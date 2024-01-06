Return-Path: <linux-wireless+bounces-1553-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC093825F40
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jan 2024 11:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194B21C21329
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jan 2024 10:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9469C6FB5;
	Sat,  6 Jan 2024 10:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GmiNJcZP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C1A6FA6
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jan 2024 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-67ff241c2bcso4106396d6.1
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jan 2024 02:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704537523; x=1705142323; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UVjrwaADQlKDCzlyWYKwNfJZEnaAITgEzLJY+d+eq1E=;
        b=GmiNJcZPGWxQVgigmuPZW33Br7+0GdG87TWWMmi6JPqtmcXPJ7NmoKBRCCWIhsf+Bp
         O0i6zWfQ0Ro1BT2BiqpCAsv5w2GtSShXJNVeCaqznjyFRKKDXvB3rRC+EcLPDQKaWlAQ
         UI/dfaLjq8EFc/y+HfDuWDwWuUpbZG6PC2pxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704537523; x=1705142323;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVjrwaADQlKDCzlyWYKwNfJZEnaAITgEzLJY+d+eq1E=;
        b=W2GMlQp1CUQx7sV2I85myic8ak4xdxFFGw9SxnYPVZaETKo1AY0QorcLwwzkVvAeX+
         FYH7GrnEOaR95n3YqSWztOhmiP555YruzDWNA4DXgEPpBhL0erV+Cb8Q8RgtDkNwt6Zq
         vJHS874hI+abXnx2CYdUoG0kxJd8EG4SF6QPHNhifiI02EUlYhyEvwv4zTfDAjDfCLkS
         NH0nznZ2QdobAV6P4lo6RA2FTRNmv0HnYwNSA3BjnJzeEEaBD6RWgNJ+r67VZ6ELc7Ex
         sHFYu3wfaKyVFrfGkgH0gfe9IYP5naWa6fgEOa9g1uQAGPWvPAJFZ/kxo6Ah8IpLmSNJ
         lbxw==
X-Gm-Message-State: AOJu0Yy3MbSxaaxGYclR0YyyK3qoTQnA+smdEjoayEQNxWMBaJqGq4V3
	pvxmzRoMUBm6nHfuVv16zFRSaSwPQpJv0idmWXxSuGk4MOq3S5s=
X-Google-Smtp-Source: AGHT+IEfmT0CsN1idtospb/CO0VVtTfW7VNvmXOCI9NvhHqn9dY9mtKTFI4ekceYKyg19ab//KnCyw==
X-Received: by 2002:a05:6214:1256:b0:680:c09c:6102 with SMTP id r22-20020a056214125600b00680c09c6102mr1108130qvv.62.1704537522921;
        Sat, 06 Jan 2024 02:38:42 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id k1-20020ad44501000000b0067f70fffc7bsm1312927qvu.2.2024.01.06.02.38.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jan 2024 02:38:41 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	Hector Martin <marcan@marcan.st>,
	stable@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH V2 1/3] wifi: brcmfmac: Demote vendor-specific attach/detach messages to info
Date: Sat,  6 Jan 2024 11:38:33 +0100
Message-Id: <20240106103835.269149-2-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240106103835.269149-1-arend.vanspriel@broadcom.com>
References: <20240106103835.269149-1-arend.vanspriel@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000093530d060e4491c3"

--00000000000093530d060e4491c3
Content-Transfer-Encoding: 8bit

From: Hector Martin <marcan@marcan.st>

People are getting spooked by brcmfmac errors on their boot console.
There's no reason for these messages to be errors.

Cc: stable@vger.kernel.org # 6.2.x
Fixes: d6a5c562214f ("wifi: brcmfmac: add support for vendor-specific firmware api")
Signed-off-by: Hector Martin <marcan@marcan.st>
[arend.vanspriel@broadcom.com: remove attach/detach vendor callbacks]
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../broadcom/brcm80211/brcmfmac/bca/core.c    | 13 ----------
 .../broadcom/brcm80211/brcmfmac/cyw/core.c    | 13 ----------
 .../broadcom/brcm80211/brcmfmac/fwvid.c       |  7 +++--
 .../broadcom/brcm80211/brcmfmac/fwvid.h       | 26 ++-----------------
 .../broadcom/brcm80211/brcmfmac/wcc/core.c    | 15 +----------
 5 files changed, 6 insertions(+), 68 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/core.c
