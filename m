Return-Path: <linux-wireless+bounces-28261-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E29C099A4
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 18:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B2635472F1
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 16:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5FD30DD3B;
	Sat, 25 Oct 2025 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPuYHemx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C307030AAC7;
	Sat, 25 Oct 2025 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409421; cv=none; b=BSkB/Ye7ltVjZjkItChfYqz7cRDoM0ZJF3e125FVwihZO4gwiPBpLib3y96F5vCDT4aTbVUuB3LT2IiPCYwng9nfT75JXS7tlyk9NDt1pdqA3QrGjbNyKa2p+aj6AH//IT3vvgonU4rGnHeaRU943NKEVnxKx5C69F8E6+rxOGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409421; c=relaxed/simple;
	bh=z10t3tUUlPF6mTtW0oTS0T6Brg0Lk6xgAcgBNsRe9W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1aCcQoA5Jpllv6HAGcsJN38442j89prJ7+4Yy167k3xyqA8eWSjR+5nzSimU9VrThqEce+Z3nYAH47rYFSVXJWDE3O18OoVMbSz1WYxkqZOTYyRhuxa1roIpmQNfr3RVoNmFRnflUS8TJus0muFDcGlCfUilcsp16UIGcyhTdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPuYHemx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF446C4CEFF;
	Sat, 25 Oct 2025 16:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409421;
	bh=z10t3tUUlPF6mTtW0oTS0T6Brg0Lk6xgAcgBNsRe9W4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JPuYHemxAb0rYe9vDxfm0sAwsvI1jLI4Pk1ZqHsu7a3dTKleab9B8kY6vecn5jZSH
	 CKZWDMZvalwj0gGVv7Mm2dCAgTD3LaR09ayCyFP27mO+iyAKTIarTPRSMQXR9FnLrO
	 I0+aKiUAwhQcCno38cNM0Y2P16v4U1T/ML75SP2K+rJlmOm9015d8mi89exakoBQ6p
	 03Ib+ofs/Mh1WPEOsuEBKtaVdgW5HC43WPJr68wkpyeQVgX82nK4w4Lb10UbElx9iR
	 Kr9Mk8FLjw9Z0BsTuC6vhvJMgG9x2sMlxtLxG4dCnNi2wTnyLVWBXkz2FZOwJtu4zj
	 0cwHhqwUUCJVg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] wifi: cfg80211: update the time stamps in hidden ssid
Date: Sat, 25 Oct 2025 11:59:09 -0400
Message-ID: <20251025160905.3857885-318-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit 185cc2352cb1ef2178fe4e9a220a73c94007b8bb ]

In hidden SSID we have separate BSS entries for the beacon and for the
probe response(s).
The BSS entry time stamps represent the age of the BSS;
when was the last time we heard the BSS.
When we receive a beacon of a hidden SSID it means that we heard that
BSS, so it makes sense to indicate that in the probe response entries.
Do that.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250907115135.712745e498c0.I38186abf5d20dec6f6f2d42d2e1cdb50c6bfea25@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

Explanation
- Fixes a real bug: For hidden SSIDs cfg80211 keeps separate BSS entries
  for the beacon and probe response(s) (see doc comment in
  net/wireless/scan.c:39). Previously, when only a beacon was received,
  the probe-response BSS entries’ timestamps were not refreshed, making
  them appear stale/expired despite the AP being heard.
- Precise change: When updating a hidden-SSID group due to a beacon, the
  patch propagates the current time to all sub-entries:
  - net/wireless/scan.c:1820 sets `bss->ts = known->ts`
  - net/wireless/scan.c:1821 sets `bss->pub.ts_boottime =
    known->pub.ts_boottime`
- Correct update ordering: Timestamps for the “known” BSS are updated at
  the start of the update function so the propagated values are current
  and also updated even if an early-return path is taken:
  - net/wireless/scan.c:1889 updates `known->ts`
  - net/wireless/scan.c:1890 updates `known->pub.ts_boottime`
  - Early-return case (hidden/beacon confusion) occurs at
    net/wireless/scan.c:1912 and can now still benefit from timestamp
    refresh.
- Why it matters to users: Expiration and selection logic uses `ts`;
  stale `ts` causes hidden SSID probe-response entries to be treated as
  expired:
  - Expire processing uses `ts` (net/wireless/scan.c:479)
  - get_bss filters out expired entries with `ts +
    IEEE80211_SCAN_RESULT_EXPIRE` (net/wireless/scan.c:1634)
  - Userspace also consumes `ts_boottime` via
    NL80211_BSS_LAST_SEEN_BOOTTIME (net/wireless/nl80211.c:11573), so
    keeping it accurate improves reporting.
- Small and contained: The patch touches only net/wireless/scan.c and
  adds 7 lines + minor reordering; no API or architectural changes.
- Behaviorally safe: The new behavior aligns with the documented hidden-
  SSID grouping, i.e., hearing any frame (beacon) from the AP indicates
  the BSS is alive for the grouped probe-response entries
  (net/wireless/scan.c:39). If beacons stop, timestamps still age and
  entries expire as before.
- Minimal regression risk: Only timestamp bookkeeping is affected. No
  changes to element parsing, channel handling, or RCU lifetimes;
  updates occur under `bss_lock` and mirror existing direct-field
  updates elsewhere in scan.c.
- Stable criteria fit:
  - Important bugfix: avoids hidden SSID entries being incorrectly aged
    out, impacting discoverability/connectivity.
  - Small, localized change with clear intent and low risk.
  - No new features or architectural changes.
  - Applies to a common subsystem (cfg80211) with wide user impact.

Conclusion: This is a straightforward correctness fix for hidden-SSID
handling and should be backported to stable.

 net/wireless/scan.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 6c7b7c3828a41..90a9187a6b135 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1816,6 +1816,9 @@ static void cfg80211_update_hidden_bsses(struct cfg80211_internal_bss *known,
 		WARN_ON(ies != old_ies);
 
 		rcu_assign_pointer(bss->pub.beacon_ies, new_ies);
+
+		bss->ts = known->ts;
+		bss->pub.ts_boottime = known->pub.ts_boottime;
 	}
 }
 
@@ -1882,6 +1885,10 @@ cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 {
 	lockdep_assert_held(&rdev->bss_lock);
 
+	/* Update time stamps */
+	known->ts = new->ts;
+	known->pub.ts_boottime = new->pub.ts_boottime;
+
 	/* Update IEs */
 	if (rcu_access_pointer(new->pub.proberesp_ies)) {
 		const struct cfg80211_bss_ies *old;
@@ -1945,8 +1952,6 @@ cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 	if (signal_valid)
 		known->pub.signal = new->pub.signal;
 	known->pub.capability = new->pub.capability;
-	known->ts = new->ts;
-	known->pub.ts_boottime = new->pub.ts_boottime;
 	known->parent_tsf = new->parent_tsf;
 	known->pub.chains = new->pub.chains;
 	memcpy(known->pub.chain_signal, new->pub.chain_signal,
-- 
2.51.0


