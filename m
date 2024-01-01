Return-Path: <linux-wireless+bounces-1376-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 910B882134D
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jan 2024 09:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1D72B21E84
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jan 2024 08:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA7A1FD8;
	Mon,  1 Jan 2024 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VpEPoW8w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2175F184E
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jan 2024 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42782601608so43908371cf.2
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jan 2024 00:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704098679; x=1704703479; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4jcMtwaI/5jhgHBoQhSxTBsqEuBOW8B4wSOtHfwfCLc=;
        b=VpEPoW8wUt2LkrYQzi5RtlDOkIzrhZKw2+VjygX/m6chZimcLdQ5wIZ6+xOclbpEaZ
         b527kgCk4vN4HqiEFfeea9IK3N8qZKong/W4sX+PW9IGUEHD5AjcJDxJu8NUSmNqXxSW
         SAfjz3vjm+miE3YIifBvE4gAjuI+VRfBUHlGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704098679; x=1704703479;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4jcMtwaI/5jhgHBoQhSxTBsqEuBOW8B4wSOtHfwfCLc=;
        b=bNhpE0CmChDTczZoll8A3IbZXbHdIG4PfPWh0Ct9+JijdGL/WMzpjmp5W3zSTusTmm
         w9sK0ohZPRqNkVDO6hzeS/mhhH3dq38F2Wbs3wsLh18uurGImblzMIr2RBhNV/Eyt0Hx
         79e8nA+o2dIHt1hLAT4GBapySMBObnGswKZHxzN0brYf0Eh/hIouMuYiLTtnDA5zZCSb
         7OOg0q1ms4iscdqFQNZu+WljhUqkQh1ZaWVqs6xqDcJEv8VWQQaddQMNtnTLbIsoFBJ5
         njeX0X8xbbOsOfZ2Hn48dvVqh80GHF9OiLHe1imxyQAwG+Za0CTxyzDo0KXkL5hd9ktw
         c+nw==
X-Gm-Message-State: AOJu0YyTgOXaHIgHL/KN+V6yOe3zH/zsc3Ppjg16s1Vyw1XNGwm7OzxR
	/NaY+NAHDxxEPwJkdlKYpJnbh3erIj/J
X-Google-Smtp-Source: AGHT+IFqb52hjwK8jOPWVtWwTMTRa4Vtz3+54p3pKoUmd8tvZG1lwLjMPz89fAD0r+rVEdh00VKIsQ==
X-Received: by 2002:a05:622a:3ce:b0:427:8e47:9662 with SMTP id k14-20020a05622a03ce00b004278e479662mr14901965qtx.130.1704098678898;
        Mon, 01 Jan 2024 00:44:38 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id ey25-20020a05622a4c1900b00427fb1d6b44sm4186230qtb.5.2024.01.01.00.44.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jan 2024 00:44:37 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 1/4] wifi: brcmfmac: export firmware interface functions
Date: Mon,  1 Jan 2024 09:44:27 +0100
Message-Id: <20240101084430.161821-2-arend.vanspriel@broadcom.com>
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
	boundary="000000000000708530060dde64d1"

--000000000000708530060dde64d1
Content-Transfer-Encoding: 8bit

With multi-vendor support the vendor-specific module may need to use
the firmware interface functions so export them using the macro
BRCMF_EXPORT_SYMBOL_GPL() which exports them to driver namespace.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |   2 +-
 .../broadcom/brcm80211/brcmfmac/core.c        |   2 +-
 .../broadcom/brcm80211/brcmfmac/feature.c     |   2 +-
 .../broadcom/brcm80211/brcmfmac/fwil.c        | 115 +---------------
 .../broadcom/brcm80211/brcmfmac/fwil.h        | 127 +++++++++++++++---
 5 files changed, 120 insertions(+), 128 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 133c5ea6429c..7a7c2a0e863e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -7269,7 +7269,7 @@ static int brcmf_setup_wiphybands(struct brcmf_cfg80211_info *cfg)
 	u32 nmode = 0;
 	u32 vhtmode = 0;
 	u32 bw_cap[2] = { WLC_BW_20MHZ_BIT, WLC_BW_20MHZ_BIT };
