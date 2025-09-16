Return-Path: <linux-wireless+bounces-27353-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B0BB7D5E0
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9908E3A804D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DF228725B;
	Tue, 16 Sep 2025 22:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="I71B2TGs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D8A288AD
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061188; cv=none; b=GsQ2ljxk++E7gQxZ5j8f6QAs8hdu5VJcMutPHwpu8SvzPd4w7JEfK7sXm1IQh3VdKmRV12z3UReug1e52UKu8s/yPBYo7S2VEAScub0JDKwV4hEOaIHufmZlm1ljzoPSdLijSzyqmB6C+VsHER6sShoM7pVLbhJYgg6HVyumWLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061188; c=relaxed/simple;
	bh=nSZmlnCQf5iV/MR6E8o8M625yAOXejcxHxvBckYRQdE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MVJDatrIDwLfbAjHpZBudgymOn8exq7yGyMRyTjl+eG44RHRnK1gFgBsCx2vVhQbhhvxyy9g09qLEtRgOuTXcatZvXWT4PRbeVCHH9HxXKkuPTGQJosK7WM8fLzuW1KvZv7+eHe9+s9MDySlOK6ssEgrRtSzADYTXFZiTFMasM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=I71B2TGs; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061186; x=1789597186;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nSZmlnCQf5iV/MR6E8o8M625yAOXejcxHxvBckYRQdE=;
  b=I71B2TGsvuAcvQnwY1KGul13a6Yw7pDtzNsO2+TdiU+UoGeHLz/NKq31
   +QJnnXNG6hjqlFgUOjUi8t0QpX5Ykg7dqD5ICZgENF4ZHfYbL92ubJDGk
   eloQHvHjtK49Lnl+oG83uZOuGYnvUc487tXLJmMk2N9TQfiHdzooNUiUK
   M=;
X-CSE-ConnectionGUID: KltgTBdCQ0ureq/pwP8g7g==
X-CSE-MsgGUID: kmWuhzSFSHy02jMcpo2XSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="110918054"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="110918054"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:18:36 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:18:35 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:18:30 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>, Carter Chen <Carter.Chen@infineon.com>,
	Owen Huang <Owen.Huang@infineon.com>, Ian Lin <Ian.Lin@infineon.com>,
	JasonHuang <Jason.Huang2@infineon.com>, Shelley Yang
	<Shelley.Yang@infineon.com>, avishad verma <avishad.verma@infineon.com>
Subject: [PATCH wireless-next 00/57] wifi: inffmac: introducing a driver for Infineon's new generation chipsets
Date: Wed, 17 Sep 2025 03:47:15 +0530
Message-ID: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MUCSE804.infineon.com (172.23.29.30) To
 MUCSE827.infineon.com (172.23.29.20)

Infineon is introducing a new INFFMAC (WLAN FULLMAC) Linux driver
specifically for Infineon's new-generation AIROC family of
Wi-Fi + Bluetooth combo chipsets (CYW5557x, CYW5551x, CYW5591x, CYW43022,
and any future chipsets). These chipsets will be interfaced with host
machines over the PCIe and SDIO bus. Infineon product briefs and datasheets
are available in https://www.infineon.com/products/wireless-connectivity

These new-generation Infineon chipsets listed above are tailor-made for a
wide variety of IoT use cases and provide support for multiple host bus
interfaces (eventually gSPI, SPI, I2C, USB, and UART support will be added
in future contributions). In addition, these new chipsets support IoT mode
of operations that require an Infineon-proprietary secured firmware
architecture.

By default, this driver expects the device firmware/image/NVRAM/CLM_BLOB
files in the filesystem path /lib/firmware/infineon/ with the file name
prefix “inffmac*” (for example: inffmac43022-sdio.trxs). This driver is
tested for AP, STA, and P2P operation modes on Intel NUC platform with
the v6.16.2 stable kernel version. 

