Return-Path: <linux-wireless+bounces-10020-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CC69291D1
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CFEAB21A3D
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4211C69D;
	Sat,  6 Jul 2024 08:28:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162B941A94
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254504; cv=none; b=fS5Vmrjz8BdimcESOaI+qQyAj+luFJiOwVeUK1nvAKaAzfBuC5BUZIwZxmQp8Zch/Fxrze3XPXguexu1bP/oPhPVyywYr+B/kEEMCrqksWEIBJFfZLzWkg8YC5D7zoxqHLri3kqyYlBeHe4uhXDXRaHdsnWDo9vLnGZkvH5Gohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254504; c=relaxed/simple;
	bh=ZuS1cCteGnmQkyLUn7yrpsqVuMR4c9rfyra1ywarpME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o41clgjHdN1vB5Q7LNGeE05jUcLcnZauz25jN4ju/QAEsxO0v4/Ejdfc75AKPjvRLoJ2qMufctZbSfzjVFUXiZCLdfIM86UJca2hWuHbGNifik3d08AwQdJsKX7U9u0bOZMEPBrc9LmAufYUzb7ygC6jH7vlooEqXKO1hPilh6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-25e14bf05e5so95378fac.1
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254502; x=1720859302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBS3wbdRxNhopEBbNwl9R2AdLE3ypdIAsNxw00p9SqU=;
        b=P5zWAYDgguJccrM0wdjp8O124X3Sq4CKiE+SDWjqqasFeYcI4wuKEwu+eD5E4/tyyj
         dlVZ01mz95vQehVaSbzqwgjS765yXg+yc9zB7ENQyGAfG6O31FFjftqjoAtOAPTtaJDQ
         cIKY3PBmIYoRIDZIsw2BUJgHbieONZ7f9Il2t+SnW/rWMRXXVwiu4WvhVxHS3Vzl//jG
         Bo5qSmogsHzDbSgaFSYQqXtRsFV0nE0xtZvTuIfwhxMRoThR8iLkECt6lNJNckgM58B4
         CnNdBr8X0UYLY8Hynrz5W/erGA/UlQYh3Y1AU+NwgmFIV/20NkSbWJZKypHaHaMhtIwa
         Gn8A==
X-Forwarded-Encrypted: i=1; AJvYcCWqxdNZVBayEdhQj+iG9W+mmVQEHXQONyQvF88P959EeqECb3+9TCn034LxaKVaez9QIPPuKiIz0x9ag9zSFp2kU4F8PggauVE+BX6V/fk=
X-Gm-Message-State: AOJu0YxM0NduOnII7uGlM/xmAdIFJJhU1uOZDQdU4kPYeoe2s57gJdVt
	Q0rvYxgNu2KJgwezHwT4G9J+lHgmpzDUQIwiCbXjm6eUCJmZIDIn
X-Google-Smtp-Source: AGHT+IEk6eY+anZuLZtshXs5jcY3ZABNoDdpwliXhfVBQqinwJqJUuK5I+eA1bn/Byd1GVaRQ7nPXQ==
X-Received: by 2002:a05:6871:588c:b0:25e:2624:eb5f with SMTP id 586e51a60fabf-25e2b8cf269mr6539491fac.1.1720254502068;
        Sat, 06 Jul 2024 01:28:22 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:28:20 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 01/37] wifi: mt76: mt7925: update mt76_connac_mcu_uni_add_dev for MLO
Date: Sat,  6 Jul 2024 01:27:41 -0700
Message-Id: <5c184808c54b4e71c6feec05828a9f1f5be9b14d.1720248331.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1720248331.git.sean.wang@kernel.org>
References: <cover.1720248331.git.sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Set OMAC address with the per-link BSS. The change remains compatible with
the non-MLO mode and the older firmware.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 4e3c8af98fe7..18801aaf6764 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -4,6 +4,7 @@
 #include <linux/firmware.h>
 #include "mt76_connac2_mac.h"
 #include "mt76_connac_mcu.h"
+#include "mt792x.h"
 
 int mt76_connac_mcu_start_firmware(struct mt76_dev *dev, u32 addr, u32 option)
 {
@@ -1141,7 +1142,8 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 				struct mt76_wcid *wcid,
 				bool enable)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)bss_conf->vif->drv_priv;
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(bss_conf);
+	struct mt76_vif *mvif = &mconf->mt76;
 	struct mt76_dev *dev = phy->dev;
 	struct {
 		struct {
@@ -1214,7 +1216,7 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
 	basic_req.basic.hw_bss_idx = idx;
 
-	memcpy(dev_req.tlv.omac_addr, bss_conf->vif->addr, ETH_ALEN);
+	memcpy(dev_req.tlv.omac_addr, bss_conf->addr, ETH_ALEN);
 
 	cmd = enable ? MCU_UNI_CMD(DEV_INFO_UPDATE) : MCU_UNI_CMD(BSS_INFO_UPDATE);
 	data = enable ? (void *)&dev_req : (void *)&basic_req;
-- 
2.25.1


