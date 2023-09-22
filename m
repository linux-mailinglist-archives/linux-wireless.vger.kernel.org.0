Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229947AB26D
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Sep 2023 14:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjIVMtr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Sep 2023 08:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjIVMtp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Sep 2023 08:49:45 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC1B8F
        for <linux-wireless@vger.kernel.org>; Fri, 22 Sep 2023 05:49:39 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3adba522a5dso1217878b6e.2
        for <linux-wireless@vger.kernel.org>; Fri, 22 Sep 2023 05:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1695386979; x=1695991779; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IOH37OsEFFrcw56CIhoEYu0QMohLGycplmMZLz0vkp8=;
        b=FUmQXQrVhKbp9sqAFLZshsABtTwNMaD0g2bs4OiWvD9e+LeKaFjCx3X4tdhsBt1xgH
         eNLZUXcYupG8ToOjcqhfoaamWcZ+IPST6fWvaU9Lli97kdLa6y6kOLto9D0f33tRPoSg
         lmS79qANgVXor0lcG09FMiYe++prdd5XiyXCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695386979; x=1695991779;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IOH37OsEFFrcw56CIhoEYu0QMohLGycplmMZLz0vkp8=;
        b=jj6Z5RuuqOnZim6iDQsni/IeJmd9/dsoJuM9Pz4nJlDle5cHItGM7LVfwqbDY+R3Sc
         NvpiAiQTT/Ippidb2o1sCDdNf3MsE3SsPTlKQIdI7+QL8T0UC0lLLT2O39FDaVOiLpYU
         O8MBVjPUlCEsJQMiF8mneRZBGXvtGX4JF6DMLW9LPnDCpgZXmArnkcSH/V9Lie/HY5Xx
         VWGb1AY2E7bbfS0A9ZUXyFH01zw860VdLxQMv0S2YBfjg57rbPBvQJWQsoQjhKTlzfVI
         TznQgG7kGU8JbZrmHGF/+efe6JC2ebiZEAPBJ1na6pZY967N+rX/FH7lcHRDGHCgTh0w
         DVAg==
X-Gm-Message-State: AOJu0YzjcR9LmeB4Cvr72YtyPDR0D5ehd1gb+OrbH4tFO2ikr74TvTj3
        FxZDRA5JXI/pQPrrqPsPvRtv4g==
X-Google-Smtp-Source: AGHT+IFL3Vg4J15kkoKp+Keof50D7McV0CnHKHx1uX6UXc1vReCM1qknOpwaOYfDM7tKvO+hKYkwPg==
X-Received: by 2002:a05:6808:1382:b0:3ab:5e9e:51f8 with SMTP id c2-20020a056808138200b003ab5e9e51f8mr9668451oiw.9.1695386978816;
        Fri, 22 Sep 2023 05:49:38 -0700 (PDT)
Received: from ibnvda0196.ibn.broadcom.net ([192.19.252.250])
        by smtp.gmail.com with ESMTPSA id s25-20020a63af59000000b0056606274e54sm3036004pgo.31.2023.09.22.05.49.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Sep 2023 05:49:38 -0700 (PDT)
From:   Vinayak Yadawad <vinayak.yadawad@broadcom.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, jithu.jance@broadcom.com,
        Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Subject: [PATCH v3 1/1] cfg80211: Allow AP/P2PGO to indicate port authorization to peer STA/P2PClient
Date:   Fri, 22 Sep 2023 18:19:20 +0530
Message-Id: <d91c22826cb7d66f78950a953f18fd0d64d496b2.1695385607.git.vinayak.yadawad@broadcom.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a6919b0605f20a8a"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_NO_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000a6919b0605f20a8a
Content-Transfer-Encoding: 8bit

In 4way handshake offload, cfg80211_port_authorized enables driver
to indicate successful 4way handshake to cfg80211 layer. Currently
this path of port authorization is restricted to interface type
NL80211_IFTYPE_STATION and NL80211_IFTYPE_P2P_CLIENT. This patch
extends the support for NL80211_IFTYPE_AP and NL80211_IFTYPE_P2P_GO
interfaces to authorize peer STA/P2P_CLIENT, whenever authentication
is offloaded on the AP/P2P_GO interface.

Signed-off-by: Vinayak Yadawad <vinayak.yadawad@broadcom.com>
---
v2->v3: Fixed indentation in comment
v1->v2: Address review comments to change peer_mac to peer_addr
---
 include/net/cfg80211.h |  8 ++++++--
 net/wireless/core.h    |  2 +-
 net/wireless/nl80211.c |  4 ++--
 net/wireless/nl80211.h |  5 ++++-
 net/wireless/sme.c     | 23 ++++++++++++++---------
 net/wireless/util.c    |  2 +-
 6 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 3a4b684f89bf..444fd8aac8c1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7967,7 +7967,8 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
  * cfg80211_port_authorized - notify cfg80211 of successful security association
  *
  * @dev: network device
