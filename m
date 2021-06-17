Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EFD3AB85C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhFQQHJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:07:09 -0400
Received: from mail-db8eur05on2048.outbound.protection.outlook.com ([40.107.20.48]:5985
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230052AbhFQQGo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:06:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1hP3NrOxPFn9lz155Rfi4+ArzP7E4i/cYlc803NcHqKGNDAbnDZasvT3gw/l53B5ry5co8WDMLNtZUeXjRk8yHPh+JTCQhnmwOxZNCi9otKtst+peIlrW5v7ohRmlwQCk2v+ZHW5VgMl7i0CaHJuJeP3uIds0HOc27ZfYGAGlyiSspGDJ0qCmMgEWV09XbwjqpjPgylHWbpCBxFxkyBVxfmy4fPRw1a3L0x/01zwfler5frf0ZWZsir440wiMsC5og8E396UKEQVIL5lE2NImThUgBAnee6mU6PpxK4Kkw+KntQfY1HeipHpEAsHr7bvb98qo6fa+kcP50wqziUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KqwOgOW2ZCR5wbIoBiGQv3EYrFQ8PvlXgTt8ZdG9V0=;
 b=OoYa6n4O1NeDlfM8Y13QyHLME1GuqTyQOPq9Gf7Eu/rucWz3qo6lCueHREjFHKXJasdq4/83vRuSa4oYb9QzZXbp6aC05RoFzt+K+ym1rpnZly4jd13zgdCqzD12Wk0nON88S0qZH6UJx27CKniR3cibw9VhQLdfJC8d88NaFqDCdRaYyF2a3ABvBpAoOSwnO/JaOLSg5HOBUOgDyrmU8cDH/EsDJQqWtkG8HILRJ9Iwd3Y0qfIoSitNnoAmxS6VcatHgGa3zcoYj+ZWxr9rcXqZ4Y2rDkmFcrG6gp1TAwt+c/sIflHvwLgSN0ifcUGSCvBgakqyuLYFdg8emwAzPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KqwOgOW2ZCR5wbIoBiGQv3EYrFQ8PvlXgTt8ZdG9V0=;
 b=wskdxZq2o/HjYdgjVu5St9Q1UhBL1hU0J7k5J4bsXBzKRbRmCcjmAHsid+J/SvxavTs7e07vumrR0zIJX2OfWEVYaI70ua3gg5zL/A15dDxH3wgqWz2FwtoHi6PfWQNg2elzcaf5s3qa4hsruBIePCzeVFWij/VCdEGH7eW2d7Q=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0871.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 17 Jun
 2021 16:04:24 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:24 +0000
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
Subject: [RFC v1 075/256] cl8k: add env_det.c
Date:   Thu, 17 Jun 2021 15:59:22 +0000
Message-Id: <20210617160223.160998-76-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 509d180a-ec94-441a-cb23-08d931a982c9
X-MS-TrafficTypeDiagnostic: AM9P192MB0871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB08710230406178AF76A389D1F60E9@AM9P192MB0871.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I0FDtULz+SE+OMoDKgEPS2/bM++VztTApiaUygCxcOmrjLXoUlYA+xe1z3ptbOB2CVQbZ4fbljpYD+xIzcOn2upa4H6CCYAd94FFs1eCYZHXhYOP5nmb91oyaP5TLDb6J7BicIH8SbPT/g4o6qtTdw1mGu/TS99WfXv18F9wxSCG8/NuikxhyyGS4apEhctkphH79B3zOrGUcSxYfcy2igLd4SXksJWkJNqaPM2/PsndKGz5dO1cwczjPsNusncDmcmLOD02tUFY6rHsGHq++PG/WDHI/Mx8psTw8I78DZdX0o/T9Vp/qZupg1Q78jmx3gNuEwb1fyrtKp0gTl9oDKSr0zCyiwIJr+xcybIvx8BOmi+awoc2qOxphwVCsIoWWtemUZBZznLYBBlYU1Y24W1RfXy82wOqblAkkUlnLypgrc2VBfDIBh40jUbcHDnugDoPG6PPvp48Rghan1VlFfICZpu1+IqQHWqnvG7aPfX1yQFlxJNbCF32wPnTfP3mWPIvk1FOcg8qXI5uk+i08174lUNzGPuWuOY3A3POrif+nWe8k1dJc8Y3UAYDcbbL3OLjjKbi829W3bJVwyRWpJHA28vLi3PZ3FVFCAzEamYxTZHWV84Oslp3YBRHUd8pLm8qBwZS3JPBxc2VfjEclsOqS/CunG8I5YfWWznTGEWJfwfMs6NoEPNRWZ2f4Iflpo5EhL4L4tEwhL9aSzFG/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(396003)(39840400004)(16526019)(66946007)(478600001)(26005)(66476007)(6486002)(186003)(66556008)(9686003)(316002)(86362001)(6506007)(6666004)(6512007)(55236004)(38350700002)(1076003)(38100700002)(4326008)(8676002)(83380400001)(5660300002)(52116002)(2616005)(2906002)(6916009)(956004)(8936002)(107886003)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yOEXLrjWPMew3tiziRiTexNnp5YDUejY8G4Usm761Y9A0KicAu7A1XPu4cYn?=
 =?us-ascii?Q?Y6m3eUR5eSHSu0trX6/Gi8HDp1oKyIn0Lr4/4AlQvqGtU2gWLe6bh/HvZPEA?=
 =?us-ascii?Q?LW7v1u9ykFOK7/1y8sv7LVFITJTWWfpRpU/+d6kRo7wJJgyO+ZeSjFAYfnSj?=
 =?us-ascii?Q?ZnAbeGJpLTMgD2q+ciXJXSyRkZZhhP8cw1LA0RCwj5yHr5Xl67pIOupWzPUb?=
 =?us-ascii?Q?HlOzRGeUqVdhMU2nbFbyPHaGO/Qd5kUdoy+R0w2GXUmRaaHbz5fhoJ+ybmKg?=
 =?us-ascii?Q?AyfxN19MT3icMishVrkPN1rR2UumYO59XC3IPQgUcyCWn8pEGfxByvLpFrxf?=
 =?us-ascii?Q?A3DFRCW9OMYzRIM08QBiya2Zhvti3t9iE6t5Epru48PBnLXtiSserYPPDOR4?=
 =?us-ascii?Q?NpEcIIIjIthDpqmJD36tT9mP0yiX7cHGwpUGBzGdtHO2yWpzxj+Y5E82x0Vy?=
 =?us-ascii?Q?hn9hS9N4WdlsTn+veQQD2NkoxN6Elmcle3FFs+i1rVRSVP/vYdD4B6skEAwx?=
 =?us-ascii?Q?1Yn/NKfCkFAN9no95ZX/tnISuOopz/M2APET1ppgckbvY6nxuCO9R1vRNklw?=
 =?us-ascii?Q?nVRaA+M5KlYcx8WgNi80b66eLTTM2IYIV0Zc7Zx/7wBV2PPOaKF2kBqZKb8B?=
 =?us-ascii?Q?KHrJZvex6xVdv2k/ydTv8tmcVxeB/VzDyE0VmfJ2l1A0H9IIJ4O0yNz8Bx+v?=
 =?us-ascii?Q?pPjt1x2BFbIM1+RS/ntEqC0MBtmo5sil36/U8H6pILUFUwBJG4gyu9fNGr5w?=
 =?us-ascii?Q?AeXpjF0MmU+p4D/qygNEAVl7bmtcIk6WA8U5EF/5rCerXuczYLpgvsONcVj9?=
 =?us-ascii?Q?KqbiaX32KdhZsLipwcVL0MOn0hnDVzYvj/0N7caHId9AlVggwKeTcyNynDqB?=
 =?us-ascii?Q?yNDW5Asu1edA0knslLAf53bccR0z957JPkp1TwqxwcT85By3hiHzZqCLyPEm?=
 =?us-ascii?Q?QnIpjkpm7j9QQsOo9QZGWA2PHrgbb3Zc6vaSEdVhKGWj7xYf60U9UZP3Ic8o?=
 =?us-ascii?Q?vKOY1VyYV7r7664PS8wP7oruQsn06+vFkDbuwRDLJRCKO5zydgHVZgvdlfRf?=
 =?us-ascii?Q?Sqv5C+MVZW0B5pC8ojAA50ILJUKoqXMEJSnZUOzS00+Jk1KsCMuXJIPey604?=
 =?us-ascii?Q?benXPC2A9/+rM/e1jFRSNDsYb4qmxTURh9Sd6s4wAlOPU8UTFxdYOsOHiJwF?=
 =?us-ascii?Q?iHltpjHu55JpA9m/kzku4nwiZl/csKWtQMMdSiqPuPLtpoREqoKCgpxW0ZmX?=
 =?us-ascii?Q?20TpBTzyy+AySMtg20NwR9ZuNZZHec1Xf5zFebuUPWtr/KwgaPrbi/ltYtUf?=
 =?us-ascii?Q?TKt1BzGaIZQMQCbcnDaVgOTK?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 509d180a-ec94-441a-cb23-08d931a982c9
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:56.4546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsYaxGI6GOGt0S7Xc5JcudcG1ek9DFg3ucJgVRHewU/3raZMa6q9fVzzMu/G3FjgF1SQ8IMBV3qJhmiEjBB8EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0871
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/env_det.c | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/env_det.c

diff --git a/drivers/net/wireless/celeno/cl8k/env_det.c b/drivers/net/wirel=
ess/celeno/cl8k/env_det.c
new file mode 100644
index 000000000000..fcd2de02018b
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/env_det.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "env_det.h"
+#include "hw.h"
+
+void cl_env_det_set_type(struct cl_hw *cl_hw, enum cl_env_type type)
+{
+       cl_dbg_info(cl_hw, "Changing env state from:%u to %u\n",
+                   cl_hw->env_db.type, type);
+       cl_hw->env_db.type =3D type;
+}
+
+bool cl_env_det_is_clean(struct cl_hw *cl_hw)
+{
+       return cl_hw->env_db.type =3D=3D CL_ENV_TYPE_CLEAN;
+}
+
+bool cl_env_det_is_average(struct cl_hw *cl_hw)
+{
+       return cl_hw->env_db.type =3D=3D CL_ENV_TYPE_AVERAGE;
+}
+
+bool cl_env_det_is_noisy(struct cl_hw *cl_hw)
+{
+       return cl_hw->env_db.type =3D=3D CL_ENV_TYPE_NOISY;
+}
+
+bool cl_env_det_is_very_noisy(struct cl_hw *cl_hw)
+{
+       return cl_hw->env_db.type =3D=3D CL_ENV_TYPE_VERY_NOISY;
+}
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

