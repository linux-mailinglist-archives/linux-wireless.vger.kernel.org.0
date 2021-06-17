Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEE33AB83C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbhFQQF5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:57 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:15895
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233612AbhFQQFt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DE3HfU3qnbfAPPKQC4SQLKJ5ICpn1iCSDh1xt8OD18Eyi0eY06oznIjid/ri2qB06XhBxffnD0Fp3e8RC7/Qlo3xsgCZmBt2fxuU19tqJrMQ7znTA3GGKtvfFJydpyNSp6C7ZuJ+zKOHfJ7Is9XfI79hh8CZltlkKL9Au6gd1hWg0kXSTvUCOlCXF1y15n8pZs/YPbLqQNQacypsW5+amg1Zd0UOFahiX7Nyubvswep7uOaMdE9QTP5H8UCreKASkCYbmdndB5jOT7WrH2SUSpDK817RMkbQTTyXO1HzbF7AN7qRtM5SmF/vgDoY+glsAH9ZCrtX0SYj/pCx6gMu2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReQanTgEXuRxzelIJk0KTx50AVXqAMRyWugjXCwn+uk=;
 b=ZfwarfcIGSC+K9hWG0EO7O863/XxWv7DUhvZkZgrzcS2JZyWJXEGkODPOECYTj2iFCk3y1RTRhJLXsUm0PhlDrgiVTQIhyJIDd871OOc7EwoS1FdIdcmj0Mse6M0HS2flvywuqqUcMMDv+k7b+Lyk6oAmd1PfwsPZisZlJmCyV6IKNUmhC0iykHCImsvl7FDaLEcSaNcisuC28oJGhU2oFPWxP6BgNSkRUFW4fDgRnXJa1W+jS+1EOs34JBYETg+h1Y07rwtD3+2je6/sNqoOUURUXS1FUdDOxtkbn6nYi8uJ9pjCegdTBQAqeC9dgHOLiVongZLoLn8odf/lo7IxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReQanTgEXuRxzelIJk0KTx50AVXqAMRyWugjXCwn+uk=;
 b=kIASny7ohn8dSyFuohvBy5MrYjjo4RvEVZhnN88ixbecipxjeSRJFka0jlPd0nrolEnK1oBdAHnZY3Q0Z8ThFZH59Ptopz8PE2eFOUPjayg+uqC/XR6qd23Jx73i8W+4h1K9v0ud7cu4hhd/WnBWwHZmlT4CRGSKADSxRHY/aJ8=
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
Subject: [RFC v1 038/256] cl8k: add channel.c
Date:   Thu, 17 Jun 2021 15:58:45 +0000
Message-Id: <20210617160223.160998-39-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2eebb8a3-c120-4005-f0bc-08d931a96abf
X-MS-TrafficTypeDiagnostic: AM9P192MB0966:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0966F15EC1CA1D3985ECA2A1F60E9@AM9P192MB0966.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j+XbNkP4ObsE9USE9bf+wvIg2Zr8h1wnBl7NJ9bDW5QTCo32GJ11tux+rQhf9flrW+HoqsCMhzOjMuXKjL2F055NZa06KBKfLgioN9rzFHCHD3HDYj7XOE+hDuOssxknsmLK9Y1u9cUVhp7EEzvgAbSYFtBQ+fSaJmv66Fh4ffiVXlRJ7RVKsNityEt2SrehZFmdonqKrYHHf1pvL4GPJoWP0Yiok6UzKcB4Yxrn9ARLMCzCmmW5NKVYWPnbBGwrsgMKhO2c468FeaUEfi/5hl/7NqgsUjS5IcN0xsinHBL9v5ejiA+VGTuOdS9zK/kgQBBehqV3RQ7/9UZQwvLQmfcYhCbsq1uvhdUNobcoIUIIMOwl6NmXPYLd3q7QIIf5WJDQNIZozcqzzwU1forqRyoKdq8mkeezP5rmS84ob3rHLifSMOPYn9+Mv8PXbeYcL2YDInqEL5/DeDD9TKMqB3tWS6PmtHTy9QlSMCDlmRwsXBA3eYLe+HxSwbgyfC2iRe2LZ3AaIJYZV4tgQ4p4DhIvcuXraXJXA1g7npgDDKTzOb8O1hDrYEn8ecn/CPQ28KI8kLKG1ZldLTF6OxmcWiQr/f5VK/QFyLa57Fb9G8MkHbPcH1k+Ls2K+dRSo1V6mxWgPxTQsxe8XCcq6QfxjmkfzBl43Vcar5QaMlBpxFzEkqjM3sqXz9akJA47X9fIzB0d/yg/spCLSgAjENJeaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39850400004)(376002)(396003)(30864003)(4326008)(1076003)(2616005)(8676002)(186003)(6512007)(6486002)(107886003)(83380400001)(6916009)(38100700002)(55236004)(316002)(16526019)(6506007)(38350700002)(6666004)(54906003)(8936002)(26005)(508600001)(36756003)(2906002)(9686003)(52116002)(956004)(5660300002)(66946007)(66556008)(66476007)(86362001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vWIU4rNfoP31y+Af2VVv4ss+rKKOOFtxpiJw/P5o/givQawBk9r3UkPV0poo?=
 =?us-ascii?Q?2rPkacEC+r0/6fu+uggwMohWYRHlPgppShh22sH9tIaF/+pEQItvfgqB/zxK?=
 =?us-ascii?Q?Pmdw2eT5/SWn6EArIxqLjOfLzRfK9yGtGBvp124jA2tJi+8j3uGpLTmpSSuK?=
 =?us-ascii?Q?gu7X6sbMfE+JISUJB7V77qDO8Xr9hheKRwNXv1y7ZFL3DvL5QT/XQ+8dPUhr?=
 =?us-ascii?Q?Jhms84XvXb20c3tTNmbpfwxAjcwdk0Z2xQVFbJpUHeOR9XFXuOCCnZK4K4Fn?=
 =?us-ascii?Q?v/7RhKqnKO5zs43SbmMxSI8iBHn+fJ2Rt3TsbM5BF/rnDpg0UiZq1PTPcml+?=
 =?us-ascii?Q?I6quHUDqlRQxE/2FBKXUt6Jg9pXwd/5D5c+ja5hH3VQL8dx60DHVp1OHAyiy?=
 =?us-ascii?Q?9/j6UkWiMEGj2aEPcKJYhv8I+NY/79nhJND/T7AnXz5D+PDWszZaAACI9Kng?=
 =?us-ascii?Q?MLlspozWyeLHHqMR1mQqhFz7PVB6w0cf8Qgs+Ytc9dP9R3vVCzLIeXraDDYF?=
 =?us-ascii?Q?RM87d+VPgyJXFxaOSjvHzCu/zbAh7vz7OUC4zoKUirOcpxG5aoR3xtk6nnnG?=
 =?us-ascii?Q?oZSh0sV7n3upFZy2l8758qmGOMc44OKM343fQRIGgVS3vm6m2wSSeA5WKBny?=
 =?us-ascii?Q?zabzTPXe7YwZgL+TPrsa3Vl8aFb5H/geOHGPxQI3WI/WpdOGz6wBbiaknURC?=
 =?us-ascii?Q?rOzaVdzC3rXyvacAdGf/WDbzjl+eFHuCQ/iMom2MwvaNdQwPNKX5zwBcswsP?=
 =?us-ascii?Q?HMaJL5RQw1OwErleFe041b47Bk6Q9icA8cFzcXQdW7vD8f9Ru7wuDYXvECkh?=
 =?us-ascii?Q?q1Y/AqW5c168Cch1toBhNKjNex0vDDMCJNw6/eLNqYEal4AIsLSM0/lG/KOK?=
 =?us-ascii?Q?WTmHeD8R7D1nTYQSMVsXyqQfXuR/hvtlVqpdgLSwumA1lPEypH4zXKR1UAx3?=
 =?us-ascii?Q?y6al6tYUBDzxtAGxTRk4JhBWDqeL3Po980q/Elt1S0SoQzrcayOXu/jLLVca?=
 =?us-ascii?Q?t/jZfu+KUtrLdL3/ujocfnbDvWaQbAJgJO/63f5739ion6cp9Twca6dEX7Pt?=
 =?us-ascii?Q?OTVTg2D170OWXRUJ3TqurO4bv+U7RiXLIHeXqAk0LLpD5excwu/f8mZDcp8A?=
 =?us-ascii?Q?wZAeNffsJsDyaONFyXYHr7y753Ef8diTLJHwxxWjKFcf59RQ5lxrM4i4BT3q?=
 =?us-ascii?Q?do/R9yP/ygLvWZ0dng7wdU6j3ZbVNw8kr4RhnyZIVfVimshqEo9NZZCvuWVV?=
 =?us-ascii?Q?pELwT6GG7RH3SF1XN7TagAS8qLEvySgPLDyuE9+BTVKQLIda7QLK0Uq51pWV?=
 =?us-ascii?Q?SCH9Ip4itO6jtdvTRLl0k/Va?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eebb8a3-c120-4005-f0bc-08d931a96abf
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:16.1725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRWGV8PNe1IQc8NYj7ZxvgCRuA7SmW6qHSP827UcWQAx0+4+2xpIzX5dgTC9wwcaH4ChoJQrZhShKlM3MwmtZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0966
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/channel.c | 373 +++++++++++++++++++++
 1 file changed, 373 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/channel.c

diff --git a/drivers/net/wireless/celeno/cl8k/channel.c b/drivers/net/wirel=
ess/celeno/cl8k/channel.c
new file mode 100644
index 000000000000..78346f04e332
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/channel.c
@@ -0,0 +1,373 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "channel.h"
+#include "band.h"
+#include "vif.h"
+#include "dfs/dfs.h"
+#include "chandef.h"
+#include "netlink.h"
+
+#define CASE_CHAN2IDX_6G(_chan) { case _chan: return (b6g_ch ## _chan); }
+#define CASE_CHAN2IDX_5G(_chan) { case _chan: return (b5g_ch ## _chan); }
+#define CASE_CHAN2IDX_2G(_chan) { case _chan: return (b24g_ch ## _chan); }
+
+#define CASE_IDX2FREQ_6G(_chan) { case (b6g_ch ## _chan): return FREQ6G(_c=
han); }
+#define CASE_IDX2FREQ_5G(_chan) { case (b5g_ch ## _chan): return FREQ5G(_c=
han); }
+#define CASE_IDX2FREQ_2G(_chan) { case (b24g_ch ## _chan): return FREQ2G(_=
chan); }
+
+#define INVALID_FREQ 0xffff
+
+static u8 cl_channel_to_index_6g(struct cl_hw *cl_hw, u32 channel)
+{
+       switch (channel) {
+       CASE_CHAN2IDX_6G(1);
+       CASE_CHAN2IDX_6G(2);
+       CASE_CHAN2IDX_6G(5);
+       CASE_CHAN2IDX_6G(9);
+       CASE_CHAN2IDX_6G(13);
+       CASE_CHAN2IDX_6G(17);
+       CASE_CHAN2IDX_6G(21);
+       CASE_CHAN2IDX_6G(25);
+       CASE_CHAN2IDX_6G(29);
+       CASE_CHAN2IDX_6G(33);
+       CASE_CHAN2IDX_6G(37);
+       CASE_CHAN2IDX_6G(41);
+       CASE_CHAN2IDX_6G(45);
+       CASE_CHAN2IDX_6G(49);
+       CASE_CHAN2IDX_6G(53);
+       CASE_CHAN2IDX_6G(57);
+       CASE_CHAN2IDX_6G(61);
+       CASE_CHAN2IDX_6G(65);
+       CASE_CHAN2IDX_6G(69);
+       CASE_CHAN2IDX_6G(73);
+       CASE_CHAN2IDX_6G(77);
+       CASE_CHAN2IDX_6G(81);
+       CASE_CHAN2IDX_6G(85);
+       CASE_CHAN2IDX_6G(89);
+       CASE_CHAN2IDX_6G(93);
+       CASE_CHAN2IDX_6G(97);
+       CASE_CHAN2IDX_6G(101);
+       CASE_CHAN2IDX_6G(105);
+       CASE_CHAN2IDX_6G(109);
+       CASE_CHAN2IDX_6G(113);
+       CASE_CHAN2IDX_6G(117);
+       CASE_CHAN2IDX_6G(121);
+       CASE_CHAN2IDX_6G(125);
+       CASE_CHAN2IDX_6G(129);
+       CASE_CHAN2IDX_6G(133);
+       CASE_CHAN2IDX_6G(137);
+       CASE_CHAN2IDX_6G(141);
+       CASE_CHAN2IDX_6G(145);
+       CASE_CHAN2IDX_6G(149);
+       CASE_CHAN2IDX_6G(153);
+       CASE_CHAN2IDX_6G(157);
+       CASE_CHAN2IDX_6G(161);
+       CASE_CHAN2IDX_6G(165);
+       CASE_CHAN2IDX_6G(169);
+       CASE_CHAN2IDX_6G(173);
+       CASE_CHAN2IDX_6G(177);
+       CASE_CHAN2IDX_6G(181);
+       CASE_CHAN2IDX_6G(185);
+       CASE_CHAN2IDX_6G(189);
+       CASE_CHAN2IDX_6G(193);
+       CASE_CHAN2IDX_6G(197);
+       CASE_CHAN2IDX_6G(201);
+       CASE_CHAN2IDX_6G(205);
+       CASE_CHAN2IDX_6G(209);
+       CASE_CHAN2IDX_6G(213);
+       CASE_CHAN2IDX_6G(217);
+       CASE_CHAN2IDX_6G(221);
+       CASE_CHAN2IDX_6G(225);
+       CASE_CHAN2IDX_6G(229);
+       CASE_CHAN2IDX_6G(233);
+       };
+
+       return INVALID_CHAN_IDX;
+}
+
+static u8 cl_channel_to_index_5g(struct cl_hw *cl_hw, u32 channel)
+{
+       switch (channel) {
+       CASE_CHAN2IDX_5G(36);
+       CASE_CHAN2IDX_5G(38);
+       CASE_CHAN2IDX_5G(40);
+       CASE_CHAN2IDX_5G(42);
+       CASE_CHAN2IDX_5G(44);
+       CASE_CHAN2IDX_5G(46);
+       CASE_CHAN2IDX_5G(48);
+       CASE_CHAN2IDX_5G(50);
+       CASE_CHAN2IDX_5G(52);
+       CASE_CHAN2IDX_5G(54);
+       CASE_CHAN2IDX_5G(56);
+       CASE_CHAN2IDX_5G(58);
+       CASE_CHAN2IDX_5G(60);
+       CASE_CHAN2IDX_5G(62);
+       CASE_CHAN2IDX_5G(64);
+       CASE_CHAN2IDX_5G(100);
+       CASE_CHAN2IDX_5G(102);
+       CASE_CHAN2IDX_5G(104);
+       CASE_CHAN2IDX_5G(106);
+       CASE_CHAN2IDX_5G(108);
+       CASE_CHAN2IDX_5G(110);
+       CASE_CHAN2IDX_5G(112);
+       CASE_CHAN2IDX_5G(114);
+       CASE_CHAN2IDX_5G(116);
+       CASE_CHAN2IDX_5G(118);
+       CASE_CHAN2IDX_5G(120);
+       CASE_CHAN2IDX_5G(122);
+       CASE_CHAN2IDX_5G(124);
+       CASE_CHAN2IDX_5G(126);
+       CASE_CHAN2IDX_5G(128);
+       /* 130 - invalid */
+       CASE_CHAN2IDX_5G(132);
+       CASE_CHAN2IDX_5G(134);
+       CASE_CHAN2IDX_5G(136);
+       CASE_CHAN2IDX_5G(138);
+       CASE_CHAN2IDX_5G(140);
+       CASE_CHAN2IDX_5G(142);
+       CASE_CHAN2IDX_5G(144);
+       CASE_CHAN2IDX_5G(149);
+       CASE_CHAN2IDX_5G(151);
+       CASE_CHAN2IDX_5G(153);
+       CASE_CHAN2IDX_5G(155);
+       CASE_CHAN2IDX_5G(157);
+       CASE_CHAN2IDX_5G(159);
+       CASE_CHAN2IDX_5G(161);
+       /* 163 - invalid */
+       CASE_CHAN2IDX_5G(165);
+       };
+
+       return INVALID_CHAN_IDX;
+}
+
+static u8 cl_channel_to_index_24g(struct cl_hw *cl_hw, u32 channel)
+{
+       switch (channel) {
+       CASE_CHAN2IDX_2G(1);
+       CASE_CHAN2IDX_2G(2);
+       CASE_CHAN2IDX_2G(3);
+       CASE_CHAN2IDX_2G(4);
+       CASE_CHAN2IDX_2G(5);
+       CASE_CHAN2IDX_2G(6);
+       CASE_CHAN2IDX_2G(7);
+       CASE_CHAN2IDX_2G(8);
+       CASE_CHAN2IDX_2G(9);
+       CASE_CHAN2IDX_2G(10);
+       CASE_CHAN2IDX_2G(11);
+       CASE_CHAN2IDX_2G(12);
+       CASE_CHAN2IDX_2G(13);
+       CASE_CHAN2IDX_2G(14);
+       };
+
+       return INVALID_CHAN_IDX;
+}
+
+u8 cl_channel_to_index(struct cl_hw *cl_hw, u32 channel)
+{
+       /* Calculate index for a given channel */
+       if (cl_band_is_6g(cl_hw))
+               return cl_channel_to_index_6g(cl_hw, channel);
+       else if (cl_band_is_5g(cl_hw))
+               return cl_channel_to_index_5g(cl_hw, channel);
+       else
+               return cl_channel_to_index_24g(cl_hw, channel);
+}
+
+static u16 cl_channel_idx_to_freq_6g(struct cl_hw *cl_hw, u8 index)
+{
+       switch (index) {
+       CASE_IDX2FREQ_6G(1);
+       CASE_IDX2FREQ_6G(2);
+       CASE_IDX2FREQ_6G(5);
+       CASE_IDX2FREQ_6G(9);
+       CASE_IDX2FREQ_6G(13);
+       CASE_IDX2FREQ_6G(17);
+       CASE_IDX2FREQ_6G(21);
+       CASE_IDX2FREQ_6G(25);
+       CASE_IDX2FREQ_6G(29);
+       CASE_IDX2FREQ_6G(33);
+       CASE_IDX2FREQ_6G(37);
+       CASE_IDX2FREQ_6G(41);
+       CASE_IDX2FREQ_6G(45);
+       CASE_IDX2FREQ_6G(49);
+       CASE_IDX2FREQ_6G(53);
+       CASE_IDX2FREQ_6G(57);
+       CASE_IDX2FREQ_6G(61);
+       CASE_IDX2FREQ_6G(65);
+       CASE_IDX2FREQ_6G(69);
+       CASE_IDX2FREQ_6G(73);
+       CASE_IDX2FREQ_6G(77);
+       CASE_IDX2FREQ_6G(81);
+       CASE_IDX2FREQ_6G(85);
+       CASE_IDX2FREQ_6G(89);
+       CASE_IDX2FREQ_6G(93);
+       CASE_IDX2FREQ_6G(97);
+       CASE_IDX2FREQ_6G(101);
+       CASE_IDX2FREQ_6G(105);
+       CASE_IDX2FREQ_6G(109);
+       CASE_IDX2FREQ_6G(113);
+       CASE_IDX2FREQ_6G(117);
+       CASE_IDX2FREQ_6G(121);
+       CASE_IDX2FREQ_6G(125);
+       CASE_IDX2FREQ_6G(129);
+       CASE_IDX2FREQ_6G(133);
+       CASE_IDX2FREQ_6G(137);
+       CASE_IDX2FREQ_6G(141);
+       CASE_IDX2FREQ_6G(145);
+       CASE_IDX2FREQ_6G(149);
+       CASE_IDX2FREQ_6G(153);
+       CASE_IDX2FREQ_6G(157);
+       CASE_IDX2FREQ_6G(161);
+       CASE_IDX2FREQ_6G(165);
+       CASE_IDX2FREQ_6G(169);
+       CASE_IDX2FREQ_6G(173);
+       CASE_IDX2FREQ_6G(177);
+       CASE_IDX2FREQ_6G(181);
+       CASE_IDX2FREQ_6G(185);
+       CASE_IDX2FREQ_6G(189);
+       CASE_IDX2FREQ_6G(193);
+       CASE_IDX2FREQ_6G(197);
+       CASE_IDX2FREQ_6G(201);
+       CASE_IDX2FREQ_6G(205);
+       CASE_IDX2FREQ_6G(209);
+       CASE_IDX2FREQ_6G(213);
+       CASE_IDX2FREQ_6G(217);
+       CASE_IDX2FREQ_6G(221);
+       CASE_IDX2FREQ_6G(225);
+       CASE_IDX2FREQ_6G(229);
+       CASE_IDX2FREQ_6G(233);
+       };
+
+       return INVALID_FREQ;
+}
+
+static u16 cl_channel_idx_to_freq_5g(struct cl_hw *cl_hw, u8 index)
+{
+       switch (index) {
+       CASE_IDX2FREQ_5G(36);
+       CASE_IDX2FREQ_5G(38);
+       CASE_IDX2FREQ_5G(40);
+       CASE_IDX2FREQ_5G(42);
+       CASE_IDX2FREQ_5G(44);
+       CASE_IDX2FREQ_5G(46);
+       CASE_IDX2FREQ_5G(48);
+       CASE_IDX2FREQ_5G(50);
+       CASE_IDX2FREQ_5G(52);
+       CASE_IDX2FREQ_5G(54);
+       CASE_IDX2FREQ_5G(56);
+       CASE_IDX2FREQ_5G(58);
+       CASE_IDX2FREQ_5G(60);
+       CASE_IDX2FREQ_5G(62);
+       CASE_IDX2FREQ_5G(64);
+       CASE_IDX2FREQ_5G(100);
+       CASE_IDX2FREQ_5G(102);
+       CASE_IDX2FREQ_5G(104);
+       CASE_IDX2FREQ_5G(106);
+       CASE_IDX2FREQ_5G(108);
+       CASE_IDX2FREQ_5G(110);
+       CASE_IDX2FREQ_5G(112);
+       CASE_IDX2FREQ_5G(114);
+       CASE_IDX2FREQ_5G(116);
+       CASE_IDX2FREQ_5G(118);
+       CASE_IDX2FREQ_5G(120);
+       CASE_IDX2FREQ_5G(122);
+       CASE_IDX2FREQ_5G(124);
+       CASE_IDX2FREQ_5G(126);
+       CASE_IDX2FREQ_5G(128);
+       CASE_IDX2FREQ_5G(132);
+       CASE_IDX2FREQ_5G(134);
+       CASE_IDX2FREQ_5G(136);
+       CASE_IDX2FREQ_5G(138);
+       CASE_IDX2FREQ_5G(140);
+       CASE_IDX2FREQ_5G(142);
+       CASE_IDX2FREQ_5G(144);
+       CASE_IDX2FREQ_5G(149);
+       CASE_IDX2FREQ_5G(151);
+       CASE_IDX2FREQ_5G(153);
+       CASE_IDX2FREQ_5G(155);
+       CASE_IDX2FREQ_5G(157);
+       CASE_IDX2FREQ_5G(159);
+       CASE_IDX2FREQ_5G(161);
+       CASE_IDX2FREQ_5G(165);
+       };
+
+       return INVALID_FREQ;
+}
+
+static u16 cl_channel_idx_to_freq_24g(struct cl_hw *cl_hw, u8 index)
+{
+       switch (index) {
+       CASE_IDX2FREQ_2G(1);
+       CASE_IDX2FREQ_2G(2);
+       CASE_IDX2FREQ_2G(3);
+       CASE_IDX2FREQ_2G(4);
+       CASE_IDX2FREQ_2G(5);
+       CASE_IDX2FREQ_2G(6);
+       CASE_IDX2FREQ_2G(7);
+       CASE_IDX2FREQ_2G(8);
+       CASE_IDX2FREQ_2G(9);
+       CASE_IDX2FREQ_2G(10);
+       CASE_IDX2FREQ_2G(11);
+       CASE_IDX2FREQ_2G(12);
+       CASE_IDX2FREQ_2G(13);
+       CASE_IDX2FREQ_2G(14);
+       };
+
+       return INVALID_FREQ;
+}
+
+u16 cl_channel_idx_to_freq(struct cl_hw *cl_hw, u8 index)
+{
+       /* Calculate frequency of a given idnex */
+       if (cl_band_is_6g(cl_hw))
+               return cl_channel_idx_to_freq_6g(cl_hw, index);
+       else if (cl_band_is_5g(cl_hw))
+               return cl_channel_idx_to_freq_5g(cl_hw, index);
+       else
+               return cl_channel_idx_to_freq_24g(cl_hw, index);
+}
+
+bool cl_channel_is_valid(struct cl_hw *cl_hw, u8 channel)
+{
+       if (cl_band_is_24g(cl_hw)) {
+               return (channel > 0 && channel <=3D 14);
+       } else if (cl_band_is_5g(cl_hw)) {
+               if (channel >=3D 36 && channel <=3D 64)
+                       return ((channel & 0x1) =3D=3D 0x0);
+
+               if (channel >=3D 100 && channel <=3D 144)
+                       return ((channel & 0x1) =3D=3D 0x0);
+
+               if (channel >=3D 149 && channel <=3D 161)
+                       return ((channel & 0x1) =3D=3D 0x1);
+
+               if (channel =3D=3D 165)
+                       return true;
+       } else {
+               if (channel =3D=3D 2)
+                       return true;
+
+               if (channel >=3D 1 && channel <=3D 233)
+                       if ((channel & 0x3) =3D=3D 0x1)
+                               return true;
+       }
+
+       return false;
+}
+
+u32 cl_channel_num(struct cl_hw *cl_hw)
+{
+       if (cl_hw->conf->ci_band_num =3D=3D 6)
+               return NUM_CHANNELS_6G;
+
+       if (cl_hw->conf->ci_band_num =3D=3D 5)
+               return NUM_CHANNELS_5G;
+
+       return NUM_CHANNELS_24G;
+}
+
+bool __must_check cl_channel_is_scan_active(struct cl_hw *cl_hw)
+{
+       return false;
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

