Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C893AB845
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbhFQQGM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:12 -0400
Received: from mail-eopbgr140058.outbound.protection.outlook.com ([40.107.14.58]:8512
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233581AbhFQQF6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiDj7NcJNl7pZasOz/Lm0yuIOEpZG9M2g4L2sslkVu0sITBKzp1BzLHY6AdQKw0+0R2pFoF7BnLIevUL5Azs0OIQakAopE8A4lQutKP+jMfwxUH6kLoSpe6hmrtHkgcyGONiRj7uLYO5TXIbngYxHOZb7w4a7c3wLh1gx7m5OkUqGp0+gIVIp+yI9vsaqUifJOdvTPCSH+iJ0w2MEdvexxCf+yeGfMTHg4WkEUbTyu0BJCAEgwUnsWKOrcpgmTNmc4G9q+JWoVXkqYj6nShP5iU/hz8BeybJPbX9rdvUusYVbkmzM4SW0v9TxmBcDpeeaT801gIG0eLYnUaqLw9EAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7x9EZCVOOPZFjOS+r8CXd6P0OHei2BLNzrogh8Bmv/k=;
 b=PrxNwYCpxxKHTMybV7BFFrYg9uQ9lZAdEI+QiFdkSR7akyfTDeUPWik0YQ/dlDkgidAGe1SNlsfkvK4h9IpIj+89XDOJQTYOWFf0dkMbP1I2OVmdnkrjjsY1ZfNF67jZyd55XZxnaG5RadGkUz/qmEFqF3+5owPpdHU3NeneuDJdEiizpP2kcPB4r45rAfxqTNHiozvQm14KJbDLCpXXrAeq4Z1PtMzKKM+7bmXKWReLB6CveVVd7+6tQgOYqQweWvu0odQZAItf5IZWhXS5pvDvK6Po1/1CzXbFo9xNfzSVpbsky+wfr8frr1uucfxFDlowF7bEQIhfWgNvYKgLoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7x9EZCVOOPZFjOS+r8CXd6P0OHei2BLNzrogh8Bmv/k=;
 b=FmNs7btRPbL8wFEowTgghURQTBLIFzQKH61bDgnlo4ffxZ+MvAH49GwJbspR693evXnem2Tp854uEuRoyzYYb7Hyi1wqnwxLy/brCfIDTjq8TJTAgF7cl9qsleg0/5qv+iaBpWMjjyYq6cfr62WLf5kSR2ehkylkTfD3seguVko=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1234.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:03:42 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:42 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v1 043/256] cl8k: add chip.h
