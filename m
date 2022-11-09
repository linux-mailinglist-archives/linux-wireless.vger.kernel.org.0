Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEAD6234B4
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 21:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiKIUhB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Nov 2022 15:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiKIUgw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Nov 2022 15:36:52 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3772F645
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 12:36:45 -0800 (PST)
X-UUID: 2d4d54e340534681a6faec327278aeb3-20221110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=P8e55r60yL8b3MDHe2FUZdktnmdfVIU8b+P0EU+Kx0c=;
        b=Z0HVNaMNs8RdiTVjfDhvqCnLra/gro2tOyDk6xcIXK2O/nh6y45pdiWW/hXVs+jiv1ekyL6H3blqzPB3DxcVcLqhdLcSxOKYZQaf6f8CY1Jx6U3OPncCowQWOiM1UU8pP6ZM75QQhRRlkm1IiCa8PgQuNprk+kJFvZowk7EyjJI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:b055236a-0ea2-4cff-85fc-2a6a03fb1b7b,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.12,REQID:b055236a-0ea2-4cff-85fc-2a6a03fb1b7b,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:62cd327,CLOUDID:e474d450-b7af-492d-8b40-b1032f90ce11,B
        ulkID:221109073012ZKQZCQC1,BulkQuantity:4,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:41,QS:nil,BEC:nil,COL:0
X-UUID: 2d4d54e340534681a6faec327278aeb3-20221110
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1256730464; Thu, 10 Nov 2022 04:36:38 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 10 Nov 2022 04:36:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 10 Nov 2022 04:36:37 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v3 4/4] wifi: mt76: mt7915: enable coredump support
Date:   Thu, 10 Nov 2022 04:36:34 +0800
Message-ID: <b65f419a0c7319a6f661e07af7778fecb6cc7547.1668024217.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <3e6ef9fb1d2e09d415b4c489cc9c62134a05b3c1.1668024217.git.ryder.lee@mediatek.com>
References: <3e6ef9fb1d2e09d415b4c489cc9c62134a05b3c1.1668024217.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Host triggered and catastrophic event triggered firmware core dumping
for basic firmware issues triage, including state reporting, task/irq
info, function calltrace and MCU memory dump.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/Kconfig |   1 +
 .../wireless/mediatek/mt76/mt7915/Makefile    |   3 +-
 .../wireless/mediatek/mt76/mt7915/coredump.c  | 409 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt7915/coredump.h  | 136 ++++++
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  12 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  72 ++-
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  59 ++-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  22 +
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  34 +-
 9 files changed, 740 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/coredump.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/coredump.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
index f21282cea845..d710726d47bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
@@ -2,6 +2,7 @@
 config MT7915E
 	tristate "MediaTek MT7915E (PCIe) support"
 	select MT76_CONNAC_LIB
+	select WANT_DEV_COREDUMP
 	depends on MAC80211
 	depends on PCI
 	select RELAY
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/Makefile b/drivers/net/wireless/mediatek/mt76/mt7915/Makefile
index b794ceb79c37..797ae49805c3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/Makefile
@@ -6,4 +6,5 @@ mt7915e-y := pci.o init.o dma.o eeprom.o main.o mcu.o mac.o \
 	     debugfs.o mmio.o
 
 mt7915e-$(CONFIG_NL80211_TESTMODE) += testmode.o
