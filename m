Return-Path: <linux-wireless+bounces-1145-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9926081B940
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 15:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D411CB2921D
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 14:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761AC6D6EF;
	Thu, 21 Dec 2023 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S1o1iVol"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D68736084
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 14:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33666946422so688921f8f.1
        for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 06:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703167461; x=1703772261; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UMTZwPtJGlCp8K8G/vUAt5DHeRB1YS9+IBF5P9XtlvU=;
        b=S1o1iVolU1HK7dv/CHSKwZ/TseOiNAJWKoQGml4VP5WXUP5M6m5jL+VeFy88I+a6Q/
         /tbAT+bNN3K7wLKTXl5ucSgf3UEUIrUmJVmOKznCesqyxHDEaNQlA/2Eu2yfR+AEp/no
         0ZLgmrrgTept+99eEKB2ENqMAS8HpVnAdK6wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703167461; x=1703772261;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMTZwPtJGlCp8K8G/vUAt5DHeRB1YS9+IBF5P9XtlvU=;
        b=f+tSZ9mP78dHnMHfd0Cevehy+aElxOcbn2v1Xt0hvIAZPoBthf6ADHT5Qz5oCJiSEW
         4SjTWGo1P+XHf/+PCPeeCHhSeIZafCaguPuARBhAxdzM2sfppnUB1WpVDFrdIS5hZ9S0
         I+fxAwV6BzA1jaH4+l365KPEL0mzoPOFF2Sydi5xhdMC0uy/R92VC+7THh9dvkMFmEkI
         dKvjMeEGDWwttEyUTZMxUL4SDWwuk5KOlRc+enFxBmgnDNtxRizSTjMsLcC96fnEviTI
         eNHvSaR+W41nhfVl+o2ryqZJwbMAlYgHPodke79Obv40d/gt0ztFgxNa0QSTTo7ZGMMg
         XGFQ==
X-Gm-Message-State: AOJu0Yzk55lMWZHBMGuiepmirfGloYzvG9LEBQ9gv38bq3qUSsKTjuL0
	1AcZI0lOzQr8YWH/caKh2CT8IA==
X-Google-Smtp-Source: AGHT+IEHZCaHv23/4k+9bHxjcb7GTDkN2ISruOhv1y89820+k0HSMvOcRZULkz1xd4RB3zdLiHrLVA==
X-Received: by 2002:a5d:63cb:0:b0:333:2fd2:8146 with SMTP id c11-20020a5d63cb000000b003332fd28146mr896505wrw.99.1703167461285;
        Thu, 21 Dec 2023 06:04:21 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id w11-20020adfcd0b000000b003367e35abd4sm2117531wrm.71.2023.12.21.06.04.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Dec 2023 06:04:20 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	Hector Martin <marcan@marcan.st>,
	Neal Gompa <neal@gompa.dev>,
	=?UTF-8?q?Pawe=C5=82=20Drewniak?= <czajernia@gmail.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
Date: Thu, 21 Dec 2023 15:04:16 +0100
Message-Id: <20231221140416.223639-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
References: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008c201c060d059320"

--0000000000008c201c060d059320
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Hector Martin <marcan@marcan.st>

Using the WSEC command instead of sae_password seems to be the supported
mechanism on newer firmware, and also how the brcmdhd driver does it.

According to user reports [1], the sae_password codepath doesn't actually
work on machines with Cypress chips anyway, so no harm in removing it.

This makes WPA3 work with iwd, or with wpa_supplicant pending a support
patchset [2].

[1] https://rachelbythebay.com/w/2023/11/06/wpa3/
[2] http://lists.infradead.org/pipermail/hostap/2023-July/041653.html

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Paweł Drewniak <czajernia@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
[arend.vanspriel@broadcom.com: use multi-vendor framework]
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
Here is how the multi-vendor code could support both Cypress and
WCC mobility chips. As said it might be easier to just override
entire cfg80211 callback operations.

