Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D503AB874
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbhFQQIL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:11 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:19069
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231372AbhFQQHb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrOL4qZKZIlKgUGhs8Jp12yYx60Y2rw0vQOIg15nT/qTr41S3uw7YDvW1RZau1dGyKsfFo7Kj0J0PsOgmc4020e9GVYpK4LSZiJ7Q/fZDs6pjbxorFixthJnDGUJkDdkk1UoiuYfIT7TQh1L+fsELqfmmgDz2HMONtilDUiT7tb9PZu0YoxmfyT9uAd64ky02idY6NOrvebmX5ZfHX6LTt8zsDKJfhcQRfH0ZuS6efUn3fAnNwWucfoJmbjCyDg/+wqzONxqBuSOezpBY9yhnhVAwA0p91Ir/NvTGicP3C8g+8JTdd+8muohdEzwr8bS1N3H/J9TEuN0nB4nJe+F6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRmgInNM2TsHBGCn4xJnWagK5zK8yXn0TaFw1uxtwD8=;
 b=AOyq1ncWRNEEm5cOOJtQV0ujy3hsK4Se1+/NqxzX9NaC4DJ7IL+cHf7ZtbAtCzn9kehyvkpHNyNNkjdx70U9H3G+ANcES36rABowCNyUHnjHDR7ueXIf742LAS6xHiuoJFwJQCdSQnVTUPhbACdUOAfcLmKUNIp/8vmdPvZYfQWtVohRHP7S5dTJ5mjGt2PD8cIeteZ3wkUa67VgjMINDg2GkGPowi8K71tJoNm0eSYOAQPD1lKduRFjiScxplAK9jTj3osCYeikG4F6CKSbeqM/mk2H8nk6VA+Pii9ge2Wj4rXTBlOKSsf2w7uhN+nluKcWilEh/kFnYZqNKYJBtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRmgInNM2TsHBGCn4xJnWagK5zK8yXn0TaFw1uxtwD8=;
 b=tBSi9E4dmGETVy38zrT26ypuOFkoyNBeJQi99gtk1vvLd24glBlkx2ePyn/x3uQFWHUTwb188QMZ2OoJkSt5XM+SDLx5TH3cQ2knwvYwqU/m7RpK5mO1SUhqClB/Bifh0AYox0yfCurJSQiSrlRIwGbPAhn6Kvh4oANLBN4owu4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0887.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:00 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:00 +0000
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
Subject: [RFC v1 091/256] cl8k: add fw/fw_msg.h
Date:   Thu, 17 Jun 2021 15:59:38 +0000
Message-Id: <20210617160223.160998-92-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4c467e3-0b81-4b66-1e3f-08d931a98d3d
X-MS-TrafficTypeDiagnostic: AM9P192MB0887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB088791E4B795E5810347BCD0F60E9@AM9P192MB0887.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:87;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fWBjUXmqcSnGJHBq+wuopwwYcvEnYbyDjFXNos1hgqAbnmwlhPX3XXRFy1q4Db0XDY3ohRvYmVJonfCUndvQ2LJyQLE+QjJrV2rF5CpF6tbK65iqHoKq3njiU9hiG90Y0Y/7EnDPU4IOiCj1cvjl0VqAl1+2kYe3eky+MPPPeYD0xCwqHtnxFP/3ZCe0lSonymxqkPBYZAff7g1lsfmk5mC9gEQfhqVqUwdEu6vdGe/G7933CKW0a63g4l/Sw5ILF9H+FcxvR/1w34eqrt9wb3DcuUZr/eTpKSpRptVM1i1Mp93uQti6v7Bywh47dDTaWBUlsGBZ0bbFdgCUnBjUcEc/QcDBsfWWgHD4nRIdMJfvF+PzptKom6LAI3k3bgm9iaguxYyOvYBYuwBcCMpjCSfMoxep5V/XVwnBRErtOT54kbmW3ZWUwDBQIfCFmReacyCbVL1xHVJwqDeFM9gz4wz9LUMkfHoWEBdCg/E+u+M0FqyrxDXzrZpD81At+AQDfbuhVa0ZO3bJCdEUG7pKL+N8BFL6pHE9rxu+BzjIZBx1ulrr1o4NJk2RrSAZNEZb7iqJobt0sIDzKYJDxJBj2nT+HClKQUivvZLeygmtyGL/Cs4bo6uml1FYllMUMBKtYlnbKloWUkcpJ0yo0QgrZFRBNwijTx6wAjZWxcwEaG/hnOiOM4S82p+HQ2coz6pEJhQTPlWpDs7iXWXx/By7fA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(39850400004)(136003)(346002)(83380400001)(6666004)(38350700002)(4326008)(186003)(16526019)(5660300002)(54906003)(6506007)(26005)(55236004)(38100700002)(316002)(1076003)(107886003)(30864003)(52116002)(8936002)(508600001)(66476007)(66946007)(66556008)(36756003)(6916009)(6486002)(86362001)(2616005)(956004)(2906002)(8676002)(9686003)(6512007)(69590400013)(32563001)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nDsP6TI3GuGUKjYLzk8IaxhnDWyDsBrG8Dh0Q7qnxtn2hwX5OY6lo8/vVJsa?=
 =?us-ascii?Q?VHBuKK1UkpGILgXzBgArRMsTyBFU1LiqrFZc525a/P8YS4raa7aT8JvWX+vA?=
 =?us-ascii?Q?C8TpLX4mJMm1KdR3I+EapI7nayaqHnIukYlt7XGpHqZeisf1GIpK3QulNDK4?=
 =?us-ascii?Q?Yoee6d59yVIs9TsgY7zRCpeU9QcSNBqt+YiDloWWlgKLHhmGwFWP33kcO/pT?=
 =?us-ascii?Q?VDhl5KwbC0KXW3GQsKUtegMK5+mScdNvCf0AFrD5o1pYSdRj9UOL6PfFeOtA?=
 =?us-ascii?Q?SfyNNFm/tbVBevycCmMFeoLAO/JQFTvVcqGCvw36uLKPUuOlbJGZomHKh3gd?=
 =?us-ascii?Q?crXWKXOI1PcoJTtX3mRp2U5LXhFvgLypWOwTngqA0bQotRKZNUTBnJ9FRLX5?=
 =?us-ascii?Q?N3dZdw8iXUFlF7V0dlD69tJbsBxzGCxGGD47+QAjfqxzLbFWG6Ha/pXfgm1q?=
 =?us-ascii?Q?tyTqK85V/IO0d2AcI9rI9K4ka1uVpl/l8LIl4n7FvmN5ZzU8oNhgQSppE1v8?=
 =?us-ascii?Q?OX6WDG9IIBPRQDUknMmElC5KE5krUqFSq2SyQrhE8U51+KqAhtNwgbM13BcC?=
 =?us-ascii?Q?8QG3Xei8kI7ARy5QdlIY/+ZZAN7dzX/dwbF9fD3fBLfT7pNXWpfuFD13OMHA?=
 =?us-ascii?Q?4VirGLfG4VBxIHxk4qCN+GpnkKPR0LBuZFf1TXbkJ0ZkhC7lI+IvmIHLJpHg?=
 =?us-ascii?Q?doLBCvsWoW4YVejrjuQtheZ3/azV7cdpg2H3L6C65P4HpBpswLpFbJUuCbDe?=
 =?us-ascii?Q?Bvork9KRfIImD5nJ6ERbBLJpTOUZrt6DYFsoMKkxbTkVWCJCvhwTJmPqH380?=
 =?us-ascii?Q?QSIb/33zTZ9naVX+aw4d4+7t6GWUPR34MfRZioNCeSGu28xy/+wsvwPX+tRJ?=
 =?us-ascii?Q?fX71Lnnz+Gu68zPkeIk76W8qXrDrSIsGytT6KXh6I4OtDmN1GAjBsiuUcxwU?=
 =?us-ascii?Q?+lPZmWkzNGdWAFh7cvMRHFOP8YtmM0Eaox+E8Ugr2pAGHAandhyBfHUBDlIQ?=
 =?us-ascii?Q?mrNbUH/ah/HAy2oXp2a+1IJvhoQl/zkSgYePp3BU79cGP+q0bcwhCou6OWuz?=
 =?us-ascii?Q?3u/aZ0kJhjZ/pe95jUuqQIXXQBSSMw+ptQhHl3HzDdYN9iWH88T/WlKa0Go5?=
 =?us-ascii?Q?IGAxwEHYaSwrMoExEUreov+TFzQnzHEw/+s68nubeN+EuU+7uoH4//COC0Y1?=
 =?us-ascii?Q?JXgL0kVDaR+Hw4uMtCZE0MopA95ZBw4rG0SBrV4OCcsO5LgjL57TGXU+8KlX?=
 =?us-ascii?Q?8mUN0E/wCcI8XRUrKodKQjSie4mZLe4lq1K0FikDtE+bfjD0D5uS1VBcr6tf?=
 =?us-ascii?Q?9EhoxaVlvmFkHT30PIE8nyia?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c467e3-0b81-4b66-1e3f-08d931a98d3d
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:14.1937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mevbdGI1FbDQdWBTjIJb6tiGKNGJDjKBRZKWD5JDD0gIceBEcPyUSA2HsWnoQOs493hRpakhpS7j8HfxobY8Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0887
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/fw/fw_msg.h | 1656 ++++++++++++++++++
 1 file changed, 1656 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw/fw_msg.h