- * @bssid: the BSSID of the AP
+ * @peer_addr: BSSID of the AP/P2P GO in case of STA/GC or STA/GC MAC address
+ *	in case of AP/P2P GO
  * @td_bitmap: transition disable policy
  * @td_bitmap_len: Length of transition disable policy
  * @gfp: allocation flags
@@ -7978,8 +7979,11 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
  * should be preceded with a call to cfg80211_connect_result(),
  * cfg80211_connect_done(), cfg80211_connect_bss() or cfg80211_roamed() to
  * indicate the 802.11 association.
+ * This function can also be called by AP/P2P GO driver that supports
+ * authentication offload. In this case the peer_mac passed is that of
+ * associated STA/GC.
  */
-void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
+void cfg80211_port_authorized(struct net_device *dev, const u8 *peer_addr,
 			      const u8* td_bitmap, u8 td_bitmap_len, gfp_t gfp);
 
 /**
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 507d184b8b40..678aba05e78b 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -276,7 +276,7 @@ struct cfg80211_event {
 			struct ieee80211_channel *channel;
 		} ij;
 		struct {
-			u8 bssid[ETH_ALEN];
+			u8 peer_addr[ETH_ALEN];
 			const u8 *td_bitmap;
 			u8 td_bitmap_len;
 		} pa;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index de47838aca4f..af4878df118e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -18219,7 +18219,7 @@ void nl80211_send_roamed(struct cfg80211_registered_device *rdev,
 }
 
 void nl80211_send_port_authorized(struct cfg80211_registered_device *rdev,
-				  struct net_device *netdev, const u8 *bssid,
+				  struct net_device *netdev, const u8 *peer_addr,
 				  const u8 *td_bitmap, u8 td_bitmap_len)
 {
 	struct sk_buff *msg;
@@ -18237,7 +18237,7 @@ void nl80211_send_port_authorized(struct cfg80211_registered_device *rdev,
 
 	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
 	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, netdev->ifindex) ||
-	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, bssid))
+	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, peer_addr))
 		goto nla_put_failure;
 
 	if ((td_bitmap_len > 0) && td_bitmap)
diff --git a/net/wireless/nl80211.h b/net/wireless/nl80211.h
index b4af53f9b227..d3cabf358696 100644
--- a/net/wireless/nl80211.h
+++ b/net/wireless/nl80211.h
@@ -82,8 +82,11 @@ void nl80211_send_connect_result(struct cfg80211_registered_device *rdev,
 void nl80211_send_roamed(struct cfg80211_registered_device *rdev,
 			 struct net_device *netdev,
 			 struct cfg80211_roam_info *info, gfp_t gfp);
+/* For STA/GC, indicate port authorized with AP/GO bssid.
+ * For GO/AP, use peer GC/STA mac_addr.
+ */
 void nl80211_send_port_authorized(struct cfg80211_registered_device *rdev,
-				  struct net_device *netdev, const u8 *bssid,
+				  struct net_device *netdev, const u8 *peer_addr,
 				  const u8 *td_bitmap, u8 td_bitmap_len);
 void nl80211_send_disconnected(struct cfg80211_registered_device *rdev,
 			       struct net_device *netdev, u16 reason,
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 9bba233b5a6e..59f1e9936c29 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1294,24 +1294,29 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
 }
 EXPORT_SYMBOL(cfg80211_roamed);
 
-void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid,
+void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *peer_addr,
 					const u8 *td_bitmap, u8 td_bitmap_len)
 {
 	ASSERT_WDEV_LOCK(wdev);
 
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_STATION &&
-		    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT))
+		wdev->iftype != NL80211_IFTYPE_P2P_CLIENT &&
+		wdev->iftype != NL80211_IFTYPE_AP &&
+		wdev->iftype != NL80211_IFTYPE_P2P_GO))
 		return;
 
-	if (WARN_ON(!wdev->connected) ||
-	    WARN_ON(!ether_addr_equal(wdev->u.client.connected_addr, bssid)))
-		return;
+	if (wdev->iftype == NL80211_IFTYPE_STATION ||
+		wdev->iftype == NL80211_IFTYPE_P2P_CLIENT) {
+		if (WARN_ON(!wdev->connected) ||
+			WARN_ON(!ether_addr_equal(wdev->u.client.connected_addr, peer_addr)))
+			return;
+	}
 
 	nl80211_send_port_authorized(wiphy_to_rdev(wdev->wiphy), wdev->netdev,
-				     bssid, td_bitmap, td_bitmap_len);
+				     peer_addr, td_bitmap, td_bitmap_len);
 }
 
