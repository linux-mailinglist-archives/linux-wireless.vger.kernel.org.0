Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3C93AB876
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhFQQIN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:13 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:9431
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232384AbhFQQHe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncyyMoYmPDNeFu2HXTpkZv8vV9W8bv0SNsyYnMJOTCkaSkPpvPEBbjfLHnG6RjjN+B5faMw6B8UuuuNNpXxe561DDNGT/hJnlpWQnkuvS0RjCGUrLOWU8KdnqEmZNZ9OSh2XbUjCK1VFNOpYx4bcnvJykOHKPjlQtsI6pjgUOURrCKN1CSKoMYPjmN/1zJwF21PWSFeNFd0hbaOTSeWBxYsAdC2cOPiTYFi4zfy9yZt9qYS+ZTfYevmwIPLuv3mVZ/KBb1zvsUb50I0/LU47rNArHwV5dKxs2qdOL7RqqUYKccnxQnHCaAbxeKg9lpEDusBHU7bxogdFyeEpqsi8pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN6sv98xs2EOPNw7TmHOLwzIGanCTxsT1hGeKdwWsxY=;
 b=PhWnCwP5RqDtOqxO9Wa97nqgkpnRXqMcYl/MY1PmKWx2LLsw80VvU4KTopaugx1ApNFdHCatHobv2v5ylpYoCC4bCH0UPS7nbEqvW/zFBBtyiSg5ocxXiXuNkoYp6TccckPljWDF7BgW6aDIV5/QNfOmVo5HZ6QtzMh9zhN0mm9zR/vtX5bTB/kT1tc1JABp0/NCPD8GN1JhFZ+4QHT2WfiBKxOjtbb/a9S1l0f1YRoGy5zcM7mvWnxmQcz7gUtQKwVX6FFsgfqBZcR8IOu6OMoZXi7tXri//6ErXaFmZON4rQV1i50CO6C3NMA6TMzhyxAcmxCom4dlqgKVEgouzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN6sv98xs2EOPNw7TmHOLwzIGanCTxsT1hGeKdwWsxY=;
 b=lBj39wX7e+ITQk/Jt6QhNdgqJXYjKWdKpbMVAT+advpNM+lnfa0DtdktYKpkkNtkw+9po9Gzv1Kx5dX364bDGSHiMgpMwA9uFpIEYp/cwk0ofMgSJW2+cKWGA5wbLwMoXbstLEU2D3FxkBZ0yglkulbB4dYpELUjn/1GHU+yVr0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1268.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:04:22 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:22 +0000
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
Subject: [RFC v1 070/256] cl8k: add edca.h
Date:   Thu, 17 Jun 2021 15:59:17 +0000
Message-Id: <20210617160223.160998-71-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df05e2f0-23db-44bf-eca0-08d931a97fd4
X-MS-TrafficTypeDiagnostic: AM9P192MB1268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1268DABFDE772C95E72789ABF60E9@AM9P192MB1268.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rk/sdJntWvllNjhxbNd7+QGz0vRAKo59P5VvUhcmsixgkgheJy11Y68iAjfMFcpvcCaRd7v5xlQo9qE6ZimaKEtj5r5eMiB7W8e1o5tKdYdMPuB0QVf8XR4UIhqi7o1ukd9akcHY8+o5ybuqQsDlN5ZVzYblgrkpFGrOEco5EP71PNdq9WEDlbWcSTsiKV4P3v8XLeECUlw7ZLL1/wbt6L8VjesEbZJBM+Zl97XcpZD4kGcS8T+vVtIqy7YaYPjznt9vxE7lhprw9xM+7LcaxytFNE54U2zAsoTzZ6rNRfmmzNyyeT39UvnF2o3nlk6CQem/O38IKeGp9g3IKULo1T2XScGUe7eq4Oz2ILtv9jwl1d17cebZ+Ny2cY065G5PxrCM0Wd19qlCxV1J/IVslSSA5mZcYQERE4kJdjh5A/r9BeCWUuOZdkfc+Xb1fhGGO4O0ZzpU7sRjZYNT3z8VKM3H0L54fiVlZOiWQ9nyLzktGsGa9u0rJJ3lrW4NZzIUqfnD/jZT/JGyOw4N8cRWPldo3/0MQ59ziM8sdkTYkDBhkWSI13IKhfnfCT1o1EovMeSXTpCC84lTPbkLaqJt+QyQjeVeB/Wk2JunDX+K7nSYLQ0X0iDHaiDvZattTlHZHq5j3fKB0UPdF7iUy0GwdLMVQWju/WvuxooHUINGvv2J1pG9aRzJ6fj/ZV4mdejBClAFyTn+VT1WknKBMl5RFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(39850400004)(136003)(376002)(6486002)(956004)(54906003)(4326008)(2616005)(186003)(38100700002)(16526019)(8676002)(5660300002)(38350700002)(8936002)(26005)(2906002)(6512007)(9686003)(52116002)(83380400001)(6916009)(66946007)(66556008)(66476007)(86362001)(55236004)(6666004)(6506007)(1076003)(107886003)(508600001)(316002)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qdPKkSjM8RvdN5gyCfmYMVMUTKpjhK0EruMtYv13nm/CFoxlv6icVVxHsz27?=
 =?us-ascii?Q?hoIfbVXs15PYfqQG1ga+mCvtlp6WocKTv0VivNM90buV65A1yg7955d8vHgW?=
 =?us-ascii?Q?xnx2ixuATS0Q6evfVyd4pp7X8hFlhEKjy72KStUiMzkKq/rlruQclOUDAHIT?=
 =?us-ascii?Q?qKRvkw+EucbMCqRNJbje9tAXWtYG16K/JgN8P+Ar0J2U6zcmnmoGQaLNpmVs?=
 =?us-ascii?Q?BI4U/WnSlynxNiI5jIvpw/I2Z4Db2k4UXSnvQzEf9pCDyqOeTOMAQSKrK63w?=
 =?us-ascii?Q?ub3e0vpcY6zjvkiXwkmmv4YiX3BILM6eiWhRh7hq7Op8lwFXK6p9V59Gm06+?=
 =?us-ascii?Q?4FdhbfGYnrsLLFglqJoIqEeaPVwNyU/xm6tDmA3da+MlPMzKqwylpVvcn5Ad?=
 =?us-ascii?Q?QWO1ONkoCrLhvgv1yxlvsuu96D0P641bgEnpL3VwopssBR0yhkODpJULQH+2?=
 =?us-ascii?Q?7wZ6c/sv7vXg9iK9/xCwBYMj1cJjcoQAMUP4Crh5LNk3cbWPbOLASvAI9X2L?=
 =?us-ascii?Q?82FhnZDAHBwd7wkuyz1rKEOelYLWDZYzTg3E/A+/MZuSN++TYR9X+pO8i6z1?=
 =?us-ascii?Q?LYy00QFfAj1NJ8/ILH8hh/+NUFs+oosyQGNERpl65x55qWgnmkErdPKyXGhh?=
 =?us-ascii?Q?dPLqLwfR05d0r2J26dZjks3CO9G+4NgehD/tMkoXP5kmvf6BXNYK8diLkmgZ?=
 =?us-ascii?Q?imXTaJyXgpsVF9Gav1dV8Jg57NQnGzP9pMAAcL+I/Ws8SR483WKWFedPetLj?=
 =?us-ascii?Q?1Endnkd4J8e7VVLM1tSfXdAby5m3YVXC+wGaabgPKbNXl88J3Pdn/ZzwV0Y2?=
 =?us-ascii?Q?n7mwP23wMjMX6E1xU7g5Q+F8G5J5CWhLOTQEc5hBA/rozzsdBjvnLK1HdnfW?=
 =?us-ascii?Q?kYQphoZ+Bvp2pvYQwsQA1ZrcLmIl5JDU0QS6Bv6TqfaKePNacy4Qv9IhtKPP?=
 =?us-ascii?Q?iBcP8xTzbk9V6Mchzwm3AYnNYtet1rR3Rtx9W15KP7ZqrJ+Lhu281bPhZ8EG?=
 =?us-ascii?Q?eteUe+xKcgc9KuevcoXkmFsDq32U/j9Ov8/m3vAxmhXCzHneIqMaAObN1ZjB?=
 =?us-ascii?Q?aMGcW6Zwt4vttncepEPaEYvMFoBrx7L2J4NbBrS/8I4fzixtclLlVOZRojty?=
 =?us-ascii?Q?UV9EsRXpHo0uO9H5wNhSBSRGOg/3LrjmRe1eDVzjWjqNPdx7C4UZ6WRA/x38?=
 =?us-ascii?Q?u38X7TpFcRvgCVGaWCOzHSQg88d04evQXQkhUMWVMCj2xsfWbpHwJu8/Gqhr?=
 =?us-ascii?Q?Zb8n0/D/9FmS1w3e5/GXXUfYvvX1AFfxMgAUoUO2+GllXqhFfVfY4mVKT+Hp?=
 =?us-ascii?Q?6rtJ+9FZeI0PZSlEsL4EfVmN?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df05e2f0-23db-44bf-eca0-08d931a97fd4
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:51.5014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQ2sCR2ptjQxyb6BbccEu2mkgpdIDnvcgPv2eiBWlMt5m5kU7ljssUsBO4Y3nkr4snA6hkS58NktsPu4tnudTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1268
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/edca.h | 47 +++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/edca.h

