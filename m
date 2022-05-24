Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEA2532955
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbiEXLjh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbiEXLjf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:35 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50088.outbound.protection.outlook.com [40.107.5.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB25E8CCEA
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RngjiYnJJrvTL/Cd1kRYHTBIZLm4H6OJCtVMuaOxQvfw9BW15ZX1ds1ih1xjEd4fM5O2j8cCXbs18YwqIRbpwjgPUkGD77SnPuhdSabP8wl7suCqGrCMbcbyrWtODayo4qCnR36SHTMDJGv+T9+WcF1txOQbFXVxY2gn1x25lVzCXniQ2A2AFgr8pgYUmXr/schi7n3aI/wT5skIOFzshYdgWJFEINP8H8Njiv7j3atoGfPtDMUemVeRFt0/fTrPnXQfPbJJd8P2s5HwaN56Y+KXbwuKeIAQmZHB3rReXfcuHs68WYPOQOiHqcp68xQU9JctbFzVgmF95ryleNz1lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMKvWTleB9iG/UOWfQmbR9WPHfo2LA9D9BYTg+SEASs=;
 b=aI4haBqzysYA00efM05pfISOb0//htfU/zAFa7+M+vMdmtv7NzGigi0BySTeu/gdvi25R9ypdCY90e0RCOuEi6/gUWmASVminlSBZU0mZ41kiog0azMrBFqKB+jtpbyPmVg1fgs8uHkVtzvBT5UAVmHeY+W47Oc/ClSzOFVGDiCjNghYhS3xY01ACAcI9wBFSwMA3RlvfGpr7uY9p9AiIuxDWN47J5ki44l2/J7Zn7316vCjzE+wwE0UluIXr0S3LvueGVqokGpouy7PH31mBvlNUeg2PBuNYt0KeSWTOg+asGPpLQufr+g0d11w+VDeaLpE+NWKsamJcTPGnfIXkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMKvWTleB9iG/UOWfQmbR9WPHfo2LA9D9BYTg+SEASs=;
 b=q8zsStpGvpy7wUTSLxBAFyhbfwDSxen87YdD9vwynlTZoCJcMsv06xauZzrgNZJwpwT/0DVfV3AUKR3dpOAFzfE6KGhPddsGVwRbn1bvDtpNfWoprJEo4SDuScJ52YxvKs+v1ySFFj366PqXyJbIIKadAmMREhtyVGbk+YxzktE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by DU0P192MB1571.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:34c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 11:38:48 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:48 +0000
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
Subject: [RFC v2 52/96] cl8k: add platform.c
Date:   Tue, 24 May 2022 14:34:18 +0300
Message-Id: <20220524113502.1094459-53-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 99a7fd48-4964-4171-0c27-08da3d79ed80
X-MS-TrafficTypeDiagnostic: DU0P192MB1571:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <DU0P192MB1571A943A945F1A1F3FD571EF6D79@DU0P192MB1571.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KMiw8H6Hfu05mK0K+8ssQ6a4HVFXS6DadEUqdL1R3feEP7CN8gG+sjh3Gh721AZlqF0tTHF/j4AQJES0Po6OnyXVLzw7L+a2zSHdMBWDI3U4n/PINrWycG1RxWMoE7BXWUbwodee8KXNKyi/EnU3kIeWYRIBCXuxd8tVsUnrMjMKH9AseGpHOB0A33Lio8L7/6Y8HP5Kpc4t1zsLkrSkd2b08B5zWpiDwQM+zAIGK01+X6TZxNySUj20JEtREbXa9CrQujxBl+WHC1d7qZJ6NiLKIBRZxt2PeVfgkdAPpmebmMlQzsn+mT/DdMNzejm8OaUy8monsDS215HKGdScXWYzQSF613Hy5iTBA5pXQ8QInmsa8lvm8nX5plERICBP6FUlB4JH9mk6Q/EGml3QxWh7FBne3r8x2ujIMtbbJivMhwiDgd2ujLFLD0Q/SRluQweEUPwwt5q756UMJeblhFDBG0izPESlATxdSxunMNAj06b+IxbHGRE0V7BHcIz0Yxx2PZE8gzzHzhlG6kcHnZII+7WRQsKVihfRSEEZX2p/n0fwe+HsEixx/PVedgak8qIHiGTkCO9rmWYySTJ/A/MOpuOgqA8znBzwS6zIB4ouzEQUKfaYJ+hwAYZ+wQRajZkicr8YbLRLnGAn7ImTPX0Pk9KJB3+vd6U+0BI52dfwGCbccqJAhFVCtvYrX0CZQnT49raI4xdHN3R+Ob86Mto0y6sF8pLq8xdzKQkIVmw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(39850400004)(346002)(396003)(376002)(6512007)(186003)(6916009)(9686003)(38350700002)(38100700002)(41300700001)(36756003)(316002)(54906003)(2616005)(1076003)(86362001)(107886003)(8676002)(66476007)(4326008)(66556008)(66946007)(52116002)(8936002)(6666004)(6506007)(2906002)(83380400001)(508600001)(30864003)(5660300002)(6486002)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zmoPGFwuDOA1kHPC6zhqdWc/T1TDF3CA1Qwq01dvuUWtqn+6Fu21ImcOYMZF?=
 =?us-ascii?Q?e+tdu9Xo2W416eN0nRyFl8U+Oj8mKD5Oc3TI4YCU2er/f72EMcvwoYSWnDSn?=
 =?us-ascii?Q?nVjdtx2GMmwiuk1dSp4Bx4v3BNd0oEUOCuaOe9lyptpw0ALEgfnh6TgN9+S2?=
 =?us-ascii?Q?ezWIKbVpigJi4soYVOAsK+1wDRjaYPIifrN9kmxDRXAvuAwiPUc2tH9m4rZf?=
 =?us-ascii?Q?ZgoKp6w+ivtzc3dpvxbmajIoSg98zmF4mgPgRzFOUf2ng3tkMP4wo4ZZqQ3z?=
 =?us-ascii?Q?YsAIa59UqeNeSz3eePoh7W6ePoTddYzsjSZehvSBHnGMx5K9FLF9Up0J9uIC?=
 =?us-ascii?Q?0Gfazmse7ljSIRYXtpOBx9kM3CtVh53Thh/0s5RUQFYSYUw84X/SJNanaaDk?=
 =?us-ascii?Q?nf/8DOGx9ZzRpUYNHsUaqsAo5wJ5PnYxE0K1pWVZSz1+2GIhC6vegAsOJ9zD?=
 =?us-ascii?Q?/4EmLJPVbKUZOuimW+18b7wiU9/uTMdJZ7uPit/x4Z0ylLv4w1lPNmqba/ea?=
 =?us-ascii?Q?GB6viHYeXvKacrqnYH6YANkRl91jJyKCRcwEpuiZa+HNnX1pLHY97dOMxt8U?=
 =?us-ascii?Q?V1UtfpL+gFNlwK4BveJyw2eyGvpKCJKq6uRXWmc/sMGZt20ktAsl53XAfxle?=
 =?us-ascii?Q?Gc21U9Flv+yWHtAtE8DFwvGGfCxcDqsKWpe56QkXQ7p3WEhYFrHH0wm6ToOx?=
 =?us-ascii?Q?EV+TopOao7TuL6hSdZ0dJvFREtILoTqv6CYePHSWXykt+yEtYNBSlS5OuPhK?=
 =?us-ascii?Q?M7/k5PqbeDcF7rcWU3njRRkCZ0TAQJqWswX8wXXh3jU8EkgdMFE4/Qy3SIB8?=
 =?us-ascii?Q?9g1DGJEwX0ws1nA2gKhfEj8BKbBogSPlK9z8TG19T7sZFMKgYY98O9bAWeNe?=
 =?us-ascii?Q?FUYni6VGWSV2ozF5X/Lryk7TSOb+orZIVRBf3Aoo7XB+KghNoLW332lJlIJM?=
 =?us-ascii?Q?/gRBZny83jVkx5ttwnKKuw9GttEqhcSnNa6ZYmSflPliEpZCIDWK3CXos71v?=
 =?us-ascii?Q?BqbhvHPj5XZcMNZDCI5SLI25oyXe753lnpGajAaddnDAMvo/XuX4tWNw0Zp0?=
 =?us-ascii?Q?WIBDeDw3Xj2f3mGQdMPwf6l30eCohMj/LPlxEB5kxzuOzjfDz0cm47tssu6w?=
 =?us-ascii?Q?llTaZHxxpJ5Z8QyhqVVzuoKdWxWNMll6xNtUhKlEYCQ9qd7R7W1gGCC34jJp?=
 =?us-ascii?Q?BubxJt4PDRL+rXXx0puMnm9S5VDsMxspWK/2TuMw6ZkQDFssAaOsFo0uEz0o?=
 =?us-ascii?Q?EAVO0RFEE7torTyT6pf/qE+KGznkgznjhCFa6GRBsz9Q7c+cpByffvl5VD2q?=
 =?us-ascii?Q?Tub/VS6X0dWWgR6PURYZQ5Si+IwFGaG/YKFdxXA6E/VioiXuDrn+PNhT9vOB?=
 =?us-ascii?Q?KmuZlbn65EjTrmTjJsKDwTLbzoXYl+UN8/y/h+MjkJZsTuGIQGbgI5MEMPM3?=
 =?us-ascii?Q?Tkx/+1pAlmVS758SX5iLdt6sod0dYIJBDtxizkf4Yaiv/NPArQyf71a0S6Nl?=
 =?us-ascii?Q?6o2rLM/uoV9w3CVdqZ+vs7LyxD2eB1TTTByrwRjS5XTFxOgpxuXRNIcSqlLp?=
 =?us-ascii?Q?Q8JqU8pAd7vD8sGJJQchNC6fJvxrCNga8xYinxebE8Vl9D76krdhpCG7cmDZ?=
 =?us-ascii?Q?SQdgIRJS1X/agqH7/LGkRxYm10HIkN1NXd/K78Bru5Z5MJn4ABHne+CQJiu5?=
 =?us-ascii?Q?fv1jYtMF/3xNejKgaqiGuJjdiR6OjcJyv1u5CN+xxK8QnFWQCl3Bed2y/jTN?=
 =?us-ascii?Q?Vj6kzXTAzVawhO+y9Dy3h9f8jRVaHq4=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a7fd48-4964-4171-0c27-08da3d79ed80
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:31.2837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaub5LcSblWjWJjB0OXkATXqcN0kS+MzmsGqmTKQnHRICWDg64KIoVfBlbWjxwWk910UvZVFYn/zcehaEpaiCg==
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
 drivers/net/wireless/celeno/cl8k/platform.c | 392 ++++++++++++++++++++
 1 file changed, 392 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/platform.c

diff --git a/drivers/net/wireless/celeno/cl8k/platform.c b/drivers/net/wireless/celeno/cl8k/platform.c
new file mode 100644
index 000000000000..140505523fb2
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/platform.c
@@ -0,0 +1,392 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include <linux/types.h>
+
+#include "e2p.h"
+#include "debug.h"
+#include "utils.h"
+#include "hw.h"
+#include "platform.h"
+
+static int cl_platform_update_idx_v1(struct cl_chip *chip)
+{
+	u8 i = 0;
+	u32 platform_id = 0;
+	struct cl_agc_platform_pack *app = chip->platform.app;
+	ssize_t buf_len = chip->platform.app_size;
+	ssize_t data_len = buf_len - sizeof(*app);
+	ssize_t offset = 0;
+	struct cl_platform_binding *platform = NULL;
+
+	if (cl_e2p_read(chip, (u8 *)&platform_id, SIZE_FEM_PLATFORM_ID, ADDR_FEM_PLATFORM_ID))
+		return -1;
+
+	cl_dbg_chip_verbose(chip,
+			    "platform_id: 0x%08x, "
+			    "customer_id: 0x%04x, board_id: 0x%02x, chip_id: 0x%x\n",
+			    platform_id,
+			    PLATFORM_CUSTOMER(platform_id),
+			    PLATFORM_BOARD(platform_id),
+			    PLATFORM_CHIP(platform_id));
+
+	while (offset <= data_len) {
+		struct cl_agc_tilv *tilv = (struct cl_agc_tilv *)((u8 *)app->data + offset);
+
+		if (tilv->t == CL_AGC_PACK_EOF || tilv->t == CL_AGC_PACK_UNDEFINED)
+			break;
+
+		if (tilv->t != CL_AGC_PACK_PLATFORM_BINDING)
+			goto next_tilv;
+
+		platform = (void *)tilv->v;
+		if (platform_id != platform->platform_id)
+			goto next_tilv;
+
+		cl_dbg_chip_verbose(chip, "%s\n", platform->platform_description);
+		chip->platform.idx = i;
+		return 0;
+next_tilv:
+		i += 1;
+		offset += sizeof(*tilv) + tilv->l;
+	}
+
+	if (IS_REAL_PHY(chip)) {
+		CL_DBG_ERROR_CHIP(chip, "Invalid platform_id 0x%08x\n", platform_id);
+
+		if (!chip->conf->ce_production_mode)
+			return -1;
+	}
+
+	return 0;
+}
+
+struct cl_platform_table *cl_platform_get_active_table(struct cl_chip *chip, u8 idx)
+{
+	bool is_active = (idx == chip->platform.idx);
+
+	if (idx >= cl_platform_get_tables_cnt(chip))
+		return NULL;
+
+	if (is_active && chip->platform.app)
+		return &chip->platform.table;
+
+	return NULL;
+}
+
+static int cl_calc_platforms_number(struct cl_agc_platform_pack *app, ssize_t buf_len)
+{
+	ssize_t data_len = buf_len - sizeof(*app);
+	ssize_t offset = 0;
+	int ret = 0;
+
+	while (offset <= data_len) {
+		struct cl_agc_tilv *tilv = (struct cl_agc_tilv *)((u8 *)app->data + offset);
+
+		if (tilv->t == CL_AGC_PACK_EOF || tilv->t == CL_AGC_PACK_UNDEFINED)
+			break;
+
+		if (tilv->t != CL_AGC_PACK_PLATFORM_BINDING)
+			goto next_tilv;
+
+		ret += 1;
+next_tilv:
+		offset += sizeof(*tilv) + tilv->l;
+	}
+
+	return ret;
+}
+
+static void *cl_find_tilv_data(struct cl_agc_platform_pack *app,
+			       ssize_t buf_len, u8 seeking_id, u8 seeking_type)
+{
+	ssize_t data_len = buf_len - sizeof(*app);
+	ssize_t offset = 0;
+	void *ret = NULL;
+
+	if (seeking_type >= CL_AGC_PACK_MAX)
+		return NULL;
+
+	while (offset <= data_len) {
+		struct cl_agc_tilv *tilv = (struct cl_agc_tilv *)((u8 *)app->data + offset);
+
+		if (tilv->t == CL_AGC_PACK_EOF || tilv->t == CL_AGC_PACK_UNDEFINED)
+			break;
+
+		if (tilv->t != seeking_type)
+			goto next_tilv;
+
+		if (tilv->i == seeking_id) {
+			ret = (void *)&tilv->v;
+			break;
+		}
+
+next_tilv:
+		offset += sizeof(*tilv) + tilv->l;
+	}
+
+	return ret;
+}
+
+static struct cl_platform_binding *cl_find_binding(struct cl_agc_platform_pack *app,
+						   ssize_t buf_len, u8 seeking_id)
+{
+	return cl_find_tilv_data(app, buf_len, seeking_id, CL_AGC_PACK_PLATFORM_BINDING);
+}
+
+static struct cl_agc_profile_per_bw *cl_find_agc_profile(struct cl_agc_platform_pack *app,
+							 ssize_t buf_len, u8 seeking_id)
+{
+	return cl_find_tilv_data(app, buf_len, seeking_id, CL_AGC_PACK_PROFILE);
+}
+
+static const u8 *cl_find_power_table(struct cl_agc_platform_pack *app,
+				     ssize_t buf_len, u8 seeking_id)
+{
+	return cl_find_tilv_data(app, buf_len, seeking_id, CL_AGC_PACK_POWER_TABLE);
+}
+
+static bool cl_is_valid_agc_profile(u8 profile_id)
+{
+	return (profile_id >= CL_AGC_PROFILE_FIRST) &&
+		(profile_id < CL_AGC_PROFILE_MAX);
+}
+
+static bool cl_is_valid_power_table(u8 table_id)
+{
+	return (table_id >= CL_POWER_TO_POWERWORD_CONV_TABLE_FIRST) &&
+		(table_id < CL_POWER_TO_POWERWORD_CONV_TABLE_MAX);
+}
+
+int cl_platform_get_tables_cnt(struct cl_chip *chip)
+{
+	return cl_calc_platforms_number(chip->platform.app, chip->platform.app_size);
+}
+
+int cl_platform_unpack_v1(struct cl_platform_table *table,
+			  struct cl_agc_platform_pack *app,
+			  ssize_t buf_len, u8 platform_idx)
+{
+	struct cl_platform_binding *binding = NULL;
+	u8 profile_id = CL_AGC_PROFILE_UNDEFINED;
+
+	binding = cl_find_binding(app, buf_len, platform_idx);
+	if (!binding)
+		return -ENODATA;
+
+	/* Find corresponding binding */
+	table->platform_id = binding->platform_id;
+	memcpy(table->platform_description, binding->platform_description,
+	       sizeof(table->platform_description));
+
+	/* Bind AGC profiles */
+	profile_id = binding->agc_profile[TCV0];
+	if (cl_is_valid_agc_profile(profile_id))
+		table->agc_profile[TCV0] = cl_find_agc_profile(app, buf_len, profile_id);
+
+	profile_id = binding->agc_profile[TCV1];
+	if (cl_is_valid_agc_profile(profile_id))
+		table->agc_profile[TCV1] = cl_find_agc_profile(app, buf_len, profile_id);
+
+	profile_id = binding->agc_profile_elastic[TCV0];
+	if (cl_is_valid_agc_profile(profile_id))
+		table->agc_profile_elastic[TCV0] = cl_find_agc_profile(app, buf_len, profile_id);
+
+	profile_id = binding->agc_profile_elastic[TCV1];
+	if (cl_is_valid_agc_profile(profile_id))
+		table->agc_profile_elastic[TCV1] = cl_find_agc_profile(app, buf_len, profile_id);
+
+	profile_id = binding->agc_profile_sensing;
+	if (cl_is_valid_agc_profile(profile_id))
+		table->agc_profile_sensing = cl_find_agc_profile(app, buf_len, profile_id);
+
+	/* Bind power tables */
+	if (cl_is_valid_power_table(binding->power_conv_table_2))
+		table->power_conv_table_2 = cl_find_power_table(app, buf_len,
+								binding->power_conv_table_2);
+
+	if (cl_is_valid_power_table(binding->power_conv_table_5))
+		table->power_conv_table_5 = cl_find_power_table(app, buf_len,
+								binding->power_conv_table_5);
+
+	if (cl_is_valid_power_table(binding->power_conv_table_6))
+		table->power_conv_table_6 = cl_find_power_table(app, buf_len,
+								binding->power_conv_table_6);
+
+	return 0;
+}
+
+static int cl_platform_unpack(struct cl_chip *chip)
+{
+	int ret = 0;
+	struct cl_agc_platform_pack *app = chip->platform.app;
+	ssize_t buf_len = chip->platform.app_size;
+
+	if (strncmp(app->magic, PLATFORM_PACK_MAGIC_V1, sizeof(app->magic)) != 0) {
+		cl_dbg_chip_err(chip,
+				"Magic differs, got %s, expected %s\n",
+				app->magic, PLATFORM_PACK_MAGIC_V1);
+		return -EINVAL;
+	}
+	if (le32_to_cpu(app->version) != PLATFORM_PACK_VERSION_V1) {
+		cl_dbg_chip_err(chip,
+				"Invalid pack version: %u\n",
+				le32_to_cpu(app->version));
+		return -EINVAL;
+	}
+
+	ret = cl_platform_update_idx_v1(chip);
+	if (ret)
+		return ret;
+
+	ret = cl_platform_unpack_v1(&chip->platform.table, app, buf_len,
+				    chip->platform.idx);
+	return ret;
+}
+
+int cl_platform_alloc(struct cl_chip *chip)
+{
+	char filename[CL_FILENAME_MAX];
+	size_t size = 0;
+	char *buf = NULL;
+	int ret = 0;
+
+	snprintf(filename, sizeof(filename), PLATFORM_PACK_FILENAME_V1);
+	size = cl_file_open_and_read(chip, filename, (char **)&buf);
+	if (!buf) {
+		cl_dbg_chip_err(chip, "AGC platform pack data buffer is empty\n");
+
+		ret = -ENODATA;
+		goto err;
+	}
+
+	chip->platform.app_size = size;
+	chip->platform.app = (struct cl_agc_platform_pack *)buf;
+
+	ret = cl_platform_unpack(chip);
+err:
+	return ret;
+}
+
+void cl_platform_dealloc(struct cl_chip *chip)
+{
+	if (chip->platform.app) {
+		kvfree(chip->platform.app);
+		chip->platform.app = NULL;
+		chip->platform.app_size = 0;
+	}
+}
+
+/* AGC PROFILE */
+#define AGC_PROFILE_BAND_MASK       0xff000000
+#define AGC_PROFILE_BRANCH_MASK     0x00ff0000
+#define AGC_PROFILE_VERSION_MASK    0x0000ff00
+
+#define AGC_PROFILE_BAND(profile) \
+	u32_get_bits(profile, AGC_PROFILE_BAND_MASK)
+#define AGC_PROFILE_BRANCH(profile) \
+	u32_get_bits(profile, AGC_PROFILE_BRANCH_MASK)
+#define AGC_PROFILE_VERSION(profile) \
+	u32_get_bits(profile, AGC_PROFILE_VERSION_MASK)
+
+#ifdef __BIG_ENDIAN_BITFIELD
+static void cl_agc_profile_to_le32(struct cl_agc_profile *profile)
+{
+	u32 i;
+	u32 size = sizeof(struct cl_agc_profile);
+	u32 *ptr = (u32 *)profile;
+
+	/* Make sure that size divides by 4 */
+	WARN_ON((size & 0x3) != 0);
+
+	for (i = 0; i < size / 4; i++)
+		ptr[i] = cpu_to_le32(ptr[i]);
+}
+#endif
+
+int cl_agc_params_fill(struct cl_hw *cl_hw, struct cl_agc_params *agc_params)
+{
+	u8 tcv_idx = cl_hw->tcv_idx;
+	u8 platform_idx = cl_hw->chip->platform.idx;
+	u8 bw = cl_hw->bw;
+	struct cl_platform_table *table = NULL;
+
+	memset(agc_params, 0, sizeof(struct cl_agc_params));
+
+	if (platform_idx == U8_MAX)
+		return 0;
+
+	table = cl_platform_get_active_table(cl_hw->chip, platform_idx);
+	if (!table)
+		return -EINVAL;
+
+	if (!table->agc_profile_elastic[tcv_idx] || cl_hw->num_antennas <= 2) {
+		u8 ant_shift = cl_hw_ant_shift(cl_hw);
+
+		if (table->agc_profile[tcv_idx]) {
+			agc_params->profile1.id = table->agc_profile[tcv_idx]->id;
+			agc_params->profile1.regs = table->agc_profile[tcv_idx]->regs[bw];
+		} else if (tcv_idx == TCV1 && table->agc_profile_sensing) {
+			agc_params->profile1.id = table->agc_profile_sensing->id;
+			agc_params->profile1.regs = table->agc_profile_sensing->regs[bw];
+		} else {
+			CL_DBG_ERROR(cl_hw, "Invalid tcv/sensing profile");
+			return -1;
+		}
+
+		agc_params->num_profiles = 1;
+		agc_params->ant_mask1 = ANT_MASK(cl_hw->num_antennas) << ant_shift;
+		agc_params->ant_mask2 = 0;
+
+#ifdef __BIG_ENDIAN_BITFIELD
+		cl_agc_profile_to_le32(&agc_params->profile1);
+#endif
+	} else {
+		if (table->agc_profile[tcv_idx]) {
+			memcpy(&agc_params->profile1,
+			       table->agc_profile[tcv_idx],
+			       sizeof(struct cl_agc_profile));
+		} else {
+			CL_DBG_ERROR(cl_hw, "Invalid tcv profile");
+			return -1;
+		}
+
+		if (table->agc_profile_elastic[tcv_idx]) {
+			memcpy(&agc_params->profile2,
+			       table->agc_profile_elastic[tcv_idx],
+			       sizeof(struct cl_agc_profile));
+		} else {
+			CL_DBG_ERROR(cl_hw, "Invalid elastic profile");
+			return -1;
+		}
+
+		agc_params->num_profiles = 2;
+		agc_params->ant_mask1 = ANT_MASK(2);
+		agc_params->ant_mask2 = ANT_MASK(cl_hw->num_antennas - 2) << 2;
+
+#ifdef __BIG_ENDIAN_BITFIELD
+		cl_agc_profile_to_le32(&agc_params->profile1);
+		cl_agc_profile_to_le32(&agc_params->profile2);
+#endif
+	}
+
+	return 0;
+}
+
+void cl_agc_params_dump_profile_id(char *buf, ssize_t buf_size, ssize_t *len,
+				   u32 id, const char *str)
+{
+	u8 band, branch, version;
+
+	band = AGC_PROFILE_BAND(id);
+	branch = AGC_PROFILE_BRANCH(id);
+	version = AGC_PROFILE_VERSION(id);
+
+	if (*buf) {
+		*len += scnprintf(buf + *len, buf_size - *len,
+				  "%s %u.%u.%u\n", str, band, branch, version);
+	} else {
+		pr_debug("%s %u.%u.%u\n", str, band, branch, version);
+	}
+}
+
-- 
2.36.1

