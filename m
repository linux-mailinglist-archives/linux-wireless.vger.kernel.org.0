Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47613AB86E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbhFQQIF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:05 -0400
Received: from mail-db8eur05on2082.outbound.protection.outlook.com ([40.107.20.82]:7360
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232173AbhFQQHZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvmNfc65manZ2G6E56hqHmewdc5Q3+0P0mxSs+Yn+bMRkHoKQYe+iAEv0bn6FNtw92WAsjjlfHJcHpkewqlSBB46El907JReZV3Nqw67MtwkbJRB8+ElczNKHSY2HlXV3nRXv1Jp/IHaqyEWDV6waekoWKjtp+yam0q3UPrmSTcC38Bj5DlsHe6JvIbz50HCD385AdvfQ3peTwnlyBPG6FFFS+HG6/Mic4BUWSdeMuT8q1oLTpqq2YKOXsZGk+W/Ma7jEqJq4ed7wqoKgsFOi7duGq6plnbZrNQWwzsMgJwwayG+HfDfcV//6+EB52taf4jWAKmCtaYUq9xU5xDaHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOAWgpwNu7L3cmaTieRwbtEGfwuiSBFRwutyjFL1ksU=;
 b=UAAuW40tJ5PxBmetOpzWAhQlRJfFq65XLV6ijJp6wNxtom9nN3PK0QB+uUQjDjOcxKh63Fnhqz4lyiJ8R59qZHqiNHE2clXqLyypVYj0KlZ3WggWoyNbfHLqzGYj4quqXIOu+cQFWzdLxl/+jhHC4HQorKd8GKhFikPBa7bkQYHK3GJz7F03GnGzWDANhlzNH+96p4uoSLDtptE0j25q1SqK8ALNAJipfNjkfpkJuVam750QXh6q130UhYoel5zxPPt2XEiqAryE4Z6UmNxYPIn5cTVVILPuXDvkCD2ex0WD63jMRp85DRyGaz2Rh+hxWm2C0kgY1zm8avRfmTVaQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOAWgpwNu7L3cmaTieRwbtEGfwuiSBFRwutyjFL1ksU=;
 b=CVV4KArlxOK7PwAef7AdAddzZfZsmbxfe9hBCygkan9d/bTbGk2n8ylOJHtCNyWQ6QOqSLMMbT3ee7Vc8BMqqmYe1GVTQ6+rsGjKVv5hjgBfRUqC2aB7SiKtI8QEGaZ54vlyUuIm+V+uCX7/qAKVCEnipyLEh9olBrPVC1PkqUI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0871.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 17 Jun
 2021 16:04:26 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:26 +0000
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
Subject: [RFC v1 081/256] cl8k: add ext/vlan_dscp.c
Date:   Thu, 17 Jun 2021 15:59:28 +0000
Message-Id: <20210617160223.160998-82-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 719eccc2-ade0-43de-77e1-08d931a9864d
X-MS-TrafficTypeDiagnostic: AM9P192MB0871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0871CBDA0183C30F8B001740F60E9@AM9P192MB0871.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IFwQrDI4WNjBOS4iHl7PYuhsnBW3w1vh9xJmyU5Do+3IyUOyZHCyBFBnYh9EsbNV3YOSUM6/qXn8d7rIo2m3AvOK+2TpjKIXLy+b5NH2sUtu+tb0V+MrIKHEG/txkbuTZjrxLsZp77pg/skkYOzwtGavTiElRXWNVDQBletReH1A5B+FIBShy02pRqqhvvD7jCMrPiQ1jC4FkwvvMNtBf57OIBOXefpmt+l/Yv/+agIU5edIV9koA75yaKflEd7LQ1uWOixMGIG47F+QmCsBO2VcfhYVG96ujZXA3q+2VGZZx1wdeEADwhECwWegwy9dvh/NS0skOtCzuIJBBTLej7E57i7qXnoA5PB1jcdoBSy02DX+VnirfvXJCqC0fqp2dK2A58DHkDgvgsqj0RdmMbNiRz/jOxb2E1JeG/oaUm6Yh7stCsWPNpoqp5ddvLKLOTR4esrVlL5sbIf7LXZ6Q/1xt1C93O1n667oMVv9T3jzSebwf/4hAYshnHMLYOy8MPp/9C/BknwqZ6BRyvdDF4hz1wCdch0/xVE7cgSIYtfWQgy2Cde7UuJU2F1On4u4hCgwI/9KaywJqf0DiyVmsFSNgQ0/meNbNxd0QHpaVJMmg7ozLJZ6xOoCa0Sh3xS27vVXWs6Bf7RbxvNfDamf8kgCIhiySYKhogvYS99ZIE4QPaiJWDUo1JiMb8XqavWtKdxf9ZBd9TWvWLNnSXUZvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(396003)(39840400004)(16526019)(66946007)(478600001)(26005)(66476007)(30864003)(6486002)(186003)(66556008)(9686003)(316002)(86362001)(6506007)(6666004)(6512007)(55236004)(38350700002)(1076003)(38100700002)(4326008)(8676002)(83380400001)(5660300002)(52116002)(2616005)(2906002)(6916009)(956004)(8936002)(107886003)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KBRrPd4OX249zFCcfRJtVsMrONfIWxFqPgmEHoS6c9y0jfZBGNTN7SWZFgxc?=
 =?us-ascii?Q?l2xDMMLeVBzatSER/7BgUAiVeFx+EkoDWiV7gBckPZDIoHCX05P9lTavvpT6?=
 =?us-ascii?Q?VJULnOfFdoxqBCmbvupR44WIHq/kku21e0Lg0/whp01qnOvPU5eVNMF2NwU3?=
 =?us-ascii?Q?sWZ8shiVzRCQYRhHnk9B85T0FZRxdxPUhSfSDBFFZB0VEKzpnulk0zWxiUJ1?=
 =?us-ascii?Q?RO2MYpuk1kq2a+iEWEHbu0hO2VVuYJPC1NfymHEJm+ztIomEWB68dnJdSFDL?=
 =?us-ascii?Q?hgbcFeSYzm6rAmAs+XSXOO+3X3fwFNB9kR1JsSm/ZUbhDbK1PcL7qJI45pFf?=
 =?us-ascii?Q?uv/BtRj0R6PkIVGsA+KwKkrfwP7M7Bc88/0OIGPKLb2OVKgdIcpa+xdYf7dz?=
 =?us-ascii?Q?5g/ycw7+6Boq4Y/3gUnLzovOxQwA5tRIUn/Oo4G1m5cxAz7croqPTiOkAGZ+?=
 =?us-ascii?Q?XFTpFAat831s4OT3A7EHzgteZ8Ob9/QdOd5xSdZO4v01BQtEhQVEhLdoRVbT?=
 =?us-ascii?Q?KL4wmwwn67mxuzaAXUZyQV983YWT5m7gnzSsV2PPwZbxdA2pnsrZN4t3ZGgY?=
 =?us-ascii?Q?WZEIpvKL+oIEKZRIpeNHyvEgSlTVEYVLnZhHLsmR2lRho9E75zeFrYc1eu3s?=
 =?us-ascii?Q?st5B6u9TNacB8BQKZDdCtfg4MSWFU2P9gnP97JT5SWIHnWypgA6TVfY7KLwg?=
 =?us-ascii?Q?FGNYw5rfYBgXgzXpN1VnxZosjByUU1neV9dAxt2Z+nsC1wlfUIYJl0PruSux?=
 =?us-ascii?Q?nc2QZX+fcT9P7bnDg3Er6HI4Rk7v7RaVh09HIFG0z1Lr6yJFn71qJmjcSZU6?=
 =?us-ascii?Q?hpssQhYmR+FvepG5uQQUEQqDb/UDTLoe1Kt3k9aS6bUvjdxZhMmuqBA0gyLV?=
 =?us-ascii?Q?ZMlGAmBHx5wlpOnYa/rahIZ1+n226ZFQcVcysUQ+27LC2OacuMvk248yDTEp?=
 =?us-ascii?Q?O0j9sGcYILtjE3XWJg8Inq0rJDgs+obY0Qb1y1IAAueezzVwPqkMX+YxE/J4?=
 =?us-ascii?Q?iHpOauoE9I6An2kXYL6sPPbYcfBSx3845obPYVcGrJSFIkjumPcmn/czYgvA?=
 =?us-ascii?Q?U3RThj1/xXQKfKW/Qjk/u9H9oXLCjjNJTmmBJEYg8MpjHezJpvgsgMYyjBa5?=
 =?us-ascii?Q?Rx5IIqyQRjr43dmDkC0+NYIk11KogRnXDDpZpgwUi+uyMoLJ361QAD5qIv0D?=
 =?us-ascii?Q?xn6Y97JjdBv/ZIcgnE5qhuFQCmf8P0SQWyKQdtSZ9gS++yBEwubPESR1YMB/?=
 =?us-ascii?Q?CRJJqnwXOQJN78I/qMw7fllxJ0XK5j8Pj/ZrE//k9wJ845iBl9wjm++vFqA/?=
 =?us-ascii?Q?HDu8YpHwIQXbYjRBF2onMX2v?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719eccc2-ade0-43de-77e1-08d931a9864d
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:02.4503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LXW7JnLcuPl685Nl/2C5baipqgHGGFTXagFT7EhQH6O8Aejt1r2ovmSp4/1j/dlp25XNuPNklm53Nu1OfJWTEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0871
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/ext/vlan_dscp.c  | 658 ++++++++++++++++++
 1 file changed, 658 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/ext/vlan_dscp.c

diff --git a/drivers/net/wireless/celeno/cl8k/ext/vlan_dscp.c b/drivers/net=
/wireless/celeno/cl8k/ext/vlan_dscp.c
new file mode 100644
index 000000000000..9942d5599ffb
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/ext/vlan_dscp.c
@@ -0,0 +1,658 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include <linux/if_vlan.h>
+#include <linux/string.h>
+
+#include "ext/vlan_dscp.h"
+#include "utils/ip.h"
+#include "vif.h"
+#include "hw.h"
+#include "utils/utils.h"
+
+#define VLAN_DSCP_DBG(...) \
+       do { \
+               if (cl_hw->vlan_dscp.debug) \
+                       pr_debug(__VA_ARGS__); \
+       } while (0)
+
+static u8 get_vlan_pbit_up(struct cl_hw *cl_hw, u8 pbit_val, u16 vlan_id_v=
al, u8 ap_idx)
+{
+       /* Get UP from VID + priority bits */
+       u8 user_priority =3D 0;
+       u8 pbit_found =3D 0;
+       struct cl_vid_user *vid_user;
+       struct cl_vlan_dhcp_params *vlan_dhcp_params =3D
+               &cl_hw->vlan_dscp.vlan_dhcp_params[ap_idx];
+       int j;
+
+       for (j =3D 0; j < CL_USER_PRIO_VALS; j++) {
+               vid_user =3D &vlan_dhcp_params->vlan_pbit_to_up[pbit_val][j=
];
+               if (vid_user->vid =3D=3D 0)
+                       break; /* End of vid list in this Pbit raw */
+
+               if (vlan_id_val =3D=3D vid_user->vid) {
+                       user_priority =3D vid_user->user_prio;
+                       pbit_found =3D 1;
+                       break;
+               }
+       }
+
+       /* Use vlan_to_up mapping */
+       if (pbit_found =3D=3D 0)
+               user_priority =3D vlan_dhcp_params->vlan_to_up[pbit_val];
+
+       VLAN_DSCP_DBG("[%s] vlan_id_val=3D%u, pbit_val=3D%u, ap_idx=3D%u, u=
ser_priority=3D%u\n",
+                     __func__, vlan_id_val, pbit_val, ap_idx, user_priorit=
y);
+
+       return user_priority;
+}
+
+static u8 get_ip_user_priority(struct cl_hw *cl_hw, u8 *src_buf, u16 proto=
col, u8 ap_idx)
+{
+       /* Get UP from DSCP value */
+       u8 user_priority =3D cl_hw->vlan_dscp.vlan_dhcp_params[ap_idx].dscp=
_to_up[0];
+       u8 dscp_val =3D 0;
+
+       if (protocol =3D=3D ETH_P_IP) /* IPv4 */
+               dscp_val =3D (*(src_buf + 1) & 0xfc) >> 2;
+       else
+               dscp_val =3D (ntohs(*(u16 *)src_buf) >> 6) & 0x3f;
+
+       if (dscp_val > 63) {
+               VLAN_DSCP_DBG("[%s] bad DSCP value =3D %u\n", __func__, dsc=
p_val);
+               return user_priority;
+       }
+
+       /* Look for priority in the DSCP array */
+       user_priority =3D cl_hw->vlan_dscp.vlan_dhcp_params[ap_idx].dscp_to=
_up[dscp_val];
+       if (user_priority =3D=3D U8_MAX) {
+               /* Value wasn't found in the array. use regular parsing */
+               if (protocol =3D=3D ETH_P_IP) /* IPv4 */
+                       user_priority =3D (*(src_buf + 1) & 0xe0) >> 5;
+               else /* IPv6 */
+                       user_priority =3D ((*src_buf) & 0x0e) >> 1;
+       }
+
+       VLAN_DSCP_DBG("[%s] dscp_val=3D%u, user_priority=3D%u, ap_idx=3D%u\=
n",
+                     __func__, dscp_val, user_priority, ap_idx);
+
+       return user_priority;
+}
+
+static int print_configuration(struct cl_hw *cl_hw, u8 ap_idx)
+{
+       /* Print all the configuration parameters for specific AP */
+       struct cl_vlan_dscp *dscp =3D &cl_hw->vlan_dscp;
+       struct cl_vlan_dhcp_params *param =3D &dscp->vlan_dhcp_params[ap_id=
x];
+       u8 i, j;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
+       cl_snprintf(&buf, &len, &buf_size,
+                   "AP %u\n", ap_idx);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
+       cl_snprintf(&buf, &len, &buf_size,
+                   "enable =3D %s\n", dscp->enable[ap_idx] ? "True" : "Fal=
se");
+       cl_snprintf(&buf, &len, &buf_size,
+                   "up_layer_based =3D %u [0-AUTO 2-VLAN 3-DSCP]\n", param=
->up_layer_based);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "default_vlan_up =3D %u\n", param->default_vlan_up);
+
+       cl_snprintf(&buf, &len, &buf_size, "\ndscp_to_up:\n");
+
+       for (i =3D 0; i < CL_USER_DSCP_VALS; i++) {
+               cl_snprintf(&buf, &len, &buf_size,
+                           "dscp=3D%u up=3D%u", i, param->dscp_to_up[i]);
+               if ((i + 1) % 8 =3D=3D 0)
+                       cl_snprintf(&buf, &len, &buf_size, "\n");
+               else
+                       cl_snprintf(&buf, &len, &buf_size, "\t");
+       }
+
+       cl_snprintf(&buf, &len, &buf_size, "\n\nvlan_to_up:\n");
+       for (i =3D 0; i < CL_USER_PRIO_VALS; i++)
+               cl_snprintf(&buf, &len, &buf_size,
+                           "%3u ", param->vlan_to_up[i]);
+
+       cl_snprintf(&buf, &len, &buf_size, "\n\nvlan_pbit_to_up:\n");
+       for (i =3D 0; i < CL_USER_PRIO_VALS; i++) {
+               cl_snprintf(&buf, &len, &buf_size, "pbit %u\t", i);
+               for (j =3D 0; j < CL_USER_PRIO_VALS; j++)
+                       cl_snprintf(&buf, &len, &buf_size,
+                                   "v=3D%u,up=3D%u\t",
+                                   param->vlan_pbit_to_up[i][j].vid,
+                                   param->vlan_pbit_to_up[i][j].user_prio)=
;
+
+               cl_snprintf(&buf, &len, &buf_size, "\n");
+       }
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static void read_dscp_parms_format1(struct cl_hw *cl_hw, char *buffer, u8 =
ap_idx)
+{
+       int i;
+       int num_of_str;
+       char *tok_ptr;
+       char *mac_ptr;
+       char *str_ptr[CL_USER_DSCP_VALS];
+       u8 dscp;
+       u8 user_prio;
+       u32 val;
+       struct cl_vlan_dhcp_params *vlan_dhcp_params =3D
+               &cl_hw->vlan_dscp.vlan_dhcp_params[ap_idx];
+
+       mac_ptr =3D strsep(&buffer, ";");
+       for (num_of_str =3D 0; mac_ptr && (num_of_str < ARRAY_SIZE(str_ptr)=
); num_of_str++) {
+               str_ptr[num_of_str] =3D mac_ptr;
+               mac_ptr =3D strsep(&buffer, ";");
+       }
+
+       for (i =3D 0; i < num_of_str; i++) {
+               val =3D U32_MAX;
+               dscp =3D U8_MAX;
+               user_prio =3D U8_MAX;
+
+               /* Get DSCP 0-63 */
+               tok_ptr =3D strsep(&str_ptr[i], ",");
+
+               if (!tok_ptr) {
+                       pr_err("dscp_to_up0_7dec: dscp null\n");
+                       continue;
+               }
+               if (kstrtou32(tok_ptr, 10, &val) !=3D 0) {
+                       pr_err("dscp_to_up0_7dec: invalid dscp (%s)\n", tok=
_ptr);
+                       continue;
+               }
+               if (val > 63) {
+                       pr_err("dscp_to_up0_7dec: dscp exceeds 63 (%u)\n", =
val);
+                       continue;
+               }
+
+               dscp =3D (u8)val;
+
+               /* Get user priority */
+               val =3D U32_MAX;
+               tok_ptr =3D strsep(&str_ptr[i], ",");
+
+               if (!tok_ptr) {
+                       pr_err("dscp_to_up0_7dec: up null\n");
+                       continue;
+               }
+               if (kstrtou32(tok_ptr, 10, &val) !=3D 0) {
+                       pr_err("dscp_to_up0_7dec: invalid up (%s)\n", tok_p=
tr);
+                       continue;
+               }
+               if (val > 7) {
+                       pr_err("dscp_to_up0_7dec: up exceeds 7 (%u)\n", val=
);
+                       continue;
+               }
+
+               user_prio =3D (u8)val;
+
+               /* At this point the 2 parameters are valid: dscp, and user=
_prio */
+               if (vlan_dhcp_params->dscp_to_up[dscp] =3D=3D U8_MAX)
+                       /* First time initialization for this dscp */
+                       vlan_dhcp_params->dscp_to_up[dscp] =3D user_prio;
+               else
+                       pr_warn("dscp_to_up0_7dec[%u] is already set with u=
ser_prio %u."
+                               "Will not set it with a different user_prio=
 %u\n",
+                               dscp, vlan_dhcp_params->dscp_to_up[dscp], u=
ser_prio);
+       }
+}
+
+static void read_dscp_parms_format2(struct cl_hw *cl_hw, char *buffer, u8 =
ap_idx)
+{
+       int i;
+       char *mac_ptr;
+       u8 dscp_val;
+       struct cl_vlan_dhcp_params *vlan_dhcp_params =3D
+               &cl_hw->vlan_dscp.vlan_dhcp_params[ap_idx];
+
+       for (i =3D 0, mac_ptr =3D strsep(&buffer, ","); mac_ptr; mac_ptr =
=3D strsep(&buffer, ","), i++) {
+               if (i > (CL_USER_PRIO_VALS - 1)) {
+                       pr_err("dscp_to_up0_7dec: DSCP exceeds %d entries!"
+                              "Remaining DSCP entries ignored\n", CL_USER_=
PRIO_VALS);
+                       break;
+               }
+
+               if (kstrtou8(mac_ptr, 10, &dscp_val) !=3D 0) {
+                       pr_err("dscp_to_up0_7dec: Invalid dscp (%s)\n", mac=
_ptr);
+                       continue;
+               }
+
+               if (dscp_val > 63) {
+                       pr_err("dscp_to_up0_7dec: illegal dscp value %u."
+                              "Converted to %u\n", dscp_val, (dscp_val & 0=
x3F));
+                       dscp_val &=3D 0x3F;
+               }
+
+               vlan_dhcp_params->dscp_to_up[dscp_val] =3D i;
+       }
+
+       if (i < (CL_USER_PRIO_VALS - 1))
+               pr_warn("dscp_to_up0_7dec: only %d first DSCP entries fille=
d in."
+                       "Remaining DSCP entries will remain unassigned\n", =
i + 1);
+}
+
+static void read_dscp_parms_from_buffer(struct cl_hw *cl_hw, char *buffer,=
 u8 ap_idx)
+{
+       /*
+        * Initiate configuration per AP index by buffer by
+        * configuration parameter dscp_to_up0_7dec
+        */
+       char *pch;
+       struct cl_vlan_dhcp_params *vlan_dhcp_params =3D
+               &cl_hw->vlan_dscp.vlan_dhcp_params[ap_idx];
+
+       if (!buffer || (strlen(buffer) =3D=3D 0))
+               return;
+
+       /* Initially fill with illegal dscp value */
+       memset(vlan_dhcp_params->dscp_to_up, U8_MAX, CL_USER_DSCP_VALS);
+
+       pch =3D strchr(buffer, ';');
+       if (pch)
+               /* Handle the follow format dscp_val1,up;dscp_val2,up;dscp_=
val3,up;... */
+               read_dscp_parms_format1(cl_hw, buffer, ap_idx);
+       else
+               /* Handle the follow format dscp_to_up_0,dscp_to_up_1,dscp_=
to_up_2,... */
+               read_dscp_parms_format2(cl_hw, buffer, ap_idx);
+}
+
+static void read_vlan_parms_format1(struct cl_hw *cl_hw, char *buffer, u8 =
ap_idx)
+{
+       int i, j, num_of_str;
+       char *mac_ptr, *tok_ptr;
+       char *str_ptr[CL_USER_PRIO_VALS * CL_USER_PRIO_VALS];
+       u8 pbit, user_prio;
+       u8 helper[CL_USER_PRIO_VALS];
+       u16 vid;
+       u32 val;
+       struct cl_vlan_dhcp_params *vlan_dhcp_params =3D &cl_hw->vlan_dscp.=
vlan_dhcp_params[ap_idx];
+
+       /*Initialize array */
+       for (i =3D 0; i < CL_USER_PRIO_VALS; i++) {
+               for (j =3D 0; j < CL_USER_PRIO_VALS; j++) {
+                       vlan_dhcp_params->vlan_pbit_to_up[i][j].vid =3D 0;
+                       vlan_dhcp_params->vlan_pbit_to_up[i][j].user_prio =
=3D 0;
+               }
+               helper[i] =3D 0;
+       }
+
+       mac_ptr =3D strsep(&buffer, ";");
+
+       for (num_of_str =3D 0; mac_ptr && (num_of_str < ARRAY_SIZE(str_ptr)=
); num_of_str++) {
+               str_ptr[num_of_str] =3D mac_ptr;
+               mac_ptr =3D strsep(&buffer, ";");
+       }
+
+       for (i =3D 0; i < num_of_str; i++) {
+               val =3D U32_MAX;
+               pbit =3D U8_MAX;
+               vid =3D U16_MAX;
+               user_prio =3D U8_MAX;
+
+               /* Get vid */
+               tok_ptr =3D strsep(&str_ptr[i], ",");
+               if (!tok_ptr) {
+                       pr_err("vlan_to_up0_7dec: vid null\n");
+                       continue;
+               }
+               if (kstrtou32(tok_ptr, 10, &val) !=3D 0) {
+                       pr_err("vlan_to_up0_7dec: invalid vid (%s)\n", tok_=
ptr);
+                       continue;
+               }
+               if (val > 4095) {
+                       pr_err("vlan_to_up0_7dec: vid exceeds 4095 (%u)\n",=
 val);
+                       continue;
+               }
+
+               vid =3D (u16)val;
+
+               /* Get p-bit */
+               val =3D U32_MAX;
+               tok_ptr =3D strsep(&str_ptr[i], ",");
+
+               if (!tok_ptr) {
+                       pr_err("vlan_to_up0_7dec: pbit null\n");
+                       continue;
+               }
+               if (kstrtou32(tok_ptr, 10, &val) !=3D 0) {
+                       pr_err("vlan_to_up0_7dec: invalid pbit (%s)\n", tok=
_ptr);
+                       continue;
+               }
+               if (val > 7) {
+                       pr_err("vlan_to_up0_7dec: pbit exceeds 7 (%u)\n", v=
al);
+                       continue;
+               }
+
+               pbit =3D (u8)val;
+
+               /* Get user priority */
+               val =3D U32_MAX;
+               tok_ptr =3D strsep(&str_ptr[i], ",");
+
+               if (!tok_ptr) {
+                       pr_err("vlan_to_up0_7dec: up null\n");
+                       continue;
+               }
+               if (kstrtou32(tok_ptr, 10, &val) !=3D 0) {
+                       pr_err("vlan_to_up0_7dec: invalid up (%s)\n", tok_p=
tr);
+                       continue;
+               }
+               if (val > 7) {
+                       pr_err("vlan_to_up0_7dec: up exceeds 7 (%u)\n", val=
);
+                       continue;
+               }
+
+               user_prio =3D (u8)val;
+
+               /* At this point all 3 parameters are valid: p-bit, vid and=
 user_prio */
+               if (vid !=3D 0) {
+                       if (helper[pbit] < CL_USER_PRIO_VALS) {
+                               struct cl_vid_user *vid_user =3D
+                                       &vlan_dhcp_params->vlan_pbit_to_up[=
pbit][helper[pbit]];
+
+                               vid_user->vid =3D vid;
+                               vid_user->user_prio =3D user_prio;
+                               helper[pbit]++;
+
+                               /*
+                                * Mark the fact that vlan_pbit_to_up
+                                * array has been initialized
+                                */
+                               if (vlan_dhcp_params->vlan_pbit_to_up[0][0]=
.user_prio =3D=3D (u8)(-1))
+                                       vlan_dhcp_params->vlan_pbit_to_up[0=
][0].user_prio =3D 0;
+                       }
+               } else {
+                       vlan_dhcp_params->vlan_to_up[pbit] =3D user_prio;
+               }
+       }
+}
+
+static void read_vlan_parms_format2(struct cl_hw *cl_hw, char *buffer, u8 =
ap_idx)
+{
+       struct cl_vlan_dhcp_params *vlan_dhcp_params =3D &cl_hw->vlan_dscp.=
vlan_dhcp_params[ap_idx];
+       int i;
+       char *mac_ptr;
+       u8 user_prio;
+
+       for (i =3D 0, mac_ptr =3D strsep(&buffer, ","); mac_ptr; mac_ptr =
=3D strsep(&buffer, ","), i++) {
+               if (i > (CL_USER_PRIO_VALS - 1)) {
+                       pr_warn("vlan_to_up0_7dec: Priority bit exceeds %d =
entries!"
+                               "Rest of Priority bits ignored\n", CL_USER_=
PRIO_VALS);
+                       break;
+               }
+
+               if (kstrtou8(mac_ptr, 10, &user_prio) !=3D 0) {
+                       pr_err("dscp_to_up0_7dec: Invalid up (%s)\n", mac_p=
tr);
+                       continue;
+               }
+
+               if (user_prio > 7) {
+                       pr_err("vlan_to_up0_7dec[%d]: illegal user priority=
 %u."
+                              "Set it to %u\n", i, user_prio, (user_prio &=
 0x7));
+                       user_prio =3D (user_prio & 0x7);
+               }
+
+               vlan_dhcp_params->vlan_to_up[i] =3D user_prio;
+       }
+
+       if (i < (CL_USER_PRIO_VALS - 1))
+               pr_warn("vlan_to_up0_7dec: only %d first priority bits entr=
ies filled in."
+                       "Remaining priority bits will remain unassigned\n",=
 i + 1);
+}
+
+static void read_vlan_parms_from_buffer(struct cl_hw *cl_hw, char *buffer,=
 u8 ap_idx)
+{
+       /*
+        * Initiate configuration per AP index by buffer
+        * by configuration parameter vlan_to_up0_7dec
+        */
+       struct cl_vlan_dhcp_params *vlan_dhcp_params =3D
+               &cl_hw->vlan_dscp.vlan_dhcp_params[ap_idx];
+       int i;
+       char *pch;
+
+       if (!buffer || (strlen(buffer) =3D=3D 0))
+               return;
+
+       /* Assume initially no change in vlan user priority */
+       for (i =3D 0; i < CL_USER_PRIO_VALS; i++)
+               vlan_dhcp_params->vlan_to_up[i] =3D i;
+
+       /* Assume initially vid_pbit NVRAM parameter is not initialized */
+       vlan_dhcp_params->vlan_pbit_to_up[0][0].user_prio =3D (u8)(-1);
+
+       pch =3D strchr(buffer, ';');
+       if (pch)
+               /* Handle format vlan_id1,pbit,up;vlan_id2,pbit,up;vlan_id3=
,pbit,up.. */
+               read_vlan_parms_format1(cl_hw, buffer, ap_idx);
+       else
+               /* Handle the follow format dscp_to_up_0,dscp_to_up_1,dscp_=
to_up_2,... */
+               read_vlan_parms_format2(cl_hw, buffer, ap_idx);
+}
+
+static void read_layer_based_parms_from_buffer(struct cl_hw *cl_hw, char *=
buffer, u8 ap_idx)
+{
+       if (!buffer || (strlen(buffer) =3D=3D 0))
+               return;
+
+       if ((strcmp(buffer, "AUTO") =3D=3D 0) || (strcmp(buffer, "0") =3D=
=3D 0))
+               cl_hw->vlan_dscp.vlan_dhcp_params[ap_idx].up_layer_based =
=3D 0;
+       else if ((strcmp(buffer, "VLAN") =3D=3D 0) || (strcmp(buffer, "2") =
=3D=3D 0))
+               cl_hw->vlan_dscp.vlan_dhcp_params[ap_idx].up_layer_based =
=3D 2;
+       else if ((strcmp(buffer, "DSCP") =3D=3D 0) || (strcmp(buffer, "3") =
=3D=3D 0))
+               cl_hw->vlan_dscp.vlan_dhcp_params[ap_idx].up_layer_based =
=3D 3;
+       else
+               pr_err("%s: invalid input [%s]\n", __func__, buffer);
+}
+
+static void read_default_vlan_up_parms_from_buffer(struct cl_hw *cl_hw, ch=
ar *buffer, u8 ap_idx)
+{
+       u8 default_vlan_up;
+
+       if (!buffer || (strlen(buffer) =3D=3D 0))
+               return;
+
+       if (kstrtou8(buffer, 10, &default_vlan_up) !=3D 0) {
+               pr_err("invalid param - %s\n", buffer);
+               return;
+       }
+
+       if (default_vlan_up < 8)
+               cl_hw->vlan_dscp.vlan_dhcp_params[ap_idx].default_vlan_up =
=3D default_vlan_up;
+}
+
+static int cl_vlan_dscp_cli_help(struct cl_hw *cl_hw)
+{
+       char *buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+
+       if (!buf)
+               return -ENOMEM;
+
+       snprintf(buf, PAGE_SIZE,
+                "qos usage:\n"
+                "-a : Set ce_dscp_to_up0_7dec0 [val]\n"
+                "-b : Set ce_vlan_to_up0_7dec0 [val]\n"
+                "-c : Set ce_up0_7_layer_based [val]\n"
+                "-d : Set ce_up0_7_default_vlan_user_prio [val]\n"
+                "-e : Enable/Disable QOS functionality [1/0]\n"
+                "-s : Show current QoS configuration\n"
+                "-v : Enable/Disable QOS debug [1/0]\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+void cl_vlan_dscp_init(struct cl_hw *cl_hw)
+{
+       struct cl_tcv_conf *conf =3D cl_hw->conf;
+       u8 ap_idx;
+
+       for (ap_idx =3D 0; ap_idx < MAX_BSS_NUM; ap_idx++) {
+               cl_hw->vlan_dscp.enable[ap_idx] =3D conf->ce_dscp_vlan_enab=
le[ap_idx];
+               cl_hw->vlan_dscp.vlan_dhcp_params[ap_idx].up_layer_based =
=3D
+                       conf->ce_up0_7_layer_based[ap_idx];
+               cl_hw->vlan_dscp.vlan_dhcp_params[ap_idx].default_vlan_up =
=3D
+                       conf->ce_up0_7_default_vlan_user_prio[ap_idx];
+       }
+
+       /* Ce_dscp_to_up0_7decX */
+       read_dscp_parms_from_buffer(cl_hw, conf->ce_dscp_to_up0_7dec0, 0);
+       read_dscp_parms_from_buffer(cl_hw, conf->ce_dscp_to_up0_7dec1, 1);
+       read_dscp_parms_from_buffer(cl_hw, conf->ce_dscp_to_up0_7dec2, 2);
+       read_dscp_parms_from_buffer(cl_hw, conf->ce_dscp_to_up0_7dec3, 3);
+       read_dscp_parms_from_buffer(cl_hw, conf->ce_dscp_to_up0_7dec4, 4);
+       read_dscp_parms_from_buffer(cl_hw, conf->ce_dscp_to_up0_7dec5, 5);
+       read_dscp_parms_from_buffer(cl_hw, conf->ce_dscp_to_up0_7dec6, 6);
+       read_dscp_parms_from_buffer(cl_hw, conf->ce_dscp_to_up0_7dec7, 7);
+
+       /* Ce_vlan_to_up0_7decX */
+       read_vlan_parms_from_buffer(cl_hw, conf->ce_vlan_to_up0_7dec0, 0);
+       read_vlan_parms_from_buffer(cl_hw, conf->ce_vlan_to_up0_7dec1, 1);
+       read_vlan_parms_from_buffer(cl_hw, conf->ce_vlan_to_up0_7dec2, 2);
+       read_vlan_parms_from_buffer(cl_hw, conf->ce_vlan_to_up0_7dec3, 3);
+       read_vlan_parms_from_buffer(cl_hw, conf->ce_vlan_to_up0_7dec4, 4);
+       read_vlan_parms_from_buffer(cl_hw, conf->ce_vlan_to_up0_7dec5, 5);
+       read_vlan_parms_from_buffer(cl_hw, conf->ce_vlan_to_up0_7dec6, 6);
+       read_vlan_parms_from_buffer(cl_hw, conf->ce_vlan_to_up0_7dec7, 7);
+}
+
+bool cl_vlan_dscp_is_enabled(struct cl_hw *cl_hw, struct cl_vif *cl_vif)
+{
+       return cl_hw->vlan_dscp.enable[cl_vif->vif_index];
+}
+
+u8 cl_vlan_dscp_check_ether_type(struct cl_hw *cl_hw, struct sk_buff *skb,=
 u8 ap_idx)
+{
+       /* Calculate the user priority according to the celeno logic and co=
nfiguration */
+       struct cl_vlan_dhcp_params *vlan_dhcp_params =3D &cl_hw->vlan_dscp.=
vlan_dhcp_params[ap_idx];
+       u8 user_priority =3D 0;
+       u16 ether_type;
+       u8 *src_buf =3D skb->data;
+
+       /* VLAN TCI: 3-bit UP + 1-bit CFI + 12-bit VLAN ID */
+       u16 vlan_id_val =3D 0;
+       u8 pbit_val =3D 0;
+
+       /* Get Ethernet protocol field*/
+       ether_type =3D get_ether_type(2 * ETH_ALEN, src_buf);
+       /* Skip the Ethernet Header.*/
+       src_buf +=3D ETH_HLEN;
+
+       /*
+        * handel LLC packets
+        * if it's a LLC packet we should move the data pointer and to
+        * get the ether type from the llc header add support to other LLC
+        */
+       if (ether_type <=3D 1500) {
+               /* 802.3, 802.3 LLC
+                * DestMAC(6) + SrcMAC(6) + Length(2) +
+                * DSAP(1) + SSAP(1) + Control(1) +
+                * if the DSAP =3D 0xAA, SSAP=3D0xAA, Contorl =3D 0x03, it =
has a 5-bytes SNAP header.
+                * =3D> + SNAP (5, OriginationID(3) + etherType(2))
+                */
+               if (PKT_HAS_LLC_HDR(src_buf)) {
+                       /* Get new ether_type */
+                       ether_type =3D get_ether_type(LENGTH_LLC + LENGTH_S=
SNAP - 2, src_buf);
+                       src_buf +=3D LENGTH_LLC + LENGTH_SSNAP; /* Skip thi=
s LLC/SNAP header */
+               }
+       }
+
+       if (ether_type =3D=3D ETH_VLAN || skb->vlan_tci !=3D 0) {
+               if (skb->vlan_tci !=3D 0) {
+                       pbit_val =3D (skb->vlan_tci >> PBIT_OFFSET);
+                       vlan_id_val =3D skb->vlan_tci & VID_MASK;
+               } else {
+                       /* VLAN tag: 3-bit UP + 1-bit CFI + 12-bit VLAN ID =
*/
+                       vlan_id_val =3D *(u16 *)src_buf;
+                       vlan_id_val =3D htons(vlan_id_val);
+                       vlan_id_val =3D vlan_id_val & VID_MASK;
+                       ether_type =3D get_ether_type(LENGTH_VLAN_HDR - 2, =
src_buf);
+                       pbit_val =3D (*(src_buf) & 0xe0) >> 5;
+               }
+
+               /* Only use VLAN tag */
+               if (vlan_dhcp_params->up_layer_based !=3D CL_UP_BY_L3) {
+                       user_priority =3D get_vlan_pbit_up(cl_hw, pbit_val,=
 vlan_id_val, ap_idx);
+                       goto out;
+               }
+
+               if (ether_type =3D=3D ETH_VLAN)
+                       src_buf +=3D LENGTH_VLAN_HDR; /* Skip the VLAN Head=
er.*/
+       }
+
+       ether_type =3D htons(*(u16 *)(src_buf - 2));
+
+       if (vlan_dhcp_params->up_layer_based !=3D CL_UP_BY_L2) {
+               /*
+                * GET user priority by DSCP
+                * If it is an IP packet and up_layer_based =3D=3D 3 (DSCP)=
,
+                * we will check it's DSCP parameter
+                */
+               if (ether_type =3D=3D ETH_P_IP || ether_type =3D=3D ETH_P_I=
PV6) {
+                       u8 version =3D (*src_buf & 0xf0);
+
+                       if ((version =3D=3D IP_V_IPV6 || version =3D=3D IP_=
V_IPV4))
+                               user_priority =3D get_ip_user_priority(cl_h=
w, src_buf,
+                                                                    ether_=
type, ap_idx);
+               }
+       }
+
+out:
+       VLAN_DSCP_DBG("ether_type=3D0x%X, vlan_tci=3D0x%X, pbit_val=3D%u, v=
lan_id_val=3D%u, priority=3D%u\n",
+                     ether_type, skb->vlan_tci, pbit_val, vlan_id_val, use=
r_priority);
+
+       return user_priority;
+}
+
+int cl_vlan_dscp_cli(struct cl_hw *cl_hw, struct cl_vif *cl_vif, char *dat=
a)
+{
+       u8 ap_idx =3D cl_vif->vif_index;
+       char *payload_start =3D data + 3;
+
+       if (!(payload_start && strlen(payload_start)))
+               return cl_vlan_dscp_cli_help(cl_hw);
+
+       /*
+        * workaround: delete last 'space' symbol if it is present in the p=
ayload
+        * this is caused by Celeno iw command convention - automatically a=
dded after all payload
+        */
+       if (payload_start[strlen(payload_start) - 1] =3D=3D ' ')
+               payload_start[strlen(payload_start) - 1] =3D '\0';
+
+       if (!strncmp(data, "-a.", 3)) {
+               read_dscp_parms_from_buffer(cl_hw, payload_start, ap_idx);
+       } else if (!strncmp(data, "-b.", 3)) {
+               read_vlan_parms_from_buffer(cl_hw, payload_start, ap_idx);
+       } else if (!strncmp(data, "-c.", 3)) {
+               read_layer_based_parms_from_buffer(cl_hw, payload_start, ap=
_idx);
+       } else if (!strncmp(data, "-d.", 3)) {
+               read_default_vlan_up_parms_from_buffer(cl_hw, payload_start=
, ap_idx);
+       } else if (!strncmp(data, "-e.", 3)) {
+               if (kstrtobool(payload_start, &cl_hw->vlan_dscp.enable[ap_i=
dx]) !=3D 0)
+                       pr_err("invalid data - %s\n", payload_start);
+       } else if (!strncmp(data, "-v.", 3)) {
+               if (kstrtobool(payload_start, &cl_hw->vlan_dscp.debug) !=3D=
 0)
+                       pr_err("invalid data - %s\n", payload_start);
+       } else if (!strncmp(data, "-s.?", 4)) {
+               return print_configuration(cl_hw, ap_idx);
+       }
+
+       pr_err("%s(): error in parameters\n", __func__);
+       return cl_vlan_dscp_cli_help(cl_hw);
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

