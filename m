Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE563AB8B8
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbhFQQKB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:01 -0400
Received: from mail-vi1eur05on2083.outbound.protection.outlook.com ([40.107.21.83]:50945
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233751AbhFQQIu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNGf49F671yo9aGlfjLG5AyqdvK+rpuQd07HTWAN+U22XyBQYnwEbK5GYTO0onByLxcdRwyYWV0MZkWxpcb6Sg9s0zGKIspMfurQ7XAs8LbnO95iLNZNgYrlCOjfg4O1wmFW98WeVXgJQdLZBwNFKCJVj4VTe4ueYHXzlqokT7D+QGWG/nodBbnQlbO1odI7m9sOGlapNjNkudC5poqX+KN1SOIWCS6blWj/vXAy9Gp/BcFKsqWaN5NmbnNnrj2Onb2mzg73vB/o6FWwN6FX8uq1Rh+APu0AM4WdDxWK1yhkg+XhAsc2ZDgEOST1/gRGjvPpvPWn2JKl5x8EDAGCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ipDd6DCgmMgxcfWE2rZdnhtayBweSvsOLwoLZqdCpM=;
 b=RBPg3JKQwaIDYn9xPGZt4niQZnpSH4TS1uuJiGw4uT2UDUwsmWvVTvjC16vmYS8jSBgxvvo1LicOQJYt137JxC/S08HYPv4iU6yBYOSquqNlXgCzstavlQ5y21KPT2gM+1h55ta6JHTWVO2PopokiM01zWAzLOmyfvb0UFjw+bt8JrQ1GeoQ5nAqOfxulqO9cWZ54RZspFf+Qny1yAnh5wtExJRZTm78TkyZOz3bH9s7Q+a9pVDmOtrfgHZLbDJUiCyY+GWNK+pS/dqYxxaUZaD7DSlB0xXEuO7BIaohGJMhbDSJmljclRB2wA22HnDTmg9DyJwYxK9CKtQHPlztYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ipDd6DCgmMgxcfWE2rZdnhtayBweSvsOLwoLZqdCpM=;
 b=CtlxUEffOEV1KMvL1zBSRd4q287jUbmUXfzjkLhZD8ailYQv5xDCAaKeRR+j5b7D3M3gHcT0aZ8udTXlC97BpIA/NdTarp4V9/bme9jTBn+8Xep1oyQViJs+DH4SSEo/iNJClKta0on5snpyMJduE49jRabwLSZ7G3lcz2uOkXo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1314.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:44 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:44 +0000
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
Subject: [RFC v1 126/256] cl8k: add phy/phy.h
Date:   Thu, 17 Jun 2021 16:00:13 +0000
Message-Id: <20210617160223.160998-127-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dc8198a-9579-4055-e684-08d931a9a453
X-MS-TrafficTypeDiagnostic: AM9P192MB1314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1314AA2C65C2BB52D442E3D1F60E9@AM9P192MB1314.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7UDPCl8fG56JMcNIlGLWX1ZV6oPDJviVJ3Q5WT0JZwJACUsKmux0Dc+lrMtc8CXzjxK69I1Z5lCpfR23OzSrEYZfOgnqUdbPLKt+l36gwDhcvxydggK4Pap8jo7lkq1Mmrxm9g42bV8jZLaThFuhjoqMoJFJX6/CXVF0pRZw//Xp7M6CdA6BfsXpHHZPIF6IO+JCpcuTnMJ5dt0NB0GG3Gmfr0ErNsMNi0xDMiJ3tSQ/5w3exdkxfQmiJ0pAwbF9Ufa8ozPBZeD3iofivuTJeGNxkBZMA2JQrIsi94qauAl8hlsLQM0ACwYE1KG9Oa9PaeVKmaYDDxctIWm1XwTqzWEELD1Io0eRhYh9D1bFd6NAlD2CrVSAPhyvH9+l2Wvc9jYUeUQlBfCl8RSe9egkjwNz4dqhBBIc6M9xfbk8U2trF6x55gOVmj65c1JTcFzxzxsQe1HvWAkqeXkbRef3hKye8vW5RGVkufVj40/sPAw9mzAPRgPao9L0GcvvdI+c5+J/xyLCojrYz7bgty+se2PUemPpN7Isqx3n74C7IVRxm5t6EPwS1PTtFUNBCMB0Bmp+JRxdzC1IoR/IzkC+zgDn7PgMvPkoH0fs5flfCqRdDyaLpM/5oziLYOJrbaEscPPIOi3cRvJ/iRhqUA2CScGAtZwfWWZOTg6jnKddfw8DSw5+rteUngk6BDPTgmfQDMo2zP+bq3B4ajdBpWq5Fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(39840400004)(366004)(376002)(136003)(346002)(8936002)(66946007)(83380400001)(186003)(5660300002)(26005)(36756003)(86362001)(8676002)(55236004)(1076003)(6916009)(2906002)(6506007)(66476007)(478600001)(6666004)(38350700002)(52116002)(66556008)(956004)(4326008)(107886003)(54906003)(38100700002)(6486002)(2616005)(316002)(16526019)(6512007)(9686003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YCx+sg2hj/XH0pi4P57B58NpnQngvLHy8f76dNXZpb5DvTHf/eImqmCWJ11F?=
 =?us-ascii?Q?QjEJM44xeQ8g/u/Gpf/J7s8bL3Oxr2WevNAkyQy4rb+UVCBd2u//pjdUb4fN?=
 =?us-ascii?Q?ojlz5uFB8u8ZYtTeQm0cu2CMJdnQfPWCpFoeuP3P3OxptCqjnkxl//kRR/gd?=
 =?us-ascii?Q?FDbk9f2WzKZaYwC7Nc4bVMu/3beHJoyoodu9NQHRZbPIukU5PaqP44tw+DKg?=
 =?us-ascii?Q?Hvfzu06pxWH6poByn0BcHw0A81U1zTh5nicBS1FSqTTGAzRzErkBYd0WLc/L?=
 =?us-ascii?Q?w/3/KLY9toEpLsVE8ybU3VxSe3R/w+cEyolywkeuft6uCBtFZsCqYnnzMvPS?=
 =?us-ascii?Q?Xm3MfRq7yZlkd1QgtWZJgZzBdMNjnBtD/VpUTTJ+rqpUcMMryDzod4KxDldn?=
 =?us-ascii?Q?6N3rhpMrTJ1udfmX1bnlKgcCCjr+eNl8Yk6O4uWuf4i+qOpYOs/Q5tdYXqJ1?=
 =?us-ascii?Q?dVDSw6dBiZIsC00/qRb3aoggqSF2p1inDX5DWuIB3MikNMy8uSmvd05yESuO?=
 =?us-ascii?Q?GAg4Gud+oIIITjfAWvaWXGttaeswl1DcI5ut1zM8wMT3T1Q7yKbN+DSSuZiK?=
 =?us-ascii?Q?Vtor3DSFtLnl94f88ZCJA83XlwTwmq5nAdgq915LVRLCvl4u0R03+x2Xm7pU?=
 =?us-ascii?Q?i+iLm/vbzaSviQB0dGwkNX5VNn+qcifjaY+c1W+YXbHu/mx1V1Bqfr5OD/9G?=
 =?us-ascii?Q?R8xv6hzWMKZE5gP1gkefnes53d8nKU79RlvpnjkK2qAP4LX1+7Xxwxn/iQlX?=
 =?us-ascii?Q?WCSxMrFJsQuabmpDnJc9Vheald9399oW/kivyV6pqFiozFib51Kp368BmQSD?=
 =?us-ascii?Q?bsSat2VoiNTbnX+pdU5hdkROcClcNt5L7POzv4T+44Z9KKTcl9cNDuGa9D1Y?=
 =?us-ascii?Q?hfRlZt6dj3q8+6DUkYaA40tvdMvQdNQvjWj9tygHMl+oZhymwQ9Dxq3wTvDC?=
 =?us-ascii?Q?Rt1VO+K1USEeNaia7zJG7cMYzCE6z79rOhB/+psTnr/kT4G1Mq+U1TKgAvZi?=
 =?us-ascii?Q?NYzhIJtktEe40FqWN18ihYZcG6h7e1HWoPfLDpS8lb3QhBegD0hjRHqao3qJ?=
 =?us-ascii?Q?e8V7d9bPyDBwxYaTjUsSaLKbDOrxJ3Lgqxp+RPlflaVonV/NcJQHsME1t0nH?=
 =?us-ascii?Q?l8TbQmG7BJHpHI/xXkKlWIqjeSgEaXJqsOO4vj3IPKfAzvgQY9juN1/WEnbZ?=
 =?us-ascii?Q?Ekfyk4mdqm2c6m0nQfl1kPZeDBWM9ZaP+p48F/rRqWQbLxS4uoE7Ep+RvG1X?=
 =?us-ascii?Q?6JzE/C5xZ+VxdAfPx0NDe+HFCByTh+SJGZlD12uSN/x2mSE/qzXzs1mpjgVY?=
 =?us-ascii?Q?IDX1j/DqCUoqI0B7++5WtE/r?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc8198a-9579-4055-e684-08d931a9a453
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:52.7215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abX4lO6BGvLBl3ca1wKLNEuDI3p4l3hKB3LwUU4wQVGnOvNss0Z0ikD0qxtZJm0lFHW/56DLO0FalhSnabfTZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1314
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/phy/phy.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/phy/phy.h

diff --git a/drivers/net/wireless/celeno/cl8k/phy/phy.h b/drivers/net/wirel=
ess/celeno/cl8k/phy/phy.h
new file mode 100644
index 000000000000..6a58faf2cfd8
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/phy/phy.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_PHY_H
+#define CL_PHY_H
+
+#include "hw.h"
+#include "chip.h"
+
+void cl_phy_reset(struct cl_hw *cl_hw);
+void cl_phy_off(struct cl_hw *cl_hw);
+int cl_phy_load_recovery(struct cl_hw *cl_hw);
+int cl_phy_data_alloc(struct cl_hw *cl_hw);
+void cl_phy_data_free(struct cl_hw *cl_hw);
+void cl_phy_enable(struct cl_hw *cl_hw);
+
+#endif /* CL_PHY_H */
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

