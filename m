Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D815E3AB83E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbhFQQF7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:59 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:15895
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233570AbhFQQFu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWJ0VWEjIpyVt4GmdycpxqHnfIHMvJJXllpr4czC40V3D2bXLOq0BjHpCxLMP9mbr0ZZgkWe32u9ym52wpBw26NDHus3cvDKVWocurq/ny25WdYKh4QstZdzYihhWQzgNTJb722XzNAChWrOcR8Jh5MiAN+nB/jJa0n7/gwyAF5PSeUFK7g0K8BVhxu86PdwdyFNUqlEs74IhDY9FWIKHPNEyHHCzuIJgmKSTmfzxbqrOdTuXlXXk4cJmKxou+OfSQhxccQwFykEVl8tNeSDHbBcXWei5NXYB6vN/1SixKdCZBtFAcDtbcUiy+cdK+rvUimvEF4GfLR369iFWwkSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYwYPaZsms30XYnxyCOgd3OmpGbPP4OJEjBxzEb2S3Q=;
 b=fFYcMHwGLLfnCq2xyd3OhmDkmyK8osRpGzTmVJ0ek+qrUPRx4ZrcuShyvl5lQJ+StRQ0u2kYPpK+JLF56s1qYi6cX2LPlSsK8QgxmIk5+q1Pwbcpp4q/fxe2lwngGkHoUOcE76cpqai60681Z+pjQE1YPFUuhB8vQScbBO+VgsSHz8brMQTbh7UcEebaGDSlfxsELEz4Y7QdTtxC7eSzUhnZPf8mjP12cOzN+H0IJgO/afSt7p4G7biNgDAJTcmmhM2AlU7fzf8awK1W3VDqbKg0OyaoshbuirJMdFREzksWZDkLMMXWt9Y7I1h9buSZxJTN9qpWRVo+tsEaWDS3qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYwYPaZsms30XYnxyCOgd3OmpGbPP4OJEjBxzEb2S3Q=;
 b=mk3cK/AzJJhaLZ/ga9hAblQz2ru7keq+xOO+Sw5nSEXkRGx2TyL3LGUTOAOVcy7IkJeJqsa/w1X9Y1OT0WG/jmmjzfSDVIhKNLZk6mL0JRvHde+cYcd7czHuI5Dd3eIjfPi30ZngJ9tb4i1wo0jZPC2pX7pNERODlkwCPrJuMcg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0966.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Thu, 17 Jun
 2021 16:03:40 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:40 +0000
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
Subject: [RFC v1 039/256] cl8k: add channel.h
Date:   Thu, 17 Jun 2021 15:58:46 +0000
Message-Id: <20210617160223.160998-40-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 079f2c37-778c-420a-7b78-08d931a96b5d
X-MS-TrafficTypeDiagnostic: AM9P192MB0966:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0966E4FA807F4C3F5D730AEAF60E9@AM9P192MB0966.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gw/Juut75SNV0sgZblh/VraCeD1eB0AXrAgzSW2YqM6ph5ceqbdCmfEkUqMruhNkWSp+SgtEDEtz4vB82f2bUbxIi5t51PSvaPyPDrryQcnFhCw3wfer0lEI5a+ixotoxjThQSJgcJe+zPUdsBqUVX9UsfKAvmBOof4T6BfB72djAmflkpx3VJnr6X9KrrctSlWX3l+gXgtYQxQ6564azly/tCdnz7lX9CIe0ZiBJ4XROgPtJ9sLKcPbjdRfZt7YmBM2jIojONHR2Wk6CDcUHe/diQr+TYnCEkfj8Psetaq97NVnEjHoHskXrf0XQpFDApFsXmWKrxU9tv7cF9sKT6UkVOqKXDyB9Byfl0mEYAkzOz+Ismc3pEZb8iFnUNQeSDhBaI+5JeAruKN8Xu5ofSP7DCJCjrlhvhiJAFZYFQ20DrWCxmXs4/g86xNrtI4OBI4lqxZtHTDJy8BlPKy4L13ZWrwu30+nSXPisfSn9XkVn8Q51w+4t0+8OvT5qPXe++wTVJUMrlpLbMtvzDsyRSamu1S5mci/qUdM2j0YOiB1fqxjBnkHM5BUcwmd/XILc5NtMC69CU1KLGRDvTe0yRvxGAM+sGjsAh5Ytr+u8dJgehEVNnyhMy1eOluWB6jeY43ythDIb9pLLA3ReMJJnjqDJ76OsmwFUBzGshtGOCud01e6dyKYC9FQ7YM3m9mWaBPtnKQwbLcilWvhSY6cBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39850400004)(376002)(396003)(4326008)(1076003)(2616005)(8676002)(186003)(6512007)(6486002)(107886003)(83380400001)(6916009)(38100700002)(55236004)(316002)(16526019)(6506007)(38350700002)(6666004)(54906003)(8936002)(26005)(508600001)(36756003)(2906002)(9686003)(52116002)(956004)(5660300002)(66946007)(66556008)(66476007)(86362001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bUfvF3fQvdX9Q359M14MSs3Q4UqwQvN0BzlFJ0c2po/dqzjBLSt0ROHbWfmX?=
 =?us-ascii?Q?jVcphxL9pQsDuEA8xqv1kRy+lAetr//MsYNCRqzFsPKsuL0lI3KGywRF7QPk?=
 =?us-ascii?Q?FdZ9D9RNgIjI2AlNovC0nzPDSRaHiCT3eJYL/J72nj7Dxm5aU0e5JuwmAPE8?=
 =?us-ascii?Q?iv2heCfPt8MGQCGl1Q3GYOsWnR1wXzMd9Yp9SMj2Fb80WME1aQwFLIPQtcZX?=
 =?us-ascii?Q?uZKUUYLWeiVUpvsriGwGCKg58oVJKjlP42pN/3TwWRF/slEoeq3eoEYUOaFb?=
 =?us-ascii?Q?wdGmJW/J+AVrZUevLp2gLlygLZYruUherDAp2tZWZbVLZtDA0NmDuci00Xpd?=
 =?us-ascii?Q?TAMIPD9ONFR/PV40iZFZh4YXmic9S3jTYYdBEGDiMImo3o2KQxmrzdEyG1jJ?=
 =?us-ascii?Q?Bk+a/tHMUAdBPKMGUwEc3fR9tDZWmGovOo2q6XLoV8ZzDUt5iErHxoS4jZK9?=
 =?us-ascii?Q?/hQTqg1MWjIh9T+928/p6454rvks7bjTHxbO4lJuGlQ80qZWrPhDzdCYtGdN?=
 =?us-ascii?Q?S5W1qb9dhbtQA+gCccp+voQpGAyZKc9FeykKDaf5Nql4ZQX6kpvuitn2+MtK?=
 =?us-ascii?Q?SPBdKHQDnJMUh12R+vimVi/DVMsXiMPLa6BW6q3CXkaoYQv0PfJHHXXwhLf7?=
 =?us-ascii?Q?O3u4tMgQ0HDBo9cwAVR1T80YyKY/9YpPVMNG79wu7ov2fZjqly3mIcFgDDEf?=
 =?us-ascii?Q?keWz2JZMfAAJNlJHH1Z1z1G9Awy26GJXAkDLw910MyiLkYfki2y34qMebDH8?=
 =?us-ascii?Q?CgsvwKn8uWNnwLvM7Yv53yEFhha50O7A3fJ1xFpQT5hX0eSVsgHvZHDtopSJ?=
 =?us-ascii?Q?JFfKKjzmGjib1KWA87F7RU4TQmiFwiyK4FkyHucNOpr5Ui+oliPuJMzdOnex?=
 =?us-ascii?Q?F6mIc6oQJ5QDaLGFrag/NpNnm/cTDuWdC82JK++sVsBFi4UfzVzhK7mm4LFV?=
 =?us-ascii?Q?NHADI4Qaw6Sorpp2lVR9tw3+4MKciedI4zgPDrn+L5gKrYmstkIKPL83NoRt?=
 =?us-ascii?Q?kBU3mEhRr1RMDO4dXS+/wdfrzGXnkzBUGEV62bi2r86s0WQ+djvbmD08AH92?=
 =?us-ascii?Q?7/iFi22xvIA7XS2lU05O60Bi8YfM5dEL2VVUB0Lu/5a1LEJnKwSx25RYqqoh?=
 =?us-ascii?Q?qQmpGXrE0mtjeMHTUY+gIhubTy9/ibSZWHrfU4nSJfj+VXOBxnSwrRSzLmZy?=
 =?us-ascii?Q?0mRABjliyRdw7R9Ewj2FskUX11+sunoZkMkLXbQXZjIHnvw4qJKVUsKkdVVE?=
 =?us-ascii?Q?7lvjL/U8LV2Hk7sqaWdHWDc3shdFi7t12RhJik4ZSq5l36iij84JrkL4GKTA?=
 =?us-ascii?Q?81s/Ggxgq1IcnloyHq0kqBJm?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 079f2c37-778c-420a-7b78-08d931a96b5d
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:17.1492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9njhoGB4NVelM1Q1RqU9lZPL/PJdN6UQYppzwFkL/Aio3hn+UsCfEAAUyImOKfhhTmKKefUDYlXcdkHHWnBug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0966
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/channel.h | 187 +++++++++++++++++++++
 1 file changed, 187 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/channel.h

diff --git a/drivers/net/wireless/celeno/cl8k/channel.h b/drivers/net/wirel=
ess/celeno/cl8k/channel.h
new file mode 100644
index 000000000000..c31cb4f69f2a
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/channel.h
@@ -0,0 +1,187 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_CHANNEL_H
+#define CL_CHANNEL_H
+
+#include <linux/types.h>
+#include <linux/errno.h>
+
+enum chan_idx_6g {
+       b6g_ch1,
+       b6g_ch2,
+       b6g_ch5,
+       b6g_ch9,
+       b6g_ch13,
+       b6g_ch17,
+       b6g_ch21,
+       b6g_ch25,
+       b6g_ch29,
+       b6g_ch33,
+       b6g_ch37,
+       b6g_ch41,
+       b6g_ch45,
+       b6g_ch49,
+       b6g_ch53,
+       b6g_ch57,
+       b6g_ch61,
+       b6g_ch65,
+       b6g_ch69,
+       b6g_ch73,
+       b6g_ch77,
+       b6g_ch81,
+       b6g_ch85,
+       b6g_ch89,
+       b6g_ch93,
+       b6g_ch97,
+       b6g_ch101,
+       b6g_ch105,
+       b6g_ch109,
+       b6g_ch113,
+       b6g_ch117,
+       b6g_ch121,
+       b6g_ch125,
+       b6g_ch129,
+       b6g_ch133,
+       b6g_ch137,
+       b6g_ch141,
+       b6g_ch145,
+       b6g_ch149,
+       b6g_ch153,
+       b6g_ch157,
+       b6g_ch161,
+       b6g_ch165,
+       b6g_ch169,
+       b6g_ch173,
+       b6g_ch177,
+       b6g_ch181,
+       b6g_ch185,
+       b6g_ch189,
+       b6g_ch193,
+       b6g_ch197,
+       b6g_ch201,
+       b6g_ch205,
+       b6g_ch209,
+       b6g_ch213,
+       b6g_ch217,
+       b6g_ch221,
+       b6g_ch225,
+       b6g_ch229,
+       b6g_ch233,
+
+       NUM_CHANNELS_6G
+};
+
+enum chan_idx_5g {
+       b5g_ch36,
+       b5g_ch38,
+       b5g_ch40,
+       b5g_ch42,
+       b5g_ch44,
+       b5g_ch46,
+       b5g_ch48,
+       b5g_ch50,
+       b5g_ch52,
+       b5g_ch54,
+       b5g_ch56,
+       b5g_ch58,
+       b5g_ch60,
+       b5g_ch62,
+       b5g_ch64,
+       b5g_ch100,
+       b5g_ch102,
+       b5g_ch104,
+       b5g_ch106,
+       b5g_ch108,
+       b5g_ch110,
+       b5g_ch112,
+       b5g_ch114,
+       b5g_ch116,
+       b5g_ch118,
+       b5g_ch120,
+       b5g_ch122,
+       b5g_ch124,
+       b5g_ch126,
+       b5g_ch128,
+       b5g_ch132,
+       b5g_ch134,
+       b5g_ch136,
+       b5g_ch138,
+       b5g_ch140,
+       b5g_ch142,
+       b5g_ch144,
+       b5g_ch149,
+       b5g_ch151,
+       b5g_ch153,
+       b5g_ch155,
+       b5g_ch157,
+       b5g_ch159,
+       b5g_ch161,
+       b5g_ch165,
+
+       NUM_CHANNELS_5G
+};
+
+enum chan_idx_24g {
+       b24g_ch1,
+       b24g_ch2,
+       b24g_ch3,
+       b24g_ch4,
+       b24g_ch5,
+       b24g_ch6,
+       b24g_ch7,
+       b24g_ch8,
+       b24g_ch9,
+       b24g_ch10,
+       b24g_ch11,
+       b24g_ch12,
+       b24g_ch13,
+       b24g_ch14,
+
+       NUM_CHANNELS_24G
+};
+
+enum cl_ch_status {
+       CH_STATUS_SUCCESS,
+       CH_STATUS_ALREADY_ON_CHANNEL,
+       CH_STATUS_INVALID_PARAM =3D -EINVAL,
+
+       CH_STATUS_MAX
+};
+
+/* 6g band has the largest list */
+#define MAX_CHANNELS NUM_CHANNELS_6G
+
+#define START_CHAN_IDX_6G 1
+
+/* 1 =3D=3D> 5955 */
+#define FREQ6G(_chan) ((_chan) =3D=3D 2 ? 5935 : 5950 + 5 * (_chan))
+/* 36 =3D=3D> 5180 */
+#define FREQ5G(_chan) (5000 + 5 * (_chan))
+/* 1 =3D=3D> 2412 */
+#define FREQ2G(_chan) ((_chan) =3D=3D 14 ? 2484 : 2407 + (_chan) *  5)
+
+/* 6G channels - UNII-5 */
+#define START_CHAN_IDX_UNII5 1
+#define END_CHAN_IDX_UNII5   85
+/* 6G channels - UNII-6 */
+#define START_CHAN_IDX_UNII6 89
+#define END_CHAN_IDX_UNII6   109
+/* 6G channels - UNII-7 */
+#define START_CHAN_IDX_UNII7 113
+#define END_CHAN_IDX_UNII7   165
+/* 6G channels - UNII-8 */
+#define START_CHAN_IDX_UNII8 169
+#define END_CHAN_IDX_UNII8   233
+
+#define INVALID_CHAN_IDX 0xff
+
+struct cl_hw;
+
+u8 cl_channel_to_index(struct cl_hw *cl_hw, u32 channel);
+u16 cl_channel_idx_to_freq(struct cl_hw *cl_hw, u8 index);
+bool cl_channel_is_valid(struct cl_hw *cl_hw, u8 channel);
+u32 cl_channel_num(struct cl_hw *cl_hw);
+bool __must_check cl_channel_is_scan_active(struct cl_hw *cl_hw);
+
+#endif /* CL_CHANNEL_H */
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

