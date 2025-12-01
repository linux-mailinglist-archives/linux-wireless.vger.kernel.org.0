Return-Path: <linux-wireless+bounces-29439-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F7EC964F8
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Dec 2025 10:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B8934E13FC
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Dec 2025 09:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58682EC0B0;
	Mon,  1 Dec 2025 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNSHxVaB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57232FF15D
	for <linux-wireless@vger.kernel.org>; Mon,  1 Dec 2025 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764579824; cv=none; b=LjOtxskUGexdeRGTzlzRh6nrs0QbWxqnLuQvXwTzXIgHHh194YZuL3r4CIsuZzeSw702HTX+vovGqxKwdFOUYEugFEmAhRUcSRwdqo2vBDPnWDmx07lyis2bIUInGeSwJD/rkXHAFnvnePT80DMEff/z8ahJXJWSVB509sHmjFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764579824; c=relaxed/simple;
	bh=OENUUPVsybzTfsmwczvXbu6dAmQzUDri4hyNFGmPrF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OEQmt/+//r8pZyaY1bc5cPuZoxUwQsZT3sh08srjyEsBi17F7tYoh3F2eNPNDoD8KJ5vX3HGQnmpxtfpfavotv3MNjdvBZIih+wmwYL020MV4b9lkKbPuBPqpLqFZUc08PSD9rYrh/0s3yWg51xiF8yH4uQ88I1HmlXLCmga68E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNSHxVaB; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42e2e671521so656728f8f.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Dec 2025 01:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764579821; x=1765184621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N8ah7K9QBZgVHJunjh/RbCQgoXUT9r/YcIZqeujeIYI=;
        b=cNSHxVaBlQNXG7PlbsWVcCW6swfsGSmRBXsAKzxJAsmzaUfQ8dTn0gdsYzirRGz/Sd
         l9yjkmLvejsy56FFT7mS4vePx9zRvQ6OmX2mG9v+sw+CoDSU10HFa5o333M8CLWIDWrq
         x7RZqWTTolBKvsCWdcUyUsA024xoUXaSnefQSP8D3NRQMo861krQmWDmts2u136hqzjq
         x+jhUG5xChZJbuYEIg5IYrgwCZv9P3XAebvLBrrIgTOeEvqb0HZBqERrKWri3ihVfyeL
         1UFDSkca4NFWuki1hI+Leh62n6VAqQAwmHtjVsEpWQs5ERJZhxCG6j/vF28+3k9Y62bZ
         oWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764579821; x=1765184621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8ah7K9QBZgVHJunjh/RbCQgoXUT9r/YcIZqeujeIYI=;
        b=lZme/QPYooTa0xFvf8QWeOLnPoeA73Yg7gIrxs/yuaw/zeuXgnFZCDdZELMBLeEnDQ
         gJVc4FwbVZG5x4Ry11Nn1V1VNUe8aPBT/mR/NahtY97CgjgKWN+osyTxenOZp+O0jyGo
         fGG2Fq3NETyc8WHavTeBy4p/IF+gsBVKhapsohIaZL/lkzRxMbyPUSCW4ax8QxWrtu/d
         tAWwLbFxORrH2vMaC8t/Kd5DAilABnQz/OfjSOeOdQ+jxPtPE8L9+9duwFp1dJbrYdjY
         dcauCYu23vV09MN7fa8scTzpKTPYVoFSsX9lWnQoPeJpcjD+ZGuHeGLNLWypvHuJP0Z/
         7nqg==
X-Forwarded-Encrypted: i=1; AJvYcCWk0K5QyjhywcNM90gg+lNrPJwhX5hkQ9zhqQyKgsn8HY998HZ3f1/ZTTz5uil6UmAFIW5gJ0NGQeW0X/lK/w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4TpZF8vF4Xn+Fp96yd/HqMd6iYGsPjfSISUKMSAdrjZswLZpk
	vVTuo+EJ5Iryxd8N/R4S/7iLwOgUePq+V6n3d3jICxNa/Y3TvA9KP666
