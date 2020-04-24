Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376841B8226
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 00:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgDXWmj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 18:42:39 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:50737 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726112AbgDXWmj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 18:42:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587768158; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=agUELOV9lipNsFvH/nyiWApqAJhfdAC9LPNeRPNoYZ0=; b=pGh2eqP35DrGzLduFMhZmphrYne9e8Mo7tSPqtDVo2kyCDTtK6rMO+Si3Mq8JpORgmA4F/ys
 /JICoY6w8jZBzvc0eUM827DoO4/YWVm6kVqJNOD2FXJYyyjcYYAubZJ+GoxZG+b/+BGUB6YA
 RXy5bY8PCakV8f3YxVGs7CvU2Qo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea36b55.7f006ae200a0-smtp-out-n02;
 Fri, 24 Apr 2020 22:42:29 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CD26DC433D2; Fri, 24 Apr 2020 22:42:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F2B9C433CB;
        Fri, 24 Apr 2020 22:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F2B9C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH 10/10] ath11k: build HE 6 GHz capability
Date:   Fri, 24 Apr 2020 15:41:48 -0700
Message-Id: <1587768108-25248-11-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587768108-25248-1-git-send-email-rmanohar@codeaurora.org>
References: <1587768108-25248-1-git-send-email-rmanohar@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Build 6 GHz band capability from HT and VHT capabilities reported
by firmware.

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 6e7b8ecd09a6..730829eaee23 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -537,6 +537,7 @@ struct ath11k_band_cap {
 	u32 he_mcs;
 	u32 he_cap_phy_info[PSOC_HOST_MAX_PHY_SIZE];
 	struct ath11k_ppe_threshold he_ppet;
+	u32 he_6ghz_cap;
 };
 
 struct ath11k_pdev_cap {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 06d063274eea..eb4dc6fc4209 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3522,6 +3522,32 @@ ath11k_mac_filter_he_cap_mesh(struct ieee80211_he_cap_elem *he_cap_elem)
 	he_cap_elem->phy_cap_info[9] &= ~m;
 }
 
+static u16 ath11k_mac_setup_he_6ghz_cap(struct ath11k_pdev_cap *pcap,
+					struct ath11k_band_cap *bcap)
+{
+	bcap->he_6ghz_cap = IEEE80211_HT_MPDU_DENSITY_NONE;
+	if (bcap->ht_cap_info & WMI_HT_CAP_DYNAMIC_SMPS)
+		bcap->he_6ghz_cap |=
+			FIELD_PREP(IEEE80211_HE_6GHZ_CAP_SMPS_MASK,
+				   WLAN_HT_CAP_SM_PS_DYNAMIC);
+	bcap->he_6ghz_cap |=
+	   FIELD_PREP(IEEE80211_HE_6GHZ_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
+		FIELD_GET(IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
+			  pcap->vht_cap));
+	bcap->he_6ghz_cap |=
+		FIELD_PREP(IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LENGTH_MASK,
+			   FIELD_GET(IEEE80211_VHT_CAP_MAX_MPDU_MASK,
+				     pcap->vht_cap));
+	if (pcap->vht_cap & IEEE80211_VHT_CAP_RX_ANTENNA_PATTERN)
+		bcap->he_6ghz_cap |=
+			IEEE80211_HE_6GHZ_CAP_RX_ANTENNA_PATTERN;
+	if (pcap->vht_cap & IEEE80211_VHT_CAP_TX_ANTENNA_PATTERN)
+		bcap->he_6ghz_cap |=
+			IEEE80211_HE_6GHZ_CAP_TX_ANTENNA_PATTERN;
+
+	return bcap->he_6ghz_cap;
+}
+
 static int ath11k_mac_copy_he_cap(struct ath11k *ar,
 				  struct ath11k_pdev_cap *cap,
 				  struct ieee80211_sband_iftype_data *data,
@@ -3602,6 +3628,10 @@ static int ath11k_mac_copy_he_cap(struct ath11k *ar,
 		    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT)
 			ath11k_gen_ppe_thresh(&band_cap->he_ppet,
 					      he_cap->ppe_thres);
+
+		if (band == NL80211_BAND_6GHZ)
+			he_cap->he_6ghz_cap =
+				ath11k_mac_setup_he_6ghz_cap(cap, band_cap);
 		idx++;
 	}
 
-- 
2.7.4
