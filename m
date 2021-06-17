Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CE73AB930
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhFQQNW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:22 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:21118
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233808AbhFQQMG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:12:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQTs91xTLOZGRV53ZjXVBL/Cc3iYgScSoThBk6jpaFBLMDaeqJ4LImaxNw2RE1SwbFVncSONlohfUYt43hdOneXclw+MTzuBzUYpThe/zO0tFI7dw5Qr/0eo5Q7bhFgE00TCP4JdV1zqyjvn0kI6BRn93dnK2BdeCu9m4EWDa/1fXmxtFnq9635XjUCGQpZl5xkoOoH+Pq+sN+G7laIxLnOff6q4OoaKkxHcE5KO4y5t7csx2TmPIUp89fI8Oa/lFilH/p9tdKb1ne/XRxq2L2SyvQuwueCGMyyT+tZg7NHZHHKw/w3qDmCRmxTJ7Mlcaqs4MVBZSsPuzYuN1JqEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xxIRiwRYVg0/yxEseDVfslxWBjVO54Cq9ANtdsw88o=;
 b=FFwRaYAjkwXIWJ3faa7KvBpZMR3ek/B1E9p5UejxNmRqObnK8g1YHdn26nR1ShPU2rgkVgieA0W+JtiBIgbW6yt5XyAblqOiwTkbm36t8t6U01zBedwdqDbVY6cziw5CDbJdKRktLODtSSAmQK4vDAqXVcC2Ywybm8YJ9HvgFRw7dzDxzf1Jq4WkQKpOy8FmqsvOzSppoUsIX3CIOtikopOB04vjHZfHZzyWm9LsgKbxyG2L+CVAJLMVeqgvuaW6C54gkgtQJ/YL/pJYTEWCnotdoQQUBEwIm6aaNW/WIMhPodfUELkuOMK7kjBh3WY3RVN7wwPrxHkkrKpIIkBm2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xxIRiwRYVg0/yxEseDVfslxWBjVO54Cq9ANtdsw88o=;
 b=lXEH9LeQwivbsF7MPKYgsZqGR79hsjkyjYmZ3uVLA18nkNA1Vn/3zm68ZGDidc7ph9utOBwa7CyFP4TVItHbq++iBR7H4fZ8UPHCQJdxb75Q0Hv4UA1gNL8SpNrC/gJmIPgsdpePkROcrTQnKnjpXBh7/voSDlDE+0cVbF4P9ac=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1075.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:07:18 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:18 +0000
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
Subject: [RFC v1 205/256] cl8k: add tx/baw.h
Date:   Thu, 17 Jun 2021 16:01:32 +0000
Message-Id: <20210617160223.160998-206-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09ce6556-8d9d-4d94-4c4d-08d931a9d920
X-MS-TrafficTypeDiagnostic: AM8P192MB1075:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB107550289A2FB2993B2C0888F60E9@AM8P192MB1075.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1lgXdEZLv6CuwIG+JOkDQ290COZy1hwRnZFIFoVWivwxoSfmIGpEQAcZwOICAuC5RrDjSECIrhIFV2/R8oeckn4ovg5JCq4mbvnfM/rFowhxag/50BEEkVvP/Rt/UcZ70apI7SrVEHyJ7YVbrhwfhtcdz8gYCnMS+lWJ9CnM3+8i6DTCvkA6FohkrcPzI3I3xuFVjBqjL3eB2vDIvdrvCJ5YS3CEThFfny3Nc0bw96awXTkI4oRkssL1NmjNPJw5VxtkbiMVbQOzYfEWs3snpcRR4IX6N2gqhXsGT7nNSC0Lr7gTIkYp9irOzmWvE0L29qlQGz9uWd39Zjk420dh8gyv9MYVPNBLp255b12AJoQsI5eRWPexWkfUQ/6UvMTm+Qg7ZI5qiaEfGr1fK2wEXVPmxrwsUM5mqyb6xfvxEoUHqJ7ITLuTEPQ/JdjEo5L7Y9fhCSfeZqgPiKFmBN7DEYfpIggs/CjY/Y7QDhKd3Pb2Iar9UVrk2HCKpMh9MLthBJzjQrxz6dnkXURFkm4r2WquOr2oMNp0pv3fhGaNYDRGBrtPkAfmzhPhahWTjWAonIf4G8MzwoO6bRe3zy82+B9FKfsEgbwz/E06QyNb9p1kWhQDCfukUUOJaudAVCEp75DgJ3KPuC7RHQOWpTY9E/wwmc09yCnL11ZhmBPmPsKBCeZ3aL5lACLjDetDJvSnkGoG19IwtEztOtpzqkzjJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(136003)(39850400004)(376002)(366004)(346002)(66476007)(6512007)(8936002)(66556008)(38350700002)(6916009)(9686003)(66946007)(956004)(86362001)(26005)(5660300002)(2616005)(38100700002)(478600001)(8676002)(6506007)(6666004)(4326008)(1076003)(55236004)(186003)(316002)(2906002)(83380400001)(16526019)(54906003)(52116002)(36756003)(107886003)(6486002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H/OBHrticB9V5yJ5eP/RNkK02AP7oecKKjLyEUAuPX19hyiXrhYNOcG2VX9W?=
 =?us-ascii?Q?ufQVWyIv9X129EuGcB5O7iukTEaewlYEg7gVSZnJhEcDV8j7lLonCQwVtQ/B?=
 =?us-ascii?Q?1U4d8qbTdO/DwwpEHvJ5dAG+yIRb+bFRo0bWw8l54kDBFUvi91IjR1ph6Q4V?=
 =?us-ascii?Q?dJVO0A6sHbZayMfgX6Yc72MFDBB7MRecFYwfotcGU/OFA5/z+CJFIM0jPaJP?=
 =?us-ascii?Q?r/QGDQuaPsFv+iZuzOOGaIearD0YfWf/+Ty2m87WMwj6tBlOWnNVciq3ZLW+?=
 =?us-ascii?Q?x1NOrCLK/GJwiylAr6v1+I1J/GL/iYt4E+xLEOV2DFGOkdfNRlMNWJJx3KFs?=
 =?us-ascii?Q?bJKj3nW9xcJNCboGuArGnWGOZycfVim7dStc+tfk4SzpFxPUTSupD1SJEhgq?=
 =?us-ascii?Q?TjOT35F8L/A0E+2bWOEfTdqSWw8unIMJCmdTRQSCzbPqkdLcL/PmdLaD9kDr?=
 =?us-ascii?Q?7897LZFgBIa2RFd54xieHfevpg+2u8AYLfDIbbf6Kf2aRcxaJGHnepuoMqMu?=
 =?us-ascii?Q?QLBxQgo9uEEpGsQa+4En60fEb/ZIb0aBm/uAO+xPLWH47wB+HItgvg9EKOwV?=
 =?us-ascii?Q?clmHqMTZq4ymeKQHhvqEc7KyVOKQKxUlBzbwLZYxiv/zNZO5F0iEaCAj1pFG?=
 =?us-ascii?Q?+z/NtDEdmO4vZuz1618ofPkB0Sf5S52pO1aGEJR+ZyE4W5Gr6pKVm2zsn5oL?=
 =?us-ascii?Q?yCh+sHF4m61nM7YxQuZkrYyTd1mesHgakoLvbaJbXAntUoJYlHWvQ8OSgxJE?=
 =?us-ascii?Q?2z1Qn6+nSq31Nn25ZGGYIj4mruu/bfBuGOL1h/khuzrAQFL+IALAYtQq/yG5?=
 =?us-ascii?Q?sHAuSmnI1+2umqBKPJKq2t4sk5QbQvvvUiCjDcQzWeDFiQQZYbBsX5KsH0mR?=
 =?us-ascii?Q?WacPN0OrfXgvTkbL13IW47JrasTy9CuRsywVU4ADozAaTF3cb4iF48xGe0wh?=
 =?us-ascii?Q?mhqn7vp4MbtjlZ/NliODq6QC6X4PcNMblMNVIzhWr8szGtHMAHoXb8xg+zYT?=
 =?us-ascii?Q?TgRy+zJxSez63N105yePGbdN97+Qx53ALX0aUA/Rq0fsT6CSUgVfLRHL0+8K?=
 =?us-ascii?Q?uTQi7o7zEwEaHDNuWzalFLIGmN1/D13swOtKosmdKEN/6xhEtPlLznIdSQY/?=
 =?us-ascii?Q?TSvOrTd17py2LfPPFviBh7wqyvMVtLtc+VrgyLNiIexX2blob2G+WwV5B1EB?=
 =?us-ascii?Q?uJmbd19o7v0ukl7YDiMw6Q5ri5JwLpM5XGq9mL/bY06k5nwf0s8QFevJLby7?=
 =?us-ascii?Q?eeLvaJDXjI6pcxyjp9nWv/AqdBSc4JyC98xOMBO8j7VFd1MUkvRYWGHNnjn7?=
 =?us-ascii?Q?CUQm927o5kQCAhLiY3dNXaSU?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ce6556-8d9d-4d94-4c4d-08d931a9d920
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:21.3056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZjRM/uIWDL2xjrX3junraF9k2uGbSH04YJZhoPWtKCaiz5kcMkcvrhgMXg1uYKprZdQANBVyAnhHw2k2kV4Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1075
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/tx/baw.h | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/baw.h

diff --git a/drivers/net/wireless/celeno/cl8k/tx/baw.h b/drivers/net/wirele=
ss/celeno/cl8k/tx/baw.h
new file mode 100644
index 000000000000..448fea76422a
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tx/baw.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_BAW_H
+#define CL_BAW_H
+
+#include "hw.h"
+#include "sta.h"
+
+void cl_baw_init(struct cl_sta *cl_sta);
+void cl_baw_start(struct cl_baw *baw, u16 ssn);
+void cl_baw_operational(struct cl_hw *cl_hw, struct cl_baw *baw,
+                       u8 fw_agg_idx, bool amsdu_supported);
+void cl_baw_stop(struct cl_baw *baw);
+void cl_baw_tx_inject(struct cl_hw *cl_hw,
+                     struct cl_baw *baw,
+                     u8 fw_agg_idx);
+void cl_baw_pending_to_agg(struct cl_hw *cl_hw,
+                          struct cl_sta *cl_sta,
+                          u8 tid);
+void cl_baw_pending_to_single(struct cl_hw *cl_hw,
+                             struct cl_sta *cl_sta,
+                             struct cl_baw *baw);
+void cl_baw_pending_purge(struct cl_baw *baw);
+
+#endif /* CL_BAW_H */
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

