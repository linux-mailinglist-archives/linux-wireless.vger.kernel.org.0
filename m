Return-Path: <linux-wireless+bounces-27835-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5842CBBFC0A
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 01:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1CE84E32B2
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Oct 2025 23:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B681D61BC;
	Mon,  6 Oct 2025 23:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=govivid-ai.20230601.gappssmtp.com header.i=@govivid-ai.20230601.gappssmtp.com header.b="WVpcysSj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C12184524
	for <linux-wireless@vger.kernel.org>; Mon,  6 Oct 2025 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759792393; cv=none; b=epWdGA3c741C9w11qUGcQcxMqiXaW300tgvdv98BxBhgD5BpVVqb2EArW/bkbk64ifJYNw5VYlNI4hlfVs8vqw4ZzPqw5eXADITSQqXifKtmtwg7SF/13zes/u4k0uxOpZmsC9qFQEiFtszKrKRjwZEhWqSOHuW97ag/gwP76IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759792393; c=relaxed/simple;
	bh=19GMLGf8m5a0CRzgB5oDAv+GaLJ/mJexuxc4h93Fq6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KAHlh6Z3PFnKkmyIMwGzPIftOAxo5P9WMZjSy7gu+WvSRZ1KV77QGVwNcL8drAJo4arqmjSOX7ftEuKOiAV7K2mLct7ysDNF/JCAhJnVWcPfKbg1t1+bpqXXJvViiL0GkF1T3647FfujRrosXVLravlBxTKunlaP7bs4qM6ej8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=govivid.ai; spf=pass smtp.mailfrom=govivid.ai; dkim=pass (2048-bit key) header.d=govivid-ai.20230601.gappssmtp.com header.i=@govivid-ai.20230601.gappssmtp.com header.b=WVpcysSj; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=govivid.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=govivid.ai
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d60501806so61738367b3.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Oct 2025 16:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=govivid-ai.20230601.gappssmtp.com; s=20230601; t=1759792390; x=1760397190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plG/WwEQw6V2dNdegoY/PD4rJgv2/HUngWDkL7W4ugk=;
        b=WVpcysSj/HepGomC+yoRV9dX8CfhETdH0WUFod/NGBJ7xW1gBrTacwDdKg/LcjGVWV
         uWPNzNEwHpGofgABW1ShIZeme2z7ik7BAmxyzKnnUCEukYw8s2NtxIELsSgmIYCza7a2
         kZTA7mgnOIXFvTcu0OUZQGUVgB2ss6qP8K2WQ7XgTbHYQZjzedugGsf+/xAqJYkoXvQX
         ZGEjsMPZnG0BUvEiJveWLD4Q+hLlupFLJmkB5r4NG5Ggv7zbGL723R+58rDPIOzH9PbT
         PnAr6ZgTqCMciL8AwJcBwBXPFO452ZB7QnN2Zd293Rey4OEni/ptMyibgSZTY+2Kcczx
         fKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759792390; x=1760397190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plG/WwEQw6V2dNdegoY/PD4rJgv2/HUngWDkL7W4ugk=;
        b=e5r/frQldWlL54Iyj3nM278GfcSH23uqicV7wGrFyyd6zUkJ2qAjJeaYcbjiaLm7ZP
         pQaNo5FbLcaXrHd6X/WKdNIPyCooZroSbMGBbKyFq8pttl+jzTuqbRjf3Wkge0PrvyRZ
         050/vfVNOx47N+J9IyiuUpDGiKUfk0ZqMH7ytBt3yACyXp9K6JRNnDco5XYeItSeoufK
         uqXY74rdYwCdDRcGW7NpVjLF3LV5stPSrIY1fSGdkaGtGOd1PEWLMzp6AfN+MieomIcf
         qubIA9EbFgAvo5BABdB13GCgbQkm7tAvOii0SkzbulJFMqb8vOTYIO43JrvEEAoRWZxi
         1NUw==
X-Gm-Message-State: AOJu0YxXpvmrRfUo5TC+T2CVURrc8ptHpygbWfdxpDt23tUj20BoCMDG
	8O41FXIwT5rlBfJ0vHO/uzwQj4gmTh9i6QbFzD6HI1EmiFo6sVHCDSxwrM+3EqsvJEWlWsdpoVd
	gQuyN
