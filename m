Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5513AB93F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhFQQNt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:49 -0400
Received: from mail-eopbgr130084.outbound.protection.outlook.com ([40.107.13.84]:35463
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231838AbhFQQMw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:12:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eboMSuXu2ZM1dpkMgcOj8KeEy2P65nryrirMpHUzBgGhVAkQ/2qu5dt74q4PUQ7cyh8CYrIh/XSyp9QhCT6mKdC0xgvWsdr6zOJ46LrwYSaK/6WA7P9FqzjW/ECpLlOM4U3XHQIWCVJVJL48DLuwKh0JfJ6N56HJ7C08fbxMwaCRZDbwYNwbKUp6CPEGfDeNw0te05aQK2L+NfuyU4ECw5u3sJTBIDlDZjy3rUYlF3s6oxTa1q8d3oMXxGuyXdwViUCXYjUhGxLqukHHrC1OlBLgzj0Usf0axxFAxfKxP0akOSGalPrT6M7vuLtbxmPPdYj7FusBZZhttoinA7172w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zByDGFWJ5V9DIHhWDRtB4UQ1ExDldqSVfc/iVEBBXOE=;
 b=YmDYpRBTbRlViQzemEm1ju+3LyHiiCT8SadhMqEiCqOgObXI8sX7kq12tmTFPUeWwGgL1CTya6Gdi/3Cj8vRIy4tGwjmBD6fQZ3WKzveU/24M7+VFi+0jYWLZCHEldOd7lryUl248fAzKn8HW0z3KdxyQenNhIidh16UxBNsJPVPOj++XFRa1i1BFdJPjuHPHXsDWkJMtKRS+VSlamWqSf4e05aqrvmfu2kHd4Nqn/vuiKTOLnyFN88y3xuks/G/o8hnaB6m+tX/owzijIFS9zHrTJqUC2jdL2n2bvo6AvtwJNjP+W8Z3N/HkD1Dhibgxf8TXd1dM4oEnLZEWuBrsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zByDGFWJ5V9DIHhWDRtB4UQ1ExDldqSVfc/iVEBBXOE=;
 b=VKeQGsLm67NCeZdfYcn1lxRKyi3uxdU9KWZtxMvr5MhP4WE6gpnD1b3Kqv2D8Id2KQxnRWnGiKB8b3OmFcrxGg80q++Z31SV2e16sZNgvVhksb2HWPIaT+VFAWdfHAvrQgDboop1di6HU+S7v8dBT7/9oVwbtmTi4Hord9C5rkI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0978.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:08:35 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:08:35 +0000
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
Subject: [RFC v1 249/256] cl8k: add wrs/wrs_rssi.h
Date:   Thu, 17 Jun 2021 16:02:16 +0000
Message-Id: <20210617160223.160998-250-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:07:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce069845-0b4e-4771-f34e-08d931a9f7d1
X-MS-TrafficTypeDiagnostic: AM8P192MB0978:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB0978E09D2C8847D0677B84BDF60E9@AM8P192MB0978.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PHGzrlMaDFXTlyA+zgfigyPCmvc5n3YnJEkZVdCxmCwDfXELEjcK4jokea5ENYWfHAO0lPk5bkdB6ji7R5fvBUPzPXWMmw6ax0+dPH+K4YAslHLQhg17oTEnY9tPn3g1p3ljFshIM8x/jAcguMBVMLpsSKyopmueGMR4q4h4jZFxa+Wi3383JhS/Dc9wQnGaT3eH+lqEWi2eiqUTWUk5EhL1qxDExX/AbAzvPpSssdETC1ygtolOxPPhmmz/+AHbu8ie9FPOn6YE9o9XYlMmJzbWGt97tUNOrjqae4WNdtgRMqeYHM8hQcMtIC7s6BVB0hkRe4fjgVO9rK/16ZINlPRRLLRFaGcMx0ZudGTo3cPw2EDIGbpa4YW99LH2RvnaujqmI0nAU2pW8EQMQEVmxUydsKr8o7anFKEE0plI3j2dSHaezVpoTgsO+37llOfa/QPWOSkpiz0OqsB915L3hs5XwZC2K5dCqP9Pw8Zdqjkm6DSo3sts6rYuXkYAL/X5kR70d79dAHwDFXWr/qGqMgny3bTwB3+SUi/iFrCETvg2RM4RacUGtDYJjEX9KhZN/avJc1ha3u3iun7EeWC40vK3yhEKAXLiZXZmw9939inNcIh2eicwV4g+FHhMGHXGbRGrOyf3FOeY+a6pqrwiRjQo2UzQDZ5NlevqlhycwSub9rC7QgKXdHoTR2bNeYJMokWbANDOO0wiJe6juq3B+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(376002)(39850400004)(366004)(16526019)(107886003)(5660300002)(66556008)(83380400001)(26005)(186003)(1076003)(2616005)(316002)(66476007)(66946007)(9686003)(2906002)(6512007)(8676002)(508600001)(52116002)(55236004)(6486002)(38350700002)(86362001)(38100700002)(6916009)(8936002)(6506007)(956004)(4326008)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z0dkA0u2gl4X/xi8y0Y8wbMioNvqY1Oixz1yCgmQ9C52rfBVs2CSSIwFEvNO?=
 =?us-ascii?Q?d8xVpYR4mSpoIyad2v553uOyNvGYOShdcw0eDYjnNvkOOmWru8rl+eUbCl+r?=
 =?us-ascii?Q?bvRCk1NWu673PKtWgKFQeb/QX4T+z0xRynzNmGDk34SJQjJE2DlTUFJ0osxL?=
 =?us-ascii?Q?snHxTjkb6szWX7iY7E6E0oPFCGx9hm/+Rz7db8WP0EMMKc47htF8sTra1gsh?=
 =?us-ascii?Q?5fxFPB3+mRo3vnhmKUaIGjZoeXaef9AlWNfT1kq3SW7+nR5swEJdCI72RuNq?=
 =?us-ascii?Q?wLVqrF0ix1Yi214EvhoDNHRj1J8AbNj61xgkUusIwhVqcMKaDt8OqRtVbvAV?=
 =?us-ascii?Q?KoLznOfTD049VFnI+apUd5W0csLlna59XXeZjfeVKwdW7q1WlVDFIxPi9806?=
 =?us-ascii?Q?tU8aI1iMkIrxyKvnCkqk7sNEskXoxe/NdIuJNj728iksJKIqPcpbWb/l0IxT?=
 =?us-ascii?Q?bKsGw6kyIkb6s3efltIDYE7JQ0KDfnymYdNRn89a7/dZXkR7/4mkLa+krdTS?=
 =?us-ascii?Q?ElgIHWqW5SkDur2L+Dm6PrMS2lAhHdvQRSC3zfKwNqpWQaQ/4tSYpif/3w4p?=
 =?us-ascii?Q?hvdwSAc0j1aMFXC36NaHb4f2jQq7LQk5G+In4UEiBSgJsB6JIEhh2U6c9IKk?=
 =?us-ascii?Q?peWXXPLj25xt02JZ9gxLYYNBwdQ2PbCuj+y6NOOy3FqQMQwGAKgOWcvOkCzO?=
 =?us-ascii?Q?zbTGIukKX7KlVI7mlrU/h9H+IvhRD9Qp2IsNiRsf/cza1vCdI1cbMNn45XfQ?=
 =?us-ascii?Q?c2CerkSdgt/dSbgQXgeRnI8BNpr3DW69InWxTiL6i3eBxA0SMJUR74IRjWh0?=
 =?us-ascii?Q?+Syw3vRxKRJTPk91MXrUGMeJfhMgZP7D+G6oYw9BQ8Bryxbl2ZqwL25bn3BQ?=
 =?us-ascii?Q?+XzU1rhS+nPsQYBifhQpQm89Td/lCxhYV8OvGUwx7hzf8Imc6ZtrfcSiCD+n?=
 =?us-ascii?Q?Z6mTviUVm+KMNrRwYYAh8Eoe+v+IDj0GL7e71/jWvAdKlvt1ZWm+8ZtBmHZ4?=
 =?us-ascii?Q?p0yrvpyzBKO8E1Qvb3ozc/CWFerDGxRVXvJqcAiv1TcLyLhwhz3A4gAxdvd4?=
 =?us-ascii?Q?oZgCUaHb1F1osRR22fpDvgkvSNrozpzF3eQJWthOf8C2EK6uKcSeL/ofpupG?=
 =?us-ascii?Q?xQFKWMGCOoz6OI0e4G4icCjsfylfrQHz0zwRqSDV9WVJ7pSYj0zL1I1VJsXK?=
 =?us-ascii?Q?bksLJ2JiSXvNQppxXhHKX/D0nhevml1BBKmH1fCAeeUALRBVUgRzCqTWYirH?=
 =?us-ascii?Q?9R2LPo0rarph2xRqUoPB6aIYO54mcjcqNGQpmNZRp4Lmj8JlDvZtvdEcnak3?=
 =?us-ascii?Q?mKAV/xkqo2B9z+6c1TWoNXqi?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce069845-0b4e-4771-f34e-08d931a9f7d1
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:07:12.8403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AcCGh0CxYdxyXrEW223UohZxgVatE2t48TJN8fh/YvheA2FYANFl2+0eYWFnXY+Du74fNiAT0A7o1hXvN53v/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0978
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/wrs/wrs_rssi.h   | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_rssi.h

diff --git a/drivers/net/wireless/celeno/cl8k/wrs/wrs_rssi.h b/drivers/net/=
wireless/celeno/cl8k/wrs/wrs_rssi.h
new file mode 100644
index 000000000000..2a7f64c88aa5
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/wrs/wrs_rssi.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_WRS_RSSI_H
+#define CL_WRS_RSSI_H
+
+#include "hw.h"
+#include "wrs/wrs_db.h"
+
+bool cl_wrs_rssi_set_rate(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+                         struct cl_wrs_sta *wrs_sta);
+
+void cl_wrs_rssi_prot_start(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+bool cl_wrs_rssi_prot_decision(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_=
db,
+                              struct cl_wrs_sta *wrs_sta, bool up_rate_val=
id,
+                              u8 up_rate_idx, u8 down_rate_idx);
+void cl_wrs_rssi_prot_dbg(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+                         struct cl_wrs_sta *wrs_sta);
+void cl_wrs_rssi_prot_config(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db=
,
+                            bool enable, bool mode, s32 rssi_up_thr, s32 r=
ssi_dn_thr);
+
+#endif /* CL_WRS_RSSI_H */
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

