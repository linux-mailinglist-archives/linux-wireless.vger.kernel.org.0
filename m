Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AD33AB8FB
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhFQQLn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:43 -0400
Received: from mail-vi1eur05on2070.outbound.protection.outlook.com ([40.107.21.70]:44832
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232409AbhFQQKY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXHu6ga++UixHDaa8HPALjcQ2s2fUrNAVPyBx1gXuhXxTJhbRjduFGxJbntqV9LszSILCE8iVkgg+Leo2Q5MEjB6CSelxu2Uq9Y1A+oG1HtOcOnoukBbNZNtKyHiXGD4SQL+8Hi2w1ou5xfjMGKHjdoGeL01DkGcAK8R1kZ6tOVnZdpl7X1O+SNj62GjQvEzcs24yURsDbxdpU0q40Onr/V594vpjfSbSf1A1uRvvy/rRaKljmeGR/12bJvNnmeTupVUZHmqVvihOCarsJJLR9MBJ5lywg8NUPhdqEc+kPuqOu/4iyyGCUal/MkBzU2CeG3EYyq2QutFId0oIv5UvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wlKRKAdnKD89wbNrDPAizfC2atXSF8LgyT/uOpRZk0=;
 b=NdyYofNfxPz39siPMRojEySLDrDtupCSCFcl9Sqv0+Omgrkv2LIkGqUZrOcKAY0jqbNFHAjqLEgkuNMkvQGLN2K0kBEbsfOzBW+QjOYHKIA1AyA1VH99sTQ0iSopAP53qWZ3b6lGigshCEsNkBJKdhNfGzH9DoYbj00U0HfW7qyJhGVhGAsN3RjKy06GXRm1j28HK35e5ryLUnN4dSx/uI4wbvduTgdjJqMSGlZ0+2pD25+Y4FL6pq/ewhqV9YZ9t4kGzVnWnXBPybHt6CQ+l5I9OU0hLQRrWnhgUbAGAa2mWbt1BUnTae9giM17GRlQas4p6Cdtzeb7QFSttH3+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wlKRKAdnKD89wbNrDPAizfC2atXSF8LgyT/uOpRZk0=;
 b=F/6sS1mG+TDblRx9mVvKn7nWARUr7IsBm7t5LLmIA9lfRUK0O1TzQiXhUvYzt3qTfMnSAvew/NH5QBynZwV9nbolUPilezcX9+AfDys6dH+YbKa1HWiqMKMIaw9qnZOJG8dAGklnHly2pdHLSNl599k+nenwX9KjrWU5JobGMk8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1314.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:45 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:45 +0000
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
Subject: [RFC v1 127/256] cl8k: add phy/phy_athos_lut.c
Date:   Thu, 17 Jun 2021 16:00:14 +0000
Message-Id: <20210617160223.160998-128-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d37a54d-7b2a-4656-4081-08d931a9a4ee
X-MS-TrafficTypeDiagnostic: AM9P192MB1314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB131455F06F1A5228A4C0F5EEF60E9@AM9P192MB1314.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IMF4loEOX+fw5Es8ta8U/1/v/x8Seco7W7Gp3Y5uJWWgEW498l3LwaYiiud+WRA44ebps8/U5x+iPc1MI+mDpSM2w9xOxB2zBf8bNxrL/0rSEM4lIz+5Y7EH9DfP+mOJcFL+P9L/az+lnjl6UCUZnVdZr/rVqeLrSquYm/eZShZaF49as2p1jQ0iiNOF/qsnRowaBonCrtqBv8sKOp+DNWpmNmkRfcgaji43Um5zo4yQfplxkmeLpPAiBGran16Wu4N9t+di5fuBNg7nvlZB0ATeVFXe7R06kytzL0QELS9a+kx0+NOlkaT25vf9SH9IvZqOmr2ZWFNQ/RmQ9i7iqfVdBXQzrtKGMMBXmCMviJ3W85WXYSexV4nOveawgtaASkznV0oOzbu+jw0U5MZscMg4iAazUhr3hBgchpk7aBL5tXm6gNMbpKgvmEE4HC5oKQtZ/NKRxNBA/Pvgc6TijOQquUYckbBpUQj/OqQ71T1O+nIwJrZ4G1CZwaW4SDWcedIXY32c+30K7mhHkkV4SVEJLhlJw7AkqFSjNg9gNUsc6KVLduRRBxboyUjJIuJC/aY1iyt82+ZdQB5N7agRUTNjT9vXx9KGQ/s130Zw6j2rukOP93Z3GY/MS1i2z75n3M9PxotRr/xcbbQNZWEgQsacDdP/0fbUxHvmglBxQ1LpEAqy5BaitbQpTQCiykRb8eurSZKY7Cv0PEuCw9fANg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:ro;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(39840400004)(366004)(376002)(136003)(346002)(8936002)(66946007)(83380400001)(186003)(5660300002)(26005)(36756003)(86362001)(8676002)(55236004)(1076003)(6916009)(2906002)(6506007)(66476007)(478600001)(6666004)(30864003)(38350700002)(52116002)(66556008)(956004)(4326008)(107886003)(54906003)(38100700002)(6486002)(2616005)(316002)(16526019)(6512007)(9686003)(69590400013)(32563001)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DA+gwj4WU+LE6taDpVSTHs/zVw5UifGB+qC6k2pbrA0ZyQV9em3kG7421H30?=
 =?us-ascii?Q?JpbudW6nMx4CHbivrpeD4hRxwh42Ihk51JT/zsXjNaHcuhIZxpuO99hUXrAn?=
 =?us-ascii?Q?re/0iZpGtMEZo1tlfhY3xRYum5meiJN9y9TA7afwOZcRr1YkMPIKvZrIkdAO?=
 =?us-ascii?Q?nPcXXC/QqzCJelp3QUFuZhhERxzUCFdoArimWsslUQ6/tHh+h83s0yAk7T4t?=
 =?us-ascii?Q?xEuqbdU/oueQG98rSEAbhc49maDvEU6/eNNu5LYV2Dt6Otp9OCidkY4h4eZJ?=
 =?us-ascii?Q?P9aoqodB0cBfCXifEL/uN4RmXafrqOLcYAR0CghN04+vunt9ymyS76bxQ9S2?=
 =?us-ascii?Q?q82dBBhcTDdx1Ux1dgxqID7b8Uo1CE0BW6yJQYQSRKuCP5/7QpaNsoYC4WWs?=
 =?us-ascii?Q?Ls6CXfjeevDmBoaQFaEj4yF+0TCPZJ+PIqzl08yN6ZaEG2vq92vHj0Lk5MRa?=
 =?us-ascii?Q?9pVlwdB510NjfIYegKxyRgvkaxWcE2IkTteHROaXeD+Z5OdpfXe72Rx6TmW2?=
 =?us-ascii?Q?hSC/6doHFsYnB8Xbs7cAcdBrCpxXFqnVYvpJ8SFzfCEUPmFWvDaKrCtYlhs1?=
 =?us-ascii?Q?FqAQ0up/wk7LU8qdHjr6szQlGn7bhyqJoFE+xx4o+mDJqYn4K2h3nAOXHm/j?=
 =?us-ascii?Q?4pu87goYH38tBh6H/PtVAgcAqOVcibyw2no9nynU5BYzW3pSJlhDW4bpQje4?=
 =?us-ascii?Q?wCIXx/zve0C/vgJKZF/fiZvEvA+HM9JUxEVyARSiBGWzwOsgx50Jxv9mET54?=
 =?us-ascii?Q?6ZOCMBjEzfH/fL1/oLlppzWbEXlJGXBYig7EYsnbE5KjIYg1Kkve0YVpgQFL?=
 =?us-ascii?Q?5aw8GeEdvrobgOVKz1dLmZjbXLJuj5PBG2bFzdLqGxasp+S6YDXQpIg5uGsO?=
 =?us-ascii?Q?lk9JpmDVyI2F+t9pg5c66N1Q6e1LTTUxn0YzQl4mtte0Wv13vhFoLiR09WR9?=
 =?us-ascii?Q?GgHDV3/+kx4HieJcBhpL0HDZTLC2vA+C9lvmjsK30oT45Pm/orufdUOrlOQT?=
 =?us-ascii?Q?khPbTjc8haLgKKKPFIj3iUWEyKGEDGKYi7ugjN4lPi9tg7W51Muo+jaQ/vy+?=
 =?us-ascii?Q?m+kxBRiEyiSqAL+13vZDMB3XmVxJx/ONp4Wclrscox7fTtduRUKpIJzbYW3a?=
 =?us-ascii?Q?eXoTj8gf26bpmzneYqcESrm0dkYJkFR7veHa3Og3+LjBRVilEl+UEyOOt+2T?=
 =?us-ascii?Q?I6GmthbCMayr7zpbi7T6XsKCDCOqrDqYQF9TIp8jrXWAAvjbwgHn0VziF8Fj?=
 =?us-ascii?Q?gjG+p3JKCENFC4Dybn2MdLLK+4mbNRMTnRm0O1Qw/EzufBh/YD2uw1qUxbZR?=
 =?us-ascii?Q?+uyYmd/VPc/aT48PMKdj169R?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d37a54d-7b2a-4656-4081-08d931a9a4ee
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:54.1722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ejt70PNtRfA6JEDiDAyud/nW759+PEGhaCUFwO6011QBqMc2iIFAhKNmz4OjKI4MNrt9kfcaCxWzq4RJAOjJdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1314
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../wireless/celeno/cl8k/phy/phy_athos_lut.c  | 2069 +++++++++++++++++
 1 file changed, 2069 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/phy/phy_athos_lut.c

diff --git a/drivers/net/wireless/celeno/cl8k/phy/phy_athos_lut.c b/drivers=
/net/wireless/celeno/cl8k/phy/phy_athos_lut.c
new file mode 100644
index 000000000000..5a42e55116c0
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/phy/phy_athos_lut.c
@@ -0,0 +1,2069 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "phy_athos_lut.h"
+
+const struct athos_lut_line athos_lut_6g_40_mhz[ATHOS_LUT_CHAN_6G_MAX] =3D=
 {
+       [ATHOS_LUT_CHAN_593000_IDX] =3D { 23720, 0x0, 0x62, 0x1AAAAB, 0x7B9=
 },
+       [ATHOS_LUT_CHAN_593125_IDX] =3D { 23725, 0x0, 0x62, 0x1B5555, 0x7B9=
 },
+       [ATHOS_LUT_CHAN_593250_IDX] =3D { 23730, 0x0, 0x62, 0x1C0000, 0x7BA=
 },
+       [ATHOS_LUT_CHAN_593375_IDX] =3D { 23735, 0x0, 0x62, 0x1CAAAB, 0x7BA=
 },
+       [ATHOS_LUT_CHAN_593500_IDX] =3D { 23740, 0x0, 0x62, 0x1D5555, 0x7BA=
 },
+       [ATHOS_LUT_CHAN_593625_IDX] =3D { 23745, 0x0, 0x62, 0x1E0000, 0x7BB=
 },
+       [ATHOS_LUT_CHAN_593750_IDX] =3D { 23750, 0x0, 0x62, 0x1EAAAB, 0x7BB=
 },
+       [ATHOS_LUT_CHAN_593875_IDX] =3D { 23755, 0x0, 0x62, 0x1F5555, 0x7BC=
 },
+       [ATHOS_LUT_CHAN_594000_IDX] =3D { 23760, 0x0, 0x63, 0x0, 0x7BC },
+       [ATHOS_LUT_CHAN_594125_IDX] =3D { 23765, 0x0, 0x63, 0xAAAB, 0x7BC }=
,
+       [ATHOS_LUT_CHAN_594250_IDX] =3D { 23770, 0x0, 0x63, 0x15555, 0x7BD =
},
+       [ATHOS_LUT_CHAN_594375_IDX] =3D { 23775, 0x0, 0x63, 0x20000, 0x7BD =
},
+       [ATHOS_LUT_CHAN_594500_IDX] =3D { 23780, 0x0, 0x63, 0x2AAAB, 0x7BE =
},
+       [ATHOS_LUT_CHAN_594625_IDX] =3D { 23785, 0x0, 0x63, 0x35555, 0x7BE =
},
+       [ATHOS_LUT_CHAN_594750_IDX] =3D { 23790, 0x0, 0x63, 0x40000, 0x7BF =
},
+       [ATHOS_LUT_CHAN_594875_IDX] =3D { 23795, 0x0, 0x63, 0x4AAAB, 0x7BF =
},
+       [ATHOS_LUT_CHAN_595000_IDX] =3D { 23800, 0x0, 0x63, 0x55555, 0x7BF =
},
+       [ATHOS_LUT_CHAN_595125_IDX] =3D { 23805, 0x0, 0x63, 0x60000, 0x7C0 =
},
+       [ATHOS_LUT_CHAN_595250_IDX] =3D { 23810, 0x0, 0x63, 0x6AAAB, 0x7C0 =
},
+       [ATHOS_LUT_CHAN_595375_IDX] =3D { 23815, 0x0, 0x63, 0x75555, 0x7C1 =
},
+       [ATHOS_LUT_CHAN_595500_IDX] =3D { 23820, 0x0, 0x63, 0x80000, 0x7C1 =
},
+       [ATHOS_LUT_CHAN_595625_IDX] =3D { 23825, 0x0, 0x63, 0x8AAAB, 0x7C1 =
},
+       [ATHOS_LUT_CHAN_595750_IDX] =3D { 23830, 0x0, 0x63, 0x95555, 0x7C2 =
},
+       [ATHOS_LUT_CHAN_595875_IDX] =3D { 23835, 0x0, 0x63, 0xA0000, 0x7C2 =
},
+       [ATHOS_LUT_CHAN_596000_IDX] =3D { 23840, 0x0, 0x63, 0xAAAAB, 0x7C3 =
},
+       [ATHOS_LUT_CHAN_596125_IDX] =3D { 23845, 0x0, 0x63, 0xB5555, 0x7C3 =
},
+       [ATHOS_LUT_CHAN_596250_IDX] =3D { 23850, 0x0, 0x63, 0xC0000, 0x7C4 =
},
+       [ATHOS_LUT_CHAN_596375_IDX] =3D { 23855, 0x0, 0x63, 0xCAAAB, 0x7C4 =
},
+       [ATHOS_LUT_CHAN_596500_IDX] =3D { 23860, 0x0, 0x63, 0xD5555, 0x7C4 =
},
+       [ATHOS_LUT_CHAN_596625_IDX] =3D { 23865, 0x0, 0x63, 0xE0000, 0x7C5 =
},
+       [ATHOS_LUT_CHAN_596750_IDX] =3D { 23870, 0x0, 0x63, 0xEAAAB, 0x7C5 =
},
+       [ATHOS_LUT_CHAN_596875_IDX] =3D { 23875, 0x0, 0x63, 0xF5555, 0x7C6 =
},
+       [ATHOS_LUT_CHAN_597000_IDX] =3D { 23880, 0x0, 0x63, 0x100000, 0x7C6=
 },
+       [ATHOS_LUT_CHAN_597125_IDX] =3D { 23885, 0x0, 0x63, 0x10AAAB, 0x7C6=
 },
+       [ATHOS_LUT_CHAN_597250_IDX] =3D { 23890, 0x0, 0x63, 0x115555, 0x7C7=
 },
+       [ATHOS_LUT_CHAN_597375_IDX] =3D { 23895, 0x0, 0x63, 0x120000, 0x7C7=
 },
+       [ATHOS_LUT_CHAN_597500_IDX] =3D { 23900, 0x0, 0x63, 0x12AAAB, 0x7C8=
 },
+       [ATHOS_LUT_CHAN_597625_IDX] =3D { 23905, 0x0, 0x63, 0x135555, 0x7C8=
 },
+       [ATHOS_LUT_CHAN_597750_IDX] =3D { 23910, 0x0, 0x63, 0x140000, 0x7C9=
 },
+       [ATHOS_LUT_CHAN_597875_IDX] =3D { 23915, 0x0, 0x63, 0x14AAAB, 0x7C9=
 },
+       [ATHOS_LUT_CHAN_598000_IDX] =3D { 23920, 0x0, 0x63, 0x155555, 0x7C9=
 },
+       [ATHOS_LUT_CHAN_598125_IDX] =3D { 23925, 0x0, 0x63, 0x160000, 0x7CA=
 },
+       [ATHOS_LUT_CHAN_598250_IDX] =3D { 23930, 0x0, 0x63, 0x16AAAB, 0x7CA=
 },
+       [ATHOS_LUT_CHAN_598375_IDX] =3D { 23935, 0x0, 0x63, 0x175555, 0x7CB=
 },
+       [ATHOS_LUT_CHAN_598500_IDX] =3D { 23940, 0x0, 0x63, 0x180000, 0x7CB=
 },
+       [ATHOS_LUT_CHAN_598625_IDX] =3D { 23945, 0x0, 0x63, 0x18AAAB, 0x7CB=
 },
+       [ATHOS_LUT_CHAN_598750_IDX] =3D { 23950, 0x0, 0x63, 0x195555, 0x7CC=
 },
+       [ATHOS_LUT_CHAN_598875_IDX] =3D { 23955, 0x0, 0x63, 0x1A0000, 0x7CC=
 },
+       [ATHOS_LUT_CHAN_599000_IDX] =3D { 23960, 0x0, 0x63, 0x1AAAAB, 0x7CD=
 },
+       [ATHOS_LUT_CHAN_599125_IDX] =3D { 23965, 0x0, 0x63, 0x1B5555, 0x7CD=
 },
+       [ATHOS_LUT_CHAN_599250_IDX] =3D { 23970, 0x0, 0x63, 0x1C0000, 0x7CE=
 },
+       [ATHOS_LUT_CHAN_599375_IDX] =3D { 23975, 0x0, 0x63, 0x1CAAAB, 0x7CE=
 },
+       [ATHOS_LUT_CHAN_599500_IDX] =3D { 23980, 0x0, 0x63, 0x1D5555, 0x7CE=
 },
+       [ATHOS_LUT_CHAN_599625_IDX] =3D { 23985, 0x0, 0x63, 0x1E0000, 0x7CF=
 },
+       [ATHOS_LUT_CHAN_599750_IDX] =3D { 23990, 0x0, 0x63, 0x1EAAAB, 0x7CF=
 },
+       [ATHOS_LUT_CHAN_599875_IDX] =3D { 23995, 0x0, 0x63, 0x1F5555, 0x7D0=
 },
+       [ATHOS_LUT_CHAN_600000_IDX] =3D { 24000, 0x0, 0x64, 0x0, 0x7D0 },
+       [ATHOS_LUT_CHAN_600125_IDX] =3D { 24005, 0x0, 0x64, 0xAAAB, 0x7D0 }=
,
+       [ATHOS_LUT_CHAN_600250_IDX] =3D { 24010, 0x0, 0x64, 0x15555, 0x7D1 =
},
+       [ATHOS_LUT_CHAN_600375_IDX] =3D { 24015, 0x0, 0x64, 0x20000, 0x7D1 =
},
+       [ATHOS_LUT_CHAN_600500_IDX] =3D { 24020, 0x0, 0x64, 0x2AAAB, 0x7D2 =
},
+       [ATHOS_LUT_CHAN_600625_IDX] =3D { 24025, 0x0, 0x64, 0x35555, 0x7D2 =
},
+       [ATHOS_LUT_CHAN_600750_IDX] =3D { 24030, 0x0, 0x64, 0x40000, 0x7D3 =
},
+       [ATHOS_LUT_CHAN_600875_IDX] =3D { 24035, 0x0, 0x64, 0x4AAAB, 0x7D3 =
},
+       [ATHOS_LUT_CHAN_601000_IDX] =3D { 24040, 0x0, 0x64, 0x55555, 0x7D3 =
},
+       [ATHOS_LUT_CHAN_601125_IDX] =3D { 24045, 0x0, 0x64, 0x60000, 0x7D4 =
},
+       [ATHOS_LUT_CHAN_601250_IDX] =3D { 24050, 0x0, 0x64, 0x6AAAB, 0x7D4 =
},
+       [ATHOS_LUT_CHAN_601375_IDX] =3D { 24055, 0x0, 0x64, 0x75555, 0x7D5 =
},
+       [ATHOS_LUT_CHAN_601500_IDX] =3D { 24060, 0x0, 0x64, 0x80000, 0x7D5 =
},
+       [ATHOS_LUT_CHAN_601625_IDX] =3D { 24065, 0x0, 0x64, 0x8AAAB, 0x7D5 =
},
+       [ATHOS_LUT_CHAN_601750_IDX] =3D { 24070, 0x0, 0x64, 0x95555, 0x7D6 =
},
+       [ATHOS_LUT_CHAN_601875_IDX] =3D { 24075, 0x0, 0x64, 0xA0000, 0x7D6 =
},
+       [ATHOS_LUT_CHAN_602000_IDX] =3D { 24080, 0x0, 0x64, 0xAAAAB, 0x7D7 =
},
+       [ATHOS_LUT_CHAN_602125_IDX] =3D { 24085, 0x0, 0x64, 0xB5555, 0x7D7 =
},
+       [ATHOS_LUT_CHAN_602250_IDX] =3D { 24090, 0x0, 0x64, 0xC0000, 0x7D8 =
},
+       [ATHOS_LUT_CHAN_602375_IDX] =3D { 24095, 0x0, 0x64, 0xCAAAB, 0x7D8 =
},
+       [ATHOS_LUT_CHAN_602500_IDX] =3D { 24100, 0x0, 0x64, 0xD5555, 0x7D8 =
},
+       [ATHOS_LUT_CHAN_602625_IDX] =3D { 24105, 0x0, 0x64, 0xE0000, 0x7D9 =
},
+       [ATHOS_LUT_CHAN_602750_IDX] =3D { 24110, 0x0, 0x64, 0xEAAAB, 0x7D9 =
},
+       [ATHOS_LUT_CHAN_602875_IDX] =3D { 24115, 0x0, 0x64, 0xF5555, 0x7DA =
},
+       [ATHOS_LUT_CHAN_603000_IDX] =3D { 24120, 0x0, 0x64, 0x100000, 0x7DA=
 },
+       [ATHOS_LUT_CHAN_603125_IDX] =3D { 24125, 0x0, 0x64, 0x10AAAB, 0x7DA=
 },
+       [ATHOS_LUT_CHAN_603250_IDX] =3D { 24130, 0x0, 0x64, 0x115555, 0x7DB=
 },
+       [ATHOS_LUT_CHAN_603375_IDX] =3D { 24135, 0x0, 0x64, 0x120000, 0x7DB=
 },
+       [ATHOS_LUT_CHAN_603500_IDX] =3D { 24140, 0x0, 0x64, 0x12AAAB, 0x7DC=
 },
+       [ATHOS_LUT_CHAN_603625_IDX] =3D { 24145, 0x0, 0x64, 0x135555, 0x7DC=
 },
+       [ATHOS_LUT_CHAN_603750_IDX] =3D { 24150, 0x0, 0x64, 0x140000, 0x7DD=
 },
+       [ATHOS_LUT_CHAN_603875_IDX] =3D { 24155, 0x0, 0x64, 0x14AAAB, 0x7DD=
 },
+       [ATHOS_LUT_CHAN_604000_IDX] =3D { 24160, 0x0, 0x64, 0x155555, 0x7DD=
 },
+       [ATHOS_LUT_CHAN_604125_IDX] =3D { 24165, 0x0, 0x64, 0x160000, 0x7DE=
 },
+       [ATHOS_LUT_CHAN_604250_IDX] =3D { 24170, 0x0, 0x64, 0x16AAAB, 0x7DE=
 },
+       [ATHOS_LUT_CHAN_604375_IDX] =3D { 24175, 0x0, 0x64, 0x175555, 0x7DF=
 },
+       [ATHOS_LUT_CHAN_604500_IDX] =3D { 24180, 0x0, 0x64, 0x180000, 0x7DF=
 },
+       [ATHOS_LUT_CHAN_604625_IDX] =3D { 24185, 0x0, 0x64, 0x18AAAB, 0x7DF=
 },
+       [ATHOS_LUT_CHAN_604750_IDX] =3D { 24190, 0x0, 0x64, 0x195555, 0x7E0=
 },
+       [ATHOS_LUT_CHAN_604875_IDX] =3D { 24195, 0x0, 0x64, 0x1A0000, 0x7E0=
 },
+       [ATHOS_LUT_CHAN_605000_IDX] =3D { 24200, 0x0, 0x64, 0x1AAAAB, 0x7E1=
 },
+       [ATHOS_LUT_CHAN_605125_IDX] =3D { 24205, 0x0, 0x64, 0x1B5555, 0x7E1=
 },
+       [ATHOS_LUT_CHAN_605250_IDX] =3D { 24210, 0x0, 0x64, 0x1C0000, 0x7E2=
 },
+       [ATHOS_LUT_CHAN_605375_IDX] =3D { 24215, 0x0, 0x64, 0x1CAAAB, 0x7E2=
 },
+       [ATHOS_LUT_CHAN_605500_IDX] =3D { 24220, 0x0, 0x64, 0x1D5555, 0x7E2=
 },
+       [ATHOS_LUT_CHAN_605625_IDX] =3D { 24225, 0x0, 0x64, 0x1E0000, 0x7E3=
 },
+       [ATHOS_LUT_CHAN_605750_IDX] =3D { 24230, 0x0, 0x64, 0x1EAAAB, 0x7E3=
 },
+       [ATHOS_LUT_CHAN_605875_IDX] =3D { 24235, 0x0, 0x64, 0x1F5555, 0x7E4=
 },
+       [ATHOS_LUT_CHAN_606000_IDX] =3D { 24240, 0x0, 0x65, 0x0, 0x7E4 },
+       [ATHOS_LUT_CHAN_606125_IDX] =3D { 24245, 0x0, 0x65, 0xAAAB, 0x7E4 }=
,
+       [ATHOS_LUT_CHAN_606250_IDX] =3D { 24250, 0x0, 0x65, 0x15555, 0x7E5 =
},
+       [ATHOS_LUT_CHAN_606375_IDX] =3D { 24255, 0x0, 0x65, 0x20000, 0x7E5 =
},
+       [ATHOS_LUT_CHAN_606500_IDX] =3D { 24260, 0x0, 0x65, 0x2AAAB, 0x7E6 =
},
+       [ATHOS_LUT_CHAN_606625_IDX] =3D { 24265, 0x0, 0x65, 0x35555, 0x7E6 =
},
+       [ATHOS_LUT_CHAN_606750_IDX] =3D { 24270, 0x0, 0x65, 0x40000, 0x7E7 =
},
+       [ATHOS_LUT_CHAN_606875_IDX] =3D { 24275, 0x0, 0x65, 0x4AAAB, 0x7E7 =
},
+       [ATHOS_LUT_CHAN_607000_IDX] =3D { 24280, 0x0, 0x65, 0x55555, 0x7E7 =
},
+       [ATHOS_LUT_CHAN_607125_IDX] =3D { 24285, 0x0, 0x65, 0x60000, 0x7E8 =
},
+       [ATHOS_LUT_CHAN_607250_IDX] =3D { 24290, 0x0, 0x65, 0x6AAAB, 0x7E8 =
},
+       [ATHOS_LUT_CHAN_607375_IDX] =3D { 24295, 0x0, 0x65, 0x75555, 0x7E9 =
},
+       [ATHOS_LUT_CHAN_607500_IDX] =3D { 24300, 0x0, 0x65, 0x80000, 0x7E9 =
},
+       [ATHOS_LUT_CHAN_607625_IDX] =3D { 24305, 0x0, 0x65, 0x8AAAB, 0x7E9 =
},
+       [ATHOS_LUT_CHAN_607750_IDX] =3D { 24310, 0x0, 0x65, 0x95555, 0x7EA =
},
+       [ATHOS_LUT_CHAN_607875_IDX] =3D { 24315, 0x0, 0x65, 0xA0000, 0x7EA =
},
+       [ATHOS_LUT_CHAN_608000_IDX] =3D { 24320, 0x0, 0x65, 0xAAAAB, 0x7EB =
},
+       [ATHOS_LUT_CHAN_608125_IDX] =3D { 24325, 0x0, 0x65, 0xB5555, 0x7EB =
},
+       [ATHOS_LUT_CHAN_608250_IDX] =3D { 24330, 0x0, 0x65, 0xC0000, 0x7EC =
},
+       [ATHOS_LUT_CHAN_608375_IDX] =3D { 24335, 0x0, 0x65, 0xCAAAB, 0x7EC =
},
+       [ATHOS_LUT_CHAN_608500_IDX] =3D { 24340, 0x0, 0x65, 0xD5555, 0x7EC =
},
+       [ATHOS_LUT_CHAN_608625_IDX] =3D { 24345, 0x0, 0x65, 0xE0000, 0x7ED =
},
+       [ATHOS_LUT_CHAN_608750_IDX] =3D { 24350, 0x0, 0x65, 0xEAAAB, 0x7ED =
},
+       [ATHOS_LUT_CHAN_608875_IDX] =3D { 24355, 0x0, 0x65, 0xF5555, 0x7EE =
},
+       [ATHOS_LUT_CHAN_609000_IDX] =3D { 24360, 0x0, 0x65, 0x100000, 0x7EE=
 },
+       [ATHOS_LUT_CHAN_609125_IDX] =3D { 24365, 0x0, 0x65, 0x10AAAB, 0x7EE=
 },
+       [ATHOS_LUT_CHAN_609250_IDX] =3D { 24370, 0x0, 0x65, 0x115555, 0x7EF=
 },
+       [ATHOS_LUT_CHAN_609375_IDX] =3D { 24375, 0x0, 0x65, 0x120000, 0x7EF=
 },
+       [ATHOS_LUT_CHAN_609500_IDX] =3D { 24380, 0x0, 0x65, 0x12AAAB, 0x7F0=
 },
+       [ATHOS_LUT_CHAN_609625_IDX] =3D { 24385, 0x0, 0x65, 0x135555, 0x7F0=
 },
+       [ATHOS_LUT_CHAN_609750_IDX] =3D { 24390, 0x0, 0x65, 0x140000, 0x7F1=
 },
+       [ATHOS_LUT_CHAN_609875_IDX] =3D { 24395, 0x0, 0x65, 0x14AAAB, 0x7F1=
 },
+       [ATHOS_LUT_CHAN_610000_IDX] =3D { 24400, 0x1, 0x65, 0x155555, 0x7F1=
 },
+       [ATHOS_LUT_CHAN_610125_IDX] =3D { 24405, 0x1, 0x65, 0x160000, 0x7F2=
 },
+       [ATHOS_LUT_CHAN_610250_IDX] =3D { 24410, 0x1, 0x65, 0x16AAAB, 0x7F2=
 },
+       [ATHOS_LUT_CHAN_610375_IDX] =3D { 24415, 0x1, 0x65, 0x175555, 0x7F3=
 },
+       [ATHOS_LUT_CHAN_610500_IDX] =3D { 24420, 0x1, 0x65, 0x180000, 0x7F3=
 },
+       [ATHOS_LUT_CHAN_610625_IDX] =3D { 24425, 0x1, 0x65, 0x18AAAB, 0x7F3=
 },
+       [ATHOS_LUT_CHAN_610750_IDX] =3D { 24430, 0x1, 0x65, 0x195555, 0x7F4=
 },
+       [ATHOS_LUT_CHAN_610875_IDX] =3D { 24435, 0x1, 0x65, 0x1A0000, 0x7F4=
 },
+       [ATHOS_LUT_CHAN_611000_IDX] =3D { 24440, 0x1, 0x65, 0x1AAAAB, 0x7F5=
 },
+       [ATHOS_LUT_CHAN_611125_IDX] =3D { 24445, 0x1, 0x65, 0x1B5555, 0x7F5=
 },
+       [ATHOS_LUT_CHAN_611250_IDX] =3D { 24450, 0x1, 0x65, 0x1C0000, 0x7F6=
 },
+       [ATHOS_LUT_CHAN_611375_IDX] =3D { 24455, 0x1, 0x65, 0x1CAAAB, 0x7F6=
 },
+       [ATHOS_LUT_CHAN_611500_IDX] =3D { 24460, 0x1, 0x65, 0x1D5555, 0x7F6=
 },
+       [ATHOS_LUT_CHAN_611625_IDX] =3D { 24465, 0x1, 0x65, 0x1E0000, 0x7F7=
 },
+       [ATHOS_LUT_CHAN_611750_IDX] =3D { 24470, 0x1, 0x65, 0x1EAAAB, 0x7F7=
 },
+       [ATHOS_LUT_CHAN_611875_IDX] =3D { 24475, 0x1, 0x65, 0x1F5555, 0x7F8=
 },
+       [ATHOS_LUT_CHAN_612000_IDX] =3D { 24480, 0x1, 0x66, 0x0, 0x7F8 },
+       [ATHOS_LUT_CHAN_612125_IDX] =3D { 24485, 0x1, 0x66, 0xAAAB, 0x7F8 }=
,
+       [ATHOS_LUT_CHAN_612250_IDX] =3D { 24490, 0x1, 0x66, 0x15555, 0x7F9 =
},
+       [ATHOS_LUT_CHAN_612375_IDX] =3D { 24495, 0x1, 0x66, 0x20000, 0x7F9 =
},
+       [ATHOS_LUT_CHAN_612500_IDX] =3D { 24500, 0x1, 0x66, 0x2AAAB, 0x7FA =
},
+       [ATHOS_LUT_CHAN_612625_IDX] =3D { 24505, 0x1, 0x66, 0x35555, 0x7FA =
},
+       [ATHOS_LUT_CHAN_612750_IDX] =3D { 24510, 0x1, 0x66, 0x40000, 0x7FB =
},
+       [ATHOS_LUT_CHAN_612875_IDX] =3D { 24515, 0x1, 0x66, 0x4AAAB, 0x7FB =
},
+       [ATHOS_LUT_CHAN_613000_IDX] =3D { 24520, 0x1, 0x66, 0x55555, 0x7FB =
},
+       [ATHOS_LUT_CHAN_613125_IDX] =3D { 24525, 0x1, 0x66, 0x60000, 0x7FC =
},
+       [ATHOS_LUT_CHAN_613250_IDX] =3D { 24530, 0x1, 0x66, 0x6AAAB, 0x7FC =
},
+       [ATHOS_LUT_CHAN_613375_IDX] =3D { 24535, 0x1, 0x66, 0x75555, 0x7FD =
},
+       [ATHOS_LUT_CHAN_613500_IDX] =3D { 24540, 0x1, 0x66, 0x80000, 0x7FD =
},
+       [ATHOS_LUT_CHAN_613625_IDX] =3D { 24545, 0x1, 0x66, 0x8AAAB, 0x7FD =
},
+       [ATHOS_LUT_CHAN_613750_IDX] =3D { 24550, 0x1, 0x66, 0x95555, 0x7FE =
},
+       [ATHOS_LUT_CHAN_613875_IDX] =3D { 24555, 0x1, 0x66, 0xA0000, 0x7FE =
},
+       [ATHOS_LUT_CHAN_614000_IDX] =3D { 24560, 0x1, 0x66, 0xAAAAB, 0x7FF =
},
+       [ATHOS_LUT_CHAN_614125_IDX] =3D { 24565, 0x1, 0x66, 0xB5555, 0x7FF =
},
+       [ATHOS_LUT_CHAN_614250_IDX] =3D { 24570, 0x1, 0x66, 0xC0000, 0x800 =
},
+       [ATHOS_LUT_CHAN_614375_IDX] =3D { 24575, 0x1, 0x66, 0xCAAAB, 0x800 =
},
+       [ATHOS_LUT_CHAN_614500_IDX] =3D { 24580, 0x1, 0x66, 0xD5555, 0x800 =
},
+       [ATHOS_LUT_CHAN_614625_IDX] =3D { 24585, 0x1, 0x66, 0xE0000, 0x801 =
},
+       [ATHOS_LUT_CHAN_614750_IDX] =3D { 24590, 0x1, 0x66, 0xEAAAB, 0x801 =
},
+       [ATHOS_LUT_CHAN_614875_IDX] =3D { 24595, 0x1, 0x66, 0xF5555, 0x802 =
},
+       [ATHOS_LUT_CHAN_615000_IDX] =3D { 24600, 0x1, 0x66, 0x100000, 0x802=
 },
+       [ATHOS_LUT_CHAN_615125_IDX] =3D { 24605, 0x1, 0x66, 0x10AAAB, 0x802=
 },
+       [ATHOS_LUT_CHAN_615250_IDX] =3D { 24610, 0x1, 0x66, 0x115555, 0x803=
 },
+       [ATHOS_LUT_CHAN_615375_IDX] =3D { 24615, 0x1, 0x66, 0x120000, 0x803=
 },
+       [ATHOS_LUT_CHAN_615500_IDX] =3D { 24620, 0x1, 0x66, 0x12AAAB, 0x804=
 },
+       [ATHOS_LUT_CHAN_615625_IDX] =3D { 24625, 0x1, 0x66, 0x135555, 0x804=
 },
+       [ATHOS_LUT_CHAN_615750_IDX] =3D { 24630, 0x1, 0x66, 0x140000, 0x805=
 },
+       [ATHOS_LUT_CHAN_615875_IDX] =3D { 24635, 0x1, 0x66, 0x14AAAB, 0x805=
 },
+       [ATHOS_LUT_CHAN_616000_IDX] =3D { 24640, 0x1, 0x66, 0x155555, 0x805=
 },
+       [ATHOS_LUT_CHAN_616125_IDX] =3D { 24645, 0x1, 0x66, 0x160000, 0x806=
 },
+       [ATHOS_LUT_CHAN_616250_IDX] =3D { 24650, 0x1, 0x66, 0x16AAAB, 0x806=
 },
+       [ATHOS_LUT_CHAN_616375_IDX] =3D { 24655, 0x1, 0x66, 0x175555, 0x807=
 },
+       [ATHOS_LUT_CHAN_616500_IDX] =3D { 24660, 0x1, 0x66, 0x180000, 0x807=
 },
+       [ATHOS_LUT_CHAN_616625_IDX] =3D { 24665, 0x1, 0x66, 0x18AAAB, 0x807=
 },
+       [ATHOS_LUT_CHAN_616750_IDX] =3D { 24670, 0x1, 0x66, 0x195555, 0x808=
 },
+       [ATHOS_LUT_CHAN_616875_IDX] =3D { 24675, 0x1, 0x66, 0x1A0000, 0x808=
 },
+       [ATHOS_LUT_CHAN_617000_IDX] =3D { 24680, 0x1, 0x66, 0x1AAAAB, 0x809=
 },
+       [ATHOS_LUT_CHAN_617125_IDX] =3D { 24685, 0x1, 0x66, 0x1B5555, 0x809=
 },
+       [ATHOS_LUT_CHAN_617250_IDX] =3D { 24690, 0x1, 0x66, 0x1C0000, 0x80A=
 },
+       [ATHOS_LUT_CHAN_617375_IDX] =3D { 24695, 0x1, 0x66, 0x1CAAAB, 0x80A=
 },
+       [ATHOS_LUT_CHAN_617500_IDX] =3D { 24700, 0x1, 0x66, 0x1D5555, 0x80A=
 },
+       [ATHOS_LUT_CHAN_617625_IDX] =3D { 24705, 0x1, 0x66, 0x1E0000, 0x80B=
 },
+       [ATHOS_LUT_CHAN_617750_IDX] =3D { 24710, 0x1, 0x66, 0x1EAAAB, 0x80B=
 },
+       [ATHOS_LUT_CHAN_617875_IDX] =3D { 24715, 0x1, 0x66, 0x1F5555, 0x80C=
 },
+       [ATHOS_LUT_CHAN_618000_IDX] =3D { 24720, 0x1, 0x67, 0x0, 0x80C },
+       [ATHOS_LUT_CHAN_618125_IDX] =3D { 24725, 0x1, 0x67, 0xAAAB, 0x80C }=
,
+       [ATHOS_LUT_CHAN_618250_IDX] =3D { 24730, 0x1, 0x67, 0x15555, 0x80D =
},
+       [ATHOS_LUT_CHAN_618375_IDX] =3D { 24735, 0x1, 0x67, 0x20000, 0x80D =
},
+       [ATHOS_LUT_CHAN_618500_IDX] =3D { 24740, 0x1, 0x67, 0x2AAAB, 0x80E =
},
+       [ATHOS_LUT_CHAN_618625_IDX] =3D { 24745, 0x1, 0x67, 0x35555, 0x80E =
},
+       [ATHOS_LUT_CHAN_618750_IDX] =3D { 24750, 0x1, 0x67, 0x40000, 0x80F =
},
+       [ATHOS_LUT_CHAN_618875_IDX] =3D { 24755, 0x1, 0x67, 0x4AAAB, 0x80F =
},
+       [ATHOS_LUT_CHAN_619000_IDX] =3D { 24760, 0x1, 0x67, 0x55555, 0x80F =
},
+       [ATHOS_LUT_CHAN_619125_IDX] =3D { 24765, 0x1, 0x67, 0x60000, 0x810 =
},
+       [ATHOS_LUT_CHAN_619250_IDX] =3D { 24770, 0x1, 0x67, 0x6AAAB, 0x810 =
},
+       [ATHOS_LUT_CHAN_619375_IDX] =3D { 24775, 0x1, 0x67, 0x75555, 0x811 =
},
+       [ATHOS_LUT_CHAN_619500_IDX] =3D { 24780, 0x1, 0x67, 0x80000, 0x811 =
},
+       [ATHOS_LUT_CHAN_619625_IDX] =3D { 24785, 0x1, 0x67, 0x8AAAB, 0x811 =
},
+       [ATHOS_LUT_CHAN_619750_IDX] =3D { 24790, 0x1, 0x67, 0x95555, 0x812 =
},
+       [ATHOS_LUT_CHAN_619875_IDX] =3D { 24795, 0x1, 0x67, 0xA0000, 0x812 =
},
+       [ATHOS_LUT_CHAN_620000_IDX] =3D { 24800, 0x1, 0x67, 0xAAAAB, 0x813 =
},
+       [ATHOS_LUT_CHAN_620125_IDX] =3D { 24805, 0x1, 0x67, 0xB5555, 0x813 =
},
+       [ATHOS_LUT_CHAN_620250_IDX] =3D { 24810, 0x1, 0x67, 0xC0000, 0x814 =
},
+       [ATHOS_LUT_CHAN_620375_IDX] =3D { 24815, 0x1, 0x67, 0xCAAAB, 0x814 =
},
+       [ATHOS_LUT_CHAN_620500_IDX] =3D { 24820, 0x1, 0x67, 0xD5555, 0x814 =
},
+       [ATHOS_LUT_CHAN_620625_IDX] =3D { 24825, 0x1, 0x67, 0xE0000, 0x815 =
},
+       [ATHOS_LUT_CHAN_620750_IDX] =3D { 24830, 0x1, 0x67, 0xEAAAB, 0x815 =
},
+       [ATHOS_LUT_CHAN_620875_IDX] =3D { 24835, 0x1, 0x67, 0xF5555, 0x816 =
},
+       [ATHOS_LUT_CHAN_621000_IDX] =3D { 24840, 0x1, 0x67, 0x100000, 0x816=
 },
+       [ATHOS_LUT_CHAN_621125_IDX] =3D { 24845, 0x1, 0x67, 0x10AAAB, 0x816=
 },
+       [ATHOS_LUT_CHAN_621250_IDX] =3D { 24850, 0x1, 0x67, 0x115555, 0x817=
 },
+       [ATHOS_LUT_CHAN_621375_IDX] =3D { 24855, 0x1, 0x67, 0x120000, 0x817=
 },
+       [ATHOS_LUT_CHAN_621500_IDX] =3D { 24860, 0x1, 0x67, 0x12AAAB, 0x818=
 },
+       [ATHOS_LUT_CHAN_621625_IDX] =3D { 24865, 0x1, 0x67, 0x135555, 0x818=
 },
+       [ATHOS_LUT_CHAN_621750_IDX] =3D { 24870, 0x1, 0x67, 0x140000, 0x819=
 },
+       [ATHOS_LUT_CHAN_621875_IDX] =3D { 24875, 0x1, 0x67, 0x14AAAB, 0x819=
 },
+       [ATHOS_LUT_CHAN_622000_IDX] =3D { 24880, 0x1, 0x67, 0x155555, 0x819=
 },
+       [ATHOS_LUT_CHAN_622125_IDX] =3D { 24885, 0x1, 0x67, 0x160000, 0x81A=
 },
+       [ATHOS_LUT_CHAN_622250_IDX] =3D { 24890, 0x1, 0x67, 0x16AAAB, 0x81A=
 },
+       [ATHOS_LUT_CHAN_622375_IDX] =3D { 24895, 0x1, 0x67, 0x175555, 0x81B=
 },
+       [ATHOS_LUT_CHAN_622500_IDX] =3D { 24900, 0x1, 0x67, 0x180000, 0x81B=
 },
+       [ATHOS_LUT_CHAN_622625_IDX] =3D { 24905, 0x1, 0x67, 0x18AAAB, 0x81B=
 },
+       [ATHOS_LUT_CHAN_622750_IDX] =3D { 24910, 0x1, 0x67, 0x195555, 0x81C=
 },
+       [ATHOS_LUT_CHAN_622875_IDX] =3D { 24915, 0x1, 0x67, 0x1A0000, 0x81C=
 },
+       [ATHOS_LUT_CHAN_623000_IDX] =3D { 24920, 0x1, 0x67, 0x1AAAAB, 0x81D=
 },
+       [ATHOS_LUT_CHAN_623125_IDX] =3D { 24925, 0x1, 0x67, 0x1B5555, 0x81D=
 },
+       [ATHOS_LUT_CHAN_623250_IDX] =3D { 24930, 0x1, 0x67, 0x1C0000, 0x81E=
 },
+       [ATHOS_LUT_CHAN_623375_IDX] =3D { 24935, 0x1, 0x67, 0x1CAAAB, 0x81E=
 },
+       [ATHOS_LUT_CHAN_623500_IDX] =3D { 24940, 0x1, 0x67, 0x1D5555, 0x81E=
 },
+       [ATHOS_LUT_CHAN_623625_IDX] =3D { 24945, 0x1, 0x67, 0x1E0000, 0x81F=
 },
+       [ATHOS_LUT_CHAN_623750_IDX] =3D { 24950, 0x1, 0x67, 0x1EAAAB, 0x81F=
 },
+       [ATHOS_LUT_CHAN_623875_IDX] =3D { 24955, 0x1, 0x67, 0x1F5555, 0x820=
 },
+       [ATHOS_LUT_CHAN_624000_IDX] =3D { 24960, 0x1, 0x68, 0x0, 0x820 },
+       [ATHOS_LUT_CHAN_624125_IDX] =3D { 24965, 0x1, 0x68, 0xAAAB, 0x820 }=
,
+       [ATHOS_LUT_CHAN_624250_IDX] =3D { 24970, 0x1, 0x68, 0x15555, 0x821 =
},
+       [ATHOS_LUT_CHAN_624375_IDX] =3D { 24975, 0x1, 0x68, 0x20000, 0x821 =
},
+       [ATHOS_LUT_CHAN_624500_IDX] =3D { 24980, 0x1, 0x68, 0x2AAAB, 0x822 =
},
+       [ATHOS_LUT_CHAN_624625_IDX] =3D { 24985, 0x1, 0x68, 0x35555, 0x822 =
},
+       [ATHOS_LUT_CHAN_624750_IDX] =3D { 24990, 0x1, 0x68, 0x40000, 0x823 =
},
+       [ATHOS_LUT_CHAN_624875_IDX] =3D { 24995, 0x1, 0x68, 0x4AAAB, 0x823 =
},
+       [ATHOS_LUT_CHAN_625000_IDX] =3D { 25000, 0x1, 0x68, 0x55555, 0x823 =
},
+       [ATHOS_LUT_CHAN_625125_IDX] =3D { 25005, 0x1, 0x68, 0x60000, 0x824 =
},
+       [ATHOS_LUT_CHAN_625250_IDX] =3D { 25010, 0x1, 0x68, 0x6AAAB, 0x824 =
},
+       [ATHOS_LUT_CHAN_625375_IDX] =3D { 25015, 0x1, 0x68, 0x75555, 0x825 =
},
+       [ATHOS_LUT_CHAN_625500_IDX] =3D { 25020, 0x1, 0x68, 0x80000, 0x825 =
},
+       [ATHOS_LUT_CHAN_625625_IDX] =3D { 25025, 0x1, 0x68, 0x8AAAB, 0x825 =
},
+       [ATHOS_LUT_CHAN_625750_IDX] =3D { 25030, 0x1, 0x68, 0x95555, 0x826 =
},
+       [ATHOS_LUT_CHAN_625875_IDX] =3D { 25035, 0x1, 0x68, 0xA0000, 0x826 =
},
+       [ATHOS_LUT_CHAN_626000_IDX] =3D { 25040, 0x1, 0x68, 0xAAAAB, 0x827 =
},
+       [ATHOS_LUT_CHAN_626125_IDX] =3D { 25045, 0x1, 0x68, 0xB5555, 0x827 =
},
+       [ATHOS_LUT_CHAN_626250_IDX] =3D { 25050, 0x1, 0x68, 0xC0000, 0x828 =
},
+       [ATHOS_LUT_CHAN_626375_IDX] =3D { 25055, 0x1, 0x68, 0xCAAAB, 0x828 =
},
+       [ATHOS_LUT_CHAN_626500_IDX] =3D { 25060, 0x1, 0x68, 0xD5555, 0x828 =
},
+       [ATHOS_LUT_CHAN_626625_IDX] =3D { 25065, 0x1, 0x68, 0xE0000, 0x829 =
},
+       [ATHOS_LUT_CHAN_626750_IDX] =3D { 25070, 0x1, 0x68, 0xEAAAB, 0x829 =
},
+       [ATHOS_LUT_CHAN_626875_IDX] =3D { 25075, 0x1, 0x68, 0xF5555, 0x82A =
},
+       [ATHOS_LUT_CHAN_627000_IDX] =3D { 25080, 0x1, 0x68, 0x100000, 0x82A=
 },
+       [ATHOS_LUT_CHAN_627125_IDX] =3D { 25085, 0x1, 0x68, 0x10AAAB, 0x82A=
 },
+       [ATHOS_LUT_CHAN_627250_IDX] =3D { 25090, 0x1, 0x68, 0x115555, 0x82B=
 },
+       [ATHOS_LUT_CHAN_627375_IDX] =3D { 25095, 0x1, 0x68, 0x120000, 0x82B=
 },
+       [ATHOS_LUT_CHAN_627500_IDX] =3D { 25100, 0x1, 0x68, 0x12AAAB, 0x82C=
 },
+       [ATHOS_LUT_CHAN_627625_IDX] =3D { 25105, 0x1, 0x68, 0x135555, 0x82C=
 },
+       [ATHOS_LUT_CHAN_627750_IDX] =3D { 25110, 0x1, 0x68, 0x140000, 0x82D=
 },
+       [ATHOS_LUT_CHAN_627875_IDX] =3D { 25115, 0x1, 0x68, 0x14AAAB, 0x82D=
 },
+       [ATHOS_LUT_CHAN_628000_IDX] =3D { 25120, 0x1, 0x68, 0x155555, 0x82D=
 },
+       [ATHOS_LUT_CHAN_628125_IDX] =3D { 25125, 0x1, 0x68, 0x160000, 0x82E=
 },
+       [ATHOS_LUT_CHAN_628250_IDX] =3D { 25130, 0x1, 0x68, 0x16AAAB, 0x82E=
 },
+       [ATHOS_LUT_CHAN_628375_IDX] =3D { 25135, 0x1, 0x68, 0x175555, 0x82F=
 },
+       [ATHOS_LUT_CHAN_628500_IDX] =3D { 25140, 0x1, 0x68, 0x180000, 0x82F=
 },
+       [ATHOS_LUT_CHAN_628625_IDX] =3D { 25145, 0x1, 0x68, 0x18AAAB, 0x82F=
 },
+       [ATHOS_LUT_CHAN_628750_IDX] =3D { 25150, 0x1, 0x68, 0x195555, 0x830=
 },
+       [ATHOS_LUT_CHAN_628875_IDX] =3D { 25155, 0x1, 0x68, 0x1A0000, 0x830=
 },
+       [ATHOS_LUT_CHAN_629000_IDX] =3D { 25160, 0x1, 0x68, 0x1AAAAB, 0x831=
 },
+       [ATHOS_LUT_CHAN_629125_IDX] =3D { 25165, 0x1, 0x68, 0x1B5555, 0x831=
 },
+       [ATHOS_LUT_CHAN_629250_IDX] =3D { 25170, 0x1, 0x68, 0x1C0000, 0x832=
 },
+       [ATHOS_LUT_CHAN_629375_IDX] =3D { 25175, 0x1, 0x68, 0x1CAAAB, 0x832=
 },
+       [ATHOS_LUT_CHAN_629500_IDX] =3D { 25180, 0x1, 0x68, 0x1D5555, 0x832=
 },
+       [ATHOS_LUT_CHAN_629625_IDX] =3D { 25185, 0x1, 0x68, 0x1E0000, 0x833=
 },
+       [ATHOS_LUT_CHAN_629750_IDX] =3D { 25190, 0x1, 0x68, 0x1EAAAB, 0x833=
 },
+       [ATHOS_LUT_CHAN_629875_IDX] =3D { 25195, 0x1, 0x68, 0x1F5555, 0x834=
 },
+       [ATHOS_LUT_CHAN_630000_IDX] =3D { 25200, 0x1, 0x69, 0x0, 0x834 },
+       [ATHOS_LUT_CHAN_630125_IDX] =3D { 25205, 0x1, 0x69, 0xAAAB, 0x834 }=
,
+       [ATHOS_LUT_CHAN_630250_IDX] =3D { 25210, 0x1, 0x69, 0x15555, 0x835 =
},
+       [ATHOS_LUT_CHAN_630375_IDX] =3D { 25215, 0x1, 0x69, 0x20000, 0x835 =
},
+       [ATHOS_LUT_CHAN_630500_IDX] =3D { 25220, 0x1, 0x69, 0x2AAAB, 0x836 =
},
+       [ATHOS_LUT_CHAN_630625_IDX] =3D { 25225, 0x1, 0x69, 0x35555, 0x836 =
},
+       [ATHOS_LUT_CHAN_630750_IDX] =3D { 25230, 0x1, 0x69, 0x40000, 0x837 =
},
+       [ATHOS_LUT_CHAN_630875_IDX] =3D { 25235, 0x1, 0x69, 0x4AAAB, 0x837 =
},
+       [ATHOS_LUT_CHAN_631000_IDX] =3D { 25240, 0x1, 0x69, 0x55555, 0x837 =
},
+       [ATHOS_LUT_CHAN_631125_IDX] =3D { 25245, 0x1, 0x69, 0x60000, 0x838 =
},
+       [ATHOS_LUT_CHAN_631250_IDX] =3D { 25250, 0x1, 0x69, 0x6AAAB, 0x838 =
},
+       [ATHOS_LUT_CHAN_631375_IDX] =3D { 25255, 0x1, 0x69, 0x75555, 0x839 =
},
+       [ATHOS_LUT_CHAN_631500_IDX] =3D { 25260, 0x1, 0x69, 0x80000, 0x839 =
},
+       [ATHOS_LUT_CHAN_631625_IDX] =3D { 25265, 0x1, 0x69, 0x8AAAB, 0x839 =
},
+       [ATHOS_LUT_CHAN_631750_IDX] =3D { 25270, 0x1, 0x69, 0x95555, 0x83A =
},
+       [ATHOS_LUT_CHAN_631875_IDX] =3D { 25275, 0x1, 0x69, 0xA0000, 0x83A =
},
+       [ATHOS_LUT_CHAN_632000_IDX] =3D { 25280, 0x1, 0x69, 0xAAAAB, 0x83B =
},
+       [ATHOS_LUT_CHAN_632125_IDX] =3D { 25285, 0x1, 0x69, 0xB5555, 0x83B =
},
+       [ATHOS_LUT_CHAN_632250_IDX] =3D { 25290, 0x1, 0x69, 0xC0000, 0x83C =
},
+       [ATHOS_LUT_CHAN_632375_IDX] =3D { 25295, 0x1, 0x69, 0xCAAAB, 0x83C =
},
+       [ATHOS_LUT_CHAN_632500_IDX] =3D { 25300, 0x1, 0x69, 0xD5555, 0x83C =
},
+       [ATHOS_LUT_CHAN_632625_IDX] =3D { 25305, 0x1, 0x69, 0xE0000, 0x83D =
},
+       [ATHOS_LUT_CHAN_632750_IDX] =3D { 25310, 0x1, 0x69, 0xEAAAB, 0x83D =
},
+       [ATHOS_LUT_CHAN_632875_IDX] =3D { 25315, 0x1, 0x69, 0xF5555, 0x83E =
},
+       [ATHOS_LUT_CHAN_633000_IDX] =3D { 25320, 0x1, 0x69, 0x100000, 0x83E=
 },
+       [ATHOS_LUT_CHAN_633125_IDX] =3D { 25325, 0x1, 0x69, 0x10AAAB, 0x83E=
 },
+       [ATHOS_LUT_CHAN_633250_IDX] =3D { 25330, 0x1, 0x69, 0x115555, 0x83F=
 },
+       [ATHOS_LUT_CHAN_633375_IDX] =3D { 25335, 0x1, 0x69, 0x120000, 0x83F=
 },
+       [ATHOS_LUT_CHAN_633500_IDX] =3D { 25340, 0x1, 0x69, 0x12AAAB, 0x840=
 },
+       [ATHOS_LUT_CHAN_633625_IDX] =3D { 25345, 0x1, 0x69, 0x135555, 0x840=
 },
+       [ATHOS_LUT_CHAN_633750_IDX] =3D { 25350, 0x1, 0x69, 0x140000, 0x841=
 },
+       [ATHOS_LUT_CHAN_633875_IDX] =3D { 25355, 0x1, 0x69, 0x14AAAB, 0x841=
 },
+       [ATHOS_LUT_CHAN_634000_IDX] =3D { 25360, 0x1, 0x69, 0x155555, 0x841=
 },
+       [ATHOS_LUT_CHAN_634125_IDX] =3D { 25365, 0x1, 0x69, 0x160000, 0x842=
 },
+       [ATHOS_LUT_CHAN_634250_IDX] =3D { 25370, 0x1, 0x69, 0x16AAAB, 0x842=
 },
+       [ATHOS_LUT_CHAN_634375_IDX] =3D { 25375, 0x1, 0x69, 0x175555, 0x843=
 },
+       [ATHOS_LUT_CHAN_634500_IDX] =3D { 25380, 0x1, 0x69, 0x180000, 0x843=
 },
+       [ATHOS_LUT_CHAN_634625_IDX] =3D { 25385, 0x1, 0x69, 0x18AAAB, 0x843=
 },
+       [ATHOS_LUT_CHAN_634750_IDX] =3D { 25390, 0x1, 0x69, 0x195555, 0x844=
 },
+       [ATHOS_LUT_CHAN_634875_IDX] =3D { 25395, 0x1, 0x69, 0x1A0000, 0x844=
 },
+       [ATHOS_LUT_CHAN_635000_IDX] =3D { 25400, 0x1, 0x69, 0x1AAAAB, 0x845=
 },
+       [ATHOS_LUT_CHAN_635125_IDX] =3D { 25405, 0x1, 0x69, 0x1B5555, 0x845=
 },
+       [ATHOS_LUT_CHAN_635250_IDX] =3D { 25410, 0x1, 0x69, 0x1C0000, 0x846=
 },
+       [ATHOS_LUT_CHAN_635375_IDX] =3D { 25415, 0x1, 0x69, 0x1CAAAB, 0x846=
 },
+       [ATHOS_LUT_CHAN_635500_IDX] =3D { 25420, 0x1, 0x69, 0x1D5555, 0x846=
 },
+       [ATHOS_LUT_CHAN_635625_IDX] =3D { 25425, 0x1, 0x69, 0x1E0000, 0x847=
 },
+       [ATHOS_LUT_CHAN_635750_IDX] =3D { 25430, 0x1, 0x69, 0x1EAAAB, 0x847=
 },
+       [ATHOS_LUT_CHAN_635875_IDX] =3D { 25435, 0x1, 0x69, 0x1F5555, 0x848=
 },
+       [ATHOS_LUT_CHAN_636000_IDX] =3D { 25440, 0x1, 0x6A, 0x0, 0x848 },
+       [ATHOS_LUT_CHAN_636125_IDX] =3D { 25445, 0x1, 0x6A, 0xAAAB, 0x848 }=
,
+       [ATHOS_LUT_CHAN_636250_IDX] =3D { 25450, 0x1, 0x6A, 0x15555, 0x849 =
},
+       [ATHOS_LUT_CHAN_636375_IDX] =3D { 25455, 0x1, 0x6A, 0x20000, 0x849 =
},
+       [ATHOS_LUT_CHAN_636500_IDX] =3D { 25460, 0x1, 0x6A, 0x2AAAB, 0x84A =
},
+       [ATHOS_LUT_CHAN_636625_IDX] =3D { 25465, 0x1, 0x6A, 0x35555, 0x84A =
},
+       [ATHOS_LUT_CHAN_636750_IDX] =3D { 25470, 0x1, 0x6A, 0x40000, 0x84B =
},
+       [ATHOS_LUT_CHAN_636875_IDX] =3D { 25475, 0x1, 0x6A, 0x4AAAB, 0x84B =
},
+       [ATHOS_LUT_CHAN_637000_IDX] =3D { 25480, 0x1, 0x6A, 0x55555, 0x84B =
},
+       [ATHOS_LUT_CHAN_637125_IDX] =3D { 25485, 0x1, 0x6A, 0x60000, 0x84C =
},
+       [ATHOS_LUT_CHAN_637250_IDX] =3D { 25490, 0x1, 0x6A, 0x6AAAB, 0x84C =
},
+       [ATHOS_LUT_CHAN_637375_IDX] =3D { 25495, 0x1, 0x6A, 0x75555, 0x84D =
},
+       [ATHOS_LUT_CHAN_637500_IDX] =3D { 25500, 0x1, 0x6A, 0x80000, 0x84D =
},
+       [ATHOS_LUT_CHAN_637625_IDX] =3D { 25505, 0x1, 0x6A, 0x8AAAB, 0x84D =
},
+       [ATHOS_LUT_CHAN_637750_IDX] =3D { 25510, 0x1, 0x6A, 0x95555, 0x84E =
},
+       [ATHOS_LUT_CHAN_637875_IDX] =3D { 25515, 0x1, 0x6A, 0xA0000, 0x84E =
},
+       [ATHOS_LUT_CHAN_638000_IDX] =3D { 25520, 0x1, 0x6A, 0xAAAAB, 0x84F =
},
+       [ATHOS_LUT_CHAN_638125_IDX] =3D { 25525, 0x1, 0x6A, 0xB5555, 0x84F =
},
+       [ATHOS_LUT_CHAN_638250_IDX] =3D { 25530, 0x1, 0x6A, 0xC0000, 0x850 =
},
+       [ATHOS_LUT_CHAN_638375_IDX] =3D { 25535, 0x1, 0x6A, 0xCAAAB, 0x850 =
},
+       [ATHOS_LUT_CHAN_638500_IDX] =3D { 25540, 0x1, 0x6A, 0xD5555, 0x850 =
},
+       [ATHOS_LUT_CHAN_638625_IDX] =3D { 25545, 0x1, 0x6A, 0xE0000, 0x851 =
},
+       [ATHOS_LUT_CHAN_638750_IDX] =3D { 25550, 0x1, 0x6A, 0xEAAAB, 0x851 =
},
+       [ATHOS_LUT_CHAN_638875_IDX] =3D { 25555, 0x1, 0x6A, 0xF5555, 0x852 =
},
+       [ATHOS_LUT_CHAN_639000_IDX] =3D { 25560, 0x1, 0x6A, 0x100000, 0x852=
 },
+       [ATHOS_LUT_CHAN_639125_IDX] =3D { 25565, 0x1, 0x6A, 0x10AAAB, 0x852=
 },
+       [ATHOS_LUT_CHAN_639250_IDX] =3D { 25570, 0x1, 0x6A, 0x115555, 0x853=
 },
+       [ATHOS_LUT_CHAN_639375_IDX] =3D { 25575, 0x1, 0x6A, 0x120000, 0x853=
 },
+       [ATHOS_LUT_CHAN_639500_IDX] =3D { 25580, 0x1, 0x6A, 0x12AAAB, 0x854=
 },
+       [ATHOS_LUT_CHAN_639625_IDX] =3D { 25585, 0x1, 0x6A, 0x135555, 0x854=
 },
+       [ATHOS_LUT_CHAN_639750_IDX] =3D { 25590, 0x1, 0x6A, 0x140000, 0x855=
 },
+       [ATHOS_LUT_CHAN_639875_IDX] =3D { 25595, 0x1, 0x6A, 0x14AAAB, 0x855=
 },
+       [ATHOS_LUT_CHAN_640000_IDX] =3D { 25600, 0x1, 0x6A, 0x155555, 0x855=
 },
+       [ATHOS_LUT_CHAN_640125_IDX] =3D { 25605, 0x1, 0x6A, 0x160000, 0x856=
 },
+       [ATHOS_LUT_CHAN_640250_IDX] =3D { 25610, 0x1, 0x6A, 0x16AAAB, 0x856=
 },
+       [ATHOS_LUT_CHAN_640375_IDX] =3D { 25615, 0x1, 0x6A, 0x175555, 0x857=
 },
+       [ATHOS_LUT_CHAN_640500_IDX] =3D { 25620, 0x1, 0x6A, 0x180000, 0x857=
 },
+       [ATHOS_LUT_CHAN_640625_IDX] =3D { 25625, 0x1, 0x6A, 0x18AAAB, 0x857=
 },
+       [ATHOS_LUT_CHAN_640750_IDX] =3D { 25630, 0x1, 0x6A, 0x195555, 0x858=
 },
+       [ATHOS_LUT_CHAN_640875_IDX] =3D { 25635, 0x1, 0x6A, 0x1A0000, 0x858=
 },
+       [ATHOS_LUT_CHAN_641000_IDX] =3D { 25640, 0x1, 0x6A, 0x1AAAAB, 0x859=
 },
+       [ATHOS_LUT_CHAN_641125_IDX] =3D { 25645, 0x1, 0x6A, 0x1B5555, 0x859=
 },
+       [ATHOS_LUT_CHAN_641250_IDX] =3D { 25650, 0x1, 0x6A, 0x1C0000, 0x85A=
 },
+       [ATHOS_LUT_CHAN_641375_IDX] =3D { 25655, 0x1, 0x6A, 0x1CAAAB, 0x85A=
 },
+       [ATHOS_LUT_CHAN_641500_IDX] =3D { 25660, 0x1, 0x6A, 0x1D5555, 0x85A=
 },
+       [ATHOS_LUT_CHAN_641625_IDX] =3D { 25665, 0x1, 0x6A, 0x1E0000, 0x85B=
 },
+       [ATHOS_LUT_CHAN_641750_IDX] =3D { 25670, 0x1, 0x6A, 0x1EAAAB, 0x85B=
 },
+       [ATHOS_LUT_CHAN_641875_IDX] =3D { 25675, 0x1, 0x6A, 0x1F5555, 0x85C=
 },
+       [ATHOS_LUT_CHAN_642000_IDX] =3D { 25680, 0x1, 0x6B, 0x0, 0x85C },
+       [ATHOS_LUT_CHAN_642125_IDX] =3D { 25685, 0x1, 0x6B, 0xAAAB, 0x85C }=
,
+       [ATHOS_LUT_CHAN_642250_IDX] =3D { 25690, 0x1, 0x6B, 0x15555, 0x85D =
},
+       [ATHOS_LUT_CHAN_642375_IDX] =3D { 25695, 0x1, 0x6B, 0x20000, 0x85D =
},
+       [ATHOS_LUT_CHAN_642500_IDX] =3D { 25700, 0x1, 0x6B, 0x2AAAB, 0x85E =
},
+       [ATHOS_LUT_CHAN_642625_IDX] =3D { 25705, 0x1, 0x6B, 0x35555, 0x85E =
},
+       [ATHOS_LUT_CHAN_642750_IDX] =3D { 25710, 0x1, 0x6B, 0x40000, 0x85F =
},
+       [ATHOS_LUT_CHAN_642875_IDX] =3D { 25715, 0x1, 0x6B, 0x4AAAB, 0x85F =
},
+       [ATHOS_LUT_CHAN_643000_IDX] =3D { 25720, 0x1, 0x6B, 0x55555, 0x85F =
},
+       [ATHOS_LUT_CHAN_643125_IDX] =3D { 25725, 0x1, 0x6B, 0x60000, 0x860 =
},
+       [ATHOS_LUT_CHAN_643250_IDX] =3D { 25730, 0x1, 0x6B, 0x6AAAB, 0x860 =
},
+       [ATHOS_LUT_CHAN_643375_IDX] =3D { 25735, 0x1, 0x6B, 0x75555, 0x861 =
},
+       [ATHOS_LUT_CHAN_643500_IDX] =3D { 25740, 0x1, 0x6B, 0x80000, 0x861 =
},
+       [ATHOS_LUT_CHAN_643625_IDX] =3D { 25745, 0x1, 0x6B, 0x8AAAB, 0x861 =
},
+       [ATHOS_LUT_CHAN_643750_IDX] =3D { 25750, 0x1, 0x6B, 0x95555, 0x862 =
},
+       [ATHOS_LUT_CHAN_643875_IDX] =3D { 25755, 0x1, 0x6B, 0xA0000, 0x862 =
},
+       [ATHOS_LUT_CHAN_644000_IDX] =3D { 25760, 0x1, 0x6B, 0xAAAAB, 0x863 =
},
+       [ATHOS_LUT_CHAN_644125_IDX] =3D { 25765, 0x1, 0x6B, 0xB5555, 0x863 =
},
+       [ATHOS_LUT_CHAN_644250_IDX] =3D { 25770, 0x1, 0x6B, 0xC0000, 0x864 =
},
+       [ATHOS_LUT_CHAN_644375_IDX] =3D { 25775, 0x1, 0x6B, 0xCAAAB, 0x864 =
},
+       [ATHOS_LUT_CHAN_644500_IDX] =3D { 25780, 0x1, 0x6B, 0xD5555, 0x864 =
},
+       [ATHOS_LUT_CHAN_644625_IDX] =3D { 25785, 0x1, 0x6B, 0xE0000, 0x865 =
},
+       [ATHOS_LUT_CHAN_644750_IDX] =3D { 25790, 0x1, 0x6B, 0xEAAAB, 0x865 =
},
+       [ATHOS_LUT_CHAN_644875_IDX] =3D { 25795, 0x1, 0x6B, 0xF5555, 0x866 =
},
+       [ATHOS_LUT_CHAN_645000_IDX] =3D { 25800, 0x1, 0x6B, 0x100000, 0x866=
 },
+       [ATHOS_LUT_CHAN_645125_IDX] =3D { 25805, 0x1, 0x6B, 0x10AAAB, 0x866=
 },
+       [ATHOS_LUT_CHAN_645250_IDX] =3D { 25810, 0x1, 0x6B, 0x115555, 0x867=
 },
+       [ATHOS_LUT_CHAN_645375_IDX] =3D { 25815, 0x1, 0x6B, 0x120000, 0x867=
 },
+       [ATHOS_LUT_CHAN_645500_IDX] =3D { 25820, 0x1, 0x6B, 0x12AAAB, 0x868=
 },
+       [ATHOS_LUT_CHAN_645625_IDX] =3D { 25825, 0x1, 0x6B, 0x135555, 0x868=
 },
+       [ATHOS_LUT_CHAN_645750_IDX] =3D { 25830, 0x1, 0x6B, 0x140000, 0x869=
 },
+       [ATHOS_LUT_CHAN_645875_IDX] =3D { 25835, 0x1, 0x6B, 0x14AAAB, 0x869=
 },
+       [ATHOS_LUT_CHAN_646000_IDX] =3D { 25840, 0x1, 0x6B, 0x155555, 0x869=
 },
+       [ATHOS_LUT_CHAN_646125_IDX] =3D { 25845, 0x1, 0x6B, 0x160000, 0x86A=
 },
+       [ATHOS_LUT_CHAN_646250_IDX] =3D { 25850, 0x1, 0x6B, 0x16AAAB, 0x86A=
 },
+       [ATHOS_LUT_CHAN_646375_IDX] =3D { 25855, 0x1, 0x6B, 0x175555, 0x86B=
 },
+       [ATHOS_LUT_CHAN_646500_IDX] =3D { 25860, 0x1, 0x6B, 0x180000, 0x86B=
 },
+       [ATHOS_LUT_CHAN_646625_IDX] =3D { 25865, 0x1, 0x6B, 0x18AAAB, 0x86B=
 },
+       [ATHOS_LUT_CHAN_646750_IDX] =3D { 25870, 0x1, 0x6B, 0x195555, 0x86C=
 },
+       [ATHOS_LUT_CHAN_646875_IDX] =3D { 25875, 0x1, 0x6B, 0x1A0000, 0x86C=
 },
+       [ATHOS_LUT_CHAN_647000_IDX] =3D { 25880, 0x1, 0x6B, 0x1AAAAB, 0x86D=
 },
+       [ATHOS_LUT_CHAN_647125_IDX] =3D { 25885, 0x1, 0x6B, 0x1B5555, 0x86D=
 },
+       [ATHOS_LUT_CHAN_647250_IDX] =3D { 25890, 0x1, 0x6B, 0x1C0000, 0x86E=
 },
+       [ATHOS_LUT_CHAN_647375_IDX] =3D { 25895, 0x1, 0x6B, 0x1CAAAB, 0x86E=
 },
+       [ATHOS_LUT_CHAN_647500_IDX] =3D { 25900, 0x1, 0x6B, 0x1D5555, 0x86E=
 },
+       [ATHOS_LUT_CHAN_647625_IDX] =3D { 25905, 0x1, 0x6B, 0x1E0000, 0x86F=
 },
+       [ATHOS_LUT_CHAN_647750_IDX] =3D { 25910, 0x1, 0x6B, 0x1EAAAB, 0x86F=
 },
+       [ATHOS_LUT_CHAN_647875_IDX] =3D { 25915, 0x1, 0x6B, 0x1F5555, 0x870=
 },
+       [ATHOS_LUT_CHAN_648000_IDX] =3D { 25920, 0x1, 0x6C, 0x0, 0x870 },
+       [ATHOS_LUT_CHAN_648125_IDX] =3D { 25925, 0x1, 0x6C, 0xAAAB, 0x870 }=
,
+       [ATHOS_LUT_CHAN_648250_IDX] =3D { 25930, 0x1, 0x6C, 0x15555, 0x871 =
},
+       [ATHOS_LUT_CHAN_648375_IDX] =3D { 25935, 0x1, 0x6C, 0x20000, 0x871 =
},
+       [ATHOS_LUT_CHAN_648500_IDX] =3D { 25940, 0x1, 0x6C, 0x2AAAB, 0x872 =
},
+       [ATHOS_LUT_CHAN_648625_IDX] =3D { 25945, 0x1, 0x6C, 0x35555, 0x872 =
},
+       [ATHOS_LUT_CHAN_648750_IDX] =3D { 25950, 0x1, 0x6C, 0x40000, 0x873 =
},
+       [ATHOS_LUT_CHAN_648875_IDX] =3D { 25955, 0x1, 0x6C, 0x4AAAB, 0x873 =
},
+       [ATHOS_LUT_CHAN_649000_IDX] =3D { 25960, 0x1, 0x6C, 0x55555, 0x873 =
},
+       [ATHOS_LUT_CHAN_649125_IDX] =3D { 25965, 0x1, 0x6C, 0x60000, 0x874 =
},
+       [ATHOS_LUT_CHAN_649250_IDX] =3D { 25970, 0x1, 0x6C, 0x6AAAB, 0x874 =
},
+       [ATHOS_LUT_CHAN_649375_IDX] =3D { 25975, 0x1, 0x6C, 0x75555, 0x875 =
},
+       [ATHOS_LUT_CHAN_649500_IDX] =3D { 25980, 0x1, 0x6C, 0x80000, 0x875 =
},
+       [ATHOS_LUT_CHAN_649625_IDX] =3D { 25985, 0x1, 0x6C, 0x8AAAB, 0x875 =
},
+       [ATHOS_LUT_CHAN_649750_IDX] =3D { 25990, 0x1, 0x6C, 0x95555, 0x876 =
},
+       [ATHOS_LUT_CHAN_649875_IDX] =3D { 25995, 0x1, 0x6C, 0xA0000, 0x876 =
},
+       [ATHOS_LUT_CHAN_650000_IDX] =3D { 26000, 0x1, 0x6C, 0xAAAAB, 0x877 =
},
+       [ATHOS_LUT_CHAN_650125_IDX] =3D { 26005, 0x1, 0x6C, 0xB5555, 0x877 =
},
+       [ATHOS_LUT_CHAN_650250_IDX] =3D { 26010, 0x1, 0x6C, 0xC0000, 0x878 =
},
+       [ATHOS_LUT_CHAN_650375_IDX] =3D { 26015, 0x1, 0x6C, 0xCAAAB, 0x878 =
},
+       [ATHOS_LUT_CHAN_650500_IDX] =3D { 26020, 0x1, 0x6C, 0xD5555, 0x878 =
},
+       [ATHOS_LUT_CHAN_650625_IDX] =3D { 26025, 0x1, 0x6C, 0xE0000, 0x879 =
},
+       [ATHOS_LUT_CHAN_650750_IDX] =3D { 26030, 0x1, 0x6C, 0xEAAAB, 0x879 =
},
+       [ATHOS_LUT_CHAN_650875_IDX] =3D { 26035, 0x1, 0x6C, 0xF5555, 0x87A =
},
+       [ATHOS_LUT_CHAN_651000_IDX] =3D { 26040, 0x1, 0x6C, 0x100000, 0x87A=
 },
+       [ATHOS_LUT_CHAN_651125_IDX] =3D { 26045, 0x1, 0x6C, 0x10AAAB, 0x87A=
 },
+       [ATHOS_LUT_CHAN_651250_IDX] =3D { 26050, 0x1, 0x6C, 0x115555, 0x87B=
 },
+       [ATHOS_LUT_CHAN_651375_IDX] =3D { 26055, 0x1, 0x6C, 0x120000, 0x87B=
 },
+       [ATHOS_LUT_CHAN_651500_IDX] =3D { 26060, 0x1, 0x6C, 0x12AAAB, 0x87C=
 },
+       [ATHOS_LUT_CHAN_651625_IDX] =3D { 26065, 0x1, 0x6C, 0x135555, 0x87C=
 },
+       [ATHOS_LUT_CHAN_651750_IDX] =3D { 26070, 0x1, 0x6C, 0x140000, 0x87D=
 },
+       [ATHOS_LUT_CHAN_651875_IDX] =3D { 26075, 0x1, 0x6C, 0x14AAAB, 0x87D=
 },
+       [ATHOS_LUT_CHAN_652000_IDX] =3D { 26080, 0x1, 0x6C, 0x155555, 0x87D=
 },
+       [ATHOS_LUT_CHAN_652125_IDX] =3D { 26085, 0x1, 0x6C, 0x160000, 0x87E=
 },
+       [ATHOS_LUT_CHAN_652250_IDX] =3D { 26090, 0x1, 0x6C, 0x16AAAB, 0x87E=
 },
+       [ATHOS_LUT_CHAN_652375_IDX] =3D { 26095, 0x1, 0x6C, 0x175555, 0x87F=
 },
+       [ATHOS_LUT_CHAN_652500_IDX] =3D { 26100, 0x1, 0x6C, 0x180000, 0x87F=
 },
+       [ATHOS_LUT_CHAN_652625_IDX] =3D { 26105, 0x1, 0x6C, 0x18AAAB, 0x87F=
 },
+       [ATHOS_LUT_CHAN_652750_IDX] =3D { 26110, 0x1, 0x6C, 0x195555, 0x880=
 },
+       [ATHOS_LUT_CHAN_652875_IDX] =3D { 26115, 0x1, 0x6C, 0x1A0000, 0x880=
 },
+       [ATHOS_LUT_CHAN_653000_IDX] =3D { 26120, 0x1, 0x6C, 0x1AAAAB, 0x881=
 },
+       [ATHOS_LUT_CHAN_653125_IDX] =3D { 26125, 0x1, 0x6C, 0x1B5555, 0x881=
 },
+       [ATHOS_LUT_CHAN_653250_IDX] =3D { 26130, 0x1, 0x6C, 0x1C0000, 0x882=
 },
+       [ATHOS_LUT_CHAN_653375_IDX] =3D { 26135, 0x1, 0x6C, 0x1CAAAB, 0x882=
 },
+       [ATHOS_LUT_CHAN_653500_IDX] =3D { 26140, 0x1, 0x6C, 0x1D5555, 0x882=
 },
+       [ATHOS_LUT_CHAN_653625_IDX] =3D { 26145, 0x1, 0x6C, 0x1E0000, 0x883=
 },
+       [ATHOS_LUT_CHAN_653750_IDX] =3D { 26150, 0x1, 0x6C, 0x1EAAAB, 0x883=
 },
+       [ATHOS_LUT_CHAN_653875_IDX] =3D { 26155, 0x1, 0x6C, 0x1F5555, 0x884=
 },
+       [ATHOS_LUT_CHAN_654000_IDX] =3D { 26160, 0x1, 0x6D, 0x0, 0x884 },
+       [ATHOS_LUT_CHAN_654125_IDX] =3D { 26165, 0x1, 0x6D, 0xAAAB, 0x884 }=
,
+       [ATHOS_LUT_CHAN_654250_IDX] =3D { 26170, 0x1, 0x6D, 0x15555, 0x885 =
},
+       [ATHOS_LUT_CHAN_654375_IDX] =3D { 26175, 0x1, 0x6D, 0x20000, 0x885 =
},
+       [ATHOS_LUT_CHAN_654500_IDX] =3D { 26180, 0x1, 0x6D, 0x2AAAB, 0x886 =
},
+       [ATHOS_LUT_CHAN_654625_IDX] =3D { 26185, 0x1, 0x6D, 0x35555, 0x886 =
},
+       [ATHOS_LUT_CHAN_654750_IDX] =3D { 26190, 0x1, 0x6D, 0x40000, 0x887 =
},
+       [ATHOS_LUT_CHAN_654875_IDX] =3D { 26195, 0x1, 0x6D, 0x4AAAB, 0x887 =
},
+       [ATHOS_LUT_CHAN_655000_IDX] =3D { 26200, 0x1, 0x6D, 0x55555, 0x887 =
},
+       [ATHOS_LUT_CHAN_655125_IDX] =3D { 26205, 0x1, 0x6D, 0x60000, 0x888 =
},
+       [ATHOS_LUT_CHAN_655250_IDX] =3D { 26210, 0x1, 0x6D, 0x6AAAB, 0x888 =
},
+       [ATHOS_LUT_CHAN_655375_IDX] =3D { 26215, 0x1, 0x6D, 0x75555, 0x889 =
},
+       [ATHOS_LUT_CHAN_655500_IDX] =3D { 26220, 0x1, 0x6D, 0x80000, 0x889 =
},
+       [ATHOS_LUT_CHAN_655625_IDX] =3D { 26225, 0x1, 0x6D, 0x8AAAB, 0x889 =
},
+       [ATHOS_LUT_CHAN_655750_IDX] =3D { 26230, 0x1, 0x6D, 0x95555, 0x88A =
},
+       [ATHOS_LUT_CHAN_655875_IDX] =3D { 26235, 0x1, 0x6D, 0xA0000, 0x88A =
},
+       [ATHOS_LUT_CHAN_656000_IDX] =3D { 26240, 0x1, 0x6D, 0xAAAAB, 0x88B =
},
+       [ATHOS_LUT_CHAN_656125_IDX] =3D { 26245, 0x1, 0x6D, 0xB5555, 0x88B =
},
+       [ATHOS_LUT_CHAN_656250_IDX] =3D { 26250, 0x1, 0x6D, 0xC0000, 0x88C =
},
+       [ATHOS_LUT_CHAN_656375_IDX] =3D { 26255, 0x1, 0x6D, 0xCAAAB, 0x88C =
},
+       [ATHOS_LUT_CHAN_656500_IDX] =3D { 26260, 0x1, 0x6D, 0xD5555, 0x88C =
},
+       [ATHOS_LUT_CHAN_656625_IDX] =3D { 26265, 0x1, 0x6D, 0xE0000, 0x88D =
},
+       [ATHOS_LUT_CHAN_656750_IDX] =3D { 26270, 0x1, 0x6D, 0xEAAAB, 0x88D =
},
+       [ATHOS_LUT_CHAN_656875_IDX] =3D { 26275, 0x1, 0x6D, 0xF5555, 0x88E =
},
+       [ATHOS_LUT_CHAN_657000_IDX] =3D { 26280, 0x1, 0x6D, 0x100000, 0x88E=
 },
+       [ATHOS_LUT_CHAN_657125_IDX] =3D { 26285, 0x1, 0x6D, 0x10AAAB, 0x88E=
 },
+       [ATHOS_LUT_CHAN_657250_IDX] =3D { 26290, 0x1, 0x6D, 0x115555, 0x88F=
 },
+       [ATHOS_LUT_CHAN_657375_IDX] =3D { 26295, 0x1, 0x6D, 0x120000, 0x88F=
 },
+       [ATHOS_LUT_CHAN_657500_IDX] =3D { 26300, 0x1, 0x6D, 0x12AAAB, 0x890=
 },
+       [ATHOS_LUT_CHAN_657625_IDX] =3D { 26305, 0x1, 0x6D, 0x135555, 0x890=
 },
+       [ATHOS_LUT_CHAN_657750_IDX] =3D { 26310, 0x1, 0x6D, 0x140000, 0x891=
 },
+       [ATHOS_LUT_CHAN_657875_IDX] =3D { 26315, 0x1, 0x6D, 0x14AAAB, 0x891=
 },
+       [ATHOS_LUT_CHAN_658000_IDX] =3D { 26320, 0x1, 0x6D, 0x155555, 0x891=
 },
+       [ATHOS_LUT_CHAN_658125_IDX] =3D { 26325, 0x1, 0x6D, 0x160000, 0x892=
 },
+       [ATHOS_LUT_CHAN_658250_IDX] =3D { 26330, 0x1, 0x6D, 0x16AAAB, 0x892=
 },
+       [ATHOS_LUT_CHAN_658375_IDX] =3D { 26335, 0x1, 0x6D, 0x175555, 0x893=
 },
+       [ATHOS_LUT_CHAN_658500_IDX] =3D { 26340, 0x1, 0x6D, 0x180000, 0x893=
 },
+       [ATHOS_LUT_CHAN_658625_IDX] =3D { 26345, 0x1, 0x6D, 0x18AAAB, 0x893=
 },
+       [ATHOS_LUT_CHAN_658750_IDX] =3D { 26350, 0x1, 0x6D, 0x195555, 0x894=
 },
+       [ATHOS_LUT_CHAN_658875_IDX] =3D { 26355, 0x1, 0x6D, 0x1A0000, 0x894=
 },
+       [ATHOS_LUT_CHAN_659000_IDX] =3D { 26360, 0x1, 0x6D, 0x1AAAAB, 0x895=
 },
+       [ATHOS_LUT_CHAN_659125_IDX] =3D { 26365, 0x1, 0x6D, 0x1B5555, 0x895=
 },
+       [ATHOS_LUT_CHAN_659250_IDX] =3D { 26370, 0x1, 0x6D, 0x1C0000, 0x896=
 },
+       [ATHOS_LUT_CHAN_659375_IDX] =3D { 26375, 0x1, 0x6D, 0x1CAAAB, 0x896=
 },
+       [ATHOS_LUT_CHAN_659500_IDX] =3D { 26380, 0x1, 0x6D, 0x1D5555, 0x896=
 },
+       [ATHOS_LUT_CHAN_659625_IDX] =3D { 26385, 0x1, 0x6D, 0x1E0000, 0x897=
 },
+       [ATHOS_LUT_CHAN_659750_IDX] =3D { 26390, 0x1, 0x6D, 0x1EAAAB, 0x897=
 },
+       [ATHOS_LUT_CHAN_659875_IDX] =3D { 26395, 0x1, 0x6D, 0x1F5555, 0x898=
 },
+       [ATHOS_LUT_CHAN_660000_IDX] =3D { 26400, 0x1, 0x6E, 0x0, 0x898 },
+       [ATHOS_LUT_CHAN_660125_IDX] =3D { 26405, 0x1, 0x6E, 0xAAAB, 0x898 }=
,
+       [ATHOS_LUT_CHAN_660250_IDX] =3D { 26410, 0x1, 0x6E, 0x15555, 0x899 =
},
+       [ATHOS_LUT_CHAN_660375_IDX] =3D { 26415, 0x1, 0x6E, 0x20000, 0x899 =
},
+       [ATHOS_LUT_CHAN_660500_IDX] =3D { 26420, 0x1, 0x6E, 0x2AAAB, 0x89A =
},
+       [ATHOS_LUT_CHAN_660625_IDX] =3D { 26425, 0x1, 0x6E, 0x35555, 0x89A =
},
+       [ATHOS_LUT_CHAN_660750_IDX] =3D { 26430, 0x1, 0x6E, 0x40000, 0x89B =
},
+       [ATHOS_LUT_CHAN_660875_IDX] =3D { 26435, 0x1, 0x6E, 0x4AAAB, 0x89B =
},
+       [ATHOS_LUT_CHAN_661000_IDX] =3D { 26440, 0x1, 0x6E, 0x55555, 0x89B =
},
+       [ATHOS_LUT_CHAN_661125_IDX] =3D { 26445, 0x1, 0x6E, 0x60000, 0x89C =
},
+       [ATHOS_LUT_CHAN_661250_IDX] =3D { 26450, 0x1, 0x6E, 0x6AAAB, 0x89C =
},
+       [ATHOS_LUT_CHAN_661375_IDX] =3D { 26455, 0x1, 0x6E, 0x75555, 0x89D =
},
+       [ATHOS_LUT_CHAN_661500_IDX] =3D { 26460, 0x1, 0x6E, 0x80000, 0x89D =
},
+       [ATHOS_LUT_CHAN_661625_IDX] =3D { 26465, 0x1, 0x6E, 0x8AAAB, 0x89D =
},
+       [ATHOS_LUT_CHAN_661750_IDX] =3D { 26470, 0x1, 0x6E, 0x95555, 0x89E =
},
+       [ATHOS_LUT_CHAN_661875_IDX] =3D { 26475, 0x1, 0x6E, 0xA0000, 0x89E =
},
+       [ATHOS_LUT_CHAN_662000_IDX] =3D { 26480, 0x1, 0x6E, 0xAAAAB, 0x89F =
},
+       [ATHOS_LUT_CHAN_662125_IDX] =3D { 26485, 0x1, 0x6E, 0xB5555, 0x89F =
},
+       [ATHOS_LUT_CHAN_662250_IDX] =3D { 26490, 0x1, 0x6E, 0xC0000, 0x8A0 =
},
+       [ATHOS_LUT_CHAN_662375_IDX] =3D { 26495, 0x1, 0x6E, 0xCAAAB, 0x8A0 =
},
+       [ATHOS_LUT_CHAN_662500_IDX] =3D { 26500, 0x1, 0x6E, 0xD5555, 0x8A0 =
},
+       [ATHOS_LUT_CHAN_662625_IDX] =3D { 26505, 0x1, 0x6E, 0xE0000, 0x8A1 =
},
+       [ATHOS_LUT_CHAN_662750_IDX] =3D { 26510, 0x1, 0x6E, 0xEAAAB, 0x8A1 =
},
+       [ATHOS_LUT_CHAN_662875_IDX] =3D { 26515, 0x1, 0x6E, 0xF5555, 0x8A2 =
},
+       [ATHOS_LUT_CHAN_663000_IDX] =3D { 26520, 0x1, 0x6E, 0x100000, 0x8A2=
 },
+       [ATHOS_LUT_CHAN_663125_IDX] =3D { 26525, 0x1, 0x6E, 0x10AAAB, 0x8A2=
 },
+       [ATHOS_LUT_CHAN_663250_IDX] =3D { 26530, 0x1, 0x6E, 0x115555, 0x8A3=
 },
+       [ATHOS_LUT_CHAN_663375_IDX] =3D { 26535, 0x1, 0x6E, 0x120000, 0x8A3=
 },
+       [ATHOS_LUT_CHAN_663500_IDX] =3D { 26540, 0x1, 0x6E, 0x12AAAB, 0x8A4=
 },
+       [ATHOS_LUT_CHAN_663625_IDX] =3D { 26545, 0x1, 0x6E, 0x135555, 0x8A4=
 },
+       [ATHOS_LUT_CHAN_663750_IDX] =3D { 26550, 0x1, 0x6E, 0x140000, 0x8A5=
 },
+       [ATHOS_LUT_CHAN_663875_IDX] =3D { 26555, 0x1, 0x6E, 0x14AAAB, 0x8A5=
 },
+       [ATHOS_LUT_CHAN_664000_IDX] =3D { 26560, 0x1, 0x6E, 0x155555, 0x8A5=
 },
+       [ATHOS_LUT_CHAN_664125_IDX] =3D { 26565, 0x1, 0x6E, 0x160000, 0x8A6=
 },
+       [ATHOS_LUT_CHAN_664250_IDX] =3D { 26570, 0x1, 0x6E, 0x16AAAB, 0x8A6=
 },
+       [ATHOS_LUT_CHAN_664375_IDX] =3D { 26575, 0x1, 0x6E, 0x175555, 0x8A7=
 },
+       [ATHOS_LUT_CHAN_664500_IDX] =3D { 26580, 0x1, 0x6E, 0x180000, 0x8A7=
 },
+       [ATHOS_LUT_CHAN_664625_IDX] =3D { 26585, 0x1, 0x6E, 0x18AAAB, 0x8A7=
 },
+       [ATHOS_LUT_CHAN_664750_IDX] =3D { 26590, 0x1, 0x6E, 0x195555, 0x8A8=
 },
+       [ATHOS_LUT_CHAN_664875_IDX] =3D { 26595, 0x1, 0x6E, 0x1A0000, 0x8A8=
 },
+       [ATHOS_LUT_CHAN_665000_IDX] =3D { 26600, 0x1, 0x6E, 0x1AAAAB, 0x8A9=
 },
+       [ATHOS_LUT_CHAN_665125_IDX] =3D { 26605, 0x1, 0x6E, 0x1B5555, 0x8A9=
 },
+       [ATHOS_LUT_CHAN_665250_IDX] =3D { 26610, 0x1, 0x6E, 0x1C0000, 0x8AA=
 },
+       [ATHOS_LUT_CHAN_665375_IDX] =3D { 26615, 0x1, 0x6E, 0x1CAAAB, 0x8AA=
 },
+       [ATHOS_LUT_CHAN_665500_IDX] =3D { 26620, 0x1, 0x6E, 0x1D5555, 0x8AA=
 },
+       [ATHOS_LUT_CHAN_665625_IDX] =3D { 26625, 0x1, 0x6E, 0x1E0000, 0x8AB=
 },
+       [ATHOS_LUT_CHAN_665750_IDX] =3D { 26630, 0x1, 0x6E, 0x1EAAAB, 0x8AB=
 },
+       [ATHOS_LUT_CHAN_665875_IDX] =3D { 26635, 0x1, 0x6E, 0x1F5555, 0x8AC=
 },
+       [ATHOS_LUT_CHAN_666000_IDX] =3D { 26640, 0x1, 0x6F, 0x0, 0x8AC },
+       [ATHOS_LUT_CHAN_666125_IDX] =3D { 26645, 0x1, 0x6F, 0xAAAB, 0x8AC }=
,
+       [ATHOS_LUT_CHAN_666250_IDX] =3D { 26650, 0x1, 0x6F, 0x15555, 0x8AD =
},
+       [ATHOS_LUT_CHAN_666375_IDX] =3D { 26655, 0x1, 0x6F, 0x20000, 0x8AD =
},
+       [ATHOS_LUT_CHAN_666500_IDX] =3D { 26660, 0x1, 0x6F, 0x2AAAB, 0x8AE =
},
+       [ATHOS_LUT_CHAN_666625_IDX] =3D { 26665, 0x1, 0x6F, 0x35555, 0x8AE =
},
+       [ATHOS_LUT_CHAN_666750_IDX] =3D { 26670, 0x1, 0x6F, 0x40000, 0x8AF =
},
+       [ATHOS_LUT_CHAN_666875_IDX] =3D { 26675, 0x1, 0x6F, 0x4AAAB, 0x8AF =
},
+       [ATHOS_LUT_CHAN_667000_IDX] =3D { 26680, 0x1, 0x6F, 0x55555, 0x8AF =
},
+       [ATHOS_LUT_CHAN_667125_IDX] =3D { 26685, 0x1, 0x6F, 0x60000, 0x8B0 =
},
+       [ATHOS_LUT_CHAN_667250_IDX] =3D { 26690, 0x1, 0x6F, 0x6AAAB, 0x8B0 =
},
+       [ATHOS_LUT_CHAN_667375_IDX] =3D { 26695, 0x1, 0x6F, 0x75555, 0x8B1 =
},
+       [ATHOS_LUT_CHAN_667500_IDX] =3D { 26700, 0x1, 0x6F, 0x80000, 0x8B1 =
},
+       [ATHOS_LUT_CHAN_667625_IDX] =3D { 26705, 0x1, 0x6F, 0x8AAAB, 0x8B1 =
},
+       [ATHOS_LUT_CHAN_667750_IDX] =3D { 26710, 0x1, 0x6F, 0x95555, 0x8B2 =
},
+       [ATHOS_LUT_CHAN_667875_IDX] =3D { 26715, 0x1, 0x6F, 0xA0000, 0x8B2 =
},
+       [ATHOS_LUT_CHAN_668000_IDX] =3D { 26720, 0x1, 0x6F, 0xAAAAB, 0x8B3 =
},
+       [ATHOS_LUT_CHAN_668125_IDX] =3D { 26725, 0x1, 0x6F, 0xB5555, 0x8B3 =
},
+       [ATHOS_LUT_CHAN_668250_IDX] =3D { 26730, 0x1, 0x6F, 0xC0000, 0x8B4 =
},
+       [ATHOS_LUT_CHAN_668375_IDX] =3D { 26735, 0x1, 0x6F, 0xCAAAB, 0x8B4 =
},
+       [ATHOS_LUT_CHAN_668500_IDX] =3D { 26740, 0x1, 0x6F, 0xD5555, 0x8B4 =
},
+       [ATHOS_LUT_CHAN_668625_IDX] =3D { 26745, 0x1, 0x6F, 0xE0000, 0x8B5 =
},
+       [ATHOS_LUT_CHAN_668750_IDX] =3D { 26750, 0x1, 0x6F, 0xEAAAB, 0x8B5 =
},
+       [ATHOS_LUT_CHAN_668875_IDX] =3D { 26755, 0x1, 0x6F, 0xF5555, 0x8B6 =
},
+       [ATHOS_LUT_CHAN_669000_IDX] =3D { 26760, 0x1, 0x6F, 0x100000, 0x8B6=
 },
+       [ATHOS_LUT_CHAN_669125_IDX] =3D { 26765, 0x1, 0x6F, 0x10AAAB, 0x8B6=
 },
+       [ATHOS_LUT_CHAN_669250_IDX] =3D { 26770, 0x1, 0x6F, 0x115555, 0x8B7=
 },
+       [ATHOS_LUT_CHAN_669375_IDX] =3D { 26775, 0x1, 0x6F, 0x120000, 0x8B7=
 },
+       [ATHOS_LUT_CHAN_669500_IDX] =3D { 26780, 0x1, 0x6F, 0x12AAAB, 0x8B8=
 },
+       [ATHOS_LUT_CHAN_669625_IDX] =3D { 26785, 0x1, 0x6F, 0x135555, 0x8B8=
 },
+       [ATHOS_LUT_CHAN_669750_IDX] =3D { 26790, 0x1, 0x6F, 0x140000, 0x8B9=
 },
+       [ATHOS_LUT_CHAN_669875_IDX] =3D { 26795, 0x1, 0x6F, 0x14AAAB, 0x8B9=
 },
+       [ATHOS_LUT_CHAN_670000_IDX] =3D { 26800, 0x1, 0x6F, 0x155555, 0x8B9=
 },
+       [ATHOS_LUT_CHAN_670125_IDX] =3D { 26805, 0x1, 0x6F, 0x160000, 0x8BA=
 },
+       [ATHOS_LUT_CHAN_670250_IDX] =3D { 26810, 0x1, 0x6F, 0x16AAAB, 0x8BA=
 },
+       [ATHOS_LUT_CHAN_670375_IDX] =3D { 26815, 0x1, 0x6F, 0x175555, 0x8BB=
 },
+       [ATHOS_LUT_CHAN_670500_IDX] =3D { 26820, 0x1, 0x6F, 0x180000, 0x8BB=
 },
+       [ATHOS_LUT_CHAN_670625_IDX] =3D { 26825, 0x1, 0x6F, 0x18AAAB, 0x8BB=
 },
+       [ATHOS_LUT_CHAN_670750_IDX] =3D { 26830, 0x1, 0x6F, 0x195555, 0x8BC=
 },
+       [ATHOS_LUT_CHAN_670875_IDX] =3D { 26835, 0x1, 0x6F, 0x1A0000, 0x8BC=
 },
+       [ATHOS_LUT_CHAN_671000_IDX] =3D { 26840, 0x1, 0x6F, 0x1AAAAB, 0x8BD=
 },
+       [ATHOS_LUT_CHAN_671125_IDX] =3D { 26845, 0x1, 0x6F, 0x1B5555, 0x8BD=
 },
+       [ATHOS_LUT_CHAN_671250_IDX] =3D { 26850, 0x1, 0x6F, 0x1C0000, 0x8BE=
 },
+       [ATHOS_LUT_CHAN_671375_IDX] =3D { 26855, 0x1, 0x6F, 0x1CAAAB, 0x8BE=
 },
+       [ATHOS_LUT_CHAN_671500_IDX] =3D { 26860, 0x1, 0x6F, 0x1D5555, 0x8BE=
 },
+       [ATHOS_LUT_CHAN_671625_IDX] =3D { 26865, 0x1, 0x6F, 0x1E0000, 0x8BF=
 },
+       [ATHOS_LUT_CHAN_671750_IDX] =3D { 26870, 0x1, 0x6F, 0x1EAAAB, 0x8BF=
 },
+       [ATHOS_LUT_CHAN_671875_IDX] =3D { 26875, 0x1, 0x6F, 0x1F5555, 0x8C0=
 },
+       [ATHOS_LUT_CHAN_672000_IDX] =3D { 26880, 0x1, 0x70, 0x0, 0x8C0 },
+       [ATHOS_LUT_CHAN_672125_IDX] =3D { 26885, 0x1, 0x70, 0xAAAB, 0x8C0 }=
,
+       [ATHOS_LUT_CHAN_672250_IDX] =3D { 26890, 0x1, 0x70, 0x15555, 0x8C1 =
},
+       [ATHOS_LUT_CHAN_672375_IDX] =3D { 26895, 0x1, 0x70, 0x20000, 0x8C1 =
},
+       [ATHOS_LUT_CHAN_672500_IDX] =3D { 26900, 0x1, 0x70, 0x2AAAB, 0x8C2 =
},
+       [ATHOS_LUT_CHAN_672625_IDX] =3D { 26905, 0x1, 0x70, 0x35555, 0x8C2 =
},
+       [ATHOS_LUT_CHAN_672750_IDX] =3D { 26910, 0x1, 0x70, 0x40000, 0x8C3 =
},
+       [ATHOS_LUT_CHAN_672875_IDX] =3D { 26915, 0x1, 0x70, 0x4AAAB, 0x8C3 =
},
+       [ATHOS_LUT_CHAN_673000_IDX] =3D { 26920, 0x1, 0x70, 0x55555, 0x8C3 =
},
+       [ATHOS_LUT_CHAN_673125_IDX] =3D { 26925, 0x1, 0x70, 0x60000, 0x8C4 =
},
+       [ATHOS_LUT_CHAN_673250_IDX] =3D { 26930, 0x1, 0x70, 0x6AAAB, 0x8C4 =
},
+       [ATHOS_LUT_CHAN_673375_IDX] =3D { 26935, 0x1, 0x70, 0x75555, 0x8C5 =
},
+       [ATHOS_LUT_CHAN_673500_IDX] =3D { 26940, 0x1, 0x70, 0x80000, 0x8C5 =
},
+       [ATHOS_LUT_CHAN_673625_IDX] =3D { 26945, 0x1, 0x70, 0x8AAAB, 0x8C5 =
},
+       [ATHOS_LUT_CHAN_673750_IDX] =3D { 26950, 0x1, 0x70, 0x95555, 0x8C6 =
},
+       [ATHOS_LUT_CHAN_673875_IDX] =3D { 26955, 0x1, 0x70, 0xA0000, 0x8C6 =
},
+       [ATHOS_LUT_CHAN_674000_IDX] =3D { 26960, 0x1, 0x70, 0xAAAAB, 0x8C7 =
},
+       [ATHOS_LUT_CHAN_674125_IDX] =3D { 26965, 0x1, 0x70, 0xB5555, 0x8C7 =
},
+       [ATHOS_LUT_CHAN_674250_IDX] =3D { 26970, 0x1, 0x70, 0xC0000, 0x8C8 =
},
+       [ATHOS_LUT_CHAN_674375_IDX] =3D { 26975, 0x1, 0x70, 0xCAAAB, 0x8C8 =
},
+       [ATHOS_LUT_CHAN_674500_IDX] =3D { 26980, 0x1, 0x70, 0xD5555, 0x8C8 =
},
+       [ATHOS_LUT_CHAN_674625_IDX] =3D { 26985, 0x1, 0x70, 0xE0000, 0x8C9 =
},
+       [ATHOS_LUT_CHAN_674750_IDX] =3D { 26990, 0x1, 0x70, 0xEAAAB, 0x8C9 =
},
+       [ATHOS_LUT_CHAN_674875_IDX] =3D { 26995, 0x1, 0x70, 0xF5555, 0x8CA =
},
+       [ATHOS_LUT_CHAN_675000_IDX] =3D { 27000, 0x1, 0x70, 0x100000, 0x8CA=
 },
+       [ATHOS_LUT_CHAN_675125_IDX] =3D { 27005, 0x1, 0x70, 0x10AAAB, 0x8CA=
 },
+       [ATHOS_LUT_CHAN_675250_IDX] =3D { 27010, 0x1, 0x70, 0x115555, 0x8CB=
 },
+       [ATHOS_LUT_CHAN_675375_IDX] =3D { 27015, 0x1, 0x70, 0x120000, 0x8CB=
 },
+       [ATHOS_LUT_CHAN_675500_IDX] =3D { 27020, 0x1, 0x70, 0x12AAAB, 0x8CC=
 },
+       [ATHOS_LUT_CHAN_675625_IDX] =3D { 27025, 0x1, 0x70, 0x135555, 0x8CC=
 },
+       [ATHOS_LUT_CHAN_675750_IDX] =3D { 27030, 0x1, 0x70, 0x140000, 0x8CD=
 },
+       [ATHOS_LUT_CHAN_675875_IDX] =3D { 27035, 0x1, 0x70, 0x14AAAB, 0x8CD=
 },
+       [ATHOS_LUT_CHAN_676000_IDX] =3D { 27040, 0x1, 0x70, 0x155555, 0x8CD=
 },
+       [ATHOS_LUT_CHAN_676125_IDX] =3D { 27045, 0x1, 0x70, 0x160000, 0x8CE=
 },
+       [ATHOS_LUT_CHAN_676250_IDX] =3D { 27050, 0x1, 0x70, 0x16AAAB, 0x8CE=
 },
+       [ATHOS_LUT_CHAN_676375_IDX] =3D { 27055, 0x1, 0x70, 0x175555, 0x8CF=
 },
+       [ATHOS_LUT_CHAN_676500_IDX] =3D { 27060, 0x1, 0x70, 0x180000, 0x8CF=
 },
+       [ATHOS_LUT_CHAN_676625_IDX] =3D { 27065, 0x1, 0x70, 0x18AAAB, 0x8CF=
 },
+       [ATHOS_LUT_CHAN_676750_IDX] =3D { 27070, 0x1, 0x70, 0x195555, 0x8D0=
 },
+       [ATHOS_LUT_CHAN_676875_IDX] =3D { 27075, 0x1, 0x70, 0x1A0000, 0x8D0=
 },
+       [ATHOS_LUT_CHAN_677000_IDX] =3D { 27080, 0x1, 0x70, 0x1AAAAB, 0x8D1=
 },
+       [ATHOS_LUT_CHAN_677125_IDX] =3D { 27085, 0x1, 0x70, 0x1B5555, 0x8D1=
 },
+       [ATHOS_LUT_CHAN_677250_IDX] =3D { 27090, 0x1, 0x70, 0x1C0000, 0x8D2=
 },
+       [ATHOS_LUT_CHAN_677375_IDX] =3D { 27095, 0x1, 0x70, 0x1CAAAB, 0x8D2=
 },
+       [ATHOS_LUT_CHAN_677500_IDX] =3D { 27100, 0x1, 0x70, 0x1D5555, 0x8D2=
 },
+       [ATHOS_LUT_CHAN_677625_IDX] =3D { 27105, 0x1, 0x70, 0x1E0000, 0x8D3=
 },
+       [ATHOS_LUT_CHAN_677750_IDX] =3D { 27110, 0x1, 0x70, 0x1EAAAB, 0x8D3=
 },
+       [ATHOS_LUT_CHAN_677875_IDX] =3D { 27115, 0x1, 0x70, 0x1F5555, 0x8D4=
 },
+       [ATHOS_LUT_CHAN_678000_IDX] =3D { 27120, 0x1, 0x71, 0x0, 0x8D4 },
+       [ATHOS_LUT_CHAN_678125_IDX] =3D { 27125, 0x1, 0x71, 0xAAAB, 0x8D4 }=
,
+       [ATHOS_LUT_CHAN_678250_IDX] =3D { 27130, 0x1, 0x71, 0x15555, 0x8D5 =
},
+       [ATHOS_LUT_CHAN_678375_IDX] =3D { 27135, 0x1, 0x71, 0x20000, 0x8D5 =
},
+       [ATHOS_LUT_CHAN_678500_IDX] =3D { 27140, 0x1, 0x71, 0x2AAAB, 0x8D6 =
},
+       [ATHOS_LUT_CHAN_678625_IDX] =3D { 27145, 0x1, 0x71, 0x35555, 0x8D6 =
},
+       [ATHOS_LUT_CHAN_678750_IDX] =3D { 27150, 0x1, 0x71, 0x40000, 0x8D7 =
},
+       [ATHOS_LUT_CHAN_678875_IDX] =3D { 27155, 0x1, 0x71, 0x4AAAB, 0x8D7 =
},
+       [ATHOS_LUT_CHAN_679000_IDX] =3D { 27160, 0x1, 0x71, 0x55555, 0x8D7 =
},
+       [ATHOS_LUT_CHAN_679125_IDX] =3D { 27165, 0x1, 0x71, 0x60000, 0x8D8 =
},
+       [ATHOS_LUT_CHAN_679250_IDX] =3D { 27170, 0x1, 0x71, 0x6AAAB, 0x8D8 =
},
+       [ATHOS_LUT_CHAN_679375_IDX] =3D { 27175, 0x1, 0x71, 0x75555, 0x8D9 =
},
+       [ATHOS_LUT_CHAN_679500_IDX] =3D { 27180, 0x1, 0x71, 0x80000, 0x8D9 =
},
+       [ATHOS_LUT_CHAN_679625_IDX] =3D { 27185, 0x1, 0x71, 0x8AAAB, 0x8D9 =
},
+       [ATHOS_LUT_CHAN_679750_IDX] =3D { 27190, 0x1, 0x71, 0x95555, 0x8DA =
},
+       [ATHOS_LUT_CHAN_679875_IDX] =3D { 27195, 0x1, 0x71, 0xA0000, 0x8DA =
},
+       [ATHOS_LUT_CHAN_680000_IDX] =3D { 27200, 0x1, 0x71, 0xAAAAB, 0x8DB =
},
+       [ATHOS_LUT_CHAN_680125_IDX] =3D { 27205, 0x1, 0x71, 0xB5555, 0x8DB =
},
+       [ATHOS_LUT_CHAN_680250_IDX] =3D { 27210, 0x1, 0x71, 0xC0000, 0x8DC =
},
+       [ATHOS_LUT_CHAN_680375_IDX] =3D { 27215, 0x1, 0x71, 0xCAAAB, 0x8DC =
},
+       [ATHOS_LUT_CHAN_680500_IDX] =3D { 27220, 0x1, 0x71, 0xD5555, 0x8DC =
},
+       [ATHOS_LUT_CHAN_680625_IDX] =3D { 27225, 0x1, 0x71, 0xE0000, 0x8DD =
},
+       [ATHOS_LUT_CHAN_680750_IDX] =3D { 27230, 0x1, 0x71, 0xEAAAB, 0x8DD =
},
+       [ATHOS_LUT_CHAN_680875_IDX] =3D { 27235, 0x1, 0x71, 0xF5555, 0x8DE =
},
+       [ATHOS_LUT_CHAN_681000_IDX] =3D { 27240, 0x1, 0x71, 0x100000, 0x8DE=
 },
+       [ATHOS_LUT_CHAN_681125_IDX] =3D { 27245, 0x1, 0x71, 0x10AAAB, 0x8DE=
 },
+       [ATHOS_LUT_CHAN_681250_IDX] =3D { 27250, 0x1, 0x71, 0x115555, 0x8DF=
 },
+       [ATHOS_LUT_CHAN_681375_IDX] =3D { 27255, 0x1, 0x71, 0x120000, 0x8DF=
 },
+       [ATHOS_LUT_CHAN_681500_IDX] =3D { 27260, 0x1, 0x71, 0x12AAAB, 0x8E0=
 },
+       [ATHOS_LUT_CHAN_681625_IDX] =3D { 27265, 0x1, 0x71, 0x135555, 0x8E0=
 },
+       [ATHOS_LUT_CHAN_681750_IDX] =3D { 27270, 0x1, 0x71, 0x140000, 0x8E1=
 },
+       [ATHOS_LUT_CHAN_681875_IDX] =3D { 27275, 0x1, 0x71, 0x14AAAB, 0x8E1=
 },
+       [ATHOS_LUT_CHAN_682000_IDX] =3D { 27280, 0x1, 0x71, 0x155555, 0x8E1=
 },
+       [ATHOS_LUT_CHAN_682125_IDX] =3D { 27285, 0x1, 0x71, 0x160000, 0x8E2=
 },
+       [ATHOS_LUT_CHAN_682250_IDX] =3D { 27290, 0x1, 0x71, 0x16AAAB, 0x8E2=
 },
+       [ATHOS_LUT_CHAN_682375_IDX] =3D { 27295, 0x1, 0x71, 0x175555, 0x8E3=
 },
+       [ATHOS_LUT_CHAN_682500_IDX] =3D { 27300, 0x1, 0x71, 0x180000, 0x8E3=
 },
+       [ATHOS_LUT_CHAN_682625_IDX] =3D { 27305, 0x1, 0x71, 0x18AAAB, 0x8E3=
 },
+       [ATHOS_LUT_CHAN_682750_IDX] =3D { 27310, 0x1, 0x71, 0x195555, 0x8E4=
 },
+       [ATHOS_LUT_CHAN_682875_IDX] =3D { 27315, 0x1, 0x71, 0x1A0000, 0x8E4=
 },
+       [ATHOS_LUT_CHAN_683000_IDX] =3D { 27320, 0x1, 0x71, 0x1AAAAB, 0x8E5=
 },
+       [ATHOS_LUT_CHAN_683125_IDX] =3D { 27325, 0x1, 0x71, 0x1B5555, 0x8E5=
 },
+       [ATHOS_LUT_CHAN_683250_IDX] =3D { 27330, 0x1, 0x71, 0x1C0000, 0x8E6=
 },
+       [ATHOS_LUT_CHAN_683375_IDX] =3D { 27335, 0x1, 0x71, 0x1CAAAB, 0x8E6=
 },
+       [ATHOS_LUT_CHAN_683500_IDX] =3D { 27340, 0x1, 0x71, 0x1D5555, 0x8E6=
 },
+       [ATHOS_LUT_CHAN_683625_IDX] =3D { 27345, 0x1, 0x71, 0x1E0000, 0x8E7=
 },
+       [ATHOS_LUT_CHAN_683750_IDX] =3D { 27350, 0x1, 0x71, 0x1EAAAB, 0x8E7=
 },
+       [ATHOS_LUT_CHAN_683875_IDX] =3D { 27355, 0x1, 0x71, 0x1F5555, 0x8E8=
 },
+       [ATHOS_LUT_CHAN_684000_IDX] =3D { 27360, 0x1, 0x72, 0x0, 0x8E8 },
+       [ATHOS_LUT_CHAN_684125_IDX] =3D { 27365, 0x1, 0x72, 0xAAAB, 0x8E8 }=
,
+       [ATHOS_LUT_CHAN_684250_IDX] =3D { 27370, 0x1, 0x72, 0x15555, 0x8E9 =
},
+       [ATHOS_LUT_CHAN_684375_IDX] =3D { 27375, 0x1, 0x72, 0x20000, 0x8E9 =
},
+       [ATHOS_LUT_CHAN_684500_IDX] =3D { 27380, 0x1, 0x72, 0x2AAAB, 0x8EA =
},
+       [ATHOS_LUT_CHAN_684625_IDX] =3D { 27385, 0x1, 0x72, 0x35555, 0x8EA =
},
+       [ATHOS_LUT_CHAN_684750_IDX] =3D { 27390, 0x1, 0x72, 0x40000, 0x8EB =
},
+       [ATHOS_LUT_CHAN_684875_IDX] =3D { 27395, 0x1, 0x72, 0x4AAAB, 0x8EB =
},
+       [ATHOS_LUT_CHAN_685000_IDX] =3D { 27400, 0x1, 0x72, 0x55555, 0x8EB =
},
+       [ATHOS_LUT_CHAN_685125_IDX] =3D { 27405, 0x1, 0x72, 0x60000, 0x8EC =
},
+       [ATHOS_LUT_CHAN_685250_IDX] =3D { 27410, 0x1, 0x72, 0x6AAAB, 0x8EC =
},
+       [ATHOS_LUT_CHAN_685375_IDX] =3D { 27415, 0x1, 0x72, 0x75555, 0x8ED =
},
+       [ATHOS_LUT_CHAN_685500_IDX] =3D { 27420, 0x1, 0x72, 0x80000, 0x8ED =
},
+       [ATHOS_LUT_CHAN_685625_IDX] =3D { 27425, 0x1, 0x72, 0x8AAAB, 0x8ED =
},
+       [ATHOS_LUT_CHAN_685750_IDX] =3D { 27430, 0x1, 0x72, 0x95555, 0x8EE =
},
+       [ATHOS_LUT_CHAN_685875_IDX] =3D { 27435, 0x1, 0x72, 0xA0000, 0x8EE =
},
+       [ATHOS_LUT_CHAN_686000_IDX] =3D { 27440, 0x1, 0x72, 0xAAAAB, 0x8EF =
},
+       [ATHOS_LUT_CHAN_686125_IDX] =3D { 27445, 0x1, 0x72, 0xB5555, 0x8EF =
},
+       [ATHOS_LUT_CHAN_686250_IDX] =3D { 27450, 0x1, 0x72, 0xC0000, 0x8F0 =
},
+       [ATHOS_LUT_CHAN_686375_IDX] =3D { 27455, 0x1, 0x72, 0xCAAAB, 0x8F0 =
},
+       [ATHOS_LUT_CHAN_686500_IDX] =3D { 27460, 0x1, 0x72, 0xD5555, 0x8F0 =
},
+       [ATHOS_LUT_CHAN_686625_IDX] =3D { 27465, 0x1, 0x72, 0xE0000, 0x8F1 =
},
+       [ATHOS_LUT_CHAN_686750_IDX] =3D { 27470, 0x1, 0x72, 0xEAAAB, 0x8F1 =
},
+       [ATHOS_LUT_CHAN_686875_IDX] =3D { 27475, 0x1, 0x72, 0xF5555, 0x8F2 =
},
+       [ATHOS_LUT_CHAN_687000_IDX] =3D { 27480, 0x1, 0x72, 0x100000, 0x8F2=
 },
+       [ATHOS_LUT_CHAN_687125_IDX] =3D { 27485, 0x1, 0x72, 0x10AAAB, 0x8F2=
 },
+       [ATHOS_LUT_CHAN_687250_IDX] =3D { 27490, 0x1, 0x72, 0x115555, 0x8F3=
 },
+       [ATHOS_LUT_CHAN_687375_IDX] =3D { 27495, 0x1, 0x72, 0x120000, 0x8F3=
 },
+       [ATHOS_LUT_CHAN_687500_IDX] =3D { 27500, 0x1, 0x72, 0x12AAAB, 0x8F4=
 },
+       [ATHOS_LUT_CHAN_687625_IDX] =3D { 27505, 0x1, 0x72, 0x135555, 0x8F4=
 },
+       [ATHOS_LUT_CHAN_687750_IDX] =3D { 27510, 0x1, 0x72, 0x140000, 0x8F5=
 },
+       [ATHOS_LUT_CHAN_687875_IDX] =3D { 27515, 0x1, 0x72, 0x14AAAB, 0x8F5=
 },
+       [ATHOS_LUT_CHAN_688000_IDX] =3D { 27520, 0x1, 0x72, 0x155555, 0x8F5=
 },
+       [ATHOS_LUT_CHAN_688125_IDX] =3D { 27525, 0x1, 0x72, 0x160000, 0x8F6=
 },
+       [ATHOS_LUT_CHAN_688250_IDX] =3D { 27530, 0x1, 0x72, 0x16AAAB, 0x8F6=
 },
+       [ATHOS_LUT_CHAN_688375_IDX] =3D { 27535, 0x1, 0x72, 0x175555, 0x8F7=
 },
+       [ATHOS_LUT_CHAN_688500_IDX] =3D { 27540, 0x1, 0x72, 0x180000, 0x8F7=
 },
+       [ATHOS_LUT_CHAN_688625_IDX] =3D { 27545, 0x1, 0x72, 0x18AAAB, 0x8F7=
 },
+       [ATHOS_LUT_CHAN_688750_IDX] =3D { 27550, 0x1, 0x72, 0x195555, 0x8F8=
 },
+       [ATHOS_LUT_CHAN_688875_IDX] =3D { 27555, 0x1, 0x72, 0x1A0000, 0x8F8=
 },
+       [ATHOS_LUT_CHAN_689000_IDX] =3D { 27560, 0x1, 0x72, 0x1AAAAB, 0x8F9=
 },
+       [ATHOS_LUT_CHAN_689125_IDX] =3D { 27565, 0x1, 0x72, 0x1B5555, 0x8F9=
 },
+       [ATHOS_LUT_CHAN_689250_IDX] =3D { 27570, 0x1, 0x72, 0x1C0000, 0x8FA=
 },
+       [ATHOS_LUT_CHAN_689375_IDX] =3D { 27575, 0x1, 0x72, 0x1CAAAB, 0x8FA=
 },
+       [ATHOS_LUT_CHAN_689500_IDX] =3D { 27580, 0x1, 0x72, 0x1D5555, 0x8FA=
 },
+       [ATHOS_LUT_CHAN_689625_IDX] =3D { 27585, 0x1, 0x72, 0x1E0000, 0x8FB=
 },
+       [ATHOS_LUT_CHAN_689750_IDX] =3D { 27590, 0x1, 0x72, 0x1EAAAB, 0x8FB=
 },
+       [ATHOS_LUT_CHAN_689875_IDX] =3D { 27595, 0x1, 0x72, 0x1F5555, 0x8FC=
 },
+       [ATHOS_LUT_CHAN_690000_IDX] =3D { 27600, 0x1, 0x73, 0x0, 0x8FC },
+       [ATHOS_LUT_CHAN_690125_IDX] =3D { 27605, 0x1, 0x73, 0xAAAB, 0x8FC }=
,
+       [ATHOS_LUT_CHAN_690250_IDX] =3D { 27610, 0x1, 0x73, 0x15555, 0x8FD =
},
+       [ATHOS_LUT_CHAN_690375_IDX] =3D { 27615, 0x1, 0x73, 0x20000, 0x8FD =
},
+       [ATHOS_LUT_CHAN_690500_IDX] =3D { 27620, 0x1, 0x73, 0x2AAAB, 0x8FE =
},
+       [ATHOS_LUT_CHAN_690625_IDX] =3D { 27625, 0x1, 0x73, 0x35555, 0x8FE =
},
+       [ATHOS_LUT_CHAN_690750_IDX] =3D { 27630, 0x1, 0x73, 0x40000, 0x8FF =
},
+       [ATHOS_LUT_CHAN_690875_IDX] =3D { 27635, 0x1, 0x73, 0x4AAAB, 0x8FF =
},
+       [ATHOS_LUT_CHAN_691000_IDX] =3D { 27640, 0x1, 0x73, 0x55555, 0x8FF =
},
+       [ATHOS_LUT_CHAN_691125_IDX] =3D { 27645, 0x1, 0x73, 0x60000, 0x900 =
},
+       [ATHOS_LUT_CHAN_691250_IDX] =3D { 27650, 0x1, 0x73, 0x6AAAB, 0x900 =
},
+       [ATHOS_LUT_CHAN_691375_IDX] =3D { 27655, 0x1, 0x73, 0x75555, 0x901 =
},
+       [ATHOS_LUT_CHAN_691500_IDX] =3D { 27660, 0x1, 0x73, 0x80000, 0x901 =
},
+       [ATHOS_LUT_CHAN_691625_IDX] =3D { 27665, 0x1, 0x73, 0x8AAAB, 0x901 =
},
+       [ATHOS_LUT_CHAN_691750_IDX] =3D { 27670, 0x1, 0x73, 0x95555, 0x902 =
},
+       [ATHOS_LUT_CHAN_691875_IDX] =3D { 27675, 0x1, 0x73, 0xA0000, 0x902 =
},
+       [ATHOS_LUT_CHAN_692000_IDX] =3D { 27680, 0x1, 0x73, 0xAAAAB, 0x903 =
},
+       [ATHOS_LUT_CHAN_692125_IDX] =3D { 27685, 0x1, 0x73, 0xB5555, 0x903 =
},
+       [ATHOS_LUT_CHAN_692250_IDX] =3D { 27690, 0x1, 0x73, 0xC0000, 0x904 =
},
+       [ATHOS_LUT_CHAN_692375_IDX] =3D { 27695, 0x1, 0x73, 0xCAAAB, 0x904 =
},
+       [ATHOS_LUT_CHAN_692500_IDX] =3D { 27700, 0x1, 0x73, 0xD5555, 0x904 =
},
+       [ATHOS_LUT_CHAN_692625_IDX] =3D { 27705, 0x1, 0x73, 0xE0000, 0x905 =
},
+       [ATHOS_LUT_CHAN_692750_IDX] =3D { 27710, 0x1, 0x73, 0xEAAAB, 0x905 =
},
+       [ATHOS_LUT_CHAN_692875_IDX] =3D { 27715, 0x1, 0x73, 0xF5555, 0x906 =
},
+       [ATHOS_LUT_CHAN_693000_IDX] =3D { 27720, 0x1, 0x73, 0x100000, 0x906=
 },
+       [ATHOS_LUT_CHAN_693125_IDX] =3D { 27725, 0x1, 0x73, 0x10AAAB, 0x906=
 },
+       [ATHOS_LUT_CHAN_693250_IDX] =3D { 27730, 0x1, 0x73, 0x115555, 0x907=
 },
+       [ATHOS_LUT_CHAN_693375_IDX] =3D { 27735, 0x1, 0x73, 0x120000, 0x907=
 },
+       [ATHOS_LUT_CHAN_693500_IDX] =3D { 27740, 0x1, 0x73, 0x12AAAB, 0x908=
 },
+       [ATHOS_LUT_CHAN_693625_IDX] =3D { 27745, 0x1, 0x73, 0x135555, 0x908=
 },
+       [ATHOS_LUT_CHAN_693750_IDX] =3D { 27750, 0x1, 0x73, 0x140000, 0x909=
 },
+       [ATHOS_LUT_CHAN_693875_IDX] =3D { 27755, 0x1, 0x73, 0x14AAAB, 0x909=
 },
+       [ATHOS_LUT_CHAN_694000_IDX] =3D { 27760, 0x1, 0x73, 0x155555, 0x909=
 },
+       [ATHOS_LUT_CHAN_694125_IDX] =3D { 27765, 0x1, 0x73, 0x160000, 0x90A=
 },
+       [ATHOS_LUT_CHAN_694250_IDX] =3D { 27770, 0x1, 0x73, 0x16AAAB, 0x90A=
 },
+       [ATHOS_LUT_CHAN_694375_IDX] =3D { 27775, 0x1, 0x73, 0x175555, 0x90B=
 },
+       [ATHOS_LUT_CHAN_694500_IDX] =3D { 27780, 0x1, 0x73, 0x180000, 0x90B=
 },
+       [ATHOS_LUT_CHAN_694625_IDX] =3D { 27785, 0x1, 0x73, 0x18AAAB, 0x90B=
 },
+       [ATHOS_LUT_CHAN_694750_IDX] =3D { 27790, 0x1, 0x73, 0x195555, 0x90C=
 },
+       [ATHOS_LUT_CHAN_694875_IDX] =3D { 27795, 0x1, 0x73, 0x1A0000, 0x90C=
 },
+       [ATHOS_LUT_CHAN_695000_IDX] =3D { 27800, 0x1, 0x73, 0x1AAAAB, 0x90D=
 },
+       [ATHOS_LUT_CHAN_695125_IDX] =3D { 27805, 0x1, 0x73, 0x1B5555, 0x90D=
 },
+       [ATHOS_LUT_CHAN_695250_IDX] =3D { 27810, 0x1, 0x73, 0x1C0000, 0x90E=
 },
+       [ATHOS_LUT_CHAN_695375_IDX] =3D { 27815, 0x1, 0x73, 0x1CAAAB, 0x90E=
 },
+       [ATHOS_LUT_CHAN_695500_IDX] =3D { 27820, 0x1, 0x73, 0x1D5555, 0x90E=
 },
+       [ATHOS_LUT_CHAN_695625_IDX] =3D { 27825, 0x1, 0x73, 0x1E0000, 0x90F=
 },
+       [ATHOS_LUT_CHAN_695750_IDX] =3D { 27830, 0x1, 0x73, 0x1EAAAB, 0x90F=
 },
+       [ATHOS_LUT_CHAN_695875_IDX] =3D { 27835, 0x1, 0x73, 0x1F5555, 0x910=
 },
+       [ATHOS_LUT_CHAN_696000_IDX] =3D { 27840, 0x1, 0x74, 0x0, 0x910 },
+       [ATHOS_LUT_CHAN_696125_IDX] =3D { 27845, 0x1, 0x74, 0xAAAB, 0x910 }=
,
+       [ATHOS_LUT_CHAN_696250_IDX] =3D { 27850, 0x1, 0x74, 0x15555, 0x911 =
},
+       [ATHOS_LUT_CHAN_696375_IDX] =3D { 27855, 0x1, 0x74, 0x20000, 0x911 =
},
+       [ATHOS_LUT_CHAN_696500_IDX] =3D { 27860, 0x1, 0x74, 0x2AAAB, 0x912 =
},
+       [ATHOS_LUT_CHAN_696625_IDX] =3D { 27865, 0x1, 0x74, 0x35555, 0x912 =
},
+       [ATHOS_LUT_CHAN_696750_IDX] =3D { 27870, 0x1, 0x74, 0x40000, 0x913 =
},
+       [ATHOS_LUT_CHAN_696875_IDX] =3D { 27875, 0x1, 0x74, 0x4AAAB, 0x913 =
},
+       [ATHOS_LUT_CHAN_697000_IDX] =3D { 27880, 0x1, 0x74, 0x55555, 0x913 =
},
+       [ATHOS_LUT_CHAN_697125_IDX] =3D { 27885, 0x1, 0x74, 0x60000, 0x914 =
},
+       [ATHOS_LUT_CHAN_697250_IDX] =3D { 27890, 0x1, 0x74, 0x6AAAB, 0x914 =
},
+       [ATHOS_LUT_CHAN_697375_IDX] =3D { 27895, 0x1, 0x74, 0x75555, 0x915 =
},
+       [ATHOS_LUT_CHAN_697500_IDX] =3D { 27900, 0x1, 0x74, 0x80000, 0x915 =
},
+       [ATHOS_LUT_CHAN_697625_IDX] =3D { 27905, 0x1, 0x74, 0x8AAAB, 0x915 =
},
+       [ATHOS_LUT_CHAN_697750_IDX] =3D { 27910, 0x1, 0x74, 0x95555, 0x916 =
},
+       [ATHOS_LUT_CHAN_697875_IDX] =3D { 27915, 0x1, 0x74, 0xA0000, 0x916 =
},
+       [ATHOS_LUT_CHAN_698000_IDX] =3D { 27920, 0x1, 0x74, 0xAAAAB, 0x917 =
},
+       [ATHOS_LUT_CHAN_698125_IDX] =3D { 27925, 0x1, 0x74, 0xB5555, 0x917 =
},
+       [ATHOS_LUT_CHAN_698250_IDX] =3D { 27930, 0x1, 0x74, 0xC0000, 0x918 =
},
+       [ATHOS_LUT_CHAN_698375_IDX] =3D { 27935, 0x1, 0x74, 0xCAAAB, 0x918 =
},
+       [ATHOS_LUT_CHAN_698500_IDX] =3D { 27940, 0x1, 0x74, 0xD5555, 0x918 =
},
+       [ATHOS_LUT_CHAN_698625_IDX] =3D { 27945, 0x1, 0x74, 0xE0000, 0x919 =
},
+       [ATHOS_LUT_CHAN_698750_IDX] =3D { 27950, 0x1, 0x74, 0xEAAAB, 0x919 =
},
+       [ATHOS_LUT_CHAN_698875_IDX] =3D { 27955, 0x1, 0x74, 0xF5555, 0x91A =
},
+       [ATHOS_LUT_CHAN_699000_IDX] =3D { 27960, 0x1, 0x74, 0x100000, 0x91A=
 },
+       [ATHOS_LUT_CHAN_699125_IDX] =3D { 27965, 0x1, 0x74, 0x10AAAB, 0x91A=
 },
+       [ATHOS_LUT_CHAN_699250_IDX] =3D { 27970, 0x1, 0x74, 0x115555, 0x91B=
 },
+       [ATHOS_LUT_CHAN_699375_IDX] =3D { 27975, 0x1, 0x74, 0x120000, 0x91B=
 },
+       [ATHOS_LUT_CHAN_699500_IDX] =3D { 27980, 0x1, 0x74, 0x12AAAB, 0x91C=
 },
+       [ATHOS_LUT_CHAN_699625_IDX] =3D { 27985, 0x1, 0x74, 0x135555, 0x91C=
 },
+       [ATHOS_LUT_CHAN_699750_IDX] =3D { 27990, 0x1, 0x74, 0x140000, 0x91D=
 },
+       [ATHOS_LUT_CHAN_699875_IDX] =3D { 27995, 0x1, 0x74, 0x14AAAB, 0x91D=
 },
+       [ATHOS_LUT_CHAN_700000_IDX] =3D { 28000, 0x1, 0x74, 0x155555, 0x91D=
 },
+       [ATHOS_LUT_CHAN_700125_IDX] =3D { 28005, 0x1, 0x74, 0x160000, 0x91E=
 },
+       [ATHOS_LUT_CHAN_700250_IDX] =3D { 28010, 0x1, 0x74, 0x16AAAB, 0x91E=
 },
+       [ATHOS_LUT_CHAN_700375_IDX] =3D { 28015, 0x1, 0x74, 0x175555, 0x91F=
 },
+       [ATHOS_LUT_CHAN_700500_IDX] =3D { 28020, 0x1, 0x74, 0x180000, 0x91F=
 },
+       [ATHOS_LUT_CHAN_700625_IDX] =3D { 28025, 0x1, 0x74, 0x18AAAB, 0x91F=
 },
+       [ATHOS_LUT_CHAN_700750_IDX] =3D { 28030, 0x1, 0x74, 0x195555, 0x920=
 },
+       [ATHOS_LUT_CHAN_700875_IDX] =3D { 28035, 0x1, 0x74, 0x1A0000, 0x920=
 },
+       [ATHOS_LUT_CHAN_701000_IDX] =3D { 28040, 0x1, 0x74, 0x1AAAAB, 0x921=
 },
+       [ATHOS_LUT_CHAN_701125_IDX] =3D { 28045, 0x1, 0x74, 0x1B5555, 0x921=
 },
+       [ATHOS_LUT_CHAN_701250_IDX] =3D { 28050, 0x1, 0x74, 0x1C0000, 0x922=
 },
+       [ATHOS_LUT_CHAN_701375_IDX] =3D { 28055, 0x1, 0x74, 0x1CAAAB, 0x922=
 },
+       [ATHOS_LUT_CHAN_701500_IDX] =3D { 28060, 0x1, 0x74, 0x1D5555, 0x922=
 },
+       [ATHOS_LUT_CHAN_701625_IDX] =3D { 28065, 0x1, 0x74, 0x1E0000, 0x923=
 },
+       [ATHOS_LUT_CHAN_701750_IDX] =3D { 28070, 0x1, 0x74, 0x1EAAAB, 0x923=
 },
+       [ATHOS_LUT_CHAN_701875_IDX] =3D { 28075, 0x1, 0x74, 0x1F5555, 0x924=
 },
+       [ATHOS_LUT_CHAN_702000_IDX] =3D { 28080, 0x1, 0x75, 0x0, 0x924 },
+       [ATHOS_LUT_CHAN_702125_IDX] =3D { 28085, 0x1, 0x75, 0xAAAB, 0x924 }=
,
+       [ATHOS_LUT_CHAN_702250_IDX] =3D { 28090, 0x1, 0x75, 0x15555, 0x925 =
},
+       [ATHOS_LUT_CHAN_702375_IDX] =3D { 28095, 0x1, 0x75, 0x20000, 0x925 =
},
+       [ATHOS_LUT_CHAN_702500_IDX] =3D { 28100, 0x1, 0x75, 0x2AAAB, 0x926 =
},
+       [ATHOS_LUT_CHAN_702625_IDX] =3D { 28105, 0x1, 0x75, 0x35555, 0x926 =
},
+       [ATHOS_LUT_CHAN_702750_IDX] =3D { 28110, 0x1, 0x75, 0x40000, 0x927 =
},
+       [ATHOS_LUT_CHAN_702875_IDX] =3D { 28115, 0x1, 0x75, 0x4AAAB, 0x927 =
},
+       [ATHOS_LUT_CHAN_703000_IDX] =3D { 28120, 0x1, 0x75, 0x55555, 0x927 =
},
+       [ATHOS_LUT_CHAN_703125_IDX] =3D { 28125, 0x1, 0x75, 0x60000, 0x928 =
},
+       [ATHOS_LUT_CHAN_703250_IDX] =3D { 28130, 0x1, 0x75, 0x6AAAB, 0x928 =
},
+       [ATHOS_LUT_CHAN_703375_IDX] =3D { 28135, 0x1, 0x75, 0x75555, 0x929 =
},
+       [ATHOS_LUT_CHAN_703500_IDX] =3D { 28140, 0x1, 0x75, 0x80000, 0x929 =
},
+       [ATHOS_LUT_CHAN_703625_IDX] =3D { 28145, 0x1, 0x75, 0x8AAAB, 0x929 =
},
+       [ATHOS_LUT_CHAN_703750_IDX] =3D { 28150, 0x1, 0x75, 0x95555, 0x92A =
},
+       [ATHOS_LUT_CHAN_703875_IDX] =3D { 28155, 0x1, 0x75, 0xA0000, 0x92A =
},
+       [ATHOS_LUT_CHAN_704000_IDX] =3D { 28160, 0x1, 0x75, 0xAAAAB, 0x92B =
},
+       [ATHOS_LUT_CHAN_704125_IDX] =3D { 28165, 0x1, 0x75, 0xB5555, 0x92B =
},
+       [ATHOS_LUT_CHAN_704250_IDX] =3D { 28170, 0x1, 0x75, 0xC0000, 0x92C =
},
+       [ATHOS_LUT_CHAN_704375_IDX] =3D { 28175, 0x1, 0x75, 0xCAAAB, 0x92C =
},
+       [ATHOS_LUT_CHAN_704500_IDX] =3D { 28180, 0x1, 0x75, 0xD5555, 0x92C =
},
+       [ATHOS_LUT_CHAN_704625_IDX] =3D { 28185, 0x1, 0x75, 0xE0000, 0x92D =
},
+       [ATHOS_LUT_CHAN_704750_IDX] =3D { 28190, 0x1, 0x75, 0xEAAAB, 0x92D =
},
+       [ATHOS_LUT_CHAN_704875_IDX] =3D { 28195, 0x1, 0x75, 0xF5555, 0x92E =
},
+       [ATHOS_LUT_CHAN_705000_IDX] =3D { 28200, 0x1, 0x75, 0x100000, 0x92E=
 },
+       [ATHOS_LUT_CHAN_705125_IDX] =3D { 28205, 0x1, 0x75, 0x10AAAB, 0x92E=
 },
+       [ATHOS_LUT_CHAN_705250_IDX] =3D { 28210, 0x1, 0x75, 0x115555, 0x92F=
 },
+       [ATHOS_LUT_CHAN_705375_IDX] =3D { 28215, 0x1, 0x75, 0x120000, 0x92F=
 },
+       [ATHOS_LUT_CHAN_705500_IDX] =3D { 28220, 0x1, 0x75, 0x12AAAB, 0x930=
 },
+       [ATHOS_LUT_CHAN_705625_IDX] =3D { 28225, 0x1, 0x75, 0x135555, 0x930=
 },
+       [ATHOS_LUT_CHAN_705750_IDX] =3D { 28230, 0x1, 0x75, 0x140000, 0x931=
 },
+       [ATHOS_LUT_CHAN_705875_IDX] =3D { 28235, 0x1, 0x75, 0x14AAAB, 0x931=
 },
+       [ATHOS_LUT_CHAN_706000_IDX] =3D { 28240, 0x1, 0x75, 0x155555, 0x931=
 },
+       [ATHOS_LUT_CHAN_706125_IDX] =3D { 28245, 0x1, 0x75, 0x160000, 0x932=
 },
+       [ATHOS_LUT_CHAN_706250_IDX] =3D { 28250, 0x1, 0x75, 0x16AAAB, 0x932=
 },
+       [ATHOS_LUT_CHAN_706375_IDX] =3D { 28255, 0x1, 0x75, 0x175555, 0x933=
 },
+       [ATHOS_LUT_CHAN_706500_IDX] =3D { 28260, 0x1, 0x75, 0x180000, 0x933=
 },
+       [ATHOS_LUT_CHAN_706625_IDX] =3D { 28265, 0x1, 0x75, 0x18AAAB, 0x933=
 },
+       [ATHOS_LUT_CHAN_706750_IDX] =3D { 28270, 0x1, 0x75, 0x195555, 0x934=
 },
+       [ATHOS_LUT_CHAN_706875_IDX] =3D { 28275, 0x1, 0x75, 0x1A0000, 0x934=
 },
+       [ATHOS_LUT_CHAN_707000_IDX] =3D { 28280, 0x1, 0x75, 0x1AAAAB, 0x935=
 },
+       [ATHOS_LUT_CHAN_707125_IDX] =3D { 28285, 0x1, 0x75, 0x1B5555, 0x935=
 },
+       [ATHOS_LUT_CHAN_707250_IDX] =3D { 28290, 0x1, 0x75, 0x1C0000, 0x936=
 },
+       [ATHOS_LUT_CHAN_707375_IDX] =3D { 28295, 0x1, 0x75, 0x1CAAAB, 0x936=
 },
+       [ATHOS_LUT_CHAN_707500_IDX] =3D { 28300, 0x1, 0x75, 0x1D5555, 0x936=
 },
+       [ATHOS_LUT_CHAN_707625_IDX] =3D { 28305, 0x1, 0x75, 0x1E0000, 0x937=
 },
+       [ATHOS_LUT_CHAN_707750_IDX] =3D { 28310, 0x1, 0x75, 0x1EAAAB, 0x937=
 },
+       [ATHOS_LUT_CHAN_707875_IDX] =3D { 28315, 0x1, 0x75, 0x1F5555, 0x938=
 },
+       [ATHOS_LUT_CHAN_708000_IDX] =3D { 28320, 0x1, 0x76, 0x0, 0x938 },
+       [ATHOS_LUT_CHAN_708125_IDX] =3D { 28325, 0x1, 0x76, 0xAAAB, 0x938 }=
,
+       [ATHOS_LUT_CHAN_708250_IDX] =3D { 28330, 0x1, 0x76, 0x15555, 0x939 =
},
+       [ATHOS_LUT_CHAN_708375_IDX] =3D { 28335, 0x1, 0x76, 0x20000, 0x939 =
},
+       [ATHOS_LUT_CHAN_708500_IDX] =3D { 28340, 0x1, 0x76, 0x2AAAB, 0x93A =
},
+       [ATHOS_LUT_CHAN_708625_IDX] =3D { 28345, 0x1, 0x76, 0x35555, 0x93A =
},
+       [ATHOS_LUT_CHAN_708750_IDX] =3D { 28350, 0x1, 0x76, 0x40000, 0x93B =
},
+       [ATHOS_LUT_CHAN_708875_IDX] =3D { 28355, 0x1, 0x76, 0x4AAAB, 0x93B =
},
+       [ATHOS_LUT_CHAN_709000_IDX] =3D { 28360, 0x1, 0x76, 0x55555, 0x93B =
},
+       [ATHOS_LUT_CHAN_709125_IDX] =3D { 28365, 0x1, 0x76, 0x60000, 0x93C =
},
+       [ATHOS_LUT_CHAN_709250_IDX] =3D { 28370, 0x1, 0x76, 0x6AAAB, 0x93C =
},
+       [ATHOS_LUT_CHAN_709375_IDX] =3D { 28375, 0x1, 0x76, 0x75555, 0x93D =
},
+       [ATHOS_LUT_CHAN_709500_IDX] =3D { 28380, 0x1, 0x76, 0x80000, 0x93D =
},
+       [ATHOS_LUT_CHAN_709625_IDX] =3D { 28385, 0x1, 0x76, 0x8AAAB, 0x93D =
},
+       [ATHOS_LUT_CHAN_709750_IDX] =3D { 28390, 0x1, 0x76, 0x95555, 0x93E =
},
+       [ATHOS_LUT_CHAN_709875_IDX] =3D { 28395, 0x1, 0x76, 0xA0000, 0x93E =
},
+       [ATHOS_LUT_CHAN_710000_IDX] =3D { 28400, 0x1, 0x76, 0xAAAAB, 0x93F =
},
+       [ATHOS_LUT_CHAN_710125_IDX] =3D { 28405, 0x1, 0x76, 0xB5555, 0x93F =
},
+       [ATHOS_LUT_CHAN_710250_IDX] =3D { 28410, 0x1, 0x76, 0xC0000, 0x940 =
},
+       [ATHOS_LUT_CHAN_710375_IDX] =3D { 28415, 0x1, 0x76, 0xCAAAB, 0x940 =
},
+       [ATHOS_LUT_CHAN_710500_IDX] =3D { 28420, 0x1, 0x76, 0xD5555, 0x940 =
},
+       [ATHOS_LUT_CHAN_710625_IDX] =3D { 28425, 0x1, 0x76, 0xE0000, 0x941 =
},
+       [ATHOS_LUT_CHAN_710750_IDX] =3D { 28430, 0x1, 0x76, 0xEAAAB, 0x941 =
},
+       [ATHOS_LUT_CHAN_710875_IDX] =3D { 28435, 0x1, 0x76, 0xF5555, 0x942 =
},
+       [ATHOS_LUT_CHAN_711000_IDX] =3D { 28440, 0x1, 0x76, 0x100000, 0x942=
 },
+       [ATHOS_LUT_CHAN_711125_IDX] =3D { 28445, 0x1, 0x76, 0x10AAAB, 0x942=
 },
+       [ATHOS_LUT_CHAN_711250_IDX] =3D { 28450, 0x1, 0x76, 0x115555, 0x943=
 },
+       [ATHOS_LUT_CHAN_711375_IDX] =3D { 28455, 0x1, 0x76, 0x120000, 0x943=
 },
+       [ATHOS_LUT_CHAN_711500_IDX] =3D { 28460, 0x1, 0x76, 0x12AAAB, 0x944=
 },
+       [ATHOS_LUT_CHAN_711625_IDX] =3D { 28465, 0x1, 0x76, 0x135555, 0x944=
 },
+       [ATHOS_LUT_CHAN_711750_IDX] =3D { 28470, 0x1, 0x76, 0x140000, 0x945=
 },
+       [ATHOS_LUT_CHAN_711875_IDX] =3D { 28475, 0x1, 0x76, 0x14AAAB, 0x945=
 },
+       [ATHOS_LUT_CHAN_712000_IDX] =3D { 28480, 0x1, 0x76, 0x155555, 0x945=
 },
+       [ATHOS_LUT_CHAN_712125_IDX] =3D { 28485, 0x1, 0x76, 0x160000, 0x946=
 },
+       [ATHOS_LUT_CHAN_712250_IDX] =3D { 28490, 0x1, 0x76, 0x16AAAB, 0x946=
 },
+       [ATHOS_LUT_CHAN_712375_IDX] =3D { 28495, 0x1, 0x76, 0x175555, 0x947=
 },
+       [ATHOS_LUT_CHAN_712500_IDX] =3D { 28500, 0x1, 0x76, 0x180000, 0x947=
 },
+       [ATHOS_LUT_CHAN_712625_IDX] =3D { 28505, 0x1, 0x76, 0x18AAAB, 0x947=
 },
+       [ATHOS_LUT_CHAN_712750_IDX] =3D { 28510, 0x1, 0x76, 0x195555, 0x948=
 },
+       [ATHOS_LUT_CHAN_712875_IDX] =3D { 28515, 0x1, 0x76, 0x1A0000, 0x948=
 },
+       [ATHOS_LUT_CHAN_713000_IDX] =3D { 28520, 0x1, 0x76, 0x1AAAAB, 0x949=
 },
+       [ATHOS_LUT_CHAN_713125_IDX] =3D { 28525, 0x1, 0x76, 0x1B5555, 0x949=
 },
+       [ATHOS_LUT_CHAN_713250_IDX] =3D { 28530, 0x1, 0x76, 0x1C0000, 0x94A=
 },
+       [ATHOS_LUT_CHAN_713375_IDX] =3D { 28535, 0x1, 0x76, 0x1CAAAB, 0x94A=
 },
+       [ATHOS_LUT_CHAN_713500_IDX] =3D { 28540, 0x1, 0x76, 0x1D5555, 0x94A=
 },
+       [ATHOS_LUT_CHAN_713625_IDX] =3D { 28545, 0x1, 0x76, 0x1E0000, 0x94B=
 },
+       [ATHOS_LUT_CHAN_713750_IDX] =3D { 28550, 0x1, 0x76, 0x1EAAAB, 0x94B=
 },
+       [ATHOS_LUT_CHAN_713875_IDX] =3D { 28555, 0x1, 0x76, 0x1F5555, 0x94C=
 },
+       [ATHOS_LUT_CHAN_714000_IDX] =3D { 28560, 0x1, 0x77, 0x0, 0x94C },
+       [ATHOS_LUT_CHAN_714125_IDX] =3D { 28565, 0x1, 0x77, 0xAAAB, 0x94C }=
,
+       [ATHOS_LUT_CHAN_714250_IDX] =3D { 28570, 0x1, 0x77, 0x15555, 0x94D =
},
+       [ATHOS_LUT_CHAN_714375_IDX] =3D { 28575, 0x1, 0x77, 0x20000, 0x94D =
},
+       [ATHOS_LUT_CHAN_714500_IDX] =3D { 28580, 0x1, 0x77, 0x2AAAB, 0x94E =
},
+       [ATHOS_LUT_CHAN_714625_IDX] =3D { 28585, 0x1, 0x77, 0x35555, 0x94E =
},
+       [ATHOS_LUT_CHAN_714750_IDX] =3D { 28590, 0x1, 0x77, 0x40000, 0x94F =
},
+       [ATHOS_LUT_CHAN_714875_IDX] =3D { 28595, 0x1, 0x77, 0x4AAAB, 0x94F =
},
+       [ATHOS_LUT_CHAN_715000_IDX] =3D { 28600, 0x1, 0x77, 0x55555, 0x94F =
},
+       [ATHOS_LUT_CHAN_715125_IDX] =3D { 28605, 0x1, 0x77, 0x60000, 0x950 =
},
+       [ATHOS_LUT_CHAN_715250_IDX] =3D { 28610, 0x1, 0x77, 0x6AAAB, 0x950 =
},
+       [ATHOS_LUT_CHAN_715375_IDX] =3D { 28615, 0x1, 0x77, 0x75555, 0x951 =
},
+       [ATHOS_LUT_CHAN_715500_IDX] =3D { 28620, 0x1, 0x77, 0x80000, 0x951 =
},
+       [ATHOS_LUT_CHAN_715625_IDX] =3D { 28625, 0x1, 0x77, 0x8AAAB, 0x951 =
},
+       [ATHOS_LUT_CHAN_715750_IDX] =3D { 28630, 0x1, 0x77, 0x95555, 0x952 =
},
+       [ATHOS_LUT_CHAN_715875_IDX] =3D { 28635, 0x1, 0x77, 0xA0000, 0x952 =
},
+       [ATHOS_LUT_CHAN_716000_IDX] =3D { 28640, 0x1, 0x77, 0xAAAAB, 0x953 =
},
+       [ATHOS_LUT_CHAN_716125_IDX] =3D { 28645, 0x1, 0x77, 0xB5555, 0x953 =
},
+       [ATHOS_LUT_CHAN_716250_IDX] =3D { 28650, 0x1, 0x77, 0xC0000, 0x954 =
},
+       [ATHOS_LUT_CHAN_716375_IDX] =3D { 28655, 0x1, 0x77, 0xCAAAB, 0x954 =
},
+       [ATHOS_LUT_CHAN_716500_IDX] =3D { 28660, 0x1, 0x77, 0xD5555, 0x954 =
},
+       [ATHOS_LUT_CHAN_716625_IDX] =3D { 28665, 0x1, 0x77, 0xE0000, 0x955 =
},
+       [ATHOS_LUT_CHAN_716750_IDX] =3D { 28670, 0x1, 0x77, 0xEAAAB, 0x955 =
},
+       [ATHOS_LUT_CHAN_716875_IDX] =3D { 28675, 0x1, 0x77, 0xF5555, 0x956 =
},
+       [ATHOS_LUT_CHAN_717000_IDX] =3D { 28680, 0x1, 0x77, 0x100000, 0x956=
 },
+       [ATHOS_LUT_CHAN_717125_IDX] =3D { 28685, 0x1, 0x77, 0x10AAAB, 0x956=
 },
+       [ATHOS_LUT_CHAN_717250_IDX] =3D { 28690, 0x1, 0x77, 0x115555, 0x957=
 },
+       [ATHOS_LUT_CHAN_717375_IDX] =3D { 28695, 0x1, 0x77, 0x120000, 0x957=
 },
+       [ATHOS_LUT_CHAN_717500_IDX] =3D { 28700, 0x1, 0x77, 0x12AAAB, 0x958=
 },
+       [ATHOS_LUT_CHAN_717625_IDX] =3D { 28705, 0x1, 0x77, 0x135555, 0x958=
 },
+       [ATHOS_LUT_CHAN_717750_IDX] =3D { 28710, 0x1, 0x77, 0x140000, 0x959=
 },
+       [ATHOS_LUT_CHAN_717875_IDX] =3D { 28715, 0x1, 0x77, 0x14AAAB, 0x959=
 },
+       [ATHOS_LUT_CHAN_718000_IDX] =3D { 28720, 0x1, 0x77, 0x155555, 0x959=
 },
+       [ATHOS_LUT_CHAN_718125_IDX] =3D { 28725, 0x1, 0x77, 0x160000, 0x95A=
 },
+       [ATHOS_LUT_CHAN_718250_IDX] =3D { 28730, 0x1, 0x77, 0x16AAAB, 0x95A=
 },
+       [ATHOS_LUT_CHAN_718375_IDX] =3D { 28735, 0x1, 0x77, 0x175555, 0x95B=
 },
+       [ATHOS_LUT_CHAN_718500_IDX] =3D { 28740, 0x1, 0x77, 0x180000, 0x95B=
 },
+       [ATHOS_LUT_CHAN_718625_IDX] =3D { 28745, 0x1, 0x77, 0x18AAAB, 0x95B=
 },
+       [ATHOS_LUT_CHAN_718750_IDX] =3D { 28750, 0x1, 0x77, 0x195555, 0x95C=
 },
+       [ATHOS_LUT_CHAN_718875_IDX] =3D { 28755, 0x1, 0x77, 0x1A0000, 0x95C=
 },
+       [ATHOS_LUT_CHAN_719000_IDX] =3D { 28760, 0x1, 0x77, 0x1AAAAB, 0x95D=
 },
+       [ATHOS_LUT_CHAN_719125_IDX] =3D { 28765, 0x1, 0x77, 0x1B5555, 0x95D=
 },
+       [ATHOS_LUT_CHAN_719250_IDX] =3D { 28770, 0x1, 0x77, 0x1C0000, 0x95E=
 },
+       [ATHOS_LUT_CHAN_719375_IDX] =3D { 28775, 0x1, 0x77, 0x1CAAAB, 0x95E=
 },
+       [ATHOS_LUT_CHAN_719500_IDX] =3D { 28780, 0x1, 0x77, 0x1D5555, 0x95E=
 },
+       [ATHOS_LUT_CHAN_719625_IDX] =3D { 28785, 0x1, 0x77, 0x1E0000, 0x95F=
 },
+       [ATHOS_LUT_CHAN_719750_IDX] =3D { 28790, 0x1, 0x77, 0x1EAAAB, 0x95F=
 },
+       [ATHOS_LUT_CHAN_719875_IDX] =3D { 28795, 0x1, 0x77, 0x1F5555, 0x960=
 },
+       [ATHOS_LUT_CHAN_720000_IDX] =3D { 28800, 0x1, 0x78, 0x0, 0x960 },
+       [ATHOS_LUT_CHAN_720125_IDX] =3D { 28805, 0x1, 0x78, 0xAAAB, 0x960 }=
,
+       [ATHOS_LUT_CHAN_720250_IDX] =3D { 28810, 0x1, 0x78, 0x15555, 0x961 =
},
+       [ATHOS_LUT_CHAN_720375_IDX] =3D { 28815, 0x1, 0x78, 0x20000, 0x961 =
},
+       [ATHOS_LUT_CHAN_720500_IDX] =3D { 28820, 0x1, 0x78, 0x2AAAB, 0x962 =
},
+       [ATHOS_LUT_CHAN_720625_IDX] =3D { 28825, 0x1, 0x78, 0x35555, 0x962 =
},
+       [ATHOS_LUT_CHAN_720750_IDX] =3D { 28830, 0x1, 0x78, 0x40000, 0x963 =
},
+       [ATHOS_LUT_CHAN_720875_IDX] =3D { 28835, 0x1, 0x78, 0x4AAAB, 0x963 =
},
+       [ATHOS_LUT_CHAN_721000_IDX] =3D { 28840, 0x1, 0x78, 0x55555, 0x963 =
},
+       [ATHOS_LUT_CHAN_721125_IDX] =3D { 28845, 0x1, 0x78, 0x60000, 0x964 =
},
+       [ATHOS_LUT_CHAN_721250_IDX] =3D { 28850, 0x1, 0x78, 0x6AAAB, 0x964 =
},
+       [ATHOS_LUT_CHAN_721375_IDX] =3D { 28855, 0x1, 0x78, 0x75555, 0x965 =
},
+       [ATHOS_LUT_CHAN_721500_IDX] =3D { 28860, 0x1, 0x78, 0x80000, 0x965 =
}
+};
+
+const struct athos_lut_line athos_lut_6g_60_mhz[ATHOS_LUT_CHAN_6G_MAX] =3D=
 {
+       [ATHOS_LUT_CHAN_593000_IDX] =3D { 23720, 0x0, 0x41, 0x1C71C7, 0x7B9=
 },
+       [ATHOS_LUT_CHAN_593125_IDX] =3D { 23725, 0x0, 0x41, 0x1CE38E, 0x7B9=
 },
+       [ATHOS_LUT_CHAN_593250_IDX] =3D { 23730, 0x0, 0x41, 0x1D5555, 0x7BA=
 },
+       [ATHOS_LUT_CHAN_593375_IDX] =3D { 23735, 0x0, 0x41, 0x1DC71C, 0x7BA=
 },
+       [ATHOS_LUT_CHAN_593500_IDX] =3D { 23740, 0x0, 0x41, 0x1E38E4, 0x7BA=
 },
+       [ATHOS_LUT_CHAN_593625_IDX] =3D { 23745, 0x0, 0x41, 0x1EAAAB, 0x7BB=
 },
+       [ATHOS_LUT_CHAN_593750_IDX] =3D { 23750, 0x0, 0x41, 0x1F1C72, 0x7BB=
 },
+       [ATHOS_LUT_CHAN_593875_IDX] =3D { 23755, 0x0, 0x41, 0x1F8E39, 0x7BC=
 },
+       [ATHOS_LUT_CHAN_594000_IDX] =3D { 23760, 0x0, 0x42, 0x0, 0x7BC },
+       [ATHOS_LUT_CHAN_594125_IDX] =3D { 23765, 0x0, 0x42, 0x71C7, 0x7BC }=
,
+       [ATHOS_LUT_CHAN_594250_IDX] =3D { 23770, 0x0, 0x42, 0xE38E, 0x7BD }=
,
+       [ATHOS_LUT_CHAN_594375_IDX] =3D { 23775, 0x0, 0x42, 0x15555, 0x7BD =
},
+       [ATHOS_LUT_CHAN_594500_IDX] =3D { 23780, 0x0, 0x42, 0x1C71C, 0x7BE =
},
+       [ATHOS_LUT_CHAN_594625_IDX] =3D { 23785, 0x0, 0x42, 0x238E4, 0x7BE =
},
+       [ATHOS_LUT_CHAN_594750_IDX] =3D { 23790, 0x0, 0x42, 0x2AAAB, 0x7BF =
},
+       [ATHOS_LUT_CHAN_594875_IDX] =3D { 23795, 0x0, 0x42, 0x31C72, 0x7BF =
},
+       [ATHOS_LUT_CHAN_595000_IDX] =3D { 23800, 0x0, 0x42, 0x38E39, 0x7BF =
},
+       [ATHOS_LUT_CHAN_595125_IDX] =3D { 23805, 0x0, 0x42, 0x40000, 0x7C0 =
},
+       [ATHOS_LUT_CHAN_595250_IDX] =3D { 23810, 0x0, 0x42, 0x471C7, 0x7C0 =
},
+       [ATHOS_LUT_CHAN_595375_IDX] =3D { 23815, 0x0, 0x42, 0x4E38E, 0x7C1 =
},
+       [ATHOS_LUT_CHAN_595500_IDX] =3D { 23820, 0x0, 0x42, 0x55555, 0x7C1 =
},
+       [ATHOS_LUT_CHAN_595625_IDX] =3D { 23825, 0x0, 0x42, 0x5C71C, 0x7C1 =
},
+       [ATHOS_LUT_CHAN_595750_IDX] =3D { 23830, 0x0, 0x42, 0x638E4, 0x7C2 =
},
+       [ATHOS_LUT_CHAN_595875_IDX] =3D { 23835, 0x0, 0x42, 0x6AAAB, 0x7C2 =
},
+       [ATHOS_LUT_CHAN_596000_IDX] =3D { 23840, 0x0, 0x42, 0x71C72, 0x7C3 =
},
+       [ATHOS_LUT_CHAN_596125_IDX] =3D { 23845, 0x0, 0x42, 0x78E39, 0x7C3 =
},
+       [ATHOS_LUT_CHAN_596250_IDX] =3D { 23850, 0x0, 0x42, 0x80000, 0x7C4 =
},
+       [ATHOS_LUT_CHAN_596375_IDX] =3D { 23855, 0x0, 0x42, 0x871C7, 0x7C4 =
},
+       [ATHOS_LUT_CHAN_596500_IDX] =3D { 23860, 0x0, 0x42, 0x8E38E, 0x7C4 =
},
+       [ATHOS_LUT_CHAN_596625_IDX] =3D { 23865, 0x0, 0x42, 0x95555, 0x7C5 =
},
+       [ATHOS_LUT_CHAN_596750_IDX] =3D { 23870, 0x0, 0x42, 0x9C71C, 0x7C5 =
},
+       [ATHOS_LUT_CHAN_596875_IDX] =3D { 23875, 0x0, 0x42, 0xA38E4, 0x7C6 =
},
+       [ATHOS_LUT_CHAN_597000_IDX] =3D { 23880, 0x0, 0x42, 0xAAAAB, 0x7C6 =
},
+       [ATHOS_LUT_CHAN_597125_IDX] =3D { 23885, 0x0, 0x42, 0xB1C72, 0x7C6 =
},
+       [ATHOS_LUT_CHAN_597250_IDX] =3D { 23890, 0x0, 0x42, 0xB8E39, 0x7C7 =
},
+       [ATHOS_LUT_CHAN_597375_IDX] =3D { 23895, 0x0, 0x42, 0xC0000, 0x7C7 =
},
+       [ATHOS_LUT_CHAN_597500_IDX] =3D { 23900, 0x0, 0x42, 0xC71C7, 0x7C8 =
},
+       [ATHOS_LUT_CHAN_597625_IDX] =3D { 23905, 0x0, 0x42, 0xCE38E, 0x7C8 =
},
+       [ATHOS_LUT_CHAN_597750_IDX] =3D { 23910, 0x0, 0x42, 0xD5555, 0x7C9 =
},
+       [ATHOS_LUT_CHAN_597875_IDX] =3D { 23915, 0x0, 0x42, 0xDC71C, 0x7C9 =
},
+       [ATHOS_LUT_CHAN_598000_IDX] =3D { 23920, 0x0, 0x42, 0xE38E4, 0x7C9 =
},
+       [ATHOS_LUT_CHAN_598125_IDX] =3D { 23925, 0x0, 0x42, 0xEAAAB, 0x7CA =
},
+       [ATHOS_LUT_CHAN_598250_IDX] =3D { 23930, 0x0, 0x42, 0xF1C72, 0x7CA =
},
+       [ATHOS_LUT_CHAN_598375_IDX] =3D { 23935, 0x0, 0x42, 0xF8E39, 0x7CB =
},
+       [ATHOS_LUT_CHAN_598500_IDX] =3D { 23940, 0x0, 0x42, 0x100000, 0x7CB=
 },
+       [ATHOS_LUT_CHAN_598625_IDX] =3D { 23945, 0x0, 0x42, 0x1071C7, 0x7CB=
 },
+       [ATHOS_LUT_CHAN_598750_IDX] =3D { 23950, 0x0, 0x42, 0x10E38E, 0x7CC=
 },
+       [ATHOS_LUT_CHAN_598875_IDX] =3D { 23955, 0x0, 0x42, 0x115555, 0x7CC=
 },
+       [ATHOS_LUT_CHAN_599000_IDX] =3D { 23960, 0x0, 0x42, 0x11C71C, 0x7CD=
 },
+       [ATHOS_LUT_CHAN_599125_IDX] =3D { 23965, 0x0, 0x42, 0x1238E4, 0x7CD=
 },
+       [ATHOS_LUT_CHAN_599250_IDX] =3D { 23970, 0x0, 0x42, 0x12AAAB, 0x7CE=
 },
+       [ATHOS_LUT_CHAN_599375_IDX] =3D { 23975, 0x0, 0x42, 0x131C72, 0x7CE=
 },
+       [ATHOS_LUT_CHAN_599500_IDX] =3D { 23980, 0x0, 0x42, 0x138E39, 0x7CE=
 },
+       [ATHOS_LUT_CHAN_599625_IDX] =3D { 23985, 0x0, 0x42, 0x140000, 0x7CF=
 },
+       [ATHOS_LUT_CHAN_599750_IDX] =3D { 23990, 0x0, 0x42, 0x1471C7, 0x7CF=
 },
+       [ATHOS_LUT_CHAN_599875_IDX] =3D { 23995, 0x0, 0x42, 0x14E38E, 0x7D0=
 },
+       [ATHOS_LUT_CHAN_600000_IDX] =3D { 24000, 0x0, 0x42, 0x155555, 0x7D0=
 },
+       [ATHOS_LUT_CHAN_600125_IDX] =3D { 24005, 0x0, 0x42, 0x15C71C, 0x7D0=
 },
+       [ATHOS_LUT_CHAN_600250_IDX] =3D { 24010, 0x0, 0x42, 0x1638E4, 0x7D1=
 },
+       [ATHOS_LUT_CHAN_600375_IDX] =3D { 24015, 0x0, 0x42, 0x16AAAB, 0x7D1=
 },
+       [ATHOS_LUT_CHAN_600500_IDX] =3D { 24020, 0x0, 0x42, 0x171C72, 0x7D2=
 },
+       [ATHOS_LUT_CHAN_600625_IDX] =3D { 24025, 0x0, 0x42, 0x178E39, 0x7D2=
 },
+       [ATHOS_LUT_CHAN_600750_IDX] =3D { 24030, 0x0, 0x42, 0x180000, 0x7D3=
 },
+       [ATHOS_LUT_CHAN_600875_IDX] =3D { 24035, 0x0, 0x42, 0x1871C7, 0x7D3=
 },
+       [ATHOS_LUT_CHAN_601000_IDX] =3D { 24040, 0x0, 0x42, 0x18E38E, 0x7D3=
 },
+       [ATHOS_LUT_CHAN_601125_IDX] =3D { 24045, 0x0, 0x42, 0x195555, 0x7D4=
 },
+       [ATHOS_LUT_CHAN_601250_IDX] =3D { 24050, 0x0, 0x42, 0x19C71C, 0x7D4=
 },
+       [ATHOS_LUT_CHAN_601375_IDX] =3D { 24055, 0x0, 0x42, 0x1A38E4, 0x7D5=
 },
+       [ATHOS_LUT_CHAN_601500_IDX] =3D { 24060, 0x0, 0x42, 0x1AAAAB, 0x7D5=
 },
+       [ATHOS_LUT_CHAN_601625_IDX] =3D { 24065, 0x0, 0x42, 0x1B1C72, 0x7D5=
 },
+       [ATHOS_LUT_CHAN_601750_IDX] =3D { 24070, 0x0, 0x42, 0x1B8E39, 0x7D6=
 },
+       [ATHOS_LUT_CHAN_601875_IDX] =3D { 24075, 0x0, 0x42, 0x1C0000, 0x7D6=
 },
+       [ATHOS_LUT_CHAN_602000_IDX] =3D { 24080, 0x0, 0x42, 0x1C71C7, 0x7D7=
 },
+       [ATHOS_LUT_CHAN_602125_IDX] =3D { 24085, 0x0, 0x42, 0x1CE38E, 0x7D7=
 },
+       [ATHOS_LUT_CHAN_602250_IDX] =3D { 24090, 0x0, 0x42, 0x1D5555, 0x7D8=
 },
+       [ATHOS_LUT_CHAN_602375_IDX] =3D { 24095, 0x0, 0x42, 0x1DC71C, 0x7D8=
 },
+       [ATHOS_LUT_CHAN_602500_IDX] =3D { 24100, 0x0, 0x42, 0x1E38E4, 0x7D8=
 },
+       [ATHOS_LUT_CHAN_602625_IDX] =3D { 24105, 0x0, 0x42, 0x1EAAAB, 0x7D9=
 },
+       [ATHOS_LUT_CHAN_602750_IDX] =3D { 24110, 0x0, 0x42, 0x1F1C72, 0x7D9=
 },
+       [ATHOS_LUT_CHAN_602875_IDX] =3D { 24115, 0x0, 0x42, 0x1F8E39, 0x7DA=
 },
+       [ATHOS_LUT_CHAN_603000_IDX] =3D { 24120, 0x0, 0x43, 0x0, 0x7DA },
+       [ATHOS_LUT_CHAN_603125_IDX] =3D { 24125, 0x0, 0x43, 0x71C7, 0x7DA }=
,
+       [ATHOS_LUT_CHAN_603250_IDX] =3D { 24130, 0x0, 0x43, 0xE38E, 0x7DB }=
,
+       [ATHOS_LUT_CHAN_603375_IDX] =3D { 24135, 0x0, 0x43, 0x15555, 0x7DB =
},
+       [ATHOS_LUT_CHAN_603500_IDX] =3D { 24140, 0x0, 0x43, 0x1C71C, 0x7DC =
},
+       [ATHOS_LUT_CHAN_603625_IDX] =3D { 24145, 0x0, 0x43, 0x238E4, 0x7DC =
},
+       [ATHOS_LUT_CHAN_603750_IDX] =3D { 24150, 0x0, 0x43, 0x2AAAB, 0x7DD =
},
+       [ATHOS_LUT_CHAN_603875_IDX] =3D { 24155, 0x0, 0x43, 0x31C72, 0x7DD =
},
+       [ATHOS_LUT_CHAN_604000_IDX] =3D { 24160, 0x0, 0x43, 0x38E39, 0x7DD =
},
+       [ATHOS_LUT_CHAN_604125_IDX] =3D { 24165, 0x0, 0x43, 0x40000, 0x7DE =
},
+       [ATHOS_LUT_CHAN_604250_IDX] =3D { 24170, 0x0, 0x43, 0x471C7, 0x7DE =
},
+       [ATHOS_LUT_CHAN_604375_IDX] =3D { 24175, 0x0, 0x43, 0x4E38E, 0x7DF =
},
+       [ATHOS_LUT_CHAN_604500_IDX] =3D { 24180, 0x0, 0x43, 0x55555, 0x7DF =
},
+       [ATHOS_LUT_CHAN_604625_IDX] =3D { 24185, 0x0, 0x43, 0x5C71C, 0x7DF =
},
+       [ATHOS_LUT_CHAN_604750_IDX] =3D { 24190, 0x0, 0x43, 0x638E4, 0x7E0 =
},
+       [ATHOS_LUT_CHAN_604875_IDX] =3D { 24195, 0x0, 0x43, 0x6AAAB, 0x7E0 =
},
+       [ATHOS_LUT_CHAN_605000_IDX] =3D { 24200, 0x0, 0x43, 0x71C72, 0x7E1 =
},
+       [ATHOS_LUT_CHAN_605125_IDX] =3D { 24205, 0x0, 0x43, 0x78E39, 0x7E1 =
},
+       [ATHOS_LUT_CHAN_605250_IDX] =3D { 24210, 0x0, 0x43, 0x80000, 0x7E2 =
},
+       [ATHOS_LUT_CHAN_605375_IDX] =3D { 24215, 0x0, 0x43, 0x871C7, 0x7E2 =
},
+       [ATHOS_LUT_CHAN_605500_IDX] =3D { 24220, 0x0, 0x43, 0x8E38E, 0x7E2 =
},
+       [ATHOS_LUT_CHAN_605625_IDX] =3D { 24225, 0x0, 0x43, 0x95555, 0x7E3 =
},
+       [ATHOS_LUT_CHAN_605750_IDX] =3D { 24230, 0x0, 0x43, 0x9C71C, 0x7E3 =
},
+       [ATHOS_LUT_CHAN_605875_IDX] =3D { 24235, 0x0, 0x43, 0xA38E4, 0x7E4 =
},
+       [ATHOS_LUT_CHAN_606000_IDX] =3D { 24240, 0x0, 0x43, 0xAAAAB, 0x7E4 =
},
+       [ATHOS_LUT_CHAN_606125_IDX] =3D { 24245, 0x0, 0x43, 0xB1C72, 0x7E4 =
},
+       [ATHOS_LUT_CHAN_606250_IDX] =3D { 24250, 0x0, 0x43, 0xB8E39, 0x7E5 =
},
+       [ATHOS_LUT_CHAN_606375_IDX] =3D { 24255, 0x0, 0x43, 0xC0000, 0x7E5 =
},
+       [ATHOS_LUT_CHAN_606500_IDX] =3D { 24260, 0x0, 0x43, 0xC71C7, 0x7E6 =
},
+       [ATHOS_LUT_CHAN_606625_IDX] =3D { 24265, 0x0, 0x43, 0xCE38E, 0x7E6 =
},
+       [ATHOS_LUT_CHAN_606750_IDX] =3D { 24270, 0x0, 0x43, 0xD5555, 0x7E7 =
},
+       [ATHOS_LUT_CHAN_606875_IDX] =3D { 24275, 0x0, 0x43, 0xDC71C, 0x7E7 =
},
+       [ATHOS_LUT_CHAN_607000_IDX] =3D { 24280, 0x0, 0x43, 0xE38E4, 0x7E7 =
},
+       [ATHOS_LUT_CHAN_607125_IDX] =3D { 24285, 0x0, 0x43, 0xEAAAB, 0x7E8 =
},
+       [ATHOS_LUT_CHAN_607250_IDX] =3D { 24290, 0x0, 0x43, 0xF1C72, 0x7E8 =
},
+       [ATHOS_LUT_CHAN_607375_IDX] =3D { 24295, 0x0, 0x43, 0xF8E39, 0x7E9 =
},
+       [ATHOS_LUT_CHAN_607500_IDX] =3D { 24300, 0x0, 0x43, 0x100000, 0x7E9=
 },
+       [ATHOS_LUT_CHAN_607625_IDX] =3D { 24305, 0x0, 0x43, 0x1071C7, 0x7E9=
 },
+       [ATHOS_LUT_CHAN_607750_IDX] =3D { 24310, 0x0, 0x43, 0x10E38E, 0x7EA=
 },
+       [ATHOS_LUT_CHAN_607875_IDX] =3D { 24315, 0x0, 0x43, 0x115555, 0x7EA=
 },
+       [ATHOS_LUT_CHAN_608000_IDX] =3D { 24320, 0x0, 0x43, 0x11C71C, 0x7EB=
 },
+       [ATHOS_LUT_CHAN_608125_IDX] =3D { 24325, 0x0, 0x43, 0x1238E4, 0x7EB=
 },
+       [ATHOS_LUT_CHAN_608250_IDX] =3D { 24330, 0x0, 0x43, 0x12AAAB, 0x7EC=
 },
+       [ATHOS_LUT_CHAN_608375_IDX] =3D { 24335, 0x0, 0x43, 0x131C72, 0x7EC=
 },
+       [ATHOS_LUT_CHAN_608500_IDX] =3D { 24340, 0x0, 0x43, 0x138E39, 0x7EC=
 },
+       [ATHOS_LUT_CHAN_608625_IDX] =3D { 24345, 0x0, 0x43, 0x140000, 0x7ED=
 },
+       [ATHOS_LUT_CHAN_608750_IDX] =3D { 24350, 0x0, 0x43, 0x1471C7, 0x7ED=
 },
+       [ATHOS_LUT_CHAN_608875_IDX] =3D { 24355, 0x0, 0x43, 0x14E38E, 0x7EE=
 },
+       [ATHOS_LUT_CHAN_609000_IDX] =3D { 24360, 0x0, 0x43, 0x155555, 0x7EE=
 },
+       [ATHOS_LUT_CHAN_609125_IDX] =3D { 24365, 0x0, 0x43, 0x15C71C, 0x7EE=
 },
+       [ATHOS_LUT_CHAN_609250_IDX] =3D { 24370, 0x0, 0x43, 0x1638E4, 0x7EF=
 },
+       [ATHOS_LUT_CHAN_609375_IDX] =3D { 24375, 0x0, 0x43, 0x16AAAB, 0x7EF=
 },
+       [ATHOS_LUT_CHAN_609500_IDX] =3D { 24380, 0x0, 0x43, 0x171C72, 0x7F0=
 },
+       [ATHOS_LUT_CHAN_609625_IDX] =3D { 24385, 0x0, 0x43, 0x178E39, 0x7F0=
 },
+       [ATHOS_LUT_CHAN_609750_IDX] =3D { 24390, 0x0, 0x43, 0x180000, 0x7F1=
 },
+       [ATHOS_LUT_CHAN_609875_IDX] =3D { 24395, 0x0, 0x43, 0x1871C7, 0x7F1=
 },
+       [ATHOS_LUT_CHAN_610000_IDX] =3D { 24400, 0x1, 0x43, 0x18E38E, 0x7F1=
 },
+       [ATHOS_LUT_CHAN_610125_IDX] =3D { 24405, 0x1, 0x43, 0x195555, 0x7F2=
 },
+       [ATHOS_LUT_CHAN_610250_IDX] =3D { 24410, 0x1, 0x43, 0x19C71C, 0x7F2=
 },
+       [ATHOS_LUT_CHAN_610375_IDX] =3D { 24415, 0x1, 0x43, 0x1A38E4, 0x7F3=
 },
+       [ATHOS_LUT_CHAN_610500_IDX] =3D { 24420, 0x1, 0x43, 0x1AAAAB, 0x7F3=
 },
+       [ATHOS_LUT_CHAN_610625_IDX] =3D { 24425, 0x1, 0x43, 0x1B1C72, 0x7F3=
 },
+       [ATHOS_LUT_CHAN_610750_IDX] =3D { 24430, 0x1, 0x43, 0x1B8E39, 0x7F4=
 },
+       [ATHOS_LUT_CHAN_610875_IDX] =3D { 24435, 0x1, 0x43, 0x1C0000, 0x7F4=
 },
+       [ATHOS_LUT_CHAN_611000_IDX] =3D { 24440, 0x1, 0x43, 0x1C71C7, 0x7F5=
 },
+       [ATHOS_LUT_CHAN_611125_IDX] =3D { 24445, 0x1, 0x43, 0x1CE38E, 0x7F5=
 },
+       [ATHOS_LUT_CHAN_611250_IDX] =3D { 24450, 0x1, 0x43, 0x1D5555, 0x7F6=
 },
+       [ATHOS_LUT_CHAN_611375_IDX] =3D { 24455, 0x1, 0x43, 0x1DC71C, 0x7F6=
 },
+       [ATHOS_LUT_CHAN_611500_IDX] =3D { 24460, 0x1, 0x43, 0x1E38E4, 0x7F6=
 },
+       [ATHOS_LUT_CHAN_611625_IDX] =3D { 24465, 0x1, 0x43, 0x1EAAAB, 0x7F7=
 },
+       [ATHOS_LUT_CHAN_611750_IDX] =3D { 24470, 0x1, 0x43, 0x1F1C72, 0x7F7=
 },
+       [ATHOS_LUT_CHAN_611875_IDX] =3D { 24475, 0x1, 0x43, 0x1F8E39, 0x7F8=
 },
+       [ATHOS_LUT_CHAN_612000_IDX] =3D { 24480, 0x1, 0x44, 0x0, 0x7F8 },
+       [ATHOS_LUT_CHAN_612125_IDX] =3D { 24485, 0x1, 0x44, 0x71C7, 0x7F8 }=
,
+       [ATHOS_LUT_CHAN_612250_IDX] =3D { 24490, 0x1, 0x44, 0xE38E, 0x7F9 }=
,
+       [ATHOS_LUT_CHAN_612375_IDX] =3D { 24495, 0x1, 0x44, 0x15555, 0x7F9 =
},
+       [ATHOS_LUT_CHAN_612500_IDX] =3D { 24500, 0x1, 0x44, 0x1C71C, 0x7FA =
},
+       [ATHOS_LUT_CHAN_612625_IDX] =3D { 24505, 0x1, 0x44, 0x238E4, 0x7FA =
},
+       [ATHOS_LUT_CHAN_612750_IDX] =3D { 24510, 0x1, 0x44, 0x2AAAB, 0x7FB =
},
+       [ATHOS_LUT_CHAN_612875_IDX] =3D { 24515, 0x1, 0x44, 0x31C72, 0x7FB =
},
+       [ATHOS_LUT_CHAN_613000_IDX] =3D { 24520, 0x1, 0x44, 0x38E39, 0x7FB =
},
+       [ATHOS_LUT_CHAN_613125_IDX] =3D { 24525, 0x1, 0x44, 0x40000, 0x7FC =
},
+       [ATHOS_LUT_CHAN_613250_IDX] =3D { 24530, 0x1, 0x44, 0x471C7, 0x7FC =
},
+       [ATHOS_LUT_CHAN_613375_IDX] =3D { 24535, 0x1, 0x44, 0x4E38E, 0x7FD =
},
+       [ATHOS_LUT_CHAN_613500_IDX] =3D { 24540, 0x1, 0x44, 0x55555, 0x7FD =
},
+       [ATHOS_LUT_CHAN_613625_IDX] =3D { 24545, 0x1, 0x44, 0x5C71C, 0x7FD =
},
+       [ATHOS_LUT_CHAN_613750_IDX] =3D { 24550, 0x1, 0x44, 0x638E4, 0x7FE =
},
+       [ATHOS_LUT_CHAN_613875_IDX] =3D { 24555, 0x1, 0x44, 0x6AAAB, 0x7FE =
},
+       [ATHOS_LUT_CHAN_614000_IDX] =3D { 24560, 0x1, 0x44, 0x71C72, 0x7FF =
},
+       [ATHOS_LUT_CHAN_614125_IDX] =3D { 24565, 0x1, 0x44, 0x78E39, 0x7FF =
},
+       [ATHOS_LUT_CHAN_614250_IDX] =3D { 24570, 0x1, 0x44, 0x80000, 0x800 =
},
+       [ATHOS_LUT_CHAN_614375_IDX] =3D { 24575, 0x1, 0x44, 0x871C7, 0x800 =
},
+       [ATHOS_LUT_CHAN_614500_IDX] =3D { 24580, 0x1, 0x44, 0x8E38E, 0x800 =
},
+       [ATHOS_LUT_CHAN_614625_IDX] =3D { 24585, 0x1, 0x44, 0x95555, 0x801 =
},
+       [ATHOS_LUT_CHAN_614750_IDX] =3D { 24590, 0x1, 0x44, 0x9C71C, 0x801 =
},
+       [ATHOS_LUT_CHAN_614875_IDX] =3D { 24595, 0x1, 0x44, 0xA38E4, 0x802 =
},
+       [ATHOS_LUT_CHAN_615000_IDX] =3D { 24600, 0x1, 0x44, 0xAAAAB, 0x802 =
},
+       [ATHOS_LUT_CHAN_615125_IDX] =3D { 24605, 0x1, 0x44, 0xB1C72, 0x802 =
},
+       [ATHOS_LUT_CHAN_615250_IDX] =3D { 24610, 0x1, 0x44, 0xB8E39, 0x803 =
},
+       [ATHOS_LUT_CHAN_615375_IDX] =3D { 24615, 0x1, 0x44, 0xC0000, 0x803 =
},
+       [ATHOS_LUT_CHAN_615500_IDX] =3D { 24620, 0x1, 0x44, 0xC71C7, 0x804 =
},
+       [ATHOS_LUT_CHAN_615625_IDX] =3D { 24625, 0x1, 0x44, 0xCE38E, 0x804 =
},
+       [ATHOS_LUT_CHAN_615750_IDX] =3D { 24630, 0x1, 0x44, 0xD5555, 0x805 =
},
+       [ATHOS_LUT_CHAN_615875_IDX] =3D { 24635, 0x1, 0x44, 0xDC71C, 0x805 =
},
+       [ATHOS_LUT_CHAN_616000_IDX] =3D { 24640, 0x1, 0x44, 0xE38E4, 0x805 =
},
+       [ATHOS_LUT_CHAN_616125_IDX] =3D { 24645, 0x1, 0x44, 0xEAAAB, 0x806 =
},
+       [ATHOS_LUT_CHAN_616250_IDX] =3D { 24650, 0x1, 0x44, 0xF1C72, 0x806 =
},
+       [ATHOS_LUT_CHAN_616375_IDX] =3D { 24655, 0x1, 0x44, 0xF8E39, 0x807 =
},
+       [ATHOS_LUT_CHAN_616500_IDX] =3D { 24660, 0x1, 0x44, 0x100000, 0x807=
 },
+       [ATHOS_LUT_CHAN_616625_IDX] =3D { 24665, 0x1, 0x44, 0x1071C7, 0x807=
 },
+       [ATHOS_LUT_CHAN_616750_IDX] =3D { 24670, 0x1, 0x44, 0x10E38E, 0x808=
 },
+       [ATHOS_LUT_CHAN_616875_IDX] =3D { 24675, 0x1, 0x44, 0x115555, 0x808=
 },
+       [ATHOS_LUT_CHAN_617000_IDX] =3D { 24680, 0x1, 0x44, 0x11C71C, 0x809=
 },
+       [ATHOS_LUT_CHAN_617125_IDX] =3D { 24685, 0x1, 0x44, 0x1238E4, 0x809=
 },
+       [ATHOS_LUT_CHAN_617250_IDX] =3D { 24690, 0x1, 0x44, 0x12AAAB, 0x80A=
 },
+       [ATHOS_LUT_CHAN_617375_IDX] =3D { 24695, 0x1, 0x44, 0x131C72, 0x80A=
 },
+       [ATHOS_LUT_CHAN_617500_IDX] =3D { 24700, 0x1, 0x44, 0x138E39, 0x80A=
 },
+       [ATHOS_LUT_CHAN_617625_IDX] =3D { 24705, 0x1, 0x44, 0x140000, 0x80B=
 },
+       [ATHOS_LUT_CHAN_617750_IDX] =3D { 24710, 0x1, 0x44, 0x1471C7, 0x80B=
 },
+       [ATHOS_LUT_CHAN_617875_IDX] =3D { 24715, 0x1, 0x44, 0x14E38E, 0x80C=
 },
+       [ATHOS_LUT_CHAN_618000_IDX] =3D { 24720, 0x1, 0x44, 0x155555, 0x80C=
 },
+       [ATHOS_LUT_CHAN_618125_IDX] =3D { 24725, 0x1, 0x44, 0x15C71C, 0x80C=
 },
+       [ATHOS_LUT_CHAN_618250_IDX] =3D { 24730, 0x1, 0x44, 0x1638E4, 0x80D=
 },
+       [ATHOS_LUT_CHAN_618375_IDX] =3D { 24735, 0x1, 0x44, 0x16AAAB, 0x80D=
 },
+       [ATHOS_LUT_CHAN_618500_IDX] =3D { 24740, 0x1, 0x44, 0x171C72, 0x80E=
 },
+       [ATHOS_LUT_CHAN_618625_IDX] =3D { 24745, 0x1, 0x44, 0x178E39, 0x80E=
 },
+       [ATHOS_LUT_CHAN_618750_IDX] =3D { 24750, 0x1, 0x44, 0x180000, 0x80F=
 },
+       [ATHOS_LUT_CHAN_618875_IDX] =3D { 24755, 0x1, 0x44, 0x1871C7, 0x80F=
 },
+       [ATHOS_LUT_CHAN_619000_IDX] =3D { 24760, 0x1, 0x44, 0x18E38E, 0x80F=
 },
+       [ATHOS_LUT_CHAN_619125_IDX] =3D { 24765, 0x1, 0x44, 0x195555, 0x810=
 },
+       [ATHOS_LUT_CHAN_619250_IDX] =3D { 24770, 0x1, 0x44, 0x19C71C, 0x810=
 },
+       [ATHOS_LUT_CHAN_619375_IDX] =3D { 24775, 0x1, 0x44, 0x1A38E4, 0x811=
 },
+       [ATHOS_LUT_CHAN_619500_IDX] =3D { 24780, 0x1, 0x44, 0x1AAAAB, 0x811=
 },
+       [ATHOS_LUT_CHAN_619625_IDX] =3D { 24785, 0x1, 0x44, 0x1B1C72, 0x811=
 },
+       [ATHOS_LUT_CHAN_619750_IDX] =3D { 24790, 0x1, 0x44, 0x1B8E39, 0x812=
 },
+       [ATHOS_LUT_CHAN_619875_IDX] =3D { 24795, 0x1, 0x44, 0x1C0000, 0x812=
 },
+       [ATHOS_LUT_CHAN_620000_IDX] =3D { 24800, 0x1, 0x44, 0x1C71C7, 0x813=
 },
+       [ATHOS_LUT_CHAN_620125_IDX] =3D { 24805, 0x1, 0x44, 0x1CE38E, 0x813=
 },
+       [ATHOS_LUT_CHAN_620250_IDX] =3D { 24810, 0x1, 0x44, 0x1D5555, 0x814=
 },
+       [ATHOS_LUT_CHAN_620375_IDX] =3D { 24815, 0x1, 0x44, 0x1DC71C, 0x814=
 },
+       [ATHOS_LUT_CHAN_620500_IDX] =3D { 24820, 0x1, 0x44, 0x1E38E4, 0x814=
 },
+       [ATHOS_LUT_CHAN_620625_IDX] =3D { 24825, 0x1, 0x44, 0x1EAAAB, 0x815=
 },
+       [ATHOS_LUT_CHAN_620750_IDX] =3D { 24830, 0x1, 0x44, 0x1F1C72, 0x815=
 },
+       [ATHOS_LUT_CHAN_620875_IDX] =3D { 24835, 0x1, 0x44, 0x1F8E39, 0x816=
 },
+       [ATHOS_LUT_CHAN_621000_IDX] =3D { 24840, 0x1, 0x45, 0x0, 0x816 },
+       [ATHOS_LUT_CHAN_621125_IDX] =3D { 24845, 0x1, 0x45, 0x71C7, 0x816 }=
,
+       [ATHOS_LUT_CHAN_621250_IDX] =3D { 24850, 0x1, 0x45, 0xE38E, 0x817 }=
,
+       [ATHOS_LUT_CHAN_621375_IDX] =3D { 24855, 0x1, 0x45, 0x15555, 0x817 =
},
+       [ATHOS_LUT_CHAN_621500_IDX] =3D { 24860, 0x1, 0x45, 0x1C71C, 0x818 =
},
+       [ATHOS_LUT_CHAN_621625_IDX] =3D { 24865, 0x1, 0x45, 0x238E4, 0x818 =
},
+       [ATHOS_LUT_CHAN_621750_IDX] =3D { 24870, 0x1, 0x45, 0x2AAAB, 0x819 =
},
+       [ATHOS_LUT_CHAN_621875_IDX] =3D { 24875, 0x1, 0x45, 0x31C72, 0x819 =
},
+       [ATHOS_LUT_CHAN_622000_IDX] =3D { 24880, 0x1, 0x45, 0x38E39, 0x819 =
},
+       [ATHOS_LUT_CHAN_622125_IDX] =3D { 24885, 0x1, 0x45, 0x40000, 0x81A =
},
+       [ATHOS_LUT_CHAN_622250_IDX] =3D { 24890, 0x1, 0x45, 0x471C7, 0x81A =
},
+       [ATHOS_LUT_CHAN_622375_IDX] =3D { 24895, 0x1, 0x45, 0x4E38E, 0x81B =
},
+       [ATHOS_LUT_CHAN_622500_IDX] =3D { 24900, 0x1, 0x45, 0x55555, 0x81B =
},
+       [ATHOS_LUT_CHAN_622625_IDX] =3D { 24905, 0x1, 0x45, 0x5C71C, 0x81B =
},
+       [ATHOS_LUT_CHAN_622750_IDX] =3D { 24910, 0x1, 0x45, 0x638E4, 0x81C =
},
+       [ATHOS_LUT_CHAN_622875_IDX] =3D { 24915, 0x1, 0x45, 0x6AAAB, 0x81C =
},
+       [ATHOS_LUT_CHAN_623000_IDX] =3D { 24920, 0x1, 0x45, 0x71C72, 0x81D =
},
+       [ATHOS_LUT_CHAN_623125_IDX] =3D { 24925, 0x1, 0x45, 0x78E39, 0x81D =
},
+       [ATHOS_LUT_CHAN_623250_IDX] =3D { 24930, 0x1, 0x45, 0x80000, 0x81E =
},
+       [ATHOS_LUT_CHAN_623375_IDX] =3D { 24935, 0x1, 0x45, 0x871C7, 0x81E =
},
+       [ATHOS_LUT_CHAN_623500_IDX] =3D { 24940, 0x1, 0x45, 0x8E38E, 0x81E =
},
+       [ATHOS_LUT_CHAN_623625_IDX] =3D { 24945, 0x1, 0x45, 0x95555, 0x81F =
},
+       [ATHOS_LUT_CHAN_623750_IDX] =3D { 24950, 0x1, 0x45, 0x9C71C, 0x81F =
},
+       [ATHOS_LUT_CHAN_623875_IDX] =3D { 24955, 0x1, 0x45, 0xA38E4, 0x820 =
},
+       [ATHOS_LUT_CHAN_624000_IDX] =3D { 24960, 0x1, 0x45, 0xAAAAB, 0x820 =
},
+       [ATHOS_LUT_CHAN_624125_IDX] =3D { 24965, 0x1, 0x45, 0xB1C72, 0x820 =
},
+       [ATHOS_LUT_CHAN_624250_IDX] =3D { 24970, 0x1, 0x45, 0xB8E39, 0x821 =
},
+       [ATHOS_LUT_CHAN_624375_IDX] =3D { 24975, 0x1, 0x45, 0xC0000, 0x821 =
},
+       [ATHOS_LUT_CHAN_624500_IDX] =3D { 24980, 0x1, 0x45, 0xC71C7, 0x822 =
},
+       [ATHOS_LUT_CHAN_624625_IDX] =3D { 24985, 0x1, 0x45, 0xCE38E, 0x822 =
},
+       [ATHOS_LUT_CHAN_624750_IDX] =3D { 24990, 0x1, 0x45, 0xD5555, 0x823 =
},
+       [ATHOS_LUT_CHAN_624875_IDX] =3D { 24995, 0x1, 0x45, 0xDC71C, 0x823 =
},
+       [ATHOS_LUT_CHAN_625000_IDX] =3D { 25000, 0x1, 0x45, 0xE38E4, 0x823 =
},
+       [ATHOS_LUT_CHAN_625125_IDX] =3D { 25005, 0x1, 0x45, 0xEAAAB, 0x824 =
},
+       [ATHOS_LUT_CHAN_625250_IDX] =3D { 25010, 0x1, 0x45, 0xF1C72, 0x824 =
},
+       [ATHOS_LUT_CHAN_625375_IDX] =3D { 25015, 0x1, 0x45, 0xF8E39, 0x825 =
},
+       [ATHOS_LUT_CHAN_625500_IDX] =3D { 25020, 0x1, 0x45, 0x100000, 0x825=
 },
+       [ATHOS_LUT_CHAN_625625_IDX] =3D { 25025, 0x1, 0x45, 0x1071C7, 0x825=
 },
+       [ATHOS_LUT_CHAN_625750_IDX] =3D { 25030, 0x1, 0x45, 0x10E38E, 0x826=
 },
+       [ATHOS_LUT_CHAN_625875_IDX] =3D { 25035, 0x1, 0x45, 0x115555, 0x826=
 },
+       [ATHOS_LUT_CHAN_626000_IDX] =3D { 25040, 0x1, 0x45, 0x11C71C, 0x827=
 },
+       [ATHOS_LUT_CHAN_626125_IDX] =3D { 25045, 0x1, 0x45, 0x1238E4, 0x827=
 },
+       [ATHOS_LUT_CHAN_626250_IDX] =3D { 25050, 0x1, 0x45, 0x12AAAB, 0x828=
 },
+       [ATHOS_LUT_CHAN_626375_IDX] =3D { 25055, 0x1, 0x45, 0x131C72, 0x828=
 },
+       [ATHOS_LUT_CHAN_626500_IDX] =3D { 25060, 0x1, 0x45, 0x138E39, 0x828=
 },
+       [ATHOS_LUT_CHAN_626625_IDX] =3D { 25065, 0x1, 0x45, 0x140000, 0x829=
 },
+       [ATHOS_LUT_CHAN_626750_IDX] =3D { 25070, 0x1, 0x45, 0x1471C7, 0x829=
 },
+       [ATHOS_LUT_CHAN_626875_IDX] =3D { 25075, 0x1, 0x45, 0x14E38E, 0x82A=
 },
+       [ATHOS_LUT_CHAN_627000_IDX] =3D { 25080, 0x1, 0x45, 0x155555, 0x82A=
 },
+       [ATHOS_LUT_CHAN_627125_IDX] =3D { 25085, 0x1, 0x45, 0x15C71C, 0x82A=
 },
+       [ATHOS_LUT_CHAN_627250_IDX] =3D { 25090, 0x1, 0x45, 0x1638E4, 0x82B=
 },
+       [ATHOS_LUT_CHAN_627375_IDX] =3D { 25095, 0x1, 0x45, 0x16AAAB, 0x82B=
 },
+       [ATHOS_LUT_CHAN_627500_IDX] =3D { 25100, 0x1, 0x45, 0x171C72, 0x82C=
 },
+       [ATHOS_LUT_CHAN_627625_IDX] =3D { 25105, 0x1, 0x45, 0x178E39, 0x82C=
 },
+       [ATHOS_LUT_CHAN_627750_IDX] =3D { 25110, 0x1, 0x45, 0x180000, 0x82D=
 },
+       [ATHOS_LUT_CHAN_627875_IDX] =3D { 25115, 0x1, 0x45, 0x1871C7, 0x82D=
 },
+       [ATHOS_LUT_CHAN_628000_IDX] =3D { 25120, 0x1, 0x45, 0x18E38E, 0x82D=
 },
+       [ATHOS_LUT_CHAN_628125_IDX] =3D { 25125, 0x1, 0x45, 0x195555, 0x82E=
 },
+       [ATHOS_LUT_CHAN_628250_IDX] =3D { 25130, 0x1, 0x45, 0x19C71C, 0x82E=
 },
+       [ATHOS_LUT_CHAN_628375_IDX] =3D { 25135, 0x1, 0x45, 0x1A38E4, 0x82F=
 },
+       [ATHOS_LUT_CHAN_628500_IDX] =3D { 25140, 0x1, 0x45, 0x1AAAAB, 0x82F=
 },
+       [ATHOS_LUT_CHAN_628625_IDX] =3D { 25145, 0x1, 0x45, 0x1B1C72, 0x82F=
 },
+       [ATHOS_LUT_CHAN_628750_IDX] =3D { 25150, 0x1, 0x45, 0x1B8E39, 0x830=
 },
+       [ATHOS_LUT_CHAN_628875_IDX] =3D { 25155, 0x1, 0x45, 0x1C0000, 0x830=
 },
+       [ATHOS_LUT_CHAN_629000_IDX] =3D { 25160, 0x1, 0x45, 0x1C71C7, 0x831=
 },
+       [ATHOS_LUT_CHAN_629125_IDX] =3D { 25165, 0x1, 0x45, 0x1CE38E, 0x831=
 },
+       [ATHOS_LUT_CHAN_629250_IDX] =3D { 25170, 0x1, 0x45, 0x1D5555, 0x832=
 },
+       [ATHOS_LUT_CHAN_629375_IDX] =3D { 25175, 0x1, 0x45, 0x1DC71C, 0x832=
 },
+       [ATHOS_LUT_CHAN_629500_IDX] =3D { 25180, 0x1, 0x45, 0x1E38E4, 0x832=
 },
+       [ATHOS_LUT_CHAN_629625_IDX] =3D { 25185, 0x1, 0x45, 0x1EAAAB, 0x833=
 },
+       [ATHOS_LUT_CHAN_629750_IDX] =3D { 25190, 0x1, 0x45, 0x1F1C72, 0x833=
 },
+       [ATHOS_LUT_CHAN_629875_IDX] =3D { 25195, 0x1, 0x45, 0x1F8E39, 0x834=
 },
+       [ATHOS_LUT_CHAN_630000_IDX] =3D { 25200, 0x1, 0x46, 0x0, 0x834 },
+       [ATHOS_LUT_CHAN_630125_IDX] =3D { 25205, 0x1, 0x46, 0x71C7, 0x834 }=
,
+       [ATHOS_LUT_CHAN_630250_IDX] =3D { 25210, 0x1, 0x46, 0xE38E, 0x835 }=
,
+       [ATHOS_LUT_CHAN_630375_IDX] =3D { 25215, 0x1, 0x46, 0x15555, 0x835 =
},
+       [ATHOS_LUT_CHAN_630500_IDX] =3D { 25220, 0x1, 0x46, 0x1C71C, 0x836 =
},
+       [ATHOS_LUT_CHAN_630625_IDX] =3D { 25225, 0x1, 0x46, 0x238E4, 0x836 =
},
+       [ATHOS_LUT_CHAN_630750_IDX] =3D { 25230, 0x1, 0x46, 0x2AAAB, 0x837 =
},
+       [ATHOS_LUT_CHAN_630875_IDX] =3D { 25235, 0x1, 0x46, 0x31C72, 0x837 =
},
+       [ATHOS_LUT_CHAN_631000_IDX] =3D { 25240, 0x1, 0x46, 0x38E39, 0x837 =
},
+       [ATHOS_LUT_CHAN_631125_IDX] =3D { 25245, 0x1, 0x46, 0x40000, 0x838 =
},
+       [ATHOS_LUT_CHAN_631250_IDX] =3D { 25250, 0x1, 0x46, 0x471C7, 0x838 =
},
+       [ATHOS_LUT_CHAN_631375_IDX] =3D { 25255, 0x1, 0x46, 0x4E38E, 0x839 =
},
+       [ATHOS_LUT_CHAN_631500_IDX] =3D { 25260, 0x1, 0x46, 0x55555, 0x839 =
},
+       [ATHOS_LUT_CHAN_631625_IDX] =3D { 25265, 0x1, 0x46, 0x5C71C, 0x839 =
},
+       [ATHOS_LUT_CHAN_631750_IDX] =3D { 25270, 0x1, 0x46, 0x638E4, 0x83A =
},
+       [ATHOS_LUT_CHAN_631875_IDX] =3D { 25275, 0x1, 0x46, 0x6AAAB, 0x83A =
},
+       [ATHOS_LUT_CHAN_632000_IDX] =3D { 25280, 0x1, 0x46, 0x71C72, 0x83B =
},
+       [ATHOS_LUT_CHAN_632125_IDX] =3D { 25285, 0x1, 0x46, 0x78E39, 0x83B =
},
+       [ATHOS_LUT_CHAN_632250_IDX] =3D { 25290, 0x1, 0x46, 0x80000, 0x83C =
},
+       [ATHOS_LUT_CHAN_632375_IDX] =3D { 25295, 0x1, 0x46, 0x871C7, 0x83C =
},
+       [ATHOS_LUT_CHAN_632500_IDX] =3D { 25300, 0x1, 0x46, 0x8E38E, 0x83C =
},
+       [ATHOS_LUT_CHAN_632625_IDX] =3D { 25305, 0x1, 0x46, 0x95555, 0x83D =
},
+       [ATHOS_LUT_CHAN_632750_IDX] =3D { 25310, 0x1, 0x46, 0x9C71C, 0x83D =
},
+       [ATHOS_LUT_CHAN_632875_IDX] =3D { 25315, 0x1, 0x46, 0xA38E4, 0x83E =
},
+       [ATHOS_LUT_CHAN_633000_IDX] =3D { 25320, 0x1, 0x46, 0xAAAAB, 0x83E =
},
+       [ATHOS_LUT_CHAN_633125_IDX] =3D { 25325, 0x1, 0x46, 0xB1C72, 0x83E =
},
+       [ATHOS_LUT_CHAN_633250_IDX] =3D { 25330, 0x1, 0x46, 0xB8E39, 0x83F =
},
+       [ATHOS_LUT_CHAN_633375_IDX] =3D { 25335, 0x1, 0x46, 0xC0000, 0x83F =
},
+       [ATHOS_LUT_CHAN_633500_IDX] =3D { 25340, 0x1, 0x46, 0xC71C7, 0x840 =
},
+       [ATHOS_LUT_CHAN_633625_IDX] =3D { 25345, 0x1, 0x46, 0xCE38E, 0x840 =
},
+       [ATHOS_LUT_CHAN_633750_IDX] =3D { 25350, 0x1, 0x46, 0xD5555, 0x841 =
},
+       [ATHOS_LUT_CHAN_633875_IDX] =3D { 25355, 0x1, 0x46, 0xDC71C, 0x841 =
},
+       [ATHOS_LUT_CHAN_634000_IDX] =3D { 25360, 0x1, 0x46, 0xE38E4, 0x841 =
},
+       [ATHOS_LUT_CHAN_634125_IDX] =3D { 25365, 0x1, 0x46, 0xEAAAB, 0x842 =
},
+       [ATHOS_LUT_CHAN_634250_IDX] =3D { 25370, 0x1, 0x46, 0xF1C72, 0x842 =
},
+       [ATHOS_LUT_CHAN_634375_IDX] =3D { 25375, 0x1, 0x46, 0xF8E39, 0x843 =
},
+       [ATHOS_LUT_CHAN_634500_IDX] =3D { 25380, 0x1, 0x46, 0x100000, 0x843=
 },
+       [ATHOS_LUT_CHAN_634625_IDX] =3D { 25385, 0x1, 0x46, 0x1071C7, 0x843=
 },
+       [ATHOS_LUT_CHAN_634750_IDX] =3D { 25390, 0x1, 0x46, 0x10E38E, 0x844=
 },
+       [ATHOS_LUT_CHAN_634875_IDX] =3D { 25395, 0x1, 0x46, 0x115555, 0x844=
 },
+       [ATHOS_LUT_CHAN_635000_IDX] =3D { 25400, 0x1, 0x46, 0x11C71C, 0x845=
 },
+       [ATHOS_LUT_CHAN_635125_IDX] =3D { 25405, 0x1, 0x46, 0x1238E4, 0x845=
 },
+       [ATHOS_LUT_CHAN_635250_IDX] =3D { 25410, 0x1, 0x46, 0x12AAAB, 0x846=
 },
+       [ATHOS_LUT_CHAN_635375_IDX] =3D { 25415, 0x1, 0x46, 0x131C72, 0x846=
 },
+       [ATHOS_LUT_CHAN_635500_IDX] =3D { 25420, 0x1, 0x46, 0x138E39, 0x846=
 },
+       [ATHOS_LUT_CHAN_635625_IDX] =3D { 25425, 0x1, 0x46, 0x140000, 0x847=
 },
+       [ATHOS_LUT_CHAN_635750_IDX] =3D { 25430, 0x1, 0x46, 0x1471C7, 0x847=
 },
+       [ATHOS_LUT_CHAN_635875_IDX] =3D { 25435, 0x1, 0x46, 0x14E38E, 0x848=
 },
+       [ATHOS_LUT_CHAN_636000_IDX] =3D { 25440, 0x1, 0x46, 0x155555, 0x848=
 },
+       [ATHOS_LUT_CHAN_636125_IDX] =3D { 25445, 0x1, 0x46, 0x15C71C, 0x848=
 },
+       [ATHOS_LUT_CHAN_636250_IDX] =3D { 25450, 0x1, 0x46, 0x1638E4, 0x849=
 },
+       [ATHOS_LUT_CHAN_636375_IDX] =3D { 25455, 0x1, 0x46, 0x16AAAB, 0x849=
 },
+       [ATHOS_LUT_CHAN_636500_IDX] =3D { 25460, 0x1, 0x46, 0x171C72, 0x84A=
 },
+       [ATHOS_LUT_CHAN_636625_IDX] =3D { 25465, 0x1, 0x46, 0x178E39, 0x84A=
 },
+       [ATHOS_LUT_CHAN_636750_IDX] =3D { 25470, 0x1, 0x46, 0x180000, 0x84B=
 },
+       [ATHOS_LUT_CHAN_636875_IDX] =3D { 25475, 0x1, 0x46, 0x1871C7, 0x84B=
 },
+       [ATHOS_LUT_CHAN_637000_IDX] =3D { 25480, 0x1, 0x46, 0x18E38E, 0x84B=
 },
+       [ATHOS_LUT_CHAN_637125_IDX] =3D { 25485, 0x1, 0x46, 0x195555, 0x84C=
 },
+       [ATHOS_LUT_CHAN_637250_IDX] =3D { 25490, 0x1, 0x46, 0x19C71C, 0x84C=
 },
+       [ATHOS_LUT_CHAN_637375_IDX] =3D { 25495, 0x1, 0x46, 0x1A38E4, 0x84D=
 },
+       [ATHOS_LUT_CHAN_637500_IDX] =3D { 25500, 0x1, 0x46, 0x1AAAAB, 0x84D=
 },
+       [ATHOS_LUT_CHAN_637625_IDX] =3D { 25505, 0x1, 0x46, 0x1B1C72, 0x84D=
 },
+       [ATHOS_LUT_CHAN_637750_IDX] =3D { 25510, 0x1, 0x46, 0x1B8E39, 0x84E=
 },
+       [ATHOS_LUT_CHAN_637875_IDX] =3D { 25515, 0x1, 0x46, 0x1C0000, 0x84E=
 },
+       [ATHOS_LUT_CHAN_638000_IDX] =3D { 25520, 0x1, 0x46, 0x1C71C7, 0x84F=
 },
+       [ATHOS_LUT_CHAN_638125_IDX] =3D { 25525, 0x1, 0x46, 0x1CE38E, 0x84F=
 },
+       [ATHOS_LUT_CHAN_638250_IDX] =3D { 25530, 0x1, 0x46, 0x1D5555, 0x850=
 },
+       [ATHOS_LUT_CHAN_638375_IDX] =3D { 25535, 0x1, 0x46, 0x1DC71C, 0x850=
 },
+       [ATHOS_LUT_CHAN_638500_IDX] =3D { 25540, 0x1, 0x46, 0x1E38E4, 0x850=
 },
+       [ATHOS_LUT_CHAN_638625_IDX] =3D { 25545, 0x1, 0x46, 0x1EAAAB, 0x851=
 },
+       [ATHOS_LUT_CHAN_638750_IDX] =3D { 25550, 0x1, 0x46, 0x1F1C72, 0x851=
 },
+       [ATHOS_LUT_CHAN_638875_IDX] =3D { 25555, 0x1, 0x46, 0x1F8E39, 0x852=
 },
+       [ATHOS_LUT_CHAN_639000_IDX] =3D { 25560, 0x1, 0x47, 0x0, 0x852 },
+       [ATHOS_LUT_CHAN_639125_IDX] =3D { 25565, 0x1, 0x47, 0x71C7, 0x852 }=
,
+       [ATHOS_LUT_CHAN_639250_IDX] =3D { 25570, 0x1, 0x47, 0xE38E, 0x853 }=
,
+       [ATHOS_LUT_CHAN_639375_IDX] =3D { 25575, 0x1, 0x47, 0x15555, 0x853 =
},
+       [ATHOS_LUT_CHAN_639500_IDX] =3D { 25580, 0x1, 0x47, 0x1C71C, 0x854 =
},
+       [ATHOS_LUT_CHAN_639625_IDX] =3D { 25585, 0x1, 0x47, 0x238E4, 0x854 =
},
+       [ATHOS_LUT_CHAN_639750_IDX] =3D { 25590, 0x1, 0x47, 0x2AAAB, 0x855 =
},
+       [ATHOS_LUT_CHAN_639875_IDX] =3D { 25595, 0x1, 0x47, 0x31C72, 0x855 =
},
+       [ATHOS_LUT_CHAN_640000_IDX] =3D { 25600, 0x1, 0x47, 0x38E39, 0x855 =
},
+       [ATHOS_LUT_CHAN_640125_IDX] =3D { 25605, 0x1, 0x47, 0x40000, 0x856 =
},
+       [ATHOS_LUT_CHAN_640250_IDX] =3D { 25610, 0x1, 0x47, 0x471C7, 0x856 =
},
+       [ATHOS_LUT_CHAN_640375_IDX] =3D { 25615, 0x1, 0x47, 0x4E38E, 0x857 =
},
+       [ATHOS_LUT_CHAN_640500_IDX] =3D { 25620, 0x1, 0x47, 0x55555, 0x857 =
},
+       [ATHOS_LUT_CHAN_640625_IDX] =3D { 25625, 0x1, 0x47, 0x5C71C, 0x857 =
},
+       [ATHOS_LUT_CHAN_640750_IDX] =3D { 25630, 0x1, 0x47, 0x638E4, 0x858 =
},
+       [ATHOS_LUT_CHAN_640875_IDX] =3D { 25635, 0x1, 0x47, 0x6AAAB, 0x858 =
},
+       [ATHOS_LUT_CHAN_641000_IDX] =3D { 25640, 0x1, 0x47, 0x71C72, 0x859 =
},
+       [ATHOS_LUT_CHAN_641125_IDX] =3D { 25645, 0x1, 0x47, 0x78E39, 0x859 =
},
+       [ATHOS_LUT_CHAN_641250_IDX] =3D { 25650, 0x1, 0x47, 0x80000, 0x85A =
},
+       [ATHOS_LUT_CHAN_641375_IDX] =3D { 25655, 0x1, 0x47, 0x871C7, 0x85A =
},
+       [ATHOS_LUT_CHAN_641500_IDX] =3D { 25660, 0x1, 0x47, 0x8E38E, 0x85A =
},
+       [ATHOS_LUT_CHAN_641625_IDX] =3D { 25665, 0x1, 0x47, 0x95555, 0x85B =
},
+       [ATHOS_LUT_CHAN_641750_IDX] =3D { 25670, 0x1, 0x47, 0x9C71C, 0x85B =
},
+       [ATHOS_LUT_CHAN_641875_IDX] =3D { 25675, 0x1, 0x47, 0xA38E4, 0x85C =
},
+       [ATHOS_LUT_CHAN_642000_IDX] =3D { 25680, 0x1, 0x47, 0xAAAAB, 0x85C =
},
+       [ATHOS_LUT_CHAN_642125_IDX] =3D { 25685, 0x1, 0x47, 0xB1C72, 0x85C =
},
+       [ATHOS_LUT_CHAN_642250_IDX] =3D { 25690, 0x1, 0x47, 0xB8E39, 0x85D =
},
+       [ATHOS_LUT_CHAN_642375_IDX] =3D { 25695, 0x1, 0x47, 0xC0000, 0x85D =
},
+       [ATHOS_LUT_CHAN_642500_IDX] =3D { 25700, 0x1, 0x47, 0xC71C7, 0x85E =
},
+       [ATHOS_LUT_CHAN_642625_IDX] =3D { 25705, 0x1, 0x47, 0xCE38E, 0x85E =
},
+       [ATHOS_LUT_CHAN_642750_IDX] =3D { 25710, 0x1, 0x47, 0xD5555, 0x85F =
},
+       [ATHOS_LUT_CHAN_642875_IDX] =3D { 25715, 0x1, 0x47, 0xDC71C, 0x85F =
},
+       [ATHOS_LUT_CHAN_643000_IDX] =3D { 25720, 0x1, 0x47, 0xE38E4, 0x85F =
},
+       [ATHOS_LUT_CHAN_643125_IDX] =3D { 25725, 0x1, 0x47, 0xEAAAB, 0x860 =
},
+       [ATHOS_LUT_CHAN_643250_IDX] =3D { 25730, 0x1, 0x47, 0xF1C72, 0x860 =
},
+       [ATHOS_LUT_CHAN_643375_IDX] =3D { 25735, 0x1, 0x47, 0xF8E39, 0x861 =
},
+       [ATHOS_LUT_CHAN_643500_IDX] =3D { 25740, 0x1, 0x47, 0x100000, 0x861=
 },
+       [ATHOS_LUT_CHAN_643625_IDX] =3D { 25745, 0x1, 0x47, 0x1071C7, 0x861=
 },
+       [ATHOS_LUT_CHAN_643750_IDX] =3D { 25750, 0x1, 0x47, 0x10E38E, 0x862=
 },
+       [ATHOS_LUT_CHAN_643875_IDX] =3D { 25755, 0x1, 0x47, 0x115555, 0x862=
 },
+       [ATHOS_LUT_CHAN_644000_IDX] =3D { 25760, 0x1, 0x47, 0x11C71C, 0x863=
 },
+       [ATHOS_LUT_CHAN_644125_IDX] =3D { 25765, 0x1, 0x47, 0x1238E4, 0x863=
 },
+       [ATHOS_LUT_CHAN_644250_IDX] =3D { 25770, 0x1, 0x47, 0x12AAAB, 0x864=
 },
+       [ATHOS_LUT_CHAN_644375_IDX] =3D { 25775, 0x1, 0x47, 0x131C72, 0x864=
 },
+       [ATHOS_LUT_CHAN_644500_IDX] =3D { 25780, 0x1, 0x47, 0x138E39, 0x864=
 },
+       [ATHOS_LUT_CHAN_644625_IDX] =3D { 25785, 0x1, 0x47, 0x140000, 0x865=
 },
+       [ATHOS_LUT_CHAN_644750_IDX] =3D { 25790, 0x1, 0x47, 0x1471C7, 0x865=
 },
+       [ATHOS_LUT_CHAN_644875_IDX] =3D { 25795, 0x1, 0x47, 0x14E38E, 0x866=
 },
+       [ATHOS_LUT_CHAN_645000_IDX] =3D { 25800, 0x1, 0x47, 0x155555, 0x866=
 },
+       [ATHOS_LUT_CHAN_645125_IDX] =3D { 25805, 0x1, 0x47, 0x15C71C, 0x866=
 },
+       [ATHOS_LUT_CHAN_645250_IDX] =3D { 25810, 0x1, 0x47, 0x1638E4, 0x867=
 },
+       [ATHOS_LUT_CHAN_645375_IDX] =3D { 25815, 0x1, 0x47, 0x16AAAB, 0x867=
 },
+       [ATHOS_LUT_CHAN_645500_IDX] =3D { 25820, 0x1, 0x47, 0x171C72, 0x868=
 },
+       [ATHOS_LUT_CHAN_645625_IDX] =3D { 25825, 0x1, 0x47, 0x178E39, 0x868=
 },
+       [ATHOS_LUT_CHAN_645750_IDX] =3D { 25830, 0x1, 0x47, 0x180000, 0x869=
 },
+       [ATHOS_LUT_CHAN_645875_IDX] =3D { 25835, 0x1, 0x47, 0x1871C7, 0x869=
 },
+       [ATHOS_LUT_CHAN_646000_IDX] =3D { 25840, 0x1, 0x47, 0x18E38E, 0x869=
 },
+       [ATHOS_LUT_CHAN_646125_IDX] =3D { 25845, 0x1, 0x47, 0x195555, 0x86A=
 },
+       [ATHOS_LUT_CHAN_646250_IDX] =3D { 25850, 0x1, 0x47, 0x19C71C, 0x86A=
 },
+       [ATHOS_LUT_CHAN_646375_IDX] =3D { 25855, 0x1, 0x47, 0x1A38E4, 0x86B=
 },
+       [ATHOS_LUT_CHAN_646500_IDX] =3D { 25860, 0x1, 0x47, 0x1AAAAB, 0x86B=
 },
+       [ATHOS_LUT_CHAN_646625_IDX] =3D { 25865, 0x1, 0x47, 0x1B1C72, 0x86B=
 },
+       [ATHOS_LUT_CHAN_646750_IDX] =3D { 25870, 0x1, 0x47, 0x1B8E39, 0x86C=
 },
+       [ATHOS_LUT_CHAN_646875_IDX] =3D { 25875, 0x1, 0x47, 0x1C0000, 0x86C=
 },
+       [ATHOS_LUT_CHAN_647000_IDX] =3D { 25880, 0x1, 0x47, 0x1C71C7, 0x86D=
 },
+       [ATHOS_LUT_CHAN_647125_IDX] =3D { 25885, 0x1, 0x47, 0x1CE38E, 0x86D=
 },
+       [ATHOS_LUT_CHAN_647250_IDX] =3D { 25890, 0x1, 0x47, 0x1D5555, 0x86E=
 },
+       [ATHOS_LUT_CHAN_647375_IDX] =3D { 25895, 0x1, 0x47, 0x1DC71C, 0x86E=
 },
+       [ATHOS_LUT_CHAN_647500_IDX] =3D { 25900, 0x1, 0x47, 0x1E38E4, 0x86E=
 },
+       [ATHOS_LUT_CHAN_647625_IDX] =3D { 25905, 0x1, 0x47, 0x1EAAAB, 0x86F=
 },
+       [ATHOS_LUT_CHAN_647750_IDX] =3D { 25910, 0x1, 0x47, 0x1F1C72, 0x86F=
 },
+       [ATHOS_LUT_CHAN_647875_IDX] =3D { 25915, 0x1, 0x47, 0x1F8E39, 0x870=
 },
+       [ATHOS_LUT_CHAN_648000_IDX] =3D { 25920, 0x1, 0x48, 0x0, 0x870 },
+       [ATHOS_LUT_CHAN_648125_IDX] =3D { 25925, 0x1, 0x48, 0x71C7, 0x870 }=
,
+       [ATHOS_LUT_CHAN_648250_IDX] =3D { 25930, 0x1, 0x48, 0xE38E, 0x871 }=
,
+       [ATHOS_LUT_CHAN_648375_IDX] =3D { 25935, 0x1, 0x48, 0x15555, 0x871 =
},
+       [ATHOS_LUT_CHAN_648500_IDX] =3D { 25940, 0x1, 0x48, 0x1C71C, 0x872 =
},
+       [ATHOS_LUT_CHAN_648625_IDX] =3D { 25945, 0x1, 0x48, 0x238E4, 0x872 =
},
+       [ATHOS_LUT_CHAN_648750_IDX] =3D { 25950, 0x1, 0x48, 0x2AAAB, 0x873 =
},
+       [ATHOS_LUT_CHAN_648875_IDX] =3D { 25955, 0x1, 0x48, 0x31C72, 0x873 =
},
+       [ATHOS_LUT_CHAN_649000_IDX] =3D { 25960, 0x1, 0x48, 0x38E39, 0x873 =
},
+       [ATHOS_LUT_CHAN_649125_IDX] =3D { 25965, 0x1, 0x48, 0x40000, 0x874 =
},
+       [ATHOS_LUT_CHAN_649250_IDX] =3D { 25970, 0x1, 0x48, 0x471C7, 0x874 =
},
+       [ATHOS_LUT_CHAN_649375_IDX] =3D { 25975, 0x1, 0x48, 0x4E38E, 0x875 =
},
+       [ATHOS_LUT_CHAN_649500_IDX] =3D { 25980, 0x1, 0x48, 0x55555, 0x875 =
},
+       [ATHOS_LUT_CHAN_649625_IDX] =3D { 25985, 0x1, 0x48, 0x5C71C, 0x875 =
},
+       [ATHOS_LUT_CHAN_649750_IDX] =3D { 25990, 0x1, 0x48, 0x638E4, 0x876 =
},
+       [ATHOS_LUT_CHAN_649875_IDX] =3D { 25995, 0x1, 0x48, 0x6AAAB, 0x876 =
},
+       [ATHOS_LUT_CHAN_650000_IDX] =3D { 26000, 0x1, 0x48, 0x71C72, 0x877 =
},
+       [ATHOS_LUT_CHAN_650125_IDX] =3D { 26005, 0x1, 0x48, 0x78E39, 0x877 =
},
+       [ATHOS_LUT_CHAN_650250_IDX] =3D { 26010, 0x1, 0x48, 0x80000, 0x878 =
},
+       [ATHOS_LUT_CHAN_650375_IDX] =3D { 26015, 0x1, 0x48, 0x871C7, 0x878 =
},
+       [ATHOS_LUT_CHAN_650500_IDX] =3D { 26020, 0x1, 0x48, 0x8E38E, 0x878 =
},
+       [ATHOS_LUT_CHAN_650625_IDX] =3D { 26025, 0x1, 0x48, 0x95555, 0x879 =
},
+       [ATHOS_LUT_CHAN_650750_IDX] =3D { 26030, 0x1, 0x48, 0x9C71C, 0x879 =
},
+       [ATHOS_LUT_CHAN_650875_IDX] =3D { 26035, 0x1, 0x48, 0xA38E4, 0x87A =
},
+       [ATHOS_LUT_CHAN_651000_IDX] =3D { 26040, 0x1, 0x48, 0xAAAAB, 0x87A =
},
+       [ATHOS_LUT_CHAN_651125_IDX] =3D { 26045, 0x1, 0x48, 0xB1C72, 0x87A =
},
+       [ATHOS_LUT_CHAN_651250_IDX] =3D { 26050, 0x1, 0x48, 0xB8E39, 0x87B =
},
+       [ATHOS_LUT_CHAN_651375_IDX] =3D { 26055, 0x1, 0x48, 0xC0000, 0x87B =
},
+       [ATHOS_LUT_CHAN_651500_IDX] =3D { 26060, 0x1, 0x48, 0xC71C7, 0x87C =
},
+       [ATHOS_LUT_CHAN_651625_IDX] =3D { 26065, 0x1, 0x48, 0xCE38E, 0x87C =
},
+       [ATHOS_LUT_CHAN_651750_IDX] =3D { 26070, 0x1, 0x48, 0xD5555, 0x87D =
},
+       [ATHOS_LUT_CHAN_651875_IDX] =3D { 26075, 0x1, 0x48, 0xDC71C, 0x87D =
},
+       [ATHOS_LUT_CHAN_652000_IDX] =3D { 26080, 0x1, 0x48, 0xE38E4, 0x87D =
},
+       [ATHOS_LUT_CHAN_652125_IDX] =3D { 26085, 0x1, 0x48, 0xEAAAB, 0x87E =
},
+       [ATHOS_LUT_CHAN_652250_IDX] =3D { 26090, 0x1, 0x48, 0xF1C72, 0x87E =
},
+       [ATHOS_LUT_CHAN_652375_IDX] =3D { 26095, 0x1, 0x48, 0xF8E39, 0x87F =
},
+       [ATHOS_LUT_CHAN_652500_IDX] =3D { 26100, 0x1, 0x48, 0x100000, 0x87F=
 },
+       [ATHOS_LUT_CHAN_652625_IDX] =3D { 26105, 0x1, 0x48, 0x1071C7, 0x87F=
 },
+       [ATHOS_LUT_CHAN_652750_IDX] =3D { 26110, 0x1, 0x48, 0x10E38E, 0x880=
 },
+       [ATHOS_LUT_CHAN_652875_IDX] =3D { 26115, 0x1, 0x48, 0x115555, 0x880=
 },
+       [ATHOS_LUT_CHAN_653000_IDX] =3D { 26120, 0x1, 0x48, 0x11C71C, 0x881=
 },
+       [ATHOS_LUT_CHAN_653125_IDX] =3D { 26125, 0x1, 0x48, 0x1238E4, 0x881=
 },
+       [ATHOS_LUT_CHAN_653250_IDX] =3D { 26130, 0x1, 0x48, 0x12AAAB, 0x882=
 },
+       [ATHOS_LUT_CHAN_653375_IDX] =3D { 26135, 0x1, 0x48, 0x131C72, 0x882=
 },
+       [ATHOS_LUT_CHAN_653500_IDX] =3D { 26140, 0x1, 0x48, 0x138E39, 0x882=
 },
+       [ATHOS_LUT_CHAN_653625_IDX] =3D { 26145, 0x1, 0x48, 0x140000, 0x883=
 },
+       [ATHOS_LUT_CHAN_653750_IDX] =3D { 26150, 0x1, 0x48, 0x1471C7, 0x883=
 },
+       [ATHOS_LUT_CHAN_653875_IDX] =3D { 26155, 0x1, 0x48, 0x14E38E, 0x884=
 },
+       [ATHOS_LUT_CHAN_654000_IDX] =3D { 26160, 0x1, 0x48, 0x155555, 0x884=
 },
+       [ATHOS_LUT_CHAN_654125_IDX] =3D { 26165, 0x1, 0x48, 0x15C71C, 0x884=
 },
+       [ATHOS_LUT_CHAN_654250_IDX] =3D { 26170, 0x1, 0x48, 0x1638E4, 0x885=
 },
+       [ATHOS_LUT_CHAN_654375_IDX] =3D { 26175, 0x1, 0x48, 0x16AAAB, 0x885=
 },
+       [ATHOS_LUT_CHAN_654500_IDX] =3D { 26180, 0x1, 0x48, 0x171C72, 0x886=
 },
+       [ATHOS_LUT_CHAN_654625_IDX] =3D { 26185, 0x1, 0x48, 0x178E39, 0x886=
 },
+       [ATHOS_LUT_CHAN_654750_IDX] =3D { 26190, 0x1, 0x48, 0x180000, 0x887=
 },
+       [ATHOS_LUT_CHAN_654875_IDX] =3D { 26195, 0x1, 0x48, 0x1871C7, 0x887=
 },
+       [ATHOS_LUT_CHAN_655000_IDX] =3D { 26200, 0x1, 0x48, 0x18E38E, 0x887=
 },
+       [ATHOS_LUT_CHAN_655125_IDX] =3D { 26205, 0x1, 0x48, 0x195555, 0x888=
 },
+       [ATHOS_LUT_CHAN_655250_IDX] =3D { 26210, 0x1, 0x48, 0x19C71C, 0x888=
 },
+       [ATHOS_LUT_CHAN_655375_IDX] =3D { 26215, 0x1, 0x48, 0x1A38E4, 0x889=
 },
+       [ATHOS_LUT_CHAN_655500_IDX] =3D { 26220, 0x1, 0x48, 0x1AAAAB, 0x889=
 },
+       [ATHOS_LUT_CHAN_655625_IDX] =3D { 26225, 0x1, 0x48, 0x1B1C72, 0x889=
 },
+       [ATHOS_LUT_CHAN_655750_IDX] =3D { 26230, 0x1, 0x48, 0x1B8E39, 0x88A=
 },
+       [ATHOS_LUT_CHAN_655875_IDX] =3D { 26235, 0x1, 0x48, 0x1C0000, 0x88A=
 },
+       [ATHOS_LUT_CHAN_656000_IDX] =3D { 26240, 0x1, 0x48, 0x1C71C7, 0x88B=
 },
+       [ATHOS_LUT_CHAN_656125_IDX] =3D { 26245, 0x1, 0x48, 0x1CE38E, 0x88B=
 },
+       [ATHOS_LUT_CHAN_656250_IDX] =3D { 26250, 0x1, 0x48, 0x1D5555, 0x88C=
 },
+       [ATHOS_LUT_CHAN_656375_IDX] =3D { 26255, 0x1, 0x48, 0x1DC71C, 0x88C=
 },
+       [ATHOS_LUT_CHAN_656500_IDX] =3D { 26260, 0x1, 0x48, 0x1E38E4, 0x88C=
 },
+       [ATHOS_LUT_CHAN_656625_IDX] =3D { 26265, 0x1, 0x48, 0x1EAAAB, 0x88D=
 },
+       [ATHOS_LUT_CHAN_656750_IDX] =3D { 26270, 0x1, 0x48, 0x1F1C72, 0x88D=
 },
+       [ATHOS_LUT_CHAN_656875_IDX] =3D { 26275, 0x1, 0x48, 0x1F8E39, 0x88E=
 },
+       [ATHOS_LUT_CHAN_657000_IDX] =3D { 26280, 0x1, 0x49, 0x0, 0x88E },
+       [ATHOS_LUT_CHAN_657125_IDX] =3D { 26285, 0x1, 0x49, 0x71C7, 0x88E }=
,
+       [ATHOS_LUT_CHAN_657250_IDX] =3D { 26290, 0x1, 0x49, 0xE38E, 0x88F }=
,
+       [ATHOS_LUT_CHAN_657375_IDX] =3D { 26295, 0x1, 0x49, 0x15555, 0x88F =
},
+       [ATHOS_LUT_CHAN_657500_IDX] =3D { 26300, 0x1, 0x49, 0x1C71C, 0x890 =
},
+       [ATHOS_LUT_CHAN_657625_IDX] =3D { 26305, 0x1, 0x49, 0x238E4, 0x890 =
},
+       [ATHOS_LUT_CHAN_657750_IDX] =3D { 26310, 0x1, 0x49, 0x2AAAB, 0x891 =
},
+       [ATHOS_LUT_CHAN_657875_IDX] =3D { 26315, 0x1, 0x49, 0x31C72, 0x891 =
},
+       [ATHOS_LUT_CHAN_658000_IDX] =3D { 26320, 0x1, 0x49, 0x38E39, 0x891 =
},
+       [ATHOS_LUT_CHAN_658125_IDX] =3D { 26325, 0x1, 0x49, 0x40000, 0x892 =
},
+       [ATHOS_LUT_CHAN_658250_IDX] =3D { 26330, 0x1, 0x49, 0x471C7, 0x892 =
},
+       [ATHOS_LUT_CHAN_658375_IDX] =3D { 26335, 0x1, 0x49, 0x4E38E, 0x893 =
},
+       [ATHOS_LUT_CHAN_658500_IDX] =3D { 26340, 0x1, 0x49, 0x55555, 0x893 =
},
+       [ATHOS_LUT_CHAN_658625_IDX] =3D { 26345, 0x1, 0x49, 0x5C71C, 0x893 =
},
+       [ATHOS_LUT_CHAN_658750_IDX] =3D { 26350, 0x1, 0x49, 0x638E4, 0x894 =
},
+       [ATHOS_LUT_CHAN_658875_IDX] =3D { 26355, 0x1, 0x49, 0x6AAAB, 0x894 =
},
+       [ATHOS_LUT_CHAN_659000_IDX] =3D { 26360, 0x1, 0x49, 0x71C72, 0x895 =
},
+       [ATHOS_LUT_CHAN_659125_IDX] =3D { 26365, 0x1, 0x49, 0x78E39, 0x895 =
},
+       [ATHOS_LUT_CHAN_659250_IDX] =3D { 26370, 0x1, 0x49, 0x80000, 0x896 =
},
+       [ATHOS_LUT_CHAN_659375_IDX] =3D { 26375, 0x1, 0x49, 0x871C7, 0x896 =
},
+       [ATHOS_LUT_CHAN_659500_IDX] =3D { 26380, 0x1, 0x49, 0x8E38E, 0x896 =
},
+       [ATHOS_LUT_CHAN_659625_IDX] =3D { 26385, 0x1, 0x49, 0x95555, 0x897 =
},
+       [ATHOS_LUT_CHAN_659750_IDX] =3D { 26390, 0x1, 0x49, 0x9C71C, 0x897 =
},
+       [ATHOS_LUT_CHAN_659875_IDX] =3D { 26395, 0x1, 0x49, 0xA38E4, 0x898 =
},
+       [ATHOS_LUT_CHAN_660000_IDX] =3D { 26400, 0x1, 0x49, 0xAAAAB, 0x898 =
},
+       [ATHOS_LUT_CHAN_660125_IDX] =3D { 26405, 0x1, 0x49, 0xB1C72, 0x898 =
},
+       [ATHOS_LUT_CHAN_660250_IDX] =3D { 26410, 0x1, 0x49, 0xB8E39, 0x899 =
},
+       [ATHOS_LUT_CHAN_660375_IDX] =3D { 26415, 0x1, 0x49, 0xC0000, 0x899 =
},
+       [ATHOS_LUT_CHAN_660500_IDX] =3D { 26420, 0x1, 0x49, 0xC71C7, 0x89A =
},
+       [ATHOS_LUT_CHAN_660625_IDX] =3D { 26425, 0x1, 0x49, 0xCE38E, 0x89A =
},
+       [ATHOS_LUT_CHAN_660750_IDX] =3D { 26430, 0x1, 0x49, 0xD5555, 0x89B =
},
+       [ATHOS_LUT_CHAN_660875_IDX] =3D { 26435, 0x1, 0x49, 0xDC71C, 0x89B =
},
+       [ATHOS_LUT_CHAN_661000_IDX] =3D { 26440, 0x1, 0x49, 0xE38E4, 0x89B =
},
+       [ATHOS_LUT_CHAN_661125_IDX] =3D { 26445, 0x1, 0x49, 0xEAAAB, 0x89C =
},
+       [ATHOS_LUT_CHAN_661250_IDX] =3D { 26450, 0x1, 0x49, 0xF1C72, 0x89C =
},
+       [ATHOS_LUT_CHAN_661375_IDX] =3D { 26455, 0x1, 0x49, 0xF8E39, 0x89D =
},
+       [ATHOS_LUT_CHAN_661500_IDX] =3D { 26460, 0x1, 0x49, 0x100000, 0x89D=
 },
+       [ATHOS_LUT_CHAN_661625_IDX] =3D { 26465, 0x1, 0x49, 0x1071C7, 0x89D=
 },
+       [ATHOS_LUT_CHAN_661750_IDX] =3D { 26470, 0x1, 0x49, 0x10E38E, 0x89E=
 },
+       [ATHOS_LUT_CHAN_661875_IDX] =3D { 26475, 0x1, 0x49, 0x115555, 0x89E=
 },
+       [ATHOS_LUT_CHAN_662000_IDX] =3D { 26480, 0x1, 0x49, 0x11C71C, 0x89F=
 },
+       [ATHOS_LUT_CHAN_662125_IDX] =3D { 26485, 0x1, 0x49, 0x1238E4, 0x89F=
 },
+       [ATHOS_LUT_CHAN_662250_IDX] =3D { 26490, 0x1, 0x49, 0x12AAAB, 0x8A0=
 },
+       [ATHOS_LUT_CHAN_662375_IDX] =3D { 26495, 0x1, 0x49, 0x131C72, 0x8A0=
 },
+       [ATHOS_LUT_CHAN_662500_IDX] =3D { 26500, 0x1, 0x49, 0x138E39, 0x8A0=
 },
+       [ATHOS_LUT_CHAN_662625_IDX] =3D { 26505, 0x1, 0x49, 0x140000, 0x8A1=
 },
+       [ATHOS_LUT_CHAN_662750_IDX] =3D { 26510, 0x1, 0x49, 0x1471C7, 0x8A1=
 },
+       [ATHOS_LUT_CHAN_662875_IDX] =3D { 26515, 0x1, 0x49, 0x14E38E, 0x8A2=
 },
+       [ATHOS_LUT_CHAN_663000_IDX] =3D { 26520, 0x1, 0x49, 0x155555, 0x8A2=
 },
+       [ATHOS_LUT_CHAN_663125_IDX] =3D { 26525, 0x1, 0x49, 0x15C71C, 0x8A2=
 },
+       [ATHOS_LUT_CHAN_663250_IDX] =3D { 26530, 0x1, 0x49, 0x1638E4, 0x8A3=
 },
+       [ATHOS_LUT_CHAN_663375_IDX] =3D { 26535, 0x1, 0x49, 0x16AAAB, 0x8A3=
 },
+       [ATHOS_LUT_CHAN_663500_IDX] =3D { 26540, 0x1, 0x49, 0x171C72, 0x8A4=
 },
+       [ATHOS_LUT_CHAN_663625_IDX] =3D { 26545, 0x1, 0x49, 0x178E39, 0x8A4=
 },
+       [ATHOS_LUT_CHAN_663750_IDX] =3D { 26550, 0x1, 0x49, 0x180000, 0x8A5=
 },
+       [ATHOS_LUT_CHAN_663875_IDX] =3D { 26555, 0x1, 0x49, 0x1871C7, 0x8A5=
 },
+       [ATHOS_LUT_CHAN_664000_IDX] =3D { 26560, 0x1, 0x49, 0x18E38E, 0x8A5=
 },
+       [ATHOS_LUT_CHAN_664125_IDX] =3D { 26565, 0x1, 0x49, 0x195555, 0x8A6=
 },
+       [ATHOS_LUT_CHAN_664250_IDX] =3D { 26570, 0x1, 0x49, 0x19C71C, 0x8A6=
 },
+       [ATHOS_LUT_CHAN_664375_IDX] =3D { 26575, 0x1, 0x49, 0x1A38E4, 0x8A7=
 },
+       [ATHOS_LUT_CHAN_664500_IDX] =3D { 26580, 0x1, 0x49, 0x1AAAAB, 0x8A7=
 },
+       [ATHOS_LUT_CHAN_664625_IDX] =3D { 26585, 0x1, 0x49, 0x1B1C72, 0x8A7=
 },
+       [ATHOS_LUT_CHAN_664750_IDX] =3D { 26590, 0x1, 0x49, 0x1B8E39, 0x8A8=
 },
+       [ATHOS_LUT_CHAN_664875_IDX] =3D { 26595, 0x1, 0x49, 0x1C0000, 0x8A8=
 },
+       [ATHOS_LUT_CHAN_665000_IDX] =3D { 26600, 0x1, 0x49, 0x1C71C7, 0x8A9=
 },
+       [ATHOS_LUT_CHAN_665125_IDX] =3D { 26605, 0x1, 0x49, 0x1CE38E, 0x8A9=
 },
+       [ATHOS_LUT_CHAN_665250_IDX] =3D { 26610, 0x1, 0x49, 0x1D5555, 0x8AA=
 },
+       [ATHOS_LUT_CHAN_665375_IDX] =3D { 26615, 0x1, 0x49, 0x1DC71C, 0x8AA=
 },
+       [ATHOS_LUT_CHAN_665500_IDX] =3D { 26620, 0x1, 0x49, 0x1E38E4, 0x8AA=
 },
+       [ATHOS_LUT_CHAN_665625_IDX] =3D { 26625, 0x1, 0x49, 0x1EAAAB, 0x8AB=
 },
+       [ATHOS_LUT_CHAN_665750_IDX] =3D { 26630, 0x1, 0x49, 0x1F1C72, 0x8AB=
 },
+       [ATHOS_LUT_CHAN_665875_IDX] =3D { 26635, 0x1, 0x49, 0x1F8E39, 0x8AC=
 },
+       [ATHOS_LUT_CHAN_666000_IDX] =3D { 26640, 0x1, 0x4A, 0x0, 0x8AC },
+       [ATHOS_LUT_CHAN_666125_IDX] =3D { 26645, 0x1, 0x4A, 0x71C7, 0x8AC }=
,
+       [ATHOS_LUT_CHAN_666250_IDX] =3D { 26650, 0x1, 0x4A, 0xE38E, 0x8AD }=
,
+       [ATHOS_LUT_CHAN_666375_IDX] =3D { 26655, 0x1, 0x4A, 0x15555, 0x8AD =
},
+       [ATHOS_LUT_CHAN_666500_IDX] =3D { 26660, 0x1, 0x4A, 0x1C71C, 0x8AE =
},
+       [ATHOS_LUT_CHAN_666625_IDX] =3D { 26665, 0x1, 0x4A, 0x238E4, 0x8AE =
},
+       [ATHOS_LUT_CHAN_666750_IDX] =3D { 26670, 0x1, 0x4A, 0x2AAAB, 0x8AF =
},
+       [ATHOS_LUT_CHAN_666875_IDX] =3D { 26675, 0x1, 0x4A, 0x31C72, 0x8AF =
},
+       [ATHOS_LUT_CHAN_667000_IDX] =3D { 26680, 0x1, 0x4A, 0x38E39, 0x8AF =
},
+       [ATHOS_LUT_CHAN_667125_IDX] =3D { 26685, 0x1, 0x4A, 0x40000, 0x8B0 =
},
+       [ATHOS_LUT_CHAN_667250_IDX] =3D { 26690, 0x1, 0x4A, 0x471C7, 0x8B0 =
},
+       [ATHOS_LUT_CHAN_667375_IDX] =3D { 26695, 0x1, 0x4A, 0x4E38E, 0x8B1 =
},
+       [ATHOS_LUT_CHAN_667500_IDX] =3D { 26700, 0x1, 0x4A, 0x55555, 0x8B1 =
},
+       [ATHOS_LUT_CHAN_667625_IDX] =3D { 26705, 0x1, 0x4A, 0x5C71C, 0x8B1 =
},
+       [ATHOS_LUT_CHAN_667750_IDX] =3D { 26710, 0x1, 0x4A, 0x638E4, 0x8B2 =
},
+       [ATHOS_LUT_CHAN_667875_IDX] =3D { 26715, 0x1, 0x4A, 0x6AAAB, 0x8B2 =
},
+       [ATHOS_LUT_CHAN_668000_IDX] =3D { 26720, 0x1, 0x4A, 0x71C72, 0x8B3 =
},
+       [ATHOS_LUT_CHAN_668125_IDX] =3D { 26725, 0x1, 0x4A, 0x78E39, 0x8B3 =
},
+       [ATHOS_LUT_CHAN_668250_IDX] =3D { 26730, 0x1, 0x4A, 0x80000, 0x8B4 =
},
+       [ATHOS_LUT_CHAN_668375_IDX] =3D { 26735, 0x1, 0x4A, 0x871C7, 0x8B4 =
},
+       [ATHOS_LUT_CHAN_668500_IDX] =3D { 26740, 0x1, 0x4A, 0x8E38E, 0x8B4 =
},
+       [ATHOS_LUT_CHAN_668625_IDX] =3D { 26745, 0x1, 0x4A, 0x95555, 0x8B5 =
},
+       [ATHOS_LUT_CHAN_668750_IDX] =3D { 26750, 0x1, 0x4A, 0x9C71C, 0x8B5 =
},
+       [ATHOS_LUT_CHAN_668875_IDX] =3D { 26755, 0x1, 0x4A, 0xA38E4, 0x8B6 =
},
+       [ATHOS_LUT_CHAN_669000_IDX] =3D { 26760, 0x1, 0x4A, 0xAAAAB, 0x8B6 =
},
+       [ATHOS_LUT_CHAN_669125_IDX] =3D { 26765, 0x1, 0x4A, 0xB1C72, 0x8B6 =
},
+       [ATHOS_LUT_CHAN_669250_IDX] =3D { 26770, 0x1, 0x4A, 0xB8E39, 0x8B7 =
},
+       [ATHOS_LUT_CHAN_669375_IDX] =3D { 26775, 0x1, 0x4A, 0xC0000, 0x8B7 =
},
+       [ATHOS_LUT_CHAN_669500_IDX] =3D { 26780, 0x1, 0x4A, 0xC71C7, 0x8B8 =
},
+       [ATHOS_LUT_CHAN_669625_IDX] =3D { 26785, 0x1, 0x4A, 0xCE38E, 0x8B8 =
},
+       [ATHOS_LUT_CHAN_669750_IDX] =3D { 26790, 0x1, 0x4A, 0xD5555, 0x8B9 =
},
+       [ATHOS_LUT_CHAN_669875_IDX] =3D { 26795, 0x1, 0x4A, 0xDC71C, 0x8B9 =
},
+       [ATHOS_LUT_CHAN_670000_IDX] =3D { 26800, 0x1, 0x4A, 0xE38E4, 0x8B9 =
},
+       [ATHOS_LUT_CHAN_670125_IDX] =3D { 26805, 0x1, 0x4A, 0xEAAAB, 0x8BA =
},
+       [ATHOS_LUT_CHAN_670250_IDX] =3D { 26810, 0x1, 0x4A, 0xF1C72, 0x8BA =
},
+       [ATHOS_LUT_CHAN_670375_IDX] =3D { 26815, 0x1, 0x4A, 0xF8E39, 0x8BB =
},
+       [ATHOS_LUT_CHAN_670500_IDX] =3D { 26820, 0x1, 0x4A, 0x100000, 0x8BB=
 },
+       [ATHOS_LUT_CHAN_670625_IDX] =3D { 26825, 0x1, 0x4A, 0x1071C7, 0x8BB=
 },
+       [ATHOS_LUT_CHAN_670750_IDX] =3D { 26830, 0x1, 0x4A, 0x10E38E, 0x8BC=
 },
+       [ATHOS_LUT_CHAN_670875_IDX] =3D { 26835, 0x1, 0x4A, 0x115555, 0x8BC=
 },
+       [ATHOS_LUT_CHAN_671000_IDX] =3D { 26840, 0x1, 0x4A, 0x11C71C, 0x8BD=
 },
+       [ATHOS_LUT_CHAN_671125_IDX] =3D { 26845, 0x1, 0x4A, 0x1238E4, 0x8BD=
 },
+       [ATHOS_LUT_CHAN_671250_IDX] =3D { 26850, 0x1, 0x4A, 0x12AAAB, 0x8BE=
 },
+       [ATHOS_LUT_CHAN_671375_IDX] =3D { 26855, 0x1, 0x4A, 0x131C72, 0x8BE=
 },
+       [ATHOS_LUT_CHAN_671500_IDX] =3D { 26860, 0x1, 0x4A, 0x138E39, 0x8BE=
 },
+       [ATHOS_LUT_CHAN_671625_IDX] =3D { 26865, 0x1, 0x4A, 0x140000, 0x8BF=
 },
+       [ATHOS_LUT_CHAN_671750_IDX] =3D { 26870, 0x1, 0x4A, 0x1471C7, 0x8BF=
 },
+       [ATHOS_LUT_CHAN_671875_IDX] =3D { 26875, 0x1, 0x4A, 0x14E38E, 0x8C0=
 },
+       [ATHOS_LUT_CHAN_672000_IDX] =3D { 26880, 0x1, 0x4A, 0x155555, 0x8C0=
 },
+       [ATHOS_LUT_CHAN_672125_IDX] =3D { 26885, 0x1, 0x4A, 0x15C71C, 0x8C0=
 },
+       [ATHOS_LUT_CHAN_672250_IDX] =3D { 26890, 0x1, 0x4A, 0x1638E4, 0x8C1=
 },
+       [ATHOS_LUT_CHAN_672375_IDX] =3D { 26895, 0x1, 0x4A, 0x16AAAB, 0x8C1=
 },
+       [ATHOS_LUT_CHAN_672500_IDX] =3D { 26900, 0x1, 0x4A, 0x171C72, 0x8C2=
 },
+       [ATHOS_LUT_CHAN_672625_IDX] =3D { 26905, 0x1, 0x4A, 0x178E39, 0x8C2=
 },
+       [ATHOS_LUT_CHAN_672750_IDX] =3D { 26910, 0x1, 0x4A, 0x180000, 0x8C3=
 },
+       [ATHOS_LUT_CHAN_672875_IDX] =3D { 26915, 0x1, 0x4A, 0x1871C7, 0x8C3=
 },
+       [ATHOS_LUT_CHAN_673000_IDX] =3D { 26920, 0x1, 0x4A, 0x18E38E, 0x8C3=
 },
+       [ATHOS_LUT_CHAN_673125_IDX] =3D { 26925, 0x1, 0x4A, 0x195555, 0x8C4=
 },
+       [ATHOS_LUT_CHAN_673250_IDX] =3D { 26930, 0x1, 0x4A, 0x19C71C, 0x8C4=
 },
+       [ATHOS_LUT_CHAN_673375_IDX] =3D { 26935, 0x1, 0x4A, 0x1A38E4, 0x8C5=
 },
+       [ATHOS_LUT_CHAN_673500_IDX] =3D { 26940, 0x1, 0x4A, 0x1AAAAB, 0x8C5=
 },
+       [ATHOS_LUT_CHAN_673625_IDX] =3D { 26945, 0x1, 0x4A, 0x1B1C72, 0x8C5=
 },
+       [ATHOS_LUT_CHAN_673750_IDX] =3D { 26950, 0x1, 0x4A, 0x1B8E39, 0x8C6=
 },
+       [ATHOS_LUT_CHAN_673875_IDX] =3D { 26955, 0x1, 0x4A, 0x1C0000, 0x8C6=
 },
+       [ATHOS_LUT_CHAN_674000_IDX] =3D { 26960, 0x1, 0x4A, 0x1C71C7, 0x8C7=
 },
+       [ATHOS_LUT_CHAN_674125_IDX] =3D { 26965, 0x1, 0x4A, 0x1CE38E, 0x8C7=
 },
+       [ATHOS_LUT_CHAN_674250_IDX] =3D { 26970, 0x1, 0x4A, 0x1D5555, 0x8C8=
 },
+       [ATHOS_LUT_CHAN_674375_IDX] =3D { 26975, 0x1, 0x4A, 0x1DC71C, 0x8C8=
 },
+       [ATHOS_LUT_CHAN_674500_IDX] =3D { 26980, 0x1, 0x4A, 0x1E38E4, 0x8C8=
 },
+       [ATHOS_LUT_CHAN_674625_IDX] =3D { 26985, 0x1, 0x4A, 0x1EAAAB, 0x8C9=
 },
+       [ATHOS_LUT_CHAN_674750_IDX] =3D { 26990, 0x1, 0x4A, 0x1F1C72, 0x8C9=
 },
+       [ATHOS_LUT_CHAN_674875_IDX] =3D { 26995, 0x1, 0x4A, 0x1F8E39, 0x8CA=
 },
+       [ATHOS_LUT_CHAN_675000_IDX] =3D { 27000, 0x1, 0x4B, 0x0, 0x8CA },
+       [ATHOS_LUT_CHAN_675125_IDX] =3D { 27005, 0x1, 0x4B, 0x71C7, 0x8CA }=
,
+       [ATHOS_LUT_CHAN_675250_IDX] =3D { 27010, 0x1, 0x4B, 0xE38E, 0x8CB }=
,
+       [ATHOS_LUT_CHAN_675375_IDX] =3D { 27015, 0x1, 0x4B, 0x15555, 0x8CB =
},
+       [ATHOS_LUT_CHAN_675500_IDX] =3D { 27020, 0x1, 0x4B, 0x1C71C, 0x8CC =
},
+       [ATHOS_LUT_CHAN_675625_IDX] =3D { 27025, 0x1, 0x4B, 0x238E4, 0x8CC =
},
+       [ATHOS_LUT_CHAN_675750_IDX] =3D { 27030, 0x1, 0x4B, 0x2AAAB, 0x8CD =
},
+       [ATHOS_LUT_CHAN_675875_IDX] =3D { 27035, 0x1, 0x4B, 0x31C72, 0x8CD =
},
+       [ATHOS_LUT_CHAN_676000_IDX] =3D { 27040, 0x1, 0x4B, 0x38E39, 0x8CD =
},
+       [ATHOS_LUT_CHAN_676125_IDX] =3D { 27045, 0x1, 0x4B, 0x40000, 0x8CE =
},
+       [ATHOS_LUT_CHAN_676250_IDX] =3D { 27050, 0x1, 0x4B, 0x471C7, 0x8CE =
},
+       [ATHOS_LUT_CHAN_676375_IDX] =3D { 27055, 0x1, 0x4B, 0x4E38E, 0x8CF =
},
+       [ATHOS_LUT_CHAN_676500_IDX] =3D { 27060, 0x1, 0x4B, 0x55555, 0x8CF =
},
+       [ATHOS_LUT_CHAN_676625_IDX] =3D { 27065, 0x1, 0x4B, 0x5C71C, 0x8CF =
},
+       [ATHOS_LUT_CHAN_676750_IDX] =3D { 27070, 0x1, 0x4B, 0x638E4, 0x8D0 =
},
+       [ATHOS_LUT_CHAN_676875_IDX] =3D { 27075, 0x1, 0x4B, 0x6AAAB, 0x8D0 =
},
+       [ATHOS_LUT_CHAN_677000_IDX] =3D { 27080, 0x1, 0x4B, 0x71C72, 0x8D1 =
},
+       [ATHOS_LUT_CHAN_677125_IDX] =3D { 27085, 0x1, 0x4B, 0x78E39, 0x8D1 =
},
+       [ATHOS_LUT_CHAN_677250_IDX] =3D { 27090, 0x1, 0x4B, 0x80000, 0x8D2 =
},
+       [ATHOS_LUT_CHAN_677375_IDX] =3D { 27095, 0x1, 0x4B, 0x871C7, 0x8D2 =
},
+       [ATHOS_LUT_CHAN_677500_IDX] =3D { 27100, 0x1, 0x4B, 0x8E38E, 0x8D2 =
},
+       [ATHOS_LUT_CHAN_677625_IDX] =3D { 27105, 0x1, 0x4B, 0x95555, 0x8D3 =
},
+       [ATHOS_LUT_CHAN_677750_IDX] =3D { 27110, 0x1, 0x4B, 0x9C71C, 0x8D3 =
},
+       [ATHOS_LUT_CHAN_677875_IDX] =3D { 27115, 0x1, 0x4B, 0xA38E4, 0x8D4 =
},
+       [ATHOS_LUT_CHAN_678000_IDX] =3D { 27120, 0x1, 0x4B, 0xAAAAB, 0x8D4 =
},
+       [ATHOS_LUT_CHAN_678125_IDX] =3D { 27125, 0x1, 0x4B, 0xB1C72, 0x8D4 =
},
+       [ATHOS_LUT_CHAN_678250_IDX] =3D { 27130, 0x1, 0x4B, 0xB8E39, 0x8D5 =
},
+       [ATHOS_LUT_CHAN_678375_IDX] =3D { 27135, 0x1, 0x4B, 0xC0000, 0x8D5 =
},
+       [ATHOS_LUT_CHAN_678500_IDX] =3D { 27140, 0x1, 0x4B, 0xC71C7, 0x8D6 =
},
+       [ATHOS_LUT_CHAN_678625_IDX] =3D { 27145, 0x1, 0x4B, 0xCE38E, 0x8D6 =
},
+       [ATHOS_LUT_CHAN_678750_IDX] =3D { 27150, 0x1, 0x4B, 0xD5555, 0x8D7 =
},
+       [ATHOS_LUT_CHAN_678875_IDX] =3D { 27155, 0x1, 0x4B, 0xDC71C, 0x8D7 =
},
+       [ATHOS_LUT_CHAN_679000_IDX] =3D { 27160, 0x1, 0x4B, 0xE38E4, 0x8D7 =
},
+       [ATHOS_LUT_CHAN_679125_IDX] =3D { 27165, 0x1, 0x4B, 0xEAAAB, 0x8D8 =
},
+       [ATHOS_LUT_CHAN_679250_IDX] =3D { 27170, 0x1, 0x4B, 0xF1C72, 0x8D8 =
},
+       [ATHOS_LUT_CHAN_679375_IDX] =3D { 27175, 0x1, 0x4B, 0xF8E39, 0x8D9 =
},
+       [ATHOS_LUT_CHAN_679500_IDX] =3D { 27180, 0x1, 0x4B, 0x100000, 0x8D9=
 },
+       [ATHOS_LUT_CHAN_679625_IDX] =3D { 27185, 0x1, 0x4B, 0x1071C7, 0x8D9=
 },
+       [ATHOS_LUT_CHAN_679750_IDX] =3D { 27190, 0x1, 0x4B, 0x10E38E, 0x8DA=
 },
+       [ATHOS_LUT_CHAN_679875_IDX] =3D { 27195, 0x1, 0x4B, 0x115555, 0x8DA=
 },
+       [ATHOS_LUT_CHAN_680000_IDX] =3D { 27200, 0x1, 0x4B, 0x11C71C, 0x8DB=
 },
+       [ATHOS_LUT_CHAN_680125_IDX] =3D { 27205, 0x1, 0x4B, 0x1238E4, 0x8DB=
 },
+       [ATHOS_LUT_CHAN_680250_IDX] =3D { 27210, 0x1, 0x4B, 0x12AAAB, 0x8DC=
 },
+       [ATHOS_LUT_CHAN_680375_IDX] =3D { 27215, 0x1, 0x4B, 0x131C72, 0x8DC=
 },
+       [ATHOS_LUT_CHAN_680500_IDX] =3D { 27220, 0x1, 0x4B, 0x138E39, 0x8DC=
 },
+       [ATHOS_LUT_CHAN_680625_IDX] =3D { 27225, 0x1, 0x4B, 0x140000, 0x8DD=
 },
+       [ATHOS_LUT_CHAN_680750_IDX] =3D { 27230, 0x1, 0x4B, 0x1471C7, 0x8DD=
 },
+       [ATHOS_LUT_CHAN_680875_IDX] =3D { 27235, 0x1, 0x4B, 0x14E38E, 0x8DE=
 },
+       [ATHOS_LUT_CHAN_681000_IDX] =3D { 27240, 0x1, 0x4B, 0x155555, 0x8DE=
 },
+       [ATHOS_LUT_CHAN_681125_IDX] =3D { 27245, 0x1, 0x4B, 0x15C71C, 0x8DE=
 },
+       [ATHOS_LUT_CHAN_681250_IDX] =3D { 27250, 0x1, 0x4B, 0x1638E4, 0x8DF=
 },
+       [ATHOS_LUT_CHAN_681375_IDX] =3D { 27255, 0x1, 0x4B, 0x16AAAB, 0x8DF=
 },
+       [ATHOS_LUT_CHAN_681500_IDX] =3D { 27260, 0x1, 0x4B, 0x171C72, 0x8E0=
 },
+       [ATHOS_LUT_CHAN_681625_IDX] =3D { 27265, 0x1, 0x4B, 0x178E39, 0x8E0=
 },
+       [ATHOS_LUT_CHAN_681750_IDX] =3D { 27270, 0x1, 0x4B, 0x180000, 0x8E1=
 },
+       [ATHOS_LUT_CHAN_681875_IDX] =3D { 27275, 0x1, 0x4B, 0x1871C7, 0x8E1=
 },
+       [ATHOS_LUT_CHAN_682000_IDX] =3D { 27280, 0x1, 0x4B, 0x18E38E, 0x8E1=
 },
+       [ATHOS_LUT_CHAN_682125_IDX] =3D { 27285, 0x1, 0x4B, 0x195555, 0x8E2=
 },
+       [ATHOS_LUT_CHAN_682250_IDX] =3D { 27290, 0x1, 0x4B, 0x19C71C, 0x8E2=
 },
+       [ATHOS_LUT_CHAN_682375_IDX] =3D { 27295, 0x1, 0x4B, 0x1A38E4, 0x8E3=
 },
+       [ATHOS_LUT_CHAN_682500_IDX] =3D { 27300, 0x1, 0x4B, 0x1AAAAB, 0x8E3=
 },
+       [ATHOS_LUT_CHAN_682625_IDX] =3D { 27305, 0x1, 0x4B, 0x1B1C72, 0x8E3=
 },
+       [ATHOS_LUT_CHAN_682750_IDX] =3D { 27310, 0x1, 0x4B, 0x1B8E39, 0x8E4=
 },
+       [ATHOS_LUT_CHAN_682875_IDX] =3D { 27315, 0x1, 0x4B, 0x1C0000, 0x8E4=
 },
+       [ATHOS_LUT_CHAN_683000_IDX] =3D { 27320, 0x1, 0x4B, 0x1C71C7, 0x8E5=
 },
+       [ATHOS_LUT_CHAN_683125_IDX] =3D { 27325, 0x1, 0x4B, 0x1CE38E, 0x8E5=
 },
+       [ATHOS_LUT_CHAN_683250_IDX] =3D { 27330, 0x1, 0x4B, 0x1D5555, 0x8E6=
 },
+       [ATHOS_LUT_CHAN_683375_IDX] =3D { 27335, 0x1, 0x4B, 0x1DC71C, 0x8E6=
 },
+       [ATHOS_LUT_CHAN_683500_IDX] =3D { 27340, 0x1, 0x4B, 0x1E38E4, 0x8E6=
 },
+       [ATHOS_LUT_CHAN_683625_IDX] =3D { 27345, 0x1, 0x4B, 0x1EAAAB, 0x8E7=
 },
+       [ATHOS_LUT_CHAN_683750_IDX] =3D { 27350, 0x1, 0x4B, 0x1F1C72, 0x8E7=
 },
+       [ATHOS_LUT_CHAN_683875_IDX] =3D { 27355, 0x1, 0x4B, 0x1F8E39, 0x8E8=
 },
+       [ATHOS_LUT_CHAN_684000_IDX] =3D { 27360, 0x1, 0x4C, 0x0, 0x8E8 },
+       [ATHOS_LUT_CHAN_684125_IDX] =3D { 27365, 0x1, 0x4C, 0x71C7, 0x8E8 }=
,
+       [ATHOS_LUT_CHAN_684250_IDX] =3D { 27370, 0x1, 0x4C, 0xE38E, 0x8E9 }=
,
+       [ATHOS_LUT_CHAN_684375_IDX] =3D { 27375, 0x1, 0x4C, 0x15555, 0x8E9 =
},
+       [ATHOS_LUT_CHAN_684500_IDX] =3D { 27380, 0x1, 0x4C, 0x1C71C, 0x8EA =
},
+       [ATHOS_LUT_CHAN_684625_IDX] =3D { 27385, 0x1, 0x4C, 0x238E4, 0x8EA =
},
+       [ATHOS_LUT_CHAN_684750_IDX] =3D { 27390, 0x1, 0x4C, 0x2AAAB, 0x8EB =
},
+       [ATHOS_LUT_CHAN_684875_IDX] =3D { 27395, 0x1, 0x4C, 0x31C72, 0x8EB =
},
+       [ATHOS_LUT_CHAN_685000_IDX] =3D { 27400, 0x1, 0x4C, 0x38E39, 0x8EB =
},
+       [ATHOS_LUT_CHAN_685125_IDX] =3D { 27405, 0x1, 0x4C, 0x40000, 0x8EC =
},
+       [ATHOS_LUT_CHAN_685250_IDX] =3D { 27410, 0x1, 0x4C, 0x471C7, 0x8EC =
},
+       [ATHOS_LUT_CHAN_685375_IDX] =3D { 27415, 0x1, 0x4C, 0x4E38E, 0x8ED =
},
+       [ATHOS_LUT_CHAN_685500_IDX] =3D { 27420, 0x1, 0x4C, 0x55555, 0x8ED =
},
+       [ATHOS_LUT_CHAN_685625_IDX] =3D { 27425, 0x1, 0x4C, 0x5C71C, 0x8ED =
},
+       [ATHOS_LUT_CHAN_685750_IDX] =3D { 27430, 0x1, 0x4C, 0x638E4, 0x8EE =
},
+       [ATHOS_LUT_CHAN_685875_IDX] =3D { 27435, 0x1, 0x4C, 0x6AAAB, 0x8EE =
},
+       [ATHOS_LUT_CHAN_686000_IDX] =3D { 27440, 0x1, 0x4C, 0x71C72, 0x8EF =
},
+       [ATHOS_LUT_CHAN_686125_IDX] =3D { 27445, 0x1, 0x4C, 0x78E39, 0x8EF =
},
+       [ATHOS_LUT_CHAN_686250_IDX] =3D { 27450, 0x1, 0x4C, 0x80000, 0x8F0 =
},
+       [ATHOS_LUT_CHAN_686375_IDX] =3D { 27455, 0x1, 0x4C, 0x871C7, 0x8F0 =
},
+       [ATHOS_LUT_CHAN_686500_IDX] =3D { 27460, 0x1, 0x4C, 0x8E38E, 0x8F0 =
},
+       [ATHOS_LUT_CHAN_686625_IDX] =3D { 27465, 0x1, 0x4C, 0x95555, 0x8F1 =
},
+       [ATHOS_LUT_CHAN_686750_IDX] =3D { 27470, 0x1, 0x4C, 0x9C71C, 0x8F1 =
},
+       [ATHOS_LUT_CHAN_686875_IDX] =3D { 27475, 0x1, 0x4C, 0xA38E4, 0x8F2 =
},
+       [ATHOS_LUT_CHAN_687000_IDX] =3D { 27480, 0x1, 0x4C, 0xAAAAB, 0x8F2 =
},
+       [ATHOS_LUT_CHAN_687125_IDX] =3D { 27485, 0x1, 0x4C, 0xB1C72, 0x8F2 =
},
+       [ATHOS_LUT_CHAN_687250_IDX] =3D { 27490, 0x1, 0x4C, 0xB8E39, 0x8F3 =
},
+       [ATHOS_LUT_CHAN_687375_IDX] =3D { 27495, 0x1, 0x4C, 0xC0000, 0x8F3 =
},
+       [ATHOS_LUT_CHAN_687500_IDX] =3D { 27500, 0x1, 0x4C, 0xC71C7, 0x8F4 =
},
+       [ATHOS_LUT_CHAN_687625_IDX] =3D { 27505, 0x1, 0x4C, 0xCE38E, 0x8F4 =
},
+       [ATHOS_LUT_CHAN_687750_IDX] =3D { 27510, 0x1, 0x4C, 0xD5555, 0x8F5 =
},
+       [ATHOS_LUT_CHAN_687875_IDX] =3D { 27515, 0x1, 0x4C, 0xDC71C, 0x8F5 =
},
+       [ATHOS_LUT_CHAN_688000_IDX] =3D { 27520, 0x1, 0x4C, 0xE38E4, 0x8F5 =
},
+       [ATHOS_LUT_CHAN_688125_IDX] =3D { 27525, 0x1, 0x4C, 0xEAAAB, 0x8F6 =
},
+       [ATHOS_LUT_CHAN_688250_IDX] =3D { 27530, 0x1, 0x4C, 0xF1C72, 0x8F6 =
},
+       [ATHOS_LUT_CHAN_688375_IDX] =3D { 27535, 0x1, 0x4C, 0xF8E39, 0x8F7 =
},
+       [ATHOS_LUT_CHAN_688500_IDX] =3D { 27540, 0x1, 0x4C, 0x100000, 0x8F7=
 },
+       [ATHOS_LUT_CHAN_688625_IDX] =3D { 27545, 0x1, 0x4C, 0x1071C7, 0x8F7=
 },
+       [ATHOS_LUT_CHAN_688750_IDX] =3D { 27550, 0x1, 0x4C, 0x10E38E, 0x8F8=
 },
+       [ATHOS_LUT_CHAN_688875_IDX] =3D { 27555, 0x1, 0x4C, 0x115555, 0x8F8=
 },
+       [ATHOS_LUT_CHAN_689000_IDX] =3D { 27560, 0x1, 0x4C, 0x11C71C, 0x8F9=
 },
+       [ATHOS_LUT_CHAN_689125_IDX] =3D { 27565, 0x1, 0x4C, 0x1238E4, 0x8F9=
 },
+       [ATHOS_LUT_CHAN_689250_IDX] =3D { 27570, 0x1, 0x4C, 0x12AAAB, 0x8FA=
 },
+       [ATHOS_LUT_CHAN_689375_IDX] =3D { 27575, 0x1, 0x4C, 0x131C72, 0x8FA=
 },
+       [ATHOS_LUT_CHAN_689500_IDX] =3D { 27580, 0x1, 0x4C, 0x138E39, 0x8FA=
 },
+       [ATHOS_LUT_CHAN_689625_IDX] =3D { 27585, 0x1, 0x4C, 0x140000, 0x8FB=
 },
+       [ATHOS_LUT_CHAN_689750_IDX] =3D { 27590, 0x1, 0x4C, 0x1471C7, 0x8FB=
 },
+       [ATHOS_LUT_CHAN_689875_IDX] =3D { 27595, 0x1, 0x4C, 0x14E38E, 0x8FC=
 },
+       [ATHOS_LUT_CHAN_690000_IDX] =3D { 27600, 0x1, 0x4C, 0x155555, 0x8FC=
 },
+       [ATHOS_LUT_CHAN_690125_IDX] =3D { 27605, 0x1, 0x4C, 0x15C71C, 0x8FC=
 },
+       [ATHOS_LUT_CHAN_690250_IDX] =3D { 27610, 0x1, 0x4C, 0x1638E4, 0x8FD=
 },
+       [ATHOS_LUT_CHAN_690375_IDX] =3D { 27615, 0x1, 0x4C, 0x16AAAB, 0x8FD=
 },
+       [ATHOS_LUT_CHAN_690500_IDX] =3D { 27620, 0x1, 0x4C, 0x171C72, 0x8FE=
 },
+       [ATHOS_LUT_CHAN_690625_IDX] =3D { 27625, 0x1, 0x4C, 0x178E39, 0x8FE=
 },
+       [ATHOS_LUT_CHAN_690750_IDX] =3D { 27630, 0x1, 0x4C, 0x180000, 0x8FF=
 },
+       [ATHOS_LUT_CHAN_690875_IDX] =3D { 27635, 0x1, 0x4C, 0x1871C7, 0x8FF=
 },
+       [ATHOS_LUT_CHAN_691000_IDX] =3D { 27640, 0x1, 0x4C, 0x18E38E, 0x8FF=
 },
+       [ATHOS_LUT_CHAN_691125_IDX] =3D { 27645, 0x1, 0x4C, 0x195555, 0x900=
 },
+       [ATHOS_LUT_CHAN_691250_IDX] =3D { 27650, 0x1, 0x4C, 0x19C71C, 0x900=
 },
+       [ATHOS_LUT_CHAN_691375_IDX] =3D { 27655, 0x1, 0x4C, 0x1A38E4, 0x901=
 },
+       [ATHOS_LUT_CHAN_691500_IDX] =3D { 27660, 0x1, 0x4C, 0x1AAAAB, 0x901=
 },
+       [ATHOS_LUT_CHAN_691625_IDX] =3D { 27665, 0x1, 0x4C, 0x1B1C72, 0x901=
 },
+       [ATHOS_LUT_CHAN_691750_IDX] =3D { 27670, 0x1, 0x4C, 0x1B8E39, 0x902=
 },
+       [ATHOS_LUT_CHAN_691875_IDX] =3D { 27675, 0x1, 0x4C, 0x1C0000, 0x902=
 },
+       [ATHOS_LUT_CHAN_692000_IDX] =3D { 27680, 0x1, 0x4C, 0x1C71C7, 0x903=
 },
+       [ATHOS_LUT_CHAN_692125_IDX] =3D { 27685, 0x1, 0x4C, 0x1CE38E, 0x903=
 },
+       [ATHOS_LUT_CHAN_692250_IDX] =3D { 27690, 0x1, 0x4C, 0x1D5555, 0x904=
 },
+       [ATHOS_LUT_CHAN_692375_IDX] =3D { 27695, 0x1, 0x4C, 0x1DC71C, 0x904=
 },
+       [ATHOS_LUT_CHAN_692500_IDX] =3D { 27700, 0x1, 0x4C, 0x1E38E4, 0x904=
 },
+       [ATHOS_LUT_CHAN_692625_IDX] =3D { 27705, 0x1, 0x4C, 0x1EAAAB, 0x905=
 },
+       [ATHOS_LUT_CHAN_692750_IDX] =3D { 27710, 0x1, 0x4C, 0x1F1C72, 0x905=
 },
+       [ATHOS_LUT_CHAN_692875_IDX] =3D { 27715, 0x1, 0x4C, 0x1F8E39, 0x906=
 },
+       [ATHOS_LUT_CHAN_693000_IDX] =3D { 27720, 0x1, 0x4D, 0x0, 0x906 },
+       [ATHOS_LUT_CHAN_693125_IDX] =3D { 27725, 0x1, 0x4D, 0x71C7, 0x906 }=
,
+       [ATHOS_LUT_CHAN_693250_IDX] =3D { 27730, 0x1, 0x4D, 0xE38E, 0x907 }=
,
+       [ATHOS_LUT_CHAN_693375_IDX] =3D { 27735, 0x1, 0x4D, 0x15555, 0x907 =
},
+       [ATHOS_LUT_CHAN_693500_IDX] =3D { 27740, 0x1, 0x4D, 0x1C71C, 0x908 =
},
+       [ATHOS_LUT_CHAN_693625_IDX] =3D { 27745, 0x1, 0x4D, 0x238E4, 0x908 =
},
+       [ATHOS_LUT_CHAN_693750_IDX] =3D { 27750, 0x1, 0x4D, 0x2AAAB, 0x909 =
},
+       [ATHOS_LUT_CHAN_693875_IDX] =3D { 27755, 0x1, 0x4D, 0x31C72, 0x909 =
},
+       [ATHOS_LUT_CHAN_694000_IDX] =3D { 27760, 0x1, 0x4D, 0x38E39, 0x909 =
},
+       [ATHOS_LUT_CHAN_694125_IDX] =3D { 27765, 0x1, 0x4D, 0x40000, 0x90A =
},
+       [ATHOS_LUT_CHAN_694250_IDX] =3D { 27770, 0x1, 0x4D, 0x471C7, 0x90A =
},
+       [ATHOS_LUT_CHAN_694375_IDX] =3D { 27775, 0x1, 0x4D, 0x4E38E, 0x90B =
},
+       [ATHOS_LUT_CHAN_694500_IDX] =3D { 27780, 0x1, 0x4D, 0x55555, 0x90B =
},
+       [ATHOS_LUT_CHAN_694625_IDX] =3D { 27785, 0x1, 0x4D, 0x5C71C, 0x90B =
},
+       [ATHOS_LUT_CHAN_694750_IDX] =3D { 27790, 0x1, 0x4D, 0x638E4, 0x90C =
},
+       [ATHOS_LUT_CHAN_694875_IDX] =3D { 27795, 0x1, 0x4D, 0x6AAAB, 0x90C =
},
+       [ATHOS_LUT_CHAN_695000_IDX] =3D { 27800, 0x1, 0x4D, 0x71C72, 0x90D =
},
+       [ATHOS_LUT_CHAN_695125_IDX] =3D { 27805, 0x1, 0x4D, 0x78E39, 0x90D =
},
+       [ATHOS_LUT_CHAN_695250_IDX] =3D { 27810, 0x1, 0x4D, 0x80000, 0x90E =
},
+       [ATHOS_LUT_CHAN_695375_IDX] =3D { 27815, 0x1, 0x4D, 0x871C7, 0x90E =
},
+       [ATHOS_LUT_CHAN_695500_IDX] =3D { 27820, 0x1, 0x4D, 0x8E38E, 0x90E =
},
+       [ATHOS_LUT_CHAN_695625_IDX] =3D { 27825, 0x1, 0x4D, 0x95555, 0x90F =
},
+       [ATHOS_LUT_CHAN_695750_IDX] =3D { 27830, 0x1, 0x4D, 0x9C71C, 0x90F =
},
+       [ATHOS_LUT_CHAN_695875_IDX] =3D { 27835, 0x1, 0x4D, 0xA38E4, 0x910 =
},
+       [ATHOS_LUT_CHAN_696000_IDX] =3D { 27840, 0x1, 0x4D, 0xAAAAB, 0x910 =
},
+       [ATHOS_LUT_CHAN_696125_IDX] =3D { 27845, 0x1, 0x4D, 0xB1C72, 0x910 =
},
+       [ATHOS_LUT_CHAN_696250_IDX] =3D { 27850, 0x1, 0x4D, 0xB8E39, 0x911 =
},
+       [ATHOS_LUT_CHAN_696375_IDX] =3D { 27855, 0x1, 0x4D, 0xC0000, 0x911 =
},
+       [ATHOS_LUT_CHAN_696500_IDX] =3D { 27860, 0x1, 0x4D, 0xC71C7, 0x912 =
},
+       [ATHOS_LUT_CHAN_696625_IDX] =3D { 27865, 0x1, 0x4D, 0xCE38E, 0x912 =
},
+       [ATHOS_LUT_CHAN_696750_IDX] =3D { 27870, 0x1, 0x4D, 0xD5555, 0x913 =
},
+       [ATHOS_LUT_CHAN_696875_IDX] =3D { 27875, 0x1, 0x4D, 0xDC71C, 0x913 =
},
+       [ATHOS_LUT_CHAN_697000_IDX] =3D { 27880, 0x1, 0x4D, 0xE38E4, 0x913 =
},
+       [ATHOS_LUT_CHAN_697125_IDX] =3D { 27885, 0x1, 0x4D, 0xEAAAB, 0x914 =
},
+       [ATHOS_LUT_CHAN_697250_IDX] =3D { 27890, 0x1, 0x4D, 0xF1C72, 0x914 =
},
+       [ATHOS_LUT_CHAN_697375_IDX] =3D { 27895, 0x1, 0x4D, 0xF8E39, 0x915 =
},
+       [ATHOS_LUT_CHAN_697500_IDX] =3D { 27900, 0x1, 0x4D, 0x100000, 0x915=
 },
+       [ATHOS_LUT_CHAN_697625_IDX] =3D { 27905, 0x1, 0x4D, 0x1071C7, 0x915=
 },
+       [ATHOS_LUT_CHAN_697750_IDX] =3D { 27910, 0x1, 0x4D, 0x10E38E, 0x916=
 },
+       [ATHOS_LUT_CHAN_697875_IDX] =3D { 27915, 0x1, 0x4D, 0x115555, 0x916=
 },
+       [ATHOS_LUT_CHAN_698000_IDX] =3D { 27920, 0x1, 0x4D, 0x11C71C, 0x917=
 },
+       [ATHOS_LUT_CHAN_698125_IDX] =3D { 27925, 0x1, 0x4D, 0x1238E4, 0x917=
 },
+       [ATHOS_LUT_CHAN_698250_IDX] =3D { 27930, 0x1, 0x4D, 0x12AAAB, 0x918=
 },
+       [ATHOS_LUT_CHAN_698375_IDX] =3D { 27935, 0x1, 0x4D, 0x131C72, 0x918=
 },
+       [ATHOS_LUT_CHAN_698500_IDX] =3D { 27940, 0x1, 0x4D, 0x138E39, 0x918=
 },
+       [ATHOS_LUT_CHAN_698625_IDX] =3D { 27945, 0x1, 0x4D, 0x140000, 0x919=
 },
+       [ATHOS_LUT_CHAN_698750_IDX] =3D { 27950, 0x1, 0x4D, 0x1471C7, 0x919=
 },
+       [ATHOS_LUT_CHAN_698875_IDX] =3D { 27955, 0x1, 0x4D, 0x14E38E, 0x91A=
 },
+       [ATHOS_LUT_CHAN_699000_IDX] =3D { 27960, 0x1, 0x4D, 0x155555, 0x91A=
 },
+       [ATHOS_LUT_CHAN_699125_IDX] =3D { 27965, 0x1, 0x4D, 0x15C71C, 0x91A=
 },
+       [ATHOS_LUT_CHAN_699250_IDX] =3D { 27970, 0x1, 0x4D, 0x1638E4, 0x91B=
 },
+       [ATHOS_LUT_CHAN_699375_IDX] =3D { 27975, 0x1, 0x4D, 0x16AAAB, 0x91B=
 },
+       [ATHOS_LUT_CHAN_699500_IDX] =3D { 27980, 0x1, 0x4D, 0x171C72, 0x91C=
 },
+       [ATHOS_LUT_CHAN_699625_IDX] =3D { 27985, 0x1, 0x4D, 0x178E39, 0x91C=
 },
+       [ATHOS_LUT_CHAN_699750_IDX] =3D { 27990, 0x1, 0x4D, 0x180000, 0x91D=
 },
+       [ATHOS_LUT_CHAN_699875_IDX] =3D { 27995, 0x1, 0x4D, 0x1871C7, 0x91D=
 },
+       [ATHOS_LUT_CHAN_700000_IDX] =3D { 28000, 0x1, 0x4D, 0x18E38E, 0x91D=
 },
+       [ATHOS_LUT_CHAN_700125_IDX] =3D { 28005, 0x1, 0x4D, 0x195555, 0x91E=
 },
+       [ATHOS_LUT_CHAN_700250_IDX] =3D { 28010, 0x1, 0x4D, 0x19C71C, 0x91E=
 },
+       [ATHOS_LUT_CHAN_700375_IDX] =3D { 28015, 0x1, 0x4D, 0x1A38E4, 0x91F=
 },
+       [ATHOS_LUT_CHAN_700500_IDX] =3D { 28020, 0x1, 0x4D, 0x1AAAAB, 0x91F=
 },
+       [ATHOS_LUT_CHAN_700625_IDX] =3D { 28025, 0x1, 0x4D, 0x1B1C72, 0x91F=
 },
+       [ATHOS_LUT_CHAN_700750_IDX] =3D { 28030, 0x1, 0x4D, 0x1B8E39, 0x920=
 },
+       [ATHOS_LUT_CHAN_700875_IDX] =3D { 28035, 0x1, 0x4D, 0x1C0000, 0x920=
 },
+       [ATHOS_LUT_CHAN_701000_IDX] =3D { 28040, 0x1, 0x4D, 0x1C71C7, 0x921=
 },
+       [ATHOS_LUT_CHAN_701125_IDX] =3D { 28045, 0x1, 0x4D, 0x1CE38E, 0x921=
 },
+       [ATHOS_LUT_CHAN_701250_IDX] =3D { 28050, 0x1, 0x4D, 0x1D5555, 0x922=
 },
+       [ATHOS_LUT_CHAN_701375_IDX] =3D { 28055, 0x1, 0x4D, 0x1DC71C, 0x922=
 },
+       [ATHOS_LUT_CHAN_701500_IDX] =3D { 28060, 0x1, 0x4D, 0x1E38E4, 0x922=
 },
+       [ATHOS_LUT_CHAN_701625_IDX] =3D { 28065, 0x1, 0x4D, 0x1EAAAB, 0x923=
 },
+       [ATHOS_LUT_CHAN_701750_IDX] =3D { 28070, 0x1, 0x4D, 0x1F1C72, 0x923=
 },
+       [ATHOS_LUT_CHAN_701875_IDX] =3D { 28075, 0x1, 0x4D, 0x1F8E39, 0x924=
 },
+       [ATHOS_LUT_CHAN_702000_IDX] =3D { 28080, 0x1, 0x4E, 0x0, 0x924 },
+       [ATHOS_LUT_CHAN_702125_IDX] =3D { 28085, 0x1, 0x4E, 0x71C7, 0x924 }=
,
+       [ATHOS_LUT_CHAN_702250_IDX] =3D { 28090, 0x1, 0x4E, 0xE38E, 0x925 }=
,
+       [ATHOS_LUT_CHAN_702375_IDX] =3D { 28095, 0x1, 0x4E, 0x15555, 0x925 =
},
+       [ATHOS_LUT_CHAN_702500_IDX] =3D { 28100, 0x1, 0x4E, 0x1C71C, 0x926 =
},
+       [ATHOS_LUT_CHAN_702625_IDX] =3D { 28105, 0x1, 0x4E, 0x238E4, 0x926 =
},
+       [ATHOS_LUT_CHAN_702750_IDX] =3D { 28110, 0x1, 0x4E, 0x2AAAB, 0x927 =
},
+       [ATHOS_LUT_CHAN_702875_IDX] =3D { 28115, 0x1, 0x4E, 0x31C72, 0x927 =
},
+       [ATHOS_LUT_CHAN_703000_IDX] =3D { 28120, 0x1, 0x4E, 0x38E39, 0x927 =
},
+       [ATHOS_LUT_CHAN_703125_IDX] =3D { 28125, 0x1, 0x4E, 0x40000, 0x928 =
},
+       [ATHOS_LUT_CHAN_703250_IDX] =3D { 28130, 0x1, 0x4E, 0x471C7, 0x928 =
},
+       [ATHOS_LUT_CHAN_703375_IDX] =3D { 28135, 0x1, 0x4E, 0x4E38E, 0x929 =
},
+       [ATHOS_LUT_CHAN_703500_IDX] =3D { 28140, 0x1, 0x4E, 0x55555, 0x929 =
},
+       [ATHOS_LUT_CHAN_703625_IDX] =3D { 28145, 0x1, 0x4E, 0x5C71C, 0x929 =
},
+       [ATHOS_LUT_CHAN_703750_IDX] =3D { 28150, 0x1, 0x4E, 0x638E4, 0x92A =
},
+       [ATHOS_LUT_CHAN_703875_IDX] =3D { 28155, 0x1, 0x4E, 0x6AAAB, 0x92A =
},
+       [ATHOS_LUT_CHAN_704000_IDX] =3D { 28160, 0x1, 0x4E, 0x71C72, 0x92B =
},
+       [ATHOS_LUT_CHAN_704125_IDX] =3D { 28165, 0x1, 0x4E, 0x78E39, 0x92B =
},
+       [ATHOS_LUT_CHAN_704250_IDX] =3D { 28170, 0x1, 0x4E, 0x80000, 0x92C =
},
+       [ATHOS_LUT_CHAN_704375_IDX] =3D { 28175, 0x1, 0x4E, 0x871C7, 0x92C =
},
+       [ATHOS_LUT_CHAN_704500_IDX] =3D { 28180, 0x1, 0x4E, 0x8E38E, 0x92C =
},
+       [ATHOS_LUT_CHAN_704625_IDX] =3D { 28185, 0x1, 0x4E, 0x95555, 0x92D =
},
+       [ATHOS_LUT_CHAN_704750_IDX] =3D { 28190, 0x1, 0x4E, 0x9C71C, 0x92D =
},
+       [ATHOS_LUT_CHAN_704875_IDX] =3D { 28195, 0x1, 0x4E, 0xA38E4, 0x92E =
},
+       [ATHOS_LUT_CHAN_705000_IDX] =3D { 28200, 0x1, 0x4E, 0xAAAAB, 0x92E =
},
+       [ATHOS_LUT_CHAN_705125_IDX] =3D { 28205, 0x1, 0x4E, 0xB1C72, 0x92E =
},
+       [ATHOS_LUT_CHAN_705250_IDX] =3D { 28210, 0x1, 0x4E, 0xB8E39, 0x92F =
},
+       [ATHOS_LUT_CHAN_705375_IDX] =3D { 28215, 0x1, 0x4E, 0xC0000, 0x92F =
},
+       [ATHOS_LUT_CHAN_705500_IDX] =3D { 28220, 0x1, 0x4E, 0xC71C7, 0x930 =
},
+       [ATHOS_LUT_CHAN_705625_IDX] =3D { 28225, 0x1, 0x4E, 0xCE38E, 0x930 =
},
+       [ATHOS_LUT_CHAN_705750_IDX] =3D { 28230, 0x1, 0x4E, 0xD5555, 0x931 =
},
+       [ATHOS_LUT_CHAN_705875_IDX] =3D { 28235, 0x1, 0x4E, 0xDC71C, 0x931 =
},
+       [ATHOS_LUT_CHAN_706000_IDX] =3D { 28240, 0x1, 0x4E, 0xE38E4, 0x931 =
},
+       [ATHOS_LUT_CHAN_706125_IDX] =3D { 28245, 0x1, 0x4E, 0xEAAAB, 0x932 =
},
+       [ATHOS_LUT_CHAN_706250_IDX] =3D { 28250, 0x1, 0x4E, 0xF1C72, 0x932 =
},
+       [ATHOS_LUT_CHAN_706375_IDX] =3D { 28255, 0x1, 0x4E, 0xF8E39, 0x933 =
},
+       [ATHOS_LUT_CHAN_706500_IDX] =3D { 28260, 0x1, 0x4E, 0x100000, 0x933=
 },
+       [ATHOS_LUT_CHAN_706625_IDX] =3D { 28265, 0x1, 0x4E, 0x1071C7, 0x933=
 },
+       [ATHOS_LUT_CHAN_706750_IDX] =3D { 28270, 0x1, 0x4E, 0x10E38E, 0x934=
 },
+       [ATHOS_LUT_CHAN_706875_IDX] =3D { 28275, 0x1, 0x4E, 0x115555, 0x934=
 },
+       [ATHOS_LUT_CHAN_707000_IDX] =3D { 28280, 0x1, 0x4E, 0x11C71C, 0x935=
 },
+       [ATHOS_LUT_CHAN_707125_IDX] =3D { 28285, 0x1, 0x4E, 0x1238E4, 0x935=
 },
+       [ATHOS_LUT_CHAN_707250_IDX] =3D { 28290, 0x1, 0x4E, 0x12AAAB, 0x936=
 },
+       [ATHOS_LUT_CHAN_707375_IDX] =3D { 28295, 0x1, 0x4E, 0x131C72, 0x936=
 },
+       [ATHOS_LUT_CHAN_707500_IDX] =3D { 28300, 0x1, 0x4E, 0x138E39, 0x936=
 },
+       [ATHOS_LUT_CHAN_707625_IDX] =3D { 28305, 0x1, 0x4E, 0x140000, 0x937=
 },
+       [ATHOS_LUT_CHAN_707750_IDX] =3D { 28310, 0x1, 0x4E, 0x1471C7, 0x937=
 },
+       [ATHOS_LUT_CHAN_707875_IDX] =3D { 28315, 0x1, 0x4E, 0x14E38E, 0x938=
 },
+       [ATHOS_LUT_CHAN_708000_IDX] =3D { 28320, 0x1, 0x4E, 0x155555, 0x938=
 },
+       [ATHOS_LUT_CHAN_708125_IDX] =3D { 28325, 0x1, 0x4E, 0x15C71C, 0x938=
 },
+       [ATHOS_LUT_CHAN_708250_IDX] =3D { 28330, 0x1, 0x4E, 0x1638E4, 0x939=
 },
+       [ATHOS_LUT_CHAN_708375_IDX] =3D { 28335, 0x1, 0x4E, 0x16AAAB, 0x939=
 },
+       [ATHOS_LUT_CHAN_708500_IDX] =3D { 28340, 0x1, 0x4E, 0x171C72, 0x93A=
 },
+       [ATHOS_LUT_CHAN_708625_IDX] =3D { 28345, 0x1, 0x4E, 0x178E39, 0x93A=
 },
+       [ATHOS_LUT_CHAN_708750_IDX] =3D { 28350, 0x1, 0x4E, 0x180000, 0x93B=
 },
+       [ATHOS_LUT_CHAN_708875_IDX] =3D { 28355, 0x1, 0x4E, 0x1871C7, 0x93B=
 },
+       [ATHOS_LUT_CHAN_709000_IDX] =3D { 28360, 0x1, 0x4E, 0x18E38E, 0x93B=
 },
+       [ATHOS_LUT_CHAN_709125_IDX] =3D { 28365, 0x1, 0x4E, 0x195555, 0x93C=
 },
+       [ATHOS_LUT_CHAN_709250_IDX] =3D { 28370, 0x1, 0x4E, 0x19C71C, 0x93C=
 },
+       [ATHOS_LUT_CHAN_709375_IDX] =3D { 28375, 0x1, 0x4E, 0x1A38E4, 0x93D=
 },
+       [ATHOS_LUT_CHAN_709500_IDX] =3D { 28380, 0x1, 0x4E, 0x1AAAAB, 0x93D=
 },
+       [ATHOS_LUT_CHAN_709625_IDX] =3D { 28385, 0x1, 0x4E, 0x1B1C72, 0x93D=
 },
+       [ATHOS_LUT_CHAN_709750_IDX] =3D { 28390, 0x1, 0x4E, 0x1B8E39, 0x93E=
 },
+       [ATHOS_LUT_CHAN_709875_IDX] =3D { 28395, 0x1, 0x4E, 0x1C0000, 0x93E=
 },
+       [ATHOS_LUT_CHAN_710000_IDX] =3D { 28400, 0x1, 0x4E, 0x1C71C7, 0x93F=
 },
+       [ATHOS_LUT_CHAN_710125_IDX] =3D { 28405, 0x1, 0x4E, 0x1CE38E, 0x93F=
 },
+       [ATHOS_LUT_CHAN_710250_IDX] =3D { 28410, 0x1, 0x4E, 0x1D5555, 0x940=
 },
+       [ATHOS_LUT_CHAN_710375_IDX] =3D { 28415, 0x1, 0x4E, 0x1DC71C, 0x940=
 },
+       [ATHOS_LUT_CHAN_710500_IDX] =3D { 28420, 0x1, 0x4E, 0x1E38E4, 0x940=
 },
+       [ATHOS_LUT_CHAN_710625_IDX] =3D { 28425, 0x1, 0x4E, 0x1EAAAB, 0x941=
 },
+       [ATHOS_LUT_CHAN_710750_IDX] =3D { 28430, 0x1, 0x4E, 0x1F1C72, 0x941=
 },
+       [ATHOS_LUT_CHAN_710875_IDX] =3D { 28435, 0x1, 0x4E, 0x1F8E39, 0x942=
 },
+       [ATHOS_LUT_CHAN_711000_IDX] =3D { 28440, 0x1, 0x4F, 0x0, 0x942 },
+       [ATHOS_LUT_CHAN_711125_IDX] =3D { 28445, 0x1, 0x4F, 0x71C7, 0x942 }=
,
+       [ATHOS_LUT_CHAN_711250_IDX] =3D { 28450, 0x1, 0x4F, 0xE38E, 0x943 }=
,
+       [ATHOS_LUT_CHAN_711375_IDX] =3D { 28455, 0x1, 0x4F, 0x15555, 0x943 =
},
+       [ATHOS_LUT_CHAN_711500_IDX] =3D { 28460, 0x1, 0x4F, 0x1C71C, 0x944 =
},
+       [ATHOS_LUT_CHAN_711625_IDX] =3D { 28465, 0x1, 0x4F, 0x238E4, 0x944 =
},
+       [ATHOS_LUT_CHAN_711750_IDX] =3D { 28470, 0x1, 0x4F, 0x2AAAB, 0x945 =
},
+       [ATHOS_LUT_CHAN_711875_IDX] =3D { 28475, 0x1, 0x4F, 0x31C72, 0x945 =
},
+       [ATHOS_LUT_CHAN_712000_IDX] =3D { 28480, 0x1, 0x4F, 0x38E39, 0x945 =
},
+       [ATHOS_LUT_CHAN_712125_IDX] =3D { 28485, 0x1, 0x4F, 0x40000, 0x946 =
},
+       [ATHOS_LUT_CHAN_712250_IDX] =3D { 28490, 0x1, 0x4F, 0x471C7, 0x946 =
},
+       [ATHOS_LUT_CHAN_712375_IDX] =3D { 28495, 0x1, 0x4F, 0x4E38E, 0x947 =
},
+       [ATHOS_LUT_CHAN_712500_IDX] =3D { 28500, 0x1, 0x4F, 0x55555, 0x947 =
},
+       [ATHOS_LUT_CHAN_712625_IDX] =3D { 28505, 0x1, 0x4F, 0x5C71C, 0x947 =
},
+       [ATHOS_LUT_CHAN_712750_IDX] =3D { 28510, 0x1, 0x4F, 0x638E4, 0x948 =
},
+       [ATHOS_LUT_CHAN_712875_IDX] =3D { 28515, 0x1, 0x4F, 0x6AAAB, 0x948 =
},
+       [ATHOS_LUT_CHAN_713000_IDX] =3D { 28520, 0x1, 0x4F, 0x71C72, 0x949 =
},
+       [ATHOS_LUT_CHAN_713125_IDX] =3D { 28525, 0x1, 0x4F, 0x78E39, 0x949 =
},
+       [ATHOS_LUT_CHAN_713250_IDX] =3D { 28530, 0x1, 0x4F, 0x80000, 0x94A =
},
+       [ATHOS_LUT_CHAN_713375_IDX] =3D { 28535, 0x1, 0x4F, 0x871C7, 0x94A =
},
+       [ATHOS_LUT_CHAN_713500_IDX] =3D { 28540, 0x1, 0x4F, 0x8E38E, 0x94A =
},
+       [ATHOS_LUT_CHAN_713625_IDX] =3D { 28545, 0x1, 0x4F, 0x95555, 0x94B =
},
+       [ATHOS_LUT_CHAN_713750_IDX] =3D { 28550, 0x1, 0x4F, 0x9C71C, 0x94B =
},
+       [ATHOS_LUT_CHAN_713875_IDX] =3D { 28555, 0x1, 0x4F, 0xA38E4, 0x94C =
},
+       [ATHOS_LUT_CHAN_714000_IDX] =3D { 28560, 0x1, 0x4F, 0xAAAAB, 0x94C =
},
+       [ATHOS_LUT_CHAN_714125_IDX] =3D { 28565, 0x1, 0x4F, 0xB1C72, 0x94C =
},
+       [ATHOS_LUT_CHAN_714250_IDX] =3D { 28570, 0x1, 0x4F, 0xB8E39, 0x94D =
},
+       [ATHOS_LUT_CHAN_714375_IDX] =3D { 28575, 0x1, 0x4F, 0xC0000, 0x94D =
},
+       [ATHOS_LUT_CHAN_714500_IDX] =3D { 28580, 0x1, 0x4F, 0xC71C7, 0x94E =
},
+       [ATHOS_LUT_CHAN_714625_IDX] =3D { 28585, 0x1, 0x4F, 0xCE38E, 0x94E =
},
+       [ATHOS_LUT_CHAN_714750_IDX] =3D { 28590, 0x1, 0x4F, 0xD5555, 0x94F =
},
+       [ATHOS_LUT_CHAN_714875_IDX] =3D { 28595, 0x1, 0x4F, 0xDC71C, 0x94F =
},
+       [ATHOS_LUT_CHAN_715000_IDX] =3D { 28600, 0x1, 0x4F, 0xE38E4, 0x94F =
},
+       [ATHOS_LUT_CHAN_715125_IDX] =3D { 28605, 0x1, 0x4F, 0xEAAAB, 0x950 =
},
+       [ATHOS_LUT_CHAN_715250_IDX] =3D { 28610, 0x1, 0x4F, 0xF1C72, 0x950 =
},
+       [ATHOS_LUT_CHAN_715375_IDX] =3D { 28615, 0x1, 0x4F, 0xF8E39, 0x951 =
},
+       [ATHOS_LUT_CHAN_715500_IDX] =3D { 28620, 0x1, 0x4F, 0x100000, 0x951=
 },
+       [ATHOS_LUT_CHAN_715625_IDX] =3D { 28625, 0x1, 0x4F, 0x1071C7, 0x951=
 },
+       [ATHOS_LUT_CHAN_715750_IDX] =3D { 28630, 0x1, 0x4F, 0x10E38E, 0x952=
 },
+       [ATHOS_LUT_CHAN_715875_IDX] =3D { 28635, 0x1, 0x4F, 0x115555, 0x952=
 },
+       [ATHOS_LUT_CHAN_716000_IDX] =3D { 28640, 0x1, 0x4F, 0x11C71C, 0x953=
 },
+       [ATHOS_LUT_CHAN_716125_IDX] =3D { 28645, 0x1, 0x4F, 0x1238E4, 0x953=
 },
+       [ATHOS_LUT_CHAN_716250_IDX] =3D { 28650, 0x1, 0x4F, 0x12AAAB, 0x954=
 },
+       [ATHOS_LUT_CHAN_716375_IDX] =3D { 28655, 0x1, 0x4F, 0x131C72, 0x954=
 },
+       [ATHOS_LUT_CHAN_716500_IDX] =3D { 28660, 0x1, 0x4F, 0x138E39, 0x954=
 },
+       [ATHOS_LUT_CHAN_716625_IDX] =3D { 28665, 0x1, 0x4F, 0x140000, 0x955=
 },
+       [ATHOS_LUT_CHAN_716750_IDX] =3D { 28670, 0x1, 0x4F, 0x1471C7, 0x955=
 },
+       [ATHOS_LUT_CHAN_716875_IDX] =3D { 28675, 0x1, 0x4F, 0x14E38E, 0x956=
 },
+       [ATHOS_LUT_CHAN_717000_IDX] =3D { 28680, 0x1, 0x4F, 0x155555, 0x956=
 },
+       [ATHOS_LUT_CHAN_717125_IDX] =3D { 28685, 0x1, 0x4F, 0x15C71C, 0x956=
 },
+       [ATHOS_LUT_CHAN_717250_IDX] =3D { 28690, 0x1, 0x4F, 0x1638E4, 0x957=
 },
+       [ATHOS_LUT_CHAN_717375_IDX] =3D { 28695, 0x1, 0x4F, 0x16AAAB, 0x957=
 },
+       [ATHOS_LUT_CHAN_717500_IDX] =3D { 28700, 0x1, 0x4F, 0x171C72, 0x958=
 },
+       [ATHOS_LUT_CHAN_717625_IDX] =3D { 28705, 0x1, 0x4F, 0x178E39, 0x958=
 },
+       [ATHOS_LUT_CHAN_717750_IDX] =3D { 28710, 0x1, 0x4F, 0x180000, 0x959=
 },
+       [ATHOS_LUT_CHAN_717875_IDX] =3D { 28715, 0x1, 0x4F, 0x1871C7, 0x959=
 },
+       [ATHOS_LUT_CHAN_718000_IDX] =3D { 28720, 0x1, 0x4F, 0x18E38E, 0x959=
 },
+       [ATHOS_LUT_CHAN_718125_IDX] =3D { 28725, 0x1, 0x4F, 0x195555, 0x95A=
 },
+       [ATHOS_LUT_CHAN_718250_IDX] =3D { 28730, 0x1, 0x4F, 0x19C71C, 0x95A=
 },
+       [ATHOS_LUT_CHAN_718375_IDX] =3D { 28735, 0x1, 0x4F, 0x1A38E4, 0x95B=
 },
+       [ATHOS_LUT_CHAN_718500_IDX] =3D { 28740, 0x1, 0x4F, 0x1AAAAB, 0x95B=
 },
+       [ATHOS_LUT_CHAN_718625_IDX] =3D { 28745, 0x1, 0x4F, 0x1B1C72, 0x95B=
 },
+       [ATHOS_LUT_CHAN_718750_IDX] =3D { 28750, 0x1, 0x4F, 0x1B8E39, 0x95C=
 },
+       [ATHOS_LUT_CHAN_718875_IDX] =3D { 28755, 0x1, 0x4F, 0x1C0000, 0x95C=
 },
+       [ATHOS_LUT_CHAN_719000_IDX] =3D { 28760, 0x1, 0x4F, 0x1C71C7, 0x95D=
 },
+       [ATHOS_LUT_CHAN_719125_IDX] =3D { 28765, 0x1, 0x4F, 0x1CE38E, 0x95D=
 },
+       [ATHOS_LUT_CHAN_719250_IDX] =3D { 28770, 0x1, 0x4F, 0x1D5555, 0x95E=
 },
+       [ATHOS_LUT_CHAN_719375_IDX] =3D { 28775, 0x1, 0x4F, 0x1DC71C, 0x95E=
 },
+       [ATHOS_LUT_CHAN_719500_IDX] =3D { 28780, 0x1, 0x4F, 0x1E38E4, 0x95E=
 },
+       [ATHOS_LUT_CHAN_719625_IDX] =3D { 28785, 0x1, 0x4F, 0x1EAAAB, 0x95F=
 },
+       [ATHOS_LUT_CHAN_719750_IDX] =3D { 28790, 0x1, 0x4F, 0x1F1C72, 0x95F=
 },
+       [ATHOS_LUT_CHAN_719875_IDX] =3D { 28795, 0x1, 0x4F, 0x1F8E39, 0x960=
 },
+       [ATHOS_LUT_CHAN_720000_IDX] =3D { 28800, 0x1, 0x50, 0x0, 0x960 },
+       [ATHOS_LUT_CHAN_720125_IDX] =3D { 28805, 0x1, 0x50, 0x71C7, 0x960 }=
,
+       [ATHOS_LUT_CHAN_720250_IDX] =3D { 28810, 0x1, 0x50, 0xE38E, 0x961 }=
,
+       [ATHOS_LUT_CHAN_720375_IDX] =3D { 28815, 0x1, 0x50, 0x15555, 0x961 =
},
+       [ATHOS_LUT_CHAN_720500_IDX] =3D { 28820, 0x1, 0x50, 0x1C71C, 0x962 =
},
+       [ATHOS_LUT_CHAN_720625_IDX] =3D { 28825, 0x1, 0x50, 0x238E4, 0x962 =
},
+       [ATHOS_LUT_CHAN_720750_IDX] =3D { 28830, 0x1, 0x50, 0x2AAAB, 0x963 =
},
+       [ATHOS_LUT_CHAN_720875_IDX] =3D { 28835, 0x1, 0x50, 0x31C72, 0x963 =
},
+       [ATHOS_LUT_CHAN_721000_IDX] =3D { 28840, 0x1, 0x50, 0x38E39, 0x963 =
},
+       [ATHOS_LUT_CHAN_721125_IDX] =3D { 28845, 0x1, 0x50, 0x40000, 0x964 =
},
+       [ATHOS_LUT_CHAN_721250_IDX] =3D { 28850, 0x1, 0x50, 0x471C7, 0x964 =
},
+       [ATHOS_LUT_CHAN_721375_IDX] =3D { 28855, 0x1, 0x50, 0x4E38E, 0x965 =
},
+       [ATHOS_LUT_CHAN_721500_IDX] =3D { 28860, 0x1, 0x50, 0x55555, 0x965 =
}
+};
+
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

