Return-Path: <linux-wireless+bounces-14223-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E3A9A4740
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 21:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36291C20DBD
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 19:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B90205ACC;
	Fri, 18 Oct 2024 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="FLB3+9vS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6677318786A;
	Fri, 18 Oct 2024 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280579; cv=none; b=eXQZqYSifih7H/BNfVtWpqVqDHPCc358skeVCgKwPlImXJUB9cDolaco6M3WLs59Hvbwrfz2xhMXy1XliwyFt/Alc/ED25lIWOrgyfYcPf2xvQGZhNcvxaKwCEEGTy4rLKYtXGIXNc6vO7GW4bH9HisDIYY43AUQex8gRcTdfkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280579; c=relaxed/simple;
	bh=Gpuxf7aeuuzqmzhp63zYCRRpmPtiuiFGFtvbgMIYt9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jlp2WGlySjRmJnZ5SxVwOEC71beOo7lBdwuy4SbBKowTcOht2MRWSxcBXta3wWp3SqDPV48zTRKcOLBMS5NEfI604b/9Cswa2l+O3iXV2VJV6FhqvOdivt5BpFfmBiP2utWReb2soeIZQq6oVa9QwSIEf/Er3H16ZxS6GWM12MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=FLB3+9vS; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5DBA188A0E;
	Fri, 18 Oct 2024 21:42:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729280575;
	bh=5zSJJrhTq//NrW8OCQxS0nkzbZo5tl0gZe9uSnXIa48=;
	h=From:To:Cc:Subject:Date:From;
	b=FLB3+9vSianCeYmV9Od/b2APXn596aSKEbVfzgyT9Z885pV91FVJfpTeOcJ5m/2+e
	 P7pEuM9ni/5fEGnYBSVIURb5MOWbuQdkiKu6Mcizz//MNYg6jxZXed/spUgjmyBnPj
	 FDbZgP9ak7D60KfMhLjFVKINF5FCq5O0KPLuGIoPsPsZKwQ/l/kpJhanXD4gkSipOd
	 fP5o1r0YoIL5kQaeXiYoM3q+87xWmNGqd1ith68a7NqWimSHX06j5q2NTykFfMI8EL
	 KlCXiRqGNyPYaZVeOmd0UVh/AZ+7rKfzTIG5DgaAOu8TgYgQHfejTV8c2lXZmI32M7
	 RklBwEVAKkvzA==
From: Marek Vasut <marex@denx.de>
To: linux-wireless@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Adham Abozaeid <adham.abozaeid@microchip.com>,
	Ajay Singh <ajay.kathat@microchip.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] wifi: wilc1000: Add proper error handling for remaining CMD52
Date: Fri, 18 Oct 2024 21:41:57 +0200
Message-ID: <20241018194244.280322-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

A few of the CMD52 calls did not have any error handling, add it.
This prevents odd errors like "Unexpected interrupt (1) int=nnn"
when the CMD52 fails just above in the IRQ handler and the CMD52
error code is ignored by the driver. Fill the error handling in.
Sort the variables in those affected functions while at it. Note
that the error code itself is already printed in wilc_sdio_cmd52().

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Adham Abozaeid <adham.abozaeid@microchip.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>
Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 .../net/wireless/microchip/wilc1000/sdio.c    | 27 ++++++++++++++-----
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 5262c8846c13d..170470d1c2092 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -769,8 +769,10 @@ static int wilc_sdio_init(struct wilc *wilc, bool resume)
 
 static int wilc_sdio_read_size(struct wilc *wilc, u32 *size)
 {
-	u32 tmp;
+	struct sdio_func *func = dev_to_sdio_func(wilc->dev);
 	struct sdio_cmd52 cmd;
+	u32 tmp;
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
+		dev_err(&func->dev, "Fail cmd 52, set DATA_SZ[0] register...\n");
+		return ret;
+	}
 	tmp = cmd.data;
 
 	cmd.address = WILC_SDIO_INTERRUPT_DATA_SZ_REG + 1;
 	cmd.data = 0;
-	wilc_sdio_cmd52(wilc, &cmd);
+	ret = wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->dev, "Fail cmd 52, set DATA_SZ[1] register...\n");
+		return ret;
+	}
 	tmp |= (cmd.data << 8);
 
 	*size = tmp;
@@ -796,9 +806,10 @@ static int wilc_sdio_read_int(struct wilc *wilc, u32 *int_status)
 {
 	struct sdio_func *func = dev_to_sdio_func(wilc->dev);
 	struct wilc_sdio *sdio_priv = wilc->bus_data;
-	u32 tmp;
-	u8 irq_flags;
 	struct sdio_cmd52 cmd;
+	u8 irq_flags;
+	u32 tmp;
+	int ret;
 
 	wilc_sdio_read_size(wilc, &tmp);
 
@@ -817,7 +828,11 @@ static int wilc_sdio_read_int(struct wilc *wilc, u32 *int_status)
 	cmd.raw = 0;
 	cmd.read_write = 0;
 	cmd.data = 0;
-	wilc_sdio_cmd52(wilc, &cmd);
+	ret = wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->dev, "Fail cmd 52, set IRQ_FLAG register...\n");
+		return ret;
+	}
 	irq_flags = cmd.data;
 
 	if (sdio_priv->irq_gpio)
-- 
2.45.2


