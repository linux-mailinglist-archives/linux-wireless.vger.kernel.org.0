Return-Path: <linux-wireless+bounces-27884-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF54BC476C
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 12:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E315189D59D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Oct 2025 10:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD3B241663;
	Wed,  8 Oct 2025 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="a41Yrmyg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3CC208CA
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920954; cv=none; b=QpLearUTw4BB2N+mQuR+/7FyqWCvNabklzZUinJ839cuxhJ07lth2svZC8jztka+V3u3o8dglkz1JSHEJIrbz3/AZ7h9IJDOJesnkddbbGRDnqWWp9BrBv1YPVBMQZdzIQD5o5mvKq1cHVnPIcNMPuv9uHZCDdpW+M5jcGv+O2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920954; c=relaxed/simple;
	bh=J24pvBFS0A2btlP+wO0p0MRTheosNO491NT3QNdTKGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QjoWs98vi49dvRENeponmtlzpJzTtkoC8VoB9JpYXYH6xlMPk7veSnokvifnBaKtv1NhtHK8ikx3wygReWSV28ntGk5DUrYCw5a+FqyXezjXvHEf2o0bPxMwN/mitjHUtpsAvGtKaUcMosaUf1kYKUbj7t/2wNTvi3I8qclNeG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=a41Yrmyg; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=eEQ+BzeNHkDjDDW2U//sRkzDDTpom08ATFXkLkhYDME=; b=a41YrmyggUq+IrxlN4YxR40jnj
	HOpZlckA4zW0dCHAitLySy8D2P80GFNc2Zna1TG88/TKa0TuXy0tmQ164HRT6xQjKfTwkAza+6atg
	WSwxPJAsqvuoO6YhqtN2wx9lxK9qgj5hFkjz+JBGtk+L656Z0IbSVNULvtsai/88UqI4=;
