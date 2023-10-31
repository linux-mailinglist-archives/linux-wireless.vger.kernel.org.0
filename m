Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F3E7DD477
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Oct 2023 18:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbjJaRQP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Oct 2023 13:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjJaRQN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Oct 2023 13:16:13 -0400
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F09091
        for <linux-wireless@vger.kernel.org>; Tue, 31 Oct 2023 10:16:09 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2521:0:640:91c3:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id 0641D60A93;
        Tue, 31 Oct 2023 20:16:07 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 6GZDaGIWsKo0-0HcNXh3t;
        Tue, 31 Oct 2023 20:16:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1698772566; bh=u26v84jsfyeAOUAawhR4uhDAOntPN0rb1NlNDwbTLFg=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=cSsmxyW7UiUIE/6vOBYzcuiMKIXKx/px6iO6GQGzGR/Nh9QHce8Piz5dPX8V/TYne
         6FnqZI0U6hRfkAzBEtf4XMOfRAuA4/Qlodv9wAwtZNti5pBcSEXQHB0uA69HZzKEFs
         hXWD+IQl1ngOjQ2OOiPzzOowbQMPyYktnO9vzMU8=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ajay Singh <ajay.kathat@microchip.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] wifi: wilc1000: cleanup struct wilc_conn_info
Date:   Tue, 31 Oct 2023 20:13:23 +0300
Message-ID: <20231031171330.70399-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove set but otherwise unused 'ch' member of 'struct wilc_conn_info'
and avoid typeless 'void *' pointers in '(*conn_result)()' callback.
Likewise for 'wilc_parse_join_bss_param()'. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../net/wireless/microchip/wilc1000/cfg80211.c    |  6 ++----
 drivers/net/wireless/microchip/wilc1000/hif.c     | 13 +++++++------
 drivers/net/wireless/microchip/wilc1000/hif.h     | 15 +++++++++------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index bf2a60533506..af6d17724bf3 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -162,9 +162,8 @@ static void cfg_scan_result(enum scan_event scan_event,
 }
 
 static void cfg_connect_result(enum conn_event conn_disconn_evt, u8 mac_status,
-			       void *priv_data)
+			       struct wilc_priv *priv)
 {
-	struct wilc_priv *priv = priv_data;
 	struct net_device *dev = priv->dev;
 	struct wilc_vif *vif = netdev_priv(dev);
 	struct wilc *wl = vif->wilc;
@@ -412,9 +411,8 @@ static int connect(struct wiphy *wiphy, struct net_device *dev,
 
 	wfi_drv->conn_info.security = security;
 	wfi_drv->conn_info.auth_type = auth_type;
-	wfi_drv->conn_info.ch = ch;
 	wfi_drv->conn_info.conn_result = cfg_connect_result;
-	wfi_drv->conn_info.arg = priv;
+	wfi_drv->conn_info.priv = priv;
 	wfi_drv->conn_info.param = join_params;
 
 	if (sme->mfp == NL80211_MFP_OPTIONAL)
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index 2c42683dd5fb..a5115227644b 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -348,7 +348,7 @@ static void handle_connect_timeout(struct work_struct *work)
 	if (hif_drv->conn_info.conn_result) {
 		hif_drv->conn_info.conn_result(CONN_DISCONN_EVENT_CONN_RESP,
 					       WILC_MAC_STATUS_DISCONNECTED,
-					       hif_drv->conn_info.arg);
+					       hif_drv->conn_info.priv);
 
 	} else {
 		netdev_err(vif->ndev, "%s: conn_result is NULL\n", __func__);
@@ -371,8 +371,9 @@ static void handle_connect_timeout(struct work_struct *work)
 	kfree(msg);
 }
 
-void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
-				struct cfg80211_crypto_settings *crypto)
+struct wilc_join_bss_param *
+wilc_parse_join_bss_param(struct cfg80211_bss *bss,
+			  struct cfg80211_crypto_settings *crypto)
 {
 	struct wilc_join_bss_param *param;
 	struct ieee80211_p2p_noa_attr noa_attr;
@@ -627,7 +628,7 @@ static inline void host_int_parse_assoc_resp_info(struct wilc_vif *vif,
 
 	del_timer(&hif_drv->connect_timer);
 	conn_info->conn_result(CONN_DISCONN_EVENT_CONN_RESP, mac_status,
-			       hif_drv->conn_info.arg);
+			       hif_drv->conn_info.priv);
 
 	if (mac_status == WILC_MAC_STATUS_CONNECTED &&
 	    conn_info->status == WLAN_STATUS_SUCCESS) {
@@ -657,7 +658,7 @@ void wilc_handle_disconnect(struct wilc_vif *vif)
 
 	if (hif_drv->conn_info.conn_result)
 		hif_drv->conn_info.conn_result(CONN_DISCONN_EVENT_DISCONN_NOTIF,
-					       0, hif_drv->conn_info.arg);
+					       0, hif_drv->conn_info.priv);
 
 	eth_zero_addr(hif_drv->assoc_bssid);
 
@@ -739,7 +740,7 @@ int wilc_disconnect(struct wilc_vif *vif)
 			del_timer(&hif_drv->connect_timer);
 
 		conn_info->conn_result(CONN_DISCONN_EVENT_DISCONN_NOTIF, 0,
-				       conn_info->arg);
+				       conn_info->priv);
 	} else {
 		netdev_err(vif->ndev, "%s: conn_result is NULL\n", __func__);
 	}
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.h b/drivers/net/wireless/microchip/wilc1000/hif.h
index b0cb35590027..07f81c7c5130 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.h
+++ b/drivers/net/wireless/microchip/wilc1000/hif.h
@@ -95,6 +95,7 @@ struct wilc_rcvd_net_info {
 	struct ieee80211_mgmt *mgmt;
 };
 
+struct wilc_priv;
 struct wilc_user_scan_req {
 	void (*scan_result)(enum scan_event evt,
 			    struct wilc_rcvd_net_info *info, void *priv);
@@ -102,20 +103,21 @@ struct wilc_user_scan_req {
 	u32 ch_cnt;
 };
 
+struct wilc_join_bss_param;
 struct wilc_conn_info {
 	u8 bssid[ETH_ALEN];
 	u8 security;
 	enum authtype auth_type;
 	enum mfptype mfp_type;
-	u8 ch;
 	u8 *req_ies;
 	size_t req_ies_len;
 	u8 *resp_ies;
 	u16 resp_ies_len;
 	u16 status;
-	void (*conn_result)(enum conn_event evt, u8 status, void *priv_data);
-	void *arg;
-	void *param;
+	void (*conn_result)(enum conn_event evt, u8 status,
+			    struct wilc_priv *priv);
+	struct wilc_priv *priv;
+	struct wilc_join_bss_param *param;
 };
 
 struct wilc_vif;
@@ -207,8 +209,9 @@ int wilc_set_external_auth_param(struct wilc_vif *vif,
 void wilc_scan_complete_received(struct wilc *wilc, u8 *buffer, u32 length);
 void wilc_network_info_received(struct wilc *wilc, u8 *buffer, u32 length);
 void wilc_gnrl_async_info_received(struct wilc *wilc, u8 *buffer, u32 length);
-void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
-				struct cfg80211_crypto_settings *crypto);
+struct wilc_join_bss_param *
+wilc_parse_join_bss_param(struct cfg80211_bss *bss,
+			  struct cfg80211_crypto_settings *crypto);
 int wilc_set_default_mgmt_key_index(struct wilc_vif *vif, u8 index);
 void wilc_handle_disconnect(struct wilc_vif *vif);
 
-- 
2.41.0

