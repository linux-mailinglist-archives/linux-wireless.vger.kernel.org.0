Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C46B3AB890
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhFQQI6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:58 -0400
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:40639
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231920AbhFQQIB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/2UGZSbDAN2IvHyeygG5FsmKyZ39IYmzlaYW9FzGcMeNz0VANL5YTiE4wCmnz/wrDdMRk44nxVvv9mTyZdvs2O+jd01FCUb/8n1eiZuBD3SCThguuwjDrreQ2lDTyVwHbAlt8094ePc9IDm6KAn9W8FX3bsJ7gyc5FPJumQ+E2gix7by4MQpxKlO3mgSQ48sx58Fzg7D1XEVJ4KFNyA3fzwYaBV26n+ux9SEM4GYEUdqfTYLpd9xUXDBwF87OsAueEy3wQ1VZn+1CJqkabCP1MChELSWQjj2RJQ1hDPnzIKbdSMKRan/GiVVQQkSO44gd31UkUHL6aTDvE/IqURjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pBL1G3SoBkqijcB5Cgg1KaAfMOUUC8AbZyYDq6UkbI=;
 b=Gyb+trA2LFCdd1mk1A+b4/YjG9cswaSTb2xaNRXiG1M4qHQheyoKShjzKT5MmegigTf6MBHNwiEPysHoe4e/+CqQr6cI7QClDXHQehEFPKHxxs56D3JWwdvmx5IYImUCPQ7Hrgi/A/v1FiyxX31VrewuBUzdRXMByEukCps0OdM8KoRL6sDn9TH6mN/HfUb7EHK8Hrj+3iRSF08l1oSyXCROiIh7fsb3aVmByEnlcaj+eznIfm3ZliHqT1kDqk2dYDktCChcTGaMTlIbw+/0i3YNd3DGEGnlc4XhM8dwjhs1NElabLVnSNIki4TtFJBL8F7U/h6t6ADA//vYBYu0jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pBL1G3SoBkqijcB5Cgg1KaAfMOUUC8AbZyYDq6UkbI=;
 b=M0X4R4TLSOzUbTRVCcpe0XefJriH+62kBkgxjmGbmkSwZruwn6BgTTimLGhmTVcZ2kfJZusDgHrx9OjFe1S/kG8f88dwqzBdwYHoQ9qLSTPqW3OcHGDUvXxfBIZU6UqX5qCAKft6kPcwT/4iAxxJvNl2ocql2Ra2vfFPYAUtStM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1268.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:04:23 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:23 +0000
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
Subject: [RFC v1 074/256] cl8k: add enhanced_tim.h
Date:   Thu, 17 Jun 2021 15:59:21 +0000
Message-Id: <20210617160223.160998-75-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0917db54-fd6a-4252-7af7-08d931a98232
X-MS-TrafficTypeDiagnostic: AM9P192MB1268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB126809200265113701C6CFEBF60E9@AM9P192MB1268.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ky8tzbru4EF334Y8oCp6VSH4l/lMSqVZgNhpYT6H1aYGThi1gAXsfCCIfK6yDjWeG6QAn7RGPvuspaw7jPijIFlEo8SdtUbhu3DI4SkGk5mvhFQmdzTG3sqOs/4sf+MbLzvzJFB18ZkuOREJoJEv6EvvRUi2Ay0iiDLASMu7FBdYSuzjWxL6KYT+hLBpJHBJmA6tMQmbSkNBaG9FwrF7rNTNkNEMC9ZK+h0ogZxI0/txoJT9R9DdmQ2ledvvNXr7wimegy1wXeoWvh7qcfeLMm50BPpRVxd202h0Ynj+uRBeO3SzVjRs4+M9SOR3Z06mfpSgguhY9uHK7tjnnJ4T19CLf6+FG+H9UUqk0CfvVMhrxDlyAWAUpBr3de4sKqBD2m8XWCy64cr5BrHTCzvw+xm64nLnq/pD4Sk0o/2hnCyUTkFZeW9/Z7MBvcFURlHnTMLNTB/uNoE7zh3znl0kz7gld/94ixZ86OOIq9FCfObdWkHQ+p9q7CLcKOutGbFNYip0/AyxWIVuZ3C6F0lqWGgJ+MMdLFqAj2Qb3Lzpza7D2yjT3VeYFXwMhBDk2qijBI71xy9UfVHd90hskv1hrMJhzynTB9MAslb5Z5S3rML+PKIuoJPXj1BZrJVZh7GtUNz5VIuG2uqCdxz5MukdmHPYs4DiGsQm/Vlovl5cgs26wqgW+shO5m/YX6fQfuw3NrKqHSRYuREqs8RcebRKEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(39850400004)(136003)(376002)(6486002)(956004)(54906003)(4326008)(2616005)(186003)(38100700002)(16526019)(8676002)(5660300002)(38350700002)(8936002)(26005)(2906002)(6512007)(9686003)(52116002)(83380400001)(6916009)(66946007)(66556008)(66476007)(86362001)(55236004)(6666004)(6506007)(1076003)(107886003)(508600001)(316002)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fPkAkSfajz4ySNkGkz5RgzQ6z8f5JbwBBpBPSpyJoRpeOt7Bw6BjmSaB27bq?=
 =?us-ascii?Q?KThzx1VR89nKkpuRi+bzX+gbtCGoI19jLB5II++NguXbr/QopZxguNZ22pzo?=
 =?us-ascii?Q?4oirnX/EbjzuoLSse08S9VjRopLxBcYuxLe8GZE+UyuxYjT8FAmI7eE6zF3A?=
 =?us-ascii?Q?Sy9L9P+FHg2FSgLthYgoQ7d7xVCu33vBleQnVcWg55matXtM+oUpLsPXAZUa?=
 =?us-ascii?Q?dMUtFjyMHgtYPtu7k/E8nEyRT+PLDQmrxjAe/zTUJGaLXnzAT3wcOA0BJqLg?=
 =?us-ascii?Q?dU+WmLFu+igsS/XTM2cJ5WPpbCgCfH9+oQBpPqfIVDif6gSV3EVVYk0kWS+s?=
 =?us-ascii?Q?Aw0G9ZSIXS3qSc5gljbApfFG/TnR/3oDJWgLBXwHvlJuYbRes+1q+Smi+ruK?=
 =?us-ascii?Q?2UTmQs476bBYocA599ctpbpGx6nRPb6F7iLe++aMVyRvYvLADwIyD0Q66Rjc?=
 =?us-ascii?Q?bKHX5Mk1Z9te4eu8skhxgK9dR8ejCl539AEK/TQ7CDizs83rZZMMXDTdYOgz?=
 =?us-ascii?Q?e6sVrcGwrLSmWFv4gEc6wUwwa1/qYF+lv9cemS/PhEuO++3MvqnxdefS7Njz?=
 =?us-ascii?Q?MKGNt3fc58RBBE6wPCiJuJbDKmUbYbMQq3G0ZaDupb0t0chF/1XJSjZ1q0r1?=
 =?us-ascii?Q?GKnQMJN8yCser2pteVgftUhKviWTiYyAN+K5WhZjIUWLRYosMl0p7mbLcwHT?=
 =?us-ascii?Q?Br895CtoQSVxWeM/CkZrmnIQht6VVc7dyyutMyPe7kxPrHmL8C8Gnv1C0Frk?=
 =?us-ascii?Q?8H3sGkGRDmrVI5OugcHz/OfFJ9DUVTxarnAoER7WUB4kes+CC4z19TefZCCC?=
 =?us-ascii?Q?S8j3wK0xVtG1bnsvnRYdrwo+bOpq/jyucuF7EqNE3ewAsLBHrTznY2XhJKal?=
 =?us-ascii?Q?ezAgkDVOllTtbYTjxENesNoqas2MyyagV+aiRFgBrtSarrJssDsroFw9H85H?=
 =?us-ascii?Q?jwVtuA2TGQ7cdAfCFLUSyRFbhF8/kA+jy8ZBN1frKYd38OO/Ao25mev65BSy?=
 =?us-ascii?Q?L3ivDWWU5oGjqU2iiCmoi82ed9tGbQ2JBA98D+KxaNmowD2QJ2LC7zYGN8OO?=
 =?us-ascii?Q?zxy4hDJOgZeMMNhoufwiGfZv518TjwoMofRzE9vHwbUC5XZNwS0oPP/9xq8n?=
 =?us-ascii?Q?7F7Hh0QSEt1LtTLFfaC1cefZZB8DRoibUzDW3Qdj9nZNtbZQJiLPdda/SFoY?=
 =?us-ascii?Q?6f/LyX9D7Xf9/zieNb0ele/FCW72pIXuEiy0h+2MVBU96NnnUAeRY7kGyR11?=
 =?us-ascii?Q?jeI+6uLzC9kWT2ZhfaIm8GFd+pa5wfKAkjgPOz1fXOMIH3dwvxaKVlYag/Y0?=
 =?us-ascii?Q?josZ3FE9v9kLIe3sq2+PDN5A?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0917db54-fd6a-4252-7af7-08d931a98232
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:55.4530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbZ81hHA8G1oReRcyH1IaMVpC/+RsEHSho4OfSftA6rYaIIJhlFnUcF8VBcACZ9Pn8btwLTFbIFKTfUHL8rAUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1268
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/enhanced_tim.h   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/enhanced_tim.h

