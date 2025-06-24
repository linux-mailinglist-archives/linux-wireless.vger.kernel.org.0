Return-Path: <linux-wireless+bounces-24390-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10623AE5B5C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 06:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD99178825
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 04:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094A4253F11;
	Tue, 24 Jun 2025 04:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XX4BzroJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A8A253F08;
	Tue, 24 Jun 2025 04:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750738390; cv=none; b=UfEg0H6fNfDd8l0gaWdwMqHI4hm6L80mz3MHdg8x0onJjx7RC1iG2swXys1Mi3qe94aSR0AsXDZo5LNpD7FEIzou9c3HH2GlqtYX/GBOewxIu9u35r1c/XeUzFIeJ+Oo2hIYq35V/eYZcqKNCKQuj69NVwlOu8gKSFSFNxY1Xlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750738390; c=relaxed/simple;
	bh=facy8F0nUNf3E9Ua+SPcJBCIrt1Ln1cNIBezrr34KXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eb031iBQ26e3UkUYR8JOS2zXpKncAFpyKsiyWlnTEyjWZMfbnLJyTRZde7rPJuflqCITHRStYgJOWqBfQ18YSUWNA7rtWg9WA7ORNydmDQ3H6MO5eqlXStO9VjBfvahcPTtc2HjuTxgtfgAy7gx7C0cMjLyQeKhMvGWhqZFbdeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XX4BzroJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4B9C4CEEF;
	Tue, 24 Jun 2025 04:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750738390;
	bh=facy8F0nUNf3E9Ua+SPcJBCIrt1Ln1cNIBezrr34KXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XX4BzroJ9FozDa1cFfgUZtuBxKIEunG7ritpaRjcOfJidBXuOVGnWW3K2ZWHIaBjU
	 zbmVGUm1ddVAcAKOLALbIVOOCcxkX5mNbKhcf4YzoRpE7reyMeEz0MbA8jq2T/1oq2
	 yCGla9jaKTxJOshEkTcrBnZm2V74VC+0zXUQ1APYiHUvYWxnbsd+csMY3apf+MtaHI
	 MBHl7wWAhMAUvQoAP8GvjAtipJc/wJS7toZyu4i9HyhMw4kQ08jOqDNmdxHiY/01NT
	 6b/vEJzx0QqL1iPcFIxuxw8OVI7C62VFT9IXz3lmweFBMGINbkqtxEceCXoGmTT7Ov
	 +wTm2joSKvIrw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 08/11] wifi: ath6kl: remove WARN on bad firmware input
Date: Tue, 24 Jun 2025 00:12:56 -0400
Message-Id: <20250624041259.84940-8-sashal@kernel.org>
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

[ Upstream commit e7417421d89358da071fd2930f91e67c7128fbff ]

If the firmware gives bad input, that's nothing to do with
the driver's stack at this point etc., so the WARN_ON()
doesn't add any value. Additionally, this is one of the
top syzbot reports now. Just print a message, and as an
added bonus, print the sizes too.

Reported-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
Tested-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Link: https://patch.msgid.link/20250617114529.031a677a348e.I58bf1eb4ac16a82c546725ff010f3f0d2b0cca49@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees for the
following reasons:

## Security and Stability Impact

1. **Syzbot Report**: The commit explicitly mentions this is "one of the
   top syzbot reports now", indicating it's a frequently triggered issue
   that impacts kernel stability testing. Syzbot is Google's continuous
   fuzzing infrastructure that finds kernel bugs, and high-frequency
   reports indicate significant impact.

2. **WARN_ON Misuse**: The removed WARN_ON is checking for bad firmware
   input, which violates kernel best practices. WARN_ON should only be
   used for "impossible" conditions that indicate kernel bugs, not for
   validating external input. As the commit message states: "If the
   firmware gives bad input, that's nothing to do with the driver's
   stack at this point."

3. **DoS Potential**: A WARN_ON can be triggered by malicious or
   corrupted firmware, potentially causing:
   - Stack traces in kernel logs (log spam)
   - Performance degradation
   - In some configurations, system panic (if panic_on_warn is set)

## Code Analysis

The change is minimal and safe:
```c
- WARN_ON(1);
+ ath6kl_err("mismatched byte count %d vs. expected %zd\n",
+            le32_to_cpu(targ_info->byte_count),
+            sizeof(*targ_info));
```

The fix:
- Removes the inappropriate WARN_ON
- Adds informative error logging with actual vs expected sizes
- Maintains the same error handling path (return -EINVAL)
- No functional changes beyond logging

## Similar Precedent

Looking at similar commits:
- Commit #5 (ath6kl: reduce WARN to dev_dbg() in callback) -
  **Backported: YES** - Similar removal of WARN for known race condition
- Commit #3 (ath10k: Change the warning message string) - **Backported:
  YES** - Modified warning to avoid syzbot confusion

## Stable Kernel Criteria

This meets stable kernel criteria:
- **Fixes a real bug**: Addresses inappropriate WARN_ON usage that can
  be triggered by external input
- **Minimal change**: Only removes WARN_ON and adds error message
- **Low risk**: No functional changes, just logging improvement
- **Tested**: Explicitly tested by syzbot
- **Clear benefit**: Reduces false positive warnings and improves
  debugging

The commit is a straightforward fix that improves kernel robustness
without introducing new risks, making it an ideal candidate for stable
backporting.

 drivers/net/wireless/ath/ath6kl/bmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath6kl/bmi.c b/drivers/net/wireless/ath/ath6kl/bmi.c
index af98e871199d3..5a9e93fd1ef42 100644
--- a/drivers/net/wireless/ath/ath6kl/bmi.c
+++ b/drivers/net/wireless/ath/ath6kl/bmi.c
@@ -87,7 +87,9 @@ int ath6kl_bmi_get_target_info(struct ath6kl *ar,
 		 * We need to do some backwards compatibility to make this work.
 		 */
 		if (le32_to_cpu(targ_info->byte_count) != sizeof(*targ_info)) {
-			WARN_ON(1);
+			ath6kl_err("mismatched byte count %d vs. expected %zd\n",
+				   le32_to_cpu(targ_info->byte_count),
+				   sizeof(*targ_info));
 			return -EINVAL;
 		}
 
-- 
2.39.5


