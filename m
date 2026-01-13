Return-Path: <linux-wireless+bounces-30758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B1CD1B3A5
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 21:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B027C3005015
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 20:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6AF2772D;
	Tue, 13 Jan 2026 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="L5dkN6CP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA1B296BBC
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336528; cv=none; b=g1tEafTuSw2QKQoqIfHgXLFOb4p5XajTdUJHpi73Pq26kTnFZFvD7rbFeTESs4hUBSxSIDtKu2bYyDztIyw3a1RNbMCn1ja0x5t8HewG03bhS8w6nWmNnKyRuBeQA5uGB0oF/ddaaRnmPybOFtZmVAlKyppYh6nmKMYLnlH5TYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336528; c=relaxed/simple;
	bh=GsgJEGDm8ULos30+oIsHp94X7/q1uAVhOXI1V9eq4R8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tnKtBlAghwRc/gNW9L75uXDg5SDnMWpLndOOaLuAn7sWL7zbtomifcimSiKUy1O5u2D8dZB/KhyPe4jgmkKmWbU2zLuU2vbZRMuBhVsHvMQUf3pmZO5w5HIlDlfs7NH3/Oqbblg4DVPM9y+GR3i+Ta70IwYT6O8Z1YL00O+qZHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=L5dkN6CP; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1768336527; x=1799872527;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GsgJEGDm8ULos30+oIsHp94X7/q1uAVhOXI1V9eq4R8=;
  b=L5dkN6CP+Tsw0ABzpM7tZeHzqhtcc5ICONsJTnYWnHhmFrlKBNLy5HF3
   onvwzcz2dom/B8x8fAIzqYVWPaVi1jyxXwD1ndYs/xLGGLNG/azHfDFgC
   DYLCse3h96gvciU5+qOoK0vFqKOQ4/RIQEjc5HsuP9LgTpQFZa2DZxm9v
   M=;
X-CSE-ConnectionGUID: yYtMtUNdQn6G+qRJkKiEhg==
X-CSE-MsgGUID: xBkpv8brTBWUV95EVBuICw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="78106910"
X-IronPort-AV: E=Sophos;i="6.21,222,1763420400"; 
   d="scan'208";a="78106910"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:34:15 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 13 Jan
 2026 21:34:14 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 13 Jan 2026 21:34:12 +0100
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, <marex@nabladev.com>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 00/34] wifi: inffmac: introducing a driver for Infineon's new generation chipsets
Date: Wed, 14 Jan 2026 02:03:13 +0530
Message-ID: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MUCSE805.infineon.com (172.23.29.31) To
 MUCSE827.infineon.com (172.23.29.20)

Infineon(Cypress) is introducing a new INFFMAC (WLAN FULLMAC) Linux driver
specifically for its new-generation AIROC family of Wi-Fi Connectivity
Processor (CP) chipsets (CYW5591x), Wi-Fi + Bluetooth combo chipsets
(CYW5557x, CYW5551x, CYW5591x, CYW43022), and also for all future chipsets.

The chipsets from these families have various combinations of capabilities
like Wi-Fi 6/5, 2.4/5/6GHz, 1x1/2x2, 20/40/80MHz and PCIe/SDIO BUS, etc.
Infineon's full list of Wireless Connectivity product briefs and datasheets
are available in https://www.infineon.com/products/wireless-connectivity

The Infineon chipsets listed above are tailor-made for a wide variety of
IoT use cases and provide support for multiple host BUS interfaces
(eventually gSPI, SPI, I2C, USB, and UART support will be added
in future contributions). In addition, these new chipsets support IoT mode
of operations that require an Infineon-proprietary secured Device firmware
architecture.

By default, this driver expects the device firmware/image/NVRAM/CLM_BLOB
files in the filesystem path /lib/firmware/infineon/ with the file name
prefix “inffmac*” (for example: inffmac43022-sdio.trxs). This driver is
tested for AP, STA, and P2P operation modes on Intel NUC platform.

As suggested in the review comments received on V1, had to reduce the size
of the driver, so removed some major functionalities, to be added later.
Also have split the driver into smaller commits to make the review easier,
Final version would be a single commit for the inffmac driver changes.
Kindly let us know if there is anything else that we can do to help with
the review. Completed checkpatch verification with current default max
line length (100) used in linux. If checkpatch is ran with a line
length restriction of 80 characters, then we can expect some warnings.

