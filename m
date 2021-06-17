Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABC73AB831
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhFQQF1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:27 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:38880
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233584AbhFQQFO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRULTdN5KWQKdkC8+9OqdLLt9pF43dW1baRJ/IP4q6O1yL3XLce10CrxCkzg7Yu11kSftwLVLQh7nO7GDt68zV+PL0fH7IKoCbVkqzxVxZjv7C0ojdOYbwAYMx6wnasC7TNQaJhfzCg0GkO+qdkdOVMGOyQtdnXa4E8O3Fet9dPsUiOGCn+0Gvgfs/eITIpLVzib5J/4gSQxzMJmi8VEcyRbQM/Y0DeOCPR713xsWHZMwKQe66TgzXuwpS8zv00xLeSbe3CL4XLMuU5YlsELCZEWBI/q5ke7s+yD6mW7/NOl01ovcPNksTy+ghailhh/KqPQpZgbWvLfhY/UUHf3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=We9cvzzmXSrg0UYdXtDLtYeGSwWxb4pX6XsACN4Qpjc=;
 b=cpdButZ1LuwGWIGsAy6FVXvdX9dW8hSx0W7zMtRZbFT0hdR85g/l07Sk1HxR1iFJUH9j0ZIHIuP7SGDYLkohUGRcFQlS5XlP0G2t5SKzpFQh0A7HZFm6PtnB13GUygk7MC7DarEd7gMeAtbCfNWRXUiPLOHmOh1otBBmwgAUxASwPFVeRgMgmyATjI/n8uV/Bij48CMm97tnW6gFOVxNRdHLHiGGOzE8FsNyCeyPw+WDM/Og8xjJO23f4stXEhlh+bXCRzvPq97xDSfXpx7YdTrowVEESFUN4GwngcoS08rYevPOXlMO61eD9cenfDWHMmHrJxfpFJB4NuC0txy+nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=We9cvzzmXSrg0UYdXtDLtYeGSwWxb4pX6XsACN4Qpjc=;
 b=I2w0EcjjND4Yt+9KUtiZIW2JXiKFPmLFasnFRDlq1UiEvxdy/7aqavywaS1+LhAjQBP0q5Ev3G2yHmc7wq4O7uAwye15O6e6Rb96k7GSt6Zx7jDoqh4NViF7RIDVD5HFFZBP6OW83Qve2s6iWjfL57CEyoQL5xZ9MsjWrRI6aNw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0499.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:03:01 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:01 +0000
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
Subject: [RFC v1 025/256] cl8k: add bus/pci/rx_pci.h
Date:   Thu, 17 Jun 2021 15:58:32 +0000
Message-Id: <20210617160223.160998-26-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e648c90c-9e5c-4f34-267c-08d931a9620e
X-MS-TrafficTypeDiagnostic: AM0P192MB0499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB049944C4A442B27F8F190F5BF60E9@AM0P192MB0499.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C/YaLueHdthfWHKOPqQlX0xboLtoMG1l8u3a81yopQ1xTnb1F+ASywpJTaDol5/bhA6Y2Du7fYl92EbjSkkuKnb3kDEK6YQY7fn+sChyFqKKYuTudz2pPQzctMaXoY9m1oxpDOlt9FA5Wur8Uki2RyLNe780As6Rtg8IBkWQzlQQbdrMZAqo1SatMn02urF8Tgp6g+wlC+4E+3TZwhb285CbDi+TLoxRFIjF1X2XTNZeuuGd1EtxLQpc2MtdSIHiEWl04DC0ZdWNGKWHdQZRl6bW6EnUrrTa7jpiI0wq0UABHssUY59CIjcG1jXXnCUNZ/awDQjvnzgYUep1QWmjm2enp/iPyVJhvFEgkIICAtdxYEY71dY2hdNjAV05Byuf2HMOTHGVl18G0+50iuzbTcjpMeS3QqqWN7ZsQKeM1UzadJPinAA+Pu7qG+tc5/zVBJZ0NGwIKn3yi0P5SnatUOV9M0haUEWk7qxDHLqIwFJ5iO1OnaS6sFfiGIOcxBZ1fbfwa3T8MhfXGnYVuZMlT1pooRuUuHLavAEhbsfWrYs3iqOJg4T4TTuLuoXL/05Bq/Zwpu+HuO7rYHna+a/kLb5PWCutw3VTQxbbjNX8uaZj3nEP0shFitoz8TzyYepQEfXMABEeDVWnYP0UpTVC7jISBnpD7uDrsAkAqUV3ef6Y05ZF9yI7brhfqWJaE2vG2yxtPtZXt+tDMU2kMUYnrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(86362001)(107886003)(66556008)(52116002)(83380400001)(55236004)(36756003)(4326008)(186003)(16526019)(956004)(316002)(6486002)(8676002)(54906003)(38100700002)(38350700002)(66476007)(6506007)(2906002)(26005)(9686003)(6512007)(66946007)(2616005)(5660300002)(478600001)(1076003)(6666004)(8936002)(6916009)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SfMKueb5radihOXk4M9gfnipMG1LT/LKw0aQLuduJodnc7LH8M+KJ1kfd/ET?=
 =?us-ascii?Q?I5KJA6a9Wy/2zSgzmXRV1tQqXoepDtxKrx43WhFSa5VvuGhEnklA6KjoTSn9?=
 =?us-ascii?Q?nEwfrPED3hm/AN6BcmkPKoNfntchuHDUMCWA5iX/P0JkmGUVVV6OVsP9Qeg7?=
 =?us-ascii?Q?v3Tkjf/+NTiacfagBp8yaxL91UbcfFsIb2bwIC9zXfVNz+0uifCKZiRg3zHI?=
 =?us-ascii?Q?SptDkcu0hbSwd1bfLlCOhrFbGZl/MpaPeX7uzAKxzWv5hKrzqS8PcmCu4bdu?=
 =?us-ascii?Q?nkwyd1I1w50Z2sQbIXPFtX34mQ9FokCnuyFC6TPTfm2sTVxcuMb4yyfgszBr?=
 =?us-ascii?Q?AN+u+GeycxEiiCY5+xKnyC9GwF4Kk1MMs8TO4I4wKYHGHXYx+aHxkfILFQPi?=
 =?us-ascii?Q?8D8UCPHozgDYfLOcHdjXdehMSbx2xaVFLe6aLggc3oMArUMAetA7KCStKbJp?=
 =?us-ascii?Q?lJjGwLWbv2GjKFBChfUzDXFTbmLY1mP1rRcKeisL0yCenA1CFNilUZD2Os+O?=
 =?us-ascii?Q?gx3cytz77chepGpV6E9vulqCnc2ZUyTOL7ArM4s/VfF3iH+f+87fXPhHtWAP?=
 =?us-ascii?Q?0FbzXPtKUGFdAek59635V5YZ1iLX1Y/0KXgfUgvRhJ3XPyXrYb5nqNSTx64I?=
 =?us-ascii?Q?78dDDcL6SXtMokdfQRmlWxlZVrCBbszHSd1Sc0vP+QWGuQ8RUsAOa501IDAK?=
 =?us-ascii?Q?wSPmLzxL4GHe/HLsyOD4r8Z5EU3YheFoa4HrILgvRxFlO8v54qZYhbTwDMnS?=
 =?us-ascii?Q?9HTjRlONcZiajlZnGP0TrHQDpM+DyGZlXd6MZu5FPzaB8u9a6nYe6D0+Smfs?=
 =?us-ascii?Q?fKJdtF4DDTZvH2MHT3rlFJWwhSEEeV45zg6Io7GeqTKpAGSZxd5GMgo2Npwc?=
 =?us-ascii?Q?CTTzeGDaArFjqvwB4HQNct8zDFMbogsrX8PQiUhEsK2ncrAX64LwAuLiX6eC?=
 =?us-ascii?Q?x2/yjL6KCpcYeboMMGHzOQW36zv/uW1lVvU6HaElXJWcLODbDet/xGfUgJ2e?=
 =?us-ascii?Q?60RQXZXTGFHcVP173hA3Q2O/3/65zVUD3kZxuApdc0n/m+Uc9p8xWB6M58E1?=
 =?us-ascii?Q?cYf9L5P7H2bQ+wZ29fPGKGgyo30RVRmJ+wg4iePVF4DrvcDZg1KfeYPSnC/c?=
 =?us-ascii?Q?/3sZfPU7M9DEfU5HY8l2iPMoe7+T+g0DMaNbi00aWdp6UGd9Rc/b0MI8MGpE?=
 =?us-ascii?Q?WL4zb/EiFvwvhS9DP+sM45faoeuyO3CAZ66sf/ujlaM5U7vngivPl/l7uFVA?=
 =?us-ascii?Q?oopbcpAuEog/68SCchcm+RkNe9a+796imGIxeaG5cW53FcWuY8dpshlGguKL?=
 =?us-ascii?Q?kAbMzjvqxjeKz6Ppe1zfG0Ja?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e648c90c-9e5c-4f34-267c-08d931a9620e
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:01.5348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEPdoENDAA3YOXt7/kzkf71rENGYUQO7F/02D+rjjcJiDBc0OIPYrbDeEWP5EPAtOydKU7bvh0WriHH3z40ccQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0499
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/bus/pci/rx_pci.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/bus/pci/rx_pci.h

diff --git a/drivers/net/wireless/celeno/cl8k/bus/pci/rx_pci.h b/drivers/ne=
t/wireless/celeno/cl8k/bus/pci/rx_pci.h
new file mode 100644
index 000000000000..71dceddffb84
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/bus/pci/rx_pci.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_RX_PCI_H
+#define CL_RX_PCI_H
+
+#include "hw.h"
+
+void cl_rx_pci_init(struct cl_hw *cl_hw);
+void cl_rx_pci_deinit(struct cl_hw *cl_hw);
+void cl_rx_pci_desc_handler(struct cl_hw *cl_hw);
+void cl_rx_pci_desc_tasklet(unsigned long data);
+
+#endif /* CL_RX_PCI_H */
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

