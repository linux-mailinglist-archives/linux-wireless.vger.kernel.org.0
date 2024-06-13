Return-Path: <linux-wireless+bounces-8978-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DA59074AB
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 16:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C5E281AC8
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 14:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C50A145A1C;
	Thu, 13 Jun 2024 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GsnwWXb1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4021F144D22;
	Thu, 13 Jun 2024 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287822; cv=none; b=FqsXDjTtnAY8LEmUf+UTh21eRgmsnypFE88cVSuyUltxh+gkG+RPL7dbmM4Eb/3+lYPzWPozw/PoT+9A4/f82p07n5/hyyUWZgH2NdFlREwMXTZvEcGf1H09uJMzQLmdmWAXpTts3F/TAFwAjmmp2skHOV5obM1kAb8twURLcUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287822; c=relaxed/simple;
	bh=4RT3k3qkDb51XkI7+op2d8Gu+d00tOAbnMzE7YADJbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s69Fi1wU3leqIVyWlpsNo6Kd3fCwKfoKBY6D/Uu5NJwNv+Xrfu4eqFHabI7wfUrqR6bQVVt68iQ8TLF6D8E6TIJRBo7VoK6vUvn5QVj1Ie51ZYr9puKEapkAYUSth9X10TR4d2rnxMuJpffvst0elR1OztKQLNMwgoEqHEF/2vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GsnwWXb1; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9F6721BF214;
	Thu, 13 Jun 2024 14:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718287812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KImdBPG69Vy3zZfpijKwF06u8+Zf/lYE5b5hwvY4Qas=;
	b=GsnwWXb1yinDepVUXtSQeF5RZvxsfwf1jbLv4K6tORU5gdAlgYLAZdxRJvR5cCBqETOjOH
	E/FSqctlHRnQojxlvydBbVlVjsOumCor4BzimB590DFoHW8JGP+96bXoQTKy/5T36HtYlp
	FWPClaaAmxL6FGkvtzyHQqbxBS5wFV29sMHUsCM7xlommbYoD87eLM2IGkDPD3KTzo013m
	tvCbcxsAsehqKJHnsoE4PxsgOUCRpBFc4GA4xjwuMitZI5GqdymVXru53Gp2S1OHu1GzyM
	5UCq9ZXNUMdUJiCxigct30r10mZ3HkG+3W4Rdh7pZiv7aJ6pconNzYZ3Z+m1OA==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Thu, 13 Jun 2024 16:06:42 +0200
Subject: [PATCH 3/6] wifi: wilc1000: do not keep sdio bus claimed during
 suspend/resume
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240613-wilc_suspend-v1-3-c2f766d0988c@bootlin.com>
References: <20240613-wilc_suspend-v1-0-c2f766d0988c@bootlin.com>
In-Reply-To: <20240613-wilc_suspend-v1-0-c2f766d0988c@bootlin.com>
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

There is no reason to keep the MMC host claimed during suspend.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/sdio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 4e478a2cd4cc..fb4de3de1140 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -269,7 +269,6 @@ static int wilc_sdio_suspend(struct device *dev)
 		dev_err(&func->dev, "Fail reset sdio\n");
 		return ret;
 	}
-	sdio_claim_host(func);
 
 	return 0;
 }
@@ -1000,7 +999,6 @@ static int wilc_sdio_resume(struct device *dev)
 	struct wilc *wilc = sdio_get_drvdata(func);
 
 	dev_info(dev, "sdio resume\n");
-	sdio_release_host(func);
 	wilc_sdio_init(wilc, true);
 
 	if (wilc->suspend_event)

-- 
2.45.2


