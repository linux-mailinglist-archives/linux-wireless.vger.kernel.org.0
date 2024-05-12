Return-Path: <linux-wireless+bounces-7557-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2588C37EE
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 20:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C916B1F2124E
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 18:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BF7524DF;
	Sun, 12 May 2024 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gGngt6Kd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFFF4436B
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715538831; cv=none; b=E5bkZZ5dV/Fd3L7mJSUDdrwH3IvFMJhH3sJGsDOQIdsH2hZTt3xFVb6PJLKIDlpM/QJRciIH73jQghCBM6xr1nFpT/ozqCwFWQnO/EUhbewfy56heKpsWbaMFVyBYncnw8yOHHYFMFKVE8EHQVPFIONEwTkmRiFcKD+O/BFQE8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715538831; c=relaxed/simple;
	bh=FjLqaaD2J7Uc27idZPuXUZ5cjttQsqaI6j7vqOencw0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P36B/LU5d8dYeELHbLvFmeuCkCK20wCBSt/03d1gEvnjG999+y5DxRWS5e0k/wycQhxApEz+lDmTSVP+ACHeb8oiFpyg3o8C5ueEdj18SzKS7jWi3tY3WeEkt/6pN2j2YlP6BDqVHe/PWt930/Cw/SxiR+sfDuguOVyQgS7pqJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gGngt6Kd; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44CIXYLO001213;
	Sun, 12 May 2024 13:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715538814;
	bh=Y/gtAHhEiR3Dj6WcGYiMkHbRyKEVwnXq7Ii4qMZIls0=;
	h=From:To:CC:Subject:Date;
	b=gGngt6KdxsEv90igS6MdiJMFX96TNS7SZrmotndZ/bm4lW8kcMJkVYvkktsxzqagy
	 H5YO/kj6M+q4ucOdiRDPFLs4hEGYQcmkJv8uaGGoRLkJR0FnhiqYSmF8U4Vuf5p33/
	 MSlkE0IeG1FH+EMTMgYXN2OrnpKFEMSGbhAGchCI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44CIXXSX013705
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 12 May 2024 13:33:34 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 12
 May 2024 13:33:33 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 12 May 2024 13:33:33 -0500
Received: from localhost (uda0389739.dhcp.ti.com [137.167.1.114])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44CIXWtm047065;
	Sun, 12 May 2024 13:33:33 -0500
From: <michael.nemanov@ti.com>
To: <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC: <sabeeh-khan@ti.com>, Michael Nemanov <michael.nemanov@ti.com>
Subject: [RFC PATCH 00/17] wifi: cc33xx: Add driver for new TI CC33xx wireless device family
Date: Sun, 12 May 2024 21:32:30 +0300
Message-ID: <20240512183247.2190242-1-michael.nemanov@ti.com>
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

This series adds support for CC33xx which is a new family of WLAN IEEE802.11 a/b/g/n/ax
and BLE 5.4 transceivers by Texas Instruments. These devices are 20MHz single spatial stream
enabling STA (IEEE802.11ax) and AP (IEEE802.11n only) roles as well as both roles simultaneously.
Communication to the CC33xx is done via 4-bit SDIO with two extra GPIOs: Enable and Interrupt.

Data sheet: https://www.ti.com/lit/gpn/cc3301

This driver's architecture is a soft-MAC and derivative of existing wl18xx + wlcore code [1].
It has been tested with the AM335x, AM625x, and i.MX8-MP evaluation kits.

All code passes sparse and checkpatch with very few pragmatic exceptions.

Known gaps to be addressed in following patches:
1. Device tree binding documentation
2. BLE support

This work is presented as an RFC with the intention of being made into a patch after initial 
feedback is addressed.

[1] It was considered implementing CC33xx as another user of wlcore but The
differences in HW, host interface, IRQ functionality, Rx/Tx behavior and supported features
were too significant so this was abandoned.

Michael Nemanov, Sabeeh Khan
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
  Add debugfs.c, debugfs.h
  Add scan.c, scan.h
  Add conf.h
  Add ps.c, ps.h
  Add testmode.c, testmode.h
  Add Kconfig, Makefile and integrate into wireless/ti folder

 drivers/net/wireless/ti/Kconfig           |    1 +
 drivers/net/wireless/ti/Makefile          |    1 +
 drivers/net/wireless/ti/cc33xx/Kconfig    |   24 +
 drivers/net/wireless/ti/cc33xx/Makefile   |   10 +
 drivers/net/wireless/ti/cc33xx/acx.c      | 1295 +++++
 drivers/net/wireless/ti/cc33xx/acx.h      |  961 ++++
 drivers/net/wireless/ti/cc33xx/boot.c     |  362 ++
 drivers/net/wireless/ti/cc33xx/boot.h     |   23 +
 drivers/net/wireless/ti/cc33xx/cc33xx.h   |  480 ++
 drivers/net/wireless/ti/cc33xx/cc33xx_i.h |  458 ++
 drivers/net/wireless/ti/cc33xx/cmd.c      | 2037 +++++++
 drivers/net/wireless/ti/cc33xx/cmd.h      |  699 +++
 drivers/net/wireless/ti/cc33xx/conf.h     | 1245 +++++
 drivers/net/wireless/ti/cc33xx/debug.h    |   91 +
 drivers/net/wireless/ti/cc33xx/debugfs.c  | 2201 ++++++++
 drivers/net/wireless/ti/cc33xx/debugfs.h  |   91 +
 drivers/net/wireless/ti/cc33xx/event.c    |  391 ++
 drivers/net/wireless/ti/cc33xx/event.h    |   70 +
 drivers/net/wireless/ti/cc33xx/init.c     |  241 +
 drivers/net/wireless/ti/cc33xx/init.h     |   14 +
 drivers/net/wireless/ti/cc33xx/io.c       |  130 +
 drivers/net/wireless/ti/cc33xx/io.h       |   25 +
 drivers/net/wireless/ti/cc33xx/main.c     | 6013 +++++++++++++++++++++
 drivers/net/wireless/ti/cc33xx/ps.c       |  116 +
 drivers/net/wireless/ti/cc33xx/ps.h       |   15 +
 drivers/net/wireless/ti/cc33xx/rx.c       |  394 ++
 drivers/net/wireless/ti/cc33xx/rx.h       |   85 +
 drivers/net/wireless/ti/cc33xx/scan.c     |  763 +++
 drivers/net/wireless/ti/cc33xx/scan.h     |  363 ++
 drivers/net/wireless/ti/cc33xx/sdio.c     |  576 ++
 drivers/net/wireless/ti/cc33xx/testmode.c |  358 ++
 drivers/net/wireless/ti/cc33xx/testmode.h |   11 +
 drivers/net/wireless/ti/cc33xx/tx.c       | 1419 +++++
 drivers/net/wireless/ti/cc33xx/tx.h       |  159 +
 34 files changed, 21122 insertions(+)
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
 create mode 100644 drivers/net/wireless/ti/cc33xx/debugfs.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/debugfs.h
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


base-commit: 83127ecada257e27f4740dbca9644dd0e838bc36
-- 
2.25.1


