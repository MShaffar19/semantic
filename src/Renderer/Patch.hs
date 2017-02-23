import qualified Data.Text as Text
import qualified Source
import Source hiding (break, length, null)
truncatePatch _ blobs = header blobs <> "#timed_out\nTruncating diff: timeout reached.\n"
patch blobs diff = PatchOutput $ if not (Text.null text) && Text.last text /= '\n'
  then text <> "\n\\ No newline at end of file\n"
  else text
  where text = header blobs <> mconcat (showHunk blobs <$> hunks diff blobs)
showHunk :: Functor f => HasField fields Range => Both SourceBlob -> Hunk (SplitDiff f (Record fields)) -> Text
  mconcat (showChange sources <$> changes hunk) <>
showChange :: Functor f => HasField fields Range => Both Source -> Change (SplitDiff f (Record fields)) -> Text
showLines :: Functor f => HasField fields Range => Source -> Char -> [Maybe (SplitDiff f (Record fields))] -> Text
        prepend source = Text.singleton prefix <> source
showLine :: Functor f => HasField fields Range => Source -> Maybe (SplitDiff f (Record fields)) -> Maybe Text
showLine source line | Just line <- line = Just . toText . (`slice` source) $ getRange line
header :: Both SourceBlob -> Text
header blobs = Text.intercalate "\n" ([filepathHeader, fileModeHeader] <> maybeFilepaths) <> "\n"
          (Nothing, Just mode) -> Text.intercalate "\n" [ "new file mode " <> modeToDigits mode, blobOidHeader ]
          (Just mode, Nothing) -> Text.intercalate "\n" [ "deleted file mode " <> modeToDigits mode, blobOidHeader ]
          (Just mode1, Just mode2) -> Text.intercalate "\n" [
        modeHeader :: Text -> Maybe SourceKind -> Text -> Text
        maybeFilepaths = if (nullOid == oidA && Source.null (snd sources)) || (nullOid == oidB && Source.null (fst sources)) then [] else [ beforeFilepath, afterFilepath ]
        (pathA, pathB) = case runJoin $ toS . path <$> blobs of
              , sourcesNull <- runBothWith (&&) (Source.null <$> sources)
hunksInRows :: (Foldable f, Functor f) => Both (Sum Int) -> [Join These (SplitDiff f annotation)] -> [Hunk (SplitDiff f annotation)]
nextHunk :: (Foldable f, Functor f) => Both (Sum Int) -> [Join These (SplitDiff f annotation)] -> Maybe (Hunk (SplitDiff f annotation), [Join These (SplitDiff f annotation)])
nextChange :: (Foldable f, Functor f) => Both (Sum Int) -> [Join These (SplitDiff f annotation)] -> Maybe (Both (Sum Int), Change (SplitDiff f annotation), [Join These (SplitDiff f annotation)])
changeIncludingContext :: (Foldable f, Functor f) => [Join These (SplitDiff f annotation)] -> [Join These (SplitDiff f annotation)] -> Maybe (Change (SplitDiff f annotation), [Join These (SplitDiff f annotation)])
rowHasChanges :: (Foldable f, Functor f) => Join These (SplitDiff f annotation) -> Bool