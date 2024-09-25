Return-Path: <linux-wireless+bounces-13164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56916985990
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8732F1C235B9
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 11:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C71E1A3BC9;
	Wed, 25 Sep 2024 11:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnynJ0ck"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E2C186609;
	Wed, 25 Sep 2024 11:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264370; cv=none; b=nVRFSeAlaTOJcP1Vdmnp+Ummf2+GprNIA5RtRZXuoPVwfcg8oCWl4h6k81RjGmFaFhC/WG4/PWIjjDI3iaxGGu1Y5W9OnutFjWR844h4ZOFVuZZyVJPl9GFjklRQc4WtKPOSGtWZFWF5xQYlfAJOsOBYvNx+emTZHEQEqIRbYS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264370; c=relaxed/simple;
	bh=JCEGL/sQYlkj9svfo9k3afWCljeSxe/9w5ji40a+sAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRx1ql86P0BMk3XaGpE8F0XrKntBsGqM3JVC05x3mYVz80x/mWNuLdLYhspGZxBauCWT+fvKo91jCh1bckbBwJG3Q8zCYktzV77ETvejfVPP6nPnhB/+qTyGUlSSqfuglmbmdh+ZgRrw1vliZPwXwipbbpmw9PZanPny/JYIPkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnynJ0ck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6276C4CEC3;
	Wed, 25 Sep 2024 11:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264370;
	bh=JCEGL/sQYlkj9svfo9k3afWCljeSxe/9w5ji40a+sAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XnynJ0ckGTczfHZmz7aJJ3tJwVETaRB2Ls0u6ZCIZhhnHkLaDEFo1nwgdOAqcXnYf
	 VJjXqmxKWx4S/RPTk7XCeroPfC0etVNEAzgVAr7o9xSb5gf4/qaVoXDBdVJk7tI4Wg
	 YjfDdneLXCmB4ruvqyNYRO4YuybCuBjtyxUfw9YInbZHibpORGy6xYXkjJ7EtUtiys
	 yPRsKAvulJtN0QtQ0m06sauhKIxrCEI1UdxpoDIDttLFwOpVrLCD2CudGMJ2uhoN0d
	 RJNBENy7LtjQ+Ct+S8rVp7OppiRpMOG7oljgMdO+1HDucHxf0DZUB+A12OWF8jsL8M
	 GyU1EjBWu8+Dw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ajay.kathat@microchip.com,
	claudiu.beznea@tuxon.dev,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 070/244] wifi: wilc1000: Do not operate uninitialized hardware during suspend/resume
Date: Wed, 25 Sep 2024 07:24:51 -0400
Message-ID: <20240925113641.1297102-70-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Marek Vasut <marex@denx.de>

[ Upstream commit b0dc7018477e8fbb7e40c908c29cf663d06b17a7 ]

In case the hardware is not initialized, do not operate it during
suspend/resume cycle, the hardware is already off so there is no
reason to access it.

In fact, wilc_sdio_enable_interrupt() in the resume callback does
interfere with the same call when initializing the hardware after
resume and makes such initialization after resume fail. Fix this
by not operating uninitialized hardware during suspend/resume.

Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://patch.msgid.link/20240821183639.163187-1-marex@denx.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/microchip/wilc1000/sdio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 0043f7a0fdf97..7999aeb76901f 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -977,6 +977,9 @@ static int wilc_sdio_suspend(struct device *dev)
 
 	dev_info(dev, "sdio suspend\n");
 
+	if (!wilc->initialized)
+		return 0;
+
 	if (!IS_ERR(wilc->rtc_clk))
 		clk_disable_unprepare(wilc->rtc_clk);
 
@@ -999,6 +1002,10 @@ static int wilc_sdio_resume(struct device *dev)
 	struct wilc *wilc = sdio_get_drvdata(func);
 
 	dev_info(dev, "sdio resume\n");
+
+	if (!wilc->initialized)
+		return 0;
+
 	wilc_sdio_init(wilc, true);
 	wilc_sdio_enable_interrupt(wilc);
 
-- 
2.43.0


