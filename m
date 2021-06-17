Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AFB3AB8BB
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbhFQQKJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:09 -0400
Received: from mail-vi1eur05on2070.outbound.protection.outlook.com ([40.107.21.70]:44832
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231181AbhFQQJE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgEOyTlukYxkYLK0+6U4p70AVqZCQJ8GUN4R8+kmHSNPZlRTsviKxAlQTDzVHiCJXI8RMcTiZQvOnBUgHg0Pn6NNM+XbJsgYFRu8E94Y59yMJkeiUvdJDublwKSlIFvjVeS8/IWRP6NnCX1DT/3K9ae+CHJihYbYKTRz94t6jTmdeuOjX5UMPcJIAy3/pRXpn5bx/Z7QYBXqWVrmV9eWQBI5a/j+IeXMmDJg/I8GyT29FW82qTUsfrXT4lNCABjCMP1dEu+9/klIdhDUP34K22dwgJckN48wbVkno/905SqwtHFPsN9WUKZZgeHadWM1NCtvu6iPhmMn6bH6FXBuBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUjOIkRXqBIxQPjljie43tBZM5yMmGpXVxDU+1jaUDg=;
 b=W53F/QisAlfddw7BJUKRxpegzUOJYwrozjeaHRcjfvj/R4PCqA2UNFD0Nb1EMZnPQaBUGy5EosEqJYKq7j5MU2PsnnBDWUDQZWNs0VNBvU589f+mZ3Sb9g3x0JcUJCq+Kcjpf87Kt13USSdnZpFRGu6we9PrGkOBc52Kty9Tkav9mDg1ySKUbRSXVqlEMV62suCGPkSkAuAVHkSWdkUm8p4e4hMHk9sLlZAyPXzNWjpUD/vTpws+aizf12j2U0hUe6TYLJ6rHZunBnQt1+NKf89IsEHXbIOd6h/JVxTAkCaBJ0asmI+KIof+sVbJpDH3KJD6EzP+DZlIpXIqrwO5rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUjOIkRXqBIxQPjljie43tBZM5yMmGpXVxDU+1jaUDg=;
 b=V5nIhoKkz4zNEYHCSWeWid+THqnED9ofEIxaORgJX1YXWud6sV+pmLBKjQ1tARHb8nOxLVNEixlpLXHwUM3569CxxAlay/tPrvqGYJpR42uBWoMGseVZAaw4+gFWbEfBYavXn0Le6sr4DqRtUCTxi5suFqfeg6w1U2C0NXGjjcQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1314.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:47 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:47 +0000
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
Subject: [RFC v1 134/256] cl8k: add power.h
Date:   Thu, 17 Jun 2021 16:00:21 +0000
Message-Id: <20210617160223.160998-135-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62fb9a7e-b1ae-4fba-0334-08d931a9a9b9
X-MS-TrafficTypeDiagnostic: AM9P192MB1314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1314A1937435FE5E3967497AF60E9@AM9P192MB1314.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8PGKR0R1VqCcQoiS+N/O8TnEkY1c/G2ZC0e2S2/+DaMRR2C4SRM0MR0naTRt/HMjUt5gNIL/wUzM6aE7TKf57AfC9wavPey0VnfgrUlo9Rk8Dkny/r6udQgLteN0DfmsoM1Ae326sJH3CZrvveeKQrqnPmabdVV3Z4Df6ki71guFLW5FLduAmbfAryGATYBcKdjTBMd5U2Eis/3pdSMgXde+i28p2N6trhZDrU/Rwv1l9jAF6fTDe/N1hzMl8qgI3e2zWxAzv22AsN6+uIEUW9NkVtMruMxIo7xs96yYu1HZPxiEkujnaXjBcqbEiAFMeccUYoQ1MClCLzbRKglC6OaEtkKOa417yDToL1nbQqZ2e9aVZ9dh/Vwg3MbNILCazPdBbBTilmhAYv+TamAl4n+3UfDFOWdp1S1nfEJTPVKEfkeag2h7nU0Iwzt7iFe+tA/9SxlIhHc1CmnaiKLGxEcY/eK2MCYvw6P5evNEdr30uJsJHm48pqDgjyHi734BDW54rJVxnZocO4SC4CQRTm5uWZdjvUMnrIyqZoGUuSiGd2Ra9c0vf/px7xKpzKjnPPZcVtrtXbQl39t9i/dkNshdTMtIkLyhS0bHHSNt98WlNMWsxI/vZgsd12yelyrg2j8N/L1Zy8TvwJgNHuVFauuS8BhjBQcVepHbKFF2aKWTsSCJgMv0ShW4H1TgJw5naNRnhGwBVV/d5NlABkqSfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(39840400004)(366004)(376002)(136003)(346002)(8936002)(66946007)(83380400001)(186003)(5660300002)(26005)(36756003)(86362001)(8676002)(55236004)(1076003)(6916009)(2906002)(6506007)(66476007)(478600001)(6666004)(38350700002)(52116002)(66556008)(956004)(4326008)(107886003)(54906003)(38100700002)(6486002)(2616005)(316002)(16526019)(6512007)(9686003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dWZd6VBFLPIYFchKsYv7mV3Xb7QwtFJmmG/yRCyboQcIQ2p6Cx7lOLbX/YGW?=
 =?us-ascii?Q?SIY6HR8BTZDDWnaT7mwqhl2QaL2JgR93xjKjvIVbx1vm80A5dPrNhHTeeoxO?=
 =?us-ascii?Q?5gWVHX8njp1Wmb3SK33o8cgi4qou1ZDhrGvOQ64UdI7pSwEv8mRWKTZKAL5h?=
 =?us-ascii?Q?gyLVg5y+ZFQtOAjo/YlaDOpFLnspVWkOri1AN9dNzKtVwjqVQ0gSGN5pq8qy?=
 =?us-ascii?Q?0/SidZaHMA8ghYzmaOkq5sCgMVwR1eAOXmmuT0L6lmWALcoB5NzjVEdDbHhT?=
 =?us-ascii?Q?jNJIu6GZ+snY0b4+MXsBesVWm3pW+XiyJMcA9UKhqvSDxBMr6p4jwq0PqRB7?=
 =?us-ascii?Q?9FMQ8sxtoQuV3OfoSFi7DLFjkveYKVaaI/a/ofvdlKCF0+x/qWcriNeKjoo4?=
 =?us-ascii?Q?wWZe/gTUdZeY9OgUe+nETT77B+p+xmd8J/PZtq63JugQnRh2HhvphmSN8T7s?=
 =?us-ascii?Q?AgPE3VtXyCX93qJhQlpn+2Uu7McxQMl/HrryFZfgEcQdQdbA+TqezW6U07EM?=
 =?us-ascii?Q?hH+tGekzKG1+fjAzZBCZ7v8+v0KRUc5HudMhj5ZtcKHOmiXhlL/JuiQMUpzM?=
 =?us-ascii?Q?YUMKvRB28A5++kXMdp0/+Sfsggv0JC6n24DbKuyTdeQYBF8d00OwYS0INOFs?=
 =?us-ascii?Q?0n/J2/AHitcbcgeTQjw4rKEw2lA4h9jxF69AHxe1DnJGEmLV7XrrW4/0jeZq?=
 =?us-ascii?Q?m8w5Aw9uDic+coWbmqZhPAl7ZrJhmsZown0//6PPc1Ls7qswDnfLO9hGn6KN?=
 =?us-ascii?Q?dfikUNK797dy15BZMhscHaMufKqav0qRq+yrGbCh/1v3ysptj78MRf9dDCeR?=
 =?us-ascii?Q?LJUF7V5i4dNfM7ErJafbJzCLhZTxzD5rHtE/Rm0PXa+gwSP6UTqXSuGjiI1m?=
 =?us-ascii?Q?IxDXcsF4kkKnPzjyNETpE/M1bDutQNuZUfzhHKtTsJTEjjL8og1xqYhaS7/8?=
 =?us-ascii?Q?Faqgt/8eDK8M8eee2LF4eEeZUdpTrdW6gxbf+Hd2b/6GljWQbbK6elieF673?=
 =?us-ascii?Q?bRA2YlVbbGj7Kq86nvqIYPCtsnD/FAfA1VCOAZvd/jmi8uXlAygxU2PkUAm8?=
 =?us-ascii?Q?2kG7ZWYVZZiK8PhyTZGxkIGGO3NL1+0weWemwmQ4iKVxWjkBZGwFkJx8qRZ8?=
 =?us-ascii?Q?dvTiG7REfxij+GCQRM3l9dlITobBmWBb7r86rEjAKVwz1KuskPC0bFTN2tan?=
 =?us-ascii?Q?I9E2ElWp5I1HyV0zHJbJ8CUrGc5kcUQZTfFWzmDpu/9zPIIQep2dWqeJMddS?=
 =?us-ascii?Q?kFtKehX621lnGkg5f6I02ZuV2YStExeTjMj5Wi3pQ5PRx01g+Ud6NA4cbTiN?=
 =?us-ascii?Q?8hBQmbb1ylHJ89Vr7lhuRHQB?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62fb9a7e-b1ae-4fba-0334-08d931a9a9b9
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:01.7778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FiyeVKAChSxAXwfAo16wMI574V/dTMZVYwvInRcGAgq8n7nUVj+RDJo4PLmmLgLMQbN5IIDyZzCxpibtFHwFuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1314
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/power.h | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/power.h

diff --git a/drivers/net/wireless/celeno/cl8k/power.h b/drivers/net/wireles=
s/celeno/cl8k/power.h
new file mode 100644
index 000000000000..3dc12d618c7c
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/power.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_POWER_H
+#define CL_POWER_H
+
+#include "hw.h"
+
+#define POWER_MAX_DB 30
+#define POWER_MIN_DB -10
+
+#define POWER_MIN_DB_Q1 (POWER_MIN_DB << 1)
+#define POWER_MIN_DB_Q8 (POWER_MIN_DB << 8)
+
+#define POWER_OFFSET_RES 4
+
+#define POWER_OFFSET_MAX_Q2 (16 << 2)  /* +16dB * 4 */
+#define POWER_OFFSET_MIN_Q2 (-16 << 2) /* -16dB * 4 */
+
+u8 cl_power_tx_ant(struct cl_hw *cl_hw, enum cl_wrs_mode mode);
+s32 cl_power_antenna_gain_q8(struct cl_hw *cl_hw);
+s32 cl_power_antenna_gain_q1(struct cl_hw *cl_hw);
+s32 cl_power_array_gain_q8(struct cl_hw *cl_hw, u8 tx_ant);
+s8 cl_power_array_gain_q2(struct cl_hw *cl_hw, u8 tx_ant);
+s32 cl_power_array_gain_q1(struct cl_hw *cl_hw, u8 tx_ant);
+s32 cl_power_bf_gain_q1(struct cl_hw *cl_hw, u8 tx_ant, u8 nss);
+s32 cl_power_min_ant_q1(struct cl_hw *cl_hw);
+s8 cl_power_bw_factor_q2(struct cl_hw *cl_hw, u8 bw);
+s32 cl_power_average_calib_q1(struct cl_hw *cl_hw, u8 ant_num);
+s32 cl_power_total_q1(struct cl_hw *cl_hw, s8 pwr_offset_q1, u8 tx_ant, u8=
 nss,
+                     enum cl_wrs_mode mode, bool is_auto_resp);
+s8 cl_power_offset_q1(struct cl_hw *cl_hw, u8 mode, u8 bw, u8 mcs);
+s8 cl_power_offset_check_margin(struct cl_hw *cl_hw, u8 bw, u8 ant_idx, s8=
 offset_q2);
+void cl_power_tables_update(struct cl_hw *cl_hw, struct cl_pwr_tables *pwr=
_tables);
+s32 cl_power_get_max(struct cl_hw *cl_hw);
+
+#endif /* CL_POWER_H */
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