We have split the driver into smaller commits to make the review easier,
Final version would be a single commit for the inffmac driver cahnges.
Kindly let us know if there is anything else that we can do to help with
the review. Completed checkpatch verification with current default max
line length (100) used in linux. If checkpatch is ran with a line
length restriction of 80 characters, then we can expect some warnings.

Some of the major features that this new WLAN driver supports are:

  * 802.11ax (Wi-Fi 6) operation – Most of these  new-generation Infineon
    chipsets support Wi-Fi 6 operation, each with varying spatial stream
    (1x1/2x2) and bandwidth (20/40/80 MHz) capabilities. Also supported are
    optional 802.11ax features like Target Wake Time (TWT) and 1024 QAM.
	
  * eXpress Data Path (XDP) for WLAN – This driver introduces support for
    having a programmable network data path, by allowing native XDP program
    execution in the WLAN driver layer even before socket buffer (SKB)
    allocation for all RX data packets received over the PCIe bus from
    firmware. The FULLMAC nature of Infineon’s WLAN NIC makes it suitable
    for XDP program execution directly on the 802.3 packet received from
    the device through DMA, just like an Ethernet NIC.
   	
    Currently, the supported XDP actions are XDP_PASS, XDP_DROP, and
    XDP_ABORTED. There are plans to further extend this support to XDP_TX
    and XDP_REDIRECT actions later. Having support for XDP is beneficial
    for a variety of use cases, like being helpful in efficiently dropping
    unwanted RX packets and in-place (zero-copy) packet modification before
    passing the RX packet to the network stack.
	
  * Fine timing measurement (FTM) support – This driver has FTM support
    to find the accurate round-trip time (RTT) between another supported
    peer WLAN device using the Peer Measurement Request (PMSR)
    infrastructure currently available in nl80211/cfg80211.
	
  * WLAN sensing support – This driver provides a mechanism to collect
    the Channel State Information (CSI) using the WLAN device. For the
    WLAN sensing measurement, this driver leverages and extends the
    existing Peer Measurement Request (PMSR) infrastructure currently
    available in nl80211/cfg80211 since  it supports only one type of
    measurement (FTM).
	
    This driver also introduces a new wdev interface (non netdev) type
    “WLAN_SENSE” in the Linux nl80211/cfg80211 layer to allow 802.11
    frame transmissions with a specific MAC address, which would be used
    by the device during solicited WLAN sensing measurement.

  * Connectivity processor (CP) support – IoT applications often demand a
    WLAN solution with optimal power save and extensive network offloads.
    Infineon's CYW5591x sub-family of chipsets supported by this driver
    follows the connectivity processor (CP) architecture which provides
    wireless connectivity along with a host network offload.
	
  * Bluetooth shared SDIO – This feature allows sharing a common SDIO bus
    interface between the Bluetooth host Linux driver and WLAN host Linux
    driver for any operations to be done in these Wi-Fi + Bluetooth combo
    chipsets.	

  * Cloud management support – IoT applications need a WLAN solution with
    varied cloud-based control and compatibility interfaces. Infineon's
    CYW5591x sub-family chipset architecture supported by this driver
    provides wireless connectivity along with cloud-based management of
    the devices.
	
  * Ultra-low-power (ULP) mode for IoT device – This driver can make the
    Infineon chipset operate in an ultra-low-power (ULP) mode. This helps
    the IoT device maximize the power savings to have a longer battery
    life.
	
  * Driver debugging with logger support – This driver Introduces a debug
    mechanism within the driver to log the important event/state
    information in a ring buffer, which is helpful in debugging when the
    intermittent issue occurred.
	
  * Wi-Fi security offload – This driver can offload multiple Wi-Fi
    security operations like Simultaneous Authentication of Equals (SAE),
    Opportunistic Wireless Encryption (OWE), and Extensible Authentication
    Protocol over LAN (EAPoL) 4-way handshake from the host machine to the
    WLAN device. The device firmware takes care of the authentication frame
    exchange and key derivation.
	
  * Packet offload – The device driver provides an option to configure a
    wide range of packet offloads in the device as per the end use case,
    like MQTT Keepalive Ping Request offload, ICMP Echo Ping Request
    offload, Multicast DNS Query Response offload, and ICMP Echo Response
    offload.

  * Infineon vendor nl80211 interface – This driver exposes an Infineon
    OUI-based vendor nl80211 interface for allowing Infineon's
    vendor-specific WLAN operations from the user space  for operations
    that are not feasible over the standard nl80211 path.

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
Co-developed-by: avishad verma <avishad.verma@infineon.com>
Signed-off-by: avishad verma <avishad.verma@infineon.com>
Signed-off-by: Double Lo <Double.Lo@infineon.com>
Signed-off-by: Vinoth Sampath <Vinoth.Sampath@infineon.com>

