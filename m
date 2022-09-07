Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138535B0424
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Sep 2022 14:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIGMpE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Sep 2022 08:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIGMpD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Sep 2022 08:45:03 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878C342ACD
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 05:45:01 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o2-20020a17090a9f8200b0020025a22208so10957757pjp.2
        for <linux-wireless@vger.kernel.org>; Wed, 07 Sep 2022 05:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=OdOebsivC1srCw5I1TPXSWqPezumrGrTQbVxmyXb4kM=;
        b=FjTD9BAtr9rm22kentL6fCnh90UPRGw+JVUQYiviSINHnC3cQQfGQ4NG1zHeg+uTsY
         LL/+91ZtLiV5fCNeLjydbevcFn9zkxtwvv0s8XEnZEkAkZzrWJhWCUv71bCvoGbfFnHI
         ibZmOvlRcj0g04oKSfrurlfRM30XwNLJQ3sJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=OdOebsivC1srCw5I1TPXSWqPezumrGrTQbVxmyXb4kM=;
        b=V2PIZEgbxhNyrCgpavBVzUsgTen2srioAOCB10z8aKPE1xCVmYkVOlKFiSnLEL+tWH
         Hg51ZvTsY9UcVsO7px1R7K9pphyvQiz5FeOVZScxZ/7/6eb6+az7d6IR4hiFpGfIQQMy
         cDhaZnxMuFvF5tAlOtjxQf5e9dQWUgJE+1rccodFdIVvtapmZ9NdLlVd73BehNYN5zgl
         Bk2Qi2jDh8s7OLXH88wW+YkN7DfK9qZt9G65UKTnt0JvnE6SDVLRqDXjHDg/SwhkhuJe
         7siqIKUoMj7V77FOziJoI8mYYr1RtnUZ8lfdwjzPzahLEYKCDx6W8Eu+h/ENhEfrwzVz
         h4lg==
X-Gm-Message-State: ACgBeo1I6NLtdSvmxFB6dGAkFwxteVwZs6Oc17Ct0U/DEdOMf5uIPnwq
        2Y3BRnESqqC0zkUKT/2Yg3pYvVRZHh80tg==
X-Google-Smtp-Source: AA6agR7JNjcltv12XOSm1QMmcxWkb1IEM+HrzHLdG6i/zupwkhVFkntSIQcOKNQSOdaGJYdJX+8bVQ==
X-Received: by 2002:a17:902:bd49:b0:170:953d:c489 with SMTP id b9-20020a170902bd4900b00170953dc489mr3813779plx.96.1662554700791;
        Wed, 07 Sep 2022 05:45:00 -0700 (PDT)
Received: from ibnvda0196.ibn.broadcom.net ([192.19.252.250])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902cece00b0015e8d4eb219sm12358458plg.99.2022.09.07.05.44.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2022 05:45:00 -0700 (PDT)
From:   Vinayak Yadawad <vinayak.yadawad@broadcom.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, jithu.jance@broadcom.com,
        Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Subject: [PATCHv3 1/1] cfg80211: Update Transition Disable policy during port authorization
Date:   Wed,  7 Sep 2022 18:14:48 +0530
Message-Id: <6c0155abdd7179336bcf2c59654d04a6611fb08c.1662552152.git.vinayak.yadawad@broadcom.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In case of 4way handshake offload, transition disable policy
updated by the AP during EAPOL 3/4 is not updated to the upper layer.
This results in mismatch between transition disable policy
between the upper layer and the driver. This patch addresses this
issue by updating transition disable policy as part of port
authorization indication.

Signed-off-by: Vinayak Yadawad <vinayak.yadawad@broadcom.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c  |  2 +-
 include/net/cfg80211.h                               |  4 +++-
 include/uapi/linux/nl80211.h                         |  3 +++
 net/wireless/core.h                                  |  5 ++++-
 net/wireless/nl80211.c                               |  7 ++++++-
 net/wireless/nl80211.h                               |  3 ++-
 net/wireless/sme.c                                   | 12 ++++++++----
 net/wireless/util.c                                  |  3 ++-
 8 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index db45da33adfd..ed18d1784521 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6028,7 +6028,7 @@ brcmf_bss_roaming_done(struct brcmf_cfg80211_info *cfg,
 	brcmf_dbg(CONN, "Report roaming result\n");
 
 	if (profile->use_fwsup == BRCMF_PROFILE_FWSUP_1X && profile->is_ft) {
-		cfg80211_port_authorized(ndev, profile->bssid, GFP_KERNEL);
+		cfg80211_port_authorized(ndev, profile->bssid, NULL, 0, GFP_KERNEL);
 		brcmf_dbg(CONN, "Report port authorized\n");
 	}
 
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 908d58393484..a4285e139d8f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7659,6 +7659,8 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
  *
  * @dev: network device
  * @bssid: the BSSID of the AP
+ * @td_bitmap: transition disable policy
+ * @td_bitmap_len: Length of transition disable policy
  * @gfp: allocation flags
  *
  * This function should be called by a driver that supports 4 way handshake
@@ -7669,7 +7671,7 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
  * indicate the 802.11 association.
  */
 void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
-			      gfp_t gfp);
+			      const u8* td_bitmap, u8 td_bitmap_len, gfp_t gfp);
 
 /**
  * cfg80211_disconnected - notify cfg80211 that connection was dropped
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index ffb7c573e299..c81cdc6d6c86 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2741,6 +2741,8 @@ enum nl80211_commands {
  *	When used with %NL80211_CMD_FRAME_TX_STATUS, indicates the ack RX
  *	timestamp. When used with %NL80211_CMD_FRAME RX notification, indicates
  *	the incoming frame RX timestamp.
+ * @NL80211_ATTR_TD_BITMAP: Transition Disable bitmap, for subsequent
+ *  (re)associations.
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3268,6 +3270,7 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_TX_HW_TIMESTAMP,
 	NL80211_ATTR_RX_HW_TIMESTAMP,
+	NL80211_ATTR_TD_BITMAP,
 
 	/* add attributes here, update the policy in nl80211.c */
 
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 775e16cb99ed..af85d8909935 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -271,6 +271,8 @@ struct cfg80211_event {
 		} ij;
 		struct {
 			u8 bssid[ETH_ALEN];
+			const u8 *td_bitmap;
+			u8 td_bitmap_len;
 		} pa;
 	};
 };
