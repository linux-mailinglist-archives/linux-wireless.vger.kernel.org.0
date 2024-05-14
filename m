Return-Path: <linux-wireless+bounces-7649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175F08C590E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 17:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90264B21570
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 15:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E33A17F361;
	Tue, 14 May 2024 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B/90QdET"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34461292D2;
	Tue, 14 May 2024 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715701891; cv=none; b=G2WBfDAr6oiOXd1SWJ5IRt6IVtlLXhMQB7P/k8COhx064USESTx/IZW4m4M4ALLUiWrQaU9B7jNbR07pxAIXQUyRGAQvtUuE9KGY73plevj3oxWr8PlrTdE/FMPbq8DuF0xRw9daKrs4mVUKv6BFCUdBYVXqVxdVda0MNzxIsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715701891; c=relaxed/simple;
	bh=7qCZjVj0npclH05dgo5fA40AF1gLfoojNtKF6rHAMUo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cXdN23tsViqSYvnyxCv0xdPuNPx8pp9CYovHYzC8delv6NnuAZm/uQYBnDGRjODY8bCJpjtbDE0vse7j7suFg41SbSjuW86twg4/zONZ1l7u1TDq8MRiHt6MCZk+5mFkBYQXrTSMymcoooigm+3sphZsdjPwmZ04A4iQxOnUu1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B/90QdET; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1C42C1C0005;
	Tue, 14 May 2024 15:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715701886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Tfx7Bevqga7Dh0vC0Y7W7EThPtYYB7PnS/L6OwfxpZI=;
	b=B/90QdETOpRS7TCwy23tkVC+xxteweiAReV6y77LZn492w00DQX7SEr6mPWuPF9fayl8mK
	RK2f5eFcijo1aDOL76EUf9LyxN9LnQmyTgPV8CBMabf/gOFPjzHp0fsDwQ61Y98UOKg4/4
	a3TmcUzfDVAyVeeT5lu+nk58xjnGyZbS4ADXAWIfsEUx3O0G8EtWu3YNZOhamDpTbnwnNE
	clCxpB7FiGWV67JX0SanSFkeFFPHMqTP2p/4TbfjVNQS6cypDvV3ePAT6sczPfEod6/gww
	ksrjmSuINP+sLPODcpq24KxWOlHRxSPDL/f0YFykT7e8e5yadlqmFyX/OckfzQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: [PATCH v2 0/6] wifi: wilc1000: fix default mac address
Date: Tue, 14 May 2024 17:51:18 +0200
Message-Id: <20240514-mac_addr_at_probe-v2-0-afef09f1cd10@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHaIQ2YC/22NQQqDMBBFryKzbkoypkq76j2KSCZJ60A1kkhoE
 e/e6LrL9+C/v0LykX2CW7VC9JkTh6kAniqwg5leXrArDCixVohKjMb2xrnYm6WfYyAvakuN1Jr
 wohyU3Rz9kz9H89EVHjgtIX6Pi6x2u9e01Kr9U8tKSNG0rrFXqski3SmE5c3T2YYRum3bfq9Ur
 4e0AAAA
To: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Heiko Thiery <Heiko.Thiery@kontron.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 Heiko Thiery <heiko.thiery@gmail.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

This series aims to fix invalid mac address issue raised by Heiko Thiery 
([1]). WILC1000 mac address is currently not set until device is opened, at
which point firmware is loaded and started. This results in default mac
address being 00:00:00:00:00:00.

This series, based on an initial patch from Ajay, reads the MAC address
from chip eFuse whenever we set the first interface (at probe time). To do
so, we need to ensure that any bus communication is properly initialized,
so the first commits slightly rearrange/fix initialization/registration
order to allow to read MAC address properly.
Based on the tests I did during this series adjustments, there are still a
few corner cased not properly handled, especially when dealing with two
interfaces on top of the same wphy, but it fixes at least the user-facing
mac address for those interfaces so user space network managers are not
confused anymore.

[1] https://lore.kernel.org/netdev/CAEyMn7aV-B4OEhHR4Ad0LM3sKCz1-nDqSb9uZNmRWR-hMZ=z+A@mail.gmail.com/

---
Changes in v2:
- add missing symbols export
- declare new nv mac read helper at the bottom of file
- collected Tested-By tag
- Link to v1: https://lore.kernel.org/r/20240417-mac_addr_at_probe-v1-0-67d6c9b3bc2b@bootlin.com

---
Ajay Singh (1):
      wifi: wilc1000: read MAC address from fuse at probe

Alexis Lothoré (5):
      wifi: wilc1000: set net device registration as last step during interface creation
      wifi: wilc1000: register net device only after bus being fully initialized
      wifi: wilc1000: set wilc_set_mac_address parameter as const
      wifi: wilc1000: add function to read mac address from eFuse
      wifi: wilc1000: make sdio deinit function really deinit the sdio card

 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 10 ---
 drivers/net/wireless/microchip/wilc1000/fw.h       | 13 ++++
 drivers/net/wireless/microchip/wilc1000/hif.c      |  4 +-
 drivers/net/wireless/microchip/wilc1000/hif.h      |  2 +-
 drivers/net/wireless/microchip/wilc1000/netdev.c   | 72 ++++++++++++----------
 drivers/net/wireless/microchip/wilc1000/netdev.h   |  2 +
 drivers/net/wireless/microchip/wilc1000/sdio.c     | 71 ++++++++++++++++++++-
 drivers/net/wireless/microchip/wilc1000/spi.c      | 17 ++++-
 drivers/net/wireless/microchip/wilc1000/wlan.c     | 49 +++++++++++++++
 drivers/net/wireless/microchip/wilc1000/wlan.h     |  1 +
 10 files changed, 193 insertions(+), 48 deletions(-)
---
base-commit: cd546c1dc7164096520a97fbcaca0a063ef1d0a7
change-id: 20231221-mac_addr_at_probe-3cb6044b251d

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