Regards,
Arend
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 13 +++++++---
 .../broadcom/brcm80211/brcmfmac/cfg80211.h    |  3 +++
 .../broadcom/brcm80211/brcmfmac/fwil.c        |  1 +
 .../broadcom/brcm80211/brcmfmac/fwil_types.h  |  2 +-
 .../broadcom/brcm80211/brcmfmac/fwvid.h       | 14 ++++++++++
 .../broadcom/brcm80211/brcmfmac/wcc/core.c    | 26 +++++++++++++++++++
 6 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 133c5ea6429c..989d0f3d4b3b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -32,6 +32,7 @@
 #include "vendor.h"
 #include "bus.h"
 #include "common.h"
+#include "fwvid.h"
 
 #define BRCMF_SCAN_IE_LEN_MAX		2048
 
@@ -1693,6 +1694,12 @@ static int brcmf_set_pmk(struct brcmf_if *ifp, const u8 *pmk_data, u16 pmk_len)
 	struct brcmf_wsec_pmk_le pmk;
 	int err;
 
+	if (pmk_len > sizeof(pmk.key)) {
+		bphy_err(drvr, "key must be less than %zu bytes\n",
+			 sizeof(pmk.key));
+		return -EINVAL;
+	}
+
 	memset(&pmk, 0, sizeof(pmk));
 
 	/* pass pmk directly */
@@ -1710,7 +1717,7 @@ static int brcmf_set_pmk(struct brcmf_if *ifp, const u8 *pmk_data, u16 pmk_len)
 	return err;
 }
 
-static int brcmf_set_sae_password(struct brcmf_if *ifp, const u8 *pwd_data,
+int brcmf_set_sae_password(struct brcmf_if *ifp, const u8 *pwd_data,
 				  u16 pwd_len)
 {
 	struct brcmf_pub *drvr = ifp->drvr;
@@ -1734,6 +1741,7 @@ static int brcmf_set_sae_password(struct brcmf_if *ifp, const u8 *pwd_data,
 
 	return err;
 }
+BRCMF_EXPORT_SYMBOL_GPL(brcmf_set_sae_password);
 
 static void brcmf_link_down(struct brcmf_cfg80211_vif *vif, u16 reason,
 			    bool locally_generated)
@@ -2503,8 +2511,7 @@ brcmf_cfg80211_connect(struct wiphy *wiphy, struct net_device *ndev,
 			bphy_err(drvr, "failed to clean up user-space RSNE\n");
 			goto done;
 		}
-		err = brcmf_set_sae_password(ifp, sme->crypto.sae_pwd,
-					     sme->crypto.sae_pwd_len);
+		err = brcmf_fwvid_set_sae_password(ifp, &sme->crypto);
 		if (!err && sme->crypto.psk)
 			err = brcmf_set_pmk(ifp, sme->crypto.psk,
 					    BRCMF_WSEC_MAX_PSK_LEN);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
index 0e1fa3f0dea2..7c08e545e73f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
@@ -468,4 +468,7 @@ void brcmf_set_mpc(struct brcmf_if *ndev, int mpc);
 void brcmf_abort_scanning(struct brcmf_cfg80211_info *cfg);
 void brcmf_cfg80211_free_netdev(struct net_device *ndev);
 
+int brcmf_set_sae_password(struct brcmf_if *ifp, const u8 *pwd_data,
+			   u16 pwd_len);
+
 #endif /* BRCMFMAC_CFG80211_H */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c
index 72fe8bce6eaf..65604477ad2f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c
@@ -142,6 +142,7 @@ brcmf_fil_cmd_data_set(struct brcmf_if *ifp, u32 cmd, void *data, u32 len)
 
 	return err;
 }
+BRCMF_EXPORT_SYMBOL_GPL(brcmf_fil_cmd_data_set);
 
 s32
 brcmf_fil_cmd_data_get(struct brcmf_if *ifp, u32 cmd, void *data, u32 len)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
index 9d248ba1c0b2..e74a23e11830 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
@@ -584,7 +584,7 @@ struct brcmf_wsec_key_le {
 struct brcmf_wsec_pmk_le {
 	__le16  key_len;
 	__le16  flags;
-	u8 key[2 * BRCMF_WSEC_MAX_PSK_LEN + 1];
+	u8 key[BRCMF_WSEC_MAX_SAE_PASSWORD_LEN];
 };
 
 /**
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
index 43df58bb70ad..6fb3b8fc398a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
@@ -6,12 +6,15 @@
 #define FWVID_H_
 
 #include "firmware.h"
+#include "cfg80211.h"
 
 struct brcmf_pub;
+struct brcmf_if;
 
 struct brcmf_fwvid_ops {
 	int (*attach)(struct brcmf_pub *drvr);
 	void (*detach)(struct brcmf_pub *drvr);
+	int (*set_sae_password)(struct brcmf_if *ifp, struct cfg80211_crypto_settings *crypto);
 };
 
 /* exported functions */
@@ -44,4 +47,15 @@ static inline void brcmf_fwvid_detach(struct brcmf_pub *drvr)
 	brcmf_fwvid_detach_ops(drvr);
 }
 
+static inline int brcmf_fwvid_set_sae_password(struct brcmf_if *ifp,
+					       struct cfg80211_crypto_settings *crypto)
+{
+	const struct brcmf_fwvid_ops *vops = ifp->drvr->vops;
+
+	if (!vops || !vops->set_sae_password)
+		return brcmf_set_sae_password(ifp, crypto->sae_pwd, crypto->sae_pwd_len);
+
+	return vops->set_sae_password(ifp, crypto);
+}
+
 #endif /* FWVID_H_ */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
index 5573a47766ad..01025d5c137b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
@@ -7,6 +7,7 @@
 #include <core.h>
 #include <bus.h>
 #include <fwvid.h>
+#include <fwil.h>
 
 #include "vops.h"
 
@@ -21,7 +22,32 @@ static void brcmf_wcc_detach(struct brcmf_pub *drvr)
 	pr_debug("%s: executing\n", __func__);
 }
 
