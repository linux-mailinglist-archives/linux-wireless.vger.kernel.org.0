Return-Path: <linux-wireless+bounces-1439-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEF8822AA8
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 10:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F338285161
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 09:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BAA1864E;
	Wed,  3 Jan 2024 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Aq6eKyxl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6B818637
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jan 2024 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3374eb61cbcso203072f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jan 2024 01:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704275832; x=1704880632; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=on6eER1psI786e0oItRaq0d2yEbkXlA313wsomcJh7E=;
        b=Aq6eKyxlrOAYDE3yHMh1NLEyv5z7p47bxeJnP+rguOGVhIHi3NMTFyV//RfJd1wFUh
         6/SpN85W9otoG7Qv+qMuGayi4JllRMDR7q8mbJD0Zicr5pd90OT6+5TNQoB6jscXLrf9
         +D6iHCOKBeZ5aMjzAmnzrjGzIcuB2KMks5Yms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704275832; x=1704880632;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=on6eER1psI786e0oItRaq0d2yEbkXlA313wsomcJh7E=;
        b=BLXUTr8/ZZme49NekCZoj4BgOOyzrxt+We7lY1TZEURddXKVDo/gxkIine5hSTTnlR
         GrXx5DpQKnQ5oELp0xgkJvpwoBog4aiGgzLCM+zDEdDMbwN12I2tDd5OptafX2tcWh9r
         s/gP4kge/9tVVSyZEnJzWxN/uPdOdMdanoMUsKC/kcdWqOCJIt2YdOGu76N/xz2B1Jn9
         BqacnSwcJNO5ZuHgKAbEj0xc0dJZcfmvDspc5vWqxWi+eCE+2m8ouYODNw1LSK43Wnjc
         ZFZiAHaC467DOhR8i2o7qMBFmzyZGrBB66RZQMPEtm6pquJGiLB61bLGVXSQV86hRvls
         NTLA==
X-Gm-Message-State: AOJu0YyUkaMvUcyvjhLWgPGDYVoMQIs/OmI9Z7LLLerdXmj3/CfSAFka
	KZ4+kb8GF6id91h7442buUycVQEo7OEC
X-Google-Smtp-Source: AGHT+IEGUd/rNKM2v7h6KZs9gqZDO3qliD2CI3J4v0zIx+GIOngObIrP8ZsQaXLE7v5cnrPu8gt3lA==
X-Received: by 2002:a5d:6611:0:b0:336:9eb1:e10e with SMTP id n17-20020a5d6611000000b003369eb1e10emr9867876wru.39.1704275832758;
        Wed, 03 Jan 2024 01:57:12 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id d5-20020adffbc5000000b00336e69fbc32sm18868019wrs.102.2024.01.03.01.57.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2024 01:57:11 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH V2 1/4] wifi: brcmfmac: export firmware interface functions
Date: Wed,  3 Jan 2024 10:57:01 +0100
Message-Id: <20240103095704.135651-2-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240103095704.135651-1-arend.vanspriel@broadcom.com>
References: <20240103095704.135651-1-arend.vanspriel@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009fd742060e07a3c9"

--0000000000009fd742060e07a3c9
Content-Transfer-Encoding: 8bit

With multi-vendor support the vendor-specific module may need to use
the firmware interface functions so export them using the macro
BRCMF_EXPORT_SYMBOL_GPL() which exports them to driver namespace.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
changelog
  V2: address 0-day compilation failure for sparc64.
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |   4 +-
 .../broadcom/brcm80211/brcmfmac/core.c        |   2 +-
 .../broadcom/brcm80211/brcmfmac/feature.c     |   2 +-
 .../broadcom/brcm80211/brcmfmac/fwil.c        | 115 +---------------
 .../broadcom/brcm80211/brcmfmac/fwil.h        | 127 +++++++++++++++---
 5 files changed, 121 insertions(+), 129 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 133c5ea6429c..4df3d53bf5d3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -3081,7 +3081,7 @@ brcmf_cfg80211_get_station_ibss(struct brcmf_if *ifp,
 	struct brcmf_scb_val_le scbval;
 	struct brcmf_pktcnt_le pktcnt;
 	s32 err;
-	u32 rate;
+	u32 rate = 0;
 	u32 rssi;
 
 	/* Get the current tx rate */
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


--0000000000009fd742060e07a3c9
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCALW0g1HcLF1Ky9m1D0
IHlesqc/fzi9FQ0T51E5FdYurDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDAxMDMwOTU3MTJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEA7FzXHJnechr13LQ1MXOHW2q/3wYe1WNLdEWC
7k1rOLzQiqE6U7e/9raXvUER7g6QId764nj6klCgpwalIfk0FFsNsbfjjAhr4N85cs3B3QdxQ71F
4E9Xtl+jNbHMXeI7m2dG52ioWF46HWxJWBH6Tm3hMLLjDG8f6T0iLrqeWPyYdYDOVy6t3XtnQisP
AhjQEa23uskAv2HB3ZxZoO5RvtdAuc8jC/9gr0E7EPn9Iws5yK8d2lFqLvjK/Bjxgz6BPbgWUq6F
i+W+ebk4TpaHBnuEl3yhnBc43nOD2ivFm1lFV1ThwEUjI3pM14nVAcCyMOYbOR8RyQPbDQYdMtGr
yg==
--0000000000009fd742060e07a3c9--

