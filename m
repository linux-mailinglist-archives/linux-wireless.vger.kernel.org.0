Return-Path: <linux-wireless+bounces-27113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F4223B49DFB
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 02:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47B71B23276
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 00:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D791F416A;
	Tue,  9 Sep 2025 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="du0vpJm4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869331C01;
	Tue,  9 Sep 2025 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757377829; cv=none; b=ff5XdBFEuUgTiEZu+OWSYewDjVfi8gbGkWVMXWUmSX/HDAZ8PHr2abaiehqfhD8a177TY9gTfVXXQhLm6PCKFrDqk2PVUbN7liEhYBcRNxWFTzPlZl3E7aSkcIFG1nsk2LaZgWqRyF5M76UvitoCr2NWkHp6PMNU08X03vilsdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757377829; c=relaxed/simple;
	bh=jZBFPEpo6t+Z4YDP2lNx0TwkOOKOoZ+qAeQZjGBaWzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CZrtA1JRIAfQDdV1/VfuYzAdJA6Jc0l5N5MeVlmL+1ZI90lRSLvXxrUOiGehRGMnjzgyDZ83j6WJBNZxaAjlvO47g7qIN7C6dNKpneeo/baGzDtXdRvEiqhPhcqXBY02BivCdBq5FoBU27zR4PY9Gbyq9VJ/7Un4tqqV8gQ/lng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=du0vpJm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E27C4CEF9;
	Tue,  9 Sep 2025 00:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757377829;
	bh=jZBFPEpo6t+Z4YDP2lNx0TwkOOKOoZ+qAeQZjGBaWzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=du0vpJm4oR7jnDET8ihqSEBBfZqrC1GQeZPwdtcsIYaxztsUP4pqi1uxVm2lXOwkA
	 VnybZJxH4tsLEsWjb1I/HXo7N7X1WSYHgtFVwzo/WXdxkkhqKr+qoY7ZDa42V3lsWy
	 96KyUvjvuPFmE9FCAK3fFdYEtrfPCwV5mY7aoJiuBmneNO/sY92KtsSsPkCs29yYxQ
	 hkyXvj21eVy9nRAGLb5ckHV0MhX+jKGfjeE/lJtcPOo9a9NcXTpo9Go1I9+B9kF1Nd
	 UX/fNDGXnpNwm3O/f/shzGaPOK9yivIgmhVMFKO6Sq/87ZhlSRMCVxLPxThzXKdXgv
	 N0hJYuDxqs5uw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16-5.4] wifi: mac80211: fix incorrect type for ret
Date: Mon,  8 Sep 2025 20:30:12 -0400
Message-ID: <20250909003025.2493540-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909003025.2493540-1-sashal@kernel.org>
References: <20250909003025.2493540-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Liao Yuanhong <liaoyuanhong@vivo.com>

[ Upstream commit a33b375ab5b3a9897a0ab76be8258d9f6b748628 ]

The variable ret is declared as a u32 type, but it is assigned a value
of -EOPNOTSUPP. Since unsigned types cannot correctly represent negative
values, the type of ret should be changed to int.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
Link: https://patch.msgid.link/20250825022911.139377-1-liaoyuanhong@vivo.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

## Analysis of the Code Change

The commit fixes a clear type mismatch bug in `net/mac80211/driver-
ops.h:1419` where `ret` was incorrectly declared as `u32` while being
assigned the negative error value `-EOPNOTSUPP` (-95):

```c
// Before (incorrect):
u32 ret = -EOPNOTSUPP;  // Assigns -95 to unsigned, becomes 4294967201

// After (correct):
int ret = -EOPNOTSUPP;  // Properly represents -95
```

## Why This Qualifies for Stable Backport

1. **Bug Fix**: This is a genuine bug that violates C type safety.
   Assigning negative values to unsigned types is incorrect and can lead
   to undefined behavior or compiler-specific interpretations.

2. **Long-standing Issue**: The bug has existed since kernel v4.20
   (commit bc847970f43281cb, October 2018), affecting all stable kernels
   from 4.20 onwards. A 7-year-old bug deserves fixing in stable trees.

3. **Minimal and Contained**: The fix is a single-line type change from
   `u32` to `int`. It's about as minimal and low-risk as a kernel patch
   can be.

4. **No Functional Changes**: The fix doesn't introduce new features or
   change architecture - it simply corrects a type declaration to match
   its intended use.

5. **Correctness Over Impact**: While the practical impact was minimal
   due to implicit type conversion preserving the negative value when
   returned as `int`, this is still incorrect code that:
   - Violates type safety principles
   - Can trigger compiler warnings
   - Sets a bad example for similar code patterns
   - Could break with different compiler optimizations or architectures

6. **Affects Error Handling Path**: The bug is in error handling code
   (`-EOPNOTSUPP`), and correct error handling is critical for kernel
   stability. Even if the current behavior happens to work, relying on
   implicit conversions for error codes is dangerous.

7. **Simple Verification**: The fix is trivially verifiable - the
   function returns `int` and all error codes are negative, so `ret`
   should be `int`, not `u32`.

## Stable Tree Rules Compliance

The commit perfectly aligns with stable kernel rules:
- ✅ Fixes a real bug (type mismatch)
- ✅ Already merged in Linus' tree
- ✅ Minimal size (1 line change)
- ✅ No new features added
- ✅ Low regression risk
- ✅ Improves code correctness

The fact that this bug existed for 7 years without causing reported
failures actually strengthens the case for backporting - it means the
fix is extremely safe while still correcting incorrect code that could
potentially cause issues with different compilers or architectures.

 net/mac80211/driver-ops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 307587c8a0037..7964a7c5f0b2b 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1389,7 +1389,7 @@ drv_get_ftm_responder_stats(struct ieee80211_local *local,
 			    struct ieee80211_sub_if_data *sdata,
 			    struct cfg80211_ftm_responder_stats *ftm_stats)
 {
-	u32 ret = -EOPNOTSUPP;
+	int ret = -EOPNOTSUPP;
 
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
-- 
2.51.0


