Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326A97BE742
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Oct 2023 19:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377353AbjJIRB0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Oct 2023 13:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376840AbjJIRBZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Oct 2023 13:01:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087D49D
        for <linux-wireless@vger.kernel.org>; Mon,  9 Oct 2023 10:01:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7B1C433C8
        for <linux-wireless@vger.kernel.org>; Mon,  9 Oct 2023 17:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696870883;
        bh=ts8roYjwOsV4Tr/ONn5bpXTgWkLn16rXzzAYMhWAtPI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PJDk8pOGHHKSXPgSJ5l0c+x2bc/zYdB/F/DA2H0ss+PfXekBNTaNiS4ljCMvsVNxf
         TjmUfAtDIKtWEn5b5aqT35jLwOjlnuoaLajESYka+UBTHb6wRWgFRT29kOm23ADaIU
         VJriWUZkwfgmLFAPBHQgI4WR5eQVAzGzfTuQVn37594iy2zj51ccrfG+vZ7y48OESF
         DHTtdrltr7IahLXCKIm3477oGDKqd0cxMh6c+z5P7VCsHv4GfD3awYQo/0F+NTrtwF
         n4CtkhBmxmxbfxd9BoPeh6hFaiTXUwg5u52Wug8Ayjm7TCTngdl2Dy39Hf9ezNbv+f
         gFvierSEPvnMw==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH RFC 2/2] wifi: mac80211: rename cfg80211_rx_assoc_resp() to cfg80211_rx_assoc_response()
Date:   Mon,  9 Oct 2023 20:01:20 +0300
Message-Id: <20231009170120.2522470-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009170120.2522470-1-kvalo@kernel.org>
References: <20231009170120.2522470-1-kvalo@kernel.org>
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

To workaround this rename the function to cfg80211_rx_assoc_response(). The
function name is a bit longer now but still IMHO not too long.

Compile tested only.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 Documentation/driver-api/80211/cfg80211.rst | 2 +-
 include/net/cfg80211.h                      | 8 ++++----
 net/mac80211/mlme.c                         | 2 +-
 net/wireless/mlme.c                         | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/driver-api/80211/cfg80211.rst b/Documentation/driver-api/80211/cfg80211.rst
index 836f609c3f75..66900f3cd102 100644
--- a/Documentation/driver-api/80211/cfg80211.rst
+++ b/Documentation/driver-api/80211/cfg80211.rst
@@ -73,7 +73,7 @@ Actions and configuration
 	cfg80211_pmksa
 	cfg80211_rx_mlme_mgmt
 	cfg80211_auth_timeout
-	cfg80211_rx_assoc_resp
+	cfg80211_rx_assoc_response
 	cfg80211_assoc_timeout
 	cfg80211_tx_mlme_mgmt
 	cfg80211_ibss_joined
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a9ef43b33748..0ca208884675 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7271,7 +7271,7 @@ void cfg80211_auth_timeout(struct net_device *dev, const u8 *addr);
 /**
  * struct cfg80211_rx_assoc_resp - association response data
  * @bss: the BSS that association was requested with, ownership of the pointer
- *	moves to cfg80211 in the call to cfg80211_rx_assoc_resp()
+ *	moves to cfg80211 in the call to cfg80211_rx_assoc_response()
  * @buf: (Re)Association Response frame (header + body)
  * @len: length of the frame data
  * @uapsd_queues: bitmap of queues configured for uapsd. Same format
@@ -7299,7 +7299,7 @@ struct cfg80211_rx_assoc_resp {
 };
 
 /**
- * cfg80211_rx_assoc_resp - notification of processed association response
+ * cfg80211_rx_assoc_response - notification of processed association response
  * @dev: network device
  * @data: association response data, &struct cfg80211_rx_assoc_resp
  *
@@ -7308,8 +7308,8 @@ struct cfg80211_rx_assoc_resp {
  *
  * This function may sleep. The caller must hold the corresponding wdev's mutex.
  */
-void cfg80211_rx_assoc_resp(struct net_device *dev,
-			    struct cfg80211_rx_assoc_resp *data);
+void cfg80211_rx_assoc_response(struct net_device *dev,
+				struct cfg80211_rx_assoc_resp *data);
 
 /**
  * struct cfg80211_assoc_failure - association failure data
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 8d2514a9a6c4..699864da5ae6 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5454,7 +5454,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 	resp.len = len;
 	resp.req_ies = ifmgd->assoc_req_ies;
 	resp.req_ies_len = ifmgd->assoc_req_ies_len;
-	cfg80211_rx_assoc_resp(sdata->dev, &resp);
+	cfg80211_rx_assoc_response(sdata->dev, &resp);
 notify_driver:
 	drv_mgd_complete_tx(sdata->local, sdata, &info);
 	kfree(elems);
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 579fea2f3548..418f3d6a4a34 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -21,8 +21,8 @@
 #include "rdev-ops.h"
 
 
-void cfg80211_rx_assoc_resp(struct net_device *dev,
-			    struct cfg80211_rx_assoc_resp *data)
+void cfg80211_rx_assoc_response(struct net_device *dev,
+				struct cfg80211_rx_assoc_resp *data)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct wiphy *wiphy = wdev->wiphy;
@@ -94,7 +94,7 @@ void cfg80211_rx_assoc_resp(struct net_device *dev,
 	/* update current_bss etc., consumes the bss reference */
 	__cfg80211_connect_result(dev, &cr, cr.status == WLAN_STATUS_SUCCESS);
 }
-EXPORT_SYMBOL(cfg80211_rx_assoc_resp);
+EXPORT_SYMBOL(cfg80211_rx_assoc_response);
 
 static void cfg80211_process_auth(struct wireless_dev *wdev,
 				  const u8 *buf, size_t len)
-- 
2.39.2

