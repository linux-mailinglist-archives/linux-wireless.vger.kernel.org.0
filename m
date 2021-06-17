Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B12F3AB81D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhFQQFB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:01 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:38880
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233537AbhFQQE7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:04:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HU0huGtMrGmPM8sm8+KphjpdeDK4MTZQ7DZY+TG269MORDsLddFkqsgHffBsJL+/J9FdIOqTEvHg74NWSUPiz3hV9mK+WVkbAcbMHBLwRU4h4ZvHkdQsd2nilYrji8+XMmc69njFvBH9ZXtIXXOKkaWHm2kjCrWPRsxDAIY7g0wt1i5gKe+TeXn8RmKOHEaLeAikfKt+MvUMOvFWf25Hr2LFfZAnkmABK1in6mH8nGiR8KO3GUd4ofPJHFVzoIXFnlmuXn9eNK1MafX6CFzWnwXfhznPMc54UIwTEm5i1ZPCH1QUykCj2ggI5C+a4Gyu9J8J71DWh1BSgTAQbW6Mog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDQ2L9z7qIdZbAS04j39x7a1KbxVhqqU1kGuAEngbvM=;
 b=gHjUwRKar4cccc2ISjoNHihoTN6P6uxbK+4Ze8pdryHbl57yj/a0WbX19Yeha78uZzGCHWOOmdF3WWcsUSd2SS86vMZSXhCS+LfhSWoDGH1/+0D7YWATJerrN5RGEm0xy310ulk/aod9qYrPUjE1xB6CoJImzya/a3NDihv1QaIEwTqx71j0cN4rMvQD8J2kJYfQ2d+/pMNrQ1nfe23PJKIOD9afEK+QqegbZJ1xlOChbOFN8HyZuBAqe0eF6eenEqivkaO00hRgGGtFzt8YY8N9tzDoMjvEAFhl7Fd7ymRl+OeGTZBJcvUm3M4Dm1JwEbFddmMliHESQxtBthkN/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDQ2L9z7qIdZbAS04j39x7a1KbxVhqqU1kGuAEngbvM=;
 b=CH2/mn8r0yeMzm16FoOevmPnG+Gmsmhce7SqQ/DAM6OBtgfIPJXT2eRSovUnTBlYfjYNetq5b4NcyaZfsc8CNf7F21d4pAIgALwyCCZP9XihqPb31U3eImGPYSWrGTMdoFqd8++IORLxC+7jFvzO8T2Z+7H61B+mRmuWkdKsvv0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0499.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:02:47 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:02:47 +0000
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
Subject: [RFC v1 012/256] cl8k: add ate.h
Date:   Thu, 17 Jun 2021 15:58:19 +0000
Message-Id: <20210617160223.160998-13-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7323d57-4936-414f-c825-08d931a959cc
X-MS-TrafficTypeDiagnostic: AM0P192MB0499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0499F24FB6239376EF926E5DF60E9@AM0P192MB0499.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7XVuqFLW8xlJXXARRBUVuTBNIX28dpNd+2+l//h5K7HnvPj4x+kl4IkrYArKfsFEYIOxzjd7bi9+qN0CV76AzLwnCfiOSG94GJC4Es2dRMrRrKbppfY1uhhuNs12Dply1Af4FSNbAT0BqCzDFEvtD1foNntBlzIhBQppHrDXdSv6xY7+kg2r6oeLTKCNRHBzrSg3rdZwI0MgpXTXdyz/kBr1bVtfhFAufku4p0tIu1qZyRZEEzquPmAqdgn79stgLF89Q30yUG1FPkYrp7sYgg/pNI4pLvqUPkYRKczeXlkZ2a8KYcY2nMfN2YBMeWrPWOYGH7N3wc0jEtnyqbVFvmGKrhcMS2Q3yd951fnM5HlaBAcV29NVykgg3I/4o5949DUubXpccVaFAtwK44pOEy+1PaZShZzCvr/jenXwvVRSsVrOtEg5qd0VlJKql6ReGvFD+uY/A/yh5SXjoiU8m+qgPvSORkTiBRoArkNEIKvhORSjkUfjfjgtAH/1l/zf2tEBojSoIRFy2y0HaZmjbcZ1IAKbHcmAmYl3IXH6js3EAHpwRm3t4fkmgiMSbVn0Efao4+CGGhmUyOxNU3I1Z9uP6upEBG1uQD+z8dSEL1OavVmD9BjxEhxOfEjcCpmVi49toIjaVRW9rvYISI1RUB95cLzxS91O+yzDOXxRlpxmHBlkTMjuMhFUXrVt9pQVaikdSVZKyHFbsrUz4r2cwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(86362001)(107886003)(66556008)(52116002)(83380400001)(55236004)(36756003)(4326008)(186003)(16526019)(956004)(316002)(6486002)(8676002)(54906003)(38100700002)(38350700002)(66476007)(6506007)(2906002)(26005)(9686003)(6512007)(66946007)(2616005)(5660300002)(478600001)(1076003)(6666004)(8936002)(6916009)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JdtyG8bRE6j8Vlm5fqgt1xKR3o1oqLOSsk8cqEhnbhmQc9a3q1ol3ANUsXap?=
 =?us-ascii?Q?hlHCwCPkSl6NOlY8NlhAMk+ov3sm+r4c33/cko55a5//2dVJdcCe0/il5lNt?=
 =?us-ascii?Q?rren46ZlGUhZsleYlD3o7Zed3wHx23WQqM8jMmeyEu8Hb/p8Oy9EwdPkIr6n?=
 =?us-ascii?Q?kWuNHvHdBxHfP3iNPqpr8hM/1j/B01UatRw2I//y7NOo3fB20qM5foNRXo9F?=
 =?us-ascii?Q?bFujJ9Tv0Aw+8aMyl/pV7GgdYlOxZf4+6/bVk7QW/BOJzNgbh5BDcg7ChYA8?=
 =?us-ascii?Q?P6SD7aoCuDXck3nD13FriTr7nJPw9+XA2T58+OE0Kfz+yU8WGHHqliYdBY6m?=
 =?us-ascii?Q?R1DLs/Eid+E4YpKVx6IeaAZ93H8aRqKBR2GUKHtnvtD0DqHMc+pZ1/sEKsNE?=
 =?us-ascii?Q?o10HaDEuJ9xv6ZKPQKIQuWNQ6qLnzKOK5zOLfwmgi75g8EwenYSapgpViQ5z?=
 =?us-ascii?Q?nwfKcCK6poMi4sVoNq6EjMpnILoCppicUfw6cmejeAYco+HwWuK/0I6GmhhS?=
 =?us-ascii?Q?AQhWwUOlzJ72b8upB5ran/eoUTROIxFvPE3L1SF/NzXWWI/9d7JlDJDUgi0z?=
 =?us-ascii?Q?/c5Z1Wf6L/1klGVPp7XhbiIwoft5zKMB6fqj7wc5qL2Pn1kBGEXJEB0hnBlV?=
 =?us-ascii?Q?2Ql8Kgrs/ldiFZHBtPN2ez9Jqy/AY23CssvJ2F01DCUK5O1ifPje0rPGe/1q?=
 =?us-ascii?Q?/rkj3TNfjJHLlU6ciwdpOz4nMtSq8Ri9g9iQ40i2VMoWLhkOuu5gBE3GQSzf?=
 =?us-ascii?Q?KeXR9mO4cg5oJIqG8zqvVIb5zDFfa0zkHslr805TEIjBQ9DWMdfu20eX8R3q?=
 =?us-ascii?Q?h95lmOu/iq8LXF8l9gC2ShZ86d2F/0T24q9ohOdwAxi7oH2yc4eX7D+xCYGN?=
 =?us-ascii?Q?9gASmen5Wl1m+Wb9AXrWFvgbNCz+XhQw34wbA8AQ+C4QSO34axN7m2uic0YQ?=
 =?us-ascii?Q?nlaMdZJOAnPv7OE9mjoQ8CORRpcy34rDkkOLaLYLcksJOHrWIxpT5+hxdKHH?=
 =?us-ascii?Q?T17S3bYvvcwqmtMDbG/RDNfSJtQdpASB2TyrU81gviYvhZaPQerDCqefbT0p?=
 =?us-ascii?Q?iLxYdpMlEEnU0xoYzOSWCKG3+Dobc/SqQULV7JoGDhBwlQRa9fE/753LyXil?=
 =?us-ascii?Q?urtiIG/y6Zo93BZYU7HFEY7mr+Xd/6BnBngm2vmvqieHG9xBqZqt+Rd4JvAp?=
 =?us-ascii?Q?AGCPQalZ4QkMNCWy1PYbW3Wb4rY5S4agPKX37w6GyFZCpG1dGI/Ra/+74sor?=
 =?us-ascii?Q?h2DxT+UQanhE11J7TkfXoTodh9HD5/SS6HD9mXvq7tddSlZdMSX2n3zteaxU?=
 =?us-ascii?Q?B13PJJ99BtBnAGlAmsCx3SdV?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7323d57-4936-414f-c825-08d931a959cc
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:02:47.6757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beRdrKtJN863qHBrQoFLcQQ/36RZqlNnTX9ElBFFbnmfV0pSy5bmEwp7Pp5iifEC3JtfLT2S8CM9JywVh91UnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0499
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/ate.h | 90 ++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/ate.h

