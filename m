Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B2E6D6D87
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 22:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbjDDUDy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Apr 2023 16:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbjDDUDx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Apr 2023 16:03:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1DB10D3
        for <linux-wireless@vger.kernel.org>; Tue,  4 Apr 2023 13:03:47 -0700 (PDT)
X-UUID: c923be6ed32311edb6b9f13eb10bd0fe-20230405
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=lbEvmoMG8DcwrAyp3RK9DAGflVMVCOWNVtqH207Fk0I=;
        b=UM5xNjNffriGdtzbRqwlnDpct9BLo32l040lfhph3z6IgnJRT90OsRFl7+sLEHcrZncUKRc0fHq/XbcltW4oedmnZiK5CCVgwrK0W4c3vQMNxBTk1ULb76CV4qBT7n70gcsOcklS8M8Lg4UBQNsLMsdFZwbzM9Mgc/J/7wLus0Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:846d7e58-078a-4cf2-be5a-48eacd441ab9,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.22,REQID:846d7e58-078a-4cf2-be5a-48eacd441ab9,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:120426c,CLOUDID:56fa5d2a-564d-42d9-9875-7c868ee415ec,B
        ulkID:2304050403399ZUFOB58,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: c923be6ed32311edb6b9f13eb10bd0fe-20230405
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1837330661; Wed, 05 Apr 2023 04:03:37 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 5 Apr 2023 04:03:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 5 Apr 2023 04:03:35 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 3/3] wifi: mt76: mt7996: enable coredump support
Date:   Wed, 5 Apr 2023 04:03:32 +0800
Message-ID: <ab93849a56836e0aeafffb2f5b4dc2e7bc54fbf1.1680638324.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <6756ddde5aaaf29db4f62264bab7f28bb539b26f.1680638324.git.ryder.lee@mediatek.com>
References: <6756ddde5aaaf29db4f62264bab7f28bb539b26f.1680638324.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Host triggered and catastrophic event triggered firmware core dumping
for basic firmware issues triage, including state reporting, function
calltrace and MCU memory dump.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/Kconfig |   1 +
 .../wireless/mediatek/mt76/mt7996/Makefile    |   2 +
 .../wireless/mediatek/mt76/mt7996/coredump.c  | 268 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt7996/coredump.h  |  97 +++++++
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  10 +-
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  72 ++++-
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  |   8 +
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  22 ++
 .../net/wireless/mediatek/mt76/mt7996/regs.h  |  18 ++
 9 files changed, 496 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/coredump.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/coredump.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
index 79fb47a73c91..1afa2f662e47 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
@@ -2,6 +2,7 @@
 config MT7996E
 	tristate "MediaTek MT7996 (PCIe) support"
 	select MT76_CONNAC_LIB
+	select WANT_DEV_COREDUMP
 	select RELAY
 	depends on MAC80211
 	depends on PCI
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/Makefile b/drivers/net/wireless/mediatek/mt76/mt7996/Makefile
index bcb9a3c53149..07c8b555c1ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/Makefile
@@ -4,3 +4,5 @@ obj-$(CONFIG_MT7996E) += mt7996e.o
 
 mt7996e-y := pci.o init.o dma.o eeprom.o main.o mcu.o mac.o \
 	     debugfs.o mmio.o
