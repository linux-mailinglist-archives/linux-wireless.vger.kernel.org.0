Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BFC3AB857
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhFQQGy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:54 -0400
Received: from mail-eopbgr60088.outbound.protection.outlook.com ([40.107.6.88]:43502
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233675AbhFQQGa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:06:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4YGbUhttmwgUBam//I1g1Qrujb0xXa/jUEd5WC22rK1DEett60H4w2OEtW/FdMjY1voENk0uO0Ns3/3tai6nXBXWMUuDI+SGkh8zsJuWuj8DVCSfb6/pxzOT+4qeX9o/31dn/aSMqfCfL2hLrATZ+RPfqXmC9jQnZiHPwQrvM9p44Kr0QoU24vLBJVo26Vx5v3/EUtEAcSzqCkVPh4Ryzj+5ucWUe4wvDv9lTgqAiteY9YlIa6hOizKE7t7si8pt/eF/zzBxQQCpkZXfYWpbvXWaFdFKuSD+oAiZBctnNiSrdrelaZZHov9H55WGCNsPFGVsadsfrG+hAnwKAty/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muca6tt3vzcMhgDpANSEdOTwYfhwzrAShD5VMxrl65E=;
 b=IKTjQEbLoCsMshGBuv/yqF2RMjstaXfH1aMvoP+cm7hRjMGIImfIKwtmPeHm1YE60EZRnlaPsFgwz6ChsGQRAe2VbVRYQcFifTx3ygQx8cUQVTMaKF33OoFDL5EL4DBLTG2VpGlUf1aKRJlq8k96qh4JXLgvvnm9mEKXfH4xD3f/yMdWSj2lhAzBMCPrV4jYU8//vsD9y77gCQzERDmcCTDLtNrrMs+rKh6SFOs0IjXalGUtQK6U+I+VHX1RQtWjOwS0mw8b1iY2l1Z24/FDYp3gPb0Dr5OfCaJ2ZYF7PnIirJZw6CIFSxUxDFx8R6JtrN6tMbhqM6aBs6u4d5n0Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muca6tt3vzcMhgDpANSEdOTwYfhwzrAShD5VMxrl65E=;
 b=FNqLrv9Dvz903yX6WkRFOzYsEQLwRqcFsDPjrUIblg2yoFH5HzgeqRboRcAJMku6uA7emnxoLuVmzZhaUpMxHF3LNJT9Fju08XfYRhrTwtM3SWHGyE6o7KD46T51pL5URBq+C7uCcyLcMBTrwEwfCGwWvXJcXehcwaWRMvHM0fw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1268.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:04:19 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:18 +0000
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
Subject: [RFC v1 060/256] cl8k: add dfs/dfs.h
Date:   Thu, 17 Jun 2021 15:59:07 +0000
Message-Id: <20210617160223.160998-61-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69b50b1a-0b42-4de5-ce39-08d931a978df
X-MS-TrafficTypeDiagnostic: AM9P192MB1268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB12683B1034F44C975D6C2889F60E9@AM9P192MB1268.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JF51wYJy+RYPdQaSXau/44JtHZ5j0vSNgamEjTZ5tYGTPBm0McxLSLFTOIDbQjzfYNMz7IVjD68J9m/wsclZirk4Qvd1rh5GJfqULqn0A5HQ0G1fRrY7FsbVzSfrY1Xf6ivcyFVrB4cvZZMq0Me0y3nU0n71Q4ROLMDdK7tZ57BNCoJ7Y3Kq2pvFhO0eb55IOPTp/F7rYkeoy5XNui1YNwndO4HUlVpbHOcbe8/AdUqQVuRLyC4P7/EarDIgd9se+qlfjU2lQe0yyOYZZe2bA5olQNFi1sXSaf94So1RJQ1rQf7ilkedHi9ZzYYw3c95EhZ2lgWg2xPCzbV0co4SVOCObi2oE37KOInqnB0P1ZsFt4Cr4XnbujUmtqwJ5zGQKth9g4MRG8J9AlGl8uLXJZv1N8Otc+5jBLxb7pN8SPnJReN18VjaWTy8/hVyfDYSgcH8leEu3ysZKdBCzN9x1OOTnTdEDzkUmfJSRLwo1j9Kb1bGXyYwo1in+jAQ3tx2Gm2nrKtgAkPn/CimDCzjwucQ583yB2ZG5ZCzOwhumG8oDrJwMBIaOtqdhVtsIWDkfc+aphZOJekX0F/qOMkimlaPZ5pUJGslqZA219+WpmudQFQRYw7EPIjTLR7a1Q3d2qUuJUj3nfOpsrg5qt3qXjlmU6FTZNPIfIhgWjCYSCo9mSMiDTGUYiLXOm7F9cCSc6E3KN0+poxkFk4HLd3R2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(6486002)(956004)(54906003)(4326008)(2616005)(186003)(38100700002)(16526019)(8676002)(5660300002)(38350700002)(8936002)(26005)(2906002)(6512007)(9686003)(52116002)(83380400001)(6916009)(66946007)(66556008)(66476007)(86362001)(55236004)(498600001)(6666004)(6506007)(1076003)(107886003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KjCbpSXmwftm6Pg+R/BUOgQrxBW5MtJRLH1AiqDmc+ZpAO3IU5gepCCjFVF0?=
 =?us-ascii?Q?YvLltypkJhB3VQqnQqUJ9FfPaoChacOJFVcjrvfc19oU4O92IzzklbUKKPyy?=
 =?us-ascii?Q?/7ga+tWLGbWPbpoIQx8NSB6KO78IKecDJKsfblZDGWB4fhcItDEx9N4R6YHE?=
 =?us-ascii?Q?bsyU/plXfrJ1r45DTxVAtppbIKbllJlZXDDcINSxsK3DOBYVNQUoTDQbvVlG?=
 =?us-ascii?Q?vk0GiSKxA3bpHrxcsDKEPYPn0eJ7MaTLaDNOfEE+0CnQ37SwTCgv9QKXdPWM?=
 =?us-ascii?Q?LfTmw8cRrLX1k5Q/ido/92WsLI3pBm8n7yHLFc3lp7L6dLRMOtcnCXE0J19i?=
 =?us-ascii?Q?LX3lh/Hoa+VyXUXKbPgblqO8oajFeYPQOVc5ddA4OGY6yiMuJpPOEcpzzJkH?=
 =?us-ascii?Q?PRW+eZ5Rn2Oz0AIj9WHo06S4Xyu4hgZHkCNCN5szlUNfI84vCi2nuIz7Q8Vy?=
 =?us-ascii?Q?ozaAWMAeIWMPbs/QlXEBDYbV+0jb0iiDfzaI2HLTB1r1nUufn8SiyL5gxh4D?=
 =?us-ascii?Q?g0k7jg8LRo/MQsnYdudWzOOuh0FihuT9m7/vQkhhsJBJzsgrhAxSCPWTilMc?=
 =?us-ascii?Q?3OXVseE134K/Ko2KQTB7OQ7korLnwxhJwcCyiprrJp7wmLIP+TYAYqjSHTPE?=
 =?us-ascii?Q?zSNy0wLGztKfonFs9jejcaZ6vP9kqsCIlGS5608yCxiaIGWdqOAnqZk8m9bC?=
 =?us-ascii?Q?gY12/nWnnGhl6KEPxWS6Z4Lf6gQpiQyR8l+VKwv2DHYe+kn/g8lE2E3AhHTE?=
 =?us-ascii?Q?ugGobmJtcostvTEdNnGWeZM/8Qpbqyw2ZAh81xMTfaAsurd0MSEYf+SRMLUZ?=
 =?us-ascii?Q?OCDIRAQ3YFAZ1jwfnbgIscOOn1dvPSH5SD30uBGwuGid1LihPIR4DMIAKQjz?=
 =?us-ascii?Q?qNScQXQCK/AgwnPvXf5t2AEZl/dAoH+iaILCY5ITpCjipfk980mRARnmRGl8?=
 =?us-ascii?Q?Jxgmu2mf4+zV73y7dn/cdxq3z2N1IYNn9R+NV3kNV+JckZsg0bvTCmSGLb6o?=
 =?us-ascii?Q?P8xqC4TbIQiiuqjZBKsWJOa6PY7+MwwJ77irO4Qz8rjcp/NxkcOlHX/fmeBU?=
 =?us-ascii?Q?lDPGWmBc3lu87u7nl05M+3YF7W+2Uq9rswCF5gHnc11WAlYhxazh3uPrd3hb?=
 =?us-ascii?Q?rQobBNE66povnyoniiTTlZO7+q2Ol6kldz+IGiGIkcCmon2gcGxjDGsRN9Mw?=
 =?us-ascii?Q?XZ+nM6nXg87jiE7kH04/mwnl0JQUNon9l9s9KZ2yXd9pbHGppsGu4E8fhstr?=
 =?us-ascii?Q?CF56D4MypIh0xcAGWAl+9qTsZ/yUpohsINxhO4CgWvezs0X7JZtMoo5TrJHB?=
 =?us-ascii?Q?vdisqNL2pEq60Ed3TBZsjs1P?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b50b1a-0b42-4de5-ce39-08d931a978df
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:39.8316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p579Jua2P/beUj4JIonffI3jG98OGZSOLKgiz4OLNoGXgxms6PsdWWuqtDt/vuVAVbSHzHmA/waliovW+kPGaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1268
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/dfs/dfs.h | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/dfs/dfs.h

diff --git a/drivers/net/wireless/celeno/cl8k/dfs/dfs.h b/drivers/net/wirel=
ess/celeno/cl8k/dfs/dfs.h
new file mode 100644
index 000000000000..7630861a5351
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/dfs/dfs.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_DFS_H
+#define CL_DFS_H
+
+#include "hw.h"
+#include "dfs/radar.h"
+
+bool cl_dfs_pulse_process(struct cl_hw *cl_hw, struct cl_radar_pulse *puls=
e, u8 pulse_cnt,
+                         unsigned long time);
+bool __must_check cl_dfs_is_en(struct cl_hw *cl_hw);
+bool __must_check cl_dfs_is_in_cac(struct cl_hw *cl_hw);
+bool __must_check cl_dfs_requested_cac(struct cl_hw *cl_hw);
+bool __must_check cl_dfs_radar_listening(struct cl_hw *cl_hw);
+void cl_dfs_init(struct cl_hw *cl_hw);
+void cl_dfs_close(struct cl_hw *cl_hw);
+void cl_dfs_recovery(struct cl_hw *cl_hw);
+void cl_dfs_force_cac_start(struct cl_hw *cl_hw);
+void cl_dfs_force_cac_end(struct cl_hw *cl_hw);
+void cl_dfs_radar_listen_start(struct cl_hw *cl_hw);
+void cl_dfs_radar_listen_end(struct cl_hw *cl_hw);
+void cl_dfs_request_cac(struct cl_hw *cl_hw, bool should_do);
+int cl_dfs_cli(struct cl_hw *cl_hw, struct cli_params *cli_params, u8 *ret=
_buf, u16 *ret_buf_len);
+
+#endif /* CL_DFS_H */
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

