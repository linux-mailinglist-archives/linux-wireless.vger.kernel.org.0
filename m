Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDDE532982
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbiEXLmA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236962AbiEXLky (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:40:54 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50064.outbound.protection.outlook.com [40.107.5.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1EC9346A
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E47LHLsqXIGVjuNwdpUvVZpSBlfqZ9wCpjunADypRoLus79dbUHAPz8NUBIKtCfXsPbXa/H1IIRQssgV/59xaFVE5XtHD04k0Hl424B7YDHpr9QQMGokJYsBze9oxp2ynTFUNKXFMbl7MA3LoWU43lQwjd+bPiYvLQEX/sYQ7VqiEoFFygCiCwovCAHtFXMGRhxahXyhVBEV0ydlsnJu1KsQFDJadaMwwgk9sDnax+MRtb9ZoJ15kW/C5QZSMJ4LBVi2/SlgkicF/uqeVLraDWu29nwDkfHh2wyrbl+g5OOI1ZY8ufFrWthuBTIC+wMAUkYdxrnu0eRO17RunH3qcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hz9hn2VBY/kFqcnhWJGsFs6PUGJeFU2PTE6ZifvSUo=;
 b=bXdWZH3dXX0MvuybUB5hlN7rutLIyUtMJrr5dMaLE6e2KypVvPo6KLcQK5LaKrgWXulLcbdQFZnWfjJ5d9D1UeOiw/Sf7eagi7kTbly9LC/XIj+BiM0P8qQZMCkiOp+6+dKJnu3QLelMGy8WD9iN+VUmayui9Xs5e+qyqXQhk+cr10sOZlObolSRkf0b6xUf62AEjIh/b+VCFU2R0/CO9MhRfP6Vd+C9YkH3mQUFo1YM9stzGhpoIBgtQyL12Op+FIRZ7KHvFgZOEh/GGIoQ2SmY5bNpYkA/pBG7CYx8ZcgGDVJUPvtApdalglpwvW9a4fPRHQLR2fOptdC/1WR2mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hz9hn2VBY/kFqcnhWJGsFs6PUGJeFU2PTE6ZifvSUo=;
 b=y94WDjyBVhuLD0GgT/1NEJuZA5cncwHaWImHHq/p9HUxUvSAMvrp2v6kCMRA70Lt5rW2yM2cl9YVXSqach4FX1XYECI2G25yLNOV/9708iL/+dZFoqCaOJTmwPWd/2guZF436rtMPAt/ara3a0R9A1cgBbxBKyZ+VTVahYo+JXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by DU0P192MB1571.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:34c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 11:39:23 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:23 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Maksym Kokhan <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v2 61/96] cl8k: add recovery.h
Date:   Tue, 24 May 2022 14:34:27 +0300
Message-Id: <20220524113502.1094459-62-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220524113502.1094459-1-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR10CA0092.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::33) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff6e7bea-8fd4-4aa3-74a5-08da3d79f181
X-MS-TrafficTypeDiagnostic: DU0P192MB1571:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <DU0P192MB1571C3451DAB011342843467F6D79@DU0P192MB1571.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0fkh921AaPuQWYXQUuDu2SJSoWYXyONxVF8/dC/Aw36YOxnqnH6oWwR2f0TqXll+3Gnj1ZEiGHNvo9UZ7pFMRFlBSU4BD0dgc/ze1q3dCoOZTOnhyCw9EZNrQtyjTIsEnkV4yFGCMkUkyYgF+t3ZCMs+XyOTbvKzVSwSDMXx7L60W0xpl6ebwmzvBRMT6M4BeWxDI0h7vel5l05HGcc6Hfjyp8HF5s/6i2KggE3vYuLRp4TrFJoCEkmorQh3+zX4O8giH9zMVxiRr3ydZ1GnM2hIqV6Xso5G41BC2GC1SpyAUeJaALq4Et9GJJuqSL9mVP4ZDXBr74p6oQyGBvB0iOnF363IFVouyRz7sSzWMoy7nopiWIsEBMcDNiE3jPyobtBLXMfSo07vu3wml55J/p3ILvDHGfnG9PU7JuIJQfuNZefy6Xh7AtJFUEn4RrY7p+Klwj6B6XCc9wxpgvZbK+LCPMMYZ/Plhfww6204KyaPL/3jrYqNr1qda6u2NGh9ymmZg41tH31LLQqOjqk5XY6Pu3Sjh3rdACB4U3TBFgJxD3MbD1Uun7GNDo/DGplAGpom8m/xahU7Fo0rN6cIHEaC6PYfPXuwfaaWmj3Kh9sG8h2KFb3/c03hesJASzwivDypxAaZ9rNY92gICed2hJY1g5d99RBaq2P02EhgUVf519GjuTaKRrXD2G1psoLE5LpxAdi/Atsa42SEyZrWRCI2i9VmfiX33+dTRwcdyW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(39850400004)(346002)(396003)(376002)(6512007)(186003)(6916009)(9686003)(38350700002)(38100700002)(41300700001)(36756003)(316002)(54906003)(2616005)(1076003)(86362001)(107886003)(8676002)(66476007)(4326008)(66556008)(66946007)(52116002)(8936002)(6506007)(2906002)(83380400001)(508600001)(5660300002)(6486002)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RU1unefGxGsI/UYulhYuf9bIAf1vQWJr5Uq5XJjD997lJhQYWZbFS3yb0MbS?=
 =?us-ascii?Q?lqMEVLFUZZupYQIx2d+QQm8mZkLkrOFle4Um9DJhpXKOfoUdXziLTONIbiDP?=
 =?us-ascii?Q?q8T0LTNbKMzIUGjqv5EJjMCJsWNKU4c3K+BDVAybFxUK4JlcWuziP8mCOi8M?=
 =?us-ascii?Q?PNQXf9kbmRsa9m42A22xwH2gA6hG08p6e6LPNKopWcahKkdptUepdVXv2JV/?=
 =?us-ascii?Q?tANOyV2gRnizQr+irc5CxMe/l0yoQayY9AujAkDyJJm97BLqqF4IBZOgwK3i?=
 =?us-ascii?Q?Sn54bKK7DLtVFwWnWqlyKicKz+dv2oDn4BsxohoB8vYe4DM063/dIO70g05a?=
 =?us-ascii?Q?o5bUKMG/pUmbOAWJNnx7/uFT1KG3l7hrw5mZGhheYBMlC+Q7WDWWCaXaTCoo?=
 =?us-ascii?Q?Jp+DhGzIjPUUOcg6Q4y9OoOymSiBZVoVnchOUzuemmZKlHB7M3bqxa9iXMXf?=
 =?us-ascii?Q?6H3PFeyNl9NIDkmN4f35dqcaf2wU5GYmU6hhhOS6U/kdT1fABwonpdZzOMC+?=
 =?us-ascii?Q?rHoaadxFS5aE/jeXx7XnqSYjqScT640cOzePb0G8IsAq0PrO3QcB/VqoGFnD?=
 =?us-ascii?Q?LqC6H445grdC3rOzrfyyLldkMJKYtybLLJuj2kGM4dCwKOepwfcBHNJqmjkU?=
 =?us-ascii?Q?PFnOt6Vc+GTC6+nrPrUACIz/XdwzlgyORSmKR6xRGEWjWdeg00F4Jh+rXrwV?=
 =?us-ascii?Q?LTPQrUG1VgZg+1AdrfdkCpO2MMnqbPmf7KdMlm/GkHsIL8hSBwmZ3Muk0iwP?=
 =?us-ascii?Q?ZavT4Y5K2HbCtHQbX3rIeN56ig/53RSdkwE2/TbRNGkxU9LLO+MGECUdskrx?=
 =?us-ascii?Q?/fkKrEH9DrvARydhQeivC5/K/G+8LbkCTB9FKgm5scxI+guAKLvN6g1+yXm/?=
 =?us-ascii?Q?G9OxkuuZKFWyXe4QkCiyCY7uKDyTdyj5Tigp7EauKXf5P00w05HzCRY0zqTq?=
 =?us-ascii?Q?TVkhLVf/O586clrMbBi2YSzTsdiwIusAnTmOo1KTT1cvRO39jmRWl/QwVmfV?=
 =?us-ascii?Q?/cswDuJVIXVHIys6IfB59pPBdwNfsT59yPLnDzLRQVPGe9KypKKW6g8BQVmq?=
 =?us-ascii?Q?ZLIwdYtzkJ2V0X+nLsUVR+qlPi0wmBWO07LlDg8wStSroRdG25rwn7e2eKzM?=
 =?us-ascii?Q?BH3ZdnVg9YQDJCeiNhyDf8oLYgE/UYPjGNV6bV9/+KbG/EkP0sOqYbd/DO/+?=
 =?us-ascii?Q?MhPtxT1GH91fphC60BqTieg2Aua4wgB+KTjOXtqOctTcVnZDYuLVrOFlkblG?=
 =?us-ascii?Q?2+t6K6K3rxWYBFe8bM4Z535ct5f+JBojFwDTFs9f+Rqka5JgoBUhkFJcArVh?=
 =?us-ascii?Q?MRny1ENKdTBJOMiMkUsholGOaAoGiG1X1YAyoQU9AL4DaE47tFPAbqMJD+w/?=
 =?us-ascii?Q?DRzWS0dbhtCn+amtMqGVTbfikXvRAdI8O/3tSGX0NDd5fWHFGh49otEnfdcI?=
 =?us-ascii?Q?4xl5jdJVGLObCYYaB6Gfcd3ohwrh3apYKF4ikEUtTJxskHJ6YJrHxNyZb8LB?=
 =?us-ascii?Q?u+i74Lrn5xyk9K8pqYpuI/9H4PM7/yETFemtFcOjHwkxMXx2YwGHPDFc4TPa?=
 =?us-ascii?Q?T8nAV0Xp4ZRpDTGZf2Ix21mtQxB6MKL47h4llY3Lf4s7RH1pRyOZczQBpV6j?=
 =?us-ascii?Q?OpUxD1Qc0ScAa1TFQqe79M7mrDtnp519JBlZDTF1wU2a+wl3uro0YlA9qoOj?=
 =?us-ascii?Q?bwv5FgHrXkufRWBZS3AlbuFJn+HVJIiXJwlrzk0qoTBDPVQWPy0rKQmxT6R3?=
 =?us-ascii?Q?gXt7F/bTSHzGqxkRsAshdPz9QdhPS30=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6e7bea-8fd4-4aa3-74a5-08da3d79f181
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:37.9882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7Y2EIGN3fnuulX4lrV0EytKFqvYHDvKkVgUu111+Giei2Yte03hNhaTrWLsRmgHK1HBv8lsUA3Nx6XfUW29hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB1571
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/recovery.h | 39 +++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/recovery.h

