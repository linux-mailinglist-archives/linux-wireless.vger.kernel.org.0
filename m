Return-Path: <linux-wireless+bounces-8180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529A18D1720
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 11:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 853D1B24DD2
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 09:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD5313DDAA;
	Tue, 28 May 2024 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IEWWJWh3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AB113FD98;
	Tue, 28 May 2024 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887898; cv=none; b=etEUO34Nz1IVQCOPAT21tKq6emra61zTqKWbAX4O4+OtfKsX7Ez7vfemIf1j77Wrii39Qc02OHWnIXgxP3PC7JNln2fcTtxNjAouAeMQupR1go6i4g2cSvHSPlG4E/1RTzuceobxjC2mdWmgiQuya1GtU10rcYXXiKxWAqApYCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887898; c=relaxed/simple;
	bh=OrpFxVvf8L2kV0avrvZILfxK58oh+W6unS06Tvx2HWE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=aIiA0t7QMlcAU9aJqRQqunIN92Ojk2krXki4YQ962LtXJ0hWJiDSRadJZW/3s9fnCcuvhSqpcTvkk/syOfe519zxouIN1z+jbwr0H5JlKZtBBa4KExVUcLGIyKib7rM+WsdOfz6xfSWFrZ79BhERsm6SfjaY1I+TbgCnCczlvzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IEWWJWh3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KWRKd5sgUp41uUqnRFuTZP9wXDKBCzkvewba+Ard9/Q=; b=IEWWJWh3HGKfgi9hXj+j/O5y3O
	vLk51b4dpYuRmByv0SbJdJcqLtbm+lW3OQagrr0bMgcBdOCXv/MiKV5QMn15PJ+BMcu3xNDY6A78G
	L700Xjhgw0Y7pEU75VjQWqKy66ShwJSGkbZcCPnkaIW1gD4mulZepm32ieEd6ZwFhIlxhJ0BMCnQ3
	UywLRzZ6DMUBjAylU6nVK1UnyBvGVJ0oOO3Ew+aYonE3mXIypKWv1SkISDl5BiEPOEDpNs7QMsBS+
	oqvUBBYwm6EYDWiWMzdt+KpI2QRJjOUJwi8l8CDMfJpmiC/+KNT3nKZ8p8TuxrUWL0QEMjqUEF8cl
	1DyoSzUg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53388 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sBsyA-0004YR-0e;
	Tue, 28 May 2024 10:18:10 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sBsyC-00E8w0-Rz; Tue, 28 May 2024 10:18:12 +0100
In-Reply-To: <ZlWhH4HleGILuUtN@shell.armlinux.org.uk>
References: <ZlWhH4HleGILuUtN@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>,
	 Michael Nemanov <michael.nemanov@ti.com>,
	 linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 7/8] wifi: wl18xx: add support for reading 8.9.1
 fw status
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sBsyC-00E8w0-Rz@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 May 2024 10:18:12 +0100

Add the necessary code to read the 8.9.1 firmware status into the
driver private status structure, augmenting the 8.9.0 firmware
status code. New structure layout taken from:

https://git.ti.com/cgit/wilink8-wlan/build-utilites/tree/patches/kernel_patches/4.19.38/0023-wlcore-Fixing-PN-drift-on-encrypted-link-after-recov.patch?h=r8.9&id=a2ee50aa5190ed3b334373d6cd09b1bff56ffcf7

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/wireless/ti/wl18xx/main.c   | 71 ++++++++++++++++++++++++-
 drivers/net/wireless/ti/wl18xx/wl18xx.h | 60 +++++++++++++++++++++
 2 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ti/wl18xx/main.c b/drivers/net/wireless/ti/wl18xx/main.c
index 2ccac1cdec01..39d8eebb9b6e 100644
--- a/drivers/net/wireless/ti/wl18xx/main.c
+++ b/drivers/net/wireless/ti/wl18xx/main.c
@@ -1177,8 +1177,49 @@ static int wl18xx_hw_init(struct wl1271 *wl)
 	return ret;
 }
 
