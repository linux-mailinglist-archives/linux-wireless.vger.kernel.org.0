Return-Path: <linux-wireless+bounces-7908-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADB68CB2B7
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 19:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8B5EB20972
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 17:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939B0148851;
	Tue, 21 May 2024 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HAaIc4Kn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BE414830D;
	Tue, 21 May 2024 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716311968; cv=none; b=Xl5txngSSntSMID0bazohi8b2IeV+7uw7Dl3oyQIM1DcNWC7ps8UXAhxJKTGO7gAHZ5sZbZ8nWhwTHt9/t5fLLlFoSNr3dSqkTKMd2V7BJDRr6T0x842ONCDS5jUqiTCm9NBCWyZ2h1BzT0hDss+3OoiRxIwbY1gHYdMHDPc8nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716311968; c=relaxed/simple;
	bh=VLzvIPj/S3ngnfBotvC7rncAzchdWyg+j6grIYSDDXg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ekLSb5OLGmYVCxYAkCr9pH/YbvzBpv33vp9VoEh7yTd8bTXhoGYtWQ0TenJosdraJOM58vC7zXd48UdETIg4FRDx1ZCzSFbIv7pQ3R4+v8HCvuGNSyHUVFNuhVBhRV1SH1TM0Fsj6fpMJDiynJsO3YviMzNCJ+N2yuTMe5qSubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HAaIc4Kn; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44LHIu1K096831;
	Tue, 21 May 2024 12:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716311936;
	bh=S2YXdbcyJVlmzclCVxZ5TAlqXZgP4oQF7n9qzGat2gQ=;
	h=From:To:CC:Subject:Date;
	b=HAaIc4KnUsVrRr5ZP99E6/kQET71XPw0G3FkcoYcv8lmAnleY0OPDJePGahzk+0AL
	 u0qiZSBZ4nnQp59FfRbCsY1we+qyYw1aw2C8y8L7Xyv46HX5C66paamSiyPh4a2rdT
	 ysYajYhTynP73pOeKPLRVcLrSzBcQTu7cs1kHEls=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44LHIuvo032387
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 May 2024 12:18:56 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 21
 May 2024 12:18:55 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 21 May 2024 12:18:55 -0500
Received: from localhost (uda0389739.dhcp.ti.com [137.167.1.114])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44LHIts5013885;
	Tue, 21 May 2024 12:18:55 -0500
From: <michael.nemanov@ti.com>
To: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
        Breno Leitao <leitao@debian.org>,
        Justin Stitt <justinstitt@google.com>,
        Kees
 Cook <keescook@chromium.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sabeeh Khan <sabeeh-khan@ti.com>, Michael Nemanov <michael.nemanov@ti.com>
Subject: [PATCH 00/17] wifi: cc33xx: Add driver for new TI CC33xx wireless device family
Date: Tue, 21 May 2024 20:18:24 +0300
Message-ID: <20240521171841.884576-1-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Michael Nemanov <michael.nemanov@ti.com>

Hello everyone,

This series adds support for CC33xx which is a new family of WLAN IEEE802.11 a/b/g/n/ax
and BLE 5.4 transceivers by Texas Instruments. These devices are 20MHz single spatial stream
enabling STA (IEEE802.11ax) and AP (IEEE802.11n only) roles as well as both roles simultaneously.
Communication to the CC33xx is done via 4-bit SDIO with two extra GPIOs: Enable and Interrupt.

Data sheet: https://www.ti.com/lit/gpn/cc3301

This driver's architecture is a soft-MAC and derivative of existing wl18xx + wlcore code [1].
It has been tested with the AM335x, AM625x, and i.MX8-MP evaluation kits.

All code passes sparse and checkpatch with very few pragmatic exceptions.

Known gaps to be addressed in following patches:
1. BLE support

Test log:
https://0x0.st/XPUd.log

