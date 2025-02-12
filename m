Return-Path: <linux-wireless+bounces-18846-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AD5A32A6E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 16:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B241883371
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 15:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D69211700;
	Wed, 12 Feb 2025 15:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PLkMLkwv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781E6271814;
	Wed, 12 Feb 2025 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739375271; cv=none; b=olGUqWVzt658od/lySWSWJZj3MmYCsWSFRLclPj9PF20z9QK6mqfyAAey7oxFc7Vt9Jb1xpDiUBSlvVuTve2Za4TyIzIR09c96OBcfP0ZPjXAVLSQUHn8kf79JhS96dFroe8mXWXWBFcPK8yRkNDS9eHB+2/E8JkO7KoAmL6+SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739375271; c=relaxed/simple;
	bh=evqjBDuFvQvZNlaBbpp360TMcXxjhw1F9NMB4b5lJuQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KeKwzXd/MaZQpmuPg6CUDHQTQkXsetLoz7uoJV2P7xg3s67Rk0kGmFmlfXggFx/nQUzoR2B/GGF2Ry7ItrxXlq1ZbaNR3PftQvlcCPqvuQ0mIdLXU/5B2uNOnRnBfo/cewmPtDwTU2nktvC5ZjO9ULRnoWnNHnhpvKgwLl+Ru9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PLkMLkwv; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BF86F440F3;
	Wed, 12 Feb 2025 15:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739375266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=39musMyRvQZFJGCAwDo09lJ3EVHHEkzlG1spNgpkZ4Q=;
	b=PLkMLkwv0wm/8HRgZPKQsHL3sSziak3cusMU+bcFX6+IVkHZS6TEd3k+KrY2dIywTHU+oU
	k5K+Pu8maSlm//NBsxq+mli1fn7ynFCbmeyrr0OVipl4XgwpYFpZ71V/Tp26rgvyeW/VtT
	aNGFCrDp4Mqnl16E8Td75hPikhyv5T09yR9oqeNnvaN21zbx63n7R28RguxaBHArhg2815
	Oel1IDy2h8N8RZ3QHT5Fgs+AY/odjSZySHn09TSgSRb+URe2tF0+6rKCsiewXEfGGijI3M
	GhwVdz8aXHvMXC6DNX2aI1tobo5yil3SxE8scKqWRZZ4MU149UC2siFA9xrlAQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: [PATCH 00/12] bluetooth: hci_wilc: add new bluetooth driver
Date: Wed, 12 Feb 2025 16:46:19 +0100
Message-Id: <20250212-wilc3000_bt-v1-0-9609b784874e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEvCrGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyML3fLMnGRjAwOD+KQS3bREE1OjNKNES+PEFCWgjoKi1LTMCrBp0bG
 1tQDQShcmXQAAAA==
X-Change-ID: 20240828-wilc3000_bt-fa452f2a93ad
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Marek Vasut <marex@denx.de>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggedvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevffetudegfedukeelhffgjeefteevgeejjeffkeekudejhedvfedufeefvedtnecuffhomhgrihhnpehmihgtrhhotghhihhprdgtohhmpdhkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekhedphhgvlhhopegludelvddrudeikedruddrudeljegnpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrn
 hgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,

WILC3000 ([1]) is a combo chip exposing 802.11b/g/n and Bluetooth 5.
Support for the wlan part has recently been integrated upstream ([2]) in
the existing wilc1000 driver. This new series aims to bring support for
the bluetooth side.

The WILC3000 chip is controlled through a SDIO or SPI bus for the wlan
part (similarly to wilc1000), and uses standard HCI commands over a UART
bus for the bluetooth operations. This work is based on the code
available in the vendor kernel ([3]), in which bluetooth is managed
directly in the wireless driver, and relies on user to trigger the
hardware configuration (chardev manipulations + hciattach). The series
brings a new dedicated bluetooth driver to support the bluetooth feature
from the chip, without relying on the user to perform the device
bringup. However, getting completely rid of the wlan driver dependency
is not possible: it is still needed for early BT CPU configuration and
BT firmware download, so the new driver still have a dependency of the
wlan one, with an approach similar to the one used by the rsi driver.

