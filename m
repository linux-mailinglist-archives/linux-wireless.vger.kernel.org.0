Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BBC3AB838
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhFQQFs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:48 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:15895
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231726AbhFQQFr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ot3OPrx5cRjhNFwsTqroMhMsWhifzmfmVa61Jjf+SV3S4mFbMJtrCuDK+4FIn1aF3D8WWQPB/CpBQYjj3gMvW2m00ByEMkBaD3TKBglaQs7TdshmXrd3B76gZ8ce6gsHyuFmmVslp70oE+WM+m5sWrCx65g0rIWjWjtlEvjGiecEDw4kQj0w2IHIHxwwySoBYW04Pt8J8RUWAC8R6ovgZHyJ99tqvuYupGVUdJNk7CpsUye7+Rw/5jO0tmr99DCcc4oIqPBMKGlNj737c+YwLIx+irdXEGmjR+icLeNQ5H/Bl1us50tt5uXuRNR29So4mGUO57NukiuzltAlhUfPdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxjKZNdHqEyNjcDPlZO/peiLpzcFM7CaiZnxtVXLtT4=;
 b=jGwGEguqdpqwKVl7Xj5G9U4Lg0e8rc6A8R9phhTb4z5I/sC7BP0C8QhSESY1+F2orMLi11ddHrb1O9Ki0VCXoK3r7j8nOwfCQMwArobJ+61Z5aezz0awZbqNtD+GKGUddSzM2p3VI8cR2BFxsL1aGXq/5WgzvyLAVrKYDVpvOV7q95hgmQ2oQYyzzsk//mpyMpp5RDXYQJGa9sn2c9qjzJSTjZVaZEA+7zH35aCz/TCywt1mgIoL3xg1s06D6edjJA5R/FsAcLLre30lViqBsFdw2AetzELkF9dkr2nGgPwepSZketAV6/DbyejzYgTsNlVPwtSXGLRqsyw+Otl2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxjKZNdHqEyNjcDPlZO/peiLpzcFM7CaiZnxtVXLtT4=;
 b=bb1T7f2SkQ36dts0S/pfTZMQ3IHiriAW5+Rhce/ttOkG1WUey9qG55FwEdQB75vaLIf12x+KXUQrg+3mGPzlaT+G7KzVvvIu+fXd15z0xWw2rxeZu3cp6iJlXHlQ3zGu6rBrB4BpvMPRmg2VC+/82pE9HrUSRmD75ETDj384MQI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0966.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Thu, 17 Jun
 2021 16:03:37 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:37 +0000
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
Subject: [RFC v1 030/256] cl8k: add cap.c
Date:   Thu, 17 Jun 2021 15:58:37 +0000
Message-Id: <20210617160223.160998-31-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfd45bd2-124e-4905-4e7d-08d931a96541
X-MS-TrafficTypeDiagnostic: AM9P192MB0966:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0966EEE93B039AA159CA0178F60E9@AM9P192MB0966.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8JG5NF5teuqUtOFcXzuqSXCDV4zV5KUtXqeOB1oOFq6p6XNjx2hRkMXWfwM8RNxESbgaDE7XtUi2eU/nSf6e5UZRAADUodOEuTj1KkBA7ugH4dAVX4vYiNaDTYbDEigq1MVD5SF64GJE8xRLx0bS2Azm4m+dG1QsNDx9wnacsk5EBrY8JNQsaD0l19FG/YWYcJE2tYLRf0ocL8qiHu3rmuRsuC6Q+wKdyIaoPEWBZd6B1bk4K5ApH2IcVJ2mHd+TR1aY/QKhq+wuWIqIpGljZjWWzmDqgZ4rsWDeOoM6u9j6A75XLMnulfqAl+xjaKgvRelJAJ6OsOn0Cg84mGhkZjrxAEm/elig+1YvRAXCurhlwMrCAHwEbKYlLRWyFmcnbZdbmM7lR2jZruBOx8bEgdH+fdX3XEz9XW5lINSbjnq5LsrZJ9DUHctw9tcntM3/4FchE6Pb8VE9vuApdDxGH3CsFuhEyG3p8q5ZHaXBmwbYx4ETnXBZdEJ1dO8wGgSwN0/4HgbLM7gpw2Z5Gx7IL5khwA6SReYM9VuJTqNypkihuAxWbzMVY2wFyc5gDUgdWZL+31HRlUBgZOKbFekBXt2O2cEFB3jAMs93WNClsLorBh07VZlhls0WLAtS85I6pX/oNg0TFKEGkv15Ta/a/eJgQnuI4ELH3ZH2k6he1CMoVeDf51OFtXs87yaPAqXgrVD4vwqc7reX+egk3vZfDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39850400004)(376002)(396003)(30864003)(4326008)(1076003)(2616005)(8676002)(186003)(6512007)(6486002)(107886003)(83380400001)(6916009)(38100700002)(55236004)(316002)(16526019)(6506007)(38350700002)(6666004)(54906003)(8936002)(26005)(508600001)(36756003)(2906002)(9686003)(52116002)(956004)(5660300002)(66946007)(66556008)(66476007)(86362001)(69590400013)(32563001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F8RL9GhuGDiv5ZA/JTO/Qc1AHOccf/kWH061aMqXIE18qqLS/KIgueN877uf?=
 =?us-ascii?Q?87bBqbJUjUhAvAOCdEYDEIPmNimpi3X8LrTpRiAwJZ+qEOZAegOT+5KuwzZS?=
 =?us-ascii?Q?dooGl9ufzTjqMfyTfz/rDGKIGpFI5m8hxN0dDc2jjJQ3NM87qEuTD3FXTxvt?=
 =?us-ascii?Q?JH/ouTSNtvtQHygBmSBvRv+XLcvVM4iLHWo5w0ltdILmq9ESSWJ4B9h3mkA6?=
 =?us-ascii?Q?LAFp7GjUOs7onSxoeZg8NA8LwKEbH+jHfmJ4+emiOTvZe3NseTpSWnbPhEq6?=
 =?us-ascii?Q?ah069/7h0zHzn9QaMvwwIAOToK9IEYEz/bBxytas24XTBa5hM95su0WZiRjq?=
 =?us-ascii?Q?qKnh07QYws1v95IA2kCP7c/0Y2D5ng3vLx694jYHC7aFkQG4vQ5d1B6qqO62?=
 =?us-ascii?Q?RTRWJDQtqYe1aeNPLyJ1c3XCbJCnsbjOp7h9kDBQUBXBQSmB1LDp3KbnAiTC?=
 =?us-ascii?Q?SC4aLozVzJIF7D0yMt802Nid/8VLuCj/+A2bMUqfXv+mDZvGYlhmxgcvIqfe?=
 =?us-ascii?Q?yF2YRQMxcXjymR68rNX6d/ze84D5jQ9pjjeZZTwkIueKyQ6dHpc/xapnB5gq?=
 =?us-ascii?Q?HiCcg49VbbHaLfrEXRj6HLkh/ilkSQm8Lm+2VNPOm9x0TTWsdXOzPc9bRx8L?=
 =?us-ascii?Q?VSNQPfCyLMb/uLkQslmrNPhgRaBg7LGFvj6RVw0KHlmKbbGmVFkN9yweDFFT?=
 =?us-ascii?Q?pdB4ArBpYPD1GAwnJo6EKXphbXGyaZOK1+U3dh9mHpMPf5OZkLk6Zbqx9PGW?=
 =?us-ascii?Q?BbcBX+AnjHRCGMDgm2yGyIj10TRvcMyYRvhsoJBc9F+1/DqQt7fP9hNuIbXG?=
 =?us-ascii?Q?/m5ryv3N8klRjMVWdkrk8Zmd+k15kCxBGL8kcJfN8CfDDsx1yFywNG04fIR3?=
 =?us-ascii?Q?t0kasO9zE6hKFbJkcNYwZrJuPGgTkjKOMXr9vndHuN1Wx8a+8gLY/1XQGeZK?=
 =?us-ascii?Q?8mDdVBV7x67GU8XECluc5c1vFYHeXsmVd/YStXrJzGQ9MHv+8tT/jVpLBxed?=
 =?us-ascii?Q?Ibjfj5BrPMaNdv4aM219N3s0jx7E3TNo7nKu2lBmYphtAS+2UJauTok89Cdh?=
 =?us-ascii?Q?yz1ysP/QS8SqvwS0qUtPk6ZG9XFohNz4S64PjvnJQii8CFw73QgKClFqqj/L?=
 =?us-ascii?Q?OirHdMu5MeBOEhiJiz2dpHkCPM//t93+LjYx+sZcftnlkzhJWwM1rSOhLU4X?=
 =?us-ascii?Q?nFvn56NYZFUm1RwWkQHCsBDs5c26kButBikpS4ff/Zzwrtc4ATW/DDVIent5?=
 =?us-ascii?Q?gMPQ6ndSY+PIgLMAkHh4SnLo8xy6I0RTpyyzCeZA/sOzlVnI/mDrUul9rnOB?=
 =?us-ascii?Q?mKYysZX0aVzXjR4IOIRh3EqY?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd45bd2-124e-4905-4e7d-08d931a96541
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:07.1780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkvuawmXGSCGAAf6AmRzhVttEjWgyobcaVB6RjyDYE+yQl7jEzXPGY+PrSWT1Yl1jKmXJORs7pnjHwwPh8RJvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0966
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/cap.c | 928 +++++++++++++++++++++++++
 1 file changed, 928 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/cap.c

diff --git a/drivers/net/wireless/celeno/cl8k/cap.c b/drivers/net/wireless/=
celeno/cl8k/cap.c
new file mode 100644
index 000000000000..bfd884706aa7
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/cap.c
@@ -0,0 +1,928 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "cap.h"
+#include "utils/utils.h"
+#include "debug.h"
+#include "band.h"
+#include "chan_info.h"
+#include "tx/tx.h"
+#include "sta.h"
+#include "rx/rx_amsdu.h"
+
+#define CL_HT_CAPABILITIES                                              \
+{                                                                       \
+       .ht_supported =3D true,                                           \
+       .cap =3D IEEE80211_HT_CAP_DSSSCCK40 | IEEE80211_HT_CAP_MAX_AMSDU, \
+       .ampdu_factor =3D IEEE80211_HT_MAX_AMPDU_64K,                     \
+       .ampdu_density =3D IEEE80211_HT_MPDU_DENSITY_1,                   \
+       .mcs =3D {                                                        \
+               .rx_mask =3D { 0xff, 0, 0, 0, 0, 0, 0, 0, 0, 0 },         \
+               .rx_highest =3D cpu_to_le16(65),                          \
+               .tx_params =3D IEEE80211_HT_MCS_TX_DEFINED,               \
+       },                                                              \
+}
+
+#define CL_VHT_CAPABILITIES                                             \
+{                                                                       \
+       .vht_supported =3D false,                                         \
+       .cap =3D                                                          \
+               IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE |               \
+               IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |               \
+               IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE |               \
+               IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE |               \
+               (3 << IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_SHIFT) |    \
+               (3 << IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT),          \
+       .vht_mcs =3D {                                                    \
+               .rx_mcs_map =3D cpu_to_le16(                              \
+                               IEEE80211_VHT_MCS_SUPPORT_0_7   << 0  | \
+                               IEEE80211_VHT_MCS_NOT_SUPPORTED << 2  | \
+                               IEEE80211_VHT_MCS_NOT_SUPPORTED << 4  | \
+                               IEEE80211_VHT_MCS_NOT_SUPPORTED << 6  | \
+                               IEEE80211_VHT_MCS_NOT_SUPPORTED << 8  | \
+                               IEEE80211_VHT_MCS_NOT_SUPPORTED << 10 | \
+                               IEEE80211_VHT_MCS_NOT_SUPPORTED << 12 | \
+                               IEEE80211_VHT_MCS_NOT_SUPPORTED << 14), \
+               .tx_mcs_map =3D cpu_to_le16(                              \
+                               IEEE80211_VHT_MCS_SUPPORT_0_7   << 0  | \
+                               IEEE80211_VHT_MCS_NOT_SUPPORTED << 2  | \
+                               IEEE80211_VHT_MCS_NOT_SUPPORTED << 4  | \
+                               IEEE80211_VHT_MCS_NOT_SUPPORTED << 6  | \
+                               IEEE80211_VHT_MCS_NOT_SUPPORTED << 8  | \
+                               IEEE80211_VHT_MCS_NOT_SUPPORTED << 10 | \
+                               IEEE80211_VHT_MCS_NOT_SUPPORTED << 12 | \
+                               IEEE80211_VHT_MCS_NOT_SUPPORTED << 14), \
+       }                                                               \
+}
+
+#define CL_HE_CAP_ELEM_STATION                                            =
           \
+{                                                                         =
           \
+       .mac_cap_info[0] =3D IEEE80211_HE_MAC_CAP0_HTC_HE,                 =
            \
+       .mac_cap_info[1] =3D 0,                                            =
            \
+       .mac_cap_info[2] =3D 0,                                            =
            \
+       .mac_cap_info[3] =3D IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_2,=
            \
+       .mac_cap_info[4] =3D IEEE80211_HE_MAC_CAP4_BQR,                    =
            \
+       .mac_cap_info[5] =3D IEEE80211_HE_MAC_CAP5_HT_VHT_TRIG_FRAME_RX,   =
            \
+       .phy_cap_info[0] =3D IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAP=
PING_IN_2G, \
+       .phy_cap_info[1] =3D IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A,         =
            \
+       .phy_cap_info[2] =3D 0,                                            =
            \
+       .phy_cap_info[3] =3D 0,                                            =
            \
+       .phy_cap_info[4] =3D 0,                                            =
            \
+       .phy_cap_info[5] =3D 0,                                            =
            \
+       .phy_cap_info[6] =3D 0,                                            =
            \
+       .phy_cap_info[7] =3D 0,                                            =
            \
+       .phy_cap_info[8] =3D IEEE80211_HE_PHY_CAP8_20MHZ_IN_40MHZ_HE_PPDU_I=
N_2G,       \
+       .phy_cap_info[9] =3D IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_16US=
,           \
+       .phy_cap_info[10] =3D 0,                                           =
            \
+}
+
+#define CL_HE_CAP_ELEM_AP                                                 =
      \
+{                                                                         =
      \
+       .mac_cap_info[0] =3D IEEE80211_HE_MAC_CAP0_HTC_HE,                 =
       \
+       .mac_cap_info[1] =3D 0,                                            =
       \
+       .mac_cap_info[2] =3D 0,                                            =
       \
+       .mac_cap_info[3] =3D IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_2,=
       \
+       .mac_cap_info[4] =3D IEEE80211_HE_MAC_CAP4_BQR,                    =
       \
+       .mac_cap_info[5] =3D 0,                                            =
       \
+       .phy_cap_info[0] =3D 0,                                            =
       \
+       .phy_cap_info[1] =3D IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A,         =
       \
+       .phy_cap_info[2] =3D 0,                                            =
       \
+       .phy_cap_info[3] =3D 0,                                            =
       \
+       .phy_cap_info[4] =3D 0,                                            =
       \
+       .phy_cap_info[5] =3D 0,                                            =
       \
+       .phy_cap_info[6] =3D 0,                                            =
       \
+       .phy_cap_info[7] =3D 0,                                            =
       \
+       .phy_cap_info[8] =3D 0,                                            =
       \
+       .phy_cap_info[9] =3D IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_16US=
,      \
+       .phy_cap_info[10] =3D 0,                                           =
       \
+}
+
+#define CL_HE_CAP_ELEM_MESH_POINT                                         =
      \
+{                                                                         =
      \
+       .mac_cap_info[0] =3D IEEE80211_HE_MAC_CAP0_HTC_HE,                 =
       \
+       .mac_cap_info[1] =3D 0,                                            =
       \
+       .mac_cap_info[2] =3D 0,                                            =
       \
+       .mac_cap_info[3] =3D IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_2,=
       \
+       .mac_cap_info[4] =3D IEEE80211_HE_MAC_CAP4_BQR,                    =
       \
+       .mac_cap_info[5] =3D 0,                                            =
       \
+       .phy_cap_info[0] =3D 0,                                            =
       \
+       .phy_cap_info[1] =3D IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A,         =
       \
+       .phy_cap_info[2] =3D 0,                                            =
       \
+       .phy_cap_info[3] =3D 0,                                            =
       \
+       .phy_cap_info[4] =3D 0,                                            =
       \
+       .phy_cap_info[5] =3D 0,                                            =
       \
+       .phy_cap_info[6] =3D 0,                                            =
       \
+       .phy_cap_info[7] =3D 0,                                            =
       \
+       .phy_cap_info[8] =3D 0,                                            =
       \
+       .phy_cap_info[9] =3D IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_16US=
,      \
+       .phy_cap_info[10] =3D 0,                                           =
       \
+}
+
+#define CL_HE_MCS_NSS_SUPP                   \
+{                                            \
+       .rx_mcs_80 =3D cpu_to_le16(0xff00),    \
+       .tx_mcs_80 =3D cpu_to_le16(0xff00),    \
+       .rx_mcs_160 =3D cpu_to_le16(0xff00),   \
+       .tx_mcs_160 =3D cpu_to_le16(0xff00),   \
+       .rx_mcs_80p80 =3D cpu_to_le16(0xffff), \
+       .tx_mcs_80p80 =3D cpu_to_le16(0xffff), \
+}
+
+#define RATE(_bitrate, _hw_rate, _flags) { \
+       .bitrate =3D (_bitrate),             \
+       .flags =3D (_flags),                 \
+       .hw_value =3D (_hw_rate),            \
+}
+
+#define CHAN(_freq, _idx) {     \
+       .center_freq =3D (_freq), \
+       .hw_value =3D (_idx),     \
+       .max_power =3D 18,        \
+}
+
+#define CHANF(_freq, _idx, _flags) { \
+       .center_freq =3D (_freq),      \
+       .hw_value =3D (_idx),          \
+       .flags =3D (_flags),           \
+       .max_power =3D 18,             \
+}
+
+static struct ieee80211_sband_iftype_data cl_he_data[] =3D {
+       {
+               .types_mask =3D BIT(NL80211_IFTYPE_STATION),
+               .he_cap =3D {
+                       .has_he =3D true,
+                       .he_cap_elem =3D CL_HE_CAP_ELEM_STATION,
+                       .he_mcs_nss_supp =3D CL_HE_MCS_NSS_SUPP,
+               },
+       },
+       {
+               .types_mask =3D BIT(NL80211_IFTYPE_AP),
+               .he_cap =3D {
+                       .has_he =3D true,
+                       .he_cap_elem =3D CL_HE_CAP_ELEM_AP,
+                       .he_mcs_nss_supp =3D CL_HE_MCS_NSS_SUPP,
+               },
+       },
+       {
+               .types_mask =3D BIT(NL80211_IFTYPE_MESH_POINT),
+               .he_cap =3D {
+                       .has_he =3D true,
+                       .he_cap_elem =3D CL_HE_CAP_ELEM_MESH_POINT,
+                       .he_mcs_nss_supp =3D CL_HE_MCS_NSS_SUPP,
+               },
+       },
+};
+
+static struct ieee80211_rate cl_ratetable[] =3D {
+       RATE(10,  0x00, 0),
+       RATE(20,  0x01, IEEE80211_RATE_SHORT_PREAMBLE),
+       RATE(55,  0x02, IEEE80211_RATE_SHORT_PREAMBLE),
+       RATE(110, 0x03, IEEE80211_RATE_SHORT_PREAMBLE),
+       RATE(60,  0x04, 0),
+       RATE(90,  0x05, 0),
+       RATE(120, 0x06, 0),
+       RATE(180, 0x07, 0),
+       RATE(240, 0x08, 0),
+       RATE(360, 0x09, 0),
+       RATE(480, 0x0A, 0),
+       RATE(540, 0x0B, 0),
+};
+
+/* The channels indexes here are not used anymore */
+static struct ieee80211_channel cl_2ghz_channels[] =3D {
+       CHAN(2412, 0),
+       CHAN(2417, 1),
+       CHAN(2422, 2),
+       CHAN(2427, 3),
+       CHAN(2432, 4),
+       CHAN(2437, 5),
+       CHAN(2442, 6),
+       CHAN(2447, 7),
+       CHAN(2452, 8),
+       CHAN(2457, 9),
+       CHAN(2462, 10),
+       CHAN(2467, 11),
+       CHAN(2472, 12),
+       CHAN(2484, 13),
+};
+
+static struct ieee80211_channel cl_5ghz_channels[] =3D {
+       CHAN(5180, 0),  /* 36 -  20MHz */
+       CHAN(5200, 1),  /* 40 -  20MHz */
+       CHAN(5220, 2),  /* 44 -  20MHz */
+       CHAN(5240, 3),  /* 48 -  20MHz */
+
+       CHANF(5260, 4,  IEEE80211_CHAN_RADAR),  /* 52 -  20MHz */
+       CHANF(5280, 5,  IEEE80211_CHAN_RADAR),  /* 56 -  20MHz */
+       CHANF(5300, 6,  IEEE80211_CHAN_RADAR),  /* 60 -  20MHz */
+       CHANF(5320, 7,  IEEE80211_CHAN_RADAR),  /* 64 -  20MHz */
+       CHANF(5500, 8,  IEEE80211_CHAN_RADAR),  /* 100 - 20MHz */
+       CHANF(5520, 9,  IEEE80211_CHAN_RADAR),  /* 104 - 20MHz */
+       CHANF(5540, 10, IEEE80211_CHAN_RADAR), /* 108 - 20MHz */
+       CHANF(5560, 11, IEEE80211_CHAN_RADAR), /* 112 - 20MHz */
+       CHANF(5580, 12, IEEE80211_CHAN_RADAR), /* 116 - 20MHz */
+       CHANF(5600, 13, IEEE80211_CHAN_RADAR), /* 120 - 20MHz */
+       CHANF(5620, 14, IEEE80211_CHAN_RADAR), /* 124 - 20MHz */
+       CHANF(5640, 15, IEEE80211_CHAN_RADAR), /* 128 - 20MHz */
+       CHANF(5660, 16, IEEE80211_CHAN_RADAR), /* 132 - 20MHz */
+       CHANF(5680, 17, IEEE80211_CHAN_RADAR), /* 136 - 20MHz */
+       CHANF(5700, 18, IEEE80211_CHAN_RADAR), /* 140 - 20MHz */
+
+       CHAN(5720, 19), /* 144 - 20MHz */
+       CHAN(5745, 20), /* 149 - 20MHz */
+       CHAN(5765, 21), /* 153 - 20MHz */
+       CHAN(5785, 22), /* 157 - 20MHz */
+       CHAN(5805, 23), /* 161 - 20MHz */
+       CHAN(5825, 24), /* 165 - 20MHz */
+};
+
+static struct ieee80211_channel cl_6ghz_channels[] =3D {
+       CHAN(5955, 1),  /* 1 - 20MHz */
+       CHAN(5935, 2),  /* 2 - 20MHz */
+       CHAN(5975, 5),  /* 5 - 20MHz */
+       CHAN(5995, 9),  /* 9 - 20MHz */
+       CHAN(6015, 13),  /* 13 - 20MHz */
+       CHAN(6035, 17),  /* 17 - 20MHz */
+       CHAN(6055, 21),  /* 21 - 20MHz */
+       CHAN(6075, 25),  /* 25 - 20MHz */
+       CHAN(6095, 29),  /* 29 - 20MHz */
+       CHAN(6115, 33),  /* 33 - 20MHz */
+       CHAN(6135, 37),  /* 37 - 20MHz */
+       CHAN(6155, 41),  /* 41 - 20MHz */
+       CHAN(6175, 45),  /* 45 - 20MHz */
+       CHAN(6195, 49),  /* 49 - 20MHz */
+       CHAN(6215, 53),  /* 53 - 20MHz */
+       CHAN(6235, 57),  /* 57 - 20MHz */
+       CHAN(6255, 61),  /* 61 - 20MHz */
+       CHAN(6275, 65),  /* 65 - 20MHz */
+       CHAN(6295, 69),  /* 69 - 20MHz */
+       CHAN(6315, 73),  /* 73 - 20MHz */
+       CHAN(6335, 77),  /* 77 - 20MHz */
+       CHAN(6355, 81),  /* 81 - 20MHz */
+       CHAN(6375, 85),  /* 85 - 20MHz */
+       CHAN(6395, 89),  /* 89 - 20MHz */
+       CHAN(6415, 93),  /* 93 - 20MHz */
+       CHAN(6435, 97),  /* 97 - 20MHz */
+       CHAN(6455, 101),  /* 101 - 20MHz */
+       CHAN(6475, 105),  /* 105 - 20MHz */
+       CHAN(6495, 109),  /* 109 - 20MHz */
+       CHAN(6515, 113),  /* 113 - 20MHz */
+       CHAN(6535, 117),  /* 117 - 20MHz */
+       CHAN(6555, 121),  /* 121 - 20MHz */
+       CHAN(6575, 125),  /* 125 - 20MHz */
+       CHAN(6595, 129),  /* 129 - 20MHz */
+       CHAN(6615, 133),  /* 133 - 20MHz */
+       CHAN(6635, 137),  /* 137 - 20MHz */
+       CHAN(6655, 141),  /* 141 - 20MHz */
+       CHAN(6675, 145),  /* 145 - 20MHz */
+       CHAN(6695, 149),  /* 149 - 20MHz */
+       CHAN(6715, 153),  /* 153 - 20MHz */
+       CHAN(6735, 157),  /* 157 - 20MHz */
+       CHAN(6755, 161),  /* 161 - 20MHz */
+       CHAN(6775, 165),  /* 165 - 20MHz */
+       CHAN(6795, 169),  /* 169 - 20MHz */
+       CHAN(6815, 173),  /* 173 - 20MHz */
+       CHAN(6835, 177),  /* 177 - 20MHz */
+       CHAN(6855, 181),  /* 181 - 20MHz */
+       CHAN(6875, 188),  /* 185 - 20MHz */
+       CHAN(6895, 189),  /* 189 - 20MHz */
+       CHAN(6915, 193),  /* 193 - 20MHz */
+       CHAN(6935, 197),  /* 197 - 20MHz */
+       CHAN(6955, 201),  /* 201 - 20MHz */
+       CHAN(6975, 205),  /* 205 - 20MHz */
+       CHAN(6995, 209),  /* 209 - 20MHz */
+       CHAN(7015, 213),  /* 213 - 20MHz */
+       CHAN(7035, 217),  /* 217 - 20MHz */
+       CHAN(7055, 221),  /* 221 - 20MHz */
+       CHAN(7075, 225),  /* 225 - 20MHz */
+       CHAN(7095, 229),  /* 229 - 20MHz */
+       CHAN(7115, 233),  /* 233 - 20MHz */
+};
+
+static struct ieee80211_supported_band cl_band_2ghz =3D {
+       .channels   =3D cl_2ghz_channels,
+       .n_channels =3D ARRAY_SIZE(cl_2ghz_channels),
+       .bitrates   =3D cl_ratetable,
+       .n_bitrates =3D ARRAY_SIZE(cl_ratetable),
+       .ht_cap     =3D CL_HT_CAPABILITIES,
+       .vht_cap    =3D CL_VHT_CAPABILITIES,
+};
+
+static struct ieee80211_supported_band cl_band_5ghz =3D {
+       .channels   =3D cl_5ghz_channels,
+       .n_channels =3D ARRAY_SIZE(cl_5ghz_channels),
+       .bitrates   =3D &cl_ratetable[4],
+       .n_bitrates =3D ARRAY_SIZE(cl_ratetable) - 4,
+       .ht_cap     =3D CL_HT_CAPABILITIES,
+       .vht_cap    =3D CL_VHT_CAPABILITIES,
+};
+
+static struct ieee80211_supported_band cl_band_6ghz =3D {
+       .channels   =3D cl_6ghz_channels,
+       .n_channels =3D ARRAY_SIZE(cl_6ghz_channels),
+       .bitrates   =3D &cl_ratetable[4],
+       .n_bitrates =3D ARRAY_SIZE(cl_ratetable) - 4,
+};
+
+static const struct ieee80211_iface_limit cl_limits[] =3D {
+       {
+               .max   =3D MAX_BSS_NUM,
+               .types =3D BIT(NL80211_IFTYPE_AP) |
+                        BIT(NL80211_IFTYPE_STATION) |
+                        BIT(NL80211_IFTYPE_MESH_POINT),
+       },
+};
+
+static const u8 cl_if_types_ext_capa_ap[] =3D {
+       [0]  =3D WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING,
+       [7]  =3D WLAN_EXT_CAPA8_OPMODE_NOTIF,
+       [10] =3D WLAN_EXT_CAPA11_COMPLETE_LIST_OF_NONTXBSSID_PROFILES,
+};
+
+static const struct wiphy_iftype_ext_capab cl_iftypes_ext_capa[] =3D {
+       {
+               .iftype =3D NL80211_IFTYPE_AP,
+               .extended_capabilities =3D cl_if_types_ext_capa_ap,
+               .extended_capabilities_mask =3D cl_if_types_ext_capa_ap,
+               .extended_capabilities_len =3D sizeof(cl_if_types_ext_capa_=
ap),
+       },
+};
+
+static const struct ieee80211_iface_combination cl_combinations[] =3D {
+       {
+               .limits =3D cl_limits,
+               .n_limits =3D ARRAY_SIZE(cl_limits),
+               .num_different_channels =3D 1,
+               .max_interfaces =3D MAX_BSS_NUM,
+               .beacon_int_min_gcd =3D 100,
+               .radar_detect_widths =3D BIT(NL80211_CHAN_WIDTH_20) |
+                                      BIT(NL80211_CHAN_WIDTH_40) |
+                                      BIT(NL80211_CHAN_WIDTH_80) |
+                                      BIT(NL80211_CHAN_WIDTH_160),
+       }
+};
+
+static u8 he_mcs_supp_tx(struct cl_hw *cl_hw, u8 nss)
+{
+       u8 mcs =3D cl_hw->conf->ce_he_mcs_nss_supp_tx[nss];
+
+       switch (mcs) {
+       case WRS_MCS_7:
+               return IEEE80211_HE_MCS_SUPPORT_0_7;
+       case WRS_MCS_9:
+               return IEEE80211_HE_MCS_SUPPORT_0_9;
+       case WRS_MCS_11:
+               return IEEE80211_HE_MCS_SUPPORT_0_11;
+       }
+
+       cl_dbg_err(cl_hw, "Invalid mcs %u for nss %u. Must be 7, 9 or 11!\n=
", mcs, nss);
+       return IEEE80211_HE_MCS_NOT_SUPPORTED;
+}
+
+static u8 he_mcs_supp_rx(struct cl_hw *cl_hw, u8 nss)
+{
+       u8 mcs =3D cl_hw->conf->ce_he_mcs_nss_supp_rx[nss];
+
+       switch (mcs) {
+       case WRS_MCS_7:
+               return IEEE80211_HE_MCS_SUPPORT_0_7;
+       case WRS_MCS_9:
+               return IEEE80211_HE_MCS_SUPPORT_0_9;
+       case WRS_MCS_11:
+               return IEEE80211_HE_MCS_SUPPORT_0_11;
+       }
+
+       cl_dbg_err(cl_hw, "Invalid mcs %u for nss %u. Must be 7, 9 or 11!\n=
", mcs, nss);
+       return IEEE80211_HE_MCS_NOT_SUPPORTED;
+}
+
+static u8 vht_mcs_supp_tx(struct cl_hw *cl_hw, u8 nss)
+{
+       u8 mcs =3D cl_hw->conf->ce_vht_mcs_nss_supp_tx[nss];
+
+       switch (mcs) {
+       case WRS_MCS_7:
+               return IEEE80211_VHT_MCS_SUPPORT_0_7;
+       case WRS_MCS_8:
+               return IEEE80211_VHT_MCS_SUPPORT_0_8;
+       case WRS_MCS_9:
+               return IEEE80211_VHT_MCS_SUPPORT_0_9;
+       }
+
+       cl_dbg_err(cl_hw, "Invalid mcs %u for nss %u. Must be 7-9!\n", mcs,=
 nss);
+       return IEEE80211_VHT_MCS_NOT_SUPPORTED;
+}
+
+static u8 vht_mcs_supp_rx(struct cl_hw *cl_hw, u8 nss)
+{
+       u8 mcs =3D cl_hw->conf->ce_vht_mcs_nss_supp_rx[nss];
+
+       switch (mcs) {
+       case WRS_MCS_7:
+               return IEEE80211_VHT_MCS_SUPPORT_0_7;
+       case WRS_MCS_8:
+               return IEEE80211_VHT_MCS_SUPPORT_0_8;
+       case WRS_MCS_9:
+               return IEEE80211_VHT_MCS_SUPPORT_0_9;
+       }
+
+       cl_dbg_err(cl_hw, "Invalid mcs %u for nss %u. Must be 7-9!\n", mcs,=
 nss);
+       return IEEE80211_VHT_MCS_NOT_SUPPORTED;
+}
+
+static void cl_set_he_6ghz_capab(struct cl_hw *cl_hw)
+{
+       struct ieee80211_he_6ghz_capa *he_6ghz_cap0 =3D &cl_hw->iftype_data=
[0].he_6ghz_capa;
+       struct ieee80211_he_6ghz_capa *he_6ghz_cap1 =3D &cl_hw->iftype_data=
[1].he_6ghz_capa;
+       struct ieee80211_he_6ghz_capa *he_6ghz_cap2 =3D &cl_hw->iftype_data=
[2].he_6ghz_capa;
+
+       he_6ghz_cap0->capa =3D cpu_to_le16(IEEE80211_HT_MPDU_DENSITY_1);
+       he_6ghz_cap0->capa |=3D
+               cpu_to_le16(cl_hw->conf->ha_max_mpdu_len << HE_6GHZ_CAP_MAX=
_MPDU_LEN_OFFSET);
+       he_6ghz_cap0->capa |=3D
+               cpu_to_le16(IEEE80211_VHT_MAX_AMPDU_1024K << HE_6GHZ_CAP_MA=
X_AMPDU_LEN_EXP_OFFSET);
+
+       he_6ghz_cap1->capa =3D he_6ghz_cap0->capa;
+       he_6ghz_cap2->capa =3D he_6ghz_cap0->capa;
+}
+
+static void _cl_set_he_capab(struct cl_hw *cl_hw, u8 idx)
+{
+       struct ieee80211_sta_he_cap *he_cap =3D &cl_hw->iftype_data[idx].he=
_cap;
+       struct ieee80211_he_mcs_nss_supp *he_mcs_nss_supp =3D &he_cap->he_m=
cs_nss_supp;
+       struct ieee80211_he_cap_elem *he_cap_elem =3D &he_cap->he_cap_elem;
+       u8 rx_nss =3D cl_hw->conf->ce_rx_nss;
+       u8 tx_nss =3D cl_hw->conf->ce_tx_nss;
+       int i =3D 0;
+
+       if (BAND_IS_5G_6G(cl_hw)) {
+               he_cap_elem->phy_cap_info[0] |=3D
+                       IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5=
G;
+
+               for (i =3D 0; i < rx_nss; i++)
+                       he_mcs_nss_supp->rx_mcs_160 |=3D
+                               cpu_to_le16(he_mcs_supp_rx(cl_hw, i) << (i =
* 2));
+
+               for (i =3D 0; i < tx_nss; i++)
+                       he_mcs_nss_supp->tx_mcs_160 |=3D
+                               cpu_to_le16(he_mcs_supp_tx(cl_hw, i) << (i =
* 2));
+
+               he_cap_elem->phy_cap_info[0] |=3D
+                       IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ=
_IN_5G;
+
+               for (i =3D 0; i < rx_nss; i++)
+                       he_mcs_nss_supp->rx_mcs_80 |=3D
+                               cpu_to_le16(he_mcs_supp_rx(cl_hw, i) << (i =
* 2));
+
+               for (i =3D 0; i < tx_nss; i++)
+                       he_mcs_nss_supp->tx_mcs_80 |=3D
+                               cpu_to_le16(he_mcs_supp_tx(cl_hw, i) << (i =
* 2));
+       } else {
+               he_cap_elem->phy_cap_info[0] |=3D
+                       IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G=
;
+
+               for (i =3D 0; i < rx_nss; i++)
+                       he_mcs_nss_supp->rx_mcs_80 |=3D
+                               cpu_to_le16(he_mcs_supp_rx(cl_hw, i) << (i =
* 2));
+
+               for (i =3D 0; i < tx_nss; i++)
+                       he_mcs_nss_supp->tx_mcs_80 |=3D
+                               cpu_to_le16(he_mcs_supp_tx(cl_hw, i) << (i =
* 2));
+       }
+
+       for (i =3D rx_nss; i < 8; i++) {
+               he_mcs_nss_supp->rx_mcs_80 |=3D
+                       cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << (i * =
2));
+               he_mcs_nss_supp->rx_mcs_160 |=3D
+                       cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << (i * =
2));
+       }
+
+       for (i =3D tx_nss; i < 8; i++) {
+               he_mcs_nss_supp->tx_mcs_80 |=3D
+                       cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << (i * =
2));
+               he_mcs_nss_supp->tx_mcs_160 |=3D
+                       cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << (i * =
2));
+       }
+
+       if (cl_hw->conf->ce_he_rxldpc_en)
+               he_cap_elem->phy_cap_info[1] |=3D
+                       IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD;
+
+       if (cl_hw->conf->ci_rx_he_mu_ppdu)
+               he_cap_elem->phy_cap_info[3] |=3D
+                       IEEE80211_HE_PHY_CAP3_RX_PARTIAL_BW_SU_IN_20MHZ_MU;
+
+       he_cap_elem->phy_cap_info[3] |=3D
+               IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER;
+       he_cap_elem->phy_cap_info[5] |=3D
+               IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_4;
+}
+
+static void cl_set_he_capab(struct cl_hw *cl_hw)
+{
+       struct ieee80211_sta_he_cap *he_cap0 =3D &cl_hw->iftype_data[0].he_=
cap;
+       struct ieee80211_sta_he_cap *he_cap1 =3D &cl_hw->iftype_data[1].he_=
cap;
+       struct ieee80211_he_cap_elem *he_cap_elem0 =3D &he_cap0->he_cap_ele=
m;
+       struct ieee80211_he_cap_elem *he_cap_elem1 =3D &he_cap1->he_cap_ele=
m;
+
+       struct cl_tcv_conf *conf =3D cl_hw->conf;
+       u8 tf_mac_pad_dur =3D conf->ci_tf_mac_pad_dur;
+
+       memcpy(&cl_hw->iftype_data, cl_he_data, sizeof(cl_hw->iftype_data))=
;
+
+       /* TWT support */
+       if (conf->ce_twt_en) {
+               /* STA mode */
+               he_cap_elem0->mac_cap_info[0] |=3D IEEE80211_HE_MAC_CAP0_TW=
T_REQ;
+               /* AP mode */
+               he_cap_elem1->mac_cap_info[0] |=3D IEEE80211_HE_MAC_CAP0_TW=
T_RES;
+       }
+
+       /* OMI support */
+       if (conf->ce_omi_en) {
+               /* STA mode */
+               he_cap_elem0->mac_cap_info[3] |=3D IEEE80211_HE_MAC_CAP3_OM=
I_CONTROL;
+               /* AP mode */
+               he_cap_elem1->mac_cap_info[3] |=3D IEEE80211_HE_MAC_CAP3_OM=
I_CONTROL;
+               he_cap_elem1->mac_cap_info[5] |=3D IEEE80211_HE_MAC_CAP5_OM=
_CTRL_UL_MU_DATA_DIS_RX;
+       }
+
+       if (tf_mac_pad_dur =3D=3D 1)
+               he_cap_elem0->mac_cap_info[1] |=3D IEEE80211_HE_MAC_CAP1_TF=
_MAC_PAD_DUR_8US;
+       else if (tf_mac_pad_dur =3D=3D 2)
+               he_cap_elem0->mac_cap_info[1] |=3D IEEE80211_HE_MAC_CAP1_TF=
_MAC_PAD_DUR_16US;
+
+       _cl_set_he_capab(cl_hw, 0);
+       _cl_set_he_capab(cl_hw, 1);
+       _cl_set_he_capab(cl_hw, 2);
+
+       if (cl_band_is_6g(cl_hw))
+               cl_set_he_6ghz_capab(cl_hw);
+
+       cl_hw->sband.n_iftype_data =3D ARRAY_SIZE(cl_he_data);
+       cl_hw->sband.iftype_data =3D cl_hw->iftype_data;
+}
+
+void cl_cap_dyn_params(struct cl_hw *cl_hw)
+{
+       struct ieee80211_hw *hw =3D cl_hw->hw;
+       struct wiphy *wiphy =3D hw->wiphy;
+       struct cl_tcv_conf *conf =3D cl_hw->conf;
+       u8 rx_nss =3D conf->ce_rx_nss;
+       u8 tx_nss =3D conf->ce_tx_nss;
+       u8 guard_interval =3D conf->ha_short_guard_interval;
+       u8 i;
+       u8 bw =3D cl_hw->conf->ce_channel_bandwidth;
+       struct ieee80211_supported_band *sband =3D &cl_hw->sband;
+       struct ieee80211_sta_ht_cap *sband_ht_cap =3D &sband->ht_cap;
+       struct ieee80211_sta_vht_cap *sband_vht_cap =3D &sband->vht_cap;
+
+       if (cl_band_is_6g(cl_hw)) {
+               memcpy(sband, &cl_band_6ghz, sizeof(struct ieee80211_suppor=
ted_band));
+       } else if (cl_band_is_5g(cl_hw)) {
+               memcpy(sband, &cl_band_5ghz, sizeof(struct ieee80211_suppor=
ted_band));
+               if (!conf->ci_ieee80211h) {
+                       int i;
+
+                       for (i =3D 0; i < sband->n_channels; i++)
+                               sband->channels[i].flags &=3D ~IEEE80211_CH=
AN_RADAR;
+               }
+       } else {
+               memcpy(sband, &cl_band_2ghz, sizeof(struct ieee80211_suppor=
ted_band));
+
+               if (!conf->ci_vht_cap_24g)
+                       memset(&sband->vht_cap, 0, sizeof(struct ieee80211_=
sta_vht_cap));
+       }
+
+       /* 6GHz doesn't support HT/VHT */
+       if (!cl_band_is_6g(cl_hw)) {
+               if (bw > CHNL_BW_20)
+                       sband_ht_cap->cap |=3D IEEE80211_HT_CAP_SUP_WIDTH_2=
0_40;
+
+               /* Guard_interval */
+               if (guard_interval) {
+                       sband_ht_cap->cap |=3D IEEE80211_HT_CAP_SGI_20;
+
+                       if (bw >=3D CHNL_BW_40)
+                               sband_ht_cap->cap |=3D IEEE80211_HT_CAP_SGI=
_40;
+
+                       if (bw >=3D CHNL_BW_80)
+                               sband_vht_cap->cap |=3D IEEE80211_VHT_CAP_S=
HORT_GI_80;
+
+                       if (bw =3D=3D CHNL_BW_160)
+                               sband_vht_cap->cap |=3D IEEE80211_VHT_CAP_S=
HORT_GI_160;
+               }
+       }
+
+       /* Amsdu */
+       cl_rx_amsdu_hw_en(hw, conf->ce_rxamsdu_en);
+       cl_hw->txamsdu_en =3D conf->ce_txamsdu_en;
+
+       /* Hw flags */
+       ieee80211_hw_set(hw, HOST_BROADCAST_PS_BUFFERING);
+       ieee80211_hw_set(hw, SIGNAL_DBM);
+       ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
+       ieee80211_hw_set(hw, QUEUE_CONTROL);
+       ieee80211_hw_set(hw, WANT_MONITOR_VIF);
+       ieee80211_hw_set(hw, SPECTRUM_MGMT);
+       ieee80211_hw_set(hw, SUPPORTS_HT_CCK_RATES);
+       ieee80211_hw_set(hw, HAS_RATE_CONTROL);
+       ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
+       ieee80211_hw_set(hw, NO_AUTO_VIF);
+
+       wiphy->features |=3D NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE;
+
+       /* Turn on "20/40 Coex Mgmt Support" bit (24g only) */
+       if (cl_band_is_24g(cl_hw)) {
+               struct ieee80211_local *local =3D hw_to_local(hw);
+
+               if (conf->ce_coex_en)
+                       local->ext_capa[0] |=3D WLAN_EXT_CAPA1_2040_BSS_COE=
X_MGMT_ENABLED;
+               else
+                       wiphy->features &=3D ~NL80211_FEATURE_AP_MODE_CHAN_=
WIDTH_CHANGE;
+       }
+
+       if (conf->ci_fast_rx_en) {
+               ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
+               ieee80211_hw_set(hw, AP_LINK_PS);
+       }
+
+       /*
+        * To disable the dynamic PS we say to the stack that we support it=
 in
+        * HW. This will force mac80211 rely on us to handle this.
+        */
+       ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
+
+       if (conf->ci_agg_tx)
+               ieee80211_hw_set(hw, AMPDU_AGGREGATION);
+
+       if (conf->ci_ieee80211w)
+               ieee80211_hw_set(hw, MFP_CAPABLE);
+
+       wiphy->interface_modes =3D BIT(NL80211_IFTYPE_STATION) |
+                                BIT(NL80211_IFTYPE_AP) |
+                                BIT(NL80211_IFTYPE_MESH_POINT);
+
+       wiphy->flags |=3D WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL |
+                       WIPHY_FLAG_HAS_CHANNEL_SWITCH;
+
+       if (conf->ce_uapsd_en)
+               wiphy->flags |=3D WIPHY_FLAG_AP_UAPSD;
+
+       wiphy->iface_combinations =3D cl_combinations;
+       wiphy->n_iface_combinations =3D ARRAY_SIZE(cl_combinations);
+
+       hw->max_rates =3D IEEE80211_TX_MAX_RATES;
+       hw->max_report_rates =3D IEEE80211_TX_MAX_RATES;
+       hw->max_rate_tries =3D 1;
+
+       hw->max_tx_aggregation_subframes =3D conf->ce_max_agg_size_tx;
+       hw->max_rx_aggregation_subframes =3D conf->ce_max_agg_size_rx;
+
+       hw->vif_data_size =3D sizeof(struct cl_vif);
+       hw->sta_data_size =3D sizeof(struct cl_sta);
+
+       hw->extra_tx_headroom =3D 0;
+       hw->queues =3D IEEE80211_MAX_QUEUES;
+       hw->offchannel_tx_hw_queue =3D CL_HWQ_VO;
+
+       if (!cl_band_is_6g(cl_hw)) {
+               if (conf->ce_ht_rxldpc_en)
+                       sband_ht_cap->cap |=3D IEEE80211_HT_CAP_LDPC_CODING=
;
+
+               sband_ht_cap->cap |=3D IEEE80211_HT_CAP_MAX_AMSDU;
+               sband_vht_cap->cap |=3D cl_hw->conf->ha_max_mpdu_len;
+       }
+
+       if (cl_band_is_5g(cl_hw) || (cl_band_is_24g(cl_hw) && conf->ci_vht_=
cap_24g)) {
+               if (bw =3D=3D CHNL_BW_160)
+                       sband_vht_cap->cap |=3D IEEE80211_VHT_CAP_SUPP_CHAN=
_WIDTH_160MHZ;
+
+               sband_vht_cap->cap |=3D (conf->ha_vht_max_ampdu_len_exp <<
+                                      IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_=
EXPONENT_SHIFT);
+
+               if (conf->ce_vht_rxldpc_en)
+                       sband_vht_cap->cap |=3D IEEE80211_VHT_CAP_RXLDPC;
+
+               sband_vht_cap->vht_mcs.rx_mcs_map =3D cpu_to_le16(0);
+               sband_vht_cap->vht_mcs.tx_mcs_map =3D cpu_to_le16(0);
+
+               for (i =3D 0; i < rx_nss; i++)
+                       sband_vht_cap->vht_mcs.rx_mcs_map |=3D
+                               cpu_to_le16(vht_mcs_supp_rx(cl_hw, i) << (i=
 * 2));
+
+               for (; i < 8; i++)
+                       sband_vht_cap->vht_mcs.rx_mcs_map |=3D
+                               cpu_to_le16(IEEE80211_VHT_MCS_NOT_SUPPORTED=
 << (i * 2));
+
+               for (i =3D 0; i < tx_nss; i++)
+                       sband_vht_cap->vht_mcs.tx_mcs_map |=3D
+                               cpu_to_le16(vht_mcs_supp_tx(cl_hw, i) << (i=
 * 2));
+
+               for (; i < 8; i++)
+                       sband_vht_cap->vht_mcs.tx_mcs_map |=3D
+                               cpu_to_le16(IEEE80211_VHT_MCS_NOT_SUPPORTED=
 << (i * 2));
+
+               sband_vht_cap->vht_mcs.rx_highest =3D cpu_to_le16(390 * rx_=
nss);
+               sband_vht_cap->vht_mcs.tx_highest =3D cpu_to_le16(390 * tx_=
nss);
+               sband_vht_cap->vht_supported =3D true;
+       }
+
+       /* 6GHz band supports HE only */
+       if (!cl_band_is_6g(cl_hw)) {
+               for (i =3D 0; i < rx_nss; i++)
+                       sband_ht_cap->mcs.rx_mask[i] =3D U8_MAX;
+
+               if (bw =3D=3D CHNL_BW_20)
+                       sband_ht_cap->mcs.rx_highest =3D guard_interval ?
+                               cpu_to_le16(72 * rx_nss) : cpu_to_le16(65 *=
 rx_nss);
+               else
+                       sband_ht_cap->mcs.rx_highest =3D guard_interval ?
+                               cpu_to_le16(150 * rx_nss) : cpu_to_le16(135=
 * rx_nss);
+       }
+
+       if (cl_hw->conf->ce_wireless_mode > WIRELESS_MODE_HT_VHT)
+               cl_set_he_capab(cl_hw);
+
+       /* Get channels and power limitations information from ChannelInfo =
file */
+       cl_chan_info_init(cl_hw);
+
+       if (cl_band_is_6g(cl_hw)) {
+               wiphy->bands[NL80211_BAND_2GHZ] =3D NULL;
+               wiphy->bands[NL80211_BAND_5GHZ] =3D NULL;
+               wiphy->bands[NL80211_BAND_6GHZ] =3D sband;
+       } else if (cl_band_is_5g(cl_hw)) {
+               wiphy->bands[NL80211_BAND_2GHZ] =3D NULL;
+               wiphy->bands[NL80211_BAND_5GHZ] =3D sband;
+               wiphy->bands[NL80211_BAND_6GHZ] =3D NULL;
+       } else {
+               wiphy->bands[NL80211_BAND_2GHZ] =3D sband;
+               wiphy->bands[NL80211_BAND_5GHZ] =3D NULL;
+               wiphy->bands[NL80211_BAND_6GHZ] =3D NULL;
+       }
+
+       wiphy->regulatory_flags |=3D REGULATORY_WIPHY_SELF_MANAGED;
+}
+
+enum he_pkt_ext_constellations {
+       HE_PKT_EXT_BPSK =3D 0,
+       HE_PKT_EXT_QPSK,
+       HE_PKT_EXT_16QAM,
+       HE_PKT_EXT_64QAM,
+       HE_PKT_EXT_256QAM,
+       HE_PKT_EXT_1024QAM,
+       HE_PKT_EXT_RESERVED,
+       HE_PKT_EXT_NONE,
+};
+
+static u8 mcs_to_constellation[WRS_MCS_MAX_HE] =3D {
+       HE_PKT_EXT_BPSK,
+       HE_PKT_EXT_QPSK,
+       HE_PKT_EXT_QPSK,
+       HE_PKT_EXT_16QAM,
+       HE_PKT_EXT_16QAM,
+       HE_PKT_EXT_64QAM,
+       HE_PKT_EXT_64QAM,
+       HE_PKT_EXT_64QAM,
+       HE_PKT_EXT_256QAM,
+       HE_PKT_EXT_256QAM,
+       HE_PKT_EXT_1024QAM,
+       HE_PKT_EXT_1024QAM
+};
+
+#define QAM_THR_1 0
+#define QAM_THR_2 1
+#define QAM_THR_MAX 2
+
+static u8 get_ppe_val(u8 *ppe, u8 ppe_pos_bit)
+{
+       u8 byte_num =3D ppe_pos_bit / 8;
+       u8 bit_num =3D ppe_pos_bit % 8;
+       u8 residue_bits;
+       u8 res;
+
+       if (bit_num <=3D 5)
+               return (ppe[byte_num] >> bit_num) &
+                      (BIT(IEEE80211_PPE_THRES_INFO_PPET_SIZE) - 1);
+
+       /*
+        * If bit_num > 5, we have to combine bits with next byte.
+        * Calculate how many bits we need to take from current byte (calle=
d
+        * here "residue_bits"), and add them to bits from next byte.
+        */
+       residue_bits =3D 8 - bit_num;
+
+       res =3D (ppe[byte_num + 1] &
+              (BIT(IEEE80211_PPE_THRES_INFO_PPET_SIZE - residue_bits) - 1)=
) <<
+             residue_bits;
+       res +=3D (ppe[byte_num] >> bit_num) & (BIT(residue_bits) - 1);
+
+       return res;
+}
+
+static void set_fixed_ppe_val(u8 pe_dur[CHNL_BW_MAX][WRS_MCS_MAX_HE], u8 d=
ur)
+{
+       u8 val =3D ((dur << 6) | (dur << 4) | (dur << 2) | dur);
+
+       memset(pe_dur, val, CHNL_BW_MAX * WRS_MCS_MAX_HE);
+}
+
+void cl_cap_ppe_duration(struct cl_hw *cl_hw, struct ieee80211_sta *sta,
+                        u8 pe_dur[CHNL_BW_MAX][WRS_MCS_MAX_HE])
+{
+       /* Force NVRAM parameter */
+       if (cl_hw->conf->ci_pe_duration <=3D PPE_16US) {
+               set_fixed_ppe_val(pe_dur, cl_hw->conf->ci_pe_duration);
+               return;
+       }
+
+       /*
+        * If STA sets the PPE Threshold Present subfield to 0,
+        * the value should be set according to the Nominal Packet Padding =
subfield
+        */
+       if ((sta->he_cap.he_cap_elem.phy_cap_info[6] &
+            IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) =3D=3D 0) {
+               switch (sta->he_cap.he_cap_elem.phy_cap_info[9] &
+                       IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_MASK) {
+               case IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_0US:
+                       set_fixed_ppe_val(pe_dur, PPE_0US);
+                       break;
+               case IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_8US:
+                       set_fixed_ppe_val(pe_dur, PPE_8US);
+                       break;
+               case IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_16US:
+               default:
+                       set_fixed_ppe_val(pe_dur, PPE_16US);
+                       break;
+               }
+
+               return;
+       }
+
+       /*
+        * struct iwl_he_pkt_ext - QAM thresholds
+        * The required PPE is set via HE Capabilities IE, per Nss x BW x M=
CS
+        * The IE is organized in the following way:
+        * Support for Nss x BW (or RU) matrix:
+        *      (0=3DSISO, 1=3DMIMO2) x (0-20MHz, 1-40MHz, 2-80MHz, 3-160MH=
z)
+        * Each entry contains 2 QAM thresholds for 8us and 16us:
+        *      0=3DBPSK, 1=3DQPSK, 2=3D16QAM, 3=3D64QAM, 4=3D256QAM, 5=3D1=
024QAM, 6=3DRES, 7=3DNONE
+        * i.e. QAM_th1 < QAM_th2 such if TX uses QAM_tx:
+        *      QAM_tx < QAM_th1            --> PPE=3D0us
+        *      QAM_th1 <=3D QAM_tx < QAM_th2 --> PPE=3D8us
+        *      QAM_th2 <=3D QAM_tx           --> PPE=3D16us
+        * @pkt_ext_qam_th: QAM thresholds
+        *      For each Nss/Bw define 2 QAM thrsholds (0..5)
+        *      For rates below the low_th, no need for PPE
+        *      For rates between low_th and high_th, need 8us PPE
+        *      For rates equal or higher then the high_th, need 16us PPE
+        *      Nss (0-siso, 1-mimo2) x BW (0-20MHz, 1-40MHz, 2-80MHz, 3-16=
0MHz) x
+        *              (0-low_th, 1-high_th)
+        */
+       u8 pkt_ext_qam_th[WRS_SS_MAX][CHNL_BW_MAX][QAM_THR_MAX];
+
+       /* If PPE Thresholds exist, parse them into a FW-familiar format. *=
/
+       u8 nss =3D (sta->he_cap.ppe_thres[0] & IEEE80211_PPE_THRES_NSS_MASK=
) + 1;
+       u8 ru_index_bitmap =3D u32_get_bits(sta->he_cap.ppe_thres[0],
+                                         IEEE80211_PPE_THRES_RU_INDEX_BITM=
ASK_MASK);
+       u8 *ppe =3D &sta->he_cap.ppe_thres[0];
+       u8 ppe_pos_bit =3D 7; /* Starting after PPE header */
+       u8 bw, ss, mcs, constellation;
+
+       if (nss > WRS_SS_MAX)
+               nss =3D WRS_SS_MAX;
+
+       for (ss =3D 0; ss < nss; ss++) {
+               u8 ru_index_tmp =3D ru_index_bitmap << 1;
+
+               for (bw =3D 0; bw <=3D cl_hw->bw; bw++) {
+                       ru_index_tmp >>=3D 1;
+                       if (!(ru_index_tmp & 1))
+                               continue;
+
+                       pkt_ext_qam_th[ss][bw][QAM_THR_2] =3D get_ppe_val(p=
pe, ppe_pos_bit);
+                       ppe_pos_bit +=3D IEEE80211_PPE_THRES_INFO_PPET_SIZE=
;
+                       pkt_ext_qam_th[ss][bw][QAM_THR_1] =3D get_ppe_val(p=
pe, ppe_pos_bit);
+                       ppe_pos_bit +=3D IEEE80211_PPE_THRES_INFO_PPET_SIZE=
;
+               }
+       }
+
+       /* Reset PE duration before filling it */
+       memset(pe_dur, 0, CHNL_BW_MAX * WRS_MCS_MAX_HE);
+
+       for (ss =3D 0; ss < nss; ss++) {
+               for (bw =3D 0; bw <=3D cl_hw->bw; bw++) {
+                       for (mcs =3D 0; mcs < WRS_MCS_MAX_HE; mcs++) {
+                               constellation =3D mcs_to_constellation[mcs]=
;
+
+                               if (constellation < pkt_ext_qam_th[ss][bw][=
QAM_THR_1])
+                                       pe_dur[bw][mcs] |=3D (PPE_0US << (s=
s * 2));
+                               else if (constellation < pkt_ext_qam_th[ss]=
[bw][QAM_THR_2])
+                                       pe_dur[bw][mcs] |=3D (PPE_8US << (s=
s * 2));
+                               else
+                                       pe_dur[bw][mcs] |=3D (PPE_16US << (=
ss * 2));
+                       }
+               }
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

