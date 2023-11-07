Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65EA7E3550
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Nov 2023 07:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjKGGkd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Nov 2023 01:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKGGkc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Nov 2023 01:40:32 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CD6E8
        for <linux-wireless@vger.kernel.org>; Mon,  6 Nov 2023 22:40:29 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso4189532b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Nov 2023 22:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1699339229; x=1699944029; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uUdEB3gmq57FMEy9xNM0XPQ5CHFr00XI048nC+QIEtc=;
        b=cLMU9cAxfr5eEGGJszF2xRTaokjuDDAD3Ia5W/PqHBUq4wm6hfL2H4sA/FOOnKVdwF
         VpeOZBuJuBp8XZkF497svyp73OTGnVJl3tYbh0JHL65lIwF/+7x/so4JQC0iKxhhjytI
         wzQoCEeQnbrl/T+S0H86P1l8QpEGZobnSRhkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699339229; x=1699944029;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uUdEB3gmq57FMEy9xNM0XPQ5CHFr00XI048nC+QIEtc=;
        b=g5wNLgyAADjhmToTt0EYH8feWGKFEFuejFv/CipGJkqN5NYlqBFvPFwhJ/ebCZwbW+
         Jp9wuJTNusWqEG2yKKCXJK29yyem4BI+j0A0y0zpCtJvOlGH+2eI92N5JEX1hrXWqUW9
         66Gj+DG0eGNnQb0TBxk/Gq5n2OoSnnZm7BNYpT6kRel+J105OEQPtTyA40TL0xXC5IRI
         BBMhqFsj1/uRGgGYrm6ce3XkgYge00fPYgkxoRSJ8d1CiXianbpy1888eIuPThsRv0GT
         Do/07OY5/j+ErUN25UYH58mlEBKD7MTRc+bI69BEtPru6Wof/rhUV7JRHZ9oY/tF8ZQw
         VQgQ==
X-Gm-Message-State: AOJu0YyBMwfZIvasK3KGCQP0t8v/xalRti9Dv+31GAhwGRki2s4tEyW0
        2gQgFeTYrgVbPT0mETxx6bxN1Q==
X-Google-Smtp-Source: AGHT+IGUPINRcarNT1mkV1Oyghdprz13lVvTSy2Cq3fN7nrEpj41G4Li8LjLlxDGdJQCIKS7DxLb/g==
X-Received: by 2002:a05:6a00:1304:b0:6c2:e10:42e3 with SMTP id j4-20020a056a00130400b006c20e1042e3mr2165337pfu.8.1699339228778;
        Mon, 06 Nov 2023 22:40:28 -0800 (PST)
Received: from ibnvda0196.ibn.broadcom.net ([192.19.252.250])
        by smtp.gmail.com with ESMTPSA id c26-20020a62e81a000000b006b8bb35e313sm6528522pfi.103.2023.11.06.22.40.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Nov 2023 22:40:27 -0800 (PST)
From:   Vinayak Yadawad <vinayak.yadawad@broadcom.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, jithu.jance@broadcom.com,
        Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Subject: [PATCH 1/1] wifi:nl80211: Extend del pmksa support for SAE and OWE security
Date:   Tue,  7 Nov 2023 12:10:18 +0530
Message-Id: <a4e53b3538b04ce9c3f53b216d106c6914f4ad0b.1699339021.git.vinayak.yadawad@broadcom.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001d086506098a3f64"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_NO_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--0000000000001d086506098a3f64
Content-Transfer-Encoding: 8bit

Current handling of del pmksa with SSID is limited to FILS
security. In the current change the del pmksa support is extended
to SAE/OWE security offloads as well. For OWE/SAE offloads, the
PMK is generated and cached at driver/FW, so user app needs the
capability to request cache deletion based on SSID for drivers
supporting SAE/OWE offload.

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


--0000000000001d086506098a3f64
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
XtHLz48aMtQwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJzHw+ELdFCaIGO00QCd
g1jqGZjZJ0NZHh5wVlL9RzlIMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTIzMTEwNzA2NDAyOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCbgIkRxAhWdM30cnSYKOq4mWxbPRi46g9mpJbB
b3mgJs8Glg24she9fRYtOQfWpWhrkC0TGEspxKqhwrZ4+438EGaEYiI3CGbGHmncMkI3XMfxTtTg
esrn+nh1XjTweukIlfzuTjIDqnDBNTPbNLUpB7a8c2MvcoRlTiZwBcVOsb65I7JGsThoiI37t9Zy
oU8w2a5C/JYPwjzG/BXBY8DtRQSM3DYI4XAyanJBHTngqRlKaj051YAFBlG6Ch1ExIUCLqi+SpyP
BsFQf/SmdFSMdoKPa9pvgFAHylpSXqfj6rwHi7xYQ3Qq+khx456zLcobV1hv0O4IOe/WVSTcOHhN
--0000000000001d086506098a3f64--
