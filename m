Return-Path: <linux-wireless+bounces-11758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8C795A4C4
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 20:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EEB7B21191
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 18:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FED5157E62;
	Wed, 21 Aug 2024 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Iut0DTIQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62491D131A
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724265456; cv=none; b=NdV8ZCYvpqDUnRPEf6fwH5ys/XKO2idLp6VIeabiXs/GCuYU+KybDyCnN+WQtbsDNIUXjhYAcQQkp6fmViF6kvOQwl6x22L5xp3DzRciqOoChui/mcNuq7vXNUDbwyLzsSYfN8Yr16foGpEUWoqdyx0cQ3sfn/YdFs2AYi4XHVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724265456; c=relaxed/simple;
	bh=MSUAylMFmOZmlg+V9xaszTMsdQqvJ/5hwYW9E56YF+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s4AwRJYiJHf3uYtp4csSrn6lCJraULesFQ6PgyJZxTKc46EJAmH1r4HJRyvbLeJ+Q1sDca/zQSAB4ztNBPJXjKMBYRVuLPsHZulaRNy7KTSZJi4X8wY9K2EzB1eqJ8o6Jmf/QgBb00mprdsEdhcqIdcU+MDm8vkZ/EmggyLGjEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Iut0DTIQ; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id E7FAC889A2;
	Wed, 21 Aug 2024 20:37:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724265453;
	bh=PWtSoWK/N5fxylpswoonWpg+fMRxlb4trtn5A3Y6Swk=;
	h=From:To:Cc:Subject:Date:From;
	b=Iut0DTIQOQtnsrF4vtijyNUHCdgDs94fHz83eRW+deUNyqhQ223kjYf12DUz7U8iO
	 j0H9vqaDCu0usAzHz5RgylC4z7Z8EBz4SHWu5yiFXfxaL3Q30jRBrRwq08XzJNvfTg
	 FZyr9OWSM+lgjLBkThNguvB5VnVdeSl31VcJM0XTBJhTNNrU0g/PWA6jONil1BcRbK
	 /tgWJgdyWA41pZbNjwveSTWiaPuLZ0XigwM6Dn+pgcZge7MtZRIaKUuhcUwoqmm3Ig
	 eZlSn+HvMNSHi749exycxP2HHZuo+I4SiwmXBZ89V9SaXArKlWrSEn07yx2limkE5+
	 n+PfTygYD649Q==
From: Marek Vasut <marex@denx.de>
To: linux-wireless@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Ajay Singh <ajay.kathat@microchip.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kalle Valo <kvalo@kernel.org>
Subject: [PATCH] wifi: wilc1000: Re-enable RTC clock on resume
Date: Wed, 21 Aug 2024 20:36:54 +0200
Message-ID: <20240821183717.163235-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The wilc_sdio_suspend() does clk_disable_unprepare() on rtc_clk clock,
make sure wilc_sdio_resume() does matching clk_prepare_enable(), else
any suspend/resume cycle leads to clock disable/enable imbalance. Fix
the imbalance.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Ajay Singh <ajay.kathat@microchip.com>
Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/microchip/wilc1000/sdio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 7999aeb76901f..683a35c682a8f 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -1006,6 +1006,9 @@ static int wilc_sdio_resume(struct device *dev)
 	if (!wilc->initialized)
 		return 0;
 
+	if (!IS_ERR(wilc->rtc_clk))
+		clk_prepare_enable(wilc->rtc_clk);
+
 	wilc_sdio_init(wilc, true);
 	wilc_sdio_enable_interrupt(wilc);
 
-- 
2.43.0


