Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E684F3AB85B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhFQQHH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:07:07 -0400
Received: from mail-db8eur05on2082.outbound.protection.outlook.com ([40.107.20.82]:7360
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232807AbhFQQGk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:06:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUKgI/dcn3gyqG94SCvdOOtO2JvxTFFctvmu8X5lY8cfC12kWZJdrpVXlFFT7+NNjBE7TO7KiDzo1Dlk6p5r+juHyr9tdRbcz4A4KPZVUcLaSbbathFJICsxOTcjIixcwgtSTInUIYwVEiLzfumvxw+8tkmtFWT7toVF5a1rkzqWaVw6mlI4s6W0oWyZltKV8tyVKPwrUhWhM9f3Srky5UwsOuCEaRvvKGdAJ9HioEDsFJnqp+lCs3gnUaPQKYhPu8LUGG6dVsR93hl5zllFlsKs6nUF4NniDfcykewh6KHcBN4G/uLiUNMzzzNa1NLfOztxH+X/cwOHjHhH/l33Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEwZSJPAcBz0bX2V+wMHeNmrys91/PC6BUP/VlGi7tk=;
 b=QRbQ2Jt0R8Rep1MB+vgHv0VEbQQb2/CQYQM7WnsQxqOekaP7tHzpobWhPQZdr+FbaWIAyVovYuuR23haLRqHPgyIlsF9FiHSWwSjbMQj7TP41yZekXDdF+FA7Xo44Zbuq8hMwmxgrnFy/dCgoWqBw4kS4kohkHggBpwZw1GOo768u6DQWHJr6qvje0YUVMdSZ9HKkAj+COL+ITULznGJmeiaOpeIfvO1oiotoAsYtzMeOVmDSfOxT4qVOOQpZGxifA0YKceVoeWCTAD2vVopTGR6esh1/faA136XuyPanz6Sv55M+pNyj95YoYDTBxmZ9eNuZLdYkqt1VjFntQU/rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEwZSJPAcBz0bX2V+wMHeNmrys91/PC6BUP/VlGi7tk=;
 b=pxpCFcGKHe1tRe9pPSl/uexZBr5tAZUF+OTiRgxZ86ZdDDl1SliSs3EuJe2EE+LmGSgv84jes38ae9X8WhXMPT5WuzpGz14yqb+hyrGoARA9skFEIq+LSz2w57IR87/AAfDuemSek0avwDfqP9yTK5c+DR/BTpdcft/VN9riTUw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0871.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 17 Jun
 2021 16:04:25 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:25 +0000
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
Subject: [RFC v1 078/256] cl8k: add ext/dyn_bcast_rate.h
Date:   Thu, 17 Jun 2021 15:59:25 +0000
Message-Id: <20210617160223.160998-79-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 454a1350-d1fd-4de3-8106-08d931a98489
X-MS-TrafficTypeDiagnostic: AM9P192MB0871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0871E93B56C3E23C32582DF3F60E9@AM9P192MB0871.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0roin+jiIKyqaCskf7XSrOxX8bW8tpGfiyXeRevqfL7eSkbP92/BhEZFElOnJouSv3G0jjutvGJA5fP4Cldh3sRHpiWvkdOEV6PAKuujxT+OBdoQpYhzHNPerwcAx/tGKzqY/w9NO5anGWYSYJrZdyZV1fgJO3LOEvSgtCSw/T9gciMfs9hoFseGd8p6jkqFfTcZNSYqZp8oLKuuPLSiXia8ZAUOJUGXkAuhZXo6LFMvI0P41puqGCU+V95ZogPAXcIO0/iF5PNs6UBkhi/3dZV5y4WpxcSgDdTtFW0KpnmPpLd5ZiefBowuVtX/k2ppLdmZfZVYvcVLHzTj8fln7wlJW9daAterikY/+2AS+jUmMVskAR+uB/3wopWD6nHe3eyGUKFXJvyiAWqmZfWirJRVGnezdCWdtlOkMiMUZNxVJ6NbRgwtwSyQs00c287nF4DVff0hZZGyzB/BW7i8SI/i7NvFsLVjLKoXMZcQ6Zpxi5PKd/BD6CaCY6ubAGseKoRVQdRxo2CkWka59HLcgfv2RFE4bLv4nVXQA2g0ImB39WTPAHNFR+GLeycneF4avUHJJlizP8E4uuy97jofRPZCbcT1JRKX9URJRAQu1p7kHW0KbjCET9TrOdtVFKNKCKFRljaU3H6+OyNWMdFi6eCdceHR3TAcqd1gDzf8pGO+QouCOumYgWHNOQANVzUEmMuEGAOqKstz2BCdQDELpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(396003)(39840400004)(16526019)(66946007)(478600001)(26005)(66476007)(6486002)(186003)(66556008)(9686003)(316002)(86362001)(6506007)(6666004)(6512007)(55236004)(38350700002)(1076003)(38100700002)(4326008)(8676002)(83380400001)(5660300002)(52116002)(2616005)(2906002)(6916009)(956004)(8936002)(107886003)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7QjF7x7jp7iOYwiCNb3Le3c3alC2buZbWx1K0hwwjxSssELO36tB5+Z5VoGi?=
 =?us-ascii?Q?tj3QtK9P03/w7OM9CJ+vT2jt8Fp8/xU52l8GpgAw1YbYI62pBcVMtO+M77OI?=
 =?us-ascii?Q?w4oG11G8n6MwMnNIInMAHNgKQKjrjc+8WIb9DRXjUWvlYIOFO9EHxp6zKQp3?=
 =?us-ascii?Q?dDfRNenrKNPb91IbSTrLc3/BHPdG8pWSHDjYRb1gyO6UTJd9M8nY5Og6PqqE?=
 =?us-ascii?Q?NqVXMZSYDfY/BabeQmrtFPr3EAS012yxl9hPx1CnM/9zvD2GpW7lOWBr4xfY?=
 =?us-ascii?Q?1ZMaVwLS8V05QZtHtgYstlJqn35Ram+7VTVUXLjvuaLbwcLk3UJ6UpIDmU5D?=
 =?us-ascii?Q?b0ndbIfua82E3OW9BgPYBMW/bxBMwMAebOQKFzUG/qhUPj5E1Wp6uMOGjDPm?=
 =?us-ascii?Q?7JuLViE0mvi+rouSXHJ1zIeEqkVqDm34OJvcpjJmTdeFyMaeKTq8U2UAL0iJ?=
 =?us-ascii?Q?nJvt+HDD8mVE0WMrYnxxDTD7AoR+vNF/kbPLDl8ZUxqYSo3tVIiZJiM9YCLJ?=
 =?us-ascii?Q?Z5nc++G1m9UzVMc/xDtt2APLFrKcBfC9ou+jWkyTeKoAtl/1VPblI0XIfR2u?=
 =?us-ascii?Q?F53CmYR7+8k/uB2TE2sFokKTf8RQ3Lq1gOc6/jvjUcfyYkCTzHOEJczzHN4R?=
 =?us-ascii?Q?V2GBcMiagdyckxwaonkIY9OOZeDAhq/tuFwD6FRjxIlwG2L2ft7K0V64LhML?=
 =?us-ascii?Q?1b5+C2Tf54AQPRK/yVnf/4FAayZEd2/vdN5psLEVx2m2e8SPPdSyqDX33Nof?=
 =?us-ascii?Q?i24jAv9Bd2637uIHzQpJ04UgqctZB1ZfvULGSYAhvfm/3o/jVbsA5icYW8VT?=
 =?us-ascii?Q?DsLKi5zcng5riXEaJv3WF0Yt1eRvUBoBLskKNEPDYaFxahz95eEn8LKCXebX?=
 =?us-ascii?Q?e3IW4NGe+jw4CmrUH/U6deW6sDbfjarWWfVRIQt/XvYtJiTHFUcNsQTIzKGC?=
 =?us-ascii?Q?5sxr2tlJ9IgWqYzlATW5Ji1QaNnn3T4otbSo8YnC42xOHNn6Zxs9IClcCH0e?=
 =?us-ascii?Q?qhz163sqHryZmQKI8X3XgwaS7F1ey39jkt+8cnFF9HzO+mTTlKn8KpjliHKM?=
 =?us-ascii?Q?TNUuzlw1Xz/iasSfeQBzutocs8iqFppOEi//mRB/vtKQcw0YG5hu+rrh3vqU?=
 =?us-ascii?Q?f8uWXIr1zpf1+I55VT23qQ38x4a8Sq+/gFBgUUVvXYiKwsZGHZMZCQSWc1+3?=
 =?us-ascii?Q?U3ld/y86WNJRjCbo8/FeaqtcQbASHBdfpnAqsnlmt5QG9jzVc/5dvPuX+Bb4?=
 =?us-ascii?Q?SDO8JI/CwotGbYEYcOIkreeLV6j3xv+p/Cmayty5x1GJBuwAHiOo5Dvynlmm?=
 =?us-ascii?Q?NGGUmAkj9iO6rMYhrS/oGsnO?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454a1350-d1fd-4de3-8106-08d931a98489
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:59.3778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBX0IZ7A2YVdjDjmukLEXCOP1dThSExVFHSYwn0scckqPCSa0SFGutHjT+X/KxCbuWwZl5NqxONK+Gds1OME1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0871
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../wireless/celeno/cl8k/ext/dyn_bcast_rate.h  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/ext/dyn_bcast_rate.h

diff --git a/drivers/net/wireless/celeno/cl8k/ext/dyn_bcast_rate.h b/driver=
s/net/wireless/celeno/cl8k/ext/dyn_bcast_rate.h
new file mode 100644
index 000000000000..d5d828d85fc7
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/ext/dyn_bcast_rate.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_DYN_BCAST_RATE_H
+#define CL_DYN_BCAST_RATE_H
+
+#include "hw.h"
+
+void cl_dyn_bcast_rate_init(struct cl_hw *cl_hw);
+void cl_dyn_bcast_rate_set(struct cl_hw *cl_hw, u8 bcast_mcs);
+u16 cl_dyn_bcast_rate_get(struct cl_hw *cl_hw);
+void cl_dyn_bcast_rate_recovery(struct cl_hw *cl_hw);
+void cl_dyn_bcast_rate_change(struct cl_hw *cl_hw, struct cl_sta *cl_sta_c=
hange,
+                             u8 old_mcs, u8 new_mcs);
+void cl_dyn_bcast_rate_update_upon_assoc(struct cl_hw *cl_hw, u8 mcs, u8 n=
um_sta);
+void cl_dyn_bcast_rate_update_upon_disassoc(struct cl_hw *cl_hw, u8 mcs, u=
8 num_sta);
+
+#endif /* CL_DYN_BCAST_RATE_H */
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