Date:   Thu, 17 Jun 2021 15:58:50 +0000
Message-Id: <20210617160223.160998-44-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210617160223.160998-1-viktor.barna@celeno.com>
References: <20210617160223.160998-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [62.216.42.54]
X-ClientProxiedBy: PR3PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::23) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ab720e6-8f3b-427e-38d9-08d931a96de9
X-MS-TrafficTypeDiagnostic: AM9P192MB1234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1234122B360D364A061E65F8F60E9@AM9P192MB1234.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t6FeUbDvKSrMlyTwRqm4Tr74z4JShEHyjySu6zSQL/9dHZ/Ki3ZG+LpI1/JOPINQDuGHCutdYLESYZhl0T39tEf0mAIQG9FIwHBTlayboq8ChJ8E0/0Wl4YFjcAfCFKI+yKpcGqhoXbjVx/a1DMvihncFeQYm5UCK9EpbO0z3K6jRoVeoptnWP6iN0oHr2prb56Ft+XNm1rIxtkr/unonVg7aw/GslFIM5b7qxIAQ/YPQWXNyfwjwYOwix6p9ZLMOdwRoeXpqv/CFGIAzEXNScOCRu37lZdVckgk8BQqM/6oyO5JKlFrYRPR10buTiqzGPBK4lcVvSgI9ys2wyAEzQQvOZN+F9Stc6YLlynX7gIcejBbZIVSbZkJnvkrLI/1RV1XZFyOMyKN2z0eTaOxeChV4/uLefTrHL2BC5tJhWbJlMc1WA0ztp5ID1/ez+Cm4WlInCUFSjxEuGhxGMs6wyQpt94p//twOtNxoVJCP52+twe/bnyGnixHlPUhJXirFsRhfepCaLAkRZRol7aOHagS1/XAdpL4lfBaRSnuuI7alovgqF/2bN4EwWtOnR6rv4bqvXtkaz2wAeM22gtKGcSsE8JrgG2u5a/9CdzjBsxrxqB9leqUtJWOK4hQRuxSXWPM+ExyRRaWAHT5hBLpoAtqEPULwU9EjHDKRxS9y17Nw8W1ep0HVzCaOR34LKHNI3juPRJYxq0C6yspZEz2EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(396003)(39850400004)(6666004)(107886003)(36756003)(956004)(66476007)(66556008)(2616005)(66946007)(6916009)(2906002)(26005)(9686003)(1076003)(6512007)(6486002)(16526019)(6506007)(38100700002)(52116002)(86362001)(8936002)(316002)(38350700002)(186003)(55236004)(54906003)(8676002)(5660300002)(508600001)(83380400001)(4326008)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CLaHKy4t0DbT67XuJ2TJpaZjpPbb8LVzn8TxxP0KgPyCFHO6mOIYXUsHubGP?=
 =?us-ascii?Q?udOw/42adyYd4RzVKDVqLaaiS/7osurqZGaSCC+TSJU9dlRwOBhYG8mMr83k?=
 =?us-ascii?Q?zBf1dRESwx245BzdRvTIDJJi9z7ZM2OYGwAIe4PyJWZ69MzhPa9jGw3qq9C3?=
 =?us-ascii?Q?176SvxJca/fj8EOP5H9H31Osb4aQm+u6xq0xkg8Ru7F2WklDYgC/g3IJGAOb?=
 =?us-ascii?Q?6Sy64Pt25YgSFQfR2UQEp+eQuwlkqdGh69O97wQY8NE0vzCQTiBHbzl1WbhH?=
 =?us-ascii?Q?zlh9aEScwm/R9xBZoSuKTJX9yeI6D89SOS3n2jREVoV577pUTOyrFF0D5uv0?=
 =?us-ascii?Q?w6fanEm2UjMdTZIc8TeKu2KQUlI47/pAdIccFBpjsSpchSGn0stW05ZzQp0P?=
 =?us-ascii?Q?LoukIF1yfdWsqzM21MgdtQR+iTSoM4U8QcZo9ZsdbsYRd2ue4N1u3D8G8g20?=
 =?us-ascii?Q?eSJqwLPCA6Vzq6BkDXn9THPH1KCgmQRZJqiJEdyl2IkgSX8AX1c46Q1HkE9F?=
 =?us-ascii?Q?8y4DhAOjnS7wECeQldgrSVxv0LQp4/yCD5lPI7OCVnmr494g8JVCqSAiqux+?=
 =?us-ascii?Q?+pffGzoZlcy4Ck+CcD2SzokDZM+knsmvf1BgRupiAbg2b0SxnEcWb1qqmYH4?=
 =?us-ascii?Q?YRJvFkEuecIjASnCKVq56S+Ifx0+jIbUP8muSEt/aZkixgjL9ACE6W7c/f9p?=
 =?us-ascii?Q?ortYwhFI0LSnVYOUEjNe/HtAdH4mDM3+puw8M7qEOG32hueO4pLRUMAf83xd?=
 =?us-ascii?Q?utRKHs+KTzQHQMnr/GRLlMls2XvkQ/doMOGm2No2uA7H8h28aCgOWsHJwKv9?=
 =?us-ascii?Q?5EE6sOiBxhdIkIGfeWhdP7jIunexPG3wGp2WOPAyYfQrcOk/CaXTJM4YSOr7?=
 =?us-ascii?Q?tLwqAOBeJtLI/IOZ+j3+Gy8kpRLnhVhnUP8JPF2SQnc2cH+67zwAxy++MwyT?=
 =?us-ascii?Q?OFSpK8OVzAIjCw3E1p7vynSaN1fX+VNrVPMFxUTN7LaF0VFmxJ7l72DtCggR?=
 =?us-ascii?Q?UXF+lQPqcox660w2q95//omherx/z4acu0gw3tnCFHp9mbALLSvkZZ5C3Mdp?=
 =?us-ascii?Q?4gRCSdF2kzj2FO8RnDTXybtCfV3xc19C0yAcfCeeIL6s3tbV2NFbcIfZbRwY?=
 =?us-ascii?Q?7MbELhtf/BmXDFgRUdRhTyqR/lw8bpArAfGhighnMKpyzxcYAA34AB4yo9RA?=
 =?us-ascii?Q?Z1Cz1C9gkoBAamgyXKp4QzWgD3KRc5j54Lgv1LCBebhdcy9uJ38lxG5S5t4e?=
 =?us-ascii?Q?humIxmFB4e/KG62qH/Uvw7rHJgY9f+KeEEpbjHVjZzvEljWYCG6ib40bkvJZ?=
 =?us-ascii?Q?QfndxAAFYReXvh1FJJSE/QmW?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab720e6-8f3b-427e-38d9-08d931a96de9
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:21.4424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhM0dJaOhzjNC4L2LAJQygDdM1+AnJ/YJ1Hg0p4izrX+S6YiZh2px8mO1OE27ClDc1d7XVx+785abL4f/n3/+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1234
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/chip.h | 143 ++++++++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/chip.h

