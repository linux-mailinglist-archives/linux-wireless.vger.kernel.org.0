Return-Path: <linux-wireless+bounces-21667-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A1DA91EDA
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7699416F96C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2735324EA9C;
	Thu, 17 Apr 2025 13:54:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E647124EAB2
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898083; cv=none; b=C61veI1t73zN7zYFX50GggnwPp9pNMFqne+WhJg1/Z0gam2WwwCx+G2fnVP67uKmRy7m8Ba2Ol6+SZ2SYSDUtU9OLaCAHDjeXpmv86HufloAni4EiyjGRm5yypp8n3fRecWpHLDBsUi3v9WiUu6fmZ+V5ixeoAxAuFhXpobbyIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898083; c=relaxed/simple;
	bh=/78LeKjIAwQnUbprAiO7aIoBuBnoLYS8SJx6Ep2wwgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=b00jqy1MCV16jee05a81QPOv3Fa5C0bQ4bX/tl/pVJ6NJ+EN7QThGRGXD/VFc3jSuMLhV5M0GzoER7Sd5NWt9y0NDU/NOnOkjkXM0r2ABem7iJsWDMkWRuk4dyOG3krC6tndqd2SAjsg9po8tr6I/I0f9ViN84ohQBC5XNgtBI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: fHV8+fpkRtufsJT7wSFvrQ==
X-CSE-MsgGUID: BfPx31IRR/OvmmWdBYQiTQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 22:54:39 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 74C6A400E4E9;
	Thu, 17 Apr 2025 22:54:36 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 27/38] ra6w: add sdio.c
Date: Thu, 17 Apr 2025 16:52:25 +0300
Message-Id: <20250417135236.52410-28-oleksandr.savchenko.dn@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250417135236.52410-1-oleksandr.savchenko.dn@bp.renesas.com>
References: <20250417135236.52410-1-oleksandr.savchenko.dn@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Part of the split. Please, take a look at the cover letter for more details

Reviewed-by: Viktor Barna <viktor.barna.rj@bp.renesas.com>
Reviewed-by: Gal Gur <gal.gur.jx@renesas.com>
Signed-off-by: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
---
 drivers/net/wireless/renesas/ra6w/sdio.c | 505 +++++++++++++++++++++++
 1 file changed, 505 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/sdio.c

