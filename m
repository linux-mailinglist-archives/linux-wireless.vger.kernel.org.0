Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778BC3AB872
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhFQQIK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:10 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:64480
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231364AbhFQQHa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJoDMuy3umHHOmq2uTuKm7DJ44JWyMNxGncArs4oHp9pm2fOkwVKbvbwTRyPQzw3jgAjywEmRBxu9NloP3AM5hGiiLQUIMpYGhySqT9F4nxwAcGrqZ/Z6YmMOLm1yE8LyxZ/jrZ5k3gITKaQ9HO6fNPvfzWtcRUwyATB4ueqlGHZD1i6jkpQgqQ+Kjxbfc9XxaeMDRkk27b2aFLsqwR2irkqEB45zHhHs+KCvWa7u+C2A8hG29mwn/xhvL8p/YGa+R0ueDQT6eewiEGp1ED52/DrOybdBpxkXoTQSpikmJhkY9GsxVafcE3drCqJ+8q5qyUlxuEnmRGb1xeaZxj/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v83xR2y+6jWPYcaiFGaZyKF1TVwLJ31JIqOb+5Y5sjQ=;
 b=j8Dx2G6IglkQ+gujHpz1lJZSz4ceC2w57hN+9pHwuEBndUaJAwInwR01rxHzeGy0uBX9MtB/F7uAvGLWoi9g1wSXwJr0I0H2jsaGm/JhyTNuIk9RKYmpC5Ue45Zjrwnq0WB5WGvp1c9+P1/0tTpo+EUm3RUKtrkDnq7x8pjzg3UYmG3JegkVyjLQd+81fZUNtlFupRHIVCJb9KVXxspVjIOcwyrSlW68wS+exf9rtQ6e+LT/bb6HwkPfBE5I4kCsy34OaAMj0wdw/eSUliCp+KeGj7NIQl4u3nzaM7Io/G4POxKG69U2fsrkQ7C+G7KAHwX14c7b6dBPEKt8VmYV2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v83xR2y+6jWPYcaiFGaZyKF1TVwLJ31JIqOb+5Y5sjQ=;
 b=umfdg6ywZ3EwaHchV46JjQ29st4DZ+L5sGoh7DpCL95uWGusB2Hf+1zVyllPocooM+eF+eJo8bj2eHbolsKitiD8Mj65hOHd4vaVH0dG1FHcbe950tF/rFCbxGj+3+vfSKnfHOTc7+a0lqd6zM5Am75AyW69hFdQOSMPLSSd+9o=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0402.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:46::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:05:07 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:07 +0000
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
Subject: [RFC v1 108/256] cl8k: add mac_addr.h
Date:   Thu, 17 Jun 2021 15:59:55 +0000
Message-Id: <20210617160223.160998-109-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4628bcf-1af5-4720-553f-08d931a998d0
X-MS-TrafficTypeDiagnostic: AM0P192MB0402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB04028F29CE86D1778A605720F60E9@AM0P192MB0402.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: duP692S/CL+DxIbW6KW/kZ2NHAna/VKgxV/r6Tvb6UsvFPQM0viPYRj2HWcRx05GQQ+wEqf7avB/GArebmXirvtruzMjO6ko0XlEySM9troIfFhQdblz0C3ScjOMzVNVtKD030Yg9inCV8UMwgQ/9h4TxVcf0+HzNJ1b6OgHnR9lb8P4HS7iOdWJmVeiC9Vc1pj3nP7eO2W+QtYzSQ9kJsQW7Q7DR5zwNVw9/EG4A3mSEGaFDamVy+uk5+eacHucWYp6dGbQ11+XzbLZe2uM94MQFRRiU4yAAwom59eXzyF1qjy1G/nfBpj8aQsxpxhEGIHXfZgHWYhxsh8kF7n4A0neeyp617Z+LtqSVDGY0Did5J/8wIq0crIPwFd4lg9jbDM0oYURCGiTWjT/5isBUQVOY3t8a+goO6lj81sGmWC7Mzh32nNdTaL3X8GlIPL6/blGb5Lro8iuClyvrT7qIGnt/pjU+rBFsGu6cDhft0yI1JiU/ioMyuP9E1Z6fKIEohiNSN/4ksAH1DLMHEQ1y/IXLECzSYrw6SR5zwiEuwHWGE6JpK5PTg7DrtU0t5LJTzH6NoaYlHytchkXzqvonfcZbZKwI/kNRSIkkha3vBwjIrz7F7jqZA7wjzyCZSQ/xcDAhChdmr5SZ3KJ4GVdkreZGYHT9oDqShYLTYFytbf74Xg2hBGwpcWHi4cWYQ9zDN4P37B/LnCH/V7YB4JUqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39850400004)(136003)(376002)(396003)(366004)(346002)(6916009)(6512007)(9686003)(6666004)(52116002)(2616005)(186003)(16526019)(38100700002)(38350700002)(1076003)(6506007)(5660300002)(107886003)(55236004)(86362001)(6486002)(8936002)(956004)(26005)(8676002)(508600001)(2906002)(36756003)(54906003)(316002)(66946007)(66556008)(4326008)(66476007)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8ookLLOTmJYjWddg/LeAYq+GOOJF9KXRj9o5EsyPxrIx7Q8WpYaXH0zqaLVW?=
 =?us-ascii?Q?nJ35xFn6hSQQzWVmQfST1zFiOL/jT1VV7Z5/Cpr9m0hCub8eodLSgkcvZ/3M?=
 =?us-ascii?Q?ekPcV41CuLSwAUG+dQFLvvaeLmnKJVmDK44spl8rWO/IGpd42UzsxEWRXP+F?=
 =?us-ascii?Q?KwWBTAPoLT58MCKjVhYIRNMYxgtwiSLFg8W996JrvOx4TrkFclrIRlwBax2w?=
 =?us-ascii?Q?vxAwikVYFiTMSxvnkCXHTWsKQ/F2O7HmZ+9QdF7Zo1Nf09b4t6PaNhADEU3r?=
 =?us-ascii?Q?0WHeB5y5p7lCZFsv4jrx3zlsc66Z7EO9g156pe/TnieQp78JTiQoVnyA0jjj?=
 =?us-ascii?Q?CreTfQ8G/H5aubDRrLy5ih/yLf1CKqSxs87f7Zs1nmy08INEb57gglCE7hgs?=
 =?us-ascii?Q?b9kfnNNs57yDnfMNRvZi0uKuD87WkuE1LXsgTNbnkSeTTbXNPkh9HuWTR16S?=
 =?us-ascii?Q?hPWdUfir6YTHhiX1SNRhprZ6scDZqqY0Kc9fvnlHmIFJTWGPOVNOkSJPNwhl?=
 =?us-ascii?Q?sUpL63UwIhVV1BH/1hrCSEaZhamQlRNCbZamrgLnuuXwU2nhq/6ESIOePh7l?=
 =?us-ascii?Q?5rckNFJue+QeOWPg4UGzTrcjCUV5K25/sezruTYTrepnmaUJqx/HgyyyGkn3?=
 =?us-ascii?Q?INunBxblhsGrZ1mvsSHSkaX51I3nlJ1sy3pOd+gW6XuMy/QSC4UEodFmwLze?=
 =?us-ascii?Q?d9AlTbrvGikTRnikYjsyr4nGATFTRu8pFOpRFTMQbCY1Kp46YfkXvbUdX9pr?=
 =?us-ascii?Q?gc8DW2bfW1pJs9BHl74HLxEYbMe6BQ4UNQmCOXBJI08OR9UeS8jKBjZf7qcj?=
 =?us-ascii?Q?q9T+uNi3vHUwUpR8qC09sUMipRLEDhN2OeyrVjiLFwla/uHjn+9tESeGUSuA?=
 =?us-ascii?Q?nv5/YhslvqY4I9BJNNErd7EonIf2G51PJcX54W07Vx+9X3DOkApHqXg8bT2F?=
 =?us-ascii?Q?MGuOPZOPnhh2I/WFJ9rz2JmaDvW/5Zmp39hdGo6OjnbOVAP73jrcMmQKkt7h?=
 =?us-ascii?Q?4eAq4p37OLCT+Dw3aweXGhc4alcFjhLgixkx17ElCZLJJ3ZZQLT1kXYhd6UN?=
 =?us-ascii?Q?eWk4BfQPg+GHZi9Xov9v3/42+bNMwurmY/9arnvfd3sspAiiWKJERo4gbb8w?=
 =?us-ascii?Q?xeI7G10+Ik2tMw/Z59d4tFI8yISZ0Wg48Rkf7ekVuXt1i4/tFz7Fq6qbgDUD?=
 =?us-ascii?Q?pJbDicuMhhazDdHhLXQACUvZsHwP3updI0uLgecmfEb1Ex9u6lnCcqLG9Qat?=
 =?us-ascii?Q?dnICpQkyQFTzbyPrnYRvksyI8eTxecb3y61IMRMvP1G8kXGqPmSrj4q1i4s4?=
 =?us-ascii?Q?GfuUIjpvBJPE5skpTM5VXu03?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4628bcf-1af5-4720-553f-08d931a998d0
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:33.4014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvLnX4QKcFdlcHOnv7CeHU5YJHZ5tlyDnrWds+IlDtfSb/agh1dl9x6tKwQ46WvKVrOXPxSVmWRv8/SJw66mAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0402
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/mac_addr.h | 67 +++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/mac_addr.h

