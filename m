Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8761C3AB860
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhFQQH3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:07:29 -0400
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:40639
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232384AbhFQQHD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjvdIM7OL5fyyg9R4Ku6kDG0b/8T0TRdROzRMpXQvl998WAAjYR3etgmR7r4EWcJTGDr3a4mQos5/eBohgKO8ZBMMt1TPTuEKe45gDEg2p41Qw17IqaLLRKB74L+6ayErRo284KQUJmWo8k17yPIU0w04f/32uM6ZFWFmn7UcJmM+mh/YbN+KrD4qJXcEeC9hKQ0OQ7d1VTToodXSiXkcx1xF/Eye01FuB36kw9R2z4EG3NccQJuntseu5LO3Sa5aeRwRtNJ38Cy3fDGOE5bDdcTyQAw3Ncndh4x3fsSzx7MirnarKh7nB3Bi6Hh397nxN2xZehgbzuWQ/3KI1871w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjuLNHKGf/UZKSiSiSDyqbF7yCHPtESPd4hCTP7WFEc=;
 b=Bw/pAFViKYv2NGjuNZMVsRTsXJb7jpucCkDtzdzh1Pv4vwxY6oJD0jJ4N9ypVgJRRz1BaQ/veM+m+6GEb+zxxlq5SCY+Uo63p6jo+n6Cyr1OjZJk19ZEasGFmgfcVkBEubvw9bhBhaPx0g+Ob+F8eEaI38r6RYOFAe3d6u1mpM4LcCx33bxFI/B0Wa0jhhz8KVOZKNSlYkFlDXJETaxlbwepOsC6U/pkPeuc5YkxVYf+kImWmPVeIFmH1XChBCw0YFOeFn+2pPsFngnxrSkbDcUcy1/+3wW3iXTT1vENDWBrO8XV4yUdYBi37YTpyiI4M5yP7bOU8q8L/QboxEOQ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjuLNHKGf/UZKSiSiSDyqbF7yCHPtESPd4hCTP7WFEc=;
 b=WPiAYl7SttgFJxv5m2QVPyFRA2RVVaiCyWApHj/AE0U4fyA3pLLdboR6YqaAHZecxL+Gdq+ESpq5vW5Bl68QJ6C/edm7IpThvywsRVy1A1wpcg9gb3rguOi8NfCMnCVAJ0lYHEt3kK3ff9nthB0gyFtM9PB/hL98p36h8GdnwSM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1268.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:04:20 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:20 +0000
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
Subject: [RFC v1 066/256] cl8k: add dsp.h
Date:   Thu, 17 Jun 2021 15:59:13 +0000
Message-Id: <20210617160223.160998-67-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e3c10ca-ffc6-46d0-d558-08d931a97d09
X-MS-TrafficTypeDiagnostic: AM9P192MB1268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB126805F29697C456E925A6FEF60E9@AM9P192MB1268.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bb+b9PRD8lk2v/6vvMnFy8orR5DwsVusnwZfAzjCtR6FFWoTVPzfNH2vQWephYLI5VkqG65mz4V6bpVgYbKwtYj05J9BeUUZTkWP9xo1q5qs7o9EA3VcgZMVFbrj/p5mjmQIu2pEOarpaBeKMQ8M7AywizJtzMZtT0G33gFNbXo3S3kobWHCz2ycCTB9o8BuBdURYKXfSP+7dTH40qICamSAJm+FgoNks+9emCq41Ta7j+Ck5jXuFx/wE3YAzrlMDrJdhBv/PSGOBMYBFGD6rp8JOHF3yzKnFG62+M/IwiwL0RUcA6bCcjrhoDbHNNAMq9zw/wS5ZS+PXklqI+2NoKppZW2EocOLH01IGA6Gf6sEjC1l1jL2fqXUdIliN8iuW2gbNVdJFf7R8+dUCvu+dksUPz5fURVO6x+HOCG1s+ipLWTXBgXL9Sj+mSQAXfcmQLSVwhUC5EqATSl5t6nBS1FRATkO3y8LMVWqQSqbdTTa8AfTyQDi5FE6fA6nXoE37Km6jCdLlfxqFBTwlp8UceAlLmeG+ZBBhivmUAvPqHQISMstv79Aaz/AViRxcA/WwsWMDrAbgLjuarwhsA4lmxWEhoDVB/RlfsDAZoxYVudw5CWSaaRu17vPY85YfriREq4FKfy+o8vjHxCG4jWP2e2CdE4DPWft4KS6PanlyJgEEgJNNyX2RSMrXbWC9g8HM5R26Zhibj//7ReraFnmvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(6486002)(956004)(54906003)(4326008)(2616005)(186003)(38100700002)(16526019)(8676002)(5660300002)(38350700002)(8936002)(26005)(2906002)(6512007)(9686003)(52116002)(83380400001)(6916009)(66946007)(66556008)(66476007)(86362001)(55236004)(498600001)(6666004)(6506007)(1076003)(107886003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?34B+otSgYEyj+4peAwwcJ5dBrpikLbWOqTabdnYaQTQx/V6rwO1bL65+IePD?=
 =?us-ascii?Q?h3u4Zm2r39evT84PtapugTk7PDpcTYyv0bxNmetaWC2V3W25lQyO0OK+lFxU?=
 =?us-ascii?Q?4+c8ibj6ecSOfueYTn5hVFIR+u37BfS9ylbYszac/MjdecHENbSRjMbV/rnq?=
 =?us-ascii?Q?kgPlCCYQF9C3SQM7MgPqRCH5aamjvZRm8Cd8YrVnS7lkW/mivQjil0Wem1Qh?=
 =?us-ascii?Q?G9oUqpVB7qXjVjbG60JtE7mI69QNJxm+mmlTBZRMLKhiknIf+m/9qBf7UOu/?=
 =?us-ascii?Q?gTQb1+XHVLc6yZaD4DRbHsaPyMNQpCxCwrl6k3MLGWoU4zz6xY21oI+OjUN7?=
 =?us-ascii?Q?qBe9lGo9kuzzxy2Dn1M5Tx7vuR/6DkOB5BaHfgGflF7+aOw6B1YrKzhgN/dC?=
 =?us-ascii?Q?nWO2xGXdP9DADALY22zUnq+f37sLCnVGBRQEAI3XPKc2xelwt9K0AwZHRCCc?=
 =?us-ascii?Q?88yEIGIiue1g8b5tmriClMSCvQVnHsG7LF9/kHd4bG4akoPGsOSpwBdJ6IaI?=
 =?us-ascii?Q?4nX6QL2YbBxFk8yBu9dGObqEJn6q7pjmrpve8xm0kh7nxHYO2nQfd6A4etBt?=
 =?us-ascii?Q?enh1AlYMuAof5icgqHO0jlug8SPOTS8uf89ROjLPvMJ170bMoYq+uxNypRl/?=
 =?us-ascii?Q?Fv8j1pPNrKh0+KXqV9L/yIJZ99AFQf6xXwiuf2omkIQvjARBwlf7MMoW6Fsv?=
 =?us-ascii?Q?lrq76Vu2UdQk2jZ42fp8K1NeyAjg/jEwh1upFVKEjUhXLmAhZdlHnY+x9OzY?=
 =?us-ascii?Q?CueIgaGEQsYsu0OoQK7+zKtfnkwMKqfKeFDPV00qmTTRyncQFoGzKd4lfybS?=
 =?us-ascii?Q?tBexyXlgUxLvtjgZmS5I2V4AB8qqNY0pRtIsti5BCJ6oA0oNjww5qH1Cd5R7?=
 =?us-ascii?Q?sXTe+j3Qgwau+oU7geltM3hPJqTJV4TD3FEdLqXvsWJn4vgJDWUA7Wr3Iqui?=
 =?us-ascii?Q?/EbCVycoGTcGCbYbqLIUKuFETmUHqJGb4xH+eAmwDWCmpPJqUvI4h8/odhYD?=
 =?us-ascii?Q?VLdphSNfNFOk5Rtnq9c4BqHpW1SQZP3T7nMT19BhyTak1RSyh1mvi/V0DmNf?=
 =?us-ascii?Q?MbOC4DMc+7MW1bZsTsl/L0kzq2nYbP0Hwagr35T0trBN7DudaD3HfOtW0XsF?=
 =?us-ascii?Q?fKGGcBsrV1utihs+v75LTYK+/n3WYv2xJSlw9gexYpgpEPbPI/M++g0N6kzx?=
 =?us-ascii?Q?NsRMLxe84y0NgVtWXSgp6n0k9TldADzH4uV/rfjYLmxwz5anlFZw4nP+FJWz?=
 =?us-ascii?Q?NMhlWoqCLr3Qa8tCNmXL7ZISLZRrHpXgQoRVa59EPdp8/6usZ4xg/9FRokdA?=
 =?us-ascii?Q?3FYr8dmgjsq3Ma1U1ppI0FuC?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3c10ca-ffc6-46d0-d558-08d931a97d09
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:46.9035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +q3hGfyU5EqzjilegkYN1zM3uGrtiSK7nBq6ZymV+/posFZDqq4KfArH6zM3IdBJEKQtPLrDOBPydK360DL6CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1268
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/dsp.h | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/dsp.h

diff --git a/drivers/net/wireless/celeno/cl8k/dsp.h b/drivers/net/wireless/=
celeno/cl8k/dsp.h
new file mode 100644
index 000000000000..f9802c479e47
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/dsp.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_DSP_H
+#define CL_DSP_H
+
+#include "chip.h"
+
+/*
+ * cl_dsp_load_regular - Load DSP firmware for both TCV's.
+ *
+ * @chip - chip pointer.
+ *
+ * Return value: 0 upon success, negative errno code upon failure.
+ */
+int cl_dsp_load_regular(struct cl_chip *chip);
+
+/*
+ * cl_dsp_load_recovery - Load only DSP data for single TCV.
+ *
+ * @chip - chip pointer.
+ *
+ * Return value: 0 upon success, negative errno code upon failure.
+ */
+int cl_dsp_load_recovery(struct cl_hw *cl_hw);
+
+#endif /* CL_DSP_LOAD_H */
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

