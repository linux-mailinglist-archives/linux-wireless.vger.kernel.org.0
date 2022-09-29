Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F065EEC55
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 05:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbiI2DKR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 23:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbiI2DKO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 23:10:14 -0400
Received: from smtp15.infineon.com (smtp15.infineon.com [217.10.52.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3431748EBC
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 20:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664421013; x=1695957013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3N5v7EQod9pUtZBMmSFk9STkluMPgluIY5SwpJwibEg=;
  b=Sy/21JX/3QbPUMNziX3LnWTynN0HshZqmFv5se+Vcdj5Yzs6tKgLkcRk
   KqjIPic3jFQg4R/NIvELOl7Q2wnkmEt6zdGKBpZZezuJ1dGxxeFKjIeEx
   L8tmeAz7hI5C8TMI6qPvuW5OBVWiK2ffbSeb4bcfc/ilTo/rQEYGzxked
   A=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="143262921"
X-IronPort-AV: E=Sophos;i="5.93,353,1654552800"; 
   d="scan'208";a="143262921"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 05:10:10 +0200
Received: from MUCSE812.infineon.com (MUCSE812.infineon.com [172.23.29.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 05:10:09 +0200 (CEST)
Received: from MUCSE804.infineon.com (172.23.29.30) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 05:10:09 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay1.infineon.com (172.23.29.5) with Microsoft SMTP Server id
 15.2.986.29; Thu, 29 Sep 2022 05:10:09 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="264141845"
X-IronPort-AV: E=Sophos;i="5.93,353,1654552800"; 
   d="scan'208";a="264141845"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 29 Sep 2022 05:10:09 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Wed, 28 Sep 2022
 22:10:08 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id E9E561004E0;
        Wed, 28 Sep 2022 22:10:07 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 E6737980481; Wed, 28 Sep 2022 22:10:07 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH 1/3] brcmfmac: add a timer to read console periodically in PCIE bus
Date:   Wed, 28 Sep 2022 22:09:59 -0500
Message-ID: <20220929031001.9962-2-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220929031001.9962-1-ian.lin@infineon.com>
References: <20220929031001.9962-1-ian.lin@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wright Feng <wright.feng@cypress.com>

Currently, host only reads console buffer when receiving mailbox data or
hit crash with PCIE bus. Therefore, we add timer in PCIE code to read
console buffer periodically to help developer and user check firmware
message when there is no data transmission between host and dongle.

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 .../broadcom/brcm80211/brcmfmac/bus.h         |   6 +
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 125 ++++++++++++++++++
 .../broadcom/brcm80211/brcmfmac/sdio.c        |   2 -
 3 files changed, 131 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
index 2208ab3aa795..60f5645aead3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
@@ -24,6 +24,12 @@
 #define BRCMF_NROF_COMMON_MSGRINGS	(BRCMF_NROF_H2D_COMMON_MSGRINGS + \
 					 BRCMF_NROF_D2H_COMMON_MSGRINGS)
 
+/* The interval to poll console */
+#define BRCMF_CONSOLE	10
+
+/* The maximum console interval value (5 mins) */
+#define MAX_CONSOLE_INTERVAL	(5 * 60)
+
 /* The level of bus communication with the dongle */
 enum brcmf_bus_state {
 	BRCMF_BUS_DOWN,		/* Not ready for frame transfers */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 80083f9ea311..2b7ebbd7b5b4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -12,6 +12,8 @@
 #include <linux/interrupt.h>
 #include <linux/bcma/bcma.h>
 #include <linux/sched.h>
+#include <linux/sched/signal.h>
+#include <linux/kthread.h>
 #include <linux/io.h>
 #include <asm/unaligned.h>
 
@@ -340,6 +342,11 @@ struct brcmf_pciedev_info {
 			  u16 value);
 	struct brcmf_mp_device *settings;
 	struct brcmf_otp_params otp;
+#ifdef DEBUG
+	u32 console_interval;
+	bool console_active;
+	struct timer_list timer;
+#endif
 };
 
 struct brcmf_pcie_ringbuf {
@@ -440,6 +447,9 @@ static void brcmf_pcie_setup(struct device *dev, int ret,
 			     struct brcmf_fw_request *fwreq);
 static struct brcmf_fw_request *
 brcmf_pcie_prepare_fw_request(struct brcmf_pciedev_info *devinfo);
+static void
+brcmf_pcie_fwcon_timer(struct brcmf_pciedev_info *devinfo, bool active);
+static void brcmf_pcie_debugfs_create(struct device *dev);
 
 static u16
 brcmf_pcie_read_reg16(struct brcmf_pciedev_info *devinfo, u32 reg_offset)
@@ -1413,6 +1423,11 @@ static int brcmf_pcie_init_scratchbuffers(struct brcmf_pciedev_info *devinfo)
 
 static void brcmf_pcie_down(struct device *dev)
 {
+	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
+	struct brcmf_pciedev *pcie_bus_dev = bus_if->bus_priv.pcie;
+	struct brcmf_pciedev_info *devinfo = pcie_bus_dev->devinfo;
+
+	brcmf_pcie_fwcon_timer(devinfo, false);
 }
 
 static int brcmf_pcie_preinit(struct device *dev)
@@ -1547,6 +1562,7 @@ static const struct brcmf_bus_ops brcmf_pcie_bus_ops = {
 	.get_memdump = brcmf_pcie_get_memdump,
 	.get_blob = brcmf_pcie_get_blob,
 	.reset = brcmf_pcie_reset,
+	.debugfs_create = brcmf_pcie_debugfs_create,
 };
 
 
@@ -2123,6 +2139,8 @@ static void brcmf_pcie_setup(struct device *dev, int ret,
 
 	brcmf_pcie_bus_console_read(devinfo, false);
 
+	brcmf_pcie_fwcon_timer(devinfo, true);
+
 	return;
 
 fail:
@@ -2197,6 +2215,105 @@ brcmf_pcie_prepare_fw_request(struct brcmf_pciedev_info *devinfo)
 	return fwreq;
 }
 
+#ifdef DEBUG
+static void
+brcmf_pcie_fwcon_timer(struct brcmf_pciedev_info *devinfo, bool active)
+{
+	if (!active) {
+		if (devinfo->console_active) {
+			del_timer_sync(&devinfo->timer);
+			devinfo->console_active = false;
+		}
+		return;
+	}
+
+	/* don't start the timer */
+	if (devinfo->state != BRCMFMAC_PCIE_STATE_UP ||
+	    !devinfo->console_interval || !BRCMF_FWCON_ON())
+		return;
+
+	if (!devinfo->console_active) {
+		devinfo->timer.expires = jiffies + devinfo->console_interval;
+		add_timer(&devinfo->timer);
+		devinfo->console_active = true;
+	} else {
+		/* Reschedule the timer */
+		mod_timer(&devinfo->timer, jiffies + devinfo->console_interval);
+	}
+}
+
+static void
+brcmf_pcie_fwcon(struct timer_list *t)
+{
+	struct brcmf_pciedev_info *devinfo = from_timer(devinfo, t, timer);
+
+	if (!devinfo->console_active)
+		return;
+
+	brcmf_pcie_bus_console_read(devinfo, false);
+
+	/* Reschedule the timer if console interval is not zero */
+	mod_timer(&devinfo->timer, jiffies + devinfo->console_interval);
+}
+
+static int brcmf_pcie_console_interval_get(void *data, u64 *val)
+{
+	struct brcmf_pciedev_info *devinfo = data;
+
+	*val = devinfo->console_interval;
+
+	return 0;
+}
+
+static int brcmf_pcie_console_interval_set(void *data, u64 val)
+{
+	struct brcmf_pciedev_info *devinfo = data;
+
+	if (val > MAX_CONSOLE_INTERVAL)
+		return -EINVAL;
+
+	devinfo->console_interval = val;
+
+	if (!val && devinfo->console_active)
+		brcmf_pcie_fwcon_timer(devinfo, false);
+	else if (val)
+		brcmf_pcie_fwcon_timer(devinfo, true);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(brcmf_pcie_console_interval_fops,
+			brcmf_pcie_console_interval_get,
+			brcmf_pcie_console_interval_set,
+			"%llu\n");
+
+static void brcmf_pcie_debugfs_create(struct device *dev)
+{
+	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
+	struct brcmf_pub *drvr = bus_if->drvr;
+	struct brcmf_pciedev *pcie_bus_dev = bus_if->bus_priv.pcie;
+	struct brcmf_pciedev_info *devinfo = pcie_bus_dev->devinfo;
+	struct dentry *dentry = brcmf_debugfs_get_devdir(drvr);
+
+	if (IS_ERR_OR_NULL(dentry))
+		return;
+
+	devinfo->console_interval = BRCMF_CONSOLE;
+
+	debugfs_create_file("console_interval", 0644, dentry, devinfo,
+			    &brcmf_pcie_console_interval_fops);
+}
+
+#else
+void brcmf_pcie_fwcon_timer(struct brcmf_pciedev_info *devinfo, bool active)
+{
+}
+
+static void brcmf_pcie_debugfs_create(struct device *dev)
+{
+}
+#endif
+
 static int
 brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
@@ -2278,6 +2395,11 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto fail_brcmf;
 	}
 
+#ifdef DEBUG
+	/* Set up the fwcon timer */
+	timer_setup(&devinfo->timer, brcmf_pcie_fwcon, 0);
+#endif
+
 	fwreq = brcmf_pcie_prepare_fw_request(devinfo);
 	if (!fwreq) {
 		ret = -ENOMEM;
@@ -2323,6 +2445,7 @@ brcmf_pcie_remove(struct pci_dev *pdev)
 
 	devinfo = bus->bus_priv.pcie->devinfo;
 	brcmf_pcie_bus_console_read(devinfo, false);
+	brcmf_pcie_fwcon_timer(devinfo, false);
 
 	devinfo->state = BRCMFMAC_PCIE_STATE_DOWN;
 	if (devinfo->ci)
@@ -2366,6 +2489,7 @@ static int brcmf_pcie_pm_enter_D3(struct device *dev)
 	bus = dev_get_drvdata(dev);
 	devinfo = bus->bus_priv.pcie->devinfo;
 
+	brcmf_pcie_fwcon_timer(devinfo, false);
 	brcmf_bus_change_state(bus, BRCMF_BUS_DOWN);
 
 	devinfo->mbdata_completed = false;
@@ -2409,6 +2533,7 @@ static int brcmf_pcie_pm_leave_D3(struct device *dev)
 		brcmf_bus_change_state(bus, BRCMF_BUS_UP);
 		brcmf_pcie_intr_enable(devinfo);
 		brcmf_pcie_hostready(devinfo);
+		brcmf_pcie_fwcon_timer(devinfo, true);
 		return 0;
 	}
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 465d95d83759..deb0199fcf8c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -135,8 +135,6 @@ struct rte_console {
 
 #define BRCMF_FIRSTREAD	(1 << 6)
 
-#define BRCMF_CONSOLE	10	/* watchdog interval to poll console */
-
 /* SBSDIO_DEVICE_CTL */
 
 /* 1: device will assert busy signal when receiving CMD53 */
-- 
2.25.0