diff --git a/drivers/net/wireless/celeno/cl8k/ate.h b/drivers/net/wireless/=
celeno/cl8k/ate.h
new file mode 100644
index 000000000000..ae9ea58b1a01
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/ate.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_ATE_H
+#define CL_ATE_H
+
+#include "hw.h"
+
+/**
+ * DOC: ATE (=3DAutomatic Test Equipment)
+ *
+ * Routines, that may be helpful in pre/post production stages to verify
+ * validity of the chip behavior.
+ */
+
+int cl_ate_reset(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len);
+int cl_ate_mode(struct wiphy *wiphy, struct wireless_dev *wdev,
+               const void *data, int data_len);
+int cl_ate_bw(struct wiphy *wiphy, struct wireless_dev *wdev,
+             const void *data, int data_len);
+int cl_ate_mcs(struct wiphy *wiphy, struct wireless_dev *wdev,
+              const void *data, int data_len);
+int cl_ate_nss(struct wiphy *wiphy, struct wireless_dev *wdev,
+              const void *data, int data_len);
+int cl_ate_gi(struct wiphy *wiphy, struct wireless_dev *wdev,
+             const void *data, int data_len);
+int cl_ate_ltf(struct wiphy *wiphy, struct wireless_dev *wdev,
+              const void *data, int data_len);
+int cl_ate_ldpc(struct wiphy *wiphy, struct wireless_dev *wdev,
+               const void *data, int data_len);
+int cl_ate_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
+                  const void *data, int data_len);
+int cl_ate_ant(struct wiphy *wiphy, struct wireless_dev *wdev,
+              const void *data, int data_len);
+int cl_ate_multi_ant(struct wiphy *wiphy, struct wireless_dev *wdev,
+                    const void *data, int data_len);
+int cl_ate_packet_len(struct wiphy *wiphy, struct wireless_dev *wdev,
+                     const void *data, int data_len);
+int cl_ate_vector(struct wiphy *wiphy, struct wireless_dev *wdev,
+                 const void *data, int data_len);
+int cl_ate_vector_reset(struct wiphy *wiphy, struct wireless_dev *wdev,
+                       const void *data, int data_len);
+int cl_ate_freq_offset(struct wiphy *wiphy, struct wireless_dev *wdev,
+                      const void *data, int data_len);
+int cl_ate_stat(struct wiphy *wiphy, struct wireless_dev *wdev,
+               const void *data, int data_len);
+int cl_ate_stat_reset(struct wiphy *wiphy, struct wireless_dev *wdev,
+                     const void *data, int data_len);
+int cl_ate_power(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len);
+int cl_ate_power_offset(struct wiphy *wiphy, struct wireless_dev *wdev,
+                       const void *data, int data_len);
+int cl_ate_tx_start(struct wiphy *wiphy, struct wireless_dev *wdev,
+                   const void *data, int data_len);
+int cl_ate_tx_continuous(struct wiphy *wiphy, struct wireless_dev *wdev,
+                        const void *data, int data_len);
+int cl_ate_stop(struct wiphy *wiphy, struct wireless_dev *wdev,
+               const void *data, int data_len);
+int cl_ate_help(struct wiphy *wiphy, struct wireless_dev *wdev,
+               const void *data, int data_len);
+
+enum cl_ate_cmd {
+       CL_ATE_RESET,
+       CL_ATE_MODE,
+       CL_ATE_BW,
+       CL_ATE_MCS,
+       CL_ATE_NSS,
+       CL_ATE_GI,
+       CL_ATE_LTF,
+       CL_ATE_LDPC,
+       CL_ATE_CHANNEL,
+       CL_ATE_ANT,
+       CL_ATE_MULTI_ANT,
+       CL_ATE_PACKET_LEN,
+       CL_ATE_VECTOR_RESET,
+       CL_ATE_VECTOR,
+       CL_ATE_FREQ_OFFSET,
+       CL_ATE_STAT_RESET,
+       CL_ATE_STAT,
+       CL_ATE_POWER,
+       CL_ATE_POWER_OFFSET,
+       CL_ATE_TX_START,
+       CL_ATE_TX_CONTINUOUS,
+       CL_ATE_STOP,
+
+       CL_ATE_MAX
+};
+
+#endif /* CL_ATE_H */
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

