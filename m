Return-Path: <linux-wireless+bounces-23135-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F40ABB301
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 03:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936A5170670
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 01:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B544A1A5B84;
	Mon, 19 May 2025 01:54:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521DE18C004;
	Mon, 19 May 2025 01:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747619686; cv=none; b=Yf+/EQn9w4DxcsXKnp9MWzIRaHt8hVocBeV/dhkj8Fhy7V3HrZJmUQ85kLUd/uomd/zHrTZzJ/FcUd6Zj/qLohE/DAgr93cQsyQnS9wgoW6WIRXgks4ImyyGvH/uh2CnhbtM9VYuu3Gg3kY0/U0R/zcaNzK07B20yXlJM+6KYyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747619686; c=relaxed/simple;
	bh=QtUHOhPV0ehWeJwt6RG0Hz4M9XSUQwDisOX7ZGfog7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rtVbFx8HM7QkwqsTxB94jZr/EA1GuDjd1mqFswH7SAkJadIo3FWkjOo8SiK+bxXVKafOlTh5Uk9e804gnWROicrhMz26btv8FfA+lWLWGAoZw/OdVknTdVs2TgtP7JpXH8EyKQpkM7c3toWc+J5ckQSH6PZMXk6K/28Du3UwDOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowADn7PZcjypoMT1BAQ--.9661S2;
	Mon, 19 May 2025 09:54:36 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: ajay.kathat@microchip.com,
	claudiu.beznea@tuxon.dev,
	kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] wifi: wilc1000: Handle wilc_sdio_cmd52() failure in wilc_sdio_read_init()
Date: Mon, 19 May 2025 09:54:14 +0800
Message-ID: <20250519015415.966-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADn7PZcjypoMT1BAQ--.9661S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4fWFWxKF4fXw4UZFW5ZFb_yoW8XFy7pF
	WxurWYqw10kFWrZ3W7tFs5A3WrJa48trW7WFWxuw1fZr4kZr1fCr4fXa45Zr1qg3WUC3Wx
	Xw10vr4jgF1IyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUJOz3UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwsHA2gqdo5g3gAAsM

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
v2: Fix code error.

 drivers/net/wireless/microchip/wilc1000/sdio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 8ff49b08bbd2..e85aa5c605ef 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -808,6 +808,7 @@ static int wilc_sdio_read_int(struct wilc *wilc, u32 *int_status)
 	u32 tmp;
 	u8 irq_flags;
 	struct sdio_cmd52 cmd;
+	int ret;
 
 	wilc_sdio_read_size(wilc, &tmp);
 
@@ -826,7 +827,12 @@ static int wilc_sdio_read_int(struct wilc *wilc, u32 *int_status)
 	cmd.raw = 0;
 	cmd.read_write = 0;
 	cmd.data = 0;
-	wilc_sdio_cmd52(wilc, &cmd);
+	ret = wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->dev, "Fail cmd 52, get IRQ register...\n");
+		return ret;
+	}
+
 	irq_flags = cmd.data;
 
 	if (sdio_priv->irq_gpio)
-- 
2.42.0.windows.2