- Patch 1 brings the new dt binding
- Patch 2-9 prepares the wlan side, either by exposing the needed
  functions to initialize BT, or by mitigating behavior which would
  prevent BT and WLAN from runnning in parallel
- Patch 10 brings the new bluetooth driver
- Patch 11 updates the device tree description for sama5d27_wlsom1_ek
  board (which I used to validate this series) to use the new driver
- Patch 12 adds a new entry for this driver in the MAINTAINERS files

This series has been tested with WILC3000 both in SDIO mode (with the
chip embedded on the sama5d27_wlsom1_ek) and SPI mode (custom wiring on
an SPI on the same eval board, with a WILC3000-SD).

Since this works needs new code in both the existing wlan driver and the
new driver, I have included both linux-wireless and bluetooth mailing
lists, while keeping the entire series for clarity, but let me know if
you want to proceed differently.

[1] https://www.microchip.com/en-us/product/atwilc3000
[2] https://lore.kernel.org/linux-wireless/20241004114551.40236-1-marex@denx.de/
[3] https://github.com/linux4microchip/linux/tree/linux-6.6-mchp/drivers/net/wireless/microchip/wilc1000

---
Alexis Lothoré (12):
      dt-bindings: bluetooth: describe wilc 3000 bluetooth chip
      wifi: wilc1000: add a read-modify-write API for registers accesses
      wifi: wilc1000: add lock to prevent concurrent firmware startup
      wifi: wilc1000: allow to use acquire/release bus in other parts of driver
      wifi: wilc1000: do not depend on power save flag to wake up chip
      wifi: wilc1000: remove timeout parameter from set_power_mgmt
      wifi: wilc1000: reorganize makefile objs into sorted list
      wifi: wilc1000: add basic functions to allow bluetooth bringup
      wifi: wilc1000: disable firmware power save if bluetooth is in use
      bluetooth: hci_wilc: add wilc hci driver
      ARM: dts: at91-sama5d27_wlsom1: update bluetooth chip description
      MAINTAINERS: add entry for new wilc3000 bluetooth driver

 .../net/bluetooth/microchip,wilc3000-bt.yaml       |  41 +++
 MAINTAINERS                                        |   7 +
 .../boot/dts/microchip/at91-sama5d27_wlsom1.dtsi   |   8 +
 .../boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts |  10 -
 drivers/bluetooth/Kconfig                          |  13 +
 drivers/bluetooth/Makefile                         |   3 +-
 drivers/bluetooth/hci_uart.h                       |   1 +
 drivers/bluetooth/hci_wilc.c                       | 333 ++++++++++++++++++++
 drivers/net/wireless/microchip/wilc1000/Kconfig    |   3 +
 drivers/net/wireless/microchip/wilc1000/Makefile   |  11 +-
 drivers/net/wireless/microchip/wilc1000/bt.c       | 345 +++++++++++++++++++++
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |   7 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      |   2 +-
 drivers/net/wireless/microchip/wilc1000/hif.h      |   2 +-
 drivers/net/wireless/microchip/wilc1000/netdev.c   |  14 +
 drivers/net/wireless/microchip/wilc1000/netdev.h   |   5 +
 drivers/net/wireless/microchip/wilc1000/sdio.c     | 101 ++++--
 drivers/net/wireless/microchip/wilc1000/spi.c      |  43 +++
 drivers/net/wireless/microchip/wilc1000/wlan.c     | 154 ++++-----
 drivers/net/wireless/microchip/wilc1000/wlan.h     |  23 ++
 include/net/wilc.h                                 |  19 ++
 21 files changed, 996 insertions(+), 149 deletions(-)
---
base-commit: 95f6f2d73dc40ab53a94756689ce5cfd2f23361a
change-id: 20240828-wilc3000_bt-fa452f2a93ad

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


