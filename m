Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BB63AB87E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbhFQQIW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:22 -0400
Received: from mail-db8eur05on2082.outbound.protection.outlook.com ([40.107.20.82]:7360
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232038AbhFQQHi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ji3BDTZGUXzbrCgGqm07wgbnS8SWYx9HB0nmXkbr3rXm+hP/iyzzJ8CQAQZqP/T5Dj/tbYpzC0zA0vmeaEDQt/+EHy9RWAdpyAvy65ZsTXqGwton+etbJhEFl6wKuR6ULy3h9eHUgIoBn7ylRWrj31/RXKVfxKbcKjxA5ckVCyzFR1KsVByrUIbNqExXM7AJnSLsnWkq/Pj1aw+DYhvspJuxbUOgtMW5eRYZmOa9uCoURa6po3MzCv70G30JvVwMQnyezJ7/yfYQzwTrULDTVGqGLYisutRYGSDSCZV75uNlAk3gu4UiVwcfCodp0N1Ofw0pX1vTwOM6dfEVY0Oemg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqUzwkaL7Vrjdy/lVALGfQzBSf363V+fQeGZksvrbXw=;
 b=DTowmKr9ZSu6vspr+ifmp4nghYEfa7LZ+0XvISb/52UjOBUW6hI7iHKtRdrSEIJW0h27F0XWYt8yHmikOAAHqdr5SwY3K7wPO6fjrS9ed2o6amuQpeywUMoBC6MSL0WMqZEHtO8R4yJwpsT8BIsjBNrHccTRGyK+B8+A2orgfPgAPikhJ02pBnJkk1CAk6EkuZBKbZ3rm7qoh0VEZOFEWG3Vyqk4zKafUJqS9BkDRCU9e07ywiChNO+UH53CxrhOVWhhQkydq2ijr2tUWajItWUfbt8VOiT80bzvlI+m1wMni2DVkUVsSvoa3n4obBSX8jw3h9QaoCxv6Wo+utVgxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqUzwkaL7Vrjdy/lVALGfQzBSf363V+fQeGZksvrbXw=;
 b=sm8DxcYjZWhhtlTJUQyxIBcC1ok6blkLyK3va0ADH3tBniVIAFa7Ok5qss834+kSHdG8n8Q8xPsv8uQ6sy3kISJnFo6tb2eq4YWCzoPHc9AZpcmKd5FIkW2NN++bPRLnfK/DD6RsOUKve/SIW8lm9VZCO+EtmulSpBNThV1FM7o=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0871.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 17 Jun
 2021 16:04:27 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:27 +0000
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
Subject: [RFC v1 083/256] cl8k: add fem.c
Date:   Thu, 17 Jun 2021 15:59:30 +0000
Message-Id: <20210617160223.160998-84-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3847f43-ea3c-4bc4-aa74-08d931a987e0
X-MS-TrafficTypeDiagnostic: AM9P192MB0871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0871C360185CBBD0A48CE69CF60E9@AM9P192MB0871.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HbkbXugoLz++U201unFu9LYzWGT0FJygKbX/jirzXyAvHPrLOhRyCCssUzjsG8wJL3muNVBOJag9j3aBv9SJvCXPiE2+Ut/J96qaAMjMQ1EFELXMk5jFsWFmioIxhQJk3kw2oiciwxGUdpEnR3JV5xpCZz7Ot515Cf2+XDjS3iUI3NDoD5zH9i1P0kVJcVdJnGiCqSLmfF66qBvmE9QM2qfnEYKS0EII3Gdw0NQHxNwMIdmf0VZyz8b/mSpjS39Y0gKKeY7nqsiK7toh1sD53u8DQxGdydF0J4nzBON8ol9xfzf/5AwLnGPQ08Bob8CDAuindqyJ9QkrpFwzArlj6pIYUfQ4A2xeYk9didDfNAxxv8evc7DyD48dfRXFs12dWIcY6nKXGrIlHBLi3eiDuESUxl0DQhWLsoVx8ZHPzz9WQZieASGyld0unV0e8xAqDSj0JstCrPKD2f6/Mghl1iI4qeBexB13zDPTfEeQrCbZLbTWUHdUzxumsRm8RyCk0wuhqifW691Bpet+enOP1edpil1eYNDqI9BgwRYs0mDe8JAuTfZap8/ynTtidxXX2WHn4Ws51bac9Gf4CiR2tOBFFvUojyAt/yf/uugsbgZKg+KC1HONWuZB9MmImxoxjrqa4uGiWBcbKEhkcHM4cl2ErQxbLP0h3aKoEjE1WkW3QP0Q1HXQnxnu8iPEDgdWg1aTXKcDwSwl09iQFQjOsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(396003)(39840400004)(16526019)(66946007)(478600001)(26005)(66476007)(30864003)(6486002)(186003)(66556008)(9686003)(316002)(86362001)(6506007)(6666004)(6512007)(55236004)(38350700002)(1076003)(38100700002)(4326008)(8676002)(83380400001)(5660300002)(52116002)(2616005)(2906002)(6916009)(956004)(8936002)(107886003)(54906003)(36756003)(69590400013)(32563001)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FK0o7P88EP2rF/8HZIoYiXXw8TMZJgfNJndjRs9SCB0E48ZZcR8tZv1XjESY?=
 =?us-ascii?Q?xtuftnT2+l3HWSQT2Uqba7VdvF82UFW6s26eOxWPNuE6E9NuoyCIdkv7zjxb?=
 =?us-ascii?Q?ysbfg7QS7F1amDvoL4bDF2gU2n9rP9cbQNRaidhVP5690UgKYjK/LLwq7WM8?=
 =?us-ascii?Q?Pm8pyzr1cTMWY8Vk3C3lEJRuGOg6KXIHs7SOp1DpDKQe5TFSTj1MCYSprG4q?=
 =?us-ascii?Q?9YBMIGHqkpnXtp+poto3qo/JkpuaRK+bcev3IGMpeMvlrNRLiRwt3pagZQu3?=
 =?us-ascii?Q?JeCPQ+AwwnQn18dFTMHeqhTsTRmd7dk0AwtDq3Gn2q60jNjlR3GcZvGtQGhk?=
 =?us-ascii?Q?dW+dqxoihgTWwNmIUF0BJiDwEZWli6+qhjQNnFlsOkaGdQxuY4K0HfJYTYO6?=
 =?us-ascii?Q?je80hS7ILH4QPzxgY9i2g6XKGe6FODUfa3o5hTOJVpCkHeYdDlNMTj+NfHz+?=
 =?us-ascii?Q?v+6VCOCfEMxxcumL7wsYA/6BEwjORfgOoN+PG2UZnWaB7r7MKMon44oL0gZ3?=
 =?us-ascii?Q?Fy2mMhOK9Jvc98NYQCzYh2Yohiq5D3zT/hyx/8BeyBDJLuSVQ0LmPkY2hoDh?=
 =?us-ascii?Q?t68PxbN5OhJRBFqZaxuxaGfVo8DNwwixO6YXQBukT4ex5oVawsxvXd/7KT4W?=
 =?us-ascii?Q?NLG3Z3Pm8lKC56UHwwxy7KxlS3dPSwiyvYFydmcMf0RXkOys2x6067h+yxj1?=
 =?us-ascii?Q?lHwr+q06cA0IbOs9Rdw80w7LaLVtblRqRzW4ohASXBkleb/87lCvlcIGDxUq?=
 =?us-ascii?Q?ZoZ2Jn2VoboONONF/Y6PAxArnPa3bu/yXJ3tYOxDURnWBKiX3qDmRA6xyyib?=
 =?us-ascii?Q?PGBRfa05kAx2tZw2o0M4Tbe9/5z4W9s0qyDJa8FTXc3wgQnHpV56pr7BuBF0?=
 =?us-ascii?Q?yN/UowyjR+JNbVk5yVS6LOaqnl8okRWT3ZMOOn7KJmgv9c1E2CTlvjUp4zur?=
 =?us-ascii?Q?TIbNWPw5mTVHwcwtsvViNOsN8ls09H1uiI0Ec0uRhjDzHs6Iq8CrIWhg7kPH?=
 =?us-ascii?Q?KhE3chsBtkVivD3I/LTblLTSxs3HvCTJHghzALmS8nYckO5757af81Sxjo50?=
 =?us-ascii?Q?NIx1JKbXoLXkcBr9nYTky2tGlKWd46x7mC7BvsSm9BR9TqBNB5TZKTbMfKNV?=
 =?us-ascii?Q?r/76buS1SiSYRFnNBAmL+uaqKHZWRXHhlgGDUA+x5DUyHmJ3nAAcJoqJT9Zw?=
 =?us-ascii?Q?hgjetufJ68x0ugssY/bvw5XMUlVsK20odGCjOeZuHmVHiwl/U+LoP9UuUFRU?=
 =?us-ascii?Q?gU+3Fu+/un3l/EnF2xMV7eZUl8M81AsDTF+vomUigoUqIiQ2DMJ6sjygWHjB?=
 =?us-ascii?Q?UbnxzEx9ooNvJpn/BuJvACxb?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3847f43-ea3c-4bc4-aa74-08d931a987e0
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:05.4421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LdBvpgEkui9690aXoP+w9mg6FGrY+PvAEiP5ymlVnDuUOr0Elotl812XbiZVge61tt1yBgNTnnpyBFhy96DZrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0871
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/fem.c | 1271 ++++++++++++++++++++++++
 1 file changed, 1271 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/fem.c

diff --git a/drivers/net/wireless/celeno/cl8k/fem.c b/drivers/net/wireless/=
celeno/cl8k/fem.c
new file mode 100644
index 000000000000..4786106b63aa
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/fem.c
@@ -0,0 +1,1271 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "chip.h"
+#include "fem.h"
+#include "reg/reg_fem.h"
+#include "fem_common.h"
+#include "e2p.h"
+#include "reg/reg_ricu.h"
+#include "reg/reg_riu_rc.h"
+#include "agc_params.h"
+
+static const struct cl_fem_lna_enable_gpio lna_enable_gpio[FEM_WIRING_MAX]=
 =3D {
+       [FEM_WIRING_0_TCV0_6_TCV1_6]           =3D { .val =3D 0b00000000000=
0 },
+       [FEM_WIRING_1_TCV0_6_TCV1_6]           =3D { .val =3D 0b00000000000=
0 },
+       [FEM_WIRING_2_TCV0_6_TCV1_6]           =3D { .val =3D 0b00000000000=
0 },
+       [FEM_WIRING_3_TCV0_2_ELASTIC_4_TCV1_2] =3D { .val =3D 0b00110011000=
0 },
+       [FEM_WIRING_4_TCV0_2_ELASTIC_4_TCV1_2] =3D { .val =3D 0b00110011000=
0 },
+       [FEM_WIRING_5_TCV0_2_ELASTIC_4_TCV1_2] =3D { .val =3D 0b00110011000=
0 },
+       [FEM_WIRING_6_TCV0_2_ELASTIC_4_TCV1_2] =3D { .val =3D 0b00110011000=
0 },
+       [FEM_WIRING_7_TCV0_4_TCV1_4]           =3D { .val =3D 0b00000011101=
0 },
+       [FEM_WIRING_8_TCV0_4_TCV1_4]           =3D { .val =3D 0b00000011101=
0 },
+       [FEM_WIRING_9_TCV0_4_TCV1_4]           =3D { .val =3D 0b11110000000=
0 },
+       [FEM_WIRING_10_TCV0_4_TCV1_4]          =3D { .val =3D 0b11110000000=
0 },
+       [FEM_WIRING_11_TCV0_4_TCV1_4_RX_ONLY]  =3D { .val =3D 0b11110000000=
0 },
+       [FEM_WIRING_12_TCV0_4_TCV1_4_RX_ONLY]  =3D { .val =3D 0b11110000000=
0 },
+       [FEM_WIRING_13_SENSING_4RX_2TX]        =3D { .val =3D 0b00111111000=
0 },
+       [FEM_WIRING_14_SENSING_4TX_2RX]        =3D { .val =3D 0b11110011000=
0 },
+       [FEM_WIRING_15_CHAMELEON_4TX_4RX]      =3D { .val =3D 0b00110000101=
0 },
+       [FEM_WIRING_16_TCV0_2_TCV1_2]          =3D { .val =3D 0b10011011111=
0 },
+       [FEM_WIRING_17_TCV0_4_TCV1_0]          =3D { .val =3D 0b11111111000=
0 },
+       [FEM_WIRING_18_TCV0_4_TCV1_4]          =3D { .val =3D 0b00000011101=
0 },
+       [FEM_WIRING_19_TCV0_2_TCV1_2_SWAPPED]  =3D { .val =3D 0b00001111111=
1 },
+       [FEM_WIRING_20_TCV0_4_TCV1_2]          =3D { .val =3D 0b00001111101=
0 },
+       [FEM_WIRING_21_TCV0_4_TCV1_2]          =3D { .val =3D 0b11111100000=
0 },
+};
+
+static const struct cl_fem_pa_enable_gpio pa_enable_gpio[FEM_WIRING_MAX] =
=3D {
+       [FEM_WIRING_0_TCV0_6_TCV1_6]           =3D { .val =3D 0b00000000000=
0 },
+       [FEM_WIRING_1_TCV0_6_TCV1_6]           =3D { .val =3D 0b00000000000=
0 },
+       [FEM_WIRING_2_TCV0_6_TCV1_6]           =3D { .val =3D 0b00000000000=
0 },
+       [FEM_WIRING_3_TCV0_2_ELASTIC_4_TCV1_2] =3D { .val =3D 0b00000000000=
0 },
+       [FEM_WIRING_4_TCV0_2_ELASTIC_4_TCV1_2] =3D { .val =3D 0b00000000000=
0 },
+       [FEM_WIRING_5_TCV0_2_ELASTIC_4_TCV1_2] =3D { .val =3D 0b00000000000=
0 },
+       [FEM_WIRING_6_TCV0_2_ELASTIC_4_TCV1_2] =3D { .val =3D 0b00000000000=
0 },
+       [FEM_WIRING_7_TCV0_4_TCV1_4]           =3D { .val =3D 0b00000011101=
0 },
+       [FEM_WIRING_8_TCV0_4_TCV1_4]           =3D { .val =3D 0b00000011101=
0 },
+       [FEM_WIRING_9_TCV0_4_TCV1_4]           =3D { .val =3D 0b11110000000=
0 },
+       [FEM_WIRING_10_TCV0_4_TCV1_4]          =3D { .val =3D 0b11110000000=
0 },
+       [FEM_WIRING_11_TCV0_4_TCV1_4_RX_ONLY]  =3D { .val =3D 0b11111111000=
0 },
+       [FEM_WIRING_12_TCV0_4_TCV1_4_RX_ONLY]  =3D { .val =3D 0b11111111000=
0 },
+       [FEM_WIRING_13_SENSING_4RX_2TX]        =3D { .val =3D 0b00111111000=
0 },
+       [FEM_WIRING_14_SENSING_4TX_2RX]        =3D { .val =3D 0b00111111101=
0 },
+       [FEM_WIRING_15_CHAMELEON_4TX_4RX]      =3D { .val =3D 0b00111111101=
0 },
+       [FEM_WIRING_16_TCV0_2_TCV1_2]          =3D { .val =3D 0b10011011111=
0 },
+       [FEM_WIRING_17_TCV0_4_TCV1_0]          =3D { .val =3D 0b11111111000=
0 },
+       [FEM_WIRING_18_TCV0_4_TCV1_4]          =3D { .val =3D 0b00000011101=
0 },
+       [FEM_WIRING_19_TCV0_2_TCV1_2_SWAPPED]  =3D { .val =3D 0b00001111111=
1 },
+       [FEM_WIRING_20_TCV0_4_TCV1_2]          =3D { .val =3D 0b00001111101=
0 },
+       [FEM_WIRING_21_TCV0_4_TCV1_2]          =3D { .val =3D 0b11111111000=
0 },
+};
+
+static const struct cl_fem_rx_active_gpio rx_active_gpio[FEM_WIRING_MAX] =
=3D {
+       [FEM_WIRING_0_TCV0_6_TCV1_6]           =3D { .val =3D 0b11000000 },
+       [FEM_WIRING_1_TCV0_6_TCV1_6]           =3D { .val =3D 0b11111111 },
+       [FEM_WIRING_2_TCV0_6_TCV1_6]           =3D { .val =3D 0b00000000 },=
 /* N/A */
+       [FEM_WIRING_3_TCV0_2_ELASTIC_4_TCV1_2] =3D { .val =3D 0b11111100 },
+       [FEM_WIRING_4_TCV0_2_ELASTIC_4_TCV1_2] =3D { .val =3D 0b11111111 },
+       [FEM_WIRING_5_TCV0_2_ELASTIC_4_TCV1_2] =3D { .val =3D 0b00000000 },=
 /* N/A */
+       [FEM_WIRING_6_TCV0_2_ELASTIC_4_TCV1_2] =3D { .val =3D 0b00000000 },=
 /* N/A */
+       [FEM_WIRING_7_TCV0_4_TCV1_4]           =3D { .val =3D 0b11110000 },
+       [FEM_WIRING_8_TCV0_4_TCV1_4]           =3D { .val =3D 0b00000000 },=
 /* N/A */
+       [FEM_WIRING_9_TCV0_4_TCV1_4]           =3D { .val =3D 0b11111111 },
+       [FEM_WIRING_10_TCV0_4_TCV1_4]          =3D { .val =3D 0b00000000 },
+       [FEM_WIRING_11_TCV0_4_TCV1_4_RX_ONLY]  =3D { .val =3D 0b11110000 },
+       [FEM_WIRING_12_TCV0_4_TCV1_4_RX_ONLY]  =3D { .val =3D 0b11111111 },
+       [FEM_WIRING_13_SENSING_4RX_2TX]        =3D { .val =3D 0b11000000 },
+       [FEM_WIRING_14_SENSING_4TX_2RX]        =3D { .val =3D 0b11110000 },
+       [FEM_WIRING_15_CHAMELEON_4TX_4RX]      =3D { .val =3D 0b11110000 },
+       [FEM_WIRING_16_TCV0_2_TCV1_2]          =3D { .val =3D 0b11111001 },
+       [FEM_WIRING_17_TCV0_4_TCV1_0]          =3D { .val =3D 0b11111111 },
+       [FEM_WIRING_18_TCV0_4_TCV1_4]          =3D { .val =3D 0b00000000 },
+       [FEM_WIRING_19_TCV0_2_TCV1_2_SWAPPED]  =3D { .val =3D 0b11001111 },
+       [FEM_WIRING_20_TCV0_4_TCV1_2]          =3D { .val =3D 0b11110000 },
+       [FEM_WIRING_21_TCV0_4_TCV1_2]          =3D { .val =3D 0b11111111 },
+};
+
+static const u32 ricu_fem_conf[FEM_WIRING_MAX][TCV_MAX] =3D {
+       [FEM_WIRING_0_TCV0_6_TCV1_6]           =3D { 0x00AB3021, 0x0054CD89=
},
+       [FEM_WIRING_1_TCV0_6_TCV1_6]           =3D { 0x00AB3021, 0x0054CD89=
},
+       [FEM_WIRING_2_TCV0_6_TCV1_6]           =3D { 0x00AB3021, 0x0054CD89=
},
+       [FEM_WIRING_3_TCV0_2_ELASTIC_4_TCV1_2] =3D { 0x00003021, 0x00AB0089=
},
+       [FEM_WIRING_4_TCV0_2_ELASTIC_4_TCV1_2] =3D { 0x00003021, 0x00AB0089=
},
+       [FEM_WIRING_5_TCV0_2_ELASTIC_4_TCV1_2] =3D { 0x00003021, 0x00AB0089=
},
+       [FEM_WIRING_6_TCV0_2_ELASTIC_4_TCV1_2] =3D { 0x00003021, 0x00AB0089=
},
+       [FEM_WIRING_7_TCV0_4_TCV1_4]           =3D { 0x00000001, 0x0032AB89=
},
+       [FEM_WIRING_8_TCV0_4_TCV1_4]           =3D { 0x00000001, 0x0032AB89=
},
+       [FEM_WIRING_9_TCV0_4_TCV1_4]           =3D { 0x00AB3210, 0x00000089=
},
+       [FEM_WIRING_10_TCV0_4_TCV1_4]          =3D { 0x00AB3210, 0x00000089=
},
+       [FEM_WIRING_11_TCV0_4_TCV1_4_RX_ONLY]  =3D { 0x00AB3210, 0x00000089=
},
+       [FEM_WIRING_12_TCV0_4_TCV1_4_RX_ONLY]  =3D { 0x00AB3210, 0x00000089=
},
+       [FEM_WIRING_13_SENSING_4RX_2TX]        =3D { 0x00003021, 0x00890000=
},
+       [FEM_WIRING_14_SENSING_4TX_2RX]        =3D { 0x00003021, 0x00000089=
},
+       [FEM_WIRING_15_CHAMELEON_4TX_4RX]      =3D { 0x00AB0001, 0x00320089=
},
+       [FEM_WIRING_16_TCV0_2_TCV1_2]          =3D { 0x00000001, 0x0000B00A=
},
+       [FEM_WIRING_17_TCV0_4_TCV1_0]          =3D { 0x00AB3210, 0x00000089=
},
+       [FEM_WIRING_18_TCV0_4_TCV1_4]          =3D { 0x00000001, 0x0032AB89=
},
+       [FEM_WIRING_19_TCV0_2_TCV1_2_SWAPPED]  =3D { 0x00000000, 0x00AB3289=
},
+       [FEM_WIRING_20_TCV0_4_TCV1_2]          =3D { 0x00000001, 0x0032AB00=
},
+       [FEM_WIRING_21_TCV0_4_TCV1_2]          =3D { 0x00AB3210, 0x00000089=
},
+};
+
+static const u8 fem_full_list[FEM_WIRING_MAX][TCV_MAX][FEM_LUT_AMOUNT_PER_=
MAC] =3D {
+       [FEM_WIRING_0_TCV0_6_TCV1_6] =3D {
+               {FEM_TYPE_TCV0, FEM_TYPE_TCV0, FEM_TYPE_TCV0,
+                       FEM_TYPE_TCV0, FEM_TYPE_TCV0, FEM_TYPE_TCV0},
+               {FEM_TYPE_TCV1, FEM_TYPE_TCV1, FEM_TYPE_TCV1,
+                       FEM_TYPE_TCV1, FEM_TYPE_TCV1, FEM_TYPE_TCV1},
+       },
+       [FEM_WIRING_1_TCV0_6_TCV1_6] =3D {
+               {FEM_TYPE_TCV0, FEM_TYPE_TCV0, FEM_TYPE_TCV0,
+                       FEM_TYPE_TCV0, FEM_TYPE_TCV0, FEM_TYPE_TCV0},
+               {FEM_TYPE_TCV1, FEM_TYPE_TCV1, FEM_TYPE_TCV1,
+                       FEM_TYPE_TCV1, FEM_TYPE_TCV1, FEM_TYPE_TCV1},
+       },
+       [FEM_WIRING_2_TCV0_6_TCV1_6] =3D {
+               {FEM_TYPE_TCV0, FEM_TYPE_TCV0, FEM_TYPE_TCV0,
+                       FEM_TYPE_TCV0, FEM_TYPE_TCV0, FEM_TYPE_TCV0},
+               {FEM_TYPE_TCV1, FEM_TYPE_TCV1, FEM_TYPE_TCV1,
+                       FEM_TYPE_TCV1, FEM_TYPE_TCV1, FEM_TYPE_TCV1},
+       },
+       [FEM_WIRING_3_TCV0_2_ELASTIC_4_TCV1_2] =3D {
+               {FEM_TYPE_TCV0, FEM_TYPE_TCV0, FEM_TYPE_ELASTIC,
+                       FEM_TYPE_ELASTIC, FEM_TYPE_ELASTIC, FEM_TYPE_ELASTI=
C},
+               {FEM_TYPE_TCV1, FEM_TYPE_TCV1, FEM_TYPE_ELASTIC,
+                       FEM_TYPE_ELASTIC, FEM_TYPE_ELASTIC, FEM_TYPE_ELASTI=
C},
+       },
+       [FEM_WIRING_4_TCV0_2_ELASTIC_4_TCV1_2] =3D {
+               {FEM_TYPE_TCV0, FEM_TYPE_TCV0, FEM_TYPE_ELASTIC,
+                       FEM_TYPE_ELASTIC, FEM_TYPE_ELASTIC, FEM_TYPE_ELASTI=
C},
+               {FEM_TYPE_TCV1, FEM_TYPE_TCV1, FEM_TYPE_ELASTIC,
+                       FEM_TYPE_ELASTIC, FEM_TYPE_ELASTIC, FEM_TYPE_ELASTI=
C},
+       },
+       [FEM_WIRING_5_TCV0_2_ELASTIC_4_TCV1_2] =3D {
+               {FEM_TYPE_TCV0, FEM_TYPE_TCV0, FEM_TYPE_ELASTIC,
+                       FEM_TYPE_ELASTIC, FEM_TYPE_ELASTIC, FEM_TYPE_ELASTI=
C},
+               {FEM_TYPE_TCV1, FEM_TYPE_TCV1, FEM_TYPE_ELASTIC,
+                       FEM_TYPE_ELASTIC, FEM_TYPE_ELASTIC, FEM_TYPE_ELASTI=
C},
+       },
+       [FEM_WIRING_6_TCV0_2_ELASTIC_4_TCV1_2] =3D {
+               {FEM_TYPE_TCV0, FEM_TYPE_TCV0, FEM_TYPE_ELASTIC,
+                       FEM_TYPE_ELASTIC, FEM_TYPE_ELASTIC, FEM_TYPE_ELASTI=
C},
+               {FEM_TYPE_TCV1, FEM_TYPE_TCV1, FEM_TYPE_ELASTIC,
+                       FEM_TYPE_ELASTIC, FEM_TYPE_ELASTIC, FEM_TYPE_ELASTI=
C},
+       },
+       [FEM_WIRING_7_TCV0_4_TCV1_4] =3D {
+               {FEM_TYPE_TCV0, FEM_TYPE_TCV0, FEM_TYPE_TCV0,
+                       FEM_TYPE_TCV0, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+               {FEM_TYPE_TCV1, FEM_TYPE_TCV1, FEM_TYPE_TCV1,
+                       FEM_TYPE_TCV1, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+       },
+       [FEM_WIRING_8_TCV0_4_TCV1_4] =3D {
+               {FEM_TYPE_TCV0, FEM_TYPE_TCV0, FEM_TYPE_TCV0,
+                       FEM_TYPE_TCV0, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+               {FEM_TYPE_TCV1, FEM_TYPE_TCV1, FEM_TYPE_TCV1,
+                       FEM_TYPE_TCV1, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+       },
+       [FEM_WIRING_9_TCV0_4_TCV1_4] =3D {
+               {FEM_TYPE_TCV0, FEM_TYPE_TCV0, FEM_TYPE_TCV0,
+                       FEM_TYPE_TCV0, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+               {FEM_TYPE_TCV1, FEM_TYPE_TCV1, FEM_TYPE_TCV1,
+                       FEM_TYPE_TCV1, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+       },
+       [FEM_WIRING_10_TCV0_4_TCV1_4] =3D {
+               {FEM_TYPE_TCV0, FEM_TYPE_TCV0, FEM_TYPE_TCV0,
+                       FEM_TYPE_TCV0, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+               {FEM_TYPE_TCV1, FEM_TYPE_TCV1, FEM_TYPE_TCV1,
+                       FEM_TYPE_TCV1, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+       },
+       [FEM_WIRING_11_TCV0_4_TCV1_4_RX_ONLY] =3D {
+               {FEM_TYPE_TCV0, FEM_TYPE_TCV0, FEM_TYPE_TCV0,
+                       FEM_TYPE_TCV0, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+               {FEM_TYPE_SENSING, FEM_TYPE_SENSING, FEM_TYPE_SENSING,
+                       FEM_TYPE_SENSING, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+       },
+       [FEM_WIRING_12_TCV0_4_TCV1_4_RX_ONLY] =3D {
+               {FEM_TYPE_TCV0, FEM_TYPE_TCV0, FEM_TYPE_TCV0,
+                       FEM_TYPE_TCV0, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+               {FEM_TYPE_SENSING, FEM_TYPE_SENSING, FEM_TYPE_SENSING,
+                       FEM_TYPE_SENSING, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+       },
+       [FEM_WIRING_13_SENSING_4RX_2TX] =3D {
+               {FEM_TYPE_SENSING, FEM_TYPE_SENSING, FEM_TYPE_SENSING,
+                       FEM_TYPE_SENSING, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+               {FEM_TYPE_TCV1, FEM_TYPE_TCV1, FEM_LUT_EMPTY,
+                       FEM_LUT_EMPTY, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+       },
+       [FEM_WIRING_14_SENSING_4TX_2RX] =3D {
+               {FEM_TYPE_TCV0, FEM_TYPE_TCV0, FEM_TYPE_TCV0,
+                       FEM_TYPE_TCV0, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+               {FEM_TYPE_SENSING, FEM_TYPE_SENSING, FEM_LUT_EMPTY,
+                       FEM_LUT_EMPTY, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+       },
+       [FEM_WIRING_15_CHAMELEON_4TX_4RX] =3D {
+               {FEM_TYPE_TCV0, FEM_TYPE_TCV0, FEM_TYPE_TCV0,
+                       FEM_TYPE_TCV0, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+               {FEM_TYPE_SENSING, FEM_TYPE_SENSING, FEM_TYPE_SENSING,
+                       FEM_TYPE_SENSING, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+       },
+       [FEM_WIRING_16_TCV0_2_TCV1_2] =3D {
+               {FEM_TYPE_TCV0, FEM_TYPE_TCV0, FEM_LUT_EMPTY,
+                       FEM_LUT_EMPTY, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+               {FEM_LUT_EMPTY, FEM_LUT_EMPTY, FEM_TYPE_TCV1,
+                       FEM_TYPE_TCV1, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+       },
+       [FEM_WIRING_17_TCV0_4_TCV1_0] =3D {
+               {FEM_TYPE_TCV0, FEM_TYPE_TCV0, FEM_TYPE_TCV0,
+                       FEM_TYPE_TCV0, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+               {FEM_LUT_EMPTY, FEM_LUT_EMPTY, FEM_LUT_EMPTY,
+                       FEM_LUT_EMPTY, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+       },
+       [FEM_WIRING_18_TCV0_4_TCV1_4] =3D {
+               {FEM_TYPE_TCV0, FEM_TYPE_TCV0, FEM_TYPE_TCV0,
+                       FEM_TYPE_TCV0, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+               {FEM_TYPE_TCV1, FEM_TYPE_TCV1, FEM_TYPE_TCV1,
+                       FEM_TYPE_TCV1, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+       },
+       [FEM_WIRING_19_TCV0_2_TCV1_2_SWAPPED] =3D {
+               {FEM_LUT_EMPTY, FEM_LUT_EMPTY, FEM_TYPE_TCV0,
+                       FEM_TYPE_TCV0, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+               {FEM_LUT_EMPTY, FEM_LUT_EMPTY, FEM_TYPE_TCV1,
+                       FEM_TYPE_TCV1, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+       },
+       [FEM_WIRING_20_TCV0_4_TCV1_2] =3D {
+               {FEM_TYPE_TCV0, FEM_TYPE_TCV0, FEM_TYPE_TCV0,
+                       FEM_TYPE_TCV0, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+               {FEM_LUT_EMPTY, FEM_LUT_EMPTY, FEM_TYPE_TCV1,
+                       FEM_TYPE_TCV1, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+       },
+       [FEM_WIRING_21_TCV0_4_TCV1_2] =3D {
+               {FEM_TYPE_TCV0, FEM_TYPE_TCV0, FEM_TYPE_TCV0,
+                       FEM_TYPE_TCV0, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+               {FEM_LUT_EMPTY, FEM_LUT_EMPTY, FEM_TYPE_SENSING,
+                       FEM_TYPE_SENSING, FEM_LUT_EMPTY, FEM_LUT_EMPTY},
+       }
+};
+
+static u16 cl_fem_reg_manual(struct cl_hw *cl_hw, u16 val, u8 ant_idx)
+{
+       u8 shift =3D 0;
+       u16 lut, lut0, lut1, lut2;
+
+       if (cl_hw->fem_ant !=3D ant_idx && cl_hw->fem_ant !=3D U8_MAX)
+               shift =3D 0; /* In case manual fem setting was chosen */
+       else
+               shift =3D cl_hw->fem_system_mode * 4;
+
+       lut =3D (val >> shift) & RIU_RC_RF_LNA_LUT_RFLNALUT_0_MASK;
+       lut0 =3D ((lut << RIU_RC_RF_LNA_LUT_RFLNALUT_0_LSB) & (u16)RIU_RC_R=
F_LNA_LUT_RFLNALUT_0_MASK);
+       lut1 =3D ((lut << RIU_RC_RF_LNA_LUT_RFLNALUT_1_LSB) & (u16)RIU_RC_R=
F_LNA_LUT_RFLNALUT_1_MASK);
+       lut2 =3D ((lut << RIU_RC_RF_LNA_LUT_RFLNALUT_2_LSB) & (u16)RIU_RC_R=
F_LNA_LUT_RFLNALUT_2_MASK);
+
+       return (lut0 | lut1 | lut2);
+}
+
+int cl_fem_get_registers(struct cl_hw *cl_hw, u32 fem_reg[FEM_REGISTERS_AM=
OUNT])
+{
+       u8 i;
+       u8 reg_idx;
+       u8 shift;
+       u8 tcv_idx =3D cl_hw->tcv_idx;
+       u16 reg_val;
+       struct cl_fem_params *fem =3D &cl_hw->chip->fem;
+
+       /* In case there's no valid wiring_id, keep the fem lut registers e=
mpty. */
+       if (fem->wiring_id >=3D FEM_WIRING_MAX)
+               return 0;
+
+       for (i =3D 0; i < MAX_ANTENNAS; i++) {
+               reg_idx =3D i >> 1; /* 0 - 2 */
+               shift =3D (i & 0x1) ? 16 : 0; /* even - 0. odd  - 16 */
+
+               if (i < cl_hw->num_antennas) {
+                       if (cl_hw->fem_system_mode =3D=3D FEM_MODE_OPERETIO=
NAL) {
+                               reg_val =3D fem->lut_registers[tcv_idx][i];
+                       } else {
+                               u16 fem_val =3D fem->lut_registers[tcv_idx]=
[i];
+
+                               reg_val =3D cl_fem_reg_manual(cl_hw, fem_va=
l, i);
+                       }
+               } else {
+                       reg_val =3D fem->lut_off_register[tcv_idx];
+               }
+
+               fem_reg[reg_idx] |=3D ((u32)reg_val << shift);
+       }
+
+       for (i =3D 0; i < FEM_REGISTERS_AMOUNT; i++)
+               cl_dbg_trace(cl_hw, "RC_RFLNALUT_%u: [0x%08X]\n", i, fem_re=
g[i]);
+
+       return 0;
+}
+
+static int cl_fem_read_lut(struct cl_chip *chip)
+{
+       int i;
+       int has_valid_fem_lut =3D 0;
+       struct cl_fem_params *fem =3D &chip->fem;
+
+       /* Read FEM LUT from eeprom */
+       if (cl_e2p_read(chip, (u8 *)&fem->lut, SIZE_FEM_LUT, ADDR_FEM_LUT))
+               return -1;
+
+       for (i =3D 0; i < FEM_TYPE_MAX; i++) {
+               if (fem->lut[i] =3D=3D U16_MAX)
+                       continue;
+
+               /* Mark as valid if at least one the FEM LUTs has a valid v=
alue. */
+               has_valid_fem_lut =3D 1;
+               fem->lut_off_register_list[i] =3D EXTRACT_OFF_LUT(fem->lut[=
i]);
+               fem->lut[i] &=3D FEM_LUT_MASK;
+               cl_dbg_chip_trace(chip, "lut[%d] =3D 0x%X, lut_off_register=
_list[%d] =3D 0x%X\n",
+                                 i, fem->lut[i], i, fem->lut_off_register_=
list[i]);
+       }
+
+       return !has_valid_fem_lut;
+}
+
+#define FEM_LUT_OFFSET_BYPASS 0
+#define FEM_LUT_OFFSET_TX     4
+#define FEM_LUT_OFFSET_RX     8
+#define FEM_LUT_OFFSET_OFF    12
+#define FEM_LUT_VAL_MASK      0x7
+
+static int _cl_fem_check_lut_validity(struct cl_chip *chip, enum fem_type =
type)
+{
+       u16 fem_lut =3D chip->fem.lut[type];
+       u16 bypass =3D (fem_lut >> FEM_LUT_OFFSET_BYPASS) & FEM_LUT_VAL_MAS=
K;
+       u16 tx =3D (fem_lut >> FEM_LUT_OFFSET_TX) & FEM_LUT_VAL_MASK;
+       u16 rx =3D (fem_lut >> FEM_LUT_OFFSET_RX) & FEM_LUT_VAL_MASK;
+       u16 off =3D (fem_lut >> FEM_LUT_OFFSET_OFF) & FEM_LUT_VAL_MASK;
+       int ret =3D 0;
+
+       if (fem_lut =3D=3D U16_MAX) {
+               cl_dbg_chip_err(chip, "Wiring_id [%u] must have valid FEM L=
UTs for %s\n",
+                               chip->fem.wiring_id, FEM_TYPE_STR(type));
+               return -1;
+       }
+
+       // Skip uniqueness check for sensing type
+       if (type =3D=3D FEM_TYPE_SENSING)
+               return 0;
+
+       // Check uniqueness of BYPASS/TX/RX/OFF
+       if (bypass =3D=3D tx) {
+               cl_dbg_chip_err(chip, "Error: bypass (%u) and tx (%u) value=
s are equal\n",
+                               bypass, tx);
+               ret =3D -EIO;
+       }
+
+       if (bypass =3D=3D rx) {
+               cl_dbg_chip_err(chip, "Error: bypass (%u) and rx (%u) value=
s are equal\n",
+                               bypass, rx);
+               ret =3D -EIO;
+       }
+
+       if (tx =3D=3D rx) {
+               cl_dbg_chip_err(chip, "Error: tx (%u) and rx (%u) values ar=
e equal\n",
+                               tx, rx);
+               ret =3D -EIO;
+       }
+
+       if (tx =3D=3D off) {
+               cl_dbg_chip_err(chip, "Error: tx (%u) and off (%u) values a=
re equal\n",
+                               tx, off);
+               ret =3D -EIO;
+       }
+
+       if (rx =3D=3D off) {
+               cl_dbg_chip_err(chip, "Error: rx (%u) and off (%u) values a=
re equal\n",
+                               rx, off);
+               ret =3D -EIO;
+       }
+
+       return ret;
+}
+
+static int cl_fem_check_lut_validity(struct cl_chip *chip, u8 wiring_id)
+{
+       if (cl_fem_read_lut(chip)) {
+               cl_dbg_chip_err(chip, "None of the FEM LUTs is valid. Abort=
ing.\n");
+               return -1;
+       }
+
+       switch (wiring_id) {
+       case FEM_WIRING_0_TCV0_6_TCV1_6:
+       case FEM_WIRING_1_TCV0_6_TCV1_6:
+       /* case FEM_WIRING_2_TCV0_6_TCV1_6: */
+       case FEM_WIRING_7_TCV0_4_TCV1_4:
+       /* case FEM_WIRING_8_TCV0_4_TCV1_4: */
+       case FEM_WIRING_9_TCV0_4_TCV1_4:
+       case FEM_WIRING_10_TCV0_4_TCV1_4:
+       case FEM_WIRING_16_TCV0_2_TCV1_2:
+       case FEM_WIRING_18_TCV0_4_TCV1_4:
+       case FEM_WIRING_19_TCV0_2_TCV1_2_SWAPPED:
+       case FEM_WIRING_20_TCV0_4_TCV1_2:
+               if (_cl_fem_check_lut_validity(chip, FEM_TYPE_TCV0) ||
+                   _cl_fem_check_lut_validity(chip, FEM_TYPE_TCV1))
+                       return -1;
+               break;
+
+       case FEM_WIRING_17_TCV0_4_TCV1_0:
+               if (_cl_fem_check_lut_validity(chip, FEM_TYPE_TCV0))
+                       return -1;
+               break;
+
+       case FEM_WIRING_3_TCV0_2_ELASTIC_4_TCV1_2:
+       case FEM_WIRING_4_TCV0_2_ELASTIC_4_TCV1_2:
+       /* case FEM_WIRING_5_TCV0_2_ELASTIC_4_TCV1_2: */
+       /* case FEM_WIRING_6_TCV0_2_ELASTIC_4_TCV1_2: */
+               if (_cl_fem_check_lut_validity(chip, FEM_TYPE_TCV0) ||
+                   _cl_fem_check_lut_validity(chip, FEM_TYPE_TCV1) ||
+                   _cl_fem_check_lut_validity(chip, FEM_TYPE_ELASTIC))
+                       return -1;
+               break;
+
+       case FEM_WIRING_11_TCV0_4_TCV1_4_RX_ONLY:
+       case FEM_WIRING_12_TCV0_4_TCV1_4_RX_ONLY:
+       case FEM_WIRING_14_SENSING_4TX_2RX:
+       case FEM_WIRING_15_CHAMELEON_4TX_4RX:
+       case FEM_WIRING_21_TCV0_4_TCV1_2:
+               if (_cl_fem_check_lut_validity(chip, FEM_TYPE_TCV0) ||
+                   _cl_fem_check_lut_validity(chip, FEM_TYPE_SENSING))
+                       return -1;
+               break;
+
+       case FEM_WIRING_13_SENSING_4RX_2TX:
+               if (_cl_fem_check_lut_validity(chip, FEM_TYPE_TCV1) ||
+                   _cl_fem_check_lut_validity(chip, FEM_TYPE_SENSING))
+                       return -1;
+               break;
+
+       case FEM_WIRING_2_TCV0_6_TCV1_6:
+       case FEM_WIRING_5_TCV0_2_ELASTIC_4_TCV1_2:
+       case FEM_WIRING_6_TCV0_2_ELASTIC_4_TCV1_2:
+       case FEM_WIRING_8_TCV0_4_TCV1_4:
+               cl_dbg_chip_err(chip, "wiring_id %u is not supported\n", wi=
ring_id);
+               return -1;
+
+       default:
+               cl_dbg_chip_err(chip, "Wiring_id [%u] is not valid [0..%u]\=
n",
+                               wiring_id, FEM_WIRING_MAX - 1);
+               return -1;
+       }
+
+       return 0;
+}
+
+static int cl_fem_validate_wiring_id(struct cl_chip *chip, u8 wiring_id)
+{
+       switch (wiring_id) {
+       case FEM_WIRING_0_TCV0_6_TCV1_6:
+       case FEM_WIRING_1_TCV0_6_TCV1_6:
+       case FEM_WIRING_2_TCV0_6_TCV1_6:
+       case FEM_WIRING_3_TCV0_2_ELASTIC_4_TCV1_2:
+       case FEM_WIRING_4_TCV0_2_ELASTIC_4_TCV1_2:
+       case FEM_WIRING_5_TCV0_2_ELASTIC_4_TCV1_2:
+       case FEM_WIRING_6_TCV0_2_ELASTIC_4_TCV1_2:
+       case FEM_WIRING_7_TCV0_4_TCV1_4:
+       case FEM_WIRING_8_TCV0_4_TCV1_4:
+       case FEM_WIRING_9_TCV0_4_TCV1_4:
+       case FEM_WIRING_10_TCV0_4_TCV1_4:
+       case FEM_WIRING_11_TCV0_4_TCV1_4_RX_ONLY:
+       case FEM_WIRING_12_TCV0_4_TCV1_4_RX_ONLY:
+       case FEM_WIRING_13_SENSING_4RX_2TX:
+       case FEM_WIRING_14_SENSING_4TX_2RX:
+       case FEM_WIRING_15_CHAMELEON_4TX_4RX:
+       case FEM_WIRING_18_TCV0_4_TCV1_4:
+       case FEM_WIRING_19_TCV0_2_TCV1_2_SWAPPED:
+               return cl_chip_is_8ant(chip) ? 0 : -1;
+       case FEM_WIRING_20_TCV0_4_TCV1_2:
+       case FEM_WIRING_21_TCV0_4_TCV1_2:
+               return cl_chip_is_6ant(chip) ? 0 : -1;
+       case FEM_WIRING_16_TCV0_2_TCV1_2:
+       case FEM_WIRING_17_TCV0_4_TCV1_0:
+               return cl_chip_is_4ant(chip) ? 0 : -1;
+       default:
+               cl_dbg_chip_err(chip, "wiring_id %u is not valid. [0..%u] a=
re valid values\n",
+                               wiring_id, (FEM_WIRING_MAX - 1));
+               return -1;
+       }
+
+       return -1;
+}
+
+int cl_fem_read_wiring_id(struct cl_chip *chip)
+{
+       struct cl_fem_params *fem =3D &chip->fem;
+
+       /* In case there's a valid wiring id in chip, no need to re-read it=
 from EEPROM */
+       if (fem->wiring_id < FEM_WIRING_MAX)
+               return 0;
+
+       /* Read wiring_id from eeprom */
+       if (cl_e2p_read(chip, &fem->wiring_id, SIZE_FEM_WIRING_ID, ADDR_FEM=
_WIRING_ID))
+               return -1;
+
+       return cl_fem_validate_wiring_id(chip, fem->wiring_id);
+}
+
+static void cl_fem_set_registers(struct cl_chip *chip)
+{
+       struct cl_fem_params *fem =3D &chip->fem;
+       int i;
+       u8 wiring_id =3D fem->wiring_id;
+
+       for (i =3D 0; i < FEM_LUT_AMOUNT_PER_MAC; i++) {
+               fem->lut_registers[TCV0][i] =3D fem->lut[fem_full_list[wiri=
ng_id][TCV0][i]];
+               fem->lut_registers[TCV1][i] =3D fem->lut[fem_full_list[wiri=
ng_id][TCV1][i]];
+       }
+}
+
+static int cl_fem_set_lut_off(struct cl_chip *chip)
+{
+       struct cl_fem_params *fem =3D &chip->fem;
+
+       switch (fem->wiring_id) {
+       case FEM_WIRING_0_TCV0_6_TCV1_6:
+       case FEM_WIRING_1_TCV0_6_TCV1_6:
+       case FEM_WIRING_2_TCV0_6_TCV1_6:
+       case FEM_WIRING_7_TCV0_4_TCV1_4:
+       case FEM_WIRING_8_TCV0_4_TCV1_4:
+       case FEM_WIRING_9_TCV0_4_TCV1_4:
+       case FEM_WIRING_10_TCV0_4_TCV1_4:
+       case FEM_WIRING_11_TCV0_4_TCV1_4_RX_ONLY:
+       case FEM_WIRING_12_TCV0_4_TCV1_4_RX_ONLY:
+       case FEM_WIRING_13_SENSING_4RX_2TX:
+       case FEM_WIRING_14_SENSING_4TX_2RX:
+       case FEM_WIRING_15_CHAMELEON_4TX_4RX:
+       case FEM_WIRING_16_TCV0_2_TCV1_2:
+       case FEM_WIRING_18_TCV0_4_TCV1_4:
+       case FEM_WIRING_19_TCV0_2_TCV1_2_SWAPPED:
+       case FEM_WIRING_20_TCV0_4_TCV1_2:
+       case FEM_WIRING_21_TCV0_4_TCV1_2:
+               fem->lut_off_register[TCV0] =3D fem->lut_off_register_list[=
FEM_TYPE_TCV0];
+               fem->lut_off_register[TCV1] =3D fem->lut_off_register_list[=
FEM_TYPE_TCV1];
+               break;
+
+       case FEM_WIRING_17_TCV0_4_TCV1_0:
+               fem->lut_off_register[TCV0] =3D fem->lut_off_register_list[=
FEM_TYPE_TCV0];
+               break;
+
+       case FEM_WIRING_3_TCV0_2_ELASTIC_4_TCV1_2:
+       case FEM_WIRING_4_TCV0_2_ELASTIC_4_TCV1_2:
+       case FEM_WIRING_5_TCV0_2_ELASTIC_4_TCV1_2:
+       case FEM_WIRING_6_TCV0_2_ELASTIC_4_TCV1_2:
+               fem->lut_off_register[TCV0] =3D fem->lut_off_register_list[=
FEM_TYPE_ELASTIC];
+               fem->lut_off_register[TCV1] =3D fem->lut_off_register_list[=
FEM_TYPE_ELASTIC];
+               break;
+
+       default:
+               cl_dbg_chip_err(chip, "Unsupported wiring id [%u]\n", fem->=
wiring_id);
+               return -1;
+       }
+
+       cl_dbg_chip_trace(chip, "wiring_id =3D %u, lut_off_register =3D [%u=
 %u]\n",
+                         fem->wiring_id,
+                         fem->lut_off_register[TCV0],
+                         fem->lut_off_register[TCV1]);
+       return 0;
+}
+
+int cl_fem_init(struct cl_chip *chip)
+{
+       int ret =3D 0;
+       struct cl_fem_params *fem =3D &chip->fem;
+
+       fem->wiring_id =3D FEM_WIRING_DEFAULT;
+
+       ret =3D cl_fem_read_wiring_id(chip);
+
+       if (ret) {
+               CL_DBG_ERROR_CHIP(chip, "Invalid wiring_id =3D %u. Aborting=
.\n", fem->wiring_id);
+
+               if (!chip->conf->ce_production_mode)
+                       return ret;
+       }
+
+       if (cl_fem_read_lut(chip)) {
+               CL_DBG_ERROR_CHIP(chip, "None of the FEM_LUT registers is v=
alid. Aborting.\n");
+
+               if (!chip->conf->ce_production_mode)
+                       return -1;
+       }
+
+       if (cl_fem_check_lut_validity(chip, fem->wiring_id) &&
+           !chip->conf->ce_production_mode)
+               return -1;
+
+       if (cl_fem_set_lut_off(chip) &&
+           !chip->conf->ce_production_mode)
+               return -1;
+
+       cl_dbg_chip_verbose(chip, "wiring_id =3D %u\n", fem->wiring_id);
+       cl_fem_set_registers(chip);
+
+       ret =3D cl_agc_params_read_platform_id(chip);
+       if (ret)
+               return ret;
+
+       return 0;
+}
+
+static void cl_fem_get_conf_params(struct cl_chip *chip,
+                                  u32 *ricu_fem_conf_0,
+                                  u32 *ricu_fem_conf_1)
+{
+       u8 wiring_id =3D chip->fem.wiring_id;
+
+       *ricu_fem_conf_0 =3D ricu_fem_conf[wiring_id][0];
+       *ricu_fem_conf_1 =3D ricu_fem_conf[wiring_id][1];
+
+       cl_dbg_chip_verbose(chip, "ricu_fem_conf_0 =3D 0x%08X, ricu_fem_con=
f_1 =3D 0x%08X\n",
+                           *ricu_fem_conf_0, *ricu_fem_conf_1);
+}
+
+static u8 get_num_antennas_tcv0(struct cl_chip *chip)
+{
+       if (chip->cl_hw_tcv0)
+               return chip->cl_hw_tcv0->num_antennas;
+       else
+               return chip->max_antennas - chip->cl_hw_tcv1->num_antennas;
+}
+
+static void update_formation_1_band_select(struct cl_chip *chip)
+{
+       u8 num_antennas_tcv0 =3D get_num_antennas_tcv0(chip);
+
+       if (num_antennas_tcv0 =3D=3D 2) {
+               io_ctrl_pa_enable_4_set(chip, PA_ENABLE_GPIO_OUT_CFG(0));
+               io_ctrl_pa_enable_5_set(chip, PA_ENABLE_GPIO_OUT_CFG(0));
+               io_ctrl_pa_enable_8_set(chip, PA_ENABLE_GPIO_OUT_CFG(0));
+               io_ctrl_pa_enable_9_set(chip, PA_ENABLE_GPIO_OUT_CFG(0));
+       } else if (num_antennas_tcv0 =3D=3D 3) {
+               io_ctrl_pa_enable_4_set(chip, PA_ENABLE_GPIO_OUT_CFG(0));
+               io_ctrl_pa_enable_5_set(chip, PA_ENABLE_GPIO_OUT_CFG(0));
+               io_ctrl_pa_enable_8_set(chip, PA_ENABLE_GPIO_OUT_CFG(1));
+               io_ctrl_pa_enable_9_set(chip, PA_ENABLE_GPIO_OUT_CFG(0));
+       } else if (num_antennas_tcv0 =3D=3D 4) {
+               io_ctrl_pa_enable_4_set(chip, PA_ENABLE_GPIO_OUT_CFG(0));
+               io_ctrl_pa_enable_5_set(chip, PA_ENABLE_GPIO_OUT_CFG(0));
+               io_ctrl_pa_enable_8_set(chip, PA_ENABLE_GPIO_OUT_CFG(1));
+               io_ctrl_pa_enable_9_set(chip, PA_ENABLE_GPIO_OUT_CFG(1));
+       } else if (num_antennas_tcv0 =3D=3D 5) {
+               io_ctrl_pa_enable_4_set(chip, PA_ENABLE_GPIO_OUT_CFG(1));
+               io_ctrl_pa_enable_5_set(chip, PA_ENABLE_GPIO_OUT_CFG(0));
+               io_ctrl_pa_enable_8_set(chip, PA_ENABLE_GPIO_OUT_CFG(1));
+               io_ctrl_pa_enable_9_set(chip, PA_ENABLE_GPIO_OUT_CFG(1));
+       } else if (num_antennas_tcv0 =3D=3D 6) {
+               io_ctrl_pa_enable_4_set(chip, PA_ENABLE_GPIO_OUT_CFG(1));
+               io_ctrl_pa_enable_5_set(chip, PA_ENABLE_GPIO_OUT_CFG(1));
+               io_ctrl_pa_enable_8_set(chip, PA_ENABLE_GPIO_OUT_CFG(1));
+               io_ctrl_pa_enable_9_set(chip, PA_ENABLE_GPIO_OUT_CFG(1));
+       }
+}
+
+static void set_lna_bypass_gpio(struct cl_chip *chip)
+{
+       struct cl_fem_params *fem =3D &chip->fem;
+       u8 lna_bypass_val_tcv0 =3D fem->lut[FEM_TYPE_TCV0] & RIU_RC_RF_LNA_=
LUT_RFLNALUT_0_MASK;
+       u8 lna_bypass_val_tcv1 =3D fem->lut[FEM_TYPE_TCV1] & RIU_RC_RF_LNA_=
LUT_RFLNALUT_0_MASK;
+       u8 lna_bypass_val_elastic =3D fem->lut[FEM_TYPE_ELASTIC] & RIU_RC_R=
F_LNA_LUT_RFLNALUT_0_MASK;
+       u8 lna_bypass_val_sensing =3D fem->lut[FEM_TYPE_SENSING] & RIU_RC_R=
F_LNA_LUT_RFLNALUT_0_MASK;
+       u8 pa_enable_bit_tcv0 =3D GET_BIT(lna_bypass_val_tcv0, PA_ENABLE_PO=
S);
+       u8 pa_enable_bit_tcv1 =3D GET_BIT(lna_bypass_val_tcv1, PA_ENABLE_PO=
S);
+       u8 pa_enable_bit_elastic =3D GET_BIT(lna_bypass_val_elastic, PA_ENA=
BLE_POS);
+       u8 pa_enable_bit_sensing =3D GET_BIT(lna_bypass_val_sensing, PA_ENA=
BLE_POS);
+       u8 lna_enable_bit_tcv0 =3D GET_BIT(lna_bypass_val_tcv0, LNA_ENABLE_=
POS);
+       u8 lna_enable_bit_tcv1 =3D GET_BIT(lna_bypass_val_tcv1, LNA_ENABLE_=
POS);
+       u8 lna_enable_bit_elastic =3D GET_BIT(lna_bypass_val_elastic, LNA_E=
NABLE_POS);
+       u8 lna_enable_bit_sensing =3D GET_BIT(lna_bypass_val_sensing, LNA_E=
NABLE_POS);
+       u8 rx_active_bit_tcv0 =3D GET_BIT(lna_bypass_val_tcv0, RX_ACTIVE_PO=
S);
+       u8 rx_active_bit_tcv1 =3D GET_BIT(lna_bypass_val_tcv1, RX_ACTIVE_PO=
S);
+       u8 rx_active_bit_sensing =3D GET_BIT(lna_bypass_val_sensing, RX_ACT=
IVE_POS);
+       u32 pa_enable_cfg_tcv0 =3D PA_ENABLE_GPIO_OUT_CFG(pa_enable_bit_tcv=
0);
+       u32 pa_enable_cfg_tcv1 =3D PA_ENABLE_GPIO_OUT_CFG(pa_enable_bit_tcv=
1);
+       u32 pa_enable_cfg_elastic =3D PA_ENABLE_GPIO_OUT_CFG(pa_enable_bit_=
elastic);
+       u32 pa_enable_cfg_sensing =3D PA_ENABLE_GPIO_OUT_CFG(pa_enable_bit_=
sensing);
+       u32 lna_enable_cfg_tcv0 =3D LNA_ENABLE_GPIO_OUT_CFG(lna_enable_bit_=
tcv0);
+       u32 lna_enable_cfg_tcv1 =3D LNA_ENABLE_GPIO_OUT_CFG(lna_enable_bit_=
tcv1);
+       u32 lna_enable_cfg_elastic =3D LNA_ENABLE_GPIO_OUT_CFG(lna_enable_b=
it_elastic);
+       u32 lna_enable_cfg_sensing =3D LNA_ENABLE_GPIO_OUT_CFG(lna_enable_b=
it_sensing);
+       u32 rx_active_cfg_tcv0 =3D RX_ACTIVE_GPIO_OUT_CFG(rx_active_bit_tcv=
0);
+       u32 rx_active_cfg_tcv1 =3D RX_ACTIVE_GPIO_OUT_CFG(rx_active_bit_tcv=
1);
+       u32 rx_active_cfg_sensing =3D RX_ACTIVE_GPIO_OUT_CFG(rx_active_bit_=
sensing);
+
+       switch (fem->wiring_id) {
+       case FEM_WIRING_0_TCV0_6_TCV1_6:
+               io_ctrl_lna_enable_0_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_1_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_2_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_3_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_4_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_5_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_6_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_7_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_8_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_9_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_10_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_11_set(chip, lna_enable_cfg_tcv0);
+
+               io_ctrl_pa_enable_0_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_1_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_2_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_3_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_4_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_5_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_6_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_7_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_8_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_9_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_10_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_11_set(chip, pa_enable_cfg_tcv0);
+
+               io_ctrl_rx_active_0_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_1_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_2_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_3_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_4_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_5_set(chip, rx_active_cfg_tcv0);
+               break;
+       case FEM_WIRING_1_TCV0_6_TCV1_6:
+               io_ctrl_lna_enable_0_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_1_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_2_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_3_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_4_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_5_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_6_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_7_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_8_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_9_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_10_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_11_set(chip, lna_enable_cfg_tcv0);
+
+               io_ctrl_pa_enable_0_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_1_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_2_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_3_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_4_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_5_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_6_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_7_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_8_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_9_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_10_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_11_set(chip, pa_enable_cfg_tcv0);
+               break;
+       case FEM_WIRING_2_TCV0_6_TCV1_6:
+               /* TBD */
+               break;
+       case FEM_WIRING_3_TCV0_2_ELASTIC_4_TCV1_2:
+               io_ctrl_lna_enable_0_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_1_set(chip, lna_enable_cfg_elastic);
+               io_ctrl_lna_enable_2_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_3_set(chip, lna_enable_cfg_elastic);
+               io_ctrl_lna_enable_6_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_7_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_10_set(chip, lna_enable_cfg_elastic);
+               io_ctrl_lna_enable_11_set(chip, lna_enable_cfg_elastic);
+
+               io_ctrl_pa_enable_0_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_1_set(chip, pa_enable_cfg_elastic);
+               io_ctrl_pa_enable_2_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_3_set(chip, pa_enable_cfg_elastic);
+               io_ctrl_pa_enable_6_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_7_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_10_set(chip, pa_enable_cfg_elastic);
+               io_ctrl_pa_enable_11_set(chip, pa_enable_cfg_elastic);
+
+               io_ctrl_rx_active_0_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_1_set(chip, rx_active_cfg_tcv0);
+               break;
+       case FEM_WIRING_4_TCV0_2_ELASTIC_4_TCV1_2:
+               io_ctrl_lna_enable_0_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_1_set(chip, lna_enable_cfg_elastic);
+               io_ctrl_lna_enable_2_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_3_set(chip, lna_enable_cfg_elastic);
+               io_ctrl_lna_enable_6_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_7_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_10_set(chip, lna_enable_cfg_elastic);
+               io_ctrl_lna_enable_11_set(chip, lna_enable_cfg_elastic);
+
+               io_ctrl_pa_enable_0_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_1_set(chip, pa_enable_cfg_elastic);
+               io_ctrl_pa_enable_2_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_3_set(chip, pa_enable_cfg_elastic);
+               io_ctrl_pa_enable_6_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_7_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_10_set(chip, pa_enable_cfg_elastic);
+               io_ctrl_pa_enable_11_set(chip, pa_enable_cfg_elastic);
+               break;
+       case FEM_WIRING_5_TCV0_2_ELASTIC_4_TCV1_2:
+               io_ctrl_lna_enable_0_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_1_set(chip, lna_enable_cfg_elastic);
+               io_ctrl_lna_enable_2_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_3_set(chip, lna_enable_cfg_elastic);
+               io_ctrl_lna_enable_6_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_7_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_10_set(chip, lna_enable_cfg_elastic);
+               io_ctrl_lna_enable_11_set(chip, lna_enable_cfg_elastic);
+
+               io_ctrl_pa_enable_0_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_1_set(chip, pa_enable_cfg_elastic);
+               io_ctrl_pa_enable_2_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_3_set(chip, pa_enable_cfg_elastic);
+               io_ctrl_pa_enable_6_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_7_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_10_set(chip, pa_enable_cfg_elastic);
+               io_ctrl_pa_enable_11_set(chip, pa_enable_cfg_elastic);
+
+               io_ctrl_rx_active_0_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_1_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_6_set(chip, rx_active_cfg_tcv1);
+               io_ctrl_rx_active_7_set(chip, rx_active_cfg_tcv1);
+               break;
+       case FEM_WIRING_6_TCV0_2_ELASTIC_4_TCV1_2:
+               /* TBD */
+               break;
+       case FEM_WIRING_7_TCV0_4_TCV1_4:
+               io_ctrl_lna_enable_0_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_2_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_6_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_7_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_8_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_9_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_10_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_11_set(chip, lna_enable_cfg_tcv0);
+
+               io_ctrl_pa_enable_0_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_2_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_6_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_7_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_8_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_9_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_10_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_11_set(chip, pa_enable_cfg_tcv0);
+
+               io_ctrl_rx_active_0_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_1_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_2_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_3_set(chip, rx_active_cfg_tcv0);
+               break;
+       case FEM_WIRING_8_TCV0_4_TCV1_4:
+               /* TBD */
+               break;
+       case FEM_WIRING_9_TCV0_4_TCV1_4:
+               io_ctrl_lna_enable_0_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_1_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_2_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_3_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_4_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_5_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_6_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_7_set(chip, lna_enable_cfg_tcv1);
+
+               io_ctrl_pa_enable_0_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_1_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_2_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_3_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_4_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_5_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_6_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_7_set(chip, pa_enable_cfg_tcv1);
+               break;
+       case FEM_WIRING_10_TCV0_4_TCV1_4:
+               io_ctrl_lna_enable_0_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_1_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_2_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_3_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_4_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_5_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_6_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_7_set(chip, lna_enable_cfg_tcv1);
+
+               io_ctrl_pa_enable_0_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_1_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_2_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_3_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_4_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_5_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_6_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_7_set(chip, pa_enable_cfg_tcv1);
+
+               io_ctrl_rx_active_0_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_1_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_2_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_3_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_4_set(chip, rx_active_cfg_tcv1);
+               io_ctrl_rx_active_5_set(chip, rx_active_cfg_tcv1);
+               io_ctrl_rx_active_6_set(chip, rx_active_cfg_tcv1);
+               io_ctrl_rx_active_7_set(chip, rx_active_cfg_tcv1);
+               break;
+       case FEM_WIRING_11_TCV0_4_TCV1_4_RX_ONLY:
+               io_ctrl_lna_enable_0_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_1_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_2_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_3_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_4_set(chip, lna_enable_cfg_sensing);
+               io_ctrl_lna_enable_5_set(chip, lna_enable_cfg_sensing);
+               io_ctrl_lna_enable_6_set(chip, lna_enable_cfg_sensing);
+               io_ctrl_lna_enable_7_set(chip, lna_enable_cfg_sensing);
+
+               io_ctrl_pa_enable_0_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_1_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_2_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_3_set(chip, pa_enable_cfg_tcv0);
+
+               io_ctrl_rx_active_0_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_1_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_2_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_3_set(chip, rx_active_cfg_tcv0);
+               break;
+       case FEM_WIRING_12_TCV0_4_TCV1_4_RX_ONLY:
+               io_ctrl_lna_enable_0_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_1_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_2_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_3_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_4_set(chip, lna_enable_cfg_sensing);
+               io_ctrl_lna_enable_5_set(chip, lna_enable_cfg_sensing);
+               io_ctrl_lna_enable_6_set(chip, lna_enable_cfg_sensing);
+               io_ctrl_lna_enable_7_set(chip, lna_enable_cfg_sensing);
+
+               io_ctrl_pa_enable_0_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_1_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_2_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_3_set(chip, pa_enable_cfg_tcv0);
+               break;
+       case FEM_WIRING_13_SENSING_4RX_2TX:
+               io_ctrl_lna_enable_0_set(chip, lna_enable_cfg_sensing);
+               io_ctrl_lna_enable_1_set(chip, lna_enable_cfg_sensing);
+               io_ctrl_lna_enable_2_set(chip, lna_enable_cfg_sensing);
+               io_ctrl_lna_enable_3_set(chip, lna_enable_cfg_sensing);
+               io_ctrl_lna_enable_10_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_11_set(chip, lna_enable_cfg_tcv1);
+
+               io_ctrl_pa_enable_0_set(chip, pa_enable_cfg_sensing);
+               io_ctrl_pa_enable_1_set(chip, pa_enable_cfg_sensing);
+               io_ctrl_pa_enable_2_set(chip, pa_enable_cfg_sensing);
+               io_ctrl_pa_enable_3_set(chip, pa_enable_cfg_sensing);
+               io_ctrl_pa_enable_10_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_11_set(chip, pa_enable_cfg_tcv1);
+
+               io_ctrl_rx_active_0_set(chip, rx_active_cfg_sensing);
+               io_ctrl_rx_active_1_set(chip, rx_active_cfg_sensing);
+               io_ctrl_rx_active_2_set(chip, rx_active_cfg_sensing);
+               io_ctrl_rx_active_3_set(chip, rx_active_cfg_sensing);
+               io_ctrl_rx_active_4_set(chip, rx_active_cfg_tcv1);
+               io_ctrl_rx_active_5_set(chip, rx_active_cfg_tcv1);
+               break;
+       case FEM_WIRING_14_SENSING_4TX_2RX:
+               io_ctrl_lna_enable_0_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_1_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_2_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_3_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_6_set(chip, lna_enable_cfg_sensing);
+               io_ctrl_lna_enable_7_set(chip, lna_enable_cfg_sensing);
+
+               io_ctrl_pa_enable_0_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_1_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_2_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_3_set(chip, pa_enable_cfg_tcv0);
+
+               io_ctrl_rx_active_0_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_1_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_2_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_3_set(chip, rx_active_cfg_tcv0);
+               break;
+       case FEM_WIRING_15_CHAMELEON_4TX_4RX:
+               io_ctrl_lna_enable_0_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_2_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_4_set(chip, lna_enable_cfg_sensing);
+               io_ctrl_lna_enable_5_set(chip, lna_enable_cfg_sensing);
+               io_ctrl_lna_enable_6_set(chip, lna_enable_cfg_sensing);
+               io_ctrl_lna_enable_7_set(chip, lna_enable_cfg_sensing);
+               io_ctrl_lna_enable_10_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_11_set(chip, lna_enable_cfg_tcv0);
+
+               io_ctrl_pa_enable_0_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_2_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_10_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_11_set(chip, pa_enable_cfg_tcv0);
+
+               io_ctrl_rx_active_0_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_1_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_2_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_3_set(chip, rx_active_cfg_tcv0);
+               break;
+       case FEM_WIRING_16_TCV0_2_TCV1_2:
+               io_ctrl_lna_enable_0_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_6_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_9_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_10_set(chip, lna_enable_cfg_tcv0);
+
+               io_ctrl_pa_enable_0_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_6_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_9_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_10_set(chip, pa_enable_cfg_tcv0);
+
+               io_ctrl_rx_active_1_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_2_set(chip, rx_active_cfg_tcv0);
+               break;
+       case FEM_WIRING_17_TCV0_4_TCV1_0:
+               io_ctrl_lna_enable_0_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_1_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_2_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_3_set(chip, lna_enable_cfg_tcv0);
+
+               io_ctrl_pa_enable_0_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_1_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_2_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_3_set(chip, pa_enable_cfg_tcv0);
+               break;
+       case FEM_WIRING_18_TCV0_4_TCV1_4:
+               io_ctrl_lna_enable_0_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_2_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_6_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_7_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_8_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_9_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_10_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_11_set(chip, lna_enable_cfg_tcv0);
+
+               io_ctrl_pa_enable_0_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_2_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_6_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_7_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_8_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_9_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_10_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_11_set(chip, pa_enable_cfg_tcv0);
+
+               io_ctrl_rx_active_0_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_1_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_2_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_3_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_4_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_5_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_6_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_7_set(chip, rx_active_cfg_tcv0);
+               break;
+       case FEM_WIRING_19_TCV0_2_TCV1_2_SWAPPED:
+               io_ctrl_lna_enable_8_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_9_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_10_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_11_set(chip, lna_enable_cfg_tcv0);
+
+               io_ctrl_pa_enable_8_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_9_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_10_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_11_set(chip, pa_enable_cfg_tcv0);
+
+               io_ctrl_rx_active_4_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_5_set(chip, rx_active_cfg_tcv0);
+               break;
+       case FEM_WIRING_20_TCV0_4_TCV1_2:
+               io_ctrl_lna_enable_0_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_2_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_8_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_9_set(chip, lna_enable_cfg_tcv1);
+               io_ctrl_lna_enable_10_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_11_set(chip, lna_enable_cfg_tcv0);
+
+               io_ctrl_pa_enable_0_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_2_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_8_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_9_set(chip, pa_enable_cfg_tcv1);
+               io_ctrl_pa_enable_10_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_11_set(chip, pa_enable_cfg_tcv0);
+
+               io_ctrl_rx_active_0_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_1_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_2_set(chip, rx_active_cfg_tcv0);
+               io_ctrl_rx_active_3_set(chip, rx_active_cfg_tcv0);
+               break;
+       case FEM_WIRING_21_TCV0_4_TCV1_2:
+               io_ctrl_lna_enable_0_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_1_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_2_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_3_set(chip, lna_enable_cfg_tcv0);
+               io_ctrl_lna_enable_4_set(chip, lna_enable_cfg_sensing);
+               io_ctrl_lna_enable_5_set(chip, lna_enable_cfg_sensing);
+
+               io_ctrl_pa_enable_0_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_1_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_2_set(chip, pa_enable_cfg_tcv0);
+               io_ctrl_pa_enable_3_set(chip, pa_enable_cfg_tcv0);
+               break;
+       default:
+               break;
+       }
+}
+
+static void _cl_fem_conf_gpio(struct cl_chip *chip,
+                             const struct cl_fem_lna_enable_gpio *lna_enab=
le_gpio,
+                             const struct cl_fem_pa_enable_gpio *pa_enable=
_gpio,
+                             const struct cl_fem_rx_active_gpio *rx_active=
_gpio)
+{
+       io_ctrl_lna_enable_0_set(chip, LNA_ENABLE_GPIO_VAL(lna_enable_gpio-=
>b0));
+       io_ctrl_lna_enable_1_set(chip, LNA_ENABLE_GPIO_VAL(lna_enable_gpio-=
>b1));
+       io_ctrl_lna_enable_2_set(chip, LNA_ENABLE_GPIO_VAL(lna_enable_gpio-=
>b2));
+       io_ctrl_lna_enable_3_set(chip, LNA_ENABLE_GPIO_VAL(lna_enable_gpio-=
>b3));
+       io_ctrl_lna_enable_4_set(chip, LNA_ENABLE_GPIO_VAL(lna_enable_gpio-=
>b4));
+       io_ctrl_lna_enable_5_set(chip, LNA_ENABLE_GPIO_VAL(lna_enable_gpio-=
>b5));
+       io_ctrl_lna_enable_6_set(chip, LNA_ENABLE_GPIO_VAL(lna_enable_gpio-=
>b6));
+       io_ctrl_lna_enable_7_set(chip, LNA_ENABLE_GPIO_VAL(lna_enable_gpio-=
>b7));
+       io_ctrl_lna_enable_8_set(chip, LNA_ENABLE_GPIO_VAL(lna_enable_gpio-=
>b8));
+       io_ctrl_lna_enable_9_set(chip, LNA_ENABLE_GPIO_VAL(lna_enable_gpio-=
>b9));
+       io_ctrl_lna_enable_10_set(chip, LNA_ENABLE_GPIO_VAL(lna_enable_gpio=
->b10));
+       io_ctrl_lna_enable_11_set(chip, LNA_ENABLE_GPIO_VAL(lna_enable_gpio=
->b11));
+
+       io_ctrl_pa_enable_0_set(chip, PA_ENABLE_GPIO_VAL(pa_enable_gpio->b0=
));
+       io_ctrl_pa_enable_1_set(chip, PA_ENABLE_GPIO_VAL(pa_enable_gpio->b1=
));
+       io_ctrl_pa_enable_2_set(chip, PA_ENABLE_GPIO_VAL(pa_enable_gpio->b2=
));
+       io_ctrl_pa_enable_3_set(chip, PA_ENABLE_GPIO_VAL(pa_enable_gpio->b3=
));
+       io_ctrl_pa_enable_4_set(chip, PA_ENABLE_GPIO_VAL(pa_enable_gpio->b4=
));
+       io_ctrl_pa_enable_5_set(chip, PA_ENABLE_GPIO_VAL(pa_enable_gpio->b5=
));
+       io_ctrl_pa_enable_6_set(chip, PA_ENABLE_GPIO_VAL(pa_enable_gpio->b6=
));
+       io_ctrl_pa_enable_7_set(chip, PA_ENABLE_GPIO_VAL(pa_enable_gpio->b7=
));
+       io_ctrl_pa_enable_8_set(chip, PA_ENABLE_GPIO_VAL(pa_enable_gpio->b8=
));
+       io_ctrl_pa_enable_9_set(chip, PA_ENABLE_GPIO_VAL(pa_enable_gpio->b9=
));
+       io_ctrl_pa_enable_10_set(chip, PA_ENABLE_GPIO_VAL(pa_enable_gpio->b=
10));
+       io_ctrl_pa_enable_11_set(chip, PA_ENABLE_GPIO_VAL(pa_enable_gpio->b=
11));
+
+       io_ctrl_rx_active_0_set(chip, RX_ACTIVE_GPIO_VAL(rx_active_gpio->b0=
));
+       io_ctrl_rx_active_1_set(chip, RX_ACTIVE_GPIO_VAL(rx_active_gpio->b1=
));
+       io_ctrl_rx_active_2_set(chip, RX_ACTIVE_GPIO_VAL(rx_active_gpio->b2=
));
+       io_ctrl_rx_active_3_set(chip, RX_ACTIVE_GPIO_VAL(rx_active_gpio->b3=
));
+       io_ctrl_rx_active_4_set(chip, RX_ACTIVE_GPIO_VAL(rx_active_gpio->b4=
));
+       io_ctrl_rx_active_5_set(chip, RX_ACTIVE_GPIO_VAL(rx_active_gpio->b5=
));
+       io_ctrl_rx_active_6_set(chip, RX_ACTIVE_GPIO_VAL(rx_active_gpio->b6=
));
+       io_ctrl_rx_active_7_set(chip, RX_ACTIVE_GPIO_VAL(rx_active_gpio->b7=
));
+}
+
+static int cl_fem_conf_gpio(struct cl_chip *chip)
+{
+       struct cl_fem_params *fem =3D &chip->fem;
+       u8 wiring_id =3D fem->wiring_id;
+
+       if (wiring_id =3D=3D FEM_WIRING_2_TCV0_6_TCV1_6 ||
+           wiring_id =3D=3D FEM_WIRING_5_TCV0_2_ELASTIC_4_TCV1_2 ||
+           wiring_id =3D=3D FEM_WIRING_6_TCV0_2_ELASTIC_4_TCV1_2 ||
+           wiring_id =3D=3D FEM_WIRING_8_TCV0_4_TCV1_4) {
+               /* Need to be approved by Menashe - so for now it's unsuppo=
rted. */
+               cl_dbg_chip_err(chip, "Unsupported wiring id [%u]\n", wirin=
g_id);
+               return -1;
+       }
+
+       _cl_fem_conf_gpio(chip,
+                         &lna_enable_gpio[wiring_id],
+                         &pa_enable_gpio[wiring_id],
+                         &rx_active_gpio[wiring_id]);
+
+       if (wiring_id =3D=3D FEM_WIRING_3_TCV0_2_ELASTIC_4_TCV1_2 ||
+           wiring_id =3D=3D FEM_WIRING_4_TCV0_2_ELASTIC_4_TCV1_2 ||
+           wiring_id =3D=3D FEM_WIRING_5_TCV0_2_ELASTIC_4_TCV1_2 ||
+           wiring_id =3D=3D FEM_WIRING_6_TCV0_2_ELASTIC_4_TCV1_2)
+               update_formation_1_band_select(chip);
+
+       return 0;
+}
+
+int cl_fem_set_system_mode(struct cl_hw *cl_hw, u8 fem_system_mode, u8 fem=
_ant)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+
+       if (fem_system_mode > FEM_MODE_MAX && fem_system_mode !=3D FEM_MODE=
_OPERETIONAL)
+               return -1;
+
+       cl_dbg_trace(cl_hw, "fem_system_mode: old value =3D %u -> new value=
 =3D %u\n",
+                    cl_hw->fem_system_mode, fem_system_mode);
+
+       if (fem_system_mode =3D=3D FEM_MODE_OPERETIONAL) {
+               cl_fem_conf_gpio(chip);
+               chip->lna_bypass_mode_set =3D 0;
+       } else if (!chip->lna_bypass_mode_set) {
+               cl_dbg_trace(cl_hw, "fem_system_mode: Set GPIO to LNA Bypas=
s Mode.\n");
+               set_lna_bypass_gpio(chip);
+               chip->lna_bypass_mode_set =3D 1;
+       }
+
+       cl_hw->fem_system_mode =3D fem_system_mode;
+       cl_hw->fem_ant =3D fem_ant;
+       return 0;
+}
+
+int cl_fem_update_conf_params(struct cl_chip *chip)
+{
+       u32 ricu_fem_conf_0, ricu_fem_conf_1 =3D 0;
+
+       if (cl_fem_read_lut(chip))
+               return -1;
+
+       if (cl_fem_check_lut_validity(chip, chip->fem.wiring_id))
+               return -1;
+
+       /* In case of invalid platform id, don't update FEM conf params*/
+       if (cl_fem_set_lut_off(chip))
+               return -1;
+
+       cl_fem_get_conf_params(chip, &ricu_fem_conf_0, &ricu_fem_conf_1);
+       ricu_fem_conf_0_set(chip, ricu_fem_conf_0);
+       ricu_fem_conf_1_set(chip, ricu_fem_conf_1);
+
+       if (cl_fem_conf_gpio(chip))
+               return -1;
+
+       cl_fem_set_registers(chip);
+
+       return 0;
+}
+
+static int cl_fem_write_wiring_id(struct cl_chip *chip, u8 wiring_id)
+{
+       if (wiring_id >=3D FEM_WIRING_MAX) {
+               cl_dbg_chip_err(chip, "wiring_id %u is not valid. [0..%u] a=
re valid values\n",
+                               wiring_id, (FEM_WIRING_MAX - 1));
+               return -1;
+       }
+
+       if (cl_fem_check_lut_validity(chip, wiring_id))
+               return -1;
+
+       /* Write wiring ID to eeprom */
+       if (cl_e2p_write(chip, &wiring_id, SIZE_FEM_WIRING_ID, ADDR_FEM_WIR=
ING_ID))
+               return -1;
+
+       chip->fem.wiring_id =3D wiring_id;
+       cl_dbg_chip_verbose(chip, "wiring_id is %u\n", chip->fem.wiring_id)=
;
+
+       return 0;
+}
+
+static void update_set_channel_fem(struct cl_chip *chip, struct cl_hw *cl_=
hw)
+{
+       if (cl_hw && cl_chip_is_tcv_enabled(chip, cl_hw->tcv_idx))
+               cl_msg_tx_set_channel(cl_hw, cl_hw->channel, cl_hw->bw, cl_=
hw->primary_freq,
+                                     cl_hw->center_freq);
+}
+
+int cl_fem_set_wiring_id(struct cl_chip *chip, u8 wiring_id)
+{
+       int ret =3D cl_fem_write_wiring_id(chip, wiring_id);
+
+       if (ret)
+               return ret;
+
+       ret =3D cl_fem_update_conf_params(chip);
+
+       if (ret) {
+               cl_dbg_chip_err(chip, "Error occurred while updating config=
uration parameters.\n");
+               return ret;
+       }
+
+       update_set_channel_fem(chip, chip->cl_hw_tcv0);
+       update_set_channel_fem(chip, chip->cl_hw_tcv1);
+
+       cl_dbg_chip_trace(chip, "wiring_id =3D %u\n", chip->fem.wiring_id);
+
+       return 0;
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

