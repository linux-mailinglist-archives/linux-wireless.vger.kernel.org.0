Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAE23AB825
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbhFQQFN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:13 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:38880
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233544AbhFQQFB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhUeac6Fq5ReQjP4zpBM0ihHy35dXdgECd0D9mSUKhdW3C+Lkut8PdVF54DnF8EaLqOB6za8WtJ9uy2G76uVaB9v01pIhcii3fwF+y7YLVct9NXjWhy6w6H7FLaQioG12ot59P2RqZ3yKW58zFuNY0oIrjoeXTQ+FOw8HZ/v11bUHfYB7W3/vDSsJIQD5/gd86hnAzCeQJbCkb1gvsumBBIubf9jZxzoxwGfzuTOQFfHG1/5pZUEeEv/H8K2nHIzF6DJOERLIoNhoL0qM9Cf3HXxNCUx65tF8blMP0SjmS4QXewQghA7Aqg+aNpEecGa8onqytSmUzFNRQg7AyPWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntQVhnnCY+TGE5eAEDDAqLtm7VUEeochPaq4ND09qlE=;
 b=LNoLTMASKZoz05I6FlzpGtgFf/a2vk5DlMQDYBguNJB+qpPFrAfQborMOZjvPPuG+xwUpGk+Us3i52kS1CbL3KIQmm9y5o4OSHLAn7kdkinHkg/vBtJsOD1cUDXRXiMNw6F9/CmVhWiRxkt29TptJMbTeCuQ+6XMX8e3XiCcuXyR3Wu/8DzP7EQ5ydCx45HRSEsdOVCi++KyaOKZE55kP/rCWAbF2KoJUNfGfZcZzbdrpI9b0nRvrKXhvl5tZ3ChcSiyjvf9i5JIF7SpyWl9xqe4XVQSsQDFAqVEvExUwc01bcv8MgEb6fN8Hbk9cFsv0txk0hE3Eg4le3wdk9aM+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntQVhnnCY+TGE5eAEDDAqLtm7VUEeochPaq4ND09qlE=;
 b=wXBjW7yJIqkeOZ5Z0wAuGbf6zpdej6RdBZK3m+PFn/uI1vd9ckoSEVkM66cYVbKozASRpxV6Z61FvfXjCFEH7j+QxgNmfSLygV02SOJSf8H61Co0eCHyrmD5BBJHr4YxOr1MbJgRDlbSpZAGADkXQ5u2wQYFBQeRPJ48oO6kmog=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0499.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:02:49 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:02:49 +0000
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
Subject: [RFC v1 014/256] cl8k: add band.h
Date:   Thu, 17 Jun 2021 15:58:21 +0000
Message-Id: <20210617160223.160998-15-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c12f8883-fe93-4480-b32f-08d931a95b02
X-MS-TrafficTypeDiagnostic: AM0P192MB0499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB04995DD9E0B671643537BA14F60E9@AM0P192MB0499.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A0TTErK8Q9ujRDSgE9DNLbd1OEDAEu8K/Zk3xTlSDb6/RLekJLzprFzhTb8YmsTrzeMA+5FXJK5rA7KiFaaLGfsbYV48/yG1IO7IFNOfhISiZ4SkvIJy6NnLLUIu4B+fRRspPPyLJJnLXlfU8QAG0UcA7dzSaRG37b/PJTkYA01w4AwDVaxaNEcdcmCMQxyG2IP8kNqhCZuypORfsatQty5sD4BkspejdWDtNQ3LjCOBc3c202Ja3BKQuHkrqs6e4Bb3aIoeMbAllGsMUIey35TiQYVVIG2LqTIip6Fz19xENaxU1Oqee538SfMFUlkQgAVN4CUc38DTs9fXo5tvrBmSWaO9o8FuKG1SJbSazAONYq71dyUYakLxzBIpFR8xTuFLcWCHs/wPnILJIuKkeatGX3Gi1AEgINdTVmOXH8y7bQgymQP91Xjl2cCBEUMKA8gNcpuJ9KcAotojwC4l3sX2CM2s1mjPrk2iPtxJ8zRqj7gCcZ/yfrsrHPdiheMl9Nmb0IqCSSY/ahm2m5zRfGw146ncYxnbsnd+XEuOwIuZE1N6ivRaY0FT5745WY3ZPIq+mLogyRCOdEDSfilYfBT1a9ASDe51JFVH2+k1MWudVvV/y1nxtd/AgA02MZgZbC2xnx+imxOo0e5/rquehhkTDblIdyXY9UBfAw8CsL7UC5xZRUBsYcBzPfMYBBSPE5tdR0uzvYGqUO4WLPYtLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(86362001)(107886003)(66556008)(52116002)(83380400001)(55236004)(36756003)(4326008)(186003)(16526019)(956004)(316002)(6486002)(8676002)(54906003)(38100700002)(38350700002)(66476007)(6506007)(2906002)(26005)(9686003)(6512007)(66946007)(2616005)(5660300002)(478600001)(1076003)(6666004)(8936002)(6916009)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YT7IhFLSZ+fB4XX89G0EQt1YXTZKRLsJh7Ll5VITDAdphrdtjrUWogZVi1Xe?=
 =?us-ascii?Q?kymR6YF5p9Wt24DbQfYj57pw5tEAV5y4SWksqTLGD9/3MeLLDK+1QYKAoH9r?=
 =?us-ascii?Q?5l3GmDd/5V6aNaW88GfTZgM3UsQvscu/D1X/RO60r+YgJrheSaacE9hO5DJU?=
 =?us-ascii?Q?0aJo6muAV8VYP5Qal8d51hmhPp1ppGUhEI9txJXMfkX3/i2frMQF6FD5QkwJ?=
 =?us-ascii?Q?cijqSHixMsD7qMsIGJBsuOhuWOeO87sKENorBW859XNO9saj1TrTtNwIAh7G?=
 =?us-ascii?Q?KLTChbSGdQYYiUEHAVd2SkfRlCpCaCIoRWiIqRLs4ejW3Rmgp2RNyCu4W+Xu?=
 =?us-ascii?Q?3pO4i40VXmI1wQPIBrr1SaF3cXWA3LJsRnExrdJOQEkVBNe0ns3+RoUV67RS?=
 =?us-ascii?Q?EXCFJ187ULNQOom7bM1obr1PfHjZpaEnk2D3mSdPNJG9iBL7UbeU2r80gA4c?=
 =?us-ascii?Q?b8565GummkA8HwJ16YDYNKIcMwxR63y8lu5t4NFH/CkxpLyX9KVq7WRmohm7?=
 =?us-ascii?Q?40ZE/ID/H4InffVxGVgGK5u2mPLpfF9rcGGY8eLkcWwisNmqmZUfJzaeZGY8?=
 =?us-ascii?Q?aifARjhDogl9ugkAmmcKplFTifZLpFfUftnyJqB6Unr3mDvMeEAtomC1p0ml?=
 =?us-ascii?Q?86xFearP6UGGS3CYdiAcCI4xL+Ug9ENVlvH1mWhdg9g5KsUM0CkkJlabezdm?=
 =?us-ascii?Q?EScLRupbNmHdHaiczzdTu8h/0NBk6Z0tUYVsGPbB7rP0MvNgH+Q4FmmsYFpN?=
 =?us-ascii?Q?IyjSQPesp8XuayqkPPoVoAlrMeq2GLDWKjlJEygJiQ1vkoBQxjkuS5O7Aprv?=
 =?us-ascii?Q?dru25w7PDygkYa7R2+IEkYnkVMK1cE21Os7pAyylwmTHefo9scLlU3qVSrMP?=
 =?us-ascii?Q?Mm9PuNixMYZzOdwKfmNpzENQ0rP8y/SCE0/CRaMcxxLoMPiXV0KhjNEpV7ly?=
 =?us-ascii?Q?NqDlZ7qqWAGlRHuk55FGeEC4NVrAlN+rDhceopAcF1tvZhJ7+ysCjVro+rPs?=
 =?us-ascii?Q?8MraFUJ1XNHOZ92+mbmfdtJCNcQyAbulDg55Gp3ow5XdIsk9zFlIODgVcQ7u?=
 =?us-ascii?Q?dMDy7NPoAhILYHRBK20zGM8GXLJzlGZeGIjplqrigrRz2fgsbHCiNnqi6Vt4?=
 =?us-ascii?Q?JddaGh1llzFsFVPrAxOEjSk7sefWM4ZU0C0x4UdBUhipV5ah5K++4cfVwxha?=
 =?us-ascii?Q?VJt+k/6Dhahuub8IXsAtcz4wThJd5TB3MlmmvokxpfzoeXqZWoZFxMZho/W6?=
 =?us-ascii?Q?9WUV2c2aNfh0OgIABP/DGpoD8XG/DIatFJZMewyA+LDSE8J/nmXokKoNHNAT?=
 =?us-ascii?Q?jINScaVQf3rGO2tbtQgt+9Ae?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c12f8883-fe93-4480-b32f-08d931a95b02
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:02:49.7217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fSMM7C/GZlBtoW/jO37lDrGsl0wos9vm0NAKT5edEYIOraDWcaP2oZBFvuhykVC8NT2surXkZ0vjnAxCpLm7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0499
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/band.h | 40 +++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/band.h

