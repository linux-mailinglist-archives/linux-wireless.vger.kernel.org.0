Return-Path: <linux-wireless+bounces-23066-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A48CAB97D5
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 10:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713E33ACA0D
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 08:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E620C22D7AD;
	Fri, 16 May 2025 08:39:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AB7282E1;
	Fri, 16 May 2025 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747384766; cv=none; b=Cmjf4jBseqx5p0FaDvYAIgjmtdQ6pF06YK/O/Cl7kUkr5GmbDeaOAWCaZnPFU9l+A780qiBSX1Ap8j1db7+ncI65M1Bwb+2kaZcyoRJcx2scLdMCt+jrk6d2L/e+yzZyfp8RGoen60G8Qzl8IITBl841+2u3TTOw0JAMpG1drlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747384766; c=relaxed/simple;
	bh=RYjeXy5eHZRl5Mt/8DZrayKgM7iSHvClpWchztY8Rac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k5PE1JWQC41HFmaVAUD3Wg4a4j3Qi3lkZRfIlrITdCqz2GAqpyvejlf3m4SkzAC1Ud3RaO8aRFh9llNx1vBAUX0eRidKfHZoiIGDz2PODK2+E+pQpLa9czUGD5U7SUCHdfZyNpsMRPwaGd/NTZsI0b66oty8fCcQydn8jMv484M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowAA3pkKt+SZoThhgFg--.38627S2;
	Fri, 16 May 2025 16:39:13 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: ajay.kathat@microchip.com,
	claudiu.beznea@tuxon.dev,
	kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: wilc1000: Add error handling for wilc_sdio_cmd52()
Date: Fri, 16 May 2025 16:38:41 +0800
Message-ID: <20250516083842.903-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAA3pkKt+SZoThhgFg--.38627S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4fWFWxKF4fXFW7AF1fWFg_yoW8Cr4rpF
	WxWr4Yqw1qkrWrZw17JFsYyF95ta4ktrWUuFWI9w1rZr4kZw1Skr4fXFy5Xrn0q3W7Cw18
	Xr1vqF4jgF10vFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JU7KsbUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwkEA2gmkZXk+wABsd

The wilc_sdio_read_size() calls wilc_sdio_cmd52() but does not check the
return value. This could lead to execution with potentially invalid data
if wilc_sdio_cmd52() fails. A proper implementation can be found in
wilc_sdio_read_reg().

Add error handling for wilc_sdio_cmd52(). If wilc_sdio_cmd52() fails,
log an error message via dev_err().

Fixes: 0e1af73ddeb9 ("staging/wilc1000: use proper naming for global symbols")
Cc: stable@vger.kernel.org # v4.15
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/wireless/microchip/wilc1000/sdio.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 5262c8846c13..e7a2bc9f9902 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -771,6 +771,8 @@ static int wilc_sdio_read_size(struct wilc *wilc, u32 *size)
 {
 	u32 tmp;
 	struct sdio_cmd52 cmd;
+	struct sdio_func *func = dev_to_sdio_func(wilc->dev);
+	int ret;
 
 	/**
 	 *      Read DMA count in words
@@ -780,12 +782,20 @@ static int wilc_sdio_read_size(struct wilc *wilc, u32 *size)
 	cmd.raw = 0;
 	cmd.address = WILC_SDIO_INTERRUPT_DATA_SZ_REG;
 	cmd.data = 0;
-	wilc_sdio_cmd52(wilc, &cmd);
+	ret = wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->devm, "Fail cmd 52, interrupt data register...\n");
+		return ret;
+	}
 	tmp = cmd.data;
 
 	cmd.address = WILC_SDIO_INTERRUPT_DATA_SZ_REG + 1;
 	cmd.data = 0;
-	wilc_sdio_cmd52(wilc, &cmd);
+	ret = wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->devm, "Fail cmd 52, interrupt data register...\n");
+		return ret;
+	}
 	tmp |= (cmd.data << 8);
 
 	*size = tmp;
-- 
2.42.0.windows.2


