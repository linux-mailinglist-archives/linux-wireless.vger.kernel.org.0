Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D287F3AB921
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhFQQMv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:51 -0400
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:4749
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232021AbhFQQLq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLDUsZxDuEV4VsAM70ke5ei5+pS8j/zEotWCpFCEU96kItZsxsBofbL0Q5TLTPJl405DDXPOb6MPiiJWyITzDfdG2JAl6LgnZeTiWQ372gBjP2svojKy5aeUYtfKL8dF1SkkcybTJVk7NCfk8UnwA+0rR4Y6T8s13tBoefyR2aiX+QZf/VNZVXGPUXcc99jErHCNcRncgPxIu0YLlf1N4frgsJ8f7A1hNE0m48D/mz5NURZx2r1wgfkPa+uOZJYd0P0U1S+H1V3e/VDUQhEUvabFmjwAUcuAJah2PXh2qL25WC9blV5/nU8jg1YHV6oaatLfdDoPzir8CDzo45kJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAIhW1QbSpadtUKKl5gvRdy4IAPvROksRbECBn6jh/Q=;
 b=HM2exP6OxLyWikx6829VZ+c92nVNbS0yn5J//gnZ3nuORtBfOupQICFOykxGjMmuw9EuArlBFY+LvDrkknJsJp2vGAiUFuE7PpwanDAWbcRPwOS4U4x+WRJ6GiglkT2vBuhoVCb+AhMLN7ecMznmJoP1beqoQMMrWWO5UjX1Qk+W73gMouaXr7dvdbycSW3vO1Zf6Lq/Hx43zfFDNXvbKxNbNIDASiXccbR/o0xGmhl4/WHBjYHgoRMw+6QELqhvRmJZ5B0dCbyHTzjqVWnOPQDPk5JHw3jM7aZ/McpifMNT5t95T3xbPPiLzY6UdG0H8GWb8iKtfnUE0bERojpDvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAIhW1QbSpadtUKKl5gvRdy4IAPvROksRbECBn6jh/Q=;
 b=3ntf3NVNB9FjMV/ikqAlXKN28BYxMslZGm2Ylbrw5JMSyPKKv7AX3XHGrC0j4C1wkJdRdrAGB92N5Xyc6zMnmmStXllP3cdEdjRw5NiXaY6bAp6chIC2iLhDp9AQNvovA2HAtNWZtT6rDDv1bBGSO3smip5uqtt6EOOT+506A/4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1187.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:06:32 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:06:32 +0000
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
Subject: [RFC v1 169/256] cl8k: add rsrc_mgmt.h
Date:   Thu, 17 Jun 2021 16:00:56 +0000
Message-Id: <20210617160223.160998-170-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea64cc95-54f4-4080-e109-08d931a9c04f
X-MS-TrafficTypeDiagnostic: AM9P192MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1187118953DA030D022EDEB6F60E9@AM9P192MB1187.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w4EaOVq5vEm2MjTbfgktmVWFN7tpHOMkaXYtpG2F7EyCEnQ4QGYis6qgA8DGBFg7Q50a3Qn01lo72K15Ql+q1j1yOUXspVguUtzqjPT3x1jdAI/D7m4eKedvHmJ8/Et+H2xJPZUDaLBejyUzKz606sY/SeY8x1WyVy5qyYsYAzWIBdogbMadrMopCThlP1KOxQwVpzPYg+YPlU38ga8ncngUtwBuxXRn7635E5ttivCnQW5ooGHsdoJi6fm8SdVnXtk0kgXOJWIztoiIvKkk98aHp+tilR/aMVl9Lz2CODZz/6bkK4o2kW79bGh9GQfN/ZTdrqKQ2iyxcMppOW90fqgoFYy8heC4b6Ls4cBAfus84lTy5agciA5X7McZE8VVnAClqPkEjI06RaQA9bwP6Owzd56mtSVp1xyhSgiIAU7ASmjl0mmzLXsoFkp7sHJCbHoBMeeWPYDN9isk8uBWKgFauWkPWCiuXEvcfP2mntU+1grAuL4uNRKVkZTeM0ot9aMkNJ4ZiM31Ztiu5Cw/hYHeoPuMJQ9dMLU0kFYHLF0f+wjrhQoFg6ffE55iWAPcNUD7Jz4Vzf+SKBTFMLjJ/kTqCowfsZKNImikdEpVjS4m27EcqlR/fRIIKbl+pCtNOjqsi4GJIYk0QeFUsYzjTzSI+iRHwWl87qwiXSbUrwdhzE5lxc+Ws/Hmfu3IavLg2l0dylRv4goKzYRtqVACAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39840400004)(376002)(396003)(136003)(366004)(346002)(6512007)(66946007)(55236004)(66556008)(6506007)(54906003)(8676002)(4326008)(186003)(316002)(66476007)(6486002)(26005)(6916009)(86362001)(36756003)(9686003)(8936002)(6666004)(5660300002)(2616005)(956004)(2906002)(478600001)(52116002)(83380400001)(38350700002)(16526019)(1076003)(38100700002)(107886003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zQwP74SbauWutYy+jnQmr0P2xUx0Eb2AF85NfDcqw098UUp3dGkTcj/eWk1Y?=
 =?us-ascii?Q?SDfZNmsvGx++99LNYWDfI07evmAmJsrCkXaWETaSV2yRSgLDEtu3PIp/ZtiW?=
 =?us-ascii?Q?ot/G6mtDNiDmVSTNLMqvPMqkvIr14vACJ058/Hwe7g7kWHlQUxWH432QoxXa?=
 =?us-ascii?Q?Lvk7ns5Iaxrz545yO+jIvivgvYu4Gn+oXlHAPBBKgvra5SecOPInOGeSARzr?=
 =?us-ascii?Q?RoFLgEzQZVCqmfueeoFmMmMPFSBJqeZ4EZIcy84JV0uRHRq4pjPt9gAHmh5f?=
 =?us-ascii?Q?Wlav/pMXzWkxQoOUbNgb+kAGrPtxdiJGNlfLPB/LPJSYBn1tVsHAeUQae8CJ?=
 =?us-ascii?Q?o26vaPr5PjJXUFhfgK0Dp+0EzHMh5frfOygM8BUdMiFhi/to9MUimbz6AWoy?=
 =?us-ascii?Q?XjoIYAgYxljvRDRDmeFJw2apxe58PflugqF7UuL26Q29P3i+P3xMZNDPJYcx?=
 =?us-ascii?Q?9hIsIkNSQv7z1bsot1Q95WNjx3ZmlpmX+SW/4izkjt0wUVCX7F4x1V+iJDxm?=
 =?us-ascii?Q?KarfbekBLy0p5aJdSzMsoUZ4ay35yL/Qy+W7ye8GOl2gHdJJQKFP8Zp4OJf8?=
 =?us-ascii?Q?Xv+3nsuar8kizBg4WQwbJ8M8vmPrLe5EVknTUATA4qkzmyPX4Y8OIZgWzpd3?=
 =?us-ascii?Q?koHmwZMidjD7WPZtL4+8qxo2T2ypOjT55JXr9nxSsVLQIg2iR0M6m0nurIUe?=
 =?us-ascii?Q?zWz0wrxcOoAroPpOrFwbR3evpI84nFGHDquYAnau1JU1U/eOUuyXmzSVUysJ?=
 =?us-ascii?Q?Xwe5wfq0qQRXZKJOryXdtcqV2Mf0o/aBK/8DFBmqOmmWzwOqqrnWgV/VsInQ?=
 =?us-ascii?Q?RAKmlnPmLaS/1rXDpmP/rm/rVTbANYG8wMe3dmURYOwODkwFpZrCtwhHHr53?=
 =?us-ascii?Q?yq9l93M/s93L6z+Y8d+WlPjfFnry6c6i05Ekbu4K/XTJVmTB7OJkwAkhoEv8?=
 =?us-ascii?Q?m4dBREtBgDMHOxzMp20e3YqseX93d9dCOc+C+fuZQkMRbOFmfbA5zI9vxRvh?=
 =?us-ascii?Q?MAUmDbk9SDwFwU+cxH2McuQF43WiCt65eHYNQkpyuDmnnpEiqcilzkT6/nM4?=
 =?us-ascii?Q?4BwqshEwKywVKtozVmspkh8z7g2alvXMi11QcoaND8Xr1W4D6s0xt/frGSrx?=
 =?us-ascii?Q?Uwv7dW8pEAxYhvtn/7oYrESHvaXekDI8vte9At0CTGcooMuKs9l8WqdWtznQ?=
 =?us-ascii?Q?nWG6RbQiftlGbwwhlmISD32kMDahhhD2yS/oEvQ81CDAZAsbrlpiyDS9QtaM?=
 =?us-ascii?Q?X3ZYYrgfypW+kCdOORs8kPeznuwBLWoQWtKvEYqemE4AlOTcVy89K3vxE7bJ?=
 =?us-ascii?Q?slyA1dKn5OFLFFu8GsiDD7ml?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea64cc95-54f4-4080-e109-08d931a9c04f
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:39.6644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SngBTccRgpcrbfTKOnT61VYgVfS6HTgOLCSHFG83Fo5rAd+gYwXR/fi+mDnCzeubvDo9c1FsyiriVzdALhogPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1187
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/rsrc_mgmt.h | 29 ++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/rsrc_mgmt.h

diff --git a/drivers/net/wireless/celeno/cl8k/rsrc_mgmt.h b/drivers/net/wir=
eless/celeno/cl8k/rsrc_mgmt.h
new file mode 100644
index 000000000000..7fde3c777c85
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/rsrc_mgmt.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+#ifndef CL_RSRC_MGMT_H
+#define CL_RSRC_MGMT_H
+
+#include "traffic.h"
+
+/**
+ * DOC: Resource management
+ *
+ * Responsible for control over dynamic features of the driver from the
+ * firmware, regarding the collected information about traffic intensity,
+ * environment state etc.
+ */
+
+struct cl_rsrc_mgmt_db {
+       struct mm_rsrc_mgmt_notif_policy notif_policies[MM_RSRC_MGMT_MAX];
+};
+
+void cl_rsrc_mgmt_init(struct cl_hw *cl_hw);
+void cl_rsrc_mgmt_traffic_start(struct cl_hw *cl_hw, enum cl_traffic_level=
 level,
+                               enum cl_traffic_direction direction);
+void cl_rsrc_mgmt_traffic_stop(struct cl_hw *cl_hw, enum cl_traffic_level =
level,
+                              enum cl_traffic_direction direction);
+void cl_rsrc_mgmt_rates_update(struct cl_hw *cl_hw, struct cl_sta *cl_sta)=
;
+void cl_rsrc_mgmt_process_ind(struct cl_hw *cl_hw, struct mm_rsrc_mgmt_ind=
 *ind);
+void cl_rsrc_mgmt_process_cfm(struct cl_hw *cl_hw, struct mm_rsrc_mgmt_cfm=
 *cfm);
+
+#endif /* CL_RSRC_MGMT_H */
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

