Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF023AB82E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhFQQFZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:25 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:38880
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233527AbhFQQFL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bw09d0ICZF8tPznW15/r+bBEPYnbYsKSVazXgXunQvuX0yaANgy6jEyoz8nhmPE7FHnOfYJuPQUyxChXi4M5cmvHc3pFsUuD+pNBMD9SNRmeHr1kjRIvpEk9X07YrwxCnxfEBtBZ96g8rQvVh6wtULTKqNR2sLA35DRvlR65ypILl3DlqIhnSeaLSYIKfnVRhP0Hg33CAiBRkl+A8uDjDOiNy+wK6Dd7+tKQtcV/yjC2GOjjWs4ylcfA/ECGGT0+Nt9ZNaYdmV2Gb+Gn3IJWdSdw1IFMPyBBjUIKtq7KJajS9vaLT41GH+E0VwjDGJp8SLo/8/6lvQ0WwZwMe4CfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJoBTD9OLUDBWjEaWAJTBBWEcOSNOgF89bVECEunxJw=;
 b=SrIGtF7eOLGajxz/VutezF67XIBKDZp6wZ8NvZLFtO0sAw1mRPe5oYZSNBx8aTHN7P/aax4c2hwU5iDvBkihoTyBVaHjrX+t82l+w8DRDqOFgczMn2r35ht2c9sKLJy1SXGudi9OhITRAKoPo1YSozcN/MIRkqhkHkGCr85fHPGQNDBF4Pb0PIUp5Ovpd7QtLqilISpXBUMOROCQF+6BYZSZ3VZEgOese9xWAJtKxcA7Fga4aymRcXzPsQOrQiaRVZYdedjSC7huisO5KKa3/kcM0U+NcK9/nCXG9xDHUYREc6MLqTl2tcMxiQz4OGWMQfqph/syU6gaPa6FzCb2sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJoBTD9OLUDBWjEaWAJTBBWEcOSNOgF89bVECEunxJw=;
 b=vG43yUfbNOCOg2lWqZTyrJ4m3Y/cOjuKiqsZA4lStrnsRh7QW3rYBDFkwknkQ0qipb9QgK/xbMBluX2QGL+N1rOLG4qOdHiZCCdDCEC1B8qOhjxdgLh5zDjcRfOrKhR32+Cql+QLn0pvCnSZx6E8Uc9eVNi6wSKTJDckAwKfLwc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0499.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:02:58 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:02:58 +0000
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
Subject: [RFC v1 022/256] cl8k: add bus/pci/msg_pci.h
Date:   Thu, 17 Jun 2021 15:58:29 +0000
Message-Id: <20210617160223.160998-23-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 994ca7bd-9a8d-4440-d18b-08d931a95fed
X-MS-TrafficTypeDiagnostic: AM0P192MB0499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB04999ADD6103EA597345EB9CF60E9@AM0P192MB0499.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ltXPdFxxsnCynu5vqEkAAV7/uOd/3QYM4XtcpArorYQsXClpM/DtXJB9FIv0p7s3KBZ5tJoDsaIwvYgNboInG1qf747v40Cy82O3fpfsoujC/2AzxRfFqwGsiUEbYQt7m6w7kk3h5Em2gxxK1BfCQRUIupzCv+ZBPFL3QzUlLCdPI1ctmhQIc8geR5o8qjxcgNdg65sLqKDgDxLGGpcCK4o9iCpwqH2lTueVOzg3K6UImHW2zwQSuPP8G/JhWXlko3pOkmmN3E4tQMj0p0WrSxyxUcszT5h6ifUXRwZrU+ChC6IqA86T9Shi/07AEFK2lZIO9gSvRpGvWR+BbqSjbVdZCboX+fdVlyjOM5rGkcd7MyBjuntbjQCnb5J0JdVR/IpEkPmVLJ/xj00m1mkRJTmk07UTrvItK+AgD7mFmqbKQgolRmxk1/lWjYxpqsE3Hjn4eQ0DqV77CRtzMqsq4HIyAbh7kD73mSLs/nw+GiiWmKZRJBO+X/WE++V/ci1E9FLZkuTfqgnOEhWHW3+TupI3taVUjm/oUEcwJ8DUf2d5FjwEKTItp6mJn8fo2MweYhRrOzmc7r6zafvSOQ/8lCzuvZRW1zIIhl65T3HgWE3ih8D5//9MGcZcfJkYzrNz5zHiRLuiZkigIT+ky7keP5VU1JiEsK9EdwBQ6aCkK0MjeblnKFpEds5mUdJQ70TLyQw5yVLpcbOk7zjq8/qcQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(86362001)(107886003)(66556008)(52116002)(83380400001)(55236004)(36756003)(4326008)(186003)(16526019)(956004)(316002)(6486002)(8676002)(54906003)(38100700002)(38350700002)(66476007)(6506007)(2906002)(26005)(9686003)(6512007)(66946007)(2616005)(5660300002)(478600001)(1076003)(6666004)(8936002)(6916009)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SK3SSu0McbPmZB6mbIhv3C2jlAeDnu+tdZNZw7APmoPs5CBnh9ITdlHzSPUE?=
 =?us-ascii?Q?QeX2o3IBzXIfEX1ScJwIMtW8Ww32IE3dJiO2f1YYv62Es+9/bLKCq5RDLlzN?=
 =?us-ascii?Q?pnlBq5kXiB6gnNhnt9mEKrGNJ9dAzqF976jjnxOI6NyVD1dqL85bO5BkDkJS?=
 =?us-ascii?Q?64E9M657NpSiNPWfEXzgtYzJAPwxr4cBGL3QK5dXuMjKl8DwyTYnuYu2Jfss?=
 =?us-ascii?Q?AwAbwIy2yu+9o0EMKF/q8wyBEBxAh7FmAbgr/Gy5ZigxF7Bfft9yNModUfa6?=
 =?us-ascii?Q?Z1XDzFx/dZdJvgAdOrgLUr7nEQsV3POMgRQdM/2y0MzRgN0RsZueunINpuZ+?=
 =?us-ascii?Q?mAFnAwumcdmvEmq5r3kbAlWD4LyYrGiqr/cma6dTd/F9nqjkny4ksS3MvJ2L?=
 =?us-ascii?Q?47aSZ303H8r+Fkk8iIgfpXenXEDYSv4fxU3UzxgzbCtJy+o6fmKXppRcYZtM?=
 =?us-ascii?Q?h8TGZoC6rcyda5A9rKqRmTWVYtIqdY7UVbfoZnvdYcZQPnxoIZp6k5jVAaqW?=
 =?us-ascii?Q?aMKoCFkeUvcoKGiqS0+xIYI2Aq9OM175x4EA3ZQJiwNWq0utY/zMyZT0zCpy?=
 =?us-ascii?Q?+XxeH7PW3Bl+hPPLtPNirCwG0kwwGZlr7AezxrTutDm3d8AkuMXo4et3l9Nk?=
 =?us-ascii?Q?XFHdIYXDlJ5hfArv4hbVVjX28a8gtHMo3yWqsIt9KpQciwlcX+XQ5YCmXzIk?=
 =?us-ascii?Q?rLKT/bPNuHFNBHFhnbGMXk9RRScJFPqjVd1/0ywun7gV3h8HzrieGmAL6gU2?=
 =?us-ascii?Q?B32EjhkM00AcLTkG/4jgGoRYmoKa5nQWeKCxwLGHqX71v46a6J9siJoG1nQS?=
 =?us-ascii?Q?ufz4ahuwSCApcDAEwiF5qfhUEbltjqbHvvR5XUN7razALtdoRi5Xp/X4R6AB?=
 =?us-ascii?Q?x8yVBa2Htdk1rZoAh+rSUxPzAcFj5n3p2b6OObtTdKr9Eukkwk4FuO/6Pls0?=
 =?us-ascii?Q?AO0bdK3GoFTCKziDLXySbI0ibAVuThUerZZW1SL9YeXxJN47v2Dmn0yChhzv?=
 =?us-ascii?Q?BBuOD1B2ESCwgwqwSuamIZfMwu4lxDNnkOE4WqCP+CnYVcaccFGveyO4tft8?=
 =?us-ascii?Q?gsSiogctgpCa+UY4MHx3PvffQcKda25KNURHePkKuc3ilTYHRKsr77sZcUTd?=
 =?us-ascii?Q?zLKlTAx8eDZA+xcX7vR9RSFXhUP8ImnzROMuS+WvgLCl5FcFdV6v7hyvKz/h?=
 =?us-ascii?Q?nePFdMiEk2kW5nHw9UEFCcnrCzAyqASFpFK6i1aVNblIiMsQmFDYXZ7hCo9B?=
 =?us-ascii?Q?uB2Zantbv5bnvff5enLkcXkJyqjhrau2iLVs4GoHWK2hWbxH5M2YuI1mzmT1?=
 =?us-ascii?Q?/8ETUB/WZkKJwq0WwFZymHOK?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 994ca7bd-9a8d-4440-d18b-08d931a95fed
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:02:57.9714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcZ7vKK95RgMpckSP2ohoVXBWrGmeIMVR8R3fr+NsmPzS66kfe4FzlnQ/YfK5GLv47gb/FUEfPisQUlXmRoo2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0499
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/bus/pci/msg_pci.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/bus/pci/msg_pci.h

diff --git a/drivers/net/wireless/celeno/cl8k/bus/pci/msg_pci.h b/drivers/n=
et/wireless/celeno/cl8k/bus/pci/msg_pci.h
new file mode 100644
index 000000000000..6ad2050dc57c
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/bus/pci/msg_pci.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_MSG_PCI_H
+#define CL_MSG_PCI_H
+
+#include "hw.h"
+
+int cl_msg_pci_msg_fw_send(struct cl_hw *cl_hw, const void *msg_params,
+                          bool background);
+
+#endif /* CL_MSG_PCI_H */
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

