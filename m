Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD28532990
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236968AbiEXLlp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236994AbiEXLlj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:41:39 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60044.outbound.protection.outlook.com [40.107.6.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB9DBE8
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:41:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mW7q++whO27S+UNdFQ682IU3M9CvhkwmqmXRfZQ8qg2A1tBl/Y4iSXRPSfrrxUPE2O6V6HITGn8D2jVlUqRaRwj3HLlSbQfgMcXik614y+Zmf8Q9MQnOd6pIY3S6cu0q76yYetcZBdlLXN7uvNwdQNwgK86XfLcFBOlkzGQUQ5YxR04/aR7CxppJs1DReqbNcku2Ov/UnCS4gnXyPt7FkK4xSGkF86WvLF8M7Y34poA9hO/hB9GIAwshjto6HVowJVmkyV5v8rvI602GwZkcqyxylgnHGGnmhEQoCcYy9uStNKcfexdjjARtG94vSt5ONZQ1teuMmFkV/n8hJVwS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdqqG26dssxH+NjXK6D8Jiyj+M5focrYOsTHZ92RRO0=;
 b=nKZXjkg1Ai0fdtnjxPuw0GE+F+q1iL/xroh0anQYkU6ZBkpC2YczIqy1aC9DgOva0GTLDdAOtUnGX8Ep+gb3lweKfcn4ksZynzXXMvKezIQ7kHDMc9KlZdHU1XTLzg6SeqdacRtb4kIH4D9kkRyQXEHVqC4km4QIZ6mNiyJNFnz9rOioEKe+5SVD/JMPkWBoWFbjjdVf45cZ03/78W3SZ+3AHXDuiU6+Zzp3kOCXHcbH8EQumfTZ80qkoqbC/nJAH5tqM5zDe/kg1w3KCPg3QtIVuYBNh19cK9R4ylgWriHuwcJ9ukFlhh1SDHJYJFi36nCWy8LJvYE4zYB2l92Ujg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdqqG26dssxH+NjXK6D8Jiyj+M5focrYOsTHZ92RRO0=;
 b=Jws/eTMzkPt4CakjxEsLcCxa8cVuGMiLlITb55wcRCoYgs7od2xAjE3st68irzkKq1Vec8GQQLtkAFVi5e2dY6GuJmxttocpcc+cnEH38zz6WzclTMcTOnJISGNXqNw9EuX/Cbdrl9GbeM3j3IpRH/P+5crNSVrjgeajtpsbquw=
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
Subject: [RFC v2 75/96] cl8k: add sta.h
Date:   Tue, 24 May 2022 14:34:41 +0300
Message-Id: <20220524113502.1094459-76-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 81f910f5-b922-4792-ba72-08da3d79f895
X-MS-TrafficTypeDiagnostic: AM8P192MB0915:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM8P192MB0915E157345FE0100DABA577F6D79@AM8P192MB0915.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WA8vAtq5JgfXY4MMQeyO2/ebhCbTpgLWdOqIESVKXonJxeBGFsAM8Rmq9CKrTp5yA0PWKfVcgtQeBci0lq20VkEgTgeectTMF5CFcHxR4USIT/4yTfhxHQVOHZ9bu2npk7dXGB8d7zHTsvu3WLYFQHwybmcplloKo56SKH1jCe1hCbzQoDmNnaxeNlic6jFElDFalRcCwsLzp/geKlTvj0Yw4xxj8HJg5VKKalvp/9H0DXjlTVYR/ngYltijKsXYADzhCf28X7ei67z3EeqVRT/hxBB6U8NvtTfpgnRLP2eC8W+7LRlBCvStsw6oD+L+4SXktgRLz1Jtxe5D1XneWaF59HzGJ9YRRokpQS0fadJm6Lr1p1Myjga1mCPGnJ1sdQiF1YGXVj9KfGEcPjxRs0MwQ80YsXVznK9863lQ3getN++lK7t/37TUpJB1M3b6q+8KTa34jBUUHkzcdqZZw3J+gL0qbcFhw9pV6lPnA8UDPxceQ5Lf5AGDK3TTTMgwmAb0qUiq1q0O66l9x5ffqDk0Dy2P3rE+fFh8KO0KGMC1tq8eLvOkLBdgUiPKiJwSdrQudAK66ze2zugnrJfOnESoOpzZdycTm7yW1lDmT2pRqBuGWbj/5SnZAxmROvgo9NHaXcV3K8rIq0PJ09Rp+CmWJcIp1bOkYZxy3P0iZD8JBEQBx+cf0+oYa7fZFwp2WE6uTczsjtJVhIsvGhgCT7FQhPkRj6RNJi4lRsqK2r0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(376002)(346002)(39850400004)(83380400001)(54906003)(186003)(36756003)(107886003)(2906002)(2616005)(1076003)(6916009)(41300700001)(66946007)(8936002)(6666004)(9686003)(66476007)(26005)(86362001)(66556008)(5660300002)(6512007)(4326008)(38350700002)(316002)(6506007)(52116002)(8676002)(6486002)(38100700002)(508600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lNfcHJpsfyLRLRXogVVyVPRpAzG0H87ptVEefTCVm4WNdogwd3iWKfzan5B5?=
 =?us-ascii?Q?4EFsqfdRWq0nq3IdCN7ZhxKBwH7qWncV5ffRvKGiffe5IzT1OtvkreLFm5Jf?=
 =?us-ascii?Q?hVWXXUDpk2ztjNUevlpISyjrlFk0z/YQPODwkBr9St8QyAbDjHIwg3G8uOKE?=
 =?us-ascii?Q?m9kRP3uKivh+mRpU+G/9IOpOZJp8a8EmcMbotsDyugd1WsME66mHHh3FXpPc?=
 =?us-ascii?Q?FB9RGI3Aby5e8AfRKMnwfg1yEfZKjb1enmb1hBRW9dQrdYisRZKsU8FaY+kR?=
 =?us-ascii?Q?dU6l1Y3PEaRnVU1SeyNW6x0D7IARu7FR0VWLPxq1rEY7oWh4N4gBVUgNJGmg?=
 =?us-ascii?Q?YNBqt/z6kN+hbYDyEImAXivCv7osIIQJh7QS1GHaBXuMZ33M1Q+ic0jHbqK8?=
 =?us-ascii?Q?iVaK4D1WMqF8YssceOc8YFNlVtrq7HAnE+vRV7ifiFU2R+VPDBzlqGW4hvvH?=
 =?us-ascii?Q?uYpPRgRHPVA+Vep7Bhfl4wAyZ5H3DUB85FbGYrD42O9M5cwpoZ5CvgEOOya3?=
 =?us-ascii?Q?83A4PS9vRfJ5571LRge6xknYAjus5KxsvA3Pr7GoAN/1TpREk8jeuKUIUdDZ?=
 =?us-ascii?Q?TeSK9+AwGh91Yhw1UHNLzgduJo7nvmxjE42W9V2EENEZnfUV1rpCtERpDlKc?=
 =?us-ascii?Q?Wr3QpUWs39sF5IXcA7rJe0CI6cVUEYLDM81aNpQutcXXGfL6rOkJphsSlpk7?=
 =?us-ascii?Q?CqkIeWD3mvpLVgQ39w7ZEn9hmrrwLaNUUMRDCqtu57wZUwCLucYn/Y/WcvWv?=
 =?us-ascii?Q?CpoXtuZjXm51qvb95mf8IKLVzNCJlZbW2RXRbm58cRqnT8cZSk5a/SNW2xOh?=
 =?us-ascii?Q?kPZTMH9deyu4uNsXD/tTXAK9lqKcgt40rELSlMCCS2zWLgahWX7R8o3UyG5a?=
 =?us-ascii?Q?u5B0K4SZWfr51mcPpst+eDB0DK/IKcEHreBcgsozkAf4dxEunvluiwJjPU/o?=
 =?us-ascii?Q?/a8d5BKte901MF9PEmPzqqIb3B8jy7Uhox+ZfdoO3zE3EMmevLozmX8VM6gf?=
 =?us-ascii?Q?YhxFC69GOyPKgXCWMafdFYHSBG1Fh0dTM1StTHI27xqG2GRSDtRNedtTCsDP?=
 =?us-ascii?Q?3CEnlkWtB1kVnR/NQ0kFmKC/Wu7NROaXvDuvmvLkfNuP6pvQvKPsCXbn3y3U?=
 =?us-ascii?Q?8YlLPCwhmLJ261fXGWjv+k56wu6PYdqmOwjmAP+PgtJL3EXYM4afVl+ONxck?=
 =?us-ascii?Q?RN62hjpA9AJDNOJ7IfFuhGYOMZqU/zAWBBfIBPfl9KxQabCOS+wrTLizhEYz?=
 =?us-ascii?Q?Yr4NowccIxyfYoo9Q6C9JCKt4neBjVgBt0/xN3amJrI4EMgY1/sZY0h18uDd?=
 =?us-ascii?Q?ZqV4OfYgdaKMm0Es4G8y7ED61itEIlku80eAlxubfDb1aBl7G9nFSNJLqy7u?=
 =?us-ascii?Q?Ik3v+mqFyQWyvnTYyVLAuByGxTLLnpG9QisJ5tuSV/Bn3V8v8i4EprpFffFs?=
 =?us-ascii?Q?JqCcYd4dpXvQlfXKeZ/DdxRB6uWQauOAsQB3ISsodfIh+BMHpQrNEBOLXo4v?=
 =?us-ascii?Q?ZRv6CXwcy1rYz1DVSx2Sp2rK8yNs9l0S1mheFFk2ydf+zlJhHw9JqA2EC4k2?=
 =?us-ascii?Q?J1YG7pb7E+oVTTRhYQdg0NZGosm56vOgAXYnhRG5vnbV8MtQFiTvB7gjIloc?=
 =?us-ascii?Q?xPt10VUA4Pjacy5DxAwZyumyVfD5DQW47lNXtkdE//sdpL7po3D5J/K1HCOu?=
 =?us-ascii?Q?JGN5QZpHGtic4YMe0HDLQ4o3Qp+ReOEBaH8JCuL05C7ODiEK4RKSJsm/IR1i?=
 =?us-ascii?Q?CcgBECojSwCEGoJB7zrbRli0USA0vsQ=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f910f5-b922-4792-ba72-08da3d79f895
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:49.8808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0s3pTD7PeyYhlIQ2WqqnIUt2c1a+jqsDKMENekriw4F+jn96xeFf3UigxVi2sIpvXBmqCmbNJ0gIIyEf2yXr6w==
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
 drivers/net/wireless/celeno/cl8k/sta.h | 99 ++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/sta.h

diff --git a/drivers/net/wireless/celeno/cl8k/sta.h b/drivers/net/wireless/celeno/cl8k/sta.h
new file mode 100644
index 000000000000..f3c6bc743b96
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/sta.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_STA_H
+#define CL_STA_H
+
+#include "sta_info.h"
+#include "mac80211.h"
+#include "rates.h"
+#include "motion_sense.h"
+#include "tx.h"
+#include "traffic.h"
+#include "bf.h"
+#include "vns.h"
+
+#define IEEE80211_STA_TO_CL_STA(sta) ((struct cl_sta *)(sta)->drv_priv)
+#define IEEE80211_STA_TO_STAINFO(ieee80211_sta) (container_of(ieee80211_sta, struct sta_info, sta))
+
+#define CL_MAX_NUM_MESH_POINT 8
+
+/*
+ * Structure used to save information relative to the managed stations.
+ * Will be used as the 'drv_priv' field of the "struct ieee80211_sta" structure.
+ */
+struct cl_sta {
+	struct list_head list;
+	struct list_head list_hash;
+	u8 sta_idx;
+	u8 su_sid;
+	bool key_disable;
+	u8 addr[ETH_ALEN];
+	struct cl_baw baws[IEEE80211_NUM_TIDS];
+	struct cl_amsdu_ctrl amsdu_anchor[IEEE80211_NUM_TIDS];
+	struct cl_tx_queue *agg_tx_queues[IEEE80211_NUM_TIDS];
+	u8 rx_pn[IEEE80211_NUM_TIDS][IEEE80211_CCMP_PN_LEN];
+	struct cl_vif *cl_vif;
+	struct ieee80211_sta *sta;
+	struct ieee80211_key_conf *key_conf;
+	struct cl_bf_sta_db bf_db;
+	struct cl_stats *stats;
+	s32 alpha_rssi;
+	bool manual_alpha_rssi;
+	s8 last_rssi[MAX_ANTENNAS];
+	u8 ampdu_min_spacing;
+	struct cl_traffic_sta traffic_db[TRAFFIC_DIRECTION_MAX];
+	struct cl_traffic_mon traffic_mon[CL_TRFC_MON_PROT_MAX][CL_TRFC_MON_DIR_MAX];
+	struct cl_vns_sta_db vns_db;
+	u32 retry_count;
+	u32 data_pending[AC_MAX];
+	struct cl_wrs_info wrs_info_tx_su;
+	struct cl_wrs_info wrs_info_tx_mu_mimo;
+	struct cl_wrs_info wrs_info_rx;
+	struct cl_wrs_rssi wrs_rssi;
+	bool add_complete;
+	bool remove_start;
+	struct cl_wrs_sta wrs_sta;
+	struct cl_motion_sense motion_sense;
+	union cl_rate_ctrl_info_he rate_ctrl_he;
+	bool tf_support_dis;
+	struct cl_tid_ampdu_rx *tid_agg_rx[IEEE80211_NUM_TIDS];
+	u64 tx_bytes;
+	u64 rx_bytes;
+	bool stop_tx;
+	bool pause_tx;
+
+};
+
+#define CL_STA_HASH_SIZE (CL_MAX_NUM_STA / 2)
+#define CL_STA_HASH_MASK (CL_STA_HASH_SIZE - 1)
+#define CL_STA_HASH_IDX(x) ((x) & CL_STA_HASH_MASK)
+
+struct cl_sta_db {
+	struct list_head head;
+	struct cl_sta *lut[CL_MAX_NUM_STA];
+	struct list_head hash[CL_STA_HASH_SIZE];
+	rwlock_t lock;
+	u32 num;
+};
+
+typedef void (*sta_callback)(struct cl_hw *, struct cl_sta *);
+
+/* These functions take the lock inside */
+u32 cl_sta_num(struct cl_hw *cl_hw);
+u32 cl_sta_num_bh(struct cl_hw *cl_hw);
+
+/* Must take lock before calling these functions */
+struct cl_sta *cl_sta_get(struct cl_hw *cl_hw, u8 sta_idx);
+struct cl_sta *cl_sta_get_by_addr(struct cl_hw *cl_hw, u8 *addr);
+
+void cl_sta_init(struct cl_hw *cl_hw);
+void cl_sta_loop(struct cl_hw *cl_hw, sta_callback callback);
+void cl_sta_loop_bh(struct cl_hw *cl_hw, sta_callback callback);
+void cl_sta_init_sta(struct cl_hw *cl_hw, struct ieee80211_sta *sta);
+int cl_sta_add(struct cl_hw *cl_hw, struct ieee80211_vif *vif, struct ieee80211_sta *sta);
+void cl_sta_mgd_add(struct cl_hw *cl_hw, struct cl_vif *cl_vif, struct ieee80211_sta *sta);
+void cl_sta_remove(struct cl_hw *cl_hw, struct ieee80211_vif *vif, struct ieee80211_sta *sta);
+void cl_sta_ps_notify(struct cl_hw *cl_hw, struct cl_sta *cl_sta, bool is_ps);
+
+#endif /* CL_STA_H */
-- 
2.36.1

