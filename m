Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA05C52EADB
	for <lists+linux-wireless@lfdr.de>; Fri, 20 May 2022 13:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348557AbiETLc7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 May 2022 07:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348544AbiETLc4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 May 2022 07:32:56 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C44583A3
        for <linux-wireless@vger.kernel.org>; Fri, 20 May 2022 04:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=eOAOF+XX86+ml91ZB+goac63OLNH27Uicj+le8PgZFE=;
        t=1653046368; x=1654255968; b=Qtx2qBd/fWiyl6NCePsAjYXmdRc9loXuQFeJUdgSCZFGnfN
        fk5y0HQ31Y+3pXh9zIFoE7fprUbX6e6Yg5attn6pjlRODrsB4pO25KSGdNwexiSe6aR2/SkavVfcB
        u/r3hRD7J1Rp5Dy8pkVJfcmhiEfIdcft/xbhmeHARrtgJho01+MDZnM7DaDnSlD+p7DYQULSi4Zd9
        BFuZl9VxPXyBU7GWJhCdscIVipaELMdMiYsCRjcHOIITiOeUl+hWEPT+j5qSAJEliFMkknXmTcMFR
        wcIcCDKI6bqTLC5GJ7kNyD6NwfwbXnls2HAXJVVm+4nDoc6HCjEfK3aVYYIz5HHQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ns0s9-00HJjx-JM;
        Fri, 20 May 2022 13:32:45 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/4] mac80211: move interface config to new struct
Date:   Fri, 20 May 2022 13:32:41 +0200
Message-Id: <20220520132938.3c2ce764e4bc.If45210f0a19c37327a15727ff6c90cd06f3502d2@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520113242.129546-1-johannes@sipsolutions.net>
References: <20220520113242.129546-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We'll use bss_conf for per-link configuration later, so
move out all the non-link-specific data out into a new
struct ieee80211_vif_cfg used in the vif.

Some adjustments were done with the following spatch:

    @@
    expression sdata;
    struct ieee80211_vif *vifp;
    identifier var = { assoc, ibss_joined, aid, arp_addr_list, arp_addr_cnt, ssid, ssid_len, s1g, ibss_creator };
    @@
    (
    -sdata->vif.bss_conf.var
    +sdata->vif.cfg.var
    |
    -vifp->bss_conf.var
    +vifp->cfg.var
    )

    @bss_conf@
    struct ieee80211_bss_conf *bss_conf;
    identifier var = { assoc, ibss_joined, aid, arp_addr_list, arp_addr_cnt, ssid, ssid_len, s1g, ibss_creator };
    @@
    -bss_conf->var
    +vif_cfg->var

(though more manual fixups were needed, e.g. replacing
"vif_cfg->" by "vif->cfg." in many files.)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/ar5523/ar5523.c      | 10 ++--
 drivers/net/wireless/ath/ath10k/mac.c         | 29 +++++-----
 drivers/net/wireless/ath/ath11k/mac.c         | 22 +++----
 drivers/net/wireless/ath/ath5k/mac80211-ops.c | 12 ++--
 drivers/net/wireless/ath/ath9k/beacon.c       | 11 ++--
 drivers/net/wireless/ath/ath9k/htc_drv_main.c | 16 ++---
 drivers/net/wireless/ath/ath9k/main.c         |  8 +--
 drivers/net/wireless/ath/carl9170/main.c      |  2 +-
 drivers/net/wireless/ath/wcn36xx/main.c       | 16 ++---
 drivers/net/wireless/ath/wcn36xx/smd.c        |  2 +-
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c | 12 ++--
 .../net/wireless/intel/iwlegacy/3945-mac.c    |  6 +-
 drivers/net/wireless/intel/iwlegacy/4965.c    |  6 +-
 drivers/net/wireless/intel/iwlegacy/common.c  | 10 ++--
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c | 16 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  2 +-
 .../intel/iwlwifi/mvm/ftm-initiator.c         | 10 ++--
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 12 ++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 24 ++++----
 .../wireless/intel/iwlwifi/mvm/offloading.c   |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/power.c    |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/quota.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sf.c   |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  2 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  8 +--
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  4 +-
 drivers/net/wireless/intersil/p54/main.c      |  4 +-
 drivers/net/wireless/mac80211_hwsim.c         |  6 +-
 drivers/net/wireless/marvell/mwl8k.c          | 10 ++--
 .../net/wireless/mediatek/mt76/mt7603/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  2 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 10 ++--
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  2 +-
 drivers/net/wireless/mediatek/mt7601u/phy.c   |  9 ++-
 .../net/wireless/ralink/rt2x00/rt2x00config.c |  4 +-
 .../net/wireless/ralink/rt2x00/rt2x00mac.c    |  2 +-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 10 ++--
 drivers/net/wireless/realtek/rtlwifi/core.c   |  4 +-
 drivers/net/wireless/realtek/rtw88/bf.c       |  2 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |  4 +-
 drivers/net/wireless/realtek/rtw88/main.c     | 13 +++--
 drivers/net/wireless/realtek/rtw89/cam.c      |  2 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  2 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  2 +-
 drivers/net/wireless/realtek/rtw89/phy.c      |  4 +-
 drivers/net/wireless/rsi/rsi_91x_core.c       |  3 +-
 drivers/net/wireless/rsi/rsi_91x_hal.c        |  5 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c   | 31 +++++-----
 drivers/net/wireless/rsi/rsi_91x_mgmt.c       |  3 +-
 drivers/net/wireless/silabs/wfx/hif_tx.c      | 12 ++--
 drivers/net/wireless/silabs/wfx/sta.c         | 24 ++++----
 drivers/net/wireless/st/cw1200/sta.c          | 36 ++++++------
 drivers/net/wireless/st/cw1200/txrx.c         |  4 +-
 drivers/net/wireless/ti/wl1251/main.c         |  8 +--
 drivers/net/wireless/ti/wlcore/cmd.c          |  4 +-
 drivers/net/wireless/ti/wlcore/main.c         | 35 +++++------
 drivers/staging/vt6655/device_main.c          |  6 +-
 drivers/staging/vt6656/main_usb.c             |  4 +-
 include/net/mac80211.h                        | 58 +++++++++++--------
 net/mac80211/cfg.c                            | 10 ++--
 net/mac80211/debugfs_netdev.c                 |  4 +-
 net/mac80211/ibss.c                           | 26 ++++-----
 net/mac80211/main.c                           | 10 ++--
 net/mac80211/mlme.c                           | 26 +++++----
 net/mac80211/offchannel.c                     |  2 +-
 net/mac80211/scan.c                           |  2 +-
 net/mac80211/tdls.c                           |  4 +-
 net/mac80211/trace.h                          | 39 ++++++++-----
 net/mac80211/tx.c                             |  2 +-
 net/mac80211/util.c                           |  2 +-
 76 files changed, 379 insertions(+), 343 deletions(-)

diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
index 9f84a6fde0c2..4cd06a0942d4 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -1256,14 +1256,14 @@ static int ar5523_create_connection(struct ar5523 *ar,
 				sizeof(create), 0);
 }
 
