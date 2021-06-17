Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B423AB875
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhFQQIM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:12 -0400
Received: from mail-eopbgr60088.outbound.protection.outlook.com ([40.107.6.88]:43502
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231326AbhFQQHc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BupSPGVRCY8IaudsdADTWSNmgqaRm/VgxO5O5QnXlsuPiBxbW3BYwZzoHYqxZfRPvHsPxclXAG6E/wwepEyRNDvJk0CUHa489cT7L2KZtzTsKG3xid0KGR7bS993Z2OsCALwhbmIiUbKphd5IJt7bL3rQzymfGXxoh6OrHQ76L+MIVgkCXKUfSE0+ND1NMQpCPuHWWSr+6P/7IxHHRlxs9Tz9myHPLUHNAol+ITGTC+rVm90+wgj7ID/DSvDGGzrRCOCnozbtXs9fg98C5aGkh91S4ohqFnPf/aaUCJ7fLmjJjLzwtac8kByGoV7RRcdp2Sde4UcVvsd6DvAp5jEoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rod/+7Qkhyw4UJhd97EfRp9Savc5EM6wA0cK5hvQA1M=;
 b=fnbHR4JoRcrSeYNUw0+jOqZG1nHwHgWMLVNv6G+Ps5i6zsUm9Pbm9dsx/yMKWUHijcBJcsBw5kN8QUCfiCkJ5gdVCWAO69tzxk5fJaXZX+jXNRDA9Xo1eHHayqWuf03pxF/jVMN2rrNtfXXiQQiSqAGYs8JBGOBqdW8XT5aayCayKo3VgVRqo5cJNF/LZtBa3aAMLDoiSZHyiF4smMFSNOaZ8ZbLnFZfN5pnDj1FH6dQ2LqNjpQblRmnCOcV7QRlf+5Jxt4gA7YjjfZvIST95ZyDHs6/U4+ke/PmYOKdHYkey5KFD8RRaLV25WbjyQEtdqRecheF5I3ubkefsG6CDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rod/+7Qkhyw4UJhd97EfRp9Savc5EM6wA0cK5hvQA1M=;
 b=ztDNaSqDEjOWPAgCWthPhKsaQy1bYGmT40gp2PFd4UJKN+ngpebREBx1tKkPkod8uxquu7t/c5p+nJbg00nuH7NXPkgQP4qB09EQwxpjMMFkGtllJvbbyIumcDbDgoRO5ur2iMUrvjcwlZiwvwpSg3DaJr1PFcUd6AjQWJFU3HQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1268.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:04:21 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:21 +0000
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
Subject: [RFC v1 069/256] cl8k: add edca.c
Date:   Thu, 17 Jun 2021 15:59:16 +0000
Message-Id: <20210617160223.160998-70-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64835f21-14a9-4d31-9237-08d931a97f2e
X-MS-TrafficTypeDiagnostic: AM9P192MB1268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1268E6671EF0B4166D67D1C0F60E9@AM9P192MB1268.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:480;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nLYfEJeSOXI4QoZ6JnVwyQYx50E7cio/kzYp9eu7V4Ps+Xr1gAh1dA/GXXL/EcltyK2O5M0JPb4tUn+FDlMm2NweiLlKn22esSzXdDuLnBbB4Zb5Id0BjD6RhSYTgpUzjCWmTo0i/g1DOj7RizIcNgJuXDsRCtIGN/cVgYtv0kFe4gfjUdBGqSwEIRSR+SRvnR3ZHdKooZwiRNrMGMiAn2AQhlhah8OoYQOjKV2YYWq/eevZsPBGtW4EBposoHPQzEBb1u8I7WmO5OO+/cMk+MblRgjBZE+Jacr/6Se10N1W6VxQQDo/Z+NnR7ywTyEsbLOSrWL2Kep53o4TDndhF/GnaTCxMtFSMbwwLLQ55YRX+jA3O1hnsHU+X+3FefZy/dGv9TyaENnfFFuJ+6iOC0N0CSviSxOMzLrYpnEz9xXO1pl7FJwKMnIRMuELVDDVxHCq1U/hrHGATChBIyNb3PpE7zR6zpmf0t9M8Yxy23CaWB+a8m46jmEWjqIaHF6+JDbdBGaM8dSrqRSqWT5mIu+Iw5eRXXn5ctyPmmWj1kO+WfTxb+l1C6BHTfkxZMYpb0FaZrKipDIze2uqOEKQlD+y8gjqeCZWa/Xa/23T+sPAihBcHHF+9AAuJ5xYechgxV+lg8aZRDg+xh3rjDsf/ix0qDyhCoyYmB5uLbZ1SYGl2H0jUF0UPi+832qYHIc+KOKrNit4tE36PTw+puEXzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(6486002)(956004)(54906003)(4326008)(2616005)(186003)(38100700002)(16526019)(8676002)(5660300002)(38350700002)(8936002)(26005)(2906002)(6512007)(9686003)(52116002)(83380400001)(6916009)(66946007)(66556008)(66476007)(86362001)(55236004)(498600001)(6666004)(6506007)(1076003)(107886003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ug5eYJ7T5qg+Z9/ce+bg+IIHgrdW48hr32Gr5X93bawk3wI08kLdStq75cKv?=
 =?us-ascii?Q?1ZCarrS9hVgoUdyzkw3+0kkKViXUsl0spb6Y6DDOFUObHWDNWpukUVBzB5Ip?=
 =?us-ascii?Q?xXdw1U+PS85Tcu6jaD7NUXawwIhthtBCh1ouqbv4yAC5ALvDjdWX0kyIeDPz?=
 =?us-ascii?Q?0xUUHFlB82owFgnXVqQwHy+3gI5oQBm30cBuqSXMz8Yg9D+fl7B1bzB5EUz9?=
 =?us-ascii?Q?P7imx0Ihe3fKpAtrpc2pezFTZ+QcdTbfFFmSq5hFD/HQf+0ft8wA1i3ixrZk?=
 =?us-ascii?Q?AAUHSIqYc6QqW9tCrB0N69+UjpY+UiqvDKOWFbe3gIb34tBPg1jpA+OVILr1?=
 =?us-ascii?Q?VDNzqFqxe+RqK4HV7yYAaMj6aXqwHfVW0/RjV1QNu54uEei0erfrSl++9gLe?=
 =?us-ascii?Q?3Fv5jeH/UAPi80/iZH8SAdqSHYhTRgoANyx84BdIHr8HMlCX1Eb2qdBe1RNs?=
 =?us-ascii?Q?zawm+W9GkTv+lcObjjhPtVUHu3BWQvVV8or8wIv3poy6gGNFZT+OqpqsKQEy?=
 =?us-ascii?Q?8Y3UEsVwODY5ffpTGp1fRFDr1vPbFA86riwHJqqDb8lyha4XjiYoE2Lxd4CD?=
 =?us-ascii?Q?T2VemVHLMhzZH+KKr4hR291F//AKJqTKgVS/BzLPoUmwxbPoBOz05ZRDV3CT?=
 =?us-ascii?Q?VKiuEBncy7lxZKqhds1HiDQImvOMMh8BIPrY4MI/5ZXl5InIvCDjE90+aAfP?=
 =?us-ascii?Q?YAdbLX83H8GqmQtVo8p0aIy7RewuvSgk9i6ZPltN4WlXJ9QsYuT5UPJnGD+B?=
 =?us-ascii?Q?0pSjOD0JlrLkH22u0kixoVFJyzzDiH3CF9KV2SKPY1ciV9P0mh0ZsYavyAtC?=
 =?us-ascii?Q?V+8V0xxLiobL1B63HFGb7zLS4cYN8uMSOQ4gDsO4yXL5H0rbfnmxSEvruzy9?=
 =?us-ascii?Q?wIrgXu58toPJelweBHz9fOzClzc9KfXugknQDVoSh2Kyd73RdZ2XpE8JIne4?=
 =?us-ascii?Q?5eyCvchohfODeR4H9Ca2W3zmt/nt9k8l/ioetZugEnsrurSpWugY/xCG7LL4?=
 =?us-ascii?Q?qMuGOQ/ooG2fHNPJKlRaQVdPzIjNkbkKyRZ3FRw3ThnBpCEPAF4oM6ynoNr4?=
 =?us-ascii?Q?tVLVpTcVdq53qsYeHCgHBCjl+FmwKTd1qOPwM4QO5I68mGqrGyOK//anEL8g?=
 =?us-ascii?Q?09/XhGWj0dLKUalj6pOhv1e3Ym08K4wVNxBhU8zL4L65ztXriRqJCO7YOphd?=
 =?us-ascii?Q?SlAsy4EUJdJnMZ7dopZcRK14ZVmUgTN2jeLOw2zEcZaB62eg78MII62UkkO/?=
 =?us-ascii?Q?j5w4SlY9+1TFuXMBXLOhuw+p9M60Q69WFpYkuMO8jDgKEEM5bvony3TvctHe?=
 =?us-ascii?Q?5hmByfNptpby7lq4AiU0sq3r?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64835f21-14a9-4d31-9237-08d931a97f2e
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:50.4759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49I3VNZOMBhmIJKoatcySFbdYBXc7DDSfF7flt43+CmyAVDlCFFXr8pxhD3iGo4tqvhMaP2sal/iw8cbxmln8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1268
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/edca.c | 265 ++++++++++++++++++++++++
 1 file changed, 265 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/edca.c

diff --git a/drivers/net/wireless/celeno/cl8k/edca.c b/drivers/net/wireless=
/celeno/cl8k/edca.c
new file mode 100644
index 000000000000..d17a7bd674c5
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/edca.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "edca.h"
+#include "sta.h"
+#include "vendor_cmd.h"
+#include "fw/msg_tx.h"
+#include "utils/utils.h"
+
+static u8 conv_to_fw_ac[EDCA_AC_MAX] =3D {
+       [EDCA_AC_BE] =3D AC_BE,
+       [EDCA_AC_BK] =3D AC_BK,
+       [EDCA_AC_VI] =3D AC_VI,
+       [EDCA_AC_VO] =3D AC_VO
+};
+
+static const char *edca_ac_str[EDCA_AC_MAX] =3D {
+       [EDCA_AC_BE] =3D "BE",
+       [EDCA_AC_BK] =3D "BK",
+       [EDCA_AC_VI] =3D "VI",
+       [EDCA_AC_VO] =3D "VO"
+};
+
+static int cl_edca_print(struct cl_hw *cl_hw)
+{
+       u8 ac =3D 0;
+       struct edca_params *params;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "---------------------------------------\n"
+                   "| ac | aifsn | cw_min | cw_max | txop |\n"
+                   "|----+-------+--------+--------+------|\n");
+
+       for (ac =3D 0; ac < AC_MAX; ac++) {
+               params =3D &cl_hw->edca_db.hw_params[ac];
+               cl_snprintf(&buf, &len, &buf_size,
+                           "| %s | %5u | %6u | %6u | %4u |\n",
+                           edca_ac_str[ac], params->aifsn, params->cw_min,
+                           params->cw_max, params->txop);
+       }
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "---------------------------------------\n\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static void cl_edca_set_conf(struct cl_hw *cl_hw, u8 ac)
+{
+       struct edca_params params =3D {
+               .aifsn =3D cl_hw->conf->ce_wmm_aifsn[ac],
+               .cw_min =3D cl_hw->conf->ce_wmm_cwmin[ac],
+               .cw_max =3D cl_hw->conf->ce_wmm_cwmax[ac],
+               .txop =3D cl_hw->conf->ce_wmm_txop[ac]
+       };
+
+       cl_edca_set(cl_hw, ac, &params, NULL);
+}
+
+static void cl_edca_ac_set(struct cl_hw *cl_hw, u8 ac, u8 aifsn, u8 cw_min=
, u8 cw_max, u16 txop)
+{
+       pr_debug("ac =3D %u, aifsn =3D %u, cw_min =3D %u, cw_max =3D %u, tx=
op =3D %u\n",
+                ac, aifsn, cw_min, cw_max, txop);
+
+       cl_hw->conf->ce_wmm_aifsn[ac] =3D aifsn;
+       cl_hw->conf->ce_wmm_cwmin[ac] =3D cw_min;
+       cl_hw->conf->ce_wmm_cwmax[ac] =3D cw_max;
+       cl_hw->conf->ce_wmm_txop[ac] =3D txop;
+
+       cl_edca_set_conf(cl_hw, ac);
+}
+
+static void cl_edca_aifsn_set(struct cl_hw *cl_hw, s32 aifsn[AC_MAX])
+{
+       u8 ac =3D 0;
+
+       pr_debug("Set aifsn: BE =3D %d, BK =3D %d, VI =3D %d, VO =3D %d\n",
+                aifsn[0], aifsn[1], aifsn[2], aifsn[3]);
+
+       for (ac =3D 0; ac < AC_MAX; ac++) {
+               cl_hw->conf->ce_wmm_aifsn[ac] =3D (u8)aifsn[ac];
+               cl_edca_set_conf(cl_hw, ac);
+       }
+}
+
+static void cl_edca_cwmin_set(struct cl_hw *cl_hw, s32 cw_min[AC_MAX])
+{
+       u8 ac =3D 0;
+
+       pr_debug("Set cw_min: BE =3D %d, BK =3D %d, VI =3D %d, VO =3D %d\n"=
,
+                cw_min[0], cw_min[1], cw_min[2], cw_min[3]);
+
+       for (ac =3D 0; ac < AC_MAX; ac++) {
+               cl_hw->conf->ce_wmm_cwmin[ac] =3D (u8)cw_min[ac];
+               cl_edca_set_conf(cl_hw, ac);
+       }
+}
+
+static void cl_edca_cwmax_set(struct cl_hw *cl_hw, s32 cw_max[AC_MAX])
+{
+       u8 ac =3D 0;
+
+       pr_debug("Set cw_max: BE =3D %d, BK =3D %d, VI =3D %d, VO =3D %d\n"=
,
+                cw_max[0], cw_max[1], cw_max[2], cw_max[3]);
+
+       for (ac =3D 0; ac < AC_MAX; ac++) {
+               cl_hw->conf->ce_wmm_cwmax[ac] =3D (u8)cw_max[ac];
+               cl_edca_set_conf(cl_hw, ac);
+       }
+}
+
+static void cl_edca_txop_set(struct cl_hw *cl_hw, s32 txop[AC_MAX])
+{
+       u8 ac =3D 0;
+
+       pr_debug("Set txop: BE =3D %d, BK =3D %d, VI =3D %d, VO =3D %d\n",
+                txop[0], txop[1], txop[2], txop[3]);
+
+       for (ac =3D 0; ac < AC_MAX; ac++) {
+               cl_hw->conf->ce_wmm_txop[ac] =3D (u16)txop[ac];
+               cl_edca_set_conf(cl_hw, ac);
+       }
+}
+
+static int cl_edca_cli_help(struct cl_hw *cl_hw)
+{
+       char *buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+
+       if (!buf)
+               return -ENOMEM;
+
+       snprintf(buf, PAGE_SIZE,
+                "edca usage:\n"
+                "-a : Print current configuration\n"
+                "-b : Set per AC [0-BE,1-BK,2-VI,3-VO].[aifsn].[cw_min]."
+                       "[cw_max].[txop]\n"
+                "-c : Set aifsn [BE].[BK].[VI].[VO]\n"
+                "-d : Set cw_min [BE].[BK].[VI].[VO]\n"
+                "-e : Set cw_max [BE].[BK].[VI].[VO]\n"
+                "-f : Set txop  [BE].[BK].[VI].[VO]\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+void cl_edca_hw_conf(struct cl_hw *cl_hw)
+{
+       u8 ac =3D 0;
+       struct cl_tcv_conf *conf =3D cl_hw->conf;
+
+       for (ac =3D 0; ac < AC_MAX; ac++) {
+               struct edca_params params =3D {
+                       .aifsn =3D conf->ce_wmm_aifsn[ac],
+                       .cw_min =3D conf->ce_wmm_cwmin[ac],
+                       .cw_max =3D conf->ce_wmm_cwmax[ac],
+                       .txop =3D conf->ce_wmm_txop[ac]
+               };
+
+               cl_edca_set(cl_hw, ac, &params, NULL);
+       }
+}
+
+void cl_edca_set(struct cl_hw *cl_hw, u8 ac, struct edca_params *params,
+                struct ieee80211_he_mu_edca_param_ac_rec *mu_edca)
+{
+       u32 edca_reg_val =3D 0;
+
+       if (ac >=3D AC_MAX) {
+               pr_err("%s: Invalid AC index\n", __func__);
+               return;
+       }
+
+       edca_reg_val  =3D (u32)(params->aifsn);
+       edca_reg_val |=3D (u32)(params->cw_min << 4);
+       edca_reg_val |=3D (u32)(params->cw_max << 8);
+       edca_reg_val |=3D (u32)(params->txop << 12);
+
+       memcpy(&cl_hw->edca_db.hw_params[ac], params, sizeof(struct edca_pa=
rams));
+
+       cl_msg_tx_set_edca(cl_hw, conv_to_fw_ac[ac], edca_reg_val, mu_edca)=
;
+
+       cl_dbg_trace(cl_hw, "EDCA-%s: aifsn=3D%u, cw_min=3D%u, cw_max=3D%u,=
 txop=3D%u\n",
+                    edca_ac_str[ac], params->aifsn, params->cw_min, params=
->cw_max, params->txop);
+}
+
+void cl_edca_restore_conf(struct cl_hw *cl_hw, u8 ac)
+{
+       cl_edca_set_conf(cl_hw, ac);
+}
+
+void cl_edca_recovery(struct cl_hw *cl_hw)
+{
+       u8 ac;
+
+       for (ac =3D 0; ac < AC_MAX; ac++)
+               cl_edca_set(cl_hw, ac, &cl_hw->edca_db.hw_params[ac], NULL)=
;
+}
+
+int cl_edca_cli(struct cl_hw *cl_hw, struct cli_params *cli_params)
+{
+       u8 ac, aifsn, cw_min, cw_max;
+       u16 txop;
+
+       switch (cli_params->option) {
+       case 'a':
+               return cl_edca_print(cl_hw);
+       case 'b':
+               if (cli_params->num_params !=3D 5)
+                       goto err_num_of_arg;
+
+               ac =3D (u8)cli_params->params[0];
+               aifsn =3D (u8)cli_params->params[1];
+               cw_min =3D (u8)cli_params->params[2];
+               cw_max =3D (u8)cli_params->params[3];
+               txop =3D (u16)cli_params->params[4];
+
+               cl_edca_ac_set(cl_hw, ac, aifsn, cw_min, cw_max, txop);
+               break;
+       case 'c':
+               if (cli_params->num_params !=3D AC_MAX)
+                       goto err_num_of_arg;
+
+               cl_edca_aifsn_set(cl_hw, cli_params->params);
+               break;
+       case 'd':
+               if (cli_params->num_params !=3D AC_MAX)
+                       goto err_num_of_arg;
+
+               cl_edca_cwmin_set(cl_hw, cli_params->params);
+               break;
+       case 'e':
+               if (cli_params->num_params !=3D AC_MAX)
+                       goto err_num_of_arg;
+
+               cl_edca_cwmax_set(cl_hw, cli_params->params);
+               break;
+       case 'f':
+               if (cli_params->num_params !=3D AC_MAX)
+                       goto err_num_of_arg;
+
+               cl_edca_txop_set(cl_hw, cli_params->params);
+               break;
+       case '?':
+               return cl_edca_cli_help(cl_hw);
+       default:
+               cl_dbg_err(cl_hw, "Illegal option (%c) - try '?' for help\n=
", cli_params->option);
+               break;
+       }
+
+       return 0;
+
+err_num_of_arg:
+       pr_err("wrong number of arguments\n");
+       return 0;
+}
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

