Return-Path: <linux-wireless+bounces-12631-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EED9704B3
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2024 03:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5A7282BF8
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2024 01:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A4C12B71;
	Sun,  8 Sep 2024 01:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b="A7L4Y+FZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.kaechele.ca (mail.kaechele.ca [54.39.219.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15E1AD58;
	Sun,  8 Sep 2024 01:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.219.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725759487; cv=none; b=jlnig0lQ5Yk990WBznd5IqwcgRVGwCVBJ0cNzbkUWonF0EsmaV+A6NbfjYEM/0nMkXPplIio2UAusTe0DiwiaJvT6Fet9dU01fm3kF/qN4IS019Iosugq2RQyPjQdlMCqPiypYlTV51KopSiWNwnz1d0ZIsC2LuP4NVxqLhNfF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725759487; c=relaxed/simple;
	bh=cKur2q1H4Fp8CU1WwGO5kiQmlLK0EZaG7F+Q1MIAcMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGv7f1qcDvQQ692fjAsz9SlR0v3UBGkLYR0hIgWPMJHG3cyOpjBh0GimdQ4DNKAXOikPK5DIo5kVlT+6552339K7ElHmsP2lwKV60WJVWfxd0uPmsADcrgsQWucspSnLYyUJsK+DBoQ3SFMx3pL91K2Ys4hrHOJYu5R+ln9gl08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca; spf=pass smtp.mailfrom=kaechele.ca; dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b=A7L4Y+FZ; arc=none smtp.client-ip=54.39.219.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaechele.ca
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7B7E3C006E;
	Sat,  7 Sep 2024 21:34:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaechele.ca; s=201907;
	t=1725759259; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=8JhlNFjotRe07qdRg8Zljx1TcJ9iAGtjWJxLaciU8lA=;
	b=A7L4Y+FZTZLlVHhkCu7ZKrizMxZwdm/Hc2V4DdVozR5La6FUwmCQUiE0v4hmCWzDinI661
	GSQVyBrWMgJ5CSmXyL5+fGvnFA7PowhK9v/W41fKas4O2zb7Cu56ujPcKGyfxpUGyks8ol
	vlDDyAVLbnQ6LITJo1PeJD6o4XBeEbo=
From: Felix Kaechele <felix@kaechele.ca>
To: ath10k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: [PATCH v2 2/2] wifi: ath10k: add support for QCA9379 hw1.0 SDIO
Date: Sat,  7 Sep 2024 21:32:44 -0400
Message-ID: <20240908013244.496382-3-felix@kaechele.ca>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240908013244.496382-1-felix@kaechele.ca>
References: <20240908013244.496382-1-felix@kaechele.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This adds support for the QCA9379-3 SDIO SoC. It is part of the
QCA6174 SDIO family.

While the device is generally working, there are some remaining issues:
- the card will perform a full reconnect upon expiry of the Group Key
  renewal interval
- rx rates are not reported correctly (i.e. always show as 6.0 MBit/s)

More debugging would need to be done on these, preferably by people with
access to proper documentation.

This change was tested on a device that uses a LITEON WCBN3510A module.
The module was tested in WPA2 and WPA3 Personal scenarios using iperf3.
Performance was comparable to the same device using the vendor driver in
the same environment.

Tested-on: QCA9379 hw1.0 SDIO WLAN.NPL.1.6-00163-QCANPLSWPZ-1

Signed-off-by: Felix Kaechele <felix@kaechele.ca>
---
 drivers/net/wireless/ath/ath10k/core.c      | 37 +++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/hw.h        | 10 ++++++
 drivers/net/wireless/ath/ath10k/pci.c       |  2 ++
 drivers/net/wireless/ath/ath10k/sdio.c      |  5 ++-
 drivers/net/wireless/ath/ath10k/targaddrs.h |  3 ++
 5 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index b3294287bce1..32d5d4be8830 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -661,6 +661,42 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.delay_unmap_buffer = false,
 		.mcast_frame_registration = false,
 	},
