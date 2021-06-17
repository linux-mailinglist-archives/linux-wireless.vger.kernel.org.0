Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D818D3AB87D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbhFQQIR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:17 -0400
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:40639
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231514AbhFQQHi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFbEGBs6xh7nlhoNjZKlqOm8Lwqwv6XEyCWfyC9G7DDybRueHFtptSyT3YuJetu7U3LzGnwBFgG8Bydpnv/aE2jz89WYGyXB4fIq/bvTnR3b911jLGet02jlEj6LPwGuGEZVX346alioXekTaAxCyn94jQSwEcKf1CUM9pc/fxbBy+CZRJbg+Np1A/Guoj4mGQHZkLgRNBjl6C9Su5fW6SZK3J2/qmPKfs67Ve9x2TknPg3D7qSL+px3Q5H66wVb2+Eq/keKz5BY5cf++ZaYA7TMRHi+Euxs9+Zk0SdmFsx4oBYd4JrY3RT3YkcSymGD7oKbfDDxGAj1U7rBq6ui/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yzLlT07y5M7FhsPFj+yKRG5er+leVVl+K+6cDg3Hyo=;
 b=WIYdB3F6B3FdgdKBESLDfKke192ul7Quy1u75d7pwn19zEhawtCf3aYPtJ3/wbgbs3pu7HuP3hEs2uFJsi8amnAAh9ZjznuFbaMWqDj3NUSx/2vkf3siKb/o2Pop27keQRwxKitQT+P633LIzSNn46gB362mTyd9s834GUS+TYy4uYQXSE7Kq9TrpWEOAxgr45fhF4FSA4LwJJ0BMjGt9SX64N7dA0Ax5iBCDgDpjRr5t4p4SC9rDwDlo6QWfVsicSdrbbJTpp02d6xSRKE9iA32r1HoVO0Cb21y9YXgfEeXdue4cqBifnTJSNjBYWBRmMT++YbqB1txhIA59gj+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yzLlT07y5M7FhsPFj+yKRG5er+leVVl+K+6cDg3Hyo=;
 b=2+shn7mAstolPCi9HbhQdqXI9Qca3JETgjwbXkT3+KTFaCI5fGME2r+eYE6TTN7GR+ZMw67/00KGczO0uTPo80V22ALsWDBiBivuztwjAwq21uHxlRBbWf6vVUOFlRVP5olPZMikjUFX8gJBGHyypHA/eBqaGfV3n+4R0lEZRUQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1268.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:04:22 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:22 +0000
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
Subject: [RFC v1 071/256] cl8k: add ela.c
Date:   Thu, 17 Jun 2021 15:59:18 +0000
Message-Id: <20210617160223.160998-72-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50d8d5a9-e88a-4aba-ff40-08d931a9806c
X-MS-TrafficTypeDiagnostic: AM9P192MB1268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB12682D68277886B82CE377EEF60E9@AM9P192MB1268.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MdRdv99scJbH/8RV5NYjbVPz2cGv2+0DO7cVObDWCeZINrB+vU0qHSpWdK7TK4oCVmoROwEqQLHS4DfQ3FQlL6Nl/q3MFHnSwfhNWyuwgvsCQsoepau4idGgkVSRT+gmIIg7k1/BimV74ockdDAO++vsf4DY52OZU3XyxyCmGuxLgaHdXhXSEoSeoEZuDSvoLsesdRsG6fad1LAWYIC5GG8f5yXJTOcUinieWzbLZ6g3EOVo04dMQkY0VmSpFQ3n0NVtfGXs0SdAmkH14NRlam0EszxRchZHPddMn1ust14cT7c9liFMh4qxzDujJ1HXTfHmdEmer+shcsfMu5nulJbgP0eN6IuKnI3T7HNPlbJUAW/pFim4/+APcc/jpYycURO29BJDrCdCirQSDhZdTResGtW2acz4RJgC+cvrS5ENQtmj3Z9/8xobluSG1KIRKQ5q3ewnuGrTKi9DzPluC3Q1yNmnKP4p/dpf6wZoMKpwgA8PO20jP852Wk7P4ruk94kVfMnRQW0rMUbsMdzB57inDKZRH4akq6K+/R11aVMLq9gr9bUrVNGgl8qoR4gKJtZelp94wh0gzZFgad2lFsd6ChSfwS8vpovjLw4foEuyEyZjHJTx81pdRK5WtjTtce1zo1SBcZhWTmtsFQV6wdDWBD5kcSxWRfmbTFcGAAhicxmNws9y1cKkNwjrgEUvHDs0/jAKaX+Yfw/kBCZhrdtTpLlFQFLiJ3uq/LNyCss=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(39850400004)(136003)(376002)(6486002)(956004)(54906003)(4326008)(2616005)(186003)(38100700002)(16526019)(8676002)(5660300002)(38350700002)(8936002)(26005)(2906002)(6512007)(9686003)(52116002)(83380400001)(6916009)(66946007)(66556008)(66476007)(86362001)(55236004)(6666004)(6506007)(1076003)(107886003)(508600001)(316002)(36756003)(69590400013)(32563001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9R00sSXjGrv9/TPYgv/j6wm4c7Ju9ij5D5KNP3J7V1S8rPK2Br+Sh5y9O4pI?=
 =?us-ascii?Q?TdrPZi4Qgf009TAEKepfKHjRKq7V9pwzdlufJV4deZ8ikHtTOsA8kvGiyMa+?=
 =?us-ascii?Q?gNkNzB2qDF9Qy9pVOFliRls+AZCxFt5HRb0hCZDbnzaMdazaEM68AoRTHIbm?=
 =?us-ascii?Q?ryaUEBqWEhgJzVigEJBpxIxXPPgsGBtP7fZTDsCLHUVJ+w3bQ1aY/uJDSF/m?=
 =?us-ascii?Q?rb4mlHB83AKvOd4/ynwWNjVsj5PhPltb6JhEJQeEBJPwR6j/Yyw+N3YLGtYC?=
 =?us-ascii?Q?glGADf9L4T5/SC19TBsH5w4Lpc8ZIzMXR+ooJuTpV/Udbjj3nEitYFL99gVK?=
 =?us-ascii?Q?oP5Kj2U0L2dC+jj6QrjXaeNWWhpwkV9xu0uBiQYc4aAeuS92PDERHWTCqU3K?=
 =?us-ascii?Q?tEixCqvzQmFM54+Q+tkEGTIcfN5iR2y+c5Ub9mjHHlBe1XqSsdfdqzm1QvIO?=
 =?us-ascii?Q?k/Xa4xW2kqmPO/xqUifbFfQo/f6EAQ1IRWHjezXx3FDjXnwWwQp1Grx5UC34?=
 =?us-ascii?Q?R2Dw5Ji/zDHZAzOXRz8GiCfSPTJjkgQGfFfqvXamj5Jkk9Qi+gINdwwbup9Y?=
 =?us-ascii?Q?BgVotB9oY08YFj04j6KXVGxYRkuGzzD05HSD+mFMyi7r9j5xIGjAzLuytkr/?=
 =?us-ascii?Q?wLZ0yDkpkRuXBR4uJEIg1pkycOgcY9WcGGROn+CQnyGt2UsXcueCxd8oaLVQ?=
 =?us-ascii?Q?0FQNXxFnvoXIExJnu7LqymxXKbUKZ40tYA5vTu3tIdP37OoRwrDlld4zmmXJ?=
 =?us-ascii?Q?kJoq4u5WoEv/YZaZIphkaahVtAMgWx6hrJZp+ejFbko51FGtD/WPOfDS/lQu?=
 =?us-ascii?Q?K4aF2ebpWwkSu9gPrN85ARcPWMLXTYxBwyZpQSOpFOSzxeX5ACo3/weKwAEt?=
 =?us-ascii?Q?V6kyRDRib0QtsBLoRdjUjd03W237yZwWwroZNsbL9ENgisW4+OtHllQ2GUBr?=
 =?us-ascii?Q?BPkPJdHVaumg2qNTzv80qpHVWMjhDM2NcFMmXibvRcFldXaUJTl+tA6ZRt0x?=
 =?us-ascii?Q?R4R0rfjcPtczYnf05cXGEOQms2MPa6JvnBiT5nVR9YpDwXN3sG99YinHK3NO?=
 =?us-ascii?Q?o8nPVpGR97Qw6lQitAvMzbHgheQzqJaT5gnO6/7R/JyXY6d/nv0Wo69f2eOh?=
 =?us-ascii?Q?xdse96I0+ZI0d7sTU+1hKDqqrCdvqSrDzmVuCCndxUAmeUDBjOhw6D8OvGc+?=
 =?us-ascii?Q?Dxx+rpdfsT7cSJGgLLrN6iDBGDBCnIanBy/2Yc6DodDC/Q0KHsFuUJQUewJB?=
 =?us-ascii?Q?3lmZG1it6AhZiCwwBcpAuC2yGk4obVi251UHgW9aLe5nJwmKYYH5YnEh3ADr?=
 =?us-ascii?Q?jBc6WGHw4XfNSyZXlFsjq1zV?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d8d5a9-e88a-4aba-ff40-08d931a9806c
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:52.4830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKG/K6pReEcN4innO5leR25pVuIpOMSkxvYeBn8GhvniqzDA30GLIAr63WDmkQXwuGRXrTmbWgr7STAvXYoDtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1268
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/ela.c | 227 +++++++++++++++++++++++++
 1 file changed, 227 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/ela.c

diff --git a/drivers/net/wireless/celeno/cl8k/ela.c b/drivers/net/wireless/=
celeno/cl8k/ela.c
new file mode 100644
index 000000000000..49f4d2d21054
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/ela.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2021, Celeno Communications Ltd. */
+
+#include "ela.h"
+#include "utils/file.h"
+#include "reg/reg_access.h"
+#include "reg/reg_lcu_common.h"
+#include "reg/reg_lcu_phy.h"
+
+#define CL_ELA_MODE_DFLT_ALIAS          "default"
+#define CL_ELA_MODE_DFLT_SYMB_LINK      "lcu_default.conf"
+#define CL_ELA_MODE_DFLT_OFF            "OFF"
+#define CL_ELA_LCU_CONF_TOKENS_CNT      3 /* cmd addr1 addr2 */
+#define CL_ELA_LCU_MEM_WRITE_CMD_STR    "mem_write"
+#define CL_ELA_LCU_MEM_WRITE_CMD_SZ     sizeof(CL_ELA_LCU_MEM_WRITE_CMD_ST=
R)
+#define CL_ELA_LCU_UNKNOWN_CMD_TYPE     0
+#define CL_ELA_LCU_MEM_WRITE_CMD_TYPE   1
+#define CL_ELA_LCU_UNKNOWN_CMD_STR      "unknown"
+
+static int __must_check get_lcu_cmd_type(char *cmd)
+{
+       if (!strncmp(CL_ELA_LCU_MEM_WRITE_CMD_STR, cmd, CL_ELA_LCU_MEM_WRIT=
E_CMD_SZ))
+               return CL_ELA_LCU_MEM_WRITE_CMD_TYPE;
+
+       return CL_ELA_LCU_UNKNOWN_CMD_TYPE;
+}
+
+static int add_lcu_cmd(struct cl_ela_db *ed, u32 type, u32 offset, u32 val=
ue)
+{
+       struct cl_lcu_cmd *cmd =3D NULL;
+
+       cmd =3D kzalloc(sizeof(*cmd), GFP_ATOMIC);
+       if (!cmd)
+               return -ENOMEM;
+
+       cmd->type =3D type;
+       cmd->offset =3D offset;
+       cmd->value =3D value;
+
+       list_add_tail(&cmd->cmd_list, &ed->cmd_head);
+
+       return 0;
+}
+
+static void remove_lcu_cmd(struct cl_lcu_cmd *cmd)
+{
+       list_del(&cmd->cmd_list);
+       kfree(cmd);
+}
+
+static void reset_stats(struct cl_ela_db *db)
+{
+       memset(&db->stats, 0, sizeof(db->stats));
+}
+
+static int load_cmds_from_buf(struct cl_chip *chip, char *buf, size_t size=
)
+{
+       struct cl_ela_db *ed =3D &chip->ela_db;
+       char *line =3D buf;
+       char cmd[STR_LEN_256B];
+       u32 type =3D CL_ELA_LCU_UNKNOWN_CMD_TYPE;
+       u32 offset =3D 0;
+       u32 value =3D 0;
+       int tokens_cnt =3D 0;
+       int ret =3D 0;
+
+       while (line && strlen(line) && (line !=3D (buf + size))) {
+               if ((*line =3D=3D '#') || (*line =3D=3D '\n')) {
+                       /* Skip comment or blank line */
+                       line =3D strstr(line, "\n") + 1;
+               } else if (*line) {
+                       tokens_cnt =3D sscanf(line, "%s %x %x\n", cmd, &off=
set, &value);
+                       cl_dbg_chip_trace(chip,
+                                         "tokens(%d):cmd(%s), offset(0x%X)=
, value(0x%X)\n",
+                                         tokens_cnt, cmd, offset, value);
+
+                       type =3D get_lcu_cmd_type(cmd);
+                       if (type =3D=3D CL_ELA_LCU_UNKNOWN_CMD_TYPE) {
+                               cl_dbg_chip_trace(chip, "Detected extra tok=
en, skipping\n");
+                               goto newline;
+                       }
+                       if (tokens_cnt !=3D CL_ELA_LCU_CONF_TOKENS_CNT) {
+                               cl_dbg_chip_err(chip,
+                                               "Tokens count is wrong! (%d=
 !=3D %d)\n",
+                                               CL_ELA_LCU_CONF_TOKENS_CNT,
+                                               tokens_cnt);
+                               ret =3D -EBADMSG;
+                               goto exit;
+                       }
+
+                       ret =3D add_lcu_cmd(ed, type, offset, value);
+                       if (ret)
+                               goto exit;
+
+newline:
+                       line =3D strstr(line, "\n") + 1;
+               }
+       }
+
+exit:
+       ed->stats.adaptations_cnt++;
+       return ret;
+}
+
+void cl_ela_lcu_reset(struct cl_chip *chip)
+{
+       lcu_common_sw_rst_set(chip, 0x1);
+       lcu_phy_lcu_sw_rst_set(chip->cl_hw_tcv0, 0x1);
+       lcu_phy_lcu_sw_rst_set(chip->cl_hw_tcv1, 0x1);
+}
+
+void cl_ela_lcu_apply_config(struct cl_chip *chip)
+{
+       struct cl_ela_db *ed =3D &chip->ela_db;
+       struct cl_lcu_cmd *cmd =3D NULL;
+
+       if (!cl_ela_lcu_is_valid_config(chip)) {
+               cl_dbg_chip_err(chip, "Active ELA LCU config is not valid\n=
");
+               return;
+       }
+
+       list_for_each_entry(cmd, &ed->cmd_head, cmd_list) {
+               cl_dbg_chip_info(chip, "Writing cmd (0x%X, 0x%X)\n",
+                                cmd->offset, cmd->value);
+               cl_reg_write_chip(chip, cmd->offset, cmd->value);
+       }
+       ed->stats.applications_cnt++;
+}
+
+bool cl_ela_is_on(struct cl_chip *chip)
+{
+       return !!strncmp(CL_ELA_MODE_DFLT_OFF, chip->conf->ce_ela_mode,
+                        sizeof(chip->conf->ce_ela_mode));
+}
+
+bool cl_ela_is_default(struct cl_chip *chip)
+{
+       return !strncmp(CL_ELA_MODE_DFLT_ALIAS, chip->conf->ce_ela_mode,
+                       sizeof(chip->conf->ce_ela_mode));
+}
+
+bool cl_ela_lcu_is_valid_config(struct cl_chip *chip)
+{
+       struct cl_ela_db *ed =3D &chip->ela_db;
+
+       return ed->error_state =3D=3D 0;
+}
+
+char *cl_ela_lcu_cmd_str(u32 type)
+{
+       if (type =3D=3D CL_ELA_LCU_MEM_WRITE_CMD_TYPE)
+               return CL_ELA_LCU_MEM_WRITE_CMD_STR;
+
+       return CL_ELA_LCU_UNKNOWN_CMD_STR;
+}
+
+char *cl_ela_lcu_config_name(struct cl_chip *chip)
+{
+       if (!cl_ela_is_on(chip))
+               return CL_ELA_MODE_DFLT_OFF;
+
+       if (cl_ela_is_default(chip))
+               return CL_ELA_MODE_DFLT_SYMB_LINK;
+
+       return chip->conf->ce_ela_mode;
+}
+
+int cl_ela_lcu_config_read(struct cl_chip *chip)
+{
+       struct cl_ela_db *ed =3D &chip->ela_db;
+       char filename[CL_FILENAME_MAX] =3D {0};
+       size_t size =3D 0;
+       int ret =3D 0;
+
+       if (!cl_ela_is_on(chip)) {
+               ret =3D -EOPNOTSUPP;
+               goto exit;
+       }
+
+       reset_stats(ed);
+
+       snprintf(filename, sizeof(filename), "%s", cl_ela_lcu_config_name(c=
hip));
+       size =3D cl_file_open_and_read(chip, filename, &ed->raw_lcu_config)=
;
+       if (!ed->raw_lcu_config) {
+               ret =3D -ENODATA;
+               goto exit;
+       }
+
+       ret =3D load_cmds_from_buf(chip, ed->raw_lcu_config, size);
+exit:
+       ed->error_state =3D ret;
+       return ret;
+}
+
+int cl_ela_init(struct cl_chip *chip)
+{
+       struct cl_ela_db *ed =3D &chip->ela_db;
+       int ret =3D 0;
+
+       if (!cl_ela_is_on(chip))
+               return 0;
+
+       INIT_LIST_HEAD(&ed->cmd_head);
+
+       ret =3D cl_ela_lcu_config_read(chip);
+       if (ret =3D=3D 0) {
+               cl_ela_lcu_reset(chip);
+               cl_ela_lcu_apply_config(chip);
+       }
+
+       return ret;
+}
+
+void cl_ela_deinit(struct cl_chip *chip)
+{
+       struct cl_ela_db *ed =3D &chip->ela_db;
+       struct cl_lcu_cmd *cmd =3D NULL, *cmd_tmp =3D NULL;
+
+       if (!cl_ela_is_on(chip))
+               return;
+
+       kfree(ed->raw_lcu_config);
+       ed->raw_lcu_config =3D NULL;
+
+       list_for_each_entry_safe(cmd, cmd_tmp, &ed->cmd_head, cmd_list)
+               remove_lcu_cmd(cmd);
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