-mt7915e-$(CONFIG_MT7986_WMAC) += soc.o
\ No newline at end of file
+mt7915e-$(CONFIG_MT7986_WMAC) += soc.o
+mt7915e-$(CONFIG_DEV_COREDUMP) += coredump.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/coredump.c b/drivers/net/wireless/mediatek/mt76/mt7915/coredump.c
new file mode 100644
index 000000000000..bb4b70401af5
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/coredump.c
@@ -0,0 +1,409 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2022 MediaTek Inc. */
+
+#include <linux/devcoredump.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/utsname.h>
+#include "coredump.h"
+
+static bool coredump_memdump;
+module_param(coredump_memdump, bool, 0644);
+
+static const struct mt7915_mem_region mt7915_mem_regions[] = {
+	{
+		.start = 0xe003b400,
+		.len = 0x00003bff,
+		.name = "CRAM",
+	},
+};
+
+static const struct mt7915_mem_region mt7916_mem_regions[] = {
+	{
+		.start = 0x00800000,
+		.len = 0x0005ffff,
+		.name = "ROM",
+	},
+	{
+		.start = 0x00900000,
+		.len = 0x00013fff,
+		.name = "ULM1",
+	},
+	{
+		.start = 0x02200000,
+		.len = 0x0004ffff,
+		.name = "ULM2",
+	},
+	{
+		.start = 0x02300000,
+		.len = 0x0004ffff,
+		.name = "ULM3",
+	},
+	{
+		.start = 0x00400000,
+		.len = 0x00027fff,
+		.name = "SRAM",
+	},
+	{
+		.start = 0xe0000000,
+		.len = 0x00157fff,
+		.name = "CRAM",
+	},
+};
+
+static const struct mt7915_mem_region mt7986_mem_regions[] = {
+	{
+		.start = 0x00800000,
+		.len = 0x0005ffff,
+		.name = "ROM",
+	},
+	{
+		.start = 0x00900000,
+		.len = 0x0000ffff,
+		.name = "ULM1",
+	},
+	{
+		.start = 0x02200000,
+		.len = 0x0004ffff,
+		.name = "ULM2",
+	},
+	{
+		.start = 0x02300000,
+		.len = 0x0004ffff,
+		.name = "ULM3",
+	},
+	{
+		.start = 0x00400000,
+		.len = 0x00017fff,
+		.name = "SRAM",
+	},
+	{
+		.start = 0xe0000000,
+		.len = 0x00113fff,
+		.name = "CRAM",
+	},
+};
+
+const struct mt7915_mem_region*
+mt7915_coredump_get_mem_layout(struct mt7915_dev *dev, u32 *num)
+{
+	switch (mt76_chip(&dev->mt76)) {
+	case 0x7915:
+		*num = ARRAY_SIZE(mt7915_mem_regions);
+		return &mt7915_mem_regions[0];
+	case 0x7986:
+		*num = ARRAY_SIZE(mt7986_mem_regions);
+		return &mt7986_mem_regions[0];
+	case 0x7916:
+		*num = ARRAY_SIZE(mt7916_mem_regions);
+		return &mt7916_mem_regions[0];
+	default:
+		return NULL;
+	}
+}
+
+static int mt7915_coredump_get_mem_size(struct mt7915_dev *dev)
+{
+	const struct mt7915_mem_region *mem_region;
+	size_t size = 0;
+	u32 num;
+	int i;
+
+	mem_region = mt7915_coredump_get_mem_layout(dev, &num);
+	if (!mem_region)
+		return 0;
+
+	for (i = 0; i < num; i++) {
+		size += mem_region->len;
+		mem_region++;
+	}
+
+	/* reserve space for the headers */
+	size += num * sizeof(struct mt7915_mem_hdr);
+	/* make sure it is aligned 4 bytes for debug message print out */
+	size = ALIGN(size, 4);
+
+	return size;
+}
+
+struct mt7915_crash_data *mt7915_coredump_new(struct mt7915_dev *dev)
+{
+	struct mt7915_crash_data *crash_data = dev->coredump.crash_data;
+
+	lockdep_assert_held(&dev->dump_mutex);
+
+	guid_gen(&crash_data->guid);
+	ktime_get_real_ts64(&crash_data->timestamp);
+
+	return crash_data;
+}
+
+static void
+mt7915_coredump_fw_state(struct mt7915_dev *dev, struct mt7915_coredump *dump,
+			 bool *exception)
+{
+	u32 state, count, type;
+
+	type = (u32)mt76_get_field(dev, MT_FW_EXCEPT_TYPE, GENMASK(7, 0));
+	state = (u32)mt76_get_field(dev, MT_FW_ASSERT_STAT, GENMASK(7, 0));
+	count = is_mt7915(&dev->mt76) ?
+		(u32)mt76_get_field(dev, MT_FW_EXCEPT_COUNT, GENMASK(15, 8)) :
+		(u32)mt76_get_field(dev, MT_FW_EXCEPT_COUNT, GENMASK(7, 0));
+
+	/* normal mode: driver can manually trigger assert for detail info */
+	if (!count)
+		strscpy(dump->fw_state, "normal", sizeof(dump->fw_state));
+	else if (state > 1 && (count == 1) && type == 5)
+		strscpy(dump->fw_state, "assert", sizeof(dump->fw_state));
+	else if ((state > 1 && count == 1) || count > 1)
+		strscpy(dump->fw_state, "exception", sizeof(dump->fw_state));
+
+	*exception = !!count;
+}
+
+static void
+mt7915_coredump_fw_trace(struct mt7915_dev *dev, struct mt7915_coredump *dump,
+			 bool exception)
+{
+	u32 n, irq, sch, base = MT_FW_EINT_INFO;
+
+	/* trap or run? */
+	dump->last_msg_id = mt76_rr(dev, MT_FW_LAST_MSG_ID);
+
+	n = is_mt7915(&dev->mt76) ?
+	    (u32)mt76_get_field(dev, base, GENMASK(7, 0)) :
+	    (u32)mt76_get_field(dev, base, GENMASK(15, 8));
+	dump->eint_info_idx = n;
+
+	irq = mt76_rr(dev, base + 0x8);
+	n = is_mt7915(&dev->mt76) ?
+	    FIELD_GET(GENMASK(7, 0), irq) : FIELD_GET(GENMASK(23, 16), irq);
+	dump->irq_info_idx = n;
+
+	sch = mt76_rr(dev, MT_FW_SCHED_INFO);
+	n = is_mt7915(&dev->mt76) ?
+	    FIELD_GET(GENMASK(7, 0), sch) : FIELD_GET(GENMASK(15, 8), sch);
+	dump->sched_info_idx = n;
+
+	if (exception) {
+		u32 i, y;
+
+		/* sched trace */
+		n = is_mt7915(&dev->mt76) ?
+		    FIELD_GET(GENMASK(15, 8), sch) : FIELD_GET(GENMASK(7, 0), sch);
+		n = n > 60 ? 60 : n;
+
+		strscpy(dump->trace_sched, "(sched_info) id, time",
+			sizeof(dump->trace_sched));
+
+		for (y = dump->sched_info_idx, i = 0; i < n; i++, y++) {
+			mt7915_memcpy_fromio(dev, dump->sched, base + 0xc + y * 12,
+					     sizeof(dump->sched));
+			y = y >= n ? 0 : y;
+		}
+
+		/* irq trace */
+		n = is_mt7915(&dev->mt76) ?
+		    FIELD_GET(GENMASK(15, 8), irq) : FIELD_GET(GENMASK(7, 0), irq);
+		n = n > 60 ? 60 : n;
+
+		strscpy(dump->trace_irq, "(irq_info) id, time",
+			sizeof(dump->trace_irq));
+
+		for (y = dump->irq_info_idx, i = 0; i < n; i++, y++) {
+			mt7915_memcpy_fromio(dev, dump->irq, base + 0x4 + y * 16,
+					     sizeof(dump->irq));
+			y = y >= n ? 0 : y;
+		}
+	}
+}
+
+static void
+mt7915_coredump_fw_stack(struct mt7915_dev *dev, struct mt7915_coredump *dump,
+			 bool exception)
+{
+	u32 oldest, i, idx;
+
+	/* stop call stack record */
+	if (!exception)
+		mt76_clear(dev, 0x89050200, BIT(0));
+
+	oldest = (u32)mt76_get_field(dev, 0x89050200, GENMASK(20, 16)) + 2;
+	for (i = 0; i < 16; i++) {
+		idx = ((oldest + 2 * i + 1) % 32);
+		dump->call_stack[i] = mt76_rr(dev, 0x89050204 + idx * 4);
+	}
+
+	/* start call stack record */
+	if (!exception)
+		mt76_set(dev, 0x89050200, BIT(0));
+}
+
+static void
+mt7915_coredump_fw_task(struct mt7915_dev *dev, struct mt7915_coredump *dump)
+{
+	u32 offs = is_mt7915(&dev->mt76) ? 0xe0 : 0x170;
+
+	strscpy(dump->task_qid, "(task queue id) read, write",
+		sizeof(dump->task_qid));
+
+	dump->taskq[0].read = mt76_rr(dev, MT_FW_TASK_QID1);
+	dump->taskq[0].write = mt76_rr(dev, MT_FW_TASK_QID1 - 4);
+	dump->taskq[1].read = mt76_rr(dev, MT_FW_TASK_QID2);
+	dump->taskq[1].write = mt76_rr(dev, MT_FW_TASK_QID2 - 4);
+
+	strscpy(dump->task_info, "(task stack) start, end, size",
+		sizeof(dump->task_info));
+
+	dump->taski[0].start = mt76_rr(dev, MT_FW_TASK_START);
+	dump->taski[0].end = mt76_rr(dev, MT_FW_TASK_END);
+	dump->taski[0].size = mt76_rr(dev, MT_FW_TASK_SIZE);
+	dump->taski[1].start = mt76_rr(dev, MT_FW_TASK_START + offs);
+	dump->taski[1].end = mt76_rr(dev, MT_FW_TASK_END + offs);
+	dump->taski[1].size = mt76_rr(dev, MT_FW_TASK_SIZE + offs);
+}
+
+static void
+mt7915_coredump_fw_context(struct mt7915_dev *dev, struct mt7915_coredump *dump)
+{
+	u32 count, idx, id;
+
+	count = mt76_rr(dev, MT_FW_CIRQ_COUNT);
+
+	/* current context */
+	if (!count) {
+		strscpy(dump->fw_context, "(context) interrupt",
+			sizeof(dump->fw_context));
+
+		idx = is_mt7915(&dev->mt76) ?
+		      (u32)mt76_get_field(dev, MT_FW_CIRQ_IDX, GENMASK(31, 16)) :
+		      (u32)mt76_get_field(dev, MT_FW_CIRQ_IDX, GENMASK(15, 0));
+		dump->context.idx = idx;
+		dump->context.handler = mt76_rr(dev, MT_FW_CIRQ_LISR);
+	} else {
+		idx = mt76_rr(dev, MT_FW_TASK_IDX);
+		id = mt76_rr(dev, MT_FW_TASK_ID);
+
+		if (!id && idx == 3) {
+			strscpy(dump->fw_context, "(context) idle",
+				sizeof(dump->fw_context));
+		} else if (id && idx != 3) {
+			strscpy(dump->fw_context, "(context) task",
+				sizeof(dump->fw_context));
+
+			dump->context.idx = idx;
+			dump->context.handler = id;
+		}
+	}
+}
+
+static struct mt7915_coredump *mt7915_coredump_build(struct mt7915_dev *dev)
+{
+	struct mt7915_crash_data *crash_data = dev->coredump.crash_data;
+	struct mt7915_coredump *dump;
+	struct mt7915_coredump_mem *dump_mem;
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
+	dump = (struct mt7915_coredump *)(buf);
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
+	mt7915_coredump_fw_state(dev, dump, &exception);
+	mt7915_coredump_fw_trace(dev, dump, exception);
+	mt7915_coredump_fw_task(dev, dump);
+	mt7915_coredump_fw_context(dev, dump);
+	mt7915_coredump_fw_stack(dev, dump, exception);
+
+	/* gather memory content */
+	dump_mem = (struct mt7915_coredump_mem *)(buf + sofar);
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
+int mt7915_coredump_submit(struct mt7915_dev *dev)
+{
+	struct mt7915_coredump *dump;
+
+	dump = mt7915_coredump_build(dev);
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
+int mt7915_coredump_register(struct mt7915_dev *dev)
+{
+	struct mt7915_crash_data *crash_data;
+
+	crash_data = vzalloc(sizeof(*dev->coredump.crash_data));
+	if (!crash_data)
+		return -ENOMEM;
+
+	dev->coredump.crash_data = crash_data;
+
+	if (coredump_memdump) {
+		crash_data->memdump_buf_len = mt7915_coredump_get_mem_size(dev);
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
+void mt7915_coredump_unregister(struct mt7915_dev *dev)
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
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/coredump.h b/drivers/net/wireless/mediatek/mt76/mt7915/coredump.h
new file mode 100644
index 000000000000..1db326d208d0
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/coredump.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2022 MediaTek Inc. */
+
+#ifndef _COREDUMP_H_
+#define _COREDUMP_H_
+
+#include "mt7915.h"
+
+struct trace {
+	u32 id;
+	u32 timestamp;
+};
+
+struct mt7915_coredump {
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
+	u32 last_msg_id;
+	u32 eint_info_idx;
+	u32 irq_info_idx;
+	u32 sched_info_idx;
+
+	/* schedule info */
+	char trace_sched[32];
+	struct {
+		struct trace t;
+		u32 pc;
+	} sched[60];
+
+	/* irq info */
+	char trace_irq[32];
+	struct trace irq[60];
+
+	/* task queue status */
+	char task_qid[32];
+	struct {
+		u32 read;
+		u32 write;
+	} taskq[2];
+
+	/* task stack info */
+	char task_info[32];
+	struct {
+		u32 start;
+		u32 end;
+		u32 size;
+	} taski[2];
+
+	/* firmware context */
+	char fw_context[24];
+	struct {
+		u32 idx;
+		u32 handler;
+	} context;
+
+	/* link registers calltrace */
+	u32 call_stack[16];
+
+	/* memory content */
+	u8 data[];
+} __packed;
+
+struct mt7915_coredump_mem {
+	u32 len;
+	u8 data[];
+} __packed;
+
+struct mt7915_mem_hdr {
+	u32 start;
+	u32 len;
+	u8 data[];
+};
+
+struct mt7915_mem_region {
+	u32 start;
+	size_t len;
+
+	const char *name;
+};
+
+#ifdef CONFIG_DEV_COREDUMP
+
+const struct mt7915_mem_region *
+mt7915_coredump_get_mem_layout(struct mt7915_dev *dev, u32 *num);
+struct mt7915_crash_data *mt7915_coredump_new(struct mt7915_dev *dev);
+int mt7915_coredump_submit(struct mt7915_dev *dev);
+int mt7915_coredump_register(struct mt7915_dev *dev);
+void mt7915_coredump_unregister(struct mt7915_dev *dev);
+
+#else /* CONFIG_DEV_COREDUMP */
+
+static inline const struct mt7915_mem_region*
+mt7915_coredump_get_mem_layout(struct mt7915_dev *dev)
+{
+	return NULL;
+}
+
+static inline int mt7915_coredump_submit(struct mt7915_dev *dev)
+{
+	return 0;
+}
+
+struct mt7915_crash_data *mt7915_coredump_new(struct mt7915_dev *dev)
+{
+	return NULL;
+}
+
+static inline int mt7915_coredump_register(struct mt7915_dev *dev)
+{
+	return 0;
+}
+
+static inline void mt7915_coredump_unregister(struct mt7915_dev *dev)
+{
+}
+
+#endif /* CONFIG_DEV_COREDUMP */
+
+#endif /* _COREDUMP_H_ */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 1f39aa3e3f3d..db581742994c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -8,6 +8,7 @@
 #include "mt7915.h"
 #include "mac.h"
 #include "mcu.h"
+#include "coredump.h"
 #include "eeprom.h"
 
 static const struct ieee80211_iface_limit if_limits[] = {
@@ -1076,6 +1077,8 @@ int mt7915_register_device(struct mt7915_dev *dev)
 
 	init_waitqueue_head(&dev->reset_wait);
 	INIT_WORK(&dev->reset_work, mt7915_mac_reset_work);
+	INIT_WORK(&dev->dump_work, mt7915_mac_dump_work);
+	mutex_init(&dev->dump_mutex);
 
 	dev->dbdc_support = mt7915_band_config(dev);
 
@@ -1118,7 +1121,13 @@ int mt7915_register_device(struct mt7915_dev *dev)
 
 	dev->recovery.hw_init_done = true;
 
-	mt7915_init_debugfs(&dev->phy);
+	ret = mt7915_init_debugfs(&dev->phy);
+	if (ret)
+		goto unreg_thermal;
+
+	ret = mt7915_coredump_register(dev);
+	if (ret)
+		goto unreg_thermal;
 
 	return 0;
 
@@ -1137,6 +1146,7 @@ int mt7915_register_device(struct mt7915_dev *dev)
 void mt7915_unregister_device(struct mt7915_dev *dev)
 {
 	mt7915_unregister_ext_phy(dev);
+	mt7915_coredump_unregister(dev);
 	mt7915_unregister_thermal(&dev->phy);
 	mt76_unregister_device(&dev->mt76);
 	mt7915_stop_hardware(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index c8e69644c552..ccabe492075e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -3,6 +3,7 @@
 
 #include <linux/etherdevice.h>
 #include <linux/timekeeping.h>
+#include "coredump.h"
 #include "mt7915.h"
 #include "../dma.h"
 #include "mac.h"
@@ -1597,6 +1598,75 @@ void mt7915_mac_reset_work(struct work_struct *work)
 					     MT7915_WATCHDOG_TIME);
 }
 
+/* firmware coredump */
+void mt7915_mac_dump_work(struct work_struct *work)
+{
+	const struct mt7915_mem_region *mem_region;
+	struct mt7915_crash_data *crash_data;
+	struct mt7915_dev *dev;
+	struct mt7915_mem_hdr *hdr;
+	size_t buf_len;
+	int i;
+	u32 num;
+	u8 *buf;
+
+	dev = container_of(work, struct mt7915_dev, dump_work);
+
+	mutex_lock(&dev->dump_mutex);
+
+	crash_data = mt7915_coredump_new(dev);
+	if (!crash_data) {
+		mutex_unlock(&dev->dump_mutex);
+		goto skip_coredump;
+	}
+
+	mem_region = mt7915_coredump_get_mem_layout(dev, &num);
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
+			dev_warn(dev->mt76.dev, "%s len %lu is too large\n",
+				 mem_region->name, mem_region->len);
+			break;
+		}
+
+		/* reserve space for the header */
+		hdr = (void *)buf;
+		buf += sizeof(*hdr);
+		buf_len -= sizeof(*hdr);
+
+		mt7915_memcpy_fromio(dev, buf, mem_region->start,
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
+	mt7915_coredump_submit(dev);
+skip_coredump:
+	queue_work(dev->mt76.wq, &dev->reset_work);
+}
+
 void mt7915_reset(struct mt7915_dev *dev)
 {
 	if (!dev->recovery.hw_init_done)
@@ -1613,7 +1683,7 @@ void mt7915_reset(struct mt7915_dev *dev)
 			 wiphy_name(dev->mt76.hw->wiphy));
 
 		mt7915_irq_disable(dev, MT_INT_MCU_CMD);
-		queue_work(dev->mt76.wq, &dev->reset_work);
+		queue_work(dev->mt76.wq, &dev->dump_work);
 		return;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 032af46289af..3c840853a2c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -25,7 +25,22 @@ static const u32 mt7915_reg[] = {
 	[WFDMA_EXT_CSR_ADDR]	= 0xd7000,
 	[CBTOP1_PHY_END]	= 0x77ffffff,
 	[INFRA_MCU_ADDR_END]	= 0x7c3fffff,
-	[FW_EXCEPTION_ADDR]	= 0x219848,
+	[FW_ASSERT_STAT_ADDR]	= 0x219848,
+	[FW_EXCEPT_TYPE_ADDR]	= 0x21987c,
+	[FW_EXCEPT_COUNT_ADDR]	= 0x219848,
+	[FW_CIRQ_COUNT_ADDR]	= 0x216f94,
+	[FW_CIRQ_IDX_ADDR]	= 0x216ef8,
+	[FW_CIRQ_LISR_ADDR]	= 0x2170ac,
+	[FW_TASK_ID_ADDR]	= 0x216f90,
+	[FW_TASK_IDX_ADDR]	= 0x216f9c,
+	[FW_TASK_QID1_ADDR]	= 0x219680,
+	[FW_TASK_QID2_ADDR]	= 0x219760,
+	[FW_TASK_START_ADDR]	= 0x219558,
+	[FW_TASK_END_ADDR]	= 0x219554,
+	[FW_TASK_SIZE_ADDR]	= 0x219560,
+	[FW_LAST_MSG_ID_ADDR]	= 0x216f70,
+	[FW_EINT_INFO_ADDR]	= 0x219818,
+	[FW_SCHED_INFO_ADDR]	= 0x219828,
 	[SWDEF_BASE_ADDR]	= 0x41f200,
 	[TXQ_WED_RING_BASE]	= 0xd7300,
 	[RXQ_WED_RING_BASE]	= 0xd7410,
@@ -43,7 +58,22 @@ static const u32 mt7916_reg[] = {
 	[WFDMA_EXT_CSR_ADDR]	= 0xd7000,
 	[CBTOP1_PHY_END]	= 0x7fffffff,
 	[INFRA_MCU_ADDR_END]	= 0x7c085fff,
-	[FW_EXCEPTION_ADDR]	= 0x022050bc,
+	[FW_ASSERT_STAT_ADDR]	= 0x02204c14,
+	[FW_EXCEPT_TYPE_ADDR]	= 0x022051a4,
+	[FW_EXCEPT_COUNT_ADDR]	= 0x022050bc,
+	[FW_CIRQ_COUNT_ADDR]	= 0x022001ac,
+	[FW_CIRQ_IDX_ADDR]	= 0x02204f84,
+	[FW_CIRQ_LISR_ADDR]	= 0x022050d0,
+	[FW_TASK_ID_ADDR]	= 0x0220406c,
+	[FW_TASK_IDX_ADDR]	= 0x0220500c,
+	[FW_TASK_QID1_ADDR]	= 0x022028c8,
+	[FW_TASK_QID2_ADDR]	= 0x02202a38,
+	[FW_TASK_START_ADDR]	= 0x0220286c,
+	[FW_TASK_END_ADDR]	= 0x02202870,
+	[FW_TASK_SIZE_ADDR]	= 0x02202878,
+	[FW_LAST_MSG_ID_ADDR]	= 0x02204fe8,
+	[FW_EINT_INFO_ADDR]	= 0x0220525c,
+	[FW_SCHED_INFO_ADDR]	= 0x0220516c,
 	[SWDEF_BASE_ADDR]	= 0x411400,
 	[TXQ_WED_RING_BASE]	= 0xd7300,
 	[RXQ_WED_RING_BASE]	= 0xd7410,
@@ -61,7 +91,22 @@ static const u32 mt7986_reg[] = {
 	[WFDMA_EXT_CSR_ADDR]	= 0x27000,
 	[CBTOP1_PHY_END]	= 0x7fffffff,
 	[INFRA_MCU_ADDR_END]	= 0x7c085fff,
-	[FW_EXCEPTION_ADDR]	= 0x02204ffc,
+	[FW_ASSERT_STAT_ADDR]	= 0x02204b54,
+	[FW_EXCEPT_TYPE_ADDR]	= 0x022050dc,
+	[FW_EXCEPT_COUNT_ADDR]	= 0x02204ffc,
+	[FW_CIRQ_COUNT_ADDR]	= 0x022001ac,
+	[FW_CIRQ_IDX_ADDR]	= 0x02204ec4,
+	[FW_CIRQ_LISR_ADDR]	= 0x02205010,
+	[FW_TASK_ID_ADDR]	= 0x02204fac,
+	[FW_TASK_IDX_ADDR]	= 0x02204f4c,
+	[FW_TASK_QID1_ADDR]	= 0x02202814,
+	[FW_TASK_QID2_ADDR]	= 0x02202984,
+	[FW_TASK_START_ADDR]	= 0x022027b8,
+	[FW_TASK_END_ADDR]	= 0x022027bc,
+	[FW_TASK_SIZE_ADDR]	= 0x022027c4,
+	[FW_LAST_MSG_ID_ADDR]	= 0x02204f28,
+	[FW_EINT_INFO_ADDR]	= 0x02205194,
+	[FW_SCHED_INFO_ADDR]	= 0x022051a4,
 	[SWDEF_BASE_ADDR]	= 0x411400,
 	[TXQ_WED_RING_BASE]	= 0x24420,
 	[RXQ_WED_RING_BASE]	= 0x24520,
@@ -457,6 +502,14 @@ static u32 __mt7915_reg_addr(struct mt7915_dev *dev, u32 addr)
 	return mt7915_reg_map_l2(dev, addr);
 }
 
+void mt7915_memcpy_fromio(struct mt7915_dev *dev, void *buf, u32 offset,
+			  size_t len)
+{
+	u32 addr = __mt7915_reg_addr(dev, offset);
+
+	memcpy_fromio(buf, dev->mt76.mmio.regs + addr, len);
+}
+
 static u32 mt7915_rr(struct mt76_dev *mdev, u32 offset)
 {
 	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 96ef06511552..e647ba26e6ef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -220,6 +220,15 @@ struct mib_stats {
 	u32 tx_amsdu_cnt;
 };
 
+/* crash-dump */
+struct mt7915_crash_data {
+	guid_t guid;
+	struct timespec64 timestamp;
+
+	u8 *memdump_buf;
+	size_t memdump_buf_len;
+};
+
 struct mt7915_hif {
 	struct list_head list;
 
@@ -301,6 +310,7 @@ struct mt7915_dev {
 
 	struct work_struct init_work;
 	struct work_struct rc_work;
+	struct work_struct dump_work;
 	struct work_struct reset_work;
 	wait_queue_head_t reset_wait;
 
@@ -313,6 +323,14 @@ struct mt7915_dev {
 		bool restart:1;
 	} recovery;
 
+	/* protects coredump data */
+	struct mutex dump_mutex;
+#ifdef CONFIG_DEV_COREDUMP
+	struct {
+		struct mt7915_crash_data *crash_data;
+	} coredump;
+#endif
+
 	struct list_head sta_rc_list;
 	struct list_head sta_poll_list;
 	struct list_head twt_list;
@@ -558,6 +576,9 @@ static inline void mt7915_irq_disable(struct mt7915_dev *dev, u32 mask)
 		mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, mask, 0);
 }
 
+void mt7915_memcpy_fromio(struct mt7915_dev *dev, void *buf, u32 offset,
+			  size_t len);
+
 void mt7915_mac_init(struct mt7915_dev *dev);
 u32 mt7915_mac_wtbl_lmac_addr(struct mt7915_dev *dev, u16 wcid, u8 dw);
 bool mt7915_mac_wtbl_update(struct mt7915_dev *dev, int idx, u32 mask);
@@ -575,6 +596,7 @@ void mt7915_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta);
 void mt7915_mac_work(struct work_struct *work);
 void mt7915_mac_reset_work(struct work_struct *work);
+void mt7915_mac_dump_work(struct work_struct *work);
 void mt7915_mac_sta_rc_work(struct work_struct *work);
 void mt7915_mac_update_stats(struct mt7915_phy *phy);
 void mt7915_mac_twt_teardown_flow(struct mt7915_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index d7756cb0d29b..3509abaf2b82 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -24,7 +24,22 @@ enum reg_rev {
 	WFDMA_EXT_CSR_ADDR,
 	CBTOP1_PHY_END,
 	INFRA_MCU_ADDR_END,
-	FW_EXCEPTION_ADDR,
+	FW_ASSERT_STAT_ADDR,
+	FW_EXCEPT_TYPE_ADDR,
+	FW_EXCEPT_COUNT_ADDR,
+	FW_CIRQ_COUNT_ADDR,
+	FW_CIRQ_IDX_ADDR,
+	FW_CIRQ_LISR_ADDR,
+	FW_TASK_ID_ADDR,
+	FW_TASK_IDX_ADDR,
+	FW_TASK_QID1_ADDR,
+	FW_TASK_QID2_ADDR,
+	FW_TASK_START_ADDR,
+	FW_TASK_END_ADDR,
+	FW_TASK_SIZE_ADDR,
+	FW_LAST_MSG_ID_ADDR,
+	FW_EINT_INFO_ADDR,
+	FW_SCHED_INFO_ADDR,
 	SWDEF_BASE_ADDR,
 	TXQ_WED_RING_BASE,
 	RXQ_WED_RING_BASE,
@@ -957,7 +972,22 @@ enum offs_rev {
 #define MT_ADIE_TYPE_MASK		BIT(1)
 
 /* FW MODE SYNC */
-#define MT_FW_EXCEPTION			__REG(FW_EXCEPTION_ADDR)
+#define MT_FW_ASSERT_STAT		__REG(FW_ASSERT_STAT_ADDR)
+#define MT_FW_EXCEPT_TYPE		__REG(FW_EXCEPT_TYPE_ADDR)
+#define MT_FW_EXCEPT_COUNT		__REG(FW_EXCEPT_COUNT_ADDR)
+#define MT_FW_CIRQ_COUNT		__REG(FW_CIRQ_COUNT_ADDR)
+#define MT_FW_CIRQ_IDX			__REG(FW_CIRQ_IDX_ADDR)
+#define MT_FW_CIRQ_LISR			__REG(FW_CIRQ_LISR_ADDR)
+#define MT_FW_TASK_ID			__REG(FW_TASK_ID_ADDR)
+#define MT_FW_TASK_IDX			__REG(FW_TASK_IDX_ADDR)
+#define MT_FW_TASK_QID1			__REG(FW_TASK_QID1_ADDR)
+#define MT_FW_TASK_QID2			__REG(FW_TASK_QID2_ADDR)
+#define MT_FW_TASK_START		__REG(FW_TASK_START_ADDR)
+#define MT_FW_TASK_END			__REG(FW_TASK_END_ADDR)
+#define MT_FW_TASK_SIZE			__REG(FW_TASK_SIZE_ADDR)
+#define MT_FW_LAST_MSG_ID		__REG(FW_LAST_MSG_ID_ADDR)
+#define MT_FW_EINT_INFO			__REG(FW_EINT_INFO_ADDR)
+#define MT_FW_SCHED_INFO		__REG(FW_SCHED_INFO_ADDR)
 
 #define MT_SWDEF_BASE			__REG(SWDEF_BASE_ADDR)
 
-- 
2.36.1

