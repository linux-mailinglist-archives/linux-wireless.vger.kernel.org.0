Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A072F3AB81E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhFQQFD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:03 -0400
Received: from mail-db8eur05on2077.outbound.protection.outlook.com ([40.107.20.77]:6177
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233538AbhFQQE7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:04:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qw/YVX+LbTyWsMOznnK77HQlCIE2f90NsmFYlsHHXVNcCECM+n3iyQMpuksn7PWGnWousT5FgAZA3G06DAjjcv5kxSqZo9pKzL7gq0pKWOV523n7Z8pE5nC3DybXubNBW2t5l1Q3aAsasx/wNNsby9ynDj4UBAyIUgEMdhnWiQbq51tiCrpJlV/o2QE1bxVGVftFYqLKeHWg+NPClV4WKp+Mv4sG7mVSSQ5JuqNkWf4PQH5FlxVjUbkSoMPnsn1QgVBSQoNe7VkKUpul4o9H278TrZbfeVxqQhVjztbCRrFqW2GpgQtBqOzULOGIACM63/4HFmB/Mpc41qdhgAXnnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EorWXVtlnmCYtds736qCbyGLvy5QVpoZYF2afnWy4rI=;
 b=GnAm12z+GV0kNXiknkuEuOhAL+LNsjW1YndrbbYR2sMQSS8wKPt2ZRACp7qJFq9dhNtx4nEidmppV81oLa4zo/0B+MhVWI0I0IhpbxgiICKXA+are7miFG9AphqVGEhOLJEn/3Ha11UBSaneBw5WviJUSp1ko8w9efMoCBqzU3tkkuYS45HUY0Rww0+eowgxjDrE51b6iNGHSKDIRexoXoSJbH1Qit+GbOWcX/y4Naeov7h+31MHVJjgRor/bWVFPf5HUb0mJ6crX0S1vAEOjju21ghUfEcmyucnesnSWdpuA+4xff7yGQZVZI+p+5hMYmQ3N2avDtjosbaMDn/sEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EorWXVtlnmCYtds736qCbyGLvy5QVpoZYF2afnWy4rI=;
 b=jEDpW4850j5niFMCt+JZpXLt834ZQ5a+318jxaWe3QCrshNvbzgjQxVzgVDN5yaEz/o8jAB/J/f6BXHGOR9e2HCbHYUWhNNR6MUEBdVCWwdXRDocO7ewcpKGWRwa9J0RnM+ak8NroShu0v3lOjGgUHKTT5MC5fi4uoNrgNaL1+Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:02:40 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:02:40 +0000
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
Subject: [RFC v1 006/256] cl8k: add afe.h
Date:   Thu, 17 Jun 2021 15:58:13 +0000
Message-Id: <20210617160223.160998-7-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 914caf46-fcde-40b8-c25d-08d931a9556b
X-MS-TrafficTypeDiagnostic: AM9P192MB1412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB141263E338455776347C2BA6F60E9@AM9P192MB1412.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ykfnGyLeSNshtAkq7q78UyzjIcKfA6kR7+55m78F8KukxMzq9Znz6fvR4nMBM1eS22wOtZok9JkLV+lVDbpsS/MXSIojjAm8iraZUafn46MIBPcmnpGC7V/WDMn/S53Uxu5Q8vh1E+KqhDel1o5Q0VILqi3BcAeNxpGGUzhlMzR0rllGcFKsh4Frg7FNT1GJj2dO2knbUnwVZQ1Cw2Pn5+WWDojNqb3E2Y67YWPq48typhVgwK4QJ+4y3TjP0cTzhIgBIMh2kjFMvzniEkQH4Fur84eZKmg0F0FdB7yDZm8+H435nk3cJtGoa4fGipiqa2Ib6996l37wDH1M0LpqQ9M3luzQDyPwX6UJFkoR0gXZcmolehI+SG1GzcZZtz/Nrv1ejp0VE0HDMDJUS5bcpt2NTBVM/MHpKQAZZMMPln7Hd08+WyLCWZglSKPibXRRejR9MAQIJwW0o9xWbGnhjFkQu7ED9zu4x1wZbsAy1ilf6op4rBJgzGibF02csrrdDggqtQ7m774YgOBoiKb7XHrffHkMwXdFCTpbVUlwsEHh9eXx6ynGWHSYRqHQYp3cndmMXDOT0jvORhNOwyWLOkTOjt7NIJm8UpNzBnYOs05g2vitcDNalImcZLFe1hrwS7982J4O6ZhBXFklt9uq1hGSx99Hg9k1SSE007yQopuO3NLgwbKAuV98GbLnv0rb40GGgMS3kVeVUK8qSnYEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(376002)(39840400004)(396003)(38350700002)(9686003)(16526019)(38100700002)(6512007)(478600001)(36756003)(6506007)(52116002)(55236004)(6486002)(186003)(66556008)(2906002)(8936002)(2616005)(26005)(66946007)(956004)(66476007)(86362001)(83380400001)(107886003)(5660300002)(1076003)(6666004)(4326008)(316002)(8676002)(6916009)(54906003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AAgHEjDHd79bh++wAllW+bv5eANSAfJA24ydJBQaMCQnz7mGahPQPwDj6r+z?=
 =?us-ascii?Q?YhOcnpCf8iHIVatj7Ii6pca5rFsWZgpRAHSseYVR7rXjwp3fYaQoUc8XahGP?=
 =?us-ascii?Q?AD2Ii5P+u8cU9qwn+6hZ9BnevYe0tJYa662FWAwC7F67MjvebCcb89INDMLz?=
 =?us-ascii?Q?eygKxWPuGEFfXP04kdoFM4/NsDp1j5wsZez8ZW0YHx0TcMTKi3EsViz9Od4y?=
 =?us-ascii?Q?7TO1+9E6e/cRyFpmwyxSTIzdBykM8ZRflNv+yos7bDHIk9vGvMb0HLal/9uY?=
 =?us-ascii?Q?l2PXTpV61ZHAY7NXVWQjR+wRB9H4fPhJSAwR6f8myKCG3FprbZ11A0lKzrkF?=
 =?us-ascii?Q?8IDAXVq9nyUMOZYKw1ysIWQLJn0SwD9xPENehmXNo/ZDF95HE4XX4YPRIqlV?=
 =?us-ascii?Q?LIqTbqOaPC0YFdsfbhzEpZIJNkxfrkmLVbZ6L8ruQq4lndxErAw/ERMRI0XC?=
 =?us-ascii?Q?5+C61cQr2mb0N9dT4qyaXa+tST18veXbxALjBsZJdXkuk0D0FAo41NezmOi4?=
 =?us-ascii?Q?AfmlNJPB1JlxtUMSdLSRXmyBIimq/Nk8Spx6L/BWsvPiwmgty16fi/UMN8OS?=
 =?us-ascii?Q?A61MOHPqZP+7dPRrbqY1Z+9l1hoYa4kVCPje1CpiHH34QRVrdaaAQi47W7SP?=
 =?us-ascii?Q?IOFRcdW5tX9Wc9B0C51R7z2subMb6ovchb+aq1SEgNemEFZoDzgvIw1G1Y2/?=
 =?us-ascii?Q?pGD4g1xmgTcTCQlh6qZOh24v5peYnJrHJ5/JdSLu6+ZZgq9I2nuMs6p/jPAe?=
 =?us-ascii?Q?ZjhIYyIUfdErw3TlRatMOQSB5rSNKIUuiO85Nu8ZkGknx6ZaQlO3WDIcqxqd?=
 =?us-ascii?Q?mGIMwcolTszzGW9Py7ATBh0vVtSEzG5CFwVmJv/IX1s28rFRP70lYHAy/W3K?=
 =?us-ascii?Q?MpTZ7WPK3BwMd6rJlMXQyMvOnu4EujBZAcvJ0Qe4yEn6zhCPM/4Bb4EH1yBz?=
 =?us-ascii?Q?MD/bunoreOupJpFRdf1eIcvCw/Wd4bCiqh8EFL+5o3vHaxyfOaVL3OaJGjGV?=
 =?us-ascii?Q?P/jOiUzFCQN5BJrFMyUUOkUVANsDdAyv9s42NIPr3j5igSDrOvq6nkE/K/Bw?=
 =?us-ascii?Q?9R5s7DWKLSSugvzi2IBAMzLjY6VeEkNap4ATZrMb8ovvogAUMf2yjP3OcsHF?=
 =?us-ascii?Q?pCdqu99zyLHPwlU/7qquUvYxQ6h2cpKLW/gaLlzS0R3l4W1x9Hst6N41VJaC?=
 =?us-ascii?Q?VEZje/6kMh0f3okgPWjObDd+pestR5YIYXRHzoKdthdI07a4ydLKZx08pHA9?=
 =?us-ascii?Q?yV5jkbGcpiMFuDO5hYQt2AGqqgKQE4f+QHT3HOvreXtY0tRHoSDTlh10UDJI?=
 =?us-ascii?Q?rBxxB9p2QdUqtS+7nFWjEB2y?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914caf46-fcde-40b8-c25d-08d931a9556b
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:02:40.3548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rWMQ+CMT1qgZT9saVriZy4F2R5xtC66l1GXuMgJW9f6jYBh39UXNFkWW48qGZTxD12VLJGEQnJdpFRQyiu9iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1412
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/afe.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/afe.h

diff --git a/drivers/net/wireless/celeno/cl8k/afe.h b/drivers/net/wireless/=
celeno/cl8k/afe.h
new file mode 100644
index 000000000000..3cf713a57ea5
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/afe.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_AFE_H
+#define CL_AFE_H
+
+#include "chip.h"
+
+/**
+ * DOC: AFE (=3DAnalog Front End)
+ *
+ * Configuration layer for the HW component, most of the defined operation=
s
+ * happen  when we start the driver.
+ */
+
+int cl_afe_cfg(struct cl_chip *chip);
+void cl_afe_cfg_calib(struct cl_chip *chip);
+void cl_afe_cfg_restore(struct cl_chip *chip);
+
+#endif /* CL_AFE_H */
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

