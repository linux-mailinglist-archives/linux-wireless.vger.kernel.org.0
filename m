Return-Path: <linux-wireless+bounces-12691-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D339722B3
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 21:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6B6284950
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 19:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C6F189F39;
	Mon,  9 Sep 2024 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="pnPWVeRA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C029188A2F;
	Mon,  9 Sep 2024 19:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725910259; cv=none; b=i+DZNRGmHpnyX2HKtXKULVHxi1JH2TotakOUjJDVoubYYuWQzyl+FNK9hNqXhEMs2ezFc8yId6KYDiWuyQGGkfge5fVd6bY5iX7emZYYTg2RZgpy8FdCEc5fEv1AI0paOIqYZHlhLkvjggsjjZLqowOiWjT8HS3ntWkfFZIKS5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725910259; c=relaxed/simple;
	bh=Sk3YO3Jgq/3Ih8zKz4N+f63TGaX5jzBZl+pH8EF8Gmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/QKCi7+vihFmcpZ7/qkAR/ztLZcI6eBmD+121hrSwQR14aFEaUcHGhdGpvhZrEsTVhkXDSkBggX4dwyop1PR7aUw64aPSq4JhNBqJTj3E1z+2w2no1fICdrVgCh6pAwxhvyoSbVst++KxMOO+dXVKPk2sY+Ajvdyp3ZZG3gKKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=pnPWVeRA; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id A458D88E1A;
	Mon,  9 Sep 2024 21:30:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725910255;
	bh=17v8tda0x8O7fzN3KhO3Bws+cNMG3cBD/Xqu+2tvEAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pnPWVeRArcwFbR8GWd/zs9IUTFeIjdYiQjLilU3w89ViSWlKJHqFUrI4fm692A0wz
	 OumSc3qsKI+2d4NFtb7Quv16nQg4szUxCkXk9tIiQsVoja8I6RmzsnVJ8sY8/VcKll
	 82XIWt+V3FDNL06pUuj07Tzs9Iwh9AhB9V4KME7aYDMp/eIA80eEAkUkqgXEei6j5F
	 4xnQ2vDoERtsOl6z08eUCOw8bGaXAYQSWaqlQYDWh44YK+JBnEfWYkurEJPCV7Fi7S
	 Rsw3V9uaXCQynIPmRF9QiDAAmHGtjoEkgNIE1kyXvQKyKae9GzJ16I4x1GAi8MphPQ
	 0gLz14YhtqR1A==
From: Marek Vasut <marex@denx.de>
To: linux-wireless@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Adham Abozaeid <adham.abozaeid@microchip.com>,
	Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 4/9] wifi: wilc1000: Fill in missing error handling
Date: Mon,  9 Sep 2024 21:29:45 +0200
Message-ID: <20240909193035.69823-4-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909193035.69823-1-marex@denx.de>
References: <20240909193035.69823-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add error handling to chip_wakeup() and propagate the errors throughout
the entire driver. Add error handling to acquire_bus()/release_bus() and
host_sleep_notify()/host_wakeup_notify() functions as a result as well.
Fill the error handling to all call sites.

Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Adham Abozaeid <adham.abozaeid@microchip.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>
Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
---
V3: New patch
V4: No change
V4: Add RB from Alexis
V5: No change
---
 .../net/wireless/microchip/wilc1000/sdio.c    |  11 +-
 .../net/wireless/microchip/wilc1000/wlan.c    | 154 +++++++++++++-----
 .../net/wireless/microchip/wilc1000/wlan.h    |   4 +-
 3 files changed, 118 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 90357c89ae29b..c26447289b71b 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -960,6 +960,7 @@ static int wilc_sdio_suspend(struct device *dev)
 {
 	struct sdio_func *func = dev_to_sdio_func(dev);
 	struct wilc *wilc = sdio_get_drvdata(func);
+	int ret;
 
 	dev_info(dev, "sdio suspend\n");
 
@@ -969,7 +970,11 @@ static int wilc_sdio_suspend(struct device *dev)
 	if (!IS_ERR(wilc->rtc_clk))
 		clk_disable_unprepare(wilc->rtc_clk);
 
-	host_sleep_notify(wilc);
+	ret = host_sleep_notify(wilc);
+	if (ret) {
+		clk_prepare_enable(wilc->rtc_clk);
+		return ret;
+	}
 
 	wilc_sdio_disable_interrupt(wilc);
 
@@ -992,9 +997,7 @@ static int wilc_sdio_resume(struct device *dev)
 	wilc_sdio_init(wilc, true);
 	wilc_sdio_enable_interrupt(wilc);
 
-	host_wakeup_notify(wilc);
-
-	return 0;
+	return host_wakeup_notify(wilc);
 }
 
 static const struct of_device_id wilc_of_match[] = {
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index d228c5df82628..01476f8ecc36f 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -601,7 +601,7 @@ static int chip_allow_sleep(struct wilc *wilc)
 	return 0;
 }
 
