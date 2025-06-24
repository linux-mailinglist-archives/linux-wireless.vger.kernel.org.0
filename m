Return-Path: <linux-wireless+bounces-24388-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A69AAE5B43
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 06:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CBC18884C5
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 04:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD033231845;
	Tue, 24 Jun 2025 04:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RROIU61X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8000522FDEA;
	Tue, 24 Jun 2025 04:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750738374; cv=none; b=aePGlhAFIx3lhO6j0Yl8E7J6ykKddEg3V7y203He5OeeeF5T0YiWd8SOHoiVMSik5bIjZnZ6gw1Aoy28XZsuvYYrm0jpJ84AnUOT+kbPoBBjPRRlPqRftPGReZtSgay7Fsh4LQR0PPJ6vEV2PDnNdz4vGXQj8gi4LinQj8jkN98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750738374; c=relaxed/simple;
	bh=facy8F0nUNf3E9Ua+SPcJBCIrt1Ln1cNIBezrr34KXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jiVi2Vlzs1fHjm0YCOnhv4BkR5merSEpOh8NW7wh99q1mGVj68i6jxSJUiLWr+iEYnYxl4IP1CXS3676RMeYDdkiUAKkTuOiFZd4zg5DZ+JFySG69b0EXNiyqfPUTiTW0p06H6mgmWDHbOOzHxxKMq5CIAYCSwfKpGvcyXTnzOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RROIU61X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B61C4CEE3;
	Tue, 24 Jun 2025 04:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750738374;
	bh=facy8F0nUNf3E9Ua+SPcJBCIrt1Ln1cNIBezrr34KXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RROIU61XbBPTPImXI6gnHXalsbv/DpGYPE9r4NLpTaZt/gB7dcD6xK6PLGCEMGhQP
	 INkgpMvJdk3/DXnIOQ9ir8GO4PfueRAXQjhmhP82YciznSDuo8dfUfipJRMoSrgx8p
	 XaxsrW4Z28KmX9s7m4Wze+X7KMhFxWVrFN/orrH4y7BDGxN/bDRdCYaOwuZytO6g3V
	 FbVyzBopy6mY4zPGZOzOGVJiKr8rdD7iIJZM/0LjuaiVmlsM+/B5y0UuL/4XYM9oM7
	 3YbQJ+pGF/mJlWNY9/640ASPls0xl6UkFRayYDqtDf0TGpd8eqvd0RqHUABxQ3q6Eh
	 tynQYQwHM+JZg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 12/15] wifi: ath6kl: remove WARN on bad firmware input
Date: Tue, 24 Jun 2025 00:12:35 -0400
Message-Id: <20250624041238.84580-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250624041238.84580-1-sashal@kernel.org>
References: <20250624041238.84580-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.141
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


