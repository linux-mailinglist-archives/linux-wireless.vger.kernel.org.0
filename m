Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30554447F8C
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Nov 2021 13:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbhKHMlV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Nov 2021 07:41:21 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:39385 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231529AbhKHMlV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Nov 2021 07:41:21 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636375117; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=YSgQqZ+Hm9QjVo2U12v1rsGze0V5cI8AQnix9P72WSI=; b=KO1tRFqfKb70CrZwTW28GqnBjjjkrzE0tDWLV3X6f1rRI1tk8vh5wYksyx2fSJ4gTkfmnrYE
 6jA1cDb1os8t4dOunDsCdsoqebkM921KqJqCH9QlBFh2HC0Nb0I2J9QZ/XQVqrL9LC5ej83m
 7+ZcmQgqFPe3d6U+vkt1H9BFGV4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 61891a48b882f8ab2fff6ac7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Nov 2021 12:38:32
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2A8B3C4338F; Mon,  8 Nov 2021 12:38:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AD601C4360D;
        Mon,  8 Nov 2021 12:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org AD601C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 2/2] ath11k: enable 802.11 power save mode in station mode
Date:   Mon,  8 Nov 2021 14:38:26 +0200
Message-Id: <20211108123826.8463-2-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211108123826.8463-1-kvalo@codeaurora.org>
References: <20211108123826.8463-1-kvalo@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

To reduce power consumption enable 802.11 power save mode in station mode. This
allows both radio and CPU to sleep more.

Only enable the mode on QCA6390 and WCN6855, it's unknown how other hardware
families support this feature.

To test that power save mode is running run "iw dev wls1 set power_save off",
check there is no NULL Data frame seen by a sniffer. And run "iw dev wls1 set power_save
on" and check there is a NULL Data frame in sniffer.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---

v2:

* improve commit log

* use existing ath11k_wmi_pdev_set_ps_mode()

* rename protocol_ps to supports_sta_ps

* cosmetic changes

 drivers/net/wireless/ath/ath11k/core.c |  5 ++
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/hw.h   |  1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 87 ++++++++++++++++++++++++++
 4 files changed, 94 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index b5a2af3ffc3e..a6c0d5ad7f9b 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -76,6 +76,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_monitor = true,
 		.supports_shadow_regs = false,
 		.idle_ps = false,
+		.supports_sta_ps = false,
 		.cold_boot_calib = true,
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
@@ -125,6 +126,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_monitor = true,
 		.supports_shadow_regs = false,
 		.idle_ps = false,
+		.supports_sta_ps = false,
 		.cold_boot_calib = true,
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
@@ -173,6 +175,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_monitor = false,
 		.supports_shadow_regs = true,
 		.idle_ps = true,
+		.supports_sta_ps = true,
 		.cold_boot_calib = false,
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
@@ -221,6 +224,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_monitor = true,
 		.supports_shadow_regs = false,
 		.idle_ps = false,
+		.supports_sta_ps = false,
 		.cold_boot_calib = false,
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9074),
@@ -269,6 +273,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_monitor = false,
 		.supports_shadow_regs = true,
 		.idle_ps = true,
+		.supports_sta_ps = true,
 		.cold_boot_calib = false,
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 31d234a51c79..2f1e10b7cc17 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -240,6 +240,7 @@ struct ath11k_vif {
 	bool is_started;
 	bool is_up;
 	bool spectral_enabled;
+	bool ps;
 	u32 aid;
 	u8 bssid[ETH_ALEN];
 	struct cfg80211_bitrate_mask bitrate_mask;
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 19223d36846e..1c298c24b617 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -170,6 +170,7 @@ struct ath11k_hw_params {
 	bool supports_monitor;
 	bool supports_shadow_regs;
 	bool idle_ps;
+	bool supports_sta_ps;
 	bool cold_boot_calib;
 	bool supports_suspend;
 	u32 hal_desc_sz;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index f6511fc8ae8c..82fd44f34df2 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1049,6 +1049,83 @@ static int ath11k_mac_monitor_stop(struct ath11k *ar)
 	return 0;
 }
 
+static int ath11k_mac_vif_setup_ps(struct ath11k_vif *arvif)
+{
+	struct ath11k *ar = arvif->ar;
+	struct ieee80211_vif *vif = arvif->vif;
+	struct ieee80211_conf *conf = &ar->hw->conf;
+	enum wmi_sta_powersave_param param;
+	enum wmi_sta_ps_mode psmode;
+	int ret;
+	int timeout;
+	bool enable_ps;
+
+	lockdep_assert_held(&arvif->ar->conf_mutex);
+
+	if (arvif->vif->type != NL80211_IFTYPE_STATION)
+		return 0;
+
+	enable_ps = arvif->ps;
+
+	if (!arvif->is_started) {
+		/* mac80211 can update vif powersave state while disconnected.
+		 * Firmware doesn't behave nicely and consumes more power than
+		 * necessary if PS is disabled on a non-started vdev. Hence
+		 * force-enable PS for non-running vdevs.
+		 */
+		psmode = WMI_STA_PS_MODE_ENABLED;
+	} else if (enable_ps) {
+		psmode = WMI_STA_PS_MODE_ENABLED;
+		param = WMI_STA_PS_PARAM_INACTIVITY_TIME;
+
+		timeout = conf->dynamic_ps_timeout;
+		if (timeout == 0) {
+			/* firmware doesn't like 0 */
+			timeout = ieee80211_tu_to_usec(vif->bss_conf.beacon_int) / 1000;
+		}
+
+		ret = ath11k_wmi_set_sta_ps_param(ar, arvif->vdev_id, param,
+						  timeout);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to set inactivity time for vdev %d: %i\n",
+				    arvif->vdev_id, ret);
+			return ret;
+		}
+	} else {
+		psmode = WMI_STA_PS_MODE_DISABLED;
+	}
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac vdev %d psmode %s\n",
+		   arvif->vdev_id, psmode ? "enable" : "disable");
+
+	ret = ath11k_wmi_pdev_set_ps_mode(ar, arvif->vdev_id, psmode);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to set sta power save mode %d for vdev %d: %d\n",
+			    psmode, arvif->vdev_id, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ath11k_mac_config_ps(struct ath11k *ar)
+{
+	struct ath11k_vif *arvif;
+	int ret = 0;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		ret = ath11k_mac_vif_setup_ps(arvif);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to setup powersave: %d\n", ret);
+			break;
+		}
+	}
+
+	return ret;
+}
+
 static int ath11k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
 {
 	struct ath11k *ar = hw->priv;
@@ -2942,6 +3019,16 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 		ath11k_mac_txpower_recalc(ar);
 	}
 
+	if (changed & BSS_CHANGED_PS &&
+	    ar->ab->hw_params.supports_sta_ps) {
+		arvif->ps = vif->bss_conf.ps;
+
+		ret = ath11k_mac_config_ps(ar);
+		if (ret)
+			ath11k_warn(ar->ab, "failed to setup ps on vdev %i: %d\n",
+				    arvif->vdev_id, ret);
+	}
+
 	if (changed & BSS_CHANGED_MCAST_RATE &&
 	    !ath11k_mac_vif_chan(arvif->vif, &def)) {
 		band = def.chan->band;
-- 
2.20.1

