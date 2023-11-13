Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278127E9C61
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 13:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjKMMry (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 07:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKMMry (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 07:47:54 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8CD171A
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 04:47:51 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6c10f098a27so3238457b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 04:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1699879671; x=1700484471; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JaGEnM2rJIV7UPao0q/Cv21f6cWpB34QUi+4DqR489U=;
        b=gU0TSqeScpdOKxMZPjDKzv0oQYVLqSZX1SI2UQpmte/KVz/ENM6BHXS2NdEJJSvoRT
         VNaeLc1a/rThHX9190KocJKumP3iwcX5Olg9kBJA1s2Kp+t2i5gbkgmNp7fPGhKTbBmm
         ShSzRTug2AurLLQGp742rg6E9Qnn6XRcxOneo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699879671; x=1700484471;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JaGEnM2rJIV7UPao0q/Cv21f6cWpB34QUi+4DqR489U=;
        b=Zbi36SMxDXaCRZYXyK6/BL+kny0S7svKMY/Xu+SMWRW8PEyPDZq6qrl7iRA5nETUMP
         SirScP9Q1QgxAWe8RmlPXHcCwl9Gpr3I+N8ACvP4jYU2PKYawq5DKWL+MROLXz2P+HSa
         wtQD8K0deXuuPshXA/4ikKJXiXOwFHwrieuIEi55qpv1QMMIbkhNt6X2A/pBC4sXGggl
         eelmeC2JOpppui5YbEFER1Fre6JuXzLQT+Oyg/aSf/IB8AIhUxVQSH5C7IdYS1AVxDbL
         sVCzxLYR++hlhCjB7QL+iPz97Q/fnf3zYINrlcpeT7GudRrfWf/miFWYk+NeU8/e4tBo
         PgvA==
X-Gm-Message-State: AOJu0Yyz9zKCjf4UIk+jJRBFX/Q5TgRA1l4J17ocFC0fYVTwzjpHz0oc
        PZZjXHraRfesEQwdSNnWBWU3dA==
X-Google-Smtp-Source: AGHT+IHl9NAqtQ624XBEWhQJ2t0NMPnNHb0JRdVe/9+DZRVN6+elPa5SVTwge9bgeWk5MaBQAqva8A==
X-Received: by 2002:a62:e313:0:b0:6b2:2a2d:7a25 with SMTP id g19-20020a62e313000000b006b22a2d7a25mr4215352pfh.29.1699879670239;
        Mon, 13 Nov 2023 04:47:50 -0800 (PST)
Received: from C02F22LSML85.lan ([180.151.107.109])
        by smtp.gmail.com with ESMTPSA id e16-20020a656890000000b005b6c1972c99sm3377513pgt.7.2023.11.13.04.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 04:47:49 -0800 (PST)
From:   Jithu Jance <jithu.jance@broadcom.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, vinayak.yadawad@broadcom.com,
        Jithu Jance <jithu.jance@broadcom.com>
Subject: [PATCH v3 1/1] wifi: nl80211: Add PTK/GTK rekey interval attributes for APs supporting PSK offload
Date:   Mon, 13 Nov 2023 18:17:42 +0530
Message-Id: <20231113124742.13588-1-jithu.jance@broadcom.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f36918060a0813d1"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_NO_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000f36918060a0813d1
Content-Transfer-Encoding: 8bit

This patch adds attributes to NL80211_CMD_START_AP that the user application
can use to pass down PTK/GTK rekey interval times to the driver. If driver can't
support the configuration, it is expected to return failure to NL8011_CMD_START_AP.
The rekey interval timings are to be passed in seconds.

---
v2 > v3: Fixed indentation
v1 > v2: Fixed the missing nl80211_policy changes

Signed-off-by: Jithu Jance <jithu.jance@broadcom.com>
---
 include/net/cfg80211.h       |  6 ++++++
 include/uapi/linux/nl80211.h | 13 +++++++++++++
 net/wireless/nl80211.c       | 13 +++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index b137a33a1b68..459e29d4d766 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1218,6 +1218,10 @@ struct survey_info {
  *
  *	NL80211_SAE_PWE_BOTH
  *	  Allow either hunting-and-pecking loop or hash-to-element
+ * @ptk_rekey_interval: PTK rekey interval in seconds for drivers supporting
+ *	AP 4 way handshake offload.
+ * @gtk_rekey_interval: GTK rekey interval in seconds for drivers supporting
+ *	AP 4 way handshake offload.
  */
 struct cfg80211_crypto_settings {
 	u32 wpa_versions;
@@ -1235,6 +1239,8 @@ struct cfg80211_crypto_settings {
 	const u8 *sae_pwd;
 	u8 sae_pwd_len;
 	enum nl80211_sae_pwe_mechanism sae_pwe;
+	u32 ptk_rekey_interval;
+	u32 gtk_rekey_interval;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index dced2c49daec..519be2b58cd0 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -205,6 +205,10 @@
  * preshared key material is provided, for example when that driver does
  * not support setting the temporal keys through %NL80211_CMD_NEW_KEY.
  *
+ * NL80211_CMD_START_AP can optionally carry %NL80211_ATTR_GTK_REKEY_INTERVAL
+ * and %NL80211_ATTR_PTK_REKEY_INTERVAL to pass down user configured values to
+ * the driver.
+ *
  * For 802.1X the PMK or PMK-R0 are set by providing %NL80211_ATTR_PMK
  * using %NL80211_CMD_SET_PMK. For offloaded FT support also
  * %NL80211_ATTR_PMKR0_NAME must be provided.
@@ -2826,6 +2830,12 @@ enum nl80211_commands {
  * @NL80211_ATTR_MLO_LINK_DISABLED: Flag attribute indicating that the link is
  *	disabled.
  *
+ * @NL80211_ATTR_PTK_REKEY_INTERVAL: PTK refresh interval in seconds for drivers
+ *	supporting NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK.
+ *
+ * @NL80211_ATTR_GTK_REKEY_INTERVAL: GTK refresh interval in seconds for drivers
+ *	supporting NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3364,6 +3374,9 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_MLO_LINK_DISABLED,
 
+	NL80211_ATTR_PTK_REKEY_INTERVAL,
+	NL80211_ATTR_GTK_REKEY_INTERVAL,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 569234bc2be6..514960e5681d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -818,6 +818,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_HW_TIMESTAMP_ENABLED] = { .type = NLA_FLAG },
 	[NL80211_ATTR_EMA_RNR_ELEMS] = { .type = NLA_NESTED },
 	[NL80211_ATTR_MLO_LINK_DISABLED] = { .type = NLA_FLAG },
+	[NL80211_ATTR_PTK_REKEY_INTERVAL] = { .type = NLA_U32 },
+	[NL80211_ATTR_GTK_REKEY_INTERVAL] = { .type = NLA_U32 },
 };
 
 /* policy for the key attributes */
@@ -10892,6 +10894,17 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
 	else
 		settings->sae_pwe = NL80211_SAE_PWE_UNSPECIFIED;
 
+	if (info->attrs[NL80211_ATTR_PTK_REKEY_INTERVAL] ||
+	    info->attrs[NL80211_ATTR_GTK_REKEY_INTERVAL]) {
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK))
+			return -EINVAL;
+		if (info->attrs[NL80211_ATTR_PTK_REKEY_INTERVAL])
+			settings->ptk_rekey_interval = nla_get_u32(info->attrs[NL80211_ATTR_PTK_REKEY_INTERVAL]);
+		else
+			settings->gtk_rekey_interval = nla_get_u32(info->attrs[NL80211_ATTR_GTK_REKEY_INTERVAL]);
+	}
+
 	return 0;
 }
 
-- 
2.38.1


--000000000000f36918060a0813d1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQagYJKoZIhvcNAQcCoIIQWzCCEFcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3BMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
XzCCBUkwggQxoAMCAQICDBhVVq9XaSHrnhQTpzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMzU2MzlaFw0yNTA5MTAxMzU2MzlaMIGM
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFDASBgNVBAMTC0ppdGh1IEphbmNlMScwJQYJKoZIhvcNAQkB
FhhqaXRodS5qYW5jZUBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQDQjZIkE6Gx9Y+DWz6jt7+wX/+tspCYqi2+cp8Yi8ToETLRFLalsTfwdLwk9qB/8sBsXwvcDRf0
uJPkhr8Rrwg5HGMfYEnLdYjOjS3kFPX0tTk5lb6RSAYY9gWTiAE6gsfzROm9QKCHzYNcCaYZl36y
4wyArr7cIWiXnlRsDb8hF/8m93POfn0OXOWJE9gJbTuzV6sWeiGpi4+RVqq/mvMLYANI1SCnEXJH
mpwrn0/6Sf3DEFfysFSvrnhOv7DRZ1OuvLvE6won+W2My2cUk/GwsJigcfVOIeW+6k8HqYoeS5Gv
DqYgzE2mJ/xRXZNMUqRea8CP9NUSkK5n5JKnGBMFAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGGppdGh1LmphbmNlQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUOaotQ254RGCyTOE3GmUYiOr6xQw
DQYJKoZIhvcNAQELBQADggEBAJQEmVAg5gHetC6cEpTOOkvxmlpVDUvrqLSJdclgVyEj1rM+Qc4q
VrkDMnRI9JpQ0XgPi+/oebdZ7NcqPnvkNyz1hU9T4i5KwG93YEvqKND02+TrR9TvNCqNhDV3v6qU
8aXoDtJuqSlkH8em+nzdVbHwp/4M9XNfKY2IaItl3wPDs1Ti4D6OewXG+hSmcsvbclgSvZTJnIJI
It9h7f+sXIxBghRNL631e4HsXTIi2U7EM1cnNupsDm6wZzg9O4bVtYexIi1fSy3xbOn+bxJOI4dM
pgEAAsnH2RekyBDHAWHW7qp7P+AXkLoNrQlGqs3r8W2eNgrwcxLphpakQ29LvhMxggJtMIICaQIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwYVVavV2kh654UE6cwDQYJ
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIK78bv6L2xDq0HCCGeaZN0UcH6p2zYn8LzJw
mnCaG+5CMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTExMzEy
NDc1MVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQACdk2yTCAmlP9Cvqgy/84cI4EWqjt79mmoUYZxZCIFQXRrlYpyn+p2
NAtHJvfXxhs85fkfmtC7FPMC+Tm3v5+3dovOCOYqq2+PjMzcJeRI6sLp3qVJHdqHCf0JoAk1wxtW
pMk1Yp2exOvQQgB40zAb0NZcHkCkww+fzHx20Y17fmT8qKWAmhSOuWpU/XJL44mu8SSXIcTkBb60
nzcIJ0ctaBsAZOC+EyJkN/bN6PQ52/mZLUNNp/6zSkaxFLieBQrDkRWsLTVMy3EAMmXS/ZvQIjw3
bjkNKsKaLsk21PNO+RdLKnd02cwEiTdAxwq0U0jYOnjg2mAmc5ZxLhQe3b6E
--000000000000f36918060a0813d1--
