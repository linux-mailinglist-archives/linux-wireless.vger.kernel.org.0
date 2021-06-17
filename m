Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007CD3AB86B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhFQQIB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:01 -0400
Received: from mail-vi1eur05on2081.outbound.protection.outlook.com ([40.107.21.81]:6112
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231732AbhFQQHY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8M/6bDGoPfi+SrJoOwg5RAnBfh6r8e+FBbGfXPfhBdHmYvMHoegE/XtCGduOwszHe4hNnpXmQpo+SICwQEbzOTNd93ahyuLOG1SMpbqnvmxbOR8QwXJ1CXEND/dRP3zTi8nYX3iyM3oWjFVaHe0UNdEnx63+ox4Ai/1pcgDM2mcOoc4sU/Sy3jhUIyqnxl6DHpJ8QlP5r4HZQRrNdtvpPhEXNohPDRbU0VlCnIer97EyJoT0oBTdENwqf1l5C9umzxesxXHcYrvRb0bBf87i5X922VJ9MwggNDeksNFF1L8YnGwsyXjyLWcEpqziZDWgNBToW/zjgwEWPgAxXvSdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DXTc4eVLmVlI0kHyb3bZ9dOEVHU+ZH02lF7iPmROpM=;
 b=V6yD1iHQDrKyCyctJwSPUrR8Kno4swzi7XZoh6a4YyT/WHciffd/GWaFPOBF5vjDr4aLirm/M42aqfZyey0Qm51N0WKiWrf9JNaocaiapPDWe6zz+UAJgSSPt40TmzpBnjWyooCVS9QKpnkfhwHpz5Jw/J39TNgHxD337N2w1H8SmgiVFYPzXymv5xW+neBH1wxjAKiBVytaOCHRm3aqR3j/TVwD1awNX+n1w+VIr0gLMqFFnML3kTGkP/6go0rpigKL5z/LuoBUhugVChJu9OK8RuoUplZ+M+5aCu/gWAKGTsZPAsrVDVQdCm7wKZbP5CvzWVlZ22Gr+HXY1nBK2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DXTc4eVLmVlI0kHyb3bZ9dOEVHU+ZH02lF7iPmROpM=;
 b=XXcXOw/oFKxMvGMvo9fB36DM4sL0E0QHSdFbeqBJTrb9HAO9w4c/hkzdrDuqBp7/7uqe7bvpW6yT/OQugRgeXYwIg5lTK3wW1OeWwiIr/Rr0XF8rxmBBR8yJj4Ge5876iqEvjkLJQswmlOqmTglY+yJ6aRfHOHQmFftZ7QL2CI4=
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
Subject: [RFC v1 082/256] cl8k: add ext/vlan_dscp.h
Date:   Thu, 17 Jun 2021 15:59:29 +0000
Message-Id: <20210617160223.160998-83-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d43aaf9-8671-4007-82df-08d931a9871e
X-MS-TrafficTypeDiagnostic: AM9P192MB0871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0871710F12521077C5DAED71F60E9@AM9P192MB0871.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sceTz/8RR0Q5QQ832KuL2r3nn2lZ0wHP9EzoGWDwpFYQmCnvXZUz5NfxSDj5LW3CJ9AfHtS59ttUnM3Kk4nn9BwiWyjmEKhesPsNQcVQ7doGCR9IduMyDmKDrp6Z+/vh8J/2NDg8Eru0cidh/shLtCHyjWm8OWAC0AQLT5soRn/Kc/t6Qj2Td5Q/pSSezvwrtyQn4eZTvVXB+RNq10uAYrMGKoF7SFZX3mtp5S99JQ7UD//nqjQVZK+EDicjjqrJXR064iWkbbI78mkKorjeVmcRy1Qo4vkred2CLe1RXOCC8J0cvYgtKaCedyK87Dh0IYlCDsWZq61lIJurKBltEqOfSq6ECTRO1DZNKtQMis+JJDUsw/JBGiKcGo9IS+YUlxJVHoBF0Ob1NzGiaWEouwP6C4CFKJfbXnHDFo4zMK25OhXDGF9SB/1Hbtg4N4xfXvjwOyKwq97P4WpkaHNEAE35Yk8QVXt7IDGOiO2Fg0qYvEcrhWc+sok75O2WEt7M4TbD+XI62lelITY0mFsfsjSCivawESaI/LbSZv9WRBr+FQNLOY4G30Zu7ueqVjoZShpeeYmaBnL7Rg9J4Sqv+ZJ0lpYcvIoDoTyltIIg9Sj1277N+tqkv3azXbnV40QM4iM6hoYTyLaK7YwAZxSeMN6hLiRKzcPa7rZ9rn8D6qtVvvxJNv9FW5i6JtHlHbkV4fZ6IdeRVT7K8E4y12lCaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(396003)(39840400004)(16526019)(66946007)(478600001)(26005)(66476007)(6486002)(186003)(66556008)(9686003)(316002)(86362001)(6506007)(6666004)(6512007)(55236004)(38350700002)(1076003)(38100700002)(4326008)(8676002)(83380400001)(5660300002)(52116002)(2616005)(2906002)(6916009)(956004)(8936002)(107886003)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rlfCUHNtex1Kpq0AZLS6X0mV3vyfuquhTMvuQRuLlQhtWO2YKapNqUHDvmkv?=
 =?us-ascii?Q?DJJ/Yaipk6xrXFh9PHa2bN/+Ja50UIh9N0bSML+FBLhzn7amvWLFcA0o8q7L?=
 =?us-ascii?Q?USmvMnGnp65V1Ka21b6xwRNmDe9hNQAOr0xUZxUcqMJLAk6hTC0aaRhoJpYu?=
 =?us-ascii?Q?5KCv2/DBcYrY19K+Vf8I6JDIry6PGzKqk6ftGlgMiO3Lr2AO99/Nhu4yDFaP?=
 =?us-ascii?Q?6qQg+hMloFUdXNpmEj4iSrjK2ikbjCObayycU+49kKMLWZujXaZWrQ+uFWqA?=
 =?us-ascii?Q?+KLiTssiLYfhelOjiDQa9s2+5i0haWbQIII72SLqp4vbjmqf4KdxSjmBiBde?=
 =?us-ascii?Q?RR/tZXJf44eSujV0jYKq0zBnLbLRQCCtLZaHN5e93HHa5Jci+TFgy9y+mBum?=
 =?us-ascii?Q?Vkzv60EI7z6B/wVmPG2ls8GUNtohJrIpIlmvwvY4Oj/clJAQhmxrvKP8BoHh?=
 =?us-ascii?Q?tqzGr77DJkTdY62KBp1Z11JjM+1ej+SfftY7wVUitxtsW6hELx5gisr4CaBq?=
 =?us-ascii?Q?ro4botCotAwq9iB0TuzzfIAJB06pm7sU/See3IdQ2xWkiWejCojJUJa3GQRY?=
 =?us-ascii?Q?ZFyrg3FqmIuwRNPKOqNxyTkq2Sbr2xK00khVWvu19xdQ4ChnfvF8E+KlzEb9?=
 =?us-ascii?Q?cfZ+5S+vCgOBNnLJMI6VoWRE4dfrTQBkHa6pAgi5XDsqWDqLHXoqo6JwgbX3?=
 =?us-ascii?Q?ycr1jgUPMSLDzAR+K/8de0GMQsV0wYqr494gomgohYHqBAoJ6kcDHIjJ9Kce?=
 =?us-ascii?Q?e6voauQIbzRsU3ITeoNDEurGzAHZd7kcWzV0LboFZ4EhOe74ZjPqgnrN6EmC?=
 =?us-ascii?Q?TgYDrlEmGx1bjR/48hFiWkdBh1iIJ1XTbkVJmHwaxGGNVII8rrH09l62j6Aj?=
 =?us-ascii?Q?ACAm2tXDMsZh/f94c+iAkqlhclCodHkYEPo6Os5Xzg7M2a83Rh/hfF2dgujv?=
 =?us-ascii?Q?9r4rCf+DZtKgwjxCmJzDUxzNb8anPOG9rzGRhiLOYGp/jeSsE+I6rTjBzgC/?=
 =?us-ascii?Q?OSCv4x8HlbTst0wK9l4AEEegp4Ij5F0H3QGqB1ZeFED4FdmFhumGmZ4kBDUJ?=
 =?us-ascii?Q?hp3OOkCJxjvhcsQXXk3FUp32Nyqf83yED2Ry6GlOEG8rkeIWvDvi0sBWasA9?=
 =?us-ascii?Q?iCbLtFmCeCpnLpKZ1J+vc4Bv0xDfV420fS+tXOrfISjsuHePNuiSggLlwBn3?=
 =?us-ascii?Q?UUcRHH1GypEiFiEyeWj1gvtNuNVBc74CFDzHKHm+gT179xnCKa17sRzUoDK4?=
 =?us-ascii?Q?2Hi/C48xKqF6157mfLFzt+hZ6yzNVUjiOKKhZOAoQge/y/Wqo19dk7dDxiio?=
 =?us-ascii?Q?D3xEOeaQU8BefI/UUD8XHz1x?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d43aaf9-8671-4007-82df-08d931a9871e
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:03.7177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5x2ogV08Q+KZYqnb6CH1d7s9AiiRSsL7sNrnyuS4i9jN4/IIY2Pd3/qYXjPy6J5lskvbcyXApjevto1iyQKDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0871
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/ext/vlan_dscp.h  | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/ext/vlan_dscp.h

diff --git a/drivers/net/wireless/celeno/cl8k/ext/vlan_dscp.h b/drivers/net=
/wireless/celeno/cl8k/ext/vlan_dscp.h
new file mode 100644
index 000000000000..d483aad2e724
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/ext/vlan_dscp.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_VLAN_DSCP_H
+#define CL_VLAN_DSCP_H
+
+#include <linux/ip.h>
+
+/* Length of packet field */
+#define LENGTH_VLAN_HDR 4
+
+/* Some VLAN parameters */
+#define ETH_VLAN    0x8100
+#define VID_MASK    0x0FFF
+#define PBIT_OFFSET 13
+
+/* Version field value of IP header */
+#define IP_V_IPV4 0x40
+#define IP_V_IPV6 0x60
+
+#define CL_UP_BY_L3 3
+#define CL_UP_BY_L2 2
+
+struct cl_hw;
+struct cl_vif;
+
+void cl_vlan_dscp_init(struct cl_hw *cl_hw);
+bool cl_vlan_dscp_is_enabled(struct cl_hw *cl_hw,
+                            struct cl_vif *cl_vif);
+u8 cl_vlan_dscp_check_ether_type(struct cl_hw *cl_hw,
+                                struct sk_buff *skb,
+                                u8 ap_idx);
+int cl_vlan_dscp_cli(struct cl_hw *cl_hw,
+                    struct cl_vif *cl_vif,
+                    char *data);
+
+#endif /* CL_VLAN_DSCP_H */
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