diff --git a/drivers/net/wireless/celeno/cl8k/edca.h b/drivers/net/wireless=
/celeno/cl8k/edca.h
new file mode 100644
index 000000000000..d8edcf12b95c
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/edca.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_EDCA_H
+#define CL_EDCA_H
+
+#include "vendor_cmd.h"
+#include "def.h"
+
+enum edca_ac {
+       EDCA_AC_BE,
+       EDCA_AC_BK,
+       EDCA_AC_VI,
+       EDCA_AC_VO,
+
+       EDCA_AC_MAX
+};
+
+#define EDCA_AIFSN      0
+#define EDCA_CW_MIN     1
+#define EDCA_CW_MAX     2
+#define EDCA_TXOP       3
+#define EDCA_MAX_PARAMS 4
+
+struct edca_params {
+       u16 txop;
+       u8 cw_max;
+       u8 cw_min;
+       u8 aifsn;
+};
+
+struct cl_edca_db {
+       struct edca_params hw_params[AC_MAX];
+};
+
+struct cl_hw;
+struct cl_sta;
+struct ieee80211_he_mu_edca_param_ac_rec;
+
+void cl_edca_hw_conf(struct cl_hw *cl_hw);
+void cl_edca_set(struct cl_hw *cl_hw, u8 ac, struct edca_params *params,
+                struct ieee80211_he_mu_edca_param_ac_rec *mu_edca);
+void cl_edca_restore_conf(struct cl_hw *cl_hw, u8 ac);
+void cl_edca_recovery(struct cl_hw *cl_hw);
+int cl_edca_cli(struct cl_hw *cl_hw, struct cli_params *cli_params);
+
+#endif /* CL_EDCA_H */
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