-static void chip_wakeup(struct wilc *wilc)
+static int chip_wakeup(struct wilc *wilc)
 {
 	u32 ret = 0;
 	u32 clk_status_val = 0, trials = 0;
@@ -630,20 +630,20 @@ static void chip_wakeup(struct wilc *wilc)
 	ret = hif_func->hif_write_reg(wilc, from_host_to_fw_reg,
 				      from_host_to_fw_bit);
 	if (ret)
-		return;
+		return ret;
 
 	/* Set wake-up bit */
 	ret = hif_func->hif_write_reg(wilc, wakeup_reg,
 				      wakeup_bit);
 	if (ret)
-		return;
+		return ret;
 
 	while (trials < WAKE_UP_TRIAL_RETRY) {
 		ret = hif_func->hif_read_reg(wilc, clk_status_reg,
 					     &clk_status_val);
 		if (ret) {
 			pr_err("Bus error %d %x\n", ret, clk_status_val);
-			return;
+			return ret;
 		}
 		if (clk_status_val & clk_status_bit)
 			break;
@@ -652,42 +652,63 @@ static void chip_wakeup(struct wilc *wilc)
 	}
 	if (trials >= WAKE_UP_TRIAL_RETRY) {
 		pr_err("Failed to wake-up the chip\n");
-		return;
+		return -ETIMEDOUT;
 	}
 	/* Sometimes spi fail to read clock regs after reading
 	 * writing clockless registers
 	 */
 	if (wilc->io_type == WILC_HIF_SPI)
 		wilc->hif_func->hif_reset(wilc);
+
+	return 0;
 }
 
-static inline void acquire_bus(struct wilc *wilc, enum bus_acquire acquire)
+static inline int acquire_bus(struct wilc *wilc, enum bus_acquire acquire)
 {
+	int ret = 0;
+
 	mutex_lock(&wilc->hif_cs);
-	if (acquire == WILC_BUS_ACQUIRE_AND_WAKEUP && wilc->power_save_mode)
-		chip_wakeup(wilc);
+	if (acquire == WILC_BUS_ACQUIRE_AND_WAKEUP && wilc->power_save_mode) {
+		ret = chip_wakeup(wilc);
+		if (ret)
+			mutex_unlock(&wilc->hif_cs);
+	}
+
+	return ret;
 }
 
-static inline void release_bus(struct wilc *wilc, enum bus_release release)
+static inline int release_bus(struct wilc *wilc, enum bus_release release)
 {
+	int ret = 0;
+
 	if (release == WILC_BUS_RELEASE_ALLOW_SLEEP && wilc->power_save_mode)
-		chip_allow_sleep(wilc);
+		ret = chip_allow_sleep(wilc);
 	mutex_unlock(&wilc->hif_cs);
+
+	return ret;
 }
 
-void host_wakeup_notify(struct wilc *wilc)
+int host_wakeup_notify(struct wilc *wilc)
 {
-	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+	int ret = acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+
+	if (ret)
+		return ret;
+
 	wilc->hif_func->hif_write_reg(wilc, WILC_CORTUS_INTERRUPT_2, 1);
-	release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+	return release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
 }
 EXPORT_SYMBOL_GPL(host_wakeup_notify);
 
-void host_sleep_notify(struct wilc *wilc)
+int host_sleep_notify(struct wilc *wilc)
 {
-	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+	int ret = acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+
+	if (ret)
+		return ret;
+
 	wilc->hif_func->hif_write_reg(wilc, WILC_CORTUS_INTERRUPT_1, 1);
-	release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+	return release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
 }
 EXPORT_SYMBOL_GPL(host_sleep_notify);
 
@@ -714,6 +735,7 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_count)
 	int srcu_idx;
 	u8 *txb = wilc->tx_buffer;
 	struct wilc_vif *vif;
+	int rv;
 
 	if (wilc->quit)
 		goto out_update_cnt;