+
+mt7996e-$(CONFIG_DEV_COREDUMP) += coredump.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/coredump.c b/drivers/net/wireless/mediatek/mt76/mt7996/coredump.c
new file mode 100644
index 000000000000..d58024f50fdb
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/coredump.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2023 MediaTek Inc. */
+
+#include <linux/devcoredump.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/utsname.h>
+#include "coredump.h"
+
+static bool coredump_memdump;
+module_param(coredump_memdump, bool, 0644);
+MODULE_PARM_DESC(coredump_memdump, "Optional ability to dump firmware memory");
+
+static const struct mt7996_mem_region mt7996_mem_regions[] = {
+	{
+		.start = 0x00800000,
+		.len = 0x0004ffff,
+		.name = "ULM0",
+	},
+	{
+		.start = 0x00900000,
+		.len = 0x00037fff,
+		.name = "ULM1",
+	},
+	{
+		.start = 0x02200000,
+		.len = 0x0003ffff,
+		.name = "ULM2",
+	},
+	{
+		.start = 0x00400000,
+		.len = 0x00067fff,
+		.name = "SRAM",
+	},
+	{
+		.start = 0xe0000000,
+		.len = 0x0015ffff,
+		.name = "CRAM0",
+	},
+	{
+		.start = 0xe0160000,
+		.len = 0x0011bfff,
+		.name = "CRAM1",
+	},
+};
+
+const struct mt7996_mem_region*
+mt7996_coredump_get_mem_layout(struct mt7996_dev *dev, u32 *num)
+{
+	switch (mt76_chip(&dev->mt76)) {
+	case 0x7990:
+	case 0x7991:
+		*num = ARRAY_SIZE(mt7996_mem_regions);
+		return &mt7996_mem_regions[0];
+	default:
+		return NULL;
+	}
+}
+
+static int mt7996_coredump_get_mem_size(struct mt7996_dev *dev)
+{
+	const struct mt7996_mem_region *mem_region;
+	size_t size = 0;
+	u32 num;
+	int i;
+
+	mem_region = mt7996_coredump_get_mem_layout(dev, &num);
+	if (!mem_region)
+		return 0;
+
+	for (i = 0; i < num; i++) {
+		size += mem_region->len;
+		mem_region++;
+	}
+
+	/* reserve space for the headers */
+	size += num * sizeof(struct mt7996_mem_hdr);
+	/* make sure it is aligned 4 bytes for debug message print out */
+	size = ALIGN(size, 4);
+
+	return size;
+}
+
+struct mt7996_crash_data *mt7996_coredump_new(struct mt7996_dev *dev)
+{
+	struct mt7996_crash_data *crash_data = dev->coredump.crash_data;
+
+	lockdep_assert_held(&dev->dump_mutex);
+
+	if (coredump_memdump &&
+	    !mt76_poll_msec(dev, MT_FW_DUMP_STATE, 0x3, 0x2, 500))
+		return NULL;
+
+	guid_gen(&crash_data->guid);
+	ktime_get_real_ts64(&crash_data->timestamp);
+
+	return crash_data;
+}
+
+static void
+mt7996_coredump_fw_state(struct mt7996_dev *dev, struct mt7996_coredump *dump,
+			 bool *exception)
+{
+	u32 count;
+
+	count = mt76_rr(dev, MT_FW_ASSERT_CNT);
+
+	/* normal mode: driver can manually trigger assert for detail info */
+	if (!count)
+		strscpy(dump->fw_state, "normal", sizeof(dump->fw_state));
+	else
+		strscpy(dump->fw_state, "exception", sizeof(dump->fw_state));
+
+	*exception = !!count;
+}
+
+static void
+mt7996_coredump_fw_stack(struct mt7996_dev *dev, struct mt7996_coredump *dump,
+			 bool exception)
+{
+	u32 oldest, i, idx;
+
+	strscpy(dump->pc_current, "program counter", sizeof(dump->pc_current));
+
+	/* 0: WM PC log output */
+	mt76_wr(dev, MT_CONN_DBG_CTL_OUT_SEL, 0);
+	/* choose 33th PC log buffer to read current PC index */
+	mt76_wr(dev, MT_CONN_DBG_CTL_PC_LOG_SEL, 0x3f);
+
+	/* read current PC */
+	dump->pc_stack[0] = mt76_rr(dev, MT_CONN_DBG_CTL_PC_LOG);
+
+	/* stop call stack record */
+	if (!exception) {
+		mt76_clear(dev, MT_MCU_WM_EXCP_PC_CTRL, BIT(0));
+		mt76_clear(dev, MT_MCU_WM_EXCP_LR_CTRL, BIT(0));
+	}
+
+	oldest = (u32)mt76_get_field(dev, MT_MCU_WM_EXCP_LR_CTRL,
+				     GENMASK(20, 16)) + 2;
+	for (i = 0; i < 16; i++) {
+		idx = ((oldest + 2 * i + 1) % 32);
+		dump->pc_stack[i + 1] =
+			mt76_rr(dev, MT_MCU_WM_EXCP_LR_LOG + idx * 4);
+	}
+
+	oldest = (u32)mt76_get_field(dev, MT_MCU_WM_EXCP_PC_CTRL,
+				     GENMASK(20, 16)) + 2;
+	for (i = 0; i < 16; i++) {
+		idx = ((oldest + 2 * i + 1) % 32);
+		dump->lr_stack[i] =
+			mt76_rr(dev, MT_MCU_WM_EXCP_PC_LOG + idx * 4);
+	}
+
+	/* start call stack record */
+	if (!exception) {
+		mt76_set(dev, MT_MCU_WM_EXCP_PC_CTRL, BIT(0));
+		mt76_set(dev, MT_MCU_WM_EXCP_LR_CTRL, BIT(0));
+	}
+}
+
+static struct mt7996_coredump *mt7996_coredump_build(struct mt7996_dev *dev)
+{
+	struct mt7996_crash_data *crash_data = dev->coredump.crash_data;
+	struct mt7996_coredump *dump;
+	struct mt7996_coredump_mem *dump_mem;
+	size_t len, sofar = 0, hdr_len = sizeof(*dump);
+	unsigned char *buf;
+	bool exception;
+
+	len = hdr_len;
+
+	if (coredump_memdump && crash_data->memdump_buf_len)
+		len += sizeof(*dump_mem) + crash_data->memdump_buf_len;
+
+	sofar += hdr_len;
+
+	/* this is going to get big when we start dumping memory and such,
+	 * so go ahead and use vmalloc.
+	 */
+	buf = vzalloc(len);
+	if (!buf)
+		return NULL;
+
+	mutex_lock(&dev->dump_mutex);
+
+	dump = (struct mt7996_coredump *)(buf);
+	dump->len = len;
+
+	/* plain text */
+	strscpy(dump->magic, "mt76-crash-dump", sizeof(dump->magic));
+	strscpy(dump->kernel, init_utsname()->release, sizeof(dump->kernel));
+	strscpy(dump->fw_ver, dev->mt76.hw->wiphy->fw_version,
+		sizeof(dump->fw_ver));
+
+	guid_copy(&dump->guid, &crash_data->guid);
+	dump->tv_sec = crash_data->timestamp.tv_sec;
+	dump->tv_nsec = crash_data->timestamp.tv_nsec;
+	dump->device_id = mt76_chip(&dev->mt76);
+
+	mt7996_coredump_fw_state(dev, dump, &exception);
+	mt7996_coredump_fw_stack(dev, dump, exception);
+
+	/* gather memory content */
+	dump_mem = (struct mt7996_coredump_mem *)(buf + sofar);
+	dump_mem->len = crash_data->memdump_buf_len;
+	if (coredump_memdump && crash_data->memdump_buf_len)
+		memcpy(dump_mem->data, crash_data->memdump_buf,
+		       crash_data->memdump_buf_len);
+
+	mutex_unlock(&dev->dump_mutex);
+
+	return dump;
+}
+
+int mt7996_coredump_submit(struct mt7996_dev *dev)
+{
+	struct mt7996_coredump *dump;
+
+	dump = mt7996_coredump_build(dev);
+	if (!dump) {
+		dev_warn(dev->mt76.dev, "no crash dump data found\n");
+		return -ENODATA;
+	}
+
+	dev_coredumpv(dev->mt76.dev, dump, dump->len, GFP_KERNEL);
+
+	return 0;
+}
+
+int mt7996_coredump_register(struct mt7996_dev *dev)
+{
+	struct mt7996_crash_data *crash_data;
+
+	crash_data = vzalloc(sizeof(*dev->coredump.crash_data));
+	if (!crash_data)
+		return -ENOMEM;
+
+	dev->coredump.crash_data = crash_data;
+
+	if (coredump_memdump) {
+		crash_data->memdump_buf_len = mt7996_coredump_get_mem_size(dev);
+		if (!crash_data->memdump_buf_len)
+			/* no memory content */
+			return 0;
+
+		crash_data->memdump_buf = vzalloc(crash_data->memdump_buf_len);
+		if (!crash_data->memdump_buf) {
+			vfree(crash_data);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+void mt7996_coredump_unregister(struct mt7996_dev *dev)
+{
+	if (dev->coredump.crash_data->memdump_buf) {
+		vfree(dev->coredump.crash_data->memdump_buf);
+		dev->coredump.crash_data->memdump_buf = NULL;
+		dev->coredump.crash_data->memdump_buf_len = 0;
+	}
+
+	vfree(dev->coredump.crash_data);
+	dev->coredump.crash_data = NULL;
+}
+
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/coredump.h b/drivers/net/wireless/mediatek/mt76/mt7996/coredump.h
new file mode 100644
index 000000000000..af2ba219b1b5
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/coredump.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2023 MediaTek Inc. */
+
+#ifndef _COREDUMP_H_
+#define _COREDUMP_H_
+
+#include "mt7996.h"
+
+struct mt7996_coredump {
+	char magic[16];
+
+	u32 len;
+
+	guid_t guid;
+
+	/* time-of-day stamp */
+	u64 tv_sec;
+	/* time-of-day stamp, nano-seconds */
+	u64 tv_nsec;
+	/* kernel version */
+	char kernel[64];
+	/* firmware version */
+	char fw_ver[ETHTOOL_FWVERS_LEN];
+
+	u32 device_id;
+
+	/* exception state */
+	char fw_state[12];
+
+	/* program counters */
+	char pc_current[16];
+	u32 pc_stack[17];
+	/* link registers */
+	u32 lr_stack[16];
+
+	/* memory content */
+	u8 data[];
+} __packed;
+
+struct mt7996_coredump_mem {
+	u32 len;
+	u8 data[];
+} __packed;
+
+struct mt7996_mem_hdr {
+	u32 start;
+	u32 len;
+	u8 data[];
+};
+
+struct mt7996_mem_region {
+	u32 start;
+	size_t len;
+
+	const char *name;
+};
+
+#ifdef CONFIG_DEV_COREDUMP
+
+const struct mt7996_mem_region *
+mt7996_coredump_get_mem_layout(struct mt7996_dev *dev, u32 *num);
+struct mt7996_crash_data *mt7996_coredump_new(struct mt7996_dev *dev);
+int mt7996_coredump_submit(struct mt7996_dev *dev);
+int mt7996_coredump_register(struct mt7996_dev *dev);
+void mt7996_coredump_unregister(struct mt7996_dev *dev);
+
+#else /* CONFIG_DEV_COREDUMP */
+
+static inline const struct mt7996_mem_region *
+mt7996_coredump_get_mem_layout(struct mt7996_dev *dev, u32 *num)
+{
+	return NULL;
+}
+
+static inline int mt7996_coredump_submit(struct mt7996_dev *dev)
+{
+	return 0;
+}
+
+static inline struct
+mt7996_crash_data *mt7996_coredump_new(struct mt7996_dev *dev)
+{
+	return NULL;
+}
+
+static inline int mt7996_coredump_register(struct mt7996_dev *dev)
+{
+	return 0;
+}
+
+static inline void mt7996_coredump_unregister(struct mt7996_dev *dev)
+{
+}
+
+#endif /* CONFIG_DEV_COREDUMP */
+
+#endif /* _COREDUMP_H_ */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 76501e42cd8a..503a7ff24f95 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -8,6 +8,7 @@
 #include "mt7996.h"
 #include "mac.h"
 #include "mcu.h"
+#include "coredump.h"
 #include "eeprom.h"
 
 static const struct ieee80211_iface_limit if_limits[] = {
@@ -857,6 +858,8 @@ int mt7996_register_device(struct mt7996_dev *dev)
 
 	init_waitqueue_head(&dev->reset_wait);
 	INIT_WORK(&dev->reset_work, mt7996_mac_reset_work);
+	INIT_WORK(&dev->dump_work, mt7996_mac_dump_work);
+	mutex_init(&dev->dump_mutex);
 
 	ret = mt7996_init_hardware(dev);
 	if (ret)
@@ -887,13 +890,18 @@ int mt7996_register_device(struct mt7996_dev *dev)
 
 	dev->recovery.hw_init_done = true;
 
-	return mt7996_init_debugfs(&dev->phy);
+	ret = mt7996_init_debugfs(&dev->phy);
+	if (ret)
+		return ret;
+
+	return mt7996_coredump_register(dev);
 }
 
 void mt7996_unregister_device(struct mt7996_dev *dev)
 {
 	mt7996_unregister_phy(mt7996_phy3(dev), MT_BAND2);
 	mt7996_unregister_phy(mt7996_phy2(dev), MT_BAND1);
+	mt7996_coredump_unregister(dev);
 	mt76_unregister_device(&dev->mt76);
 	mt7996_mcu_exit(dev);
 	mt7996_tx_token_put(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index f5c24985b905..52244b95831c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -5,6 +5,7 @@
 
 #include <linux/etherdevice.h>
 #include <linux/timekeeping.h>
+#include "coredump.h"
 #include "mt7996.h"
 #include "../dma.h"
 #include "mac.h"
@@ -2083,6 +2084,75 @@ void mt7996_mac_reset_work(struct work_struct *work)
 		 wiphy_name(dev->mt76.hw->wiphy));
 }
 
+/* firmware coredump */
+void mt7996_mac_dump_work(struct work_struct *work)
+{
+	const struct mt7996_mem_region *mem_region;
+	struct mt7996_crash_data *crash_data;
+	struct mt7996_dev *dev;
+	struct mt7996_mem_hdr *hdr;
+	size_t buf_len;
+	int i;
+	u32 num;
+	u8 *buf;
+
+	dev = container_of(work, struct mt7996_dev, dump_work);
+
+	mutex_lock(&dev->dump_mutex);
+
+	crash_data = mt7996_coredump_new(dev);
+	if (!crash_data) {
+		mutex_unlock(&dev->dump_mutex);
+		goto skip_coredump;
+	}
+
+	mem_region = mt7996_coredump_get_mem_layout(dev, &num);
+	if (!mem_region || !crash_data->memdump_buf_len) {
+		mutex_unlock(&dev->dump_mutex);
+		goto skip_memdump;
+	}
+
+	buf = crash_data->memdump_buf;
+	buf_len = crash_data->memdump_buf_len;
+
+	/* dumping memory content... */
+	memset(buf, 0, buf_len);
+	for (i = 0; i < num; i++) {
+		if (mem_region->len > buf_len) {
+			dev_warn(dev->mt76.dev, "%s len %zu is too large\n",
+				 mem_region->name, mem_region->len);
+			break;
+		}
+
+		/* reserve space for the header */
+		hdr = (void *)buf;
+		buf += sizeof(*hdr);
+		buf_len -= sizeof(*hdr);
+
+		mt7996_memcpy_fromio(dev, buf, mem_region->start,
+				     mem_region->len);
+
+		hdr->start = mem_region->start;
+		hdr->len = mem_region->len;
+
+		if (!mem_region->len)
+			/* note: the header remains, just with zero length */
+			break;
+
+		buf += mem_region->len;
+		buf_len -= mem_region->len;
+
+		mem_region++;
+	}
+
+	mutex_unlock(&dev->dump_mutex);
+
+skip_memdump:
+	mt7996_coredump_submit(dev);
+skip_coredump:
+	queue_work(dev->mt76.wq, &dev->reset_work);
+}
+
 void mt7996_reset(struct mt7996_dev *dev)
 {
 	if (!dev->recovery.hw_init_done)
@@ -2099,7 +2169,7 @@ void mt7996_reset(struct mt7996_dev *dev)
 			 wiphy_name(dev->mt76.hw->wiphy));
 
 		mt7996_irq_disable(dev, MT_INT_MCU_CMD);
-		queue_work(dev->mt76.wq, &dev->reset_work);
+		queue_work(dev->mt76.wq, &dev->dump_work);
 		return;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 536e8dd0edca..510c5facdae8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -162,6 +162,14 @@ static u32 __mt7996_reg_addr(struct mt7996_dev *dev, u32 addr)
 	return mt7996_reg_map_l2(dev, addr);
 }
 
+void mt7996_memcpy_fromio(struct mt7996_dev *dev, void *buf, u32 offset,
+			  size_t len)
+{
+	u32 addr = __mt7996_reg_addr(dev, offset);
+
+	memcpy_fromio(buf, dev->mt76.mmio.regs + addr, len);
+}
+
 static u32 mt7996_rr(struct mt76_dev *mdev, u32 offset)
 {
 	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 45071f0dc2fe..0f668bff1542 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -192,6 +192,15 @@ struct mib_stats {
 	u32 tx_amsdu_cnt;
 };
 
+/* crash-dump */
+struct mt7996_crash_data {
+	guid_t guid;
+	struct timespec64 timestamp;
+
+	u8 *memdump_buf;
+	size_t memdump_buf_len;
+};
+
 struct mt7996_hif {
 	struct list_head list;
 
@@ -251,6 +260,7 @@ struct mt7996_dev {
 
 	struct work_struct init_work;
 	struct work_struct rc_work;
+	struct work_struct dump_work;
 	struct work_struct reset_work;
 	wait_queue_head_t reset_wait;
 	struct {
@@ -262,6 +272,14 @@ struct mt7996_dev {
 		bool restart:1;
 	} recovery;
 
+	/* protects coredump data */
+	struct mutex dump_mutex;
+#ifdef CONFIG_DEV_COREDUMP
+	struct {
+		struct mt7996_crash_data *crash_data;
+	} coredump;
+#endif
+
 	struct list_head sta_rc_list;
 	struct list_head sta_poll_list;
 	struct list_head twt_list;
@@ -493,6 +511,9 @@ static inline void mt7996_irq_disable(struct mt7996_dev *dev, u32 mask)
 		mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, mask, 0);
 }
 
+void mt7996_memcpy_fromio(struct mt7996_dev *dev, void *buf, u32 offset,
+			  size_t len);
+
 void mt7996_mac_init(struct mt7996_dev *dev);
 u32 mt7996_mac_wtbl_lmac_addr(struct mt7996_dev *dev, u16 wcid, u8 dw);
 bool mt7996_mac_wtbl_update(struct mt7996_dev *dev, int idx, u32 mask);
@@ -511,6 +532,7 @@ void mt7996_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta);
 void mt7996_mac_work(struct work_struct *work);
 void mt7996_mac_reset_work(struct work_struct *work);
+void mt7996_mac_dump_work(struct work_struct *work);
 void mt7996_mac_sta_rc_work(struct work_struct *work);
 void mt7996_mac_update_stats(struct mt7996_phy *phy);
 void mt7996_mac_twt_teardown_flow(struct mt7996_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index fb9b8dec9189..75f856205559 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -474,6 +474,9 @@ enum base_rev {
 #define MT_INFRA_MCU_END			0x7c3fffff
 
 /* FW MODE SYNC */
+#define MT_FW_ASSERT_CNT			0x02208274
+#define MT_FW_DUMP_STATE			0x02209e90
+
 #define MT_SWDEF_BASE				0x00401400
 
 #define MT_SWDEF(ofs)				(MT_SWDEF_BASE + (ofs))
@@ -508,6 +511,13 @@ enum base_rev {
 
 #define MT_LED_EN(_n)				MT_LED_PHYS(0x40 + ((_n) * 4))
 
+/* CONN DBG */
+#define MT_CONN_DBG_CTL_BASE			0x18023000
+#define MT_CONN_DBG_CTL(ofs)			(MT_CONN_DBG_CTL_BASE + (ofs))
+#define MT_CONN_DBG_CTL_OUT_SEL			MT_CONN_DBG_CTL(0x604)
+#define MT_CONN_DBG_CTL_PC_LOG_SEL		MT_CONN_DBG_CTL(0x60c)
+#define MT_CONN_DBG_CTL_PC_LOG			MT_CONN_DBG_CTL(0x610)
+
 #define MT_LED_GPIO_MUX2			0x70005058 /* GPIO 18 */
 #define MT_LED_GPIO_MUX3			0x7000505C /* GPIO 26 */
 #define MT_LED_GPIO_SEL_MASK			GENMASK(11, 8)
@@ -561,4 +571,12 @@ enum base_rev {
 #define MT_WF_PHYRX_CSD_BAND_RXTD12_IRPI_SW_CLR_ONLY	BIT(18)
 #define MT_WF_PHYRX_CSD_BAND_RXTD12_IRPI_SW_CLR		BIT(29)
 
+/* CONN MCU EXCP CON */
+#define MT_MCU_WM_EXCP_BASE			0x89050000
+#define MT_MCU_WM_EXCP(ofs)			(MT_MCU_WM_EXCP_BASE + (ofs))
+#define MT_MCU_WM_EXCP_PC_CTRL			MT_MCU_WM_EXCP(0x100)
+#define MT_MCU_WM_EXCP_PC_LOG			MT_MCU_WM_EXCP(0x104)
+#define MT_MCU_WM_EXCP_LR_CTRL			MT_MCU_WM_EXCP(0x200)
+#define MT_MCU_WM_EXCP_LR_LOG			MT_MCU_WM_EXCP(0x204)
+
 #endif
-- 
2.18.0

