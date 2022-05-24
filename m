Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A6E53293F
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbiEXLiG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbiEXLiF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:38:05 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2BB8BD09
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:37:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOXnxCzDcAjNaKEwYtbV3dps/RNditZizRWyvM07ZmjpvZSEpie1qqNQ0kOBh6aVCB/eN/Hkbj6hNs+bx8SSPMMhzETKuDsbMcW7cIpQp5qEqoahJEwzHIBcrxTkPEMHEDMZ8THBwmkZ3cF/4ri6t8gIxOwoj2CAx/pAxjr7FRmqr7PNfok3EEKzizzHS695qWWQOz8vHhW9wStm7JXIuuu6rEWRmJcS/TaSHknBbi4O5IGmRpxxC4O203RS3DbkQn8UAjX54rh++8J9Jt3wH04hVKDua2sui3Io6PVYDyevcFhxA1wT4KVCumIJ1qvxkalOeRws67AS0Q0eXPcO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/yje7kGVUxMRVXinPBQpt7CEFdo5vm3t3XU8367uwc=;
 b=iy20+KlFAO1M1yf9+xidU/lmiPYALYxokVvphp+0doTJp5F7fv2b/WF2atLaJhXtNbQh3kRNeJqaC9MfmsAQrZi4mp+UsvKXgy8R3f9Em0v9eQF+aYFSfsxKvmiCEpjZq4o4uCiN5LqcKpvpuzdx5SfJjCwGlj0n0gEkI5GmgYxbE+grdZgFoZ0z0RxfoBYoCb+WhNvj+IkU2x/9ksE40ARdmUPp6gFusv+h/TDw8pxmyoi1d7/ZUxwAjji7OxXYK19wufNJBRW7RdfRosZccBsvX4tvmk44nTGJAy+8agHRvvQ4wr4Xvx6n3BU/5gBzMTG0GURn70Hif4U4lI2Pag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/yje7kGVUxMRVXinPBQpt7CEFdo5vm3t3XU8367uwc=;
 b=SPxOxu8Hrp8dtLaj8mFrKOH9HvRpLTlfF7pItr1Z+LoEXBzLRw7bWwEtoBjGz7S+2NwnTxg810MKdZCWdmRxz8h/a1ExGiGTogPy2dNFdD1Hi7r6GF5O4NMwQS/rIzCZat4fO6GD0hzIj/CJOMDnbsSXPCcsOsMwmjaY0UGtnII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM6P192MB0469.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:32::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:37:53 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:37:53 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Maksym Kokhan <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v2 14/96] cl8k: add chip.h
