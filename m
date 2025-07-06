Return-Path: <linux-wireless+bounces-24853-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BD7AFA7E9
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jul 2025 23:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108043A701E
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jul 2025 21:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF56288C2D;
	Sun,  6 Jul 2025 21:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cq9AJ5np"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FD11E008B;
	Sun,  6 Jul 2025 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838077; cv=none; b=J2ee7CzBa2b+qjSTTogONPJYm2oZU8o8it/7RKL7GlUB/xKLV/r4X3N7qWrm9sk6PIbzSenCZSuMUBJQvNAQ4OCMeICW3+D58qFfX/m9EK7lJ00sNJd+Lvg1cUneCckM3Rz1hGZfmcx/pcAhkwmDWKw68C7IQ1In0gpC2C5yqJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838077; c=relaxed/simple;
	bh=aazGO021bpAZfDCePBJnyp53QYIweGV/gZ21+LQWiDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M22kinfzUnppgXtpFMpsfkQwzB0WymT1onUFyxA4a4w/sYLfw3s9ROHWxvaTH8hEbhAdQPRWF7BnWsC0edDqfduUYjq3+UIpFDiTGbIfQPGXzZehGqoeCWVgBg43gdDql6YChFkpkN9AQp+uzsBRcqaK98heNkyymX2plg77YGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cq9AJ5np; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-73c17c770a7so3127798b3a.2;
        Sun, 06 Jul 2025 14:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751838075; x=1752442875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIiqXz9LsgS5XmKPI7jHGuK8VIEq2ClzFVk908OgH1k=;
        b=Cq9AJ5npe66cW3ztTKMTC/1MQYyxxFmlx451oE5D3BBd5ruOUDgAzEuCfTQ+/at/mb
         wq8SIeDgKG+jh3Fd9HvWO4a4anTkXnDDmahO1z0/0Km6mP0Xyd5ia684xjcfmK2EfHGA
         XwWi4ChRFW7tAM3Ha1PqZUeMWIGiUkeO+cCvTW+/FjJFla+k4Rcv4nXOfSk0DM7P51Ki
         HuvEud65dq/VepxWdzF8XfVz+1uyo9Vj/gydkrpIaNRxblekmEZbUYILpt/2IHpKhV7U
         xlLwlKo1kavvXOp524m5X7Y72b4pYDOFRtDtJZCyi/XVAtXsHESsM2t7OlvT+hY0/S+F
         iNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838075; x=1752442875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIiqXz9LsgS5XmKPI7jHGuK8VIEq2ClzFVk908OgH1k=;
        b=BpYf/GbUBH+U0UdRPnvkVHi94d0oeH9jRYmy9my5Xv6l2u8q8FVaos/IJ+ghM4wRNJ
         0eBZ4vlcBaaVSWd4oNuxnb1K3yG057njOTapOQ9tlx1CxEpImMZEZWk1SsSHzyPU8GnD
         2W+YCDONfdapqFrb4HHF2jnQ6EerCYsVEGOw0/2WRqJksvbzJG1m4zUzAjMrORv6v4O4
         EpaxU1sujTXxOEtVRUNZbNbpnzX7CyuFCVW9UlaEmc0XSeZilLrZhDZwTDTfb1swoz42
         JiRzdtqC8G8SqR6Z3oLimm00CZWem/a5ZcsWFts50ef5fxc3Su5DxzVxLWVj1fnBvPor
         D1iQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0cdsoQfsO9R/6ryF4LrxDrJ8gBptg4m/UJqtfRZIbFQhKSHqhNeGZGHItzI23VYcrtny8+oUvG+aK@vger.kernel.org, AJvYcCXK6vTDy/YpQkGOuBy3wLMtPieOVyi2oTfYkKm1922r+SbKmdM7fTY3/+NbIFHsdCCqRVBJdKLuJeLjlg==@vger.kernel.org, AJvYcCXSYkTYROylOopu28lDXVdcfCIVlfz3B7e2TuIw7+zsGfLB5AIi0gdpR+fCT+D/hak01nxq8XDxgzjJJeVr@vger.kernel.org
X-Gm-Message-State: AOJu0YwVo9xI2vTWFAukF3fdSNdGxgK1u45eQyhO2Z2kiv32qUrCy+bG
	pG847YgTIBwweOIz///UU2nN+YFw4fABKe6iOC64qV7lPa9vIoizkxW+TeGBFMeuqms=
