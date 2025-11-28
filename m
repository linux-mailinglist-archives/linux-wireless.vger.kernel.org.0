Return-Path: <linux-wireless+bounces-29421-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CE9C92D21
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 18:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B894E3AA51E
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 17:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05B329D275;
	Fri, 28 Nov 2025 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JN36sN/0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1282550A4
	for <linux-wireless@vger.kernel.org>; Fri, 28 Nov 2025 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764351927; cv=none; b=Fxgo5Dp9Bbgy1Qn0mDW4PinbHq2/JAgHRzRLZiH7CubzF22SQMjmEWrkEp+OD1snws2s1PYXb4N9GegGEyejgYrB5u5h+j8+uFO1WKekieXXwqZZqeYCMjTu6l9hmabbYWkvhuNz3MaQtKAlXqhukNNf/0lzzfaCylNNrYkAUFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764351927; c=relaxed/simple;
	bh=cinn32iWphnWN8tkX8ucGWRbObOOYK553n/IUZDTZQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hYD+j5NeKD77eNOjFYWi/b7YibkXGhE9lkyGIUZH3R5d+9Hcv0k/yG1Ud6atSzzyva8dXX9LoscGzHb5dQZqpRWpT6AXvavfVsefuDGhJUuIWDygHTpZdfKbsHqEPEEWnGj3611OlPZCWoNUg19gWqX/Bxtti7jjKuqxqdKgt24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JN36sN/0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477770019e4so16827855e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 28 Nov 2025 09:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764351924; x=1764956724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lSM32csH2X23xXw6xgAstXFSe1ZcOlrmsYctqKwHp88=;
        b=JN36sN/0Albrxkp0J67v9tgCcxOMaw2kpFRHYBYnxeGTFE9Jq2zXdIW11uL21T7DkQ
         A2xe+GWHeCkx3NUPqfUcdlrC1ixAyE7ENOPGnzVBVRCdHSgS3OVba9wn4kuXeFxMyRCq
         it4lX5BBYT0fd975Lo56Uu9L8fmLFWtHDqG4wRZaLY4rK6WAxyDOL8O4GJi44AahhvIr
         wV9IwAX0XDMH9bETHnKHh+m73Nhcatr2p+H9oa+kWl2gpZ767bV0/JHCStaqhtCsy1nX
         ahJ7H4B28RJtbsvMgIhd/3dqR4jB5OUhY6cvp3JiDT0PvvEeFPNmae9AaZsUy0zDJfz+
         5g5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764351924; x=1764956724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSM32csH2X23xXw6xgAstXFSe1ZcOlrmsYctqKwHp88=;
        b=PDSTfv4r8Xf8CRfK2KYmYx4O951h/9y8DSwUYjYZtsSxKT4e5hK6dIrOnbORavb8sD
         BlUeN7PzZIdFRGOLMXF9MjpvMjPWenVQbOkvLDcT/5INR5NC58zM+yOZv7u07SmmcDdP
         91AjG+ZquBduVghc1gkkgud4errDhZWf3YIIFELX1AFxZHvRTU0lrEquCo0q7uURjZHS
         ov8xjBW36iZN05oEDPj9SRsOI3nNo+WBfrzynfXz6zRV0xAE5BPb7jwP5urYo4GY9lRC
         QPjOcRvvV7OVTzUKyTJscvzD0hFpkr3Qd5wEJ6XooZNY5CViuAATwellRq/ia+MjnZ9c
         GbJA==
X-Forwarded-Encrypted: i=1; AJvYcCXtSlOB7KkUMCsYMapgNQUPX5iDCUEg/jeDI3mtnF/MxISaVRUEDId/sGbwIcRfNhxv0KtEM+H81mifM+0p3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpSJlJBtffcy+qth9fIphYcnC/wunflsqxr26MckIdUIf/mKWS
	OML9ayu7xx/5CGgh44vOmZtBeMhdw0gM9CzlBBOsJrjWcTiliEWA7SyB
