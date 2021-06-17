Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259063AB84D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhFQQGU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:20 -0400
Received: from mail-eopbgr140042.outbound.protection.outlook.com ([40.107.14.42]:47438
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233589AbhFQQGF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:06:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvSAoy1qfXXGb3rth8kFoHo13TuqDtVKJXJlf4v/eymUxaI0pKLJHTTp5l0UvzGypKWEP9ACtOIx4aba6vZlLGV2GQfxcWohU3VIlWbIqMQb2Lh62KNlEE7QGZ5g6Gg0lJ9x/zNnEpl9Hdvat7Zik6YWXgzZdgnH0ET101NHkMVPLId2H7Nmh6gDuiAl482/R+AB4jvsefHBiwU2lCHxwH8HWXXvXmK4dntaCuN64LTfmOCaeOeEdrbDSO9p9UZ/T+h2A7cQGe3I7IOX1sGaqzG8WpdzyzeibYayDqLY0GDvr5URvsEMtw7A5Mukn5WwHzvAh2Qprq0fQNE7NIB3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIkAa4f2Aqsuqvf1L4vRMqepP95Km9A3ZdECZvtFDAo=;
 b=jTklhIDYqbfGDBJX88+D0/WnnYi02/acNhiom4l2PincBLZzeYylwfsvUHdIGC1sX6xhFlkSzf+Zv6/AmeZemI5tzAnBCpB1W/0Kouc60UurRgS0KNEEDn3JHrWi2YcEf3/2vM7p1YAPpv168ktKF84Un/BWfbxZvOgCWGe/SANTrWA2sIMVgMMI/AUxYcl+Yupetk8wpRdDABLoV4p+ni+6FjJdCTvXWSZQrCgRoeaTeelDA2L5ISrUb3PpVC/hu244LjcSupez7B3eSMGdWiGPjSCDqyba8bz9pUKKbsBR4qKkZdMBAhcR15WMpBCc2QZf4yUW0SARgQ/PN4SvMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIkAa4f2Aqsuqvf1L4vRMqepP95Km9A3ZdECZvtFDAo=;
 b=WWojjeTsw3/csyFvm6zIkWYTd6LhYU9+9tFgbyir4EYO5CbLyi5uAc0UHth4CYIMBU73OdjiXPiVR+4Txpg+hhieSwzrjdcNqwlJlJR3So/u6xd0UND+LnppNDNwkJYh4sLAj4YTBDWCiMDudl22aKx4CibSoDN5wIjhzG7sNKM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1234.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:03:45 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:45 +0000
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
Subject: [RFC v1 051/256] cl8k: add data_rates.h
Date:   Thu, 17 Jun 2021 15:58:58 +0000
Message-Id: <20210617160223.160998-52-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e32cd5d6-1b56-4885-d798-08d931a97307
X-MS-TrafficTypeDiagnostic: AM9P192MB1234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1234639575E7DF994946C466F60E9@AM9P192MB1234.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z9p1u2ZoNfQwDFBklSSYxkJkl0YqaUSJZpzkaOxHBSNi3WeLh6qauK7D2zfLDG1P/pSrA570ejORjAGZ7Z/8PT6nKVdim9XSy5wB8g7Dvy/f6KAg/m6FnFqKk+BO47ZaZhAPOtdSkQ0yfSczUZRND4YCPwYBacsbkVbg8CrcS8BJpjQw4vRidUsHnxW/Q1/j482w4A+JeAgG8oQ1NYa3Wh77djI1BwafZJEtnYDLdp8ApM+AEPrjlK8rCyjl18DUvJ0N1FO7hbsNbe2wiUKd7cBDClnFOTbG1pdwj3YOlbxMulS7VuSv43/b37SKm551Szfn23QaIa4nkbnQFshaAm0VXNvj9C9HitMDYOOdM4iLn/UzRzRNBTpOOR2prQtf8x3BaYdU8TtkpayRt1wcQ5Dn7WBgEWoX3RFs1XrnJuGtTdrVxPKgJOA0dkqGN43RMmt8SAieJ/296bL9AZ3NLtTHe+lf/ObfBnmXmYTq/ohFBvk3VNSGUZCRD8I7Bby4wR5HbQVS+Z0CKOdvXQe4JxdmFh4cxU+VzkCAtaNPRVg4jjYJHPYXY7QZdDtiT0c5/9gEbTF1gKmxVasE4lYZpx3kSA94cMPmBHsuedReZjHDcd3fDuh2U7VhMYFKeu1ILY8CYJArfqvHRdtYjZJjqZ2GcuHZWigvH8mbf9XcdtD13L+ivQ6M2oZWP6ULVRXA6ucxkCPeE9VqhyBjf4UusQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(396003)(39850400004)(6666004)(107886003)(36756003)(956004)(66476007)(66556008)(2616005)(66946007)(6916009)(2906002)(26005)(9686003)(1076003)(6512007)(6486002)(16526019)(6506007)(38100700002)(52116002)(86362001)(8936002)(316002)(38350700002)(186003)(55236004)(54906003)(8676002)(5660300002)(508600001)(83380400001)(4326008)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+TywhVxOCgjP+YqO7yNh5v3iN2SD4QcNtUlAmpiqssXe4SaVqbFXlJFBQj69?=
 =?us-ascii?Q?pBAwbrK0CNFWsdXHxKR7iPcKSUmTjV9aU8/2vbJq1NN85XF5tAnaYfpYK7tR?=
 =?us-ascii?Q?+YXyIje3pG5RAZMtMUdQTn6Jbfri5oV9MDa3wT0o86OKUo3iVVwAZYBV5vgB?=
 =?us-ascii?Q?TqFy0hXnUbUk6gyfYySU+GeldOLom0y9wnoYb/b6J284ECBe7ES8v6oilHhS?=
 =?us-ascii?Q?M1TX9Z2A9E7bI3Pledwj75udDi3lT4BOE94YQZfGYme6HSaPO21F1hxIG9lP?=
 =?us-ascii?Q?DuBikehhkSrD3bN0q58DjZbMnFiukiUZGb/Fv7MqXmA1GRwybhxOmM/QXq7M?=
 =?us-ascii?Q?MktAvTnr6uGp/3pL02i0KYQNpjbZs9ag2w5uYp6PwYwTpbiqctqxX5FtG7fT?=
 =?us-ascii?Q?ys0CAu1yBruMD9QgzsC809J0nrlbXlxeBCKQGWe+V6X07Ix0lpgpLN37C+1D?=
 =?us-ascii?Q?WLQiSUJ1nopyFH2N8thhV9xQZTa7qZCpD9INPLUI/0PBgSjdoF+AM4/Xj8E0?=
 =?us-ascii?Q?1PP35X3Z0iaeKpr2S7rTa7pO8mEHQaMuqiAo9Tx7L4Fy1uRVVLWrTz7UhE6H?=
 =?us-ascii?Q?7wScu7/tMwZSIBKdFDxccnYU6NTBTlPKUsF5vGwG/kHem28q9LGoSVTTDY99?=
 =?us-ascii?Q?Kwxit6eE0h4xXZeTtrzHPtwt0gBQ5krMmrE5UbpuXPkZJ5BKmASCWFIIFV+Z?=
 =?us-ascii?Q?iUkdhM0xKmFbLBgisk9HeusH9Viara3GACpQH17AlVBXE4ymjn7kVPX6xZqB?=
 =?us-ascii?Q?eI2uqh0ni55Sqs88clxojT7IaU2PdQu0EnhY7oGbxtLqq3So/odAGRSGpWaU?=
 =?us-ascii?Q?ovLj9Us3g3li4fJccTupFooqaMDkhp6ZMKN8vse5Lbl4Zjbv5fNBTh9v5UGa?=
 =?us-ascii?Q?lV0cBS7L0BM1d11WNIE6sn/s+kH0/g3pGxsle//2mRBpjBNyUF2KKJ7H5hx4?=
 =?us-ascii?Q?xoGjtXNF+MBir0sdu53N8k6tsjcYWKIxpPdjAzfZqSBUD4WMjp9AYrOVey0k?=
 =?us-ascii?Q?WmL0e5yiTtIwNekVeEq6HWfjs2cCiFEGnhxIb1C9n6CD0ZlmpF9q+Fkurj9H?=
 =?us-ascii?Q?WjAoPLTcTl9bJnyMSE2tOAf6JKyfczAJisSJXLHUtJPJIzYyyInwb4UOBMpE?=
 =?us-ascii?Q?9kXJFdFUPJ90ZsXgbNHsyoIfSxAkECO2vnunxZXBh8UVTLbxR7XXcAqFmtSj?=
 =?us-ascii?Q?wqWzmoRkIpfeJyHNTnex8M2rsCgAS7KVQWF5FMgMxA46p8X5aIB+bPMOkYIW?=
 =?us-ascii?Q?8SnUG01jzaJtGgpo50UuwAvYfjQHtCAT246Pp2AXGShIX+4xraHvY96UMM9J?=
 =?us-ascii?Q?sWvNOHI+jO7F0PfmMRqy6Pku?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32cd5d6-1b56-4885-d798-08d931a97307
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:29.9928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezS5yzb0w9oYnLszJRXraf9kqm8jw1ozno8TBEdfkzE+u3XWCV98VmoVbTfrGUTUxHVgPksZ3R66uKGMWfeAVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1234
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/data_rates.h | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/data_rates.h

diff --git a/drivers/net/wireless/celeno/cl8k/data_rates.h b/drivers/net/wi=
reless/celeno/cl8k/data_rates.h
new file mode 100644
index 000000000000..ddb027402c19
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/data_rates.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_DATA_RATES_H
+#define CL_DATA_RATES_H
+
+#include "wrs/wrs_db.h"
+#include "def.h"
+
+#define DATA_RATE_INVERSE_Q 15
+
+struct cl_inverse_data_rate {
+       u16 he[CHNL_BW_MAX][WRS_SS_MAX][WRS_MCS_MAX_HE][WRS_GI_MAX_HE];
+       u16 ht_vht[CHNL_BW_MAX][WRS_SS_MAX][WRS_MCS_MAX_VHT][WRS_GI_MAX_VHT=
];
+       u16 ofdm[WRS_MCS_MAX_OFDM];
+       u16 cck[WRS_MCS_MAX_CCK];
+};
+
+extern struct cl_inverse_data_rate inverse_data_rate;
+
+extern const u16 data_rate_he_x10[CHNL_BW_MAX][WRS_SS_MAX][WRS_MCS_MAX_HE]=
[WRS_GI_MAX_HE];
+extern const u16 data_rate_ht_vht_x10[CHNL_BW_MAX][WRS_SS_MAX][WRS_MCS_MAX=
_VHT][WRS_GI_MAX_VHT];
+extern const u16 data_rate_ofdm_x10[];
+extern const u16 data_rate_cck_x10[];
+
+void cl_data_rates_inverse_build(void);
+u16 cl_data_rates_get(u8 mode, u8 bw, u8 nss, u8 mcs, u8 gi);
+u16 cl_data_rates_get_x10(u8 mode, u8 bw, u8 nss, u8 mcs, u8 gi);
+
+#endif /* CL_DATA_RATES_H */
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

