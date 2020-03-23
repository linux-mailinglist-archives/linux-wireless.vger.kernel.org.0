Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6D918F877
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 16:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCWPYL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 11:24:11 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:49266 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgCWPYL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 11:24:11 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jGOvw-002WHu-0e; Mon, 23 Mar 2020 16:24:08 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211_hwsim: notify wmediumd of used MAC addresses
Date:   Mon, 23 Mar 2020 16:24:00 +0100
Message-Id: <20200323162358.b397b1a1acef.Ice0536e34e5d96c51f97c374ea8af9551347c7e8@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Currently, wmediumd requires each used MAC address to be configured
as a station in the virtual air, but that doesn't make sense as any
station could have multiple MAC addresses, and even have randomized
ones in scanning, etc.

Add some code here to tell wmediumd of used MAC addresses, binding
them to the hardware address. Combined with a wmediumd patch that
makes it track the addresses this allows configuring just the radio
address (42:00:00:00:nn:00 unless the radio was manually created)
in wmediumd as a station, and all addresses that the station uses
are added/removed dynamically.

Tested with random scan, which without this and the corresponding
wmediumd change doesn't get anything through as the sender doesn't
exist as far as wmediumd is concerned (it's random).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 51 +++++++++++++++++++++++++++
 drivers/net/wireless/mac80211_hwsim.h |  8 +++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 7fe8207db6ae..4d7141d06027 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1068,6 +1068,47 @@ static int hwsim_unicast_netgroup(struct mac80211_hwsim_data *data,
 	return res;
 }
 
+static void mac80211_hwsim_config_mac_nl(struct ieee80211_hw *hw,
+					 const u8 *addr, bool add)
+{
+	struct mac80211_hwsim_data *data = hw->priv;
+	u32 _portid = READ_ONCE(data->wmediumd);
+	struct sk_buff *skb;
+	void *msg_head;
+
+	if (!_portid && !hwsim_virtio_enabled)
+		return;
+
+	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_ATOMIC);
+	if (!skb)
+		return;
+
+	msg_head = genlmsg_put(skb, 0, 0, &hwsim_genl_family, 0,
+			       add ? HWSIM_CMD_ADD_MAC_ADDR :
+				     HWSIM_CMD_DEL_MAC_ADDR);
+	if (!msg_head) {
+		pr_debug("mac80211_hwsim: problem with msg_head\n");
+		goto nla_put_failure;
+	}
+
+	if (nla_put(skb, HWSIM_ATTR_ADDR_TRANSMITTER,
+		    ETH_ALEN, data->addresses[1].addr))
+		goto nla_put_failure;
+
+	if (nla_put(skb, HWSIM_ATTR_ADDR_RECEIVER, ETH_ALEN, addr))
+		goto nla_put_failure;
+
+	genlmsg_end(skb, msg_head);
+
+	if (hwsim_virtio_enabled)
+		hwsim_tx_virtio(data, skb);
+	else
+		hwsim_unicast_netgroup(data, skb, _portid);
+	return;
+nla_put_failure:
+	nlmsg_free(skb);
+}
+
 static inline u16 trans_tx_rate_flags_ieee2hwsim(struct ieee80211_tx_rate *rate)
 {
 	u16 result = 0;
@@ -1545,6 +1586,9 @@ static int mac80211_hwsim_add_interface(struct ieee80211_hw *hw,
 		  vif->addr);
 	hwsim_set_magic(vif);
 
+	if (vif->type != NL80211_IFTYPE_MONITOR)
+		mac80211_hwsim_config_mac_nl(hw, vif->addr, true);
+
 	vif->cab_queue = 0;
 	vif->hw_queue[IEEE80211_AC_VO] = 0;
 	vif->hw_queue[IEEE80211_AC_VI] = 1;
@@ -1584,6 +1628,8 @@ static void mac80211_hwsim_remove_interface(
 		  vif->addr);
 	hwsim_check_magic(vif);
 	hwsim_clear_magic(vif);
+	if (vif->type != NL80211_IFTYPE_MONITOR)
+		mac80211_hwsim_config_mac_nl(hw, vif->addr, false);
 }
 
 static void mac80211_hwsim_tx_frame(struct ieee80211_hw *hw,
@@ -2104,6 +2150,8 @@ static void hw_scan_work(struct work_struct *work)
 		hwsim->hw_scan_vif = NULL;
 		hwsim->tmp_chan = NULL;
 		mutex_unlock(&hwsim->mutex);
+		mac80211_hwsim_config_mac_nl(hwsim->hw, hwsim->scan_addr,
+					     false);
 		return;
 	}
 
