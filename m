Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0AC182C14
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 10:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgCLJLH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 05:11:07 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:42640 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgCLJLH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 05:11:07 -0400
Received: from isengard.tu-ilmenau.de (unknown [141.24.111.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 8D54158006E;
        Thu, 12 Mar 2020 10:11:03 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 2/3] mac80211: handle no-preauth flag for control port
Date:   Thu, 12 Mar 2020 10:10:54 +0100
Message-Id: <20200312091055.54257-3-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200312091055.54257-1-markus.theil@tu-ilmenau.de>
References: <20200312091055.54257-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds support for disabling pre-auth rx over the nl80211 control
port for mac80211.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 include/net/cfg80211.h     | 1 +
 net/mac80211/cfg.c         | 4 ++++
 net/mac80211/ieee80211_i.h | 1 +
 net/mac80211/iface.c       | 4 ++++
 net/mac80211/mlme.c        | 2 ++
 net/mac80211/rx.c          | 3 ++-
 net/wireless/nl80211.c     | 3 +++
 7 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e511b225be29..329044c31220 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -924,6 +924,7 @@ struct cfg80211_crypto_settings {
 	__be16 control_port_ethertype;
 	bool control_port_no_encrypt;
 	bool control_port_over_nl80211;
+	bool control_port_no_preauth;
 	struct key_params *wep_keys;
 	int wep_tx_key;
 	const u8 *psk;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 7b654d2b8bb2..be22beece2bc 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1034,6 +1034,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	sdata->control_port_no_encrypt = params->crypto.control_port_no_encrypt;
 	sdata->control_port_over_nl80211 =
 				params->crypto.control_port_over_nl80211;
+	sdata->control_port_no_preauth =
+				params->crypto.control_port_no_preauth;
 	sdata->encrypt_headroom = ieee80211_cs_headroom(sdata->local,
 							&params->crypto,
 							sdata->vif.type);
@@ -1045,6 +1047,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 			params->crypto.control_port_no_encrypt;
 		vlan->control_port_over_nl80211 =
 			params->crypto.control_port_over_nl80211;
+		vlan->control_port_no_preauth =
+			params->crypto.control_port_no_preauth;
 		vlan->encrypt_headroom =
 			ieee80211_cs_headroom(sdata->local,
 					      &params->crypto,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index de39f9ca9935..f8ed4f621f7f 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -912,6 +912,7 @@ struct ieee80211_sub_if_data {
 	u16 sequence_number;
 	__be16 control_port_protocol;
 	bool control_port_no_encrypt;
+	bool control_port_no_preauth;
 	bool control_port_over_nl80211;
 	int encrypt_headroom;
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 128b3468d13e..d069825705d6 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -519,6 +519,8 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 			master->control_port_no_encrypt;
 		sdata->control_port_over_nl80211 =
 			master->control_port_over_nl80211;
+		sdata->control_port_no_preauth =
+			master->control_port_no_preauth;
 		sdata->vif.cab_queue = master->vif.cab_queue;
 		memcpy(sdata->vif.hw_queue, master->vif.hw_queue,
 		       sizeof(sdata->vif.hw_queue));
@@ -1463,6 +1465,8 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 
 	sdata->control_port_protocol = cpu_to_be16(ETH_P_PAE);
 	sdata->control_port_no_encrypt = false;
+	sdata->control_port_over_nl80211 = false;
+	sdata->control_port_no_preauth = false;
 	sdata->encrypt_headroom = IEEE80211_ENCRYPT_HEADROOM;
 	sdata->vif.bss_conf.idle = true;
 	sdata->vif.bss_conf.txpower = INT_MIN; /* unset */
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 9ab0842a7c37..959a0f034ba8 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5462,6 +5462,8 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	sdata->control_port_no_encrypt = req->crypto.control_port_no_encrypt;
 	sdata->control_port_over_nl80211 =
 					req->crypto.control_port_over_nl80211;
+	sdata->control_port_no_preauth =
+					req->crypto.control_port_no_preauth;
 	sdata->encrypt_headroom = ieee80211_cs_headroom(local, &req->crypto,
 							sdata->vif.type);
 
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 6bd24123456d..7bbc77605cce 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2497,7 +2497,8 @@ static void ieee80211_deliver_skb_to_local_stack(struct sk_buff *skb,
 	struct net_device *dev = sdata->dev;
 
 	if (unlikely((skb->protocol == sdata->control_port_protocol ||
-		      skb->protocol == cpu_to_be16(ETH_P_PREAUTH)) &&
+		     (skb->protocol == cpu_to_be16(ETH_P_PREAUTH) &&
+		     !sdata->control_port_no_preauth)) &&
 		     sdata->control_port_over_nl80211)) {
 		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 		bool noencrypt = !(status->flag & RX_FLAG_DECRYPTED);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0f91e02a77c6..d9af4468e528 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9301,6 +9301,9 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
 			return r;
 
 		settings->control_port_over_nl80211 = true;
+
+		if (info->attrs[NL80211_ATTR_CONTROL_PORT_NO_PREAUTH])
+			settings->control_port_no_preauth = true;
 	}
 
 	if (info->attrs[NL80211_ATTR_CIPHER_SUITES_PAIRWISE]) {
-- 
2.25.1

