Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF67E53292F
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbiEXLhy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236765AbiEXLhx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:37:53 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A7C50440
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:37:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWb1HP9cWdqeKVdp4Yyj+ztXk7OqholIx11fpios0ZATVIxmm/dZH6ndmWZ24jLitf51uOaTEizbahUyGT6PnuyLxyR17Q5eA01a3k8U3NBsTWnrbGAkWPAYrStEBiRQMJNr6AJlMh+dzb7w63N0eX/RGcP6yKbAtowrpsO444kipFoT3arvDbX0fSI1eQtGQT1nfWKN5aVIgW9YYo6nicRMa3xVVXhwEOQHtcGfKmAb01TUc7iu1K9+axhpZajbabdP9HYqvAxKnYZ2fw2RW59TqF5ksmT+HE2pc/E+ARRCDOsoD4ND5DWPlUyvhTgcBPpd+BLNmJb+fl2VY7rbaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qzv2jPsnGYTcfr/HotGEQgGPAUtEydE8OCifMXELhRo=;
 b=R3VsxQrjCFdlzBSGgZImNs85xtLjxzznHkc7mjj64Q/J3ctPDpyqH42C+3OIv1scRriTq2qQ2ZizunVWBE0PpiGmekBkWOqEguAZnjRz7P2QJ3y2c09l8yQYRDyM3dmp14ml7/hWWdapn13cKu3yuFJPvib9oE1ZjNozYF8vrKJq11NB2PJ1MB0dnDiqMJdstW/H6RG3o0sYMXYRZ9pytwbyDdZydiqpExRMMK6PeLtE0KqCTHydYpHIZ7YXs2Xs/mJHWyHZsBudSygvnuPblkq7Pfl9xmeAmdYNSXX8qbEhLu9eyQnL8lHwcC+uLEyXb4H06CYIKoeZ80Ns+baIhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qzv2jPsnGYTcfr/HotGEQgGPAUtEydE8OCifMXELhRo=;
 b=Rb4HXqrvF1eF1zVtbJgAdipRRSmjoJrKwle1q+fsMqPNAcBm+8hS4f0s565cfPHT1+F7AwsCj09Nll15RjMmx4jQXeubvvPPLl88hdi8HETJ1H3CRFlznW2aMSNb8ptAR7NS3WxVtE73t/72O506JrrGtac/xynorDs6lMcVqGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0305.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 11:37:43 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:37:42 +0000
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
Subject: [RFC v2 09/96] cl8k: add calib.c
Date:   Tue, 24 May 2022 14:33:35 +0300
Message-Id: <20220524113502.1094459-10-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 33932f94-65a8-4498-a0a6-08da3d79d030
X-MS-TrafficTypeDiagnostic: AM0P192MB0305:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM0P192MB0305497D3DD0E400ED953A1DF6D79@AM0P192MB0305.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oGi6FNcJqR3HhOL7APO14hdCjxgmw3buh9z9ZtC634x3/pzhGfp76XZMKKYQHdKpvTAal7fgbf4gRjwlH6uxOHtWd0/zdURl0lfhaKHA+lcLeiIDoyK3YzuNpZ1IRqYAS9LIpq68C8HpZc3yspbYy5F2sljxZPkwUXh8RLsTF1itCJc+XRv2TMoMS1RgHv3ZemIopFBhXpnqIFGXxngp0tO/MQ6kp7ge0NigxEcjk3WEknN93lITHXU58u0NaStPCAhJG96i6/FohxTxX3n5dLjAbWTmvAv33bxDEMIh2Z//gwQxMQTD1AIRkwr4d9mIYf54uJBJOiympU2P5uSb3SV9NBKRAAXv5VDrznosJscoGGVnGrhuLSHuTLBhGwZAP0g16/S6w2krzZUO5XIUl224e8+AopFY+faeVOoDDOluV+b0oCEvrnQEYG5UzfP362vOQQpvO7ge+nWUz1ev6xfLAdiA5vKchMaiOrWyLuvdpov9IgwreHWCOjo/COAyCoq7nJ+qLSC+CIX5M+1iF0UuPR3ewGk0uarCg2TrXZGKzGPio0nOxEUCfjbnS6NusoFdghnRdq8leKvFlpj28oFT2naAyr6c/4We8+aPeTIPe6QMZ95lTpRSX+meRMpvyeJfCWo1WE3WUrzqlwsb1sy+IJQiv2paQ5aTmynFyONDXoH2kYi8Po9QJ4aSOUB2YOkyEm5plfWyXaeV2+D13n2jTyFyaj11FMWhmsNF/krV00K4K+U1fGnm9HBzAPgs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(346002)(396003)(366004)(39850400004)(376002)(136003)(6486002)(6916009)(508600001)(38350700002)(38100700002)(52116002)(6666004)(2906002)(8936002)(54906003)(6512007)(6506007)(26005)(9686003)(30864003)(8676002)(36756003)(5660300002)(316002)(66476007)(4326008)(66556008)(107886003)(66946007)(1076003)(41300700001)(186003)(2616005)(83380400001)(86362001)(32563001)(579004)(559001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oDC0Q6m1I4eYXdrkfqHkjY/fbZdKk4e6y+EYiMRQ89zBdGm0uEe3urVh/dH4?=
 =?us-ascii?Q?qwBESu0gkcxLPRidaTH11KTaeMPcPXjg3GFc+HriKCjIhcx3/lX9glved0Gx?=
 =?us-ascii?Q?ef01nR15w1gxW3727as8IP/ROvMLQnMb1zPAKxBTu0QDvrGVhQFPrLsYdSEg?=
 =?us-ascii?Q?grciVAzc8TA0LAxQVUrcXamXU+V5CW7JXEMO9DA3g5wS36lqZi4KEe4OtpM3?=
 =?us-ascii?Q?xXbmeG6uzwhSai+Kt3utmM/iRCvbuZHZ2MDyrE97YvNfdD8LxR2tzacJbuua?=
 =?us-ascii?Q?+Y5LU9pr5Poo0wuimSGJX5hVlf5Ig33N65FFc3T5sMoGMonXDz0rn/p3+Ptz?=
 =?us-ascii?Q?RG9sP8SiSVv50RPu2F/bTnSEn9GnT2QewIPxfTZXnzXTeUG7thzjHKZw7r+4?=
 =?us-ascii?Q?xv5IIJIrST/tK6lwxdKpVtieov2m8yoMwJ/AYFRvW2s6MRK/p8yVJlNPZGIf?=
 =?us-ascii?Q?DAuoKxuG85+aco4fcovLueQgoPKtQZ/bNy7a68vuHpecZirv/SnO9+H2lH45?=
 =?us-ascii?Q?KLwgEikTURybta70hoUEe+DLDYk99Z/ra1jlRCrZJghS7Fw8dikwlVcTcIdR?=
 =?us-ascii?Q?Awd03jBQ9e5EGuMIaWa3kPUEHE0E4CQYVKNpG+uCD2x+p6zbgZ5tEEXjeUn9?=
 =?us-ascii?Q?Nyk9aqgC/5poq+AG9HG7ar/2J+XtRD5rp4UirIe+lXgRi4mhaWaL/V3FOwkv?=
 =?us-ascii?Q?IYMmJyDySAzo63Rgt9XqZ/NISa+48Ui41RBv99p+d34cBwmidJ7VOidNuuyK?=
 =?us-ascii?Q?LQixHWV2zrZWuOI0GBnx0JEBStTuJa5x+BNQYrZDF1rw48Db6AHIV14AbZTN?=
 =?us-ascii?Q?36+VJ3l3KIDg+M3Q8wcvGtfMI3Tzkv/sJtFQzqBFbFvw0pCG0jE1bnFrl7KQ?=
 =?us-ascii?Q?eO7EkMmn+wD1M0PGD005WTCdpOWbU+JZBsWr7OCHJZV026DHJ/wWC8TwlR79?=
 =?us-ascii?Q?eHIrK+Uu7cg2YYOQhuvEmwhTPeQNeB+GxKWbJvhPzTO2Xbn71PdNtSOfW24U?=
 =?us-ascii?Q?NYVk8vFZXrkLOStY7p7WvEdEYhzvzuq0RjCxzzIz4vm1mCy3XL+YwYxI5EjH?=
 =?us-ascii?Q?Y2eD58h1mHsB9fSy1zPeKEgdo7RRga6d9MBMXYe2Q3duG5W1xa/XiWAxOUlM?=
 =?us-ascii?Q?ZCApGk/0zklLzLm1arwQBzBGduMIh8SucfMKZnmreL/aU0NxMJiRIvvDY9iU?=
 =?us-ascii?Q?xlSavdz1qqtnpYRy6k1oTnnvBM/d8bMBsarXsLjt91IDNRMgLUsci6JGQHKI?=
 =?us-ascii?Q?y1H8Cams59s+GV4SQXUUC5jkFvDsBmLdvLv7nH8eCYFBF5Zq9MLgGIxN5PFV?=
 =?us-ascii?Q?N/UYBozHga2KSnQ8ejKvLNlQciTkEAbm/bKLkO7T0DshdtSpyi0WDjcvXZa2?=
 =?us-ascii?Q?bfGjUSGqKYQ0Q4z18gVdE0sysf7ku0v685LK035euT7kMdXBCbC3BZ8j5K3S?=
 =?us-ascii?Q?+mbHUWYYJweIFluyRdjJ0UPr2ZomN13U+SuKKHojQ1fkspOaV8xI5KArwHbf?=
 =?us-ascii?Q?imWoJoFGgrdU61kBBtPP3i0RPyUnW27oUmEBmynbp56XO+qI3WjSzNUWt0yb?=
 =?us-ascii?Q?TGU3udtFsaWqcexgvTrkwBnByk5UBUy8mL3dQBPDETbCSg8pKuQCH45P1ZcG?=
 =?us-ascii?Q?PoYppSY9I6I/fOx4MBbVRTyrVr26pHFyVtMBMOKXhPtWF2IwmX1RHmbG9DfJ?=
 =?us-ascii?Q?bHSnjUy8g3Ty0p4vv0U5n8c9AnTg5IJqGZ0TMXHyIPn5VtxLTBRQeo1lqHBI?=
 =?us-ascii?Q?xZSNbDW9K8vpUu9D99w6T/s7nEJLPNg=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33932f94-65a8-4498-a0a6-08da3d79d030
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:37:42.1874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44y7XGjEJGs85OUsGZW4+iXtObur3FXcNV6hgAqoxnLTo8l97ZMRKLt+WndOf6yXr8r5hh4fK6D/1cU6ziVajA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0305
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
 drivers/net/wireless/celeno/cl8k/calib.c | 2266 ++++++++++++++++++++++
 1 file changed, 2266 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/calib.c

