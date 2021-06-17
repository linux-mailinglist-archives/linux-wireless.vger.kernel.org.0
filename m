Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C1F3AB89C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhFQQJT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:19 -0400
Received: from mail-eopbgr140087.outbound.protection.outlook.com ([40.107.14.87]:56046
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233657AbhFQQIH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJlGjek5kRsSVfYND23nZQv0HOxASv+hA4K9VAUuMXE4ehVhPVXgOaO0bvd1yAlOlL5bwxSsUof92/IV3wxQ1DgNbeCpjmT9Heu9UJQebGhM4ItdwYZwFBxcrH2o/iOpzJBoXF8eIf69qMzPPjLH7pmgP8kVwxLzorpw+hS5e0kbtFuCP4BVYtw2vVn4f3duPFcc0FQ4AinxqK+QwY5f+jlf+Oz9bpiDPE14m4IeieY9Mr0fLW+hHRKRY7PsWf3f/vCQklLv3yEvIvOulb9YdgfpNdIC8bTQiV/e08AG2NKKQQ8yus37GKJ0Ubh9T3xyk38NYPQXf/hofLNGGYCStQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3K98+W6yZTumrcOlnTbWY6MzJWfH+3Wm3yaRD+DhWsM=;
 b=DLWtvNRmcidYhZ/QEb0PsgEPqMCmYz4dTvHkEiOX4q66ZtV7rg9+W58YpTk5IZGsk2pUUPVarGxkqtnreZBAh1UIP33dAjufryahz9ddH/W2QWG46mbd/TBfM1ru1X1bhffD55Xi1BMUG9rBaiwzHm4xHXQYzmK5a9Sij92KxeHYDCxaDlCH/JbYI8DGOP+2BMuUH9rT7wKLo+joxkROs/7/nK5VtAj+B42Eeh9RApqwJRj7mXbHgdVv2DqJyQafGnVKyNbPnPKg3M4z6aZ/KND20L1s2Gph/b2q3AHHfWG/jGBZpDgYlIQMD+v3vHVSDst8xsYFzIOQuGTNJRpZKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3K98+W6yZTumrcOlnTbWY6MzJWfH+3Wm3yaRD+DhWsM=;
 b=KGeghr8peyP0z3JkKqR7gtsAQHWuAJ9xh+CxvOcBNqerm6ZbSC8Eu8SIiY8tkvOnn/n6hapmLZLlt2GTC5p6akDOotmbiBU18XnOe8ZXW7NqFmw+8gmvXqeqHCAtJFf4sB2EsVtOZyKnBwNb7Qq3jZyww82iF5U0dmBE50wfNZk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1059.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:05:48 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:48 +0000
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
Subject: [RFC v1 136/256] cl8k: add power_cli.h
Date:   Thu, 17 Jun 2021 16:00:23 +0000
Message-Id: <20210617160223.160998-137-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c29ecaf6-73e0-44c6-a632-08d931a9ab2f
X-MS-TrafficTypeDiagnostic: AM8P192MB1059:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB1059F498B093B4A7013DCBBEF60E9@AM8P192MB1059.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: asMyxCFdOzrohFPSGlg4Dp2/bFxDdNfC0KZMvTF710gn02khuuwswgiU5Wy2p+1OsneJjk41/aA2D0Ilvh5c44Xksbram/eY9NDqcpqL3cEiwpMZyiwUDix39+LF4gJB06qNPEfN5/syIlDSi2UYOF0TB2IXgDfyyiw3in8vTXEPcpypMRa2mRBQldNCjuIV7rVSWRkaY3JCGZJpA4IvTUEEkCMWzhEOFHRekB4heI5yNiOT4G1J/Ym/OzJrdVu2uGbGuzWJ6EE7GNncDifFeYq15FbdMEEZvEKW89PqRsqMMMPdPDpgskeUdnVObu4ZClOObRW6s03TM9qRrRbm/sgQh6sj7HOijJnNPldzXgbuZMXqQN2hoaK9yK3hRThzuxvzuRfo/57lidvzO6Fvkr6i5WuHpAL7/1DDTj02mQXDxS6qmayG3J8TyfYLbnlgCM/HT28T9E+83vpq6l5iNmiSnVT9K1WtqbA45iMnK6JWpRK0/cdMAWk2adkmkOZO5ymAGEZd2wXOufaP6h/aso1I9CB9krm/APvpZtdM3f9LadR6O8shiyW4YBC3jK+FRayNh+YN2ogOW1fb1G4YLI76IIFcO79HLq+XjQyr+6rRiguYFaW3ULtScQTL/Ti8iKgkveFCWIbuVjbJ+jc+KnPmrLRqhMgxsltc6y4j4mCkgom76eCKluVxol+1qJzos9QwJML8140qT4G+LAh2aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(26005)(956004)(498600001)(186003)(66556008)(16526019)(107886003)(66946007)(66476007)(8936002)(6916009)(2616005)(1076003)(2906002)(54906003)(6506007)(6666004)(4326008)(38100700002)(38350700002)(83380400001)(9686003)(6512007)(5660300002)(6486002)(86362001)(55236004)(36756003)(52116002)(8676002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EaV74xw4BqQaZuJvaXnRCuQik1HqMZAf9MddKwhWfwi9+n4HJSN+wPAanyE6?=
 =?us-ascii?Q?jTdMzVWZMA/vOVMPk6b5v6THOrFTD40SqLPY5DyACGEZxkZNBQsVQUV5P5lR?=
 =?us-ascii?Q?X1yD2tceEyQ6vgbxhiM6HtOk2sowohy4e40k5IsmaosJoCqTaY+LhjMj3uyE?=
 =?us-ascii?Q?HTUXyOcOkquwqP5X9FprkjH6i+8z5MolevNF8DLSy0k0WkaxS0u7HOwS5QQz?=
 =?us-ascii?Q?bqtxMiqZS2Uu4PYt2v9yVK11gM9slou++btt2qgj1Goe6QQYaWUMGVpTV9eo?=
 =?us-ascii?Q?lFZqqq6VhZsSgSEmWH7qfJ5N2nDxB4p4XgEsmlNrZ4F4j9pQxXOcmpop/gUS?=
 =?us-ascii?Q?nO/0TtbOb/fO7o7QovfUGgDRPtK+hvPOSKShcKaFOlh842dtD1xfMwO6xVEW?=
 =?us-ascii?Q?qaXkXmarE0Fp14QKSy0y4KdAqJHc47A7ac7mry0W01Or+CMWB85s4+vaHKV0?=
 =?us-ascii?Q?Qdn4h8Dl8718fifveJAR303nu7PP+3v+RHpbDFyVpbm8m3Kp/gCJxgajOQtG?=
 =?us-ascii?Q?FtrUi2nE86YW5wYxaf6+BU4PjcJn9m0OTb50tLXaGvXFrnqnOZNuTr5RG5b2?=
 =?us-ascii?Q?L5KagD5D5jcxZzay75urwErWrQ+gq0hDW5j4j9Cp1IxxW0IUCp7Ci1vz2p9g?=
 =?us-ascii?Q?4eLJmDbaXjbFpxSUkmbkddQGgA0BGAXnphUyqXQvXLp7ZzD3a3mdm3efNgzY?=
 =?us-ascii?Q?BGTAvPZ1T9Dv6PyJ2J9g9z3alFy+rcm8/NJu5IIsR3cS1f5hLVyHTaBITPlz?=
 =?us-ascii?Q?uoF84ICmNaR4G4LKv6nj5HLgf7B+EnfFrsdUFiZdqPXPCGL4GCNCBut5OEF5?=
 =?us-ascii?Q?nK6+XAZ/uo7VYX+/6XtIBfm00RCv8QHfz8lvufXpOESqT1D9qo3i83olXy/q?=
 =?us-ascii?Q?tQZt6ldTF9a+uyBWVraW6hILcBqDNzGy1Z8tJ/cUgZC33mf8OGftSNDBbmi/?=
 =?us-ascii?Q?KlxTPHWFW8zbnlX38JnQtI5cNhiO3RjEZeUJPJfZbsIPZeP8PIUbymZBYrO3?=
 =?us-ascii?Q?VurlbWSnlLqFxHkX0XAkeBX3MsL/PuWFSLiuTeB3G5DO5uLGqPMRXmsSvm/a?=
 =?us-ascii?Q?j1Mx0sbHoOGEH4Zny9BoyHjALY2wEWyyh85GR8Pi/vxWU2ENopn0w9yjntfM?=
 =?us-ascii?Q?L1aHPIryguY9jQ/D3Uz30FUGsvmtAeQpHx9WKwFqYy5iN33/zQiXyQr2D/zd?=
 =?us-ascii?Q?JH0gaO3ohuHfeM66UsLCkgoL8QYyGLYbVfW9R4xg36WaqasTJE1FkTN+XCh/?=
 =?us-ascii?Q?u3sMnQXIM+gPsEF6wu6CIV2Ad7o8q/Nab5FZkPWmNOwEp/+vqQoykCy4vFdi?=
 =?us-ascii?Q?aALrJzoBBiyO0N8ZVQSUNsnn?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c29ecaf6-73e0-44c6-a632-08d931a9ab2f
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:04.2838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/TIpVPDAZQXMFdHHZ0UWuDx7nKpuySc5onAOCkWcA1wkCR+4xenUsIjQWmoucJCc6RzTJWRmLOsjgz9u1/cqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1059
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/power_cli.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/power_cli.h

diff --git a/drivers/net/wireless/celeno/cl8k/power_cli.h b/drivers/net/wir=
eless/celeno/cl8k/power_cli.h
new file mode 100644
index 000000000000..c88e34a249da
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/power_cli.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_POWER_CLI_H
+#define CL_POWER_CLI_H
+
+#include "vendor_cmd.h"
+#include "hw.h"
+
+int cl_power_cli(struct cl_hw *cl_hw, struct cli_params *cli_params);
+
+#endif /* CL_POWER_CLI_H */
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

