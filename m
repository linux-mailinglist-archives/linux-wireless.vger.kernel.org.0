Return-Path: <linux-wireless+bounces-24837-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6768AFA04D
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jul 2025 15:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 395727B4A76
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jul 2025 13:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D4784A3E;
	Sat,  5 Jul 2025 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQ2d5/9p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E5981724;
	Sat,  5 Jul 2025 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751723297; cv=none; b=hSaj4YmfzNFYbt/0SOI+ximjySty0eeLFvCZHWWr+TcPN8IZP4So/XIh/IWwT0MkezVenWdQgeIk8mhHVGv8/BQrpjgbw7+pCf8s41cHIlP3KnI19VR3bJqAKLJ5DcI47FEmyagDo9B6EH4P2gVSqCu2zzVfOEZtL0tuQeF61Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751723297; c=relaxed/simple;
	bh=1W2H0B+w6NXxysExHkX8rMo71CAahvdW/g5zceAGqmE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=W+i901uXwl3offBGTixtL4S0DNyLEB5vgEJ1KmCAUqjLXQRTnM0KwRcXVo1Bc+o7dYksg/TuV+yWkL1x2oyqWOMQA381YiWhpFuVf4ewykpHA3+LhujZl2nx1NT+MOLnwLBFUcsWkbwbXjepvI47mMU5FsFajuaRoWlCoguwZew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQ2d5/9p; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4e749d7b2so293550f8f.0;
        Sat, 05 Jul 2025 06:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751723294; x=1752328094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fn6GdLcwuFXBANzqB1k0dwAdvk++L8vnpZOVjkO4kDg=;
        b=EQ2d5/9pZBYgTE7OvLc1Wu33Ht5n60Y/uyrUFBUp71oALDIMWdiJS23oafRSlagwRP
         K5zNXGYG6fxGVa0d1+go7lnEd3DSedH3vpW5Q0RiDGmnQtx8xkMYQiBr7AmUW7B5F1MY
         KU6BM5iX6wLNY5uZwiDwGSkvlOlvtJL9AVgQG/riNBPl5qaGojKA8L8PCdJYitp3ZUwI
         ZSzvgTJfmxQj+3wtcST8O/+72tTQHPO1WFduBtjc8KeRABEVdLh+heiCxaSphr2zpTLy
         mMxawTFNKtauutpylZvYZ1pSTntfhCoC8i9k5N7rOtHxrqeVshU63fxUS2TLhSMaXACp
         oxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751723294; x=1752328094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fn6GdLcwuFXBANzqB1k0dwAdvk++L8vnpZOVjkO4kDg=;
        b=MgU/UksfyPQ2NRioJC+nMGRFbEvO/DCyE8hHDX7wkdRWAMFN9tqzU72Lw2eDD+gAD7
         4wOG2FHuUCwMiJk7lHx9WlJhz8PFpTb27AgGypz0zaYQZjj0n4o0yOKom5lBOcqtqQKU
         nh+iaTCyCABwKnDwnWWxJ72QTKhOMbOPde9ERoWK8SwuxebYo5ZCQ+tJh8AQFKtJxzgz
         bgx6AR6bwXD/AULKLl693rhoSk9C7GC4l/yLjKivHtHpIb7Fowbv3aX0+A0AAKKboc4b
         AfjIUIehDPZiKSeQSa5GypsMg5Fle1U3thKR8xmEDNt408cjCiAWacejtvX12LXWsHUy
         RjMw==
X-Gm-Message-State: AOJu0Yw7Ijv78Oh8m+ch/idYDsCGwJJgV/CsFaIQoah8oB1iMc4E0ajC
	vMkcjM3AbaIck7V3gEWUhj+s0DNiH3tUDCmuYyxPaN4FWvDypVT0rI937np3ZoUww5w=
X-Gm-Gg: ASbGncurp55QY/WJZTPEIXeXkbEqjeQKL9WX3unxNREUPADkVdYbhhLdPLFsu6qU69J
	6qoBeMDVUG8RmXkOFlrha1TuDQIMCTZsH0tzaCpr+rIcHKBpuRU60mt4iWlNAOIzh/ccOJ8EW5P
	NPWS0oFfvCsv1XbiXoC6pK86fGv/8fqXfnOk9xNVyo+Vh9ft75dzhamZ5nDu840W4hGxSr/xtMw
	ET7ev+qdArLwzjbrbWJM6qaAi4g2znUVVEYW4b+eVxpjgtbokheJWgWd78vyCA8GgDfkZHlYrdW
	kkDroCIf9l0PlDnCF9l6BugUmBDhmklnPvVt3by3w4zh94Q9iYlLSPbYisqCNDdz/ppdQWuqGOd
	XXLsUMqE+7wdEFKqg5DI7LTnMKPfkKf8XvntrDw==
X-Google-Smtp-Source: AGHT+IGeoBJYRo9O6B5dB4PdkosxMAJxLolG1I6S02F4NiP5Tm3phOf/jFR1IufYS2p+LhyCUtM6zg==
X-Received: by 2002:a05:6000:1ace:b0:3a6:d256:c5db with SMTP id ffacd0b85a97d-3b49662518fmr1946728f8f.13.1751723293642;
        Sat, 05 Jul 2025 06:48:13 -0700 (PDT)
Received: from pop-os.localdomain (175.77.11.37.dynamic.jazztel.es. [37.11.77.175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0959sm5051757f8f.27.2025.07.05.06.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 06:48:13 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ajay.kathat@microchip.com,
	claudiu.beznea@tuxon.dev,
	marex@denx.de,
	kvalo@kernel.org,
	alexis.lothore@bootlin.com,
	skhan@linuxfoundation.org,
	=?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
Subject: [PATCH] wilc1000: replace deprecated strcpy() with strscpy()
Date: Sat,  5 Jul 2025 15:48:10 +0200
Message-Id: <20250705134810.197494-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

strcpy() is deprecated for NUL-terminated strings.  Replace the single
instance in wilc1000 netdev setup with strscpy(), which guarantees
NUL-termination and prevents overflow.

ndev->name is a fixed-size buffer (IFNAMSIZ, 16 bytes).

Signed-off-by: Miguel García <miguelgarciaroman8@gmail.com>
---
 drivers/net/wireless/microchip/wilc1000/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index af298021e050..8f4d11e1a2a6 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -960,7 +960,7 @@ struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl, const char *name,
 
 	vif = netdev_priv(ndev);
 	ndev->ieee80211_ptr = &vif->priv.wdev;
-	strcpy(ndev->name, name);
+	strscpy(ndev->name, name, sizeof(ndev->name));
 	vif->wilc = wl;
 	vif->ndev = ndev;
 	ndev->ml_priv = vif;
-- 
2.34.1


