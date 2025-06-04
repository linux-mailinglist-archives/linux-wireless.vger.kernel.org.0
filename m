Return-Path: <linux-wireless+bounces-23628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D27ACD2E8
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19074177FF8
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 01:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A2725C83A;
	Wed,  4 Jun 2025 00:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUNJG6Q8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A40E1F4162;
	Wed,  4 Jun 2025 00:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998793; cv=none; b=TWv5ee4QViCLnUZeSdUd2zlCgrDlsbWQIw2i6Hvk2ysBQcbEbXZyOQMAHdIR+dXP3WqFz1LVAMyF8LLWp9k8pf8+wkLkKNdT3dK2SoMFsPo9k8Gqd5TnA+GEw4tBrcmLXO7x6cgsfFj7b8zx/BvZlvA6IYb9e4cShimFFYknfkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998793; c=relaxed/simple;
	bh=A29diI843ilzsY3cqrhl3K0AAgwjljsKvnSWwWjH7H4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2OxDxhiSdcnb9EIsw0VJuyi5qM+6btfPMMta5cCEFJlJlh7fExMviXhhg2dW77oLHopRzpjZ96Oure+k76WYJYgRC5qUEklMBab7hfS07tLZVicpjKHnn0c+WyO2Rz5HTMCqSa4paZrvOr0NgSGVQK3N8fz6bLCPtwNhQcivvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUNJG6Q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D0FC4CEEF;
	Wed,  4 Jun 2025 00:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998793;
	bh=A29diI843ilzsY3cqrhl3K0AAgwjljsKvnSWwWjH7H4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MUNJG6Q8VYAys/8Qmk8HwmxWnBYah20OXmOWJCoVKxwOTglD5Of+7YAyK9l/XSujA
	 SRC7Any4l68eVTCXFwQJQFVS1bL/873dXZQ/zwLJjI7miiu42AzBkagwd08LsaDIix
	 X5QRdmVBiTKyujN+Or0hCqP+TJPpllWL5dOgiSSTOfW67ze8ipa9pTAgff9+WQwDFD
	 muFKpLZttHUBh2lvGmZDN5E//KYVVlmNWpy8Y09oiuWz3IRwnxjtu29FcAbvO/Vgry
	 7GBmhrftF0esH4AggDe09AmARZuN23tcW4fspPBnV9B4SVTuFPUC7YC19TDhOFm3bY
	 ugB8IPyHcoAYg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 15/93] wifi: mac80211: validate SCAN_FLAG_AP in scan request during MLO
Date: Tue,  3 Jun 2025 20:58:01 -0400
Message-Id: <20250604005919.4191884-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005919.4191884-1-sashal@kernel.org>
References: <20250604005919.4191884-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.31
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

[ Upstream commit 78a7a126dc5b8e3c5a3d4da9f513e0236d2dc1a3 ]

When an AP interface is already beaconing, a subsequent scan is not allowed
unless the user space explicitly sets the flag NL80211_SCAN_FLAG_AP in the
scan request. If this flag is not set, the scan request will be returned
with the error code -EOPNOTSUPP. However, this restriction currently
applies only to non-ML interfaces. For ML interfaces, scans are allowed
without this flag being explicitly set by the user space which is wrong.
This is because the beaconing check currently uses only the deflink, which
does not get set during MLO.

Hence to fix this, during MLO, use the existing helper
ieee80211_num_beaconing_links() to know if any of the link is beaconing.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Link: https://patch.msgid.link/20250516-bug_fix_mlo_scan-v2-1-12e59d9110ac@oss.qualcomm.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis, here is my decision: **YES** This commit should be
backported to stable kernel trees for the following reasons: ## Security
and Functional Bug Analysis 1. **Clear Security/Behavioral Bug**: This
commit fixes a significant security validation bypass in MLO (Multi-Link
Operation) mode. The bug allows AP interfaces in MLO mode to perform
scans without the required `NL80211_SCAN_FLAG_AP` flag, which bypasses
an important protection mechanism. 2. **Root Cause**: The issue stems
from line 2927 in `net/mac80211/cfg.c` where the code was checking
`sdata->deflink.u.ap.beacon` instead of using
`ieee80211_num_beaconing_links(sdata)`. In MLO mode, `deflink` doesn't
get properly set, so the beaconing check fails and scans are incorrectly
allowed without proper authorization. 3. **Impact Scope**: - The bug
affects all kernels with MLO support (since v6.0) where
`ieee80211_num_beaconing_links()` is available (since v6.10) - MLO was
introduced in kernel v6.0, but the helper function was only added in
v6.10 - This means kernels v6.10+ with MLO support have this
vulnerability ## Code Change Analysis The fix is minimal and surgical:
```c // Before: if (sdata->deflink.u.ap.beacon && // After: if
(ieee80211_num_beaconing_links(sdata) && ``` This change: - Replaces a
deflink-specific check with a MLO-aware function - The
`ieee80211_num_beaconing_links()` function properly iterates through all
links in MLO mode and checks for beaconing on any link - In non-MLO
mode, it still works correctly (after commit 68b44b05f4c8) - Is
contained, with no side effects beyond fixing the intended issue ##
Stable Tree Criteria Met 1. **Important Bug Fix**: ✅ Fixes security
validation bypass 2. **Small and Contained**: ✅ Single line change 3.
**No Architectural Changes**: ✅ Uses existing helper function 4.
**Minimal Regression Risk**: ✅ The change makes the validation more
strict, not less 5. **Clear Affects Users**: ✅ Any MLO AP deployment is
affected ## Historical Context Looking at the similar commits provided,
this follows the pattern of "Backport Status: YES" from commit #5, which
was also a small fix for MLO address translation issues that could break
functionality. ## Recommendation This should be backported to stable
trees that have both: - MLO support (v6.0+) - The
`ieee80211_num_beaconing_links()` helper function (v6.10+) The backport
target should be **v6.10+** stable trees.

 net/mac80211/cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f11fd360b422d..cf2b8a05c3389 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2876,7 +2876,7 @@ static int ieee80211_scan(struct wiphy *wiphy,
 		 * the frames sent while scanning on other channel will be
 		 * lost)
 		 */
-		if (sdata->deflink.u.ap.beacon &&
+		if (ieee80211_num_beaconing_links(sdata) &&
 		    (!(wiphy->features & NL80211_FEATURE_AP_SCAN) ||
 		     !(req->flags & NL80211_SCAN_FLAG_AP)))
 			return -EOPNOTSUPP;
-- 
2.39.5


