Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8EC3AB839
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbhFQQFt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:49 -0400
Received: from mail-eopbgr140042.outbound.protection.outlook.com ([40.107.14.42]:47438
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233570AbhFQQFs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaCzzL95qbZ63dboHHuP4WEy1LMFzhPyrNlWi2ESUX7W19zqsBz3yVqfBj2JTh6SHIpVXx9L92wtMp++okii+XN+dzLuaXMZKVSFeEX7QWARqHqraEHUOTRWOSjMPN9zx8xD9Exq4KpyyYuiCDm6w4aQrI+f9gqw3nXLMwWLNku3+k1rzcyXCtAI9PBOFuTc7LZlxCcjX/3aNNv35XkmN12yc0mlm3kh0zytPaXn0cMj6El5HT8yYC7wo4M43pOtDmxdXTtNUUTn1c5XoD6/J/YJZXH0z5aCv4ggcU6298HkGiOHv9ZGNdwQe4enIdLv9VC3p31IuMNNv8k8k00glg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFLtkPSk8HsJojJFMqoNd1rSdc7k32UyGOloV+rt+sk=;
 b=dtxokp2YSfSku37uNJ8Ol82HaqiaaYPEGV1iFcG+3eIyI8QIhQcnbRAW9G3GXnsodB+4xI/95V7haVuaPUlmdmtekK+tVgbSKvj9Li7vaZKv4meB5+6Vv1PJ5dSTw6f96Wi0nwpr7323uj5WL8va/khdOqaP8+/n+S5jNPQIdOav25AhAdiH7KoctlJGkkvdslNKVaYjAbxZdfzscbxa0G+8QTnDPiqT7lmpJspYT03Jblwko2v07Oi2WbbwA67ZkiLsDJJ6AnNIEJRDpPN1lvWjs3NrUCiu2NCqjInos6+2h5IYU6DF8r15BQofvu8DXpiX9Tf1KInbKTMik77LOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFLtkPSk8HsJojJFMqoNd1rSdc7k32UyGOloV+rt+sk=;
 b=LNq2XlPkBTbwcGPZMUn+5HY7e5huR1gW/71IywLUpu/sjfikwYeH3myCCLVlgAFsOKDoIWnlV1UI0oPGbuGl7DAZG8NTD94Pr2hz0zeP/obrpuy59fjU5VTU2mK5WfgyW4oRXsBssI9OBJSHRmwDxpEsIFprne4y0gKHkDv7H50=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1234.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:03:38 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:38 +0000
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
Subject: [RFC v1 033/256] cl8k: add cca.h
Date:   Thu, 17 Jun 2021 15:58:40 +0000
Message-Id: <20210617160223.160998-34-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8766c91a-fef0-49e8-a320-08d931a967b0
X-MS-TrafficTypeDiagnostic: AM9P192MB1234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB12345956A22A43026AF92492F60E9@AM9P192MB1234.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hHujcZAb/4fEZo5Mb3Sl6mBWZwESSv8wfxPaZXpYFMzArKpm0s65Cqd32034E7dGyeHCsjis5k8d/5cRxha0CaofcJBQmd4YPWq28P5S67zI+k65BnbX8KnQQAgbW+CARu1KGI+/YU8YPrykdamRHFtn5xvExO4X3r9ONsW7HVpW8G9V8/63II7VNTFmHWhHD36zOD6dUcjoemQy0A7SE4rTEIBtAG03CfUixbo5eyt/QjwhylQN4IWx6rBXl0L8c0EfYo5jdsYqCwLZRhsUuYkT1bjtD/tNAI4eydYte52pPfNl4p98S9z07CdnB4uZlvwNm86fP2VQZT0wKoxHT5hk/kifYcn/i0rbyOkagPRPwOvOOEGXwbsl79Tw/pgB7Fu14HF7X/tvYT6DLmFL8wuzWMvgoOxLkL+OCtgjKgAWwaqqGif3kGjSzdr/OVKp/0qDRymHvNNsepGkssvOZVbiRo06qg7HJ/F5M7Dg+sCq8oPA5zI3zIXwwtTI+N5vKe/40d05vq1MqbeDibLAY9QvpDHLi5wvMqGX5lQZjgZXgkERDzNio4kgBCfvEIf6ejFDWezE+VV7ZlBb0fAbLUU6POP6i46CMGjy0GLOrP9CjUNnNwL4y5As5H3a83y1xsm14p0qQIwG1PD1Pm2AL3MzZ67/JfJjxIqlq248zQYy3zu1RGCs+Q5G0iYGbJG0q+6kxxH8AD+lMmNjNsG9mA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(396003)(39850400004)(6666004)(107886003)(36756003)(956004)(66476007)(66556008)(2616005)(66946007)(6916009)(2906002)(26005)(9686003)(1076003)(6512007)(6486002)(16526019)(6506007)(38100700002)(52116002)(86362001)(8936002)(316002)(38350700002)(186003)(55236004)(54906003)(8676002)(5660300002)(508600001)(83380400001)(4326008)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fzdL/1o5kPcQNMAV8Iuf4JQWOKdF/mbxzu2BXdHai6OXCDIdhU3ZbtTFee36?=
 =?us-ascii?Q?lfaJ1OAbYWfgrbonSx/K0J+3s4EYiQZj+c1OvhdOdTGwCi7x/u4J4GBNHyrc?=
 =?us-ascii?Q?hVsX9S8Ku2GcRoIgD2dc2zoE1wGW+1DeEr+ZEqkTeWVR3AvRI3+vH8aGadZ7?=
 =?us-ascii?Q?F6NSI82il06Gag0/2xSGHrbqpnTzHnYaEtH2kMQwIx0XjNi4uy+AMmrmb5Gz?=
 =?us-ascii?Q?ajoWyECOdZnE3B3J3gSpwKX9StUoQy7028hZ2b69i2dY68RQf090KCfG1yMN?=
 =?us-ascii?Q?pmoSFHPD6W39TC0MnEYdv4yWHPGOzarxYCg6KtjcimlsapPn5TdkGdXBgG/7?=
 =?us-ascii?Q?o2X1oPKi0SSUyDM+/SfvJK7nbWmDWz9lix/s/kSx9BUpw8rPO/y2rni5YCOX?=
 =?us-ascii?Q?vgXXeoKqQ5HO8jy0bmcxyIN3k4C2ICi365ByhLAzTh8ZGxEO7rutpIoKTXUF?=
 =?us-ascii?Q?EVpEE/1tlWykMCVux0aohTn3qxFWgR2oqmILMC1cwuxv63yDT/SioQJsojfV?=
 =?us-ascii?Q?CC7ziiInoE6ylQoPOx8KyOf/DHv2UbHz6PW6SKma9A4p5N2wEevc9h5g11+L?=
 =?us-ascii?Q?VaW1/9jsDqhIkgbGYP7lawcHti5dNLXjOQSJPsDY6ryU0upRDgpbZVATyEwe?=
 =?us-ascii?Q?LIWnteTDfwoLfk0MDab/janxA4TJ13RuxdNyLwpIYcjctmAClJamDIMhOll4?=
 =?us-ascii?Q?KZKNoe6u2kN0FBHpFtWn94FQun2DDBIan9FBXrJ2ARRs5JVBGriOdcTtShsw?=
 =?us-ascii?Q?VThEL7UHXhw1O8Ria/7lzjb1jI+f+E/XHtPo8z76dAhRkWBl4nSaOB61uZif?=
 =?us-ascii?Q?w4reKlAndBRPuHWii9eilCG/9v2I6lZxCbJhhtqusN0o6cr1FQXH12nhNhii?=
 =?us-ascii?Q?+UNc8tjeTko2puGA9C/Ett0d6sWNC3OxZJc7Npj7gXOytWLoKOBTxAYzgXba?=
 =?us-ascii?Q?pYP25VLaIOxpYNxIAbd5f9rkXrQ2p28ydYoyTCh+JJ4GhQvHLVHf1/WR9OyI?=
 =?us-ascii?Q?33RP9hN01pGiYvxki+DfqtE1cK2u7nOMZ5v+4uF+/Z+sfg8UhI4htnnhYZeH?=
 =?us-ascii?Q?Bx3pQKG12WblF9JorIdGIKOcpPgNOBVPWZVOUSxuXtUJPfFfOYtGy061+SNz?=
 =?us-ascii?Q?sYe7q1Mv9HkEIit8b5TtkJDdbAMlJV+DHBYahF4okr3/hun7bCIOuQFyIhD4?=
 =?us-ascii?Q?e5EBXFPKWlL+IMSeez1C0x9VWpNP+a5CTb6NvZm54av1WP3eSQro1Rfv6NAH?=
 =?us-ascii?Q?u15O1n6JhAGR4ZsW6iI063bapJutan24R3Zlf1gn8GlzhYoFbx1Fm/u+NNUP?=
 =?us-ascii?Q?hOP0UMdkyuoFEROkCauFQMAs?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8766c91a-fef0-49e8-a320-08d931a967b0
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:11.0072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGR9fqLEP5B5dmC9d1mrSCzfZDpnYZCZazKWiUbCTlkOWvWCbZxLGC8Uw5N+/1yBOb8HA1SxrzGqZb7EentGAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1234
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/cca.h | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/cca.h

diff --git a/drivers/net/wireless/celeno/cl8k/cca.h b/drivers/net/wireless/=
celeno/cl8k/cca.h
new file mode 100644
index 000000000000..ceb2c4251d9a
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/cca.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_CCA_H
+#define CL_CCA_H
+
+/**
+ * CCA (=3DClear Channel Assessment)
+ */
+
+struct cl_hw;
+struct cli_params;
+
+enum cl_cca_opt {
+       CCA_OPT_CNT_CS =3D 0x1,
+       CCA_OPT_CNT_MDM_STATE =3D 0x2,
+       CCA_OPT_CNT_MP =3D 0x4,
+       CCA_OPT_CNT_ENERGY =3D 0x8,
+       CCA_OPT_CNT_ENERGY_BAND =3D 0x10,
+       CCA_OPT_UTIL =3D 0x20,
+       CCA_OPT_TX_RX_MINE =3D 0x40,
+       CCA_OPT_EDCA =3D 0x80,
+       CCA_OPT_EDCA_NAV =3D 0x100,
+       CCA_OPT_REC_HIST =3D 0x200
+};
+
+void cl_cca_maintenance(struct cl_hw *cl_hw);
+int cl_cca_cli(struct cl_hw *cl_hw, struct cli_params *cli_params);
+
+#endif /* CL_CCA_H */
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