More information on this driver is available in V1 cover letter [1].

Co-developed-by: Carter Chen <Carter.Chen@infineon.com>
Signed-off-by: Carter Chen <Carter.Chen@infineon.com>
Co-developed-by: Owen Huang <Owen.Huang@infineon.com>
Signed-off-by: Owen Huang <Owen.Huang@infineon.com>
Co-developed-by: Ian Lin <Ian.Lin@infineon.com>
Signed-off-by: Ian Lin <Ian.Lin@infineon.com>
Co-developed-by: JasonHuang <Jason.Huang2@infineon.com>
Signed-off-by: JasonHuang <Jason.Huang2@infineon.com>
Co-developed-by: Shelley Yang <Shelley.Yang@infineon.com>
Signed-off-by: Shelley Yang <Shelley.Yang@infineon.com>
Co-developed-by: Ramprasad Kannappan <Ramprasad.Kannappan@infineon.com>
Signed-off-by: Ramprasad Kannappan <Ramprasad.Kannappan@infineon.com>
Co-developed-by: Gaurang Rathod <Gaurang.Rathod@infineon.com>
Signed-off-by: Gaurang Rathod <Gaurang.Rathod@infineon.com>
Co-developed-by: Kirtan Joshi <Kirtan.Joshi@infineon.com>
Signed-off-by: Kirtan Joshi <Kirtan.Joshi@infineon.com>
Co-developed-by: avishad verma <avishad.verma@infineon.com>
Signed-off-by: avishad verma <avishad.verma@infineon.com>
Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
Signed-off-by: Double Lo <Double.Lo@infineon.com>
Signed-off-by: Vinoth Sampath <Vinoth.Sampath@infineon.com>

---

v2:
 - Improved support for Infineon's new type of WLAN chipsets having the
   the Connectivity Processor (CP) architecture which provides wireless
   connectivity along with a host network offload. The driver communicates
   with various components (like, CP, WLAN FW) inside these devices using
   the ICDC protocol over the SDIO BUS.

 - Fully refactored the interface management functionality and added the
   Dynamic vif creation, deletion support.

 - Separated out the P2P functionality from the Management Frame TX
   functionality.

 - Improved the Device Firmware Update (DFU) support to update the Firmware
   over SDIO in Device FLASH Memory or PSRAM during runtime.

 - Started utilizing wiphy locking, wiphy work and wiphy delayed work
   scheduling infrastrucutre provided by cfg80211 for the WLAN Drivers.

 - Cleaned up multiple source and header files.

 - Skipped support for WLAN Sensing, XDP, Packet offloads now, to be added
   later in a separate patch with a dedicated review, as suggested in v1.

 - Also skipped the support for BT Coexistance, Shared SDIO for BT, PNO,
   Debug Logger, most of the module params, etc now to shrink the driver
   size in this version to help with the review.
   
v1: [1] https://lore.kernel.org/linux-wireless/20250916221821.4387-1-gokulkumar.sivakumar@infineon.com/

---

