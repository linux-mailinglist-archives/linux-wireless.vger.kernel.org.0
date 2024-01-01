Return-Path: <linux-wireless+bounces-1379-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C70821350
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jan 2024 09:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15DE1C210DC
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jan 2024 08:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47A84437;
	Mon,  1 Jan 2024 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LzWXzY5d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D4E3FEC
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jan 2024 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-428207fdcccso1000841cf.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jan 2024 00:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704098686; x=1704703486; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mV4JIvXpX547fmjrhmBgQnEy3mZEsU3qfm+Z89YsGu8=;
        b=LzWXzY5dFvGMWOWXsswjV2Limae8ytNH2rwwWUE7LBNS3SFPg+6haO7/Jhri0xbl2R
         3sE3LfnTZy5Iaz+Rq+uhehR1ZZ1KPkDraotq8mF1nhiGTrM1riSDzbVSWZIs0NTCeMEG
         KckezjgS9dreE/qVO3aH+ZKdAbfxbcMfz+2Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704098686; x=1704703486;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mV4JIvXpX547fmjrhmBgQnEy3mZEsU3qfm+Z89YsGu8=;
        b=WgR0EyFfJK9lfau9BFbTz4BKf9oxoUGRP4SWiWHoPnvVYBWsA1Hd8cBt2GyHP8+19+
         cMuN/tXuNSAlvz16gLytUkSat0sIDSBELokmCBl7geFRsw/saMDExmkJIXWNYCpFIs7e
         s3D2PK1cMeGxci4tNXDRtVzualInmtMEkvlEKSs2+Na7ScreaLCPmV1F5gaXB4/+7C5x
         3D7URx0SvpubEguVn1fn148guZSvGuv+TBClKcsIn0i5ulqCCRtgaoOPDEXbmLHoEDQv
         sosVW5S1ax77aMRBTR4KxAcZHyNyaUXmB9TTTqbQO6ct4a8nNft+9ryi8IQlmFt5FDS5
         JZdA==
X-Gm-Message-State: AOJu0Yzp9TzWbl0aKWU6IezqgsT43W5VBoU8XC+1nBMSCrHxCkuwTbLg
	QqZCAJgYFf+Lzp7zAYhqd6lAquPfeAY6
X-Google-Smtp-Source: AGHT+IHRK543uLKcnKLLYLMBeRksQJwidaj3bFHlpgGjCaIrsSnTDT2ZgGJWc63Zucyswdq0XfmZcA==
X-Received: by 2002:ac8:5b91:0:b0:427:f89b:89a5 with SMTP id a17-20020ac85b91000000b00427f89b89a5mr6210858qta.45.1704098685656;
        Mon, 01 Jan 2024 00:44:45 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id ey25-20020a05622a4c1900b00427fb1d6b44sm4186230qtb.5.2024.01.01.00.44.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jan 2024 00:44:44 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	Hector Martin <marcan@marcan.st>,
	Neal Gompa <neal@gompa.dev>,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 4/4] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
Date: Mon,  1 Jan 2024 09:44:30 +0100
Message-Id: <20240101084430.161821-5-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240101084430.161821-1-arend.vanspriel@broadcom.com>
References: <20240101084430.161821-1-arend.vanspriel@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d78193060dde647a"

--000000000000d78193060dde647a
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
[arend.vanspriel@broadcom.com: use multi-vendor framework]
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 56 ++++++++-----------
 .../broadcom/brcm80211/brcmfmac/cfg80211.h    |  2 +
 .../broadcom/brcm80211/brcmfmac/cyw/core.c    | 28 ++++++++++
 .../broadcom/brcm80211/brcmfmac/fwil.c        |  1 +
 .../broadcom/brcm80211/brcmfmac/fwil_types.h  |  2 +-
 .../broadcom/brcm80211/brcmfmac/fwvid.h       | 13 +++++
 .../broadcom/brcm80211/brcmfmac/wcc/core.c    |  9 +++
 7 files changed, 76 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 7a7c2a0e863e..ade1f9da5ae1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -32,6 +32,7 @@
 #include "vendor.h"
 #include "bus.h"
 #include "common.h"
