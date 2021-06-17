Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9AA3AB88A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhFQQIs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:48 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:9431
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232040AbhFQQH5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7zjIfno8eUDccTCFnd8DwQqsPVFf/hbKQMQGYd0VIj6uzJFzKnC0wDxkQlwGkdTENwpMHH6GeuM5iAyUbczCvL3a8mXIlhMgmdilfnoMoeQatoSnInySTjT4pM/j+/438SpgPNG6aKnzHW0gV0IEM1z1i/YWKTJaOzIQKMFZ09QnrFq0nWo321PLDD7dovuGkLY208kN6vCYRjX4h5H6MBcdUAnx7PB5aUBi2cimBqHmd2wOCP3bOuvqg7XMl82rk+7fultYfpVfIqiYRqGCRoQc+1Ft+f411zaSXX/5OoRsZcTunAjCdqUtyuJS/GOQRaAqdPswtzuNwW+WhiZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vatMcND/6pybaSlyoMoDi1hFmhpz0aoBNc7436a25s=;
 b=m8/ieLw/499X6mUW12dYh6j/cVWMR+ve3zbxXR89eZoXWkp9VgVfBRDJrLNMCgZdEKuSTAzLJNHRkYowkuxbGDRRdgnsxIKOZSFKdJiiLAOLGKiiSKaTGXbqrgIhL1SXlKwy5eoA1BckMdoM0J3T1Mdqs+zc0D8FL5HaoLvZ1yt5kFAGG8jX3VFq4ZZNwugX62OVMx1jXRnMMg8x0Zun+dc+jgm+dWZmIKvKP9DxK32RJLtKzHuYfrmIP7KXOxaLcWhxPkV9/80ThoA/f2GvThs+Bd95wKvoCt3fpMRQQ5X8MZTKjTMtlAHJx4s3liBt5yuu4wLfUNXXYnC8giTZOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vatMcND/6pybaSlyoMoDi1hFmhpz0aoBNc7436a25s=;
 b=x2lCcZHGWD/+3dkJK2kjNuvmDzAPABhuQYAQwblTQ85Jyl0nPA0T74iSWucxbOQ8yDncDHGxwnsUunio8cysryHbdrgSVypC81umF03aYp0UGW0Hr5qhqRZ6Kl14pUGVrgakd7RoVwuvVRTgyo3L+zPkfE8DL4lTFE3Oqa0vpHA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1268.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:04:23 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:23 +0000
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
Subject: [RFC v1 073/256] cl8k: add enhanced_tim.c
Date:   Thu, 17 Jun 2021 15:59:20 +0000
Message-Id: <20210617160223.160998-74-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2212fda1-ef4e-4008-a5ed-08d931a98199
X-MS-TrafficTypeDiagnostic: AM9P192MB1268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1268CAE162FE9770EC6B5988F60E9@AM9P192MB1268.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ptJxmvKUYYapQSj3UxGEwpApjTVMzXwFySda59jueaZMQhZfuHxHPWo7nK/bae/xjpu1R6YxIm+7kFtsRBGIs6XtlJvZ7GvbtjBEeb1DhfGf8LAyLTR9CvXi4BgoN6lF2Rg1BRanicCROMnb/NNSmPYpkWlmD9xxXdS3Lxf4HHEMbMIKJXuBKOTwiS4/XYyr5bisElE4bNRyoNedYh1QRY4+HXdikRNlYSrcgEaentPSyF3B53zP7zmgZ25ndHbivJvSfDO4Pan5d0+gCEb7Z4RP3XRnDa7PjQqKvVydetNnDfLGEEW5VL2eNHBQz/hrfZn/Puv3OxDTBUrIAN4ug1MxM3RxdK225+klc6dgi1G+FtNrWrq38NzdBg9c/jECzThvJzB4ptFRGVnL+H2gW6E0QRJU2NmJYsRiJ37FwM5uTGw1TFl93NAGvCyoXbwnFNX7ap2DhCYg0NA2gIiIN9jsPYMC7kQjUaHtzS5ZiuES1/34smAlALrwknmcYkPz7nO53U9B3OZofu680OqPebZN/6ob6/1D6zdw3OkjUfA53wgMLY/TEtVQKmSU/Bibedicd54U2MrKZvcJUDIuNPXyN6ZnnIFRDyZiWgkOUh4tfCJF78lb+BmDZs400eKbBs8slbfoRW0WRLjCQsfWRlRnKHCc2XaJx5CaC+4Nu7a/3h0IBDEOy9MsluTBqt440cJI3twMfm7S5pOJa6TsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(39850400004)(136003)(376002)(6486002)(956004)(54906003)(4326008)(2616005)(186003)(38100700002)(16526019)(8676002)(5660300002)(38350700002)(8936002)(26005)(2906002)(6512007)(9686003)(52116002)(83380400001)(6916009)(66946007)(66556008)(66476007)(86362001)(55236004)(6666004)(6506007)(1076003)(107886003)(508600001)(316002)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y55SR2EHxFmbWTK1dnronUv0pDHGSbtCSN9q1o2LYoth4v2Nzw0axlgD1UPQ?=
 =?us-ascii?Q?10QZcLHRKKFOK2DO0UcARirYYxMWnVBhhmCQ59GBiSFvEOkGbr/B2ClMCPIe?=
 =?us-ascii?Q?vgNd0qCag3sOU86GRbipGm5IGK09E2qNJhkIHpkFIxl11rN2Oj02Wt5NPt6S?=
 =?us-ascii?Q?PxVZqU/nHAe7O0Nn7xenxticJtPbKcW1gdFQemar8W4GndpVVV5O8uyj1N5d?=
 =?us-ascii?Q?21eJAdNh7l/pQf2d96a+NouL2kCACpHbhPutP8pGYxkXHtEGS4wQ4nL0GDCD?=
 =?us-ascii?Q?KlyvdAQEjFE6Sr2CKMdJBSopHJjeRtLNfw2GNjCD0vYiCqhzEeuMBkMEpmqe?=
 =?us-ascii?Q?U56JbsTPRRKl2L4sH7n9yNak63I8j91+AGRxDt/tv6YxHf0/kontMkEZUGZz?=
 =?us-ascii?Q?z+3UH/x3v0AdspeqJ8dESf7PJSr+CsRP1cSIwC36TOdeJxgC2MnoFv/VbajV?=
 =?us-ascii?Q?iUkf8pTofYFZUQVsEK9FLyq1gOAQadpV2fh8nPPvce8OEXdYyHUkm9ZyGMy3?=
 =?us-ascii?Q?Og1kNwwvL8xAK8/e0tstCzvrEXffFWtIt96qFHh2f5qGli26uLywv06NHrtx?=
 =?us-ascii?Q?U44E1j/krWoCCQJYWTAzJSn3nO5ZfjyIwPTqP2m+D3+25e1PeFVKNVsWJVE8?=
 =?us-ascii?Q?tuDxr+kCRkBnINt0feLL4Dz2J0EKZUIkt0Oj01vkNvVJKJYKHl/2iMtuknxG?=
 =?us-ascii?Q?qkyNXTngs7d6uaMC/rCT+cgLfHK7Tu2h8jocqwyB6JuzH3EJkRJbiMsGBuJ6?=
 =?us-ascii?Q?m6/GF72iVFnuBUJlyB50b2o8/tOsD1BK93Ar8iY8w8LwgOwRnp92Gt0DvAYi?=
 =?us-ascii?Q?Mufz9XMsmlR1ywi7/fDhOzzstCFTk5+MlDZo3ScrVG+X4HdhFNP7L3Kh6Gyg?=
 =?us-ascii?Q?ZtyUU6gixaJuuaXC5K5EEBh2fp5Fun9up1aV0eliyF+y+hYav65hHJ567uu1?=
 =?us-ascii?Q?ZxuKcTSR5+H4mnd0+1Ua+csS19nnGxlOO7bMl4hD4jh+w3/qio6cLmnJgyfn?=
 =?us-ascii?Q?oQRxQG48RbEMe7d1N1Q6a3vTv6DJaPdZGG2HIpE6A/r5LG7mHrFkVZXRzqFx?=
 =?us-ascii?Q?iSeH2iHXhfoAdMM1erLjeLvd3oZHr1NeFiWPg3fZcUgOZTg6OwL3KXWpm1b6?=
 =?us-ascii?Q?VTWc8koxaBgzMrYe3cuoEYi4kxr64THVWElLYcrd6WY/d4ATo7wfaLedjU55?=
 =?us-ascii?Q?KOSJ2h9NVDhQPuJpf3cz6IWBcY+rjCeCQA3lnvYfT5+1c48z7Q15whWwwLPV?=
 =?us-ascii?Q?CKuvZoEec8eyK4uK43/1wu41YOcWWFRo7YSLIG7FGtchnjTiJi2S6aNTQrya?=
 =?us-ascii?Q?VNWplvHv3TdoedS5WEgZDXZz?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2212fda1-ef4e-4008-a5ed-08d931a98199
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:54.4574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W93P5DoIAymy/R9Tzz4i6iJPkcPY0VfjsME5DwoYyrRWbufdlKjC4Y2vDF8QzWiwPgkFZ1Y10aC6JYI1CntT/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1268
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/enhanced_tim.c   | 216 ++++++++++++++++++
 1 file changed, 216 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/enhanced_tim.c