Gokul Sivakumar (34):
  wifi: inffmac: add a new driver directory for infineon WLAN vendor
  wifi: inffmac: add pmsr.c/h
  wifi: inffmac: add he.c/h
  wifi: inffmac: add twt.c/h
  wifi: inffmac: add trxhdr.h
  wifi: inffmac: add chip.c/h
  wifi: inffmac: add chip_{5591x/5551x/5557x/43022}.c/h
  wifi: inffmac: add icdc.c/h
  wifi: inffmac: add dfu.c/h
  wifi: inffmac: add firmware.c/h
  wifi: inffmac: add vendor.c/h
  wifi: inffmac: add main.c/h
  wifi: inffmac: add dev_evt.c/h
  wifi: inffmac: add dev_cmd.c/h
  wifi: inffmac: add net.c/h
  wifi: inffmac: add cfg80211.c/h
  wifi: inffmac: add msgbuf.c/h
  wifi: inffmac: add pcie.c/h
  wifi: inffmac: add p2p.c/h
  wifi: inffmac: add interface.c/h
  wifi: inffmac: add feature.c/h
  wifi: inffmac: add bus_proto.c/h
  wifi: inffmac: add commonring.c/h
  wifi: inffmac: add flowring.c/h
  wifi: inffmac: add sdio.c/h
  wifi: inffmac: add ie.c/h
  wifi: inffmac: add scan.c/h
  wifi: inffmac: add fwsignal.c/h
  wifi: inffmac: add security.c/h
  wifi: inffmac: add bcdc.c/h
  wifi: inffmac: add chan.c/h
  wifi: inffmac: add debug.c/h
  wifi: inffmac: add utils.c/h
  wifi: inffmac: add Kconfig, Makefile

 drivers/net/wireless/Kconfig                  |    1 +
 drivers/net/wireless/Makefile                 |    1 +
 drivers/net/wireless/infineon/Kconfig         |   25 +
 drivers/net/wireless/infineon/Makefile        |   12 +
 drivers/net/wireless/infineon/inffmac/Kconfig |   44 +
 .../net/wireless/infineon/inffmac/Makefile    |   52 +
 drivers/net/wireless/infineon/inffmac/bcdc.c  |  525 ++
 drivers/net/wireless/infineon/inffmac/bcdc.h  |   27 +
 .../net/wireless/infineon/inffmac/bus_proto.c |  158 +
 .../net/wireless/infineon/inffmac/bus_proto.h |  428 +
 .../net/wireless/infineon/inffmac/cfg80211.c  | 4984 +++++++++++
 .../net/wireless/infineon/inffmac/cfg80211.h  |  346 +
 drivers/net/wireless/infineon/inffmac/chan.c  |  982 +++
 drivers/net/wireless/infineon/inffmac/chan.h  |  356 +
 drivers/net/wireless/infineon/inffmac/chip.c  | 1626 ++++
 drivers/net/wireless/infineon/inffmac/chip.h  |  636 ++
 .../wireless/infineon/inffmac/chip_43022.c    |   30 +
 .../wireless/infineon/inffmac/chip_43022.h    |   31 +
 .../wireless/infineon/inffmac/chip_5551x.c    |   37 +
 .../wireless/infineon/inffmac/chip_5551x.h    |   24 +
 .../wireless/infineon/inffmac/chip_5557x.c    |   31 +
 .../wireless/infineon/inffmac/chip_5557x.h    |   24 +
 .../wireless/infineon/inffmac/chip_5591x.c    |   33 +
 .../wireless/infineon/inffmac/chip_5591x.h    |   37 +
 .../wireless/infineon/inffmac/commonring.c    |  237 +
 .../wireless/infineon/inffmac/commonring.h    |   63 +
 drivers/net/wireless/infineon/inffmac/debug.c |  117 +
 drivers/net/wireless/infineon/inffmac/debug.h |  174 +
 .../net/wireless/infineon/inffmac/dev_cmd.c   |  727 ++
 .../net/wireless/infineon/inffmac/dev_cmd.h   | 1261 +++
 .../net/wireless/infineon/inffmac/dev_evt.c   | 1841 ++++
 .../net/wireless/infineon/inffmac/dev_evt.h   |  446 +
 drivers/net/wireless/infineon/inffmac/dfu.c   |  883 ++
 drivers/net/wireless/infineon/inffmac/dfu.h   |  109 +
 .../net/wireless/infineon/inffmac/feature.c   |  319 +
 .../net/wireless/infineon/inffmac/feature.h   |  129 +
 .../net/wireless/infineon/inffmac/firmware.c  | 1012 +++
 .../net/wireless/infineon/inffmac/firmware.h  |  109 +
 .../net/wireless/infineon/inffmac/flowring.c  |  403 +
 .../net/wireless/infineon/inffmac/flowring.h  |   65 +
 .../net/wireless/infineon/inffmac/fwsignal.c  | 2718 ++++++
 .../net/wireless/infineon/inffmac/fwsignal.h  |   53 +
 drivers/net/wireless/infineon/inffmac/he.c    |  234 +
 drivers/net/wireless/infineon/inffmac/he.h    |   67 +
 drivers/net/wireless/infineon/inffmac/icdc.c  |  450 +
 drivers/net/wireless/infineon/inffmac/icdc.h  |   34 +
 drivers/net/wireless/infineon/inffmac/ie.c    |  789 ++
 drivers/net/wireless/infineon/inffmac/ie.h    |  203 +
 .../net/wireless/infineon/inffmac/interface.c |  803 ++
 .../net/wireless/infineon/inffmac/interface.h |  183 +
 drivers/net/wireless/infineon/inffmac/main.c  | 1133 +++
 drivers/net/wireless/infineon/inffmac/main.h  |  377 +
 .../net/wireless/infineon/inffmac/msgbuf.c    | 2004 +++++
 .../net/wireless/infineon/inffmac/msgbuf.h    |  112 +
 drivers/net/wireless/infineon/inffmac/net.c   |  695 ++
 drivers/net/wireless/infineon/inffmac/net.h   |   42 +
 drivers/net/wireless/infineon/inffmac/p2p.c   | 2379 ++++++
 drivers/net/wireless/infineon/inffmac/p2p.h   |  202 +
 drivers/net/wireless/infineon/inffmac/pcie.c  | 2642 ++++++
 drivers/net/wireless/infineon/inffmac/pcie.h  |   27 +
 drivers/net/wireless/infineon/inffmac/pmsr.c  | 1131 +++
 drivers/net/wireless/infineon/inffmac/pmsr.h  |   43 +
 drivers/net/wireless/infineon/inffmac/scan.c  | 1205 +++
 drivers/net/wireless/infineon/inffmac/scan.h  |  203 +
 drivers/net/wireless/infineon/inffmac/sdio.c  | 7529 +++++++++++++++++
 drivers/net/wireless/infineon/inffmac/sdio.h  |  286 +
 .../net/wireless/infineon/inffmac/security.c  | 1416 ++++
 .../net/wireless/infineon/inffmac/security.h  |  263 +
 .../net/wireless/infineon/inffmac/trxhdr.h    |   54 +
 drivers/net/wireless/infineon/inffmac/twt.c   | 1214 +++
 drivers/net/wireless/infineon/inffmac/twt.h   |  442 +
 drivers/net/wireless/infineon/inffmac/utils.c |  291 +
 drivers/net/wireless/infineon/inffmac/utils.h |  233 +
 .../net/wireless/infineon/inffmac/vendor.c    | 1344 +++
 .../net/wireless/infineon/inffmac/vendor.h    |  322 +
 include/linux/ieee80211-p2p.h                 |   25 +
 include/linux/ieee80211.h                     |   42 +
 include/linux/mmc/sdio_ids.h                  |    4 +
 include/linux/pci_ids.h                       |    3 +
 79 files changed, 49542 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/Kconfig
 create mode 100644 drivers/net/wireless/infineon/Makefile
 create mode 100644 drivers/net/wireless/infineon/inffmac/Kconfig
 create mode 100644 drivers/net/wireless/infineon/inffmac/Makefile
 create mode 100644 drivers/net/wireless/infineon/inffmac/bcdc.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/bcdc.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/bus_proto.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/bus_proto.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/cfg80211.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/cfg80211.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/chan.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/chan.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip_43022.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip_43022.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip_5551x.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip_5551x.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip_5557x.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip_5557x.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip_5591x.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip_5591x.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/commonring.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/commonring.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/debug.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/debug.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/dev_cmd.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/dev_cmd.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/dev_evt.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/dev_evt.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/dfu.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/dfu.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/feature.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/feature.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/firmware.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/firmware.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/flowring.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/flowring.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/fwsignal.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/fwsignal.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/he.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/he.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/icdc.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/icdc.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/ie.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/ie.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/interface.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/interface.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/main.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/main.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/msgbuf.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/msgbuf.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/net.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/net.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/p2p.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/p2p.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/pcie.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/pcie.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/pmsr.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/pmsr.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/scan.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/scan.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/sdio.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/sdio.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/security.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/security.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/trxhdr.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/twt.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/twt.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/utils.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/utils.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/vendor.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/vendor.h


base-commit: 24a57985670e9dac5547e5b7731bf8e7b03d5be8
-- 
2.25.1


