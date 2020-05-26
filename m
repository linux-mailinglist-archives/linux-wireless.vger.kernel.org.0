Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D178F1ADB4F
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 12:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgDQKnI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 06:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728868AbgDQKnI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 06:43:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCE3C061A0C
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2020 03:43:08 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jPOSg-0072nK-5h; Fri, 17 Apr 2020 12:43:06 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Igor Mitsyanko <imitsyanko@quantenna.com>,
        Avinash Patil <avinashp@quantenna.com>,
        Sergey Matyukevich <smatyukevich@quantenna.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] cfg80211: change internal management frame registration API
Date:   Fri, 17 Apr 2020 12:43:01 +0200
Message-Id: <20200417124300.f47f3828afc8.I7f81ef59c2c5a340d7075fb3c6d0e08e8aeffe07@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Almost all drivers below cfg80211 get the API wrong (except for
cfg80211) and are unable to cope with multiple registrations for
the same frame type, which is valid due to the match filter.
This seems to indicate the API is wrong, and we should maintain
the full information in cfg80211 instead of the drivers.

Change the API to no longer inform the driver about individual
registrations and unregistrations, but rather every time about
the entire state of the entire wiphy and single wdev, whenever
it may have changed. This also simplifies the code in cfg80211
as it no longer has to track exactly what was unregistered and
can free things immediately.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c    | 26 +++---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 19 ++---
 .../net/wireless/marvell/mwifiex/cfg80211.c   | 16 ++--
 .../net/wireless/quantenna/qtnfmac/cfg80211.c | 83 ++++++++++---------
 include/net/cfg80211.h                        | 23 +++--
 include/net/mac80211.h                        |  2 +-
 net/mac80211/cfg.c                            | 50 +++++------
 net/mac80211/ieee80211_i.h                    |  2 +-
 net/wireless/core.c                           |  7 +-
 net/wireless/core.h                           |  6 +-
 net/wireless/mlme.c                           | 72 +++++++---------
 net/wireless/rdev-ops.h                       | 11 ++-
 net/wireless/trace.h                          | 20 ++---
 13 files changed, 159 insertions(+), 178 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index 37cf602d8adf..67f8f2aa7a53 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -3249,22 +3249,19 @@ static int ath6kl_get_antenna(struct wiphy *wiphy,
 	return 0;
 }
 
