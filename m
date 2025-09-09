Return-Path: <linux-wireless+bounces-27112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9210B49DF9
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 02:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C213D1B22A9A
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 00:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3701AE877;
	Tue,  9 Sep 2025 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHhO1T62"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0B0199237;
	Tue,  9 Sep 2025 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757377828; cv=none; b=AG6q2F2qO1jIqvaUBQ9QFT43ca4o+O+mahr9EPodqV47sxNlEWL6mEri5B8VH3gQxLugjNxEw8M/GyWBOPuLNgEUgqLZHbzNntpWJPaSkBcGUJPjPV46Tk9tgwgdGQOPi3RNDA6x2gJsIWwvspRV4yFE3+fevTdua3WsU0qp63Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757377828; c=relaxed/simple;
	bh=z3yrPgah7DfTXR3m8YBbMtyTPrtwLo8PjdKgn9pWkZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rtd863rTGTeIdI86KMeqvkrMzWR6IfEA6hXTFhlMFjLeF0Ei5MiG5qNDt6duAOwrK9xzRUylE5Jb1HszX02xE0gQ0Wc3u5NJWjphT4O72wFmHSCNcms2XVTP2JxLJinSyt+oNqSDnh58GSOd66xeiUH3t6q/T5sQ1jdGD051uOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHhO1T62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205C9C4CEF1;
	Tue,  9 Sep 2025 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757377827;
	bh=z3yrPgah7DfTXR3m8YBbMtyTPrtwLo8PjdKgn9pWkZY=;
	h=From:To:Cc:Subject:Date:From;
	b=fHhO1T62IOcqZNX2uryEiEzD9j5PS4aZiTnt/HLy1GKylN6mvhF1LWzRKDhZyPfKg
	 2xIyBSjgU/uRfBL/QJCrRLnwoLl2ugVGitL3mK9bfwQt5vp770aPX2cknaWN3+9xaJ
	 WbNBzP103z/41HyGMS8rgm/UAMG7RbDUi5kcy3fDU8gqYUgdZIUs7m81SWu1aA1Ocu
	 7IzvR3DLTQr8tve0bB5tawy3ZrhiXBIdt5/evFZ4Lh0eaVus8b94+V9gkubQddxhNq
	 4B7yj/Utbda7v7NG8ppZBZ6vDgbUuNSNKtUD/uH+3CFwqwqETw01GokkpJEpmWmhl+
	 9G7zL7zJesZRA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16-6.1] wifi: mac80211: increase scan_ies_len for S1G
Date: Mon,  8 Sep 2025 20:30:11 -0400
Message-ID: <20250909003025.2493540-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16.5
Content-Transfer-Encoding: 8bit

From: Lachlan Hodges <lachlan.hodges@morsemicro.com>

[ Upstream commit 7e2f3213e85eba00acb4cfe6d71647892d63c3a1 ]

Currently the S1G capability element is not taken into account
for the scan_ies_len, which leads to a buffer length validation
failure in ieee80211_prep_hw_scan() and subsequent WARN in
__ieee80211_start_scan(). This prevents hw scanning from functioning.
To fix ensure we accommodate for the S1G capability length.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Link: https://patch.msgid.link/20250826085437.3493-1-lachlan.hodges@morsemicro.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Perfect! Now I have all the context I need. Let me provide my analysis:

## Backport Status: **YES**

### Extensive Analysis:

**This commit fixes a real bug that causes hardware scanning to fail for
S1G (802.11ah) WiFi devices.**

#### The Bug Details:

