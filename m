Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043A64B3DBC
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Feb 2022 22:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbiBMVbr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Feb 2022 16:31:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238362AbiBMVbm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Feb 2022 16:31:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68B9753B48
        for <linux-wireless@vger.kernel.org>; Sun, 13 Feb 2022 13:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644787894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ISiWi7uw9QaoI83fopDw/+FnuaHWer+3fN5HCw2quzg=;
        b=Y9pLuSXeo6vqitXBiZDggdfW4TKwp1nUjg88MC0N9yUvvBr45XdETdM/qUZvs2O7iSUPeY
        fNzR5M2PUCTIZ/ghx8Qz1IUOdrrxYMRmHz520UUuiQt++fHz4AdUvIAXTQN/ECPjuLrQdp
        bZT8y8ypP3qwTgw444yhrcq/czu9EKw=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-q9kWHyP_NuqBqiGAQFGTHw-1; Sun, 13 Feb 2022 16:31:33 -0500
X-MC-Unique: q9kWHyP_NuqBqiGAQFGTHw-1
Received: by mail-ot1-f72.google.com with SMTP id p17-20020a0568301d5100b005a3cd7c1e0bso9224081oth.7
        for <linux-wireless@vger.kernel.org>; Sun, 13 Feb 2022 13:31:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ISiWi7uw9QaoI83fopDw/+FnuaHWer+3fN5HCw2quzg=;
        b=Xl2p75gOjoapBzeS0qTVDJKTa8G9apHsia1m5XnQiws8Q7YJO8tKjUIO5j9X7cCb2o
         eeLOMRlEDYE4eKTQUGQ6i/FxfojGKeUCiK+VXt7bZ/NjvJF1fy2OwJv6PsCehp9NUkHa
         gYbFSyxZaDEfJIueYPSBdenRbcEePydQIyFUQrp+NP3C76YIJ0kW40mBPzWnMH5MMFEX
         d1x1NigooMrL9NYWd1fNvZ/KY+pSjjCWkUCDSLUU6YPO+KnchZyldub0NYnLJyb6XO91
         hDzmcgKwsKOtXkeqG/D9prUT2COZBUe69NUDfo99qVOxLamzoeWRal6TwuojlDkWmR9H
         5t8A==
X-Gm-Message-State: AOAM533djiTy2JiLUTF6+Zc30Gq9sqLh1oB6qBeCibKXgzGg/SKol6Ut
        oW9IYVtyA/g0RW1u8W/g+Xx7YI+YUsTN9bDfJ+bfr5ULp2zOqng0CuDnCO3tbuNG3x8O9MZ8Vra
        rQZaDCcpr1Oynf+f1ZCwlp9ue34w=
X-Received: by 2002:a05:6870:6187:: with SMTP id a7mr2996386oah.301.1644787892292;
        Sun, 13 Feb 2022 13:31:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBDBn/d8+RXj4ujrdySBt45orvQd/A6U7KmyqT7QKsU7gPKeEE3J13eHOR6ybDLtEJSykNEA==
X-Received: by 2002:a05:6870:6187:: with SMTP id a7mr2996383oah.301.1644787892055;
        Sun, 13 Feb 2022 13:31:32 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id l40sm3632140otv.12.2022.02.13.13.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 13:31:31 -0800 (PST)
From:   trix@redhat.com
To:     zajec5@gmail.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2] bcma: cleanup comments
Date:   Sun, 13 Feb 2022 13:31:21 -0800
Message-Id: <20220213213121.2806376-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'info'.
Replacements
'adventages' with 'advantages'
'strenth' with 'strength'
'atleast' with 'at least'
'thr'u'' with 'through'
'capabilty' with 'capability'
'controll' with 'control'
'ourself' with 'ourselves'
'noone' with 'no one'
'cores' to 'core's' and 'core'

Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: change per Randy's suggestions

 drivers/bcma/driver_chipcommon.c     | 2 +-
 drivers/bcma/driver_chipcommon_pmu.c | 6 +++---
 drivers/bcma/driver_pci_host.c       | 6 +++---
 drivers/bcma/main.c                  | 4 ++--
 drivers/bcma/sprom.c                 | 4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/bcma/driver_chipcommon.c b/drivers/bcma/driver_chipcommon.c
index 62f5bfa5065d..fd91a39f02c7 100644
--- a/drivers/bcma/driver_chipcommon.c
+++ b/drivers/bcma/driver_chipcommon.c
@@ -303,7 +303,7 @@ u32 bcma_chipco_gpio_outen(struct bcma_drv_cc *cc, u32 mask, u32 value)
 EXPORT_SYMBOL_GPL(bcma_chipco_gpio_outen);
 
 /*
- * If the bit is set to 0, chipcommon controlls this GPIO,
+ * If the bit is set to 0, chipcommon controls this GPIO,
  * if the bit is set to 1, it is used by some part of the chip and not our code.
  */
 u32 bcma_chipco_gpio_control(struct bcma_drv_cc *cc, u32 mask, u32 value)
diff --git a/drivers/bcma/driver_chipcommon_pmu.c b/drivers/bcma/driver_chipcommon_pmu.c
index 3056f81efca4..263ef6fa1d0f 100644
--- a/drivers/bcma/driver_chipcommon_pmu.c
+++ b/drivers/bcma/driver_chipcommon_pmu.c
@@ -206,7 +206,7 @@ static void bcma_pmu_resources_init(struct bcma_drv_cc *cc)
 	usleep_range(2000, 2500);
 }
 
