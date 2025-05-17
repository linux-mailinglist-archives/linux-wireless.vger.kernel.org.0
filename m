Return-Path: <linux-wireless+bounces-23113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0990ABAAE4
	for <lists+linux-wireless@lfdr.de>; Sat, 17 May 2025 17:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9267189110C
	for <lists+linux-wireless@lfdr.de>; Sat, 17 May 2025 15:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC22120127B;
	Sat, 17 May 2025 15:46:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142103EA63;
	Sat, 17 May 2025 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747496810; cv=none; b=MO00wExzs+Arr4Vl7mG0LBdTmsPPF7L6hxfFlA/hJNYH+VRZ0egX7qVm0DqhtJDfbOPJlgYxKIByEtCDplV092v12t9myBzZ5mplfd26yYok9TRlhZbhEgK5bhAswqvvT0XO5iALFp6IPuCSzFr68QtPqtLa4HMRLI0a2dYNauo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747496810; c=relaxed/simple;
	bh=B17RbtciEnVVEu7Dlw7ST4KzADZ1kSpxHtr6ZOzjFME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SPKqCMiuvuDD1ZQtgBa/ZDZ9y+orH+toOvTe8YtiD2ItWZQJA0GQbWhk9yNzAt9959gBGeqbjx2XqixRPsSQZeLFN5vGcglKI4ikVOyAmouiWR6FMCih7K6ij4CmK2HRg+swKqoIBv1X83bzwQbtoFE9yQa2qAplT+IqemL54vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.201.46.250])
	by APP-05 (Coremail) with SMTP id zQCowAB3tihZryhogGKtAA--.34380S2;
	Sat, 17 May 2025 23:46:34 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: ajay.kathat@microchip.com,
	claudiu.beznea@tuxon.dev,
	kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: wilc1000: Handle wilc_sdio_cmd52() failure in wilc_sdio_read_init()
Date: Sat, 17 May 2025 23:46:11 +0800
Message-ID: <20250517154611.910-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3tihZryhogGKtAA--.34380S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4fWFWxKF4fXw4UZFW5ZFb_yoW8XF1kpF
	WxurWYqw10kFWru3W7tFs5Aa4rJa4UtrW7WFWxuw1fur4kZr1Skr4fXa45Xr1qg3WUC3Wx
	Xw40vr4jgF1IvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVb
	kUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYFA2gopvIMOQAAst

The wilc_sdio_read_init() calls wilc_sdio_cmd52() but does not check the
return value. This could lead to execution with potentially invalid data
if wilc_sdio_cmd52() fails. A proper implementation can be found in
wilc_sdio_read_reg().

Add error handling for wilc_sdio_cmd52(). If wilc_sdio_cmd52() fails,
log an error message via dev_err().

Fixes: eda308be643f ("staging: wilc1000: refactor interrupt handling for sdio")
Cc: stable@vger.kernel.org # v5.7
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/wireless/microchip/wilc1000/sdio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index e7a2bc9f9902..d0e8b812b622 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -809,6 +809,7 @@ static int wilc_sdio_read_int(struct wilc *wilc, u32 *int_status)
 	u32 tmp;
 	u8 irq_flags;
 	struct sdio_cmd52 cmd;
+	int ret;
 
 	wilc_sdio_read_size(wilc, &tmp);
 
@@ -827,7 +828,12 @@ static int wilc_sdio_read_int(struct wilc *wilc, u32 *int_status)
 	cmd.raw = 0;
 	cmd.read_write = 0;
 	cmd.data = 0;
-	wilc_sdio_cmd52(wilc, &cmd);
+	ret = wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->devm, "Fail cmd 52, get IRQ register...\n");
+		return ret;
+	}
+
 	irq_flags = cmd.data;
 
 	if (sdio_priv->irq_gpio)
-- 
2.42.0.windows.2


