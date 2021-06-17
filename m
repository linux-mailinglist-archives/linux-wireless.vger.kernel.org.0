Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3753AB844
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhFQQGK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:10 -0400
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:17172
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233638AbhFQQF5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9AiBU9Qkt0FfvGk23stwpiNLvJKbsFHkYk70X9XrBRJPL337XpSQXTY1PeP2AG34DB9t+5BOTdzHdKDWmeXnkImDBwGvzLEc3HBxWKcRUvQZ4k92Ou4e8O5Htud0SWT9cTqBEpLb6558LkTKCMVL07hgMQRqBmvu9Mm4UeUk9G6yfWOCltfWqx24woO7dt2y/yQBnh/Rg3pyn4/cKPtLVDpKyfOM52nnXA5AFqOq4yxe0xeLnMNnHjZfeELGjAjxhOi6evRpOjZA5jInxQFIoUFD4VwpYxtJ4ZqegdKiV3Dw5wl9is5TWKmpVz11QlYYW16/Pq7nMyWka+N7h/WeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxZxPV6qAip0we8SIiVzfX6G1NO5z9TpQg+c98DaGlw=;
 b=AuoJgCa+AK/mLkd5g6iK35lhFmdY5v65RB5470MQvF7txNWlWuiTZJ1bRONANQ8X0V1Ll2VhNV0mrfBodN9UJouBQxIp12I8Bvhu6ndXz3NWODiwiHRNOUdD0P/BkMyZrqugbViunsidOqug1UqjK/srEtsEcHidzGw/u1YTAsVYsFqaZ7undEm6/Cz+k/6z5yt2l1CmHVOmAv/8t/Rveb2/J/KZmoCxLt654IMlf58U1zzITMO0Hb2x2jolCYdrLG78uOYemuVPDjJvSXjmw1n9xL/GoypUGGJiMoUKFdpi2sCpHkOm3SQu29g45kEqKQotfUIYO/hm7RQssAN57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxZxPV6qAip0we8SIiVzfX6G1NO5z9TpQg+c98DaGlw=;
 b=Ys4+67i/N0UVAxELUWqFSQO52HYGkHkWKjq8kh/NQT3v4Fi2l7KHPZEbUqtEEB8CdLFq+EL3e/+qxkxcnVHQN054GmnCDaBDAa9ns3PS1Zbr+MdRizGOJofg2AhDrkTixG53K9I4UWFdhpSwsv3pJ3524uqkj4oMq6Q2L/ImTeA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1234.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:03:41 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:41 +0000
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
Subject: [RFC v1 042/256] cl8k: add chip.c
Date:   Thu, 17 Jun 2021 15:58:49 +0000
Message-Id: <20210617160223.160998-43-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05a43e5e-76ae-484f-b18b-08d931a96d50
X-MS-TrafficTypeDiagnostic: AM9P192MB1234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1234A2FF3EDAD33B5DE3F7BFF60E9@AM9P192MB1234.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZ5qVfHUF12qS4XPdETaLxWfUHj6GA/1h4wgM62KPwzv8es5B2d3urNUBXmcuf7YZgDrB8B0JWKrp5HWn5GLpAA3l2ZaLNb1edQJdCpadocE5qf98q3cBW0s+mqpAwqATyW+JwkVgatAXxqINV9Hd6ZdIVMnGTciaOdgq4PfV3kUFrsTStajhzouddr3fJAVcMzYnSCl72ORi7qoxB8dD6ufL4VhAoi+PWVWD6mxnUYcksYxheQIbJ1NeacJKwcD4cR6WlV+ojAEsYe/TaqCv4yEt00p45xobzSGQ9fB1n8W5OGEZO1nxcoodcq7M2t+QP9fuxDak1MLkVUvLXyMbaAEOVLsHuFGyIiFWQIO96Ed5xp4G1V2kIoywTg4pB3hDbNxIuxHrvaG0G1/WLjH2nIjKFUlaH+zDDP9vOZp06WLkXNCY4SI8y31b1Sw5kaxdq2Qw8GDR3jLFPak0aQv0/ImjJi82vGbDN574gBYV7JQkj5WG1YjXA6JfloJ8HLrzkXslqDEmPSJTVVz5k8/LQROcIXoHF56Nf8WhUU4UauE9J9RzrXvFmAQVvYOtxPDknQNW2RoICZVqPZc7wQzyZIB5zLoNOqo/X6oOiGlXXDaCVVMoVJDU76/Y1ozvA2kY9pKwog7iHQZHBBXUoA66SaEaid15jLR8HUILKBgZpCw6g7swL23MLNvsp3eoZfWG8t/NrBCZsodQczmlR6HOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(396003)(39850400004)(6666004)(107886003)(36756003)(956004)(66476007)(66556008)(2616005)(66946007)(6916009)(2906002)(26005)(9686003)(1076003)(6512007)(6486002)(16526019)(6506007)(38100700002)(52116002)(86362001)(8936002)(316002)(38350700002)(186003)(55236004)(54906003)(8676002)(5660300002)(508600001)(83380400001)(4326008)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XF0uVJ/UR949EM6exNksrHVSOwje4YN6dEHoGq9Un7wHAV9+/xuXUKfybNqA?=
 =?us-ascii?Q?pjDBZ3whNkXm+xEso5KaMRo0qfy3YyS68Wu93+/d5qYXAvshr8aNGNtsUFzw?=
 =?us-ascii?Q?U/hWzMSYUTUEGUGz8LIDK2fqNuNS1UOHt5xSPYK244VIfkwJlit1MEVd40Gq?=
 =?us-ascii?Q?5vhPt7KXjYjOiVs/KSRCCEz/QBqAS5Dlo3kfM/3vTJQyGlKKcM1I783oPPQY?=
 =?us-ascii?Q?u6XqhFCnc9p1qi96jdHDa/WQucrLSioOmRiuGcJLtgzr7GFsA6BVnNSFo+Xt?=
 =?us-ascii?Q?+DRyvhalSat+jycdWQ1px2wqPHctHB1g5VJEgMJImzcpgpkq6PptQzbvTk7B?=
 =?us-ascii?Q?e/pZhMpISshsLZxBESP3/hht+OsyjCXkUZAsne7XvHPTwaTDRjZu0GxbmcHB?=
 =?us-ascii?Q?T9K/ioCFq6OvMxlpsrb7S40VfCIlARXyW4ngMoU5sap9LekOZ9TPkDdmBJAH?=
 =?us-ascii?Q?71yTEUvnySt7+tygVdEokSFcVurQUDWHdlOCk2cWHMCnykELZ/U8PulpF/J6?=
 =?us-ascii?Q?ZeQL+UJitXc2NUs58zlMMRUcHtO5FvDKB0aA5iG2OkzovPrmxxBRnyGMvMP9?=
 =?us-ascii?Q?I8o66+iZwj5hN2J2paScB7EBc0zakCTCiX8qa+KAu0r5XdZxb0NeRChTEWkK?=
 =?us-ascii?Q?Zb5XnEzpBOald3JsP/PlUVAHOpIKfApk9DYZIo9J/vXZj7sHuLGO8EzXnIaX?=
 =?us-ascii?Q?XizSJZU8vyAaCDwDZ65ib0wNuRj+1/hSJeRbI/xr5t8bzk+T3sOZK0IajMmS?=
 =?us-ascii?Q?B5q/do9DDssy4MCaPl8CtDFaW3EzUsK+ndgagJQVlPQZ/54UWmNs2QJyZYwn?=
 =?us-ascii?Q?m+sVz9rLL1yHLb56quaCzKx3yfzu/RQAUGGXGptCAzjA3+LCNi+rV7lVqPBR?=
 =?us-ascii?Q?4IO7b87lmKxTuh7RH5a7nGJDsqcXcN7CSHvCZEBJ/f57QhcclVYQVPSBYEFK?=
 =?us-ascii?Q?WpDOIixjrI8eXgK+Ii3IuHyAFQfTh7tOVJWYEH8wVkMcuxshC//ciVqfROmZ?=
 =?us-ascii?Q?fe8QLdJ3c2ASemauNljHr9P+NAVb/No07N3thZ4DRz6w+m9H+cNh+iEm9Pqj?=
 =?us-ascii?Q?Pw1xCnZ2QfdWPXWMD/eG8uL7/fD3ZMd6i9n7uFUDzWVS7yEN/7t0Idhtj63z?=
 =?us-ascii?Q?4jU5h9hu+OB33eFK4MJBSPAEAfZO88iF8we9RjhMpMWl/bHREvgFV3Ph+oTq?=
 =?us-ascii?Q?2nqthSaM8KRUcI+sUN2pB5LwzadYsQVaqJby6Z+ZNJt15/OAqaNcJs6/3vRm?=
 =?us-ascii?Q?neIPtJsRUfNHabdSB3xrBRWLQVtos6EZHUHgpZkRXDeSNKm/zb7nUzhYUsh3?=
 =?us-ascii?Q?SJNJvCw1bI2z68qjuv/bBiee?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a43e5e-76ae-484f-b18b-08d931a96d50
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:20.4298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYI6W+V8j/GLGyNAd5YPM261bBFV3gBLLlNTUeE6FpwuXMq9Ces/rp6+baasJ6GId+tSyGUF0qCYh6za9r38Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1234
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/chip.c | 241 ++++++++++++++++++++++++
 1 file changed, 241 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/chip.c

