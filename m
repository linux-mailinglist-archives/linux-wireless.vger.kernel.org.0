Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061603AB8A1
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhFQQJa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:30 -0400
Received: from mail-am6eur05on2057.outbound.protection.outlook.com ([40.107.22.57]:62080
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233669AbhFQQIM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1W51z2lAdkjlq2VRMENs5iGn0nr3o63QFriP4d2asZ/3l3auBAS6ZGYo9hpn6KBAXaBPQJcxMi6fuQfRPIYZCd9SrPy4Itj9McHPVmFlFVFYVEisD21Hnv/QE2KQ0hubdorr53x2e+RUK5LCn+/tHulH8BHPIi9uTU2ITY8UwZ4yasUxCo4QGv3Eli7MlPvxjXC0VY+TdaJwo7IDht7OzHYDCIxx7TUb93H//X5tja2+ANOGTRdh+OBtimBpwfiEsoeyNZ/b5A/fj97CsKPUOnqmfVHpqc4dUVer8zJ9TNjt1u+iZ1SKYWP0ZfOA+K44iJyTgJORCzAXHvxwjfupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIYYtFylTnYRJkHDG7LwYRvS3+mhB90VV+kvD+vpz9Y=;
 b=HuzonVrp9OWpcOoZiOrrnn/2FIW+dn2TmaJhXizr011NQvwVRGPtzegB+Oy4lMJgF0ob8c2t9vRc/oL2ePuUDlO14qeHQEQws977YxtEUsQ1lq8E+ST1Nu7ZVom/poqMGm7lalIa6iMd2khLQ+xhMgkK8Wq6EleDQiIXll242FtEY80aHt4mGcRcP/hh5eTffB76FBHA8/6GznkzmKuSHBdYMWxBEVZjNijQH+1ll13TDNSnKYX9rycox8UXoZY6gnyaOYV3+TP+Rq8MFb76jr6CLQ+hQCEvA9IZsdHnpZe5iMh/uPzg91jy6h1/C/sSfzHH69Z5afZvVJZ4PZ1+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIYYtFylTnYRJkHDG7LwYRvS3+mhB90VV+kvD+vpz9Y=;
 b=HniwYhFJh6vKrvr/VoTjoqvJea4sFTT6zCG9J5MDre5vNWnGuGOLtXdFp1Znsnigt9CcJ6EN8ofcf86A63G3zKPHyPXdDRUyiZYowWKQXkM0XNwGTRAuEpj2JrEm9QwVGuvGdZ0+FiW9krqt+dgtR94nUuhZmuXqObYmJ/u7yxw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0402.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:46::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:05:11 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:11 +0000
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
Subject: [RFC v1 116/256] cl8k: add motion_sense.h
Date:   Thu, 17 Jun 2021 16:00:03 +0000
Message-Id: <20210617160223.160998-117-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50ea62be-8bea-42c5-fab0-08d931a99e47
X-MS-TrafficTypeDiagnostic: AM0P192MB0402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0402995138537F76C56A1AACF60E9@AM0P192MB0402.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w51z1LJL815/V4QVFp28aPsM9qijVPgk89aWIoOKqfsR21/dQym2KMa6Hl+IZuT/66ThwAAAfYQRHgexJ4SkGohrrwF7aobC5q7WRgXpTmRU/cgpsMFgPuUoPJVDYrICsbzoryBEBg3ESHdQ1rXV1MGADQCh8JdQF+eMZjswObrYcDg/MLC+sY1ReX0YrPjrXggsMAF2FFp/Iel+5TWCSaDjOyJqVwBoAj0EEB0ttr5+S9QzeD5kqnd8JFFwT4a1sijTa9xLgWj5rDV1EXyAluppOLWeGTkjXBJWD8Ur0RtQfFEirScvg6bamHKe1kIqR3F0yFEFth6g/WhClydCL8yyM/8vxZJZbGVptZ+dr11Yy5y3w0e02HQL+NEMHtb1N7bkOyDHBqC7F8f4cypRcXbCBvZjGfVGGce6MYgcRPogv7KU5FvjTliN8kO6hwj28RON1xmgtg1bAVtQaaB7/gn9QBEuLSx2O4SfhBwaBxBr1eHHruh0dZTudvCCcMrQU5TMxQb9Z6tdLrj3Pznx68l7XFVW0qEyMhZOeqQx5UstchkXDfos2+wgAljPtbrf3L3C4HTnrT4JDnswJwfqafA1SVA6IgGu4A/k4PubtOIMDgi8O89IkAdkY2E/k8aTdGFKyoNSb/Q6PzAaEfT5KqLCckSGW+kyOcNlG9ZT2bwYJkPm54QbNwV86Gmx38Cn82lwnXiLpU5tEZ//Udp37g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39850400004)(136003)(376002)(396003)(366004)(346002)(6916009)(6512007)(9686003)(6666004)(52116002)(2616005)(186003)(16526019)(38100700002)(38350700002)(1076003)(6506007)(5660300002)(107886003)(55236004)(86362001)(6486002)(8936002)(956004)(26005)(8676002)(508600001)(2906002)(36756003)(54906003)(316002)(66946007)(66556008)(4326008)(66476007)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c63DO0dd6B0KTP3iPqTGCmiQBlrx5fJMEitCia4OfgodKGHCE+OdqmmNeKhc?=
 =?us-ascii?Q?ucDMo97xPg48KaG6FBAmbA0gAjLz7AcPv6THcTSBumspjF+FfvB58n7hP0QM?=
 =?us-ascii?Q?OLfGtb83FAkGvb8ffNWQsvztb5b+BjpToZkW4/731WIIsxoEhVSq/C6gpgyH?=
 =?us-ascii?Q?PNzLeNJg0nAAkmjOJ0AjR07DCjKW7vXBasgIN1d92+QhrTywVuRhhau1If1g?=
 =?us-ascii?Q?XxHOOyfOHqq+9itLYamo4/chFUi0mimH5x/OorMUkHTyn7c/ERYOEA9MO43K?=
 =?us-ascii?Q?4cCnre8rt/OXd9R2nnDpKYkWa3ZklPb2B6v9nDMpe+x6ZCVn/z6q9c8X8t5o?=
 =?us-ascii?Q?0/cTBqkYYF8d0RNo1TIUlEpPdRujuROsGaIFE0GehqF1iOB4LTvgcQ34pcrk?=
 =?us-ascii?Q?1LG46GeflQdKDyJRy12HwCtXlx/9txg+bHm0zQ+eJwNutEElGto4+b1zXP1S?=
 =?us-ascii?Q?gtGod+ei9GNVh1x6vIwPkIo7meZGI7UfoDzAlJimJApVmFdNc/MkpzeivPdy?=
 =?us-ascii?Q?aOnvx9QkM8UiTcBuFNlDnCDgk/WlwccfINcpJLFh63OQOXO9UGBVs9rSSYuO?=
 =?us-ascii?Q?C6jKcuuQBz2tG0CNlJJSzr5SQceXIpX0fEKPBZypGd8COmALSMvddex4N9Vx?=
 =?us-ascii?Q?OxSkpVH3w7+qaMCWr7eYyNfY52FB+waEk7CD+x/meLgVhhKvMgyOX3JGQNWB?=
 =?us-ascii?Q?r1nX1aB+JnBvRALXwagqMZ/bZnQOVkoyORHyj4EWXw5nfxttAzhue1cI6SWq?=
 =?us-ascii?Q?1vN1Mj5prxNhIbCLZuxKTzri2qpcflcLwNa9IXquPaUOdspoY/mxJpqloc6g?=
 =?us-ascii?Q?/+wG9EdebmlUvTsrmj7XJKjWKgeO/I7k+e+Z5dUP+ul/VxQUGwpsBj+B5vbc?=
 =?us-ascii?Q?C5ADxcM7G0DlQGATBLqBO2p00pGMC0ZEapxaXlPnJ9t84lleEJbdRkwXKjnh?=
 =?us-ascii?Q?DIGFqyLhFJxHVVBZbTdU+vdyf8qd+ATmeMpxp2e3T+5J+1xc+5VV41scnsv2?=
 =?us-ascii?Q?6EncUrzDqjbnoPgZcrBMZSnWA4eXPoQl5Y8C9bkm7LXht2dsdiTPthKLjzsj?=
 =?us-ascii?Q?2GxOkdeFOy9YKewr758vml7wtstjvfa71MOqM5953XKYQvcfb1s17WtbZwNr?=
 =?us-ascii?Q?1Nnk1EugWPEfaOLr7rD+OrYKMek/4ta4CjXOPoakG9nxvbp+8Ci/ymwICX+h?=
 =?us-ascii?Q?oJqzhvxuRjKREOQWFK0qQpD6qyigweshewRMKnTebFlynMwmdDZY2OEYwpCS?=
 =?us-ascii?Q?J6MFEk72GG1EgnoZkKB3n5TYwbLxUdMxuJ8XCiy90zyqVwZ9uoY8mDT+D+J4?=
 =?us-ascii?Q?dqWZ+0zA5YCEf3mhxqk48xM4?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ea62be-8bea-42c5-fab0-08d931a99e47
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:42.5830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZ4RrqGeEM0mo2q35QU5M+btzIEh/c24QB2BFwoiynh+EaFCr8mNN8ZlTqRjwqtegdvAN0++53scZKx6MDI8pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0402
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/motion_sense.h   | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/motion_sense.h

diff --git a/drivers/net/wireless/celeno/cl8k/motion_sense.h b/drivers/net/=
wireless/celeno/cl8k/motion_sense.h
new file mode 100644
index 000000000000..a3846acf278f
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/motion_sense.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_MOTION_SENSE_H
+#define CL_MOTION_SENSE_H
+
+#include "hw.h"
+#include "rx/rx.h"
+#include <linux/types.h>
+
+#define MOTION_SENSE_SIZE 30
+
+enum cl_motion_state {
+       STATE_NULL,
+       STATE_MOVING,
+       STATE_STATIC
+};
+
+struct cl_motion_rssi {
+       s32 sum[MAX_ANTENNAS];
+       s32 cnt;
+       s8 history[MOTION_SENSE_SIZE];
+       u8 idx;
+       s8 max;
+       s8 min;
+       enum cl_motion_state state;
+};
+
+struct cl_motion_sense {
+       struct cl_motion_rssi rssi_mgmt_ctl;
+       struct cl_motion_rssi rssi_data;
+       struct cl_motion_rssi rssi_ba;
+       enum cl_motion_state combined_state;
+       enum cl_motion_state forced_state;
+};
+
+void cl_motion_sense_sta_add(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_motion_sense_rssi_mgmt_ctl(struct cl_hw *cl_hw, struct cl_sta *cl_=
sta,
+                                  struct hw_rxhdr *rxhdr);
+void cl_motion_sense_rssi_data(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                              struct hw_rxhdr *rxhdr);
+void cl_motion_sense_rssi_ba(struct cl_hw *cl_hw, struct cl_sta *cl_sta, s=
8 rssi[MAX_ANTENNAS]);
+void cl_motion_sense_maintenance(struct cl_hw *cl_hw);
+bool cl_motion_sense_is_static(struct cl_hw *cl_hw, struct cl_sta *cl_sta)=
;
+int cl_motion_sense_cli(struct cl_hw *cl_hw, struct cli_params *cli_params=
);
+
+#endif /* CL_MOTION_SENSE_H */
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

