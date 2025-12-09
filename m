Return-Path: <linux-wireless+bounces-29606-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74476CAE782
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Dec 2025 01:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7DBC301EFF1
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Dec 2025 00:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D48F21B9C0;
	Tue,  9 Dec 2025 00:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuyPzK+6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318EE2153FB;
	Tue,  9 Dec 2025 00:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765239413; cv=none; b=TClSJnlONc4KGclrutW8HslcQg/G3frAxT3xak5khZR4+QoARYMXt2swZTevXUCldPNgeJe5jJxsRishNnixK6nKFKe14055S4BBUTKHMun25FQzc4OipY4sEhgzu27ZIdgcKcvzhzm3IUS5q/Kxq3kgSJ7p8vMinRuNgA8jY8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765239413; c=relaxed/simple;
	bh=QPRP10VucOT7diTQb7MQ7N+PgDBlIwD51s7XelWZoGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=di+uV+nm75Y23nIa1caxBFQiEq+0OqEUtVfTqqkf8LBCuzc2ToZfhJEhm9Kn87vseEH5B1O9G7uUzPyj9YUWLYsMBAMyJhs5HWdmovQoYtjON/EeGWi4xSNMCrUoYOc90ya9WgGX987d4RJ3NKiOqepUj5zdoqUM/SYTHrTms2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuyPzK+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43D7C19421;
	Tue,  9 Dec 2025 00:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765239413;
	bh=QPRP10VucOT7diTQb7MQ7N+PgDBlIwD51s7XelWZoGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nuyPzK+6aqOKF5XAjX1uf10V2q162IiOCtxncUw5cBOSOm4AHkHwVomi8NY2YWq+Y
	 y5cEyTFkf5vts90LRpHHQxf5tfHFKbq2/r9PX+mKXdXkYcCfLm/Q3rdNnPJKQrnd0F
	 bERjhZDhnl9dnGUMBrHJ1psh0byAuMHV1mj179cxyEkizluEtRrxp/5DRf3Dj7AuM3
	 /F0rhwknjdeiP5BvhEyKWPvIGkONvMHjdIEupvnCNyzn4sRdi1gHckUW2gvQSQOdXF
	 cEcIzppqehU2ggjkieXpPuFEJP99NBYSzcwbE33iVVDIrH9mh3JgC2T58/+LXxHywP
	 c//bqYZeEKEiw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.12] wifi: mac80211: reset CRC valid after CSA
Date: Mon,  8 Dec 2025 19:15:02 -0500
Message-ID: <20251209001610.611575-10-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209001610.611575-1-sashal@kernel.org>
References: <20251209001610.611575-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 8f24be708829854560e1db9f765c51305b046183 ]

While waiting for a beacon after CSA, reset the CRC valid
so that the next beacon is handled even if it happens to
be identical the last one on the old channel. This is an
AP bug either way, but it's better to disconnect cleanly
than to have lingering CSA state.

In the iwlwifi instantiation of this problem, mac80211 is
ignoring the beacon but the firmware creates a new CSA,
and then crashes later because mac80211/driver didn't do
anything about it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20251019115024.521ad9c6b87d.I86376900df3d3423185b75bf63358c29f33a5eb6@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I understand the full picture! Let me put together the final
analysis:

## Summary Analysis

### 1. COMMIT MESSAGE ANALYSIS

**Subject:** "wifi: mac80211: reset CRC valid after CSA"

**Key points from commit message:**
- Fixes a bug where the beacon CRC matching causes the first beacon
  after CSA to be ignored
- This happens when an AP (like Asus AXE11000) sends an identical beacon
  after CSA
- When ignored, mac80211 doesn't complete the CSA cleanup properly
- In iwlwifi, this causes firmware to create a new CSA and eventually
  crash

**Tags:**
- **NO** `Cc: stable@vger.kernel.org` tag - The maintainer did NOT
  explicitly request stable backport
- **NO** `Fixes:` tag - There's no explicit reference to a buggy commit

### 2. CODE CHANGE ANALYSIS

The fix is extremely small - just **1 line of actual code** plus a
**9-line comment**:

```c
link->u.mgd.beacon_crc_valid = false;
```

This line is added at line 2509 in `ieee80211_csa_switch_work()`, right
after:
```c
link->u.mgd.csa.waiting_bcn = true;
```

**Technical mechanism:**
1. mac80211 uses a CRC mechanism to skip processing beacons that haven't
   changed
2. After CSA, the code sets `waiting_bcn = true` to wait for the first
   beacon on the new channel
3. The first beacon should normally be different (CSA IE removed), but
   some buggy APs send identical beacons
4. If the beacon CRC matches the last beacon on the old channel and
   `beacon_crc_valid` is still true, mac80211 skips processing
5. This leaves the CSA in a "waiting" state indefinitely
6. The iwlwifi firmware sees the beacon, detects CSA state, and creates
   a new CSA event, eventually crashing

