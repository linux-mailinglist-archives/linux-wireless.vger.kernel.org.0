Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D02C3AB887
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhFQQIp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:45 -0400
Received: from mail-eopbgr60088.outbound.protection.outlook.com ([40.107.6.88]:43502
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231617AbhFQQHz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPj45rlKByV85dbdWr5kvBtDMLJF+HqyytmypB5qsjupnnaZFF7R5cAIbD9/d13T7oqMuMw1dJSNZll9Fg9azlopaq5HBIyUzQBRiXyQ1ZqrJ5ZZYkkVVvXRYt5pkMJa8QB99r4EQqokw8dqckLPzKqxO8++qvZPg5OTTMuib1pm3S6uMywLgsZ3aeKI2udBTsUqsJokjdTQ6mjFnHIezjDiN4TtUkPPt6o7ib/ZV0f7jBGPmDYyWDL8rTiJDHDebyWICBUbhVPkSVmVtosTNHEPJOWes9d1HYEF1LSLq9w7pOkYksKftbqXkIFufodCpRM6AEmSqrjQmiQGOGX6DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISheBVzP+eKO2O/AMYt3AM6KQR2pxzBFSLitLXBtNUU=;
 b=GVvW56Zprg0IkZ5tcRQ1wWjoKvOvP3n3xiODbBc8CM5vqwn1mFe3RyMUCcJ8SZqg6e1JCwOMVc/jmhgjVEvlM5QLDbRI8jrvs4u645p377LPMWzn6BZ7MaDF9PiElJCqy/LvP8O+qcUwT9HXZ5RSnfo6F4w8aGeOu64RHpUcZU3TgSCVklG4Mmh9HBtbAB+j6BsULQcsiDW5pRpdSJWwxA85bpqpADYPjIvjXqv0X2/Geby5zR6oMFc+XlXXiZp35Ml2e+6BIbTx43andVo02LSJiIEnEy8t3HsKdCgrCFNFAET1+DyDT1KH8sk+VmB+N6Wpr+OMXChdPySgPW6Wnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISheBVzP+eKO2O/AMYt3AM6KQR2pxzBFSLitLXBtNUU=;
 b=Kr7kjC5oKtHNiKbDnMDoGfPG3NtQJKz7ojCsVWJaOGEYV8xJa8jok0lmz9CuMYhs412djGZ98Dz4sVAX3uwGzpxszGAs0/HARpaVoj90rZpiC/SLUkrud+Fh8F2f4CpQMckXD1w+W95ZaTXksHS+ZC2EAVk5HIzHKnqSszxItKw=
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
Subject: [RFC v1 072/256] cl8k: add ela.h
Date:   Thu, 17 Jun 2021 15:59:19 +0000
Message-Id: <20210617160223.160998-73-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b81f9dbf-ea01-43ca-0801-08d931a98102
X-MS-TrafficTypeDiagnostic: AM9P192MB1268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB126889A060066F4DF7BB2DCCF60E9@AM9P192MB1268.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3IHhBdw0//hUTDZqOU2xGVz35aQRMNEJhYnLbR0ZACFWQ4BRPjx4ws1R3lPn0WyA+CIs/OVW2kyZNz1gNFAIAI5JaGxBbqkEisNv0CxDX8RM0xfWV7dtgCKFB9y5AUW8dCFoyDQEPUENqkjvNn+OKa2ucFO8dHOJmeUx6LKpFBMIBvWYKRmtfZ03QR0sKfkGgtKJeIG+HVCBHP7BMHRZEWYoTfO7HKmiKIqPg8NBN+4Bqrn2mtL/TTOAQowMA37Hkzu2SyQphnI6WdNpNtRFlGJ8AxHHg1We84y8i3wR+HLlkwkiucdPmN0UOcnu6XvfWWAoxfpK2Ld7VDgGc/STzFo06PYEG5xaL9ZJIejnb0QBY8Xe29HTdIunK6eFVRDPoJ2yvNFHFcYS2AMvF6CQk+/PcneGfkkLLl3vGJztDF5tIGQcUNI63xe0Jp1ipI30QUNcTNaQrSyikXyAdQPdX27iOKn4+U/W90cxMAFmU6x8kmoknjHVT91XxEWdmgA2kYHjRYjHqTEYcyD4ww1ZRmPYIZUXCcHWyDBIvPb4YA/1OTjWuAOzTOXAO/mvMTF4AfCpxtVNohXiMMc+iAYCMulmprKHflz8esCpC9LxkJa+UiokDBeGEiJDEQSQJ1gYFIX5mb/UHQ0Jb/PlBmlDwmGWdyD3MpLIqABlMuFc0cIPnSQf0UxlSRLsN5PRg7tZNka1EjMlZWck/xGNVnMu/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(39850400004)(136003)(376002)(6486002)(956004)(54906003)(4326008)(2616005)(186003)(38100700002)(16526019)(8676002)(5660300002)(38350700002)(8936002)(26005)(2906002)(6512007)(9686003)(52116002)(83380400001)(6916009)(66946007)(66556008)(66476007)(86362001)(55236004)(6666004)(6506007)(1076003)(107886003)(508600001)(316002)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GoXpjFQ6HmAL+jpeFIAx1Hma7e8BZbABU0F/RR+lxl9wDoBeH8A9UCelfDCg?=
 =?us-ascii?Q?t8uHZpHevoK1IFu7ekFFfLO1ANVRn5UpUFRAxZibKh4zVJn8xGSxHhqYJHa1?=
 =?us-ascii?Q?VNCnENHR36wOsRfJdFqb1rwVu2b7Lfwn3JjA/up0zJoa/xRkfK2vM4MLu6dj?=
 =?us-ascii?Q?s8ME+aPN7DSl+vZQSzw+6WvhbYIh6DmIXKlG8ZpjmTYJ7C7jpwSFrloIVaOc?=
 =?us-ascii?Q?pBTx937+at1prScBbEOTaZgCC7Ku2/MU3hmZ1zl7A5rTkPsJdAmadDR6CRbE?=
 =?us-ascii?Q?b/z7Pq9CiOTOK4q54iEgZJZroFC55fKkcXSQl7OoAsq8kh1PBtnZyadzRUA3?=
 =?us-ascii?Q?Ql64nP+pZQxBYQNF2mQjJUXDnb+t2rMTpxrXtpKhci1A0WyQ96wCkGzvDFuQ?=
 =?us-ascii?Q?0wk1wiuuIRink8cBkQMGwKDDrjCIyZgOIDSoWaQILWZh1RhiCGTSICOSr9n/?=
 =?us-ascii?Q?CIBs9rxuRuHIm8nJxDHBWXnXYY0/OQYjRL8ZMO3NK/UpkAAh1DC6lv+C8XpJ?=
 =?us-ascii?Q?PPHMzOz3x+a9TKeshJozw7OW+BZwgc6K7Bsw0M0OHeEAo7op05SQvrQWlw0I?=
 =?us-ascii?Q?VtLujfrXzdyuq3xCn95I4dkMCVtKJkFtALx6gAbwK2ffypP/5NmcCdN3jDHa?=
 =?us-ascii?Q?S30/NWfngXGU2bLBd0M3Q/Kc63sAmqt6SCFfd2A9TaYuL5cXQApRwQi5owgx?=
 =?us-ascii?Q?geDdOSEcUrNKg9L7t5Jp4MoWx+TPLHI3tOMU8ZXiSH7CfdbMxboS3Ow2RzK2?=
 =?us-ascii?Q?T79qz3P4J7+qybs4MW75R9EJuCD5WQfZaSiBHg9B/l7p7oqJxCaQyc/Bgmgk?=
 =?us-ascii?Q?TXtPMWEv3hgnySNrMj4l4K1qQzUpmJvOre/VxZSMrUFH3AsJKQ59Al7CF7BK?=
 =?us-ascii?Q?139AHNLxwS2SkjY6D9FOMdfe+MalvSkG+oQVBp5Z0i3k+IfTKMHsnmpJAXr9?=
 =?us-ascii?Q?9DFhUc0T9B4Vw2UZmkci54T1a19bYbMRNLS4pWiD8kNsugjo0UQjktflGCec?=
 =?us-ascii?Q?9mTbshFNuTq46f21aPX3rFcL7Cr3oaygAIF6XE4USyXIsXA2/lGaJPJAI01A?=
 =?us-ascii?Q?VfUv+/b8dsDvb16Br0D2LAhlkLBwnd9suajdJXJxg9KvPvCvr2fu/7R+VRAQ?=
 =?us-ascii?Q?DEFNkbjOz3i+GEfp+8ivhKfH9Y8bNv5UJ1reylreER1G8mEM0nZ+rvTueIxF?=
 =?us-ascii?Q?TjSEiqx5zPWWIhADz3rIUK63b6AeoiTP83+ZB9W3QuSmjEbRY3+9VLJwamC/?=
 =?us-ascii?Q?/VmNrD7AAKEq8RgLRgULJ8CIUA+bhgJrlbwVOJHlXtgzwv+JvmFVMzA4YnYY?=
 =?us-ascii?Q?wvX+gWYCK+uFbDrXvv1OZ44D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81f9dbf-ea01-43ca-0801-08d931a98102
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:53.4707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqI0yljTbOCen9qgefbT6AF9/H9icUB2Lp6WCJi/NN80Plmn3liNmSLRN9DCwkMI/c6WwV6EMTE1R7ciWeJOTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1268
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/ela.h | 38 ++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/ela.h

diff --git a/drivers/net/wireless/celeno/cl8k/ela.h b/drivers/net/wireless/=
celeno/cl8k/ela.h
new file mode 100644
index 000000000000..dc2e67d06798
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/ela.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_ELA_H
+#define CL_ELA_H
+
+#include "chip.h"
+
+/**
+ * DOC: ELA (=3DEmbedded Logic Analyzer)
+ *
+ * Chip contains built-in ELA with LCU (=3DLogic Capture Unit), that allow=
s to
+ * collect profiling info. Collected data is aggregated via set of %cl_nle=
v
+ * elements, and saved inside special dump buffer (described by %cl_coredu=
mp)
+ * and fed to the userspace via DEV_COREDUMP subsystem.
+ *
+ * This layer is mandatory since it allows to set properly initial and
+ * post-recovery configuration.
+ */
+
+struct cl_lcu_cmd {
+       u32 type;
+       u32 offset;
+       u32 value;
+       struct list_head cmd_list;
+};
+
+void cl_ela_lcu_reset(struct cl_chip *chip);
+void cl_ela_lcu_apply_config(struct cl_chip *chip);
+bool cl_ela_is_on(struct cl_chip *chip);
+bool cl_ela_is_default(struct cl_chip *chip);
+bool cl_ela_lcu_is_valid_config(struct cl_chip *chip);
+char *cl_ela_lcu_cmd_str(u32 type);
+char *cl_ela_lcu_config_name(struct cl_chip *chip);
+int cl_ela_lcu_config_read(struct cl_chip *chip);
+int cl_ela_init(struct cl_chip *chip);
+void cl_ela_deinit(struct cl_chip *chip);
+#endif /* CL_ELA_H */
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