X-Gm-Gg: ASbGncuXT27kWiosONnxSNb9ClnGJFjOgvezQqr8+s4oBapTiW6EyYI4Fb55Y1gCMSR
	HTJfOcLkVEVLbrqoWpeqsY99NVPY9Qwje5RnXtviVYAcb3LhUaS5hMLYz1UyjvQc/CxbBp1hsGr
	fhThuxLUD5VrreYqjmsO8Q8VqRvX2ARAtX934U6aqVue7t6+++2SHiwHdwa3LNOAqdqsTzXYA9V
	zVlYhozaDfBUnTkhwV89P45fFLJpt6ux/K3xGzD1PcMPHygkXMw4l/+stPf2fOBLCTGw9kTunuv
	i/jZfoou+HO/opfCm+eZ9741NSN/MCoZHA+k0Ev51IxxlJWbACnfHUX8ZmwB4nZoF2xQvWXAA/u
	xApDXQcGIojUWotQoMY+junFHhpQVTGyGwFYQjna2S8Zx8usDwOqSgYVGglRcdMknkGiy6lqcfj
	4N/5hD0mgJ5tx98HA=
X-Google-Smtp-Source: AGHT+IEcydTcIwCjbQRB0nGuzNXPZzp8lCn4+RYJcX/cAtCDjD/66keOoi6DpdWSWTOQpt+wcZtEcg==
X-Received: by 2002:a05:6000:186a:b0:429:ee71:2ff0 with SMTP id ffacd0b85a97d-42e0f362435mr27273212f8f.53.1764579820669;
        Mon, 01 Dec 2025 01:03:40 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d607csm25334499f8f.15.2025.12.01.01.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 01:03:40 -0800 (PST)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH] wifi: mt7601u: check multiple firmware paths
Date: Mon,  1 Dec 2025 09:03:36 +0000
Message-Id: <20251201090336.1157193-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The linux-firmware repo moved mt7601u.bin from the root folder to
the mediatek sub-folder some time ago, but not all distros create
symlinks to the old location the driver checks. Update the driver
to check for firmware in both old and new locations.

With firmware in /usr/lib/firmware/mediatek/mt7601u.bin):

kernel: mt7601u 1-1.3:1.0: ASIC revision: 76010001 MAC revision: 76010500
kernel: mt7601u 1-1.3:1.0: Direct firmware load for mt7601u.bin failed with error -2
kernel: mt7601u 1-1.3:1.0: probe with driver mt7601u failed with error -2

And with the patch:

kernel: mt7601u 1-1.3:1.0: ASIC revision: 76010001 MAC revision: 76010500
kernel: mt7601u 1-1.3:1.0: Firmware Version: 0.1.00 Build: 7640 Build time: 201302052146
kernel: mt7601u 1-1.3:1.0: EEPROM ver:0c fae:00

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
The firmware was moved in [0]. Changes were requested to a previous
patch [1] but I wasn't able to find a follow-up submission from the
original author. So here's my novice attempt at the improvement.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/?id=8451c2b1d529dc1a49328ac9235d3cf5bb8a8fcb
[1] https://patchwork.kernel.org/project/linux-wireless/patch/fefcbf36f13873ae0d97438a0156b87e7e1ae64e.1684191377.git.daniel@makrotopia.org/

 drivers/net/wireless/mediatek/mt7601u/mcu.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt7601u/mcu.c b/drivers/net/wireless/mediatek/mt7601u/mcu.c
index 1b5cc271a9e1..c771bbf7952c 100644
--- a/drivers/net/wireless/mediatek/mt7601u/mcu.c
+++ b/drivers/net/wireless/mediatek/mt7601u/mcu.c
@@ -409,6 +409,11 @@ static int mt7601u_load_firmware(struct mt7601u_dev *dev)
 	const struct mt76_fw_header *hdr;
 	int len, ret;
 	u32 val;
+	const char *fw_paths[] = {
+		"mediatek/" MT7601U_FIRMWARE,
+		MT7601U_FIRMWARE,
+	};
+	int i;
 
 	mt7601u_wr(dev, MT_USB_DMA_CFG, (MT_USB_DMA_CFG_RX_BULK_EN |
 					 MT_USB_DMA_CFG_TX_BULK_EN));
@@ -416,7 +421,14 @@ static int mt7601u_load_firmware(struct mt7601u_dev *dev)
 	if (firmware_running(dev))
 		return firmware_request_cache(dev->dev, MT7601U_FIRMWARE);
 
-	ret = request_firmware(&fw, MT7601U_FIRMWARE, dev->dev);
+	/* Try loading firmware from multiple locations */
+	fw = NULL;
+	for (i = 0; i < ARRAY_SIZE(fw_paths); i++) {
+		ret = request_firmware(&fw, fw_paths[i], dev->dev);
+		if (ret == 0)
+			break;
+	}
+
 	if (ret)
 		return ret;
 
-- 
2.34.1

