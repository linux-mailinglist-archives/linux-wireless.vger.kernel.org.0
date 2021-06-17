Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F313AB895
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhFQQJE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:04 -0400
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:59110
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231955AbhFQQID (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBcwJq92t6XgQiA5aI+LAM2tSboZN6lym1wxOiMjepg0oMKDCm1VCZJbRfhuexNb82iqbcs305ltlgyajvnyLsHwCW+k4nuuTwgEjCtFai0tGrtrbDqE1lDG+vVuK3+VI4UcnvoZvKDnxoPf2zDfXY7gw28PfmNmLrUCsJRGH8QbY9ryOo97HkNBYm1J4P3HEhSzggKIpDpJWoP6zlXoOPOhI78MWx8gC1LtYs66yr+iLBNQynKcX8Mj/ApTfDUHKfejO3ohdK2RXO/k62Ttk0HILe9JOrOtLL8b5CneF9mCyxWYXMuQ0nSA/Ob7q2fbG2A0RQIUVFKlVOWT/UYY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGYUfMiVLeGSOkH8a7fOMvwPj/Ibreb5b8Q+PUtsM4A=;
 b=jJGIDjElVHTmHCe+omdr/p45Q2U11y87b9rIiM7s8M1R6ikES86plH95OvDw/vuiBpWOq2WA9xDxN7q0PUkRE4Xoh5EuOVNHSoWNQGVihoSnqMMdz9JzKwq+LIi0Q0zy+DttHXjsv6Y9CaoZ7s8vb/L1zYdOdcKWIAhucGcejWGUWc4Sp5aBCOUyFJjK+cQ6FXSoD2JHXip+ipF6cW0CY3H+O+Jp+B9g5qKV7qL/+P4i/tZYqCxafQEvOhANE2Jalvue48Q13hoLBQXNvADXchgk26XSXi8lryhrQZZ5aEfV09u+41ryUBaOXRF2BILj1YrlQf0Co/YlSnbCXeZ3uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGYUfMiVLeGSOkH8a7fOMvwPj/Ibreb5b8Q+PUtsM4A=;
 b=3IhVcPqPBB52sdzwal7zjQI8PbQDT+Cq6b0ZcxEfz/sl4QLCPJ4fs3yzkB2wgi0airtygjb1ksHnxUlq6Rj9ki7tD7FxojP3CawEUOpOa33kQ31XzhI9ieXnUahAAJfEhXKuGkHA5AIWKSYYmas6SSyAOdsY3dU7kF4OshiMS5U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0887.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:04 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:03 +0000
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
Subject: [RFC v1 100/256] cl8k: add hw_assert.c
Date:   Thu, 17 Jun 2021 15:59:47 +0000
Message-Id: <20210617160223.160998-101-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f07addd-ddae-4b7a-d968-08d931a993a0
X-MS-TrafficTypeDiagnostic: AM9P192MB0887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0887FA30001B1B5E338715F5F60E9@AM9P192MB0887.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rnVNv0wrw713qjQbMAniCay3+mkUqa5uT0AM1ADmB9n35a3q+nKYwaGHMbG2xvTYPlX9nSFgMOom4Xwv0h6O3H+DjMTlm2uGysAUv5kVN8DGONvytZ/PW6IhVN1KTrh54mFxUQ7WEk0G61S3zT3T5O+WsFHP2+jvsQGTd0BN4TOWClVoWzHZwDZtUPwVBuTVV8X1y7apSx2sLNsvSN6VuKT2m7zDFVDDF27C4fe4BFD45/4PhRgEAnQXMttV2tRCPYck1fLU8Ldsh88v8bSvNi2MjHweCLV6y/lg+oK9BdQAFpjzVJmnPLHNzBaLvupgj2wfxhfTBsUunvvQeSSDV3qjD1XHIT+FKolmISwamMAdhuycRJbMMtfzPkw/XI1em8FlUya6SwtjbYFfa7DalATk1eqAs2TYeKXRbaqoBNLAbrz148UWl0wxZGR2W9s8jKTS9sKyjXOFOtvyCCQ7pAN4vZrWWcyrafqGv7NmqC8Gqe+Yyxk3yEiNcvI1KOqM7iJp64euCZQ372hfLivphuslD/mJAMCPFgOXKLRgms0sdofIge9MKRdbHPc01qS1ZKBkTQvrh2WGP9uJxN9NG/2JGL/wjzqKafVuQL506WMrVjfWl888EqvVCrct3b4VH9yZS0tFn46yMhUNCTUDEv9cNhEwdVrd4Ebfvc6s/kn9hC9a2nA+KfaBJNDyVD9zb6ABRq2XBKLB+A49NHHREg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(39850400004)(136003)(346002)(83380400001)(6666004)(38350700002)(4326008)(186003)(16526019)(5660300002)(54906003)(6506007)(26005)(55236004)(38100700002)(316002)(1076003)(107886003)(52116002)(8936002)(508600001)(66476007)(66946007)(66556008)(36756003)(6916009)(6486002)(86362001)(2616005)(956004)(2906002)(8676002)(9686003)(6512007)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2R3Q7rKCSy7Xzy9Qpn19Aq2XQCv7cdx9y/uu3kkvaE28GEUEQZdFevLJUm4P?=
 =?us-ascii?Q?3XwhJDiBXJ9iSCZhjv6JQshygDCY5FifQXgIOlB6uec6WPlAlkH0mP/UxQeO?=
 =?us-ascii?Q?dCfjdvS/eGAsTMwqUGZTBtrWwrKoxuomcKa6YcToztvKt6Ms9g/sjpsfAF2G?=
 =?us-ascii?Q?j/P0RSpPa3Anbqks3jrXFKPEWsFkIuIfDhHj6RUMaaOyxB87ReBaanW0rzim?=
 =?us-ascii?Q?rVh+wOG6cYPNah6tsbCTbgKcfNX6cFEtgtFZ39x6vBVHGuWw1o1gEK2K0ftm?=
 =?us-ascii?Q?e7alucHxKQ8oXvFQUWr8HCBs+GnYwS10bSKkwzEeeb9ZvoIPwbxDA/gLuTXz?=
 =?us-ascii?Q?KbxpPZcRrMBxO/vmxtNHeSqd5cK+X1326rnHIfJhBMOCqTvWj9d4cINPvBLb?=
 =?us-ascii?Q?pgySG28i9L6RWS0dWLEi9btcoUDsHUuNeV/sj3eqxCakzf7DUzWamfViT60U?=
 =?us-ascii?Q?c0UpkOGfYvd1E3/KdOEbOSePmJyKctAXBNVGD8FQnYLca4jIBmUvVYnOU+qt?=
 =?us-ascii?Q?yCZ0/JQv1N4xT5MKvwLhUkyo7+sfwzJeB72EmYBXGP0Uia0CfDbssMZbJm2i?=
 =?us-ascii?Q?Uz5bmxM/TnoDV/LMQokHefFynaxq92sWGeMySPPC1xPSuqhjQhTsQHQHXDLF?=
 =?us-ascii?Q?2Js4UdnvAM1iPsTiJHimD5B7srnuGBbYyIqBjVrgWfjg1288FsW6rGeSajvG?=
 =?us-ascii?Q?8L5s6T1x7W0n4sY3xgzloZ+t2kVi+OZSBHBjKfQu03mFhS2YTe7giWQrG5P8?=
 =?us-ascii?Q?2ULvVE0VmuYLAY03V0+ojSBszcWu8bjBX3T9Uoc4XUgzu58AzJifFX6GGo2o?=
 =?us-ascii?Q?iULwTwcRlUt8cLXQ/gM2fEpVgj+BShpKv6QV+XZT2oIYMTFKZyBNKiQ0mf7l?=
 =?us-ascii?Q?2Q0xdVDk83/r216nHYHCSSrJ9CtMeIk2J7WB17tWc5p5SclTO2BUyXwp2Cgf?=
 =?us-ascii?Q?4qSWU+90r0VHEpwPUOdZdgu1LVkqZujDv7pFxoj8vzH0uuIYqH2lG71dK73B?=
 =?us-ascii?Q?BNLQbDoWkVZdOIQXO8Xq0Vag5JeWSVvEU8GpSMVhru2j1WOHSId/D0HUcejI?=
 =?us-ascii?Q?qBfQ9+Oj8WCVyQowyLR+P5tOWQU4BWlTVSPeb40Omf0f0zYx+MtPH8tVxYwH?=
 =?us-ascii?Q?C5Adh/SU+LVzsuzfkzOstbP7RU26Xxzr3sHhXKoRXKQFIlUlAIk2Ed3WjXBj?=
 =?us-ascii?Q?3J8o6rosx0PSR744WsPglMD2RVthqSDF78bKGTT0gOwTKcANOqoJXsQM9Ywg?=
 =?us-ascii?Q?DarfMCMkKHd7J1iQij48h/AM5ujMU8jalZOUrQydI9LIkoYNSVtyb+/7iw35?=
 =?us-ascii?Q?YWaAFiQhMYx/hEEIDlx3K8bU?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f07addd-ddae-4b7a-d968-08d931a993a0
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:24.7484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrOqwX+GEcGtVui4Hc7t09O6Z+0awaaS1ZEORRV3WY1b+jLESNfIh0Q8VfSyzZHfZS6vIEQA28qbzRt4Ccby2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0887
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/hw_assert.c | 129 +++++++++++++++++++
 1 file changed, 129 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/hw_assert.c

diff --git a/drivers/net/wireless/celeno/cl8k/hw_assert.c b/drivers/net/wir=
eless/celeno/cl8k/hw_assert.c
new file mode 100644
index 000000000000..b632d70bae44
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/hw_assert.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "hw_assert.h"
+#include "recovery.h"
+#include "debug.h"
+#include "dbgfile.h"
+#include "bus/pci/ipc.h"
+#include "coredump.h"
+
+#define ASSERT_PATTERN 0xC0DEDEAD
+
+/*
+ * Function will take time stamp for each hw error indication.
+ * when time diff between each error is less than ce_hw_assert_time_max
+ * cl_hw_restart work will be scheduled
+ */
+static bool cl_hw_assert_storm_detect(struct cl_hw *cl_hw)
+{
+       struct cl_hw_asserts_info *assert_info =3D &cl_hw->assert_info;
+       u8 idx =3D assert_info->index % CL_MIN_ASSERT_CNT;
+       /* Get the oldest assert timestamp. */
+       u8 prev_idx =3D (assert_info->index + 1) % CL_MIN_ASSERT_CNT;
+       bool is_hw_restarted =3D false;
+
+       if (assert_info->restart_sched) {
+               is_hw_restarted =3D true;
+       } else {
+               /* Take time stamp of the assert */
+               assert_info->timestamp[idx] =3D jiffies;
+               assert_info->index++;
+               /* In case hw assert time diff is less than CL_HW_ASSERT_TI=
ME_MAX, restart hw. */
+               if (assert_info->index > CL_MIN_ASSERT_CNT) {
+                       unsigned long time_diff_jiffies =3D
+                               assert_info->timestamp[idx] - assert_info->=
timestamp[prev_idx];
+                       unsigned int time_diff_msecs =3D jiffies_to_msecs(t=
ime_diff_jiffies);
+
+                       if (time_diff_msecs < cl_hw->conf->ce_hw_assert_tim=
e_max) {
+                               assert_info->index =3D 0;
+
+                               cl_dbg_err(cl_hw, "Assert storm detect (tim=
e_diff =3D %u)\n",
+                                          time_diff_msecs);
+                               cl_recovery_start(cl_hw, RECOVERY_ASSERT_ST=
ORM_DETECT);
+
+                               is_hw_restarted =3D true;
+                       }
+               }
+       }
+
+       return is_hw_restarted;
+}
+
+void cl_hw_assert_info_init(struct cl_hw *cl_hw)
+{
+       memset(&cl_hw->assert_info, 0, sizeof(cl_hw->assert_info));
+}
+
+void cl_hw_assert_print(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg)
+{
+       struct dbg_print_ind *ind =3D (struct dbg_print_ind *)msg->param;
+       const char *assert_string;
+       u32 assert_pattern;
+       u16 file_id =3D le16_to_cpu(ind->file_id);
+       u16 line =3D le16_to_cpu(ind->line);
+       u16 has_param =3D le16_to_cpu(ind->has_param);
+       u32 param =3D le32_to_cpu(ind->param);
+
+       /* If ce_hw_assert_time_max is 0, HW assert storm detection is disa=
bled */
+       if (cl_hw->conf->ce_hw_assert_time_max)
+               if (cl_hw_assert_storm_detect(cl_hw))
+                       return;
+
+       /* Print ASSERT message with fileid, line, [parameter] */
+       if (has_param)
+               cl_dbg_err(cl_hw, "ASSERT_TCV%u @ FILE=3D%hu LINE=3D%hu par=
am=3D0x%08X\n",
+                          cl_hw->idx, file_id, line, param);
+       else
+               cl_dbg_err(cl_hw, "ASSERT_TCV%u @ file=3D%hu line=3D%hu\n",
+                          cl_hw->idx, file_id, line);
+
+       assert_string =3D cl_dbgfile_get_msg_txt(&cl_hw->dbg_data, file_id,=
 line);
+
+       if (!assert_string)
+               assert_string =3D "ASSERT STRING NOT FOUND";
+
+       /* TODO: length of single print may be limited, consider printing l=
ong msgs by pieces */
+       cl_dbg_err(cl_hw, "%.500s\n", assert_string);
+
+       assert_pattern =3D le32_to_cpu(cl_hw->ipc_env->shared->assert_patte=
rn);
+
+       /* Reset ASSERT pattern if needed (in order to prevent assert print=
s loop) */
+       if (assert_pattern =3D=3D ASSERT_PATTERN)
+               cl_hw->ipc_env->shared->assert_pattern =3D 0;
+
+       if (ind->err_no_dump) {
+               bool reason =3D RECOVERY_UNRECOVERABLE_ASSERT_NO_DUMP;
+               bool restart =3D cl_coredump_recovery(cl_hw, reason);
+
+               if (restart)
+                       cl_hw->assert_info.restart_needed =3D true;
+       } else {
+               cl_hw->assert_info.restart_needed =3D false;
+       }
+}
+
+void cl_hw_assert_check(struct cl_hw *cl_hw)
+{
+       struct cl_ipc_shared_env *shared_env =3D cl_hw->ipc_env->shared;
+       u32 assert_pattern =3D le32_to_cpu(shared_env->assert_pattern);
+
+       if (assert_pattern =3D=3D ASSERT_PATTERN) {
+               u16 line =3D le16_to_cpu(shared_env->assert_line_num);
+               u16 fileid =3D le16_to_cpu(shared_env->assert_file_id);
+               u32 param =3D le32_to_cpu(shared_env->assert_param);
+               const char *assert_string =3D cl_dbgfile_get_msg_txt(&cl_hw=
->dbg_data, fileid, line);
+
+               /* Print 1st ASSERT message with fileid, line, [parameter] =
*/
+               cl_dbg_err(cl_hw, "ASSERT_%cmac @ FILE=3D%hu LINE=3D%hu par=
am=3D0x%08X\n",
+                          cl_hw->fw_prefix, fileid, line, param);
+
+               if (!assert_string)
+                       assert_string =3D "ASSERT STRING NOT FOUND";
+
+               cl_dbg_err(cl_hw, "%.500s\n", assert_string);
+
+               /* Reset ASSERT pattern in order to prevent assert prints l=
oop */
+               shared_env->assert_pattern =3D 0;
+       }
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

