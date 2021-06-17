Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6E03AB925
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhFQQNA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:00 -0400
Received: from mail-db8eur05on2086.outbound.protection.outlook.com ([40.107.20.86]:16332
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230217AbhFQQLw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJEiY5LJswmpWDJhCJ9NDKeN9M16Wjo8uZtCWXh2kX7e5JwLOkUcX3uHPw3We5ZItIHftxgXCPf+491RREtLUGp+y+nslLuLajZyfLRnr9c/l5eh8imZ3xaQ1YDlUzJXRE2MUf2TaQk1YBDAIchBOdGeUV+11AsZeRBh7oNxjZU5Br4CmJRgF270AOazky52jmhHtykJsuzm52PGeET+J9aGIclTqlXeCr4htNZVPg1gFfEtrYIRrXjkDmwNCyXYiWku0BPUtcr3TTG7FULtz0RrVaSLWCXH+XSr3OKX3HIhd68DB1qp1+z87u4HqvBsr2n4T0ZbCzvFpi3sHf4Yxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+sKn+IBIl9t3EzrOFHEfnmXz78vkWYmRl8Dsj/yXn0=;
 b=BNY6KSan5Zfk/ovVTbx2QOPguYEPZkw46jTo0Co0E5YpcGB8dzIl3+SaFcQulDRlJdw1CKlfoECwLBqaIkL42l3k/q3GLKiWEPj/oXPyi2O8VRvPTi1wKifoJ22wOeNec1YyaypmyQu4vOXt0f5rTNqcclToYuFWJ4HIHBUzzv1u/a/D8Wgg0OH7V1YKV9/qC+i8Nz0kzyeVWRVMiSVmFBUXuRWVWPKiDT07doawRvI9K1YKFmUPHuELN/j4fBzHMU59ch4nd3R9mEo7xu+R5KWdLw7zHp8zAzHg/lw+PHpSdTo1qMi98FtefZmlnftZpfyegkJLggqPBhuETbV6Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+sKn+IBIl9t3EzrOFHEfnmXz78vkWYmRl8Dsj/yXn0=;
 b=cuIExpIDeKZudi/1mfjUG6ErnHBwoD5isJ0iJtOYy5UctFBhCcZP5fXzttZ8deayuxH8WEEZxnZiDdZm/g6E0GXNwi9wiooXEwpXGRQ78eZSlVjWtZqqVIYAMToZ5WNeJSpeqOY3LRtS8t/i+9+MaFLfWRwoH31S7gg+/AwmUM0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1014.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:08:37 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:08:37 +0000
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
Subject: [RFC v1 254/256] cl8k: add wrs/wrs_tables.c
Date:   Thu, 17 Jun 2021 16:02:21 +0000
Message-Id: <20210617160223.160998-255-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:07:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da3763cc-5174-4b94-d383-08d931a9fb45
X-MS-TrafficTypeDiagnostic: AM9P192MB1014:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB10144700788CBD379E671C36F60E9@AM9P192MB1014.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jwe5sO0/ubQFGEodEENYEFWT5lsqfG1sgEg2AiyHNm80HRQVmPbq7A5vxws8Ou36sAPqmIYNed8HHLOAWrhBp6WQfPmTLNZJzpf93+/7FEcbFDhlhNDiuJdE5/r2qFYUuxsoV47QlbBcsh3tWeLr7eeZPuiCLtVvb/eFnvL/gsJ+BTNMi8laVGmw3Oops5VEfRyPOwo7eZGz6wqx8d+VchxqkWjXjA+972v0b53+aMF6zUDsS+f6RwYL75g6b50fVu2pAg8ElWbTWDwAycS4kDFsSNqn6oauiBOGJJBjQwNBQDpyqH4YY6fmmy9dwemvCkaHr77eXF8h479dIzl2eDCJewlDzW24965gbtWt+kgwFK5JP0MYWzYM7T53EVPiNtFFDEwFM5f4lecjXCfEeT1x07P5VI0t2IAkQPg/QTfGLmVA8h1PWV6mTervPhAnGAx27RWoouvT+H6wgknurBT3Tivnkt/RNF1xnrHYwEZvprtCFMUxDgPhZ+cw51yyyZiKkx8jLae/nFH4r/Atkw4Lp7+sMlGPso8i6JkxOnWCFXmEp0Q9SBnUhSHLWdVYh6cKTGHiXjxJqEparJjQ7EOooHZlL8mZWQrQ4C5moOLTfJJrzyiwCLCqGqmRckzptSDEeuk8Z0Hr54j/cKN7fet/42hqbxkoKFmAfE09UU8Xt0Cjtg+kwiVK/EQk1GEmYsptDSrnOucrIi54lWgsAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39850400004)(346002)(376002)(396003)(136003)(316002)(86362001)(66946007)(54906003)(4326008)(956004)(55236004)(66556008)(66476007)(508600001)(36756003)(8676002)(26005)(2616005)(6666004)(5660300002)(6506007)(107886003)(6916009)(83380400001)(30864003)(2906002)(52116002)(1076003)(16526019)(38350700002)(38100700002)(6486002)(8936002)(186003)(9686003)(6512007)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wFUEmqJtHXojhhSTOEzSfllnU+daE6OhCPEA8J1OQ9qhAmCt1VQ3aIO3pIfU?=
 =?us-ascii?Q?f0f1lwoEF7tZUe3aYvRhYRgmRZ4i7H7w9Sm37Ns9/pQdx7wbSsFqTciz0Gqh?=
 =?us-ascii?Q?VlfSucMP7AMF6/AFxSUDpGifyiQvw1sRAidmLCWRdKLaqdxKIerl6eB+NaNq?=
 =?us-ascii?Q?5sz/6VXUO1B9lgnOA6CQsOViHHz+G9NWUDRdHCv+z3vvqqF6U0qB0o1S0XQe?=
 =?us-ascii?Q?Ga4POqX5O54ugYzfOHkEcjhFZwUn37T0bbO80GCfijXwEy+AwIUHB4kWfNUV?=
 =?us-ascii?Q?z8CAE/Tv122zh0jCWHFHCDdLkxRReYwSiiuuf5hZdp0BRirGHCs2vT8edMwh?=
 =?us-ascii?Q?e6VhWmbgtZEkQc6sR6xRgV5NumL2nzLtjll9aPb32mH7/5HPUpUaK9Q3xtYf?=
 =?us-ascii?Q?wzImXWVimhtRAJcON33z/4DxOLHzNmIyHFc/DeHMKx4qzIe0uc0ZLfE2JtLS?=
 =?us-ascii?Q?ubQ+HfFIdN0ZPw0Hm5Pqst68cogwy+Kdbcj6Wd2t/jldVAsK3RmwMlw2pOss?=
 =?us-ascii?Q?QPGuA3M95TEFm/SyolXPVda6QfG0dflGPiS/fRYnQCmWB1lXcwOaeldfI6/s?=
 =?us-ascii?Q?bhzFA/VCMkhlhw+xTWZbbaHqM8o8BZ88WCw85tsxF45+oh30aUWwbqvURqlt?=
 =?us-ascii?Q?on+UAoyTXKG5UpyCREqNAua8pkRyb5JuocB3UHSznTTkKioP+tPLqfXrYlSM?=
 =?us-ascii?Q?1+7EAF6ngGw2osJA3xbXNn6xQfKYFgj4bJY2UVQt9z7WiCwRk/DYCSDCpBY5?=
 =?us-ascii?Q?D+J6Qy+sO+L01SRYOBtPGvGapgP3FQ1xpCDClxlFsNUWxZHGNBqRZr2Q6i3T?=
 =?us-ascii?Q?/Vx7EtcgryE3zY00YXg9Zv3aOHbKn0l+eKa3b26NPQeI13CX9c96V2XNL62K?=
 =?us-ascii?Q?VuP9ZXRiZgd5C/mwAnWu46onL0mHsyhGaLrlX6iT+6Qc1XbXqkrDzt24AHYK?=
 =?us-ascii?Q?GlMbYv6S9XNuAzxOQPUxMzR2mSB/72NHZEtNRnDXv1oZVzmbhKwHjGlkJy4B?=
 =?us-ascii?Q?QCnEi9prQGz4dvvR9pN9ogYZDHcP1vIDhgGegw7pruOjCjXAQHkD7P92ndI0?=
 =?us-ascii?Q?5+ANCufrpsBqzuS/mezw81zikzO94YeNUpuF/AFHntVK80xXf9wQvtUCJ/zJ?=
 =?us-ascii?Q?5rH4+lCaW+j2toX0f3xnMPZWExpzHNbUW8flvFAR6UU0CSO6imBZjE3IvrTl?=
 =?us-ascii?Q?UdC/c4/YSdcxYYtm9MuY0Plc7RnM8CXvnYcTKqYT8uSdzj9eqGSpy8XhfilL?=
 =?us-ascii?Q?pRC1wEDG8gsaXW99Z2FjqL3X0pJPn7NoTwjSinPvu/LQdR8pQQ76Xd8ay8KM?=
 =?us-ascii?Q?0EQKtMOEJDekDfEZklCJ4EOQ?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da3763cc-5174-4b94-d383-08d931a9fb45
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:07:18.7583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G64tKPAfVGs/Vj2F/Hxd6txK+8X3BOR5k0pJcgo4rYzmbGHMZP1Pyf9Ztp6q2VA4qNmylGtDPLhxctpi47XBbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1014
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/wrs/wrs_tables.c | 774 ++++++++++++++++++
 1 file changed, 774 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_tables.c