diff --git a/drivers/net/wireless/celeno/cl8k/enhanced_tim.h b/drivers/net/=
wireless/celeno/cl8k/enhanced_tim.h
new file mode 100644
index 000000000000..0d7b05bd28fe
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/enhanced_tim.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_ENHANCED_TIM_H
+#define CL_ENHANCED_TIM_H
+
+#include "hw.h"
+#include "sta.h"
+
+void cl_enhanced_tim_reset(struct cl_hw *cl_hw);
+void cl_enhanced_tim_clear_tx_agg(struct cl_hw *cl_hw, u32 ipc_queue_idx,
+                                 u8 ac, struct cl_sta *cl_sta, u8 tid);
+void cl_enhanced_tim_clear_tx_single(struct cl_hw *cl_hw, u32 ipc_queue_id=
x, u8 ac,
+                                    bool no_ps_buffer, struct cl_sta *cl_s=
ta, u8 tid);
+void cl_enhanced_tim_set_tx_agg(struct cl_hw *cl_hw, u32 ipc_queue_idx, u8=
 ac,
+                               bool no_ps_buffer, struct cl_sta *cl_sta, u=
8 tid);
+void cl_enhanced_tim_set_tx_single(struct cl_hw *cl_hw, u32 ipc_queue_idx,=
 u8 ac,
+                                  bool no_ps_buffer, struct cl_sta *cl_sta=
, u8 tid);
+void cl_enhanced_tim_clear_rx(struct cl_hw *cl_hw, u8 ac, u8 sta_idx);
+void cl_enhanced_tim_set_rx(struct cl_hw *cl_hw, u8 ac, u8 sta_idx);
+void cl_enhanced_tim_clear_rx_sta(struct cl_hw *cl_hw, u8 sta_idx);
+void cl_enhanced_tim_set_rx_sta(struct cl_hw *cl_hw, u8 sta_idx);
+
+#endif /* CL_ENHANCED_TIM_H */
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

