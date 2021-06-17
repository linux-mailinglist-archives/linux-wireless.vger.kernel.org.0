Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3F93AB822
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhFQQFI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:08 -0400
Received: from mail-eopbgr30041.outbound.protection.outlook.com ([40.107.3.41]:35801
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233527AbhFQQFA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izI7BI0JaDKZ1MGUmADX1LHTrbmfOsoZ5LHlbBptbbeQjnkiX4lLRENmRDcrtncF/h8Tq6BGdRZPeDfXL1wsNtOCp/lq7vSiWOmqyZWAsrdYEhTULxRYfgPjSD3ZTJrRSFBftPgRXYW0qN4I2v2RePjB4d0FQ358PmV3NuzQvbQ5w+rnbeHp83YtX2CTg3rMljHVIO1jswqNGb5cwKbZ28unSdc4RIIxJv5oK0PhdZVhQdMd/7tIUhnZpvdenQ36VeGP65wNz//vKraEW+qUBPkjRHBsd37VqdLNjc+vvTHd7/7OsK/mVkfpuWLELxJjm6uLe/5kARI1DDU0WWF9+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N47jMyj5bJCAtdfBCHogRzFvtxL+6krenXngJSStt+4=;
 b=dGCUuLANoNfjlG1wYpEW9a45BXlHZ89mdq6uaadWrpytHXb0wmmDxXDsnO3slOG/rMueYUfFxEDROdldjIJUEmfL2EtOE5//bxZ0aAwx8s21GFM0iJN2wF/dvFuzN3798bfZy8QF89JWf/0L0EM7/rEqgKQFpyimUxefC1RcfJZ4wDDFo/d4oRtCcHDkGdQ2Vwa9oCohM8dG+zeLhr7e1n2Y7OI3QvXH1G7UZhQ9C7PzGSQKGdBj6vo5gQiQ5vqpBV+UOfc7n6lyshiCrn2jJFt6RiuDpThDfY56adfbLuvY13g9UL87R/ezBqEOZNOUxJYelkIqGZUPXtL5cv0qgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N47jMyj5bJCAtdfBCHogRzFvtxL+6krenXngJSStt+4=;
 b=UNdwuT62xIMT/yKGhRut0c7HT2Mkh/So77mJwTTWI0+FawfuZ6oRdXPklpg4kqn6TNbrXHM6IPrScICdRrTttfP5N5NFJ7/hiylJoLESkVwVfVoX7/coCVA2eoTQqL6EDg18mHMBZsSzrYQIdHXd4HCy8G2+9EZSH7pfTAZ6W0k=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:02:42 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:02:42 +0000
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
Subject: [RFC v1 007/256] cl8k: add agc_params.c
Date:   Thu, 17 Jun 2021 15:58:14 +0000
Message-Id: <20210617160223.160998-8-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64e8f335-28be-467b-d861-08d931a95608
X-MS-TrafficTypeDiagnostic: AM9P192MB1412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB14127AD82EEC28F539686E21F60E9@AM9P192MB1412.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:298;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uK7PLuHM9sx2he/5g87ykwLr1CaxlAmDFSFX1z5PhfWxEFC0VKcTCPP/tuPaXBfIuFnT5H6KUMWo3o7jCgDgeiLqDQdXp8r+9h0YjvuYwAEAXcKlTbpEebrc4xkZltztal5DIE2ITgwnCWHrxK0rn84titkKDxMskeIqH60IYKgrUXkBocp2FomrsLvtfuHlmRELRBSDCecSNUWNzhCXW3Jtcv+xtKM3MlxL8xM1TTZ65bFNSuC/5pau8KL+bqyglVvEdiKQhbMWCtFLz5o1jrRkq9Vgyc41ZZe+6V6B2Vi7u+ypw0HlTnzCavB93RecO/I+9gtdYjnUaDqEssgz0iRzPihUCcXk/3hCPPkOT4xTlm40qT7cI5CHQEvGtjaKb7PCAwlsRPqDBPyofy9NllEmau/OgQC9rHxkAhE0c2KmQfsCHyrvu0HT5c7hKH0o+uSbwRjw7a7jqrS48ifqhoRlOUJbVbBARPOGffw5taVF5Ol3AOEj37d0ENUr+jTURXx7UhBfQiQ+OO3QB97UWSmFAFZZP0oqmRRGkPJ+noKcWikNOD/oVLObeWezVgwJtUOoC8+qvanSNmOjibcfOR1pUaV4QIW5QzaA/2W/EMopiYPr1C9826I17VAUwTwq+5vjHmJG/B1VEF68MhIqcjuZutSQEUbzkv+ruc/3MxZNNhcT+7iSEx18lThObb9JPXg9fBOBZCeOwyWWDVnpEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(376002)(39840400004)(396003)(38350700002)(9686003)(16526019)(38100700002)(6512007)(478600001)(36756003)(6506007)(52116002)(55236004)(6486002)(186003)(66556008)(2906002)(8936002)(2616005)(26005)(66946007)(956004)(66476007)(86362001)(83380400001)(107886003)(5660300002)(1076003)(6666004)(4326008)(316002)(8676002)(30864003)(6916009)(54906003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xcrp0qeLA0M4dNaFRp8xyo+nhnFP0KuUtov0gMyESLMbym9q/74NuyPFvAfy?=
 =?us-ascii?Q?/qHBkd+PZlQfogffhwM5LfsJ6u33gpAn24V0Nw01mhbLTXqdHbHp2uTs+fmF?=
 =?us-ascii?Q?l8i9VPHNQkVjCQ5lANQ+dFIWFULHB0y5zBFRrFQCYmRG3WMkaw+eN4BRhCEg?=
 =?us-ascii?Q?U700GLaLMyDWloCZ/4Xlw12HrROQeOujAJqjg9UI6jPNJ13h7VCloWGJtYOp?=
 =?us-ascii?Q?0vOjoFiN7E/wU6m1KXb6G6QPMoLp9vaV9OowiMLbGVFI1W7OjTv3w4QYk0eX?=
 =?us-ascii?Q?FJiZx/Q7FDtLNufGT5CoECS0i/7Jey/VZkod6KFzN8gBnMJDwjtWp4Gl5IvE?=
 =?us-ascii?Q?3Cj5KE8V3gwqLD89moTUkKeUvosOEKHPCOh7afUdTojXefo5c+8ItKglWd4R?=
 =?us-ascii?Q?Sk+mffUqSjEwgHnSsvG7PA7srb8pe8AOefjApapJlhJeLKalCcJFMlGmTphV?=
 =?us-ascii?Q?Q8OfL2x/BAqdlmTO87uIT+D2+5Hq8CTDQlfqGiAArhXw39EJo8ly2AsI3fc7?=
 =?us-ascii?Q?ytDZ1/JdBG10sLGihQ8xfJKZy9P+5UJ5AfdluOvXhzo6i3I+onuLhmsCyVRZ?=
 =?us-ascii?Q?QXG57raceNhq3auBHahjXRbLweN2MEsmTWj2BVI04/vKW2BM6OQS+sS2zCC2?=
 =?us-ascii?Q?bJ0At2RM5fhojyrVf6qmo+dkCDDyQXQJI/XlL4+HAqqivmSVDdP9RKbdpfZh?=
 =?us-ascii?Q?0Xg8vSuqUQh2l75jCSGTon2NygFrWGUcaMxxuOo7dUU03b6Ll78e58O1fR3n?=
 =?us-ascii?Q?RU5a+hkVRPLBzsQ7wtVYTuVJsDLIGznPt6Y0hSOZm9P9AyUV4f5+0IEWuMQ2?=
 =?us-ascii?Q?taf9SfRCwGiyj2a0GRGAv3vXRZSFTQQE+f3+i+fTARUb/meUyvrz6svSzLvu?=
 =?us-ascii?Q?Ns9AU1ZzKDkJfkgcDvGeOPvPSn4k8LLAyZTjpHrY3tiWN18ikV9+0A3oswbH?=
 =?us-ascii?Q?arKPon+57nPqbhZaIzizdP4Rdkz16PM3GecQD/3ObpUdYOckzkmi5OP2OD9L?=
 =?us-ascii?Q?K3KtorVnUlQTIibliROSt7AirvuEGjcM/TW8fxRcztjKyoE2saRe5PdLafYK?=
 =?us-ascii?Q?XJ59jvyG1q2D3wORrXo5JscRUJClccG6ym3uq/vXhGlHjbHTBE0lECygFuea?=
 =?us-ascii?Q?bX7/RKlO/YDfYpAv0TfJUp0yjTFqxx1In8Yr4SUciFyKLEy54vfNkz7QtBv4?=
 =?us-ascii?Q?aLb8nKY8T9AJCUc7pvxDpw4/RTpvL5PBKDCBW4erwT0gnRXd0wQIrj4A/hGm?=
 =?us-ascii?Q?UJoVYK2D3rSgHHSlpC6o6B9dpgwjCJdSw68dM46wpy0F9Z2TGq2Lfu+HWyJ/?=
 =?us-ascii?Q?wgLej26c+Pf4SICebBqEtaLl?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e8f335-28be-467b-d861-08d931a95608
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:02:41.6611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JA3u6Lz1MJNkOuai5PR85tNxuIqgoSH+fU9ARSnWux7tVrk/45NmhRtI18Gldp2YXFYskxGzL5VXN1KcMVp/8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1412
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/agc_params.c | 683 ++++++++++++++++++
 1 file changed, 683 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/agc_params.c

diff --git a/drivers/net/wireless/celeno/cl8k/agc_params.c b/drivers/net/wi=
reless/celeno/cl8k/agc_params.c
new file mode 100644
index 000000000000..3512defb6f18
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/agc_params.c
@@ -0,0 +1,683 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "agc_params.h"
+#include "chip.h"
+#include "hw.h"
+#include "e2p.h"
+#include "utils/utils.h"
+
+struct cl_agc_profile agc_profile_2_1_6 =3D {
+       .id                 =3D AGC_PROFILE(2, 1, 6),
+       .fsm_preset_p2      =3D { .val =3D 0x00004701, .mask =3D 0xffffffff=
 }, /* 0x244 */
+       .lna_thr_set0_ref2  =3D { .val =3D 0x2E292624, .mask =3D 0xffffffff=
 }, /* 0x25C */
+       .lna_thr_set0_ref3  =3D { .val =3D 0x00393933, .mask =3D 0xffffffff=
 }, /* 0x260 */
+       .lna_thr_set1_ref2  =3D { .val =3D 0x2E292624, .mask =3D 0xffffffff=
 }, /* 0x264 */
+       .lna_thr_set1_ref3  =3D { .val =3D 0x5D393933, .mask =3D 0xffffffff=
 }, /* 0x268 */
+       .lna_thr_set2_ref2  =3D { .val =3D 0x2E292624, .mask =3D 0xffffffff=
 }, /* 0x26C */
+       .lna_thr_set2_ref3  =3D { .val =3D 0x5D393933, .mask =3D 0xffffffff=
 }, /* 0x270 */
+       .lna_gain_set0_ref2 =3D { .val =3D 0x2926231F, .mask =3D 0xffffffff=
 }, /* 0x274 */
+       .lna_gain_set0_ref3 =3D { .val =3D 0x3838322E, .mask =3D 0xffffffff=
 }, /* 0x278 */
+       .lna_nf_set0_ref2   =3D { .val =3D 0x04080C0F, .mask =3D 0xffffffff=
 }, /* 0x27C */
+       .lna_nf_set0_ref3   =3D { .val =3D 0x03030303, .mask =3D 0xffffffff=
 }, /* 0x280 */
+       .lna_icp1_set0_ref2 =3D { .val =3D 0x66696C6C, .mask =3D 0xffffffff=
 }, /* 0x284 */
+       .lna_icp1_set0_ref3 =3D { .val =3D 0x625F6264, .mask =3D 0xffffffff=
 }, /* 0x288 */
+       .fsm_preset_p10     =3D { .val =3D 0x00001E21, .mask =3D 0xffffffff=
 }, /* 0x2A8 */
+       .fsm_preset_p11     =3D { .val =3D 0x00001E21, .mask =3D 0xffffffff=
 }, /* 0x2AC */
+       .fsm_preset_p12     =3D { .val =3D 0x00ECEA07, .mask =3D 0xffffffff=
 }, /* 0x2B0 */
+       .ant_loss           =3D { .val =3D 0x00000000, .mask =3D 0xffffffff=
 }, /* 0x300 */
+       .gain_range         =3D { .val =3D 0x47076407, .mask =3D 0xffffffff=
 }, /* 0x304 */
+       .vga_ref0           =3D { .val =3D 0x0001021E, .mask =3D 0xffffffff=
 }, /* 0x308 */
+       .lna_gain_set0_ref0 =3D { .val =3D 0x15120F0B, .mask =3D 0xffffffff=
 }, /* 0x30C */
+       .lna_gain_set0_ref1 =3D { .val =3D 0x24241E1A, .mask =3D 0xffffffff=
 }, /* 0x310 */
+       .lna_thr_set0_ref0  =3D { .val =3D 0x1A16130F, .mask =3D 0xffffffff=
 }, /* 0x314 */
+       .lna_thr_set0_ref1  =3D { .val =3D 0x2424241F, .mask =3D 0xffffffff=
 }, /* 0x318 */
+       .lna_thr_set1_ref0  =3D { .val =3D 0x1A16130F, .mask =3D 0xffffffff=
 }, /* 0x31C */
+       .lna_thr_set1_ref1  =3D { .val =3D 0x2424241F, .mask =3D 0xffffffff=
 }, /* 0x320 */
+       .lna_thr_set2_ref0  =3D { .val =3D 0x1A16130F, .mask =3D 0xffffffff=
 }, /* 0x324 */
+       .lna_thr_set2_ref1  =3D { .val =3D 0x2424241F, .mask =3D 0xffffffff=
 }, /* 0x328 */
+       .lna_nf_set0_ref0   =3D { .val =3D 0x141A2023, .mask =3D 0xffffffff=
 }, /* 0x32C */
+       .lna_nf_set0_ref1   =3D { .val =3D 0x000D0E10, .mask =3D 0xffffffff=
 }, /* 0x330 */
+       .lna_icp1_set0_ref0 =3D { .val =3D 0x7A7D0000, .mask =3D 0xffffffff=
 }, /* 0x334 */
+       .lna_icp1_set0_ref1 =3D { .val =3D 0x00737678, .mask =3D 0xffffffff=
 }, /* 0x338 */
+       .saturation         =3D { .val =3D 0x08393536, .mask =3D 0xffffffff=
 }, /* 0x364 */
+       .ramp               =3D { .val =3D 0x05200710, .mask =3D 0xffffffff=
 }, /* 0x36C */
+       .dsp0               =3D { .val =3D 0x00000000, .mask =3D 0x000000ff=
 }, /* 0x394 */
+       .dsp1               =3D { .val =3D 0x00000000, .mask =3D 0x000000ff=
 }, /* 0x398 */
+       .dsp2               =3D { .val =3D 0x00000000, .mask =3D 0xffffffff=
 }, /* 0x39A */
+       .dsp3               =3D { .val =3D 0x0B730000, .mask =3D 0xffff0000=
 }, /* 0x3A0 */
+       .lna_gain_set1_ref0 =3D { .val =3D 0x15120F0B, .mask =3D 0xffffffff=
 }, /* 0x590 */
+       .lna_gain_set1_ref1 =3D { .val =3D 0x24241E1A, .mask =3D 0xffffffff=
 }, /* 0x594 */
+       .lna_gain_set1_ref2 =3D { .val =3D 0x2926231F, .mask =3D 0xffffffff=
 }, /* 0x598 */
+       .lna_gain_set1_ref3 =3D { .val =3D 0x3838322E, .mask =3D 0xffffffff=
 }, /* 0x59C */
+       .lna_nf_set1_ref0   =3D { .val =3D 0x141A2023, .mask =3D 0xffffffff=
 }, /* 0x5A0 */
+       .lna_nf_set1_ref1   =3D { .val =3D 0x000D0E10, .mask =3D 0xffffffff=
 }, /* 0x5A4 */
+       .lna_nf_set1_ref2   =3D { .val =3D 0x04080C0F, .mask =3D 0xffffffff=
 }, /* 0x5A8 */
+       .lna_nf_set1_ref3   =3D { .val =3D 0x03030303, .mask =3D 0xffffffff=
 }, /* 0x5AC */
+       .lna_icp1_set1_ref0 =3D { .val =3D 0x7A7D0000, .mask =3D 0xffffffff=
 }, /* 0x5B0 */
+       .lna_icp1_set1_ref1 =3D { .val =3D 0x00737678, .mask =3D 0xffffffff=
 }, /* 0x5B4 */
+       .lna_icp1_set1_ref2 =3D { .val =3D 0x66696C6C, .mask =3D 0xffffffff=
 }, /* 0x5B8 */
+       .lna_icp1_set1_ref3 =3D { .val =3D 0x625F6264, .mask =3D 0xffffffff=
 }, /* 0x5BC */
+};
+
+struct cl_agc_profile agc_profile_5_1_7 =3D {
+       .id                 =3D AGC_PROFILE(5, 1, 7),
+       .fsm_preset_p2      =3D { .val =3D 0x00004701, .mask =3D 0xffffffff=
 }, /* 0x244 */
+       .lna_thr_set0_ref2  =3D { .val =3D 0x2E28231F, .mask =3D 0xffffffff=
 }, /* 0x25C */
+       .lna_thr_set0_ref3  =3D { .val =3D 0x00353532, .mask =3D 0xffffffff=
 }, /* 0x260 */
+       .lna_thr_set1_ref2  =3D { .val =3D 0x2E28231F, .mask =3D 0xffffffff=
 }, /* 0x264 */
+       .lna_thr_set1_ref3  =3D { .val =3D 0x5B353532, .mask =3D 0xffffffff=
 }, /* 0x268 */
+       .lna_thr_set2_ref2  =3D { .val =3D 0x2E28231F, .mask =3D 0xffffffff=
 }, /* 0x26C */
+       .lna_thr_set2_ref3  =3D { .val =3D 0x5B353532, .mask =3D 0xffffffff=
 }, /* 0x270 */
+       .lna_gain_set0_ref2 =3D { .val =3D 0x27231E19, .mask =3D 0xffffffff=
 }, /* 0x274 */
+       .lna_gain_set0_ref3 =3D { .val =3D 0x3535312C, .mask =3D 0xffffffff=
 }, /* 0x278 */
+       .lna_nf_set0_ref2   =3D { .val =3D 0x0406090D, .mask =3D 0xffffffff=
 }, /* 0x27C */
+       .lna_nf_set0_ref3   =3D { .val =3D 0x02030303, .mask =3D 0xffffffff=
 }, /* 0x280 */
+       .lna_icp1_set0_ref2 =3D { .val =3D 0x5D666A6F, .mask =3D 0xffffffff=
 }, /* 0x284 */
+       .lna_icp1_set0_ref3 =3D { .val =3D 0x5757575B, .mask =3D 0xffffffff=
 }, /* 0x288 */
+       .fsm_preset_p10     =3D { .val =3D 0x00001E21, .mask =3D 0xffffffff=
 }, /* 0x2A8 */
+       .fsm_preset_p11     =3D { .val =3D 0x00001E21, .mask =3D 0xffffffff=
 }, /* 0x2AC */
+       .fsm_preset_p12     =3D { .val =3D 0x00ECEA07, .mask =3D 0xffffffff=
 }, /* 0x2B0 */
+       .ant_loss           =3D { .val =3D 0x00000000, .mask =3D 0xffffffff=
 }, /* 0x300 */
+       .gain_range         =3D { .val =3D 0x47026402, .mask =3D 0xffffffff=
 }, /* 0x304 */
+       .vga_ref0           =3D { .val =3D 0x0001021E, .mask =3D 0xffffffff=
 }, /* 0x308 */
+       .lna_gain_set0_ref0 =3D { .val =3D 0x120E0904, .mask =3D 0xffffffff=
 }, /* 0x30C */
+       .lna_gain_set0_ref1 =3D { .val =3D 0x20201C17, .mask =3D 0xffffffff=
 }, /* 0x310 */
+       .lna_thr_set0_ref0  =3D { .val =3D 0x17120E09, .mask =3D 0xffffffff=
 }, /* 0x314 */
+       .lna_thr_set0_ref1  =3D { .val =3D 0x1F1F1F1C, .mask =3D 0xffffffff=
 }, /* 0x318 */
+       .lna_thr_set1_ref0  =3D { .val =3D 0x17120E09, .mask =3D 0xffffffff=
 }, /* 0x31C */
+       .lna_thr_set1_ref1  =3D { .val =3D 0x1F1F1F1C, .mask =3D 0xffffffff=
 }, /* 0x320 */
+       .lna_thr_set2_ref0  =3D { .val =3D 0x17120E09, .mask =3D 0xffffffff=
 }, /* 0x324 */
+       .lna_thr_set2_ref1  =3D { .val =3D 0x1F1F1F1C, .mask =3D 0xffffffff=
 }, /* 0x328 */
+       .lna_nf_set0_ref0   =3D { .val =3D 0x12171C20, .mask =3D 0xffffffff=
 }, /* 0x32C */
+       .lna_nf_set0_ref1   =3D { .val =3D 0x0A0B0B0F, .mask =3D 0xffffffff=
 }, /* 0x330 */
+       .lna_icp1_set0_ref0 =3D { .val =3D 0x6F727476, .mask =3D 0xffffffff=
 }, /* 0x334 */
+       .lna_icp1_set0_ref1 =3D { .val =3D 0x6268686D, .mask =3D 0xffffffff=
 }, /* 0x338 */
+       .saturation         =3D { .val =3D 0x08393536, .mask =3D 0xffffffff=
 }, /* 0x364 */
+       .ramp               =3D { .val =3D 0x05200710, .mask =3D 0xffffffff=
 }, /* 0x36C */
+       .dsp0               =3D { .val =3D 0x00000000, .mask =3D 0x000000ff=
 }, /* 0x394 */
+       .dsp1               =3D { .val =3D 0x00000000, .mask =3D 0x000000ff=
 }, /* 0x398 */
+       .dsp2               =3D { .val =3D 0x00000000, .mask =3D 0xffffffff=
 }, /* 0x39A */
+       .dsp3               =3D { .val =3D 0x0B730000, .mask =3D 0xffff0000=
 }, /* 0x3A0 */
+       .lna_gain_set1_ref0 =3D { .val =3D 0x120E0904, .mask =3D 0xffffffff=
 }, /* 0x590 */
+       .lna_gain_set1_ref1 =3D { .val =3D 0x20201C17, .mask =3D 0xffffffff=
 }, /* 0x594 */
+       .lna_gain_set1_ref2 =3D { .val =3D 0x27231E19, .mask =3D 0xffffffff=
 }, /* 0x598 */
+       .lna_gain_set1_ref3 =3D { .val =3D 0x3535312C, .mask =3D 0xffffffff=
 }, /* 0x59C */
+       .lna_nf_set1_ref0   =3D { .val =3D 0x12171C20, .mask =3D 0xffffffff=
 }, /* 0x5A0 */
+       .lna_nf_set1_ref1   =3D { .val =3D 0x0A0B0B0F, .mask =3D 0xffffffff=
 }, /* 0x5A4 */
+       .lna_nf_set1_ref2   =3D { .val =3D 0x0406090D, .mask =3D 0xffffffff=
 }, /* 0x5A8 */
+       .lna_nf_set1_ref3   =3D { .val =3D 0x02030303, .mask =3D 0xffffffff=
 }, /* 0x5AC */
+       .lna_icp1_set1_ref0 =3D { .val =3D 0x6F727476, .mask =3D 0xffffffff=
 }, /* 0x5B0 */
+       .lna_icp1_set1_ref1 =3D { .val =3D 0x6268686D, .mask =3D 0xffffffff=
 }, /* 0x5B4 */
+       .lna_icp1_set1_ref2 =3D { .val =3D 0x5D666A6F, .mask =3D 0xffffffff=
 }, /* 0x5B8 */
+       .lna_icp1_set1_ref3 =3D { .val =3D 0x5757575B, .mask =3D 0xffffffff=
 }, /* 0x5BC */
+};
+
+struct cl_agc_profile agc_profile_6_1_3 =3D {
+       .id                 =3D AGC_PROFILE(6, 1, 3),
+       .fsm_preset_p2      =3D { .val =3D 0x00004701, .mask =3D 0xffffffff=
 }, /* 0x244 */
+       .lna_thr_set0_ref2  =3D { .val =3D 0x29241F1C, .mask =3D 0xffffffff=
 }, /* 0x25C */
+       .lna_thr_set0_ref3  =3D { .val =3D 0x0033332D, .mask =3D 0xffffffff=
 }, /* 0x260 */
+       .lna_thr_set1_ref2  =3D { .val =3D 0x29241F1C, .mask =3D 0xffffffff=
 }, /* 0x264 */
+       .lna_thr_set1_ref3  =3D { .val =3D 0x5833332D, .mask =3D 0xffffffff=
 }, /* 0x268 */
+       .lna_thr_set2_ref2  =3D { .val =3D 0x29241F1C, .mask =3D 0xffffffff=
 }, /* 0x26C */
+       .lna_thr_set2_ref3  =3D { .val =3D 0x5833332D, .mask =3D 0xffffffff=
 }, /* 0x270 */
+       .lna_gain_set0_ref2 =3D { .val =3D 0x1A15100C, .mask =3D 0xffffffff=
 }, /* 0x274 */
+       .lna_gain_set0_ref3 =3D { .val =3D 0x2828231E, .mask =3D 0xffffffff=
 }, /* 0x278 */
+       .lna_nf_set0_ref2   =3D { .val =3D 0x0406090D, .mask =3D 0xffffffff=
 }, /* 0x27C */
+       .lna_nf_set0_ref3   =3D { .val =3D 0x02030303, .mask =3D 0xffffffff=
 }, /* 0x280 */
+       .lna_icp1_set0_ref2 =3D { .val =3D 0x5D666A6F, .mask =3D 0xffffffff=
 }, /* 0x284 */
+       .lna_icp1_set0_ref3 =3D { .val =3D 0x5757575B, .mask =3D 0xffffffff=
 }, /* 0x288 */
+       .fsm_preset_p10     =3D { .val =3D 0x00001E21, .mask =3D 0xffffffff=
 }, /* 0x2A8 */
+       .fsm_preset_p11     =3D { .val =3D 0x00001E21, .mask =3D 0xffffffff=
 }, /* 0x2AC */
+       .fsm_preset_p12     =3D { .val =3D 0x00ECEA07, .mask =3D 0xffffffff=
 }, /* 0x2B0 */
+       .ant_loss           =3D { .val =3D 0x00000000, .mask =3D 0xffffffff=
 }, /* 0x300 */
+       .gain_range         =3D { .val =3D 0x47026402, .mask =3D 0xffffffff=
 }, /* 0x304 */
+       .vga_ref0           =3D { .val =3D 0x0001A214, .mask =3D 0xffffffff=
 }, /* 0x308 */
+       .lna_gain_set0_ref0 =3D { .val =3D 0x047F7A76, .mask =3D 0xffffffff=
 }, /* 0x30C */
+       .lna_gain_set0_ref1 =3D { .val =3D 0x12120D08, .mask =3D 0xffffffff=
 }, /* 0x310 */
+       .lna_thr_set0_ref0  =3D { .val =3D 0x130D0906, .mask =3D 0xffffffff=
 }, /* 0x314 */
+       .lna_thr_set0_ref1  =3D { .val =3D 0x1A1A1A17, .mask =3D 0xffffffff=
 }, /* 0x318 */
+       .lna_thr_set1_ref0  =3D { .val =3D 0x130D0906, .mask =3D 0xffffffff=
 }, /* 0x31C */
+       .lna_thr_set1_ref1  =3D { .val =3D 0x1A1A1A17, .mask =3D 0xffffffff=
 }, /* 0x320 */
+       .lna_thr_set2_ref0  =3D { .val =3D 0x130D0906, .mask =3D 0xffffffff=
 }, /* 0x324 */
+       .lna_thr_set2_ref1  =3D { .val =3D 0x1A1A1A17, .mask =3D 0xffffffff=
 }, /* 0x328 */
+       .lna_nf_set0_ref0   =3D { .val =3D 0x12171C20, .mask =3D 0xffffffff=
 }, /* 0x32C */
+       .lna_nf_set0_ref1   =3D { .val =3D 0x0A0B0B0F, .mask =3D 0xffffffff=
 }, /* 0x330 */
+       .lna_icp1_set0_ref0 =3D { .val =3D 0x6F727476, .mask =3D 0xffffffff=
 }, /* 0x334 */
+       .lna_icp1_set0_ref1 =3D { .val =3D 0x6268686D, .mask =3D 0xffffffff=
 }, /* 0x338 */
+       .saturation         =3D { .val =3D 0x08383435, .mask =3D 0xffffffff=
 }, /* 0x364 */
+       .ramp               =3D { .val =3D 0x05200710, .mask =3D 0xffffffff=
 }, /* 0x36C */
+       .dsp0               =3D { .val =3D 0x00000004, .mask =3D 0x000000ff=
 }, /* 0x394 */
+       .dsp1               =3D { .val =3D 0x00000006, .mask =3D 0x000000ff=
 }, /* 0x398 */
+       .dsp2               =3D { .val =3D 0x06060606, .mask =3D 0xffffffff=
 }, /* 0x39A */
+       .dsp3               =3D { .val =3D 0x0B730000, .mask =3D 0xffff0000=
 }, /* 0x3A0 */
+       .lna_gain_set1_ref0 =3D { .val =3D 0x047F7A76, .mask =3D 0xffffffff=
 }, /* 0x590 */
+       .lna_gain_set1_ref1 =3D { .val =3D 0x12120D08, .mask =3D 0xffffffff=
 }, /* 0x594 */
+       .lna_gain_set1_ref2 =3D { .val =3D 0x1A15100C, .mask =3D 0xffffffff=
 }, /* 0x598 */
+       .lna_gain_set1_ref3 =3D { .val =3D 0x2828231E, .mask =3D 0xffffffff=
 }, /* 0x59C */
+       .lna_nf_set1_ref0   =3D { .val =3D 0x12171C20, .mask =3D 0xffffffff=
 }, /* 0x5A0 */
+       .lna_nf_set1_ref1   =3D { .val =3D 0x0A0B0B0F, .mask =3D 0xffffffff=
 }, /* 0x5A4 */
+       .lna_nf_set1_ref2   =3D { .val =3D 0x0406090D, .mask =3D 0xffffffff=
 }, /* 0x5A8 */
+       .lna_nf_set1_ref3   =3D { .val =3D 0x02030303, .mask =3D 0xffffffff=
 }, /* 0x5AC */
+       .lna_icp1_set1_ref0 =3D { .val =3D 0x6F727476, .mask =3D 0xffffffff=
 }, /* 0x5B0 */
+       .lna_icp1_set1_ref1 =3D { .val =3D 0x6268686D, .mask =3D 0xffffffff=
 }, /* 0x5B4 */
+       .lna_icp1_set1_ref2 =3D { .val =3D 0x5D666A6F, .mask =3D 0xffffffff=
 }, /* 0x5B8 */
+       .lna_icp1_set1_ref3 =3D { .val =3D 0x5757575B, .mask =3D 0xffffffff=
 }, /* 0x5BC */
+};
+
+#define PLATFORM_DESCRIPTION_LENGTH 100
+
+struct cl_agc_table {
+       u32 platform_id;
+       u8 platform_description[PLATFORM_DESCRIPTION_LENGTH];
+       struct cl_agc_profile *agc_profile[TCV_MAX];
+       struct cl_agc_profile *agc_profile_elastic[TCV_MAX];
+       struct cl_agc_profile *agc_profile_sensing;
+};
+
+struct cl_agc_table agc_table[] =3D {
+       {
+               .platform_id =3D AGC_PLATFORM(CL_CUSTOMER_CELENO, CL_BOARD_=
EVB, 0),
+               .platform_description =3D "Celeno, EVB, 5G 6x6 + 2.4G 6x6",
+               .agc_profile[TCV0] =3D &agc_profile_5_1_7,
+               .agc_profile[TCV1] =3D &agc_profile_2_1_6,
+               .agc_profile_elastic[TCV0] =3D NULL,
+               .agc_profile_elastic[TCV1] =3D NULL,
+               .agc_profile_sensing =3D NULL,
+       },
+       {
+               .platform_id =3D AGC_PLATFORM(CL_CUSTOMER_CELENO, CL_BOARD_=
MERLIN, 0),
+               .platform_description =3D "Celeno, Merlin, 5G 4x4 + 2.4G 4x=
4",
+               .agc_profile[TCV0] =3D &agc_profile_5_1_7,
+               .agc_profile[TCV1] =3D &agc_profile_2_1_6,
+               .agc_profile_elastic[TCV0] =3D NULL,
+               .agc_profile_elastic[TCV1] =3D NULL,
+               .agc_profile_sensing =3D NULL,
+       },
+       {
+               .platform_id =3D AGC_PLATFORM(CL_CUSTOMER_CELENO, CL_BOARD_=
EVB_6G, 0),
+               .platform_description =3D "Celeno, EVB, 6G 4x4 + 6G 4x4",
+               .agc_profile[TCV0] =3D &agc_profile_6_1_3,
+               .agc_profile[TCV1] =3D &agc_profile_6_1_3,
+               .agc_profile_elastic[TCV0] =3D NULL,
+               .agc_profile_elastic[TCV1] =3D NULL,
+               .agc_profile_sensing =3D NULL,
+       },
+       {
+               .platform_id =3D AGC_PLATFORM(CL_CUSTOMER_CELENO, CL_BOARD_=
ALBATROSS, 0),
+               .platform_description =3D
+                       "Celeno, Albatross, 6G 4x4 WiFi + 6G 2x2 sensing + =
5G 2x2 sensing",
+               .agc_profile[TCV0] =3D &agc_profile_6_1_3,
+               .agc_profile[TCV1] =3D NULL,
+               .agc_profile_elastic[TCV0] =3D NULL,
+               .agc_profile_elastic[TCV1] =3D NULL,
+               .agc_profile_sensing =3D &agc_profile_6_1_3,
+       },
+       {
+               .platform_id =3D AGC_PLATFORM(CL_CUSTOMER_CELENO, CL_BOARD_=
ALBATROSS_2, 0),
+               .platform_description =3D
+                       "Celeno, Albatross 2, 6G 4x4 WiFi + 6G 2x2 sensing =
+ 5G 2x2 sensing",
+               .agc_profile[TCV0] =3D &agc_profile_6_1_3,
+               .agc_profile[TCV1] =3D NULL,
+               .agc_profile_elastic[TCV0] =3D NULL,
+               .agc_profile_elastic[TCV1] =3D NULL,
+               .agc_profile_sensing =3D &agc_profile_6_1_3,
+       },
+       {
+               .platform_id =3D AGC_PLATFORM(CL_CUSTOMER_CELENO, CL_BOARD_=
CHAMELEON, 0),
+               .platform_description =3D "Celeno, Chameleon, 5G 4x4 WiFi +=
 5G 4x4 sensing",
+               .agc_profile[TCV0] =3D &agc_profile_5_1_7,
+               .agc_profile[TCV1] =3D NULL,
+               .agc_profile_elastic[TCV0] =3D NULL,
+               .agc_profile_elastic[TCV1] =3D NULL,
+               .agc_profile_sensing =3D &agc_profile_5_1_7,
+       },
+};
+
+int cl_agc_params_read_platform_id(struct cl_chip *chip)
+{
+       u8 i;
+       u32 platform_id =3D 0;
+
+       if (cl_e2p_read(chip, (u8 *)&platform_id, SIZE_FEM_PLATFORM_ID, ADD=
R_FEM_PLATFORM_ID))
+               return -1;
+
+       cl_dbg_chip_verbose(chip,
+                           "platform_id: 0x%08x, "
+                           "customer_id: 0x%04x, board_id: 0x%02x, chip_id=
: 0x%x\n",
+                           platform_id,
+                           AGC_PLATFORM_CUSTOMER(platform_id),
+                           AGC_PLATFORM_BOARD(platform_id),
+                           AGC_PLATFORM_CHIP(platform_id));
+
+       for (i =3D 0; i < ARRAY_SIZE(agc_table); i++) {
+               if (platform_id !=3D agc_table[i].platform_id)
+                       continue;
+
+               cl_dbg_chip_verbose(chip, "%s\n", agc_table[i].platform_des=
cription);
+               chip->agc_table_entry =3D i;
+               return 0;
+       }
+
+       CL_DBG_ERROR_CHIP(chip, "Invalid platform_id 0x%08x\n", platform_id=
);
+
+       if (!chip->conf->ce_production_mode)
+               return -1;
+
+       return 0;
+}
+
+#ifdef __BIG_ENDIAN_BITFIELD
+static void agc_profile_to_le32(struct cl_agc_profile *profile)
+{
+       u32 i;
+       u32 size =3D sizeof(struct cl_agc_profile);
+       u32 *ptr =3D (u32 *)profile;
+
+       /* Make sure that size divides by 4 */
+       WARN_ON((size & 0x3) !=3D 0);
+
+       for (i =3D 0; i < size / 4; i++)
+               ptr[i] =3D cpu_to_le32(ptr[i]);
+}
+#endif
+
+int cl_agc_params_fill(struct cl_hw *cl_hw, struct cl_agc_params *agc_para=
ms)
+{
+       u8 tcv_idx =3D cl_hw->tcv_idx;
+       u8 agc_table_entry =3D cl_hw->chip->agc_table_entry;
+       struct cl_agc_table *table;
+
+       memset(agc_params, 0, sizeof(struct cl_agc_params));
+
+       if (agc_table_entry =3D=3D U8_MAX)
+               return 0;
+
+       table =3D &agc_table[agc_table_entry];
+
+       if (!table->agc_profile_elastic[tcv_idx] || cl_hw->num_antennas <=
=3D 2) {
+               u8 ant_shift =3D cl_hw_ant_shift(cl_hw);
+
+               if (table->agc_profile[tcv_idx]) {
+                       memcpy(&agc_params->profile1,
+                              table->agc_profile[tcv_idx],
+                              sizeof(struct cl_agc_profile));
+               } else if (tcv_idx =3D=3D TCV1 && table->agc_profile_sensin=
g) {
+                       memcpy(&agc_params->profile1,
+                              table->agc_profile_sensing,
+                              sizeof(struct cl_agc_profile));
+               } else {
+                       CL_DBG_ERROR(cl_hw, "Invalid tcv/sensing profile");
+                       return -1;
+               }
+
+               agc_params->num_profiles =3D 1;
+               agc_params->ant_mask1 =3D ANT_MASK(cl_hw->num_antennas) << =
ant_shift;
+               agc_params->ant_mask2 =3D 0;
+
+#ifdef __BIG_ENDIAN_BITFIELD
+               agc_profile_to_le32(&agc_params->profile1);
+#endif
+       } else {
+               if (table->agc_profile[tcv_idx]) {
+                       memcpy(&agc_params->profile1,
+                              table->agc_profile[tcv_idx],
+                              sizeof(struct cl_agc_profile));
+               } else {
+                       CL_DBG_ERROR(cl_hw, "Invalid tcv profile");
+                       return -1;
+               }
+
+               if (table->agc_profile_elastic[tcv_idx]) {
+                       memcpy(&agc_params->profile2,
+                              table->agc_profile_elastic[tcv_idx],
+                              sizeof(struct cl_agc_profile));
+               } else {
+                       CL_DBG_ERROR(cl_hw, "Invalid elastic profile");
+                       return -1;
+               }
+
+               agc_params->num_profiles =3D 2;
+               agc_params->ant_mask1 =3D ANT_MASK(2);
+               agc_params->ant_mask2 =3D ANT_MASK(cl_hw->num_antennas - 2)=
 << 2;
+
+#ifdef __BIG_ENDIAN_BITFIELD
+               agc_profile_to_le32(&agc_params->profile1);
+               agc_profile_to_le32(&agc_params->profile2);
+#endif
+       }
+
+       return 0;
+}
+
+static void _cl_agc_params_dump(struct cl_hw *cl_hw, char **buf, int *len,
+                               ssize_t *buf_size, struct cl_agc_profile *a=
gc_table)
+{
+       cl_snprintf(buf, len, buf_size,
+                   "|-----------------------------------------------------=
-|\n"
+                   "| Addr  | Name               | Mask       | Value     =
 |\n"
+                   "|-------+--------------------+------------+-----------=
-|\n");
+
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x244 | fsm_preset_p2      | 0x%08x | 0x%08x |\n",
+                   agc_table->fsm_preset_p2.mask, agc_table->fsm_preset_p2=
.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x25C | lna_thr_set0_ref2  | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_thr_set0_ref2.mask, agc_table->lna_thr_s=
et0_ref2.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x260 | lna_thr_set0_ref3  | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_thr_set0_ref3.mask, agc_table->lna_thr_s=
et0_ref3.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x264 | lna_thr_set1_ref2  | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_thr_set1_ref2.mask, agc_table->lna_thr_s=
et1_ref2.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x268 | lna_thr_set1_ref3  | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_thr_set1_ref3.mask, agc_table->lna_thr_s=
et1_ref3.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x26C | lna_thr_set2_ref2  | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_thr_set2_ref2.mask, agc_table->lna_thr_s=
et2_ref2.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x270 | lna_thr_set2_ref3  | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_thr_set2_ref3.mask, agc_table->lna_thr_s=
et2_ref3.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x274 | lna_gain_set0_ref2 | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_gain_set0_ref2.mask, agc_table->lna_gain=
_set0_ref2.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x278 | lna_gain_set0_ref3 | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_gain_set0_ref3.mask, agc_table->lna_gain=
_set0_ref3.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x27C | lna_nf_set0_ref2   | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_nf_set0_ref2.mask, agc_table->lna_nf_set=
0_ref2.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x280 | lna_nf_set0_ref3   | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_nf_set0_ref3.mask, agc_table->lna_nf_set=
0_ref3.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x284 | lna_icp1_set0_ref2 | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_icp1_set0_ref2.mask, agc_table->lna_icp1=
_set0_ref2.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x288 | lna_icp1_set0_ref3 | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_icp1_set0_ref3.mask, agc_table->lna_icp1=
_set0_ref3.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x2A8 | fsm_preset_p10     | 0x%08x | 0x%08x |\n",
+                   agc_table->fsm_preset_p10.mask, agc_table->fsm_preset_p=
10.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x2AC | fsm_preset_p11     | 0x%08x | 0x%08x |\n",
+                   agc_table->fsm_preset_p11.mask, agc_table->fsm_preset_p=
11.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x2B0 | fsm_preset_p12     | 0x%08x | 0x%08x |\n",
+                   agc_table->fsm_preset_p12.mask, agc_table->fsm_preset_p=
12.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x300 | ant_loss           | 0x%08x | 0x%08x |\n",
+                   agc_table->ant_loss.mask, agc_table->ant_loss.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x304 | gain_range         | 0x%08x | 0x%08x |\n",
+                   agc_table->gain_range.mask, agc_table->gain_range.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x308 | vga_ref0           | 0x%08x | 0x%08x |\n",
+                   agc_table->vga_ref0.mask, agc_table->vga_ref0.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x30C | lna_gain_set0_ref0 | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_gain_set0_ref0.mask, agc_table->lna_gain=
_set0_ref0.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x310 | lna_gain_set0_ref1 | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_gain_set0_ref1.mask, agc_table->lna_gain=
_set0_ref1.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x314 | lna_thr_set0_ref0  | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_thr_set0_ref0.mask, agc_table->lna_thr_s=
et0_ref0.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x318 | lna_thr_set0_ref1  | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_thr_set0_ref1.mask, agc_table->lna_thr_s=
et0_ref1.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x31C | lna_thr_set1_ref0  | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_thr_set1_ref0.mask, agc_table->lna_thr_s=
et1_ref0.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x320 | lna_thr_set1_ref1  | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_thr_set1_ref1.mask, agc_table->lna_thr_s=
et1_ref1.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x324 | lna_thr_set2_ref0  | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_thr_set2_ref0.mask, agc_table->lna_thr_s=
et2_ref0.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x328 | lna_thr_set2_ref1  | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_thr_set2_ref1.mask, agc_table->lna_thr_s=
et2_ref1.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x32C | lna_nf_set0_ref0   | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_nf_set0_ref0.mask, agc_table->lna_nf_set=
0_ref0.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x330 | lna_nf_set0_ref1   | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_nf_set0_ref1.mask, agc_table->lna_nf_set=
0_ref1.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x334 | lna_icp1_set0_ref0 | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_icp1_set0_ref0.mask, agc_table->lna_icp1=
_set0_ref0.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x338 | lna_icp1_set0_ref1 | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_icp1_set0_ref1.mask, agc_table->lna_icp1=
_set0_ref1.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x364 | saturation          | 0x%08x | 0x%08x |\n",
+                   agc_table->saturation.mask, agc_table->saturation.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x36C | ramp               | 0x%08x | 0x%08x |\n",
+                   agc_table->ramp.mask, agc_table->ramp.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x394 | dsp0               | 0x%08x | 0x%08x |\n",
+                   agc_table->dsp0.mask, agc_table->dsp0.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x398 | dsp1               | 0x%08x | 0x%08x |\n",
+                   agc_table->dsp1.mask, agc_table->dsp1.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x39C | dsp2               | 0x%08x | 0x%08x |\n",
+                   agc_table->dsp2.mask, agc_table->dsp2.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x3A0 | dsp3               | 0x%08x | 0x%08x |\n",
+                   agc_table->dsp3.mask, agc_table->dsp3.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x590 | lna_gain_set1_ref0 | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_gain_set1_ref0.mask,
+                   agc_table->lna_gain_set1_ref0.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x594 | lna_gain_set1_ref1 | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_gain_set1_ref1.mask,
+                   agc_table->lna_gain_set1_ref1.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x598 | lna_gain_set1_ref2 | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_gain_set1_ref2.mask,
+                   agc_table->lna_gain_set1_ref2.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x59C | lna_gain_set1_ref3 | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_gain_set1_ref3.mask,
+                   agc_table->lna_gain_set1_ref3.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x5A0 | lna_nf_set1_ref0   | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_nf_set1_ref0.mask,
+                   agc_table->lna_nf_set1_ref0.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x5A4 | lna_nf_set1_ref1   | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_nf_set1_ref1.mask,
+                   agc_table->lna_nf_set1_ref1.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x5A8 | lna_nf_set1_ref2   | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_nf_set1_ref2.mask,
+                   agc_table->lna_nf_set1_ref2.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x5AC | lna_nf_set1_ref3   | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_nf_set1_ref3.mask,
+                   agc_table->lna_nf_set1_ref3.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x5B0 | lna_icp1_set1_ref0 | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_icp1_set1_ref0.mask,
+                   agc_table->lna_icp1_set1_ref0.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x5B4 | lna_icp1_set1_ref1 | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_icp1_set1_ref1.mask,
+                   agc_table->lna_icp1_set1_ref1.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x5B8 | lna_icp1_set1_ref2 | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_icp1_set1_ref2.mask,
+                   agc_table->lna_icp1_set1_ref2.val);
+       cl_snprintf(buf, len, buf_size,
+                   "| 0x5BC | lna_icp1_set1_ref3 | 0x%08x | 0x%08x |\n",
+                   agc_table->lna_icp1_set1_ref3.mask,
+                   agc_table->lna_icp1_set1_ref3.val);
+
+       cl_snprintf(buf, len, buf_size,
+                   "|-----------------------------------------------------=
-|\n");
+}
+
+static int cl_agc_params_dump(struct cl_hw *cl_hw)
+{
+       struct cl_agc_params *agc_params =3D
+                                       &cl_hw->phy_data_info.data->agc_par=
ams;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       if (agc_params->profile1.id) {
+               cl_snprintf(&buf, &len, &buf_size, "AGC Params [%ug]\n", cl=
_hw->conf->ci_band_num);
+               _cl_agc_params_dump(cl_hw, &buf, &len, &buf_size, &agc_para=
ms->profile1);
+       }
+
+       if (agc_params->profile2.id) {
+               cl_snprintf(&buf, &len, &buf_size, "AGC Params [%ug elastic=
]",
+                           cl_hw->conf->ci_band_num);
+               _cl_agc_params_dump(cl_hw, &buf, &len, &buf_size, &agc_para=
ms->profile2);
+       }
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_agc_params_print_table(struct cl_hw *cl_hw)
+{
+       struct cl_agc_table *table;
+       u32 platform_id;
+       u8 i;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       for (i =3D 0; i < ARRAY_SIZE(agc_table); i++) {
+               table =3D &agc_table[i];
+               platform_id =3D table->platform_id;
+
+               cl_snprintf(&buf, &len, &buf_size,
+                           "----------------------------------------------=
--------\n");
+               cl_snprintf(&buf, &len, &buf_size, "Table #%u\n", i);
+               cl_snprintf(&buf, &len, &buf_size,
+                           "----------------------------------------------=
--------\n");
+               cl_snprintf(&buf, &len, &buf_size, "Platform ID: 0x%08x\n",=
 platform_id);
+               cl_snprintf(&buf, &len, &buf_size, "  - Customer =3D 0x%04x=
\n",
+                           AGC_PLATFORM_CUSTOMER(platform_id));
+               cl_snprintf(&buf, &len, &buf_size, "  - Board =3D 0x%02x\n"=
,
+                           AGC_PLATFORM_BOARD(platform_id));
+               cl_snprintf(&buf, &len, &buf_size, "  - Chip =3D 0x%x\n",
+                           AGC_PLATFORM_CHIP(platform_id));
+               cl_snprintf(&buf, &len, &buf_size, "Description:\n");
+               cl_snprintf(&buf, &len, &buf_size, "  - %s\n", table->platf=
orm_description);
+               cl_snprintf(&buf, &len, &buf_size, "AGC Profile:\n");
+
+               cl_agc_params_print_profile(&buf, &len, &buf_size, table->a=
gc_profile[TCV0],
+                                           "  - TCV0 =3D");
+               cl_agc_params_print_profile(&buf, &len, &buf_size,
+                                           table->agc_profile[TCV1], "  - =
TCV1 =3D");
+               cl_agc_params_print_profile(&buf, &len, &buf_size,
+                                           table->agc_profile_elastic[TCV0=
],
+                                           "  - Elastic TCV0 =3D");
+               cl_agc_params_print_profile(&buf, &len, &buf_size,
+                                           table->agc_profile_elastic[TCV1=
],
+                                           "  - Elastic TCV1 =3D");
+               cl_agc_params_print_profile(&buf, &len, &buf_size,
+                                           table->agc_profile_sensing, "  =
- Sensing =3D");
+       }
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+void cl_agc_params_print_profile(char **buf, int *len, ssize_t *buf_size,
+                                struct cl_agc_profile *profile,
+                                const char *str)
+{
+       u32 id;
+       u8 band, branch, version;
+
+       if (!profile)
+               return;
+
+       id =3D profile->id;
+
+       if (id =3D=3D 0)
+               return;
+
+       band =3D AGC_PROFILE_BAND(id);
+       branch =3D AGC_PROFILE_BRANCH(id);
+       version =3D AGC_PROFILE_VERSION(id);
+
+       if (*buf)
+               cl_snprintf(buf, len, buf_size, "%s %u.%u.%u\n", str, band,=
 branch, version);
+       else
+               pr_debug("%s %u.%u.%u\n", str, band, branch, version);
+}
+
+static int cl_agc_params_cli_help(struct cl_hw *cl_hw)
+{
+       char *buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+
+       if (!buf)
+               return -ENOMEM;
+
+       snprintf(buf, PAGE_SIZE,
+                "agc_params usage:\n"
+                "-d : Dump AGC parameters\n"
+                "-t : Print AGC table\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+int cl_agc_params_cli(struct cl_hw *cl_hw, struct cli_params *cli_params)
+{
+       bool dump_params =3D false;
+       bool print_table =3D false;
+       u32 expected_params =3D -1;
+
+       switch (cli_params->option) {
+       case 'd':
+               dump_params =3D true;
+               expected_params =3D 0;
+               break;
+       case 't':
+               print_table =3D true;
+               expected_params =3D 0;
+               break;
+       case '?':
+               return cl_agc_params_cli_help(cl_hw);
+       default:
+               cl_dbg_err(cl_hw, "Illegal option (%c) - try '?' for help\n=
", cli_params->option);
+               goto out_err;
+       }
+
+       if (expected_params !=3D cli_params->num_params) {
+               cl_dbg_err(cl_hw, "Wrong number of arguments (expected %u) =
(actual %u)\n",
+                          expected_params, cli_params->num_params);
+               goto out_err;
+       }
+
+       if (dump_params)
+               return cl_agc_params_dump(cl_hw);
+
+       if (print_table)
+               return cl_agc_params_print_table(cl_hw);
+
+out_err:
+       return -EIO;
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