diff --git a/drivers/net/wireless/celeno/cl8k/wrs/wrs_tables.c b/drivers/ne=
t/wireless/celeno/cl8k/wrs/wrs_tables.c
new file mode 100644
index 000000000000..9349c3251557
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/wrs/wrs_tables.c
@@ -0,0 +1,774 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "wrs/wrs_tables.h"
+#include "wrs/wrs.h"
+#include "wrs/wrs_db.h"
+#include "wrs/wrs_sta.h"
+#include "data_rates.h"
+#include "hw.h"
+
+static struct cl_wrs_table
+       ap_rate_table_he[CHNL_BW_MAX][WRS_SS_MAX][WRS_MCS_MAX_HE][WRS_GI_MA=
X_HE];
+static struct cl_wrs_table
+       ap_rate_table_ht_vht[CHNL_BW_MAX][WRS_SS_MAX][WRS_MCS_MAX_VHT][WRS_=
GI_MAX_VHT];
+
+/* Rate indexes sorted by data rate */
+static u16 rate_idx_sorted_by_data_rate_he[WRS_HE_RATE_TABLE_SIZE] =3D {0}=
;
+static u16 rate_idx_sorted_by_data_rate_ht_vht[WRS_HT_VHT_RATE_TABLE_SIZE]=
 =3D {0};
+
+static void cl_wrs_extract_rate_idx_vht(u16 idx, u8 *bw, u8 *nss, u8 *mcs,=
 u8 *gi)