diff --git a/drivers/net/wireless/celeno/cl8k/chip.c b/drivers/net/wireless=
/celeno/cl8k/chip.c
new file mode 100644
index 000000000000..5876b1da1857
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/chip.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include <linux/dmapool.h>
+#include "chip.h"
+#include "chip_config.h"
+#include "utils/utils.h"
+#include "reg/reg_access.h"
+#include "reg/reg_ipc.h"
+#include "temperature.h"
+#include "fem.h"
+#include "e2p.h"
+#include "ela.h"
+#include "utils/string.h"
+#include "main.h"
+#include "netlink.h"
+#include "data_rates.h"
+#ifdef CONFIG_CL_PCIE
+#include "bus/pci/irq.h"
+#endif
+
+#define CL_ALIGN_BOUND_64KB BIT(16)
+
+static void cl_chip_set_max_antennas(struct cl_chip *chip)
+{
+       switch (chip->pci_dev->device) {
+       case 0x8040:
+       case 0x8046:
+               chip->max_antennas =3D MAX_ANTENNAS_CL804X;
+               break;
+       case 0x8060:
+       case 0x8066:
+               chip->max_antennas =3D MAX_ANTENNAS_CL806X;
+               break;
+       case 0x8080:
+       case 0x8086:
+       default:
+               chip->max_antennas =3D MAX_ANTENNAS_CL808X;
+               break;
+       }
+
+       cl_dbg_chip_trace(chip, "max_antennas =3D %u\n", chip->max_antennas=
);
+}
+
+static int cl_chip_print_serial_number(struct cl_chip *chip)
+{
+       u8 serial_number[SIZE_GEN_SERIAL_NUMBER + 1] =3D {0};
+
+       if (cl_e2p_read(chip, (u8 *)&serial_number, SIZE_GEN_SERIAL_NUMBER,=
 ADDR_GEN_SERIAL_NUMBER))
+               return -1;
+
+       if (strlen(serial_number) =3D=3D 0)
+               CL_DBG_WARNING_CHIP(chip, "Serial-number in not set in EEPR=
OM\n");
+       else
+               cl_dbg_chip_verbose(chip, "Serial-number =3D %s\n", serial_=
number);
+
+       return 0;
+}
+
+static int cl_chip_ring_indices_init(struct cl_chip *chip)
+{
+       struct cl_ring_indices *ring_indices =3D &chip->ring_indices;
+
+       ring_indices->pool =3D dma_pool_create("cl_ring_indices_pool", chip=
->dev,
+                                            (sizeof(struct cl_ipc_ring_ind=
ices) * TCV_MAX),
+                                            CL_ALIGN_BOUND_64KB, CL_ALIGN_=
BOUND_64KB);
+
+       if (!ring_indices->pool) {
+               cl_dbg_chip_err(chip, "ring_indices pool create failed !!!\=
n");
+               return -ENOMEM;
+       }
+
+       ring_indices->params =3D dma_pool_alloc(ring_indices->pool, GFP_KER=
NEL,
+                                             &ring_indices->dma_addr);
+       if (!ring_indices->params)
+               return -ENOMEM;
+
+       return 0;
+}
+
+static void cl_chip_ring_indices_deinit(struct cl_chip *chip)
+{
+       if (chip->ring_indices.params) {
+               dma_pool_free(chip->ring_indices.pool,
+                             chip->ring_indices.params,
+                             chip->ring_indices.dma_addr);
+               chip->ring_indices.params =3D NULL;
+       }
+
+       dma_pool_destroy(chip->ring_indices.pool);
+       chip->ring_indices.pool =3D NULL;
+}
+
+struct cl_chip *cl_chip_alloc(u8 idx)
+{
+       struct cl_chip *chip =3D kzalloc(sizeof(*chip), GFP_KERNEL);
+
+       if (!chip)
+               return NULL;
+
+       chip->idx =3D idx;
+       return chip;
+}
+
+void cl_chip_dealloc(struct cl_chip *chip)
+{
+       cl_chip_config_dealloc(chip);
+       kfree(chip);
+}
+
+int cl_chip_init(struct cl_chip *chip)
+{
+       int ret =3D 0;
+
+       chip->agc_table_entry =3D U8_MAX;
+
+       spin_lock_init(&chip->isr_lock);
+       spin_lock_init(&chip->spi_lock);
+
+       rwlock_init(&chip->cl_hw_lock);
+
+       cl_chip_set_max_antennas(chip);
+
+#ifdef CONFIG_CL_PCIE
+       ret =3D cl_irq_request(chip);
+       if (ret)
+               return ret;
+#endif
+       ipc_host_global_int_en_set(chip, 1);
+
+       cl_temperature_init(chip);
+
+       ret =3D cl_e2p_init(chip);
+       if (ret) {
+               cl_dbg_chip_err(chip, "cl_e2p_init failed %d\n", ret);
+               return ret;
+       }
+
+       ret =3D cl_fem_init(chip);
+       if (ret)
+               return ret;
+
+       ret =3D cl_chip_ring_indices_init(chip);
+       if (ret)
+               return ret;
+
+       cl_chip_print_serial_number(chip);
+
+       cl_wrs_tables_global_build();
+       cl_data_rates_inverse_build();
+
+       return ret;
+}
+
+void cl_chip_deinit(struct cl_chip *chip)
+{
+       cl_chip_ring_indices_deinit(chip);
+       cl_temperature_close(chip);
+       cl_e2p_close(chip);
+       ipc_host_global_int_en_set(chip, 0);
+
+#ifdef CONFIG_CL_PCIE
+       cl_irq_free(chip);
+#endif
+}
+
+bool cl_chip_is_enabled(struct cl_chip *chip)
+{
+       return cl_chip_is_tcv0_enabled(chip) || cl_chip_is_tcv1_enabled(chi=
p);
+}
+
+bool cl_chip_is_both_enabled(struct cl_chip *chip)
+{
+       return cl_chip_is_tcv0_enabled(chip) && cl_chip_is_tcv1_enabled(chi=
p);
+}
+
+bool cl_chip_is_tcv_enabled(struct cl_chip *chip, u8 tcv_idx)
+{
+       return chip->conf->ce_tcv_enabled[tcv_idx];
+}
+
+bool cl_chip_is_tcv0_enabled(struct cl_chip *chip)
+{
+       return chip->conf->ce_tcv_enabled[TCV0];
+}
+
+bool cl_chip_is_tcv1_enabled(struct cl_chip *chip)
+{
+       return chip->conf->ce_tcv_enabled[TCV1];
+}
+
+void cl_chip_set_hw(struct cl_chip *chip, struct cl_hw *cl_hw)
+{
+       if (cl_hw_is_tcv0(cl_hw))
+               chip->cl_hw_tcv0 =3D cl_hw;
+       else
+               chip->cl_hw_tcv1 =3D cl_hw;
+}
+
+void cl_chip_unset_hw(struct cl_chip *chip, struct cl_hw *cl_hw)
+{
+       if (cl_hw_is_tcv0(cl_hw))
+               chip->cl_hw_tcv0 =3D NULL;
+       else
+               chip->cl_hw_tcv1 =3D NULL;
+}
+
+bool cl_chip_is_8ant(struct cl_chip *chip)
+{
+       return chip->max_antennas =3D=3D MAX_ANTENNAS_CL808X;
+}
+
+bool cl_chip_is_6ant(struct cl_chip *chip)
+{
+       return chip->max_antennas =3D=3D MAX_ANTENNAS_CL806X;
+}
+
+bool cl_chip_is_4ant(struct cl_chip *chip)
+{
+       return chip->max_antennas =3D=3D MAX_ANTENNAS_CL804X;
+}
+
+static u16 cl_chip_get_device_id(struct cl_chip *chip)
+{
+       u16 device_id =3D chip->pci_dev->device;
+
+       /* If device-id is default, set it accoridng to phy-dev. */
+       if (device_id =3D=3D 0x8000 || device_id =3D=3D 0x8001)
+               device_id =3D IS_PHY_ATHOS(chip) ? 0x8086 : 0x8080;
+
+       return device_id;
+}
+
+bool cl_chip_is_6g(struct cl_chip *chip)
+{
+       u16 device_id =3D cl_chip_get_device_id(chip);
+       u8 band =3D device_id & 0xf;
+
+       return (band =3D=3D 6);
+}
+
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

