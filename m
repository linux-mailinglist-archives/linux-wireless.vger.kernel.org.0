Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D786953298F
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbiEXLks (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbiEXLkm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:40:42 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00041.outbound.protection.outlook.com [40.107.0.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489AF8CCF2
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:40:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y10+JGXUeOkSl02b/vo7aelSFUkr4A50JcWoSDczOlXzF/e8TJEZvciCS6vFdb8ubb6ZCWzWZSeargbISPnwg25BgC7at6o0y5s+mLkVfAPLHaAOMiI1XZ19kBC0FJQZk9P9/THNoBUd2ceFo/4wDtANMfSRZz7KbZRTEJyFANdlQ+BiEsRsyFrUzZEDonlCuSN+dZU70VblGIrhqtz18oan6Pwp2iWa3sBghE5oczBvqf39aeiCmC4c2MAXDqFfaORJIpTKwbyjsryuNE7gkG3b/77ylIJsr3E6X1spc6GKlWltxumJKXd0YuWR3v0luMsQc3WIcjL+826+oWGRvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jq9xtePaeQ03sbSbP+zGe1BtdAMepLr/4o+DOmD1hJk=;
 b=XK5U8HomLkiN16k2u0LjPXnH6i0E9o/m/g+WEeX/nU5P092Y6zfiJ25PGLciJP0qoOzeu6afzwkGOGDXlyTBZkvUYLqE9NvbCxIPkRq8fPlR7wTVoXK/qNZ5y8nipdDfjjQWZ/ZSkWudhahtGX9eTrjpZU8tPABH20IfwXSFRUio73N9oC0/jRmwuKwwBvK7otRd50C5zqqPG4uUPVOe+G858VFT/NHD2qxIYZ1hWr7MXPXBAC5KyDgFA8cQEZFoucBKAp3X9BX3zv7OrHeTNH8LK+NntVoThG0cUdKogQIGVtpApmGTKG7nptT6Qk9yYAQ8jrduecL2dmXC0P7kXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jq9xtePaeQ03sbSbP+zGe1BtdAMepLr/4o+DOmD1hJk=;
 b=SHd73JnIbP8qX2MU5TApWBIK5P2QPhXuD1UUdC2i96OC+2YUmhno/wlvCNRiWSpvuh4CH2XkKWY/LW6r3IdJJVzFgnh5WrXt1A2p9CTtYcqNUvfFlt7mW3VzTpOhzsKpxBhGO2Bp7yyQY+rKPs2iAlLV4LQmtSwlXLi+twrbk/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by DBAP192MB1033.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:1b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 11:40:05 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:40:05 +0000
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
Subject: [RFC v2 91/96] cl8k: add vif.h
Date:   Tue, 24 May 2022 14:34:57 +0300
Message-Id: <20220524113502.1094459-92-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7b63ce08-379f-46e5-6dae-08da3d7a002b
X-MS-TrafficTypeDiagnostic: DBAP192MB1033:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <DBAP192MB10335280D97A1AE68B6901EFF6D79@DBAP192MB1033.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yW4GqbLTfM+5OsnXMhGys4yrKW0XKuzSmI44q2zbc+RBpESpcnDElV/ulmZULNwZ8pMgEBjBClCxw72SFk8nJsLWGdKhF9AEDUYe4OvrHofU/L1+Jk7m4YDRVr3mYF21sNt9bGrkF3TpBR+s4bmihZs1MmjR7v2Uw+LResV+e7UbBiFPdAr4kq2BdkCEDFQzBgLkB6niQDyvDqhJgXyHrD/BGaOY5O8M+JmpVoNaVp/s4u2OR8HWbAwAv1agETQpXwqn9yCHETx6FdP+a2ZcoBfTGvLeaMDHT0KLHuUJhxyGLTyJyDNSzSi9wzNGNojfTuqTaSwNgmyULKIdxI3rD7KEdrlul6Q54Muxk5n3e6IV0ye2Bq0IUA+y9ll+cVZmLQY7gsCOp4WQhDypBC9cIdF/aXg2XU/IWFTTK3KuGqfiSZ9Nm0uwOJ6BdazryLlknfY6fziFn0zTG4SLzsmUWpIZ7bLa42Hd4at92Wo9H9kZ23xH1femYqGsbtvxFzJ0dPKsb9nEbFmKwksKhqvBa2xTkxdnbO4AKMFW56BtzIihY2tlpDvyLzO3c3j0T4NHOD4uh4t35b2Rf5SaS6shcKswiLBuNMGf+mjwu36pjwEG/eAvyPJww0516BbhuiHrcMvEbh6jWxgukiA4Z3E4F7Mr2JKBCGEVuqv2ucOIE0AfowdKvGSVzdjSLJkydvrRoVP17oxZ1aP1oIiBrLQFC3iBfoYVZ+LAlvMyj0RXEcA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(346002)(376002)(366004)(136003)(396003)(39850400004)(2906002)(4326008)(6916009)(38350700002)(8676002)(86362001)(316002)(54906003)(38100700002)(66476007)(66556008)(26005)(2616005)(52116002)(9686003)(36756003)(6486002)(66946007)(6512007)(6506007)(107886003)(5660300002)(508600001)(83380400001)(8936002)(186003)(1076003)(41300700001)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FvFVUSydHtTTI0rVSsuwT53zFHX+fahEr2hVD7uMyPBuIlwnRoChzAn+FIJO?=
 =?us-ascii?Q?XnkU1gE0MnZ/otQ4pXOVfgJaoNJbRDoosQy2GrCjqHTejBMCHJH8u3ULXN3u?=
 =?us-ascii?Q?WwtDNwPb2CjPyQ6o5qChGL2JuiBlrvMQGhtUj0KnK/lz3/N/cy8vFupGXUN4?=
 =?us-ascii?Q?h+pvp//XBEr/tqnpcAhwMROn4gPuVPRGoHdI3HJcUFpT0pqDP61C2OHJuC83?=
 =?us-ascii?Q?xFT4C4zLiJFeEiKSvu3OdG2wpZooLT7/S0KTq+z/BBoXteW3jjxteXnbQCcX?=
 =?us-ascii?Q?8E+faz/y6EXLvB6P1FHNWNGqHVs3/P6wEbO/UZs7SAEcuPqilRUGzxPo7nnK?=
 =?us-ascii?Q?zmVB8Bx3kX4iLdrOMbYHPXrX05Gm9cyEaGkKiXNw/pJfGNcanKATL2bouSID?=
 =?us-ascii?Q?l4x41+XIljHPHfg1dOIgjl9pajUgIc+8mlneKEZmYx7DG171r3hQeTcSzH5p?=
 =?us-ascii?Q?Wl+E+QmPfOPEOH7ouu1SckNS3UU/oL16ACP7V+uoASiSNRV0ZrDDIwq5vZrV?=
 =?us-ascii?Q?PfFSFAkIO7Tf4ITL9gXnCoRtw0L0bwU6sHUdEpyL7o8hc/xv4WegyAJlNLmF?=
 =?us-ascii?Q?u5N+9f9Vz1OpnNKy2LsE8/mcMOkNYhslPfKa+DbhtKQHlEpwPJq9gg2UyGlg?=
 =?us-ascii?Q?s6YZjmCH/rdYKqWnwpdFnanJCBSNMFW1H7T8fck4kgivs0NWBDOuLxFnhyFd?=
 =?us-ascii?Q?Ngsn8Md+05NSO5MicEzXprMOJXktgedy8PfFxU4uxUE+hg6WHyGsf4DKT+2Q?=
 =?us-ascii?Q?YtZHSCzGxqJNZKFfviUS4T3+uzRPoM1oOMjdDvxdJuk9ZMHYfmkw3e+8FcqG?=
 =?us-ascii?Q?l/TlufU+YM6adnSyboC2WXf9P77iK/itSg8wNDZRlr4bSH0JQrrTuKVtyjnb?=
 =?us-ascii?Q?6lYTpmjws9S35DUuHud+NIDikUjpONK8k2AT8FcoDvMDm2UCKPqSIPgODOSn?=
 =?us-ascii?Q?dwhGfK4cnjOqhQ3EQjqOrs4pHSa7e+Il6AZJVe0zUvQEgOKI692MSI1zqHhQ?=
 =?us-ascii?Q?/WNkUTs3VN7NbUxLFvbxyUEmlZXV0qk8f+rPW0Q0E5LdM6LACTyJJMMbMMuc?=
 =?us-ascii?Q?/uFUOu9GYpT7hIqaflIpSAQ0aCWXDKlf0Q1a5Ftir7acyxlB/7fl/qjbrYKi?=
 =?us-ascii?Q?M5lXxHAnpdm60DtGELeFCyK0BDEzSCWGpuDCQ/zAp5NVce/jS0O+mklBfXg8?=
 =?us-ascii?Q?+SsHo38KC0FuGQIWY12n8HcgwmpOSIqRo8kP1VXPlT4yEKwmI8IQOd/7C5PQ?=
 =?us-ascii?Q?wlVWGL9rp3xHWKh5Rldwc6J/0CO5FLakVhRwOftHkl9NpMybtRsW0cUIsQS3?=
 =?us-ascii?Q?c6XLhI242X8bC8l84oACLBHhX5nTDMLsKr21x3tZJbvt21kaY55WZvd39lrX?=
 =?us-ascii?Q?tQHuM2Li1t1QOxeRJpyiVEaYwaoHSB+Gd5lpIGMmtU1VlH8GiLrs04QXwaFh?=
 =?us-ascii?Q?kJUi/lieeGgiLSO/wr+OsFudfCZ7h19B54VCRcNIQN3IvLVHLPWnJOQOXbBg?=
 =?us-ascii?Q?mVzdrP8DVxAue9YYMeuyXk1g/XeJFaKd0rMkJyaiqFAerVX9PflECotGHMmA?=
 =?us-ascii?Q?tPMHKD+1mOqVGadreqvi9RCPtzm8YxOsS1IXcVkQkNGDWmICrkm7kW6A0RSo?=
 =?us-ascii?Q?cKh+r3uel6B1EBLcsAo7ISgdYbB8aS43cICOI6iLD7gIl6SuapVNmw01mjxo?=
 =?us-ascii?Q?JWWGWIj+OyzObL9bD+EMLPGE7A7pU6uaUPInDkN99Rr4iPr0Mkh6J6fEd2i2?=
 =?us-ascii?Q?jMK3jYOugDgz4CTTc4718SVNsXzSwcY=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b63ce08-379f-46e5-6dae-08da3d7a002b
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:39:02.6215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDw6Em73yh4hCsrWSVWE043IJn/ll0Vx5z3XbqCEojFYK/MtpSaIsiRAZe0GcVDN12mzgTQV+tBqf5GqFX3a9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP192MB1033
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
 drivers/net/wireless/celeno/cl8k/vif.h | 81 ++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/vif.h

diff --git a/drivers/net/wireless/celeno/cl8k/vif.h b/drivers/net/wireless/celeno/cl8k/vif.h
new file mode 100644
index 000000000000..2563c6c3222d
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/vif.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_VIF_H
+#define CL_VIF_H
+
+#include <linux/netdevice.h>
+
+#include "wrs.h"
+
+struct cl_connection_data {
+	u32 max_client;            /* MAX Clients of the SSID */
+	u32 max_client_timestamp;  /* MAX Clients Timestamp of the SSID */
+	u32 watermark_threshold;   /* Number of clients threshold for watermark */
+	u32 watermark_reached_cnt; /* Number of times the watermark threshold was reached */
+};
+
+struct cl_traffic_counters {
+	u64 tx_packets;
+	u64 tx_bytes;
+	u64 rx_packets;
+	u64 rx_bytes;
+	u32 tx_errors;
+	u32 rx_errors;
+	u32 tx_dropped;
+	u32 rx_dropped;
+};
+
+/*
+ * Structure used to save information relative to the managed interfaces.
+ * Will be used as the 'drv_priv' field of the "struct ieee80211_vif" structure.
+ * This is also linked within the cl_hw vifs list.
+ */
+struct cl_vif {
+	struct list_head list;
+	struct cl_hw *cl_hw;
+	struct ieee80211_vif *vif;
+	struct net_device *dev;
+	struct list_head key_list_head;
+	struct cl_key_conf *key;
+	int key_idx_default;
+	u32 unicast_tx;
+	u32 unicast_rx;
+	u32 multicast_tx;
+	u32 multicast_rx;
+	u32 broadcast_tx;
+	u32 broadcast_rx;
+	u16 sequence_number;
+	u8 num_sta; /* Number of station connected per SSID */
+	struct cl_connection_data *conn_data;
+	u8 vif_index;
+	bool tx_en;
+	/* Holds info for channel utilization stats */
+	u32 chan_util_last_tx_bytes;
+	u32 chan_util;
+	struct mcast_table *mcast_table;
+	struct cl_wrs_rate_params fixed_params;
+	struct cl_traffic_counters trfc_cntrs[AC_MAX];
+	bool wmm_enabled;
+	u16 mesh_basic_rates;
+};
+
+struct cl_vif_db {
+	struct list_head head;
+	rwlock_t lock;
+	u8 num_iface_bcn;
+};
+
+void cl_vif_init(struct cl_hw *cl_hw);
+void cl_vif_add(struct cl_hw *cl_hw, struct cl_vif *cl_vif);
+void cl_vif_remove(struct cl_hw *cl_hw, struct cl_vif *cl_vif);
+struct cl_vif *cl_vif_get_next(struct cl_hw *cl_hw, struct cl_vif *cl_vif);
+struct cl_vif *cl_vif_get_by_dev(struct cl_hw *cl_hw, struct net_device *dev);
+struct cl_vif *cl_vif_get_by_mac(struct cl_hw *cl_hw, u8 *mac_addr);
+struct cl_vif *cl_vif_get_first(struct cl_hw *cl_hw);
+struct cl_vif *cl_vif_get_first_ap(struct cl_hw *cl_hw);
+struct net_device *cl_vif_get_first_net_device(struct cl_hw *cl_hw);
+struct net_device *cl_vif_get_dev_by_index(struct cl_hw *cl_hw, u8 index);
+void cl_vif_ap_tx_enable(struct cl_hw *cl_hw, bool enable);
+
+#endif /* CL_VIF_H */
-- 
2.36.1

