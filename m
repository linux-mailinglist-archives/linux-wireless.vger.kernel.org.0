Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8CC3AB8BD
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbhFQQKN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:13 -0400
Received: from mail-eopbgr140054.outbound.protection.outlook.com ([40.107.14.54]:3726
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233773AbhFQQJH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7iM1ji4oXfxSDDDyFmtLnDBogj1ke/QKS1aLOk9wAdPYuyaYn6yA6I1i9INcHUi71t/JqeObM9Bx5Kduoi6rY+kvc+cmWy1Gy8qoqgLkf2fB+TRKKhc5z57obD7z1aEVbC4vWjqBZI2hUx8MaJR+cGDhpYnT2ApUcEPL0MjbZBF8xV5j92EGuMwZK0pZe+2Bl7t6xvw4lPxZam0rrSDA04uZxYzbSHmKgRTI8iajPNdgnyP4/sbUWMchAQPVfHwWLtBZYQN31FX/t5eAB1rS1qW/NFk70AcflJqqXlWxV5JSPUkOfcqHtUA9d0AlW7wchJAaP7T/+Gs8F4G53GETA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpI5IVtym0PJnnlGUjVbZ2k7sY4QYL8LnKoLCVS1hQ4=;
 b=aZd8hhB98Jts17GItEJMdTwed8vZowpwhtEIpvZjF0/BLmRLVmYgAMdc35NUctLjDiulODrA5qbOjGFZrc8J2FhZppc4pF6dOct45nPM4EshFCe2PWeWhXCcfEVcAiWy7jqxql5cGR588c5/qg1V81aATQ2ZAA92ciFIyOxd3nYncJlle4dXgk95zHwyslhvG4+uep5RJp1uZ2rlDzOiFEuqMQusagPyXNifrhf+J99PkMG6D5/3R0vDM7hVSxTSfOmjfwPFCQmu9KEa2IhaBnhlF2OahM9qciGotXj2nyu2u58MtT1yuJS3J9iwtEgNJRnIYx3TrWqhfAOv4+gEOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpI5IVtym0PJnnlGUjVbZ2k7sY4QYL8LnKoLCVS1hQ4=;
 b=v2mS7p/LJfnGyc9jAbRyLoSbe7d/ql6d5xMs/9CrWHOIIDwYvLIFTpuxopuLM1goV6DqucSJ4+F9n/Kw9EvR4Oopq/dAsBTLCfv5Ermei6GKG2VkVpFkMqHG3a/BBjvfGUW9ZJgQrSsWP8fC36BActUzQfpiqo9B/UkEu1M1ZjE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1059.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:05:52 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:52 +0000
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
Subject: [RFC v1 146/256] cl8k: add recovery.h
Date:   Thu, 17 Jun 2021 16:00:33 +0000
Message-Id: <20210617160223.160998-147-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1fcf5ec-e769-4303-a052-08d931a9b1b6
X-MS-TrafficTypeDiagnostic: AM8P192MB1059:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB1059DFD4317B4142C0219024F60E9@AM8P192MB1059.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uv0eJ3iBKbNIlPRZ6+0EBjcCvvaj25L1oRO4JFBa/yf7QPQ1oEvkKHBUWDZ9G/Uge3oyYwqxLRCV9kqU+hh9DQb1brvb9p33RqQvjBtTb0jjf+Pay5GBw1uDxOFc7LTbuA9JzaIVSYF+lf8HttIeHN3dQBN48SEXFKtDOEWzV7yrL4N13qKPvhXt/JwJI/LKtwRu2uC82sFIJFTnHfWKVuoU4K5K443ZzMRSjcZdaBLL7fhmaKfkigMxc7dxwNO5cF9Pt963JhXu2I+h7GT37IR5ce0MDB7s4BKv4EQaOzFKxRVWPDKpnWr7FV0syb2xcOE8xffoSzuG8HXBjDNJo4/E/+B7RK9t48FXvhyNjJ2LIVxZ2ooS2y0lm7PXVvup7UxT/jC+iy3oOJU0UKYqLKVzd3i3/yR0DxVEFOmlBWZmmmQQdAT1+f6DH0YnGqnpL84dBB3E/X1Jyk4feD/hSpC95qzxiVCYYft5Sr0n0gpB/+XoyG8sEGwjBglNfxPptedUGHtZnZG9O45vwf26qx3dd9R6a2eyAta+BoxFA6bmSJyWNQZy6KYjRHTAiJI8lgX8d8IYKh8kl5sxxum+vekeAl6LG2eFqyXqfv15OjwbpmpWXdFpWlH85NP13Uj+PZ1KNC/CEvrffkqQkaIEo84Y+LzEk4WmwizU00Z+RiCFlkNZw82/fZO7PjCdlBuq6ZAuLAv2MnGRw+22p72KTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39840400004)(346002)(136003)(376002)(396003)(366004)(26005)(956004)(478600001)(186003)(66556008)(16526019)(107886003)(66946007)(66476007)(8936002)(6916009)(2616005)(1076003)(2906002)(54906003)(6506007)(6666004)(4326008)(38100700002)(38350700002)(83380400001)(9686003)(6512007)(5660300002)(6486002)(86362001)(316002)(55236004)(36756003)(52116002)(8676002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZuLdek4mfiWWpZFjFhTgeFiM1rDOUv+aHn69JnJABii8tXnngPk3pNLxK6+5?=
 =?us-ascii?Q?fDUn9ZgZEw6GqRU1v/EYcutPlgByhTl1c9+LuYFv1sTe6F+3NJDKS808m76n?=
 =?us-ascii?Q?vuyltIMhcqV5eP/7X2Ao7z6JZkeyxJOTaVP79ffU4D8IQ0TyVmI4hquyYkvJ?=
 =?us-ascii?Q?3+SCyMI162D5pOwQdvSHdYcLLqlaRuVHcLOqklIDbI+4Bh+4yVllMRXSo8Q2?=
 =?us-ascii?Q?IgOYToVZgYgxEHqEwqpZOcaIU3r7kL0fmGzR/7dXAhKOPnIyL2IUIOtvJnEw?=
 =?us-ascii?Q?63IfyM05A+51ubE7HTS3yxbwGqoDpLsIl2X64Xq0BdefYmXDg/bZNNTmW/ZN?=
 =?us-ascii?Q?MI5DwYQN7G1pCEQPDKO1WpoMc3gQ5EcVhs2DZvLiK7170v4ufYc3ELmkwQdS?=
 =?us-ascii?Q?6yleJRUKT8j/BXJZkPAo53mUIhvpNvIyBXhxDHmxLetP9bq+E0T75Z2zm2Wg?=
 =?us-ascii?Q?hie4qUfMbQzzUSsocV43P/roqERnqsA+kfOW1YMxSUCtiRy3YYQWa3B2ef1A?=
 =?us-ascii?Q?pRpzCOr/VHIjd2OZf7yeMTW0k4sjbtJxY192pQ8anUUzn19WcDyOIevmPMzu?=
 =?us-ascii?Q?+W27Z8CpUhkiJsjV4rcDk8x7f61nf+gQ8Cw9/uwoUrQco1AwGUUBPzFTxvhE?=
 =?us-ascii?Q?bA2j4yE+XQyAuUKNVw4EaaNHkTP5OvsgUDU7f3rABAt7nsU2yOckoXpXC7aE?=
 =?us-ascii?Q?23eKPYvqQmmpthwnZfu21ZxAsFyXtwMntEvs73dIZfvQAnaJqbsh8u/jB8UQ?=
 =?us-ascii?Q?AVk718QO1AgHnw/WGi0A5y6j5kkWcyCYyoJ/PNlAugpkYVXtbl0/bwnCKGT+?=
 =?us-ascii?Q?V+ttVy+/FGSf6u7rw++325jczGnJA5Ek8Wwb74yFkroZYx92WJTNyqDJ+NGq?=
 =?us-ascii?Q?DF9T+FE4uB0PEfORWCcqzbShcYRUu0mcd8dMMH3zOEpn8SOJOzr78bRJ0twq?=
 =?us-ascii?Q?gk3w/eMRppPLYll0IeluQzJ6Eupgwz/Fc11dI21DNzvRsKzWCQCf5ZOm6MHV?=
 =?us-ascii?Q?eASerXBv+bhFEEwUdqG6dIdQW6FCIi6/SGZhOogPQ9LrPYJ8dIPaZaH39W36?=
 =?us-ascii?Q?ZZWuZiynC8vbGropJfPFN4Xoribt0cJ8lEv98lB6ROgUrSu69/HQYO1jn7gp?=
 =?us-ascii?Q?VjkxIMrpQhW8S0TUjLua6y6zmyEaOiIwIUdQDPBADb6stEprQX1/2EBc0McM?=
 =?us-ascii?Q?8wpMc4+nsGLPKVVYNoGgZuOkLDCRxXu1xyg0ufE4D8Fse+eDgYvjwVRZgRvB?=
 =?us-ascii?Q?jmzpcQjnvTFD+yFRAIKsOS2eOwcq5pR5RCS3HcdIwWqGVeQKRT+4Oa7ue1KS?=
 =?us-ascii?Q?MKEPOEeIbll1yTmtlG+q5OAB?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1fcf5ec-e769-4303-a052-08d931a9b1b6
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:15.1819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dc4C7NlWAs2ZbmXry838MfntN67cxDA96/aY4D1K3lTvbu0xxudZwEzBAaPRoB98EXPCXGm6GjN56oMQef9wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1059
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/recovery.h | 27 +++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/recovery.h

diff --git a/drivers/net/wireless/celeno/cl8k/recovery.h b/drivers/net/wire=
less/celeno/cl8k/recovery.h
new file mode 100644
index 000000000000..6899faaabf8a
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/recovery.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_RECOVERY_H
+#define CL_RECOVERY_H
+
+#include "hw.h"
+
+enum recovery_reason {
+       RECOVERY_WAIT4CFM,
+       RECOVERY_UNRECOVERABLE_ASSERT,
+       RECOVERY_UNRECOVERABLE_ASSERT_NO_DUMP,
+       RECOVERY_ASSERT_STORM_DETECT,
+       RECOVERY_DRV_FAILED,
+};
+
+enum cl_fw_wd_mode {
+       FW_WD_DISABLE,
+       FW_WD_INTERNAL_RECOVERY,
+       FW_WD_DRV_RELOAD,
+};
+
+bool cl_recovery_in_progress(struct cl_hw *cl_hw);
+void cl_recovery_reconfig_complete(struct cl_hw *cl_hw);
+void cl_recovery_start(struct cl_hw *cl_hw, int reason);
+
+#endif /* CL_RECOVERY_H */
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

