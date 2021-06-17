Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF913AB915
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbhFQQMX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:23 -0400
Received: from mail-eopbgr70053.outbound.protection.outlook.com ([40.107.7.53]:60423
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233729AbhFQQLS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xq8nGbuN2losKzgjzAw39txKwGnN13IQLPGJ488+loxOAQvcVdixFc3DtJZdR/rGWCxU7gcK/sRMLAipax/RxJcuNATgcn6LMAdQvUlypX+7QHtpW3UOCftONE2rRik34kvtuu5ILRqwqhni13vcYGR3dvjSDi1HVYDAq2/wMD8LTFQOozDhQaVCN5ZDYzQEAdrzeknOJYoHgW2WZerkmK2lExuH8P/L7x2Z2nUkJZaXk/UmcIb7y2H78j4qFoNBX0t2IwiosyGGszSLbtxzMzVmN2HelHjnySToZ2xIAtKilWuFIvsac97zc5/LoRsh4t1xs2fhEZPByfA1hWJbhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67mv4CeZUmgxzJ9YGbN0Kf4hf/t+bB1A4jzTnTyYsUI=;
 b=UujnCMeVzXb6e50O7RiWbq+dLxODMPieITlCjE3g/Q7lrYqVom+117cd4JDOdAmfvKml3jCqxFpq9jRIgJlELKBKx3BU/Z89CshuvJl1QWyS83kjU2jcYupS5M+giDKTdcuCHwsrHi4/TkNHLPSw5qsJP4uy9rErnik4FNZ5ZU71w+vnI73CYGO/zJ2B9euxg06P4HSVqW2SqivA6zk7c8ruKiEIHUCzWCXJr9dS9/yooWpBSi89s5UmS+dd6BAe7hzgfl9hJNWQpNHlZvs21dwb8lR8GDii/DKm+aozjyPi7xWatzipXNvvOKq56YjZrvh2LuM1IC4FcZ7KhArJZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67mv4CeZUmgxzJ9YGbN0Kf4hf/t+bB1A4jzTnTyYsUI=;
 b=hVhYUvJOXlXJ2GOfPP2uALF8/SLcGl661PEcM5ZeF9Xdc2q+1htEt3/pfz5T577xnCehqqmo6bp1i7SwqR2CtZJNoDfX1hfybBKlAPG5EgNgMrf7elGqdOgRacQoKSfNfAW0pSCXBNm900UYoLbWpwPK/3M0AhI4ZQiWh7ssvoA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1187.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:06:31 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:06:30 +0000
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
Subject: [RFC v1 167/256] cl8k: add rf_boot.h
Date:   Thu, 17 Jun 2021 16:00:54 +0000
Message-Id: <20210617160223.160998-168-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35af95a1-cb88-4f55-7821-08d931a9bed3
X-MS-TrafficTypeDiagnostic: AM9P192MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB118754BC078AFAC5DF1231D1F60E9@AM9P192MB1187.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 53Em1KAtwW777pQNcHhWy7YulrsQzCHTpJ/6WPScxN2Kp1UuJe9b4/OmIJkAW9Dsi9QuFTmt3QOcPIi9fh9x8P3SxoImXBgCZ2y64WDlolYVfBjcPm2cjNt2hHwKKQJCEqKTvIseyuN6Lkm4WvYKzbRzif/OHpW8sFi44mTgPhvkhuRrLUo9vx4vWO1nbXI/ygh1rZZdZQeJaW89/h+P0mr4IIQnKNtCM21JZYQj5soxZfyOVd4v3lOFbVCg0lSSYYK4iBQd1NKIocU/nk4HSGaGXeHmYqDv8+xS45PL92J+uKllgm6FhWH5kLYU+nHeQq6PBSHpz/AroEmZM6AJK9RgKlOBDFhncBt5udg1DaNazPoaVIp9lZ9SvbBoUJGP5mS76vkaKP1+A1zAICxd8aegePbkhG4Ccl8Bhhrj3fqe43LZPL83916yqT+/vxTcr+Ekmclh3nBaXy7TIRP6kmMylC9tF7RpuDNeTHz7y1cOoenNL42qjoz/y+WxaBitaZJ+SKpngHjUA4lw2yKWMpiRoB1JaP5OrZhPFmrGpi3H45ury1W8aSm7ZEd64aI+C5UAbaeDZ7nGbyNsKt+1jVpCi574PGW5JRPprsOz9JL5YMzZNZJSYYbJM3+YQRxkRyvCSbfYVk/k2ccI8hkS8AS6msCjqOdskiJpTglgBuCgzclUlOMmCP1jR80lRw1x9rdpEbtXvyK8q7jTGCCnvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39840400004)(376002)(396003)(136003)(366004)(346002)(6512007)(66946007)(55236004)(66556008)(6506007)(54906003)(8676002)(4326008)(186003)(316002)(66476007)(6486002)(26005)(6916009)(86362001)(36756003)(9686003)(8936002)(6666004)(5660300002)(2616005)(956004)(2906002)(478600001)(52116002)(83380400001)(38350700002)(16526019)(1076003)(38100700002)(107886003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mkYBLvtB1f8uIYdDIquAe9D34V2aLwL6aNSfJVQc+pQMNZoDnkbPKcwxXjoU?=
 =?us-ascii?Q?C5cq3noaURcOEjgMdEbih+OT2Pi/AqFlJxY7aAg2ZLJ+dZN0b2T9tnZMOUQL?=
 =?us-ascii?Q?O5JNozprK0YR6qKtWtwMitk3K+ZUxxGKS2Zu8TV+TkAYGZKjD2ad8MMtbWac?=
 =?us-ascii?Q?aCZHaaS305jB+uMlQXAwffiEFSB11niiBrkHVH+SeR+PFhbia+l7SsePvdBc?=
 =?us-ascii?Q?eb+th/SLILxpPzJZ4rm/LlGbDx2J/yCZ1qXm50Bsdqm5SIFWlZ+kGbHYZA0f?=
 =?us-ascii?Q?iCIirwEwK/QAGi+T3h8Htwr6+sEEGxkr/BI4nU/QhAyyIFVK3JRDQL3dh2es?=
 =?us-ascii?Q?0kH0MiR++rs8HUpzdhE55WRqjmzGIgdTL8JBxms/iLIo3Ib6eIuU7zMJM5Ia?=
 =?us-ascii?Q?v8dDiqcLxQxIk+LK4LRfPfKI49gLj01Eu5RWFE/dAYFsyoV2gMmHbVY7QHMe?=
 =?us-ascii?Q?+3dngs5ylKFrZlsuyDPIdJrDs/5YN+9dkKeTdAHk4vrSoaF25iVpTzLMP0Yz?=
 =?us-ascii?Q?9GcvHG1xg5Ndu5QbnuaQ1sEW5jl6x9qo3xIi2QhkE4c1N5eIps0KKQqXsf2o?=
 =?us-ascii?Q?oukIEnXVubHPUvtRFTqnqLhwbHj8vqIgqcveSn8p7oJHcF9A+NGKdtSGdzLk?=
 =?us-ascii?Q?+sJ4WxVIkG2YVd7Bq3eWV14xplXYoPLcmltrS7J5HuJp2E9erDd3WWm9SUon?=
 =?us-ascii?Q?SgML/Yn7RK3T+zRd9XQ8RQbHlWNjKblTIa1vFRWtB4GRzWeaaxuR9K1SjD0j?=
 =?us-ascii?Q?y0+2l1zWrNpEtlpH3dsupZbcVGYJrt+QPGd229oLwWSxtf3Wc5ZlUpF5MeU7?=
 =?us-ascii?Q?ZZ1gBdKov3KKXg1VYKQ4yAJsKjRCK7AxpKGawxOkEVqh3F8ca1bJ0RhGlWX2?=
 =?us-ascii?Q?voZ8/Dp02ptOsCLTo+QYNYnlAbgWIS/NN6HdzphFoKlNQmWaSs1eKCTKaWIh?=
 =?us-ascii?Q?4vdZZTYbY9qfjatVGPEm/vmmVaI9jzf/+LSZCj3cbGAA50exYlEHjtKYib8K?=
 =?us-ascii?Q?0TTO2n6zmniOwiPd2fdcOsREIzWbOjM0FwaK93aUVAJyIbgmYP7cbqMMsiQq?=
 =?us-ascii?Q?txyKuEKBlfj0sHlDMRCc7WdrOmMFGg/160hnFz5LWfp+qOTIkhaeCqAZvqBU?=
 =?us-ascii?Q?BR5O8qiWg5IzDzEbapHiB5emtfaq9F5Y4vf1n9KSyCzB/kkSmMh+4mM6UG2Y?=
 =?us-ascii?Q?NwvewCplkcPpmpn0HS6tkm3hncXGXW8qVQD2zZrw839ECwv7RvY33xVMkgyD?=
 =?us-ascii?Q?7BgFCMN/yNH1EAHu1lXg/FZmy6FuEF8VmXGAxWOpiBGcXBuvyVCRMVnSxxKf?=
 =?us-ascii?Q?gLbK/CvhC2aQDVEFK17cS0In?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35af95a1-cb88-4f55-7821-08d931a9bed3
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:37.1933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBPt88YWpV4/HS8ywuXaR5JTjV4Je0Cbg5z9hKK7TZL2FRS4tWDjiy3BWJB4rOdyXyD5uJziFE0y0AUHOa5eEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1187
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/rf_boot.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/rf_boot.h

diff --git a/drivers/net/wireless/celeno/cl8k/rf_boot.h b/drivers/net/wirel=
ess/celeno/cl8k/rf_boot.h
new file mode 100644
index 000000000000..c246ed41cccd
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/rf_boot.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_RF_BOOT_H
+#define CL_RF_BOOT_H
+
+#include "chip.h"
+
+int cl_rf_boot(struct cl_chip *chip);
+int cl_rf_boot_recovery(struct cl_hw *cl_hw);
+
+#endif /* CL_RF_BOOT_H */
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