diff --git a/drivers/net/wireless/celeno/cl8k/chip.h b/drivers/net/wireless=
/celeno/cl8k/chip.h
new file mode 100644
index 000000000000..c7548ca92e59
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/chip.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_CHIP_H
+#define CL_CHIP_H
+
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#ifdef CONFIG_CL_PCIE
+#include <linux/pci.h>
+#endif
+#include "calib.h"
+#include "temperature.h"
+#include "bus/pci/ipc.h"
+#include "chip_config.h"
+
+/**
+ * DOC: Chip basics
+ *
+ * Each physical device of ours is a separate chip, that is being describe=
d by
+ * %cl_chip structure. Each chip may be several (%TCV_MAX) transceivers (b=
ands),
+ * which are operating simultaneously and are described via own %ieee80211=
_hw
+ * unit (it refers to the private driver via specific pointer, described b=
y
+ * %cl_hw). Totally, 3 types of bands are supported - 2.4G/5.2G/6G. Driver
+ * supports multiple chips (up to %CHIP_MAX). Since the driver can control=
 up
+ * to %TCV_TOTAL entities, it is important to pass it's pointer to each
+ * function, that operates somehow with specific band/transceiver.
+ *
+ * Chip instance is being created during bus probing procedure and is bein=
g
+ * destroyed during bus removal procedure.
+ *
+ * Physically, 80xx chips family may have different amount of antennas (4/=
6/8),
+ * each of which may not be hardly bounded to the specific band (both band=
s are
+ * sharing them and may change antenna combinations in specific circumstan=
ces).
+ *
+ * Each band (transceiver) has own FW, that is being loaded by
+ * request_firmware() call during chip structure initialization procedure.=
 At
+ * lower layer each band is associated with own HW die by LMAC and SMAC na=
mes
+ * (e.g: 5.2G and 2.4G). Celeno is using XMAC naming when we are referring=
 to any
+ * of LMAC/SMAC components.
+ */
+
+enum cl_bus_type {
+       CL_BUS_TYPE_PCI,
+};
+
+struct cl_irq_stats {
+       unsigned long last_rx;
+       unsigned long last_tx;
+       unsigned long last_isr;
+       u32 last_isr_statuses;
+       u32 count_irq;
+       u32 ipc_success;
+};
+
+struct cl_fem_params {
+       u8 wiring_id;
+       u16 lut[FEM_TYPE_MAX];
+       u16 lut_registers[TCV_MAX][FEM_LUT_AMOUNT_PER_MAC];
+       u16 lut_off_register[TCV_MAX];
+       u16 lut_off_register_list[FEM_TYPE_MAX];
+};
+
+struct cl_afe_reg {
+       u32 ctrl36_phy0;
+       u32 ctrl36_phy1;
+       u32 ctrl37_phy0;
+       u32 ctrl37_phy1;
+};
+
+struct cl_ring_indices {
+       struct cl_ipc_ring_indices *params;
+       dma_addr_t dma_addr;
+       struct dma_pool *pool;
+};
+
+struct cl_xmem {
+       u32 total_used;
+       u32 size;
+};
+
+struct cl_ela_db {
+       char *raw_lcu_config;
+       struct list_head cmd_head;
+       struct {
+               u32 adaptations_cnt;
+               u32 applications_cnt;
+       } stats;
+       int error_state;
+};
+
+struct cl_chip {
+       u8 idx;
+       enum cl_bus_type bus_type;
+       bool temperature_configured;
+       u8 max_antennas;
+#ifdef CONFIG_CL_PCIE
+       struct pci_driver pci_drv;
+       struct pci_dev *pci_dev;
+#endif
+       void __iomem *pci_bar0_virt_addr;
+       struct cl_irq_stats irq_stats;
+       struct cl_temperature temperature;
+       struct cl_chip_conf *conf;
+       struct device *dev;
+       struct cl_hw *cl_hw_lut[TCV_MAX];
+       struct cl_hw *cl_hw_tcv0;
+       struct cl_hw *cl_hw_tcv1;
+       spinlock_t isr_lock;
+       spinlock_t spi_lock;
+       rwlock_t cl_hw_lock;
+       bool fw_first_tcv;
+       struct cl_fem_params fem;
+       struct eeprom *eeprom_cache;
+       int (*eeprom_read_block)(struct cl_chip *chip, u16 addr, u16 num_of=
_byte, u8 *data);
+       int (*eeprom_write_block)(struct cl_chip *chip, u16 addr, u16 num_o=
f_byte, u8 *data);
+       struct cl_afe_reg orig_afe_reg;
+       u8 agc_table_entry;
+       u8 lna_bypass_mode_set;
+       struct cl_calib_db calib_db;
+       struct cl_ela_db ela_db;
+       struct cl_ring_indices ring_indices;
+       u8 reg_dbg;
+       struct cl_xmem xmem_db;
+};
+
+struct cl_chip *cl_chip_alloc(u8 idx);
+void cl_chip_dealloc(struct cl_chip *chip);
+int cl_chip_init(struct cl_chip *chip);
+void cl_chip_deinit(struct cl_chip *chip);
+bool cl_chip_is_enabled(struct cl_chip *chip);
+bool cl_chip_is_both_enabled(struct cl_chip *chip);
+bool cl_chip_is_tcv_enabled(struct cl_chip *chip, u8 tcv_idx);
+bool cl_chip_is_tcv0_enabled(struct cl_chip *chip);
+bool cl_chip_is_tcv1_enabled(struct cl_chip *chip);
+void cl_chip_set_hw(struct cl_chip *chip, struct cl_hw *cl_hw);
+void cl_chip_unset_hw(struct cl_chip *chip, struct cl_hw *cl_hw);
+bool cl_chip_is_8ant(struct cl_chip *chip);
+bool cl_chip_is_6ant(struct cl_chip *chip);
+bool cl_chip_is_4ant(struct cl_chip *chip);
+bool cl_chip_is_6g(struct cl_chip *chip);
+
+#endif /* CL_CHIP_H */
--
2.30.0

________________________________
The information transmitted is intended only for the person or entity to wh=
ich it is addressed and may contain confidential and/or privileged material=
. Any retransmission, dissemination, copying or other use of, or taking of =
any action in reliance upon this information is prohibited. If you received=
 this in error, please contact the sender and delete the material from any =
computer. Nothing contained herein shall be deemed as a representation, war=
ranty or a commitment by Celeno. No warranties are expressed or implied, in=
cluding, but not limited to, any implied warranties of non-infringement, me=
rchantability and fitness for a particular purpose.
________________________________

