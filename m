Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A095E3AB8C2
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhFQQKV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:21 -0400
Received: from mail-vi1eur05on2059.outbound.protection.outlook.com ([40.107.21.59]:25895
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231840AbhFQQJP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwsY0l9jnCoTiIUimOk/69UfFiRZIndT9kIP/axzscz3/MfM7C9xTLioVsuzCNVdgDpU1+Qp90gMMDd/6mJhxv/5bIxVd/TCbFU7u+FAlxXxrZhYPTICRCxVkS8yEcmFGs6JDhBb5A6w+dPkuiMBEYPdkmRVxPL0HDyKcUgkXSvNyK5+1K/p+rv/mjtKE01K8jwBABzzISrHyfXlyrUSQRr2fe80AJa+IteqO5rs4Ny2SZl09+/D64RUUZ/Zly1+jwCcwY5pQeFcCp+M/h18mZxcV5JsjYWBRgUjZfP3WdYR5hiNWuxYo4kyFvjAf1S47DhCy7eKu++DQ4UwoiLTUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkmPKcbuwnXOuSHWk3+S7nCtesZrQ44UNqN0Yu9i/js=;
 b=aq+2mC77w2AN3qV6OWb6T4yGe5tAeislalIFBpmMnIIgmg+bxtGORmv/XgopeFMkxKKE2MH/RgdObvx/oxofl9/BE5yiJP4FmjVE7ZmWOBfsPkCq4rZmwupr1ziEcyZ8icFS9PZYdgRcUsp3CpMwsNmoH+ozqqxeJepkI2mp6FtzYPHpSC8findOA0r2isyEjK4q9s1YyYmaf7bW+ENL30nfGoGO9H+IuT1YRtlJbsLOxxET6GiGhm8DlEXBH6E9pplr5wNRA2nB5XDV0wM65BPbKY21JZFMJ8IwJRNxzX+U8OAVK/7B4S1bKCHt4gkGdSqGAQeDUwuOKM32xnNuGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkmPKcbuwnXOuSHWk3+S7nCtesZrQ44UNqN0Yu9i/js=;
 b=hvkwlPkEgtNYgq9kWhOjvLv5H1rBULTB8pudCrcnjNJ4IuRhWl82lovRkHnc2pXPX0RxSLAAKcX6Vqc+Zb/DXk1MEokhLU9QneL5HVaO7Qg2oakA4IonZfqOLKra9XxbhF4aiK1uO2pEW79y49Qt3T3Qmf//jjZt5D+oSAlPZwU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1059.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:05:52 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:52 +0000
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
Subject: [RFC v1 147/256] cl8k: add reg/ceva.h
Date:   Thu, 17 Jun 2021 16:00:34 +0000
Message-Id: <20210617160223.160998-148-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a52fd2b7-583e-4069-41c0-08d931a9b253
X-MS-TrafficTypeDiagnostic: AM8P192MB1059:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB1059916A107FCEEBB1169758F60E9@AM8P192MB1059.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yS1W6SaudPC96kda708y5pfVAWqZKCL85MPtx83a+ldVn+ACumWAOHORIcUW8xaC7JinjXkU/dH26czL6lcnmZumoBBu5N/U03WK6qogO09/2JrJ2D8IaIhqji0II06w5faMQwGBwfwperF9Vw4+EhasBbWnx19qhKu3L4xNsM0yfZZghojt6C9BgOZ+5SYmAXI5HipxLHO9MAJttFA+Wul531JsfGfW4f4K7dF/lWsFGLT5D0uhjXqv+DWlPYhmtKULl87eeI4Q1YmwvcC3xlxuI5+FKNuAB8RCfIAv9MfMazN+zxEIUFldMAItg6xN4u29nR7JQmoenJIKzFx3/gtKyAw310ZOZiOrSa1c7XWxX7tFkKEgv7GfBr67ejSJhr9NJrX7Z4QiaRmKfa1Vzz6Pjpiew/rm+0D784pL0a3LYTve+zvEr3mN0zwa3R5mnvQmtJuwguytrbRp4S3u1yVpqCyi5gmPedWCklqTKcMh5+V0hsYjcqwy0lhLHyjAUsi9re467H370JZVWc8vBMQHyyyKYsrBeswbkqGiPRkxNl9QSWrm7k4+5t/Va/OXmB5/AZXYcLbu/XoDvkDFcuH2hcIP1E8F+e7KF35KNPdxPCJ2Ygp+3qDiX4fSX+qJi8VX6UsfysbjmG+Ko6fabJZzMMiKGX8TF2EjVET/brPnSw2F5JTSyuwhSONL9eQoaxjSj4TrYlEaYPGEzclHUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39840400004)(346002)(136003)(376002)(396003)(366004)(26005)(956004)(478600001)(186003)(66556008)(16526019)(107886003)(66946007)(66476007)(8936002)(6916009)(2616005)(1076003)(2906002)(54906003)(6506007)(6666004)(4326008)(38100700002)(38350700002)(83380400001)(9686003)(6512007)(5660300002)(6486002)(86362001)(316002)(55236004)(36756003)(52116002)(8676002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kFRm6RCvXk2knBLPSsEdfHD4OFcrPTzLy3rPWOdZLgQE7Awh3JVJeetLFgiq?=
 =?us-ascii?Q?MKSWZrg40a0ZMUvo4MgAgikYSFa3wuRjigkXxcmtXJfH+2XPs/T5mN0SUT1K?=
 =?us-ascii?Q?79pq6Yt7m0zkqPiEJy54yjTLd5MiUcFahtAhbZe90dVxvrARtXcvu+AksDrk?=
 =?us-ascii?Q?mKiHxNwBSLuv7p6mtzzbI/1jCrG0Iu0zTi7MojehUHFATenfGWtifmeHv+7k?=
 =?us-ascii?Q?XNqiadrQFTH/zm4nDDCdi6k5aT0Muk8DCwp/OqeJ/h3OLH6s6kTPBdmuRjCN?=
 =?us-ascii?Q?i+xFcoYGnEe1WpdSuqUAEuB92VDHd3/KrJQwvN9AKXPsIWuEktVL7wNY7S6I?=
 =?us-ascii?Q?NAkJ1mvaruHC9eDlsh1AF+MEGeXelXq7dhxOf7hBLw1Za5Y7Gu1XUpzSogyL?=
 =?us-ascii?Q?xQ/nGmOEKaRvGtk7O0ExVtxZjIeD9SumDFcggoV/4C91ZnAr49/QFQZ03hn5?=
 =?us-ascii?Q?/jj1smPUFN7dMM5ILdGso1S0b8ZZrLq42fpx3by545oSw2MYTgN9IW7YK4/G?=
 =?us-ascii?Q?/AwbVNS/bP1WKvzJefUsnf95iCwhVHwtE8/98DhX0qFACwTyT7Y0n0CX83Mx?=
 =?us-ascii?Q?H1LHAnl+1nwQo7pW1Bmp8Sd2d5Ltzbc+UXGPGB9QlreYY7rb3DXoyDe3jBr9?=
 =?us-ascii?Q?2wxRHqb264ytlUCGKO4Bd9GBJ8uGfN8GMQy/hN+sZaZXcwDi8RdiUzuAF/ab?=
 =?us-ascii?Q?hSqa/MDymSYi2Mhl9uMCN3CywXg1WVddU+QIakrtTVki19zVTIwyROAea4dC?=
 =?us-ascii?Q?iigt7xGbU9kZDLhAeB4n3Z0atncIZpjKpnYIf63xjn/tjmEht/6/nitT92NM?=
 =?us-ascii?Q?PQ3uRqiGu1nNf9/aBQGy64HW8Zab4gs9acYlxfkQ1B72j1JF+9ESMNA4eV9y?=
 =?us-ascii?Q?a73Rr3TMtMqOMkey4vGvBJRn5WhNeD3JCkH/1KKNZZvAehwwr51e2DOinXm3?=
 =?us-ascii?Q?TxPJkqLFLNcnFNxD7TzKp6STOV+fajxVlnnk+h9qc9J76PuHSVczMfo9V3LW?=
 =?us-ascii?Q?sMt3C1LRxuQiK1tbzE7pk8joTaOskESePxYX2zCx2nZ+Q/CDOfc1oCCBwz3V?=
 =?us-ascii?Q?Kzht87nsrMWkXDYO3pahN9vuwbMDv1Pb522dEkaEvB5hdIvDwGXMoUq4NkiH?=
 =?us-ascii?Q?G3wwNw2haai9BTerXKC/jRVQyxZ4JflxVzbQuKmUmkIoAE/vgmVENZKA1QpO?=
 =?us-ascii?Q?AbfAKfFin05hzjZCGe6DnRgmX79MDvekgZ2lWxbOgPA1+nEdqoD++hdP+hiX?=
 =?us-ascii?Q?uTai4oL3JNngYxrpXCiQ6M0ZlcFpjr+O5+z/Yy3PSIWjed9RnwRGBrD/lFpd?=
 =?us-ascii?Q?dw1V9RGWfFBN+zhXDIx6wuni?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52fd2b7-583e-4069-41c0-08d931a9b253
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:16.1974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgS0+6QRimHjYbykOyakNDs7mGTNw/MkDXfMvW0WAk2Q+7UB3C8baOln+IirUg+ulB/WVERSIlttX+Qh/xjFLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1059
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/reg/ceva.h | 44 +++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/ceva.h

diff --git a/drivers/net/wireless/celeno/cl8k/reg/ceva.h b/drivers/net/wire=
less/celeno/cl8k/reg/ceva.h
new file mode 100644
index 000000000000..3e5f79b0cc14
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/reg/ceva.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_CEVA_H
+#define CL_CEVA_H
+
+#define CEVA_MCCI_BASE_ADDR 0x004B0000
+
+#define CEVA_CORE_VERSION_ADDR (CEVA_MCCI_BASE_ADDR + 0x1000)
+#define CEVA_CORE_ID_ADDR (CEVA_MCCI_BASE_ADDR + 0x1004)
+
+#define CEVA_CPM_BASE_ADDR (CEVA_MCCI_BASE_ADDR + 0x2000)
+
+/* PDMA */
+#define CEVA_CPM_PDEA_REG (CEVA_CPM_BASE_ADDR + 0x0008) /* External */
+#define CEVA_CPM_PDIA_REG (CEVA_CPM_BASE_ADDR + 0x000C) /* Internal */
+#define CEVA_CPM_PDTC_REG (CEVA_CPM_BASE_ADDR + 0x0010) /* Control */
+
+/* DDMA */
+#define CEVA_CPM_DDEA_REG (CEVA_CPM_BASE_ADDR + 0x001c) /* External */
+#define CEVA_CPM_DDIA_REG (CEVA_CPM_BASE_ADDR + 0x0020) /* Internal */
+#define CEVA_CPM_DDTC_REG (CEVA_CPM_BASE_ADDR + 0x0024) /* Control */
+
+#define CEVA_CPM_DDTC_WRITE_COMMAND 0x40000000
+
+/* Translated internally to 0x60600000. */
+#define CEVA_SHARED_PMEM_BASE_ADDR_FROM_HOST 0x004C0000
+
+/* Internal address to access Shared */
+#define CEVA_SHARED_PMEM_BASE_ADDR_INTERNAL 0x60600000 /* PMEM */
+#define CEVA_SHARED_XMEM_BASE_ADDR_INTERNAL 0x60900000 /* XMEM */
+
+#define CEVA_DSP_DATA_SIZE 0x80000 /* 512kB. */
+#define CEVA_DSP_EXT_DATA_SIZE 0x60000 /* 384kB. */
+
+/* 512kb */
+#define CEVA_INTERNAL_PMEM_SIZE 0x80000
+
+#define CEVA_SHARED_PMEM_SIZE 0x20000 /* 128kb */
+#define CEVA_SHARED_XMEM_SIZE 0x60000 /* 384kB */
+
+#define CEVA_MAX_PAGES (CEVA_INTERNAL_PMEM_SIZE / CEVA_SHARED_PMEM_SIZE)
+
+#endif /* CL_CEVA_H */
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