@@ -409,7 +411,8 @@ int cfg80211_disconnect(struct cfg80211_registered_device *rdev,
 			bool wextev);
 void __cfg80211_roamed(struct wireless_dev *wdev,
 		       struct cfg80211_roam_info *info);
-void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid);
+void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid,
+				const u8 *td_bitmap, u8 td_bitmap_len);
 int cfg80211_mgd_wext_connect(struct cfg80211_registered_device *rdev,
 			      struct wireless_dev *wdev);
 void cfg80211_autodisconnect_wk(struct work_struct *work);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2705e3ee8fc4..87e95f34d9b2 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -17841,7 +17841,8 @@ void nl80211_send_roamed(struct cfg80211_registered_device *rdev,
 }
 
 void nl80211_send_port_authorized(struct cfg80211_registered_device *rdev,
-				  struct net_device *netdev, const u8 *bssid)
+				  struct net_device *netdev, const u8 *bssid,
+				  const u8 *td_bitmap, u8 td_bitmap_len)
 {
 	struct sk_buff *msg;
 	void *hdr;
@@ -17861,6 +17862,10 @@ void nl80211_send_port_authorized(struct cfg80211_registered_device *rdev,
 	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, bssid))
 		goto nla_put_failure;
 
+	if ((td_bitmap_len > 0) && td_bitmap)
+		if (nla_put(msg, NL80211_ATTR_TD_BITMAP, td_bitmap_len, td_bitmap))
+			goto nla_put_failure;
+
 	genlmsg_end(msg, hdr);
 
 	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
diff --git a/net/wireless/nl80211.h b/net/wireless/nl80211.h
index 855d540ddfb9..ba9457e94c43 100644
--- a/net/wireless/nl80211.h
+++ b/net/wireless/nl80211.h
@@ -83,7 +83,8 @@ void nl80211_send_roamed(struct cfg80211_registered_device *rdev,
 			 struct net_device *netdev,
 			 struct cfg80211_roam_info *info, gfp_t gfp);
 void nl80211_send_port_authorized(struct cfg80211_registered_device *rdev,
-				  struct net_device *netdev, const u8 *bssid);
+				  struct net_device *netdev, const u8 *bssid,
+				  const u8 *td_bitmap, u8 td_bitmap_len);
 void nl80211_send_disconnected(struct cfg80211_registered_device *rdev,
 			       struct net_device *netdev, u16 reason,
 			       const u8 *ie, size_t ie_len, bool from_ap);
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 27fb2a0c4052..42e750a18320 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1234,7 +1234,8 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
 }
 EXPORT_SYMBOL(cfg80211_roamed);
 
-void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid)
+void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid,
+					const u8 *td_bitmap, u8 td_bitmap_len)
 {
 	ASSERT_WDEV_LOCK(wdev);
 
@@ -1247,11 +1248,11 @@ void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid)
 		return;
 
 	nl80211_send_port_authorized(wiphy_to_rdev(wdev->wiphy), wdev->netdev,
-				     bssid);
+				     bssid, td_bitmap, td_bitmap_len);
 }
 
 void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
-			      gfp_t gfp)
+			      const u8 *td_bitmap, u8 td_bitmap_len, gfp_t gfp)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
@@ -1261,12 +1262,15 @@ void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
 	if (WARN_ON(!bssid))
 		return;
 
-	ev = kzalloc(sizeof(*ev), gfp);
+	ev = kzalloc(sizeof(*ev) + td_bitmap_len, gfp);
 	if (!ev)
 		return;
 
 	ev->type = EVENT_PORT_AUTHORIZED;
 	memcpy(ev->pa.bssid, bssid, ETH_ALEN);
+	ev->pa.td_bitmap = ((u8 *)ev) + sizeof(*ev);
+	ev->pa.td_bitmap_len = td_bitmap_len;
+	memcpy((void *)ev->pa.td_bitmap, td_bitmap, td_bitmap_len);
 
 	/*
 	 * Use the wdev event list so that if there are pending
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 2c127951764a..42e7fce3184b 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -988,7 +988,8 @@ void cfg80211_process_wdev_events(struct wireless_dev *wdev)
 			__cfg80211_leave(wiphy_to_rdev(wdev->wiphy), wdev);
 			break;
 		case EVENT_PORT_AUTHORIZED:
-			__cfg80211_port_authorized(wdev, ev->pa.bssid);
+			__cfg80211_port_authorized(wdev, ev->pa.bssid, ev->pa.td_bitmap,
+					       ev->pa.td_bitmap_len);
 			break;
 		}
 		wdev_unlock(wdev);
-- 
2.32.0

