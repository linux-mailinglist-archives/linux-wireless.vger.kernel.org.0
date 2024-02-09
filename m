Return-Path: <linux-wireless+bounces-3389-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 778E084F623
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 14:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC9C1F2471D
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 13:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB023C471;
	Fri,  9 Feb 2024 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TdU+ZSys"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF9B3C099
	for <linux-wireless@vger.kernel.org>; Fri,  9 Feb 2024 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707486325; cv=none; b=aAWgY6Edql6ZUz7NKjPlxOhD0vR9W4EqlfGPSir2GlwEVnkfsNWsrusMWnCAt6nsbf+gh+HS3a+jC54cZbfbMkhpGdZK4MezrUkWf4CzZhf7RiZdsDktTr8Aa3xkv1joZYcNZ5KsuuGSjiXGCk8O5MBZKD5rgfzuxsnhoNnsTdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707486325; c=relaxed/simple;
	bh=O7ExEhOfreOhKikgsOgxHOgUH/7a0r/6CmnFs2T6wEo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SkcYQdDpa7WgZq4ef8dL3DGiXhfZcp47TPuoHBmoUJALyxSz2mJnTVon6LdYTywlSCIJha7rnpjeV1Gh45CfQ1Hm2osHjWU5s9zxTNirIwzLpThVfyJmTA7tskL5qYM6nhn7nCy2q3EJhwuN14oA1QaYcfkih5JOhoLM+1CnfTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TdU+ZSys; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-783f3d27bfbso41218085a.2
        for <linux-wireless@vger.kernel.org>; Fri, 09 Feb 2024 05:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707486323; x=1708091123; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wjGCK4lgpy/0QQ/lFE2vHUo6oRVe9mteXFl8otNH7i8=;
        b=TdU+ZSyspbfNMV75//vQfrKgyoNhqBxPOuyk/a18ZBEdobclHLXfD9x3JOVBacKS1x
         QmH7TOVciqgEXKSYSHEM7pHrkxRcy0YdO77q+AUOgWeuUplqRz4mqc1Op+tc9skb9I2J
         LFjgTIL8owXca4x4AbmbMv58I1m7sqHhHUlIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707486323; x=1708091123;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wjGCK4lgpy/0QQ/lFE2vHUo6oRVe9mteXFl8otNH7i8=;
        b=EY2R428bmnbV5UeFMY4sgo69BPSMuUN+UTKB0amOQ4QLqu0gQSBQ3uete+rK8/nJpF
         jDSb2qH9Pw6R9IIaP4lUHdLBV+w/54DR2YFDuHFnrpcHjlmZTODvovIF12v6bKARTsIJ
         q9AYjjsdqHSJuBz8l9mkPkonik0+nXcHyGGnIqgxUWk/lEZYWVLfjsPuNgH7g7Yen9Ac
         /8cCm+S9Hnoa33WmW1xg+G6TqQYZx74heVx4WmuuTVb2WYTXJYjxZkFaDsFqYWSf36cv
         haUjbKLm6phtt9f+9JTHxy2AnOzE+WF5XojFaDTHzKkB8nxvWOB7u5cbMZ0heC1wONVH
         /UEw==
X-Gm-Message-State: AOJu0YylK69jtuAnWYFIDmxPbuaQCv0WrVlPQTIs+0mLIMbD0HMtO972
	4D8XAGHaGen6gUJB/SPI3tloyZcaNCgNY3N2BeHcgviOr0W3ddczy2CjJK9D0w==
X-Google-Smtp-Source: AGHT+IHvMs+FHIzq2AZspOOV3PVKPJ09r60srJMtnF2wYlmsJpEfxYPTLj5XGIjAkxyV18cHQjkGvA==
X-Received: by 2002:a05:620a:2287:b0:785:74f5:62c6 with SMTP id o7-20020a05620a228700b0078574f562c6mr1436159qkh.75.1707486322816;
        Fri, 09 Feb 2024 05:45:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLWn7VXT2a4ntW4EW8XSZSiPaqHQBujPWVhlnU9JAS9wVDtazwNZgBADEwrKcPEoqlNunhhwO/SGGRg99IeskmjpzSgHng9ct7wEjEN1kcmNTMf4E5o39ODY/nFZkJiOMP4zVJhpQ=
Received: from hnd.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id bq42-20020a05620a46aa00b00783fed2e88fsm730598qkb.20.2024.02.09.05.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 05:45:22 -0800 (PST)
From: Vinayak Yadawad <vinayak.yadawad@broadcom.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	jithu.jance@broadcom.com,
	Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Subject: [PATCH 1/1] wifi: nl80211: Add support for plumbing SAE groups to driver
Date: Fri,  9 Feb 2024 19:20:43 +0530
Message-Id: <309965e8ef4d220053ca7e6bd34393f892ea1bb8.1707486287.git.vinayak.yadawad@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c0b6b80610f323d5"

