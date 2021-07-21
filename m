Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B8B3D15EB
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 20:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238091AbhGUR2B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 13:28:01 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:15731 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238058AbhGUR2A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 13:28:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626890916; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=pa930ByGaNBYDxHUkpCnsttA7x9eewXwjb2aQJd3G1s=; b=FIcUbCL9oGUSfw4fXAF2r5EzhzX9vsMo3thhxqWupcq+5TOf/L6MBSAB1KD+bdTsAisrTHez
 ceL7NI9UnWArlYFwadWjK4vTbD+PEt+Z6YKHsz8Q6Sjf902bYSCfvDj3VUSnDuFa0uE0N5Ub
 bck6TnYMTy3SQhgqJToQE/mw9Us=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60f8629cd0100c7cf90f5fd0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 18:08:28
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9CE19C4338A; Wed, 21 Jul 2021 18:08:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 34FC4C43217;
        Wed, 21 Jul 2021 18:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34FC4C43217
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 2/4] ath11k: Introduce spectral hw configurable param
Date:   Wed, 21 Jul 2021 21:08:07 +0300
Message-Id: <20210721180809.90960-3-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721180809.90960-1-jouni@codeaurora.org>
References: <20210721180809.90960-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Karthikeyan Periyasamy <periyasa@codeaurora.org>

Below parameters have been identified as configurable across the platforms.
So to scale the spectral across the platforms, move these parameter
into hw param.

	1. Maximum FFT bins
	2. Summary report pad size
	3. FFT report header length

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01492-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ6018 hw1.0 AHB WLAN.HK.2.4.0.1-00330-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c     | 12 +++++++++
 drivers/net/wireless/ath/ath11k/hw.h       |  3 +++
 drivers/net/wireless/ath/ath11k/spectral.c | 29 +++++++++++-----------
 drivers/net/wireless/ath/spectral_common.h |  1 -
 4 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 2a81a544b6a9..08b2e67c8e19 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -65,6 +65,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 			 * so added pad size as 2 bytes to compensate the BIN size
 			 */
 			.fft_pad_sz = 2,
+			.summary_pad_sz = 0,
+			.fft_hdr_len = 16,
+			.max_fft_bins = 512,
 		},
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
 					BIT(NL80211_IFTYPE_AP) |
@@ -109,6 +112,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.spectral = {
 			.fft_sz = 4,
 			.fft_pad_sz = 0,
+			.summary_pad_sz = 0,
+			.fft_hdr_len = 16,
+			.max_fft_bins = 512,
 		},
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
 					BIT(NL80211_IFTYPE_AP) |
@@ -153,6 +159,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.spectral = {
 			.fft_sz = 0,
 			.fft_pad_sz = 0,
+			.summary_pad_sz = 0,
+			.fft_hdr_len = 0,
+			.max_fft_bins = 0,
 		},
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
 					BIT(NL80211_IFTYPE_AP),
@@ -235,6 +244,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.spectral = {
 			.fft_sz = 0,
 			.fft_pad_sz = 0,
+			.summary_pad_sz = 0,
+			.fft_hdr_len = 0,
+			.max_fft_bins = 0,
 		},
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
 					BIT(NL80211_IFTYPE_AP),
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index f0349c277026..5d150cd793b2 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -157,6 +157,9 @@ struct ath11k_hw_params {
 	struct {
 		u8 fft_sz;
 		u8 fft_pad_sz;
+		u8 summary_pad_sz;
+		u8 fft_hdr_len;
+		u16 max_fft_bins;
 	} spectral;
 
 	u16 interface_modes;
diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
index 11b9fec746a2..aca3c523632e 100644
--- a/drivers/net/wireless/ath/ath11k/spectral.c
+++ b/drivers/net/wireless/ath/ath11k/spectral.c
@@ -11,20 +11,20 @@
 #define ATH11K_SPECTRAL_EVENT_TIMEOUT_MS	1
 
 #define ATH11K_SPECTRAL_DWORD_SIZE		4
-#define ATH11K_SPECTRAL_ATH11K_MIN_BINS		64
-#define ATH11K_SPECTRAL_ATH11K_MIN_IB_BINS	32
-#define ATH11K_SPECTRAL_ATH11K_MAX_IB_BINS	256
+#define ATH11K_SPECTRAL_MIN_BINS		64
+#define ATH11K_SPECTRAL_MIN_IB_BINS	(ATH11K_SPECTRAL_MIN_BINS >> 1)
+#define ATH11K_SPECTRAL_MAX_IB_BINS(x)	((x)->hw_params.spectral.max_fft_bins >> 1)
 
 #define ATH11K_SPECTRAL_SCAN_COUNT_MAX		4095
 
 /* Max channel computed by sum of 2g and 5g band channels */
 #define ATH11K_SPECTRAL_TOTAL_CHANNEL		41
 #define ATH11K_SPECTRAL_SAMPLES_PER_CHANNEL	70
-#define ATH11K_SPECTRAL_PER_SAMPLE_SIZE		(sizeof(struct fft_sample_ath11k) + \
-						 ATH11K_SPECTRAL_ATH11K_MAX_IB_BINS)
+#define ATH11K_SPECTRAL_PER_SAMPLE_SIZE(x)	(sizeof(struct fft_sample_ath11k) + \
+						 ATH11K_SPECTRAL_MAX_IB_BINS(x))
 #define ATH11K_SPECTRAL_TOTAL_SAMPLE		(ATH11K_SPECTRAL_TOTAL_CHANNEL * \
 						 ATH11K_SPECTRAL_SAMPLES_PER_CHANNEL)
