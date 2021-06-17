Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FE83AB84C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhFQQGU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:20 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:35841
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233597AbhFQQGE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:06:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKMIiw7jLJIvXPckK7lnBFVv/bwEY+qn+YYq6IioOtH9xPozAYWJdhL05mQAw/ln/jwkD6ldyGnvjRreo/hHrk65JyiQsFImYeOBOVXKfekVm/0WF2/KydScZI/OAijhl55gsgfKbm9d/T1snBGjRqna1wyJWyg+atnIwZn4BQeyRO/lB8hGXF21VrJUHiJEfK6OYmhN1VLmwZJAwjt7zTBR+CNU236ENcrC+XmAuoFtuAw3d1K6JWHeeoNhaIjjshSRVHDplyHD2ZYg9/3PTP3vWNkNqLW5wQTd0qw0o4OzLIpC1kWPkpwkBN4wkAA6DFVmgOk4O2hpbSb4BxRLdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFjf+DYAjxlVBIhAANTC1tszlf7rV6jiH0RMoHRk+VM=;
 b=mk8UidXYlqByo1TMXUo8xW5x8vd8WDrbRmVC/zdbDYZTSPWXMVPtl4x4ZClBAfK9/aNt8fq8RrXJTeQmlQlLY4QC7zhX0rJWzIBHsuF/fubZAWHRlbdbJa1leLDzDwqN513Yn+hH1eX4uNwmVJNZYrhyrpa/5TXn5+QmvM7BmDSHMRENCyuYAq0RS7gF42dK1gaxuY2yL3baNA68aKQibeLUYlLOvn0MMavzoUUFuebS9YvZOgldkypcI5wznOAaDFopQq5ZkHMGCx5EqXuzTrFII8cIxH7Pt6lTa9DM0PM2mzNmrF8UFm3B1q4040p4781nRjSofbz896x3TNv3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFjf+DYAjxlVBIhAANTC1tszlf7rV6jiH0RMoHRk+VM=;
 b=CoxidsrbfrneGxuVxQLwnwW5x12BXLoDq/ia7zXAtDT81hXK4MGzNSVC1epjc6CsC3biza1BtpvmmLapX6TAzH+rBYJmmFmGvYp/8yzuPZifo1FgaNUwmJAUdWsLgZIeJbjWaIoQk04QY2y9oHJb2kfYIEwI8sczYvhPX97mYdo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0499.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:03:47 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:46 +0000
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
Subject: [RFC v1 055/256] cl8k: add debugfs.c
Date:   Thu, 17 Jun 2021 15:59:02 +0000
Message-Id: <20210617160223.160998-56-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11e99562-bb93-4e11-ddff-08d931a9756a
X-MS-TrafficTypeDiagnostic: AM0P192MB0499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB04993D4AAF81CE40DB78DC60F60E9@AM0P192MB0499.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:134;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWakKtbllIgg97XCA+syR/Rx71oDKu+d+KDaglFr7NboryR5eS+69Dqzl5CrTGjxluRs+VSIHY/yL8iPF7bPcih0rLz9ldWmwELgpX/MZeaXG6hNgNPkpfsLQsEormTnCmAtpa8rgYjx1+MZgL2iwQRnLjJsfuRCj6Mqt+bFN3lE+LGDNPFjwG5XxtvaROF7+F/9R0VBmJp4Rd2k7lffW6BfNLT7w3Os1PCKvIXDqgDpBjVl2OYAA2Ln+PrCGma8ZyeA50OTrAqSLKQsf/d4vcGPYSxrJ1Xl2FIA+x5tY5sOvKB9gWvb9m7OB6eyRMhk5/XNwBuG0j+8FuASpKmo753AEGJT0HaWVk+m3nFJYuYReb7sk4Ft0yGy3CN1RRhlpRkbrpHGfV9OrjHWFq2mlKFddWGk4EwCJX1J3DGY5h9rmeeQ4b2/RXCiNEwUxFEW5pTF4YTtwopK/e/w1bddjreYsPG6dhvyzr/kXD1pxnDZ1j3TR7cg0lf5IHMIzF2FmlLtrGYgA2UIGFewJ9GZK7j0cYq5cmNBwCNjhId7GnrS1AbtFRjSbzq8Bev83ZemnB7Zwzxvu2PR0wcnM7f6QYkSW4RaAiByAZF9SibAqNqHhCgiFb82v/pGL6tiIxEibw7jBPJNvqjexjcCJY7XSbZ3zL56AW/rfISOj+0jvobafyINDWcfoSUv+1KzK9HnHBN3wvx9jTjW0CuSMqf9Hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(86362001)(107886003)(66556008)(52116002)(83380400001)(55236004)(36756003)(4326008)(186003)(16526019)(956004)(316002)(6486002)(8676002)(54906003)(38100700002)(38350700002)(66476007)(6506007)(2906002)(26005)(9686003)(6512007)(66946007)(2616005)(5660300002)(478600001)(30864003)(1076003)(6666004)(8936002)(6916009)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KeXPvXiqbjngMyfIRNASvNDgAUIkUje0Etpn1H3ztiH8ol+r3JHgn0qgw5+M?=
 =?us-ascii?Q?AX7dm36wAfTJjicMrlAO5eYgPZC5XdrTfyGRxcnLnRHPVQROywy0kdDj/TOg?=
 =?us-ascii?Q?Y+mYW2cXa3NQGkcsSurLdkO+cBhVtip7vKHxCflv0vs7UktJE8kuC6byv+1r?=
 =?us-ascii?Q?r5AuG901oiz2lbJAJQemvC+j3w6+d9ClrIsHDjfhOwhAlzglokAjVAlyDyYp?=
 =?us-ascii?Q?CdNFF9NBXMZvn87WtHZxWL2MHg0N6XeFs/j3tycL3jB8FxM3Mf869F0XeytS?=
 =?us-ascii?Q?PDzUoyJ0d7vnINHXkbq2fZpXewNwa2N28HOhD4+DtFqBJmA7pdZdyd8Lrm9u?=
 =?us-ascii?Q?9SjaHn/3+CUTq0+0xMVfnQAqxL+tSgAaNcIpGkjoGzXOTyA6ttkNMjjejMla?=
 =?us-ascii?Q?5DcXd1QT9rVF6He0937t0TFV02ov0pmqW8Nf/OIuSqbeXnUQ04dFFidCuAge?=
 =?us-ascii?Q?rsP4f0C+dZ93JS73HCCTKMijNAYaR8lkKjt8Dke3Ni1xfqts/92CK2IO4dV9?=
 =?us-ascii?Q?TGXy/gQsgqa5Ds2LN/5QKhHCTMBQTBC/VjWFjeJZzYjac4qXQ8NG4o3wFatT?=
 =?us-ascii?Q?EUbScFbvnuSiPhIIs7uO64fMA/pyElXEswwOSSXhVBEK0yk+NKgCEqwvOS2U?=
 =?us-ascii?Q?EJDb9vTjx5r9m90WQZfs/PRDXnF6t1a4sQSt2bho3xeeNBUQzPBbVc1HQoJE?=
 =?us-ascii?Q?UIKsMoGsjvnjPzOs0TgE/SZ9iqBy4lor0qw4OOjXs9LeZM+TelTIrmj5zoga?=
 =?us-ascii?Q?LkyLoNMZBa+VFds4EjHelQfwbJblWmzMISqu1RVIz0//WvwuqL4D48nBX+ga?=
 =?us-ascii?Q?ShhNEmjRxnQfmHl4uBse+GwyINr/U+MTwU+weVvbbC5JvIODFOhtW3KV8LwO?=
 =?us-ascii?Q?fPGjoflqNBy70Kx0KpHyO8ofTKb3MUIh/sO4mHuyZ7KVVLNTBDh6SFvRm4kA?=
 =?us-ascii?Q?VaipnnKjMRXHRl18V53EfHBLKPVDHy5C0CW20UjP+LRfHwGMdGYyCLgFYcgo?=
 =?us-ascii?Q?zM2KagS1J7Y6XulwYMrgL6WtvFJt/tmy7cm6HL4wVRFEuh6b8U6DRRcHtfE8?=
 =?us-ascii?Q?DQ3PVmhaPTk6ouKij1OfPYi2zqupZECuOhUoXrxQ/pXfUYCWekqNJynkbNOt?=
 =?us-ascii?Q?Rv/2GDZRDRk9Ln3qCTQ0TbsD6WQnAGF15GDcFqTxjSv/RCGlweuMxRrSDiZQ?=
 =?us-ascii?Q?/qYEzt9+fb3Z2lQja8ixgMPouH0yV9OeBhczVul+MoLYT8g+Fkdo7gvhEzkr?=
 =?us-ascii?Q?FIsjlyTWxZnv+2XkKPCQtWNclcM2EeQGk1pSv0cxMOS+W9ev/5Q4tznQteG0?=
 =?us-ascii?Q?hDcltalTZgas3zvFuqtmXSc/?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e99562-bb93-4e11-ddff-08d931a9756a
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:34.1406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g71XXjlENQ5fd8aVSyVgjbMgZP7dwzlAef2YO0pr5RJw98XltxpETIhnJVe5TMHUQc/39lcyBtB5VREqpWm5pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0499
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/debugfs.c | 957 +++++++++++++++++++++
 1 file changed, 957 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/debugfs.c