+{
+       *gi =3D idx % WRS_GI_MAX_VHT;
+       idx =3D (idx - *gi) / WRS_GI_MAX_VHT;
+       *mcs =3D idx % WRS_MCS_MAX_VHT;
+       idx =3D (idx - *mcs) / WRS_MCS_MAX_VHT;
+       *bw =3D idx % CHNL_BW_MAX;
+       *nss =3D (idx - *bw) / WRS_SS_MAX;
+}
+
+static void cl_wrs_extract_rate_idx_he(u16 idx, u8 *bw, u8 *nss, u8 *mcs, =
u8 *gi)
+{
+       *gi =3D idx % WRS_GI_MAX_HE;
+       idx =3D (idx - *gi) / WRS_GI_MAX_HE;
+       *mcs =3D idx % WRS_MCS_MAX_HE;
+       idx =3D (idx - *mcs) / WRS_MCS_MAX_HE;
+       *bw =3D idx % CHNL_BW_MAX;
+       *nss =3D (idx - *bw) / WRS_SS_MAX;
+}
+
+static void cl_wrs_tables_build_sorted_ht_vht(void)
+{
+       /* Sort according to HT/VHT data rate */
+       u16 i, j;
+       u8 bw1, nss1, mcs1, gi1, bw2, nss2, mcs2, gi2;
+
+       for (i =3D 0; i < WRS_HT_VHT_RATE_TABLE_SIZE; i++)
+               rate_idx_sorted_by_data_rate_ht_vht[i] =3D i;
+
+       for (i =3D 0; i < WRS_HT_VHT_RATE_TABLE_SIZE - 1; i++) {
+               for (j =3D 0; j < WRS_HT_VHT_RATE_TABLE_SIZE - i - 1; j++) =
{
+                       cl_wrs_extract_rate_idx_vht(rate_idx_sorted_by_data=
_rate_ht_vht[j],
+                                                   &bw1, &nss1, &mcs1, &gi=
1);
+                       cl_wrs_extract_rate_idx_vht(rate_idx_sorted_by_data=
_rate_ht_vht[j + 1],
+                                                   &bw2, &nss2, &mcs2, &gi=
2);
+
+                       if (data_rate_ht_vht_x10[bw1][nss1][mcs1][gi1] >
+                           data_rate_ht_vht_x10[bw2][nss2][mcs2][gi2])
+                               swap(rate_idx_sorted_by_data_rate_ht_vht[j]=
,
+                                    rate_idx_sorted_by_data_rate_ht_vht[j =
+ 1]);
+               }
+       }
+}
+
+static void cl_wrs_tables_build_sorted_he(void)
+{
+       /* Sort according to HE data rate */
+       u16 i, j;
+       u8 bw1, nss1, mcs1, gi1, bw2, nss2, mcs2, gi2;
+
+       for (i =3D 0; i < WRS_HE_RATE_TABLE_SIZE; i++)
+               rate_idx_sorted_by_data_rate_he[i] =3D i;
+
+       for (i =3D 0; i < WRS_HE_RATE_TABLE_SIZE - 1; i++) {
+               for (j =3D 0; j < WRS_HE_RATE_TABLE_SIZE - i - 1; j++) {
+                       cl_wrs_extract_rate_idx_he(rate_idx_sorted_by_data_=
rate_he[j],
+                                                  &bw1, &nss1, &mcs1, &gi1=
);
+                       cl_wrs_extract_rate_idx_he(rate_idx_sorted_by_data_=
rate_he[j + 1],
+                                                  &bw2, &nss2, &mcs2, &gi2=
);
+
+                       if (data_rate_he_x10[nss1][bw1][mcs1][gi1] >
+                           data_rate_he_x10[nss2][bw2][mcs2][gi2])
+                               swap(rate_idx_sorted_by_data_rate_he[j],
+                                    rate_idx_sorted_by_data_rate_he[j + 1]=
);
+               }
+       }
+}
+
+static u16 idx_to_offt_ht_vht(u32 bw, u32 nss, u32 mcs, u32 gi)
+{
+       if (bw < CHNL_BW_MAX &&
+           nss < WRS_SS_MAX &&
+           mcs < WRS_MCS_MAX_VHT &&
+           gi < WRS_GI_MAX_VHT)
+               return (gi + WRS_GI_MAX_VHT * (mcs + WRS_MCS_MAX_VHT * (nss=
 + bw * WRS_SS_MAX)));
+       else
+               return -1;
+}
+
+static u16 idx_to_offt_he(u32 bw, u32 nss, u32 mcs, u32 gi)
+{
+       if (bw < CHNL_BW_MAX &&
+           nss < WRS_SS_MAX &&
+           mcs < WRS_MCS_MAX_HE &&
+           gi < WRS_GI_MAX_HE)
+               return (gi + WRS_GI_MAX_HE * (mcs + WRS_MCS_MAX_HE * (nss +=
 bw * WRS_SS_MAX)));
+       else
+               return -1;
+}
+
+static u16 find_down_rate_idx(u32 bw, u32 nss, u32 mcs, u32 gi, u16 *data_=
rates,
+                             u16 (*idx_to_offt)(u32 bw, u32 nss, u32 mcs, =
u32 gi))
+{
+       u16 idx;
+
+       if (mcs > 0) {
+               idx =3D idx_to_offt(bw, nss, mcs - 1, gi);
+               if (data_rates[idx])
+                       return idx;
+               if (mcs > 1)
+                       return idx_to_offt(bw, nss, mcs - 2, gi);
+       }
+
+       if (bw > 0) {
+               idx =3D idx_to_offt(bw - 1, nss, mcs, gi);
+               if (data_rates[idx])
+                       return idx;
+               if (bw > 1)
+                       return idx_to_offt(bw - 2, nss, mcs, gi);
+       }
+
+       if (nss > 0) {
+               idx =3D idx_to_offt(bw, nss - 1, mcs, gi);
+               if (data_rates[idx])
+                       return idx;
+               if (nss > 1) {
+                       idx =3D idx_to_offt(bw, nss - 2, mcs, gi);
+                       if (data_rates[idx])
+                               return idx;
+               }
+       }
+
+       if (gi > 0)
+               return idx_to_offt(bw, nss, mcs, gi - 1);
+
+       return 0;
+}
+
+static u16 find_up_mcs_rate_idx(u32 bw, u32 nss, u32 mcs, u32 gi, u16 *dat=
a_rates,
+                               u16 (*idx_to_offt)(u32 bw, u32 nss, u32 mcs=
, u32 gi))
+{
+       s16 idx =3D idx_to_offt(bw, nss, mcs + 1, gi);
+
+       if (idx < 0 || !data_rates[idx])
+               idx =3D idx_to_offt(bw, nss, mcs + 2, gi);
+
+       return (idx < 0) ? WRS_INVALID_RATE : idx;
+}
+
+static u16 find_up_bw_rate_idx(u32 bw, u32 nss, u32 mcs, u32 gi,
+                              u16 *data_rates,
+                              u16 (*idx_to_offt)(u32 bw, u32 nss, u32 mcs,=
 u32 gi))