-#define ATH11K_SPECTRAL_SUB_BUFF_SIZE		ATH11K_SPECTRAL_PER_SAMPLE_SIZE
+#define ATH11K_SPECTRAL_SUB_BUFF_SIZE(x)	ATH11K_SPECTRAL_PER_SAMPLE_SIZE(x)
 #define ATH11K_SPECTRAL_NUM_SUB_BUF		ATH11K_SPECTRAL_TOTAL_SAMPLE
 
 #define ATH11K_SPECTRAL_20MHZ			20
@@ -442,8 +442,8 @@ static ssize_t ath11k_write_file_spectral_bins(struct file *file,
 	if (kstrtoul(buf, 0, &val))
 		return -EINVAL;
 
-	if (val < ATH11K_SPECTRAL_ATH11K_MIN_BINS ||
-	    val > SPECTRAL_ATH11K_MAX_NUM_BINS)
+	if (val < ATH11K_SPECTRAL_MIN_BINS ||
+	    val > ar->ab->hw_params.spectral.max_fft_bins)
 		return -EINVAL;
 
 	if (!is_power_of_2(val))
@@ -594,7 +594,7 @@ int ath11k_spectral_process_fft(struct ath11k *ar,
 	tlv_len = FIELD_GET(SPECTRAL_TLV_HDR_LEN, __le32_to_cpu(tlv->header));
 	/* convert Dword into bytes */
 	tlv_len *= ATH11K_SPECTRAL_DWORD_SIZE;
-	bin_len = tlv_len - (sizeof(*fft_report) - sizeof(*tlv));
+	bin_len = tlv_len - ab->hw_params.spectral.fft_hdr_len;
 
 	if (data_len < (bin_len + sizeof(*fft_report))) {
 		ath11k_warn(ab, "mismatch in expected bin len %d and data len %d\n",
@@ -607,8 +607,8 @@ int ath11k_spectral_process_fft(struct ath11k *ar,
 	/* Only In-band bins are useful to user for visualize */
 	num_bins >>= 1;
 
-	if (num_bins < ATH11K_SPECTRAL_ATH11K_MIN_IB_BINS ||
-	    num_bins > ATH11K_SPECTRAL_ATH11K_MAX_IB_BINS ||
+	if (num_bins < ATH11K_SPECTRAL_MIN_IB_BINS ||
+	    num_bins > ATH11K_SPECTRAL_MAX_IB_BINS(ab) ||
 	    !is_power_of_2(num_bins)) {
 		ath11k_warn(ab, "Invalid num of bins %d\n", num_bins);
 		return -EINVAL;
@@ -689,7 +689,7 @@ static int ath11k_spectral_process_data(struct ath11k *ar,
 		goto unlock;
 	}
 
-	sample_sz = sizeof(*fft_sample) + ATH11K_SPECTRAL_ATH11K_MAX_IB_BINS;
+	sample_sz = sizeof(*fft_sample) + ATH11K_SPECTRAL_MAX_IB_BINS(ab);
 	fft_sample = kmalloc(sample_sz, GFP_ATOMIC);
 	if (!fft_sample) {
 		ret = -ENOBUFS;
@@ -737,7 +737,8 @@ static int ath11k_spectral_process_data(struct ath11k *ar,
 			 * is 4 DWORD size (16 bytes).
 			 * Need to remove this workaround once HW bug fixed
 			 */
-			tlv_len = sizeof(*summary) - sizeof(*tlv);
+			tlv_len = sizeof(*summary) - sizeof(*tlv) +
+				  ab->hw_params.spectral.summary_pad_sz;
 
 			if (tlv_len < (sizeof(*summary) - sizeof(*tlv))) {
 				ath11k_warn(ab, "failed to parse spectral summary at bytes %d tlv_len:%d\n",
@@ -900,7 +901,7 @@ static inline int ath11k_spectral_debug_register(struct ath11k *ar)
 
 	ar->spectral.rfs_scan = relay_open("spectral_scan",
 					   ar->debug.debugfs_pdev,
-					   ATH11K_SPECTRAL_SUB_BUFF_SIZE,
+					   ATH11K_SPECTRAL_SUB_BUFF_SIZE(ar->ab),
 					   ATH11K_SPECTRAL_NUM_SUB_BUF,
 					   &rfs_scan_cb, NULL);
 	if (!ar->spectral.rfs_scan) {
diff --git a/drivers/net/wireless/ath/spectral_common.h b/drivers/net/wireless/ath/spectral_common.h
index 9c2e5458e425..e14f374f97d4 100644
--- a/drivers/net/wireless/ath/spectral_common.h
+++ b/drivers/net/wireless/ath/spectral_common.h
@@ -24,7 +24,6 @@
  * could be acquired so far.
  */
 #define SPECTRAL_ATH10K_MAX_NUM_BINS		256
-#define SPECTRAL_ATH11K_MAX_NUM_BINS		512
 
 /* FFT sample format given to userspace via debugfs.
  *
-- 
2.25.1

