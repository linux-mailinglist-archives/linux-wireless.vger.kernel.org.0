Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F46B3AB840
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbhFQQGE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:04 -0400
Received: from mail-eopbgr140058.outbound.protection.outlook.com ([40.107.14.58]:8512
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233622AbhFQQFw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCFf89JXLCr+4uZpdXJxstPw8qg4qbxBBy4xzBCoeWsx9xbnLRYv63KIU1Sgrey13wLbVLdTQHhUSCf2VdSxjD3+LwgBuyTi/vI/VOxHoaljlGZVEkQJEv5fIZ6RTVq23OJ+Slm3GU0JvKd4rbL2FcaT11tLutYf9ZEHxtvwIy8SkqzrNgye5Qbc6+giAiKFc8FNQamKa/3Yq5nTzmfpGkGJ66d1bbABxyrG25/LkmWK3AtBj8PZpUo7kqXzc9GDYJ5o2uhSUAmmOu/ASXmV6v8My0W7UGNjXJevpDttpU9micXaHUI/lr+m0HjmZBDzs2nrVN94TWacAJIGAGVb1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KWpoFfCnDQOx456D1yibHT85vg8Xc1IEKNL6OTFKC8=;
 b=N9DOQWw5VWGTi1rQbYRaTCqOLARPOv+yHue+alsT0SaWUkvS8tfEkA80tVpzeH8tscS1hgU/gdrayMnBlSYFUVSD6Gl4J4BULwfSL1rqxM2Vm+igZm9Uk/w2NBonFThPhkOonZPEV3rawBVL8JDP3TU8NC7XfGBWFacDRlF7bPFk1M/U/MWL8G8a1vl0Qx8g7zkfGPEq41TDNuWIzO0rKgkOj9iw3kSq90gl6FoB/dDN3CEek1wz0SGAfHP3m7XYEw8QWnvMM4kaVffuzmuTuOr9nIeov/BNAwG3DiL5Dqat0SnHej9fxlE+dJXHsYfhqWKK0gRw4g9jnl8q4L8+gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KWpoFfCnDQOx456D1yibHT85vg8Xc1IEKNL6OTFKC8=;
 b=KRkRRbHjZAjCoy0p2T4utxP1FlDRMmUjwXQxViIiYN7Y680+Y5imaKL9MwacMdvjitN6ESTva/kA4XcONFQ9VTcfHytaCoKuFLEskIXw4IyhmnPr3bL15kPp1DEuuxERxLyo6mRSYWdBwqK14C7XGsg3ifMq4fL2dbPdiYRPhQk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1234.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:03:39 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:39 +0000
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
Subject: [RFC v1 037/256] cl8k: add chandef.h
Date:   Thu, 17 Jun 2021 15:58:44 +0000
Message-Id: <20210617160223.160998-38-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5150c747-026c-42db-f7ce-08d931a96a1f
X-MS-TrafficTypeDiagnostic: AM9P192MB1234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1234E485878D42D422DCA3CFF60E9@AM9P192MB1234.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g2JJxOydRMPzeOMY2ZPpGRr0WSedpSo8YYnRGGBd25tH6vsIBjsAq1vlfWG72jbpZp29Bg3Jz2DIyxi7827Qh9C0vEc/6tTm/EoDqOX0HrCfsmRurdtNncYKDMG9UOJy5Rjs1+hWqvs9ajFoBvzuY6kFJR7Yi/Oin4bp5eu0VRin11vQdXikPLZlzNffJwh6/FlZ8v0R4D4AZ1sE68WtpqtciQsZHrDD91BYRU0OMadL9zP5fh5tkVBzrYbtGEzc2drxHnXYxikUvcS0ym8iKGxk9rPwex5dv1SMg8Ibdv47aCTSexmbITLlgs6S8cIRI9RdI2ypwP7HYEftrPYv8QSUwuwQk7oaxGlsc6Buxgae37U2+9uSO5e4a76e6d9xYHnwqp3i3INBTEXNRu1mEsQ/zyJDrQrPZvQIZ9OPpQFbBxnvq/coA0nEl4arVPi4KMaOpDSJe+z3J5PF3SOGxO7hbpIJbitD3gFMbIJh+jkCDkXZJkDUzyF+a+NTxySw2evQBlNr6Y3bEaab4FurAZePLZ72N2KBBFMqF90Vt3ANdF3bZWDwuDsm9eEkRjUZu6v7OoT8bQw1MJBwbC+fZG20TRJcRhCXY6lw9x0qFvIGmSRxu+7OTTCNc9/1PEJerqe/iCgTOJhv/cS+UdwM9Zlzuhr5u9Va43za/ZJYkgx86IX5WGc+FPKROQB7o0etrHp1P53G3pz6qExgCN6H6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(396003)(39850400004)(6666004)(107886003)(36756003)(956004)(66476007)(66556008)(2616005)(66946007)(6916009)(2906002)(26005)(9686003)(1076003)(6512007)(6486002)(16526019)(6506007)(38100700002)(52116002)(86362001)(8936002)(316002)(38350700002)(186003)(55236004)(54906003)(8676002)(5660300002)(508600001)(83380400001)(4326008)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ea2Hum377YXihS0Dj8hXEqioFooaCty9divkzXnwDOWok+H/2eoCv9oX4H7M?=
 =?us-ascii?Q?GC76qtAoEUQYqBKKTKSWGr4Js6x9iq6A1lCINhcP+81luVamrH68P4Fzc42M?=
 =?us-ascii?Q?BLjDqEkZiMx+/NeKBzC/SDGU8BgCmSoFNSwbxW2pMHminRBekyo7kzvNDhZF?=
 =?us-ascii?Q?EKeGA13Vd378+tViY+O0kDIoDrL/LuxGhZhh84YVXqqXs3e3Q/gIoJPnKOjk?=
 =?us-ascii?Q?WnZGqyPxMEBhFL1MwE0cr6AAF5GCGmZqhijy9GjieIk2VIkmFpZZbFrKj+cL?=
 =?us-ascii?Q?UwvhnOBUpKpwq4sIRDq90dtW6Berl6gyqSEU4VWEtbnPWLQ5ZIO6eyXX2QMb?=
 =?us-ascii?Q?XntKAeIqkW0/JpUVRH2zrDOBUPuZg8QRgTVqtgmzcuOpdGp4p79RywhDs7Te?=
 =?us-ascii?Q?knxFjD7KKbT20LeHBinzcFsZQUhir7P6cA4BECXzguPYf1uUlpn8vPlPcacO?=
 =?us-ascii?Q?k+5PHfCHHGinN53lPpZv8cNlUi8cG6lrZQOdl5D4o/zEjlKFEOu1agjAPiU1?=
 =?us-ascii?Q?PAlje1BpXIq/0xT4V4hp+S8awUhrROlKIleE6SJcZfURo5+xc6x01cq/GkX8?=
 =?us-ascii?Q?OlWHPjZdrDYtDOdl6ex9VPYEWUYolHaE5e+TOabp1SYZX+KUKsy1bH7COxBE?=
 =?us-ascii?Q?apUWH5Nt7l2y2Wko3K+77s9daPhKz60j5JGhuGinee5OQVI9HP+XisU3ZXep?=
 =?us-ascii?Q?4qheWlfTgO9rABJMWB2uTWbPtKaXD+0agoqRlR7fKrICV6yTaV7uRzYWUodv?=
 =?us-ascii?Q?WZY92gsua1v+YirLBz18d29KoqhZbOoTeJKtdZjhU5+HEFiVhed2R+aLO4qT?=
 =?us-ascii?Q?CrYNskT68evempYzfBQxBtQWWlhkcVmvJAUpEaiLuOtEdje9es6jnj3Qi19B?=
 =?us-ascii?Q?Y5bNtRc/b6O9GnVyp6EKy/SBWMDveeJ3VtilDOyTPX35xiBFOZVlPddIuiH4?=
 =?us-ascii?Q?M7bnk7Uvzmf5Fb5eT0eh4rqlaNWMD+glPzx77dnYzlxQwZCQu92/6LtBgCYA?=
 =?us-ascii?Q?td/T0b2+87dLkn2CcGUY+pwYKhVOdiChW9bPraxL1C63qkcsslzZJUaskk2O?=
 =?us-ascii?Q?hDcHwIlFKAkwNugVxmvoF/rUbkgyfU8RW9MFfq6BBs/S9UMQOasYrp1eumwE?=
 =?us-ascii?Q?n6bF1dxRNqU8W0OOPhmOwLg1QWXfgBB53V+daP+32dbVyCukC2RBsGIo84Cy?=
 =?us-ascii?Q?ScK2Pg3seL0jWSXYDaJgBwo5dx8I5hUcRTQT4+w2Amf58X6cG0AgNY57m/2w?=
 =?us-ascii?Q?XQHtq53Fgo9rNwuDdNRV1r7lcZvRrKJF0cYphuhuQbWVwA8qnc7vIfHbcawJ?=
 =?us-ascii?Q?Oc4h2+sjv8Nni6t8UVx2F6FG?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5150c747-026c-42db-f7ce-08d931a96a1f
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:15.0932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDttx+5bfO1qyJA7mm2eY4OFqf7bhuy11S2+itw22E+k6/q6DqGVJLrQiXwIF+rsePaHCPgoLcKmKF0Gv1MCNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1234
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/chandef.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/chandef.h

diff --git a/drivers/net/wireless/celeno/cl8k/chandef.h b/drivers/net/wirel=
ess/celeno/cl8k/chandef.h
new file mode 100644
index 000000000000..414e5c76f09f
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/chandef.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_CHANDEF_H
+#define CL_CHANDEF_H
+
+#include "hw.h"
+
+int cl_chandef_calc(struct cl_hw *cl_hw, u32 channel, u32 bw,
+                   enum nl80211_chan_width *width, u32 *primary, u32 *cent=
er);
+int cl_chandef_get_default(struct cl_hw *cl_hw, enum nl80211_chan_width *w=
idth,
+                          u32 *primary, u32 *center);
+
+#endif /* CL_CHANDEF_H */
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

