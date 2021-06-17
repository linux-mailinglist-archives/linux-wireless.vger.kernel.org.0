Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398A73AB93D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbhFQQNq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:46 -0400
Received: from mail-eopbgr60067.outbound.protection.outlook.com ([40.107.6.67]:35227
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231379AbhFQQMs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:12:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrgU1uuA42mb8CGdvU/Fk/6x+DKQzN2afO8GPvHJvZZhpN2NuTeZ3CVoGeBW3DwhN1mjrnJ54aPX2nBcUiPoA+lqe/+wQWO1vM4J8r5gb+eQoYXVy3HOnhJB2XgvmjIOWE6s94GWi0S8Mwolkcg/duY3Sn6q++cbN3niS+l8K7LyFmY7Du86Ry2Ot5Hj992ZALJZe+9B+fblZuljaTQyoyc2xjy9R5x08DqQN/umZwflKgkfXQRCxBv0qbzetO8bZTqhdILrWxMjMUyaMvPCl/wHGhuzobPtahWnluk2sjRO2LZ+fy6uN05zTTE3zVDjzBgpsDniIzwh3TXef5dmww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4x1TZIui1lHt+IAEkFjZfXChNYePgNOilKczZJ/Wtds=;
 b=ie6FP0oV5GxLSFgv+d2PstTYxBfl7pQATNChNI74qevJ4c3XOxHymy/S9I7M5eE2LB6ItE1VlZW0GMdJ2t4Aj86jLsEvj0NGl4CdJZUUqUeAQmoJWhLF7T0njfHvz/lEtFMzUoRMLpx9kTUcJhjxE8Qr9H9+vjXjueg3IUvYK7hQwMjOI3nquY4MZsFCpXvzdQdsKAynLrqjI+mYghwDpO/mQDsjf0T25CdhFCSNzjnwu0J4o1CSNCcKV7bSCg766J4yaID+Vu+yU46oVRnlhqBgM9A0vUuimGQec86qp9UEOTltoyCnKRofu0a1Y139zNfzt4CQAMKXStg4oHjgoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4x1TZIui1lHt+IAEkFjZfXChNYePgNOilKczZJ/Wtds=;
 b=QmjXclpmI0voNO53jU+H+PAXftR7Y4IgzzjBKEyst0RuKDOsr3S29bhM2rQ7OG0nS6JuHNewyDUVxkKxgyXsQdcP60+ijLr+D3t9KRD68Eg0an5achAcIEC5REU+BBHGeK3hXLDIk8Va1oDEFD3lKaxSoqiKKcTPdiHV3Hq2Q3g=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1075.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:07:20 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:19 +0000
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
Subject: [RFC v1 209/256] cl8k: add tx/single_cfm.h
Date:   Thu, 17 Jun 2021 16:01:36 +0000
Message-Id: <20210617160223.160998-210-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8afe4e5e-ad6e-4c95-c508-08d931a9db96
X-MS-TrafficTypeDiagnostic: AM8P192MB1075:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB1075A00D14A6DF2EA8070648F60E9@AM8P192MB1075.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IdQp8gdfV05KxuvpyUdcKqVgDo5uofst+IUrkf7XPiLgvifuoQ3n4wGokCHvI0fVNxXMnW4bd1RukUeh+gD7sJQXTE+QEyWIttjY111wMz8zts2tN3ReW+zMwjo3wln/r0gdccJZkPtiWM09W1W6Hmdi4Y6slZC2VVbs0ptdIDA0LL91+ekB7JZk4Qd3tvc5ptN3PsCWvGT8vD6Gz5wSEMYyTBwhcLJ5Cy+iMHExkw5TcTCAmDX0VJqKPfhWE+9M9Iqy6SFQImOK5qEp/AilNHDdfgL2hT6cWSgSfNVi4SYj5cst56dA6gSFa8lS9w/Hj5FhFvOAOdhMlubwXpEmnTscHIeQHBeLxmP6o5iOQmeEjPMjNG/+MdWk42tGMAWpGiyhze4priU5Rp8Y/aTMOMUmUfE6l/8kLCkRv7vCXYyNUoRGrw2WxIq84e0IWPDAY6+vaC1OStRN4B0h1b/Ca6iYRiU4v2Z/hB4CDvhsx9nqNSycokoxfql1uBHJA9QZ/D313JUNrRPeXqA+Y6Ob6x5Xavka97fvqdnHsQdV6/Unvqcw1FKuctcy1//kPFIauCIz8awrcjREzy4GlMVi5/e8apJzECvslKFOt9EH/EoSGQR3prFxDG7BiUSq9g45gSM+Yw8NvDJbFW294LTCOXFuE93bN1JPTCCRoFrWTi/1xKNQHICuxXP0rU91+mYklIHGYAdl05Snjk5mPu6brA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(136003)(39850400004)(376002)(366004)(346002)(66476007)(6512007)(8936002)(66556008)(38350700002)(6916009)(9686003)(66946007)(956004)(86362001)(26005)(5660300002)(2616005)(38100700002)(478600001)(8676002)(6506007)(6666004)(4326008)(1076003)(55236004)(186003)(316002)(2906002)(83380400001)(16526019)(54906003)(52116002)(36756003)(107886003)(6486002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7aOx6j/pIu7pyiArz1E1IqJePTVShGMQ0xx7A4YEM/cPh/qwyi5Ye1m/lQN+?=
 =?us-ascii?Q?/AulVEO0Y2+YRzYYXQp2ppYqhABwPCA/ExfLbyFGDDxzWlLHs0MLRIMA9K//?=
 =?us-ascii?Q?/rPe2zqwaXjEyVzP7vRuT+6LfsG9GW8VTpGOhiB9w97pTGPqK7y5ZoYma/Y2?=
 =?us-ascii?Q?U+bCsrD3beBDNXClDS5/4FQudShjfQjjOBhinno2xnwISmbHLzzfBOUPtzjB?=
 =?us-ascii?Q?8ui/TFAHHaecpLXVhEQVFzk7U3SQGg9wK6YBBd6LAD/QIgSvsoFDrlKKgy+n?=
 =?us-ascii?Q?N1luutZSf2fCBhqlcHJATXHxLVWQkm9DRmJe+ae07X34tYzZkztOvWpPeV9y?=
 =?us-ascii?Q?AqwdmSAnwt8LYOvPvCcL82hwzLVL0/cfo/cgU0FFTRufQtPygSTN876DzF0D?=
 =?us-ascii?Q?8ey00onjbout+rUZ1mfZ7fnluTDQl7RyUbOTvqM1Z8z8ojoiQmf0AuXQyUPd?=
 =?us-ascii?Q?mxJlstn6x3GqRYj3kla1v5B5o1m4b5JEl51tbMEflzgBrq9w8A7wmkbEzhoJ?=
 =?us-ascii?Q?PWDVMwXrsKxeAFDBJum/HYb8JhfoKmE913IMR//JICEY5PZiuXT1VV+GQJ/p?=
 =?us-ascii?Q?k+JXcdbJnBwaifb4jFrJVlLedPYt6sCkYaE//+tyjQRg+iU/zLtxvApRsc56?=
 =?us-ascii?Q?fYEYeEwgz8M1+6vTfg6tR06iaC3khubGEW1ysqnMLuI/rJKQxw8ek+74dKQI?=
 =?us-ascii?Q?zZceVExsaPCpFvy/vtPBqqJ6nEWLurIVviaFzarnszen+RKRpfU8irASGTbR?=
 =?us-ascii?Q?67dTYm9s+aK99oY3CeqR606HSQVzXDmkXzEaega0HxXwvBXvk6KfAulxuPwK?=
 =?us-ascii?Q?oDnCVia5AwUHjM3pK84RRU8vhU+DHzqle7EE5gkngroZfMqID89BbQP12W/O?=
 =?us-ascii?Q?SXLM7gPpYyp/2yWqy0cua1MSRE25gV/mhLAL7EyiL4aGKtv2+3NN3QAQ1PCj?=
 =?us-ascii?Q?H3ZNBIN6dDDlMcVNrW8am9l2g6eTYtGuTkbjf2//Aw5ZGnGgeVMfZDelsWfw?=
 =?us-ascii?Q?il9mrrqQgP3sssrtAZDI2kuHOF5HQaDTN5dRyJrSBXD7OeW+OIWLnDURo7Ui?=
 =?us-ascii?Q?r2RufqOCKM+HbDGWS3oUKJgmbpUDAy2aI5XwCkilxk02uDcGx/pBhhnTwfG1?=
 =?us-ascii?Q?LS6a/eHDZy4iOmmZSDlgvyJGMKQje8YURU+jpz1A4wSFaWemO/746/Mtm3jh?=
 =?us-ascii?Q?FuUQXVN5PK9l0oFjApa3+eECnuCKdxJvvD7ifqgG0i2uea0QvNZUkQfvXB0O?=
 =?us-ascii?Q?dSOcj8XncFx5TIGA+48ZtD7ShwYW2Lt8nGJlKm3VKviesCd075Ga5+6T+XvW?=
 =?us-ascii?Q?FcylPZEc4Fcj1U8v1PtYzrYt?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afe4e5e-ad6e-4c95-c508-08d931a9db96
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:25.4494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Vr2Wm8AkGeKe5kZxDCmiyQZ5y5v52fugtxZZ4H6LCu5j2my8X7Gb7o3f6BwD1klYsa8iChqFk71SK2FVA2BDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1075
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/tx/single_cfm.h   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/single_cfm.h

diff --git a/drivers/net/wireless/celeno/cl8k/tx/single_cfm.h b/drivers/net=
/wireless/celeno/cl8k/tx/single_cfm.h
new file mode 100644
index 000000000000..f04b93a51ba5
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tx/single_cfm.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_SINGLE_CFM_H
+#define CL_SINGLE_CFM_H
+
+#include "tx/tx.h"
+
+void cl_single_cfm_init(struct cl_hw *cl_hw);
+void cl_single_cfm_add(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr, =
u32 queue_idx);
+struct cl_sw_txhdr *cl_single_cfm_find(struct cl_hw *cl_hw, u32 queue_idx,
+                                      dma_addr_t dma_addr);
+void cl_single_cfm_flush_all(struct cl_hw *cl_hw);
+void cl_single_cfm_flush_sta(struct cl_hw *cl_hw, u8 sta_idx);
+void cl_single_cfm_poll_empty(struct cl_hw *cl_hw, u32 queue_idx);
+void cl_single_cfm_poll_empty_sta(struct cl_hw *cl_hw, u8 sta_idx);
+
+#endif /* CL_SINGLE_CFM_H */
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

