Return-Path: <linux-wireless+bounces-25954-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA976B0FB55
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 22:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F3F47B2D98
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 20:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B72021D5AE;
	Wed, 23 Jul 2025 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPIJSCjR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D800420DD42;
	Wed, 23 Jul 2025 20:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753301871; cv=none; b=aBA6EyIRQvZDuMO+WqPstdRjHvLNE36UReJlBF6oYbGs6rTp91YOctftDekkr9O8sBdlRKX80k7vaE8ZQ3WtcftYffEZIN5Xd/wiiLVX6AgHfBDwc9dUULSt12S3XmHYAzQuZsp0ao8j4TJhJzhdIgiJAOk9k5iTjroQsk3FQrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753301871; c=relaxed/simple;
	bh=GZ5otWIEFfMHAI7a4VW7abVJrNi+wW30wpGXZd5Gu3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YgCtFCkXV2T3k70gx41pphF4W0cI4NcpOlX7X+UK7E4FFAHiEzbAsjXGaDZ3vwtuNLSOxIP3ox88TX36FhvdCw7kHFvLOWzM0fNwaHn2JASAOxqr2GT6NvlMVffmT0SdsMi9lEXa9hMJ2WB+Jl66mJcB6Z2mlXNUBjKdev19D8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPIJSCjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412FBC4CEE7;
	Wed, 23 Jul 2025 20:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753301871;
	bh=GZ5otWIEFfMHAI7a4VW7abVJrNi+wW30wpGXZd5Gu3Q=;
	h=From:To:Cc:Subject:Date:From;
	b=oPIJSCjRj/0eQppDDT7qe0i/Mxlw18XoYWJRuka0fwteaNtPR8c+u3RxShft0MpJ/
	 pzsAx6ZT6xbEyEgmc/Yt/Oy6MHmvckBmKqgrqDmaXav8eDZTGgxYy2kJ35SsQRY4u+
	 AZsZ++QG+P9IvqbZN5lwooduxXtYtMb7+PNxaeyGRrIDQ5SbdY5EOtIMH900SuDeDn
	 flu7KaDCKONWoWjISwHdQKDj5x7AB1PGtp9mrXEy4h5yJ7vEBnr64QM00kLOg9gZUv
	 bVW3GPFHL38jcQT8cJsAop+52gKRW+Q29OR367BaHUX2ix5QS8z9m/ibI1l4iEYuGd
	 eEq91WbP+Nv/g==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH net-next] wifi: Fix typos
