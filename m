Return-Path: <linux-wireless+bounces-3269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CBC84C451
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 06:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F975287CCC
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 05:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DB31CD1B;
	Wed,  7 Feb 2024 05:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b="XF7jgoom"
X-Original-To: linux-wireless@vger.kernel.org
Received: from o1.ptr2625.egauge.net (o1.ptr2625.egauge.net [167.89.112.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A498B1CD1E
	for <linux-wireless@vger.kernel.org>; Wed,  7 Feb 2024 05:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.112.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707282465; cv=none; b=L6c4OrpzEPd5UiDg3zWA361G2aKmMT9BxPcZfkJQnUgeva3HV3Mw/fsqhgaLyLqrWw9GlwM0Q8NojATIs+ud5Z5KNhA6AR1mhULdynAahn2oYsgrxgONjHzfQMA1pV3KAxzwOIOWuolpJsvjm9n8vQa+W435xiAzFqPY7j4XwcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707282465; c=relaxed/simple;
	bh=eZHUD0o+FDsi9Kcus4E2yOeijxfnXA5HbfNiYeTfq+Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=kwRJegRymTbB4opYjtNvamYScL3G/ZXVV2SpxJML5Y8xFTi7A2MZ6uPDwrUG/ThHwLmxJYUda00UUQRICr/bRxMUm6Tu9IVGOf926HudDfWCdnuRwbayEwdxVJhu6osyqbDS8WMXDD8qW/l4AsD2bQKM3PF3QqsFUOHLt62DObE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net; spf=pass smtp.mailfrom=em1190.egauge.net; dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b=XF7jgoom; arc=none smtp.client-ip=167.89.112.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1190.egauge.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
	h=from:subject:mime-version:to:cc:content-transfer-encoding:
	content-type:cc:content-type:from:subject:to;
	s=sgd; bh=t5uwWM1eFvhFbTRLCASmRjIfg1LO/x8XEpeX31o8lcQ=;
	b=XF7jgoomQjpyWXVqGDYr8JOoO/E/s6D5Y4iFeZddBeDtHOmdF/B+/5JRdSQOa4C2D/K8
	LBV0hxqDbQShwHxLKoQ+G5D1AFaQJVNkfa2BTQYPcfGWyU2F5Apx7eeJ+vPxiBDj3rQ4GM
	9aCQUYi9/HWvv14quMafg1hYeiZob/4DtYuFs3Rea/Oli0T8l91cSocYCI6RoVio4gkSRv
	7KSuMnvOrCm4Mwx5zASqhloS9ih6AUB7cwTw31rfcYUON+BInSPD14Mq96diXy/sCJiHxv
	5Vj6jy3yKjxcGvyTiFJua1yMaRBvRhoMvOHVO940KjsotrwuB1c7i3NlslYhmQgg==
Received: by filterdrecv-5bbdbb56cd-l76qx with SMTP id filterdrecv-5bbdbb56cd-l76qx-1-65C3101E-2
        2024-02-07 05:07:42.276640557 +0000 UTC m=+2303415.056742646
Received: from pearl.egauge.net (unknown)
	by geopod-ismtpd-8 (SG) with ESMTP
	id zOgGbdMgRKeHESz9OKhNFQ
	Wed, 07 Feb 2024 05:07:42.113 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
	id 331FB7008B0; Tue,  6 Feb 2024 22:07:41 -0700 (MST)
From: David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH] wifi: wilc1000: correct CRC7 calculation
Date: Wed, 07 Feb 2024 05:07:42 +0000 (UTC)
Message-Id: <20240207050736.2717641-1-davidm@egauge.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvKHe5FjBwGBVhJooE?=
 =?us-ascii?Q?iuLh3M0JFA+be6q9aU1e9QvgTYvN2FBlU+lYVC4?=
 =?us-ascii?Q?WQwCwnWPlZE8XH9x9VtFNOov+Wto9GyxKabS9h0?=
 =?us-ascii?Q?t0sWUhyLaYb6R7KlcEmYLfypOdkVd3rdZXEmrbl?=
 =?us-ascii?Q?MnBYCRNhBslyjDIzYBcBfyvZMSyAmjkwi8pY34o?=
 =?us-ascii?Q?QZgsz1cWQbVFRAUddFC2w=3D=3D?=
To: linux-wireless@vger.kernel.org
Cc: Ajay.Kathat@microchip.com, alexis.lothore@bootlin.com, kvalo@kernel.org,
	David Mosberger-Tang <davidm@egauge.net>
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii

Document

    ATWILC1000/ATWILC3000
    Baremetal Wi-Fi/BLE Link Controller Software Design Guide

    https://tinyurl.com/yer2xhyc

says that bit 0 of the CRC7 code must always be a 1.

I confirmed that today with a logic analyzer: setting bit 0 causes
wilc1000 to accept a command with CRC7 enabled, whereas clearing bit 0
causes wilc1000 to reject the command with a CRC error.

Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
---
 drivers/net/wireless/microchip/wilc1000/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index 7eb0f8a421a3..b9ed88d9c33d 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -472,7 +472,7 @@ static int spi_data_write(struct wilc *wilc, u8 *b, u32 sz)
  ********************************************/
 static u8 wilc_get_crc7(u8 *buffer, u32 len)
 {
-	return crc7_be(0xfe, buffer, len);
+	return crc7_be(0xfe, buffer, len) | 0x01;
 }
 
 static int wilc_spi_single_read(struct wilc *wilc, u8 cmd, u32 adr, void *b,
-- 
2.34.1