X-Gm-Gg: ASbGncs6AQSCaUH9m6wosbCNgIsPg/bFif8g/l5fJAc+0a5LRmPIMRXcCAW3slURN1g
	XeztueK9YTJwfg3aYSIWl63aRFtAqXSEjaa8kQ/3D9C/CuE3RZuiK/Xu/e3oCRTDJHKaDxoaLW9
	djHCWAuw9d20wBp8WV7M5EtOEhGXJybnqpVdxCe0BawkEO8Dez+yY1UyLDd8dXo8hb7N4bng5gZ
	M59F+v3sYAMLXkBJWQRQ9rhIPNm65aZaXCTRiII9TdrKo+W4luGA6dj505cXMxF7+XPLhcN/ccZ
	rDzhkXS0xb0W2gCY84QSUvQzUhiJfd7tGo3gCQNEG2L1cnz0v8e6Bh/tjlLfgDkZuRySbD46Hg3
	lnb/3esA9nRmdzuOgk96aVx3KUq1xbEr73QsKjg==
X-Google-Smtp-Source: AGHT+IFk6eSrZ5XzN3wvlsC9PmPuzF6JqZifmZhN9bZD3EfSYGRrCwu9TSu1fUUPzi8tVdN/mHZODg==
X-Received: by 2002:a05:690c:6604:b0:77f:90dd:af74 with SMTP id 00721157ae682-77f945bf0ddmr152543907b3.3.1759792390164;
        Mon, 06 Oct 2025 16:13:10 -0700 (PDT)
Received: from pop-os.. ([12.41.86.113])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-77f81c09387sm47712097b3.2.2025.10.06.16.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 16:13:09 -0700 (PDT)
From: Richard Reigh <richard@govivid.ai>
To: linux-wireless@vger.kernel.org
Cc: wahrenst@gmx.net,
	arend.vanspriel@broadcom.com,
	brcm80211-dev-list.pdl@broadcom.com,
	brcm80211@lists.linux.dev,
	chris@streetlogic.pro,
	s311332@gmail.com,
	Richard Reigh <richard@govivid.ai>
Subject: [PATCH v2] brcmfmac: Fix NULL pointer dereference in P2P action frame handling
Date: Mon,  6 Oct 2025 18:13:06 -0500
Message-Id: <20251006231306.131967-1-richard@govivid.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <9811a46c-70ab-4bf6-9e20-7882fe1d0c55@gmx.net>
References: <9811a46c-70ab-4bf6-9e20-7882fe1d0c55@gmx.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When iPhones query network information via the WiFi settings "i" button,
the brcmfmac driver crashes with a NULL pointer dereference. This occurs
because the P2P device vif is not initialized when handling certain action
frames.

Added an early check in brcmf_cfg80211_mgmt_tx() to verify P2P device vif
availability before attepting to send action frames. Also added a defensive
check in brcmf_p2p_tx_action_frame() as a safety net.

Tested on Raspberry Pi Zero 2 W with kernel 6.1.21-v8+

Fixes: 18e2f61db3b7 ("brcmfmac: P2P action frame tx")
Signed-off-by: Richard Reigh <richard@govivid.ai>

---
Changes in v2:
- Added early check in cfg80211.c before calling P2P functions (suggested by
  Stefan Wahren)
- Changed error message to debug level in p2p.c (suggested by Stefan Wahren)
- Added fixes tag
---
 .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 13 +++++++++++++
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c  |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index ea8409e0e..9983136a7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5137,6 +5137,19 @@ brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 
 	vif = container_of(wdev, struct brcmf_cfg80211_vif, wdev);
 
+	/* check if P2P device vif is available before attempting */
+	/* action frames */
+	if (ieee80211_is_action(mgmt->frame_control)) {
+		struct brcmf_p2p_info *p2p = &cfg->p2p;
+
+		if (!p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif) {
+			brcmf_dbg(TRACE, "P2P device vif not available\n");
+			cfg80211_mgmt_tx_status(wdev, *cookie, buf, len, false,
+						GFP_KERNEL);
+			return 0;
+		}
+	}
+
 	if (ieee80211_is_probe_resp(mgmt->frame_control)) {
 		/* Right now the only reason to get a probe response */
 		/* is for p2p listen response or for p2p GO from     */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index 10d9d9c63..e62135cd4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -1559,6 +1559,12 @@ static s32 brcmf_p2p_tx_action_frame(struct brcmf_p2p_info *p2p,
 	else
 		vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
 
+	/* add NULL check */
+	if (!vif) {
+		brcmf_dbg(TRACE, "vif is NULL, cannot send action frame\n");
+		return -ENODEV;
+	}
+
 	err = brcmf_fil_bsscfg_data_set(vif->ifp, "actframe", af_params,
 					sizeof(*af_params));
 	if (err) {
-- 
2.34.1


