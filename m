Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906C33AB8C0
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbhFQQKR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:17 -0400
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:26086
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232809AbhFQQJM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+WmqY+yWWKzXaYtcRupwEiiKC4FJKsgC+VAXysmB5DZGgwUMWPn87ocEvGma62uu/BZzoDG7VFlLQeJAUtyzeI7eSZKL/sUZ9KfUy6wpjX7+e+vYaCfMoN7rGPcBm+FDVfFH1Fmqon108mld8GEudOuKbIqahuJ1hmew78F9S6ZmQN5qjPARZPFxQzSQtDdnetHYK7pjtWU/9DPMJ/Q4rlBwOBHB5AbpVkTBFFusiAOOT6sTgqY9c41JkGeMWgPAzqMumipcHOC/ufYx4AwHKs0gnq9SFa1PcqshMhcvyZet8Ea2c/OsfCqQOumWazsYGhSwK0f01KfmmxAib2Psw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmebeQCeeZXGP3RQdsZSkXT/pG3RPtVI3FTFm64T97c=;
 b=iTwOuBK/y0KOHcWQaB3LfwlkT2C6/nlJHHHDU0bRL3Qn9cNhUGhZQUBXeHughu5qgizwa6F5+PLgWFs+BsTK9NahNz+XJvN4fKlkFwswjNEw/jyEgWvST10/SnM7s3FdeWPpeRsb6Kh/zi23t0vvAs1V1QOLti75hP01B9tZ9OG/Lp+Q3G/UxzC8wIT9PDaThdLCpFs2JZ59CBGVI3xKQoQhV6rwkritMqi7QcZICzxA5ELhkHEs/D/AxT+8uepoccvjGMMEJAFjEFiGPvod+vU2bEM6AYluArPwpjfm2JJlmsjhFA63Ya11GknQi6tF7KaH6Z1KAt79i9E6WM8aIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmebeQCeeZXGP3RQdsZSkXT/pG3RPtVI3FTFm64T97c=;
 b=ZvwPl8hKUrWpaKTQwJWJ49K4MpqvI0F22nU+05f+TlLYdoZynerhJoDewWnvDtPqxAcKY+Zhp17jZktg84vOSruzYBIhIUOyYuNhD9NTZPjFuXMav9cu6lyyTUw9YoLWGoInyywfWGEDNmeWsWNGH/XoYvlAqPsLgI83VmEVbA8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0260.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:47::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 17 Jun
 2021 16:06:33 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:06:33 +0000
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
Subject: [RFC v1 171/256] cl8k: add rssi.h
Date:   Thu, 17 Jun 2021 16:00:58 +0000
Message-Id: <20210617160223.160998-172-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef7702e1-36be-4ce4-281e-08d931a9c1a6
X-MS-TrafficTypeDiagnostic: AM0P192MB0260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0260CF6FBA9F8061A9209ED6F60E9@AM0P192MB0260.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lAO14KX6eSfiOh/dotnF8I/hJYgcUU9W4YWQB4swbGrIMrGEF4wzuaehg1I3YY7OSKyx+UHQ3a+abBiLMz8WPpHB1W+qnU/UotKmqcsLCXpIrv9brQmQCxqF+gNDJQaRywKpKgJlj0rsHpJ09BCbDfaNR83dSB5TKnPdR0/unfvDem+BwJH6YanBVahCYPRStScfIMWj+ZLsDgqV4C8AOQbj9ahM34qiILw5XRG9exXztaVOmBOi+AZu5kV34tTCIvmytLWWh/y5yRCOd8Vy45bMBFdMqvr2x/WvKo5oyyliI9N8/VColb7J7OIW/TuGS21AXk8HHsYkj7ZPvlL17jM4kl4fM2dlaTn3+wR4bgtLYlpcCGIQYzrWonR3p81O3QSgI6sIkjMcHuNKG/b7CFNz9AmyWcHMMA4OfipTfRqGwBOXlcVhLjbjm0lrGvYCAH0/TzrKujnOJFmR8GSFQp4jvy09W46DMXMAwL1vVFwLqIH96/rE/LQfRsL/PjIM1dedCxs/il8tJCJT76z/MVb123lPMr7mXySZs6bXmAHUMMA1ctjwCLNlROnZmEOil0xkzGujePYuAesWQTO8yzgirxAUxFrp7raIWFWTpyH+xD76+YOPuaObtfor14bMm9HUxg3ZXCxPGS+8NL2Db9lNO1j754WYHNDdKOZ5ZT2iH9dBUWXKyiESmBWlcXwU4ePblviZJMq01uMWMtSxfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(39850400004)(396003)(508600001)(8936002)(86362001)(107886003)(4326008)(316002)(26005)(8676002)(956004)(186003)(6666004)(2906002)(6512007)(66556008)(2616005)(5660300002)(38350700002)(54906003)(38100700002)(16526019)(66946007)(9686003)(83380400001)(55236004)(52116002)(66476007)(6486002)(6916009)(6506007)(36756003)(1076003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wulog/QeO/n/QuPhk5BYsZq3Sk0K5nKD1580WXspS+abn1VotGSMAve1fOGz?=
 =?us-ascii?Q?ouIs5WNRvdWbYGQmHuFKfOzqiEelJfDGG9vTdlqmhYzreuN/Y8yQJZlU8GnB?=
 =?us-ascii?Q?D7+vfEW+AIFGtNCB+iZS/MjeOJNkVz5fTLAiiktex5fAApb5lUvj7pTARREc?=
 =?us-ascii?Q?/1ClY8K/JcoqOi/l05wXoq5QSrybYLwS1N9i5kb6E53mTyXqD+x/76vh5Db7?=
 =?us-ascii?Q?9gsMZaLIv+7JUTTuoVd+pfPPgIueSku4OinR84Ku1fXhzTr500eOAQHE6+7W?=
 =?us-ascii?Q?qv+N2bJN0JyIZrscf+KTOU26Qd8Be9FIw48UtitJU8jYY0grhHQQsh79b8Dj?=
 =?us-ascii?Q?BV+AGj9JcZKs7c2nt+t/Nq6m42Krus6Jp2AAtlFi1NE64+2IoLq+YLNR2v2Q?=
 =?us-ascii?Q?+6eDrmKS/oVSRSCv/55m8yatVq/KNt6q9Oe0BjpkNhzJnYu1b5yBCL0XPPmJ?=
 =?us-ascii?Q?NXXCzBpXMLUWUlzQpU2Z0vor7qZuKIjsHL13f1MtAKLnGz2vEVuFFayCCsmi?=
 =?us-ascii?Q?HFFp3o8l6mvaEB/zuiQQ9/J5dsOuI/ZSTUkuw1UDaxXgjupWWlzRz0yygfd/?=
 =?us-ascii?Q?JC0FzQX5X+PYj3dCjWdHFKE7CVrbjfOnq2I0nFlfZRc5nHaP7NvDp7ftRYWv?=
 =?us-ascii?Q?YPudulLnWwnoAGHokoVwyplNHh2Lmvv2muZXMo60PpwJ3PzGLo7a4JlUNFla?=
 =?us-ascii?Q?hlZOe/2t/jnyn875KZs7q9Vuk2Kp0tstntZa+IPJT5443+XnJEQ93N9+NZ9o?=
 =?us-ascii?Q?Q3hYS8QdjDn8lBONvXL6wrHf7hFwZDDbgzStGpRQ2M8Xxl5Gx/ES+XLl4V9Y?=
 =?us-ascii?Q?rBMaZP8xiaiZH4Kbq9Cm2srBo1HZ8yPNCYQPYmfkingy1Awh0gjX1Koh6v9o?=
 =?us-ascii?Q?ij1qck9C/vgrqkoXBJRFKZu7D1/GUCp+a/bvmZmNN/oSe///O4OamNIcwpyK?=
 =?us-ascii?Q?RSsdNwmBdXvqeL24WkMZ0SgAp4taBXCbJqsYhMoML3GtgfVwGqsEosc2sjum?=
 =?us-ascii?Q?kRpySEEKDG6PSoHMQrF0s9veU2o4GuU4lii9eJARkyGem1C3xmnK2JCZGJKt?=
 =?us-ascii?Q?bJNEN6xjtn0jykpTWNQLtOK7NKUWnALirQXpMZ4ZXchM3JxH+4xnBGV6FEpB?=
 =?us-ascii?Q?Jn7e6L2kYS83ZLSflT5J+fAAQHTbMPb4YeTAlA3m0SsSMMbktWHuBwLMuJPY?=
 =?us-ascii?Q?v75JhZVzE61brWCxdiSVGhLeB/kOlwtKeBfIk/VGUet5oAgvutqokaUijWcd?=
 =?us-ascii?Q?Y0OCv0eP1gtpovlQaYk40ZT51ONBNiYOg8BQrZBFn1UYhRbGAzpudJBmDFzA?=
 =?us-ascii?Q?iS6o7qpaJT084qH9eIZAGjm7?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7702e1-36be-4ce4-281e-08d931a9c1a6
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:41.9066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOj4D6lQTrYQvpoI5CzBNMleOlMvrIQL+WhHw3ZAFKYj5H5sfAFrLtjPp+2CXHZEZLTvU5eiljpaaFTnaDo9oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0260
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/rssi.h | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/rssi.h

diff --git a/drivers/net/wireless/celeno/cl8k/rssi.h b/drivers/net/wireless=
/celeno/cl8k/rssi.h
new file mode 100644
index 000000000000..26ea2b0693a0
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/rssi.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_RSSI_H
+#define CL_RSSI_H
+
+#include "rx/rx.h"
+#include "hw.h"
+#include "tx/agg_tx_report.h"
+
+#define RX_HDR_RSSI(rxhdr) \
+       {(rxhdr)->rssi1, (rxhdr)->rssi2, (rxhdr)->rssi3, \
+        (rxhdr)->rssi4, (rxhdr)->rssi5, (rxhdr)->rssi6}
+
+void cl_rssi_assoc_init(struct cl_hw *cl_hw);
+void cl_rssi_assoc_exit(struct cl_hw *cl_hw);
+void cl_rssi_assoc_handle(struct cl_hw *cl_hw, u8 *mac_addr, struct hw_rxh=
dr *rxhdr);
+void cl_rssi_assoc_find(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u8 num=
_sta);
+void cl_rssi_sort_descending(s8 rssi[MAX_ANTENNAS], u8 num_ant);
+s8 cl_rssi_calc_equivalent(struct cl_hw *cl_hw, s8 rssi[MAX_ANTENNAS]);
+s8 cl_rssi_get_strongest(struct cl_hw *cl_hw, s8 rssi[MAX_ANTENNAS]);
+void cl_rssi_block_ack_handler(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                              struct cl_agg_tx_report *agg_report);
+void cl_rssi_rx_handler(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                       struct hw_rxhdr *rxhdr, s8 equivalent_rssi);
+void cl_rssi_bw_adjust(struct cl_hw *cl_hw, struct hw_rxhdr *rxhdr, s8 bw_=
factor);
+
+#endif /* CL_RSSI_H */
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

