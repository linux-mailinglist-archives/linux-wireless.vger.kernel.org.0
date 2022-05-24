Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660E353297B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbiEXLln (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237004AbiEXLlg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:41:36 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60067.outbound.protection.outlook.com [40.107.6.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB024915BB
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:40:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kU6GZZ4tP21xZHfCImAmk6FGWXVfqww6OJrTgkB6NDrw8uRH7fxl0yGztTlvqDxahqQz9RA7BPWo62cTm6s+FIvoBC9i2A2ZaFfpzqvJw+IKircfm/68FTFXkSifqkF7aA5wv6OUs99yx2R12Lb/3iJMCD/BH2O/kn00uVDvW5r0p7eI7JYLJlEuxiMuCDqLC7BKRdJt8EzaUMpy/fgHM0KxsjK8Y5UTUB34h4dIQtbUPxIkwIMrOhN7FodL+ksraOrz3eHIhSpB6S1IFq+XQ87wBr+JtAdxviBeHMvom5RJmDYJrxzt1GM3XgECxoggkXSWhIFkuPXnB2bx1ZTHKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JM4onuLiLGB7asJfwptj2ATnylJ+NbnJA+JvJV1v1c=;
 b=AaP+Q2CG9DS3699/muQPDq1nJYOVpkUaLIGRSWiFTR6eaMRv2MyIPbkPj+O3YRkaOsz42jPzHCSylwLx9Big1wA7bd4K+ixpqCxVB9YhPka0pNVaEksj2MXMMcneAn8YJ2XQZqsAvSJ1aNQm9AL5ukf2tcobemSstWSqbR3MQY4cXXZafNLW5LyqwzzgitNFshf8MGVe76B3s1RIdX/W1JHxuzA0TAJxulOgrFsqrroB2NJ6Im+G1HxiiI8Op8e5j3IopmavO7W9MQ5WMjlD//PJsQPTnfFp2oxOyfnYaDzwjqjpM+KrzwJhret8xsFM7BtZNwM+xIWOOFetwoCG1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JM4onuLiLGB7asJfwptj2ATnylJ+NbnJA+JvJV1v1c=;
 b=Yp/bjNLr2yA7L24a1TrNzPi+ULQzAPeB3wV1VXjPBGiEkKAFP19SGopZ7kFiRiielE0lqeI86kMFChY5AnImaU80sA9+eGFAZs4tzCij84cgYldMe4/PsnNP8T7j3eyLbbPUarTtYL3k9bGEc2hUw+aBpb72naHPRptWWkjKmxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0915.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 24 May
 2022 11:39:27 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:27 +0000
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
Subject: [RFC v2 74/96] cl8k: add sta.c
Date:   Tue, 24 May 2022 14:34:40 +0300
Message-Id: <20220524113502.1094459-75-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: e6d73d93-0093-40b1-44ba-08da3d79f82a
X-MS-TrafficTypeDiagnostic: AM8P192MB0915:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM8P192MB091536A0BD07CA536C277F06F6D79@AM8P192MB0915.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVXl/wgYqPlpALlw/gvksicvQFyYGL+1n5hkTttMq+YUbCE2MRM9j/QFUHh7QPZ6Vx6bSsb1brLY3uw81gWs81KY75qeHYRSkw9fH3qE53YPdZh1M/93UIq1dbFK2pWMkr54BSmxbPdSYsDXIw8GBXCZEjK2IwV0Ma9srIWSWjI811jwITGH3HQFAgHTQjFJPCRNL1THL6je0Lotu1xhi3C9WEkDYvrLGamjG1AdnPywCmD48A7dzl8QfTeSvV6g1iUxCAH463eFOX1TEtR1bjNYyAflG3gAfpeyCbC9vm2Sigs7T5Vujv3U/p7vheJ1TL3f9PNem7v5yaL3pyVNhJpJ8OtIlvbc64NYhsaJndvEXqKbrt9NyQ8vcujWWwo0gnpiZNJOvLO93JvLUHq1FrNTXWBZWx0ftRUhnDLSZPbJETIw3VzyE2U6F/J/Vq92ebQsyCrBK30tQhuRZBaoOG0/Gjsv2fWL9e04PzVGMRJ0Pls5sRFM5nT6CXu7s05vYplT5zww6kgE1PCp7Oncy1fn8siA0wQBVnM80lJ835bYLPtJAh9jZflHOI4BsNYHR9dEyDzVKo5epGcxPkcCz9R0N/W3QK/NiHSHwS4n/xm2/n61IMG888o1t7BaanKmyDl1fRE459gR8RoIMrNUJK7kuyLjbP9qJNqFAwgsrZGKnRI0COZXXZOV3TWN/H5bw2pBqJo2XsnLwG6QCvAv97nAeqbp7Iyv/3ki3yKboyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(376002)(346002)(39850400004)(83380400001)(54906003)(186003)(36756003)(107886003)(2906002)(2616005)(30864003)(1076003)(6916009)(41300700001)(66946007)(8936002)(6666004)(9686003)(66476007)(26005)(86362001)(66556008)(5660300002)(6512007)(4326008)(38350700002)(316002)(6506007)(52116002)(8676002)(6486002)(38100700002)(508600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CUwExySzDcH77f6WdpXa//8hT7E1wA2vbVwYrLUxGhdebeSSBwum7qhho1Sq?=
 =?us-ascii?Q?tBHARxSuRhPFcoanHDkDIdLc7Qp5B/uHGJXwnNdAtRhrEeGFTnEfje/YglYG?=
 =?us-ascii?Q?OJ7Ew/Ygwc4WI4Qe9+Rz5XINgTZ2bb0MHQWg97IgCefl3l9Omoyd/DmrnvD8?=
 =?us-ascii?Q?v1nap3mDRU59MY/fmJC4WFOvMRhMr7b6Z/yNk1m1WedpWFb1vAfspSYbsdjk?=
 =?us-ascii?Q?yX+aqZfNBA9zzTqSvaMXMQwkw4CeBSkRtngF6pVBYhg+kGGFaRH+5EyoWWrg?=
 =?us-ascii?Q?b3LBxI6jNVwbQhuoylKE+Vh6PMrZPkO3Vc7cQu7i+gligz0Zv3AGyXIt6lqO?=
 =?us-ascii?Q?Z+BEoJhWGFZjUvFcAtlk2YBqNFn72k3sW5abmuWZUIgcMTo61YNmQNymqaeZ?=
 =?us-ascii?Q?f1iMlrhy8IMZg3P3I05wRKhWoTNLInHGgqo90aTTQDbaeLz2KJHw5+cLmlhi?=
 =?us-ascii?Q?VhCw3JNBEuYXxQc1S037a+016If+Z+G31r0XxPwd5gw3FlVrLieXUUf2O5YS?=
 =?us-ascii?Q?+E0n1A0Z1QDOLauAgOij2OeJLcNgsnIZSXw2cFw5gwWUODV+zhSixwaicQD/?=
 =?us-ascii?Q?28kKeplZNvXhcjkayTpURmYUaHILhHyWLoSwBZZehBtmSXK6ddofAI19nX/C?=
 =?us-ascii?Q?WblWjG6pFttRQoxaCmDsh9mzBPvmp3Q/qYxGpfvJAhcKgJfeiFQykXdWyH1T?=
 =?us-ascii?Q?E+PuAUnx+FGPbFY/bb0YvbrSTD1bPNOUagPYAi0wvhRcJnA0YNq2XrX2DgIB?=
 =?us-ascii?Q?1wKMFIS0VbTieZoepq0qTEB4pN6YqqRDbheQO50bmYoIC4+aX+NRqqNfvrg/?=
 =?us-ascii?Q?/0D1uRMnJ5hv4yVLzpyhYHPP73cayHeKcxFgRw+IBA/ZYzjvy26cJnHsLQ88?=
 =?us-ascii?Q?KlJUKPuLjVooyrSqd51pJu7m4+hBdzuyRT5EEloWE9lTaDTD6H2FHtIPcFKX?=
 =?us-ascii?Q?xZhNS9eJvzNnpSCworYX/EiN9yyY3XqoUfVz1GirJ3MPf+RhlYeY3zKuCFle?=
 =?us-ascii?Q?a3lAjIAJWgWW4cq1Yztr4iP/SAv/w0/cR4m02NQuDC1gFFUmX9UV0ZiGXsz7?=
 =?us-ascii?Q?DrLbeNOsAEz/4WVoTp7q3coC1XhS220XtayDJWbol2hDYew2Aq1lslksa8a2?=
 =?us-ascii?Q?1icBZ/6SKD440gflbUcXe4gIHsiNbxU6WJNx9I9yTf/Za62X9E4Y6cZerz5/?=
 =?us-ascii?Q?J7hivPvHvhvGqnpMuYfwBQbgjVyMWUJGAnkbjP+FgezSirL9py+I6XEBqso8?=
 =?us-ascii?Q?l0Xtr4SJAhq+K5+bXVN+9bhMj70HuWN5jQxJx1MLv5V+1wD235/E++1PWUrx?=
 =?us-ascii?Q?CgOZfwYGaVUyE/GwgUJfYkAx0kPznHPctoQGF0VMommKXOsbmQJEwcqh32f6?=
 =?us-ascii?Q?Up7SNJBoimzyHs/bZTCbXDUm225CZNW/3V2Q7srCCAvcSVPd/QZ+3xvWuCOJ?=
 =?us-ascii?Q?54R6CpUTSoKeAPSgZf4bqYw1uA8MGA5CHkeNXhMdTfJfBPg2JEgH/Dp1Uqun?=
 =?us-ascii?Q?TXj79VMyoQs3uPZLAdDq/4SBxdYm+jlgT9MckI2BMVdo5d6Sd8N5qnTD0feo?=
 =?us-ascii?Q?Npztdw/5lUzpDNH5ivDQb5oV8z6e3AMe1m/yPVabepUwGjI/5/54+r7p0iXO?=
 =?us-ascii?Q?U7+fxQo5A61LE9lTJSyPghy7PJ9b44iWuAr6vxyR2H3h5y48+oBIu/2OrEZc?=
 =?us-ascii?Q?wx6jn066OZftQwbh0wVxpa+kIVAoVIdw++ivBiji3LeA1EUITZWab+Oq9F45?=
 =?us-ascii?Q?CR1oHWvdr0Rb8kAfcg5v20CjVL4vaOM=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d73d93-0093-40b1-44ba-08da3d79f82a
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:49.1778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrF/NPNvcT8zVFiJedunRuowTJi4uhCvJOc6IvhUAmISRG3LAWlFZjZqAe6OpXryXb7ABeycASKSUB+u9NBOFg==
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
 drivers/net/wireless/celeno/cl8k/sta.c | 507 +++++++++++++++++++++++++
 1 file changed, 507 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/sta.c

diff --git a/drivers/net/wireless/celeno/cl8k/sta.c b/drivers/net/wireless/celeno/cl8k/sta.c
new file mode 100644
index 000000000000..26c280b05266
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/sta.c
@@ -0,0 +1,507 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include "chip.h"
+#include "phy.h"
+#include "bf.h"
+#include "vns.h"
+#include "tx.h"
+#include "radio.h"
+#include "motion_sense.h"
+#include "mac_addr.h"
+#include "recovery.h"
+#include "dfs.h"
+#include "stats.h"
+#include "utils.h"
+#include "sta.h"
+
+void cl_sta_init(struct cl_hw *cl_hw)
+{
+	u32 i;
+
+	rwlock_init(&cl_hw->cl_sta_db.lock);
+	INIT_LIST_HEAD(&cl_hw->cl_sta_db.head);
+
+	for (i = 0; i < CL_STA_HASH_SIZE; i++)
+		INIT_LIST_HEAD(&cl_hw->cl_sta_db.hash[i]);
+}
+
+void cl_sta_init_sta(struct cl_hw *cl_hw, struct ieee80211_sta *sta)
+{
+	if (!cl_recovery_in_progress(cl_hw)) {
+		struct cl_sta *cl_sta = IEEE80211_STA_TO_CL_STA(sta);
+
+		/* Reset all cl_sta strcture */
+		memset(cl_sta, 0, sizeof(struct cl_sta));
+		cl_sta->sta = sta;
+		/*
+		 * Set sta_idx to 0xFF since FW expects this value as long as
+		 * the STA is not fully connected
+		 */
+		cl_sta->sta_idx = STA_IDX_INVALID;
+	}
+}
+
+static void cl_sta_add_to_lut(struct cl_hw *cl_hw, struct cl_vif *cl_vif, struct cl_sta *cl_sta)
+{
+	write_lock_bh(&cl_hw->cl_sta_db.lock);
+
+	cl_hw->cl_sta_db.num++;
+	cl_vif->num_sta++;
+	cl_hw->cl_sta_db.lut[cl_sta->sta_idx] = cl_sta;
+
+	/* Done here inside the lock because it allocates cl_stats */
+	cl_stats_sta_add(cl_hw, cl_sta);
+
+	write_unlock_bh(&cl_hw->cl_sta_db.lock);
+
+	cl_dbg_verbose(cl_hw, "mac=%pM, sta_idx=%u, vif_index=%u\n",
+		       cl_sta->addr, cl_sta->sta_idx, cl_sta->cl_vif->vif_index);
+}
+
+static void cl_sta_add_to_list(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	u8 hash_idx = CL_STA_HASH_IDX(cl_sta->addr[5]);
+
+	write_lock_bh(&cl_hw->cl_sta_db.lock);
+
+	/* Add to hash table */
+	list_add(&cl_sta->list_hash, &cl_hw->cl_sta_db.hash[hash_idx]);
+
+	/* Make sure that cl_sta's are stored in the list according to their sta_idx. */
+	if (list_empty(&cl_hw->cl_sta_db.head)) {
+		list_add(&cl_sta->list, &cl_hw->cl_sta_db.head);
+	} else if (list_is_singular(&cl_hw->cl_sta_db.head)) {
+		struct cl_sta *cl_sta_singular =
+			list_first_entry(&cl_hw->cl_sta_db.head, struct cl_sta, list);
+
+		if (cl_sta_singular->sta_idx < cl_sta->sta_idx)
+			list_add_tail(&cl_sta->list, &cl_hw->cl_sta_db.head);
+		else
+			list_add(&cl_sta->list, &cl_hw->cl_sta_db.head);
+	} else {
+		struct cl_sta *cl_sta_last =
+			list_last_entry(&cl_hw->cl_sta_db.head, struct cl_sta, list);
+
+		if (cl_sta->sta_idx > cl_sta_last->sta_idx) {
+			list_add_tail(&cl_sta->list, &cl_hw->cl_sta_db.head);
+		} else {
+			struct cl_sta *cl_sta_next = NULL;
+			struct cl_sta *cl_sta_prev = NULL;
+
+			list_for_each_entry(cl_sta_next, &cl_hw->cl_sta_db.head, list) {
+				if (cl_sta_next->sta_idx < cl_sta->sta_idx)
+					continue;
+
+				cl_sta_prev = list_prev_entry(cl_sta_next, list);
+				__list_add(&cl_sta->list, &cl_sta_prev->list, &cl_sta_next->list);
+				break;
+			}
+		}
+	}
+
+	write_unlock_bh(&cl_hw->cl_sta_db.lock);
+
+	cl_sta->add_complete = true;
+}
+
+static void cl_connection_data_add(struct cl_vif *cl_vif)
+{
+	struct cl_connection_data *conn_data = cl_vif->conn_data;
+
+	if (cl_vif->num_sta > conn_data->max_client) {
+		conn_data->max_client = cl_vif->num_sta;
+		conn_data->max_client_timestamp = ktime_get_real_seconds();
+	}
+
+	if (cl_vif->num_sta == conn_data->watermark_threshold)
+		conn_data->watermark_reached_cnt++;
+}
+
+static void cl_connection_data_remove(struct cl_vif *cl_vif)
+{
+	struct cl_connection_data *conn_data = cl_vif->conn_data;
+
+	if (cl_vif->num_sta == conn_data->watermark_threshold)
+		conn_data->watermark_reached_cnt++;
+}
+
+static void _cl_sta_add(struct cl_hw *cl_hw, struct ieee80211_vif *vif, struct ieee80211_sta *sta)
+{
+	struct cl_vif *cl_vif = (struct cl_vif *)vif->drv_priv;
+	struct cl_sta *cl_sta = IEEE80211_STA_TO_CL_STA(sta);
+
+	/* !!! Must be first !!! */
+	cl_sta_add_to_lut(cl_hw, cl_vif, cl_sta);
+
+	cl_baw_init(cl_sta);
+	cl_txq_sta_add(cl_hw, cl_sta);
+	cl_vns_sta_add(cl_hw, cl_sta);
+	cl_connection_data_add(cl_vif);
+
+	/*
+	 * Add rssi of association request to rssi pool
+	 * Make sure to call it before cl_wrs_api_sta_add()
+	 */
+	cl_rssi_assoc_find(cl_hw, cl_sta, cl_hw->cl_sta_db.num);
+
+	cl_motion_sense_sta_add(cl_hw, cl_sta);
+	cl_bf_sta_add(cl_hw, cl_sta, sta);
+	cl_wrs_api_sta_add(cl_hw, sta);
+	cl_wrs_api_set_smps_mode(cl_hw, sta, sta->bandwidth);
+#ifdef CONFIG_CL8K_DYN_MCAST_RATE
+	/* Should be called after cl_wrs_api_sta_add() */
+	cl_dyn_mcast_rate_update_upon_assoc(cl_hw, cl_sta->wrs_sta.mode,
+					    cl_hw->cl_sta_db.num);
+#endif /* CONFIG_CL8K_DYN_MCAST_RATE */
+#ifdef CONFIG_CL8K_DYN_BCAST_RATE
+	cl_dyn_bcast_rate_update_upon_assoc(cl_hw,
+					    cl_sta->wrs_sta.tx_su_params.rate_params.mcs,
+					    cl_hw->cl_sta_db.num);
+#endif /* CONFIG_CL8K_DYN_BCAST_RATE */
+
+	/* !!! Must be last !!! */
+	cl_sta_add_to_list(cl_hw, cl_sta);
+}
+
+/*
+ * Parse the ampdu density to retrieve the value in usec, according to
+ * the values defined in ieee80211.h
+ */
+static u8 cl_sta_density2usec(u8 ampdu_density)
+{
+	switch (ampdu_density) {
+	case IEEE80211_HT_MPDU_DENSITY_NONE:
+		return 0;
+		/* 1 microsecond is our granularity */
+	case IEEE80211_HT_MPDU_DENSITY_0_25:
+	case IEEE80211_HT_MPDU_DENSITY_0_5:
+	case IEEE80211_HT_MPDU_DENSITY_1:
+		return 1;
+	case IEEE80211_HT_MPDU_DENSITY_2:
+		return 2;
+	case IEEE80211_HT_MPDU_DENSITY_4:
+		return 4;
+	case IEEE80211_HT_MPDU_DENSITY_8:
+		return 8;
+	case IEEE80211_HT_MPDU_DENSITY_16:
+		return 16;
+	default:
+		return 0;
+	}
+}
+
+static void cl_sta_set_min_spacing(struct cl_hw *cl_hw,
+				   struct ieee80211_sta *sta)
+{
+	bool is_6g = cl_band_is_6g(cl_hw);
+	u8 sta_min_spacing = 0;
+	struct cl_sta *cl_sta = IEEE80211_STA_TO_CL_STA(sta);
+
+	if (is_6g)
+		sta_min_spacing =
+			cl_sta_density2usec(le16_get_bits(sta->he_6ghz_capa.capa,
+							  IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START));
+	else if (sta->ht_cap.ht_supported)
+		sta_min_spacing =
+			cl_sta_density2usec(sta->ht_cap.ampdu_density);
+	else
+		cl_dbg_err(cl_hw, "HT is not supported - cannot set sta_min_spacing\n");
+
+	cl_sta->ampdu_min_spacing =
+		max(cl_sta_density2usec(IEEE80211_HT_MPDU_DENSITY_1), sta_min_spacing);
+}
+
+u32 cl_sta_num(struct cl_hw *cl_hw)
+{
+	u32 num = 0;
+
+	read_lock(&cl_hw->cl_sta_db.lock);
+	num = cl_hw->cl_sta_db.num;
+	read_unlock(&cl_hw->cl_sta_db.lock);
+
+	return num;
+}
+
+u32 cl_sta_num_bh(struct cl_hw *cl_hw)
+{
+	u32 num = 0;
+
+	read_lock_bh(&cl_hw->cl_sta_db.lock);
+	num = cl_hw->cl_sta_db.num;
+	read_unlock_bh(&cl_hw->cl_sta_db.lock);
+
+	return num;
+}
+
+struct cl_sta *cl_sta_get(struct cl_hw *cl_hw, u8 sta_idx)
+{
+	if (sta_idx < CL_MAX_NUM_STA)
+		return cl_hw->cl_sta_db.lut[sta_idx];
+
+	return NULL;
+}
+
+struct cl_sta *cl_sta_get_by_addr(struct cl_hw *cl_hw, u8 *addr)
+{
+	struct cl_sta *cl_sta = NULL;
+	u8 hash_idx = CL_STA_HASH_IDX(addr[5]);
+
+	if (is_multicast_ether_addr(addr))
+		return NULL;
+
+	list_for_each_entry(cl_sta, &cl_hw->cl_sta_db.hash[hash_idx], list_hash)
+		if (cl_mac_addr_compare(cl_sta->addr, addr))
+			return cl_sta;
+
+	return NULL;
+}
+
+void cl_sta_loop(struct cl_hw *cl_hw, sta_callback callback)
+{
+	struct cl_sta *cl_sta = NULL;
+
+	/* Go over all stations */
+	read_lock(&cl_hw->cl_sta_db.lock);
+
+	list_for_each_entry(cl_sta, &cl_hw->cl_sta_db.head, list)
+		callback(cl_hw, cl_sta);
+
+	read_unlock(&cl_hw->cl_sta_db.lock);
+}
+
+void cl_sta_loop_bh(struct cl_hw *cl_hw, sta_callback callback)
+{
+	struct cl_sta *cl_sta = NULL;
+
+	/* Go over all stations - use bottom-half lock */
+	read_lock_bh(&cl_hw->cl_sta_db.lock);
+
+	list_for_each_entry(cl_sta, &cl_hw->cl_sta_db.head, list)
+		callback(cl_hw, cl_sta);
+
+	read_unlock_bh(&cl_hw->cl_sta_db.lock);
+}
+
+static int cl_sta_add_to_firmware(struct cl_hw *cl_hw, struct ieee80211_vif *vif,
+				  struct ieee80211_sta *sta)
+{
+	struct cl_sta *cl_sta = (struct cl_sta *)sta->drv_priv;
+	struct cl_vif *cl_vif = (struct cl_vif *)vif->drv_priv;
+	struct mm_sta_add_cfm *sta_add_cfm;
+	int error = 0;
+	u8 recovery_sta_idx = 0;
+	u32 rate_ctrl_info = 0;
+
+	if (cl_recovery_in_progress(cl_hw)) {
+		struct cl_wrs_rate_params *rate_params = &cl_sta->wrs_sta.tx_su_params.rate_params;
+
+		/*
+		 * If station is added to firmware during recovery, the driver passes to firmware
+		 * the station index to be used instead of firmware selecting a free index
+		 */
+		recovery_sta_idx = cl_sta->sta_idx;
+
+		/* Keep current rate value */
+		rate_ctrl_info = cl_rate_ctrl_generate(cl_hw, cl_sta, rate_params->mode,
+						       rate_params->bw, rate_params->nss,
+						       rate_params->mcs, rate_params->gi,
+						       false, false);
+	} else {
+		bool is_cck = cl_band_is_24g(cl_hw) && cl_hw_mode_is_b_or_bg(cl_hw);
+		u8 mode = is_cck ? WRS_MODE_CCK : WRS_MODE_OFDM;
+
+		/*
+		 * Not in recovery:
+		 * firmware will set sta_idx and will return in confirmation message
+		 */
+		recovery_sta_idx = STA_IDX_INVALID;
+
+		/* Default rate value */
+		rate_ctrl_info = cl_rate_ctrl_generate(cl_hw, cl_sta, mode,
+						       0, 0, 0, 0, false, false);
+	}
+
+	/* Must be called before cl_msg_tx_sta_add() */
+	cl_sta_set_min_spacing(cl_hw, sta);
+
+	/* Send message to firmware */
+	error = cl_msg_tx_sta_add(cl_hw, sta, cl_vif, recovery_sta_idx, rate_ctrl_info);
+	if (error)
+		return error;
+
+	sta_add_cfm = (struct mm_sta_add_cfm *)(cl_hw->msg_cfm_params[MM_STA_ADD_CFM]);
+	if (!sta_add_cfm)
+		return -ENOMSG;
+
+	if (sta_add_cfm->status != 0) {
+		cl_dbg_verbose(cl_hw, "Status Error (%u)\n", sta_add_cfm->status);
+		cl_msg_tx_free_cfm_params(cl_hw, MM_STA_ADD_CFM);
+		return -EIO;
+	}
+
+	/* Save the index retrieved from firmware */
+	cl_sta->sta_idx = sta_add_cfm->sta_idx;
+
+	/* Release cfm msg */
+	cl_msg_tx_free_cfm_params(cl_hw, MM_STA_ADD_CFM);
+
+	return 0;
+}
+
+int cl_sta_add(struct cl_hw *cl_hw, struct ieee80211_vif *vif,
+	       struct ieee80211_sta *sta)
+{
+	struct cl_sta *cl_sta = (struct cl_sta *)sta->drv_priv;
+	struct cl_vif *cl_vif = (struct cl_vif *)vif->drv_priv;
+	int error = 0;
+
+	if (cl_radio_is_going_down(cl_hw))
+		return -EPERM;
+
+	if (vif->type == NL80211_IFTYPE_MESH_POINT &&
+	    cl_vif->num_sta >= CL_MAX_NUM_MESH_POINT)
+		return -EPERM;
+
+	cl_sta->cl_vif = cl_vif;
+	cl_mac_addr_copy(cl_sta->addr, sta->addr);
+
+	error = cl_sta_add_to_firmware(cl_hw, vif, sta);
+	if (error)
+		return error;
+
+	if (!cl_recovery_in_progress(cl_hw))
+		if (vif->type != NL80211_IFTYPE_STATION ||
+		    cl_hw->chip->conf->ce_production_mode)
+			_cl_sta_add(cl_hw, vif, sta);
+
+	if (vif->type == NL80211_IFTYPE_MESH_POINT && cl_vif->num_sta == 1)
+		set_bit(CL_DEV_MESH_AP, &cl_hw->drv_flags);
+
+	return 0;
+}
+
+void cl_sta_mgd_add(struct cl_hw *cl_hw, struct cl_vif *cl_vif, struct ieee80211_sta *sta)
+{
+	/* Should be called in station mode */
+	struct cl_sta *cl_sta = (struct cl_sta *)sta->drv_priv;
+
+	/* !!! Must be first !!! */
+	cl_sta_add_to_lut(cl_hw, cl_vif, cl_sta);
+
+	cl_baw_init(cl_sta);
+	cl_txq_sta_add(cl_hw, cl_sta);
+	cl_vns_sta_add(cl_hw, cl_sta);
+
+	/*
+	 * Add rssi of association response to rssi pool
+	 * Make sure to call it before cl_wrs_api_sta_add()
+	 */
+	cl_rssi_assoc_find(cl_hw, cl_sta, cl_hw->cl_sta_db.num);
+
+	cl_connection_data_add(cl_vif);
+
+	/* In station mode we assume that the AP we connect to is static */
+	cl_motion_sense_sta_add(cl_hw, cl_sta);
+	cl_bf_sta_add(cl_hw, cl_sta, sta);
+	cl_wrs_api_sta_add(cl_hw, sta);
+#ifdef CONFIG_CL8K_DYN_MCAST_RATE
+	/* Should be called after cl_wrs_api_sta_add() */
+	cl_dyn_mcast_rate_update_upon_assoc(cl_hw, cl_sta->wrs_sta.mode,
+					    cl_hw->cl_sta_db.num);
+#endif /* CONFIG_CL8K_DYN_MCAST_RATE */
+#ifdef CONFIG_CL8K_DYN_BCAST_RATE
+	cl_dyn_bcast_rate_update_upon_assoc(cl_hw,
+					    cl_sta->wrs_sta.tx_su_params.rate_params.mcs,
+					    cl_hw->cl_sta_db.num);
+
+#endif /* CONFIG_CL8K_DYN_BCAST_RATE */
+	/* !!! Must be last !!! */
+	cl_sta_add_to_list(cl_hw, cl_sta);
+}
+
+static void _cl_sta_remove(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	write_lock_bh(&cl_hw->cl_sta_db.lock);
+
+	list_del(&cl_sta->list);
+	list_del(&cl_sta->list_hash);
+
+	cl_hw->cl_sta_db.lut[cl_sta->sta_idx] = NULL;
+	cl_hw->cl_sta_db.num--;
+	cl_sta->cl_vif->num_sta--;
+
+	cl_dbg_verbose(cl_hw, "mac=%pM, sta_idx=%u, vif_index=%u\n",
+		       cl_sta->addr, cl_sta->sta_idx, cl_sta->cl_vif->vif_index);
+
+	write_unlock_bh(&cl_hw->cl_sta_db.lock);
+}
+
+void cl_sta_remove(struct cl_hw *cl_hw, struct ieee80211_vif *vif, struct ieee80211_sta *sta)
+{
+	struct cl_vif *cl_vif = (struct cl_vif *)vif->drv_priv;
+	struct cl_sta *cl_sta = (struct cl_sta *)sta->drv_priv;
+	u8 sta_idx = cl_sta->sta_idx;
+
+	cl_sta->remove_start = true;
+
+	/* !!! Must be first - remove from list and LUT !!! */
+	_cl_sta_remove(cl_hw, cl_sta);
+
+	cl_traffic_sta_remove(cl_hw, cl_sta);
+	cl_bf_sta_remove(cl_hw, cl_sta);
+	cl_connection_data_remove(cl_vif);
+#ifdef CONFIG_CL8K_DYN_MCAST_RATE
+	cl_dyn_mcast_rate_update_upon_disassoc(cl_hw,
+					       cl_sta->wrs_sta.mode,
+					       cl_hw->cl_sta_db.num);
+#endif /* CONFIG_CL8K_DYN_MCAST_RATE */
+#ifdef CONFIG_CL8K_DYN_BCAST_RATE
+	cl_dyn_bcast_rate_update_upon_disassoc(cl_hw,
+					       cl_sta->wrs_sta.tx_su_params.rate_params.mcs,
+					       cl_hw->cl_sta_db.num);
+#endif /* CONFIG_CL8K_DYN_BCAST_RATE */
+	cl_wrs_api_sta_remove(cl_hw, cl_sta);
+	cl_stats_sta_remove(cl_hw, cl_sta);
+
+	/*
+	 * TX stop flow:
+	 * 1) Flush TX queues
+	 * 2) Poll confirmation queue and clear enhanced TIM
+	 * 3) Send MM_STA_DEL_REQ message to firmware
+	 * 4) Flush confirmation queue
+	 * 5) Reset write index
+	 */
+
+	cl_txq_flush_sta(cl_hw, cl_sta);
+	cl_single_cfm_poll_empty_sta(cl_hw, sta_idx);
+	cl_txq_sta_remove(cl_hw, sta_idx);
+
+	if (cl_vif->vif->type == NL80211_IFTYPE_MESH_POINT &&
+	    cl_vif->num_sta == 0) {
+		clear_bit(CL_DEV_MESH_AP, &cl_hw->drv_flags);
+	}
+
+	cl_single_cfm_flush_sta(cl_hw, sta_idx);
+
+	cl_msg_tx_sta_del(cl_hw, sta_idx);
+
+	if (cl_vif->num_sta == 0)
+		cl_radio_off_wake_up(cl_hw);
+}
+
+void cl_sta_ps_notify(struct cl_hw *cl_hw, struct cl_sta *cl_sta, bool is_ps)
+{
+	struct sta_info *stainfo = IEEE80211_STA_TO_STAINFO(cl_sta->sta);
+
+	/*
+	 * PS-Poll & UAPSD are handled by FW, by setting
+	 * WLAN_STA_SP we ensure mac80211 does not re-handle.
+	 * flag is unset at ieee80211_sta_ps_deliver_wakeup
+	 */
+	if (is_ps)
+		set_sta_flag(stainfo, WLAN_STA_SP);
+
+	cl_stats_update_ps(cl_hw, cl_sta, is_ps);
+}
+
-- 
2.36.1

