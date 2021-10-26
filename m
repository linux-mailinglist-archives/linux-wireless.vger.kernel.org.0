Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353DE43B116
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 13:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbhJZLWW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Oct 2021 07:22:22 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:47817 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbhJZLWV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Oct 2021 07:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635247198; x=1666783198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M72rrJu6jvtu6sAzW8B4eMmtRyk9ZLkO4UK2qFnPAuM=;
  b=HuB/Ms0iK52am6Vj7NL+hBfGzGdCnrhqH+P+WrclnSPmyrIAbHMQSSQ9
   ZG7osrWRoyTL5bjmZ7S8nM8Dx0JTAguU9aTBoaw5sofsBpoI9yUck2enm
   2LCmafh/D4M/8op6JhlFdGBBO0f+rsHSBKWsrKBo5PtdIErwKWELXxV3t
   0=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 26 Oct 2021 04:19:58 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 04:19:58 -0700
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Tue, 26 Oct 2021 04:19:56 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH 07/15] ath11k: update regulatory rules when connect to AP on 6 GHz band for station
Date:   Tue, 26 Oct 2021 07:19:05 -0400
Message-ID: <20211026111913.7346-8-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026111913.7346-1-quic_wgong@quicinc.com>
References: <20211026111913.7346-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When station connect to AP on 6 GHz band, it need switch the regulatory
rules according to the regulatory info subfield in HE operation element.
Swith to the power type of AP for station mode.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index fbfc7f139854..76ccc99e77ae 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5590,6 +5590,8 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	struct ath11k_vif *arvif = (void *)vif->drv_priv;
 	int ret;
 	struct peer_create_params param;
+	struct cur_regulatory_info *reg_info;
+	enum ieee80211_ap_reg_power power_type;
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -5597,6 +5599,17 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		   "mac chanctx assign ptr %pK vdev_id %i\n",
 		   ctx, arvif->vdev_id);
 
+	if (ar->supports_6ghz && ctx->def.chan->band == NL80211_BAND_6GHZ &&
+	    arvif->vdev_type == WMI_VDEV_TYPE_STA) {
+		reg_info = &ab->reg_info_store[ar->pdev_idx];
+		power_type = vif->bss_conf.power_type;
+		ath11k_dbg(ab, ATH11K_DBG_MAC, "mac chanctx power type %d\n",
+			   power_type);
+		if (power_type == IEEE80211_REG_UNSET_AP)
+			power_type = IEEE80211_REG_LPI_AP;
+		ath11k_reg_handle_chan_list(ab, reg_info, power_type);
+	}
+
 	/* for QCA6390 bss peer must be created before vdev_start */
 	if (ab->hw_params.vdev_start_delay &&
 	    arvif->vdev_type != WMI_VDEV_TYPE_AP &&
-- 
2.31.1

