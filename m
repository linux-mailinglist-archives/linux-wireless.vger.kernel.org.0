Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924EF3AB865
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhFQQHk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:07:40 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:64480
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232113AbhFQQHQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=in0NvS68OXLL/cLXnLBCxgZK0vxCt1muFrDfuE65q5vkaXLC2Bgp0iFBLSEJJ2fETyME9nvaGhJaGTkgSwnuoHY9CUOT9BdjgFlHTHOfs9grOqnmHxyKOe5GG6K3HkWywZgbD8mwV8raWe8FIPjUXZqi1BW1YqSPkLV0xG1q0rEB1PdcPh46LpATa0N4lOXXJdyxAma04VS5d0TOQHSP2TJOYQk7QcDAuHzUtIF1oqJ8vbpEBgvHRDw2YGWz3KYvNFVHBylra9zjpa234XWdcYocFlSq028ftSl7osEI69qQDT3HLGQDpUN1CIZA9kFeztIDwVq5mkA7fCYnYk/XNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUdARfgsljQ5UALp6Tyqx6tRJWplu8XeJEJcvfVAsSk=;
 b=XNnGUqGMUwts2l6cxTQOPVdj+FGrCKYIAv2s3A38c3yt/RmfBcFyW4kvy4igWQSCYxZTqo9d+ZBxMqVYa7+pwdgkEzolfXQQyDMP5KujFDN0wFeZqPF9oaAMky/95RFNQvpUiqhQaVp8VEGuE8hOC4RvSAlXTRNYLF7DSnU9yxcJp4gDqHYQ8Fq0BPxbavd/H3/lyPE1FamcsAsraUXS5WV/2q6W4Of8SqOLuKEELSD12aQuLzUR0ddTEWY1i2j+wwkb++VUeYg0ZiT/7TeJ3KwpeKLyZdjsvsUtucp5hnl+SdJSjXim8G2LwqycKJDlgwG0hr1tK17pIEwII4FFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUdARfgsljQ5UALp6Tyqx6tRJWplu8XeJEJcvfVAsSk=;
 b=OO5mgBx7lnQ8kM+4SGNvFI89XvIjRfe+WbZYLOJZZJaJ3SE9uJYA/nIGQWGyExOvfh05NRWBAV389ynduag7a4Ls2h7nGxpSle9JlMg6koB6NOi0PTPRqD2R+2ITzLL1k7Tu6QyXwmx/yf3o0ts2CLeByAMm3Zi//KCo0EH+LgE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0402.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:46::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:05:06 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:06 +0000
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
Subject: [RFC v1 105/256] cl8k: add mac80211.c
Date:   Thu, 17 Jun 2021 15:59:52 +0000
Message-Id: <20210617160223.160998-106-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 154a132a-b1ca-474b-2958-08d931a996ec
X-MS-TrafficTypeDiagnostic: AM0P192MB0402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB04028517D8BF9F940BE1497BF60E9@AM0P192MB0402.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l34Byq9OKeQ0Wk68MfSm7O9JVKTPY+OWFzTyKxV9on6Q03EHPp02WMzLTfCjZJ/gyrtkEGXGPrsqgZE7DmFsZiB2n2oBnoWgzitQoCglo3RHtiz5OxTuQD/uiElbzJa9NdEY5ehfCJsyFS09B5vLKCKEZoGlt9PNnP0fM40Y9B5oAHIYHDZw/gmheFLbaq5YMIsw7ei2eSOoVTcKbMrWYueYCTJyjCbo07htdBwlxDhqqSkUSydYom0Ym30O6GcDtKHojO+nc45n/fy1VNDSuhqYYemENzZVdZe6oaQqictESq0wwK+kWnLFWciIQU85yROfe3sAkPUwK0iuouXRJue/VGzeBl0/djIp/VMgUtcJrAF3qkIDHU+F2sYKfy6L3C082D+WiX4s20kudBTqCOjtD5gcT0EGDTlLdApNttwz+SFj8UH8Sl90ZH+fg48qmKAkoso1v2/kmRumStOPh1c1DE6IgFNV0QkFxeXtF3+xTrBjtL+3gINeK0IDwnJnRKXdeiMZ4B+1hoqiCRnDFPjbed/1QiRVK2vFK6eBdE9R+TvOOQhSn/FOiD7vgHZ/OtXbuO/zVmlt2Com3zqo2UOBJcE4lW47OoMk6+wVnNoh8bxHlOVhAboXyWIfLeSEA6yaPIK31ZfGHjR+pWNvXe2yL5n7Y1v9Cg+J0Fkt0o5iUBjKnFj7nk2z3cG7orktMNWC4XtNNiaGCll0btSBCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39850400004)(136003)(376002)(396003)(366004)(346002)(6916009)(6512007)(9686003)(6666004)(52116002)(2616005)(186003)(16526019)(38100700002)(38350700002)(1076003)(6506007)(5660300002)(107886003)(55236004)(86362001)(6486002)(8936002)(956004)(26005)(8676002)(508600001)(2906002)(36756003)(54906003)(316002)(66946007)(66556008)(4326008)(66476007)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MlzJDELDxan1/M5bBUEmf1B5xQ+riZOgB/jqGriJ8UBPnZs53lSl4flnCNjA?=
 =?us-ascii?Q?h1QN+neXvYVVbx03XNNjpNo+9fehnB9o7yjH4D7TdukNRjo4N4GxjQjnBc0/?=
 =?us-ascii?Q?Co2DBchmEunSxMrN7kY9HfUmVH0wWsiTugYeVFqYByxQmRbybubujWw8jyQJ?=
 =?us-ascii?Q?mAemJsX55ByJBoScLL8m0b4EzMvmsV23ehhUK4zMw+ADddSnsdtai7qa7gvi?=
 =?us-ascii?Q?DSjmvy7R0NNR5SUZDoWb2D975nKk4px0WQoZIwyDd7x4tyfbpZ8lBLdFrq2S?=
 =?us-ascii?Q?q3+BnDc7AF+Nb7fHpXuVzv48ram7AUzRr6qRxiXgOnTPsNAbjWANWR4tRXlV?=
 =?us-ascii?Q?b/lKlOEd4/KtEUj6g24iBr0Pv+FOeVkucCq66aJ0RH2D521ItaMX03skgcD9?=
 =?us-ascii?Q?O3FdHwWignvyUqUsS/17jVztKkyLL3OoliIgpd5uVI6WbGKyBQf6yOixH5k9?=
 =?us-ascii?Q?DV9t/XJC5AvMacqaMVEdcvFtkuWdWzQPIWM1eOgMSVfRulDnP2BylEDfoptd?=
 =?us-ascii?Q?kGLVEMXgEUqM4AulB3TITDSIZIzL6A96eZd77y6Y29XulTpbkR1VfFA5BF+F?=
 =?us-ascii?Q?tF4VC9DWEVD6o6RW3Xgvi2OGqbVYtFoYgYi9DIFBM2rj0V0VN+Jp0cdvDHV4?=
 =?us-ascii?Q?TB7ITpP6YFN4RC0m82JUKADit2fnd6qFV3UuLlGM7TbrM2/DC4pK6wR9DPwr?=
 =?us-ascii?Q?hq28VyGBZ5qYOSOc0Cn1G5QMemPWmgKOxjo6gErF3QKGaMu//PIxslsRXeTC?=
 =?us-ascii?Q?sBIdp63BlsJpuImt8SiG+pdAeGWVSEjkOAuvto0AAQvn5l4vq3LWOJ6e6vao?=
 =?us-ascii?Q?b/AGKfzgtf8emzMgeYsvJkxM3gBvq6QwBKRfL/LdOwL2bUqchkfnPPxAuY8a?=
 =?us-ascii?Q?qUPZjGDSrh6e8FeEFXV0OEMqWHoEx2cylD8EQDJZtywGfL8gKxC+LtrpEGM6?=
 =?us-ascii?Q?ORBWEccovTqtOyDQDvnECPuV8OCQ1Ayw5uJg8gUyzMyatkZ8aFqYOqwvPpnI?=
 =?us-ascii?Q?dChvwhg3Sz9RXdumlo61131kdn8A6YW0TCayyl7iCFaZ3uGUvswU30VAzpdB?=
 =?us-ascii?Q?9N3EFCpGlb9UgQpxlEnEcvqjEcODKZdhmbInCKN84q0tzgYB5MXQK6nSY9ma?=
 =?us-ascii?Q?sMaDBJmZi0MW9IvqFczZ8y0SIxpCawUVRFQbEfs/2u4LKsriXhurhziiuFpv?=
 =?us-ascii?Q?arZDPzUcr0DWDS2kRpMECZc6/kfcSUcxr0XfTLAkGPg1aP+E4qonxbfBowJ+?=
 =?us-ascii?Q?SW6wSIBTWuUkQNcSAUYnhB+C/s+2T0TrvUAiNt+9sL1Uf3ydffKvFiFk53H1?=
 =?us-ascii?Q?s7rgb3kb+V24PQWcoSLigIZl?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154a132a-b1ca-474b-2958-08d931a996ec
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:30.2392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tr/LZLFNClDpxewN0UnMLKisP2f4ipUbNJwHnrHq2coLLtdBvH5T5FElG8aWMnELW0k0x9tbwdc7oYJFK5Pelw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0402
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/mac80211.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/mac80211.c

diff --git a/drivers/net/wireless/celeno/cl8k/mac80211.c b/drivers/net/wire=
less/celeno/cl8k/mac80211.c
new file mode 100644
index 000000000000..4ba6dd1e6eec
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/mac80211.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "mac80211.h"
+#include <net/mac80211.h>
+
+/* Copied from kernel/bp/net/mac80211/wme.c */
+const int ieee802_1d_to_ac[8] =3D {
+       IEEE80211_AC_BE,
+       IEEE80211_AC_BK,
+       IEEE80211_AC_BK,
+       IEEE80211_AC_BE,
+       IEEE80211_AC_VI,
+       IEEE80211_AC_VI,
+       IEEE80211_AC_VO,
+       IEEE80211_AC_VO
+};
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