@@ -784,7 +806,10 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_count)
 		goto out_unlock;
 	vmm_table[i] = 0x0;
 
-	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+	ret = acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+	if (ret)
+		goto out_unlock;
+
 	counter = 0;
 	func = wilc->hif_func;
 	do {
@@ -859,7 +884,9 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_count)
 		goto out_release_bus;
 	}
 
-	release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+	ret = release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+	if (ret)
+		goto out_unlock;
 
 	offset = 0;
 	i = 0;
@@ -921,7 +948,9 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_count)
 	for (i = 0; i < NQUEUES; i++)
 		wilc->txq[i].fw.count += ac_pkt_num_to_chip[i];
 
-	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+	ret = acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+	if (ret)
+		goto out_unlock;
 
 	ret = func->hif_clear_int_ext(wilc, ENABLE_TX_VMM);
 	if (ret)
@@ -930,7 +959,9 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_count)
 	ret = func->hif_block_tx_ext(wilc, 0, txb, offset);
 
 out_release_bus:
-	release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+	rv = release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+	if (!ret && rv)
+		ret = rv;
 
 out_unlock:
 	mutex_unlock(&wilc->txq_add_to_head_cs);
@@ -1059,8 +1090,14 @@ static void wilc_wlan_handle_isr_ext(struct wilc *wilc, u32 int_status)
 void wilc_handle_isr(struct wilc *wilc)
 {
 	u32 int_status;
+	int ret;
+
+	ret = acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+	if (ret) {
+		dev_err_ratelimited(wilc->dev, "Cannot acquire bus\n");
+		return;
+	}
 
-	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
 	wilc->hif_func->hif_read_int(wilc, &int_status);
 
 	if (int_status & DATA_INT_EXT)
@@ -1069,7 +1106,9 @@ void wilc_handle_isr(struct wilc *wilc)
 	if (!(int_status & (ALL_INT_EXT)))
 		wilc_unknown_isr_ext(wilc);
 
-	release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+	ret = release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+	if (ret)
+		dev_err_ratelimited(wilc->dev, "Cannot release bus\n");
 }
 EXPORT_SYMBOL_GPL(wilc_handle_isr);
 
@@ -1081,6 +1120,7 @@ int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
 	u8 *dma_buffer;
 	int ret = 0;
 	u32 reg = 0;
+	int rv;
 
 	blksz = BIT(12);
 
@@ -1091,7 +1131,9 @@ int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
 	offset = 0;
 	pr_debug("%s: Downloading firmware size = %d\n", __func__, buffer_size);
 
-	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+	ret = acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+	if (ret)
+		return ret;
 
 	wilc->hif_func->hif_read_reg(wilc, WILC_GLB_RESET_0, &reg);
 	reg &= ~BIT(10);
@@ -1100,11 +1142,17 @@ int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
 	if (reg & BIT(10))
 		pr_err("%s: Failed to reset\n", __func__);
 