-static int ar5523_write_associd(struct ar5523 *ar,
-				struct ieee80211_bss_conf *bss)
+static int ar5523_write_associd(struct ar5523 *ar, struct ieee80211_vif *vif)
 {
+	struct ieee80211_bss_conf *bss = &vif->bss_conf;
 	struct ar5523_cmd_set_associd associd;
 
 	memset(&associd, 0, sizeof(associd));
 	associd.defaultrateix = cpu_to_be32(0);	/* XXX */
-	associd.associd = cpu_to_be32(bss->aid);
+	associd.associd = cpu_to_be32(vif->cfg.aid);
 	associd.timoffset = cpu_to_be32(0x3b);	/* XXX */
 	memcpy(associd.bssid, bss->bssid, ETH_ALEN);
 	return ar5523_cmd_write(ar, WDCMSG_WRITE_ASSOCID, &associd,
@@ -1284,7 +1284,7 @@ static void ar5523_bss_info_changed(struct ieee80211_hw *hw,
 	if (!(changed & BSS_CHANGED_ASSOC))
 		goto out_unlock;
 
-	if (bss->assoc) {
+	if (vif->cfg.assoc) {
 		error = ar5523_create_connection(ar, vif, bss);
 		if (error) {
 			ar5523_err(ar, "could not create connection\n");
@@ -1297,7 +1297,7 @@ static void ar5523_bss_info_changed(struct ieee80211_hw *hw,
 			goto out_unlock;
 		}
 
-		error = ar5523_write_associd(ar, bss);
+		error = ar5523_write_associd(ar, vif);
 		if (error) {
 			ar5523_err(ar, "could not set association\n");
 			goto out_unlock;
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 6407f509e91b..409777a15dcb 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -1509,8 +1509,8 @@ static int ath10k_vdev_start_restart(struct ath10k_vif *arvif,
 		arg.channel.chan_radar =
 			!!(chandef->chan->flags & IEEE80211_CHAN_RADAR);
 	} else if (arvif->vdev_type == WMI_VDEV_TYPE_IBSS) {
-		arg.ssid = arvif->vif->bss_conf.ssid;
-		arg.ssid_len = arvif->vif->bss_conf.ssid_len;
+		arg.ssid = arvif->vif->cfg.ssid;
+		arg.ssid_len = arvif->vif->cfg.ssid_len;
 	}
 
 	ath10k_dbg(ar, ATH10K_DBG_MAC,
@@ -1823,8 +1823,7 @@ static void ath10k_control_beaconing(struct ath10k_vif *arvif,
 }
 
 static void ath10k_control_ibss(struct ath10k_vif *arvif,
-				struct ieee80211_bss_conf *info,
-				const u8 self_peer[ETH_ALEN])
+				struct ieee80211_vif *vif)
 {
 	struct ath10k *ar = arvif->ar;
 	u32 vdev_param;
@@ -1832,7 +1831,7 @@ static void ath10k_control_ibss(struct ath10k_vif *arvif,
 
 	lockdep_assert_held(&arvif->ar->conf_mutex);
 
-	if (!info->ibss_joined) {
+	if (!vif->cfg.ibss_joined) {
 		if (is_zero_ether_addr(arvif->bssid))
 			return;
 
@@ -2163,7 +2162,7 @@ static void ath10k_peer_assoc_h_basic(struct ath10k *ar,
 	lockdep_assert_held(&ar->conf_mutex);
 
 	if (vif->type == NL80211_IFTYPE_STATION)
-		aid = vif->bss_conf.aid;
+		aid = vif->cfg.aid;
 	else
 		aid = sta->aid;
 
@@ -2193,7 +2192,8 @@ static void ath10k_peer_assoc_h_crypto(struct ath10k *ar,
 		return;
 
 	bss = cfg80211_get_bss(ar->hw->wiphy, def.chan, info->bssid,
-			       info->ssid_len ? info->ssid : NULL, info->ssid_len,
+			       vif->cfg.ssid_len ? vif->cfg.ssid : NULL,
+			       vif->cfg.ssid_len,
 			       IEEE80211_BSS_TYPE_ANY, IEEE80211_PRIVACY_ANY);
 	if (bss) {
 		const struct cfg80211_bss_ies *ies;
@@ -3118,11 +3118,11 @@ static void ath10k_bss_assoc(struct ieee80211_hw *hw,
 
 	ath10k_dbg(ar, ATH10K_DBG_MAC,
 		   "mac vdev %d up (associated) bssid %pM aid %d\n",
-		   arvif->vdev_id, bss_conf->bssid, bss_conf->aid);
+		   arvif->vdev_id, bss_conf->bssid, vif->cfg.aid);
 
 	WARN_ON(arvif->is_up);
 
-	arvif->aid = bss_conf->aid;
+	arvif->aid = vif->cfg.aid;
 	ether_addr_copy(arvif->bssid, bss_conf->bssid);
 
 	ret = ath10k_wmi_pdev_set_param(ar,
@@ -6048,7 +6048,7 @@ static void ath10k_bss_info_changed(struct ieee80211_hw *hw,
 	mutex_lock(&ar->conf_mutex);
 
 	if (changed & BSS_CHANGED_IBSS)
-		ath10k_control_ibss(arvif, info, vif->addr);
+		ath10k_control_ibss(arvif, vif);
 
 	if (changed & BSS_CHANGED_BEACON_INT) {
 		arvif->beacon_interval = info->beacon_int;
@@ -6113,9 +6113,10 @@ static void ath10k_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_SSID &&
 	    vif->type == NL80211_IFTYPE_AP) {
-		arvif->u.ap.ssid_len = info->ssid_len;
-		if (info->ssid_len)
-			memcpy(arvif->u.ap.ssid, info->ssid, info->ssid_len);
+		arvif->u.ap.ssid_len = vif->cfg.ssid_len;
+		if (vif->cfg.ssid_len)
+			memcpy(arvif->u.ap.ssid, vif->cfg.ssid,
+			       vif->cfg.ssid_len);
 		arvif->u.ap.hidden_ssid = info->hidden_ssid;
 	}
 
@@ -6192,7 +6193,7 @@ static void ath10k_bss_info_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_ASSOC) {
-		if (info->assoc) {
+		if (vif->cfg.assoc) {
 			/* Workaround: Make sure monitor vdev is not running
 			 * when associating to prevent some firmware revisions
 			 * (e.g. 10.1 and 10.2) from crashing.
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index f6ae3b308ac8..7ec0df2fc107 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1539,7 +1539,7 @@ static void ath11k_peer_assoc_h_basic(struct ath11k *ar,
 	lockdep_assert_held(&ar->conf_mutex);
 
 	if (vif->type == NL80211_IFTYPE_STATION)
-		aid = vif->bss_conf.aid;
+		aid = vif->cfg.aid;
 	else
 		aid = sta->aid;
 
@@ -2749,7 +2749,7 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 
 	WARN_ON(arvif->is_up);
 
-	arvif->aid = bss_conf->aid;
+	arvif->aid = vif->cfg.aid;
 	ether_addr_copy(arvif->bssid, bss_conf->bssid);
 
 	ret = ath11k_wmi_vdev_up(ar, arvif->vdev_id, arvif->aid, arvif->bssid);
@@ -2764,7 +2764,7 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
 		   "mac vdev %d up (associated) bssid %pM aid %d\n",
-		   arvif->vdev_id, bss_conf->bssid, bss_conf->aid);
+		   arvif->vdev_id, bss_conf->bssid, vif->cfg.aid);
 
 	spin_lock_bh(&ar->ab->base_lock);
 
@@ -3185,9 +3185,10 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_SSID &&
 	    vif->type == NL80211_IFTYPE_AP) {
-		arvif->u.ap.ssid_len = info->ssid_len;
-		if (info->ssid_len)
-			memcpy(arvif->u.ap.ssid, info->ssid, info->ssid_len);
+		arvif->u.ap.ssid_len = vif->cfg.ssid_len;
+		if (vif->cfg.ssid_len)
+			memcpy(arvif->u.ap.ssid, vif->cfg.ssid,
+			       vif->cfg.ssid_len);
 		arvif->u.ap.hidden_ssid = info->hidden_ssid;
 	}
 
@@ -3275,7 +3276,7 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_ASSOC) {
-		if (info->assoc)
+		if (vif->cfg.assoc)
 			ath11k_bss_assoc(hw, vif, info);
 		else
 			ath11k_bss_disassoc(hw, vif);
@@ -3406,14 +3407,15 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 		ath11k_mac_fils_discovery(arvif, info);
 
 	if (changed & BSS_CHANGED_ARP_FILTER) {
-		ipv4_cnt = min(info->arp_addr_cnt, ATH11K_IPV4_MAX_COUNT);
-		memcpy(arvif->arp_ns_offload.ipv4_addr, info->arp_addr_list,
+		ipv4_cnt = min(vif->cfg.arp_addr_cnt, ATH11K_IPV4_MAX_COUNT);
+		memcpy(arvif->arp_ns_offload.ipv4_addr,
+		       vif->cfg.arp_addr_list,
 		       ipv4_cnt * sizeof(u32));
 		memcpy(arvif->arp_ns_offload.mac_addr, vif->addr, ETH_ALEN);
 		arvif->arp_ns_offload.ipv4_count = ipv4_cnt;
 
 		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac arp_addr_cnt %d vif->addr %pM, offload_addr %pI4\n",
-			   info->arp_addr_cnt,
+			   vif->cfg.arp_addr_cnt,
 			   vif->addr, arvif->arp_ns_offload.ipv4_addr);
 	}
 
diff --git a/drivers/net/wireless/ath/ath5k/mac80211-ops.c b/drivers/net/wireless/ath/ath5k/mac80211-ops.c
index 532eeac9e83e..0df0fa1da181 100644
--- a/drivers/net/wireless/ath/ath5k/mac80211-ops.c
+++ b/drivers/net/wireless/ath/ath5k/mac80211-ops.c
@@ -278,9 +278,9 @@ ath5k_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	}
 
 	if (changes & BSS_CHANGED_ASSOC) {
-		avf->assoc = bss_conf->assoc;
-		if (bss_conf->assoc)
-			ah->assoc = bss_conf->assoc;
+		avf->assoc = vif->cfg.assoc;
+		if (vif->cfg.assoc)
+			ah->assoc = vif->cfg.assoc;
 		else
 			ah->assoc = ath5k_any_vif_assoc(ah);
 
@@ -288,11 +288,11 @@ ath5k_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			ath5k_set_beacon_filter(hw, ah->assoc);
 		ath5k_hw_set_ledstate(ah, ah->assoc ?
 			AR5K_LED_ASSOC : AR5K_LED_INIT);
-		if (bss_conf->assoc) {
+		if (vif->cfg.assoc) {
 			ATH5K_DBG(ah, ATH5K_DEBUG_ANY,
 				  "Bss Info ASSOC %d, bssid: %pM\n",
-				  bss_conf->aid, common->curbssid);
-			common->curaid = bss_conf->aid;
+				  vif->cfg.aid, common->curbssid);
+			common->curaid = vif->cfg.aid;
 			ath5k_hw_set_bssid(ah);
 			/* Once ANI is available you would start it here */
 		}
diff --git a/drivers/net/wireless/ath/ath9k/beacon.c b/drivers/net/wireless/ath/ath9k/beacon.c
index 8b1b966bcef1..d41988f8ea3f 100644
--- a/drivers/net/wireless/ath/ath9k/beacon.c
+++ b/drivers/net/wireless/ath/ath9k/beacon.c
@@ -585,8 +585,9 @@ static void ath9k_beacon_config_adhoc(struct ath_softc *sc,
 
 static void ath9k_cache_beacon_config(struct ath_softc *sc,
 				      struct ath_chanctx *ctx,
-				      struct ieee80211_bss_conf *bss_conf)
+				      struct ieee80211_vif *vif)
 {
+	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
 	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
 	struct ath_beacon_config *cur_conf = &ctx->beacon;
 
@@ -596,7 +597,7 @@ static void ath9k_cache_beacon_config(struct ath_softc *sc,
 	cur_conf->beacon_interval = bss_conf->beacon_int;
 	cur_conf->dtim_period = bss_conf->dtim_period;
 	cur_conf->dtim_count = 1;
-	cur_conf->ibss_creator = bss_conf->ibss_creator;
+	cur_conf->ibss_creator = vif->cfg.ibss_creator;
 
 	/*
 	 * It looks like mac80211 may end up using beacon interval of zero in
@@ -649,7 +650,7 @@ void ath9k_beacon_config(struct ath_softc *sc, struct ieee80211_vif *main_vif,
 	cur_conf->enable_beacon = beacons;
 
 	if (sc->sc_ah->opmode == NL80211_IFTYPE_STATION) {
-		ath9k_cache_beacon_config(sc, ctx, &main_vif->bss_conf);
+		ath9k_cache_beacon_config(sc, ctx, main_vif);
 
 		ath9k_set_beacon(sc);
 		set_bit(ATH_OP_BEACONS, &common->op_flags);
@@ -657,7 +658,7 @@ void ath9k_beacon_config(struct ath_softc *sc, struct ieee80211_vif *main_vif,
 	}
 
 	/* Update the beacon configuration. */
-	ath9k_cache_beacon_config(sc, ctx, &main_vif->bss_conf);
+	ath9k_cache_beacon_config(sc, ctx, main_vif);
 
 	/*
 	 * Configure the HW beacon registers only when we have a valid
@@ -670,7 +671,7 @@ void ath9k_beacon_config(struct ath_softc *sc, struct ieee80211_vif *main_vif,
 		 * IBSS interface.
 		 */
 		if (sc->sc_ah->opmode == NL80211_IFTYPE_ADHOC &&
-		    !enabled && beacons && !main_vif->bss_conf.ibss_creator) {
+		    !enabled && beacons && !main_vif->cfg.ibss_creator) {
 			spin_lock_irqsave(&sc->sc_pm_lock, flags);
 			sc->ps_flags |= PS_BEACON_SYNC | PS_WAIT_FOR_BEACON;
 			spin_unlock_irqrestore(&sc->sc_pm_lock, flags);
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_main.c b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
index cfee732a89b1..3a5ec4da6a38 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_main.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
@@ -100,7 +100,7 @@ static void ath9k_htc_vif_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
 		priv->rearm_ani = true;
 	}
 
-	if (bss_conf->assoc) {
+	if (vif->cfg.assoc) {
 		priv->rearm_ani = true;
 		priv->reconfig_beacon = true;
 	}
@@ -1488,8 +1488,8 @@ static void ath9k_htc_bss_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
 	struct ath_common *common = ath9k_hw_common(priv->ah);
 	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
 
-	if ((vif->type == NL80211_IFTYPE_STATION) && bss_conf->assoc) {
-		common->curaid = bss_conf->aid;
+	if ((vif->type == NL80211_IFTYPE_STATION) && vif->cfg.assoc) {
+		common->curaid = vif->cfg.aid;
 		common->last_rssi = ATH_RSSI_DUMMY_MARKER;
 		memcpy(common->curbssid, bss_conf->bssid, ETH_ALEN);
 		set_bit(ATH_OP_PRIM_STA_VIF, &common->op_flags);
@@ -1521,17 +1521,17 @@ static void ath9k_htc_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_ASSOC) {
 		ath_dbg(common, CONFIG, "BSS Changed ASSOC %d\n",
-			bss_conf->assoc);
+			vif->cfg.assoc);
 
-		bss_conf->assoc ?
+		vif->cfg.assoc ?
 			priv->num_sta_assoc_vif++ : priv->num_sta_assoc_vif--;
 
-		if (!bss_conf->assoc)
+		if (!vif->cfg.assoc)
 			clear_bit(ATH_OP_PRIM_STA_VIF, &common->op_flags);
 
 		if (priv->ah->opmode == NL80211_IFTYPE_STATION) {
 			ath9k_htc_choose_set_bssid(priv);
-			if (bss_conf->assoc && (priv->num_sta_assoc_vif == 1))
+			if (vif->cfg.assoc && (priv->num_sta_assoc_vif == 1))
 				ath9k_htc_start_ani(priv);
 			else if (priv->num_sta_assoc_vif == 0)
 				ath9k_htc_stop_ani(priv);
@@ -1540,7 +1540,7 @@ static void ath9k_htc_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_IBSS) {
 		if (priv->ah->opmode == NL80211_IFTYPE_ADHOC) {
-			common->curaid = bss_conf->aid;
+			common->curaid = vif->cfg.aid;
 			memcpy(common->curbssid, bss_conf->bssid, ETH_ALEN);
 			ath9k_htc_set_bssid(priv);
 		}
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index 77144647f4fc..56c2681e5192 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -1881,11 +1881,11 @@ static void ath9k_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_ASSOC) {
 		ath_dbg(common, CONFIG, "BSSID %pM Changed ASSOC %d\n",
-			bss_conf->bssid, bss_conf->assoc);
+			bss_conf->bssid, vif->cfg.assoc);
 
 		memcpy(avp->bssid, bss_conf->bssid, ETH_ALEN);
-		avp->aid = bss_conf->aid;
-		avp->assoc = bss_conf->assoc;
+		avp->aid = vif->cfg.aid;
+		avp->assoc = vif->cfg.assoc;
 
 		ath9k_calculate_summary_state(sc, avp->chanctx);
 	}
@@ -1893,7 +1893,7 @@ static void ath9k_bss_info_changed(struct ieee80211_hw *hw,
 	if ((changed & BSS_CHANGED_IBSS) ||
 	      (changed & BSS_CHANGED_OCB)) {
 		memcpy(common->curbssid, bss_conf->bssid, ETH_ALEN);
-		common->curaid = bss_conf->aid;
+		common->curaid = vif->cfg.aid;
 		ath9k_hw_write_associd(sc->sc_ah);
 	}
 
diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index 101295162967..e28a5f3085c0 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -1115,7 +1115,7 @@ static void carl9170_op_bss_info_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_ASSOC) {
-		ar->common.curaid = bss_conf->aid;
+		ar->common.curaid = vif->cfg.aid;
 		err = carl9170_set_beacon_timers(ar);
 		if (err)
 			goto out;
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index e34d3d0b7082..72ba2e2fc93a 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -919,17 +919,17 @@ static void wcn36xx_bss_info_changed(struct ieee80211_hw *hw,
 		wcn36xx_dbg(WCN36XX_DBG_MAC,
 			    "mac bss changed ssid\n");
 		wcn36xx_dbg_dump(WCN36XX_DBG_MAC, "ssid ",
-				 bss_conf->ssid, bss_conf->ssid_len);
+				 vif->cfg.ssid, vif->cfg.ssid_len);
 
-		vif_priv->ssid.length = bss_conf->ssid_len;
+		vif_priv->ssid.length = vif->cfg.ssid_len;
 		memcpy(&vif_priv->ssid.ssid,
-		       bss_conf->ssid,
-		       bss_conf->ssid_len);
+		       vif->cfg.ssid,
+		       vif->cfg.ssid_len);
 	}
 
 	if (changed & BSS_CHANGED_ASSOC) {
 		vif_priv->is_joining = false;
-		if (bss_conf->assoc) {
+		if (vif->cfg.assoc) {
 			struct ieee80211_sta *sta;
 			struct wcn36xx_sta *sta_priv;
 
@@ -937,7 +937,7 @@ static void wcn36xx_bss_info_changed(struct ieee80211_hw *hw,
 				    "mac assoc bss %pM vif %pM AID=%d\n",
 				     bss_conf->bssid,
 				     vif->addr,
-				     bss_conf->aid);
+				     vif->cfg.aid);
 
 			vif_priv->sta_assoc = true;
 
@@ -963,7 +963,7 @@ static void wcn36xx_bss_info_changed(struct ieee80211_hw *hw,
 			wcn36xx_smd_config_bss(wcn, vif, sta,
 					       bss_conf->bssid,
 					       true);
-			sta_priv->aid = bss_conf->aid;
+			sta_priv->aid = vif->cfg.aid;
 			/*
 			 * config_sta must be called from  because this is the
 			 * place where AID is available.
@@ -977,7 +977,7 @@ static void wcn36xx_bss_info_changed(struct ieee80211_hw *hw,
 				    "disassociated bss %pM vif %pM AID=%d\n",
 				    bss_conf->bssid,
 				    vif->addr,
-				    bss_conf->aid);
+				    vif->cfg.aid);
 			vif_priv->sta_assoc = false;
 			wcn36xx_smd_set_link_st(wcn,
 						bss_conf->bssid,
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 7ac9a1e6f768..46ab21824d63 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -3005,7 +3005,7 @@ int wcn36xx_smd_arp_offload(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 		msg_body.host_offload_params.enable =
 			WCN36XX_HAL_OFFLOAD_ARP_AND_BCAST_FILTER_ENABLE;
 		memcpy(&msg_body.host_offload_params.u,
-		       &vif->bss_conf.arp_addr_list[0], sizeof(__be32));
+		       &vif->cfg.arp_addr_list[0], sizeof(__be32));
 	}
 	msg_body.ns_offload_params.bss_index = vif_priv->bss_index;
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
index 8c741b98d8e5..e6cd638a85d6 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
@@ -507,7 +507,7 @@ brcms_ops_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 		brcms_c_start_station(wl->wlc, vif->addr);
 	else if (vif->type == NL80211_IFTYPE_AP)
 		brcms_c_start_ap(wl->wlc, vif->addr, vif->bss_conf.bssid,
-				 vif->bss_conf.ssid, vif->bss_conf.ssid_len);
+				 vif->cfg.ssid, vif->cfg.ssid_len);
 	else if (vif->type == NL80211_IFTYPE_ADHOC)
 		brcms_c_start_adhoc(wl->wlc, vif->addr);
 	spin_unlock_bh(&wl->lock);
@@ -592,9 +592,9 @@ brcms_ops_bss_info_changed(struct ieee80211_hw *hw,
 		 * also implies a change in the AID.
 		 */
 		brcms_err(core, "%s: %s: %sassociated\n", KBUILD_MODNAME,
-			  __func__, info->assoc ? "" : "dis");
+			  __func__, vif->cfg.assoc ? "" : "dis");
 		spin_lock_bh(&wl->lock);
-		brcms_c_associate_upd(wl->wlc, info->assoc);
+		brcms_c_associate_upd(wl->wlc, vif->cfg.assoc);
 		spin_unlock_bh(&wl->lock);
 	}
 	if (changed & BSS_CHANGED_ERP_SLOT) {
@@ -669,7 +669,7 @@ brcms_ops_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_SSID) {
 		/* BSSID changed, for whatever reason (IBSS and managed mode) */
 		spin_lock_bh(&wl->lock);
-		brcms_c_set_ssid(wl->wlc, info->ssid, info->ssid_len);
+		brcms_c_set_ssid(wl->wlc, vif->cfg.ssid, vif->cfg.ssid_len);
 		spin_unlock_bh(&wl->lock);
 	}
 	if (changed & BSS_CHANGED_BEACON) {
@@ -715,13 +715,13 @@ brcms_ops_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_IBSS) {
 		/* IBSS join status changed */
 		brcms_err(core, "%s: IBSS joined: %s (implement)\n",
-			  __func__, info->ibss_joined ? "true" : "false");
+			  __func__, vif->cfg.ibss_joined ? "true" : "false");
 	}
 
 	if (changed & BSS_CHANGED_ARP_FILTER) {
 		/* Hardware ARP filter address list or state changed */
 		brcms_err(core, "%s: arp filtering: %d addresses"
-			  " (implement)\n", __func__, info->arp_addr_cnt);
+			  " (implement)\n", __func__, vif->cfg.arp_addr_cnt);
 	}
 
 	if (changed & BSS_CHANGED_QOS) {
diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index bd4e7d752958..846138d6e33d 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -2701,7 +2701,7 @@ il3945_post_associate(struct il_priv *il)
 	if (!il->vif || !il->is_open)
 		return;
 
-	D_ASSOC("Associated as %d to: %pM\n", il->vif->bss_conf.aid,
+	D_ASSOC("Associated as %d to: %pM\n", il->vif->cfg.aid,
 		il->active.bssid_addr);
 
 	if (test_bit(S_EXIT_PENDING, &il->status))
@@ -2718,9 +2718,9 @@ il3945_post_associate(struct il_priv *il)
 
 	il->staging.filter_flags |= RXON_FILTER_ASSOC_MSK;
 
-	il->staging.assoc_id = cpu_to_le16(il->vif->bss_conf.aid);
+	il->staging.assoc_id = cpu_to_le16(il->vif->cfg.aid);
 
-	D_ASSOC("assoc id %d beacon interval %d\n", il->vif->bss_conf.aid,
+	D_ASSOC("assoc id %d beacon interval %d\n", il->vif->cfg.aid,
 		il->vif->bss_conf.beacon_int);
 
 	if (il->vif->bss_conf.use_short_preamble)
diff --git a/drivers/net/wireless/intel/iwlegacy/4965.c b/drivers/net/wireless/intel/iwlegacy/4965.c
index 9fa556486511..c34729f576cd 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965.c
@@ -1756,9 +1756,9 @@ il4965_post_associate(struct il_priv *il)
 	if (il->ops->set_rxon_chain)
 		il->ops->set_rxon_chain(il);
 
-	il->staging.assoc_id = cpu_to_le16(vif->bss_conf.aid);
+	il->staging.assoc_id = cpu_to_le16(vif->cfg.aid);
 
-	D_ASSOC("assoc id %d beacon interval %d\n", vif->bss_conf.aid,
+	D_ASSOC("assoc id %d beacon interval %d\n", vif->cfg.aid,
 		vif->bss_conf.beacon_int);
 
 	if (vif->bss_conf.use_short_preamble)
@@ -1775,7 +1775,7 @@ il4965_post_associate(struct il_priv *il)
 
 	il_commit_rxon(il);
 
-	D_ASSOC("Associated as %d to: %pM\n", vif->bss_conf.aid,
+	D_ASSOC("Associated as %d to: %pM\n", vif->cfg.aid,
 		il->active.bssid_addr);
 
 	switch (vif->type) {
diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index 8299d89e7505..b01945415be6 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -5427,8 +5427,8 @@ il_mac_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	}
 
 	if (changes & BSS_CHANGED_ASSOC) {
-		D_MAC80211("ASSOC %d\n", bss_conf->assoc);
-		if (bss_conf->assoc) {
+		D_MAC80211("ASSOC %d\n", vif->cfg.assoc);
+		if (vif->cfg.assoc) {
 			il->timestamp = bss_conf->sync_tsf;
 
 			if (!il_is_rfkill(il))
@@ -5437,7 +5437,7 @@ il_mac_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			il_set_no_assoc(il, vif);
 	}
 
-	if (changes && il_is_associated(il) && bss_conf->aid) {
+	if (changes && il_is_associated(il) && vif->cfg.aid) {
 		D_MAC80211("Changes (%#x) while associated\n", changes);
 		ret = il_send_rxon_assoc(il);
 		if (!ret) {
@@ -5459,10 +5459,10 @@ il_mac_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	if (changes & BSS_CHANGED_IBSS) {
 		ret = il->ops->manage_ibss_station(il, vif,
-						   bss_conf->ibss_joined);
+						   vif->cfg.ibss_joined);
 		if (ret)
 			IL_ERR("failed to %s IBSS station %pM\n",
-			       bss_conf->ibss_joined ? "add" : "remove",
+			       vif->cfg.ibss_joined ? "add" : "remove",
 			       bss_conf->bssid);
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c b/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
index 5dd2d43a01d8..bf756301f7f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
@@ -563,11 +563,11 @@ int iwlagn_set_pan_params(struct iwl_priv *priv)
 
 		if (test_bit(STATUS_SCAN_HW, &priv->status) ||
 		    (!ctx_bss->vif->bss_conf.idle &&
-		     !ctx_bss->vif->bss_conf.assoc)) {
+		     !ctx_bss->vif->cfg.assoc)) {
 			slot0 = dtim * bcnint * 3 - IWL_MIN_SLOT_TIME;
 			slot1 = IWL_MIN_SLOT_TIME;
 		} else if (!ctx_pan->vif->bss_conf.idle &&
-			   !ctx_pan->vif->bss_conf.assoc) {
+			   !ctx_pan->vif->cfg.assoc) {
 			slot1 = dtim * bcnint * 3 - IWL_MIN_SLOT_TIME;
 			slot0 = IWL_MIN_SLOT_TIME;
 		}
@@ -1420,14 +1420,14 @@ void iwlagn_bss_info_changed(struct ieee80211_hw *hw,
 		iwlagn_update_qos(priv, ctx);
 	}
 
-	ctx->staging.assoc_id = cpu_to_le16(vif->bss_conf.aid);
+	ctx->staging.assoc_id = cpu_to_le16(vif->cfg.aid);
 	if (vif->bss_conf.use_short_preamble)
 		ctx->staging.flags |= RXON_FLG_SHORT_PREAMBLE_MSK;
 	else
 		ctx->staging.flags &= ~RXON_FLG_SHORT_PREAMBLE_MSK;
 
 	if (changes & BSS_CHANGED_ASSOC) {
-		if (bss_conf->assoc) {
+		if (vif->cfg.assoc) {
 			priv->timestamp = bss_conf->sync_tsf;
 			ctx->staging.filter_flags |= RXON_FILTER_ASSOC_MSK;
 		} else {
@@ -1483,7 +1483,7 @@ void iwlagn_bss_info_changed(struct ieee80211_hw *hw,
 	 */
 
 	if (vif->type == NL80211_IFTYPE_STATION) {
-		if (!bss_conf->assoc)
+		if (!vif->cfg.assoc)
 			ctx->staging.filter_flags |= RXON_FILTER_BCON_AWARE_MSK;
 		else
 			ctx->staging.filter_flags &=
@@ -1493,7 +1493,7 @@ void iwlagn_bss_info_changed(struct ieee80211_hw *hw,
 	if (force || memcmp(&ctx->staging, &ctx->active, sizeof(ctx->staging)))
 		iwlagn_commit_rxon(priv, ctx);
 
-	if (changes & BSS_CHANGED_ASSOC && bss_conf->assoc) {
+	if (changes & BSS_CHANGED_ASSOC && vif->cfg.assoc) {
 		/*
 		 * The chain noise calibration will enable PM upon
 		 * completion. If calibration has already been run
@@ -1509,10 +1509,10 @@ void iwlagn_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changes & BSS_CHANGED_IBSS) {
 		ret = iwlagn_manage_ibss_station(priv, vif,
-						 bss_conf->ibss_joined);
+						 vif->cfg.ibss_joined);
 		if (ret)
 			IWL_ERR(priv, "failed to %s IBSS station %pM\n",
-				bss_conf->ibss_joined ? "add" : "remove",
+				vif->cfg.ibss_joined ? "add" : "remove",
 				bss_conf->bssid);
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index ed2a0678ccb7..35d6f54aced7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -311,7 +311,7 @@ static void iwl_mvm_bt_notif_iterator(void *_data, u8 *mac,
 		smps_mode = IEEE80211_SMPS_DYNAMIC;
 
 	/* relax SMPS constraints for next association */
-	if (!vif->bss_conf.assoc)
+	if (!vif->cfg.assoc)
 		smps_mode = IEEE80211_SMPS_AUTOMATIC;
 
 	if (mvmvif->phy_ctxt &&
@@ -382,7 +382,7 @@ static void iwl_mvm_bt_notif_iterator(void *_data, u8 *mac,
 	 *  we are not associated
 	 */
 	if (iwl_get_coex_type(mvm, vif) == BT_COEX_LOOSE_LUT ||
-	    mvm->cfg->bt_shared_single_ant || !vif->bss_conf.assoc ||
+	    mvm->cfg->bt_shared_single_ant || !vif->cfg.assoc ||
 	    le32_to_cpu(mvm->last_bt_notif.bt_activity_grading) == BT_OFF) {
 		iwl_mvm_bt_coex_reduced_txp(mvm, mvmvif->ap_sta_id, false);
 		iwl_mvm_bt_coex_enable_rssi_event(mvm, vif, false, 0);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 8edc8646a23a..aeb0015b73d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -749,7 +749,7 @@ static int iwl_mvm_d3_reprogram(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	/* add back the MAC */
 	mvmvif->uploaded = false;
 
-	if (WARN_ON(!vif->bss_conf.assoc))
+	if (WARN_ON(!vif->cfg.assoc))
 		return -EINVAL;
 
 	ret = iwl_mvm_mac_ctxt_add(mvm, vif);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 430044bc4755..efb070899d6b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -67,7 +67,7 @@ int iwl_mvm_ftm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	 * the TK is already configured for this station, so it
 	 * shouldn't be set again here.
 	 */
-	if (vif->bss_conf.assoc &&
+	if (vif->cfg.assoc &&
 	    !memcmp(addr, vif->bss_conf.bssid, ETH_ALEN)) {
 		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 		struct ieee80211_sta *sta;
@@ -222,7 +222,7 @@ static void iwl_mvm_ftm_cmd_v5(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	for (i = 0; i < ETH_ALEN; i++)
 		cmd->macaddr_mask[i] = ~req->mac_addr_mask[i];
 
-	if (vif->bss_conf.assoc)
+	if (vif->cfg.assoc)
 		memcpy(cmd->range_req_bssid, vif->bss_conf.bssid, ETH_ALEN);
 	else
 		eth_broadcast_addr(cmd->range_req_bssid);
@@ -254,7 +254,7 @@ static void iwl_mvm_ftm_cmd_common(struct iwl_mvm *mvm,
 	for (i = 0; i < ETH_ALEN; i++)
 		cmd->macaddr_mask[i] = ~req->mac_addr_mask[i];
 
-	if (vif->bss_conf.assoc) {
+	if (vif->cfg.assoc) {
 		memcpy(cmd->range_req_bssid, vif->bss_conf.bssid, ETH_ALEN);
 
 		/* AP's TSF is only relevant if associated */
@@ -503,7 +503,7 @@ iwl_mvm_ftm_put_target(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	iwl_mvm_ftm_put_target_common(mvm, peer, target);
 
-	if (vif->bss_conf.assoc &&
+	if (vif->cfg.assoc &&
 	    !memcmp(peer->addr, vif->bss_conf.bssid, ETH_ALEN)) {
 		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 		struct ieee80211_sta *sta;
@@ -693,7 +693,7 @@ iwl_mvm_ftm_set_secured_ranging(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		target->cipher = entry->cipher;
 		memcpy(target->hltk, entry->hltk, sizeof(target->hltk));
 
-		if (vif->bss_conf.assoc &&
+		if (vif->cfg.assoc &&
 		    !memcmp(vif->bss_conf.bssid, target->bssid,
 			    sizeof(target->bssid)))
 			ieee80211_iter_keys(mvm->hw, vif, iter, target);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 7756ac0faf3f..65df8cbb57d9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -570,7 +570,7 @@ static int iwl_mvm_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 	}
 
 	/* We need the dtim_period to set the MAC as associated */
-	if (vif->bss_conf.assoc && vif->bss_conf.dtim_period &&
+	if (vif->cfg.assoc && vif->bss_conf.dtim_period &&
 	    !force_assoc_off) {
 		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 		u32 dtim_offs;
@@ -628,9 +628,9 @@ static int iwl_mvm_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 					      vif->bss_conf.dtim_period);
 
 	ctxt_sta->listen_interval = cpu_to_le32(mvm->hw->conf.listen_interval);
-	ctxt_sta->assoc_id = cpu_to_le32(vif->bss_conf.aid);
+	ctxt_sta->assoc_id = cpu_to_le32(vif->cfg.aid);
 
-	if (vif->probe_req_reg && vif->bss_conf.assoc && vif->p2p)
+	if (vif->probe_req_reg && vif->cfg.assoc && vif->p2p)
 		cmd.filter_flags |= cpu_to_le32(MAC_FILTER_IN_PROBE_REQUEST);
 
 	if (vif->bss_conf.he_support && !iwlwifi_mod_params.disable_11ax) {
@@ -944,8 +944,8 @@ static int iwl_mvm_mac_ctxt_send_beacon_v9(struct iwl_mvm *mvm,
 			IWL_MAC_BEACON_FILS :
 			IWL_MAC_BEACON_FILS_V1;
 		beacon_cmd.short_ssid =
-			cpu_to_le32(~crc32_le(~0, vif->bss_conf.ssid,
-					      vif->bss_conf.ssid_len));
+			cpu_to_le32(~crc32_le(~0, vif->cfg.ssid,
+					      vif->cfg.ssid_len));
 	}
 	rcu_read_unlock();
 
@@ -1031,7 +1031,7 @@ static void iwl_mvm_mac_ap_iterator(void *_data, u8 *mac,
 {
 	struct iwl_mvm_mac_ap_iterator_data *data = _data;
 
-	if (vif->type != NL80211_IFTYPE_STATION || !vif->bss_conf.assoc)
+	if (vif->type != NL80211_IFTYPE_STATION || !vif->cfg.assoc)
 		return;
 
 	/* Station client has higher priority over P2P client*/
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index c5626ff83805..31290c0f210c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1614,7 +1614,7 @@ static void iwl_mvm_mc_iface_iterator(void *_data, u8 *mac,
 		return;
 
 	if (vif->type != NL80211_IFTYPE_STATION ||
-	    !vif->bss_conf.assoc)
+	    !vif->cfg.assoc)
 		return;
 
 	cmd->port_id = data->port_id++;
@@ -1740,7 +1740,7 @@ static void iwl_mvm_config_iface_filter(struct ieee80211_hw *hw,
 		return;
 
 	/* Supported only for p2p client interfaces */
-	if (vif->type != NL80211_IFTYPE_STATION || !vif->bss_conf.assoc ||
+	if (vif->type != NL80211_IFTYPE_STATION || !vif->cfg.assoc ||
 	    !vif->p2p)
 		return;
 
@@ -2191,7 +2191,7 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 	 * on the beacon interval, which was not known when the station
 	 * interface was added.
 	 */
-	if (changes & BSS_CHANGED_ASSOC && bss_conf->assoc) {
+	if (changes & BSS_CHANGED_ASSOC && vif->cfg.assoc) {
 		if (vif->bss_conf.he_support &&
 		    !iwlwifi_mod_params.disable_11ax)
 			iwl_mvm_cfg_he_sta(mvm, vif, mvmvif->ap_sta_id);
@@ -2201,7 +2201,7 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 
 	/* Update MU EDCA params */
 	if (changes & BSS_CHANGED_QOS && mvmvif->associated &&
-	    bss_conf->assoc && vif->bss_conf.he_support &&
+	    vif->cfg.assoc && vif->bss_conf.he_support &&
 	    !iwlwifi_mod_params.disable_11ax)
 		iwl_mvm_cfg_he_sta(mvm, vif, mvmvif->ap_sta_id);
 
@@ -2220,10 +2220,10 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 
 	/* after sending it once, adopt mac80211 data */
 	memcpy(mvmvif->bssid, bss_conf->bssid, ETH_ALEN);
-	mvmvif->associated = bss_conf->assoc;
+	mvmvif->associated = vif->cfg.assoc;
 
 	if (changes & BSS_CHANGED_ASSOC) {
-		if (bss_conf->assoc) {
+		if (vif->cfg.assoc) {
 			/* clear statistics to get clean beacon counter */
 			iwl_mvm_request_statistics(mvm, true);
 			memset(&mvmvif->beacon_stats, 0,
@@ -3020,7 +3020,7 @@ static void iwl_mvm_mei_host_associated(struct iwl_mvm *mvm,
 #if IS_ENABLED(CONFIG_IWLMEI)
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mei_conn_info conn_info = {
-		.ssid_len = vif->bss_conf.ssid_len,
+		.ssid_len = vif->cfg.ssid_len,
 		.channel = vif->bss_conf.chandef.chan->hw_value,
 	};
 
@@ -3068,7 +3068,7 @@ static void iwl_mvm_mei_host_associated(struct iwl_mvm *mvm,
 		return;
 	}
 
-	memcpy(conn_info.ssid, vif->bss_conf.ssid, vif->bss_conf.ssid_len);
+	memcpy(conn_info.ssid, vif->cfg.ssid, vif->cfg.ssid_len);
 	memcpy(conn_info.bssid,  vif->bss_conf.bssid, ETH_ALEN);
 
 	/* TODO: add support for collocated AP data */
@@ -3747,7 +3747,7 @@ static int iwl_mvm_send_aux_roc_cmd(struct iwl_mvm *mvm,
 	 * like the delay to be for 2-3 dtim intervals, in case there are
 	 * other time events with higher priority.
 	 */
-	if (vif->bss_conf.assoc) {
+	if (vif->cfg.assoc) {
 		delay = min_t(u32, dtim_interval * 3, AUX_ROC_MAX_DELAY);
 		/* We cannot remain off-channel longer than the DTIM interval */
 		if (dtim_interval <= req_dur) {
@@ -4502,7 +4502,7 @@ static int __iwl_mvm_mac_testmode_cmd(struct iwl_mvm *mvm,
 	case IWL_MVM_TM_CMD_SET_BEACON_FILTER:
 		/* must be associated client vif - ignore authorized */
 		if (!vif || vif->type != NL80211_IFTYPE_STATION ||
-		    !vif->bss_conf.assoc || !vif->bss_conf.dtim_period ||
+		    !vif->cfg.assoc || !vif->bss_conf.dtim_period ||
 		    !tb[IWL_MVM_TM_ATTR_BEACON_FILTER_STATE])
 			return -EINVAL;
 
@@ -4670,7 +4670,7 @@ static int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
 		 * we don't know the dtim period. In this case, the firmware can't
 		 * track the beacons.
 		 */
-		if (!vif->bss_conf.assoc || !vif->bss_conf.dtim_period) {
+		if (!vif->cfg.assoc || !vif->bss_conf.dtim_period) {
 			ret = -EBUSY;
 			goto out_unlock;
 		}
@@ -5069,7 +5069,7 @@ static void iwl_mvm_mac_sta_statistics(struct ieee80211_hw *hw,
 	if (!(vif->driver_flags & IEEE80211_VIF_BEACON_FILTER))
 		return;
 
-	if (!vif->bss_conf.assoc)
+	if (!vif->cfg.assoc)
 		return;
 
 	mutex_lock(&mvm->mutex);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c b/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c
index c7dabc6b3765..b1ded76299f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c
@@ -192,9 +192,9 @@ int iwl_mvm_send_proto_offload(struct iwl_mvm *mvm,
 		size = sizeof(cmd.v1);
 	}
 
-	if (vif->bss_conf.arp_addr_cnt) {
+	if (vif->cfg.arp_addr_cnt) {
 		enabled |= IWL_D3_PROTO_OFFLOAD_ARP | IWL_D3_PROTO_IPV4_VALID;
-		common->host_ipv4_addr = vif->bss_conf.arp_addr_list[0];
+		common->host_ipv4_addr = vif->cfg.arp_addr_list[0];
 		memcpy(common->arp_mac_addr, vif->addr, ETH_ALEN);
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index b2f33ebdf485..db43c8a83a31 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -162,7 +162,7 @@ static void iwl_mvm_rx_monitor_notif(struct iwl_mvm *mvm,
 	    vif->bss_conf.chandef.width < NL80211_CHAN_WIDTH_40)
 		return;
 
-	if (!vif->bss_conf.assoc)
+	if (!vif->cfg.assoc)
 		return;
 
 	/* this shouldn't happen *again*, ignore it */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index afdf3bb523e9..b49f265a421f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -223,7 +223,7 @@ static void iwl_mvm_p2p_standalone_iterator(void *_data, u8 *mac,
 		*is_p2p_standalone = false;
 		break;
 	case NL80211_IFTYPE_STATION:
-		if (vif->bss_conf.assoc)
+		if (vif->cfg.assoc)
 			*is_p2p_standalone = false;
 		break;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/quota.c b/drivers/net/wireless/intel/iwlwifi/mvm/quota.c
index c862bd243b55..0453f5d54885 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/quota.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/quota.c
@@ -47,7 +47,7 @@ static void iwl_mvm_quota_iterator(void *_data, u8 *mac,
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_STATION:
-		if (vif->bss_conf.assoc)
+		if (vif->cfg.assoc)
 			break;
 		return;
 	case NL80211_IFTYPE_AP:
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index a4077053e374..582a95ffc7ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1948,14 +1948,14 @@ static void iwl_mvm_scan_6ghz_passive_scan(struct iwl_mvm *mvm,
 	 * reset or resume flow, or while not associated and a large interval
 	 * has passed since the last 6GHz passive scan.
 	 */
-	if ((vif->bss_conf.assoc ||
+	if ((vif->cfg.assoc ||
 	     time_after(mvm->last_6ghz_passive_scan_jiffies +
 			(IWL_MVM_6GHZ_PASSIVE_SCAN_TIMEOUT * HZ), jiffies)) &&
 	    (time_before(mvm->last_reset_or_resume_time_jiffies +
 			 (IWL_MVM_6GHZ_PASSIVE_SCAN_ASSOC_TIMEOUT * HZ),
 			 jiffies))) {
 		IWL_DEBUG_SCAN(mvm, "6GHz passive scan: %s\n",
-			       vif->bss_conf.assoc ? "associated" :
+			       vif->cfg.assoc ? "associated" :
 			       "timeout did not expire");
 		return;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sf.c b/drivers/net/wireless/intel/iwlwifi/mvm/sf.c
index 693752d8f65b..22476a8364c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sf.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sf.c
@@ -31,7 +31,7 @@ static void iwl_mvm_bound_iface_iterator(void *_data, u8 *mac,
 
 	if (vif->type == NL80211_IFTYPE_STATION) {
 		data->sta_vif_ap_sta_id = mvmvif->ap_sta_id;
-		if (vif->bss_conf.assoc)
+		if (vif->cfg.assoc)
 			data->sta_vif_state = SF_FULL_ON;
 		else
 			data->sta_vif_state = SF_INIT_OFF;
@@ -261,7 +261,7 @@ int iwl_mvm_sf_update(struct iwl_mvm *mvm, struct ieee80211_vif *changed_vif,
 				return -EINVAL;
 			if (changed_vif->type != NL80211_IFTYPE_STATION) {
 				new_state = SF_UNINIT;
-			} else if (changed_vif->bss_conf.assoc &&
+			} else if (changed_vif->cfg.assoc &&
 				   changed_vif->bss_conf.dtim_period) {
 				mvmvif = iwl_mvm_vif_from_mac80211(changed_vif);
 				sta_id = mvmvif->ap_sta_id;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 406f0a50a5bf..3c7f65af22f7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1948,7 +1948,7 @@ int iwl_mvm_rm_sta(struct iwl_mvm *mvm,
 	if (vif->type == NL80211_IFTYPE_STATION &&
 	    mvmvif->ap_sta_id == sta_id) {
 		/* if associated - we can't remove the AP STA now */
-		if (vif->bss_conf.assoc)
+		if (vif->cfg.assoc)
 			return ret;
 
 		/* unassoc - go ahead - remove the AP STA now */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index b8c2fe639220..56a91e1f2d9a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -160,7 +160,7 @@ static bool iwl_mvm_te_check_disconnect(struct iwl_mvm *mvm,
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return false;
 
-	if (!mvmvif->csa_bcn_pending && vif->bss_conf.assoc &&
+	if (!mvmvif->csa_bcn_pending && vif->cfg.assoc &&
 	    vif->bss_conf.dtim_period)
 		return false;
 	if (errmsg)
@@ -176,7 +176,7 @@ static bool iwl_mvm_te_check_disconnect(struct iwl_mvm *mvm,
 		rcu_read_unlock();
 	}
 
-	if (vif->bss_conf.assoc) {
+	if (vif->cfg.assoc) {
 		/*
 		 * When not associated, this will be called from
 		 * iwl_mvm_event_mlme_callback_ini()
@@ -346,7 +346,7 @@ static void iwl_mvm_te_handle_notif(struct iwl_mvm *mvm,
 			 * and know the dtim period.
 			 */
 			iwl_mvm_te_check_disconnect(mvm, te_data->vif,
-				!te_data->vif->bss_conf.assoc ?
+				!te_data->vif->cfg.assoc ?
 				"Not associated and the time event is over already..." :
 				"No beacon heard and the time event is over already...");
 			break;
@@ -859,7 +859,7 @@ void iwl_mvm_rx_session_protect_notif(struct iwl_mvm *mvm,
 			 * and know the dtim period.
 			 */
 			iwl_mvm_te_check_disconnect(mvm, vif,
-						    !vif->bss_conf.assoc ?
+						    !vif->cfg.assoc ?
 						    "Not associated and the session protection is over already..." :
 						    "No beacon heard and the session protection is over already...");
 			spin_lock_bh(&mvm->time_event_lock);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index bc947733d982..3ee5ea3484be 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -604,7 +604,7 @@ static void iwl_mvm_sta_iface_iterator(void *_data, u8 *mac,
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return;
 
-	if (vif->bss_conf.assoc)
+	if (vif->cfg.assoc)
 		data->assoc = true;
 }
 
@@ -816,7 +816,7 @@ static void iwl_mvm_uapsd_agg_disconnect(struct iwl_mvm *mvm,
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return;
 
-	if (!vif->bss_conf.assoc)
+	if (!vif->cfg.assoc)
 		return;
 
 	if (!mvmvif->queue_params[IEEE80211_AC_VO].uapsd &&
diff --git a/drivers/net/wireless/intersil/p54/main.c b/drivers/net/wireless/intersil/p54/main.c
index a3ca6620dc0c..a9dfe6a3da0d 100644
--- a/drivers/net/wireless/intersil/p54/main.c
+++ b/drivers/net/wireless/intersil/p54/main.c
@@ -480,8 +480,8 @@ static void p54_bss_info_changed(struct ieee80211_hw *dev,
 			p54_scan(priv, P54_SCAN_EXIT, 0);
 	}
 	if (changed & BSS_CHANGED_ASSOC) {
-		if (info->assoc) {
-			priv->aid = info->aid;
+		if (vif->cfg.assoc) {
+			priv->aid = vif->cfg.aid;
 			priv->wakeup_timer = info->beacon_int *
 					     info->dtim_period * 5;
 			p54_setup_mac(priv);
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 53333e6ebdc2..b034d34745ab 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2119,9 +2119,9 @@ static void mac80211_hwsim_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_ASSOC) {
 		wiphy_dbg(hw->wiphy, "  ASSOC: assoc=%d aid=%d\n",
-			  info->assoc, info->aid);
-		vp->assoc = info->assoc;
-		vp->aid = info->aid;
+			  vif->cfg.assoc, vif->cfg.aid);
+		vp->assoc = vif->cfg.assoc;
+		vp->aid = vif->cfg.aid;
 	}
 
 	if (changed & BSS_CHANGED_BEACON_ENABLED) {
diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index 36c24d17136c..5f1bcfb5e3f6 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -3250,7 +3250,7 @@ mwl8k_cmd_set_aid(struct ieee80211_hw *hw,
 
 	cmd->header.code = cpu_to_le16(MWL8K_CMD_SET_AID);
 	cmd->header.length = cpu_to_le16(sizeof(*cmd));
-	cmd->aid = cpu_to_le16(vif->bss_conf.aid);
+	cmd->aid = cpu_to_le16(vif->cfg.aid);
 	memcpy(cmd->bssid, vif->bss_conf.bssid, ETH_ALEN);
 
 	if (vif->bss_conf.use_cts_prot) {
@@ -5013,13 +5013,13 @@ mwl8k_bss_info_changed_sta(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	/*
 	 * No need to capture a beacon if we're no longer associated.
 	 */
-	if ((changed & BSS_CHANGED_ASSOC) && !vif->bss_conf.assoc)
+	if ((changed & BSS_CHANGED_ASSOC) && !vif->cfg.assoc)
 		priv->capture_beacon = false;
 
 	/*
 	 * Get the AP's legacy and MCS rates.
 	 */
-	if (vif->bss_conf.assoc) {
+	if (vif->cfg.assoc) {
 		struct ieee80211_sta *ap;
 
 		rcu_read_lock();
@@ -5085,7 +5085,7 @@ mwl8k_bss_info_changed_sta(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			goto out;
 	}
 
-	if (vif->bss_conf.assoc && !priv->ap_fw &&
+	if (vif->cfg.assoc && !priv->ap_fw &&
 	    (changed & (BSS_CHANGED_ASSOC | BSS_CHANGED_ERP_CTS_PROT |
 			BSS_CHANGED_HT))) {
 		rc = mwl8k_cmd_set_aid(hw, vif, ap_legacy_rates);
@@ -5093,7 +5093,7 @@ mwl8k_bss_info_changed_sta(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			goto out;
 	}
 
-	if (vif->bss_conf.assoc &&
+	if (vif->cfg.assoc &&
 	    (changed & (BSS_CHANGED_ASSOC | BSS_CHANGED_BEACON_INT))) {
 		/*
 		 * Finalize the join.  Tell rx handler to process
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 91425b454cae..1f14ecda1f55 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -305,7 +305,7 @@ mt7603_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mutex_lock(&dev->mt76.mutex);
 
 	if (changed & (BSS_CHANGED_ASSOC | BSS_CHANGED_BSSID)) {
-		if (info->assoc || info->ibss_joined) {
+		if (vif->cfg.assoc || vif->cfg.ibss_joined) {
 			mt76_wr(dev, MT_BSSID0(mvif->idx),
 				get_unaligned_le32(info->bssid));
 			mt76_wr(dev, MT_BSSID1(mvif->idx),
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index a9c9b97d173e..d992fdea0f32 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -616,7 +616,7 @@ static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_ASSOC)
-		mt7615_mac_set_beacon_filter(phy, vif, info->assoc);
+		mt7615_mac_set_beacon_filter(phy, vif, vif->cfg.assoc);
 
 	mt7615_mutex_release(dev);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 8fb6c9d735dc..f58376733c67 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2530,7 +2530,7 @@ int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 		u8 pad;
 	} req = {
 		.bss_idx = mvif->mt76.idx,
-		.aid = cpu_to_le16(vif->bss_conf.aid),
+		.aid = cpu_to_le16(vif->cfg.aid),
 		.dtim_period = vif->bss_conf.dtim_period,
 		.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
 	};
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index faa279bbbcb2..d3da54e6670b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -402,7 +402,7 @@ void mt76_connac_mcu_sta_basic_tlv(struct sk_buff *skb,
 		else
 			conn_type = CONNECTION_INFRA_AP;
 		basic->conn_type = cpu_to_le32(conn_type);
-		basic->aid = cpu_to_le16(vif->bss_conf.aid);
+		basic->aid = cpu_to_le16(vif->cfg.aid);
 		break;
 	case NL80211_IFTYPE_ADHOC:
 		basic->conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
@@ -546,7 +546,7 @@ void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev,
 
 	if (sta) {
 		if (vif->type == NL80211_IFTYPE_STATION)
-			generic->partial_aid = cpu_to_le16(vif->bss_conf.aid);
+			generic->partial_aid = cpu_to_le16(vif->cfg.aid);
 		else
 			generic->partial_aid = cpu_to_le16(sta->aid);
 		memcpy(generic->peer_addr, sta->addr, ETH_ALEN);
@@ -2157,8 +2157,10 @@ int mt76_connac_mcu_update_arp_filter(struct mt76_dev *dev,
 				      struct mt76_vif *vif,
 				      struct ieee80211_bss_conf *info)
 {
+	struct ieee80211_vif *mvif = container_of(info, struct ieee80211_vif,
+						  bss_conf);
 	struct sk_buff *skb;
-	int i, len = min_t(int, info->arp_addr_cnt,
+	int i, len = min_t(int, mvif->cfg.arp_addr_cnt,
 			   IEEE80211_BSS_ARP_ADDR_LIST_LEN);
 	struct {
 		struct {
@@ -2186,7 +2188,7 @@ int mt76_connac_mcu_update_arp_filter(struct mt76_dev *dev,
 
 	skb_put_data(skb, &req_hdr, sizeof(req_hdr));
 	for (i = 0; i < len; i++)
-		skb_put_data(skb, &info->arp_addr_list[i], sizeof(__be32));
+		skb_put_data(skb, &mvif->cfg.arp_addr_list[i], sizeof(__be32));
 
 	return mt76_mcu_skb_send_msg(dev, skb, MCU_UNI_CMD(OFFLOAD), true);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 710ca757fb52..05327b0b6fc3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -593,7 +593,7 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_ASSOC) {
-		mt7915_mcu_add_bss_info(phy, vif, info->assoc);
+		mt7915_mcu_add_bss_info(phy, vif, vif->cfg.assoc);
 		mt7915_mcu_add_obss_spr(dev, vif, info->he_obss_pd.enable);
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 80279f342109..8532033794bd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -678,7 +678,7 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 		mt7921_mcu_sta_update(dev, NULL, vif, true,
 				      MT76_STA_INFO_STATE_ASSOC);
 		if (dev->pm.enable)
-			mt7921_mcu_set_beacon_filter(dev, vif, info->assoc);
+			mt7921_mcu_set_beacon_filter(dev, vif, vif->cfg.assoc);
 	}
 
 	if (changed & BSS_CHANGED_ARP_FILTER) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 12bab18c4171..64fc400bd981 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1036,7 +1036,7 @@ mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 		u8 pad;
 	} req = {
 		.bss_idx = mvif->mt76.idx,
-		.aid = cpu_to_le16(vif->bss_conf.aid),
+		.aid = cpu_to_le16(vif->cfg.aid),
 		.dtim_period = vif->bss_conf.dtim_period,
 		.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
 	};
diff --git a/drivers/net/wireless/mediatek/mt7601u/phy.c b/drivers/net/wireless/mediatek/mt7601u/phy.c
index 8a00f6a75ca9..d4cd2215aba9 100644
--- a/drivers/net/wireless/mediatek/mt7601u/phy.c
+++ b/drivers/net/wireless/mediatek/mt7601u/phy.c
@@ -1097,7 +1097,10 @@ static void mt7601u_phy_freq_cal(struct work_struct *work)
 void mt7601u_phy_con_cal_onoff(struct mt7601u_dev *dev,
 			       struct ieee80211_bss_conf *info)
 {
-	if (!info->assoc)
+	struct ieee80211_vif *vif = container_of(info, struct ieee80211_vif,
+						 bss_conf);
+
+	if (!vif->cfg.assoc)
 		cancel_delayed_work_sync(&dev->freq_cal.work);
 
 	/* Start/stop collecting beacon data */
@@ -1108,10 +1111,10 @@ void mt7601u_phy_con_cal_onoff(struct mt7601u_dev *dev,
 	spin_unlock_bh(&dev->con_mon_lock);
 
 	dev->freq_cal.freq = dev->ee->rf_freq_off;
-	dev->freq_cal.enabled = info->assoc;
+	dev->freq_cal.enabled = vif->cfg.assoc;
 	dev->freq_cal.adjusting = false;
 
-	if (info->assoc)
+	if (vif->cfg.assoc)
 		ieee80211_queue_delayed_work(dev->hw, &dev->freq_cal.work,
 					     MT_FREQ_CAL_INIT_DELAY);
 }
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00config.c b/drivers/net/wireless/ralink/rt2x00/rt2x00config.c
index 6bafdd991171..f895f560a185 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00config.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00config.c
@@ -70,6 +70,8 @@ void rt2x00lib_config_erp(struct rt2x00_dev *rt2x00dev,
 			  struct ieee80211_bss_conf *bss_conf,
 			  u32 changed)
 {
+	struct ieee80211_vif *vif = container_of(bss_conf, struct ieee80211_vif,
+						 bss_conf);
 	struct rt2x00lib_erp erp;
 
 	memset(&erp, 0, sizeof(erp));
@@ -87,7 +89,7 @@ void rt2x00lib_config_erp(struct rt2x00_dev *rt2x00dev,
 	erp.beacon_int = bss_conf->beacon_int;
 
 	/* Update the AID, this is needed for dynamic PS support */
-	rt2x00dev->aid = bss_conf->assoc ? bss_conf->aid : 0;
+	rt2x00dev->aid = vif->cfg.assoc ? vif->cfg.aid : 0;
 	rt2x00dev->last_beacon = bss_conf->sync_tsf;
 
 	/* Update global beacon interval time, this is needed for PS support */
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
index dea5babd30fe..660554a01894 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
@@ -645,7 +645,7 @@ void rt2x00mac_bss_info_changed(struct ieee80211_hw *hw,
 	if (changes & BSS_CHANGED_ASSOC) {
 		rt2x00dev->link.count = 0;
 
-		if (bss_conf->assoc)
+		if (vif->cfg.assoc)
 			rt2x00dev->intf_associated++;
 		else
 			rt2x00dev->intf_associated--;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 8b2ca9e8eac6..0239e12ec8a5 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4570,11 +4570,11 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	rarpt = &priv->ra_report;
 
 	if (changed & BSS_CHANGED_ASSOC) {
-		dev_dbg(dev, "Changed ASSOC: %i!\n", bss_conf->assoc);
+		dev_dbg(dev, "Changed ASSOC: %i!\n", vif->cfg.assoc);
 
 		rtl8xxxu_set_linktype(priv, vif->type);
 
-		if (bss_conf->assoc) {
+		if (vif->cfg.assoc) {
 			u32 ramask;
 			int sgi = 0;
 			u8 highest_rate;
@@ -4639,7 +4639,7 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 			/* joinbss sequence */
 			rtl8xxxu_write16(priv, REG_BCN_PSR_RPT,
-					 0xc000 | bss_conf->aid);
+					 0xc000 | vif->cfg.aid);
 
 			priv->fops->report_connect(priv, 0, true);
 		} else {
@@ -5405,7 +5405,7 @@ void rtl8723bu_handle_bt_inquiry(struct rtl8xxxu_priv *priv)
 
 	vif = priv->vif;
 	btcoex = &priv->bt_coex;
-	wifi_connected = (vif && vif->bss_conf.assoc);
+	wifi_connected = (vif && vif->cfg.assoc);
 
 	if (!wifi_connected) {
 		rtl8723bu_set_ps_tdma(priv, 0x8, 0x0, 0x0, 0x0, 0x0);
@@ -5431,7 +5431,7 @@ void rtl8723bu_handle_bt_info(struct rtl8xxxu_priv *priv)
 
 	vif = priv->vif;
 	btcoex = &priv->bt_coex;
-	wifi_connected = (vif && vif->bss_conf.assoc);
+	wifi_connected = (vif && vif->cfg.assoc);
 
 	if (wifi_connected) {
 		u32 val32 = 0;
diff --git a/drivers/net/wireless/realtek/rtlwifi/core.c b/drivers/net/wireless/realtek/rtlwifi/core.c
index 99a1d91ced5a..5177eb02740e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/core.c
+++ b/drivers/net/wireless/realtek/rtlwifi/core.c
@@ -1094,7 +1094,7 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_ASSOC) {
 		u8 mstatus;
 
-		if (bss_conf->assoc) {
+		if (vif->cfg.assoc) {
 			struct ieee80211_sta *sta = NULL;
 			u8 keep_alive = 10;
 
@@ -1111,7 +1111,7 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 
 			mac->link_state = MAC80211_LINKED;
 			mac->cnt_after_linked = 0;
-			mac->assoc_id = bss_conf->aid;
+			mac->assoc_id = vif->cfg.aid;
 			memcpy(mac->bssid, bss_conf->bssid, ETH_ALEN);
 
 			if (rtlpriv->cfg->ops->linked_set_reg)
diff --git a/drivers/net/wireless/realtek/rtw88/bf.c b/drivers/net/wireless/realtek/rtw88/bf.c
index e76841d3417b..76c7f3257dd3 100644
--- a/drivers/net/wireless/realtek/rtw88/bf.c
+++ b/drivers/net/wireless/realtek/rtw88/bf.c
@@ -67,7 +67,7 @@ void rtw_bf_assoc(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 		ether_addr_copy(bfee->mac_addr, bssid);
 		bfee->role = RTW_BFEE_MU;
 		bfee->p_aid = (bssid[5] << 1) | (bssid[4] >> 7);
-		bfee->aid = bss_conf->aid;
+		bfee->aid = vif->cfg.aid;
 		bfinfo->bfer_mu_cnt++;
 
 		rtw_chip_config_bfee(rtwdev, rtwvif, bfee, true);
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 30903c567cd9..52e2c93d02f0 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -369,12 +369,12 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_ASSOC) {
 		rtw_vif_assoc_changed(rtwvif, conf);
-		if (conf->assoc) {
+		if (vif->cfg.assoc) {
 			rtw_coex_connect_notify(rtwdev, COEX_ASSOCIATE_FINISH);
 
 			rtw_fw_download_rsvd_page(rtwdev);
 			rtw_send_rsvd_page_h2c(rtwdev);
-			rtw_coex_media_status_notify(rtwdev, conf->assoc);
+			rtw_coex_media_status_notify(rtwdev, vif->cfg.assoc);
 			if (rtw_bf_support)
 				rtw_bf_assoc(rtwdev, vif, conf);
 			rtw_store_op_chan(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 14289f83feb5..b151af13e310 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -171,7 +171,7 @@ static void rtw_vif_watch_dog_iter(void *data, u8 *mac,
 	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
 
 	if (vif->type == NL80211_IFTYPE_STATION)
-		if (vif->bss_conf.assoc)
+		if (vif->cfg.assoc)
 			iter_data->rtwvif = rtwvif;
 
 	rtw_dynamic_csi_rate(iter_data->rtwdev, rtwvif);
@@ -525,8 +525,13 @@ EXPORT_SYMBOL(rtw_dump_reg);
 void rtw_vif_assoc_changed(struct rtw_vif *rtwvif,
 			   struct ieee80211_bss_conf *conf)
 {
-	if (conf && conf->assoc) {
-		rtwvif->aid = conf->aid;
+	struct ieee80211_vif *vif = NULL;
+
+	if (conf)
+		vif = container_of(conf, struct ieee80211_vif, bss_conf);
+
+	if (conf && vif->cfg.assoc) {
+		rtwvif->aid = vif->cfg.aid;
 		rtwvif->net_type = RTW_NET_MGD_LINKED;
 	} else {
 		rtwvif->aid = 0;
@@ -1587,7 +1592,7 @@ static void rtw_vif_smps_iter(void *data, u8 *mac,
 {
 	struct rtw_dev *rtwdev = (struct rtw_dev *)data;
 
-	if (vif->type != NL80211_IFTYPE_STATION || !vif->bss_conf.assoc)
+	if (vif->type != NL80211_IFTYPE_STATION || !vif->cfg.assoc)
 		return;
 
 	if (rtwdev->hal.txrx_1ss)
diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 8a26adeb23fb..5e3f6a74a896 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -694,7 +694,7 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 	FWCMD_SET_ADDR_FRM_TGT_IND(cmd, rtwvif->frm_tgt_ind);
 	FWCMD_SET_ADDR_MACID(cmd, rtwsta ? rtwsta->mac_id : rtwvif->mac_id);
 	if (rtwvif->net_type == RTW89_NET_TYPE_INFRA)
-		FWCMD_SET_ADDR_AID12(cmd, vif->bss_conf.aid & 0xfff);
+		FWCMD_SET_ADDR_AID12(cmd, vif->cfg.aid & 0xfff);
 	else if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE)
 		FWCMD_SET_ADDR_AID12(cmd, sta ? sta->aid & 0xfff : 0);
 	FWCMD_SET_ADDR_WOL_PATTERN(cmd, rtwvif->wowlan_pattern);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e8a77225a90f..c86055341d91 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3674,7 +3674,7 @@ void rtw89_chip_cfg_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
-	if (!vif->bss_conf.he_support || !vif->bss_conf.assoc)
+	if (!vif->bss_conf.he_support || !vif->cfg.assoc)
 		return;
 
 	if (chip->ops->set_txpwr_ul_tb_offset)
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index f24e4a208376..6fc125deba28 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -345,7 +345,7 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 	rtw89_leave_ps_mode(rtwdev);
 
 	if (changed & BSS_CHANGED_ASSOC) {
-		if (conf->assoc) {
+		if (vif->cfg.assoc) {
 			rtw89_station_mode_sta_assoc(rtwdev, vif, conf);
 			rtw89_phy_set_bss_color(rtwdev, vif);
 			rtw89_chip_cfg_txpwr_ul_tb_offset(rtwdev, vif);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 762cdba9d3cf..e773f6869245 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3612,7 +3612,7 @@ void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif
 	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
 	u8 bss_color;
 
-	if (!vif->bss_conf.he_support || !vif->bss_conf.assoc)
+	if (!vif->bss_conf.he_support || !vif->cfg.assoc)
 		return;
 
 	bss_color = vif->bss_conf.he_bss_color.color;
@@ -3622,7 +3622,7 @@ void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif
 	rtw89_phy_write32_idx(rtwdev, R_BSS_CLR_MAP, B_BSS_CLR_MAP_TGT, bss_color,
 			      phy_idx);
 	rtw89_phy_write32_idx(rtwdev, R_BSS_CLR_MAP, B_BSS_CLR_MAP_STAID,
-			      vif->bss_conf.aid, phy_idx);
+			      vif->cfg.aid, phy_idx);
 }
 
 static void
diff --git a/drivers/net/wireless/rsi/rsi_91x_core.c b/drivers/net/wireless/rsi/rsi_91x_core.c
index 6bfaab48b507..0f3a80f66b61 100644
--- a/drivers/net/wireless/rsi/rsi_91x_core.c
+++ b/drivers/net/wireless/rsi/rsi_91x_core.c
@@ -420,7 +420,8 @@ void rsi_core_xmit(struct rsi_common *common, struct sk_buff *skb)
 			rsi_hal_send_sta_notify_frame(common,
 						      RSI_IFTYPE_STATION,
 						      STA_CONNECTED, bss->bssid,
-						      bss->qos, bss->aid, 0,
+						      bss->qos, vif->cfg.aid,
+						      0,
 						      vif);
 		}
 
diff --git a/drivers/net/wireless/rsi/rsi_91x_hal.c b/drivers/net/wireless/rsi/rsi_91x_hal.c
index dca81a4bbdd7..d7c0da8f315b 100644
--- a/drivers/net/wireless/rsi/rsi_91x_hal.c
+++ b/drivers/net/wireless/rsi/rsi_91x_hal.c
@@ -311,7 +311,7 @@ int rsi_send_data_pkt(struct rsi_common *common, struct sk_buff *skb)
 
 	if (((vif->type == NL80211_IFTYPE_STATION) ||
 	     (vif->type == NL80211_IFTYPE_P2P_CLIENT)) &&
-	    (!bss->assoc))
+	    (!vif->cfg.assoc))
 		goto err;
 
 	status = rsi_send_pkt_to_bus(common, skb);
@@ -367,7 +367,8 @@ int rsi_send_mgmt_pkt(struct rsi_common *common,
 	xtend_desc = (struct rsi_xtended_desc *)&skb->data[FRAME_DESC_SZ];
 
 	/* Indicate to firmware to give cfm for probe */
-	if (ieee80211_is_probe_req(wh->frame_control) && !bss->assoc) {
+	if (ieee80211_is_probe_req(wh->frame_control) &&
+	    !info->control.vif->cfg.assoc) {
 		rsi_dbg(INFO_ZONE,
 			"%s: blocking mgmt queue\n", __func__);
 		mgmt_desc->misc_flags = RSI_DESC_REQUIRE_CFM_TO_HOST;
diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index f01e82b90c07..d4b3834388ab 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -237,7 +237,6 @@ static int rsi_mac80211_hw_scan_start(struct ieee80211_hw *hw,
 	struct cfg80211_scan_request *scan_req = &hw_req->req;
 	struct rsi_hw *adapter = hw->priv;
 	struct rsi_common *common = adapter->priv;
-	struct ieee80211_bss_conf *bss = &vif->bss_conf;
 
 	rsi_dbg(INFO_ZONE, "***** Hardware scan start *****\n");
 	common->mac_ops_resumed = false;
@@ -256,7 +255,7 @@ static int rsi_mac80211_hw_scan_start(struct ieee80211_hw *hw,
 	/* If STA is not connected, return with special value 1, in order
 	 * to start sw_scan in mac80211
 	 */
-	if (!bss->assoc)
+	if (!vif->cfg.assoc)
 		return 1;
 
 	mutex_lock(&common->mutex);
@@ -579,7 +578,6 @@ static int rsi_channel_change(struct ieee80211_hw *hw)
 	struct ieee80211_channel *curchan = hw->conf.chandef.chan;
 	u16 channel = curchan->hw_value;
 	struct ieee80211_vif *vif;
-	struct ieee80211_bss_conf *bss;
 	bool assoc = false;
 	int i;
 
@@ -593,8 +591,7 @@ static int rsi_channel_change(struct ieee80211_hw *hw)
 		if (!vif)
 			continue;
 		if (vif->type == NL80211_IFTYPE_STATION) {
-			bss = &vif->bss_conf;
-			if (bss->assoc) {
+			if (vif->cfg.assoc) {
 				assoc = true;
 				break;
 			}
@@ -700,7 +697,7 @@ static int rsi_mac80211_config(struct ieee80211_hw *hw,
 			}
 			if ((vif->type == NL80211_IFTYPE_STATION ||
 			     vif->type == NL80211_IFTYPE_P2P_CLIENT) &&
-			    (!sta_vif || vif->bss_conf.assoc))
+			    (!sta_vif || vif->cfg.assoc))
 				sta_vif = vif;
 		}
 		if (set_ps && sta_vif) {
@@ -797,8 +794,8 @@ static void rsi_mac80211_bss_info_changed(struct ieee80211_hw *hw,
 	mutex_lock(&common->mutex);
 	if (changed & BSS_CHANGED_ASSOC) {
 		rsi_dbg(INFO_ZONE, "%s: Changed Association status: %d\n",
-			__func__, bss_conf->assoc);
-		if (bss_conf->assoc) {
+			__func__, vif->cfg.assoc);
+		if (vif->cfg.assoc) {
 			/* Send the RX filter frame */
 			rx_filter_word = (ALLOW_DATA_ASSOC_PEER |
 					  ALLOW_CTRL_ASSOC_PEER |
@@ -807,17 +804,17 @@ static void rsi_mac80211_bss_info_changed(struct ieee80211_hw *hw,
 		}
 		rsi_inform_bss_status(common,
 				      RSI_OPMODE_STA,
-				      bss_conf->assoc,
+				      vif->cfg.assoc,
 				      bss_conf->bssid,
 				      bss_conf->qos,
-				      bss_conf->aid,
+				      vif->cfg.aid,
 				      NULL, 0,
 				      bss_conf->assoc_capability, vif);
 		adapter->ps_info.dtim_interval_duration = bss->dtim_period;
 		adapter->ps_info.listen_interval = conf->listen_interval;
 
 		/* If U-APSD is updated, send ps parameters to firmware */
-		if (bss->assoc) {
+		if (vif->cfg.assoc) {
 			if (common->uapsd_bitmap) {
 				rsi_dbg(INFO_ZONE, "Configuring UAPSD\n");
 				rsi_conf_uapsd(adapter, vif);
@@ -1359,7 +1356,7 @@ static void rsi_fill_rx_status(struct ieee80211_hw *hw,
 	if (!bss)
 		return;
 	/* CQM only for connected AP beacons, the RSSI is a weighted avg */
-	if (bss->assoc && !(memcmp(bss->bssid, hdr->addr2, ETH_ALEN))) {
+	if (vif->cfg.assoc && !(memcmp(bss->bssid, hdr->addr2, ETH_ALEN))) {
 		if (ieee80211_is_beacon(hdr->frame_control))
 			rsi_perform_cqm(common, hdr->addr2, rxs->signal, vif);
 	}
@@ -1737,7 +1734,7 @@ static void rsi_resume_conn_channel(struct rsi_common *common)
 		}
 		if (((vif->type == NL80211_IFTYPE_STATION) ||
 		     (vif->type == NL80211_IFTYPE_P2P_CLIENT)) &&
-		    vif->bss_conf.assoc) {
+		    vif->cfg.assoc) {
 			rsi_switch_channel(adapter, vif);
 			break;
 		}
@@ -1862,17 +1859,15 @@ static u16 rsi_wow_map_triggers(struct rsi_common *common,
 int rsi_config_wowlan(struct rsi_hw *adapter, struct cfg80211_wowlan *wowlan)
 {
 	struct rsi_common *common = adapter->priv;
+	struct ieee80211_vif *vif = adapter->vifs[0];
 	u16 triggers = 0;
 	u16 rx_filter_word = 0;
-	struct ieee80211_bss_conf *bss = NULL;
 
 	rsi_dbg(INFO_ZONE, "Config WoWLAN to device\n");
 
-	if (!adapter->vifs[0])
+	if (!vif)
 		return -EINVAL;
 
-	bss = &adapter->vifs[0]->bss_conf;
-
 	if (WARN_ON(!wowlan)) {
 		rsi_dbg(ERR_ZONE, "WoW triggers not enabled\n");
 		return -EINVAL;
@@ -1884,7 +1879,7 @@ int rsi_config_wowlan(struct rsi_hw *adapter, struct cfg80211_wowlan *wowlan)
 		rsi_dbg(ERR_ZONE, "%s:No valid WoW triggers\n", __func__);
 		return -EINVAL;
 	}
-	if (!bss->assoc) {
+	if (!vif->cfg.assoc) {
 		rsi_dbg(ERR_ZONE,
 			"Cannot configure WoWLAN (Station not connected)\n");
 		common->wow_flags |= RSI_WOW_NO_CONNECTION;
diff --git a/drivers/net/wireless/rsi/rsi_91x_mgmt.c b/drivers/net/wireless/rsi/rsi_91x_mgmt.c
index c14689266fec..1b309e47a1f1 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mgmt.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mgmt.c
@@ -1635,7 +1635,6 @@ int rsi_send_ps_request(struct rsi_hw *adapter, bool enable,
 			struct ieee80211_vif *vif)
 {
 	struct rsi_common *common = adapter->priv;
-	struct ieee80211_bss_conf *bss = &vif->bss_conf;
 	struct rsi_request_ps *ps;
 	struct rsi_ps_info *ps_info;
 	struct sk_buff *skb;
@@ -1669,7 +1668,7 @@ int rsi_send_ps_request(struct rsi_hw *adapter, bool enable,
 	ps->ps_sleep.sleep_duration =
 		cpu_to_le32(ps_info->deep_sleep_wakeup_period);
 
-	if (bss->assoc)
+	if (vif->cfg.assoc)
 		ps->ps_sleep.connected_sleep = RSI_CONNECTED_SLEEP;
 	else
 		ps->ps_sleep.connected_sleep = RSI_DEEP_SLEEP;
diff --git a/drivers/net/wireless/silabs/wfx/hif_tx.c b/drivers/net/wireless/silabs/wfx/hif_tx.c
index 2b92c227efbc..85b053e4c40c 100644
--- a/drivers/net/wireless/silabs/wfx/hif_tx.c
+++ b/drivers/net/wireless/silabs/wfx/hif_tx.c
@@ -282,6 +282,8 @@ int wfx_hif_stop_scan(struct wfx_vif *wvif)
 int wfx_hif_join(struct wfx_vif *wvif, const struct ieee80211_bss_conf *conf,
 		 struct ieee80211_channel *channel, const u8 *ssid, int ssidlen)
 {
+	struct ieee80211_vif *vif = container_of(conf, struct ieee80211_vif,
+						 bss_conf);
 	int ret;
 	struct wfx_hif_msg *hif;
 	struct wfx_hif_req_join *body = wfx_alloc_hif(sizeof(*body), &hif);
@@ -289,10 +291,10 @@ int wfx_hif_join(struct wfx_vif *wvif, const struct ieee80211_bss_conf *conf,
 	WARN_ON(!conf->beacon_int);
 	WARN_ON(!conf->basic_rates);
 	WARN_ON(sizeof(body->ssid) < ssidlen);
-	WARN(!conf->ibss_joined && !ssidlen, "joining an unknown BSS");
+	WARN(!vif->cfg.ibss_joined && !ssidlen, "joining an unknown BSS");
 	if (!hif)
 		return -ENOMEM;
-	body->infrastructure_bss_mode = !conf->ibss_joined;
+	body->infrastructure_bss_mode = !vif->cfg.ibss_joined;
 	body->short_preamble = conf->use_short_preamble;
 	body->probe_for_join = !(channel->flags & IEEE80211_CHAN_NO_IR);
 	body->channel_number = channel->hw_value;
@@ -417,6 +419,8 @@ int wfx_hif_set_pm(struct wfx_vif *wvif, bool ps, int dynamic_ps_timeout)
 int wfx_hif_start(struct wfx_vif *wvif, const struct ieee80211_bss_conf *conf,
 		  const struct ieee80211_channel *channel)
 {
+        struct ieee80211_vif *vif = container_of(conf, struct ieee80211_vif,
+						 bss_conf);
 	int ret;
 	struct wfx_hif_msg *hif;
 	struct wfx_hif_req_start *body = wfx_alloc_hif(sizeof(*body), &hif);
@@ -429,8 +433,8 @@ int wfx_hif_start(struct wfx_vif *wvif, const struct ieee80211_bss_conf *conf,
 	body->channel_number = channel->hw_value;
 	body->beacon_interval = cpu_to_le32(conf->beacon_int);
 	body->basic_rate_set = cpu_to_le32(wfx_rate_mask_to_hw(wvif->wdev, conf->basic_rates));
-	body->ssid_length = conf->ssid_len;
-	memcpy(body->ssid, conf->ssid, conf->ssid_len);
+	body->ssid_length = vif->cfg.ssid_len;
+	memcpy(body->ssid, vif->cfg.ssid, vif->cfg.ssid_len);
 	wfx_fill_header(hif, wvif->id, HIF_REQ_ID_START, sizeof(*body));
 	ret = wfx_cmd_send(wvif->wdev, hif, NULL, 0, false);
 	kfree(hif);
diff --git a/drivers/net/wireless/silabs/wfx/sta.c b/drivers/net/wireless/silabs/wfx/sta.c
index e551fa284a43..3fc55c0c0b4d 100644
--- a/drivers/net/wireless/silabs/wfx/sta.c
+++ b/drivers/net/wireless/silabs/wfx/sta.c
@@ -156,7 +156,7 @@ static int wfx_get_ps_timeout(struct wfx_vif *wvif, bool *enable_ps)
 	struct ieee80211_conf *conf = &wvif->wdev->hw->conf;
 	struct ieee80211_vif *vif = wvif_to_vif(wvif);
 
-	WARN(!vif->bss_conf.assoc && enable_ps,
+	WARN(!vif->cfg.assoc && enable_ps,
 	     "enable_ps is reliable only if associated");
 	if (wdev_to_wvif(wvif->wdev, 0)) {
 		struct wfx_vif *wvif_ch0 = wdev_to_wvif(wvif->wdev, 0);
@@ -175,7 +175,7 @@ static int wfx_get_ps_timeout(struct wfx_vif *wvif, bool *enable_ps)
 			/* It is useless to enable PS if channels are the same. */
 			if (enable_ps)
 				*enable_ps = false;
-			if (vif->bss_conf.assoc && vif->bss_conf.ps)
+			if (vif->cfg.assoc && vif->bss_conf.ps)
 				dev_info(wvif->wdev->dev, "ignoring requested PS mode");
 			return -1;
 		}
@@ -189,7 +189,7 @@ static int wfx_get_ps_timeout(struct wfx_vif *wvif, bool *enable_ps)
 	}
 	if (enable_ps)
 		*enable_ps = vif->bss_conf.ps;
-	if (vif->bss_conf.assoc && vif->bss_conf.ps)
+	if (vif->cfg.assoc && vif->bss_conf.ps)
 		return conf->dynamic_ps_timeout;
 	else
 		return -1;
@@ -201,7 +201,7 @@ int wfx_update_pm(struct wfx_vif *wvif)
 	int ps_timeout;
 	bool ps;
 
-	if (!vif->bss_conf.assoc)
+	if (!vif->cfg.assoc)
 		return 0;
 	ps_timeout = wfx_get_ps_timeout(wvif, &ps);
 	if (!ps)
@@ -417,7 +417,7 @@ static void wfx_join(struct wfx_vif *wvif)
 
 	bss = cfg80211_get_bss(wvif->wdev->hw->wiphy, wvif->channel, conf->bssid, NULL, 0,
 			       IEEE80211_BSS_TYPE_ANY, IEEE80211_PRIVACY_ANY);
-	if (!bss && !conf->ibss_joined) {
+	if (!bss && !vif->cfg.ibss_joined) {
 		wfx_tx_unlock(wvif->wdev);
 		return;
 	}
@@ -458,7 +458,7 @@ static void wfx_join_finalize(struct wfx_vif *wvif, struct ieee80211_bss_conf *i
 	bool greenfield = false;
 
 	rcu_read_lock(); /* protect sta */
-	if (info->bssid && !info->ibss_joined)
+	if (info->bssid && !vif->cfg.ibss_joined)
 		sta = ieee80211_find_sta(vif, info->bssid);
 	if (sta && sta->deflink.ht_cap.ht_supported)
 		ampdu_density = sta->deflink.ht_cap.ampdu_density;
@@ -471,7 +471,7 @@ static void wfx_join_finalize(struct wfx_vif *wvif, struct ieee80211_bss_conf *i
 	wfx_hif_set_association_mode(wvif, ampdu_density, greenfield, info->use_short_preamble);
 	wfx_hif_keep_alive_period(wvif, 0);
 	/* beacon_loss_count is defined to 7 in net/mac80211/mlme.c. Let's use the same value. */
-	wfx_hif_set_bss_params(wvif, info->aid, 7);
+	wfx_hif_set_bss_params(wvif, vif->cfg.aid, 7);
 	wfx_hif_set_beacon_wakeup_period(wvif, 1, 1);
 	wfx_update_pm(wvif);
 }
@@ -522,9 +522,9 @@ void wfx_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	}
 
 	if (changed & BSS_CHANGED_ASSOC) {
-		if (info->assoc || info->ibss_joined)
+		if (vif->cfg.assoc || vif->cfg.ibss_joined)
 			wfx_join_finalize(wvif, info);
-		else if (!info->assoc && vif->type == NL80211_IFTYPE_STATION)
+		else if (!vif->cfg.assoc && vif->type == NL80211_IFTYPE_STATION)
 			wfx_reset(wvif);
 		else
 			dev_warn(wdev->dev, "misunderstood change: ASSOC\n");
@@ -540,11 +540,11 @@ void wfx_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	if (changed & BSS_CHANGED_ARP_FILTER) {
 		for (i = 0; i < HIF_MAX_ARP_IP_ADDRTABLE_ENTRIES; i++) {
-			__be32 *arp_addr = &info->arp_addr_list[i];
+			__be32 *arp_addr = &vif->cfg.arp_addr_list[i];
 
-			if (info->arp_addr_cnt > HIF_MAX_ARP_IP_ADDRTABLE_ENTRIES)
+			if (vif->cfg.arp_addr_cnt > HIF_MAX_ARP_IP_ADDRTABLE_ENTRIES)
 				arp_addr = NULL;
-			if (i >= info->arp_addr_cnt)
+			if (i >= vif->cfg.arp_addr_cnt)
 				arp_addr = NULL;
 			wfx_hif_set_arp_ipv4_filter(wvif, i, arp_addr);
 		}
diff --git a/drivers/net/wireless/st/cw1200/sta.c b/drivers/net/wireless/st/cw1200/sta.c
index 321df124d449..3f48def51ebc 100644
--- a/drivers/net/wireless/st/cw1200/sta.c
+++ b/drivers/net/wireless/st/cw1200/sta.c
@@ -1208,8 +1208,8 @@ static void cw1200_do_join(struct cw1200_common *priv)
 	struct cfg80211_bss *bss = NULL;
 	struct wsm_protected_mgmt_policy mgmt_policy;
 	struct wsm_join join = {
-		.mode = conf->ibss_joined ?
-				WSM_JOIN_MODE_IBSS : WSM_JOIN_MODE_BSS,
+		.mode = priv->vif->cfg.ibss_joined ?
+		WSM_JOIN_MODE_IBSS : WSM_JOIN_MODE_BSS,
 		.preamble_type = WSM_JOIN_PREAMBLE_LONG,
 		.probe_for_join = 1,
 		.atim_window = 0,
@@ -1230,7 +1230,7 @@ static void cw1200_do_join(struct cw1200_common *priv)
 	bss = cfg80211_get_bss(priv->hw->wiphy, priv->channel, bssid, NULL, 0,
 			       IEEE80211_BSS_TYPE_ANY, IEEE80211_PRIVACY_ANY);
 
-	if (!bss && !conf->ibss_joined) {
+	if (!bss && !priv->vif->cfg.ibss_joined) {
 		wsm_unlock_tx(priv);
 		return;
 	}
@@ -1284,7 +1284,7 @@ static void cw1200_do_join(struct cw1200_common *priv)
 		 join.bssid,
 		 join.dtim_period, priv->beacon_int);
 
-	if (!conf->ibss_joined) {
+	if (!priv->vif->cfg.ibss_joined) {
 		const u8 *ssidie;
 		rcu_read_lock();
 		ssidie = ieee80211_bss_get_ie(bss, WLAN_EID_SSID);
@@ -1302,7 +1302,7 @@ static void cw1200_do_join(struct cw1200_common *priv)
 	}
 
 	/* Enable asynchronous join calls */
-	if (!conf->ibss_joined) {
+	if (!priv->vif->cfg.ibss_joined) {
 		join.flags |= WSM_JOIN_FLAGS_FORCE;
 		join.flags |= WSM_JOIN_FLAGS_FORCE_WITH_COMPLETE_IND;
 	}
@@ -1813,15 +1813,15 @@ void cw1200_bss_info_changed(struct ieee80211_hw *dev,
 		int i;
 
 		pr_debug("[STA] BSS_CHANGED_ARP_FILTER cnt: %d\n",
-			 info->arp_addr_cnt);
+			 vif->cfg.arp_addr_cnt);
 
 		/* Currently only one IP address is supported by firmware.
 		 * In case of more IPs arp filtering will be disabled.
 		 */
-		if (info->arp_addr_cnt > 0 &&
-		    info->arp_addr_cnt <= WSM_MAX_ARP_IP_ADDRTABLE_ENTRIES) {
-			for (i = 0; i < info->arp_addr_cnt; i++) {
-				filter.ipv4addrs[i] = info->arp_addr_list[i];
+		if (vif->cfg.arp_addr_cnt > 0 &&
+		    vif->cfg.arp_addr_cnt <= WSM_MAX_ARP_IP_ADDRTABLE_ENTRIES) {
+			for (i = 0; i < vif->cfg.arp_addr_cnt; i++) {
+				filter.ipv4addrs[i] = vif->cfg.arp_addr_list[i];
 				pr_debug("[STA] addr[%d]: 0x%X\n",
 					 i, filter.ipv4addrs[i]);
 			}
@@ -1857,7 +1857,7 @@ void cw1200_bss_info_changed(struct ieee80211_hw *dev,
 
 	if (changed & BSS_CHANGED_BEACON_INT) {
 		pr_debug("CHANGED_BEACON_INT\n");
-		if (info->ibss_joined)
+		if (vif->cfg.ibss_joined)
 			do_join = true;
 		else if (priv->join_status == CW1200_JOIN_STATUS_AP)
 			cw1200_update_beaconing(priv);
@@ -1882,7 +1882,7 @@ void cw1200_bss_info_changed(struct ieee80211_hw *dev,
 	     BSS_CHANGED_BASIC_RATES |
 	     BSS_CHANGED_HT)) {
 		pr_debug("BSS_CHANGED_ASSOC\n");
-		if (info->assoc) {
+		if (vif->cfg.assoc) {
 			if (priv->join_status < CW1200_JOIN_STATUS_PRE_STA) {
 				ieee80211_connection_loss(vif);
 				mutex_unlock(&priv->conf_mutex);
@@ -1894,7 +1894,7 @@ void cw1200_bss_info_changed(struct ieee80211_hw *dev,
 			do_join = true;
 		}
 
-		if (info->assoc || info->ibss_joined) {
+		if (vif->cfg.assoc || vif->cfg.ibss_joined) {
 			struct ieee80211_sta *sta = NULL;
 			__le32 htprot = 0;
 
@@ -1904,7 +1904,7 @@ void cw1200_bss_info_changed(struct ieee80211_hw *dev,
 
 			rcu_read_lock();
 
-			if (info->bssid && !info->ibss_joined)
+			if (info->bssid && !vif->cfg.ibss_joined)
 				sta = ieee80211_find_sta(vif, info->bssid);
 			if (sta) {
 				priv->ht_info.ht_cap = sta->deflink.ht_cap;
@@ -1958,7 +1958,7 @@ void cw1200_bss_info_changed(struct ieee80211_hw *dev,
 			cancel_work_sync(&priv->unjoin_work);
 
 			priv->bss_params.beacon_lost_count = priv->cqm_beacon_loss_count;
-			priv->bss_params.aid = info->aid;
+			priv->bss_params.aid = vif->cfg.aid;
 
 			if (priv->join_dtim_period < 1)
 				priv->join_dtim_period = 1;
@@ -1973,7 +1973,7 @@ void cw1200_bss_info_changed(struct ieee80211_hw *dev,
 				 priv->association_mode.basic_rate_set);
 			wsm_set_association_mode(priv, &priv->association_mode);
 
-			if (!info->ibss_joined) {
+			if (!vif->cfg.ibss_joined) {
 				wsm_keep_alive_period(priv, 30 /* sec */);
 				wsm_set_bss_params(priv, &priv->bss_params);
 				priv->setbssparams_done = true;
@@ -2330,8 +2330,8 @@ static int cw1200_start_ap(struct cw1200_common *priv)
 
 	memset(start.ssid, 0, sizeof(start.ssid));
 	if (!conf->hidden_ssid) {
-		start.ssid_len = conf->ssid_len;
-		memcpy(start.ssid, conf->ssid, start.ssid_len);
+		start.ssid_len = priv->vif->cfg.ssid_len;
+		memcpy(start.ssid, priv->vif->cfg.ssid, start.ssid_len);
 	}
 
 	priv->beacon_int = conf->beacon_int;
diff --git a/drivers/net/wireless/st/cw1200/txrx.c b/drivers/net/wireless/st/cw1200/txrx.c
index 7de666b90ff5..fde21fca6c5e 100644
--- a/drivers/net/wireless/st/cw1200/txrx.c
+++ b/drivers/net/wireless/st/cw1200/txrx.c
@@ -1183,8 +1183,8 @@ void cw1200_rx_cb(struct cw1200_common *priv,
 
 		/* Disable beacon filter once we're associated... */
 		if (priv->disable_beacon_filter &&
-		    (priv->vif->bss_conf.assoc ||
-		     priv->vif->bss_conf.ibss_joined)) {
+		    (priv->vif->cfg.assoc ||
+		     priv->vif->cfg.ibss_joined)) {
 			priv->disable_beacon_filter = false;
 			queue_work(priv->workqueue,
 				   &priv->update_filtering_work);
diff --git a/drivers/net/wireless/ti/wl1251/main.c b/drivers/net/wireless/ti/wl1251/main.c
index a25a6143e65f..bdc93c4f54ba 100644
--- a/drivers/net/wireless/ti/wl1251/main.c
+++ b/drivers/net/wireless/ti/wl1251/main.c
@@ -1123,7 +1123,7 @@ static void wl1251_op_bss_info_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_ASSOC) {
-		if (bss_conf->assoc) {
+		if (vif->cfg.assoc) {
 			wl->beacon_int = bss_conf->beacon_int;
 
 			skb = ieee80211_pspoll_get(wl->hw, wl->vif);
@@ -1137,7 +1137,7 @@ static void wl1251_op_bss_info_changed(struct ieee80211_hw *hw,
 			if (ret < 0)
 				goto out_sleep;
 
-			ret = wl1251_acx_aid(wl, bss_conf->aid);
+			ret = wl1251_acx_aid(wl, vif->cfg.aid);
 			if (ret < 0)
 				goto out_sleep;
 		} else {
@@ -1176,10 +1176,10 @@ static void wl1251_op_bss_info_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_ARP_FILTER) {
-		__be32 addr = bss_conf->arp_addr_list[0];
+		__be32 addr = vif->cfg.arp_addr_list[0];
 		WARN_ON(wl->bss_type != BSS_TYPE_STA_BSS);
 
-		enable = bss_conf->arp_addr_cnt == 1 && bss_conf->assoc;
+		enable = vif->cfg.arp_addr_cnt == 1 && vif->cfg.assoc;
 		ret = wl1251_acx_arp_ip_filter(wl, enable, addr);
 		if (ret < 0)
 			goto out_sleep;
diff --git a/drivers/net/wireless/ti/wlcore/cmd.c b/drivers/net/wireless/ti/wlcore/cmd.c
index df6029ef6304..138edd28b0de 100644
--- a/drivers/net/wireless/ti/wlcore/cmd.c
+++ b/drivers/net/wireless/ti/wlcore/cmd.c
@@ -675,8 +675,8 @@ int wl12xx_cmd_role_start_ap(struct wl1271 *wl, struct wl12xx_vif *wlvif)
 		memcpy(cmd->ap.ssid, wlvif->ssid, wlvif->ssid_len);
 	} else {
 		cmd->ap.ssid_type = WL12XX_SSID_TYPE_HIDDEN;
-		cmd->ap.ssid_len = bss_conf->ssid_len;
-		memcpy(cmd->ap.ssid, bss_conf->ssid, bss_conf->ssid_len);
+		cmd->ap.ssid_len = vif->cfg.ssid_len;
+		memcpy(cmd->ap.ssid, vif->cfg.ssid, vif->cfg.ssid_len);
 	}
 
 	supported_rates = CONF_TX_ENABLED_RATES | CONF_TX_MCS_RATES |
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 21a9e3b0cbac..3195c07bdc12 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -2904,10 +2904,12 @@ static int wlcore_set_assoc(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 			    struct ieee80211_bss_conf *bss_conf,
 			    u32 sta_rate_set)
 {
+	struct ieee80211_vif *vif = container_of(bss_conf, struct ieee80211_vif,
+						 bss_conf);
 	int ieoffset;
 	int ret;
 
-	wlvif->aid = bss_conf->aid;
+	wlvif->aid = vif->cfg.aid;
 	wlvif->channel_type = cfg80211_get_chandef_type(&bss_conf->chandef);
 	wlvif->beacon_int = bss_conf->beacon_int;
 	wlvif->wmm_enabled = bss_conf->qos;
@@ -3935,7 +3937,6 @@ static int wl1271_ap_set_probe_resp_tmpl_legacy(struct wl1271 *wl,
 					     u32 rates)
 {
 	struct wl12xx_vif *wlvif = wl12xx_vif_to_data(vif);
-	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
 	u8 probe_rsp_templ[WL1271_CMD_TEMPL_MAX_SIZE];
 	int ssid_ie_offset, ie_offset, templ_len;
 	const u8 *ptr;
@@ -3948,7 +3949,7 @@ static int wl1271_ap_set_probe_resp_tmpl_legacy(struct wl1271 *wl,
 					       probe_rsp_len, 0,
 					       rates);
 
-	if (probe_rsp_len + bss_conf->ssid_len > WL1271_CMD_TEMPL_MAX_SIZE) {
+	if (probe_rsp_len + vif->cfg.ssid_len > WL1271_CMD_TEMPL_MAX_SIZE) {
 		wl1271_error("probe_rsp template too big");
 		return -EINVAL;
 	}
@@ -3970,12 +3971,12 @@ static int wl1271_ap_set_probe_resp_tmpl_legacy(struct wl1271 *wl,
 
 	/* insert SSID from bss_conf */
 	probe_rsp_templ[ssid_ie_offset] = WLAN_EID_SSID;
-	probe_rsp_templ[ssid_ie_offset + 1] = bss_conf->ssid_len;
+	probe_rsp_templ[ssid_ie_offset + 1] = vif->cfg.ssid_len;
 	memcpy(probe_rsp_templ + ssid_ie_offset + 2,
-	       bss_conf->ssid, bss_conf->ssid_len);
-	templ_len = ssid_ie_offset + 2 + bss_conf->ssid_len;
+	       vif->cfg.ssid, vif->cfg.ssid_len);
+	templ_len = ssid_ie_offset + 2 + vif->cfg.ssid_len;
 
-	memcpy(probe_rsp_templ + ssid_ie_offset + 2 + bss_conf->ssid_len,
+	memcpy(probe_rsp_templ + ssid_ie_offset + 2 + vif->cfg.ssid_len,
 	       ptr, probe_rsp_len - (ptr - probe_rsp_data));
 	templ_len += probe_rsp_len - (ptr - probe_rsp_data);
 
@@ -4255,15 +4256,15 @@ static void wl1271_bss_info_changed_ap(struct wl1271 *wl,
 }
 
 static int wlcore_set_bssid(struct wl1271 *wl, struct wl12xx_vif *wlvif,
-			    struct ieee80211_bss_conf *bss_conf,
-			    u32 sta_rate_set)
+			    struct ieee80211_vif *vif, u32 sta_rate_set)
 {
+	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
 	u32 rates;
 	int ret;
 
 	wl1271_debug(DEBUG_MAC80211,
 	     "changed_bssid: %pM, aid: %d, bcn_int: %d, brates: 0x%x sta_rate_set: 0x%x",
-	     bss_conf->bssid, bss_conf->aid,
+	     bss_conf->bssid, vif->cfg.aid,
 	     bss_conf->beacon_int,
 	     bss_conf->basic_rates, sta_rate_set);
 
@@ -4351,7 +4352,7 @@ static void wl1271_bss_info_changed_sta(struct wl1271 *wl,
 	}
 
 	if (changed & BSS_CHANGED_IBSS) {
-		if (bss_conf->ibss_joined) {
+		if (vif->cfg.ibss_joined) {
 			set_bit(WLVIF_FLAG_IBSS_JOINED, &wlvif->flags);
 			ibss_joined = true;
 		} else {
@@ -4411,7 +4412,7 @@ static void wl1271_bss_info_changed_sta(struct wl1271 *wl,
 
 	if (changed & BSS_CHANGED_BSSID) {
 		if (!is_zero_ether_addr(bss_conf->bssid)) {
-			ret = wlcore_set_bssid(wl, wlvif, bss_conf,
+			ret = wlcore_set_bssid(wl, wlvif, vif,
 					       sta_rate_set);
 			if (ret < 0)
 				goto out;
@@ -4427,9 +4428,9 @@ static void wl1271_bss_info_changed_sta(struct wl1271 *wl,
 
 	if (changed & BSS_CHANGED_IBSS) {
 		wl1271_debug(DEBUG_ADHOC, "ibss_joined: %d",
-			     bss_conf->ibss_joined);
+			     vif->cfg.ibss_joined);
 
-		if (bss_conf->ibss_joined) {
+		if (vif->cfg.ibss_joined) {
 			u32 rates = bss_conf->basic_rates;
 			wlvif->basic_rate_set =
 				wl1271_tx_enabled_rates_get(wl, rates,
@@ -4466,7 +4467,7 @@ static void wl1271_bss_info_changed_sta(struct wl1271 *wl,
 	}
 
 	if (changed & BSS_CHANGED_ASSOC) {
-		if (bss_conf->assoc) {
+		if (vif->cfg.assoc) {
 			ret = wlcore_set_assoc(wl, wlvif, bss_conf,
 					       sta_rate_set);
 			if (ret < 0)
@@ -4541,11 +4542,11 @@ static void wl1271_bss_info_changed_sta(struct wl1271 *wl,
 	/* Handle arp filtering. Done after join. */
 	if ((changed & BSS_CHANGED_ARP_FILTER) ||
 	    (!is_ibss && (changed & BSS_CHANGED_QOS))) {
-		__be32 addr = bss_conf->arp_addr_list[0];
+		__be32 addr = vif->cfg.arp_addr_list[0];
 		wlvif->sta.qos = bss_conf->qos;
 		WARN_ON(wlvif->bss_type != BSS_TYPE_STA_BSS);
 
-		if (bss_conf->arp_addr_cnt == 1 && bss_conf->assoc) {
+		if (vif->cfg.arp_addr_cnt == 1 && vif->cfg.assoc) {
 			wlvif->ip_addr = addr;
 			/*
 			 * The template should have been configured only upon
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 897d70cf32b8..741e1b9d6677 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -980,7 +980,7 @@ static void vnt_check_bb_vga(struct vnt_private *priv)
 	if (priv->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
 		return;
 
-	if (!(priv->vif->bss_conf.assoc && priv->current_rssi))
+	if (!(priv->vif->cfg.assoc && priv->current_rssi))
 		return;
 
 	RFvRSSITodBm(priv, (u8)priv->current_rssi, &dbm);
@@ -1400,7 +1400,7 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 {
 	struct vnt_private *priv = hw->priv;
 
-	priv->current_aid = conf->aid;
+	priv->current_aid = vif->cfg.aid;
 
 	if (changed & BSS_CHANGED_BSSID && conf->bssid) {
 		unsigned long flags;
@@ -1469,7 +1469,7 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & (BSS_CHANGED_ASSOC | BSS_CHANGED_BEACON_INFO) &&
 	    priv->op_mode != NL80211_IFTYPE_AP) {
-		if (conf->assoc && conf->beacon_rate) {
+		if (vif->cfg.assoc && conf->beacon_rate) {
 			CARDbUpdateTSF(priv, conf->beacon_rate->hw_value,
 				       conf->sync_tsf);
 
diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
index ae7f5916d4d6..3ab8a7bb9715 100644
--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -749,7 +749,7 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 {
 	struct vnt_private *priv = hw->priv;
 
-	priv->current_aid = conf->aid;
+	priv->current_aid = vif->cfg.aid;
 
 	if (changed & BSS_CHANGED_BSSID && conf->bssid)
 		vnt_mac_set_bssid_addr(priv, (u8 *)conf->bssid);
@@ -811,7 +811,7 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & (BSS_CHANGED_ASSOC | BSS_CHANGED_BEACON_INFO) &&
 	    priv->op_mode != NL80211_IFTYPE_AP) {
-		if (conf->assoc && conf->beacon_rate) {
+		if (vif->cfg.assoc && conf->beacon_rate) {
 			u16 ps_beacon_int = conf->beacon_int;
 
 			if (conf->dtim_period)
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index e3ded46f70ac..48f786d1e9d5 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -526,11 +526,6 @@ struct ieee80211_fils_discovery {
  *	mode only, set if the AP advertises TWT responder role)
  * @twt_protected: does this BSS support protected TWT frames
  * @twt_broadcast: does this BSS support broadcast TWT
- * @assoc: association status
- * @ibss_joined: indicates whether this station is part of an IBSS
- *	or not
- * @ibss_creator: indicates if a new IBSS network is being created
- * @aid: association ID number, valid only when @assoc is true
  * @use_cts_prot: use CTS protection
  * @use_short_preamble: use 802.11b short preamble
  * @use_short_slot: use short slot time (only relevant for ERP)
@@ -551,6 +546,8 @@ struct ieee80211_fils_discovery {
  *	IMPORTANT: These three sync_* parameters would possibly be out of sync
  *	by the time the driver will use them. The synchronized view is currently
  *	guaranteed only in certain callbacks.
+ *	Note also that this is not used with MLD associations, mac80211 doesn't
+ *	know how to track beacons for all of the links for this.
  * @beacon_int: beacon interval
  * @assoc_capability: capabilities taken from assoc resp
  * @basic_rates: bitmap of basic rates, each bit stands for an
@@ -576,21 +573,12 @@ struct ieee80211_fils_discovery {
  *	threshold event and can't be enabled simultaneously with it.
  * @cqm_rssi_high: Connection quality monitor RSSI upper threshold.
  * @cqm_rssi_hyst: Connection quality monitor RSSI hysteresis
- * @arp_addr_list: List of IPv4 addresses for hardware ARP filtering. The
- *	may filter ARP queries targeted for other addresses than listed here.
- *	The driver must allow ARP queries targeted for all address listed here
- *	to pass through. An empty list implies no ARP queries need to pass.
- * @arp_addr_cnt: Number of addresses currently on the list. Note that this
- *	may be larger than %IEEE80211_BSS_ARP_ADDR_LIST_LEN (the arp_addr_list
- *	array size), it's up to the driver what to do in that case.
  * @qos: This is a QoS-enabled BSS.
  * @idle: This interface is idle. There's also a global idle flag in the
  *	hardware config which may be more appropriate depending on what
  *	your driver/device needs to do.
  * @ps: power-save mode (STA only). This flag is NOT affected by
  *	offchannel/dynamic_ps operations.
- * @ssid: The SSID of the current vif. Valid in AP and IBSS mode.
- * @ssid_len: Length of SSID given in @ssid.
  * @hidden_ssid: The SSID of the current vif is hidden. Only valid in AP-mode.
  * @txpower: TX power in dBm.  INT_MIN means not configured.
  * @txpower_type: TX power adjustment used to control per packet Transmit
@@ -628,7 +616,6 @@ struct ieee80211_fils_discovery {
  * @fils_discovery: FILS discovery configuration
  * @unsol_bcast_probe_resp_interval: Unsolicited broadcast probe response
  *	interval.
- * @s1g: BSS is S1G BSS (affects Association Request format).
  * @beacon_tx_rate: The configured beacon transmit rate that needs to be passed
  *	to driver when rate control is offloaded to firmware.
  * @power_type: power type of BSS for 6 GHz
@@ -661,10 +648,6 @@ struct ieee80211_bss_conf {
 	bool twt_responder;
 	bool twt_protected;
 	bool twt_broadcast;
-	/* association related data */
-	bool assoc, ibss_joined;
-	bool ibss_creator;
-	u16 aid;
 	/* erp related data */
 	bool use_cts_prot;
 	bool use_short_preamble;
@@ -686,13 +669,9 @@ struct ieee80211_bss_conf {
 	s32 cqm_rssi_high;
 	struct cfg80211_chan_def chandef;
 	struct ieee80211_mu_group_data mu_group;
-	__be32 arp_addr_list[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
-	int arp_addr_cnt;
 	bool qos;
 	bool idle;
 	bool ps;
-	u8 ssid[IEEE80211_MAX_SSID_LEN];
-	size_t ssid_len;
 	bool hidden_ssid;
 	int txpower;
 	enum nl80211_tx_power_setting txpower_type;
@@ -717,7 +696,6 @@ struct ieee80211_bss_conf {
 	struct cfg80211_he_bss_color he_bss_color;
 	struct ieee80211_fils_discovery fils_discovery;
 	u32 unsol_bcast_probe_resp_interval;
-	bool s1g;
 	struct cfg80211_bitrate_mask beacon_tx_rate;
 	enum ieee80211_ap_reg_power power_type;
 	struct ieee80211_tx_pwr_env tx_pwr_env[IEEE80211_TPE_MAX_IE_COUNT];
@@ -1721,6 +1699,36 @@ enum ieee80211_offload_flags {
 	IEEE80211_OFFLOAD_DECAP_ENABLED		= BIT(2),
 };
 
+/**
+ * struct ieee80211_vif_cfg - interface configuration
+ * @assoc: association status
+ * @ibss_joined: indicates whether this station is part of an IBSS or not
+ * @ibss_creator: indicates if a new IBSS network is being created
+ * @aid: association ID number, valid only when @assoc is true
+ * @arp_addr_list: List of IPv4 addresses for hardware ARP filtering. The
+ *	may filter ARP queries targeted for other addresses than listed here.
+ *	The driver must allow ARP queries targeted for all address listed here
+ *	to pass through. An empty list implies no ARP queries need to pass.
+ * @arp_addr_cnt: Number of addresses currently on the list. Note that this
+ *	may be larger than %IEEE80211_BSS_ARP_ADDR_LIST_LEN (the arp_addr_list
+ *	array size), it's up to the driver what to do in that case.
+ * @ssid: The SSID of the current vif. Valid in AP and IBSS mode.
+ * @ssid_len: Length of SSID given in @ssid.
+ * @s1g: BSS is S1G BSS (affects Association Request format).
+ */
+struct ieee80211_vif_cfg {
+	/* association related data */
+	bool assoc, ibss_joined;
+	bool ibss_creator;
+	u16 aid;
+
+	__be32 arp_addr_list[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
+	int arp_addr_cnt;
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+	size_t ssid_len;
+	bool s1g;
+};
+
 /**
  * struct ieee80211_vif - per-interface data
  *
@@ -1728,6 +1736,7 @@ enum ieee80211_offload_flags {
  * use during the life of a virtual interface.
  *
  * @type: type of this virtual interface
+ * @cfg: vif configuration, see &struct ieee80211_vif_cfg
  * @bss_conf: BSS configuration for this interface, either our own
  *	or the BSS we're associated to
  * @addr: address of this interface
@@ -1762,6 +1771,7 @@ enum ieee80211_offload_flags {
  */
 struct ieee80211_vif {
 	enum nl80211_iftype type;
+	struct ieee80211_vif_cfg cfg;
 	struct ieee80211_bss_conf bss_conf;
 	u8 addr[ETH_ALEN] __aligned(2);
 	bool p2p;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 5915772713e1..1b23403602fc 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1214,12 +1214,12 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	sdata->vif.bss_conf.twt_responder = params->twt_responder;
 	sdata->vif.bss_conf.he_obss_pd = params->he_obss_pd;
 	sdata->vif.bss_conf.he_bss_color = params->beacon.he_bss_color;
-	sdata->vif.bss_conf.s1g = params->chandef.chan->band ==
+	sdata->vif.cfg.s1g = params->chandef.chan->band ==
 				  NL80211_BAND_S1GHZ;
 
-	sdata->vif.bss_conf.ssid_len = params->ssid_len;
+	sdata->vif.cfg.ssid_len = params->ssid_len;
 	if (params->ssid_len)
-		memcpy(sdata->vif.bss_conf.ssid, params->ssid,
+		memcpy(sdata->vif.cfg.ssid, params->ssid,
 		       params->ssid_len);
 	sdata->vif.bss_conf.hidden_ssid =
 		(params->hidden_ssid != NL80211_HIDDEN_SSID_NOT_IN_USE);
@@ -1403,7 +1403,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 
 	sdata->vif.bss_conf.enable_beacon = false;
 	sdata->beacon_rate_set = false;
-	sdata->vif.bss_conf.ssid_len = 0;
+	sdata->vif.cfg.ssid_len = 0;
 	clear_bit(SDATA_STATE_OFFCHANNEL_BEACON_STOPPED, &sdata->state);
 	ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_BEACON_ENABLED);
 
@@ -3486,7 +3486,7 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 
 		break;
 	case NL80211_IFTYPE_ADHOC:
-		if (!sdata->vif.bss_conf.ibss_joined)
+		if (!sdata->vif.cfg.ibss_joined)
 			return -EINVAL;
 
 		if (params->chandef.width != sdata->u.ibss.chandef.width)
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index cf71484658c6..dd71cb7b3f75 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -233,7 +233,7 @@ IEEE80211_IF_FILE_R(hw_queues);
 
 /* STA attributes */
 IEEE80211_IF_FILE(bssid, u.mgd.bssid, MAC);
-IEEE80211_IF_FILE(aid, vif.bss_conf.aid, DEC);
+IEEE80211_IF_FILE(aid, vif.cfg.aid, DEC);
 IEEE80211_IF_FILE(beacon_timeout, u.mgd.beacon_timeout, JIFFIES_TO_MS);
 
 static int ieee80211_set_smps(struct ieee80211_sub_if_data *sdata,
@@ -366,7 +366,7 @@ IEEE80211_IF_FILE_W(tkip_mic_test);
 static ssize_t ieee80211_if_parse_beacon_loss(
 	struct ieee80211_sub_if_data *sdata, const char *buf, int buflen)
 {
-	if (!ieee80211_sdata_running(sdata) || !sdata->vif.bss_conf.assoc)
+	if (!ieee80211_sdata_running(sdata) || !sdata->vif.cfg.assoc)
 		return -ENOTCONN;
 
 	ieee80211_beacon_loss(&sdata->vif);
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index aebae1f4d288..056da2ff65f4 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -244,9 +244,9 @@ static void __ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 		sta_info_flush(sdata);
 
 	/* if merging, indicate to driver that we leave the old IBSS */
-	if (sdata->vif.bss_conf.ibss_joined) {
-		sdata->vif.bss_conf.ibss_joined = false;
-		sdata->vif.bss_conf.ibss_creator = false;
+	if (sdata->vif.cfg.ibss_joined) {
+		sdata->vif.cfg.ibss_joined = false;
+		sdata->vif.cfg.ibss_creator = false;
 		sdata->vif.bss_conf.enable_beacon = false;
 		netif_carrier_off(sdata->dev);
 		ieee80211_bss_info_change_notify(sdata,
@@ -326,8 +326,8 @@ static void __ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 	sdata->vif.bss_conf.enable_beacon = true;
 	sdata->vif.bss_conf.beacon_int = beacon_int;
 	sdata->vif.bss_conf.basic_rates = basic_rates;
-	sdata->vif.bss_conf.ssid_len = ifibss->ssid_len;
-	memcpy(sdata->vif.bss_conf.ssid, ifibss->ssid, ifibss->ssid_len);
+	sdata->vif.cfg.ssid_len = ifibss->ssid_len;
+	memcpy(sdata->vif.cfg.ssid, ifibss->ssid, ifibss->ssid_len);
 	bss_change = BSS_CHANGED_BEACON_INT;
 	bss_change |= ieee80211_reset_erp_info(sdata);
 	bss_change |= BSS_CHANGED_BSSID;
@@ -359,15 +359,15 @@ static void __ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 
 	ieee80211_set_wmm_default(sdata, true, false);
 
-	sdata->vif.bss_conf.ibss_joined = true;
-	sdata->vif.bss_conf.ibss_creator = creator;
+	sdata->vif.cfg.ibss_joined = true;
+	sdata->vif.cfg.ibss_creator = creator;
 
 	err = drv_join_ibss(local, sdata);
 	if (err) {
-		sdata->vif.bss_conf.ibss_joined = false;
-		sdata->vif.bss_conf.ibss_creator = false;
+		sdata->vif.cfg.ibss_joined = false;
+		sdata->vif.cfg.ibss_creator = false;
 		sdata->vif.bss_conf.enable_beacon = false;
-		sdata->vif.bss_conf.ssid_len = 0;
+		sdata->vif.cfg.ssid_len = 0;
 		RCU_INIT_POINTER(ifibss->presp, NULL);
 		kfree_rcu(presp, rcu_head);
 		mutex_lock(&local->mtx);
@@ -708,10 +708,10 @@ static void ieee80211_ibss_disconnect(struct ieee80211_sub_if_data *sdata)
 
 	netif_carrier_off(sdata->dev);
 
-	sdata->vif.bss_conf.ibss_joined = false;
-	sdata->vif.bss_conf.ibss_creator = false;
+	sdata->vif.cfg.ibss_joined = false;
+	sdata->vif.cfg.ibss_creator = false;
 	sdata->vif.bss_conf.enable_beacon = false;
-	sdata->vif.bss_conf.ssid_len = 0;
+	sdata->vif.cfg.ssid_len = 0;
 
 	/* remove beacon */
 	presp = rcu_dereference_protected(ifibss->presp,
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index ebde131efcaa..0c81ae492df4 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -349,7 +349,7 @@ static int ieee80211_ifa_changed(struct notifier_block *nb,
 	struct wireless_dev *wdev = ndev->ieee80211_ptr;
 	struct in_device *idev;
 	struct ieee80211_sub_if_data *sdata;
-	struct ieee80211_bss_conf *bss_conf;
+	struct ieee80211_vif_cfg *vif_cfg;
 	struct ieee80211_if_managed *ifmgd;
 	int c = 0;
 
@@ -361,7 +361,7 @@ static int ieee80211_ifa_changed(struct notifier_block *nb,
 		return NOTIFY_DONE;
 
 	sdata = IEEE80211_DEV_TO_SUB_IF(ndev);
-	bss_conf = &sdata->vif.bss_conf;
+	vif_cfg = &sdata->vif.cfg;
 
 	/* ARP filtering is only supported in managed mode */
 	if (sdata->vif.type != NL80211_IFTYPE_STATION)
@@ -374,16 +374,16 @@ static int ieee80211_ifa_changed(struct notifier_block *nb,
 	ifmgd = &sdata->u.mgd;
 	sdata_lock(sdata);
 
-	/* Copy the addresses to the bss_conf list */
+	/* Copy the addresses to the vif config list */
 	ifa = rtnl_dereference(idev->ifa_list);
 	while (ifa) {
 		if (c < IEEE80211_BSS_ARP_ADDR_LIST_LEN)
-			bss_conf->arp_addr_list[c] = ifa->ifa_address;
+			vif_cfg->arp_addr_list[c] = ifa->ifa_address;
 		ifa = rtnl_dereference(ifa->ifa_next);
 		c++;
 	}
 
-	bss_conf->arp_addr_cnt = c;
+	vif_cfg->arp_addr_cnt = c;
 
 	/* Configure driver only if associated (which also implies it is up) */
 	if (ifmgd->associated)
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index c526af66ff8d..4a792e88568d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2258,6 +2258,7 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_bss *bss = (void *)cbss->priv;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
+	struct ieee80211_vif_cfg *vif_cfg = &sdata->vif.cfg;
 
 	bss_info_changed |= BSS_CHANGED_ASSOC;
 	bss_info_changed |= ieee80211_handle_bss_capability(sdata,
@@ -2317,7 +2318,7 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 		bss_conf->dtim_period = 0;
 	}
 
-	bss_conf->assoc = 1;
+	vif_cfg->assoc = 1;
 
 	/* Tell the driver to monitor connection quality (if supported) */
 	if (sdata->vif.driver_flags & IEEE80211_VIF_SUPPORTS_CQM_RSSI &&
@@ -2325,7 +2326,7 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 		bss_info_changed |= BSS_CHANGED_CQM;
 
 	/* Enable ARP filtering */
-	if (bss_conf->arp_addr_cnt)
+	if (vif_cfg->arp_addr_cnt)
 		bss_info_changed |= BSS_CHANGED_ARP_FILTER;
 
 	ieee80211_bss_info_change_notify(sdata, bss_info_changed);
@@ -2419,7 +2420,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	/* clear bssid only after building the needed mgmt frames */
 	eth_zero_addr(ifmgd->bssid);
 
-	sdata->vif.bss_conf.ssid_len = 0;
+	sdata->vif.cfg.ssid_len = 0;
 
 	/* remove AP and TDLS peers */
 	sta_info_flush(sdata);
@@ -2429,7 +2430,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	ieee80211_led_assoc(local, 0);
 	changed |= BSS_CHANGED_ASSOC;
-	sdata->vif.bss_conf.assoc = false;
+	sdata->vif.cfg.assoc = false;
 
 	ifmgd->p2p_noa_index = -1;
 	memset(&sdata->vif.bss_conf.p2p_noa_attr, 0,
@@ -2455,7 +2456,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	cancel_work_sync(&local->dynamic_ps_enable_work);
 
 	/* Disable ARP filtering */
-	if (sdata->vif.bss_conf.arp_addr_cnt)
+	if (sdata->vif.cfg.arp_addr_cnt)
 		changed |= BSS_CHANGED_ARP_FILTER;
 
 	sdata->vif.bss_conf.qos = false;
@@ -2642,8 +2643,8 @@ static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 		ieee80211_send_nullfunc(sdata->local, sdata, false);
 	} else {
 		ieee80211_mlme_send_probe_req(sdata, sdata->vif.addr, dst,
-					      sdata->vif.bss_conf.ssid,
-					      sdata->vif.bss_conf.ssid_len,
+					      sdata->vif.cfg.ssid,
+					      sdata->vif.cfg.ssid_len,
 					      ifmgd->assoc_bss->channel);
 	}
 
@@ -3425,7 +3426,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		goto out;
 	}
 
-	sdata->vif.bss_conf.aid = aid;
+	sdata->vif.cfg.aid = aid;
 	ifmgd->tdls_chan_switch_prohibited =
 		elems->ext_capab && elems->ext_capab_len >= 5 &&
 		(elems->ext_capab[4] & WLAN_EXT_CAPA5_TDLS_CH_SW_PROHIBITED);
@@ -4102,6 +4103,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
+	struct ieee80211_vif_cfg *vif_cfg = &sdata->vif.cfg;
 	struct ieee80211_mgmt *mgmt = (void *) hdr;
 	size_t baselen;
 	struct ieee802_11_elems *elems;
@@ -4226,7 +4228,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	ncrc = elems->crc;
 
 	if (ieee80211_hw_check(&local->hw, PS_NULLFUNC_STACK) &&
-	    ieee80211_check_tim(elems->tim, elems->tim_len, bss_conf->aid)) {
+	    ieee80211_check_tim(elems->tim, elems->tim_len, vif_cfg->aid)) {
 		if (local->hw.conf.dynamic_ps_timeout > 0) {
 			if (local->hw.conf.flags & IEEE80211_CONF_PS) {
 				local->hw.conf.flags &= ~IEEE80211_CONF_PS;
@@ -5877,7 +5879,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_mgd_assoc_data *assoc_data;
 	const struct cfg80211_bss_ies *beacon_ies;
 	struct ieee80211_supported_band *sband;
-	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
+	struct ieee80211_vif_cfg *vif_cfg = &sdata->vif.cfg;
 	const struct element *ssid_elem, *ht_elem, *vht_elem;
 	int i, err;
 	bool override = false;
@@ -5895,8 +5897,8 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	}
 	memcpy(assoc_data->ssid, ssid_elem->data, ssid_elem->datalen);
 	assoc_data->ssid_len = ssid_elem->datalen;
-	memcpy(bss_conf->ssid, assoc_data->ssid, assoc_data->ssid_len);
-	bss_conf->ssid_len = assoc_data->ssid_len;
+	memcpy(vif_cfg->ssid, assoc_data->ssid, assoc_data->ssid_len);
+	vif_cfg->ssid_len = assoc_data->ssid_len;
 	rcu_read_unlock();
 
 	if (ifmgd->associated) {
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index b62d382433f9..5e20e19e7679 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -785,7 +785,7 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_ADHOC:
-		if (!sdata->vif.bss_conf.ibss_joined)
+		if (!sdata->vif.cfg.ibss_joined)
 			need_offchan = true;
 #ifdef CONFIG_MAC80211_MESH
 		fallthrough;
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index b698756887eb..f80284eee055 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -177,7 +177,7 @@ ieee80211_bss_info_update(struct ieee80211_local *local,
 	rcu_read_lock();
 	scan_sdata = rcu_dereference(local->scan_sdata);
 	if (scan_sdata && scan_sdata->vif.type == NL80211_IFTYPE_STATION &&
-	    scan_sdata->vif.bss_conf.assoc &&
+	    scan_sdata->vif.cfg.assoc &&
 	    ieee80211_have_rx_timestamp(rx_status)) {
 		bss_meta.parent_tsf =
 			ieee80211_calculate_rx_timestamp(local, rx_status,
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 1902bcffb21b..dc3f149ce18f 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -230,7 +230,7 @@ ieee80211_tdls_add_aid(struct ieee80211_sub_if_data *sdata, struct sk_buff *skb)
 
 	*pos++ = WLAN_EID_AID;
 	*pos++ = 2; /* len */
-	put_unaligned_le16(sdata->vif.bss_conf.aid, pos);
+	put_unaligned_le16(sdata->vif.cfg.aid, pos);
 }
 
 /* translate numbering in the WMM parameter IE to the mac80211 notation */
@@ -1444,7 +1444,7 @@ void ieee80211_tdls_oper_request(struct ieee80211_vif *vif, const u8 *peer,
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 
-	if (vif->type != NL80211_IFTYPE_STATION || !vif->bss_conf.assoc) {
+	if (vif->type != NL80211_IFTYPE_STATION || !vif->cfg.assoc) {
 		sdata_err(sdata, "Discarding TDLS oper %d - not STA or disconnected\n",
 			  oper);
 		return;
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 743adfbb9b15..42a6fdbb9c70 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -425,14 +425,14 @@ TRACE_EVENT(drv_bss_info_changed,
 		__field(u32, channel_cfreq1)
 		__field(u32, channel_cfreq1_offset)
 		__dynamic_array(u32, arp_addr_list,
-				info->arp_addr_cnt > IEEE80211_BSS_ARP_ADDR_LIST_LEN ?
+				sdata->vif.cfg.arp_addr_cnt > IEEE80211_BSS_ARP_ADDR_LIST_LEN ?
 					IEEE80211_BSS_ARP_ADDR_LIST_LEN :
-					info->arp_addr_cnt)
+					sdata->vif.cfg.arp_addr_cnt)
 		__field(int, arp_addr_cnt)
 		__field(bool, qos)
 		__field(bool, idle)
 		__field(bool, ps)
-		__dynamic_array(u8, ssid, info->ssid_len)
+		__dynamic_array(u8, ssid, sdata->vif.cfg.ssid_len)
 		__field(bool, hidden_ssid)
 		__field(int, txpower)
 		__field(u8, p2p_oppps_ctwindow)
@@ -442,10 +442,10 @@ TRACE_EVENT(drv_bss_info_changed,
 		LOCAL_ASSIGN;
 		VIF_ASSIGN;
 		__entry->changed = changed;
-		__entry->aid = info->aid;
-		__entry->assoc = info->assoc;
-		__entry->ibss_joined = info->ibss_joined;
-		__entry->ibss_creator = info->ibss_creator;
+		__entry->aid = sdata->vif.cfg.aid;
+		__entry->assoc = sdata->vif.cfg.assoc;
+		__entry->ibss_joined = sdata->vif.cfg.ibss_joined;
+		__entry->ibss_creator = sdata->vif.cfg.ibss_creator;
 		__entry->shortpre = info->use_short_preamble;
 		__entry->cts = info->use_cts_prot;
 		__entry->shortslot = info->use_short_slot;
@@ -465,15 +465,18 @@ TRACE_EVENT(drv_bss_info_changed,
 		__entry->channel_width = info->chandef.width;
 		__entry->channel_cfreq1 = info->chandef.center_freq1;
 		__entry->channel_cfreq1_offset = info->chandef.freq1_offset;
-		__entry->arp_addr_cnt = info->arp_addr_cnt;
-		memcpy(__get_dynamic_array(arp_addr_list), info->arp_addr_list,
-		       sizeof(u32) * (info->arp_addr_cnt > IEEE80211_BSS_ARP_ADDR_LIST_LEN ?
+		__entry->arp_addr_cnt = sdata->vif.cfg.arp_addr_cnt;
+		memcpy(__get_dynamic_array(arp_addr_list),
+		       sdata->vif.cfg.arp_addr_list,
+		       sizeof(u32) * (sdata->vif.cfg.arp_addr_cnt > IEEE80211_BSS_ARP_ADDR_LIST_LEN ?
 					IEEE80211_BSS_ARP_ADDR_LIST_LEN :
-					info->arp_addr_cnt));
+					sdata->vif.cfg.arp_addr_cnt));
 		__entry->qos = info->qos;
 		__entry->idle = info->idle;
 		__entry->ps = info->ps;
-		memcpy(__get_dynamic_array(ssid), info->ssid, info->ssid_len);
+		memcpy(__get_dynamic_array(ssid),
+		       sdata->vif.cfg.ssid,
+		       sdata->vif.cfg.ssid_len);
 		__entry->hidden_ssid = info->hidden_ssid;
 		__entry->txpower = info->txpower;
 		__entry->p2p_oppps_ctwindow = info->p2p_noa_attr.oppps_ctwindow;
@@ -1719,7 +1722,7 @@ TRACE_EVENT(drv_start_ap,
 		VIF_ENTRY
 		__field(u8, dtimper)
 		__field(u16, bcnint)
-		__dynamic_array(u8, ssid, info->ssid_len)
+		__dynamic_array(u8, ssid, sdata->vif.cfg.ssid_len)
 		__field(bool, hidden_ssid)
 	),
 
@@ -1728,7 +1731,9 @@ TRACE_EVENT(drv_start_ap,
 		VIF_ASSIGN;
 		__entry->dtimper = info->dtim_period;
 		__entry->bcnint = info->beacon_int;
-		memcpy(__get_dynamic_array(ssid), info->ssid, info->ssid_len);
+		memcpy(__get_dynamic_array(ssid),
+		       sdata->vif.cfg.ssid,
+		       sdata->vif.cfg.ssid_len);
 		__entry->hidden_ssid = info->hidden_ssid;
 	),
 
@@ -1786,7 +1791,7 @@ TRACE_EVENT(drv_join_ibss,
 		VIF_ENTRY
 		__field(u8, dtimper)
 		__field(u16, bcnint)
-		__dynamic_array(u8, ssid, info->ssid_len)
+		__dynamic_array(u8, ssid, sdata->vif.cfg.ssid_len)
 	),
 
 	TP_fast_assign(
@@ -1794,7 +1799,9 @@ TRACE_EVENT(drv_join_ibss,
 		VIF_ASSIGN;
 		__entry->dtimper = info->dtim_period;
 		__entry->bcnint = info->beacon_int;
-		memcpy(__get_dynamic_array(ssid), info->ssid, info->ssid_len);
+		memcpy(__get_dynamic_array(ssid),
+		       sdata->vif.cfg.ssid,
+		       sdata->vif.cfg.ssid_len);
 	),
 
 	TP_printk(
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index e5edc6fd21c0..a4270e9ec10e 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5381,7 +5381,7 @@ struct sk_buff *ieee80211_pspoll_get(struct ieee80211_hw *hw,
 	pspoll = skb_put_zero(skb, sizeof(*pspoll));
 	pspoll->frame_control = cpu_to_le16(IEEE80211_FTYPE_CTL |
 					    IEEE80211_STYPE_PSPOLL);
-	pspoll->aid = cpu_to_le16(sdata->vif.bss_conf.aid);
+	pspoll->aid = cpu_to_le16(sdata->vif.cfg.aid);
 
 	/* aid in PS-Poll has its two MSBs each set to 1 */
 	pspoll->aid |= cpu_to_le16(1 << 15 | 1 << 14);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 48d8f0aad69f..dccc757baab2 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2496,7 +2496,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		case NL80211_IFTYPE_MONITOR:
 			break;
 		case NL80211_IFTYPE_ADHOC:
-			if (sdata->vif.bss_conf.ibss_joined)
+			if (sdata->vif.cfg.ibss_joined)
 				WARN_ON(drv_join_ibss(local, sdata));
 			fallthrough;
 		default:
-- 
2.36.1

