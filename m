Return-Path: <linux-wireless+bounces-3265-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BDB84C430
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 05:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA4A28C31C
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 04:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF001CD19;
	Wed,  7 Feb 2024 04:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b="jYfAad14"
X-Original-To: linux-wireless@vger.kernel.org
Received: from o1.ptr2625.egauge.net (o1.ptr2625.egauge.net [167.89.112.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565541CD2B
	for <linux-wireless@vger.kernel.org>; Wed,  7 Feb 2024 04:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.112.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281374; cv=none; b=RSFk75t/qeh7DPf+Pf+CYlIsSilQKLBi4vSPQV+A1228ya2D749V0F4eBGLJKdQAMxLKhwp8o42E93WX+Vlup10I6dxDWHAbrGkNe+IG+jvDXI6SOh4lVhD8lCNfT8z5VN3HqmCiZeuKa5LGbtfxVR2NbASeS2TDkbsxypHz0MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281374; c=relaxed/simple;
	bh=EsUzYfZvuYNGoGV/bwUpDJPRGQQ0Flomdmxmq++U+eQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=bDi4ISI8mjNkgqIygONtZ+IL55mny3Is7lxyJ62zaKdYr2FEeZmMQUWQqW+AyAFNavB5daCiCVH1twHJHgDIWvyVvMIf20O6cc2Mzyl5nRggHPXiJ8e4An8RhuJxWCi69kzEncVSkpihwM2Vx5WG21vKaKZs95mdYCmffbzFRO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net; spf=pass smtp.mailfrom=em1190.egauge.net; dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b=jYfAad14; arc=none smtp.client-ip=167.89.112.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1190.egauge.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
	h=from:subject:mime-version:to:cc:content-transfer-encoding:
	content-type:cc:content-type:from:subject:to;
	s=sgd; bh=WCW5ZY870loXovr8nVzsoWZsaP+qBNPKXQxv9TQfPjU=;
	b=jYfAad14GZqkWxq2/cmggJT/tXD7CsXrl1kUzGtEU71bv2TOpCGsIi1nxyDbg9TqUc8B
	4G5Ng0YD71Uzz2sqBF92tWIbWSK/+gJGkVI9oqaTJ3dXL96Ufsp+koUgHsgUdGLV2F9zxk
	EGopvwiXglBbpzcM0cwm9Wyd+cCTTJMz+tCrSGZMEjmmYpC7VpVmoiYQZJLbs8jMROnpqg
	CusUPrAT9mhs7f9FbmdpWxx2o5xIZw1tmy8ddj83kgBVlSVl/N2uZw3UO7TJG0w6bpOd27
	cnWf7Csz2wEDpY/s+MSopH+hX2JNdt2hzzX0uRDL/hYA7tCYPZFljkgup9iFdz4g==
Received: by filterdrecv-5bbdbb56cd-n2nhf with SMTP id filterdrecv-5bbdbb56cd-n2nhf-1-65C30BD8-14
        2024-02-07 04:49:29.025754919 +0000 UTC m=+2302353.555471446
Received: from pearl.egauge.net (unknown)
	by geopod-ismtpd-11 (SG)
	with ESMTP
	id idqDJ146RUul8xKL34ylTQ
	Wed, 07 Feb 2024 04:49:28.837 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
	id DB9C57008B0; Tue,  6 Feb 2024 21:49:27 -0700 (MST)
From: David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH v5] wifi: wilc1000: validate chip id during bus probe
Date: Wed, 07 Feb 2024 04:49:29 +0000 (UTC)
Message-Id: <20240207044559.2717200-1-davidm@egauge.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvCX1o7o2ib3iMxjb2?=
 =?us-ascii?Q?IjR2W5MdB1wKbJagxR3es2pR0kJFXqkTqAOZ=2F7C?=
 =?us-ascii?Q?jjxSb=2F3CSJvXunXAzmJ4luPFiDGnj0oxW4NzjTX?=
 =?us-ascii?Q?+r7HfZgrB64NOtHaxyOXz3H+ESTfUCTju9zPWUd?=
 =?us-ascii?Q?Gw9J0zBKn72c6y6eYgzNF9TUt4DXjqp5WNZwH3B?=
 =?us-ascii?Q?GeQ63T2QulDMh2MrXxlDg=3D=3D?=
To: linux-wireless@vger.kernel.org
Cc: Ajay.Kathat@microchip.com, alexis.lothore@bootlin.com, kvalo@kernel.org,
	David Mosberger-Tang <davidm@egauge.net>
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii

Previously, the driver created a net device (typically wlan0) as soon
as the module was loaded.  This commit changes the driver to follow
normal Linux convention of creating the net device only when bus
probing detects a supported chip.

Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
---
 drivers/net/wireless/microchip/wilc1000/spi.c | 69 +++++++++++++++----
 .../net/wireless/microchip/wilc1000/wlan.c    |  3 +-
 .../net/wireless/microchip/wilc1000/wlan.h    |  1 +
 3 files changed, 57 insertions(+), 16 deletions(-)

---
changelog:
V1: original version
V2: Add missing forward declarations
V3: Add missing forward declarations, actually :-(
V4: - rearranged function order to improve readability
    - now relative to wireless-next repository
    - avoid change error return value and have lower-level functions
      directly return -ENODEV instead
    - removed any mention of WILC3000
    - export and use existing is_wilc1000() for chipid validation
    - replaced strbool() function with open code
V5: - add clk_disable_unprepare() to power_down path as suggested by Ajay
    - don't re-write error codes as suggested by Alexi

 drivers/net/wireless/microchip/wilc1000/spi.c | 74 ++++++++++++++-----
 .../net/wireless/microchip/wilc1000/wlan.c    |  3 +-
 .../net/wireless/microchip/wilc1000/wlan.h    |  1 +
 3 files changed, 59 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index 7eb0f8a421a3..fdbd46b882b9 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -42,7 +42,7 @@ MODULE_PARM_DESC(enable_crc16,
 #define WILC_SPI_RSP_HDR_EXTRA_DATA	8
 
 struct wilc_spi {
-	bool isinit;		/* true if SPI protocol has been configured */
+	bool isinit;		/* true if wilc_spi_init was successful */
 	bool probing_crc;	/* true if we're probing chip's CRC config */
 	bool crc7_enabled;	/* true if crc7 is currently enabled */
 	bool crc16_enabled;	/* true if crc16 is currently enabled */
@@ -55,6 +55,8 @@ struct wilc_spi {
 static const struct wilc_hif_func wilc_hif_spi;
 
 static int wilc_spi_reset(struct wilc *wilc);
+static int wilc_spi_configure_bus_protocol(struct wilc *wilc);
+static int wilc_validate_chipid(struct wilc *wilc);
 
 /********************************************
  *
@@ -232,8 +234,27 @@ static int wilc_bus_probe(struct spi_device *spi)
 	}
 	clk_prepare_enable(wilc->rtc_clk);
 
+	dev_info(&spi->dev, "Selected CRC config: crc7=%s, crc16=%s\n",
+		 enable_crc7 ? "on" : "off", enable_crc16 ? "on" : "off");
+
+	/* we need power to configure the bus protocol and to read the chip id: */
+
+	wilc_wlan_power(wilc, true);
+
+	ret = wilc_spi_configure_bus_protocol(wilc);
+	if (ret)
+		goto power_down;
+
+	ret = wilc_validate_chipid(wilc);
+	if (ret)
+		goto power_down;
+
+	wilc_wlan_power(wilc, false);
 	return 0;
 
+power_down:
+	clk_disable_unprepare(wilc->rtc_clk);
+	wilc_wlan_power(wilc, false);
 netdev_cleanup:
 	wilc_netdev_cleanup(wilc);
 free:
@@ -1101,26 +1122,34 @@ static int wilc_spi_deinit(struct wilc *wilc)
 
 static int wilc_spi_init(struct wilc *wilc, bool resume)
 {
-	struct spi_device *spi = to_spi_device(wilc->dev);
 	struct wilc_spi *spi_priv = wilc->bus_data;
-	u32 reg;
-	u32 chipid;
-	int ret, i;
+	int ret;
 
 	if (spi_priv->isinit) {
 		/* Confirm we can read chipid register without error: */
-		ret = wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
-		if (ret == 0)
+		if (wilc_validate_chipid(wilc) == 0)
 			return 0;
-
-		dev_err(&spi->dev, "Fail cmd read chip id...\n");
 	}
 
 	wilc_wlan_power(wilc, true);
 
-	/*
-	 * configure protocol
-	 */
+	ret = wilc_spi_configure_bus_protocol(wilc);
+	if (ret) {
+		wilc_wlan_power(wilc, false);
+		return ret;
+	}
+
+	spi_priv->isinit = true;
+
+	return 0;
+}
+
+static int wilc_spi_configure_bus_protocol(struct wilc *wilc)
+{
+	struct spi_device *spi = to_spi_device(wilc->dev);
+	struct wilc_spi *spi_priv = wilc->bus_data;
+	u32 reg;
+	int ret, i;
 
 	/*
 	 * Infer the CRC settings that are currently in effect.  This
@@ -1172,6 +1201,15 @@ static int wilc_spi_init(struct wilc *wilc, bool resume)
 
 	spi_priv->probing_crc = false;
 
+	return 0;
+}
+
+static int wilc_validate_chipid(struct wilc *wilc)
+{
+	struct spi_device *spi = to_spi_device(wilc->dev);
+	u32 chipid;
+	int ret;
+
 	/*
 	 * make sure can read chip id without protocol error
 	 */
@@ -1180,9 +1218,10 @@ static int wilc_spi_init(struct wilc *wilc, bool resume)
 		dev_err(&spi->dev, "Fail cmd read chip id...\n");
 		return ret;
 	}
-
-	spi_priv->isinit = true;
-
+	if (!is_wilc1000(chipid)) {
+		dev_err(&spi->dev, "Unknown chip id 0x%x\n", chipid);
+		return -ENODEV;
+	}
 	return 0;
 }
 
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 6b2f2269ddf8..3130a3ea8d71 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -12,10 +12,11 @@
 
 #define WAKE_UP_TRIAL_RETRY		10000
 
-static inline bool is_wilc1000(u32 id)
+bool is_wilc1000(u32 id)
 {
 	return (id & (~WILC_CHIP_REV_FIELD)) == WILC_1000_BASE_ID;
 }
+EXPORT_SYMBOL_GPL(is_wilc1000);
 
 static inline void acquire_bus(struct wilc *wilc, enum bus_acquire acquire)
 {
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
index f02775f7e41f..ebdfb0afaf71 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -409,6 +409,7 @@ struct wilc_cfg_rsp {
 
 struct wilc_vif;
 
+bool is_wilc1000(u32 id);
 int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
 				u32 buffer_size);
 int wilc_wlan_start(struct wilc *wilc);
-- 
2.34.1


