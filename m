Return-Path: <linux-wireless+bounces-14415-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975B29ACD8D
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 16:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B890B1C25503
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 14:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BBB1E1027;
	Wed, 23 Oct 2024 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="GwdDTWVP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4D31CC174;
	Wed, 23 Oct 2024 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694507; cv=none; b=rEYb3Pkv5mkMvTktAQ3szu+zK8CrCz9cap0UQo3bxSsAglyRurizktRQSA9JS9oC4iAc7OGF4RSenoX2mLzrrrTBT4+CS+vdyIsbepDmBGtyebidYSGYai8mlHVwxE3erUDnP+ahJelL3IxajNBthNDa2WlDrUjPQdMA/xqzLoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694507; c=relaxed/simple;
	bh=MbL4TK7e4F9mQWBrbWt2fNvIcVgCahBYUpd5PNn08l0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RLayUACFeXhZjO8/Fl5jIgQoHpmphFgbzQNwmTg/6xKCb7F4I4OyEufZdY2iaNLBPTny/is9a+0g/2N7U3ARt2iNwWKHQOYak+Jnl4hFcla8tZ1jwmLt+CGKwBVlVc6GVrsRP0uqaIUGTgDiiZKcfENI2dtJl3dqChJaU0F/j9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=GwdDTWVP; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 7EE01892EA;
	Wed, 23 Oct 2024 16:41:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729694498;
	bh=NbyDjcyzQcgfm2WRkKIULnbopO/V/TOYSiXzHJ8t8lo=;
	h=From:To:Cc:Subject:Date:From;
	b=GwdDTWVP4+pBDpe7wRpOuKU9x/3Rc/vsI0bB0tu/ERY3+lSwYoZ7IdH/kO8C6O1yL
	 T7oMyfaAdHQmoHWJkfZyZUy2A+MIrRQGGmFGj3tzP/vz3JBR4H7ZmnFfSo2lJOLgd0
	 279TnisFmoTtHhUbPzHDhCZT1sMvDaSF3lXOB0Z31aR+Qd8j0zbl50nH9dgdbgG8lZ
	 5fU7yr08kt9hXoacgLmySNiF4BPOHkges9lIVsAY39BGet7Qx/Mb2cZtNqhHHU7n8F
	 /QkT3W8fNc4NiQQBQE83l1pylJjVB0Cs8hhZ1Gjp0NjxQjh4wTQlqkmhc+mETXpJB8
	 Yi9ZjmZdkpdHA==
From: Marek Vasut <marex@denx.de>
To: linux-wireless@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Adham Abozaeid <adham.abozaeid@microchip.com>,
	Ajay Singh <ajay.kathat@microchip.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
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
Subject: [PATCH v2] wifi: wilc1000: Rework bus locking
Date: Wed, 23 Oct 2024 16:41:21 +0200
Message-ID: <20241023144125.80296-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

The bus locking in this driver is broken and produces subtle race
condition with ksdioirqd and its mmc_claim_host()/mmc_release_host()
usage in case of SDIO bus. Rework the locking to avoid this race
condition.

The problem is the hif_cs mutex used in acquire_bus()/release_bus(),
which makes it look like calling acquire_bus() results in exclusive
access to the bus, but that is not true for SDIO bus. For SDIO bus,
to obtain exclusive access (any access, really), it is necessary to
call sdio_claim_host(), which is a wrapper around mmc_claim_host(),
which does its own locking. The acquire_bus() does not do that, but
the SDIO interface implementation does call sdio_claim_host() and
sdio_release_host() every single command, which is problematic. To
make things worse, wilc_sdio_interrupt() implementation called from
ksdioirqd first calls sdio_release_host(), then interrupt handling
and finally sdio_claim_host().

The core problem is that sdio_claim_host() should not be done per
command, but has to be done per register/data IO which consists of
multiple commands. Usually the WILC register read/write consists of
3x CMD52 to push in CSA pointer address and 1x CMD53 to read/write
data to that address. Most other accesses are also composed of
multiple commands.

Currently, if ksdioirqd wakes up and attempts to read SDIO_CCCR_INTx
to get pending SDIO IRQs in sdio_get_pending_irqs(), it can easily
perform that transfer between two consecutive CMD52 which are pushing
in the CSA pointer address and possibly disrupt the WILC operation.
This is undesired behavior.

Rework the locking.

