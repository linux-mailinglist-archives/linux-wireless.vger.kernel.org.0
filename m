Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066C02C9D22
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Dec 2020 10:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389414AbgLAJTe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Dec 2020 04:19:34 -0500
Received: from mail-am6eur05on2072.outbound.protection.outlook.com ([40.107.22.72]:4192
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390602AbgLAJTW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Dec 2020 04:19:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLepWgHoBje0lhBvb+QO9XQY5aMMWMmHcBjwwNHgNlcHSzyVyvCFFUQ590SfCFkSZj2IBWVPDHYFNHtFjItL+ZV0j0IeD053rJZ2q0bYVYZUgtqIfZy7zFIs1SgO1NOxklaXkWRcev+65/NhmSN2zmTAtMxBdiK2eB23SvhW4hFS9XvttV3vf5D2sNXFVI3/iIpz7SDGfd4idSDkHUCUIXQbzW451kc6Rvhh4CTPywM6R1Kj68Cb8CX9puTTYgZ8MTSd9dU/dqTG22Y4aU50IGEccVU02gFtHcKn6qOaZUuC46Zeib7mvvNw+cSC6FgX+GMTzWdPUW3rUh8LJBB7aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggV3K7WwbMBizOQnE0HLBttLT9xna6b/ztIDV3AajJw=;
 b=Zh52s7VPBXmnsAPNIN3Ty79mXPlPPqT/6bO/Rd3pu1fkO5pOAx7iWiS92J/5sV/uoTQ+jwRoi8nMRzgFaV6RPkRPs03CCYWofnsO+5GKXsM+0+DQQgkdew9zr3+THTJeKz/JSTfa+EpKGFHU9Ou1ytaVkxecpxHCuqw0M1aaOrInah9y7AtJ7H5DhM3s++ckNGT9dqTSoGDLu0M7GEm6+mmci3y8OAQOkVgL8QYCPGjaqeKJrC1jDCMDDnJKdJc5YBZYX4uKLFyFGrbgAC+hxAAqhIFGo7Cn70fifzSadshSwbZepYywBUPBbjcW41DWF9KRf0b78WpYbAZWHpxhUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggV3K7WwbMBizOQnE0HLBttLT9xna6b/ztIDV3AajJw=;
 b=NIqepjKkeJS3ySfz1HFexMkuLscfJXMI5AJCfBrU5+lErZ5xahA6Ha+nPhcXLJuXo4Na3qHOEMxt4Kgol09UxGFSb0HLQmJevDGCZlZOMw+w2gr4KjmYD4GAbBw7kLUd7I8gIkY1S5YtUTHK0x/K3Bxxkm4r1ZCk5vi4qnv6YOs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com (2603:10a6:803:3d::27)
 by VI1PR04MB4415.eurprd04.prod.outlook.com (2603:10a6:803:74::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.31; Tue, 1 Dec
 2020 09:18:33 +0000
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::3905:e6a3:a11a:49e1]) by VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::3905:e6a3:a11a:49e1%5]) with mapi id 15.20.3632.017; Tue, 1 Dec 2020
 09:18:33 +0000
From:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
To:     linux-wireless@vger.kernel.org
Cc:     Cathy Luo <xiaohua.luo@nxp.com>, James Cao <zheng.cao@nxp.com>,
        Rakesh Parmar <rakesh.parmar@nxp.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>
