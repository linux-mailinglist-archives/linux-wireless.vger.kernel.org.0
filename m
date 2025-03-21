Return-Path: <linux-wireless+bounces-20672-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C9CA6BD22
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 15:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E18A3BAE69
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 14:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6401DACB1;
	Fri, 21 Mar 2025 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yRwH971U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621BC1D86F2
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567746; cv=none; b=RZerijH7wq+LgJ4rOT80jk+J9T9sYQKo3CEOpRM/ZpUccDTDioZ4GglRbOpxm43uA88ldB9BTOCVK1bKiMxfNFQiDiFq4T6RPytVn32CQSV4WWO4xo0Z3YdSMFYGDIZj2FvOgBzx7G46aTs0TDup97WJw/CQvgDca8LDz8raDB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567746; c=relaxed/simple;
	bh=unOxx1FBF35f82m52qxSk7k7s5uAwciJ4IP8upP94sU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IxfbG6XUW1U/XtCbbWEJX34ixUzJyjZN1VDHD2qCL1HjrACs+HLRU80pF490ApWVnhucOATJehyclnGo7Uma3bvbm44Li28hQu6p+3ualgA/U3AAE0CnIgy3D5LBN+A2GlnexSmmqRdsJ1igHtNr8jvASbZvOLxgVrWj6+6t6Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yRwH971U; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so1264799f8f.2
        for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 07:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567743; x=1743172543; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ReU01VkkdQwGejdvSqZN3T6tHm1DJDLTnc3Lm0Bnfgg=;
        b=yRwH971Uj/aI2r211Naevx8knD2GRJvk1ZMlqlmq4RJrnEG5J0ZmcT2AN5ZTxWxzfB
         9mZajiJVgxgS4FhHnQg/VM9E14qwFLtWNjRWuM0T5x6PftQgzjNE8vEdPvgL23QZ2Bif
         RN+mmLkTdwQ7h9vlS5SUF18H+rWTxrSd8iCyKF0yPFK1j6UASVmLsRzoFIguSZBxLdBu
         mrLZMJ7vVvefvJtc77P7idyWYHjAC7FnrPIqeJ+YhsBtprw/0I/ut7+rioSb+dS6hV1g
         QMq27HndM1vw01XJEIstNt8xA3csvpt0kPF67kXrDdrF6hbDwTE2pKz8gfLDd0eeKoN5
         BLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567743; x=1743172543;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ReU01VkkdQwGejdvSqZN3T6tHm1DJDLTnc3Lm0Bnfgg=;
        b=DvMGSnsCZSfpCDlCNzaxVPbxhUB8QaDfAqsVptN7LYTcJlj3SMyfeu82eMR+TlIiBT
         +7fljtQ7HGwLMVNJ1rC3sP4iifvuTrbnYvhTD0i3sduewom7YXNJQBt7T4CNcqAr3wTH
         LT+WYk83xeDefDIz2fwOnj28QBbU3WM85DJZhFF3ZDeszUp3FeXVd2rjChniDR6FtdLH
         IFZ1Wc2S0Vwg5O2qpA4NxBshexHCvo1PoQ5al1+cN5MQM/zuZEcfCKtdRhS3gREiZq7/
         2Jiwh991pyCQl3Zcub3R5hgJ7dbjiuaRtvqfBuOi4JVV0TGKyx3RDoHOwk0nrC4wjVFC
         7Wtg==
X-Forwarded-Encrypted: i=1; AJvYcCU0O85q1BTVT5YCbGraQcQP6JBbmTinL+GGu+Wo9N2SzZZWKNyfUxLWqjXT1C2MMvFSjN0W/f4eckk8QLef0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxT4zFgjqdoV7W1iMgHyPGAFoZdyvhEXkoGesg8cqCV+Mk39u7Q
	miemBH7xDXfIafG+i/vA8YvY2btfP93df1chrccZAna9sSoVeCz5t4VVKjLFLkw=
X-Gm-Gg: ASbGncvFAdeeg9RkeC9URX78R2k3DEydM1D7yPyoFlkT2YCg47eICoH8frRZBpAVx9H
	jq6W3mjyOmlBf9DwdU9s9Qyf/mAmWRai83m0TqtNP1ku1y7Uz9Gd97SRE63g1jfHyuXZb36vQBX
	UHN0hRELuon/MxM62zWvt7TfyI2UaonynKzjSWF77gPwFp311e+Ya3ExCiQ7mMvSo0n3csoju4F
	JAyXw7rElvIb96tPixuq9HP1VRgQsdTKDkkjpXeRFVzD1yFNauL/h7GIlbYJ+pvtIz1U53r/SCt
	QpYhs58e6p/vGuwYYn+oPned7aIawjcoP7b3k1fPlWF755tFhQ==
X-Google-Smtp-Source: AGHT+IGhlqCe2mLQ6QE1+jNsut/3HpyriKLoQPJNlU/O0xCCy9UTKeLE9FjCB0uErwEBPN5BJ/Tizg==
X-Received: by 2002:a5d:5f8c:0:b0:390:e7c1:59d3 with SMTP id ffacd0b85a97d-3997f8ee934mr2979865f8f.2.1742567742643;
        Fri, 21 Mar 2025 07:35:42 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f9957aasm2571305f8f.10.2025.03.21.07.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:35:42 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:35:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Quan Zhou <quan.zhou@mediatek.com>,
	Hao Zhang <hao.zhang@mediatek.com>,
	Allan Wang <allan.wang@mediatek.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] wifi: mt76: mt7925: Fix logical vs bitwise typo
Message-ID: <d323a443-4e81-4064-8563-b62274b53ef4@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This was supposed to be & instead of &&.

Fixes: f0317215b367 ("wifi: mt76: mt7925: add EHT control support based on the CLC data")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index 63cb08f4d87c..79639be0d29a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -89,7 +89,7 @@ void mt7925_regd_be_ctrl(struct mt792x_dev *dev, u8 *alpha2)
 		}
 
 		/* Check the last one */
-		if (rule->flag && BIT(0))
+		if (rule->flag & BIT(0))
 			break;
 
 		pos += sizeof(*rule);
-- 
2.47.2


