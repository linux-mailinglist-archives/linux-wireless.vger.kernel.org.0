Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B38A79F966
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Sep 2023 06:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbjINEGJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Sep 2023 00:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbjINEFu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Sep 2023 00:05:50 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A35571FE2;
        Wed, 13 Sep 2023 21:05:42 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 5DCBC605FCF3C;
        Thu, 14 Sep 2023 12:05:40 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     toke@toke.dk, kvalo@kernel.org, afaerber@suse.de, mani@kernel.org
Cc:     linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
Subject: [PATCH wireless-next 9/9] wifi: ath9k: Remove unnecessary (void*) conversions
Date:   Thu, 14 Sep 2023 12:05:39 +0800
Message-Id: <20230914040539.1170268-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

No need cast (void *) to (struct owl_ctx *), (struct ath_hw *),
(struct cmd_buf *) or other types.

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
---
 .../wireless/ath/ath9k/ath9k_pci_owl_loader.c |  2 +-
 drivers/net/wireless/ath/ath9k/common-init.c  |  2 +-
 .../net/wireless/ath/ath9k/common-spectral.c  |  2 +-
 drivers/net/wireless/ath/ath9k/debug.c        |  2 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c      | 10 +++---
 .../net/wireless/ath/ath9k/htc_drv_debug.c    |  2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_init.c | 36 +++++++++----------
 drivers/net/wireless/ath/ath9k/htc_hst.c      |  2 +-
 drivers/net/wireless/ath/ath9k/init.c         | 12 +++----
 drivers/net/wireless/ath/ath9k/link.c         |  2 +-
 10 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c b/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