+#include "fwvid.h"
 
 #define BRCMF_SCAN_IE_LEN_MAX		2048
 
@@ -1687,52 +1688,39 @@ static u16 brcmf_map_fw_linkdown_reason(const struct brcmf_event_msg *e)
 	return reason;
 }
 
-static int brcmf_set_pmk(struct brcmf_if *ifp, const u8 *pmk_data, u16 pmk_len)
+int brcmf_set_wsec(struct brcmf_if *ifp, const u8 *key, u16 key_len, u16 flags)
 {
 	struct brcmf_pub *drvr = ifp->drvr;
 	struct brcmf_wsec_pmk_le pmk;
 	int err;
 
+	if (key_len > sizeof(pmk.key)) {
+		bphy_err(drvr, "key must be less than %zu bytes\n",
+			 sizeof(pmk.key));
+		return -EINVAL;
+	}
+
 	memset(&pmk, 0, sizeof(pmk));
 
-	/* pass pmk directly */
-	pmk.key_len = cpu_to_le16(pmk_len);
-	pmk.flags = cpu_to_le16(0);
-	memcpy(pmk.key, pmk_data, pmk_len);
+	/* pass key material directly */
+	pmk.key_len = cpu_to_le16(key_len);
+	pmk.flags = cpu_to_le16(flags);
+	memcpy(pmk.key, key, key_len);
 
-	/* store psk in firmware */
+	/* store key material in firmware */
 	err = brcmf_fil_cmd_data_set(ifp, BRCMF_C_SET_WSEC_PMK,
 				     &pmk, sizeof(pmk));
 	if (err < 0)
 		bphy_err(drvr, "failed to change PSK in firmware (len=%u)\n",
-			 pmk_len);
+			 key_len);
 
 	return err;
 }
+BRCMF_EXPORT_SYMBOL_GPL(brcmf_set_wsec);
 