diff --git a/drivers/net/wireless/celeno/cl8k/band.h b/drivers/net/wireless=
/celeno/cl8k/band.h
new file mode 100644
index 000000000000..9642432bed0f
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/band.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_BAND_H
+#define CL_BAND_H
+
+#include "hw.h"
+
+enum c_fw_band {
+       FW_BAND_2GHZ,
+       FW_BAND_5GHZ,
+       FW_BAND_6GHZ,
+
+       FW_BAND_MAX,
+};
+
+#define BAND_6G  6
+#define BAND_5G  5
+#define BAND_24G 24
+
+#define BAND_TO_STR(band) \
+               ((band) =3D=3D 6 ? "6G" : \
+               ((band) =3D=3D 5 ? "5G" : "24G"))
+
+#define BAND_IS_5G_6G(cl_hw) \
+               (cl_band_is_5g(cl_hw) || cl_band_is_6g(cl_hw))
+
+bool cl_band_is_6g(struct cl_hw *cl_hw);
+bool cl_band_is_6g_freq(u16 freq);
+
+bool cl_band_is_5g(struct cl_hw *cl_hw);
+bool cl_band_is_5g_freq(u16 freq);
+
+bool cl_band_is_24g(struct cl_hw *cl_hw);
+bool cl_band_is_24g_freq(u16 freq);
+
+u8 cl_band_to_fw_idx(struct cl_hw *cl_hw);
+u8 cl_band_from_fw_idx(u32 phy_band);
+
+#endif /* CL_BAND_H */
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

