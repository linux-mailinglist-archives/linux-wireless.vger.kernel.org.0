Return-Path: <linux-wireless+bounces-29556-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FC2CAA825
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Dec 2025 15:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6827C30BAD46
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Dec 2025 14:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D86D2FE573;
	Sat,  6 Dec 2025 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/1IPNcC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435F92FE56B;
	Sat,  6 Dec 2025 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765029832; cv=none; b=GCO6pbggUPlOgwXxGQquoVkCFT4wA32Tfk3+K6k3RT6DaX6LUVi/iuOjp29l/qBzd10pM74lyiWdlKTEhUYzivNwEjW2z1yk6Dahb+sGIYRq3C8T3xbVIjkc2StT3Zdi8f8Rnf6dlAY/S4zlSdq53MYelkBZUbaCHMsDt3MShAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765029832; c=relaxed/simple;
	bh=EiKt/ZDPWmg3g7Z7DO4WMYfttGaNdqNZbbYR7m5egzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DeVGJGOmYQm20pUQdLMwxS5xRm0thQCRTMUl/cy+76FAY2sCwKIcBgxr3IDjzUesru/07d0xjAlNGaKK1lMS0tgKXivdo2DsUEYgfdWZKiOB6hHMTBki51jUIy7MkLn8ruQKTqeJQkDZsaYx+R1BRVwKEBqqunYwc45w304yXWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/1IPNcC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AEFC113D0;
	Sat,  6 Dec 2025 14:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765029832;
	bh=EiKt/ZDPWmg3g7Z7DO4WMYfttGaNdqNZbbYR7m5egzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b/1IPNcCHCIotYdcYPDXkX2+vtJDlDMaK2zBth5zo6NX417xxLlkMcjLRva1mMQTU
	 u4ioHMh0aExpCpkaGaFEmmA+p4EdRgqJtCe80fIll0ckZs2dXa4uIBWSfcQSxNgE6+
	 mlU9AcBTZ1ylE94MXFFxOPG1QWJUktIthlWSgp1R/TDWiwpkdgdmSrWKGCD/v+qRCm
	 /LQ7DHfwiGfQPQEzOBvftDBNZgchBxKgIiPJEcsPls3xrsx7XDtnLw2jY+/ziuUZkS
	 VmZQALd6ZOrYcqASJMl8qii92n87QKZt+1cMfDXfohiAm0fKJNCGE+HHpL2tlmpIdl
	 KFxPIynUGWVvA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.12] wifi: cfg80211: stop radar detection in cfg80211_leave()
Date: Sat,  6 Dec 2025 09:02:31 -0500
Message-ID: <20251206140252.645973-26-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251206140252.645973-1-sashal@kernel.org>
References: <20251206140252.645973-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 9f33477b9a31a1edfe2df9f1a0359cccb0e16b4c ]