+{
+       s16 cur_data_rate =3D data_rates[idx_to_offt(bw, nss, mcs, gi)];
+       s16 min_idx =3D WRS_INVALID_RATE;
+       s16 idx;
+       s32 min_rate_diff =3D S32_MAX;
+       s32 rate_diff;
+
+       for (idx =3D idx_to_offt(++bw, nss, mcs, gi); !(idx < 0);
+            idx =3D idx_to_offt(bw, nss, --mcs, gi)) {
+               /*
+                * If data_rates[idx] =3D=3D 0, the difference will be nega=
tive,
+                * so the condition below will not hold.
+                * Therefore, no need to check this possiblity specifically=
.
+                */
+               rate_diff =3D data_rates[idx] - cur_data_rate;
+               if (rate_diff > 0 &&
+                   rate_diff < min_rate_diff &&
+                   (data_rates[idx] * 100) > (cur_data_rate * WRS_EPR_FACT=
OR)) {
+                       min_rate_diff =3D rate_diff;
+                       min_idx =3D idx;
+               }
+       }
+
+       return min_idx;
+}
+
+static u16 find_up_nss_rate_idx(u32 bw, u32 nss, u32 mcs, u32 gi,
+                               u16 *data_rates,
+                               u16 (*idx_to_offt)(u32 bw, u32 nss, u32 mcs=
, u32 gi))
+{
+       s16 cur_data_rate =3D data_rates[idx_to_offt(bw, nss, mcs, gi)];
+       s16 min_idx =3D WRS_INVALID_RATE;
+       s16 idx;
+       s32 min_rate_diff =3D S32_MAX;
+       s32 rate_diff;
+
+       for (idx =3D idx_to_offt(bw, ++nss, mcs, gi); !(idx < 0);
+            idx =3D idx_to_offt(bw, nss, --mcs, gi)) {
+               /*
+                * If data_rates[idx] =3D=3D 0, the difference will be nega=
tive,
+                * so the condition below will not hold.
+                * Therefore, no need to check this possiblity specifically=
.
+                */
+               rate_diff =3D data_rates[idx] - cur_data_rate;
+               if (rate_diff > 0 &&
+                   rate_diff < min_rate_diff &&
+                   (data_rates[idx] * 100) > (cur_data_rate * WRS_EPR_FACT=
OR)) {
+                       min_rate_diff =3D rate_diff;
+                       min_idx =3D idx;
+               }
+       }
+
+       return min_idx;
+}
+
+static u16 find_up_bf_rate_idx(u32 bw, u32 nss, u32 mcs, u32 gi,
+                              u16 *data_rates,
+                              u16 (*idx_to_offt)(u32 bw, u32 nss, u32 mcs,=
 u32 gi))
+{
+       s16 cur_data_rate =3D data_rates[idx_to_offt(bw, nss, mcs, gi)];
+       s16 min_idx =3D WRS_INVALID_RATE;
+       s16 idx;
+       s32 min_rate_diff =3D S32_MAX;
+       s16 rate_diff;
+
+       for (idx =3D idx_to_offt(bw, --nss, mcs, gi); !(idx < 0);
+            idx =3D idx_to_offt(bw, nss, ++mcs, gi)) {
+               /*
+                * If data_rates[idx] =3D=3D 0, the difference will be nega=
tive,
+                * so the condition below will not hold.
+                * Therefore, no need to check this possiblity specifically=
.
+                */
+               rate_diff =3D data_rates[idx] - cur_data_rate;
+               if (rate_diff > 0 &&
+                   rate_diff < min_rate_diff &&
+                   (data_rates[idx] * 100) > (cur_data_rate * WRS_EPR_FACT=
OR)) {
+                       min_rate_diff =3D rate_diff;
+                       min_idx =3D idx;
+               }
+       }
+
+       return min_idx;
+}
+
+static u16 find_up_gi_rate_idx(u32 bw, u32 nss, u32 mcs, u32 gi,
+                              u16 (*idx_to_offt)(u32 bw, u32 nss, u32 mcs,=
 u32 gi))
