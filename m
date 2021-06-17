Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC1E3AB821
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhFQQFH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:07 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:38880
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233535AbhFQQFA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hzq31QNI5VTF4oWj6ac22YKILKKvWw/DOlMJeo/AHP4KPbm9ev9n++MBJfp5hz012nGYb1W+Bh3s3tlICVKkI81ToDjAnXWe2ctG4ZOTJJ31XF4/tCjY+WWqdwfxUcjqIQ9/Un8ggifM0aK8orz7G9LSTK3E3d6qcjtV2r8xF9xuK0jhQw+xCZAb2Clr3LV7uWZlTM/btnDGl1hEQcYXIpU7CvXG/YNoHudvgIRuyeXtzd3UMQZ2QYIEoi+lp5U07qBakZmInCYzdnjSmjIA59xl9284dfkGLCQZkADE5Vj96sC5b5gjicF1FywevmxZnmS2y9eiAy0/Zqc3KQsmzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUC3W3XkC7Ga/LQ6UArwU0cRbEuDE8ByqSmx2u/onRM=;
 b=d4zrHz9S687FzZPIpXbNmsw6IMseccLfAZ2r/yFXJtm9JwdMXlK1jZ0DmYJFnTXbWCKLZmwU7R1tyrI4S0KXHRgEvVwFKknkIJ8FT/S8CWwsfwYsBTW8zDxCBaU/q/Bo/L/xe5iFXMrg1a0I0sGPWOUuikptWKJcw6Xj4llpzPwRBdVuqIg1gj0Bh89ciA+RF6WRLv2qWrBEv1JV8QXSqwpAXZqrNK4AlK+u7fNm4cumBjKxokbNpCL9n0TnXg8Z4ZyKTqR5yxXcdN1kYPCjH5g74IWwICy8XlrT2aTtg07qgSg2aVSN+8YLn6jkZvSlW1n9Ik/DEkotpBpZ8jXn3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUC3W3XkC7Ga/LQ6UArwU0cRbEuDE8ByqSmx2u/onRM=;
 b=hZ4zgn9nCTuXFmrDl2bh/u3oXb1PwKNho//zKBBXdi+3cys7un6xID5dhqVAqjx9dICBiErDhs3P71S7caCcl5ja1oHb8pD1sNayhBoaIdi9oqJA3vxFGmYZjtKP/Hh7TU+7ytyxzmiUAiwgY32PIwm31Zozt7H2EhTpYz/7Edw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0499.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:02:48 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:02:48 +0000
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
Subject: [RFC v1 013/256] cl8k: add band.c
Date:   Thu, 17 Jun 2021 15:58:20 +0000
Message-Id: <20210617160223.160998-14-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0acff10-9101-4cd5-f4ce-08d931a95a68
X-MS-TrafficTypeDiagnostic: AM0P192MB0499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB049977078A7701525A103246F60E9@AM0P192MB0499.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 972egUFNcCHlQ6xVRJ54tSk9qcr2HsqLwUvazyfGpDI3cs4Be6U5158Sx/eUc8Uz7UJ2wDQnr6GSZK6Ev024LNU4gDvxNilX4+TijenO1f0tBzFVkd4agoZrVj1LXrblM5cWRp4Q7lqHNuQYJKha2Yv1lf2zmgb1zmHNK+VMYg0cPFcZ2rY9qcNebuL4jqwBXighltSvcIDi2BFt6dVB2E1Ph1y76d2AaVaKxFNqCSeGGSY/4VhOpQ47Xl4nwwkYaBZEDC7kEMSIJ8+ZcV97V8lI2shEBXYOzLFfiEdhqFNrimgBLP4mgu6xfvGFdgXudj0eNNnQPlPU2dgXUlf9BVUVvToEFSuXCwR19QYZ5gMO6/2i8uzm2Jn0AzNRVwGKPAb+YAw1RuQ5fvbJ6d6B/njNYZHcoZuCDJHTsxRA9ZeU1Md3tvtOFnUPWzjPRqdutHQtMkWDxFmlXjXXv0pa6R/Woh8T1yWBCMv9zihhclTw1nc+CGUX89vE1sqL6UEdTGQbDZ89cmALHXu3NYar8Pd7vQstTUSOgio+95c/wy6cr9sORyuM//9Btee4A6Fi62gpuFLehoug5oRvP3toLlS8UjYAeOsuII54bFi41iAGBGhaY5Vr72f3/YBhoPxyFOBFJZ/j3f/3A7aLlWV00bx5ZIJgJdpsl7E+d4uo+CpiqOB5p3bRZYokUdMcYXuNwds/9qaoJiax27humKfuVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(86362001)(107886003)(66556008)(52116002)(83380400001)(55236004)(36756003)(4326008)(186003)(16526019)(956004)(316002)(6486002)(8676002)(54906003)(38100700002)(38350700002)(66476007)(6506007)(2906002)(26005)(9686003)(6512007)(66946007)(2616005)(5660300002)(478600001)(1076003)(6666004)(8936002)(6916009)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dyHyap+RV473Y7KQRAR04wZaMIf+TBD/3zDfN14fYiYyZLfF6YdoSBGXO4BH?=
 =?us-ascii?Q?BAIhcysevu39+BMK35ton7ar3y3Oh5ARyFKw/UCUm0yWYKbo92DS1jsx2apE?=
 =?us-ascii?Q?yTc0OVKa+kHxP4dWx6nt3mxDh7QBXlXQf1CST7UDCK6PxNsKfNimQCM6Odcm?=
 =?us-ascii?Q?EvrLwM//GJaIHJlqW7mkF+/GxYsot99XlQq4833XhGNJNyiJrDG4NeoM4ASC?=
 =?us-ascii?Q?yovE2VGJ8IpWekDN4YUE21gvuvs9qw2Ev8insbU6uNiuojAvdIkeyn/PJ9tC?=
 =?us-ascii?Q?CoRe8drj0wZwfbCpMigANan19AOboMZNl/+9w/gZzgg29xj/JVThnZxg5kEA?=
 =?us-ascii?Q?BAGzoOfzVqeInhyZGcnwLEdC+9lIbTAXdmIPGmNAHjABUwd3+QEwbYtZuW6j?=
 =?us-ascii?Q?ZgNycZJLYKD1zP4JD+OTq3lp7ks3U5eKyT0AGiyaY6/gvzVziGSqN+4iveRo?=
 =?us-ascii?Q?BwmUTkaL56yNvoHlWFo5wciPYj77ixn7+EhtTAjhzsC5mnc3AStiy2Dj11GE?=
 =?us-ascii?Q?m4+t8rVUHI+NvsuA5gGMWdJoJrBUAwt21FF7kVbrzpER4aodzziwQCYKEW2+?=
 =?us-ascii?Q?9H6a0IgvxNAYD+7cbJ141Tv1bR1am103B+VdqHqcUvBJF8OT0EdcWLU4j4rv?=
 =?us-ascii?Q?F23VM6x62Q/erIC0QcrXtczXi1/SF+tuTYZI7SWftP3+PTUP9Q7UJOWXCgwO?=
 =?us-ascii?Q?+m3mjezQQlrhHA+B/gTVH6bMKS61LE4QzbpAqiziQ5Sm225YCQ1gNNkgRTMp?=
 =?us-ascii?Q?Mt5qAzQV4xd605mBLYPG/5ybqmCHiN5cJHr5DtAymRrFNZgablSbEC55XWWm?=
 =?us-ascii?Q?f5B+XAc1i6Gi0L/g4wpnFJZH93NdBDtQicbAqrozztKVihVaaQdK//86QqXS?=
 =?us-ascii?Q?OAPnIsofzgfxJf5U6/acIqwZV+BcX2ZEftEezRs+p35Gs49JkJwhK5zn9/Ay?=
 =?us-ascii?Q?MW/gNFNRoVyfU9yenT0wynJLkXIcDAMIbjbwX5KRBGt1s88oXkwMdE56TvqE?=
 =?us-ascii?Q?ak+QuAE5ubO/iUSWAKZ/r1T/3H5bdyoX9lMHMtu42XMeh9i0CyHlNghgeVsp?=
 =?us-ascii?Q?AXYH6E9/ZCtOt2wkr1moptih3PzdFJDaTRtdbAKEyrzqNEAmEp+jKK2RSMfe?=
 =?us-ascii?Q?ZXbQY8zTSrS6PdFJZMDvFZ3kFNFR7DxIybbjdmfXn/rNpFbEX+TgDmQ65ucg?=
 =?us-ascii?Q?BapQD8N7LXcTLPUG1xl7Niwu3runeslOgKApsOQcK8Bfum6LYjR/kKHbBrAF?=
 =?us-ascii?Q?DQ67Di2MdoAWfNVryRN34ZntJ8eFbY+/h0TpS+fHNhqcDLyUjxbFGrBjcT8W?=
 =?us-ascii?Q?/h7p8NftYbbWH6xMCQobhbiJ?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0acff10-9101-4cd5-f4ce-08d931a95a68
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:02:48.7031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73XSNjQD939SEcMq73Aj3++xy7PxjeKqflSfY0fg9at9aBV6DI+80X1xMJT1kGKPHp7VClFhSRbC6b1nm8nD8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0499
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/band.c | 60 +++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/band.c

