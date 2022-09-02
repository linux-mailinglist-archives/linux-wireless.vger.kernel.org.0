Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292285AAB16
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 11:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbiIBJOr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 05:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbiIBJOf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 05:14:35 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2366BC1672
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 02:14:05 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q63so1431866pga.9
        for <linux-wireless@vger.kernel.org>; Fri, 02 Sep 2022 02:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/DFyRGkVRd6t8ipL3Ly3GSyMHS2IH2mq8GElMlTDq80=;
        b=QBVqmiMpm7LR/uxGSmhTDP2alMMOq2qiR9emaWZ10bfAKNrQD2r9TWdRBMo/FbdJks
         JkUIFN0XmUjfgQ5u5X1a6IjmI5Ll7lnL+Li6ZKKwnEwkuMZNOPsoFVz9kxO/aNSKeq+s
         gdNOZm2BGz4Ll8G9qEFLyZyv+EhWl8LkpT5gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/DFyRGkVRd6t8ipL3Ly3GSyMHS2IH2mq8GElMlTDq80=;
        b=7ttNP7RVBAYPXYhz3Kq1REHM+h5qveZ/IyyTHpTuPyS7k7M0VlRTBS05cgqwcuga9H
         7TsvIg0U2YU3R73NmOQ+VXdUuxTyRrqnGKoeLPbt0BOpNQidAdArbFmmhO9AHOso/JMi
         r9QAjlOnYeRIoIFwzodLEFewIjMSOW9ZbpCFMh/tjWHpYTitJOt5QsCjFswpcnt0qN3K
         XFhn67pSPiMWJ30GJg3YCdFKoxewz3YvqqTAPy+GBW8Vo7qS8e7cJB7OqF0SwZ27j/Zq
         jB2WAqP5jS0/Bq85qB1W28L/hmSCIIVYkUm6QSVqfQZJDtxYmQYkzzpqPtPP1P+2TIfm
         z8lg==
X-Gm-Message-State: ACgBeo0KmmWdHSF6CBk4fUZ0qpTReEX6N2EKC3LE8Wo5b2JksYIehnQd
        9TKeK9Pu6QlsEM6OhMbrKQSvqg==
X-Google-Smtp-Source: AA6agR5HlmO+OpLeDWm688KtPXvrV/bu2YQ34gDP74RNvtk/0tidFnCToKHrTdTPIXi8ALWuUYWJ5Q==
X-Received: by 2002:a05:6a00:1a93:b0:536:5dca:a685 with SMTP id e19-20020a056a001a9300b005365dcaa685mr35742518pfv.13.1662110044508;
        Fri, 02 Sep 2022 02:14:04 -0700 (PDT)
Received: from ibnvda0196.ibn.broadcom.net ([192.19.252.250])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902c9cc00b00174abcb02d6sm1054994pld.235.2022.09.02.02.14.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Sep 2022 02:14:04 -0700 (PDT)
From:   Vinayak Yadawad <vinayak.yadawad@broadcom.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, jithu.jance@broadcom.com,
        Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Subject: [PATCH 2/2] cfg80211: Update Transition Disable policy during port authorization
Date:   Fri,  2 Sep 2022 14:43:57 +0530
Message-Id: <080553d39655d0d2b6c717936b6c0b25ca86a7da.1662109386.git.vinayak.yadawad@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <ae2a823643d71f40751259266f7c2e7d90909662.1662109386.git.vinayak.yadawad@broadcom.com>
References: <ae2a823643d71f40751259266f7c2e7d90909662.1662109386.git.vinayak.yadawad@broadcom.com>
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
 .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c  | 2 +-
 include/net/cfg80211.h                                   | 4 +++-
 include/uapi/linux/nl80211.h                             | 3 +++
 net/wireless/core.h                                      | 5 ++++-
 net/wireless/nl80211.c                                   | 7 ++++++-
 net/wireless/nl80211.h                                   | 3 ++-
 net/wireless/sme.c                                       | 9 ++++++---
 net/wireless/util.c                                      | 3 ++-
 8 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index db45da33adfd..fc02ecee8783 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6028,7 +6028,7 @@ brcmf_bss_roaming_done(struct brcmf_cfg80211_info *cfg,
 	brcmf_dbg(CONN, "Report roaming result\n");
 
 	if (profile->use_fwsup == BRCMF_PROFILE_FWSUP_1X && profile->is_ft) {
-		cfg80211_port_authorized(ndev, profile->bssid, GFP_KERNEL);
+		cfg80211_port_authorized(ndev, profile->bssid, 0, NULL, GFP_KERNEL);
 		brcmf_dbg(CONN, "Report port authorized\n");
 	}
 
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 908d58393484..c160cf316e84 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7659,6 +7659,8 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
  *
  * @dev: network device
  * @bssid: the BSSID of the AP
+ * @td_bitmap_len: Length of transition disable policy
+ * @td_bitmap: transition disable policy
  * @gfp: allocation flags
  *
  * This function should be called by a driver that supports 4 way handshake
@@ -7669,7 +7671,7 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
  * indicate the 802.11 association.
  */
 void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
-			      gfp_t gfp);
+			      u8 td_bitmap_len, u8* td_bitmap, gfp_t gfp);
 
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
index 775e16cb99ed..48f573b5e865 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -271,6 +271,8 @@ struct cfg80211_event {
 		} ij;
 		struct {
 			u8 bssid[ETH_ALEN];
+			u8 td_bitmap_len;
+			u8 *td_bitmap;
 		} pa;
 	};
 };