-	release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+	ret = release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+	if (ret)
+		goto fail;
+
 	do {
 		addr = get_unaligned_le32(&buffer[offset]);
 		size = get_unaligned_le32(&buffer[offset + 4]);
-		acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+		ret = acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+		if (ret)
+			goto fail;
+
 		offset += 8;
 		while (((int)size) && (offset < buffer_size)) {
 			if (size <= blksz)
@@ -1122,7 +1170,9 @@ int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
 			offset += size2;
 			size -= size2;
 		}
-		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+		rv = release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+		if (!ret && rv)
+			ret = rv;
 
 		if (ret) {
 			pr_err("%s Bus error\n", __func__);
@@ -1141,7 +1191,7 @@ int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
 int wilc_wlan_start(struct wilc *wilc)
 {
 	u32 reg = 0;
-	int ret;
+	int ret, rv;
 	u32 chipid;
 
 	if (wilc->io_type == WILC_HIF_SDIO) {
@@ -1150,7 +1200,10 @@ int wilc_wlan_start(struct wilc *wilc)
 	} else if (wilc->io_type == WILC_HIF_SPI) {
 		reg = 1;
 	}
-	acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
+	ret = acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
+	if (ret)
+		return ret;
+
 	ret = wilc->hif_func->hif_write_reg(wilc, WILC_VMM_CORE_CFG, reg);
 	if (ret)
 		goto release;
@@ -1181,16 +1234,18 @@ int wilc_wlan_start(struct wilc *wilc)
 	wilc->hif_func->hif_read_reg(wilc, WILC_GLB_RESET_0, &reg);
 
 release:
-	release_bus(wilc, WILC_BUS_RELEASE_ONLY);
-	return ret;
+	rv = release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+	return ret ? ret : rv;
 }
 
 int wilc_wlan_stop(struct wilc *wilc, struct wilc_vif *vif)
 {
 	u32 reg = 0;
-	int ret;
+	int ret, rv;
 
-	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+	ret = acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+	if (ret)
+		return ret;
 
 	ret = wilc->hif_func->hif_read_reg(wilc, GLOBAL_MODE_CONTROL, &reg);
 	if (ret)
@@ -1226,9 +1281,9 @@ int wilc_wlan_stop(struct wilc *wilc, struct wilc_vif *vif)
 	ret = 0;
 release:
 	/* host comm is disabled - we can't issue sleep command anymore: */
-	release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+	rv = release_bus(wilc, WILC_BUS_RELEASE_ONLY);
 
-	return ret;
+	return ret ? ret : rv;
 }
 
 void wilc_wlan_cleanup(struct net_device *dev)
@@ -1433,11 +1488,13 @@ static int wilc_get_chipid(struct wilc *wilc)
 static int init_chip(struct net_device *dev)
 {
 	u32 reg;
-	int ret = 0;
+	int ret, rv;
 	struct wilc_vif *vif = netdev_priv(dev);
 	struct wilc *wilc = vif->wilc;
 
-	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+	ret = acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+	if (ret)
+		return ret;
 
 	ret = wilc_get_chipid(wilc);
 	if (ret)
@@ -1469,17 +1526,19 @@ static int init_chip(struct net_device *dev)
 	}
 
 release:
-	release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+	rv = release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
 
-	return ret;
+	return ret ? ret : rv;
 }
 
 int wilc_load_mac_from_nv(struct wilc *wl)
 {
-	int ret = -EINVAL;
+	int ret, rv;
 	unsigned int i;
 
-	acquire_bus(wl, WILC_BUS_ACQUIRE_AND_WAKEUP);
+	ret = acquire_bus(wl, WILC_BUS_ACQUIRE_AND_WAKEUP);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < WILC_NVMEM_MAX_NUM_BANK; i++) {
 		int bank_offset = get_bank_offset_from_bank_index(i);
@@ -1518,14 +1577,14 @@ int wilc_load_mac_from_nv(struct wilc *wl)
 		break;
 	}
 
-	release_bus(wl, WILC_BUS_RELEASE_ALLOW_SLEEP);
-	return ret;
+	rv = release_bus(wl, WILC_BUS_RELEASE_ALLOW_SLEEP);
+	return ret ? ret : rv;
 }
 EXPORT_SYMBOL_GPL(wilc_load_mac_from_nv);
 
 int wilc_wlan_init(struct net_device *dev)
 {
-	int ret = 0;
+	int ret = 0, rv;
 	struct wilc_vif *vif = netdev_priv(dev);
 	struct wilc *wilc;
 
@@ -1534,11 +1593,16 @@ int wilc_wlan_init(struct net_device *dev)
 	wilc->quit = 0;
 
 	if (!wilc->hif_func->hif_is_init(wilc)) {
-		acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
+		ret = acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
+		if (ret)
+			return ret;
+
 		ret = wilc->hif_func->hif_init(wilc, false);
 		if (!ret)
 			ret = wilc_get_chipid(wilc);
-		release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+		rv = release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+		if (!ret && rv)
+			ret = rv;
 		if (ret)
 			goto fail;
 
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
index e75a5c8aaecec..4e2b0c4ac1e21 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -436,8 +436,8 @@ netdev_tx_t wilc_mac_xmit(struct sk_buff *skb, struct net_device *dev);
 
 void wilc_wfi_p2p_rx(struct wilc_vif *vif, u8 *buff, u32 size);
 bool wilc_wfi_mgmt_frame_rx(struct wilc_vif *vif, u8 *buff, u32 size);
-void host_wakeup_notify(struct wilc *wilc);
-void host_sleep_notify(struct wilc *wilc);
+int host_wakeup_notify(struct wilc *wilc);
+int host_sleep_notify(struct wilc *wilc);
 int wilc_send_config_pkt(struct wilc_vif *vif, u8 mode, struct wid *wids,
 			 u32 count);
 int wilc_wlan_init(struct net_device *dev);
-- 
2.45.2


