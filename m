Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FCF532947
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbiEXLjJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236833AbiEXLjI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:08 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB044130C
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpcpgLV5iTdBNMSoCzEQmBKcJJ3RydfredsXRyVjaytskcWGcsJWSaxkH/5haIVk2hdFeWB8RtIBzztJoHF/Aq+Lf6+Mg1/SxpYpyvS+yjQ2qlPvU6HUEMxra0SQF5NcYXTMXm2XJ20PC0tYWnG2xvloLVxA6EbgeQiV9sl5zKhejbwEyPKpVb2+hyvsY8o1YGQtWZjB8vnY5rTQnEpZjgQZQhj9BBVKgM0+IzwaR8HhhIUunOJEMVG2ZdUU4t5j+qxqDsddd7Rz7BPd3jyt4dJfkWvmC/pYqzy630qD84IWDaZZrPtjNiI4tX1vJm9vD0QUPvKqAm7gHl/sEcaunA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4pCHF9gp7sEz693J8QX4CnSm0VS2lyIw0BvSapRomA=;
 b=M97hxtgpIx7Vr1QM0VwZUOeDa74cvVR1J5hiUHIb/MX2bMpz6rULN9vYc/0HpHvc8q/oagrt0Ssvb94FQizN7P9qSI7G3Ls9rFwJ5rCBhqmVAlTiWIBfSmh1dPaRiO8vrbCLtG1aLY/p3vR/hQz/W17vJnn6qsqNHAYQblsHq2Cd+Tz4+8m1xSWNk9Ai1SKxkdmbzIthvgBgTB5hWJjLaWTtzEvVht5QXXpcbdbVB1/yZ4ZJUwiiB9VR8GZmyiZa2g/m7esXCx1j0Cs16KnFNJgTM5IH9UxrLSdM6jlz7StqXB3QdEJuSTHjH0dx0mMAE+3A0oZ5MyFKGO7p/ybhcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4pCHF9gp7sEz693J8QX4CnSm0VS2lyIw0BvSapRomA=;
 b=yAVbLhu/QyOCYFHO3FDcEoYE5OGyDeQXg2jM5NeuQ6yB4T4Hf+rZ03S33LbcGkEyC4ZRaOjPdyYQAH0wyUxkw+TRQvZfLJMJzlO0H1CWoKO8GRtpUbl8KG72XcR8LBd0UHE6Cgyd+IkP7IXGlvTLrg3pEkTaKkrk3lpbn1jFGe0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VI1P192MB0384.EURP192.PROD.OUTLOOK.COM (2603:10a6:803:34::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 11:38:37 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:37 +0000
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
Subject: [RFC v2 32/96] cl8k: add fw.h
Date:   Tue, 24 May 2022 14:33:58 +0300
Message-Id: <20220524113502.1094459-33-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: b654ba23-7186-4873-775c-08da3d79df3d
X-MS-TrafficTypeDiagnostic: VI1P192MB0384:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1P192MB0384C90BC2931B596E84C74DF6D79@VI1P192MB0384.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0FHC5Pm19UnyfMZ9zbQpV5k667ulb0562LF2MNQPj+nUnfGu7nWRH6IBz5wb4NtYTwn/J8TWRZEc7KZRZkscmcw1gzYvzo8ieWMbLI2WpF6TUgskhcM+PdDkhRJjbqggPpPAlScE2NMpNR0quft5am7ahRbC849y2h0HsbCxCnJfIq9g0nKhst/CNTirs6kjjvLPAde399rdNroRRXGuTnsG6ZWlPL7ADWCzyXahFm3NSZ5Xq7BpDeQNav7WerIVbKaIXvt1ciU9jwH6ft+Mic6ZeObtk0C5SM5raZEyvJtazklGdPOfA7L3bpLuMG6oAE3tffBkQ8/kdxzSOy+9nNz2ca/cGOaDXcCof3mKv8eet3K8jNSF3H6WU2TRI4Gz35piR7mMwaIW1zRlfjenTl1CxpKfxzi4jP0S9T+kVFvYm9M4cT2eCifvdLw/RZjn47Teb0bGtQXDl2VcFs9VOqjj3jqt5yBEuHpY7JiC+/t3Uv9Qqm9T1+3a/XULPNLz7qFecqldzybo33nl/3lW02ZZGvAmIUnK5tKzZptfurhlykeLTFFyCdRgp3P+b8t9AE2RZ1OA0KvsSI/zUEoqYz9sv7U4mL5T6JM8EWyq8GUwZK0KfEJ16rBd3Tbmd0PCFiIbIVH2Pe09c0l0xLqOUrrxCIVBcNcCdTaDn4pIe9xW83cdT5b29SjeMoWGxR4UkbPQ5EbPER9aSbihDJbkUJ+/jE78jWNgriuR7qLJC3o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(346002)(39850400004)(376002)(41300700001)(36756003)(6666004)(30864003)(8936002)(508600001)(186003)(83380400001)(6486002)(6506007)(38100700002)(2906002)(38350700002)(6512007)(107886003)(5660300002)(2616005)(1076003)(66946007)(4326008)(8676002)(26005)(52116002)(316002)(6916009)(9686003)(66556008)(66476007)(86362001)(54906003)(32563001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xITO+sEKeTDK/PdwEmFxFGGxCkW9h50pnX++MW2wkUJTFpv6/PaGxdGWTv+T?=
 =?us-ascii?Q?1wucM6fKv8T0jYhROSFJnV/+/Q/cvcVwS5QLRz8cRBephRajnM8VUf1sRX6i?=
 =?us-ascii?Q?lLFIjBcJgFeIAtJJvEblN3ks857+UCjow3G+lqqe734ApuNcEFz7C66X7R0K?=
 =?us-ascii?Q?x0Ud/gOZuJRoZw3VfqecaenwWQzoQXlRm5pIbboLgd1OXeOu7xuE7pVcsfGp?=
 =?us-ascii?Q?JdnfhK2dfORKGeiCAQv1LGFwVQlXSIlVagu7z/EFRXkLgBIGA+buhqcbSM/2?=
 =?us-ascii?Q?7jnRkIohXGiXVnd2M7gQz8HqethYj5bLKpMHTSU19sOuoANTDpibfallXab3?=
 =?us-ascii?Q?v2DnNuCVVE8DUncMwIJ+Nl5UJNVXNzlbwQaFkX5yesUWLgDl/5R9992e+c4e?=
 =?us-ascii?Q?OOVPUAK+O7u+etEr/sCpC9WbyabalWXrpLCrND7euwmHLRopEF7FwkjK9NU5?=
 =?us-ascii?Q?G+tqZbtuZeWEznicnd5RuV5x70DV+draPUtP+4fK6EHhh2PCbNb+n6s8RfXM?=
 =?us-ascii?Q?RM+wTbGRiTEeraOylHWzCJYS6orxOgr9wSu4KbckZiCn4k0qPVuxgfRIF1Jw?=
 =?us-ascii?Q?sF0CQ/mglQNpUKZswxL7vaUptZMHKzNfC0gxcYj+Lqk0DktP1VjnhxAvDe2a?=
 =?us-ascii?Q?yv3MnlZ3YCuS78TyS8tM7lDgmPK8vP5+DFpgonHbP8vkrrPXxKMCQ8pTMUEE?=
 =?us-ascii?Q?7rbj3m1zU6lH8pipyd9XqawXSe/re2ajmHOd2dGOBEqfsPX5F644T+S5Dbvz?=
 =?us-ascii?Q?O1SmUP7hLvDBo+85vbYT5CB/4m25yUEHBhcuuHbEt8Kp3yxmSp2Lw2tIMIWG?=
 =?us-ascii?Q?9hNPDbCoW95tj1JBJztigISJBYq3U9qKpum0UHAnGhSCIG0VGC4XG47A3dzR?=
 =?us-ascii?Q?7v7I9BqI1pfFzg+cnEgOdUW14j3DiPZYo6oP2CYIePZM1Qsre9frcSsKNT8N?=
 =?us-ascii?Q?vJk4NjXqzQGVI9ZawuJMt6lIs/JRKd6Q8FPw0PL2/v7ptliokjOu6EBI8HSb?=
 =?us-ascii?Q?ms6HH4NvqfXEBTfiaYbXYc5ohGQOWG6IeAy7ljZP1ntUYNc2I4cL5uHUM0Kz?=
 =?us-ascii?Q?XCcMQvCW1fjSrTBIFT6DvtiUnGP0HIxPAL/Dx7qgw+OugN5wQ4Tiowy137Mt?=
 =?us-ascii?Q?9PccKrqeAdFmxH4oDPg06HSE625iqhs4o+3BJhcK4HpjkbsDIbg3G5KSxlsA?=
 =?us-ascii?Q?qyogSuFya2lI+b4gSdYiqOtoUgCZ51XSP7xSAzQt3RQEfmY7CGotdx6b6iRu?=
 =?us-ascii?Q?/o7WxrXx2V+uJWGuxZ7CHHV53ximdbcQmAqJ8+uLk/Nle6ItbUc79X2MY69W?=
 =?us-ascii?Q?pD1DTyDOrRGs9mw5I1OM2Ia6nq5oLaTx/lglZSH5Cac+g6hpKxrntZj70kHm?=
 =?us-ascii?Q?owhyn0BK8ekvulp7pomKjQNtqr2DRv6ZAdJUfkTtHUDpVhcU+L9XOIT0MVbb?=
 =?us-ascii?Q?9TB1FEV1D+aZ8HvBSrRB78uJ04VcetIZ7qqNCyZlkBzdxdx+9Ltk634JVvb/?=
 =?us-ascii?Q?hCp/ebTkSFYOX1Ux0DjCXPsqD1fDCGh0c2C7fUidQFTAa1yfiUmBXp5PYGrv?=
 =?us-ascii?Q?YMWVr42sHLCQIoYj0tWyRwNhkRb8MaCrEamUxJK/tiHFubCW4cC2Wx6xt+3t?=
 =?us-ascii?Q?ybUhvfbXuXl32EcwYTEntKIFEEZ7TrFL8Tr5Hl2ekWq3S6/707ILmT4KYNa0?=
 =?us-ascii?Q?OAJto1Wm2d58HdpVHjbchmg+vJHeD2yCPxmxTYt4YcoIUsj2djgucqPBQ853?=
 =?us-ascii?Q?b+mbChxXR5Eie9RClulIkV+fEjeF7ko=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b654ba23-7186-4873-775c-08da3d79df3d
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:07.4061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPKB1ZkioRi2fSg3Y5THvqpVTGX4kV4dasFenepDLK1zXSaTM4rtOlPjDWhHsJ57DyZqpWbGzsy7tKRFj8HVbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P192MB0384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
 drivers/net/wireless/celeno/cl8k/fw.h | 1462 +++++++++++++++++++++++++
 1 file changed, 1462 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw.h

diff --git a/drivers/net/wireless/celeno/cl8k/fw.h b/drivers/net/wireless/celeno/cl8k/fw.h
new file mode 100644
index 000000000000..12f573c0188c
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/fw.h
@@ -0,0 +1,1462 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_FW_H
+#define CL_FW_H
+
+#include <linux/module.h>
+
+#include "calib.h"
+#include "wrs.h"
+
+#if !defined(__LITTLE_ENDIAN_BITFIELD) && !defined(__BIG_ENDIAN_BITFIELD)
+#error "Please fix <asm/byteorder.h>"
+#endif
+
+#define KEY_SRAM_BASE_VAL 64
+#define INVALID_AMPDU_CNT U8_MAX
+
+enum {
+	DBG_INFO_DUMP = 1,
+	DBG_INFO_TX_STATS,
+	DBG_INFO_BCN_STATS,
+	DBG_INFO_RX_STATS,
+	DBG_INFO_DYN_CAL_STATS,
+	DBG_INFO_RATE_FALLBACK_STATS,
+	DBG_INFO_BF,
+	DBG_INFO_TRIGGER_FLOW,
+	DBG_INFO_QUEUE_IDX_DIFF,
+	DBG_INFO_MAX,
+	DBG_INFO_UNSET = DBG_INFO_MAX
+};
+
+struct cl_rx_trigger_based_stats {
+	bool enable;
+	bool modify;
+	u8 ampdu_cnt;
+	u16 data_per_agg;
+	u16 qos_null_per_agg;
+	u32 total;
+	u32 data[DBG_STATS_MAX_AGG_SIZE];
+	u32 qos_null[TID_MAX + 2];
+	u32 total_per_mu[MU_UL_MAX];
+	u32 qos_null_per_mu[MU_UL_MAX];
+	u32 data_per_mu[MU_UL_MAX];
+	u16 data_per_mu_agg[MU_UL_MAX];
+	u32 data_per_mu_agg_size[MU_UL_MAX][DBG_STATS_MAX_AGG_SIZE];
+};
+
+struct cl_rx_trigger_based_sta_stats {
+	bool modify;
+	u8 ampdu_cnt;
+	u16 data_per_sta[CL_MAX_NUM_STA];
+	u32 data_per_sta_agg[CL_MAX_NUM_STA][DBG_STATS_MAX_AGG_SIZE];
+};
+
+void cl_fw_dbg_handler(struct cl_hw *cl_hw);
+int cl_fw_dbg_trigger_based_init(struct cl_hw *cl_hw);
+void cl_fw_dbg_trigger_based_deinit(struct cl_hw *cl_hw);
+void cl_fw_dbg_trigger_based_update(struct cl_hw *cl_hw, struct hw_rxhdr *rxhdr,
+				    struct ieee80211_hdr *hdr);
+void cl_fw_dbg_trigger_based_sta_update(struct cl_hw *cl_hw, struct hw_rxhdr *rxhdr,
+					struct ieee80211_hdr *hdr);
+
+struct cl_dma_accessed {
+	void *drv_v_addr;
+	u32 size;
+	u32 fw_v_addr;
+	u32 dma_addr;
+};
+
+struct cl_cached_fw {
+	void *data;
+	size_t size;
+};
+
+int cl_fw_file_load(struct cl_hw *cl_hw);
+void cl_fw_file_cleanup(struct cl_hw *cl_hw);
+void cl_fw_file_release(struct cl_hw *cl_hw);
+
+#define MSG_SHIFT              8
+#define NEW_MSG_SHIFT          1
+#define INTERNAL_MSG_COUNT     5
+#define FIRST_MSG(task)        ((task) << MSG_SHIFT)
+#define SHIFTED_MSG(id, shift) ((id) + NEW_MSG_SHIFT + (shift))
+
+/* Message structure. */
+struct cl_fw_msg {
+	__le16 msg_id;  /* Message ID. */
+	u8 dst_kern_id; /* Destination kernel ID. */
+	u8 dst_task_id; /* Destination task ID. */
+	u8 src_kern_id; /* Source kernel ID. */
+	u8 src_task_id; /* Source task ID. */
+	__le16 param_len;  /* Parameter embedded struct length. */
+	__le32 param[1];   /* Parameter embedded struct - must be word-aligned. */
+};
+
+enum {
+	TASK_MM,
+	TASK_DBG,
+	TASK_MAX,
+};
+
+/* List of messages related to the task. */
+enum mm_msg_tag {
+	/* Reset message */
+	MM_RESET_REQ = FIRST_MSG(TASK_MM),
+	MM_RESET_CFM,
+	/* Start message */
+	MM_START_REQ,
+	MM_START_CFM,
+	/* Version message */
+	MM_VERSION_REQ,
+	MM_VERSION_CFM,
+	/* Add interface message */
+	MM_ADD_IF_REQ,
+	MM_ADD_IF_CFM,
+	/* Remove interface message */
+	MM_REMOVE_IF_REQ,
+	MM_REMOVE_IF_CFM,
+	/* Station add message */
+	MM_STA_ADD_REQ,
+	MM_STA_ADD_CFM,
+	/* Station del message */
+	MM_STA_DEL_REQ,
+	MM_STA_DEL_CFM,
+	/* Set filter message */
+	MM_SET_FILTER_REQ,
+	MM_SET_FILTER_CFM,
+	/* Set channel message */
+	MM_SET_CHANNEL_REQ = SHIFTED_MSG(MM_SET_FILTER_CFM, 2),
+	MM_SET_CHANNEL_CFM,
+	/* External calibration message */
+	MM_EXT_CALIB_REQ,
+	MM_EXT_CALIB_CFM,
+	/* Set DTIM message */
+	MM_SET_DTIM_REQ,
+	MM_SET_DTIM_CFM,
+	/* Set beacon interval message */
+	MM_SET_BEACON_INT_REQ,
+	MM_SET_BEACON_INT_CFM,
+	/* Set basic rates message */
+	MM_SET_BASIC_RATES_REQ,
+	MM_SET_BASIC_RATES_CFM,
+	/* Set BSSID message */
+	MM_SET_BSSID_REQ,
+	MM_SET_BSSID_CFM,
+	/* Set EDCA message */
+	MM_SET_EDCA_REQ,
+	MM_SET_EDCA_CFM,
+	/* Set association message */
+	MM_SET_ASSOCIATED_REQ,
+	MM_SET_ASSOCIATED_CFM,
+	/* Set slot time message */
+	MM_SET_SLOTTIME_REQ,
+	MM_SET_SLOTTIME_CFM,
+	/* Set idle message */
+	MM_SET_IDLE_REQ,
+	MM_SET_IDLE_CFM,
+	/* Key add message */
+	MM_KEY_ADD_REQ = SHIFTED_MSG(MM_SET_IDLE_CFM, 2),
+	MM_KEY_ADD_CFM,
+	/* Key delete message */
+	MM_KEY_DEL_REQ,
+	MM_KEY_DEL_CFM,
+	/* Block ack add TX message */
+	MM_BA_ADD_TX_REQ,
+	MM_BA_ADD_TX_CFM,
+	/* Block ack add RX message */
+	MM_BA_ADD_RX_REQ,
+	MM_BA_ADD_RX_CFM,
+	/* Block ack delete message */
+	MM_BA_DEL_REQ,
+	MM_BA_DEL_CFM,
+	/* PHY reset message */
+	MM_PHY_RESET_REQ,
+	MM_PHY_RESET_CFM,
+	/* Available BA TX queue message */
+	MM_AVAILABLE_BA_TXQ_REQ,
+	MM_AVAILABLE_BA_TXQ_CFM,
+	/* Update rate DL message */
+	MM_UPDATE_RATE_DL_REQ,
+	MM_UPDATE_RATE_DL_CFM,
+	/* Update rate UL message */
+	MM_UPDATE_RATE_UL_REQ,
+	MM_UPDATE_RATE_UL_CFM,
+	/* Set VNS message */
+	MM_SET_VNS_REQ,
+	MM_SET_VNS_CFM,
+	/* Set TX BF message */
+	MM_SET_TX_BF_REQ,
+	MM_SET_TX_BF_CFM,
+	/* Sounding message */
+	MM_SOUNDING_REQ,
+	MM_SOUNDING_CFM,
+	/* Sounding pairing message */
+	MM_SOUNDING_PAIRING_REQ,
+	MM_SOUNDING_PAIRING_CFM,
+	/* Sounding interval message */
+	MM_SOUNDING_INTERVAL_REQ,
+	MM_SOUNDING_INTERVAL_CFM,
+	/* Set DFS message */
+	MM_SET_DFS_REQ = SHIFTED_MSG(MM_SOUNDING_INTERVAL_CFM, 4),
+	MM_SET_DFS_CFM,
+	/* Set NDP TX control message */
+	MM_NDP_TX_CONTROL_REQ = SHIFTED_MSG(MM_SET_DFS_CFM, 2),
+	MM_NDP_TX_CONTROL_CFM,
+	/* Register write message */
+	MM_REG_WRITE_REQ,
+	MM_REG_WRITE_CFM,
+	/* Protection mode message */
+	MM_PROT_MODE_REQ,
+	MM_PROT_MODE_CFM,
+	/* Backup beacon enable message */
+	MM_BACKUP_BCN_EN_REQ = SHIFTED_MSG(MM_PROT_MODE_CFM, 4),
+	MM_BACKUP_BCN_EN_CFM,
+	/* Start periodic TX time message */
+	MM_START_PERIODIC_TX_TIME_REQ,
+	MM_START_PERIODIC_TX_TIME_CFM,
+	/* Anamon read message */
+	MM_ANAMON_READ_REQ,
+	MM_ANAMON_READ_CFM,
+	/* Refresh power message */
+	MM_REFRESH_PWR_REQ = SHIFTED_MSG(MM_ANAMON_READ_CFM, 10),
+	MM_REFRESH_PWR_CFM,
+	/* Set antenna power offset message */
+	MM_SET_ANT_PWR_OFFSET_REQ,
+	MM_SET_ANT_PWR_OFFSET_CFM,
+	/* Set rate fallback message */
+	MM_SET_RATE_FALLBACK_REQ,
+	MM_SET_RATE_FALLBACK_CFM,
+	/* SPI write message */
+	MM_SPI_WRITE_REQ = SHIFTED_MSG(MM_SET_RATE_FALLBACK_CFM, 6),
+	MM_SPI_WRITE_CFM,
+	/* SPI read message */
+	MM_SPI_READ_REQ,
+	MM_SPI_READ_CFM,
+	MM_REQ_CFM_MAX = SHIFTED_MSG(MM_SPI_READ_CFM, 2),
+
+	/* ############### Firmware indication messages   ############### */
+	/* Start of indication messages */
+	MM_FIRST_IND = SHIFTED_MSG(MM_REQ_CFM_MAX, INTERNAL_MSG_COUNT),
+	/* TX aggregation indication from FW */
+	MM_AGG_TX_REPORT_IND = MM_FIRST_IND,
+	/* RX aggregation indication from FW */
+	MM_AGG_RX_REPORT_IND,
+	/* Indication for BF sounding */
+	MM_SOUNDING_IND,
+	/* Indication of fw error */
+	MM_FW_ERROR_IND = SHIFTED_MSG(MM_SOUNDING_IND, 2),
+	/* Async indication that MAC is in idle */
+	MM_IDLE_ASYNC_IND,
+
+	/* MAX number of messages */
+	MM_MAX,
+};
+
+/* Interface types */
+enum {
+	MM_STA,
+	MM_IBSS,
+	MM_AP,
+	MM_MONITOR,
+	MM_MESH_POINT,
+};
+
+/* BA agreement types */
+enum {
+	/* BlockAck agreement for TX */
+	BA_AGMT_TX,
+	/* BlockAck agreement for RX */
+	BA_AGMT_RX,
+};
+
+/* BA agreement related status */
+enum {
+	BA_AGMT_ESTABLISHED,
+	BA_AGMT_ALREADY_EXISTS,
+	BA_AGMT_DELETED,
+	BA_AGMT_DOES_NOT_EXIST,
+	BA_AGMT_NOT_ESTABLISHED,
+};
+
+/* MM_BA_TXQUEUE request / confirm related status */
+enum {
+	BA_TXQUEUE_INVALID,
+	BA_TXQUEUE_VALID,
+};
+
+/* MAC address structure. */
+struct mac_addr {
+	/* Array of bytes that make up the MAC address. */
+	u8 array[ETH_ALEN];
+};
+
+/* DCOC/IQ Calibration related defines */
+#define CALIB_SUCCESS 0x00
+#define CALIB_FAIL    0x01
+
+#define REG_OVERWRITE_DATA_MAX 3
+#define REG_OVERWRITE_REGS_MAX 20
+
+struct cl_rf_reg_overwrite_info {
+	u8 cmd;
+	__le32 data[REG_OVERWRITE_DATA_MAX];
+};
+
+struct cl_antenna_config {
+	/* Number of antennas */
+	u8 num_tx_he;
+	u8 num_tx_ofdm_ht_vht;
+	u8 num_rx;
+	/* Mask of antennas */
+	u8 mask_tx_he;
+	u8 mask_tx_ofdm_ht_vht;
+	u8 mask_rx;
+	/* CCK mask */
+	u8 mask_tx_cck;
+	u8 mask_rx_cck;
+	/* CDB_mask 0x0 -> SX0 chain. 0x1-> SX1 chain. */
+	u8 cdb_mask;
+};
+
+#define FEM_LUTS_PER_REGISTER  2
+#define FEM_LUT_AMOUNT_PER_MAC 6
+#define FEM_REGISTERS_AMOUNT   (FEM_LUT_AMOUNT_PER_MAC / FEM_LUTS_PER_REGISTER)
+
+struct cl_fem_config {
+	__le32 reg[FEM_REGISTERS_AMOUNT];
+};
+
+struct cl_cca_config {
+	u8 ed_rise_thr_dbm;
+	u8 ed_fall_thr_dbm;
+	u8 cs_en;
+	u8 modem_en;
+	u8 main_ant;
+	u8 second_ant;
+	u8 flag0_ctrl;
+	u8 flag1_ctrl;
+	u8 flag2_ctrl;
+	u8 flag3_ctrl;
+	u8 gi_rise_thr_dbm;
+	u8 gi_fall_thr_dbm;
+	u8 gi_pow_lim_dbm;
+	__le16 ed_en;
+	u8 gi_en;
+};
+
+/* Structure containing the parameters of the PHY configuration */
+struct cl_phy_cfg {
+	struct cl_cca_config cca_config;
+	struct cl_antenna_config ant_config;
+	struct cl_fem_config fem_conf;
+	u8 first_start;
+	u8 channel_bandwidth;
+	u8 band; /* 0 = 2.4g / 1 = 5g / 2 = 6g */
+	u8 other_band;
+	__le16 freq_offset;
+	u8 rx_sensitivity[MAX_ANTENNAS];
+	u8 vns_tx_power_mode;
+	u8 vns_rssi_suto_resp_th;
+	u8 afe_config_en;
+	u8 no_capture_noise_sleep;
+	u8 ht_rxldpc_en;
+	u8 gain_update_enable;
+	u8 mcs_sig_b;
+	u8 ofdm_only;
+	u8 hr_factor;
+	u8 td_csd_en;
+	u8 pe_duration_bcast;
+	__le32 tx_digital_gain;
+	__le32 tx_digital_gain_cck;
+	u8 ofdm_cck_power_offset;
+	u8 phy_clk_gating_en;
+	u8 tcv1_chains_sx0;
+	u8 dsp_lcu_mode;
+	u8 is_first_rfic;
+	u8 precalibration_enable;
+	/* For RF debug - this field should be deleted after RF bring up */
+	struct cl_rf_reg_overwrite_info rf_reg_overwrite_info[REG_OVERWRITE_REGS_MAX];
+};
+
+enum {
+	CENX_CFG_DEBUG_PRINT,
+	CENX_CFG_INT_FRAME,
+	CENX_CFG_CE_TX_CFM,
+};
+
+#define IPC_TXQ_CNT  5
+
+/* MM_START_REQ parameters */
+struct cl_start_param {
+	__le32 comp_flags;
+	__le16 cfm_size;
+	__le32 cfm_dma_base_addr;
+	__le16 phy_dev;
+	__le16 fw_scale_down;
+	__le16 dbg_test_mode_max;
+	struct {
+		__le32 idle;
+		__le32 ac0;
+		__le32 ac1;
+		__le32 ac2;
+		__le32 ac3;
+		__le32 bcn;
+	} hal_timeout;
+	/*
+	 * this is the pointer to the dma base address of the host struct
+	 * that hold all the dma addresses of the ipc host queues
+	 */
+	__le32 ipc_host_tx_queues_dma_addr;
+	/* Address of RX buffer in host RAM */
+	__le32 host_rxbuf_base_addr[CL_RX_BUF_MAX];
+	/* Address of HOST indices */
+	__le32 ipc_ring_indices_base;
+	u8 prot_log_nav_en;
+	u8 prot_mode;
+	u8 prot_rate_format;
+	u8 prot_rate_mcs;
+	u8 prot_rate_pre_type;
+	u8 bw_signaling_mode;
+	u8 mult_ampdu_in_txop_en;
+	u8 preemptive_backoff_en;
+	__le32 cca_timeout;
+	u8 short_retry_limit;
+	u8 long_retry_limit;
+	u8 assoc_auth_retry_limit;
+	__le16 bcn_tx_path_min_time;
+	u8 backup_bcn_en;
+	u8 tx_txop_cut_en;
+	u8 ps_ctrl_enabled;
+	u8 ac_with_bcns_flushed_cnt_thr;
+	__le32 txl_statistics_struct_size;
+	__le32 rxl_statistics_struct_size;
+	struct dbg_meta_data dbg_metadata;
+	u8 phy_err_prevents_phy_dump;
+	u8 tx_rx_delay;
+	u8 assert_storm_detect_thd;
+	u8 assert_time_diff_sec;
+	__le16 ipc_rxbuf_size[CL_RX_BUF_MAX];
+	u8 host_pci_gen_ver;
+	u8 dma_lli_max_chan[2];
+	u8 production_mode;
+	u8 bw_factor_q2[CHNL_BW_MAX];
+	u8 ant_factor_q2[MAX_ANTENNAS];
+	u8 min_ant_pwr_q1;
+	struct {
+		u8 auto_resp_all  : 2;
+		u8 auto_resp_msta : 2;
+		u8 rsv            : 4;
+	} default_distance;
+	__le32 phy_data_dma_addr;
+	__le32 phy_remote_rom_dma_addr;
+	__le32 iq_dcoc_calib_tables_dma_addr;
+	__le32 power_table_dma_addr;
+	__le32 tf_info_dma_addr;
+	u8 su_force_min_spacing_usec;
+	u8 mu_force_min_spacing_usec;
+	u8 single_tcv;
+	u8 rx_padding;
+	u8 bar_cap_disable;
+	u8 hw_bsr;
+	u8 drop_to_lower_bw;
+	u8 dra_enable;
+	u8 mac_clk_gating_en;
+	u8 imaging_blocker;
+	u8 fec_coding;
+	u8 cs_required;
+	u8 fw_disable_recovery;
+};
+
+struct cl_tx_params {
+	__le32 rate;
+	__le32 rate_he;
+	u8 req_bw_tx;
+	u8 ant_set;
+	u8 ltf;
+};
+
+struct mm_update_rate_dl_req {
+	u8 op_mode;
+	u8 sta_idx;
+	u8 mu_is_rate_valid;
+	u8 group_id;
+	struct cl_tx_params tx_params;
+	__le32 rate_fallback;
+	u8 ltf_fallback;
+};
+
+struct mm_update_rate_ul_req {
+	u8 op_mode;
+	u8 mu_is_rate_valid;
+	u8 group_id;
+	u8 sta_idx;
+	u8 bw;
+	u8 nss;
+	u8 mcs;
+	u8 gi_ltf;
+};
+
+struct mm_set_ant_pwr_offset_req {
+	/* Power offset (0.25dB resoultion) */
+	u8 pwr_offset[MAX_ANTENNAS];
+};
+
+struct mm_rate_fallback_req {
+	u8 fallback_count_su;
+	u8 fallback_count_mu;
+	u8 ba_per_thr;
+	u8 ba_not_received_thr;
+	u8 retry_count_thr;
+	u8 disable_mcs0;
+};
+
+struct mm_set_vns_req {
+	u8 sta_idx;
+	u8 is_vns;
+};
+
+struct mm_set_tx_bf_req {
+	u8 sta_idx;
+	u8 is_on;
+	u8 is_on_fallback;
+};
+
+/* Structure containing the parameters of the MM_START_REQ message */
+struct mm_start_req {
+	/* PHY configuration */
+	struct cl_phy_cfg phy_cfg;
+	/* Other start parameters */
+	struct cl_start_param param;
+};
+
+struct mm_mac_api_lut_line {
+	__le16 frequency_q2;
+	union {
+		struct {
+			struct {
+				u8 vcocalsel;
+				u8 nint;
+				__le32 nfrac;
+				__le32 freqmeastarg;
+			} xco_40M;
+			struct {
+				u8 vcocalsel;
+				u8 nint;
+				__le32 nfrac;
+				__le32 freqmeastarg;
+			} xco_60M;
+		} olympus_2_lines;
+		struct {
+			struct {
+				u8 vcocalsel;
+				u8 nint;
+				__le32 nfrac;
+				__le32 freqmeastarg;
+			} xco_40M;
+			struct {
+				u8 vcocalsel;
+				u8 nint;
+				__le32 nfrac;
+				__le32 freqmeastarg;
+			} xco_60M_s0;
+			struct {
+				u8 vcocalsel;
+				u8 nint;
+				__le32 nfrac;
+				__le32 freqmeastarg;
+			} xco_60M_s1;
+		} olympus_3_lines;
+	} rfic_specific;
+};
+
+struct cl_calib_other_tcv {
+	/* Parameters for calibration */
+	__le16 prim20_freq;
+	struct mm_mac_api_lut_line center1_freq_lut;
+	/* Parameter to restore previous configuration of other TCV */
+	u8 mask_tx_he;
+	u8 num_tx_he;
+	u8 band;
+};
+
+struct cl_calib_conf {
+	u8 rx_gain_upper_limit;
+	u8 rx_gain_lower_limit;
+	__le16 nco_freq;
+	s8 nco_amp;
+	u8 sleeve_trshld;
+	u8 n_samples_exp_lolc;
+	u8 n_samples_exp_iqc;
+	__le32 p_thresh;
+	u8 n_bit_fir_scale;
+	u8 n_bit_amp_scale;
+	u8 n_bit_phase_scale;
+	__le16 tone_vector[IQ_NUM_TONES_REQ];
+	__le32 gp_rad_trshld;
+	__le32 ga_lin_upper_trshld;
+	__le32 ga_lin_lower_trshld;
+	u8 comp_filter_len;
+	u8 singletons_num;
+	u8 tones_num;
+	__le16 rampup_time;
+	__le16 lo_coarse_step;
+	__le16 lo_fine_step;
+	u8 precalibration_enable;
+};
+
+struct cl_calib_param {
+	u8 mode;
+	u8 dcoc_max_vga;
+	struct cl_calib_chain tx_calib_chain[MAX_ANTENNAS];
+	struct cl_calib_chain rx_calib_chain[MAX_ANTENNAS];
+	struct cl_calib_conf conf;
+	struct cl_calib_other_tcv other_tcv;
+};
+
+/* Structure containing the parameters of the MM_SET_CHANNEL_REQ message */
+struct mm_set_channel_req {
+	/* Band (2.4GHz, 5GHz, 6GHz) */
+	u8 band;
+	u8 other_band;
+	/* Channel type: 20,40,80 or 160 MHz */
+	u8 bandwidth;
+	/* Frequency for Primary 20MHz channel (in MHz) */
+	__le16 prim20_freq;
+	/* Frequency for Center of the contiguous channel or center of Primary 80+80 */
+	struct mm_mac_api_lut_line center1_freq_lut;
+	/* Antenna configuration */
+	struct cl_antenna_config ant_config;
+	/* FEM configuration */
+	struct cl_fem_config fem_conf;
+	/* For RF debug - this field should be deleted after RF bring up */
+	struct cl_rf_reg_overwrite_info rf_reg_overwrite_info[REG_OVERWRITE_REGS_MAX];
+	u8 calib_info_set;
+	/* Calibration configuration */
+	struct cl_calib_param calib_param;
+	/* Antenna power offset */
+	u8 ant_pwr_offset[MAX_ANTENNAS];
+	/*
+	 * Frequency offset in MHz between current synthesizer's center channel,
+	 * and the other synthesizer's channel.
+	 * Needed for LOLC and IQC Calibration. Otherwise, shouldn't be used.
+	 */
+	s8 sx_freq_offset_mhz;
+	/* Hr factor */
+	u8 hr_factor;
+	/* Signal extension enable (for 2.4G sifs10 mode), should be 1 for 2,4 band by default */
+	u8 signal_ext;
+};
+
+enum mm_ext_calib_command {
+	MM_EXT_CALIB_CMD_INIT_SX,
+	MM_EXT_CALIB_CMD_SET_CHANNEL,
+	MM_EXT_CALIB_CMD_INIT_AND_SET_CHANNEL,
+	MM_EXT_CALIB_CMD_MAX
+};
+
+struct mm_ext_calib_init_sx_req {
+	u8 band;
+	u8 cdb_mask;
+	u8 mask_tx_he;
+	u8 num_tx_he;
+	u8 sx_idx;
+};
+
+struct mm_ext_calib_set_channel_req {
+	u8 band;
+	u8 bandwidth;
+	__le16 prim20_freq;
+	struct mm_mac_api_lut_line center1_freq_lut;
+	u8 sx_idx;
+};
+
+struct mm_ext_calib_init_and_set_req {
+	u8 band;
+	u8 cdb_mask;
+	u8 bandwidth;
+	__le16 prim20_freq;
+	struct mm_mac_api_lut_line center1_freq_lut;
+	__le16 remote_prim20_freq;
+	struct mm_mac_api_lut_line remote_center1_freq_lut;
+};
+
+union mm_ext_calib_cmd_req {
+	struct mm_ext_calib_init_sx_req init_sx;
+	struct mm_ext_calib_set_channel_req set_channel;
+	struct mm_ext_calib_init_and_set_req init_and_set;
+};
+
+struct mm_ext_calib_req {
+	u8 cmd;
+	union mm_ext_calib_cmd_req u;
+};
+
+/* Structure containing the parameters of the MM_SET_DTIM_REQ message */
+struct mm_set_dtim_req {
+	u8 dtim_period;
+};
+
+/* Structure containing the parameters of the MM_SET_BEACON_INT_REQ message */
+struct mm_set_beacon_int_req {
+	__le16 beacon_int;
+	/* Index of the interface */
+	u8 inst_nbr;
+};
+
+/* Structure containing the parameters of the MM_SET_BASIC_RATES_REQ message */
+struct mm_set_basic_rates_req {
+	/* Basic rate set (as expected by bssBasicRateSet field of Rates MAC HW register) */
+	__le32 rates;
+};
+
+/* Structure containing the parameters of the MM_SET_BSSID_REQ message */
+struct mm_set_bssid_req {
+	/* BSSID to be configured in HW */
+	struct mac_addr bssid;
+	/* Index of the interface for which the parameter is configured */
+	u8 inst_nbr;
+};
+
+/* Structure containing the parameters of the MM_SET_FILTER_REQ message */
+struct mm_set_filter_req {
+	__le32 filter;
+};
+
+/* Structure containing the parameters of the MM_ADD_IF_REQ message. */
+struct mm_add_if_req {
+	u8 type;
+	struct mac_addr addr;
+	u8 inst_nbr;
+	u8 tx_strip_vlan;
+	u8 rx_push_vlan;
+	__le32 rx_push_vlan_tag;
+	__le32 rx_filter_monitor_mask;
+	__le32 mac_addr_hi_mask;
+	__le32 mac_addr_low_mask;
+	u8 start_dtim_count;
+	u8 mbssid_mode;
+};
+
+/* Structure containing the parameters of the MM_SET_EDCA_REQ message */
+struct mm_set_edca_req {
+	__le32 ac_param;
+	u8 hw_queue;
+	u8 mu_edca_aifsn;
+	u8 mu_edca_ecw_min_max;
+	u8 mu_edca_timer;
+};
+
+struct mm_config_cca_req {
+	u8 enable;
+};
+
+struct mm_set_dfs_req {
+	bool enable;
+	bool standard_fcc;
+	u8 initial_gain;
+	u8 agc_cd_th;
+};
+
+struct mm_ndp_tx_control_req {
+	u8 chain_mask;
+	u8 bw;
+	u8 format;
+	u8 num_ltf;
+};
+
+struct mm_reg_write_req {
+	__le32 address;
+	__le32 value;
+	__le32 mask;
+};
+
+struct mm_prot_mode_req {
+	u8 log_nav_en;
+	u8 mode;
+	u8 rate_format;
+	u8 rate_mcs;
+	u8 rate_pre_type;
+};
+
+enum mac_idle_cmd {
+	MAC_ACTIVE = 0,
+	MAC_IDLE_SYNC,
+	MAC_IDLE_ASYNC
+};
+
+struct mm_set_idle_req {
+	u8 hw_idle;
+};
+
+/* Structure containing the parameters of the MM_SET_SLOTTIME_REQ message */
+struct mm_set_slottime_req {
+	/* Slot time expressed in us */
+	u8 slottime;
+};
+
+/* Structure containing the parameters of the MM_SET_ASSOCIATED_REQ message */
+struct mm_set_associated_req {
+	/* Association Id received from the AP */
+	__le16 aid;
+	/* Mask address high - [47:32] */
+	__le32 bssid_hi_mask;
+	/* Mask address low - [31:0] */
+	__le32 bssid_low_mask;
+};
+
+/* Structure containing the parameters of the MM_ADD_IF_CFM message. */
+struct mm_add_if_cfm {
+	/* Status of operation (different from 0 if unsuccessful) */
+	u8 status;
+};
+
+/* Structure containing the parameters of the MM_REMOVE_IF_REQ message. */
+struct mm_remove_if_req {
+	/* Interface index assigned by the firmware */
+	u8 inst_nbr;
+};
+
+/* Structure containing the parameters of the MM_VERSION_CFM message. */
+struct mm_version_cfm {
+	struct {
+		__le32 dsp;
+		__le32 rfic_sw;
+		__le32 rfic_hw;
+		__le32 agcram;
+		char fw[CL_VERSION_STR_SIZE];
+	} versions;
+	u8 rf_crystal_mhz;
+};
+
+/* Structure containing the parameters of the MM_STA_ADD_REQ message. */
+struct mm_sta_add_req {
+	/* Exponent for calculating HE Maximum A-MPDU size */
+	u8 ampdu_size_exp_he;
+	/* Exponent for calculating VHT Maximum A-MPDU size */
+	u8 ampdu_size_exp_vht;
+	/* Exponent for calculating HT Maximum A-MPDU size */
+	u8 ampdu_size_exp_ht;
+	/* MAC address of the station to be added */
+	struct mac_addr mac_addr;
+	/* A-MPDU spacing, in us */
+	u8 ampdu_min_spacing;
+	/* Interface index */
+	u8 inst_nbr;
+	/* Support ldpc Tx */
+	u8 ldpc_enabled;
+	/* MU beamformee capable */
+	u8 mu_bfee;
+	/* SU beamformee capable */
+	u8 su_bfee;
+	/* Station AID */
+	__le16 aid;
+	/* My_aid - ??? */
+	__le16 my_aid;
+	/* Index of station in case of recovery */
+	u8 recovery_sta_idx;
+	u8 max_sp;
+	u8 uapsd_queues;
+	/* TX params */
+	struct cl_tx_params tx_params;
+	/*
+	 * PE duration (0 = 0us, 1 = 8us, 2 = 16us)
+	 * SS0 bits 0-1, SS1 bits 2-3, SS2 bits 4-5, SS3 bits 6-7.
+	 */
+	u8 pe_duration[CHNL_BW_MAX][WRS_MCS_MAX_HE];
+	u8 he_tf_mac_padding_duration;
+	u8 he_rx_ctrl_frm_to_mbss;
+	u8 he_rx_1024qam_under_ru242;
+};
+
+/* Structure containing the parameters of the MM_STA_ADD_CFM message. */
+struct mm_sta_add_cfm {
+	/* Status of the operation (different from 0 if unsuccessful) */
+	u8 status;
+	/* Index assigned by the firmware to the newly added station */
+	u8 sta_idx;
+};
+
+/* Structure containing the parameters of the MM_STA_DEL_REQ message. */
+struct mm_sta_del_req {
+	u8 sta_idx;
+};
+
+/* MAC Secret Key */
+#define MAC_SEC_KEY_LEN 32  /* TKIP keys 256 bits (max length) with MIC keys */
+
+struct mac_sec_key {
+	/* Key material length */
+	u8 length;
+	/* Key material */
+	u32 array[MAC_SEC_KEY_LEN / 4];
+};
+
+enum mac_cipher_suite {
+	MAC_CIPHER_SUITE_NULL,
+	MAC_CIPHER_SUITE_WEP40,
+	MAC_CIPHER_SUITE_TKIP,
+	MAC_CIPHER_SUITE_CCMP,
+	MAC_CIPHER_SUITE_WEP104,
+	MAC_CIPHER_SUITE_GCMP,
+
+	MAC_CIPHER_SUITE_MAX
+};
+
+/* Structure containing the parameters of the MM_KEY_ADD REQ message. */
+struct mm_key_add_req {
+	/* Key index (valid only for default keys) */
+	u8 key_idx;
+	/* STA index (valid only for pairwise keys) */
+	u8 sta_idx;
+	/* Key material */
+	struct mac_sec_key key;
+	/* Cipher suite */
+	u8 cipher_suite;
+	/* Index of the interface for which the key is set (valid only for default keys) */
+	u8 inst_nbr;
+	/* A-MSDU SPP parameter */
+	u8 spp;
+};
+
+/* Structure containing the parameters of the MM_KEY_ADD_CFM message. */
+struct mm_key_add_cfm {
+	/* Status of the operation (different from 0 if unsuccessful) */
+	u8 status;
+	/* HW index of the key just added */
+	u8 hw_key_idx;
+};
+
+/* Structure containing the parameters of the MM_KEY_DEL_REQ message. */
+struct mm_key_del_req {
+	u8 hw_key_idx;
+};
+
+/* Structure containing the parameters of the MM_BA_ADD_REQ message. */
+struct mm_ba_add_req {
+	/* Type of agreement (0: TX, 1: RX) */
+	u8 type;
+	/* Index of peer station with which the agreement is made */
+	u8 sta_idx;
+	/* TID for which the agreement is made with peer station */
+	u8 tid;
+	/* Buffer size - number of MPDUs that can be held in its buffer per TID */
+	__le16 bufsz;
+	/* Start sequence number negotiated during BA setup */
+	__le16 ssn;
+};
+
+/* Structure containing the parameters of the MM_BA_ADD_CFM message. */
+struct mm_ba_add_cfm {
+	/* Index of peer station for which the agreement is being confirmed */
+	u8 sta_idx;
+	/* TID for which the agreement is being confirmed */
+	u8 tid;
+	/* Status of ba establishment */
+	u8 status;
+	/* Aggregation index */
+	u8 agg_idx;
+	/* Number of descriptors the queue of session can hold */
+	u16 desc_cnt;
+};
+
+/* Structure containing the parameters of the MM_BA_DEL_REQ message. */
+struct mm_ba_del_req {
+	/* Index of peer station for which the agreement is being deleted */
+	u8 sta_idx;
+	/* TID for which the agreement is being deleted */
+	u8 tid;
+};
+
+/* Structure containing the parameters of the MM_BA_DEL_CFM message. */
+struct mm_ba_del_cfm {
+	/* Index of peer station for which the agreement deletion is being confirmed */
+	u8 sta_idx;
+	/* TID for which the agreement deletion is being confirmed */
+	u8 tid;
+	/* Status of ba deletion */
+	u8 status;
+};
+
+/* Structure containing the parameters of the MM_AVAILABLE_BA_TXQ_REQ message. */
+struct mm_available_ba_txq_req {
+	/* Index of peer station for which the agreement deletion is being confirmed */
+	u8 sta_idx;
+	/* TID for which the agreement deletion is being confirmed */
+	u8 tid;
+};
+
+/* Structure containing the parameters of the MM_AVAILABLE_BA_TXQ_CFM message. */
+struct mm_available_ba_txq_cfm {
+	/* Index of peer station for which the agreement deletion is being confirmed */
+	u8 sta_idx;
+	/* TID for which the agreement deletion is being confirmed */
+	u8 tid;
+	/* Status if ba txqueue available */
+	u8 status;
+};
+
+struct sounding_info_per_sta {
+	u8 sta_idx;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u8 nc                 : 4, /* [3:0] NC of the STA */
+	   fb_type_ng_cb_size : 3, /* [6:4] */
+	   rsv1               : 1; /* [7] reserved */
+#else
+	u8 rsv1               : 1, /* [7] reserved */
+	   fb_type_ng_cb_size : 3, /* [6:4] */
+	   nc                 : 4; /* [3:0] NC of the STA */
+#endif
+};
+
+/* Information provided by application to firmware */
+struct mm_sounding_req {
+	struct sounding_info_per_sta info_per_sta[CL_MU_MAX_STA_PER_GROUP];
+	__le32 host_address;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+		/* [2:0] sounding type (HE-SU/HE-MU/HE_CQI/VHT-SU/VHT-MU) */
+	u32     sounding_type        : 3,
+		/* [3:6] number of stations in the sounding sequence */
+		sta_num              : 4,
+		/* [7] start/stop sounding sequence */
+		start                : 1,
+		/* [19:8] life expectancy of BFR in ms */
+		lifetime             : 12,
+		/* [31:20] sounding interval. 0 means a single sounding */
+		interval             : 12;
+		/* [1:0] requested bw for the sounding sequence (BFR/NDP) */
+	u8      req_txbw             : 2,
+		/* [5:2] NSTS in the NDP frame */
+		ndp_nsts             : 4,
+		/* [7:6] reserved bits */
+		rsv1                 : 2;
+		/* [3:0] Bitmap of STAs to create SU Q-matrix for */
+	u8      q_matrix_bitmap      : 4,
+		/* [7:4] reserved bits */
+		rsv2                 : 4;
+#else
+		/* [31:20] sounding interval. 0 means a single sounding */
+	u32     interval             : 12,
+		/* [19:8] life expectancy of BFR in ms */
+		lifetime             : 12,
+		/* [7] start/stop sounding sequence */
+		start                : 1,
+		/* [3:6] number of stations in the sounding sequence */
+		sta_num              : 4,
+		/* [2:0] sounding type (HE-SU/HE-MU/HE_CQI/VHT-SU/VHT-MU) */
+		sounding_type        : 3;
+		/* [7:6] reserved bits */
+	u8      rsv1                 : 2,
+		/* [5:2] NSTS in the NDP frame */
+		ndp_nsts             : 4,
+		/* [1:0] requested bw for the sounding sequence (BFR/NDP) */
+		req_txbw             : 2;
+		/* [7:4] reserved bits */
+	u8      rsv2                 : 4,
+		/* [3:0] Bitmap of STAs to create SU Q-matrix for */
+		q_matrix_bitmap      : 4;
+#endif
+	/* Sounding id. Used when deleting a sounding sequence */
+	u8 sid;
+};
+
+/* Application feedback for sounding request */
+struct mm_sounding_cfm {
+	u8 param_err;
+	u8 sounding_id;
+};
+
+struct mm_sounding_pairing {
+	u8 sounding_type;
+	u8 sounding_id;
+	u8 sta_idx;
+	u8 gid;
+};
+
+struct mm_sounding_interval_req {
+	__le16 interval;     /* Sounding interval */
+	__le16 bfr_lifetime; /* Life expectancy of BFR in ms */
+	u8 sounding_type;    /* Type of sounding (VHT/HT/SU/MU) */
+	u8 sta_idx;          /* Sta idx */
+};
+
+struct mm_sounding_interval_cfm {
+	u8 param_err;
+};
+
+/* Structure containing the parameters of the MM_BACKUP_BCN_EN_REQ message */
+struct mm_set_backup_bcn_en_req {
+	/* Backup beacon disable/enable */
+	bool backup_bcn_en;
+};
+
+/* Structure containing the parameters of the MM_START_PERIODIC_TX_TIME_REQ message */
+struct mm_start_periodic_tx_time_req {
+	__le16 periodic_tx_time_off;
+	__le16 periodic_tx_time_on;
+};
+
+enum ANAMON_MODE {
+	ANAMON_MODE_TEMPERATURE,
+	ANAMON_MODE_CHAINS,
+	ANAMON_MODE_SX
+};
+
+/* Structure containing the parameters of the MM_ANAMON_READ_REQ message */
+struct mm_anamon_read_req {
+	u8 mode;   /* 0 - Temperature, 1 - Chains, 2 - SX */
+	u8 param1; /* For mode = 0: 0 - Internal, 1 - External ; For mode = 1/2: Page number */
+	u8 param2; /* For mode = 5 bit value corresponding to mode selection */
+};
+
+struct mm_anamon_read_cfm {
+	u8 retval;
+	__le16 raw_bits_data_0;
+	__le16 raw_bits_data_1;
+};
+
+struct mm_spi_write_req {
+	u8 page;
+	u8 addr;
+	u8 val;
+	u8 mask;
+};
+
+struct mm_spi_read_req {
+	u8 page;
+	u8 addr;
+};
+
+struct mm_spi_read_cfm {
+	u8 status;
+	u8 val;
+};
+
+/* +++++++++++++++++++++++++ Debug messages +++++++++++++++++++++++++ */
+
+/* Messages related to Debug Task */
+enum dbg_msg_tag {
+	/* Set module filter message */
+	DBG_SET_MOD_FILTER_REQ = FIRST_MSG(TASK_DBG),
+	DBG_SET_MOD_FILTER_CFM,
+	/* Set module filter message */
+	DBG_CE_SET_MOD_FILTER_REQ,
+	DBG_CE_SET_MOD_FILTER_CFM,
+	/* Set severity filter message */
+	DBG_SET_SEV_FILTER_REQ,
+	DBG_SET_SEV_FILTER_CFM,
+	/* Get ETH2WLAN statistics message */
+	DBG_GET_E2W_STATS_REQ,
+	DBG_GET_E2W_STATS_CFM,
+	/* Set LA MPIF mask message */
+	DBG_SET_LA_MPIF_MASK_REQ,
+	DBG_SET_LA_MPIF_MASK_CFM,
+	/* Set LA trigger point message */
+	DBG_SET_LA_TRIG_POINT_REQ,
+	DBG_SET_LA_TRIG_POINT_CFM,
+	/* Set LA MPIF debug mode message */
+	DBG_SET_LA_MPIF_DEBUG_MODE_REQ,
+	DBG_SET_LA_MPIF_DEBUG_MODE_CFM,
+	/* Set LA trigger rule message */
+	DBG_SET_LA_TRIG_RULE_REQ,
+	DBG_SET_LA_TRIG_RULE_CFM,
+	/* TX trace dump debug flag message */
+	DBG_TX_TRACE_DEBUG_FLAG_REQ,
+	DBG_TX_TRACE_DEBUG_FLAG_CFM,
+	/* Print statistics message */
+	DBG_PRINT_STATS_REQ,
+	DBG_PRINT_STATS_CFM,
+	/* Trigger the embedded logic analyzer message */
+	DBG_TRIGGER_REQ,
+	DBG_TRIGGER_CFM,
+	/* Test mode message */
+	DBG_TEST_MODE_REQ,
+	DBG_TEST_MODE_CFM,
+	/* Sounding command message */
+	DBG_SOUNDING_CMD_REQ,
+	DBG_SOUNDING_CMD_CFM,
+	/* Presilicon HW testing message */
+	DBG_PRESILICON_TESTING_REQ,
+	DBG_PRESILICON_TESTING_CFM,
+
+	DBG_REQ_CFM_MAX,
+
+	/* Print request */
+	DBG_PRINT_IND = DBG_REQ_CFM_MAX,
+	/* Information indication */
+	DBG_INFO_IND,
+	/* Max number of debug messages */
+	DBG_MAX,
+};
+
+/* Structure containing the parameters of the DBG_SET_MOD_FILTER_REQ message. */
+struct dbg_set_mod_filter_req {
+	/* Bit field indicating for each module if the traces are enabled or not */
+	__le32 mod_filter;
+};
+
+/* Structure containing the parameters of the DBG_SEV_MOD_FILTER_REQ message. */
+struct dbg_set_sev_filter_req {
+	/* Bit field indicating the severity threshold for the traces */
+	__le32 sev_filter;
+};
+
+/* Must be aligned with FW (dbg.h) */
+enum dbg_test_mode {
+	DBG_TEST_MODE_HELP = 0,
+	DBG_TEST_MODE_ASSERT_REC,
+	DBG_TEST_MODE_ERR_CORRECT_MODE,
+	DBG_TEST_MODE_PRESILICON_TESTS,
+	DBG_TEST_MODE_TRIGGER_BA_NOT_RECEIVED,
+	DBG_TEST_MODE_TRIGGER_ABOVE_BAW,
+	DBG_TEST_MODE_TRIGGER_BELOW_BAW,
+	DBG_TEST_MODE_TRIGGER_RETRY_LIMIT_REACHED,
+	DBG_TEST_MODE_DMA_DATA_PRINT,
+	DBG_TEST_MODE_SET_AGC_MEM,
+	DBG_TEST_MODE_FW_TRACE_MODE,
+	DBG_TEST_MODE_TX_POWER_DEBUG,
+	DBG_TEST_MODE_DCOC_IQ_MODE,
+	DBG_TEST_MODE_MACHW_STATE,
+	DBG_TEST_MODE_PHY_GLOBAL_RESET,
+	DBG_TEST_MODE_PHY_OLYMPUS_TXRX_MODE,
+	DBG_TEST_MODE_AFE_LOOPBACK_MODE,
+	DBG_TEST_MODE_MIN_SPACING_MODE,
+	DBG_TEST_MODE_DELAY_CHAIN,
+	DBG_TEST_MODE_ERR_DUMP_PRINT,
+	DBG_TEST_MODE_BW_SIG_PRINT,
+	DBG_TEST_MODE_RECOVER_BA_NOT_RECEIVED,
+	DBG_TEST_MODE_BAP_MODE,
+	DBG_TEST_MODE_DPHY_INJECT_RXERR,
+	DBG_TEST_MODE_RXM_RXVECTOR_PRINT,
+	DBG_TEST_MODE_STOP_CHAIN,
+	DBG_TEST_MODE_MAX_AGG_SIZE,
+	DBG_TEST_MODE_DISABLE_RECOVERY,
+	DBG_TEST_MODE_SET_NAV_DURATION,
+	DBG_TEST_MODE_SET_NAV_CLEAR,
+	DBG_TEST_MODE_DRA_GRP_LIMIT_SET,
+	DBG_TEST_MODE_DURATION_FROM_THD,
+	DBG_TEST_MODE_RIU_INT_EN,
+	DBG_TEST_MODE_MU_OF_1_USER,
+	DBG_TEST_MODE_FORCE_TRIGGER,
+	DBG_TEST_MODE_RECOVERY_DEBUG,
+	DBG_TEST_MODE_CHAIN_SUSPEND,
+	DBG_TEST_MODE_DSP_LCU_TRIG,
+	DBG_TEST_MODE_POWER_SAVE,
+	DBG_TEST_MODE_TRIGGER_RX_NOT_RECEIVED,
+	DBG_TEST_MODE_SNIFFER_MODE,
+	DBG_TEST_MODE_AGC_CAPTURE_NOISE,
+	DBG_TEST_MODE_TRIGGER_UNDERRUN,
+	DBG_TEST_MODE_TF_IN_AMPDU_EN,
+	DBG_TEST_MODE_HOST_FW_QUEUE_WR_RD,
+	DBG_TEST_MODE_TXDESC_DMA_TOKEN_SET,
+	DBG_TEST_MODE_ASSERT_ERR,
+	DBG_TEST_MODE_MAX,
+};
+
+/* Information sent from firmware to host indicating the rx bfr variables */
+struct mm_sounding_ind {
+	/* Param that are application private, collected by host without local copy */
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u8 sounding_type : 3,
+	   status        : 1,
+	   fail_reason   : 4;
+	u8 mu            : 1,
+	   rsv           : 7;
+#else
+	u8 fail_reason   : 4,
+	   status        : 1,
+	   sounding_type : 3;
+	u8 rsv           : 7,
+	   mu            : 1;
+#endif
+	u8 sid;
+	u8 sta_idx;
+	u16 v_matrix_offset[CL_MU_MAX_STA_PER_GROUP];
+};
+
+/* Possible fw errors types */
+enum mm_fw_error_type {
+	MM_FW_ERROR_TYPE_MU_OFDMA_SLOW_SECONDARY,
+	MM_FW_ERROR_TYPE_MAX
+};
+
+/* Structure containing the parameters of the MM_FW_ERROR_IND message */
+struct mm_fw_error_ind {
+	u8 group_id;
+	u8 error_type;
+	u8 sta_inidices[CL_MU_MAX_STA_PER_GROUP];
+	u8 sta_num;
+};
+
+enum mm_agg_rx_status_type {
+	MM_AGG_RX_REPORT_STAT_OK,
+	MM_AGG_RX_REPORT_STAT_COLISION_WITH_COUNTER,
+	MM_AGG_RX_REPORT_STAT_COUNTER_LOST,
+	MM_AGG_RX_REPORT_STAT_NOT_RECEIVED,
+	MM_AGG_RX_REPORT_STAT_NOT_HE
+};
+
+struct mm_agg_rx_ind {
+	u8 sta_num;
+	u8 sta_idx[CL_MU_MAX_STA_PER_GROUP];
+	u8 status[CL_MU_MAX_STA_PER_GROUP];
+	__le16 ampdu_received_counter[CL_MU_MAX_STA_PER_GROUP];
+	__le16 discarded_mpdu_count[CL_MU_MAX_STA_PER_GROUP];
+	__le16 correct_received_mpdu_count[CL_MU_MAX_STA_PER_GROUP];
+	__le16 incorrect_received_mpdu_count[CL_MU_MAX_STA_PER_GROUP];
+	__le16 rx_discarded_mpdu_count[CL_MU_MAX_STA_PER_GROUP];
+	__le16 incorrect_delimiter_count[CL_MU_MAX_STA_PER_GROUP];
+	u8 nss_per_user[CL_MU_MAX_STA_PER_GROUP];
+	u8 mcs_rate[CL_MU_MAX_STA_PER_GROUP];
+	u8 ru_allocation[CL_MU_MAX_STA_PER_GROUP];
+	u8 gi_ltf;
+	u8 rcpi[CL_MU_MAX_STA_PER_GROUP];
+	u8 evm1[CL_MU_MAX_STA_PER_GROUP];
+	u8 evm2[CL_MU_MAX_STA_PER_GROUP];
+	u8 evm3[CL_MU_MAX_STA_PER_GROUP];
+	u8 evm4[CL_MU_MAX_STA_PER_GROUP];
+};
+
+#define MSG_TOTAL_REQ_CFM (MM_REQ_CFM_MAX + DBG_REQ_CFM_MAX)
+#define DBG_STR_SHIFT(id) ((id) - FIRST_MSG(TASK_DBG) + MM_REQ_CFM_MAX)
+#define MSG_ID_STR(id)    (((id) < MM_REQ_CFM_MAX) ? msg2str[id] : msg2str[DBG_STR_SHIFT(id)])
+
+extern const char *const msg2str[MSG_TOTAL_REQ_CFM];
+
+/* Timeout waiting for firmware confirmation */
+#define CL_MSG_CFM_TIMEOUT_MS            400
+#define CL_MSG_CFM_TIMEOUT_JIFFIES       msecs_to_jiffies(CL_MSG_CFM_TIMEOUT_MS)
+
+#define CL_MSG_CFM_TIMEOUT_CALIB_MS      1800
+#define CL_MSG_CFM_TIMEOUT_CALIB_JIFFIES msecs_to_jiffies(CL_MSG_CFM_TIMEOUT_CALIB_MS)
+
+#define CL_MSG_CFM_TIMEOUT_DUMMY_MS      7000
+#define CL_MSG_CFM_TIMEOUT_DUMMY_JIFFIES msecs_to_jiffies(CL_MSG_CFM_TIMEOUT_DUMMY_MS)
+
+#define CL_MSG_CFM_TIMEOUT_FRU_MS        35000
+#define CL_MSG_CFM_TIMEOUT_FRU_JIFFIES   msecs_to_jiffies(CL_MSG_CFM_TIMEOUT_FRU_MS)
+
+#define CFM_CLEAR_BIT(bit, cfm_flags) \
+	clear_bit((bit) & 0x1f, *(cfm_flags) + ((bit) >> 5))
+
+#define CFM_SET_BIT(bit, cfm_flags) \
+	set_bit((bit) & 0x1f, *(cfm_flags) + ((bit) >> 5))
+
+#define CFM_TEST_BIT(bit, cfm_flags) \
+	test_bit((bit) & 0x1f, *(cfm_flags) + ((bit) >> 5))
+
+#define CFM_TEST_AND_CLEAR_BIT(bit, cfm_flags) \
+	test_and_clear_bit((bit) & 0x1f, *(cfm_flags) + ((bit) >> 5))
+
+u16 cl_msg_cfm_set_bit(u16 req);
+int cl_msg_cfm_wait(struct cl_hw *cl_hw, u16 bit, u16 req_id);
+void cl_msg_cfm_assign_and_clear(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg);
+void cl_msg_cfm_clear(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg);
+void cl_msg_rx_tasklet(unsigned long data);
+void cl_msg_rx_flush_all(struct cl_hw *cl_hw);
+
+#define FREQUENCY_INT_MASK 0xfffc
+#define FREQUENCY_FRAC_MASK 0x0003
+#define FREQUENCY_INT_SHIFT 2
+#define FREQUENCY_FRAC_RESOLUTION 25
+
+#define GET_FREQ_INT(freq) (((freq) & FREQUENCY_INT_MASK) >> FREQUENCY_INT_SHIFT)
+#define GET_FREQ_FRAC(freq) (((freq) & FREQUENCY_FRAC_MASK) * FREQUENCY_FRAC_RESOLUTION)
+
+enum ke_kern_tag {
+	KERN_HOST,
+	KERN_LMAC,
+	KERN_UMAC,
+	KERN_SMAC,
+
+	KERN_MAX,
+};
+
+#define SET_CHANNEL_MODE_OPERETIONAL  0x01
+#define SET_CHANNEL_MODE_CALIB_DCOC   0x02
+#define SET_CHANNEL_MODE_CALIB_IQ     0x04
+#define SET_CHANNEL_MODE_CALIB_LOLC   0x08
+#define SET_CHANNEL_MODE_CALIB_MANUAL 0x10
+#define SET_CHANNEL_MODE_CALIB        (SET_CHANNEL_MODE_CALIB_DCOC | \
+				       SET_CHANNEL_MODE_CALIB_IQ | \
+				       SET_CHANNEL_MODE_CALIB_LOLC)
+
+/*
+ * confirmation call back params
+ * @err: general msg transmitting error
+ * @param: pointer to lower layer feedback param (FW layer)
+ */
+struct cl_msg_cfm_cb_param {
+	int err;
+	void *param; /* Pointer to msg cfm param, the caller should be aware to that type */
+};
+
+/*
+ * call back function definition, associate with all backgrounf triggered messages
+ * if caller intersting in message done feedback it must declare function of this type!
+ */
+typedef void (*cl_msg_cfm_cb_func)(struct cl_msg_cfm_cb_param *p_cfm_cb_param, u32 token);
+
+void cl_msg_tx_free_cfm_params(struct cl_hw *cl_hw, u16 id);
+int cl_msg_tx_reset(struct cl_hw *cl_hw);
+int cl_msg_tx_start(struct cl_hw *cl_hw);
+int cl_msg_tx_version(struct cl_hw *cl_hw);
+int cl_msg_tx_add_if(struct cl_hw *cl_hw, struct ieee80211_vif *vif, u8 vif_index);
+int cl_msg_tx_remove_if(struct cl_hw *cl_hw, u8 vif_index);
+int cl_msg_tx_sta_add(struct cl_hw *cl_hw, struct ieee80211_sta *sta, struct cl_vif *cl_vif,
+		      u8 recovery_sta_idx, u32 rate_ctrl_info);
+int cl_msg_tx_sta_del(struct cl_hw *cl_hw, u8 sta_idx);
+int cl_msg_tx_set_filter(struct cl_hw *cl_hw, u32 filter, bool force);
+int cl_msg_tx_set_channel(struct cl_hw *cl_hw, u32 channel, u8 bw, u32 primary, u32 center,
+			  struct cl_calib_params calib_params);
+int cl_msg_tx_dtim(struct cl_hw *cl_hw, u8 dtim_period);
+int cl_msg_tx_set_beacon_int(struct cl_hw *cl_hw, u16 beacon_int, u8 vif_idx);
+int cl_msg_tx_set_basic_rates(struct cl_hw *cl_hw, u32 basic_rates);
+int cl_msg_tx_set_bssid(struct cl_hw *cl_hw, const u8 *bssid, u8 vif_idx);
+int cl_msg_tx_set_edca(struct cl_hw *cl_hw, u8 hw_queue, u32 param,
+		       struct ieee80211_he_mu_edca_param_ac_rec *mu_edca);
+int cl_msg_tx_set_associated(struct cl_hw *cl_hw,
+			     struct ieee80211_bss_conf *bss_conf);
+int cl_msg_tx_set_slottime(struct cl_hw *cl_hw, bool use_short_slot);
+int cl_msg_tx_set_idle(struct cl_hw *cl_hw, u8 idle, bool is_lock);
+void cl_msg_tx_idle_async(struct cl_hw *cl_hw, bool is_lock);
+int cl_msg_tx_key_add(struct cl_hw *cl_hw, struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+		      struct ieee80211_key_conf *key_conf, u8 cipher_suite);
+int cl_msg_tx_key_del(struct cl_hw *cl_hw, u8 hw_key_idx);
+int cl_msg_tx_ba_add(struct cl_hw *cl_hw, u8 type, u8 sta_idx, u16 tid, u16 bufsz, u16 ssn);
+int cl_msg_tx_ba_del(struct cl_hw *cl_hw, u8 sta_idx, u16 tid);
+int cl_msg_tx_available_ba_txq(struct cl_hw *cl_hw, u8 sta_idx, u16 tid);
+int cl_msg_tx_update_rate_dl(struct cl_hw *cl_hw, u8 sta_idx, u32 rate, u32 rate_fallback,
+			     u8 req_bw_tx, u8 op_mode, u8 gid, u8 mu_valid, u8 ltf,
+			     u8 ltf_fallback, u32 rate_he);
+int cl_msg_tx_update_rate_ul(struct cl_hw *cl_hw, u8 sta_idx, u8 bw, u8 nss, u8 mcs, u8 gi_ltf);
+int cl_msg_tx_set_vns(struct cl_hw *cl_hw, u8 sta_idx, u8 is_vns);
+int cl_msg_tx_set_tx_bf(struct cl_hw *cl_hw, u8 sta_idx, u8 is_on, u8 is_on_fallback);
+int cl_msg_tx_sounding(struct cl_hw *cl_hw,
+		       struct mm_sounding_req *sounding_req);
+int cl_msg_tx_sounding_pairing(struct cl_hw *cl_hw, u8 sounding_id, u8 sounding_type,
+			       u8 gid, u8 sta_idx);
+int cl_msg_tx_sounding_interval(struct cl_hw *cl_hw, u16 interval, u16 lifetime,
+				u8 sounding_type, u8 sta_idx);
+int cl_msg_tx_set_dfs(struct cl_hw *cl_hw, bool enable, u8 standard,
+		      u8 initial_gain, u8 agc_cd_th);
+int cl_msg_tx_ndp_tx_control(struct cl_hw *cl_hw, u8 chain_mask, u8 bw, u8 format, u8 num_ltf);
+int cl_msg_tx_reg_write(struct cl_hw *cl_hw, u32 address, u32 value, u32 mask);
+int cl_msg_tx_prot_mode(struct cl_hw *cl_hw, u8 log_nav_en, u8 mode,
+			u8 rate_format, u8 rate_mcs, u8 rate_pre_type);
+int cl_msg_tx_backup_bcn_en(struct cl_hw *cl_hw, bool backup_bcn_en);
+int cl_msg_tx_start_periodic_tx_time(struct cl_hw *cl_hw, u16 periodic_tx_time_off,
+				     u16 periodic_tx_time_on);
+int cl_msg_tx_anamon_read(struct cl_hw *cl_hw, u8 mode, u8 param1, u8 param2);
+int cl_msg_tx_refresh_power(struct cl_hw *cl_hw);
+int cl_msg_tx_set_ant_pwr_offset(struct cl_hw *cl_hw, s8 pwr_offset[MAX_ANTENNAS]);
+int cl_msg_tx_set_rate_fallback(struct cl_hw *cl_hw);
+int cl_msg_tx_spi_write(struct cl_hw *cl_hw, u8 page, u8 addr, u8 val, u8 mask);
+int cl_msg_tx_spi_read(struct cl_hw *cl_hw, u8 page, u8 addr);
+
+/* Debug messages */
+int cl_msg_tx_dbg_set_ce_mod_filter(struct cl_hw *cl_hw, u32 filter);
+int cl_msg_tx_dbg_set_sev_filter(struct cl_hw *cl_hw, u32 filter);
+
+#endif /* CL_FW_H */
-- 
2.36.1