@@ -2177,6 +2225,7 @@ static int mac80211_hwsim_hw_scan(struct ieee80211_hw *hw,
 	memset(hwsim->survey_data, 0, sizeof(hwsim->survey_data));
 	mutex_unlock(&hwsim->mutex);
 
+	mac80211_hwsim_config_mac_nl(hw, hwsim->scan_addr, true);
 	wiphy_dbg(hw->wiphy, "hwsim hw_scan request\n");
 
 	ieee80211_queue_delayed_work(hwsim->hw, &hwsim->hw_scan, 0);
@@ -2220,6 +2269,7 @@ static void mac80211_hwsim_sw_scan(struct ieee80211_hw *hw,
 	pr_debug("hwsim sw_scan request, prepping stuff\n");
 
 	memcpy(hwsim->scan_addr, mac_addr, ETH_ALEN);
+	mac80211_hwsim_config_mac_nl(hw, hwsim->scan_addr, true);
 	hwsim->scanning = true;
 	memset(hwsim->survey_data, 0, sizeof(hwsim->survey_data));
 
@@ -2236,6 +2286,7 @@ static void mac80211_hwsim_sw_scan_complete(struct ieee80211_hw *hw,
 
 	pr_debug("hwsim sw_scan_complete\n");
 	hwsim->scanning = false;
+	mac80211_hwsim_config_mac_nl(hw, hwsim->scan_addr, false);
 	eth_zero_addr(hwsim->scan_addr);
 
 	mutex_unlock(&hwsim->mutex);
diff --git a/drivers/net/wireless/mac80211_hwsim.h b/drivers/net/wireless/mac80211_hwsim.h
index 28ade92adcb4..9dceed77c5d6 100644
--- a/drivers/net/wireless/mac80211_hwsim.h
+++ b/drivers/net/wireless/mac80211_hwsim.h
@@ -75,6 +75,12 @@ enum hwsim_tx_control_flags {
  * @HWSIM_CMD_DEL_RADIO: destroy a radio, reply is multicasted
  * @HWSIM_CMD_GET_RADIO: fetch information about existing radios, uses:
  *	%HWSIM_ATTR_RADIO_ID
+ * @HWSIM_CMD_ADD_MAC_ADDR: add a receive MAC address (given in the
+ *	%HWSIM_ATTR_ADDR_RECEIVER attribute) to a device identified by
+ *	%HWSIM_ATTR_ADDR_TRANSMITTER. This lets wmediumd forward frames
+ *	to this receiver address for a given station.
+ * @HWSIM_CMD_DEL_MAC_ADDR: remove the MAC address again, the attributes
+ *	are the same as to @HWSIM_CMD_ADD_MAC_ADDR.
  * @__HWSIM_CMD_MAX: enum limit
  */
 enum {
@@ -85,6 +91,8 @@ enum {
 	HWSIM_CMD_NEW_RADIO,
 	HWSIM_CMD_DEL_RADIO,
 	HWSIM_CMD_GET_RADIO,
+	HWSIM_CMD_ADD_MAC_ADDR,
+	HWSIM_CMD_DEL_MAC_ADDR,
 	__HWSIM_CMD_MAX,
 };
 #define HWSIM_CMD_MAX (_HWSIM_CMD_MAX - 1)
-- 
2.25.1

