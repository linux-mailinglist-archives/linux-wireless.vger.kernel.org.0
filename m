Return-Path: <linux-wireless+bounces-10565-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4685193E0A5
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 20:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE801F217AD
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 18:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1AB18308E;
	Sat, 27 Jul 2024 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DTP0wpU2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C45179A3
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jul 2024 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722106587; cv=none; b=R3lJF7cuAQM1JjQbUWfqYTizmmzpKA2EKlKKvyZr1vgCGxtflRiiTmNtgPzplfpZ+aNAsaJ1Z07FF77+bHRiL3D0LznDFLnYfl2ESnPdNsRTP4ZC9vmb3fyyKLwVks/SQtT87F9eTqyFLZhvxQ4Pfth3Oeq6fuPB5rvrdM4s0RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722106587; c=relaxed/simple;
	bh=8p1rNmz4tmeWBJJwzhliteifGEOd1BXjvVO8MLUJcms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BXsx7hZktWX+CSP3ZITHVbqYoeIl3qgi608kbU1QpD/aA13c5TMYGXEiVXBWHMRfQrq3mRag+vK+cdW4qlglCyUjegnT0SGUPtUAWmYHs715pjBoCx4q4tcw2MIlT2uZX0MWs415EQyR5PY9HBCx41gP+I1BKDMQRfMUAgYdUbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DTP0wpU2; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44fe28eb1bfso10399781cf.0
        for <linux-wireless@vger.kernel.org>; Sat, 27 Jul 2024 11:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722106584; x=1722711384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MUOOESKI/ksW3lXihkzO7z85Zi5xiBexY1ha/4ln73U=;
        b=DTP0wpU2lKDlNMDHAvYO5djc3gYRZ1hYa5XMi2eMmNtKPfZZFyDTmwknIpXNDXzim6
         +rjpLgyy1epRFW3fOW/dH12fIn4Rd2qyLPdPWIMYXTldK+26+WOfdkKxW7o3DIJupkRf
         CB1S8vOxzjIym9HAVd3QKLu12exAemPB5NwBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722106584; x=1722711384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MUOOESKI/ksW3lXihkzO7z85Zi5xiBexY1ha/4ln73U=;
        b=Vllc0Os2YvlqkQ4S25TWqFro+Y/DtYKc/8+DGJuR2zzrhAGx/NBM7pJepGwBcukZSr
         CIciCDJ12qp9sVTdeAiD8hv65N9qgHWnIBr3W09mokqdixa2gqiRKm4iEQ7V5E0m2EAG
         xFWPQa23+xlZBTqNsyG3ZAy/dM2DxBpicPtGQ8NkupOrKUyV8taZ1tRNh3f8UUhhE2dh
         iZopcdllqi7ToQHBPtRXIVqrWZy9Xj98205CPgkI+v0RNFZ+cQN7zfM5NqnQnx8W+X7S
         xF4TuCiHJnpVLHkQsB+0DNkZUnfiLKjlH2hyOiAvyMj5oRNzkAGKEFT+WZYo6DJksBHa
         +ilQ==
X-Gm-Message-State: AOJu0YzBVFMrFZqTW0RLMbAdeTN1Hn6d+blkhy/cZo+KzlxDPb0MaHKy
	294pSfyOMgqo9D/cqcKSD10WVu54mzjyhXl7fx4EdzybSOvUtfPS5kFRuBdIOw==
X-Google-Smtp-Source: AGHT+IE/TgnuMb5X5BJF190OfHUANB8z7/1Kk+p9GZtvjLf05X2fLDRyPvqsSYwaE1+E53UXWV0zQQ==
X-Received: by 2002:a05:622a:13d1:b0:446:5d60:5cf3 with SMTP id d75a77b69052e-45004d79febmr43944361cf.6.1722106584428;
        Sat, 27 Jul 2024 11:56:24 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe81689a5sm26382331cf.39.2024.07.27.11.56.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jul 2024 11:56:23 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Su Hui <suhui@nfschina.com>
