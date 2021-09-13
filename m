Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778FB409B4D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 19:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbhIMR5E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 13:57:04 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:11510 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhIMR5B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 13:57:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631555744; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=4lG+14AjO4exeuH4NX4A70HcE5SBnuRaGtpVJmPEi1o=; b=RgI/XhFvjWfEfCrNwPZykruqfTCH1QcvCbdegd+MGdsmnh9R2lsIODanOiq+dZgMJCz+fUQr
 EzY1WbfDp84jvzgDUb23Ok1LXMh1n4eexj6hvhmT8M5jW5wMESDcku3KGWbnEsKAZkQoSo6k
 f9vxpqtNsvj+XxfN1f5MIsvV11E=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 613f9095648642cc1c69296a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Sep 2021 17:55:33
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6D58AC43460; Mon, 13 Sep 2021 17:55:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-72-211-nat.elisa-mobile.fi [85.76.72.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B1EC4C4338F;
        Mon, 13 Sep 2021 17:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org B1EC4C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 3/3] ath11k: support SMPS configuration for 6 GHz
Date:   Mon, 13 Sep 2021 20:55:10 +0300
Message-Id: <20210913175510.193005-3-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913175510.193005-1-jouni@codeaurora.org>
References: <20210913175510.193005-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>

Parse SMPS configuration from IEs and configure. Without this,
SMPS is not enabled for 6 GHz band.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01386-QCAHKSWPL_SILICONZ-1

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 31 ++++++++++++++++++---------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index aba005241095..155ca6af1b45 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2012,11 +2012,16 @@ static void ath11k_peer_assoc_h_smps(struct ieee80211_sta *sta,
 	const struct ieee80211_sta_ht_cap *ht_cap = &sta->ht_cap;
 	int smps;
 
-	if (!ht_cap->ht_supported)
+	if (!ht_cap->ht_supported && !sta->he_6ghz_capa.capa)
 		return;
 
-	smps = ht_cap->cap & IEEE80211_HT_CAP_SM_PS;
-	smps >>= IEEE80211_HT_CAP_SM_PS_SHIFT;
+	if (ht_cap->ht_supported) {
+		smps = ht_cap->cap & IEEE80211_HT_CAP_SM_PS;
+		smps >>= IEEE80211_HT_CAP_SM_PS_SHIFT;
+	} else {
+		smps = FIELD_GET(IEEE80211_HE_6GHZ_CAP_SM_PS,
+				 le16_to_cpu(sta->he_6ghz_capa.capa));
+	}
 
 	switch (smps) {
 	case WLAN_HT_CAP_SM_PS_STATIC:
@@ -2304,15 +2309,20 @@ static void ath11k_peer_assoc_prepare(struct ath11k *ar,
 
 static int ath11k_setup_peer_smps(struct ath11k *ar, struct ath11k_vif *arvif,
 				  const u8 *addr,
-				  const struct ieee80211_sta_ht_cap *ht_cap)
+				  const struct ieee80211_sta_ht_cap *ht_cap,
+				  u16 he_6ghz_capa)
 {
 	int smps;
 
-	if (!ht_cap->ht_supported)
+	if (!ht_cap->ht_supported && !he_6ghz_capa)
 		return 0;
 
-	smps = ht_cap->cap & IEEE80211_HT_CAP_SM_PS;
-	smps >>= IEEE80211_HT_CAP_SM_PS_SHIFT;
+	if (ht_cap->ht_supported) {
+		smps = ht_cap->cap & IEEE80211_HT_CAP_SM_PS;
+		smps >>= IEEE80211_HT_CAP_SM_PS_SHIFT;
+	} else {
+		smps = FIELD_GET(IEEE80211_HE_6GHZ_CAP_SM_PS, he_6ghz_capa);
+	}
 
 	if (smps >= ARRAY_SIZE(ath11k_smps_map))
 		return -EINVAL;
@@ -2366,7 +2376,8 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 	}
 
 	ret = ath11k_setup_peer_smps(ar, arvif, bss_conf->bssid,
-				     &ap_sta->ht_cap);
+				     &ap_sta->ht_cap,
+				     le16_to_cpu(ap_sta->he_6ghz_capa.capa));
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to setup peer SMPS for vdev %d: %d\n",
 			    arvif->vdev_id, ret);
@@ -3656,7 +3667,7 @@ static int ath11k_station_assoc(struct ath11k *ar,
 		return 0;
 
 	ret = ath11k_setup_peer_smps(ar, arvif, sta->addr,
-				     &sta->ht_cap);
+				     &sta->ht_cap, le16_to_cpu(sta->he_6ghz_capa.capa));
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to setup peer SMPS for vdev %d: %d\n",
 			    arvif->vdev_id, ret);
@@ -7559,7 +7570,7 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	 * for each band for a dual band capable radio. It will be tricky to
 	 * handle it when the ht capability different for each band.
 	 */
-	if (ht_cap & WMI_HT_CAP_DYNAMIC_SMPS)
+	if (ht_cap & WMI_HT_CAP_DYNAMIC_SMPS || ar->supports_6ghz)
 		ar->hw->wiphy->features |= NL80211_FEATURE_DYNAMIC_SMPS;
 
 	ar->hw->wiphy->max_scan_ssids = WLAN_SCAN_PARAMS_MAX_SSID;
-- 
2.25.1

