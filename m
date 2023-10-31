Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C487DD478
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Oct 2023 18:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbjJaRQQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Oct 2023 13:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbjJaRQO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Oct 2023 13:16:14 -0400
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3D78F
        for <linux-wireless@vger.kernel.org>; Tue, 31 Oct 2023 10:16:10 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2521:0:640:91c3:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id AEA60609C0;
        Tue, 31 Oct 2023 20:16:07 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 6GZDaGIWsKo0-bFbSyWZs;
        Tue, 31 Oct 2023 20:16:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1698772567; bh=Jja7lzEOHAzJ3fIC9qR6MbNQ+rm6VvuqyzehwapMTFo=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=LAXQ8FjxqdUpnDr/9B2lzcxSiWWKXQa3gci/t48VDk4ytpqALu8PHxQAv8f2m2Pv0
         ORoWJxaKUNtYrC+WZWwDHOtE0Qr+Pvla34zaRQ20GPTduLVuKEO1SQP+oDM7OjOmI2
         oEfSjv3bB1rztWcxCeZc/Bcv4axrVtZnvngWbRqU=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ajay Singh <ajay.kathat@microchip.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] wifi: wilc1000: simplify wilc_scan()
Date:   Tue, 31 Oct 2023 20:13:24 +0300
Message-ID: <20231031171330.70399-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031171330.70399-1-dmantipov@yandex.ru>
References: <20231031171330.70399-1-dmantipov@yandex.ru>
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