diff --git a/drivers/net/wireless/renesas/ra6w/sdio.c b/drivers/net/wireless/renesas/ra6w/sdio.c
new file mode 100644
index 000000000000..b2f31a4019f2
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/sdio.c
@@ -0,0 +1,505 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file contains SDIO operations.
+ *
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#include <linux/module.h>
+#include <linux/mmc/sdio.h>
+#include <linux/mmc/host.h>
+#include <linux/firmware.h>
+#include <linux/delay.h>
+
+#include "core.h"
+#include "if.h"
+#include "cfg80211.h"
+#include "params.h"
+#include "dbg.h"
+
+void ra6w_sdio_reprobe(struct sdio_func *func)
+{
+	func->card->host->rescan_disable = 0;
+
+	mmc_detect_change(func->card->host, msecs_to_jiffies(100));
+}
+
+static void ra6w_sdio_irq_handler(struct sdio_func *func)
+{
+	struct ra6w_if *ifp = sdio_get_drvdata(func);
+	struct ra6w_core *core = &ifp->core;
+	int ret = 0;
+	u8 reg = 0;
+
+	reg = sdio_readb(func, SDIO_CCCR_CAPS, &ret);
+	if (ret) {
+		ra6w_err("SDIO_CCCR_CAP read failed: %d\n", ret);
+		return;
+	}
+
+	sdio_writeb(func, reg, SDIO_CCCR_CAPS, &ret);
+	if (ret) {
+		ra6w_err("SDIO_CCCR_CAPS write failed: %d\n", ret);
+		return;
+	}
+
+	ra6w_q_event_set(&core->event, BIT(RA6W_CORE_EVENT_DATA));
+}
+
+static int ra6w_sdio_enable_irq(struct sdio_func *func)
+{
+	int ret = 0;
+	u8 reg = 0;
+
+	sdio_claim_host(func);
+
+	reg = sdio_f0_readb(func, SDIO_CCCR_IENx, &ret);
+	if (ret) {
+		ra6w_err("SDIO_CCCR_IENx read failed: %d\n", ret);
+		goto release_host;
+	}
+
+	func->num = 0;
+	reg |= BIT(func->num);
+	sdio_writeb(func, reg, SDIO_CCCR_IENx, &ret);
+	if (ret) {
+		ra6w_err("SDIO_CCCR_IENx write failed: reg=0x%x ret=%d\n", reg, ret);
+		goto release_host;
+	}
+
+	sdio_writeb(func, SDIO_CCCR_CAP_E4MI, SDIO_CCCR_CAPS, &ret);
+	if (ret) {
+		ra6w_err("SDIO_CCCR_CAPS write failed: SDIO_CCCR_CAP_E4MI ret=%d\n", ret);
+		goto release_host;
+	}
+
+	func->num = 1;
+	sdio_writeb(func, SDIO_CCCR_CAP_SRW, SDIO_CCCR_CIS, &ret);
+	if (ret) {
+		ra6w_err("SDIO_CCCR_CIS write failed: SDIO_CCCR_CAP_SRW ret=%d\n", ret);
+		goto release_host;
+	}
+
+	ret = sdio_claim_irq(func, ra6w_sdio_irq_handler);
+	if (ret)
+		ra6w_err("sdio_claim_irq failed: %d\n", ret);
+
+release_host:
+	sdio_release_host(func);
+
+	return ret;
+}
+
+static void ra6w_sdio_disable_irq(struct sdio_func *func)
+{
+	sdio_claim_host(func);
+	sdio_release_irq(func);
+	sdio_release_host(func);
+}
+
+static int ra6w_sdio_init(struct sdio_func *func)
+{
+	int ret = 0;
+	u8 reg = 0;
+
+	sdio_claim_host(func);
+
+	ret = sdio_enable_func(func);
+	if (ret) {
+		ra6w_err("sdio func enable failed: %d\n", ret);
+		goto release_host;
+	}
+
+	ret = sdio_set_block_size(func, RA6W_SDIO_BLOCK_SIZE);
+	if (ret) {
+		ra6w_err("sdio func set block size failed: %d\n", ret);
+		goto release_host;
+	}
+
+	reg = sdio_f0_readb(func, SDIO_CCCR_CAPS, &ret);
+	if (ret) {
+		ra6w_err("SDIO_CCCR_CAPS read failed: %d\n", ret);
+		goto release_host;
+	}
+
+	reg = sdio_f0_readb(func, SDIO_CCCR_IF, &ret);
+	if (ret) {
+		ra6w_err("SDIO_CCCR_IF read failed: %d\n", ret);
+		goto release_host;
+	}
+
+	reg = SDIO_BUS_WIDTH_4BIT | SDIO_BUS_CD_DISABLE;
+	func->num = 0;
+	sdio_writeb(func, reg, SDIO_CCCR_IF, &ret);
+
+release_host:
+	sdio_release_host(func);
+
+	return ret;
+}
+
+static int ra6w_sdio_read(struct sdio_func *func, void *data, int len)
+{
+	int ret;
+	int chunk;
+
+	sdio_claim_host(func);
+
+	chunk = sdio_align_size(func, len);
+	ret = sdio_readsb(func, data, RA6W_SDIO_ADDR_READ, chunk);
+
+	sdio_release_host(func);
+
+	return ret;
+}
+
+static int ra6w_sdio_write(struct sdio_func *func, void *data, int len)
+{
+	int ret;
+	int chunk;
+
+	sdio_claim_host(func);
+
+	chunk = sdio_align_size(func, len);
+	ret = sdio_writesb(func, RA6W_SDIO_ADDR_WRITE, data, chunk);
+
+	sdio_release_host(func);
+
+	return ret;
+}
+
+static int ra6w_sdio_write_crc32(struct sdio_func *func, const struct firmware *fw)
+{
+	u32 img_crc;
+	u32 msg_data;
+	int i;
+	int ret = 0;
+
+	/* send CRC */
+	img_crc = crc32_le(~0U, fw->data, fw->size);
+	img_crc ^= ~0U;
+	ra6w_dbg("wifi FW CRC is %08x\n", img_crc);
+
+	sdio_writel(func, img_crc, RA6W_SDIO_HOST_GP_REG, &ret);
+	if (ret) {
+		ra6w_err("CRC32 write failed: %d\n", ret);
+		return ret;
+	}
+
+	/* Check CRC */
+	for (i = 0; i < RA6W_SDIO_CRC_CHECK_RETRY_MAX; i++) {
+		msg_data = sdio_readl(func, RA6W_SDIO_CHIP_GP_REG, &ret);
+		if (ret)
+			return ret;
+
+		if (msg_data == RA6W_SDIO_CODE_CRC_CHECKING) {
+			usleep_range(RA6W_SDIO_CRC_CHECK_SLEEP_MIN_US,
+				     RA6W_SDIO_CRC_CHECK_SLEEP_MAX_US);
+			continue;
+		}
+
+		if (msg_data == RA6W_SDIO_CODE_SUCCESS)
+			return 0;
+
+		if (msg_data == RA6W_SDIO_CODE_BOOT_NG) {
+			ra6w_info("CRC32 write failed: 0x%x\n", RA6W_SDIO_CODE_BOOT_NG);
+			return -ENOENT;
+		}
+	}
+
+	return 0;
+}
+
+static int ra6w_sdio_fw_ack(struct sdio_func *func)
+{
+	u32 msg_data;
+	int i;
+	int ret;
+
+	for (i = 0; i < RA6W_SDIO_ACK_CNT_MAX; i++) {
+		msg_data = sdio_readl(func, RA6W_SDIO_CHIP_GP_REG, &ret);
+		if (ret)
+			return ret;
+
+		if (msg_data == RA6W_SDIO_CODE_SUCCESS)
+			break;
+	}
+
+	return 0;
+}
+
+static int ra6w_sdio_fw_wait_sync(struct sdio_func *func)
+{
+	u16 blk_size;
+	u8 reg;
+	int i;
+	int ret;
+
+	for (i = 0; i <  RA6W_SDIO_WAIT_SYNC_CNT_MAX; i++) {
+		reg = sdio_f0_readb(func, 0x110, &ret);
+		if (ret)
+			return ret;
+
+		blk_size = reg;
+		reg = sdio_f0_readb(func, 0x111, &ret);
+		if (ret)
+			return ret;
+
+		blk_size |= reg << 8;
+		msleep(50);
+		if (blk_size == RA6W_SDIO_BLOCK_SIZE)
+			break;
+	}
+
+	return 0;
+}
+
+static int _ra6w_sdio_fw_upload(struct sdio_func *func, const struct firmware *fw)
+{
+	u32 iteration;
+	u32 remain_len;
+	u8 *fw_buf = NULL;
+	int i;
+	int ret = 0;
+
+	fw_buf = devm_kmalloc(&func->dev, RA6W_SDIO_BLOCK_SIZE, GFP_KERNEL);
+	if (!fw_buf)
+		return -ENOMEM;
+
+	func->num = 1;
+	sdio_claim_host(func);
+
+	sdio_writel(func, fw->size, RA6W_SDIO_HOST_GP_REG, &ret);
+	if (ret) {
+		ra6w_err("Write fw size failed: %d\n", ret);
+		goto release_host;
+	}
+
+	ret = ra6w_sdio_fw_ack(func);
+	if (ret)
+		goto release_host;
+
+	iteration = RA6W_SDIO_GET_CNT(fw->size, RA6W_SDIO_BLOCK_SIZE);
+	for (i = 0; i < iteration; i++) {
+		memcpy(fw_buf, &fw->data[i * RA6W_SDIO_BLOCK_SIZE], RA6W_SDIO_BLOCK_SIZE);
+		ret = sdio_writesb(func, 0, fw_buf, RA6W_SDIO_BLOCK_SIZE);
+		if (ret)
+			goto release_host;
+	}
+
+	remain_len = RA6W_SDIO_GET_REMAIN(fw->size, RA6W_SDIO_BLOCK_SIZE);
+	memcpy(fw_buf, &fw->data[i * RA6W_SDIO_BLOCK_SIZE], remain_len);
+	ret = sdio_writesb(func, 0, fw_buf, remain_len);
+	if (ret)
+		goto release_host;
+
+	ret = ra6w_sdio_write_crc32(func, fw);
+	if (ret)
+		goto release_host;
+
+	func->num = 0;
+
+	ra6w_sdio_fw_wait_sync(func);
+
+release_host:
+	sdio_release_host(func);
+	devm_kfree(&func->dev, fw_buf);
+
+	return ret;
+}
+
+static int ra6w_sdio_fw_upload(struct sdio_func *func)
+{
+	int ret;
+	char path[100] = { 0 };
+	const struct firmware *fw = NULL;
+
+	snprintf(path, sizeof(path), "%s/%s", KBUILD_MODNAME, RA6W_SDIO_FW_NAME);
+
+	ra6w_info("F/W uploading...\n");
+
+	ret = request_firmware(&fw, path, &func->dev);
+	if (ret) {
+		ra6w_err("[%s] request_firmware %s failed: %d\n", __func__, path, ret);
+		return ret;
+	}
+
+	ret = _ra6w_sdio_fw_upload(func, fw);
+
+	ra6w_info("F/W uploading %s\n", ret ? "failed" : "done");
+
+	release_firmware(fw);
+
+	return ret;
+}
+
+static void ra6w_sdio_host_reset(struct sdio_func *func)
+{
+	int err = 0;
+
+	sdio_claim_host(func);
+	sdio_writel(func, RA6W_SDIO_ADDR_RESET, RA6W_SDIO_HOST_GP_REG, &err);
+	sdio_release_host(func);
+}
+
+static const struct ra6w_if_ops ra6w_if_sdio_ops = {
+	.read = ra6w_sdio_read,
+	.write = ra6w_sdio_write,
+};
+
+static int ra6w_sdio_probe(struct sdio_func *func, const struct sdio_device_id *id)
+{
+	int ret;
+	struct ra6w_if *ifp = NULL;
+	struct ra6w_core *core = NULL;
+
+	ifp = kzalloc(sizeof(*ifp), GFP_KERNEL);
+	if (!ifp)
+		return -ENOMEM;
+
+	ifp->dev.func = func;
+
+	ifp->ops = &ra6w_if_sdio_ops;
+
+	sdio_set_drvdata(func, ifp);
+
+	ret = ra6w_sdio_init(func);
+	if (ret)
+		goto free_ifp;
+
+	sdio_claim_host(func);
+	func->card->host->rescan_disable = 1;
+	sdio_release_host(func);
+
+	ret = ra6w_sdio_fw_upload(func);
+	if (ret)
+		goto free_ifp;
+
+	core = &ifp->core;
+
+	ret = ra6w_core_init(core);
+	if (ret)
+		goto free_ifp;
+
+	ret = ra6w_sdio_enable_irq(func);
+	if (ret)
+		goto core_deinit;
+
+	ret = ra6w_core_post_init(core);
+	if (ret)
+		goto core_deinit;
+
+	ret = ra6w_params_init(core);
+	if (ret)
+		goto core_deinit;
+
+	ret = ra6w_cfg80211_init(core, &func->dev);
+	if (ret)
+		goto core_deinit;
+
+	ret = ra6w_recovery_init(&core->recovery);
+	if (ret)
+		goto cfg80211_deinit;
+
+	return 0;
+
+cfg80211_deinit:
+	ra6w_cfg80211_deinit(core);
+
+core_deinit:
+	ra6w_core_deinit(core);
+	ra6w_sdio_host_reset(func);
+	ra6w_sdio_disable_irq(func);
+
+free_ifp:
+	kfree(ifp);
+
+	return ret;
+}
+
+static void ra6w_sdio_remove(struct sdio_func *func)
+{
+	struct ra6w_if *ifp = sdio_get_drvdata(func);
+	struct ra6w_core *core = &ifp->core;
+
+	ra6w_recovery_deinit(&core->recovery);
+
+	ra6w_cfg80211_deinit(core);
+	ra6w_sdio_disable_irq(func);
+	ra6w_core_deinit(core);
+	ra6w_sdio_host_reset(func);
+
+	sdio_claim_host(func);
+	func->card->host->rescan_disable = 0;
+	sdio_disable_func(func);
+	sdio_release_host(func);
+
+	mmc_detect_change(func->card->host, msecs_to_jiffies(100));
+
+	ifp->dev.func = NULL;
+
+	kfree(ifp);
+}
+
+static struct sdio_device_id ra6w_sdio_device_id[] = {
+	{ SDIO_DEVICE(RA6W_SDIO_VENDOR_ID_RENESAS, RA6W_SDIO_DEVICE_ID_RA6W) },
+	{},
+};
+
+MODULE_DEVICE_TABLE(sdio, ra6w_sdio_device_id);
+
+#ifdef CONFIG_PM
+static int ra6w_sdio_suspend(struct device *device)
+{
+	struct sdio_func *func = dev_to_sdio_func(device);
+	struct ra6w_if *ifp = sdio_get_drvdata(func);
+	mmc_pm_flag_t flags;
+	s32 ret = 0;
+
+	ifp->dev.dev_on_resume = false;
+
+	flags = sdio_get_host_pm_caps(func);
+	if (!(flags & MMC_PM_KEEP_POWER)) {
+		dev_err(device, "%s: cannot remain alive while host is suspended\n",
+			sdio_func_id(func));
+		return -EINVAL;
+	}
+
+	ret = sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER);
+	if (ret)
+		return ret;
+
+	return sdio_set_host_pm_flags(func, MMC_PM_WAKE_SDIO_IRQ);
+}
+
+static int ra6w_sdio_resume(struct device *device)
+{
+	const struct sdio_func *func = dev_to_sdio_func(device);
+	struct ra6w_if *ifp = sdio_get_drvdata(func);
+
+	ifp->dev.dev_on_resume = true;
+
+	return 0;
+}
+#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops ra6w_sdio_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(ra6w_sdio_suspend, ra6w_sdio_resume)
+};
+
+static struct sdio_driver ra6w_sdio_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = ra6w_sdio_device_id,
+	.probe = ra6w_sdio_probe,
+	.remove = ra6w_sdio_remove,
+	.drv = {
+		.owner = THIS_MODULE,
+		.pm = &ra6w_sdio_pm_ops
+	}
+};
+
+module_sdio_driver(ra6w_sdio_driver);
+
+MODULE_DESCRIPTION("Renesas 11ax driver for Linux");
+MODULE_AUTHOR("Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>");
+MODULE_LICENSE("GPL");
-- 
2.17.1


