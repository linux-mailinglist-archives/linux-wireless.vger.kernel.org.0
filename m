Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE06F7E507A
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 07:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjKHGtW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 01:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKHGtV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 01:49:21 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F0E1B5
        for <linux-wireless@vger.kernel.org>; Tue,  7 Nov 2023 22:49:19 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so1654154a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 07 Nov 2023 22:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1699426159; x=1700030959; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7oVHHhdaMqS1H8blCRWicVGXUlG0u2YinqoxLo0sK40=;
        b=fFO0H07+u5go2DzCBoRf5uL2Pe4za0FM5cAc6ja50RSYL3p1DezsWZzIyqKyNzAM+j
         RekqJeDX3iuZx7ch7nIYuEPCZn1M/mTzqjwkDOPR2v2XmbWDGhRHsK6cAzAmjb1aUsov
         HjN+mrlsfgWxf6TyWJLj+zSWAa6izimz6Cars=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699426159; x=1700030959;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7oVHHhdaMqS1H8blCRWicVGXUlG0u2YinqoxLo0sK40=;
        b=Fbx+hVU+dUlH2ijS6W0rWI6JBi7AOa3ZcZUcDX0Gr6z7pxb1ton3vpJftSpScoQLNu
         U5ua7XjIiAvoRBbw2mT+bUNlbToy9oSEvkF+t9qBrSkXia98WVUJTooIWQPCUo/mlAui
         OGaOIpgHVt9j8+/81l1k6FiI3O5S0T6uM/T8mX8xloFymburZRXMPTgJkCUfidMdZopw
         kYwjuusua2XzLqsR9ZL23vUb+72vW6tKFNNXQR9L7AYrUK7lqoY/Shm4+mT/ONEIQ3iJ
         ZE7cA8k2fWrfTun13hBuQIx1j15uSw9dOlXqKLhljblleTD4Y1oV41H/GNIwnTlIPgr4
         WHAA==
X-Gm-Message-State: AOJu0Yy5lEFIhfI3Vpk9SAIAC7m6lFYzSAweo1TWGzgfqIoVSftie8Dl
        Rz8Obkz1l7rOOtqHNwH988cImQ==
X-Google-Smtp-Source: AGHT+IErj/VqnUnbwml+vb92G7ecgoBoj9tQvDT1fjrv6L2sPNZTFT/xN5eLdsR4T717FneyxIZa4g==
X-Received: by 2002:a05:6a20:914b:b0:181:bc16:48de with SMTP id x11-20020a056a20914b00b00181bc1648demr1338586pzc.31.1699426158712;
        Tue, 07 Nov 2023 22:49:18 -0800 (PST)
Received: from ibnvda0196.ibn.broadcom.net ([192.19.252.250])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902748400b001cc52ca2dfbsm932686pll.120.2023.11.07.22.49.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Nov 2023 22:49:18 -0800 (PST)
From:   Vinayak Yadawad <vinayak.yadawad@broadcom.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, jithu.jance@broadcom.com,
        Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Subject: [PATCH v2 1/1] wifi: nl80211: Extend del pmksa support for SAE and OWE security
Date:   Wed,  8 Nov 2023 12:19:08 +0530
Message-Id: <083b63a2e6f5ae42e11e4044350a28cea8d462b7.1699426085.git.vinayak.yadawad@broadcom.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000008a22cf06099e7c5e"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--0000000000008a22cf06099e7c5e
Content-Transfer-Encoding: 8bit

Current handling of del pmksa with SSID is limited to FILS
security. In the current change the del pmksa support is extended
to SAE/OWE security offloads as well. For OWE/SAE offloads, the
PMK is generated and cached at driver/FW, so user app needs the
capability to request cache deletion based on SSID for drivers
supporting SAE/OWE offload.
---
v1->v2: Addressed review comments for indentation
Signed-off-by: Vinayak Yadawad <vinayak.yadawad@broadcom.com>
---
 net/wireless/nl80211.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 569234bc2be6..8dc1c800f171 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12183,24 +12183,37 @@ static int nl80211_setdel_pmksa(struct sk_buff *skb, struct genl_info *info)
 
 	memset(&pmksa, 0, sizeof(struct cfg80211_pmksa));
 
