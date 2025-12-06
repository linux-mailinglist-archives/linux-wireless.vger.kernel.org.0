Return-Path: <linux-wireless+bounces-29555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBE0CAA7EF
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Dec 2025 15:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A833B31BC993
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Dec 2025 14:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F3F2FF153;
	Sat,  6 Dec 2025 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSJqw7C9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4024B2FE59A;
	Sat,  6 Dec 2025 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765029796; cv=none; b=P7uxNk0Fb3rYdwlHOYF8El+en9Gp185pIGD6xqAKKhxXdE/zexSdUg4zA3lE1d7+rCqaMDBTHPWLTLZiJx10VD1+4QiagkDeewnKysPz66j9fHJfWtHI6S4bhDi77a7yh56KbySqnluHuvzQN9rGSy2iNq9GhrM0D+eTLc/usDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765029796; c=relaxed/simple;
	bh=fRKZRaHkp8aMg8Nr3JzmFLHVN7MSCkbgKjCqGU+7OEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CndDP4j7odrvkmEKwLemNp8QgAwX0SQngWd4DYy6GjDCbCz9owQ5Wl0F5lSInvlP9IDzIPkXaOzvE2O1B6B6vkGTxL9iLAIRcSEllD/10NglAnsShKlUdxOtMaLomCeq4cdCwW1C5e5NcVx2Avbo2vhDyMotAhHpmLYcol5yd8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSJqw7C9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC77C4CEF5;
	Sat,  6 Dec 2025 14:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765029796;
	bh=fRKZRaHkp8aMg8Nr3JzmFLHVN7MSCkbgKjCqGU+7OEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gSJqw7C9laszPiLKamkwjmy6QIRZ4oELO7ewIO1KP6EnvG4q2Lpuqh2oT6tjms9tI
	 aBxxDpsFw3FR5PgFqoXD/WQnTninkN03+4cnqsqKMK0Nl0iuPR3bqNzyCpu+tH54O9
	 M5pbX7/ZVHlyeFqvsW8TKJXEiFhjqmfEh+GkMBu0sQyprHAIDQ39Y8N23ho/BFasqJ
	 ZT+/BdriVgvFB0k8aQZtphGMLgH5zvVTyxUquXMyzgv4/StndfxKU670P3xAVSqi8l
	 YiT7ZHEjtopwU1+3RE8QMJhUoGgCgN+3f8mVr6P3o9qSkucxATEkoucG7lp+xuvXoy
	 6da3obmFbyMsw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.12] wifi: cfg80211: use cfg80211_leave() in iftype change
Date: Sat,  6 Dec 2025 09:02:16 -0500
Message-ID: <20251206140252.645973-11-sashal@kernel.org>
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

[ Upstream commit 7a27b73943a70ee226fa125327101fb18e94701d ]

When changing the interface type, all activity on the interface has
to be stopped first. This was done independent of existing code in
cfg80211_leave(), so didn't handle e.g. background radar detection.
Use cfg80211_leave() to handle it the same way.

Note that cfg80211_leave() behaves slightly differently for IBSS in
wireless extensions, it won't send an event in that case. We could
handle that, but since nl80211 was used to change the type, IBSS is
rare, and wext is already a corner case, it doesn't seem worth it.

Link: https://patch.msgid.link/20251121174021.922ef48ce007.I970c8514252ef8a864a7fbdab9591b71031dee03@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## 2. CODE CHANGE ANALYSIS

Looking at the diff and comparing with `cfg80211_leave()`:

**Original inline switch did:**
- AP/P2P_GO: `cfg80211_stop_ap()`
- ADHOC: `cfg80211_leave_ibss(rdev, dev, false)` - note the `false`
  parameter
- STATION/P2P_CLIENT: `cfg80211_disconnect()`
- MESH_POINT: **nothing** (just a comment "mesh should be handled?")
- OCB: `cfg80211_leave_ocb()`

