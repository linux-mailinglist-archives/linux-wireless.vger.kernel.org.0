Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CB5574480
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jul 2022 07:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbiGNFai (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jul 2022 01:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiGNFah (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jul 2022 01:30:37 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9D720BD5
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 22:30:36 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q82so582017pgq.6
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 22:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version;
        bh=1ZaLsdcvPz1wJGvRoTuSH4lmx5HZECnVXsxr3LwD1WI=;
        b=COq3OYQXlFB3XaQWsdS9bGf6ggvQSflZGZWH9yANA3Ps6cdigb/9bX9V/9EmD6gdt0
         Ku4awpbLzyaXOcnhOjBVcU4ShVNCDClEXEqLWVSvUZPGZss+l3vYw3CpkRp5KpZQsP+8
         ux3phc7KC0NiHdnTZwHP5NSw/FiuMOhX8HYsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=1ZaLsdcvPz1wJGvRoTuSH4lmx5HZECnVXsxr3LwD1WI=;
        b=aZay/8bm2Lh9ht48RvMHQhalJBQr9AhSjXrmd7yspXw/JEOz8Y8sbaLYkB7z4c7/R+
         qLyqcC5bn+XhyOnLU/8ReZzHymkrFwXFO1UoriANG/q2uq0qlQainWNHI+lzjouIZT/K
         X6NfxYHEzdBP27sEgIiYMryiLrTaw0gP9DLX4tOQHgJgy2GrLOeJgFwp40IShNs7i8Yk
         imA/wpxQmMYHpaiYbQ1tkGPwCA2EpHalrmOCPZAx8xayg3JrEpJham9mYKF6kWWHFRle
         dNirNJA7f1mzBdOem8ePJWg2moVi22julvA+fh8NHlKSayJ9liM7FzpLPJ0XXNRxEqDa
         KYEQ==
X-Gm-Message-State: AJIora8MCnMeuLCusb22qYbssfPdyuTrhwb/yYbZ8EY3I1+sbBEXfO1x
        0b0aiSj1WZlFlD6l79o0JOfN9g==
X-Google-Smtp-Source: AGRyM1sV+tW+eV/inWbVjzsW+EUa2/jW44kKajk+Ic97KtKGoIF7W2ArLg07Tt3pXn2pGWeD59gzfg==
X-Received: by 2002:a65:5a42:0:b0:411:bf36:eeec with SMTP id z2-20020a655a42000000b00411bf36eeecmr6029316pgs.522.1657776635898;
        Wed, 13 Jul 2022 22:30:35 -0700 (PDT)
Received: from ibnvda0196.ibn.broadcom.net ([192.19.252.250])
        by smtp.gmail.com with ESMTPSA id c190-20020a621cc7000000b005289fbef7c4sm548684pfc.140.2022.07.13.22.30.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jul 2022 22:30:35 -0700 (PDT)
From:   Vinayak Yadawad <vinayak.yadawad@broadcom.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, jithu.jance@broadcom.com,
        Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Subject: [PATCH 1/1] cfg80211: Allow AP/P2PGO to indicate port authorization to peer STA/P2PClient
Date:   Thu, 14 Jul 2022 11:00:28 +0530
Message-Id: <5ee2d7c8f809c3d7f773ad4231cb894af850e1a2.1657720730.git.vinayak.yadawad@broadcom.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000008954ac05e3bd3305"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_NO_TEXT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--0000000000008954ac05e3bd3305
Content-Transfer-Encoding: 8bit

In 4way handshake offload, cfg80211_port_authorized
enables driver to indicate successful 4way handshake to cfg80211 layer.
Currently this path of port authorization is restricted to
interface type NL80211_IFTYPE_STATION and NL80211_IFTYPE_P2P_CLIENT.
This patch extends the support for NL80211_IFTYPE_AP and
NL80211_IFTYPE_P2P_GO interfaces to authorize peer STA/P2P_CLIENT,
whenever authentication is offloaded on the AP/P2P_GO interface.

Signed-off-by: Vinayak Yadawad <vinayak.yadawad@broadcom.com>
---
 include/net/cfg80211.h |  8 ++++++--
 net/wireless/sme.c     | 21 +++++++++++++--------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6d02e12e4702..bdb560c52ade 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7391,7 +7391,8 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
  * cfg80211_port_authorized - notify cfg80211 of successful security association
  *
  * @dev: network device
- * @bssid: the BSSID of the AP
+ * @peer_mac: BSSID of the AP/P2P GO in case of STA/GC or STA/GC macaddress in
+ *  case of AP/P2P GO
  * @gfp: allocation flags
  *
  * This function should be called by a driver that supports 4 way handshake
@@ -7400,8 +7401,11 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
  * should be preceded with a call to cfg80211_connect_result(),
  * cfg80211_connect_done(), cfg80211_connect_bss() or cfg80211_roamed() to
  * indicate the 802.11 association.
+ * This function can also be called by AP/P2P GO driver that supports
+ * authentication offload. In this case the peer_mac passed is that of
+ * associated STA/GC.
  */
-void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
+void cfg80211_port_authorized(struct net_device *dev, const u8 *peer_mac,
 			      gfp_t gfp);
 
 /**
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index ff4d48fcbfb2..063898377190 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1027,22 +1027,27 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
 }
 EXPORT_SYMBOL(cfg80211_roamed);
 
-void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid)
+void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *peer_mac)
 {
 	ASSERT_WDEV_LOCK(wdev);
 
-	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_STATION))
+	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_STATION &&
+		wdev->iftype != NL80211_IFTYPE_P2P_CLIENT &&
+		wdev->iftype != NL80211_IFTYPE_AP &&
+		wdev->iftype != NL80211_IFTYPE_P2P_GO))
 		return;
 
-	if (WARN_ON(!wdev->current_bss) ||
-	    WARN_ON(!ether_addr_equal(wdev->current_bss->pub.bssid, bssid)))
+	if ((wdev->iftype == NL80211_IFTYPE_STATION ||
+		wdev->iftype == NL80211_IFTYPE_P2P_CLIENT) &&
+		(WARN_ON(!wdev->current_bss) ||
+		WARN_ON((!ether_addr_equal(wdev->current_bss->pub.bssid, peer_mac)))))
 		return;
 
 	nl80211_send_port_authorized(wiphy_to_rdev(wdev->wiphy), wdev->netdev,
-				     bssid);
+				     peer_mac);
 }
 
-void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
+void cfg80211_port_authorized(struct net_device *dev, const u8 *peer_mac,
 			      gfp_t gfp)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
@@ -1050,7 +1055,7 @@ void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
 	struct cfg80211_event *ev;
 	unsigned long flags;
 
-	if (WARN_ON(!bssid))
+	if (WARN_ON(!peer_mac))
 		return;
 
 	ev = kzalloc(sizeof(*ev), gfp);
@@ -1058,7 +1063,7 @@ void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
 		return;
 
 	ev->type = EVENT_PORT_AUTHORIZED;
-	memcpy(ev->pa.bssid, bssid, ETH_ALEN);
+	memcpy(ev->pa.bssid, peer_mac, ETH_ALEN);
 
 	/*
 	 * Use the wdev event list so that if there are pending
-- 
2.32.0


--0000000000008954ac05e3bd3305
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
NYTp1srcTEZOxWsxza+lig+uL28TLZLykhkiMEYxptiQ8hcAMNGh/nsULs+5FQ+Otron6+vmdguo
y+ZZQrVvKv9cKahWzqi1nsWhCRT+DkjpyBdQNNUtfL1bIfD9S4MCAwEAAaOCAd0wggHZMA4GA1Ud
DwEB/wQEAwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUu
Z2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggr
BgEFBQcwAYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3
Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4
aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmww
JwYDVR0RBCAwHoEcdmluYXlhay55YWRhd2FkQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEF
BQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUdfdZDjQllkJZ
11q+72FdCdXw5QAwDQYJKoZIhvcNAQELBQADggEBAAWPTOWAHASL5k6QbnUh956OTvL/EJy1afBX
7cFzOVe/k0+gDNOEfNh7UVEBiK7l4IlIKQw9+rSNtJNCsST4iMSDmXHp6Tbfh4IsgLYRaxLNhLtM
kfWf6Bx/Mx2nP5hCEp4xJp+FhiUokqZLI2xB40I9RxtxF6kv64xQIV9QVuiSZe52q5QNEb5HV55Y
Bmc2McPH8Wf/GmIIVG2+JAgS69jN2B4xUSIYV9yYAt2leZITSTj5uWdCTJi9GxXgkpWwJASE1OsM
N2/IoUmHQLEEXlMbWj67Vp0K7P8CZnTeTh6rfLnTgJ+EoOJf+lyKb/TwfnJ3xPD7KF+TRoJTfPwS
BcMxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxanRIQ
bv4guv944aIwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEHHgziQui/BkAKp7GGA
gvQiWDwK7Z+1HaaffSVuk+inMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTIyMDcxNDA1MzAzNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCzv6t3ZxjflRiKaPbMFBc8UhfZhkOJEC5ENvuz
U9bXKVQ44zJzOVs8EB1Rini9F4obHa+e/ONHT/L9dJkEvl9yKA9yo4ae8xvcrchicZiM/HsOcQF6
F2AZgpCHBNQpC84DykodJGQ1fNbiqXnE+el9M8Y+nDJhmgQbRrQihihO6rI3zPIAVHz3nFao8NAc
PClM+0eRuRsPTlJGfcnyP0VgBAHCOMQmmnC5DetWM0Leyg5lixWwow6ooyAhSN8tv3MmdkLLQFN/
fcbkD2Y1aoycFs6fp+Ch42TvrufSaV4CDVL+obdPQgMpldzSE5l64nBwx1ThABolZfwRrsBRQmh6
--0000000000008954ac05e3bd3305--
