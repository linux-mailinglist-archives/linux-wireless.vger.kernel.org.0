Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C415A2561
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Aug 2022 12:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiHZKE4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Aug 2022 06:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245228AbiHZKE1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Aug 2022 06:04:27 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162D4D9EAD
        for <linux-wireless@vger.kernel.org>; Fri, 26 Aug 2022 03:03:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id m2so1191388pls.4
        for <linux-wireless@vger.kernel.org>; Fri, 26 Aug 2022 03:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc;
        bh=Ax9fdXLbFaofSbdg3qzf6gGxGymPvt5sbkqxLmZ24LQ=;
        b=Ud5inWYRRNzmVJq1Bt5MJtxzpJFxni/5YLRH1pszidsjcbu4FgLK8Lciswrda5KXwh
         d4y0frrac8jhhgG+JQjJK4Q1UNLAZ0iF7/GfKFlA3E+wViCmKtrIbQhXq39DzINuULWL
         vLbzM2ue3CAWhYCHUWbEaX+J5E5Mo2gw5YOx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=Ax9fdXLbFaofSbdg3qzf6gGxGymPvt5sbkqxLmZ24LQ=;
        b=AG9PxFjPw80ALQtk7duweEyjm3W0XzUTpzlWIy7jZ59uZ5Un0U+o36KjeaqBZEMVm7
         yi/A5nvb3kOK9d1MDM2kdLglnhvPSEamwOp71dz5LHLXnzFa7zVgqUy2d1M+4eSZ3/1n
         Xsy7N6D45inLidCD2MlRMi4Em1xT1awg0TcqwA3ZTQ7YfoloNb2dDyDL0hRMpsMgnqtc
         hd9W3MF6xGQHsZ//KubYK96HZXXIWFqWTRNcUHDkfZpMvZCn+mixwcvD1tFDj8VBmaYs
         PyF4MfimjL6IBIexTHh9I6l7+OOpkOBARrk2Idve/dpo/fO5HC6Q3vFgDSKPt5ptIWCp
         j5uQ==
X-Gm-Message-State: ACgBeo0WAWq/HAk+ukC2Vu5JzOzhLsNmrNDMgoagVt5+BR59f1XTmgZ8
        d6JMxARZ/KKtQ/tVX/5wJuudnvnimxfVdw==
X-Google-Smtp-Source: AA6agR4LGrRd1ioEo50TDln+s5kiQA9hQKz+antnvMhG0X0lmNoTQAqY8q5MyBslwXIvN09F3Ub4Ew==
X-Received: by 2002:a17:903:18a:b0:16f:e43:efdf with SMTP id z10-20020a170903018a00b0016f0e43efdfmr3025098plg.157.1661508193709;
        Fri, 26 Aug 2022 03:03:13 -0700 (PDT)
Received: from ibnvda0196.ibn.broadcom.net ([192.19.252.250])
        by smtp.gmail.com with ESMTPSA id p15-20020a170902e74f00b0016d5b7fb02esm1180137plf.60.2022.08.26.03.03.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Aug 2022 03:03:13 -0700 (PDT)
From:   Vinayak Yadawad <vinayak.yadawad@broadcom.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, jithu.jance@broadcom.com,
        Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Subject: [PATCH 1/1] cfg80211: Update Transition Disable policy during port authorization
Date:   Fri, 26 Aug 2022 15:33:03 +0530
Message-Id: <a408102ee0917de77ecb3a0b63cd7c650ba93750.1661506891.git.vinayak.yadawad@broadcom.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b4e2f805e7220598"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_NO_TEXT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000b4e2f805e7220598
Content-Transfer-Encoding: 8bit

In case of 4way handshake offload, transition disable policy
updated by the AP during EAPOL 3/4 is not updated to the cfg80211
layer. This results in mismatch between transition disable policy
between the upper layer and the driver. This patch addresses this
issue by updating transition disable policy as part of port
authorization indiation.

Signed-off-by: Vinayak Yadawad <vinayak.yadawad@broadcom.com>
---
 include/net/cfg80211.h       | 2 +-
 include/uapi/linux/nl80211.h | 1 +
 net/wireless/core.h          | 4 +++-
 net/wireless/nl80211.c       | 6 ++++--
 net/wireless/nl80211.h       | 3 ++-
 net/wireless/sme.c           | 8 +++++---
 net/wireless/util.c          | 2 +-
 7 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 908d58393484..9c89102c85cd 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7669,7 +7669,7 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
  * indicate the 802.11 association.
  */
 void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
-			      gfp_t gfp);
+			      const u8 td_bitmap, gfp_t gfp);
 
 /**
  * cfg80211_disconnected - notify cfg80211 that connection was dropped
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index ffb7c573e299..ef0c882d214b 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3268,6 +3268,7 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_TX_HW_TIMESTAMP,
 	NL80211_ATTR_RX_HW_TIMESTAMP,
+	NL80211_ATTR_TD_BITMAP,
 
 	/* add attributes here, update the policy in nl80211.c */
 
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 775e16cb99ed..8baa3487f67f 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -271,6 +271,7 @@ struct cfg80211_event {
 		} ij;
 		struct {
 			u8 bssid[ETH_ALEN];
+			u8 td_bitmap;
 		} pa;
 	};
 };
