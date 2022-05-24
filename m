Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D93753298D
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236980AbiEXLmG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbiEXLk6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:40:58 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2006A9347F
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:40:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHCYfWENgX9edqHq7ZAr6m/r6xddqjtCgv39Ma0w6qUC6jKGldp8jqjeymHYsJPxG1M5H0CXafvTYHOLOtkyOkp3Bu1Km8PInl/HtkzexvwRvKb+H9K9Si3TqfHoVc1sT7IqFUv83Nw6lTHcOazbBjRynvd4PbwXlUEWYC0804+owst91qa7XeEKU0FHaOI6mJEonntxu2Oq6SKgDmq8CLYtJvc69Ju/gNaMUcna5mnAFMwa+t5evRf0uxSSPzwTvcPJJogqvZnubTL2GaCkY5xA5koOT4hda7j4HSPpa1oIShY4+rzaRuznxRXzXyyYGX9jYMfH0lHGL8PW1Ab2pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lr4KfbZp0c5+FYZarLChMg4QXcVBZDHWfkW1aTrtzyM=;
 b=Qgslz37XtYga1DXRoICcGjWln4jf4BEKD/LUGjxleV1SZdfzUqg6NEuA5lcnhZeKcbhd71HIer2g+LF62qiV4YJ38cqbXyIiEV7UdZl66ABIETPwrU5V+5KRAkQpiiDl53uI0NXW8mii3ShjQkkdFn3TdXNfP8XHBxi9nFRFzDgDpfI3f4DcUT/DicI/JslszKWls6NZzwuFFiNtvuQWMLHfIP0zJKURWLyknBdJUmrbHf/SvN53aPKBvpxJpzeVRbBJMyr2xB73exirn1eVSVPv7CF2MR9N9ydmU7Ci3wTPO+pkxRZZzvJcvnaQ8R1yFck1scKEuxTLFc6HGZd7tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lr4KfbZp0c5+FYZarLChMg4QXcVBZDHWfkW1aTrtzyM=;
 b=FJYOiWdt35KO1v6fpGjRP1zlvNtRR+gy/HtuMtzPQ5sPbNmAHPbOI119Qm6NYqgPLHN3Xyge8kpi8uKUb42X/m5nC96JkAd46utnpxP1997JSRG8+RW0xSK0Av3tPKrfNXsgm07NI/yb+DQgm0TsMFiEFJPJ7J0auD0KL6cE9JI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VE1P192MB0669.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:16f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:39:31 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:31 +0000
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
Subject: [RFC v2 83/96] cl8k: add traffic.h
Date:   Tue, 24 May 2022 14:34:49 +0300
Message-Id: <20220524113502.1094459-84-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: ae011785-a594-4742-15f7-08da3d79fc4b
X-MS-TrafficTypeDiagnostic: VE1P192MB0669:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VE1P192MB06694D90B08C4D9F6B003132F6D79@VE1P192MB0669.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r1QIp5Tjp+kOUcgj/B/0qnuQy9BRlH744f0WNPfIpvHvYTYcAZ2/gxOeJoyQPSkvqDs6qt7BypGdlNV2VGtlplW8U65flA9/C4nsFqooJsvaMb62hka8ISO5d331RKpqklutUV/P8ILgv1qSwVUW49sEjNd3PCg14pfIIOHG60mUj6XPDTgxUlXQamTgJztLRlUU4YsG52PzQ+9+nZ7R2gOswlkm4xW9z2rjAI5VsRrxUMj+1ZM6uecwnXmHlS76N9y0LPmfqYfhYLNB0lLdA2icMwmTptE7iq0AZOKCjVBsbHrxWZwosVw9hR4IlS6u7HRKTJ9R/YdVhkF8+VR43Jc9DU8X282qQzeNfzN3/RjK24PqTtPY4DgR/ZFkDg4j+Vr046PjGN5FT03FGObK0Zc9l3ufEHjNbClHHCzNwV8suBknPHUpl0JOIDeKHtFRq/6KVBmAeO7FOrBajxAjxOkp2SwxaN1F5GhrMK492vajQ+AMocmPAccBPDKnVb4R5RJmDLz8fhH6O30JwlcV4AMNhlgeYTJns16Yr4auu65vhPoDwzpKt6Fo2FmlJUsMeOm75T9UCTacTF6JzGbOhackiqxcBzY5s1wnfDO7r0/7rwXN2beqtPg6z1oaDzVujo4wYZL3SHwmJeIGA/zqOr2mvZfnoOuQEoXeusyeWSNaOIr/HDU63OJpq5igJuELW8/gvslxH1kzWKqlabid3h47Bta4aBg6DujzdhgSYYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(376002)(136003)(366004)(346002)(39850400004)(8676002)(9686003)(26005)(36756003)(66946007)(66556008)(66476007)(4326008)(107886003)(6512007)(5660300002)(38350700002)(38100700002)(1076003)(2616005)(316002)(6916009)(6506007)(6486002)(54906003)(86362001)(8936002)(508600001)(41300700001)(6666004)(2906002)(186003)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b5OMfFk1W3wr8W7wO0RsMy1hVgBJEpjoK3gsNXB6SX2LeBdrND6X9lvEgacb?=
 =?us-ascii?Q?tY1/c8CN9DkqOIEVjA7jfQBQyL+OPtHNdejawF1DEnO04P/0NYk7xz2oSoY8?=
 =?us-ascii?Q?14OocPGY2VZlZb6VET+GzZLf4GKbTAPOipba8LzSR4Bxkcx6xkSAwJ9z9z1D?=
 =?us-ascii?Q?lSl5dvk04SOSRMhO7Bcf6xsG/ZABtVeZl9ia98rSvc+/yXjWc5jbfdwalerV?=
 =?us-ascii?Q?AgzrnAgLLhHOFpCFTGb0tA3qom+HSgkv9sPZ6ylJ1bpYY9YK48SoiEO2+dwj?=
 =?us-ascii?Q?2cua7x+jS/iYIRRv8iM6o7WWZAWQWQqPpLdiXRCZdhAicHvX3+LLX3ygAnrv?=
 =?us-ascii?Q?tiYPtitI/vIILqDMJ+e4psaAATWH/gIZJz82jlZ/hVOuxUageHBK8Asa/ftj?=
 =?us-ascii?Q?MVBrvDlOB6fYrRiVOItkAGOCGHGxJVU+tlyyym71iAK1NCDL/1znhP08ZRdq?=
 =?us-ascii?Q?JXHNU9nABRtnGGkks13qD0qOOJDcbN1mQV9lNZ4zyF6HIh5gTwWCw0K2kFSO?=
 =?us-ascii?Q?W/wfM+ClaNOAcgm0CdfZPpAlgI+/+2pKE3p4P5c5/XnZyswaaQUIYAelH0aO?=
 =?us-ascii?Q?RxozVA47OUyKlnehMo1glqi5A8tFpOBkyCV6Prle/UlGOCId8DNuKynOkWSJ?=
 =?us-ascii?Q?T+CB92odt1nN1P5+CvX5zjPu5t4gLPEdDCmAR2qykVYvaE7apGxQMn9ftLxx?=
 =?us-ascii?Q?A4RIqF/QEQ9t7PV4IkjQKSoKOT9eYvqgzjfucXTfyXMGXGiwRzpyBsT3LERY?=
 =?us-ascii?Q?FdlDWT1WreM/b2/GaKxZIBhmhwfa7vZeMjNHgQHGio68ydXCYr+gjGOjquBS?=
 =?us-ascii?Q?jzKanVgDWO4yplvG0fK8JnDtOwAHUN1pD047kP7r8oaN+6hlAsPd6IEDer06?=
 =?us-ascii?Q?hV47zmNn0DyphRR089i9ee5QvkyL8el0MmhrbaLadjPradu+RBCLnk0LdZ7G?=
 =?us-ascii?Q?8Ik9SxhCilZsKksbt6++RI8uWA5Aboy8aSVnY+8S9HP2fnP28mKP43dh4HaR?=
 =?us-ascii?Q?wDa2bJLl6YVGfX2bjXSDJMpR35qfX6q6ShMyZynEg/p9/UNJEpediyAsdxvN?=
 =?us-ascii?Q?ANhairAPJk1mjLoxJ45BZd+oD9xKUxozOr+mWsxpyttjfquVwTdll2AMRGDk?=
 =?us-ascii?Q?URt0hi0hjDS6odno9JcFfadwG49qWKrhwX6ku+Y9NRoNwYQeMI2i+li2y/qz?=
 =?us-ascii?Q?qi+S99Pl6GzKbukqAL7pwM750w9zXvjowieBO8j4Z50T15z4b7wDsPY1iWW+?=
 =?us-ascii?Q?IAOSF9ifE5Lwh7BkYP8zORB5RFmig5c+YKIQ8gFIBEzRtbp6OD2y48YRWlUH?=
 =?us-ascii?Q?+hPOsDpz9V3nUBDaa+mEZBtXG1Nqr3pJ9Rk5Egay7svNzkSrRjp57YGmfd77?=
 =?us-ascii?Q?7ZFAQWpLiEHKZnh0XHY65KP6dyo0gdQyO7CvWIeAg0jgVUTHRhjblVVJYNtf?=
 =?us-ascii?Q?RuzcdPaAjPKQZbp01MJtUkj1fI3YEUpCB9h4K4cxMXFe1XJ1i00P+OAZacqo?=
 =?us-ascii?Q?YZW0kMforyDkOF8xdSkKSppAFrcCYwWN3zafVL/aXeRPsTOrLJ1MrWkct8k6?=
 =?us-ascii?Q?oDd841DTWQYF0SEdwMoiXdSuk++USDxFF7rak/4y4AGlAKOp5OtIdeK5GEvP?=
 =?us-ascii?Q?pwk6mYpgE8uZmYB1nbkKqjKTiS2Cl3wP4UTbMvVHv7YQqFde0M5jYSez0GMB?=
 =?us-ascii?Q?SJfrSREMo8Ntad9/WhybC1y7AXWBaBtVTAWasxvqMPVD8aITR7GY6tsui2KV?=
 =?us-ascii?Q?95lxnWEIoqqWn9f5TGq8B1kI7/GNQOc=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae011785-a594-4742-15f7-08da3d79fc4b
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:56.0868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nU+LL1GQBIqUodwG3nWJqiRbzRAZ/mHA6B5BO79NJ1o9PpbujtH5xasT3MbbrGyOPUau3bnedUCeVtjDN1XkZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P192MB0669
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
 drivers/net/wireless/celeno/cl8k/traffic.h | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/traffic.h