Simplify 'wilc_scan()' assuming 'struct wilc_priv *' is the only data
passed to '(*scan_result)()' callback and thus avoid typeless 'void *'
pointers in related code, including 'struct wilc_user_scan_req'.
Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../wireless/microchip/wilc1000/cfg80211.c    | 10 ++++------
 drivers/net/wireless/microchip/wilc1000/hif.c | 20 ++++++++++---------
 drivers/net/wireless/microchip/wilc1000/hif.h | 14 +++++++------
 3 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index af6d17724bf3..ad2509d8c99a 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -105,10 +105,9 @@ struct wilc_ch_list_elem {
 } __packed;
 
 static void cfg_scan_result(enum scan_event scan_event,
-			    struct wilc_rcvd_net_info *info, void *user_void)
+			    struct wilc_rcvd_net_info *info,
+			    struct wilc_priv *priv)
 {
-	struct wilc_priv *priv = user_void;
-
 	if (!priv->cfg_scanning)
 		return;
 
@@ -285,9 +284,8 @@ static int scan(struct wiphy *wiphy, struct cfg80211_scan_request *request)
 	else
 		scan_type = WILC_FW_PASSIVE_SCAN;
 
-	ret = wilc_scan(vif, WILC_FW_USER_SCAN, scan_type, scan_ch_list,
-			request->n_channels, cfg_scan_result, (void *)priv,
-			request);
+	ret = wilc_scan(vif, WILC_FW_USER_SCAN, scan_type,
+			scan_ch_list, cfg_scan_result, request);
 
 	if (ret) {
 		priv->scan_req = NULL;
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index a5115227644b..839f142663e8 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -144,18 +144,19 @@ static int handle_scan_done(struct wilc_vif *vif, enum scan_event evt)
 
 	scan_req = &hif_drv->usr_scan_req;
 	if (scan_req->scan_result) {
-		scan_req->scan_result(evt, NULL, scan_req->arg);
+		scan_req->scan_result(evt, NULL, scan_req->priv);
 		scan_req->scan_result = NULL;
 	}
 
 	return result;
 }
 
-int wilc_scan(struct wilc_vif *vif, u8 scan_source, u8 scan_type,
-	      u8 *ch_freq_list, u8 ch_list_len,
+int wilc_scan(struct wilc_vif *vif, u8 scan_source,
+	      u8 scan_type, u8 *ch_freq_list,
 	      void (*scan_result_fn)(enum scan_event,
-				     struct wilc_rcvd_net_info *, void *),
-	      void *user_arg, struct cfg80211_scan_request *request)
+				     struct wilc_rcvd_net_info *,
+				     struct wilc_priv *),
+	      struct cfg80211_scan_request *request)
 {
 	int result = 0;
 	struct wid wid_list[WILC_SCAN_WID_LIST_SIZE];
@@ -164,6 +165,7 @@ int wilc_scan(struct wilc_vif *vif, u8 scan_source, u8 scan_type,
 	u8 *buffer;
 	u8 valuesize = 0;
 	u8 *search_ssid_vals = NULL;
+	const u8 ch_list_len = request->n_channels;
 	struct host_if_drv *hif_drv = vif->hif_drv;
 
 	if (hif_drv->hif_state >= HOST_IF_SCANNING &&
@@ -249,7 +251,7 @@ int wilc_scan(struct wilc_vif *vif, u8 scan_source, u8 scan_type,
 	index++;
 
 	hif_drv->usr_scan_req.scan_result = scan_result_fn;
-	hif_drv->usr_scan_req.arg = user_arg;
+	hif_drv->usr_scan_req.priv = &vif->priv;
 
 	result = wilc_send_config_pkt(vif, WILC_SET_CFG, wid_list, index);
 	if (result) {
@@ -546,7 +548,7 @@ static void handle_rcvd_ntwrk_info(struct work_struct *work)
 
 	if (scan_req->scan_result)
 		scan_req->scan_result(SCAN_EVENT_NETWORK_FOUND, rcvd_info,
-				      scan_req->arg);
+				      scan_req->priv);
 
 done:
 	kfree(rcvd_info->mgmt);
@@ -730,7 +732,7 @@ int wilc_disconnect(struct wilc_vif *vif)
 
 	if (scan_req->scan_result) {
 		del_timer(&hif_drv->scan_timer);
-		scan_req->scan_result(SCAN_EVENT_ABORTED, NULL, scan_req->arg);
+		scan_req->scan_result(SCAN_EVENT_ABORTED, NULL, scan_req->priv);
 		scan_req->scan_result = NULL;
 	}
 
@@ -1539,7 +1541,7 @@ int wilc_deinit(struct wilc_vif *vif)
 
 	if (hif_drv->usr_scan_req.scan_result) {
 		hif_drv->usr_scan_req.scan_result(SCAN_EVENT_ABORTED, NULL,
-						  hif_drv->usr_scan_req.arg);
+						  hif_drv->usr_scan_req.priv);
 		hif_drv->usr_scan_req.scan_result = NULL;
 	}
 
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.h b/drivers/net/wireless/microchip/wilc1000/hif.h
index 07f81c7c5130..0d380586b1d9 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.h
+++ b/drivers/net/wireless/microchip/wilc1000/hif.h
@@ -98,8 +98,9 @@ struct wilc_rcvd_net_info {
 struct wilc_priv;
 struct wilc_user_scan_req {
 	void (*scan_result)(enum scan_event evt,
-			    struct wilc_rcvd_net_info *info, void *priv);
-	void *arg;
+			    struct wilc_rcvd_net_info *info,
+			    struct wilc_priv *priv);
+	struct wilc_priv *priv;
 	u32 ch_cnt;
 };
 
@@ -172,11 +173,12 @@ int wilc_set_join_req(struct wilc_vif *vif, u8 *bssid, const u8 *ies,
 int wilc_disconnect(struct wilc_vif *vif);
 int wilc_set_mac_chnl_num(struct wilc_vif *vif, u8 channel);
 int wilc_get_rssi(struct wilc_vif *vif, s8 *rssi_level);
-int wilc_scan(struct wilc_vif *vif, u8 scan_source, u8 scan_type,
-	      u8 *ch_freq_list, u8 ch_list_len,
+int wilc_scan(struct wilc_vif *vif, u8 scan_source,
+	      u8 scan_type, u8 *ch_freq_list,
 	      void (*scan_result_fn)(enum scan_event,
-				     struct wilc_rcvd_net_info *, void *),
-	      void *user_arg, struct cfg80211_scan_request *request);
+				     struct wilc_rcvd_net_info *,
+				     struct wilc_priv *),
+	      struct cfg80211_scan_request *request);
 int wilc_hif_set_cfg(struct wilc_vif *vif,
 		     struct cfg_param_attr *cfg_param);
 int wilc_init(struct net_device *dev, struct host_if_drv **hif_drv_handler);
-- 
2.41.0