diff --git a/drivers/net/wireless/celeno/cl8k/fw/fw_msg.h b/drivers/net/wir=
eless/celeno/cl8k/fw/fw_msg.h
new file mode 100644
index 000000000000..fbad729724c9
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/fw/fw_msg.h
@@ -0,0 +1,1656 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_FW_MSG_H
+#define CL_FW_MSG_H
+
+#include <linux/types.h>
+#include "vendor_cmd.h"
+#include "def.h"
+#include "ipc_shared.h"
+#include "wrs/wrs_db.h"
+#include "calib.h"
+#include "fem.h"
+#include "agc_params.h"
+
+#if !defined(__LITTLE_ENDIAN_BITFIELD) && !defined(__BIG_ENDIAN_BITFIELD)
+#error "Please fix <asm/byteorder.h>"
+#endif
+
+#define MSG_SHIFT       7
+#define FIRST_MSG(task) ((task) << MSG_SHIFT)
+
+/* Message structure. */
+struct fw_msg {
+       u16 msg_id;     /* Message ID. */
+       u8 dst_kern_id; /* Destination kernel ID. */
+       u8 dst_task_id; /* Destination task ID. */
+       u8 src_kern_id; /* Source kernel ID. */
+       u8 src_task_id; /* Source task ID. */
+       u16 param_len;  /* Parameter embedded struct length. */
+       u32 param[1];   /* Parameter embedded struct - must be word-aligned=
. */
+};
+
+enum dbg_print {
+       DBG_PRINT_RESET,
+       DBG_PRINT_HELP,
+       DBG_PRINT_TX_STATS,
+       DBG_PRINT_RX_STATS,
+       DBG_PRINT_TXDESC_LIST,
+       DBG_PRINT_AGG_DESC,
+       DBG_PRINT_TX_TRACE_DUMP,
+       DBG_PRINT_TX_RATE_CTRL,
+       DBG_PRINT_FO_CALIB,
+       DBG_PRINT_TX_RETRY,
+       DBG_PRINT_TX_BCN_FLUSH,
+       DBG_PRINT_FW_TRACE,
+       DBG_PRINT_ENHANCED_TIM,
+       DBG_PRINT_TX_DELBA_STATS,
+       DBG_PRINT_RATE_LIMITER,
+       DBG_PRINT_POWER_SAVE_STATS,
+       DBG_PRINT_BF_CTRL_ACTIVE,
+       DBG_PRINT_BF_CTRL_PASSIVE,
+       DBG_PRINT_PERIODIC_TX,
+       DBG_PRINT_MU_GRP_STATS,
+       DBG_PRINT_INT_FRAME_STATS,
+       DBG_PRINT_BMU_STATS,
+       DBG_PRINT_RX_TRACE_DUMP,
+       DBG_PRINT_RD_RW_IDX,
+       DBG_PRINT_OLYMPUS_REG_DUMP,
+       DBG_PRINT_TX_POWER_MEMORY,
+       DBG_PRINT_TX_POWER_MACHW_REGS,
+       DBG_PRINT_TX_POWER_TABLES,
+       DBG_PRINT_DBG_REGS_INFO,
+       DBG_PRINT_RICU_REGS_DUMP,
+       DBG_PRINT_RXM_STATUS,
+       DBG_PRINT_TXM_STATUS,
+       DBG_PRINT_VALID_BITMAP,
+       DBG_PRINT_TRIGGER_FLOW_INFO,
+       DBG_PRINT_LAST
+};
+
+enum {
+       TASK_MM,
+       TASK_DBG,
+       TASK_MAX,
+};
+
+/* List of messages related to the task. */
+enum mm_msg_tag {
+       /* Reset message */
+       MM_RESET_REQ =3D FIRST_MSG(TASK_MM),
+       MM_RESET_CFM,
+       /* Start message */
+       MM_START_REQ,
+       MM_START_CFM,
+       /* Version message */
+       MM_VERSION_REQ,
+       MM_VERSION_CFM,
+       /* Add interface message */
+       MM_ADD_IF_REQ,
+       MM_ADD_IF_CFM,
+       /* Remove interface message */
+       MM_REMOVE_IF_REQ,
+       MM_REMOVE_IF_CFM,
+       /* Station add message */
+       MM_STA_ADD_REQ,
+       MM_STA_ADD_CFM,
+       /* Station del message */
+       MM_STA_DEL_REQ,
+       MM_STA_DEL_CFM,
+       /* Set filter message */
+       MM_SET_FILTER_REQ,
+       MM_SET_FILTER_CFM,
+       /* Set channel message */
+       MM_SET_CHANNEL_REQ,
+       MM_SET_CHANNEL_CFM,
+       /* Set DTIM message */
+       MM_SET_DTIM_REQ,
+       MM_SET_DTIM_CFM,
+       /* Set beacon interval message */
+       MM_SET_BEACON_INT_REQ,
+       MM_SET_BEACON_INT_CFM,
+       /* Set basic rates message */
+       MM_SET_BASIC_RATES_REQ,
+       MM_SET_BASIC_RATES_CFM,
+       /* Set BSSID message */
+       MM_SET_BSSID_REQ,
+       MM_SET_BSSID_CFM,
+       /* Set EDCA message */
+       MM_SET_EDCA_REQ,
+       MM_SET_EDCA_CFM,
+       /* Set associated message */
+       MM_SET_ASSOCIATED_REQ,
+       MM_SET_ASSOCIATED_CFM,
+       /* Set slot time message */
+       MM_SET_SLOTTIME_REQ,
+       MM_SET_SLOTTIME_CFM,
+       /* Set idle message */
+       MM_SET_IDLE_REQ,
+       MM_SET_IDLE_CFM,
+       /* Key add message */
+       MM_KEY_ADD_REQ,
+       MM_KEY_ADD_CFM,
+       /* Key delete message */
+       MM_KEY_DEL_REQ,
+       MM_KEY_DEL_CFM,
+       /* Block ack add TX message */
+       MM_BA_ADD_TX_REQ,
+       MM_BA_ADD_TX_CFM,
+       /* Block ack add RX message */
+       MM_BA_ADD_RX_REQ,
+       MM_BA_ADD_RX_CFM,
+       /* Block ack delete message */
+       MM_BA_DEL_REQ,
+       MM_BA_DEL_CFM,
+       /* PHY reset message */
+       MM_PHY_RESET_REQ,
+       MM_PHY_RESET_CFM,
+       /* Available BA TX queue message */
+       MM_AVAILABLE_BA_TXQ_REQ,
+       MM_AVAILABLE_BA_TXQ_CFM,
+       /* Update rate DL message */
+       MM_UPDATE_RATE_DL_REQ,
+       MM_UPDATE_RATE_DL_CFM,
+       /* Set VNS message */
+       MM_SET_VNS_REQ,
+       MM_SET_VNS_CFM,
+       /* Set TX BF message */
+       MM_SET_TX_BF_REQ,
+       MM_SET_TX_BF_CFM,
+       /* Sounding message */
+       MM_SOUNDING_REQ,
+       MM_SOUNDING_CFM,
+       // Sounding pairing message
+       MM_SOUNDING_PAIRING_REQ,
+       MM_SOUNDING_PAIRING_CFM,
+       /* Sounding interval message */
+       MM_SOUNDING_INTERVAL_REQ,
+       MM_SOUNDING_INTERVAL_CFM,
+       /* Sounding station switch message */
+       MM_SOUNDING_STA_SWITCH_REQ,
+       MM_SOUNDING_STA_SWITCH_CFM,
+       /* Configure CCA message */
+       MM_CONFIG_CCA_REQ,
+       MM_CONFIG_CCA_CFM,
+       /* Set DFS message */
+       MM_SET_DFS_REQ,
+       MM_SET_DFS_CFM,
+       /* Set antenna bitmap message */
+       MM_SET_ANT_BITMAP_REQ,
+       MM_SET_ANT_BITMAP_CFM,
+       /* Set NDP TX control message */
+       MM_NDP_TX_CONTROL_REQ,
+       MM_NDP_TX_CONTROL_CFM,
+       /* Register write message */
+       MM_REG_WRITE_REQ,
+       MM_REG_WRITE_CFM,
+       /* Protection mode message */
+       MM_PROT_MODE_REQ,
+       MM_PROT_MODE_CFM,
+       /* Goto power reduction message */
+       MM_GOTO_POWER_REDUCTION_REQ,
+       MM_GOTO_POWER_REDUCTION_CFM,
+       /* Backup beacon enable message */
+       MM_BACKUP_BCN_EN_REQ,
+       MM_BACKUP_BCN_EN_CFM,
+       /* Start periodic TX time message */
+       MM_START_PERIODIC_TX_TIME_REQ,
+       MM_START_PERIODIC_TX_TIME_CFM,
+       /* Anamon read message */
+       MM_ANAMON_READ_REQ,
+       MM_ANAMON_READ_CFM,
+       /* Refresh power message */
+       MM_REFRESH_PWR_REQ,
+       MM_REFRESH_PWR_CFM,
+       /* Set antenna power offset message */
+       MM_SET_ANT_PWR_OFFSET_REQ,
+       MM_SET_ANT_PWR_OFFSET_CFM,
+       /* Set rate fallback message */
+       MM_SET_RATE_FALLBACK_REQ,
+       MM_SET_RATE_FALLBACK_CFM,
+       /* TWT setup message */
+       MM_TWT_SETUP_REQ,
+       MM_TWT_SETUP_CFM,
+       /* TWT teardown message */
+       MM_TWT_TEARDOWN_REQ,
+       MM_TWT_TEARDOWN_CFM,
+       /* FW resource management message */
+       MM_RSRC_MGMT_REQ,
+       MM_RSRC_MGMT_CFM,
+       /* Set frequency offset message */
+       MM_SET_FREQ_OFFSET_REQ,
+       MM_SET_FREQ_OFFSET_CFM,
+
+       MM_REQ_CFM_MAX,
+
+       /* ############### Firmware internal messages   ############### */
+       /* Periodic task - reset ADC / DAC modules. */
+       MM_ADC_DAC_PERIODIC_TIMER =3D MM_REQ_CFM_MAX,
+       /* Dynamic calibration config */
+       MM_DYNAMIC_CALIBRATION_CONFIG,
+       /* Set AGC values. */
+       MM_SET_AGC_VALS,
+       /* MU-EDCA Timer interrupt message */
+       MM_MU_EDCA_TIMER,
+       /* TWT Timer interrupt message */
+       MM_TWT_TIMER,
+
+       /* ############### Firmware indication messages   ############### *=
/
+       /* Start of indication messages */
+       MM_FIRST_IND,
+       /* TX aggregation indication from FW */
+       MM_AGG_TX_REPORT_IND =3D MM_FIRST_IND,
+       /* Indication for BF sounding */
+       MM_SOUNDING_IND,
+       /* Indication of fw error */
+       MM_FW_ERROR_IND,
+       /* Async indication that MAC is in idle */
+       MM_IDLE_ASYNC_IND,
+       /* Intidcation of FW resource management decision */
+       MM_RSRC_MGMT_IND,
+
+       /* MAX number of messages */
+       MM_MAX,
+};
+
+/* Firmware resource enums types (for the API sanity) */
+enum mm_rsrc_mgmt_sanity {
+       MM_RSRC_MGMT_SANITY_FIRST,
+
+       MM_RSRC_MGMT_SANITY_SELF =3D MM_RSRC_MGMT_SANITY_FIRST,
+       MM_RSRC_MGMT_SANITY_SUBTYPES,
+       MM_RSRC_MGMT_SANITY_ACTION_HINTS,
+       MM_RSRC_MGMT_SANITY_CONTROL_OF,
+
+       MM_RSRC_MGMT_SANITY_MAX
+};
+
+/* Firmware resource hints types */
+enum mm_rsrc_mgmt_subtype {
+       /* DRV -> FW, REQ (with CFM) */
+       MM_RSRC_MGMT_FIRST,
+
+       MM_RSRC_MGMT_API_SANITY =3D MM_RSRC_MGMT_FIRST,
+       MM_RSRC_MGMT_TRAFFIC_START,
+       MM_RSRC_MGMT_TRAFFIC_STOP,
+       MM_RSRC_MGMT_RATES_UPDATE,
+       MM_RSRC_MGMT_CECLI_HINT,
+
+       /* DRV <- FW, IND */
+       MM_RSRC_MGMT_ACTION_HINT,
+       MM_RSRC_MGMT_ENV_CHANGE,
+       MM_RSRC_MGMT_STATS,
+       MM_RSRC_MGMT_CONFIG_QUERY,
+       MM_RSRC_MGMT_NOTIF_POLICY_SET,
+
+       MM_RSRC_MGMT_MAX
+};
+
+enum mm_rsrc_mgmt_action_hint {
+       MM_RSRC_MGMT_ACTION_FIRST,
+
+       MM_RSRC_MGMT_ACTION_ENABLE =3D MM_RSRC_MGMT_ACTION_FIRST,
+       MM_RSRC_MGMT_ACTION_DISABLE,
+       MM_RSRC_MGMT_ACTION_RESTORE_DEFAULT,
+       MM_RSRC_MGMT_ACTION_SET,
+       MM_RSRC_MGMT_ACTION_GET,
+
+       MM_RSRC_MGMT_ACTION_MAX
+};
+
+enum mm_rsrc_mgmt_control_of {
+       MM_RSRC_MGMT_OF_FIRST,
+
+       MM_RSRC_MGMT_OF_TX_AMSDU =3D MM_RSRC_MGMT_OF_FIRST,
+       MM_RSRC_MGMT_OF_RX_AMSDU,
+       MM_RSRC_MGMT_OF_PROT_MODE,
+       MM_RSRC_MGMT_OF_CCA,
+
+       MM_RSRC_MGMT_OF_MAX
+};
+
+struct mm_rsrc_mgmt_active_sta {
+       u8 idx;
+       struct {
+               u8 bw;
+               u8 nss;
+               u8 mcs;
+       } su_rate, max_rate;
+};
+
+struct mm_rsrc_mgmt_notif_policy {
+       bool enabled;
+       u8 level_mask;
+       u8 direction_mask;
+       struct {
+               s8 low_th;
+               s8 high_th;
+       } active_sta;
+};
+
+struct mm_rsrc_mgmt_cecli {
+       __le32 num_params;
+       __le32 mode;
+       char option;
+       u8 len;
+       __le32 params[0];
+};
+
+struct mm_rsrc_mgmt_req {
+       u8 subtype;
+       union {
+               struct {
+                       u8 enum_type;
+                       __le32 enum_max;
+                       __le32 index;
+                       u8 len;
+                       char descr[0];
+               } api_sanity;
+               struct {
+                       u8 level;
+                       u8 direction;
+                       struct {
+                               u8 cnt;
+                               struct mm_rsrc_mgmt_active_sta list[0];
+                       } active_sta;
+               } traffic_event;
+               struct {
+                       struct mm_rsrc_mgmt_active_sta sta;
+               } rate_event;
+               struct mm_rsrc_mgmt_cecli cecli_event;
+       } u;
+};
+
+struct mm_rsrc_mgmt_cfm {
+       u8 subtype;
+       s8 status;
+};
+
+struct mm_rsrc_mgmt_ind {
+       u8 subtype;
+       union {
+               struct {
+                       __le16 target;
+                       u8 action;
+                       u8 data[0];
+               } action_hint;
+               struct {
+                       u8 state;
+               } env_event;
+               struct {
+                       __le16 target;
+               } cfg_query;
+               struct {
+                       __le32 stub;
+               } stats;
+               struct {
+                       u8 subtype;
+                       struct mm_rsrc_mgmt_notif_policy settings;
+               } notif_policy_set;
+       } u;
+};
+
+/* Interface types */
+enum {
+       MM_STA,
+       MM_IBSS,
+       MM_AP,
+       MM_MONITOR,
+       MM_MESH_POINT,
+};
+
+/* BA agreement types */
+enum {
+       /* BlockAck agreement for TX */
+       BA_AGMT_TX,
+       /* BlockAck agreement for RX */
+       BA_AGMT_RX,
+};
+
+/* BA agreement related status */
+enum {
+       BA_AGMT_ESTABLISHED,
+       BA_AGMT_ALREADY_EXISTS,
+       BA_AGMT_DELETED,
+       BA_AGMT_DOES_NOT_EXIST,
+       BA_AGMT_NOT_ESTABLISHED,
+};
+
+/* MM_BA_TXQUEUE request / confirm related status */
+enum {
+       BA_TXQUEUE_INVALID,
+       BA_TXQUEUE_VALID,
+};
+
+/* MAC address structure. */
+struct mac_addr {
+       /* Array of bytes that make up the MAC address. */
+       u8 array[ETH_ALEN];
+};
+
+#define PWR_TBL_HE_BF_SIZE  (WRS_SS_MAX + 1)
+#define PWR_TBL_VHT_BF_SIZE WRS_SS_MAX
+
+/* DCOC/IQ Calibration related defines */
+#define CALIB_SUCCESS 0x00
+#define CALIB_FAIL    0x01
+
+/*
+ * Structure containing the power tables
+ * All values are in resolution of 0.5dBm
+ */
+struct cl_pwr_tables {
+       /* Regular Tx */
+       s8 ant_pwr_he[CHNL_BW_MAX][WRS_MCS_MAX_HE][PWR_TBL_HE_BF_SIZE];
+       s8 ant_pwr_ht_vht[CHNL_BW_MAX][WRS_MCS_MAX_VHT][PWR_TBL_VHT_BF_SIZE=
];
+       s8 ant_pwr_ofdm[WRS_MCS_MAX_OFDM];
+       s8 ant_pwr_cck[WRS_MCS_MAX_CCK];
+       /* VNS */
+       s8 ant_pwr_vns_he;
+       s8 ant_pwr_vns_ht_vht;
+       s8 ant_pwr_vns_ofdm;
+       s8 ant_pwr_vns_cck;
+       /* Auto response */
+       s8 pwr_auto_resp_he[WRS_MCS_MAX_HE];
+       s8 pwr_auto_resp_ht_vht[WRS_MCS_MAX_VHT];
+       s8 pwr_auto_resp_ofdm[WRS_MCS_MAX_OFDM];
+       s8 pwr_auto_resp_cck[WRS_MCS_MAX_CCK];
+       /* Auto response VNS */
+       s8 pwr_auto_resp_vns_he;
+       s8 pwr_auto_resp_vns_ht_vht;
+       s8 pwr_auto_resp_vns_ofdm;
+       s8 pwr_auto_resp_vns_cck;
+};
+
+struct cl_phy_data {
+       struct cl_pwr_tables pwr_tables;
+       struct cl_iq_dcoc_info iq_dcoc_db;
+       struct cl_agc_params agc_params;
+};
+
+struct reg_offset_val {
+       __le16 addr_offset;
+       __le32 val;
+};
+
+struct cl_antenna_config {
+       /* Number of antennas */
+       u8 num_tx_he;
+       u8 num_tx_ofdm_ht_vht;
+       u8 num_rx;
+       /* Mask of antennas */
+       u8 mask_tx_he;
+       u8 mask_tx_ofdm_ht_vht;
+       u8 mask_rx;
+       /* CCK mask */
+       u8 mask_tx_cck;
+       u8 mask_rx_cck;
+       /* CDB_mask 0x0 -> SX0 chain. 0x1-> SX1 chain. */
+       u8 cdb_mask;
+};
+
+struct cl_fem_config {
+       u32 reg[FEM_REGISTERS_AMOUNT];
+};
+
+struct cl_cca_config {
+       u8 ed_rise_thr_dbm;
+       u8 ed_fall_thr_dbm;
+       u8 cs_en;
+       u8 modem_en;
+       u8 main_ant;
+       u8 second_ant;
+       u8 flag0_ctrl;
+       u8 flag1_ctrl;
+       u8 flag2_ctrl;
+       u8 flag3_ctrl;
+       u8 gi_rise_thr_dbm;
+       u8 gi_fall_thr_dbm;
+       u8 gi_pow_lim_dbm;
+       u16 ed_en;
+       u8 gi_en;
+};
+
+/* Structure containing the parameters of the PHY configuration */
+struct cl_phy_cfg {
+       struct cl_cca_config cca_config;
+       struct cl_antenna_config ant_config;
+       struct cl_fem_config fem_conf;
+       u8 first_start;
+       u8 channel_bandwidth;
+       u8 band; /* 0 =3D 2.4g / 1 =3D 5g / 2 =3D 6g */
+       u16 freq_offset;
+       u8 rx_sensitivity[MAX_ANTENNAS];
+       u8 vns_tx_power_mode;
+       u8 vns_rssi_suto_resp_th;
+       u8 afe_config_en;
+       u8 no_capture_noise_sleep;
+       u8 ht_rxldpc_en;
+       u8 gain_update_enable;
+       u8 mcs_sig_b;
+       u8 ofdm_only;
+       u8 hr_factor;
+       u8 td_csd_en;
+       u8 pe_duration_bcast;
+       u32 tx_digital_gain;
+       u32 tx_digital_gain_cck;
+       u8 ofdm_cck_power_offset;
+       u8 phy_clk_gating_en;
+       u8 tcv1_chains_sx0;
+};
+
+enum {
+       CENX_CFG_DEBUG_PRINT,
+       CENX_CFG_INT_FRAME,
+       CENX_CFG_CE_TX_CFM,
+       CENX_CFG_LMAC_SEQNUM,
+       CENX_CFG_DBG_COUNTERS,
+       CENX_CFG_RHD_LL_SPLIT,
+       CENX_CFG_RX_HDR_SPLIT,
+       CENX_CFG_CYC_BUF,
+       CENX_CFG_DEBUG_TRACE,
+       CENX_RX_CLASSIFICATION,
+       CENX_RX_IMP_BF,
+       CENX_CSI_SUPPORT,
+       CENX_NATT_DBG,
+       CENX_GRP_MGMT_FRAME,
+       CENX_GRP_MGMT_FRAME_RX,
+       CENX_MU_GROUP,
+       CENX_CFG_MAX
+};
+
+#define IPC_TXQ_CNT  5
+
+/* MM_START_REQ parameters */
+struct cl_start_param {
+       __le32 comp_flags;
+       __le16 cfm_size;
+       __le32 cfm_dma_base_addr;
+       __le16 phy_dev;
+       __le16 fw_scale_down;
+       __le16 dbg_test_mode_max;
+       struct {
+               __le32 idle;
+               __le32 ac0;
+               __le32 ac1;
+               __le32 ac2;
+               __le32 ac3;
+               __le32 bcn;
+       } hal_timeout;
+       /*
+        * this is the pointer to the dma base address of the host struct
+        * that hold all the dma addresses of the ipc host queues
+        */
+       __le32 ipc_host_tx_queues_dma_addr;
+       /* Address of RX buffer in host RAM */
+       __le32 host_rxbuf_base_addr[CL_RX_BUF_MAX];
+       /* Address of HOST indices */
+       __le32 ipc_ring_indices_base;
+       u8 prot_log_nav_en;
+       u8 prot_mode;
+       u8 prot_rate_format;
+       u8 prot_rate_mcs;
+       u8 prot_rate_pre_type;
+       u8 bw_signaling_mode;
+       u8 mult_ampdu_in_txop_en;
+       u8 preemptive_backoff_en;
+       __le32 cca_timeout;
+       u8 short_retry_limit;
+       u8 long_retry_limit;
+       u8 assoc_auth_retry_limit;
+       __le16 bcn_tx_path_min_time;
+       u8 backup_bcn_en;
+       u8 tx_txop_cut_en;
+       u8 ps_ctrl_enabled;
+       u8 ac_with_bcns_flushed_cnt_thr;
+       __le32 txl_statistics_struct_size;
+       __le32 rxl_statistics_struct_size;
+       struct dbg_meta_data dbg_metadata;
+       u8 phy_err_prevents_phy_dump;
+       u8 tx_rx_delay;
+       u8 assert_storm_detect_thd;
+       u8 assert_time_diff_sec;
+       __le16 ipc_rxbuf_size[CL_RX_BUF_MAX];
+       __le32 ipc_rxbuf_extra_headroom;
+       u8 host_pci_gen_ver;
+       u8 dma_lli_max_chan[2];
+       u8 production_mode;
+       u8 bw_factor_q2[CHNL_BW_MAX];
+       u8 ant_factor_q2[MAX_ANTENNAS];
+       u8 min_ant_pwr_q1;
+       struct {
+               u8 auto_resp_all  : 2;
+               u8 auto_resp_msta : 2;
+               u8 rsv            : 4;
+       } default_distance;
+       __le32 phy_data_dma_addr;
+       __le32 phy_remote_rom_dma_addr;
+       __le32 iq_dcoc_calib_tables_dma_addr;
+       __le32 power_table_dma_addr;
+       __le32 tf_info_dma_addr;
+       u8 su_force_min_spacing_usec;
+       u8 mu_force_min_spacing_usec;
+       u8 force_tcv0_only;
+       u8 rx_padding;
+       u8 bar_cap_disable;
+       u8 hw_bsr;
+       u8 drop_to_lower_bw;
+       u8 dra_enable;
+       u8 mac_clk_gating_en;
+       u8 imaging_blocker;
+       u8 fec_coding;
+       u8 cs_required;
+       u8 first_tcv;
+};
+
+struct cl_tx_params {
+       __le32 rate;
+       __le32 rate_he;
+       u8 req_bw_tx;
+       u8 ant_set;
+       u8 ltf;
+};
+
+struct cl_rx_params {
+       u8 format;
+       u8 mcs;
+       u8 nss;
+};
+
+struct mm_update_rate_dl_req {
+       u8 op_mode;
+       u8 sta_idx;
+       u8 mu_is_rate_valid;
+       u8 group_id;
+       struct cl_tx_params tx_params;
+       __le32 rate_fallback;
+       u8 ltf_fallback;
+};
+
+struct mm_set_ant_pwr_offset_req {
+       /* Power offset (0.25dB resoultion) */
+       u8 pwr_offset[MAX_ANTENNAS];
+};
+
+struct mm_rate_fallback_req {
+       u8 fallback_count_su;
+       u8 fallback_count_mu;
+       u8 ba_per_thr;
+       u8 ba_not_received_thr;
+       u8 retry_count_thr;
+       u8 disable_mcs0;
+};
+
+struct mm_set_vns_req {
+       u8 sta_idx;
+       u8 is_vns;
+};
+
+struct mm_set_tx_bf_req {
+       u8 sta_idx;
+       u8 is_on;
+       u8 is_on_fallback;
+};
+
+/* Structure containing the parameters of the MM_START_REQ message */
+struct mm_start_req {
+       /* PHY configuration */
+       struct cl_phy_cfg phy_cfg;
+       /* Other start parameters */
+       struct cl_start_param param;
+};
+
+struct mm_mac_api_lut_line {
+       __le16 frequency_q2;
+       union {
+               struct {
+                       struct {
+                               u8 vcocalsel;
+                               u8 nint;
+                               __le32 nfrac;
+                               __le32 freqmeastarg;
+                       } xco_40M;
+                       struct {
+                               u8 vcocalsel;
+                               u8 nint;
+                               __le32 nfrac;
+                               __le32 freqmeastarg;
+                       } xco_60M;
+               } olympus_2_lines;
+               struct {
+                       struct {
+                               u8 vcocalsel;
+                               u8 nint;
+                               __le32 nfrac;
+                               __le32 freqmeastarg;
+                       } xco_40M;
+                       struct {
+                               u8 vcocalsel;
+                               u8 nint;
+                               __le32 nfrac;
+                               __le32 freqmeastarg;
+                       } xco_60M_s0;
+                       struct {
+                               u8 vcocalsel;
+                               u8 nint;
+                               __le32 nfrac;
+                               __le32 freqmeastarg;
+                       } xco_60M_s1;
+               } olympus_3_lines;
+       } rfic_specific;
+};
+
+struct cl_calib_other_tcv {
+       /* Parameters for calibration */
+       __le16 prim20_freq;
+       struct mm_mac_api_lut_line center1_freq_lut;
+       /* Parameter to restore previous configuration of other TCV */
+       u8 mask_tx_he;
+       u8 num_tx_he;
+       u8 band;
+};
+
+struct cl_calib_conf {
+       u8 initial_rx_gain;
+       u8 initial_tx_gain;
+       u8 rx_gain_upper_limit;
+       u8 rx_gain_lower_limit;
+       __le16 nco_freq;
+       s8 nco_amp;
+       u8 sleeve_trshld;
+       u8 n_samples_exp_lolc;
+       u8 n_samples_exp_iqc;
+       __le32 p_thresh;
+       u8 n_bit_fir_scale;
+       u8 n_bit_amp_scale;
+       u8 n_bit_phase_scale;
+       __le16 tone_vector[IQ_NUM_TONES_REQ];
+       __le32 gp_rad_trshld;
+       __le32 ga_lin_upper_trshld;
+       __le32 ga_lin_lower_trshld;
+       u8 comp_filter_len;
+       u8 singletons_num;
+       u8 tones_num;
+       __le16 rampup_time;
+       __le16 lo_coarse_step;
+       __le16 lo_fine_step;
+};
+
+struct cl_calib_param {
+       u8 mode;
+       u8 dcoc_max_vga;
+       u8 ant_tx_pairs[MAX_ANTENNAS];
+       u8 ant_rx_pairs[MAX_ANTENNAS];
+       struct cl_calib_conf conf;
+       struct cl_calib_other_tcv other_tcv;
+};
+
+/* Structure containing the parameters of the MM_SET_CHANNEL_REQ message *=
/
+struct mm_set_channel_req {
+       /* Band (2.4GHz or 5GHz) */
+       u8 band;
+       /* Channel type: 20,40,80 or 160 MHz */
+       u8 bandwidth;
+       /* Frequency for Primary 20MHz channel (in MHz) */
+       __le16 prim20_freq;
+       /* Frequency for Center of the contiguous channel or center of Prim=
ary 80+80 */
+       struct mm_mac_api_lut_line center1_freq_lut;
+       /* Antenna configuration */
+       struct cl_antenna_config ant_config;
+       /* FEM configuration */
+       struct cl_fem_config fem_conf;
+       u8 calib_info_set;
+       /* Calibration configuration */
+       struct cl_calib_param calib_param;
+       /* Antenna power offset */
+       u8 ant_pwr_offset[MAX_ANTENNAS];
+       /*
+        * Frequency offset in MHz between current synthesizer's center cha=
nnel,
+        * and the other synthesizer's channel.
+        * Needed for LOLC and IQC Calibration. Otherwise, shouldn't be use=
d.
+        */
+       s8 sx_freq_offset_mhz;
+       /* Hr factor */
+       u8 hr_factor;
+       /* Signal extension enable (for 2.4G sifs10 mode), should be 1 for =
2,4 band by default */
+       u8 signal_ext;
+};
+
+enum mm_ext_calib_command {
+       MM_EXT_CALIB_CMD_INIT_SX,
+       MM_EXT_CALIB_CMD_SET_CHANNEL,
+       MM_EXT_CALIB_CMD_INIT_AND_SET_CHANNEL,
+       MM_EXT_CALIB_CMD_MAX
+};
+
+struct mm_ext_calib_init_sx_req {
+       u8 band;
+       u8 cdb_mask;
+       u8 mask_tx_he;
+       u8 num_tx_he;
+       u8 sx_idx;
+};
+
+struct mm_ext_calib_set_channel_req {
+       u8 band;
+       u8 bandwidth;
+       __le16 prim20_freq;
+       struct mm_mac_api_lut_line center1_freq_lut;
+       u8 sx_idx;
+};
+
+struct mm_ext_calib_init_and_set_req {
+       u8 band;
+       u8 cdb_mask;
+       u8 bandwidth;
+       __le16 prim20_freq;
+       struct mm_mac_api_lut_line center1_freq_lut;
+       __le16 remote_prim20_freq;
+       struct mm_mac_api_lut_line remote_center1_freq_lut;
+};
+
+union mm_ext_calib_cmd_req {
+       struct mm_ext_calib_init_sx_req init_sx;
+       struct mm_ext_calib_set_channel_req set_channel;
+       struct mm_ext_calib_init_and_set_req init_and_set;
+};
+
+struct mm_ext_calib_req {
+       u8 cmd;
+       union mm_ext_calib_cmd_req u;
+};
+
+/* Structure containing the parameters of the MM_GOTO_POWER_REDUCTION_REQ =
message */
+struct mm_goto_power_reduction_req {
+       u8 goto_power_reduction_mode;
+};
+
+/* Structure containing the parameters of the MM_FREQ_UPDATE_REQ message *=
/
+struct mm_freq_update_req {
+       u16 freq;
+};
+
+/* Structure containing the parameters of the MM_SET_DTIM_REQ message */
+struct mm_set_dtim_req {
+       u8 dtim_period;
+};
+
+/* Structure containing the parameters of the MM_SET_BEACON_INT_REQ messag=
e */
+struct mm_set_beacon_int_req {
+       __le16 beacon_int;
+       /* Index of the interface */
+       u8 inst_nbr;
+};
+
+/* Structure containing the parameters of the MM_SET_BASIC_RATES_REQ messa=
ge */
+struct mm_set_basic_rates_req {
+       /* Basic rate set (as expected by bssBasicRateSet field of Rates MA=
C HW register) */
+       __le32 rates;
+};
+
+/* Structure containing the parameters of the MM_SET_BSSID_REQ message */
+struct mm_set_bssid_req {
+       /* BSSID to be configured in HW */
+       struct mac_addr bssid;
+       /* Index of the interface for which the parameter is configured */
+       u8 inst_nbr;
+};
+
+/* Structure containing the parameters of the MM_SET_FILTER_REQ message */
+struct mm_set_filter_req {
+       __le32 filter;
+};
+
+/* Structure containing the parameters of the MM_ADD_IF_REQ message. */
+struct mm_add_if_req {
+       u8 type;
+       struct mac_addr addr;
+       u8 inst_nbr;
+       u8 tx_strip_vlan;
+       u8 rx_push_vlan;
+       __le32 rx_push_vlan_tag;
+       __le32 rx_filter_monitor_mask;
+       __le32 mac_addr_hi_mask;
+       __le32 mac_addr_low_mask;
+       u8 start_dtim_count;
+       u8 mbssid_mode;
+};
+
+/* Structure containing the parameters of the MM_SET_EDCA_REQ message */
+struct mm_set_edca_req {
+       __le32 ac_param;
+       u8 hw_queue;
+       u8 mu_edca_aifsn;
+       u8 mu_edca_ecw_min_max;
+       u8 mu_edca_timer;
+};
+
+struct mm_config_cca_req {
+       u8 enable;
+};
+
+struct mm_set_dfs_req {
+       bool enable;
+       bool standard_fcc;
+       u8 initial_gain;
+       u8 agc_cd_th;
+};
+
+struct mm_set_ant_bitmap_req {
+       struct cl_antenna_config ant_config;
+};
+
+struct mm_ndp_tx_control_req {
+       u8 chain_mask;
+       u8 bw;
+       u8 format;
+       u8 num_ltf;
+};
+
+struct mm_reg_write_req {
+       __le32 address;
+       __le32 value;
+       __le32 mask;
+};
+
+struct mm_prot_mode_req {
+       u8 log_nav_en;
+       u8 mode;
+       u8 rate_format;
+       u8 rate_mcs;
+       u8 rate_pre_type;
+};
+
+struct mm_bw_signaling_mode_req {
+       u8 mode;
+};
+
+enum mac_idle_cmd {
+       MAC_ACTIVE =3D 0,
+       MAC_IDLE_SYNC,
+       MAC_IDLE_ASYNC
+};
+
+struct mm_set_idle_req {
+       u8 hw_idle;
+};
+
+/* Structure containing the parameters of the MM_SET_SLOTTIME_REQ message =
*/
+struct mm_set_slottime_req {
+       /* Slot time expressed in us */
+       u8 slottime;
+};
+
+/* Structure containing the parameters of the MM_SET_ASSOCIATED_REQ messag=
e */
+struct mm_set_associated_req {
+       /* Association Id received from the AP */
+       __le16 aid;
+       /* Mask address high - [47:32] */
+       __le32 bssid_hi_mask;
+       /* Mask address low - [31:0] */
+       __le32 bssid_low_mask;
+};
+
+/* Structure containing the parameters of the MM_ADD_IF_CFM message. */
+struct mm_add_if_cfm {
+       /* Status of operation (different from 0 if unsuccessful) */
+       u8 status;
+};
+
+/* Structure containing the parameters of the MM_REMOVE_IF_REQ message. */
+struct mm_remove_if_req {
+       /* Interface index assigned by the firmware */
+       u8 inst_nbr;
+};
+
+/* Structure containing the parameters of the MM_VERSION_CFM message. */
+struct mm_version_cfm {
+       struct {
+               __le32 dsp;
+               __le32 rfic_sw;
+               __le32 rfic_hw;
+               __le32 agcram;
+               char fw[CL_VERSION_STR_SIZE];
+       } versions;
+       u8 rf_crystal_mhz;
+};
+
+/* Structure containing the parameters of the MM_STA_ADD_REQ message. */
+struct mm_sta_add_req {
+       /* Exponent for calculating HE Maximum A-MPDU size */
+       u8 ampdu_size_exp_he;
+       /* Exponent for calculating VHT Maximum A-MPDU size */
+       u8 ampdu_size_exp_vht;
+       /* Exponent for calculating HT Maximum A-MPDU size */
+       u8 ampdu_size_exp_ht;
+       /* MAC address of the station to be added */
+       struct mac_addr mac_addr;
+       /* A-MPDU spacing, in us */
+       u8 ampdu_min_spacing;
+       /* Interface index */
+       u8 inst_nbr;
+       /* Support ldpc Tx */
+       u8 ldpc_enabled;
+       /* MU beamformee capable */
+       u8 mu_bfee;
+       /* SU beamformee capable */
+       u8 su_bfee;
+       /* Station AID */
+       __le16 aid;
+       /* My_aid - ??? */
+       __le16 my_aid;
+       /* Index of station in case of recovery */
+       u8 recovery_sta_idx;
+       u8 max_sp;
+       u8 uapsd_queues;
+       /* TX params */
+       struct cl_tx_params tx_params;
+       /*
+        * PE duration (0 =3D 0us, 1 =3D 8us, 2 =3D 16us)
+        * SS0 bits 0-1, SS1 bits 2-3, SS2 bits 4-5, SS3 bits 6-7.
+        */
+       u8 pe_duration[CHNL_BW_MAX][WRS_MCS_MAX_HE];
+       u8 he_tf_mac_padding_duration;
+       u8 he_rx_ctrl_frm_to_mbss;
+       u8 he_rx_1024qam_under_ru242;
+};
+
+/* Structure containing the parameters of the MM_STA_ADD_CFM message. */
+struct mm_sta_add_cfm {
+       /* Status of the operation (different from 0 if unsuccessful) */
+       u8 status;
+       /* Index assigned by the firmware to the newly added station */
+       u8 sta_idx;
+};
+
+/* Structure containing the parameters of the MM_STA_DEL_REQ message. */
+struct mm_sta_del_req {
+       u8 sta_idx;
+};
+
+/* Structure containing the parameters of the MM_STA_DEL_CFM message. */
+struct mm_sta_del_cfm {
+       /* Status of the operation (different from 0 if unsuccessful) */
+       u8 status;
+};
+
+/* Structure containing the parameters of the SET_POWER_MODE REQ message. =
*/
+struct mm_setpowermode_req {
+       u8 mode;
+       u8 sta_idx;
+};
+
+/* Structure containing the parameters of the SET_POWER_MODE CFM message. =
*/
+struct mm_setpowermode_cfm {
+       u8 status;
+};
+
+/* MAC Secret Key */
+#define MAC_SEC_KEY_LEN 32  /* TKIP keys 256 bits (max length) with MIC ke=
ys */
+
+struct mac_sec_key {
+       /* Key material length */
+       u8 length;
+       /* Key material */
+       u32 array[MAC_SEC_KEY_LEN / 4];
+};
+
+enum mac_cipher_suite {
+       MAC_CIPHER_SUITE_NULL,
+       MAC_CIPHER_SUITE_WEP40,
+       MAC_CIPHER_SUITE_TKIP,
+       MAC_CIPHER_SUITE_CCMP,
+       MAC_CIPHER_SUITE_WEP104,
+       MAC_CIPHER_SUITE_GCMP,
+
+       MAC_CIPHER_SUITE_MAX
+};
+
+/* Structure containing the parameters of the MM_KEY_ADD REQ message. */
+struct mm_key_add_req {
+       /* Key index (valid only for default keys) */
+       u8 key_idx;
+       /* STA index (valid only for pairwise keys) */
+       u8 sta_idx;
+       /* Key material */
+       struct mac_sec_key key;
+       /* Cipher suite */
+       u8 cipher_suite;
+       /* Index of the interface for which the key is set (valid only for =
default keys) */
+       u8 inst_nbr;
+       /* A-MSDU SPP parameter */
+       u8 spp;
+};
+
+/* Structure containing the parameters of the MM_KEY_ADD_CFM message. */
+struct mm_key_add_cfm {
+       /* Status of the operation (different from 0 if unsuccessful) */
+       u8 status;
+       /* HW index of the key just added */
+       u8 hw_key_idx;
+};
+
+/* Structure containing the parameters of the MM_KEY_DEL_REQ message. */
+struct mm_key_del_req {
+       u8 hw_key_idx;
+};
+
+/* Structure containing the parameters of the MM_BA_ADD_REQ message. */
+struct mm_ba_add_req {
+       /* Type of agreement (0: TX, 1: RX) */
+       u8 type;
+       /* Index of peer station with which the agreement is made */
+       u8 sta_idx;
+       /* TID for which the agreement is made with peer station */
+       u8 tid;
+       /* Buffer size - number of MPDUs that can be held in its buffer per=
 TID */
+       __le16 bufsz;
+       /* Start sequence number negotiated during BA setup */
+       __le16 ssn;
+};
+
+/* Structure containing the parameters of the MM_BA_ADD_CFM message. */
+struct mm_ba_add_cfm {
+       /* Index of peer station for which the agreement is being confirmed=
 */
+       u8 sta_idx;
+       /* TID for which the agreement is being confirmed */
+       u8 tid;
+       /* Status of ba establishment */
+       u8 status;
+       /* Aggregation index */
+       u8 agg_idx;
+       /* Number of descriptors the queue of session can hold */
+       u16 desc_cnt;
+};
+
+/* Structure containing the parameters of the MM_BA_DEL_REQ message. */
+struct mm_ba_del_req {
+       /* Index of peer station for which the agreement is being deleted *=
/
+       u8 sta_idx;
+       /* TID for which the agreement is being deleted */
+       u8 tid;
+};
+
+/* Structure containing the parameters of the MM_BA_DEL_CFM message. */
+struct mm_ba_del_cfm {
+       /* Index of peer station for which the agreement deletion is being =
confirmed */
+       u8 sta_idx;
+       /* TID for which the agreement deletion is being confirmed */
+       u8 tid;
+       /* Status of ba deletion */
+       u8 status;
+};
+
+/* Structure containing the parameters of the MM_AVAILABLE_BA_TXQ_REQ mess=
age. */
+struct mm_available_ba_txq_req {
+       /* Index of peer station for which the agreement deletion is being =
confirmed */
+       u8 sta_idx;
+       /* TID for which the agreement deletion is being confirmed */
+       u8 tid;
+};
+
+/* Structure containing the parameters of the MM_AVAILABLE_BA_TXQ_CFM mess=
age. */
+struct mm_available_ba_txq_cfm {
+       /* Index of peer station for which the agreement deletion is being =
confirmed */
+       u8 sta_idx;
+       /* TID for which the agreement deletion is being confirmed */
+       u8 tid;
+       /* Status if ba txqueue available */
+       u8 status;
+};
+
+/* Structure containing the parameters of the MM_CONNECTION_LOSS_IND messa=
ge. */
+struct mm_connection_loss_ind {
+       /* VIF instance number */
+       u8 inst_nbr;
+};
+
+/* Structure containing the parameters of the MM_PHY_RESET_CFM */
+struct mm_phy_reset_req {
+       /* PHY device: triding/elma/sdmb2b/sim */
+       u8 phy_reset;
+};
+
+struct sounding_info_per_sta {
+       u8 sta_idx;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+       u8 nc                 : 4, /* [3:0] NC of the STA */
+          fb_type_ng_cb_size : 3, /* [6:4] */
+          rsv1               : 1; /* [7] reserved */
+#else
+       u8 rsv1               : 1, /* [7] reserved */
+          fb_type_ng_cb_size : 3, /* [6:4] */
+          nc                 : 4; /* [3:0] NC of the STA */
+#endif
+};
+
+/* Information provided by application to firmware */
+struct mm_sounding_req {
+       struct sounding_info_per_sta info_per_sta[CL_MU_MAX_STA_PER_GROUP];
+       __le32 host_address;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+               /* [2:0] sounding type (HE-SU/HE-MU/HE_CQI/VHT-SU/VHT-MU) *=
/
+       __le32  sounding_type        : 3,
+               /* [3:6] number of stations in the sounding sequence */
+               sta_num              : 4,
+               /* [7] start/stop sounding sequence */
+               start                : 1,
+               /* [19:8] life expectancy of BFR in ms */
+               lifetime             : 12,
+               /* [31:20] sounding interval. 0 means a single sounding */
+               interval             : 12;
+               /* [1:0] requested bw for the sounding sequence (BFR/NDP) *=
/
+       u8      req_txbw             : 2,
+               /* [5:2] NSTS in the NDP frame */
+               ndp_nsts             : 4,
+               /* [7:6] reserved bits */
+               rsv1                 : 2;
+               /* [3:0] Bitmap of STAs to create SU Q-matrix for */
+       u8      q_matrix_bitmap      : 4,
+               /* [7:4] reserved bits */
+               rsv2                 : 4;
+#else
+               /* [31:20] sounding interval. 0 means a single sounding */
+       __le32  interval             : 12,
+               /* [19:8] life expectancy of BFR in ms */
+               lifetime             : 12,
+               /* [7] start/stop sounding sequence */
+               start                : 1,
+               /* [3:6] number of stations in the sounding sequence */
+               sta_num              : 4,
+               /* [2:0] sounding type (HE-SU/HE-MU/HE_CQI/VHT-SU/VHT-MU) *=
/
+               sounding_type        : 3;
+               /* [7:6] reserved bits */
+       u8      rsv1                 : 2,
+               /* [5:2] NSTS in the NDP frame */
+               ndp_nsts             : 4,
+               /* [1:0] requested bw for the sounding sequence (BFR/NDP) *=
/
+               req_txbw             : 2;
+               /* [7:4] reserved bits */
+       u8      rsv2                 : 4,
+               /* [3:0] Bitmap of STAs to create SU Q-matrix for */
+               q_matrix_bitmap      : 4;
+#endif
+       /* Sounding id. Used when deleting a sounding sequence */
+       u8 sid;
+};
+
+/* Application feedback for sounding request */
+struct mm_sounding_cfm {
+       u8 param_err;
+       u8 sounding_id;
+};
+
+struct mm_sounding_pairing {
+       u8 sounding_type;
+       u8 sounding_id;
+       u8 sta_idx;
+       u8 gid;
+};
+
+struct mm_sounding_interval_req {
+       __le16 interval;     /* Sounding interval */
+       __le16 bfr_lifetime; /* Life expectancy of BFR in ms */
+       u8 sounding_type;    /* Type of sounding (VHT/HT/SU/MU) */
+       u8 sta_idx;          /* Sta idx */
+};
+
+struct mm_sounding_interval_cfm {
+       u8 param_err;
+};
+
+/* Structure containing the parameters of the MM_BACKUP_BCN_EN_REQ message=
 */
