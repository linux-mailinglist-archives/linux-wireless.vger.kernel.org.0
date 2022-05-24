Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3CC53297D
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbiEXLly (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236945AbiEXLlw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:41:52 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00078.outbound.protection.outlook.com [40.107.0.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FB7614F
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:41:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcXTaLL6d7vyXs6bySyCzvEPt/t80zB1P+klCspzKHY3LK7cQ7cPHZljxwyQ2TcV/IQ0KkbRDTNmkXzyX+fhiwvRLPJWwokN6rsaafUgPLPR/ko1/JkMoE3qisgjrGcc5CfYcALLr4gZs29kPtbs1njTzMAqNOl7eIF9EPc5WSosBWIQXsanUhzim2zeZIlZzNabXL4aP/HYTMCOMv+/tA15TWvZRL63F168FpWntnK9jPiYr8/gzs/gdkXkFVm6+/3fufei06266gP04arrIHKSy7h4AqROkyldtfUPQ43HG+u4kb2ABClyU+QUopAsqO+T9V9p1jmiUnnji9m1tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvsWW9LDg7mrJG0nernJxj5Xn8PXcHvPhbWwo6lXWEk=;
 b=mtZiOZCG689/VEXIsfCObwdmbbLxx2PQVpUWIWTQ6LmxfKt7EYZBFQ0Y/8bniYSgOdaeX5uDp1b8QlR638/TWe3gk3Ua0isIIAam14u3EiC2wTWqzntSVR7hUoh059EYApuBKbUIR6xyKX+R4dTxFkn0RQgNX2hXj4RFKX0njj3z3GgXn4iMDaPu5foZQBCPgg2Av/aryEIlxlqtpztBOpM+atA7pZpOELnlf4mxGjEC4sPjAnHBvEI7dulzZluf/hQ4MVBByY1llKXHvj9C3ZosYbCDkiwG9qkrehLV05WKzgpqLDprRpESzLj43RCdwW0jBVQqtGa2nqf/P8z1lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvsWW9LDg7mrJG0nernJxj5Xn8PXcHvPhbWwo6lXWEk=;
 b=prP7AWse8sH6HrZkcMBlX71TnZNy8fiQjBuMglltmQJNX4YEd0Nuvw8z4QKIeKxr378AHUHDZ5hpzwNVSjH07fQXL8y5MUsHsVsas07Ql+RwcHUVXuCr5yYls9/DgROG4fT6rjlj+nW+lvilt3TiCa6rwxj3Rz42aM6awK1y7Ws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by DBAP192MB1033.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:1b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 11:40:07 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:40:07 +0000
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
Subject: [RFC v2 95/96] cl8k: add wrs.h
Date:   Tue, 24 May 2022 14:35:01 +0300
Message-Id: <20220524113502.1094459-96-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: ef899d36-d152-433c-c081-08da3d7a020a
X-MS-TrafficTypeDiagnostic: DBAP192MB1033:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <DBAP192MB1033364AD8F2C3E9FAE6D15BF6D79@DBAP192MB1033.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k5XryspG/xy+oTiikFcIwxLhrCfQmuNjQ7XrZd4NVYfR9yGuRO0P8U5I1rRrFcZt1l1XaLXME4EMgeoKe3jgREVaSTm5vQV517V5mGTvy2B30qKH3A8s/vdStBvyOZa28/0DtE8sk43iP52fc8ID6a9oaz5ZqUIFbfeT5uHWcj84E7RuDzzq4joHVzvXkaSD5JB9qhuuS6FY9o64bpbo0xcvlZ4+yQvMM2mbmBqE+Qk8biKmkIoMv266b3mLaWjL9CXYke1IQ+94NzIhS6ribRm1MWZQIQS5aDM3/j+IF/2h+mLqq/77jBaIIGIUY/itOEvTiC8iHyKBScq458bKvAhvVAPIzS0DxFXk/T53/F0plNfek52MbDHaYnW0OBCP8uA4nt82wHfVcqosYe6JPuqQhw+rUcCeLK+ldPSTywjfEOgCln2o7I9GwWIcNTfx+Y/7VjkibyLIqh7ot7FzuboAWpvxw3AYqiuw7lpjPtqwAmKFpTHzd+8/ux3SvS7dhkC+Twav7vr0cm6exIc6R+ucVvzBAuyMow752XavuIHYjHpY+oVULL+Mu6WvtbrrD7rO035R3CEWttHItllaCfXQArrHXarmg+SyRHoj2QBCjS7CVm6UXWZBWBS7XjIgNcr13p32cWdNP8SnGFn90WmGMNOcE3uBc0xY/Nf13U6OeldVPeW7MT/IVWRM2d5X1TJXF0Wb9nRRtNNaXVHEWNwP6SPQm8P4hUwgAI95VOU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(346002)(376002)(366004)(136003)(396003)(39850400004)(2906002)(4326008)(6916009)(38350700002)(8676002)(86362001)(316002)(54906003)(38100700002)(66476007)(66556008)(26005)(2616005)(52116002)(9686003)(36756003)(6486002)(66946007)(6512007)(6506007)(30864003)(107886003)(5660300002)(508600001)(83380400001)(8936002)(186003)(1076003)(41300700001)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EMHj+qm5XGBwJfVZ8m6jHJ0WCzaDzxUfPXGocYPsfTRv/OA1Inmo0eILL/US?=
 =?us-ascii?Q?NbrOtEYWlgBdCNZq+YlPhQY4wJm/gllL7KSohaVg/nUo6VdryiNq+HYqNXkK?=
 =?us-ascii?Q?+OJ0oezuV/WsJndKNfaZC06kl8UNg/0sS+q1kIdFXJX/x5FhJZftyefsBtOI?=
 =?us-ascii?Q?uH4N7Tho0fXPQvOQLvt0VUJrN/3jmWFWLOAe6gTVPiSnSceOtu4vMdSylb0P?=
 =?us-ascii?Q?rs887voVVUWmYFXlCkJsw8VKLOJvBQihyz2dOtVxLPwr0erv5GBR+CVSAhmd?=
 =?us-ascii?Q?jEUkSrYFRnKc6BkAIFAi7I/VWEp2jPJCrR6teL0ROBp2ls0MY0J4Vq5qvw/H?=
 =?us-ascii?Q?u6U9FhvYh2oT5UnY740o/eFUTEXuGj+lUYK+k2hgOOBK9b8cvN61u2euR924?=
 =?us-ascii?Q?ViFaKDzaSHxr48KQ/4I9lX61vSgoI5waUuCCD6hEsHyAWgLIrsHMYr38q28V?=
 =?us-ascii?Q?/UnwoAj+h+1jr83wZ0XUoi9CT7spuja2JJRfjTw3cwAUF8BdMkDUDGgFl3wE?=
 =?us-ascii?Q?ZR9/ieVeHfgHVyBwftPa3ZXteuwiMFbkhHQ1e3jklP6B4IN+gwrW5fqfYcmK?=
 =?us-ascii?Q?8bZKrA9XJq9XDnvT9xDiGOp+bo0PesZ27BPpUzgsvW8/hGHNldCmuPEhwzRR?=
 =?us-ascii?Q?+Rq/X/EGpVUoLhgtctTNaHyZfkDeyXvJfkVGcS2pWLJLFoxE8dQiW7PgF+09?=
 =?us-ascii?Q?P+/bgdGj+6K6mFfqKzQVw15RMGNqvpIB37b+8XKGWAAS3Z1+l+NvwBnc9jQf?=
 =?us-ascii?Q?aqJ9A814fL8Vv2kK72hx7tuhasB7M1LOr57V3V63N63bTje42uTelrYp2JLW?=
 =?us-ascii?Q?62rQmUGKfsL3M1tPOiRVQuI69Hce+/N9cZl9hUReKuplCBnWN0jqrqq+/fwS?=
 =?us-ascii?Q?ic6PkIOoZCML79uqIHKaMJ8OR/ztFbngZGgDyG2p9PWP/u8lvvx9zd6ATb//?=
 =?us-ascii?Q?mKvlCGK5lovrgF/L4+m+2M+bqbQ/tBPxKx/cgEfcqemFg9cLssnzY5sW3Ivm?=
 =?us-ascii?Q?UcjKakzp3oHJxMwdxpD7vJOJNbib7LFxVvffAH70096xVgtWj8A0u7nFff0s?=
 =?us-ascii?Q?8hsfQe1vnVdkc6hpEB+3FqXn+lkeIXXWZenURWui+YOfFRHF8l/6Upn5R0an?=
 =?us-ascii?Q?uXaikKIiAWMSfHBV5w+aDZA8h0U4o/nS8N+fvu1PO3XxHjp/QEAHqJ+U9RqZ?=
 =?us-ascii?Q?Da2mTbt54p6WwPEZHHIt7qyBQA52hgoRtz41majm/pRzzA+smbu8KZFSe3eY?=
 =?us-ascii?Q?k5G+ydrAmf407Zz+2wbzcnYLTrlBTAv/qxpLN4IhT6jfEPh4GpisXl4nk1C2?=
 =?us-ascii?Q?SIqnEuM3SPa03L4+Ycs7nvLo5ABtr7e6uC2drjlQAXVsuDmqHtdbvd7ozMfw?=
 =?us-ascii?Q?Ajr9VbL+InE63QZHewZgOEMcCGbyeixYzAHYdcxCf7UDi0iSG0s6sXsYI5Qm?=
 =?us-ascii?Q?Oqi/gAigMs019dhMJO0G0iiPTrTwGFUnzeyrutamurqGt0uMEQOvqYuiQcFI?=
 =?us-ascii?Q?cE2JqPjX7P3R42+ln3ttlvwzATsWHdVIq+sQ5TyDYLVZd5hd0pjun39YVbiN?=
 =?us-ascii?Q?j0EuC5TuS1hKEFu9IJS97s409v7zuMuORwKFNyGgkmoIAke0yBgrcYeQAHQg?=
 =?us-ascii?Q?l5pOzEg577OZItWcQC9kSO5osXz2XnB1PWY1K187TQF6odCOpAlKP1PThyx8?=
 =?us-ascii?Q?oBb5N3oFKu0YrlxPSbCtkkQf68UlXMpKRMPZcF1RWGHfNscwgzme7sih1y5i?=
 =?us-ascii?Q?iI3UKL4Wbj+TUwttNBEQweuG7xJzF0o=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef899d36-d152-433c-c081-08da3d7a020a
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:39:05.7472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhW+kHXjCRWoeJ4GuK6Qg+XAVV062SaYFkj7Pxte8qs0suR9MSJPdw1b6L4Vm/jDmaUn0bEY9ty8CPfbcsblcA==
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
 drivers/net/wireless/celeno/cl8k/wrs.h | 565 +++++++++++++++++++++++++
 1 file changed, 565 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs.h

diff --git a/drivers/net/wireless/celeno/cl8k/wrs.h b/drivers/net/wireless/celeno/cl8k/wrs.h
new file mode 100644
index 000000000000..158d61b92ffc
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/wrs.h
@@ -0,0 +1,565 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_WRS_H
+#define CL_WRS_H
+
+#include <net/mac80211.h>
+
+#include "def.h"
+#include "debug.h"
+#include "rx.h"
+
+/**
+ * WRS (=Weighted Rate Selection)
+ */
+
+struct cl_hw;
+struct cl_sta;
+struct cl_vif;
+
+/* Rate Table Size */
+#define WRS_HE_RATE_TABLE_SIZE     (WRS_MCS_MAX_HE * WRS_SS_MAX * CHNL_BW_MAX * WRS_GI_MAX_HE)
+#define WRS_HT_VHT_RATE_TABLE_SIZE (WRS_MCS_MAX_VHT * WRS_SS_MAX * CHNL_BW_MAX * WRS_GI_MAX_VHT)
+
+/* Initial Thresholds */
+#define WRS_INIT_MSEC_WEIGHT_DOWN  (WRS_MAINTENANCE_PERIOD_MS * 3) /* Msec */
+#define WRS_INIT_MSEC_WEIGHT_UP    (WRS_MAINTENANCE_PERIOD_MS * 3) /* Msec */
+
+#define WRS_MSEC_WEIGHT_MIN        (WRS_MAINTENANCE_PERIOD_MS * 2) /* Msec */
+#define WRS_MSEC_WEIGHT_MAX_UP     30000 /* Msec */
+#define WRS_MSEC_WEIGHT_MAX_DOWN   4000  /* Msec */
+#define WRS_MSEC_STEP_DOWN         5000  /* Msec */
+#define WRS_MSEC_STEP_UP_SAME      1000  /* Msec */
+#define WRS_INVALID_RATE           ((u16)(~0))
+
+enum cl_wrs_table_node_up {
+	WRS_TABLE_NODE_UP_MCS,
+	WRS_TABLE_NODE_UP_BW,
+	WRS_TABLE_NODE_UP_NSS,
+	WRS_TABLE_NODE_UP_BF,
+	WRS_TABLE_NODE_UP_GI,
+
+	WRS_TABLE_NODE_UP_MAX
+};
+
+struct cl_wrs_table_validity {
+	bool is_valid;
+	u16 new_rate_idx;
+};
+
+struct cl_wrs_table_node {
+	u16 rate_idx;
+	u16 time_th;
+	bool quick_up_check;
+};
+
+struct cl_wrs_rate {
+	u16 mcs : 4,
+	    nss : 3,
+	    bw  : 2,
+	    gi  : 2,
+	    rsv : 2;
+};
+
+struct cl_wrs_table {
+	struct cl_wrs_rate rate;
+	struct cl_wrs_table_node rate_down;
+	struct cl_wrs_table_node rate_up[WRS_TABLE_NODE_UP_MAX];
+	u32 frames_total;
+	u32 ba_not_rcv_total;
+	u64 epr_acc;
+};
+
+#define WRS_MAINTENANCE_PERIOD_MS         40
+#define WRS_DATA_RATE_FACTOR              10
+#define WRS_RSSI_PROTECT_UP_THR           10
+#define WRS_RSSI_PROTECT_DN_THR           10
+#define WRS_MIN_FRAMES_FOR_DECISION       15
+#define WRS_EPR_FACTOR                    105
+#define WRS_CONVERGE_IDLE_PACKET_TH       5
+#define WRS_CONVERGE_IDLE_INTERVAL_RESET  6000  /* 6 sec */
+#define WRS_CONVERGE_IDLE_INTERVAL_RSSI   2000  /* 2 sec */
+#define WRS_CONVERGE_TRFC_INTERVAL_STATIC 30000 /* 30 sec */
+#define WRS_CONVERGE_TRFC_INTERVAL_MOTION 1000  /* 1 sec */
+#define WRS_IMMEDIATE_DROP_EPR_FACTOR     70    /* 70% */
+#define WRS_IMMEDIATE_DROP_MAX_IN_ROW     U32_MAX
+#define WRS_SYNC_MIN_ATTEMPTS             4
+#define WRS_SYNC_TIMEOUT                  1000  /* 1 sec */
+#define WRS_QUICK_UP_BA_THR               5
+#define WRS_QUICK_UP_INTERVAL_MS          1000
+#define WRS_QUICK_DOWN_EPR_FACTOR         85
+#define WRS_QUICK_DOWN_AGG_THR            3
+#define WRS_QUICK_DOWN_PKT_THR            60
+#define WRS_RSSI_PROTECT_SHIFT            7
+#define WRS_RSSI_PROTECT_BUF_SZ_OLD       BIT(WRS_RSSI_PROTECT_SHIFT) /* 2 ^ 7 = 128 */
+#define WRS_RSSI_PROTECT_BUF_SZ_NEW       3
+#define WRS_BA_NOT_RCV_TIME_SINCE_SYNC    1000
+#define WRS_CCA_PERIOD_MS                 1000
+#define WRS_CCA_PRIMARY_SHIFT             7
+#define WRS_CCA_PRIMARY_FACTOR            160 /* 160 / 2^7 = 1.25 = 25% */
+
+enum cl_wrs_rssi_prot_mode {
+	WRS_RSSI_PROT_MODE_RSSI,     /* Up/down based on rssi */
+	WRS_RSSI_PROT_MODE_NEIGHBOR, /* Up/down based on neighbors */
+
+	WRS_RSSI_PROTECT_MODE_MAX
+};
+
+enum cl_wrs_fixed_rate {
+	WRS_AUTO_RATE,
+	WRS_FIXED_FALLBACK_EN,
+	WRS_FIXED_FALLBACK_DIS,
+
+	WRS_FIXED_RATE_MAX
+};
+
+enum cl_wrs_fixed_param {
+	WRS_FIXED_PARAM_MODE,
+	WRS_FIXED_PARAM_BW,
+	WRS_FIXED_PARAM_NSS,
+	WRS_FIXED_PARAM_MCS,
+	WRS_FIXED_PARAM_GI,
+
+	WRS_FIXED_PARAM_MAX
+};
+
+#define FIXED_RATE_STR(x) \
+	(((x) == WRS_AUTO_RATE) ? "auto rate" : \
+	(((x) == WRS_FIXED_FALLBACK_EN) ? "fixed rate (fallbacks enabled)" : \
+	"fixed rate (fallbacks disabled)"))
+
+enum cl_wrs_decision {
+	WRS_DECISION_NONE,
+	WRS_DECISION_SAME,
+	WRS_DECISION_UP,
+	WRS_DECISION_UP_QUICK,
+	WRS_DECISION_UP_RSSI,
+	WRS_DECISION_UP_MCS1,
+	WRS_DECISION_DOWN,
+	WRS_DECISION_DOWN_RSSI,
+	WRS_DECISION_DOWN_IMMEDIATE,
+	WRS_DECISION_DOWN_QUICK,
+	WRS_DECISION_DOWN_NO_SYNC,
+	WRS_DECISION_RSSI_MGMT,
+	WRS_DECISION_RX_RATE,
+
+	WRS_DECISION_MAX,
+};
+
+enum cl_wrs_mcs {
+	WRS_MCS_0,
+	WRS_MCS_1,
+	WRS_MCS_2,
+	WRS_MCS_3,
+	WRS_MCS_4,
+	WRS_MCS_5,
+	WRS_MCS_6,
+	WRS_MCS_7,
+	WRS_MCS_8,
+	WRS_MCS_9,
+	WRS_MCS_10,
+	WRS_MCS_11,
+	WRS_MCS_MAX,
+};
+
+#define WRS_MCS_MAX_CCK  WRS_MCS_4
+#define WRS_MCS_MAX_OFDM WRS_MCS_8
+#define WRS_MCS_MAX_HT   WRS_MCS_8
+#define WRS_MCS_MAX_VHT  WRS_MCS_10
+#define WRS_MCS_MAX_HE   WRS_MCS_MAX
+
+enum cl_wrs_ss {
+	WRS_SS_1,
+	WRS_SS_2,
+	WRS_SS_3,
+	WRS_SS_4,
+
+	WRS_SS_MAX
+};
+
+enum cl_wrs_gi {
+	WRS_GI_LONG,
+	WRS_GI_SHORT,
+	WRS_GI_VSHORT,
+
+	WRS_GI_MAX
+};
+
+#define WRS_GI_MAX_HT  WRS_GI_VSHORT
+#define WRS_GI_MAX_VHT WRS_GI_VSHORT
+#define WRS_GI_MAX_HE  WRS_GI_MAX
+
+enum cl_wrs_ltf {
+	LTF_X1,
+	LTF_X2,
+	LTF_X4,
+	LTF_MAX
+};
+
+enum cl_wrs_converge_mode {
+	WRS_CONVERGE_MODE_RESET,
+	WRS_CONVERGE_MODE_RSSI,
+
+	WRS_CONVERGE_MODE_MAX,
+};
+
+enum cl_wrs_mode {
+	WRS_MODE_CCK,
+	WRS_MODE_OFDM,
+	WRS_MODE_HT,
+	WRS_MODE_VHT,
+	WRS_MODE_HE,
+
+	WRS_MODE_MAX,
+};
+
+enum cl_wrs_type {
+	WRS_TYPE_TX_SU,
+	WRS_TYPE_TX_MU_MIMO,
+	WRS_TYPE_RX,
+
+	WRS_TYPE_MAX,
+};
+
+#define WRS_TYPE_STR(type) \
+		((type) == WRS_TYPE_TX_SU ? "TX_SU" : \
+		((type) == WRS_TYPE_RX ? "RX" : \
+		((type) == WRS_TYPE_TX_MU_MIMO ? "TX_MU-MIMO" : "")))
+
+#define WRS_TYPE_IS_TX_SU(wrs_params) ((wrs_params)->type == WRS_TYPE_TX_SU)
+#define WRS_TYPE_IS_TX_MU_MIMO(wrs_params) ((wrs_params)->type == WRS_TYPE_TX_MU_MIMO)
+#define WRS_TYPE_IS_RX(wrs_params) ((wrs_params)->type == WRS_TYPE_RX)
+
+/* m MUST be power of 2 ! */
+#define WRS_INC_POW2(c, m) (((c) + 1) & ((m) - 1))
+
+#define WRS_INC(c, m) \
+	do { \
+		(c)++; \
+		if ((c) == (m)) \
+			(c) = 0; \
+	} while (0)
+
+#define WRS_IS_DECISION_UP(decision) \
+	(((decision) >= WRS_DECISION_UP) && ((decision) <= WRS_DECISION_UP_MCS1))
+#define WRS_IS_DECISION_DOWN(decision) \
+	(((decision) >= WRS_DECISION_DOWN) && ((decision) <= WRS_DECISION_DOWN_NO_SYNC))
+
+#define WRS_DECISION_STR(decision) (                                   \
+	(decision) == WRS_DECISION_NONE           ? "NONE"           : \
+	(decision) == WRS_DECISION_SAME           ? "SAME"           : \
+	(decision) == WRS_DECISION_UP             ? "UP"             : \
+	(decision) == WRS_DECISION_UP_QUICK       ? "UP QUICK"       : \
+	(decision) == WRS_DECISION_UP_RSSI        ? "UP RSSI"        : \
+	(decision) == WRS_DECISION_UP_MCS1        ? "UP MCS1"        : \
+	(decision) == WRS_DECISION_DOWN           ? "DOWN"           : \
+	(decision) == WRS_DECISION_DOWN_RSSI      ? "DOWN RSSI"      : \
+	(decision) == WRS_DECISION_DOWN_IMMEDIATE ? "DOWN IMMEDIATE" : \
+	(decision) == WRS_DECISION_DOWN_QUICK     ? "DOWN QUICK"     : \
+	(decision) == WRS_DECISION_DOWN_NO_SYNC   ? "DOWN NO_SYNC"   : \
+	(decision) == WRS_DECISION_RSSI_MGMT      ? "RSSI MGMT"      : \
+	(decision) == WRS_DECISION_RX_RATE        ? "RX_RATE"        : \
+	"ERROR")
+
+struct cl_wrs_cntrs {
+	u64 epr_acc;
+	u32 total;
+	u32 fail;
+	u32 ba_not_rcv;
+	u32 ba_not_rcv_consecutive;
+};
+
+struct cl_wrs_rate_params {
+	u16 mode        : 3, /* Mode - 0 = CCK, 1 = OFDM, 2 = HT, 3 = VHT, 4 = HE. */
+	    gi          : 2, /* GI - O = Long, 1 = Short, 2 = Very short. */
+	    bw          : 2, /* Bandwidth - 0 = 20M, 1 = 40M, 2 = 80M, 3 = 160M. */
+	    nss         : 3, /* Spatial Streams - 0 = 1SS, 1 = 2SS, .. 7 = 8SS. */
+	    mcs         : 4, /* MCS - CCK (0 - 3), OFDM/HT (0 - 7), VHT (0 - 9), HE (0 - 11). */
+	    fallback_en : 1,
+	    is_fixed    : 1;
+};
+
+struct cl_wrs_logger {
+	unsigned long timestamp;
+	u16 rate_idx;
+	u32 success;
+	u32 fail;
+	u32 ba_not_rcv;
+	u16 down_rate_idx;
+	u16 up_rate_idx;
+	u16 curr_epr;
+	u16 down_epr;
+	u16 down_epr_factorized;
+	u16 penalty;
+	u16 up_time;
+	enum cl_wrs_decision decision;
+	u16 new_rate_idx;
+};
+
+struct cl_wrs_per_stats {
+	struct list_head list;
+	u8 mcs;
+	u8 bw;
+	u8 nss;
+	u8 gi;
+	u32 frames_total;
+	u32 frames_failed;
+	u64 epr_acc;
+};
+
+struct cl_wrs_rssi_prot_db {
+	s8 samples_old[WRS_RSSI_PROTECT_BUF_SZ_OLD];
+	s8 samples_new[WRS_RSSI_PROTECT_BUF_SZ_NEW];
+	u8 curr_idx_old;
+	u8 curr_idx_new;
+	s32 sum;
+};
+
+struct cl_wrs_params {
+	u8 group_id;
+	u8 is_mu_valid    : 1,
+	   is_fixed_rate  : 2,
+	   is_logger_en   : 1,
+	   quick_up_check : 1,
+	   type           : 2,
+	   rsv            : 1;
+	u32 up_same_time_cnt;
+	u32 down_time_cnt;
+	enum cl_wrs_converge_mode converge_mode;
+	u32 converge_time_idle;
+	u32 converge_time_trfc;
+	u16 data_rate;
+	u16 rate_idx;
+	u16 initial_rate_idx;
+	struct cl_wrs_table *table;
+	u16 table_size;
+	u16 penalty_decision_dn;
+	struct cl_wrs_rate_params rate_params;
+	struct cl_wrs_rate rx_rate_idle;
+	enum cl_wrs_decision last_decision;
+	u32 decision_cnt[WRS_DECISION_MAX];
+	struct list_head list_rates;
+	u32 frames_total;
+	u32 fail_total;
+	u32 ba_not_rcv_total;
+	u64 epr_acc;
+	bool calc_ba_not_rcv;
+	bool sync;
+	unsigned long sync_timestamp;
+	unsigned long no_sync_timestamp;
+	struct cl_wrs_logger *logger;
+	u16 logger_idx;
+	u16 logger_size;
+	u32 immediate_drop_cntr;
+	u32 immediate_drop_ignore;
+};
+
+struct cl_wrs_sta {
+	u8 sta_idx;
+	bool smps_enable;
+	u8 assoc_bw;
+	u8 he_minrate;
+	u8 gi_cap[CHNL_BW_MAX];
+	u64 supported_rates[CHNL_BW_MAX];
+	enum cl_wrs_mode mode;
+	struct cl_wrs_rate max_rate_cap;
+	struct cl_wrs_rssi_prot_db rssi_prot_db;
+	struct cl_wrs_params tx_su_params;
+	struct cl_wrs_params *rx_params;
+};
+
+struct cl_wrs_db {
+	/* General */
+	spinlock_t lock;
+	enum cl_dbg_level debug_level;
+	/* Timer */
+	struct timer_list timer_maintenance;
+	u32 interval;
+	/* Fixed rate */
+	u8 is_fixed_rate;
+	/* Conservative initial rate */
+	bool conservative_mcs_noisy_env;
+	bool conservative_nss_noisy_env;
+	/* Immediate drop */
+	bool immediate_drop_en;
+	u8 immediate_drop_epr_factor;
+	u32 immediate_drop_max_in_row;
+	/* Converge idle */
+	bool converge_idle_en;
+	u32 converge_idle_interval_reset;
+	u32 converge_idle_interval_rssi;
+	u32 converge_idle_packet_th;
+	/* Converge traffic */
+	bool converge_trfc_en;
+	u32 converge_trfc_interval_static;
+	u32 converge_trfc_interval_motion;
+	/* Supported rates */
+	u8 mode;
+	u64 ap_supported_rates[CHNL_BW_MAX]; /* Bit array for each bw */
+	struct cl_wrs_rate max_cap;
+	u8 coex_bw;
+	/* RSSI protect */
+	bool rssi_protect_en;
+	u8 rssi_protect_mode;
+	s8 rssi_protect_up_thr;
+	s8 rssi_protect_dn_thr;
+	/* Time + step thresholds */
+	u16 time_th_min;
+	u16 time_th_max_up;
+	u16 time_th_max_down;
+	u16 step_down;
+	u16 step_up_same;
+	/* Quick up */
+	bool quick_up_en;
+	u8 quick_up_ba_thr;
+	u16 quick_up_interval;
+	/* Quick down */
+	bool quick_down_en;
+	u8 quick_down_epr_factor;
+	u8 quick_down_agg_thr;
+	u16 quick_down_pkt_thr;
+	/* BA not received */
+	bool ba_not_rcv_collision_filter;
+	bool ba_not_rcv_force;
+	u32 ba_not_rcv_time_since_sync;
+	/* Sync */
+	u16 sync_timeout;
+	u8 sync_min_attempts;
+	/* CCA counters */
+	unsigned long cca_timestamp;
+	u32 cca_primary;
+	u32 cca_sec80;
+	u32 cca_sec40;
+	u32 cca_sec20;
+	bool adjacent_interference20;
+	bool adjacent_interference40;
+	bool adjacent_interference80;
+	/* All the rest */
+	u32 min_frames_for_decision;
+	u8 epr_factor;
+};
+
+struct cl_wrs_info {
+	u64 epr_acc;
+	u32 success;
+	u32 fail;
+	u32 fail_prev;
+	u32 ba_not_rcv;
+	u8 ba_not_rcv_consecutive;
+	u8 ba_not_rcv_consecutive_max;
+	bool synced;
+	u32 sync_attempts;
+	u8 quick_rate_agg_cntr;
+	u16 quick_rate_pkt_cntr;
+	bool quick_rate_check;
+};
+
+struct cl_wrs_rssi {
+	s32 sum[MAX_ANTENNAS];
+	s32 cnt;
+};
+
+bool cl_wrs_rssi_set_rate(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+			  struct cl_wrs_sta *wrs_sta);
+void cl_wrs_rssi_prot_start(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+bool cl_wrs_rssi_prot_decision(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+			       struct cl_wrs_sta *wrs_sta,
+			       struct cl_wrs_params *wrs_params,
+			       bool up_rate_valid,
+			       u8 up_rate_idx, u8 down_rate_idx);
+u16 cl_wrs_rssi_find_rate(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+			  struct cl_wrs_sta *wrs_sta, struct cl_wrs_params *wrs_params,
+			  s8 *rssi_sort);
+void cl_wrs_sta_add(struct cl_hw *cl_hw, struct ieee80211_sta *sta);
+bool cl_wrs_sta_add_mu(struct cl_hw *cl_hw, struct cl_wrs_sta *wrs_sta, u8 group_id);
+void cl_wrs_sta_add_rx(struct cl_hw *cl_hw, struct ieee80211_sta *sta);
+void cl_wrs_sta_remove(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db, struct cl_sta *cl_sta);
+bool cl_wrs_sta_remove_mu(struct cl_wrs_db *wrs_db, struct cl_wrs_sta *wrs_sta);
+struct cl_wrs_sta *cl_wrs_sta_get(struct cl_hw *cl_hw, u8 sta_idx);
+void cl_wrs_sta_select_first_rate(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+				  struct cl_wrs_sta *wrs_sta, struct cl_wrs_params *wrs_params);
+void cl_wrs_sta_capabilities_set(struct cl_wrs_db *wrs_db, struct ieee80211_sta *sta);
+void cl_wrs_sta_set_supported_rate(struct cl_wrs_sta *wrs_sta, u8 bw, u8 nss, u8 mcs);
+void cl_wrs_stats_per_update(struct cl_wrs_db *wrs_db,
+			     struct cl_wrs_sta *wrs_sta,
+			     struct cl_wrs_params *wrs_params,
+			     struct cl_wrs_cntrs *cntrs);
+void cl_wrs_stats_per_init(struct cl_wrs_params *wrs_params);
+void cl_wrs_stats_per_remove(struct cl_wrs_params *wrs_params);
+void cl_wrs_tables_global_build(void);
+void cl_wrs_tables_reset(struct cl_wrs_db *wrs_db, struct cl_wrs_sta *wrs_sta,
+			 struct cl_wrs_params *wrs_params);
+void cl_wrs_tables_build(struct cl_hw *cl_hw, struct cl_wrs_sta *wrs_sta,
+			 struct cl_wrs_params *wrs_params);
+u16 cl_wrs_tables_find_rate_idx(struct cl_wrs_params *wrs_params,
+				u8 bw, u8 nss, u8 mcs, u8 gi);
+void cl_wrs_init(struct cl_hw *cl_hw);
+void cl_wrs_lock_bh(struct cl_wrs_db *wrs_db);
+void cl_wrs_unlock_bh(struct cl_wrs_db *wrs_db);
+void cl_wrs_lock(struct cl_wrs_db *wrs_db);
+void cl_wrs_unlock(struct cl_wrs_db *wrs_db);
+void cl_wrs_fixed_rate_set(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+			   struct cl_wrs_sta *wrs_sta, struct cl_wrs_params *wrs_params,
+			   u8 is_fixed_rate, u8 mode, u8 bw, u8 nss, u8 mcs, u8 gi, bool mu_valid);
+void cl_wrs_rate_param_sync(struct cl_wrs_db *wrs_db, struct cl_wrs_sta *wrs_sta,
+			    struct cl_wrs_params *wrs_params);
+void cl_wrs_rate_params_update(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+			       struct cl_wrs_sta *wrs_sta, struct cl_wrs_params *wrs_params,
+			       u16 new_rate_idx, bool is_sync_required, bool mu_valid);
+void cl_wrs_decision_make(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+			  struct cl_wrs_sta *wrs_sta, struct cl_wrs_params *wrs_params,
+			  enum cl_wrs_decision decision, u16 new_rate_idx);
+void cl_wrs_decision_update(struct cl_wrs_db *wrs_db, struct cl_wrs_sta *wrs_sta,
+			    struct cl_wrs_params *wrs_params, enum cl_wrs_decision decision,
+			    u16 new_rate_idx);
+void cl_wrs_quick_down_check(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+			     struct cl_wrs_sta *wrs_sta, struct cl_wrs_params *wrs_params);
+bool cl_wrs_up_mcs1(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+		    struct cl_wrs_sta *wrs_sta, struct cl_wrs_params *wrs_params);
+void cl_wrs_rate_param_set(struct cl_hw *cl_hw, struct cl_wrs_sta *wrs_sta,
+			   struct cl_wrs_params *wrs_params,
+			   struct cl_wrs_rate_params *rate_params,
+			   struct cl_wrs_rate *rate_fallback,
+			   bool mu_mimo_valid, bool set_su);
+s8 cl_wrs_rssi_eq_calc(struct cl_hw *cl_hw, struct cl_wrs_sta *wrs_sta,
+		       bool read_clear, s8 *sorted_rssi);
+void cl_wrs_cntrs_reset(struct cl_wrs_sta *wrs_sta, struct cl_wrs_params *wrs_params);
+struct cl_wrs_info *cl_wrs_info_get(struct cl_sta *cl_sta, u8 type);
+struct cl_wrs_params *cl_wrs_params_get(struct cl_wrs_sta *wrs_sta, u8 type);
+void cl_wrs_update_rx_rate(struct cl_hw *cl_hw, struct cl_sta *cl_sta, struct hw_rxhdr *rxhdr);
+bool cl_wrs_set_rate_idle(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+			  struct cl_wrs_sta *wrs_sta, struct cl_wrs_params *wrs_params);
+struct cl_wrs_rate_params *cl_wrs_rx_rate_get(struct cl_sta *cl_sta);
+void cl_wrs_rx_rate_idle_reset(struct cl_wrs_params *rx_params);
+void cl_wrs_ap_capab_set(struct cl_hw *cl_hw, u8 bw, u8 use_sgi);
+void cl_wrs_ap_capab_modify_bw(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db, u8 max_bw);
+void cl_wrs_ap_capab_modify_gi(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db, u8 use_sgi);
+void cl_wrs_ap_capab_update(struct cl_hw *cl_hw, u8 bw, u8 use_sgi);
+
+/* Driver --> WRS */
+void cl_wrs_api_init(struct cl_hw *cl_hw);
+void cl_wrs_api_close(struct cl_hw *cl_hw);
+void cl_wrs_api_sta_add(struct cl_hw *cl_hw, struct ieee80211_sta *sta);
+void cl_wrs_api_sta_remove(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_wrs_api_bss_set_bw(struct cl_hw *cl_hw, u8 bw);
+void cl_wrs_api_bss_set_sgi(struct cl_hw *cl_hw, u8 use_sgi);
+bool cl_wrs_api_bss_is_sgi_en(struct cl_hw *cl_hw);
+void cl_wrs_api_nss_or_bw_changed(struct cl_hw *cl_hw, struct ieee80211_sta *sta, u8 nss, u8 bw);
+void cl_wrs_api_he_minrate_changed(struct cl_sta *cl_sta, u8 he_minrate);
+void cl_wrs_api_recovery(struct cl_hw *cl_hw);
+void cl_wrs_api_beamforming_sync(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_wrs_api_quick_down_check(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+				 struct cl_wrs_params *wrs_params);
+void cl_wrs_api_rate_sync(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			  struct cl_wrs_params *wrs_params);
+bool cl_wrs_api_up_mcs1(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			struct cl_wrs_params *wrs_params);
+void cl_wrs_api_set_smps_mode(struct cl_hw *cl_hw, struct ieee80211_sta *sta, const u8 bw);
+u16 cl_wrs_api_get_tx_sta_data_rate(struct cl_sta *cl_sta);
+void cl_wrs_api_bss_capab_update(struct cl_hw *cl_hw, u8 bw, u8 use_sgi);
+void cl_wrs_fill_sinfo_rates(struct rate_info *rate_info,
+			     const struct cl_wrs_params *wrs_params,
+			     const struct cl_sta *sta);
+
+#endif /* CL_WRS_H */
-- 
2.36.1