Change log:
v1:
* Added dt-bindings
* Removed debugfs to ease review
* Fix build issue with CONFIG_CFG80211_CERTIFICATION_ONUS
* Fix multiple build warnings found with Clang 18 and W=12

RFC: https://lore.kernel.org/linux-wireless/20240512183247.2190242-1-michael.nemanov@ti.com/


[1] It was considered implementing CC33xx as another user of wlcore but The
differences in HW, host interface, IRQ functionality, Rx/Tx behavior and supported features
were too significant so this was abandoned.

Michael Nemanov
Texas Instruments

Michael Nemanov (17):
  Add cc33xx.h, cc33xx_i.h
  Add debug.h
  Add sdio.c, io.c, io.h
  Add cmd.c, cmd.h
  Add acx.c, acx.h
  Add event.c, event.h
  Add boot.c, boot.h
  Add main.c
  Add rx.c, rx.h
  Add tx.c, tx.h
  Add init.c, init.h
  Add scan.c, scan.h
  Add conf.h
  Add ps.c, ps.h
  Add testmode.c, testmode.h
  Add Kconfig, Makefile and integrate into wireless/ti folder
  Add ti,cc33xx.yaml

 .../bindings/net/wireless/ti,cc33xx.yaml      |   60 +
 drivers/net/wireless/ti/Kconfig               |    1 +
 drivers/net/wireless/ti/Makefile              |    1 +
 drivers/net/wireless/ti/cc33xx/Kconfig        |   24 +
 drivers/net/wireless/ti/cc33xx/Makefile       |   10 +
 drivers/net/wireless/ti/cc33xx/acx.c          | 1009 +++
 drivers/net/wireless/ti/cc33xx/acx.h          |  835 +++
 drivers/net/wireless/ti/cc33xx/boot.c         |  363 +
 drivers/net/wireless/ti/cc33xx/boot.h         |   24 +
 drivers/net/wireless/ti/cc33xx/cc33xx.h       |  481 ++
 drivers/net/wireless/ti/cc33xx/cc33xx_i.h     |  459 ++
 drivers/net/wireless/ti/cc33xx/cmd.c          | 2033 ++++++
 drivers/net/wireless/ti/cc33xx/cmd.h          |  700 ++
 drivers/net/wireless/ti/cc33xx/conf.h         | 1246 ++++
 drivers/net/wireless/ti/cc33xx/debug.h        |   92 +
 drivers/net/wireless/ti/cc33xx/event.c        |  389 ++
 drivers/net/wireless/ti/cc33xx/event.h        |   71 +
 drivers/net/wireless/ti/cc33xx/init.c         |  236 +
 drivers/net/wireless/ti/cc33xx/init.h         |   15 +
 drivers/net/wireless/ti/cc33xx/io.c           |  131 +
 drivers/net/wireless/ti/cc33xx/io.h           |   26 +
 drivers/net/wireless/ti/cc33xx/main.c         | 5949 +++++++++++++++++
 drivers/net/wireless/ti/cc33xx/ps.c           |  117 +
 drivers/net/wireless/ti/cc33xx/ps.h           |   16 +
 drivers/net/wireless/ti/cc33xx/rx.c           |  393 ++
 drivers/net/wireless/ti/cc33xx/rx.h           |   86 +
 drivers/net/wireless/ti/cc33xx/scan.c         |  756 +++
 drivers/net/wireless/ti/cc33xx/scan.h         |  364 +
 drivers/net/wireless/ti/cc33xx/sdio.c         |  581 ++
 drivers/net/wireless/ti/cc33xx/testmode.c     |  357 +
 drivers/net/wireless/ti/cc33xx/testmode.h     |   12 +
 drivers/net/wireless/ti/cc33xx/tx.c           | 1416 ++++
 drivers/net/wireless/ti/cc33xx/tx.h           |  160 +
 33 files changed, 18413 insertions(+)
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


base-commit: 2785ea9673a7305abeea87111849a4e04b0f4626
-- 
2.25.1


