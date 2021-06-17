Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB48C3AB91C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbhFQQMo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:44 -0400
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:28028
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233997AbhFQQLe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/1LRolaZVmF8qoQY55NIDZC/rfVYX2lP7SLinFvlpBJOEfPFepTRxBEjm6yZouIKfnhImuHto1FmbSZPubkRGkgrxXe4TdUbZr7A+Jgqoe4swPakC39YuAluF5dZ1JglJtbWqpVMrjU9ARhbqQK2N7W+FzbhgQM1zvt1NJjzkTxhIZdOKcOKQ8HKaxZLFw9M7a11UcyxzB1y0sZLOCsYIF2CaQtlT4eyCVAEVuZhjsROxPfrA4kn4yiDWpEKA+bDr7iqbLQ4NsPOcPEB50uMX9PhstiKJAJ0WoKPoE2sb8s+KF5NxcosEBEp79gtmMii6kFkHM41kybMSxi1X80YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lv8oak2YG84towV3esqlANVWZDIqJTc8QoR8KlEsjPg=;
 b=lAU5jOgaaVSInBr1/fjizsAJfTnWKx79mF0KUN+N9gVzwJWgzKjKZ7OzSyVaSZGA88dq8CRcouMH53Nw/ZQ3m96p/UKudWUcXG84cftCJubd9S79iJd1YYYN3sNRqZFxQulx3qhrNddSNbrX/IMwAZTdmSQaA4ojn0Iisnat5BXIfrwpJPsHEYD8OnCsIFdBIpTWoNhnNJoe+wnqqRuf1JfLa3bDVs1GH4z96oDQCoV92G8nBthHqV2mHbcjp3CjNJq7J5JWrvA6xJLZ8uYXAQkmI5N2jk4Kn74IYaakSRup64OBLpcnqlrY8+QUNBkncGdFxNmTj8+STfAOCaOPTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lv8oak2YG84towV3esqlANVWZDIqJTc8QoR8KlEsjPg=;
 b=CZjXkGTK+tPLN4CztLzXC2CGv3qhwZy1kS0VCPHeBeb9ZTPynk9PkeWT6GxVCUDep7HjbtyEdG6biTM7jyQnedb6Yv6Pq8HKI8XjS52YNB6pcI0mkBTeCn7WhHxNGVf1ErDlFuzXQdwly3SJnnTCHYDzN6FezzepPJMqX9FIbwA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1329.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:07:51 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:51 +0000
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
Subject: [RFC v1 215/256] cl8k: add tx/tx_amsdu.h
Date:   Thu, 17 Jun 2021 16:01:42 +0000
Message-Id: <20210617160223.160998-216-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd643ad6-eed9-4370-86b4-08d931a9e098
X-MS-TrafficTypeDiagnostic: AM9P192MB1329:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1329FD2EF60C019335F5C452F60E9@AM9P192MB1329.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O0HQroaL3uHVqf+Z7PIeMQFkXH5P0OSQGwBlKHJbvFR3mpdxB/jcDtQGo9I+RzPxQ7gwcKSZ6tXyNJcjzJcm+yFHGF+htz+Fuuax9JVhtHYiFyqd4d4PIwJq/mkqmE8WHCfVS9soetvVwwUV9Un5UbOV6zek+ZA+PlVLLaxGhWehL74p12RobO40CNQTqROpfWqnZe8t9uCfw7lXOy8Yon+ga47GVULtT/E10L27QTNrjv1q+34aYc56Cre3hLVX68CgxTLxcmGFjebutrJR6wqnqyxBdm7+qvElb3ZTK+9DloflYCFJwqKoz3HqCHBJy8r8Ya5dpeYvlNt7rZi97z+3qidl31azkbZ/WMU3ffUWy5zqX6dymD/4ruo1xyEjpLci/RF1DSV03a9kl7pfotcjpwBjfrcKrPR8nvQ7ZAjAI7a5zAVODAXnFUzCyFCeJdWtP4fa4bRrWqZjKYe1BqWRokJN1QRreqQ6VeYL/kAuGKfzzZxUSud9xZXgk0UsZwj2GDpEnJB+eeyAEuqI3seyPqvlW1QquDHx9s3EbbJFfyHIfFWsHd+/RFgTPsWErs7LNWzAfFTvsH4gIG7KgHCtEtQ0HAurg/3C0reNs+QtXcrtyl+q4p5wW4Nz00aiSOQfFb3VPYkk1UZlYE5FUxNuEETvXQ5KIkQxbFiKuaSpjlKtfBHhzzSnpAHFJJ+jRB9Zi/DWtrvn8YJAb10NsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39850400004)(376002)(136003)(346002)(396003)(86362001)(38350700002)(8936002)(38100700002)(6916009)(52116002)(6486002)(55236004)(54906003)(36756003)(6506007)(956004)(4326008)(186003)(2616005)(1076003)(478600001)(26005)(16526019)(107886003)(6666004)(66556008)(83380400001)(5660300002)(2906002)(6512007)(9686003)(8676002)(316002)(66476007)(66946007)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?57yJd2jP3vb8bu3pRPyydKtkZOsqmlV8MxFcKufC0M1iGCwQ7Bi9kSJwXK+p?=
 =?us-ascii?Q?p7YubGzJEifKvNemRc+/5FH8fOsCgCZKd5stUlqAG4+M3H4TAOFmOxnnHkd/?=
 =?us-ascii?Q?uC49yH5rUpjBQ6fzbx7ZKHLK0RUmULZ2W9znkS+6eL4cQenVVyoQKqb9DJtg?=
 =?us-ascii?Q?w54zU+JbAcyUu80T5v4FMApJ/S+0IywP2PNwwA0TJFd6xyY2VoXO79jyqLf3?=
 =?us-ascii?Q?wl2X52uTJchcqOTx0BFz4PQAooJ3elNB7Mlu3/3bFw0HK15iIMNuAToxnCoh?=
 =?us-ascii?Q?Y0RYmTb++jL2zy1X1kcTuWliPhdyUUu1fd1HWubEGmIsajDHm8VM0CXNIG9b?=
 =?us-ascii?Q?HpvW7P8NIB2nkYA+Vj1BcvcLNsN3+ORJyrlt74gnl6LCUjPUApAjWnJ3xjy3?=
 =?us-ascii?Q?9JS/P0nWUn/z5WI9kwkpCff+mHlDTd6YQt3I5apHX0eEi0MUn8Tq1MA5hLse?=
 =?us-ascii?Q?TF8rjmb/p8vELGJ164uOpLTEw4+mYhgUBfpZAlbD/QFzed1/b0qRLagsWk5X?=
 =?us-ascii?Q?+XJvUkuuyb0ZzbKW/WzO9Np79zC/l56eLnbt+tRzGBDTXazFG4zUPSCtpHxv?=
 =?us-ascii?Q?WBU3ekgw0sbxDJ/e/RnWj9lMRQ3XhpouCBtkxlZXgaFcbjnkxVdFuW2RBslD?=
 =?us-ascii?Q?+ZuIH+2HuCj7sXcaE+OSvfZLZ6jw7eZDXl6j1JDprq33Y7xU2aA30V/4AvzI?=
 =?us-ascii?Q?gb8ZjrqG7eEmB/0qR7pwysYIhWImh6Htv+fcP1UnJoxn018tc96/glZYeaMk?=
 =?us-ascii?Q?UUgFt3ZHBvEsyufL6489IiXhjQys5l+rgB1oZpRpW6HwZszcPnxPqLxScP0n?=
 =?us-ascii?Q?FwnD9bNOGAWYa2c2IpWQZPO4G9YzRuKYvOFuTdM5ejMv9UoH0OjtUFaDbvF0?=
 =?us-ascii?Q?G/9KNu8aV+DzPunKWvDJj/QpyyWaSs2+5kLQ3K5NHuTsNCxSt5IBQT6P59FZ?=
 =?us-ascii?Q?y+nt5nE5mRlrIEV5IKH1zSFn+D4sbqHvSkSLba7FLVDo3tOXbcyELwUUPyOn?=
 =?us-ascii?Q?xbEoA4TnLwxb6WiNTiYPJ1mPIyZEFFpVwiKJaMULUmq3vQZiki/DwzsUThqX?=
 =?us-ascii?Q?k8iL5LTZRAPSssBkRag+5tUb1MDCgzzas79YUNu6jRQqHoWoNcKTWBRxp5TX?=
 =?us-ascii?Q?X1QhMhY33Bt2gc1FJWWoT6al4oL6ozcnxenvew8/PJde2W0fuz1pgBIpKMLI?=
 =?us-ascii?Q?q8LrkV+J7lwEs5OkMumYHNVZSWAqRybAKdE26R6YYdfD79qUpft1nEEjhIGO?=
 =?us-ascii?Q?f5GQaVMipYvme5IbmU6BodY44P9zOfGKWOOTYpVeoFiY3c+5rd+/L+a8HdoN?=
 =?us-ascii?Q?IhOFdlahwC/cykYsFsbrU03B?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd643ad6-eed9-4370-86b4-08d931a9e098
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:33.8774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wf8WTZdp4+MgWEu7jifgCnV9EVlHc3/w6862uGapHTVEpxIHmvNqNsjy9oWRK2DSj3IqiuYbGXoDMvRLIYuObw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1329
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/tx/tx_amsdu.h    | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/tx_amsdu.h

