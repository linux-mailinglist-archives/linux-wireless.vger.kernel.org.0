Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7569D26BC4E
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Sep 2020 08:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgIPGNc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Sep 2020 02:13:32 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:32383 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgIPGNc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Sep 2020 02:13:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600236811; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=H4UmbSJffnvOqoFOHZW59ieennwEBZHs1jc+KK4kAD0=; b=WFoH5VCz7w9bVG0hrZ/1OexjT4yInDpMb8pwyx0L5lye6pKrvOOxeDpIY3yp2I8CRiSUCtGr
 eViPtrejEW5bKstZfXOro1AVgZBz2d+nk1nTKzm1asIHcMYR+5+rNRq89Vp+1hFIt0zXP/eo
 U2uti1re7NYXWn/6n5a/+Kb13v8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f61acf39f3347551fa0ab90 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Sep 2020 06:13:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 81806C433FE; Wed, 16 Sep 2020 06:13:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from periyasa-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: periyasa)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 64887C433C8;
        Wed, 16 Sep 2020 06:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 64887C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=periyasa@codeaurora.org
From:   Karthikeyan Periyasamy <periyasa@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: [PATCH v2] ath11k: Add support spectral scan for IPQ6018
Date:   Wed, 16 Sep 2020 11:42:56 +0530
Message-Id: <1600236776-4042-1-git-send-email-periyasa@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

IPQ6018 supported with 4 bytes FFT BIN size. so supported 4 bytes
parsing logic in FFT report process. since spectral_fft_sz is
configured as zero in hw_params, spectral is not supported in
QCA6390 platform.

Tested-on: IPQ6018 WLAN.HK.2.1.0.1-01228-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
---
 v2:
   - Rebased on top of ToT

 drivers/net/wireless/ath/ath11k/core.c     |  3 +++
 drivers/net/wireless/ath/ath11k/hw.h       |  1 +
 drivers/net/wireless/ath/ath11k/spectral.c | 26 ++++++++++++++++----------
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index ce81702..7e5ef0e 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -57,6 +57,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.vdev_start_delay = false,
 		.htt_peer_map_v2 = true,
 		.tcl_0_only = false,
+		.spectral_fft_sz = 2,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -86,6 +87,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.vdev_start_delay = false,
 		.htt_peer_map_v2 = true,
 		.tcl_0_only = false,
+		.spectral_fft_sz = 4,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -115,6 +117,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.vdev_start_delay = true,
 		.htt_peer_map_v2 = false,
 		.tcl_0_only = true,
+		.spectral_fft_sz = 0,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 57960a7..975d44e 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -155,6 +155,7 @@ struct ath11k_hw_params {
 	bool vdev_start_delay;
 	bool htt_peer_map_v2;
 	bool tcl_0_only;
+	u8 spectral_fft_sz;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
index 92fd8a4..ac2a8cf 100644
--- a/drivers/net/wireless/ath/ath11k/spectral.c
+++ b/drivers/net/wireless/ath/ath11k/spectral.c
@@ -17,8 +17,6 @@
 #define ATH11K_SPECTRAL_ATH11K_MIN_IB_BINS	32
 #define ATH11K_SPECTRAL_ATH11K_MAX_IB_BINS	256
 
-#define ATH11K_SPECTRAL_SAMPLE_FFT_BIN_MASK	0xFF
-
 #define ATH11K_SPECTRAL_SCAN_COUNT_MAX		4095
 
 /* Max channel computed by sum of 2g and 5g band channels */
@@ -557,16 +555,16 @@ static u8 ath11k_spectral_get_max_exp(s8 max_index, u8 max_magnitude,
 	return max_exp;
 }
 
-static void ath11k_spectral_parse_16bit_fft(u8 *outbins, u8 *inbins, int num_bins)
+static void ath11k_spectral_parse_fft(u8 *outbins, u8 *inbins, int num_bins, u8 fft_sz)
 {
-	int i;
-	__le16 *data = (__le16 *)inbins;
+	int i, j;
 
 	i = 0;
+	j = 0;
 	while (i < num_bins) {
-		outbins[i] = (__le16_to_cpu(data[i])) &
-			     ATH11K_SPECTRAL_SAMPLE_FFT_BIN_MASK;
+		outbins[i] = inbins[j];
 		i++;
+		j += fft_sz;
 	}
 }
 
@@ -588,6 +586,12 @@ int ath11k_spectral_process_fft(struct ath11k *ar,
 
 	lockdep_assert_held(&ar->spectral.lock);
 
+	if (!ab->hw_params.spectral_fft_sz) {
+		ath11k_warn(ab, "invalid bin size type for hw rev %d\n",
+			    ab->hw_rev);
+		return -EINVAL;
+	}
+
 	tlv = (struct spectral_tlv *)data;
 	tlv_len = FIELD_GET(SPECTRAL_TLV_HDR_LEN, __le32_to_cpu(tlv->header));
 	/* convert Dword into bytes */
@@ -649,9 +653,8 @@ int ath11k_spectral_process_fft(struct ath11k *ar,
 	freq = summary->meta.freq2;
 	fft_sample->freq2 = __cpu_to_be16(freq);
 
-	ath11k_spectral_parse_16bit_fft(fft_sample->data,
-					fft_report->bins,
-					num_bins);
+	ath11k_spectral_parse_fft(fft_sample->data, fft_report->bins, num_bins,
+				  ab->hw_params.spectral_fft_sz);
 
 	fft_sample->max_exp = ath11k_spectral_get_max_exp(fft_sample->max_index,
 							  search.peak_mag,
@@ -959,6 +962,9 @@ int ath11k_spectral_init(struct ath11k_base *ab)
 		      ab->wmi_ab.svc_map))
 		return 0;
 
+	if (!ab->hw_params.spectral_fft_sz)
+		return 0;
+
 	for (i = 0; i < ab->num_radios; i++) {
 		ar = ab->pdevs[i].ar;
 		sp = &ar->spectral;
-- 
2.7.4