index a5d9ac5e6763..a963c242975a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/core.c
@@ -11,17 +11,6 @@
 
 #include "vops.h"
 
-static int brcmf_bca_attach(struct brcmf_pub *drvr)
-{
-	pr_err("%s: executing\n", __func__);
-	return 0;
-}
-
-static void brcmf_bca_detach(struct brcmf_pub *drvr)
-{
-	pr_err("%s: executing\n", __func__);
-}
-
 static void brcmf_bca_feat_attach(struct brcmf_if *ifp)
 {
 	/* SAE support not confirmed so disabling for now */
@@ -29,7 +18,5 @@ static void brcmf_bca_feat_attach(struct brcmf_if *ifp)
 }
 
 const struct brcmf_fwvid_ops brcmf_bca_ops = {
-	.attach = brcmf_bca_attach,
-	.detach = brcmf_bca_detach,
 	.feat_attach = brcmf_bca_feat_attach,
 };
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
index 24670497f1a4..bec5748310b9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
@@ -11,17 +11,6 @@
 
 #include "vops.h"
 
-static int brcmf_cyw_attach(struct brcmf_pub *drvr)
-{
-	pr_err("%s: executing\n", __func__);
-	return 0;
-}
-
-static void brcmf_cyw_detach(struct brcmf_pub *drvr)
-{
-	pr_err("%s: executing\n", __func__);
-}
-
 static int brcmf_cyw_set_sae_pwd(struct brcmf_if *ifp,
 				 struct cfg80211_crypto_settings *crypto)
 {
@@ -49,7 +38,5 @@ static int brcmf_cyw_set_sae_pwd(struct brcmf_if *ifp,
 }
 
 const struct brcmf_fwvid_ops brcmf_cyw_ops = {
-	.attach = brcmf_cyw_attach,
-	.detach = brcmf_cyw_detach,
 	.set_sae_password = brcmf_cyw_set_sae_pwd,
 };
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
index 86eafdb40541..f633e2bbd891 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
@@ -89,8 +89,7 @@ int brcmf_fwvid_register_vendor(enum brcmf_fwvendor fwvid, struct module *vmod,
 	if (fwvid >= BRCMF_FWVENDOR_NUM)
 		return -ERANGE;
 
-	if (WARN_ON(!vmod) || WARN_ON(!vops) ||
-	    WARN_ON(!vops->attach) || WARN_ON(!vops->detach))
+	if (WARN_ON(!vmod) || WARN_ON(!vops))
 		return -EINVAL;
 
 	if (WARN_ON(fwvid_list[fwvid].vmod))
@@ -150,7 +149,7 @@ static inline int brcmf_fwvid_request_module(enum brcmf_fwvendor fwvid)
 }
 #endif
 
-int brcmf_fwvid_attach_ops(struct brcmf_pub *drvr)
+int brcmf_fwvid_attach(struct brcmf_pub *drvr)
 {
 	enum brcmf_fwvendor fwvid = drvr->bus_if->fwvid;
 	int ret;
@@ -175,7 +174,7 @@ int brcmf_fwvid_attach_ops(struct brcmf_pub *drvr)
 	return ret;
 }
 
-void brcmf_fwvid_detach_ops(struct brcmf_pub *drvr)
+void brcmf_fwvid_detach(struct brcmf_pub *drvr)
 {
 	enum brcmf_fwvendor fwvid = drvr->bus_if->fwvid;
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
index d9fc76b46db9..dac22534d033 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
@@ -12,8 +12,6 @@ struct brcmf_pub;
 struct brcmf_if;
 
 struct brcmf_fwvid_ops {
-	int (*attach)(struct brcmf_pub *drvr);
-	void (*detach)(struct brcmf_pub *drvr);
 	void (*feat_attach)(struct brcmf_if *ifp);
 	int (*set_sae_password)(struct brcmf_if *ifp, struct cfg80211_crypto_settings *crypto);
 };
@@ -24,30 +22,10 @@ int brcmf_fwvid_register_vendor(enum brcmf_fwvendor fwvid, struct module *mod,
 int brcmf_fwvid_unregister_vendor(enum brcmf_fwvendor fwvid, struct module *mod);
 
 /* core driver functions */
-int brcmf_fwvid_attach_ops(struct brcmf_pub *drvr);
-void brcmf_fwvid_detach_ops(struct brcmf_pub *drvr);
+int brcmf_fwvid_attach(struct brcmf_pub *drvr);
+void brcmf_fwvid_detach(struct brcmf_pub *drvr);
 const char *brcmf_fwvid_vendor_name(struct brcmf_pub *drvr);
 
-static inline int brcmf_fwvid_attach(struct brcmf_pub *drvr)
-{
-	int ret;
-
-	ret = brcmf_fwvid_attach_ops(drvr);
-	if (ret)
-		return ret;
-
-	return drvr->vops->attach(drvr);
-}
-
-static inline void brcmf_fwvid_detach(struct brcmf_pub *drvr)
-{
-	if (!drvr->vops)
-		return;
-
-	drvr->vops->detach(drvr);
-	brcmf_fwvid_detach_ops(drvr);
-}
-
 static inline void brcmf_fwvid_feat_attach(struct brcmf_if *ifp)
 {
 	const struct brcmf_fwvid_ops *vops = ifp->drvr->vops;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
index 2d8f80bd7382..fd593b93ad40 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
@@ -7,21 +7,10 @@
 #include <core.h>
 #include <bus.h>
 #include <fwvid.h>
-#include <fwil.h>
+#include <cfg80211.h>
 
 #include "vops.h"
 
-static int brcmf_wcc_attach(struct brcmf_pub *drvr)
-{
-	pr_debug("%s: executing\n", __func__);
-	return 0;
-}
-
-static void brcmf_wcc_detach(struct brcmf_pub *drvr)
-{
-	pr_debug("%s: executing\n", __func__);
-}
-
 static int brcmf_wcc_set_sae_pwd(struct brcmf_if *ifp,
 				 struct cfg80211_crypto_settings *crypto)
 {
@@ -30,7 +19,5 @@ static int brcmf_wcc_set_sae_pwd(struct brcmf_if *ifp,
 }
 
 const struct brcmf_fwvid_ops brcmf_wcc_ops = {
-	.attach = brcmf_wcc_attach,
-	.detach = brcmf_wcc_detach,
 	.set_sae_password = brcmf_wcc_set_sae_pwd,
 };
-- 
2.32.0


--00000000000093530d060e4491c3
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAtr1TbPFUpovlA0WB2
R+fl2YwKJ0pWt1+ZhnC9ajFDJDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDAxMDYxMDM4NDNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAxScq98/1UBbv1HwXGCS5L2hsqVKCoeM5vHg/
Jkykt0md/9zP26+kjyZLxfQPCWglsif5G/T6+QoaxHs2HbNHctdJ1tTlhak2z6kOPRo102B3KnaE
h8JnOA8lfKK6YrsL/ydAm08EfyyYSQkSNr7TZL0kqfbj3MFOfa87doqIg8be5SnKZjQMxOT6HZon
HqJjfDmCiyUboMn4sJjPgarIWWB1Nb1j7cgMfQ4yZm2jiJXo37KykzB6RMFlFXqkKoEvmRQfLHgz
dVV/NOBlAIUL/kbccGBcw+y4oy5dnbywwBue1em43kTydEW0l0jlHmHoNT4UX0IUILG5JMtdbYuk
dg==
--00000000000093530d060e4491c3--

