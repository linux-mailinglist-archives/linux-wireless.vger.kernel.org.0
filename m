Return-Path: <linux-wireless+bounces-20786-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AA7A6E55D
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 22:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358621752B5
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 21:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671221EBA07;
	Mon, 24 Mar 2025 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=conclusive.pl header.i=@conclusive.pl header.b="N8pyzF2q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95391DF98F
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850674; cv=none; b=Q9iOG10Rp5S8/+JOb24UK5NkO1u8n2IFmWmetFveupK6dMq5raqfyqzq0VFzTfTnn/ySqUqMRCM7ysiEaX/C59P2AZ/YfXO9zk56Zfm3xVDj+3WQsOCDOuV4eB0fycI25wz5DKNYI2qcnaZO0FLdachcF7i3fG6tB7uelhIIkI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850674; c=relaxed/simple;
	bh=JaqIbWahN2Zb6lXrtPpOXlP6zhvsFNEMCrAf3P29TmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VT40IDprNZZZO6J2YTjZavznf9jCjqhedJLKQIAyxOna9mUd4tHooGNtUP/674jfisFzMCM5RFk+nvknoj3psSA40NhrJ3pQ1SJZjB6NbJlXj48JSocW1uW57ykDDIsqbkU670yvtMM627kgU7ZRQBGmfxXE9NXQ94eJNHnOmd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl; spf=pass smtp.mailfrom=conclusive.pl; dkim=pass (2048-bit key) header.d=conclusive.pl header.i=@conclusive.pl header.b=N8pyzF2q; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=conclusive.pl
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5b56fc863so7163088a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 14:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conclusive.pl; s=google; t=1742850663; x=1743455463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09LZxraEd1JLFf2REr2As7i6n8KDuWrzYNF1wlBeq/c=;
        b=N8pyzF2qODnf77/E9sj4kcZjrGzRIa5DYP6U0KvFa87P8Rzl4gZ5R7m9ZHZAl+LXww
         HQmRtCsz2zGt/WpnYLJvcoJ0nr6/3ZVTIcXeNwQPZ1mn2buqaxOwA9W6jj0EEZbTcOBE
         xeRWNaBsLCZeyBvNmk5LcGQrEUSg/jHETGDzMiaAEnML3RERvokA4/VJJrsiFaZLc6LS
         pR8OGpv6ty1ce1hVVEAPhy3Yy7tzSHDgzyf5JTIS4MznpTf1hzaef2SyRZ1QMgxsvGAI
         euWGWzxb6wC+07oNPTxu8O5+ttf0nUtDUm5ISyAR+H7dA6Pc9PxfSWhkA+ZJpbqsk8XO
         pNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742850663; x=1743455463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09LZxraEd1JLFf2REr2As7i6n8KDuWrzYNF1wlBeq/c=;
        b=kcXgn5WTKX/OlLwkp8QKVe/DFVWZh0l1lNISwvTmWfLYHvfcjiuW5KDkPxX1YHzKPd
         uA7Vx1PqPQl4EPHwtmaDBUucyRh8Tj9MJwRKggjXW8uSH3i2ZH9P9IQ17jFbb4Y5ZIMO
         CkGFFtwLkbpUGos85iw8DhX6PvRczbXZAOiR22bUKPQW3S0fQ7+hw8o9syxAdKALbnvJ
         E8XZnlW+UDDLmdyPW+wsyrNmT68EZwXYZ4itaj7ngjMv02qFCgCvcIyrDDTyoTEzAzIL
         9WJN+zW43R2IP32QWmbWss3g37weZfFQQtTIJk2kKH1SxoJmu7A3JSZ/XKJTwpNyL4YZ
         f2rw==
X-Gm-Message-State: AOJu0YzJTbXkH7Zd1TlBqUocWm8yNZH+VlTXPNNHmYZ+InwP7CBH/zmF
	b5ux+KAz7+jxPulITgmXKPBeSaBhL6GzwdR03pWXx28Cvpv2wFM7rnQMJtQy+sI=
X-Gm-Gg: ASbGnctC746CtCiY9ETSfvHF+tAnSxjKjWZbUOC+2S9cwR8MQj7xh4BY+n3jG7HDmFo
	BDl/UrkRXWVogIy1VFwuRIAtrI9k0hDxCKt51g0LET6ZqDBgD0iYDGvif6QiKSIpOk1jLx9a2Jh
	IqYyKZzF50qJG6rgNBicr0/Hz3eog6ClAvc9xgV+1SDMj4jEW6QlzLEm3aNv+lZvQWJIZBVAXjc
	B1c8r/owZQAuAaIPUUNVctnMrlDEvZbnSU/YW/Gxrxh7Xmrc9Sj3Bv3FIpslcfatKYgcYaK+TiW
	v9lz6y2eLB4+I03l/JX5AaAc8I7Z0nPGF8ImEtVLtpEiofUqNa4khWCDhhG45mhBmTqlId7Uupl
	ULvEGLpdd1IVsubaQv/Dt9tc=
X-Google-Smtp-Source: AGHT+IF9SlVPbiUrDh7FZ7f7Vg1nPrtH0II31FFgYXi3PLqVu9Ql56Thb3l2eBIhd8wYkwJzoXdfVQ==
X-Received: by 2002:a05:6402:3582:b0:5e5:dbd0:2a4d with SMTP id 4fb4d7f45d1cf-5ebcd42dbe6mr10284447a12.8.1742850662130;
        Mon, 24 Mar 2025 14:11:02 -0700 (PDT)