Date:   Tue, 24 May 2022 14:33:40 +0300
Message-Id: <20220524113502.1094459-15-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220524113502.1094459-1-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR10CA0092.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::33) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d2c010b-46bc-49e1-5f21-08da3d79d69f
X-MS-TrafficTypeDiagnostic: AM6P192MB0469:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM6P192MB04696E1BC1E9A46C745BBB2BF6D79@AM6P192MB0469.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/z2CFkn0y5qlHHsWyEIUOH/bIXhRygIQgdSTiQ46HMmt5t7pC4+pwHjjHHwvzFDGmyF//K7fsCiUQ26SbPn+0YgSTQWafKeRQEMYBQx1+3I7dQVNtVp7iv+UDI+1yCblWMmVhUJdskSTsukE+eY4FPsfY4EmZgHXtlLoiUxLZs3ZKk3YD9DDfvBhxGtDmGy0nAJ+qcOX3PcLoUQmZ0LVJXlNdmxTRjTSYJUy1baUDm7/+z3JigTfh372waVINjM8efCTli6Sk8+y/NgI+dtnVZr50W3rBOOKWzSdoQ7ZSGKavMn/PpOCYgMVbi858jg2noNZj59NF4Zxz3ZUTF9/QT0cYyglmhKAwADSCtOgg0izs/xedcPJskzo4258B8G8q/kR+WsgNnSCyzuJUJUQwBqDI2HRL6jBcauZMmdBWu4AVLfQcPWqTKgBwfJKUoYYnYbaAmfkHMD9Y5ssKYx/m56m8VI40BTnUdYL8aZdjFqEKg3Z5w2fWFzUQw+EkK5qnkVfFxP8qKLXkBsupaYOLmcl1zmXaviWUFcSd5ZFOtxox7bD9Bxjm35dA2e3zcbWElj41S1hnWfJCUtMvBQEIOum3yBft3/CjgE/YZGKhTxPoeALCvqqUs8Lz0FIZNEP3Nhrvihk9i04moDGs0qp/IHMmI7sWqh1INHmumz5kTFF73jmw7XJYVsLStsSXB+DvshPT2jvQFC91OBxRNxUuU8JbMcgZ2iR/g3EMUSBx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(346002)(376002)(136003)(366004)(39850400004)(6486002)(6916009)(508600001)(8936002)(86362001)(2906002)(5660300002)(4326008)(1076003)(83380400001)(36756003)(38100700002)(41300700001)(52116002)(186003)(66556008)(2616005)(6506007)(6512007)(26005)(316002)(54906003)(107886003)(8676002)(9686003)(66476007)(38350700002)(66946007)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FlyoC+fWvhKVE7dyuEy/F3b8FpPF0WFm9JCx0k52bDWe6odrTrR8zlbAMcxG?=
 =?us-ascii?Q?lOo4wkJSaX+sjKBPzslYcmftjAVYDpQp8Ieh9Irp7CVqLVnb3HQbQg1kpZCp?=
 =?us-ascii?Q?H3w40zA5JxojIRjDbypVbxYi3hyKycD7Ud8M2wpxcUzWDeDujyRursK/m331?=
 =?us-ascii?Q?D4Dubix/PRDpQV/9MkF9ypMtSOFoTFG7srwXZPmV9c3jADdq2272sDdCTxz6?=
 =?us-ascii?Q?I9HlAv5unXwIIIZoTz2hMA4V06iEyYiNB1Sfkee/ktP/YXPJrJHH0Kndm3gz?=
 =?us-ascii?Q?odpNjksgngrpdPH3OoRLv9EpcnyYr7C6DoWi1NQe9n6w1QHCeAhIaszmh0zu?=
 =?us-ascii?Q?CmTD37iguKYr3+q6rit/O0nn1mIPdJ74ONnSnk0eC7w2ExwB+i3JzO4IQhZH?=
 =?us-ascii?Q?7U/PsZ4/QfG8MgNiX9dVGFG2GjWp97+ZlWcFX4Tbr4iaOvu7hmHHUI5ryDHX?=
 =?us-ascii?Q?gxEpIYxJmsS6VdMw4T+vbf3vsPkEtNZAZxzc+gM4WnKDcRvj82bjeGyEPK4/?=
 =?us-ascii?Q?rnGrhp+UlqogF3pQLYmFw2xYpT7gRg0gulE7YcVFq8Ao6iqY6dzwbuk8rWEo?=
 =?us-ascii?Q?v00257GSLksj42PtLhX/BagDzpFA9csLKUzsHFDmU2hfAtH4vdOvpFNc1erW?=
 =?us-ascii?Q?LQ96fg43JDtumQJi68xDxmRcNX7PmRvKRLKR6mbyYRF1kR/us1NXOD7N1Z4n?=
 =?us-ascii?Q?Qbnj/7NfA3QIQ0q6uYno1eRrum6+mMvdbqtnCVSrLpoFlOW6tlxTWAR6ztOQ?=
 =?us-ascii?Q?f4oKD0JipTR9CGjDufNCEVeJycYBurp9L/SOc3h2iT5CDcQPzg2DMD3MYxVS?=
 =?us-ascii?Q?jthT0Q9fqR5XrC3pvYBNAgQoRtw9aN2sBGl2FQg7s7jwiFXJpjJ8cgXs99DB?=
 =?us-ascii?Q?KKekX3oe6VG4zW3ZogfjqF2ru7cGTr+N8vaXnGn+UkVYnarihm5UhRukEAdO?=
 =?us-ascii?Q?u+1y4MA9cFoS4m3NEqcgPhNUlUo+DNHGBYtdodhp8juxdmOVbezRgwhRF19R?=
 =?us-ascii?Q?FAKb5E/dDhrTMfmbZr3qX8ieLZIoZJ0ZXhk0zZaab5GZU4h8vKKig4yXZiQU?=
 =?us-ascii?Q?lFunpZqQeyUN13QOtv4rXz9M955uPl0s+7Sob0LkBhsuJM/07F65CZUI6McE?=
 =?us-ascii?Q?mhQyW33zgxQg375PlTAJZ+FELondf/i4Wiso8Tzfzyo4zgF4dQvLHbRStu9O?=
 =?us-ascii?Q?dCNgBiyuX8O+3N+qZpZlp+Scc71lwzopEjU4U2McMgcRYOO50ykxyVMAvnV7?=
 =?us-ascii?Q?M0CfqcirK1YCOMMvq9XboY/rXYRLLQQB8vtyAS2579X+ipSQcFA2LjNXSglM?=
 =?us-ascii?Q?0G0QLHaZ5+VsVy4dtPOoX1NWfutZoAmKXbpzfbQm1Kb3VIEyLDW54Xd7HvZ0?=
 =?us-ascii?Q?WdLSEOv+E3Hb3YPUUnZHf4+k4rKrwbTNQGy7b8D4YraF3XkzFfCNlgeEwCUw?=
 =?us-ascii?Q?wPO9ppCey6ftZxyAFR3VnEMV+fm9VZk/OmrCNv5P6b4F1e1d1nPJMrfvWmKj?=
 =?us-ascii?Q?LFaDWOaEi87OwXxBwsBbig1hd9B9YbTogCJZiqoA3eBVlSXr3dY0xHvKcGj/?=
 =?us-ascii?Q?K/vssJZJEgPFQZtipGyi5HCm7F8hR11yDkcOQoHRXCNpJ+J4Mdqc+J9KGaVN?=
 =?us-ascii?Q?7FZkrOyAgsKNmX0jM421Nq7f8bi8XaPRJDZ09YYVyA01khDUzNTPRcnHPUrR?=
 =?us-ascii?Q?SA1bTNv+0il7hB3p2eyE/OEUYn7XM4VVHo02u7j9HFLFOTS3zhN8zll+tAwd?=
 =?us-ascii?Q?PygEx58DHmmIvYing4ldm5h3RyvCJNQ=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2c010b-46bc-49e1-5f21-08da3d79d69f
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:37:53.0590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNxgSnDZycQecMiBjoRI47ETF1rym5OtUo+kFroMTqpogzcZak9n8T9wWvOUuNea8hdNiOJCAtKJqsVxnT696w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6P192MB0469
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/chip.h | 182 ++++++++++++++++++++++++
 1 file changed, 182 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/chip.h