Subject: [PATCH] wifi: brcmfmac: introducing fwil query functions
Date: Sat, 27 Jul 2024 20:56:17 +0200
Message-Id: <20240727185617.253210-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the firmware interface layer was refactored it provided various
"get" and "set" functions. For the "get" in some cases a parameter
needed to be passed down to firmware as a key indicating what to
"get" turning the output parameter of the "get" function into an
input parameter as well. To accommodate this the "get" function blindly
copies the parameter which in some places resulted in an uninitialized
warnings from the compiler. These have been fixed by initializing the
input parameter in the past. Recently another batch of similar fixes
were submitted to address clang static checker warnings [1].

Proposing another solution by introducing a "query" variant which is used
when the (input) parameter is needed by firmware. The "get" variant will
only fill the (output) parameter with the result received from firmware
taking care of proper endianess conversion.

[1] https://lore.kernel.org/all/20240702122450.2213833-1-suhui@nfschina.com/

Fixes: 81f5dcb80830 ("brcmfmac: refactor firmware interface layer.")
Reported-by: Su Hui <suhui@nfschina.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
The change has been compiled with C=2 (sparse) to assure endianess
conversions are correct. The change has been verified on 43664 PCIe
device and 4330 SDIO device.

It applies to the main branch of the wireless-next repository.

Regards,
Arend
---
 .../broadcom/brcm80211/brcmfmac/btcoex.c      |  2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 30 +++++++-------
 .../broadcom/brcm80211/brcmfmac/core.c        |  2 +-
 .../broadcom/brcm80211/brcmfmac/feature.c     |  2 +-
 .../broadcom/brcm80211/brcmfmac/fwil.h        | 40 ++++++++++++++-----
 5 files changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
index 0c3d119d1219..1e8495f50c16 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
@@ -123,7 +123,7 @@ static s32 brcmf_btcoex_params_read(struct brcmf_if *ifp, u32 addr, u32 *data)
 {
 	*data = addr;
 
-	return brcmf_fil_iovar_int_get(ifp, "btc_params", data);
+	return brcmf_fil_iovar_int_query(ifp, "btc_params", data);
 }
 
 /**
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 1585a5653ee4..2379f46e2326 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -663,8 +663,8 @@ static int brcmf_cfg80211_request_sta_if(struct brcmf_if *ifp, u8 *macaddr)
 	/* interface_create version 3+ */
 	/* get supported version from firmware side */
 	iface_create_ver = 0;