Received: from p4ff13580.dip0.t-ipconnect.de ([79.241.53.128] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1v6RdD-001RwO-23;
	Wed, 08 Oct 2025 12:42:51 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: steven.liu@mediatek.com,
	Evelyn.Tsai@mediatek.com,
	Shayne.Chen@mediatek.com,
	Mark-MC.Lee@mediatek.com
Subject: [PATCH 2/2] wifi: mt76: relicense to BSD-3-Clause-Clear
Date: Wed,  8 Oct 2025 12:42:50 +0200
Message-ID: <20251008104250.46292-2-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008104250.46292-1-nbd@nbd.name>
References: <20251008104250.46292-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MediaTek has asked to switch from the ISC license to BSD-3-Clause-Clear,
in order to improve clarity and the legal integrity of the code.

The BSD-3-Clause license includes the "no endorsement" clause, which is
important for protecting the reputation of the original authors and
contributors by preventing unauthorized use of their names for endorsement
purposes.

This clause is absent in the BSD-2-Clause license, which is more permissive
but lacks this specific protection.

This change also cleans up the license of some Kconfig/Makefile files,
which were accidentally marked as GPL.

The GPL 2.0 remains in use on mt76x0, as well as two source files in mt7615
for which the license situation still needs to be clarified.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/Kconfig               | 2 +-
 drivers/net/wireless/mediatek/mt76/Makefile              | 2 +-
 drivers/net/wireless/mediatek/mt76/agg-rx.c              | 2 +-
 drivers/net/wireless/mediatek/mt76/channel.c             | 2 +-
 drivers/net/wireless/mediatek/mt76/debugfs.c             | 2 +-
 drivers/net/wireless/mediatek/mt76/dma.c                 | 2 +-
 drivers/net/wireless/mediatek/mt76/dma.h                 | 2 +-
 drivers/net/wireless/mediatek/mt76/eeprom.c              | 2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c            | 2 +-
 drivers/net/wireless/mediatek/mt76/mcu.c                 | 2 +-
 drivers/net/wireless/mediatek/mt76/mmio.c                | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76.h                | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/Kconfig        | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/Makefile       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/core.c         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/init.c         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.h          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mcu.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mcu.h          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/pci.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/regs.h         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/soc.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/Kconfig        | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/Makefile       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/init.c         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615_trace.h | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/soc.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/testmode.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/trace.c        | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac.h         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/pci_mcu.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h             | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_dfs.h         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_dma.h         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.h      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.h         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mcu.h         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c        | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_phy.c         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_phy.h         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_regs.h        | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_trace.c       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_trace.h       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c        | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_usb.h         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c        | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig        | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/Makefile       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.h       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/init.c         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mac.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mac.h          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mcu.h          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2u.h      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_mcu.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/phy.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_mac.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_mcu.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/Kconfig        | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/Makefile       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/coredump.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/coredump.h     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.h          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/testmode.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/testmode.h     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/Kconfig        | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/Makefile       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.h          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/regs.h         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/testmode.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/Kconfig        | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/Makefile       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/init.c         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.h          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/regs.h         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/testmode.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h              | 2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_debugfs.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_trace.c        | 2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_trace.h        | 2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/Kconfig        | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/Makefile       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/coredump.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/coredump.h     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/init.c         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.h          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c          | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h         | 2 +-
 drivers/net/wireless/mediatek/mt76/pci.c                 | 2 +-
 drivers/net/wireless/mediatek/mt76/scan.c                | 2 +-
 drivers/net/wireless/mediatek/mt76/sdio.c                | 2 +-
 drivers/net/wireless/mediatek/mt76/sdio.h                | 2 +-
 drivers/net/wireless/mediatek/mt76/sdio_txrx.c           | 2 +-
 drivers/net/wireless/mediatek/mt76/testmode.c            | 2 +-
 drivers/net/wireless/mediatek/mt76/testmode.h            | 2 +-
 drivers/net/wireless/mediatek/mt76/trace.c               | 2 +-
 drivers/net/wireless/mediatek/mt76/trace.h               | 2 +-
 drivers/net/wireless/mediatek/mt76/tx.c                  | 2 +-
 drivers/net/wireless/mediatek/mt76/usb.c                 | 2 +-
 drivers/net/wireless/mediatek/mt76/usb_trace.c           | 2 +-
 drivers/net/wireless/mediatek/mt76/usb_trace.h           | 2 +-
 drivers/net/wireless/mediatek/mt76/util.c                | 2 +-
 drivers/net/wireless/mediatek/mt76/util.h                | 2 +-
 drivers/net/wireless/mediatek/mt76/wed.c                 | 2 +-
 211 files changed, 211 insertions(+), 211 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/Kconfig b/drivers/net/wireless/mediatek/mt76/Kconfig
index a86f800b8bf5..d0aff94075d6 100644
--- a/drivers/net/wireless/mediatek/mt76/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/Kconfig
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: BSD-3-Clause-Clear
 config MT76_CORE
 	tristate
 	select PAGE_POOL
diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index 87512d101a91..53e7bcefe770 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: BSD-3-Clause-Clear
 obj-$(CONFIG_MT76_CORE) += mt76.o
 obj-$(CONFIG_MT76_USB) += mt76-usb.o
 obj-$(CONFIG_MT76_SDIO) += mt76-sdio.o
diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wireless/mediatek/mt76/agg-rx.c
index 936ab1ca9246..3d34caf7e4f7 100644
--- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
+++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2018 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/channel.c b/drivers/net/wireless/mediatek/mt76/channel.c
index 130af1b254db..2b705bdb7993 100644
--- a/drivers/net/wireless/mediatek/mt76/channel.c
+++ b/drivers/net/wireless/mediatek/mt76/channel.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2024 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index b6a2746c187d..5a105c8b0bfd 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 1fa7de1d2c45..27aa591ff2ea 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/dma.h b/drivers/net/wireless/mediatek/mt76/dma.h
index 17a80e1757fc..d41f978d4d7d 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.h
+++ b/drivers/net/wireless/mediatek/mt76/dma.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index a987c5e4eff6..f3855a941e5a 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 5ceaf78c9ea0..4be47aea2253 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
index 65d4c2adb538..535c3d8a9cc0 100644
--- a/drivers/net/wireless/mediatek/mt76/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2019 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mmio.c b/drivers/net/wireless/mediatek/mt76/mmio.c
index cd2e9737c3bf..0ea97295f5c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mmio.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index e0d50b58cd01..a5e7c573cb40 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7603/Kconfig
index dd16acfd9735..ae40a596e49c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/Kconfig
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: BSD-3-Clause-Clear
 config MT7603E
 	tristate "MediaTek MT7603E (PCIe) and MT76x8 WLAN support"
 	select MT76_CORE
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/Makefile b/drivers/net/wireless/mediatek/mt76/mt7603/Makefile
index 6878e305c24d..e954165ee133 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: BSD-3-Clause-Clear
 obj-$(CONFIG_MT7603E) += mt7603e.o
 
 mt7603e-y := \
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
index 6457ee06bb5a..300a7f9c2ef1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 
 #include "mt7603.h"
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/core.c b/drivers/net/wireless/mediatek/mt76/mt7603/core.c
index 915b8349146a..9c2943fd904e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/core.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 
 #include "mt7603.h"
 #include "../trace.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
index 3967f2f05774..c891ad5498e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 
 #include "mt7603.h"
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index e26cc78fff94..3a16851524a0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 
 #include "mt7603.h"
 #include "mac.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
index 88382b537a33..b89db2db6573 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 
 #include <linux/of.h>
 #include "mt7603.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h
index 4687d6dc00dc..b6b746d1e56f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 
 #ifndef __MT7603_EEPROM_H
 #define __MT7603_EEPROM_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 86617a3e4328..10f2ec70c792 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 
 #include <linux/etherdevice.h>
 #include "mt7603.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 6387f9e61060..d3110eeb45d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 
 #include <linux/etherdevice.h>
 #include <linux/timekeeping.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.h b/drivers/net/wireless/mediatek/mt76/mt7603/mac.h
index 17e34ecf2bfb..9f5fab51ff83 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 
 #ifndef __MT7603_MAC_H
 #define __MT7603_MAC_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 0d7c84941cd0..0f3a7508996c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 
 #include <linux/etherdevice.h>
 #include <linux/platform_device.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
index 301668c3cc92..e432cce97640 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 
 #include <linux/firmware.h>
 #include "mt7603.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.h
index 30df8a3fd11a..7debe76cd092 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 
 #ifndef __MT7603_MCU_H
 #define __MT7603_MCU_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index 55a034ccbacd..071bfab3af7c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 
 #ifndef __MT7603_H
 #define __MT7603_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/pci.c b/drivers/net/wireless/mediatek/mt76/mt7603/pci.c
index 3d94cdb4314a..5fee610597a4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/pci.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/regs.h b/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
index 524bceb8e958..97942f5ebdb4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 
 #ifndef __MT7603_REGS_H
 #define __MT7603_REGS_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/soc.c b/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
index 1dd372372048..b74256efba55 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
index 1ab1439143f4..8cc0c1b5c24e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: BSD-3-Clause-Clear
 
 config MT7615_COMMON
 	tristate
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
index 2b97b9dde477..4def3b13eae1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: ISC
+# SPDX-License-Identifier: BSD-3-Clause-Clear
 
 obj-$(CONFIG_MT7615_COMMON) += mt7615-common.o
 obj-$(CONFIG_MT7615E) += mt7615e.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 2a6d317db5e0..0f7b20152279 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 
 #include "mt7615.h"
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index bcf7864312d7..59d2b3e8696b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2019 MediaTek Inc.
  *
  * Author: Ryder Lee <ryder.lee@mediatek.com>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index d4bc7e11e772..d6828e1cda19 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2019 MediaTek Inc.
  *
  * Author: Ryder Lee <ryder.lee@mediatek.com>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
index a67fbb90f5b3..6aed52e14181 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2019 MediaTek Inc. */
 
 #ifndef __MT7615_EEPROM_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 3e7af3e58736..42e11ba1206e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2019 MediaTek Inc.
  *
  * Author: Roy Luo <royluo@google.com>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index f8d2cc94b742..bd56cdb022a2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2019 MediaTek Inc.
  *
  * Author: Ryder Lee <ryder.lee@mediatek.com>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index d08fbe64c262..336ebce5db5f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2019 MediaTek Inc. */
 
 #ifndef __MT7615_MAC_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 15fe155ac3f3..727266892c3d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2019 MediaTek Inc.
  *
  * Author: Roy Luo <royluo@google.com>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 4064e193d4de..52bbedda672b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2019 MediaTek Inc.
  *
  * Author: Roy Luo <royluo@google.com>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 8e9604be0792..851b0e4839b5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2019 MediaTek Inc. */
 
 #ifndef __MT7615_MCU_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index dbb2c82407df..da7edd48ce2c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include <linux/kernel.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 9bdd29e8d25e..e16865dd8e52 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2019 MediaTek Inc. */
 
 #ifndef __MT7615_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615_trace.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615_trace.h
index 9be5a58a4e6d..697fc5d225de 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615_trace.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615_trace.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2019 Lorenzo Bianconi <lorenzo@kernel.org>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index 68010e27f065..f5018bfa317a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2019 MediaTek Inc.
  *
  * Author: Ryder Lee <ryder.lee@mediatek.com>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
index f607eee3fb47..a9178e077fd6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2019 MediaTek Inc.
  *
  * Author: Roy Luo <royluo@google.com>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index b795d11d943d..53cb1eed1e4f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 MediaTek Inc.
  *
  * Author: Ryder Lee <ryder.lee@mediatek.com>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 806b3887c541..eb3c24d51987 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2019 MediaTek Inc. */
 
 #ifndef __MT7615_REGS_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index f56038cd4d3a..46188951ad19 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 MediaTek Inc.
  *
  * Author: Felix Fietkau <nbd@nbd.name>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/soc.c b/drivers/net/wireless/mediatek/mt76/mt7615/soc.c
index 06a0f2a141e8..4bd189dd67e3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/soc.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2019 MediaTek Inc.
  *
  * Author: Ryder Lee <ryder.lee@mediatek.com>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
index 03f5af84424b..6eb97b7eba2d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 Felix Fietkau <nbd@nbd.name> */
 
 #include "mt7615.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/trace.c b/drivers/net/wireless/mediatek/mt76/mt7615/trace.c
index 6c02d5aff68f..7ec39e0b3fb2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/trace.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/trace.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2019 Lorenzo Bianconi <lorenzo@kernel.org>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index d96e06b4fee1..d91feffadda9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2019 MediaTek Inc.
  *
  * Author: Felix Fietkau <nbd@nbd.name>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
index 820b39590027..f4169de939c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 MediaTek Inc.
  *
  * Author: Lorenzo Bianconi <lorenzo@kernel.org>
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 192dcc374a64..813d61bffc2c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #ifndef __MT76_CONNAC_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
index eb4765365b8c..d4e2c3140441 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2022 MediaTek Inc. */
 
 #ifndef __MT76_CONNAC2_MAC_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
index 2d300948308d..651fcd4169f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #include "mt76_connac.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
index c5eaedca11e0..247e2e7a47d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #ifndef __MT76_CONNAC3_MAC_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 0db00efe88b0..7af6a578562f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include "mt76_connac.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index fc3e6728fcfb..9d5fcb33e34e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include <linux/firmware.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 27daf419560a..927138130842 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #ifndef __MT76_CONNAC_MCU_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index 11c16d1fc70f..f8d206a07f99 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci_mcu.c
index f0962507f72f..efa549dc68ec 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci_mcu.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c
index 6dc1f51f5658..20a8f3659490 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index 8d06ef8c7c62..3c98808ccf26 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  * Copyright (C) 2018 Stanislaw Gruszka <stf_xl@wp.pl>
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
index d570b99bccb9..7c9b16942275 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
index 8ce4bf44733d..d81f696b32c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c b/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
index 7a07636d09c6..21c99ad7ef59 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.h b/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.h
index 491010a32247..d40051992586 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2016 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_dma.h b/drivers/net/wireless/mediatek/mt76/mt76x02_dma.h
index 23b0e7d10d57..2f6ba8cf51e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_dma.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_dma.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
index a5e3392c0b48..d16be0cb0dc7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.h b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.h
index 13fa70853b0d..3cbb2977f375 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 83488b2d6efb..14ee5b3b94d3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  * Copyright (C) 2018 Stanislaw Gruszka <stf_xl@wp.pl>
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
index 5dc6c834111e..778454ac8974 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  * Copyright (C) 2018 Stanislaw Gruszka <stf_xl@wp.pl>
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
index 75978820a260..e16f06a284ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.h
index e187ed52968e..a422cdc520cb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index a683d53c7ceb..dd71c1c95cc9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_phy.c b/drivers/net/wireless/mediatek/mt76/mt76x02_phy.c
index cbe7e6f0c29a..557380c9bfab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_phy.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_phy.h b/drivers/net/wireless/mediatek/mt76/mt76x02_phy.h
index 84d8a6138b3e..09e8edee2195 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_phy.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_phy.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h b/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h
index fe0c5e3298bc..e87d3f8a1de9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_trace.c b/drivers/net/wireless/mediatek/mt76/mt76x02_trace.c
index a812c3a1e258..a92b2b7391ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_trace.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_trace.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_trace.h b/drivers/net/wireless/mediatek/mt76/mt76x02_trace.h
index 11d119cd0f6f..56eea2f68983 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_trace.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_trace.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c b/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
index d8bc4ae185f5..301b43180006 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb.h b/drivers/net/wireless/mediatek/mt76/mt76x02_usb.h
index b5be884b3549..49ab05c1fe73 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 4840d0b500b3..3a28a8cc1338 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
index b2cc44914294..968c73e06a5f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 7dfcb20c692c..e5d9d1bc9415 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2018 Stanislaw Gruszka <stf_xl@wp.pl>
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig b/drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig
index 482a32b70ddf..d820510cb4bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: BSD-3-Clause-Clear
 config MT76x2_COMMON
 	tristate
 	select MT76x02_LIB
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/Makefile b/drivers/net/wireless/mediatek/mt76/mt76x2/Makefile
index caf089538c11..cbc90a9616a6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: BSD-3-Clause-Clear
 obj-$(CONFIG_MT76x2_COMMON) += mt76x2-common.o
 obj-$(CONFIG_MT76x2E) += mt76x2e.o
 obj-$(CONFIG_MT76x2U) += mt76x2u.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
index 221805deb42f..782813aadc0a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.h
index 43430ef98b11..1ee8be389b24 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/init.c
index 19c139290adb..408dc08b6457 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/init.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/mac.c b/drivers/net/wireless/mediatek/mt76/mt76x2/mac.c
index e08740ca3d0c..2fa34ca69095 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/mac.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/mac.h b/drivers/net/wireless/mediatek/mt76/mt76x2/mac.h
index d5c3d26b94c1..f8ea70074c41 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/mac.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c
index ac83ce5f3e8b..769d924220e3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/mcu.h b/drivers/net/wireless/mediatek/mt76/mt76x2/mcu.h
index 41fd66563e82..16a4386aa754 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/mcu.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h b/drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h
index f051721bb00e..984756c81bdc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2u.h b/drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2u.h
index f9d37c6cf1f0..27e478ab5b15 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2u.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2u.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
index 2303019670e2..491a32921a06 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
index e38e8e5685c2..bec84f932311 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
index c5dfb06d81e8..550644676201 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_mcu.c
index e5b6282d1a6c..daba163802b6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_mcu.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c
index 8831337df23e..dcf4328c1cac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
index e2b4cf30dc44..a5efa13a892f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index 96cecc576a98..01cb3b2830f3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
index 3b5562811511..41778a8ef02c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_mac.c
index eaa622833f85..d0cb511ac6a2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_mac.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
index 6671c53faf9f..66b06a493d95 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_mcu.c
index dd22d8af0901..9102be1803b7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_mcu.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c
index a04a98f5ce1e..b63dd7f3ee80 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
index 193112c49bd1..c24be8227f11 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: ISC
+# SPDX-License-Identifier: BSD-3-Clause-Clear
 config MT7915E
 	tristate "MediaTek MT7915E (PCIe) support"
 	select MT76_CONNAC_LIB
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/Makefile b/drivers/net/wireless/mediatek/mt76/mt7915/Makefile
index e0ca638c91a5..963fb3109af3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: ISC
+# SPDX-License-Identifier: BSD-3-Clause-Clear
 
 obj-$(CONFIG_MT7915E) += mt7915e.o
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/coredump.c b/drivers/net/wireless/mediatek/mt76/mt7915/coredump.c
index 5daf2258dfe6..6c7273e5b0bc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/coredump.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/coredump.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2022 MediaTek Inc. */
 
 #include <linux/devcoredump.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/coredump.h b/drivers/net/wireless/mediatek/mt76/mt7915/coredump.h
index 709f8e9c795c..eb3991eda2e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/coredump.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/coredump.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2022 MediaTek Inc. */
 
 #ifndef _COREDUMP_H_
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index b287b7d9394e..be83a0fb7692 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include <linux/relay.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 009ef713f437..aabd37366e86 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include "mt7915.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 38dfd5de365c..eb92cbf1a284 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include <linux/firmware.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
index 73611c9d26e1..1dc285c72991 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #ifndef __MT7915_EEPROM_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 5ea8b46e092e..cd5e954e923f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include <linux/etherdevice.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 1c0d310146d6..cfbe457039ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include <linux/etherdevice.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index 448b1b380190..e39f96e00ba4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #ifndef __MT7915_MAC_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index fe0639c14bf9..fcd6d4b90d2e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include <linux/etherdevice.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index c1fdd3c4f1ba..7a5c23d22c23 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include <linux/fs.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 086ad89ecd91..969b01b34df6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #ifndef __MT7915_MCU_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 36488aa6cc20..2708b1556f40 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include <linux/kernel.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 2e94347c46d6..6bdef7646347 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #ifndef __MT7915_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index 07b0a5766eab..f6b03211a879 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 MediaTek Inc.
  *
  * Author: Ryder Lee <ryder.lee@mediatek.com>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index c5ec63a25a42..307bf6a75674 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #ifndef __MT7915_REGS_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
index c823a7554a3a..e22a737bd9ab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2022 MediaTek Inc. */
 
 #include <linux/kernel.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index d534fff5c952..d19481afe74f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include "mt7915.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.h b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.h
index 5573ac309363..bb1bc568751b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #ifndef __MT7915_TESTMODE_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
index 7ed51e057857..37b5f46e76f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: ISC
+# SPDX-License-Identifier: BSD-3-Clause-Clear
 config MT7921_COMMON
 	tristate
 	select MT792x_LIB
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
index 849be9e848e0..2ad3c1cc3779 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: ISC
+# SPDX-License-Identifier: BSD-3-Clause-Clear
 
 obj-$(CONFIG_MT7921_COMMON) += mt7921-common.o
 obj-$(CONFIG_MT7921E) += mt7921e.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 616b66a3fde2..4333005b3ad9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include "mt7921.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index b9098a7331b1..d8410c77abe4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include <linux/etherdevice.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index bce26389ab18..03b4960db73f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include <linux/devcoredump.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 67383c41a319..5fae9a6e273c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include <linux/etherdevice.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 86bd33b916a9..8c5e6bdc0fc9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include <linux/fs.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index 2834c6c53e58..de676b83b89c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #ifndef __MT7921_MCU_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index c88793fcec64..83fc7f49ff84 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #ifndef __MT7921_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index a0c9df3c2cc7..ec9686183251 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 MediaTek Inc.
  *
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index 881812ba03ff..5ec084432ae3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2021 MediaTek Inc. */
 
 #include "mt7921.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
index 4cf1f2f0f968..8439c849a7a6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2021 MediaTek Inc. */
 
 #include "mt7921.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
index 43427a3a48af..4d9eaf1e0692 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #ifndef __MT7921_REGS_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index d8d36b3c3068..3421e53dc948 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2021 MediaTek Inc.
  *
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
index a9eb6252a904..416d49e53499 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2021 MediaTek Inc. */
 
 #include <linux/iopoll.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
index 5e4501d7f1c0..14e66f3f5aad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2021 MediaTek Inc. */
 
 #include <linux/kernel.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
index e838d93477c1..e60ee992edf8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 
 #include "mt7921.h"
 #include "mcu.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 100bdba32ba5..17057e68bf21 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2022 MediaTek Inc.
  *
  * Author: Lorenzo Bianconi <lorenzo@kernel.org>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7925/Kconfig
index 5854e95e68a5..f4f7c93c2ea7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/Kconfig
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: ISC
+# SPDX-License-Identifier: BSD-3-Clause-Clear
 config MT7925_COMMON
 	tristate
 	select MT792x_LIB
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/Makefile b/drivers/net/wireless/mediatek/mt76/mt7925/Makefile
index ade5e647c941..5d769de979c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: ISC
+# SPDX-License-Identifier: BSD-3-Clause-Clear
 
 obj-$(CONFIG_MT7925_COMMON) += mt7925-common.o
 obj-$(CONFIG_MT7925E) += mt7925e.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c
index 1e2fc6577e78..e2498659c884 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #include "mt7925.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index d7d5afe365ed..ea397ad48c30 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #include <linux/etherdevice.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 1e44e96f034e..19c9bec7c7e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #include <linux/devcoredump.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.h b/drivers/net/wireless/mediatek/mt76/mt7925/mac.h
index b10a993326b9..83ea9021daea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #ifndef __MT7925_MAC_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index ac3d485a2f78..13424e2fe447 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #include <linux/etherdevice.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 8eda407e4135..620f61abee0b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #include <linux/fs.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index a40764d89a1f..1a11e977a244 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #ifndef __MT7925_MCU_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 1b165d0d8bd3..f46eadce31fc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #ifndef __MT7925_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 8eb1fe1082d1..1de5e41a4061 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #include <linux/kernel.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
index 4578d16bf456..3072850c2752 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #include "mt7925.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c
index f95bc5dcd830..6cceff88c656 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #include "mt7925.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
index 341987e47f67..24985bba1b90 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #ifndef __MT7925_REGS_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7925/testmode.c
index a3c97164ba21..3d40aacfc011 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/testmode.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 
 #include "mt7925.h"
 #include "mcu.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
index bf040f34e4b9..d9968f03856d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #include <linux/kernel.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index f2c8b9e4aa0f..da7831f9efec 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #ifndef __MT792X_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c b/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c
index d1aebadd50aa..946dd7956e4a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #include <linux/acpi.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h b/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h
index e45dcd7fbdb1..474033073831 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #ifndef __MT7921_ACPI_SAR_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index c0e56541a954..5b50bf94996e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #include <linux/module.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_debugfs.c b/drivers/net/wireless/mediatek/mt76/mt792x_debugfs.c
index 9858d9a93851..65c37e0cef8f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_debugfs.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #include "mt792x.h"
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
index 69217ce91130..1ddec7788b66 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #include <linux/module.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
index 3f1d9ba49076..71dec93094eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #include <linux/module.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
index 458cfd0260b1..acf627aed609 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #ifndef __MT792X_REGS_H
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_trace.c b/drivers/net/wireless/mediatek/mt76/mt792x_trace.c
index b6f284fb929d..ffc77d3944bd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_trace.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_trace.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2023 Lorenzo Bianconi <lorenzo@kernel.org>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_trace.h b/drivers/net/wireless/mediatek/mt76/mt792x_trace.h
index 61f2aa260656..7b0e3f00b194 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_trace.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_trace.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2023 Lorenzo Bianconi <lorenzo@kernel.org>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
index 76272a03b22e..552808458138 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2023 MediaTek Inc.
  *
  * Author: Lorenzo Bianconi <lorenzo@kernel.org>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
index bb44d4a5e2dc..196e1cbab813 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: ISC
+# SPDX-License-Identifier: BSD-3-Clause-Clear
 config MT7996E
 	tristate "MediaTek MT7996 (PCIe) support"
 	select MT76_CONNAC_LIB
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/Makefile b/drivers/net/wireless/mediatek/mt76/mt7996/Makefile
index 07c8b555c1ac..19c0bc02b584 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: ISC
+# SPDX-License-Identifier: BSD-3-Clause-Clear
 
 obj-$(CONFIG_MT7996E) += mt7996e.o
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/coredump.c b/drivers/net/wireless/mediatek/mt76/mt7996/coredump.c
index 303d6e80a666..5c293ae965cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/coredump.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/coredump.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #include <linux/devcoredump.h>
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/coredump.h b/drivers/net/wireless/mediatek/mt76/mt7996/coredump.h
index af2ba219b1b5..baa2f6f50832 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/coredump.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/coredump.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2023 MediaTek Inc. */
 
 #ifndef _COREDUMP_H_
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
index 0ab827f52fd7..a000275b369b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2022 MediaTek Inc.
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index 659015f93d32..20aa67eff76f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2022 MediaTek Inc.
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
index da3231c9aa11..8f60772913b4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2022 MediaTek Inc.
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
index 7a771ca2434c..9e6f0e04caf9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2022 MediaTek Inc.
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 5e95a36b42d1..5f2a2da5c326 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2022 MediaTek Inc.
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 9501def3e0e3..fd3fabc60026 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2022 MediaTek Inc.
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.h b/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
index e629324a5617..4eca37b013fc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2022 MediaTek Inc.
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index b53ca702591c..0e629d094545 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2022 MediaTek Inc.
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index afa6a43bd51e..dda01fa6d7bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2022 MediaTek Inc.
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index c841da1c60e5..e0b83ac9f5e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2022 MediaTek Inc.
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index d14b626ee511..15d55892c558 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2022 MediaTek Inc.
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 718e4d4ad85f..d52264b23163 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2022 MediaTek Inc.
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
index 3f49bbbba3b9..4eb55ffdf1a0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2022 MediaTek Inc.
  */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index 0fa325f87fcd..e48e0e575b64 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2022 MediaTek Inc.
  */
diff --git a/drivers/net/wireless/mediatek/mt76/pci.c b/drivers/net/wireless/mediatek/mt76/pci.c
index b5031ca7f73f..833923ab2483 100644
--- a/drivers/net/wireless/mediatek/mt76/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/pci.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2019 Lorenzo Bianconi <lorenzo@kernel.org>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/scan.c b/drivers/net/wireless/mediatek/mt76/scan.c
index 5a875aac410f..ff9176cdee3d 100644
--- a/drivers/net/wireless/mediatek/mt76/scan.c
+++ b/drivers/net/wireless/mediatek/mt76/scan.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2024 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 8e9576747052..8bae77c761be 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 MediaTek Inc.
  *
  * This file is written based on mt76/usb.c.
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.h b/drivers/net/wireless/mediatek/mt76/sdio.h
index 27d5d2077eba..41b89f3de86b 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.h
+++ b/drivers/net/wireless/mediatek/mt76/sdio.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /* Copyright (C) 2020 MediaTek Inc.
  *
  * Author: Sean Wang <sean.wang@mediatek.com>
diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
index f882d21c9f63..3f314e8e1e69 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 MediaTek Inc.
  *
  * Author: Felix Fietkau <nbd@nbd.name>
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index ca4feccf38ca..6ee160bda882 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /* Copyright (C) 2020 Felix Fietkau <nbd@nbd.name> */
 
 #include <linux/random.h>
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.h b/drivers/net/wireless/mediatek/mt76/testmode.h
index 0590c35c7126..bed1ba40ba94 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.h
+++ b/drivers/net/wireless/mediatek/mt76/testmode.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2020 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/trace.c b/drivers/net/wireless/mediatek/mt76/trace.c
index f199fcd2a63d..f17cc01017f3 100644
--- a/drivers/net/wireless/mediatek/mt76/trace.c
+++ b/drivers/net/wireless/mediatek/mt76/trace.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/trace.h b/drivers/net/wireless/mediatek/mt76/trace.h
index 109a07f9733a..794b957ac79d 100644
--- a/drivers/net/wireless/mediatek/mt76/trace.h
+++ b/drivers/net/wireless/mediatek/mt76/trace.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index b78ae6a34b65..b09b7dfab416 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index f9e67b8c3b3c..632ae755c7a6 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/usb_trace.c b/drivers/net/wireless/mediatek/mt76/usb_trace.c
index 9942bdd6177b..a04585b4b778 100644
--- a/drivers/net/wireless/mediatek/mt76/usb_trace.c
+++ b/drivers/net/wireless/mediatek/mt76/usb_trace.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/usb_trace.h b/drivers/net/wireless/mediatek/mt76/usb_trace.h
index 7b261ddb2ac6..93bb69c65a4f 100644
--- a/drivers/net/wireless/mediatek/mt76/usb_trace.h
+++ b/drivers/net/wireless/mediatek/mt76/usb_trace.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/util.c b/drivers/net/wireless/mediatek/mt76/util.c
index 97249ebb4bc8..83d3dc42e534 100644
--- a/drivers/net/wireless/mediatek/mt76/util.c
+++ b/drivers/net/wireless/mediatek/mt76/util.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/util.h b/drivers/net/wireless/mediatek/mt76/util.h
index 037d39a55f71..617966e8de76 100644
--- a/drivers/net/wireless/mediatek/mt76/util.h
+++ b/drivers/net/wireless/mediatek/mt76/util.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  */
diff --git a/drivers/net/wireless/mediatek/mt76/wed.c b/drivers/net/wireless/mediatek/mt76/wed.c
index 907a8e43e72a..dc0faf236b25 100644
--- a/drivers/net/wireless/mediatek/mt76/wed.c
+++ b/drivers/net/wireless/mediatek/mt76/wed.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (C) 2023 Lorenzo Bianconi <lorenzo@kernel.org>
  */
-- 
2.51.0


