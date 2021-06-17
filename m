Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6953AB862
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhFQQHh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:07:37 -0400
Received: from mail-db8eur05on2048.outbound.protection.outlook.com ([40.107.20.48]:5985
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232781AbhFQQHJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/z/9LKNIZ1EG2zRMh4GlFGA2kG4Tdi7GMl5OUWxIftGRIvSEqLSlW3O33m4NWD6EUf1ttfwc7TqbklnVJWM1BTIPSo/UaxYnciWFQS5GZ0duBrvHvuESI/f1BXK9elaboi3dQiri/6f/PAAABz/K22cyQbJRidCKWqwaIvszPAKbzs/B2J5Tpekx+GV3K8Ax2zSXYk9A5JpNOXAREZczxImSp3n8uTmtcArRn5Gxb1sSoqNFMsS+cVUbVJYPJBujPxMuwzkEXclqPHoJq6nyF62L8c7XPQPtnnd+sIeQPWPYdq8LwdQfIqqelfFN07T+DF+wrLIgOUbM3xB+0I7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAtcNY2+S3+ov/x9Pol1hGpCwjMyE3oUWWeweTwilQA=;
 b=V/XUbM5dpl6rp+G3qq/BNLO0mU61RzyKMhjhbWHQuM75GMBe+EEUq/U2t4VcUltAxJ3z4I6ekjPXEKZ7wyjnOex2q85zt6EuxqI2wOfJzCQMDZRUbaI4IjY2q0LfodebKqmsS89TBW6X9OKXhsk2z1ndKCO/b+gB046uMgFCPtpyTwp9CVpla8r+yekvY0yj3xtug1veFYk77wfUk5inYUoXkNwhStWIQVRP9Ri6MSoq51gp4qP9taEDHGXzadPoVw6Hzd2FokFU6c/PXrbsyHNN8Xg7hyS+wp/p4K+s3CLOL7P6jSyLLqfsrLjGcpTXC1+shL9PyqhtBGfAbwMOFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAtcNY2+S3+ov/x9Pol1hGpCwjMyE3oUWWeweTwilQA=;
 b=Yg3pcPYQD9PicSJHFRqEatd5ZHQAi/roxSgV6av3P9B6JAikPLbCiGk0frzn2kJ/pU2nCHrvn9A3XS+DNteVWo3KB3/S+JK3MmrAE/AsRtjxeRdCYGWFSEIbOlex1YCYH5rOxEdhrFBAcCcQqkgTUD1YApQGA2/Vp7+m6zJl7+8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0871.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 17 Jun
 2021 16:04:26 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:26 +0000
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
Subject: [RFC v1 080/256] cl8k: add ext/dyn_mcast_rate.h
Date:   Thu, 17 Jun 2021 15:59:27 +0000
Message-Id: <20210617160223.160998-81-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ed1e280-961d-44d3-5ed1-08d931a985b7
X-MS-TrafficTypeDiagnostic: AM9P192MB0871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0871E5FE99CEFF72DD12124FF60E9@AM9P192MB0871.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rwdVm/M1qBSPvUDFr0wBQ6i28J8MWgG3pgc2ImvKHkm/c7kzrFvGErzGqqIIR4sGdYrV4N5EuaZ/HaOuMxR1VgmV3e4B3GSkm9tIB5l6WvMbgnQUVhrIkgs9MhJcCkeAdG7xJpHW0noaOIPgWwP9ooYzgn1sqdYV5ZzbbB0jg+Yl/k82Mk5l5tuKpzjRwBbhaOwIAWEatY45uwTkTzo9TQ0SxFB3aTog2Hoz+0l8XziY21zNF99Aaw/T5To3nDX8/KooCyXZ4sul2C2cJS8yuSTyjlgCwHzd/ZZHdfiV6w7Z176Tp+gVRy5vB8v2fJGJqWxlesxZjINcgfAqVkL+wa2OtYbeP3hCNHqpxOEqxE+T5SMpjzjbPUjsji65m3MqJ3aYdpthkKZN7XUCaAjlACTsMviHo0I4hTt6pi/xzev+XPTXoj+IA++nhht1wYrT4h2SKGPFBTLRfNoA8w7hW20IeFam30Fopezurs+zkKUQMYRSr7h5RyWuBNpqP+e1zNaYB2qAWTggJ/hcLZfVUMchK4XON7QIfTtE+FZX8cLELM/970tiuHmp5/e8Ocnbk3dCCl0gf6lMaRUF8YtF5Q0fATpD6LM55ZgyBeFaVg7EEW6I4zBD0ZsWmP9lq+VX9cl08Mowb67/PrIR2yJiogaVNnhZ+rEnTuT6JtYpOfSSrVhTyPQ2NGw+keUVbIxlIi6JGekptxROVfTCZ3G3ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(396003)(39840400004)(16526019)(66946007)(478600001)(26005)(66476007)(6486002)(186003)(66556008)(9686003)(316002)(86362001)(6506007)(6666004)(6512007)(55236004)(38350700002)(1076003)(38100700002)(4326008)(8676002)(83380400001)(5660300002)(52116002)(2616005)(2906002)(6916009)(956004)(8936002)(107886003)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NwyvqEOX8GSgIoQtaVTJcrLDA8qOLLv+wGFA2WKsq8Wq9ZxjP1SZ4F9neOa/?=
 =?us-ascii?Q?wKAeaGlGEyTEMrZlyQ0vAD4qSUnSqzAqet1biUU2ZY8++T6nMJIXUh2bNydN?=
 =?us-ascii?Q?cBB3tH3k4QkzR08rfeCRcmVpOHhxAH48ix5quEz59Fyv3cHvJWfMPPvKsAqH?=
 =?us-ascii?Q?OfonsFKa9NbK3EG0uhWLNmozYY3FEr9sLDjUGYFwUxTKf5RcHrzayQJu790E?=
 =?us-ascii?Q?rFKWgAOwd2AIbyV1kpA/W2cK0XFbfX9O+J75bJMCVvEdOmpoNP3TtDB+PQBX?=
 =?us-ascii?Q?26s1AnccvQ4eTh+yOzOxOkIR7gxLlfKD3ByKjxn0anC0y5u6iy4OhtG/BLQR?=
 =?us-ascii?Q?fF8BkJkqXPOnTI6z0BUr8+5oDOhXzghIwT3VBPoChZI4M5YiWLzRJyBQ+hM3?=
 =?us-ascii?Q?gTt1yxOgEGgdKc5i8LrHsUqe6PdAQhZisidxpLYmNYE3cNBXe1uaxsXAgqhs?=
 =?us-ascii?Q?FQqEcq1RBXOknCVSdhs/DlpxARVTV0G18ijAdNdlrK3T9zTxpaUE0FM34tiy?=
 =?us-ascii?Q?qsL5Kzwync9s3Y4u2sRfmKiWYbtTDcaFEliS+YsrNdNiiQIzfk00q2CofEqm?=
 =?us-ascii?Q?AQCzV/Uq7FYwG8qywMnAu3DJzgHEPk0CVLHc4NWH8AVsAxlgJXG1WTFaXzPL?=
 =?us-ascii?Q?wry1a5lbIt6LGz9JI16/0aYmLEuqeKu1UyzNerUGEjTbFZTDvvogUu+o5RpO?=
 =?us-ascii?Q?CncPrFln0iwQwDmR9CWRSRbGM2IW3g7Zz4QhTigYohvBmp5Ke3LzJwE9RCvb?=
 =?us-ascii?Q?SIUavBaDWjAhNUuCrYtHWCyO1p+bhl7eRFNQhrD++179dEBiXRKeJLxZB7RW?=
 =?us-ascii?Q?WIq+gQxYrj9fp8tq1kB/QmJm0wutIYgvKushlZr64WHTSQpZAJHj2piErgrR?=
 =?us-ascii?Q?syRJ19owzvrhCJn52PB0qGBcFlZcoF7/MoZChTmUXiMG4QSn+m3eCYzlYzqJ?=
 =?us-ascii?Q?+UvBC+xx1hGC8EykVFck+9Jsx25uUeERu6aA+dHguGImTJhInZyUpHEy1zdQ?=
 =?us-ascii?Q?POJuLIwVUTCg366jMAKWcFHIyVHyKeL3QkavQoIDmIgPAHAiQeLX6z/WbGUm?=
 =?us-ascii?Q?QNhicOdr2OlfBoQlxOCwPt43HoQ16zSsxEsGRK+y2uDn5Be6eE8ZYyf8IYgR?=
 =?us-ascii?Q?gpVzOilC9l7EADh6oePh8ImYpe+1P5Bn24/hOpxuerV5dHgQ19aVxxPnGdOA?=
 =?us-ascii?Q?IncNnSlQVBxy6bZlLNMGXCFxscSzm+xHUEJcOltFjdOQg694kxKFcTh1igBw?=
 =?us-ascii?Q?W12ABLYsD2ObezJzwiEBtn+QOvRGWEUCsPA1fzSC/LM4LyRoqvTsHtChLZVG?=
 =?us-ascii?Q?nbSfMKUzsD7xyaCrnZbdoCAk?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed1e280-961d-44d3-5ed1-08d931a985b7
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:01.3571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHN5EvXivvvnaVBLUmoM4USKm7jm1Ipfs0p7+D9n22vGRXI4vvQyJFlwEhtjhgf7oYkEb64nmUyL6ZbWMJwU5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0871
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/ext/dyn_mcast_rate.h  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/ext/dyn_mcast_rate.h

diff --git a/drivers/net/wireless/celeno/cl8k/ext/dyn_mcast_rate.h b/driver=
s/net/wireless/celeno/cl8k/ext/dyn_mcast_rate.h
new file mode 100644
index 000000000000..dac8c816c5a4
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/ext/dyn_mcast_rate.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_DYN_MCAST_RATE_H
+#define CL_DYN_MCAST_RATE_H
+
+void cl_dyn_mcast_rate_init(struct cl_hw *cl_hw);
+void cl_dyn_mcast_rate_set(struct cl_hw *cl_hw);
+u16 cl_dyn_mcast_rate_get(struct cl_hw *cl_hw);
+void cl_dyn_mcast_rate_recovery(struct cl_hw *cl_hw);
+void cl_dyn_mcast_rate_update_upon_assoc(struct cl_hw *cl_hw, u8 wrs_mode,=
 u8 num_sta);
+void cl_dyn_mcast_rate_update_upon_disassoc(struct cl_hw *cl_hw, u8 wrs_mo=
de, u8 num_sta);
+
+#endif /* CL_DYN_MCAST_RATE_H */
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