If an interface is set down or, per the previous patch, changes
type, radar detection for it should be cancelled. This is done
for AP mode in mac80211 (somewhat needlessly, since cfg80211 can
do it, but didn't until now), but wasn't handled for mesh, so if
radar detection was started and then the interface set down or
its type switched (the latter sometimes happning in the hwsim
test 'mesh_peer_connected_dfs'), radar detection would be around
with the interface unknown to the driver, later leading to some
warnings around chanctx usage.

Link: https://patch.msgid.link/20251121174021.290120e419e3.I2a5650c9062e29c988992dd8ce0d8eb570d23267@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Summary and Analysis

### What the Bug Fixes
This commit fixes a cleanup issue where radar detection (DFS CAC) was
not properly stopped when a mesh interface was brought down or changed
type. This left residual radar detection state that caused warnings
about chanctx (channel context) usage, since the driver thought radar
detection was still active for an interface that no longer existed.

### Technical Details
The fix:
1. Adds a new `cfg80211_stop_radar_detection()` function in `mlme.c`
   that iterates through all valid links, ends CAC via `rdev_end_cac()`,
   and sends `NL80211_RADAR_CAC_ABORTED` notification
2. Calls this new function in `cfg80211_leave()` (the cleanup path when
   interfaces go down)

### Critical Dependencies
The code uses **per-link DFS infrastructure** that was introduced in:
- **Commit 62c16f219a73c** ("wifi: cfg80211: move DFS related members to
  links[] in wireless_dev") - September 2024, **first in v6.12**

This commit accesses `wdev->links[link_id].cac_started` - this structure
only exists in 6.12+. In older kernels (6.11 and earlier), `cac_started`
was a simple top-level member of `wireless_dev`, not per-link.

### Stable Backport Assessment

**Against backporting:**
1. **No `Cc: stable@vger.kernel.org`** - The maintainer (Johannes Berg)
   did not request stable backporting
2. **No `Fixes:` tag** - No specific commit is identified as introducing
   the bug
3. **Dependencies on recent code** - The per-link DFS infrastructure
   only exists in kernel 6.12+
4. **Cannot apply to LTS trees** - Would require substantial rework for
   6.6.y, 6.1.y, 5.15.y, etc.
5. **Not critical severity** - The bug causes kernel warnings, not
   crashes, security issues, or data corruption
6. **Niche use case** - Mesh networking combined with DFS channels is
   relatively uncommon
7. **Very new feature** - The affected MLO/per-link DFS code is only one
   release old

**Supporting backporting:**
- Does fix a real bug that causes warnings
- Small, localized change (~25 lines)
- From a known/trusted maintainer

### Conclusion

This commit fixes a legitimate bug but does **not** meet stable kernel
criteria:
- The maintainer did not request stable backporting
- The affected code only exists in kernel 6.12+, making it only relevant
  to the most recent stable branch if any
- The bug severity (warnings, not crashes/corruption/security) does not
  warrant the backporting effort
- It cannot be cleanly applied to most stable trees due to structural
  code differences

**NO**

 net/wireless/core.c |  1 +
 net/wireless/core.h |  1 +
 net/wireless/mlme.c | 19 +++++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 54a34d8d356e0..5e5c1bc380a89 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1365,6 +1365,7 @@ void cfg80211_leave(struct cfg80211_registered_device *rdev,
 
 	cfg80211_pmsr_wdev_down(wdev);
 
+	cfg80211_stop_radar_detection(wdev);
 	cfg80211_stop_background_radar_detection(wdev);
 
 	switch (wdev->iftype) {
diff --git a/net/wireless/core.h b/net/wireless/core.h
index b6bd7f4d6385a..d5d78752227af 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -489,6 +489,7 @@ cfg80211_start_background_radar_detection(struct cfg80211_registered_device *rde
 					  struct wireless_dev *wdev,
 					  struct cfg80211_chan_def *chandef);
 
+void cfg80211_stop_radar_detection(struct wireless_dev *wdev);
 void cfg80211_stop_background_radar_detection(struct wireless_dev *wdev);
 
 void cfg80211_background_cac_done_wk(struct work_struct *work);
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 46394eb2086f6..3fc175f9f8686 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -1295,6 +1295,25 @@ cfg80211_start_background_radar_detection(struct cfg80211_registered_device *rde
 	return 0;
 }
 
+void cfg80211_stop_radar_detection(struct wireless_dev *wdev)
+{
+	struct wiphy *wiphy = wdev->wiphy;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	int link_id;
+
+	for_each_valid_link(wdev, link_id) {
+		struct cfg80211_chan_def chandef;
+
+		if (!wdev->links[link_id].cac_started)
+			continue;
+
+		chandef = *wdev_chandef(wdev, link_id);
+		rdev_end_cac(rdev, wdev->netdev, link_id);
+		nl80211_radar_notify(rdev, &chandef, NL80211_RADAR_CAC_ABORTED,
+				     wdev->netdev, GFP_KERNEL);
+	}
+}
+
 void cfg80211_stop_background_radar_detection(struct wireless_dev *wdev)
 {
 	struct wiphy *wiphy = wdev->wiphy;
-- 
2.51.0