Date: Wed, 23 Jul 2025 15:17:17 -0500
Message-ID: <20250723201741.2908456-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos in comments and error messages.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/net/wireless/ath/ath10k/hw.h          |  8 +++----
 drivers/net/wireless/ath/ath5k/reg.h          |  2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  6 ++---
 .../broadcom/brcm80211/brcmfmac/common.c      |  4 ++--
 .../broadcom/brcm80211/brcmfmac/common.h      |  4 ++--
 .../broadcom/brcm80211/brcmfmac/core.h        |  2 +-
 .../broadcom/brcm80211/brcmfmac/p2p.c         |  4 ++--
 .../net/wireless/intel/iwlegacy/commands.h    |  2 +-
 .../intel/iwlwifi/fw/api/time-event.h         |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  4 ++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  6 ++---
 drivers/net/wireless/intersil/p54/p54spi.c    |  4 ++--
 drivers/net/wireless/marvell/libertas/cfg.c   |  4 ++--
 drivers/net/wireless/marvell/mwifiex/fw.h     |  4 ++--
 .../net/wireless/ralink/rt2x00/rt2800lib.c    |  2 +-
 .../net/wireless/ralink/rt2x00/rt2x00dev.c    |  4 ++--
 .../net/wireless/ralink/rt2x00/rt2x00queue.c  |  2 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c  |  2 +-
 .../wireless/realtek/rtlwifi/rtl8192de/rf.c   |  2 +-
 .../wireless/realtek/rtlwifi/rtl8192se/rf.c   |  2 +-
 .../wireless/realtek/rtlwifi/rtl8821ae/hw.c   | 22 +++++++++----------
 drivers/net/wireless/ti/wl1251/reg.h          |  6 ++---
 drivers/net/wireless/ti/wl12xx/reg.h          |  6 ++---
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c  |  2 +-
 25 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index fec56b916497..da71dce9babf 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -473,8 +473,8 @@ enum ath10k_hw_cc_wraparound_type {
 	 */
 	ATH10K_HW_CC_WRAP_SHIFTED_ALL = 1,
 
-	/* Each hw counter wrapsaround independently. When the
-	 * counter overflows the repestive counter is right shifted
+	/* Each hw counter wraps around independently. When the
+	 * counter overflows the respective counter is right shifted
 	 * by 1, i.e reset to 0x7fffffff, and other counters will be
 	 * running unaffected. In this type of wraparound, it should
 	 * be possible to report accurate Rx busy time unlike the
@@ -837,7 +837,7 @@ ath10k_is_rssi_enable(struct ath10k_hw_params *hw,
 #define TARGET_10_4_NUM_TDLS_BUFFER_STA		1
 #define TARGET_10_4_NUM_TDLS_SLEEP_STA		1
 
-/* Maximum number of Copy Engine's supported */
+/* Maximum number of Copy Engines supported */
 #define CE_COUNT_MAX 12
 
 /* Number of Copy Engines supported */
@@ -1134,7 +1134,7 @@ ath10k_is_rssi_enable(struct ath10k_hw_params *hw,
 #define RTC_STATE_V_GET(x) (((x) & RTC_STATE_V_MASK) >> RTC_STATE_V_LSB)
 
 /* Register definitions for first generation ath10k cards. These cards include
- * a mac thich has a register allocation similar to ath9k and at least some
+ * a mac which has a register allocation similar to ath9k and at least some
  * registers including the ones relevant for modifying the coverage class are
  * identical to the ath9k definitions.
  * These registers are usually managed by the ath10k firmware. However by
diff --git a/drivers/net/wireless/ath/ath5k/reg.h b/drivers/net/wireless/ath/ath5k/reg.h
index 0ea1608b47fd..22101c96713f 100644
--- a/drivers/net/wireless/ath/ath5k/reg.h
+++ b/drivers/net/wireless/ath/ath5k/reg.h
@@ -543,7 +543,7 @@
  * Queue control unit (QCU) registers [5211+]
  *
  * Card has 12 TX Queues but i see that only 0-9 are used (?)
- * both in binary HAL (see ah.h) and ar5k. Each queue has it's own
+ * both in binary HAL (see ah.h) and ar5k. Each queue has its own
  * TXDP at addresses 0x0800 - 0x082c, a CBR (Constant Bit Rate)
  * configuration register (0x08c0 - 0x08ec), a ready time configuration
  * register (0x0900 - 0x092c), a misc configuration register (0x09c0 -
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 40a9a8177de6..5fc375f27630 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -3878,7 +3878,7 @@ brcmf_notify_sched_scan_results(struct brcmf_if *ifp,
 	brcmf_dbg(SCAN, "Enter\n");
 
 	if (e->datalen < (sizeof(*pfn_result) + sizeof(*netinfo))) {
-		brcmf_dbg(SCAN, "Event data to small. Ignore\n");
+		brcmf_dbg(SCAN, "Event data too small. Ignore\n");
 		return 0;
 	}
 
@@ -4046,7 +4046,7 @@ brcmf_wowl_nd_results(struct brcmf_if *ifp, const struct brcmf_event_msg *e,
 	brcmf_dbg(SCAN, "Enter\n");
 
 	if (e->datalen < (sizeof(*pfn_result) + sizeof(*netinfo))) {
-		brcmf_dbg(SCAN, "Event data to small. Ignore\n");
+		brcmf_dbg(SCAN, "Event data too small. Ignore\n");
 		return 0;
 	}
 
@@ -4308,7 +4308,7 @@ static s32 brcmf_cfg80211_suspend(struct wiphy *wiphy,
 		brcmf_set_mpc(ifp, 1);
 
 	} else {
-		/* Configure WOWL paramaters */
+		/* Configure WOWL parameters */
 		brcmf_configure_wowl(cfg, ifp, wowl);
 
 		/* Prevent disassociation due to inactivity with keep-alive */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index 75f101622db1..688f16c51319 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -525,7 +525,7 @@ struct brcmf_mp_device *brcmf_get_module_param(struct device *dev,
 	if (!settings)
 		return NULL;
 
-	/* start by using the module paramaters */
+	/* start by using the module parameters */
 	settings->p2p_enable = !!brcmf_p2p_enable;
 	settings->feature_disable = brcmf_feature_disable;
 	settings->fcmode = brcmf_fcmode;
@@ -612,7 +612,7 @@ static int __init brcmfmac_module_init(void)
 	if (err == -ENODEV)
 		brcmf_dbg(INFO, "No platform data available.\n");
 
-	/* Initialize global module paramaters */
+	/* Initialize global module parameters */
 	brcmf_mp_attach();
 
 	/* Continue the initialization by registering the different busses */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
index 2be2986d2110..3bdb6984b2dd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
@@ -20,7 +20,7 @@
  */
 
 /**
- * struct brcmf_mp_global_t - Global module paramaters.
+ * struct brcmf_mp_global_t - Global module parameters.
  *
  * @firmware_path: Alternative firmware path.
  */
@@ -31,7 +31,7 @@ struct brcmf_mp_global_t {
 extern struct brcmf_mp_global_t brcmf_mp_global;
 
 /**
- * struct brcmf_mp_device - Device module paramaters.
+ * struct brcmf_mp_device - Device module parameters.
  *
  * @p2p_enable: Legacy P2P0 enable (old wpa_supplicant).
  * @feature_disable: Feature_disable bitmask.
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
index d53839f855d7..399b6810e394 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
@@ -67,7 +67,7 @@ struct brcmf_ampdu_rx_reorder {
 /* Forward decls for struct brcmf_pub (see below) */
 struct brcmf_proto;	/* device communication protocol info */
 struct brcmf_fws_info;	/* firmware signalling info */
-struct brcmf_mp_device;	/* module paramateres, device specific */
+struct brcmf_mp_device;	/* module parameters, device specific */
 
 /*
  * struct brcmf_rev_info
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index 6e0c90f4718b..0dc9d28cd77b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -1403,7 +1403,7 @@ int brcmf_p2p_notify_action_frame_rx(struct brcmf_if *ifp,
 	u8 action;
 
 	if (e->datalen < sizeof(*rxframe)) {
-		brcmf_dbg(SCAN, "Event data to small. Ignore\n");
+		brcmf_dbg(SCAN, "Event data too small. Ignore\n");
 		return 0;
 	}
 
@@ -1949,7 +1949,7 @@ s32 brcmf_p2p_notify_rx_mgmt_p2p_probereq(struct brcmf_if *ifp,
 		  e->reason);
 
 	if (e->datalen < sizeof(*rxframe)) {
-		brcmf_dbg(SCAN, "Event data to small. Ignore\n");
+		brcmf_dbg(SCAN, "Event data too small. Ignore\n");
 		return 0;
 	}
 
diff --git a/drivers/net/wireless/intel/iwlegacy/commands.h b/drivers/net/wireless/intel/iwlegacy/commands.h
index 4a9fa8b83f0f..b61b8f377702 100644
--- a/drivers/net/wireless/intel/iwlegacy/commands.h
+++ b/drivers/net/wireless/intel/iwlegacy/commands.h
@@ -2229,7 +2229,7 @@ struct il_spectrum_notification {
 	u8 channel;
 	u8 type;		/* see enum il_measurement_type */
 	u8 reserved1;
-	/* NOTE:  cca_ofdm, cca_cck, basic_type, and histogram are only only
+	/* NOTE:  cca_ofdm, cca_cck, basic_type, and histogram are only
 	 * valid if applicable for measurement type requested. */
 	__le32 cca_ofdm;	/* cca fraction time in 40Mhz clock periods */
 	__le32 cca_cck;		/* cca fraction time in 44Mhz clock periods */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h b/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
index f586379d66dd..46d35ef4751e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
@@ -452,7 +452,7 @@ struct iwl_roc_notif {
  *	listen mode. Will be fragmented. Valid only on the P2P Device MAC.
  *	Valid only on the P2P Device MAC. The firmware will take into account
  *	the duration, the interval and the repetition count.
- * @SESSION_PROTECT_CONF_P2P_GO_NEGOTIATION: Schedule the P2P Device to be be
+ * @SESSION_PROTECT_CONF_P2P_GO_NEGOTIATION: Schedule the P2P Device to be
  *	able to run the GO Negotiation. Will not be fragmented and not
  *	repetitive. Valid only on the P2P Device MAC. Only the duration will
  *	be taken into account.
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index ef9bab042902..dfce0f15a37e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -250,7 +250,7 @@ static void iwl_mvm_wowlan_get_rsc_tsc_data(struct ieee80211_hw *hw,
 
 		/*
 		 * For non-QoS this relies on the fact that both the uCode and
-		 * mac80211 use TID 0 (as they need to to avoid replay attacks)
+		 * mac80211 use TID 0 (as they need to avoid replay attacks)
 		 * for checking the IV in the frames.
 		 */
 		for (i = 0; i < IWL_NUM_RSC; i++) {
@@ -386,7 +386,7 @@ static void iwl_mvm_wowlan_get_rsc_v5_data(struct ieee80211_hw *hw,
 
 		/*
 		 * For non-QoS this relies on the fact that both the uCode and
-		 * mac80211 use TID 0 (as they need to to avoid replay attacks)
+		 * mac80211 use TID 0 (as they need to avoid replay attacks)
 		 * for checking the IV in the frames.
 		 */
 		for (i = 0; i < IWL_MAX_TID_COUNT; i++) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index fa9d5e0b6609..9541ec6003d5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3330,7 +3330,7 @@ void iwl_mvm_mac_cancel_hw_scan(struct ieee80211_hw *hw,
 	 * us to stop a hw_scan when it's already stopped.  This can
 	 * happen, for instance, if we stopped the scan ourselves,
 	 * called ieee80211_scan_completed() and the userspace called
-	 * cancel scan scan before ieee80211_scan_work() could run.
+	 * cancel scan before ieee80211_scan_work() could run.
 	 * To handle that, simply return if the scan is not running.
 	*/
 	if (mvm->scan_status & IWL_MVM_SCAN_REGULAR)
@@ -4343,7 +4343,7 @@ int iwl_mvm_mac_sched_scan_stop(struct ieee80211_hw *hw,
 	 * us to stop a sched_scan when it's already stopped.  This
 	 * can happen, for instance, if we stopped the scan ourselves,
 	 * called ieee80211_sched_scan_stopped() and the userspace called
-	 * stop sched scan scan before ieee80211_sched_scan_stopped_work()
+	 * stop sched scan before ieee80211_sched_scan_stopped_work()
 	 * could run.  To handle this, simply return if the scan is
 	 * not running.
 	*/
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 5f6797598998..11c6b86db4ec 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2461,7 +2461,7 @@ void iwl_mvm_free_bcast_sta_queues(struct iwl_mvm *mvm,
 	mvmvif->deflink.bcast_sta.tfd_queue_msk &= ~BIT(queue);
 }
 
-/* Send the FW a request to remove the station from it's internal data
+/* Send the FW a request to remove the station from its internal data
  * structures, but DO NOT remove the entry from the local data structures. */
 int iwl_mvm_send_rm_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
@@ -2524,7 +2524,7 @@ void iwl_mvm_dealloc_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 }
 
 /*
- * Send the FW a request to remove the station from it's internal data
+ * Send the FW a request to remove the station from its internal data
  * structures, and in addition remove it from the local data structure.
  */
 int iwl_mvm_rm_p2p_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
@@ -2677,7 +2677,7 @@ static int __iwl_mvm_remove_sta_key(struct iwl_mvm *mvm, u8 sta_id,
 }
 
 /*
- * Send the FW a request to remove the station from it's internal data
+ * Send the FW a request to remove the station from its internal data
  * structures, and in addition remove it from the local data structure.
  */
 int iwl_mvm_rm_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
diff --git a/drivers/net/wireless/intersil/p54/p54spi.c b/drivers/net/wireless/intersil/p54/p54spi.c
index 27f44a9f0bc1..9d66dcae54e0 100644
--- a/drivers/net/wireless/intersil/p54/p54spi.c
+++ b/drivers/net/wireless/intersil/p54/p54spi.c
@@ -32,7 +32,7 @@ MODULE_FIRMWARE("3826.eeprom");
 
 /* gpios should be handled in board files and provided via platform data,
  * but because it's currently impossible for p54spi to have a header file
- * in include/linux, let's use module paramaters for now
+ * in include/linux, let's use module parameters for now
  */
 
 static int p54spi_gpio_power = 97;
@@ -155,7 +155,7 @@ static int p54spi_request_firmware(struct ieee80211_hw *dev)
 	struct p54s_priv *priv = dev->priv;
 	int ret;
 
-	/* FIXME: should driver use it's own struct device? */
+	/* FIXME: should driver use its own struct device? */
 	ret = request_firmware(&priv->firmware, "3826.arm", &priv->spi->dev);
 
 	if (ret < 0) {
diff --git a/drivers/net/wireless/marvell/libertas/cfg.c b/drivers/net/wireless/marvell/libertas/cfg.c
index 2e2c193716d9..94dd488becaf 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -2146,8 +2146,8 @@ static void lbs_reg_notifier(struct wiphy *wiphy,
 }
 
 /*
- * This function get's called after lbs_setup_firmware() determined the
- * firmware capabities. So we can setup the wiphy according to our
+ * This function gets called after lbs_setup_firmware() determined the
+ * firmware capabilities. So we can setup the wiphy according to our
  * hardware/firmware.
  */
 int lbs_cfg_register(struct lbs_private *priv)
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 91458f3bd14a..e9e896606912 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -1119,7 +1119,7 @@ struct host_cmd_ds_get_hw_spec {
 	__le32 fw_cap_info;
 	__le32 dot_11n_dev_cap;
 	u8 dev_mcs_support;
-	__le16 mp_end_port;	/* SDIO only, reserved for other interfacces */
+	__le16 mp_end_port;	/* SDIO only, reserved for other interfaces */
 	__le16 mgmt_buf_count;	/* mgmt IE buffer count */
 	__le32 reserved_5;
 	__le32 reserved_6;
@@ -1739,7 +1739,7 @@ struct host_cmd_ds_11n_cfg {
 struct host_cmd_ds_txbuf_cfg {
 	__le16 action;
 	__le16 buff_size;
-	__le16 mp_end_port;	/* SDIO only, reserved for other interfacces */
+	__le16 mp_end_port;	/* SDIO only, reserved for other interfaces */
 	__le16 reserved3;
 } __packed;
 
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 4b5a7c9b6499..b264ed0af923 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -639,7 +639,7 @@ static bool rt2800_check_firmware_crc(const u8 *data, const size_t len)
 	/*
 	 * Use the crc ccitt algorithm.
 	 * This will return the same value as the legacy driver which
-	 * used bit ordering reversion on the both the firmware bytes
+	 * used bit ordering reversion on both the firmware bytes
 	 * before input input as well as on the final output.
 	 * Obviously using crc ccitt directly is much more efficient.
 	 */
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index 432ddfac2c33..7db29e90eb4f 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -357,7 +357,7 @@ static void rt2x00lib_fill_tx_status(struct rt2x00_dev *rt2x00dev,
 	}
 
 	/*
-	 * Every single frame has it's own tx status, hence report
+	 * Every single frame has its own tx status, hence report
 	 * every frame as ampdu of size 1.
 	 *
 	 * TODO: if we can find out how many frames were aggregated
@@ -496,7 +496,7 @@ void rt2x00lib_txdone(struct queue_entry *entry,
 	/*
 	 * If the IV/EIV data was stripped from the frame before it was
 	 * passed to the hardware, we should now reinsert it again because
-	 * mac80211 will expect the same data to be present it the
+	 * mac80211 will expect the same data to be present in the
 	 * frame as it was passed to us.
 	 */
 	if (rt2x00_has_cap_hw_crypto(rt2x00dev))
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c b/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
index 013003777fee..13e48b1e7356 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
@@ -45,7 +45,7 @@ struct sk_buff *rt2x00queue_alloc_rxskb(struct queue_entry *entry, gfp_t gfp)
 
 	/*
 	 * For IV/EIV/ICV assembly we must make sure there is
-	 * at least 8 bytes bytes available in headroom for IV/EIV
+	 * at least 8 bytes available in headroom for IV/EIV
 	 * and 8 bytes for ICV data as tailroon.
 	 */
 	if (rt2x00_has_cap_hw_crypto(rt2x00dev)) {
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 496836f716aa..c62de698f188 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -1163,7 +1163,7 @@ static void rtl8xxxu_start_tx_beacon(struct rtl8xxxu_priv *priv)
 
 
 /*
- * The rtl8723a has 3 channel groups for it's efuse settings. It only
+ * The rtl8723a has 3 channel groups for its efuse settings. It only
  * supports the 2.4GHz band, so channels 1 - 14:
  *  group 0: channels 1 - 3
  *  group 1: channels 4 - 9
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.c
index eb7d8b070cc7..494b2706abee 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.c
@@ -84,7 +84,7 @@ bool rtl92d_phy_rf6052_config(struct ieee80211_hw *hw)
 		rtlphy->num_total_rfpath = 2;
 
 	/* Single phy mode: use radio_a radio_b config path_A path_B */
-	/* seperately by MAC0, and MAC1 needn't configure RF; */
+	/* separately by MAC0, and MAC1 needn't configure RF; */
 	/* Dual PHY mode:MAC0 use radio_a config 1st phy path_A, */
 	/* MAC1 use radio_b config 2nd PHY path_A. */
 	/* DMDP,MAC0 on G band,MAC1 on A band. */
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/rf.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/rf.c
index 5a493602aaf2..17d29249a711 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/rf.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/rf.c
@@ -438,7 +438,7 @@ bool rtl92s_phy_rf6052_config(struct ieee80211_hw *hw)
 		rtl92s_phy_set_bb_reg(hw, pphyreg->rfhssi_para2,
 				B3WIRE_DATALENGTH, 0x0);
 
-		/* Initialize RF fom connfiguration file */
+		/* Initialize RF from configuration file */
 		switch (rfpath) {
 		case RF90_PATH_A:
 			rtstatus = rtl92s_phy_config_rf(hw,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
index a5a34b5edcfd..3a4a33476205 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
@@ -1026,7 +1026,7 @@ static void _rtl8821ae_hw_configure(struct ieee80211_hw *hw)
 	/*Set retry limit*/
 	rtl_write_word(rtlpriv, REG_RL, 0x0707);
 
-	/* Set Data / Response auto rate fallack retry count*/
+	/* Set Data / Response auto rate fallback retry count*/
 	rtl_write_dword(rtlpriv, REG_DARFRC, 0x01000000);
 	rtl_write_dword(rtlpriv, REG_DARFRC + 4, 0x07060504);
 	rtl_write_dword(rtlpriv, REG_RARFRC, 0x01000000);
@@ -1295,12 +1295,12 @@ static bool _rtl8821ae_reset_pcie_interface_dma(struct ieee80211_hw *hw,
 		rtl_write_byte(rtlpriv, REG_CR, 0xFF);
 
 		/* We should init LLT & RQPN and
-		 * prepare Tx/Rx descrptor address later
+		 * prepare Tx/Rx descriptor address later
 		 * because MAC function is reset.*/
 	}
 
 	/* 7. Restore PCIe autoload down bit */
-	/* 8812AE does not has the defination. */
+	/* 8812AE does not have the definition. */
 	if (rtlhal->hw_type == HARDWARE_TYPE_RTL8821AE) {
 		/* write 0xF8 bit[17] = 1'b1 */
 		tmp = rtl_read_byte(rtlpriv, REG_MAC_PHY_CTRL_NORMAL + 2);
@@ -1308,7 +1308,7 @@ static bool _rtl8821ae_reset_pcie_interface_dma(struct ieee80211_hw *hw,
 		rtl_write_byte(rtlpriv, REG_MAC_PHY_CTRL_NORMAL + 2, tmp);
 	}
 
-	/* In MAC power on state, BB and RF maybe in ON state,
+	/* In MAC power on state, BB and RF may be in ON state,
 	 * if we release TRx DMA here.
 	 * it will cause packets to be started to Tx/Rx,
 	 * so we release Tx/Rx DMA later.*/
@@ -1713,7 +1713,7 @@ static bool _rtl8821ae_wowlan_initialize_adapter(struct ieee80211_hw *hw)
 	_rtl8821ae_get_wakeup_reason(hw);
 
 	/* Patch Pcie Rx DMA hang after S3/S4 several times.
-	 * The root cause has not be found. */
+	 * The root cause has not been found. */
 	if (_rtl8821ae_check_pcie_dma_hang(hw))
 		_rtl8821ae_reset_pcie_interface_dma(hw, true, false);
 
@@ -1926,7 +1926,7 @@ int rtl8821ae_hw_init(struct ieee80211_hw *hw)
 	rtl8821ae_phy_mac_config(hw);
 	/* because last function modify RCR, so we update
 	 * rcr var here, or TP will unstable for receive_config
-	 * is wrong, RX RCR_ACRC32 will cause TP unstabel & Rx
+	 * is wrong, RX RCR_ACRC32 will cause TP unstable & Rx
 	 * RCR_APP_ICV will cause mac80211 unassoc for cisco 1252
 	rtlpci->receive_config = rtl_read_dword(rtlpriv, REG_RCR);
 	rtlpci->receive_config &= ~(RCR_ACRC32 | RCR_AICV);
@@ -2332,7 +2332,7 @@ void rtl8821ae_card_disable(struct ieee80211_hw *hw)
 		if (_rtl8821ae_dynamic_rqpn(hw, 0xE0, 0x3, 0x80c20d0d))
 			rtlhal->re_init_llt_table = true;
 
-		/* 3 <2> Set Fw releted H2C cmd. */
+		/* 3 <2> Set Fw related H2C cmd. */
 
 		/* Set WoWLAN related security information. */
 		rtl8821ae_set_fw_global_info_cmd(hw);
@@ -2357,8 +2357,8 @@ void rtl8821ae_card_disable(struct ieee80211_hw *hw)
 
 		/* 3 <3> Hw Configutations */
 
-		/* Wait untill Rx DMA Finished before host sleep.
-		 * FW Pause Rx DMA may happens when received packet doing dma.
+		/* Wait until Rx DMA Finished before host sleep.
+		 * FW Pause Rx DMA may happen when received packet doing DMA.
 		 */
 		rtl_write_byte(rtlpriv, REG_RXDMA_CONTROL, BIT(2));
 
@@ -3927,7 +3927,7 @@ void rtl8821ae_resume(struct ieee80211_hw *hw)
 {
 }
 
-/* Turn on AAP (RCR:bit 0) for promicuous mode. */
+/* Turn on AAP (RCR:bit 0) for promiscuous mode. */
 void rtl8821ae_allow_all_destaddr(struct ieee80211_hw *hw,
 	bool allow_all_da, bool write_into_reg)
 {
@@ -3964,7 +3964,7 @@ void rtl8821ae_add_wowlan_pattern(struct ieee80211_hw *hw,
 
 	/* RX page size = 128 byte */
 	offset = MAX_RX_DMA_BUFFER_SIZE_8812 / 128;
-	/* We should start from the boundry */
+	/* We should start from the boundary */
 	cam_start = offset * 128;
 
 	/* Enable Rx packet buffer access. */
diff --git a/drivers/net/wireless/ti/wl1251/reg.h b/drivers/net/wireless/ti/wl1251/reg.h
index 890176c915ab..bfe35754f33a 100644
--- a/drivers/net/wireless/ti/wl1251/reg.h
+++ b/drivers/net/wireless/ti/wl1251/reg.h
@@ -205,7 +205,7 @@ enum wl12xx_acx_int_reg {
  the burst read starts at EEPROM address 0.
  Otherwise, it starts at the address
  following the address of the previous access.
- TheWlan hardware hardware clears this bit automatically.
+ TheWlan hardware clears this bit automatically.
 
  Default: 0x00000000
 *================================================*/
@@ -353,13 +353,13 @@ enum wl12xx_acx_int_reg {
  loads a single byte of data into the EE_DATA
  register from the EEPROM location specified in
  the EE_ADDR register.
- The Wlan hardware hardware clears this bit automatically.
+ The Wlan hardware clears this bit automatically.
  EE_DATA is valid when this bit is cleared.
 
  0 EE_WRITE  - EEPROM Write Request  - Setting this bit
  writes a single byte of data from the EE_DATA register into the
  EEPROM location specified in the EE_ADDR register.
- The Wlan hardware hardware clears this bit automatically.
+ The Wlan hardware clears this bit automatically.
 *===============================================*/
 #define EE_CTL                              (REGISTERS_BASE + 0x2000)
 #define ACX_EE_CTL_REG                      EE_CTL
diff --git a/drivers/net/wireless/ti/wl12xx/reg.h b/drivers/net/wireless/ti/wl12xx/reg.h
index 8ff018808020..601305a26141 100644
--- a/drivers/net/wireless/ti/wl12xx/reg.h
+++ b/drivers/net/wireless/ti/wl12xx/reg.h
@@ -168,7 +168,7 @@
  the burst read starts at EEPROM address 0.
  Otherwise, it starts at the address
  following the address of the previous access.
- TheWlan hardware hardware clears this bit automatically.
+ TheWlan hardware clears this bit automatically.
 
  Default: 0x00000000
 *================================================*/
@@ -276,13 +276,13 @@
  loads a single byte of data into the EE_DATA
  register from the EEPROM location specified in
  the EE_ADDR register.
- The Wlan hardware hardware clears this bit automatically.
+ The Wlan hardware clears this bit automatically.
  EE_DATA is valid when this bit is cleared.
 
  0 EE_WRITE  - EEPROM Write Request  - Setting this bit
  writes a single byte of data from the EE_DATA register into the
  EEPROM location specified in the EE_ADDR register.
- The Wlan hardware hardware clears this bit automatically.
+ The Wlan hardware clears this bit automatically.
 *===============================================*/
 #define ACX_EE_CTL_REG                      EE_CTL
 #define EE_WRITE                            0x00000001ul
diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
index 9ae10f65f2af..2faa0de2a36e 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
@@ -445,7 +445,7 @@ static void int_urb_complete(struct urb *urb)
 	}
 
 	if (urb->actual_length < sizeof(hdr)) {
-		dev_dbg_f(urb_dev(urb), "error: urb %p to small\n", urb);
+		dev_dbg_f(urb_dev(urb), "error: urb %p too small\n", urb);
 		goto resubmit;
 	}
 
-- 
2.43.0


