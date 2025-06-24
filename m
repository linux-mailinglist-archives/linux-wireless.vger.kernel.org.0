Return-Path: <linux-wireless+bounces-24389-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC29CAE5B44
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 06:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA354472D4
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 04:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D74B253340;
	Tue, 24 Jun 2025 04:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiBe81Hp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DA22522B1;
	Tue, 24 Jun 2025 04:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750738388; cv=none; b=R5lOJ/OFkSNic1jrnCNnIYakIRycadU00oHYVeu3dpzGutydESoGaGbv3ru1RJq+nVGWV39/u7UWRgXkeKLuJSk9c9te32nS10AaJPij3hK96+jpTIWhGElH9PDRnjH9WIrlV9GTLG2sDEZbsOKGJ0cRt9LCuSPDY0whLT1D0UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750738388; c=relaxed/simple;
	bh=DhpiNizAsBQWDuYIGthZRs36xpI4HhNCsvYqzWKIQ4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H87Jdxk7IVtaoGMEGhK3z4KE2YYclHzTZ+5vnTkHcBDL9Lwo2ECZWxk9syDl4a890PL54c3AC484o3Ie/yaW9Qj89aY2PS9owLI7gHYvFkLY8l1s45Y7yHr+2q3JSv6Fj5JFHJC9ZJO5d3eE3gVTxCHBxrjpEwaCcIje+a3thCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiBe81Hp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0734EC4CEEF;
	Tue, 24 Jun 2025 04:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750738388;
	bh=DhpiNizAsBQWDuYIGthZRs36xpI4HhNCsvYqzWKIQ4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HiBe81HpGxyddWVwWjDlDV15480UslGlT5q/BNaSTZH3aDNFBI4d4uAgdXD+XS4YY
	 405zInV2vzbK8i9XYXbJk8qk2Pljcgl6FSagyk5o0JBvXUuQOWkHpB+d1M7KqOcwiQ
	 Nla4ToG3G9S+b5nnonH/bfJxfJCvOTQ62X2XPMa+iJ196rue8bBDfv+jCiLFGLH4r6
	 RE4YjFYiWgrmMtr43GasBHWTA1ll+BVdt5SkQGgO7FB90hmKv4pz0j2UsTlCYLURXe
	 /SP0lMRafIxDqRmVwnpQwpUuZPEXVSYnktPzFDxRJhunNODvhVsHvXPoyNEHL2GMvh
	 3svDYtfOu248Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+8b512026a7ec10dcbdd9@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 07/11] wifi: mac80211: drop invalid source address OCB frames
Date: Tue, 24 Jun 2025 00:12:55 -0400
Message-Id: <20250624041259.84940-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250624041259.84940-1-sashal@kernel.org>
References: <20250624041259.84940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.185
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit d1b1a5eb27c4948e8811cf4dbb05aaf3eb10700c ]

In OCB, don't accept frames from invalid source addresses
(and in particular don't try to create stations for them),
drop the frames instead.

Reported-by: syzbot+8b512026a7ec10dcbdd9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/6788d2d9.050a0220.20d369.0028.GAE@google.com/
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Tested-by: syzbot+8b512026a7ec10dcbdd9@syzkaller.appspotmail.com
Link: https://patch.msgid.link/20250616171838.7433379cab5d.I47444d63c72a0bd58d2e2b67bb99e1fea37eec6f@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Security Vulnerability Fixed

The commit fixes a clear security vulnerability in OCB (Outside Context
of a BSS) mode where frames with invalid source addresses are accepted
and processed. Looking at the code change:

```c
+               /* reject invalid/our STA address */
+               if (!is_valid_ether_addr(hdr->addr2) ||
+                   ether_addr_equal(sdata->dev->dev_addr, hdr->addr2))
+                       return false;
```

This adds critical validation that was missing, preventing:

1. **Invalid MAC addresses** (all zeros, broadcast/multicast addresses)
   from being accepted
2. **Self-spoofing attacks** where frames appear to come from the
   device's own address

## Comparison with Similar Historical Fixes

This fix follows the exact pattern of Similar Commit #1 (Backport
Status: YES):
- That commit added `!is_valid_ether_addr(hdr->addr2)` check to ADHOC
  mode
- It fixed WARN_ON spam in `sta_info_insert_check()`
- It was deemed suitable for stable backporting

The OCB fix addresses the same class of vulnerability in a different
interface mode.

## Impact Without the Fix

Without this validation, the `ieee80211_ocb_rx_no_sta()` function would:
1. Create station entries for invalid addresses
2. Potentially trigger WARN_ON messages causing log spam
3. Allow resource exhaustion attacks by creating many invalid stations
4. Risk crashes or undefined behavior from invalid station entries

## Stable Backport Criteria Met

1. **Fixes a real bug**: Yes - invalid frames are incorrectly accepted
2. **Security impact**: Yes - potential DoS via resource exhaustion
3. **Small and contained**: Yes - adds 4 lines of validation
4. **Clear fix**: Yes - straightforward address validation
5. **No new features**: Correct - only adds missing validation
6. **Tested**: Yes - verified by syzbot

## Not Like the "NO" Examples

Unlike the commits marked for NO backporting:
- This is not adding new functionality (like link-addressed frames
  support)
- This is not a code cleanup or optimization
- This is fixing a concrete security issue reported by syzbot
- This has minimal risk of regression

The fix is essential for OCB mode security and should be backported to
all stable kernels that support OCB mode (since 2014).

 net/mac80211/rx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 26943c93f14c4..6c160ff2aab90 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4168,6 +4168,10 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 		if (!multicast &&
 		    !ether_addr_equal(sdata->dev->dev_addr, hdr->addr1))
 			return false;
+		/* reject invalid/our STA address */
+		if (!is_valid_ether_addr(hdr->addr2) ||
+		    ether_addr_equal(sdata->dev->dev_addr, hdr->addr2))
+			return false;
 		if (!rx->sta) {
 			int rate_idx;
 			if (status->encoding != RX_ENC_LEGACY)
-- 
2.39.5


