Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E763AB877
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhFQQIO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:14 -0400
Received: from mail-am6eur05on2057.outbound.protection.outlook.com ([40.107.22.57]:62080
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232424AbhFQQHh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaHqIG5J/C6d7hnb2oT1jsZYIJh1f0fQCeSOJZZdvEe214R9y/mLea2QpOiXcwBqQjaUYFz9fmXUXEURb/K3xW9V1/Tjxt38PR6rRJWus0X/D9dJ3ksL/Zzda5LEtU7iAD7sxFXIjh3297mUqsDkS8AoKBFtG/BM0VNaai36fn/swwA4U61RQxcmhacQJpem89QhwFLwnO1C+dXueL6YWjr/asUfTJEylVl1r72vByvitZMKSxq1kBTBFZ5P8ay2hj4bP4/H093ozUqoAwlBD9cOUNpOWxmZ2psAsynv56HR7Y37OJd/vVBmy/CyHI+rrs0NuzWOf/R+bm9cY4yeWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D47JU/znNrEF8YpMlCVrspvHyGdUaiNjoEP6ubQwlqg=;
 b=PPIdDhe+Gb6b7SxkOl/ti3w5FMvnZ4XxGRFV62v8fpzs8Nzrx8pcL5ZqaBMUSOY6iP/hI4Z1JMHyOHD0mcPSYZ4o9cG8dhFqSTlk7ZE2B8N3ooypdoMzHxtXMPTGmp79ecIKmBYMN+sqBW6g1w2kNB/07Tv1DH4F/4/a1VaoI8qGR/2+WncHQANA4TILo3CMTUkByNcKqzWBlRzNnV2AaIn87r2H44IlwUgw6Xg+ix8cDe4FkxNyWDWaX6NHlhKJaGiRD68qlQD9YXOs1iwY07sxt/6TnHtiB+0eCK3LMu9LGCB9Z0cbZZsTc9OSii8qwgRpkwHMCRzsmCLVh2qU/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D47JU/znNrEF8YpMlCVrspvHyGdUaiNjoEP6ubQwlqg=;
 b=ajUIPhduSKnzTNE4+1s/Bv/BTWtLYld3IyAu/2pM2BTqOytrLQlnMgIRp9ah1CBYaEh5Z9kS7LJ05m4l6l2JmW556t6TJvHe2MNALGUzCTWGMGwokTlBRaYLqspZChy0BMajXVLfYZZ3kI3hrxgX5uOuziLfwtkNYo2aeZtnPAI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0402.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:46::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:05:08 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:08 +0000
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
Subject: [RFC v1 110/256] cl8k: add main.h
Date:   Thu, 17 Jun 2021 15:59:57 +0000
Message-Id: <20210617160223.160998-111-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40c7516c-8c6a-4a8a-0346-08d931a99a13
X-MS-TrafficTypeDiagnostic: AM0P192MB0402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB04021BC34B5A25AEF52D654DF60E9@AM0P192MB0402.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Daz+ZZS0my/7hL4VKQt+nf39k9nISlu/HLv9jVCMXO52UIET7Pyhx3LG0WxTAFRQRVoRuK+RlmJTitaWhp9Mx64qHRJcLZGfBCU/9ZMCDmxih7697j2MAib3eZ4377P70DSQUpjWv8M5FsuvdxSHyOLdAyHEDr6YfVpN94sSS8DTJreQgeZJXQQNcq7UGivS+Wib8bP8Er0CpzT1Sbjqms2z8BykGKdP+1/Y7Uzs9SVMDjMs5dKbA9n/sI8/7uexcQBxP2bfHoKH7i7XCF6XE8npJg07EhzP79YYcSZXF++Fl7rtCmgtiKPMfNIddj9Ke0BNSA7xrnneMcIVKqipJ8mdpa5uAXxnJtj6K6c2bL9sWaZCwDLAAh5qD/X3R6uf7LhyWpUIRcfzkHIMtD97sZTre74LQYeF94LldWMs3h5HhGrPBEmkApQwBBSIvXavh2iZb7NjKDdvACZJ8nFzN0hyCqKSKj17OeyZPeMG+vWLPxFxBS07Zs/NYMDbqk2lhyj3hgngKS59H2G52vBw5K4xZtZbsOZO8wSQBpPq6wU5hiwbyWlWpMARMCaVJBNGO9npvWMtgURWwwet6BnMXT4DM4l53j5qO6CPxWOw/v7GIURXgZ8xSwLhMjtJwmKlldGsmQ9oIGJMPOJFIuc6N6ZrPj5TzUK541Est8c7VVGQeLdWhbPVJILt2+Qe3DumxV0zZzWBiCDPPOsizwkjKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39850400004)(136003)(376002)(396003)(366004)(346002)(6916009)(6512007)(9686003)(6666004)(52116002)(2616005)(186003)(16526019)(38100700002)(38350700002)(1076003)(6506007)(5660300002)(107886003)(55236004)(86362001)(6486002)(8936002)(956004)(26005)(8676002)(508600001)(2906002)(36756003)(54906003)(316002)(66946007)(66556008)(4326008)(66476007)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?24JqpNsTa3i+V26dr2tzCK75M1+jbTkzX/mT/lqPrymxcm6s/ryLpCRCP+WW?=
 =?us-ascii?Q?VFLDNZB57lut5iCHtW1nTzsbwC1Dfs2Tg5rttjSCvCk0YbwTgN/BkLKxzCS8?=
 =?us-ascii?Q?rTfyP6tECZ7OkBOpZWncL6shyfzrhjj6ovKdV/0bGaiR9ngLfAZs71/1Fx+s?=
 =?us-ascii?Q?KZkYhGXGPE73hwgbZZ6HUCbJ6FGervZuSw+hvXkxiwmtXtBUmpOhLzTGZIXS?=
 =?us-ascii?Q?T2b3O729zUFPHYfoNJjM1c09YbP/zWvEvF5ujwNcwj0fb1s87equjJIjMtP2?=
 =?us-ascii?Q?pgb/JiBM4PxxOjPIHbeebH2CU96O3foywNBislYw7w1RSpHOekl1E4oilwb2?=
 =?us-ascii?Q?iDQBVv1Hca9Xaq6EXsoM2cDMgjyGR0e9BOBuayBLONJVPB9GTIDiwI8oVKig?=
 =?us-ascii?Q?+lyg7WLhjfaipr2tkoSkyv5VoTsghd+aL4nof0WPSOLNIfHENXeqdm2IYnBI?=
 =?us-ascii?Q?t2mdDKj+C/g60iR6c29OCypY1YgOQOhgisq/x90ocqnvYJ7oxxGP87hlfX3F?=
 =?us-ascii?Q?yCTLLaUPmDLPBQzJIB9JI/Tx3VJG6iqA+FnrA69iZluisRf6UJrwpn26xKmA?=
 =?us-ascii?Q?K5v4yjnZliMR82hWwy6nWLsAvMtQQXvCrj8DB9fOm7lI8xHONqt0haZwYRQs?=
 =?us-ascii?Q?mfrR9D2rO64xUYUdG4msAn6fJSd1x+xEhDtrVOz1YsUZJerulMYlgTBlXPvi?=
 =?us-ascii?Q?Y1S6/xk1QyTqGZJ36bcb0+YKxVV4xeHt5UNA1DHfI1Q/o1V/MHxQ8xnKJP2A?=
 =?us-ascii?Q?tFMjuw76tn1OreNYQ6mdw7d0JIJJpB7xC6HgIkdTCZSTjZP8OAy4bKc87ExD?=
 =?us-ascii?Q?4N8B9vovpyw4URBYeRZH6nkgJqdzvMjH2Jvz6ablnP9qAPg1pMGL8WihUVfs?=
 =?us-ascii?Q?sSw4EGpWvmEoCQXsFF2QmPrfWwmFk8DrPRPtUelYBlinCUVbW6Hr6kNypiLT?=
 =?us-ascii?Q?gtyEtWwfE7DtPj5kQS8vNnM8CPbTO0uvZ4qoZ6WPWMTbE3k3mrmzu9AHEebr?=
 =?us-ascii?Q?EUotMyP90INLmbLEZzXZpfPBlC5yhq98402nRbPtgYpvLVOmnoZV0GRBnOEs?=
 =?us-ascii?Q?ZSOvlBw/KHcln52KaWQQg9EittD+9rTvqnpa00vr8N/dI6+4UKv6H0EZfNim?=
 =?us-ascii?Q?6sfPeJ88tzDXetNzhVsPCvzlR7rXkEtRBtIMtpkS8rLMcFIcxuOWqhS84GJM?=
 =?us-ascii?Q?bArD2p8SKnJJgef2/G4P8PBmOL1cZtPMwBhh6ivc9pF+BhG02onTcjiwLpoe?=
 =?us-ascii?Q?TfBw1FEzXGPIpXj6ESVwpWZhNsxpAWL5Kbn4PSV5urrnu7nDGsxUSAaMfskm?=
 =?us-ascii?Q?FGC4wo14qrQY2h7gW5J57MbX?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c7516c-8c6a-4a8a-0346-08d931a99a13
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:35.5161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w//oo8B3xMbujRjDxS4xOSUbdSFPmfubiVkigoW3lT+y2c+wW0HrPA3MSja8/t2mjvpxmMbQdujUmOuFdLnnwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0402
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/main.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/main.h

diff --git a/drivers/net/wireless/celeno/cl8k/main.h b/drivers/net/wireless=
/celeno/cl8k/main.h
new file mode 100644
index 000000000000..8fab87e715f5
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/main.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_MAIN_H
+#define CL_MAIN_H
+
+#include "chip.h"
+#include "hw.h"
+
+int cl_main_init(struct cl_chip *chip, const struct cl_driver_ops *drv_ops=
);
+void cl_main_deinit(struct cl_chip *chip);
+void cl_main_reset(struct cl_chip *chip, struct cl_controller_reg *control=
ler_reg);
+int cl_main_on(struct cl_hw *cl_hw);
+void cl_main_off(struct cl_hw *cl_hw);
+
+#endif /* CL_MAIN_H */
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