Infineon’s new and future chipsets are significantly different from the
older chipsets that are currently being supported by the existing BRCMFMAC
driver. As BRCMFMAC has a shared ownership structure with multiple (more
than three) WLAN chip vendor organizations, it has posed a significant
challenge to Infineon in retrofitting the new Infineon chip architectures
on the older legacy Broadcom architecture WLAN driver. This is why Infineon
plans to support all newer generations of its chipsets with the new INFFMAC
driver only. 

The following are some of the details of the challenges Infineon has faced
supporting the new chipsets through the BRCMFMAC driver.

  * Missing driver capability for supporting a secured and signed firmware
    architecture – Infineon’s new and future chipsets support IoT mode of
    operations that requires an Infineon-proprietary secured firmware
    architecture. This new secure firmware architecture demands a unique
    vendor-specific handshake between the host machine and new Infineon
    chipsets for both bring up and normal operation, because of firmware
    encryption and firmware signature validation. This host-device
    handshake flow will be maintained and upgraded for the current
    (already launched) and future chipsets based on the newer secure
    architecture extension.

    The driver capability to do the handshake with the chipset and download
    the secured and signed firmware on the chipset is not available with
    the BRCMMFAC driver. This is critical for IoT devices to ensure
    firmware integrity and restrict any unauthorized access.

  * Control path and IOCTL/IOVAR conflicts – Because each WLAN vendor
    started naturally diverging with their host driver <-> device firmware
    control interface command and event path, the chances of functionality
    regressions occurring on other vendor's chipset is increasing.
    The introduction of Firmware Vendor ID (FWVID) in BRCMFMAC to change
    the behaviour of the driver based on the WLAN vendor seems to have
    provided a minor interim solution for the conflict in the control
    interface for old chipsets that are being updated with new firmware.
    However, there are still multiple other factors that influence the 
    host driver <-> device firmware communication for the new architecture
    chipsets that are still vendor-specific and cannot be generic for all
    vendors.

  * Missing device firmware update (DFU) infrastructure – Support for
    triggering a device firmware update is crucial for IoT devices that
    must always run the latest firmware available for that device to ensure
    that the device is protected against critical vulnerabilities. Some of
    Infineon’s IoT-specific chipsets have a non-volatile memory, and the
    driver downloads the image file into this memory as part of the OTA
    update process. Current BRCMFMAC driver does not support this
    functionality.

  * Missing support for connectivity processor (CP) Chipsets – The existing
    BRCMFMAC driver does not recognize and have the capability to enumerate
    and manage the new type of connectivity processor (CP) chipsets from
    Infineon, which have WLAN support with extensive network offloads.

  * Host-to-device (H2D) communication protocol changes – In case of chips
    that support PCIe and SDIO bus, the host and device share critical
    information about the communication channel and protocol using the
    fields in the shared memory structure maintained inside the device’s
    memory. Any changes to the shared memory structure or communication
    protocol structures done by a vendor warrants a change in a Shared
    Info Version Number to maintain the compatibility across different
    firmware versions of the same vendor in the driver. In such cases,
    there is an additional complexity of need to maintain a compatibility
    for Shared Info Version and communication protocol changes across
    different firmware versions across different firmware vendors.

  * Device-to-host (D2H) communication changes – In the legacy Broadcom
    architecture, event notifications from the device firmware to the host
    driver are sent as a data packet with an Ethernet header and Broadcom
    Vendor OUI to identify this as a firmware event. Currently BRCMFMAC
    always expects the Broadcom OUI to identify this as a firmware event,
    irrespective of the vendor of the connected chipset. This reuse of same
    OUI across vendors in the same driver source code has multiple
    potential issues and complications.

  * IoT-specific flow changes – To support and manage the Connectivity
    Processor (CP) type of lightweight chipset architectures, the BRCMFMAC
    driver require changes across the layers. These changes would not be
    compatible with the legacy Broadcom architecture chipsets. Making these
    changes would not be compatible with Broadcom and other vendors which
    uses same driver flow.