Introduce new .hif_claim/.hif_release callbacks which implement bus
specific locking. Lock/unlock SDIO bus access using sdio_claim_host()
and sdio_release_host(), lock/unlock SPI bus access using spi_bus_lock()
and spi_bus_unlock(), and get rid of hif_cs mutex. Make acquire_bus()
and release_bus() call the .hif_claim/.hif_release() callbacks.

Remove any SDIO bus locking used directly in commands and the broken
SDIO bus unlocking in wilc_sdio_interrupt(), this is no longer needed.
Fix up SDIO initialization code which newly needs sdio_claim_host()
and sdio_release_host(), since it cannot depend on the locking being
done per-command anymore.

Infograpics. With current code, this can happen, which is not good,
because transfers from multiple threads can be interleaved and
interfere with each other:

"
thread 1                     |  thread2
do_some_higher_level_op() {  |
 ...                         |
 read_register_0x3b0000() {  |
  claim_bus                  |
  CMD52 0x00                 |
  release bus                |  ksdioirqd() {
                             |    claim_bus
                             |    CMD52 0x0f, lets read SDIO_CCCR_INTx
                             |    release_bus
  claim bus                  |  }
  CMD52 0x00                 |
  release_bus                |
  claim_bus                  |
  CMD52 0x3b                 |
  release_bus                |
  claim_bus                  |
  CMD53 lets read data       |
  release_bus                |
 }                           |
 ...                         |
}                            |
"

What should happen is either:

"
thread 1                     |  thread2
                             |  ksdioirqd() { // option 1
                             |    claim_bus
                             |    CMD52 0x0f, lets read SDIO_CCCR_INTx
do_some_higher_level_op() {  |    release_bus
 claim_bus                   |  }
 ...                         |
 read_register_0x3b0000 {    |
  CMD52 0x00                 |
  CMD52 0x00                 |
  CMD52 0x3b                 |
  CMD53 lets read data       |
 }                           |
 ...                         |
 read_another_register()     |
 ...                         |
 release_bus                 |  ksdioirqd() { // option 2
}                            |    claim_bus
                             |    CMD52 0x0f, lets read SDIO_CCCR_INTx
                             |    release_bus
                             |  }
