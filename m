Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D5C532988
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbiEXLmE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236984AbiEXLk6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:40:58 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60067.outbound.protection.outlook.com [40.107.6.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DE28D6AC
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:40:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sj2PBQ5SDS9u+ud60n3gX29n+Syybu8HjDOzrAaoiLB9vU/YIo4dZcStc3kURX9r10oO/hYzc68yBNV+HpAIoW/09Sl/Vm7bFm21iba4tUPRWcnrZurGSYKW/j8BlVh/hKFuJbYasGcojcfkWq9Gl6hYZWAnLuaqHNHALzGcqiMj94lK7inPWAv3wBY2DQegNH9VYr+f+wdqm+K058VvRzma/OUdtccnuYj3Amn+VPQkUOuaYkyuwWaMEwKSFhj5H6ysiXQeDN33g+S8guIAZtF4/cciaY8eAcCHXsvYGeUsVGCZVQHrb8SOAqknK7F7z1GVJPgYWFwFlnDf2yUsaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWPv2bBc/3vHcY8w0lhcSHgUwFeyFMSeAZDvhG4Mirc=;
 b=KPvXBtfMsVEHQLziAqT8Wl8OSlvNuxi3M49Fsto3RJNbAbNKVSYHvtcHE0ZBMzqXV+kdh0HHuf8p8x0KV1T/pFB/1hMq0k/ytl4z8S4tuLjMpW2F8Z4jetHM6y278sgi0dbKw3AJB96YOiABJe4SLMPcxBZMGwe2+NVNcxcDccVtgAhf2HUP6ZglTjhhx1pdBuDM6qj/lM7O3NcN2aQ6iPOHK01PNdDeksIXzbriaknOk2Vih5BKbMI9YhqWY2YvPwp/5rpPhKcbZ0ygjySbTrzh2lEZg9tM6kwQljyP+6x+yJUT9v8xAmPLxBnMnaldJyamQPhs4ulKTtBOJ2Sr1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWPv2bBc/3vHcY8w0lhcSHgUwFeyFMSeAZDvhG4Mirc=;
 b=zo/zi2wak0TosQxPs16UuPW1Jn2HCd/2WtMkTlscTyqXwwex/UYc5MVYFclWjcGZOhCB5XzqOEslJ+r+OFOPehKHcfnS+uzJt3ZwmLv5f/LnbR93XxIhWx4ToBh9dLOYwQWuxKmyiZFRPJS8YdKBW/eYviYZaI8vpZL54yUQCrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0915.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 24 May
 2022 11:39:25 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:25 +0000
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
Subject: [RFC v2 68/96] cl8k: add rx.c
Date:   Tue, 24 May 2022 14:34:34 +0300
Message-Id: <20220524113502.1094459-69-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: f11bf062-e223-4200-a3c3-08da3d79f51e
X-MS-TrafficTypeDiagnostic: AM8P192MB0915:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM8P192MB0915C694DA8616941AE7E11DF6D79@AM8P192MB0915.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 10hvZMv6slXztpl7Y5dNZ2kdvaRZX09tvBs1ElVdj0PpDckLyf9+riWeMyRZQKy5ZMke+D7sDS4wh3X9FQUc5Lb3zGmR6lrTgCrww+u8KMzb7KAEmAVJyWISIFJzG9mMZZBm4OlaoQ6Txv4sG/o1ZfPJnNyG7CpCuWIHHNmMmmb2yyDgs1/rtmLn3NugyQAf5Y9UyoVfxLVNv8qqwU0R7e77QO4PtfL6no70pq+uI1MlQwNj+It8bV83IBfa4JlKiWxABoCJ3/2uvfGgu7M6lfWh2XEpUqa7QUkgeVlpI8fJaQvjQ75TcciSQfn+5c+sMHDJBjHtxymIpncOgLGz41w19ufNRPFYeRZmmdRTGgLFtt70W1HVhsj2dwu/Q9auIXcDvraiulzmeaRYeCe3Nm0l7cYCQ3JMd4SoWiyWC6gswAF3GV8s3Dqnr77SmdMxfTLRkmGro+LMZ3UdfS2AaFHkdCOT6kr/rXO8P6l9EZokFVi61t8SkEvuSdSqx7m6lmSG0r4QT5jVbS00lwXs2ms5YQsHZVd9QMUCcCjUTO6YeQaKq3/omhGRc8v37hMsbst6X48hAiv97BWoenuCVaDMjL55DcFIXWIb7zDfWU97AgqtbJwpR+IarEVJtDvL6DWbGg6OiSRnCUO93tQOI/Cmr2D1myhmS2s16RFIVODgNvXtxfTId7b3XnBFHtF+V6j9ut5YYrwCprfQK9ndS6VJANK20q4CFOSJGNwZO98=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(376002)(346002)(39850400004)(83380400001)(54906003)(186003)(36756003)(107886003)(2906002)(2616005)(30864003)(1076003)(6916009)(41300700001)(66946007)(8936002)(6666004)(9686003)(66476007)(26005)(86362001)(66556008)(5660300002)(6512007)(4326008)(38350700002)(316002)(6506007)(52116002)(8676002)(6486002)(38100700002)(508600001)(32563001)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6jIU/ZfCc/3kfOflmYyIOl6z5jefCHeI0D8X5v5NoIQxz9vXsK9mjgrt9IvP?=
 =?us-ascii?Q?y7SJ2hsfz7hK3skj+FpK4MT5gKM0k7InkI1lYwQDgYl6mKRw3H1sNXDZEOHu?=
 =?us-ascii?Q?cGuj2auz6n0VbjxWOMquOZECwl59BYRTzq6VFawiGwJguNruT7tiWx4om9CR?=
 =?us-ascii?Q?/ngUDkFfmu9bu/uLz6wjThFXJNzdgWDCk7sf2Zwoh8a56jdDZzYqa0vStONW?=
 =?us-ascii?Q?fATZWPF57F3AU9JNmucnanaJe3lSeFT8FGgNeVKO/PeQfY/29m4CazT4BEIW?=
 =?us-ascii?Q?9FF4WlePP5O3Rq9Tu7U2vwufK77Sloc0aWT7wmC9Ye6unXsz6ulpyotmt4pl?=
 =?us-ascii?Q?6IecVuYQVYFxXNRbYUNdVK9WJTUFNcMPwNo0xaaY860hZNqln0vZtY5QRZuI?=
 =?us-ascii?Q?moGb1j7Ry6AoAuj4P/YFLNC5EJyt0Qrg27VX5LGo8dk3YOWvfIBvTeyeteLP?=
 =?us-ascii?Q?GrzV4aq5XPHWTewdXl1nUnohVJxroQo96iu/nnt7qqLop/d9NKG9A/vo1rjc?=
 =?us-ascii?Q?z3PnDQ312u7MSvdKiuzn/+pOrINwIESwawGjjMD+5n2QU/KbU9e3qSmWaVQf?=
 =?us-ascii?Q?u03v33ah/MW6O1uoMJ49aWzR03QjDU8UWvvnkYHqecxXklb+NVIFCq/5Lagc?=
 =?us-ascii?Q?sVJOaLdXWDEpSoOzbec3R7CWMhKaywq3eMOP+2kkfwutdGc33QUeE+sCDtMU?=
 =?us-ascii?Q?49awEVU+H8Dh+eAJDm2NMSuXs2raNT+CpwHIcBVQ3+5bEfcfIMheyIB0rlxJ?=
 =?us-ascii?Q?hVEP1EzsnuaQ7k01yvShzgOFzwrIZZzmtE5ZzMl7dJvaTBDPWyrsbtDIaA9K?=
 =?us-ascii?Q?BTS0daE8PkAlEpPoPziGLmndFvAzTZXulpcDNTeeNYZMfuhdzxYyeEsSjYdR?=
 =?us-ascii?Q?/QOyifGJ9OeNy0Y3CRhP4cwLIipl+BLeBFY6dJooQarRUE/7bf6Mf0G5XisQ?=
 =?us-ascii?Q?3j2/xVYRZD1Mg56pgN1oD/8t+adctBmljLqPsd5GD+OPNKHZ3nvUvW/EBLj0?=
 =?us-ascii?Q?bwy6866D8fcA3xVBl2/xSNrrozDmtsBOYFhVN5xFb1uU9KcDsv9XJPcOXjqy?=
 =?us-ascii?Q?gqVdSEE9YphKXiBjidsf3BzxAvnkYh9qMaQuCgLim9Q/pp1czv1LeSRIWNqI?=
 =?us-ascii?Q?Mg89kr6con3EgSKW4wMeCr9zZO6pJbEwXtN0PwThls0I1c2XsP8XCDzbSVqV?=
 =?us-ascii?Q?D1IuL9aN9JjxxL5auEyw3SRCH4Kdk4729HjOq5gj+2ih4pHvW89itHJwOxgW?=
 =?us-ascii?Q?+AvP4EgQR/TltEi2xRnoNMmN8z6HzAn1cmODcrckkomZAaNdWIV2VRppnKO0?=
 =?us-ascii?Q?JK0aSmfzR+cPI6T+a/NHl1n/1Y/MGU8ICKZBHlDV9PIFkpfy33Iwo1u+ZU7S?=
 =?us-ascii?Q?e16ctGVHqamrArqKoWkNvsJE5yoqioOWydmWz+mi8qamZ9YlRCCPTUiKUUeu?=
 =?us-ascii?Q?oP6/SK17FnfQfyslCfBZ1CnXGI7okd/iRkoTzFi7pRoCHnt+RpVDyTwLRv9r?=
 =?us-ascii?Q?qBvZ7t3U68VXluA60sxyqw0I9bODKuCs0fzOO94D1Gn1hjwXHEgAyVH8pmFb?=
 =?us-ascii?Q?/Iz3Ut4HSJQODU8tG0ycqLDqcCqTnnPfH+Bz6CeeSzEfCPgKPAD0PHXIiDT/?=
 =?us-ascii?Q?YPQrOfRKlFSIG+GtMKVFNF7llWSbxU27XDJ8ydBoder7zpQvfQ1U/7olelt5?=
 =?us-ascii?Q?Rov/mai5ppnM8DnGVPBoXndm9n5TTVTBYHBLJqkPyGids5YyJo1RwnNDja3c?=
 =?us-ascii?Q?bqU859fuvrMIWRrVewQoOh/0IJ6y2+E=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11bf062-e223-4200-a3c3-08da3d79f51e
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:44.1776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTJRVPkKc0rQVaFd0HDt1/0CW9dpMK6UuWZ+OHPp2NKUb++j3jGTVWBkZnbPX1wjssrA8hxd+NBMNwUItH69Xw==
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
 drivers/net/wireless/celeno/cl8k/rx.c | 1845 +++++++++++++++++++++++++
 1 file changed, 1845 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/rx.c

diff --git a/drivers/net/wireless/celeno/cl8k/rx.c b/drivers/net/wireless/celeno/cl8k/rx.c
new file mode 100644
index 000000000000..b10c9b80fc06
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/rx.c
@@ -0,0 +1,1845 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include <linux/skbuff.h>
+#include <net/mac80211.h>
+
+#include "tx.h"
+#include "stats.h"
+#include "rates.h"
+#include "vns.h"
+#include "dfs.h"
+#include "recovery.h"
+#include "def.h"
+#include "mac80211.h"
+#include "reg/reg_defs.h"
+#include "key.h"
+#include "utils.h"
+#include "radio.h"
+#include "vif.h"
+#include "rx.h"
+
+/* Must correspond to FW definition of MM_SEC_DEFAULT_KEY_COUNT */
+#define MM_SEC_DEFAULT_KEY_COUNT 64
+
+#define VHT_MCS_MASK 0x0F
+#define VHT_MCS_OFT  0
+
+/* Number of entries in HW legacy rate conversion table */
+#define LEGACY_RATE_MAX 16
+#define KSR_MGTK_BCAST_OFFSET 31
+#define KSR_BLOCK_SIZE 4
+
+static const s8 legacy_rates_lut[LEGACY_RATE_MAX] = {
+	0,      /* 0: 1 Mbps   */
+	1,      /* 1: 2 Mbps   */
+	2,      /* 2: 5.5 Mbps */
+	3,      /* 3: 11 Mbps  */
+	-1,     /* 4: Invalid  */
+	-1,     /* 5: Invalid  */
+	-1,     /* 6: Invalid  */
+	-1,     /* 7: Invalid  */
+	10,     /* 8: 48 Mbps  */
+	8,      /* 9: 24 Mbps  */
+	6,      /* 10: 12 Mbps */
+	4,      /* 11: 6 Mbps  */
+	11,     /* 12: 54 Mbps */
+	9,      /* 13: 36 Mbps */
+	7,      /* 14: 18 Mbps */
+	5       /* 15: 9 Mbps  */
+};
+
+/*
+ * rx_skb_cnt is an atomic counter that tracks the total number of skbs in
+ * the entire host.
+ * The counter is incremented when skb is allocated, and freed when the skb
+ * is freed (=destructor function called).
+ * Therefore the counter is global (and not part of cl_hw or cl_chip).
+ *
+ * rx_skb_max is the configured to:
+ * max(chip0->conf->ci_rx_skb_max, chip1->conf->ci_rx_skb_max)
+ */
+static atomic_t rx_skb_cnt = ATOMIC_INIT(0);
+static u32 rx_skb_max;
+
+static void cl_rx_skb_destructor(struct sk_buff *skb)
+{
+	atomic_dec(&rx_skb_cnt);
+}
+
+static void cl_rx_skb_success(struct cl_vif *cl_vif, struct ieee80211_hdr *hdr,
+			      u32 rx_packets, u32 rx_bytes)
+{
+	if (cl_vif) {
+		u8 ac = cl_rx_get_skb_ac(hdr);
+
+		cl_vif->trfc_cntrs[ac].rx_packets += rx_packets;
+		cl_vif->trfc_cntrs[ac].rx_bytes += rx_bytes;
+	}
+}
+
+static DEFINE_PER_CPU(struct tasklet_struct, rx_remote_tasklet_mac[TCV_TOTAL]);
+
+static call_single_data_t csd_rx_remote_cpu_mac[TCV_TOTAL];
+static void cl_rx_remote_cpu_mac(struct cl_hw *cl_hw)
+{
+	int cpu = cl_hw->conf->ci_rx_remote_cpu_mac;
+	struct tasklet_struct *t = csd_rx_remote_cpu_mac[cl_hw->idx].info;
+
+	if (!test_bit(TASKLET_STATE_SCHED, &t->state))
+		smp_call_function_single_async(cpu, &csd_rx_remote_cpu_mac[cl_hw->idx]);
+}
+
+static int cl_rx_check_err(struct cl_hw *cl_hw, struct sk_buff *skb, struct hw_rxhdr *rxhdr)
+{
+	u32 status;
+
+	if (rxhdr->frm_successful_rx)
+		return 0;
+
+	/* The status field is in offset of 14 u32's */
+	status = *((u32 *)rxhdr + 14);
+
+	/* Ignore phy errors and do not drop the packet */
+	if (rxhdr->phy_err) {
+		cl_hw->radio_stats[CL_RADIO_PHY_ERROR]++;
+		cl_dbg_warn(cl_hw, "phy_err (status 0x%x)\n", status);
+		return 0;
+	}
+
+	/* From this point and on, drop the erroneous packets */
+	if (rxhdr->fcs_err) {
+		cl_hw->radio_stats[CL_RADIO_FCS_ERROR]++;
+		cl_dbg_err(cl_hw, "fcs_err (status 0x%x)\n", status);
+	}
+
+	if (rxhdr->rx_fifo_oflow) {
+		cl_hw->radio_stats[CL_RADIO_RX_FIFO_OVERFLOW]++;
+		cl_dbg_err(cl_hw, "rx_fifo_oflow (status 0x%x)\n", status);
+	}
+
+	if (rxhdr->undef_err) {
+		cl_hw->radio_stats[CL_RADIO_UNDEFINED_ERROR]++;
+		cl_dbg_err(cl_hw, "undef_err (status 0x%x)\n", status);
+	}
+
+	if (rxhdr->addr_mismatch) {
+		cl_hw->radio_stats[CL_RADIO_ADDRESS_MISMATCH]++;
+		cl_dbg_err(cl_hw, "addr_mismatch (status 0x%x)\n", status);
+	}
+
+	if (rxhdr->amsdu_present && rxhdr->msdu_cnt > 1)
+		cl_rx_amsdu_set_state_error(cl_hw, rxhdr, RX_AMSDU_ERR_NOT_SUCCESS);
+
+	cl_hw->rx_info.pkt_drop_not_success++;
+	cl_rx_skb_error(cl_hw);
+	kfree_skb(skb);
+
+	return -EBADMSG;
+}
+
+static u8 chnl_bw_to_rate_info_bw[CHNL_BW_MAX] = {
+	[CHNL_BW_20] = RATE_INFO_BW_20,
+	[CHNL_BW_40] = RATE_INFO_BW_40,
+	[CHNL_BW_80] = RATE_INFO_BW_80,
+	[CHNL_BW_160] = RATE_INFO_BW_160,
+};
+
+static u8 chnl_bw_factor[CHNL_BW_MAX] = {
+	[CHNL_BW_20] = 0,
+	[CHNL_BW_40] = 3,
+	[CHNL_BW_80] = 6,
+	[CHNL_BW_160] = 9,
+};
+
+static int cl_rx_fill_status(struct cl_hw *cl_hw, struct cl_sta *cl_sta, struct sk_buff *skb,
+			     struct hw_rxhdr *rxhdr, u8 *encrypt_len)
+{
+	s8 rssi[MAX_ANTENNAS] = RX_HDR_RSSI(rxhdr);
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
+	u8 tid = ieee80211_get_tid(hdr);
+
+	memset(status, 0, sizeof(struct ieee80211_rx_status));
+
+	status->mactime = ((u64)le32_to_cpu((rxhdr->tsf_hi)) << 32) | le32_to_cpu(rxhdr->tsf_lo);
+	status->flag |= RX_FLAG_MACTIME_END;
+
+	if (cl_sta && cl_sta->tid_agg_rx[tid])
+		status->flag |= RX_FLAG_DUP_VALIDATED;
+
+	status->antenna = rxhdr->antenna_set;
+	status->band = cl_band_from_fw_idx(rxhdr->phy_band);
+
+	if (rxhdr->format_mod >= FORMATMOD_HE_SU) {
+		status->encoding = RX_ENC_HE;
+		status->rate_idx = (rxhdr->mcs & VHT_MCS_MASK) >> VHT_MCS_OFT;
+		status->nss = rxhdr->n_sts + 1;
+
+		/* he_gi expectes to get values according to enum nl80211_he_gi */
+		status->he_gi = cl_convert_gi_format_wrs_to_fw(WRS_MODE_HE, rxhdr->gi_type);
+	} else if (rxhdr->format_mod == FORMATMOD_VHT) {
+		status->encoding = RX_ENC_VHT;
+		status->rate_idx = (rxhdr->mcs & VHT_MCS_MASK) >> VHT_MCS_OFT;
+		status->nss = rxhdr->n_sts + 1;
+
+		if (rxhdr->gi_type)
+			status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+	} else if (rxhdr->format_mod == FORMATMOD_HT_GF) {
+		status->encoding = RX_ENC_HT;
+		status->enc_flags |= RX_ENC_FLAG_HT_GF;
+		status->rate_idx = rxhdr->mcs;
+
+		if (rxhdr->gi_type)
+			status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+
+	} else if (rxhdr->format_mod == FORMATMOD_HT_MF) {
+		status->encoding = RX_ENC_HT;
+		status->rate_idx = rxhdr->mcs;
+
+		if (rxhdr->gi_type)
+			status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+	} else {
+		if (legacy_rates_lut[rxhdr->leg_rate] != -1)
+			status->rate_idx = legacy_rates_lut[rxhdr->leg_rate];
+		if (status->band != NL80211_BAND_2GHZ)
+			status->rate_idx -= RATE_CTRL_OFFSET_OFDM;
+		if (!rxhdr->pre_type)
+			status->enc_flags |= RX_ENC_FLAG_SHORTPRE;
+	}
+
+	if (rxhdr->aggregation) {
+		status->flag |= RX_FLAG_AMPDU_DETAILS;
+		status->ampdu_reference = rxhdr->ampdu_cnt;
+	}
+
+	/*
+	 * Set bw field
+	 */
+	if (rxhdr->ru_type) {
+		status->bw = RATE_INFO_BW_HE_RU;
+
+		if (rxhdr->ru_type == CL_MU_OFDMA_RU_TYPE_26)
+			cl_rssi_bw_adjust(cl_hw, rxhdr, -9);
+		else if (rxhdr->ru_type == CL_MU_OFDMA_RU_TYPE_52)
+			cl_rssi_bw_adjust(cl_hw, rxhdr, -6);
+		else if (rxhdr->ru_type == CL_MU_OFDMA_RU_TYPE_106)
+			cl_rssi_bw_adjust(cl_hw, rxhdr, -3);
+
+		status->he_ru = cl_ru_type_to_nl80211_he_ru_alloc(rxhdr->ru_type);
+	} else {
+		u8 factor = chnl_bw_factor[rxhdr->ch_bw];
+
+		status->bw = chnl_bw_to_rate_info_bw[rxhdr->ch_bw];
+		cl_rssi_bw_adjust(cl_hw, rxhdr, factor);
+	}
+
+	/*
+	 * TODO: check if when a frame is received on 40MHz or more bandwidth,
+	 * we need to take the center1_freq instead of the prim20_freq
+	 */
+	status->freq = Q2_TO_FREQ(rxhdr->phy_prim20_freq);
+
+	status->signal = cl_rssi_calc_equivalent(cl_hw, rssi);
+
+	switch (rxhdr->decr_status) {
+	case CL_RX_HDR_DECR_UNENC:
+		if (!ieee80211_has_protected(hdr->frame_control))
+			break;
+
+		cl_dbg_warn(cl_hw, "Protected frame unencrypted\n");
+		cl_hw->rx_info.pkt_drop_unencrypted++;
+		if (rxhdr->amsdu_present && rxhdr->msdu_cnt > 1)
+			cl_rx_amsdu_set_state_error(cl_hw, rxhdr,
+						    RX_AMSDU_ERR_UNENCRYPTED);
+		return -EBADMSG;
+	case CL_RX_HDR_DECR_ICVFAIL:
+	case CL_RX_HDR_DECR_AMSDUDISCARD:
+	case CL_RX_HDR_DECR_NULLKEY:
+	case CL_RX_HDR_DECR_CCMPFAIL:
+		cl_dbg_warn(cl_hw, "Decryption failed (%u)\n", rxhdr->decr_status);
+		cl_hw->rx_info.pkt_drop_decrypt_fail++;
+		*encrypt_len = 0;
+		if (rxhdr->amsdu_present && rxhdr->msdu_cnt > 1)
+			cl_rx_amsdu_set_state_error(cl_hw, rxhdr, RX_AMSDU_ERR_DECRYPT_FAIL);
+		return -EBADMSG;
+	case CL_RX_HDR_DECR_WEPSUCCESS:
+	case CL_RX_HDR_DECR_TKIPSUCCESS:
+		*encrypt_len = IEEE80211_WEP_ICV_LEN;
+		status->flag |= (RX_FLAG_DECRYPTED | RX_FLAG_ICV_STRIPPED);
+		break;
+	case CL_RX_HDR_DECR_CCMPSUCCESS:
+		*encrypt_len = IEEE80211_CCMP_HDR_LEN;
+		status->flag |= (RX_FLAG_DECRYPTED | RX_FLAG_MIC_STRIPPED);
+		break;
+	}
+
+	return 0;
+}
+
+static void cl_rx_handle_mesh_reconnect(struct cl_hw *cl_hw,
+					struct ieee80211_mgmt *mgmt, struct cl_sta *cl_sta)
+{
+	struct ieee80211_sta *sta = cl_sta->sta;
+	struct cl_tx_queue *tx_queue;
+	u8 action_code = mgmt->u.action.u.self_prot.action_code;
+	u8 i;
+
+	if (action_code == WLAN_SP_MESH_PEERING_CONFIRM) {
+		for (i = 0; i < IEEE80211_NUM_TIDS; i++) {
+			tx_queue = cl_sta->agg_tx_queues[i];
+
+			if (tx_queue)
+				ieee80211_stop_tx_ba_session(sta, i);
+		}
+	}
+}
+
+static void cl_rx_action_frame_handler(struct cl_hw *cl_hw, struct cl_ieee80211_mgmt *mgmt,
+				       int len, struct cl_sta *cl_sta)
+{
+	/* Verify action code is present */
+	if (len < IEEE80211_MIN_ACTION_SIZE + 1)
+		return;
+
+	switch (mgmt->u.action.category) {
+	case WLAN_CATEGORY_WNM:
+		break;
+	case WLAN_CATEGORY_SELF_PROTECTED:
+		if (cl_sta && cl_sta->cl_vif->vif->type == NL80211_IFTYPE_MESH_POINT)
+			cl_rx_handle_mesh_reconnect(cl_hw, (struct ieee80211_mgmt *)mgmt, cl_sta);
+		break;
+	default:
+		break;
+	}
+}
+
+static struct ieee80211_he_6ghz_oper *
+cl_rx_get_he_6ghz_oper(const struct ieee80211_he_operation *he_oper)
+{
+	const u8 *ret = (void *)&he_oper->optional;
+	u32 he_oper_params;
+
+	he_oper_params = le32_to_cpu(he_oper->he_oper_params);
+
+	if (!(he_oper_params & IEEE80211_HE_OPERATION_6GHZ_OP_INFO))
+		return NULL;
+	if (he_oper_params & IEEE80211_HE_OPERATION_VHT_OPER_INFO)
+		ret += 3;
+	if (he_oper_params & IEEE80211_HE_OPERATION_CO_HOSTED_BSS)
+		ret++;
+
+	return (void *)ret;
+}
+
+static void
+cl_rx_check_he_minrate_change(struct cl_sta *cl_sta,
+			      const struct ieee80211_he_operation *he_oper)
+{
+	struct ieee80211_he_6ghz_oper *
+		he_6ghz_oper = cl_rx_get_he_6ghz_oper(he_oper);
+
+	if (!he_6ghz_oper)
+		return;
+
+	if (he_6ghz_oper->minrate != cl_sta->wrs_sta.he_minrate)
+		cl_wrs_api_he_minrate_changed(cl_sta, he_6ghz_oper->minrate);
+}
+
+static void cl_rx_handle_beacon(struct cl_hw *cl_hw,
+				struct sk_buff *skb,
+				struct cl_sta *cl_sta)
+{
+	struct ieee802_11_elems elems;
+	struct cl_vif *cl_vif = cl_sta->cl_vif;
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	size_t baselen = offsetof(struct ieee80211_mgmt, u.beacon.variable);
+	struct ieee80211_bss_conf *bss_conf = &cl_vif->vif->bss_conf;
+
+	if (cl_vif->vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	cl_ieee802_11_parse_elems(mgmt->u.beacon.variable, skb->len - baselen, &elems);
+
+	if (!elems.parse_error && elems.he_operation && bss_conf->he_support)
+		cl_rx_check_he_minrate_change(cl_sta, elems.he_operation);
+}
+
+static bool cl_rx_mgmt_check(struct cl_hw *cl_hw, struct sk_buff *skb,
+			     struct cl_vif *cl_vif, struct cl_sta *cl_sta,
+			     struct hw_rxhdr *rxhdr)
+{
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	__le16 fc = mgmt->frame_control;
+
+	if (!ieee80211_is_mgmt(fc))
+		return true;
+
+	if (cl_sta) {
+		if (ieee80211_is_beacon(fc))
+			cl_rx_handle_beacon(cl_hw, skb, cl_sta);
+		else if (ieee80211_is_action(fc))
+			cl_rx_action_frame_handler(cl_hw, (struct cl_ieee80211_mgmt *)mgmt,
+						   skb->len, cl_sta);
+	} else {
+		s8 rssi[MAX_ANTENNAS] = RX_HDR_RSSI(rxhdr);
+
+		cl_vns_mgmt_handler(cl_hw, mgmt->sa, rssi);
+
+		if (ieee80211_is_assoc_req(fc) || ieee80211_is_assoc_resp(fc)) {
+			cl_rssi_assoc_handle(cl_hw, mgmt->sa, rxhdr);
+			return true;
+		}
+	}
+
+	return true;
+}
+
+static void cl_rx_data_check(struct cl_hw *cl_hw, struct sk_buff *skb,
+			     struct cl_sta *cl_sta, u32 packet_len, struct hw_rxhdr *rxhdr)
+{
+	if (cl_sta) {
+		cl_traffic_rx_handler(cl_hw, cl_sta, packet_len);
+
+		if (!rxhdr->aggregation || (rxhdr->aggregation && rxhdr->mpdu_cnt == 0))
+			cl_motion_sense_rssi_data(cl_hw, cl_sta, rxhdr);
+	}
+}
+
+static bool cl_rx_skb_done(struct cl_hw *cl_hw, struct sk_buff *skb,
+			   struct cl_sta *cl_sta, struct hw_rxhdr *rxhdr)
+{
+	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	__le16 fc = hdr->frame_control;
+	struct cl_vif *cl_vif = NULL;
+
+	/* Update trigger base statistics */
+	cl_fw_dbg_trigger_based_update(cl_hw, rxhdr, hdr);
+	cl_fw_dbg_trigger_based_sta_update(cl_hw, rxhdr, hdr);
+
+	if (cl_sta) {
+		cl_vif = cl_sta->cl_vif;
+		skb->dev = cl_vif->dev;
+
+		cl_stats_update_rx_rate(cl_hw, cl_sta, rxhdr);
+
+		if (!rxhdr->aggregation || (rxhdr->aggregation && rxhdr->mpdu_cnt == 0))
+			cl_rssi_rx_handler(cl_hw, cl_sta, rxhdr, status->signal);
+	} else {
+		cl_vif = cl_vif_get_by_mac(cl_hw, hdr->addr3);
+		skb->dev = cl_vif ? cl_vif->dev : NULL;
+
+		if (cl_hw_is_prod_or_listener(cl_hw))
+			cl_stats_update_rx_rate_production(cl_hw, rxhdr);
+	}
+
+	/* DATA */
+	if (ieee80211_is_data(fc)) {
+		cl_wrs_update_rx_rate(cl_hw, cl_sta, rxhdr);
+		cl_rx_data_check(cl_hw, skb, cl_sta, skb->len, rxhdr);
+		goto out;
+	}
+
+	/* MGMT/CTL */
+	if (cl_sta)
+		cl_motion_sense_rssi_mgmt_ctl(cl_hw, cl_sta, rxhdr);
+
+	/* MGMT */
+	if (!cl_rx_mgmt_check(cl_hw, skb, cl_vif, cl_sta, rxhdr))
+		return false;
+
+out:
+	if (rx_skb_max &&
+	    atomic_read(&rx_skb_cnt) >= rx_skb_max) {
+		cl_hw->rx_info.pkt_drop_host_limit++;
+		cl_rx_skb_drop(cl_hw, skb, 1);
+		kfree_skb(skb);
+		return false;
+	}
+
+	cl_rx_skb_success(cl_vif, hdr, 1, skb->len);
+
+	return true;
+}
+
+static void cl_rx_pass_to_mac(struct cl_hw *cl_hw,
+			      struct ieee80211_sta *sta,
+			      struct sk_buff_head *frames)
+{
+	if (cl_hw->conf->ci_rx_remote_cpu_mac == -1) {
+		struct sk_buff *skb = NULL;
+
+		while ((skb = __skb_dequeue(frames)))
+			ieee80211_rx_napi(cl_hw->hw, sta, skb, NULL);
+	} else {
+		struct sk_buff_head *rx_remote_queue_mac = &cl_hw->rx_remote_queue_mac;
+
+		spin_lock(&rx_remote_queue_mac->lock);
+		skb_queue_splice_tail_init(frames, rx_remote_queue_mac);
+		spin_unlock(&rx_remote_queue_mac->lock);
+
+		cl_rx_remote_cpu_mac(cl_hw);
+	}
+}
+
+static void cl_rx_amsdu_done_reorder(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+				     struct sk_buff_head *frames)
+{
+	struct sk_buff *skb = NULL;
+	struct sk_buff_head reorder_buf;
+
+	/* Init the reorder buffer */
+	__skb_queue_head_init(&reorder_buf);
+
+	while ((skb = __skb_dequeue(frames)))
+		cl_rx_reorder_ampdu(cl_hw, cl_sta, skb, &reorder_buf);
+
+	if (!skb_queue_empty(&reorder_buf))
+		cl_rx_pass_to_mac(cl_hw, cl_sta->sta, &reorder_buf);
+}
+
+static void cl_rx_amsdu_done(struct cl_hw *cl_hw, struct cl_amsdu_rx_state *amsdu_rx_state)
+{
+	struct sk_buff_head *frames = &amsdu_rx_state->frames;
+	struct sk_buff *skb = __skb_peek(frames);
+	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
+	struct cl_sta *cl_sta;
+	struct cl_vif *cl_vif;
+	struct hw_rxhdr *rxhdr = amsdu_rx_state->rxhdr;
+	u32 packet_len = amsdu_rx_state->packet_len;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_sta *sta;
+
+	if (cl_rx_amsdu_check_aggregation_attack(amsdu_rx_state)) {
+		cl_hw->rx_info.pkt_drop_amsdu_inj_attack += amsdu_rx_state->msdu_cnt;
+		__skb_queue_purge(frames);
+		return;
+	}
+
+	/* START - cl_sta protected block */
+	cl_sta_lock(cl_hw);
+	cl_sta = cl_sta_get(cl_hw, amsdu_rx_state->sta_idx);
+
+	if (!cl_sta) {
+		cl_sta_unlock(cl_hw);
+		cl_hw->rx_info.pkt_drop_sta_null += amsdu_rx_state->msdu_cnt;
+		__skb_queue_purge(frames);
+		return;
+	}
+
+	sta = cl_sta->sta;
+	cl_vif = cl_sta->cl_vif;
+	skb->dev = cl_vif->dev;
+
+	cl_rx_data_check(cl_hw, skb, cl_sta, packet_len, rxhdr);
+	cl_stats_update_rx_rate(cl_hw, cl_sta, rxhdr);
+	cl_wrs_update_rx_rate(cl_hw, cl_sta, rxhdr);
+
+	if (!rxhdr->aggregation || (rxhdr->aggregation && rxhdr->mpdu_cnt == 0))
+		cl_rssi_rx_handler(cl_hw, cl_sta, rxhdr, status->signal);
+
+	cl_sta_unlock(cl_hw);
+	/* END - cl_sta protected block */
+
+	if (rx_skb_max &&
+	    (atomic_read(&rx_skb_cnt) + amsdu_rx_state->msdu_cnt) >= rx_skb_max) {
+		cl_hw->rx_info.pkt_drop_host_limit += amsdu_rx_state->msdu_cnt;
+		cl_rx_skb_drop(cl_hw, skb, amsdu_rx_state->msdu_cnt);
+		__skb_queue_purge(frames);
+		return;
+	}
+
+	cl_rx_skb_success(cl_vif, hdr, rxhdr->msdu_cnt, packet_len);
+
+	if (cl_sta->tid_agg_rx[amsdu_rx_state->tid])
+		cl_rx_amsdu_done_reorder(cl_hw, cl_sta, frames);
+	else
+		cl_rx_pass_to_mac(cl_hw, sta, frames);
+}
+
+static void cl_rx_invalid_tailroom(struct cl_hw *cl_hw, struct hw_rxhdr *rxhdr,
+				   struct sk_buff *skb, u32 len)
+{
+	cl_dbg_err(cl_hw, "Invalid RX header length - tailroom=%d, len=%u\n",
+		   skb_tailroom(skb), len);
+
+	if (rxhdr->amsdu_present && rxhdr->msdu_cnt > 1)
+		cl_rx_amsdu_set_state_error(cl_hw, rxhdr, RX_AMSDU_ERR_INVALID_TAILROOM);
+
+	cl_hw->rx_info.pkt_drop_tailroom_error++;
+	cl_rx_skb_error(cl_hw);
+	kfree_skb(skb);
+}
+
+static void cl_rx_invalid_pattern(struct cl_hw *cl_hw, struct sk_buff *skb, u32 pattern)
+{
+	cl_dbg_err(cl_hw, "WRONG PATTERN - 0x%x\n", pattern);
+	cl_hw->rx_info.pkt_drop_wrong_pattern++;
+	cl_rx_skb_error(cl_hw);
+	kfree_skb(skb);
+}
+
+static int cl_rx_get_sta_idx(struct cl_hw *cl_hw, struct hw_rxhdr *rxhdr)
+{
+	int sta_idx = rxhdr->key_sram_index - MM_SEC_DEFAULT_KEY_COUNT;
+	u8 vif_type;
+
+	if (sta_idx < 0) {
+		vif_type = cl_hw_get_iface_conf(cl_hw);
+		if (vif_type ==  CL_IFCONF_MESH_AP || vif_type == CL_IFCONF_MESH_ONLY) {
+			sta_idx += KSR_MGTK_BCAST_OFFSET;
+			sta_idx /= KSR_BLOCK_SIZE;
+		}
+	}
+
+	if (sta_idx >= 0 && sta_idx < CL_MAX_NUM_STA)
+		return sta_idx;
+
+	cl_dbg_err(cl_hw, "invalid sta_idx %d, key_sram_index=%d\n",
+		   sta_idx, rxhdr->key_sram_index);
+
+	return -EINVAL;
+}
+
+static void cl_rx_handle_first_amsdu(struct cl_hw *cl_hw, struct sk_buff *skb,
+				     struct cl_amsdu_rx_state *amsdu_rx_state,
+				     struct hw_rxhdr *rxhdr, u8 sta_idx, u8 tid, u8 encrypt_len)
+{
+	/*
+	 * First MSDU recived frame:
+	 * ------------------------------------------
+	 * || WLAN_HDR || MSDU HDR || MSDU PAYLOAD ||
+	 * ------------------------------------------
+	 */
+	cl_rx_amsdu_stats(cl_hw, rxhdr->msdu_cnt);
+
+	if (rxhdr->corrupted_amsdu) {
+		cl_rx_amsdu_first_corrupted(cl_hw, skb, rxhdr);
+	} else {
+		cl_rx_amsdu_first(cl_hw, skb, rxhdr, sta_idx, tid, encrypt_len);
+
+		/* If there are more MSDU's, hold on with the update
+		 * to the upper layer until A-MSDU is complete
+		 */
+		if (amsdu_rx_state->msdu_remaining_cnt == 0)
+			cl_rx_amsdu_done(cl_hw, amsdu_rx_state);
+	}
+}
+
+static void cl_rx_handle_sub_amsdu(struct cl_hw *cl_hw, struct sk_buff *skb,
+				   struct cl_amsdu_rx_state *amsdu_rx_state)
+{
+	/* Update the remaining MSDU counter */
+	amsdu_rx_state->msdu_remaining_cnt--;
+
+	/* Free MSDU with error */
+	if (amsdu_rx_state->amsdu_error) {
+		cl_rx_amsdu_sub_error(cl_hw, skb);
+		return;
+	}
+
+	/* Add the sub-MSDU to the existing ones */
+	if (!cl_rx_amsdu_sub(cl_hw, skb))
+		return;
+
+	/* This is the last MSDU, A-MSDU is complete, push to upper layer */
+	if (amsdu_rx_state->msdu_remaining_cnt == 0)
+		cl_rx_amsdu_done(cl_hw, amsdu_rx_state);
+}
+
+static void cl_rx_handle_ps(struct cl_hw *cl_hw, struct cl_sta *cl_sta, struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)(skb->data);
+	struct ieee80211_sta *sta = cl_sta->sta;
+	bool is_ps;
+	__le16 fc = hdr->frame_control;
+
+	if (ieee80211_is_pspoll(fc) ||
+	    ieee80211_has_morefrags(fc) ||
+	    !(ieee80211_is_mgmt(fc) ||
+	      ieee80211_is_data(fc)))
+		return;
+
+	is_ps = ieee80211_has_pm(hdr->frame_control);
+
+	cl_sta_ps_notify(cl_hw, cl_sta, is_ps);
+	ieee80211_sta_ps_transition(sta, is_ps);
+}
+
+static void cl_rx_shift_rxhdr_rssi_values(struct cl_hw *cl_hw, struct hw_rxhdr *rxhdr)
+{
+	/* Fill in the rxhdr rssi "holes" so that values will start from rssi1 */
+	switch (cl_hw->first_riu_chain) {
+	case 1:
+		rxhdr->rssi1 = rxhdr->rssi2;
+		rxhdr->rssi2 = rxhdr->rssi3;
+		rxhdr->rssi3 = rxhdr->rssi4;
+		rxhdr->rssi4 = rxhdr->rssi5;
+		rxhdr->rssi5 = rxhdr->rssi6;
+		break;
+	case 2:
+		rxhdr->rssi1 = rxhdr->rssi3;
+		rxhdr->rssi2 = rxhdr->rssi4;
+		rxhdr->rssi3 = rxhdr->rssi5;
+		rxhdr->rssi4 = rxhdr->rssi6;
+		break;
+	case 3:
+		rxhdr->rssi1 = rxhdr->rssi4;
+		rxhdr->rssi2 = rxhdr->rssi5;
+		rxhdr->rssi3 = rxhdr->rssi6;
+		break;
+	case 4:
+		rxhdr->rssi1 = rxhdr->rssi5;
+		rxhdr->rssi2 = rxhdr->rssi6;
+		break;
+	case 5:
+		rxhdr->rssi1 = rxhdr->rssi6;
+		break;
+	default:
+		break;
+	}
+}
+
+static void cl_rx_handle_skb(struct cl_hw *cl_hw, struct sk_buff *skb)
+{
+	u8 encrypt_len = 0;
+	u8 tid = 0;
+	u32 mpdu_offset = 0;
+	u32 len = 0;
+	int sta_idx = -1;
+	bool skb_done = false;
+	struct cl_sta *cl_sta = NULL;
+	struct ieee80211_sta *sta = NULL;
+	struct hw_rxhdr *rxhdr = NULL;
+	struct cl_tid_ampdu_rx *tid_agg_rx = NULL;
+	struct cl_amsdu_rx_state *amsdu_rx_state = &cl_hw->amsdu_rx_state;
+	s8 remote_cpu_mac = cl_hw->conf->ci_rx_remote_cpu_mac;
+
+	if (amsdu_rx_state->msdu_remaining_cnt > 0) {
+		cl_rx_handle_sub_amsdu(cl_hw, skb, amsdu_rx_state);
+		return;
+	}
+
+	rxhdr = (struct hw_rxhdr *)skb->data;
+	mpdu_offset = sizeof(struct hw_rxhdr);
+
+	if (rxhdr->rx_padding_done)
+		mpdu_offset += CL_PADDING_IN_BYTES;
+
+	/* Pull the HW RX header */
+	skb_reserve(skb, mpdu_offset);
+
+	/*
+	 * Sanity check - the embedded layer is responsible to validate the pattern correctness.
+	 * If pattern is invalid then it is likely that the embedded layer did some thing wrong.
+	 */
+	if (le32_to_cpu(rxhdr->pattern) != IPC_RX_DMA_OVER_PATTERN) {
+		cl_rx_invalid_pattern(cl_hw, skb, le32_to_cpu(rxhdr->pattern));
+		return;
+	}
+
+	if (cl_rx_check_err(cl_hw, skb, rxhdr))
+		return;
+
+	/* Convert gi from firmware format to driver format */
+	rxhdr->gi_type = cl_convert_gi_format_fw_to_wrs(rxhdr->format_mod, rxhdr->gi_type);
+
+	if (cl_hw->first_riu_chain > 0)
+		cl_rx_shift_rxhdr_rssi_values(cl_hw, rxhdr);
+
+	if (cl_hw->rssi_simulate)
+		cl_rssi_simulate(cl_hw, rxhdr);
+
+	if (rxhdr->key_sram_v)
+		sta_idx = cl_rx_get_sta_idx(cl_hw, rxhdr);
+
+	cl_sta_lock(cl_hw);
+
+	if (sta_idx != -1) {
+		cl_sta = cl_sta_get(cl_hw, sta_idx);
+
+		if (cl_sta) {
+			sta = cl_sta->sta;
+
+			if (cl_hw->conf->ci_fast_rx_en) {
+				tid = ieee80211_get_tid((struct ieee80211_hdr *)skb->data);
+				tid_agg_rx = cl_sta->tid_agg_rx[tid];
+				cl_rx_handle_ps(cl_hw, cl_sta, skb);
+			}
+
+			/* Store the pointer to sta in the skb->sk field */
+			if (remote_cpu_mac != -1)
+				skb->sk = (struct sock *)sta;
+		}
+	}
+
+	if (unlikely(cl_rx_fill_status(cl_hw, cl_sta, skb, rxhdr, &encrypt_len))) {
+		cl_sta_unlock(cl_hw);
+		cl_rx_skb_error(cl_hw);
+		kfree_skb(skb);
+		return;
+	}
+
+	/* Is A-MSDU frame? */
+	if (rxhdr->amsdu_present) {
+		cl_rx_handle_first_amsdu(cl_hw, skb, amsdu_rx_state, rxhdr, sta_idx,
+					 tid, encrypt_len);
+		cl_sta_unlock(cl_hw);
+		return;
+	}
+
+	len = rxhdr->len;
+
+	if (skb_tailroom(skb) >= len) {
+		/* Push the WLAN HDR + MDPU payload to the skb data */
+		skb_put(skb, len);
+		cl_hw->rx_info.non_amsdu++;
+	} else {
+		cl_sta_unlock(cl_hw);
+		cl_rx_invalid_tailroom(cl_hw, rxhdr, skb, len);
+		return;
+	}
+
+	skb_done = cl_rx_skb_done(cl_hw, skb, cl_sta, rxhdr);
+
+	cl_sta_unlock(cl_hw);
+
+	if (!skb_done)
+		return;
+
+	if (tid_agg_rx) {
+		struct sk_buff_head reorder_buf;
+
+		/* Init the reorder buffer */
+		__skb_queue_head_init(&reorder_buf);
+		cl_rx_reorder_ampdu(cl_hw, cl_sta, skb, &reorder_buf);
+
+		if (!skb_queue_empty(&reorder_buf))
+			cl_rx_pass_to_mac(cl_hw, sta, &reorder_buf);
+	} else {
+		if (cl_key_handle_pn_validation(cl_hw, skb, cl_sta) == CL_PN_VALID_STATE_FAILED) {
+			kfree_skb(skb);
+			return;
+		}
+
+		if (remote_cpu_mac == -1) {
+			ieee80211_rx_napi(cl_hw->hw, sta, skb, NULL);
+		} else {
+			skb_queue_tail(&cl_hw->rx_remote_queue_mac, skb);
+			cl_rx_remote_cpu_mac(cl_hw);
+		}
+	}
+}
+
+static bool cl_is_rx_allowed(struct cl_hw *cl_hw)
+{
+	return !(cl_radio_is_off(cl_hw) ||
+		 !test_bit(CL_DEV_STARTED, &cl_hw->drv_flags) ||
+		 test_bit(CL_DEV_FW_ERROR, &cl_hw->drv_flags) ||
+		 cl_recovery_in_progress(cl_hw));
+}
+
+static void cl_rx_tasklet(unsigned long data)
+{
+	struct cl_hw *cl_hw = (struct cl_hw *)data;
+	struct sk_buff *skb = NULL;
+	u16 pkt_cnt = 0;
+
+	if (unlikely(!cl_is_rx_allowed(cl_hw)))
+		return;
+
+	while ((skb = skb_dequeue(&cl_hw->rx_skb_queue))) {
+		cl_rx_handle_skb(cl_hw, skb);
+
+		if (++pkt_cnt > cl_hw->conf->ce_rx_pkts_budget) {
+			if (cl_hw->chip->conf->ci_rx_resched_tasklet)
+				tasklet_schedule(&cl_hw->rx_resched_tasklet);
+			else
+				tasklet_schedule(&cl_hw->rx_tasklet);
+
+			cl_hw->rx_info.exceed_pkt_budget++;
+			return;
+		}
+	}
+}
+
+static void cl_rx_resched_tasklet(unsigned long data)
+{
+	struct cl_hw *cl_hw = (struct cl_hw *)data;
+
+	tasklet_schedule(&cl_hw->rx_tasklet);
+}
+
+static void cl_rx_remote_tasklet_mac(unsigned long data)
+{
+	struct cl_hw *cl_hw = (struct cl_hw *)data;
+	struct sk_buff *skb = NULL;
+	struct ieee80211_sta *sta;
+
+	if (unlikely(!cl_is_rx_allowed(cl_hw)))
+		return;
+
+	cl_rx_remote_cpu_info(cl_hw);
+
+	while ((skb = skb_dequeue(&cl_hw->rx_remote_queue_mac))) {
+		/*
+		 * Get sta pointer from skb->sk (stored their in cl_rx_remote_cpu_mac)
+		 * and reset skb->sk.
+		 */
+		sta = (struct ieee80211_sta *)skb->sk;
+		skb->sk = NULL;
+
+		ieee80211_rx_napi(cl_hw->hw, sta, skb, NULL);
+	}
+}
+
+void cl_rx_init(struct cl_hw *cl_hw)
+{
+	s8 cpu_mac = cl_hw->conf->ci_rx_remote_cpu_mac;
+
+	/* Set rx_skb_max to be the maximum of ci_rx_skb_max configured for each chip */
+	rx_skb_max = max(cl_hw->chip->conf->ci_rx_skb_max, rx_skb_max);
+
+	skb_queue_head_init(&cl_hw->rx_remote_queue_mac);
+	skb_queue_head_init(&cl_hw->rx_skb_queue);
+	__skb_queue_head_init(&cl_hw->amsdu_rx_state.frames);
+
+	tasklet_init(&cl_hw->rx_tasklet, cl_rx_tasklet, (unsigned long)cl_hw);
+	tasklet_init(&cl_hw->rx_resched_tasklet, cl_rx_resched_tasklet, (unsigned long)cl_hw);
+
+	if (cpu_mac >= 0) {
+		struct tasklet_struct *t = &per_cpu(rx_remote_tasklet_mac[cl_hw->idx], cpu_mac);
+
+		tasklet_init(t,
+			     cl_rx_remote_tasklet_mac,
+			     (unsigned long)cl_hw);
+
+		csd_rx_remote_cpu_mac[cl_hw->idx].func = cl_rx_remote_tasklet_sched;
+		csd_rx_remote_cpu_mac[cl_hw->idx].info = t;
+	}
+	cl_rx_pci_init(cl_hw);
+}
+
+void cl_rx_off(struct cl_hw *cl_hw)
+{
+	s8 cpu_mac = cl_hw->conf->ci_rx_remote_cpu_mac;
+
+	if (cpu_mac >= 0)
+		tasklet_kill(&per_cpu(rx_remote_tasklet_mac[cl_hw->idx], cpu_mac));
+
+	tasklet_kill(&cl_hw->rx_tasklet);
+	tasklet_kill(&cl_hw->rx_resched_tasklet);
+
+	skb_queue_purge(&cl_hw->rx_remote_queue_mac);
+	skb_queue_purge(&cl_hw->rx_skb_queue);
+
+	cl_rx_amsdu_reset(cl_hw);
+	cl_rx_pci_deinit(cl_hw);
+}
+
+void cl_rx_remote_tasklet_sched(void *t)
+{
+	tasklet_schedule((struct tasklet_struct *)t);
+}
+
+void cl_rx_remote_cpu_info(struct cl_hw *cl_hw)
+{
+	u32 processor_id = smp_processor_id();
+
+	if (processor_id < CPU_MAX_NUM)
+		cl_hw->rx_info.remote_cpu[processor_id]++;
+}
+
+void cl_rx_push_queue(struct cl_hw *cl_hw, struct sk_buff *skb)
+{
+	skb_queue_tail(&cl_hw->rx_skb_queue, skb);
+	tasklet_schedule(&cl_hw->rx_tasklet);
+}
+
+void cl_rx_skb_alloc_handler(struct sk_buff *skb)
+{
+	skb->destructor = cl_rx_skb_destructor;
+	atomic_inc(&rx_skb_cnt);
+}
+
+void cl_rx_skb_error(struct cl_hw *cl_hw)
+{
+	/*
+	 * When there is an error with the received packet we can't
+	 * know the interface and the AC.
+	 * So just use the first interface and BE.
+	 */
+	struct cl_vif *cl_vif = cl_vif_get_first(cl_hw);
+
+	if (!cl_vif) {
+		cl_dbg_err(cl_hw, "Couldn't find vif\n");
+		return;
+	}
+
+	cl_vif->trfc_cntrs[AC_BE].rx_errors++;
+}
+
+void cl_rx_skb_drop(struct cl_hw *cl_hw, struct sk_buff *skb, u8 cnt)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct cl_vif *cl_vif = cl_vif_get_by_mac(cl_hw, hdr->addr3);
+
+	if (cl_vif) {
+		u8 ac = cl_rx_get_skb_ac(hdr);
+
+		cl_vif->trfc_cntrs[ac].rx_dropped += cnt;
+	}
+}
+
+void cl_rx_post_recovery(struct cl_hw *cl_hw)
+{
+	if (!skb_queue_empty(&cl_hw->rx_skb_queue))
+		tasklet_schedule(&cl_hw->rx_tasklet);
+
+	if (!skb_queue_empty(&cl_hw->rx_remote_queue_mac))
+		tasklet_schedule(&per_cpu(rx_remote_tasklet_mac[cl_hw->idx],
+					  cl_hw->conf->ci_rx_remote_cpu_mac));
+}
+
+u8 cl_rx_get_skb_ac(struct ieee80211_hdr *hdr)
+{
+	if (ieee80211_is_data_qos(hdr->frame_control)) {
+		u8 *qos_ctl = ieee80211_get_qos_ctl(hdr);
+		u8 tid = *qos_ctl & IEEE80211_QOS_CTL_TAG1D_MASK;
+		return tid_to_ac[tid];
+	}
+
+	return AC_BE;
+}
+
+bool cl_rx_process_in_irq(struct cl_hw *cl_hw)
+{
+	struct cl_ipc_ring_indices *indices = cl_hw->ipc_env->ring_indices_elem->indices;
+	u32 read_idx = le32_to_cpu(indices->rxdesc_read_idx[CL_RX_BUF_RXM]);
+	u32 write_idx = le32_to_cpu(indices->rxdesc_write_idx[CL_RX_BUF_RXM]);
+	u32 free_buffers = read_idx - write_idx;
+
+	if (free_buffers < (IPC_RXBUF_CNT_RXM / 2)) {
+		cl_hw->rx_info.buffer_process_irq++;
+		return true;
+	}
+
+	cl_hw->rx_info.buffer_process_tasklet++;
+	return false;
+}
+
+static bool cl_agg_rx_report_is_status_valid(u8 status)
+{
+	if (status == MM_AGG_RX_REPORT_STAT_OK ||
+	    status == MM_AGG_RX_REPORT_STAT_COLISION_WITH_COUNTER)
+		return true;
+
+	return false;
+}
+
+static void sync_rx_rate(struct cl_hw *cl_hw, struct cl_sta *cl_sta, struct cl_wrs_info *wrs_info,
+			 struct cl_wrs_params *wrs_params, u8 bw, u8 nss, u8 mcs, u8 gi)
+{
+	struct cl_wrs_rate_params *rate_params = &wrs_params->rate_params;
+
+	if (bw == rate_params->bw &&
+	    nss == rate_params->nss &&
+	    mcs == rate_params->mcs &&
+	    gi == rate_params->gi) {
+		cl_wrs_api_rate_sync(cl_hw, cl_sta, wrs_params);
+
+		wrs_info->synced = true;
+		wrs_info->quick_rate_check = true;
+		wrs_info->quick_rate_agg_cntr = 0;
+		wrs_info->quick_rate_pkt_cntr = 0;
+	} else {
+		wrs_info->sync_attempts++;
+	}
+}
+
+void cl_agg_rx_report_handler(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u8 sta_loc,
+			      struct mm_agg_rx_ind *agg_report)
+{
+	struct cl_wrs_info *wrs_info = NULL;
+	struct cl_wrs_params *wrs_params = cl_sta->wrs_sta.rx_params;
+	u16 success_cnt = le16_to_cpu(agg_report->correct_received_mpdu_count[sta_loc]);
+	u16 data_rate;
+	u8 nss = agg_report->nss_per_user[sta_loc];
+	u8 mcs = agg_report->mcs_rate[sta_loc];
+	u8 gi =  CL_TF_GI_LTF_TO_GI(agg_report->gi_ltf);
+	u8 bw;
+
+	if (!wrs_params ||
+	    !cl_agg_rx_report_is_status_valid(agg_report->status[sta_loc]))
+		return;
+
+	wrs_info = &cl_sta->wrs_info_rx;
+
+	{
+		u8 ru_type = cl_ru_alloc_to_ru_type(agg_report->ru_allocation[sta_loc]);
+
+		bw = cl_mu_ofdma_grp_convert_ru_type_to_bw(cl_hw, ru_type);
+	}
+
+	/* WRS sync mechanism */
+	if (!wrs_info->synced)
+		sync_rx_rate(cl_hw, cl_sta, wrs_info, wrs_params, bw, nss, mcs, gi);
+
+	data_rate = cl_data_rates_get_x10(WRS_MODE_HE, bw, nss, mcs, gi);
+
+	wrs_info->success += success_cnt;
+	wrs_info->fail += (le16_to_cpu(agg_report->incorrect_received_mpdu_count[sta_loc]) +
+			   le16_to_cpu(agg_report->incorrect_delimiter_count[sta_loc]));
+	wrs_info->epr_acc += ((u64)success_cnt * data_rate);
+}
+
+struct msduhdr {
+	u8 dest[ETH_ALEN];
+	u8 source[ETH_ALEN];
+	__be16 len;
+} __packed;
+
+static void cl_rx_set_flag_amsdu_more(struct sk_buff *skb)
+{
+	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
+
+	rx_status->flag |= RX_FLAG_AMSDU_MORE;
+}
+
+static void cl_rx_clear_flag_amsdu_more(struct sk_buff *skb)
+{
+	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
+
+	rx_status->flag &= ~RX_FLAG_AMSDU_MORE;
+}
+
+static void cl_rx_add_80211_hdr(struct cl_amsdu_rx_state *amsdu_rx_state,
+				struct sk_buff *skb, struct sk_buff *first_skb)
+{
+	/* Copy the 802.11 header of the first skb */
+	struct ieee80211_hdr *hdr_first = (struct ieee80211_hdr *)(first_skb->data);
+	u32 hdrlen_first = ieee80211_hdrlen(hdr_first->frame_control);
+	u32 total_bytes = hdrlen_first + amsdu_rx_state->encrypt_len;
+
+	skb_push(skb, total_bytes);
+	memcpy(skb->data, first_skb->data, total_bytes);
+}
+
+static void cl_rx_copy_status(struct cl_amsdu_rx_state *amsdu_rx_state,
+			      struct sk_buff *skb, struct sk_buff *first_skb)
+{
+	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
+	struct ieee80211_rx_status *rx_status_first = IEEE80211_SKB_RXCB(first_skb);
+
+	/* Copy rx_status from the first skb */
+	memcpy(rx_status, rx_status_first, sizeof(struct ieee80211_rx_status));
+
+	/* If it is the last sub-frame clear RX_FLAG_AMSDU_MORE */
+	if (amsdu_rx_state->msdu_remaining_cnt == 0)
+		rx_status->flag &= ~RX_FLAG_AMSDU_MORE;
+}
+
+static void cl_rx_amsdu_set_state(struct cl_hw *cl_hw, struct sk_buff *skb, struct hw_rxhdr *rxhdr,
+				  u8 sta_idx, u8 tid, u32 packet_len, u8 encrypt_len)
+{
+	struct cl_amsdu_rx_state *amsdu_rx_state = &cl_hw->amsdu_rx_state;
+
+	amsdu_rx_state->msdu_cnt = rxhdr->msdu_cnt;
+	amsdu_rx_state->msdu_remaining_cnt = rxhdr->msdu_cnt - 1;
+	amsdu_rx_state->msdu_dma_align = rxhdr->msdu_dma_align;
+	amsdu_rx_state->amsdu_error = 0;
+	amsdu_rx_state->encrypt_len = encrypt_len;
+	amsdu_rx_state->packet_len = packet_len;
+	amsdu_rx_state->rxhdr = rxhdr;
+	amsdu_rx_state->first_skb = skb;
+	amsdu_rx_state->sta_idx = sta_idx;
+	amsdu_rx_state->tid = tid;
+
+	__skb_queue_head(&cl_hw->amsdu_rx_state.frames, skb);
+}
+
+static void cl_rx_amsdu_first_length_error(struct cl_hw *cl_hw, struct sk_buff *skb,
+					   struct hw_rxhdr *rxhdr, u32 len)
+{
+	cl_dbg_err(cl_hw, "RX-AMSDU length error (1/%u) - tailroom=%d, len=%u\n",
+		   rxhdr->msdu_cnt, skb_tailroom(skb), len);
+
+	cl_rx_amsdu_set_state_error(cl_hw, rxhdr, RX_AMSDU_ERR_LENGTH);
+
+	cl_hw->rx_info.pkt_drop_amsdu_len_error++;
+	cl_rx_skb_error(cl_hw);
+	kfree_skb(skb);
+}
+
+static void cl_rx_amsdu_sub_length_error(struct cl_hw *cl_hw, struct sk_buff *skb, u32 len)
+{
+	struct cl_amsdu_rx_state *amsdu_rx_state = &cl_hw->amsdu_rx_state;
+	struct sk_buff *skb_tail;
+	u8 sub_cnt = amsdu_rx_state->msdu_cnt - amsdu_rx_state->msdu_remaining_cnt;
+
+	cl_dbg_err(cl_hw, "RX-AMSDU length error (%u/%u) - tailroom=%d, len=%u\n",
+		   sub_cnt, amsdu_rx_state->msdu_cnt, skb_tailroom(skb), len);
+
+	/* All remaining skbs in the AMSDU will be treated as errors */
+	amsdu_rx_state->amsdu_error = RX_AMSDU_ERR_LENGTH;
+
+	/* Clear RX_FLAG_AMSDU_MORE in the last success skb that was received */
+	skb_tail = skb_peek_tail(&amsdu_rx_state->frames);
+	cl_rx_clear_flag_amsdu_more(skb_tail);
+
+	cl_hw->rx_info.pkt_drop_sub_amsdu_len_error++;
+	cl_rx_skb_error(cl_hw);
+	kfree_skb(skb);
+}
+
+static bool cl_rx_amsdu_is_frame_aggregation_attack(struct ieee80211_hdr *hdr,
+						    const struct msduhdr *msdu_hdr)
+{
+	__le16 fc;
+	int to_ds;
+	int from_ds;
+
+	fc = hdr->frame_control;
+	to_ds = ieee80211_has_tods(fc);
+	from_ds = ieee80211_has_fromds(fc);
+
+	if (to_ds && memcmp(hdr->addr2, msdu_hdr->source, ETH_ALEN))
+		return true;
+
+	if (from_ds && memcmp(hdr->addr1, msdu_hdr->dest, ETH_ALEN) &&
+	    !(is_multicast_ether_addr(hdr->addr3)))
+		return true;
+
+	return false;
+}
+
+void cl_rx_amsdu_first(struct cl_hw *cl_hw, struct sk_buff *skb,
+		       struct hw_rxhdr *rxhdr, u8 sta_idx, u8 tid, u8 encrypt_len)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)(skb->data);
+	u32 hdr_len = ieee80211_hdrlen(hdr->frame_control);
+	struct msduhdr *msdu_hdr = (struct msduhdr *)(skb->data + hdr_len + encrypt_len);
+	u32 packet_len = hdr_len + encrypt_len + sizeof(struct msduhdr) + ntohs(msdu_hdr->len);
+
+	if (skb_tailroom(skb) < packet_len) {
+		cl_rx_amsdu_first_length_error(cl_hw, skb, rxhdr, packet_len);
+		return;
+	}
+
+	/* Put the WLAN header + MSDU header + payload in the skb data */
+	skb_put(skb, packet_len);
+
+	cl_rx_amsdu_set_state(cl_hw, skb, rxhdr, sta_idx, tid, packet_len, encrypt_len);
+
+	/* Must be called after cl_rx_amsdu_set_state() */
+	if (cl_hw->amsdu_rx_state.msdu_remaining_cnt > 0)
+		cl_rx_set_flag_amsdu_more(skb);
+}
+
+bool cl_rx_amsdu_sub(struct cl_hw *cl_hw, struct sk_buff *skb)
+{
+	/*
+	 * ----------------------------------------------------------
+	 * | DMA padding 4 byte alignment | MSDU HDR | MSDU PAYLOAD |
+	 *  ---------------------------------------------------------
+	 */
+	struct cl_amsdu_rx_state *amsdu_rx_state = &cl_hw->amsdu_rx_state;
+	struct sk_buff *first_skb = amsdu_rx_state->first_skb;
+	struct msduhdr *msdu_hdr;
+	u32 packet_len;
+
+	/*
+	 * Push the dma alignment to the reserved area, so that skb->data will
+	 * point to the MSDU header
+	 */
+	skb_reserve(skb, amsdu_rx_state->msdu_dma_align);
+
+	msdu_hdr = (struct msduhdr *)(skb->data);
+	packet_len = sizeof(struct msduhdr) + ntohs(msdu_hdr->len);
+
+	if (skb_tailroom(skb) < packet_len) {
+		cl_rx_amsdu_sub_length_error(cl_hw, skb, packet_len);
+		return false;
+	}
+
+	/* Put the MSDU HDR + MSDU PAYLOAD into the skb data area */
+	skb_put(skb, packet_len);
+
+	amsdu_rx_state->packet_len += packet_len;
+
+	cl_rx_add_80211_hdr(amsdu_rx_state, skb, first_skb);
+	cl_rx_copy_status(amsdu_rx_state, skb, first_skb);
+
+	/* Store the pointer to sta in the skb->sk field */
+	skb->sk = first_skb->sk;
+
+	__skb_queue_tail(&amsdu_rx_state->frames, skb);
+
+	return true;
+}
+
+bool cl_rx_amsdu_check_aggregation_attack(struct cl_amsdu_rx_state *amsdu_rx_state)
+{
+	u32 hdrlen = 0;
+	struct sk_buff_head *frames = &amsdu_rx_state->frames;
+	struct hw_rxhdr *rxhdr = amsdu_rx_state->rxhdr;
+	struct ieee80211_hdr *hdr = NULL;
+	struct msduhdr *msdu_hdr = NULL;
+	struct sk_buff *skb = NULL;
+
+	/* Validate encryption info - forbid A-MSDU on pre-HT connections */
+	switch (rxhdr->decr_status) {
+	case CL_RX_HDR_DECR_ICVFAIL:
+	case CL_RX_HDR_DECR_WEPSUCCESS:
+	case CL_RX_HDR_DECR_TKIPSUCCESS:
+		return true;
+	default:
+		break;
+	}
+
+	skb_queue_walk(frames, skb) {
+		hdr = (struct ieee80211_hdr *)(skb->data);
+		hdrlen = ieee80211_hdrlen(hdr->frame_control);
+		msdu_hdr = (struct msduhdr *)(skb->data + hdrlen + amsdu_rx_state->encrypt_len);
+		if (cl_rx_amsdu_is_frame_aggregation_attack(hdr, msdu_hdr))
+			return true;
+	}
+
+	return false;
+}
+
+void cl_rx_amsdu_first_corrupted(struct cl_hw *cl_hw, struct sk_buff *skb,
+				 struct hw_rxhdr *rxhdr)
+{
+	struct ieee80211_hdr *mac_hdr = (struct ieee80211_hdr *)(skb->data);
+
+	cl_dbg_verbose(cl_hw, "Corrupted RX-AMSDU (1/%u), dest_addr=%pM\n",
+		       rxhdr->msdu_cnt, mac_hdr->addr1);
+
+	cl_rx_amsdu_set_state_error(cl_hw, rxhdr, RX_AMSDU_ERR_CORRUPTED);
+
+	cl_hw->rx_info.pkt_drop_amsdu_corrupted++;
+	cl_rx_skb_error(cl_hw);
+	kfree_skb(skb);
+}
+
+void cl_rx_amsdu_sub_error(struct cl_hw *cl_hw, struct sk_buff *skb)
+{
+	struct cl_amsdu_rx_state *amsdu_rx_state = &cl_hw->amsdu_rx_state;
+	u8 sub_cnt = amsdu_rx_state->msdu_cnt - amsdu_rx_state->msdu_remaining_cnt;
+
+	if (amsdu_rx_state->amsdu_error & RX_AMSDU_ERR_CORRUPTED) {
+		cl_hw->rx_info.pkt_drop_sub_amsdu_corrupted++;
+
+		cl_dbg_verbose(cl_hw, "Corrupted RX-AMSDU (%u/%u)\n",
+			       sub_cnt, amsdu_rx_state->msdu_cnt);
+	} else if (amsdu_rx_state->amsdu_error & RX_AMSDU_ERR_LENGTH) {
+		cl_hw->rx_info.pkt_drop_sub_amsdu_len_error++;
+
+		cl_dbg_verbose(cl_hw, "RX-AMSDU length error (%u/%u)\n",
+			       sub_cnt, amsdu_rx_state->msdu_cnt);
+	} else if (amsdu_rx_state->amsdu_error & RX_AMSDU_ERR_NOT_SUCCESS) {
+		cl_hw->rx_info.pkt_drop_sub_amsdu_not_success++;
+
+		cl_dbg_verbose(cl_hw, "RX-AMSDU not success (%u/%u)\n",
+			       sub_cnt, amsdu_rx_state->msdu_cnt);
+	} else if (amsdu_rx_state->amsdu_error & RX_AMSDU_ERR_UNENCRYPTED) {
+		cl_hw->rx_info.pkt_drop_sub_amsdu_unencrypted++;
+
+		cl_dbg_verbose(cl_hw, "Protected frame unencrypted (%u/%u)\n",
+			       sub_cnt, amsdu_rx_state->msdu_cnt);
+	} else if (amsdu_rx_state->amsdu_error & RX_AMSDU_ERR_DECRYPT_FAIL) {
+		cl_hw->rx_info.pkt_drop_sub_amsdu_decrypt_fail++;
+
+		cl_dbg_verbose(cl_hw, "Decryption failed (%u/%u)\n",
+			       sub_cnt, amsdu_rx_state->msdu_cnt);
+	} else if (amsdu_rx_state->amsdu_error & RX_AMSDU_ERR_INVALID_TAILROOM) {
+		cl_hw->rx_info.pkt_drop_sub_amsdu_tailroom_error++;
+
+		cl_dbg_verbose(cl_hw, "Invalid tailroom (%u/%u)\n",
+			       sub_cnt, amsdu_rx_state->msdu_cnt);
+	}
+
+	cl_rx_skb_error(cl_hw);
+	kfree_skb(skb);
+}
+
+void cl_rx_amsdu_set_state_error(struct cl_hw *cl_hw,
+				 struct hw_rxhdr *rxhdr,
+				 enum rx_amsdu_error err)
+{
+	struct cl_amsdu_rx_state *amsdu_rx_state = &cl_hw->amsdu_rx_state;
+
+	amsdu_rx_state->msdu_cnt = rxhdr->msdu_cnt;
+	amsdu_rx_state->msdu_remaining_cnt = rxhdr->msdu_cnt - 1;
+	amsdu_rx_state->amsdu_error = err;
+}
+
+void cl_rx_amsdu_reset(struct cl_hw *cl_hw)
+{
+	/* Free pending frames */
+	__skb_queue_purge(&cl_hw->amsdu_rx_state.frames);
+
+	/* Reset RX A-MSDU state */
+	memset(&cl_hw->amsdu_rx_state, 0, sizeof(struct cl_amsdu_rx_state));
+
+	__skb_queue_head_init(&cl_hw->amsdu_rx_state.frames);
+}
+
+void cl_rx_amsdu_stats(struct cl_hw *cl_hw, u8 msdu_cnt)
+{
+	/*
+	 * Update A-MSDU statistics
+	 * msdu_cnt 1 - 128 is mapped to 0 - 127.
+	 */
+	if (msdu_cnt <= RX_MAX_MSDU_IN_AMSDU)
+		cl_hw->rx_info.amsdu_cnt[msdu_cnt - 1]++;
+	else
+		cl_dbg_err(cl_hw, "Invalid msdu_cnt [%u]\n", msdu_cnt);
+}
+
+/* Only ieee80211_hw_set() is defined in mac80211.h */
+static inline void _ieee80211_hw_clear(struct ieee80211_hw *hw,
+				       enum ieee80211_hw_flags flg)
+{
+	return __clear_bit(flg, hw->flags);
+}
+
+#define ieee80211_hw_clear(hw, flg) _ieee80211_hw_clear(hw, IEEE80211_HW_##flg)
+
+void cl_rx_amsdu_hw_en(struct ieee80211_hw *hw, bool rxamsdu_en)
+{
+	if (rxamsdu_en)
+		ieee80211_hw_set(hw, SUPPORTS_AMSDU_IN_AMPDU);
+	else
+		ieee80211_hw_clear(hw, SUPPORTS_AMSDU_IN_AMPDU);
+}
+
+u32 cl_rx_filter_update_flags(struct cl_hw *cl_hw, u32 filter)
+{
+	u32 rx_filter = 0;
+
+	if (filter & FIF_ALLMULTI)
+		rx_filter |= RX_CNTRL_ACCEPT_MULTICAST_BIT;
+
+	if (filter & (FIF_FCSFAIL | FIF_PLCPFAIL))
+		rx_filter |= RX_CNTRL_ACCEPT_ERROR_FRAMES_BIT;
+
+	if (filter & FIF_BCN_PRBRESP_PROMISC)
+		rx_filter |= RX_CNTRL_ACCEPT_OTHER_BSSID_BIT;
+
+	if (filter & FIF_CONTROL)
+		rx_filter |= RX_CNTRL_ACCEPT_OTHER_CNTRL_FRAMES_BIT |
+			     RX_CNTRL_ACCEPT_CF_END_BIT |
+			     RX_CNTRL_ACCEPT_ACK_BIT |
+			     RX_CNTRL_ACCEPT_CTS_BIT |
+			     RX_CNTRL_ACCEPT_RTS_BIT |
+			     RX_CNTRL_ACCEPT_BA_BIT | RX_CNTRL_ACCEPT_BAR_BIT;
+
+	if (filter & FIF_OTHER_BSS)
+		rx_filter |= RX_CNTRL_ACCEPT_OTHER_BSSID_BIT;
+
+	if (filter & FIF_PSPOLL)
+		rx_filter |= RX_CNTRL_ACCEPT_PS_POLL_BIT;
+
+	if (filter & FIF_PROBE_REQ)
+		rx_filter |= RX_CNTRL_ACCEPT_PROBE_REQ_BIT;
+
+	/* Add the filter flags that are set by default and cannot be changed here */
+	rx_filter |= CL_MAC80211_NOT_CHANGEABLE;
+
+	if (ieee80211_hw_check(cl_hw->hw, AMPDU_AGGREGATION))
+		rx_filter |= RX_CNTRL_ACCEPT_BA_BIT;
+
+	/*
+	 * work around for HW bug (AD 14672)
+	 * In order for the response frames to BAR and RTS be with correct
+	 * power they should always be accepted and found in the KSR
+	 */
+	rx_filter |= RX_CNTRL_ACCEPT_BAR_BIT | RX_CNTRL_ACCEPT_RTS_BIT;
+
+	return rx_filter;
+}
+
+static u32 cl_filter_get_flags(struct net_device *dev)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+
+	return sdata->local->filter_flags;
+}
+
+void cl_rx_filter_restore_flags(struct cl_hw *cl_hw)
+{
+	struct net_device *dev = cl_vif_get_first_net_device(cl_hw);
+	u32 filter = 0;
+
+	if (!dev)
+		return;
+
+	filter = cl_filter_get_flags(dev);
+	cl_dbg_verbose(cl_hw, "Restoring filter flags to 0x%x\n", filter);
+	cl_msg_tx_set_filter(cl_hw, filter, false);
+}
+
+void cl_rx_filter_set_promiscuous(struct cl_hw *cl_hw)
+{
+	u32 filter = ~(FIF_FCSFAIL | FIF_PLCPFAIL | (1 << 31));
+
+	cl_dbg_verbose(cl_hw, "set promiscuous mode 0x%x\n", filter);
+	cl_msg_tx_set_filter(cl_hw, filter, false);
+}
+
+#define REORDER_BUF_TIMEOUT (HZ / 10)
+#define REORDER_BUF_TIMEOUT_MS jiffies_to_msecs(REORDER_BUF_TIMEOUT + 1)
+
+static bool cl_rx_reorder_ready(struct cl_tid_ampdu_rx *tid_agg_rx, u8 index)
+{
+	struct sk_buff_head *frames = &tid_agg_rx->reorder_buf[index];
+	struct sk_buff *tail = skb_peek_tail(frames);
+	struct ieee80211_rx_status *status;
+
+	if (tid_agg_rx->reorder_buf_filtered & BIT_ULL(index))
+		return true;
+
+	if (!tail)
+		return false;
+
+	status = IEEE80211_SKB_RXCB(tail);
+
+	if (status->flag & RX_FLAG_AMSDU_MORE)
+		return false;
+
+	return true;
+}
+
+static void cl_rx_release_reorder_frame(struct cl_tid_ampdu_rx *tid_agg_rx, int index,
+					struct sk_buff_head *frames)
+{
+	struct cl_hw *cl_hw = tid_agg_rx->cl_hw;
+	struct sk_buff_head *skb_list = &tid_agg_rx->reorder_buf[index];
+	struct sk_buff *skb;
+	struct ieee80211_rx_status *status = NULL;
+	struct cl_sta *cl_sta = IEEE80211_STA_TO_CL_STA(tid_agg_rx->sta);
+	int pn_state = CL_PN_VALID_STATE_FAILED;
+
+	lockdep_assert_held(&tid_agg_rx->reorder_lock);
+
+	if (skb_queue_empty(skb_list))
+		goto no_frame;
+
+	tid_agg_rx->stored_mpdu_num--;
+
+	if (!cl_rx_reorder_ready(tid_agg_rx, index)) {
+		__skb_queue_purge(skb_list);
+		goto no_frame;
+	}
+
+	/* For NON AMSDU - Single skb in skb_list
+	 * For AMSDU - Validate first skb and set PN flag for rest.
+	 */
+	skb = skb_peek(skb_list);
+	pn_state = cl_key_handle_pn_validation(cl_hw, skb, cl_sta);
+	if (pn_state == CL_PN_VALID_STATE_FAILED) {
+		__skb_queue_purge(skb_list);
+		goto no_frame;
+	}
+
+	while ((skb = __skb_dequeue(skb_list))) {
+		if (pn_state == CL_PN_VALID_STATE_SUCCESS) {
+			status = IEEE80211_SKB_RXCB(skb);
+			status->flag |= RX_FLAG_PN_VALIDATED;
+		}
+		__skb_queue_tail(frames, skb);
+	}
+
+no_frame:
+	tid_agg_rx->reorder_buf_filtered &= ~BIT_ULL(index);
+	tid_agg_rx->head_seq_num = ieee80211_sn_inc(tid_agg_rx->head_seq_num);
+}
+
+static void cl_rx_release_reorder_frames(struct cl_tid_ampdu_rx *tid_agg_rx,
+					 u16 head_seq_num,
+					 struct sk_buff_head *frames)
+{
+	int index;
+
+	lockdep_assert_held(&tid_agg_rx->reorder_lock);
+
+	while (ieee80211_sn_less(tid_agg_rx->head_seq_num, head_seq_num)) {
+		index = tid_agg_rx->head_seq_num % tid_agg_rx->buf_size;
+		cl_rx_release_reorder_frame(tid_agg_rx, index, frames);
+	}
+}
+
+static void cl_reorder_release(struct cl_tid_ampdu_rx *tid_agg_rx, struct sk_buff_head *frames)
+{
+	u8 index, i, j;
+
+	lockdep_assert_held(&tid_agg_rx->reorder_lock);
+
+	/* Release buffer until next hole */
+	index = tid_agg_rx->head_seq_num % tid_agg_rx->buf_size;
+	if (!cl_rx_reorder_ready(tid_agg_rx, index) && tid_agg_rx->stored_mpdu_num) {
+		u8 skipped = 1;
+
+		for (j = (index + 1) % tid_agg_rx->buf_size; j != index;
+		     j = (j + 1) % tid_agg_rx->buf_size) {
+			if (!cl_rx_reorder_ready(tid_agg_rx, j)) {
+				skipped++;
+				continue;
+			}
+			if (skipped &&
+			    !time_after(jiffies, tid_agg_rx->reorder_time[j] +
+					REORDER_BUF_TIMEOUT))
+				goto set_release_timer;
+
+			/* Incomplete A-MSDUs */
+			for (i = (index + 1) % tid_agg_rx->buf_size; i != j;
+			     i = (i + 1) % tid_agg_rx->buf_size) {
+				__skb_queue_purge(&tid_agg_rx->reorder_buf[i]);
+			}
+
+			cl_rx_release_reorder_frame(tid_agg_rx, j, frames);
+
+			tid_agg_rx->head_seq_num =
+				(tid_agg_rx->head_seq_num +
+				 skipped) & IEEE80211_SN_MASK;
+			skipped = 0;
+		}
+	} else {
+		while (cl_rx_reorder_ready(tid_agg_rx, index)) {
+			cl_rx_release_reorder_frame(tid_agg_rx, index, frames);
+			index = tid_agg_rx->head_seq_num % tid_agg_rx->buf_size;
+		}
+	}
+
+	if (tid_agg_rx->stored_mpdu_num) {
+		j = tid_agg_rx->head_seq_num % tid_agg_rx->buf_size;
+		index = j;
+		for (; j != (index - 1) % tid_agg_rx->buf_size;
+		     j = (j + 1) % tid_agg_rx->buf_size) {
+			if (cl_rx_reorder_ready(tid_agg_rx, j))
+				break;
+		}
+
+ set_release_timer:
+		if (!tid_agg_rx->removed)
+			mod_timer(&tid_agg_rx->reorder_timer, tid_agg_rx->reorder_time[j] +
+				   msecs_to_jiffies(REORDER_BUF_TIMEOUT_MS));
+	} else {
+		del_timer(&tid_agg_rx->reorder_timer);
+	}
+}
+
+static void cl_rx_reorder_release_timeout(struct timer_list *t)
+{
+	struct cl_tid_ampdu_rx *tid_agg_rx = from_timer(tid_agg_rx, t, reorder_timer);
+	struct sk_buff *skb = NULL;
+	struct cl_hw *cl_hw = NULL;
+	struct ieee80211_sta *sta = NULL;
+	struct sk_buff_head buffer;
+
+	if (!tid_agg_rx)
+		return;
+
+	__skb_queue_head_init(&buffer);
+
+	spin_lock(&tid_agg_rx->reorder_lock);
+
+	cl_hw = tid_agg_rx->cl_hw;
+	sta = tid_agg_rx->sta;
+	cl_reorder_release(tid_agg_rx, &buffer);
+
+	spin_unlock(&tid_agg_rx->reorder_lock);
+
+	while (!skb_queue_empty(&buffer)) {
+		skb = __skb_dequeue(&buffer);
+		ieee80211_rx_napi(cl_hw->hw, sta, skb, NULL);
+	}
+}
+
+static bool cl_rx_manage_reorder_buf(struct cl_tid_ampdu_rx *tid_agg_rx,
+				     struct sk_buff *skb,
+				     struct sk_buff_head *ordered_mpdu)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
+	u16 sc = le16_to_cpu(hdr->seq_ctrl);
+	u16 mpdu_seq_num = (sc & IEEE80211_SCTL_SEQ) >> 4;
+	u16 head_seq_num, buf_size;
+	u8 index;
+	bool ret = true;
+
+	if (unlikely(tid_agg_rx->auto_seq)) {
+		tid_agg_rx->auto_seq = false;
+		tid_agg_rx->ssn = mpdu_seq_num;
+		tid_agg_rx->head_seq_num = mpdu_seq_num;
+	}
+
+	buf_size = tid_agg_rx->buf_size;
+	head_seq_num = tid_agg_rx->head_seq_num;
+
+	/* Current SN is smaller than the SSN */
+	if (unlikely(!tid_agg_rx->started)) {
+		if (ieee80211_sn_less(mpdu_seq_num, head_seq_num)) {
+			ret = false;
+			goto out;
+		}
+		tid_agg_rx->started = true;
+	}
+
+	/* Out of date sequence number */
+	if (ieee80211_sn_less(mpdu_seq_num, head_seq_num)) {
+		dev_kfree_skb(skb);
+		goto out;
+	}
+
+	/* SN exceeds buffer window */
+	if (!ieee80211_sn_less(mpdu_seq_num, head_seq_num + buf_size)) {
+		head_seq_num = ieee80211_sn_inc(ieee80211_sn_sub(mpdu_seq_num, buf_size));
+		cl_rx_release_reorder_frames(tid_agg_rx, head_seq_num, ordered_mpdu);
+	}
+
+	index = mpdu_seq_num % tid_agg_rx->buf_size;
+
+	/* Frame already stored */
+	if (cl_rx_reorder_ready(tid_agg_rx, index)) {
+		dev_kfree_skb(skb);
+		goto out;
+	}
+
+	if (mpdu_seq_num == tid_agg_rx->head_seq_num &&
+	    tid_agg_rx->stored_mpdu_num == 0) {
+		if (!(status->flag & RX_FLAG_AMSDU_MORE)) {
+			tid_agg_rx->head_seq_num =
+				ieee80211_sn_inc(tid_agg_rx->head_seq_num);
+		}
+		ret = false;
+		goto out;
+	}
+
+	/* Insert frame into reorder buffer */
+	__skb_queue_tail(&tid_agg_rx->reorder_buf[index], skb);
+	if (!(status->flag & RX_FLAG_AMSDU_MORE)) {
+		tid_agg_rx->reorder_time[index] = jiffies;
+		tid_agg_rx->stored_mpdu_num++;
+		cl_reorder_release(tid_agg_rx, ordered_mpdu);
+	}
+
+ out:
+	return ret;
+}
+
+void cl_rx_reorder_ampdu(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			 struct sk_buff *skb, struct sk_buff_head *ordered_mpdu)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct cl_tid_ampdu_rx *tid_agg_rx;
+	u8 tid, ack_policy;
+
+	if (!cl_sta)
+		return;
+
+	ack_policy = *ieee80211_get_qos_ctl(hdr) &
+		     IEEE80211_QOS_CTL_ACK_POLICY_MASK;
+	tid = ieee80211_get_tid(hdr);
+
+	tid_agg_rx = cl_sta->tid_agg_rx[tid];
+	if (!tid_agg_rx)
+		return;
+
+	spin_lock(&tid_agg_rx->reorder_lock);
+	if (!ieee80211_is_data_qos(hdr->frame_control) ||
+	    is_multicast_ether_addr(hdr->addr1))
+		goto dont_reorder;
+
+	if (unlikely(hdr->frame_control & cpu_to_le16(IEEE80211_STYPE_NULLFUNC)))
+		goto dont_reorder;
+
+	if (ack_policy != IEEE80211_QOS_CTL_ACK_POLICY_BLOCKACK &&
+	    ack_policy != IEEE80211_QOS_CTL_ACK_POLICY_NORMAL)
+		goto dont_reorder;
+
+	/* Ignore EAPOL frames */
+	if (cl_is_eapol(skb))
+		goto dont_reorder;
+
+	if (cl_rx_manage_reorder_buf(tid_agg_rx, skb, ordered_mpdu)) {
+		spin_unlock(&tid_agg_rx->reorder_lock);
+		return;
+	}
+
+ dont_reorder:
+	spin_unlock(&tid_agg_rx->reorder_lock);
+
+	if (cl_key_handle_pn_validation(cl_hw, skb, cl_sta) == CL_PN_VALID_STATE_FAILED) {
+		dev_kfree_skb(skb);
+		return;
+	}
+
+	__skb_queue_tail(ordered_mpdu, skb);
+}
+
+void cl_rx_reorder_close(struct cl_sta *cl_sta, u8 tid)
+{
+	struct cl_tid_ampdu_rx *tid_agg_rx = cl_sta->tid_agg_rx[tid];
+	u16 i;
+
+	spin_lock_bh(&tid_agg_rx->reorder_lock);
+	tid_agg_rx->removed = true;
+	spin_unlock_bh(&tid_agg_rx->reorder_lock);
+
+	del_timer_sync(&tid_agg_rx->reorder_timer);
+
+	spin_lock_bh(&tid_agg_rx->reorder_lock);
+	for (i = 0; i < tid_agg_rx->buf_size; i++)
+		__skb_queue_purge(&tid_agg_rx->reorder_buf[i]);
+
+	kfree(tid_agg_rx->reorder_buf);
+	kfree(tid_agg_rx->reorder_time);
+	cl_sta->tid_agg_rx[tid] = NULL;
+
+	spin_unlock_bh(&tid_agg_rx->reorder_lock);
+	kfree(tid_agg_rx);
+}
+
+void cl_rx_reorder_init(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u8 tid, u16 buf_size)
+{
+	struct cl_tid_ampdu_rx *tid_agg_rx;
+	u16 i;
+
+	tid_agg_rx = kzalloc(sizeof(*tid_agg_rx), GFP_KERNEL);
+	if (!tid_agg_rx)
+		return;
+
+	spin_lock_init(&tid_agg_rx->reorder_lock);
+
+	timer_setup(&tid_agg_rx->reorder_timer, cl_rx_reorder_release_timeout, 0);
+
+	tid_agg_rx->reorder_buf =
+		kcalloc(buf_size, sizeof(struct sk_buff_head), GFP_KERNEL);
+	tid_agg_rx->reorder_time =
+		kcalloc(buf_size, sizeof(unsigned long), GFP_KERNEL);
+	if (!tid_agg_rx->reorder_buf || !tid_agg_rx->reorder_time) {
+		pr_err("Allocation failed!\n");
+		kfree(tid_agg_rx->reorder_buf);
+		kfree(tid_agg_rx->reorder_time);
+		return;
+	}
+
+	for (i = 0; i < buf_size; i++)
+		__skb_queue_head_init(&tid_agg_rx->reorder_buf[i]);
+
+	tid_agg_rx->ssn = 0;
+	tid_agg_rx->head_seq_num = 0;
+	tid_agg_rx->buf_size = buf_size;
+	tid_agg_rx->stored_mpdu_num = 0;
+	tid_agg_rx->auto_seq = 0;
+	tid_agg_rx->started = false;
+	tid_agg_rx->reorder_buf_filtered = 0;
+	tid_agg_rx->tid = tid;
+	tid_agg_rx->sta = cl_sta->sta;
+	tid_agg_rx->cl_hw = cl_hw;
+	cl_sta->tid_agg_rx[tid] = tid_agg_rx;
+}
-- 
2.36.1

