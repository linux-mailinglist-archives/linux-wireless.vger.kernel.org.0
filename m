Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DBA3AB913
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhFQQMW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:22 -0400
Received: from mail-eopbgr60069.outbound.protection.outlook.com ([40.107.6.69]:39392
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233845AbhFQQLI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbrEdGmL3cccUoFWXP05iQQR4APOehZ3IPJIDXgokqxRC1tiWMe6D1qWk6KCAxn5tuQnjjvpRPEnJdiC7Q+YoLXXtJjG3sjDnaTTWvN1a4Iv0UJwTEtfxj7OgGp1j3/6Aa1IRtgBbiQef1xW856TdmdqqF21ALDMYGHXpTInkzmoH38f9mnSxA7hf/hE7r+qtFds8or5BOLuh3c/UDrcyGxHQ40Iva6XRIrw4fzPMUlP7rQlvQbzQrFBHOa91H1+gfNWTfzXdkztfjm1a1Pf9djYRRxq6WE7/wYd4ttto6Pv62MUdmCRif9cFnngEkN/J2N3FITChro4WtTAvmKkww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ic0RbwbwqONuLFKXWCJMMAIi9rbpvhYU/5kPYneUp4Y=;
 b=Wx53lEcTeRAdM2TuhmiVSPa1KJylw10zkyiLpiyhwKQ6+noTxtjvb9EzS3QJ68BdnpPWpFjWgI+brILFF4/fn7KCZjBS+RJ72LzbeyLbKjeElaeBCCQP9GvSohogg4CVGVwcb/HBV9vLM6k9x3y/HFYIyKNX9D90ApBjcZlI68PRLz3RkKiqbB/YjGyfZ8rmLp62rquHQEliFMANRMGNuV9s9UCpogaycs4+DszIerLOvgy6PF2PfehT3+2PkHldX/Ej9cSzM8EcOjWE5iMqxcZBDCAam+PtMwWhD3DurRUx37+JqSeDgPnslteeJgfIR0V1bHbiiy6oz/c6XXUBiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ic0RbwbwqONuLFKXWCJMMAIi9rbpvhYU/5kPYneUp4Y=;
 b=bHRyqV2rED17xmcEPyph7PoVPd//8Y2SjTyAqpHoXvH0h42zqKx5JwneK/6u21ZVZ3m4QG06x8D7z3YeR6W0xCu1yfJJFGCzjC9TEjX+IJu1htWWQKvXqOFcp/sqNvD2nA3cYquEASkVXLzkgfhdiJmGZC7xGf62C5MQReefKRU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1075.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:07:16 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:16 +0000
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
Subject: [RFC v1 201/256] cl8k: add tx/agg_cfm.h
Date:   Thu, 17 Jun 2021 16:01:28 +0000
Message-Id: <20210617160223.160998-202-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 485ed626-42a8-43b9-6762-08d931a9d688
X-MS-TrafficTypeDiagnostic: AM8P192MB1075:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB10755C26CF43B17293A4A826F60E9@AM8P192MB1075.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KZhm8GeuMfplEIQiTO+uIRYWJFRk1vk3e3ou9r0nGSYkV7juwUzvcJa3fOTgZLdzlYKBMXIaXARnIxTNXkBs677/UFoEXsm+ZpbwJYk0gGn+Xug+LBhOsRrwQpyOqRkn+GrDi6vA6a4uXYX4tv1MvDYFKlfwVe6vvbbWbL1dBKViqgFkqS1TtwOA1s242bg2XfjrTptYnWmionYMWffF50cT2QiAjEwFDwePsVR9/SQH0XGdHNlt+738JFJI9OwVZEMblAIejMLPs+DrJ+mg9Z++WNb/RFJFtBwz2W3LPJcY0G4MySXK1pWuF6HknD8MLClaZLlRyMWNcGcD4ZMUYCJ0PEhjQJ18wo5Uw8N1jUcq849mqai8DxeC3E1GKc8/C+qfz2XN/jbDlHR0uA6aTiNbRfBwqeWPnO0AbBcs9NQAtP7eU94BWDtt/Q684eaykwyeNWuJGqpu2fYYu1YKknUvzzKPmDUL3V/g+muqQxmAB9003gLoHDp3f0cbzAsIY5qM4Pt8ZDe42OKpDDcIqVFT9itCMLI/3ggtBBPjOAkkEQ7QC4XOICAm068Neu7C5y6u1QUpD7dieyqk5JCR0Fq+N5VoR/Xz2D9W62pFZ2lxos3MmGwJZxxcqU6xfIoCno47yAC5Wuq86H6FurN/pg0gmIwWizefcMJLIbNRNGrzoMPHtqtfEUNcdfBwYEHETh0TKKDWfveeO7W4xzzSng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(136003)(39850400004)(376002)(366004)(346002)(66476007)(6512007)(8936002)(66556008)(38350700002)(6916009)(9686003)(66946007)(956004)(86362001)(26005)(5660300002)(2616005)(38100700002)(478600001)(8676002)(6506007)(6666004)(4326008)(1076003)(55236004)(186003)(316002)(2906002)(83380400001)(16526019)(54906003)(52116002)(36756003)(107886003)(6486002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x0ELjRJVzJ4n1ZStmaYdg/HOmTXqlSm2koDFQCXyQ9/oS8VC0HMgW4+5pC8E?=
 =?us-ascii?Q?n5hQTV9buK0/EuJF/uQeDIBqxpd1JmV2kUprOoJjLcJqyRLBxU+n18zYJNdZ?=
 =?us-ascii?Q?Mgr2j6Cjc9BSo2OnoJgK8o4ZOAITOlndHZ0AonxR2zPYo8coC8qU/lbykgvi?=
 =?us-ascii?Q?8gXxRIP0lIYrHE+rlF3yFCOu+p3Bt1C4/aJxyEuxa8Q3DLSZ8cr9FKKB8aqy?=
 =?us-ascii?Q?kgICadW+vEneZdYDHeOhT/YRWAf6nifCSVaePh8RzdAvWsL6EACoR7fLWhRj?=
 =?us-ascii?Q?+Fepfwu8dSEO5DleyslIiZ6QCGsKXabBfXLlV4v4yBD5pAzii9fLxvdmUqO6?=
 =?us-ascii?Q?9dVN+BPRf6NLQ8AGkB0Syu6KfvyP+rfaQqM+AfnhfsOZUVhxbf1QBcmO5oOg?=
 =?us-ascii?Q?bSdm1YutmLfl2vQiuLqM5D3j52qvdapS893BUtBxQQZmn+UFodaO9VhWp7Pu?=
 =?us-ascii?Q?g2rfSd6Z8ZGHqpFxEnYvQzuTe7oosRyzu/zA0EnzOz1WeMA9fsS15DQH5sms?=
 =?us-ascii?Q?ppdiR5rCsJHO7quXzpjeJvLrZHg99lDJ0h3qZoT92Z4msP3g1aFYWbjlmDAX?=
 =?us-ascii?Q?CjakPuuZ+LBgGVUYuggRRXHstrsUEZVGEpnb4YpGxJwRad/GZkTHX3RueYwQ?=
 =?us-ascii?Q?iKeLBRyY2CHAA4CaGcocV4sI0uHjdbfem0tGgRPeOZv/fz6rcxj46rpJpvq8?=
 =?us-ascii?Q?UYhFk82KEW8sJarZP4Oy681ueatM2WU+wfllZY6uciXtMB6qIC+/G1uYy2Fg?=
 =?us-ascii?Q?FL7O2/Yd4VoUvouuc82iiwVTyzkuw0Fw+dh+Sgaqd7eCkAtyJuhkKfYROGRN?=
 =?us-ascii?Q?A/7GN/Z7GGJLSuQ+IP/hH3/zWTSAkyMRjpaZIWPQoTACDhI80N+wS4ILZViY?=
 =?us-ascii?Q?Yt7X6emGiAkX48knWccz/JzSPG9T6Jz2Fd2U/1zPaD8RJ+4I3jVU7Y/yf3eN?=
 =?us-ascii?Q?z1YbvqNuGSGzxHJ0zlvlHekLjpuBWfzt0ZhTyAG+DhppwxYKVeWMuaRzuaZw?=
 =?us-ascii?Q?HhjtRczne7g10sZfmmc9FxwCUwiI1L7Z/7ZApm9QYcU25xru2ihBQ68KQnlo?=
 =?us-ascii?Q?pHkKIBNUYutLtaf5dJCiShz8WNYX47Qo7SzboJCi+yw15Gnkj68SoGjPPjT8?=
 =?us-ascii?Q?DbzCfA8E8M8ArT1CXbBoagsux4DwN6eJ5HVOrZOaSPNyjAjl7+xu64ejhY40?=
 =?us-ascii?Q?fzvPmjD+RcXkVT95t/xBPGTob5vVWyUlWWPVdikFtBxX0vfr2iZSav+s8D3R?=
 =?us-ascii?Q?9w4N0RQmAmp1Az9fYyDg3wvmEuwif5q0HyrOlSNQivi8PL5s0VxfWqVm6UHQ?=
 =?us-ascii?Q?9eSIcSfl9qbpZx08FB5WxWAH?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485ed626-42a8-43b9-6762-08d931a9d688
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:16.9417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4OOGdGJYdZmvQmq9KnYnB+B6tX99bMWtOBJB4QU/2TvyxhnrsHdLsCU5k8XAOsdIzYV/mMz+LOm/Yu/48YsRBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1075
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/tx/agg_cfm.h | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/agg_cfm.h

diff --git a/drivers/net/wireless/celeno/cl8k/tx/agg_cfm.h b/drivers/net/wi=
reless/celeno/cl8k/tx/agg_cfm.h
new file mode 100644
index 000000000000..d998e7fa4415
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tx/agg_cfm.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_AGG_CFM_H
+#define CL_AGG_CFM_H
+
+#include "tx/tx_queue.h"
+#include "ipc_shared.h"
+
+void cl_agg_cfm_init(struct cl_hw *cl_hw);
+void cl_agg_cfm_add(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr, u8 =
agg_idx);
+void cl_agg_cfm_free_head_skb(struct cl_hw *cl_hw,
+                             struct cl_agg_cfm_queue *cfm_queue,
+                             u8 ba_queue_idx);
+void cl_agg_cfm_flush_all(struct cl_hw *cl_hw);
+void cl_agg_cfm_poll_empty(struct cl_hw *cl_hw, u8 agg_idx, bool flush);
+void cl_agg_cfm_poll_empty_sta(struct cl_hw *cl_hw, struct cl_sta *cl_sta)=
;
+void cl_agg_cfm_set_ssn(struct cl_hw *cl_hw, u16 ssn, u8 idx);
+void cl_agg_cfm_set_tx_queue(struct cl_hw *cl_hw, struct cl_tx_queue *tx_q=
ueue, u8 idx);
+
+#endif /* CL_AGG_CFM_H */
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