The newly compiled “inffmac.ko” module can be loaded in the kernel for
newer Infineon chipsets having the newer Infineon architecture
(for example, CYW55573), along with the existing “brcmfmac.ko” and
“brcmfmac-cyw.ko” modules for older Infineon chipsets with the legacy
Broadcom architecture (for example, CYW4373) because both drivers support
different sets of chipsets.

We would like to emphasize that Infineon is committed in continuing to
support the BRCMFMAC driver for existing Infineon chipsets that are already
listed in the upstream kernel BRCMFMAC driver under the Cypress Firmware
Vendor ID (FWVID) label. Infineon also has plans to add upstream BRCMFMAC
driver support for other older Infineon chipsets that have the old legacy
Broadcom architecture.


Gokul Sivakumar (57):
  wifi: nl80211/cfg80211: introduce new iface type for WLAN Sensing
    operation
  wifi: nl80211/cfg80211: add support to do WLAN Sensing operation using
    PMSR
  wifi: ieee80211: add Radio Measurement (RM) Enabled Capabilities
    definition
  mmc: sdio: add SDIO Device ID of new Infineon(Cypress) Wi-Fi+Bluetooth
    chips
  wifi: inffmac: introduce a new driver directory for infineon WLAN
    vendor
  wifi: inffmac: add pmsr.c/h
  wifi: inffmac: add ftm.c/h
  wifi: inffmac: add wlan_sense.c/h
  wifi: inffmac: add offload.c/h
  wifi: inffmac: add he.c/h
  wifi: inffmac: add twt.c/h
  wifi: inffmac: add bt_shared_sdio.c/h
  wifi: inffmac: add trxhdr.h
  wifi: inffmac: add chip.c/h
  wifi: inffmac: add chip_43022.c/h
  wifi: inffmac: add chip_5557x.c/h
  wifi: inffmac: add chip_5551x.c/h
  wifi: inffmac: add chip_5591x.c/h
  wifi: inffmac: add xdp.c/h
  wifi: inffmac: add msgbuf.c/h
  wifi: inffmac: add pcie.c/h
  wifi: inffmac: add vendor.c/h
  wifi: inffmac: add logger.c/h
  wifi: inffmac: add debug.c/h
  wifi: inffmac: add eht.c/h
  wifi: inffmac: add tracepoint.c/h
  wifi: inffmac: add firmware.c/h
  wifi: inffmac: add feature.c/h
  wifi: inffmac: add dfu.c/h
  wifi: inffmac: add bus.h
  wifi: inffmac: add proto.c/h
  wifi: inffmac: add commonring.c/h
  wifi: inffmac: add flowring.c/h
  wifi: inffmac: add sdio.c/h
  wifi: inffmac: add bcdc.c/h
  wifi: inffmac: add infsdh.c
  wifi: inffmac: add fwil.c/h
  wifi: inffmac: add fwil_types.h
  wifi: inffmac: add fweh.c/h
  wifi: inffmac: add fwsignal.c/h
  wifi: inffmac: add xtlv.c/h
  wifi: inffmac: add common.c/h
  wifi: inffmac: add cfg80211.c/h
  wifi: inffmac: add core.c/h
  wifi: inffmac: add btcoex.c/h
  wifi: inffmac: add pno.c/h
  wifi: inffmac: add ie.c/h
  wifi: inffmac; add scan.c/h
  wifi: inffmac: add interface.c/h
  wifi: inffmac: add security.c/h
  wifi: inffmac: add p2p.c/h
  wifi: inffmac: add hw_ids.h
  wifi: inffmac: add chipcommon.h
  wifi: inffmac: add chanspec.c/h
  wifi: inffmac: add utils.c/h
  wifi: inffmac: add defs.h
  wifi: inffmac: add Kconfig, Makefile

 drivers/net/wireless/Kconfig                  |    1 +
 drivers/net/wireless/Makefile                 |    1 +
 drivers/net/wireless/infineon/Kconfig         |   36 +
 drivers/net/wireless/infineon/Makefile        |   12 +
 drivers/net/wireless/infineon/inffmac/Kconfig |   61 +
 .../net/wireless/infineon/inffmac/Makefile    |   65 +
 drivers/net/wireless/infineon/inffmac/bcdc.c  |  521 ++
 drivers/net/wireless/infineon/inffmac/bcdc.h  |   24 +
 .../infineon/inffmac/bt_shared_sdio.c         | 1009 +++
 .../infineon/inffmac/bt_shared_sdio.h         |   35 +
 .../net/wireless/infineon/inffmac/btcoex.c    |  482 ++
 .../net/wireless/infineon/inffmac/btcoex.h    |   22 +
 drivers/net/wireless/infineon/inffmac/bus.h   |  344 +
 .../net/wireless/infineon/inffmac/cfg80211.c  | 6749 +++++++++++++++++
 .../net/wireless/infineon/inffmac/cfg80211.h  |  604 ++
 .../net/wireless/infineon/inffmac/chanspec.c  |  260 +
 .../net/wireless/infineon/inffmac/chanspec.h  |  357 +
 drivers/net/wireless/infineon/inffmac/chip.c  | 1507 ++++
 drivers/net/wireless/infineon/inffmac/chip.h  |  223 +
 .../wireless/infineon/inffmac/chip_43022.c    |   30 +
 .../wireless/infineon/inffmac/chip_43022.h    |   29 +
 .../wireless/infineon/inffmac/chip_5551x.c    |   37 +
 .../wireless/infineon/inffmac/chip_5551x.h    |   24 +
 .../wireless/infineon/inffmac/chip_5557x.c    |   31 +
 .../wireless/infineon/inffmac/chip_5557x.h    |   24 +
 .../wireless/infineon/inffmac/chip_5591x.c    |   24 +
 .../wireless/infineon/inffmac/chip_5591x.h    |   33 +
 .../wireless/infineon/inffmac/chipcommon.h    |  566 ++
 .../net/wireless/infineon/inffmac/common.c    |  765 ++
 .../net/wireless/infineon/inffmac/common.h    |  140 +
 .../wireless/infineon/inffmac/commonring.c    |  237 +
 .../wireless/infineon/inffmac/commonring.h    |   63 +
 drivers/net/wireless/infineon/inffmac/core.c  | 2326 ++++++
 drivers/net/wireless/infineon/inffmac/core.h  |  355 +
 drivers/net/wireless/infineon/inffmac/debug.c |  138 +
 drivers/net/wireless/infineon/inffmac/debug.h |  184 +
 drivers/net/wireless/infineon/inffmac/defs.h  |   21 +
 drivers/net/wireless/infineon/inffmac/dfu.c   |  416 +
 drivers/net/wireless/infineon/inffmac/dfu.h   |   39 +
 drivers/net/wireless/infineon/inffmac/eht.c   |   86 +
 drivers/net/wireless/infineon/inffmac/eht.h   |   42 +
 .../net/wireless/infineon/inffmac/feature.c   |  377 +
 .../net/wireless/infineon/inffmac/feature.h   |  168 +
 .../net/wireless/infineon/inffmac/firmware.c  |  983 +++
 .../net/wireless/infineon/inffmac/firmware.h  |  108 +
 .../net/wireless/infineon/inffmac/flowring.c  |  492 ++
 .../net/wireless/infineon/inffmac/flowring.h  |   74 +
 drivers/net/wireless/infineon/inffmac/ftm.c   |  605 ++
 drivers/net/wireless/infineon/inffmac/ftm.h   |  382 +
 drivers/net/wireless/infineon/inffmac/fweh.c  | 1552 ++++
 drivers/net/wireless/infineon/inffmac/fweh.h  |  402 +
 drivers/net/wireless/infineon/inffmac/fwil.c  |  539 ++
 drivers/net/wireless/infineon/inffmac/fwil.h  |  119 +
 .../wireless/infineon/inffmac/fwil_types.h    | 1311 ++++
 .../net/wireless/infineon/inffmac/fwsignal.c  | 2739 +++++++
 .../net/wireless/infineon/inffmac/fwsignal.h  |   53 +
 drivers/net/wireless/infineon/inffmac/he.c    |  239 +
 drivers/net/wireless/infineon/inffmac/he.h    |   58 +
 .../net/wireless/infineon/inffmac/hw_ids.h    |   26 +
 drivers/net/wireless/infineon/inffmac/ie.c    |  801 ++
 drivers/net/wireless/infineon/inffmac/ie.h    |  167 +
 .../net/wireless/infineon/inffmac/infsdh.c    | 1367 ++++
 .../net/wireless/infineon/inffmac/interface.c |  523 ++
 .../net/wireless/infineon/inffmac/interface.h |   80 +
 .../net/wireless/infineon/inffmac/logger.c    |  189 +
 .../net/wireless/infineon/inffmac/logger.h    |  133 +
 .../net/wireless/infineon/inffmac/msgbuf.c    | 2205 ++++++
 .../net/wireless/infineon/inffmac/msgbuf.h    |  109 +
 .../net/wireless/infineon/inffmac/offload.c   |  429 ++
 .../net/wireless/infineon/inffmac/offload.h   |  215 +
 drivers/net/wireless/infineon/inffmac/p2p.c   | 2605 +++++++
 drivers/net/wireless/infineon/inffmac/p2p.h   |  186 +
 drivers/net/wireless/infineon/inffmac/pcie.c  | 2909 +++++++
 drivers/net/wireless/infineon/inffmac/pcie.h  |   19 +
 drivers/net/wireless/infineon/inffmac/pmsr.c  |  282 +
 drivers/net/wireless/infineon/inffmac/pmsr.h  |   35 +
 drivers/net/wireless/infineon/inffmac/pno.c   |  770 ++
 drivers/net/wireless/infineon/inffmac/pno.h   |  140 +
 drivers/net/wireless/infineon/inffmac/proto.c |   71 +
 drivers/net/wireless/infineon/inffmac/proto.h |  192 +
 drivers/net/wireless/infineon/inffmac/scan.c  | 1025 +++
 drivers/net/wireless/infineon/inffmac/scan.h  |  127 +
 drivers/net/wireless/infineon/inffmac/sdio.c  | 5909 +++++++++++++++
 drivers/net/wireless/infineon/inffmac/sdio.h  |  553 ++
 .../net/wireless/infineon/inffmac/security.c  |  752 ++
 .../net/wireless/infineon/inffmac/security.h  |  212 +
 .../wireless/infineon/inffmac/tracepoint.c    |   35 +
 .../wireless/infineon/inffmac/tracepoint.h    |  138 +
 .../net/wireless/infineon/inffmac/trxhdr.h    |   54 +
 drivers/net/wireless/infineon/inffmac/twt.c   | 1200 +++
 drivers/net/wireless/infineon/inffmac/twt.h   |  334 +
 drivers/net/wireless/infineon/inffmac/utils.c |  323 +
 drivers/net/wireless/infineon/inffmac/utils.h |  254 +
 .../net/wireless/infineon/inffmac/vendor.c    |  338 +
 .../net/wireless/infineon/inffmac/vendor.h    |   54 +
 .../wireless/infineon/inffmac/vendor_inf.c    | 1344 ++++
 .../wireless/infineon/inffmac/vendor_inf.h    |  767 ++
 .../wireless/infineon/inffmac/wlan_sense.c    |  916 +++
 .../wireless/infineon/inffmac/wlan_sense.h    |  177 +
 drivers/net/wireless/infineon/inffmac/xdp.c   |  155 +
 drivers/net/wireless/infineon/inffmac/xdp.h   |   31 +
 drivers/net/wireless/infineon/inffmac/xtlv.c  |  106 +
 drivers/net/wireless/infineon/inffmac/xtlv.h  |   37 +
 include/linux/ieee80211.h                     |   47 +
 include/linux/mmc/sdio_ids.h                  |    4 +
 include/net/cfg80211.h                        |   91 +-
 include/uapi/linux/nl80211.h                  |  130 +
 net/mac80211/cfg.c                            |    1 +
 net/mac80211/chan.c                           |    2 +
 net/mac80211/iface.c                          |    2 +
 net/mac80211/util.c                           |    1 +
 net/wireless/chan.c                           |    2 +
 net/wireless/core.c                           |  119 +-
 net/wireless/core.h                           |    3 +
 net/wireless/nl80211.c                        |  133 +
 net/wireless/pmsr.c                           |  143 +
 net/wireless/rdev-ops.h                       |   19 +
 net/wireless/trace.h                          |   10 +
 net/wireless/util.c                           |    1 +
 119 files changed, 57094 insertions(+), 32 deletions(-)
 create mode 100644 drivers/net/wireless/infineon/Kconfig
 create mode 100644 drivers/net/wireless/infineon/Makefile
 create mode 100644 drivers/net/wireless/infineon/inffmac/Kconfig
 create mode 100644 drivers/net/wireless/infineon/inffmac/Makefile
 create mode 100644 drivers/net/wireless/infineon/inffmac/bcdc.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/bcdc.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/bt_shared_sdio.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/bt_shared_sdio.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/btcoex.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/btcoex.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/bus.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/cfg80211.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/cfg80211.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/chanspec.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/chanspec.h
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
 create mode 100644 drivers/net/wireless/infineon/inffmac/chipcommon.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/common.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/common.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/commonring.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/commonring.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/core.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/core.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/debug.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/debug.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/defs.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/dfu.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/dfu.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/eht.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/eht.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/feature.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/feature.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/firmware.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/firmware.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/flowring.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/flowring.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/ftm.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/ftm.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/fweh.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/fweh.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/fwil.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/fwil.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/fwil_types.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/fwsignal.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/fwsignal.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/he.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/he.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/hw_ids.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/ie.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/ie.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/infsdh.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/interface.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/interface.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/logger.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/logger.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/msgbuf.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/msgbuf.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/offload.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/offload.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/p2p.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/p2p.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/pcie.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/pcie.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/pmsr.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/pmsr.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/pno.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/pno.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/proto.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/proto.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/scan.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/scan.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/sdio.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/sdio.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/security.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/security.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/tracepoint.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/tracepoint.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/trxhdr.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/twt.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/twt.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/utils.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/utils.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/vendor.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/vendor.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/vendor_inf.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/vendor_inf.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/wlan_sense.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/wlan_sense.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/xdp.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/xdp.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/xtlv.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/xtlv.h


base-commit: d103f26a5c8599385acb2d2e01dfbaedb00fdc0a
-- 
2.25.1