--000000000000c0b6b80610f323d5
Content-Transfer-Encoding: 8bit

In case of SAE authentication offload, the driver would need
the info of SAE DH groups for both STA connection and soft AP.
In the current change we update the SAE DH group support info
to driver in the order/priority as provided by the supplicant/
upper layer.

Signed-off-by: Vinayak Yadawad <vinayak.yadawad@broadcom.com>
---
 include/net/cfg80211.h       |  6 ++++++
 include/uapi/linux/nl80211.h |  7 +++++++
 net/wireless/nl80211.c       | 22 ++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 5b42bfc..0b2db0d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1194,6 +1194,7 @@ struct survey_info {
 };
 
 #define CFG80211_MAX_NUM_AKM_SUITES	10
+#define CFG80211_MAX_NUM_SAE_DH_GROUPS 10
 
 /**
  * struct cfg80211_crypto_settings - Crypto settings
@@ -1235,6 +1236,9 @@ struct survey_info {
  *
  *	NL80211_SAE_PWE_BOTH
  *	  Allow either hunting-and-pecking loop or hash-to-element
+ *
+ * @sae_dh_groups: SAE DH groups in preference order.
+ * @n_sae_dhd_groups: No of SAE DH groups assigned.
  */
 struct cfg80211_crypto_settings {
 	u32 wpa_versions;
@@ -1252,6 +1256,8 @@ struct cfg80211_crypto_settings {
 	const u8 *sae_pwd;
 	u8 sae_pwd_len;
 	enum nl80211_sae_pwe_mechanism sae_pwe;
+	u32 sae_dh_groups[CFG80211_MAX_NUM_SAE_DH_GROUPS];
+	u8 n_sae_dh_groups;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 853ac53..7c1a7b4 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2855,6 +2855,11 @@ enum nl80211_commands {
  *	%NL80211_CMD_ASSOCIATE indicating the SPP A-MSDUs
  *	are used on this connection
  *
+ * @NL80211_ATTR_SAE_DH_GROUPS: Attribute to indicate the supported SAE DH
+ *	groups to driver. For STA role, the dh groups should be tried in the
+ *	indicated order. For AP role, the order does not have any specific
+ *	significance.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3400,6 +3405,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_ASSOC_SPP_AMSDU,
 
+	NL80211_ATTR_SAE_DH_GROUPS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 68c2040..555eb0f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -826,6 +826,7 @@ static int validate_he_capa(const struct nlattr *attr,
 	[NL80211_ATTR_MLO_TTLM_DLINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
 	[NL80211_ATTR_MLO_TTLM_ULINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
 	[NL80211_ATTR_ASSOC_SPP_AMSDU] = { .type = NLA_FLAG },
+	[NL80211_ATTR_SAE_DH_GROUPS] = { .type = NLA_NESTED },
 };
 
 /* policy for the key attributes */
@@ -10883,6 +10884,27 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
 	else
 		settings->sae_pwe = NL80211_SAE_PWE_UNSPECIFIED;
 
+	if (info->attrs[NL80211_ATTR_SAE_DH_GROUPS]) {
+		struct nlattr *dh_group;
+		int tmp, i = 0;
+
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_SAE_OFFLOAD) &&
+		    !wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_SAE_OFFLOAD_AP))
+			return -EINVAL;
+
+		nla_for_each_nested(dh_group, info->attrs[NL80211_ATTR_SAE_DH_GROUPS],
+		    tmp) {
+			settings->sae_dh_groups[i] = nla_get_u32(dh_group);
+			i++;
+
+			if (i == CFG80211_MAX_NUM_SAE_DH_GROUPS)
+				break;
+		}
+		settings->n_sae_dh_groups = i;
+	}
+
 	return 0;
 }
 
-- 
1.8.3.1


--000000000000c0b6b80610f323d5
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
XtHLz48aMtQwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDG0CtGs1L85bA4vBKHo
HYBJEXKRSR48I8OOCDb9A38AMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTI0MDIwOTEzNDUyM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCpNbSadD5tAoWw4CQjWDGi++KfoVsV7/e0e6mF
1ugzv+Lt8OhOkoLVrcwq8FbA3YgrRrQeJJgaeJvYaIST9dh/BIXxHhX/kzGZlIBzHrTXqcRtnp12
S2xAp6AW0AmNenoaMrYorUwXUw3wGf78Q2QqTmDFRekDl2AyS2aoX+MStRpVTaCZLDnOi/kL4jZL
GFHOpyz8DPL8dOvT5m60wI9zldFrPbMWU3t8CQmMkVuRbgcGxLIKX5WqdlNipJqjbAVL+8+Grj3G
aqWYv5Hc4MlA4C12JKmIFEgLyceS2QDO/ycjGZYSWIYE2aCJJ5aqaFgcCfJYSAc1h9KZSt5xx8A9
--000000000000c0b6b80610f323d5--