diff --git a/drivers/net/wireless/celeno/cl8k/recovery.h b/drivers/net/wireless/celeno/cl8k/recovery.h
new file mode 100644
index 000000000000..303259d5d802
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/recovery.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_RECOVERY_H
+#define CL_RECOVERY_H
+
+#include <linux/types.h>
+
+enum recovery_reason {
+	RECOVERY_WAIT4CFM,
+	RECOVERY_UNRECOVERABLE_ASSERT,
+	RECOVERY_UNRECOVERABLE_ASSERT_NO_DUMP,
+	RECOVERY_ASSERT_STORM_DETECT,
+	RECOVERY_DRV_FAILED,
+};
+
+enum cl_fw_wd_mode {
+	FW_WD_DISABLE,
+	FW_WD_INTERNAL_RECOVERY,
+	FW_WD_DRV_RELOAD,
+};
+
+struct cl_recovery_db {
+	unsigned long last_restart;
+	u32 restart_cnt;
+
+	u32 ela_en;
+	u32 ela_sel_a;
+	u32 ela_sel_b;
+	u32 ela_sel_c;
+
+	bool in_recovery;
+};
+
+bool cl_recovery_in_progress(struct cl_hw *cl_hw);
+void cl_recovery_reconfig_complete(struct cl_hw *cl_hw);
+void cl_recovery_start(struct cl_hw *cl_hw, int reason);
+
+#endif /* CL_RECOVERY_H */
-- 
2.36.1