diff --git a/drivers/net/wireless/celeno/cl8k/enhanced_tim.c b/drivers/net/=
wireless/celeno/cl8k/enhanced_tim.c
new file mode 100644
index 000000000000..da2a0cf547fc
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/enhanced_tim.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "enhanced_tim.h"
+#include "bus/pci/ipc.h"
+#include "utils/utils.h"
+
+/*
+ * The kernel's test_and_set_bit() gets unsigned long * as an argument, bu=
t we actually
+ * pass a pointer to u32, what cause to alignment fault in 64bit platforms=
.
+ * This function gets a pointer to u32 to prevent this alignment fault.
+ * Notice that the kernel's function sets the bit as an atomic operation,
+ * and our function doesn't. Vut it's not an issue since we set the bit fr=
om one context only.
+ */
+static int cl_test_and_set_bit(unsigned long nr, u32 *addr)
+{
+       u32 *new_addr, mask, old;
+
+       new_addr =3D ((u32 *)addr) + (nr >> 5);
+       mask =3D 1 << (nr & 31);
+       old =3D *new_addr & mask;
+       *new_addr |=3D mask;
+
+       return (old !=3D 0);
+}
+
+static int CFM_TEST_AND_CLEAR_BIT(unsigned long nr, u32 *addr)
+{
+       u32 *new_addr, mask, old;
+
+       new_addr =3D ((u32 *)addr) + (nr >> 5);
+       mask =3D 1 << (nr & 31);
+       old =3D *new_addr & mask;
+       *new_addr &=3D ~mask;
+
+       return (old !=3D 0);
+}
+
+void cl_enhanced_tim_reset(struct cl_hw *cl_hw)
+{
+       /*
+        * There is no need to reset cl_hw->ipc_env->shared->enhanced_tim.
+        * It is done as part of ipc_shared_env_init()
+        */
+       memset(&cl_hw->ipc_env->enhanced_tim, 0, sizeof(struct cl_ipc_enhan=
ced_tim));
+}
+
+/*
+ * NOTE: the UMAC DRAM starts with the enhanced TIM elements stractures.
+ * This is hard coded in the FW, this memory allocation should be changed =
in
+ * the driver module .ELF file.
+ */
+
+void cl_enhanced_tim_clear_tx_agg(struct cl_hw *cl_hw, u32 ipc_queue_idx,
+                                 u8 ac, struct cl_sta *cl_sta, u8 tid)
+{
+       /* Pointer to HOST enhanced TIM */
+       u32 *source =3D cl_hw->ipc_env->enhanced_tim.tx_rx_agg[ac];
+       u32 ipc_queue_idx_common =3D IPC_TX_QUEUE_IDX_TO_COMMON_QUEUE_IDX(i=
pc_queue_idx);
+       /*
+        * Does the UMAC enhanced TIM need update?
+        * If the TIM element is set then clear it and update the UMAC TIM =
element
+        */
+       if (CFM_TEST_AND_CLEAR_BIT(ipc_queue_idx_common, source)) {
+               /* Pointer to UMAC enhanced TIM */
+               u32 *target =3D (u32 *)cl_hw->ipc_env->shared->enhanced_tim=
.tx_rx_agg[ac];
+               /* Offset to UMAC encahned TIM array position */
+               u32 agg_offset =3D ipc_queue_idx_common / (BITS_PER_BYTE * =
sizeof(u32));
+
+               /* Update tim element */
+               if (cl_sta && test_sta_flag(cl_sta->stainfo, WLAN_STA_PS_ST=
A))
+                       ieee80211_sta_set_buffered(&cl_sta->stainfo->sta, t=
id,
+                                                  false);
+
+               target[agg_offset] =3D cpu_to_le32(source[agg_offset]);
+       }
+}
+
+void cl_enhanced_tim_clear_tx_single(struct cl_hw *cl_hw, u32 ipc_queue_id=
x, u8 ac,
+                                    bool no_ps_buffer, struct cl_sta *cl_s=
ta, u8 tid)
+{
+       /* Pointer to HOST enhanced TIM */
+       u32 *source =3D cl_hw->ipc_env->enhanced_tim.tx_single[ac];
+       /* Staton index: 0 - 128 (do not use cl_sta->sta_idx which is 0 -12=
7) */
+       u32 sta_idx =3D ipc_queue_idx % FW_MAX_NUM_STA;
+
+       /*
+        * Does the UMAC enhanced TIM need update?
+        * If the TIM element is set then clear it and update the UMAC TIM =
element
+        */
+       if (CFM_TEST_AND_CLEAR_BIT(sta_idx, source)) {
+               /* Pointer to UMAC enhanced TIM for singles or aggregation =
*/
+               u32 *target =3D (u32 *)cl_hw->ipc_env->shared->enhanced_tim=
.tx_single[ac];
+               /* Offset to UMAC encahned TIM array position */
+               u32 sta_offset =3D sta_idx / (BITS_PER_BYTE * sizeof(u32));
+
+               /* Update tim element */
+               if (!no_ps_buffer && cl_sta &&
+                   test_sta_flag(cl_sta->stainfo, WLAN_STA_PS_STA))
+                       ieee80211_sta_set_buffered(&cl_sta->stainfo->sta, t=
id,
+                                                  false);
+
+               target[sta_offset] =3D cpu_to_le32(source[sta_offset]);
+       }
+}
+
+void cl_enhanced_tim_set_tx_agg(struct cl_hw *cl_hw, u32 ipc_queue_idx, u8=
 ac,
+                               bool no_ps_buffer, struct cl_sta *cl_sta, u=
8 tid)
+{
+       /* Pointer to HOST enhanced TIM */
+       u32 *source =3D cl_hw->ipc_env->enhanced_tim.tx_rx_agg[ac];
+       u32 ipc_queue_idx_common =3D IPC_TX_QUEUE_IDX_TO_COMMON_QUEUE_IDX(i=
pc_queue_idx);
+       /*
+        * Does the UMAC enhanced TIM need update?
+        * If the TIM element is cleared then set it and update the UMAC TI=
M element
+        */
+       if (!cl_test_and_set_bit(ipc_queue_idx_common, source)) {
+               /* Pointer to UMAC enhanced TIM */
+               u32 *target =3D (u32 *)cl_hw->ipc_env->shared->enhanced_tim=
.tx_rx_agg[ac];
+               /* Offset to UMAC encahned TIM array position */
+               u32 agg_offset =3D ipc_queue_idx_common / (BITS_PER_BYTE * =
sizeof(u32));
+
+               /* Update tim element */
+               if (!no_ps_buffer && cl_sta &&
+                   test_sta_flag(cl_sta->stainfo, WLAN_STA_PS_STA))
+                       ieee80211_sta_set_buffered(&cl_sta->stainfo->sta, t=
id,
+                                                  true);
+
+               target[agg_offset] =3D cpu_to_le32(source[agg_offset]);
+       }
+}
+
+void cl_enhanced_tim_set_tx_single(struct cl_hw *cl_hw, u32 ipc_queue_idx,=
 u8 ac,
+                                  bool no_ps_buffer, struct cl_sta *cl_sta=
, u8 tid)
+{
+       /* Pointer to HOST enhanced TIM */
+       u32 *source =3D cl_hw->ipc_env->enhanced_tim.tx_single[ac];
+       /* Staton index: 0 - 128 (do not use cl_sta->sta_idx which is 0 -12=
7) */
+       u32 sta_idx =3D ipc_queue_idx % FW_MAX_NUM_STA;
+
+       /*
+        * Does the UMAC enhanced TIM need update?
+        * If the TIM element is cleared then set it and update the UMAC TI=
M element
+        */
+       if (!cl_test_and_set_bit(sta_idx, source)) {
+               /* Pointer to UMAC enhanced TIM */
+               u32 *target =3D (u32 *)cl_hw->ipc_env->shared->enhanced_tim=
.tx_single[ac];
+               /* Offset to UMAC encahned TIM array position */
+               u32 sta_offset =3D sta_idx / (BITS_PER_BYTE * sizeof(u32));
+
+               /* Update tim element */
+               if (!no_ps_buffer && cl_sta &&
+                   test_sta_flag(cl_sta->stainfo, WLAN_STA_PS_STA))
+                       ieee80211_sta_set_buffered(&cl_sta->stainfo->sta, t=
id,
+                                                  true);
+
+               target[sta_offset] =3D cpu_to_le32(source[sta_offset]);
+       }
+}
+
+void cl_enhanced_tim_clear_rx(struct cl_hw *cl_hw, u8 ac, u8 sta_idx)
+{
+       /* Pointer to HOST enhanced TIM */
+       u32 *source =3D cl_hw->ipc_env->enhanced_tim.tx_rx_agg[ac];
+       u32 ipc_queue_idx_common =3D IPC_RX_QUEUE_IDX_TO_COMMON_QUEUE_IDX(s=
ta_idx);
+       /*
+        * Does the UMAC enhanced TIM need update?
+        * If the TIM element is set then clear it and update the UMAC TIM =
element
+        */
+       if (CFM_TEST_AND_CLEAR_BIT(ipc_queue_idx_common, source)) {
+               /* Pointer to UMAC enhanced TIM for singles or aggregation =
*/
+               u32 *target =3D (u32 *)cl_hw->ipc_env->shared->enhanced_tim=
.tx_rx_agg[ac];
+               /* Offset to UMAC encahned TIM array position */
+               u32 sta_offset =3D ipc_queue_idx_common / (BITS_PER_BYTE * =
sizeof(u32));
+
+               target[sta_offset] =3D cpu_to_le32(source[sta_offset]);
+       }
+}
+
+void cl_enhanced_tim_set_rx(struct cl_hw *cl_hw, u8 ac, u8 sta_idx)
+{
+       /* Pointer to HOST enhanced TIM */
+       u32 *source =3D cl_hw->ipc_env->enhanced_tim.tx_rx_agg[ac];
+       u32 ipc_queue_idx_common =3D IPC_RX_QUEUE_IDX_TO_COMMON_QUEUE_IDX(s=
ta_idx);
+       /*
+        * Does the UMAC enhanced TIM need update?
+        * If the TIM element is cleared then set it and update the UMAC TI=
M element
+        */
+       if (!cl_test_and_set_bit(ipc_queue_idx_common, source)) {
+               /* Pointer to UMAC enhanced TIM */
+               u32 *target =3D (u32 *)cl_hw->ipc_env->shared->enhanced_tim=
.tx_rx_agg[ac];
+               /* Offset to UMAC encahned TIM array position */
+               u32 sta_offset =3D ipc_queue_idx_common / (BITS_PER_BYTE * =
sizeof(u32));
+
+               target[sta_offset] =3D cpu_to_le32(source[sta_offset]);
+
+               cl_hw->ipc_host2xmac_trigger_set(cl_hw->chip, BIT(IPC_IRQ_A=
2E_RX_STA_MAP(ac)));
+       }
+}
+
+void cl_enhanced_tim_clear_rx_sta(struct cl_hw *cl_hw, u8 sta_idx)
+{
+       u8 ac;
+
+       for (ac =3D 0; ac < AC_MAX; ac++)
+               cl_enhanced_tim_clear_rx(cl_hw, ac, sta_idx);
+}
+
+void cl_enhanced_tim_set_rx_sta(struct cl_hw *cl_hw, u8 sta_idx)
+{
+       u8 ac;
+
+       for (ac =3D 0; ac < AC_MAX; ac++)
+               cl_enhanced_tim_set_rx(cl_hw, ac, sta_idx);
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

