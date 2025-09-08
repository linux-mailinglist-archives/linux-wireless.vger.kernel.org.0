Return-Path: <linux-wireless+bounces-27096-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1AFB48BDC
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 13:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392611B26F6F
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 11:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE2430147E;
	Mon,  8 Sep 2025 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHVt5H+d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D7302141
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330042; cv=none; b=rBzvK9AiGIy60TKJgjV3fJfit5QZORSB0P7aZ/O1wl4AI3pJTshuFBRIWfvIjSmKyk3UL83GreFJNZnbvZZd8XSVw3B2dwdzfXpEJjcYghGLBPrH6jbLNOCTkturPbs4Odzy/EXpXNkY0m/GTal5y0FI1ekDP+NdLxJLpbmEcTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330042; c=relaxed/simple;
	bh=qKGO53ftP3GZXjw1HZZfSxjp+VMPHpdkOElKSVoihX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CcI0Oxd/H9I07vE8050oOEk7L2lCunSETgFcOcugPSzbl2Jx6sDXgyzgYyGDneTDDaMWmlzzHu5LTrTs12E621dyl+cO5z5dkPDgJrxxdYdSPdlt7gc0ChWOPyWoTyittxPqrRE03FP+m5fNuyFvpCNp66CZnyoS4it3aBKmkEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHVt5H+d; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757330040; x=1788866040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qKGO53ftP3GZXjw1HZZfSxjp+VMPHpdkOElKSVoihX4=;
  b=WHVt5H+dYZvN9MrQefMJgN6mqJ2j3bX0z+7QCXPChfQdAYvoVN6903yF
   sanvg+BtVEzwbElWfGR8JNfYptLUt6kRnq8Pnx12AB6/wqGGktE+ssHux
   jylBn5Pyt39b/kGMNYOvCeWkOHZBVl1N9MHw1abKhfXKHiWZ3vv9XHzET
   qi8YkFLcY3uK1CojvI6ZXKdQ0EfwAa5oHT00rvFzWyM3i3oV2xeJlgF7D
   Q1KwDv+Aw84YmCMIwR/ykv0QUgc1K72hCLIUMpLRkS3gpOFm3kWLkkfSj
   6yOFeqIGdrU0BJqgMl/ES/Smw0EcBnn4OOK6gRd0PUvYp//U6RnSLMBWZ
   A==;
X-CSE-ConnectionGUID: DdkTAxFxQIaUWOBOIirU9A==
X-CSE-MsgGUID: t3HJqVyuSFSZl1Yop2fg1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="77037936"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="77037936"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:56 -0700
X-CSE-ConnectionGUID: bGeZt43YTIeRxdi2lzIJdw==
X-CSE-MsgGUID: 5nYTb+VlRhCfIP7rbRWCqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="173126623"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 14/14] wifi: mac80211_hwsim: Add simulation support for NAN device
Date: Mon,  8 Sep 2025 14:13:08 +0300
Message-Id: <20250908140015.2d02d5be6468.I3badfdb80c29e7713bd37373650ccbf099547a59@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908111308.2688889-1-miriam.rachel.korenblit@intel.com>
References: <20250908111308.2688889-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Add support for simulating a NAN Device interface:

- Update interface limits to include support for NAN Device.
- Increase the number of supported HW addresses to allow unique
  addresses for combination such as: station interface + P2P
  Device interface + NAN Device interface.
- Declare support for NAN capabilities, specifically support for
  NAN synchronization offload and NAN DE user space support.
- Add the relevant callbacks to support start/stop NAN Device
  operation.