Received: from wiesia.conclusive.pl (host-89.25.128.123.static.3s.pl. [89.25.128.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0e0cb6sm6537097a12.79.2025.03.24.14.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 14:11:01 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jakub Klama <jakub@conclusive.pl>,
	Wojciech Kloska <wojciech@conclusive.pl>,
	Ulf Axelsson <ulf.axelsson@nordicsemi.no>,
	Artur Rojek <artur@conclusive.pl>
Subject: [RFC PATCH 1/2] net: wireless: Add Nordic nRF70 series Wi-Fi driver
Date: Mon, 24 Mar 2025 22:10:44 +0100
Message-ID: <20250324211045.3508952-2-artur@conclusive.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324211045.3508952-1-artur@conclusive.pl>
References: <20250324211045.3508952-1-artur@conclusive.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce support for Nordic Semiconductor nRF70 series wireless
companion IC.

Signed-off-by: Artur Rojek <artur@conclusive.pl>
---
 drivers/net/wireless/Kconfig                  |    1 +
 drivers/net/wireless/Makefile                 |    1 +
 drivers/net/wireless/nordic/Kconfig           |   26 +
 drivers/net/wireless/nordic/Makefile          |    3 +
 drivers/net/wireless/nordic/nrf70.c           | 4671 +++++++++++++++++
 drivers/net/wireless/nordic/nrf70_cmds.h      | 1051 ++++
 drivers/net/wireless/nordic/nrf70_rf_params.h |   98 +
 7 files changed, 5851 insertions(+)
 create mode 100644 drivers/net/wireless/nordic/Kconfig
 create mode 100644 drivers/net/wireless/nordic/Makefile
 create mode 100644 drivers/net/wireless/nordic/nrf70.c
 create mode 100644 drivers/net/wireless/nordic/nrf70_cmds.h
 create mode 100644 drivers/net/wireless/nordic/nrf70_rf_params.h

diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index c6599594dc99..ffd2c4dcd4ac 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -27,6 +27,7 @@ source "drivers/net/wireless/intersil/Kconfig"
 source "drivers/net/wireless/marvell/Kconfig"
 source "drivers/net/wireless/mediatek/Kconfig"
 source "drivers/net/wireless/microchip/Kconfig"
+source "drivers/net/wireless/nordic/Kconfig"
 source "drivers/net/wireless/purelifi/Kconfig"
 source "drivers/net/wireless/ralink/Kconfig"
 source "drivers/net/wireless/realtek/Kconfig"
diff --git a/drivers/net/wireless/Makefile b/drivers/net/wireless/Makefile
index e1c4141c6004..a3f9579c9b27 100644
--- a/drivers/net/wireless/Makefile
+++ b/drivers/net/wireless/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_WLAN_VENDOR_INTERSIL) += intersil/
 obj-$(CONFIG_WLAN_VENDOR_MARVELL) += marvell/
 obj-$(CONFIG_WLAN_VENDOR_MEDIATEK) += mediatek/
 obj-$(CONFIG_WLAN_VENDOR_MICROCHIP) += microchip/
+obj-$(CONFIG_WLAN_VENDOR_NORDIC) += nordic/
 obj-$(CONFIG_WLAN_VENDOR_PURELIFI) += purelifi/
 obj-$(CONFIG_WLAN_VENDOR_QUANTENNA) += quantenna/
 obj-$(CONFIG_WLAN_VENDOR_RALINK) += ralink/
diff --git a/drivers/net/wireless/nordic/Kconfig b/drivers/net/wireless/nordic/Kconfig
new file mode 100644
index 000000000000..c29aa338188a
--- /dev/null
+++ b/drivers/net/wireless/nordic/Kconfig
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config WLAN_VENDOR_NORDIC
+	bool "Nordic Semiconductor devices"
+	default y
+	help
+	  If you have a wireless card belonging to this class, say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all the
+	  questions about these cards. If you say Y, you will be asked for
+	  your specific card in the following questions.
+
+if WLAN_VENDOR_NORDIC
+
+config NRF70
+	tristate "Nordic Semiconductor nRF70 series wireless companion IC"
+	depends on CFG80211 && INET && SPI_MEM && CPU_LITTLE_ENDIAN
+	help
+	  This enables support for the Nordic Semiconductor nRF70 family of
+	  wireless companion ICs.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called nrf70.
+
+endif # WLAN_VENDOR_NORDIC
diff --git a/drivers/net/wireless/nordic/Makefile b/drivers/net/wireless/nordic/Makefile
new file mode 100644
index 000000000000..4559072a4b83
--- /dev/null
+++ b/drivers/net/wireless/nordic/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_NRF70)	+= nrf70.o
diff --git a/drivers/net/wireless/nordic/nrf70.c b/drivers/net/wireless/nordic/nrf70.c
new file mode 100644
index 000000000000..e4b1b4cc9b45
--- /dev/null
+++ b/drivers/net/wireless/nordic/nrf70.c
@@ -0,0 +1,4671 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Conclusive Engineering Sp. z o. o.
+ */
+
+#include <crypto/hash.h>
+#include <linux/crypto.h>
+#include <linux/delay.h>
+#include <linux/firmware.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+#include <linux/units.h>
+#include <net/ieee80211_radiotap.h>
+#include <net/mac80211.h>
+#include <uapi/linux/if_arp.h>
+
+#include "nrf70_cmds.h"
+#include "nrf70_rf_params.h"
+
+#define	NRF70_FW_SIGNATURE	0xdead1eaf
+#define	NRF70_FW_HASH_LEN	32
+
+#define	NRF70_OP_PP	0x02
+#define	NRF70_OP_RDSR	0x05
+#define	NRF70_OP_FASTRD	0x0b
+#define	NRF70_OP_RDSR1	0x1f
+#define	NRF70_OP_RDSR2	0x2f
+#define	NRF70_OP_PP4	0x38
+#define	NRF70_OP_WRSR2	0x3f
+#define	NRF70_OP_RD4	0xeb
+
+#define	NRF70_SR2_WAKEUP_REQ	BIT(0)
+#define	NRF70_SR1_AWAKE		BIT(1)
+#define	NRF70_SR1_READY		BIT(2)
+
+#define	NRF70_ADDR_INVAL		(-1)
+
+#define	NRF70_RPU_BASE_MCU		0x80000000
+#define	NRF70_RPU_BASE_SBUS		0xa4000000
+#define	NRF70_RPU_BASE_PBUS		0xa5000000
+#define	NRF70_RPU_BASE_PKTRAM		0xb0000000
+#define	NRF70_RPU_BASE_GRAM		0xb7000000
+#define	NRF70_RPU_BASE_INDIRECT		0xc0000000
+
+#define	NRF70_RPU_BASE_MASK		0xff000000
+
+#define	NRF70_HOST_BASE_SBUS		0x000000
+#define	NRF70_HOST_BASE_PBUS		0x040000
+#define	NRF70_HOST_BASE_GRAM		0x080000
+#define	NRF70_HOST_BASE_PKTRAM		0x0c0000
+#define	NRF70_HOST_BASE_MCU		0x100000
+
+#define	NRF70_HOST_BASE_MASK		0xff0000
+
+#define	NRF70_HOST_OFFSET_LMAC		0x0
+#define	NRF70_HOST_OFFSET_UMAC		0x100000
+
+#define	NRF70_HOST_OFFSET_MASK		0x00ffffff
+/* Host addresses tagged with this bit are subject to multi-word SPI I/O. */
+#define	NRF70_HOST_MW_IO		BIT(23)
+
+/*
+ * All hw register addresses are from the RPU point of view. They are converted
+ * to SPI bus memory map in I/O helpers.
+ */
+#define	NRF70_PBUS_CLK				(NRF70_RPU_BASE_PBUS + 0x8c20)
+#define	NRF70_PBUS_CLK_UNGATE			BIT(8)
+
+#define	NRF70_SBUS_MIPS_MCU_CONTROL		(NRF70_RPU_BASE_SBUS + 0x0)
+#define	NRF70_SBUS_MIPS_MCU_UCCP_INT_STATUS	(NRF70_RPU_BASE_SBUS + 0x4)
+#define	NRF70_SBUS_MIPS_MCU_UCCP_INT_CLEAR	(NRF70_RPU_BASE_SBUS + 0xc)
+
+#define	NRF70_SBUS_CP0_SLEEP_STATUS		(NRF70_RPU_BASE_SBUS + 0x18)
+#define	NRF70_SBUS_MIPS_MCU2_CONTROL		(NRF70_RPU_BASE_SBUS + 0x100)
+#define	NRF70_SBUS_CP1_SLEEP_STATUS		(NRF70_RPU_BASE_SBUS + 0x118)
+
+#define	NRF70_MCU_LMAC_PATCH_BIN	\
+	(NRF70_RPU_BASE_MCU + NRF70_HOST_OFFSET_LMAC + 0x043a80)
+#define	NRF70_MCU_LMAC_PATCH_BIMG	\
+	(NRF70_RPU_BASE_MCU + NRF70_HOST_OFFSET_LMAC + 0x04bc00)
+#define	NRF70_MCU_UMAC_PATCH_BIN	\
+	(NRF70_RPU_BASE_MCU + NRF70_HOST_OFFSET_UMAC + 0x08c000)
+#define	NRF70_MCU_UMAC_PATCH_BIMG	\
+	(NRF70_RPU_BASE_MCU + NRF70_HOST_OFFSET_UMAC + 0x099400)
+
+#define	NRF70_MCU_LMAC_BOOT_SIG		(NRF70_RPU_BASE_GRAM + 0x000d50)
+#define	NRF70_MCU_UMAC_BOOT_SIG		(NRF70_RPU_BASE_PKTRAM + 0x000000)
+#define	NRF70_MCU_UMAC_VERSION		(NRF70_RPU_BASE_PKTRAM + 0x000004)
+#define	NRF70_MCU_UMAC_HPQ		(NRF70_RPU_BASE_PKTRAM + 0x24)
+#define	NRF70_OTP_HWADDR		(NRF70_RPU_BASE_PKTRAM + 0x84)
+#define	NRF70_OTP_INFO_FLAGS		(NRF70_RPU_BASE_PKTRAM + 0x4fdc)
+#define	NRF70_OTP_INFO_FLAGS_HWADDR(n)	BIT(1 + (n))
+
+#define	NRF70_RX_CMD_BASE		(NRF70_RPU_BASE_GRAM + 0xd58)
+#define	NRF70_TX_CMD_BASE		(NRF70_RPU_BASE_PKTRAM + 0xb8)
+
+#define	NRF70_MCU_UMAC_VERSION_VER(n)	((n) >> 24 & 0xff)
+#define	NRF70_MCU_UMAC_VERSION_MAJOR(n)	((n) >> 16 & 0xff)
+#define	NRF70_MCU_UMAC_VERSION_MINOR(n)	((n) >> 8 & 0xff)
+#define	NRF70_MCU_UMAC_VERSION_EXTRA(n)	((n) & 0xff)
+
+#define	NRF70_LMAC_CORE_RET_START	(NRF70_RPU_BASE_MCU + 0x40000)
+#define	NRF70_UMAC_CORE_RET_START	(NRF70_RPU_BASE_MCU + 0x80000)
+#define	NRF70_LMAC_ROM_PATCH_OFFSET	\
+	(NRF70_MCU_LMAC_PATCH_BIMG - NRF70_LMAC_CORE_RET_START)
+#define	NRF70_UMAC_ROM_PATCH_OFFSET	\
+	(NRF70_MCU_UMAC_PATCH_BIMG - NRF70_UMAC_CORE_RET_START)
+
+#define	NRF70_UCC_SLEEP_CTRL_DATA_0	(NRF70_RPU_BASE_SBUS + 0x2c2c)
+#define	NRF70_UCC_SLEEP_CTRL_DATA_1	(NRF70_RPU_BASE_SBUS + 0x2c30)
+
+#define	NRF70_MCU_BOOT_SIG		0x5a5a5a5a
+
+#define NRF70_SBUS_CORE_MEM_CTRL	(NRF70_RPU_BASE_SBUS + 0x30)
+#define NRF70_SBUS_CORE_MEM_WDATA	(NRF70_RPU_BASE_SBUS + 0x34)
+
+#define	NRF70_SBUS_MIPS_MCU_TIMER	(NRF70_RPU_BASE_SBUS + 0x4c)
+#define	NRF70_SBUS_MIPS_MCU_TIMER_RESET	0xffffff
+
+#define	NRF70_SBUS_MIPS_MCU_BOOT_EXCP_INSTR_0	(NRF70_RPU_BASE_SBUS + 0x50)
+#define	NRF70_SBUS_MIPS_MCU_BOOT_EXCP_INSTR_1	(NRF70_RPU_BASE_SBUS + 0x54)
+#define	NRF70_SBUS_MIPS_MCU_BOOT_EXCP_INSTR_2	(NRF70_RPU_BASE_SBUS + 0x58)
+#define	NRF70_SBUS_MIPS_MCU_BOOT_EXCP_INSTR_3	(NRF70_RPU_BASE_SBUS + 0x5c)
+#define	NRF70_SBUS_MIPS_MCU2_BOOT_EXCP_INSTR_0	(NRF70_RPU_BASE_SBUS + 0x150)
+#define	NRF70_SBUS_MIPS_MCU2_BOOT_EXCP_INSTR_1	(NRF70_RPU_BASE_SBUS + 0x154)
+#define	NRF70_SBUS_MIPS_MCU2_BOOT_EXCP_INSTR_2	(NRF70_RPU_BASE_SBUS + 0x158)
+#define	NRF70_SBUS_MIPS_MCU2_BOOT_EXCP_INSTR_3	(NRF70_RPU_BASE_SBUS + 0x15c)
+
+#define NRF70_MCU_LMAC_BOOT_EXCP_VECT_0	0x3c1a8000
+#define NRF70_MCU_LMAC_BOOT_EXCP_VECT_1	0x275a0000
+#define NRF70_MCU_LMAC_BOOT_EXCP_VECT_2	0x03400008
+#define NRF70_MCU_LMAC_BOOT_EXCP_VECT_3	0x00000000
+
+#define NRF70_MCU_UMAC_BOOT_EXCP_VECT_0	0x3c1a8000
+#define NRF70_MCU_UMAC_BOOT_EXCP_VECT_1	0x275a0000
+#define NRF70_MCU_UMAC_BOOT_EXCP_VECT_2	0x03400008
+#define NRF70_MCU_UMAC_BOOT_EXCP_VECT_3	0x00000000
+
+#define	NRF70_SBUS_MIPS_MCU_WATCHDOG_INT	BIT(1)
+
+#define	NRF70_SBUS_UCCP_CORE_INT_ENAB		(NRF70_RPU_BASE_SBUS + 0x400)
+#define	NRF70_UCCP_MTX2_INT_IRQ_ENAB		BIT(17)
+
+#define	NRF70_SBUS_UCCP_CORE_HOST2_TO_MTX2_CMD	(NRF70_RPU_BASE_SBUS + 0x480)
+#define	NRF70_UCCP_HOST2_TO_MTX2_CMD_DATA_MASK	0x7fff0000
+
+#define	NRF70_SBUS_UCCP_CORE_HOST2_TO_MTX2_ACK	(NRF70_RPU_BASE_SBUS + 0x488)
+
+#define	NRF70_SBUS_UCCP_CORE_MTX2_INT_ENABLE	(NRF70_RPU_BASE_SBUS + 0x494)
+#define	NRF70_UCCP_MTX2_INT_EN		BIT(31)
+
+#define	NRF70_RPU_PKTRAM_PKT_BASE		(NRF70_RPU_BASE_PKTRAM + 0x5000)
+#define	NRF70_RPU_PKTRAM_PKT_BASE_SZ	0x2c000
+
+#define	NRF70_RPU_CMD_START_MAGIC	0xdead
+
+#define	NRF70_PEERS_MAX			8
+#define	NRF70_PEERS_MASK		GENMASK(NRF70_PEERS_MAX - 1, 0)
+#define	NRF70_VIFS_MAX			2
+#define	NRF70_VIFS_MASK			GENMASK(NRF70_VIFS_MAX - 1, 0)
+#define	NRF70_SCAN_SSIDS_MAX		4
+
+#define	NRF70_UMAC_CMD_MAX_SZ		400
+#define	NRF70_DATA_CMD_RX_MAX_SZ	8
+#define	NRF70_DATA_CMD_TX_MAX_SZ	148
+#define	NRF70_EVENT_POOL_MAX_SZ		1000
+
+#define	NRF70_NUM_RX_QUEUES		3
+#define	NRF70_NUM_RX_BUFS		48
+#define	NRF70_RX_DATA_MAX_SZ		1600
+#define	NRF70_TX_DATA_MAX_SZ		1600
+#define	NRF70_DESC_MASK			GENMASK(15, 0)
+
+#define	NRF70_TX_PENDING_MAX		100
+#define	NRF70_TX_PENDING_WMARK		(NRF70_TX_PENDING_MAX / 2)
+
+#define	NRF70_NDEV_TO_IFACE(n)		\
+	(((struct nrf70_ndev_priv *)netdev_priv(n))->vif->iface)
+
+#define	NRF70_RADIOTAP_PRESENT_FIELDS				\
+	cpu_to_le32((1 << IEEE80211_RADIOTAP_RATE) |		\
+		    (1 << IEEE80211_RADIOTAP_CHANNEL) |		\
+		    (1 << IEEE80211_RADIOTAP_DBM_ANTSIGNAL))
+
+static const u8 nrf70_tuning_pattern[] = {
+	0xa5, 0xa5, 0xde, 0xad, 0xc0, 0xde, 0x8b, 0xad,
+	0xf0, 0x0d, 0xfe, 0xe1, 0xc0, 0x1d, 0x5a, 0x5a
+};
+
+struct nrf70_hpq {
+	u32 eq;
+	u32 dq;
+};
+
+enum nrf70_hpq_type {
+	NRF70_EVENT_BUSY_QUEUE,
+	NRF70_EVENT_AVL_QUEUE,
+	NRF70_CMD_BUSY_QUEUE,
+	NRF70_CMD_AVL_QUEUE,
+	NRF70_RX_BUSY_QUEUE,
+	NRF70_RX_BUSY_QUEUE2,
+	NRF70_RX_BUSY_QUEUE3,
+	NRF70_QUEUE_MAX
+};
+
+struct nrf70_cookie {
+	struct list_head list;
+	u64 host_cookie;
+	u64 rpu_cookie;
+};
+
+static struct nrf70_mem_op {
+	int op;
+	int width;
+	int dummy;
+	enum spi_mem_data_dir dir;
+} nrf70_read_ops[] = {
+	{ NRF70_OP_RD4, 4, 3, SPI_MEM_DATA_OUT },
+	{ NRF70_OP_FASTRD, 1, 1, SPI_MEM_DATA_OUT },
+}, nrf70_write_ops[] = {
+	{ NRF70_OP_PP4, 4, 0, SPI_MEM_DATA_IN },
+	{ NRF70_OP_PP, 1, 0, SPI_MEM_DATA_IN },
+};
+
+struct nrf70_sta {
+	u8 addr[ETH_ALEN];
+	struct sk_buff_head pending;
+	struct wiphy_work pending_work;
+	bool can_xmit;
+};
+
+struct nrf70_vif {
+	struct list_head list;
+	struct net_device *ndev;
+	struct wireless_dev wdev;
+	int iface;
+	/* Protects against concurrent access to sta and sta_bitmap members. */
+	spinlock_t sta_lock;
+	unsigned long sta_bitmap;
+	struct nrf70_sta sta[NRF70_PEERS_MAX];
+	struct sk_buff_head tx_queue;
+	struct wiphy_work xmit_work;
+	struct cfg80211_scan_request *scan_req;
+	struct cfg80211_bss *bss;
+	struct cfg80211_qos_map *qos_map;
+	unsigned long iface_stypes;
+	struct completion iface_updated;
+	struct completion chan_updated;
+	struct cfg80211_chan_def chandef;
+	struct {
+		struct u64_stats_sync syncp;
+		u64 rx_packets;
+		u64 tx_packets;
+		u64 rx_bytes;
+		u64 tx_bytes;
+		u64 rx_dropped;
+		u64 tx_dropped;
+	} stats;
+};
+
+struct nrf70_priv {
+	struct spi_mem *mem;
+	struct gpio_desc *buck_en;
+	struct gpio_desc *iovdd_en;
+	struct gpio_desc *irq;
+	struct nrf70_hpq queue[NRF70_QUEUE_MAX];
+	int num_cmds;
+	struct work_struct event_work;
+	struct wiphy *wiphy;
+	struct list_head vifs;
+	unsigned long vif_bitmap;
+	u8 hwaddr[NRF70_VIFS_MAX][ETH_ALEN];
+	u8 regdom[3];
+	struct completion regdom_updated;
+	u32 rx_cmd_base;
+	u32 tx_cmd_base;
+	u64 mgmt_frame_cookie;
+	struct list_head cookies;
+	bool scan_in_progress;
+	/* Provides synchronization for write operations. */
+	struct mutex write_lock;
+	/* Provides synchronization for read operations. */
+	struct mutex read_lock;
+	/* Provides synchronization while enqueuing messages. */
+	struct mutex enqueue_lock;
+	/* Protects against concurrent access to the tx_desc_bitmap member. */
+	struct mutex desc_lock;
+	unsigned long tx_desc_bitmap[NRF70_VIFS_MAX];
+	struct completion init_done;
+	struct nrf70_mem_op *read_op;
+	struct nrf70_mem_op *write_op;
+	int read_op_pad[3];
+	struct station_info *sinfo;
+	struct completion station_info_available;
+	bool has_raw_mode;
+	u32 tx_buf ____cacheline_aligned;
+	u32 rx_buf ____cacheline_aligned;
+};
+
+struct nrf70_wiphy_priv {
+	struct nrf70_priv *priv;
+};
+
+struct nrf70_ndev_priv {
+	struct nrf70_priv *priv;
+	struct nrf70_vif *vif;
+};
+
+static u32 rpu_to_host_addr(u32 address)
+{
+	u32 offset = (address & NRF70_HOST_OFFSET_MASK);
+
+	switch (address & NRF70_RPU_BASE_MASK) {
+	case NRF70_RPU_BASE_MCU:
+		return offset + NRF70_HOST_BASE_MCU;
+	case NRF70_RPU_BASE_SBUS:
+		return offset + NRF70_HOST_BASE_SBUS;
+	case NRF70_RPU_BASE_PBUS:
+		return offset + NRF70_HOST_BASE_PBUS;
+	case NRF70_RPU_BASE_PKTRAM:
+		return offset + NRF70_HOST_BASE_PKTRAM;
+	case NRF70_RPU_BASE_GRAM:
+		return offset + NRF70_HOST_BASE_GRAM;
+	case NRF70_RPU_BASE_INDIRECT:
+		pr_warn("Warning: Indirect address base\n");
+		fallthrough;
+	default:
+		return NRF70_ADDR_INVAL;
+	}
+}
+
+static int nrf70_read_padding(struct spi_mem *mem, u32 address)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+
+	switch (address & NRF70_HOST_BASE_MASK) {
+	case NRF70_HOST_BASE_PKTRAM:
+		return priv->read_op_pad[1];
+	default:
+		return address & NRF70_HOST_MW_IO ?
+		       priv->read_op_pad[2] : priv->read_op_pad[0];
+	}
+}
+
+static void nrf70_writel(struct spi_mem *mem, u32 address, u32 value)
+{
+	u32 rpu_addr = rpu_to_host_addr(address);
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct nrf70_mem_op *mop = priv->write_op;
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(mop->op, 1),
+					  SPI_MEM_OP_ADDR(3, rpu_addr,
+							  mop->width),
+					  SPI_MEM_OP_NO_DUMMY,
+					  SPI_MEM_OP_DATA_OUT(4, &priv->tx_buf,
+							      mop->width));
+
+	guard(mutex)(&priv->write_lock);
+	priv->tx_buf = value;
+
+	if (spi_mem_exec_op(mem, &op))
+		dev_err(&mem->spi->dev, "Failed to write to address %06x\n",
+			address);
+}
+
+static void nrf70_writev(struct spi_mem *mem, u32 address, const void *buf,
+			 size_t len)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct device *dev = &mem->spi->dev;
+	u32 rpu_addr = rpu_to_host_addr(address) | NRF70_HOST_MW_IO;
+	struct nrf70_mem_op *mop = priv->write_op;
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(mop->op, 1),
+					  SPI_MEM_OP_ADDR(3, rpu_addr,
+							  mop->width),
+					  SPI_MEM_OP_NO_DUMMY,
+					  SPI_MEM_OP_DATA_OUT(len, buf,
+							      mop->width));
+	int ret;
+
+	if (len < 4) {
+		dev_err(dev, "Write buffer too small\n");
+		return;
+	}
+	if (address % 4 || len % 4) {
+		dev_err(dev, "Misaligned write: %x\n", address);
+		return;
+	}
+
+	guard(mutex)(&priv->write_lock);
+	while (len) {
+		op.data.nbytes = len;
+		ret = spi_mem_adjust_op_size(mem, &op);
+		if (ret) {
+			dev_err(dev, "Unsupported write op size: %zu, %d\n",
+				len, ret);
+			return;
+		}
+		ret = spi_mem_exec_op(mem, &op);
+		if (ret) {
+			dev_err(dev, "Failed to write to address: %06x, %d\n",
+				address, ret);
+			return;
+		}
+
+		len -= op.data.nbytes;
+		op.data.buf.out += op.data.nbytes;
+		op.addr.val += op.data.nbytes;
+	}
+}
+
+static u32 nrf70_readl(struct spi_mem *mem, u32 address)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	u32 rpu_addr = rpu_to_host_addr(address);
+	struct nrf70_mem_op *mop = priv->read_op;
+	int dummy = nrf70_read_padding(mem, rpu_addr) + mop->dummy;
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(mop->op, 1),
+					  SPI_MEM_OP_ADDR(3, rpu_addr,
+							  mop->width),
+					  SPI_MEM_OP_DUMMY(dummy, mop->width),
+					  SPI_MEM_OP_DATA_IN(4, &priv->rx_buf,
+							     mop->width));
+
+	guard(mutex)(&priv->read_lock);
+	if (spi_mem_exec_op(mem, &op)) {
+		dev_err(&mem->spi->dev, "Failed to read from address %06x\n",
+			address);
+		return 0;
+	}
+
+	return priv->rx_buf;
+}
+
+static int nrf70_readv(struct spi_mem *mem, u32 address, void *buf, size_t len)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct device *dev = &mem->spi->dev;
+	u32 rpu_addr = rpu_to_host_addr(address) | NRF70_HOST_MW_IO;
+	struct nrf70_mem_op *mop = priv->read_op;
+	int dummy = nrf70_read_padding(mem, rpu_addr) + mop->dummy;
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(mop->op, 1),
+					  SPI_MEM_OP_ADDR(3, rpu_addr,
+							  mop->width),
+					  SPI_MEM_OP_DUMMY(dummy, mop->width),
+					  SPI_MEM_OP_DATA_IN(len, buf,
+							     mop->width));
+	int ret;
+
+	if (len < 4) {
+		dev_err(dev, "Read buffer too small\n");
+		return -EINVAL;
+	}
+	if (address % 4) {
+		dev_err(dev, "Misaligned read\n");
+		return -EINVAL;
+	}
+
+	guard(mutex)(&priv->read_lock);
+	while (len) {
+		op.data.nbytes = len;
+		ret = spi_mem_adjust_op_size(mem, &op);
+		if (ret) {
+			dev_err(dev, "Unsupported read op size: %zu, %d\n",
+				len, ret);
+			return ret;
+		}
+		ret = spi_mem_exec_op(mem, &op);
+		if (ret) {
+			dev_err(dev, "Failed to read from address: %06x, %d\n",
+				address, ret);
+			return ret;
+		}
+
+		len -= op.data.nbytes;
+		op.data.buf.in += op.data.nbytes;
+		op.addr.val += op.data.nbytes;
+	}
+
+	return 0;
+}
+
+static u8 nrf70_rdsr1(struct spi_mem *mem)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(NRF70_OP_RDSR1, 1),
+					  SPI_MEM_OP_NO_ADDR,
+					  SPI_MEM_OP_NO_DUMMY,
+					  SPI_MEM_OP_DATA_IN(1, &priv->rx_buf,
+							     1));
+
+	guard(mutex)(&priv->read_lock);
+	if (spi_mem_exec_op(mem, &op))
+		dev_err(&mem->spi->dev, "Failed to perform RDSR1 operation\n");
+
+	return priv->rx_buf;
+}
+
+static u8 nrf70_rdsr2(struct spi_mem *mem)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(NRF70_OP_RDSR2, 1),
+					  SPI_MEM_OP_NO_ADDR,
+					  SPI_MEM_OP_NO_DUMMY,
+					  SPI_MEM_OP_DATA_IN(1, &priv->rx_buf,
+							     1));
+
+	guard(mutex)(&priv->read_lock);
+	if (spi_mem_exec_op(mem, &op))
+		dev_err(&mem->spi->dev, "Failed to perform RDSR2 operation\n");
+
+	return priv->rx_buf;
+}
+
+static void nrf70_wrsr2(struct spi_mem *mem, u8 value)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(NRF70_OP_WRSR2, 1),
+					  SPI_MEM_OP_NO_ADDR,
+					  SPI_MEM_OP_NO_DUMMY,
+					  SPI_MEM_OP_DATA_OUT(1, &priv->tx_buf,
+							      1));
+
+	guard(mutex)(&priv->write_lock);
+	priv->tx_buf = value;
+
+	if (spi_mem_exec_op(mem, &op))
+		dev_err(&mem->spi->dev, "Failed to perform WRSR2 operation\n");
+}
+
+#define	NRF70_FW_FEATURE_RAW_MODE	BIT(3)
+struct __packed nrf70_fw_header {
+	u32 signature;
+	u32 num_images;
+	u32 version;
+	u32 feature_flags;
+	u32 length;
+	u8 hash[NRF70_FW_HASH_LEN];
+	u8 data[];
+};
+
+struct __packed nrf70_fw_img {
+	u32 type;
+	u32 length;
+	u8 data[];
+};
+
+static const u32 nrf_rpu_addr_lut[4] = { NRF70_MCU_UMAC_PATCH_BIMG,
+					 NRF70_MCU_UMAC_PATCH_BIN,
+					 NRF70_MCU_LMAC_PATCH_BIMG,
+					 NRF70_MCU_LMAC_PATCH_BIN };
+
+static const u32 nrf_boot_vectors[][4][2] = {
+	{
+		{
+			NRF70_SBUS_MIPS_MCU_BOOT_EXCP_INSTR_0,
+			NRF70_MCU_LMAC_BOOT_EXCP_VECT_0
+		},
+		{
+			NRF70_SBUS_MIPS_MCU_BOOT_EXCP_INSTR_1,
+			NRF70_MCU_LMAC_BOOT_EXCP_VECT_1
+		},
+		{
+			NRF70_SBUS_MIPS_MCU_BOOT_EXCP_INSTR_2,
+			NRF70_MCU_LMAC_BOOT_EXCP_VECT_2
+		},
+		{
+			NRF70_SBUS_MIPS_MCU_BOOT_EXCP_INSTR_3,
+			NRF70_MCU_LMAC_BOOT_EXCP_VECT_3
+		},
+	},
+	{
+		{
+			NRF70_SBUS_MIPS_MCU2_BOOT_EXCP_INSTR_0,
+			NRF70_MCU_UMAC_BOOT_EXCP_VECT_0
+		},
+		{
+			NRF70_SBUS_MIPS_MCU2_BOOT_EXCP_INSTR_1,
+			NRF70_MCU_UMAC_BOOT_EXCP_VECT_1
+		},
+		{
+			NRF70_SBUS_MIPS_MCU2_BOOT_EXCP_INSTR_2,
+			NRF70_MCU_UMAC_BOOT_EXCP_VECT_2
+		},
+		{
+			NRF70_SBUS_MIPS_MCU2_BOOT_EXCP_INSTR_3,
+			NRF70_MCU_UMAC_BOOT_EXCP_VECT_3
+		},
+	}
+};
+
+static int nrf70_verify_firmware(struct device *dev,
+				 const struct nrf70_fw_header *fw)
+{
+	struct crypto_shash *alg;
+	u8 hash[NRF70_FW_HASH_LEN];
+	int ret;
+
+	alg = crypto_alloc_shash("sha256", 0, 0);
+	if (IS_ERR(alg)) {
+		ret = PTR_ERR(alg);
+		dev_err(dev, "Unable to allocate shash memory: %d\n", ret);
+		goto out;
+	};
+
+	if (crypto_shash_digestsize(alg) != NRF70_FW_HASH_LEN) {
+		dev_err(dev, "Incorrect digest size\n");
+		ret = -EFAULT;
+		goto out;
+	}
+
+	ret = crypto_shash_tfm_digest(alg, fw->data, fw->length, hash);
+	if (ret) {
+		dev_err(dev, "Unable to compute hash\n");
+		goto out;
+	}
+
+	if (memcmp(fw->hash, hash, sizeof(hash))) {
+		dev_err(dev, "Invalid firmware checksum\n");
+		ret = -EFAULT;
+	}
+
+out:
+	crypto_free_shash(alg);
+
+	return ret;
+}
+
+static int nrf70_load_firmware(struct spi_mem *mem)
+{
+	struct device *dev = &mem->spi->dev;
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	const struct nrf70_fw_header *header;
+	const struct nrf70_fw_img *image;
+	const struct firmware *firmware;
+	int val, i, ret;
+	u32 type, len;
+
+	/* Perform RPU MCU reset. */
+	nrf70_writel(mem, NRF70_SBUS_MIPS_MCU_CONTROL, 0x1);
+
+	if (read_poll_timeout(nrf70_readl, val, !(val & 0x1),
+			      10 * USEC_PER_MSEC, 50 * USEC_PER_MSEC, false,
+			      mem, NRF70_SBUS_MIPS_MCU_CONTROL)) {
+		dev_err(dev, "Unable to reset LMAC\n");
+		return -ETIMEDOUT;
+	}
+
+	if (read_poll_timeout(nrf70_readl, val, val & 0x1,
+			      10 * USEC_PER_MSEC, 50 * USEC_PER_MSEC, false,
+			      mem, NRF70_SBUS_CP0_SLEEP_STATUS)) {
+		dev_err(dev, "Unable to reset LMAC2\n");
+		return -ETIMEDOUT;
+	}
+
+	nrf70_writel(mem, NRF70_SBUS_MIPS_MCU2_CONTROL, 0x1);
+
+	if (read_poll_timeout(nrf70_readl, val, !(val & 0x1),
+			      10 * USEC_PER_MSEC, 50 * USEC_PER_MSEC, false,
+			      mem, NRF70_SBUS_MIPS_MCU2_CONTROL)) {
+		dev_err(dev, "Unable to reset UMAC\n");
+		return -ETIMEDOUT;
+	}
+
+	if (read_poll_timeout(nrf70_readl, val, val & 0x1,
+			      10 * USEC_PER_MSEC, 50 * USEC_PER_MSEC, false,
+			      mem, NRF70_SBUS_CP1_SLEEP_STATUS)) {
+		dev_err(dev, "Unable to reset UMAC2\n");
+		return -ETIMEDOUT;
+	}
+
+	ret = request_firmware(&firmware, "nrf70.bin", dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to request firmware: %d\n", ret);
+		return ret;
+	}
+
+	header = (const struct nrf70_fw_header *)firmware->data;
+	if (header->signature != NRF70_FW_SIGNATURE) {
+		dev_err(dev, "Invalid firmware signature\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = nrf70_verify_firmware(dev, header);
+	if (ret)
+		goto out;
+
+	priv->has_raw_mode = header->feature_flags & NRF70_FW_FEATURE_RAW_MODE;
+
+	image = (const struct nrf70_fw_img *)header->data;
+
+	for (i = 0; i < header->num_images; i++) {
+		type = image->type;
+		if (type > 3) {
+			dev_err(dev, "Unknown firmware image type: %d\n", type);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		len = image->length;
+		if (len % 4) {
+			dev_err(dev, "Unaligned firmware image length: %d\n",
+				len);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		nrf70_writev(mem, nrf_rpu_addr_lut[type], image->data, len);
+
+		image = (void *)(image->data + image->length);
+	}
+
+	nrf70_writel(mem, NRF70_MCU_LMAC_BOOT_SIG, 0x0);
+	nrf70_writel(mem, NRF70_UCC_SLEEP_CTRL_DATA_0,
+		     NRF70_LMAC_ROM_PATCH_OFFSET);
+	nrf70_writel(mem, NRF70_MCU_UMAC_BOOT_SIG, 0x0);
+	nrf70_writel(mem, NRF70_UCC_SLEEP_CTRL_DATA_1,
+		     NRF70_UMAC_ROM_PATCH_OFFSET);
+
+	for (i = 0; i < 4; i++)
+		nrf70_writel(mem, nrf_boot_vectors[0][i][0],
+			     nrf_boot_vectors[0][i][1]);
+
+	nrf70_writel(mem, NRF70_SBUS_MIPS_MCU_CONTROL, 0x1);
+
+	for (i = 0; i < 4; i++)
+		nrf70_writel(mem, nrf_boot_vectors[1][i][0],
+			     nrf_boot_vectors[1][i][1]);
+
+	nrf70_writel(mem, NRF70_SBUS_MIPS_MCU2_CONTROL, 0x1);
+
+	if (read_poll_timeout(nrf70_readl, val, val == NRF70_MCU_BOOT_SIG,
+			      100, 10 * USEC_PER_MSEC, false,
+			      mem, NRF70_MCU_LMAC_BOOT_SIG)) {
+		dev_err(dev, "Unable to read LMAC boot signature\n");
+		ret = -ETIMEDOUT;
+		goto out;
+	}
+
+	if (read_poll_timeout(nrf70_readl, val, val == NRF70_MCU_BOOT_SIG,
+			      100, 10 * USEC_PER_MSEC, false,
+			      mem, NRF70_MCU_UMAC_BOOT_SIG)) {
+		dev_err(dev, "Unable to read UMAC boot signature\n");
+		ret = -ETIMEDOUT;
+	}
+
+out:
+	release_firmware(firmware);
+
+	return ret;
+}
+
+static int nrf70_dequeue(struct spi_mem *mem, enum nrf70_hpq_type queue,
+			 u32 *addr)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	u32 val = nrf70_readl(mem, priv->queue[queue].dq);
+
+	if (!val || val == 0xaaaaaaaa || val == 0xffffffff)
+		return -EINVAL;
+
+	nrf70_writel(mem, priv->queue[queue].dq, val);
+	*addr = val;
+
+	return 0;
+}
+
+static int nrf70_enqueue_message(struct spi_mem *mem, struct nrf70_msg *msg)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct device *dev = &mem->spi->dev;
+	int val, total, len;
+	u32 addr;
+	u8 *buf = (u8 *)msg;
+
+	guard(mutex)(&priv->enqueue_lock);
+	for (total = msg->len; total > 0; total -= len, buf += len) {
+		len = min(ALIGN(total, 4), NRF70_UMAC_CMD_MAX_SZ);
+
+		if (read_poll_timeout(nrf70_dequeue, val, !val,
+				      2 * USEC_PER_MSEC, 10 * USEC_PER_MSEC,
+				      false, mem, NRF70_CMD_AVL_QUEUE, &addr)) {
+			dev_err(dev, "Unable to send message\n");
+			return -ETIMEDOUT;
+		}
+
+		nrf70_writev(mem, addr, buf, len);
+		nrf70_writel(mem, priv->queue[NRF70_CMD_BUSY_QUEUE].eq, addr);
+
+		val = priv->num_cmds++ | NRF70_UCCP_HOST2_TO_MTX2_CMD_DATA_MASK;
+		nrf70_writel(mem, NRF70_SBUS_UCCP_CORE_HOST2_TO_MTX2_CMD, val);
+	}
+
+	return 0;
+}
+
+static int nrf70_init_rx(struct spi_mem *mem, int desc)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct device *dev = &mem->spi->dev;
+	u32 addr, bounce_addr;
+	size_t rx_addr_base = (NRF70_RPU_PKTRAM_PKT_BASE +
+			      NRF70_RPU_PKTRAM_PKT_BASE_SZ) -
+			      (NRF70_NUM_RX_BUFS * NRF70_RX_DATA_MAX_SZ);
+	int i = desc / (NRF70_NUM_RX_BUFS / NRF70_NUM_RX_QUEUES);
+
+	addr = priv->rx_cmd_base + desc * NRF70_DATA_CMD_RX_MAX_SZ;
+	if (addr % 4) {
+		dev_err(dev, "Misaligned indirect write\n");
+		return -EINVAL;
+	}
+
+	bounce_addr = rx_addr_base + desc * NRF70_RX_DATA_MAX_SZ;
+	nrf70_writel(mem, bounce_addr, desc);
+
+	addr = (addr & NRF70_HOST_OFFSET_MASK) >> 2;
+	nrf70_writel(mem, NRF70_SBUS_CORE_MEM_CTRL, addr);
+	nrf70_writel(mem, NRF70_SBUS_CORE_MEM_WDATA, bounce_addr);
+	nrf70_writel(mem, priv->queue[NRF70_RX_BUSY_QUEUE + i].eq,
+		     priv->rx_cmd_base + desc * NRF70_DATA_CMD_RX_MAX_SZ);
+
+	return 0;
+}
+
+static int nrf70_init_rx_command(struct spi_mem *mem)
+{
+	int i, ret = 0;
+
+	for (i = 0; ret || i < NRF70_NUM_RX_BUFS; i++)
+		ret = nrf70_init_rx(mem, i);
+
+	return ret;
+}
+
+static struct nrf70_msg *nrf70_create_msg(u32 type, u32 id, size_t data_len,
+					  int iface)
+{
+	struct nrf70_msg *msg;
+	union cmd_header {
+		struct __packed nrf70_header sys;
+		struct __packed nrf70_umac_header umac;
+	} *hdr;
+	size_t len = sizeof(*msg) + data_len;
+
+	msg = kzalloc(len, GFP_KERNEL);
+	if (!msg)
+		return ERR_PTR(-ENOMEM);
+
+	msg->type = type;
+	msg->len = len;
+
+	hdr = (union cmd_header *)msg->data;
+	switch (type) {
+	case NRF70_MSG_SYSTEM:
+		fallthrough;
+	case NRF70_MSG_DATA:
+		hdr->sys.id = id;
+		hdr->sys.len = data_len;
+	break;
+	case NRF70_MSG_UMAC:
+		hdr->umac.id = id;
+		if (iface >= 0) {
+			hdr->umac.idx.wdev_id = iface;
+			hdr->umac.idx.valid_fields = NRF70_UMAC_ID_WDEV;
+		}
+	break;
+	default:
+		kfree(msg);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return msg;
+}
+
+static const u8 nrf7002_qfn_rf_params[NRF70_RF_PARAMS_SZ] = {
+	NRF70_RESERVED,
+	NRF70_RESERVED,
+	NRF70_RESERVED,
+	NRF70_RESERVED,
+	NRF70_RESERVED,
+	NRF70_RESERVED,
+	/* XO */
+	NRF70_QFN_XO_VAL,
+	/* PD adjust values for MCS7. Currently unused. */
+	NRF70_PD_ADJUST_VAL,
+	NRF70_PD_ADJUST_VAL,
+	NRF70_PD_ADJUST_VAL,
+	NRF70_PD_ADJUST_VAL,
+	/* TX power systematic offset. */
+	NRF70_SYSTEM_OFFSET_LB,
+	NRF70_SYSTEM_OFFSET_HB_CHAN_LOW,
+	NRF70_SYSTEM_OFFSET_HB_CHAN_MID,
+	NRF70_SYSTEM_OFFSET_HB_CHAN_HIGH,
+	/* Max TX power value for which both EVM and SEM pass. */
+	NRF70_QFN_MAX_TX_PWR_DSSS,
+	NRF70_QFN_MAX_TX_PWR_LB_MCS7,
+	NRF70_QFN_MAX_TX_PWR_LB_MCS0,
+	NRF70_QFN_MAX_TX_PWR_HB_LOW_CHAN_MCS7,
+	NRF70_QFN_MAX_TX_PWR_HB_MID_CHAN_MCS7,
+	NRF70_QFN_MAX_TX_PWR_HB_HIGH_CHAN_MCS7,
+	NRF70_QFN_MAX_TX_PWR_HB_LOW_CHAN_MCS0,
+	NRF70_QFN_MAX_TX_PWR_HB_MID_CHAN_MCS0,
+	NRF70_QFN_MAX_TX_PWR_HB_HIGH_CHAN_MCS0,
+	/* RX gain adjustment offsets. */
+	NRF70_RX_GAIN_OFFSET_LB_CHAN,
+	NRF70_RX_GAIN_OFFSET_HB_LOW_CHAN,
+	NRF70_RX_GAIN_OFFSET_HB_MID_CHAN,
+	NRF70_RX_GAIN_OFFSET_HB_HIGH_CHAN,
+	/* Voltage and temperature dependent backoffs. */
+	NRF70_QFN_MAX_CHIP_TEMP,
+	NRF70_QFN_MIN_CHIP_TEMP,
+	NRF70_QFN_LB_MAX_PWR_BKF_HI_TEMP,
+	NRF70_QFN_LB_MAX_PWR_BKF_LOW_TEMP,
+	NRF70_QFN_HB_MAX_PWR_BKF_HI_TEMP,
+	NRF70_QFN_HB_MAX_PWR_BKF_LOW_TEMP,
+	NRF70_QFN_LB_VBT_LT_VLOW,
+	NRF70_QFN_HB_VBT_LT_VLOW,
+	NRF70_QFN_LB_VBT_LT_LOW,
+	NRF70_QFN_HB_VBT_LT_LOW,
+	NRF70_RESERVED,
+	NRF70_RESERVED,
+	NRF70_RESERVED,
+	NRF70_RESERVED,
+	/* PHY parameters blob. */
+	NRF70_PHY_PARAMS,
+};
+
+static int nrf70_init_command(struct spi_mem *mem)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_sys_init *cmd;
+	int ret;
+
+	msg = nrf70_create_msg(NRF70_MSG_SYSTEM, NRF70_CMD_INIT, sizeof(*cmd),
+			       -1);
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_sys_init *)msg->data;
+	cmd->sys_param.phy_calib = NRF70_DEF_PHY_CALIB;
+	cmd->sys_param.hw_bringup_time = 7300;
+	cmd->sys_param.sw_bringup_time = 5000;
+	cmd->sys_param.bcn_time_out = 20000;
+	memcpy(cmd->sys_param.rf_params, nrf7002_qfn_rf_params,
+	       sizeof(nrf7002_qfn_rf_params));
+	cmd->sys_param.rf_params_valid = true;
+	cmd->tcp_ip_checksum_offload = 1;
+	cmd->op_band = NRF70_OP_BAND_ALL;
+	cmd->discon_timeout = 20;
+
+	cmd->rx_buf_pools[0].size = NRF70_RX_DATA_MAX_SZ;
+	cmd->rx_buf_pools[1].size = NRF70_RX_DATA_MAX_SZ;
+	cmd->rx_buf_pools[2].size = NRF70_RX_DATA_MAX_SZ;
+	cmd->rx_buf_pools[0].count = NRF70_NUM_RX_BUFS / NRF70_NUM_RX_QUEUES;
+	cmd->rx_buf_pools[1].count = NRF70_NUM_RX_BUFS / NRF70_NUM_RX_QUEUES;
+	cmd->rx_buf_pools[2].count = NRF70_NUM_RX_BUFS / NRF70_NUM_RX_QUEUES;
+
+	cmd->data_config_params.rate_protection_type = 0;
+	cmd->data_config_params.aggregation = 1;
+	cmd->data_config_params.wmm = 0;
+	cmd->data_config_params.max_tx_agg_sessions = 4;
+	cmd->data_config_params.max_rx_agg_sessions = 8;
+	cmd->data_config_params.max_tx_aggregation = 12;
+	cmd->data_config_params.reorder_buf_size = 64;
+	cmd->data_config_params.max_rxampdu_size = 3; /* 64 KiB. */
+
+	cmd->vbat_config.temp_based_calib_en = 1;
+	cmd->vbat_config.temp_calib_bitmap = NRF70_DEF_PHY_TEMP_CALIB;
+	cmd->vbat_config.vbat_calibp_bitmap = NRF70_PHY_CALIB_FLAG_DPD;
+	cmd->vbat_config.temp_vbat_mon_period = 1024 * 1024;
+	cmd->vbat_config.vth_very_low = NRF70_VBAT_MV_TO_VTH(3060);
+	cmd->vbat_config.vth_low = NRF70_VBAT_MV_TO_VTH(3340);
+	cmd->vbat_config.vth_hi = NRF70_VBAT_MV_TO_VTH(3480);
+	cmd->vbat_config.temp_threshold = 40;
+
+	ret = nrf70_enqueue_message(mem, msg);
+	kfree(msg);
+
+	return ret ? ret : (wait_for_completion_timeout(&priv->init_done, HZ) ?
+			    0 : -ETIMEDOUT);
+}
+
+static int nrf70_hwaddr_change_command(struct spi_mem *mem, const u8 *hwaddr,
+				       int iface)
+{
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_change_hwaddr *cmd;
+	int ret;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_CHANGE_MACADDR,
+			       sizeof(*cmd), iface);
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_change_hwaddr *)msg->data;
+	ether_addr_copy(cmd->hwaddr, hwaddr);
+
+	ret = nrf70_enqueue_message(mem, msg);
+	kfree(msg);
+
+	return ret;
+}
+
+static struct nrf70_vif *nrf70_get_vif(struct nrf70_priv *priv, int iface)
+{
+	struct nrf70_vif *vif;
+
+	list_for_each_entry(vif, &priv->vifs, list)
+		if (vif->iface == iface)
+			return vif;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int nrf70_dequeue_sys_event(struct spi_mem *mem, void *data)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct device *dev = &mem->spi->dev;
+	struct nrf70_header *header = data;
+	struct nrf70_vif *vif;
+
+	switch (header->id) {
+	case NRF70_EVENT_INIT_DONE:
+	fallthrough;
+	case NRF70_EVENT_DEINIT_DONE:
+		complete_all(&priv->init_done);
+		break;
+	case NRF70_EVENT_MODE_SET_DONE:
+		{
+			struct nrf70_event_raw_config_mode *ev = data;
+
+			vif = nrf70_get_vif(priv, ev->if_idx);
+
+			if (IS_ERR(vif))
+				return PTR_ERR(vif);
+
+			if (!ev->status)
+				complete(&vif->iface_updated);
+		}
+		break;
+	case NRF70_EVENT_CHANNEL_SET_DONE:
+		{
+			struct nrf70_event_set_channel *ev = data;
+
+			vif = nrf70_get_vif(priv, ev->if_idx);
+
+			if (!ev->status)
+				complete(&vif->chan_updated);
+		}
+		break;
+	default:
+		dev_dbg(dev, "Unsupported system event type: %d\n",
+			header->id);
+		return 1;
+	}
+
+	return 0;
+}
+
+enum nrf70_rx_pkt_type {
+	NRF70_RX_PKT_DATA,
+	NRF70_RX_PKT_BCN_PRB_RSP,
+	NRF70_RAW_RX_PKT
+};
+
+enum nrf70_pkt_type {
+	NRF70_PKT_MPDU,
+	NRF70_PKT_MSDU_WITH_MAC,
+	NRF70_PKT_MSDU,
+};
+
+struct nrf70_radiotap_hdr {
+	struct ieee80211_radiotap_header hdr;
+	u8 rate;
+	__le16 chan;
+	__le16 chan_mask;
+	s8 signal;
+};
+
+static void nrf70_netif_rx(struct sk_buff *skb, struct nrf70_vif *vif)
+{
+	int len = skb->len;
+
+	if (netif_rx(skb)) {
+		u64_stats_update_begin(&vif->stats.syncp);
+		vif->stats.rx_dropped++;
+		u64_stats_update_end(&vif->stats.syncp);
+		return;
+	}
+
+	u64_stats_update_begin(&vif->stats.syncp);
+	vif->stats.rx_packets++;
+	vif->stats.rx_bytes += len;
+	u64_stats_update_end(&vif->stats.syncp);
+}
+
+static int nrf70_handle_cmd_rx_buf(struct spi_mem *mem,
+				   struct nrf70_cmd_rx_buf *ev)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct nrf70_vif *vif = nrf70_get_vif(priv, ev->wdev_id);
+	struct device *dev = &mem->spi->dev;
+	struct ieee80211_mgmt *mgmt;
+	struct sk_buff *skb;
+	struct cfg80211_bss *bss;
+	struct nrf70_radiotap_hdr *hdr;
+	struct ieee80211_hdr *data_hdr;
+	struct ieee80211_channel *ch;
+	size_t len, rx_addr_base;
+	u32 bounce_addr, desc;
+	int data_offset, i;
+	bool amsdu;
+
+	if (IS_ERR(vif))
+		return PTR_ERR(vif);
+
+	for (i = 0; i < ev->rx_pkt_cnt; i++) {
+		desc = ev->buf_info[i].desc_id;
+		rx_addr_base = (NRF70_RPU_PKTRAM_PKT_BASE +
+			       NRF70_RPU_PKTRAM_PKT_BASE_SZ) -
+			       (NRF70_NUM_RX_BUFS * NRF70_RX_DATA_MAX_SZ);
+		bounce_addr = rx_addr_base + desc * NRF70_RX_DATA_MAX_SZ;
+		len = ev->buf_info[i].pkt_len;
+		skb = alloc_skb(len + sizeof(*hdr), GFP_ATOMIC);
+		if (!skb)
+			continue;
+
+		skb_reserve(skb, sizeof(*hdr));
+		skb_put(skb, len);
+		nrf70_readv(mem, bounce_addr, skb->data, len);
+		nrf70_init_rx(mem, ev->buf_info[i].desc_id);
+
+		ch = ieee80211_get_channel(priv->wiphy, ev->frequency);
+
+		switch (ev->rx_pkt_type) {
+		case NRF70_RX_PKT_DATA:
+			data_hdr = (struct ieee80211_hdr *)skb->data;
+			data_offset = ev->mac_header_len -
+				      ieee80211_hdrlen(data_hdr->frame_control);
+
+			amsdu = ev->buf_info[i].pkt_type != NRF70_PKT_MPDU;
+			if (ieee80211_data_to_8023_exthdr(skb, NULL,
+							  vif->ndev->dev_addr,
+							  vif->wdev.iftype,
+							  data_offset, amsdu)) {
+				u64_stats_update_begin(&vif->stats.syncp);
+				vif->stats.rx_dropped++;
+				u64_stats_update_end(&vif->stats.syncp);
+				break;
+			}
+
+			skb->dev = vif->ndev;
+			skb->protocol = eth_type_trans(skb, skb->dev);
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+			nrf70_netif_rx(skb, vif);
+
+			/* Skip over kfree_skb - net stack will handle that. */
+			continue;
+		case NRF70_RX_PKT_BCN_PRB_RSP:
+			mgmt = (struct ieee80211_mgmt *)skb->data;
+			if (skb->len < 24 ||
+			    (!ieee80211_is_probe_resp(mgmt->frame_control) &&
+			    !ieee80211_is_beacon(mgmt->frame_control)))
+				break;
+
+			bss = cfg80211_inform_bss_frame(priv->wiphy, ch, mgmt,
+							skb->len, ev->signal,
+							GFP_ATOMIC);
+			cfg80211_put_bss(priv->wiphy, bss);
+			break;
+		case NRF70_RAW_RX_PKT:
+			hdr = skb_push(skb, sizeof(*hdr));
+			memset(hdr, 0, sizeof(*hdr));
+			hdr->hdr.it_version = PKTHDR_RADIOTAP_VERSION;
+			hdr->hdr.it_pad = 0;
+			hdr->hdr.it_len = cpu_to_le16(sizeof(*hdr));
+			hdr->hdr.it_present = NRF70_RADIOTAP_PRESENT_FIELDS;
+			hdr->rate = ev->rate;
+			hdr->chan = ev->frequency;
+
+			if (ch->band == NL80211_BAND_5GHZ)
+				hdr->chan_mask |= IEEE80211_CHAN_OFDM |
+						  IEEE80211_CHAN_5GHZ;
+			else
+				hdr->chan_mask |= IEEE80211_CHAN_2GHZ;
+
+			hdr->signal = MBM_TO_DBM(ev->signal);
+
+			skb->dev = vif->ndev;
+			skb_reset_mac_header(skb);
+			skb->pkt_type = PACKET_OTHERHOST;
+			skb->protocol = htons(ETH_P_802_2);
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+			nrf70_netif_rx(skb, vif);
+
+			/* Skip over kfree_skb - net stack will handle that. */
+			continue;
+		default:
+			dev_err(dev, "Unknown rx packet type: %d\n",
+				ev->rx_pkt_type);
+			break;
+		}
+		kfree_skb(skb);
+	}
+
+	return 0;
+}
+
+static int nrf70_get_sta_idx(struct nrf70_vif *vif, const u8 *mac)
+{
+	unsigned long bmp;
+	int bit;
+
+	bmp = READ_ONCE(vif->sta_bitmap) & NRF70_PEERS_MASK;
+
+	while (1) {
+		bit = ffz(bmp);
+		if (bit >= NRF70_PEERS_MAX)
+			return -ENOENT;
+
+		if (ether_addr_equal(vif->sta[bit].addr, mac))
+			return bit;
+
+		set_bit(bit, &bmp);
+	}
+}
+
+static int nrf70_handle_pm_mode(struct spi_mem *mem,
+				struct nrf70_cmd_sap_pm *ev)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct nrf70_vif *vif = nrf70_get_vif(priv, ev->wdev_id);
+	int i;
+
+	if (IS_ERR(vif))
+		return PTR_ERR(vif);
+
+	guard(spinlock_irqsave)(&vif->sta_lock);
+	i = nrf70_get_sta_idx(vif, ev->hwaddr);
+	if (i < 0)
+		return -EINVAL;
+
+	vif->sta[i].can_xmit = !ev->state;
+
+	lockdep_assert_wiphy(priv->wiphy);
+
+	if (ev->state == NRF70_SAP_PM_CLIENT_ACTIVE)
+		wiphy_work_queue(priv->wiphy, &vif->sta[i].pending_work);
+	else
+		wiphy_work_cancel(priv->wiphy, &vif->sta[i].pending_work);
+
+	return 0;
+}
+
+static void nrf70_drain_tx(struct nrf70_priv *priv, struct nrf70_vif *vif)
+{
+	unsigned long bmp;
+	int bit;
+
+	guard(spinlock_irqsave)(&vif->sta_lock);
+	bmp = READ_ONCE(vif->sta_bitmap) & NRF70_PEERS_MASK;
+
+	while (1) {
+		bit = ffz(bmp);
+		if (bit >= NRF70_PEERS_MAX)
+			break;
+
+		vif->sta[bit].can_xmit = false;
+		wiphy_work_cancel(priv->wiphy, &vif->sta[bit].pending_work);
+		skb_queue_purge(&vif->sta[bit].pending);
+
+		set_bit(bit, &bmp);
+	}
+
+	wiphy_work_cancel(priv->wiphy, &vif->xmit_work);
+	skb_queue_purge(&vif->tx_queue);
+}
+
+static void nrf70_carrier_change(struct nrf70_priv *priv, int iface, bool state)
+{
+	struct nrf70_vif *vif = nrf70_get_vif(priv, iface);
+
+	if (IS_ERR(vif))
+		return;
+
+	if (state) {
+		netif_carrier_on(vif->ndev);
+		return;
+	}
+
+	netif_carrier_off(vif->ndev);
+	nrf70_drain_tx(priv, vif);
+}
+
+static int nrf70_handle_cmd_tx_buff_done(struct spi_mem *mem,
+					 struct nrf70_event_tx_buff_done *ev)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct nrf70_vif *vif;
+	int i, iface, desc = ev->tx_desc_num;
+
+	mutex_lock(&priv->desc_lock);
+	iface = !!(priv->tx_desc_bitmap[0] & BIT(desc));
+	set_bit(ev->tx_desc_num, &priv->tx_desc_bitmap[iface]);
+	mutex_unlock(&priv->desc_lock);
+
+	vif = nrf70_get_vif(priv, iface);
+	wiphy_work_queue(priv->wiphy, &vif->xmit_work);
+
+	for (i = 0; i < ev->num_tx_status_code; i++) {
+		if (ev->tx_status_code[i]) {
+			u64_stats_update_begin(&vif->stats.syncp);
+			vif->stats.tx_dropped++;
+			u64_stats_update_end(&vif->stats.syncp);
+		}
+	}
+
+	return 0;
+}
+
+static int nrf70_dequeue_data_event(struct spi_mem *mem, void *data)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct device *dev = &mem->spi->dev;
+	struct nrf70_header *header = data;
+
+	switch (header->id) {
+	case NRF70_CMD_TX_BUFF_DONE:
+		nrf70_handle_cmd_tx_buff_done(mem, data);
+		break;
+	case NRF70_CMD_CARRIER_ON:
+	fallthrough;
+	case NRF70_CMD_CARRIER_OFF:
+		{
+			struct nrf70_event_carrier_state *ev = data;
+			bool state = header->id == NRF70_CMD_CARRIER_ON;
+
+			nrf70_carrier_change(priv, ev->wdev_id, state);
+		}
+		break;
+	case NRF70_CMD_RX_BUFF:
+		nrf70_handle_cmd_rx_buf(mem, data);
+		break;
+	case NRF70_CMD_PM_MODE:
+		nrf70_handle_pm_mode(mem, data);
+		break;
+	default:
+		dev_dbg(dev, "Unsupported data event type: %d\n", header->id);
+		return 1;
+	}
+
+	return 0;
+}
+
+static int nrf70_get_scan_results_command(struct spi_mem *mem, int iface)
+{
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_get_scan_results *cmd;
+	int ret;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_GET_SCAN_RESULTS,
+			       sizeof(*cmd), iface);
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_get_scan_results *)msg->data;
+	cmd->reason = 0;
+
+	ret = nrf70_enqueue_message(mem, msg);
+	kfree(msg);
+
+	return ret;
+}
+
+static void nrf70_handle_cmd_status(struct spi_mem *mem,
+				    struct nrf70_event_cmd_status *ev)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct nrf70_vif *vif = nrf70_get_vif(priv, ev->header.idx.wdev_id);
+	struct cfg80211_scan_info info = { .aborted = true, };
+
+	if (IS_ERR(vif))
+		return;
+
+	if (!ev->status)
+		return;
+
+	switch (ev->cmd_id) {
+	case NRF70_UMAC_CMD_TRIGGER_SCAN:
+		if (vif->scan_req) {
+			cfg80211_scan_done(vif->scan_req, &info);
+			vif->scan_req = NULL;
+		}
+
+		WRITE_ONCE(priv->scan_in_progress, false);
+		break;
+	case NRF70_UMAC_CMD_GET_STATION:
+		complete(&priv->station_info_available);
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+nrf70_handle_scan_display_results(struct spi_mem *mem,
+				  struct nrf70_event_scan_display_results *ev)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct nrf70_vif *vif = nrf70_get_vif(priv, ev->header.idx.wdev_id);
+	struct device *dev = &mem->spi->dev;
+	struct cfg80211_bss *bss;
+	struct cfg80211_scan_info info = { .aborted = false, };
+	struct nrf70_display_results *res;
+	struct ieee80211_channel *rx_chan;
+	u8 ie[2 + IEEE80211_MAX_SSID_LEN];
+	int i, freq;
+
+	if (IS_ERR(vif))
+		return;
+
+	if (ev->bss_count > NRF70_DISP_SCAN_RES_SZ) {
+		dev_err(dev, "BSS count %d too large\n", ev->bss_count);
+		return;
+	}
+
+	for (i = 0; i < ev->bss_count; i++) {
+		res = &ev->results[i];
+		freq = ieee80211_channel_to_freq_khz(res->chan, res->band);
+		rx_chan = ieee80211_get_channel_khz(priv->wiphy, freq);
+		bss = cfg80211_get_bss(priv->wiphy, rx_chan, res->hwaddr,
+				       res->ssid.ssid, res->ssid.len,
+				       IEEE80211_BSS_TYPE_ESS,
+				       IEEE80211_PRIVACY_ANY);
+		if (bss) {
+			cfg80211_put_bss(priv->wiphy, bss);
+			continue;
+		}
+
+		/*
+		 * Generate a partial entry until the first BSS info event
+		 * becomes available.
+		 */
+		memset(ie, 0, sizeof(ie));
+		ie[0] = WLAN_EID_SSID;
+		ie[1] = res->ssid.len;
+		memcpy(ie + 2, res->ssid.ssid, res->ssid.len);
+
+		bss = cfg80211_inform_bss(priv->wiphy,
+					  rx_chan,
+					  CFG80211_BSS_FTYPE_BEACON,
+					  res->hwaddr,
+					  0,
+					  res->capability,
+					  res->beacon_interval,
+					  ie, 2 + res->ssid.len,
+					  res->signal.mbm_signal,
+					  GFP_KERNEL);
+		cfg80211_put_bss(priv->wiphy, bss);
+	}
+
+	/* Final results for the scan request. */
+	if (!ev->header.seq) {
+		info.aborted = false;
+		cfg80211_scan_done(vif->scan_req, &info);
+		vif->scan_req = NULL;
+	}
+}
+
+static void nrf70_handle_auth(struct spi_mem *mem, struct nrf70_event_mlme *ev)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct nrf70_vif *vif = nrf70_get_vif(priv, ev->header.idx.wdev_id);
+
+	if (IS_ERR(vif))
+		return;
+
+	cfg80211_rx_mlme_mgmt(vif->ndev, ev->frame.data, ev->frame.len);
+}
+
+static void nrf70_handle_assoc(struct spi_mem *mem, struct nrf70_event_mlme *ev)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct nrf70_vif *vif = nrf70_get_vif(priv, ev->header.idx.wdev_id);
+	struct cfg80211_rx_assoc_resp_data data = {
+		.buf = ev->frame.data,
+		.len = ev->frame.len,
+		.uapsd_queues = -1,
+		.req_ies = ev->req_ie,
+		.req_ies_len = ev->req_ie_len,
+		.uapsd_queues = ev->wme_uapsd_queues,
+	};
+
+	if (IS_ERR(vif))
+		return;
+
+	data.links[0].bss = vif->bss;
+
+	cfg80211_rx_assoc_resp(vif->ndev, &data);
+}
+
+static void nrf70_handle_tx_mlme_mgmt(struct spi_mem *mem,
+				      struct nrf70_event_mlme *ev)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct nrf70_vif *vif = nrf70_get_vif(priv, ev->header.idx.wdev_id);
+
+	if (IS_ERR(vif))
+		return;
+
+	cfg80211_tx_mlme_mgmt(vif->ndev, ev->frame.data, ev->frame.len, false);
+}
+
+static void nrf70_handle_rx_mgmt(struct spi_mem *mem,
+				 struct nrf70_event_mlme *ev)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct nrf70_vif *vif = nrf70_get_vif(priv, ev->header.idx.wdev_id);
+
+	if (IS_ERR(vif))
+		return;
+
+	(void)cfg80211_rx_mgmt(&vif->wdev, ev->frequency, ev->rx_signal_dbm,
+			       ev->frame.data, ev->frame.len, ev->wifi_flags);
+}
+
+static void nrf70_handle_cookie_resp(struct spi_mem *mem,
+				     struct nrf70_event_cookie_resp *ev)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct nrf70_cookie *cookie;
+
+	cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
+	if (!cookie)
+		return;
+
+	INIT_LIST_HEAD(&cookie->list);
+	cookie->host_cookie = ev->host_cookie;
+	cookie->rpu_cookie = ev->cookie;
+
+	list_add_tail(&priv->cookies, &cookie->list);
+}
+
+static void nrf70_handle_frame_tx_status(struct spi_mem *mem,
+					 struct nrf70_event_mlme *ev)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct nrf70_vif *vif = nrf70_get_vif(priv, ev->header.idx.wdev_id);
+	struct device *dev = &mem->spi->dev;
+	bool ack = ev->wifi_flags & NRF70_EVENT_MLME_ACK;
+	struct nrf70_cookie *cookie, *tmp;
+	u64 host_cookie = 0;
+
+	if (IS_ERR(vif))
+		return;
+
+	list_for_each_entry_safe(cookie, tmp, &priv->cookies, list) {
+		if (cookie->rpu_cookie != ev->cookie)
+			continue;
+
+		host_cookie = cookie->host_cookie;
+		list_del(&cookie->list);
+		kfree(cookie);
+	}
+
+	if (!host_cookie)
+		dev_err(dev, "Host cookie for %llx not found\n", ev->cookie);
+
+	cfg80211_mgmt_tx_status(&vif->wdev, host_cookie, ev->frame.data,
+				ev->frame.len, ack, GFP_ATOMIC);
+}
+
+#define	NRF70_TX_DESC_BMP		\
+	((priv->tx_desc_bitmap[0] & priv->tx_desc_bitmap[1]) & NRF70_DESC_MASK)
+
+static int nrf70_dequeue_tx(struct nrf70_priv *priv, struct sk_buff **skb,
+			    struct sk_buff_head *queue)
+{
+	int desc, iface;
+
+	guard(mutex)(&priv->desc_lock);
+
+	desc = ffs(NRF70_TX_DESC_BMP) - 1;
+
+	if (desc < 0)
+		return -1;
+
+	*skb = skb_dequeue(queue);
+	if (!*skb)
+		return -1;
+
+	iface = NRF70_NDEV_TO_IFACE((*skb)->dev);
+	clear_bit(desc, &priv->tx_desc_bitmap[iface]);
+
+	return desc;
+}
+
+static void nrf70_pending_worker(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct nrf70_sta *sta = container_of(work, struct nrf70_sta,
+					     pending_work);
+	struct sk_buff *skb;
+	struct nrf70_vif *vif;
+
+	/* Move pending skbs into the hw queue. */
+	while ((skb = skb_dequeue(&sta->pending))) {
+		vif = ((struct nrf70_ndev_priv *)netdev_priv(skb->dev))->vif;
+		skb_queue_tail(&vif->tx_queue, skb);
+		wiphy_work_queue(wiphy, &vif->xmit_work);
+	}
+}
+
+static void nrf70_xmit_worker(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct nrf70_vif *vif = container_of(work, struct nrf70_vif, xmit_work);
+	struct nrf70_wiphy_priv *wpriv = wiphy_priv(wiphy);
+	struct nrf70_priv *priv = wpriv->priv;
+	struct spi_mem *mem = priv->mem;
+	struct device *dev = &mem->spi->dev;
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_tx_buf *cmd;
+	struct sk_buff *skb;
+	size_t skb_len, msg_len;
+	u32 addr, bounce_addr, val;
+	int desc;
+
+	if (skb_queue_empty(&vif->tx_queue))
+		return;
+
+	msg_len = sizeof(*msg) + sizeof(*cmd) + sizeof(struct nrf70_buf_info);
+	msg = kzalloc(msg_len, GFP_KERNEL);
+	if (unlikely(!msg)) {
+		dev_err(dev, "Unable to allocate message buffer\n");
+		return;
+	}
+
+	while (!skb_queue_empty(&vif->tx_queue)) {
+		desc = nrf70_dequeue_tx(priv, &skb, &vif->tx_queue);
+		if (desc < 0)
+			break;
+
+		if (skb_queue_len(&vif->tx_queue) < NRF70_TX_PENDING_WMARK &&
+		    netif_queue_stopped(skb->dev))
+			netif_wake_queue(skb->dev);
+
+		skb_len = ALIGN(skb->len, 4);
+		if (skb_len > NRF70_TX_DATA_MAX_SZ) {
+			u64_stats_update_begin(&vif->stats.syncp);
+			vif->stats.tx_dropped++;
+			u64_stats_update_end(&vif->stats.syncp);
+			goto consume;
+		}
+
+		bounce_addr = NRF70_RPU_PKTRAM_PKT_BASE +
+			      desc * NRF70_TX_DATA_MAX_SZ;
+
+		nrf70_writev(priv->mem, bounce_addr, skb->data, skb_len);
+
+		msg->type = NRF70_MSG_DATA;
+		msg->len = msg_len;
+		cmd = (struct nrf70_cmd_tx_buf *)msg->data;
+		cmd->header.id = NRF70_CMD_TX_BUFF;
+		cmd->header.len = sizeof(*cmd) + sizeof(struct nrf70_buf_info);
+
+		ether_addr_copy(cmd->mac_hdr_info.dst, skb->data);
+		ether_addr_copy(cmd->mac_hdr_info.src, skb->data + ETH_ALEN);
+
+		cmd->mac_hdr_info.tx_flags = skb->priority & NRF70_TX_QOS_MASK;
+		if (skb->priority == 0xff)
+			cmd->mac_hdr_info.tx_flags |= NRF70_TX_FLAG_TWT_EMERG;
+
+		if (!skb_checksum_complete(skb))
+			cmd->mac_hdr_info.tx_flags |= NRF70_TX_FLAG_CSUM_AVAIL;
+
+		cmd->mac_hdr_info.etype = be16_to_cpu(skb->protocol);
+		cmd->mac_hdr_info.eosp = 0;
+		cmd->wdev_id = NRF70_NDEV_TO_IFACE(skb->dev);
+		cmd->tx_desc_num = desc;
+		cmd->num_tx_pkts = 1; /* Frame aggregation not yet supported. */
+
+		cmd->buf_info[0].pkt_len = skb->len;
+		cmd->buf_info[0].ddr_ptr = bounce_addr;
+
+		addr = priv->tx_cmd_base + desc * NRF70_DATA_CMD_TX_MAX_SZ;
+		nrf70_writev(mem, addr, msg, ALIGN(msg->len, 4));
+
+		mutex_lock(&priv->enqueue_lock);
+		nrf70_writel(mem, priv->queue[NRF70_CMD_BUSY_QUEUE].eq, addr);
+		val = priv->num_cmds++ | NRF70_UCCP_HOST2_TO_MTX2_CMD_DATA_MASK;
+		nrf70_writel(mem, NRF70_SBUS_UCCP_CORE_HOST2_TO_MTX2_CMD, val);
+		mutex_unlock(&priv->enqueue_lock);
+
+		u64_stats_update_begin(&vif->stats.syncp);
+		vif->stats.tx_packets++;
+		vif->stats.tx_bytes += skb->len;
+		u64_stats_update_end(&vif->stats.syncp);
+
+consume:
+		consume_skb(skb);
+	}
+
+	kfree(msg);
+}
+
+static void nrf70_handle_station(struct spi_mem *mem,
+				 struct nrf70_event_new_station *ev,
+				 bool new_station)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct nrf70_vif *vif = nrf70_get_vif(priv, ev->header.idx.wdev_id);
+	struct device *dev = &mem->spi->dev;
+	int i;
+
+	if (IS_ERR(vif))
+		return;
+
+	guard(spinlock_irqsave)(&vif->sta_lock);
+	if (new_station) {
+		i = ffs(vif->sta_bitmap) - 1;
+		if (i < 0) {
+			dev_err(dev, "Unable to store new station data\n");
+			return;
+		}
+
+		clear_bit(i, &vif->sta_bitmap);
+		ether_addr_copy(vif->sta[i].addr, ev->hwaddr);
+
+		wiphy_work_init(&vif->sta[i].pending_work,
+				nrf70_pending_worker);
+		skb_queue_head_init(&vif->sta[i].pending);
+		vif->sta[i].can_xmit = true;
+
+		return;
+	}
+
+	i = nrf70_get_sta_idx(vif, ev->hwaddr);
+	if (i < 0)
+		return;
+
+	wiphy_work_cancel(priv->wiphy, &vif->sta[i].pending_work);
+	skb_queue_purge(&vif->sta[i].pending);
+	vif->sta[i].can_xmit = false;
+	set_bit(i, &vif->sta_bitmap);
+}
+
+static void nrf70_handle_get_station(struct spi_mem *mem,
+				     struct nrf70_event_new_station *ev)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct device *dev = &mem->spi->dev;
+	struct station_info *sinfo = priv->sinfo;
+	u32 valid = ev->sta_info.valid_fields;
+	struct nrf70_rate_info *rate_info;
+
+	if (!sinfo) {
+		dev_err(dev, "Invalid station info reference\n");
+		return;
+	}
+
+	if (valid & NRF70_STA_INFO_CONNECTED_TIME) {
+		sinfo->connected_time = ev->sta_info.connected_time;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CONNECTED_TIME);
+	}
+	if (valid & NRF70_STA_INFO_INACTIVE_TIME) {
+		sinfo->inactive_time = ev->sta_info.inactive_time;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME);
+	}
+	if (valid & NRF70_STA_INFO_RX_BYTES) {
+		sinfo->rx_bytes = ev->sta_info.rx_bytes;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BYTES);
+	}
+	if (valid & NRF70_STA_INFO_TX_BYTES) {
+		sinfo->tx_bytes = ev->sta_info.tx_bytes;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES);
+	}
+	sinfo->chains = ev->sta_info.chain.signal_mask;
+	if (valid & NRF70_STA_INFO_CHAIN_SIGNAL) {
+		memcpy(sinfo->chain_signal, ev->sta_info.chain.signal,
+		       sizeof(sinfo->chain_signal));
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);
+	}
+	if (valid & NRF70_STA_INFO_CHAIN_SIGNAL_AVG) {
+		memcpy(sinfo->chain_signal_avg, ev->sta_info.chain.signal_avg,
+		       sizeof(sinfo->chain_signal_avg));
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG);
+	}
+	if (valid & NRF70_STA_INFO_TX_BITRATE) {
+		rate_info = &ev->sta_info.tx_bitrate;
+
+		if (rate_info->flags & NRF70_RATE_INFO_40_MHZ_WIDTH)
+			sinfo->txrate.bw = RATE_INFO_BW_40;
+		else if (rate_info->flags & NRF70_RATE_INFO_80_MHZ_WIDTH)
+			sinfo->txrate.bw = RATE_INFO_BW_80;
+		else if (rate_info->flags & NRF70_RATE_INFO_160_MHZ_WIDTH)
+			sinfo->txrate.bw = RATE_INFO_BW_160;
+		else
+			sinfo->txrate.bw = RATE_INFO_BW_20;
+
+		if (rate_info->flags & NRF70_RATE_INFO_SHORT_GI)
+			sinfo->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+
+		if (rate_info->valid_fields & NRF70_RATE_INFO_BITRATE)
+			sinfo->txrate.legacy = rate_info->bitrate;
+
+		if (rate_info->valid_fields & NRF70_RATE_INFO_MCS) {
+			sinfo->txrate.mcs = rate_info->mcs;
+			sinfo->txrate.flags |= RATE_INFO_FLAGS_MCS;
+		}
+
+		if (rate_info->valid_fields & NRF70_RATE_INFO_VHT_MCS) {
+			sinfo->txrate.mcs = rate_info->vht_mcs;
+			sinfo->txrate.flags |= RATE_INFO_FLAGS_VHT_MCS;
+		}
+
+		if (rate_info->valid_fields & NRF70_RATE_INFO_VHT_NSS)
+			sinfo->txrate.nss = rate_info->vht_nss;
+
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+	}
+	if (valid & NRF70_STA_INFO_RX_BITRATE) {
+		rate_info = &ev->sta_info.rx_bitrate;
+
+		if (rate_info->flags & NRF70_RATE_INFO_40_MHZ_WIDTH)
+			sinfo->rxrate.bw = RATE_INFO_BW_40;
+		else if (rate_info->flags & NRF70_RATE_INFO_80_MHZ_WIDTH)
+			sinfo->rxrate.bw = RATE_INFO_BW_80;
+		else if (rate_info->flags & NRF70_RATE_INFO_160_MHZ_WIDTH)
+			sinfo->rxrate.bw = RATE_INFO_BW_160;
+		else
+			sinfo->rxrate.bw = RATE_INFO_BW_20;
+
+		if (rate_info->flags & NRF70_RATE_INFO_SHORT_GI)
+			sinfo->rxrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+
+		if (rate_info->valid_fields & NRF70_RATE_INFO_BITRATE)
+			sinfo->rxrate.legacy = rate_info->bitrate;
+
+		if (rate_info->valid_fields & NRF70_RATE_INFO_MCS) {
+			sinfo->rxrate.mcs = rate_info->mcs;
+			sinfo->rxrate.flags |= RATE_INFO_FLAGS_MCS;
+		}
+
+		if (rate_info->valid_fields & NRF70_RATE_INFO_VHT_MCS) {
+			sinfo->rxrate.mcs = rate_info->vht_mcs;
+			sinfo->rxrate.flags |= RATE_INFO_FLAGS_VHT_MCS;
+		}
+
+		if (rate_info->valid_fields & NRF70_RATE_INFO_VHT_NSS)
+			sinfo->rxrate.nss = rate_info->vht_nss;
+
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
+	}
+	if (valid & NRF70_STA_INFO_STA_FLAGS) {
+		sinfo->sta_flags.mask = ev->sta_info.sta_flags.mask;
+		sinfo->sta_flags.set = ev->sta_info.sta_flags.set;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_STA_FLAGS);
+	}
+	if (valid & NRF70_STA_INFO_SIGNAL) {
+		sinfo->signal = ev->sta_info.signal;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+	}
+	if (valid & NRF70_STA_INFO_SIGNAL_AVG) {
+		sinfo->signal_avg = ev->sta_info.signal_avg;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
+	}
+	if (valid & NRF70_STA_INFO_RX_PACKETS) {
+		sinfo->rx_packets = ev->sta_info.rx_packets;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_PACKETS);
+	}
+	if (valid & NRF70_STA_INFO_TX_PACKETS) {
+		sinfo->tx_packets = ev->sta_info.tx.packets;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
+	}
+	if (valid & NRF70_STA_INFO_TX_RETRIES) {
+		sinfo->tx_retries = ev->sta_info.tx.retries;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
+	}
+	if (valid & NRF70_STA_INFO_TX_FAILED) {
+		sinfo->tx_failed = ev->sta_info.tx.failed;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
+	}
+	if (valid & NRF70_STA_INFO_EXPECTED_THROUGHPUT) {
+		sinfo->expected_throughput = ev->sta_info.expected_throughput;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_EXPECTED_THROUGHPUT);
+	}
+	if (valid & NRF70_STA_INFO_BEACON_LOSS_COUNT) {
+		sinfo->beacon_loss_count = ev->sta_info.beacon_loss_count;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_LOSS);
+	}
+	if (valid & NRF70_STA_INFO_T_OFFSET) {
+		sinfo->t_offset = ev->sta_info.t_offset;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_T_OFFSET);
+	}
+	if (valid & NRF70_STA_INFO_RX_DROPPED_MISC) {
+		sinfo->rx_dropped_misc = ev->sta_info.rx_dropped_misc;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC);
+	}
+	if (valid & NRF70_STA_INFO_RX_BEACON) {
+		sinfo->rx_beacon = ev->sta_info.rx_beacon;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_RX);
+	}
+	if (valid & NRF70_STA_INFO_RX_BEACON_SIGNAL_AVG) {
+		sinfo->rx_beacon_signal_avg = ev->sta_info.rx_beacon_signal_avg;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG);
+	}
+	if (valid & NRF70_STA_INFO_BSS_PARAMS) {
+		sinfo->bss_param.flags = ev->sta_info.bss_param.flags;
+		sinfo->bss_param.dtim_period =
+			ev->sta_info.bss_param.dtim_period;
+		sinfo->bss_param.beacon_interval =
+			ev->sta_info.bss_param.beacon_interval;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_BSS_PARAM);
+	}
+
+	complete(&priv->station_info_available);
+}
+
+static int nrf70_handle_get_channel(struct spi_mem *mem,
+				    struct nrf70_event_get_chan *ev)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct nrf70_vif *vif = nrf70_get_vif(priv, ev->header.idx.wdev_id);
+
+	if (IS_ERR(vif))
+		return PTR_ERR(vif);
+
+	memset(&vif->chandef, 0, sizeof(vif->chandef));
+	vif->chandef.chan = ieee80211_get_channel(priv->wiphy,
+						  ev->chan.center_freq);
+	vif->chandef.width = ev->width;
+	vif->chandef.center_freq1 = ev->center_freq1;
+	vif->chandef.center_freq2 = ev->center_freq2;
+
+	complete(&vif->chan_updated);
+
+	return 0;
+}
+
+static int nrf70_change_bss(struct wiphy *wiphy, struct net_device *ndev,
+			    struct bss_parameters *params)
+{
+	struct nrf70_wiphy_priv *wpriv = wiphy_priv(wiphy);
+	struct nrf70_priv *priv = wpriv->priv;
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_set_bss *cmd;
+	int ret;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_SET_BSS,
+			       sizeof(*cmd), NRF70_NDEV_TO_IFACE(ndev));
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_set_bss *)msg->data;
+	cmd->info.ht_opmode = params->ht_opmode;
+	cmd->info.cts = params->use_cts_prot;
+	cmd->info.preamble = params->use_short_preamble;
+	cmd->info.slot = params->use_short_slot_time;
+	cmd->info.ap_isolate = params->ap_isolate;
+	cmd->info.num_basic_rates = params->basic_rates_len;
+	memcpy(cmd->info.basic_rates, params->basic_rates,
+	       cmd->info.num_basic_rates);
+
+	if (in_range(params->p2p_ctwindow, 1, 126)) {
+		cmd->info.p2p_go_ctwindow = params->p2p_ctwindow;
+		cmd->info.p2p_opp_ps = params->p2p_opp_ps;
+		cmd->valid_fields = NRF70_SET_BSS_P2P_CTWINDOW |
+				    NRF70_SET_BSS_P2P_OPPPS;
+	}
+
+	cmd->valid_fields |= NRF70_SET_BSS_CTS | NRF70_SET_BSS_PREAMBLE |
+			     NRF70_SET_BSS_SLOT | NRF70_SET_BSS_HT_OPMODE |
+			     NRF70_SET_BSS_AP_ISOLATE;
+
+	ret = nrf70_enqueue_message(priv->mem, msg);
+	kfree(msg);
+
+	return ret;
+}
+
+static void nrf70_handle_event_get_reg(struct spi_mem *mem,
+				       struct nrf70_event_get_reg *ev)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+
+	memcpy(priv->regdom, ev->alpha2, sizeof(ev->alpha2));
+	complete(&priv->regdom_updated);
+}
+
+static void nrf70_handle_event_reg_change(struct spi_mem *mem,
+					  struct nrf70_event_reg_change *ev)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+
+	memcpy(priv->regdom, ev->alpha2, sizeof(ev->alpha2));
+	complete(&priv->regdom_updated);
+}
+
+static void nrf70_handle_rx_unprot_mlme_mgmt(struct spi_mem *mem,
+					     struct nrf70_event_mlme *ev)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct nrf70_vif *vif = nrf70_get_vif(priv, ev->header.idx.wdev_id);
+
+	if (IS_ERR(vif))
+		return;
+
+	cfg80211_rx_unprot_mlme_mgmt(vif->ndev, ev->frame.data, ev->frame.len);
+}
+
+static void nrf70_handle_iface_update(struct spi_mem *mem,
+				      struct nrf70_event_iface_update *ev)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct nrf70_vif *vif = nrf70_get_vif(priv, ev->header.idx.wdev_id);
+
+	if (IS_ERR(vif))
+		return;
+
+	if (!ev->status)
+		complete(&vif->iface_updated);
+}
+
+static int nrf70_dequeue_umac_event(struct spi_mem *mem, void *data)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct device *dev = &mem->spi->dev;
+	struct nrf70_umac_header *header = data;
+	struct nrf70_vif *vif = nrf70_get_vif(priv, header->idx.wdev_id);
+	struct cfg80211_scan_info scan_info = { .aborted = true };
+
+	if (IS_ERR(vif))
+		return PTR_ERR(vif);
+
+	switch (header->id) {
+	case NRF70_UMAC_EVENT_TRIGGER_SCAN_START:
+		break;
+	case NRF70_UMAC_EVENT_SCAN_ABORTED:
+		if (vif->scan_req) {
+			cfg80211_scan_done(vif->scan_req, &scan_info);
+			vif->scan_req = NULL;
+		}
+
+		WRITE_ONCE(priv->scan_in_progress, false);
+		break;
+	case NRF70_UMAC_EVENT_SCAN_DONE:
+		if (!((struct nrf70_event_scan_done *)data)->status) {
+			nrf70_get_scan_results_command(mem, vif->iface);
+		} else if (vif->scan_req) {
+			cfg80211_scan_done(vif->scan_req, &scan_info);
+			vif->scan_req = NULL;
+		}
+
+		WRITE_ONCE(priv->scan_in_progress, false);
+		break;
+	case NRF70_UMAC_EVENT_AUTHENTICATE:
+		nrf70_handle_auth(mem, data);
+		break;
+	case NRF70_UMAC_EVENT_ASSOCIATE:
+		nrf70_handle_assoc(mem, data);
+		break;
+	case NRF70_UMAC_EVENT_CONNECT:
+		/* Nothing to be done. */
+		break;
+	case NRF70_UMAC_EVENT_DEAUTHENTICATE:
+		fallthrough;
+	case NRF70_UMAC_EVENT_DISASSOCIATE:
+		nrf70_handle_tx_mlme_mgmt(mem, data);
+		break;
+	case NRF70_UMAC_EVENT_DISCONNECT:
+		/* Nothing to be done. */
+		break;
+	case NRF70_UMAC_EVENT_FRAME:
+		nrf70_handle_rx_mgmt(mem, data);
+		break;
+	case NRF70_UMAC_EVENT_COOKIE_RESP:
+		nrf70_handle_cookie_resp(mem, data);
+		break;
+	case NRF70_UMAC_EVENT_FRAME_TX_STATUS:
+		nrf70_handle_frame_tx_status(mem, data);
+		break;
+	case NRF70_UMAC_EVENT_NEW_STATION:
+		nrf70_handle_station(mem, data, true);
+		break;
+	case NRF70_UMAC_EVENT_DEL_STATION:
+		nrf70_handle_station(mem, data, false);
+		break;
+	case NRF70_UMAC_EVENT_GET_STATION:
+		nrf70_handle_get_station(mem, data);
+		break;
+	case NRF70_UMAC_EVENT_GET_CHANNEL:
+		nrf70_handle_get_channel(mem, data);
+		break;
+	case NRF70_UMAC_EVENT_IFFLAGS_STATUS:
+		fallthrough;
+	case NRF70_UMAC_EVENT_SET_INTERFACE:
+		nrf70_handle_iface_update(mem, data);
+		break;
+	case NRF70_UMAC_EVENT_UNPROT_DEAUTHENTICATE:
+		fallthrough;
+	case NRF70_UMAC_EVENT_UNPROT_DISASSOCIATE:
+		nrf70_handle_rx_unprot_mlme_mgmt(mem, data);
+		break;
+	case NRF70_UMAC_EVENT_NEW_INTERFACE:
+		break;
+	case NRF70_UMAC_EVENT_GET_REG:
+		nrf70_handle_event_get_reg(mem, data);
+		break;
+	case  NRF70_UMAC_EVENT_BEACON_HINT:
+		break;
+	case  NRF70_UMAC_EVENT_REG_CHANGE:
+		nrf70_handle_event_reg_change(mem, data);
+		break;
+	case NRF70_UMAC_EVENT_SCAN_DISPLAY_RESULT:
+		nrf70_handle_scan_display_results(mem, data);
+		break;
+	case NRF70_UMAC_EVENT_CMD_STATUS:
+		nrf70_handle_cmd_status(mem, data);
+		break;
+	default:
+		dev_dbg(dev, "Unsupported umac event type: %d\n",
+			header->id);
+		return 1;
+	}
+
+	return 0;
+}
+
+static void nrf70_event_worker(struct work_struct *work)
+{
+	struct nrf70_priv *priv = container_of(work, struct nrf70_priv,
+				  event_work);
+	struct spi_mem *mem = priv->mem;
+	struct device *dev = &mem->spi->dev;
+	u32 addr, eq = priv->queue[NRF70_EVENT_AVL_QUEUE].eq;
+	struct nrf70_msg *msg;
+	int len, ret, i;
+
+	msg = kzalloc(NRF70_EVENT_POOL_MAX_SZ, GFP_KERNEL);
+	if (unlikely(!msg)) {
+		dev_err(dev, "Unable to allocate message buffer\n");
+		return;
+	}
+
+	while (!nrf70_dequeue(mem, NRF70_EVENT_BUSY_QUEUE, &addr)) {
+		len = nrf70_readl(mem, addr);
+
+		if (len < sizeof(*msg)) {
+			dev_dbg(dev, "Event length %d too small\n", len);
+			continue;
+		}
+		nrf70_readv(mem, addr, msg, min(len, NRF70_EVENT_POOL_MAX_SZ));
+
+		/* Put on empty queue. */
+		if (msg->resubmit)
+			nrf70_writel(mem, eq, addr);
+
+		if (len > NRF70_EVENT_POOL_MAX_SZ) {
+			dev_dbg(dev, "Fragmented event! Size %d > %d\n",
+				len, NRF70_EVENT_POOL_MAX_SZ);
+			continue;
+		}
+
+		switch (msg->type) {
+		case NRF70_MSG_SYSTEM:
+			ret = nrf70_dequeue_sys_event(mem, msg->data);
+			break;
+		case NRF70_MSG_DATA:
+			ret = nrf70_dequeue_data_event(mem, msg->data);
+			break;
+		case NRF70_MSG_UMAC:
+			ret = nrf70_dequeue_umac_event(mem, msg->data);
+			break;
+		default:
+			dev_dbg(dev, "Unknown message type\n");
+			ret = 1;
+			break;
+		}
+
+		if (ret && ret != -EINVAL) {
+			for (i = 0; i < len; i += 4) {
+				dev_dbg(dev, "[%d] = %08x\n",
+					i, *((u32 *)msg + i / 4));
+			}
+		}
+	}
+
+	kfree(msg);
+}
+
+static int nrf70_mac_init(struct spi_mem *mem)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct device *dev = &mem->spi->dev;
+	int val, i, idx, ret;
+	size_t sz;
+	u32 *tmpbuf;
+
+	val = nrf70_readl(mem, NRF70_MCU_UMAC_VERSION);
+	dev_info(dev, "UMAC version: %d.%d.%d.%d\n",
+		 NRF70_MCU_UMAC_VERSION_VER(val),
+		 NRF70_MCU_UMAC_VERSION_MAJOR(val),
+		 NRF70_MCU_UMAC_VERSION_MINOR(val),
+		 NRF70_MCU_UMAC_VERSION_EXTRA(val));
+	dev_info(dev, "Raw mode support: %s\n",
+		 priv->has_raw_mode ? "yes" : "no");
+
+	sz = sizeof(priv->queue);
+	tmpbuf = kzalloc(sz, GFP_KERNEL);
+	if (!tmpbuf)
+		return -ENOMEM;
+
+	nrf70_readv(mem, NRF70_MCU_UMAC_HPQ, tmpbuf, sz);
+	for (i = 0; i < NRF70_QUEUE_MAX; i++) {
+		idx = i * 2;
+		priv->queue[i].eq = tmpbuf[idx];
+		priv->queue[i].dq = tmpbuf[idx + 1];
+	}
+	kfree(tmpbuf);
+
+	priv->num_cmds = NRF70_RPU_CMD_START_MAGIC;
+
+	priv->rx_cmd_base = nrf70_readl(mem, NRF70_RX_CMD_BASE);
+	priv->tx_cmd_base = NRF70_TX_CMD_BASE;
+
+	val = nrf70_readl(mem, NRF70_SBUS_UCCP_CORE_INT_ENAB);
+	val |= NRF70_UCCP_MTX2_INT_IRQ_ENAB;
+	nrf70_writel(mem, NRF70_SBUS_UCCP_CORE_INT_ENAB, val);
+	nrf70_writel(mem, NRF70_SBUS_UCCP_CORE_MTX2_INT_ENABLE,
+		     NRF70_UCCP_MTX2_INT_EN);
+
+	tmpbuf = kzalloc(sizeof(priv->hwaddr), GFP_KERNEL);
+	if (!tmpbuf)
+		return -ENOMEM;
+
+	nrf70_readv(mem, NRF70_OTP_HWADDR, tmpbuf, sizeof(priv->hwaddr));
+	memcpy(priv->hwaddr, tmpbuf, sizeof(priv->hwaddr));
+	kfree(tmpbuf);
+	val = nrf70_readl(mem, NRF70_OTP_INFO_FLAGS);
+	for (i = 0; i < NRF70_VIFS_MAX; i++) {
+		if (!(val & NRF70_OTP_INFO_FLAGS_HWADDR(i)) &&
+		    !is_zero_ether_addr(priv->hwaddr[i]))
+			continue;
+
+		dev_warn(dev, "OTP hwaddr %d invalid, using a random address\n",
+			 i);
+		eth_random_addr(priv->hwaddr[i]);
+	}
+
+	ret = nrf70_init_rx_command(mem);
+	if (ret)
+		goto out;
+
+	ret = nrf70_init_command(mem);
+
+out:
+	return ret;
+}
+
+static irqreturn_t nrf70_irq(int irq, void *data)
+{
+	struct spi_mem *mem = data;
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	int val;
+
+	/* Rearm watchdog. */
+	val = nrf70_readl(mem, NRF70_SBUS_MIPS_MCU_UCCP_INT_STATUS);
+	if (val & NRF70_SBUS_MIPS_MCU_WATCHDOG_INT) {
+		nrf70_writel(mem, NRF70_SBUS_MIPS_MCU_TIMER,
+			     NRF70_SBUS_MIPS_MCU_TIMER_RESET);
+		nrf70_writel(mem, NRF70_SBUS_MIPS_MCU_UCCP_INT_CLEAR,
+			     NRF70_SBUS_MIPS_MCU_WATCHDOG_INT);
+	}
+
+	/* Check for pending events regardless of the IRQ source. */
+	schedule_work(&priv->event_work);
+
+	nrf70_writel(mem, NRF70_SBUS_UCCP_CORE_HOST2_TO_MTX2_ACK,
+		     NRF70_UCCP_MTX2_INT_EN);
+
+	return IRQ_HANDLED;
+}
+
+static int nrf70_set_monitor_channel(struct wiphy *wiphy,
+				     struct net_device *ndev,
+				     struct cfg80211_chan_def *def)
+{
+	struct nrf70_ndev_priv *npriv = netdev_priv(ndev);
+	struct nrf70_priv *priv = npriv->priv;
+	struct nrf70_vif *vif = npriv->vif;
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_set_channel *cmd;
+	u32 freq = def->chan->center_freq;
+	int ret;
+
+	msg = nrf70_create_msg(NRF70_MSG_SYSTEM, NRF70_CMD_CHANNEL,
+			       sizeof(*cmd), -1);
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_set_channel *)msg->data;
+	cmd->if_idx = NRF70_NDEV_TO_IFACE(ndev);
+	cmd->chan.primary_num = ieee80211_frequency_to_channel(freq);
+
+	reinit_completion(&vif->chan_updated);
+	ret = nrf70_enqueue_message(priv->mem, msg);
+	kfree(msg);
+
+	if (ret)
+		return ret;
+
+	vif->chandef = *def;
+
+	return wait_for_completion_timeout(&vif->chan_updated,
+					   msecs_to_jiffies(1000)) ?
+					   0 : -ETIMEDOUT;
+}
+
+static int nrf70_open(struct net_device *dev)
+{
+	struct nrf70_ndev_priv *npriv = netdev_priv(dev);
+	struct nrf70_priv *priv = npriv->priv;
+	struct nrf70_vif *vif = npriv->vif;
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_chg_vif_state *cmd;
+	int ret, iface = vif->iface;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_SET_IFFLAGS,
+			       sizeof(*cmd), iface);
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_chg_vif_state *)msg->data;
+	cmd->info.state = 1;
+	cmd->info.if_idx = iface;
+
+	reinit_completion(&vif->iface_updated);
+
+	ret = nrf70_enqueue_message(priv->mem, msg);
+	kfree(msg);
+
+	if (ret)
+		return ret;
+
+	ret = wait_for_completion_timeout(&vif->iface_updated,
+					  msecs_to_jiffies(1000)) ?
+					  0 : -ETIMEDOUT;
+	if (ret || vif->wdev.iftype != NL80211_IFTYPE_MONITOR)
+		return ret;
+
+	return nrf70_set_monitor_channel(priv->wiphy, dev, &vif->chandef);
+}
+
+static int nrf70_close(struct net_device *dev)
+{
+	struct nrf70_ndev_priv *npriv = netdev_priv(dev);
+	struct nrf70_priv *priv = npriv->priv;
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_chg_vif_state *cmd;
+	int ret, iface = npriv->vif->iface;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_SET_IFFLAGS,
+			       sizeof(*cmd), iface);
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_chg_vif_state *)msg->data;
+	cmd->info.state = 0;
+	cmd->info.if_idx = iface;
+
+	reinit_completion(&npriv->vif->iface_updated);
+
+	ret = nrf70_enqueue_message(priv->mem, msg);
+	kfree(msg);
+
+	if (ret)
+		return ret;
+
+	if (!wait_for_completion_timeout(&npriv->vif->iface_updated,
+					 msecs_to_jiffies(1000)))
+		return -ETIMEDOUT;
+
+	nrf70_carrier_change(priv, iface, false);
+
+	return 0;
+}
+
+static netdev_tx_t nrf70_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct nrf70_ndev_priv *npriv = netdev_priv(ndev);
+	struct nrf70_priv *priv = npriv->priv;
+	struct cfg80211_qos_map *qos_map = READ_ONCE(npriv->vif->qos_map);
+	struct nrf70_vif *vif = npriv->vif;
+	struct sk_buff_head *queue;
+	int i;
+
+	if (skb->priority == 0 || skb->priority > 7)
+		skb->priority = cfg80211_classify8021d(skb, qos_map);
+
+	guard(spinlock_irqsave)(&vif->sta_lock);
+	i = nrf70_get_sta_idx(vif, eth_hdr(skb)->h_dest);
+	queue = i < 0 || vif->sta[i].can_xmit ? &vif->tx_queue :
+						&vif->sta[i].pending;
+
+	skb_queue_tail(queue, skb);
+
+	if (skb_queue_len(queue) >= NRF70_TX_PENDING_MAX) {
+		if (queue == &vif->tx_queue) {
+			netif_stop_queue(ndev);
+		} else {
+			/* Toss the oldest pending skb. */
+			consume_skb(skb_dequeue(queue));
+			u64_stats_update_begin(&vif->stats.syncp);
+			vif->stats.tx_dropped++;
+			u64_stats_update_end(&vif->stats.syncp);
+		}
+	}
+
+	if (queue == &vif->tx_queue)
+		wiphy_work_queue(priv->wiphy, &vif->xmit_work);
+
+	return NETDEV_TX_OK;
+}
+
+static int nrf70_set_hwaddr(struct net_device *ndev, void *addr)
+{
+	struct nrf70_ndev_priv *npriv = netdev_priv(ndev);
+	struct nrf70_priv *priv = npriv->priv;
+	struct sockaddr *sa = addr;
+	int ret, iface = NRF70_NDEV_TO_IFACE(ndev);
+
+	ret = eth_prepare_mac_addr_change(ndev, addr);
+	if (ret)
+		return ret;
+
+	ret = nrf70_hwaddr_change_command(priv->mem, sa->sa_data, iface);
+	if (ret)
+		return ret;
+
+	eth_hw_addr_set(ndev, sa->sa_data);
+
+	return 0;
+}
+
+static void nrf70_get_stats64(struct net_device *ndev,
+			      struct rtnl_link_stats64 *stats)
+{
+	struct nrf70_ndev_priv *npriv = netdev_priv(ndev);
+	struct nrf70_vif *vif = npriv->vif;
+	unsigned int start;
+
+	/*
+	 * nRF70 hardware keeps track of MAC statistics, however they are not
+	 * grouped based on individual VIFs, rendering them useless for
+	 * get_stats64. Instead, return statistics collected by the driver.
+	 */
+	do {
+		start = u64_stats_fetch_begin(&vif->stats.syncp);
+		stats->tx_packets = vif->stats.tx_packets;
+		stats->tx_bytes = vif->stats.tx_bytes;
+		stats->rx_packets = vif->stats.rx_packets;
+		stats->rx_bytes = vif->stats.rx_bytes;
+		stats->tx_dropped = vif->stats.tx_dropped;
+	} while (u64_stats_fetch_retry(&vif->stats.syncp, start));
+}
+
+static const struct net_device_ops nrf70_netdev_ops = {
+	.ndo_open = nrf70_open,
+	.ndo_stop = nrf70_close,
+	.ndo_start_xmit = nrf70_xmit,
+	.ndo_set_mac_address = nrf70_set_hwaddr,
+	.ndo_get_stats64 = nrf70_get_stats64,
+};
+
+static int nrf70_set_fmac_mode(struct spi_mem *mem, struct nrf70_vif *vif,
+			       enum nl80211_iftype type)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_raw_config_mode *cmd;
+	struct ieee80211_channel *ch;
+	int mode, ret;
+
+	/* CMD_RAW_CONFIG_MODE is not required if raw mode is not present. */
+	if (!priv->has_raw_mode)
+		return 0;
+
+	switch (type) {
+	case NL80211_IFTYPE_STATION:
+		mode = NRF70_OP_MODE_STA;
+		break;
+	case NL80211_IFTYPE_AP:
+		mode = NRF70_OP_MODE_AP;
+		break;
+	case NL80211_IFTYPE_MONITOR:
+		mode = NRF70_OP_MODE_MONITOR;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	msg = nrf70_create_msg(NRF70_MSG_SYSTEM, NRF70_CMD_RAW_CONFIG_MODE,
+			       sizeof(*cmd), -1);
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_raw_config_mode *)msg->data;
+	cmd->if_idx = vif->iface;
+	cmd->mode = mode;
+
+	reinit_completion(&vif->iface_updated);
+	ret = nrf70_enqueue_message(mem, msg);
+	kfree(msg);
+
+	if (ret)
+		return ret;
+
+	ret = wait_for_completion_timeout(&vif->iface_updated,
+					  msecs_to_jiffies(1000)) ?
+					  0 : -ETIMEDOUT;
+	if (ret || type != NL80211_IFTYPE_MONITOR)
+		return ret;
+
+	ch = priv->wiphy->bands[NL80211_BAND_2GHZ]->channels;
+	cfg80211_chandef_create(&vif->chandef, ch, NL80211_CHAN_NO_HT);
+
+	return nrf70_set_monitor_channel(priv->wiphy, vif->ndev,
+					 &vif->chandef);
+}
+
+static int nrf70_add_vif_command(struct spi_mem *mem, struct nrf70_vif *vif)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_add_vif *cmd;
+	int ret;
+
+	if (!vif->iface)
+		return -EOPNOTSUPP;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_NEW_INTERFACE,
+			       sizeof(*cmd), vif->iface);
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_add_vif *)msg->data;
+	cmd->valid_fields = NRF70_ADD_VIF_HWADDR | NRF70_ADD_VIF_IFTYPE |
+			    NRF70_ADD_VIF_IFNAME;
+	cmd->info.iftype = vif->wdev.iftype;
+	strscpy(cmd->info.ifacename, vif->ndev->name, IFNAMSIZ);
+	ether_addr_copy(cmd->info.hwaddr, priv->hwaddr[vif->iface]);
+
+	ret = nrf70_enqueue_message(mem, msg);
+	kfree(msg);
+
+	return ret;
+}
+
+static struct nrf70_vif *nrf70_add_if(struct nrf70_priv *priv, const char *name,
+				      unsigned char name_assign_type,
+				      enum nl80211_iftype iftype,
+				      struct vif_params *params, bool locked)
+{
+	struct device *dev = &priv->mem->spi->dev;
+	struct net_device *ndev;
+	struct nrf70_ndev_priv *npriv;
+	struct nrf70_vif *vif;
+	bool is_monitor = false;
+	struct ieee80211_channel *ch;
+	u8 *hwaddr;
+	int ret;
+
+	switch (iftype) {
+	case NL80211_IFTYPE_STATION:
+		fallthrough;
+	case NL80211_IFTYPE_AP:
+		break;
+	case NL80211_IFTYPE_MONITOR:
+		if (!priv->has_raw_mode)
+			return ERR_PTR(-EOPNOTSUPP);
+		is_monitor = true;
+		break;
+	default:
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	vif = kzalloc(sizeof(*vif), GFP_KERNEL);
+	if (!vif)
+		return ERR_PTR(-ENOMEM);
+
+	vif->iface = ffs(priv->vif_bitmap) - 1;
+	if (vif->iface < 0 || vif->iface >= NRF70_VIFS_MAX)
+		return ERR_PTR(-EINVAL);
+	clear_bit(vif->iface, &priv->vif_bitmap);
+
+	vif->wdev.wiphy = priv->wiphy;
+	vif->wdev.iftype = iftype;
+
+	ndev = alloc_netdev(sizeof(*npriv), name, name_assign_type,
+			    ether_setup);
+	if (!ndev) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	vif->ndev = ndev;
+	ndev->needs_free_netdev = true;
+	npriv = netdev_priv(ndev);
+	npriv->priv = priv;
+	npriv->vif = vif;
+
+	ndev->type = is_monitor ? ARPHRD_IEEE80211_RADIOTAP : ARPHRD_ETHER;
+	ndev->ieee80211_ptr = &vif->wdev;
+	SET_NETDEV_DEV(ndev, wiphy_dev(priv->wiphy));
+	vif->wdev.netdev = ndev;
+
+	hwaddr = (!params || is_zero_ether_addr(params->macaddr)) ?
+		  priv->hwaddr[vif->iface] :
+		  params->macaddr;
+	eth_hw_addr_set(ndev, hwaddr);
+
+	ndev->netdev_ops = &nrf70_netdev_ops;
+
+	ret = locked ? cfg80211_register_netdevice(ndev) :
+		       register_netdev(ndev);
+	if (ret) {
+		dev_err(dev, "Unable to register netdev: %d\n", ret);
+		goto err_ndev;
+	}
+
+	netif_carrier_off(vif->ndev);
+
+	/*
+	 * The primary interface is already created by UMAC FW, and as such
+	 * there is no need to send a create command.
+	 */
+	if (!vif->iface) {
+		ret = nrf70_hwaddr_change_command(priv->mem, ndev->dev_addr,
+						  vif->iface);
+		if (ret) {
+			dev_err(dev, "Unable to set netdev MAC address: %d\n",
+				ret);
+
+			goto err_ndev;
+		}
+	} else {
+		ret = nrf70_add_vif_command(priv->mem, vif);
+		if (ret)
+			goto err_ndev;
+	}
+
+	list_add_tail(&vif->list, &priv->vifs);
+	init_completion(&vif->iface_updated);
+	init_completion(&vif->chan_updated);
+	u64_stats_init(&vif->stats.syncp);
+
+	ch = priv->wiphy->bands[NL80211_BAND_2GHZ]->channels;
+	cfg80211_chandef_create(&vif->chandef, ch, NL80211_CHAN_NO_HT);
+
+	skb_queue_head_init(&vif->tx_queue);
+	vif->sta_bitmap = NRF70_PEERS_MASK;
+	spin_lock_init(&vif->sta_lock);
+	wiphy_work_init(&vif->xmit_work, nrf70_xmit_worker);
+
+	nrf70_open(ndev);
+	ret = nrf70_set_fmac_mode(priv->mem, vif, iftype);
+	nrf70_close(ndev);
+	if (ret) {
+		list_del(&vif->list);
+		goto err_ndev;
+	}
+
+	return vif;
+
+err_ndev:
+	if (ndev->reg_state == NETREG_REGISTERED) {
+		if (locked)
+			cfg80211_unregister_netdevice(ndev);
+		else
+			unregister_netdev(ndev);
+	}
+	free_netdev(ndev);
+err:
+	set_bit(vif->iface, &priv->vif_bitmap);
+	kfree(vif);
+
+	return ERR_PTR(ret);
+}
+
+static struct wireless_dev *nrf70_add_vif(struct wiphy *wiphy,
+					  const char *name,
+					  unsigned char name_assign_type,
+					  enum nl80211_iftype type,
+					  struct vif_params *params)
+{
+	struct nrf70_wiphy_priv *wpriv = wiphy_priv(wiphy);
+	struct nrf70_priv *priv = wpriv->priv;
+	struct nrf70_vif *vif;
+
+	vif = nrf70_add_if(priv, name, name_assign_type, type, params, true);
+
+	return IS_ERR(vif) ? ERR_CAST(vif) : &vif->wdev;
+}
+
+static int nrf70_del_vif_command(struct spi_mem *mem, struct nrf70_vif *vif)
+{
+	struct nrf70_msg *msg;
+	int ret;
+
+	if (!vif->iface)
+		return -EOPNOTSUPP;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_DEL_INTERFACE,
+			       sizeof(struct nrf70_umac_header), vif->iface);
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	ret = nrf70_enqueue_message(mem, msg);
+	kfree(msg);
+
+	return ret;
+}
+
+static int nrf70_del_if(struct nrf70_priv *priv, struct nrf70_vif *vif,
+			bool locked)
+{
+	int ret = 0;
+
+	netif_stop_queue(vif->ndev);
+	nrf70_drain_tx(priv, vif);
+
+	/*
+	 * The primary interface is always present in UMAC FW, and as such we
+	 * cannot send a delete command.
+	 */
+	if (vif->iface)
+		ret = nrf70_del_vif_command(priv->mem, vif);
+
+	nrf70_carrier_change(priv, vif->iface, false);
+	set_bit(vif->iface, &priv->vif_bitmap);
+	complete(&vif->iface_updated);
+	complete(&vif->chan_updated);
+
+	if (vif->ndev->reg_state == NETREG_REGISTERED) {
+		if (locked)
+			cfg80211_unregister_netdevice(vif->ndev);
+		else
+			unregister_netdev(vif->ndev);
+	} else {
+		free_netdev(vif->ndev);
+	}
+
+	list_del(&vif->list);
+	kfree(vif);
+
+	return ret;
+}
+
+static int nrf70_del_vif(struct wiphy *wiphy, struct wireless_dev *wdev)
+{
+	struct nrf70_wiphy_priv *wpriv = wiphy_priv(wiphy);
+	struct nrf70_priv *priv = wpriv->priv;
+
+	return nrf70_del_if(priv, container_of(wdev, struct nrf70_vif, wdev),
+			    true);
+}
+
+static int nrf70_chg_vif(struct wiphy *wiphy, struct net_device *ndev,
+			 enum nl80211_iftype type, struct vif_params *params)
+{
+	struct nrf70_ndev_priv *npriv = netdev_priv(ndev);
+	struct nrf70_priv *priv = npriv->priv;
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_chg_vif_attr *cmd;
+	int ret;
+
+	nrf70_drain_tx(priv, npriv->vif);
+
+	ret = nrf70_set_fmac_mode(priv->mem, npriv->vif, type);
+	if (ret)
+		return ret;
+
+	/* CMD_SET_INTERFACE doesn't support monitor mode, so exit early. */
+	if (type == NL80211_IFTYPE_MONITOR) {
+		ndev->type = ARPHRD_IEEE80211_RADIOTAP;
+		ndev->ieee80211_ptr->iftype = type;
+
+		return 0;
+	}
+
+	nrf70_close(ndev);
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_SET_INTERFACE,
+			       sizeof(*cmd), NRF70_NDEV_TO_IFACE(ndev));
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_chg_vif_attr *)msg->data;
+	cmd->valid_fields = NRF70_CHG_VIF_IFTYPE | NRF70_CHG_VIF_USE_4ADDR;
+	cmd->info.iftype = type;
+	cmd->info.use_4addr = params->use_4addr;
+
+	reinit_completion(&npriv->vif->iface_updated);
+
+	ret = nrf70_enqueue_message(priv->mem, msg);
+	kfree(msg);
+
+	if (ret)
+		return ret;
+
+	if (!wait_for_completion_timeout(&npriv->vif->iface_updated,
+					 msecs_to_jiffies(1000)))
+		return -ETIMEDOUT;
+
+	ndev->type = ARPHRD_ETHER;
+	ndev->ieee80211_ptr->iftype = type;
+
+	nrf70_open(ndev);
+
+	return ret;
+}
+
+static int nrf70_add_key(struct wiphy *wiphy, struct net_device *ndev,
+			 int link_id, u8 key_index, bool pairwise,
+			 const u8 *hwaddr, struct key_params *params)
+{
+	struct nrf70_wiphy_priv *wpriv = wiphy_priv(wiphy);
+	struct nrf70_priv *priv = wpriv->priv;
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_key *cmd;
+	int ret;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_NEW_KEY,
+			       sizeof(*cmd), NRF70_NDEV_TO_IFACE(ndev));
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_key *)msg->data;
+	cmd->info.key.len = params->key_len;
+	if (cmd->info.key.len) {
+		memcpy(cmd->info.key.data, params->key, cmd->info.key.len);
+		cmd->info.key_idx = key_index;
+		cmd->info.valid_fields |= NRF70_KEY_INFO_KEY |
+					  NRF70_KEY_INFO_KEY_IDX;
+	}
+
+	cmd->info.seq.len = params->seq_len;
+	if (cmd->info.seq.len) {
+		memcpy(cmd->info.seq.data, params->seq, cmd->info.seq.len);
+		cmd->info.valid_fields |= NRF70_KEY_INFO_SEQ;
+	}
+
+	cmd->info.valid_fields |= NRF70_KEY_INFO_CIPHER_SUITE |
+				  NRF70_KEY_INFO_KEY_TYPE;
+
+	cmd->info.cipher_suite = params->cipher;
+
+	cmd->info.key.type = pairwise ? NL80211_KEYTYPE_PAIRWISE :
+					NL80211_KEYTYPE_GROUP;
+
+	if (hwaddr) {
+		ether_addr_copy(cmd->hwaddr, hwaddr);
+		cmd->valid_fields |= NRF70_KEY_HWADDR;
+	}
+
+	ret = nrf70_enqueue_message(priv->mem, msg);
+	kfree(msg);
+
+	return ret;
+}
+
+static int nrf70_del_key(struct wiphy *wiphy, struct net_device *ndev,
+			 int link_id, u8 key_index, bool pairwise,
+			 const u8 *hwaddr)
+{
+	struct nrf70_wiphy_priv *wpriv = wiphy_priv(wiphy);
+	struct nrf70_priv *priv = wpriv->priv;
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_key *cmd;
+	int ret;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_DEL_KEY,
+			       sizeof(*cmd), NRF70_NDEV_TO_IFACE(ndev));
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_key *)msg->data;
+	cmd->info.key_idx = key_index;
+	cmd->info.valid_fields |= NRF70_KEY_INFO_KEY_TYPE |
+				  NRF70_KEY_INFO_KEY_IDX;
+	cmd->info.key.type = pairwise ? NL80211_KEYTYPE_PAIRWISE :
+					NL80211_KEYTYPE_GROUP;
+
+	if (hwaddr) {
+		ether_addr_copy(cmd->hwaddr, hwaddr);
+		cmd->valid_fields |= NRF70_KEY_HWADDR;
+	}
+
+	ret = nrf70_enqueue_message(priv->mem, msg);
+	kfree(msg);
+
+	return ret;
+}
+
+static int nrf70_set_default_key(struct wiphy *wiphy, struct net_device *ndev,
+				 int link_id, u8 key_index, bool unicast,
+				 bool multicast)
+{
+	struct nrf70_wiphy_priv *wpriv = wiphy_priv(wiphy);
+	struct nrf70_priv *priv = wpriv->priv;
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_set_key *cmd;
+	int ret;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_SET_KEY,
+			       sizeof(*cmd), NRF70_NDEV_TO_IFACE(ndev));
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_set_key *)msg->data;
+	cmd->info.wifi_flags = NRF70_KEY_INFO_FLAG_DEFAULT;
+	if (unicast)
+		cmd->info.wifi_flags |= NRF70_KEY_INFO_FLAG_DEFAULT_UNICAST;
+	if (multicast)
+		cmd->info.wifi_flags |= NRF70_KEY_INFO_FLAG_DEFAULT_MULTICAST;
+
+	cmd->info.key_idx = key_index;
+	cmd->info.valid_fields = NRF70_KEY_INFO_KEY_IDX;
+
+	ret = nrf70_enqueue_message(priv->mem, msg);
+	kfree(msg);
+
+	return ret;
+}
+
+static int nrf70_set_default_mgmt_key(struct wiphy *wiphy,
+				      struct net_device *ndev, int link_id,
+				      u8 key_index)
+{
+	struct nrf70_wiphy_priv *wpriv = wiphy_priv(wiphy);
+	struct nrf70_priv *priv = wpriv->priv;
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_set_key *cmd;
+	int ret;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_SET_KEY,
+			       sizeof(*cmd), NRF70_NDEV_TO_IFACE(ndev));
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_set_key *)msg->data;
+	cmd->info.wifi_flags = NRF70_KEY_INFO_FLAG_DEFAULT_MGMT;
+
+	cmd->info.key_idx = key_index;
+	cmd->info.valid_fields = NRF70_KEY_INFO_KEY_IDX;
+
+	ret = nrf70_enqueue_message(priv->mem, msg);
+	kfree(msg);
+
+	return ret;
+}
+
+static int nrf70_set_wiphy_command(struct spi_mem *mem, int iface,
+				   const struct nrf70_wiphy_info *info)
+{
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_set_wiphy *cmd;
+	int ret;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_SET_WIPHY,
+			       sizeof(*cmd), iface);
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_set_wiphy *)msg->data;
+	cmd->info = *info;
+
+	if (cmd->info.freq_params.valid_fields)
+		cmd->valid_fields |= NRF70_SET_WIPHY_FREQ;
+	if (cmd->info.rts_threshold)
+		cmd->valid_fields |= NRF70_SET_WIPHY_RTS_THRESHOLD;
+	if (cmd->info.frag_threshold)
+		cmd->valid_fields |= NRF70_SET_WIPHY_FRAG_THRESHOLD;
+	if (cmd->info.retry_short)
+		cmd->valid_fields |= NRF70_SET_WIPHY_RETRY_SHORT;
+	if (cmd->info.retry_long)
+		cmd->valid_fields |= NRF70_SET_WIPHY_RETRY_LONG;
+	if (cmd->info.coverage_class)
+		cmd->valid_fields |= NRF70_SET_WIPHY_COVERAGE_CLASS;
+
+	ret = nrf70_enqueue_message(mem, msg);
+	kfree(msg);
+
+	return ret;
+}
+
+static int nrf70_get_auth_type(enum nl80211_auth_type type)
+{
+	if (type == NL80211_AUTHTYPE_AUTOMATIC)
+		return NRF70_AUTHTYPE_AUTOMATIC;
+
+	/* nRF70 doesn't support FILS auth algs. */
+	if (type > NL80211_AUTHTYPE_SAE)
+		return -EOPNOTSUPP;
+
+	/* Otherwise nl80211_auth_type matches 1:1 with nRF70 auth types. */
+	return type;
+}
+
+static void nrf70_set_crypto_info(struct nrf70_connect_info *info,
+				  struct cfg80211_crypto_settings *crypto)
+{
+	size_t sz;
+
+	info->valid_fields |= NRF70_CONNECT_WPA_VERSIONS;
+	info->wpa_versions = crypto->wpa_versions;
+	info->cipher_suite_group = crypto->cipher_group;
+
+	info->control_port_no_encrypt = crypto->control_port_no_encrypt;
+	if (info->control_port_no_encrypt)
+		info->valid_fields |= NRF70_CONNECT_CONTROL_PORT_NO_ENCRYPT;
+
+	info->control_port_ethertype =
+		be16_to_cpu(crypto->control_port_ethertype);
+	if (info->control_port_ethertype)
+		info->valid_fields |= NRF70_CONNECT_CONTROL_PORT_ETHER_TYPE;
+
+	if (crypto->n_ciphers_pairwise) {
+		sz = sizeof(crypto->ciphers_pairwise[0]);
+		sz *= crypto->n_ciphers_pairwise;
+		memcpy(info->cipher_suites_pairwise, crypto->ciphers_pairwise,
+		       sz);
+		info->num_cipher_suites_pairwise = sz;
+		info->valid_fields |= NRF70_CONNECT_CIPHER_PAIRWISE;
+	}
+
+	if (crypto->n_akm_suites) {
+		sz = sizeof(crypto->akm_suites[0]) * crypto->n_akm_suites;
+		memcpy(info->akm_suites, crypto->akm_suites, sz);
+		info->num_akm_suites = sz;
+		info->valid_fields |= NRF70_CONNECT_AKM_SUITES;
+	}
+
+	info->control_port = crypto->control_port;
+	info->control_port_no_encrypt = crypto->control_port_no_encrypt;
+}
+
+static int nrf70_start_ap(struct wiphy *wiphy, struct net_device *ndev,
+			  struct cfg80211_ap_settings *cfg)
+{
+	struct nrf70_wiphy_priv *wpriv = wiphy_priv(wiphy);
+	struct nrf70_priv *priv = wpriv->priv;
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_start_ap *cmd;
+	struct nrf70_freq_params *freq_params;
+	struct nrf70_connect_info *con_info;
+	struct nrf70_wiphy_info wiphy_info = {};
+	int ret;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_START_AP,
+			       sizeof(*cmd), NRF70_NDEV_TO_IFACE(ndev));
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_start_ap *)msg->data;
+	cmd->valid_fields = NRF70_START_AP_BEACON_INTERVAL |
+			    NRF70_START_AP_VERSIONS |
+			    NRF70_START_AP_CIPHER_SUITE_GROUP;
+
+	cmd->info.beacon_interval = cfg->beacon_interval;
+	cmd->info.dtim_period = cfg->dtim_period;
+	cmd->info.auth_type = nrf70_get_auth_type(cfg->auth_type);
+	if (cmd->info.auth_type < 0) {
+		ret = cmd->info.auth_type;
+		goto out;
+	}
+
+	cmd->info.flags = cfg->privacy ? NRF70_START_AP_FLAG_PRIVACY :
+					 NRF70_START_AP_FLAG_NO_ENCRYPT;
+
+	freq_params = &cmd->info.freq_params;
+	freq_params->frequency = cfg->chandef.chan->center_freq;
+	freq_params->channel_width = cfg->chandef.width;
+	freq_params->center_freq1 = cfg->chandef.center_freq1;
+	freq_params->center_freq2 = cfg->chandef.center_freq2;
+
+	freq_params->valid_fields = NRF70_FREQ_PARAMS_FREQ |
+				    NRF70_FREQ_PARAMS_CHAN_WIDTH |
+				    NRF70_FREQ_PARAMS_CENTER_FREQ1 |
+				    NRF70_FREQ_PARAMS_CENTER_FREQ2 |
+				    NRF70_FREQ_PARAMS_CHAN_TYPE;
+
+	freq_params->channel_type = cfg80211_get_chandef_type(&cfg->chandef);
+
+	if (cfg->ssid_len) {
+		memcpy(cmd->info.ssid.ssid, cfg->ssid, cfg->ssid_len);
+		cmd->info.ssid.len = cfg->ssid_len;
+	}
+	cmd->info.hidden_ssid = cfg->hidden_ssid;
+	cmd->info.inactivity_timeout = cfg->inactivity_timeout;
+
+	con_info = &cmd->info.connect_info;
+	nrf70_set_crypto_info(con_info, &cfg->crypto);
+
+	cmd->info.beacon_data.head_len = cfg->beacon.head_len;
+	if (cfg->beacon.head_len)
+		memcpy(cmd->info.beacon_data.head, cfg->beacon.head,
+		       cfg->beacon.head_len);
+
+	cmd->info.beacon_data.tail_len = cfg->beacon.tail_len;
+	if (cfg->beacon.tail_len)
+		memcpy(cmd->info.beacon_data.tail, cfg->beacon.tail,
+		       cfg->beacon.tail_len);
+
+	cmd->info.beacon_data.probe_resp_len = cfg->beacon.probe_resp_len;
+	if (cfg->beacon.probe_resp_len)
+		memcpy(cmd->info.beacon_data.probe_resp, cfg->beacon.probe_resp,
+		       cfg->beacon.probe_resp_len);
+
+	if (cfg->p2p_ctwindow > 0 && cfg->p2p_ctwindow < 127) {
+		cmd->info.p2p_go_ctwindow = cfg->p2p_ctwindow;
+		cmd->info.p2p_opp_ps = cfg->p2p_opp_ps;
+		cmd->valid_fields |= NRF70_START_AP_FLAG_P2P_CTWINDOW |
+				     NRF70_START_AP_FLAG_P2P_OPPPS;
+	}
+
+	wiphy_info.freq_params = *freq_params;
+	ret = nrf70_set_wiphy_command(priv->mem, NRF70_NDEV_TO_IFACE(ndev),
+				      &wiphy_info);
+	if (ret)
+		goto out;
+
+	ret = nrf70_enqueue_message(priv->mem, msg);
+
+out:
+	kfree(msg);
+
+	return ret;
+}
+
+static int nrf70_change_beacon(struct wiphy *wiphy, struct net_device *ndev,
+			       struct cfg80211_ap_update *info)
+{
+	struct nrf70_ndev_priv *npriv = netdev_priv(ndev);
+	struct nrf70_priv *priv = npriv->priv;
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_set_beacon *cmd;
+	int ret;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_SET_BEACON,
+			       sizeof(*cmd), NRF70_NDEV_TO_IFACE(ndev));
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_set_beacon *)msg->data;
+	cmd->beacon_data.head_len = info->beacon.head_len;
+	memcpy(cmd->beacon_data.head, info->beacon.head, info->beacon.head_len);
+
+	cmd->beacon_data.tail_len = info->beacon.tail_len;
+	memcpy(cmd->beacon_data.tail, info->beacon.tail, info->beacon.tail_len);
+
+	cmd->beacon_data.probe_resp_len = info->beacon.probe_resp_len;
+	memcpy(cmd->beacon_data.probe_resp, info->beacon.probe_resp,
+	       info->beacon.probe_resp_len);
+
+	ret = nrf70_enqueue_message(priv->mem, msg);
+	kfree(msg);
+
+	return ret;
+}
+
+static int nrf70_stop_ap(struct wiphy *wiphy, struct net_device *ndev,
+			 unsigned int link_id)
+{
+	struct nrf70_ndev_priv *npriv = netdev_priv(ndev);
+	struct nrf70_priv *priv = npriv->priv;
+	struct nrf70_msg *msg;
+	int ret;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_STOP_AP,
+			       sizeof(struct nrf70_umac_header),
+			       NRF70_NDEV_TO_IFACE(ndev));
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	ret = nrf70_enqueue_message(priv->mem, msg);
+	kfree(msg);
+
+	return ret;
+}
+
+static int nrf70_scan(struct wiphy *wiphy, struct cfg80211_scan_request *req)
+{
+	struct wireless_dev *wdev = req->wdev;
+	struct nrf70_wiphy_priv *wpriv = wiphy_priv(wiphy);
+	struct nrf70_priv *priv = wpriv->priv;
+	struct nrf70_vif *vif = container_of(wdev, struct nrf70_vif, wdev);
+	struct device *dev = &priv->mem->spi->dev;
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_scan *cmd;
+	int duration_ms;
+	int ret, len, i;
+
+	if (wdev->iftype == NL80211_IFTYPE_AP)
+		return -EOPNOTSUPP;
+
+	if (req->n_channels > 64)
+		return -EINVAL;
+
+	if (READ_ONCE(priv->scan_in_progress))
+		return -EBUSY;
+
+	vif->scan_req = req;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_TRIGGER_SCAN,
+			       sizeof(*cmd) + sizeof(int) * req->n_channels,
+			       vif->iface);
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_scan *)msg->data;
+	cmd->scan_info.reason = NRF70_SCAN_REASON_DISPLAY;
+	cmd->scan_info.num_scan_channels = req->n_channels;
+	cmd->scan_info.bands = NRF70_SCAN_BAND_ANY;
+
+	for (i = 0; i < req->n_channels; i++) {
+		cmd->scan_info.center_freq[i] = req->channels[i]->center_freq;
+
+		switch (req->channels[i]->band) {
+		case NL80211_BAND_2GHZ:
+			cmd->scan_info.bands |= NRF70_SCAN_BAND_2GHZ;
+			break;
+		case NL80211_BAND_5GHZ:
+			cmd->scan_info.bands |= NRF70_SCAN_BAND_5GHZ;
+			break;
+		default:
+			dev_warn(dev, "Unsupported chan %d band: %d\n",
+				 i, req->channels[i]->band);
+			break;
+		}
+	}
+	cmd->scan_info.no_cck = req->no_cck;
+
+	if (req->ie && req->ie_len) {
+		memcpy(cmd->scan_info.ie.ie, req->ie, req->ie_len);
+		cmd->scan_info.ie.len = req->ie_len;
+	}
+
+	ether_addr_copy(cmd->scan_info.hwaddr, req->bssid);
+
+	/*
+	 * If duration_ms is 0, UMAC will program dwell to 50ms for active scan,
+	 * and to 150ms for passive scan.
+	 */
+	duration_ms = ieee80211_tu_to_usec(req->duration) / USEC_PER_MSEC;
+	cmd->scan_info.passive_scan = !req->n_ssids;
+	if (cmd->scan_info.passive_scan)
+		cmd->scan_info.dwell_time_passive = duration_ms;
+	else
+		cmd->scan_info.dwell_time_active = duration_ms;
+
+	for (i = 0; i < req->n_ssids; i++) {
+		if (!req->ssids[i].ssid_len)
+			continue;
+
+		len = req->ssids[i].ssid_len;
+		if (len > 32) {
+			dev_err(dev, "SSID %d length %d too long\n", i, len);
+			ret = -ERANGE;
+			goto out;
+		}
+
+		if (cmd->scan_info.num_scan_ssids >= 2) {
+			dev_err(dev, "Maximum number of SSIDs reached\n");
+			ret = -ERANGE;
+			goto out;
+		}
+
+		memcpy(cmd->scan_info.scan_ssids[i].ssid, req->ssids[i].ssid,
+		       len);
+		cmd->scan_info.scan_ssids[i].len = len;
+		cmd->scan_info.num_scan_ssids++;
+	}
+
+	ret = nrf70_enqueue_message(priv->mem, msg);
+	WRITE_ONCE(priv->scan_in_progress, !ret);
+
+out:
+	kfree(msg);
+
+	return ret;
+}
+
+static void nrf70_abort_scan(struct wiphy *wiphy, struct wireless_dev *wdev)
+{
+	struct nrf70_wiphy_priv *wpriv = wiphy_priv(wiphy);
+	struct nrf70_priv *priv = wpriv->priv;
+	struct nrf70_msg *msg;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_ABORT_SCAN,
+			       sizeof(struct nrf70_umac_header),
+			       NRF70_NDEV_TO_IFACE(wdev->netdev));
+	if (IS_ERR(msg))
+		return;
+
+	(void)nrf70_enqueue_message(priv->mem, msg);
+	kfree(msg);
+}
+
+static int nrf70_auth(struct wiphy *wiphy, struct net_device *ndev,
+		      struct cfg80211_auth_request *req)
+{
+	struct nrf70_wiphy_priv *wpriv = wiphy_priv(wiphy);
+	struct nrf70_priv *priv = wpriv->priv;
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_auth *cmd;
+	const u8 *ssid_ie;
+	int ret;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_AUTHENTICATE,
+			       sizeof(*cmd), NRF70_NDEV_TO_IFACE(ndev));
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_auth *)msg->data;
+	cmd->info.frequency = req->bss->channel->center_freq;
+	if (cmd->info.frequency)
+		cmd->valid_fields |= NRF70_AUTH_FREQ;
+
+	cmd->info.auth_type = nrf70_get_auth_type(req->auth_type);
+	if (cmd->info.auth_type < 0) {
+		ret = cmd->info.auth_type;
+		goto out;
+	}
+
+	memcpy(cmd->info.bssid, req->bss->bssid, ETH_ALEN);
+	memcpy(cmd->info.bss_ie.ie, req->bss->ies->data, req->bss->ies->len);
+	cmd->info.bss_ie.len = req->bss->ies->len;
+	cmd->info.scan_width = NL80211_BSS_CHAN_WIDTH_20;
+	cmd->info.signal = req->bss->signal;
+	cmd->info.capability = req->bss->capability;
+	cmd->info.beacon_interval = req->bss->beacon_interval;
+	cmd->info.tsf = req->bss->ies->tsf;
+	cmd->info.from_beacon = req->bss->ies->from_beacon;
+
+	ssid_ie = cfg80211_find_ie(WLAN_EID_SSID, req->bss->ies->data,
+				   req->bss->ies->len);
+	cmd->info.ssid.len = ssid_ie[1];
+	if (cmd->info.ssid.len) {
+		if (cmd->info.ssid.len > IEEE80211_MAX_SSID_LEN)
+			goto out;
+		memcpy(cmd->info.ssid.ssid, ssid_ie + 2, cmd->info.ssid.len);
+		cmd->valid_fields |= NRF70_AUTH_SSID;
+	}
+
+	if (req->key_len) {
+		cmd->info.key_info.key_idx = req->key_idx;
+		memcpy(cmd->info.key_info.key.data, req->key, req->key_len);
+		cmd->info.key_info.key.len = req->key_len;
+		cmd->info.key_info.cipher_suite = req->key_len == 5 ?
+						  WLAN_CIPHER_SUITE_WEP40 :
+						  WLAN_CIPHER_SUITE_WEP104;
+		cmd->info.key_info.valid_fields = NRF70_KEY_INFO_KEY |
+						  NRF70_KEY_INFO_KEY_IDX |
+						  NRF70_KEY_INFO_CIPHER_SUITE;
+		cmd->valid_fields |= NRF70_AUTH_KEY_INFO;
+	}
+
+	if (req->auth_data_len) {
+		memcpy(cmd->info.sae.data, req->auth_data, req->auth_data_len);
+		cmd->info.sae.len = req->auth_data_len;
+		cmd->valid_fields |= NRF70_AUTH_SAE;
+	}
+
+	ret = nrf70_enqueue_message(priv->mem, msg);
+
+out:
+	kfree(msg);
+
+	return ret;
+}
+
+static int nrf70_assoc(struct wiphy *wiphy, struct net_device *ndev,
+		       struct cfg80211_assoc_request *req)
+{
+	struct nrf70_wiphy_priv *wpriv = wiphy_priv(wiphy);
+	struct nrf70_priv *priv = wpriv->priv;
+	struct nrf70_vif *vif = nrf70_get_vif(priv, NRF70_NDEV_TO_IFACE(ndev));
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_assoc *cmd;
+	const u8 *ssid_ie;
+	int ret;
+
+	vif->bss = req->bss;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_ASSOCIATE,
+			       sizeof(*cmd), vif->iface);
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_assoc *)msg->data;
+	cmd->info.frequency = req->bss->channel->center_freq;
+	cmd->info.valid_fields |= NRF70_CONNECT_FREQ;
+
+	if (!is_zero_ether_addr(req->bss->bssid)) {
+		ether_addr_copy(cmd->info.hwaddr, req->bss->bssid);
+		cmd->info.valid_fields |= NRF70_CONNECT_HWADDR;
+	}
+
+	ssid_ie = cfg80211_find_ie(WLAN_EID_SSID, req->bss->ies->data,
+				   req->bss->ies->len);
+	cmd->info.ssid.len = ssid_ie[1];
+	if (cmd->info.ssid.len) {
+		memcpy(cmd->info.ssid.ssid, ssid_ie + 2, cmd->info.ssid.len);
+		cmd->info.valid_fields |= NRF70_CONNECT_SSID;
+	}
+
+	cmd->info.wpa_ie.len = req->ie_len;
+	if (cmd->info.wpa_ie.len) {
+		memcpy(cmd->info.wpa_ie.ie, req->ie, cmd->info.wpa_ie.len);
+		cmd->info.valid_fields |= NRF70_CONNECT_WPA_IE;
+	}
+
+	cmd->info.use_mfp = req->use_mfp;
+	if (cmd->info.use_mfp)
+		cmd->info.valid_fields |= NRF70_CONNECT_MFP;
+
+	nrf70_set_crypto_info(&cmd->info, &req->crypto);
+
+	cmd->info.wifi_flags |= NRF70_CONNECT_FLAGS_USE_RRM;
+
+	ret = nrf70_enqueue_message(priv->mem, msg);
+	kfree(msg);
+
+	return ret;
+}
+
+static int nrf70_deauth_command(struct spi_mem *mem, const u8 *hwaddr,
+				u16 reason, bool state_change,
+				struct net_device *ndev)
+{
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_disconn *cmd;
+	int ret;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_DEAUTHENTICATE,
+			       sizeof(*cmd), NRF70_NDEV_TO_IFACE(ndev));
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_disconn *)msg->data;
+	cmd->info.reason = reason;
+
+	if (!is_zero_ether_addr(hwaddr)) {
+		ether_addr_copy(cmd->info.hwaddr, hwaddr);
+		cmd->valid_fields |= NRF70_DISCONN_HWADDR;
+	}
+
+	if (state_change)
+		cmd->info.flags |= NRF70_DISCONN_FLAGS_LOCAL_STATE_CHANGE;
+
+	ret = nrf70_enqueue_message(mem, msg);
+	kfree(msg);
+
+	cfg80211_disconnected(ndev, reason, NULL, 0, true, GFP_KERNEL);
+
+	return ret;
+}
+
+static int nrf70_deauth(struct wiphy *wiphy, struct net_device *ndev,
+			struct cfg80211_deauth_request *req)
+{
+	struct nrf70_wiphy_priv *wpriv = wiphy_priv(wiphy);
+	struct nrf70_priv *priv = wpriv->priv;
+
+	return nrf70_deauth_command(priv->mem, req->bssid, req->reason_code,
+				    req->local_state_change, ndev);
+}
+
+static int nrf70_disassoc(struct wiphy *wiphy, struct net_device *ndev,
+			  struct cfg80211_disassoc_request *req)
+{
+	struct nrf70_wiphy_priv *wpriv = wiphy_priv(wiphy);
+	struct nrf70_priv *priv = wpriv->priv;
+
+	return nrf70_deauth_command(priv->mem, req->ap_addr, req->reason_code,
+				    req->local_state_change, ndev);
+}
+
+static int nrf70_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
+			 struct cfg80211_mgmt_tx_params *params, u64 *cookie)
+{
+	struct nrf70_wiphy_priv *wpriv = wiphy_priv(wiphy);
+	struct nrf70_priv *priv = wpriv->priv;
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_mgmt_tx *cmd;
+	int ret;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_FRAME,
+			       sizeof(*cmd), NRF70_NDEV_TO_IFACE(wdev->netdev));
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_mgmt_tx *)msg->data;
+	cmd->valid_fields = NRF70_MGMT_TX_FREQ | NRF70_MGMT_TX_DURATION |
+			    NRF70_MGMT_TX_SET_FRAME_FREQ;
+	cmd->info.freq_params.valid_fields = NRF70_MGMT_TX_FREQ_MASK;
+
+	if (params->offchan)
+		cmd->info.wifi_flags |= NRF70_MGMT_TX_FLAGS_OFFCHAN_TX;
+	if (params->dont_wait_for_ack)
+		cmd->info.wifi_flags |= NRF70_MGMT_TX_FLAGS_NO_ACK;
+	if (params->no_cck)
+		cmd->info.wifi_flags |= NRF70_MGMT_TX_FLAGS_NO_CCK_RATE;
+	if (params->chan)
+		cmd->info.frequency = params->chan->center_freq;
+	if (params->len) {
+		memcpy(cmd->info.frame.data, params->buf, params->len);
+		cmd->info.frame.len = params->len;
+	}
+
+	cmd->info.dur = params->wait;
+	cmd->info.freq_params.frequency = cmd->info.frequency;
+	cmd->info.freq_params.channel_width = NL80211_CHAN_WIDTH_20;
+	cmd->info.freq_params.center_freq1 = cmd->info.frequency;
+	cmd->info.freq_params.center_freq2 = 0;
+	cmd->info.freq_params.channel_type = NL80211_CHAN_HT20;
+
+	while (!priv->mgmt_frame_cookie++)
+		;
+	*cookie = cmd->info.cookie = priv->mgmt_frame_cookie;
+
+	ret = nrf70_enqueue_message(priv->mem, msg);
+	kfree(msg);
+
+	return ret;
+}
+
+static void nrf70_update_mgmt_frame_reg(struct wiphy *wiphy,
+					struct wireless_dev *wdev,
+					struct mgmt_frame_regs *upd)
+{
+	struct nrf70_wiphy_priv *wpriv = wiphy_priv(wiphy);
+	struct nrf70_priv *priv = wpriv->priv;
+	struct nrf70_vif *vif = container_of(wdev, struct nrf70_vif, wdev);
+	struct device *dev = &priv->mem->spi->dev;
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_mgmt_frame_reg *cmd;
+	unsigned long bmp = upd->interface_stypes;
+	int ret, bit;
+
+	if (!bmp) {
+		/* Clear state and exit. Usually called at AP start/teardown. */
+		WRITE_ONCE(vif->iface_stypes, 0);
+		return;
+	}
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_REGISTER_FRAME,
+			       sizeof(*cmd), vif->iface);
+	if (IS_ERR(msg))
+		return;
+
+	cmd = (struct nrf70_cmd_mgmt_frame_reg *)msg->data;
+
+	while ((bit = ffs(bmp))) {
+		bit--;
+
+		clear_bit(bit, &bmp);
+		if (vif->iface_stypes & bit)
+			continue;
+
+		cmd->info.type = bit << 4;
+		cmd->info.match_len = 0;
+		set_bit(bit, &vif->iface_stypes);
+
+		ret = nrf70_enqueue_message(priv->mem, msg);
+		if (ret) {
+			dev_err(dev, "Unable to register mgmt frame %d: %d\n",
+				cmd->info.type, ret);
+			continue;
+		}
+
+		/*
+		 * There is no callback to know when the ongoing frame
+		 * registration has completed. Instead, we need to wait for
+		 * a bit before sending in another frame registration command.
+		 * Below sleep value has been derived experimentally.
+		 */
+		msleep(50);
+	}
+
+	kfree(msg);
+}
+
+static int nrf70_set_station(struct net_device *ndev, const u8 *mac,
+			     struct station_parameters *params, int cmd_id)
+{
+	struct nrf70_ndev_priv *npriv = netdev_priv(ndev);
+	struct nrf70_priv *priv = npriv->priv;
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_chg_sta *cmd;
+	int ret, flags_mask = NL80211_STA_FLAG_ASSOCIATED - 1;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, cmd_id, sizeof(*cmd),
+			       NRF70_NDEV_TO_IFACE(ndev));
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_chg_sta *)msg->data;
+	cmd->valid_fields = NRF70_CHG_STA_LISTEN_INTERVAL;
+
+	cmd->aid = params->aid;
+	if (cmd->aid)
+		cmd->valid_fields |= NRF70_CHG_STA_AID;
+
+	cmd->sta_capability = params->capability;
+	if (cmd->sta_capability)
+		cmd->valid_fields |= NRF70_CHG_STA_STA_CAPAB;
+
+	cmd->listen_interval = params->listen_interval;
+
+	cmd->supp_rates.num_rates = params->link_sta_params.supported_rates_len;
+	if (cmd->supp_rates.num_rates) {
+		memcpy(cmd->supp_rates.rates,
+		       params->link_sta_params.supported_rates,
+		       cmd->supp_rates.num_rates);
+		cmd->valid_fields |= NRF70_CHG_STA_SUPP_RATES;
+	}
+
+	cmd->ext_cap_len = params->ext_capab_len;
+	if (cmd->ext_cap_len) {
+		memcpy(cmd->ext_cap, params->ext_capab, cmd->ext_cap_len);
+		cmd->valid_fields |= NRF70_CHG_STA_EXT_CAPAB;
+	}
+
+	cmd->sup_chans_len = params->supported_channels_len;
+	if (cmd->sup_chans_len) {
+		memcpy(cmd->sup_chans, params->supported_channels,
+		       cmd->sup_chans_len);
+		cmd->valid_fields |= NRF70_CHG_STA_SUP_CHANS;
+	}
+
+	cmd->sup_oper_classes_len = params->supported_oper_classes_len;
+	if (cmd->sup_oper_classes_len) {
+		memcpy(cmd->sup_oper_classes, params->supported_oper_classes,
+		       cmd->sup_oper_classes_len);
+		cmd->valid_fields |= NRF70_CHG_STA_OPER_CLASSES;
+	}
+
+	cmd->sta_flags2.mask = params->sta_flags_mask & flags_mask;
+	cmd->sta_flags2.set = params->sta_flags_set & flags_mask;
+	cmd->valid_fields |= NRF70_CHG_STA_FLAGS2;
+
+	if (params->link_sta_params.ht_capa) {
+		memcpy(cmd->ht_cap, params->link_sta_params.ht_capa,
+		       sizeof(*params->link_sta_params.ht_capa));
+		cmd->valid_fields |= NRF70_CHG_STA_HT_CAP;
+	}
+
+	if (params->link_sta_params.vht_capa) {
+		memcpy(cmd->vht_cap, params->link_sta_params.vht_capa,
+		       sizeof(*params->link_sta_params.vht_capa));
+		cmd->valid_fields |= NRF70_CHG_STA_VHT_CAP;
+	}
+
+	ether_addr_copy(cmd->hwaddr, mac);
+
+	if (params->link_sta_params.opmode_notif_used) {
+		cmd->opmode_notif = params->link_sta_params.opmode_notif;
+		cmd->valid_fields |= NRF70_CHG_STA_OPMODE_NOTIF;
+	}
+
+	cmd->wme_uapsd_queues = params->uapsd_queues;
+	if (cmd->wme_uapsd_queues)
+		cmd->valid_fields |= NRF70_CHG_STA_WME_UAPSD_QUEUES;
+
+	cmd->wme_max_sp = params->max_sp;
+	if (cmd->wme_max_sp)
+		cmd->valid_fields |= NRF70_CHG_STA_WME_MAX_SP;
+
+	ret = nrf70_enqueue_message(priv->mem, msg);
+	kfree(msg);
+
+	return ret;
+}
+
+static int nrf70_add_station(struct wiphy *wiphy, struct net_device *ndev,
+			     const u8 *mac, struct station_parameters *params)
+{
+	return nrf70_set_station(ndev, mac, params, NRF70_UMAC_CMD_NEW_STATION);
+}
+
+static int nrf70_change_station(struct wiphy *wiphy, struct net_device *ndev,
+				const u8 *mac,
+				struct station_parameters *params)
+{
+	return nrf70_set_station(ndev, mac, params, NRF70_UMAC_CMD_SET_STATION);
+}
+
+static int nrf70_del_station(struct wiphy *wiphy, struct net_device *ndev,
+			     struct station_del_parameters *params)
+{
+	struct nrf70_wiphy_priv *wpriv = wiphy_priv(wiphy);
+	struct nrf70_priv *priv = wpriv->priv;
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_del_sta *cmd;
+	int ret;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_DEL_STATION,
+			       sizeof(*cmd), NRF70_NDEV_TO_IFACE(ndev));
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_del_sta *)msg->data;
+
+	if (params->mac && !is_zero_ether_addr(params->mac)) {
+		ether_addr_copy(cmd->hwaddr, params->mac);
+		cmd->valid_fields |= NRF70_DEL_STA_HWADDR;
+	}
+
+	cmd->mgmt_subtype = params->subtype;
+	if (cmd->mgmt_subtype)
+		cmd->valid_fields |= NRF70_DEL_STA_MGMT_SUBTYPE;
+
+	cmd->reason = params->reason_code;
+	if (cmd->reason)
+		cmd->valid_fields |= NRF70_DEL_STA_REASON;
+
+	ret = nrf70_enqueue_message(priv->mem, msg);
+	kfree(msg);
+
+	return ret;
+}
+
+static int nrf70_get_station(struct wiphy *wiphy, struct net_device *ndev,
+			     const u8 *mac, struct station_info *sinfo)
+{
+	struct nrf70_wiphy_priv *wpriv = wiphy_priv(wiphy);
+	struct nrf70_priv *priv = wpriv->priv;
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_get_sta *cmd;
+	int ret;
+
+	if (READ_ONCE(priv->sinfo))
+		return -EBUSY;
+
+	reinit_completion(&priv->station_info_available);
+	WRITE_ONCE(priv->sinfo, sinfo);
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_GET_STATION,
+			       sizeof(*cmd), NRF70_NDEV_TO_IFACE(ndev));
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_get_sta *)msg->data;
+	ether_addr_copy(cmd->hwaddr, mac);
+
+	ret = nrf70_enqueue_message(priv->mem, msg);
+	kfree(msg);
+	if (ret)
+		goto out;
+
+	ret = wait_for_completion_timeout(&priv->station_info_available,
+					  msecs_to_jiffies(100)) ?
+					  0 : -ETIMEDOUT;
+
+out:
+	WRITE_ONCE(priv->sinfo, NULL);
+
+	return ret;
+}
+
+static int nrf70_dump_station(struct wiphy *wiphy, struct net_device *ndev,
+			      int idx, u8 *mac, struct station_info *sinfo)
+{
+	struct nrf70_ndev_priv *npriv = netdev_priv(ndev);
+	struct nrf70_vif *vif = npriv->vif;
+	unsigned long bmp, flags;
+	int bit;
+
+	spin_lock_irqsave(&vif->sta_lock, flags);
+	bmp = vif->sta_bitmap;
+	if (idx >= NRF70_PEERS_MAX || vif->sta_bitmap == NRF70_PEERS_MASK)
+		goto err;
+
+	do {
+		bit = ffz(bmp);
+		set_bit(bit, &bmp);
+	} while (idx--);
+
+	if (bit >= NRF70_PEERS_MAX)
+		goto err;
+
+	ether_addr_copy(mac, vif->sta[bit].addr);
+	spin_unlock_irqrestore(&vif->sta_lock, flags);
+
+	return nrf70_get_station(wiphy, ndev, mac, sinfo);
+
+err:
+	spin_unlock_irqrestore(&npriv->vif->sta_lock, flags);
+	return -ENOENT;
+}
+
+static int nrf70_set_qos_map(struct wiphy *wiphy, struct net_device *ndev,
+			     struct cfg80211_qos_map *qos_map)
+{
+	struct nrf70_wiphy_priv *wpriv = wiphy_priv(wiphy);
+	struct nrf70_priv *priv = wpriv->priv;
+	struct nrf70_ndev_priv *npriv = netdev_priv(ndev);
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_set_qos_map *cmd;
+	int ret;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_SET_QOS_MAP,
+			       sizeof(*cmd), NRF70_NDEV_TO_IFACE(ndev));
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_set_qos_map *)msg->data;
+
+	/* NULL might be passed to disable QoS mapping. */
+	if (qos_map) {
+		cmd->map_info.len = sizeof(*qos_map);
+		memcpy(cmd->map_info.data, qos_map, cmd->map_info.len);
+	}
+
+	ret = nrf70_enqueue_message(priv->mem, msg);
+	if (!ret)
+		WRITE_ONCE(npriv->vif->qos_map, qos_map);
+
+	kfree(msg);
+
+	return ret;
+}
+
+static int nrf70_set_wiphy_params(struct wiphy *wiphy, u32 changed)
+{
+	struct nrf70_wiphy_priv *wpriv = wiphy_priv(wiphy);
+	struct nrf70_priv *priv = wpriv->priv;
+	struct nrf70_wiphy_info info = {};
+	struct nrf70_vif *vif = list_first_entry(&priv->vifs, typeof(*vif),
+						 list);
+
+	if (list_entry_is_head(vif, &priv->vifs, list))
+		return -EINVAL;
+
+	if (changed & WIPHY_PARAM_RETRY_SHORT)
+		info.retry_short = wiphy->retry_short;
+	if (changed & WIPHY_PARAM_RETRY_LONG)
+		info.retry_long = wiphy->retry_long;
+	if (changed & WIPHY_PARAM_FRAG_THRESHOLD)
+		info.frag_threshold = wiphy->frag_threshold;
+	if (changed & WIPHY_PARAM_RTS_THRESHOLD)
+		info.rts_threshold = wiphy->rts_threshold;
+	if (changed & WIPHY_PARAM_COVERAGE_CLASS)
+		info.coverage_class = wiphy->coverage_class;
+
+	return nrf70_set_wiphy_command(priv->mem, vif->iface, &info);
+}
+
+static int nrf70_get_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
+			     unsigned int link_id,
+			     struct cfg80211_chan_def *chandef)
+{
+	struct nrf70_wiphy_priv *wpriv = wiphy_priv(wiphy);
+	struct nrf70_priv *priv = wpriv->priv;
+	struct nrf70_vif *vif = container_of(wdev, struct nrf70_vif, wdev);
+	struct nrf70_msg *msg;
+	struct nrf70_umac_header *cmd;
+	int ret = 0;
+
+	if (!(vif->ndev->flags & IFF_UP))
+		return -ENETDOWN;
+
+	/*
+	 * CMD_GET_CHANNEL works only for associated APs. In case of monitor
+	 * mode, simply return the channel currently being tuned to.
+	 */
+	if (vif->wdev.iftype == NL80211_IFTYPE_MONITOR) {
+		*chandef = vif->chandef;
+		goto out;
+	}
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_GET_CHANNEL,
+			       sizeof(*cmd), vif->iface);
+	if (IS_ERR(msg)) {
+		ret = PTR_ERR(msg);
+		goto out;
+	}
+
+	reinit_completion(&vif->chan_updated);
+	ret = nrf70_enqueue_message(priv->mem, msg);
+	kfree(msg);
+
+	if (ret)
+		goto out;
+
+	if (!wait_for_completion_timeout(&vif->chan_updated,
+					 msecs_to_jiffies(1000)))
+		return -ETIMEDOUT;
+
+	*chandef = vif->chandef;
+
+	return chandef->center_freq1 ? 0 : -EINVAL;
+
+out:
+	return ret;
+}
+
+static int nrf70_probe_client(struct wiphy *wiphy, struct net_device *ndev,
+			      const u8 *peer, u64 *cookie)
+{
+	/* Provide fake probe_client to work around hostapd limitations. */
+	return -EOPNOTSUPP;
+}
+
+static const struct cfg80211_ops nrf70_cfg80211_ops = {
+	.add_virtual_intf = nrf70_add_vif,
+	.del_virtual_intf = nrf70_del_vif,
+	.change_virtual_intf = nrf70_chg_vif,
+	.add_key = nrf70_add_key,
+	.del_key = nrf70_del_key,
+	.set_default_key = nrf70_set_default_key,
+	.set_default_mgmt_key = nrf70_set_default_mgmt_key,
+	.start_ap = nrf70_start_ap,
+	.change_beacon = nrf70_change_beacon,
+	.stop_ap = nrf70_stop_ap,
+	.set_monitor_channel = nrf70_set_monitor_channel,
+	.scan = nrf70_scan,
+	.abort_scan = nrf70_abort_scan,
+	.auth = nrf70_auth,
+	.assoc = nrf70_assoc,
+	.deauth = nrf70_deauth,
+	.disassoc = nrf70_disassoc,
+	.mgmt_tx = nrf70_mgmt_tx,
+	.update_mgmt_frame_registrations = nrf70_update_mgmt_frame_reg,
+	.add_station = nrf70_add_station,
+	.change_station = nrf70_change_station,
+	.del_station = nrf70_del_station,
+	.get_station = nrf70_get_station,
+	.dump_station = nrf70_dump_station,
+	.change_bss = nrf70_change_bss,
+	.set_qos_map = nrf70_set_qos_map,
+	.set_wiphy_params = nrf70_set_wiphy_params,
+	.get_channel = nrf70_get_channel,
+	.probe_client = nrf70_probe_client,
+};
+
+static const struct ieee80211_txrx_stypes
+nrf70_default_mgmt_stypes[NUM_NL80211_IFTYPES] = {
+	[NL80211_IFTYPE_STATION] = {
+		.tx = 0xffff,
+		.rx = BIT(IEEE80211_STYPE_ACTION >> 4) |
+			BIT(IEEE80211_STYPE_PROBE_REQ >> 4),
+	},
+	[NL80211_IFTYPE_AP] = {
+		.tx = 0xffff,
+		.rx = BIT(IEEE80211_STYPE_ASSOC_REQ >> 4) |
+			BIT(IEEE80211_STYPE_REASSOC_REQ >> 4) |
+			BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
+			BIT(IEEE80211_STYPE_DISASSOC >> 4) |
+			BIT(IEEE80211_STYPE_AUTH >> 4) |
+			BIT(IEEE80211_STYPE_DEAUTH >> 4) |
+			BIT(IEEE80211_STYPE_ACTION >> 4),
+	},
+};
+
+static const struct ieee80211_iface_limit nrf70_if_limits[] = {
+	{
+		.max = NRF70_VIFS_MAX,
+		.types = BIT(NL80211_IFTYPE_STATION) |
+			 BIT(NL80211_IFTYPE_AP),
+	},
+};
+
+static const struct ieee80211_iface_combination nrf70_if_comb[] = {
+	{
+		.limits = nrf70_if_limits,
+		.n_limits = ARRAY_SIZE(nrf70_if_limits),
+		.max_interfaces = NRF70_VIFS_MAX,
+		.num_different_channels = 1,
+		.beacon_int_infra_match = true,
+	}
+};
+
+#define NRF70_CHAN2G(freq, idx)		\
+	{					\
+		.band = NL80211_BAND_2GHZ,	\
+		.center_freq = (freq),		\
+		.hw_value = (idx),		\
+		.max_power = 20,		\
+	}
+
+static struct ieee80211_channel nrf70_dsss_chans[] = {
+	NRF70_CHAN2G(2412, 0),
+	NRF70_CHAN2G(2417, 1),
+	NRF70_CHAN2G(2422, 2),
+	NRF70_CHAN2G(2427, 3),
+	NRF70_CHAN2G(2432, 4),
+	NRF70_CHAN2G(2437, 5),
+	NRF70_CHAN2G(2442, 6),
+	NRF70_CHAN2G(2447, 7),
+	NRF70_CHAN2G(2452, 8),
+	NRF70_CHAN2G(2457, 9),
+	NRF70_CHAN2G(2462, 10),
+	NRF70_CHAN2G(2467, 11),
+	NRF70_CHAN2G(2472, 12),
+	NRF70_CHAN2G(2484, 13),
+};
+
+static struct ieee80211_rate nrf70_dsss_rates[] = {
+	{ .bitrate = 10, .hw_value = 2 },
+	{ .bitrate = 20, .hw_value = 4,
+	  .flags = IEEE80211_RATE_SHORT_PREAMBLE },
+	{ .bitrate = 55,
+	  .hw_value = 11,
+	  .flags = IEEE80211_RATE_SHORT_PREAMBLE },
+	{ .bitrate = 110,
+	  .hw_value = 22,
+	  .flags = IEEE80211_RATE_SHORT_PREAMBLE },
+	{ .bitrate = 60, .hw_value = 12 },
+	{ .bitrate = 90, .hw_value = 18 },
+	{ .bitrate = 120, .hw_value = 24 },
+	{ .bitrate = 180, .hw_value = 36 },
+	{ .bitrate = 240, .hw_value = 48 },
+	{ .bitrate = 360, .hw_value = 72 },
+	{ .bitrate = 480, .hw_value = 96 },
+	{ .bitrate = 540, .hw_value = 108 },
+};
+
+static struct ieee80211_supported_band nrf70_band_2ghz = {
+	.channels = nrf70_dsss_chans,
+	.n_channels = ARRAY_SIZE(nrf70_dsss_chans),
+	.band = NL80211_BAND_2GHZ,
+	.bitrates = nrf70_dsss_rates,
+	.n_bitrates = ARRAY_SIZE(nrf70_dsss_rates),
+	.ht_cap = {
+		.ht_supported = 1,
+		.cap = IEEE80211_HT_CAP_MAX_AMSDU |
+		       IEEE80211_HT_CAP_SGI_20 |
+		       IEEE80211_HT_CAP_SGI_40 |
+		       IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
+		       BIT(IEEE80211_HT_CAP_RX_STBC_SHIFT) |
+		       IEEE80211_HT_CAP_LSIG_TXOP_PROT,
+		.ampdu_factor = IEEE80211_HT_MAX_AMPDU_32K,
+		.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16,
+		.mcs = {
+			.tx_params = IEEE80211_HT_MCS_TX_DEFINED,
+			.rx_mask[0] = 0xff,
+			.rx_mask[4] = 0x1,
+		},
+	},
+	.iftype_data = &(const struct ieee80211_sband_iftype_data){
+		.types_mask = BIT(NL80211_IFTYPE_STATION) |
+			      BIT(NL80211_IFTYPE_AP),
+		.he_cap = {
+			.has_he = true,
+			.he_cap_elem = {
+				.mac_cap_info[0] = IEEE80211_HE_MAC_CAP0_HTC_HE,
+			},
+			.he_mcs_nss_supp = {
+				.rx_mcs_80 = 0xfffc,
+				.tx_mcs_80 = 0xfffc,
+				.rx_mcs_160 = 0xffff,
+				.tx_mcs_160 = 0xffff,
+				.rx_mcs_80p80 = 0xffff,
+				.tx_mcs_80p80 = 0xffff,
+			},
+		},
+	},
+	.n_iftype_data = 1,
+};
+
+#define	NRF70_CHAN5G(freq, idx, flgs)					\
+{									\
+	.band = NL80211_BAND_5GHZ,					\
+	.center_freq = (freq),						\
+	.hw_value = (idx),						\
+	.max_power = 20,						\
+	.flags = (flgs)							\
+}
+
+static struct ieee80211_channel nrf70_ofdm_chans[] = {
+	NRF70_CHAN5G(5180, 14, 0),
+	NRF70_CHAN5G(5200, 15, 0),
+	NRF70_CHAN5G(5220, 16, 0),
+	NRF70_CHAN5G(5240, 17, 0),
+	NRF70_CHAN5G(5260, 18, IEEE80211_CHAN_RADAR),
+	NRF70_CHAN5G(5280, 19, IEEE80211_CHAN_RADAR),
+	NRF70_CHAN5G(5300, 20, IEEE80211_CHAN_RADAR),
+	NRF70_CHAN5G(5320, 21, IEEE80211_CHAN_RADAR),
+	NRF70_CHAN5G(5500, 22, IEEE80211_CHAN_RADAR),
+	NRF70_CHAN5G(5520, 23, IEEE80211_CHAN_RADAR),
+	NRF70_CHAN5G(5540, 24, IEEE80211_CHAN_RADAR),
+	NRF70_CHAN5G(5560, 25, IEEE80211_CHAN_RADAR),
+	NRF70_CHAN5G(5580, 26, IEEE80211_CHAN_RADAR),
+	NRF70_CHAN5G(5600, 27, IEEE80211_CHAN_RADAR),
+	NRF70_CHAN5G(5620, 28, IEEE80211_CHAN_RADAR),
+	NRF70_CHAN5G(5640, 29, IEEE80211_CHAN_RADAR),
+	NRF70_CHAN5G(5660, 30, IEEE80211_CHAN_RADAR),
+	NRF70_CHAN5G(5680, 31, IEEE80211_CHAN_RADAR),
+	NRF70_CHAN5G(5700, 32, IEEE80211_CHAN_RADAR),
+	NRF70_CHAN5G(5720, 33, IEEE80211_CHAN_RADAR),
+	NRF70_CHAN5G(5745, 34, 0),
+	NRF70_CHAN5G(5765, 35, 0),
+	NRF70_CHAN5G(5785, 36, 0),
+	NRF70_CHAN5G(5805, 37, 0),
+	NRF70_CHAN5G(5825, 38, 0),
+	NRF70_CHAN5G(5845, 39, 0),
+	NRF70_CHAN5G(5865, 40, 0),
+	NRF70_CHAN5G(5885, 41, 0),
+};
+
+static struct ieee80211_rate nrf70_ofdm_rates[] = {
+	{ .bitrate = 60, .hw_value = 12 },
+	{ .bitrate = 90, .hw_value = 18 },
+	{ .bitrate = 120, .hw_value = 24 },
+	{ .bitrate = 180, .hw_value = 36 },
+	{ .bitrate = 240, .hw_value = 48 },
+	{ .bitrate = 360, .hw_value = 72 },
+	{ .bitrate = 480, .hw_value = 96 },
+	{ .bitrate = 540, .hw_value = 108 },
+};
+
+#define	NRF70_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT	\
+	(3 << IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT)
+
+#define	NRF70_VHT_MCS_MAP					\
+	((IEEE80211_VHT_MCS_SUPPORT_0_7 << 2 * 0) |		\
+	(IEEE80211_VHT_MCS_NOT_SUPPORTED << 2 * 1) |		\
+	(IEEE80211_VHT_MCS_NOT_SUPPORTED << 2 * 2) |		\
+	(IEEE80211_VHT_MCS_NOT_SUPPORTED << 2 * 3) |		\
+	(IEEE80211_VHT_MCS_NOT_SUPPORTED << 2 * 4) |		\
+	(IEEE80211_VHT_MCS_NOT_SUPPORTED << 2 * 5) |		\
+	(IEEE80211_VHT_MCS_NOT_SUPPORTED << 2 * 6) |		\
+	(IEEE80211_VHT_MCS_NOT_SUPPORTED << 2 * 7))
+
+static struct ieee80211_supported_band nrf70_band_5ghz = {
+	.channels = nrf70_ofdm_chans,
+	.n_channels = ARRAY_SIZE(nrf70_ofdm_chans),
+	.band = NL80211_BAND_5GHZ,
+	.bitrates = nrf70_ofdm_rates,
+	.n_bitrates = ARRAY_SIZE(nrf70_ofdm_rates),
+	.ht_cap = {
+		.ht_supported = 1,
+		.cap = IEEE80211_HT_CAP_MAX_AMSDU |
+		       IEEE80211_HT_CAP_SGI_20 |
+		       IEEE80211_HT_CAP_SGI_40 |
+		       IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
+		       BIT(IEEE80211_HT_CAP_RX_STBC_SHIFT) |
+		       IEEE80211_HT_CAP_LSIG_TXOP_PROT,
+		.ampdu_factor = IEEE80211_HT_MAX_AMPDU_32K,
+		.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16,
+		.mcs = {
+			.tx_params = IEEE80211_HT_MCS_TX_DEFINED,
+			.rx_mask[0] = 0xff,
+			.rx_mask[4] = 0x1,
+		},
+	},
+	.vht_cap = {
+		.vht_supported = true,
+		.cap = IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454 |
+		       IEEE80211_VHT_CAP_SHORT_GI_80 |
+		       IEEE80211_VHT_CAP_RXLDPC |
+		       IEEE80211_VHT_CAP_TXSTBC |
+		       IEEE80211_VHT_CAP_RXSTBC_1 |
+		       IEEE80211_VHT_CAP_HTC_VHT |
+		       NRF70_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT,
+		.vht_mcs = {
+			.rx_mcs_map = NRF70_VHT_MCS_MAP,
+			.tx_mcs_map = NRF70_VHT_MCS_MAP,
+		},
+	},
+	.iftype_data = &(const struct ieee80211_sband_iftype_data){
+		.types_mask = BIT(NL80211_IFTYPE_STATION) |
+			      BIT(NL80211_IFTYPE_AP),
+		.he_cap = {
+			.has_he = true,
+			.he_cap_elem = {
+				.mac_cap_info[0] = IEEE80211_HE_MAC_CAP0_HTC_HE,
+			},
+			.he_mcs_nss_supp = {
+				.rx_mcs_80 = 0xfffc,
+				.tx_mcs_80 = 0xfffc,
+				.rx_mcs_160 = 0xffff,
+				.tx_mcs_160 = 0xffff,
+				.rx_mcs_80p80 = 0xffff,
+				.tx_mcs_80p80 = 0xffff,
+			},
+		},
+	},
+	.n_iftype_data = 1,
+};
+
+static const u32 nrf70_cipher_suites[] = {
+	WLAN_CIPHER_SUITE_WEP40,	WLAN_CIPHER_SUITE_WEP104,
+	WLAN_CIPHER_SUITE_TKIP,		WLAN_CIPHER_SUITE_CCMP,
+	WLAN_CIPHER_SUITE_CCMP_256,	WLAN_CIPHER_SUITE_AES_CMAC,
+	WLAN_CIPHER_SUITE_GCMP,		WLAN_CIPHER_SUITE_GCMP_256,
+	WLAN_CIPHER_SUITE_BIP_GMAC_128, WLAN_CIPHER_SUITE_BIP_GMAC_256,
+	WLAN_CIPHER_SUITE_BIP_CMAC_256,
+};
+
+#define	NRF70_TUNING_LEN	16
+#define	NRF70_PADDING_MAX	16
+static int nrf70_tune_read_op(struct spi_mem *mem)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	u32 *buf, addr = NRF70_RX_CMD_BASE;
+	int i, j, ret = 0;
+
+	buf = kzalloc(NRF70_TUNING_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/* Test for readl timing. */
+	for (i = 0; i <= NRF70_PADDING_MAX; i++) {
+		priv->read_op_pad[0] = i;
+
+		memcpy(buf, nrf70_tuning_pattern, NRF70_TUNING_LEN);
+		nrf70_writev(mem, addr, buf, NRF70_TUNING_LEN);
+
+		memset(buf, 0, NRF70_TUNING_LEN);
+		for (j = 0; j < NRF70_TUNING_LEN / 4; j++)
+			buf[j] = nrf70_readl(mem, addr + 4 * j);
+
+		if (!memcmp(buf, nrf70_tuning_pattern, NRF70_TUNING_LEN))
+			break;
+	}
+	if (i > NRF70_PADDING_MAX) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	addr = NRF70_TX_CMD_BASE;
+	/* Test for PKTRAM readl timing. */
+	for (i = 0; i <= NRF70_PADDING_MAX; i++) {
+		priv->read_op_pad[1] = i;
+
+		memcpy(buf, nrf70_tuning_pattern, NRF70_TUNING_LEN);
+		nrf70_writev(mem, addr, buf, NRF70_TUNING_LEN);
+
+		memset(buf, 0, NRF70_TUNING_LEN);
+		for (j = 0; j < NRF70_TUNING_LEN / 4; j++)
+			buf[j] = nrf70_readl(mem, addr + 4 * j);
+
+		if (!memcmp(buf, nrf70_tuning_pattern, NRF70_TUNING_LEN))
+			break;
+	}
+	if (i > NRF70_PADDING_MAX) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Test for readv timing. */
+	for (i = 0; i <= NRF70_PADDING_MAX; i++) {
+		priv->read_op_pad[2] = i;
+
+		memcpy(buf, nrf70_tuning_pattern, NRF70_TUNING_LEN);
+		nrf70_writev(mem, addr, buf, NRF70_TUNING_LEN);
+
+		memset(buf, 0, NRF70_TUNING_LEN);
+		nrf70_readv(mem, addr, buf, NRF70_TUNING_LEN);
+
+		if (!memcmp(buf, nrf70_tuning_pattern, NRF70_TUNING_LEN))
+			break;
+	}
+	if (i > NRF70_PADDING_MAX)
+		ret = -EINVAL;
+
+out:
+	kfree(buf);
+
+	return ret;
+}
+
+static struct nrf70_mem_op *nrf70_select_op_variant(struct spi_mem *mem,
+						    struct nrf70_mem_op *ops,
+						    size_t num_ops)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(0, 1),
+					  SPI_MEM_OP_ADDR(3, 0, 0),
+					  SPI_MEM_OP_NO_DUMMY,
+					  SPI_MEM_OP_NO_DATA);
+	int i;
+
+	if (num_ops <= 0)
+		return NULL;
+
+	for (i = 0; i < num_ops; i++) {
+		op.cmd.opcode = ops[i].op;
+		op.addr.nbytes = ops[i].width;
+		op.addr.buswidth = ops[i].width;
+		op.data.dir = ops[i].dir;
+		op.data.nbytes = 4;
+		op.data.buswidth = ops[i].width;
+
+		if (ops[i].dir == SPI_MEM_DATA_IN) {
+			op.dummy.nbytes = 5;
+			op.dummy.buswidth = ops[i].width;
+			op.data.buf.in = &priv->rx_buf;
+		} else {
+			op.data.buf.out = &priv->tx_buf;
+		}
+
+		if (spi_mem_supports_op(mem, &op))
+			break;
+	}
+
+	return i >= num_ops ? NULL : &ops[i];
+}
+
+static int nrf70_get_reg(struct nrf70_priv *priv)
+{
+	struct nrf70_msg *msg;
+	int ret;
+
+	if (!wait_for_completion_timeout(&priv->init_done, HZ))
+		return -EAGAIN;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_GET_REG,
+			       sizeof(struct nrf70_umac_header), -1);
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	reinit_completion(&priv->regdom_updated);
+
+	ret = nrf70_enqueue_message(priv->mem, msg);
+	kfree(msg);
+
+	if (ret)
+		return ret;
+
+	return wait_for_completion_timeout(&priv->regdom_updated,
+					   msecs_to_jiffies(1000)) ?
+					   0 : -ETIMEDOUT;
+}
+
+static int nrf70_set_reg(struct nrf70_priv *priv, char *alpha2)
+{
+	struct nrf70_msg *msg;
+	struct nrf70_cmd_set_reg *cmd;
+	int ret;
+
+	if (!wait_for_completion_timeout(&priv->init_done, HZ))
+		return -EAGAIN;
+
+	msg = nrf70_create_msg(NRF70_MSG_UMAC, NRF70_UMAC_CMD_REQ_SET_REG,
+			       sizeof(*cmd), -1);
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	cmd = (struct nrf70_cmd_set_reg *)msg->data;
+	memcpy(cmd->alpha2, alpha2, sizeof(cmd->alpha2));
+	cmd->valid_fields = NRF70_SET_REG_ALPHA2 | NRF70_SET_REG_USER_REG_FORCE;
+
+	reinit_completion(&priv->regdom_updated);
+
+	ret = nrf70_enqueue_message(priv->mem, msg);
+	kfree(msg);
+
+	if (ret)
+		return ret;
+
+	return wait_for_completion_timeout(&priv->regdom_updated,
+					   msecs_to_jiffies(1000)) ?
+					   0 : -ETIMEDOUT;
+}
+
+static void nrf70_reg_notifier(struct wiphy *wiphy,
+			       struct regulatory_request *request)
+{
+	struct nrf70_wiphy_priv *wpriv = wiphy_priv(wiphy);
+	struct nrf70_priv *priv = wpriv->priv;
+	int ret;
+
+	ret = nrf70_get_reg(priv);
+	if (ret || !memcmp(request->alpha2, priv->regdom, sizeof(priv->regdom)))
+		return;
+
+	(void)nrf70_set_reg(priv, request->alpha2);
+}
+
+static int nrf70_deinit_command(struct spi_mem *mem)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct nrf70_msg *msg;
+	int ret;
+
+	msg = nrf70_create_msg(NRF70_MSG_SYSTEM, NRF70_CMD_DEINIT,
+			       sizeof(struct nrf70_header), -1);
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	reinit_completion(&priv->init_done);
+	ret = nrf70_enqueue_message(mem, msg);
+	kfree(msg);
+
+	return ret ? ret : (wait_for_completion_timeout(&priv->init_done, HZ) ?
+			    0 : -ETIMEDOUT);
+}
+
+static int nrf70_probe(struct spi_mem *mem)
+{
+	struct nrf70_priv *priv;
+	struct nrf70_wiphy_priv *wpriv;
+	struct device *dev = &mem->spi->dev;
+	struct nrf70_vif *vif;
+	int irq_num, ret, val;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	spi_mem_set_drvdata(mem, priv);
+	priv->mem = mem;
+
+	mutex_init(&priv->write_lock);
+	mutex_init(&priv->read_lock);
+	mutex_init(&priv->enqueue_lock);
+	mutex_init(&priv->desc_lock);
+
+	priv->buck_en = devm_gpiod_get(dev, "bucken", 0);
+	if (!priv->buck_en) {
+		dev_err(dev, "Unable to find bucken-gpios property\n");
+		return -EINVAL;
+	}
+
+	ret = gpiod_direction_output(priv->buck_en, 0);
+	if (ret) {
+		dev_err(dev, "Unable to set buck_en direction\n");
+		return -EIO;
+	}
+
+	priv->iovdd_en = devm_gpiod_get_optional(dev, "iovdd", 0);
+	if (IS_ERR(priv->iovdd_en)) {
+		dev_err(dev, "Invalid iovdd-gpios property\n");
+		return PTR_ERR(priv->iovdd_en);
+	}
+
+	if (priv->iovdd_en) {
+		ret = gpiod_direction_output(priv->iovdd_en, 0);
+		if (ret) {
+			dev_err(dev, "Unable to set iovdd_en direction\n");
+			return -EIO;
+		}
+	}
+
+	priv->irq = devm_gpiod_get(dev, "irq", 0);
+	if (!priv->irq) {
+		dev_err(dev, "Unable to find irq-gpios property\n");
+		return -EINVAL;
+	}
+
+	ret = gpiod_direction_input(priv->irq);
+	if (ret) {
+		dev_err(dev, "Unable to set irq direction\n");
+		return -EIO;
+	}
+
+	irq_num = gpiod_to_irq(priv->irq);
+	if (irq_num < 0) {
+		dev_err(dev, "Unable to get gpio irq number: %d\n", ret);
+		return irq_num;
+	}
+
+	/* Test support of opcodes. */
+	priv->read_op = nrf70_select_op_variant(mem, nrf70_read_ops,
+						ARRAY_SIZE(nrf70_read_ops));
+	if (!priv->read_op)
+		return -EOPNOTSUPP;
+	priv->write_op = nrf70_select_op_variant(mem, nrf70_write_ops,
+						 ARRAY_SIZE(nrf70_write_ops));
+	if (!priv->write_op)
+		return -EOPNOTSUPP;
+
+	/* Wake up RPU. */
+	gpiod_set_value(priv->buck_en, 0);
+	if (priv->iovdd_en)
+		gpiod_set_value(priv->iovdd_en, 0);
+	usleep_range(1000, 2000);
+	gpiod_set_value(priv->buck_en, 1);
+	usleep_range(1000, 2000);
+	if (priv->iovdd_en) {
+		gpiod_set_value(priv->iovdd_en, 1);
+		usleep_range(1000, 2000);
+	}
+
+	nrf70_wrsr2(mem, NRF70_SR2_WAKEUP_REQ);
+
+	if (read_poll_timeout(nrf70_rdsr2, val, val & NRF70_SR2_WAKEUP_REQ,
+			      5 * USEC_PER_MSEC, 2 * USEC_PER_SEC, false,
+			      mem)) {
+		dev_err(dev, "Unable to wake up RPU: request failed\n");
+		ret = -ETIMEDOUT;
+		goto err_disable_rpu;
+	}
+
+	if (read_poll_timeout(nrf70_rdsr1, val, val & NRF70_SR1_AWAKE,
+			      5 * USEC_PER_MSEC, 2 * USEC_PER_SEC, false,
+			      mem)) {
+		dev_err(dev, "Unable to wake up RPU: bus not active\n");
+		ret = -ETIMEDOUT;
+		goto err_disable_rpu;
+	}
+
+	/* Ungate RPU clocks. */
+	nrf70_writel(mem, NRF70_PBUS_CLK, NRF70_PBUS_CLK_UNGATE);
+
+	ret = nrf70_tune_read_op(mem);
+	if (ret) {
+		dev_err(dev, "Unable to tune-in read op timing\n");
+		goto err_disable_rpu;
+	}
+
+	ret = nrf70_load_firmware(mem);
+	if (ret)
+		goto err_disable_rpu;
+
+	init_completion(&priv->init_done);
+	init_completion(&priv->station_info_available);
+	init_completion(&priv->regdom_updated);
+	INIT_WORK(&priv->event_work, nrf70_event_worker);
+
+	ret = devm_request_threaded_irq(dev, irq_num, NULL, nrf70_irq,
+					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
+					dev_name(dev), mem);
+	if (ret < 0) {
+		dev_err(dev, "Unable to request threaded irq: %d\n", ret);
+		goto err_disable_rpu;
+	}
+
+	priv->tx_desc_bitmap[0] = NRF70_DESC_MASK;
+	priv->tx_desc_bitmap[1] = NRF70_DESC_MASK;
+	INIT_LIST_HEAD(&priv->cookies);
+	INIT_LIST_HEAD(&priv->vifs);
+
+	ret = nrf70_mac_init(mem);
+	if (ret < 0) {
+		dev_err(dev, "Unable to initialize UMAC: %d\n", ret);
+		goto err_disable_rpu;
+	}
+
+	priv->wiphy = wiphy_new(&nrf70_cfg80211_ops, sizeof(*wpriv));
+	if (!priv->wiphy) {
+		dev_err(dev, "Unable to allocate wiphy\n");
+		ret = -ENOMEM;
+		goto err_deinit_rpu;
+	}
+
+	set_wiphy_dev(priv->wiphy, dev);
+	wpriv = wiphy_priv(priv->wiphy);
+	wpriv->priv = priv;
+
+	priv->wiphy->mgmt_stypes = nrf70_default_mgmt_stypes;
+	priv->wiphy->iface_combinations = nrf70_if_comb;
+	priv->wiphy->flags |= WIPHY_FLAG_NETNS_OK | WIPHY_FLAG_4ADDR_AP |
+			      WIPHY_FLAG_4ADDR_STATION |
+			      WIPHY_FLAG_REPORTS_OBSS | WIPHY_FLAG_OFFCHAN_TX |
+			      WIPHY_FLAG_CONTROL_PORT_PROTOCOL |
+			      WIPHY_FLAG_AP_UAPSD;
+
+	priv->wiphy->features |= NL80211_FEATURE_SK_TX_STATUS |
+				 NL80211_FEATURE_SAE |
+				 NL80211_FEATURE_HT_IBSS |
+				 NL80211_FEATURE_MAC_ON_CREATE;
+
+	wiphy_ext_feature_set(priv->wiphy, NL80211_EXT_FEATURE_SET_SCAN_DWELL);
+
+	priv->wiphy->bands[NL80211_BAND_2GHZ] = &nrf70_band_2ghz;
+	priv->wiphy->bands[NL80211_BAND_5GHZ] = &nrf70_band_5ghz;
+	priv->wiphy->signal_type = CFG80211_SIGNAL_TYPE_MBM;
+	priv->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
+				       BIT(NL80211_IFTYPE_AP);
+	if (priv->has_raw_mode)
+		priv->wiphy->interface_modes |= BIT(NL80211_IFTYPE_MONITOR);
+	priv->wiphy->max_scan_ssids = NRF70_SCAN_SSIDS_MAX;
+	priv->wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
+	priv->wiphy->cipher_suites = nrf70_cipher_suites;
+	priv->wiphy->n_cipher_suites = ARRAY_SIZE(nrf70_cipher_suites);
+
+	priv->wiphy->reg_notifier = nrf70_reg_notifier;
+
+	ret = wiphy_register(priv->wiphy);
+	if (ret < 0) {
+		dev_err(dev, "Unable to register wiphy: %d\n", ret);
+		goto err_wiphy;
+	}
+
+	priv->vif_bitmap = NRF70_VIFS_MASK;
+
+	/* Add primary net interface. */
+	vif = nrf70_add_if(priv, "nrf%d", NET_NAME_UNKNOWN,
+			   NL80211_IFTYPE_STATION, NULL, false);
+	if (!IS_ERR(vif))
+		return 0;
+
+	ret = PTR_ERR(vif);
+	wiphy_unregister(priv->wiphy);
+err_wiphy:
+	wiphy_free(priv->wiphy);
+err_deinit_rpu:
+	nrf70_deinit_command(mem);
+err_disable_rpu:
+	nrf70_writel(mem, NRF70_PBUS_CLK, 0x0);
+	if (priv->iovdd_en)
+		gpiod_set_value(priv->iovdd_en, 0);
+	gpiod_set_value(priv->buck_en, 0);
+
+	return ret;
+}
+
+static int nrf70_remove(struct spi_mem *mem)
+{
+	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
+	struct nrf70_cookie *cookie, *tmpc;
+	struct nrf70_vif *vif, *tmpv;
+
+	list_for_each_entry_safe(cookie, tmpc, &priv->cookies, list) {
+		list_del(&cookie->list);
+		kfree(cookie);
+	}
+
+	list_for_each_entry_safe(vif, tmpv, &priv->vifs, list) {
+		nrf70_drain_tx(priv, vif);
+		unregister_netdev(vif->ndev);
+		list_del(&vif->list);
+		kfree(vif);
+	}
+
+	wiphy_unregister(priv->wiphy);
+	wiphy_free(priv->wiphy);
+
+	nrf70_deinit_command(mem);
+	cancel_work_sync(&priv->event_work);
+
+	/* Power off RPU. */
+	nrf70_writel(mem, NRF70_PBUS_CLK, 0x0);
+	if (priv->iovdd_en)
+		gpiod_set_value(priv->iovdd_en, 0);
+	gpiod_set_value(priv->buck_en, 0);
+
+	return 0;
+}
+
+static const struct of_device_id nrf70_of_match_table[] = {
+	{ .compatible = "nordic,nrf70" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, nrf70_of_match_table);
+
+static struct spi_mem_driver nrf70_driver = {
+	.spidrv = {
+		.driver = {
+			.name = "nrf70",
+			.of_match_table = nrf70_of_match_table,
+		},
+	},
+	.probe = nrf70_probe,
+	.remove = nrf70_remove,
+};
+
+module_spi_mem_driver(nrf70_driver);
+MODULE_DESCRIPTION("Nordic Semiconductor nRF70 series wireless companion IC");
+MODULE_AUTHOR("Artur Rojek <artur@conclusive.tech>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/wireless/nordic/nrf70_cmds.h b/drivers/net/wireless/nordic/nrf70_cmds.h
new file mode 100644
index 000000000000..d996c0a14676
--- /dev/null
+++ b/drivers/net/wireless/nordic/nrf70_cmds.h
@@ -0,0 +1,1051 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Conclusive Engineering Sp. z o. o.
+ */
+
+#ifndef _NRF70_CMDS_H
+#define _NRF70_CMDS_H
+
+#include <linux/if_ether.h>
+#include <net/cfg80211.h>
+
+enum nrf70_sys_cmds {
+	NRF70_CMD_INIT,
+	NRF70_CMD_TX,
+	NRF70_CMD_IF_TYPE,
+	NRF70_CMD_MODE,
+	NRF70_CMD_GET_STATS,
+	NRF70_CMD_CLEAR_STATS,
+	NRF70_CMD_RX,
+	NRF70_CMD_PWR,
+	NRF70_CMD_DEINIT,
+	NRF70_CMD_BTCOEX,
+	NRF70_CMD_RF_TEST,
+	NRF70_CMD_HE_GI_LTF_CONFIG,
+	NRF70_CMD_UMAC_INT_STATS,
+	NRF70_CMD_RADIO_TEST_INIT,
+	NRF70_CMD_RT_REQ_SET_REG,
+	NRF70_CMD_TX_FIX_DATA_RATE,
+	NRF70_CMD_CHANNEL,
+	NRF70_CMD_RAW_CONFIG_MODE,
+	NRF70_CMD_RAW_CONFIG_FILTER,
+	NRF70_CMD_RAW_TX_PKT,
+	NRF70_CMD_RESET_STATISTICS,
+	NRF70_CMD_MAX
+};
+
+/* Data commands and events share the same enums. */
+enum nrf70_data_cmds {
+	NRF70_CMD_MGMT_BUFF_CONFIG,
+	NRF70_CMD_TX_BUFF,
+	NRF70_CMD_TX_BUFF_DONE,
+	NRF70_CMD_RX_BUFF,
+	NRF70_CMD_CARRIER_ON,
+	NRF70_CMD_CARRIER_OFF,
+	NRF70_CMD_PM_MODE,
+	NRF70_CMD_PS_GET_FRAMES,
+};
+
+enum nrf70_umac_cmds {
+	NRF70_UMAC_CMD_TRIGGER_SCAN,
+	NRF70_UMAC_CMD_GET_SCAN_RESULTS,
+	NRF70_UMAC_CMD_AUTHENTICATE,
+	NRF70_UMAC_CMD_ASSOCIATE,
+	NRF70_UMAC_CMD_DEAUTHENTICATE,
+	NRF70_UMAC_CMD_SET_WIPHY,
+	NRF70_UMAC_CMD_NEW_KEY,
+	NRF70_UMAC_CMD_DEL_KEY,
+	NRF70_UMAC_CMD_SET_KEY,
+	NRF70_UMAC_CMD_GET_KEY,
+	NRF70_UMAC_CMD_NEW_BEACON,
+	NRF70_UMAC_CMD_SET_BEACON,
+	NRF70_UMAC_CMD_SET_BSS,
+	NRF70_UMAC_CMD_START_AP,
+	NRF70_UMAC_CMD_STOP_AP,
+	NRF70_UMAC_CMD_NEW_INTERFACE,
+	NRF70_UMAC_CMD_SET_INTERFACE,
+	NRF70_UMAC_CMD_DEL_INTERFACE,
+	NRF70_UMAC_CMD_SET_IFFLAGS,
+	NRF70_UMAC_CMD_NEW_STATION,
+	NRF70_UMAC_CMD_DEL_STATION,
+	NRF70_UMAC_CMD_SET_STATION,
+	NRF70_UMAC_CMD_GET_STATION,
+	NRF70_UMAC_CMD_START_P2P_DEVICE,
+	NRF70_UMAC_CMD_STOP_P2P_DEVICE,
+	NRF70_UMAC_CMD_REMAIN_ON_CHANNEL,
+	NRF70_UMAC_CMD_CANCEL_REMAIN_ON_CHANNEL,
+	NRF70_UMAC_CMD_SET_CHANNEL,
+	NRF70_UMAC_CMD_RADAR_DETECT,
+	NRF70_UMAC_CMD_REGISTER_FRAME,
+	NRF70_UMAC_CMD_FRAME,
+	NRF70_UMAC_CMD_JOIN_IBSS,
+	NRF70_UMAC_CMD_WIN_STA_CONNECT,
+	NRF70_UMAC_CMD_SET_POWER_SAVE,
+	NRF70_UMAC_CMD_SET_WOWLAN,
+	NRF70_UMAC_CMD_SUSPEND,
+	NRF70_UMAC_CMD_RESUME,
+	NRF70_UMAC_CMD_SET_QOS_MAP,
+	NRF70_UMAC_CMD_GET_CHANNEL,
+	NRF70_UMAC_CMD_GET_TX_POWER,
+	NRF70_UMAC_CMD_GET_INTERFACE,
+	NRF70_UMAC_CMD_GET_WIPHY,
+	NRF70_UMAC_CMD_GET_IFHWADDR,
+	NRF70_UMAC_CMD_SET_IFHWADDR,
+	NRF70_UMAC_CMD_GET_REG,
+	NRF70_UMAC_CMD_SET_REG,
+	NRF70_UMAC_CMD_REQ_SET_REG,
+	NRF70_UMAC_CMD_CONFIG_UAPSD,
+	NRF70_UMAC_CMD_CONFIG_TWT,
+	NRF70_UMAC_CMD_TEARDOWN_TWT,
+	NRF70_UMAC_CMD_ABORT_SCAN,
+	NRF70_UMAC_CMD_MCAST_FILTER,
+	NRF70_UMAC_CMD_CHANGE_MACADDR,
+	NRF70_UMAC_CMD_SET_POWER_SAVE_TIMEOUT,
+	NRF70_UMAC_CMD_GET_CONNECTION_INFO,
+	NRF70_UMAC_CMD_GET_POWER_SAVE_INFO,
+	NRF70_UMAC_CMD_SET_LISTEN_INTERVAL,
+	NRF70_UMAC_CMD_CONFIG_EXTENDED_PS,
+	NRF70_UMAC_CMD_CONFIG_QUIET_PERIOD,
+};
+
+enum nrf70_sys_events {
+	NRF70_EVENT_PWR_DATA,
+	NRF70_EVENT_INIT_DONE,
+	NRF70_EVENT_STATS,
+	NRF70_EVENT_DEINIT_DONE,
+	NRF70_EVENT_RF_TEST,
+	NRF70_EVENT_COEX_CONFIG,
+	NRF70_EVENT_INT_UMAC_STATS,
+	NRF70_EVENT_RADIOCMD_STATUS,
+	NRF70_EVENT_CHANNEL_SET_DONE,
+	NRF70_EVENT_MODE_SET_DONE,
+	NRF70_EVENT_FILTER_SET_DONE,
+	NRF70_EVENT_RAW_TX_DONE,
+};
+
+enum nrf70_umac_events {
+	NRF70_UMAC_EVENT_UNSPECIFIED = 256,
+	NRF70_UMAC_EVENT_TRIGGER_SCAN_START,
+	NRF70_UMAC_EVENT_SCAN_ABORTED,
+	NRF70_UMAC_EVENT_SCAN_DONE,
+	NRF70_UMAC_EVENT_SCAN_RESULT,
+	NRF70_UMAC_EVENT_AUTHENTICATE,
+	NRF70_UMAC_EVENT_ASSOCIATE,
+	NRF70_UMAC_EVENT_CONNECT,
+	NRF70_UMAC_EVENT_DEAUTHENTICATE,
+	NRF70_UMAC_EVENT_DISASSOCIATE,
+	NRF70_UMAC_EVENT_NEW_STATION,
+	NRF70_UMAC_EVENT_DEL_STATION,
+	NRF70_UMAC_EVENT_GET_STATION,
+	NRF70_UMAC_EVENT_REMAIN_ON_CHANNEL,
+	NRF70_UMAC_EVENT_CANCEL_REMAIN_ON_CHANNEL,
+	NRF70_UMAC_EVENT_DISCONNECT,
+	NRF70_UMAC_EVENT_FRAME,
+	NRF70_UMAC_EVENT_COOKIE_RESP,
+	NRF70_UMAC_EVENT_FRAME_TX_STATUS,
+	NRF70_UMAC_EVENT_IFFLAGS_STATUS,
+	NRF70_UMAC_EVENT_GET_TX_POWER,
+	NRF70_UMAC_EVENT_GET_CHANNEL,
+	NRF70_UMAC_EVENT_SET_INTERFACE,
+	NRF70_UMAC_EVENT_UNPROT_DEAUTHENTICATE,
+	NRF70_UMAC_EVENT_UNPROT_DISASSOCIATE,
+	NRF70_UMAC_EVENT_NEW_INTERFACE,
+	NRF70_UMAC_EVENT_NEW_WIPHY,
+	NRF70_UMAC_EVENT_GET_IFHWADDR,
+	NRF70_UMAC_EVENT_GET_REG,
+	NRF70_UMAC_EVENT_SET_REG,
+	NRF70_UMAC_EVENT_REQ_SET_REG,
+	NRF70_UMAC_EVENT_GET_KEY,
+	NRF70_UMAC_EVENT_BEACON_HINT,
+	NRF70_UMAC_EVENT_REG_CHANGE,
+	NRF70_UMAC_EVENT_WIPHY_REG_CHANGE,
+	NRF70_UMAC_EVENT_SCAN_DISPLAY_RESULT,
+	NRF70_UMAC_EVENT_CMD_STATUS,
+	NRF70_UMAC_EVENT_BSS_INFO,
+	NRF70_UMAC_EVENT_CONFIG_TWT,
+	NRF70_UMAC_EVENT_TEARDOWN_TWT,
+	NRF70_UMAC_EVENT_TWT_SLEEP,
+	NRF70_UMAC_EVENT_COALESCING,
+	NRF70_UMAC_EVENT_MCAST_FILTER,
+	NRF70_UMAC_EVENT_GET_CONNECTION_INFO,
+	NRF70_UMAC_EVENT_GET_POWER_SAVE_INFO
+};
+
+#define	NRF70_MSG_SYSTEM		0
+#define	NRF70_MSG_DATA			2
+#define	NRF70_MSG_UMAC			3
+
+struct __packed nrf70_msg {
+	u32 len;
+	u32 resubmit;
+	u32 type;
+	u8 data[];
+};
+
+struct __packed nrf70_header {
+	u32 id;
+	u32 len;
+};
+
+#define	NRF70_UMAC_ID_WDEV		BIT(0)
+struct __packed nrf70_umac_header {
+	u32 portid;	/* unused */
+	u32 seq;	/* used only for EVENT_SCAN_DISPLAY_RESULT */
+	u32 id;
+	s32 ret_val;	/* unused */
+	struct __packed {
+		u32 valid_fields;
+		s32 iface_id;	/* unused */
+		s32 wiphy_id;	/* unused */
+		u64 wdev_id;
+	} idx;
+};
+
+/* System commands. */
+#define	NRF70_RF_PARAMS_SZ		200
+#define	NRF70_RX_QUEUE_CNT		3
+#define	NRF70_COUNTRY_CODE_LEN		2
+#define	NRF70_OP_BAND_ALL		0
+#define	NRF70_OP_BAND_2G		1
+struct __packed nrf70_cmd_sys_init {
+	struct nrf70_header header;
+	u32 dev_id;
+	struct __packed {
+		u32 sleep_enable;
+		u32 hw_bringup_time;
+		u32 sw_bringup_time;
+		u32 bcn_time_out;
+		u32 calib_sleep_clk;
+		u32 phy_calib;
+		u8 hwaddr[ETH_ALEN];
+		u8 rf_params[NRF70_RF_PARAMS_SZ];
+		u8 rf_params_valid;
+	} sys_param;
+	struct __packed {
+		u16 size;
+		u16 count;
+	} rx_buf_pools[NRF70_RX_QUEUE_CNT];
+	struct __packed {
+		u8 rate_protection_type;
+		u8 aggregation;
+		u8 wmm;
+		u8 max_tx_agg_sessions;
+		u8 max_rx_agg_sessions;
+		u8 max_tx_aggregation;
+		u8 reorder_buf_size;
+		u32 max_rxampdu_size;
+	} data_config_params;
+	struct __packed {
+		u32 temp_based_calib_en;
+		u32 temp_calib_bitmap;
+		u32 vbat_calibp_bitmap;
+		u32 temp_vbat_mon_period;
+		s32 vth_very_low;
+		s32 vth_low;
+		s32 vth_hi;
+		s32 temp_threshold;
+		s32 vbat_threshold;
+	} vbat_config;
+	u8 tcp_ip_checksum_offload;
+	u8 country_code[NRF70_COUNTRY_CODE_LEN];
+	u32 op_band;
+	u8 mgmt_buff_offload;
+	u32 feature_flags;
+	u32 disable_beamforming;
+	u32 discon_timeout;
+	u8 ps_data_retrieval_mech;
+};
+
+#define	NRF70_OP_MODE_STA		BIT(0)
+#define	NRF70_OP_MODE_MONITOR		BIT(1)
+#define	NRF70_OP_MODE_AP		BIT(4)
+struct __packed nrf70_cmd_raw_config_mode {
+	struct nrf70_header header;
+	u8 if_idx;
+	u8 mode;
+};
+
+struct __packed nrf70_event_raw_config_mode {
+	struct nrf70_header header;
+	u8 if_idx;
+	u8 mode;
+	s32 status;
+};
+
+struct __packed nrf70_cmd_set_channel {
+	struct nrf70_header header;
+	u8 if_idx;
+	struct __packed {
+		u32 primary_num;
+		u8 bandwidth;
+		s32 sec_20_offset;
+		s32 sec_40_offset;
+	} chan;
+};
+
+struct __packed nrf70_event_set_channel {
+	struct nrf70_header header;
+	u8 if_idx;
+	u32 chan;
+	s32 status;
+};
+
+#define	NRF70_OP_MODE_PRODUCTION	0
+struct __packed nrf70_cmd_get_stats {
+	struct nrf70_header header;
+	u32 stats_type;
+	u32 op_mode;
+};
+
+/* Data commands/events. */
+#define	NRF70_BUF_TIMESTAMP_SZ		6
+struct __packed nrf70_cmd_rx_buf {
+	struct nrf70_header header;
+	s16 rx_pkt_type;
+	u8 rate_flags;
+	u8 rate;
+	u8 wdev_id;
+	u8 rx_pkt_cnt;
+	u8 reserved;
+	u8 mac_header_len;
+	u16 frequency;
+	s16 signal;
+	struct __packed {
+		u16 desc_id;
+		u16 pkt_len;
+		u8 pkt_type;
+		u8 timestamp_rec[NRF70_BUF_TIMESTAMP_SZ];
+		u8 timestamp_ack[NRF70_BUF_TIMESTAMP_SZ];
+	} buf_info[];
+};
+
+#define	NRF70_SAP_PM_CLIENT_ACTIVE	0
+#define	NRF70_SAP_PM_CLIENT_PS_MODE	1
+struct __packed nrf70_cmd_sap_pm {
+	struct nrf70_header header;
+	u32 wdev_id;
+	u8 state;
+	u8 hwaddr[ETH_ALEN];
+};
+
+struct __packed nrf70_buf_info {
+	u16 pkt_len;
+	u32 ddr_ptr;
+};
+
+#define	NRF70_TX_QOS_MASK		0xffff
+#define	NRF70_TX_FLAG_CSUM_AVAIL	BIT(30)
+#define	NRF70_TX_FLAG_TWT_EMERG		BIT(31)
+struct __packed nrf70_cmd_tx_buf {
+	struct nrf70_header header;
+	u8 wdev_id;
+	u8 tx_desc_num;
+	struct __packed {
+		s32 umac_fill_flags;
+		u16 fc;
+		u8 dst[ETH_ALEN];
+		u8 src[ETH_ALEN];
+		u16 etype;
+		u32 tx_flags;
+		u8 more_data;
+		u8 eosp;
+	} mac_hdr_info;
+	u32 pending_buf_size;
+	u8 num_tx_pkts;
+	struct nrf70_buf_info buf_info[];
+};
+
+struct __packed nrf70_event_tx_buff_done {
+	struct nrf70_header header;
+	u8 tx_desc_num;
+	u8 num_tx_status_code;
+	u8 timestamp_sent[NRF70_BUF_TIMESTAMP_SZ];
+	u8 timestamp_rec[NRF70_BUF_TIMESTAMP_SZ];
+	u8 tx_status_code[];
+};
+
+struct __packed nrf70_event_carrier_state {
+	struct nrf70_header header;
+	u32 wdev_id;
+};
+
+/* UMAC commands/events. */
+#define NRF70_SSID_SZ			32
+struct __packed nrf70_ssid {
+	u8 len;
+	u8 ssid[NRF70_SSID_SZ];
+};
+
+#define NRF70_IE_SZ			400
+struct __packed nrf70_ie {
+	u16 len;
+	s8 ie[NRF70_IE_SZ];
+};
+
+#define	NRF70_FRAME_SZ			400
+struct __packed nrf70_frame {
+	s32 len;
+	s8 data[NRF70_FRAME_SZ];
+};
+
+#define	NRF70_SCAN_REASON_DISPLAY	0
+#define	NRF70_SCAN_REASON_CONNECT	1
+#define	NRF70_SCAN_BAND_ANY		0
+#define	NRF70_SCAN_BAND_2GHZ		BIT(0)
+#define	NRF70_SCAN_BAND_5GHZ		BIT(1)
+struct __packed nrf70_cmd_scan {
+	struct nrf70_umac_header header;
+	struct __packed {
+		s32 reason;
+		u16 passive_scan;
+		u8 num_scan_ssids;
+		struct nrf70_ssid scan_ssids[2];
+		u8 no_cck;
+		u8 bands;
+		struct nrf70_ie ie;
+		u8 hwaddr[ETH_ALEN];
+		u16 dwell_time_active;
+		u16 dwell_time_passive;
+		u16 num_scan_channels;
+		u8 skip_local_admin_macs;
+		u32 center_freq[];
+	} scan_info;
+};
+
+struct __packed nrf70_event_cmd_status {
+	struct nrf70_umac_header header;
+	u32 cmd_id;
+	s32 status;
+};
+
+struct __packed nrf70_cmd_change_hwaddr {
+	struct nrf70_umac_header header;
+	u8 hwaddr[ETH_ALEN];
+};
+
+struct __packed nrf70_cmd_get_scan_results {
+	struct nrf70_umac_header header;
+	s32 reason;
+};
+
+struct __packed nrf70_cmd_chg_vif_state {
+	struct nrf70_umac_header header;
+	struct __packed {
+		u32 state;
+		s8 if_idx;
+	} info;
+};
+
+#define	NRF70_CHG_VIF_IFTYPE			BIT(0)
+#define	NRF70_CHG_VIF_USE_4ADDR			BIT(1)
+struct __packed nrf70_cmd_chg_vif_attr {
+	struct nrf70_umac_header header;
+	u32 valid_fields;
+	struct __packed {
+		s32 iftype;
+		s32 use_4addr;
+	} info;
+};
+
+#define	NRF70_ADD_VIF_USE_4ADDR			BIT(0)
+#define	NRF70_ADD_VIF_HWADDR			BIT(1)
+#define	NRF70_ADD_VIF_IFTYPE			BIT(2)
+#define	NRF70_ADD_VIF_IFNAME			BIT(3)
+struct __packed nrf70_cmd_add_vif {
+	struct nrf70_umac_header header;
+	u32 valid_fields;
+	struct __packed {
+		s32 iftype;
+		s32 use_4addr;
+		u32 mon_flags;
+		u8 hwaddr[ETH_ALEN];
+		s8 ifacename[IFNAMSIZ];
+	} info;
+};
+
+#define	NRF70_FRAME_MATCH_MAX_LEN	8
+struct __packed nrf70_cmd_mgmt_frame_reg {
+	struct nrf70_umac_header header;
+	struct __packed {
+		u16 type;
+		u32 match_len;
+		u8 match[NRF70_FRAME_MATCH_MAX_LEN];
+	} info;
+};
+
+#define	NRF70_KEY_INFO_KEY_SZ			256
+#define	NRF70_KEY_INFO_SEQ_SZ			256
+#define	NRF70_KEY_INFO_FLAG_DEFAULT		BIT(0)
+#define	NRF70_KEY_INFO_FLAG_DEFAULT_MGMT	BIT(2)
+#define	NRF70_KEY_INFO_FLAG_DEFAULT_UNICAST	BIT(3)
+#define	NRF70_KEY_INFO_FLAG_DEFAULT_MULTICAST	BIT(4)
+#define	NRF70_KEY_INFO_KEY			BIT(0)
+#define	NRF70_KEY_INFO_KEY_TYPE			BIT(1)
+#define	NRF70_KEY_INFO_KEY_IDX			BIT(2)
+#define	NRF70_KEY_INFO_SEQ			BIT(3)
+#define	NRF70_KEY_INFO_CIPHER_SUITE		BIT(4)
+#define	NRF70_KEY_INFO_KEY_INFO			BIT(5)
+struct __packed nrf70_key_info {
+	u32 valid_fields;
+	u32 cipher_suite;
+	u16 wifi_flags;
+	struct __packed {
+		s32 type;
+		u32 len;
+		u8 data[NRF70_KEY_INFO_KEY_SZ];
+	} key;
+	struct __packed {
+		s32 len;
+		u8 data[NRF70_KEY_INFO_SEQ_SZ];
+	} seq;
+	u8 key_idx;
+};
+
+#define	NRF70_KEY_HWADDR		BIT(0)
+struct __packed nrf70_cmd_key {
+	struct nrf70_umac_header header;
+	u32 valid_fields;
+	struct nrf70_key_info info;
+	u8 hwaddr[ETH_ALEN];
+};
+
+struct __packed nrf70_cmd_set_key {
+	struct nrf70_umac_header header;
+	struct nrf70_key_info info;
+};
+
+#define	NRF70_AUTHTYPE_OPEN_SYSTEM	0
+#define	NRF70_AUTHTYPE_SHARED_KEY	1
+#define	NRF70_AUTHTYPE_FT		2
+#define	NRF70_AUTHTYPE_NETWORK_EAP	3
+#define	NRF70_AUTHTYPE_SAE		4
+#define	NRF70_AUTHTYPE_AUTOMATIC	7
+
+#define	NRF70_AUTH_INFO_SAE_SZ		256
+#define	NRF70_AUTH_KEY_INFO		BIT(0)
+#define	NRF70_AUTH_BSSID		BIT(1)
+#define	NRF70_AUTH_FREQ			BIT(2)
+#define	NRF70_AUTH_SSID			BIT(3)
+#define	NRF70_AUTH_IE			BIT(4)
+#define	NRF70_AUTH_SAE			BIT(5)
+struct __packed nrf70_cmd_auth {
+	struct nrf70_umac_header header;
+	u32 valid_fields;
+	struct __packed {
+		u32 frequency;
+		u16 wifi_flags;
+		s32 auth_type;
+		struct nrf70_key_info key_info;
+		struct nrf70_ssid ssid;
+		struct nrf70_ie ie;
+		struct __packed {
+			s32 len;
+			u8 data[NRF70_AUTH_INFO_SAE_SZ];
+		} sae;
+		u8 bssid[ETH_ALEN];
+		s32 scan_width;
+		s32 signal;
+		s32 from_beacon;
+		struct nrf70_ie bss_ie;
+		u16 capability;
+		u16 beacon_interval;
+		u64 tsf;
+	} info;
+};
+
+#define	NRF70_CONNECT_HWADDR			BIT(0)
+#define	NRF70_CONNECT_FREQ			BIT(2)
+#define	NRF70_CONNECT_SSID			BIT(5)
+#define	NRF70_CONNECT_WPA_IE			BIT(6)
+#define	NRF70_CONNECT_WPA_VERSIONS		BIT(7)
+#define	NRF70_CONNECT_CIPHER_PAIRWISE		BIT(8)
+#define	NRF70_CONNECT_CIPHER_GROUP		BIT(9)
+#define	NRF70_CONNECT_AKM_SUITES		BIT(10)
+#define	NRF70_CONNECT_MFP			BIT(11)
+#define	NRF70_CONNECT_CONTROL_PORT_ETHER_TYPE	BIT(12)
+#define	NRF70_CONNECT_CONTROL_PORT_NO_ENCRYPT	BIT(13)
+#define	NRF70_CONNECT_FLAGS_USE_RRM		BIT(14)
+#define	NRF70_HT_VHT_CAP_MAX_SZ			256
+struct __packed nrf70_connect_info {
+	u32 valid_fields;
+	u32 frequency;
+	u32 freq_hint;
+	u32 wpa_versions;
+	s32 num_cipher_suites_pairwise;
+	u32 cipher_suites_pairwise[7];
+	u32 cipher_suite_group;
+	u32 num_akm_suites;
+	u32 akm_suites[2];
+	s32 use_mfp;
+	u32 wifi_flags;
+	u16 bg_scan_period;
+	u8 hwaddr[ETH_ALEN];
+	u8 hwaddr_hint[ETH_ALEN];
+	struct nrf70_ssid ssid;
+	struct nrf70_ie wpa_ie;
+	struct __packed {
+		u32 valid_fields;
+		u16 flags;
+		u8 ht_capa[NRF70_HT_VHT_CAP_MAX_SZ];
+		u8 ht_capa_mask[NRF70_HT_VHT_CAP_MAX_SZ];
+		u8 vht_capa[NRF70_HT_VHT_CAP_MAX_SZ];
+		u8 vht_capa_mask[NRF70_HT_VHT_CAP_MAX_SZ];
+	} ht_vht_cap;
+	u16 control_port_ethertype;
+	u8 control_port_no_encrypt;
+	s8 control_port;
+	u8 prev_bssid[ETH_ALEN];
+	u16 maxidle_insec;
+};
+
+struct __packed nrf70_cmd_assoc {
+	struct nrf70_umac_header header;
+	u32 valid_fields;
+	struct nrf70_connect_info info;
+	u8 hwaddr[ETH_ALEN];
+};
+
+#define	NRF70_DISCONN_FLAGS_LOCAL_STATE_CHANGE	BIT(0)
+#define	NRF70_DISCONN_HWADDR			BIT(0)
+struct __packed nrf70_cmd_disconn {
+	struct nrf70_umac_header header;
+	u32 valid_fields;
+	struct __packed {
+		u16 flags;
+		u16 reason;
+		u8 hwaddr[ETH_ALEN];
+	} info;
+};
+
+#define	NRF70_FREQ_PARAMS_FREQ		BIT(0)
+#define	NRF70_FREQ_PARAMS_CHAN_WIDTH	BIT(1)
+#define	NRF70_FREQ_PARAMS_CENTER_FREQ1	BIT(2)
+#define	NRF70_FREQ_PARAMS_CENTER_FREQ2	BIT(3)
+#define	NRF70_FREQ_PARAMS_CHAN_TYPE	BIT(4)
+#define	NRF70_CHAN_NO_HT	0
+#define	NRF70_CHAN_HT20		1
+#define	NRF70_CHAN_HT40MINUS	2
+#define	NRF70_CHAN_HT40PLUS	3
+struct __packed nrf70_freq_params {
+	u32 valid_fields;
+	s32 frequency;
+	s32 channel_width;
+	s32 center_freq1;
+	s32 center_freq2;
+	s32 channel_type;
+};
+
+#define	NRF70_MGMT_TX_FREQ			BIT(0)
+#define	NRF70_MGMT_TX_DURATION			BIT(1)
+#define	NRF70_MGMT_TX_SET_FRAME_FREQ		BIT(2)
+#define	NRF70_MGMT_TX_FLAGS_OFFCHAN_TX		BIT(0)
+#define	NRF70_MGMT_TX_FLAGS_NO_CCK_RATE		BIT(1)
+#define	NRF70_MGMT_TX_FLAGS_NO_ACK		BIT(2)
+#define	NRF70_MGMT_TX_FREQ_MASK			GENMASK(4, 0)
+struct __packed nrf70_cmd_mgmt_tx {
+	struct nrf70_umac_header header;
+	u32 valid_fields;
+	struct __packed {
+		u32 wifi_flags;
+		u32 frequency;
+		u32 dur;
+		struct nrf70_frame frame;
+		struct nrf70_freq_params freq_params;
+		u64 cookie;
+	} info;
+};
+
+struct __packed nrf70_sta_flag_update {
+	u32 mask;
+	u32 set;
+};
+
+#define	NRF70_CHG_STA_SUPP_RATES		BIT(0)
+#define	NRF70_CHG_STA_AID			BIT(1)
+#define	NRF70_CHG_STA_STA_CAPAB			BIT(3)
+#define	NRF70_CHG_STA_EXT_CAPAB			BIT(4)
+#define	NRF70_CHG_STA_HT_CAP			BIT(6)
+#define	NRF70_CHG_STA_VHT_CAP			BIT(7)
+#define	NRF70_CHG_STA_OPMODE_NOTIF		BIT(9)
+#define	NRF70_CHG_STA_SUP_CHANS			BIT(10)
+#define	NRF70_CHG_STA_OPER_CLASSES		BIT(11)
+#define	NRF70_CHG_STA_FLAGS2			BIT(12)
+#define	NRF70_CHG_STA_WME_UAPSD_QUEUES		BIT(13)
+#define	NRF70_CHG_STA_WME_MAX_SP		BIT(14)
+#define	NRF70_CHG_STA_LISTEN_INTERVAL		BIT(15)
+struct __packed nrf70_cmd_chg_sta {
+	struct nrf70_umac_header header;
+	u32 valid_fields;
+	s32 listen_interval;
+	u32 sta_vlan;
+	u16 aid;
+	u16 peer_aid;
+	u16 sta_capability;
+	u16 spare;
+	struct __packed {
+		u32 valid_fields;
+		s32 band;
+		s32 num_rates;
+		u8 rates[60];
+	} supp_rates;
+	u32 ext_cap_len;
+	u8 ext_cap[32];
+	u32 sup_chans_len;
+	u8 sup_chans[64];
+	u32 sup_oper_classes_len;
+	u8 sup_oper_classes[64];
+	struct nrf70_sta_flag_update sta_flags2;
+	u8 ht_cap[NRF70_HT_VHT_CAP_MAX_SZ];
+	u8 vht_cap[NRF70_HT_VHT_CAP_MAX_SZ];
+	u8 hwaddr[ETH_ALEN];
+	u8 opmode_notif;
+	u8 wme_uapsd_queues;
+	u8 wme_max_sp;
+};
+
+#define	NRF70_DEL_STA_HWADDR			BIT(0)
+#define	NRF70_DEL_STA_MGMT_SUBTYPE		BIT(1)
+#define	NRF70_DEL_STA_REASON			BIT(2)
+struct __packed nrf70_cmd_del_sta {
+	struct nrf70_umac_header header;
+	u32 valid_fields;
+	u8 hwaddr[ETH_ALEN];
+	u8 mgmt_subtype;
+	u16 reason;
+};
+
+struct __packed nrf70_wiphy_info {
+	u32 rts_threshold;
+	u32 frag_threshold;
+	u32 antenna_tx;
+	u32 antenna_rx;
+	struct nrf70_freq_params freq_params;
+	struct __packed {
+		u16 toxp;
+		u16 cwmin;
+		u16 cwmax;
+		u8 aifs;
+		u8 ac;
+	} txq_params;
+	struct __packed {
+		u32 valid_fields;
+		s32 type;
+		s32 power_level;
+	} tx_power_settings;
+	u8 retry_short;
+	u8 retry_long;
+	u8 coverage_class;
+	s8 wiphy_name[32];
+};
+
+#define	NRF70_SET_WIPHY_FREQ			BIT(0)
+#define	NRF70_SET_WIPHY_RTS_THRESHOLD		BIT(2)
+#define	NRF70_SET_WIPHY_FRAG_THRESHOLD		BIT(3)
+#define	NRF70_SET_WIPHY_RETRY_SHORT		BIT(7)
+#define	NRF70_SET_WIPHY_RETRY_LONG		BIT(8)
+#define	NRF70_SET_WIPHY_COVERAGE_CLASS		BIT(9)
+struct __packed nrf70_cmd_set_wiphy {
+	struct nrf70_umac_header header;
+	u32 valid_fields;
+	struct nrf70_wiphy_info info;
+};
+
+#define	NRF70_BEACON_DATA_MAX_HEAD_LEN		256
+#define	NRF70_BEACON_DATA_MAX_TAIL_LEN		512
+#define	NRF70_BEACON_DATA_MAX_PROBE_RESP_LEN	400
+struct __packed nrf70_beacon_data {
+	u32 head_len;
+	u32 tail_len;
+	u32 probe_resp_len;
+	u8 head[NRF70_BEACON_DATA_MAX_HEAD_LEN];
+	u8 tail[NRF70_BEACON_DATA_MAX_TAIL_LEN];
+	u8 probe_resp[NRF70_BEACON_DATA_MAX_PROBE_RESP_LEN];
+};
+
+#define	NRF70_SET_BSS_CTS			BIT(0)
+#define	NRF70_SET_BSS_PREAMBLE			BIT(1)
+#define	NRF70_SET_BSS_SLOT			BIT(2)
+#define	NRF70_SET_BSS_HT_OPMODE			BIT(3)
+#define	NRF70_SET_BSS_AP_ISOLATE		BIT(4)
+#define	NRF70_SET_BSS_P2P_CTWINDOW		BIT(5)
+#define	NRF70_SET_BSS_P2P_OPPPS			BIT(6)
+#define	NRF70_BSS_INFO_MAX_BASIC_RATES		32
+struct __packed nrf70_cmd_set_bss {
+	struct nrf70_umac_header header;
+	u32 valid_fields;
+	struct __packed {
+		u32 p2p_go_ctwindow;
+		u32 p2p_opp_ps;
+		u32 num_basic_rates;
+		u16 ht_opmode;
+		u8 cts;
+		u8 preamble;
+		u8 slot;
+		u8 ap_isolate;
+		u8 basic_rates[NRF70_BSS_INFO_MAX_BASIC_RATES];
+	} info;
+};
+
+#define	NRF70_START_AP_BEACON_INTERVAL		BIT(0)
+#define	NRF70_START_AP_AUTH_TYPE		BIT(1)
+#define	NRF70_START_AP_VERSIONS			BIT(2)
+#define	NRF70_START_AP_CIPHER_SUITE_GROUP	BIT(3)
+#define	NRF70_START_AP_INACTIVITY_TIMEOUT	BIT(4)
+#define	NRF70_START_AP_FREQ_PARAMS		BIT(5)
+#define	NRF70_START_AP_FLAG_PRIVACY		BIT(0)
+#define	NRF70_START_AP_FLAG_NO_ENCRYPT		BIT(1)
+#define	NRF70_START_AP_FLAG_P2P_CTWINDOW	BIT(6)
+#define	NRF70_START_AP_FLAG_P2P_OPPPS		BIT(7)
+struct __packed nrf70_cmd_start_ap {
+	struct nrf70_umac_header header;
+	u32 valid_fields;
+	struct __packed {
+		u16 beacon_interval;
+		u8 dtim_period;
+		s32 hidden_ssid;
+		s32 auth_type;
+		s32 smps_mode;
+		u32 flags;
+		struct nrf70_beacon_data beacon_data;
+		struct nrf70_ssid ssid;
+		struct nrf70_connect_info connect_info;
+		struct nrf70_freq_params freq_params;
+		u16 inactivity_timeout;
+		u8 p2p_go_ctwindow;
+		u8 p2p_opp_ps;
+	} info;
+};
+
+struct __packed nrf70_cmd_set_beacon {
+	struct nrf70_umac_header header;
+	struct nrf70_beacon_data beacon_data;
+};
+
+struct __packed nrf70_cmd_get_sta {
+	struct nrf70_umac_header header;
+	u8 hwaddr[ETH_ALEN];
+};
+
+struct __packed nrf70_cmd_set_qos_map {
+	struct nrf70_umac_header header;
+	struct __packed {
+		u32 len;
+		u8 data[256];
+	} map_info;
+};
+
+struct __packed nrf70_display_results {
+	struct nrf70_ssid ssid;
+	u8 hwaddr[ETH_ALEN];
+	s32 band;
+	u32 chan;
+	u8 protocol_flags;
+	s32 security_type;
+	u16 beacon_interval;
+	u16 capability;
+	struct __packed {
+		u32 type;
+		union __packed {
+			u32 mbm_signal;
+			u8 unspec_signal;
+		};
+	} signal;
+	u8 reserved[4];
+};
+
+#define	NRF70_DISP_SCAN_RES_SZ			8
+struct __packed nrf70_event_scan_display_results {
+	struct nrf70_umac_header header;
+	u8 bss_count;
+	struct nrf70_display_results results[NRF70_DISP_SCAN_RES_SZ];
+};
+
+struct __packed nrf70_event_scan_done {
+	struct nrf70_umac_header header;
+	u32 status;
+	u32 scan_type;
+};
+
+struct __packed nrf70_event_get_reg {
+	struct nrf70_umac_header header;
+	u8 alpha2[NRF70_COUNTRY_CODE_LEN];
+	u32 num_chans;
+	struct __packed {
+		u32 center_freq;
+		u32 max_power;
+		u8 supported;
+		u8 passive_channel;
+		u8 dfs;
+	} chan_info[];
+};
+
+#define	NRF70_EVENT_MLME_TIMED_OUT		BIT(0)
+#define	NRF70_EVENT_MLME_ACK			BIT(1)
+struct __packed nrf70_event_mlme {
+	struct nrf70_umac_header header;
+	u32 valid_fields;
+	u32 frequency;
+	u32 rx_signal_dbm;
+	u32 wifi_flags;
+	u64 cookie;
+	struct nrf70_frame frame;
+	u8 bssid[ETH_ALEN];
+	u8 wme_uapsd_queues;
+	u32 req_ie_len;
+	u8 req_ie[];
+};
+
+struct __packed nrf70_event_iface_update {
+	struct nrf70_umac_header header;
+	s32 status;
+};
+
+struct __packed nrf70_event_cookie_resp {
+	struct nrf70_umac_header header;
+	u32 valid_fields;
+	u64 host_cookie;
+	u64 cookie;
+	u8 hwaddr[ETH_ALEN];
+};
+
+#define	NRF70_RATE_INFO_BITRATE			BIT(0)
+#define	NRF70_RATE_INFO_BITRATE_COMPAT		BIT(1)
+#define	NRF70_RATE_INFO_MCS			BIT(2)
+#define	NRF70_RATE_INFO_VHT_MCS			BIT(3)
+#define	NRF70_RATE_INFO_VHT_NSS			BIT(4)
+
+#define	NRF70_RATE_INFO_0_MHZ_WIDTH		BIT(0)
+#define	NRF70_RATE_INFO_5_MHZ_WIDTH		BIT(1)
+#define	NRF70_RATE_INFO_10_MHZ_WIDTH		BIT(2)
+#define	NRF70_RATE_INFO_40_MHZ_WIDTH		BIT(3)
+#define	NRF70_RATE_INFO_80_MHZ_WIDTH		BIT(4)
+#define	NRF70_RATE_INFO_160_MHZ_WIDTH		BIT(5)
+#define	NRF70_RATE_INFO_SHORT_GI		BIT(6)
+#define	NRF70_RATE_INFO_80P80_MHZ_WIDTH		BIT(7)
+struct __packed nrf70_rate_info {
+	u32 valid_fields;
+	u32 bitrate;
+	u16 bitrate_compat;
+	u8 mcs;
+	u8 vht_mcs;
+	u8 vht_nss;
+	u32 flags;
+};
+
+#define	NRF70_STA_INFO_CONNECTED_TIME		BIT(0)
+#define	NRF70_STA_INFO_INACTIVE_TIME		BIT(1)
+#define	NRF70_STA_INFO_RX_BYTES			BIT(2)
+#define	NRF70_STA_INFO_TX_BYTES			BIT(3)
+#define	NRF70_STA_INFO_CHAIN_SIGNAL		BIT(4)
+#define	NRF70_STA_INFO_CHAIN_SIGNAL_AVG		BIT(5)
+#define	NRF70_STA_INFO_TX_BITRATE		BIT(6)
+#define	NRF70_STA_INFO_RX_BITRATE		BIT(7)
+#define	NRF70_STA_INFO_STA_FLAGS		BIT(8)
+#define	NRF70_STA_INFO_LLID			BIT(9)
+#define	NRF70_STA_INFO_PLID			BIT(10)
+#define	NRF70_STA_INFO_PLINK_STATE		BIT(11)
+#define	NRF70_STA_INFO_SIGNAL			BIT(12)
+#define	NRF70_STA_INFO_SIGNAL_AVG		BIT(13)
+#define	NRF70_STA_INFO_RX_PACKETS		BIT(14)
+#define	NRF70_STA_INFO_TX_PACKETS		BIT(15)
+#define	NRF70_STA_INFO_TX_RETRIES		BIT(16)
+#define	NRF70_STA_INFO_TX_FAILED		BIT(17)
+#define	NRF70_STA_INFO_EXPECTED_THROUGHPUT	BIT(18)
+#define	NRF70_STA_INFO_BEACON_LOSS_COUNT	BIT(19)
+#define	NRF70_STA_INFO_LOCAL_PM			BIT(20)
+#define	NRF70_STA_INFO_PEER_PM			BIT(21)
+#define	NRF70_STA_INFO_NONPEER_PM		BIT(22)
+#define	NRF70_STA_INFO_T_OFFSET			BIT(23)
+#define	NRF70_STA_INFO_RX_DROPPED_MISC		BIT(24)
+#define	NRF70_STA_INFO_RX_BEACON		BIT(25)
+#define	NRF70_STA_INFO_RX_BEACON_SIGNAL_AVG	BIT(26)
+#define	NRF70_STA_INFO_BSS_PARAMS		BIT(27)
+struct __packed nrf70_event_new_station {
+	struct nrf70_umac_header header;
+	u32 valid_fields;
+	u8 wme;
+	u8 sta_legacy;
+	u8 hwaddr[ETH_ALEN];
+	u32 generation;
+	struct __packed {
+		u32 valid_fields;
+		u32 connected_time;
+		u32 inactive_time;
+		u32 rx_bytes;
+		u32 tx_bytes;
+		struct __packed {
+			u32 signal_mask;
+			u8 signal[IEEE80211_MAX_CHAINS];
+			u32 signal_avg_mask;
+			u8 signal_avg[IEEE80211_MAX_CHAINS];
+		} chain;
+		struct nrf70_rate_info tx_bitrate;
+		struct nrf70_rate_info rx_bitrate;
+		u16 llid; /* unused */
+		u16 plid; /* unused */
+		u8 plink_state; /* unused */
+		s32 signal;
+		s32 signal_avg;
+		u32 rx_packets;
+		struct __packed {
+			u32 packets;
+			u32 retries;
+			u32 failed;
+		} tx;
+		u32 expected_throughput;
+		u32 beacon_loss_count;
+		u32 local_pm; /* unused */
+		u32 peer_pm; /* unused */
+		u32 nonpeer_pm; /* unused */
+		struct nrf70_sta_flag_update sta_flags;
+		u64 t_offset;
+		u64 rx_dropped_misc;
+		u64 rx_beacon;
+		s64 rx_beacon_signal_avg;
+		struct __packed {
+			u8 flags;
+			u8 dtim_period;
+			u16 beacon_interval;
+		} bss_param;
+	} sta_info;
+	struct nrf70_ie assoc_req_ies;
+};
+
+struct __packed nrf70_event_get_chan {
+	struct nrf70_umac_header header;
+	struct __packed {
+		s32 band;
+		u32 center_freq;
+		u32 flags;
+		s32 max_antenna_gain;
+		s32 max_power;
+		s32 max_reg_power;
+		u32 orig_flags;
+		s32 orig_mag;
+		s32 orig_mpwr;
+		u16 hw_value;
+		s8 beacon_found;
+	} chan;
+	s32 width;
+	u32 center_freq1;
+	u32 center_freq2;
+};
+
+#define	NRF70_SET_REG_ALPHA2		BIT(0)
+#define	NRF70_SET_REG_USER_REG_FORCE	BIT(2)
+struct __packed nrf70_cmd_set_reg {
+	struct nrf70_umac_header header;
+	u32 valid_fields;
+	u32 user_reg_hint_type;
+	u8 alpha2[NRF70_COUNTRY_CODE_LEN];
+};
+
+struct __packed nrf70_event_reg_change {
+	struct nrf70_umac_header header;
+	u16 flags;
+	s32 intr;
+	s8 reg_type;
+	u8 alpha2[NRF70_COUNTRY_CODE_LEN];
+};
+
+#endif /* _NRF70_CMDS_H */
diff --git a/drivers/net/wireless/nordic/nrf70_rf_params.h b/drivers/net/wireless/nordic/nrf70_rf_params.h
new file mode 100644
index 000000000000..d6a746783ded
--- /dev/null
+++ b/drivers/net/wireless/nordic/nrf70_rf_params.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Conclusive Engineering Sp. z o. o.
+ */
+
+#ifndef _NRF70_RF_PARAMS_H
+#define _NRF70_RF_PARAMS_H
+
+#define	NRF70_RESERVED				0x0
+
+#define	NRF70_QFN_XO_VAL			0x2a
+#define	NRF70_CSP_XO_VAL			0x2a
+
+#define	NRF70_PD_ADJUST_VAL			0x0
+
+#define	NRF70_SYSTEM_OFFSET_LB			0x3
+#define	NRF70_SYSTEM_OFFSET_HB_CHAN_LOW		0x3
+#define	NRF70_SYSTEM_OFFSET_HB_CHAN_MID		0x3
+#define	NRF70_SYSTEM_OFFSET_HB_CHAN_HIGH	0x3
+
+#define	NRF70_QFN_MAX_TX_PWR_DSSS		0x48
+#define	NRF70_QFN_MAX_TX_PWR_LB_MCS7		0x40
+#define	NRF70_QFN_MAX_TX_PWR_LB_MCS0		0x40
+#define	NRF70_QFN_MAX_TX_PWR_HB_LOW_CHAN_MCS7	0x34
+#define	NRF70_QFN_MAX_TX_PWR_HB_MID_CHAN_MCS7	0x34
+#define	NRF70_QFN_MAX_TX_PWR_HB_HIGH_CHAN_MCS7	0x30
+#define	NRF70_QFN_MAX_TX_PWR_HB_LOW_CHAN_MCS0	0x38
+#define	NRF70_QFN_MAX_TX_PWR_HB_MID_CHAN_MCS0	0x34
+#define	NRF70_QFN_MAX_TX_PWR_HB_HIGH_CHAN_MCS0	0x30
+
+#define	NRF70_RX_GAIN_OFFSET_LB_CHAN		0x0
+#define	NRF70_RX_GAIN_OFFSET_HB_LOW_CHAN	0x0
+#define	NRF70_RX_GAIN_OFFSET_HB_MID_CHAN	0x0
+#define	NRF70_RX_GAIN_OFFSET_HB_HIGH_CHAN	0x0
+
+#define	NRF70_QFN_MAX_CHIP_TEMP			0x43
+#define	NRF70_QFN_MIN_CHIP_TEMP			0x7
+#define	NRF70_QFN_LB_MAX_PWR_BKF_HI_TEMP	0xfc
+#define	NRF70_QFN_LB_MAX_PWR_BKF_LOW_TEMP	0x0
+#define	NRF70_QFN_HB_MAX_PWR_BKF_HI_TEMP	0xf8
+#define	NRF70_QFN_HB_MAX_PWR_BKF_LOW_TEMP	0xfc
+#define	NRF70_QFN_LB_VBT_LT_VLOW		0xfc
+#define	NRF70_QFN_HB_VBT_LT_VLOW		0xf8
+#define	NRF70_QFN_LB_VBT_LT_LOW			0x0
+#define	NRF70_QFN_HB_VBT_LT_LOW			0xfc
+
+#define NRF70_PHY_CALIB_FLAG_RXDC		BIT(0)
+#define NRF70_PHY_CALIB_FLAG_TXDC		BIT(1)
+#define NRF70_PHY_CALIB_FLAG_TXPOW		0
+#define NRF70_PHY_CALIB_FLAG_TXIQ		BIT(3)
+#define NRF70_PHY_CALIB_FLAG_RXIQ		BIT(4)
+#define NRF70_PHY_CALIB_FLAG_DPD		BIT(5)
+
+#define NRF70_PHY_SCAN_CALIB_FLAG_RXDC		(1 << 16)
+#define NRF70_PHY_SCAN_CALIB_FLAG_TXDC		(2 << 16)
+#define NRF70_PHY_SCAN_CALIB_FLAG_TXPOW		(0 << 16)
+#define NRF70_PHY_SCAN_CALIB_FLAG_TXIQ		(0 << 16)
+#define NRF70_PHY_SCAN_CALIB_FLAG_RXIQ		(0 << 16)
+#define NRF70_PHY_SCAN_CALIB_FLAG_DPD		(0 << 16)
+
+#define NRF70_DEF_PHY_CALIB (NRF70_PHY_CALIB_FLAG_RXDC |		\
+			     NRF70_PHY_CALIB_FLAG_TXDC |		\
+			     NRF70_PHY_CALIB_FLAG_RXIQ |		\
+			     NRF70_PHY_CALIB_FLAG_TXIQ |		\
+			     NRF70_PHY_CALIB_FLAG_TXPOW |		\
+			     NRF70_PHY_CALIB_FLAG_DPD |			\
+			     NRF70_PHY_SCAN_CALIB_FLAG_RXDC |		\
+			     NRF70_PHY_SCAN_CALIB_FLAG_TXDC |		\
+			     NRF70_PHY_SCAN_CALIB_FLAG_RXIQ |		\
+			     NRF70_PHY_SCAN_CALIB_FLAG_TXIQ |		\
+			     NRF70_PHY_SCAN_CALIB_FLAG_TXPOW |		\
+			     NRF70_PHY_SCAN_CALIB_FLAG_DPD)
+
+/* Temperature based calibration params. */
+#define NRF70_DEF_PHY_TEMP_CALIB (NRF70_PHY_CALIB_FLAG_RXDC |		\
+				  NRF70_PHY_CALIB_FLAG_TXDC |		\
+				  NRF70_PHY_CALIB_FLAG_RXIQ |		\
+				  NRF70_PHY_CALIB_FLAG_TXIQ |		\
+				  NRF70_PHY_CALIB_FLAG_TXPOW |		\
+				  NRF70_PHY_CALIB_FLAG_DPD)
+
+/* Convert from millivolts to vbat threshold. Value must be above 2.5 V. */
+#define	NRF70_VBAT_MV_TO_VTH(n)	(((n) - 2500) / 70)
+
+#define NRF70_PHY_PARAMS \
+	0x00, 0x70, 0x77, 0x00, 0x3f, 0x03, 0x24, 0x24, 0x00, 0x10, 0x00, \
+	0x00, 0x28, 0x00, 0x32, 0x35, 0x00, 0x00, 0x0c, 0xf0, 0x08, 0x08, \
+	0x7d, 0x81, 0x05, 0x01, 0x00, 0x71, 0x63, 0x03, 0x00, 0xee, 0xd5, \
+	0x01, 0x00, 0x1f, 0x6f, 0x00, 0x00, 0x3b, 0x35, 0x01, 0x00, 0xf5, \
+	0x2e, 0x00, 0x00, 0xe3, 0x5e, 0x00, 0x00, 0xb7, 0xb6, 0x00, 0x00, \
+	0x66, 0xef, 0xfe, 0xff, 0xb5, 0xf6, 0x00, 0x00, 0x89, 0x62, 0x00, \
+	0x00, 0x7a, 0x84, 0x02, 0x00, 0xe2, 0x8f, 0xfc, 0xff, 0x08, 0x08, \
+	0x08, 0x08, 0x04, 0x08, 0x12, 0x01, 0x00, 0x00, 0x00, 0x00, 0xa1, \
+	0xa1, 0x01, 0x78, 0x00, 0x00, 0x00, 0x08, 0x00, 0x50, 0x00, 0x3b, \
+	0x02, 0x07, 0x26, 0x18, 0x18, 0x18, 0x18, 0x1a, 0x12, 0x0a, 0x14, \
+	0x0e, 0x06, 0x00
+
+#endif /* _NRF70_RF_PARAMS_H */
-- 
2.49.0


