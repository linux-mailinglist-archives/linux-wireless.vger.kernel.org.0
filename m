Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7361EB2BA
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2020 02:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgFBAbg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jun 2020 20:31:36 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:57201 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbgFBAbf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jun 2020 20:31:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591057894; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=B69SSZTJq1OA8ksaTM/ow9wWEb/dwjjTpwVtyeQg7wc=; b=B5RloE4ElKwpY3j6dAoUu0Nz1x7YTzram04XQBmxGSJOzyJyr6NxbKrEBDQ4RhLgN7gUsa+I
 9Ph/hBFWv/XV2MGeGNawn0FvoC8Bb21UaSIFFbIexWPiLHt93/M2EGSuYdYOpf509U8YSLt3
 ponRHymqO7NuZElj4OANmJVRkBA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5ed59de6082f42857f751d8d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Jun 2020 00:31:34
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 25E55C433CB; Tue,  2 Jun 2020 00:31:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5FDA7C433C6;
        Tue,  2 Jun 2020 00:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5FDA7C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH] ath11k: build HE 6 GHz capability
Date:   Mon,  1 Jun 2020 17:31:28 -0700
Message-Id: <1591057888-2862-1-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Build 6 GHz band capability from HT and VHT capabilities reported
by firmware.

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index e04f0e711779..f68e97c5695c 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -548,6 +548,7 @@ struct ath11k_band_cap {
 	u32 he_mcs;
 	u32 he_cap_phy_info[PSOC_HOST_MAX_PHY_SIZE];
 	struct ath11k_ppe_threshold he_ppet;
+	u16 he_6ghz_capa;
 };
 
 struct ath11k_pdev_cap {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 2836a0f197ab..3604e2e08d67 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3532,6 +3532,35 @@ ath11k_mac_filter_he_cap_mesh(struct ieee80211_he_cap_elem *he_cap_elem)
 	he_cap_elem->phy_cap_info[9] &= ~m;
 }
 
+static __le16 ath11k_mac_setup_he_6ghz_cap(struct ath11k_pdev_cap *pcap,
+					   struct ath11k_band_cap *bcap)
+{
+	u8 val;
+
+	bcap->he_6ghz_capa = IEEE80211_HT_MPDU_DENSITY_NONE;
+	if (bcap->ht_cap_info & WMI_HT_CAP_DYNAMIC_SMPS)
+		bcap->he_6ghz_capa |=
+			FIELD_PREP(IEEE80211_HE_6GHZ_CAP_SM_PS,
+				   WLAN_HT_CAP_SM_PS_DYNAMIC);
+	else
+		bcap->he_6ghz_capa |=
+			FIELD_PREP(IEEE80211_HE_6GHZ_CAP_SM_PS,
+				   WLAN_HT_CAP_SM_PS_DISABLED);
+	val = FIELD_GET(IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
+			pcap->vht_cap);
+	bcap->he_6ghz_capa |=
+		FIELD_PREP(IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP, val);
+	val = FIELD_GET(IEEE80211_VHT_CAP_MAX_MPDU_MASK, pcap->vht_cap);
+	bcap->he_6ghz_capa |=
+		FIELD_PREP(IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN, val);
+	if (pcap->vht_cap & IEEE80211_VHT_CAP_RX_ANTENNA_PATTERN)
+		bcap->he_6ghz_capa |= IEEE80211_HE_6GHZ_CAP_RX_ANTPAT_CONS;
+	if (pcap->vht_cap & IEEE80211_VHT_CAP_TX_ANTENNA_PATTERN)
+		bcap->he_6ghz_capa |= IEEE80211_HE_6GHZ_CAP_TX_ANTPAT_CONS;
+
+	return cpu_to_le16(bcap->he_6ghz_capa);
+}
+
 static int ath11k_mac_copy_he_cap(struct ath11k *ar,
 				  struct ath11k_pdev_cap *cap,
 				  struct ieee80211_sband_iftype_data *data,
@@ -3614,6 +3643,11 @@ static int ath11k_mac_copy_he_cap(struct ath11k *ar,
 		    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT)
 			ath11k_gen_ppe_thresh(&band_cap->he_ppet,
 					      he_cap->ppe_thres);
+
+		if (band == NL80211_BAND_6GHZ) {
+			data[idx].he_6ghz_capa.capa =
+				ath11k_mac_setup_he_6ghz_cap(cap, band_cap);
+		}
 		idx++;
 	}
 
-- 
2.7.4

