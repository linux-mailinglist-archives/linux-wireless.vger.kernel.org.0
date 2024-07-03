Return-Path: <linux-wireless+bounces-9941-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7091C926A8A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8EC1F23173
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B358191F96;
	Wed,  3 Jul 2024 21:42:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA0817F51A
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042970; cv=none; b=TQk4enQEdHdQXU4UOdjxET8B+FAWIfdirKTPln092RPynIH56yoc2sVFaQnWL7AtCgybC2GJZ6cixW3GJKKealYde9MMAagHf/KZF30hx0/jhIUuIXdIM5KNFQhFGBw1eBnDsOACpljtSaV+N7lorF9fV6fGJX15C6pAyZT24+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042970; c=relaxed/simple;
	bh=hBBFZBmKbWmJHc6vGhmioiyoyMMl/7LaaxUCKb+yQno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MknJqBVcobn6Bc6iZ+xi1GF0C1Y21/sp4g12cLwZ2HWdKAzDOMBWGl+lzzsyIFyNkCKvMZM1rgXTZIAqU6Iz6+xAd/j+jAjOaPfhc7o/4WSSc86HeNM73Yt/ANnhnTMU/NAMclH1OtbW8SrfQdOCVDbFsbADGzLSp2cni8hmDSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-700cee3c5f6so115687a34.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042968; x=1720647768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZTio5F8p35DlD4asDjPvybCMwGfLPum9VeO2lVI5Tw=;
        b=aXgNHO+FIOkpy0LnFRrM0mNv0SV1ElD3TeMTPy75fx6F0PUd3Eq7k/vEaBwjCDR0AO
         Dw92oJmTqOXUu/tKgZPzh38c58IWSXdyYqZvKIzmNnE1rTUKElfAz1ribds5aP4abZRM
         Fe/83etAS0V6xpIApc72yNmcIuj7OxiA5GwPOapoyzH3WIBlehzb88DeELEc0DBnoUA4
         nJL0ic48anrNxemDRBCHLvtAkwwBai+E4YO0fJgX8V7Iiljr0jCEhgyzdtoAYxmZ5wph
         OVOSCGqPex1kjQOi7/SLIY0coR2BwVuzX2rYypCHiUf8Dp7EFzuvw56VF/l3Rf4MuurF
         0AGA==
X-Forwarded-Encrypted: i=1; AJvYcCXCKCUUMoshNtRpeZk33k6aGy5HWZuHDWMjxrHEaZDJ8mqUhzkkmDVACy9og+8LbIqTYD7eZWZ1liegpG+yAhZ+yLylrDvsIYyHIDitQtY=
X-Gm-Message-State: AOJu0Ywosod4w+SPq6BHkSAqvdK4CmXQcEjBRW04ZJW0oBWEX4ChbfHn
	G71BgaxHcXORuEG+ZthLoJWMCcAmXIzMSbbYNXqopILFHyeWWh3KJamCzft+
X-Google-Smtp-Source: AGHT+IGRunLO6mFzSc2Jy3s5TzQ57XC4kIYZhicOz2t0jYUM6P5DBFc/NWlT3v1DejDwVVb0J3v/0g==
X-Received: by 2002:a9d:6b15:0:b0:700:d428:1cd1 with SMTP id 46e09a7af769-702077756d3mr12771626a34.3.1720042968011;
        Wed, 03 Jul 2024 14:42:48 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:42:46 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 01/29] wifi: mt76: mt7925: update mt76_connac_mcu_uni_add_dev for MLO
Date: Wed,  3 Jul 2024 14:42:06 -0700
Message-Id: <6b2502d0c3a53093f83ae33329e9d782ba2465b3.1720042294.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1720042294.git.sean.wang@kernel.org>
References: <cover.1720042294.git.sean.wang@kernel.org>
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
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 4e3c8af98fe7..4dce03ddbfa4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1214,7 +1214,7 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
 	basic_req.basic.hw_bss_idx = idx;
 
-	memcpy(dev_req.tlv.omac_addr, bss_conf->vif->addr, ETH_ALEN);
+	memcpy(dev_req.tlv.omac_addr, bss_conf->addr, ETH_ALEN);
 
 	cmd = enable ? MCU_UNI_CMD(DEV_INFO_UPDATE) : MCU_UNI_CMD(BSS_INFO_UPDATE);
 	data = enable ? (void *)&dev_req : (void *)&basic_req;
-- 
2.25.1


