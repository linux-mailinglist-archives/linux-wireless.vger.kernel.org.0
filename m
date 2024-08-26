Return-Path: <linux-wireless+bounces-11943-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E07F395EA5E
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 09:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9894D2872E1
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 07:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E1913A3F6;
	Mon, 26 Aug 2024 07:27:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63EB12CDBE
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 07:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657233; cv=none; b=Y//vcFh0XtqVQMJW8sx+hl0zreR95HEDG2iD1BHYCpVZGXa/tHc2XaYKDf1WY02LGW5+J5OOCsuDnPHD1SvBuG2E6eCkufBf/DmzUNhllnsWbdUduDldEOih0pp6PHijjYy3Jsh/ATROwzPz4nfiQdDTHae2n94Am3rEjjqM4X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657233; c=relaxed/simple;
	bh=NfggcRePv6t1cR7t6EclMmVFevTXn8I9YcDh8D7YkPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gjhZjLYM8ipeGE7rQalWPGN4tOucaovl15msnffmL1bnMJ+QcCf/hHUAu+rJUgxRoMjurhsqbsOIpDLMmiIcvLXJVjnomOlqIS2jyRnftZONhkePCcK9XMmOtjeA8n/gveb6UUuwr+nzSLc9RI4WPOGHhHgraNDUvOk2AEmZdcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siU7p-0005HT-SK; Mon, 26 Aug 2024 09:26:53 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siU7p-0038Ey-81; Mon, 26 Aug 2024 09:26:53 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siU7p-000hSF-0Q;
	Mon, 26 Aug 2024 09:26:53 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Calvin Owens <calvin@wbinvd.org>,
	Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@kernel.org>,
	David Lin <yu-hao.lin@nxp.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 4/4] mwifiex: add iw61x support
Date: Mon, 26 Aug 2024 09:26:48 +0200
Message-Id: <20240826072648.167004-5-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826072648.167004-1-s.hauer@pengutronix.de>
References: <20240826072648.167004-1-s.hauer@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

This adds iw61x aka SD9177 support to the mwifiex driver. It is named
SD9177 in the downstream driver, I deliberately chose the NXP name in
the driver.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 79 +++++++++++++++++++++
 drivers/net/wireless/marvell/mwifiex/sdio.h |  3 +
 include/linux/mmc/sdio_ids.h                |  3 +
 3 files changed, 85 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index cbcb5674b8036..7b4045a40df57 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -318,6 +318,62 @@ static const struct mwifiex_sdio_card_reg mwifiex_reg_sd89xx = {
 				 0x68, 0x69, 0x6a},
 };
 
