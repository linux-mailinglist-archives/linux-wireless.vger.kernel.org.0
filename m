Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98CC3AB8C9
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhFQQKa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:30 -0400
Received: from mail-vi1eur05on2083.outbound.protection.outlook.com ([40.107.21.83]:50945
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231960AbhFQQJa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5EgloX51DtQLfuI5L4N7GmsKkjrJhb3rdtNISHTzWz6Rq9xfmMpjLxh6ZUeSw4PJdU3jiBTR52ciGHHFmwljkKZ7yL5bkbvHyheJoJcTZOlOj0OM6KLZYu8P5NXFYVz9+2G+ltHhwbcIj+AeQ6W1yVITBk/MqzKabk74CQ7oU1OUz/hVe5Zfqkms2q916h4TcUtv3Gn4fl/VjoHKPFRGZiSCTA7HZMV+RDN6pPykJZ92uO4MBwk9OzxE5Rf3zbI+84DKOh3DsfOFKgEZ0Z8PLmq9U7UVFVxwcWozCc59SkCf0wBgv8MbT2kiDM5QNBfKxnSOtFt86vhqKyndw8vhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hC7TCRUN7N2gnVduXQWBFDtxXxQTWWEjo13bCpyIlUc=;
 b=S6AL9hIAB8HR5EJYQozqo3HQVm7cmA5bjqpXQomPH04DhrwYX+99YpAad9wDz3R7esnMiXcq/4fC4UYPW5ulzvGm6UX8cWI6WtNHYDtS6fQxwKmfYdYLUJPia3XWx6RIhNAGpgPhJ3f6szZBnOL4KIfuUu9FIEuJB373cv2MgfRT6oNa0ZGZ15eWt3CQ9JXqtljljcnKrD2JLjV3+nJ8t5L8wtAoCWp5wVltqg40ORXxn4e3Fzc8orTRlKH/V8RgB8L1o0peAFcJ87/T3XwISu/gjVhvzPHDZboulYNQPI5n9fVCwX+FfCvfS4EAKCe7nBxerFp9e7iYCWAV/8Yigg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hC7TCRUN7N2gnVduXQWBFDtxXxQTWWEjo13bCpyIlUc=;
 b=Os+asL0TPdfz/nKNGIXddAC6eh97+GMwuyhW9IL7dvkekTAhlfMbc3w+8VX1RF3ZMPwlQvDJeqpmajDqE2yOdHaeYN6cTLJjnQgMM1f/i0khN9MQ25/O/YPbR5VzBfsItX8/Vf7rlwOStRldNvU83CMzN0mfAzSkGNzV/qY7Tc0=
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
Subject: [RFC v1 133/256] cl8k: add power.c
Date:   Thu, 17 Jun 2021 16:00:20 +0000
Message-Id: <20210617160223.160998-134-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29a8db40-1a00-44be-13a2-08d931a9a910
X-MS-TrafficTypeDiagnostic: AM9P192MB1314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1314B738D5082BC2D3BACECAF60E9@AM9P192MB1314.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KvUKGX2QM/0kY4JHoy2jpJQW2+PzV5NwH9xgC6HQRaFmvodwLLQvH0ZRK49Zvw/fKuPDfOZr/leQImXRneATF5KWjVWnGTxnRwJMtdeX+9hZa04E1gJ/AJ6Qo4/0mQoKFSus5qwQIvDeBMXsYiUAr5NEDUKoeWkpOS4pp/SsGvMN8xNwlA1VL1qzRur0716W3l5DeIvUiVmTi+SBZM3uicnl7ri1RcPyqQGNd5fzpZXLwNdRjrqjOG/UJZlVpz+mJs1SFERTJymuSEN10lVv+Iy9LLdvh+Kl4V1SakMIRuQ+p9LWKe6B5xPYAsAP1kPgeIkaGdL747Q0WZoB+IU46DGwO3QRY79WRatHHNvJYr21L1jWvm1+vIBUz0RqGXOCaGT2uMFXDq34EaWPcCdjHwCfYwoTOpd/1BvVRrbScYLtTPnUmwOOul+qIkAfF0CWKmW/x8m407LPb8jKQk0dxJHfDWIqnv14n2yZO+PIAlQOCn6dRDFqJt5kMIMk6E3XK0MXu38PfLVWmreWMIWSoy/5WDDF+g5qFr2LZOhZgBidjF5ryDFGVnZBpEru5rN6wVu77I3kFJ+gPQBG36zHrQMhMzswQiSXOv2qyOxub15x0ah/6UqTcmq1xmjm3FJy3XNi5A1WWxxqVD3mr1k2n95UYCII+BOGj/HswiDxa6NZ4C4j8aOqwsD1CWI1nHfLLQITjKPvIVkY9KCehESVYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(39840400004)(366004)(376002)(136003)(346002)(8936002)(66946007)(83380400001)(186003)(5660300002)(26005)(36756003)(86362001)(8676002)(55236004)(1076003)(6916009)(2906002)(6506007)(66476007)(478600001)(6666004)(30864003)(38350700002)(52116002)(66556008)(956004)(4326008)(107886003)(54906003)(38100700002)(6486002)(2616005)(316002)(16526019)(6512007)(9686003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D3+1F/PIqMOqW8oKIxnMxdkgP/zvfkGfaim/DDk8Ec5T+KfqZOHzQvtVn82O?=
 =?us-ascii?Q?2rSW5cuw1wpNQGaNb5YFWBIHU7Vg/lgdLOzQHIq+G4Ko4WZPnL10ScOC6kgr?=
 =?us-ascii?Q?WcoGuZl73LiHM8RrdNXlge3TMgqVXCPA1upkCuKJKaxUWvS3vk3mINoXmCen?=
 =?us-ascii?Q?Y5pY4ldZs9vjfdUWKu2Sz39GQ9ennlagvRgHOTmgLmrTecEPMDG3Rttng48f?=
 =?us-ascii?Q?uYce7h/6TzjM5a6I7BMHbZJAbKTAWC4ASfsxfLiVe3adzLipFj45qn2IjUBk?=
 =?us-ascii?Q?1RXfU4bf7XGeWi4XfxxDqOU5W/vfSfuDgH6Iw54r9bfKZPyaC3zE9CSekQJP?=
 =?us-ascii?Q?Zg0+GLQJ2sHL2KMpka3/SpbKRq5jATiy/T4pK9+61ehiyDt39pHqbGoylgN6?=
 =?us-ascii?Q?CyygOQKLzEOge4y1M4SqvN7ZOe8CmlmcbQYIPkIB354UIQNek2FM/Mb8dFbg?=
 =?us-ascii?Q?pbIWSc7OMcLKZzT2euQLk6nPXHscvM5ykJ60WXdnlGbPadZSXCZVMiQsdGvu?=
 =?us-ascii?Q?HfxHrzp4AFXsK1MMnupxd5oGDw5pXUj/tKPSDGP03ioc+nwIbIVfVTUJPcuU?=
 =?us-ascii?Q?R12zfl20dxXI6dd2n7nJUxH+w+kX23Y0R9de5DagMXu9T+bsnZrulWWAplQs?=
 =?us-ascii?Q?ow67/lCD8H9kBiNbXgTgDKs1fLoFYlWb8uyHyMRX0YEsOwlVLpKHDNb6smDV?=
 =?us-ascii?Q?45n9THYkZcs50KruwhNLTrHcP6pGpXzYoaMM9as0jMAuueuq74Cutw+hoqNe?=
 =?us-ascii?Q?fYT0T6d+/96yu86x32rt1CmqSSwISqwHg8UPu3j5YZidBfPPFCOXQVxtTR3K?=
 =?us-ascii?Q?yRayK947pnea8opOgBUXuSAm8JsFmFzbzJLEYfJl87+3kXE3i9wGyErnF6wh?=
 =?us-ascii?Q?juYqZ8auI7FmK4JDVylKeQUWsfdITDVxMvC/1Wcco0+2eynCfz3mVCcgQ29H?=
 =?us-ascii?Q?Z8+R1cdZoUsi58DyOJUqxKHrL6L3UPohBjKu8FxoM8gDrlzjxRW+eMQ5hE7i?=
 =?us-ascii?Q?IozVYebfw6l8fAcYKY+YckEblYwYFGkeLjpDfOfyUCiX4hPJiVFvcGsB7xAR?=
 =?us-ascii?Q?F4K7dc8CKlOve3DmwwnnhUFh38o2oXfNw3zJhUxiHPdW9XBeeL04C+jwkZWP?=
 =?us-ascii?Q?aBobZgctUkPHVxg9lW6inxZuRcpHTYix42dgnbGZiZUeXt3hBWiQX5saB86K?=
 =?us-ascii?Q?/898/gV+rOHr+YEwEd2M4+v3ln0aKmm9zLD6C/XqGrCXP2XoG2Oc1y5+9zwV?=
 =?us-ascii?Q?zJCUbQOprEOFt9ay7XqCW8xCgODe3WHwkss+v+05rF4VMU3ybXcioumf9ygH?=
 =?us-ascii?Q?A/JKCU5bPZJdBZUIb3GVMYR8?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a8db40-1a00-44be-13a2-08d931a9a910
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:00.7582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tdvm+Vuv3qd1yK4kHaKJEjgrQT1hbb49ip8nKZvBzQGDmL/rvYnJ83+ppiAhYp10Qu8ahaV0RzfDrCpraT+7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1314
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/power.c | 946 +++++++++++++++++++++++
 1 file changed, 946 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/power.c

diff --git a/drivers/net/wireless/celeno/cl8k/power.c b/drivers/net/wireles=
s/celeno/cl8k/power.c
new file mode 100644
index 000000000000..6662bc0ebd66
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/power.c
@@ -0,0 +1,946 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include <linux/string.h>
+#include "power.h"
+#include "reg/reg_access.h"
+#include "chan_info.h"
+#include "utils/utils.h"
+#include "band.h"
+#include "utils/string.h"
+#include "channel.h"
+
+static s32 convert_str_int_q8(s8 *str)
+{
+       s32 x, y;
+
+       if (!str)
+               return 0;
+       if (sscanf(str, "%d.%2d", &x, &y) =3D=3D 0)
+               return 0;
+       if (!strstr(str, "."))
+               return x << 8;
+       if (y < 10 && (*(strstr(str, ".") + 1) !=3D '0'))
+               y *=3D 10;
+       return ((x * 100 + y) << 8) / 100;
+}
+
+u8 cl_power_tx_ant(struct cl_hw *cl_hw, enum cl_wrs_mode mode)
+{
+       if (mode =3D=3D WRS_MODE_CCK)
+               return hweight8(cl_hw->conf->ce_cck_tx_ant_mask);
+
+       if (mode <=3D WRS_MODE_VHT)
+               return min_t(u8, cl_hw->num_antennas, MAX_ANTENNAS_OFDM_HT_=
VHT);
+
+       return cl_hw->num_antennas;
+}
+
+s32 cl_power_antenna_gain_q8(struct cl_hw *cl_hw)
+{
+       u8 channel =3D cl_hw->channel;
+
+       if (channel >=3D 36 && channel <=3D 64)
+               return convert_str_int_q8(cl_hw->conf->ce_ant_gain_36_64);
+       else if (channel >=3D 100 && channel <=3D 140)
+               return convert_str_int_q8(cl_hw->conf->ce_ant_gain_100_140)=
;
+       else if (channel >=3D 149 && channel < 165)
+               return convert_str_int_q8(cl_hw->conf->ce_ant_gain_149_165)=
;
+       else
+               return convert_str_int_q8(cl_hw->conf->ce_ant_gain); /* 2.4=
g and 6g */
+}
+
+s32 cl_power_antenna_gain_q1(struct cl_hw *cl_hw)
+{
+       return cl_power_antenna_gain_q8(cl_hw) >> 7;
+}
+
+s32 cl_power_array_gain_q8(struct cl_hw *cl_hw, u8 tx_ant)
+{
+       /*
+        * Format in NVRAM of ce_arr_gain=3DA,B,C,D,E,F
+        * A is the array gain with 1 tx_ant, B is with 2 tx_ant and so on.=
..
+        */
+       int arr_gain_val =3D 0;
+       int arr_gain_len =3D 0;
+       int idx =3D 0;
+       s8 *arr_gain_cpy =3D NULL;
+       s8 *arr_gain_str =3D NULL;
+       s8 *arr_gain_tmp =3D NULL;
+
+       arr_gain_len =3D strlen(cl_hw->conf->ce_arr_gain) + 1;
+       arr_gain_cpy =3D kzalloc(arr_gain_len, GFP_ATOMIC);
+
+       if (!arr_gain_cpy)
+               return 0;
+
+       /* Copy cl_hw->conf->ce_arr_gain so its value won't be changed by c=
l_strtok_r() */
+       memcpy(arr_gain_cpy, cl_hw->conf->ce_arr_gain, arr_gain_len);
+
+       /* Arr_gain_str points to the array gain of 1 tx_ant */
+       arr_gain_str =3D cl_strtok_r(arr_gain_cpy, ",", &arr_gain_tmp);
+
+       /* Only a single value in ce_arr_gain - same value will be applied =
for all tx_ant */
+       if (!arr_gain_tmp) {
+               arr_gain_val =3D convert_str_int_q8(arr_gain_cpy);
+       } else {
+               /* Keep iterating until getting to the correct ant idx */
+               for (idx =3D 1; arr_gain_str && (idx < tx_ant); idx++)
+                       arr_gain_str =3D cl_strtok_r(NULL, ",", &arr_gain_t=
mp);
+
+               arr_gain_val =3D arr_gain_str ? convert_str_int_q8(arr_gain=
_str) : 0;
+       }
+
+       kfree(arr_gain_cpy);
+
+       return arr_gain_val;
+}
+
+s8 cl_power_array_gain_q2(struct cl_hw *cl_hw, u8 tx_ant)
+{
+       return (s8)(cl_power_array_gain_q8(cl_hw, tx_ant) >> 6);
+}
+
+s32 cl_power_array_gain_q1(struct cl_hw *cl_hw, u8 tx_ant)
+{
+       return cl_power_array_gain_q8(cl_hw, tx_ant) >> 7;
+}
+
+static s32 cl_power_bf_gain_q8(struct cl_hw *cl_hw, u8 tx_ant, u8 nss)
+{
+       /*
+        * Format in NVRAM of ce_bf_gain=3DA,B,C,D
+        * A is the bf gain with 1 NSS, B is with 2 NSS and so on...
+        */
+       int bf_gain_val =3D 0;
+       int bf_gain_len =3D 0;
+       int idx =3D 0;
+       s8 *bf_gain_ptr =3D NULL;
+       s8 *bf_gain_cpy =3D NULL;
+       s8 *bf_gain_str =3D NULL;
+       s8 *bf_gain_tmp =3D NULL;
+
+       if (tx_ant =3D=3D 6) {
+               bf_gain_ptr =3D cl_hw->conf->ce_bf_gain_6_ant;
+       } else if (tx_ant =3D=3D 5) {
+               bf_gain_ptr =3D cl_hw->conf->ce_bf_gain_5_ant;
+       } else if (tx_ant =3D=3D 4) {
+               bf_gain_ptr =3D cl_hw->conf->ce_bf_gain_4_ant;
+       } else if (tx_ant =3D=3D 3) {
+               bf_gain_ptr =3D cl_hw->conf->ce_bf_gain_3_ant;
+       } else if (tx_ant =3D=3D 2) {
+               bf_gain_ptr =3D cl_hw->conf->ce_bf_gain_2_ant;
+       } else if (tx_ant =3D=3D 1) {
+               goto out;
+       } else {
+               pr_err("[%s]: invalid tx_ant %u\n", __func__, tx_ant);
+               goto out;
+       }
+
+       bf_gain_len =3D strlen(bf_gain_ptr) + 1;
+       bf_gain_cpy =3D kzalloc(bf_gain_len, GFP_ATOMIC);
+
+       if (!bf_gain_cpy)
+               return 0;
+
+       /* Copy cl_hw->conf->ce_bf_gain_*_ant so its value won't be changed=
 by cl_strtok_r() */
+       memcpy(bf_gain_cpy, bf_gain_ptr, bf_gain_len);
+
+       /* Bf_gain_str points to the bf gain of 1 SS */
+       bf_gain_str =3D cl_strtok_r(bf_gain_cpy, ",", &bf_gain_tmp);
+
+       /* Keep iterating until getting to the correct ss index */
+       for (idx =3D 0; bf_gain_str && (idx < nss); idx++)
+               bf_gain_str =3D cl_strtok_r(NULL, ",", &bf_gain_tmp);
+
+       bf_gain_val =3D bf_gain_str ? convert_str_int_q8(bf_gain_str) : 0;
+
+       kfree(bf_gain_cpy);
+ out:
+       return bf_gain_val;
+}
+
+s32 cl_power_bf_gain_q1(struct cl_hw *cl_hw, u8 tx_ant, u8 nss)
+{
+       return cl_power_bf_gain_q8(cl_hw, tx_ant, nss) >> 7;
+}
+
+static s32 cl_power_min_ant_q8(struct cl_hw *cl_hw)
+{
+       return convert_str_int_q8(cl_hw->conf->ci_min_ant_pwr);
+}
+
+s32 cl_power_min_ant_q1(struct cl_hw *cl_hw)
+{
+       return cl_power_min_ant_q8(cl_hw) >> 7;
+};
+
+s8 cl_power_bw_factor_q2(struct cl_hw *cl_hw, u8 bw)
+{
+       /*
+        * Format in NVRAM of ci_bw_factor=3DA,B,C,D
+        * A is the bw factor for bw 20MHz, B is for 40MHz and so on..
+        */
+       int bw_factor_val =3D 0;
+       int bw_factor_len =3D 0;
+       int idx =3D 0;
+       s8 *bw_factor_cpy =3D NULL;
+       s8 *bw_factor_str =3D NULL;
+       s8 *bw_factor_tmp =3D NULL;
+
+       bw_factor_len =3D strlen(cl_hw->conf->ci_bw_factor) + 1;
+       bw_factor_cpy =3D kzalloc(bw_factor_len, GFP_ATOMIC);
+
+       if (!bw_factor_cpy)
+               return 0;
+
+       /* Copy cl_hw->conf->ci_bw_factor so its value won't be changed by =
cl_strtok_r() */
+       memcpy(bw_factor_cpy, cl_hw->conf->ci_bw_factor, bw_factor_len);
+
+       /* Bw_factor_str points to the bw factor of 20MHz */
+       bw_factor_str =3D cl_strtok_r(bw_factor_cpy, ",", &bw_factor_tmp);
+
+       /* Only a single value in ci_bw_factor - same value will be applied=
 for all bandwidths */
+       if (!bw_factor_tmp) {
+               bw_factor_val =3D convert_str_int_q8(bw_factor_cpy);
+       } else {
+               /* Keep iterating until getting to the correct bw index */
+               for (idx =3D 0; bw_factor_str && (idx < bw); idx++)
+                       bw_factor_str =3D cl_strtok_r(NULL, ",", &bw_factor=
_tmp);
+
+               bw_factor_val =3D bw_factor_str ? convert_str_int_q8(bw_fac=
tor_str) : 0;
+       }
+
+       kfree(bw_factor_cpy);
+
+       return (s8)(bw_factor_val >> 6);
+}
+
+static s32 cl_power_average_calib_q8(struct cl_hw *cl_hw, u8 ant_num)
+{
+       u8 ant =3D 0;
+       u8 chan_idx =3D cl_channel_to_index(cl_hw, cl_hw->channel);
+       s32 total_calib_pow =3D 0;
+
+       if (chan_idx =3D=3D INVALID_CHAN_IDX)
+               return 0;
+
+       for (ant =3D 0; ant < ant_num; ant++)
+               total_calib_pow +=3D cl_hw->tx_pow_info[chan_idx][ant].powe=
r;
+
+       return ((total_calib_pow << 8) / ant_num);
+}
+
+s32 cl_power_average_calib_q1(struct cl_hw *cl_hw, u8 ant_num)
+{
+       return cl_power_average_calib_q8(cl_hw, ant_num) >> 7;
+}
+
+static s32 cl_power_total_q8(struct cl_hw *cl_hw, s8 pwr_offset_q1, u8 tx_=
ant, u8 nss,
+                            enum cl_wrs_mode mode, bool is_auto_resp)
+{
+       s32 bf_gain_q8 =3D  0;
+       s32 antenna_gain_q8 =3D cl_power_antenna_gain_q8(cl_hw);
+       s32 array_gain_q8 =3D cl_power_array_gain_q8(cl_hw, tx_ant);
+       s32 pwr_offset_q8 =3D (s32)pwr_offset_q1 << 7;
+       s32 calib_power_q8 =3D cl_power_average_calib_q8(cl_hw, tx_ant);
+       s32 total_power_q8 =3D 0;
+
+       if (!is_auto_resp)
+               bf_gain_q8 =3D (mode > WRS_MODE_OFDM) ? cl_power_bf_gain_q8=
(cl_hw, tx_ant, nss) : 0;
+
+       total_power_q8 =3D calib_power_q8 + bf_gain_q8 + array_gain_q8 +
+               antenna_gain_q8 + pwr_offset_q8;
+
+       /* FCC calculation */
+       if (cl_hw->channel_info.standard =3D=3D CL_STANDARD_FCC)
+               total_power_q8 -=3D min(bf_gain_q8 + antenna_gain_q8, 6 << =
8);
+
+       return total_power_q8;
+}
+
+s32 cl_power_total_q1(struct cl_hw *cl_hw, s8 pwr_offset_q1, u8 tx_ant, u8=
 nss,
+                     enum cl_wrs_mode mode, bool is_auto_resp)
+{
+       return cl_power_total_q8(cl_hw, pwr_offset_q1, tx_ant, nss, mode, i=
s_auto_resp) >> 7;
+}
+
+static s32 cl_power_eirp_delta_q1(struct cl_hw *cl_hw, u8 bw, s8 pwr_offse=
t_q1, u8 tx_ant,
+                                 u8 nss, enum cl_wrs_mode mode, bool is_au=
to_resp)
+{
+       /* Calculate total TX power */
+       s32 total_power_q8 =3D cl_power_total_q8(cl_hw, pwr_offset_q1, tx_a=
nt, nss,
+                                              mode, is_auto_resp);
+
+       /* EIRP power limit */
+       s32 eirp_power_limit_q8 =3D cl_chan_info_get_eirp_limit_q8(cl_hw, b=
w);
+
+       /* Delta between total TX power and EIRP limit */
+       return (total_power_q8 - eirp_power_limit_q8) >> 7;
+}
+
+static s8 cl_power_calc_q1(struct cl_hw *cl_hw, s8 mcs_offset_q1, u8 bw, u=
8 nss,
+                          enum cl_wrs_mode mode, bool is_auto_resp, u8 *tr=
unc_pwr_q1)
+{
+       /* Result is in 0.5dBm resolution */
+       u8 tx_ant =3D cl_power_tx_ant(cl_hw, mode);
+       s32 calib_power_q1 =3D cl_power_average_calib_q1(cl_hw, tx_ant);
+       s32 res_q1 =3D calib_power_q1 + mcs_offset_q1;
+       s32 min_pwr_q1 =3D POWER_MIN_DB_Q1;
+
+       if (cl_hw->channel_info.use_channel_info && cl_hw->conf->ci_eirp_re=
gulatory_en) {
+               s32 delta_power_q1 =3D cl_power_eirp_delta_q1(cl_hw, bw, mc=
s_offset_q1,
+                                                           tx_ant, nss, mo=
de, is_auto_resp);
+
+               if (delta_power_q1 > 0) {
+                       /*
+                        * If tx power is greater than the limitation
+                        * subtract delta power from the result
+                        */
+                       res_q1 -=3D delta_power_q1;
+                       *trunc_pwr_q1 =3D delta_power_q1;
+               } else {
+                       *trunc_pwr_q1 =3D 0;
+               }
+       } else {
+               *trunc_pwr_q1 =3D 0;
+       }
+
+       if (is_auto_resp)
+               min_pwr_q1 +=3D cl_power_min_ant_q1(cl_hw);
+
+       if (res_q1 < min_pwr_q1) {
+               *trunc_pwr_q1 =3D max((s32)(*trunc_pwr_q1) - min_pwr_q1 - r=
es_q1, 0);
+               res_q1 =3D min_pwr_q1;
+       }
+
+       if (is_auto_resp)
+               res_q1 +=3D cl_power_array_gain_q1(cl_hw, tx_ant);
+
+       return (s8)res_q1;
+}
+
+static s8 cl_power_offset_he(struct cl_hw *cl_hw, u8 bw, u8 mcs)
+{
+       u8 channel =3D cl_hw->channel;
+       s8 *ppmcs =3D NULL;
+
+       switch (cl_hw->conf->ci_band_num) {
+       case BAND_5G:
+               if (channel >=3D 36 && channel <=3D 64)
+                       ppmcs =3D cl_hw->conf->ce_ppmcs_offset_he_36_64;
+               else if (channel >=3D 100 && channel <=3D 140)
+                       ppmcs =3D cl_hw->conf->ce_ppmcs_offset_he_100_140;
+               else
+                       ppmcs =3D cl_hw->conf->ce_ppmcs_offset_he_149_165;
+               break;
+       case BAND_24G:
+               ppmcs =3D cl_hw->conf->ce_ppmcs_offset_he;
+               break;
+       case BAND_6G:
+               ppmcs =3D cl_hw->conf->ce_ppmcs_offset_he_6g;
+               break;
+       default:
+               return 0;
+       }
+
+       return ppmcs[mcs] + cl_hw->conf->ce_ppbw_offset[bw];
+}
+
+static s8 cl_power_offset_ht_vht(struct cl_hw *cl_hw, u8 bw, u8 mcs)
+{
+       u8 channel =3D cl_hw->channel;
+       s8 *ppmcs =3D NULL;
+
+       switch (cl_hw->conf->ci_band_num) {
+       case BAND_5G:
+               if (channel >=3D 36 && channel <=3D 64)
+                       ppmcs =3D cl_hw->conf->ce_ppmcs_offset_ht_vht_36_64=
;
+               else if (channel >=3D 100 && channel <=3D 140)
+                       ppmcs =3D cl_hw->conf->ce_ppmcs_offset_ht_vht_100_1=
40;
+               else
+                       ppmcs =3D cl_hw->conf->ce_ppmcs_offset_ht_vht_149_1=
65;
+               break;
+       case BAND_24G:
+               ppmcs =3D cl_hw->conf->ce_ppmcs_offset_ht;
+               break;
+       case BAND_6G:
+       default:
+               return 0;
+       }
+
+       return ppmcs[mcs] + cl_hw->conf->ce_ppbw_offset[bw];
+}
+
+static s8 cl_power_offset_ofdm(struct cl_hw *cl_hw, u8 mcs)
+{
+       u8 channel =3D cl_hw->channel;
+       s8 *ppmcs =3D NULL;
+
+       switch (cl_hw->conf->ci_band_num) {
+       case BAND_5G:
+               if (channel >=3D 36 && channel <=3D 64)
+                       ppmcs =3D cl_hw->conf->ce_ppmcs_offset_ofdm_36_64;
+               else if (channel >=3D 100 && channel <=3D 140)
+                       ppmcs =3D cl_hw->conf->ce_ppmcs_offset_ofdm_100_140=
;
+               else
+                       ppmcs =3D cl_hw->conf->ce_ppmcs_offset_ofdm_149_165=
;
+               break;
+       case BAND_24G:
+               ppmcs =3D cl_hw->conf->ce_ppmcs_offset_ofdm;
+               break;
+       case BAND_6G:
+       default:
+               return 0;
+       }
+
+       return ppmcs[mcs] + cl_hw->conf->ce_ppbw_offset[CHNL_BW_20];
+}
+
+static s8 cl_power_offset_cck(struct cl_hw *cl_hw, u8 mcs)
+{
+       s8 *ppmcs =3D cl_hw->conf->ce_ppmcs_offset_cck;
+
+       if (cl_band_is_24g(cl_hw))
+               return ppmcs[mcs] + cl_hw->conf->ce_ppbw_offset[CHNL_BW_20]=
;
+
+       return 0;
+}
+
+s8 cl_power_offset_q1(struct cl_hw *cl_hw, u8 mode, u8 bw, u8 mcs)
+{
+       if (mode =3D=3D WRS_MODE_HE)
+               return cl_power_offset_he(cl_hw, bw, mcs);
+       else if (mode =3D=3D WRS_MODE_HT || mode =3D=3D WRS_MODE_VHT)
+               return cl_power_offset_ht_vht(cl_hw, bw, mcs);
+       else if (mode =3D=3D WRS_MODE_OFDM)
+               return cl_power_offset_ofdm(cl_hw, mcs);
+       else if (mode =3D=3D WRS_MODE_CCK)
+               return cl_power_offset_cck(cl_hw, mcs);
+
+       return 0;
+}
+
+#define UPPER_POWER_MARGIN_Q2 (38 << 2)
+#define LOWER_POWER_MARGIN_Q2 (50 << 2)
+
+s8 cl_power_offset_check_margin(struct cl_hw *cl_hw, u8 bw, u8 ant_idx, s8=
 offset_q2)
+{
+       s8 new_offset_q2 =3D 0;
+       s8 bw_factor_q2 =3D cl_hw->power_db.bw_factor_q2[bw];
+       s8 ant_factor_q2 =3D cl_hw->power_db.ant_factor_q2[ant_idx];
+       s8 total_offset_upper_q2 =3D bw_factor_q2 + offset_q2;
+       s8 total_offset_lower_q2 =3D bw_factor_q2 + ant_factor_q2 + offset_=
q2;
+       bool upper_limit_valid =3D (total_offset_upper_q2 <=3D UPPER_POWER_=
MARGIN_Q2);
+       bool lower_limit_valid =3D (total_offset_lower_q2 <=3D LOWER_POWER_=
MARGIN_Q2);
+
+       if (upper_limit_valid && lower_limit_valid) {
+               return offset_q2;
+       } else if (!upper_limit_valid && lower_limit_valid) {
+               new_offset_q2 =3D UPPER_POWER_MARGIN_Q2 - bw_factor_q2;
+
+               return new_offset_q2;
+       } else if (upper_limit_valid && !lower_limit_valid) {
+               new_offset_q2 =3D LOWER_POWER_MARGIN_Q2 - bw_factor_q2 - an=
t_factor_q2;
+
+               return new_offset_q2;
+       }
+
+       new_offset_q2 =3D min(UPPER_POWER_MARGIN_Q2 - bw_factor_q2,
+                           LOWER_POWER_MARGIN_Q2 - bw_factor_q2 - ant_fact=
or_q2);
+
+       return new_offset_q2;
+}
+
+static void cl_power_tables_update_cck(struct cl_hw *cl_hw,
+                                      struct cl_pwr_tables *pwr_tables)
+{
+       u8 mcs;
+       u8 trunc_value =3D 0;
+       s8 pwr_offset_q1;
+
+       /* CCK - Enforce EIRP limitations */
+       for (mcs =3D 0; mcs < WRS_MCS_MAX_CCK; mcs++) {
+               pwr_offset_q1 =3D cl_power_offset_q1(cl_hw, WRS_MODE_CCK, C=
HNL_BW_20, mcs);
+
+               pwr_tables->ant_pwr_cck[mcs] =3D
+                       cl_power_calc_q1(cl_hw, pwr_offset_q1, 0, 0,
+                                        WRS_MODE_CCK, false, &trunc_value)=
;
+
+               cl_hw->pwr_trunc.cck[mcs] =3D trunc_value;
+
+               /* Auto response */
+               pwr_tables->pwr_auto_resp_cck[mcs] =3D
+                       cl_power_calc_q1(cl_hw, pwr_offset_q1, 0, 0,
+                                        WRS_MODE_CCK, true, &trunc_value);
+       }
+}
+
+static void cl_power_tables_update_ofdm(struct cl_hw *cl_hw,
+                                       struct cl_pwr_tables *pwr_tables)
+{
+       u8 mcs;
+       u8 trunc_value =3D 0;
+       s8 pwr_offset_q1;
+
+       /* OFDM - Enforce EIRP limitations */
+       for (mcs =3D 0; mcs < WRS_MCS_MAX_OFDM; mcs++) {
+               pwr_offset_q1 =3D cl_power_offset_q1(cl_hw, WRS_MODE_OFDM, =
CHNL_BW_20, mcs);
+
+               pwr_tables->ant_pwr_ofdm[mcs] =3D
+                       cl_power_calc_q1(cl_hw, pwr_offset_q1, 0, 0,
+                                        WRS_MODE_OFDM, false, &trunc_value=
);
+
+               cl_hw->pwr_trunc.ofdm[mcs] =3D trunc_value;
+
+               /* Auto response */
+               pwr_tables->pwr_auto_resp_ofdm[mcs] =3D
+                       cl_power_calc_q1(cl_hw, pwr_offset_q1, 0, 0,
+                                        WRS_MODE_OFDM, true, &trunc_value)=
;
+       }
+}
+
+static u8 cl_power_tables_update_ht_vht(struct cl_hw *cl_hw,
+                                       struct cl_pwr_tables *pwr_tables)
+{
+       bool is_24g =3D cl_band_is_24g(cl_hw);
+       bool is_5g =3D cl_band_is_5g(cl_hw);
+       u8 bw;
+       u8 nss;
+       u8 mcs;
+       u8 trunc_value =3D 0;
+       u8 min_bw_idx_limit_vht =3D 0;
+       u8 max_mcs_ht_vht =3D (is_5g || (is_24g && cl_hw->conf->ci_vht_cap_=
24g)) ?
+               WRS_MCS_MAX_VHT : WRS_MCS_MAX_HT;
+       s8 pwr_offset_q1;
+       s16 min_bw_limit =3D 0;
+       s32 eirp_power_limit_q8;
+
+       for (bw =3D 0, min_bw_limit =3D 0xFFFF; bw < max_bw_idx(WRS_MODE_VH=
T, is_24g); bw++) {
+               if (!cl_hw->chip->conf->ce_production_mode &&
+                   !cl_chan_info_get(cl_hw, cl_hw->channel, bw))
+                       continue;
+
+               /* Find lowest EIRP power limitation among all bw for auto =
resp calculations */
+               eirp_power_limit_q8 =3D cl_chan_info_get_eirp_limit_q8(cl_h=
w, bw);
+               if (eirp_power_limit_q8 < min_bw_limit) {
+                       min_bw_limit =3D eirp_power_limit_q8;
+                       min_bw_idx_limit_vht =3D bw;
+               }
+
+               /* HT/VHT - Enforce EIRP limitations */
+               for (mcs =3D 0; mcs < max_mcs_ht_vht; mcs++) {
+                       pwr_offset_q1 =3D cl_power_offset_q1(cl_hw, WRS_MOD=
E_VHT, bw, mcs);
+
+                       for (nss =3D 0; nss < PWR_TBL_VHT_BF_SIZE; nss++) {
+                               pwr_tables->ant_pwr_ht_vht[bw][mcs][nss] =
=3D
+                                       cl_power_calc_q1(cl_hw, pwr_offset_=
q1,
+                                                        bw, nss, WRS_MODE_=
VHT, false,
+                                                        &trunc_value);
+                               cl_hw->pwr_trunc.ht_vht[bw][mcs][nss] =3D t=
runc_value;
+                       }
+               }
+       }
+
+       /* Auto resp HT/VHT - Enforce EIRP limitations */
+       for (mcs =3D 0; mcs < max_mcs_ht_vht; mcs++) {
+               pwr_offset_q1 =3D cl_power_offset_q1(cl_hw, WRS_MODE_VHT, C=
HNL_BW_20, mcs);
+
+               pwr_tables->pwr_auto_resp_ht_vht[mcs] =3D
+                       cl_power_calc_q1(cl_hw, pwr_offset_q1,
+                                        min_bw_idx_limit_vht, 0, WRS_MODE_=
VHT,
+                                        true, &trunc_value);
+       }
+
+       return min_bw_idx_limit_vht;
+}
+
+static u8 cl_power_tables_update_he(struct cl_hw *cl_hw,
+                                   struct cl_pwr_tables *pwr_tables)
+{
+       bool is_24g =3D cl_band_is_24g(cl_hw);
+       u8 bw;
+       u8 nss;
+       u8 mcs;
+       u8 trunc_value =3D 0;
+       u8 min_bw_idx_limit_he =3D 0;
+       s8 pwr_offset_q1;
+       s16 min_bw_limit =3D 0;
+       s32 eirp_power_limit_q8;
+
+       for (bw =3D 0, min_bw_limit =3D 0xFFFF; bw < max_bw_idx(WRS_MODE_HE=
, is_24g); bw++) {
+               if (!cl_hw->chip->conf->ce_production_mode &&
+                   !cl_chan_info_get(cl_hw, cl_hw->channel, bw))
+                       continue;
+
+               /* Find lowest EIRP power limitation among all bw for auto =
resp calculations */
+               eirp_power_limit_q8 =3D cl_chan_info_get_eirp_limit_q8(cl_h=
w, bw);
+               if (eirp_power_limit_q8 < min_bw_limit) {
+                       min_bw_limit =3D eirp_power_limit_q8;
+                       min_bw_idx_limit_he =3D bw;
+               }
+
+               /* HE - Enforce EIRP limitations */
+               for (mcs =3D 0; mcs < WRS_MCS_MAX_HE; mcs++) {
+                       pwr_offset_q1 =3D cl_power_offset_q1(cl_hw, WRS_MOD=
E_HE, bw, mcs);
+
+                       for (nss =3D 0; nss < PWR_TBL_HE_BF_SIZE; nss++) {
+                               pwr_tables->ant_pwr_he[bw][mcs][nss] =3D
+                                       cl_power_calc_q1(cl_hw, pwr_offset_=
q1,
+                                                        bw, nss, WRS_MODE_=
HE, false,
+                                                        &trunc_value);
+                               cl_hw->pwr_trunc.he[bw][mcs][nss] =3D trunc=
_value;
+                       }
+               }
+       }
+
+       /* Auto resp HE - Enforce EIRP limitations */
+       for (mcs =3D 0; mcs < WRS_MCS_MAX_HE; mcs++) {
+               pwr_offset_q1 =3D cl_power_offset_q1(cl_hw, WRS_MODE_HE, CH=
NL_BW_20, mcs);
+
+               pwr_tables->pwr_auto_resp_he[mcs] =3D
+                       cl_power_calc_q1(cl_hw, pwr_offset_q1, min_bw_idx_l=
imit_he,
+                                        nss, WRS_MODE_HE, true, &trunc_val=
ue);
+       }
+
+       return min_bw_idx_limit_he;
+}
+
+static u8 cl_power_calc_max(struct cl_hw *cl_hw, u8 bw, enum cl_wrs_mode m=
ode)
+{
+       u8 tx_ant =3D cl_power_tx_ant(cl_hw, mode);
+       /* Total TX power - pass is_auto_resp =3D true in order to ignore b=
f gain */
+       s32 total_power_q8 =3D cl_power_total_q8(cl_hw, 0, tx_ant, 0, mode,=
 true);
+       /* EIRP power limit */
+       s32 eirp_power_limit_q8 =3D cl_chan_info_get_eirp_limit_q8(cl_hw, b=
w);
+
+       return (min(total_power_q8, eirp_power_limit_q8) >> 8);
+}
+
+static s8 cl_power_vns_calc_q1(struct cl_hw *cl_hw, u8 bw,
+                              enum cl_wrs_mode mode, bool is_auto_resp)
+{
+       u8 max_tx_pwr =3D cl_power_calc_max(cl_hw, bw, mode);
+       u8 tx_ant =3D cl_power_tx_ant(cl_hw, mode);
+       s32 vns_pwr_limit_q8 =3D min_t(u8, cl_hw->conf->ci_vns_pwr_limit, m=
ax_tx_pwr) << 8;
+       s32 antenna_gain_q8 =3D cl_power_antenna_gain_q8(cl_hw);
+       s32 array_gain_q8 =3D (is_auto_resp ? 0 : cl_power_array_gain_q8(cl=
_hw, tx_ant));
+       s32 min_ant_pwr_q8 =3D cl_power_min_ant_q8(cl_hw);
+       s32 min_pwr_q8 =3D is_auto_resp ? (POWER_MIN_DB_Q8 + min_ant_pwr_q8=
) : POWER_MIN_DB_Q8;
+       s32 res_q8 =3D vns_pwr_limit_q8 - antenna_gain_q8 - array_gain_q8;
+
+       if (res_q8 < min_pwr_q8)
+               res_q8 =3D min_pwr_q8;
+
+       /* Result should be in 0.5dBm resolution */
+       return (s8)(res_q8 >> 7);
+}
+
+static void cl_power_tables_update_vns(struct cl_hw *cl_hw,
+                                      struct cl_pwr_tables *pwr_tables,
+                                      u8 min_bw_idx_limit_vht,
+                                      u8 min_bw_idx_limit_he)
+{
+       /* VNS */
+       pwr_tables->ant_pwr_vns_he =3D
+               cl_power_vns_calc_q1(cl_hw, min_bw_idx_limit_he, WRS_MODE_H=
E, false);
+       pwr_tables->ant_pwr_vns_ht_vht =3D
+               cl_power_vns_calc_q1(cl_hw, min_bw_idx_limit_vht, WRS_MODE_=
VHT, false);
+       pwr_tables->ant_pwr_vns_ofdm =3D
+               cl_power_vns_calc_q1(cl_hw, 0, WRS_MODE_OFDM, false);
+       pwr_tables->ant_pwr_vns_cck =3D
+               cl_power_vns_calc_q1(cl_hw, 0, WRS_MODE_CCK, false);
+
+       /* Auto response VNS */
+       pwr_tables->pwr_auto_resp_vns_he =3D
+               cl_power_vns_calc_q1(cl_hw, min_bw_idx_limit_he, WRS_MODE_H=
E, true);
+       pwr_tables->pwr_auto_resp_vns_ht_vht =3D
+               cl_power_vns_calc_q1(cl_hw, min_bw_idx_limit_vht, WRS_MODE_=
VHT, true);
+       pwr_tables->pwr_auto_resp_vns_ofdm =3D
+               cl_power_vns_calc_q1(cl_hw, 0, WRS_MODE_OFDM, true);
+       pwr_tables->pwr_auto_resp_vns_cck =3D
+               cl_power_vns_calc_q1(cl_hw, 0, WRS_MODE_CCK, true);
+}
+
+static void cl_power_tables_update_by_offset(struct cl_hw *cl_hw,
+                                            struct cl_pwr_tables *pwr_tabl=
es,
+                                            s8 offset)
+{
+       u8 mcs =3D 0;
+       u8 bw =3D 0;
+       u8 nss =3D 0;
+
+       /* CCK - Enforce EIRP limitations */
+       for (mcs =3D 0; mcs < WRS_MCS_MAX_CCK; mcs++) {
+               pwr_tables->ant_pwr_cck[mcs] +=3D offset;
+
+               /* Auto response */
+               pwr_tables->pwr_auto_resp_cck[mcs] +=3D offset;
+       }
+
+       /* OFDM - Enforce EIRP limitations */
+       for (mcs =3D 0; mcs < WRS_MCS_MAX_OFDM; mcs++) {
+               pwr_tables->ant_pwr_ofdm[mcs] +=3D offset;
+
+               /* Auto response */
+               pwr_tables->pwr_auto_resp_ofdm[mcs] +=3D offset;
+       }
+
+       for (bw =3D 0; bw < CHNL_BW_MAX; bw++) {
+               /* HT/VHT - Enforce EIRP limitations */
+               for (mcs =3D 0; mcs < WRS_MCS_MAX_VHT; mcs++) {
+                       for (nss =3D 0; nss < PWR_TBL_VHT_BF_SIZE; nss++)
+                               pwr_tables->ant_pwr_ht_vht[bw][mcs][nss] +=
=3D offset;
+
+                       /*
+                        * Auto response:
+                        * always with disabled BF so the offset of the las=
t nss is used
+                        */
+                       pwr_tables->pwr_auto_resp_ht_vht[mcs] +=3D offset;
+               }
+
+               /* HE - Enforce EIRP limitations */
+               for (mcs =3D 0; mcs < WRS_MCS_MAX_HE; mcs++) {
+                       for (nss =3D 0; nss < PWR_TBL_HE_BF_SIZE; nss++)
+                               pwr_tables->ant_pwr_he[bw][mcs][nss] +=3D o=
ffset;
+
+                       /*
+                        * Auto response:
+                        * always with disabled BF so the offset of the las=
t nss is used
+                        */
+                       pwr_tables->pwr_auto_resp_he[mcs] +=3D offset;
+               }
+       }
+}
+
+static s8 cl_power_get_offset(u16 percentage)
+{
+       if (percentage >=3D 94)
+               return 0;
+       else if (percentage >=3D 84)
+               return -1; /* -0.5dBm */
+       else if (percentage >=3D 75)
+               return -2; /* -1dBm */
+       else if (percentage >=3D 67)
+               return -3; /* -1.5dBm */
+       else if (percentage >=3D 59)
+               return -4; /* -2dBm */
+       else if (percentage >=3D 54)
+               return -5; /* -2.5dBm */
+       else if (percentage >=3D 48)
+               return -6; /* -3dBm */
+       else if (percentage >=3D 43)
+               return -7; /* -3.5dBm */
+       else if (percentage >=3D 38)
+               return -8; /* -4dBm */
+       else if (percentage >=3D 34)
+               return -9; /* -4.5dBm */
+       else if (percentage >=3D 30)
+               return -10; /* -5dBm */
+       else if (percentage >=3D 27)
+               return -11; /* -5.5dBm */
+       else if (percentage >=3D 24)
+               return -12; /* -6dBm */
+       else if (percentage >=3D 22)
+               return -13; /* -6.5dBm */
+       else if (percentage >=3D 19)
+               return -14; /* -7dBm */
+       else if (percentage >=3D 17)
+               return -15; /* -7.5dBm */
+       else if (percentage >=3D 15)
+               return -16; /* -8dBm */
+       else if (percentage >=3D 14)
+               return -17; /* -8.5dBm */
+       else if (percentage >=3D 12)
+               return -18; /* -9dBm */
+       else if (percentage >=3D 11)
+               return -19; /* -9.5dBm */
+       else if (percentage >=3D 10)
+               return -20; /* -10dBm */
+       else if (percentage >=3D 9)
+               return -21; /* -10.5dBm */
+       else if (percentage >=3D 8)
+               return -22; /* -11dBm */
+       else if (percentage >=3D 7)
+               return -23; /* -11.5dBm */
+       else if (percentage >=3D 6)
+               return -24; /* -12dBm */
+       else if (percentage >=3D 5)
+               return -26; /* -13dBm */
+       else if (percentage >=3D 4)
+               return -28; /* -14dBm */
+       else if (percentage >=3D 3)
+               return -30; /* -15dBm */
+       else if (percentage >=3D 2)
+               return -34; /* -17dBm */
+       else if (percentage >=3D 1)
+               return -40; /* -20dBm */
+
+       /* Should not get here */
+       return 0;
+}
+
+static void cl_power_control_apply_percentage(struct cl_hw *cl_hw)
+{
+       struct cl_power_db *power_db =3D &cl_hw->power_db;
+       u8 percentage =3D cl_hw->conf->ce_tx_power_control;
+
+       power_db->curr_percentage =3D percentage;
+
+       if (percentage !=3D 100) {
+               power_db->curr_offset =3D cl_power_get_offset(percentage);
+               cl_power_tables_update_by_offset(cl_hw,
+                                                &cl_hw->phy_data_info.data=
->pwr_tables,
+                                                power_db->curr_offset);
+       }
+}
+
+void cl_power_tables_update(struct cl_hw *cl_hw, struct cl_pwr_tables *pwr=
_tables)
+{
+       bool is_24g =3D cl_band_is_24g(cl_hw);
+       bool is_6g =3D cl_band_is_6g(cl_hw);
+       u8 min_bw_idx_limit_he =3D 0;
+       u8 min_bw_idx_limit_vht =3D 0;
+
+       /*
+        * If tx_power is set then we are in calibration process and
+        * need to set all values in power tables to this value x2.
+        */
+       if (cl_hw->ate_db.active &&
+           cl_hw->ate_db.tx_power >=3D POWER_MIN_DB &&
+           cl_hw->ate_db.tx_power <=3D POWER_MAX_DB) {
+               s8 tx_power_q1 =3D cl_hw->ate_db.tx_power << 1;
+
+               memset(pwr_tables, tx_power_q1, sizeof(struct cl_pwr_tables=
));
+               return;
+       }
+
+       memset(pwr_tables, 0, sizeof(struct cl_pwr_tables));
+
+       if (is_24g)
+               cl_power_tables_update_cck(cl_hw, pwr_tables);
+
+       if (!is_6g) {
+               cl_power_tables_update_ofdm(cl_hw, pwr_tables);
+               min_bw_idx_limit_vht =3D cl_power_tables_update_ht_vht(cl_h=
w, pwr_tables);
+       }
+
+       min_bw_idx_limit_he =3D cl_power_tables_update_he(cl_hw, pwr_tables=
);
+
+       cl_power_tables_update_vns(cl_hw, pwr_tables, min_bw_idx_limit_vht,=
 min_bw_idx_limit_he);
+
+       cl_power_control_apply_percentage(cl_hw);
+}
+
+static s32 cl_power_get_max_cck(struct cl_hw *cl_hw)
+{
+       struct cl_pwr_tables *pwr_tables =3D &cl_hw->phy_data_info.data->pw=
r_tables;
+       u8 mcs =3D 0;
+       u8 tx_ant =3D cl_power_tx_ant(cl_hw, WRS_MODE_CCK);
+       s32 ant_gain_q1 =3D cl_power_antenna_gain_q1(cl_hw);
+       s32 arr_gain_q1 =3D cl_power_array_gain_q1(cl_hw, tx_ant);
+       s32 total_pwr_q1 =3D 0;
+       s32 max_pwr_q1 =3D 0;
+
+       for (mcs =3D 0; mcs < WRS_MCS_MAX_CCK; mcs++) {
+               total_pwr_q1 =3D pwr_tables->ant_pwr_cck[mcs] + ant_gain_q1=
 + arr_gain_q1;
+
+               if (total_pwr_q1 > max_pwr_q1)
+                       max_pwr_q1 =3D total_pwr_q1;
+       }
+
+       return max_pwr_q1;
+}
+
+static s32 cl_power_get_max_ofdm(struct cl_hw *cl_hw)
+{
+       struct cl_pwr_tables *pwr_tables =3D &cl_hw->phy_data_info.data->pw=
r_tables;
+       u8 mcs =3D 0;
+       u8 tx_ant =3D cl_power_tx_ant(cl_hw, WRS_MODE_OFDM);
+       s32 ant_gain_q1 =3D cl_power_antenna_gain_q1(cl_hw);
+       s32 arr_gain_q1 =3D cl_power_array_gain_q1(cl_hw, tx_ant);
+       s32 total_pwr_q1 =3D 0;
+       s32 max_pwr_q1 =3D 0;
+
+       for (mcs =3D 0; mcs < WRS_MCS_MAX_OFDM; mcs++) {
+               total_pwr_q1 =3D pwr_tables->ant_pwr_ofdm[mcs] + ant_gain_q=
1 + arr_gain_q1;
+
+               if (total_pwr_q1 > max_pwr_q1)
+                       max_pwr_q1 =3D total_pwr_q1;
+       }
+
+       return max_pwr_q1;
+}
+
+static s32 cl_power_get_max_ht_vht(struct cl_hw *cl_hw)
+{
+       struct cl_pwr_tables *pwr_tables =3D &cl_hw->phy_data_info.data->pw=
r_tables;
+       u8 tx_ant =3D cl_power_tx_ant(cl_hw, WRS_MODE_VHT);
+       u8 mcs =3D 0;
+       u8 bw =3D 0;
+       u8 bf =3D 0;
+       s32 ant_gain_q1 =3D cl_power_antenna_gain_q1(cl_hw);
+       s32 arr_gain_q1 =3D cl_power_array_gain_q1(cl_hw, tx_ant);
+       s32 total_pwr_q1 =3D 0;
+       s32 max_pwr_q1 =3D 0;
+
+       for (bw =3D 0; bw < CHNL_BW_MAX; bw++) {
+               for (mcs =3D 0; mcs < WRS_MCS_MAX_VHT; mcs++) {
+                       for (bf =3D 0; bf < PWR_TBL_VHT_BF_SIZE; bf++) {
+                               total_pwr_q1 =3D pwr_tables->ant_pwr_ht_vht=
[bw][mcs][bf] +
+                                       ant_gain_q1 + arr_gain_q1;
+
+                               if (total_pwr_q1 > max_pwr_q1)
+                                       max_pwr_q1 =3D total_pwr_q1;
+                       }
+               }
+       }
+
+       return max_pwr_q1;
+}
+
+static s32 cl_power_get_max_he(struct cl_hw *cl_hw)
+{
+       struct cl_pwr_tables *pwr_tables =3D &cl_hw->phy_data_info.data->pw=
r_tables;
+       u8 tx_ant =3D cl_power_tx_ant(cl_hw, WRS_MODE_HE);
+       u8 mcs =3D 0;
+       u8 bw =3D 0;
+       u8 bf =3D 0;
+       s32 ant_gain_q1 =3D cl_power_antenna_gain_q1(cl_hw);
+       s32 arr_gain_q1 =3D cl_power_array_gain_q1(cl_hw, tx_ant);
+       s32 total_pwr_q1 =3D 0;
+       s32 max_pwr_q1 =3D 0;
+
+       for (bw =3D 0; bw < CHNL_BW_MAX; bw++) {
+               for (mcs =3D 0; mcs < WRS_MCS_MAX_HE; mcs++) {
+                       for (bf =3D 0; bf < PWR_TBL_HE_BF_SIZE; bf++) {
+                               total_pwr_q1 =3D pwr_tables->ant_pwr_he[bw]=
[mcs][bf] +
+                                       ant_gain_q1 + arr_gain_q1;
+
+                               if (total_pwr_q1 > max_pwr_q1)
+                                       max_pwr_q1 =3D total_pwr_q1;
+                       }
+               }
+       }
+
+       return max_pwr_q1;
+}
+
+s32 cl_power_get_max(struct cl_hw *cl_hw)
+{
+       bool is_24g =3D cl_band_is_24g(cl_hw);
+       bool is_6g =3D cl_band_is_6g(cl_hw);
+       s32 max_pwr_cck_q1 =3D is_24g ? cl_power_get_max_cck(cl_hw) : S32_M=
IN;
+       s32 max_pwr_ofdm_q1 =3D !is_6g ? cl_power_get_max_ofdm(cl_hw) : S32=
_MIN;
+       s32 max_pwr_ht_vht_q1 =3D !is_6g ? cl_power_get_max_ht_vht(cl_hw) :=
 S32_MIN;
+       s32 max_pwr_he_q1 =3D cl_power_get_max_he(cl_hw);
+       s32 max_pwr_q1 =3D 0;
+
+       max_pwr_q1 =3D max(max_pwr_q1, max_pwr_cck_q1);
+       max_pwr_q1 =3D max(max_pwr_q1, max_pwr_ofdm_q1);
+       max_pwr_q1 =3D max(max_pwr_q1, max_pwr_ht_vht_q1);
+       max_pwr_q1 =3D max(max_pwr_q1, max_pwr_he_q1);
+
+       return (max_pwr_q1 >> 1);
+}
+
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