+	{
+		.id = QCA9379_HW_1_0_DEV_VERSION,
+		.dev_id = QCA9379_1_0_DEVICE_ID,
+		.bus = ATH10K_BUS_SDIO,
+		.name = "qca9379 hw1.0 sdio",
+		.patch_load_addr = QCA9379_HW_1_0_PATCH_LOAD_ADDR,
+		.uart_pin = 19,
+		.otp_exe_param = 0,
+		.channel_counters_freq_hz = 88000,
+		.max_probe_resp_desc_thres = 0,
+		.cal_data_len = 0,
+		.fw = {
+			.dir = QCA9379_HW_1_0_FW_DIR,
+			.board_size = QCA9379_BOARD_DATA_SZ,
+			.board_ext_size = QCA9379_BOARD_EXT_DATA_SZ,
+		},
+		.rx_desc_ops = &qca988x_rx_desc_ops,
+		.hw_ops = &qca6174_sdio_ops,
+		.hw_clk = qca6174_clk,
+		.target_cpu_freq = 176000000,
+		.decap_align_bytes = 4,
+		.n_cipher_suites = 8,
+		.num_peers = 10,
+		.ast_skid_limit = 0x10,
+		.num_wds_entries = 0x20,
+		.uart_pin_workaround = true,
+		.tx_stats_over_pktlog = false,
+		.credit_size_workaround = true,
+		.bmi_large_size_download = true,
+		.supports_peer_stats_info = false,
+		.dynamic_sar_support = false,
+		.hw_restart_disconnect = false,
+		.use_fw_tx_credits = true,
+		.delay_unmap_buffer = false,
+		.mcast_frame_registration = false,
+	},
 	{
 		.id = QCA4019_HW_1_0_DEV_VERSION,
 		.dev_id = 0,
@@ -3602,6 +3638,7 @@ struct ath10k *ath10k_core_create(size_t priv_size, struct device *dev,
 		break;
 	case ATH10K_HW_QCA6174:
 	case ATH10K_HW_QCA9377:
+	case ATH10K_HW_QCA9379:
 		ar->regs = &qca6174_regs;
 		ar->hw_ce_regs = &qcax_ce_regs;
 		ar->hw_values = &qca6174_values;
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index 442091c6dfd2..419fa1888e75 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -30,6 +30,7 @@ enum ath10k_bus {
 #define QCA9888_2_0_DEVICE_ID	(0x0056)
 #define QCA9984_1_0_DEVICE_ID	(0x0046)
 #define QCA9377_1_0_DEVICE_ID   (0x0042)
+#define QCA9379_1_0_DEVICE_ID   (0x0042)
 #define QCA9887_1_0_DEVICE_ID   (0x0050)
 
 /* QCA988X 1.0 definitions (unsupported) */
@@ -59,6 +60,9 @@ enum ath10k_bus {
 #define QCA9377_HW_1_0_DEV_VERSION	0x05020000
 #define QCA9377_HW_1_1_DEV_VERSION	0x05020001
 
+/* QCA9379 target BMI version signatures */
+#define QCA9379_HW_1_0_DEV_VERSION	0x05040000
+
 enum qca6174_pci_rev {
 	QCA6174_PCI_REV_1_1 = 0x11,
 	QCA6174_PCI_REV_1_3 = 0x13,
@@ -115,6 +119,10 @@ enum qca9377_chip_id_rev {
 #define QCA9377_HW_1_0_FW_DIR          ATH10K_FW_DIR "/QCA9377/hw1.0"
 #define QCA9377_HW_1_0_PATCH_LOAD_ADDR	0x1234
 
+/* QCA9379 1.0 definitions */
+#define QCA9379_HW_1_0_FW_DIR		ATH10K_FW_DIR "/QCA9379/hw1.0"
+#define QCA9379_HW_1_0_PATCH_LOAD_ADDR	0x1234
+
 /* QCA4019 1.0 definitions */
 #define QCA4019_HW_1_0_DEV_VERSION     0x01000000
 #define QCA4019_HW_1_0_FW_DIR          ATH10K_FW_DIR "/QCA4019/hw1.0"
@@ -230,6 +238,7 @@ enum ath10k_hw_rev {
 	ATH10K_HW_QCA9888,
 	ATH10K_HW_QCA9984,
 	ATH10K_HW_QCA9377,
+	ATH10K_HW_QCA9379,
 	ATH10K_HW_QCA4019,
 	ATH10K_HW_QCA9887,
 	ATH10K_HW_WCN3990,
@@ -401,6 +410,7 @@ int ath10k_hw_diag_fast_download(struct ath10k *ar,
 #define QCA_REV_9888(ar) ((ar)->hw_rev == ATH10K_HW_QCA9888)
 #define QCA_REV_9984(ar) ((ar)->hw_rev == ATH10K_HW_QCA9984)
 #define QCA_REV_9377(ar) ((ar)->hw_rev == ATH10K_HW_QCA9377)
+#define QCA_REV_9379(ar) ((ar)->hw_rev == ATH10K_HW_QCA9379)
 #define QCA_REV_40XX(ar) ((ar)->hw_rev == ATH10K_HW_QCA4019)
 #define QCA_REV_WCN3990(ar) ((ar)->hw_rev == ATH10K_HW_WCN3990)
 
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index c52a16f8078f..6fee3d52d808 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -1899,6 +1899,7 @@ void ath10k_pci_irq_msi_fw_mask(struct ath10k *ar)
 		 *  to mask irq/MSI.
 		 */
 		break;
+	case ATH10K_HW_QCA9379:
 	case ATH10K_HW_WCN3990:
 		break;
 	}
@@ -1927,6 +1928,7 @@ static void ath10k_pci_irq_msi_fw_unmask(struct ath10k *ar)
 		 *  to unmask irq/MSI.
 		 */
 		break;
+	case ATH10K_HW_QCA9379:
 	case ATH10K_HW_WCN3990:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 08a6f36a6be9..24123d23ad5a 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -1105,6 +1105,7 @@ static void ath10k_sdio_set_mbox_info(struct ath10k *ar)
 				ATH10K_HIF_MBOX0_EXT_WIDTH_ROME_2_0;
 		break;
 	case (SDIO_DEVICE_ID_ATHEROS_QCA9377 & 0x0F00):
+	case (SDIO_DEVICE_ID_ATHEROS_QCA9379 & 0x0F00):
 		mbox_info->ext_info[0].htc_ext_sz =
 			ATH10K_HIF_MBOX0_EXT_WIDTH_ROME_2_0;
 		break;
@@ -2597,7 +2598,8 @@ static int ath10k_sdio_probe(struct sdio_func *func,
 
 	dev_id_base = (id->device & 0x0F00);
 	if (dev_id_base != (SDIO_DEVICE_ID_ATHEROS_AR6005 & 0x0F00) &&
-	    dev_id_base != (SDIO_DEVICE_ID_ATHEROS_QCA9377 & 0x0F00)) {
+	    dev_id_base != (SDIO_DEVICE_ID_ATHEROS_QCA9377 & 0x0F00) &&
+	    dev_id_base != (SDIO_DEVICE_ID_ATHEROS_QCA9379 & 0x0F00)) {
 		ret = -ENODEV;
 		ath10k_err(ar, "unsupported device id %u (0x%x)\n",
 			   dev_id_base, id->device);
@@ -2656,6 +2658,7 @@ static void ath10k_sdio_remove(struct sdio_func *func)
 static const struct sdio_device_id ath10k_sdio_devices[] = {
 	{SDIO_DEVICE(SDIO_VENDOR_ID_ATHEROS, SDIO_DEVICE_ID_ATHEROS_AR6005)},
 	{SDIO_DEVICE(SDIO_VENDOR_ID_ATHEROS, SDIO_DEVICE_ID_ATHEROS_QCA9377)},
+	{SDIO_DEVICE(SDIO_VENDOR_ID_ATHEROS, SDIO_DEVICE_ID_ATHEROS_QCA9379)},
 	{},
 };
 
diff --git a/drivers/net/wireless/ath/ath10k/targaddrs.h b/drivers/net/wireless/ath/ath10k/targaddrs.h
index ba37e6c7ced0..1a0f71126683 100644
--- a/drivers/net/wireless/ath/ath10k/targaddrs.h
+++ b/drivers/net/wireless/ath/ath10k/targaddrs.h
@@ -481,6 +481,9 @@ struct host_interest {
 #define QCA9377_BOARD_DATA_SZ     QCA6174_BOARD_DATA_SZ
 #define QCA9377_BOARD_EXT_DATA_SZ 0
 
+#define QCA9379_BOARD_DATA_SZ     QCA6174_BOARD_DATA_SZ
+#define QCA9379_BOARD_EXT_DATA_SZ 0
+
 #define QCA99X0_BOARD_DATA_SZ	  12288
 #define QCA99X0_BOARD_EXT_DATA_SZ 0
 
-- 
2.46.0