-static void ath6kl_mgmt_frame_register(struct wiphy *wiphy,
-				       struct wireless_dev *wdev,
-				       u16 frame_type, bool reg)
+static void ath6kl_update_mgmt_frame_registrations(struct wiphy *wiphy,
+						   struct wireless_dev *wdev,
+						   struct mgmt_frame_regs *upd)
 {
 	struct ath6kl_vif *vif = ath6kl_vif_from_wdev(wdev);
 
-	ath6kl_dbg(ATH6KL_DBG_WLAN_CFG, "%s: frame_type=0x%x reg=%d\n",
-		   __func__, frame_type, reg);
-	if (frame_type == IEEE80211_STYPE_PROBE_REQ) {
-		/*
-		 * Note: This notification callback is not allowed to sleep, so
-		 * we cannot send WMI_PROBE_REQ_REPORT_CMD here. Instead, we
-		 * hardcode target to report Probe Request frames all the time.
-		 */
-		vif->probe_req_report = reg;
-	}
+	/*
+	 * FIXME: send WMI_PROBE_REQ_REPORT_CMD here instead of hardcoding
+	 *	  the reporting in the target all the time, this callback
+	 *	  *is* allowed to sleep after all.
+	 */
+	vif->probe_req_report =
+		upd->interface_stypes & BIT(IEEE80211_STYPE_PROBE_REQ >> 4);
 }
 
 static int ath6kl_cfg80211_sscan_start(struct wiphy *wiphy,
@@ -3464,7 +3461,8 @@ static struct cfg80211_ops ath6kl_cfg80211_ops = {
 	.remain_on_channel = ath6kl_remain_on_channel,
 	.cancel_remain_on_channel = ath6kl_cancel_remain_on_channel,
 	.mgmt_tx = ath6kl_mgmt_tx,
-	.mgmt_frame_register = ath6kl_mgmt_frame_register,
+	.update_mgmt_frame_registrations =
+		ath6kl_update_mgmt_frame_registrations,
 	.get_antenna = ath6kl_get_antenna,
 	.sched_scan_start = ath6kl_cfg80211_sscan_start,
 	.sched_scan_stop = ath6kl_cfg80211_sscan_stop,
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 2ba165330038..fa846471dac2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -4979,21 +4979,15 @@ brcmf_cfg80211_change_station(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static void
-brcmf_cfg80211_mgmt_frame_register(struct wiphy *wiphy,
-				   struct wireless_dev *wdev,
-				   u16 frame_type, bool reg)
+brcmf_cfg80211_update_mgmt_frame_registrations(struct wiphy *wiphy,
+					       struct wireless_dev *wdev,
+					       struct mgmt_frame_regs *upd)
 {
 	struct brcmf_cfg80211_vif *vif;
-	u16 mgmt_type;
 
-	brcmf_dbg(TRACE, "Enter, frame_type %04x, reg=%d\n", frame_type, reg);
-
-	mgmt_type = (frame_type & IEEE80211_FCTL_STYPE) >> 4;
 	vif = container_of(wdev, struct brcmf_cfg80211_vif, wdev);
-	if (reg)
-		vif->mgmt_rx_reg |= BIT(mgmt_type);
-	else
-		vif->mgmt_rx_reg &= ~BIT(mgmt_type);
+
+	vif->mgmt_rx_reg = upd->interface_stypes;
 }
 
 
@@ -5408,7 +5402,8 @@ static struct cfg80211_ops brcmf_cfg80211_ops = {
 	.change_station = brcmf_cfg80211_change_station,
 	.sched_scan_start = brcmf_cfg80211_sched_scan_start,
 	.sched_scan_stop = brcmf_cfg80211_sched_scan_stop,
-	.mgmt_frame_register = brcmf_cfg80211_mgmt_frame_register,
+	.update_mgmt_frame_registrations =
+		brcmf_cfg80211_update_mgmt_frame_registrations,
 	.mgmt_tx = brcmf_cfg80211_mgmt_tx,
 	.remain_on_channel = brcmf_p2p_remain_on_channel,
 	.cancel_remain_on_channel = brcmf_cfg80211_cancel_remain_on_channel,
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 1566d2197906..21a17d4017c4 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -269,17 +269,12 @@ mwifiex_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
  * CFG802.11 operation handler to register a mgmt frame.
  */
 static void
-mwifiex_cfg80211_mgmt_frame_register(struct wiphy *wiphy,
-				     struct wireless_dev *wdev,
-				     u16 frame_type, bool reg)
+mwifiex_cfg80211_update_mgmt_frame_registrations(struct wiphy *wiphy,
+						 struct wireless_dev *wdev,
+						 struct mgmt_frame_regs *upd)
 {
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(wdev->netdev);
-	u32 mask;
-
-	if (reg)
-		mask = priv->mgmt_frame_mask | BIT(frame_type >> 4);
-	else
-		mask = priv->mgmt_frame_mask & ~BIT(frame_type >> 4);
+	u32 mask = upd->interface_stypes;
 
 	if (mask != priv->mgmt_frame_mask) {
 		priv->mgmt_frame_mask = mask;
@@ -4189,7 +4184,8 @@ static struct cfg80211_ops mwifiex_cfg80211_ops = {
 	.del_key = mwifiex_cfg80211_del_key,
 	.set_default_mgmt_key = mwifiex_cfg80211_set_default_mgmt_key,
 	.mgmt_tx = mwifiex_cfg80211_mgmt_tx,
-	.mgmt_frame_register = mwifiex_cfg80211_mgmt_frame_register,
+	.update_mgmt_frame_registrations =
+		mwifiex_cfg80211_update_mgmt_frame_registrations,
 	.remain_on_channel = mwifiex_cfg80211_remain_on_channel,
 	.cancel_remain_on_channel = mwifiex_cfg80211_cancel_remain_on_channel,
 	.set_default_key = mwifiex_cfg80211_set_default_key,
diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
index 8be17106008d..54cdf3ad09d7 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -389,55 +389,57 @@ static int qtnf_set_wiphy_params(struct wiphy *wiphy, u32 changed)
 }
 
 static void
-qtnf_mgmt_frame_register(struct wiphy *wiphy, struct wireless_dev *wdev,
-			 u16 frame_type, bool reg)
+qtnf_update_mgmt_frame_registrations(struct wiphy *wiphy,
+				     struct wireless_dev *wdev,
+				     struct mgmt_frame_regs *upd)
 {
 	struct qtnf_vif *vif = qtnf_netdev_get_priv(wdev->netdev);
-	u16 mgmt_type;
-	u16 new_mask;
-	u16 qlink_frame_type = 0;
+	u16 new_mask = upd->interface_stypes;
+	u16 old_mask = vif->mgmt_frames_bitmask;
+	static const struct {
+		u16 mask, qlink_type;
+	} updates[] = {
+		{
+			.mask = BIT(IEEE80211_STYPE_REASSOC_REQ >> 4) |
+				BIT(IEEE80211_STYPE_ASSOC_REQ >> 4),
+			.qlink_type = QLINK_MGMT_FRAME_ASSOC_REQ,
+		},
+		{
+			.mask = BIT(IEEE80211_STYPE_AUTH >> 4),
+			.qlink_type = QLINK_MGMT_FRAME_AUTH,
+		},
+		{
+			.mask = BIT(IEEE80211_STYPE_PROBE_REQ >> 4),
+			.qlink_type = QLINK_MGMT_FRAME_PROBE_REQ,
+		},
+		{
+			.mask = BIT(IEEE80211_STYPE_ACTION >> 4),
+			.qlink_type = QLINK_MGMT_FRAME_ACTION,
+		},
+	};
+	unsigned int i;
 
-	mgmt_type = (frame_type & IEEE80211_FCTL_STYPE) >> 4;
+	if (new_mask == old_mask)
+		return;
 
-	if (reg)
-		new_mask = vif->mgmt_frames_bitmask | BIT(mgmt_type);
-	else
-		new_mask = vif->mgmt_frames_bitmask & ~BIT(mgmt_type);
+	for (i = 0; i < ARRAY_SIZE(updates); i++) {
+		u16 mask = updates[i].mask;
+		u16 qlink_frame_type = updates[i].qlink_type;
+		bool reg;
 
-	if (new_mask == vif->mgmt_frames_bitmask)
-		return;
+		/* the ! are here due to the assoc/reassoc merge */
+		if (!(new_mask & mask) == !(old_mask & mask))
+			continue;
 
-	switch (frame_type & IEEE80211_FCTL_STYPE) {
-	case IEEE80211_STYPE_REASSOC_REQ:
-	case IEEE80211_STYPE_ASSOC_REQ:
-		qlink_frame_type = QLINK_MGMT_FRAME_ASSOC_REQ;
-		break;
-	case IEEE80211_STYPE_AUTH:
-		qlink_frame_type = QLINK_MGMT_FRAME_AUTH;
-		break;
-	case IEEE80211_STYPE_PROBE_REQ:
-		qlink_frame_type = QLINK_MGMT_FRAME_PROBE_REQ;
-		break;
-	case IEEE80211_STYPE_ACTION:
-		qlink_frame_type = QLINK_MGMT_FRAME_ACTION;
-		break;
-	default:
-		pr_warn("VIF%u.%u: unsupported frame type: %X\n",
-			vif->mac->macid, vif->vifid,
-			(frame_type & IEEE80211_FCTL_STYPE) >> 4);
-		return;
-	}
+		reg = new_mask & mask;
 
-	if (qtnf_cmd_send_register_mgmt(vif, qlink_frame_type, reg)) {
-		pr_warn("VIF%u.%u: failed to %sregister mgmt frame type 0x%x\n",
-			vif->mac->macid, vif->vifid, reg ? "" : "un",
-			frame_type);
-		return;
+		if (qtnf_cmd_send_register_mgmt(vif, qlink_frame_type, reg))
+			pr_warn("VIF%u.%u: failed to %sregister qlink frame type 0x%x\n",
+				vif->mac->macid, vif->vifid, reg ? "" : "un",
+				qlink_frame_type);
 	}
 
 	vif->mgmt_frames_bitmask = new_mask;
-	pr_debug("VIF%u.%u: %sregistered mgmt frame type 0x%x\n",
-		 vif->mac->macid, vif->vifid, reg ? "" : "un", frame_type);
 }
 
 static int
@@ -1017,7 +1019,8 @@ static struct cfg80211_ops qtn_cfg80211_ops = {
 	.change_beacon		= qtnf_change_beacon,
 	.stop_ap		= qtnf_stop_ap,
 	.set_wiphy_params	= qtnf_set_wiphy_params,
-	.mgmt_frame_register	= qtnf_mgmt_frame_register,
+	.update_mgmt_frame_registrations =
+		qtnf_update_mgmt_frame_registrations,
 	.mgmt_tx		= qtnf_mgmt_tx,
 	.change_station		= qtnf_change_station,
 	.del_station		= qtnf_del_station,
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 70e48f66dac8..9d9dae104e89 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3384,6 +3384,17 @@ struct cfg80211_update_owe_info {
 	size_t ie_len;
 };
 
+/**
+ * struct mgmt_frame_regs - management frame registrations data
+ * @global_stypes: bitmap of management frame subtypes registered
+ *	for the entire device
+ * @interface_stypes: bitmap of management frame subtypes registered
+ *	for the given interface
+ */
+struct mgmt_frame_regs {
+	u32 global_stypes, interface_stypes;
+};
+
 /**
  * struct cfg80211_ops - backend description for wireless configuration
  *
@@ -3608,8 +3619,8 @@ struct cfg80211_update_owe_info {
  *	The driver should not call cfg80211_sched_scan_stopped() for a requested
  *	stop (when this method returns 0).
  *
- * @mgmt_frame_register: Notify driver that a management frame type was
- *	registered. The callback is allowed to sleep.
+ * @update_mgmt_frame_registrations: Notify the driver that management frame
+ *	registrations were updated. The callback is allowed to sleep.
  *
  * @set_antenna: Set antenna configuration (tx_ant, rx_ant) on the device.
  *	Parameters are bitmaps of allowed antennas to use for TX/RX. Drivers may
@@ -3932,9 +3943,9 @@ struct cfg80211_ops {
 				      struct net_device *dev,
 				      u32 rate, u32 pkts, u32 intvl);
 
-	void	(*mgmt_frame_register)(struct wiphy *wiphy,
-				       struct wireless_dev *wdev,
-				       u16 frame_type, bool reg);
+	void	(*update_mgmt_frame_registrations)(struct wiphy *wiphy,
+						   struct wireless_dev *wdev,
+						   struct mgmt_frame_regs *upd);
 
 	int	(*set_antenna)(struct wiphy *wiphy, u32 tx_ant, u32 rx_ant);
 	int	(*get_antenna)(struct wiphy *wiphy, u32 *tx_ant, u32 *rx_ant);
@@ -5015,6 +5026,7 @@ struct cfg80211_cqm_config;
  *	by cfg80211 on change_interface
  * @mgmt_registrations: list of registrations for management frames
  * @mgmt_registrations_lock: lock for the list
+ * @mgmt_registrations_update_wk: update work to defer from atomic context
  * @mtx: mutex used to lock data in this struct, may be used by drivers
  *	and some API functions require it held
  * @beacon_interval: beacon interval used on this device for transmitting
@@ -5058,6 +5070,7 @@ struct wireless_dev {
 
 	struct list_head mgmt_registrations;
 	spinlock_t mgmt_registrations_lock;
+	struct work_struct mgmt_registrations_update_wk;
 
 	struct mutex mtx;
 
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index b6b4de0e4b5e..f6dc5a38720f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1647,7 +1647,7 @@ struct ieee80211_vif {
 	struct dentry *debugfs_dir;
 #endif
 
-	unsigned int probe_req_reg;
+	bool probe_req_reg;
 
 	bool txqs_stopped[IEEE80211_NUM_ACS];
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b90f2131ec7a..e62b4764e82e 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3398,44 +3398,35 @@ int ieee80211_attach_ack_skb(struct ieee80211_local *local, struct sk_buff *skb,
 	return 0;
 }
 
-static void ieee80211_mgmt_frame_register(struct wiphy *wiphy,
+static void
+ieee80211_update_mgmt_frame_registrations(struct wiphy *wiphy,
 					  struct wireless_dev *wdev,
-					  u16 frame_type, bool reg)
+					  struct mgmt_frame_regs *upd)
 {
 	struct ieee80211_local *local = wiphy_priv(wiphy);
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
+	u32 preq_mask = BIT(IEEE80211_STYPE_PROBE_REQ >> 4);
+	bool global_change, intf_change;
 
-	switch (frame_type) {
-	case IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_PROBE_REQ:
-		if (reg) {
-			local->probe_req_reg++;
-			sdata->vif.probe_req_reg++;
-		} else {
-			if (local->probe_req_reg)
-				local->probe_req_reg--;
+	global_change =
+		local->probe_req_reg != !!(upd->global_stypes & preq_mask);
+	local->probe_req_reg = upd->global_stypes & preq_mask;
 
-			if (sdata->vif.probe_req_reg)
-				sdata->vif.probe_req_reg--;
-		}
+	intf_change = sdata->vif.probe_req_reg !=
+				!!(upd->interface_stypes & preq_mask);
+	sdata->vif.probe_req_reg = upd->interface_stypes & preq_mask;
 
-		if (!local->open_count)
-			break;
+	if (!local->open_count)
+		return;
 
-		if (ieee80211_sdata_running(sdata)) {
-			if (sdata->vif.probe_req_reg == 1)
-				drv_config_iface_filter(local, sdata,
-							FIF_PROBE_REQ,
-							FIF_PROBE_REQ);
-			else if (sdata->vif.probe_req_reg == 0)
-				drv_config_iface_filter(local, sdata, 0,
-							FIF_PROBE_REQ);
-		}
+	if (intf_change && ieee80211_sdata_running(sdata))
+		drv_config_iface_filter(local, sdata,
+					sdata->vif.probe_req_reg ?
+						FIF_PROBE_REQ : 0,
+					FIF_PROBE_REQ);
 
+	if (global_change)
 		ieee80211_configure_filter(local);
-		break;
-	default:
-		break;
-	}
 }
 
 static int ieee80211_set_antenna(struct wiphy *wiphy, u32 tx_ant, u32 rx_ant)
@@ -4020,7 +4011,8 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.mgmt_tx_cancel_wait = ieee80211_mgmt_tx_cancel_wait,
 	.set_cqm_rssi_config = ieee80211_set_cqm_rssi_config,
 	.set_cqm_rssi_range_config = ieee80211_set_cqm_rssi_range_config,
-	.mgmt_frame_register = ieee80211_mgmt_frame_register,
+	.update_mgmt_frame_registrations =
+		ieee80211_update_mgmt_frame_registrations,
 	.set_antenna = ieee80211_set_antenna,
 	.get_antenna = ieee80211_get_antenna,
 	.set_rekey_data = ieee80211_set_rekey_data,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 934a91bef575..da41ee996d3d 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1167,7 +1167,7 @@ struct ieee80211_local {
 	/* number of interfaces with corresponding FIF_ flags */
 	int fif_fcsfail, fif_plcpfail, fif_control, fif_other_bss, fif_pspoll,
 	    fif_probe_req;
-	int probe_req_reg;
+	bool probe_req_reg;
 	unsigned int filter_flags; /* FIF_* */
 
 	bool wiphy_ciphers_allocated;
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 341402b4f178..5757dea2aa94 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -480,9 +480,6 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 	INIT_LIST_HEAD(&rdev->bss_list);
 	INIT_LIST_HEAD(&rdev->sched_scan_req_list);
 	INIT_WORK(&rdev->scan_done_wk, __cfg80211_scan_done);
-	INIT_LIST_HEAD(&rdev->mlme_unreg);
-	spin_lock_init(&rdev->mlme_unreg_lock);
-	INIT_WORK(&rdev->mlme_unreg_wk, cfg80211_mlme_unreg_wk);
 	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
 			  cfg80211_dfs_channels_update_work);
 #ifdef CONFIG_CFG80211_WEXT
@@ -1030,7 +1027,6 @@ void wiphy_unregister(struct wiphy *wiphy)
 	cancel_delayed_work_sync(&rdev->dfs_update_channels_wk);
 	flush_work(&rdev->destroy_work);
 	flush_work(&rdev->sched_scan_stop_wk);
-	flush_work(&rdev->mlme_unreg_wk);
 	flush_work(&rdev->propagate_radar_detect_wk);
 	flush_work(&rdev->propagate_cac_done_wk);
 
@@ -1094,6 +1090,7 @@ static void __cfg80211_unregister_wdev(struct wireless_dev *wdev, bool sync)
 	rdev->devlist_generation++;
 
 	cfg80211_mlme_purge_registrations(wdev);
+	flush_work(&wdev->mgmt_registrations_update_wk);
 
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_P2P_DEVICE:
@@ -1238,6 +1235,8 @@ void cfg80211_init_wdev(struct cfg80211_registered_device *rdev,
 	spin_lock_init(&wdev->event_lock);
 	INIT_LIST_HEAD(&wdev->mgmt_registrations);
 	spin_lock_init(&wdev->mgmt_registrations_lock);
+	INIT_WORK(&wdev->mgmt_registrations_update_wk,
+		  cfg80211_mgmt_registrations_update_wk);
 	INIT_LIST_HEAD(&wdev->pmsr_list);
 	spin_lock_init(&wdev->pmsr_lock);
 	INIT_WORK(&wdev->pmsr_free_wk, cfg80211_pmsr_free_wk);
diff --git a/net/wireless/core.h b/net/wireless/core.h
index bb897a803ffe..30fb2c35ae43 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -60,10 +60,6 @@ struct cfg80211_registered_device {
 	struct list_head beacon_registrations;
 	spinlock_t beacon_registrations_lock;
 
-	struct list_head mlme_unreg;
-	spinlock_t mlme_unreg_lock;
-	struct work_struct mlme_unreg_wk;
-
 	/* protected by RTNL only */
 	int num_running_ifaces;
 	int num_running_monitor_ifaces;
@@ -386,7 +382,7 @@ void cfg80211_mlme_down(struct cfg80211_registered_device *rdev,
 int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_pid,
 				u16 frame_type, const u8 *match_data,
 				int match_len, struct netlink_ext_ack *extack);
-void cfg80211_mlme_unreg_wk(struct work_struct *wk);
+void cfg80211_mgmt_registrations_update_wk(struct work_struct *wk);
 void cfg80211_mlme_unregister_socket(struct wireless_dev *wdev, u32 nlpid);
 void cfg80211_mlme_purge_registrations(struct wireless_dev *wdev);
 int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index e4805a3bd310..2e1a21e90b83 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -429,43 +429,37 @@ struct cfg80211_mgmt_registration {
 	u8 match[];
 };
 
-static void
-cfg80211_process_mlme_unregistrations(struct cfg80211_registered_device *rdev)
+static void cfg80211_mgmt_registrations_update(struct wireless_dev *wdev)
 {
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
+	struct wireless_dev *tmp;
 	struct cfg80211_mgmt_registration *reg;
+	struct mgmt_frame_regs upd = {};
 
 	ASSERT_RTNL();
 
-	spin_lock_bh(&rdev->mlme_unreg_lock);
-	while ((reg = list_first_entry_or_null(&rdev->mlme_unreg,
-					       struct cfg80211_mgmt_registration,
-					       list))) {
-		list_del(&reg->list);
-		spin_unlock_bh(&rdev->mlme_unreg_lock);
-
-		if (rdev->ops->mgmt_frame_register) {
-			u16 frame_type = le16_to_cpu(reg->frame_type);
+	rcu_read_lock();
+	list_for_each_entry_rcu(tmp, &rdev->wiphy.wdev_list, list) {
+		list_for_each_entry_rcu(reg, &tmp->mgmt_registrations, list) {
+			u32 mask = BIT(le16_to_cpu(reg->frame_type) >> 4);
 
-			rdev_mgmt_frame_register(rdev, reg->wdev,
-						 frame_type, false);
+			upd.global_stypes |= mask;
+			if (tmp == wdev)
+				upd.interface_stypes |= mask;
 		}
-
-		kfree(reg);
-
-		spin_lock_bh(&rdev->mlme_unreg_lock);
 	}
-	spin_unlock_bh(&rdev->mlme_unreg_lock);
+	rcu_read_unlock();
+
+	rdev_update_mgmt_frame_registrations(rdev, wdev, &upd);
 }
 
-void cfg80211_mlme_unreg_wk(struct work_struct *wk)
+void cfg80211_mgmt_registrations_update_wk(struct work_struct *wk)
 {
-	struct cfg80211_registered_device *rdev;
-
-	rdev = container_of(wk, struct cfg80211_registered_device,
-			    mlme_unreg_wk);
+	struct wireless_dev *wdev = container_of(wk, struct wireless_dev,
+						 mgmt_registrations_update_wk);
 
 	rtnl_lock();
-	cfg80211_process_mlme_unregistrations(rdev);
+	cfg80211_mgmt_registrations_update(wdev);
 	rtnl_unlock();
 }
 
@@ -473,8 +467,6 @@ int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_portid,
 				u16 frame_type, const u8 *match_data,
 				int match_len, struct netlink_ext_ack *extack)
 {
-	struct wiphy *wiphy = wdev->wiphy;
-	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	struct cfg80211_mgmt_registration *reg, *nreg;
 	int err = 0;
 	u16 mgmt_type;
@@ -534,10 +526,8 @@ int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_portid,
 		}
 	}
 
-	if (err) {
-		kfree(nreg);
+	if (err)
 		goto out;
-	}
 
 	memcpy(nreg->match, match_data, match_len);
 	nreg->match_len = match_len;
@@ -547,15 +537,12 @@ int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_portid,
 	list_add(&nreg->list, &wdev->mgmt_registrations);
 	spin_unlock_bh(&wdev->mgmt_registrations_lock);
 
-	/* process all unregistrations to avoid driver confusion */
-	cfg80211_process_mlme_unregistrations(rdev);
-
-	if (rdev->ops->mgmt_frame_register)
-		rdev_mgmt_frame_register(rdev, wdev, frame_type, true);
+	cfg80211_mgmt_registrations_update(wdev);
 
 	return 0;
 
  out:
+	kfree(nreg);
 	spin_unlock_bh(&wdev->mgmt_registrations_lock);
 
 	return err;
@@ -574,11 +561,9 @@ void cfg80211_mlme_unregister_socket(struct wireless_dev *wdev, u32 nlportid)
 			continue;
 
 		list_del(&reg->list);
-		spin_lock(&rdev->mlme_unreg_lock);
-		list_add_tail(&reg->list, &rdev->mlme_unreg);
-		spin_unlock(&rdev->mlme_unreg_lock);
+		kfree(reg);
 
-		schedule_work(&rdev->mlme_unreg_wk);
+		schedule_work(&wdev->mgmt_registrations_update_wk);
 	}
 
 	spin_unlock_bh(&wdev->mgmt_registrations_lock);
@@ -594,15 +579,16 @@ void cfg80211_mlme_unregister_socket(struct wireless_dev *wdev, u32 nlportid)
 
 void cfg80211_mlme_purge_registrations(struct wireless_dev *wdev)
 {
-	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
+	struct cfg80211_mgmt_registration *reg, *tmp;
 
 	spin_lock_bh(&wdev->mgmt_registrations_lock);
-	spin_lock(&rdev->mlme_unreg_lock);
-	list_splice_tail_init(&wdev->mgmt_registrations, &rdev->mlme_unreg);
-	spin_unlock(&rdev->mlme_unreg_lock);
+	list_for_each_entry_safe(reg, tmp, &wdev->mgmt_registrations, list) {
+		list_del(&reg->list);
+		kfree(reg);
+	}
 	spin_unlock_bh(&wdev->mgmt_registrations_lock);
 
-	cfg80211_process_mlme_unregistrations(rdev);
+	cfg80211_mgmt_registrations_update(wdev);
 }
 
 int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 99462f0c4e08..df5142e86c4f 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -819,13 +819,16 @@ rdev_set_cqm_txe_config(struct cfg80211_registered_device *rdev,
 }
 
 static inline void
-rdev_mgmt_frame_register(struct cfg80211_registered_device *rdev,
-			 struct wireless_dev *wdev, u16 frame_type, bool reg)
+rdev_update_mgmt_frame_registrations(struct cfg80211_registered_device *rdev,
+				     struct wireless_dev *wdev,
+				     struct mgmt_frame_regs *upd)
 {
 	might_sleep();
 
-	trace_rdev_mgmt_frame_register(&rdev->wiphy, wdev , frame_type, reg);
-	rdev->ops->mgmt_frame_register(&rdev->wiphy, wdev , frame_type, reg);
+	trace_rdev_update_mgmt_frame_registrations(&rdev->wiphy, wdev, upd);
+	if (rdev->ops->update_mgmt_frame_registrations)
+		rdev->ops->update_mgmt_frame_registrations(&rdev->wiphy, wdev,
+							   upd);
 	trace_rdev_return_void(&rdev->wiphy);
 }
 
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 839df54cee21..ee736620f1e3 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1582,25 +1582,25 @@ TRACE_EVENT(rdev_set_bitrate_mask,
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(peer))
 );
 
-TRACE_EVENT(rdev_mgmt_frame_register,
+TRACE_EVENT(rdev_update_mgmt_frame_registrations,
 	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
-		 u16 frame_type, bool reg),
-	TP_ARGS(wiphy, wdev, frame_type, reg),
+		 struct mgmt_frame_regs *upd),
+	TP_ARGS(wiphy, wdev, upd),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		WDEV_ENTRY
-		__field(u16, frame_type)
-		__field(bool, reg)
+		__field(u16, global_stypes)
+		__field(u16, interface_stypes)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		WDEV_ASSIGN;
-		__entry->frame_type = frame_type;
-		__entry->reg = reg;
+		__entry->global_stypes = upd->global_stypes;
+		__entry->interface_stypes = upd->interface_stypes;
 	),
-	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", frame_type: 0x%.2x, reg: %s ",
-		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->frame_type,
-		  __entry->reg ? "true" : "false")
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", global: 0x%.2x, intf: 0x%.2x",
+		  WIPHY_PR_ARG, WDEV_PR_ARG,
+		  __entry->global_stypes, __entry->interface_stypes)
 );
 
 TRACE_EVENT(rdev_return_int_tx_rx,
-- 
2.25.1