+static const struct mwifiex_sdio_card_reg mwifiex_reg_iw612 = {
+	.start_rd_port = 0,
+	.start_wr_port = 0,
+	.base_0_reg = 0xF8,
+	.base_1_reg = 0xF9,
+	.poll_reg = 0x5C,
+	.host_int_enable = UP_LD_HOST_INT_MASK | DN_LD_HOST_INT_MASK |
+			CMD_PORT_UPLD_INT_MASK | CMD_PORT_DNLD_INT_MASK,
+	.host_int_rsr_reg = 0x4,
+	.host_int_status_reg = 0x0C,
+	.host_int_mask_reg = 0x08,
+	.host_strap_reg = 0xF4,
+	.host_strap_mask = 0x01,
+	.host_strap_value = 0x01,
+	.status_reg_0 = 0xE8,
+	.status_reg_1 = 0xE9,
+	.sdio_int_mask = 0xff,
+	.data_port_mask = 0xffffffff,
+	.io_port_0_reg = 0xE4,
+	.io_port_1_reg = 0xE5,
+	.io_port_2_reg = 0xE6,
+	.max_mp_regs = 196,
+	.rd_bitmap_l = 0x10,
+	.rd_bitmap_u = 0x11,
+	.rd_bitmap_1l = 0x12,
+	.rd_bitmap_1u = 0x13,
+	.wr_bitmap_l = 0x14,
+	.wr_bitmap_u = 0x15,
+	.wr_bitmap_1l = 0x16,
+	.wr_bitmap_1u = 0x17,
+	.rd_len_p0_l = 0x18,
+	.rd_len_p0_u = 0x19,
+	.card_misc_cfg_reg = 0xd8,
+	.card_cfg_2_1_reg = 0xd9,
+	.cmd_rd_len_0 = 0xc0,
+	.cmd_rd_len_1 = 0xc1,
+	.cmd_rd_len_2 = 0xc2,
+	.cmd_rd_len_3 = 0xc3,
+	.cmd_cfg_0 = 0xc4,
+	.cmd_cfg_1 = 0xc5,
+	.cmd_cfg_2 = 0xc6,
+	.cmd_cfg_3 = 0xc7,
+	.fw_dump_host_ready = 0xcc,
+	.fw_dump_ctrl = 0xf0,
+	.fw_dump_start = 0xf1,
+	.fw_dump_end = 0xf8,
+	.func1_dump_reg_start = 0x10,
+	.func1_dump_reg_end = 0x17,
+	.func1_scratch_reg = 0xe8,
+	.func1_spec_reg_num = 13,
+	.func1_spec_reg_table = {0x08, 0x58, 0x5C, 0x5D,
+				 0x60, 0x61, 0x62, 0x64,
+				 0x65, 0x66, 0x68, 0x69,
+				 0x6a},
+};
+
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8786 = {
 	.firmware = SD8786_DEFAULT_FW_NAME,
 	.reg = &mwifiex_reg_sd87xx,
@@ -441,6 +497,25 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8997 = {
 	.host_mlme = false,
 };
 
+static const struct mwifiex_sdio_device mwifiex_sdio_iw612 = {
+	.firmware = IW612_DEFAULT_FW_NAME,
+	.firmware_sdiouart = IW612_SDIOUART_FW_NAME,
+	.reg = &mwifiex_reg_iw612,
+	.max_ports = 32,
+	.mp_agg_pkt_limit = 16,
+	.tx_buf_size = MWIFIEX_TX_DATA_BUF_SIZE_4K,
+	.mp_tx_agg_buf_size = MWIFIEX_MP_AGGR_BUF_SIZE_MAX,
+	.mp_rx_agg_buf_size = MWIFIEX_MP_AGGR_BUF_SIZE_MAX,
+	.supports_sdio_new_mode = true,
+	.has_control_mask = false,
+	.can_dump_fw = true,
+	.fw_dump_enh = true,
+	.can_auto_tdls = false,
+	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
+	.host_mlme = true,
+};
+
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8887 = {
 	.firmware = SD8887_DEFAULT_FW_NAME,
 	.reg = &mwifiex_reg_sd8887,
@@ -974,6 +1049,8 @@ static const struct sdio_device_id mwifiex_ids[] = {
 		.driver_data = (unsigned long)&mwifiex_sdio_sd8987},
 	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8997_WLAN),
 		.driver_data = (unsigned long)&mwifiex_sdio_sd8997},
+	{SDIO_DEVICE(SDIO_VENDOR_ID_NXP, SDIO_DEVICE_ID_NXP_IW612_WLAN),
+		.driver_data = (unsigned long)&mwifiex_sdio_iw612},
 	{},
 };
 
@@ -3212,3 +3289,5 @@ MODULE_FIRMWARE(SD8978_SDIOUART_FW_NAME);
 MODULE_FIRMWARE(SD8987_DEFAULT_FW_NAME);
 MODULE_FIRMWARE(SD8997_DEFAULT_FW_NAME);
 MODULE_FIRMWARE(SD8997_SDIOUART_FW_NAME);
+MODULE_FIRMWARE(IW612_DEFAULT_FW_NAME);
+MODULE_FIRMWARE(IW612_SDIOUART_FW_NAME);
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.h b/drivers/net/wireless/marvell/mwifiex/sdio.h
index 65d142286c46e..97759456314b0 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.h
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
@@ -29,6 +29,9 @@
 #define SD8987_DEFAULT_FW_NAME "mrvl/sd8987_uapsta.bin"
 #define SD8997_DEFAULT_FW_NAME "mrvl/sdsd8997_combo_v4.bin"
 #define SD8997_SDIOUART_FW_NAME "mrvl/sdiouart8997_combo_v4.bin"
+#define IW612_DEFAULT_FW_NAME "nxp/sdsd_nw61x.bin"
+#define IW612_SDIOUART_FW_NAME "nxp/sd_w61x.bin"
+
 
 #define BLOCK_MODE	1
 #define BYTE_MODE	0
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 7cddfdac2f576..a421c58abd331 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -115,6 +115,9 @@
 #define SDIO_VENDOR_ID_MICROCHIP_WILC		0x0296
 #define SDIO_DEVICE_ID_MICROCHIP_WILC1000	0x5347
 
+#define SDIO_VENDOR_ID_NXP			0x0471
+#define SDIO_DEVICE_ID_NXP_IW612_WLAN		0x0205
+
 #define SDIO_VENDOR_ID_REALTEK			0x024c
 #define SDIO_DEVICE_ID_REALTEK_RTW8723BS	0xb723
 #define SDIO_DEVICE_ID_REALTEK_RTW8821BS	0xb821
-- 
2.39.2


