Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7463AB92E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhFQQNS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:18 -0400
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:65046
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233677AbhFQQMF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:12:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dT9By6k6v2LFBftWeaeS7pDd5qUH36RZS0j4Nq9l+BEzyoLWP2Zr6Jnpmna0w+ScsaAIAWkTF2J9il5sKPC/N6PSAwy0q2im2f1yGkc9iQxBTs121Egi9Cca5pjBszCbDM8Mzi6/OUeuBGfFrcgnHBQTwnxXfLUZxCmg1aCnUvljm+sKOZYZ69+G4ckmFNx2SDJ2gM452iUbXaDEqiYloorxGWeXVgtlwNk08Bl2ij8VJ1ikv6v8udKWDNgHL6A32CE8WjmuRbcTEsrZvmLetqtG8AQ7+icL5HCx8CYafJmkvLKsPchbqu6W3z6NjTbvdeyT3h9c2RSI4pEWLMfXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3Tcg9s0qsf1zMx3p9BQ6/7ttJejPB6SPdtKloLtQec=;
 b=cVuygAjpjEAN2RMuh9aOg4EdWfe4tQalXhMW/IFNgy8GPznStsa30TcFJqm4ZjoyTK7YShIM4Iqj+EgvE9tX6fWswXT/9lQeCxCGKhea0G383fHHXSEDuoJpJY/iMLMzlD7ZISTQK5LwQVYJqC4kuMC1bbmuXDjHOgGN/zVnOSUhDoz+hO7R70ZQX+TcYoI4oV3iiigAamg531PvTyB5HptiBDgJxCgMxHFzEg6UodBp0QD9V29Q27oovwfHIoY2XY+c9Pf0ItIbei8rwbrYKaST2qsBMB3IGin9U3XOuNJ116zMG2YdpdVo7r5phvM/FehEyrNA/tepsx1GtNTkrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3Tcg9s0qsf1zMx3p9BQ6/7ttJejPB6SPdtKloLtQec=;
 b=mzBv6sml4+Z5ZjKutx93epdchqclSVgbx2Yb8GYo+idxCUF2xcmqroF5gWJFYTGyEtakIZlzMgT6ovTRZ/Ui62R/yrJqUmC4jjVpAUJM1P61KUoqp2HBWt5pfteIfXjUQi8nQ/jdMzrtGVIluUFIPKc+rGndK2L9RIG6+EvLsOg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1329.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:07:53 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:53 +0000
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
Subject: [RFC v1 219/256] cl8k: add tx/tx_queue.h
Date:   Thu, 17 Jun 2021 16:01:46 +0000
Message-Id: <20210617160223.160998-220-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac54fc37-61da-4a98-9d6a-08d931a9e3a6
X-MS-TrafficTypeDiagnostic: AM9P192MB1329:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1329226371984797652E1C92F60E9@AM9P192MB1329.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RymBl9DCY8Fb2y9wK58UjZWHXIfvpWTf71kHv4CqDzLWxsTxZQtrxDM4elzW8om0eDyCYsXg2nIKQksPKjDeNcSyKV6Ium7+aRaEcMEQfg8Z8X7gHA2FIWaAIdVmv9x17F0D5uqGlneDRwG7ZeBDJDpw5HJiqb8Mo/hxwT4pI+4QDGhJwT0MRqwC2tY1queLXofypBAKAGwc08AEgfC9catJjvuJl3cSxYXpA0RVFPz9GUIhQt6G+jN0j+ezzWJ+XeC/Xdh4eap+xJaCFwZYcVBiCWrabX9AObH4oQGvcPZWcNPobA2kbQg9aGWRrYGshhFkFwwi9bcuSG/o+XHet4H1JB2dKY1liianOPLvSQNiY/0xZird76mP17PhKWt7BhOqca5OcZ20FeNTKIzuDL2y/2Vfu590k9nAjXtVA75Eh6uwXpTe/LboOaAwrYfz/5hUnpLcp3sLzbxTNxbFCg1jRHFLMo6XnpnD0/V2NppDS1Yp6/vJ+nAjUJfscfmTtx4CgQcnlDZ6YbRvcRvS4+ioGNUftjOVCETgZ9MKHWlc2YP4tyVh7Nf5TukMxDHhDpzl6pexfDIJiWyh6Ts0pSNw89ENU1O1jIYke1IOzmvIBNzhcDPi4Ca5WXUQtMhSe9iLEZL+641udwzYG74OgU4mpviH9O27A95z8z9E4HSefh25Ohn7rOwX+914uE5VjijIr9BQ238STodjCnEb4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39850400004)(376002)(136003)(346002)(396003)(86362001)(38350700002)(8936002)(38100700002)(6916009)(52116002)(6486002)(55236004)(54906003)(36756003)(6506007)(956004)(4326008)(186003)(2616005)(1076003)(478600001)(26005)(16526019)(107886003)(6666004)(66556008)(83380400001)(5660300002)(2906002)(6512007)(9686003)(8676002)(316002)(66476007)(66946007)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0cKqqSIyjvSScmF6MSibEShcbvcpzWYlOliv+Hd0udTd23iTJH/C5teZmjlN?=
 =?us-ascii?Q?TMrCIhXavEDVRHnFKMy84rCi0mV7XlmXki41Dn4egA4JDAaPRRkuNvfJuY57?=
 =?us-ascii?Q?WIkrZgWxxB7PC30YhbXB3txWnMthr6I9vfgx7p0/z1ij1cZbFFmIhMVZ6+69?=
 =?us-ascii?Q?IX5ZVWX0wLAEgvyp/k6NlEqYDziR/uQtrUhxmpd3T1u4fxh0nV+UtnCXhPe9?=
 =?us-ascii?Q?1YG1Gezv7EnizHsUe+Cppujbn4a2yxX6uBTa4d2KignCZEIFQzLEFiE4udd3?=
 =?us-ascii?Q?3B64u1nsWa1hy9eWdihxDEEc1sbQ/7RmlW2ZlLLx703fR6eICjAJpE+mcy43?=
 =?us-ascii?Q?KZkySD93ssmkFGHz719+xcsoms3z/h2gT++AMFV/y43Be09oru5In54aC9J2?=
 =?us-ascii?Q?/AB6peMGcIGx7nGCG8X0/869Acg69YMwG2JVKlKO3Y4PYLp/rMOMzAwvYH8d?=
 =?us-ascii?Q?GyyCSOO7ecs3NTU9DOXHzwT0iXlpKdJnhQQUeObrRuXX29F7W4soXSRzpDN2?=
 =?us-ascii?Q?AAi12U7/xqAeGYjk4meDsJoWJKfJ2t0MOEWhzfUPgtEi3XI29zAducB5yIaO?=
 =?us-ascii?Q?nSqYkO9yx0LBmDL7YFdBMV2DPqx3TXrhvJMWJuOgYp1DcQCMYQiTUgSiiBJI?=
 =?us-ascii?Q?XnvBJrBY5uKQ2wLoWkSY1ye70V1UTYZPvCdOS62gBjoDlrQvqzVxjp69GPVU?=
 =?us-ascii?Q?UNkuHWTUWwVnoMdotPsGKjuqLzz399aKL1NegjY9HoYQ8HiA40Ge/LFgM+4r?=
 =?us-ascii?Q?vMuVVZYCWBOajZd/L0rkYh57wM2E6a72Os2qa9JEQ0wOt4Y45JKHk70Ju/X2?=
 =?us-ascii?Q?m3NNDnZEaSfJm266mQ11j3VHLo7VgwFkgEL3/rSYhSjCXG2WQXhMp8UOM5Rr?=
 =?us-ascii?Q?NSkPwSGRUnVouizNQuSU/y4V+93DpRuewdtYlKQZGcjWISJqO4RKGgi43S4b?=
 =?us-ascii?Q?PQ4UbI5tt8fAeA6lTL8gMDLrgQmXgCk2tsDmRW0DJJMIezHTUCFd+60wKhCc?=
 =?us-ascii?Q?VhwhnTLu8PCGB+wdCv89Qn+/3wLfzdzTVQ2ulzATg4buQhS/yaR9AJRUwEmC?=
 =?us-ascii?Q?uj9Wvu3YltA3XugBbr0G4bPkGjQ7iKg6+8Q+vfKqP4Vf5BSnibqplXta9dyc?=
 =?us-ascii?Q?ENNbrCKEie+wOXsuTw7sqY290nMMdXVQvvOgqpBWFWXf1dtkXbF2ZQhWtED2?=
 =?us-ascii?Q?o1wQk6sFoYWcuZWGuvorURIwgFhYYF8MFubIJ7FHTnXnrizBoWdcC6gcVeQs?=
 =?us-ascii?Q?xNVc/Z2MXz7cwVTHNB1Cmd9WKrUtOj8xT+V8yvCnqG/v449gqeO0Fr9kvjcM?=
 =?us-ascii?Q?rV9LoyuTVnZjtD04TSi9m5B/?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac54fc37-61da-4a98-9d6a-08d931a9e3a6
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:39.1253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DidSvgkA8mRrf1YtoeXd928vhwWxySm8E4fm+JhUIb11d+9JHOWBwp130KYqnGw0yMpkCQNwIapoXSEh/V5EqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1329
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/tx/tx_queue.h    | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/tx_queue.h

