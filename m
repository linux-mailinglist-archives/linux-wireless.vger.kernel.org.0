Return-Path: <linux-wireless+bounces-23627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483BBACD2BA
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87033A072B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 01:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D916E25A33E;
	Wed,  4 Jun 2025 00:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItUqcuL4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BD325A338;
	Wed,  4 Jun 2025 00:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998746; cv=none; b=CJGr+D71YnM5CQ43blU3Xo2cW161C8Ncjf0vOaQEfHRnXmHbgndsrqX9iB2vH9Iz1KThUSXZH91C+BcQ4qZ6nHikExqpWCdrtgKIeoWc13gLpKio6RAAzxK4/AH8HKod/SR0PS5G6ohil6hVjg30nTlDLGukOcc+zE9QvActd5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998746; c=relaxed/simple;
	bh=lZczzj5YQkYZRcD8aHGOMU8JXI7INh21lOf5qXrg/uA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uq03xnXtFyllPw2YGDh2RcYLcU/MDvWyxyGNZzJegSrO2RIbd3u4hXy57nPNQmzaaa7/Ln0654M111fih/tX6ZPQXuCIE39F9YTy3/qk3GOZos77Tr1XaLzh1yx7m89q7gFQDk2qKfN2zBy/i8qfMeH5Esytwj29GkAUJXV1JVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItUqcuL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB99C4CEEF;
	Wed,  4 Jun 2025 00:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998746;
	bh=lZczzj5YQkYZRcD8aHGOMU8JXI7INh21lOf5qXrg/uA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ItUqcuL4WrFP0FXggNttuPDsZPWIyB8CWa7zzfcUQmDt4fBZ7p1qA10J2k65yh+h2
	 giPnqGC7NS+xILDqV5Kr+/Rw2IytaYXqhdR41JIjgSVbaR1nqWRlDc1ayJC+rPIKif
	 Q1Bxz8NDDTVjRU8itAjXeTruNJ7KYrpCmpNbYH5+xlQw28xG/xRtQbkOa4yixbf1GF
	 kLatzVFMFqoKS4Qnr04OqW5ZO3PiEuXx77FxzBTUgh3u/6kWmjo81dkk4kxny4BA+c
	 azJR8B7Vl8McAVGLPv96sXTP3kNC1+cO+bqJFV2Zv6g2bOncYZw73LRwzR4WYM7Awp
	 TK6OGBQ1hhKoA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Suraj P Kizhakkethil <quic_surapk@quicinc.com>,
	Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 107/108] wifi: ath12k: Pass correct values of center freq1 and center freq2 for 160 MHz
Date: Tue,  3 Jun 2025 20:55:30 -0400
Message-Id: <20250604005531.4178547-107-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005531.4178547-1-sashal@kernel.org>
References: <20250604005531.4178547-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Suraj P Kizhakkethil <quic_surapk@quicinc.com>

[ Upstream commit b1b01e46a3db5ad44d1e4691ba37c1e0832cd5cf ]