diff --git a/drivers/net/wireless/celeno/cl8k/band.c b/drivers/net/wireless=
/celeno/cl8k/band.c
new file mode 100644
index 000000000000..6fc688613a51
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/band.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "band.h"
+
+bool cl_band_is_6g(struct cl_hw *cl_hw)
+{
+       return (cl_hw->conf->ci_band_num =3D=3D 6);
+}
+
+bool cl_band_is_6g_freq(u16 freq)
+{
+       return (freq > 5935) ? true : false;
+}
+
+bool cl_band_is_5g(struct cl_hw *cl_hw)
+{
+       return (cl_hw->conf->ci_band_num =3D=3D 5);
+}
+
+bool cl_band_is_5g_freq(u16 freq)
+{
+       return (freq > 5000 && freq <=3D 5835) ? true : false;
+}
+
+bool cl_band_is_24g(struct cl_hw *cl_hw)
+{
+       return (cl_hw->conf->ci_band_num =3D=3D 24);
+}
+
+bool cl_band_is_24g_freq(u16 freq)
+{
+       return (freq < 5000) ? true : false;
+}
+
+u8 cl_band_to_fw_idx(struct cl_hw *cl_hw)
+{
+       if (cl_hw->nl_band =3D=3D NL80211_BAND_6GHZ)
+               return FW_BAND_6GHZ;
+
+       if (cl_hw->nl_band =3D=3D NL80211_BAND_5GHZ)
+               return FW_BAND_5GHZ;
+
+       return FW_BAND_2GHZ;
+}
+
+static u8 fw_to_nl_band[FW_BAND_MAX] =3D {
+       [FW_BAND_6GHZ] =3D NL80211_BAND_6GHZ,
+       [FW_BAND_5GHZ] =3D NL80211_BAND_5GHZ,
+       [FW_BAND_2GHZ] =3D NL80211_BAND_2GHZ,
+};
+
+u8 cl_band_from_fw_idx(u32 phy_band)
+{
+       if (phy_band < FW_BAND_MAX)
+               return fw_to_nl_band[phy_band];
+
+       return FW_BAND_MAX;
+}
+
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