diff --git a/drivers/net/wireless/celeno/cl8k/calib.c b/drivers/net/wireless/celeno/cl8k/calib.c
new file mode 100644
index 000000000000..93fe6a2e00ee
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/calib.c
@@ -0,0 +1,2266 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include <linux/dcache.h>
+
+#include "reg/reg_defs.h"
+#include "chip.h"
+#include "config.h"
+#include "radio.h"
+#include "e2p.h"
+#include "rfic.h"
+#include "debug.h"
+#include "utils.h"
+#include "calib.h"
+
+static void cl_calib_common_init_cfm(struct cl_iq_dcoc_data *iq_dcoc_data)
+{
+	int i;
+
+	for (i = 0; i < CALIB_CFM_MAX; i++)
+		iq_dcoc_data->dcoc_iq_cfm[i].status = CALIB_FAIL;
+}
+
+void cl_calib_common_fill_phy_data(struct cl_hw *cl_hw, struct cl_iq_dcoc_info *iq_dcoc_db,
+				   u8 flags)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	u8 bw = cl_hw->bw;
+	u8 channel_idx = cl_calib_dcoc_channel_bw_to_idx(cl_hw, cl_hw->channel, bw);
+	u8 tcv_idx = cl_hw->tcv_idx;
+	u8 sx = cl_hw->sx_idx;
+
+	if (flags & SET_PHY_DATA_FLAGS_DCOC)
+		cl_calib_dcoc_fill_data(cl_hw, iq_dcoc_db);
+
+	if (flags & SET_PHY_DATA_FLAGS_IQ_TX_LOLC)
+		cl_calib_iq_lolc_fill_data(cl_hw, iq_dcoc_db->iq_tx_lolc);
+
+	if (flags & SET_PHY_DATA_FLAGS_IQ_TX)
+		cl_calib_iq_fill_data(cl_hw, iq_dcoc_db->iq_tx,
+				      chip->calib_db.iq_tx[tcv_idx][channel_idx][bw][sx]);
+
+	if (flags & SET_PHY_DATA_FLAGS_IQ_RX)
+		cl_calib_iq_fill_data(cl_hw, iq_dcoc_db->iq_rx,
+				      chip->calib_db.iq_rx[tcv_idx][channel_idx][bw][sx]);
+}
+
+int cl_calib_common_tables_alloc(struct cl_hw *cl_hw)
+{
+	struct cl_iq_dcoc_data *buf = NULL;
+	u32 len = sizeof(struct cl_iq_dcoc_data);
+	dma_addr_t phys_dma_addr;
+
+	buf = dma_alloc_coherent(cl_hw->chip->dev, len, &phys_dma_addr, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	cl_hw->iq_dcoc_data_info.iq_dcoc_data = buf;
+	cl_hw->iq_dcoc_data_info.dma_addr = phys_dma_addr;
+
+	cl_calib_common_init_cfm(cl_hw->iq_dcoc_data_info.iq_dcoc_data);
+	return 0;
+}
+
+void cl_calib_common_tables_free(struct cl_hw *cl_hw)
+{
+	struct cl_iq_dcoc_data_info *iq_dcoc_data_info = &cl_hw->iq_dcoc_data_info;
+	u32 len = sizeof(struct cl_iq_dcoc_data);
+	dma_addr_t phys_dma_addr = iq_dcoc_data_info->dma_addr;
+
+	if (!iq_dcoc_data_info->iq_dcoc_data)
+		return;
+
+	dma_free_coherent(cl_hw->chip->dev, len, (void *)iq_dcoc_data_info->iq_dcoc_data,
+			  phys_dma_addr);
+	iq_dcoc_data_info->iq_dcoc_data = NULL;
+}
+
+static void _cl_calib_common_start_work(struct work_struct *ws)
+{
+	struct cl_calib_work *calib_work = container_of(ws, struct cl_calib_work, ws);
+	struct cl_hw *cl_hw = calib_work->cl_hw;
+	struct cl_hw *cl_hw_other = cl_hw_other_tcv(cl_hw);
+	struct cl_chip *chip = cl_hw->chip;
+
+	cl_calib_iq_init_calibration(cl_hw);
+
+	if (cl_chip_is_both_enabled(chip))
+		cl_calib_iq_init_calibration(cl_hw_other);
+
+	/* Start cl_radio_on after calibration ends */
+	cl_radio_on_start(cl_hw);
+
+	if (cl_chip_is_both_enabled(chip))
+		cl_radio_on_start(cl_hw_other);
+
+	kfree(calib_work);
+}
+
+void cl_calib_common_start_work(struct cl_hw *cl_hw)
+{
+	struct cl_calib_work *calib_work = kzalloc(sizeof(*calib_work), GFP_ATOMIC);
+
+	if (!calib_work)
+		return;
+
+	calib_work->cl_hw = cl_hw;
+	INIT_WORK(&calib_work->ws, _cl_calib_common_start_work);
+	queue_work(cl_hw->drv_workqueue, &calib_work->ws);
+}
+
+s16 cl_calib_common_get_temperature(struct cl_hw *cl_hw, u8 cfm_type)
+{
+	struct calib_cfm *dcoc_iq_cfm =
+		&cl_hw->iq_dcoc_data_info.iq_dcoc_data->dcoc_iq_cfm[cfm_type];
+	u16 raw_bits = (le16_to_cpu(dcoc_iq_cfm->raw_bits_data_0) +
+		le16_to_cpu(dcoc_iq_cfm->raw_bits_data_1)) / 2;
+
+	return cl_temperature_calib_calc(cl_hw, raw_bits);
+}
+
+#ifdef CONFIG_CL8K_EEPROM_STM24256
+static u16 cl_calib_common_eeprom_get_idx(struct cl_hw *cl_hw, int bw_idx, u16 channel,
+					  u16 channels_plan[], u8 num_of_channels)
+{
+	int i;
+
+	for (i = 0; i < num_of_channels; i++)
+		if (channels_plan[i] == channel)
+			return i;
+
+	return U16_MAX;
+}
+
+static u16 cl_calib_common_eeprom_get_addr(struct cl_hw *cl_hw, int bw_idx, u16 channel)
+{
+	int idx = 0;
+	u16 addr = 0;
+	u16 *channels;
+	u8 num_of_channels;
+
+	switch (bw_idx) {
+	case CHNL_BW_20:
+		channels = cl_hw->conf->ci_calib_eeprom_channels_20mhz;
+
+		if (cl_hw_is_tcv0(cl_hw)) {
+			num_of_channels = EEPROM_CALIB_DATA_ELEM_NUM_20MHZ_TCV0;
+			idx = cl_calib_common_eeprom_get_idx(cl_hw, bw_idx, channel, channels,
+							     num_of_channels);
+			addr = ADDR_CALIB_IQ_DCOC_DATA_20MHZ_TCV0;
+		} else {
+			num_of_channels = EEPROM_CALIB_DATA_ELEM_NUM_20MHZ_TCV1;
+			idx = cl_calib_common_eeprom_get_idx(cl_hw, bw_idx, channel, channels,
+							     num_of_channels);
+			addr = ADDR_CALIB_IQ_DCOC_DATA_20MHZ_TCV1;
+		}
+		break;
+	case CHNL_BW_40:
+		channels = cl_hw->conf->ci_calib_eeprom_channels_40mhz;
+
+		if (cl_hw_is_tcv0(cl_hw)) {
+			num_of_channels = EEPROM_CALIB_DATA_ELEM_NUM_40MHZ_TCV0;
+			idx = cl_calib_common_eeprom_get_idx(cl_hw, bw_idx, channel, channels,
+							     num_of_channels);
+			addr = ADDR_CALIB_IQ_DCOC_DATA_40MHZ_TCV0;
+		} else {
+			num_of_channels = EEPROM_CALIB_DATA_ELEM_NUM_40MHZ_TCV1;
+			idx = cl_calib_common_eeprom_get_idx(cl_hw, bw_idx, channel, channels,
+							     num_of_channels);
+			addr = ADDR_CALIB_IQ_DCOC_DATA_40MHZ_TCV1;
+		}
+		break;
+	case CHNL_BW_80:
+		channels = cl_hw->conf->ci_calib_eeprom_channels_80mhz;
+
+		if (cl_hw_is_tcv0(cl_hw)) {
+			num_of_channels = EEPROM_CALIB_DATA_ELEM_NUM_80MHZ_TCV0;
+			idx = cl_calib_common_eeprom_get_idx(cl_hw, bw_idx, channel, channels,
+							     num_of_channels);
+			addr = ADDR_CALIB_IQ_DCOC_DATA_80MHZ_TCV0;
+		} else {
+			num_of_channels = EEPROM_CALIB_DATA_ELEM_NUM_80MHZ_TCV1;
+			idx = cl_calib_common_eeprom_get_idx(cl_hw, bw_idx, channel, channels,
+							     num_of_channels);
+			addr = ADDR_CALIB_IQ_DCOC_DATA_80MHZ_TCV1;
+		}
+		break;
+	case CHNL_BW_160:
+		channels = cl_hw->conf->ci_calib_eeprom_channels_80mhz;
+
+		if (cl_hw_is_tcv0(cl_hw)) {
+			num_of_channels = EEPROM_CALIB_DATA_ELEM_NUM_80MHZ_TCV0;
+			idx = cl_calib_common_eeprom_get_idx(cl_hw, bw_idx, channel, channels,
+							     num_of_channels);
+			addr = ADDR_CALIB_IQ_DCOC_DATA_80MHZ_TCV0;
+		} else {
+			num_of_channels = EEPROM_CALIB_DATA_ELEM_NUM_80MHZ_TCV1;
+			idx = cl_calib_common_eeprom_get_idx(cl_hw, bw_idx, channel, channels,
+							     num_of_channels);
+			addr = ADDR_CALIB_IQ_DCOC_DATA_80MHZ_TCV1;
+		}
+		break;
+	default:
+		return U16_MAX;
+	}
+
+	if (idx == U16_MAX)
+		return U16_MAX;
+
+	return ((u16)addr + (u16)(idx * sizeof(struct eeprom_calib_data)));
+}
+
+static void cl_calib_common_write_lolc_to_eeprom(struct cl_calib_db *calib_db,
+						 struct eeprom_calib_data *calib_data,
+						 u8 ch_idx, u8 bw, u8 sx_idx, u8 tcv_idx)
+{
+	memcpy(calib_data->lolc,
+	       calib_db->iq_tx_lolc[tcv_idx][ch_idx][bw][sx_idx],
+	       sizeof(u32) * MAX_ANTENNAS);
+}
+
+static void cl_calib_common_write_dcoc_to_eeprom(struct cl_calib_db *calib_db,
+						 struct eeprom_calib_data *calib_data,
+						 u8 ch_idx, u8 bw, u8 sx_idx, u8 tcv_idx)
+{
+	memcpy(calib_data->dcoc,
+	       calib_db->dcoc[tcv_idx][ch_idx][bw][sx_idx],
+	       sizeof(struct cl_dcoc_calib) * MAX_ANTENNAS * DCOC_LNA_GAIN_NUM);
+}
+
+static void cl_calib_common_write_iq_to_eeprom(struct cl_calib_db *calib_db,
+					       struct eeprom_calib_data *calib_data,
+					       u8 ch_idx, u8 bw, u8 sx_idx, u8 tcv_idx)
+{
+	memcpy(calib_data->iq_tx,
+	       calib_db->iq_tx[tcv_idx][ch_idx][bw][sx_idx],
+	       sizeof(struct cl_iq_calib) * MAX_ANTENNAS);
+	memcpy(calib_data->iq_rx,
+	       calib_db->iq_rx[tcv_idx][ch_idx][bw][sx_idx],
+	       sizeof(struct cl_iq_calib) * MAX_ANTENNAS);
+}
+
+static s8 cl_calib_common_find_worst_iq_tone(struct cl_iq_report iq_report_dma)
+{
+	u8 tone = 0;
+	s8 worst_tone = S8_MIN;
+
+	for (tone = 0; tone < IQ_NUM_TONES_CFM; tone++)
+		if (worst_tone < iq_report_dma.ir_db[IQ_POST_IDX][tone])
+			worst_tone = iq_report_dma.ir_db[IQ_POST_IDX][tone];
+
+	return worst_tone;
+}
+
+static void cl_calib_common_write_score_dcoc(struct cl_hw *cl_hw,
+					     struct eeprom_calib_data *calib_data)
+{
+	u8 lna, ant;
+
+	for (lna = 0; lna < DCOC_LNA_GAIN_NUM; lna++) {
+		for (ant = 0; ant < MAX_ANTENNAS; ant++) {
+			struct cl_dcoc_report *dcoc_calib_report =
+				&cl_hw->iq_dcoc_data_info.iq_dcoc_data->report.dcoc[lna][ant];
+
+			calib_data->score[ant].dcoc_i_mv[lna] =
+				(s16)le16_to_cpu(dcoc_calib_report->i_dc);
+			calib_data->score[ant].dcoc_q_mv[lna] =
+				(s16)le16_to_cpu(dcoc_calib_report->q_dc);
+		}
+	}
+}
+
+static void cl_calib_common_write_score_lolc(struct cl_hw *cl_hw,
+					     struct eeprom_calib_data *calib_data)
+{
+	u8 ant;
+	struct cl_iq_dcoc_report *report = &cl_hw->iq_dcoc_data_info.iq_dcoc_data->report;
+
+	for (ant = 0; ant < MAX_ANTENNAS; ant++) {
+		calib_data->score[ant].lolc_score =
+			(s16)(le16_to_cpu(report->lolc_report[ant].lolc_qual)) >> 8;
+	}
+}
+
+static void cl_calib_common_write_score_iq(struct cl_hw *cl_hw,
+					   struct eeprom_calib_data *calib_data)
+{
+	u8 ant;
+
+	for (ant = 0; ant < MAX_ANTENNAS; ant++) {
+		struct cl_iq_report iq_report_dma_tx =
+			cl_hw->iq_dcoc_data_info.iq_dcoc_data->report.iq_tx[ant];
+		struct cl_iq_report iq_report_dma_rx =
+			cl_hw->iq_dcoc_data_info.iq_dcoc_data->report.iq_rx[ant];
+
+		calib_data->score[ant].iq_tx_score = iq_report_dma_tx.ir_db_avg_post;
+		calib_data->score[ant].iq_rx_score = iq_report_dma_rx.ir_db_avg_post;
+		calib_data->score[ant].iq_tx_worst_score =
+			cl_calib_common_find_worst_iq_tone(iq_report_dma_tx);
+		calib_data->score[ant].iq_rx_worst_score =
+			cl_calib_common_find_worst_iq_tone(iq_report_dma_rx);
+	}
+}
+
+static void cl_calib_common_write_score_to_eeprom(struct cl_hw *cl_hw,
+						  struct eeprom_calib_data *calib_data)
+{
+	cl_calib_common_write_score_dcoc(cl_hw, calib_data);
+	cl_calib_common_write_score_lolc(cl_hw, calib_data);
+	cl_calib_common_write_score_iq(cl_hw, calib_data);
+}
+
+static void cl_calib_common_write_eeprom(struct cl_hw *cl_hw, u32 channel, u8 bw, u8 sx_idx,
+					 u8 tcv_idx)
+{
+	u8 ch_idx = cl_calib_dcoc_channel_bw_to_idx(cl_hw, channel, bw);
+	u16 eeprom_addr = cl_calib_common_eeprom_get_addr(cl_hw, bw, channel);
+	struct eeprom_calib_data calib_data;
+	struct cl_calib_db *calib_db = &cl_hw->chip->calib_db;
+
+	if (eeprom_addr == U16_MAX)
+		return;
+
+	calib_data.valid = true;
+	calib_data.temperature = cl_calib_common_get_temperature(cl_hw, CALIB_CFM_IQ);
+	cl_calib_common_write_lolc_to_eeprom(calib_db, &calib_data, ch_idx, bw, sx_idx, tcv_idx);
+	cl_calib_common_write_dcoc_to_eeprom(calib_db, &calib_data, ch_idx, bw, sx_idx, tcv_idx);
+	cl_calib_common_write_iq_to_eeprom(calib_db, &calib_data, ch_idx, bw, sx_idx, tcv_idx);
+	cl_calib_common_write_score_to_eeprom(cl_hw, &calib_data);
+
+	cl_e2p_write(cl_hw->chip, (u8 *)&calib_data, (u16)sizeof(struct eeprom_calib_data),
+		     eeprom_addr);
+}
+
+static bool cl_calib_common_is_channel_included_in_eeprom_bitmap(struct cl_hw *cl_hw)
+{
+	u16 i;
+	u16 *eeprom_valid_ch = NULL;
+	u16 num_of_channels;
+
+	switch (cl_hw->bw) {
+	case CHNL_BW_20:
+		eeprom_valid_ch = cl_hw->conf->ci_calib_eeprom_channels_20mhz;
+
+		if (cl_hw_is_tcv0(cl_hw))
+			num_of_channels = EEPROM_CALIB_DATA_ELEM_NUM_20MHZ_TCV0;
+		else
+			num_of_channels = EEPROM_CALIB_DATA_ELEM_NUM_20MHZ_TCV1;
+		break;
+	case CHNL_BW_40:
+		eeprom_valid_ch = cl_hw->conf->ci_calib_eeprom_channels_40mhz;
+
+		if (cl_hw_is_tcv0(cl_hw))
+			num_of_channels = EEPROM_CALIB_DATA_ELEM_NUM_20MHZ_TCV0;
+		else
+			num_of_channels = EEPROM_CALIB_DATA_ELEM_NUM_20MHZ_TCV1;
+		break;
+	case CHNL_BW_80:
+		eeprom_valid_ch = cl_hw->conf->ci_calib_eeprom_channels_80mhz;
+
+		if (cl_hw_is_tcv0(cl_hw))
+			num_of_channels = EEPROM_CALIB_DATA_ELEM_NUM_20MHZ_TCV0;
+		else
+			num_of_channels = EEPROM_CALIB_DATA_ELEM_NUM_20MHZ_TCV1;
+		break;
+	case CHNL_BW_160:
+		eeprom_valid_ch = cl_hw->conf->ci_calib_eeprom_channels_160mhz;
+
+		if (cl_hw_is_tcv0(cl_hw))
+			num_of_channels = EEPROM_CALIB_DATA_ELEM_NUM_20MHZ_TCV0;
+		else
+			num_of_channels = EEPROM_CALIB_DATA_ELEM_NUM_20MHZ_TCV1;
+		break;
+	default:
+		return false;
+	}
+	for (i = 0; i < num_of_channels; i++)
+		if (cl_hw->channel == eeprom_valid_ch[i])
+			return true;
+
+	return false;
+}
+#endif /* CONFIG_CL8K_EEPROM_STM24256 */
+
+int cl_calib_common_handle_set_channel_cfm(struct cl_hw *cl_hw, struct cl_calib_params calib_params)
+{
+	struct cl_iq_dcoc_data *iq_dcoc_data = cl_hw->iq_dcoc_data_info.iq_dcoc_data;
+	u8 mode = calib_params.mode;
+
+	cl_dbg_trace(cl_hw, "\n ------  FINISH CALIB CHANNEL  -----\n");
+
+	/*
+	 * In case any of the requested calibrations failed - no need to copy
+	 * the other Calibration data, and fail the whole calibration process.
+	 */
+	if ((mode & SET_CHANNEL_MODE_CALIB_DCOC &&
+	     iq_dcoc_data->dcoc_iq_cfm[CALIB_CFM_DCOC].status != CALIB_SUCCESS) ||
+	    (mode & SET_CHANNEL_MODE_CALIB_IQ &&
+	     iq_dcoc_data->dcoc_iq_cfm[CALIB_CFM_IQ].status != CALIB_SUCCESS)) {
+		cl_dbg_err(cl_hw, "Calibration failed! mode = %u, DCOC_CFM_STATUS = %u, "
+			   "IQ_CFM_STATUS = %u\n", mode,
+			   iq_dcoc_data->dcoc_iq_cfm[CALIB_CFM_DCOC].status,
+			   iq_dcoc_data->dcoc_iq_cfm[CALIB_CFM_IQ].status);
+		/* Set status to CALIB_FAIL to ensure that FW is writing the values. */
+		iq_dcoc_data->dcoc_iq_cfm[CALIB_CFM_DCOC].status = CALIB_FAIL;
+		iq_dcoc_data->dcoc_iq_cfm[CALIB_CFM_IQ].status = CALIB_FAIL;
+		return -EINVAL;
+	}
+
+	cl_dbg_trace(cl_hw, "mode = %u\n", mode);
+
+	if (mode & SET_CHANNEL_MODE_CALIB_DCOC)
+		cl_calib_dcoc_handle_set_channel_cfm(cl_hw, calib_params.first_channel);
+
+	if (mode & SET_CHANNEL_MODE_CALIB_IQ)
+		cl_calib_iq_handle_set_channel_cfm(cl_hw, calib_params.plan_bitmap);
+
+	if (mode & SET_CHANNEL_MODE_CALIB_LOLC)
+		cl_calib_iq_lolc_handle_set_channel_cfm(cl_hw, calib_params.plan_bitmap);
+
+#ifdef CONFIG_CL8K_EEPROM_STM24256
+	if (cl_hw->chip->conf->ci_calib_eeprom_en && cl_hw->chip->conf->ce_production_mode &&
+	    cl_hw->chip->is_calib_eeprom_loaded && cl_hw->chip->conf->ce_calib_runtime_en)
+		if (cl_calib_common_is_channel_included_in_eeprom_bitmap(cl_hw))
+			cl_calib_common_write_eeprom(cl_hw, cl_hw->channel, cl_hw->bw,
+						     cl_hw->sx_idx, cl_hw->tcv_idx);
+#endif
+
+	return 0;
+}
+
+int cl_calib_common_check_errors(struct cl_hw *cl_hw)
+{
+	u8 tcv_idx = cl_hw->tcv_idx;
+	u16 dcoc_erros = cl_hw->chip->calib_db.errors[tcv_idx].dcoc;
+	u16 lolc_erros = cl_hw->chip->calib_db.errors[tcv_idx].lolc;
+	u16 iq_tx_erros = cl_hw->chip->calib_db.errors[tcv_idx].iq_tx;
+	u16 iq_rx_erros = cl_hw->chip->calib_db.errors[tcv_idx].iq_rx;
+
+	if (!cl_hw->chip->conf->ci_calib_check_errors)
+		return 0;
+
+	if (dcoc_erros > 0 || lolc_erros > 0 || iq_tx_erros > 0 || iq_rx_erros > 0) {
+		CL_DBG_ERROR(cl_hw, "Abort: dcoc_erros %u, lolc_erros %u,"
+			     " iq_tx_erros %u, iq_rx_erros %u\n",
+			     dcoc_erros, lolc_erros, iq_tx_erros, iq_rx_erros);
+		return -ECANCELED;
+	}
+
+	return 0;
+}
+
+static const u8 calib_channels_24g[CALIB_CHAN_24G_MAX] = {
+	1, 6, 11
+};
+
+static const u8 calib_channels_5g_plan[CALIB_CHAN_5G_PLAN] = {
+	36, 52, 100, 116, 132, 149
+};
+
+static const u8 calib_channels_6g_plan[CALIB_CHAN_6G_PLAN] = {
+	1, 17, 33, 49, 65, 81, 97, 113, 129, 145, 161, 177, 193, 209, 225
+};
+
+static const u8 calib_channels_5g_bw_20[] = {
+	36, 40, 44, 48, 52, 56, 60, 64, 100, 104, 108, 112, 116, 120, 124, 128, 132, 136, 140, 144,
+	149, 153, 157, 161, 165
+};
+
+static const u8 calib_channels_5g_bw_40[] = {
+	36, 44, 52, 60, 100, 108, 116, 124, 132, 140, 149, 157
+};
+
+static const u8 calib_channels_5g_bw_80[] = {
+	36, 52, 100, 116, 132, 149
+};
+
+static const u8 calib_channels_5g_bw_160[] = {
+	36, 100
+};
+
+static const u8 calib_channels_6g_bw_20[] = {
+	1, 5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61, 65, 69, 73, 77, 81, 85, 89, 93,
+	97, 101, 105, 109, 113, 117, 121, 125, 129, 133, 137, 141, 145, 149, 153, 157, 161, 165,
+	169, 173, 177, 181, 185, 189, 193, 197, 201, 205, 209, 213, 217, 221, 225, 229, 233
+};
+
+static const u8 calib_channels_6g_bw_40[] = {
+	1, 9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89, 97, 105, 113, 121, 129, 137, 145, 153, 161,
+	169, 177, 185, 193, 201, 209, 217, 225
+};
+
+static const u8 calib_channels_6g_bw_80[] = {
+	1, 17, 33, 49, 65, 81, 97, 113, 129, 145, 161, 177, 193, 209, 225
+};
+
+static const u8 calib_channels_6g_bw_160[] = {
+	1, 33, 65, 97, 129, 161, 193, 225
+};
+
+static void cl_calib_dcoc_handle_data(struct cl_hw *cl_hw, s16 calib_temperature, u8 channel, u8 bw)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	int lna, chain;
+	u8 tcv_idx = cl_hw->tcv_idx;
+	u8 sx = cl_hw->sx_idx;
+	u8 channel_idx = cl_calib_dcoc_channel_bw_to_idx(cl_hw, channel, bw);
+	struct cl_dcoc_calib *dcoc_calib;
+	struct cl_dcoc_calib *dcoc_calib_dma;
+
+	for (lna = 0; lna < DCOC_LNA_GAIN_NUM; lna++) {
+		riu_chain_for_each(chain) {
+			dcoc_calib =
+				&chip->calib_db.dcoc[tcv_idx][channel_idx][bw][sx][chain][lna];
+			dcoc_calib_dma =
+				&cl_hw->iq_dcoc_data_info.iq_dcoc_data->iq_dcoc_db.dcoc[lna][chain];
+			dcoc_calib->i = dcoc_calib_dma->i;
+			dcoc_calib->q = dcoc_calib_dma->q;
+		}
+	}
+}
+
+static void cl_calib_dcoc_handle_report(struct cl_hw *cl_hw, s16 calib_temperature,
+					int channel, u8 bw)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	int lna, chain;
+	struct cl_dcoc_report *dcoc_calib_report_dma;
+	int bw_mhz = BW_TO_MHZ(bw);
+	u8 dcoc_threshold = chip->conf->ci_dcoc_mv_thr[bw];
+	s16 i, q;
+
+	for (lna = 0; lna < DCOC_LNA_GAIN_NUM; lna++) {
+		riu_chain_for_each(chain) {
+			dcoc_calib_report_dma =
+				&cl_hw->iq_dcoc_data_info.iq_dcoc_data->report.dcoc[lna][chain];
+
+			i = (s16)le16_to_cpu(dcoc_calib_report_dma->i_dc);
+			q = (s16)le16_to_cpu(dcoc_calib_report_dma->q_dc);
+
+			if (abs(i) > dcoc_threshold || abs(q) > dcoc_threshold) {
+				cl_dbg_warn(cl_hw,
+					    "Warning: DCOC value exceeds threshold [%umV]: channel %u, bw = %u, lna = %u, chain = %u, I[mV] = %d, I[Iter] = %u, Q[mV] = %d, Q[Iter] = %u\n",
+					    dcoc_threshold, channel, bw_mhz, lna, chain, i,
+					    le16_to_cpu(dcoc_calib_report_dma->i_iterations), q,
+					    le16_to_cpu(dcoc_calib_report_dma->q_iterations));
+				chip->calib_db.errors[cl_hw->tcv_idx].dcoc++;
+			}
+		}
+	}
+}
+
+static int cl_calib_dcoc_calibrate_channel(struct cl_hw *cl_hw, u32 channel, u32 bw,
+					   bool first_channel)
+{
+	u32 primary = 0;
+	u32 center = 0;
+	enum nl80211_chan_width width = NL80211_CHAN_WIDTH_20;
+	struct cl_calib_params calib_params = {SET_CHANNEL_MODE_CALIB_DCOC, first_channel, 0, 0};
+
+	if (cl_chandef_calc(cl_hw, channel, bw, &width, &primary, &center)) {
+		cl_dbg_err(cl_hw, "cl_chandef_calc failed\n");
+		return -EINVAL;
+	}
+
+	cl_dbg_trace(cl_hw, "\n ------  START CALIB DCOC CHANNEL  -----\n");
+	cl_dbg_trace(cl_hw, "channel = %u first_channel = %u\n", channel, first_channel);
+
+	/* Set Channel Mode to DCOC Calibration Mode */
+	return cl_msg_tx_set_channel(cl_hw, channel, bw, primary, center, calib_params);
+}
+
+static void cl_calib_dcoc_average(struct cl_chip *chip, u8 tcv_idx, u8 center,
+				  u8 bw, u8 chain, u8 sx, u8 lna)
+{
+	struct cl_dcoc_calib *dcoc_db_left;
+	struct cl_dcoc_calib *dcoc_db_center;
+	struct cl_dcoc_calib *dcoc_db_right;
+	u8 left_idx = cl_calib_dcoc_tcv_channel_to_idx(chip, tcv_idx,
+						       calib_channels_6g_plan[center - 1], bw);
+	u8 center_idx = cl_calib_dcoc_tcv_channel_to_idx(chip, tcv_idx,
+							 calib_channels_6g_plan[center], bw);
+	u8 right_idx = cl_calib_dcoc_tcv_channel_to_idx(chip, tcv_idx,
+							calib_channels_6g_plan[center + 1], bw);
+
+	dcoc_db_left = &chip->calib_db.dcoc[tcv_idx][left_idx][bw][sx][chain][lna];
+	dcoc_db_center = &chip->calib_db.dcoc[tcv_idx][center_idx][bw][sx][chain][lna];
+	dcoc_db_right = &chip->calib_db.dcoc[tcv_idx][right_idx][bw][sx][chain][lna];
+
+	dcoc_db_center->i = (dcoc_db_left->i + dcoc_db_right->i) / 2;
+	dcoc_db_center->q = (dcoc_db_left->q + dcoc_db_right->q) / 2;
+}
+
+static int cl_calib_dcoc_calibrate_6g(struct cl_hw *cl_hw)
+{
+	int i;
+	u8 chain, lna;
+	u8 tcv_idx = cl_hw->tcv_idx;
+	u8 sx = tcv_idx;
+	bool first_channel = true;
+	struct cl_chip *chip = cl_hw->chip;
+
+	/* Calibrate channels: 1, 33, 65, 97, 129, 161, 193, 225 */
+	for (i = 0; i < CALIB_CHAN_6G_PLAN; i += 2) {
+		if (cl_hw->conf->ci_cap_bandwidth == CHNL_BW_160 &&
+		    (cl_calib_dcoc_calibrate_channel(cl_hw, calib_channels_6g_plan[i], CHNL_BW_160,
+						     first_channel) == 0))
+			first_channel = false;
+
+		if (cl_calib_dcoc_calibrate_channel(cl_hw, calib_channels_6g_plan[i], CHNL_BW_80,
+						    first_channel) == 0)
+			first_channel = false;
+
+		if (cl_calib_dcoc_calibrate_channel(cl_hw, calib_channels_6g_plan[i], CHNL_BW_20,
+						    first_channel) == 0)
+			first_channel = false;
+	}
+
+	/*
+	 * For these channels 17, 49, 81, 113, 145, 177, 209
+	 * calculate average of closest neighbors
+	 */
+	for (i = 1; i < CALIB_CHAN_6G_PLAN - 1; i += 2)
+		riu_chain_for_each(chain)
+			for (lna = 0; lna < DCOC_LNA_GAIN_NUM; lna++) {
+				cl_calib_dcoc_average(chip, tcv_idx, i, CHNL_BW_80,
+						      chain, sx, lna);
+				cl_calib_dcoc_average(chip, tcv_idx, i, CHNL_BW_20,
+						      chain, sx, lna);
+			}
+
+	return first_channel;
+}
+
+static int cl_calib_dcoc_calibrate_5g(struct cl_hw *cl_hw)
+{
+	int i;
+	bool first_channel = true;
+
+	if (cl_hw->conf->ci_cap_bandwidth == CHNL_BW_160) {
+		if (cl_calib_dcoc_calibrate_channel(cl_hw, 36, CHNL_BW_160, first_channel) == 0)
+			first_channel = false;
+
+		if (cl_calib_dcoc_calibrate_channel(cl_hw, 100, CHNL_BW_160, first_channel) == 0)
+			first_channel = false;
+	}
+
+	for (i = 0; i < CALIB_CHAN_5G_PLAN; i++) {
+		if (cl_calib_dcoc_calibrate_channel(cl_hw, calib_channels_5g_plan[i], CHNL_BW_80,
+						    first_channel) == 0)
+			first_channel = false;
+
+		if (cl_calib_dcoc_calibrate_channel(cl_hw, calib_channels_5g_plan[i], CHNL_BW_20,
+						    first_channel) == 0)
+			first_channel = false;
+	}
+
+	return first_channel;
+}
+
+static int cl_calib_dcoc_calibrate_24g(struct cl_hw *cl_hw)
+{
+	int i;
+	bool first_channel = true;
+
+	for (i = 0; i < CALIB_CHAN_24G_MAX; i++) {
+		if (cl_calib_dcoc_calibrate_channel(cl_hw, calib_channels_24g[i], CHNL_BW_40,
+						    first_channel) == 0)
+			first_channel = false;
+
+		if (cl_calib_dcoc_calibrate_channel(cl_hw, calib_channels_24g[i], CHNL_BW_20,
+						    first_channel) == 0)
+			first_channel = false;
+	}
+
+	return first_channel;
+}
+
+static void cl_calib_dcoc_calibrate(struct cl_hw *cl_hw)
+{
+	if (cl_band_is_6g(cl_hw))
+		cl_calib_dcoc_calibrate_6g(cl_hw);
+	else if (cl_band_is_5g(cl_hw))
+		cl_calib_dcoc_calibrate_5g(cl_hw);
+	else if (cl_band_is_24g(cl_hw))
+		cl_calib_dcoc_calibrate_24g(cl_hw);
+}
+
+void cl_calib_dcoc_init_calibration(struct cl_hw *cl_hw)
+{
+	u8 tcv_idx = cl_hw->tcv_idx;
+	struct cl_chip *chip = cl_hw->chip;
+	struct cl_iq_dcoc_conf *iq_dcoc_conf = &chip->iq_dcoc_conf;
+	u8 fem_mode = cl_hw->fem_mode;
+
+	/* No need to init calibration to non-Olympus phy */
+	if (!IS_REAL_PHY(chip))
+		return;
+	if (cl_hw_is_tcv0(cl_hw) && chip->conf->ci_tcv1_chains_sx0)
+		return;
+
+	if (!iq_dcoc_conf->dcoc_calib_needed[tcv_idx]) {
+		u8 file_num_antennas = iq_dcoc_conf->dcoc_file_num_ant[tcv_idx];
+
+		if (file_num_antennas < cl_hw->num_antennas) {
+			cl_dbg_verbose(cl_hw,
+				       "Num of antennas [%u], is larger than DCOC calibration file"
+				       " num of antennas [%u], recalibration is needed\n",
+				       cl_hw->num_antennas, file_num_antennas);
+		} else {
+			return;
+		}
+	}
+
+	/* Set FEM mode to LNA Bypass Only mode for DCOC Calibration. */
+	cl_fem_set_dcoc_bypass(cl_hw);
+	cl_afe_cfg_calib(chip);
+
+	cl_calib_dcoc_calibrate(cl_hw);
+
+	/* Restore FEM mode to its original mode. */
+	cl_fem_dcoc_restore(cl_hw, fem_mode);
+	cl_afe_cfg_restore(chip);
+
+	iq_dcoc_conf->dcoc_calib_needed[tcv_idx] = false;
+	iq_dcoc_conf->dcoc_file_num_ant[tcv_idx] = cl_hw->num_antennas;
+}
+
+static u8 cl_calib_dcoc_get_chan_idx(const u8 calib_chan_list[], u8 list_len, u8 channel)
+{
+	u8 i = 0;
+
+	for (i = 1; i < list_len; i++)
+		if (calib_chan_list[i] > channel)
+			return (i - 1);
+
+	return (list_len - 1);
+}
+
+static u8 cl_calib_dcoc_convert_to_channel_in_plan(u8 channel, u8 band)
+{
+	u8 idx;
+
+	if (band == BAND_6G) {
+		idx = cl_calib_dcoc_get_chan_idx(calib_channels_6g_plan,
+						 ARRAY_SIZE(calib_channels_6g_plan), channel);
+		return calib_channels_6g_plan[idx];
+	}
+
+	idx = cl_calib_dcoc_get_chan_idx(calib_channels_5g_plan,
+					 ARRAY_SIZE(calib_channels_5g_plan), channel);
+
+	return calib_channels_5g_plan[idx];
+}
+
+u8 cl_calib_dcoc_channel_bw_to_idx(struct cl_hw *cl_hw, u8 channel, u8 bw)
+{
+	if (cl_band_is_6g(cl_hw)) {
+		if (bw == CHNL_BW_160)
+			return cl_calib_dcoc_get_chan_idx(calib_channels_6g_bw_160,
+							  ARRAY_SIZE(calib_channels_6g_bw_160),
+							  channel);
+		/*
+		 * In case of non runtime calib - channels that don't exist in the plan list will
+		 * not be calibrated. Thus, the calib data need to be fetched from a close channel
+		 * that was calibrated - AKA "fallback channel".
+		 * In this case the channel value should convert to the "fallback channel" that had
+		 * been calibrated. The func will return the idx value of the "fallback channel"
+		 * instead of the original idx channel.
+		 */
+		if (!cl_hw->chip->conf->ce_calib_runtime_en)
+			channel = cl_calib_dcoc_convert_to_channel_in_plan(channel, BAND_6G);
+
+		if (bw == CHNL_BW_20)
+			return cl_calib_dcoc_get_chan_idx(calib_channels_6g_bw_20,
+							  ARRAY_SIZE(calib_channels_6g_bw_20),
+							  channel);
+
+		if (bw == CHNL_BW_40)
+			return cl_calib_dcoc_get_chan_idx(calib_channels_6g_bw_40,
+							  ARRAY_SIZE(calib_channels_6g_bw_40),
+							  channel);
+
+		if (bw == CHNL_BW_80)
+			return cl_calib_dcoc_get_chan_idx(calib_channels_6g_bw_80,
+							  ARRAY_SIZE(calib_channels_6g_bw_80),
+							  channel);
+	}
+
+	if (cl_band_is_5g(cl_hw)) {
+		if (bw == CHNL_BW_160)
+			return cl_calib_dcoc_get_chan_idx(calib_channels_5g_bw_160,
+							  ARRAY_SIZE(calib_channels_5g_bw_160),
+							  channel);
+
+		if (!cl_hw->chip->conf->ce_calib_runtime_en)
+			channel = cl_calib_dcoc_convert_to_channel_in_plan(channel, BAND_5G);
+
+		if (bw == CHNL_BW_20)
+			return cl_calib_dcoc_get_chan_idx(calib_channels_5g_bw_20,
+							  ARRAY_SIZE(calib_channels_5g_bw_20),
+							  channel);
+
+		if (bw == CHNL_BW_40)
+			return cl_calib_dcoc_get_chan_idx(calib_channels_5g_bw_40,
+							  ARRAY_SIZE(calib_channels_5g_bw_40),
+							  channel);
+
+		if (bw == CHNL_BW_80)
+			return cl_calib_dcoc_get_chan_idx(calib_channels_5g_bw_80,
+							  ARRAY_SIZE(calib_channels_5g_bw_80),
+							  channel);
+	}
+
+	return cl_calib_dcoc_get_chan_idx(calib_channels_24g, ARRAY_SIZE(calib_channels_24g),
+					  channel);
+}
+
+void cl_calib_dcoc_fill_data(struct cl_hw *cl_hw, struct cl_iq_dcoc_info *iq_dcoc_db)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	u8 lna = 0, chain = 0;
+	u8 bw = cl_hw->bw;
+	u8 channel_idx = cl_calib_dcoc_channel_bw_to_idx(cl_hw, cl_hw->channel, bw);
+	u8 tcv_idx = cl_hw->tcv_idx;
+	u8 sx = cl_hw->sx_idx;
+
+	for (lna = 0; lna < DCOC_LNA_GAIN_NUM; lna++)
+		riu_chain_for_each(chain)
+			iq_dcoc_db->dcoc[lna][chain] =
+				chip->calib_db.dcoc[tcv_idx][channel_idx][bw][sx][chain][lna];
+}
+
+u8 cl_calib_dcoc_tcv_channel_to_idx(struct cl_chip *chip, u8 tcv_idx, u8 channel, u8 bw)
+{
+	u8 i = 0;
+
+	if (cl_chip_is_6g(chip)) {
+		if (tcv_idx == TCV0) {
+			if (bw == CHNL_BW_20)
+				return cl_calib_dcoc_get_chan_idx(calib_channels_6g_bw_20,
+								  ARRAY_SIZE
+								  (calib_channels_6g_bw_20),
+								  channel);
+
+			if (bw == CHNL_BW_40)
+				return cl_calib_dcoc_get_chan_idx(calib_channels_6g_bw_40,
+								  ARRAY_SIZE
+								  (calib_channels_6g_bw_40),
+								  channel);
+
+			if (bw == CHNL_BW_80)
+				return cl_calib_dcoc_get_chan_idx(calib_channels_6g_bw_80,
+								  ARRAY_SIZE
+								  (calib_channels_6g_bw_80),
+								  channel);
+
+			if (bw == CHNL_BW_160)
+				return cl_calib_dcoc_get_chan_idx(calib_channels_6g_bw_160,
+								  ARRAY_SIZE
+								  (calib_channels_6g_bw_160),
+								  channel);
+		} else if (tcv_idx == TCV1) {
+			if (bw == CHNL_BW_20)
+				return cl_calib_dcoc_get_chan_idx(calib_channels_5g_bw_20,
+								  ARRAY_SIZE
+								  (calib_channels_5g_bw_20),
+								  channel);
+
+			if (bw == CHNL_BW_40)
+				return cl_calib_dcoc_get_chan_idx(calib_channels_5g_bw_40,
+								  ARRAY_SIZE
+								  (calib_channels_5g_bw_40),
+								  channel);
+
+			if (bw == CHNL_BW_80)
+				return cl_calib_dcoc_get_chan_idx(calib_channels_5g_bw_80,
+								  ARRAY_SIZE
+								  (calib_channels_5g_bw_80),
+								  channel);
+
+			if (bw == CHNL_BW_160)
+				return cl_calib_dcoc_get_chan_idx(calib_channels_5g_bw_160,
+								  ARRAY_SIZE
+								  (calib_channels_5g_bw_160),
+								  channel);
+		}
+	} else {
+		if (channel <= NUM_CHANNELS_24G) {
+			for (i = 0; i < CALIB_CHAN_24G_MAX; i++)
+				if (calib_channels_24g[i] == channel)
+					return i;
+		} else {
+			if (bw == CHNL_BW_20)
+				return cl_calib_dcoc_get_chan_idx(calib_channels_5g_bw_20,
+								ARRAY_SIZE
+								(calib_channels_5g_bw_20),
+								channel);
+
+			if (bw == CHNL_BW_40)
+				return cl_calib_dcoc_get_chan_idx(calib_channels_5g_bw_40,
+								ARRAY_SIZE
+								(calib_channels_5g_bw_40),
+								channel);
+
+			if (bw == CHNL_BW_80)
+				return cl_calib_dcoc_get_chan_idx(calib_channels_5g_bw_80,
+								ARRAY_SIZE
+								(calib_channels_5g_bw_80),
+								channel);
+
+			if (bw == CHNL_BW_160)
+				return cl_calib_dcoc_get_chan_idx(calib_channels_5g_bw_160,
+								ARRAY_SIZE
+								(calib_channels_5g_bw_160),
+								channel);
+		}
+	}
+
+	return 0;
+}
+
+void cl_calib_dcoc_handle_set_channel_cfm(struct cl_hw *cl_hw, bool first_channel)
+{
+	struct calib_cfm *dcoc_iq_cfm =
+		&cl_hw->iq_dcoc_data_info.iq_dcoc_data->dcoc_iq_cfm[CALIB_CFM_DCOC];
+	s16 calib_temperature = cl_calib_common_get_temperature(cl_hw, CALIB_CFM_DCOC);
+	u8 channel = cl_hw->channel;
+	u8 bw = cl_hw->bw;
+
+	cl_dbg_trace(cl_hw, "calib_temperature = %d, channel = %u, bw = %u\n", calib_temperature,
+		     channel, bw);
+
+	cl_calib_dcoc_handle_data(cl_hw, calib_temperature, channel, bw);
+	cl_calib_dcoc_handle_report(cl_hw, calib_temperature, channel, bw);
+
+	/*
+	 * Set the default status to FAIL, to ensure FW is actually changing the value,
+	 * if the calibration succeeded.
+	 */
+	dcoc_iq_cfm->status = CALIB_FAIL;
+}
+
+static void cl_calib_iq_handle_data(struct cl_hw *cl_hw, s16 calib_temperature, u8 channel,
+				    u8 bw, u8 plan_bitmap)
+{
+	int chain;
+	u8 tcv_idx = cl_hw->tcv_idx;
+	u8 sx = cl_hw->sx_idx;
+	u8 channel_idx = cl_calib_dcoc_channel_bw_to_idx(cl_hw, channel, bw);
+	struct cl_iq_calib iq_calib_dma;
+
+	riu_chain_for_each(chain) {
+		if ((plan_bitmap & (1 << chain)) == 0)
+			continue;
+
+		iq_calib_dma = cl_hw->iq_dcoc_data_info.iq_dcoc_data->iq_dcoc_db.iq_tx[chain];
+		cl_hw->chip->calib_db.iq_tx[tcv_idx][channel_idx][bw][sx][chain] = iq_calib_dma;
+
+		iq_calib_dma = cl_hw->iq_dcoc_data_info.iq_dcoc_data->iq_dcoc_db.iq_rx[chain];
+		cl_hw->chip->calib_db.iq_rx[tcv_idx][channel_idx][bw][sx][chain] = iq_calib_dma;
+	}
+}
+
+static void cl_calib_iq_lolc_handle_data(struct cl_hw *cl_hw, s16 calib_temperature,
+					 u8 channel, u8 bw, u8 plan_bitmap)
+{
+	int chain;
+	u8 tcv_idx = cl_hw->tcv_idx;
+	u8 sx = cl_hw->sx_idx;
+	u8 channel_idx = cl_calib_dcoc_channel_bw_to_idx(cl_hw, channel, bw);
+	__le32 lolc_calib_dma;
+
+	riu_chain_for_each(chain) {
+		if ((plan_bitmap & (1 << chain)) == 0)
+			continue;
+
+		lolc_calib_dma =
+			cl_hw->iq_dcoc_data_info.iq_dcoc_data->iq_dcoc_db.iq_tx_lolc[chain];
+		cl_hw->chip->calib_db.iq_tx_lolc[tcv_idx][channel_idx][bw][sx][chain] =
+			le32_to_cpu(lolc_calib_dma);
+	}
+}
+
+static void cl_calib_iq_lolc_handle_report(struct cl_hw *cl_hw, s16 calib_temperature,
+					   int channel, u8 bw, u8 plan_bitmap)
+{
+	struct cl_iq_dcoc_report *report = &cl_hw->iq_dcoc_data_info.iq_dcoc_data->report;
+	int chain;
+	struct cl_lolc_report lolc_report_dma;
+	int bw_mhz = BW_TO_MHZ(bw);
+	s16 lolc_threshold = cl_hw->chip->conf->ci_lolc_db_thr;
+	s32 lolc_qual = 0;
+
+	riu_chain_for_each(chain) {
+		if ((plan_bitmap & (1 << chain)) == 0)
+			continue;
+
+		lolc_report_dma = report->lolc_report[chain];
+		lolc_qual = (s16)(le16_to_cpu(lolc_report_dma.lolc_qual)) >> 8;
+
+		cl_dbg_trace(cl_hw, "LOLC Quality [chain = %u] = %d, Iter = %u\n",
+			     chain, lolc_qual, lolc_report_dma.n_iter);
+
+		if (lolc_qual > lolc_threshold) {
+			cl_dbg_warn(cl_hw,
+				    "Warning: LOLC value exceeds threshold [%ddB]: channel %u, "
+				    "bw  = %u, chain = %u, LOLC[dB] = %d, I[Iter] = %u\n",
+				    lolc_threshold, channel, bw_mhz, chain, lolc_qual,
+				    lolc_report_dma.n_iter);
+			cl_hw->chip->calib_db.errors[cl_hw->tcv_idx].lolc++;
+		}
+	}
+}
+
+static int cl_calib_iq_calibrate_channel(struct cl_hw *cl_hw, u32 channel, u32 bw,
+					 bool first_channel)
+{
+	u32 primary = 0;
+	u32 center = 0;
+	enum nl80211_chan_width width = NL80211_CHAN_WIDTH_20;
+	struct cl_calib_params calib_params = {
+		(SET_CHANNEL_MODE_CALIB_IQ | SET_CHANNEL_MODE_CALIB_LOLC),
+		first_channel, SX_FREQ_OFFSET_Q2, 0
+	};
+
+	/* Convert ant to riu chain in the calib plan_bitmap */
+	calib_params.plan_bitmap =
+		cl_hw_ant_mask_to_riu_chain_mask(cl_hw, cl_hw->mask_num_antennas);
+
+	if (cl_chandef_calc(cl_hw, channel, bw, &width, &primary, &center)) {
+		cl_dbg_err(cl_hw, "cl_chandef_calc failed\n");
+		return -EINVAL;
+	}
+
+	cl_dbg_trace(cl_hw, "\n ------  START CALIB IQ CHANNEL  -----\n");
+	cl_dbg_trace(cl_hw, "channel = %u first_channel = %d\n", channel, first_channel);
+
+	/* Set channel mode to LO+IQ calibration mode */
+	return cl_msg_tx_set_channel(cl_hw, channel, bw, primary, center, calib_params);
+}
+
+static u8 cl_calib_iq_convert_plan_to_calib_db_idx(u8 chan_idx_src, u8 bw)
+{
+	u8 shift_idx = 0;
+	/*
+	 * Calibration data is fetched from calibrated channels to previous uncalibrated channels in
+	 * plan list.
+	 *
+	 * For example: channel 65 was calibrated due the channels plan list. Calibration data of
+	 * channel 65 saved in calib_db struct in the relevant chan idx place due the BW, as the
+	 * follow:
+	 * chan_idx 16 for BW 20,
+	 * chan_idx 8 for BW 40
+	 * chan_idx 4 for BW 80
+	 * chan_idx 2 for BW 160.
+	 *
+	 * We want to copy calib data of IQ & LOLC from channel 65 to channel 49. Doing the same
+	 * also to the other uncalib channels: 33->17, 65->49, 97->81 etc.
+	 *
+	 * The chan idx of channel 49 in the calib_db by BW is:
+	 * chan_idx 12 for BW 20,
+	 * chan_idx 6 for BW 40
+	 * chan_idx 3 for BW 80
+	 * (no exist chan_idx for BW 160)
+	 *
+	 * We copy the data in calib_db from idx of channel 65 to the idx of channel 49:
+	 * chan_idx 16 to chan_idx 12 (in BW 20)
+	 * chan_idx 8 to chan_idx 6 (in BW 40)
+	 * chan_idx 4 to chan_idx 3 (in BW 80)
+	 *
+	 * In general, the dst chan idx will be calculated by;
+	 * dst_idx = src_idx - 4 (for BW 20)
+	 * dst_idx = src_idx - 2 (for BW 40)
+	 * dst_idx = src_idx - 1 (for BW 80)
+	 *
+	 * The way to calc this is shiftting is by the follow bitmask:
+	 * 4 >> bw
+	 */
+	shift_idx = 4 >> bw;
+
+	return chan_idx_src - shift_idx;
+}
+
+static void cl_calib_iq_copy_data_to_uncalibrated_channels_6g(struct cl_hw *cl_hw)
+{
+	struct cl_calib_db *calib_db = &cl_hw->chip->calib_db;
+	int i;
+	u8 sx = cl_hw->sx_idx;
+	u8 tcv_idx = cl_hw->tcv_idx;
+	u8 chan_idx_src = 0;
+	u8 chan_idx_dst = 0;
+	u8 chain = 0;
+	u8 bw = 0;
+
+	/*
+	 * Copy iq & lo calib data from 6g list plan calibrate channels: 1, 33, 65, 97, 129, 161,
+	 * 193, 22 to uncalibrated channels 17, 49, 81, 113, 145, 177, 209. copy to the correct
+	 * channel idx for each different bw
+	 */
+	for (i = 1; i < CALIB_CHAN_6G_PLAN - 1; i += 2)
+		riu_chain_for_each(chain)
+			/* Iterate only CHNL_BW_80 and CHNL_BW_20 */
+			for (bw = CHNL_BW_20; bw <= CHNL_BW_80; bw += 2) {
+				chan_idx_src =
+					cl_calib_dcoc_channel_bw_to_idx(cl_hw,
+									calib_channels_6g_plan[i],
+									bw);
+
+				chan_idx_dst =
+					cl_calib_iq_convert_plan_to_calib_db_idx(chan_idx_src, bw);
+				memcpy(&calib_db->iq_tx[tcv_idx][chan_idx_dst][bw][sx][chain],
+				       &calib_db->iq_tx[tcv_idx][chan_idx_src][bw][sx][chain],
+				       sizeof(struct cl_iq_calib));
+				memcpy(&calib_db->iq_rx[tcv_idx][chan_idx_dst][bw][sx][chain],
+				       &calib_db->iq_rx[tcv_idx][chan_idx_src][bw][sx][chain],
+				       sizeof(struct cl_iq_calib));
+				calib_db->iq_tx_lolc[tcv_idx][chan_idx_dst][bw][sx][chain] =
+					calib_db->iq_tx_lolc[tcv_idx][chan_idx_src][bw][sx][chain];
+			}
+}
+
+static bool cl_calib_iq_calibrate_6g(struct cl_hw *cl_hw)
+{
+	int i;
+	bool first_channel = true;
+
+	/* Calibrate channels: 1, 33, 65, 97, 129, 161, 193, 225 */
+	for (i = 0; i < CALIB_CHAN_6G_PLAN; i += 2) {
+		if ((cl_calib_iq_calibrate_channel(cl_hw, calib_channels_6g_plan[i], CHNL_BW_160,
+						   first_channel) == 0))
+			first_channel = false;
+
+		if (cl_calib_iq_calibrate_channel(cl_hw, calib_channels_6g_plan[i], CHNL_BW_80,
+						  first_channel) == 0)
+			first_channel = false;
+
+		if (cl_calib_iq_calibrate_channel(cl_hw, calib_channels_6g_plan[i], CHNL_BW_20,
+						  first_channel) == 0)
+			first_channel = false;
+	}
+
+	/*
+	 * For these channels 17, 49, 81, 113, 145, 177, 209
+	 * copy data of next neighbor
+	 */
+	cl_calib_iq_copy_data_to_uncalibrated_channels_6g(cl_hw);
+
+	return first_channel;
+}
+
+static bool cl_calib_iq_calibrate_5g(struct cl_hw *cl_hw)
+{
+	int i;
+	bool first_channel = true;
+
+	if (cl_calib_iq_calibrate_channel(cl_hw, 36, CHNL_BW_160, first_channel) == 0)
+		first_channel = false;
+
+	if (cl_calib_iq_calibrate_channel(cl_hw, 100, CHNL_BW_160, first_channel) == 0)
+		first_channel = false;
+
+	for (i = 0; i < CALIB_CHAN_5G_PLAN; i++) {
+		if (cl_calib_iq_calibrate_channel(cl_hw, calib_channels_5g_plan[i], CHNL_BW_80,
+						  first_channel) == 0)
+			first_channel = false;
+
+		if (cl_calib_iq_calibrate_channel(cl_hw, calib_channels_5g_plan[i], CHNL_BW_20,
+						  first_channel) == 0)
+			first_channel = false;
+	}
+
+	return first_channel;
+}
+
+static bool cl_calib_iq_calibrate_24g(struct cl_hw *cl_hw)
+{
+	int i;
+	bool first_channel = true;
+
+	if (cl_hw->chip->conf->ce_production_mode) {
+		if (cl_calib_iq_calibrate_channel(cl_hw, 1, CHNL_BW_160,
+						  first_channel) == 0)
+			first_channel = false;
+
+		if (cl_calib_iq_calibrate_channel(cl_hw, 1, CHNL_BW_80,
+						  first_channel) == 0)
+			first_channel = false;
+	}
+
+	for (i = 0; i < CALIB_CHAN_24G_MAX; i++) {
+		if (cl_calib_iq_calibrate_channel(cl_hw, calib_channels_24g[i], CHNL_BW_40,
+						  first_channel) == 0)
+			first_channel = false;
+
+		if (cl_calib_iq_calibrate_channel(cl_hw, calib_channels_24g[i], CHNL_BW_20,
+						  first_channel) == 0)
+			first_channel = false;
+	}
+
+	return first_channel;
+}
+
+static void cl_calib_iq_calibrate(struct cl_hw *cl_hw)
+{
+	if (cl_band_is_6g(cl_hw))
+		cl_calib_iq_calibrate_6g(cl_hw);
+	else if (cl_band_is_5g(cl_hw))
+		cl_calib_iq_calibrate_5g(cl_hw);
+	else if (cl_band_is_24g(cl_hw))
+		cl_calib_iq_calibrate_24g(cl_hw);
+}
+
+static void cl_calib_iq_init_calibration_tcv(struct cl_hw *cl_hw)
+{
+	u8 tcv_idx = cl_hw->tcv_idx;
+
+	cl_calib_iq_calibrate(cl_hw);
+
+	cl_hw->chip->iq_dcoc_conf.iq_file_num_ant[tcv_idx] = cl_hw->num_antennas;
+}
+
+void cl_calib_restore_channel(struct cl_hw *cl_hw, struct cl_calib_iq_restore *iq_restore)
+{
+	u8 bw = iq_restore->bw;
+	u32 primary = iq_restore->primary;
+	u32 center = iq_restore->center;
+	u8 channel = iq_restore->channel;
+
+	cl_msg_tx_set_channel(cl_hw, channel, bw, primary, center, CL_CALIB_PARAMS_DEFAULT_STRUCT);
+}
+
+void cl_calib_save_channel(struct cl_hw *cl_hw, struct cl_calib_iq_restore *iq_restore)
+{
+	iq_restore->bw = cl_hw->bw;
+	iq_restore->primary = cl_hw->primary_freq;
+	iq_restore->center = cl_hw->center_freq;
+	iq_restore->channel = ieee80211_frequency_to_channel(cl_hw->primary_freq);
+
+	cl_dbg_chip_trace(cl_hw, "bw = %u, primary = %d, center = %d, channel = %u\n",
+			  iq_restore->bw, iq_restore->primary,
+			  iq_restore->center, iq_restore->channel);
+}
+
+int cl_calib_iq_set_idle(struct cl_hw *cl_hw, bool idle)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	struct cl_hw *cl_hw_tcv0 = chip->cl_hw_tcv0;
+	struct cl_hw *cl_hw_tcv1 = chip->cl_hw_tcv1;
+	bool tcv0_en = cl_chip_is_tcv0_enabled(chip) && cl_radio_is_on(cl_hw_tcv0);
+	bool tcv1_en = cl_chip_is_tcv1_enabled(chip) && cl_radio_is_on(cl_hw_tcv1);
+
+	if (!idle) {
+		if (tcv1_en)
+			cl_msg_tx_set_idle(cl_hw_tcv1, MAC_ACTIVE, false);
+
+		if (tcv0_en)
+			cl_msg_tx_set_idle(cl_hw_tcv0, MAC_ACTIVE, false);
+
+		return 0;
+	}
+
+	if (tcv1_en)
+		cl_msg_tx_idle_async(cl_hw_tcv1, false);
+
+	if (tcv0_en)
+		cl_msg_tx_set_idle(cl_hw_tcv0, MAC_IDLE_SYNC, false);
+
+	cl_dbg_info(cl_hw, "idle_async_set = %u\n", cl_hw->idle_async_set);
+
+	if (wait_event_timeout(cl_hw->wait_queue, !cl_hw->idle_async_set,
+			       CL_MSG_CFM_TIMEOUT_JIFFIES))
+		return 0;
+
+	cl_dbg_err(cl_hw, "Timeout occurred - MM_IDLE_ASYNC_IND\n");
+	return -ETIMEDOUT;
+}
+
+bool cl_calib_iq_calibration_needed(struct cl_hw *cl_hw)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	struct cl_iq_dcoc_conf *iq_dcoc_conf = &chip->iq_dcoc_conf;
+	bool calib_needed = false;
+
+	if (!IS_REAL_PHY(chip))
+		return false;
+
+	if (cl_hw->chip->conf->ce_calib_runtime_en)
+		return false;
+
+	if (cl_hw_is_tcv0(cl_hw) && chip->conf->ci_tcv1_chains_sx0)
+		return false;
+
+	if (cl_chip_is_tcv0_enabled(chip)) {
+		u8 num_antennas_tcv0 = chip->cl_hw_tcv0->num_antennas;
+
+		if (iq_dcoc_conf->iq_file_num_ant[TCV0] < num_antennas_tcv0 &&
+		    !chip->conf->ci_tcv1_chains_sx0) {
+			cl_dbg_verbose(cl_hw,
+				       "Num of antennas [%u], is larger than LOLC Calibration File "
+				       "num of antennas [%u], recalibration is needed\n",
+				       num_antennas_tcv0, iq_dcoc_conf->iq_file_num_ant[TCV0]);
+			calib_needed = true;
+		}
+	}
+
+	if (cl_chip_is_tcv1_enabled(chip)) {
+		u8 num_antennas_tcv1 = chip->cl_hw_tcv1->num_antennas;
+
+		if (iq_dcoc_conf->iq_file_num_ant[TCV1] < num_antennas_tcv1) {
+			cl_dbg_verbose(cl_hw,
+				       "Num of antennas [%u], is larger than LOLC Calibration File "
+				       "num of antennas [%u], recalibration is needed\n",
+				       num_antennas_tcv1, iq_dcoc_conf->iq_file_num_ant[TCV1]);
+			calib_needed = true;
+		}
+	}
+
+	return calib_needed;
+}
+
+void cl_calib_iq_init_calibration(struct cl_hw *cl_hw)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	u8 fem_mode = cl_hw->fem_mode;
+	struct cl_iq_dcoc_conf *iq_dcoc_conf = &chip->iq_dcoc_conf;
+	struct cl_hw *cl_hw_tcv0 = chip->cl_hw_tcv0;
+	struct cl_hw *cl_hw_tcv1 = chip->cl_hw_tcv1;
+	struct cl_calib_iq_restore iq_restore_tcv0;
+	struct cl_calib_iq_restore iq_restore_tcv1;
+	u8 save_tcv0_needed = cl_hw_tcv0 && cl_hw_tcv0->primary_freq &&
+		!chip->conf->ci_tcv1_chains_sx0;
+	u8 save_tcv1_needed = cl_hw_tcv1 && cl_hw_tcv1->primary_freq;
+
+	if (save_tcv0_needed)
+		cl_calib_save_channel(cl_hw_tcv0, &iq_restore_tcv0);
+
+	if (save_tcv1_needed)
+		cl_calib_save_channel(cl_hw_tcv1, &iq_restore_tcv1);
+
+	cl_fem_set_iq_bypass(cl_hw);
+	cl_afe_cfg_calib(chip);
+
+	if (cl_hw_tcv0 &&
+	    (chip->iq_dcoc_conf.force_calib ||
+	    (iq_dcoc_conf->iq_file_num_ant[TCV0] < cl_hw_tcv0->num_antennas &&
+	    !chip->conf->ci_tcv1_chains_sx0))) {
+		cl_calib_iq_init_calibration_tcv(cl_hw_tcv0);
+	}
+
+	if (cl_hw_tcv1 &&
+	    (chip->iq_dcoc_conf.force_calib ||
+	    iq_dcoc_conf->iq_file_num_ant[TCV1] < cl_hw_tcv1->num_antennas)) {
+		cl_calib_iq_init_calibration_tcv(cl_hw_tcv1);
+	}
+
+	cl_fem_iq_restore(cl_hw, fem_mode);
+	cl_afe_cfg_restore(chip);
+
+	if (save_tcv0_needed)
+		cl_calib_restore_channel(cl_hw_tcv0, &iq_restore_tcv0);
+
+	if (save_tcv1_needed)
+		cl_calib_restore_channel(cl_hw_tcv1, &iq_restore_tcv1);
+}
+
+void cl_calib_iq_fill_data(struct cl_hw *cl_hw, struct cl_iq_calib *iq_data,
+			   struct cl_iq_calib *iq_chip_data)
+{
+	u8 ant = 0;
+
+	for (ant = 0; ant < MAX_ANTENNAS; ant++) {
+		iq_data[ant].coef0 = iq_chip_data[ant].coef0;
+		iq_data[ant].coef1 = iq_chip_data[ant].coef1;
+		iq_data[ant].coef2 = iq_chip_data[ant].coef2;
+		iq_data[ant].gain = iq_chip_data[ant].gain;
+	}
+}
+
+void cl_calib_iq_lolc_fill_data(struct cl_hw *cl_hw, __le32 *iq_lolc)
+{
+	struct cl_calib_db *calib_db = &cl_hw->chip->calib_db;
+	u8 ant = 0;
+	u8 bw = cl_hw->bw;
+	u8 chan_idx = cl_calib_dcoc_channel_bw_to_idx(cl_hw, cl_hw->channel, bw);
+	u8 tcv_idx = cl_hw->tcv_idx;
+	u8 sx = cl_hw->sx_idx;
+
+	for (ant = 0; ant < MAX_ANTENNAS; ant++)
+		iq_lolc[ant] = cpu_to_le32(calib_db->iq_tx_lolc[tcv_idx][chan_idx][bw][sx][ant]);
+}
+
+void cl_calib_iq_handle_set_channel_cfm(struct cl_hw *cl_hw, u8 plan_bitmap)
+{
+	struct calib_cfm *dcoc_iq_cfm =
+		&cl_hw->iq_dcoc_data_info.iq_dcoc_data->dcoc_iq_cfm[CALIB_CFM_IQ];
+	s16 calib_temperature = cl_calib_common_get_temperature(cl_hw, CALIB_CFM_IQ);
+	u8 channel = cl_hw->channel;
+	u8 bw = cl_hw->bw;
+
+	CL_DBG(cl_hw, DBG_LVL_TRACE, "calib_temperature = %d, channel = %u, bw = %u\n",
+	       calib_temperature, channel, bw);
+
+	cl_calib_iq_handle_data(cl_hw, calib_temperature, channel, bw, plan_bitmap);
+
+	/*
+	 * Set the default status to FAIL, to ensure FW is actually changing the value,
+	 * if the calibration succeeded.
+	 */
+	dcoc_iq_cfm->status = CALIB_FAIL;
+}
+
+void cl_calib_iq_lolc_handle_set_channel_cfm(struct cl_hw *cl_hw, u8 plan_bitmap)
+{
+	struct calib_cfm *dcoc_iq_cfm =
+		&cl_hw->iq_dcoc_data_info.iq_dcoc_data->dcoc_iq_cfm[CALIB_CFM_IQ];
+	s16 calib_temperature = cl_calib_common_get_temperature(cl_hw, CALIB_CFM_IQ);
+	u8 channel = cl_hw->channel;
+	u8 bw = cl_hw->bw;
+
+	cl_dbg_trace(cl_hw, "calib_temperature = %d, channel = %u, bw = %u\n", calib_temperature,
+		     channel, bw);
+
+	cl_calib_iq_lolc_handle_data(cl_hw, calib_temperature, channel, bw, plan_bitmap);
+	cl_calib_iq_lolc_handle_report(cl_hw, calib_temperature, channel, bw, plan_bitmap);
+
+	/*
+	 * Set the default status to FAIL, to ensure FW is actually changing the value,
+	 * if the calibration succeeded.
+	 */
+	dcoc_iq_cfm->status = CALIB_FAIL;
+}
+
+void cl_calib_iq_get_tone_vector(struct cl_hw *cl_hw, __le16 *tone_vector)
+{
+	u8 tone = 0;
+	u8 *vector_ptr = NULL;
+
+	switch (cl_hw->bw) {
+	case CHNL_BW_20:
+		vector_ptr = cl_hw->conf->ci_calib_conf_tone_vector_20bw;
+		break;
+	case CHNL_BW_40:
+		vector_ptr = cl_hw->conf->ci_calib_conf_tone_vector_40bw;
+		break;
+	case CHNL_BW_80:
+		vector_ptr = cl_hw->conf->ci_calib_conf_tone_vector_80bw;
+		break;
+	case CHNL_BW_160:
+		vector_ptr = cl_hw->conf->ci_calib_conf_tone_vector_160bw;
+		break;
+	default:
+		vector_ptr = cl_hw->conf->ci_calib_conf_tone_vector_20bw;
+		break;
+	}
+
+	for (tone = 0; tone < IQ_NUM_TONES_REQ; tone++)
+		tone_vector[tone] = cpu_to_le16((u16)vector_ptr[tone]);
+}
+
+void cl_calib_iq_init_production(struct cl_hw *cl_hw)
+{
+	struct cl_hw *cl_hw_other = NULL;
+	struct cl_chip *chip = cl_hw->chip;
+
+	if (!cl_chip_is_both_enabled(chip) ||
+	    (cl_hw_is_tcv1(cl_hw) && chip->conf->ci_tcv1_chains_sx0)) {
+		if (cl_calib_iq_calibration_needed(cl_hw))
+			cl_calib_iq_init_calibration(cl_hw);
+		return;
+	}
+
+	cl_hw_other = cl_hw_other_tcv(cl_hw);
+	if (!cl_hw_other)
+		return;
+
+	if (cl_hw_other->iq_cal_ready) {
+		cl_hw_other->iq_cal_ready = false;
+		cl_calib_iq_init_calibration(cl_hw);
+	} else if (cl_calib_iq_calibration_needed(cl_hw)) {
+		cl_hw->iq_cal_ready = true;
+		cl_dbg_verbose(cl_hw, "IQ Calibration needed. Wait for both TCVs before starting "
+			       "calibration.\n");
+	}
+}
+
+/*
+ * CL80x0: TCV0 - 5g, TCV1 - 24g
+ * ==============================================
+ * 50  48  46  44  42  40  38  36  --> Start 5g
+ * 100 64  62  60  58  56  54  52
+ * 116 114 112 110 108 106 104 102
+ * 134 132 128 126 124 122 120 118
+ * 153 151 149 144 142 140 138 136
+ * 3   2   1   165 161 159 157 155  --> Start 24g
+ * 11  10  9   8   7   6   5   4
+ *                     14  13  12
+ */
+
+/*
+ * CL80x6: TCV0 - 6g, TCV1 - 5g
+ * ==============================================
+ * 25  21  17  13  9   5   2   1   --> Start 6g
+ * 57  53  49  45  41  37  33  29
+ * 89  85  81  77  73  69  65  61
+ * 121 117 113 109 105 101 97  93
+ * 153 147 143 139 135 131 127 123
+ * 185 181 177 173 169 165 161 157
+ * 217 213 209 205 201 197 193 189
+ * 42  40  38  36  233 229 225 221 --> Start 5g
+ * 58  56  54  52  50  48  46  44
+ * 108 106 104 102 100 64  62  60
+ * 124 122 120 118 116 114 112 110
+ * 142 140 138 136 134 132 128 126
+ * 161 159 157 155 153 151 149 144
+ *                             165
+ */
+
+#define BITMAP_80X0_START_TCV0  0
+#define BITMAP_80X0_MAX_TCV0    NUM_CHANNELS_5G
+
+#define BITMAP_80X0_START_TCV1 NUM_CHANNELS_5G
+#define BITMAP_80X0_MAX_TCV1   (NUM_CHANNELS_5G + NUM_CHANNELS_24G)
+
+#define BITMAP_80X6_START_TCV0  0
+#define BITMAP_80X6_MAX_TCV0    NUM_BITMAP_CHANNELS_6G
+
+#define BITMAP_80X6_START_TCV1  NUM_BITMAP_CHANNELS_6G
+#define BITMAP_80X6_MAX_TCV1    (NUM_BITMAP_CHANNELS_6G + NUM_CHANNELS_5G)
+
+#define INVALID_ADDR 0xffff
+
+static u8 cl_get_bitmap_start_tcv1(struct cl_chip *chip)
+{
+	if (cl_chip_is_6g(chip))
+		return BITMAP_80X6_START_TCV1;
+	else
+		return BITMAP_80X0_START_TCV1;
+}
+
+static u8 cl_idx_to_arr_offset(u8 idx)
+{
+	/* Divide by 8 for array index */
+	return idx >> 3;
+}
+
+static u8 cl_idx_to_bit_offset(u8 idx)
+{
+	/* Reminder is for bit index (assummed array of u8) */
+	return idx & 0x07;
+}
+
+static const u8 bits_cnt_table256[] = {
+	0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4,
+	1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
+	1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
+	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
+	1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
+	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
+	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
+	3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
+	1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,
+	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
+	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
+	3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
+	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,
+	3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
+	3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,
+	4, 5, 5, 6, 5, 6, 6, 7, 5, 6, 6, 7, 6, 7, 7, 8
+};
+
+static bool cl_is_vector_unset(const u8 *bitmap)
+{
+	/* Check bitmap is unset i.e. all values are CURR_BMP_UNSET */
+	u8 empty_bitmap[BIT_MAP_SIZE] = {0};
+
+	return !memcmp(bitmap, empty_bitmap, BIT_MAP_SIZE);
+}
+
+static bool cl_bitmap_test_bit_idx(const u8 *bitmap, u8 idx)
+{
+	/* Check bit at a given index is set i.e. 1 */
+	u8 arr_idx = cl_idx_to_arr_offset(idx), bit_idx = cl_idx_to_bit_offset(idx);
+
+	if (arr_idx >= BIT_MAP_SIZE)
+		return false;
+
+	/* Convert non-zero to true and zero to false */
+	return !!(bitmap[arr_idx] & BIT(bit_idx));
+}
+
+static void cl_bitmap_shift(u8 *bitmap, u8 shft)
+{
+	/* Shifts an array of byte of size len by shft number of bits to the left */
+	u8 bitmap_tmp[BIT_MAP_SIZE] = {0};
+	u8 msb_shifts = shft % 8;
+	u8 lsb_shifts = 8 - msb_shifts;
+	u8 byte_shift = shft / 8;
+	u8 last_byte = BIT_MAP_SIZE - byte_shift - 1;
+	u8 msb_idx;
+	u8 i;
+
+	memcpy(bitmap_tmp, bitmap, BIT_MAP_SIZE);
+	memset(bitmap, 0, BIT_MAP_SIZE);
+
+	for (i = 0;  i < BIT_MAP_SIZE; i++) {
+		if (i <= last_byte) {
+			msb_idx = i + byte_shift;
+			bitmap[i] = bitmap_tmp[msb_idx] >> msb_shifts;
+			if (i != last_byte)
+				bitmap[i] |= bitmap_tmp[msb_idx + 1] << lsb_shifts;
+		}
+	}
+}
+
+static bool cl_bitmap_set_bit_idx(struct cl_hw *cl_hw, u8 *bitmap, u8 bitmap_size, u8 idx)
+{
+	/* Set bit at a given index */
+	u8 arr_idx = cl_idx_to_arr_offset(idx), bit_idx = cl_idx_to_bit_offset(idx);
+
+	if (arr_idx >= bitmap_size) {
+		cl_dbg_err(cl_hw, "invalid arr_idx (%u)\n", arr_idx);
+		return false;
+	}
+
+	bitmap[arr_idx] |= BIT(bit_idx);
+	return true;
+}
+
+static u16 cl_bitmap_look_lsb_up(struct cl_hw *cl_hw, u8 *bitmap, u16 idx, bool ext)
+{
+	/* Find closest set bit with index higher than idx inside bitmap */
+	u16 curr_idx = idx;
+	u8 curr = 0;
+	u32 chan_num = ext ? NUM_EXT_CHANNELS_6G : cl_channel_num(cl_hw);
+
+	while (++curr_idx < chan_num) {
+		curr = bitmap[cl_idx_to_arr_offset(curr_idx)];
+		if (curr & (1ULL << cl_idx_to_bit_offset(curr_idx)))
+			return curr_idx;
+	}
+
+	/* No matching bit found - return original index */
+	return idx;
+}
+
+static u16 bitmap_look_msb_down(struct cl_hw *cl_hw, u8 *bitmap, u16 idx, bool ext)
+{
+	/* Find closest set bit with index lower than idx inside bitmap */
+	u16 curr_idx = idx;
+	u8 curr = 0;
+	u32 chan_num = ext ? NUM_EXT_CHANNELS_6G : cl_channel_num(cl_hw);
+
+	if (idx >= chan_num) {
+		cl_dbg_err(cl_hw, "Invalid channel index [%u]\n", idx);
+		return idx;
+	}
+
+	while (curr_idx-- != 0) {
+		curr = bitmap[cl_idx_to_arr_offset(curr_idx)];
+		if (curr & (1ULL << cl_idx_to_bit_offset(curr_idx)))
+			return curr_idx;
+	}
+
+	/* No matching bit found - return original index */
+	return idx;
+}
+
+static u8 cl_address_offset_tcv1(struct cl_hw *cl_hw)
+{
+	/* Calculate eeprom calibration data offset for tcv1 */
+	struct cl_chip *chip = cl_hw->chip;
+	u8 i, cnt = 0;
+	u8 bitmap[BIT_MAP_SIZE] = {0};
+
+	if (cl_e2p_read(chip, bitmap, BIT_MAP_SIZE, ADDR_CALIB_POWER_CHAN_BMP))
+		return 0;
+
+	for (i = 0; i < cl_get_bitmap_start_tcv1(chip); i++)
+		cnt += cl_bitmap_test_bit_idx(bitmap, i);
+
+	return cnt;
+}
+
+static int cl_point_idx_to_address(struct cl_hw *cl_hw, u8 *bitmap, struct point *pt)
+{
+	/* Calculate eeprom address for a given idx and phy (initiated point) */
+	u8 i, cnt = 0;
+
+	pt->addr = INVALID_ADDR;
+
+	if (!cl_bitmap_test_bit_idx(bitmap, pt->idx))
+		return 0;
+
+	if (pt->phy >= MAX_ANTENNAS) {
+		cl_dbg_err(cl_hw, "Invalid phy number %u", pt->phy);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < pt->idx; i++)
+		cnt += cl_bitmap_test_bit_idx(bitmap, i);
+
+	if (cl_hw_is_tcv1(cl_hw))
+		cnt += cl_address_offset_tcv1(cl_hw);
+
+	pt->addr = ADDR_CALIB_POWER_PHY +
+		sizeof(struct eeprom_phy_calib) * (cnt * MAX_ANTENNAS + pt->phy);
+
+	return 0;
+}
+
+static bool cl_linear_equation_signed(struct cl_hw *cl_hw, const u16 x, s8 *y,
+				      const u16 x0, const s8 y0, const u16 x1, const s8 y1)
+{
+	/* Calculate y given to points (x0,y0) and (x1,y1) and x */
+	s32 numerator = (x - x0) * (y1 - y0);
+	s32 denominator = x1 - x0;
+
+	if (unlikely(!denominator)) {
+		cl_dbg_err(cl_hw, "zero denominator\n");
+		return false;
+	}
+
+	*y = (s8)(y0 + DIV_ROUND_CLOSEST(numerator, denominator));
+
+	return true;
+}
+
+static void cl_extend_bitmap_6g(struct cl_hw *cl_hw, u8 *bitmap, u8 *ext_bitmap)
+{
+	u8 i, ext_idx;
+
+	for (i = 0; i < cl_channel_num(cl_hw); ++i) {
+		if (cl_bitmap_test_bit_idx(bitmap, i)) {
+			ext_idx = CHAN_BITMAP_IDX_6G_2_EXT_IDX(i);
+			cl_bitmap_set_bit_idx(cl_hw, ext_bitmap, EXT_BIT_MAP_SIZE, ext_idx);
+		}
+	}
+}
+
+static bool cl_calculate_calib(struct cl_hw *cl_hw, u8 *bitmap,
+			       struct point *p0, struct point *p1, struct point *p2)
+{
+	/* Main interpolation/extrapolation function */
+	bool calc_succsess = false, use_ext = false;
+	u16 freq0, freq1, freq2;
+	u8 e2p_ext_bitmap[EXT_BIT_MAP_SIZE] = {0};
+	u8 *bitmap_to_use = bitmap;
+
+	if (unlikely(cl_is_vector_unset(bitmap)))
+		return false;
+
+	/*
+	 * In case that the band is 6g and the channel index wasn't found, it might be because
+	 * the channel is missing from the original bitmap (that includes only 20MHz channels).
+	 * In case of center channels in 40/180/160MHz, it can't be found in the original bitmap
+	 * and therefore we need to extend the bitmap to include these channels in order to perform
+	 * interpolation on it.
+	 */
+	if (cl_band_is_6g(cl_hw) && p0->idx == INVALID_CHAN_IDX) {
+		p0->idx = cl_channel_to_ext_index_6g(cl_hw, p0->chan);
+		cl_extend_bitmap_6g(cl_hw, bitmap, e2p_ext_bitmap);
+		bitmap_to_use = e2p_ext_bitmap;
+		use_ext = true;
+	}
+
+	p1->idx = cl_bitmap_look_lsb_up(cl_hw, bitmap_to_use, p0->idx, use_ext);
+	p2->idx = bitmap_look_msb_down(cl_hw, bitmap_to_use, p0->idx, use_ext);
+
+	/* Invalid case */
+	if (p1->idx == p0->idx && p2->idx == p0->idx) {
+		cl_dbg_err(cl_hw, "Invalid index %u or bad bit map\n", p0->idx);
+		return false;
+	}
+
+	/* Extrapolation case */
+	if (p1->idx == p0->idx)
+		p1->idx = bitmap_look_msb_down(cl_hw, bitmap_to_use, p2->idx, use_ext);
+	if (p2->idx == p0->idx)
+		p2->idx = cl_bitmap_look_lsb_up(cl_hw, bitmap_to_use, p1->idx, use_ext);
+
+	if (use_ext) {
+		/* Convert indices from extended bitmap to eeprom bitmap */
+		p1->idx = CHAN_EXT_IDX_6G_2_BITMAP_IDX(p1->idx);
+		p2->idx = CHAN_EXT_IDX_6G_2_BITMAP_IDX(p2->idx);
+	}
+
+	/* Address from index */
+	if (cl_point_idx_to_address(cl_hw, bitmap, p1) || p1->addr == INVALID_ADDR) {
+		cl_dbg_err(cl_hw, "Point calculation failed\n");
+		return false;
+	}
+
+	if (cl_point_idx_to_address(cl_hw, bitmap, p2) || p2->addr == INVALID_ADDR) {
+		cl_dbg_err(cl_hw, "Point calculation failed\n");
+		return false;
+	}
+
+	/* Read from eeprom */
+	if (cl_e2p_read(cl_hw->chip, (u8 *)&p1->calib, sizeof(struct eeprom_phy_calib), p1->addr))
+		return false;
+
+	/* No interpolation required */
+	if (p1->addr == p2->addr) {
+		p0->calib = p1->calib;
+		return true;
+	}
+
+	/* Interpolation or extrapolation is required - read from eeprom */
+	if (cl_e2p_read(cl_hw->chip, (u8 *)&p2->calib, sizeof(struct eeprom_phy_calib), p2->addr))
+		return false;
+
+	freq0 = (use_ext ? cl_channel_ext_idx_to_freq_6g(cl_hw, p0->idx) :
+		 cl_channel_idx_to_freq(cl_hw, p0->idx));
+	freq1 = cl_channel_idx_to_freq(cl_hw, p1->idx);
+	freq2 = cl_channel_idx_to_freq(cl_hw, p2->idx);
+
+	/* Interpolate/extrapolate target power */
+	calc_succsess = cl_linear_equation_signed(cl_hw,
+						  freq0, &p0->calib.pow,
+						  freq1, p1->calib.pow,
+						  freq2, p2->calib.pow);
+
+	/* Interpolate/extrapolate power offset */
+	calc_succsess = calc_succsess && cl_linear_equation_signed(cl_hw,
+								   freq0, &p0->calib.offset,
+								   freq1, p1->calib.offset,
+								   freq2, p2->calib.offset);
+
+	/* Interpolate/extrapolate calibration temperature */
+	calc_succsess = calc_succsess && cl_linear_equation_signed(cl_hw,
+								   freq0, &p0->calib.tmp,
+								   freq1, p1->calib.tmp,
+								   freq2, p2->calib.tmp);
+
+	if (unlikely(!calc_succsess)) {
+		cl_dbg_err(cl_hw,
+			   "Calc failed: freq0 %u idx0 %u%s, freq1 %u idx1 %u, freq2 %u idx2 %u\n",
+			   freq0, p0->idx, use_ext ? " (ext)" : "",
+			   freq1, p1->idx, freq2, p2->idx);
+		return false;
+	}
+
+	return true;
+}
+
+static int cl_read_validate_vector_bitmap(struct cl_hw *cl_hw, u8 *bitmap)
+{
+	struct cl_chip *chip = cl_hw->chip;
+
+	if (cl_e2p_read(chip, bitmap, BIT_MAP_SIZE, ADDR_CALIB_POWER_CHAN_BMP))
+		return -1;
+
+	/* Test if e2p was read succsefull since it is not ALL EMPTY */
+	if (cl_is_vector_unset(bitmap)) {
+		cl_dbg_err(cl_hw, "Vector not ready\n");
+		return -EPERM;
+	}
+
+	if (cl_hw_is_tcv1(cl_hw)) {
+		u8 bitmap_start = cl_get_bitmap_start_tcv1(chip);
+
+		cl_bitmap_shift(bitmap, bitmap_start);
+	}
+
+	return 0;
+}
+
+static int cl_read_or_interpolate_point(struct cl_hw *cl_hw, u8 *bitmap, struct point *p0)
+{
+	struct point p1 = {.phy = p0->phy};
+	struct point p2 = {.phy = p0->phy};
+	struct point tmp_pt = *p0;
+
+	/* Invalid address = no physical address was allocated to this channel */
+	if (tmp_pt.addr != INVALID_ADDR) {
+		if (cl_e2p_read(cl_hw->chip, (u8 *)&tmp_pt.calib,
+				sizeof(struct eeprom_phy_calib), tmp_pt.addr))
+			return -1;
+	} else {
+		/* Interpolate */
+		if (!cl_calculate_calib(cl_hw, bitmap, &tmp_pt, &p1, &p2)) {
+			cl_dbg_err(cl_hw, "Interpolation Error\n");
+			return -EFAULT;
+		}
+	}
+
+	if (tmp_pt.calib.pow == 0 && tmp_pt.calib.offset == 0 && tmp_pt.calib.tmp == 0) {
+		u16 freq = ieee80211_channel_to_frequency(tmp_pt.chan, cl_hw->nl_band);
+
+		cl_dbg_err(cl_hw, "Verify calibration point: addr %x, idx %u, freq %u, phy %u\n",
+			   tmp_pt.addr, tmp_pt.idx, freq, tmp_pt.phy);
+		/* *Uninitiated eeprom value */
+		return -EINVAL;
+	}
+
+	/* Now p0 will contain "Valid" calculations of calib" */
+	p0->calib = tmp_pt.calib;
+	return 0;
+}
+
+static void cl_calib_power_reset(struct cl_hw *cl_hw)
+{
+	u8 ch_idx;
+	u16 phy;
+	u32 chan_num = cl_band_is_6g(cl_hw) ? NUM_EXT_CHANNELS_6G : cl_channel_num(cl_hw);
+	static const struct cl_tx_power_info default_info = {
+		.power       = UNCALIBRATED_POWER,
+		.offset      = UNCALIBRATED_POWER_OFFSET,
+		.temperature = UNCALIBRATED_TEMPERATURE
+	};
+
+	/* Initiate tx_pow_info struct to default values */
+	for (ch_idx = 0; ch_idx < chan_num; ch_idx++)
+		for (phy = 0; phy < MAX_ANTENNAS; phy++)
+			cl_hw->tx_pow_info[ch_idx][phy] = default_info;
+}
+
+static void cl_calib_fill_power_info(struct cl_hw *cl_hw, u8 chan_idx, u8 ant,
+				     struct point *point)
+{
+	cl_hw->tx_pow_info[chan_idx][ant].power = point->calib.pow;
+	cl_hw->tx_pow_info[chan_idx][ant].offset = point->calib.offset;
+	cl_hw->tx_pow_info[chan_idx][ant].temperature = point->calib.tmp;
+}
+
+#define PHY0_OFFSET_FIX_Q2 -8 /* -2db */
+#define PHY3_OFFSET_FIX_Q2 14 /* +3.5db */
+
+static void cl_calib_phy_offset_adjust(struct cl_hw *cl_hw, u8 eeprom_version,
+				       u8 phy, struct point *point)
+{
+	/*
+	 * Work around:
+	 * Add 3.5dB offset to PHY3 if EEPROM version is 0.
+	 * Decrease 2dB offset to all PHYs if EEPROM version is 1.
+	 */
+	if (!cl_chip_is_6g(cl_hw->chip)) {
+		if (cl_band_is_5g(cl_hw) && eeprom_version == 0 && phy == 3)
+			point->calib.offset += PHY3_OFFSET_FIX_Q2;
+		else if (cl_band_is_24g(cl_hw) && eeprom_version == 1)
+			point->calib.offset += PHY0_OFFSET_FIX_Q2;
+	}
+}
+
+void cl_calib_power_read(struct cl_hw *cl_hw)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	int ret;
+	u8 bitmap[BIT_MAP_SIZE] = {0};
+	struct point curr_point = {0};
+	u8 *phy = &curr_point.phy;
+	u8 *ch_idx = &curr_point.idx;
+	u8 ext_chan_idx = 0;
+	u8 ant;
+	u8 eeprom_version = chip->eeprom_cache->general.version;
+	u32 tmp_freq = 0;
+
+	/* Initiate tx_pow_info struct to default values */
+	cl_calib_power_reset(cl_hw);
+
+	/* Vector not initiated set table to default values */
+	if (unlikely(cl_read_validate_vector_bitmap(cl_hw, bitmap))) {
+		cl_dbg_trace(cl_hw, "initiate to default values\n");
+		return;
+	}
+
+	/* Perform only on calibrated boards - cl_read_validate_vector_bitmap succeeded (0) */
+	for (*ch_idx = 0; *ch_idx < cl_channel_num(cl_hw); (*ch_idx)++) {
+		for (ant = 0; ant < MAX_ANTENNAS; ant++) {
+			if (!(cl_hw->mask_num_antennas & BIT(ant)))
+				continue;
+
+			/*
+			 * In old eeprom versions (< 3) power info was saved in eeprom
+			 * per riu chain (unintentionally) so we need to fetch it accordingly
+			 */
+			if (eeprom_version < 3)
+				*phy = cl_hw_ant_to_riu_chain(cl_hw, ant);
+			else
+				*phy = ant;
+
+			ret = cl_point_idx_to_address(cl_hw, bitmap, &curr_point);
+
+			if (ret) {
+				/* Don't overwrite default values */
+				cl_dbg_err(cl_hw, "point idx to address failed\n");
+				continue;
+			}
+
+			if (cl_band_is_6g(cl_hw)) {
+				tmp_freq = cl_channel_idx_to_freq(cl_hw, *ch_idx);
+				curr_point.chan = ieee80211_frequency_to_channel(tmp_freq);
+			}
+
+			ret = cl_read_or_interpolate_point(cl_hw, bitmap, &curr_point);
+			/* Unable to calculate new value ==> DON'T overwrite default values */
+			if (unlikely(ret))
+				continue;
+
+			cl_calib_phy_offset_adjust(cl_hw, eeprom_version, *phy, &curr_point);
+
+			if (cl_band_is_6g(cl_hw))
+				ext_chan_idx = CHAN_BITMAP_IDX_6G_2_EXT_IDX(*ch_idx);
+			else
+				ext_chan_idx = *ch_idx;
+
+			cl_calib_fill_power_info(cl_hw, ext_chan_idx, ant, &curr_point);
+		}
+	}
+
+	if (!cl_band_is_6g(cl_hw))
+		goto calib_read_out;
+
+	/*
+	 * Fill info for channels that are missing from the original bitmap, which are the
+	 * center channels in 40/180/160MHz (channels 3, 7, 11, etc..).
+	 */
+	for (ext_chan_idx = 0; ext_chan_idx < NUM_EXT_CHANNELS_6G; ext_chan_idx++) {
+		/* Skip channels that were already filled above */
+		tmp_freq = cl_channel_ext_idx_to_freq_6g(cl_hw, ext_chan_idx);
+
+		/* Chan field needs to be updated before calling to cl_read_or_interpolate_point */
+		curr_point.chan = ieee80211_frequency_to_channel(tmp_freq);
+
+		/* If the channel is found in the bitmap - we already handled it above */
+		if (cl_channel_to_bitmap_index(cl_hw, curr_point.chan) != INVALID_CHAN_IDX)
+			continue;
+
+		for (ant = 0; ant < MAX_ANTENNAS; ant++) {
+			if (!(cl_hw->mask_num_antennas & BIT(ant)))
+				continue;
+
+			/*
+			 * In old eeprom versions (< 3) power info was saved in eeprom
+			 * per riu chain (unintentionally) so we need to fetch it accordingly
+			 */
+			if (eeprom_version < 3)
+				*phy = cl_hw_ant_to_riu_chain(cl_hw, ant);
+			else
+				*phy = ant;
+
+			/*
+			 * Addr and idx fields needs to be invalid to successfully interpolate the
+			 * power info on the extended eeprom bitmap.
+			 */
+			curr_point.addr = INVALID_ADDR;
+			curr_point.idx = INVALID_CHAN_IDX;
+
+			ret = cl_read_or_interpolate_point(cl_hw, bitmap, &curr_point);
+
+			/* Unable to calculate new value ==> DON'T overwrite default values */
+			if (unlikely(ret))
+				continue;
+
+			cl_calib_fill_power_info(cl_hw, ext_chan_idx, ant, &curr_point);
+		}
+	}
+calib_read_out:
+	cl_dbg_trace(cl_hw, "Created tx_pow_info\n");
+}
+
+void cl_calib_power_offset_fill(struct cl_hw *cl_hw, u8 channel,
+				u8 bw, u8 offset[MAX_ANTENNAS])
+{
+	u8 i, chain;
+	u8 chan_idx = cl_channel_to_index(cl_hw, cl_hw->channel);
+	s8 pow_offset;
+	s8 signed_offset;
+
+	if (chan_idx == INVALID_CHAN_IDX)
+		return;
+
+	for (i = 0; i < MAX_ANTENNAS; i++) {
+		if (!(cl_hw->mask_num_antennas & BIT(i)))
+			continue;
+
+		pow_offset = cl_hw->tx_pow_info[chan_idx][i].offset;
+		signed_offset = cl_power_offset_check_margin(cl_hw, bw, i, pow_offset);
+		chain = cl_hw_ant_to_riu_chain(cl_hw, i);
+		offset[chain] = cl_convert_signed_to_reg_value(signed_offset);
+	}
+}
+
+struct cl_runtime_work {
+	struct work_struct ws;
+	struct cl_hw *cl_hw;
+	u32 channel;
+	u8 bw;
+	u16 primary;
+	u16 center;
+};
+
+static int _cl_calib_runtime_and_switch_channel(struct cl_hw *cl_hw, u32 channel, u8 bw,
+						u16 primary, u16 center,
+						struct cl_calib_params calib_params)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	struct cl_calib_iq_restore iq_restore_other_tcv;
+	struct cl_hw *cl_hw_other = cl_hw_other_tcv(cl_hw);
+	int ret = 0;
+	u8 fem_mode = cl_hw->fem_mode;
+	u8 save_other_tcv_needed = cl_chip_is_both_enabled(chip) && cl_hw_other &&
+					!!cl_hw_other->primary_freq;
+
+	cl_hw->calib_runtime_needed = false;
+
+	if (save_other_tcv_needed)
+		cl_calib_save_channel(cl_hw_other, &iq_restore_other_tcv);
+
+	if (cl_chip_is_both_enabled(chip)) {
+		ret = cl_calib_iq_set_idle(cl_hw, true);
+		if (ret)
+			return ret;
+	}
+
+	cl_fem_set_iq_bypass(cl_hw);
+	cl_afe_cfg_calib(chip);
+
+	/* Calibration by the default values */
+	if (cl_msg_tx_set_channel(cl_hw, channel, bw, primary, center, calib_params)) {
+		cl_dbg_chip_err(cl_hw, "Failed to calibrate channel %u, bw %u\n",
+				channel, bw);
+		ret = -1;
+	}
+
+	cl_fem_iq_restore(cl_hw, fem_mode);
+	cl_afe_cfg_restore(chip);
+
+	if (save_other_tcv_needed)
+		cl_calib_restore_channel(cl_hw_other, &iq_restore_other_tcv);
+
+	/* Set channel to load the new calib data */
+	ret += cl_msg_tx_set_channel(cl_hw, channel, bw, primary, center,
+				     CL_CALIB_PARAMS_DEFAULT_STRUCT);
+
+	if (cl_chip_is_both_enabled(chip))
+		cl_calib_iq_set_idle(cl_hw, false);
+
+	return ret;
+}
+
+static void cl_calib_runtime_work_handler(struct work_struct *ws)
+{
+	struct cl_runtime_work *runtime_work = container_of(ws, struct cl_runtime_work, ws);
+
+	cl_calib_runtime_and_switch_channel(runtime_work->cl_hw, runtime_work->channel,
+					    runtime_work->bw, runtime_work->primary,
+					    runtime_work->center);
+
+	kfree(runtime_work);
+}
+
+static bool cl_calib_runtime_is_channel_calibrated(struct cl_hw *cl_hw, u8 channel, u8 bw)
+{
+	int chain, lna;
+	u8 chan_idx = cl_calib_dcoc_channel_bw_to_idx(cl_hw, channel, bw);
+	u8 tcv_idx = cl_hw->tcv_idx;
+	u8 sx = cl_hw->sx_idx;
+
+	riu_chain_for_each(chain) {
+		if (!cl_hw->chip->calib_db.iq_tx[tcv_idx][chan_idx][bw][sx][chain].gain &&
+		    !cl_hw->chip->calib_db.iq_tx[tcv_idx][chan_idx][bw][sx][chain].coef0 &&
+		    !cl_hw->chip->calib_db.iq_tx[tcv_idx][chan_idx][bw][sx][chain].coef1 &&
+		    !cl_hw->chip->calib_db.iq_tx[tcv_idx][chan_idx][bw][sx][chain].coef2) {
+			cl_dbg_trace(cl_hw, "IQ TX calibration data is missing\n");
+			return false;
+		}
+
+		if (!cl_hw->chip->calib_db.iq_rx[tcv_idx][chan_idx][bw][sx][chain].gain &&
+		    !cl_hw->chip->calib_db.iq_rx[tcv_idx][chan_idx][bw][sx][chain].coef0 &&
+		    !cl_hw->chip->calib_db.iq_rx[tcv_idx][chan_idx][bw][sx][chain].coef1 &&
+		    !cl_hw->chip->calib_db.iq_rx[tcv_idx][chan_idx][bw][sx][chain].coef2) {
+			cl_dbg_trace(cl_hw, "IQ RX calibration data is missing\n");
+			return false;
+		}
+
+		if (!cl_hw->chip->calib_db.iq_tx_lolc[tcv_idx][chan_idx][bw][sx][chain]) {
+			cl_dbg_trace(cl_hw, "LOLC calibration data is missing\n");
+			return false;
+		}
+	}
+
+	for (lna = 0; lna < DCOC_LNA_GAIN_NUM; lna++) {
+		riu_chain_for_each(chain) {
+			if (!cl_hw->chip->calib_db.dcoc[tcv_idx][chan_idx][bw][sx][chain][lna].i &&
+			    !cl_hw->chip->calib_db.dcoc[tcv_idx][chan_idx][bw][sx][chain][lna].q) {
+				cl_dbg_trace(cl_hw, "DCOC calibration data is missing\n");
+				return false;
+			}
+		}
+	}
+
+	/* If all the calibration data of channel exist */
+	return true;
+}
+
+bool cl_calib_runtime_is_allowed(struct cl_hw *cl_hw)
+{
+	if (!cl_hw)
+		return false;
+
+	if (cl_hw->scanner && cl_is_scan_in_progress(cl_hw->scanner))
+		return false;
+
+	return true;
+}
+
+void cl_calib_runtime_work(struct cl_hw *cl_hw, u32 channel, u8 bw, u16 primary,
+			   u16 center)
+{
+	struct cl_runtime_work *runtime_work = kzalloc(sizeof(*runtime_work), GFP_ATOMIC);
+
+	if (!runtime_work)
+		return;
+
+	runtime_work->cl_hw = cl_hw;
+	runtime_work->channel = channel;
+	runtime_work->bw = bw;
+	runtime_work->primary = primary;
+	runtime_work->center = center;
+	INIT_WORK(&runtime_work->ws, cl_calib_runtime_work_handler);
+	queue_work(cl_hw->drv_workqueue, (struct work_struct *)(&runtime_work->ws));
+}
+
+int cl_calib_runtime_and_switch_channel(struct cl_hw *cl_hw, u32 channel, u8 bw, u32 primary,
+					u32 center)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	struct cl_hw *cl_hw_other = cl_hw_other_tcv(cl_hw);
+	struct cl_calib_params calib_params = {SET_CHANNEL_MODE_CALIB, false, SX_FREQ_OFFSET_Q2, 0};
+	int ret = 0;
+	bool calib_needed = (cl_hw->chip->conf->ci_calib_runtime_force ||
+			     !cl_calib_runtime_is_channel_calibrated(cl_hw, channel, bw)) &&
+			    !cl_hw->sw_scan_in_progress;
+
+	mutex_lock(&cl_hw->chip->calib_runtime_mutex);
+
+	if (!calib_needed || !cl_calib_runtime_is_allowed(cl_hw) ||
+	    (cl_chip_is_both_enabled(chip) && !cl_calib_runtime_is_allowed(cl_hw_other))) {
+		if (calib_needed)
+			cl_hw->calib_runtime_needed = true;
+
+		/* Switch channel without calibration */
+		ret = cl_msg_tx_set_channel(cl_hw, channel, bw, primary, center,
+					    CL_CALIB_PARAMS_DEFAULT_STRUCT);
+		mutex_unlock(&cl_hw->chip->calib_runtime_mutex);
+
+		return ret;
+	}
+
+	/* Convert ant to riu chain in the calib plan_bitmap */
+	calib_params.plan_bitmap = cl_hw_ant_mask_to_riu_chain_mask(cl_hw,
+								    cl_hw->mask_num_antennas);
+
+	/* This mutex needs to be held during the whole calibration process */
+	mutex_lock(&cl_hw->chip->set_idle_mutex);
+	ret = _cl_calib_runtime_and_switch_channel(cl_hw, channel, bw, primary, center,
+						   calib_params);
+	mutex_unlock(&cl_hw->chip->set_idle_mutex);
+
+	mutex_unlock(&cl_hw->chip->calib_runtime_mutex);
+
+	return ret;
+}
+
-- 
2.36.1

