Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613D179C73A
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Sep 2023 08:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjILGzE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Sep 2023 02:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjILGzD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Sep 2023 02:55:03 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0222AF
        for <linux-wireless@vger.kernel.org>; Mon, 11 Sep 2023 23:54:59 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c0d5b16aacso43058285ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 11 Sep 2023 23:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1694501699; x=1695106499; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b7AkImIHixbtmcaetHj8tokk3Hud/22bJx+86LBAUB4=;
        b=aAsEPfPUewhmYPluLozoy5psP8j5yU7UecfXtJE4ipg2G2l8uPo1x/1ElO47OKgY4B
         u4h2ntdCMjwAAwgnyx6vt9S2R4lHQSioxhiZ0/Q3n2/88i8ie10ALDC4gacgj06LgTPr
         MR7UD5k4Fj1moQL6V0aeRVWQk92kje2+fubTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694501699; x=1695106499;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b7AkImIHixbtmcaetHj8tokk3Hud/22bJx+86LBAUB4=;
        b=GP80rCLWHSbxGxwIjBPbkAwXm9kZKzFp/VBqmP47P4X2vHbk0fO8ClXNWtgu8XvHjw
         TlM5iUyP7ZTJCb3/Tv7ClZlM2xq0V3csyAnkfX6etbdeq7ifOGS4+fkqypQh0el1C0pj
         mLHwbdJn1IiTEewHSfxlEw9cGEX8hA6ohqFuMBa+grwYHFWSO3AP5PFjSIJNydfXc0hl
         db8Lb4cDGSe8CGSio09b9Q1GXjWCPNYtmmht3c9oC6M9zSl+hK4zxSJ0XxfkbrgBVl4u
         Pq087YrZ01BSl0Di6I8mJJ6aOzvubveUGlmu17nWpIUZbG/rw6vzbUsCd0ZluUWgtczf
         /TuQ==
X-Gm-Message-State: AOJu0Ywu6q/aacUlWWgnXPOAOyzzbTwQ4jV43+MXClJRJCinf7ClxiqM
        PZaN3EXh6/0ChnD5IhZFifnNK22qzhZd8hO3aEk=
X-Google-Smtp-Source: AGHT+IGv8faQv8Sae8Lv7hRIgSaNWAMNay48VgzvXRm2nqwF1/BoqlGU9dNtQbYqxO1En1quZ3XMzA==
X-Received: by 2002:a17:903:124f:b0:1bc:6861:d746 with SMTP id u15-20020a170903124f00b001bc6861d746mr12479781plh.58.1694501699252;
        Mon, 11 Sep 2023 23:54:59 -0700 (PDT)
Received: from ibnvda0196.ibn.broadcom.net ([192.19.252.250])
        by smtp.gmail.com with ESMTPSA id t14-20020a170902e84e00b001b9e9edbf43sm7664223plg.171.2023.09.11.23.54.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Sep 2023 23:54:58 -0700 (PDT)
From:   Vinayak Yadawad <vinayak.yadawad@broadcom.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, jithu.jance@broadcom.com,
        Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Subject: [PATCH 1/1] cfg80211: Allow AP/P2PGO to indicate port authorization to peer STA/P2PClient
Date:   Tue, 12 Sep 2023 12:24:51 +0530
Message-Id: <85614ee38fd3f68ade1810c2be0863c45c22fef1.1694499025.git.vinayak.yadawad@broadcom.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e1a35c060523ebd5"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000e1a35c060523ebd5
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
 net/wireless/sme.c     | 18 +++++++++++-------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 3a4b684f89bf..0ce46d0fd5ac 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7967,7 +7967,8 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
  * cfg80211_port_authorized - notify cfg80211 of successful security association
  *
  * @dev: network device