@@ -409,7 +410,8 @@ int cfg80211_disconnect(struct cfg80211_registered_device *rdev,
 			bool wextev);
 void __cfg80211_roamed(struct wireless_dev *wdev,
 		       struct cfg80211_roam_info *info);
-void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid);
+void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid,
+				const u8 td_bitmap);
 int cfg80211_mgd_wext_connect(struct cfg80211_registered_device *rdev,
 			      struct wireless_dev *wdev);
 void cfg80211_autodisconnect_wk(struct work_struct *work);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2705e3ee8fc4..eee3a2d6e6f7 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -17841,7 +17841,8 @@ void nl80211_send_roamed(struct cfg80211_registered_device *rdev,
 }
 
 void nl80211_send_port_authorized(struct cfg80211_registered_device *rdev,
-				  struct net_device *netdev, const u8 *bssid)
+				  struct net_device *netdev, const u8 *bssid,
+				  const u8 td_bitmap)
 {
 	struct sk_buff *msg;
 	void *hdr;
@@ -17858,7 +17859,8 @@ void nl80211_send_port_authorized(struct cfg80211_registered_device *rdev,
 
 	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
 	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, netdev->ifindex) ||
-	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, bssid))
+	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, bssid) ||
+	    nla_put_u8(msg, NL80211_ATTR_TD_BITMAP, td_bitmap))
 		goto nla_put_failure;
 
 	genlmsg_end(msg, hdr);
diff --git a/net/wireless/nl80211.h b/net/wireless/nl80211.h
index 855d540ddfb9..5001d9d8c635 100644
--- a/net/wireless/nl80211.h
+++ b/net/wireless/nl80211.h
@@ -83,7 +83,8 @@ void nl80211_send_roamed(struct cfg80211_registered_device *rdev,
 			 struct net_device *netdev,
 			 struct cfg80211_roam_info *info, gfp_t gfp);
 void nl80211_send_port_authorized(struct cfg80211_registered_device *rdev,
-				  struct net_device *netdev, const u8 *bssid);
+				  struct net_device *netdev, const u8 *bssid,
+				  const u8 td_bitmap);
 void nl80211_send_disconnected(struct cfg80211_registered_device *rdev,
 			       struct net_device *netdev, u16 reason,
 			       const u8 *ie, size_t ie_len, bool from_ap);
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 27fb2a0c4052..5e9db942cbbb 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1234,7 +1234,8 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
 }
 EXPORT_SYMBOL(cfg80211_roamed);
 
-void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid)
+void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid,
+					const u8 td_bitmap)
 {
 	ASSERT_WDEV_LOCK(wdev);
 
@@ -1247,11 +1248,11 @@ void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid)
 		return;
 
 	nl80211_send_port_authorized(wiphy_to_rdev(wdev->wiphy), wdev->netdev,
-				     bssid);
+				     bssid, td_bitmap);
 }
 
 void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
-			      gfp_t gfp)
+			      const u8 td_bitmap, gfp_t gfp)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
@@ -1267,6 +1268,7 @@ void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
 
 	ev->type = EVENT_PORT_AUTHORIZED;
 	memcpy(ev->pa.bssid, bssid, ETH_ALEN);
+	ev->pa.td_bitmap = td_bitmap;
 
 	/*
 	 * Use the wdev event list so that if there are pending
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 2c127951764a..6a1d82c43766 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -988,7 +988,7 @@ void cfg80211_process_wdev_events(struct wireless_dev *wdev)
 			__cfg80211_leave(wiphy_to_rdev(wdev->wiphy), wdev);
 			break;
 		case EVENT_PORT_AUTHORIZED:
-			__cfg80211_port_authorized(wdev, ev->pa.bssid);
+			__cfg80211_port_authorized(wdev, ev->pa.bssid, ev->pa.td_bitmap);
 			break;
 		}
 		wdev_unlock(wdev);
-- 
2.32.0


--000000000000b4e2f805e7220598
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
bv4guv944aIwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFj7rLV/QhrCEZyVlsGw
7k1F1jPaSNDbDpV3RcWU71jeMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTIyMDgyNjEwMDMxNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAwnWq811fhWqU/jbouAHdvLq65yh/PDI61LLCz
VoH6A29JTYd+Cao2dlvxMZylTuz8agw7+VCpxjq+Z7E4Kmg1049JVxogzFDYQf+V5gYEBwQYkoER
Da7jnVOTHLq2FQeNunzzP/2bLq7D/V35mQztY5kFLdGb3ERDN1QdDTDHSapg+mTOYhQaWzGTBpbg
Toe62eQJ25XgyTBA9M9504Ckyb1A7bn/hLyHQxI48Kp+/8ead6oWf8+JGWjefkTOnrPwOBaK+HsJ
sp9oxiz1XbZ25s+Cr4lzwCFCbWMUv956PrMHiWTBlC/kZOzAYoPIiIw2HMXFHNACHcXbxC/YCbzo
--000000000000b4e2f805e7220598--