+struct mm_set_backup_bcn_en_req {
+       /* Backup beacon disable/enable */
+       bool backup_bcn_en;
+};
+
+/* Structure containing the parameters of the MM_START_PERIODIC_TX_TIME_RE=
Q message */
+struct mm_start_periodic_tx_time_req {
+       u16 periodic_tx_time_off;
+       u16 periodic_tx_time_on;
+};
+
+enum ANAMON_MODE {
+       ANAMON_MODE_TEMPERATURE,
+       ANAMON_MODE_CHAINS,
+       ANAMON_MODE_SX
+};
+
+/* Structure containing the parameters of the MM_ANAMON_READ_REQ message *=
/
+struct mm_anamon_read_req {
+       u8 mode;   /* 0 - Temperature, 1 - Chains, 2 - SX */
+       u8 param1; /* For mode =3D 0: 0 - Internal, 1 - External ; For mode=
 =3D 1/2: Page number */
+       u8 param2; /* For mode =3D 5 bit value corresponding to mode select=
ion */
+};
+
+struct mm_anamon_read_cfm {
+       u8 retval;
+       __le16 raw_bits_data_0;
+       __le16 raw_bits_data_1;
+};
+
+struct mm_twt_setup_req {
+       u64 twt_start_time_tsf;
+       u64 twt_interval_us;
+       u32 min_wake_duration_us;
+       u8 sta_idx;
+       u8 twt_flow_id;
+       u8 triggered;
+       u8 announced;
+};
+
+struct mm_twt_teardown_req {
+       u8 sta_idx;
+       u8 twt_flow_id;
+};
+
+struct mm_set_freq_offset_req {
+       __le16 val;
+};
+
+/* +++++++++++++++++++++++++ Debug messages +++++++++++++++++++++++++ */
+
+/* Messages related to Debug Task */
+enum dbg_msg_tag {
+       /* Set module filter message */
+       DBG_SET_MOD_FILTER_REQ =3D FIRST_MSG(TASK_DBG),
+       DBG_SET_MOD_FILTER_CFM,
+       /* Set module filter message */
+       DBG_CE_SET_MOD_FILTER_REQ,
+       DBG_CE_SET_MOD_FILTER_CFM,
+       /* Set severity filter message */
+       DBG_SET_SEV_FILTER_REQ,
+       DBG_SET_SEV_FILTER_CFM,
+       /* Beamforming TX message */
+       DBG_BEAMFORMING_TX_REQ,
+       DBG_BEAMFORMING_TX_CFM,
+       /* Get ETH2WLAN statistics message */
+       DBG_GET_E2W_STATS_REQ,
+       DBG_GET_E2W_STATS_CFM,
+       /* Set LA MPIF mask message */
+       DBG_SET_LA_MPIF_MASK_REQ,
+       DBG_SET_LA_MPIF_MASK_CFM,
+       /* Set LA trigger point message */
+       DBG_SET_LA_TRIG_POINT_REQ,
+       DBG_SET_LA_TRIG_POINT_CFM,
+       /* Set LA MPIF debug mode message */
+       DBG_SET_LA_MPIF_DEBUG_MODE_REQ,
+       DBG_SET_LA_MPIF_DEBUG_MODE_CFM,
+       /* Set LA trigger rule message */
+       DBG_SET_LA_TRIG_RULE_REQ,
+       DBG_SET_LA_TRIG_RULE_CFM,
+       /* TX trace dump debug flag message */
+       DBG_TX_TRACE_DEBUG_FLAG_REQ,
+       DBG_TX_TRACE_DEBUG_FLAG_CFM,
+       /* Print statistics message */
+       DBG_PRINT_STATS_REQ,
+       DBG_PRINT_STATS_CFM,
+       /* Trigger the embedded logic analyzer message */
+       DBG_TRIGGER_REQ,
+       DBG_TRIGGER_CFM,
+       /* Test mode message */
+       DBG_TEST_MODE_REQ,
+       DBG_TEST_MODE_CFM,
+       /* Sounding command message */
+       DBG_SOUNDING_CMD_REQ,
+       DBG_SOUNDING_CMD_CFM,
+
+       DBG_REQ_CFM_MAX,
+
+       /* Print request */
+       DBG_PRINT_IND =3D DBG_REQ_CFM_MAX,
+       /* Information indication */
+       DBG_INFO_IND,
+       /* Max number of debug messages */
+       DBG_MAX,
+};
+
+/* Structure containing the parameters of the MM_DBG_TRIGGER_REQ message. =
*/
+struct dbg_trigger_req {
+       /* Error trace to be reported by the firmware */
+       char error[64];
+};
+
+/* Structure containing the parameters of the DBG_SET_MOD_FILTER_REQ messa=
ge. */
+struct dbg_set_mod_filter_req {
+       /* Bit field indicating for each module if the traces are enabled o=
r not */
+       __le32 mod_filter;
+};
+
+/* Structure containing the parameters of the DBG_SEV_MOD_FILTER_REQ messa=
ge. */
+struct dbg_set_sev_filter_req {
+       /* Bit field indicating the severity threshold for the traces */
+       __le32 sev_filter;
+};
+
+/* Beam forming debug sequence request */
+struct dbg_beamforming_tx_req {
+       __le32 bf_cmd;
+};
+
+/* Beamforming command parameters (debugFS interface) */
+struct dbg_fs_bf_args {
+       __le32 sta_idx     : 8;
+       __le32 antenna_set : 8;
+       __le32 is_mu       : 1; /* SU-0, MU-1 */
+       __le32 is_enable   : 1;
+       __le32 interval    : 10;
+       __le32 cmd         : 4;
+};
+
+struct dbg_frame_rate {
+       __le32 mcs          : 7;
+       __le32 bw           : 2;
+       __le32 gi           : 1;
+       __le32 pretypetxrcx : 1;
+       __le32 format       : 3;
+       __le32 reserved     : 14;
+       __le32 cmd          : 4;
+};
+
+/* Statistics print request. */
+struct dbg_print_stats_req {
+       __le32 command;
+       __le32 param[4];
+};
+
+/* Must be aligned with FW (dbg.h) */
+enum dbg_test_mode {
+       DBG_TEST_MODE_HELP =3D 0,
+       DBG_TEST_MODE_ASSERT_REC,
+       DBG_TEST_MODE_ERR_CORRECT_MODE,
+       DBG_TEST_MODE_PRESILICON_TESTS,
+       DBG_TEST_MODE_TRIGGER_BA_NOT_RECEIVED,
+       DBG_TEST_MODE_TRIGGER_ABOVE_BAW,
+       DBG_TEST_MODE_TRIGGER_BELOW_BAW,
+       DBG_TEST_MODE_TRIGGER_RETRY_LIMIT_REACHED,
+       DBG_TEST_MODE_DMA_DATA_PRINT,
+       DBG_TEST_MODE_SET_AGC_MEM,
+       DBG_TEST_MODE_FW_TRACE_MODE,
+       DBG_TEST_MODE_TX_POWER_DEBUG,
+       DBG_TEST_MODE_DCOC_IQ_MODE,
+       DBG_TEST_MODE_MACHW_STATE,
+       DBG_TEST_MODE_PHY_GLOBAL_RESET,
+       DBG_TEST_MODE_PHY_OLYMPUS_TXRX_MODE,
+       DBG_TEST_MODE_AFE_LOOPBACK_MODE,
+       DBG_TEST_MODE_MIN_SPACING_MODE,
+       DBG_TEST_MODE_DELAY_CHAIN,
+       DBG_TEST_MODE_ERR_DUMP_PRINT,
+       DBG_TEST_MODE_BW_SIG_PRINT,
+       DBG_TEST_MODE_RECOVER_BA_NOT_RECEIVED,
+       DBG_TEST_MODE_BAP_MODE,
+       DBG_TEST_MODE_DPHY_INJECT_RXERR,
+       DBG_TEST_MODE_RXM_RXVECTOR_PRINT,
+       DBG_TEST_MODE_STOP_CHAIN,
+       DBG_TEST_MODE_MAX_AGG_SIZE,
+       DBG_TEST_MODE_DISABLE_RECOVERY,
+       DBG_TEST_MODE_SET_NAV_DURATION,
+       DBG_TEST_MODE_SET_NAV_CLEAR,
+       DBG_TEST_MODE_DRA_GRP_LIMIT_SET,
+       DBG_TEST_MODE_DURATION_FROM_THD,
+       DBG_TEST_MODE_RIU_INT_EN,
+       DBG_TEST_MODE_MU_OF_1_USER,
+       DBG_TEST_MODE_FORCE_TRIGGER,
+       DBG_TEST_MODE_RECOVERY_DEBUG,
+       DBG_TEST_MODE_CHAIN_SUSPEND,
+       DBG_TEST_MODE_DSP_LCU_TRIG,
+       DBG_TEST_MODE_POWER_SAVE,
+       DBG_TEST_MODE_TRIGGER_RX_NOT_RECEIVED,
+       DBG_TEST_MODE_SNIFFER_MODE,
+       DBG_TEST_MODE_AGC_CAPTURE_NOISE,
+       DBG_TEST_MODE_TRIGGER_UNDERRUN,
+       DBG_TEST_MODE_TF_IN_AMPDU_EN,
+       DBG_TEST_MODE_MAX,
+};
+
+/* Number of input parameters to test mode */
+#define TEST_MODE_PARAM_MAX  5
+
+/* Statistics print request. */
+struct dbg_test_mode_req {
+       __le32 command;
+       __le32 params[TEST_MODE_PARAM_MAX];
+};
+
+#define SOUNDING_CMD_MAX_PARAMS 20
+
+/* Sounding cmd */
+struct dbg_sounding_cmd_param {
+       __le32 sounding_cmd_index;
+       __le32 param[SOUNDING_CMD_MAX_PARAMS];
+};
+
+/* ETH2WLAN statistics request DBG_GET_E2W_STATS_REQ message */
+struct dbg_e2w_stats_req {
+       /* Clear statistics after get */
+       __le32 clear;
+};
+
+/* ETH2WLAN software debug counters */
+struct dbg_e2w_counters {
+       /* Total number of module activations */
+       __le32 tx_ac_total[AC_MAX];
+       /* Number of Tx conversion errors */
+       __le32 tx_ac_convert_error[AC_MAX];
+       /* Number of incorrect THD frmlen errors */
+       __le32 tx_ac_thd_frmlen_error[AC_MAX];
+       /* Number of incorrect THD data-start or data-end pointer errors */
+       __le32 tx_ac_thd_ptr_error[AC_MAX];
+       /* Number of incorrect unique THD pattern errors */
+       __le32 tx_ac_thd_pattern_error[AC_MAX];
+       /* Number of module Tx errors */
+       __le32 tx_module_error;
+
+};
+
+/* ETH2WLAN statistics confirm DBG_GET_E2W_STATS_CFM message */
+struct dbg_e2w_stats_cfm {
+       struct dbg_e2w_counters cntrs;
+};
+
+/* Embedded LA MPIF mask set request message */
+struct dbg_set_la_mpif_mask_req {
+       __le32 mpif_mask;
+};
+
+/* Embedded LA Trigger Point set request message */
+struct dbg_set_la_trig_point_req {
+       __le32 trigger_point;
+};
+
+/* Embedded LA MPIF debug mode set request message */
+struct dbg_set_la_mpif_debug_mode_req {
+       u8 mode;
+};
+
+/* Structure containing the parameters of the DBG_TX_TRACE_DEBUG_FLAG_REQ =
message. */
+struct dbg_tx_trace_debug_flag_req {
+       /* Bitmap for enabling\disabling debug options */
+       __le32 bitmap;
+       /* "1" - write the bitmap to global var, "0" - read the global var =
*/
+       u8 read_write_flag;
+};
+
+enum la_trig_oper {
+       LA_TRIG_OPER_EQ,
+       LA_TRIG_OPER_NOT_EQ,
+       LA_TRIG_OPER_GT,
+       LA_TRIG_OPER_GT_EQ,
+       LA_TRIG_OPER_LT,
+       LA_TRIG_OPER_LT_EQ,
+
+       /* Always keep this entry last */
+       LA_TRIG_OPER_MAX
+};
+
+struct dbg_set_la_trig_rule_req {
+       /* Rule index */
+       u8 rule_id;
+       /* Comparison operator */
+       u8 oper;
+       /* Rule enable/disable */
+       u8 enable;
+       /* Reserved */
+       u8 rsv;
+       /* Address to be checked */
+       u32 address;
+       /* Trigger value */
+       u32 value;
+       /* Trigger value mask (enable mask - only set bits are compared) */
+       u32 mask;
+       /* Duration in usec value must match for trigger */
+       u32 duration;
+};
+
+/* Information sent from firmware to host indicating the rx bfr variables =
*/
+struct mm_sounding_ind {
+       /* Param that are application private, collected by host without lo=
cal copy */
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+       u8 sounding_type : 3,
+          status        : 1,
+          fail_reason   : 4;
+       u8 mu            : 1,
+          rsv           : 7;
+#else
+       u8 fail_reason   : 4,
+          status        : 1,
+          sounding_type : 3;
+       u8 rsv           : 7,
+          mu            : 1;
+#endif
+       u8 sid;
+       u8 sta_idx;
+       u16 v_matrix_offset[CL_MU_MAX_STA_PER_GROUP];
+};
+
+/* Possible fw errors types */
+enum mm_fw_error_type {
+       MM_FW_ERROR_TYPE_MU_OFDMA_SLOW_SECONDARY,
+       MM_FW_ERROR_TYPE_MAX
+};
+
+/* Structure containing the parameters of the MM_FW_ERROR_IND message */
+struct mm_fw_error_ind {
+       u8 group_id;
+       u8 error_type;
+       u8 sta_inidices[CL_MU_MAX_STA_PER_GROUP];
+       u8 sta_num;
+};
+
+enum mm_agg_rx_status_type {
+       MM_AGG_RX_REPORT_STAT_OK,
+       MM_AGG_RX_REPORT_STAT_COLISION_WITH_COUNTER,
+       MM_AGG_RX_REPORT_STAT_COUNTER_LOST,
+       MM_AGG_RX_REPORT_STAT_NOT_RECEIVED,
+       MM_AGG_RX_REPORT_STAT_NOT_HE
+};
+
+#define MSG_TOTAL_REQ_CFM (MM_REQ_CFM_MAX + DBG_REQ_CFM_MAX)
+#define DBG_STR_SHIFT(id) ((id) - FIRST_MSG(TASK_DBG) + MM_REQ_CFM_MAX)
+#define MSG_ID_STR(id)    (((id) < MM_REQ_CFM_MAX) ? msg2str[id] : msg2str=
[DBG_STR_SHIFT(id)])
+
+extern const char *const msg2str[MSG_TOTAL_REQ_CFM];
+
+#endif /* _CL_FW_MSG_H */
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