-/* Disable to allow reading SPROM. Don't know the adventages of enabling it. */
+/* Disable to allow reading SPROM. Don't know the advantages of enabling it. */
 void bcma_chipco_bcm4331_ext_pa_lines_ctl(struct bcma_drv_cc *cc, bool enable)
 {
 	struct bcma_bus *bus = cc->core->bus;
@@ -234,7 +234,7 @@ static void bcma_pmu_workarounds(struct bcma_drv_cc *cc)
 	switch (bus->chipinfo.id) {
 	case BCMA_CHIP_ID_BCM4313:
 		/*
-		 * enable 12 mA drive strenth for 4313 and set chipControl
+		 * enable 12 mA drive strength for 4313 and set chipControl
 		 * register bit 1
 		 */
 		bcma_chipco_chipctl_maskset(cc, 0,
@@ -249,7 +249,7 @@ static void bcma_pmu_workarounds(struct bcma_drv_cc *cc)
 	case BCMA_CHIP_ID_BCM43224:
 	case BCMA_CHIP_ID_BCM43421:
 		/*
-		 * enable 12 mA drive strenth for 43224 and set chipControl
+		 * enable 12 mA drive strength for 43224 and set chipControl
 		 * register bit 15
 		 */
 		if (bus->chipinfo.rev == 0) {
diff --git a/drivers/bcma/driver_pci_host.c b/drivers/bcma/driver_pci_host.c
index 6f8fc5f587fe..aa0581cda718 100644
--- a/drivers/bcma/driver_pci_host.c
+++ b/drivers/bcma/driver_pci_host.c
@@ -61,7 +61,7 @@ static u32 bcma_get_cfgspace_addr(struct bcma_drv_pci *pc, unsigned int dev,
 {
 	u32 addr = 0;
 
-	/* Issue config commands only when the data link is up (atleast
+	/* Issue config commands only when the data link is up (at least
 	 * one external pcie device is present).
 	 */
 	if (dev >= 2 || !(bcma_pcie_read(pc, BCMA_CORE_PCI_DLLP_LSREG)
@@ -295,7 +295,7 @@ static u8 bcma_find_pci_capability(struct bcma_drv_pci *pc, unsigned int dev,
 	if (cap_ptr == 0x00)
 		return cap_ptr;
 
-	/* loop thr'u the capability list and see if the requested capabilty
+	/* loop through the capability list and see if the requested capability
 	 * exists */
 	bcma_extpci_read_config(pc, dev, func, cap_ptr, &cap_id, sizeof(u8));
 	while (cap_id != req_cap_id) {
@@ -317,7 +317,7 @@ static u8 bcma_find_pci_capability(struct bcma_drv_pci *pc, unsigned int dev,
 
 		*buflen = 0;
 
-		/* copy the cpability data excluding cap ID and next ptr */
+		/* copy the capability data excluding cap ID and next ptr */
 		cap_data = cap_ptr + 2;
 		if ((bufsize + cap_data)  > PCI_CONFIG_SPACE_SIZE)
 			bufsize = PCI_CONFIG_SPACE_SIZE - cap_data;
diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
index 8e7ca3e4c8c4..44392b624b20 100644
--- a/drivers/bcma/main.c
+++ b/drivers/bcma/main.c
@@ -293,7 +293,7 @@ static int bcma_register_devices(struct bcma_bus *bus)
 	int err;
 
 	list_for_each_entry(core, &bus->cores, list) {
-		/* We support that cores ourself */
+		/* We support that core ourselves */
 		switch (core->id.id) {
 		case BCMA_CORE_4706_CHIPCOMMON:
 		case BCMA_CORE_CHIPCOMMON:
@@ -369,7 +369,7 @@ void bcma_unregister_cores(struct bcma_bus *bus)
 	if (bus->hosttype == BCMA_HOSTTYPE_SOC)
 		platform_device_unregister(bus->drv_cc.watchdog);
 
-	/* Now noone uses internally-handled cores, we can free them */
+	/* Now no one uses internally-handled cores, we can free them */
 	list_for_each_entry_safe(core, tmp, &bus->cores, list) {
 		list_del(&core->list);
 		put_device(&core->dev);
diff --git a/drivers/bcma/sprom.c b/drivers/bcma/sprom.c
index bd2c923a6586..3da01f173c63 100644
--- a/drivers/bcma/sprom.c
+++ b/drivers/bcma/sprom.c
@@ -28,7 +28,7 @@ static int(*get_fallback_sprom)(struct bcma_bus *dev, struct ssb_sprom *out);
  * callback handler which fills the SPROM data structure. The fallback is
  * used for PCI based BCMA devices, where no valid SPROM can be found
  * in the shadow registers and to provide the SPROM for SoCs where BCMA is
- * to controll the system bus.
+ * to control the system bus.
  *
  * This function is useful for weird architectures that have a half-assed
  * BCMA device hardwired to their PCI bus.
@@ -281,7 +281,7 @@ static void bcma_sprom_extract_r8(struct bcma_bus *bus, const u16 *sprom)
 	SPEX(alpha2[0], SSB_SPROM8_CCODE, 0xff00, 8);
 	SPEX(alpha2[1], SSB_SPROM8_CCODE, 0x00ff, 0);
 
-	/* Extract cores power info info */
+	/* Extract core's power info */
 	for (i = 0; i < ARRAY_SIZE(pwr_info_offset); i++) {
 		o = pwr_info_offset[i];
 		SPEX(core_pwr_info[i].itssi_2g, o + SSB_SROM8_2G_MAXP_ITSSI,
-- 
2.26.3

