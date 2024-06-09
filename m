Return-Path: <linux-wireless+bounces-8728-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D725A9017A2
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2024 20:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0FD1F213DC
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2024 18:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D7174E09;
	Sun,  9 Jun 2024 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hMH/ZZEB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9974050249;
	Sun,  9 Jun 2024 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717957378; cv=none; b=E7E5RpG9dUxo2Mu/k8Lg3xlNUfeck8L5GbFgnX/bNyBoIqmmTYrtOwC8mOyMpvbL04FCtz5OGY+/iQ4PoQX9d1oUrxMAbF26VX9Y0COdzcqclar7++i79nnTDGvUMviTxco80BKnGQY+AQ1e4KiO5CBUWKOm0Cf38rRPHQJNQH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717957378; c=relaxed/simple;
	bh=td5m0I7wIyrk/HcqoCLKrv5mplUVuJIwhLH4zadu01o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfYYMjjKdcV/biNw1Vk2FvD1SucuAozEbKLXfBeh1ykkyq6JlDfUrQ8X08una3Rj9REdRJDhzBeHS7vBf2cxm/UqJ4Eplc8dkkamZkNPAVkToAgrPOXnVZaKW0LeVoYQ86CJlrSTecfzmWIdUH9Qsqx2awccaJ1JRUAmuAlD2+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hMH/ZZEB; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 459IMZdW074324;
	Sun, 9 Jun 2024 13:22:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717957355;
	bh=AAxpbl1QfCjnL8HNOlt6DfrjjffsDjxLmVdJWkQd+HM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hMH/ZZEBBGLcP3O+bU1JlsRIg1sNxzY+JooX592AQ6em9Kt17kli+YVfkjzIBoOTd
	 quSQyE1NgkFDzenbHUeNwb/u2MwRgNcvbOukBzPF2F5m87bgAwV8cYChMULkKWE1Q9
	 MLjcOuUsBVfnzecZx3G3PM+G1SLFyyarc8irm3J8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 459IMZ7o035402
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 9 Jun 2024 13:22:35 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 9
 Jun 2024 13:22:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 9 Jun 2024 13:22:34 -0500
Received: from localhost (uda0389739.dhcp.ti.com [137.167.1.114])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 459IMYkO034513;
	Sun, 9 Jun 2024 13:22:34 -0500
From: <michael.nemanov@ti.com>
To: Sabeeh Khan <sabeeh-khan@ti.com>, Kalle Valo <kvalo@kernel.org>,
        Johannes
 Berg <johannes.berg@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Michael Nemanov
	<Michael.Nemanov@ti.com>
Subject: [PATCH v2 03/17] wifi: cc33xx: Add sdio.c, io.c, io.h
Date: Sun, 9 Jun 2024 21:20:48 +0300
Message-ID: <20240609182102.2950457-4-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609182102.2950457-1-michael.nemanov@ti.com>
References: <20240609182102.2950457-1-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Michael Nemanov <Michael.Nemanov@ti.com>

sdio.c implements SDIO transport functions. These are bound into
struct cc33xx_if_operations and accessed via io.h in order to abstract
multiple transport interfaces such as SPI in the future.
The CC33xx driver supports the SDIO in-band IRQ option so the IRQ from
the device received here as well.
Unlike wl1xxx products, there is no longer mapping between
HW and SDIO / SPI address space of any kind.
There are only 3 valid addresses for control, data and status
transactions each with a predefined structure.
---
 drivers/net/wireless/ti/cc33xx/io.c   | 131 ++++++
 drivers/net/wireless/ti/cc33xx/io.h   |  26 ++
 drivers/net/wireless/ti/cc33xx/sdio.c | 584 ++++++++++++++++++++++++++
 3 files changed, 741 insertions(+)
 create mode 100644 drivers/net/wireless/ti/cc33xx/io.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/io.h
 create mode 100644 drivers/net/wireless/ti/cc33xx/sdio.c

