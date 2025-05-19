Return-Path: <linux-wireless+bounces-23139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04420ABB7AA
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 10:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16A197A6139
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 08:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A6926B97E;
	Mon, 19 May 2025 08:42:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE84B267B9F;
	Mon, 19 May 2025 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747644171; cv=none; b=cEsxP4i8p/TItq+rEUnuQ8sbHP19J/lHgK+pOiFPJObvStRmeGJg6uZsfMMUMDsUNZwfBcVNZMnmOsettoxsJRKM22mzBrNwfj9lw9eSX8SRHFQQnDvSQgbvjpkPDzn54i5i4aEYDtSfMWIwB99fZEBomUkAPqFNSEfAgf+MDJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747644171; c=relaxed/simple;
	bh=GDrbtMczbadqW+M8hR3/h5c36OlbYcm8zQPsfTySveY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dCJfGx+fropC49hDV82nvkOnxglF5sLnGkfLD3KE31/vNSbhJHeGnM8BttyIBnPMV4ZpNJ3BjahDcsfzmUMCX3+95489Bsn5hnpwHfc9URHb9rNXQ6R5TL9xpQobHuUq6pidUPyYltRxMGvEjO+WPqSHDyTzQDwnBD4i7Yg9SfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowAD3OSz_7ipoUmNrAQ--.11134S2;
	Mon, 19 May 2025 16:42:41 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: ajay.kathat@microchip.com,
	claudiu.beznea@tuxon.dev,
	kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] wifi: wilc1000: Add error handling for wilc_sdio_cmd52()
Date: Mon, 19 May 2025 16:42:11 +0800
Message-ID: <20250519084211.1752-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3OSz_7ipoUmNrAQ--.11134S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4fWFWxKF4fXw48JryUtrb_yoW8Ar1UpF
	Wxuw4jqwnIkrWrZw4xJF4kA3Z5tayvyrWUuFWxuw1fZr4kAw1S9r4fXFy5Xrn0q3W7Gw1x
	X3Wvqr4YgFn2yFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUf8nOUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRAHA2gqs4joywAAsH

The wilc_sdio_read_size() calls wilc_sdio_cmd52() but does not check the
return value. This could lead to execution with potentially invalid data
if wilc_sdio_cmd52() fails. A proper implementation can be found in
wilc_sdio_read_reg().

Add error handling for wilc_sdio_cmd52(). If wilc_sdio_cmd52() fails,
log an error message via dev_err().

Fixes: ea5779b4fbc7 ("staging: wilc1000: wilc_sdio_cmd52: pass struct wilc")
Cc: stable@vger.kernel.org # v4.5
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
v3: Remove redundant error log. Fix code error. Fix fixes flag error.
v2: Fix code error.

 drivers/net/wireless/microchip/wilc1000/sdio.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 5262c8846c13..d77f88996250 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -771,6 +771,7 @@ static int wilc_sdio_read_size(struct wilc *wilc, u32 *size)
 {
 	u32 tmp;
 	struct sdio_cmd52 cmd;
+	int ret;
 
 	/**
 	 *      Read DMA count in words
@@ -780,12 +781,16 @@ static int wilc_sdio_read_size(struct wilc *wilc, u32 *size)
 	cmd.raw = 0;
 	cmd.address = WILC_SDIO_INTERRUPT_DATA_SZ_REG;
 	cmd.data = 0;
-	wilc_sdio_cmd52(wilc, &cmd);
+	ret = wilc_sdio_cmd52(wilc, &cmd);
+	if (ret)
+		return ret;
 	tmp = cmd.data;
 
 	cmd.address = WILC_SDIO_INTERRUPT_DATA_SZ_REG + 1;
 	cmd.data = 0;
-	wilc_sdio_cmd52(wilc, &cmd);
+	ret = wilc_sdio_cmd52(wilc, &cmd);
+	if (ret)
+		return ret;
 	tmp |= (cmd.data << 8);
 
 	*size = tmp;
-- 
2.42.0.windows.2