diff --git a/drivers/net/wireless/celeno/cl8k/tx/tx_amsdu.h b/drivers/net/w=
ireless/celeno/cl8k/tx/tx_amsdu.h
new file mode 100644
index 000000000000..efabed0c561c
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tx/tx_amsdu.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_TX_AMSDU_H
+#define CL_TX_AMSDU_H
+
+#include "sta.h"
+
+enum cl_amsdu_result {
+       CL_AMSDU_ANCHOR_SET,
+       CL_AMSDU_SUB_FRAME_SET,
+       CL_AMSDU_SKIP,
+       CL_AMSDU_FAILED
+};
+
+/* Max size of 802.11 WLAN header */
+#define CL_WLAN_HEADER_MAX_SIZE 36
+
+#define CL_AMSDU_MIN_AGG_SIZE 3
+#define CL_AMSDU_CONST_LEN    256
+
+struct cl_amsdu_txhdr {
+       struct list_head list;
+       struct list_head list_pool;
+       struct sk_buff *skb;
+       dma_addr_t dma_addr;
+};
+
+void cl_tx_amsdu_anchor_init(struct cl_amsdu_ctrl *amsdu_anchor);
+void cl_tx_amsdu_anchor_reset(struct cl_amsdu_ctrl *amsdu_anchor);
+void cl_tx_amsdu_set_max_len(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u=
8 tid);
+void cl_tx_amsdu_first_sub_frame(struct cl_sw_txhdr *sw_txhdr, struct cl_s=
ta *cl_sta,
+                                struct sk_buff *skb, u8 tid);
+void cl_tx_amsdu_flush_sub_frames(struct cl_hw *cl_hw, struct cl_sw_txhdr =
*sw_txhdr);
+void cl_tx_amsdu_transfer_single(struct cl_hw *cl_hw, struct cl_sw_txhdr *=
sw_txhdr);
+int cl_tx_amsdu_set(struct cl_hw *cl_hw, struct cl_sta *cl_sta, struct sk_=
buff *skb, u8 tid);
+void cl_tx_amsdu_unset(struct cl_sw_txhdr *sw_txhdr);
+
+int cl_tx_amsdu_txhdr_init(struct cl_hw *cl_hw);
+void cl_tx_amsdu_txhdr_deinit(struct cl_hw *cl_hw);
+void cl_tx_amsdu_txhdr_free(struct cl_hw *cl_hw, struct cl_amsdu_txhdr *am=
sdu_txhdr);
+
+#endif /* CL_TX_AMSDU_H */
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

