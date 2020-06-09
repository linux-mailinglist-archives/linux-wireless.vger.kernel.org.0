Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D4C1F356A
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 09:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgFIHse (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 03:48:34 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:45670 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726813AbgFIHse (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 03:48:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591688913; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=6qC+PyHQaD/u7AC6oVu4SrRhK/+vC0CHiUDnCAsUNak=; b=pdhcvby+//QKIarDHn3h3JdLHCEXGoq/OsFwkDVYUyXPo3RNf/LHHnY5SYVxYQUkKXrmytZ1
 wRp262QZZyVQnoBu3XbehuvWKr4BWmEMlpVAB6YeRcrtj+KHmEL/99AcbinhHJx29Kl9Bd54
 P3QCEtADkghohsoqvz1ySzXf6x4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n14.prod.us-west-2.postgun.com with SMTP id
 5edf3ec95c89e47d73d8ae6b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 07:48:25
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F1E75C4339C; Tue,  9 Jun 2020 07:48:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from periyasa-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: periyasa)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1338FC433C6;
        Tue,  9 Jun 2020 07:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1338FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=periyasa@codeaurora.org
From:   Karthikeyan Periyasamy <periyasa@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: [PATCH] ath11k: Add support spectral scan for IPQ6018
Date:   Tue,  9 Jun 2020 13:18:08 +0530
Message-Id: <1591688888-30237-1-git-send-email-periyasa@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

IPQ6018 supported with 4 bytes FFT BIN size. so supported 4 bytes
parsing logic in FFT report process.

Tested-on: IPQ6018 WLAN.HK.2.1.0.1-01228-QCAHKSWPL_SILICONZ-1

Note: This is based on below patches
	1. ath11k: add IPQ6018 support
	2. ath11k: add support for spectral scan
	3. ath11k: Add direct buffer ring support

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c     |  2 ++
 drivers/net/wireless/ath/ath11k/hw.h       |  1 +
 drivers/net/wireless/ath/ath11k/spectral.c | 23 +++++++++++++----------
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 3516ea6..45bf10b 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -26,6 +26,7 @@
 			.board_size = IPQ8074_MAX_BOARD_DATA_SZ,
 			.cal_size =  IPQ8074_MAX_CAL_DATA_SZ,
 		},
+		.spectral_fft_sz = 2,
 	},
 	{
 		.dev_id = ATH11K_HW_IPQ6018,
@@ -35,6 +36,7 @@
 			.board_size = IPQ6018_MAX_BOARD_DATA_SZ,
 			.cal_size =  IPQ6018_MAX_CAL_DATA_SZ,
 		},
+		.spectral_fft_sz = 4,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index d976533..7d2b147 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -117,6 +117,7 @@ struct ath11k_hw_params {
 		size_t board_size;
 		size_t cal_size;
 	} fw;
+	u8 spectral_fft_sz;
 };
 
 struct ath11k_fw_ie {
diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
index 1c5d65b..f3196a0 100644
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
+	ath11k_spectral_parse_fft(fft_sample->data, fft_report->bins,
+				  num_bins, ab->hw_params.spectral_fft_sz);
 
 	fft_sample->max_exp = ath11k_spectral_get_max_exp(fft_sample->max_index,
 							  search.peak_mag,
-- 
1.9.1

