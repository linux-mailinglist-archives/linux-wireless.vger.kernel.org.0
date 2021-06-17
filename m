Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D403AB878
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhFQQIQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:16 -0400
Received: from mail-vi1eur05on2081.outbound.protection.outlook.com ([40.107.21.81]:6112
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231301AbhFQQHi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGYmc4AQ9hPn04WMSt7Z51aKX3zSjD1SblGFk21r5qU11cxS6yRxIY5Eb1tbkNTVIvs+aHllGldek22z/HFUSwf2VxKux4NcbjwefO62RQWRAvjm8ZQHr6acHLGjgQJhqexGOttACgCf9UOGxAqTu6ysSQpF6+dOreIDI3yLeh8A6dM2YdHijRi5TSmF/7O5e1E1vBd0a6jrmRw6G4v0aCVEx7jJ1S2ADGELwmg1A3lTJxaAt/dVguiC9PbZ13Rum+n5VLJXm4YQwOG5LSHxPd7rbA+kbmQuDT/UXaPnMITUiqx+GsVKRNxB99w8yiKFvQhkYWh1jzxnk5HBn61trQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJ0ZclBiC2EUfQ6+ITuWv0D2SZ7M8GFrKwBJOGu3e4Y=;
 b=WGXMe4CpYi2L5R7//GoCN8Py5gFQ3M32D+nCy54QzTcddbIKiBGPGn66wl3OnmTcKipMbpnZ6Mdl5Xr86UKCC+aVU4YRcAKPGqLv18ocVVAk8rMRoWv49zMHRE7fIlc+ubq4gBkWRzC2c7uR3ww7ddVuVD5Hva11nIez3inKyrn4a7g0WWRMXWy3qQcy+T+YlmG17v6JpiTWxL/BCr+GHkMvHJL7WBYe28vwQtKltZlwN6o+M6XBUpTf3rUk4ShzcH4teFMHRVXx5a5vBLh3VRNHKYYVxCBdZ7ZmxrD4/H6nGPIaWgj7/LBTOdp4X8Sji23tMXgKSvwjy1yKQGoiEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJ0ZclBiC2EUfQ6+ITuWv0D2SZ7M8GFrKwBJOGu3e4Y=;
 b=gzXG24Dy5FlMPveMEbucREsm1+EL7Yb8BqW0LH7WArWE1gdiHet342T1YumYPUidGr2iSgAok1msPq9u3o0Z/Ld+3Zc3LBO1ohO3TEspO7U0nxYsR0PHWUBk+5HyTDCLH9/tRWm0AIH99543otQRwB7K33sMioU6LBCzrddMH24=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0871.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 17 Jun
 2021 16:04:28 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:28 +0000
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
Subject: [RFC v1 085/256] cl8k: add fem_common.h
Date:   Thu, 17 Jun 2021 15:59:32 +0000
Message-Id: <20210617160223.160998-86-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64f42585-e7b4-4fa5-9e37-08d931a98950
X-MS-TrafficTypeDiagnostic: AM9P192MB0871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB087132A826E9EB976C28E305F60E9@AM9P192MB0871.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vik4jK1vHPp0l8TbN/cbFeP/V1KtolF7cpQ2KjBQU5P4Pje7PMuDkG/fWz8eFkNhAzFJBpdguv104U5wRfV4cI8qLHsHX3FHyVZgRIOr3OubAVKjOd0dwFbF4Ky746gRcGMOazCib+vzfQ7uZSW87dJucjpPkgtVEeSrt/TDjn6K42osObPnzV2IcGPc4pM3e4FiyiDdNj8hlEcnJSZ/AdbxhXx6M5T7nmHijCELK9zG563b0uaBwlSTvbIZCTjXGxGgZWMosITfLNqDMXm5ASejwXNYpUB4/GvQLD0AgNXuWuhXQcV0Z1/0CAUWGg6KV3SEv1EpO7tTaM2nfW+ErXg/MpJ4gUtAbAbsznLji8oMPkTKIhJxywOJgzao6ZyeZpOxfRB+oJy3SIYymSHn5MzxsbCjAiN2HKgGl+bQA+0Pj2TPmDpR9vmrQNkbYg6if27tQDNdK/DfelJXOjS2Q2vKOfQm4Dl6KkxTEyJ6eRC9cIvbbBwwtkYTy6uRfyu7G580dR3p9XpUF1rqgBzOjXjIv/NjIJ670AjvqHpr5YYx2/F6HDzCMfQlwxRa8DxVXBM9Idmh0wtBWRYqyVZOA4Sef2T/5chKtYGjofpnw3S2pHphyING8HS7/UNZYn6ucmmG2qgjtvzPpxLGlbJQ0rh9hhTRDJKVR0ZoEx0vT+elp83iLyAuWfvadq0chWh4gEGKe1XRpV3u6mSPzRsSaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(396003)(39840400004)(16526019)(66946007)(478600001)(26005)(66476007)(6486002)(186003)(66556008)(9686003)(316002)(86362001)(6506007)(6666004)(6512007)(55236004)(38350700002)(1076003)(38100700002)(4326008)(8676002)(83380400001)(5660300002)(52116002)(2616005)(2906002)(6916009)(956004)(8936002)(107886003)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q7pvn2WCu1gImMBwqazeH5O6/GYmzwZnreHK0vof+Tl49BATlXPHeuC/8dL6?=
 =?us-ascii?Q?2a4zXJEqcTLPxegkVAM1ZTo8qrXY07lB2TWeLbgcHmS9YiESTgU4sWJGMpyA?=
 =?us-ascii?Q?tj0hEckd3TWe+TAUcxYZS3DsQHUPQ75p0sDKEbiahSsgxGRjNBohnRX4vuth?=
 =?us-ascii?Q?qGFC4ZSuMZTeYZnNX5DCR+6zx7JD9jwR7t7OkYZTEAbH9r6hWZN6vk6rZkYF?=
 =?us-ascii?Q?DsADsiiBVKbfOUCaMla+sqlodDuw67SSe0w77CwAtnIA3WiclH4/OFdLON14?=
 =?us-ascii?Q?OlxbjxfKeR0BlAMXzL70MZh+0ufzkpGOOTOZSjuZ379HPZNQx8Us77IsTIHe?=
 =?us-ascii?Q?8PAdMNBMWBXKDRzZfd3gK40vGvv7ta9p4keQlECugZ/KOTju10yoEtUOf0de?=
 =?us-ascii?Q?BLaEKcvgMXvUTzb09nLT1UkgWKIXv7Uk6cqkda2uXO9YRTo5SCAxklgIY8Gc?=
 =?us-ascii?Q?zx+or35v/oVII8SZamvVb0U4S+g/Iu1uTGhG7c8IazRFyaUsDW7HDUJlBfyN?=
 =?us-ascii?Q?XLAfOY0uMbXOtpc2kmRJdiR4x9sFWoLauHa6O6Hf3Hse3aXzz+qqqC6qSnfc?=
 =?us-ascii?Q?9tSX7L2uxg2eKaULn563A8dYh9iziOJVWuOee8vqV+8gKkt9jJntFvxWWXaR?=
 =?us-ascii?Q?lwD+8CUDA6CvFvS+YfCvaiD7pGkaWZ7AbH0EhR0wWxOoo/nV1N4PNhZL/Guu?=
 =?us-ascii?Q?b9nCCXvceD/zo7qS2NpfotWFU22QETcn9oubBn5gE57tegSDE688zkCsOkw0?=
 =?us-ascii?Q?0h6PwIh4R/AnQgvSCLs/MHQRMJHxJd8qaU1waVS0tEB4I258m5HHn5XrHiQd?=
 =?us-ascii?Q?1QFCOv4I8gIHuDVZG4tTD/AvupMj+DGjtYzU4piRWhP6dbV9gVL6ar8ujTCU?=
 =?us-ascii?Q?HQudz+0nWQxmZ3ufP5ll8eh6G6VcZk0GCtGjPNRJFTxBi9CAikk5KnirjNXc?=
 =?us-ascii?Q?VP0NzbYdH9EzUUNwlfASsPbug4ZygP2/FWdc49Vyzphl3Fr4bO0HbQlhjpSc?=
 =?us-ascii?Q?FFWLUVV1Mw4M+on0dIxdQYtXq72wPxKE2WUyVUW1MbPvxkPWaxqTkwuQSoBM?=
 =?us-ascii?Q?h2tGXmlY4996BtdC7oADAkwQoclJak4tMaWKDbvLaBpsa+eSEhXDzpSs/U2P?=
 =?us-ascii?Q?yGNPcU+5TC2aVO9sycGsI5emEi7cmBHWSmo2tOZxEwdrqPd1ezWqyaII3XUN?=
 =?us-ascii?Q?Cd/tw3LqPtLZovV/WWCdh6BAwPvSBlUhqXAl3ogQfueLo+vgb0NVQ3XoJBnl?=
 =?us-ascii?Q?pIfzAmqXVKn93aGAqoWEfQTgCbIt1cfnPvET2HqV2iDnT1bHR/2/+qwGcKma?=
 =?us-ascii?Q?Y4QX1QP8WJqkUa9G5sF0xYEV?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f42585-e7b4-4fa5-9e37-08d931a98950
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:07.4145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ateTl4QFz4BhUEgrtLkSaFrMvqG8PrT41dB7aRB9JGDQQg8tuaXv2lBssOcHGDuhxYd/BS8MyqAzXHN2DPhI+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0871
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/fem_common.h | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/fem_common.h

diff --git a/drivers/net/wireless/celeno/cl8k/fem_common.h b/drivers/net/wi=
reless/celeno/cl8k/fem_common.h
new file mode 100644
index 000000000000..9c0d165fb6b8
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/fem_common.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_FEM_COMMON_H
+#define CL_FEM_COMMON_H
+
+#define FEM_LUTS_PER_REGISTER  2
+#define FEM_LUT_AMOUNT_PER_MAC 6
+#define FEM_REGISTERS_AMOUNT   (FEM_LUT_AMOUNT_PER_MAC / FEM_LUTS_PER_REGI=
STER)
+
+/* Also needed for iw (e2p.c) in utils, so needed to be separated from the=
 other definitions. */