**Root cause:** The `beacon_crc_valid` flag wasn't reset when entering
the CSA waiting state.

### 3. HISTORICAL CONTEXT

This is a **regression fix** from commit `f3dee30c6791e` "wifi:
mac80211: mlme: unify CSA handling" (introduced in v6.9):
- That commit removed `beacon_crc_valid = false` from
  `ieee80211_chswitch_post_beacon()`
- The rationale was "the CRC will change due to CSA/ECSA elements"
- But this assumption was wrong for some buggy APs

The original fix `d6843d1ee2831` "mac80211: clear the beacon's CRC after
channel switch" (2021) recognized this need but was in a different
location in the old code structure.

### 4. CLASSIFICATION

- **Type:** Bug fix (not a feature)
- **Category:** Crash fix / firmware hang fix
- **Exception categories:** None (this is a pure bug fix)
- **Security:** No CVE mentioned, not a security issue

### 5. SCOPE AND RISK ASSESSMENT

- **Lines changed:** ~10 lines (1 functional, 9 comment)
- **Files touched:** 1 (net/mac80211/mlme.c)
- **Complexity:** Very low - single boolean assignment
- **Risk:** Very low - the change is conservative (invalidating CRC
  forces re-processing)
- **Worst case if fix is wrong:** Slightly more beacon processing work
  (negligible)
- **Subsystem:** WiFi mac80211 - mature, well-tested

### 6. USER IMPACT

- **Who is affected:** Users with Intel WiFi (iwlwifi) connecting to
  certain APs (like Asus AXE11000)
- **Severity:** HIGH - causes firmware crash
- **Reproducibility:** Specific AP behavior needed, but real-world bug
- **Trigger:** CSA (Channel Switch Announcement) - common in enterprise
  environments

### 7. STABILITY INDICATORS

- **Tested-by:** Not present
- **Reviewed-by:** Emmanuel Grumbach (Intel WiFi maintainer) ✓
- **Author:** Johannes Berg (mac80211 maintainer) - highly trusted
- **Time in mainline:** Recent (Oct 2025) - not much soak time

### 8. DEPENDENCY CHECK

**CRITICAL:** This fix requires commit `f3dee30c6791e` "wifi: mac80211:
mlme: unify CSA handling" which:
- Is present in v6.9+
- Is present in stable/linux-6.9.y, 6.10.y, 6.11.y, 6.12.y, etc.
- Is **NOT** present in stable/linux-6.6.y (LTS) or stable/linux-6.1.y
  (LTS)

For older stable trees (6.6.y, 6.1.y), this fix doesn't apply because:
1. The code structure is completely different
2. The original `beacon_crc_valid = false` is still in
   `ieee80211_chswitch_post_beacon()`
3. The bug was introduced by `f3dee30c6791e` which isn't in those trees

### VERDICT

**Arguments FOR backporting:**
1. Fixes a real firmware crash that affects users
2. Small, surgical fix - single line of actual code
3. Low risk - conservative change (invalidating CRC is safe)
4. Written by mac80211 maintainer, reviewed by iwlwifi maintainer
5. Fixes a regression from `f3dee30c6791e`

**Arguments AGAINST backporting:**
1. No `Cc: stable` tag - maintainer didn't request it
2. No `Fixes:` tag
3. Only applies to kernels 6.9+ (those with the prerequisite commit)
4. Relatively new commit (limited soak time)
5. Requires specific buggy AP to trigger

**Risk vs Benefit:**
- Risk: Very low (trivial change, conservative behavior)
- Benefit: Medium-high (prevents firmware crashes for users with
  affected APs)

The commit fixes a real crash scenario in iwlwifi with certain APs, is
extremely small and low-risk, and was reviewed by the relevant
maintainers. The lack of `Cc: stable` tag might be an oversight given
the fix's nature. However, it only applies to kernels 6.9+ where the
prerequisite CSA refactoring exists.

For stable trees 6.9+, 6.10+, 6.11+, 6.12+, this should be backported as
it fixes a real user-visible crash with very low risk.

**YES**

 net/mac80211/mlme.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f3138d1585353..a231e8661e39d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2508,6 +2508,16 @@ static void ieee80211_csa_switch_work(struct wiphy *wiphy,
 
 	link->u.mgd.csa.waiting_bcn = true;
 
+	/*
+	 * The next beacon really should always be different, so this should
+	 * have no effect whatsoever. However, some APs (we observed this in
+	 * an Asus AXE11000), the beacon after the CSA might be identical to
+	 * the last beacon on the old channel - in this case we'd ignore it.
+	 * Resetting the CRC will lead us to handle it better (albeit with a
+	 * disconnect, but clearly the AP is broken.)
+	 */
+	link->u.mgd.beacon_crc_valid = false;
+
 	/* apply new TPE restrictions immediately on the new channel */
 	if (link->u.mgd.csa.ap_chandef.chan->band == NL80211_BAND_6GHZ &&
 	    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_HE) {
-- 
2.51.0