diff --git a/drivers/net/wireless/celeno/cl8k/mac_addr.h b/drivers/net/wire=
less/celeno/cl8k/mac_addr.h
new file mode 100644
index 000000000000..6cd264c32f58
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/mac_addr.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_MAC_ADDR_H
+#define CL_MAC_ADDR_H
+
+#include "hw.h"
+
+int cl_mac_addr_set(struct cl_hw *cl_hw);
+
+static inline void cl_mac_addr_copy(u8 *dest_addr, const u8 *src_addr)
+{
+       memcpy(dest_addr, src_addr, ETH_ALEN);
+}
+
+static inline void cl_mac_addr_move(u8 *dest_addr, const u8 *src_addr)
+{
+       memmove(dest_addr, src_addr, ETH_ALEN);
+}
+
+static inline bool cl_mac_addr_compare(const u8 *addr1, const u8 *addr2)
+{
+       return !memcmp(addr1, addr2, ETH_ALEN);
+}
+
+static inline bool cl_mac_addr_is_zero(const u8 *addr)
+{
+       const u8 addr_zero[ETH_ALEN] =3D {0};
+
+       return !memcmp(addr, addr_zero, ETH_ALEN);
+}
+
+static inline bool cl_mac_addr_is_broadcast(const u8 *addr)
+{
+       const u8 addr_bcast[ETH_ALEN] =3D {0xff, 0xff, 0xff, 0xff, 0xff, 0x=
ff};
+
+       return !memcmp(addr, addr_bcast, ETH_ALEN);
+}
+
+static inline bool cl_mac_addr_parse_str(const u8 *str, u8 *addr)
+{
+       return (sscanf(str,
+                      "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx",
+                      &addr[0],
+                      &addr[1],
+                      &addr[2],
+                      &addr[3],
+                      &addr[4],
+                      &addr[5]) =3D=3D ETH_ALEN);
+}
+
+static inline void cl_mac_addr_array_to_nxmac(u8 *array, u32 *low, u32 *hi=
gh)
+{
+       /* Convert mac address (in a form of array) to a C nxmac form.
+        * Input: array - MAC address
+        * Output: low - array[0..3], high - array[4..5]
+        */
+       u8 i;
+
+       for (i =3D 0; i < 4; i++)
+               *low |=3D (u32)(((u32)array[i]) << (i * 8));
+
+       for (i =3D 0; i < 2; i++)
+               *high |=3D (u32)(((u32)array[i + 4]) << (i * 8));
+}
+
+#endif /* CL_MAC_ADDR_H */
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

