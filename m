Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49C8532943
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbiEXLiA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236773AbiEXLh6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:37:58 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7B152E53
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:37:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOkpy6LcgJg78fTc+qs5tWekiEIHCml34tkMoV/4mEfZzgIlqMOYPnWnMreNMqJkdrFL56I3HjAbB3lfR7/xaXdspNrVD0v5WsVO8zH7Pre5y+DWcYXXew9n4nChWYHDwCDcYpIomf70aNLUyv1u9r4C1JpT6zqUt152PFHbQT9dixYDwIfSUKPAonSG2+fyixHqQaZAH9bI59WJJOvkhX6hDkFA4kiJmj76PH+Zh+xLG4eKekpA09HZPL/fK2T1AtLWfA1ytJevoeFrjcarwkxQgDMGciyv3XPH7wXZyG8WtheATxzBgl9nsiKBL5kL1eLIrem2opmiecQrjqMIyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PHUAeh3NnhH1tt4Z80khQj4TXQ8emmo0Klqa2D/BEQ=;
 b=gW4OPbHtSJfPW6Y7oWpd9ZHjSgWgtl5KIspkkPnsDEuE3pGnM8DUqw34msHtdMog+rN6KHVKFFDADWa/CTafn/7lpGi8pgpLwTHJ62dk9JVDBi74oPLRepCdUu7hoDVmiKA1V5vYFcWyYWMWQ+yS/0qwwQ0NGBTJ/SZUd9R+gDT4mnIBsxuNZJZ0Vj9xKsEfsXge8VjMbNxCYs/6ecjQw/luY4YaD9QHm6x5TxYHvtT7PfYLMnmJINZkvadVa5LSXEKV7tDhcx7Y7a3rPK5PbbG4umnVbFX5Qz/VlJYFpNgDxE1CUw5ged085Ku6MKPzXRCARs/sx5utDnq1S+HI/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PHUAeh3NnhH1tt4Z80khQj4TXQ8emmo0Klqa2D/BEQ=;
 b=rQLmROF4XBeMMt0hEMfJCoJsq+TmDZga21sEZbVlvekqn1rVv8ukWq/vGuT7SwuojlYGLyFTE03Nlzbmc/duA855CxNNCGZtI6bFV8FjG4iKgnt/nlTkXlW1PzWqJ0Bsm9dI3N9y+1hOOrtSvmonYVvtgThND8iOv3C5INGiYsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM6P192MB0469.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:32::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:37:52 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:37:52 +0000
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
Subject: [RFC v2 13/96] cl8k: add chip.c
Date:   Tue, 24 May 2022 14:33:39 +0300
Message-Id: <20220524113502.1094459-14-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2d7db359-bb60-4a08-6acb-08da3d79d623
X-MS-TrafficTypeDiagnostic: AM6P192MB0469:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM6P192MB0469A57990F20A0E95F026CCF6D79@AM6P192MB0469.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k+Bjbvsu4FS6rYhLljf6mGs6x0vwdvefwJ/9wQFQ4QpAvlMx+0CNvLdNK3mCz+OkWSJa64yvdzStgwzE3qGk0owfUarliEN7FYl8hhPqCeJrtkni5sRaqV69yTdcuucIs0EjUhnyRDjo7mu7/Lx97xaMMx+ps7UhEDmQa42dZz5bixoM/OlbmaTPjxa7usAO23vCLF97oZyDYY7y/L+hT/W72BkSBpgELfeXBYP4nDHSWZdqdqRQcRNZ+aORUY87ablt9H97uwtVGJ9637UbzK4AerQ+8RC7xG3U29Xha6U8TWgD1GNl8cnn2GFg0bYiO51kOHrOaoK1xuGk4KfCc4k5NZyYezkuc2wYZI/Rt0lqwzVXvGwCNdyHBcGSno7zVaiRyhFUlnFWqeOQZzsJHrHiICCLucijyv/UU4WhIiXkVDde5u35bE1UX0I3d44b6QRaZh/9gKRWJ0Qt0bzXwgPPqA82rP/lmeI3eDydUlRKRM+H64Sk95Iz/c0oF6nKYniUJrabA1YjI2g/KJNY5sCciFUZodenybLI4jv4CZ+7b9m4nyWH1xWamMaKXQOiJAHxLCIT2z+BlVEnPV2smNdkMuQnmJZpTFvGjeKMN44ULCp8h2BQy+JT/0LDsfNJ9ikB+H2gMVNFt4+V4D5HQJWeFH5rjEE8+U25LhFE2TsR7L9/LZ3sl3yPZnB1tRWRqNu1CzQ6cXcFvFE/Rv7O7lhM0rxivYH5YxW11IOigs8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(346002)(376002)(136003)(366004)(39850400004)(6486002)(30864003)(6916009)(508600001)(8936002)(86362001)(2906002)(5660300002)(4326008)(1076003)(83380400001)(36756003)(38100700002)(41300700001)(52116002)(186003)(66556008)(2616005)(6506007)(6512007)(26005)(316002)(54906003)(107886003)(8676002)(9686003)(66476007)(38350700002)(66946007)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GGgZRvZ9W36ldRYKLNeBJMQrzRIpZNF7MFw1VcmOA8afMrgcct8KXi7nuAK1?=
 =?us-ascii?Q?shvb/1AMMMdAJuiO8blsM/86fYvDOLrnN1O4EKpccpcTPefWazcHSay4zW96?=
 =?us-ascii?Q?EzHr7Kq0Yy5/VtMnVt1+CC5jjqVI/Ok5XPUDk6JBq/hdQvpOVMsGxCnp2noK?=
 =?us-ascii?Q?anlRXFmK80jsCYVdeCw6Sq3Qc/4HEh8v99dYff6IaRZbsWrmQiAJlh8SdloI?=
 =?us-ascii?Q?A8d+nA5jm4WRAMNk2tnIzV/dJTjMzb3GdUBluIc8E4BaFTNbTskiSSLkAq4N?=
 =?us-ascii?Q?5R2qmbCVL4h1Ya4AYMORxqHKR1IPfM5t1jpfoFFMMWcIdV7ZJENQceO318RR?=
 =?us-ascii?Q?Qp75XdMNK+lo2ub5uCuCTILcSYGR4jsF+ElhlZ0Ox1pMyBKP54PD9c89+iTI?=
 =?us-ascii?Q?OfZNxL1EYpbnnWYi0xxtuH3dzkPv6buOX4TaZumeuv3viTNsTM68OZBCa8a4?=
 =?us-ascii?Q?i9JSXl0tSS7CRJVk+BvTqjujNrPKCExIeiBJWlXsSaPC1J3TSYbKlYP42/IB?=
 =?us-ascii?Q?Oa8hismwK1/cksLSo7wnJkjFHyIsnWIS9uXmC43uPEVxnfTb/rqozy2hHbDV?=
 =?us-ascii?Q?1v1BbwIlDQmKPB7ONwCqcnGZSfpTL6xblIPa/PJ95FiJiF8vBPkLFC0y0m/7?=
 =?us-ascii?Q?QnXciaBwnIi6p073DIdEyDS4QXGHzkFXBGPfGrAEwP3ghOKwWOa1i/mzGMTm?=
 =?us-ascii?Q?hEbrR5imd7knaGA8zuQ6UBd5yE0Mkm/iEibNJbQQG8znHPA46I4ahtekCIH2?=
 =?us-ascii?Q?LnDi4rwOC94wl1bZUfR4Nddk4cLvx/dJQXVbAOyGrD99VlhvuEr8Z2M+70wR?=
 =?us-ascii?Q?Y/wpI1WvG0PMADzMAuDiEz3tehKD7TsL1i+tsxIm3vmLCRVJrJW2PboMsEgN?=
 =?us-ascii?Q?/iwQUqT1hPykof4rqWV2Yv1UkG4wtvbKAl1xaep5CRjQXuHxcxa6RelS6vDC?=
 =?us-ascii?Q?KHRghpMXqocpu0WwhGJ+X1a57q8lnacVx59xEE/LmjQOkhuKAC0ATVWtRMdr?=
 =?us-ascii?Q?t5yjFuPF34nN8qMiHcpgo6qDwED9ruOViiQXWevbezRRZTjofSpwdbiguTB8?=
 =?us-ascii?Q?m89PFEnqG7IrTZJ+mzU8477oCkcjhV11Tdx+dHfaH6coZ3zPb0DGAcTVMczL?=
 =?us-ascii?Q?7tKeHN2ro4oYKjS5fawYiEjZrAErl2zAKeyAzwIpqnkjOMbn06vFVlgoF7f7?=
 =?us-ascii?Q?NtP5WJ7aPSEm9z1ULEiWP73SMGYm0tm5fR+RKwx/tqtOSLqi639ZvXHLkpTB?=
 =?us-ascii?Q?wNmTKtqrUvOtuCf3Qvz8Tvx0EIGk9D/kq2gFM4WN+gZ8n89uRC1TPZJ5TLFF?=
 =?us-ascii?Q?hFnjJ8IZGblH1qIkznebmkTf1qWGErnGNWTgmNe1BIcoZeRO85Mmzat0CWBK?=
 =?us-ascii?Q?ukukrZXY7z4OBU/kfuhrEly+/mGO+9u2gvLzmAiYxVFOZdMJ8/k1EdAm+Kq1?=
 =?us-ascii?Q?amz/QUmMa3J5RwC5YiKLqnfh6Zv4v5WoRoWqYE+m4E0PwUh4nCEowcnULJT3?=
 =?us-ascii?Q?dCHVK/Hu0zi+Y6XvGs+fVIXsjwiOPP+RrtrM6fwj8muV0NLvxCil0QrGVc1o?=
 =?us-ascii?Q?z2xYuD20O15kMRKhhEwHl2Fiqysma4b2ZqWVPVhMH7YX0mZytjy40m2sZXiF?=
 =?us-ascii?Q?RZgshhZXZRh6rAUUvwzudHBB8tI9b1tHlWeIsit2q9nC2vIduAWI/HPPQftb?=
 =?us-ascii?Q?C6im42bmvP/eG/hhSziiRWCFlQ+hHmeSJ2E2VXOtMjEnK4mwNbhZ8S/QZKSz?=
 =?us-ascii?Q?DI1+7HFowBfo+fHpHG9dyRFsLGj95hY=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7db359-bb60-4a08-6acb-08da3d79d623
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:37:52.0891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvNkphhj+RIAu2poNYG3sMhyw1iZNIMkNViEZ6gwI2R3c1lCh5iuxjlax9oyEY8cUY2sKmzeEWxPqv8OwTixpA==
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
 drivers/net/wireless/celeno/cl8k/chip.c | 580 ++++++++++++++++++++++++
 1 file changed, 580 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/chip.c

