Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5211273A3E
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 07:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgIVFhe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 01:37:34 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:34054 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728898AbgIVFhd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 01:37:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id DF08F4F9DFD;
        Tue, 22 Sep 2020 05:37:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gb5raaTkZxwx; Tue, 22 Sep 2020 05:37:29 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 31B9E4F9DFF;
        Tue, 22 Sep 2020 05:37:19 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v4 09/17] mac80211: encode listen interval for S1G
Date:   Mon, 21 Sep 2020 19:28:10 -0700
Message-Id: <20200922022818.15855-10-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200922022818.15855-1-thomas@adapt-ip.com>
References: <20200922022818.15855-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

S1G allows listen interval up to 2^14 * 10000 beacon
intervals. In order to do this listen interval needs a
scaling factor applied to the lower 14 bits. Calculate
this and properly encode the listen interval for S1G STAs.

See IEEE802.11ah-2016 Table 9-44a for reference.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
Reported-by: kernel test robot <lkp@intel.com>

---

v4:
 - move listen_int_usf[] into util.c (Johannes)
 - fix __le16 return type (kernel test robot)
---
 include/linux/ieee80211.h  |  7 +++++++
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/mlme.c        | 10 ++++++----
 net/mac80211/util.c        | 22 ++++++++++++++++++++++
 4 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index d0fda8424118..7b6af47dd279 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2448,6 +2448,13 @@ ieee80211_he_spr_size(const u8 *he_spr_ie)
 #define S1G_OPER_CH_WIDTH_PRIMARY_1MHZ	BIT(0)
 #define S1G_OPER_CH_WIDTH_OPER		GENMASK(4, 1)
 
+
+#define LISTEN_INT_USF	GENMASK(15, 14)
+#define LISTEN_INT_UI	GENMASK(13, 0)
+
+#define IEEE80211_MAX_USF	FIELD_MAX(LISTEN_INT_USF)
+#define IEEE80211_MAX_UI	FIELD_MAX(LISTEN_INT_UI)
+
 /* Authentication algorithms */
 #define WLAN_AUTH_OPEN 0
 #define WLAN_AUTH_SHARED_KEY 1
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 32b9631a458e..e65b29ec68a7 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2300,6 +2300,7 @@ void ieee80211_tdls_chsw_work(struct work_struct *wk);
 void ieee80211_tdls_handle_disconnect(struct ieee80211_sub_if_data *sdata,
 				      const u8 *peer, u16 reason);
 const char *ieee80211_get_reason_code_string(u16 reason_code);
+u16 ieee80211_encode_usf(int val);
 
 extern const struct ethtool_ops ieee80211_ethtool_ops;
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 5afc009aabac..7b3397050b23 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -696,6 +696,7 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct ieee80211_channel *chan;
 	u32 rates = 0;
+	__le16 listen_int;
 	struct element *ext_capa = NULL;
 
 	/* we know it's writable, cast away the const */
@@ -784,13 +785,15 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	memcpy(mgmt->sa, sdata->vif.addr, ETH_ALEN);
 	memcpy(mgmt->bssid, assoc_data->bss->bssid, ETH_ALEN);
 
+	listen_int = cpu_to_le16(sband->band == NL80211_BAND_S1GHZ ?
+			ieee80211_encode_usf(local->hw.conf.listen_interval) :
+			local->hw.conf.listen_interval);
 	if (!is_zero_ether_addr(assoc_data->prev_bssid)) {
 		skb_put(skb, 10);
 		mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
 						  IEEE80211_STYPE_REASSOC_REQ);
 		mgmt->u.reassoc_req.capab_info = cpu_to_le16(capab);
-		mgmt->u.reassoc_req.listen_interval =
-				cpu_to_le16(local->hw.conf.listen_interval);
+		mgmt->u.reassoc_req.listen_interval = listen_int;
 		memcpy(mgmt->u.reassoc_req.current_ap, assoc_data->prev_bssid,
 		       ETH_ALEN);
 	} else {
@@ -798,8 +801,7 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 		mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
 						  IEEE80211_STYPE_ASSOC_REQ);
 		mgmt->u.assoc_req.capab_info = cpu_to_le16(capab);
-		mgmt->u.assoc_req.listen_interval =
-				cpu_to_le16(local->hw.conf.listen_interval);
+		mgmt->u.assoc_req.listen_interval = listen_int;
 	}
 
 	/* SSID */
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index ba2810a6fae8..326f2147bdf2 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -33,6 +33,8 @@
 #include "led.h"
 #include "wep.h"
 
+static const int listen_int_usf[] = { 1, 10, 1000, 10000 };
+
 /* privid for wiphys to determine whether they belong to us or not */
 const void *const mac80211_wiphy_privid = &mac80211_wiphy_privid;
 
@@ -4385,3 +4387,23 @@ const u8 ieee80211_ac_to_qos_mask[IEEE80211_NUM_ACS] = {
 	IEEE80211_WMM_IE_STA_QOSINFO_AC_BE,
 	IEEE80211_WMM_IE_STA_QOSINFO_AC_BK
 };
+
+u16 ieee80211_encode_usf(int listen_interval)
+{
+	u16 ui, usf = 0;
+
+	/* find greatest USF */
+	while (usf < IEEE80211_MAX_USF) {
+		if (listen_interval % listen_int_usf[usf + 1])
+			break;
+		usf += 1;
+	}
+	ui = listen_interval / listen_int_usf[usf];
+
+	/* error if there is a remainder. Should've been checked by user */
+	WARN_ON_ONCE(ui > IEEE80211_MAX_UI);
+	listen_interval = FIELD_PREP(LISTEN_INT_USF, usf) |
+			  FIELD_PREP(LISTEN_INT_UI, ui);
+
+	return (u16) listen_interval;
+}
-- 
2.20.1

