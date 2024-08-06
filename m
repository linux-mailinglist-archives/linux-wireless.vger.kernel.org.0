Return-Path: <linux-wireless+bounces-11027-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D794C949634
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 19:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E433F1C214FA
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 17:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928F0155726;
	Tue,  6 Aug 2024 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OIivsS0I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23287824BD;
	Tue,  6 Aug 2024 17:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963709; cv=none; b=CkgBzf3oqWmF2D3K1ExCNQYLbTPu5i1lakT/GwmjCWSpkZ+JzmFDoL+cJ503Il2ztZQYDTTmVxM48Z9UzqiJmC/m5vKMkZw0cZE973FSHFy/72mNcO9x73JeDZyPZ33G2pg7rnFyD17+3IIJiOEH9oMxh2l311X1r/1QpP1iZho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963709; c=relaxed/simple;
	bh=yirhGRV8z3dzeaOicxTi8mzJ0iWfFkm2TMlo4tNY++o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rQXwr7AfXiAGO7BKuOxFnBXGqJweQ+mQ/3b/LoR8V29hRNb3Fs4g/JX8KhXkgkWBamzVxUKuDi9kMECTdKhX0qcpbn5+hOcL2HKL0xLjTCHS5cVq5YNGlxPh7r0m6ej+ppFE2yLPcO8XjdPwE9hIPfoehhbrJJ4CzWcR3kEVhfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OIivsS0I; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476H1PE8117593;
	Tue, 6 Aug 2024 12:01:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722963685;
	bh=DMqQCiCBes+KWaNgnlpy9KYLebMmh7WObGdpYCJSN/U=;
	h=From:To:CC:Subject:Date;
	b=OIivsS0IwrayvssOxNAliBL1QDib/KM9ZrKHPq7NusTWz1YS8IF3whBZj96o/0q+3
	 4sMRsISEIbRlBUPWVCEXAUVd4K0z0ch29iYT+nvyzDA69sfsJNRofB9slvZR8RJUI1
	 PfDjRwa4GgEVH7OOL4j0NvA3zMrt0rTvNZu3h6So=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476H1PWf006203
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 12:01:25 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 12:01:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 12:01:25 -0500
Received: from localhost (udb0389739.dhcp.ti.com [137.167.1.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476H1O8W038613;
	Tue, 6 Aug 2024 12:01:24 -0500
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
Subject: [PATCH v3 00/17] wifi: cc33xx: Add driver for new TI CC33xx wireless device family
Date: Tue, 6 Aug 2024 20:00:01 +0300
Message-ID: <20240806170018.638585-1-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

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
v3:
* Added missing sign-offs
* Fixed multiple warnings for memcpy overflow
* Fixed commit message and description of device-tree bindings

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
https://0x0.st/XVBS.log

[1] It was considered implementing CC33xx as another user of wlcore but The
differences in HW, host interface, IRQ functionality, Rx/Tx behavior and supported features
were too significant so this was abandoned.

Michael Nemanov
Texas Instruments

Michael Nemanov (17):
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
  dt-bindings: net: wireless: cc33xx: Add ti,cc33xx.yaml

 .../bindings/net/wireless/ti,cc33xx.yaml      |   56 +
 drivers/net/wireless/ti/Kconfig               |    1 +
 drivers/net/wireless/ti/Makefile              |    1 +
 drivers/net/wireless/ti/cc33xx/Kconfig        |   24 +
 drivers/net/wireless/ti/cc33xx/Makefile       |   10 +
 drivers/net/wireless/ti/cc33xx/acx.c          | 1011 +++
 drivers/net/wireless/ti/cc33xx/acx.h          |  835 +++
 drivers/net/wireless/ti/cc33xx/boot.c         |  363 +
 drivers/net/wireless/ti/cc33xx/boot.h         |   24 +
 drivers/net/wireless/ti/cc33xx/cc33xx.h       |  483 ++
 drivers/net/wireless/ti/cc33xx/cc33xx_i.h     |  459 ++
 drivers/net/wireless/ti/cc33xx/cmd.c          | 2030 ++++++
 drivers/net/wireless/ti/cc33xx/cmd.h          |  700 ++
 drivers/net/wireless/ti/cc33xx/conf.h         | 1246 ++++
 drivers/net/wireless/ti/cc33xx/debug.h        |   92 +
 drivers/net/wireless/ti/cc33xx/event.c        |  385 ++
 drivers/net/wireless/ti/cc33xx/event.h        |   71 +
 drivers/net/wireless/ti/cc33xx/init.c         |  232 +
 drivers/net/wireless/ti/cc33xx/init.h         |   15 +
 drivers/net/wireless/ti/cc33xx/io.c           |  131 +
 drivers/net/wireless/ti/cc33xx/io.h           |   26 +
 drivers/net/wireless/ti/cc33xx/main.c         | 5853 +++++++++++++++++
 drivers/net/wireless/ti/cc33xx/ps.c           |  117 +
 drivers/net/wireless/ti/cc33xx/ps.h           |   16 +
 drivers/net/wireless/ti/cc33xx/rx.c           |  393 ++
 drivers/net/wireless/ti/cc33xx/rx.h           |   86 +
 drivers/net/wireless/ti/cc33xx/scan.c         |  750 +++
 drivers/net/wireless/ti/cc33xx/scan.h         |  363 +
 drivers/net/wireless/ti/cc33xx/sdio.c         |  584 ++
 drivers/net/wireless/ti/cc33xx/testmode.c     |  359 +
 drivers/net/wireless/ti/cc33xx/testmode.h     |   12 +
 drivers/net/wireless/ti/cc33xx/tx.c           | 1411 ++++
 drivers/net/wireless/ti/cc33xx/tx.h           |  160 +
 33 files changed, 18299 insertions(+)
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


