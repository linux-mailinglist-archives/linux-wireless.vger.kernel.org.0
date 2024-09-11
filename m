Return-Path: <linux-wireless+bounces-12782-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A6D974BAC
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 09:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD331F291D3
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 07:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4142F41AAC;
	Wed, 11 Sep 2024 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U9Q3gFTZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E91E13B2A8
	for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2024 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040590; cv=none; b=T+RDVhvHMrXxcwUHkVyrgasxkPQ5nPOBy2Ta+H645rtPmpLoqHytLRefeG55AY7E7N3Ph8RCLyvd8rOKZf/yGBLGPHI2wB9Aw4rDdRj7BSoNaejQZL/xqZNP6d3z+mdcXOUccOP1G/7YKFEt3Cs0Ba24514LDIjgoS9t4Feotqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040590; c=relaxed/simple;
	bh=y6up1TEn4mGUO5E3alCcfTTaJPWeVhjSNuijasM6Hzo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xb5zFP+j72ktGc23kWAehAanEBVYeWGs/icIFdFgYxV/jgHSoos+fKdkmxwt+MAUByxBd7jo+vw88RKxuZbFo6Xf+T+SJBZpOtnaq49eTm5wuGhZh15GZiS2qlplYpJoQxT7u2PP+UB5AyoRjWqaQsorjrOiRJliCwOPfsWMqfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U9Q3gFTZ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374c84dcc90so3776717f8f.1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2024 00:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726040587; x=1726645387; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=As6Mh+lzj3Gz1WRcYQZrDI90Xpd0PmMaVKgj6FhuHj4=;
        b=U9Q3gFTZ1IbioGMTWVKQ4MRn10YaFqvlb5RRePchpiyrwBpJ+6RX4CT9TFiJ+YH2Wf
         vTpE0Xl62bTzLZ1dFLL2qSZQueOfNiWANpWFjawWz6ckmzJqS0Tl/O1ume49SJofsu0v
         ugnFeILSwNr2jnyb2W1GjS4WOULuZgiiwKnb8Ojy4Kkgf2lTpsdh4rc+2tBYYnmjtZAz
         QM/0AOT3jbBWPdVbKbW1rb+za8VHG62Q7GXvbd+G9Et4WS/1ZS9xCd0CEU5HctLu+XJS
         liocgOvHKHuvZF99+w1SrroNvFvYrHDC0/CAWc/Yqtr5QGfdfwzf1PcWE2+gsbWASmDR
         HujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726040587; x=1726645387;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=As6Mh+lzj3Gz1WRcYQZrDI90Xpd0PmMaVKgj6FhuHj4=;
        b=C781sGYE3YAKgDdGoSWCvkB3iHROwHL4Y8ELZMWLCPJ3NyAIfcKTjdOe/nUlQQWVcW
         mbT37cn0c6cTlYqFUpYBKZjyQhb9YgJW/oKA3l9/ioGuzIZDIcjF91AysqOoStvn+1NJ
         73xD2soThAEwHa26FV9H0RVgIw7LVUiMnTIRuqgpiznswq6Qwg+W52tmjWbywh1uRg0R
         4zotm8Uy3r0rQ2ORSslfKUPZ0c1ksLUNp3UFvHtp0LuXQ55OHoJravoj7euMTDWj9QoP
         LofEptOSXgtxBG/N0dh86uENBeseFN7mhVm/Sgzl/EntDoSe9iDzrzdZNK+VLsQimuvF
         jgnA==
X-Forwarded-Encrypted: i=1; AJvYcCUTnwoK9O3b4jqDpH1p00vlLd0vvLXPVfySK0MqMZgPGdChqCPEB7OySgnGJFgqbUwFQgfduAE7ISQ2fvPS2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzmakx3Ev0A69XWX857Mp16y5p+Qn9SvL9u+ffqARoSS6ONHbU
	hMHCtC+WXqUbrZpufPsCnbQtU2fekzdLpn/a4rOcM/euw/iQjYh2iOg07vJUTDY=
X-Google-Smtp-Source: AGHT+IHOJBC9xWxtEz333I412PsRAnwCCXfRzkH+Q812eYtVEcfH3PlSFuvh4othUga0PEr6w0xhXg==
X-Received: by 2002:adf:f4cc:0:b0:371:86bc:6c05 with SMTP id ffacd0b85a97d-378895c31ddmr9796759f8f.10.1726040586743;
        Wed, 11 Sep 2024 00:43:06 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956e8a98sm10786306f8f.117.2024.09.11.00.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:43:06 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:43:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Deren Wu <deren.wu@mediatek.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] wifi: mt76: mt7925: fix off by one in mt7925_load_clc()
Message-ID: <84bf5dd2-2fe3-4410-a7af-ae841e41082a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This comparison should be >= instead of > to prevent an out of bounds
read and write.

Fixes: 9679ca7326e5 ("wifi: mt76: mt7925: fix a potential array-index-out-of-bounds issue for clc")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 748ea6adbc6b..0c2a2337c313 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -638,7 +638,7 @@ static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
 	for (offset = 0; offset < len; offset += le32_to_cpu(clc->len)) {
 		clc = (const struct mt7925_clc *)(clc_base + offset);
 
-		if (clc->idx > ARRAY_SIZE(phy->clc))
+		if (clc->idx >= ARRAY_SIZE(phy->clc))
 			break;
 
 		/* do not init buf again if chip reset triggered */
-- 
2.45.2


