Return-Path: <linux-wireless+bounces-15065-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0813B9C0636
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 13:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BAD11C21D21
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 12:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D00210186;
	Thu,  7 Nov 2024 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mOIpCzY2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B970620F5B9;
	Thu,  7 Nov 2024 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730983967; cv=none; b=XVIA/6BVbWNz6CUhL1BCekQ8QPvdhaCo7z5oJz9fW9YFE0CjHWPxrd1Opk3Yt7wvyzKD8Fl4YBg6rX6Sr0WeNFoxWAVkVVTqsrU6xpOIqgaFzwpxkc5FDQjGYkQX1vw0DhaL/I1hWOHMfMYHxfY8n4TI9rSIZX6bDDZ4BvAnntI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730983967; c=relaxed/simple;
	bh=vNr6HuWQrtb+Rkj36gI9VCWzfyKga6/maKDLo7fyV6E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BQ6WOCJh852m+Jf1R6Z35ZETY3ICjAXqEMrd7FcvBvMkKkDqedNIEk0CHGXSOrgynYdu1Er6ywEGhAhpuIRTGZ3fLdDdYbMcCmHm07XAHglkbFLToOdosq6/uLUGC8wts03WoNyRbKoOwBWAq3LhKp5iVS2iERRn28aOvUOyRGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mOIpCzY2; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A7Cqbuc049045;
	Thu, 7 Nov 2024 06:52:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730983957;
	bh=LRf0OBcI3Jxw9tG7hA6mkIFHccSwxCTR0r1Se6nrlOE=;
	h=From:To:CC:Subject:Date;
	b=mOIpCzY2r/JEAW+P2TZSL6YB4fONuiCUtwHqU9Y8mzqjHuX8B6lMlVsT1oeBjjsUl
	 HCxs3CSLpAjp3HUxieF3VRHMrF4nPObcucxCqoC9nfiJIliX9ZJ2Z3wio9ZeVkGXrY
	 UT7KPmsnJkKRRncwmkkI7+Y6rE9CdvvhsfoqpIvE=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A7CqbPD011098
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 Nov 2024 06:52:37 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Nov 2024 06:52:37 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Nov 2024 06:52:37 -0600
Received: from localhost (udb0389739.dhcp.ti.com [137.167.1.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A7Cqaee038345;
	Thu, 7 Nov 2024 06:52:36 -0600
From: Michael Nemanov <michael.nemanov@ti.com>
To: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sabeeh Khan <sabeeh-khan@ti.com>, Michael Nemanov <michael.nemanov@ti.com>
Subject: [PATCH v5 00/17] wifi: cc33xx: Add driver for new TI CC33xx wireless device family
Date: Thu, 7 Nov 2024 14:51:52 +0200
Message-ID: <20241107125209.1736277-1-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello everyone,

This series adds support for CC33xx which is a new family of WLAN IEEE802.11 a/b/g/n/ax
and BLE 5.4 transceivers by Texas Instruments. These devices are 20MHz single spatial stream
enabling STA (IEEE802.11ax) and AP (IEEE802.11n only) roles as well as both roles simultaneously.
Communication to the CC33xx is done via 4-bit SDIO with two extra GPIOs: Enable and Interrupt.

This driver's architecture is a soft-MAC and derivative of existing wl18xx + wlcore code [1].
It has been tested with the AM335x, AM625x, and i.MX8-MP evaluation kits.

Data sheet: https://www.ti.com/lit/gpn/cc3301

All code passes sparse, smatch, coccicheck and checkpatch with very few pragmatic exceptions.

Driver is split on file boundary as required by Linux-wireless wiki:
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#new_driver


Change log:
v5:
* Moved all internal definitions from scan.h to scan.c
* DT bindings now describe CC3300 as the base variant. Other variants are compatible.
* Moved MODULE_DEVICE_TABLE next to device list in sdio.c
* Minor warning fixes

v4:
* Fixed DT compatibility for all CC33xx variants. Improved general formatting
* Refactored sdio.c to better align with other SDIO drivers
* Removed multiple debug traces
Link: https://lore.kernel.org/linux-wireless/20241029172354.4027886-1-michael.nemanov@ti.com/

v3:
* Added missing sign-offs
* Fixed multiple warnings for memcpy overflow
* Fixed commit message and description of device-tree bindings
Link: https://lore.kernel.org/linux-wireless/20240806170018.638585-1-michael.nemanov@ti.com/

v2:
* Fixed build bug on non-ARM architectures
* Removed driver version
* Removed trivial debug traces
* Removed debug parameters for cc33xx module
* Fixed multiple type compatibility warnings
* Minor fixes
Link: https://lore.kernel.org/linux-wireless/20240609182102.2950457-1-michael.nemanov@ti.com/

v1:
* Added dt-bindings
* Removed debugfs to ease review
* Fix build issue with CONFIG_CFG80211_CERTIFICATION_ONUS
* Fix multiple build warnings found with Clang 18 and W=12
Link: https://lore.kernel.org/linux-wireless/20240521171841.884576-1-michael.nemanov@ti.com/


Test log:
https://0x0.st/XDM9.log

[1] It was considered implementing CC33xx as another user of wlcore but The
differences in HW, host interface, IRQ functionality, Rx/Tx behavior and supported features
were too significant so this was abandoned.

Michael Nemanov
Texas Instruments

Michael Nemanov (17):
  dt-bindings: net: wireless: cc33xx: Add ti,cc33xx.yaml
  wifi: cc33xx: Add cc33xx.h, cc33xx_i.h
  wifi: cc33xx: Add debug.h
  wifi: cc33xx: Add sdio.c, io.c, io.h
  wifi: cc33xx: Add cmd.c, cmd.h
  wifi: cc33xx: Add acx.c, acx.h
  wifi: cc33xx: Add event.c, event.h
  wifi: cc33xx: Add boot.c, boot.h
  wifi: cc33xx: Add main.c
  wifi: cc33xx: Add rx.c, rx.h
  wifi: cc33xx: Add tx.c, tx.h
  wifi: cc33xx: Add init.c, init.h
  wifi: cc33xx: Add scan.c, scan.h
  wifi: cc33xx: Add conf.h
  wifi: cc33xx: Add ps.c, ps.h
  wifi: cc33xx: Add testmode.c, testmode.h
  wifi: cc33xx: Add Kconfig, Makefile

 .../bindings/net/wireless/ti,cc33xx.yaml      |   59 +
 drivers/net/wireless/ti/Kconfig               |    1 +
 drivers/net/wireless/ti/Makefile              |    1 +
 drivers/net/wireless/ti/cc33xx/Kconfig        |   24 +
 drivers/net/wireless/ti/cc33xx/Makefile       |   10 +
 drivers/net/wireless/ti/cc33xx/acx.c          |  931 +++
 drivers/net/wireless/ti/cc33xx/acx.h          |  835 +++
 drivers/net/wireless/ti/cc33xx/boot.c         |  345 +
 drivers/net/wireless/ti/cc33xx/boot.h         |   24 +
 drivers/net/wireless/ti/cc33xx/cc33xx.h       |  483 ++
 drivers/net/wireless/ti/cc33xx/cc33xx_i.h     |  459 ++
 drivers/net/wireless/ti/cc33xx/cmd.c          | 1920 ++++++
 drivers/net/wireless/ti/cc33xx/cmd.h          |  700 ++
 drivers/net/wireless/ti/cc33xx/conf.h         | 1246 ++++
 drivers/net/wireless/ti/cc33xx/debug.h        |   92 +
 drivers/net/wireless/ti/cc33xx/event.c        |  362 ++
 drivers/net/wireless/ti/cc33xx/event.h        |   71 +
 drivers/net/wireless/ti/cc33xx/init.c         |  231 +
 drivers/net/wireless/ti/cc33xx/init.h         |   15 +
 drivers/net/wireless/ti/cc33xx/io.c           |  129 +
 drivers/net/wireless/ti/cc33xx/io.h           |   26 +
 drivers/net/wireless/ti/cc33xx/main.c         | 5687 +++++++++++++++++
 drivers/net/wireless/ti/cc33xx/ps.c           |  108 +
 drivers/net/wireless/ti/cc33xx/ps.h           |   16 +
 drivers/net/wireless/ti/cc33xx/rx.c           |  388 ++
 drivers/net/wireless/ti/cc33xx/rx.h           |   86 +
 drivers/net/wireless/ti/cc33xx/scan.c         |  900 +++
 drivers/net/wireless/ti/cc33xx/scan.h         |   33 +
 drivers/net/wireless/ti/cc33xx/sdio.c         |  530 ++
 drivers/net/wireless/ti/cc33xx/testmode.c     |  349 +
 drivers/net/wireless/ti/cc33xx/testmode.h     |   12 +
 drivers/net/wireless/ti/cc33xx/tx.c           | 1409 ++++
 drivers/net/wireless/ti/cc33xx/tx.h           |  160 +
 33 files changed, 17642 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml
 create mode 100644 drivers/net/wireless/ti/cc33xx/Kconfig
 create mode 100644 drivers/net/wireless/ti/cc33xx/Makefile
 create mode 100644 drivers/net/wireless/ti/cc33xx/acx.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/acx.h
 create mode 100644 drivers/net/wireless/ti/cc33xx/boot.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/boot.h
 create mode 100644 drivers/net/wireless/ti/cc33xx/cc33xx.h
 create mode 100644 drivers/net/wireless/ti/cc33xx/cc33xx_i.h
 create mode 100644 drivers/net/wireless/ti/cc33xx/cmd.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/cmd.h
 create mode 100644 drivers/net/wireless/ti/cc33xx/conf.h
 create mode 100644 drivers/net/wireless/ti/cc33xx/debug.h
 create mode 100644 drivers/net/wireless/ti/cc33xx/event.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/event.h
 create mode 100644 drivers/net/wireless/ti/cc33xx/init.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/init.h
 create mode 100644 drivers/net/wireless/ti/cc33xx/io.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/io.h
 create mode 100644 drivers/net/wireless/ti/cc33xx/main.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/ps.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/ps.h
 create mode 100644 drivers/net/wireless/ti/cc33xx/rx.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/rx.h
 create mode 100644 drivers/net/wireless/ti/cc33xx/scan.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/scan.h
 create mode 100644 drivers/net/wireless/ti/cc33xx/sdio.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/testmode.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/testmode.h
 create mode 100644 drivers/net/wireless/ti/cc33xx/tx.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/tx.h

-- 
2.34.1


