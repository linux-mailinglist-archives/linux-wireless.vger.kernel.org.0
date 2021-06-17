Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0212B3AB816
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhFQQEp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:04:45 -0400
Received: from mail-db8eur05on2077.outbound.protection.outlook.com ([40.107.20.77]:6177
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231626AbhFQQEn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:04:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfLupEeB9mDfltt5Z5VUXvTq84m19xwweta5T9UjAVJQEt4Vm/D3BX+OUMA5U73632lu9zmHk1RYuLYatLQeqftDOWDyOTMq957PAVIKFC4bmI/8+GdmzCSVwvckADWd+DLM4VVzsFJADVEjY/4W3Bv1SEfn7erSeieXrpDdYdd6Fz9iwnlvzYW7cGgUTxQB8zBjjcJT3qlBuIieM7tYL0i64f4yd4snu5FJAY1eKZ1hjQxwoh3DQJa1vc2L1Bx7rce7Bm2TFTClJc3puQe2y9R32yYL+NY34/RodjGocXoOPBsZbnqoBSH1BTHI65CD2Q8Ov6NmHktszip8cjwhMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1tiymVmFbLNKEyNd7GpnDKpC3+aCBY2VAvJmOnUUGQ=;
 b=DkOvVzytDdypkqJW56pygUWpjKqK0FXCD47qaWY+xoF03riGLjrYYYd+6px6nkjQT01Zn/pFRz6S/q3HPYaTg1zHaKUCcAYz8zB6c/fXgXYdUTxUbpnw6AoH44DamsFSv2POF5N+L7hXlZg2cqKf7TlRCYS/STesbhjmMDg4Aygfd6cg4aW6v+LFoGWBnF4fKNJ6mzs79+l6j5Sxl0LPhudhQ8pMd7nBddx24MvLaL0HBrkU/VAeRMErxdiD4p6aJRH+vGfECWI6MQgvrj92LxTdtL+gv0U261agvjB2cXdf74oL3vdaqOuziX7uZUNqYfPJGTrIfo54QssfDj42gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1tiymVmFbLNKEyNd7GpnDKpC3+aCBY2VAvJmOnUUGQ=;
 b=tDaA/QjFUIzgVi/qq129xH8WEzyAtZX6mUfo+6XLjdfxdfr7wo6NAc64yJvWayOkR5turgNIexorBtcZd5b/5qvbM6pOI9YiJfxGXrk2Jhb9WfO/VPgOu1O0F2Vf2e/zOcJ0DNGALPyhKAbtYqLwq5EVsL4fmTRlM/u/pTtBf44=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:02:34 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:02:34 +0000
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
Subject: [RFC v1 001/256] celeno: add Kconfig
Date:   Thu, 17 Jun 2021 15:58:08 +0000
Message-Id: <20210617160223.160998-2-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c90a66e1-8474-4e77-03d0-08d931a951b7
X-MS-TrafficTypeDiagnostic: AM9P192MB1412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB141279DF52A11AA530AF7DDAF60E9@AM9P192MB1412.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oIncxaNpXO3q9GYq8VdZ+ujhq3OCF3uIgB59RFBqCIRZp/CljiDo+OKtFXwueENGfeFzKwumjWS3/WKZhlFCvFLO9hT4yVlpk6YpF7G1u0/tcjRFdZK8LtfxqSQrrLIUFrwVwlvFzFbm290aQXjTjDU/lzK9Uny+plI2/JNv/LAeu2mrflcjkvXa4EJ2a91lTvruiMzRFSNuQBmAdHnHtE3Okx+lldA9iYTSRp+kr08QgrT0SXw0jCamm5xRPEAYUc4XOyHG9MubSs+wvroNCnxkIB6o7Ck9Kc2/no3fMvEWD/G5kXAl6sEZaPfOoxDb8A7aM6iDrgdQIMmcAdjmYExgjO8iPQf6iDoiRioT0+UyIC8i2jbl6jENNO+RoulyhOP27ID+E2ze5kI5PUoWq3mZ/+dr3aoUdpVxeEF4VN5hHv1WEMtMamFXYKUkKa3DjN/7R8BjQDljO7PhpwbK4P7fYFBC25WbDAi8uVmewew0K9qeCpSSi/mPxqrp3QQq7Wr7c8+q2BFQIgpTrU/qYw0ZSm85vz63ondRNzpAW0R5JR20WDCbLPuPCoZ3f+J4B6S/MvRURGXKAsdnUBI5hYRh0LlhDAtQEft4POb1/sl1A3+2wgnEh30K9pQEUv3hXKS3nVUldn8NP7BZXiyjusiS+FVcxkgo1R2S7m+r6oLtqvpI1g/qv9IV781TXlSC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(376002)(39840400004)(396003)(38350700002)(9686003)(16526019)(38100700002)(6512007)(478600001)(36756003)(6506007)(52116002)(55236004)(6486002)(186003)(66556008)(2906002)(8936002)(2616005)(26005)(66946007)(956004)(66476007)(86362001)(83380400001)(107886003)(5660300002)(1076003)(6666004)(4326008)(316002)(8676002)(6916009)(54906003)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jltvh+aAWNDSsbp7LiOHePPx/+ujVpMqmQkP3Abcd7JLQVp7pZ4mn2nXeNI/?=
 =?us-ascii?Q?Eeh+Qr2ROU4E2Afqqw8c2q1t/Lm7FsQK4otRA180Q+1DWS/FctUdIcmC+rYj?=
 =?us-ascii?Q?jmNEAfgBN9QiL8qhokLSWqx0P48DBTwOLx5WUMLO/0XcKMpv0DbasMauwKpr?=
 =?us-ascii?Q?p2Pah166RwPgdOYgvj8nUZmWQNmfMeCUAt9HLVH5pfl1nFAJX9/bbY7XOHCJ?=
 =?us-ascii?Q?yKofj3jjKCvh7AEldeAwUv5j7w/+xNpNo+G0IxQl1csOE+KNuT9xSFkqssY5?=
 =?us-ascii?Q?+89yGaddkKdT367dkwj/XhqXbxja2rmQV4P8mrnnCrAZ0Ifadd53pTp3LY/l?=
 =?us-ascii?Q?KCTCxRx7QsjNu1KjHZDun3ZH/K0LyXzc2Gx27XuHhINKjhQr6CWjpbLoMXUq?=
 =?us-ascii?Q?DBbN14KRlBGKYx79MTb6LHt3sQyqamXtbOnSxcdNS2L7ZSE4qBV+p6fMb9Lw?=
 =?us-ascii?Q?9Z/HagnXe3ZT8ats8EMJFIGR/w5ru5VevhC9d7GJSc9IQ3nAkllVkW0eQarj?=
 =?us-ascii?Q?g1zosvvJq1tI0puj+7AA8aK+qWRCcUEvdAYGXzG7yeWikapOvWO1V5jwrAtw?=
 =?us-ascii?Q?HUounsWn2XzJzGfIpUNJnzyEJ9uY/9h9HcvXBSCJW25oPePmEV3z/ao6sGK9?=
 =?us-ascii?Q?R840o+X4pQxQ+pKvekjrlDDWoSn0D9PcH2PFOX6d9+ZZdqhh1asabBseVEQL?=
 =?us-ascii?Q?gWErtYvavR0xhsmA4EeL7TFYINHok08UcEux/7c9xdthZSeqvR1A/sMHEXVN?=
 =?us-ascii?Q?N+Dobmoz1NjDQNK2RdxWDpizb2MBPMqlEMd+03VNS5avhpbKWo+oAFRP+7iy?=
 =?us-ascii?Q?1pGYhw8BFl5OPQohG2SDwSkX2d03VkCgMl6e3HFQ1kN/Ecfto3MwZ3NZEH1w?=
 =?us-ascii?Q?ZmHOy/jt2EaGXtgg4S4QssH8AQXJpiJrlqYcy5yvk+Cz2iAH7r88i2edYLeR?=
 =?us-ascii?Q?90EMqRNypSIXPFti+nOpkG/P1Q6xXZfDqJS8y/sMAMWw1EjBZJP/Q6/TZfA/?=
 =?us-ascii?Q?elZvqnY8cYi+Lmzy+y7A1hxsv66qEo7brAsSOT31kCmxt5h45sR1LlnM4dRL?=
 =?us-ascii?Q?ClwUfGIqxaPigZsmjAqgxIe2E1492i+udrJzgKt4a11u5HT9NtuTrA4pzwFc?=
 =?us-ascii?Q?sILCIlf8R69X+tDBZXKY+AY7MLfuNwQiTxNyhsTfhyHDdaev4+46N8QGg/bY?=
 =?us-ascii?Q?GKH1Ad/D1afnhzMBRPZFGNKUt9SCNtesSt5BjSnJ+KPqOEo4+V9PVTUapzxR?=
 =?us-ascii?Q?/vH1xFrqumIvHsp6FprkkU3sAMqhB8DQQICvk48s3nIv3CoDBzLRQYNJVX1m?=
 =?us-ascii?Q?XZhCDjctSB3r9oHgH1xnQwlm?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c90a66e1-8474-4e77-03d0-08d931a951b7
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:02:34.1341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8ER9btiMxkDbmSJb8LfJ0mNObL/T8b1AY0NOSbJLoB/rHtH/NC5t/TTQAxMgK9H7gIQeff7G3JD9qY6iBvDPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1412
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/Kconfig

diff --git a/drivers/net/wireless/celeno/Kconfig b/drivers/net/wireless/cel=
eno/Kconfig
new file mode 100644
index 000000000000..4779c1ba1644
--- /dev/null
+++ b/drivers/net/wireless/celeno/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: MIT
+config WLAN_VENDOR_CELENO
+       bool "Celeno devices"
+       default y
+       help
+         If you have a wireless card belonging to this class, say Y.
+
+         Note that the answer to this question doesn't directly affect the
+         kernel: saying N will just cause the configurator to skip all the
+         questions about these cards. If you say Y, you will be asked for
+         your specific card in the following questions.
+
+if WLAN_VENDOR_CELENO
+
+source "drivers/net/wireless/celeno/cl8k/Kconfig"
+
+endif # WLAN_VENDOR_CELENO
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