- Use a timer to simulate starting a Discovery Window (currently
  the timer doesn't do much).
- Update the Tx path to simulate that the channel used for NAN
  Device is either channel 6 or channel 149.
- Send DW notification when DW starts.
- Send cluster join notification when new cluster starts, or when an
  existing cluster is joined. "Joining" is implemented by reusing the
  cluster id of any other existing NAN management interface.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 259 +++++++++++++++++-
 drivers/net/wireless/virtual/mac80211_hwsim.h |   4 +-
 2 files changed, 256 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 3789d46d5614..9f856042a67a 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -645,6 +645,7 @@ static LIST_HEAD(hwsim_radios);
 static struct rhashtable hwsim_radios_rht;
 static int hwsim_radio_idx;
 static int hwsim_radios_generation = 1;
+static u8 hwsim_nan_cluster_id[ETH_ALEN];
 
 static struct platform_driver mac80211_hwsim_driver = {
 	.driver = {
@@ -670,7 +671,7 @@ struct mac80211_hwsim_data {
 	struct ieee80211_channel channels_s1g[ARRAY_SIZE(hwsim_channels_s1g)];
 	struct ieee80211_rate rates[ARRAY_SIZE(hwsim_rates)];
 	struct ieee80211_iface_combination if_combination;
-	struct ieee80211_iface_limit if_limits[3];
+	struct ieee80211_iface_limit if_limits[4];
 	int n_if_limits;
 
 	struct ieee80211_iface_combination if_combination_radio;
@@ -679,7 +680,7 @@ struct mac80211_hwsim_data {
 
 	u32 ciphers[ARRAY_SIZE(hwsim_ciphers)];
 
-	struct mac_address addresses[2];
+	struct mac_address addresses[3];
 	int channels, idx;
 	bool use_chanctx;
 	bool destroy_on_close;
@@ -752,6 +753,14 @@ struct mac80211_hwsim_data {
 	struct wireless_dev *pmsr_request_wdev;
 
 	struct mac80211_hwsim_link_data link_data[IEEE80211_MLD_MAX_NUM_LINKS];
+
+	struct ieee80211_vif *nan_device_vif;
+	u8 nan_bands;
+
+	enum nl80211_band nan_curr_dw_band;
+	struct hrtimer nan_timer;
+	bool notify_dw;
+	struct ieee80211_vif *nan_vif;
 };
 
 static const struct rhashtable_params hwsim_rht_params = {
@@ -926,6 +935,7 @@ static const struct nla_policy hwsim_genl_policy[HWSIM_ATTR_MAX + 1] = {
 	[HWSIM_ATTR_PMSR_SUPPORT] = NLA_POLICY_NESTED(hwsim_pmsr_capa_policy),
 	[HWSIM_ATTR_PMSR_RESULT] = NLA_POLICY_NESTED(hwsim_pmsr_peers_result_policy),
 	[HWSIM_ATTR_MULTI_RADIO] = { .type = NLA_FLAG },
+	[HWSIM_ATTR_SUPPORT_NAN_DEVICE] = { .type = NLA_FLAG },
 };
 
 #if IS_REACHABLE(CONFIG_VIRTIO)
@@ -1644,6 +1654,16 @@ static void mac80211_hwsim_tx_iter(void *_data, u8 *addr,
 	struct tx_iter_data *data = _data;
 	int i;
 
+	/* For NAN Device simulation purposes, assume that NAN is always
+	 * on channel 6 or channel 149.
+	 */
+	if (vif->type == NL80211_IFTYPE_NAN) {
+		data->receive = (data->channel &&
+				 (data->channel->center_freq == 2437 ||
+				  data->channel->center_freq == 5745));
+		return;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(vif->link_conf); i++) {
 		struct ieee80211_bss_conf *conf;
 		struct ieee80211_chanctx_conf *chanctx;
@@ -1944,6 +1964,7 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct ieee80211_channel *channel;
+	struct ieee80211_vif *vif = txi->control.vif;
 	bool ack;
 	enum nl80211_chan_width confbw = NL80211_CHAN_WIDTH_20_NOHT;
 	u32 _portid, i;
@@ -1954,7 +1975,23 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 		return;
 	}
 
-	if (!data->use_chanctx) {
+	if (vif && vif->type == NL80211_IFTYPE_NAN && !data->tmp_chan) {
+		/* For NAN Device simulation purposes, assume that NAN is always
+		 * on channel 6 or channel 149, unless a ROC is in progress (for
+		 * USD use cases).
+		 */
+		if (data->nan_curr_dw_band == NL80211_BAND_2GHZ)
+			channel = ieee80211_get_channel(hw->wiphy, 2437);
+		else if (data->nan_curr_dw_band == NL80211_BAND_5GHZ)
+			channel = ieee80211_get_channel(hw->wiphy, 5745);
+		else
+			channel = NULL;
+
+		if (WARN_ON(!channel)) {
+			ieee80211_free_txskb(hw, skb);
+			return;
+		}
+	} else if (!data->use_chanctx) {
 		channel = data->channel;
 		confbw = data->bw;
 	} else if (txi->hw_queue == 4) {
@@ -1962,7 +1999,6 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 	} else {
 		u8 link = u32_get_bits(IEEE80211_SKB_CB(skb)->control.flags,
 				       IEEE80211_TX_CTRL_MLO_LINK);
-		struct ieee80211_vif *vif = txi->control.vif;
 		struct ieee80211_link_sta *link_sta = NULL;
 		struct ieee80211_sta *sta = control->sta;
 		struct ieee80211_bss_conf *bss_conf;
@@ -3950,6 +3986,168 @@ static int hwsim_pmsr_report_nl(struct sk_buff *msg, struct genl_info *info)
 	return err;
 }
 
+static enum hrtimer_restart
+mac80211_hwsim_nan_dw_start(struct hrtimer *timer)
+{
+	struct mac80211_hwsim_data *data =
+		container_of(timer, struct mac80211_hwsim_data,
+			     nan_timer);
+	struct ieee80211_hw *hw = data->hw;
+	u64 orig_tsf = mac80211_hwsim_get_tsf(hw, NULL), tsf = orig_tsf;
+	u32 dw_int = 512 * 1024;
+	u64 until_dw;
+
+	if (!data->nan_device_vif)
+		return HRTIMER_NORESTART;
+
+	if (data->nan_bands & BIT(NL80211_BAND_5GHZ)) {
+		if (data->nan_curr_dw_band == NL80211_BAND_2GHZ) {
+			dw_int = 128 * 1024;
+			data->nan_curr_dw_band = NL80211_BAND_5GHZ;
+		} else if (data->nan_curr_dw_band == NL80211_BAND_5GHZ) {
+			data->nan_curr_dw_band = NL80211_BAND_2GHZ;
+		}
+	}
+
+	until_dw = dw_int - do_div(tsf, dw_int);
+
+	/* The timer might fire just before the actual DW, in which case
+	 * update the timeout to the actual next DW
+	 */
+	if (until_dw < dw_int / 2)
+		until_dw += dw_int;
+
+	/* The above do_div() call directly modifies the 'tsf' variable, thus,
+	 * use a copy so that the print below would show the original TSF.
+	 */
+	wiphy_debug(hw->wiphy,
+		    "%s: tsf=%llx, curr_dw_band=%u, next_dw=%llu\n",
+		    __func__, orig_tsf, data->nan_curr_dw_band,
+		    until_dw);
+
+	hrtimer_forward_now(&data->nan_timer,
+			    ns_to_ktime(until_dw * NSEC_PER_USEC));
+
+	if (data->notify_dw) {
+		struct ieee80211_channel *ch;
+		struct wireless_dev *wdev =
+			ieee80211_vif_to_wdev(data->nan_device_vif);
+
+		if (data->nan_curr_dw_band == NL80211_BAND_5GHZ)
+			ch = ieee80211_get_channel(hw->wiphy, 5475);
+		else
+			ch = ieee80211_get_channel(hw->wiphy, 2437);
+
+		cfg80211_next_nan_dw_notif(wdev, ch, GFP_ATOMIC);
+	}
+
+	return HRTIMER_RESTART;
+}
+
+static int mac80211_hwsim_start_nan(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct cfg80211_nan_conf *conf)
+{
+	struct mac80211_hwsim_data *data = hw->priv;
+	u64 tsf = mac80211_hwsim_get_tsf(hw, NULL);
+	u32 dw_int = 512 * 1000;
+	u64 until_dw = dw_int - do_div(tsf, dw_int);
+	struct wireless_dev *wdev = ieee80211_vif_to_wdev(vif);
+
+	if (vif->type != NL80211_IFTYPE_NAN)
+		return -EINVAL;
+
+	if (data->nan_device_vif)
+		return -EALREADY;
+
+	/* set this before starting the timer, as preemption might occur */
+	data->nan_device_vif = vif;
+	data->nan_bands = conf->bands;
+	data->nan_curr_dw_band = NL80211_BAND_2GHZ;
+
+	wiphy_debug(hw->wiphy, "nan_started, next_dw=%llu\n",
+		    until_dw);
+
+	hrtimer_start(&data->nan_timer,
+		      ns_to_ktime(until_dw * NSEC_PER_USEC),
+		      HRTIMER_MODE_REL_SOFT);
+
+	if (conf->cluster_id && !is_zero_ether_addr(conf->cluster_id) &&
+	    is_zero_ether_addr(hwsim_nan_cluster_id)) {
+		memcpy(hwsim_nan_cluster_id, conf->cluster_id, ETH_ALEN);
+	} else if (is_zero_ether_addr(hwsim_nan_cluster_id)) {
+		hwsim_nan_cluster_id[0] = 0x50;
+		hwsim_nan_cluster_id[1] = 0x6f;
+		hwsim_nan_cluster_id[2] = 0x9a;
+		hwsim_nan_cluster_id[3] = 0x01;
+		hwsim_nan_cluster_id[4] = get_random_u8();
+		hwsim_nan_cluster_id[5] = get_random_u8();
+	}
+
+	data->notify_dw = conf->enable_dw_notification;
+
+	cfg80211_nan_cluster_joined(wdev, hwsim_nan_cluster_id, true,
+				    GFP_KERNEL);
+
+	return 0;
+}
+
+static int mac80211_hwsim_stop_nan(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif)
+{
+	struct mac80211_hwsim_data *data = hw->priv;
+	struct mac80211_hwsim_data *data2;
+	bool nan_cluster_running = false;
+
+	if (vif->type != NL80211_IFTYPE_NAN || !data->nan_device_vif ||
+	    data->nan_device_vif != vif)
+		return -EINVAL;
+
+	hrtimer_cancel(&data->nan_timer);
+	data->nan_device_vif = NULL;
+
+	spin_lock(&hwsim_radio_lock);
+	list_for_each_entry(data2, &hwsim_radios, list) {
+		if (data2->nan_device_vif) {
+			nan_cluster_running = true;
+			break;
+		}
+	}
+	spin_unlock(&hwsim_radio_lock);
+
+	if (!nan_cluster_running)
+		memset(hwsim_nan_cluster_id, 0, ETH_ALEN);
+
+	return 0;
+}
+
+static int mac80211_hwsim_change_nan_config(struct ieee80211_hw *hw,
+					    struct ieee80211_vif *vif,
+					    struct cfg80211_nan_conf *conf,
+					    u32 changes)
+{
+	struct mac80211_hwsim_data *data = hw->priv;
+
+	if (vif->type != NL80211_IFTYPE_NAN)
+		return -EINVAL;
+
+	if (!data->nan_device_vif)
+		return -EINVAL;
+
+	wiphy_debug(hw->wiphy, "nan_config_changed: changes=0x%x\n", changes);
+
+	/* Handle only the changes we care about for simulation purposes */
+	if (changes & CFG80211_NAN_CONF_CHANGED_BANDS) {
+		data->nan_bands = conf->bands;
+		data->nan_curr_dw_band = NL80211_BAND_2GHZ;
+	}
+
+	if (changes & CFG80211_NAN_CONF_CHANGED_CONFIG)
+		data->notify_dw = conf->enable_dw_notification;
+
+	return 0;
+}
+
 #ifdef CONFIG_MAC80211_DEBUGFS
 #define HWSIM_DEBUGFS_OPS					\
 	.link_add_debugfs = mac80211_hwsim_link_add_debugfs,
@@ -3982,6 +4180,9 @@ static int hwsim_pmsr_report_nl(struct sk_buff *msg, struct genl_info *info)
 	.get_et_strings = mac80211_hwsim_get_et_strings,	\
 	.start_pmsr = mac80211_hwsim_start_pmsr,		\
 	.abort_pmsr = mac80211_hwsim_abort_pmsr,		\
+	.start_nan = mac80211_hwsim_start_nan,                  \
+	.stop_nan = mac80211_hwsim_stop_nan,                    \
+	.nan_change_conf = mac80211_hwsim_change_nan_config,    \
 	HWSIM_DEBUGFS_OPS
 
 #define HWSIM_NON_MLO_OPS					\
@@ -4047,6 +4248,7 @@ struct hwsim_new_radio_params {
 	u8 n_ciphers;
 	bool mlo;
 	const struct cfg80211_pmsr_capabilities *pmsr_capa;
+	bool nan_device;
 };
 
 static void hwsim_mcast_config_msg(struct sk_buff *mcast_skb,
@@ -4127,6 +4329,11 @@ static int append_radio_msg(struct sk_buff *skb, int id,
 			return ret;
 	}
 
+	if (param->nan_device) {
+		ret = nla_put_flag(skb, HWSIM_ATTR_SUPPORT_NAN_DEVICE);
+		if (ret < 0)
+			return ret;
+	}
 	return 0;
 }
 
@@ -5239,14 +5446,18 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		/* Why need here second address ? */
 		memcpy(data->addresses[1].addr, addr, ETH_ALEN);
 		data->addresses[1].addr[0] |= 0x40;
-		hw->wiphy->n_addresses = 2;
+		memcpy(data->addresses[2].addr, addr, ETH_ALEN);
+		data->addresses[2].addr[0] |= 0x50;
+
+		hw->wiphy->n_addresses = 3;
 		hw->wiphy->addresses = data->addresses;
 		/* possible address clash is checked at hash table insertion */
 	} else {
 		memcpy(data->addresses[0].addr, param->perm_addr, ETH_ALEN);
 		/* compatibility with automatically generated mac addr */
 		memcpy(data->addresses[1].addr, param->perm_addr, ETH_ALEN);
-		hw->wiphy->n_addresses = 2;
+		memcpy(data->addresses[2].addr, param->perm_addr, ETH_ALEN);
+		hw->wiphy->n_addresses = 3;
 		hw->wiphy->addresses = data->addresses;
 	}
 
@@ -5283,6 +5494,30 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		n_limits++;
 	}
 
+	if (param->iftypes & BIT(NL80211_IFTYPE_NAN)) {
+		data->if_limits[n_limits].max = 1;
+		data->if_limits[n_limits].types = BIT(NL80211_IFTYPE_NAN);
+		n_limits++;
+
+		hw->wiphy->nan_supported_bands = BIT(NL80211_BAND_2GHZ) |
+						 BIT(NL80211_BAND_5GHZ);
+
+		hw->wiphy->nan_capa.flags = WIPHY_NAN_FLAGS_CONFIGURABLE_SYNC |
+					    WIPHY_NAN_FLAGS_USERSPACE_DE;
+		hw->wiphy->nan_capa.op_mode = NAN_OP_MODE_PHY_MODE_MASK |
+					      NAN_OP_MODE_80P80MHZ |
+					      NAN_OP_MODE_160MHZ;
+
+		hw->wiphy->nan_capa.n_antennas = 0x22;
+		hw->wiphy->nan_capa.max_channel_switch_time = 0;
+		hw->wiphy->nan_capa.dev_capabilities =
+			NAN_DEV_CAPA_EXT_KEY_ID_SUPPORTED |
+			NAN_DEV_CAPA_NDPE_SUPPORTED;
+
+		hrtimer_setup(&data->nan_timer, mac80211_hwsim_nan_dw_start,
+			      CLOCK_MONOTONIC, HRTIMER_MODE_ABS_SOFT);
+	}
+
 	data->if_combination.radar_detect_widths =
 				BIT(NL80211_CHAN_WIDTH_5) |
 				BIT(NL80211_CHAN_WIDTH_10) |
@@ -5701,6 +5936,8 @@ static int mac80211_hwsim_get_radio(struct sk_buff *skb,
 					REGULATORY_STRICT_REG);
 	param.p2p_device = !!(data->hw->wiphy->interface_modes &
 					BIT(NL80211_IFTYPE_P2P_DEVICE));
+	param.nan_device = !!(data->hw->wiphy->interface_modes &
+					BIT(NL80211_IFTYPE_NAN));
 	param.use_chanctx = data->use_chanctx;
 	param.regd = data->regd;
 	param.channels = data->channels;
@@ -6119,6 +6356,7 @@ static int hwsim_new_radio_nl(struct sk_buff *msg, struct genl_info *info)
 
 	param.reg_strict = info->attrs[HWSIM_ATTR_REG_STRICT_REG];
 	param.p2p_device = info->attrs[HWSIM_ATTR_SUPPORT_P2P_DEVICE];
+	param.nan_device = info->attrs[HWSIM_ATTR_SUPPORT_NAN_DEVICE];
 	param.channels = channels;
 	param.destroy_on_close =
 		info->attrs[HWSIM_ATTR_DESTROY_RADIO_ON_CLOSE];
@@ -6190,6 +6428,13 @@ static int hwsim_new_radio_nl(struct sk_buff *msg, struct genl_info *info)
 		param.p2p_device = true;
 	}
 
+	/* ensure both flag and iftype support is honored */
+	if (param.nan_device ||
+	    param.iftypes & BIT(NL80211_IFTYPE_NAN)) {
+		param.iftypes |= BIT(NL80211_IFTYPE_NAN);
+		param.nan_device = true;
+	}
+
 	if (info->attrs[HWSIM_ATTR_CIPHER_SUPPORT]) {
 		u32 len = nla_len(info->attrs[HWSIM_ATTR_CIPHER_SUPPORT]);
 
@@ -6910,12 +7155,14 @@ static int __init init_mac80211_hwsim(void)
 		}
 
 		param.p2p_device = support_p2p_device;
+		param.nan_device = true;
 		param.mlo = mlo;
 		param.multi_radio = multi_radio;
 		param.use_chanctx = channels > 1 || mlo || multi_radio;
 		param.iftypes = HWSIM_IFTYPE_SUPPORT_MASK;
 		if (param.p2p_device)
 			param.iftypes |= BIT(NL80211_IFTYPE_P2P_DEVICE);
+		param.iftypes |= BIT(NL80211_IFTYPE_NAN);
 
 		err = mac80211_hwsim_new_radio(NULL, &param);
 		if (err < 0)
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.h b/drivers/net/wireless/virtual/mac80211_hwsim.h
index fa157c883f7f..c2d06cf852a5 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.h
@@ -3,7 +3,7 @@
  * mac80211_hwsim - software simulator of 802.11 radio(s) for mac80211
  * Copyright (c) 2008, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2011, Javier Lopez <jlopex@gmail.com>
- * Copyright (C) 2020, 2022-2024 Intel Corporation
+ * Copyright (C) 2020, 2022-2025 Intel Corporation
  */
 
 #ifndef __MAC80211_HWSIM_H
@@ -160,6 +160,7 @@ enum hwsim_commands {
  * @HWSIM_ATTR_MULTI_RADIO: Register multiple wiphy radios (flag).
  *	Adds one radio for each band. Number of supported channels will be set for
  *	each radio instead of for the wiphy.
+ * @HWSIM_ATTR_SUPPORT_NAN_DEVICE: support NAN Device virtual interface (flag)
  * @__HWSIM_ATTR_MAX: enum limit
  */
 enum hwsim_attrs {
@@ -193,6 +194,7 @@ enum hwsim_attrs {
 	HWSIM_ATTR_PMSR_REQUEST,
 	HWSIM_ATTR_PMSR_RESULT,
 	HWSIM_ATTR_MULTI_RADIO,
+	HWSIM_ATTR_SUPPORT_NAN_DEVICE,
 	__HWSIM_ATTR_MAX,
 };
 #define HWSIM_ATTR_MAX (__HWSIM_ATTR_MAX - 1)
-- 
2.34.1