index 708c8969b503..a5eb43f30320 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
+++ b/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
@@ -125,7 +125,7 @@ static void owl_rescan(struct pci_dev *pdev)
 
 static void owl_fw_cb(const struct firmware *fw, void *context)
 {
-	struct owl_ctx *ctx = (struct owl_ctx *)context;
+	struct owl_ctx *ctx = context;
 
 	complete(&ctx->eeprom_load);
 
diff --git a/drivers/net/wireless/ath/ath9k/common-init.c b/drivers/net/wireless/ath/ath9k/common-init.c
index 82de0fadbc95..7c13a1deb3ac 100644
--- a/drivers/net/wireless/ath/ath9k/common-init.c
+++ b/drivers/net/wireless/ath/ath9k/common-init.c
@@ -124,7 +124,7 @@ static struct ieee80211_rate ath9k_legacy_rates[] = {
 
 int ath9k_cmn_init_channels_rates(struct ath_common *common)
 {
-	struct ath_hw *ah = (struct ath_hw *)common->ah;
+	struct ath_hw *ah = common->ah;
 	void *channels;
 
 	BUILD_BUG_ON(ARRAY_SIZE(ath9k_2ghz_chantable) +
diff --git a/drivers/net/wireless/ath/ath9k/common-spectral.c b/drivers/net/wireless/ath/ath9k/common-spectral.c
index a5349c72c332..4b27445a5fb8 100644
--- a/drivers/net/wireless/ath/ath9k/common-spectral.c
+++ b/drivers/net/wireless/ath/ath9k/common-spectral.c
@@ -471,7 +471,7 @@ int ath_cmn_process_fft(struct ath_spec_scan_priv *spec_priv, struct ieee80211_h
 	u8 sample_buf[SPECTRAL_SAMPLE_MAX_LEN] = {0};
 	struct ath_hw *ah = spec_priv->ah;
 	struct ath_common *common = ath9k_hw_common(spec_priv->ah);
-	struct ath_softc *sc = (struct ath_softc *)common->priv;
+	struct ath_softc *sc = common->priv;
 	u8 num_bins, *vdata = (u8 *)hdr;
 	struct ath_radar_info *radar_info;
 	int len = rs->rs_datalen;
diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/ath/ath9k/debug.c
index 9bc57c5a89bf..d91f46844d32 100644
--- a/drivers/net/wireless/ath/ath9k/debug.c
+++ b/drivers/net/wireless/ath/ath9k/debug.c
@@ -1376,7 +1376,7 @@ void ath9k_deinit_debug(struct ath_softc *sc)
 int ath9k_init_debug(struct ath_hw *ah)
 {
 	struct ath_common *common = ath9k_hw_common(ah);
-	struct ath_softc *sc = (struct ath_softc *) common->priv;
+	struct ath_softc *sc = common->priv;
 
 	sc->debug.debugfs_phy = debugfs_create_dir("ath9k",
 						   sc->hw->wiphy->debugfsdir);
diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index e5414435b141..ce79f98738e3 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -70,7 +70,7 @@ static int __hif_usb_tx(struct hif_device_usb *hif_dev);
 
 static void hif_usb_regout_cb(struct urb *urb)
 {
-	struct cmd_buf *cmd = (struct cmd_buf *)urb->context;
+	struct cmd_buf *cmd = urb->context;
 
 	switch (urb->status) {
 	case 0:
@@ -134,7 +134,7 @@ static int hif_usb_send_regout(struct hif_device_usb *hif_dev,
 
 static void hif_usb_mgmt_cb(struct urb *urb)
 {
-	struct cmd_buf *cmd = (struct cmd_buf *)urb->context;
+	struct cmd_buf *cmd = urb->context;
 	struct hif_device_usb *hif_dev;
 	unsigned long flags;
 	bool txok = true;
@@ -252,7 +252,7 @@ static inline void ath9k_skb_queue_complete(struct hif_device_usb *hif_dev,
 
 static void hif_usb_tx_cb(struct urb *urb)
 {
-	struct tx_buf *tx_buf = (struct tx_buf *) urb->context;
+	struct tx_buf *tx_buf = urb->context;
 	struct hif_device_usb *hif_dev;
 	bool txok = true;
 
@@ -687,7 +687,7 @@ static void ath9k_hif_usb_rx_stream(struct hif_device_usb *hif_dev,
 
 static void ath9k_hif_usb_rx_cb(struct urb *urb)
 {
-	struct rx_buf *rx_buf = (struct rx_buf *)urb->context;
+	struct rx_buf *rx_buf = urb->context;
 	struct hif_device_usb *hif_dev = rx_buf->hif_dev;
 	struct sk_buff *skb = rx_buf->skb;
 	int ret;
@@ -734,7 +734,7 @@ static void ath9k_hif_usb_rx_cb(struct urb *urb)
 
 static void ath9k_hif_usb_reg_in_cb(struct urb *urb)
 {
-	struct rx_buf *rx_buf = (struct rx_buf *)urb->context;
+	struct rx_buf *rx_buf = urb->context;
 	struct hif_device_usb *hif_dev = rx_buf->hif_dev;
 	struct sk_buff *skb = rx_buf->skb;
 	int ret;
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
index c549ff3abcdc..569792dc4450 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
@@ -482,7 +482,7 @@ void ath9k_htc_deinit_debug(struct ath9k_htc_priv *priv)
 int ath9k_htc_init_debug(struct ath_hw *ah)
 {
 	struct ath_common *common = ath9k_hw_common(ah);
-	struct ath9k_htc_priv *priv = (struct ath9k_htc_priv *) common->priv;
+	struct ath9k_htc_priv *priv = common->priv;
 
 	priv->debug.debugfs_phy = debugfs_create_dir(KBUILD_MODNAME,
 					     priv->hw->wiphy->debugfsdir);
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_init.c b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
index dae3d9c7b640..0aa5bdeb44a1 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_init.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
@@ -63,12 +63,12 @@ static const struct ieee80211_tpt_blink ath9k_htc_tpt_blink[] = {
 
 static void ath9k_htc_op_ps_wakeup(struct ath_common *common)
 {
-	ath9k_htc_ps_wakeup((struct ath9k_htc_priv *) common->priv);
+	ath9k_htc_ps_wakeup(common->priv);
 }
 
 static void ath9k_htc_op_ps_restore(struct ath_common *common)
 {
-	ath9k_htc_ps_restore((struct ath9k_htc_priv *) common->priv);
+	ath9k_htc_ps_restore(common->priv);
 }
 
 static const struct ath_ps_ops ath9k_htc_ps_ops = {
@@ -235,7 +235,7 @@ static unsigned int ath9k_regread(void *hw_priv, u32 reg_offset)
 {
 	struct ath_hw *ah = hw_priv;
 	struct ath_common *common = ath9k_hw_common(ah);
-	struct ath9k_htc_priv *priv = (struct ath9k_htc_priv *) common->priv;
+	struct ath9k_htc_priv *priv = common->priv;
 	__be32 val, reg = cpu_to_be32(reg_offset);
 	int r;
 
@@ -257,7 +257,7 @@ static void ath9k_multi_regread(void *hw_priv, u32 *addr,
 {
 	struct ath_hw *ah = hw_priv;
 	struct ath_common *common = ath9k_hw_common(ah);
-	struct ath9k_htc_priv *priv = (struct ath9k_htc_priv *) common->priv;
+	struct ath9k_htc_priv *priv = common->priv;
 	__be32 tmpaddr[8];
 	__be32 tmpval[8];
 	int i, ret;
@@ -282,7 +282,7 @@ static void ath9k_multi_regread(void *hw_priv, u32 *addr,
 
 static void ath9k_regwrite_multi(struct ath_common *common)
 {
-	struct ath9k_htc_priv *priv = (struct ath9k_htc_priv *) common->priv;
+	struct ath9k_htc_priv *priv = common->priv;
 	u32 rsp_status;
 	int r;
 
@@ -303,7 +303,7 @@ static void ath9k_regwrite_single(void *hw_priv, u32 val, u32 reg_offset)
 {
 	struct ath_hw *ah = hw_priv;
 	struct ath_common *common = ath9k_hw_common(ah);
-	struct ath9k_htc_priv *priv = (struct ath9k_htc_priv *) common->priv;
+	struct ath9k_htc_priv *priv = common->priv;
 	const __be32 buf[2] = {
 		cpu_to_be32(reg_offset),
 		cpu_to_be32(val),
@@ -324,7 +324,7 @@ static void ath9k_regwrite_buffer(void *hw_priv, u32 val, u32 reg_offset)
 {
 	struct ath_hw *ah = hw_priv;
 	struct ath_common *common = ath9k_hw_common(ah);
-	struct ath9k_htc_priv *priv = (struct ath9k_htc_priv *) common->priv;
+	struct ath9k_htc_priv *priv = common->priv;
 
 	mutex_lock(&priv->wmi->multi_write_mutex);
 
@@ -347,7 +347,7 @@ static void ath9k_regwrite(void *hw_priv, u32 val, u32 reg_offset)
 {
 	struct ath_hw *ah = hw_priv;
 	struct ath_common *common = ath9k_hw_common(ah);
-	struct ath9k_htc_priv *priv = (struct ath9k_htc_priv *) common->priv;
+	struct ath9k_htc_priv *priv = common->priv;
 
 	if (atomic_read(&priv->wmi->mwrite_cnt))
 		ath9k_regwrite_buffer(hw_priv, val, reg_offset);
@@ -359,7 +359,7 @@ static void ath9k_enable_regwrite_buffer(void *hw_priv)
 {
 	struct ath_hw *ah = hw_priv;
 	struct ath_common *common = ath9k_hw_common(ah);
-	struct ath9k_htc_priv *priv = (struct ath9k_htc_priv *) common->priv;
+	struct ath9k_htc_priv *priv = common->priv;
 
 	atomic_inc(&priv->wmi->mwrite_cnt);
 }
@@ -368,7 +368,7 @@ static void ath9k_regwrite_flush(void *hw_priv)
 {
 	struct ath_hw *ah = hw_priv;
 	struct ath_common *common = ath9k_hw_common(ah);
-	struct ath9k_htc_priv *priv = (struct ath9k_htc_priv *) common->priv;
+	struct ath9k_htc_priv *priv = common->priv;
 
 	atomic_dec(&priv->wmi->mwrite_cnt);
 
@@ -385,7 +385,7 @@ static void ath9k_reg_rmw_buffer(void *hw_priv,
 {
 	struct ath_hw *ah = hw_priv;
 	struct ath_common *common = ath9k_hw_common(ah);
-	struct ath9k_htc_priv *priv = (struct ath9k_htc_priv *) common->priv;
+	struct ath9k_htc_priv *priv = common->priv;
 	u32 rsp_status;
 	int r;
 
@@ -423,7 +423,7 @@ static void ath9k_reg_rmw_flush(void *hw_priv)
 {
 	struct ath_hw *ah = hw_priv;
 	struct ath_common *common = ath9k_hw_common(ah);
-	struct ath9k_htc_priv *priv = (struct ath9k_htc_priv *) common->priv;
+	struct ath9k_htc_priv *priv = common->priv;
 	u32 rsp_status;
 	int r;
 
@@ -455,7 +455,7 @@ static void ath9k_enable_rmw_buffer(void *hw_priv)
 {
 	struct ath_hw *ah = hw_priv;
 	struct ath_common *common = ath9k_hw_common(ah);
-	struct ath9k_htc_priv *priv = (struct ath9k_htc_priv *) common->priv;
+	struct ath9k_htc_priv *priv = common->priv;
 
 	if (test_bit(HTC_FWFLAG_NO_RMW, &priv->fw_flags))
 		return;
@@ -468,7 +468,7 @@ static void ath9k_reg_rmw_single(void *hw_priv,
 {
 	struct ath_hw *ah = hw_priv;
 	struct ath_common *common = ath9k_hw_common(ah);
-	struct ath9k_htc_priv *priv = (struct ath9k_htc_priv *) common->priv;
+	struct ath9k_htc_priv *priv = common->priv;
 	struct register_rmw buf, buf_ret;
 	int ret;
 
@@ -490,7 +490,7 @@ static u32 ath9k_reg_rmw(void *hw_priv, u32 reg_offset, u32 set, u32 clr)
 {
 	struct ath_hw *ah = hw_priv;
 	struct ath_common *common = ath9k_hw_common(ah);
-	struct ath9k_htc_priv *priv = (struct ath9k_htc_priv *) common->priv;
+	struct ath9k_htc_priv *priv = common->priv;
 
 	if (test_bit(HTC_FWFLAG_NO_RMW, &priv->fw_flags)) {
 		u32 val;
@@ -518,7 +518,7 @@ static void ath_usb_read_cachesize(struct ath_common *common, int *csz)
 
 static bool ath_usb_eeprom_read(struct ath_common *common, u32 off, u16 *data)
 {
-	struct ath_hw *ah = (struct ath_hw *) common->ah;
+	struct ath_hw *ah = common->ah;
 
 	(void)REG_READ(ah, AR5416_EEPROM_OFFSET + (off << AR5416_EEPROM_S));
 
@@ -970,7 +970,7 @@ int ath9k_htc_probe_device(struct htc_target *htc_handle, struct device *dev,
 
 err_init:
 	ath9k_stop_wmi(priv);
-	hif_dev = (struct hif_device_usb *)htc_handle->hif_dev;
+	hif_dev = htc_handle->hif_dev;
 	ath9k_hif_usb_dealloc_urbs(hif_dev);
 	ath9k_destroy_wmi(priv);
 err_free:
@@ -988,7 +988,7 @@ void ath9k_htc_disconnect_device(struct htc_target *htc_handle, bool hotunplug)
 
 		ath9k_deinit_device(htc_handle->drv_priv);
 		ath9k_stop_wmi(htc_handle->drv_priv);
-		ath9k_hif_usb_dealloc_urbs((struct hif_device_usb *)htc_handle->hif_dev);
+		ath9k_hif_usb_dealloc_urbs(htc_handle->hif_dev);
 		ath9k_destroy_wmi(htc_handle->drv_priv);
 		ieee80211_free_hw(htc_handle->drv_priv->hw);
 	}
diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index 99667aba289d..eb631fd3336d 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -89,7 +89,7 @@ static void htc_process_target_rdy(struct htc_target *target,
 				   void *buf)
 {
 	struct htc_endpoint *endpoint;
-	struct htc_ready_msg *htc_ready_msg = (struct htc_ready_msg *) buf;
+	struct htc_ready_msg *htc_ready_msg = buf;
 
 	target->credit_size = be16_to_cpu(htc_ready_msg->credit_size);
 
diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index 4f00400c7ffb..7fad7e75af6a 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -151,12 +151,12 @@ static void ath9k_deinit_softc(struct ath_softc *sc);
 
 static void ath9k_op_ps_wakeup(struct ath_common *common)
 {
-	ath9k_ps_wakeup((struct ath_softc *) common->priv);
+	ath9k_ps_wakeup(common->priv);
 }
 
 static void ath9k_op_ps_restore(struct ath_common *common)
 {
-	ath9k_ps_restore((struct ath_softc *) common->priv);
+	ath9k_ps_restore(common->priv);
 }
 
 static const struct ath_ps_ops ath9k_ps_ops = {
@@ -174,7 +174,7 @@ static void ath9k_iowrite32(void *hw_priv, u32 val, u32 reg_offset)
 {
 	struct ath_hw *ah = hw_priv;
 	struct ath_common *common = ath9k_hw_common(ah);
-	struct ath_softc *sc = (struct ath_softc *) common->priv;
+	struct ath_softc *sc = common->priv;
 
 	if (NR_CPUS > 1 && ah->config.serialize_regmode == SER_REG_MODE_ON) {
 		unsigned long flags;
@@ -189,7 +189,7 @@ static unsigned int ath9k_ioread32(void *hw_priv, u32 reg_offset)
 {
 	struct ath_hw *ah = hw_priv;
 	struct ath_common *common = ath9k_hw_common(ah);
-	struct ath_softc *sc = (struct ath_softc *) common->priv;
+	struct ath_softc *sc = common->priv;
 	u32 val;
 
 	if (NR_CPUS > 1 && ah->config.serialize_regmode == SER_REG_MODE_ON) {
@@ -229,7 +229,7 @@ static unsigned int ath9k_reg_rmw(void *hw_priv, u32 reg_offset, u32 set, u32 cl
 {
 	struct ath_hw *ah = hw_priv;
 	struct ath_common *common = ath9k_hw_common(ah);
-	struct ath_softc *sc = (struct ath_softc *) common->priv;
+	struct ath_softc *sc = common->priv;
 	unsigned long flags;
 	u32 val;
 
@@ -608,7 +608,7 @@ static int ath9k_nvmem_request_eeprom(struct ath_softc *sc)
 	}
 
 	/* devres manages the calibration values release on shutdown */
-	ah->nvmem_blob = (u16 *)devm_kmemdup(sc->dev, buf, len, GFP_KERNEL);
+	ah->nvmem_blob = devm_kmemdup(sc->dev, buf, len, GFP_KERNEL);
 	kfree(buf);
 	if (!ah->nvmem_blob)
 		return -ENOMEM;
diff --git a/drivers/net/wireless/ath/ath9k/link.c b/drivers/net/wireless/ath/ath9k/link.c
index 9d84003db800..d1e5767aab3c 100644
--- a/drivers/net/wireless/ath/ath9k/link.c
+++ b/drivers/net/wireless/ath/ath9k/link.c
@@ -304,7 +304,7 @@ void ath_paprd_calibrate(struct work_struct *work)
 void ath_ani_calibrate(struct timer_list *t)
 {
 	struct ath_common *common = from_timer(common, t, ani.timer);
-	struct ath_softc *sc = (struct ath_softc *)common->priv;
+	struct ath_softc *sc = common->priv;
 	struct ath_hw *ah = sc->sc_ah;
 	bool longcal = false;
 	bool shortcal = false;
-- 
2.30.2

