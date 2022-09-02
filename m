Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD395AAB8E
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 11:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbiIBJhs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 05:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbiIBJhq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 05:37:46 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CD95B069
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 02:37:44 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id i7-20020a17090adc0700b001fd7ccbec3cso7533502pjv.0
        for <linux-wireless@vger.kernel.org>; Fri, 02 Sep 2022 02:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=/DFyRGkVRd6t8ipL3Ly3GSyMHS2IH2mq8GElMlTDq80=;
        b=dvyOwZ0R0kg8zQWH6TJkWUS66/17B5pOXXHag/ozIQESqnyx5ht82MEy7+jtI5RCQe
         N+9P7IDDjYZI/SOA5Fp+fd8ZIX7LcgldXzkeQRSIFkm9WpYC2J00y/Cb4DuXl42G27kD
         5kAqaxYJU/Qja5/jsUPFYwChnoHEEVSb62Be0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=/DFyRGkVRd6t8ipL3Ly3GSyMHS2IH2mq8GElMlTDq80=;
        b=ahBoSwaJLusP09cluE1FtrwxSQGluxc90ap4J8yuob9xwbxFloDa6PKul0kkMqZQh5
         Yx4LChCABKVIL0R4H64/s9wWyN6LV9gD80aYSblaOAMnYOzvJmv/xfJsP3OiuZXV2CBu
         DpCmB0PwSZDRlMi2ULd7J7yx4C7HkZMgau/NOSPaQYGUd7bvR7TDB9x+XnIvycT9R5YY
         NhFoMieMr3Tkzk2D9FSMIteEWWZMLf2NR3CudrSp/ia95s0pjZ5vcz5rEIDWcBC1UsDx
         duUn/3kJwXFhSWTtJy+Q6au+3K7Psii9XE6KXLTUAUyhoq5hjdQTF24R5oaQEyRj0NHk
         eb7Q==
X-Gm-Message-State: ACgBeo26amKeXT/Hpbp3KtUM/qPqSaWATSx2ReMRzLFSPLy957wAMioV
        gPIFSbGwoGR72vK3HxqM53vfOw==
X-Google-Smtp-Source: AA6agR7ptyy6Fp9mjt027DCJNGBjjM/k8G0GcvNk3Yun3skGgVBvu5VLSl4BL2R/Nn1KXIJePL5VoA==
X-Received: by 2002:a17:90b:4b12:b0:1fe:4fd0:2856 with SMTP id lx18-20020a17090b4b1200b001fe4fd02856mr3917270pjb.59.1662111463397;
        Fri, 02 Sep 2022 02:37:43 -0700 (PDT)
Received: from ibnvda0196.ibn.broadcom.net ([192.19.252.250])
        by smtp.gmail.com with ESMTPSA id c23-20020a63d517000000b0042ba1a95235sm972638pgg.86.2022.09.02.02.37.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Sep 2022 02:37:42 -0700 (PDT)
From:   Vinayak Yadawad <vinayak.yadawad@broadcom.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, jithu.jance@broadcom.com,
        Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Subject: [PATCHv2 1/1] cfg80211: Update Transition Disable policy during port authorization
Date:   Fri,  2 Sep 2022 15:07:37 +0530
Message-Id: <080553d39655d0d2b6c717936b6c0b25ca86a7da.1662111385.git.vinayak.yadawad@broadcom.com>
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

