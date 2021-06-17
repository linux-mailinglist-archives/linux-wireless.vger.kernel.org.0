Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E9A3AB8B9
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhFQQKF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:05 -0400
Received: from mail-eopbgr30089.outbound.protection.outlook.com ([40.107.3.89]:45023
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229784AbhFQQIv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8Njrb+BdejxmZ8QgGUwz7OU+467PAyAr1qzTMDvf7lbHGZJnuq42YXR8DhU/s0AITyjkX2uCYtm+YwcFvMZ1V9cvzTI6MqXlxAvX3Cpb6qfOscNYEd6rMTyVxyZXT73HRT4ziM1c8ue4BcEZBgAAwaVr29Elj1f0TzEI1NCV63we691DIUqyN89H6n8fmZwtGe5VRr9HFzwU7Y5DAiEFgI/O4RmyEcg7EYLNKzs8FXuqhWP2S01iOs/ONlxndSunWB0I2J4mw5bK1e1UlNqBz56/BtPWjJBpLJXw84/6NG1Zgg0nrHh6iS0EquIeblzIcz+XXRY+8yjiMXfQksJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8yfS5CNsJ4N2K2Rzxc48Cu58BlScTDtxyjScsP9uD8=;
 b=Fk7kvrKqgja7eHPNqAFJqZQMS+synfV67Ot26JNFQkA0NkUespe7N3h7FAbOwQOvh1w/kAwEkFnGv3scPQfiTOrOiqi10Db2GW0InSo9s6/BhOF+PtyJrz+NoE93KmdUtKukhoEQ2JtDdRf8Fsc8T2BLpMZ9tg0tO5/wWfYDFvU5JevcD+xTIubnTQk6SGkee6XKXtX8d+hhzMBeE8Y+A12MhGf6/cP4rkrtaycgZa41dtSgiLx6F7e3kKrZDK72w1tcbRnXtwU030QmkJM92W55w0taQsOD1sTVmTHrJUBw7an4kVbnuTuNMgGkKqiQALpPOYRITZGEKn6UmCk8vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8yfS5CNsJ4N2K2Rzxc48Cu58BlScTDtxyjScsP9uD8=;
 b=A6ko0uetGWDQQUIkXGrQxKyj8njXrF8jBv2iWiN0xNdjSXzzGC8JqoW7D7/ZrSqwrLkRkGUt7jZTU/JOWozAXRdbGEZlUFGP9IYnaq/kXd146pqez4IJklWvERT+r8FSYmq9pharfX7Ng5NV5KghQxRyYBCifuo/qTkyNBYV/HY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0465.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:53 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:53 +0000
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
Subject: [RFC v1 149/256] cl8k: add reg/reg_cli.c
Date:   Thu, 17 Jun 2021 16:00:36 +0000
Message-Id: <20210617160223.160998-150-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c28c2b95-0531-4775-4680-08d931a9b381
X-MS-TrafficTypeDiagnostic: AM0P192MB0465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB046586D396384FC4A6FA12C0F60E9@AM0P192MB0465.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +1j+TM2p2BA4YFAFna36I1ruNFh38elxft6C0peboiUNXxg4aOi3oS1fbf5D6r/6+fctWX48wUTgXIwUOjjzoLJHUbUHa1FkvZwYK42t79hv1tb0FAF20K1T2PPYFoB/J6QY8wHwCJYV/35ALNZKeX6gPQHEXSOvkXaeZXRbsolLckmtOGzkDIb5x9azximU1F2V0tQ3WpNlj44FCdWsDz2LFuj4F6ZoP4Egonc+m3zEgOTQVzwjYwOyzVG1Rn1mfHhulis4wqDxGb8EomzXgFGLBN5sQe7HldUPU/drEEQVDb/+RjhqjeG9jGQ+f2RPFh+rw+UKBACFTy37cDnWLZf4H1zIE0mM2YUVB21AleVj2tQtP1LqNdO8UjBLnI+BwVIuNM58K5W8cFCS50WVUKDPhvpekSw0JJAtI9b+TtwuDhxwRG2HeJe7nvdf7vB3Vko4UL2CUUEozVB8gS9rJUSRJ6Ti4u/Wt/+nHOQffx7yGuzTSUfFBvaV8KfyJiBk2I+mgkXIryk1AdYlZTM09Fh1/AscPgIk4UM/OOyyhw6hZwUiVcJnfhMtetjLbsbWXB2nMv5pQjSQfTEh3MOtdjGXxZzqAWZLxU9q1dTj6VitzecfSwGMJd8l2y/yPVc4mPcfNG3t1mLkco3uj6NRL4dQwFcwYuc5nTHpJvdfvWYoatoPYigbey0iEf567SeSZfzxBgtJICzPQHWRmybkcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(136003)(346002)(39850400004)(55236004)(6506007)(4326008)(5660300002)(54906003)(107886003)(8936002)(86362001)(36756003)(6486002)(38100700002)(38350700002)(26005)(8676002)(2906002)(6666004)(186003)(83380400001)(316002)(1076003)(6512007)(2616005)(66946007)(66556008)(52116002)(66476007)(956004)(6916009)(508600001)(16526019)(9686003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?shBCRPjqk0h7OOO15AVS5aM7vTq3A4Mhe3e+XVrpqzY/vQpWxmihO41TWbx5?=
 =?us-ascii?Q?2p//8AWVyZDBC3nJ1KncAkGvenZlFrTbgYpmayvLytfQ/GvsS4Cy30TqiAhZ?=
 =?us-ascii?Q?HbemSEPyvpo3xGYIkXpFtOdNcN3wvv4h87NlQLd3YQIRuPGTRFtpg4wu6gRZ?=
 =?us-ascii?Q?boAaxHVM9XNwBrwk29dTxFqq40gnW97RjTLpax92tArTCC8gf6NIqv5rwYl7?=
 =?us-ascii?Q?INrF+xPlslTHCP4LoH0DW8C0E6uzunLhSnC5Ycb7AfQ2BA4OyktxcvywLQVf?=
 =?us-ascii?Q?+cuoJd2ripxqFIs+7/uNFreOz6WjEDzQ8JFBndbCAO50JSQOgHjOET6o0Hsy?=
 =?us-ascii?Q?46ZPghwJoEVsK2lxLJcbgErG0ArGBaBQG4CJVimKsAk6zF1TB24WoJ///i/r?=
 =?us-ascii?Q?gfUrwYlUWvIEonqk/8+2mRVwMDo9ev84VfdYtHpqEBFOircJrdjNr9JbWUHM?=
 =?us-ascii?Q?lJC9VH2u8LHP+F9DpG0PjaV1xzZW33FVvThNDCw+gh90rMzgeYUpJw2sXUyV?=
 =?us-ascii?Q?LA+48aVyM9M+oAwmQWpfAKRMsjIoS4tcLa3YROxU50bCwCdiS0m2ScITrkS3?=
 =?us-ascii?Q?lLdr1l0h5sw623ogAOyFBsL3MZsh0PXuc+vtNR6lgGMuqDTx1n/o1wUAvypO?=
 =?us-ascii?Q?UgHndqFWIL36cLbypSf+md6Dw2m6LJMnN2fX9vg4yMFCAfYOGnI8Qjv9uKmG?=
 =?us-ascii?Q?tzHyV6xlw7wAKCMkpZYVd5XWZQVHqgJsCOVJG0v5BM+E1XLUDlufWaHjIiGk?=
 =?us-ascii?Q?3sKQoZ2gtoHgw5kqfkxyDDF08gfsSY5UAs64t/14zWDEF+fx0Bov6fpud/27?=
 =?us-ascii?Q?8I0z/Gfo/MuUrxpnm13bXIrHcEYXvHz47kUSdUsY6jrNBJsPzVLkaNw6ZmEk?=
 =?us-ascii?Q?9UkugdYcdsAE5/GsDvWxKNB84Ej4DyrWciqC0AxBnIjBGxAVAeF/KZnx7YVO?=
 =?us-ascii?Q?nKSVwI5n3hS6CDQdZIYJeRdC4QXf/AAkzZqQ12LEgNohbTznH9omGuLTSAFS?=
 =?us-ascii?Q?Bv9VOOgp1UKSAi7QYpZNB/s9lio+C+PpgIyf/e/EyjlJlWrfQAPKH8FcajIA?=
 =?us-ascii?Q?uBWloMtEZd7u8xLEFrkOxK3LH9+irURzPg0jDTq6TFlNcN2MBi/Bx02mLYWo?=
 =?us-ascii?Q?Qn5Bnf12sVU+FcUhYBHlYWmiTmD4a6FPAvtEmWxSGPWnYMmHTwsWi6EdWhYS?=
 =?us-ascii?Q?DHKKtId4Fzc77uTJ1DrTnZGGJI7PhW1cgkAxC4cyUkznKsmesKEftxhqBTW0?=
 =?us-ascii?Q?BKrZpmnqyuUAlPLfiBjmUwWzfQNT5pD56QZ+ME/B8cvvEX5VPYN4zQRcktok?=
 =?us-ascii?Q?O1N6Jop37ZH9jfzxUCuH6tR7?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c28c2b95-0531-4775-4680-08d931a9b381
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:18.2255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcWKdFz0UP2TqtE/OHeP1xB+vcVP1nQ2PDydyahLdcZdEd9WdgZFvR3xLkqPQzGbY9gFlO02CCxE0Ofm+U5iag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0465
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/reg/reg_cli.c    | 277 ++++++++++++++++++
 1 file changed, 277 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_cli.c

diff --git a/drivers/net/wireless/celeno/cl8k/reg/reg_cli.c b/drivers/net/w=
ireless/celeno/cl8k/reg/reg_cli.c
new file mode 100644
index 000000000000..2293b09c0da9
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/reg/reg_cli.c
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "reg/reg_cli.h"
+#include "reg/reg_access.h"
+#include "reg/reg_modem_gcu.h"
+
+/*
+ * iwcl command to read registers and write to registers:
+ * iwcl <iface> cecli reg.-r.<reg_addr>
+ * iwcl <iface> cecli reg.-w.<reg_addr>.<reg_value>
+ * iwcl <iface> cecli reg.-m.<reg_addr>.<reg_value>.<reg_mask>
+ * iwcl <iface> cecli reg.-x.<type>.<offset>.<value>
+ * iwcl <iface> cecli reg.-y.<type>.<offset>
+ * iwcl <iface> cecli reg.-z.<type>.<offset>.<value>.<mask>
+ * reg_value should not include PCI base address
+ * The advantage of using iwcl command instead of mem command is
+ * that with using the iwcl command the relevant registers will
+ * be added to the recovery procedure.
+ */
+
+static int cl_reg_cli_write_mask(struct cl_hw *cl_hw, u32 address, u32 val=
ue, u32 mask)
+{
+       char reply_str[7] =3D {0};
+       u16 reply_strlen =3D 0;
+       int ret =3D cl_reg_write_mask(cl_hw, address, value, mask);
+
+       cl_dbg_verbose(cl_hw, "WRITE: Address =3D 0x%x, Value =3D 0x%x, Mas=
k =3D 0x%x\n",
+                      address, value, mask);
+       reply_strlen =3D snprintf(&reply_str[0], sizeof(reply_str), "ret=3D=
%d", ret);
+
+       return cl_vendor_reply(cl_hw, reply_str, reply_strlen);
+}
+
+static int cl_reg_cli_read(struct cl_hw *cl_hw, u32 address)
+{
+       u32 value =3D cl_reg_read(cl_hw, address);
+       char reply_str[11] =3D {0};
+       u16 reply_strlen =3D 0;
+
+       reply_strlen =3D snprintf(&reply_str[0], sizeof(reply_str), "0x%08x=
", value);
+
+       return cl_vendor_reply(cl_hw, reply_str, reply_strlen);
+}
+
+static void cl_reg_cli_read_block(struct cl_hw *cl_hw, u32 first_address, =
u32 last_address)
+{
+       u32 address =3D first_address;
+       u32 value;
+
+       if ((first_address & 0x3) !=3D 0) {
+               pr_err("Invalid first address - 0x%x\n", first_address);
+               return;
+       }
+
+       if ((last_address & 0x3) !=3D 0) {
+               pr_err("Invalid last address - 0x%x\n", last_address);
+               return;
+       }
+
+       if (first_address > last_address) {
+               pr_err("Invalid addresses - first [0x%x] > last [0x%x]\n",
+                      first_address, last_address);
+               return;
+       }
+
+       pr_debug("-------------------------\n");
+       pr_debug("| Address  | Value      |\n");
+       pr_debug("|----------+------------|\n");
+
+       while (address <=3D last_address) {
+               value =3D cl_reg_read(cl_hw, address);
+               pr_debug("| 0x%06x | 0x%08x |\n", address, value);
+               address +=3D 4;
+       }
+
+       pr_debug("-------------------------\n");
+}
+
+static int cl_reg_cli_write(struct cl_hw *cl_hw, u32 address, u32 value)
+{
+       char reply_str[7] =3D {0};
+       u16 reply_strlen =3D 0;
+       int ret =3D cl_reg_write(cl_hw, address, value);
+
+       cl_dbg_verbose(cl_hw, "WRITE: Address =3D 0x%x, Value =3D 0x%x\n", =
address, value);
+       reply_strlen =3D snprintf(&reply_str[0], sizeof(reply_str), "ret=3D=
%d", ret);
+
+       return cl_vendor_reply(cl_hw, reply_str, reply_strlen);
+}
+
+static int cl_reg_cli_write_type(struct cl_hw *cl_hw, u32 type, u32 offset=
, u32 value)
+{
+       if (type =3D=3D 0) /* GCU */
+               cl_reg_write_direct(cl_hw, REG_MODEM_GCU_BASE_ADDR + offset=
, value);
+       else /* RIU */
+               cl_reg_write_direct(cl_hw, REG_RIU_BASE_ADDR + offset, valu=
e);
+
+       return 0;
+}
+
+static int cl_reg_cli_read_type(struct cl_hw *cl_hw, u32 type, u32 offset)
+{
+       u32 base =3D (type =3D=3D 0) ? REG_MODEM_GCU_BASE_ADDR : REG_RIU_BA=
SE_ADDR;
+
+       return cl_reg_cli_read(cl_hw, base + offset);
+}
+
+static int cl_reg_cli_write_type_mask(struct cl_hw *cl_hw, u32 type, u32 o=
ffset,
+                                     u32 value, u32 mask)
+{
+       if (type =3D=3D 0) /* GCU */
+               cl_reg_write_mask(cl_hw, REG_MODEM_GCU_BASE_ADDR + offset, =
value, mask);
+       else /* RIU */
+               cl_reg_write_mask(cl_hw, REG_RIU_BASE_ADDR + offset, value,=
 mask);
+
+       return 0;
+}
+
+static int cl_reg_cli_set_debug(struct cl_hw *cl_hw, bool enable)
+{
+       if (enable) {
+               cl_hw->reg_dbg =3D true;
+               cl_hw->chip->reg_dbg |=3D (1 << cl_hw->tcv_idx);
+       } else {
+               cl_hw->reg_dbg =3D false;
+               cl_hw->chip->reg_dbg &=3D ~(1 << cl_hw->tcv_idx);
+       }
+
+       return 0;
+}
+
+static int cl_reg_cli_help(struct cl_hw *cl_hw)
+{
+       char *buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+
+       if (!buf)
+               return -ENOMEM;
+
+       snprintf(buf, PAGE_SIZE,
+                "reg usage:\n"
+                "-d : Set debug [0:Disable|1:Enable]\n"
+                "-m : Write masked value to address [address].[value].[mas=
k]\n"
+                "-r : Read address [address]\n"
+                "-s : Read block [first address].[last address]\n"
+                "-w : Write value to address [address].[value]\n"
+                "-x : Write type [0:GCU|1:RIU][offset].[value]\n"
+                "-y : Read type [0:GCU|1:RIU][offset]\n"
+                "-z : Write type mask [0:GCU|1:RIU][offset].[value].[mask]=
\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+int cl_reg_cli(struct cl_hw *cl_hw, struct cli_params *cli_params)
+{
+       u32 expected_params =3D 0;
+       bool set_debug =3D false;
+       bool reg_write_mask =3D false;
+       bool reg_read =3D false;
+       bool reg_read_block =3D false;
+       bool reg_write =3D false;
+       bool reg_write_type =3D false;
+       bool reg_read_type =3D false;
+       bool reg_write_type_mask =3D false;
+
+       switch (cli_params->option) {
+       case 'd':
+               set_debug =3D true;
+               expected_params =3D 1;
+               break;
+       case 'm':
+               reg_write_mask =3D true;
+               expected_params =3D 3;
+               break;
+       case 'r':
+               reg_read =3D true;
+               expected_params =3D 1;
+               break;
+       case 's':
+               reg_read_block =3D true;
+               expected_params =3D 2;
+               break;
+       case 'w':
+               reg_write =3D true;
+               expected_params =3D 2;
+               break;
+       case 'x':
+               reg_write_type =3D true;
+               expected_params =3D 3;
+               break;
+       case 'y':
+               reg_read_type =3D true;
+               expected_params =3D 2;
+               break;
+       case 'z':
+               reg_write_type_mask =3D true;
+               expected_params =3D 4;
+               break;
+       case '?':
+               return cl_reg_cli_help(cl_hw);
+       default:
+               cl_dbg_err(cl_hw, "Illegal option (%c) - try '?' for help\n=
", cli_params->option);
+               goto out_err;
+       }
+
+       if (expected_params !=3D cli_params->num_params) {
+               cl_dbg_err(cl_hw, "Wrong number of arguments (expected %u) =
(actual %u)\n",
+                          expected_params, cli_params->num_params);
+               goto out_err;
+       }
+
+       if (set_debug) {
+               u32 enable =3D cli_params->params[0];
+
+               return cl_reg_cli_set_debug(cl_hw, enable);
+       }
+
+       if (reg_write_mask) {
+               u32 address =3D cli_params->params[0];
+               u32 value =3D cli_params->params[1];
+               u32 mask =3D cli_params->params[2];
+
+               return cl_reg_cli_write_mask(cl_hw, address, value, mask);
+       }
+
+       if (reg_read) {
+               u32 address =3D cli_params->params[0];
+
+               return cl_reg_cli_read(cl_hw, address);
+       }
+
+       if (reg_read_block) {
+               u32 first_address =3D cli_params->params[0];
+               u32 last_address =3D cli_params->params[1];
+
+               cl_reg_cli_read_block(cl_hw, first_address, last_address);
+               return 0;
+       }
+
+       if (reg_write) {
+               u32 address =3D cli_params->params[0];
+               u32 value =3D cli_params->params[1];
+
+               return cl_reg_cli_write(cl_hw, address, value);
+       }
+
+       if (reg_write_type) {
+               u32 type =3D cli_params->params[0];
+               u32 offset =3D cli_params->params[1];
+               u32 value =3D cli_params->params[2];
+
+               return cl_reg_cli_write_type(cl_hw, type, offset, value);
+       }
+
+       if (reg_read_type) {
+               u32 type =3D cli_params->params[0];
+               u32 offset =3D cli_params->params[1];
+
+               return cl_reg_cli_read_type(cl_hw, type, offset);
+       }
+
+       if (reg_write_type_mask) {
+               u32 type =3D cli_params->params[0];
+               u32 offset =3D cli_params->params[1];
+               u32 value =3D cli_params->params[2];
+               u32 mask =3D cli_params->params[3];
+
+               return cl_reg_cli_write_type_mask(cl_hw, type, offset, valu=
e, mask);
+       }
+
+out_err:
+       return -EIO;
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

