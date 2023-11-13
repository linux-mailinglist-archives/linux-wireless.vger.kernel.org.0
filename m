Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A107E9A7B
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 11:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjKMKmq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 05:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKMKmo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 05:42:44 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6650A10CC
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 02:42:40 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6bee11456baso3494729b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 02:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1699872160; x=1700476960; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JHdYdDanyZIvveGI8xtj7r7aRiOPWm86AD749MGMw3c=;
        b=QU3Dqg7flXwAMcVj3Q0IGELBv2w/zb5GHXQG2+7gPCoWjr3WChSqLzbgvCVxXs/ctM
         urNt78BoVzHEhW8ygbhq8eLPhcmS+vWYBA21P4gED3x7Ei7PyCrp4h6AtOkSX6geqwRi
         AXyheiqkniZpC0EsLTsHEpguHdI9dz4Ry04Ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699872160; x=1700476960;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JHdYdDanyZIvveGI8xtj7r7aRiOPWm86AD749MGMw3c=;
        b=G1ZnoC81vGiTBE2pr6+oQvYCysGmS5jITgvGhbFu0ZboxWDxpE7GMPbIn65qJwI3WW
         yh1qZ/pd042WfpIzsD6YSPNPISYLkHX1vDnlbeeGrlxI9uD/iuVmYk7qvDcljUqjZS7Z
         7kJbOXL9nGdIpnjfI9MR6NNYENw8jGfl0noFEndECDgSzrIqCsE9tSWOxCGXGNrM2KCK
         M6FDR9cg7tFnR0z6cQsuPs8QXqSsdiZFuigr+IiqtsonwQQ+x9/riRoX2NUPmw6oiOzl
         ivM6L7WngecBYewFhNeNz+Jc+db3JLTedI8hgzioB5DCl57lbExU4fzi3HLIPXWHXsiC
         B6Xw==
X-Gm-Message-State: AOJu0YwYL+jwRrFMoDCZUoro42Y9Iiw3KyX+TzReSVCAlriDEaOAh0IN
        H6vgxOyJGGUvu9kchhIC9Aq8yw==
X-Google-Smtp-Source: AGHT+IGRwC8czzGNxv7+gIrzDbbEvInAbLQSHx3kWtYOCEkv5SjbtzAZ9TmIWl4yf7c4XHRF3XbbFw==
X-Received: by 2002:a62:ab06:0:b0:68e:2d59:b1f3 with SMTP id p6-20020a62ab06000000b0068e2d59b1f3mr4077981pff.13.1699872159711;
        Mon, 13 Nov 2023 02:42:39 -0800 (PST)
Received: from C02F22LSML85.dhcp.broadcom.net ([192.19.252.250])
        by smtp.gmail.com with ESMTPSA id ei38-20020a056a0080e600b00682d79199e7sm3606604pfb.200.2023.11.13.02.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:42:38 -0800 (PST)
From:   Jithu Jance <jithu.jance@broadcom.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, vinayak.yadawad@broadcom.com,
        Jithu Jance <jithu.jance@broadcom.com>
Subject: [PATCH v2 1/1] wifi: nl80211: Add PTK/GTK rekey interval attributes for APs supporting PSK offload
Date:   Mon, 13 Nov 2023 16:12:32 +0530
Message-Id: <20231113104232.97803-1-jithu.jance@broadcom.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004518d9060a06545d"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_NO_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--0000000000004518d9060a06545d
Content-Transfer-Encoding: 8bit

This patch adds attributes to NL80211_CMD_START_AP that the user application
can use to pass down PTK/GTK rekey interval times to the driver. If driver can't
support the configuration, it is expected to return failure to NL8011_CMD_START_AP.
The rekey interval timings are to be passed in seconds.

---
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
index dced2c49daec..1bc4650efed1 100644
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
+ * supporting NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK.
+ *
+ * @NL80211_ATTR_GTK_REKEY_INTERVAL: GTK refresh interval in seconds for drivers
+ * supporting NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK.
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


--0000000000004518d9060a06545d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
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
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDb10ZO7CbPIqFTxpWpATEUw5TWtoJ3dmdI+
Z+OO/kQSMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTExMzEw
NDI0MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQBhXA5KIY6tjtpJWzpbhe1KEBMHUvRU3zLFd4PNcESZm+muAHQS0n0I
kSqrAePX/tBviOKBry8DB5lpCU9AtpwUD/ILDAzKiZciqQlfbi2apBU+PZ8MdLkHwvydWN9QhCfd
FAvKGCrhBjjtmzI6WfuNqn0uPXv4M8DWrvLrLXSyJMYHKFHLkQ1opOQ0P+JAE7r2Z8lOZgxNTetn
3fsj0kNQLNjcdaZKNKULzHPB9hoCo7fEFQzTK6d01w3JL0ViVCxnUpm7vyao1jRoyo7s6afGbF4A
QybJkG6eWEChaBll2p0fNuqfml93kuHs7hC39XPxrAJ5To23zQziFwemm6ek
--0000000000004518d9060a06545d--
