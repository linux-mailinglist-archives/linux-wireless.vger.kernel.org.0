Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019EC3AB88B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbhFQQIu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:50 -0400
Received: from mail-eopbgr30064.outbound.protection.outlook.com ([40.107.3.64]:27105
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231892AbhFQQH6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVd637/0kBY88+XrK3s3I6VYQB2PkTsu0bxCNxi135lHyqG8CT9sLLJCtArtrbps+2fBRY0hujy0mxTBDunpYLEw/QrS6w3HeAaoFdeTtMoCGFkGan/0hjSmtIwyvF1NwMfvRIUeeqLKILH0MIooT4VQmRpjIKoCVRknntPTQdwri/lpc1qYwwGtjKq2+pMs9RO3H+JWQW9lnb99UTcp2An7NBdt5kfTRNcn0nJ/XcVxCJ4qs3T/1vg/vg46mSfGV7+ZszOex0uy866qavWUkUbasw3PkkL4ykYH31qmYwNdM8Oj1BvjRtiNkRQvGcycubsrhCL9GXwGKiPI9tV3RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcboDPmWhzWDtjyEwf3BaWHaggXMelkGonkjGWti2Fg=;
 b=UYkjlaW867SydMeConCko1sqX2OhBuMTfL8QOKZp99usmPTuNlY+SqzJc4niPcAnNfK/1hAzBZBkPXFlUsKKtUSAQMl2r5PBebKn0ueHvOuINzmWml+Hry0DTlLKS8QHGTd4B2SDe1XnJEO5t/u1n/Rj4aE5JToRTE2NYHVNgqDysbBdQdv7b0ixrPF19hJNhaiyTw+oQ+WWMFQlloGLYwOWY0I2/3UBaoyrY4eESwG5j2S7ZbsGhQ2DgKagVcYsviw0I/wXURNpq/jGLzQb40BMKQUzYFdOhZnQIO/2libijpnm+/ENkp5631ixtI9ZZw2fE+Q4MCGD1UUEmEZghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcboDPmWhzWDtjyEwf3BaWHaggXMelkGonkjGWti2Fg=;
 b=bYmMtGWI7lmq+sHNl4auTe1t5PkhHJKRnreDLx6MAz0Dbq0UTcBMgqRoAOTqGapXaqG7eCntu6gFf3rQ8DgxVxRrjpfK+mC2GxVG//uY3rxYHitN43mzIJ3ZmpxrbuWM5XP3c3An9MZ0QfOEIOwujU8gbadhvdQxjy+Gckb6hk8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0465.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:49 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:49 +0000
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
Subject: [RFC v1 138/256] cl8k: add power_table.h
Date:   Thu, 17 Jun 2021 16:00:25 +0000
Message-Id: <20210617160223.160998-139-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f0c1932-6b70-43e7-d995-08d931a9ac7f
X-MS-TrafficTypeDiagnostic: AM0P192MB0465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0465FFCE8D93D911ACDAA993F60E9@AM0P192MB0465.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t5KdpMyBSI3oDPt2e1p/V7Jh/bS6LzWkWDIWgINv6rcPmTtHubcolUNOHUnDcb9I6N8MyA1ERGTGmzMJ/785RAoiNs7gc/061Q7vdec5D1CkOg9FIHENqQGQm9R/CbYoSEZXtu/Vf9YCii2SuOEkqlSVSKxAVbnJNZ2sNCCI4XdTyR9joXwALwG+njPDsqk9XOJR6tD1/7GcsmUoisBqVglxV76+1diF55aPIVM7QE+O3peHruQFPnGSHnnv7kepPkaNmfvgec1QzOzdnBslroLDZQx6KPFAennWcBotJQpCDdMUsq0KX3MeoDQWoQJcUDIiKFkwv4mED4TLX1fmt4Q0CTkOfEQtpBTAFHEUsE3YZtfVPwcrrmPE0iDNkB0oQel10l/oC8c1rviiDVFfdanDw/4x/M9vT8TqQ5FfjPQFznb11r2tks0MobqytHT7GdYYL95rCI5f6lSyoSZHneY6pC8LH0/t3Y5lcTz/XrzHvVxj5zeza4rAOYFQkrFmV3itArOj7moYIaopu4ximNod6tY9wGxHGXCmkgx7lPntCoHZ8dU0Sv9DzQwwLnQlD98eLBbj4DRdJPAgg4re6nB6mLZrjaw0fp/qiFfzVZqtuFxuNfLYfzvO5CriP+FKz0R+OU6Ky/eRT8S+nXQEy7XGFjTmPca3fH/w+9Lzm0Gr9OzCSZetKa93RdmvU55bsKkX7H9b2qxrg/eR9h+BSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(136003)(346002)(39850400004)(55236004)(6506007)(4326008)(5660300002)(54906003)(107886003)(8936002)(86362001)(36756003)(6486002)(38100700002)(38350700002)(26005)(8676002)(2906002)(6666004)(186003)(83380400001)(316002)(1076003)(6512007)(2616005)(66946007)(66556008)(52116002)(66476007)(956004)(6916009)(508600001)(16526019)(9686003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MGK4zurgyeUqIZ9dZ52nASPT/Tv3Qln1l1Xd2SzoG4K98Bdz4AbXy09+atTp?=
 =?us-ascii?Q?t9qaj/VRrGPL324w35WCOnpPVidsiB0/bkEqI2rVaMlehXrbIdzSt0dFYTqG?=
 =?us-ascii?Q?NmNGZEBEcCvYm/fGLZC6OVb0YM/nd1g5EGeb/D6LuZaSZKQCMk0yPxFF5vke?=
 =?us-ascii?Q?79zd+ToA5fMUkeKFYUEty9/16BV+JMZ55jiLGTMqkeISOH9N4x2cI863LENc?=
 =?us-ascii?Q?tyVD5xRy5kFuHdtVXAK3BW0UFGDNf8XvvDDnp1+NA78nJlQDEMd101yGnEUd?=
 =?us-ascii?Q?4DbxsOatOoRTQVi8JUUwfiuzBelEJsAJptgFfJRvUwrfRafFHLRaXzHBuC9k?=
 =?us-ascii?Q?Dygw8rY4D6hMpYYpaZUq1OH1F0N//CNkMWKIUy8hW3w1SnLOX7O/3cETPDDQ?=
 =?us-ascii?Q?WQEP5+5DkbDpDJUD7V7iKjWGEyqySSVVxQmiSqheafYeVIE6Y2nqjYNgvpfY?=
 =?us-ascii?Q?ai+510iHMMvKLFlAazJsHuLP0mFDK+ii1PdINf5EuTSYatn0YZug1iXkNpOu?=
 =?us-ascii?Q?qgB0+IQQbvpBz+ailgmXzg9+fVG6vTJTWzFIVU3wPuA1VBZP47R9g7oza6DV?=
 =?us-ascii?Q?DNXKs0OoOkk4Qyp1U7LIDvkWsTrn8v7FLj3s3mJh6Xmjd/EtWAUvP0w5xwBA?=
 =?us-ascii?Q?Dis3StNRtUDndp6sII/KT79VTzrIkaBcJblxE4hTx5n9+AQx9p1TulNrg5Q2?=
 =?us-ascii?Q?WTp8waD0e9jG35XMgWjXzw0VJyXdcPPdhyjBd0ZriBF7fFTVsFKGQH0UFA/q?=
 =?us-ascii?Q?Elryn8OA9xVqJ5Wo5MZ2/1a/dJa9XNpoJRjnMdTZkWRyP6Uadw/v2nC2CDu8?=
 =?us-ascii?Q?JrXPo2uGR0xI4tsxp/AGgHH+0Loef7mQbARZYqP738yH4874/2AYJ+SW0vwC?=
 =?us-ascii?Q?VZ6tIFMMNWrWhP3L/CRZn0+LvOYQ0BLuFiRxnDpvgRwEu7fXOzRUaztrDWvh?=
 =?us-ascii?Q?j4ISiUwKYPo+uzCFPE+zmN2DS0ijxzx/RX3clXaUqgxV/2HaSwNoiUyLcWST?=
 =?us-ascii?Q?CVIwi0Gszoj0mFT7BiI8ipQUHvEeHORW+LSzydIARm//xbPIOwRFxTgrll9f?=
 =?us-ascii?Q?tOOAkcXo1smKtwH4CD+uueIcPaI0mgkonUWWa+GPZZ6zjtKfja+QZCEeF0wo?=
 =?us-ascii?Q?HneQI3ZOk3v1e2CL1dHX8QbFLVBLVx4H9gZyS0BBecOU+RXNOLBqPMf7WBM3?=
 =?us-ascii?Q?pnbqkNTerGd8/bebX8lXSTz4DDnGjqglAvi0BUY/B3GZHSa4s+K0eHsdVD1z?=
 =?us-ascii?Q?gVBMnBE532MO9LvtLYR8NedbkWRnTxWnF1cE7CObhDhToiu+JEsP/LJ/H0XO?=
 =?us-ascii?Q?ofpB2L4DZLqn51m5CwPV94aG?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0c1932-6b70-43e7-d995-08d931a9ac7f
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:06.4881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYxYV1ufVFP9epDJRqB0oYorapJpm5wvWODY5YNkUIHkt3WvuKTpWAxeiWKF0/lQ72f6ol8JVYuNCwtKEwGQ4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0465
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/power_table.h    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/power_table.h

diff --git a/drivers/net/wireless/celeno/cl8k/power_table.h b/drivers/net/w=
ireless/celeno/cl8k/power_table.h
new file mode 100644
index 000000000000..ba2c45f8d408
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/power_table.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_POWER_TABLE_H
+#define CL_POWER_TABLE_H
+
+#include <linux/types.h>
+
+#define NUM_POWER_WORDS 256
+
+struct cl_power_table_data {
+       u8 conv_table[NUM_POWER_WORDS];
+};
+
+struct cl_power_table_info {
+       struct cl_power_table_data *data;
+       u32 dma_addr;
+};
+
+struct cl_hw;
+
+int cl_power_table_alloc(struct cl_hw *cl_hw);
+void cl_power_table_free(struct cl_hw *cl_hw);
+
+#endif /* CL_POWER_TABLE_H */
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

