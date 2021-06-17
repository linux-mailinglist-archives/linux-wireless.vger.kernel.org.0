Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447F73AB820
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhFQQFF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:05 -0400
Received: from mail-db8eur05on2077.outbound.protection.outlook.com ([40.107.20.77]:6177
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233528AbhFQQFA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LicN8nYWE32Js0GfQSlMKOhcrZXhSSuKVeN93xet+h9AXcXXa/nUYX5mUtB7tQ1Axr2QiWEWrwUUFYUW6L1uGPvJsm1to0ZuNJ9ikYLkLGe54G8JaPswlV/6/cEdHPhSEPbT60aZK0M5IIGN9+txluIdwrKCT0u+9n8pVs+dKIbMAhgBclSVaet89RqKKVaOWu0K7S/SXFZQbEmMG0OrykidSj+52Wrdhi8G5/2eGeEQIREWKjSOZHVNfEWTZtrJvy4Cd9fcmKqOjoe0gFc96W+s2dnBUksycIlLAsq+9xnE3xKcjYtBtNuB7eR5qI187y8huAYFqH0ks2S7MCUS/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMSMANzpGl2iN2NJFkB7KEAvnxqibY4D7lN9MzMx+vk=;
 b=S3cg0LjLYpUhzu0FITT9Rvja2O1qiBMkdNdSRfHECoSshkpDIb7C0M9tla2vAWCJOAFQXj11AQbb7r+Si4CyegrC4mDGS9TBj/pKRhIs4eoRvljdgM5l36A8dIdVKEynhI/MzVEVM9asmH1qdnZswt5WZuyZLCd0/tEfjZSV9ppH7t8Coqms1jKbwgYEzqn7dO5tGwGDzKptSrvvVdLP2GlM9jiwg3UBHu8//mEjyUj6BkruMR8BNaPGvp94BQxcHth8haq86rSq9o9LR9uOEDcyvO7qr2SWJms4CwfUtM8bvJeXdQUqGT3Q15kO46UTXiedO0AE6H1uxNDNkWxFzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMSMANzpGl2iN2NJFkB7KEAvnxqibY4D7lN9MzMx+vk=;
 b=YAkVSG9k+vMRHMS+lQyvcuEsW2kmrR6VfUm7I/VFhW9RBam845DM6McOKLhrl7of3HQJJBYMkPlNEgN6xsUOfyyyI1E3+LrUw5VwZc0r63Ma7ZRCQyQUBPOl3o096iRAxl2golQvlg8/jjnWql8szibKk2+klcHnNOYxIjD05GY=
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
Subject: [RFC v1 008/256] cl8k: add agc_params.h
Date:   Thu, 17 Jun 2021 15:58:15 +0000
Message-Id: <20210617160223.160998-9-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd6ed952-7f6b-441d-95fa-08d931a956e5
X-MS-TrafficTypeDiagnostic: AM9P192MB1412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB141289FB9C2BB46674BD4870F60E9@AM9P192MB1412.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJvKrnAMXpvZkOzm55fq0Puz9jC1a/w/q6CHhOwK6SY7v43Nh9SWbQZIyLLZ2V1hBXXzdHfvTTunOGRWOxvcdC1QIf8oBNpEqO88xkMOE16b88spbI6DXbhROQEsN+UgMCYgXo+duS5xQgAjKrm5Js26su+sGFMgjI29p+4bkxDAJhCwXMhg06Xk01Cr6Fk5XnQmqiCUh/l6kvg03hfmeXmIYjPZnu1EA3t+pgkxVeHSfyELHt9VlwlSZOrp5qrrfcplsSIhxqj5Lc5uZfm5SlvMTUlej5hWAVEZicOIctNh8tUEN6jE9es2H4emYW55k1VTjPwUyAUV+CER972bgcLaNcrvNCjFTSEtRWOuefAB+rbb+tGNSn8NG7rR9DxFuBEePrbip0azBxxWbmq4e0qr5J6IRGsHaNNhws5fdi+pvWVlzd7oypDJaE5gaKYsn2agvL6fE+VQBhYortLGZTqN0agSLUHYlqIFVgU20Y6M98Ugr9XZWTgehwtmgIsPo6pUJYHTVq3lySetU7OlZ0s41q6nEcEaNGBbvt0i5QPCQMeW4oSbz7vJ/dim0yqSm+LNLEoRKmTmoMf7FiKOLxROdlA1DiGS9OLZQI0Nact1CtmCd1cpPLZt62ANDDUFRKE3VHUYpzK7tObJlxfQ+dtFQl2aJEwU5C9EVUmaBMeOf6mUNP65+UQ8lro6SOLxIuNsLzpQf/RVaQm1ff+jNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(376002)(39840400004)(396003)(38350700002)(9686003)(16526019)(38100700002)(6512007)(478600001)(36756003)(6506007)(52116002)(55236004)(6486002)(186003)(66556008)(2906002)(8936002)(2616005)(26005)(66946007)(956004)(66476007)(86362001)(83380400001)(107886003)(5660300002)(1076003)(6666004)(4326008)(316002)(8676002)(6916009)(54906003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W8GbH12Nn6ckgB9pDLTW/+ygmI+NJSqQkX3/igIxoLn/zU+4UfY/iocIeqws?=
 =?us-ascii?Q?8WSbUibsWr/PJPB03th6n9yg6NALxWZ00HC8D3tWzqK+xLgNu7dqiP6CSKDR?=
 =?us-ascii?Q?KXgu9Gqi5eQfwZ0XsR4HTCjqGuxc7MpKEomIqoCQlQ6Dywzqm7OI3qFgzhPo?=
 =?us-ascii?Q?jZHA6T9KhTxBOKlf8cvaZGS3cN3D3DWMCNyJnVMScMmV9xthzLGIHbTZ1jl/?=
 =?us-ascii?Q?q0eX69HYH9LFT+OVFdt7JRKIOUAdFCLspJD3MfghLrl4uD90P42HiqKH0yk9?=
 =?us-ascii?Q?EJZBqJ3PAxWgLDaJ2ewxEu8s+Xqdo2V6FHgZR4SneasQYTEkONY3k+/OkFgA?=
 =?us-ascii?Q?kk2teKKQAIKUlCblXPS70H7w4i15RpR2LW8xdXE1/YdAqzgY6n/vxNzzYAgJ?=
 =?us-ascii?Q?r9M6nhxHPpc2AMliu9GEceP0jPF9VzE9Wr+tfP/+76J9yRwzHvS9ZzdiME2V?=
 =?us-ascii?Q?tEQi7I2kbSwc0BNqxGUUfu7uItCAe4DQ+pxABmsJQXsbrIEAWl7iFhXuUlTr?=
 =?us-ascii?Q?FdQewTXXLwA7pbxfCSa3eZRHYpwgpqfb441M3iZpWK7YJ58dXpfr0/s7DF6g?=
 =?us-ascii?Q?kJXgJ6n4gy8CHemg3so8rRVSEkL80SLERSbHkoz1LZRn1HwINEMxaZPMz2ho?=
 =?us-ascii?Q?JqqbMlDMdKFcuUsd7DGxath8mnvjzrfcPqJyjZw3yvlPpGlyC8o/jovJUas+?=
 =?us-ascii?Q?TMEIrzWpvQL6Kv3QFWlD/jeDWrYSw6r9a/GGSHR3jaeZvdWI+rGI2NeRv593?=
 =?us-ascii?Q?aGuzGJ5Ecg0P/OTU68NkXAek8Bcz4h4OvOx1jY+en4vJswnxWRYFZCXjB2Yz?=
 =?us-ascii?Q?H4xgK+43VympRG+FO+9joXYWkJgfDHsgMmNtXUk3fMOkIPGs4GyTs80K5Ozl?=
 =?us-ascii?Q?lYhmTLaFm2QRSkHre1jszhqcTbElYOVGUhbqZ98i8T0ToJpZCEcmkavM6jDY?=
 =?us-ascii?Q?Rvlgo2OGOHgYbTEhP3V4i3CL/tVnB8fX8kZv51okiAgX2qLsg6yL8Rj4GKMu?=
 =?us-ascii?Q?LJFvsygozVwXpE9nhGLTqVvvEpBPT5x4dI4/Cb2Vs/cCWmPwx6h00RI5e4Ud?=
 =?us-ascii?Q?+oP9nO9w7cDzDYkmPNr3CtPo+14t1ds6e1pp3L2vvLFnYQCCqrdi1BkokMZK?=
 =?us-ascii?Q?+970faYyPQPHOw1938vStBMdY95P0ldmroLs7VvlSMc7Ztycxls0MaEyRFUg?=
 =?us-ascii?Q?bYjnM8qrxUdXDddE+wcepIef6JRaqXd0cutG10jG2tVEXSWMEeXFDbUKAHEb?=
 =?us-ascii?Q?p/GdlrYkydd/O7lX8WcNc69y7lIVkSu9YoIA7yCxkzU00DWSMKeDF9GTZ0xy?=
 =?us-ascii?Q?IIbGRUHIkvy02qrw6nPthS72?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6ed952-7f6b-441d-95fa-08d931a956e5
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:02:42.8469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSBQS4HuSwgtvo4Si7a8baMAaTFexMbuHvbXjOlskMA/prfczyAc4bl4V+NJLWcg2LE2TXlQIVRMO/ZDzuD6LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1412
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/agc_params.h | 151 ++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/agc_params.h

diff --git a/drivers/net/wireless/celeno/cl8k/agc_params.h b/drivers/net/wi=
reless/celeno/cl8k/agc_params.h
new file mode 100644
index 000000000000..e0f5816d6e07
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/agc_params.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_AGC_PARAMS_H
+#define CL_AGC_PARAMS_H
+
+#include <linux/types.h>
+#include <linux/bitfield.h>
+#include "def.h"
+#include "vendor_cmd.h"
+
+/**
+ * AGC (=3DAutomatic Gain Control)
+ */
+
+/* AGC PROFILE */
+#define AGC_PROFILE_BAND_OFFSET     28
+#define AGC_PROFILE_BAND_MASK       0xf0000000
+#define AGC_PROFILE_BRANCH_OFFSET   20
+#define AGC_PROFILE_BRANCH_MASK     0x0ff00000
+#define AGC_PROFILE_VERSION_OFFSET  12
+#define AGC_PROFILE_VERSION_MASK    0x000ff000
+#define AGC_PROFILE_RESERVED_OFFSET 0
+#define AGC_PROFILE_RESERVED_MASK   0x00000fff
+
+#define AGC_PROFILE(band, branch, version) \
+       (((band) << AGC_PROFILE_BAND_OFFSET) | \
+        ((branch) << AGC_PROFILE_BRANCH_OFFSET) | \
+        ((version) << AGC_PROFILE_VERSION_OFFSET))
+
+#define AGC_PROFILE_BAND(profile) \
+       u32_get_bits(profile, AGC_PROFILE_BAND_MASK)
+#define AGC_PROFILE_BRANCH(profile) \
+       u32_get_bits(profile, AGC_PROFILE_BRANCH_MASK)
+#define AGC_PROFILE_VERSION(profile) \
+       u32_get_bits(profile, AGC_PROFILE_VERSION_MASK)
+
+/* AGC PLATFORM */
+#define AGC_PLATFORM_CUSTOMER_OFFSET 16
+#define AGC_PLATFORM_CUSTOMER_MASK   0xffff0000
+#define AGC_PLATFORM_BOARD_OFFSET    8
+#define AGC_PLATFORM_BOARD_MASK      0x0000ff00
+#define AGC_PLATFORM_CHIP_OFFSET     4
+#define AGC_PLATFORM_CHIP_MASK       0x000000f0
+#define AGC_PLATFORM_RESERVED_OFFSET 0
+#define AGC_PLATFORM_RESERVED_MASK   0x0000000f
+
+#define AGC_PLATFORM(customer, board, chip) \
+       (((customer) << AGC_PLATFORM_CUSTOMER_OFFSET) | \
+        ((board) << AGC_PLATFORM_BOARD_OFFSET) | \
+        ((chip) << AGC_PLATFORM_CHIP_OFFSET))
+
+#define AGC_PLATFORM_CUSTOMER(platform) \
+       u32_get_bits(platform, AGC_PLATFORM_CUSTOMER_MASK)
+#define AGC_PLATFORM_BOARD(platform) \
+       u32_get_bits(platform, AGC_PLATFORM_BOARD_MASK)
+#define AGC_PLATFORM_CHIP(platform) \
+       u32_get_bits(platform, AGC_PLATFORM_CHIP_MASK)
+
+enum cl_customer_list {
+       CL_CUSTOMER_CELENO =3D 0,
+};
+
+enum cl_board_list {
+       /* Board list for Celeno customer */
+       CL_BOARD_EVB =3D 0,
+       /* Values from 1 to 5 are reserved */
+       CL_BOARD_MERLIN =3D 6,
+       CL_BOARD_EVB_6G =3D 7,
+       CL_BOARD_ALBATROSS =3D 8,
+       CL_BOARD_ALBATROSS_2 =3D 9,
+       CL_BOARD_CHAMELEON =3D 10,
+};
+
+struct cl_agc_reg {
+       u32 val;
+       u32 mask;
+};
+
+struct cl_agc_profile {
+       u32 id;
+       struct cl_agc_reg fsm_preset_p2;      /* 0x244 */
+       struct cl_agc_reg lna_thr_set0_ref2;  /* 0x25C */
+       struct cl_agc_reg lna_thr_set0_ref3;  /* 0x260 */
+       struct cl_agc_reg lna_thr_set1_ref2;  /* 0x264 */
+       struct cl_agc_reg lna_thr_set1_ref3;  /* 0x268 */
+       struct cl_agc_reg lna_thr_set2_ref2;  /* 0x26C */
+       struct cl_agc_reg lna_thr_set2_ref3;  /* 0x270 */
+       struct cl_agc_reg lna_gain_set0_ref2; /* 0x274 */
+       struct cl_agc_reg lna_gain_set0_ref3; /* 0x278 */
+       struct cl_agc_reg lna_nf_set0_ref2;   /* 0x27C */
+       struct cl_agc_reg lna_nf_set0_ref3;   /* 0x280 */
+       struct cl_agc_reg lna_icp1_set0_ref2; /* 0x284 */
+       struct cl_agc_reg lna_icp1_set0_ref3; /* 0x288 */
+       struct cl_agc_reg fsm_preset_p10;     /* 0x2A8 */
+       struct cl_agc_reg fsm_preset_p11;     /* 0x2AC */
+       struct cl_agc_reg fsm_preset_p12;     /* 0x2B0 */
+       struct cl_agc_reg ant_loss;           /* 0x300 */
+       struct cl_agc_reg gain_range;         /* 0x304 */
+       struct cl_agc_reg vga_ref0;           /* 0x308 */
+       struct cl_agc_reg lna_gain_set0_ref0; /* 0x30C */
+       struct cl_agc_reg lna_gain_set0_ref1; /* 0x310 */
+       struct cl_agc_reg lna_thr_set0_ref0;  /* 0x314 */
+       struct cl_agc_reg lna_thr_set0_ref1;  /* 0x318 */
+       struct cl_agc_reg lna_thr_set1_ref0;  /* 0x31C */
+       struct cl_agc_reg lna_thr_set1_ref1;  /* 0x320 */
+       struct cl_agc_reg lna_thr_set2_ref0;  /* 0x324 */
+       struct cl_agc_reg lna_thr_set2_ref1;  /* 0x328 */
+       struct cl_agc_reg lna_nf_set0_ref0;   /* 0x32C */
+       struct cl_agc_reg lna_nf_set0_ref1;   /* 0x330 */
+       struct cl_agc_reg lna_icp1_set0_ref0; /* 0x334 */
+       struct cl_agc_reg lna_icp1_set0_ref1; /* 0x338 */
+       struct cl_agc_reg saturation;         /* 0x364 */
+       struct cl_agc_reg ramp;               /* 0x36C */
+       struct cl_agc_reg dsp0;               /* 0x394 */
+       struct cl_agc_reg dsp1;               /* 0x398 */
+       struct cl_agc_reg dsp2;               /* 0x39C */
+       struct cl_agc_reg dsp3;               /* 0x3A0 */
+       struct cl_agc_reg lna_gain_set1_ref0; /* 0x590 */
+       struct cl_agc_reg lna_gain_set1_ref1; /* 0x594 */
+       struct cl_agc_reg lna_gain_set1_ref2; /* 0x598 */
+       struct cl_agc_reg lna_gain_set1_ref3; /* 0x59c */
+       struct cl_agc_reg lna_nf_set1_ref0;   /* 0x5A0 */
+       struct cl_agc_reg lna_nf_set1_ref1;   /* 0x5A4 */
+       struct cl_agc_reg lna_nf_set1_ref2;   /* 0x5A8 */
+       struct cl_agc_reg lna_nf_set1_ref3 ;  /* 0x5AC */
+       struct cl_agc_reg lna_icp1_set1_ref0; /* 0x5B0 */
+       struct cl_agc_reg lna_icp1_set1_ref1; /* 0x5B4 */
+       struct cl_agc_reg lna_icp1_set1_ref2; /* 0x5B8 */
+       struct cl_agc_reg lna_icp1_set1_ref3 ;/* 0x5BC */
+};
+
+struct cl_agc_params {
+       u8 num_profiles;
+       u8 ant_mask1;
+       u8 ant_mask2;
+       struct cl_agc_profile profile1;
+       struct cl_agc_profile profile2;
+};
+
+struct cl_chip;
+struct cl_hw;
+
+int cl_agc_params_read_platform_id(struct cl_chip *chip);
+int cl_agc_params_fill(struct cl_hw *cl_hw, struct cl_agc_params *agc_para=
ms);
+void cl_agc_params_print_profile(char **buf, int *len, ssize_t *buf_size,
+                                struct cl_agc_profile *profile,
+                                const char *str);
+int cl_agc_params_cli(struct cl_hw *cl_hw, struct cli_params *cli_params);
+
+#endif /* CL_AGC_PARAMS_H */
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