- * @bssid: the BSSID of the AP
+ * @peer_mac: BSSID of the AP/P2P GO in case of STA/GC or STA/GC macaddress in
+ * case of AP/P2P GO
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
+void cfg80211_port_authorized(struct net_device *dev, const u8 *peer_mac,
 			      const u8* td_bitmap, u8 td_bitmap_len, gfp_t gfp);
 
 /**
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 9bba233b5a6e..f4384e0cce7d 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1294,24 +1294,28 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
 }
 EXPORT_SYMBOL(cfg80211_roamed);
 
-void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid,
+void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *peer_mac,
 					const u8 *td_bitmap, u8 td_bitmap_len)
 {
 	ASSERT_WDEV_LOCK(wdev);
 
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_STATION &&
-		    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT))
+		    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT &&
+		    wdev->iftype != NL80211_IFTYPE_AP &&
+		    wdev->iftype != NL80211_IFTYPE_P2P_GO))
 		return;
 
 	if (WARN_ON(!wdev->connected) ||
-	    WARN_ON(!ether_addr_equal(wdev->u.client.connected_addr, bssid)))
+	    WARN_ON((!ether_addr_equal(wdev->u.client.connected_addr, peer_mac) &&
+	    (wdev->iftype == NL80211_IFTYPE_STATION ||
+	    wdev->iftype == NL80211_IFTYPE_P2P_CLIENT))))
 		return;
 
 	nl80211_send_port_authorized(wiphy_to_rdev(wdev->wiphy), wdev->netdev,
-				     bssid, td_bitmap, td_bitmap_len);
+				     peer_mac, td_bitmap, td_bitmap_len);
 }
 
-void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
+void cfg80211_port_authorized(struct net_device *dev, const u8 *peer_mac,
 			      const u8 *td_bitmap, u8 td_bitmap_len, gfp_t gfp)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
@@ -1319,7 +1323,7 @@ void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
 	struct cfg80211_event *ev;
 	unsigned long flags;
 
-	if (WARN_ON(!bssid))
+	if (WARN_ON(!peer_mac))
 		return;
 
 	ev = kzalloc(sizeof(*ev) + td_bitmap_len, gfp);
@@ -1327,7 +1331,7 @@ void cfg80211_port_authorized(struct net_device *dev, const u8 *bssid,
 		return;
 
 	ev->type = EVENT_PORT_AUTHORIZED;
-	memcpy(ev->pa.bssid, bssid, ETH_ALEN);
+	memcpy(ev->pa.bssid, peer_mac, ETH_ALEN);
 	ev->pa.td_bitmap = ((u8 *)ev) + sizeof(*ev);
 	ev->pa.td_bitmap_len = td_bitmap_len;
 	memcpy((void *)ev->pa.td_bitmap, td_bitmap, td_bitmap_len);
-- 
2.32.0


--000000000000e1a35c060523ebd5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQdgYJKoZIhvcNAQcCoIIQZzCCEGMCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3NMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVUwggQ9oAMCAQICDEjF3ute0cvPjxoy1DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxNDAxMTZaFw0yNTA5MTAxNDAxMTZaMIGU
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGDAWBgNVBAMTD1ZpbmF5YWsgWWFkYXdhZDErMCkGCSqGSIb3
DQEJARYcdmluYXlhay55YWRhd2FkQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBALGluSWGaYhsVi4bVabRPDQnYm//51u0IMWWKXgroawPGc8DFXsY5rRTKSEe2t57
Hcu6+9qBRZbf5cEsMo7DsnKxIforzj/CyPiHEGEVZeYlY77I+PsanMKbsn/DPEm8SSUHQTolLSDs
CLNrmVICkId5Y89k1xD0LqFL8po1wGwL+UK16vjVcp3V8IUpjtysuMxSc94V6stvWZav4sEyQ1bz
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
XtHLz48aMtQwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMsd4Ul0LU7cKCc5A+sV
j1p2sSmL0TR1VddrYHUlF/GFMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTIzMDkxMjA2NTQ1OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBWD28+gNnwpo8mGb2JEe5j7e0A8l3j9JF17nXN
gqJEq9zbUYfILT1tpKWuQIz2yfcHKPkSbM8IZZ0Kiqsrdr36Z1Z2HKCXZTQGRj7GYHzIMepWsbG7
2hJeeup+yw1LdTPW5O+4Y4ojefhCQariMv4ZPwWiloqfTZ+cdhYXNV1uSGzZob8lCGKTJOVLThjk
Hynj088SdvGVC/lTQpcFZHpvdgUAKvQ09iDfZc4C5jGTO+KaQe8Ce4ga6ZahYgyQXv0asXmezZMU
5NAwzKunDHOZNo6LA3N8J9SdgUQqywHH8ihowe0wA2toHGaJ3+b2dtbmibDEFRs5upvOdrAxnB4h
--000000000000e1a35c060523ebd5--