+static int brcmf_wcc_set_sae_pwd(struct brcmf_if *ifp,
+				 struct cfg80211_crypto_settings *crypto)
+{
+	struct brcmf_pub *drvr = ifp->drvr;
+	struct brcmf_wsec_pmk_le pmk;
+	int err;
+
+	memset(&pmk, 0, sizeof(pmk));
+
+	/* pass pmk directly */
+	pmk.key_len = cpu_to_le16(crypto->sae_pwd_len);
+	pmk.flags = cpu_to_le16(BRCMF_WSEC_PASSPHRASE);
+	memcpy(pmk.key, crypto->sae_pwd, crypto->sae_pwd_len);
+
+	/* store psk in firmware */
+	err = brcmf_fil_cmd_data_set(ifp, BRCMF_C_SET_WSEC_PMK,
+				     &pmk, sizeof(pmk));
+	if (err < 0)
+		bphy_err(drvr, "failed to change PSK in firmware (len=%u)\n",
+			 crypto->sae_pwd_len);
+
+	return err;
+}
+
 const struct brcmf_fwvid_ops brcmf_wcc_ops = {
 	.attach = brcmf_wcc_attach,
 	.detach = brcmf_wcc_detach,
+	.set_sae_password = brcmf_wcc_set_sae_pwd,
 };
-- 
2.32.0


--0000000000008c201c060d059320
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAEhY3sFZMfHgLUBodj
Rh6Z+Lw1UI3uV9wU2X3NTmcwlTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzEyMjExNDA0MjFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAhMviCUPF4HdfrVUS3F2pkSIjU7miGd9TdbY2
M3np5ZmZkSV5xCt5xaJ5s0oWOsvGtdwUrkrXV80c9COjG/eFpK3yYljjYwkVEaXPUfQIf88Pmm6N
mFIoq9oSTM7yn23tI9T81S/lHxafGJBc3/kxAotsXx6JKr33312Xn6nixwJmXiwnEcN/f/yYdz3X
HgZDVxAAWP4g665E4iYxUGQ1M1Xux0oWdjP0Qv/IRHJ+xIcTjnUa12ysVvospkVH7HG6ijG61grt
+HvrWRwkWk1tQy8hL8+jIxBWqLAZXBzchdDhAxhesX8WKP+1JrgM/0bQ35kyTs9wMHS1lT2ydF4F
oA==
--0000000000008c201c060d059320--

