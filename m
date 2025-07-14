Return-Path: <linux-wireless+bounces-25414-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52211B04BB7
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 01:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219E54A776A
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 23:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B41285CA5;
	Mon, 14 Jul 2025 23:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1hro4Ps"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA1C27FB28;
	Mon, 14 Jul 2025 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752534425; cv=none; b=I400e79Ypa+PxlCkQl3FyewCxwDtEa9BpM7sOY1/ZMwp5P/fTvkdkcUl7xrPD3QfpaVNe55/+aeChLOtV5jriaq+Zd24nOlxgtXGiYtY4b7eFGGKnIYrDigxEoy2UEwUTmzEAbXnRmqXgGWEJ93zMk7VA4B5ITuNvuWm0Thiu3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752534425; c=relaxed/simple;
	bh=1x/8Ft3aSFTbS+ffIN1sVe8c8ypmlC8xA1NZxWPCfSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o4xTtx74ItVdVOpEZrAOwDEl7UGQPs/Fc3iuidBRAEum0s31Vkv2s4TIhFwKzt97HvMC4wTEhc8kUgNZLVajxAlI7dGFCJijej758RMCBgj7vr6UcVbmWwXRUL9DVJvcBpFGyi96tLqkSZIP4Zx72FwkHsyPOI7ZkocgZqwa0ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1hro4Ps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E896FC4CEF4;
	Mon, 14 Jul 2025 23:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752534424;
	bh=1x/8Ft3aSFTbS+ffIN1sVe8c8ypmlC8xA1NZxWPCfSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b1hro4PsdtNahZeqbDeGEov07wg3mIydZ9swiZbnAQt/xeFKI5jLtPglXP0CK6prc
	 qz1tk6lNUeIotG9EjL282SSEs9/pbnvcRzftF0JqcmquC8sJ7dGZO11TQ+ux30BMC6
	 lngqfraPuaAnVIkt9I3bSrK8BPHS1iNcTK8vF5ed/66f9MORY3Rxp4Hwa1NxX/jNmV
	 Ty4DAE7oWlaE6HSG93ANRTPbM5rJktxZnb+9x/i9NIx+SN/aKHZlNPhMSijBDgKjk7
	 yuQLvcQWNUoM7KxhB50q7b6stNGnOvl1p4Ji0qRrXYBYrrAKypdNlHjcHK9Mex6NgB
	 Y1zF1OVTN6gQg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 12/15] wifi: mac80211: clear frame buffer to never leak stack
Date: Mon, 14 Jul 2025 19:06:13 -0400
Message-Id: <20250714230616.3709521-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250714230616.3709521-1-sashal@kernel.org>
References: <20250714230616.3709521-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15.6
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 8af596e8ae44c3bcf36d1aea09fc9a6f17c555e5 ]

In disconnect paths paths, local frame buffers are used
to build deauthentication frames to send them over the
air and as notifications to userspace. Some internal
error paths (that, given no other bugs, cannot happen)
don't always initialize the buffers before sending them
to userspace, so in the presence of other bugs they can
leak stack content. Initialize the buffers to avoid the
possibility of this happening.

Suggested-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
Link: https://patch.msgid.link/20250701072213.13004-2-johannes@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my analysis, here is my conclusion:

**YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Security Impact**: This is a security fix that prevents potential
   leakage of stack content to userspace. The commit message explicitly
   states that "in the presence of other bugs they can leak stack
   content."

2. **Bug Fix Nature**: The commit fixes a clear bug where frame buffers
   can be used uninitialized in error paths. Looking at the code:
   - In `ieee80211_set_disassoc()`, there are three early return paths
     (lines 3936, 3939, 3942) that can exit without initializing
     `frame_buf`
   - If these error paths are taken, the caller's `frame_buf` remains
     uninitialized
   - The caller (e.g., `__ieee80211_disconnect()`) then passes this
     uninitialized buffer to `ieee80211_report_disconnect()`, which
     ultimately sends it to userspace via `cfg80211_tx_mlme_mgmt()`

3. **Minimal and Contained Fix**: The fix is extremely simple - just
   adding a `memset(frame_buf, 0, IEEE80211_DEAUTH_FRAME_LEN)` at the
   beginning of the function. This is a safe, minimal change with no
   architectural impact.

4. **Low Risk**: The change has virtually no risk of regression as it
   only initializes memory that should have been initialized anyway. It
   doesn't change any logic or behavior.

5. **Similar to Historical Backports**: This fix is similar in nature to
   the first historical commit example ("wifi: cfg80211: avoid leaking
   stack data into trace") which was marked for backporting. Both fix
   stack data leaks with simple initialization.

6. **Defensive Programming**: Even though the error paths are marked
   with WARN_ON (indicating they "cannot happen" under normal
   circumstances), the commit message acknowledges that "in the presence
   of other bugs" these paths could be triggered. This defensive
   approach is exactly what stable kernels need.

The fix meets all stable kernel criteria: it fixes an important security
issue (information leak), is minimal and contained, has low regression
risk, and doesn't introduce new features or architectural changes.

 net/mac80211/mlme.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 53d5ffad87be8..36fc496a906a1 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3933,6 +3933,9 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	if (frame_buf)
+		memset(frame_buf, 0, IEEE80211_DEAUTH_FRAME_LEN);
+
 	if (WARN_ON(!ap_sta))
 		return;
 
-- 
2.39.5


