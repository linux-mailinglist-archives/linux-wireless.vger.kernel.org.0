Return-Path: <linux-wireless+bounces-24386-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E37F2AE5B27
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 06:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E551BC14D6
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 04:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB92E2441AA;
	Tue, 24 Jun 2025 04:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7nqiaGp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFE5221DB9;
	Tue, 24 Jun 2025 04:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750738353; cv=none; b=Zaq5fl5UChJgMidU2qzAvEo4qURxrVO5rxTjG8Sh/vXun4llGWPlfYhfrd3rUk17/SZIHXlti72UymuwEvqLMtp9HWHIMUQkX6srEdpEvcduFLiL3mlTGK1C+93JissTR+5ky0HjWTnK1YtY8CaQSFDDaSCdf5SnASOiXEpxBq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750738353; c=relaxed/simple;
	bh=facy8F0nUNf3E9Ua+SPcJBCIrt1Ln1cNIBezrr34KXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o1aZneOJqZ6Z03ZIpzHaoo6+3bJCUIZMF6iWNA2tHPX/0Z7fTtKg5RpnRKaoQcMtd7oq4fUyL/yH5iGG5rU39icZI0NCHS7MY5ZuJcqODtWnMU8C4/gP0KR21dZhxfxrUGT207cQMcOPvToAIgJ1TcXO0z/CKbh2w0iHAK8iaSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7nqiaGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB37C4CEEF;
	Tue, 24 Jun 2025 04:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750738353;
	bh=facy8F0nUNf3E9Ua+SPcJBCIrt1Ln1cNIBezrr34KXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p7nqiaGp0uRSIqL2Bhd4mm/rfJMyy0xZ2v1MJX4slSGaloSBNMzwj8dkABLsV9Byv
	 wHrjWxxsZorGVSzu+ViOh9mYV2QFZ90RXvLlQMybC5M8+dQ++qee1hvnq3DCBxXYFR
	 vYEH+gT3RyASM3QAoh4iNyUR71IG4hOefcKCB/A3se/HXUJ1le+zz6TJtd51KQby/a
	 La9pr07tk9zX79gk0pU2zhocn5FVRl+5Wj+FBDkUg76JsPFtZDASix8L6rapdmDF3k
	 cYGC9nLvPVbn5TqlWy6z5Eo3bt/vV1qOxHeH6R3AJ7RHnl4N0SHGv6JNJZCAIF14lg
	 9wB3HFaB/Fm/g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 15/18] wifi: ath6kl: remove WARN on bad firmware input
Date: Tue, 24 Jun 2025 00:12:11 -0400
Message-Id: <20250624041214.84135-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250624041214.84135-1-sashal@kernel.org>
References: <20250624041214.84135-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.94
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


