Return-Path: <linux-wireless+bounces-23134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8185ABB2F3
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 03:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D871C1894AE6
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 01:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE371B532F;
	Mon, 19 May 2025 01:45:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97E4189F3B;
	Mon, 19 May 2025 01:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747619107; cv=none; b=gAedRx/tzp5nvIPd84p/tzGywH6Gg8TFShUGyekBmt8Oy0oqAkuX/ut8tnE69TChBwftb3WcMS0o0dLJfkY+iVZZY39BgwcSf5TDV4ikA7mLBDTNeRnBhmsGeUR1fVXpQUDVeI06OdkzWPuZfwv3isbWASVsQTn7APZ6sYyo7Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747619107; c=relaxed/simple;
	bh=mkXiKGazl8RhlDprzmRKeQK2jbkx6SSl5MrzY8BDARg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nu4L8HPIwJHMzq5y4jKSoVPaAfhkHY6Oe9IxYMqWGRncQUOYLbDOxDtcW9Wihp+pU5tW5q0kO2Et5Js0IrPAadno9tFThZnlhkbLowgvVdqjjzCPXJ4sDH7Vqx+Ey+LrqaqUhbG6xcWklS57Z6cHAlc1fmhulSvlXyeyynkGCL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowADX6vUXjSpowbhAAQ--.9555S2;
	Mon, 19 May 2025 09:44:57 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: ajay.kathat@microchip.com,
	claudiu.beznea@tuxon.dev,
	kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] wifi: wilc1000: Add error handling for wilc_sdio_cmd52()
Date: Mon, 19 May 2025 09:44:33 +0800
Message-ID: <20250519014434.901-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADX6vUXjSpowbhAAQ--.9555S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4fWFWxKF4fXFW7AF1fWFg_yoW8Cr4DpF
	WxWr4Yqw1qkrWrZw17JF4vyFn5tFy8trWUuFW09w1fZr4kZw1Skr4fXFy5Xrn0q3ZrCw18
	Xr10vF4jgF10yFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVb
	kUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ8HA2gqddc7ZQABs9

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
v2: Fix code error.

 drivers/net/wireless/microchip/wilc1000/sdio.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 5262c8846c13..8ff49b08bbd2 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -771,6 +771,7 @@ static int wilc_sdio_read_size(struct wilc *wilc, u32 *size)
 {
 	u32 tmp;
 	struct sdio_cmd52 cmd;
+	struct sdio_func *func = dev_to_sdio_func(wilc->dev);
 
 	/**
 	 *      Read DMA count in words
@@ -780,12 +781,20 @@ static int wilc_sdio_read_size(struct wilc *wilc, u32 *size)
 	cmd.raw = 0;
 	cmd.address = WILC_SDIO_INTERRUPT_DATA_SZ_REG;
 	cmd.data = 0;
-	wilc_sdio_cmd52(wilc, &cmd);
+	ret = wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->dev, "Fail cmd 52, interrupt data register...\n");
+		return ret;
+	}
 	tmp = cmd.data;
 
 	cmd.address = WILC_SDIO_INTERRUPT_DATA_SZ_REG + 1;
 	cmd.data = 0;
-	wilc_sdio_cmd52(wilc, &cmd);
+	ret = wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->dev, "Fail cmd 52, interrupt data register...\n");
+		return ret;
+	}
 	tmp |= (cmd.data << 8);
 
 	*size = tmp;
-- 
2.42.0.windows.2


