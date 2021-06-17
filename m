Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B563AB8AE
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbhFQQJt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:49 -0400
Received: from mail-eopbgr30061.outbound.protection.outlook.com ([40.107.3.61]:14471
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233664AbhFQQId (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6oW4ePWNNTzmMfoxR7xMyrQtDjoVL4g8ebg+/eBsfW69yue+KIgyR908IFZ//KnhYVoup1d5jtyX+eoE51bHxzr8D2yPZlKa7KdzumFv6vA2QaSHznifiA5/U0oti2vNfjBmb6lskcqbJ9zdlC1k/scg3LqYDxg2GrR5WbtSEiU9cN75CT84CWjCSn/06HJgbI6UIqdv+1Vfr1vMJJKbLm51fSsGwuKQKG/r+Zx4axVZR1bh0n7yFjmx5PQq3zLMCu1L59w7+Z9bij1QtT4vl692g1lfrF7dXVQZfS5Vx625+i2h4XB8BkEKCAqCs/0BaX77wA6RqgVZGTol8LCrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPjzACuhU2nS/fkqIDAuHOuBQxx8PlIaX70i7dohYSM=;
 b=dNakDHpsvTbd3BLkcTB2XxI9BkFQ+mn702s9mAPfy1xu2BO5kKTEZ7DHxEsr06pOLzX84URRjQQ+6PlP3yk+GC1LsOC88cwnYVVHz7N37d7snKdVcFrM5js60KqPObbSvqTud/sOsJN/zm8u/qfPhRfEWeqleQ/egahEVqWRB0ZpheBaW6v/DOVX6UvYcsJSe1aqAJfSVoF4c9HjayP425eyAiX0bCItMijgZAUO8Hq5FKWNI+SqO8D8s0gRs+NG+G2l9v4vzR8cZhvAFHN367POmJt3ZK6hf/R8wlQb/4UzJvTzvM+UoT41vgtPl0zCQRXq4ZJwX7amr+TAKB4nwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPjzACuhU2nS/fkqIDAuHOuBQxx8PlIaX70i7dohYSM=;
 b=LqV7AU45bgwVCzkhQtqHWvf4kVWMo0hgCqGClbhj4YIsLJz8D+9BO7CQ3smIMxkgb4KdOPGnG7vGJpFvX+fe4sIFzK4vRNcHoFLNomBIF474sev+9aqwxBGdpfwKExWxwWdmot9oUiifYGw2f7kWLlMUfZqI0ehhICgrxq9aaZk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1187.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:06:23 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:06:23 +0000
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
Subject: [RFC v1 150/256] cl8k: add reg/reg_cli.h
Date:   Thu, 17 Jun 2021 16:00:37 +0000
Message-Id: <20210617160223.160998-151-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f86ed40b-b57d-446a-0ec4-08d931a9b41e
X-MS-TrafficTypeDiagnostic: AM9P192MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1187AA6974CA3F9B1AB33DC8F60E9@AM9P192MB1187.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VmtmDtzi4V2i1z6KudjF3G4BuGs41Q43bq00YjfZuzPWaIta5ZZnQd05Be1v9fDEL3QD+xs3Y0B5AvaC+jE2XLljro5SqjianpPfk1Jo/bFyk+EoswAqqseR55FBzTRHkGzuJBkNoultY1vDiuSzr0Px2UPdiWh+5ua1yJZkTO9t9sG2fgakGSahmbpveEgM5AMp59uv6/s/mbGoV0D08JDxFsMyakHKxJR85B1j6EO81bas1f2D5ijlChQZ4Js4OT1pbXE+0As0DABl0wMa7NQQSXKL1XRY50VgNoinsfwxvrgEhv3LWJe/bSssgcNn2bdY58PQntp032jPIQJro2wYCEfd4pTlFwL1zcZKWvrD8it10SFHbNoK4zLrUkz3Er/wP3wXE4I42K8xJsJFTfpd1pw6mOfnEOS5IOsoZlrBenbs1oV4D/RTuOMhX0rlGeEzDzvBA4J2SlCqbTZ4/7FJ6XPwqmbvTniqPZHO92eAWM0CaXT6hXCSuQ7kwrVeAcmWrvLELJFdv2WPld/AoeclEuI8tnkmAyJlDDnCVhu8q7iS/DsK9k3KliQ1LYF1XM5tVj+tXZaMSDIsiASk/LVnAbcoRwDjOkJz5Dc2Rg5tR0nPX49xs0oqlNByOVxTOx5ppFMWeS8n9Bt0ZpCBx1KTO2wJPmCdsn6LQSu6AeTYLr5ZklCuExT9AdPZIJg784zrbTcBg2qyJLDF5wM7Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(6512007)(66946007)(55236004)(66556008)(6506007)(54906003)(8676002)(4326008)(186003)(66476007)(6486002)(26005)(6916009)(86362001)(36756003)(9686003)(8936002)(6666004)(5660300002)(2616005)(956004)(2906002)(52116002)(83380400001)(38350700002)(16526019)(1076003)(38100700002)(498600001)(107886003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/5SYh3C9AExYmVtpYVkssXzEqbFkieTwL/Gl8YxaBxOWTuMLNOMHOWyd7Cwv?=
 =?us-ascii?Q?mwfXIHd3Gcsbsm0l98G+/TVJtsXH0H6A6832uHKgLOpI68DDqhBmAidgS906?=
 =?us-ascii?Q?/yPWgMME+5epBTlJJ5uVqcAHlZNOrNOGkJNsrdNMqD96JXq9hDj6iuItkEzC?=
 =?us-ascii?Q?e0J2qoWenBqhE38bK1CMeFxJjYKhqE/9/RzgEQZVxWRJhOOM/adtsME8Em6v?=
 =?us-ascii?Q?CUL0ufA3bI8m3VsxziH+G41EAYxv9Tu4W7llymoFYyWW0zEuma9mqKZoR7bs?=
 =?us-ascii?Q?NG6iQ6GNkdBXCZeqNjkr5lf15zd8PiuwvWNUSmZk9s8Ds5Ink2A5zhWYENkX?=
 =?us-ascii?Q?rTvhjpWgJpw0DeeqX9Wcuii0xRVDdyx35dcR29s6uXjjBSH5TCcU2z+MvVY9?=
 =?us-ascii?Q?hX13EwFan4FvSTdX+6YKpWgpfEk+WVozKamqAcT6ikIkV3BkIIAspzF7zA9P?=
 =?us-ascii?Q?sSEAGPLEIxXmuMyRqsLZd60yei6FOoNxbuRunnpQfxGdu0oAVGvq7c4dxr+W?=
 =?us-ascii?Q?N7fib0DbdAP+Lra2z+b2ZQaWirzGYbs9q+Ca5x6fxfoUu+yYWpY4Pz3FVZi6?=
 =?us-ascii?Q?+Xi/8n84wiomf4xy8y5z8TPTw93wFHDQe08W88/grjuRr4vLc/WcxXqMJxSf?=
 =?us-ascii?Q?aRTo2HmdptSMZjsD36tDyVsggJ9JRaoYO0F/pP2sqvFJWtuFvg2kDppegY6K?=
 =?us-ascii?Q?8mdtrsgwjDQGhOVHIejB0dCuFfzh6nRcznMmSewM09C2fGu+5yhzaAe629XW?=
 =?us-ascii?Q?Bx4hHkGTaN3/ACrJLJZNsQNItQzuJNoLs60LqzhXxsmGxGNcLStrDquO/CwE?=
 =?us-ascii?Q?hUBHbbQBC4tMRpU3iLo/15avmdKuOflawS137hDpLhMbdHkM4QTBIgOc0Qoj?=
 =?us-ascii?Q?01ItXPaiCev+VJiUDZpecKi+qVl/+JaQZVyvkM1bSPscIkq8hI2WpbTtaYNd?=
 =?us-ascii?Q?B40NjuOWMV2kMcrkPC/f8i6aeGq27nexCU+lFhPAAN9oOEGNPiqMkimPy8+S?=
 =?us-ascii?Q?JvvwYGVLXIN/dNZsNbnuTR4k5g/qcGYyzEtlbXKj6IeJ9KGkFH/qwGKvz92k?=
 =?us-ascii?Q?UsTpgOszhjX2hf+cQYRRT8qHC8P0tsfIuyUFupCPiRxRa5BS/AkIrcc+7zLa?=
 =?us-ascii?Q?zhdjo5ImsMZ4dsVOLRxYIWcFoWyifBsnD15IfpLcrmG7+3/seHndy6uHq3Ic?=
 =?us-ascii?Q?+rz+kWF6anoBUFB8vgSqprxliP/VGfP3/7UIntVOIhBNuV8scMUCFJW+aKyo?=
 =?us-ascii?Q?v1iJpnQFtbmNnAUAzOQ5v2EZLiPqQgZuyNBRuznyrWhK+2+mGxq0b/zcwID9?=
 =?us-ascii?Q?ahKuV/+zIAhT1H54jSpWCnMZ?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86ed40b-b57d-446a-0ec4-08d931a9b41e
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:19.2132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3O2M45S/BW+26MzlYFnuKledbO5kWX2xxV3rLKmA9l1m+pM1B8lr9+5DrV1KR3WWxb2xnW6ttGUOjNy1fTfU5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1187
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/reg/reg_cli.h | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_cli.h

diff --git a/drivers/net/wireless/celeno/cl8k/reg/reg_cli.h b/drivers/net/w=
ireless/celeno/cl8k/reg/reg_cli.h
new file mode 100644
index 000000000000..4a77dca136d7
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/reg/reg_cli.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_REG_CLI_H
+#define CL_REG_CLI_H
+
+#include "hw.h"
+
+int cl_reg_cli(struct cl_hw *cl_hw, struct cli_params *cli_params);
+
+#endif /* CL_REG_CLI_H */
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

