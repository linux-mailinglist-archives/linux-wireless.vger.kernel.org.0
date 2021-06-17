Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925733AB91E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhFQQMt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:49 -0400
Received: from mail-eopbgr60067.outbound.protection.outlook.com ([40.107.6.67]:35227
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232424AbhFQQLm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRTYI/2mAEWJiTogoJbkA9q+5YivazWltAWLJZ6ugIRP9KY9UdH0LDhkslETgcpFK3n7f42QDzwyeaaOfQgMtU0sQLThAM+YFKCn6x5s6zb0NxLBEXYRpgcouRlOgv6FqH16MBKTxwH/X+hYtMAgKkFX8GBG7EJQmaHu+AlmZE/+0uVntg0RsIn5QSCkN6D0wOiAXnOIivS/iuCzvFst8p6FzMdukpAH6tYirivGRC7Wo3x9rJAJQuDX+4y2DxoK5pTgNrAWstY5LpeaKVj68lmuyNxbwkhY76KkazLBY8z0dXoJJMyRRo/o7OUwQAWLHRkrlHYRVbhIUZo/lwwJOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKzxNTiGTDkGbZDF9V6Cb9gJKoFJ+37khkXqxDNrPAY=;
 b=kBm6m3Td5XPhO+9OZbwskotLgmrcVQjdfae94Fzb6LvuasdTtjMQhe3OO53h/o9mC60pFpCwzPElolhWVmHx4mGPB4Ya6zYAs/82yQeLeP52RAqz89zuc1XZDqmpaIUW9T8hVTidc+nkZa/DzeV638CEA/Qci95mkk99sYrvLehG8OPEGWTjdAkCexm4GxXj0NMIOS4hq4MT2dnIiNUL9MrKaPCMz9hEIxiLZ7+jfZQPh3a/cezSmZYRxO16DUJ6Lz9dNJ558eRcVMyhXmmIwhwEYe+8Sw6K3Q8gH4WwGq1DAgFdlEH8jiFRVASOAStGVxGzLv1n9iWoeXChN/lQXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKzxNTiGTDkGbZDF9V6Cb9gJKoFJ+37khkXqxDNrPAY=;
 b=ATLH5ZVYco/iEEUwuQlXUtW+r6rotX8au/xM89DLswdj/52g0DdwHhGJyHFssl2IXlrAVX1uRHEqYdetFsF8XBUi0KkiHjwWe1u8Xj0jWcxWeni+zo2/zuqSarh/fFYvip7XxrNFKTTZ+qTreqb0orRVFxIiIKU11RB31iGiu9M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1075.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:07:17 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:17 +0000
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
Subject: [RFC v1 203/256] cl8k: add tx/agg_tx_report.h
Date:   Thu, 17 Jun 2021 16:01:30 +0000
Message-Id: <20210617160223.160998-204-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a958cd0-16c3-446d-99e9-08d931a9d7c0
X-MS-TrafficTypeDiagnostic: AM8P192MB1075:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB10750CAAD3DBF3310AD30C80F60E9@AM8P192MB1075.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4jF6dPA7plbBMFS2R/Veqoip3xR/t8Y59b9xg803M2Wh3qCBQ5wCgUaT+Ngn411sV1g0c9pj8Argl9ToQXXLRQ1kE4g8Vlxcjv3l3DKnSRWnLYsX82yOwMUUPZLirOyMVXADFE2xP40ORI8KcYkaKAy1cWjxCiFslAXujxG2ah94X/QrK6RMGHPGQqke/PJG3xV4WQq3Qz6CGCNkdsW4unYsvoFKIEnc7tN7XyG38AGevhPkK8Kike+2pf+tPHzqt7Z9lUuof80q9gpCGwUt2F50w6UEtLfbe7qPWcxW6DoiHPA6Pgw/uTG2you9CCnR4YMw4Y/xf/M1U6I+2+Wn/3ajT3Hkh9sTJ3q01lxijm7h1dCLZi2DevJYRHDzDv4WocsPW7kVx6RgAhf7hmHAqkT5JFwt/E6VnDT30RzeZpJgtpRIIccNEVk2rWfXOu33VjWXCQrcDUH0emZ1ggDxXK0N1xGidudeEXG0ipYZ7DyzhBdAmFkIvX6IOQrsL0WbnekGLkpkkdOsFvUEgRVXHziBQd4uiL65HDsRxSKE7KrQORerl9aqQv8v7XjHR1ziwt8Wg7s6UQ9mhOTVhS1qZBfN62dFsQ72de6uGb+MKEvmUyEUoYijFiEwID8w1XBZyh+fM9B4lspNWjFRYrytkzP242w4Z2Qps9Za1eVRdLZeRfpMeLOEbTUhY8Eu2u8Z3QV9p7PGI/JReG4JjEVzoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(136003)(39850400004)(376002)(366004)(346002)(66476007)(6512007)(8936002)(66556008)(38350700002)(6916009)(9686003)(66946007)(956004)(86362001)(26005)(5660300002)(2616005)(38100700002)(478600001)(8676002)(6506007)(6666004)(4326008)(1076003)(55236004)(186003)(316002)(2906002)(83380400001)(16526019)(54906003)(52116002)(36756003)(107886003)(6486002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VMArOOxV54Qkyh5sbLF5TWnYLhNchvpCMNEtZGuVvI7UQKRk+gZdV3kjQT8P?=
 =?us-ascii?Q?ofLJ78pwUaVhpwesj0b39QsvT6DXqPIvEWqFIy63hSVigC51nyUhDrtYMCVb?=
 =?us-ascii?Q?gDuOH1CLyYX12BKHCZXhjGuEhlyK145kmTVwqP3csLCjQjTZ1Mum4WzCg9E4?=
 =?us-ascii?Q?8A3Uja1qAk5f18dcET8LG/NcKu2MWV7JFDjoOxWk/5Vv5MsxrKT5EzO+XxqF?=
 =?us-ascii?Q?r/xc+W6sT0pp95/o2f+/9IZvKE5tL2tAGTgL2AqWu8aBBAQHBhENo+ARssJm?=
 =?us-ascii?Q?WqWTKok1ZmaOdIaHWMK2F32R5ScsfoVHYaNYXBjZmuddUiv7ZcnJ3gm97Rjs?=
 =?us-ascii?Q?YQHQn69pohSFqa/L9vFZLnFhxtBgEHzRyPUCMxQRx2LkSKTki5cmDtobFW8E?=
 =?us-ascii?Q?FiTvAMtqtD2F4l+I8WQOPWU7D5w5ahOPy6qEvojbCovwqddRMWjQzNhVXVVb?=
 =?us-ascii?Q?gQLns7FB42MiPQ46TYJzjZ47qhEW1qzt6eraja4FUD6MirCly3ign+uFCBfn?=
 =?us-ascii?Q?m4Lw/jQ9QrdhRjePEliO6IAvKMEq8GFv/3WC1rDCnnXz2W5fH8VGVs4Ib/Xo?=
 =?us-ascii?Q?9L2gLBa+Z+z/Z0itHTNNtDSnp82N5ru1GqiNza5fVZpc/fTWLmyNi2IDzkuM?=
 =?us-ascii?Q?2i3QauZCgEB6KFSWxEFGejbwbb1Gp6XcGaZss/IMZJvOaM3H9M1elQ3CTn3g?=
 =?us-ascii?Q?oGhyNXc5EMjwIpJs5pg/N4qUiQ4IgCijXTduGfJ/xBjLGq5SBSV8YSi11AZm?=
 =?us-ascii?Q?DbA4R0TaPptERj+Eu0WLUokOvqrbgxaQAJgFI9HIa0RXR5t+uslOeiRh0lPU?=
 =?us-ascii?Q?JAhwZPtOgjQ8zrwAe9CqAAbegYeVsge4G/iSNBO9zo9WNiSQ3PMduez17XGi?=
 =?us-ascii?Q?mUZHwLo+dQV5ZlfISWrvWAS/6J88ok2+aWfIgbz+5QuIm8hriiZ1s3jprZ8k?=
 =?us-ascii?Q?qql75HiXxg14Z2xaMiOGN4Qs58cpg/8ulZeoCzCz0OFRbRQk3/2y1zFwtMn8?=
 =?us-ascii?Q?JIMJ+U1ZepIRVx39iFTxI4gLfgiMPwGVx96u4Q9ccdtkQsMG0/MBpbA+KQnZ?=
 =?us-ascii?Q?LTJt96VaVaFZGabh19vmvyQ8G/Yt0CxZPBaakw7oMFeWbf+eJz1rriii+Eyk?=
 =?us-ascii?Q?E5R5w6+PP8pHOtYvIexTvQs0pQlnnz7Z4abiLl2/gRuNs9MzwdJLiN+0Gvqh?=
 =?us-ascii?Q?+ApY1gN/9Pz4+rnv8vjrFGCE8vJT2pp4Hxst6s/HzqzBYyTXx0b7nC8aAvp5?=
 =?us-ascii?Q?pYhjLlwOXpfhOYYLVpBYi84iPPuVcYEei3ZfhlGKBj619ycQ0W5zzAKs4vME?=
 =?us-ascii?Q?kgQT71wuFvMMryQ05cBoOpnT?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a958cd0-16c3-446d-99e9-08d931a9d7c0
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:19.0057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUZqqfBf67oOIETREiKLlioy7lVMzK0WENW60wwPynKgkOe+iWqHP+tb9GNxIAvMfR0DBx/yInr8dAnwgl7NSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1075
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../wireless/celeno/cl8k/tx/agg_tx_report.h   | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/agg_tx_report.h

diff --git a/drivers/net/wireless/celeno/cl8k/tx/agg_tx_report.h b/drivers/=
net/wireless/celeno/cl8k/tx/agg_tx_report.h
new file mode 100644
index 000000000000..def24d2accd8
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tx/agg_tx_report.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_AGG_TX_REPORT_H
+#define CL_AGG_TX_REPORT_H
+
+#include "tx/tx.h"
+
+/* Structure containing the parameters of the MM_AGG_TX_REPORT_IND message=
. */
+struct cl_agg_tx_report {
+       u32 rate_cntrl_info;
+       u32 rate_cntrl_info_he;
+
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+       u32 sta_idx                    : 8,
+           is_sta_ps                  : 1,
+           bw_requested               : 2,
+           is_agg                     : 1,
+           ba_not_received            : 1,
+           ba_received_empty          : 1,
+           bf                         : 1,
+           is_fallback                : 1,
+           mu_su_gid                  : 6,
+           mu_mimo_valid              : 1,
+           mu_ofdma_valid             : 1,
+           rate_fix_mcs1              : 1,
+           rsv0                       : 7;
+
+       u32 success                    : 9,
+           fail                       : 9,
+           below_baw_cnt              : 9,
+           num_prot_retries           : 5;
+
+       u32 success_after_retry        : 9,
+           success_more_one_retry     : 9,
+           retry_limit_reached        : 9,
+           is_retry                   : 1,
+           is_rts_retry_limit_reached : 1,
+           prot_type                  : 3;
+
+       u32 rssi1                      : 8,
+           rssi2                      : 8,
+           rssi3                      : 8,
+           rssi4                      : 8;
+
+       u32 rssi5                      : 8,
+           rssi6                      : 8,
+           rsv1                       : 16;
+#else
+       u32 rsv0                       : 7,
+           rate_fix_mcs1              : 1,
+           mu_ofdma_valid             : 1,
+           mu_mimo_valid              : 1,
+           mu_su_gid                  : 6,
+           is_fallback                : 1,
+           bf                         : 1,
+           ba_received_empty          : 1,
+           ba_not_received            : 1,
+           is_agg                     : 1,
+           bw_requested               : 2,
+           is_sta_ps                  : 1,
+           sta_idx                    : 8;
+
+       u32 num_prot_retries           : 5,
+           below_baw_cnt              : 9,
+           fail                       : 9,
+           success                    : 9;
+
+       u32 prot_type                  : 3,
+           is_rts_retry_limit_reached : 1,
+           is_retry                   : 1,
+           retry_limit_reached        : 9,
+           success_more_one_retry     : 9,
+           success_after_retry        : 9;
+
+       u32 rssi4                      : 8,
+           rssi3                      : 8,
+           rssi2                      : 8,
+           rssi1                      : 8;
+
+       u32 rsv1                       : 16,
+           rssi6                      : 8,
+           rssi5                      : 8;
+#endif
+};
+
+void cl_agg_tx_report_handler(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                             struct cl_agg_tx_report *agg_report);
+void cl_agg_tx_report_simulate_for_single(struct cl_hw *cl_hw, struct cl_s=
ta *cl_sta,
+                                         struct cl_hw_tx_status *status);
+
+#endif /* CL_AGG_TX_REPORT_H */
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

