Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F373AB842
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbhFQQGH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:07 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:15895
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233632AbhFQQFy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nudzWLh7AaVdP3lg1u5hlMwuel4Cs0bmurPKgyTLWUT1BMaIHQeNqpTHc0BPu/m2+q9PhJL0VizOVeZUJ62SYboOeKRmOtV86Kmgu3aF9Qn+0yydNzbHSMtyFAbpjZm8LiYYXhxZhfvfBhexSMqpxvtbIxb2FVRhmYAXMC1iEEH4nK6ez+9HddIS339YQevmz8SADKIQQlG73pLtzQNJIY41tgsm+fNrmoPH6+MQ8eheyYX0yLv6setgZBNxcK0xJF/1qcl4mdcIRs6LP5nFnR1DH5PvCMjOWbz5NNcpvSLXOHa296SVMwlSAONP2Uwo41mItOnYYHsXQECApV20Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7ci08mEoxpzc9eFsgpylm42roCyy+zabf0Xk899ksU=;
 b=lSUtrA8KiGAngdbhlPZFB+9XmLSlgqnr0SmCWECSDGa0YTlVEEz6pnXpaGTeEKoqcMTzTS3Y56DDMprqTzaUDBoDUKQFyUXkPTid3Cw6NkM0qqlfdvaEwmy8Csh3752qVUyoPBpH4foTLKbf4HLzJ776gDBPTQgpUjjW28f5Ylbd3VQ1jtWrXjMo0LCpLKslzt8eNG33FJ1yfm22NwzpoXxW81M9/0MDWmuKnmTrmnOB+HVhj/5VQXGEuTKd4lzoYVESJtdWvx1yLpZZhU5SDnoYutV+6rsP0grx7deGof5PyLF/Q+dyjJ1v90X5h3+ZIdCRrIc4V83v+hW/6TeNiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7ci08mEoxpzc9eFsgpylm42roCyy+zabf0Xk899ksU=;
 b=pSb7FuGRENQIT+nvuGp1laKEt0eanYaWhG2B7llDKCy/eYtF8n5OvPWlgCRSou3nDl+JyQOnUtU21sbNk5pX/txZD2+nQ88CMUuaAc/2mpwdLKCLvzh2jnCZu4SjPE8SjzCXo7hVjaCgqgZ3Mw8Alc1zU00SUdMyOSrIckdCfDM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0966.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Thu, 17 Jun
 2021 16:03:41 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:41 +0000
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
Subject: [RFC v1 040/256] cl8k: add chan_info.c
Date:   Thu, 17 Jun 2021 15:58:47 +0000
Message-Id: <20210617160223.160998-41-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc1de31a-f370-4fbd-56ea-08d931a96bf4
X-MS-TrafficTypeDiagnostic: AM9P192MB0966:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB09663AFEED2587877B6EDD37F60E9@AM9P192MB0966.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RSmIPPA/SYNB4LVSnmT3B82eUMub+zcafCAlToucGHwzXtHYEvoR/MbW/tDPslFX5XPz2EgmD8+elZ7rgF6rpA9dmnZ23AN7fz+VAlJZ2wzQqizEha/VMKnqe+5DGXgkpVYDWdqJ4pQwJxBnGOec7BKhk7tIh5UpB/YLdpZjUFM3d3Q1OWxM0laQ2alwnDofWvKNbk2u/9d+tLQvtElOg2kQQajP6XVTPj0B2O9wvOp6377bs6cT3m8KIy8KbmZb4pg8BdOMrEO6ap0jHz78CFIJHbuAN9oYQipO0uCSfg8BOwEyoyN/rUV+zWxgusawRGyJjYIgb+Om2ktyZVJ7pmnhcYoH74Muscgrd63A4qKO2i6YNRcP+7yIp71Wb1y4Q5CZ3FaqDbfG7eS8MGDO32J88kCAja5YJpZ+3MPb1Bn49dCfijM3t1w4dS0odmh09yFBkNOLIJYP9arPPxPSirmSZ+aMPZ0MPYDMEdA3vLRrTJhyMtVxIWoy5Oy9MFQg9eNfRoixEfxkB91xgEkOD+apwJM6y+BVsCEeKBpS7XuSWuHTe/CBNMcf5i7mv7XRSGwn/YM2D++ZrJ/otItlhRJ0gcmoYLyZ9F7Avu0dsNP6a4DzZGWaz3tUjoP7QDy5uWeuz7DWiMyI6B5dGctU+NYyUGGYdjA+wSRJSakcFd9c6YUGlHiNYFwNPkBLsG5nybVsklj5IK82ZZ9VHeTXGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39850400004)(376002)(396003)(30864003)(4326008)(1076003)(2616005)(8676002)(186003)(6512007)(6486002)(107886003)(83380400001)(6916009)(38100700002)(55236004)(316002)(16526019)(6506007)(38350700002)(6666004)(54906003)(8936002)(26005)(508600001)(36756003)(2906002)(9686003)(52116002)(956004)(5660300002)(66946007)(66556008)(66476007)(86362001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IptBU+mpzv2sUEGREANaYNsN+g+p7zqu7YKTF8xCLjsdC3k2Det+pHp/ThGo?=
 =?us-ascii?Q?fyH60e8k6kRQb84nlJOZzUkdvaH9KV92Sa6vSZHzxS+FmVgVSn7lQ86j4JSP?=
 =?us-ascii?Q?t7NJRe7hfgAYjiq7nL2bHHPgKC3HbHani9IA0MQaHt9OOIW/EwvZB3L0cjsL?=
 =?us-ascii?Q?hbSAkugE8GeE2+eumhTbof6m2fmU2jJe9xO/A3WHA3QsDDDBUoCjK1mCG1nG?=
 =?us-ascii?Q?zVRQkPIWnD+elBv60McqCHVFbot+4i9SSOccMOCkqi21LJu0As41y7FO/JNO?=
 =?us-ascii?Q?9lSNRPc8M/88B2VQoCJXLJ/ZfuvArjBIEK39092iObDjY+cKOdnBRY053g0k?=
 =?us-ascii?Q?W86g2I8Qb5nQ9x7unhVkfByhyZegUasSpOZHxCUNjvQLV5ZSEtPKKJ1LDoLG?=
 =?us-ascii?Q?mRO4CFq2YxZMVUoyMm+mNNTZl/gpE0CXkPYAdOGzowcQC4Ay2k7HDC81/ALo?=
 =?us-ascii?Q?79L04DqspkIMXjYZmRPNMe+XRYILD5B+DhdbXst2dWhCe1m5pI1Klj/f+0fU?=
 =?us-ascii?Q?dlZh/975Xv59zdhNgg+aNsrPbjNCZNjNMNIF2zt2YsKGtiIsuwehPYBR+NMi?=
 =?us-ascii?Q?0cii8IEV6lUGhNeLZoeSMmiJIpf8/+fXiILHVV2zbYIcKuASjztZmDwK3Nno?=
 =?us-ascii?Q?B/Cx+zf/hs8WrRsSVa4kLOmGaia+yBpGARidKzlLpesD2hp9tHXVj/repoly?=
 =?us-ascii?Q?k7F//Jtsv/+6uMoavj7iDnlxRc7WPw3BxO+tF0/nWcnLYwSoaMex5k8IcnzU?=
 =?us-ascii?Q?Th9EJdOfu11FByCL8odGwWJABFWKfy85/jifLEjfMJ79SIfTXXIAso8e3lSM?=
 =?us-ascii?Q?Xn6AkB5lvDhWedJKDVUNFnQF/6ZDXUPvCDFMO9XO0pJN7hnCjJYRqMt9Cc4D?=
 =?us-ascii?Q?svyH6Xqr3xXfDzDBaplsvDncWAk60uucDU0MrspSWLxnxRXjXOS3a7M178Tv?=
 =?us-ascii?Q?ZPX8hsr6QTOw+wqBqVbYiFf2MHjwd2B8rMqFbECN2P5D/L31oXKHb/f5aG9b?=
 =?us-ascii?Q?AhOLA41zQqgVi4sLwX5KASWcKBMGnD0Pk9WP2FHxVcviH88Uc1uX8sitt6U0?=
 =?us-ascii?Q?kKzwwAACuTlv19gfaExuo+R6M3vL/ma612FJ60qPR46Ckqh6fvl+b433oSIA?=
 =?us-ascii?Q?ZW2zumtO1DXUq3TSDTh+9TZKP11jQKtOcKpLBvyZy8O0iCOsx8w5qNMfHZO1?=
 =?us-ascii?Q?XGxanstStK21hGX6fBaMYbzh5mtRaSlOJCKm1p32SF77kPlwEI7czaDVk2Go?=
 =?us-ascii?Q?LEdLd1PkSCZ3/GpCznf6szAr4SnvzsoFMMA99TWfM+KQ1haxAci/lad1U/aK?=
 =?us-ascii?Q?/0rL4SL2jDfEmmQFMdB0dKT7?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1de31a-f370-4fbd-56ea-08d931a96bf4
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:18.2972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAAULIexYicrD2C5Mm9aMua0Nh5ycCe+YaPKG41HVolDcEVoCkm3OfFcry5AE+tKCkF+qxOcyCLSD+Gv/jhqgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0966
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/chan_info.c | 852 +++++++++++++++++++
 1 file changed, 852 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/chan_info.c

diff --git a/drivers/net/wireless/celeno/cl8k/chan_info.c b/drivers/net/wir=
eless/celeno/cl8k/chan_info.c
new file mode 100644
index 000000000000..95b09128c166
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/chan_info.c
@@ -0,0 +1,852 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "chan_info.h"
+#include "utils/utils.h"
+#include "chip.h"
+#include "utils/math.h"
+#include "band.h"
+#include "utils/string.h"
+#include "channel.h"
+#include "utils/file.h"
+
+struct ieee80211_regdomain cl_regdom_24g =3D {
+       .n_reg_rules =3D 2,
+       .alpha2 =3D "99",
+       .reg_rules =3D {
+               REG_RULE(2412 - 10, 2472 + 10, 40, 6, 20, 0),
+               REG_RULE(2484 - 10, 2484 + 10, 20, 6, 20, 0),
+       }
+};
+
+struct ieee80211_regdomain cl_regdom_5g =3D {
+       .n_reg_rules =3D 1,
+       .alpha2 =3D "99",
+       .reg_rules =3D {
+               REG_RULE(5150 - 10, 5850 + 10, 80, 6, 30, 0),
+       }
+};
+
+struct ieee80211_regdomain cl_regdom_6g =3D {
+       .n_reg_rules =3D 1,
+       .alpha2 =3D "99",
+       .reg_rules =3D {
+               REG_RULE(5935 - 10, 7115 + 10, 80, 6, 30, 0),
+       }
+};
+
+static inline s32 convert_str_int_q2(s8 *str)
+{
+       s32 x, y;
+
+       if (!str)
+               return 0;
+       if (sscanf(str, "%d.%2d", &x, &y) !=3D 2)
+               return 0;
+       if (!strstr(str, "."))
+               return x * 4;
+       if (y < 10 && (*(strstr(str, ".") + 1) !=3D '0'))
+               y *=3D 10;
+       return (x * 100 + y) * 4 / 100;
+}
+
+static int cl_parse_reg_domain(struct cl_hw *cl_hw, char **str)
+{
+       /* Check if current line contains "FCC" or "ETSI" */
+       char *token =3D strsep(str, "\n");
+
+       if (!token)
+               goto err;
+
+       if (strstr(token, "FCC")) {
+               cl_hw->channel_info.standard =3D CL_STANDARD_FCC;
+               cl_dbg_info(cl_hw, "Standard =3D FCC\n");
+               return 0;
+       }
+
+       if (strstr(token, "ETSI")) {
+               cl_hw->channel_info.standard =3D CL_STANDARD_ETSI;
+               cl_dbg_info(cl_hw, "Standard =3D ETSI\n");
+               return 0;
+       }
+
+err:
+       cl_dbg_err(cl_hw, "Illegal regulatory domain\n");
+       cl_hw->channel_info.standard =3D CL_STANDARD_NONE;
+       return -1;
+}
+
+#define MAX_CC_STR 4
+#define MAX_BW_STR 8
+
+static bool cl_parse_channel_info_txt(struct cl_hw *cl_hw)
+{
+       /*
+        * Example of country information in channel_info.txt:
+        *
+        * [EU (European Union)ETSI]
+        * 2.4GHz/20MHz: 2412(1,20) 2417(2,20) 2422(3,20) 2427(4,20) 2432(5=
,20) 2437(6,20)
+        *               2442(7,20) 2447(8,20) 2452(9,20) 2457(10,20) 2462(=
11,20) 2467(12,20)
+        *               2472(13,20)
+        * 2.4GHz/40MHz: 2422(1,20) 2427(2,20) 2432(3,20) 2437(4,20) 2442(5=
,20) 2447(6,20)
+        *               2452(7,20) 2457(8,20) 2462(9,20) 2467(10,20) 2472(=
11,20)
+        * 5.2GHz/20MHz: 5180(36,23) 5200(40,23) 5220(44,23) 5240(48,23) 52=
60(52,23) 5280(56,23)
+        *               5300(60,23) 5320(64,23) 5500(100,30) 5520(104,30) =
5540(108,30)
+        *               5560(112,30)5580(116,30) 5600(120,30) 5620(124,30)=
 5640(128,30)
+        *               5660(132,30) 5680(136,30) 5700(140,30)
+        * 5.2GHz/40MHz: 5180(36,23) 5200(40,23) 5220(44,23) 5240(48,23) 52=
60(52,23) 5280(56,23)
+        *               5300(60,23) 5310(64,23) 5510(100,30) 5510(104,30) =
5550(108,30)
+        *               5550(112,30) 5590(116,30) 5590(120,30) 5630(124,30=
) 5630(128,30)
+        *               5670(132,30) 5670(136,30)
+        * 5.2GHz/80MHz: 5180(36,23) 5200(40,23) 5220(44,23) 5240(48,23) 52=
60(52,23) 5280(56,23)
+        *               5300(60,23) 5310(64,23) 5510(100,30) 5510(104,30) =
5550(108,30)
+        *               5550(112,30) 5590(116,30) 5590(120,30) 5630(124,30=
) 5630(128,30)
+        * 5.2GHz/160MHz: 5180(36,23) 5200(40,23) 5220(44,23) 5240(48,23) 5=
260(52,23) 5280(56,23)
+        *                5300(60,23) 5310(64,23) 5510(100,30) 5510(104,30)=
 5550(108,30)
+        *                5550(112,30) 5590(116,30) 5590(120,30) 5630(124,3=
0) 5630(128,30)
+        */
+
+       struct cl_channel_info *channel_info =3D &cl_hw->channel_info;
+       char *buf =3D NULL, *ptr =3D NULL;
+       char cc_str[MAX_CC_STR] =3D {0};
+       char bw_str[MAX_BW_STR] =3D {0};
+       size_t size;
+       u8 bw, bw_mhz, bw_max, max_power, channel, i;
+
+       /* Read channel_info.txt into buf */
+       size =3D cl_file_open_and_read(cl_hw->chip, "channel_info.txt", &bu=
f);
+
+       if (!buf)
+               return false;
+
+       /* Jump to the correct country in the file */
+       snprintf(cc_str, sizeof(cc_str), "[%s", cl_hw->chip->conf->ce_count=
ry_code);
+       ptr =3D strstr(buf, cc_str);
+       if (!ptr)
+               goto out;
+
+       if (cl_parse_reg_domain(cl_hw, &ptr))
+               goto out;
+
+       /* Jump to the relevant band */
+       if (cl_band_is_24g(cl_hw)) {
+               bw_max =3D CHNL_BW_40;
+               ptr =3D strstr(ptr, "2.4GHz");
+       } else if (cl_band_is_5g(cl_hw)) {
+               ptr =3D strstr(ptr, "5.2GHz");
+               bw_max =3D CHNL_BW_160;
+       } else {
+               ptr =3D strstr(ptr, "6GHz");
+               bw_max =3D CHNL_BW_160;
+       }
+
+       for (bw =3D 0; bw <=3D bw_max; bw++) {
+               if (!ptr)
+                       goto out;
+
+               i =3D 0;
+
+               /* Jump to relevant bandwidth */
+               bw_mhz =3D BW_TO_MHZ(bw);
+               snprintf(bw_str, sizeof(bw_str), "%uMHz:", bw_mhz);
+               ptr =3D strstr(ptr, bw_str);
+
+               /* Iterate until end of line and parse (channel, max_power)=
 */
+               while (ptr && (ptr + 1) && (*(ptr + 1) !=3D '\n')) {
+                       ptr =3D strstr(ptr, "(");
+                       if (!ptr)
+                               goto out;
+
+                       if (sscanf(ptr, "(%hhu,%hhu)", &channel, &max_power=
) !=3D 2)
+                               goto out;
+
+                       if (!cl_channel_is_valid(cl_hw, channel) ||
+                           i =3D=3D cl_channel_num(cl_hw))
+                               goto out;
+
+                       channel_info->channels[bw][i].channel =3D channel;
+                       channel_info->channels[bw][i].max_power_q2 =3D max_=
power << 2;
+                       channel_info->channels[bw][i].country_max_power_q2 =
=3D max_power << 2;
+
+                       i++;
+                       ptr =3D strstr(ptr, ")");
+               }
+       }
+
+       kfree(buf);
+       return true;
+
+out:
+       kfree(buf);
+       return false;
+}
+
+static bool cl_is_parsing_success(struct cl_hw *cl_hw)
+{
+       /* Check that there is at least one channel in any bw */
+       u8 bw;
+       u8 max_bw =3D BAND_IS_5G_6G(cl_hw) ? CHNL_BW_160 : CHNL_BW_40;
+
+       for (bw =3D 0; bw <=3D max_bw; bw++)
+               if (!cl_hw->channel_info.channels[bw][0].channel)
+                       return false;
+
+       return true;
+}
+
+static void cl_chan_info_set_max_bw_6g(struct cl_hw *cl_hw)
+{
+       u8 i, bw, bw_cnt, channel, channel_gap;
+       struct cl_chan_info *chan_info;
+
+       for (bw =3D 0; bw < CHNL_BW_MAX; bw++) {
+               chan_info =3D cl_hw->channel_info.channels[bw];
+               bw_cnt =3D 0;
+
+               for (i =3D 0; i < NUM_CHANNELS_6G; i++) {
+                       channel =3D chan_info[i].channel;
+
+                       if (channel =3D=3D 0)
+                               break;
+
+                       channel_gap =3D channel - START_CHAN_IDX_6G;
+
+                       /*
+                        * Verify that we don't combine together channels
+                        * from different 80MHz sections
+                        */
+                       if ((channel_gap % CL_160MHZ_CH_GAP) =3D=3D 0)
+                               bw_cnt =3D 0;
+
+                       if (i > 0)
+                               bw_cnt++;
+
+                       /* Verify that we don't make illegal 80MHz combinat=
ion */
+                       if ((channel_gap % CL_80MHZ_CH_GAP =3D=3D 0) && bw_=
cnt =3D=3D 3)
+                               bw_cnt =3D 0;
+
+                       /* Verify that we don't make illegal 40MHz combinat=
ion */
+                       if ((channel_gap % CL_40MHZ_CH_GAP =3D=3D 0) && bw_=
cnt =3D=3D 1)
+                               bw_cnt =3D 0;
+
+                       if ((((bw_cnt + 1) % CL_160MHZ_HOP) =3D=3D 0) && bw=
 =3D=3D CHNL_BW_160) {
+                               chan_info[i].max_bw =3D CHNL_BW_160;
+                               chan_info[i - 1].max_bw =3D CHNL_BW_160;
+                               chan_info[i - 2].max_bw =3D CHNL_BW_160;
+                               chan_info[i - 3].max_bw =3D CHNL_BW_160;
+                               chan_info[i - 4].max_bw =3D CHNL_BW_160;
+                               chan_info[i - 5].max_bw =3D CHNL_BW_160;
+                               chan_info[i - 6].max_bw =3D CHNL_BW_160;
+                               chan_info[i - 7].max_bw =3D CHNL_BW_160;
+                       } else if ((((bw_cnt + 1) % CL_80MHZ_HOP) =3D=3D 0)=
 && (bw =3D=3D CHNL_BW_80)) {
+                               chan_info[i].max_bw =3D CHNL_BW_80;
+                               chan_info[i - 1].max_bw =3D CHNL_BW_80;
+                               chan_info[i - 2].max_bw =3D CHNL_BW_80;
+                               chan_info[i - 3].max_bw =3D CHNL_BW_80;
+                       } else if ((((bw_cnt + 1) % CL_40MHZ_HOP) =3D=3D 0)=
 && (bw >=3D CHNL_BW_40)) {
+                               chan_info[i].max_bw =3D CHNL_BW_40;
+                               chan_info[i - 1].max_bw =3D CHNL_BW_40;
+                       } else {
+                               chan_info[i].max_bw =3D CHNL_BW_20;
+                       }
+               }
+       }
+}
+
+static void cl_chan_info_set_max_bw_5g(struct cl_hw *cl_hw)
+{
+       u8 i, bw, bw_cnt, channel, channel_gap;
+       struct cl_chan_info *chan_info;
+
+       for (bw =3D 0; bw < CHNL_BW_MAX; bw++) {
+               chan_info =3D cl_hw->channel_info.channels[bw];
+               bw_cnt =3D 0;
+
+               for (i =3D 0; i < NUM_CHANNELS_5G; i++) {
+                       channel =3D chan_info[i].channel;
+
+                       if (channel =3D=3D 0)
+                               break;
+
+                       if (channel < 149)
+                               channel_gap =3D channel - 36;
+                       else
+                               channel_gap =3D channel - 149;
+
+                       /*
+                        * Verify that we don't combine together channels f=
rom
+                        * different 80MHz sections
+                        * (i.e. 36-48 can be combined into 80MHz channels,=
 unlike 40-52)
+                        */
+                       if ((channel_gap % CL_160MHZ_CH_GAP) =3D=3D 0)
+                               bw_cnt =3D 0;
+
+                       /* Check if 20MHz channels can be combined into 40M=
Hz or 80MHz channels */
+                       if (i > 0) {
+                               /*
+                                * Verify that we don't combine together un=
secutive channels
+                                * (like 36 and 44 when 40 is missing)
+                                */
+                               if ((chan_info[i].channel - chan_info[i - 1=
].channel) >
+                                   CL_20MHZ_CH_GAP)
+                                       bw_cnt =3D 0;
+                               else
+                                       bw_cnt++;
+                       }
+
+                       /* Verify that we don't make illegal 80MHz combinat=
ion (like 44-56) */
+                       if ((channel_gap % CL_80MHZ_CH_GAP =3D=3D 0) && bw_=
cnt =3D=3D 3)
+                               bw_cnt =3D 0;
+
+                       /* Verify that we don't make illegal 40MHz combinat=
ion (like 40-44) */
+                       if ((channel_gap % CL_40MHZ_CH_GAP =3D=3D 0) && bw_=
cnt =3D=3D 1)
+                               bw_cnt =3D 0;
+
+                       if ((((bw_cnt + 1) % CL_160MHZ_HOP) =3D=3D 0) && bw=
 =3D=3D CHNL_BW_160) {
+                               chan_info[i].max_bw =3D CHNL_BW_160;
+                               chan_info[i - 1].max_bw =3D CHNL_BW_160;
+                               chan_info[i - 2].max_bw =3D CHNL_BW_160;
+                               chan_info[i - 3].max_bw =3D CHNL_BW_160;
+                               chan_info[i - 4].max_bw =3D CHNL_BW_160;
+                               chan_info[i - 5].max_bw =3D CHNL_BW_160;
+                               chan_info[i - 6].max_bw =3D CHNL_BW_160;
+                               chan_info[i - 7].max_bw =3D CHNL_BW_160;
+                       } else if ((((bw_cnt + 1) % CL_80MHZ_HOP) =3D=3D 0)=
 && bw =3D=3D CHNL_BW_80) {
+                               chan_info[i].max_bw =3D CHNL_BW_80;
+                               chan_info[i - 1].max_bw =3D CHNL_BW_80;
+                               chan_info[i - 2].max_bw =3D CHNL_BW_80;
+                               chan_info[i - 3].max_bw =3D CHNL_BW_80;
+                       } else if ((((bw_cnt + 1) % CL_40MHZ_HOP) =3D=3D 0)=
 && bw >=3D CHNL_BW_40) {
+                               chan_info[i].max_bw =3D CHNL_BW_40;
+                               chan_info[i - 1].max_bw =3D CHNL_BW_40;
+                       } else {
+                               chan_info[i].max_bw =3D CHNL_BW_20;
+                       }
+               }
+       }
+}
+
+static void cl_chan_info_set_max_bw_24g(struct cl_hw *cl_hw)
+{
+       u8 i, bw, channel;
+       struct cl_chan_info *chan_info;
+
+       for (bw =3D 0; bw < CHNL_BW_80; bw++) {
+               chan_info =3D cl_hw->channel_info.channels[bw];
+
+               for (i =3D 0; i < NUM_CHANNELS_24G; i++) {
+                       channel =3D chan_info[i].channel;
+
+                       if (channel =3D=3D 0)
+                               break;
+
+                       if (channel < 14)
+                               chan_info[i].max_bw =3D CHNL_BW_40;
+                       else
+                               chan_info[i].max_bw =3D CHNL_BW_20;
+               }
+       }
+}
+
+static void cl_chan_info_set_max_bw(struct cl_hw *cl_hw)
+{
+       if (cl_band_is_6g(cl_hw))
+               cl_chan_info_set_max_bw_6g(cl_hw);
+       else if (cl_band_is_5g(cl_hw))
+               cl_chan_info_set_max_bw_5g(cl_hw);
+       else
+               cl_chan_info_set_max_bw_24g(cl_hw);
+}
+
+static void cl_chan_info_dbg(struct cl_hw *cl_hw)
+{
+       struct cl_chan_info *chan_info;
+       u32 max_power_integer, max_power_fraction;
+       u8 i, j;
+
+       for (i =3D 0; i < CHNL_BW_MAX; i++) {
+               cl_dbg_info(cl_hw, "Bandwidth =3D %uMHz\n", BW_TO_MHZ(i));
+               for (j =3D 0; j < cl_channel_num(cl_hw); j++) {
+                       chan_info =3D &cl_hw->channel_info.channels[i][j];
+
+                       if (chan_info->channel =3D=3D 0)
+                               continue;
+
+                       max_power_integer =3D (chan_info->max_power_q2 / 4)=
;
+                       max_power_fraction =3D
+                               (100 * (chan_info->max_power_q2 - 4 * max_p=
ower_integer) / 4);
+
+                       cl_dbg_info(cl_hw, "Channel =3D %u, max EIRP =3D %3=
u.%02u, bw =3D %uMHz\n",
+                                   chan_info->channel, max_power_integer,
+                                   max_power_fraction, BW_TO_MHZ(chan_info=
->max_bw));
+               }
+       }
+}
+
+/* Band 6G - default power */
+#define UNII_5_POW_Q2     (27 << 2)
+#define UNII_6_POW_Q2     (27 << 2)
+#define UNII_7_POW_Q2     (27 << 2)
+#define UNII_8_POW_Q2     (27 << 2)
+
+/* Band 5G - default power */
+#define UNII_1_POW_Q2     (22 << 2)
+#define UNII_2_POW_Q2     (27 << 2)
+#define UNII_2_EXT_POW_Q2 (27 << 2)
+#define UNII_3_POW_Q2     (27 << 2)
+
+/* Band 2.4G - default power */
+#define BAND_24G_POW_Q2   (36 << 2)
+
+static void cl_fill_channel_info(struct cl_hw *cl_hw, u8 bw, u8 ch_idx, u8=
 channel,
+                                u8 country_max_power_q2, u8 max_power_q2)
+{
+       struct cl_channel_info *channel_info =3D &cl_hw->channel_info;
+
+       channel_info->channels[bw][ch_idx].channel =3D channel;
+       channel_info->channels[bw][ch_idx].country_max_power_q2 =3D country=
_max_power_q2;
+       channel_info->channels[bw][ch_idx].max_power_q2 =3D max_power_q2;
+}
+
+static void cl_set_default_channel_info_6g(struct cl_hw *cl_hw)
+{
+       u8 i, j, k;
+
+       for (i =3D 0; i < CHNL_BW_MAX; i++) {
+               k =3D 0;
+
+               /* Ch2 is a special case */
+               cl_fill_channel_info(cl_hw, i, k, 2, UNII_5_POW_Q2, UNII_5_=
POW_Q2);
+               k++;
+
+               for (j =3D START_CHAN_IDX_UNII5; j <=3D END_CHAN_IDX_UNII5;=
 j +=3D 4) {
+                       cl_fill_channel_info(cl_hw, i, k, j, UNII_5_POW_Q2,=
 UNII_5_POW_Q2);
+                       k++;
+               }
+
+               for (j =3D START_CHAN_IDX_UNII6; j <=3D END_CHAN_IDX_UNII6;=
 j +=3D 4) {
+                       cl_fill_channel_info(cl_hw, i, k, j, UNII_6_POW_Q2,=
 UNII_6_POW_Q2);
+                       k++;
+               }
+
+               for (j =3D START_CHAN_IDX_UNII7; j <=3D END_CHAN_IDX_UNII7;=
 j +=3D 4) {
+                       cl_fill_channel_info(cl_hw, i, k, j, UNII_7_POW_Q2,=
 UNII_7_POW_Q2);
+                       k++;
+               }
+
+               for (j =3D START_CHAN_IDX_UNII8; j <=3D END_CHAN_IDX_UNII8;=
 j +=3D 4) {
+                       /* Channel 233 is valid only in 20MHz */
+                       if (i !=3D CHNL_BW_20 && j =3D=3D END_CHAN_IDX_UNII=
8)
+                               break;
+
+                       cl_fill_channel_info(cl_hw, i, k, j, UNII_8_POW_Q2,=
 UNII_8_POW_Q2);
+                       k++;
+               }
+       }
+}
+
+static void cl_set_default_channel_info_5g(struct cl_hw *cl_hw)
+{
+       u8 i, j, k;
+
+       for (i =3D 0; i < CHNL_BW_MAX; i++) {
+               k =3D 0;
+
+               for (j =3D 36; j <=3D 48; j +=3D 4) {
+                       cl_fill_channel_info(cl_hw, i, k, j, UNII_1_POW_Q2,=
 UNII_1_POW_Q2);
+                       k++;
+               }
+
+               for (j =3D 52; j <=3D 64; j +=3D 4) {
+                       cl_fill_channel_info(cl_hw, i, k, j, UNII_2_POW_Q2,=
 UNII_2_POW_Q2);
+                       k++;
+               }
+
+               for (j =3D 100; j <=3D 144; j +=3D 4) {
+                       /* 160MHz is supported only in channel 36 - 64 and =
100 - 128 */
+                       if (i =3D=3D CHNL_BW_160 && j =3D=3D 132)
+                               return;
+
+                       cl_fill_channel_info(cl_hw, i, k, j, UNII_2_EXT_POW=
_Q2, UNII_2_EXT_POW_Q2);
+                       k++;
+               }
+
+               for (j =3D 149; j <=3D 165; j +=3D 4) {
+                       /* Channel 165 is valid only in 20MHz */
+                       if (i !=3D CHNL_BW_20 && j =3D=3D 165)
+                               break;
+
+                       cl_fill_channel_info(cl_hw, i, k, j, UNII_3_POW_Q2,=
 UNII_3_POW_Q2);
+                       k++;
+               }
+       }
+}
+
+static void cl_set_default_channel_info_24g(struct cl_hw *cl_hw)
+{
+       u8 i, j;
+
+       for (i =3D 0; i <=3D CHNL_BW_40; i++)
+               for (j =3D 0; j < 13; j++)
+                       cl_fill_channel_info(cl_hw, i, j, j + 1, BAND_24G_P=
OW_Q2, BAND_24G_POW_Q2);
+}
+
+static void cl_set_default_channel_info(struct cl_hw *cl_hw)
+{
+       struct cl_channel_info *channel_info =3D &cl_hw->channel_info;
+
+       memset(channel_info->channels, 0, sizeof(channel_info->channels));
+
+       channel_info->standard =3D CL_STANDARD_FCC;
+
+       if (cl_band_is_6g(cl_hw))
+               cl_set_default_channel_info_6g(cl_hw);
+       else if (cl_band_is_5g(cl_hw))
+               cl_set_default_channel_info_5g(cl_hw);
+       else
+               cl_set_default_channel_info_24g(cl_hw);
+}
+
+static u8 cl_regulatory_domain_max_power(struct cl_hw *cl_hw, int idx)
+{
+       u8 bw =3D 0;
+       u8 max_power =3D 0;
+       struct cl_channel_info *chan_info =3D &cl_hw->channel_info;
+
+       for (bw =3D CHNL_BW_20; bw < CHNL_BW_MAX; bw++) {
+               u8 power =3D chan_info->channels[bw][idx].country_max_power=
_q2;
+
+               if (max_power < power)
+                       max_power =3D power;
+       }
+
+       /* Translate from country_power (.25dBm) to max_power (1dBm) */
+       return (max_power >> 2);
+}
+
+static int cl_regulatory_domain_update_rule(struct cl_hw *cl_hw, int freq,=
 int power)
+{
+       struct ieee80211_regdomain *rd =3D cl_hw->channel_info.rd;
+       struct ieee80211_reg_rule *reg_rule =3D &rd->reg_rules[rd->n_reg_ru=
les - 1];
+       struct ieee80211_power_rule *power_rule =3D &reg_rule->power_rule;
+
+       reg_rule->freq_range.end_freq_khz =3D MHZ_TO_KHZ(freq + 10);
+       if (power_rule->max_eirp < DBM_TO_MBM(power))
+               power_rule->max_eirp =3D DBM_TO_MBM(power);
+
+       return (reg_rule->freq_range.end_freq_khz -
+               reg_rule->freq_range.start_freq_khz);
+}
+
+static void cl_regulatory_domain_add_rule(struct cl_hw *cl_hw, int freq, i=
nt max_power, u8 bw)
+{
+       struct ieee80211_regdomain *rd =3D cl_hw->channel_info.rd;
+       struct ieee80211_reg_rule *reg_rule =3D &rd->reg_rules[rd->n_reg_ru=
les];
+       struct ieee80211_freq_range *freq_range =3D &reg_rule->freq_range;
+       struct ieee80211_power_rule *power_rule =3D &reg_rule->power_rule;
+
+       freq_range->start_freq_khz =3D MHZ_TO_KHZ(freq - 10);
+       freq_range->end_freq_khz =3D MHZ_TO_KHZ(freq + 10);
+       freq_range->max_bandwidth_khz =3D BW_TO_KHZ(bw);
+
+       power_rule->max_eirp =3D DBM_TO_MBM(max_power);
+       power_rule->max_antenna_gain =3D DBI_TO_MBI(3);
+
+       rd->n_reg_rules++;
+}
+
+static void cl_regulatory_domain_set(struct cl_hw *cl_hw)
+{
+       int j =3D 0;
+       int diff =3D 0;
+       int power =3D 0, prev_power =3D 0;
+       u8 bw =3D 0, prev_bw =3D 0;
+       int freq =3D 0, prev_freq =3D 0;
+       u8 chan =3D 0;
+       struct ieee80211_regdomain *rd =3D cl_hw->channel_info.rd;
+
+       memcpy(rd->alpha2, cl_hw->chip->conf->ce_country_code, 2);
+
+       if (cl_hw->channel_info.standard =3D=3D CL_STANDARD_FCC)
+               rd->dfs_region =3D NL80211_DFS_FCC;
+       else if (cl_hw->channel_info.standard =3D=3D CL_STANDARD_ETSI)
+               rd->dfs_region =3D NL80211_DFS_ETSI;
+       else
+               rd->dfs_region =3D NL80211_DFS_UNSET;
+
+       for (j =3D 0; j < cl_channel_num(cl_hw); j++) {
+               chan =3D cl_hw->channel_info.channels[CHNL_BW_20][j].channe=
l;
+               if (!chan)
+                       continue;
+               power =3D cl_regulatory_domain_max_power(cl_hw, j);
+               bw =3D cl_chan_info_get_max_bw(cl_hw, chan);
+               freq =3D ieee80211_channel_to_frequency(chan, cl_hw->nl_ban=
d);
+               if (freq - prev_freq > 20 ||
+                   (prev_power !=3D power && diff >=3D BW_TO_KHZ(bw)) ||
+                   prev_bw !=3D bw) {
+                       cl_regulatory_domain_add_rule(cl_hw, freq, power, b=
w);
+                       diff =3D 0;
+               } else {
+                       diff =3D cl_regulatory_domain_update_rule(cl_hw, fr=
eq, power);
+               }
+
+               prev_freq =3D freq;
+               prev_power =3D power;
+               prev_bw =3D bw;
+       }
+}
+
+/*
+ * cl_hardware_power_table_update: Applies individual regulatory table ent=
ry
+ *   Inputs: cl_hw      - pointer to cl_hw
+ *           bw_mhz     - current bandwidth in MHz
+ *           chan_start - match channels greater or equal to chan_start
+ *           chan_end   - match channels less than chan_end
+ *           reg_pwr    - ensure channel_info.channels[bw][ch_idx].max_pow=
er does not exceed this
+ *   Output: updated channel_info.channels[bw][ch_idx].max_power
+ *           and channel_info.channels[bw][ch_idx].max_total_power
+ *           on all channels that match specified range
+ */
+static void cl_hardware_power_table_update(struct cl_hw *cl_hw, u8 bw_mhz,
+                                          u8 chan_start, u8 chan_end, u8 p=
wr_q2)
+{
+       struct cl_chan_info *chan_info =3D NULL;
+       u8 bw =3D 0;
+       u8 ch_idx =3D 0;
+       bool ch_found =3D false;
+       bool is_24g =3D cl_band_is_24g(cl_hw);
+
+       if (bw_mhz =3D=3D 20 || bw_mhz =3D=3D 40 || (!is_24g && (bw_mhz =3D=
=3D 80 || bw_mhz =3D=3D 160))) {
+               bw =3D MHZ_TO_BW(bw_mhz);
+       } else {
+               cl_dbg_err(cl_hw, "Invalid bw %u\n", bw_mhz);
+               return;
+       }
+
+       /* Iterate through all cl_channels[bw][ch_idx] - to find all matche=
s */
+       for (ch_idx =3D 0; ch_idx < cl_channel_num(cl_hw); ch_idx++) {
+               chan_info =3D &cl_hw->channel_info.channels[bw][ch_idx];
+
+               if (chan_start <=3D chan_info->channel && chan_info->channe=
l < chan_end) {
+                       ch_found =3D true;
+
+                       /*
+                        * Max-Power =3D
+                        * minimum between hardware_power_table and country=
 code definition
+                        */
+                       chan_info->max_power_q2 =3D min(pwr_q2, chan_info->=
max_power_q2);
+                       chan_info->hardware_max_power_q2 =3D pwr_q2;
+               }
+       }
+
+       if (!ch_found)
+               cl_dbg_info(cl_hw, "Skipping invalid channel range: %u - %u=
\n",
+                           chan_start, chan_end);
+}
+
+/*
+ * cl_hardware_power_table_parse():
+ * Iterate through hardware power table entries and apply each one.
+ * Expected format:
+ *     bw1(chan1=3Dreg_pwr1;chan2=3Dreg_pwr2;...)#bw2(chan3=3Dreg_pwr3;cha=
n4=3Dreg_pwr4;...) ...
+ * Example:
+ *     20(36=3D22.0;40=3D22.75;149=3D21.75)#40(36=3D22.5;40=3D23.0;149=3D2=
1.75)#80(36=3D21.75;40=3D21.5;149=3D22.25)
+ */
+static void cl_hardware_power_table_parse(struct cl_hw *cl_hw)
+{
+       s8 *table_str =3D NULL;
+       s8 *channel_str =3D NULL;
+       s8 *bw_set =3D NULL;
+       s8 *out_tok =3D NULL;
+       s8 *saveptr1 =3D NULL;
+       s8 *saveptr2 =3D NULL;
+       s8 in_reg_pwr[16] =3D {0};
+       u8 bw_mhz =3D 0;
+       u8 chan_start =3D 0;
+       u8 chan_end =3D 0;
+       u8 curr_pwr_q2 =3D 0;
+       u8 next_pwr_q2 =3D 0;
+
+       if (strlen(cl_hw->conf->ce_hardware_power_table) =3D=3D 0)
+               return; /* Not configured */
+
+       table_str =3D kzalloc(CL_MAX_STR_BUFFER_SIZE / 2, GFP_KERNEL);
+       if (!table_str)
+               return;
+
+       channel_str =3D kzalloc(CL_MAX_STR_BUFFER_SIZE / 2, GFP_KERNEL);
+       if (!channel_str) {
+               kfree(table_str);
+               cl_dbg_err(cl_hw, "Failed to allocate channel_str\n");
+               return;
+       }
+
+       strncpy(table_str,
+               cl_hw->conf->ce_hardware_power_table,
+               (CL_MAX_STR_BUFFER_SIZE / 2) - 1);
+
+       /* Iterate through all bandwidth sets included in table_str */
+       bw_set =3D cl_strtok_r(table_str, "#", &saveptr1);
+       while (bw_set) {
+               if (sscanf(bw_set, "%hhu(%s)", &bw_mhz, channel_str) !=3D 2=
) {
+                       bw_set =3D cl_strtok_r(NULL, "#", &saveptr1);
+                       continue;
+               }
+
+               /* Iterate through each channel in this bandwidth set */
+               chan_start =3D 0;
+               chan_end =3D 0;
+               curr_pwr_q2 =3D 0;
+               next_pwr_q2 =3D 0;
+               out_tok =3D cl_strtok_r(channel_str, ";", &saveptr2);
+
+               while (out_tok) {
+                       if (sscanf(out_tok, "%hhu=3D%s", &chan_end, in_reg_=
pwr) =3D=3D 2) {
+                               next_pwr_q2 =3D convert_str_int_q2(in_reg_p=
wr);
+
+                               /* Apply regulatory table rule. Skip initia=
l case */
+                               if (curr_pwr_q2 !=3D 0 && chan_start !=3D 0=
)
+                                       cl_hardware_power_table_update(cl_h=
w, bw_mhz, chan_start,
+                                                                      chan=
_end, curr_pwr_q2);
+
+                               /* Prepare next iteration */
+                               chan_start =3D chan_end;
+                               curr_pwr_q2 =3D next_pwr_q2;
+                       }
+                       out_tok =3D cl_strtok_r(NULL, ";", &saveptr2);
+               }
+
+               /* Handle last channel case */
+               if (next_pwr_q2 !=3D 0 && chan_start !=3D 0) {
+                       u8 chan_end;
+
+                       if (cl_band_is_6g(cl_hw))
+                               chan_end =3D 234;
+                       else if (cl_band_is_5g(cl_hw))
+                               chan_end =3D 166;
+                       else
+                               chan_end =3D 15;
+
+                       cl_hardware_power_table_update(cl_hw, bw_mhz, chan_=
start,
+                                                      chan_end, curr_pwr_q=
2);
+               }
+
+               bw_set =3D cl_strtok_r(NULL, "#", &saveptr1);
+       }
+
+       kfree(table_str);
+       kfree(channel_str);
+}
+
+void cl_chan_info_init(struct cl_hw *cl_hw)
+{
+       struct cl_channel_info *channel_info =3D &cl_hw->channel_info;
+
+       channel_info->use_channel_info =3D !cl_hw->chip->conf->ce_productio=
n_mode;
+
+       if (channel_info->use_channel_info) {
+               cl_hw->channel_info.rd =3D kzalloc(sizeof(*cl_hw->channel_i=
nfo.rd) +
+                                                NL80211_MAX_SUPP_REG_RULES=
 *
+                                                sizeof(struct ieee80211_re=
g_rule),
+                                                GFP_KERNEL);
+
+               if (!cl_hw->channel_info.rd) {
+                       cl_dbg_err(cl_hw, "memory allocation failed!\n");
+                       return;
+               }
+
+               if (!cl_parse_channel_info_txt(cl_hw) || !cl_is_parsing_suc=
cess(cl_hw)) {
+                       CL_DBG_WARNING(cl_hw, "Error parsing channel_info.t=
xt. Using default!\n");
+                       cl_set_default_channel_info(cl_hw);
+               }
+
+               cl_chan_info_set_max_bw(cl_hw);
+               cl_chan_info_dbg(cl_hw);
+               cl_regulatory_domain_set(cl_hw);
+       } else {
+               cl_set_default_channel_info(cl_hw);
+
+               if (cl_band_is_6g(cl_hw))
+                       cl_hw->channel_info.rd =3D &cl_regdom_6g;
+               else if (cl_band_is_5g(cl_hw))
+                       cl_hw->channel_info.rd =3D &cl_regdom_5g;
+               else
+                       cl_hw->channel_info.rd =3D &cl_regdom_24g;
+       }
+
+       cl_hardware_power_table_parse(cl_hw);
+}
+
+void cl_chan_info_deinit(struct cl_hw *cl_hw)
+{
+       if (cl_hw->channel_info.rd &&
+           cl_hw->channel_info.use_channel_info)
+               kfree(cl_hw->channel_info.rd);
+}
+
+struct cl_chan_info *cl_chan_info_get(struct cl_hw *cl_hw, u8 channel, u8 =
bw)
+{
+       int i =3D 0;
+       struct cl_chan_info *chan_info;
+
+       for (i =3D 0; i < cl_channel_num(cl_hw); i++) {
+               chan_info =3D &cl_hw->channel_info.channels[bw][i];
+
+               if (chan_info->channel =3D=3D channel)
+                       return chan_info;
+       }
+
+       return NULL;
+}
+
+u8 cl_chan_info_get_max_bw(struct cl_hw *cl_hw, u8 channel)
+{
+       s8 bw =3D 0;
+
+       for (bw =3D CHNL_BW_160; bw > CHNL_BW_20; bw--)
+               if (cl_chan_info_get(cl_hw, channel, bw))
+                       return (u8)bw;
+
+       return CHNL_BW_20;
+}
+
+s16 cl_chan_info_get_eirp_limit_q8(struct cl_hw *cl_hw, u8 bw)
+{
+       /* Eirp_limit =3D min(country_limit, hw_limit) */
+       struct cl_chan_info *chan_info =3D cl_chan_info_get(cl_hw, cl_hw->c=
hannel, bw);
+
+       return chan_info ? (chan_info->max_power_q2 << 6) : CL_DEFAULT_CHAN=
NEL_POWER_Q8;
+}
+
+s16 cl_chan_info_get_country_limit_q8(struct cl_hw *cl_hw, u8 channel, u8 =
bw)
+{
+       struct cl_chan_info *chan_info =3D cl_chan_info_get(cl_hw, channel,=
 bw);
+
+       return chan_info ? (chan_info->country_max_power_q2 << 6) : CL_DEFA=
ULT_CHANNEL_POWER_Q8;
+}
+
+s16 cl_chan_info_get_hardware_limit_q8(struct cl_hw *cl_hw, u8 channel, u8=
 bw)
+{
+       struct cl_chan_info *chan_info =3D cl_chan_info_get(cl_hw, channel,=
 bw);
+
+       return chan_info ? (chan_info->hardware_max_power_q2 << 6) : CL_DEF=
AULT_CHANNEL_POWER_Q8;
+}
+
+u8 cl_chan_info_get_max_power(struct cl_hw *cl_hw, u8 channel)
+{
+       struct cl_chan_info *chan_info;
+       u8 bw =3D 0;
+       u8 max_power_q2 =3D 0;
+
+       for (bw =3D 0; bw < ARRAY_SIZE(cl_hw->channel_info.channels); bw++)=
 {
+               chan_info =3D cl_chan_info_get(cl_hw, channel, bw);
+
+               if (!chan_info)
+                       continue;
+
+               if (chan_info->max_power_q2 > max_power_q2)
+                       max_power_q2 =3D chan_info->max_power_q2;
+       }
+
+       return max_power_q2 >> 2;
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

