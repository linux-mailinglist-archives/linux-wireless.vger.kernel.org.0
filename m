Return-Path: <linux-wireless+bounces-28155-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FC8BF8CCE
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 22:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6929F465206
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 20:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1842836B0;
	Tue, 21 Oct 2025 20:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKsB00rc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AD3281503
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 20:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079911; cv=none; b=sf7lGQDm5X/EIwgvhYa/GG2ZAIxXaPZDnYQVyhS827hYT5fbIo5dByful2uigRetiOnR5jS1b/NwrWcAXxhwu1JwGlORgKd+fo+dxBisPooJgk4I/GszjRccNL9ZTsFZLZmuzp/r63SAGoLBwFbC7iBdyxQje9Zte78nIh6q4Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079911; c=relaxed/simple;
	bh=MjkLnc2tVg/RJb5BApj/E98F+C69Oi0/gfMCl2ZTnJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLTOZ69T/zT/iy07EP8r9rr0UcIsZbIozWelC1X8sjKcT80bpYJCZGfTKXRlVmFipPQv47kcB+J8hKxMEklTmmZ8y0yiNTSqnxXVWciNhaQUE7qP63Y/2dg5txhPH4hGJCX4gx+L0f8kacA4WJl8ygMOUn1oYkLrBz1sEPWm66U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKsB00rc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-290aaff555eso59335445ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 13:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761079909; x=1761684709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWnNLlNkfbiftBrKkWUkiWaeBS4JxfSDDd9vblIlhTk=;
        b=cKsB00rcQJQyTGCATp4VsekVlqP3C2BXisyHnar3lm35/fbwRrlrD/xioXlquuFSre
         MnfugRQJ//NRnD+N1zRHm7zM/gko9f8q7uTlBZmo2X/ramHzyk9rdv+nj9uVwu4uT4uB
         UKjdWKCIyVp2nTzOESY+XZo2jDPhjyjsgNywDdn7w8UcVsIzxpyXAI/MjaQojwGzTBZl
         KWCNgspdu6FwEL4hnybO38OjGLmPV1yEsE9dhcvQAiYo+ha63ACbFD7iXsgbnKdcxjtA
         8pd0GP3qrKh18krBD41vP6plttfbQ0a1Ydkxb6Trud1Yty5skc0O+XHuZ43HYi/5Ro7g
         35Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761079909; x=1761684709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWnNLlNkfbiftBrKkWUkiWaeBS4JxfSDDd9vblIlhTk=;
        b=wcaPWGIG/9YEWSlxZ29JN+9TZ4ZHoGvKUZVtZs2pTa2ilkEVHGySg6HTQMzSPRoXNx
         Uz0kHetuDP7hp5UsbGC7bWTc1As/vz1svI2pu4eR8LiA4GEXFt257NzLvA9bys1i2K6m
         iONPDa7O47t2WmSBqquIz3tXaaJ0KzFYMazxvqPgsqP+Bz8iFS/AvPqaUsXx9PwC3A0s
         yp4Sj1oDdMzk67bnZdEnmwJGMRicTaNNAthWYPYjoQiMtCV1QkYCxUIbR0/Swxnvw0kU
         YQr2cCui//0+XEm0ZZlvzlAhmjjJiEZSvzwYntZlWKPKijtMHESMkTaKZygG79cXe4yp
         SHGg==
X-Gm-Message-State: AOJu0Yz2dRLWuHz7Vhxszt3vpHCRxvR10FlssSiuLwukUMtBH+Nkllom
	bqDdpcEYEO9mY50ZPvaq7tVuODvosl6dKKRFYixGkxJ25cIf8x5wEn7j
