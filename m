Return-Path: <linux-wireless+bounces-8980-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D39D79074AE
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 16:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794B12823B2
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 14:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B600145B18;
	Thu, 13 Jun 2024 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="URBdQX0v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA311DFFC;
	Thu, 13 Jun 2024 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287822; cv=none; b=Wa/o3DlKUizKcMZMBT7qwrnoCj7uMYHIcYbe6AdrmHUJ+/S2gTOgL1wSE7SxcCJctXtY4g7DKQjd0Clcg+93EE/JpqxLh2ozRW+bmOL+oUn3KI/7Xh9Q+9YuKNORH4iMFK1Shz80VQI80ucfSLQqHdotg2nK4pCbdSpLqp4vEWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287822; c=relaxed/simple;
	bh=ZFaFXJ/5FkNcomE8Riab0CfZAzjtblxo3xgwjf0mA8M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GW22e7+HY8ZxsWfmlN0Ev5119ScPoW81di2lR0s8qs+kqCionwHm7kLDi5Db/GE2onWS8u9DYPTP7ZoDq6Mc4euEeg7erhv0jW1jXFUocBId4S5NMuNRBz2h4FC6EK5cVIOVX+KxBNfW9zSrVyXxX+kcR0k/xJArGy44snka7Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=URBdQX0v; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F2CB1BF20F;
	Thu, 13 Jun 2024 14:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718287811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qMuh+5SjoWabgRcuPKc16rfOCZ4xON70zkQc74UXvbk=;
	b=URBdQX0vcncG2RMb2tU6slxnjH+jsgZVVVJXMO2Wdk8vQgeXvphD+4EAzqrw4G7RJgjCwv
	AjWxnm5S1/3v5sdlfzvYT4xziIswciqAH4GDNUGbJqE6FYAs50hgrqXszqHyYw98iD+6+f
	IdtSx6W45Yj0g2Dp0QitGxs5qpkZh6hMXZbhYLUt6nS0BuAK3zPsps+DwTizglsXcniTbQ
	yL37AqAiZO/u3TaF8wIjPrlTGw37oWubUdTf4MDJQXsfadlFvL8z/7x1ttL9+x4y0ZiNcG
	LL6+hNf3ZD6Q3diOse2779aLc9+6PzwCs44NTvk34UmQhd6i56WVhztHGMglFw==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: [PATCH 0/6] wifi: wilc1000: update power management
Date: Thu, 13 Jun 2024 16:06:39 +0200
Message-Id: <20240613-wilc_suspend-v1-0-c2f766d0988c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAO/8amYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQyNj3fLMnOT44tLigtS8FF0TE8NEU0sTkxRLE0MloJaCotS0zAqwcdG
 xtbUAZzIHZV4AAAA=
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

Despite being implemented, power management for wilc1000 does not work as
expected and suffer some issues. Those issues can be observed by
executing "echo devices > /sys/power/pm_test && echo mem >
/sys/power/state":

- system does not resume correctly (at least on my testing platform,
  sama5d27-wlsom1-evk, either with devices test mode or user button
  configured as wake up source)
- warnings are triggered during suspend

This series brings fixes for those issues, and more generally try to
improve things a bit:
- implement only one pair of suspend/resume callbacks (those are currently
  implemented for both 802.11 class and driver, with one depending on the
  other)
- fix some warnings (for example, IRQ still being enabled on SDIO func
  while going to suspend)
- fix some scenarios leading to chip becoming unresponsive to SDIO
  re-enumeration (error -110)

With this series the following sequence works:
  - echo devices > /sys/power/pm_test
  - echo mem > /sys/power/state
- chip is properly disconnected from any AP when entering suspend
- chip properly reconnects on resume

The patches comes both from Microchip internal patches (slightly reworked)
and new patches based on encountered issues.
Tested on SAMA5D27 EVK with a WILC 1000 SD module, tested both in SDIO
mode and SPI mode

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
Ajay Singh (1):
      wifi: wilc1000: disable power sequencer

Alexis Lothoré (5):
      wifi: wilc1000: let host->chip suspend/resume notifications manage chip wake/sleep
      wifi: wilc1000: do not keep sdio bus claimed during suspend/resume
      wifi: wilc1000: move sdio suspend method next to resume and pm ops definition
      wifi: wilc1000: remove suspend/resume from cfg80211 part
      wifi: wilc1000: disable SDIO func IRQ before suspend

 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 19 ------
 drivers/net/wireless/microchip/wilc1000/netdev.h   |  1 -
 drivers/net/wireless/microchip/wilc1000/sdio.c     | 74 ++++++++--------------
 drivers/net/wireless/microchip/wilc1000/wlan.c     |  8 +--
 drivers/net/wireless/microchip/wilc1000/wlan.h     |  1 -
 5 files changed, 30 insertions(+), 73 deletions(-)
---
base-commit: 3971a5a8f911615f9a816f76c83c37d51ac522a9
change-id: 20240123-wilc_suspend-441a5944d941

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