diff --git a/drivers/net/wireless/celeno/cl8k/chip.h b/drivers/net/wireless/celeno/cl8k/chip.h
new file mode 100644
index 000000000000..29d02cb85fb4
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/chip.h
@@ -0,0 +1,182 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_CHIP_H
+#define CL_CHIP_H
+
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/pci.h>
+
+#include "pci.h"
+#include "calib.h"
+#include "sounding.h"
+#include "temperature.h"
+#include "platform.h"
+#include "phy.h"
+#include "ela.h"
+
+/**
+ * DOC: Chip basics
+ *
+ * Each physical device of ours is a separate chip, that is being described by
+ * %cl_chip structure. Each chip may be several (%TCV_MAX) transceivers (bands),
+ * which are operating simultaneously and are described via own %ieee80211_hw
+ * unit (it refers to the private driver via specific pointer, described by
+ * %cl_hw). Totally, 3 types of bands are supported - 2.4G/5.2G/6G. Driver
+ * supports multiple chips (up to %CHIP_MAX). Since the driver can control up
+ * to %TCV_TOTAL entities, it is important to pass it's pointer to each
+ * function, that operates somehow with specific band/transceiver.
+ *
+ * Chip instance is being created during bus probing procedure and is being
+ * destroyed during bus removal procedure.
+ *
+ * Physically, 80xx chips family may have different amount of antennas (4/6/8),
+ * each of which may not be hardly bounded to the specific band (both bands are
+ * sharing them and may change antenna combinations in specific circumstances).
+ *
+ * Each band (transceiver) has own FW, that is being loaded by
+ * request_firmware() call during chip structure initialization procedure. At
+ * lower layer each band is associated with own HW die by LMAC and SMAC names
+ * (e.g: 5.2G and 2.4G). Celeno is using XMAC naming when we are referring to any
+ * of LMAC/SMAC components.
+ */
+
+struct cl_ring_indices {
+	struct cl_ipc_ring_indices *params;
+	dma_addr_t dma_addr;
+	struct dma_pool *pool;
+};
+
+struct cl_chip {
+	u8 idx;
+	bool umac_active;
+	u8 max_antennas;
+	u8 rfic_version;
+	enum cl_bus_type bus_type;
+	struct pci_driver pci_drv;
+	struct pci_dev *pci_dev;
+	void __iomem *pci_bar0_virt_addr;
+	struct cl_irq_stats irq_stats;
+	struct cl_temperature temperature;
+	struct cl_chip_conf *conf;
+	struct device *dev;
+	struct cl_hw *cl_hw_lut[TCV_MAX];
+	struct cl_hw *cl_hw_tcv0;
+	struct cl_hw *cl_hw_tcv1;
+	u8 cdb_mode_maj;
+	spinlock_t isr_lock;
+	spinlock_t spi_lock;
+	struct mutex start_msg_lock;
+	bool first_start_sent;
+	rwlock_t cl_hw_lock;
+	void (*ipc_host2xmac_trigger_set)(struct cl_chip *chip, u32 value);
+	bool rf_reg_overwrite;
+	struct cl_fem_params fem;
+	struct eeprom *eeprom_cache;
+	size_t eeprom_bin_size;
+	int (*eeprom_read_block)(struct cl_chip *chip, u16 addr, u16 num_of_byte, u8 *data);
+	int (*eeprom_write_block)(struct cl_chip *chip, u16 addr, u16 num_of_byte, u8 *data);
+	struct cl_iq_dcoc_conf iq_dcoc_conf;
+	struct cl_afe_reg orig_afe_reg;
+	struct cl_calib_db calib_db;
+	struct cl_ela_db ela_db;
+	struct cl_ring_indices ring_indices;
+	u8 reg_dbg;
+	struct cl_xmem xmem_db;
+	bool is_calib_eeprom_loaded;
+	struct workqueue_struct *chip_workqueue;
+	struct mutex recovery_mutex;
+	struct mutex calib_runtime_mutex;
+	struct mutex set_idle_mutex;
+	struct cl_platform platform;
+};
+
+struct cl_controller_reg {
+	u32 breset;
+	u32 debug_enable;
+	u32 dreset;
+	u32 ocd_halt_on_reset;
+	u32 run_stall;
+};
+
+struct cl_chip *cl_chip_alloc(u8 idx);
+void cl_chip_dealloc(struct cl_chip *chip);
+int cl_chip_init(struct cl_chip *chip);
+void cl_chip_deinit(struct cl_chip *chip);
+bool cl_chip_is_enabled(struct cl_chip *chip);
+bool cl_chip_is_both_enabled(struct cl_chip *chip);
+bool cl_chip_is_tcv0_enabled(struct cl_chip *chip);
+bool cl_chip_is_tcv1_enabled(struct cl_chip *chip);
+bool cl_chip_is_only_tcv0_enabled(struct cl_chip *chip);
+bool cl_chip_is_only_tcv1_enabled(struct cl_chip *chip);
+void cl_chip_set_hw(struct cl_chip *chip, struct cl_hw *cl_hw);
+void cl_chip_unset_hw(struct cl_chip *chip, struct cl_hw *cl_hw);
+bool cl_chip_is_8ant(struct cl_chip *chip);
+bool cl_chip_is_6ant(struct cl_chip *chip);
+bool cl_chip_is_4ant(struct cl_chip *chip);
+bool cl_chip_is_3ant(struct cl_chip *chip);
+bool cl_chip_is_6g(struct cl_chip *chip);
+u16 cl_chip_get_device_id(struct cl_chip *chip);
+
+#define CC_MAX_LEN 3 /* 2 characters + null */
+#define RM_MAX_LEN 5 /* 4 characters + null */
+#define FW_MAX_NAME 32
+
+struct cl_chip_conf {
+	bool ce_tcv_enabled[TCV_MAX];
+	s8 ce_lmac[FW_MAX_NAME];
+	s8 ce_smac[FW_MAX_NAME];
+	s32 ce_irq_smp_affinity;
+	u8 ce_eeprom_mode;
+	bool ce_production_mode;
+	bool ci_pci_msi_enable;
+	u8 ci_dma_lli_max_chan[TCV_MAX];
+	s8 ci_country_code[CC_MAX_LEN];
+	s8 ci_regdom_mode[RM_MAX_LEN];
+	s8 ce_ela_mode[STR_LEN_64B];
+	u8 ci_phy_dev;
+	s8 ce_debug_level;
+	u8 ce_host_pci_gen_ver;
+	s32 ci_scale_down_fw;
+	bool ce_temp_comp_en;
+	u8 ce_temp_protect_en;
+	s8 ce_temp_protect_delta;
+	s16 ce_temp_protect_th_max;
+	s16 ce_temp_protect_th_min;
+	u16 ce_temp_protect_tx_period_ms;
+	s16 ce_temp_protect_radio_off_th;
+	bool ci_phy_load_bootdrv;
+	u8 ce_phys_mac_addr[ETH_ALEN];
+	bool ce_lam_enable;
+	u8 ce_first_mask_bit;
+	bool ci_no_capture_noise_sleep;
+	bool ci_afe_config_en;
+	u32 ci_afe_vc_ref;
+	u32 ci_afe_vc_avd;
+	u32 ci_afe_vc_cml;
+	u16 ci_afe_eoc_ctrl;
+	u8 ci_afe_ch_cml_sel;
+	u8 ci_afe_cml_sel;
+	bool ci_afe_loopback;
+	bool ci_afe_hw_mode;
+	u8 ci_dcoc_mv_thr[CHNL_BW_MAX];
+	bool ci_calib_check_errors;
+	s8 ci_lolc_db_thr;
+	s8 ci_iq_db_thr;
+	bool ci_rx_resched_tasklet;
+	u32 ci_rx_skb_max;
+	bool ci_tcv1_chains_sx0;
+	u16 ci_sim_device_id;
+	bool ce_calib_runtime_en;
+	bool ci_calib_eeprom_en;
+	bool ci_calib_runtime_force;
+	bool ci_la_mirror_en;
+
+	/* New NVRAM parameters must be added to cl_chip_config_print() */
+};
+
+int cl_chip_config_read(struct cl_chip *chip);
+void cl_chip_config_dealloc(struct cl_chip *chip);
+
+#endif /* CL_CHIP_H */
-- 
2.36.1