-static void wl18xx_convert_fw_status(struct wl1271 *wl, void *raw_fw_status,
-				     struct wl_fw_status *fw_status)
+static void wl18xx_convert_fw_status_8_9_1(struct wl1271 *wl,
+					   void *raw_fw_status,
+					   struct wl_fw_status *fw_status)
+{
+	struct wl18xx_fw_status_8_9_1 *int_fw_status = raw_fw_status;
+
+	fw_status->intr = le32_to_cpu(int_fw_status->intr);
+	fw_status->fw_rx_counter = int_fw_status->fw_rx_counter;
+	fw_status->drv_rx_counter = int_fw_status->drv_rx_counter;
+	fw_status->tx_results_counter = int_fw_status->tx_results_counter;
+	fw_status->rx_pkt_descs = int_fw_status->rx_pkt_descs;
+
+	fw_status->fw_localtime = le32_to_cpu(int_fw_status->fw_localtime);
+	fw_status->link_ps_bitmap = le32_to_cpu(int_fw_status->link_ps_bitmap);
+	fw_status->link_fast_bitmap =
+			le32_to_cpu(int_fw_status->link_fast_bitmap);
+	fw_status->total_released_blks =
+			le32_to_cpu(int_fw_status->total_released_blks);
+	fw_status->tx_total = le32_to_cpu(int_fw_status->tx_total);
+
+	fw_status->counters.tx_released_pkts =
+			int_fw_status->counters.tx_released_pkts;
+	fw_status->counters.tx_lnk_free_pkts =
+			int_fw_status->counters.tx_lnk_free_pkts;
+	fw_status->counters.tx_lnk_sec_pn16 =
+			int_fw_status->counters.tx_lnk_sec_pn16;
+	fw_status->counters.tx_voice_released_blks =
+			int_fw_status->counters.tx_voice_released_blks;
+	fw_status->counters.tx_last_rate =
+			int_fw_status->counters.tx_last_rate;
+	fw_status->counters.tx_last_rate_mbps =
+			int_fw_status->counters.tx_last_rate_mbps;
+	fw_status->counters.hlid =
+			int_fw_status->counters.hlid;
+
+	fw_status->log_start_addr = le32_to_cpu(int_fw_status->log_start_addr);
+
+	fw_status->priv = &int_fw_status->priv;
+}
+
+static void wl18xx_convert_fw_status_8_9_0(struct wl1271 *wl,
+					   void *raw_fw_status,
+					   struct wl_fw_status *fw_status)
 {
 	struct wl18xx_fw_status *int_fw_status = raw_fw_status;
 
@@ -1214,6 +1255,15 @@ static void wl18xx_convert_fw_status(struct wl1271 *wl, void *raw_fw_status,
 	fw_status->priv = &int_fw_status->priv;
 }
 
+static void wl18xx_convert_fw_status(struct wl1271 *wl, void *raw_fw_status,
+				     struct wl_fw_status *fw_status)
+{
+	if (wl->chip.fw_ver[FW_VER_MAJOR] == 0)
+		wl18xx_convert_fw_status_8_9_0(wl, raw_fw_status, fw_status);
+	else
+		wl18xx_convert_fw_status_8_9_1(wl, raw_fw_status, fw_status);
+}
+
 static void wl18xx_set_tx_desc_csum(struct wl1271 *wl,
 				    struct wl1271_tx_hw_descr *desc,
 				    struct sk_buff *skb)
@@ -1515,12 +1565,29 @@ static int wl18xx_handle_static_data(struct wl1271 *wl,
 {
 	struct wl18xx_static_data_priv *static_data_priv =
 		(struct wl18xx_static_data_priv *) static_data->priv;
+	size_t fw_status_len;
 
 	strscpy(wl->chip.phy_fw_ver_str, static_data_priv->phy_version,
 		sizeof(wl->chip.phy_fw_ver_str));
 
 	wl1271_info("PHY firmware version: %s", static_data_priv->phy_version);
 
+	/* Adjust the firmware status size according to the firmware version */
+	if (wl->chip.fw_ver[FW_VER_MAJOR] == 0)
+		fw_status_len = sizeof(struct wl18xx_fw_status);
+	else
+		fw_status_len = sizeof(struct wl18xx_fw_status_8_9_1);
+
+	if (wl->fw_status_len != fw_status_len) {
+		void *new_status = krealloc(wl->raw_fw_status, fw_status_len,
+					    GFP_KERNEL | __GFP_ZERO);
+		if (!new_status)
+			return -ENOMEM;
+
+		wl->raw_fw_status = new_status;
+		wl->fw_status_len = fw_status_len;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ti/wl18xx/wl18xx.h b/drivers/net/wireless/ti/wl18xx/wl18xx.h
index b642e0c437bb..7fed96d71b27 100644
--- a/drivers/net/wireless/ti/wl18xx/wl18xx.h
+++ b/drivers/net/wireless/ti/wl18xx/wl18xx.h
@@ -155,6 +155,66 @@ struct wl18xx_fw_status {
 	struct wl18xx_fw_status_priv priv;
 } __packed;
 
+struct wl18xx_fw_packet_counters_8_9_1 {
+	/* Cumulative counter of released packets per AC */
+	u8 tx_released_pkts[NUM_TX_QUEUES];
+
+	/* Cumulative counter of freed packets per HLID */
+	u8 tx_lnk_free_pkts[WL18XX_MAX_LINKS];
+
+	/* PN16 of last TKIP/AES seq-num per HLID */
+	__le16 tx_lnk_sec_pn16[WL18XX_MAX_LINKS];
+
+	/* Cumulative counter of released Voice memory blocks */
+	u8 tx_voice_released_blks;
+
+	/* Tx rate of the last transmitted packet */
+	u8 tx_last_rate;
+
+	/* Tx rate or Tx rate estimate pre-calculated by fw in mbps units */
+	u8 tx_last_rate_mbps;
+
+	/* hlid for which the rates were reported */
+	u8 hlid;
+} __packed;
+
+/* FW status registers */
+struct wl18xx_fw_status_8_9_1 {
+	__le32 intr;
+	u8  fw_rx_counter;
+	u8  drv_rx_counter;
+	u8  reserved;
+	u8  tx_results_counter;
+	__le32 rx_pkt_descs[WL18XX_NUM_RX_DESCRIPTORS];
+
+	__le32 fw_localtime;
+
+	/*
+	 * A bitmap (where each bit represents a single HLID)
+	 * to indicate if the station is in PS mode.
+	 */
+	__le32 link_ps_bitmap;
+
+	/*
+	 * A bitmap (where each bit represents a single HLID) to indicate
+	 * if the station is in Fast mode
+	 */
+	__le32 link_fast_bitmap;
+
+	/* Cumulative counter of total released mem blocks since FW-reset */
+	__le32 total_released_blks;
+
+	/* Size (in Memory Blocks) of TX pool */
+	__le32 tx_total;
+
+	struct wl18xx_fw_packet_counters_8_9_1 counters;
+
+	__le32 log_start_addr;
+
+	/* Private status to be used by the lower drivers */
+	struct wl18xx_fw_status_priv priv;
+} __packed;
+
 #define WL18XX_PHY_VERSION_MAX_LEN 20
 
 struct wl18xx_static_data_priv {
-- 
2.30.2