+{
+       s16 idx =3D idx_to_offt(bw, nss, mcs, gi + 1);
+
+       return (idx < 0) ? WRS_INVALID_RATE : idx;
+}
+
+static void _cl_wrs_tables_init(struct cl_wrs_table *ap_rate_table,
+                               u16 *data_rates,
+                               u32 bw, u32 nss, u32 mcs, u32 gi,
+                               u16 (*idx_to_offt)(u32 bw, u32 nss, u32 mcs=
, u32 gi))
+{
+       struct cl_wrs_table *cur_entry =3D NULL;
+       int i =3D 0;
+       u16 offt =3D idx_to_offt(bw, nss, mcs, gi);
+
+       cur_entry =3D &ap_rate_table[offt];
+       cur_entry->rate.bw =3D bw;
+       cur_entry->rate.nss =3D nss;
+       cur_entry->rate.mcs =3D mcs;
+       cur_entry->rate.gi =3D gi;
+
+       /* If current rate is invalid, mark it as such and skip it. */
+       if (!data_rates[offt]) {
+               cur_entry->rate_down.rate_idx =3D WRS_INVALID_RATE;
+               cur_entry->rate_down.time_th =3D WRS_MSEC_WEIGHT_MAX_DOWN;
+
+               for (i =3D 0; i < WRS_TABLE_NODE_UP_MAX; i++) {
+                       cur_entry->rate_up[i].rate_idx =3D WRS_INVALID_RATE=
;
+                       cur_entry->rate_up[i].time_th =3D WRS_MSEC_WEIGHT_M=
AX_UP;
+               }
+
+               return;
+       }
+
+       cur_entry->rate_down.rate_idx =3D
+               find_down_rate_idx(bw, nss, mcs, gi, data_rates, idx_to_off=
t);
+       cur_entry->rate_up[WRS_TABLE_NODE_UP_MCS].rate_idx =3D
+               find_up_mcs_rate_idx(bw, nss, mcs, gi, data_rates, idx_to_o=
fft);
+       cur_entry->rate_up[WRS_TABLE_NODE_UP_BW].rate_idx =3D
+               find_up_bw_rate_idx(bw, nss, mcs, gi, data_rates, idx_to_of=
ft);
+       cur_entry->rate_up[WRS_TABLE_NODE_UP_NSS].rate_idx =3D
+               find_up_nss_rate_idx(bw, nss, mcs, gi, data_rates, idx_to_o=
fft);
+       cur_entry->rate_up[WRS_TABLE_NODE_UP_BF].rate_idx =3D
+               find_up_bf_rate_idx(bw, nss, mcs, gi, data_rates, idx_to_of=
ft);
+       cur_entry->rate_up[WRS_TABLE_NODE_UP_GI].rate_idx =3D
+               find_up_gi_rate_idx(bw, nss, mcs, gi, idx_to_offt);
+
+       cur_entry->rate_down.time_th =3D WRS_INIT_MSEC_WEIGHT_DOWN;
+
+       for (i =3D 0; i < WRS_TABLE_NODE_UP_MAX; i++)
+               cur_entry->rate_up[i].time_th =3D
+                       (cur_entry->rate_up[i].rate_idx =3D=3D WRS_INVALID_=
RATE) ?
+                       WRS_MSEC_WEIGHT_MAX_UP : WRS_INIT_MSEC_WEIGHT_UP;
+}
+
+static void cl_wrs_tables_init(u8 mode)
+{
+       u32 bw, nss, mcs, gi;
+       u32 max_bw, max_nss, max_mcs, max_gi;
+       u16 (*idx_to_offt)(u32 bw, u32 nss, u32 mcs, u32 gi);
+       struct cl_wrs_table *ap_rate_table =3D NULL;
+       u16 *data_rates =3D NULL;
+
+       if (mode =3D=3D WRS_MODE_HE) {
+               idx_to_offt =3D idx_to_offt_he;
+               max_bw =3D CHNL_BW_MAX;
+               max_nss =3D WRS_SS_MAX;
+               max_mcs =3D WRS_MCS_MAX_HE;
+               max_gi =3D WRS_GI_MAX_HE;
+               ap_rate_table =3D (struct cl_wrs_table *)ap_rate_table_he;
+               data_rates =3D (u16 *)data_rate_he_x10;
+       } else if (mode =3D=3D WRS_MODE_VHT) {
+               idx_to_offt =3D idx_to_offt_ht_vht;
+               max_bw =3D CHNL_BW_MAX;
+               max_nss =3D WRS_SS_MAX;
+               max_mcs =3D WRS_MCS_MAX_VHT;
+               max_gi =3D WRS_GI_MAX_VHT;
+               ap_rate_table =3D (struct cl_wrs_table *)ap_rate_table_ht_v=
ht;
+               data_rates =3D (u16 *)data_rate_ht_vht_x10;
+       } else {
+               return;
+       }
+
+       for (bw =3D 0; bw < max_bw; bw++)
+               for (nss =3D 0; nss < max_nss; nss++)
+                       for (mcs =3D 0; mcs < max_mcs; mcs++)
+                               for (gi =3D 0; gi < max_gi; gi++)
+                                       _cl_wrs_tables_init(ap_rate_table,
+                                                           data_rates,
+                                                           bw,
+                                                           nss,
+                                                           mcs,
+                                                           gi,
+                                                           idx_to_offt);
+}
+
+void cl_wrs_tables_global_build(void)
+{
+       cl_wrs_tables_init(WRS_MODE_HE);
+       cl_wrs_tables_init(WRS_MODE_VHT);
+       cl_wrs_tables_build_sorted_he();
+       cl_wrs_tables_build_sorted_ht_vht();
+}
+
+void cl_wrs_tables_print(struct cl_hw *cl_hw, struct cl_wrs_params *wrs_pa=
rams)
+{
+       struct cl_wrs_table *table;
+       u16 i =3D 0, idx_dn =3D 0, idx_up1 =3D 0, idx_up2 =3D 0, idx_up3 =
=3D 0, idx_up4 =3D 0, idx_up5 =3D 0;
+
+       pr_debug("\n");
+       pr_debug("                 ----------------------------------------=
---------------------------------------\n");
+       pr_debug("                 ||   Down    || Up #1 mcs || Up #2 bw  |=
| Up #3 ss  || Up #4 bf  || Up #5 gi  |\n");
+       pr_debug("-----------------||-----------||-----------||-----------|=
|-----------||-----------||-----------|\n");
+       pr_debug("|idx|bw|ss|mcs|gi|| idx | thr || idx | thr || idx | thr |=
| idx | thr || idx | thr || idx | thr |\n");
+       pr_debug("|----------------||-----------||-----------||-----------|=
|-----------||-----------||-----------|\n");
+
+       for (i =3D 0; i < wrs_params->table_size; i++) {
+               table =3D &wrs_params->table[i];
+
+               idx_dn =3D table->rate_down.rate_idx;
+               idx_up1 =3D table->rate_up[WRS_TABLE_NODE_UP_MCS].rate_idx;
+               idx_up2 =3D table->rate_up[WRS_TABLE_NODE_UP_BW].rate_idx;
+               idx_up3 =3D table->rate_up[WRS_TABLE_NODE_UP_NSS].rate_idx;
+               idx_up4 =3D table->rate_up[WRS_TABLE_NODE_UP_BF].rate_idx;
+               idx_up5 =3D table->rate_up[WRS_TABLE_NODE_UP_GI].rate_idx;
+
+               pr_debug("|%3u|%2u|%2u|%3u|%2u||%5u|%5u||%5u|%5u||%5u|%5u||=
%5u|%5u||%5u|%5u||%5u|%5u|\n",
+                        i,
+                        table->rate.bw, table->rate.nss, table->rate.mcs, =
table->rate.gi,
+                        idx_dn, table->rate_down.time_th,
+                        idx_up1, table->rate_up[WRS_TABLE_NODE_UP_MCS].tim=
e_th,
+                        idx_up2, table->rate_up[WRS_TABLE_NODE_UP_BW].time=
_th,
+                        idx_up3, table->rate_up[WRS_TABLE_NODE_UP_NSS].tim=
e_th,
+                        idx_up4, table->rate_up[WRS_TABLE_NODE_UP_BF].time=
_th,
+                        idx_up5, table->rate_up[WRS_TABLE_NODE_UP_GI].time=
_th);
+       }
+
+       pr_debug("---------------------------------------------------------=
---------------------------------------\n\n");
+}
+
+void cl_wrs_tables_reset(struct cl_wrs_db *wrs_db, struct cl_wrs_sta *wrs_=
sta,
+                        struct cl_wrs_params *wrs_params)
+{
+       struct cl_wrs_table_node *rate_up;
+       u16 rate_idx =3D 0;
+       u8 up_idx =3D 0;
+
+       for (rate_idx =3D 0; rate_idx < wrs_params->table_size; rate_idx++)=
 {
+               if (wrs_params->table[rate_idx].rate_down.rate_idx !=3D WRS=
_INVALID_RATE)
+                       wrs_params->table[rate_idx].rate_down.time_th =3D W=
RS_INIT_MSEC_WEIGHT_DOWN;
+               else
+                       wrs_params->table[rate_idx].rate_down.time_th =3D w=
rs_db->time_th_max_down;
+
+               wrs_params->table[rate_idx].rate_down.quick_up_check =3D fa=
lse;
+
+               for (up_idx =3D 0; up_idx < WRS_TABLE_NODE_UP_MAX; up_idx++=
) {
+                       rate_up =3D &wrs_params->table[rate_idx].rate_up[up=
_idx];
+
+                       if (rate_up->rate_idx !=3D WRS_INVALID_RATE)
+                               rate_up->time_th =3D WRS_INIT_MSEC_WEIGHT_U=
P;
+                       else
+                               rate_up->time_th =3D wrs_db->time_th_max_up=
;
+
+                       rate_up->quick_up_check =3D false;
+               }
+
+               wrs_params->table[rate_idx].frames_total =3D 0;
+               wrs_params->table[rate_idx].ba_not_rcv_total =3D 0;
+               wrs_params->table[rate_idx].epr_acc =3D 0;
+       }
+}
+
+static bool cl_wrs_is_rate_valid_he(struct cl_hw *cl_hw, struct cl_wrs_sta=
 *wrs_sta,
+                                   u8 bw, u8 nss, u8 mcs, u8 gi)
+{
+       /* Disable rates according to ce_he_mcs_nss_supp_tx */
+       if ((cl_hw->conf->ce_he_mcs_nss_supp_tx[nss] + 1) <=3D mcs)
+               return false;
+
+       return true;
+}
+
+static bool cl_wrs_is_rate_valid_vht(struct cl_hw *cl_hw, u8 bw, u8 nss, u=
8 mcs)
+{
+       /* Disable BW160 */
+       if (bw =3D=3D CHNL_BW_160)
+               return false;
+
+       /* Disable VHT invalid rates (MCS9 20M 1SS, MCS9 20M 2SS, MCS6 80M =
3SS, MCS9 20M 4SS) */
+       if (bw =3D=3D CHNL_BW_20 && mcs =3D=3D WRS_MCS_9)
+               if (nss =3D=3D WRS_SS_1 || nss =3D=3D WRS_SS_2 || nss =3D=
=3D WRS_SS_4)
+                       return false;
+
+       if (bw =3D=3D CHNL_BW_80 && mcs =3D=3D WRS_MCS_6 && nss =3D=3D WRS_=
SS_3)
+               return false;
+
+       /* Disable rates according to ce_vht_mcs_nss_supp_tx */
+       if ((cl_hw->conf->ce_vht_mcs_nss_supp_tx[nss] + 1) <=3D mcs)
+               return false;
+
+       return true;
+}
+
+static bool cl_wrs_is_rate_valid(struct cl_hw *cl_hw, struct cl_wrs_sta *w=
rs_sta,
+                                u8 mode, u8 bw, u8 nss, u8 mcs, u8 gi)
+{
+       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+
+       if (gi > wrs_db->max_cap.gi || gi > wrs_sta->gi_cap[bw])
+               return false;
+
+       if (mode =3D=3D WRS_MODE_HE)
+               return cl_wrs_is_rate_valid_he(cl_hw, wrs_sta, bw, nss, mcs=
, gi);
+
+       if (mode =3D=3D WRS_MODE_VHT)
+               return cl_wrs_is_rate_valid_vht(cl_hw, bw, nss, mcs);
+
+       return true;
+}
+
+static bool cl_wrs_is_rate_supported(u64 *rate_bitmap, u8 bw, u8 nss, u8 m=
cs)
+{
+       u8 rate_idx =3D mcs + (nss * WRS_MCS_MAX);
+       u64 mask =3D BIT(rate_idx);
+
+       return ((rate_bitmap[bw] & mask) ? true : false);
+}
+
+static bool cl_wrs_tables_is_up_invalid(struct cl_wrs_table *table)
+{
+       /*
+        * The UP_GI is not part of this if condition, because we would
+        * like to set the same up candidate for LGI & SGI (except the
+        * up from LGI to SGI).
+        */
+       return ((table->rate_up[WRS_TABLE_NODE_UP_MCS].rate_idx =3D=3D WRS_=
INVALID_RATE) &&
+               (table->rate_up[WRS_TABLE_NODE_UP_BW].rate_idx =3D=3D WRS_I=
NVALID_RATE) &&
+               (table->rate_up[WRS_TABLE_NODE_UP_NSS].rate_idx =3D=3D WRS_=
INVALID_RATE) &&
+               (table->rate_up[WRS_TABLE_NODE_UP_BF].rate_idx =3D=3D WRS_I=
NVALID_RATE));
+}
+
+static int cl_wrs_tables_max(struct cl_hw *cl_hw, struct cl_wrs_sta *wrs_s=
ta,
+                            u8 *max_bw, u8 *max_nss, u8 *max_mcs, u8 *max_=
gi)
+{
+       *max_bw =3D wrs_sta->max_rate_cap.bw;
+       *max_nss =3D wrs_sta->smps_enable ? WRS_SS_1 : wrs_sta->max_rate_ca=
p.nss;
+
+       switch (wrs_sta->mode) {
+       case WRS_MODE_CCK:
+               *max_mcs =3D WRS_MCS_3;
+               *max_gi =3D WRS_GI_LONG;
+               break;
+       case WRS_MODE_OFDM:
+               *max_mcs =3D WRS_MCS_7;
+               *max_gi =3D WRS_GI_LONG;
+               break;
+       case WRS_MODE_HT:
+               *max_mcs =3D WRS_MCS_7;
+               *max_gi =3D WRS_GI_SHORT;
+               break;
+       case WRS_MODE_VHT:
+               *max_mcs =3D WRS_MCS_9;
+               *max_gi =3D WRS_GI_SHORT;
+               break;
+       case WRS_MODE_HE:
+               *max_mcs =3D WRS_MCS_11;
+               *max_gi =3D WRS_GI_VSHORT;
+
+               if (!cl_hw->conf->ce_txldpc_en) {
+                       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+
+                       wrs_pr_verbose(wrs_db,
+                                      "[WRS] TX LDPC disabled: limit BW to=
 20MHz and MCS to 9\n");
+                       *max_mcs =3D WRS_MCS_9;
+                       *max_bw =3D CHNL_BW_20;
+               }
+               break;
+       default:
+               return -1;
+       }
+
+       return 0;
+}
+
+void cl_wrs_tables_build(struct cl_hw *cl_hw, struct cl_wrs_sta *wrs_sta,
+                        struct cl_wrs_params *wrs_params)
+{
+       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+       u8 bw =3D 0;
+       u8 nss =3D 0;
+       u8 mcs =3D 0;
+       u8 gi =3D 0;
+       u8 max_bw =3D 0;
+       u8 max_nss =3D 0;
+       u8 max_mcs =3D 0;
+       u8 max_gi =3D 0;
+       u8 up_idx =3D 0;
+       u16 rate_idx =3D 0;
+       u16 new_rate_idx =3D 0;
+       u16 tmp_rate_idx =3D 0;
+       u16 max_table_size =3D 0;
+       u16 new_table_size =3D 0;
+       u16 (*idx_to_offt)(u32 bw, u32 nss, u32 mcs, u32 gi);
+       u16 *rate_idx_sorted_by_data_rate;
+       struct cl_wrs_table *ap_rate_table;
+       struct cl_wrs_table *new_table =3D NULL;
+       struct cl_wrs_table_validity *valid_rates =3D NULL;
+
+       if (cl_wrs_tables_max(cl_hw, wrs_sta, &max_bw, &max_nss, &max_mcs, =
&max_gi))
+               return;
+
+       if (wrs_sta->mode =3D=3D WRS_MODE_HE) {
+               max_table_size =3D WRS_HE_RATE_TABLE_SIZE;
+               idx_to_offt =3D idx_to_offt_he;
+               ap_rate_table =3D (struct cl_wrs_table *)ap_rate_table_he;
+               rate_idx_sorted_by_data_rate =3D rate_idx_sorted_by_data_ra=
te_he;
+       } else {
+               max_table_size =3D WRS_HT_VHT_RATE_TABLE_SIZE;
+               idx_to_offt =3D idx_to_offt_ht_vht;
+               ap_rate_table =3D (struct cl_wrs_table *)ap_rate_table_ht_v=
ht;
+               rate_idx_sorted_by_data_rate =3D rate_idx_sorted_by_data_ra=
te_ht_vht;
+       }
+
+       valid_rates =3D kzalloc(max_table_size * sizeof(struct cl_wrs_table=
_validity), GFP_ATOMIC);
+       if (!valid_rates)
+               goto out;
+
+       wrs_sta->max_rate_cap.mcs =3D WRS_MCS_0;
+       wrs_sta->max_rate_cap.gi =3D WRS_GI_LONG;
+
+       for (bw =3D 0; bw <=3D max_bw; bw++) {
+               for (nss =3D 0; nss <=3D max_nss; nss++) {
+                       for (mcs =3D 0; mcs <=3D max_mcs; mcs++) {
+                               for (gi =3D 0; gi <=3D max_gi; gi++) {
+                                       rate_idx =3D idx_to_offt(bw, nss, m=
cs, gi);
+                                       valid_rates[rate_idx].is_valid =3D
+                                               cl_wrs_is_rate_supported(wr=
s_sta->supported_rates,
+                                                                        bw=
, nss, mcs) &&
+                                               cl_wrs_is_rate_supported(wr=
s_db->ap_supported_rates,
+                                                                        bw=
, nss, mcs) &&
+                                               cl_wrs_is_rate_valid(cl_hw,=
 wrs_sta, wrs_sta->mode,
+                                                                    bw, ns=
s, mcs, gi);
+
+                                       if (!valid_rates[rate_idx].is_valid=
)
+                                               continue;
+
+                                       valid_rates[rate_idx].new_rate_idx =
=3D new_table_size;
+                                       new_table_size++;
+
+                                       if (mcs > wrs_sta->max_rate_cap.mcs=
)
+                                               wrs_sta->max_rate_cap.mcs =
=3D mcs;
+
+                                       if (gi > wrs_sta->max_rate_cap.gi)
+                                               wrs_sta->max_rate_cap.gi =
=3D gi;
+                               }
+                       }
+               }
+       }
+
+       if (new_table_size =3D=3D 0) {
+               /* Error - size of table is 0, add single rate (mcs 0, 1 SS=
, bw 20 Mhz) */
+               wrs_pr_err(wrs_db, "[WRS] Table build error - Size of table=
 is 0\n");
+               cl_wrs_sta_set_supported_rate(wrs_sta, CHNL_BW_20, WRS_SS_1=
, WRS_MCS_0);
+               valid_rates[0].new_rate_idx =3D 0;
+               valid_rates[0].is_valid =3D 1;
+               new_table_size =3D 1;
+       }
+
+       new_table =3D kzalloc(new_table_size * sizeof(struct cl_wrs_table),=
 GFP_ATOMIC);
+
+       if (!new_table)
+               goto out;
+
+       for (rate_idx =3D 0; rate_idx < max_table_size; rate_idx++) {
+               if (!valid_rates[rate_idx].is_valid)
+                       continue;
+
+               memcpy(new_table + new_rate_idx,
+                      ap_rate_table + rate_idx,
+                      sizeof(struct cl_wrs_table));
+
+               /* Set down rate */
+               tmp_rate_idx =3D ap_rate_table[rate_idx].rate_down.rate_idx=
;
+
+               while ((!valid_rates[tmp_rate_idx].is_valid) &&
+                      (ap_rate_table[tmp_rate_idx].rate_down.rate_idx !=3D=
 tmp_rate_idx))
+                       tmp_rate_idx =3D ap_rate_table[tmp_rate_idx].rate_d=
own.rate_idx;
+
+               if (valid_rates[tmp_rate_idx].is_valid) {
+                       new_table[new_rate_idx].rate_down.rate_idx =3D
+                               valid_rates[tmp_rate_idx].new_rate_idx;
+               } else {
+                       u16 i =3D 0;
+                       u16 down_idx =3D 0;
+                       u16 down_rate_idx =3D new_rate_idx;
+
+                       while (new_table[new_rate_idx].rate_down.rate_idx !=
=3D
+                              rate_idx_sorted_by_data_rate[i]) {
+                               down_idx =3D rate_idx_sorted_by_data_rate[i=
];
+
+                               if (valid_rates[down_idx].is_valid)
+                                       down_rate_idx =3D valid_rates[down_=
idx].new_rate_idx;
+                               i++;
+                       }
+
+                       new_table[new_rate_idx].rate_down.rate_idx =3D down=
_rate_idx;
+               }
+
+               /* Set up rates */
+               for (up_idx =3D 0; up_idx < WRS_TABLE_NODE_UP_MAX; up_idx++=
) {
+                       tmp_rate_idx =3D new_table[new_rate_idx].rate_up[up=
_idx].rate_idx;
+
+                       if (tmp_rate_idx !=3D WRS_INVALID_RATE &&
+                           valid_rates[tmp_rate_idx].is_valid)
+                               new_table[new_rate_idx].rate_up[up_idx].rat=
e_idx =3D
+                                       valid_rates[tmp_rate_idx].new_rate_=
idx;
+                       else
+                               new_table[new_rate_idx].rate_up[up_idx].rat=
e_idx =3D WRS_INVALID_RATE;
+               }
+
+               /*
+                * In case all the UP rates are invalid, find one available=
 UP
+                * rate based on PHY rate
+                */
+               if (cl_wrs_tables_is_up_invalid(&new_table[new_rate_idx])) =
{
+                       u16 i =3D 0;
+
+                       for (i =3D 0; i < max_table_size; i++)
+                               if (rate_idx =3D=3D rate_idx_sorted_by_data=
_rate[i])
+                                       break;
+
+                       i++;
+
+                       while (i < max_table_size) {
+                               tmp_rate_idx =3D rate_idx_sorted_by_data_ra=
te[i];
+                               if (!valid_rates[tmp_rate_idx].is_valid) {
+                                       i++;
+                                       continue;
+                               }
+
+                               new_table[new_rate_idx].rate_up[WRS_TABLE_N=
ODE_UP_MCS].rate_idx =3D
+                                       valid_rates[tmp_rate_idx].new_rate_=
idx;
+                               break;
+                       }
+               }
+
+               new_rate_idx++;
+       }
+
+       if (wrs_params->table) {
+               /*
+                * Copy epr_acc, frames_total and ba_not_rcv_total
+                * from the old table to the new table.
+                * Also, if initial_rate_idx is set, find the new
+                * value in the new table.
+                */
+               u16 old_rate_idx =3D 0;
+
+               for (rate_idx =3D 0; rate_idx < new_table_size; rate_idx++)=
 {
+                       old_rate_idx =3D cl_wrs_tables_find_rate_idx(wrs_pa=
rams,
+                                                                  new_tabl=
e[rate_idx].rate.bw,
+                                                                  new_tabl=
e[rate_idx].rate.nss,
+                                                                  new_tabl=
e[rate_idx].rate.mcs,
+                                                                  new_tabl=
e[rate_idx].rate.gi);
+
+                       if (old_rate_idx =3D=3D WRS_INVALID_RATE)
+                               continue;
+
+                       new_table[rate_idx].epr_acc =3D
+                               wrs_params->table[old_rate_idx].epr_acc;
+                       new_table[rate_idx].frames_total =3D
+                               wrs_params->table[old_rate_idx].frames_tota=
l;
+                       new_table[rate_idx].ba_not_rcv_total =3D
+                               wrs_params->table[old_rate_idx].ba_not_rcv_=
total;
+               }
+
+               kfree(wrs_params->table);
+       }
+
+       wrs_params->table =3D new_table;
+       wrs_params->table_size =3D new_table_size;
+
+       if (wrs_params->rate_idx !=3D WRS_INVALID_RATE) {
+               /*
+                * Check if current rate is included in the new table.
+                * If not select a rate from the new table accroding to rss=
i.
+                */
+               struct cl_wrs_tx_params *tx_params =3D &wrs_params->tx_para=
ms;
+
+               rate_idx =3D cl_wrs_tables_find_rate_idx(wrs_params,
+                                                      tx_params->bw, tx_pa=
rams->nss,
+                                                      tx_params->mcs, tx_p=
arams->gi);
+
+               if (rate_idx !=3D WRS_INVALID_RATE) {
+                       wrs_params->rate_idx =3D rate_idx;
+               } else {
+                       if (wrs_params->is_fixed_rate) {
+                               wrs_params->is_fixed_rate =3D false;
+                               wrs_pr_verbose(wrs_db,
+                                              "[WRS] Disable fixed rate fo=
r station %u\n",
+                                              wrs_sta->sta_idx);
+                       }
+
+                       cl_wrs_sta_select_first_rate(cl_hw, wrs_db, wrs_sta=
, wrs_params);
+                       cl_wrs_tx_cntrs_reset(wrs_sta, wrs_params);
+               }
+       }
+
+out:
+       kfree(valid_rates);
+}
+
+u16 cl_wrs_tables_find_rate_idx(struct cl_wrs_params *wrs_params,
+                               u8 bw, u8 nss, u8 mcs, u8 gi)
+{
+       struct cl_wrs_table *table =3D wrs_params->table;
+       u16 rate_idx =3D 0;
+
+       for (rate_idx =3D 0; rate_idx < wrs_params->table_size; rate_idx++)
+               if (bw =3D=3D table[rate_idx].rate.bw &&
+                   nss =3D=3D table[rate_idx].rate.nss &&
+                   mcs =3D=3D table[rate_idx].rate.mcs &&
+                   gi =3D=3D table[rate_idx].rate.gi)
+                       return rate_idx;
+
+       return WRS_INVALID_RATE;
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