-	err = brcmf_fil_bsscfg_int_get(ifp, "interface_create",
-				       &iface_create_ver);
+	err = brcmf_fil_bsscfg_int_query(ifp, "interface_create",
+					 &iface_create_ver);
 	if (err) {
 		brcmf_err("fail to get supported version, err=%d\n", err);
 		return -EOPNOTSUPP;
@@ -756,8 +756,8 @@ static int brcmf_cfg80211_request_ap_if(struct brcmf_if *ifp)
 	/* interface_create version 3+ */
 	/* get supported version from firmware side */
 	iface_create_ver = 0;
-	err = brcmf_fil_bsscfg_int_get(ifp, "interface_create",
-				       &iface_create_ver);
+	err = brcmf_fil_bsscfg_int_query(ifp, "interface_create",
+					 &iface_create_ver);
 	if (err) {
 		brcmf_err("fail to get supported version, err=%d\n", err);
 		return -EOPNOTSUPP;
@@ -2101,7 +2101,8 @@ brcmf_set_key_mgmt(struct net_device *ndev, struct cfg80211_connect_params *sme)
 	if (!sme->crypto.n_akm_suites)
 		return 0;
 
-	err = brcmf_fil_bsscfg_int_get(netdev_priv(ndev), "wpa_auth", &val);
+	err = brcmf_fil_bsscfg_int_get(netdev_priv(ndev),
+				       "wpa_auth", &val);
 	if (err) {
 		bphy_err(drvr, "could not get wpa_auth (%d)\n", err);
 		return err;
@@ -2680,7 +2681,7 @@ brcmf_cfg80211_get_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
 	struct brcmf_cfg80211_vif *vif = wdev_to_vif(wdev);
 	struct brcmf_pub *drvr = cfg->pub;
-	s32 qdbm = 0;
+	s32 qdbm;
 	s32 err;
 
 	brcmf_dbg(TRACE, "Enter\n");
@@ -3067,7 +3068,7 @@ brcmf_cfg80211_get_station_ibss(struct brcmf_if *ifp,
 	struct brcmf_scb_val_le scbval;
 	struct brcmf_pktcnt_le pktcnt;
 	s32 err;
-	u32 rate = 0;
+	u32 rate;
 	u32 rssi;
 
 	/* Get the current tx rate */
@@ -7039,8 +7040,8 @@ static int brcmf_construct_chaninfo(struct brcmf_cfg80211_info *cfg,
 			ch.bw = BRCMU_CHAN_BW_20;
 			cfg->d11inf.encchspec(&ch);
 			chaninfo = ch.chspec;
-			err = brcmf_fil_bsscfg_int_get(ifp, "per_chan_info",
-						       &chaninfo);
+			err = brcmf_fil_bsscfg_int_query(ifp, "per_chan_info",
+							 &chaninfo);
 			if (!err) {
 				if (chaninfo & WL_CHAN_RADAR)
 					channel->flags |=
@@ -7074,7 +7075,7 @@ static int brcmf_enable_bw40_2g(struct brcmf_cfg80211_info *cfg)
 
 	/* verify support for bw_cap command */
 	val = WLC_BAND_5G;
-	err = brcmf_fil_iovar_int_get(ifp, "bw_cap", &val);
+	err = brcmf_fil_iovar_int_query(ifp, "bw_cap", &val);
 
 	if (!err) {
 		/* only set 2G bandwidth using bw_cap command */
@@ -7150,11 +7151,11 @@ static void brcmf_get_bwcap(struct brcmf_if *ifp, u32 bw_cap[])
 	int err;
 
 	band = WLC_BAND_2G;
-	err = brcmf_fil_iovar_int_get(ifp, "bw_cap", &band);
+	err = brcmf_fil_iovar_int_query(ifp, "bw_cap", &band);
 	if (!err) {
 		bw_cap[NL80211_BAND_2GHZ] = band;
 		band = WLC_BAND_5G;
-		err = brcmf_fil_iovar_int_get(ifp, "bw_cap", &band);
+		err = brcmf_fil_iovar_int_query(ifp, "bw_cap", &band);
 		if (!err) {
 			bw_cap[NL80211_BAND_5GHZ] = band;
 			return;
@@ -7163,7 +7164,6 @@ static void brcmf_get_bwcap(struct brcmf_if *ifp, u32 bw_cap[])
 		return;
 	}
 	brcmf_dbg(INFO, "fallback to mimo_bw_cap info\n");
-	mimo_bwcap = 0;
 	err = brcmf_fil_iovar_int_get(ifp, "mimo_bw_cap", &mimo_bwcap);
 	if (err)
 		/* assume 20MHz if firmware does not give a clue */
@@ -7259,10 +7259,10 @@ static int brcmf_setup_wiphybands(struct brcmf_cfg80211_info *cfg)
 	struct brcmf_pub *drvr = cfg->pub;
 	struct brcmf_if *ifp = brcmf_get_ifp(drvr, 0);
 	struct wiphy *wiphy = cfg_to_wiphy(cfg);
-	u32 nmode = 0;
+	u32 nmode;
 	u32 vhtmode = 0;
 	u32 bw_cap[2] = { WLC_BW_20MHZ_BIT, WLC_BW_20MHZ_BIT };
-	u32 rxchain = 0;
+	u32 rxchain;
 	u32 nchain;
 	int err;
 	s32 i;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index bf91b1e1368f..df53dd1d7e74 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -691,7 +691,7 @@ static int brcmf_net_mon_open(struct net_device *ndev)
 {
 	struct brcmf_if *ifp = netdev_priv(ndev);
 	struct brcmf_pub *drvr = ifp->drvr;
-	u32 monitor = 0;
+	u32 monitor;
 	int err;
 
 	brcmf_dbg(TRACE, "Enter\n");
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
index f23310a77a5d..0d9ae197fa1e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
@@ -184,7 +184,7 @@ static void brcmf_feat_wlc_version_overrides(struct brcmf_pub *drv)
 static void brcmf_feat_iovar_int_get(struct brcmf_if *ifp,
 				     enum brcmf_feat_id id, char *name)
 {
-	u32 data = 0;
+	u32 data;
 	int err;
 
 	/* we need to know firmware error */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h
index a315a7fac6a0..31e080e4da66 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h
@@ -96,15 +96,22 @@ static inline
 s32 brcmf_fil_cmd_int_get(struct brcmf_if *ifp, u32 cmd, u32 *data)
 {
 	s32 err;
-	__le32 data_le = cpu_to_le32(*data);
 
-	err = brcmf_fil_cmd_data_get(ifp, cmd, &data_le, sizeof(data_le));
+	err = brcmf_fil_cmd_data_get(ifp, cmd, data, sizeof(*data));
 	if (err == 0)
-		*data = le32_to_cpu(data_le);
+		*data = le32_to_cpu(*(__le32 *)data);
 	brcmf_dbg(FIL, "ifidx=%d, cmd=%d, value=%d\n", ifp->ifidx, cmd, *data);
 
 	return err;
 }
+static inline
+s32 brcmf_fil_cmd_int_query(struct brcmf_if *ifp, u32 cmd, u32 *data)
+{
+	__le32 *data_le = (__le32 *)data;
+
+	*data_le = cpu_to_le32(*data);
+	return brcmf_fil_cmd_int_get(ifp, cmd, data);
+}
 
 s32 brcmf_fil_iovar_data_set(struct brcmf_if *ifp, const char *name,
 			     const void *data, u32 len);
@@ -120,14 +127,21 @@ s32 brcmf_fil_iovar_int_set(struct brcmf_if *ifp, const char *name, u32 data)
 static inline
 s32 brcmf_fil_iovar_int_get(struct brcmf_if *ifp, const char *name, u32 *data)
 {
-	__le32 data_le = cpu_to_le32(*data);
 	s32 err;
 
-	err = brcmf_fil_iovar_data_get(ifp, name, &data_le, sizeof(data_le));
+	err = brcmf_fil_iovar_data_get(ifp, name, data, sizeof(*data));
 	if (err == 0)
-		*data = le32_to_cpu(data_le);
+		*data = le32_to_cpu(*(__le32 *)data);
 	return err;
 }
+static inline
+s32 brcmf_fil_iovar_int_query(struct brcmf_if *ifp, const char *name, u32 *data)
+{
+	__le32 *data_le = (__le32 *)data;
+
+	*data_le = cpu_to_le32(*data);
+	return brcmf_fil_iovar_int_get(ifp, name, data);
+}
 
 
 s32 brcmf_fil_bsscfg_data_set(struct brcmf_if *ifp, const char *name,
@@ -145,15 +159,21 @@ s32 brcmf_fil_bsscfg_int_set(struct brcmf_if *ifp, const char *name, u32 data)
 static inline
 s32 brcmf_fil_bsscfg_int_get(struct brcmf_if *ifp, const char *name, u32 *data)
 {
-	__le32 data_le = cpu_to_le32(*data);
 	s32 err;
 
-	err = brcmf_fil_bsscfg_data_get(ifp, name, &data_le,
-					sizeof(data_le));
+	err = brcmf_fil_bsscfg_data_get(ifp, name, data, sizeof(*data));
 	if (err == 0)
-		*data = le32_to_cpu(data_le);
+		*data = le32_to_cpu(*(__le32 *)data);
 	return err;
 }
+static inline
+s32 brcmf_fil_bsscfg_int_query(struct brcmf_if *ifp, const char *name, u32 *data)
+{
+	__le32 *data_le = (__le32 *)data;
+
+	*data_le = cpu_to_le32(*data);
+	return brcmf_fil_bsscfg_int_get(ifp, name, data);
+}
 
 s32 brcmf_fil_xtlv_data_set(struct brcmf_if *ifp, const char *name, u16 id,
 			    void *data, u32 len);
-- 
2.34.1