X-Gm-Gg: ASbGncv/WoM0ywFHzcuOCIg3hs9npa6CkolY+PHELFjftb/fYQyd5HZaO+e2iWQfsPX
	BZZXaQawDUL21+3PVXrDcKKaiFaXBV8EOFpwxbUvzSLnHMZ/kJ4eTovsdLJMPXBXFYdA8fm8QVQ
	XKQdQTnjkKTIcdDGccCqFYrvYw0cpLqsmrKhTko5CpMDFuczUIAvQvieTQ51XgvHy38YxhFFOOp
	5tDZL22yyr076h42iDXnoapsQtrCvJAK0uiFEONdpPgDQ5/VvPezwFestvUMkyfiUZbfCUsMw0V
	iPgOY5YPDBoNuI4Pc3endXPnnubU/OrByliK//r2+IymCQlp3mW8xxGPGY1QRDY2WJEXcCq6Xhh
	vbE9wHMQft9MTszw0RMvL98bW9lELECP4P/eRXqcI1E1REjVjaNdnB2Mxdt0BaEV61qAVTmeJ8I
	SOW6ng6bNjqjjo
X-Google-Smtp-Source: AGHT+IEqwMCwtpJe6M2AVLhFFJ0/uoQlhALmf+ZedDkgLsoDbgVNNdvSO65CLJQ2YxoWpuTW4Nbyhw==
X-Received: by 2002:a17:903:94d:b0:266:9c1a:6def with SMTP id d9443c01a7336-290c9bea18dmr221028235ad.0.1761079908830;
        Tue, 21 Oct 2025 13:51:48 -0700 (PDT)
Received: from skylark ([171.50.223.156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcde4sm119174415ad.5.2025.10.21.13.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:51:48 -0700 (PDT)
From: Amol Dhamale <amoldhamale1105@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sriram.g@kpit.com,
	Amol Dhamale <amoldhamale1105@gmail.com>
Subject: [PATCH 2/4] wifi: mac80211_hwsim: fix coding style issue by adding whitespaces
Date: Tue, 21 Oct 2025 20:50:24 +0000
Message-ID: <2120f77e6cbcd7fedf9171f7e5eb58f7acda3273.1761078139.git.amoldhamale1105@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761078139.git.amoldhamale1105@gmail.com>
References: <cover.1761078139.git.amoldhamale1105@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adhere to Linux kernel coding style.

Reported by checkpatch:

ERROR: space required after that ',' (ctx:VxV)
ERROR: space required before the open brace '{'
ERROR: space required after that ',' (ctx:VxV)

Signed-off-by: Amol Dhamale <amoldhamale1105@gmail.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 95582345cffc..51c0582e3b77 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2504,7 +2504,7 @@ static int mac80211_hwsim_config(struct ieee80211_hw *hw, int radio_idx,
 
 static void mac80211_hwsim_configure_filter(struct ieee80211_hw *hw,
 					    unsigned int changed_flags,
-					    unsigned int *total_flags,u64 multicast)
+					    unsigned int *total_flags, u64 multicast)
 {
 	struct mac80211_hwsim_data *data = hw->priv;
 
@@ -5710,7 +5710,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 			continue;
 		}
 
-		if (band != NL80211_BAND_6GHZ){
+		if (band != NL80211_BAND_6GHZ) {
 			sband->ht_cap.ht_supported = true;
 			sband->ht_cap.cap = IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
 					    IEEE80211_HT_CAP_GRN_FLD |
@@ -6398,7 +6398,7 @@ static int hwsim_new_radio_nl(struct sk_buff *msg, struct genl_info *info)
 	if (info->attrs[HWSIM_ATTR_PERM_ADDR]) {
 		if (!is_valid_ether_addr(
 				nla_data(info->attrs[HWSIM_ATTR_PERM_ADDR]))) {
-			GENL_SET_ERR_MSG(info,"MAC is no valid source addr");
+			GENL_SET_ERR_MSG(info, "MAC is no valid source addr");
 			NL_SET_BAD_ATTR(info->extack,
 					info->attrs[HWSIM_ATTR_PERM_ADDR]);
 			return -EINVAL;
-- 
2.43.0