-void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
+void cfg80211_port_authorized(struct net_device *dev, const u8 *peer_addr,
 			      const u8 *td_bitmap, u8 td_bitmap_len, gfp_t gfp)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
@@ -1319,7 +1324,7 @@ void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
 	struct cfg80211_event *ev;
 	unsigned long flags;
 
-	if (WARN_ON(!bssid))
+	if (WARN_ON(!peer_addr))
 		return;
 
 	ev = kzalloc(sizeof(*ev) + td_bitmap_len, gfp);
@@ -1327,7 +1332,7 @@ void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
 		return;
 
 	ev->type = EVENT_PORT_AUTHORIZED;
-	memcpy(ev->pa.bssid, bssid, ETH_ALEN);
+	memcpy(ev->pa.peer_addr, peer_addr, ETH_ALEN);
 	ev->pa.td_bitmap = ((u8 *)ev) + sizeof(*ev);
 	ev->pa.td_bitmap_len = td_bitmap_len;
 	memcpy((void *)ev->pa.td_bitmap, td_bitmap, td_bitmap_len);
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 1783ab9d57a3..e9e2f0a7ea11 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1069,7 +1069,7 @@ void cfg80211_process_wdev_events(struct wireless_dev *wdev)
 			__cfg80211_leave(wiphy_to_rdev(wdev->wiphy), wdev);
 			break;
 		case EVENT_PORT_AUTHORIZED:
-			__cfg80211_port_authorized(wdev, ev->pa.bssid,
+			__cfg80211_port_authorized(wdev, ev->pa.peer_addr,
 						   ev->pa.td_bitmap,
 						   ev->pa.td_bitmap_len);
 			break;
-- 
2.32.0


--000000000000a6919b0605f20a8a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
RY30ttFfLGgUxOvRzd7UPGXmjiRyV20Vv+kGag5aTueKGHUv49TWypHgJc4PX8L9y3VouEhbWmGb
bwuQjKELfovabHM5PWUVRda3t72kGFVMkIZ65u6DCdyjPFCUGnMCAwEAAaOCAd0wggHZMA4GA1Ud
DwEB/wQEAwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUu
Z2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggr
BgEFBQcwAYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3
Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4
aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmww
JwYDVR0RBCAwHoEcdmluYXlhay55YWRhd2FkQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEF
BQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUS9fHYxc9qAJz
gfBKun+P2LFASWAwDQYJKoZIhvcNAQELBQADggEBABiMQNJRdQCxXwqwqb49w0ZXCxsSrs3gS4NA
G3H9oJuvzJ8ml5Z9l9p9PGPHcrmc/BdFjIIu/wQftGETAf1+W6AvxXqYmA2flaogebRueqCMQJiy
xbJlOSry64AGOzHYULvI70tt9woEYgSx3I703b7c8o7eWCiU267y/WNzH+MpZ12h9q0Jwhw8uH9S
BTl38q8FNdCLAiM1OD+blhu7LqMLVaAEEeoUGhRxdNkvMGss1Z7/ZefenAfm9IpiaGR0PQhBwI7c
spqD/wIJUULcXiaj0eatDUjsrx3QN9OZOh3iubCt0uBoxCQUGuvxqd3Qz4FVKMSzEIzs8v/hwR+T
nTkxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxIxd7r
XtHLz48aMtQwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOWi4JmNHgQG5rXLiC1P
LtVRTwiiPF+oyOXOuYWINtjcMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTIzMDkyMjEyNDkzOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBywCsrIN1as44fjoGVfB6wFdI2D6mppdYgVFnN
KAh+eJ6q0F81h3ZWr4GYDhY9mG+jksyPunvEPJtEUNC7AAzzultU7rnKmtlM2PtbiWPSav0x4XZ+
Zr4sYGbUu2FR7UtdFf+8LYR+EuPDCacFisXPdPfBUIWoITncLc4M2j9EGeMOk2013l9tWigQgiOF
dZgA0RNffYc/q0IZDmHfYln2QIWGUBFLemk32VldVY/RiCFElPTiPgg88RopfU1PD01vdUesVutk
E9mpl3oDVJ39Q9mbmagamV2ZhdVLAJwln7a0UVdqlce7U7h8sLdxUKPHBjcSjIQ6TDN1K72FoNrY
--000000000000a6919b0605f20a8a--
