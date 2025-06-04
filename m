Return-Path: <linux-wireless+bounces-23621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FC6ACD2B3
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 03:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE5A176F0C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 01:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B910259C87;
	Wed,  4 Jun 2025 00:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAAQ4Rhk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0296F1C84C5;
	Wed,  4 Jun 2025 00:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998737; cv=none; b=qybp9N+zKJezB9EtAs3waGLqBKzvDhFRNelS8Yv5eanVqBaXf5JDPJTpPZjKsqe7AtPa0Juo8L/htLIw+cnzgTwKlWSHNCSqLERnXzE6cF7xtLf4ascUqBRMFpRHbpJQBx1SVx3Tl8tC2vz6blC8nOI/gYovrkl6XhRhXp5oJ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998737; c=relaxed/simple;
	bh=qu8ZpozExl08qP3xK4+hHn21qz11XlWdOYePU30oZL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HSMDhS4C9n4+Qy4LsdHpdOhoqaNcujIX8MpD02cXIW2qRv4IWXSM16Q9sU7uCzguJ0tCkgjoC7ivqCjQfbrEafFpfhiiLSHb26h51pfcAFQvWqPMa3n6ecKG7vDUgR6OXqRIcWDtiOh7vwOmXOAvKO+U3kB6TooqVRAc94jOgu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAAQ4Rhk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B86C4CEF3;
	Wed,  4 Jun 2025 00:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998736;
	bh=qu8ZpozExl08qP3xK4+hHn21qz11XlWdOYePU30oZL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZAAQ4RhkI+g+XeFCrB82SshdNhSAt+lSYITc3QJPI9k86KV9/KQZH4A/GB9yavBhc
	 TVRz8Dw3ts3CRbq+hUrMse2ccmYVYKpZr7Fdj9nlsBU7gwC3Urgkdj0t0LXkmPmgkf
	 8mpZXrITkmT9ZoLyBLZF6HtK7eVxPw9qyBzbP7k4e8z2JJEhViGeSXwWi0f1ADeXbT
	 Zuibw44FISHpgPwAyxCL6W12nRqKx1XoIHIjEDKosZ/6Z8fi6KZ0Tqh4zTPl8SZpk4
	 wwT93muQJTNHt71HmtUIrlvMlD9/dttzL95MJ/od15Xg2t3DtwHZ4Fng9hKAPD7hPv
	 tczwEwIZKx3fQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 101/108] wifi: ath12k: Fix incorrect rates sent to firmware
Date: Tue,  3 Jun 2025 20:55:24 -0400
Message-Id: <20250604005531.4178547-101-sashal@kernel.org>
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
Content-Transfer-Encoding: 8bit

From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>

[ Upstream commit cb1790249361ba9396b06b1af2500147e6e42e5e ]

Before firmware assert, if there is a station interface in the device
which is not associated with an AP, the basic rates are set to zero.
Following this, during firmware recovery, when basic rates are zero,
ath12k driver is sending invalid rate codes, which are negative values,
to firmware. This results in firmware assert.

Fix this by checking if rate codes are valid, before sending them
to the firmware.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250320112426.1956961-1-quic_rdevanat@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. ##
Analysis This commit fixes a critical bug that causes firmware crashes
during firmware recovery scenarios, making it an important candidate for
stable backporting. ### Issue Analysis **The Problem:** The commit
addresses a scenario where during firmware recovery, when a station
interface exists but is not associated with an AP, the `basic_rates`
field becomes zero. The original code uses `ffs(bss_conf->basic_rates) -
1` to calculate the basic rate index, which produces a negative value
(-1) when `basic_rates` is zero, since `ffs(0)` returns 0. **Code
Changes Analysis:** 1. **In `ath12k_recalculate_mgmt_rate()`:** ```c -
basic_rate_idx = ffs(bss_conf->basic_rates) - 1; + if
(bss_conf->basic_rates) + basic_rate_idx = __ffs(bss_conf->basic_rates);
+ else + basic_rate_idx = 0; ``` 2. **In
`ath12k_mac_bss_info_changed()`:** ```c - if (mcast_rate > 0) + if
(mcast_rate > 0) { rateidx = mcast_rate - 1; - else - rateidx =
ffs(info->basic_rates) - 1; + } else { + if (info->basic_rates) +
rateidx = __ffs(info->basic_rates); + else + rateidx = 0; + } ``` ###
Why This Should Be Backported **1. Firmware Crash Prevention:** The
commit directly prevents firmware crashes by ensuring invalid rate codes
(negative values) are never sent to firmware. This is a critical
stability fix. **2. Small and Contained Fix:** The changes are minimal
and focused - just adding proper validation for the `basic_rates` field
before using it in rate calculations. The fix doesn't introduce new
features or architectural changes. **3. Common Scenario Impact:** The
issue occurs during firmware recovery when station interfaces exist but
aren't associated - a scenario that can happen during normal operation,
especially in environments with frequent disconnections or recovery
events. **4. Consistent with Stable Tree Criteria:** - Fixes an
important bug affecting users (firmware crashes) - Changes are minimal
and low-risk - No new functionality introduced - Confined to the ath12k
subsystem **5. Similarity to Backported Commits:** This fix follows the
same pattern as the historical examples that were backported (marked
"YES"): - Similar Commit #1: Fixed incorrect multicast/broadcast rate
setting that caused broken mesh paths - Similar Commit #3: Fixed invalid
AMPDU factor calculation - Similar Commit #4: Fixed failed frame
transmission handling to prevent metric calculation issues - Similar
Commit #5: Fixed firmware crash due to invalid peer NSS values **6. Low
Regression Risk:** The fix uses safe fallback behavior (defaulting to
rate index 0) when `basic_rates` is zero, which is much safer than
sending negative rate codes to firmware. The commit addresses a clear
bug that causes firmware stability issues in a common operational
scenario, with a minimal and safe fix that follows established patterns
for stable tree inclusion.

 drivers/net/wireless/ath/ath12k/mac.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 06b2baccd1335..b06836525e2c4 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3413,7 +3413,10 @@ static void ath12k_recalculate_mgmt_rate(struct ath12k *ar,
 	}
 
 	sband = hw->wiphy->bands[def->chan->band];
-	basic_rate_idx = ffs(bss_conf->basic_rates) - 1;
+	if (bss_conf->basic_rates)
+		basic_rate_idx = __ffs(bss_conf->basic_rates);
+	else
+		basic_rate_idx = 0;
 	bitrate = sband->bitrates[basic_rate_idx].bitrate;
 
 	hw_rate_code = ath12k_mac_get_rate_hw_value(bitrate);
@@ -3811,10 +3814,14 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
 		band = def.chan->band;
 		mcast_rate = info->mcast_rate[band];
 
-		if (mcast_rate > 0)
+		if (mcast_rate > 0) {
 			rateidx = mcast_rate - 1;
-		else
-			rateidx = ffs(info->basic_rates) - 1;
+		} else {
+			if (info->basic_rates)
+				rateidx = __ffs(info->basic_rates);
+			else
+				rateidx = 0;
+		}
 
 		if (ar->pdev->cap.supported_bands & WMI_HOST_WLAN_5G_CAP)
 			rateidx += ATH12K_MAC_FIRST_OFDM_RATE_IDX;
-- 
2.39.5


