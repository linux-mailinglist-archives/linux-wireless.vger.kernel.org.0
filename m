Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAC63AB843
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhFQQGJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:09 -0400
Received: from mail-eopbgr140042.outbound.protection.outlook.com ([40.107.14.42]:47438
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233635AbhFQQF4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+YVGSqj2qYOBWLXrv///0BpyuTelTQbvbwBfcv9tS2xi3QMhoCUZucO6xlj3GzS8XiMigYqYbpIyOrhq1TEGWlafZlk8GtqAYowkx5j/8SlnHZMwEaLKdCDVPctawj+sVH91fLUoWQlC9Mb0YClABR1BJxqEoCLlLl6Kp0u6AmnNqCaO0pJi33mbxHcvbJ0UorjgY6Gjf+ibCkMfQTDPkaOGOc/9t/N+Vm6KSpyqzO8ABa2VOGtbZJgF89YOgkq6BozfJQJWqtYoqA4p1PfEXSuQvcg7NR7J7zICUorngIN5aKjXD9pr1vT+NLO3f1lSk6SrmVU25JtSUMZFhTZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcYpfYQ5ZVMbg9Cd2TRbZFzktCi0jrT3cCzsg+r0TuM=;
 b=aJWYwyKACPMRjjtPI4gerI0CiTRdFHd6L44Na2w8HFEtcfP2NDdxSILH6ykI6eDztVHbAaMUaPmlwYztoC9sswBUDff81BHfBRqpFBYJ5BDhWthsdYwDH2HYMn3deaZsr9IAwaoWjfQF5ukd9+KMTqX1S1JpNpNYeZjKxuzHjO3IG3wWAb3VgEv9fynK3kACAfvwPCnDw/Z9mUpLcNVlzNQcJOcr4c9OWYNj27+om0CpV96xodS+20eOn9DqHw9L/yILXzqoizj8WEbn6xg3YuCHS9H89+ik4qNHxNYUMHVQrsSOPmJ0YZoycNDl7mTe8zP3w7WxbaNcB0I23G3S8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcYpfYQ5ZVMbg9Cd2TRbZFzktCi0jrT3cCzsg+r0TuM=;
 b=W5IFBgIqSCvqapyx0H4/n2e09qOfjbW3Rau2gHJBSYp957j8lKG9c1ORDvDeVkdblcOZDqzxJJvYzqvrm6jaBSZE79nTp8e9meOzfTwiwVlBR2KrKOG/25D6E0Md0bTvLqhoSkyeYE60x6fLsw1br59vHBiPP81z3KVGmK0s3Y8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1234.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:03:41 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:41 +0000
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
Subject: [RFC v1 041/256] cl8k: add chan_info.h
Date:   Thu, 17 Jun 2021 15:58:48 +0000
Message-Id: <20210617160223.160998-42-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 585db81a-8bd0-4634-bf7a-08d931a96cba
X-MS-TrafficTypeDiagnostic: AM9P192MB1234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1234B66AC70C0DD81DE59968F60E9@AM9P192MB1234.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Co3qjf+Txvup3iVPcIhGtjRjtOttBQr3uB1gSjEeAWvWENNXjAK9wfG8xMyop5PnUwu6KonSDbk9wyC1VKpvVO516fwClWsRcoKAlg556xcBKVKeIOjLhv9pPay5f1LHgCGnsbQtEAuaoEYVYN9TrY0Af/bRXNX19BX4y5bIuCLX2FOPSM/eAx081qjAvGn6bDOn7sGw9SNmlFcMgtEk71WR4jIMau/S7pXfmb2uoWdEpOceUnrmN1Nz2LRYPHeY8FUm5SM9Bfuw2KN4Q+NMSYw6HMwB0sIyiAyds7iz1Jo/oZESIB4wvwjERXo9bXY8dLxYU98ATV0fWN0RzlktE+KUcH6T7Br4VMMpbDqVDdG1QbmMwzDXCho9El0wMxzHlwNzVg0/rMNULArvHfer6r5Ks1TKcHkN/rMa+t47wvg+4V9S1X3krgCDjr7qxhpuHzraiiUHma0uLemqt8AIoEnjoD5KHdssHGL+TzXP0qYpbazkvlC361RBm5XMi6hZVTUJFCAcobGarbi7hvQuV6MZ+2HF8OirUUiop5Jx0jk78KysYrRhDGn/L3XP6NvjR0I3sl2yWKXPy6aw3+p9yPhmeW/dv/et4JFEmTp+cezHkmt5g/lOwwKOrvNZzvH71doKe43RiYPmfAHD+d2S3Yp/oVo6P8W9DYM/XGK93jj4hehbmz2UWASVoaVl1xhgMR+AzgSI96NGF6v2W71sKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(396003)(39850400004)(6666004)(107886003)(36756003)(956004)(66476007)(66556008)(2616005)(66946007)(6916009)(2906002)(26005)(9686003)(1076003)(6512007)(6486002)(16526019)(6506007)(38100700002)(52116002)(86362001)(8936002)(316002)(38350700002)(186003)(55236004)(54906003)(8676002)(5660300002)(508600001)(83380400001)(4326008)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TuKfrIpul1aYDgFBgNJs0bx04abkpUXo0uHvbSPYvkuovqpOK6COOwpqMQsD?=
 =?us-ascii?Q?0wZclo/FoI5ZdcTocjAh7kfZgolb99KEy5P08wZktrTzkPZCxPI64WNMbBvU?=
 =?us-ascii?Q?Fsaq6Kx6E4NMDJgEkn0tp2U5HvcHNfum5IngAa6E3BVK8vcwtPkpglPAgFLx?=
 =?us-ascii?Q?ce/6JaOheZb2O5EBdylP9oRfq8EuAOBN6DNEPsqUtKuz9Q9jdikpUKRB4b8b?=
 =?us-ascii?Q?wt2SWU/jUoCLRAsdmi3Xtbzy9w42dJPVLnarZF2wfiKA5xUEkikHA4JpB6hP?=
 =?us-ascii?Q?4EPspJg9uy/fwxMcM+sLOefiuSYLWrRCcU/AxJdxlrqw5snrzzdpQ3ha/f3s?=
 =?us-ascii?Q?6ynxvDCqGzlyC+N8DXpqqU3c48574DOqa27mLLz4z2uP3mePlDwtRhnP4KOT?=
 =?us-ascii?Q?UMxiovntS0jLHTCTtBjkmgwoEz/jSMeodbVNsS+ZZF84SrQU0oS9/UcOqTXi?=
 =?us-ascii?Q?Jrxg9zG66mRdNKzQnFAF/yDoPUg0atcDxbcVwDicY5wPvbhuhBqg85nllkfq?=
 =?us-ascii?Q?lNmI7+VDJC+IQsiS2NLBx+U7lyi3izzu9k/jOE7qzDYRjLA0doXLshjAMKmk?=
 =?us-ascii?Q?4GM/fyGf0q2NGXsQF3EVTcX3yIrPG5V+RlYD3TrnUzikS3WQ6Cl0KEq/n9c/?=
 =?us-ascii?Q?fsuzDZVzdU54TM2WmOrwyLuvJJfYQ8ZNa7JF6kCbx29IE2D85N36DI2hlKIp?=
 =?us-ascii?Q?Wr/TGBBeyIyo7+BI69KIp6i1fqtNz+m8+av4gRTbkjdhHQkKR4EOBXk7RJgx?=
 =?us-ascii?Q?o9jpf/LsM8jAT/wuQoti95yZIMuU3OiAQ5PsXKDko8Ck50h0u6SX/757Rc3d?=
 =?us-ascii?Q?qxzIWtMNXmNXyaehbZCUbR4Uaij/b86W+Oocqq/Gm0jbNwFEUWiltWVxCpX2?=
 =?us-ascii?Q?fOStkE1c/gnNyz5baGWMGOfeUVM9mdi8SIrivwaNKUWE4d05Fe1X7lzpvVHv?=
 =?us-ascii?Q?7bcQL1JsFpgFqsrvtaHpzuMWzu3l/c2clFZDj5aMl97BKLywPnqNHRI3JUE8?=
 =?us-ascii?Q?1NYELNTjWCbnw1ka7EMshegOnvh4wmHFxpAVy6JVYb5BCVLSkRt8lGJlNiKy?=
 =?us-ascii?Q?vVKLrVUsVHJCMssJ3oBmst1Wy/UuwcwkwffnZ+cVLQ3wHQ/4lXk6mLsGzC8M?=
 =?us-ascii?Q?f+JcvUaV28D9Sghb9jUPlqGP1sn4bWz7B/plrcXHIL6SGAol497OLaqMxbkl?=
 =?us-ascii?Q?T8zGj0O+caWzciUE4e9zH6e1X7l4WAmMCWPG5EjOwI3bW4vEh8+thR8DCKbi?=
 =?us-ascii?Q?U9TTanYNyI0DRW8MDw8BuZHsIF+cTqNQNqqTaVaJfnU1RFvoVLaYz/JNXCu4?=
 =?us-ascii?Q?kpWRo6wJ3YZ+/I8rnXUtXlpB?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 585db81a-8bd0-4634-bf7a-08d931a96cba
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:19.4372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BEbPRVqDnsGTaNCueR+iUfYdv911NLxOtBqnmiI0zO0Inu5PS1oSP4eUZ6h9nZHkC6HuPahiPv95Q5v2F5gpNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1234
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/chan_info.h | 32 ++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/chan_info.h

diff --git a/drivers/net/wireless/celeno/cl8k/chan_info.h b/drivers/net/wir=
eless/celeno/cl8k/chan_info.h
new file mode 100644
index 000000000000..d2eb1c3828c8
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/chan_info.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_CHAN_INFO_H
+#define CL_CHAN_INFO_H
+
+#include "fw/fw_msg.h"
+#include <linux/rtnetlink.h>
+#include <net/cfg80211.h>
+
+#define CL_MAX_STR_BUFFER_SIZE 1024
+
+#define CL_DEFAULT_CHANNEL_POWER_Q8 (30 << 8)
+
+#define CL_20MHZ_CH_GAP  4
+#define CL_40MHZ_CH_GAP  8
+#define CL_80MHZ_CH_GAP  16
+#define CL_160MHZ_CH_GAP 32
+#define CL_40MHZ_HOP     2
+#define CL_80MHZ_HOP     4
+#define CL_160MHZ_HOP    8
+
+void cl_chan_info_init(struct cl_hw *cl_hw);
+void cl_chan_info_deinit(struct cl_hw *cl_hw);
+struct cl_chan_info *cl_chan_info_get(struct cl_hw *cl_hw, u8 channel, u8 =
bw);
+u8 cl_chan_info_get_max_bw(struct cl_hw *cl_hw, u8 channel);
+s16 cl_chan_info_get_eirp_limit_q8(struct cl_hw *cl_hw, u8 bw);
+s16 cl_chan_info_get_country_limit_q8(struct cl_hw *cl_hw, u8 channel, u8 =
bw);
+s16 cl_chan_info_get_hardware_limit_q8(struct cl_hw *cl_hw, u8 channel, u8=
 bw);
+u8 cl_chan_info_get_max_power(struct cl_hw *cl_hw, u8 channel);
+
+#endif /* CL_CHAN_INFO_H */
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

