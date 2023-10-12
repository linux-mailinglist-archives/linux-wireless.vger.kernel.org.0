Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F22A7C6C95
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 13:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377746AbjJLLmg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 07:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347142AbjJLLmf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 07:42:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B229D
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 04:42:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09562C433C9
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 11:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697110954;
        bh=99RgBFObAwLj7TUQWCWQfuxJxQpgdA9KPL2RVZJCq80=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JRw8gTwQzUWFw2GWhtKhg9YzRuoyvNaeSabyrKyGM9faXl9TmAo34Z3b9VCjnUxOs
         qArHtzI3khCwCmjM52E8HAcPEmtmzX1Oj8By1QbHfg4LctmiWJgiKW9mtfVw4kwoV/
         WcfaWzBPJo1E+V5fCYOTyapMzuSJSRtNYDSTru2DwMvhA2Nrgx0Jf8HBMBDg+bZRzb
         8DPXcfrFC9A5AcU9HFE5u/H1mclDtlRw7FuTkh2pTNb3amRhmnf+x/drze70SBYx6M
         3OoleJdx1vZ1UexvqY0ZzEvr9PwALyt1xAE1R3iF1QL26QuB1j9whUDtDwuMUiWnKJ
         cUCu6wrj3JIOg==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] wifi: mac80211: rename struct cfg80211_rx_assoc_resp to cfg80211_rx_assoc_resp_data
Date:   Thu, 12 Oct 2023 14:42:29 +0300
Message-Id: <20231012114229.2931808-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231012114229.2931808-1-kvalo@kernel.org>
References: <20231012114229.2931808-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

make htmldocs warns:

Documentation/driver-api/80211/cfg80211:48: ./include/net/cfg80211.h:7290: WARNING: Duplicate C declaration, also defined at cfg80211:7251.
Declaration is '.. c:function:: void cfg80211_rx_assoc_resp (struct net_device *dev, struct cfg80211_rx_assoc_resp *data)'.

This is because there's a function named cfg80211_rx_assoc_resp() and a struct
named cfg80211_rx_assoc_resp, see previous patch for more info.

To workaround this rename the struct to cfg80211_rx_assoc_resp_data. The
parameter for the function is named 'data' anyway so the naming here is
consistent.

Compile tested only.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 include/net/cfg80211.h | 8 ++++----
 net/mac80211/mlme.c    | 2 +-
 net/wireless/mlme.c    | 2 +-
 net/wireless/nl80211.c | 2 +-
 net/wireless/nl80211.h | 2 +-
 net/wireless/trace.h   | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a9ef43b33748..b0a50b32a8bb 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7269,7 +7269,7 @@ void cfg80211_rx_mlme_mgmt(struct net_device *dev, const u8 *buf, size_t len);
 void cfg80211_auth_timeout(struct net_device *dev, const u8 *addr);
 
 /**
- * struct cfg80211_rx_assoc_resp - association response data
+ * struct cfg80211_rx_assoc_resp_data - association response data
  * @bss: the BSS that association was requested with, ownership of the pointer
  *	moves to cfg80211 in the call to cfg80211_rx_assoc_resp()
  * @buf: (Re)Association Response frame (header + body)
@@ -7284,7 +7284,7 @@ void cfg80211_auth_timeout(struct net_device *dev, const u8 *addr);
  * @links.status: Set this (along with a BSS pointer) for links that
  *	were rejected by the AP.
  */
-struct cfg80211_rx_assoc_resp {
+struct cfg80211_rx_assoc_resp_data {
 	const u8 *buf;
 	size_t len;
 	const u8 *req_ies;
@@ -7301,7 +7301,7 @@ struct cfg80211_rx_assoc_resp {
 /**
  * cfg80211_rx_assoc_resp - notification of processed association response
  * @dev: network device
- * @data: association response data, &struct cfg80211_rx_assoc_resp
+ * @data: association response data, &struct cfg80211_rx_assoc_resp_data
  *
  * After being asked to associate via cfg80211_ops::assoc() the driver must
  * call either this function or cfg80211_auth_timeout().
@@ -7309,7 +7309,7 @@ struct cfg80211_rx_assoc_resp {
  * This function may sleep. The caller must hold the corresponding wdev's mutex.
  */
 void cfg80211_rx_assoc_resp(struct net_device *dev,
-			    struct cfg80211_rx_assoc_resp *data);
+			    struct cfg80211_rx_assoc_resp_data *data);
 
 /**
  * struct cfg80211_assoc_failure - association failure data
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 8d2514a9a6c4..3950b823ed41 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5266,7 +5266,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		.u.mlme.data = ASSOC_EVENT,
 	};
 	struct ieee80211_prep_tx_info info = {};
-	struct cfg80211_rx_assoc_resp resp = {
+	struct cfg80211_rx_assoc_resp_data resp = {
 		.uapsd_queues = -1,
 	};
 	u8 ap_mld_addr[ETH_ALEN] __aligned(2);
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 579fea2f3548..f90f58c65688 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -22,7 +22,7 @@
 
 
 void cfg80211_rx_assoc_resp(struct net_device *dev,
-			    struct cfg80211_rx_assoc_resp *data)
+			    struct cfg80211_rx_assoc_resp_data *data)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct wiphy *wiphy = wdev->wiphy;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2650543dcebe..d468e015d828 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -17799,7 +17799,7 @@ void nl80211_send_rx_auth(struct cfg80211_registered_device *rdev,
 
 void nl80211_send_rx_assoc(struct cfg80211_registered_device *rdev,
 			   struct net_device *netdev,
-			   struct cfg80211_rx_assoc_resp *data)
+			   struct cfg80211_rx_assoc_resp_data *data)
 {
 	nl80211_send_mlme_event(rdev, netdev, data->buf, data->len,
 				NL80211_CMD_ASSOCIATE, GFP_KERNEL,
diff --git a/net/wireless/nl80211.h b/net/wireless/nl80211.h
index b4af53f9b227..3edd53c38912 100644
--- a/net/wireless/nl80211.h
+++ b/net/wireless/nl80211.h
@@ -60,7 +60,7 @@ void nl80211_send_rx_auth(struct cfg80211_registered_device *rdev,
 			  const u8 *buf, size_t len, gfp_t gfp);
 void nl80211_send_rx_assoc(struct cfg80211_registered_device *rdev,
 			   struct net_device *netdev,
-			   struct cfg80211_rx_assoc_resp *data);
+			   struct cfg80211_rx_assoc_resp_data *data);
 void nl80211_send_deauth(struct cfg80211_registered_device *rdev,
 			 struct net_device *netdev,
 			 const u8 *buf, size_t len,
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index f6667bf3fd12..30cd1bd58aac 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2928,7 +2928,7 @@ DEFINE_EVENT(netdev_evt_only, cfg80211_send_rx_auth,
 
 TRACE_EVENT(cfg80211_send_rx_assoc,
 	TP_PROTO(struct net_device *netdev,
-		 struct cfg80211_rx_assoc_resp *data),
+		 struct cfg80211_rx_assoc_resp_data *data),
 	TP_ARGS(netdev, data),
 	TP_STRUCT__entry(
 		NETDEV_ENTRY
-- 
2.39.2