diff --git a/drivers/net/wireless/celeno/cl8k/debugfs.c b/drivers/net/wirel=
ess/celeno/cl8k/debugfs.c
new file mode 100644
index 000000000000..79854dfd85ea
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/debugfs.c
@@ -0,0 +1,957 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/kmod.h>
+#include <linux/debugfs.h>
+#include <linux/string.h>
+#include <linux/list.h>
+
+#include "debugfs.h"
+#include "chip.h"
+#include "fw/msg_tx.h"
+#include "fw/msg_cfm.h"
+#include "tx/tx.h"
+#include "rate_ctrl.h"
+#include "utils/utils.h"
+#include "coredump.h"
+#include "fw/fw_dbg.h"
+#include "dbgfile.h"
+
+#define DEBUGFS_ADD_FILE(name, parent, mode)                              =
            \
+do {                                                                      =
            \
+       if (!debugfs_create_file(#name, mode, parent, cl_hw, &cl_dbgfs_##na=
me##_ops)) \
+               goto err;                                                  =
           \
+} while (0)
+
+/* File operation */
+#define DEBUGFS_READ_FUNC(name)                                  \
+       static ssize_t cl_dbgfs_##name##_read(struct file *file, \
+                       char __user *user_buf,                   \
+                       size_t count, loff_t *ppos)
+
+#define DEBUGFS_WRITE_FUNC(name)                                  \
+       static ssize_t cl_dbgfs_##name##_write(struct file *file, \
+                       const char __user *user_buf,              \
+                       size_t count, loff_t *ppos)
+
+#define DEBUGFS_READ_FILE_OPS(name)                                   \
+       DEBUGFS_READ_FUNC(name);                                      \
+       static const struct file_operations cl_dbgfs_##name##_ops =3D { \
+               .read   =3D cl_dbgfs_##name##_read,                     \
+               .open   =3D simple_open,                                \
+               .llseek =3D generic_file_llseek,                        \
+       }
+
+#define DEBUGFS_WRITE_FILE_OPS(name)                                  \
+       DEBUGFS_WRITE_FUNC(name);                                     \
+       static const struct file_operations cl_dbgfs_##name##_ops =3D { \
+               .write  =3D cl_dbgfs_##name##_write,                    \
+               .open   =3D simple_open,                                \
+               .llseek =3D generic_file_llseek,                        \
+       }
+
+#define DEBUGFS_READ_WRITE_FILE_OPS(name)                             \
+       DEBUGFS_READ_FUNC(name);                                      \
+       DEBUGFS_WRITE_FUNC(name);                                     \
+       static const struct file_operations cl_dbgfs_##name##_ops =3D { \
+               .write  =3D cl_dbgfs_##name##_write,                    \
+               .read   =3D cl_dbgfs_##name##_read,                     \
+               .open   =3D simple_open,                                \
+               .llseek =3D generic_file_llseek,                        \
+       }
+
+static ssize_t cl_dbgfs_set_debug_write(struct file *file,
+                                       const char __user *user_buf,
+                                       size_t count,
+                                       loff_t *ppos)
+{
+       struct cl_hw *cl_hw =3D file->private_data;
+       struct cl_tcv_conf *conf =3D cl_hw->conf;
+       char buf[32];
+       char *usage_str =3D "Usage:\n"
+                         "echo [mod_filter] > set_debug\n";
+       unsigned long long mod_filter;
+       int ret;
+       int eobuf =3D min_t(size_t, sizeof(buf) - 1, count);
+
+       buf[eobuf] =3D '\0';
+       if (copy_from_user(&buf, user_buf, eobuf))
+               return -EFAULT;
+
+       ret =3D kstrtoull(buf, 0, &mod_filter);
+       if (ret) {
+               cl_dbg_verbose(cl_hw, "%s", usage_str);
+               return ret;
+       }
+
+       cl_dbg_verbose(cl_hw, "Send to FW: dbg_module=3D0x%x, dbg_severity=
=3D%u, mod_filter=3D0x%x\n",
+                      conf->ci_fw_dbg_module, conf->ci_fw_dbg_severity, (u=
32)mod_filter);
+
+       ret =3D cl_msg_tx_dbg_set_ce_mod_filter(cl_hw, conf->ci_fw_dbg_modu=
le);
+       if (ret)
+               return ret;
+
+       ret =3D cl_msg_tx_dbg_set_sev_filter(cl_hw, conf->ci_fw_dbg_severit=
y);
+       if (ret)
+               return ret;
+
+       ret =3D cl_msg_tx_dbg_set_mod_filter(cl_hw, mod_filter);
+       if (ret)
+               return ret;
+
+       return 0;
+}
+
+DEBUGFS_WRITE_FILE_OPS(set_debug);
+
+static ssize_t cl_dbgfs_tx_trace_debug_flag_write(struct file *file,
+                                                 const char __user *user_b=
uf,
+                                                 size_t count,
+                                                 loff_t *ppos)
+{
+       struct cl_hw *cl_hw =3D file->private_data;
+       char buf[32];
+       int ret;
+       unsigned long long result;
+       u8 read_write_cmd;
+       char *sptr, *token;
+       char *usage_str =3D "Usage: echo  [w\\r] [value] > tx_trace_debug_f=
lag\n";
+       int eobuf =3D min_t(size_t, sizeof(buf) - 1, count);
+
+       buf[eobuf] =3D '\0';
+       if (copy_from_user(&buf, user_buf, eobuf)) {
+               cl_dbg_err(cl_hw, "illegal input\n %s", usage_str);
+               return -EFAULT;
+       }
+       sptr =3D buf;
+       token =3D strsep(&sptr, " ");
+       if (!token) {
+               cl_dbg_err(cl_hw, "illegal input\n %s", usage_str);
+               return -EINVAL;
+       }
+
+       if (!strncasecmp(token, "w", strlen("w"))) {
+               read_write_cmd =3D 1;
+               ret =3D kstrtoull(sptr, 0, &result);
+               if (ret) {
+                       cl_dbg_err(cl_hw, "illegal input\n %s", usage_str);
+                       return ret;
+               }
+               cl_dbg_trace(cl_hw, "(write value=3D0x%x)\n", (u32)result);
+       } else if (!strncasecmp(token, "r", strlen("r"))) {
+               read_write_cmd =3D 0;
+               result =3D 0;
+               cl_dbg_trace(cl_hw, "(read)\n");
+       } else {
+               cl_dbg_err(cl_hw, "illegal input\n %s", usage_str);
+               return -EFAULT;
+       }
+
+       ret =3D cl_msg_tx_dbg_tx_trace_debug_flag(cl_hw, (u32)result, (u8)r=
ead_write_cmd);
+
+       return count;
+}
+
+DEBUGFS_WRITE_FILE_OPS(tx_trace_debug_flag);
+
+static ssize_t cl_dbgfs_test_mode_write(struct file *file,
+                                       const char __user *user_buf,
+                                       size_t count,
+                                       loff_t *ppos)
+{
+       struct cl_hw *cl_hw =3D file->private_data;
+       char buf[32];
+       int ret;
+       unsigned long long params[TEST_MODE_PARAM_MAX + 1] =3D {0};
+       u32 test_params[TEST_MODE_PARAM_MAX + 1] =3D {0};
+       char *usage_str =3D "Usage:\n"
+                         "debugfsh <chip> <tcv> test_mode <command> <param=
s> <params> ..\n";
+       char *token, *sptr;
+       int eobuf =3D min_t(size_t, sizeof(buf) - 1, count);
+       int i =3D 0;
+
+       buf[eobuf] =3D '\0';
+       if (copy_from_user(&buf, user_buf, eobuf)) {
+               cl_dbg_err(cl_hw, "string %s count %zu eobuf %d\n", buf, co=
unt, eobuf);
+               return -EFAULT;
+       }
+       sptr =3D buf;
+       token =3D strsep(&sptr, " ");
+
+       for (i =3D 0; i < TEST_MODE_PARAM_MAX + 1; i++) {
+               if (token) {
+                       ret =3D kstrtoull(token, 0, &params[i]);
+                       if (ret) {
+                               cl_dbg_trace(cl_hw, "Token %s illegal conve=
rt %s\n",
+                                            token, usage_str);
+                               return ret;
+                       }
+                       test_params[i] =3D (u32)params[i];
+                       cl_dbg_trace(cl_hw, "param[%d]=3D%llu\n", i, params=
[i]);
+               } else {
+                       break;
+               }
+               token =3D strsep(&sptr, " ");
+       }
+
+       ret =3D cl_msg_tx_dbg_test_mode(cl_hw, test_params);
+
+       return count;
+}
+
+DEBUGFS_WRITE_FILE_OPS(test_mode);
+
+static ssize_t cl_dbgfs_fixed_rate_write(struct file *file,
+                                        const char __user *user_buf,
+                                        size_t count,
+                                        loff_t *ppos)
+{
+       struct cl_hw *cl_hw =3D file->private_data;
+       char buf[32];
+       int ret;
+       unsigned long long mcs =3D 0, bw =3D 0, gi =3D 0, format =3D 0, ltf=
_field =3D 0,
+               pre_type_or_stbc =3D 0, sta_idx =3D 0xff;
+       char *sptr, *token1, *token2, *token3, *token4, *token5, *token6, *=
token7;
+       char *usage_str =3D "Usage:\n"
+                         "echo [mcs] [bw] [gi] [format] [ltf_field] [pre_t=
ype_or_stbc(opt)] "
+                         "[sta_idx(opt)] > fixed_rate\n";
+       u8 op_mode =3D RATE_OP_MODE_FIXED;
+       int eobuf =3D min_t(size_t, sizeof(buf) - 1, count);
+       union cl_rate_ctrl_info rate_ctrl;
+       union cl_rate_ctrl_info_he rate_ctrl_he;
+
+       buf[eobuf] =3D '\0';
+       if (copy_from_user(&buf, user_buf, eobuf)) {
+               cl_dbg_err(cl_hw, "illegal input\n %s", usage_str);
+               return -EFAULT;
+       }
+
+       sptr =3D buf;
+
+       /* Token1 - mcs */
+       token1 =3D strsep(&sptr, " ");
+       if (!token1) {
+               cl_dbg_err(cl_hw, "token1 illegal %s\n", usage_str);
+               return -EINVAL;
+       }
+
+       ret =3D kstrtoull(token1, 0, &mcs);
+       if (ret) {
+               cl_dbg_err(cl_hw, "token1 %s illegal convert %s\n", token1,=
 usage_str);
+               return ret;
+       }
+
+       /* Token2 - bw */
+       token2 =3D strsep(&sptr, " ");
+       if (!token2) {
+               cl_dbg_err(cl_hw, "token2 illegal %s\n", usage_str);
+               return -EINVAL;
+       }
+
+       ret =3D kstrtoull(token2, 0, &bw);
+       if (ret) {
+               cl_dbg_err(cl_hw, "token2 %s illegal convert %s\n", token2,=
 usage_str);
+               return ret;
+       }
+
+       /* Token3 - gi */
+       token3 =3D strsep(&sptr, " ");
+       if (!token3) {
+               cl_dbg_err(cl_hw, "token3 illegal %s\n", usage_str);
+               return -EINVAL;
+       }
+
+       ret =3D kstrtoull(token3, 0, &gi);
+       if (ret) {
+               cl_dbg_err(cl_hw, "token3 %s illegal convert %s\n", token3,=
 usage_str);
+               return ret;
+       }
+
+       /* Token4 - format */
+       token4 =3D strsep(&sptr, " ");
+       if (!token4) {
+               cl_dbg_err(cl_hw, "token4 illegal %s\n", usage_str);
+               return -EINVAL;
+       }
+
+       ret =3D kstrtoull(token4, 0, &format);
+       if (ret) {
+               cl_dbg_err(cl_hw, "token4 %s illegal convert %s\n", token4,=
 usage_str);
+               return ret;
+       }
+
+       /* Token5 - ltf_field */
+       token5 =3D strsep(&sptr, " ");
+       if (!token5) {
+               cl_dbg_err(cl_hw, "token5 illegal %s\n", usage_str);
+               return -EINVAL;
+       }
+
+       ret =3D kstrtoull(token5, 0, &ltf_field);
+       if (ret) {
+               cl_dbg_err(cl_hw, "token5 %s illegal convert %s\n", token5,=
 usage_str);
+               return ret;
+       }
+
+       /* Token6 - pre_type_or_stbc (optional) */
+       token6 =3D strsep(&sptr, " ");
+       if (token6) {
+               ret =3D kstrtoull(token6, 0, &pre_type_or_stbc);
+               if (ret) {
+                       cl_dbg_err(cl_hw, "token6 %s illegal convert %s\n",=
 token6, usage_str);
+                       return ret;
+               }
+       }
+
+       /* Token7 - sta_idx (optional) */
+       token7 =3D strsep(&sptr, " ");
+       if (token7) {
+               ret =3D kstrtoull(token7, 0, &sta_idx);
+               if (ret) {
+                       cl_dbg_err(cl_hw, "token7 %s illegal convert %s\n",=
 token7, usage_str);
+                       return ret;
+               }
+       }
+
+       /* Sanity tests */
+       if (sta_idx !=3D STA_IDX_INVALID && !cl_sta_is_assoc(cl_hw, sta_idx=
)) {
+               cl_dbg_err(cl_hw, "Invalid station index [%llu]\n", sta_idx=
);
+               return -EINVAL;
+       }
+
+       if (format > FORMATMOD_HE_SU) {
+               cl_dbg_err(cl_hw, "Invalid format [%llu]\n", format);
+               return -EINVAL;
+       }
+
+       if (format < FORMATMOD_HE_SU)
+               ltf_field =3D 0;
+
+       /* Build rate_ctrl and rate_ctrl_he */
+       if (mcs =3D=3D 0xff || bw =3D=3D 0xff || gi =3D=3D 0xff || format =
=3D=3D 0xff) {
+               cl_hw->entry_fixed_rate =3D false;
+               cl_dbg_trace(cl_hw, "Fixed rate turned off\n");
+       } else {
+               rate_ctrl.word =3D 0;
+               rate_ctrl.field.mcs_index =3D mcs;
+               rate_ctrl.field.bw =3D bw;
+               rate_ctrl.field.gi =3D gi;
+               rate_ctrl.field.format_mod =3D format;
+
+               if (rate_ctrl.field.format_mod !=3D FORMATMOD_NON_HT)
+                       rate_ctrl.field.pre_type_or_stbc =3D pre_type_or_st=
bc;
+
+               /* rate_ctrl_he is relevant only for HE format mode. */
+               if (format > FORMATMOD_VHT)
+                       rate_ctrl_he.field.spatial_conf =3D RATE_CNTRL_HE_S=
PATIAL_CONF_DEF;
+               else
+                       rate_ctrl_he.word =3D 0;
+
+               cl_dbg_trace(cl_hw, "mcs=3D%llu bw=3D%llu gi=3D%llu format=
=3D%llu --> rate_ctrl 0x%x\n",
+                            mcs, bw, gi, format, rate_ctrl.word);
+
+               /* Set entry_fixed_rate to true only if there is no specifi=
c station */
+               cl_hw->entry_fixed_rate =3D (sta_idx =3D=3D 0xff);
+
+               if (!cl_rate_ctrl_set_dbgfs(cl_hw, sta_idx, rate_ctrl.word,=
 rate_ctrl_he.word,
+                                           op_mode, bw, ltf_field))
+                       return -EFAULT;
+       }
+
+       return count;
+}
+
+DEBUGFS_WRITE_FILE_OPS(fixed_rate);
+
+static ssize_t cl_dbgfs_mactrace_read(struct file *file,
+                                     char __user *user_buf,
+                                     size_t count,
+                                     loff_t *ppos)
+{
+       struct cl_hw *cl_hw =3D file->private_data;
+       ssize_t read;
+
+       mutex_lock(&cl_hw->dbginfo.mutex);
+       if (cl_hw->debugfs.trace_prst) {
+               read =3D simple_read_from_buffer(user_buf, count, ppos,
+                                              &cl_hw->dbginfo.buf->u.dump.=
la_mem[0],
+                                              ARRAY_SIZE(cl_hw->dbginfo.bu=
f->u.dump.la_mem[0]));
+       } else {
+               pr_debug("No dump!\n");
+               read =3D 0;
+       }
+       mutex_unlock(&cl_hw->dbginfo.mutex);
+
+       return read;
+}
+
+static ssize_t cl_dbgfs_mactrace_write(struct file *file,
+                                      const char __user *user_buf,
+                                      size_t count,
+                                      loff_t *ppos)
+{
+       /* Write "1" to diags/mactrace triggers dump, type 0 (recoverable).=
 */
+       struct cl_hw *cl_hw =3D file->private_data;
+       char buf[32];
+       unsigned long v;
+       int eobuf =3D min_t(size_t, sizeof(buf) - 1, count);
+
+       if (cl_hw->debugfs.unregistering)
+               return -EFAULT;
+
+       if (copy_from_user(&buf, user_buf, eobuf))
+               return -EFAULT;
+
+       buf[eobuf] =3D '\0';
+       if (kstrtoul(buf, 0, &v) || v !=3D 1) {
+               pr_debug("Usage: echo 1 > mactrace : trigger firmware dump\=
n");
+               return -EFAULT;
+       }
+
+       mutex_lock(&cl_hw->dbginfo.mutex);
+       if (cl_hw->debugfs.trace_prst) {
+               pr_debug("Dump already waiting\n");
+               mutex_unlock(&cl_hw->dbginfo.mutex);
+               return -EFAULT;
+       }
+
+       scnprintf(buf, sizeof(buf), "Force trigger\n");
+       cl_msg_tx_dbg_trigger(cl_hw, buf);
+       mutex_unlock(&cl_hw->dbginfo.mutex);
+
+       return count;
+}
+
+DEBUGFS_READ_WRITE_FILE_OPS(mactrace);
+
+static ssize_t cl_dbgfs_phytrace_read(struct file *file,
+                                     char __user *user_buf,
+                                     size_t count,
+                                     loff_t *ppos)
+{
+#if LA_CNT < 2
+       return -EFAULT; /* La_mem[1] does not exist */
+#else
+       struct cl_hw *cl_hw =3D file->private_data;
+       ssize_t read;
+
+       mutex_lock(&cl_hw->dbginfo.mutex);
+       if (!cl_hw->debugfs.trace_prst) {
+               mutex_unlock(&cl_hw->dbginfo.mutex);
+               return 0;
+       }
+
+       read =3D simple_read_from_buffer(user_buf, count, ppos,
+                                      &cl_hw->dbginfo.buf->u.dump.la_mem[1=
],
+                                      ARRAY_SIZE(cl_hw->dbginfo.buf->u.dum=
p.la_mem[1]));
+       mutex_unlock(&cl_hw->dbginfo.mutex);
+       return read;
+#endif
+}
+
+DEBUGFS_READ_FILE_OPS(phytrace);
+
+static ssize_t cl_dbgfs_macdiags_read(struct file *file,
+                                     char __user *user_buf,
+                                     size_t count,
+                                     loff_t *ppos)
+{
+       struct cl_hw *cl_hw =3D file->private_data;
+       ssize_t read;
+
+       mutex_lock(&cl_hw->dbginfo.mutex);
+       if (!cl_hw->debugfs.trace_prst) {
+               mutex_unlock(&cl_hw->dbginfo.mutex);
+               return 0;
+       }
+
+       read =3D simple_read_from_buffer(user_buf, count, ppos,
+                                      cl_hw->dbginfo.buf->u.dump.general_d=
ata.diags_mac,
+                                      DBG_DIAGS_MAC_MAX * 2); // FIXME: Wh=
y * 2?? BUG?
+       mutex_unlock(&cl_hw->dbginfo.mutex);
+
+       return read;
+}
+
+DEBUGFS_READ_FILE_OPS(macdiags);
+
+static ssize_t cl_dbgfs_hwdiags_read(struct file *file,
+                                    char __user *user_buf,
+                                    size_t count,
+                                    loff_t *ppos)
+{
+       struct cl_hw *cl_hw =3D file->private_data;
+       char buf[16];
+       int ret;
+
+       mutex_lock(&cl_hw->dbginfo.mutex);
+       if (!cl_hw->debugfs.trace_prst) {
+               mutex_unlock(&cl_hw->dbginfo.mutex);
+               return 0;
+       }
+
+       ret =3D scnprintf(buf, min_t(size_t, sizeof(buf) - 1, count),
+                       "%08X\n", cl_hw->dbginfo.buf->u.dump.general_data.h=
w_diag);
+
+       mutex_unlock(&cl_hw->dbginfo.mutex);
+       return simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+}
+
+DEBUGFS_READ_FILE_OPS(hwdiags);
+
+static ssize_t cl_dbgfs_swdiags_read(struct file *file,
+                                    char __user *user_buf,
+                                    size_t count,
+                                    loff_t *ppos)
+{
+       struct cl_hw *cl_hw =3D file->private_data;
+       ssize_t read;
+
+       mutex_lock(&cl_hw->dbginfo.mutex);
+       if (!cl_hw->debugfs.trace_prst) {
+               mutex_unlock(&cl_hw->dbginfo.mutex);
+               return 0;
+       }
+
+       read =3D simple_read_from_buffer(user_buf, count, ppos,
+                                      &cl_hw->dbginfo.buf->u.dump.general_=
data.sw_diag,
+                                      cl_hw->dbginfo.buf->u.dump.general_d=
ata.sw_diag_len);
+
+       mutex_unlock(&cl_hw->dbginfo.mutex);
+       return read;
+}
+
+DEBUGFS_READ_FILE_OPS(swdiags);
+
+static ssize_t cl_dbgfs_lamacconf_read(struct file *file,
+                                      char __user *user_buf,
+                                      size_t count,
+                                      loff_t *ppos)
+{
+       struct cl_hw *cl_hw =3D file->private_data;
+       ssize_t read;
+
+       mutex_lock(&cl_hw->dbginfo.mutex);
+       if (!cl_hw->debugfs.trace_prst) {
+               mutex_unlock(&cl_hw->dbginfo.mutex);
+               return 0;
+       }
+
+       read =3D simple_read_from_buffer(user_buf, count, ppos,
+                                      &cl_hw->dbginfo.buf->u.dump.general_=
data.la_conf[0],
+                                      sizeof(struct la_conf_tag));
+
+       mutex_unlock(&cl_hw->dbginfo.mutex);
+       return read;
+}
+
+DEBUGFS_READ_FILE_OPS(lamacconf);
+
+static ssize_t cl_dbgfs_laphyconf_read(struct file *file,
+                                      char __user *user_buf,
+                                      size_t count,
+                                      loff_t *ppos)
+{
+       struct cl_hw *cl_hw =3D file->private_data;
+       ssize_t read;
+
+       mutex_lock(&cl_hw->dbginfo.mutex);
+       if (!cl_hw->debugfs.trace_prst) {
+               mutex_unlock(&cl_hw->dbginfo.mutex);
+               return 0;
+       }
+
+       read =3D simple_read_from_buffer(user_buf, count, ppos,
+                                      &cl_hw->dbginfo.buf->u.dump.general_=
data.la_conf[1],
+                                      sizeof(struct la_conf_tag));
+
+       mutex_unlock(&cl_hw->dbginfo.mutex);
+       return read;
+}
+
+DEBUGFS_READ_FILE_OPS(laphyconf);
+
+static ssize_t cl_dbgfs_chaninfo_read(struct file *file,
+                                     char __user *user_buf,
+                                     size_t count,
+                                     loff_t *ppos)
+{
+       struct cl_hw *cl_hw =3D file->private_data;
+       struct phy_channel_info *chan_info =3D &cl_hw->dbginfo.buf->u.dump.=
general_data.chan_info;
+       char buf[4 * 32];
+       int ret;
+
+       mutex_lock(&cl_hw->dbginfo.mutex);
+       if (!cl_hw->debugfs.trace_prst) {
+               mutex_unlock(&cl_hw->dbginfo.mutex);
+               return 0;
+       }
+
+       ret =3D scnprintf(buf, min_t(size_t, sizeof(buf) - 1, count),
+                       "type:         %u\n"
+                       "prim20_freq:  %u MHz\n"
+                       "center1_freq: %u MHz\n"
+                       "center2_freq: %u MHz\n",
+                       (chan_info->info1 >> 8) & 0xFF,
+                       (chan_info->info1 >> 16) & 0xFFFF,
+                       (chan_info->info2 >> 0) & 0xFFFF,
+                       (chan_info->info2 >> 16) & 0xFFFF);
+
+       mutex_unlock(&cl_hw->dbginfo.mutex);
+       return simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+}
+
+DEBUGFS_READ_FILE_OPS(chaninfo);
+
+#define MAX_BUF_SIZE 512
+
+static ssize_t cl_dbgfs_error_read(struct file *file,
+                                  char __user *user_buf,
+                                  size_t count,
+                                  loff_t *ppos)
+{
+       struct cl_hw *cl_hw =3D file->private_data;
+       struct dbg_print_ind *ind =3D
+               &cl_hw->dbginfo.buf->u.dump.fw_dump.common_info.error_info;
+       ssize_t read;
+
+       mutex_lock(&cl_hw->dbginfo.mutex);
+       if (!cl_hw->debugfs.trace_prst) {
+               mutex_unlock(&cl_hw->dbginfo.mutex);
+               return 0;
+       }
+
+       /* If an assert message, search for assert string */
+       if (ind->file_id && ind->line) {
+               u16 file_id =3D le16_to_cpu(ind->file_id);
+               u16 line =3D le16_to_cpu(ind->line);
+               const char *assert_string =3D cl_dbgfile_get_msg_txt(&cl_hw=
->dbg_data, file_id, line);
+
+               /* If string not found. use FW error string. */
+               if (!assert_string)
+                       assert_string =3D cl_hw->dbginfo.buf->u.dump.genera=
l_data.error;
+
+               read =3D simple_read_from_buffer(user_buf, count, ppos, ass=
ert_string,
+                                              strnlen(assert_string, MAX_B=
UF_SIZE));
+       } else {
+               char *error =3D cl_hw->dbginfo.buf->u.dump.general_data.err=
or;
+
+               read =3D simple_read_from_buffer(user_buf, count, ppos, err=
or,
+                                              strnlen(error, DBG_ERROR_TRA=
CE_SIZE));
+       }
+
+       mutex_unlock(&cl_hw->dbginfo.mutex);
+       return read;
+}
+
+DEBUGFS_READ_FILE_OPS(error);
+
+static ssize_t cl_dbgfs_mpifmask_write(struct file *file,
+                                      const char __user *user_buf,
+                                      size_t count,
+                                      loff_t *ppos)
+{
+       struct cl_hw *cl_hw =3D file->private_data;
+       char buf[32];
+       int ret;
+       int eobuf =3D min_t(size_t, sizeof(buf) - 1, count);
+       unsigned long long result;
+
+       buf[eobuf] =3D '\0';
+       if (copy_from_user(&buf, user_buf, eobuf))
+               return -EFAULT;
+
+       ret =3D kstrtoull(buf, 0, &result);
+       if (ret)
+               return ret;
+
+       cl_dbg_trace(cl_hw, "Set LA mpif mask =3D 0x%08x\n", (u32)result);
+
+       cl_msg_tx_dbg_set_la_mpif_mask(cl_hw, result);
+
+       return count;
+}
+
+DEBUGFS_WRITE_FILE_OPS(mpifmask);
+
+static ssize_t cl_dbgfs_trigpoint_write(struct file *file,
+                                       const char __user *user_buf,
+                                       size_t count,
+                                       loff_t *ppos)
+{
+       struct cl_hw *cl_hw =3D file->private_data;
+       char buf[32];
+       int ret;
+       int eobuf =3D min_t(size_t, sizeof(buf) - 1, count);
+       unsigned long long result;
+
+       buf[eobuf] =3D '\0';
+       if (copy_from_user(&buf, user_buf, eobuf))
+               return -EFAULT;
+
+       ret =3D kstrtoull(buf, 0, &result);
+       if (ret)
+               return ret;
+
+       cl_dbg_trace(cl_hw, "Set LA trigger point =3D 0x%x\n", (u32)result)=
;
+
+       cl_msg_tx_dbg_set_la_trig_point(cl_hw, result);
+
+       return count;
+}
+
+DEBUGFS_WRITE_FILE_OPS(trigpoint);
+
+enum {
+       CL_LA_MPIF_DEBUG_MODE_GEN, /* Generic MPIF sampling mask */
+       CL_LA_MPIF_DEBUG_MODE_TX,  /* Tx oriented MPIF sampling mask */
+       CL_LA_MPIF_DEBUG_MODE_RX,  /* Rx oriented MPIF sampling mask */
+
+       CL_LA_MPIF_DEBUG_MODE_NUM
+};
+
+const char *ce_la_mpif_debug_mode_str[CL_LA_MPIF_DEBUG_MODE_NUM] =3D {
+       [CL_LA_MPIF_DEBUG_MODE_GEN] =3D "LA_MPIF_DEBUG_MODE_GEN",
+       [CL_LA_MPIF_DEBUG_MODE_TX]  =3D "LA_MPIF_DEBUG_MODE_TX",
+       [CL_LA_MPIF_DEBUG_MODE_RX]  =3D "LA_MPIF_DEBUG_MODE_RX"
+};
+
+static ssize_t cl_dbgfs_mpif_debug_mode_write(struct file *file,
+                                             const char __user *user_buf,
+                                             size_t count,
+                                             loff_t *ppos)
+{
+       struct cl_hw *cl_hw =3D file->private_data;
+       char buf[32];
+       int ret;
+       int eobuf =3D min_t(size_t, sizeof(buf) - 1, count);
+       unsigned long long result;
+       u8 mode;
+
+       buf[eobuf] =3D '\0';
+       if (copy_from_user(&buf, user_buf, eobuf))
+               return -EFAULT;
+
+       ret =3D kstrtoull(buf, 0, &result);
+       if (ret)
+               return ret;
+
+       mode =3D (u8)result;
+       if (mode >=3D CL_LA_MPIF_DEBUG_MODE_NUM)
+               return -EINVAL;
+
+       cl_dbg_trace(cl_hw, "Set LA MPIF mode =3D %u (%s)\n", mode, ce_la_m=
pif_debug_mode_str[mode]);
+
+       cl_msg_tx_dbg_set_la_mpif_debug_mode(cl_hw, result);
+
+       return count;
+}
+
+DEBUGFS_WRITE_FILE_OPS(mpif_debug_mode);
+
+char *la_trig_oper_str[LA_TRIG_OPER_MAX] =3D {
+       [LA_TRIG_OPER_EQ] =3D "eq",
+       [LA_TRIG_OPER_NOT_EQ] =3D "neq",
+       [LA_TRIG_OPER_GT] =3D "gt",
+       [LA_TRIG_OPER_GT_EQ] =3D "gte",
+       [LA_TRIG_OPER_LT] =3D "lt",
+       [LA_TRIG_OPER_LT_EQ] =3D "lte"
+};
+
+static ssize_t cl_dbgfs_trig_rule_write(struct file *file,
+                                       const char __user *user_buf,
+                                       size_t count,
+                                       loff_t *ppos)
+{
+       struct cl_hw *cl_hw =3D file->private_data;
+       char buf[100];
+       int ret =3D 0;
+       int eobuf =3D min_t(size_t, sizeof(buf) - 1, count);
+       char *sptr =3D NULL, *token =3D NULL;
+       unsigned long val;
+       u32 address =3D 0, value =3D 0, mask =3D 0, duration =3D 0;
+       u8 idx =3D 0, oper =3D 0;
+       bool enable =3D false;
+       char *usage_str =3D "Usage:\n"
+                         "echo  <rule-idx> <enable {1|0}> <address> <oper =
{eq|neq|gt|gte|lt|lte}>"
+                         " <value> <mask> [duration] > trig_rule\n";
+
+       buf[eobuf] =3D '\0';
+       if (copy_from_user(&buf, user_buf, eobuf))
+               return -EFAULT;
+
+       sptr =3D buf;
+
+       token =3D strsep(&sptr, " ");
+       if (!token) {
+               pr_err("Illegal token.\n%s", usage_str);
+               return -EINVAL;
+       }
+
+       ret =3D kstrtoul(token, 0, &val);
+       if (ret) {
+               pr_err("<rule-idx> illegal value (%s)\n%s", token, usage_st=
r);
+               return -EINVAL;
+       }
+
+       idx =3D (u8)val;
+
+       token =3D strsep(&sptr, " ");
+       if (!token) {
+               pr_err("Illegal token.\n%s", usage_str);
+               return -EINVAL;
+       }
+
+       ret =3D kstrtoul(token, 0, &val);
+       if (ret) {
+               pr_err("<enable> illegal value (%s)\n%s", token, usage_str)=
;
+               return -EINVAL;
+       }
+
+       enable =3D (bool)val;
+
+       if (enable) {
+               /* Address token */
+               token =3D strsep(&sptr, " ");
+               if (!token) {
+                       pr_err("Illegal token.\n%s", usage_str);
+                       return -EINVAL;
+               }
+
+               ret =3D kstrtoul(token, 0, &val);
+               if (ret) {
+                       pr_err("<address> illegal value (%s)\n%s", token, u=
sage_str);
+                       return -EINVAL;
+               }
+
+               address =3D val;
+
+               /* Comparison Operator token */
+               token =3D strsep(&sptr, " ");
+               if (!token) {
+                       pr_err("Illegal token.\n%s", usage_str);
+                       return -EINVAL;
+               }
+
+               for (oper =3D LA_TRIG_OPER_EQ; oper < LA_TRIG_OPER_MAX; ++o=
per)
+                       if (!strcmp(token, la_trig_oper_str[oper]))
+                               break;
+
+               if (oper =3D=3D LA_TRIG_OPER_MAX) {
+                       pr_err("<oper> illegal value (%s)\n%s", token, usag=
e_str);
+                       return -EINVAL;
+               }
+
+               /* Value token */
+               token =3D strsep(&sptr, " ");
+               if (!token) {
+                       pr_err("Illegal token.\n%s", usage_str);
+                       return -EINVAL;
+               }
+
+               ret =3D kstrtoul(token, 0, &val);
+               if (ret) {
+                       pr_err("<value> illegal value (%s)\n%s", token, usa=
ge_str);
+                       return -EINVAL;
+               }
+
+               value =3D val;
+
+               /* Mask token */
+               token =3D strsep(&sptr, " ");
+               if (!token) {
+                       pr_err("Illegal token.\n%s", usage_str);
+                       return -EINVAL;
+               }
+
+               ret =3D kstrtoul(token, 0, &val);
+               if (ret) {
+                       pr_err("<mask> illegal value (%s)\n%s", token, usag=
e_str);
+                       return -EINVAL;
+               }
+
+               mask =3D val;
+
+               /* Duration token (optional) */
+               token =3D strsep(&sptr, " ");
+               if (token) {
+                       ret =3D kstrtoul(token, 0, &val);
+                       if (ret) {
+                               pr_err("<duration> illegal value (%s)\n%s",=
 token, usage_str);
+                               return -EINVAL;
+                       }
+
+                       duration =3D val;
+               }
+       }
+
+       if (enable)
+               pr_debug("Set trigger rule: idx=3D%u, addr=3D0x%08x, oper=
=3D%s, value=3D0x%08x, "
+                        "mask=3D0x%08x, duration=3D%u\n",
+                        idx, address, la_trig_oper_str[oper], value, mask,=
 duration);
+       else
+               pr_debug("Disable trigger rule: idx=3D%u\n", idx);
+
+       if (cl_msg_tx_dbg_set_la_trig_rule(cl_hw, idx, enable, address, ope=
r,
+                                          value, mask, duration))
+               return -EFAULT;
+
+       return count;
+}
+
+DEBUGFS_WRITE_FILE_OPS(trig_rule);
+
+int cl_dbgfs_register(struct cl_hw *cl_hw, const char *name)
+{
+       struct dentry *phyd =3D cl_hw->hw->wiphy->debugfsdir;
+       struct dentry *dir_drv, *dir_diags, *dir_cl;
+
+       cl_dbg_trace(cl_hw, "/sys/kernel/debug/%s/%s/%s.\n",
+                    phyd->d_parent->d_name.name, phyd->d_name.name, name);
+
+       dir_drv =3D debugfs_create_dir(name, phyd);
+       if (!dir_drv)
+               return -ENOMEM;
+
+       dir_diags =3D debugfs_create_dir("diags", dir_drv);
+       if (!dir_diags)
+               goto err;
+
+       dir_cl =3D debugfs_create_dir("cl8k", dir_drv);
+       if (!dir_cl) {
+               cl_dbg_err(cl_hw, "%s\n", name);
+               goto err;
+       }
+
+       cl_coredump_init(cl_hw, dir_drv);
+
+       DEBUGFS_ADD_FILE(mactrace,            dir_diags, 0400);
+       DEBUGFS_ADD_FILE(phytrace,            dir_diags, 0400);
+       DEBUGFS_ADD_FILE(macdiags,            dir_diags, 0400);
+       DEBUGFS_ADD_FILE(hwdiags,             dir_diags, 0400);
+       DEBUGFS_ADD_FILE(swdiags,             dir_diags, 0400);
+       DEBUGFS_ADD_FILE(error,               dir_diags, 0400);
+       DEBUGFS_ADD_FILE(lamacconf,           dir_diags, 0400);
+       DEBUGFS_ADD_FILE(laphyconf,           dir_diags, 0400);
+       DEBUGFS_ADD_FILE(chaninfo,            dir_diags, 0400);
+       DEBUGFS_ADD_FILE(trigpoint,           dir_diags, 0200);
+       DEBUGFS_ADD_FILE(mpifmask,            dir_diags, 0200);
+       DEBUGFS_ADD_FILE(mpif_debug_mode,     dir_diags, 0200);
+       DEBUGFS_ADD_FILE(set_debug,           dir_cl,    0200);
+       DEBUGFS_ADD_FILE(test_mode,           dir_cl,    0200);
+       DEBUGFS_ADD_FILE(fixed_rate,          dir_cl,    0200);
+       DEBUGFS_ADD_FILE(tx_trace_debug_flag, dir_cl,    0200);
+       DEBUGFS_ADD_FILE(trig_rule,           dir_cl,    0200);
+       return 0;
+
+err:
+       cl_dbgfs_unregister(cl_hw);
+       return -ENOMEM;
+}
+
+void cl_dbgfs_unregister(struct cl_hw *cl_hw)
+{
+       cl_coredump_close(cl_hw);
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

