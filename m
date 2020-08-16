Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F8D24561C
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Aug 2020 07:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbgHPFbp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Aug 2020 01:31:45 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52995 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730068AbgHPFbp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Aug 2020 01:31:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597555904; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Ult71+8x1p3sF4qts7ZK4yHs1B9J1hXmY1Bvwnj+JhI=; b=xZVkTrhlHZK7ULxBRRKAWWl5tDvbTPDhLRyv/rktDBq5nMXnPhy/U9RvQEM2YiSh7e8KnFUs
 qcKPFmtgMjkGY2gr2eTzPWh/5I5eaB2BW5vLkULVcAb52maGN5ELxz6VEyaOB1+LUWRHRXSB
 VH225ghhdn0Nr124LodzOW7+6NU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f38c4c091f8def8b2c29b47 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 16 Aug 2020 05:31:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B5BD6C43395; Sun, 16 Aug 2020 05:31:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 27AB9C433CA;
        Sun, 16 Aug 2020 05:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27AB9C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 5/9] ath11k: delay vdev_start for QCA6390
Date:   Sun, 16 Aug 2020 08:31:27 +0300
Message-Id: <1597555891-26112-6-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597555891-26112-1-git-send-email-kvalo@codeaurora.org>
References: <1597555891-26112-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

For QCA6390 firmware, bss peer must be created before vdev_start, so delay
vdev_start until bss peer is created.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c |  2 ++
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/hw.h   |  1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 51 ++++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index e583b1492eca..c469904057f9 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -40,6 +40,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.rxdma1_enable = true,
 		.num_rxmda_per_pdev = 1,
 		.rx_mac_buf_ring = false,
+		.vdev_start_delay = false,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -62,6 +63,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.rxdma1_enable = false,
 		.num_rxmda_per_pdev = 2,
 		.rx_mac_buf_ring = true,
+		.vdev_start_delay = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index f623f357aa33..d21191c51e10 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -217,6 +217,7 @@ struct ath11k_vif {
 	int txpower;
 	bool rsnie_present;
 	bool wpaie_present;
+	struct ieee80211_chanctx_conf chanctx;
 };
 
 struct ath11k_vif_iter {
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 1a8f63e789a0..cac6cd3c4c57 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -149,6 +149,7 @@ struct ath11k_hw_params {
 	bool rxdma1_enable;
 	int num_rxmda_per_pdev;
 	bool rx_mac_buf_ring;
+	bool vdev_start_delay;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 5aae1ec27e9f..9759a5db39fc 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -244,6 +244,9 @@ static const u32 ath11k_smps_map[] = {
 	[WLAN_HT_CAP_SM_PS_DISABLED] = WMI_PEER_SMPS_PS_NONE,
 };
 
+static int ath11k_start_vdev_delay(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif);
+
 u8 ath11k_mac_bw_to_mac80211_bw(u8 bw)
 {
 	u8 ret = 0;
@@ -2960,6 +2963,14 @@ static int ath11k_mac_station_add(struct ath11k *ar,
 		goto free_tx_stats;
 	}
 
+	if (ab->hw_params.vdev_start_delay) {
+		ret = ath11k_start_vdev_delay(ar->hw, vif);
+		if (ret) {
+			ath11k_warn(ab, "failed to delay vdev start: %d\n", ret);
+			goto free_tx_stats;
+		}
+	}
+
 	return 0;
 
 free_tx_stats:
@@ -5116,6 +5127,39 @@ static void ath11k_mac_op_change_chanctx(struct ieee80211_hw *hw,
 	mutex_unlock(&ar->conf_mutex);
 }
 
+static int ath11k_start_vdev_delay(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif)
+{
+	struct ath11k *ar = hw->priv;
+	struct ath11k_base *ab = ar->ab;
+	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	int ret;
+
+	if (WARN_ON(arvif->is_started))
+		return -EBUSY;
+
+	ret = ath11k_mac_vdev_start(arvif, &arvif->chanctx.def);
+	if (ret) {
+		ath11k_warn(ab, "failed to start vdev %i addr %pM on freq %d: %d\n",
+			    arvif->vdev_id, vif->addr,
+			    arvif->chanctx.def.chan->center_freq, ret);
+		return ret;
+	}
+
+	if (arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
+		ret = ath11k_monitor_vdev_up(ar, arvif->vdev_id);
+		if (ret) {
+			ath11k_warn(ab, "failed put monitor up: %d\n", ret);
+			return ret;
+		}
+	}
+
+	arvif->is_started = true;
+
+	/* TODO: Setup ps and cts/rts protection */
+	return 0;
+}
+
 static int
 ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
@@ -5132,6 +5176,13 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		   "mac chanctx assign ptr %pK vdev_id %i\n",
 		   ctx, arvif->vdev_id);
 
+	/* for QCA6390 bss peer must be created before vdev_start */
+	if (ab->hw_params.vdev_start_delay) {
+		memcpy(&arvif->chanctx, ctx, sizeof(*ctx));
+		mutex_unlock(&ar->conf_mutex);
+		return 0;
+	}
+
 	if (WARN_ON(arvif->is_started)) {
 		mutex_unlock(&ar->conf_mutex);
 		return -EBUSY;
-- 
2.7.4