-static int brcmf_set_sae_password(struct brcmf_if *ifp, const u8 *pwd_data,
-				  u16 pwd_len)
+static int brcmf_set_pmk(struct brcmf_if *ifp, const u8 *pmk_data, u16 pmk_len)
 {
-	struct brcmf_pub *drvr = ifp->drvr;
-	struct brcmf_wsec_sae_pwd_le sae_pwd;
-	int err;
-
-	if (pwd_len > BRCMF_WSEC_MAX_SAE_PASSWORD_LEN) {
-		bphy_err(drvr, "sae_password must be less than %d\n",
-			 BRCMF_WSEC_MAX_SAE_PASSWORD_LEN);
-		return -EINVAL;
-	}
-
-	sae_pwd.key_len = cpu_to_le16(pwd_len);
-	memcpy(sae_pwd.key, pwd_data, pwd_len);
-
-	err = brcmf_fil_iovar_data_set(ifp, "sae_password", &sae_pwd,
-				       sizeof(sae_pwd));
-	if (err < 0)
-		bphy_err(drvr, "failed to set SAE password in firmware (len=%u)\n",
-			 pwd_len);
-
-	return err;
+	return brcmf_set_wsec(ifp, pmk_data, pmk_len, 0);
 }
 
 static void brcmf_link_down(struct brcmf_cfg80211_vif *vif, u16 reason,
@@ -2503,8 +2491,7 @@ brcmf_cfg80211_connect(struct wiphy *wiphy, struct net_device *ndev,
 			bphy_err(drvr, "failed to clean up user-space RSNE\n");
 			goto done;
 		}
-		err = brcmf_set_sae_password(ifp, sme->crypto.sae_pwd,
-					     sme->crypto.sae_pwd_len);
+		err = brcmf_fwvid_set_sae_password(ifp, &sme->crypto);
 		if (!err && sme->crypto.psk)
 			err = brcmf_set_pmk(ifp, sme->crypto.psk,
 					    BRCMF_WSEC_MAX_PSK_LEN);
@@ -5252,8 +5239,7 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 		if (crypto->sae_pwd) {
 			brcmf_dbg(INFO, "using SAE offload\n");
 			profile->use_fwauth |= BIT(BRCMF_PROFILE_FWAUTH_SAE);
-			err = brcmf_set_sae_password(ifp, crypto->sae_pwd,
-						     crypto->sae_pwd_len);
+			err = brcmf_fwvid_set_sae_password(ifp, crypto);
 			if (err < 0)
 				goto exit;
 		}
@@ -5360,10 +5346,12 @@ static int brcmf_cfg80211_stop_ap(struct wiphy *wiphy, struct net_device *ndev,
 		msleep(400);
 
 		if (profile->use_fwauth != BIT(BRCMF_PROFILE_FWAUTH_NONE)) {
+			struct cfg80211_crypto_settings crypto = {};
+
 			if (profile->use_fwauth & BIT(BRCMF_PROFILE_FWAUTH_PSK))
 				brcmf_set_pmk(ifp, NULL, 0);
 			if (profile->use_fwauth & BIT(BRCMF_PROFILE_FWAUTH_SAE))
-				brcmf_set_sae_password(ifp, NULL, 0);
+				brcmf_fwvid_set_sae_password(ifp, &crypto);
 			profile->use_fwauth = BIT(BRCMF_PROFILE_FWAUTH_NONE);
 		}
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
index 0e1fa3f0dea2..dc3a6a537507 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
@@ -468,4 +468,6 @@ void brcmf_set_mpc(struct brcmf_if *ndev, int mpc);
 void brcmf_abort_scanning(struct brcmf_cfg80211_info *cfg);
 void brcmf_cfg80211_free_netdev(struct net_device *ndev);
 
+int brcmf_set_wsec(struct brcmf_if *ifp, const u8 *key, u16 key_len, u16 flags);
+
 #endif /* BRCMFMAC_CFG80211_H */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
index b75652ba9359..24670497f1a4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
@@ -7,6 +7,7 @@
 #include <core.h>
 #include <bus.h>
 #include <fwvid.h>
+#include <fwil.h>
 
 #include "vops.h"
 
@@ -21,7 +22,34 @@ static void brcmf_cyw_detach(struct brcmf_pub *drvr)
 	pr_err("%s: executing\n", __func__);
 }
 
+static int brcmf_cyw_set_sae_pwd(struct brcmf_if *ifp,
+				 struct cfg80211_crypto_settings *crypto)
+{
+	struct brcmf_pub *drvr = ifp->drvr;
+	struct brcmf_wsec_sae_pwd_le sae_pwd;
+	u16 pwd_len = crypto->sae_pwd_len;
+	int err;
+
+	if (pwd_len > BRCMF_WSEC_MAX_SAE_PASSWORD_LEN) {
+		bphy_err(drvr, "sae_password must be less than %d\n",
+			 BRCMF_WSEC_MAX_SAE_PASSWORD_LEN);
+		return -EINVAL;
+	}
+
+	sae_pwd.key_len = cpu_to_le16(pwd_len);
+	memcpy(sae_pwd.key, crypto->sae_pwd, pwd_len);
+
+	err = brcmf_fil_iovar_data_set(ifp, "sae_password", &sae_pwd,
+				       sizeof(sae_pwd));
+	if (err < 0)
+		bphy_err(drvr, "failed to set SAE password in firmware (len=%u)\n",
+			 pwd_len);
+
+	return err;
+}
+
 const struct brcmf_fwvid_ops brcmf_cyw_ops = {
 	.attach = brcmf_cyw_attach,
 	.detach = brcmf_cyw_detach,
+	.set_sae_password = brcmf_cyw_set_sae_pwd,
 };
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c
index 2aec7d2abd52..bc1c6b5a6e31 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c
@@ -211,6 +211,7 @@ brcmf_fil_iovar_data_set(struct brcmf_if *ifp, const char *name, const void *dat
 	mutex_unlock(&drvr->proto_block);
 	return err;
 }
+BRCMF_EXPORT_SYMBOL_GPL(brcmf_fil_iovar_data_set);
 
 s32
 brcmf_fil_iovar_data_get(struct brcmf_if *ifp, const char *name, void *data,
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
index 17fbdbb76f51..d9fc76b46db9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
@@ -6,6 +6,7 @@
 #define FWVID_H_
 
 #include "firmware.h"
+#include "cfg80211.h"
 
 struct brcmf_pub;
 struct brcmf_if;
@@ -14,6 +15,7 @@ struct brcmf_fwvid_ops {
 	int (*attach)(struct brcmf_pub *drvr);
 	void (*detach)(struct brcmf_pub *drvr);
 	void (*feat_attach)(struct brcmf_if *ifp);
+	int (*set_sae_password)(struct brcmf_if *ifp, struct cfg80211_crypto_settings *crypto);
 };
 
 /* exported functions */
@@ -56,4 +58,15 @@ static inline void brcmf_fwvid_feat_attach(struct brcmf_if *ifp)
 	vops->feat_attach(ifp);
 }
 
+static inline int brcmf_fwvid_set_sae_password(struct brcmf_if *ifp,
+					       struct cfg80211_crypto_settings *crypto)
+{
+	const struct brcmf_fwvid_ops *vops = ifp->drvr->vops;
+
+	if (!vops || !vops->set_sae_password)
+		return -EOPNOTSUPP;
+
+	return vops->set_sae_password(ifp, crypto);
+}
+
 #endif /* FWVID_H_ */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
index 5573a47766ad..2d8f80bd7382 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
@@ -7,6 +7,7 @@
 #include <core.h>
 #include <bus.h>
 #include <fwvid.h>
+#include <fwil.h>
 
 #include "vops.h"
 
@@ -21,7 +22,15 @@ static void brcmf_wcc_detach(struct brcmf_pub *drvr)
 	pr_debug("%s: executing\n", __func__);
 }
 
