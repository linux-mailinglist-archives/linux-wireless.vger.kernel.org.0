Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80703AB926
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhFQQNC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:02 -0400
Received: from mail-eopbgr130077.outbound.protection.outlook.com ([40.107.13.77]:23879
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233709AbhFQQLw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HytxgubL/AuzBxLaiqYj75yAM5qy81WGRx8EsEVLTyWNCCMLVE/19eDXn9CVjSMI4pMaDmLITDGZdVTcSYz+TyH7aXeyUx19MUj/jyn2XLKjtISSeIkzkxT2aHJAwOHnUKZiAFX4nZ8oLrhV0OobFCVIab4eosV7V3v1QOOOZHQouJmZjZ9gEp3Cuz53tBfW/MNYjw9XL4yir+uUhavml5hKB4leHCdpxU8/RZbDoIplyTMNFOm0Q/QRD+gkS8R7hw049F5LOTVXrf978EVJu4HglXIonXJQSfMGSuBbf5ubo8VvS70b/eVm5UGt0PjcIiPykNAgLfidDSJYsDcABQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrAhmlWjzAmRFbllSeMdMSdDYRmifAX7wegtulbU8Sk=;
 b=YbkHqc5VeG+wlll1hEZwJw1ta0V1NnwCNLU7SdyVcoJ/IEZfJr5JYOMiN2TvzD5T4+qfEijTuAatvuEgCTqFDMLMlyAQc8WdcQomBBLc/vDeAbHO9ZCCgE41If8ToW4tSr6qtf9BDrw5cVExBJ7QdiFO7aGREAtAEXy4qFFuCi1kMi5ZibU6SzhgfIW1AnsCQzEg4XpWfsVClB5sSzesbVgQ1TgoFk0ms7U3PBOxU0w46aMRrtqIc73Z/fVALvqIqlosO75aIEY1YrA+h+MOkXrZj9JpiPLnXaB/MZB+ohrwXtgRr8i9HL1RwH8GhmkZlhfotC+X/15v13omBUKBVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrAhmlWjzAmRFbllSeMdMSdDYRmifAX7wegtulbU8Sk=;
 b=ixJItP1Mzw4zneURvdLByPSvquTQTHbeu6LEdNp4KfMXWaAwETBbvwAEy/gal+Xitfa9sGuhh3wbV93hkjP9g/xCj3eO/dPWXF6seDWnmztYyjkil8MWmQiRQiJkJwJ8dpVSa8mtqW8mZPcgoTgyqpuW/DnBAWMA5jLYgszZP7k=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0452.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Thu, 17 Jun
 2021 16:07:56 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:56 +0000
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
Subject: [RFC v1 228/256] cl8k: add utils/timer.h
Date:   Thu, 17 Jun 2021 16:01:55 +0000
Message-Id: <20210617160223.160998-229-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47cf599d-f4e6-4724-1748-08d931a9e99f
X-MS-TrafficTypeDiagnostic: AM0P192MB0452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB04524197FBDC5118AFC638B7F60E9@AM0P192MB0452.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PkGNxWUPMtMAOLQT1cbvVl3fyC3ztabu8qJIV/+RWObDPHZ98a0WWIgTp5kDhLC6hMByvb/PGBSmYDhLRv1KgOVEYJt9J5LCa80yZqWzbhQf5soCcHo+wMvZkiSutfe2kPL3fB55yoqRaqoK5ED6WBAEMidC5eqTy4DtZkNpzNy6bWMXAngMtZlE/3T9tErold7ULmlcQdUTezIQQ2EGKk5nSQHb2jbBqPu/EqX4YmnCk2FJcCO5ihLU99ZOxzvVo+r0+HFnVCSoCh1+SBQRbq2fO9B/fdke/P1cWx64430QOJx7BrAI5zbRDkTGBg1t2PHxaZtS67vu9GXJxgxF2fecW08ck4gHQEwDKmkPQ4ZdwlQtymKyMLxZPxX3JdPXOsHa0w9hMFaayz7HK/xo1+9hFKKW70Zy2lswPGV7VHyydR7es/x3/c/7bSXHJ9nSrPn4JcJgF6BNcFFcUcpYdrCypYja5iWLPVfTOSjn3ilxRDvRUXE1lz8DXBkXIwqL3FQn9Ao83LKO0/v+15AsRP0nP2tR5W0CZeAJQB2e+yypV8ftMwJZQjRlMlannSakia7iZSPvsYSk+0ZKiOskZ4pZxyc6szkbIqiDPnFz/2p+pKs28Jof/K8tV2tFA3EyX5V91jTSrsHItlAaAgMA7CIlNo9KVN1OdMD7p5fOxW4l8pNcZNwzMl4jaRD63Po3XzLiqh1PkgVRFcivQbeDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39850400004)(66946007)(66556008)(54906003)(9686003)(6512007)(16526019)(36756003)(107886003)(8676002)(66476007)(4326008)(26005)(316002)(6486002)(6666004)(8936002)(86362001)(186003)(1076003)(2906002)(2616005)(38100700002)(38350700002)(6916009)(956004)(55236004)(52116002)(508600001)(6506007)(5660300002)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?grWlBfcwdGazvPW1ykgGkR2+H8alBFqhhIbY2DcTeKUgVKkmUZ45lQe/RnOA?=
 =?us-ascii?Q?AjWLDokGvfoMz1qUF9EjP5gwoMkd3Zo+H6/bo74uxOYv2PEdWUmnbkhNGKSF?=
 =?us-ascii?Q?IQxALR5r2z8as68sF+Cgb/srDf20/hH9Roo+OZxYaJ/l0WtwhAWFVD9DJEJb?=
 =?us-ascii?Q?aSPIKUiakYTHMrvRWHEhEzGCapSMxlff/WpanxWikbfRqi3daNawz6pTx3X/?=
 =?us-ascii?Q?/mwkkLQ++DRR5Ks0YB4Pf1BuSBRIDiHhPVzM7QjEWDbmiq+EzsI6RbuPURTK?=
 =?us-ascii?Q?WGoKZ9gdjovenDghwXwkOY4aLWcsgl7a6XRtL9N6n+kSx1OE0ki1zCKYua0X?=
 =?us-ascii?Q?PWA5HdwL7AOr7c5LYjktqNIfKTnPllx/IgB/uRyHj2Q08cAyVGkvaDUAbxoR?=
 =?us-ascii?Q?M9S7ILTI5g7enreSOgPBxUVVUZ1OLIBhW0+0Rzdgm2pGvexOBai7A1IKKA+M?=
 =?us-ascii?Q?KOB0Udxrn2bvtzbn7y2pNWZKSI+dHaxB1/rj+JTpMAMovK8i1F3qscdiNvG6?=
 =?us-ascii?Q?y/rQPXoFIgua0LUOQOg5UsOAtA1Fwr20ILkKIgsP+4WfPinpzVQ3KpBI0xE+?=
 =?us-ascii?Q?u0m06ExsCOhPK03cAyd8TnRp1pCd83OrkpLL0qJ86AYQ3lCmAjSZYKzIiFZ8?=
 =?us-ascii?Q?0JSGDRzXTcOXGG6UNcqg5kuZwaubG0dHNa6BlNIBU27neTf81Ndzm5R37Lx+?=
 =?us-ascii?Q?wn6jFzPiK4YNPqL98OAQYZS1IOHrki2eAqMfLKCNXTVfxgp7x8FDrehWqMrB?=
 =?us-ascii?Q?ZbZnCjcdczqF3IA1629+p7ImXhpV+81p/Jm/DD0jq993Of2h40hkZxdLBwoW?=
 =?us-ascii?Q?8fIsbv0ryPPnki4wQzxJm6VlcKJcS3FyuV5PILqbXlyHcyDM5XRIDI0hgdo4?=
 =?us-ascii?Q?Cp0xKblcEGMBVXIpEhJ1QFtKhDx0jOJ8BSlZyxtrIvcg3YHpx1tnNQFWrpu+?=
 =?us-ascii?Q?qUe5CALFg3pGVVL70nNBmdO1yhRu7L9bi3987x/Mm0N6YcF1W+bhb/WsU2Nn?=
 =?us-ascii?Q?JI8dkPzLVBk514fBlQQakmbm9bCyNjO2rS0nkI+xZG7zp3g5CBFrYIbqg6xI?=
 =?us-ascii?Q?pkqze6mfgAe+8fArpMVrN/FSRLW8jAfL1YPz1K1t3nWO9D67KeW1PtTUlXae?=
 =?us-ascii?Q?10Pyh94X0/NWRSlJkk06G9L5qO+AxEnbMDPutrgdR+SED6Dn1WVlcVogkh4T?=
 =?us-ascii?Q?i2+OdYAZuproaGW9Ii7mFh6PVdcCHCkPcWQHs6FvJ1Ymgo1Fl5eEIaur0Kmr?=
 =?us-ascii?Q?rxxH3tpnzaWtFRer2Vv3uX7k+7sCCtZl3Aj9n9X4ij8fcpaKZGxEUCAjWcJF?=
 =?us-ascii?Q?GcixaJodHd75qtgVEe9IQW/L?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47cf599d-f4e6-4724-1748-08d931a9e99f
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:48.9771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsjI/mSB0fQjFMWXTkoekG93xQQ2d+wVgQHbMpx1B+3pz/TVhaz8yTDKccQ7uTXTMqTgjJ4EGBK4rbF0jhFwEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0452
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/utils/timer.h    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils/timer.h

diff --git a/drivers/net/wireless/celeno/cl8k/utils/timer.h b/drivers/net/w=
ireless/celeno/cl8k/utils/timer.h
new file mode 100644
index 000000000000..1481d8d78db4
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/utils/timer.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_TIMER_H
+#define CL_TIMER_H
+
+#include <linux/timer.h>
+
+struct cl_timer {
+       struct timer_list obj;
+       void (*f)(unsigned long data);
+       unsigned long data;
+       atomic_t period;
+       bool periodic;
+       bool enable;
+};
+
+void cl_timer_init(struct cl_timer *timer,
+                  void (*f)(unsigned long data),
+                  unsigned long data,
+                  unsigned long period,
+                  bool periodic);
+void cl_timer_period_set(struct cl_timer *timer, unsigned long period);
+void cl_timer_enable(struct cl_timer *timer);
+void cl_timer_disable(struct cl_timer *timer);
+void cl_timer_disable_sync(struct cl_timer *timer);
+void cl_timer_rearm(struct cl_timer *timer);
+int cl_timer_rearm_offset(struct cl_timer *timer, unsigned long time_offse=
t);
+
+#endif /* CL_TIMER_H */
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