@@ -409,7 +411,8 @@ int cfg80211_disconnect(struct cfg80211_registered_device *rdev,
 			bool wextev);
 void __cfg80211_roamed(struct wireless_dev *wdev,
 		       struct cfg80211_roam_info *info);
-void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid);
+void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid,
+				u8 td_bitmap_len, u8 *td_bitmap);
 int cfg80211_mgd_wext_connect(struct cfg80211_registered_device *rdev,
 			      struct wireless_dev *wdev);
 void cfg80211_autodisconnect_wk(struct work_struct *work);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2705e3ee8fc4..a60aa04c890a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -17841,7 +17841,8 @@ void nl80211_send_roamed(struct cfg80211_registered_device *rdev,
 }
 
 void nl80211_send_port_authorized(struct cfg80211_registered_device *rdev,
-				  struct net_device *netdev, const u8 *bssid)
+				  struct net_device *netdev, const u8 *bssid,
+				  u8 td_bitmap_len, u8 *td_bitmap)
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
index 855d540ddfb9..44a25ebbf2ba 100644
--- a/net/wireless/nl80211.h
+++ b/net/wireless/nl80211.h
@@ -83,7 +83,8 @@ void nl80211_send_roamed(struct cfg80211_registered_device *rdev,
 			 struct net_device *netdev,
 			 struct cfg80211_roam_info *info, gfp_t gfp);
 void nl80211_send_port_authorized(struct cfg80211_registered_device *rdev,
-				  struct net_device *netdev, const u8 *bssid);
+				  struct net_device *netdev, const u8 *bssid,
+				  u8 td_bitmap_len, u8 *td_bitmap);
 void nl80211_send_disconnected(struct cfg80211_registered_device *rdev,
 			       struct net_device *netdev, u16 reason,
 			       const u8 *ie, size_t ie_len, bool from_ap);
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 27fb2a0c4052..c2e03475fc41 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1234,7 +1234,8 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
 }
 EXPORT_SYMBOL(cfg80211_roamed);
 
-void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid)
+void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid,
+					u8 td_bitmap_len, u8 *td_bitmap)
 {
 	ASSERT_WDEV_LOCK(wdev);
 
@@ -1247,11 +1248,11 @@ void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid)
 		return;
 
 	nl80211_send_port_authorized(wiphy_to_rdev(wdev->wiphy), wdev->netdev,
-				     bssid);
+				     bssid, td_bitmap_len, td_bitmap);
 }
 
 void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
-			      gfp_t gfp)
+			      u8 td_bitmap_len, u8 *td_bitmap, gfp_t gfp)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
@@ -1267,6 +1268,8 @@ void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
 
 	ev->type = EVENT_PORT_AUTHORIZED;
 	memcpy(ev->pa.bssid, bssid, ETH_ALEN);
+	ev->pa.td_bitmap_len = td_bitmap_len;
+	ev->pa.td_bitmap = td_bitmap;
 
 	/*
 	 * Use the wdev event list so that if there are pending
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 2c127951764a..f80738d2c359 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -988,7 +988,8 @@ void cfg80211_process_wdev_events(struct wireless_dev *wdev)
 			__cfg80211_leave(wiphy_to_rdev(wdev->wiphy), wdev);
 			break;
 		case EVENT_PORT_AUTHORIZED:
-			__cfg80211_port_authorized(wdev, ev->pa.bssid);
+			__cfg80211_port_authorized(wdev, ev->pa.bssid, ev->pa.td_bitmap_len,
+					       ev->pa.td_bitmap);
 			break;
 		}
 		wdev_unlock(wdev);
-- 
2.32.0