X-Gm-Gg: ASbGnctu4yivmLZT+4vYfTKnsQsPUqugqqhrEIdOp7WCkHL7F1D3Zt+O6o07hAyAa3r
	2vxHksdWGOAnsHi8IaZ+IHOvqWuXVL6U75rW7kbib1W9A5EyB/IWg4g1L4D4l+KDcj3gZ2cqpsb
	q6IENeHJvsrm4CXOopaFM5+4ac4wogwxqukBS/NhdDVLNxWHQG6vEs24/Jgf9/GGU+I+GtMLFAu
	5NJAxLX3L/PJBbvLqG6jxn9PmJsB2/++XlXYYGrjEqCMPDw48htjbzwxAeIZyQwqu8pu/JEyaA5
	gSKx55SuWC4ivh8OSeFtFCnMDmat7SGciQaa5dNmSSY=
X-Google-Smtp-Source: AGHT+IEwlHfBS1DHzBD9Lj+YLxDEJbYcNB+0NkMuq5is6NeWi5/aui1kdvGuU4/F3aaylahetEIVfg==
X-Received: by 2002:a05:6a21:6497:b0:215:d565:3026 with SMTP id adf61e73a8af0-2260c33514bmr14391573637.20.1751838074724;
        Sun, 06 Jul 2025 14:41:14 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74cfad75020sm4126416b3a.109.2025.07.06.14.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:41:14 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	yangshiji66@qq.com,
	ansuelsmth@gmail.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH 1/6] wifi: rt2x00: fix compilation
Date: Sun,  6 Jul 2025 14:41:06 -0700
Message-ID: <20250706214111.45687-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250706214111.45687-1-rosenp@gmail.com>
References: <20250706214111.45687-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The .remove prototype commits seem to have missed this driver. Probably
because COMPILE_TEST is missing.

This is a mess anyway. These non static functions will be moved to their
proper place.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ralink/rt2x00/Kconfig     | 2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00soc.c | 4 +---
 drivers/net/wireless/ralink/rt2x00/rt2x00soc.h | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/Kconfig b/drivers/net/wireless/ralink/rt2x00/Kconfig
index d1fd66d44a7e..3a32ceead54f 100644
--- a/drivers/net/wireless/ralink/rt2x00/Kconfig
+++ b/drivers/net/wireless/ralink/rt2x00/Kconfig
@@ -202,7 +202,7 @@ endif
 
 config RT2800SOC
 	tristate "Ralink WiSoC support"
-	depends on SOC_RT288X || SOC_RT305X || SOC_MT7620
+	depends on SOC_RT288X || SOC_RT305X || SOC_MT7620 || COMPILE_TEST
 	select RT2X00_LIB_SOC
 	select RT2X00_LIB_MMIO
 	select RT2X00_LIB_CRYPTO
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00soc.c b/drivers/net/wireless/ralink/rt2x00/rt2x00soc.c
index eface610178d..f7f3a2340c39 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00soc.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00soc.c
@@ -108,7 +108,7 @@ int rt2x00soc_probe(struct platform_device *pdev, const struct rt2x00_ops *ops)
 }
 EXPORT_SYMBOL_GPL(rt2x00soc_probe);
 
-int rt2x00soc_remove(struct platform_device *pdev)
+void rt2x00soc_remove(struct platform_device *pdev)
 {
 	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
 	struct rt2x00_dev *rt2x00dev = hw->priv;
@@ -119,8 +119,6 @@ int rt2x00soc_remove(struct platform_device *pdev)
 	rt2x00lib_remove_dev(rt2x00dev);
 	rt2x00soc_free_reg(rt2x00dev);
 	ieee80211_free_hw(hw);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(rt2x00soc_remove);
 
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00soc.h b/drivers/net/wireless/ralink/rt2x00/rt2x00soc.h
index 021fd06b3627..d6226b8a10e0 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00soc.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00soc.h
@@ -17,7 +17,7 @@
  * SoC driver handlers.
  */
 int rt2x00soc_probe(struct platform_device *pdev, const struct rt2x00_ops *ops);
-int rt2x00soc_remove(struct platform_device *pdev);
+void rt2x00soc_remove(struct platform_device *pdev);
 #ifdef CONFIG_PM
 int rt2x00soc_suspend(struct platform_device *pdev, pm_message_t state);
 int rt2x00soc_resume(struct platform_device *pdev);
-- 
2.50.0