Subject: [PATCH] mwifiex: change license text of Makefile and README from MARVELL to NXP
Date:   Tue,  1 Dec 2020 14:48:27 +0530
Message-Id: <1606814307-32715-1-git-send-email-ganapathi.bhat@nxp.com>
X-Mailer: git-send-email 1.9.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [115.112.95.158]
X-ClientProxiedBy: SG2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:3:18::18) To VI1PR04MB4366.eurprd04.prod.outlook.com
 (2603:10a6:803:3d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from gbhat-ThinkPad-T430.in-pnq01.nxp.com (115.112.95.158) by SG2PR02CA0030.apcprd02.prod.outlook.com (2603:1096:3:18::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3611.20 via Frontend Transport; Tue, 1 Dec 2020 09:18:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b959bf3e-adf1-45b7-9050-08d895da1306
X-MS-TrafficTypeDiagnostic: VI1PR04MB4415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4415A62C26BCA9C156509F428FF40@VI1PR04MB4415.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:323;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RI4f45sqD0E5nTMGVG7PdRyhJR3EZvMC2QzjK7LpXU61L1/Y8pDknUjtKd4ivKRd6ZlFccFyi6knUmVDKBxCxUrcmgclDf8eQ62v5Stp4z4FXZlmbsTEPyfUP3QAswUEsDloCduxDIm7bhpkCGNjqO3vBxOrHV6mZsO/anCTPvJ/BrIoWkyLROMbS4xzJ+54ygjD46dsumA8Imv8COm6WbRyD9cVvchO1B91EJsF4TfsgUUuHKaUB4IuvyaQFvjDGHiRoHi2xq0qegSeRjPueWryAvsIgZVuCRFYbtyF2csi/vtjROxIPtfYmfkMmOpT4NuxOQM4dg/7SSwtyc9XEkG9ciJcK9WAjFo/lugoJTj+4TMXNrRiv1WQ4dD6ArC9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(83380400001)(54906003)(5660300002)(316002)(6486002)(2906002)(4326008)(16526019)(36756003)(186003)(26005)(66556008)(8936002)(52116002)(86362001)(8676002)(55236004)(7696005)(478600001)(66476007)(6916009)(6666004)(66946007)(44832011)(956004)(2616005)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UTJzb3AyNm9wY3R5WWNUOTFmd0JYcGZkeEM0b1dGK1FkSEs3SVBNUGhYOXdZ?=
 =?utf-8?B?K3ZRMlhkQXRiR0h6SDBzT0tPWW1GVEsvdjAxSWkvOEdkdFgvNjhnSFRXRnla?=
 =?utf-8?B?RmpWakxXeUxQYjc3RVptd240R2tidGs4SmtUMmZ6LzEzakdyeHg2aTgxM1Mw?=
 =?utf-8?B?Y0YvSTZCZmo2V1lYcjdiUVpZQkRzaW55RFlNQkYyR2RubEM0cXBDeVFJN3JH?=
 =?utf-8?B?WFc4U25icGJlKyt4MGFHM0U2MjBLVzR3dEJQd2t5U2dScWRPVVcxWmtrRXB3?=
 =?utf-8?B?dnFDZzRWUGh5blJmNURtSDdOdkRlQU5KOUxwQWcyOXZRR1pqbjdqRjlwdng1?=
 =?utf-8?B?YzgyRm1qOFZIcW0wM3RNMHpHNUgzWnNIajNMMDJkYWE3NFdvQmlqWVBVbVpL?=
 =?utf-8?B?QkxOd1MvTzdNTFh4Q3BnZ2s5Sk5NUlJBNHEvV3U4Q2FNWUdJTXlBYlVVOHBG?=
 =?utf-8?B?ZVhwbFU1d1B3QWJpN2MvbG9ENDVRM1hhZDcrUDcwUERLQ3BWdVlOd2Y3WXJE?=
 =?utf-8?B?V1o5WVJYS2t5Rlo3eFIzcFRaVUVmb1cwMGFNSkJ2YXdYVzI3cVRTTUxLZkhs?=
 =?utf-8?B?RFR3N0d3eEtma1o4MlczcFcrWWVjOHEzS0s5MkVYaFZzR2MyVVM4RHllZjFr?=
 =?utf-8?B?bEhXN1JsTW41eWwyZUxiWXJCQmVmemRGbmpzVHhsbnRwbEs1emkra3ZVNWxp?=
 =?utf-8?B?clllTC9aL0tEL3d5SWdHZ2xyZ2VEQVk5Y3VGTkF2bXR4dVVJTkJyRElLclBj?=
 =?utf-8?B?clRDaURxYkxiM3o3eFc2OFd0YXNYYnBTRnhaK3RSdzA4VHN0eUxvZXJIN0RH?=
 =?utf-8?B?RFBwc3JBS3NVUHI5bVhHenNPMFZRalRRdGpzOC9CTHpkVE1CSllnWmovaU5O?=
 =?utf-8?B?QzZoMWMxTFA1M0hnSEVEWWJraFpsUnUrYlErMDA0SnJHaEpXUGVPZThZbmpV?=
 =?utf-8?B?bjB6dmNhQzROazdKUHAyVzlpZTFNbGhIR2xmdm1rQnROSnM0czNQbnY4Uk52?=
 =?utf-8?B?S2NaZGtONTZhK3hZQzdWaFNxOUFvSU9tVUNGK2J4N25KQWsvUjNVY1ZQbVFz?=
 =?utf-8?B?YTZ0MXNHMStXbWdBZVRNdDhhK1dGcWJhUlArRlp4cUk0Vmhsc3A2aUxpeU82?=
 =?utf-8?B?Znh6ZWFhSDBUMzNmV0lVRGlNenRqK01MRDFURHBKYUtjTE43SUsxcy9SaWQv?=
 =?utf-8?B?RU9Ld0hkT1lPWEE3cHZxdTQ3NVVjdENMcTJHNSswdWNUNGt0RlVjSHJDU1Fr?=
 =?utf-8?B?dEtlSGNwNmNBai9ENENKQ2hPSmNmRGkzd05ndHZYbDVSUEN4WC9TcDlvZ0xr?=
 =?utf-8?Q?/YWIpkojOIvpGfx5ovGoA+KcgXkwtEgYzP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b959bf3e-adf1-45b7-9050-08d895da1306
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2020 09:18:33.4127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Hie2eSqb1REO3WeFyI4dxVgitCRF8j8W3M0rVNB+EU+7Sk6fc4DitUJs35C7ooHhq9swEg/zuBNYYKWUR+CMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4415
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As of 6-DEC-2019, NXP has acquired Marvell’s Wireless business
unit. This change is to update the license text accordingly.

commit 932183aa35c6 ("mwifiex: change license text from MARVELL
to NXP") does this, but it left out two files.

Signed-off-by: James Cao <zheng.cao@nxp.com>
Signed-off-by: Cathy Luo <xiaohua.luo@nxp.com>
Signed-off-by: Ganapathi Bhat <ganapathi.bhat@nxp.com>
---
 drivers/net/wireless/marvell/mwifiex/Makefile | 6 +++---
 drivers/net/wireless/marvell/mwifiex/README   | 7 ++++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/Makefile b/drivers/net/wireless/marvell/mwifiex/Makefile
index fdfd9bf..162d557 100644
--- a/drivers/net/wireless/marvell/mwifiex/Makefile
+++ b/drivers/net/wireless/marvell/mwifiex/Makefile
@@ -1,8 +1,8 @@
 #
-# Copyright (C) 2011-2014, Marvell International Ltd.
+# Copyright 2011-2020 NXP
 #
-# This software file (the "File") is distributed by Marvell International
-# Ltd. under the terms of the GNU General Public License Version 2, June 1991
+# This software file (the "File") is distributed by NXP
+# under the terms of the GNU General Public License Version 2, June 1991
 # (the "License").  You may use, redistribute and/or modify this File in
 # accordance with the terms and conditions of the License, a copy of which
 # is available by writing to the Free Software Foundation, Inc.,
diff --git a/drivers/net/wireless/marvell/mwifiex/README b/drivers/net/wireless/marvell/mwifiex/README
index 588fcbe..5e39248 100644
--- a/drivers/net/wireless/marvell/mwifiex/README
+++ b/drivers/net/wireless/marvell/mwifiex/README
@@ -1,7 +1,8 @@
-# Copyright (C) 2011-2014, Marvell International Ltd.
 #
-# This software file (the "File") is distributed by Marvell International
-# Ltd. under the terms of the GNU General Public License Version 2, June 1991
+# Copyright 2011-2020 NXP
+#
+# This software file (the "File") is distributed by NXP
+# under the terms of the GNU General Public License Version 2, June 1991
 # (the "License").  You may use, redistribute and/or modify this File in
 # accordance with the terms and conditions of the License, a copy of which
 # is available by writing to the Free Software Foundation, Inc.,
-- 
1.9.1

