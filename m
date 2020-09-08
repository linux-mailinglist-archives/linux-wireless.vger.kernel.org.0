Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC41261B8B
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 21:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbgIHTEe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 15:04:34 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:52772 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731705AbgIHTDr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 15:03:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 9973B4F9B04;
        Tue,  8 Sep 2020 19:03:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BGHDQIYF-NA9; Tue,  8 Sep 2020 19:03:42 +0000 (UTC)
Received: from atlas.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 5A1494F9ACD;
        Tue,  8 Sep 2020 19:03:24 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v3 14/22] mac80211: encode listen interval for S1G
Date:   Tue,  8 Sep 2020 12:03:15 -0700
Message-Id: <20200908190323.15814-15-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200908190323.15814-1-thomas@adapt-ip.com>
References: <20200908190323.15814-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

S1G allows listen interval up to 2^14 * 10000 beacon
intervals. In order to do this listen interval needs a
scaling factor applied to the lower 14 bits. Calculate
this and properly encode the listen interval for S1G STAs.

See IEEE802.11ah-2016 Table 9-44a for reference.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 include/linux/ieee80211.h  |  9 +++++++++
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/mlme.c        | 11 +++++++----
 net/mac80211/util.c        | 20 ++++++++++++++++++++
 4 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 690d00505649..a63ad4b4f973 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2446,6 +2446,15 @@ ieee80211_he_spr_size(const u8 *he_spr_ie)
 #define S1G_OPER_CH_WIDTH_PRIMARY_1MHZ	BIT(0)
 #define S1G_OPER_CH_WIDTH_OPER		GENMASK(4, 1)
 
+
+#define LISTEN_INT_USF	GENMASK(15, 14)
+#define LISTEN_INT_UI	GENMASK(13, 0)
+
+#define IEEE80211_MAX_USF	FIELD_MAX(LISTEN_INT_USF)
+#define IEEE80211_MAX_UI	FIELD_MAX(LISTEN_INT_UI)
+
+static const int listen_int_usf[] = { 1, 10, 1000, 10000 };
+
 /* Authentication algorithms */
 #define WLAN_AUTH_OPEN 0
 #define WLAN_AUTH_SHARED_KEY 1
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8bbdc27d57c6..cf78e356b25d 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2293,6 +2293,7 @@ void ieee80211_tdls_chsw_work(struct work_struct *wk);
 void ieee80211_tdls_handle_disconnect(struct ieee80211_sub_if_data *sdata,
 				      const u8 *peer, u16 reason);
 const char *ieee80211_get_reason_code_string(u16 reason_code);
+__le16 ieee80211_encode_usf(int val);
 
 extern const struct ethtool_ops ieee80211_ethtool_ops;
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b69889563457..6a62a221b89e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -686,6 +686,7 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_mgd_assoc_data *assoc_data = ifmgd->assoc_data;
+	struct ieee80211_bss *bss = (void *)assoc_data->bss->priv;
 	struct sk_buff *skb;
 	struct ieee80211_mgmt *mgmt;
 	u8 *pos, qos_info, *ie_start;
@@ -696,6 +697,7 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct ieee80211_channel *chan;
 	u32 rates = 0;
+	__le16 listen_int;
 	struct element *ext_capa = NULL;
 
 	/* we know it's writable, cast away the const */
@@ -784,13 +786,15 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	memcpy(mgmt->sa, sdata->vif.addr, ETH_ALEN);
 	memcpy(mgmt->bssid, assoc_data->bss->bssid, ETH_ALEN);
 
+	listen_int = cpu_to_le16(bss->s1g ?
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
@@ -798,8 +802,7 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 		mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
 						  IEEE80211_STYPE_ASSOC_REQ);
 		mgmt->u.assoc_req.capab_info = cpu_to_le16(capab);
-		mgmt->u.assoc_req.listen_interval =
-				cpu_to_le16(local->hw.conf.listen_interval);
+		mgmt->u.assoc_req.listen_interval = listen_int;
 	}
 
 	/* SSID */
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index e474b2bf227b..57c6f8bd2bdf 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4391,3 +4391,23 @@ const u8 ieee80211_ac_to_qos_mask[IEEE80211_NUM_ACS] = {
 	IEEE80211_WMM_IE_STA_QOSINFO_AC_BE,
 	IEEE80211_WMM_IE_STA_QOSINFO_AC_BK
 };
+
+__le16 ieee80211_encode_usf(int listen_interval)
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
+	return listen_interval;
+}
-- 
2.20.1