"

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
V2: Use spi_bus_lock() and spi_bus_unlock() to get rid of hif_cs mutex
---
NOTE: I only tested the SDIO part
---
 .../wireless/microchip/wilc1000/cfg80211.c    |  2 -
 .../net/wireless/microchip/wilc1000/netdev.c  |  2 -
 .../net/wireless/microchip/wilc1000/netdev.h  |  3 --
 .../net/wireless/microchip/wilc1000/sdio.c    | 40 ++++++++++++-------
 drivers/net/wireless/microchip/wilc1000/spi.c | 13 ++++++
 .../net/wireless/microchip/wilc1000/wlan.c    | 30 ++++++++++----
 .../net/wireless/microchip/wilc1000/wlan.h    |  2 +
 7 files changed, 63 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index b0dae6f7c633b..9a9fc8e8c8354 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1730,7 +1730,6 @@ static const struct cfg80211_ops wilc_cfg80211_ops = {
 
 static void wlan_init_locks(struct wilc *wl)
 {
-	mutex_init(&wl->hif_cs);
 	mutex_init(&wl->rxq_cs);
 	mutex_init(&wl->cfg_cmd_lock);
 	mutex_init(&wl->vif_mutex);
@@ -1748,7 +1747,6 @@ static void wlan_init_locks(struct wilc *wl)
 
 void wlan_deinit_locks(struct wilc *wilc)
 {
-	mutex_destroy(&wilc->hif_cs);
 	mutex_destroy(&wilc->rxq_cs);
 	mutex_destroy(&wilc->cfg_cmd_lock);
 	mutex_destroy(&wilc->txq_add_to_head_cs);
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 7e84fc0fd9118..22c91a0b9b648 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -468,9 +468,7 @@ static void wilc_wlan_deinitialize(struct net_device *dev)
 
 		if (!wl->dev_irq_num &&
 		    wl->hif_func->disable_interrupt) {
-			mutex_lock(&wl->hif_cs);
 			wl->hif_func->disable_interrupt(wl);
-			mutex_unlock(&wl->hif_cs);
 		}
 		complete(&wl->txq_event);
 
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net/wireless/microchip/wilc1000/netdev.h
index 95bc8b8fe65a5..8bdc27edf00af 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -240,9 +240,6 @@ struct wilc {
 	/* protect rxq_entry_t receiver queue */
 	struct mutex rxq_cs;
 
-	/* lock to protect hif access */
-	struct mutex hif_cs;
-
 	struct completion cfg_event;
 	struct completion sync_event;
 	struct completion txq_event;
diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 760ae9f4a9ce5..2dc7585c3359c 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -56,11 +56,23 @@ struct sdio_cmd53 {
 
 static const struct wilc_hif_func wilc_hif_sdio;
 
-static void wilc_sdio_interrupt(struct sdio_func *func)
+static void wilc_sdio_claim(struct wilc *wilc)
+{
+	struct sdio_func *func = container_of(wilc->dev, struct sdio_func, dev);
+
+	sdio_claim_host(func);
+}
+
+static void wilc_sdio_release(struct wilc *wilc)
 {
+	struct sdio_func *func = container_of(wilc->dev, struct sdio_func, dev);
+
 	sdio_release_host(func);
+}
+
+static void wilc_sdio_interrupt(struct sdio_func *func)
+{
 	wilc_handle_isr(sdio_get_drvdata(func));
-	sdio_claim_host(func);
 }
 
 static int wilc_sdio_cmd52(struct wilc *wilc, struct sdio_cmd52 *cmd)
@@ -69,8 +81,6 @@ static int wilc_sdio_cmd52(struct wilc *wilc, struct sdio_cmd52 *cmd)
 	int ret;
 	u8 data;
 
-	sdio_claim_host(func);
-
 	func->num = cmd->function;
 	if (cmd->read_write) {  /* write */
 		if (cmd->raw) {
@@ -85,8 +95,6 @@ static int wilc_sdio_cmd52(struct wilc *wilc, struct sdio_cmd52 *cmd)
 		cmd->data = data;
 	}
 
-	sdio_release_host(func);
-
 	if (ret)
 		dev_err(&func->dev, "%s..failed, err(%d)\n", __func__, ret);
 	return ret;
@@ -99,8 +107,6 @@ static int wilc_sdio_cmd53(struct wilc *wilc, struct sdio_cmd53 *cmd)
 	struct wilc_sdio *sdio_priv = wilc->bus_data;
 	u8 *buf = cmd->buffer;
 
-	sdio_claim_host(func);
-
 	func->num = cmd->function;
 	func->cur_blksize = cmd->block_size;
 	if (cmd->block_mode)
@@ -128,8 +134,6 @@ static int wilc_sdio_cmd53(struct wilc *wilc, struct sdio_cmd53 *cmd)
 			memcpy(cmd->buffer, buf, size);
 	}
 out:
-	sdio_release_host(func);
-
 	if (ret)
 		dev_err(&func->dev, "%s..failed, err(%d)\n", __func__,  ret);
 
@@ -180,9 +184,11 @@ static int wilc_sdio_probe(struct sdio_func *func,
 		goto dispose_irq;
 	}
 
+	wilc_sdio_claim(wilc);
 	wilc_sdio_init(wilc, false);
 
 	ret = wilc_get_chipid(wilc);
+	wilc_sdio_release(wilc);
 	if (ret)
 		goto dispose_irq;
 
@@ -196,7 +202,9 @@ static int wilc_sdio_probe(struct sdio_func *func,
 		goto dispose_irq;
 	}
 
+	wilc_sdio_claim(wilc);
 	wilc_sdio_deinit(wilc);
+	wilc_sdio_release(wilc);
 
 	vif = wilc_netdev_ifc_init(wilc, "wlan%d", WILC_STATION_MODE,
 				   NL80211_IFTYPE_STATION, false);
@@ -258,9 +266,9 @@ static int wilc_sdio_enable_interrupt(struct wilc *dev)
 	struct sdio_func *func = container_of(dev->dev, struct sdio_func, dev);
 	int ret = 0;
 
-	sdio_claim_host(func);
+	wilc_sdio_claim(dev);
 	ret = sdio_claim_irq(func, wilc_sdio_interrupt);
-	sdio_release_host(func);
+	wilc_sdio_release(dev);
 
 	if (ret < 0) {
 		dev_err(&func->dev, "can't claim sdio_irq, err(%d)\n", ret);
@@ -274,11 +282,11 @@ static void wilc_sdio_disable_interrupt(struct wilc *dev)
 	struct sdio_func *func = container_of(dev->dev, struct sdio_func, dev);
 	int ret;
 
-	sdio_claim_host(func);
+	wilc_sdio_claim(dev);
 	ret = sdio_release_irq(func);
 	if (ret < 0)
 		dev_err(&func->dev, "can't release sdio_irq, err(%d)\n", ret);
-	sdio_release_host(func);
+	wilc_sdio_release(dev);
 }
 
 /********************************************
@@ -1013,6 +1021,8 @@ static const struct wilc_hif_func wilc_hif_sdio = {
 	.disable_interrupt = wilc_sdio_disable_interrupt,
 	.hif_reset = wilc_sdio_reset,
 	.hif_is_init = wilc_sdio_is_init,
+	.hif_claim = wilc_sdio_claim,
+	.hif_release = wilc_sdio_release,
 };
 
 static int wilc_sdio_suspend(struct device *dev)
@@ -1053,7 +1063,9 @@ static int wilc_sdio_resume(struct device *dev)
 	if (!IS_ERR(wilc->rtc_clk))
 		clk_prepare_enable(wilc->rtc_clk);
 
+	wilc_sdio_claim(wilc);
 	wilc_sdio_init(wilc, true);
+	wilc_sdio_release(wilc);
 	wilc_sdio_enable_interrupt(wilc);
 
 	return host_wakeup_notify(wilc);
diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index ce2a9cdd6aa78..c4fc6676b598b 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -1105,6 +1105,19 @@ static int wilc_spi_write(struct wilc *wilc, u32 addr, u8 *buf, u32 size)
  *      Bus interfaces
  *
  ********************************************/
+static void wilc_spi_claim(struct wilc *wilc)
+{
+	struct spi_device *spi = to_spi_device(wilc->dev);
+
+	spi_bus_lock(spi->controller);
+}
+
+static void wilc_spi_release(struct wilc *wilc)
+{
+	struct spi_device *spi = to_spi_device(wilc->dev);
+
+	spi_bus_unlock(spi->controller);
+}
 
 static int wilc_spi_reset(struct wilc *wilc)
 {
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 9d80adc45d6be..b149734f19a05 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -767,25 +767,37 @@ static int chip_wakeup(struct wilc *wilc)
 
 static inline int acquire_bus(struct wilc *wilc, enum bus_acquire acquire)
 {
-	int ret = 0;
+	const struct wilc_hif_func *hif_func = wilc->hif_func;
+	int ret;
 
-	mutex_lock(&wilc->hif_cs);
-	if (acquire == WILC_BUS_ACQUIRE_AND_WAKEUP && wilc->power_save_mode) {
-		ret = chip_wakeup(wilc);
-		if (ret)
-			mutex_unlock(&wilc->hif_cs);
-	}
+	hif_func->hif_claim(wilc);
+
+	if (!wilc->power_save_mode)
+		return 0;
 
+	if (acquire != WILC_BUS_ACQUIRE_AND_WAKEUP)
+		return 0;
+
+	ret = chip_wakeup(wilc);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	hif_func->hif_release(wilc);
 	return ret;
 }
 
 static inline int release_bus(struct wilc *wilc, enum bus_release release)
 {
+	const struct wilc_hif_func *hif_func = wilc->hif_func;
 	int ret = 0;
 
 	if (release == WILC_BUS_RELEASE_ALLOW_SLEEP && wilc->power_save_mode)
 		ret = chip_allow_sleep(wilc);
-	mutex_unlock(&wilc->hif_cs);
+
+	hif_func->hif_release(wilc);
 
 	return ret;
 }
@@ -1447,7 +1459,9 @@ void wilc_wlan_cleanup(struct net_device *dev)
 	wilc->rx_buffer = NULL;
 	kfree(wilc->tx_buffer);
 	wilc->tx_buffer = NULL;
+	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
 	wilc->hif_func->hif_deinit(wilc);
+	release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
 }
 
 static int wilc_wlan_cfg_commit(struct wilc_vif *vif, int type,
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
index b9e7f9222eadd..ade2db95e8a0f 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -403,6 +403,8 @@ struct wilc_hif_func {
 	void (*disable_interrupt)(struct wilc *nic);
 	int (*hif_reset)(struct wilc *wilc);
 	bool (*hif_is_init)(struct wilc *wilc);
+	void (*hif_claim)(struct wilc *wilc);
+	void (*hif_release)(struct wilc *wilc);
 };
 
 #define WILC_MAX_CFG_FRAME_SIZE		1468
-- 
2.45.2