X-Gm-Gg: ASbGnctNBXJOxliWgmFiVVH1RjjzzrdmWu/AcIoZdcqV7pSPL3HqFqCz2/EGSaOUdMs
	1xKZLSGMcX4TCQo+gZogC9c0TTRuCOkBLA5ZDfQ82I80Ww9br5gafCfxN6sOYOFs7ue43vEQ69F
	3ChpwHAOC0tZ3eE/8AZQj1fsbVUlJ9B3Pkn22wG8iaBSbQx8lky95qzu6iAV74bX6r+elbBpQSI
	KliGqMwMDV7nFu9CWyGRCyDR0+lxX8+C1HdbFjAU6eVmsoQiqVC+c8OSl/xUAJjfOACRRerWvMs
	qYufUmqdQCCou3EJRLKIEWxITpkGZpucJfN6eegbSZ/7MmXY09M/ey9VAhukNrior8H5LX9by8D
	vNIrfRCCt5UqeCswMFXycDWG3drD98m8Z6MsQMVwbaq7pd02YtywR7aQNCfGD5tGLY6SNVQmJ2v
	71NVDssiwlMZFQtaxpUMzq
X-Google-Smtp-Source: AGHT+IGr8jf1cEOxcEb6EeKeJchwsXTCgWnn9x2mUsKIoWiq9E4Ha2G7avXXtjB+xtyEdcahgOM1nA==
X-Received: by 2002:a05:600c:46d2:b0:477:54cd:2030 with SMTP id 5b1f17b1804b1-47904b1afcemr162142095e9.21.1764351924189;
        Fri, 28 Nov 2025 09:45:24 -0800 (PST)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42e1c5c3c8csm13452898f8f.2.2025.11.28.09.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 09:45:23 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] wifi: mt76: mt7996: Fix spelling mistake "retriving" -> "retrieving"
Date: Fri, 28 Nov 2025 17:44:30 +0000
Message-ID: <20251128174430.318838-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are a handful of spelling mistakes in various warning messages.
Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/npu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/npu.c b/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
index 29bb735da4cb..1422533e59c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
@@ -120,7 +120,7 @@ static int mt7996_npu_rxd_init(struct mt7996_dev *dev, struct airoha_npu *npu)
 			       &val, GFP_KERNEL);
 	if (err) {
 		dev_warn(dev->mt76.dev,
-			 "failed retriving NPU wlan rx ring0 addr\n");
+			 "failed retrieving NPU wlan rx ring0 addr\n");
 		return err;
 	}
 	writel(val, &dev->mt76.q_rx[MT_RXQ_RRO_BAND0].regs->desc_base);
@@ -129,7 +129,7 @@ static int mt7996_npu_rxd_init(struct mt7996_dev *dev, struct airoha_npu *npu)
 			       &val, GFP_KERNEL);
 	if (err) {
 		dev_warn(dev->mt76.dev,
-			 "failed retriving NPU wlan rx ring1 addr\n");
+			 "failed retrieving NPU wlan rx ring1 addr\n");
 		return err;
 	}
 	writel(val, &dev->mt76.q_rx[MT_RXQ_RRO_BAND1].regs->desc_base);
@@ -138,7 +138,7 @@ static int mt7996_npu_rxd_init(struct mt7996_dev *dev, struct airoha_npu *npu)
 			       &val, GFP_KERNEL);
 	if (err) {
 		dev_warn(dev->mt76.dev,
-			 "failed retriving NPU wlan rxdmad_c ring addr\n");
+			 "failed retrieving NPU wlan rxdmad_c ring addr\n");
 		return err;
 	}
 	writel(val, &dev->mt76.q_rx[MT_RXQ_RRO_RXDMAD_C].regs->desc_base);
@@ -159,7 +159,7 @@ static int mt7996_npu_txd_init(struct mt7996_dev *dev, struct airoha_npu *npu)
 				       &val, GFP_KERNEL);
 		if (err) {
 			dev_warn(dev->mt76.dev,
-				 "failed retriving NPU wlan tx ring addr\n");
+				 "failed retrieving NPU wlan tx ring addr\n");
 			return err;
 		}
 		writel(val, &dev->mt76.phys[i]->q_tx[0]->regs->desc_base);
-- 
2.51.0