diff --git a/drivers/net/wireless/celeno/cl8k/traffic.h b/drivers/net/wireless/celeno/cl8k/traffic.h
new file mode 100644
index 000000000000..1b820602c94a
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/traffic.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_TRAFFIC_H
+#define CL_TRAFFIC_H
+
+#include <linux/dcache.h>
+#include <linux/skbuff.h>
+
+enum cl_traffic_mon_protocol {
+	CL_TRFC_MON_PROT_TCP,
+	CL_TRFC_MON_PROT_UDP,
+	CL_TRFC_MON_PROT_MAX,
+};
+
+enum cl_traffic_mon_direction {
+	CL_TRFC_MON_DIR_DL,
+	CL_TRFC_MON_DIR_UL,
+	CL_TRFC_MON_DIR_MAX,
+};
+
+struct cl_traffic_mon {
+	u32 bytes_per_sec;
+	u32 bytes;
+};
+
+enum cl_traffic_direction {
+	TRAFFIC_DIRECTION_TX,
+	TRAFFIC_DIRECTION_RX,
+
+	TRAFFIC_DIRECTION_MAX
+};
+
+enum cl_traffic_level {
+	TRAFFIC_LEVEL_DRV,
+	TRAFFIC_LEVEL_BF,
+	TRAFFIC_LEVEL_MU,
+	TRAFFIC_LEVEL_EDCA,
+	TRAFFIC_LEVEL_DFS,
+
+	TRAFFIC_LEVEL_MAX
+};
+
+struct cl_traffic_activity {
+	u8 cntr_active;
+	u8 cntr_idle;
+	bool is_active;
+};
+
+struct cl_traffic_sta {
+	struct cl_traffic_activity activity_db[TRAFFIC_LEVEL_MAX];
+	u32 num_bytes;
+	u32 num_bytes_prev;
+};
+
+struct cl_traffic_main {
+	u32 num_active_sta[TRAFFIC_LEVEL_MAX];
+	u32 num_active_sta_dir[TRAFFIC_DIRECTION_MAX][TRAFFIC_LEVEL_MAX];
+	u32 active_bytes_thr[TRAFFIC_LEVEL_MAX];
+	bool dynamic_cts;
+};
+
+struct cl_sta;
+struct cl_hw;
+
+void cl_traffic_mon_tx(struct cl_sta *cl_sta, struct sk_buff *skb);
+void cl_traffic_mon_rx(struct cl_sta *cl_sta, struct sk_buff *skb);
+void cl_traffic_mon_sta_maintenance(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_traffic_init(struct cl_hw *cl_hw);
+void cl_traffic_tx_handler(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u32 num_bytes);
+void cl_traffic_rx_handler(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u32 num_bytes);
+void cl_traffic_maintenance(struct cl_hw *cl_hw);
+void cl_traffic_sta_remove(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+bool cl_traffic_is_sta_active(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+bool cl_traffic_is_sta_tx_exist(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+
+#endif /* CL_TRAFFIC_H */
-- 
2.36.1

