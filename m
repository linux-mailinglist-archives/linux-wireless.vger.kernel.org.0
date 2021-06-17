Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE53A3AB8F7
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhFQQL1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:27 -0400
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:37092
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233863AbhFQQKM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/wwzx2j30vrmLD7kubX9TN8y3G55hhVg0YyB4NSJyudySEh3pFtxXXFforV+s3hC73CEoxNk1kqKw6eERVonXF5paugr2SePqxuIXDYmLh92Yc0GHy3DDgGqScitLv/dQKXz6VQC71vLP3Z93uN/X/nWI422caFJG39rbFdhtkgxypgin3eOWNds5nA+56aO9QAg5YfAUAxZXIGWc7lKqnUPds0ao9RtV9Exbs3Foq3UgGw0WyMBTqFaLhG1gq6Mh/Y9NhMdB/Cykba2ijmQD1VTX2GS4cWxNcDuHNfaawPl+OBBfmamOsd/pbk4m8MzT0tmpi2Qr2djEQ1JxAM6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwhozgU//HyK8HB+0jXOlcApsUyPFGVgM/FbfI5z578=;
 b=faXc3XCfXaBmr6oS+emt5hPUuEG4MqKiJmER8KLwSA9huvVPDWFfDx9CzSNDKYDIVgljJfqvcZ4HBMJTMEJgTu0Hfey+gx64tc6a6hMTvxV/Yu3cg8ut1FREVuE8x7/TGRK1Lkt9+Odl+IYnaN+7c7+DWR7hJeXObW90pp3lQ0bAVw+Hiu8PfqGYlIZGh1fTIssL4hCNFN7TJKaK7mk0uj6T4gIe9yqqBCv8ozzlz6qRRsylvN8mqXqEiakJyEzVBJQXGJDQzCC5V9bY4MFyNaNq+msXFmlHiKBapp11TsPk0TiE3iXIvyF+KxZClHVB61AXtPJKnBOyi1j37Yv5UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwhozgU//HyK8HB+0jXOlcApsUyPFGVgM/FbfI5z578=;
 b=RGxXMmO0hFdKgXcCZmbSrc/L1Jxvo2d82hdHQzyrUBMWyvRw1y9qOu7z8rhNbB5GPJENUbJmZH2wwUjzGqeK7dImn8qIoCH2IjuDB8MnMgcFw75n1Gc+SU7y7u3B8TGrFBbEd0Yped+PIiusnq70gL3KVNBoeeAyJt+YSwSPgXc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1075.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:07:15 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:15 +0000
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
Subject: [RFC v1 197/256] cl8k: add twt_cli.h
Date:   Thu, 17 Jun 2021 16:01:24 +0000
Message-Id: <20210617160223.160998-198-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 637f4cb6-9c24-4a6b-c214-08d931a9d3d0
X-MS-TrafficTypeDiagnostic: AM8P192MB1075:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB1075B67DDAD014E3B2DA594CF60E9@AM8P192MB1075.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EXLOYOBCXS/Kc0gpFB5eVsGd3MBgN0+MDI3vYCllo8yH0LPqdRzclWfVwffnnDpvEvikyD80YSRKv70ycyL4m7cuwWgHeEtEPh4Mi/Ynxi0347dhxOterUBaL4xblD94kihFFaX806oYp0ascVi2G0S2JxzJIrvQXAApzUmzyuLL8/qq1iofLhqFO10ynWaumYj7pF8m45qrVT2HbbztkkLQZcR0AwQ5UHu1YusktLPuWy504w2vHNMET4a4RfDqurlbP497fWAenlDDYpu1mvHvlkJk8l6M5KczkoXbz9akibFt3LSsJMhbNnk0vqHobM3sxgeyhyRBM8fVJ84ftqA6Nmd+87vKxV2pvs+YqhbgcMTnZLAgHLF9WUEOD+in3/6ua+5p6VkZamwwQ613PG2kxz0jMTo16PR8ehjh7lToxlANL9900kZgu8WLzehtlrZ4nwkf9RCKzTlawq2w/65j2vDI43cJrnjHA1mQpJNTd8yM7SyVty1E/yj72XjhRf8swdrek04Im6eSKZ/1thsBGG9G2nhG2VR8gXB40uJxsc1ecG2TFKbVGSE3Xdlq6xVOUU4vS1usPoMha3l+7Xc8+lqR0FryaEfcxT9PcVCqfmf3xLtU1puFDe+iWD6zIRNXDH/RG4k2525pX0braUjqugpqzZsoVoBEI0IDeKLSsQt+q3nvhjdLAf6G6nQ0z2BlmAyEu+5oUNkFQuIyQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(66476007)(6512007)(8936002)(66556008)(38350700002)(6916009)(9686003)(66946007)(956004)(86362001)(26005)(5660300002)(2616005)(38100700002)(8676002)(6506007)(6666004)(4326008)(1076003)(55236004)(186003)(2906002)(83380400001)(498600001)(16526019)(54906003)(52116002)(36756003)(107886003)(6486002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FnW11U4Jnac6AQxc2JCoAcvaZ+4kV4LFruChaRRjxTdV1j35K2bLP9tab/OZ?=
 =?us-ascii?Q?DC+QrJdVaR8KnyVZ5KFmtggoAwkTLNjqfAxThqwvQG/oqohQrZV0VPwTPuhx?=
 =?us-ascii?Q?rVmVsB0cxogdrkbqCu9Fnb+cYQsCHFNMmFD5HA8zWRvbM11c5pmVTFgKFCs1?=
 =?us-ascii?Q?gMGnhN/ww5C4dbJpxVIWDfkLm2xWhHpavsXhezeqi3GEpQEi48mFIK/y8PfB?=
 =?us-ascii?Q?Desw6+MPhbgQSio+YEDJd1LwwNLWBrp69/AsuLw9pDlAlzepls4S36mT5iS1?=
 =?us-ascii?Q?ITAcBTDFIT34QPpzZI4opG+CAeLeZPn6Q2vuBGAvAvveSq+Av9lldFhLC7qM?=
 =?us-ascii?Q?g2S5dkS9s2SGWw+20AoiPspigyD1Yeoo+pCXqYhLp1ejnYp2yMlTaO9icBIT?=
 =?us-ascii?Q?VqhtJ9eqCuDKPx4oH8h6mYqjvBo00zn0rklISlTbUd8JgR6ZMeFgypyNaa2n?=
 =?us-ascii?Q?c95sG/x/5H1zQFGalivPtSswjPm/314jdPyD2PmyBsdQsyPH7qdMErtovWpe?=
 =?us-ascii?Q?Nttc89UrMWSC+J5B0EmhK7zsFkXBxKGD8AydtoPGokM21a3tsVQzKJRATURl?=
 =?us-ascii?Q?LBnRaB/CqNl//LLaSoTVB+CeZQD9tqLE/w+U80DNndzf9l4Mbdm301B4HRb2?=
 =?us-ascii?Q?qn9CLIpwZyY5EjbiyM59u1/haFqUWYGOxlHF0+GwdCSH9tbMoWhzt3iC9xNS?=
 =?us-ascii?Q?nTRGlIy9dlnsD+IEAdPJNLjt06cC6IahmkHvsXDhSq9fp73Sdq7/Xaz6iJyN?=
 =?us-ascii?Q?PJj7uaNbiWdGLdL/bBWvimHJQpjiXK06KARjFvJ5gLmBFoZBhCV/KJulpJ72?=
 =?us-ascii?Q?C6CxW0ZvniA1LomA9lRG/BLUcEKBpJBo7hMYXZMhM/OWV5DSdv1RO2czpl32?=
 =?us-ascii?Q?mY6f1UkyTjZnrzs7eZgq96A7V2mJjCbIkGG8xlehDVd6C60bsCKZlZJppcIz?=
 =?us-ascii?Q?XPUvEistOOpdTUCOPnJ+qySOwXVTWO3SQ266lkqgZ219Z57U/ZbM/L8qxMS0?=
 =?us-ascii?Q?kygVrIKs/0LtOL9EPJ8vr1UePcHvlg++AagIwKzEV8SBvCGP1gF9irgkb1ts?=
 =?us-ascii?Q?68BD9MAOt+qy8MhEethqdUrYnENb9t0vpqQr2N43pY4aLZxsZiSQlkt9qOiF?=
 =?us-ascii?Q?R+jDxBBBPZHiPsICOQuoDKl8lcF/lhpluOw3APYbyw3DnxsGZ+mWfrM5L16C?=
 =?us-ascii?Q?OtFW4NUNVtkNCdb1s+2AIMT3DGxPI4FXKEHGO4kwEWxYd7PBJFqfWIVuZGD0?=
 =?us-ascii?Q?L8L8h9a0q9p2HMX2N0lbJV8fjj8bvsbfDuoEhrZ08ls/yVz4wbT8G9QQ7JnS?=
 =?us-ascii?Q?TqPWMlVRN22Ixj8MjTotKjCX?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637f4cb6-9c24-4a6b-c214-08d931a9d3d0
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:12.3967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqfb5Sn5qIP3hu6hVBFa2/hbUBk+rUpZjb9udhj9Xbtjbl4AYGB0AutWpium3GVNvqOEdkG2R3bzVShRnZBhWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1075
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/twt_cli.h | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/twt_cli.h

diff --git a/drivers/net/wireless/celeno/cl8k/twt_cli.h b/drivers/net/wirel=
ess/celeno/cl8k/twt_cli.h
new file mode 100644
index 000000000000..2bfdb8d110f0
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/twt_cli.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_TWT_CLI_H
+#define CL_TWT_CLI_H
+
+#include "hw.h"
+
+int cl_twt_cli(struct cl_hw *cl_hw, struct cli_params *cli_params);
+
+#endif /* CL_TWT_CLI_H */
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