-	if (!info->attrs[NL80211_ATTR_PMKID])
+	if ((info->genlhdr->cmd == NL80211_CMD_SET_PMKSA) &&
+	    (!info->attrs[NL80211_ATTR_PMKID]))
 		return -EINVAL;
 
-	pmksa.pmkid = nla_data(info->attrs[NL80211_ATTR_PMKID]);
+	if (info->attrs[NL80211_ATTR_PMKID])
+		pmksa.pmkid = nla_data(info->attrs[NL80211_ATTR_PMKID]);
 
 	if (info->attrs[NL80211_ATTR_MAC]) {
 		pmksa.bssid = nla_data(info->attrs[NL80211_ATTR_MAC]);
-	} else if (info->attrs[NL80211_ATTR_SSID] &&
-		   info->attrs[NL80211_ATTR_FILS_CACHE_ID] &&
-		   (info->genlhdr->cmd == NL80211_CMD_DEL_PMKSA ||
+	} else if (info->attrs[NL80211_ATTR_SSID]) {
+		/* SSID based pmksa flush suppported only for FILS,
+		 * OWE/SAE OFFLOAD cases
+		 */
+		if (info->attrs[NL80211_ATTR_FILS_CACHE_ID] &&
+		    (info->genlhdr->cmd == NL80211_CMD_DEL_PMKSA ||
 		    info->attrs[NL80211_ATTR_PMK])) {
+			pmksa.cache_id =
+				nla_data(info->attrs[NL80211_ATTR_FILS_CACHE_ID]);
+		} else if ((info->genlhdr->cmd == NL80211_CMD_DEL_PMKSA) &&
+		    (!wiphy_ext_feature_isset(
+		    &rdev->wiphy, NL80211_EXT_FEATURE_SAE_OFFLOAD) &&
+		    (!wiphy_ext_feature_isset(
+		    &rdev->wiphy,NL80211_EXT_FEATURE_OWE_OFFLOAD)))){
+			return -EINVAL;
+		}
 		pmksa.ssid = nla_data(info->attrs[NL80211_ATTR_SSID]);
 		pmksa.ssid_len = nla_len(info->attrs[NL80211_ATTR_SSID]);
-		pmksa.cache_id =
-			nla_data(info->attrs[NL80211_ATTR_FILS_CACHE_ID]);
 	} else {
 		return -EINVAL;
 	}
+
 	if (info->attrs[NL80211_ATTR_PMK]) {
 		pmksa.pmk = nla_data(info->attrs[NL80211_ATTR_PMK]);
 		pmksa.pmk_len = nla_len(info->attrs[NL80211_ATTR_PMK]);
-- 
2.32.0


--0000000000008a22cf06099e7c5e
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
XtHLz48aMtQwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDhvY//06vYHT/v7zMUK
fR3Z+VAb4wB5bb0Ru+/PMD2mMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTIzMTEwODA2NDkxOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA1cdSCPxpSXlWvHB6R/9e1XB4BJRfAz66bQ2bu
+eQ2D9KpdbGb50QDOf5O3Hzdcm/0i94dbEz3ejoxKm7PRM/ykl2vX4lIV3oU1ZRTTGaMX35mQu7b
H6aFK0w0CqPA1j7YJd3QKuIhKiwyYJstiNcVVaO2W+i0MslKiyAKLWnTNgM3fcsWHfVRVrX02T0H
oSXkjtxKzVHvxpxVRKyEvmuRSUXdifIH6hrA3um9NrRXrTIHugiHFMpHCP3pySVqfYDe6b2qa20O
Ur+NoTvWI+hYE+7J/hSib/yk+lF/ALyx3pgwHhkh06MpJjo1SFEXllP8y16hRf5Y/EIERYighlyR
--0000000000008a22cf06099e7c5e--
