Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606183AB904
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhFQQLz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:55 -0400
Received: from mail-db8eur05on2086.outbound.protection.outlook.com ([40.107.20.86]:16332
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231422AbhFQQKm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUSjieThwToc1cP3qADyBFWSn6SJb/PrMBfwvCOCMVNJFAhepayBjFAgvuzY5K+EZPRzbs3q7ZEezbPUaO1BoGu/+p3TItfnP0Vtyogmqiw9GW+mttQZbXuCStHMV9/OSTKQhlizbuDHiQp0XsxSv72uHKRZgeFoi4X3wxTznzP5GeOvkr1GCyF3tY9O1umnFB6tQmH80RUNf3CPe7QAnpMoG/Q3HBJ8RVPoFGNj8gQMysQuv6k9/bDMB4qWLBZ9E8QfJXHl5D8RD5A59/o4BxOL9IuFcIZPrBw2ToTbl+llUeQU6OWvjJorMDUtje5W1KzrpGFWO5MfLlj3w77jXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7tPEW+ikQB2FDc2cXVMiynz6jWjngko8lAjq2ToarQ=;
 b=VITyI6wRLaencpTwlpdAzeOUOYsWoNuhY8wT0NJNHTEAP+PF462JtZUAwQf//D6uBNVi8b1P4SFguZEV27WSCUTgnqtaRcleR1n7pNYCNWY9hAgPdpD5Q8NW4gwqCob2QXfsb/5LjZ7kEfg9UUgaSnurxevcf9JyJucANMiPDA7ZyiOPwfP0jWD227lDwkT5oyyNBGqMS8NAXLP2LLPn/KpaX6yol2Rus6ed0ZL2k4TV36K5nmFhi8GnW8pu6pZVQHVmv+857SPZkw+6+z9eBdY9cBmX9NblHn5bua/J9JlYgjzQCLmoFQGwHu9Nl6V4foLHmH8vvQ0v1pylRJGVow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7tPEW+ikQB2FDc2cXVMiynz6jWjngko8lAjq2ToarQ=;
 b=2oa7lBvMOfg1MmLvrRkUiPv3D4FAGTRjqDH2A3TIZJZxvSKo1gMFUKYPq1XYofJPz19kpl2Mls1orf7Fco/Fh7HoG9IliXBPepMIEGTUCmcbB2H7VH1eWwwn4MQN6PWZrUFKYEKZLp4XpVQfoZJHL8tSjuMTSVLhNFoIgcJrDIY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1014.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:08:32 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:08:32 +0000
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
Subject: [RFC v1 242/256] cl8k: add wrs/wrs_ap.h
Date:   Thu, 17 Jun 2021 16:02:09 +0000
Message-Id: <20210617160223.160998-243-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:07:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ab3cf71-83f3-4408-9895-08d931a9f2bc
X-MS-TrafficTypeDiagnostic: AM9P192MB1014:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1014A69C7FBC89D3205AF170F60E9@AM9P192MB1014.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t3rQcKmqJ7rzFxwtfH4UZ1O8y0CQ3nhh3isBfm4Y+6ZuTVPvwLUzB4fhLm9/RcdRDNoF2pOSKKAtKBqx3RMAtbjDsmwYtAN4cxSjrvZnuX9aRyskcXGGF4cLMvFH0WtMAEnjrNO/UqgScsK4m5J2e1sGURckOJ+kNrwB9B9QrLD0cP9ZwzJuOV09NuoXrlMFYMTaN/eqz57XTjIdx5lUurC7lMdvHO0z/Qleg+8orOZ7mXA8b6bWFqmHwfnl/+AYCtFkf8CB/jFhQS/d8lcLxfty5xUHZz6FrnqQHFVJp9xAg4JBhYp377IKW7kH6U++XubHMH6kL3g9gHuXjhMVRJ2xiU3JEcydl93I188Dcmokyujl6aKrBKl+8mpPmkjah85KivKVDfqK4hx1oQW8JguwrkzW0dWvJ3hrtTx2SUbbJW8qvSa1zM3UmwB24ZKYaSUHnmEwrw9enEh82uQ+hx4McEKTMGdRPEckHzEFuiOt9fmToC8UWebNyLZYF1SZNObTeXKkGulLsToUS41WQ2gn1ogWe7nTLUXZmjcm+Zqlvb4spZtSXsg3bqFcDfYy/B6mIX77UDrL2ZQ+xQlKyhLCiRRuYr3mVvLD6LtWXrC5mtcOIhocTo9gTKEaPWqwTy/gARiTUpv85+8PzbD6HuWn8kCK0qS9ijHvcmQObZ7HAnT5RQsKUdxAuOCzCWt0bkK1M8zC66SVsEOk841iXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39850400004)(346002)(376002)(396003)(136003)(316002)(86362001)(66946007)(54906003)(4326008)(956004)(55236004)(66556008)(66476007)(508600001)(36756003)(8676002)(26005)(2616005)(5660300002)(6506007)(107886003)(6916009)(83380400001)(2906002)(52116002)(1076003)(16526019)(38350700002)(38100700002)(6486002)(8936002)(186003)(9686003)(6512007)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0UB95GG6HoY2u4DMbDfvwMEdt/vRFiP1NeMGqNgZ1F1WnsjzpraTrLeLWK6D?=
 =?us-ascii?Q?ObHtzhvOD5M4fn1kEcot+PpansNcIV7KvgmfXhyWEqeJHSOVlelZxp/MSq0r?=
 =?us-ascii?Q?a0diTPbKcdx/Vt2NdwzXP+muYSeraYaVN3/NWbuYr9U1fxCaoLCM12ZVkZqH?=
 =?us-ascii?Q?0Z3ejvJhWZcqD5clBRrLEh4ICFWb9ujA1vG+Q4T3vHg3iG0ncYmBZZJNt995?=
 =?us-ascii?Q?LOMJejWCpaRm40WB5AesbPwR9RXvWfQTGaenSNifwsIE+v4Qhp+xVA4g0roC?=
 =?us-ascii?Q?XH9ZeFJe1a2A47YXscHQFU07g4aCzzO/waEquPmxfTDxWaauKPmDc5ZxYmTb?=
 =?us-ascii?Q?Aq9Lhxc3njt260EnpTP/aof7TKwfXdwTcej+VA38bv4YcZjupqBPXasAyGnJ?=
 =?us-ascii?Q?uKKRECZhX96LyCcUTo7asK84bWGHmQZ+KBcLBysTH2+xJATqabuixnhe91Ia?=
 =?us-ascii?Q?Celvk9ZBInxAJhLC8LTYKbSCia3aZOiN9Z4M2hyL/o3QAUQMg4GY5Yy/Vf0/?=
 =?us-ascii?Q?gZnYKREVkqxnJU9u6t0k47KPvc0Ayp8NL1KvvrvckeNyXmsX7H5JQQR9IIXg?=
 =?us-ascii?Q?v/4yUjQklidSvABjIJKvsr+dZVLI2kAa886n3D8PQId9rlg8ss8hON9wDxma?=
 =?us-ascii?Q?7ieG372Y9gq97lKQLYZJFrL7XLSBFOLzV16fzAeq14LLSoDz1J6LfzY4g7qh?=
 =?us-ascii?Q?UpPd7YGbOgjFfdp0F1ogGowFePFGDSw4Ugp0BO5wwR2UaJv5Nfe45NWETmxP?=
 =?us-ascii?Q?z6In7u1APae5DXvE0ylhGCk5OI8cgngKVVbY+yh2c56SNfBQOu4ZsuTQmEsh?=
 =?us-ascii?Q?FzQV9obZvKgwe0ZsSdcaT2i1MKj2W9UInZlwa9ef/hXlLHk2pn+ZrKgDU+EN?=
 =?us-ascii?Q?4bsmTJtGNbj6lro2DU0ydm6oUrdAawRubc5GBXSaXsO4WFSwRedfLTDxBNfx?=
 =?us-ascii?Q?CBPaRErFFOO9OICVsYpsoAd8Vr2ifXg+lof8TUDjQVFLv//YjruxPzw+vury?=
 =?us-ascii?Q?4ehhaxjCKDlpXZuFIaNvsdBaxC+0BVC12VIRXt8boldti8jNMHQp0IOWq5D8?=
 =?us-ascii?Q?KYb+yYxrf+ZQ1yMxdp7U3zs+l4CgU2RuKFrmFZB4vN7tUwr2ZfFQ0oO//g1z?=
 =?us-ascii?Q?MXu283SGwaNdaXlInUGxsBJtrzAEnJf44wt7T3FqZ+EuTJnn+5vvjnTbli0Y?=
 =?us-ascii?Q?J6Lj0qmyol+CkWoKh/whk4bJ8i2z561eU+sWWwFUOgyP6kGfUt9Gl9vAC2GA?=
 =?us-ascii?Q?AFP7vQoYHcJLQ9UsMh3NARSWYCZK87ZeROunzPl5YAfGMXqNfj8lMMUA+h1t?=
 =?us-ascii?Q?jx4nhyyjDRKDmNX4cut5w6FE?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab3cf71-83f3-4408-9895-08d931a9f2bc
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:07:04.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XES12zlGUqnxdq81P1nYHumuXUxUVGCjU3JfdcfNH3WoGJWXCYtGcFCu3AwUHR0XRvgBn/IIBXK4JD3Y5ttM/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1014
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/wrs/wrs_ap.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_ap.h

diff --git a/drivers/net/wireless/celeno/cl8k/wrs/wrs_ap.h b/drivers/net/wi=
reless/celeno/cl8k/wrs/wrs_ap.h
new file mode 100644
index 000000000000..a01e9b46bf68
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/wrs/wrs_ap.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_WRS_AP_H
+#define CL_WRS_AP_H
+
+#include "wrs/wrs_db.h"
+#include "hw.h"
+
+void cl_wrs_ap_capab_set(struct cl_hw *cl_hw);
+void cl_wrs_ap_capab_modify_bw(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_=
db, u8 max_bw);
+
+#endif /* CL_WRS_AP_H */
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