1. **Root Cause**: When commit `0333a81bc8343` ("wifi: mac80211: S1G
   capabilities information element in probe request") was merged in
   February 2023, it added S1G capability elements to probe requests.
   However, it failed to update the buffer size calculation
   (`scan_ies_len`) to account for these additional 17 bytes (2 byte
   element header + 15 byte `struct ieee80211_s1g_cap`).

2. **Failure Mechanism**:
   - In `__ieee80211_start_scan()` at net/mac80211/scan.c:755, the
     buffer size is calculated as `local->scan_ies_len + req->ie_len`
   - When `ieee80211_prep_hw_scan()` is called at line 870, it attempts
     to build probe request IEs using `ieee80211_build_preq_ies()`
   - The function `ieee80211_build_preq_ies_band()` checks buffer space
     and adds S1G capability for S1G bands (lines 1963-1965 in util.c)
   - Without the fix, the buffer is 17 bytes too small, causing
     `-ENOBUFS` to be returned
   - This triggers the `WARN_ON(!ieee80211_prep_hw_scan(sdata))` at line
     870, producing a kernel warning and aborting the scan

3. **User Impact**:
   - Produces a visible kernel WARNING in dmesg
   - Hardware scanning completely fails for S1G devices
   - The device cannot perform network discovery
   - This is a **functional regression** introduced in kernel 6.3 (when
     commit 0333a81bc8343 was merged)

#### Why This Should Be Backported:

1. **Fixes a Real Bug**: This is not a theoretical issue - it causes
   actual hardware scanning failures with kernel warnings for any
   S1G-capable hardware.

2. **Regression Fix**: This fixes a regression introduced by commit
   0333a81bc8343 in kernel 6.3. Any stable kernel that includes that
   commit needs this fix.

3. **Small and Contained**: The fix is minimal - just 4 lines of actual
   code changes:
   - Adding `supp_s1g` boolean variable
   - Setting it based on S1G capability presence
   - Adding 17 bytes to buffer calculation when S1G is supported

4. **No Side Effects**: The change only affects S1G-capable devices and
   simply ensures adequate buffer space. It cannot negatively impact
   non-S1G devices.

5. **Clear Bug Pattern**: This is a classic "forgot to update buffer
   size calculation" bug that's straightforward to understand and
   verify.

6. **Vendor Support**: MorseMicro is actively developing S1G hardware
   and drivers, making this functionality important for emerging
   IoT/long-range WiFi deployments.

#### Stable Tree Considerations:

- Should be backported to **kernel 6.3 and later** (where commit
  0333a81bc8343 exists)
- The fix applies cleanly as it only adds to existing initialization
  code
- No dependencies on other commits
- Follows stable tree rules: fixes an important bug with minimal risk

The commit message could have been clearer by mentioning this was a
regression from commit 0333a81bc8343, but the fix itself is correct and
necessary for S1G hardware to function properly.

 net/mac80211/main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 1bad353d8a772..35c6755b817a8 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1136,7 +1136,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	int result, i;
 	enum nl80211_band band;
 	int channels, max_bitrates;
-	bool supp_ht, supp_vht, supp_he, supp_eht;
+	bool supp_ht, supp_vht, supp_he, supp_eht, supp_s1g;
 	struct cfg80211_chan_def dflt_chandef = {};
 
 	if (ieee80211_hw_check(hw, QUEUE_CONTROL) &&
@@ -1252,6 +1252,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	supp_vht = false;
 	supp_he = false;
 	supp_eht = false;
+	supp_s1g = false;
 	for (band = 0; band < NUM_NL80211_BANDS; band++) {
 		const struct ieee80211_sband_iftype_data *iftd;
 		struct ieee80211_supported_band *sband;
@@ -1299,6 +1300,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 			max_bitrates = sband->n_bitrates;
 		supp_ht = supp_ht || sband->ht_cap.ht_supported;
 		supp_vht = supp_vht || sband->vht_cap.vht_supported;
+		supp_s1g = supp_s1g || sband->s1g_cap.s1g;
 
 		for_each_sband_iftype_data(sband, i, iftd) {
 			u8 he_40_mhz_cap;
@@ -1432,6 +1434,9 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		local->scan_ies_len +=
 			2 + sizeof(struct ieee80211_vht_cap);
 
+	if (supp_s1g)
+		local->scan_ies_len += 2 + sizeof(struct ieee80211_s1g_cap);
+
 	/*
 	 * HE cap element is variable in size - set len to allow max size */
 	if (supp_he) {
-- 
2.51.0