-	u32 rxchain;
+	u32 rxchain = 0;
 	u32 nchain;
 	int err;
 	s32 i;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index f599d5f896e8..a92f78026cfd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -691,7 +691,7 @@ static int brcmf_net_mon_open(struct net_device *ndev)
 {
 	struct brcmf_if *ifp = netdev_priv(ndev);
 	struct brcmf_pub *drvr = ifp->drvr;
-	u32 monitor;
+	u32 monitor = 0;
 	int err;
 
 	brcmf_dbg(TRACE, "Enter\n");
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
index 6d10c9efbe93..7348f73680d6 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
@@ -183,7 +183,7 @@ static void brcmf_feat_wlc_version_overrides(struct brcmf_pub *drv)
 static void brcmf_feat_iovar_int_get(struct brcmf_if *ifp,
 				     enum brcmf_feat_id id, char *name)
 {
-	u32 data;
+	u32 data = 0;
 	int err;
 
 	/* we need to know firmware error */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c
index 72fe8bce6eaf..2aec7d2abd52 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c
@@ -142,6 +142,7 @@ brcmf_fil_cmd_data_set(struct brcmf_if *ifp, u32 cmd, void *data, u32 len)
 
 	return err;
 }
+BRCMF_EXPORT_SYMBOL_GPL(brcmf_fil_cmd_data_set);
 
 s32
 brcmf_fil_cmd_data_get(struct brcmf_if *ifp, u32 cmd, void *data, u32 len)
@@ -160,36 +161,7 @@ brcmf_fil_cmd_data_get(struct brcmf_if *ifp, u32 cmd, void *data, u32 len)
 
 	return err;
 }