**`cfg80211_leave()` additionally does:**
1. `cfg80211_pmsr_wdev_down(wdev)` - **new cleanup**
2. `cfg80211_stop_background_radar_detection(wdev)` - **mentioned bug
   fix**
3. For ADHOC: uses `true` instead of `false` (changes wext event
   behavior)
4. For STATION/P2P_CLIENT: stops scheduled scans + wext cleanup
5. For MESH_POINT: `cfg80211_leave_mesh()` - **fixes the TODO bug**

## 3. CLASSIFICATION

This is primarily a **code refactoring/consolidation** that:
- Fixes bugs: background radar detection not stopped, MESH_POINT not
  handled
- Changes behavior: IBSS wext event, additional scheduled scan cleanup,
  pmsr cleanup
- The author explicitly acknowledges behavioral differences but
  considers them "not worth" fixing

## 4. SCOPE AND RISK ASSESSMENT

- **Lines:** Removes ~20 lines, replaces with single function call (net
  negative)
- **Files:** 1 file (net/wireless/util.c)
- **Risk:** Medium - introduces behavioral changes beyond the stated bug
  fixes

The behavioral differences acknowledged by the author are concerning for
stable:
- IBSS with wext will behave differently (no event sent)
- Additional cleanup operations are now performed

## 5. USER IMPACT

The bugs fixed (background radar detection, mesh point handling) are
real but:
- Not crashes or security issues
- More like "incomplete state cleanup" issues
- Impact is limited to users changing interface types

## 6. STABILITY INDICATORS

**Missing stable signals:**
- No `Cc: stable@vger.kernel.org` tag
- No `Fixes:` tag pointing to when bug was introduced
- Author explicitly noted behavioral differences but chose not to
  address them

## 7. DEPENDENCY CHECK

The change depends on `cfg80211_leave()` having the current
implementation with all the necessary handlers.

## Summary

While this commit does fix real issues (background radar detection not
stopped, MESH_POINT not handled), it's fundamentally a **code
consolidation** that:

1. **Introduces behavioral changes** beyond the bug fixes (IBSS wext
   events, additional cleanup operations)
2. **Lacks explicit stable request** from the maintainer (Johannes Berg)
3. **Author acknowledged** behavioral differences but chose not to fix
   them
4. The bugs fixed are **not crashes, security issues, or data
   corruption** - they're incomplete state cleanup issues

The maintainer deliberately did not add a `Cc: stable` or `Fixes:` tag,
suggesting this wasn't intended for backporting. The behavioral changes
(IBSS wext, scheduled scan cleanup, pmsr cleanup) go beyond the stated
bug fixes and could introduce unexpected regressions in stable trees.

This is code cleanup/improvement material, not targeted stable-critical
bug fix material.

**NO**

 net/wireless/util.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 56724b33af045..4eb028ad16836 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1203,28 +1203,7 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 		dev->ieee80211_ptr->use_4addr = false;
 		rdev_set_qos_map(rdev, dev, NULL);
 
-		switch (otype) {
-		case NL80211_IFTYPE_AP:
-		case NL80211_IFTYPE_P2P_GO:
-			cfg80211_stop_ap(rdev, dev, -1, true);
-			break;
-		case NL80211_IFTYPE_ADHOC:
-			cfg80211_leave_ibss(rdev, dev, false);
-			break;
-		case NL80211_IFTYPE_STATION:
-		case NL80211_IFTYPE_P2P_CLIENT:
-			cfg80211_disconnect(rdev, dev,
-					    WLAN_REASON_DEAUTH_LEAVING, true);
-			break;
-		case NL80211_IFTYPE_MESH_POINT:
-			/* mesh should be handled? */
-			break;
-		case NL80211_IFTYPE_OCB:
-			cfg80211_leave_ocb(rdev, dev);
-			break;
-		default:
-			break;
-		}
+		cfg80211_leave(rdev, dev->ieee80211_ptr);
 
 		cfg80211_process_rdev_events(rdev);
 		cfg80211_mlme_purge_registrations(dev->ieee80211_ptr);
-- 
2.51.0


