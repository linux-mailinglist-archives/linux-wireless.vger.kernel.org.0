Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24663532993
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbiEXLlb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbiEXLl2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:41:28 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60065.outbound.protection.outlook.com [40.107.6.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC738CCC5
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7ahLqdzrCRhMHmOh0i9h8/a32QwBubFxbOJNnHwW5YvwdAw4XSHe/4nv3DCPKtpyLlI+l4NF1qjWv3TErJqNZkAF9R9jILLG9ZFZawzyOCu5nnmX3Y1tcDtqRQ+oTvWNzHQ/bm4BYT7x0AS8E+bvgKWKrvqMdl99E3PqBcWwmvGvdWK7KJXeJEf7+wMlV3WKp/tJHSZ8Nqh9Ue83u1S3vIxHw7uw+mhTeO3pgi6PQVZMWTTnJ5GBOhii2Do5P7BkXYB6IYVrA2BCmTkubuChRJuROPUCUxwAN6gIWwPSDhR9hJ7g6E/GSqTqh2TwxNrAQhTSkvOk5rH2J+yq4LWuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9NC1fx3Hc0lj16PXDrj6GUYe3Ky/0eBFlqVCFY52KM=;
 b=ThOurIE8gCxn6JsALGxxI35qQZBDcrvJJNkJbL1O83MkvxkycryRyYOhTIITOKfFS1dlySSkgInqRmNFZYdAOUF9OBYRCWwDzkSAcB5DjaqdJH0f9o+BTanWpumrhX8zjR5OW3yrPdS/2lPTIdmmSCtNVRiaHRTaFCPdnBO/wzlh1bu/8KQ+0GF7Am6IATxG/IppbCF8fXtFF/Enur3iDZlvdXd/KQ1Cwex5y/uoIDdFT0wP0BM2Lz6yUn6RgxcvHjiTYLGGEwLBDQyBHXs3fb7iQmdqatJLLMlRGYWeJKCHoVb/ru+xhs1u9RhCswfyDNTxkocm15mtaSOa55ncWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9NC1fx3Hc0lj16PXDrj6GUYe3Ky/0eBFlqVCFY52KM=;
 b=mMlx5klFj4OHyn4qxioN5eonECurI2K37SBarbyUwwwvqXUnAAWbe+LRbw9T5VlaEUGMvl7hAPJCpcUb9B70LNvH4OZRsoSqlHbZb4kmNvS4KOWsEGDZbTIbMWy6bnAkqtjkfBXe9k/YMDyzTG4EYlyODZG3uu/LgrkucYbP5DI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0915.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 24 May
 2022 11:39:26 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:26 +0000
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
Subject: [RFC v2 72/96] cl8k: add sounding.c
Date:   Tue, 24 May 2022 14:34:38 +0300
Message-Id: <20220524113502.1094459-73-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 21fe8d8c-2a17-4acf-f5e3-08da3d79f734
X-MS-TrafficTypeDiagnostic: AM8P192MB0915:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM8P192MB0915797B1FE23048144B74E6F6D79@AM8P192MB0915.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LKvPqdaz3+aJVYPHGr2KBj8RmHGucTpXZEPMFf7zBbbk8vZ/UafVJCzMUG7d5iipdEby8bHvi2Pf3k+9TFU7zaYBTg8u1aifICTdUsnEGjrEnvsBMaWUmunBwOxyyWYtrtiLgMFKORmsuw3HjkIeIv0qcJkH1PeC1GCYS19UEuw/w1LmhrSuTKoMFIu+zPwvR/m2zRvKGxbsLXuiwIOI0Bj1/mxmE9rgo5Lu9yuCu4lNFIGwOEcrEbGS/ifSvIVWOgc9dz3Xtl2JSl47n4+5pzSC9NkB0f5Uv0yCJOgK+cD2DrFe8al7LN+PCCzEiwklNy3DL95bHTOd8gl52cCZPrdLE6iWGZSbK6dAuzpwHTc6oHbkMSby7/3Nxxmq5p6l+WBzLt0g3bHMXOL/GILihsgo3YZOu53XOEXisIanuqQi1hTzN2pusVZdMy1Oh99hZlPNuu4MH/8seOVzBh+xspSmduLBX/pvPfDbdoNLo31rXkm77HZGUhy90kpcNc+b/VXKLEAJ+k/969f5lmWlXuRAxO5OIQwDBkg4bsCFVGlMcVEBS26sqxAxOIiQ84zTRvy/27jz6yd8MvP4/z03G+Dxd+NY7hCN89/U7kKbXWEQDLO6wv3M5qN/INlDlZWyvesfBjJzQkGLqLD5hUCHCU4ob+g9ZJeTeCvqi7/ajieDFrh+x9KAOJSt7eXo/BDbGkJGDfwzTtdS6ulMnnKg58D5Xtx3vsJPdYNZQiwLzy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(376002)(346002)(39850400004)(83380400001)(54906003)(186003)(36756003)(107886003)(2906002)(2616005)(30864003)(1076003)(6916009)(41300700001)(66946007)(8936002)(6666004)(9686003)(66476007)(26005)(86362001)(66556008)(5660300002)(6512007)(4326008)(38350700002)(316002)(6506007)(52116002)(8676002)(6486002)(38100700002)(508600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aVBNCkkuOz496PBXGN58uuVKdBHNeByoXEZrucflM6C4eQTPTHKV2ySjYNvw?=
 =?us-ascii?Q?IeWcNz4XU41gE4UMW3fV7faKKOIOGQh0WtgKIEEoYOoEaAp87g2mwhi6l7Bu?=
 =?us-ascii?Q?wr0kmr5PrRGyZ5LIFpREexAu/CLJGRbipr2nJMhWd54yDXFKNrb4Xolp4Sa5?=
 =?us-ascii?Q?qW1FYEXFszZbigWWCyBH76lGrWhVNhH/kzBb+EyJ4M5luYvn6pLu74TA27AI?=
 =?us-ascii?Q?rmIcqesIA4NSp9rvG5tiFhaduhJCcxY0fcZTVjAUFrYWLLiV7bzN4rg8XmQ+?=
 =?us-ascii?Q?ZPSTRfIeWGQZFi16AiY3vrQkDaQaasc/Kh2cML9izQ2ZF4x8wecNh0qTK7Hl?=
 =?us-ascii?Q?GNkGJ0XZ/4zWMvffSd8clsLIaisYm6aHI89LaSjVSJExGYgENRUDOPQe7vZ8?=
 =?us-ascii?Q?JCM1eoKfQRkQ4EoyVO5Mz6aBgn0dHDcNTyTIY7yzOrZxlRRW+SkyLyR5LbE8?=
 =?us-ascii?Q?Qp06qLZjhRreZNpZNres3Eb90UrjTwxQpT2gEdOdpj0JtL/Du43Ncx1g1YUY?=
 =?us-ascii?Q?8s2tklhDa6942Tixqxx8L5OOpqdPc3MdYKYvKQvl1rlovo5WyjkkayCqQ6Rt?=
 =?us-ascii?Q?5Tdj4hgFBr/lvPR/fw5xIVKY4MZJn1XppUogwnLIOIEMHl8HtDq06GiGOFRM?=
 =?us-ascii?Q?QfwioQMxaHifVCN5VyBXZfcho2Uz0+BJtaKTZPhjeVzW/yigKhGTV+m8mDsO?=
 =?us-ascii?Q?DO5pdKF9qR0gcdc+1m8pjOzvRKJrVzktSACh9ndpWzgFerX8SR+7vVwacXqL?=
 =?us-ascii?Q?yIn6QP3cmmBZAVjHzsYbhHFr1QJMGDOsanUXnAYLa73OCp6MJ91lZErT9kvC?=
 =?us-ascii?Q?9lH/aDxlp9193oW4X2CEMn5ic7QK22ZYosKnyxgtZo5VGp1ayrGBCmXznlAS?=
 =?us-ascii?Q?oPb5MWCtFM0z/+pGCXF6QJ7l2TlTHkITZFZoN8coV+AlmEd+vPJFwe5yTVCP?=
 =?us-ascii?Q?+uNzF79aH1O5tAal6hTVz5ecCduHmb1r30inPV1fNiD4rcr1pxw+CiW/qVlB?=
 =?us-ascii?Q?vhEmfO4O5dWlxweKFGNzBGFzK9q6C2WNg3D+LzTXzXQgre/xjvxmg1uRjttY?=
 =?us-ascii?Q?XogEyAHkjNML50CaBNuJEMtTbx/qXPSsbJdVnWFPPILKWrbEUo75OrggC5+b?=
 =?us-ascii?Q?GFOilpXbtXFWNffZFg0XmN/x6VihpL5OW/5l5Cb8XTvj9v9ZJdJd7Ip7SNKz?=
 =?us-ascii?Q?Dm/r6xwdnrI+9N5FK545hOXHvKc/iVogZd6yYmEYCq2+HxuAY0cTgdd1lhct?=
 =?us-ascii?Q?RDfEh9xz/EVbi2uu/lczgtTLaINTYCxEZiNo3q/yYELIi27G5dl1spEG69mD?=
 =?us-ascii?Q?pntP2f1kG4EIJjLfx94YVTnhn8xjE7yCE39t15oK1CILew4QsyLqcb4Ngvre?=
 =?us-ascii?Q?HlIlc4yNZ7TQXQ15lvG6OL7BpT2TTvV02HpfMlG9SHzJuyvPX4BxJPEjw7Z7?=
 =?us-ascii?Q?ptnkDh53LksHPt8cZPlWmTKKS9VamYiYlCLdXaldBc3adbRwGji/SdvOls9k?=
 =?us-ascii?Q?ImJbHp2Wrfg5/whOF7znoR9SEG1s2yDgjjG2RziUQRqgBnnefnHpxP9WKYbq?=
 =?us-ascii?Q?BWAOnLSRdN5NkJcF9/syHP10U+gjSXUhz6GHDH7z5ZxFOPvEAFz/40+YV1Fv?=
 =?us-ascii?Q?p8ZHoTXNBgeY1R5Rb8fY6k7e+z9xzht4W8rwpg6fLB2JFjm+0R8gBSc2ga5/?=
 =?us-ascii?Q?NDNbXTtVCPKm7WhL/euP+Gccpenjm9/M3SmyfJ2hRTq2IfHR6Uwuq2iTggUd?=
 =?us-ascii?Q?EGFEdoMBnDsBXi6/1/3MwBgowS6r20I=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fe8d8c-2a17-4acf-f5e3-08da3d79f734
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:47.6157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0rHukkdPJbZT5llP9wKIcJqId4CuHqWkkJ7tLXBqJra5rtddiZ5nK8titsBUzEFfjzVk77XYWs8GevvATzFOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0915
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
 drivers/net/wireless/celeno/cl8k/sounding.c | 1121 +++++++++++++++++++
 1 file changed, 1121 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/sounding.c

diff --git a/drivers/net/wireless/celeno/cl8k/sounding.c b/drivers/net/wireless/celeno/cl8k/sounding.c
new file mode 100644
index 000000000000..09d43a01bb70
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/sounding.c
@@ -0,0 +1,1121 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include "debug.h"
+#include "bf.h"
+#include "chip.h"
+#include "utils.h"
+#include "recovery.h"
+#include "debug.h"
+#include "hw.h"
+#include "sounding.h"
+
+#define DBG_PREFIX_MAX_LENGTH 64
+#define sounding_pr(level, format, ...) \
+	do { \
+		if ((level) <= cl_hw->sounding.dbg_level) { \
+			char __dbg_prefix[DBG_PREFIX_MAX_LENGTH] = {0}; \
+			if ((level) >= DBG_LVL_TRACE) \
+				snprintf(__dbg_prefix, DBG_PREFIX_MAX_LENGTH, "[%s][%d]", \
+					 __func__, __LINE__); \
+			pr_debug("%s [Sounding] " format, __dbg_prefix, ##__VA_ARGS__); \
+		} \
+	} while (0)
+
+#define sounding_pr_verbose(...) sounding_pr(DBG_LVL_VERBOSE, ##__VA_ARGS__)
+#define sounding_pr_err(...)     sounding_pr(DBG_LVL_ERROR, ##__VA_ARGS__)
+#define sounding_pr_warn(...)    sounding_pr(DBG_LVL_WARNING, ##__VA_ARGS__)
+#define sounding_pr_trace(...)   sounding_pr(DBG_LVL_TRACE, ##__VA_ARGS__)
+#define sounding_pr_info(...)    sounding_pr(DBG_LVL_INFO, ##__VA_ARGS__)
+
+#define CL_SOUNDING_ALL_STA          0xff
+#define CL_SOUNDING_LIFETIME_MAX     4095
+#define CL_SOUNDING_LIFETIME_FACTOR  5
+#define CL_SOUNDING_V_MATRIX_PADDING 32
+#define CL_V_MATRIX_MAC_OVERHEAD     41
+#define CL_Q_MATRIX_BITMAP_MASK      0xf
+
+enum cl_sounding_feedback_type {
+	CL_SOUNDING_FEEDBACK_TYPE_SU = 0,
+	CL_SOUNDING_FEEDBACK_TYPE_MU,
+};
+
+enum cl_sounding_ng {
+	CL_SOUNDING_NG_4 = 0,
+	CL_SOUNDING_NG_16,
+	CL_SOUNDING_NG_MAX
+};
+
+struct sounding_work_data {
+	struct work_struct  work;
+	struct cl_hw *cl_hw;
+	bool start;
+	bool is_recovery;
+	struct cl_sounding_info *elem; /* For stop and recovery cases */
+	enum sounding_type sounding_type;
+	u8 gid;
+	u8 sta_num;
+	u8 bw;
+	u8 q_matrix_bitmap;
+	u8 sta_indices[CL_MU_MAX_STA_PER_GROUP];
+};
+
+static u16 ng_bw_to_nsc[CL_SOUNDING_NG_MAX][CHNL_BW_MAX_HE] = {
+	{64, 128, 256, 512},
+	{32, 32, 64, 128}
+};
+
+static int cl_sounding_check_response(struct cl_hw *cl_hw, u8 param_err)
+{
+	int ret = -1;
+
+	switch (param_err) {
+	case CL_SOUNDING_RSP_OK:
+		sounding_pr_trace("param OK!\n");
+		ret = 0;
+		break;
+	case CL_SOUNDING_RSP_ERR_RLIMIT:
+		sounding_pr_err("error, resource limit reached\n");
+		break;
+	case CL_SOUNDING_RSP_ERR_BW:
+		sounding_pr_err("error, unsupported BW tx requested\n");
+		break;
+	case CL_SOUNDING_RSP_ERR_NSS:
+		sounding_pr_err("error, unsupported ndp NSS tx requested\n");
+		break;
+	case CL_SOUNDING_RSP_ERR_INTERVAL:
+		sounding_pr_err("error, interval value is invalid\n");
+		break;
+	case CL_SOUNDING_RSP_ERR_ALREADY:
+		sounding_pr_err("error, station already associated/disassociated with sounding\n");
+		break;
+	case CL_SOUNDING_RSP_ERR_STA:
+		sounding_pr_err("error, station is inactive/active\n");
+		break;
+	case CL_SOUNDING_RSP_ERR_TYPE:
+		sounding_pr_err("error, invalid sounding type\n");
+		break;
+	default:
+		sounding_pr_err("error status unknown, BUG\n");
+		break;
+	}
+
+	return ret;
+}
+
+static u32 cl_sounding_get_lifetime(struct cl_hw *cl_hw, u32 interval)
+{
+	u32 lifetime = (interval * CL_SOUNDING_LIFETIME_FACTOR) >> 1;
+
+	if (lifetime > CL_SOUNDING_LIFETIME_MAX) {
+		sounding_pr_err("lifetime (%u) exceeds 4095\n", lifetime);
+		lifetime = CL_SOUNDING_LIFETIME_MAX;
+	}
+
+	return lifetime;
+}
+
+static bool cl_sounding_is_sta_ng_16_capable(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+					     bool mu_cap)
+{
+	struct ieee80211_sta_he_cap *he_cap = &cl_sta->sta->he_cap;
+
+	if (he_cap->has_he) {
+		if (mu_cap)
+			return (he_cap->he_cap_elem.phy_cap_info[5] &
+				IEEE80211_HE_PHY_CAP5_NG16_MU_FEEDBACK);
+		else
+			return (he_cap->he_cap_elem.phy_cap_info[5] &
+				IEEE80211_HE_PHY_CAP5_NG16_SU_FEEDBACK);
+	}
+
+	return false;
+}
+
+static bool cl_sounding_is_sta_codebook_size_75_capable(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	struct ieee80211_sta_he_cap *he_cap = &cl_sta->sta->he_cap;
+
+	if (he_cap->has_he)
+		return (he_cap->he_cap_elem.phy_cap_info[6] &
+			IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_75_MU);
+
+	return false;
+}
+
+static void cl_sounding_extract_ng_cb_size(struct cl_hw *cl_hw, u8 fb_type_ng_cb_size,
+					   enum cl_sounding_ng *ng, u8 *phi_psi_sum)
+{
+	enum cl_sounding_feedback_type fb_type =
+		SOUNDING_FEEDBACK_TYPE_VAL(fb_type_ng_cb_size);
+	u8 cb_size = SOUNDING_CODEBOOK_SIZE_VAL(fb_type_ng_cb_size);
+
+	*ng = SOUNDING_NG_VAL(fb_type_ng_cb_size);
+
+	switch (fb_type) {
+	case CL_SOUNDING_FEEDBACK_TYPE_SU:
+		*phi_psi_sum = (cb_size ? 10 : 6);
+		break;
+	case CL_SOUNDING_FEEDBACK_TYPE_MU:
+		*phi_psi_sum = (cb_size ? 16 : 12);
+		break;
+	default:
+		sounding_pr_err("Invalid feedback_type %d\n", fb_type);
+		break;
+	}
+}
+
+static u32 cl_sounding_get_v_matrix_size(struct cl_hw *cl_hw, u8 sta_idx, u8 bw, u8 nc, u8 nr,
+					 u8 fb_type_ng_cb_size)
+{
+	enum cl_sounding_ng ng = 0;
+	u8 phi_psi_sum = 0;
+	u8 nsc;
+	u32 v_size;
+
+	cl_sounding_extract_ng_cb_size(cl_hw, fb_type_ng_cb_size, &ng, &phi_psi_sum);
+	nsc = ng_bw_to_nsc[ng][bw];
+
+	/* NC and NR should start from 1 and not 0 for the below calculation */
+	nc++;
+	nr++;
+
+	/* v_size = [8*41 + 8*nc + (phi + psi)/2 * nsc*(nc * (2*nr-nc-1))] / 8 + extra padding */
+	v_size = CL_V_MATRIX_MAC_OVERHEAD + nc +
+		     ((phi_psi_sum * nsc * nc * (2 * nr - nc - 1)) >> 4) +
+		     CL_SOUNDING_V_MATRIX_PADDING;
+
+	sounding_pr_info("sta %u, nc %u, nr %u, ng %d, phi_psi_sum %u, nsc %u, v_size %u\n",
+			 sta_idx, nc, nr, ng, phi_psi_sum, nsc, v_size);
+
+	return v_size;
+}
+
+static u32 cl_sounding_get_v_matrices_data_size(struct cl_hw *cl_hw,
+						struct sounding_info_per_sta *info_per_sta,
+						u8 sta_num, u8 bw, u8 nr)
+{
+	u8 i;
+	u32 v_size = 0;
+
+	for (i = 0; i < sta_num; i++)
+		v_size += cl_sounding_get_v_matrix_size(cl_hw, info_per_sta[i].sta_idx,
+							bw, info_per_sta[i].nc,
+							nr, info_per_sta[i].fb_type_ng_cb_size);
+
+	sounding_pr_info("v_matrices data size %u, sta_num %u\n", v_size, sta_num);
+
+	return v_size;
+}
+
+static u32 cl_sounding_get_q_matrix_size(struct cl_hw *cl_hw,
+					 const struct sounding_info_per_sta *info_per_sta,
+					 u8 sta_num, u8 bw, u8 nr)
+{
+	u8 i;
+	u8 nc = 0;
+	enum cl_sounding_ng ng = 0;
+	u8 nsc, phi_psi_sum = 0;
+	u32 q_size = 0;
+
+	/*
+	 * NC and NR should start from 1 and not 0 for the below calculation
+	 * In MU-MIMO case, when sta_num > 1, we should take the sum of all nc's
+	 */
+	for (i = 0; i < sta_num; i++)
+		nc += info_per_sta[i].nc + 1;
+
+	nr++;
+
+	cl_sounding_extract_ng_cb_size(cl_hw, info_per_sta[0].fb_type_ng_cb_size, &ng,
+				       &phi_psi_sum);
+	nsc = ng_bw_to_nsc[ng][bw];
+	q_size = (nr * nc * nsc) << 2;
+
+	sounding_pr_info("q_matrix size %u, sta_num %u\n", q_size, sta_num);
+
+	return q_size;
+}
+
+static u32 cl_sounding_get_required_xmem_size(struct cl_hw *cl_hw,
+					      const struct mm_sounding_req *sounding_req,
+					      const struct sounding_info_per_sta *info_per_sta)
+{
+	u8 i;
+	u8 sta_num = sounding_req->sta_num;
+	u8 q_matrix_bitmap = sounding_req->q_matrix_bitmap;
+	u8 bw = sounding_req->req_txbw;
+	u8 nr = sounding_req->ndp_nsts;
+	u32 total_size = 0;
+
+	/*
+	 * In case of MU sounding only one Q matrix is generated.
+	 * Otherwise, the number of Q matrices equals to te number of stations
+	 */
+	if (sta_num > 1 &&
+	    sounding_req->sounding_type != SOUNDING_TYPE_HE_MU &&
+	    sounding_req->sounding_type != SOUNDING_TYPE_VHT_MU)
+		for (i = 0; i < sta_num; i++)
+			total_size +=
+			cl_sounding_get_q_matrix_size(cl_hw, &info_per_sta[i], 1, bw, nr);
+	else
+		total_size =
+			cl_sounding_get_q_matrix_size(cl_hw, info_per_sta, sta_num, bw, nr);
+
+	/*
+	 * If additional SU Q matrices should be generated - consider them also when calculating
+	 * the required XMEM space
+	 */
+	if (q_matrix_bitmap) {
+		for (i = 0; i < CL_MU_MIMO_MAX_STA_PER_GRP; i++)
+			if (q_matrix_bitmap & BIT(i))
+				total_size +=
+				cl_sounding_get_q_matrix_size(cl_hw, &info_per_sta[i], 1, bw, nr);
+	}
+
+	return total_size;
+}
+
+static bool cl_sounding_is_enough_xmem_space(struct cl_hw *cl_hw,
+					     const struct mm_sounding_req *sounding_req,
+					     const struct sounding_info_per_sta *info_per_sta,
+					     u32 *required_size)
+{
+	struct cl_xmem *xmem_db = &cl_hw->chip->xmem_db;
+	u32 req_mem = cl_sounding_get_required_xmem_size(cl_hw, sounding_req, info_per_sta);
+
+	if (required_size)
+		*required_size = req_mem;
+
+	return ((xmem_db->size - xmem_db->total_used) >= req_mem);
+}
+
+static void cl_sounding_fill_info_per_sta(struct cl_hw *cl_hw, u8 sounding_type, u8 bw, u8 sta_num,
+					  struct cl_sta **cl_sta_arr,
+					  struct sounding_info_per_sta *info_per_sta,
+					  u8 *n_sts)
+{
+	u8 i;
+	u8 min_sts = cl_hw->num_antennas;
+	struct cl_sta *cl_sta = NULL;
+	u8 mu_fb_type_ng_cb_size = FEEDBACK_TYPE_MU_NG_4_CODEBOOK_SIZE_9_7;
+	u8 curr_fb_type_ng_cb_size;
+	bool should_update_fb_type_ng_cb_size = false;
+
+	for (i = 0; i < sta_num; i++) {
+		cl_sta = cl_sta_arr[i];
+
+		if (!cl_sta)
+			continue;
+
+		info_per_sta[i].sta_idx = cl_sta->sta_idx;
+		info_per_sta[i].nc = cl_sta->bf_db.nc;
+
+		min_sts = min(min_sts, cl_sta->bf_db.beamformee_sts);
+
+		switch (sounding_type) {
+		case SOUNDING_TYPE_HE_CQI:
+		case SOUNDING_TYPE_HE_SU:
+		case SOUNDING_TYPE_VHT_SU:
+		case SOUNDING_TYPE_VHT_MU:
+			info_per_sta[i].fb_type_ng_cb_size =
+				FEEDBACK_TYPE_SU_NG_4_CODEBOOK_SIZE_4_2;
+			break;
+		case SOUNDING_TYPE_HE_SU_TB:
+			info_per_sta[i].fb_type_ng_cb_size =
+				FEEDBACK_TYPE_SU_NG_4_CODEBOOK_SIZE_6_4;
+			break;
+		case SOUNDING_TYPE_HE_CQI_TB:
+			info_per_sta[i].fb_type_ng_cb_size =
+				FEEDBACK_TYPE_CQI_TB;
+			break;
+		case SOUNDING_TYPE_HE_MU:
+			if (bw == CHNL_BW_160 &&
+			    info_per_sta[i].nc >= WRS_SS_3 &&
+			    min_sts == MAX_ANTENNAS) {
+				should_update_fb_type_ng_cb_size = true;
+
+				if (cl_sounding_is_sta_codebook_size_75_capable(cl_hw, cl_sta)) {
+					curr_fb_type_ng_cb_size =
+						FEEDBACK_TYPE_MU_NG_4_CODEBOOK_SIZE_7_5;
+				} else if (cl_sounding_is_sta_ng_16_capable(cl_hw, cl_sta, true)) {
+					curr_fb_type_ng_cb_size =
+						FEEDBACK_TYPE_MU_NG_16_CODEBOOK_SIZE_9_7;
+				} else {
+					curr_fb_type_ng_cb_size =
+						FEEDBACK_TYPE_MU_NG_4_CODEBOOK_SIZE_9_7;
+					mu_fb_type_ng_cb_size =
+						FEEDBACK_TYPE_MU_NG_4_CODEBOOK_SIZE_9_7;
+					min_sts--;
+				}
+
+				if ((SOUNDING_NG_VAL(curr_fb_type_ng_cb_size) >
+							SOUNDING_NG_VAL(mu_fb_type_ng_cb_size)) ||
+				    (SOUNDING_CODEBOOK_SIZE_VAL(curr_fb_type_ng_cb_size) <
+				     SOUNDING_CODEBOOK_SIZE_VAL(mu_fb_type_ng_cb_size)))
+					mu_fb_type_ng_cb_size = curr_fb_type_ng_cb_size;
+			}
+
+			info_per_sta[i].fb_type_ng_cb_size = mu_fb_type_ng_cb_size;
+			break;
+		default:
+			sounding_pr_trace("Invalid sounding type %u\n", sounding_type);
+			break;
+		}
+	}
+
+	*n_sts = min_sts;
+
+	if (should_update_fb_type_ng_cb_size)
+		for (i = 0; i < sta_num; i++)
+			info_per_sta[i].fb_type_ng_cb_size = mu_fb_type_ng_cb_size;
+}
+
+static struct cl_sounding_info *cl_sounding_elem_alloc(struct cl_hw *cl_hw, u32 v_mat_len)
+{
+	struct cl_sounding_info *elem = NULL;
+	dma_addr_t phys_dma_addr;
+	struct v_matrix_header *buf = NULL;
+
+	elem = kzalloc(sizeof(*elem), GFP_KERNEL);
+
+	if (!elem) {
+		CL_DBG(cl_hw, DBG_LVL_ERROR, "kzalloc failed\n");
+		return NULL;
+	}
+
+	buf = dma_alloc_coherent(cl_hw->chip->dev, v_mat_len, &phys_dma_addr, GFP_KERNEL);
+
+	if (!buf) {
+		CL_DBG(cl_hw, DBG_LVL_ERROR, "dma_alloc_coherent failed. size=%u\n", v_mat_len);
+		kfree(elem);
+		return NULL;
+	}
+
+	elem->v_matrices_data = buf;
+	elem->v_matrices_dma_addr = phys_dma_addr;
+	elem->v_matrices_data_len = v_mat_len;
+
+	return elem;
+}
+
+static void cl_sounding_elem_free(struct cl_hw *cl_hw, struct cl_sounding_info *elem)
+{
+	struct v_matrix_header *v_data = elem->v_matrices_data;
+
+	if (v_data) {
+		dma_free_coherent(cl_hw->chip->dev, elem->v_matrices_data_len, (void *)v_data,
+				  elem->v_matrices_dma_addr);
+	} else {
+		sounding_pr_err("%s: v_matrices_data is NULL for sid %u\n",
+				__func__, elem->sounding_id);
+	}
+
+	elem->v_matrices_data = NULL;
+	kfree(elem);
+}
+
+static void cl_sounding_req_success(struct cl_hw *cl_hw, struct cl_sounding_info *elem)
+{
+	cl_bf_sounding_req_success(cl_hw, elem);
+}
+
+static void cl_sounding_req_failure(struct cl_hw *cl_hw, struct cl_sounding_info *elem)
+{
+	cl_bf_sounding_req_failure(cl_hw, elem);
+}
+
+static void cl_sounding_increase_num_profiles(struct cl_hw *cl_hw, u8 sounding_type, u8 sta_num)
+{
+	if (SOUNDING_TYPE_IS_CQI(sounding_type))
+		cl_hw->sounding.cqi_profiles += sta_num;
+	else
+		cl_hw->sounding.active_profiles += sta_num;
+}
+
+static void cl_sounding_decrease_num_profiles(struct cl_hw *cl_hw, u8 sounding_type, u8 sta_num)
+{
+	if (SOUNDING_TYPE_IS_CQI(sounding_type))
+		cl_hw->sounding.cqi_profiles -= sta_num;
+	else
+		cl_hw->sounding.active_profiles -= sta_num;
+}
+
+static void _cl_sounding_add(struct cl_hw *cl_hw, struct cl_sounding_info *elem, u8 sounding_id,
+			     u32 req_xmem)
+{
+	write_lock_bh(&cl_hw->sounding.list_lock);
+	elem->sounding_id = sounding_id;
+	elem->xmem_space = req_xmem;
+	cl_hw->chip->xmem_db.total_used += req_xmem;
+	cl_hw->sounding.num_soundings++;
+	list_add_tail(&elem->list, &cl_hw->sounding.head);
+	cl_sounding_increase_num_profiles(cl_hw, elem->type, elem->sta_num);
+	write_unlock_bh(&cl_hw->sounding.list_lock);
+}
+
+static void cl_sounding_remove_from_list(struct cl_hw *cl_hw, struct cl_sounding_info *elem)
+{
+	/* Remove the sounding sequence from the list and update the XMEM and profile counters */
+	write_lock_bh(&cl_hw->sounding.list_lock);
+	list_del(&elem->list);
+	cl_hw->chip->xmem_db.total_used -= elem->xmem_space;
+	cl_hw->sounding.num_soundings--;
+	cl_sounding_decrease_num_profiles(cl_hw, elem->type, elem->sta_num);
+	write_unlock_bh(&cl_hw->sounding.list_lock);
+}
+
+static void cl_sounding_remove_recovery(struct cl_hw *cl_hw, struct cl_sounding_info *elem)
+{
+	u8 i;
+
+	cl_sounding_remove_from_list(cl_hw, elem);
+
+	{
+		/* Set invalid sid for all STAs related to this sounding sequence */
+		for (i = 0; i < elem->sta_num; i++) {
+			struct cl_sta *cl_sta = elem->su_cl_sta_arr[i];
+
+			if (cl_sta)
+				cl_sta->su_sid = INVALID_SID;
+		}
+	}
+
+	/* Free the deleted sounding element */
+	cl_sounding_elem_free(cl_hw, elem);
+}
+
+static void cl_sounding_start_handler(struct cl_hw *cl_hw, struct sounding_work_data *data)
+{
+	struct mm_sounding_req sounding_req;
+	struct mm_sounding_cfm *cfm = NULL;
+	int ret = 0;
+	u32 len = 0;
+	u32 req_xmem = 0;
+	struct cl_sounding_info *elem = NULL;
+	u8 sounding_type = data->sounding_type;
+	u8 bw = data->bw;
+	u8 i, sta_num = 0;
+	u8 q_matrix_bitmap = data->q_matrix_bitmap;
+	u8 min_nsts = 0;
+	struct cl_sta *cl_sta_arr[CL_MU_MAX_STA_PER_GROUP] = {NULL};
+
+	cl_sta_lock_bh(cl_hw);
+
+	for (i = 0; i < data->sta_num; i++) {
+		u8 sta_idx = data->sta_indices[i];
+		struct cl_sta *cl_sta;
+
+		cl_sta = cl_sta_get(cl_hw, sta_idx);
+
+		if (!cl_sta)
+			continue;
+
+		cl_sta_arr[sta_num] = cl_sta;
+		sta_num++;
+	}
+
+	if (!sta_num) {
+		cl_sta_unlock_bh(cl_hw);
+		sounding_pr_err("%s: No STA found!\n", __func__);
+		return;
+	}
+
+	q_matrix_bitmap &= CL_Q_MATRIX_BITMAP_MASK;
+
+	/* Configure sounding request parameters */
+	sounding_req.start = true;
+	sounding_req.sounding_type = sounding_type;
+	sounding_req.req_txbw = bw;
+	sounding_req.sta_num = sta_num;
+	sounding_req.interval = cl_sounding_get_interval(cl_hw);
+	sounding_req.lifetime = cl_sounding_get_lifetime(cl_hw, sounding_req.interval);
+	sounding_req.q_matrix_bitmap = q_matrix_bitmap;
+	cl_sounding_fill_info_per_sta(cl_hw, sounding_type, bw, sta_num, cl_sta_arr,
+				      sounding_req.info_per_sta, &min_nsts);
+	cl_sta_unlock_bh(cl_hw);
+
+	sounding_req.ndp_nsts = min_nsts;
+
+	if (data->is_recovery) {
+		elem = data->elem;
+	} else {
+		/*
+		 * Check if there is enough XMEM space.
+		 * Should be called after filling sounding req struct
+		 */
+		if (!cl_sounding_is_enough_xmem_space(cl_hw, &sounding_req,
+						      sounding_req.info_per_sta, &req_xmem)) {
+			sounding_pr_err("There is not enough space in XMEM!\n");
+			return;
+		}
+
+		/* Should be called after filling info per STA */
+		len = cl_sounding_get_v_matrices_data_size(cl_hw, sounding_req.info_per_sta,
+							   sta_num, bw, min_nsts);
+		elem = cl_sounding_elem_alloc(cl_hw, len);
+
+		if (!elem)
+			return;
+
+		elem->type = sounding_type;
+		elem->bw = bw;
+		elem->sta_num = sta_num;
+		elem->q_matrix_bitmap = q_matrix_bitmap;
+
+		if (data->gid)
+			elem->gid = data->gid;
+		else
+			memcpy(elem->su_cl_sta_arr, cl_sta_arr,
+			       sta_num * sizeof(cl_sta_arr[0]));
+	}
+
+	sounding_req.host_address = cpu_to_le32(elem->v_matrices_dma_addr);
+
+	/* Print request parameters */
+	sounding_pr_trace("Request: start=%u, bfr_lifetime=%u, interval=%u, "
+			   "req_txbw=%u, ndp_nsts=%u, sounding_type=%u\n",
+			   sounding_req.start,
+			   sounding_req.lifetime,
+			   sounding_req.interval,
+			   sounding_req.req_txbw,
+			   sounding_req.ndp_nsts,
+			   sounding_req.sounding_type);
+
+	/* Send message to firmware */
+	ret = cl_msg_tx_sounding(cl_hw, &sounding_req);
+
+	/* Check firmware response */
+	cfm = cl_hw->msg_cfm_params[MM_SOUNDING_CFM];
+	if (ret == 0 && cfm) {
+		ret = cl_sounding_check_response(cl_hw, cfm->param_err);
+
+		if (ret == 0) {
+			if (!data->is_recovery)
+				_cl_sounding_add(cl_hw, elem, cfm->sounding_id, req_xmem);
+
+			cl_sounding_req_success(cl_hw, elem);
+
+			sounding_pr_trace("Sounding %u was enabled successfully\n",
+					  cfm->sounding_id);
+		} else {
+			cl_sounding_req_failure(cl_hw, elem);
+
+			if (data->is_recovery)
+				cl_sounding_remove_recovery(cl_hw, elem);
+		}
+	} else {
+		sounding_pr_err("%s: failed to send message (%d)\n", __func__, ret);
+		cl_sounding_req_failure(cl_hw, elem);
+
+		if (data->is_recovery)
+			cl_sounding_remove_recovery(cl_hw, elem);
+		else
+			cl_sounding_elem_free(cl_hw, elem);
+	}
+
+	/* Free message confirmation */
+	cl_msg_tx_free_cfm_params(cl_hw, MM_SOUNDING_CFM);
+}
+
+static void _cl_sounding_remove(struct cl_hw *cl_hw, struct cl_sounding_info *elem)
+{
+	u8 i;
+	struct sounding_work_data data = {
+		.cl_hw = cl_hw,
+		.bw = elem->bw,
+		.start = true,
+		.is_recovery = false,
+		.sta_num = 0
+	};
+
+	cl_sounding_remove_from_list(cl_hw, elem);
+
+	/* Update invalid sid for all STAs related to this sounding sequence.
+	 * Also start sounding for STAs that didn't request to stop sounding.
+	 */
+
+	for (i = 0; i < elem->sta_num; i++) {
+		struct cl_sta *cl_sta = elem->su_cl_sta_arr[i];
+
+		if (!cl_sta)
+			continue;
+
+		cl_sta->su_sid = INVALID_SID;
+
+		/* After stopping the multi STA sounding - check if a new sounding is needed */
+		if (elem->sounding_restart_required) {
+			if (!cl_sta->bf_db.sounding_remove_required) {
+				data.sta_indices[data.sta_num] = cl_sta->sta_idx;
+				data.sta_num++;
+			} else {
+				cl_sta->bf_db.sounding_remove_required = false;
+			}
+		}
+	}
+
+	/* Start a new sounding for the remaining stations only when needed */
+	if (data.sta_num) {
+		/* Determine new sounding type */
+		if (SOUNDING_TYPE_IS_CQI(elem->type)) {
+			if (data.sta_num > 1)
+				data.sounding_type = elem->type;
+			else
+				data.sounding_type = SOUNDING_TYPE_HE_CQI;
+		} else if (SOUNDING_TYPE_IS_VHT(elem->type)) {
+			data.sounding_type = SOUNDING_TYPE_VHT_SU;
+		} else {
+			if (data.sta_num > 1)
+				data.sounding_type = SOUNDING_TYPE_HE_SU_TB;
+			else
+				data.sounding_type = SOUNDING_TYPE_HE_SU;
+		}
+
+		cl_sounding_start_handler(cl_hw, &data);
+	}
+
+	/* Free the deleted sounding element */
+	cl_sounding_elem_free(cl_hw, elem);
+}
+
+static void cl_sounding_stop_handler(struct cl_hw *cl_hw, struct cl_sounding_info *elem)
+{
+	struct mm_sounding_req sounding_req;
+	int ret = 0;
+
+	if (!elem) {
+		sounding_pr_err("elem is NULL!!\n");
+		return;
+	}
+
+	/* Configure sounding request parameters */
+	sounding_req.start = false;
+	sounding_req.sounding_type = elem->type;
+	sounding_req.sid = elem->sounding_id;
+
+	/* Print request parameters */
+	sounding_pr_trace("Delete request: sid=%u, sounding_type=%u\n",
+			  elem->sounding_id, elem->type);
+
+	/* Send message to firmware */
+	ret = cl_msg_tx_sounding(cl_hw, &sounding_req);
+
+	/* Check firmware response */
+	if (ret)
+		sounding_pr_err("%s: failed to send message (%d)\n", __func__, ret);
+	else
+		/* Free message confirmation */
+		cl_msg_tx_free_cfm_params(cl_hw, MM_SOUNDING_CFM);
+
+	/* Remove the sounding sequence from the list and update the used XMEM counter.
+	 * Notice that elem is freed and shouldn't be accessed after the call to this function.
+	 */
+	_cl_sounding_remove(cl_hw, elem);
+}
+
+static void cl_sounding_handler_send_request(struct work_struct *work)
+{
+	struct sounding_work_data *data = (struct sounding_work_data *)work;
+	struct cl_hw *cl_hw = data->cl_hw;
+
+	if (data->start) {
+		cl_sounding_start_handler(cl_hw, data);
+	} else {
+		u8 sid;
+
+		{
+			u8 sta_idx = data->sta_indices[0];
+			struct cl_sta *cl_sta;
+
+			cl_sta_lock_bh(cl_hw);
+			cl_sta = cl_sta_get(cl_hw, sta_idx);
+			sid = cl_sta ? cl_sta->su_sid : U8_MAX;
+			cl_sta_unlock_bh(cl_hw);
+		}
+
+		if (data->elem)
+			cl_sounding_stop_handler(cl_hw, data->elem);
+		else
+			cl_sounding_stop_by_sid(cl_hw, sid, false);
+	}
+
+	kfree(data);
+}
+
+static u16 cl_sounding_calc_interval(struct cl_hw *cl_hw, u8 active_profiles)
+{
+	/* Sounding interval = min interval + [(active_profiles - 1) / STA step] * interval step */
+
+	u16 *coefs = cl_hw->conf->ce_sounding_interval_coefs;
+	u16 min_interval = coefs[SOUNDING_INTERVAL_COEF_MIN_INTERVAL];
+	u16 max_interval = coefs[SOUNDING_INTERVAL_COEF_MAX_INTERVAL];
+	u8 sta_step = coefs[SOUNDING_INTERVAL_COEF_STA_STEP];
+	u8 interval_step = coefs[SOUNDING_INTERVAL_COEF_INTERVAL_STEP];
+	u16 ret = min_interval;
+
+	if (active_profiles <= sta_step)
+		return ret;
+
+	active_profiles--;
+	ret += (active_profiles / sta_step) * interval_step;
+
+	return min(ret, max_interval);
+}
+
+static void cl_sounding_handler_change_interval(struct work_struct *work)
+{
+	struct sounding_work_data *data = (struct sounding_work_data *)work;
+	struct cl_hw *cl_hw = data->cl_hw;
+	struct mm_sounding_interval_cfm *sounding_interval_cfm = NULL;
+	int ret = 0;
+	/* Configure sounding request parameters */
+	u16 interval = cl_sounding_get_interval(cl_hw);
+	u16 lifetime = cl_sounding_get_lifetime(cl_hw, interval);
+
+	sounding_pr_trace("Sounding interval request: sta_idx=%d, interval=%u, "
+			  "lifetime=%u, sounding_type=%u\n",
+			  CL_SOUNDING_ALL_STA, interval, lifetime, data->sounding_type);
+
+	/* Start/Stop synchronize sounding request periodically */
+	ret = cl_msg_tx_sounding_interval(cl_hw, interval, lifetime, data->sounding_type,
+					  CL_SOUNDING_ALL_STA);
+	sounding_interval_cfm = cl_hw->msg_cfm_params[MM_SOUNDING_INTERVAL_CFM];
+	if (ret == 0 && sounding_interval_cfm)
+		cl_sounding_check_response(cl_hw, sounding_interval_cfm->param_err);
+	else
+		sounding_pr_err("%s: failed to send message (%d)\n", __func__, ret);
+
+	cl_msg_tx_free_cfm_params(cl_hw, MM_SOUNDING_INTERVAL_CFM);
+	kfree(data);
+}
+
+static void cl_sounding_recovery_reset(struct cl_hw *cl_hw)
+{
+	struct cl_sounding_db *sounding_db = &cl_hw->sounding;
+
+	memset(sounding_db->active_profiles_prev, 0, sizeof(u8) * CL_SOUNDING_STABILITY_TIME);
+	sounding_db->active_profiles_idx = 0;
+	cl_sta_loop(cl_hw, cl_bf_reset_sounding_ind);
+}
+
+void cl_sounding_init(struct cl_hw *cl_hw)
+{
+	struct cl_sounding_db *sounding_db = &cl_hw->sounding;
+
+	memset(sounding_db, 0, sizeof(*sounding_db));
+	sounding_db->sounding_wq = create_workqueue("cl_sounding_wq");
+	sounding_db->current_interval =
+		cl_hw->conf->ce_sounding_interval_coefs[SOUNDING_INTERVAL_COEF_MIN_INTERVAL];
+	sounding_db->dbg_level = 1;
+	cl_hw->chip->xmem_db.size = XMEM_SIZE;
+	INIT_LIST_HEAD(&sounding_db->head);
+	rwlock_init(&sounding_db->list_lock);
+}
+
+void cl_sounding_close(struct cl_hw *cl_hw)
+{
+	struct cl_sounding_info *elem, *tmp;
+
+	if (cl_hw->sounding.sounding_wq)
+		destroy_workqueue(cl_hw->sounding.sounding_wq);
+
+	list_for_each_entry_safe(elem, tmp, &cl_hw->sounding.head, list) {
+		/* Don't try to start a new sounding sequence after stopping this one */
+		elem->sounding_restart_required = false;
+		cl_sounding_stop_handler(cl_hw, elem);
+	}
+}
+
+struct cl_sounding_info *cl_sounding_get_elem(struct cl_hw *cl_hw, u8 sounding_id)
+{
+	struct cl_sounding_info *elem = NULL;
+
+	read_lock_bh(&cl_hw->sounding.list_lock);
+
+	list_for_each_entry(elem, &cl_hw->sounding.head, list) {
+		if (elem->sounding_id == sounding_id) {
+			read_unlock_bh(&cl_hw->sounding.list_lock);
+			return elem;
+		}
+	}
+
+	read_unlock_bh(&cl_hw->sounding.list_lock);
+
+	return NULL;
+}
+
+void cl_sounding_send_request(struct cl_hw *cl_hw, struct cl_sta **cl_sta_arr,
+			      u8 sta_num, bool enable, u8 sounding_type, u8 bw,
+			      void *mu_grp,
+			      u8 q_matrix_bitmap, struct cl_sounding_info *recovery_elem)
+{
+	struct sounding_work_data *data;
+	struct cl_sounding_info *elem = NULL;
+	u8 i;
+	struct cl_sta *cl_sta = NULL;
+	bool background = (preempt_count() != 0);
+
+	if (cl_band_is_24g(cl_hw) && SOUNDING_TYPE_IS_VHT(sounding_type)) {
+		sounding_pr_err("A VHT sounding type (%u) is not supported in 2.4g band\n",
+				sounding_type);
+		return;
+	}
+
+	/*
+	 * When Multiple STAs are members of a single sounding process, that is about to be stopped,
+	 * we want to schedule the stopping work only once and possibly start another sounding
+	 * sequence for STAs that still want to use it.
+	 */
+	if (enable)
+		goto next;
+
+	cl_sta = cl_sta_arr[0];
+	if (cl_sta) {
+		u8 sid = cl_sta->su_sid;
+
+		if (sid != INVALID_SID) {
+			elem = cl_sounding_get_elem(cl_hw, sid);
+
+			if (!elem) {
+				sounding_pr_trace("Sounding %u not found\n", sid);
+				return;
+			}
+
+			cl_sta->bf_db.sounding_remove_required = true;
+
+			if (elem->sounding_restart_required)
+				return;
+			elem->sounding_restart_required = true;
+		}
+	}
+
+next:
+	/* data will be freed in work handler */
+	data = kzalloc(sizeof(*data), GFP_ATOMIC);
+
+	if (!data)
+		return;
+
+	data->cl_hw = cl_hw;
+	data->start = enable;
+	data->sounding_type = sounding_type;
+	data->bw = bw;
+	data->is_recovery = cl_recovery_in_progress(cl_hw);
+	data->elem = recovery_elem ? recovery_elem : elem;
+
+	/* Fill cl_sta_arr */
+	{
+		for (i = 0; i < sta_num; i++)
+			data->sta_indices[i] = cl_sta_arr[i]->sta_idx;
+
+		data->sta_num = sta_num;
+	}
+
+	if (background) {
+		INIT_WORK(&data->work, cl_sounding_handler_send_request);
+		queue_work(cl_hw->sounding.sounding_wq, &data->work);
+	} else {
+		cl_sounding_handler_send_request((struct work_struct *)data);
+	}
+}
+
+static void cl_sounding_change_interval(struct cl_hw *cl_hw, u8 sounding_type)
+{
+	/* Data will be freed in work handler */
+	struct sounding_work_data *data = kzalloc(sizeof(*data), GFP_ATOMIC);
+
+	if (!data)
+		return;
+
+	INIT_WORK(&data->work, cl_sounding_handler_change_interval);
+	data->cl_hw = cl_hw;
+	data->sounding_type = sounding_type;
+	queue_work(cl_hw->sounding.sounding_wq, &data->work);
+}
+
+void cl_sounding_stop_by_sid(struct cl_hw *cl_hw, u8 sid, bool sounding_restart_check)
+{
+	struct cl_sounding_info *elem = cl_sounding_get_elem(cl_hw, sid);
+
+	if (!elem) {
+		sounding_pr_trace("Sounding with id %u not found or is in the middle of removal\n",
+				  sid);
+		return;
+	}
+
+	elem->sounding_restart_required = sounding_restart_check;
+	cl_sounding_stop_handler(cl_hw, elem);
+}
+
+void cl_sounding_maintenance(struct cl_hw *cl_hw)
+{
+	/*
+	 * Change sounding_index accoording to number of active_profiles.
+	 * sounding_index is modified only if number of active_profiles is stable for 5 seconds.
+	 *
+	 * Examples:
+	 * e.g #1: active_profiles=2, active_profiles_prev=3,3,3,3,3 - stabilised on 3
+	 * e.g #3: active_profiles=2, active_profiles_prev=1,1,1,1,1 - stabilised on 1
+	 * e.g #2: active_profiles=5, active_profiles_prev=6,7,7,6,6 - stabilised on 6
+	 * e.g #4: active_profiles=5, active_profiles_prev=4,3,3,2,4 - stabilised on 4
+	 */
+
+	int i = 0;
+	u8 active_profiles_min = 255;
+	u8 active_profiles_max = 0;
+	u8 active_profiles = cl_hw->sounding.last_conf_active_profiles;
+	u8 active_profiles_new = 0;
+	u16 interval;
+	u16 interval_new;
+
+	/* Add to last 5 sec buffer */
+	cl_hw->sounding.active_profiles_prev[cl_hw->sounding.active_profiles_idx] =
+		cl_hw->sounding.active_profiles;
+
+	/* Increase cyclic index */
+	cl_hw->sounding.active_profiles_idx++;
+	if (cl_hw->sounding.active_profiles_idx == CL_SOUNDING_STABILITY_TIME)
+		cl_hw->sounding.active_profiles_idx = 0;
+
+	/* Find active_profiles min/max in last 5 seconds */
+	for (i = 0; i < CL_SOUNDING_STABILITY_TIME; i++) {
+		if (cl_hw->sounding.active_profiles_prev[i] < active_profiles_min)
+			active_profiles_min = cl_hw->sounding.active_profiles_prev[i];
+
+		if (cl_hw->sounding.active_profiles_prev[i] > active_profiles_max)
+			active_profiles_max = cl_hw->sounding.active_profiles_prev[i];
+	}
+
+	if (active_profiles < active_profiles_min)
+		active_profiles_new = active_profiles_min;
+	else if (active_profiles > active_profiles_max)
+		active_profiles_new = active_profiles_max;
+	else /* Active_profiles in last 5 seconds did not change or is not stable */
+		return;
+
+	interval = cl_sounding_calc_interval(cl_hw, active_profiles);
+	interval_new = cl_sounding_calc_interval(cl_hw, active_profiles_new);
+
+	/* Check if sounding interval changed */
+	if (interval != interval_new) {
+		cl_hw->sounding.last_conf_active_profiles = active_profiles_new;
+		cl_hw->sounding.current_interval = interval_new;
+		cl_sounding_change_interval(cl_hw, SOUNDING_TYPE_MAX);
+		sounding_pr_trace("Interval: current = %u, new = %u\n",
+				  interval, interval_new);
+	}
+}
+
+u16 cl_sounding_get_interval(struct cl_hw *cl_hw)
+{
+	return cl_hw->sounding.current_interval;
+}
+
+static void cl_sounding_indication_pr(struct cl_hw *cl_hw,
+				      struct mm_sounding_ind *ind,
+				      struct v_matrix_header *v_matrix,
+				      u8 *avg_snr)
+{
+	sounding_pr_info("Sounding indication: nc index = %u, BFR BW = %u, "
+		  "SNR1 = %u, SNR2 = %u, SNR3 = %u, SNR4 = %u, SNR5 = %u, SNR6 = %u,"
+		  "feedback type = %u, sta index = %u\n",
+		  v_matrix->nc_index, v_matrix->bw,
+		  avg_snr[0], avg_snr[1], avg_snr[2], avg_snr[3], avg_snr[4],
+		  avg_snr[5], ind->sounding_type, ind->sta_idx);
+}
+
+static void cl_sounding_indication_su(struct cl_hw *cl_hw,
+				      struct mm_sounding_ind *ind,
+				      struct cl_sounding_info *sounding_elem)
+{
+	struct cl_sta *cl_sta;
+	struct v_matrix_header *v_matrix = NULL;
+	u8 *avg_snr = NULL;
+	bool pairing = false;
+
+	v_matrix = sounding_elem->v_matrices_data + ind->v_matrix_offset[0];
+	avg_snr = (u8 *)v_matrix + v_matrix->padding;
+
+	cl_sta_lock(cl_hw);
+	cl_sta = cl_sta_get(cl_hw, ind->sta_idx);
+
+	if (cl_sta) {
+		struct cl_bf_sta_db *bf_db = &cl_sta->bf_db;
+
+		/* Update Nc for the current STA */
+		bf_db->nc = v_matrix->nc_index;
+		bf_db->sounding_indications++;
+
+		if (bf_db->sounding_indications == 1) {
+			/*
+			 * After getting first indication disable the timer and set the BF
+			 * bit in the firmware rate flags.
+			 */
+			del_timer(&bf_db->timer);
+			cl_bf_update_rate(cl_hw, cl_sta);
+			pairing = true;
+		}
+	}
+
+	cl_sta_unlock(cl_hw);
+
+	/* Send a msg to fw to pair the STA with sounding ID */
+	if (pairing)
+		cl_msg_tx_sounding_pairing(cl_hw, ind->sid, ind->sounding_type, 0, ind->sta_idx);
+
+	cl_sounding_indication_pr(cl_hw, ind, v_matrix, avg_snr);
+}
+
+void cl_sounding_indication(struct cl_hw *cl_hw, struct mm_sounding_ind *ind)
+{
+	struct cl_sounding_info *sounding_elem = NULL;
+
+	sounding_elem = cl_sounding_get_elem(cl_hw, ind->sid);
+
+	if (!sounding_elem) {
+		sounding_pr_err("[%s]: sounding id %u not found!\n", __func__, ind->sid);
+		return;
+	}
+
+	switch (ind->sounding_type) {
+	case SOUNDING_TYPE_HE_SU:
+	case SOUNDING_TYPE_HE_SU_TB:
+	case SOUNDING_TYPE_VHT_SU:
+	case SOUNDING_TYPE_HE_CQI:
+	case SOUNDING_TYPE_HE_CQI_TB:
+		break;
+	default:
+		sounding_pr_err("[%s]: Invalid sounding type %u\n", __func__,
+				ind->sounding_type);
+		return;
+	}
+
+		cl_sounding_indication_su(cl_hw, ind, sounding_elem);
+}
+
+void cl_sounding_recovery(struct cl_hw *cl_hw)
+{
+	/*
+	 * After recovery process we need to update sounding requests and
+	 * sounding interval in firmware
+	 */
+	struct cl_sounding_info *elem;
+
+	/* No sounding is active */
+	if (!cl_hw->sounding.num_soundings)
+		return;
+
+	/* Reset sounding parameters */
+	cl_sounding_recovery_reset(cl_hw);
+
+	/*
+	 * Go over all clients that had sounding before recovery,
+	 * and send a new sounding request to firmware.
+	 */
+
+	sounding_pr_trace("Start sounding recovery\n");
+
+	list_for_each_entry(elem, &cl_hw->sounding.head, list)
+		cl_bf_sounding_start(cl_hw, elem->type, elem->su_cl_sta_arr, elem->sta_num, elem);
+}
+
-- 
2.36.1