diff --git a/drivers/net/wireless/celeno/cl8k/chip.c b/drivers/net/wireless/celeno/cl8k/chip.c
new file mode 100644
index 000000000000..67f65dffd804
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/chip.c
@@ -0,0 +1,580 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include <linux/dmapool.h>
+
+#include "reg/reg_access.h"
+#include "reg/reg_defs.h"
+#include "temperature.h"
+#include "phy.h"
+#include "e2p.h"
+#include "main.h"
+#include "rates.h"
+#include "calib.h"
+#include "config.h"
+#include "utils.h"
+#include "chip.h"
+
+#define CL_ALIGN_BOUND_64KB BIT(16)
+
+static void cl_chip_set_max_antennas(struct cl_chip *chip)
+{
+	u16 device_id = cl_chip_get_device_id(chip);
+
+	switch (device_id) {
+	case 0x8040:
+	case 0x8046:
+		chip->max_antennas = MAX_ANTENNAS_CL804X;
+		break;
+	case 0x8060:
+	case 0x8066:
+		chip->max_antennas = MAX_ANTENNAS_CL806X;
+		break;
+	case 0x8080:
+	case 0x8086:
+	default:
+		chip->max_antennas = MAX_ANTENNAS_CL808X;
+		break;
+	}
+}
+
+/*
+ * This function is necessary since now we can't determine the max antenna number by the
+ * device_id alone, since there is at least one case of device_id 8046 and max antenna of 3.
+ */
+static void cl_chip_update_max_antennas(struct cl_chip *chip)
+{
+	u8 wiring_id = chip->fem.wiring_id;
+
+	if (wiring_id == FEM_WIRING_27_TCV0_2_TCV1_1 || wiring_id == FEM_WIRING_31_TCV0_2_TCV1_1)
+		chip->max_antennas = MAX_ANTENNAS_WIRING_ID_27_31;
+}
+
+static int cl_chip_print_serial_number(struct cl_chip *chip)
+{
+	u8 serial_number[SIZE_GEN_SERIAL_NUMBER + 1] = {0};
+
+	if (!IS_REAL_PHY(chip))
+		return 0;
+
+	if (cl_e2p_read(chip, (u8 *)&serial_number, SIZE_GEN_SERIAL_NUMBER, ADDR_GEN_SERIAL_NUMBER))
+		return -1;
+
+	if (strlen(serial_number) == 0)
+		cl_dbg_chip_verbose(chip, "Serial-number in not set in EEPROM\n");
+	else
+		cl_dbg_chip_verbose(chip, "Serial-number = %s\n", serial_number);
+
+	return 0;
+}
+
+static int cl_chip_ring_indices_init(struct cl_chip *chip)
+{
+	struct cl_ring_indices *ring_indices = &chip->ring_indices;
+
+	ring_indices->pool = dma_pool_create("cl_ring_indices_pool", chip->dev,
+					     (sizeof(struct cl_ipc_ring_indices) * TCV_MAX),
+					     CL_ALIGN_BOUND_64KB, CL_ALIGN_BOUND_64KB);
+
+	if (!ring_indices->pool) {
+		cl_dbg_chip_err(chip, "ring_indices pool create failed !!!\n");
+		return -ENOMEM;
+	}
+
+	ring_indices->params = dma_pool_alloc(ring_indices->pool, GFP_KERNEL,
+					      &ring_indices->dma_addr);
+	if (!ring_indices->params)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void cl_chip_ring_indices_deinit(struct cl_chip *chip)
+{
+	if (chip->ring_indices.params) {
+		dma_pool_free(chip->ring_indices.pool,
+			      chip->ring_indices.params,
+			      chip->ring_indices.dma_addr);
+		chip->ring_indices.params = NULL;
+	}
+
+	dma_pool_destroy(chip->ring_indices.pool);
+	chip->ring_indices.pool = NULL;
+}
+
+struct cl_chip *cl_chip_alloc(u8 idx)
+{
+	struct cl_chip *chip = vzalloc(sizeof(*chip));
+
+	if (!chip)
+		return NULL;
+
+	chip->idx = idx;
+	return chip;
+}
+
+void cl_chip_dealloc(struct cl_chip *chip)
+{
+	cl_chip_config_dealloc(chip);
+	vfree(chip);
+}
+
+static void cl_chip_workqueue_create(struct cl_chip *chip)
+{
+	if (!chip->chip_workqueue)
+		chip->chip_workqueue = create_singlethread_workqueue("chip_workqueue");
+}
+
+static void cl_chip_workqueue_destroy(struct cl_chip *chip)
+{
+	if (chip->chip_workqueue) {
+		destroy_workqueue(chip->chip_workqueue);
+		chip->chip_workqueue = NULL;
+	}
+}
+
+int cl_chip_init(struct cl_chip *chip)
+{
+	int ret = 0;
+
+	chip->ipc_host2xmac_trigger_set = ipc_host_2_umac_trigger_set;
+
+	chip->platform.app = NULL;
+	chip->platform.app_size = 0;
+	chip->platform.idx = U8_MAX;
+
+	spin_lock_init(&chip->isr_lock);
+	spin_lock_init(&chip->spi_lock);
+	mutex_init(&chip->start_msg_lock);
+	mutex_init(&chip->calib_runtime_mutex);
+
+	rwlock_init(&chip->cl_hw_lock);
+	mutex_init(&chip->recovery_mutex);
+	mutex_init(&chip->set_idle_mutex);
+
+	cl_chip_set_max_antennas(chip);
+
+	ret = cl_irq_request(chip);
+	if (ret)
+		return ret;
+
+	ipc_host_global_int_en_set(chip, 1);
+
+	cl_temperature_init(chip);
+
+	ret = cl_e2p_init(chip);
+	if (ret) {
+		cl_dbg_chip_err(chip, "cl_e2p_init failed %d\n", ret);
+		return ret;
+	}
+
+	ret = cl_fem_init(chip);
+	if (ret)
+		return ret;
+
+	/*
+	 * Update chip->max_antennas according to wiring_id if needed.
+	 * Should be called after cl_fem_init(), where wiring_id is read from eeprom.
+	 */
+	cl_chip_update_max_antennas(chip);
+
+	ret = cl_chip_ring_indices_init(chip);
+	if (ret)
+		return ret;
+
+	cl_chip_print_serial_number(chip);
+
+	cl_wrs_tables_global_build();
+	cl_data_rates_inverse_build();
+	cl_chip_workqueue_create(chip);
+
+	return ret;
+}
+
+void cl_chip_deinit(struct cl_chip *chip)
+{
+	cl_chip_workqueue_destroy(chip);
+
+	cl_chip_ring_indices_deinit(chip);
+
+	cl_temperature_close(chip);
+
+	cl_e2p_close(chip);
+
+	ipc_host_global_int_en_set(chip, 0);
+
+	cl_irq_free(chip);
+}
+
+u16 cl_chip_get_device_id(struct cl_chip *chip)
+{
+	u16 device_id = chip->pci_dev->device;
+
+	if (chip->conf->ci_sim_device_id)
+		return chip->conf->ci_sim_device_id;
+
+	/* If device-id is default, set it accoridng to phy-dev. */
+	if (device_id == 0x8000 || device_id == 0x8001)
+		device_id = (chip->conf->ci_phy_dev == PHY_DEV_ATHOS) ? 0x8086 : 0x8080;
+
+	return device_id;
+}
+
+bool cl_chip_is_enabled(struct cl_chip *chip)
+{
+	return cl_chip_is_tcv0_enabled(chip) || cl_chip_is_tcv1_enabled(chip);
+}
+
+bool cl_chip_is_both_enabled(struct cl_chip *chip)
+{
+	return cl_chip_is_tcv0_enabled(chip) && cl_chip_is_tcv1_enabled(chip);
+}
+
+bool cl_chip_is_tcv0_enabled(struct cl_chip *chip)
+{
+	return chip->conf->ce_tcv_enabled[TCV0];
+}
+
+bool cl_chip_is_tcv1_enabled(struct cl_chip *chip)
+{
+	return chip->conf->ce_tcv_enabled[TCV1];
+}
+
+bool cl_chip_is_only_tcv0_enabled(struct cl_chip *chip)
+{
+	return cl_chip_is_tcv0_enabled(chip) && !cl_chip_is_tcv1_enabled(chip);
+}
+
+bool cl_chip_is_only_tcv1_enabled(struct cl_chip *chip)
+{
+	return !cl_chip_is_tcv0_enabled(chip) && cl_chip_is_tcv1_enabled(chip);
+}
+
+void cl_chip_set_hw(struct cl_chip *chip, struct cl_hw *cl_hw)
+{
+	if (cl_hw_is_tcv0(cl_hw))
+		chip->cl_hw_tcv0 = cl_hw;
+	else
+		chip->cl_hw_tcv1 = cl_hw;
+}
+
+void cl_chip_unset_hw(struct cl_chip *chip, struct cl_hw *cl_hw)
+{
+	if (cl_hw_is_tcv0(cl_hw))
+		chip->cl_hw_tcv0 = NULL;
+	else
+		chip->cl_hw_tcv1 = NULL;
+}
+
+bool cl_chip_is_8ant(struct cl_chip *chip)
+{
+	return chip->max_antennas == MAX_ANTENNAS_CL808X;
+}
+
+bool cl_chip_is_6ant(struct cl_chip *chip)
+{
+	return chip->max_antennas == MAX_ANTENNAS_CL806X;
+}
+
+bool cl_chip_is_4ant(struct cl_chip *chip)
+{
+	return chip->max_antennas == MAX_ANTENNAS_CL804X;
+}
+
+bool cl_chip_is_3ant(struct cl_chip *chip)
+{
+	return chip->max_antennas == MAX_ANTENNAS_WIRING_ID_27_31;
+}
+
+bool cl_chip_is_6g(struct cl_chip *chip)
+{
+	u16 device_id = cl_chip_get_device_id(chip);
+	u8 band = device_id & 0xf;
+
+	return (band == 6);
+}
+
+#define MAX_FIRST_MASK_BIT ((ETH_ALEN * 8) - 1)
+
+static struct cl_chip_conf chip_conf = {
+	.ce_tcv_enabled = {
+		[TCV0] = false,
+		[TCV1] = false
+	},
+	.ce_lmac = "lmacfw.bin",
+	.ce_smac = "smacfw.bin",
+	.ce_irq_smp_affinity = -1,
+	.ce_eeprom_mode = E2P_MODE_BIN,
+	.ce_production_mode = false,
+	.ci_pci_msi_enable = true,
+	.ci_dma_lli_max_chan = {
+		[TCV0] = 6,
+		[TCV1] = 3
+	},
+	.ci_regdom_mode = "self",
+	.ci_country_code = "US",
+	.ce_ela_mode = "default",
+	.ci_phy_dev = PHY_DEV_OLYMPUS,
+	.ce_debug_level = DBG_LVL_ERROR,
+	.ce_host_pci_gen_ver = 3,
+	.ci_scale_down_fw = 1,
+	.ce_temp_comp_en = true,
+	.ce_temp_protect_en = TEMP_PROTECT_EXTERNAL,
+	.ce_temp_protect_delta = 0,
+	.ce_temp_protect_th_max = 105,
+	.ce_temp_protect_th_min = 95,
+	.ce_temp_protect_tx_period_ms = 50,
+	.ce_temp_protect_radio_off_th = 110,
+	.ci_phy_load_bootdrv = false,
+	.ce_phys_mac_addr = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00},
+	.ce_lam_enable = true,
+	.ce_first_mask_bit = 0,
+	.ci_no_capture_noise_sleep = true,
+	.ci_afe_config_en = true,
+	.ci_afe_vc_ref = 0x77777777,
+	.ci_afe_vc_avd = 0x55555555,
+	.ci_afe_eoc_ctrl = 0xaaaa,
+	.ci_afe_ch_cml_sel = 0xff,
+	.ci_afe_vc_cml = 0,
+	.ci_afe_cml_sel = 7,
+	.ci_afe_loopback = false,
+	.ci_afe_hw_mode = true,
+	.ci_dcoc_mv_thr = {
+		[CHNL_BW_20] = 150,
+		[CHNL_BW_40] = 100,
+		[CHNL_BW_80] = 100,
+		[CHNL_BW_160] = 100
+	},
+	.ci_calib_check_errors = false,
+	.ci_lolc_db_thr = -40,
+	.ci_iq_db_thr = -46,
+	.ci_rx_resched_tasklet = false,
+	.ci_rx_skb_max = 10000,
+	.ci_tcv1_chains_sx0 = false,
+	.ci_sim_device_id = 0,
+	.ce_calib_runtime_en = false,
+	.ci_calib_eeprom_en = 0,
+	.ci_calib_runtime_force = false,
+	.ci_la_mirror_en = true,
+};
+
+static int cl_chip_update_config(struct cl_chip *chip, char *name, char *value)
+{
+	struct cl_chip_conf *conf = chip->conf;
+	int ret = -ENOENT;
+
+	do {
+		READ_BOOL_ARR(ce_tcv_enabled, TCV_MAX);
+		READ_STR(ce_lmac);
+		READ_STR(ce_smac);
+		READ_S32(ce_irq_smp_affinity);
+		READ_U8(ce_eeprom_mode);
+		READ_BOOL(ce_production_mode);
+		READ_BOOL(ci_pci_msi_enable);
+		READ_U8_ARR(ci_dma_lli_max_chan, TCV_MAX, true);
+		READ_STR(ci_regdom_mode);
+		READ_STR(ci_country_code);
+		READ_STR(ce_ela_mode);
+		READ_U8(ci_phy_dev);
+		READ_S8(ce_debug_level);
+		READ_U8(ce_host_pci_gen_ver);
+		READ_S32(ci_scale_down_fw);
+		READ_BOOL(ce_temp_comp_en);
+		READ_U8(ce_temp_protect_en);
+		READ_S8(ce_temp_protect_delta);
+		READ_S16(ce_temp_protect_th_max);
+		READ_S16(ce_temp_protect_th_min);
+		READ_U16(ce_temp_protect_tx_period_ms);
+		READ_S16(ce_temp_protect_radio_off_th);
+		READ_BOOL(ci_phy_load_bootdrv);
+		READ_MAC(ce_phys_mac_addr);
+		READ_BOOL(ce_lam_enable);
+		READ_U8(ce_first_mask_bit);
+		READ_BOOL(ci_no_capture_noise_sleep);
+		READ_BOOL(ci_afe_config_en);
+		READ_U32(ci_afe_vc_ref);
+		READ_U8(ci_afe_cml_sel);
+		READ_BOOL(ci_afe_loopback);
+		READ_BOOL(ci_afe_hw_mode);
+		READ_U8_ARR(ci_dcoc_mv_thr, CHNL_BW_MAX, true);
+		READ_BOOL(ci_calib_check_errors);
+		READ_S8(ci_lolc_db_thr);
+		READ_S8(ci_iq_db_thr);
+		READ_BOOL(ci_rx_resched_tasklet);
+		READ_U32(ci_rx_skb_max);
+		READ_BOOL(ci_tcv1_chains_sx0);
+		READ_U16(ci_sim_device_id);
+		READ_BOOL(ce_calib_runtime_en);
+		READ_BOOL(ci_calib_eeprom_en);
+		READ_BOOL(ci_calib_runtime_force);
+		READ_BOOL(ci_la_mirror_en);
+	} while (0);
+
+	if (ret == -ENOENT) {
+		if (cl_config_is_non_driver_param(name))
+			ret = 0;
+		else
+			CL_DBG_ERROR_CHIP(chip, "No matching conf for nvram parameter %s\n", name);
+	}
+
+	return ret;
+}
+
+static bool cl_chip_is_valid_device_id(u16 device_id)
+{
+	switch (device_id) {
+	case 0x8000:
+	case 0x8001:
+	case 0x8080:
+	case 0x8086:
+	case 0x8060:
+	case 0x8040:
+	case 0x8066:
+	case 0x8046:
+		return true;
+	default:
+		pr_debug("Invalid device_id %u\n", device_id);
+		break;
+	}
+
+	return false;
+}
+
+static int cl_chip_post_configuration(struct cl_chip *chip)
+{
+	struct cl_chip_conf *conf = chip->conf;
+
+	if (conf->ce_eeprom_mode >= E2P_MODE_MAX) {
+		CL_DBG_ERROR_CHIP(chip,
+				  "Invalid ce_eeprom_mode [%u]. Must be 0 (file) or 1 (eeprom)\n",
+				  conf->ce_eeprom_mode);
+		return -EINVAL;
+	}
+
+	if (conf->ce_first_mask_bit > MAX_FIRST_MASK_BIT) {
+		CL_DBG_ERROR_CHIP(chip, "Invalid ce_first_mask_bit (%u). Must be <= %u\n",
+				  conf->ce_first_mask_bit, MAX_FIRST_MASK_BIT);
+		return -EINVAL;
+	}
+
+	if (conf->ci_tcv1_chains_sx0 && !conf->ce_production_mode) {
+		cl_dbg_chip_verbose(chip, "Force ci_tcv1_chains_sx0 to 0 for operational mode\n");
+		conf->ci_tcv1_chains_sx0 = false;
+	}
+
+	if (conf->ci_sim_device_id && !cl_chip_is_valid_device_id(conf->ci_sim_device_id)) {
+		CL_DBG_ERROR_CHIP(chip, "Invalid ci_sim_device_id (0x%x)\n",
+				  conf->ci_sim_device_id);
+		return -1;
+	}
+	/* IQ and DCOC calibration data will be saved only if runtime feature is enable */
+	if (chip->conf->ci_calib_eeprom_en && !chip->conf->ce_calib_runtime_en) {
+		chip->conf->ci_calib_eeprom_en = 0;
+		CL_DBG_ERROR_CHIP(chip, "Writing/reading calibration data from the EEPROM is "
+				  "disabled because ce_calib_runtime_en nvram isn't set\n");
+	}
+
+	return 0;
+}
+
+static int cl_chip_set_all_params_from_buf(struct cl_chip *chip, char *buf, loff_t size)
+{
+	char *line = buf;
+	char name[MAX_PARAM_NAME_LENGTH];
+	char value[STR_LEN_256B];
+	char *begin;
+	char *end;
+	int ret = 0;
+	int name_length = 0;
+	int value_length = 0;
+
+	while (line && strlen(line) && (line != (buf + size))) {
+		if ((*line == '#') || (*line == '\n')) {
+			/* Skip comment or blank line */
+			line = strstr(line, "\n") + 1;
+		} else if (*line) {
+			begin = line;
+			end = strstr(begin, "=");
+
+			if (!end) {
+				ret = -EBADMSG;
+				goto exit;
+			}
+
+			end++;
+			name_length = end - begin;
+			value_length = strstr(end, "\n") - end + 1;
+
+			if (name_length >= MAX_PARAM_NAME_LENGTH) {
+				cl_dbg_chip_err(chip, "Name too long (%u)\n", name_length);
+				ret = -EBADMSG;
+				goto exit;
+			}
+			if (value_length >= STR_LEN_256B) {
+				cl_dbg_chip_err(chip, "Value too long (%u)\n", value_length);
+				ret = -EBADMSG;
+				goto exit;
+			}
+
+			snprintf(name, name_length, "%s", begin);
+			snprintf(value, value_length, "%s", end);
+
+			ret = cl_chip_update_config(chip, name, value);
+			if (ret)
+				goto exit;
+
+			line = strstr(line, "\n") + 1;
+		}
+	}
+
+exit:
+
+	return ret;
+}
+
+int cl_chip_config_read(struct cl_chip *chip)
+{
+	char *buf = NULL;
+	loff_t size = 0;
+	int ret = 0;
+	char filename[CL_FILENAME_MAX] = {0};
+
+	/* Allocate cl_chip_conf */
+	chip->conf = kzalloc(sizeof(*chip->conf), GFP_KERNEL);
+	if (!chip->conf)
+		return -ENOMEM;
+
+	/* Copy default parameters */
+	memcpy(chip->conf, &chip_conf, sizeof(*chip->conf));
+
+	snprintf(filename, sizeof(filename), "cl_chip%u.dat", chip->idx);
+	pr_debug("%s: %s\n", __func__, filename);
+	size = cl_file_open_and_read(chip, filename, &buf);
+
+	if (!buf) {
+		pr_err("read %s failed !!!\n", filename);
+		return -ENODATA;
+	}
+
+	ret = cl_chip_set_all_params_from_buf(chip, buf, size);
+	if (ret) {
+		kfree(buf);
+		return ret;
+	}
+
+	kfree(buf);
+
+	if (!cl_chip_is_enabled(chip)) {
+		cl_dbg_chip_verbose(chip, "Disabled\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = cl_chip_post_configuration(chip);
+
+	return ret;
+}
+
+void cl_chip_config_dealloc(struct cl_chip *chip)
+{
+	kfree(chip->conf);
+}
-- 
2.36.1