+static int brcmf_wcc_set_sae_pwd(struct brcmf_if *ifp,
+				 struct cfg80211_crypto_settings *crypto)
+{
+	return brcmf_set_wsec(ifp, crypto->sae_pwd, crypto->sae_pwd_len,
+			      BRCMF_WSEC_PASSPHRASE);
+}
+
 const struct brcmf_fwvid_ops brcmf_wcc_ops = {
 	.attach = brcmf_wcc_attach,
 	.detach = brcmf_wcc_detach,
+	.set_sae_password = brcmf_wcc_set_sae_pwd,
 };
-- 
2.32.0


--000000000000d78193060dde647a
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCD2SwrGoST1mmxR/txd
lyKiMG87Bh7iAPplaphqCrA4oTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDAxMDEwODQ0NDZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEALzfltN66SlJz5zXsv38lkjlUvW8xYe5Igzdv
lL1A6DkZduxljgqJ6/ywnPhnDidvl4R4SZorEs3KzDaFYhbMPOS4b0iqa1U6ob6RY7BqVBFULG60
tepnCkIfcsHiKJdKifNM9vf98XZW+s4+nHb0K+8EtCkCKmMY2cSlB9Gn6pKsi+fIgpICNviWi3f9
KpLd7Z8HwOJeV1GScgwtyVh5DwqAS86flYPOiY8ozr9+P025cFstItK9St7ISvuSj1ry7MZJLoXX
RJCJmAXBiUWBFQI8jOkgvfmd4SwfXMs5QGkrzR3eBNG8rRcduzJE/7QoD1fWO7u3OGhIp+5uQI3z
4w==
--000000000000d78193060dde647a--