diff --git a/drivers/net/wireless/ti/cc33xx/io.c b/drivers/net/wireless/ti/cc33xx/io.c
new file mode 100644
index 000000000000..c8759b63ac2d
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/io.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include "cc33xx.h"
+#include "debug.h"
+#include "io.h"
+#include "tx.h"
+
+bool cc33xx_set_block_size(struct cc33xx *cc)
+{
+	if (cc->if_ops->set_block_size) {
+		cc->if_ops->set_block_size(cc->dev, CC33XX_BUS_BLOCK_SIZE);
+		cc33xx_debug(DEBUG_CC33xx,
+			     "Set BLKsize to %d", CC33XX_BUS_BLOCK_SIZE);
+		return true;
+	}
+
+	cc33xx_debug(DEBUG_CC33xx, "Could not set BLKsize");
+	return false;
+}
+
+void cc33xx_disable_interrupts_nosync(struct cc33xx *cc)
+{
+	cc->if_ops->disable_irq(cc->dev);
+}
+
+void cc33xx_irq(void *cookie);
+void cc33xx_enable_interrupts(struct cc33xx *cc)
+{
+	cc->if_ops->enable_irq(cc->dev);
+
+	cc33xx_debug(DEBUG_CC33xx, "IBI_WA: Read core status");
+	cc33xx_irq(cc);
+	cc33xx_debug(DEBUG_CC33xx, "IBI_WA: Core status processed");
+}
+
+void cc33xx_io_reset(struct cc33xx *cc)
+{
+	if (cc->if_ops->reset)
+		cc->if_ops->reset(cc->dev);
+}
+
+void cc33xx_io_init(struct cc33xx *cc)
+{
+	if (cc->if_ops->init)
+		cc->if_ops->init(cc->dev);
+}
+
+/* Raw target IO, address is not translated */
+static int __must_check cc33xx_raw_write(struct cc33xx *cc, int addr,
+					 void *buf, size_t len, bool fixed)
+{
+	int ret;
+
+	if (test_bit(CC33XX_FLAG_IO_FAILED, &cc->flags) ||
+	    WARN_ON((test_bit(CC33XX_FLAG_IN_ELP, &cc->flags) &&
+		     addr != HW_ACCESS_ELP_CTRL_REG)))
+		return -EIO;
+
+	ret = cc->if_ops->write(cc->dev, addr, buf, len, fixed);
+	if (ret && cc->state != CC33XX_STATE_OFF)
+		set_bit(CC33XX_FLAG_IO_FAILED, &cc->flags);
+
+	return ret;
+}
+
+int __must_check cc33xx_raw_read(struct cc33xx *cc, int addr,
+				 void *buf, size_t len, bool fixed)
+{
+	int ret;
+
+	if (test_bit(CC33XX_FLAG_IO_FAILED, &cc->flags) ||
+	    WARN_ON((test_bit(CC33XX_FLAG_IN_ELP, &cc->flags) &&
+		     addr != HW_ACCESS_ELP_CTRL_REG)))
+		return -EIO;
+
+	ret = cc->if_ops->read(cc->dev, addr, buf, len, fixed);
+	if (ret && cc->state != CC33XX_STATE_OFF)
+		set_bit(CC33XX_FLAG_IO_FAILED, &cc->flags);
+
+	return ret;
+}
+
+int __must_check cc33xx_write(struct cc33xx *cc, int addr,
+			      void *buf, size_t len, bool fixed)
+{
+	return cc33xx_raw_write(cc, addr, buf, len, fixed);
+}
+
+void claim_core_status_lock(struct cc33xx *cc)
+{
+	/* When accessing core-status data (read or write) the transport lock
+	 * should be held.
+	 */
+	cc->if_ops->interface_claim(cc->dev);
+}
+
+void release_core_status_lock(struct cc33xx *cc)
+{
+	/* After accessing core-status data (read or write) the transport lock
+	 * should be released.
+	 */
+	cc->if_ops->interface_release(cc->dev);
+}
+
+void cc33xx_power_off(struct cc33xx *cc)
+{
+	int ret = 0;
+
+	if (!test_bit(CC33XX_FLAG_GPIO_POWER, &cc->flags))
+		return;
+
+	if (cc->if_ops->power)
+		ret = cc->if_ops->power(cc->dev, false);
+	if (!ret)
+		clear_bit(CC33XX_FLAG_GPIO_POWER, &cc->flags);
+}
+
+int cc33xx_power_on(struct cc33xx *cc)
+{
+	int ret = 0;
+
+	if (cc->if_ops->power)
+		ret = cc->if_ops->power(cc->dev, true);
+	if (ret == 0)
+		set_bit(CC33XX_FLAG_GPIO_POWER, &cc->flags);
+
+	return ret;
+}
diff --git a/drivers/net/wireless/ti/cc33xx/io.h b/drivers/net/wireless/ti/cc33xx/io.h
new file mode 100644
index 000000000000..cc5abd428d99
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/io.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __IO_H__
+#define __IO_H__
+
+struct cc33xx;
+
+void cc33xx_disable_interrupts_nosync(struct cc33xx *cc);
+void cc33xx_enable_interrupts(struct cc33xx *cc);
+void cc33xx_io_reset(struct cc33xx *cc);
+void cc33xx_io_init(struct cc33xx *cc);
+int __must_check cc33xx_raw_read(struct cc33xx *cc, int addr,
+				 void *buf, size_t len, bool fixed);
+int __must_check cc33xx_write(struct cc33xx *cc, int addr,
+			      void *buf, size_t len, bool fixed);
+void claim_core_status_lock(struct cc33xx *cc);
+void release_core_status_lock(struct cc33xx *cc);
+void cc33xx_power_off(struct cc33xx *cc);
+int cc33xx_power_on(struct cc33xx *cc);
+int cc33xx_translate_addr(struct cc33xx *cc, int addr);
+bool cc33xx_set_block_size(struct cc33xx *cc);
+
+#endif /* __IO_H__ */
diff --git a/drivers/net/wireless/ti/cc33xx/sdio.c b/drivers/net/wireless/ti/cc33xx/sdio.c
new file mode 100644
index 000000000000..ef41dc352a64
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/sdio.c
@@ -0,0 +1,584 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <linux/mmc/sdio_func.h>
+#include <linux/mmc/host.h>
+#include <linux/gpio.h>
+#include <linux/pm_runtime.h>
+#include <linux/of_irq.h>
+
+#include "cc33xx.h"
+#include "io.h"
+
+#ifndef SDIO_VENDOR_ID_TI
+#define SDIO_VENDOR_ID_TI		0x0097
+#endif
+
+#define SDIO_DEVICE_ID_CC33XX_NO_EFUSE	0x4076
+#define SDIO_DEVICE_ID_TI_CC33XX	0x4077
+
+static bool dump;
+
+struct cc33xx_sdio_glue {
+	struct device *dev;
+	struct platform_device *core;
+};
+
+static const struct sdio_device_id cc33xx_devices[] = {
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_CC33XX) },
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_CC33XX_NO_EFUSE) },
+	{}
+};
+MODULE_DEVICE_TABLE(sdio, cc33xx_devices);
+
+static void cc33xx_sdio_claim(struct device *child)
+{
+	struct cc33xx_sdio_glue *glue = dev_get_drvdata(child->parent);
+	struct sdio_func *func = dev_to_sdio_func(glue->dev);
+
+	sdio_claim_host(func);
+}
+
+static void cc33xx_sdio_release(struct device *child)
+{
+	struct cc33xx_sdio_glue *glue = dev_get_drvdata(child->parent);
+	struct sdio_func *func = dev_to_sdio_func(glue->dev);
+
+	sdio_release_host(func);
+}
+
+static void cc33xx_sdio_set_block_size(struct device *child,
+				       unsigned int blksz)
+{
+	struct cc33xx_sdio_glue *glue = dev_get_drvdata(child->parent);
+	struct sdio_func *func = dev_to_sdio_func(glue->dev);
+
+	sdio_claim_host(func);
+	sdio_set_block_size(func, blksz);
+	sdio_release_host(func);
+}
+
+static int __must_check cc33xx_sdio_raw_read(struct device *child, int addr,
+					     void *buf, size_t len, bool fixed)
+{
+	int ret;
+	struct cc33xx_sdio_glue *glue = dev_get_drvdata(child->parent);
+	struct sdio_func *func = dev_to_sdio_func(glue->dev);
+
+	sdio_claim_host(func);
+
+	if (unlikely(addr == HW_ACCESS_ELP_CTRL_REG)) {
+		((u8 *)buf)[0] = sdio_f0_readb(func, addr, &ret);
+		dev_dbg(child->parent, "sdio read 52 addr 0x%x, byte 0x%02x\n",
+			addr, ((u8 *)buf)[0]);
+	} else {
+		if (fixed)
+			ret = sdio_readsb(func, buf, addr, len);
+		else
+			ret = sdio_memcpy_fromio(func, buf, addr, len);
+
+		dev_dbg(child->parent, "sdio read 53 addr 0x%x, %zu bytes\n",
+			addr, len);
+	}
+
+	sdio_release_host(func);
+
+	if (WARN_ON(ret))
+		dev_err(child->parent, "sdio read failed (%d)\n", ret);
+
+	if (unlikely(dump)) {
+		dev_dbg(glue->dev, "cc33xx_sdio: READ from 0x%04x\n", addr);
+		print_hex_dump(KERN_DEBUG, "cc33xx_sdio: READ ",
+			       DUMP_PREFIX_OFFSET, 16, 1, buf, len, false);
+	}
+
+	return ret;
+}
+
+static int __must_check cc33xx_sdio_raw_write(struct device *child, int addr,
+					      void *buf, size_t len, bool fixed)
+{
+	int ret;
+	struct cc33xx_sdio_glue *glue = dev_get_drvdata(child->parent);
+	struct sdio_func *func = dev_to_sdio_func(glue->dev);
+
+	sdio_claim_host(func);
+
+	if (unlikely(dump)) {
+		dev_dbg(child->parent, "cc33xx_sdio: WRITE to 0x%04x length 0x%zx (first 64 Bytes):\n",
+			addr, len);
+		print_hex_dump(KERN_DEBUG, "cc33xx_sdio: WRITE ",
+			       DUMP_PREFIX_OFFSET, 16, 1, buf,
+			       min(len, (size_t)64), false);
+	}
+
+	if (unlikely(addr == HW_ACCESS_ELP_CTRL_REG)) {
+		sdio_f0_writeb(func, ((u8 *)buf)[0], addr, &ret);
+		dev_dbg(child->parent, "sdio write 52 addr 0x%x, byte 0x%02x\n",
+			addr, ((u8 *)buf)[0]);
+	} else {
+		dev_dbg(child->parent, "sdio write 53 addr 0x%x, %zu bytes\n",
+			addr, len);
+
+		if (fixed)
+			ret = sdio_writesb(func, addr, buf, len);
+		else
+			ret = sdio_memcpy_toio(func, addr, buf, len);
+	}
+
+	sdio_release_host(func);
+
+	if (WARN_ON(ret))
+		dev_err(child->parent, "sdio write failed (%d)\n", ret);
+
+	return ret;
+}
+
+static int cc33xx_sdio_power_on(struct cc33xx_sdio_glue *glue)
+{
+	int ret;
+	struct sdio_func *func = dev_to_sdio_func(glue->dev);
+	struct mmc_card *card = func->card;
+
+	ret = pm_runtime_get_sync(&card->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(&card->dev);
+		dev_err(glue->dev, "%s: failed to get_sync(%d)\n",
+			__func__, ret);
+
+		return ret;
+	}
+
+	sdio_claim_host(func);
+	sdio_enable_func(func);
+	sdio_release_host(func);
+
+	return 0;
+}
+
+static int cc33xx_sdio_power_off(struct cc33xx_sdio_glue *glue)
+{
+	struct sdio_func *func = dev_to_sdio_func(glue->dev);
+	struct mmc_card *card = func->card;
+
+	sdio_claim_host(func);
+	sdio_disable_func(func);
+	sdio_release_host(func);
+
+	/* Let runtime PM know the card is powered off */
+	pm_runtime_put(&card->dev);
+	return 0;
+}
+
+static int cc33xx_sdio_set_power(struct device *child, bool enable)
+{
+	struct cc33xx_sdio_glue *glue = dev_get_drvdata(child->parent);
+
+	if (enable)
+		return cc33xx_sdio_power_on(glue);
+	else
+		return cc33xx_sdio_power_off(glue);
+}
+
+/**
+ *	inband_irq_handler - Called from the MMC subsystem when the
+ *	function's IRQ is signaled.
+ *	@func: an SDIO function of the card
+ *
+ *	Note that the host is already claimed when handler is invoked.
+ */
+static void inband_irq_handler(struct sdio_func *func)
+{
+	struct cc33xx_sdio_glue *glue = sdio_get_drvdata(func);
+	struct platform_device *pdev = glue->core;
+	struct cc33xx_platdev_data *pdev_data = dev_get_platdata(&pdev->dev);
+
+	dev_dbg(glue->dev, "Inband SDIO IRQ");
+
+	if (WARN_ON(!pdev_data->irq_handler))
+		return;
+
+	pdev_data->irq_handler(pdev);
+}
+
+static void cc33xx_enable_async_interrupt(struct sdio_func *func)
+{
+	u8 reg_val;
+	const int CCCR_REG_16_ADDR = 0x16;
+	const int ENABLE_ASYNC_IRQ_BIT = BIT(1);
+
+	reg_val = sdio_f0_readb(func, CCCR_REG_16_ADDR, NULL);
+	reg_val |= ENABLE_ASYNC_IRQ_BIT;
+	sdio_f0_writeb(func, reg_val, CCCR_REG_16_ADDR, NULL);
+}
+
+static void cc33xx_sdio_enable_irq(struct device *child)
+{
+	struct cc33xx_sdio_glue *glue = dev_get_drvdata(child->parent);
+	struct sdio_func *func = dev_to_sdio_func(glue->dev);
+
+	sdio_claim_host(func);
+	cc33xx_enable_async_interrupt(func);
+	sdio_claim_irq(func, inband_irq_handler);
+	sdio_release_host(func);
+}
+
+static void cc33xx_sdio_disable_irq(struct device *child)
+{
+	struct cc33xx_sdio_glue *glue = dev_get_drvdata(child->parent);
+	struct sdio_func *func = dev_to_sdio_func(glue->dev);
+
+	sdio_claim_host(func);
+	sdio_release_irq(func);
+	sdio_release_host(func);
+}
+
+static void cc33xx_enable_line_irq(struct device *child)
+{
+	struct cc33xx_sdio_glue *glue = dev_get_drvdata(child->parent);
+	struct platform_device *pdev = glue->core;
+	struct cc33xx_platdev_data *pdev_data = dev_get_platdata(&pdev->dev);
+
+	enable_irq(pdev_data->gpio_irq_num);
+}
+
+static void cc33xx_disable_line_irq(struct device *child)
+{
+	struct cc33xx_sdio_glue *glue = dev_get_drvdata(child->parent);
+	struct platform_device *pdev = glue->core;
+	struct cc33xx_platdev_data *pdev_data = dev_get_platdata(&pdev->dev);
+
+	disable_irq_nosync(pdev_data->gpio_irq_num);
+}
+
+static void cc33xx_set_irq_handler(struct device *child, void *handler)
+{
+	struct cc33xx_sdio_glue *glue = dev_get_drvdata(child->parent);
+	struct platform_device *pdev = glue->core;
+	struct cc33xx_platdev_data *pdev_data = dev_get_platdata(&pdev->dev);
+
+	pdev_data->irq_handler = handler;
+}
+
+static struct cc33xx_if_operations sdio_ops_gpio_irq = {
+	.interface_claim	= cc33xx_sdio_claim,
+	.interface_release	= cc33xx_sdio_release,
+	.read			= cc33xx_sdio_raw_read,
+	.write			= cc33xx_sdio_raw_write,
+	.power			= cc33xx_sdio_set_power,
+	.set_block_size	= cc33xx_sdio_set_block_size,
+	.set_irq_handler	= cc33xx_set_irq_handler,
+	.disable_irq		= cc33xx_disable_line_irq,
+	.enable_irq		= cc33xx_enable_line_irq,
+};
+
+static struct cc33xx_if_operations sdio_ops_inband_irq = {
+	.interface_claim	= cc33xx_sdio_claim,
+	.interface_release	= cc33xx_sdio_release,
+	.read			= cc33xx_sdio_raw_read,
+	.write			= cc33xx_sdio_raw_write,
+	.power			= cc33xx_sdio_set_power,
+	.set_block_size	= cc33xx_sdio_set_block_size,
+	.set_irq_handler	= cc33xx_set_irq_handler,
+	.disable_irq		= cc33xx_sdio_disable_irq,
+	.enable_irq		= cc33xx_sdio_enable_irq,
+};
+
+#ifdef CONFIG_OF
+static const struct cc33xx_family_data cc33xx_data = {
+	.name = "cc33xx",
+	.cfg_name = "ti-connectivity/cc33xx-conf.bin",
+	.nvs_name = "ti-connectivity/cc33xx-nvs.bin",
+};
+
+static const struct of_device_id cc33xx_sdio_of_match_table[] = {
+	{ .compatible = "ti,cc3300", .data = &cc33xx_data },
+	{ .compatible = "ti,cc3301", .data = &cc33xx_data },
+	{ .compatible = "ti,cc3350", .data = &cc33xx_data },
+	{ .compatible = "ti,cc3351", .data = &cc33xx_data },
+	{ }
+};
+
+static int cc33xx_probe_of(struct device *dev, int *irq, int *wakeirq,
+			   struct cc33xx_platdev_data *pdev_data)
+{
+	struct device_node *np = dev->of_node;
+	const struct of_device_id *of_id;
+
+	of_id = of_match_node(cc33xx_sdio_of_match_table, np);
+	if (!of_id)
+		return -ENODEV;
+
+	pdev_data->family = of_id->data;
+
+	*irq = irq_of_parse_and_map(np, 0);
+
+	*wakeirq = irq_of_parse_and_map(np, 1);
+
+	return 0;
+}
+#else
+static int cc33xx_probe_of(struct device *dev, int *irq, int *wakeirq,
+			   struct cc33xx_platdev_data *pdev_data)
+{
+	return -ENODATA;
+}
+#endif /* CONFIG_OF */
+
+static irqreturn_t gpio_irq_hard_handler(int irq, void *cookie)
+{
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t gpio_irq_thread_handler(int irq, void *cookie)
+{
+	struct sdio_func *func = cookie;
+	struct cc33xx_sdio_glue *glue = sdio_get_drvdata(func);
+	struct platform_device *pdev = glue->core;
+	struct cc33xx_platdev_data *pdev_data = dev_get_platdata(&pdev->dev);
+
+	if (WARN_ON(!pdev_data->irq_handler))
+		return IRQ_HANDLED;
+
+	pdev_data->irq_handler(pdev);
+
+	return IRQ_HANDLED;
+}
+
+static int sdio_cc33xx_probe(struct sdio_func *func,
+			     const struct sdio_device_id *id)
+{
+	struct cc33xx_platdev_data *pdev_data;
+	struct cc33xx_sdio_glue *glue;
+	struct resource res[1];
+	mmc_pm_flag_t mmcflags;
+	int ret = -ENOMEM;
+	int gpio_irq, wakeirq, irq_flags;
+	const char *chip_family;
+
+	/* We are only able to handle the wlan function */
+	if (func->num != 0x02)
+		return -ENODEV;
+
+	pdev_data = devm_kzalloc(&func->dev, sizeof(*pdev_data), GFP_KERNEL);
+	if (!pdev_data)
+		return -ENOMEM;
+
+	glue = devm_kzalloc(&func->dev, sizeof(*glue), GFP_KERNEL);
+	if (!glue)
+		return -ENOMEM;
+
+	glue->dev = &func->dev;
+
+	/* Grab access to FN0 for ELP reg. */
+	func->card->quirks |= MMC_QUIRK_LENIENT_FN0;
+
+	/* Use block mode for transferring over one block size of data */
+	func->card->quirks |= MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
+
+	ret = cc33xx_probe_of(&func->dev, &gpio_irq, &wakeirq, pdev_data);
+	if (ret)
+		goto out;
+
+	/* if sdio can keep power while host is suspended, enable wow */
+	mmcflags = sdio_get_host_pm_caps(func);
+	dev_dbg(glue->dev, "sdio PM caps = 0x%x\n", mmcflags);
+
+	sdio_set_drvdata(func, glue);
+
+	/* Tell PM core that we don't need the card to be powered now */
+	pm_runtime_put_noidle(&func->dev);
+
+	chip_family = "cc33xx";
+
+	glue->core = platform_device_alloc(chip_family, PLATFORM_DEVID_AUTO);
+	if (!glue->core) {
+		dev_err(glue->dev, "can't allocate platform_device");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	glue->core->dev.parent = &func->dev;
+
+	if (gpio_irq) {
+		dev_info(glue->dev, "Using GPIO as IRQ\n");
+
+		irq_flags = irqd_get_trigger_type(irq_get_irq_data(gpio_irq));
+
+		irq_set_status_flags(gpio_irq, IRQ_NOAUTOEN);
+
+		if (irq_flags & (IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW))
+			irq_flags |= IRQF_ONESHOT;
+
+		ret = request_threaded_irq(gpio_irq, gpio_irq_hard_handler,
+					   gpio_irq_thread_handler,
+					   irq_flags, glue->core->name, func);
+		if (ret) {
+			dev_err(glue->dev, "can't register GPIO IRQ handler\n");
+			goto out_dev_put;
+		}
+
+		pdev_data->gpio_irq_num = gpio_irq;
+
+		if ((mmcflags & MMC_PM_KEEP_POWER) &&
+		    (enable_irq_wake(gpio_irq) == 0))
+			pdev_data->pwr_in_suspend = true;
+
+		pdev_data->if_ops = &sdio_ops_gpio_irq;
+	} else {
+		dev_info(glue->dev, "Using SDIO in-band IRQ\n");
+
+		pdev_data->if_ops = &sdio_ops_inband_irq;
+	}
+
+	if (wakeirq > 0) {
+		res[0].start = wakeirq;
+		res[0].flags = IORESOURCE_IRQ |
+			irqd_get_trigger_type(irq_get_irq_data(wakeirq));
+		res[0].name = "wakeirq";
+
+		ret = platform_device_add_resources(glue->core, res, 1);
+		if (ret) {
+			dev_err(glue->dev, "can't add resources\n");
+			goto out_dev_put;
+		}
+	}
+
+	ret = platform_device_add_data(glue->core, pdev_data,
+				       sizeof(*pdev_data));
+	if (ret) {
+		dev_err(glue->dev, "can't add platform data\n");
+		goto out_dev_put;
+	}
+
+	ret = platform_device_add(glue->core);
+	if (ret) {
+		dev_err(glue->dev, "can't add platform device\n");
+		goto out_dev_put;
+	}
+	return 0;
+
+out_dev_put:
+	platform_device_put(glue->core);
+
+	if (pdev_data->gpio_irq_num)
+		free_irq(pdev_data->gpio_irq_num, func);
+
+out:
+	return ret;
+}
+
+static void sdio_cc33xx_remove(struct sdio_func *func)
+{
+	struct cc33xx_sdio_glue *glue = sdio_get_drvdata(func);
+	struct platform_device *pdev = glue->core;
+	struct cc33xx_platdev_data *pdev_data = dev_get_platdata(&pdev->dev);
+
+	/* Undo decrement done above in sdio_cc33xx_probe */
+	pm_runtime_get_noresume(&func->dev);
+
+	platform_device_unregister(glue->core);
+
+	if (pdev_data->gpio_irq_num) {
+		free_irq(pdev_data->gpio_irq_num, func);
+		if (pdev_data->pwr_in_suspend)
+			disable_irq_wake(pdev_data->gpio_irq_num);
+	} else {
+		sdio_claim_host(func);
+		sdio_release_irq(func);
+		sdio_release_host(func);
+	}
+}
+
+#ifdef CONFIG_PM
+static int cc33xx_suspend(struct device *dev)
+{
+	/* Tell MMC/SDIO core it's OK to power down the card
+	 * (if it isn't already), but not to remove it completely
+	 */
+	struct sdio_func *func = dev_to_sdio_func(dev);
+	struct cc33xx_sdio_glue *glue = sdio_get_drvdata(func);
+	struct cc33xx *cc = platform_get_drvdata(glue->core);
+	mmc_pm_flag_t sdio_flags;
+	int ret = 0;
+
+	if (!cc) {
+		dev_err(dev, "no wilink module was probed\n");
+		goto out;
+	}
+
+	dev_dbg(dev, "cc33xx suspend. keep_device_power: %d\n",
+		cc->keep_device_power);
+
+	if (cc->keep_device_power) {
+		sdio_flags = sdio_get_host_pm_caps(func);
+
+		if (!(sdio_flags & MMC_PM_KEEP_POWER)) {
+			dev_err(dev, "can't keep power while host is suspended\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		/* keep power while host suspended */
+		ret = sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER);
+		if (ret) {
+			dev_err(dev, "error while trying to keep power\n");
+			goto out;
+		}
+	}
+out:
+	return ret;
+}
+
+static int cc33xx_resume(struct device *dev)
+{
+	dev_dbg(dev, "cc33xx resume\n");
+
+	return 0;
+}
+
+static const struct dev_pm_ops cc33xx_sdio_pm_ops = {
+	.suspend	= cc33xx_suspend,
+	.resume		= cc33xx_resume,
+};
+
+static struct sdio_driver cc33xx_sdio_driver = {
+	.name		= "cc33xx_sdio",
+	.id_table	= cc33xx_devices,
+	.probe		= sdio_cc33xx_probe,
+	.remove		= sdio_cc33xx_remove,
+	.drv = {
+		.pm = &cc33xx_sdio_pm_ops,
+	},
+};
+#else
+static struct sdio_driver cc33xx_sdio_driver = {
+	.name		= "cc33xx_sdio",
+	.id_table	= cc33xx_devices,
+	.probe		= sdio_cc33xx_probe,
+	.remove		= sdio_cc33xx_remove,
+};
+#endif /* CONFIG_PM */
+
+static int __init sdio_cc33xx_init(void)
+{
+	return sdio_register_driver(&cc33xx_sdio_driver);
+}
+
+static void __exit sdio_cc33xx_exit(void)
+{
+	sdio_unregister_driver(&cc33xx_sdio_driver);
+}
+
+module_init(sdio_cc33xx_init);
+module_exit(sdio_cc33xx_exit);
+
+module_param(dump, bool, 0600);
+MODULE_PARM_DESC(dump, "Enable sdio read/write dumps.");
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("SDIO transport for Texas Instruments CC33xx WLAN driver");
+MODULE_AUTHOR("Michael Nemanov <michael.nemanov@ti.com>");
+MODULE_AUTHOR("Sabeeh Khan <sabeeh-khan@ti.com>");
-- 
2.25.1