diff --git a/drivers/net/wireless/celeno/cl8k/tx/tx_queue.h b/drivers/net/w=
ireless/celeno/cl8k/tx/tx_queue.h
new file mode 100644
index 000000000000..e8232b605b2b
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tx/tx_queue.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_TX_QUEUE_H
+#define CL_TX_QUEUE_H
+
+#include "hw.h"
+#include "tx/tx.h"
+
+enum cl_queue_type {
+       QUEUE_TYPE_SINGLE,
+       QUEUE_TYPE_AGG,
+       QUEUE_TYPE_BCMC,
+
+       QUEUE_TYPE_MAX
+};
+
+#define QUEUE_IDX(sta, ac) ((sta) + (ac) * FW_MAX_NUM_STA)
+
+void cl_txq_init(struct cl_hw *cl_hw);
+void cl_txq_stop(struct cl_hw *cl_hw);
+struct cl_tx_queue *cl_txq_get(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw=
_txhdr);
+void cl_txq_push(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr);
+void cl_txq_sched(struct cl_hw *cl_hw, struct cl_tx_queue *tx_queue);
+void cl_txq_agg_alloc(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                     struct mm_ba_add_cfm *ba_add_cfm, u16 buf_size);
+void cl_txq_agg_free(struct cl_hw *cl_hw, struct cl_tx_queue *tx_queue,
+                    struct cl_sta *cl_sta, u8 tid);
+void cl_txq_agg_stop(struct cl_sta *cl_sta, u8 tid);
+void cl_txq_sta_add(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_txq_sta_remove(struct cl_hw *cl_hw, u8 sta_idx);
+void cl_txq_transfer_agg_to_single(struct cl_hw *cl_hw, struct cl_tx_queue=
 *agg_queue);
+void cl_txq_flush(struct cl_hw *cl_hw, struct cl_tx_queue *tx_queue);
+void cl_txq_flush_single(struct cl_hw *cl_hw, u16 idx);
+void cl_txq_flush_all_agg(struct cl_hw *cl_hw);
+void cl_txq_flush_all_single(struct cl_hw *cl_hw);
+void cl_txq_flush_sta(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_txq_agg_request_add(struct cl_hw *cl_hw, u8 sta_idx, u8 tid);
+void cl_txq_agg_request_del(struct cl_hw *cl_hw, u8 sta_idx, u8 tid);
+bool cl_txq_is_agg_available(struct cl_hw *cl_hw);
+bool cl_txq_single_is_full(struct cl_hw *cl_hw, u16 idx);
+void cl_txq_single_sched(struct cl_hw *cl_hw, u16 idx);
+bool cl_txq_is_fw_empty(struct cl_tx_queue *tx_queue);
+bool cl_txq_is_fw_full(struct cl_tx_queue *tx_queue);
+bool cl_txq_frames_pending(struct cl_hw *cl_hw);
+int cl_txq_cli(struct cl_hw *cl_hw, struct cli_params *cli_params);
+
+#endif /* CL_TX_QUEUE_H */
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