Currently, for 160 MHz bandwidth, center frequency1 and
center frequency2 are not passed correctly to the firmware.
Set center frequency1 as the center frequency
of the primary 80 MHz channel segment and center frequency2 as
the center frequency of the 160 MHz channel and pass the values
to the firmware.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Suraj P Kizhakkethil <quic_surapk@quicinc.com>
Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Link: https://patch.msgid.link/20250304095315.3050325-2-quic_surapk@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my thorough analysis, here is my assessment: **YES** This
commit should be backported to stable kernel trees for the following
reasons: ## Analysis of the Code Changes The commit fixes a critical bug
in the 160 MHz channel frequency handling for the ath12k driver
(Qualcomm Wi-Fi 7 devices). The specific issues being corrected are: ###
1. **Incorrect center frequency calculation for 160 MHz EHT channels**
**Before the fix**: The code only handled `MODE_11AC_VHT80_80` for dual-
band scenarios but completely ignored `MODE_11BE_EHT160` (Wi-Fi 7's 160
MHz mode). This meant: - `chan->band_center_freq1` was incorrectly set
to the original `arg->band_center_freq1` - `chan->band_center_freq2` was
set to 0, providing no information about the 160 MHz channel structure
**After the fix**: For `MODE_11BE_EHT160`, the code now correctly: -
Sets `chan->band_center_freq1` to the center of the primary 80 MHz
segment (±40 MHz from control channel) - Sets `chan->band_center_freq2`
to the center of the entire 160 MHz channel - Follows the exact same
pattern already established and proven in ath11k driver for
`MODE_11AX_HE160` ### 2. **Follows established precedent from ath11k**
The ath11k driver (lines 851-860 in
`/home/sasha/linux/drivers/net/wireless/ath/ath11k/wmi.c`) already
implements this exact logic for `MODE_11AX_HE160`: ```c if
(arg->channel.mode == MODE_11AX_HE160) { if (arg->channel.freq >
arg->channel.band_center_freq1) chan->band_center_freq1 = center_freq1 +
40; else chan->band_center_freq1 = center_freq1 - 40;
chan->band_center_freq2 = arg->channel.band_center_freq1; } ``` The
ath12k fix implements identical logic for `MODE_11BE_EHT160`, ensuring
consistency across the ath driver family. ### 3. **Impact on Users**
Without this fix, 160 MHz channels on Wi-Fi 7 devices would not work
correctly because: - The firmware receives incorrect channel center
frequency information - This could lead to improper channel selection,
interference, or complete failure to establish 160 MHz connections -
Users with QCN9274 (and similar) devices would experience degraded Wi-Fi
7 performance ### 4. **Meets Stable Backport Criteria** ✅ **Fixes
important functionality**: 160 MHz operation is a key Wi-Fi 7 feature ✅
**Small, contained change**: Only affects one function, adds clear
conditional logic ✅ **Low regression risk**: Follows proven pattern from
ath11k, only changes previously broken path ✅ **Clear side effects**:
None beyond fixing the intended issue ✅ **Well-tested**: Commit includes
"Tested-on: QCN9274 hw2.0" with specific firmware version ### 5.
**Driver Maturity Context** ATH12K is the Wi-Fi 7 driver for
current/recent Qualcomm chipsets. While newer than ath11k, it supports
hardware that users actively deploy. The 160 MHz functionality is
critical for achieving the high throughput promised by Wi-Fi 7. ### 6.
**Comparison with Similar Commits** This commit closely resembles
**Similar Commit #2** (marked YES for backport) which also fixed
frequency calculation issues in ath12k for 6 GHz operation. Both
commits: - Fix critical frequency/channel handling bugs - Have minimal
code changes with low regression risk - Include proper testing
validation - Address functionality that affects real user deployments
The fix is essential for proper Wi-Fi 7 160 MHz operation and should be
backported to ensure users with ath12k-supported hardware can fully
utilize their devices' capabilities.

 drivers/net/wireless/ath/ath12k/wmi.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index de7e3e74d8c26..2e34a0f1c1428 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -998,14 +998,24 @@ int ath12k_wmi_vdev_down(struct ath12k *ar, u8 vdev_id)
 static void ath12k_wmi_put_wmi_channel(struct ath12k_wmi_channel_params *chan,
 				       struct wmi_vdev_start_req_arg *arg)
 {
+	u32 center_freq1 = arg->band_center_freq1;
+
 	memset(chan, 0, sizeof(*chan));
 
 	chan->mhz = cpu_to_le32(arg->freq);
-	chan->band_center_freq1 = cpu_to_le32(arg->band_center_freq1);
-	if (arg->mode == MODE_11AC_VHT80_80)
+	chan->band_center_freq1 = cpu_to_le32(center_freq1);
+	if (arg->mode == MODE_11BE_EHT160) {
+		if (arg->freq > center_freq1)
+			chan->band_center_freq1 = cpu_to_le32(center_freq1 + 40);
+		else
+			chan->band_center_freq1 = cpu_to_le32(center_freq1 - 40);
+
+		chan->band_center_freq2 = cpu_to_le32(center_freq1);
+	} else if (arg->mode == MODE_11BE_EHT80_80) {
 		chan->band_center_freq2 = cpu_to_le32(arg->band_center_freq2);
-	else
+	} else {
 		chan->band_center_freq2 = 0;
+	}
 
 	chan->info |= le32_encode_bits(arg->mode, WMI_CHAN_INFO_MODE);
 	if (arg->passive)
-- 
2.39.5