-
-
-s32
-brcmf_fil_cmd_int_set(struct brcmf_if *ifp, u32 cmd, u32 data)
-{
-	s32 err;
-	__le32 data_le = cpu_to_le32(data);
-
-	mutex_lock(&ifp->drvr->proto_block);
-	brcmf_dbg(FIL, "ifidx=%d, cmd=%d, value=%d\n", ifp->ifidx, cmd, data);
-	err = brcmf_fil_cmd_data(ifp, cmd, &data_le, sizeof(data_le), true);
-	mutex_unlock(&ifp->drvr->proto_block);
-
-	return err;
-}
-
-s32
-brcmf_fil_cmd_int_get(struct brcmf_if *ifp, u32 cmd, u32 *data)
-{
-	s32 err;
-	__le32 data_le = cpu_to_le32(*data);
-
-	mutex_lock(&ifp->drvr->proto_block);
-	err = brcmf_fil_cmd_data(ifp, cmd, &data_le, sizeof(data_le), false);
-	mutex_unlock(&ifp->drvr->proto_block);
-	*data = le32_to_cpu(data_le);
-	brcmf_dbg(FIL, "ifidx=%d, cmd=%d, value=%d\n", ifp->ifidx, cmd, *data);
-
-	return err;
-}
+BRCMF_EXPORT_SYMBOL_GPL(brcmf_fil_cmd_data_get);
 
 static u32
 brcmf_create_iovar(const char *name, const char *data, u32 datalen,
@@ -270,26 +242,7 @@ brcmf_fil_iovar_data_get(struct brcmf_if *ifp, const char *name, void *data,
 	mutex_unlock(&drvr->proto_block);
 	return err;
 }
-
-s32
-brcmf_fil_iovar_int_set(struct brcmf_if *ifp, const char *name, u32 data)
-{
-	__le32 data_le = cpu_to_le32(data);
-
-	return brcmf_fil_iovar_data_set(ifp, name, &data_le, sizeof(data_le));
-}
-
-s32
-brcmf_fil_iovar_int_get(struct brcmf_if *ifp, const char *name, u32 *data)
-{
-	__le32 data_le = cpu_to_le32(*data);
-	s32 err;
-
-	err = brcmf_fil_iovar_data_get(ifp, name, &data_le, sizeof(data_le));
-	if (err == 0)
-		*data = le32_to_cpu(data_le);
-	return err;
-}
+BRCMF_EXPORT_SYMBOL_GPL(brcmf_fil_iovar_data_get);
 
 static u32
 brcmf_create_bsscfg(s32 bsscfgidx, const char *name, char *data, u32 datalen,
@@ -364,6 +317,7 @@ brcmf_fil_bsscfg_data_set(struct brcmf_if *ifp, const char *name,
 	mutex_unlock(&drvr->proto_block);
 	return err;
 }
+BRCMF_EXPORT_SYMBOL_GPL(brcmf_fil_bsscfg_data_set);
 
 s32
 brcmf_fil_bsscfg_data_get(struct brcmf_if *ifp, const char *name,
@@ -394,28 +348,7 @@ brcmf_fil_bsscfg_data_get(struct brcmf_if *ifp, const char *name,
 	mutex_unlock(&drvr->proto_block);
 	return err;
 }
-
-s32
-brcmf_fil_bsscfg_int_set(struct brcmf_if *ifp, const char *name, u32 data)
-{
-	__le32 data_le = cpu_to_le32(data);
-
-	return brcmf_fil_bsscfg_data_set(ifp, name, &data_le,
-					 sizeof(data_le));
-}
-
-s32
-brcmf_fil_bsscfg_int_get(struct brcmf_if *ifp, const char *name, u32 *data)
-{
-	__le32 data_le = cpu_to_le32(*data);
-	s32 err;
-
-	err = brcmf_fil_bsscfg_data_get(ifp, name, &data_le,
-					sizeof(data_le));
-	if (err == 0)
-		*data = le32_to_cpu(data_le);
-	return err;
-}
+BRCMF_EXPORT_SYMBOL_GPL(brcmf_fil_bsscfg_data_get);
 
 static u32 brcmf_create_xtlv(const char *name, u16 id, char *data, u32 len,
 			     char *buf, u32 buflen)
@@ -465,6 +398,7 @@ s32 brcmf_fil_xtlv_data_set(struct brcmf_if *ifp, const char *name, u16 id,
 	mutex_unlock(&drvr->proto_block);
 	return err;
 }
+BRCMF_EXPORT_SYMBOL_GPL(brcmf_fil_xtlv_data_set);
 
 s32 brcmf_fil_xtlv_data_get(struct brcmf_if *ifp, const char *name, u16 id,
 			    void *data, u32 len)
@@ -494,39 +428,4 @@ s32 brcmf_fil_xtlv_data_get(struct brcmf_if *ifp, const char *name, u16 id,
 	mutex_unlock(&drvr->proto_block);
 	return err;
 }
-
-s32 brcmf_fil_xtlv_int_set(struct brcmf_if *ifp, const char *name, u16 id, u32 data)
-{
-	__le32 data_le = cpu_to_le32(data);
-
-	return brcmf_fil_xtlv_data_set(ifp, name, id, &data_le,
-					 sizeof(data_le));
-}
-
-s32 brcmf_fil_xtlv_int_get(struct brcmf_if *ifp, const char *name, u16 id, u32 *data)
-{
-	__le32 data_le = cpu_to_le32(*data);
-	s32 err;
-
-	err = brcmf_fil_xtlv_data_get(ifp, name, id, &data_le, sizeof(data_le));
-	if (err == 0)
-		*data = le32_to_cpu(data_le);
-	return err;
-}
-
-s32 brcmf_fil_xtlv_int8_get(struct brcmf_if *ifp, const char *name, u16 id, u8 *data)
-{
-	return brcmf_fil_xtlv_data_get(ifp, name, id, data, sizeof(*data));
-}
-
-s32 brcmf_fil_xtlv_int16_get(struct brcmf_if *ifp, const char *name, u16 id, u16 *data)
-{
-	__le16 data_le = cpu_to_le16(*data);
-	s32 err;
-
-	err = brcmf_fil_xtlv_data_get(ifp, name, id, &data_le, sizeof(data_le));
-	if (err == 0)
-		*data = le16_to_cpu(data_le);
-	return err;
-}
-
+BRCMF_EXPORT_SYMBOL_GPL(brcmf_fil_xtlv_data_get);
\ No newline at end of file
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h
index bc693157c4b1..a315a7fac6a0 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h
@@ -81,29 +81,122 @@
 
 s32 brcmf_fil_cmd_data_set(struct brcmf_if *ifp, u32 cmd, void *data, u32 len);
 s32 brcmf_fil_cmd_data_get(struct brcmf_if *ifp, u32 cmd, void *data, u32 len);
-s32 brcmf_fil_cmd_int_set(struct brcmf_if *ifp, u32 cmd, u32 data);
-s32 brcmf_fil_cmd_int_get(struct brcmf_if *ifp, u32 cmd, u32 *data);
+static inline
+s32 brcmf_fil_cmd_int_set(struct brcmf_if *ifp, u32 cmd, u32 data)
+{
+	s32 err;
+	__le32 data_le = cpu_to_le32(data);
 
-s32 brcmf_fil_iovar_data_set(struct brcmf_if *ifp, const char *name, const void *data,
-			     u32 len);
+	brcmf_dbg(FIL, "ifidx=%d, cmd=%d, value=%d\n", ifp->ifidx, cmd, data);
+	err = brcmf_fil_cmd_data_set(ifp, cmd, &data_le, sizeof(data_le));
+
+	return err;
+}
+static inline
+s32 brcmf_fil_cmd_int_get(struct brcmf_if *ifp, u32 cmd, u32 *data)
+{
+	s32 err;
+	__le32 data_le = cpu_to_le32(*data);
+
+	err = brcmf_fil_cmd_data_get(ifp, cmd, &data_le, sizeof(data_le));
+	if (err == 0)
+		*data = le32_to_cpu(data_le);
+	brcmf_dbg(FIL, "ifidx=%d, cmd=%d, value=%d\n", ifp->ifidx, cmd, *data);
+
+	return err;
+}
+
+s32 brcmf_fil_iovar_data_set(struct brcmf_if *ifp, const char *name,
+			     const void *data, u32 len);
 s32 brcmf_fil_iovar_data_get(struct brcmf_if *ifp, const char *name, void *data,
 			     u32 len);
-s32 brcmf_fil_iovar_int_set(struct brcmf_if *ifp, const char *name, u32 data);
-s32 brcmf_fil_iovar_int_get(struct brcmf_if *ifp, const char *name, u32 *data);
-
-s32 brcmf_fil_bsscfg_data_set(struct brcmf_if *ifp, const char *name, void *data,
-			      u32 len);
-s32 brcmf_fil_bsscfg_data_get(struct brcmf_if *ifp, const char *name, void *data,
-			      u32 len);
-s32 brcmf_fil_bsscfg_int_set(struct brcmf_if *ifp, const char *name, u32 data);
-s32 brcmf_fil_bsscfg_int_get(struct brcmf_if *ifp, const char *name, u32 *data);
+static inline
+s32 brcmf_fil_iovar_int_set(struct brcmf_if *ifp, const char *name, u32 data)
+{
+	__le32 data_le = cpu_to_le32(data);
+
+	return brcmf_fil_iovar_data_set(ifp, name, &data_le, sizeof(data_le));
+}
+static inline
+s32 brcmf_fil_iovar_int_get(struct brcmf_if *ifp, const char *name, u32 *data)
+{
+	__le32 data_le = cpu_to_le32(*data);
+	s32 err;
+
+	err = brcmf_fil_iovar_data_get(ifp, name, &data_le, sizeof(data_le));
+	if (err == 0)
+		*data = le32_to_cpu(data_le);
+	return err;
+}
+
+
+s32 brcmf_fil_bsscfg_data_set(struct brcmf_if *ifp, const char *name,
+			      void *data, u32 len);
+s32 brcmf_fil_bsscfg_data_get(struct brcmf_if *ifp, const char *name,
+			      void *data, u32 len);
+static inline
+s32 brcmf_fil_bsscfg_int_set(struct brcmf_if *ifp, const char *name, u32 data)
+{
+	__le32 data_le = cpu_to_le32(data);
+
+	return brcmf_fil_bsscfg_data_set(ifp, name, &data_le,
+					 sizeof(data_le));
+}
+static inline
+s32 brcmf_fil_bsscfg_int_get(struct brcmf_if *ifp, const char *name, u32 *data)
+{
+	__le32 data_le = cpu_to_le32(*data);
+	s32 err;
+
+	err = brcmf_fil_bsscfg_data_get(ifp, name, &data_le,
+					sizeof(data_le));
+	if (err == 0)
+		*data = le32_to_cpu(data_le);
+	return err;
+}
+
 s32 brcmf_fil_xtlv_data_set(struct brcmf_if *ifp, const char *name, u16 id,
 			    void *data, u32 len);
 s32 brcmf_fil_xtlv_data_get(struct brcmf_if *ifp, const char *name, u16 id,
 			    void *data, u32 len);
-s32 brcmf_fil_xtlv_int_set(struct brcmf_if *ifp, const char *name, u16 id, u32 data);
-s32 brcmf_fil_xtlv_int_get(struct brcmf_if *ifp, const char *name, u16 id, u32 *data);
-s32 brcmf_fil_xtlv_int8_get(struct brcmf_if *ifp, const char *name, u16 id, u8 *data);
-s32 brcmf_fil_xtlv_int16_get(struct brcmf_if *ifp, const char *name, u16 id, u16 *data);
+static inline
+s32 brcmf_fil_xtlv_int_set(struct brcmf_if *ifp, const char *name, u16 id,
+			   u32 data)
+{
+	__le32 data_le = cpu_to_le32(data);
+
+	return brcmf_fil_xtlv_data_set(ifp, name, id, &data_le,
+					 sizeof(data_le));
+}
+static inline
+s32 brcmf_fil_xtlv_int_get(struct brcmf_if *ifp, const char *name, u16 id,
+			   u32 *data)
+{
+	__le32 data_le = cpu_to_le32(*data);
+	s32 err;
+
+	err = brcmf_fil_xtlv_data_get(ifp, name, id, &data_le, sizeof(data_le));
+	if (err == 0)
+		*data = le32_to_cpu(data_le);
+	return err;
+}
+static inline
+s32 brcmf_fil_xtlv_int8_get(struct brcmf_if *ifp, const char *name, u16 id,
+			    u8 *data)
+{
+	return brcmf_fil_xtlv_data_get(ifp, name, id, data, sizeof(*data));
+}
+static inline
+s32 brcmf_fil_xtlv_int16_get(struct brcmf_if *ifp, const char *name, u16 id,
+			     u16 *data)
+{
+	__le16 data_le = cpu_to_le16(*data);
+	s32 err;
+
+	err = brcmf_fil_xtlv_data_get(ifp, name, id, &data_le, sizeof(data_le));
+	if (err == 0)
+		*data = le16_to_cpu(data_le);
+	return err;
+}
 
 #endif /* _fwil_h_ */
-- 
2.32.0


--000000000000708530060dde64d1
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCrp1/r2U/ExLOD62py
Dv4PRBLNKn9jl4QEcb7A48n6tDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDAxMDEwODQ0MzlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAiicDCJujstTGizOP3gywj7z9eHwlHJMwxwr7
Ckr/xwmpfWC/bj9lAgldQhUHS5d46RIzwGq+3umcC+rT+CJkNsSbbyPmRXZ2aEdJus15cqdiVbuH
iegOYadr+yg1QOO56UZljTPC3eLLpWto3LgKuicq3+8bOwEI6pLDuBz39qLmfllL8x2QkCaF8Exq
1YhxePPLGOql/yuBKdYYfG/kMR3VWcNlrYmF0p5HlBbXPGa4CgAFXpEkEZuccQCeuX7tq4CCMZVc
HoXL2X6M/CcnHvhCGWzRIWHVvR0A1rOUHaotk35CNFaXGQkk5tJb9jQS3ERq9astIsN0yuavd8q3
aQ==
--000000000000708530060dde64d1--