+enum fem_wiring_id {
+       /* TCV0 - 6 FEMs 3 wires, TCV1 - 6 FEMs 2 wires */
+       FEM_WIRING_0_TCV0_6_TCV1_6           =3D 0,
+       /* TCV0 - 6 FEMs 2 wires, TCV1 - 6 FEMs 2 wires */
+       FEM_WIRING_1_TCV0_6_TCV1_6           =3D 1,
+       /* TCV0 - 6 FEMs 2 wires, TCV1 - 6 FEMs 3 wires */
+       FEM_WIRING_2_TCV0_6_TCV1_6           =3D 2,
+       /* TCV0 - 2 FEMs 3 wires, Elastic - 4 FEMs 3 wires, TCV1 - 2 FEMs 2=
 wires */
+       FEM_WIRING_3_TCV0_2_ELASTIC_4_TCV1_2 =3D 3,
+       /* TCV0 - 2 FEMs 2 wires, Elastic - 4 FEMs 3 wires, TCV1 - 2 FEMs 2=
 wires */
+       FEM_WIRING_4_TCV0_2_ELASTIC_4_TCV1_2 =3D 4,
+       /* TCV0 - 2 FEMs 3 wires, Elastic - 4 FEMs 3 wires, TCV1 - 2 FEMs 3=
 wires */
+       FEM_WIRING_5_TCV0_2_ELASTIC_4_TCV1_2 =3D 5,
+       /* TCV0 - 2 FEMs 2 wires, Elastic - 4 FEMs 3 wires, TCV1 - 2 FEMs 3=
 wires */
+       FEM_WIRING_6_TCV0_2_ELASTIC_4_TCV1_2 =3D 6,
+       /* TCV0 - 4 FEMs 3 wires, TCV1 - 4 FEMs 2 wires */
+       FEM_WIRING_7_TCV0_4_TCV1_4           =3D 7,
+       /* TCV0 - 4 FEMs 3 wires, TCV1 - 4 FEMs 3 wires */
+       FEM_WIRING_8_TCV0_4_TCV1_4           =3D 8,
+       /* TCV0 - 4 FEMs 2 wires, TCV1 - 4 FEMs 2 wires */
+       FEM_WIRING_9_TCV0_4_TCV1_4           =3D 9,
+       /* TCV0 - 4 FEMs 3 wires, TCV1 - 4 FEMs 3 wires */
+       FEM_WIRING_10_TCV0_4_TCV1_4          =3D 10,
+       /* TCV0 - 4 FEMs 3 wires, TCV1 - 4 LNAs (RX only) */
+       FEM_WIRING_11_TCV0_4_TCV1_4_RX_ONLY  =3D 11,
+       /* TCV0 - 4 FEMs 2 wires, TCV1 - 4 LNAs (RX only) */
+       FEM_WIRING_12_TCV0_4_TCV1_4_RX_ONLY  =3D 12,
+       /* TCV0 - 6 FEMs 3 wires, TCV1 - 6 FEMs 2 wires (not active), 2 LNA=
s 1 wire (not active) */
+       FEM_WIRING_13_SENSING_4RX_2TX        =3D 13,
+       /* TCV0 - 6 FEMs 3 wires (4 active), TCV1 - 6 FEMs 2 wires (not act=
ive), 2 LNAs 1 wire */
+       FEM_WIRING_14_SENSING_4TX_2RX        =3D 14,
+       /* TCV0 - 4 FEMs 3 wires, TCV1 - 4 FEMs (RX only) */
+       FEM_WIRING_15_CHAMELEON_4TX_4RX      =3D 15,
+       /* TCV0 - 2 FEMs 3 wires, TCV1 - 2 FEMs 2 wires (CL8040) */
+       FEM_WIRING_16_TCV0_2_TCV1_2          =3D 16,
+       /* TCV0 - 4 FEMs 2 wires, TCV1 - 0 FEMs (CL8046) */
+       FEM_WIRING_17_TCV0_4_TCV1_0          =3D 17,
+       /* TCV0 - 4 FEMs 3 wires, TCV1 - 4 FEMs 3 wires */
+       FEM_WIRING_18_TCV0_4_TCV1_4          =3D 18,
+       /* TCV0 - 2 FEMs 3 wires, TCV1 - 2 FEMs 3 wires (EVB swapped) */
+       FEM_WIRING_19_TCV0_2_TCV1_2_SWAPPED  =3D 19,
+       /* TCV0 - 4 FEMs 3 wires, TCV1 - 2 FEMs 2 wires (CL8060 4+2) */
+       FEM_WIRING_20_TCV0_4_TCV1_2          =3D 20,
+       /* TCV0 - 4 FEMs 3 wires, TCV1 - 2 LNAs (RX only) (CL8066 4+2) */
+       FEM_WIRING_21_TCV0_4_TCV1_2          =3D 21,
+
+       FEM_WIRING_MAX,
+       FEM_WIRING_DEFAULT =3D 255
+};
+
+enum fem_type {
+       FEM_TYPE_TCV0    =3D 0,
+       FEM_TYPE_TCV1    =3D 1,
+       FEM_TYPE_ELASTIC =3D 2,
+       FEM_TYPE_SENSING =3D 3,
+
+       FEM_TYPE_MAX,
+};
+
+#define FEM_LUT_EMPTY 0x0
+
+#define FEM_TYPE_STR(type) \
+       ((type =3D=3D FEM_TYPE_TCV0) ? "TCV0" : \
+       ((type =3D=3D FEM_TYPE_TCV1) ? "TCV1" : \
+       ((type =3D=3D FEM_TYPE_ELASTIC) ? "ELASTIC" : \
+       ((type =3D=3D FEM_TYPE_SENSING) ? "SENSING" : "ERROR"))))
+
+#endif /* CL_FEM_COMMON_H */
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

