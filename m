Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2118C53296E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbiEXLk3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236922AbiEXLk0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:40:26 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60067.outbound.protection.outlook.com [40.107.6.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057B74130C
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkvXtl00D4nYTv5V0FTZ4Pv+ovMQWGTUgcNAcFLGLq0jaCOP4uElkPM4elF5XJ4eqr7/+rvQwfmfA1/6KRehvwy5d4f681Qr09K2zsFvLVFAiDkAc2djOmq+ox/hlm2HgTcQflsG/qTQ2KBGejkNYJxSzEaYaNGTO2MgEbUO86vBltRnSxpMMCFT48b0dj2m0gJmUiMngbailkgwsL1RRIaApn0D/JNd2aTwSqEoSYHn3o8Knu3/P8JehKaEHiNZVZ5ynNbKlfUucv3HYt8+bj4wzF4i3sOhWoUxN8uxR4XBAvT+PiiiwzrpqKNv7Hn9qhMqrhiXSgau56093O6Dig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDhmt51XVQj8SzfSkcyrHoAiahElyAD4CWoy9Z+j9js=;
 b=BPkEPC+IK1X8t8DNGNg408yYZ/R6d8QB55hxe5H4hV5enM47RbWyzcK1BeIRsUBfmwFtujY7dk3+JV1QWIh6rvDg8wOGEj76xcH5fR0KH0W6PPuVx0YM88Fuk9aSqpAC8BwmS4UQwOYzEcky+UKd3xyY3Wl7jE63d7Jbkx9Ipyasiw0Wkp0XMd0orHjn5tmnNYlYsUTa6Ubqth89gjhEAXYyBtN+Ui3GxW9W53PKdI7OD/DXM8unMevHeBIFLGmPsZmjrxqOA5M12iMnufp0oAClCAhH8qtUFy7/rAHGrWvei5uEzUu0KXuZDMO8/C+3GI2sbjKvqgM2CBeyCD+Y3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDhmt51XVQj8SzfSkcyrHoAiahElyAD4CWoy9Z+j9js=;
 b=Ta5XAcudP4cZwbITdQIsKMm+QdsF/vmuWq8C1mp6hV/GWZ1pkifhL9jN6vz9WlKWHBwUAie3KsNwUJt2DEva80GEk7tdHakt64WK4SWUApd/iq3J41AywbSDr/YTefgfKQL06wVgJY6cbQW7BIswiBv2SYKS1I08JzO93sAvWrI=
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
Subject: [RFC v2 69/96] cl8k: add rx.h
Date:   Tue, 24 May 2022 14:34:35 +0300
Message-Id: <20220524113502.1094459-70-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: d26175c0-189a-43ba-8c4d-08da3d79f5b9
X-MS-TrafficTypeDiagnostic: AM8P192MB0915:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM8P192MB0915BA904D8C91DB638B5351F6D79@AM8P192MB0915.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LY9KPkxmoHfRv8vjtYZRo0sWoJ317xATXs8Z35KnokwpuaoblelAQa+eGjmu2NdX2sJRCXiEjnr3446T4Y/5VGvfBxKqoQL6OPAPU4ND895gk/R8jYyOiv/P7yc4xv1zg2X00UnJ5ujwD3CgsupvQzPj+Gv1HjJANuOqq9I+mUQzO2f2MfzrGadiHwoUOR9BE8eeRmmJHpaWO+j3zeCRETzzvEX0Xac8ZEaiz9bH0PCa0WuOa4DQG3V8b+BaL/RJOfvYlj6Bu8Y2cRg4yff24wcoq4G6mIsxhZ0JDaFL0jfH5xaaF2vyXjB4JDkNuSdbZ7yN0HBRaVYg5T8Li7euQJ9VAH3BljON/vh3epLRo7Pu1t3xHQaSgOhh9Gi1GCRLLlr5xjOEYuo44UMOQa79N+noCI+8KH3oFZgTptyFzr5Y/EDIgVlzvwFAJeCKJpaM0IIcST3FiQO04I4fJHZcvKrm/4s5qUT5UeRfiYvq1n1vPam4mjUI7ID8TqvSpHxZkNWo+FRhrIo8lCaj6YIRXmIXkcIlobDxnDqBsf7u3aEjlgl9PkDk84/zl6e+01WEAUGtv4WVJMOYjTu7GcpDnt4L49EdME4di/51KicVeU3BZAUFU/XwmGdTuKSu0KI0pHQ16J4SWlAo83cid4fvnqrTHAHtTY3BUUSdL5wtfRR+FFqJjXOjRMhdNAIRYnU28kdEemlC8nfQtIoQZJoH6yZw370wr1PE54VnZFknO00=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(376002)(346002)(39850400004)(83380400001)(54906003)(186003)(36756003)(107886003)(2906002)(2616005)(30864003)(1076003)(6916009)(41300700001)(66946007)(8936002)(6666004)(9686003)(66476007)(26005)(86362001)(66556008)(5660300002)(6512007)(4326008)(38350700002)(316002)(6506007)(52116002)(8676002)(6486002)(38100700002)(508600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v4Xwkz8qVxEhUMXxxyMl2QqrarMrDzDMJMVqz7ybheViGj+ppnPN2f1BS39M?=
 =?us-ascii?Q?crjbqHgZWXV7BqEJAnEGgNbJ1rJC78L17k57Pi7FVAWTqbLvLYbXK+CGAXJF?=
 =?us-ascii?Q?IF7jOVDDcc5ak8/tYxeNcD+I3vhJuG+ziFeEWCtw0xaJybI5whPOKZy7H/bV?=
 =?us-ascii?Q?0ylBSvUHiIfYWOMMgnCHZ6zFJscKJ2ZnXRN1bO8Lki63kwV29O4gaTWxH72T?=
 =?us-ascii?Q?pbwfLx6OLZDp9dozkLE9IYsOgklH3st1ZsWbX3r8aVJLa3waaz9z46jiUCaI?=
 =?us-ascii?Q?vKT1YwDQlY3M4ea/ktmdBkiRmW+jy6Zpq5p0E7CwRMJMqZOoGWa/672ps91r?=
 =?us-ascii?Q?OCy7JDJ3Tz8kAwvlG5RtPdOun3M2FH41yeotTo8iQp7fV7fBwcbKjJVFOMUN?=
 =?us-ascii?Q?wD737pmdS2QKgo/RLCBI4xnUuxjlRqJJyNaxBBma8tA2+vceiZRSYKZmrMHx?=
 =?us-ascii?Q?upIKl1twl8+mqyWR7QGqq6AIZahmEu4ADX+4IHaN4QM9pKqDKjjvjCK9Oqst?=
 =?us-ascii?Q?Ve+f+XGLAkvaqElv/OWKIFtXpW3QeqNXqA+f/DS639Z1rlzE8XTDaOFWPlkY?=
 =?us-ascii?Q?GyoTQzMiMl79C8luvxcU/6k2uWdX4UjWgTk1kSQ/e6dVQB3YqpPYJnvfAzfd?=
 =?us-ascii?Q?nYc8aaAhfDX/yr3b95YYvyEV+srovzF3HUd/tQHPOtuwTEyyaL0TXQiL03Nk?=
 =?us-ascii?Q?7UKDww1UsGYG/9kG1csiCd8545a8xYCZnXFHOPbu3swDrQVFZFXIMI1JN2uX?=
 =?us-ascii?Q?uy/vqBr5JBd85j8Jek1SAnzW0OMzLid844gYCiwxWtPABjbW3CwW3SzvLwFS?=
 =?us-ascii?Q?hCC4dfkUFVQeUCzAnzJYW5tOorV4OWjFDdqd15ITCDPTE6lCTl4ZnNnat27f?=
 =?us-ascii?Q?4ohEIm3uAxnwWOpH54cf9cPwOTSM/saVw0v5G0rvYru2HMICBpwEcAnYEF9c?=
 =?us-ascii?Q?szwsbgylelIIuAgBhA10gt3hNXvibcGTwLh9V0N4MxLZUlucEfyJkkms/QAa?=
 =?us-ascii?Q?uCZ4gOR3UAxxGqNgUHfW32zKT+j/HGSGbB/D7p3myMcmkmmRFgHzX2Ec0R9x?=
 =?us-ascii?Q?Hugyq3xZMSjmrJnuVefgITOEURyjyNPr90AfBsDiKpBa6w7cuvu6GwVPbsXW?=
 =?us-ascii?Q?Y1Zl/uTQPGHUQatjx+BPHLbsfZ8pLiT4xDyf4UbWbltR4Fm/wIaM5pWbrNIi?=
 =?us-ascii?Q?hlrI+pIUBcNtM0/JRA8nvb7x2iSLo8Zrw8YIaGGIreRA9FfXCG8PM2wvsMI4?=
 =?us-ascii?Q?LAA3t8rME10uH5zEnPa/b/bL1OSGj8gDqubZ6c1sjX8UEFPxh1EF4IBXMDk4?=
 =?us-ascii?Q?97x9CxCw899/+wQlaoEcXe4ju+GRuzUx39oLMTdBqbnXAWImg4U6JRdJL4gy?=
 =?us-ascii?Q?qU1/udw/5plFd2wooSdDhsZMWeRkJr4ravUf7BY42qHslTEBF0S1gvbE0vHn?=
 =?us-ascii?Q?vJeLPZSzKghOUSH/3sx1kll0EsOXHeyugBuzzLUXH5Y/CxiIwMB6ldp3p+zY?=
 =?us-ascii?Q?VILDVDWdLWTpBi6ylsE91HyxoxE5v57gikgXq1uVzexUgJPxvvVkKq5PieUp?=
 =?us-ascii?Q?qh3vHj5u/wD70z5Cd/xj8p46gEfKRJ24zKqA1+lMiIP8rwAo/Slz0Y/Iet20?=
 =?us-ascii?Q?ScJ7DYsxHAx+IdEZStZihCqHmROd7qXyd/E0QZ/viDAIIvLFBRoge4hWS3I0?=
 =?us-ascii?Q?0PDizCELaaLNTpQ6Y58CVkAdnDbCiFGykFnaAMSfPrQW/s7O+tY5597GQgfI?=
 =?us-ascii?Q?RPbNVxY1enzPcJvTLr2+lum6szZ4xa8=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26175c0-189a-43ba-8c4d-08da3d79f5b9
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:45.0993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+SieZDgJ+ddWBUBYGGiizvgcVV4Th7YK+6/FZJkSYGG29zdnA3hoii5aaNhUUVRGiSMTryEnJZn041JeGZxSw==
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
 drivers/net/wireless/celeno/cl8k/rx.h | 505 ++++++++++++++++++++++++++
 1 file changed, 505 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/rx.h

diff --git a/drivers/net/wireless/celeno/cl8k/rx.h b/drivers/net/wireless/celeno/cl8k/rx.h
new file mode 100644
index 000000000000..f460c3c37475
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/rx.h
@@ -0,0 +1,505 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_RX_H
+#define CL_RX_H
+
+#include <linux/skbuff.h>
+#include <net/mac80211.h>
+
+#include "ipc_shared.h"
+
+/* Decryption status subfields */
+enum cl_rx_hdr_decr {
+	CL_RX_HDR_DECR_UNENC,
+	CL_RX_HDR_DECR_ICVFAIL,
+	CL_RX_HDR_DECR_CCMPFAIL,
+	CL_RX_HDR_DECR_AMSDUDISCARD,
+	CL_RX_HDR_DECR_NULLKEY,
+	CL_RX_HDR_DECR_WEPSUCCESS,
+	CL_RX_HDR_DECR_TKIPSUCCESS,
+	CL_RX_HDR_DECR_CCMPSUCCESS
+};
+
+#define CL_PADDING_IN_BYTES 2
+
+struct hw_rxhdr {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u32 msdu_cnt           : 8,   /* [7:0] */
+	    corrupted_amsdu    : 1,   /* [8] */
+	    reserved           : 1,   /* [9] */
+	    msdu_dma_align     : 2,   /* [11:10] */
+	    amsdu_error_code   : 4,   /* [15:12] */
+	    reserved_2         :16;   /* [31:16] */
+#else
+	u32 reserved_2         :16,   /* [15:0] */
+	    amsdu_error_code   : 4,    /* [19:16] */
+	    msdu_dma_align     : 2,    /* [21:20] */
+	    reserved           : 1,    /* [22] */
+	    corrupted_amsdu    : 1,    /* [23] */
+	    msdu_cnt           : 8;    /* [31:24] */
+#endif
+	/* Total length for the MPDU transfer */
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u32 len                :14,   /* [13:0] */
+	    ampdu_cnt          : 2,   /* [15:14] */
+	    rx_padding_done    : 1,   /* [16] */
+	    rx_class_rule_res  : 7,   /* [23:17] */
+	/* AMPDU Status Information */
+	    mpdu_cnt           : 8;   /* [31:24] */
+#else
+	u32 mpdu_cnt           : 8,   /* [7:0] */
+	    rx_class_rule_res  : 7,   /* [14:8] */
+	    rx_padding_done    : 1,   /* [15] */
+	    ampdu_cnt          : 2,   /* [17:16] */
+	    len                :14;   /* [31:18] */
+#endif
+
+	/* TSF Low */
+	__le32 tsf_lo;
+	/* TSF High */
+	__le32 tsf_hi;
+
+	/* Receive Vector 1a */
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u32 leg_length         :12,   /* [11:0] */
+	    leg_rate           : 4,   /* [15:12] */
+	    ht_length_l        :16;   /* [31:16] */
+#else
+	u32 ht_length_l        :16,   /* [15:0] */
+	    leg_rate           :4,    /* [19:16] */
+	    leg_length         :12;   /* [31:20] */
+#endif
+
+	/* Receive Vector 1b */
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u32 ht_length_h        : 8,   /* [7:0] */
+	    mcs                : 7,   /* [14:8] */
+	    pre_type           : 1,   /* [15] */
+	    format_mod         : 4,   /* [19:16] */
+	    reserved_1b        : 1,   /* [20] */
+	    n_sts              : 3,   /* [23:21] */
+	    lsig_valid         : 1,   /* [24] */
+	    sounding           : 1,   /* [25] */
+	    num_extn_ss        : 2,   /* [27:26] */
+	    aggregation        : 1,   /* [28] */
+	    fec_coding         : 1,   /* [29] */
+	    dyn_bw             : 1,   /* [30] */
+	    doze_not_allowed   : 1;   /* [31] */
+#else
+	u32 doze_not_allowed   : 1,   /* [0] */
+	    dyn_bw             : 1,   /* [1] */
+	    fec_coding         : 1,   /* [2] */
+	    aggregation        : 1,   /* [3] */
+	    num_extn_ss        : 2,   /* [5:4] */
+	    sounding           : 1,   /* [6] */
+	    lsig_valid         : 1,   /* [7] */
+	    n_sts              : 3,   /* [10:8] */
+	    reserved_1b        : 1,   /* [11] */
+	    format_mod         : 4,   /* [15:12] */
+	    pre_type           : 1,   /* [16] */
+	    mcs                : 7,   /* [23:17] */
+	    ht_length_h        : 8;   /* [31:24] */
+#endif
+
+	/* Receive Vector 1c */
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u32 sn                 : 4,  /* [3:0] */
+	    warn_1c            : 1,  /* [4] */
+	    stbc               : 2,  /* [6:5] */
+	    smoothing          : 1,  /* [7] */
+	    partial_aid        : 9,  /* [16:8] */
+	    group_id           : 6,  /* [22:17] */
+	    reserved_1c        : 1,  /* [23] */
+	    rssi1              : 8;  /* [31:24] */
+#else
+	u32 rssi1              : 8,  /* [7:0] */
+	    reserved_1c        : 1,  /* [8] */
+	    group_id           : 6,  /* [14:9] */
+	    partial_aid        : 9,  /* [23:15] */
+	    smoothing          : 1,  /* [24] */
+	    stbc               : 2,  /* [26:25] */
+	    warn_1c            : 1,  /* [27] */
+	    sn                 : 4;  /* [31:28] */
+#endif
+
+	/* Receive Vector 1d */
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	s32 rssi2              : 8,  /* [7:0] */
+	    rssi3              : 8,  /* [15:8] */
+	    rssi4              : 8,  /* [23:16] */
+	    rx_chains          : 8;  /* [31:24] */
+#else
+	s32 rx_chains          : 8,  /* [7:0] */
+	    rssi4              : 8,  /* [15:8] */
+	    rssi3              : 8,  /* [23:16] */
+	    rssi2              : 8;  /* [31:24] */
+#endif
+
+	/* Receive Vector 1e */
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u32 txop_duration      : 7,  /* [6:0] */
+	    beam_change        : 1,  /* [7] */
+	    mcs_sig_b          : 3,  /* [10:8] */
+	    dcm                : 1,  /* [11] */
+	    dcm_sig_b          : 1,  /* [12] */
+	    beamformed         : 1,  /* [13] */
+	    ltf_type           : 2,  /* [15:14] */
+	    ru_band            : 1,  /* [16] */
+	    ru_type            : 3,  /* [19:17] */
+	    ru_index           : 6,  /* [25:20] */
+	    pe_duration        : 3,  /* [28:26] */
+	    ch_bw              : 2,  /* [30:29] */
+	    reserved_1e        : 1;  /* [31] */
+#else
+	u32 reserved_1e        : 1,  /* [0] */
+	    ch_bw              : 2,  /* [2:1] */
+	    pe_duration        : 3,  /* [5:3] */
+	    ru_index           : 6,  /* [11:6] */
+	    ru_type            : 3,  /* [14:12] */
+	    ru_band            : 1,  /* [15] */
+	    ltf_type           : 2,  /* [17:16] */
+	    beamformed         : 1,  /* [18] */
+	    dcm_sig_b          : 1,  /* [19] */
+	    dcm                : 1,  /* [20] */
+	    mcs_sig_b          : 3,  /* [23:21] */
+	    beam_change        : 1,  /* [24] */
+	    txop_duration      : 7;  /* [31:25] */
+#endif
+
+	/* Receive Vector 1f */
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u32 spatial_reuse      : 16, /* [15:0] */
+	    service            : 16; /* [31:16] */
+#else
+	u32 service            : 16, /* [15:0] */
+	    spatial_reuse      : 16; /* [31:16] */
+#endif
+
+	/* Receive Vector 1g */
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u32 bss_color          : 6,  /* [5:0] */
+	    gi_type            : 2,  /* [7:6] */
+	    antenna_set        : 16, /* [23:8] */
+	    rssi5              : 8;  /* [31:24] */
+#else
+	u32 rssi5              : 8,  /* [7:0] */
+	    antenna_set        : 16, /* [23:8] */
+	    gi_type            : 2,  /* [25:24] */
+	    bss_color          : 6;  /* [31:26] */
+#endif
+
+	/* Receive Vector 1h */
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	s32 rssi6              : 8,  /* [7:0] */
+	    rssi7              : 8,  /* [15:8] */
+	    rssi8              : 8,  /* [23:16] */
+	    future_1           : 8;  /* [31:24] */
+#else
+	s32 future_1           : 8,  /* [7:0] */
+	    rssi8              : 8,  /* [15:8] */
+	    rssi7              : 8,  /* [23:16] */
+	    rssi6              : 8;  /* [31:24] */
+#endif
+
+	/* Receive Vector 2a */
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u32 rcpi               : 8,  /* [7:0] */
+	    evm1               : 8,  /* [15:8] */
+	    evm2               : 8,  /* [23:16] */
+	    evm3               : 8;  /* [31:24] */
+#else
+	u32 evm3               : 8,  /* [7:0] */
+	    evm2               : 8,  /* [15:8] */
+	    evm1               : 8,  /* [23:16] */
+	    rcpi               : 8;  /* [31:24] */
+#endif
+
+	/* Receive Vector 2b */
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u32 evm4               : 8,  /* [7:0] */
+	    warn_2b            : 1,  /* [8] */
+	    reserved2b_1       : 7,  /* [15:9] */
+	    reserved2b_2       : 8,  /* [23:16] */
+	    reserved2b_3       : 8;  /* [31:24] */
+#else
+	u32 reserved2b_3       : 8,  /* [7:0] */
+	    reserved2b_2       : 8,  /* [15:8] */
+	    reserved2b_1       : 7,  /* [22:16] */
+	    warn_2b            : 1,  /* [23] */
+	    evm4               : 8;  /* [31:24] */
+#endif
+
+	/* Status **/
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u32 rx_vect2_valid     : 1,  /* [0] */
+	    resp_frame         : 1,  /* [1] */
+	    decr_status        : 3,  /* [4:2] */
+	    rx_fifo_oflow      : 1,  /* [5] */
+	    undef_err          : 1,  /* [6] */
+	    phy_err            : 1,  /* [7] */
+	    fcs_err            : 1,  /* [8] */
+	    addr_mismatch      : 1,  /* [9] */
+	    ga_frame           : 1,  /* [10] */
+	    first_qos_data     : 1,  /* [11] */
+	    amsdu_present      : 1,  /* [12] */
+	    frm_successful_rx  : 1,  /* [13] */
+	    desc_done_rx       : 1,  /* [14] */
+	    desc_spare         : 1,  /* [15] */
+	    key_sram_index     : 9,  /* [24:16] */
+	    key_sram_v         : 1,  /* [25] */
+	    type               : 2,  /* [27:26] */
+	    subtype            : 4;  /* [31:28] */
+#else
+	u32 subtype            : 4,  /* [3:0] */
+	    type               : 2,  /* [5:4] */
+	    key_sram_v         : 1,  /* [6] */
+	    key_sram_index     : 9,  /* [15:7] */
+	    desc_spare         : 1,  /* [16] */
+	    desc_done_rx       : 1,  /* [17] */
+	    frm_successful_rx  : 1,  /* [18] */
+	    amsdu_present      : 1,  /* [19] */
+	    first_qos_data     : 1,  /* [20] */
+	    ga_frame           : 1,  /* [21] */
+	    addr_mismatch      : 1,  /* [22] */
+	    fcs_err            : 1,  /* [23] */
+	    phy_err            : 1,  /* [24] */
+	    undef_err          : 1,  /* [25] */
+	    rx_fifo_oflow      : 1,  /* [26] */
+	    decr_status        : 3,  /* [29:27] */
+	    resp_frame         : 1,  /* [30] */
+	    rx_vect2_valid     : 1;  /* [31] */
+#endif
+
+	/* PHY channel information 1 */
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u32 phy_band           : 8,  /* [7:0] */
+	    phy_channel_type   : 8,  /* [15:8] */
+	    phy_prim20_freq    : 16; /* [31:16] */
+#else
+	u32 phy_prim20_freq    : 16, /* [15:0] */
+	    phy_channel_type   : 8,  /* [23:16] */
+	    phy_band           : 8;  /* [31:24] */
+#endif
+
+	/* PHY channel information 2 */
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u32 phy_center1_freq   : 16, /* [15:0] */
+	    phy_center2_freq   : 16; /* [31:16] */
+#else
+	u32 phy_center2_freq   : 16, /* [15:0] */
+	    phy_center1_freq   : 16; /* [31:16] */
+#endif
+
+	/* Patten **/
+	__le32  pattern;
+};
+
+enum cl_radio_stats {
+	CL_RADIO_FCS_ERROR = 0,
+	CL_RADIO_PHY_ERROR,
+	CL_RADIO_RX_FIFO_OVERFLOW,
+	CL_RADIO_ADDRESS_MISMATCH,
+	CL_RADIO_UNDEFINED_ERROR,
+	CL_RADIO_ERRORS_MAX
+};
+
+struct cl_rx_path_info {
+	u32 rx_desc[CL_RX_BUF_MAX];
+	u32 netif_rx;
+	u32 elem_alloc_fail;
+	u32 skb_null;
+	u32 pkt_drop_amsdu_corrupted;
+	u32 pkt_drop_sub_amsdu_corrupted;
+	u32 pkt_drop_amsdu_len_error;
+	u32 pkt_drop_sub_amsdu_len_error;
+	u32 pkt_drop_wrong_pattern;
+	u32 pkt_drop_not_success;
+	u32 pkt_drop_sub_amsdu_not_success;
+	u32 pkt_drop_unencrypted;
+	u32 pkt_drop_sub_amsdu_unencrypted;
+	u32 pkt_drop_decrypt_fail;
+	u32 pkt_drop_sub_amsdu_decrypt_fail;
+	u32 pkt_drop_tailroom_error;
+	u32 pkt_drop_sub_amsdu_tailroom_error;
+	u32 pkt_drop_amsdu_inj_attack;
+	u32 pkt_drop_sta_null;
+	u32 pkt_drop_host_limit;
+	u32 pkt_drop_invalid_pn;
+	u32 remote_cpu[CPU_MAX_NUM];
+	u32 exceed_pkt_budget;
+	u32 pkt_handle_bucket_rxm[IPC_RXBUF_NUM_BUCKETS_RXM];
+	u32 pkt_handle_bucket_fw[IPC_RXBUF_NUM_BUCKETS_FW];
+	u32 amsdu_cnt[RX_MAX_MSDU_IN_AMSDU];
+	u32 non_amsdu;
+	u32 buffer_process_irq;
+	u32 buffer_process_tasklet;
+};
+
+struct cl_hw;
+struct cl_vif;
+struct cl_sta;
+struct mm_agg_rx_ind;
+
+void cl_rx_init(struct cl_hw *cl_hw);
+void cl_rx_off(struct cl_hw *cl_hw);
+void cl_rx_remote_tasklet_sched(void *t);
+void cl_rx_remote_cpu_info(struct cl_hw *cl_hw);
+void cl_rx_push_queue(struct cl_hw *cl_hw, struct sk_buff *skb);
+void cl_rx_skb_alloc_handler(struct sk_buff *skb);
+void cl_rx_skb_error(struct cl_hw *cl_hw);
+void cl_rx_skb_drop(struct cl_hw *cl_hw, struct sk_buff *skb, u8 cnt);
+void cl_rx_post_recovery(struct cl_hw *cl_hw);
+void cl_rx_finish(struct cl_hw *cl_hw, struct sk_buff *skb, struct ieee80211_sta *sta);
+u8 cl_rx_get_skb_ac(struct ieee80211_hdr *hdr);
+bool cl_rx_process_in_irq(struct cl_hw *cl_hw);
+void cl_agg_rx_report_handler(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u8 sta_loc,
+			      struct mm_agg_rx_ind *agg_report);
+
+enum rx_amsdu_error {
+	RX_AMSDU_ERR_CORRUPTED = 0x1,
+	RX_AMSDU_ERR_LENGTH = 0x2,
+	RX_AMSDU_ERR_NOT_SUCCESS = 0x4,
+	RX_AMSDU_ERR_UNENCRYPTED = 0x8,
+	RX_AMSDU_ERR_DECRYPT_FAIL = 0x10,
+	RX_AMSDU_ERR_INVALID_TAILROOM = 0x20,
+};
+
+struct cl_amsdu_rx_state {
+	u8 msdu_cnt;
+	u8 msdu_remaining_cnt;
+	/*
+	 * MSDU padding - all MSDU pkt within A-MSDU are 4byte aligned (this
+	 * value holds the alignment value)
+	 * According to ieee80211 spec all MSDU share the same alignment
+	 */
+	u8 msdu_dma_align;
+	u8 amsdu_error;
+	u8 encrypt_len;
+	u8 sta_idx;
+	u8 tid;
+	u32 packet_len;
+	struct hw_rxhdr *rxhdr;
+	struct sk_buff *first_skb;
+	struct sk_buff_head frames;
+};
+
+void cl_rx_amsdu_first(struct cl_hw *cl_hw, struct sk_buff *skb, struct hw_rxhdr *rxhdr,
+		       u8 sta_idx, u8 tid, u8 encrypt_len);
+bool cl_rx_amsdu_sub(struct cl_hw *cl_hw, struct sk_buff *skb);
+bool cl_rx_amsdu_check_aggregation_attack(struct cl_amsdu_rx_state *amsdu_rx_state);
+void cl_rx_amsdu_first_corrupted(struct cl_hw *cl_hw, struct sk_buff *skb,
+				 struct hw_rxhdr *rxhdr);
+void cl_rx_amsdu_sub_error(struct cl_hw *cl_hw, struct sk_buff *skb);
+void cl_rx_amsdu_set_state_error(struct cl_hw *cl_hw,
+				 struct hw_rxhdr *rxhdr,
+				 enum rx_amsdu_error err);
+void cl_rx_amsdu_reset(struct cl_hw *cl_hw);
+void cl_rx_amsdu_stats(struct cl_hw *cl_hw, u8 msdu_cnt);
+void cl_rx_amsdu_hw_en(struct ieee80211_hw *hw, bool rxamsdu_en);
+
+/* Field definitions */
+#define RX_CNTRL_EN_DUPLICATE_DETECTION_BIT      ((u32)0x80000000)
+#define RX_CNTRL_EN_DUPLICATE_DETECTION_POS      31
+#define RX_CNTRL_ACCEPT_UNKNOWN_BIT              ((u32)0x40000000)
+#define RX_CNTRL_ACCEPT_UNKNOWN_POS              30
+#define RX_CNTRL_ACCEPT_OTHER_DATA_FRAMES_BIT    ((u32)0x20000000)
+#define RX_CNTRL_ACCEPT_OTHER_DATA_FRAMES_POS    29
+#define RX_CNTRL_ACCEPT_QO_S_NULL_BIT            ((u32)0x10000000)
+#define RX_CNTRL_ACCEPT_QO_S_NULL_POS            28
+#define RX_CNTRL_ACCEPT_QCFWO_DATA_BIT           ((u32)0x08000000)
+#define RX_CNTRL_ACCEPT_QCFWO_DATA_POS           27
+#define RX_CNTRL_ACCEPT_Q_DATA_BIT               ((u32)0x04000000)
+#define RX_CNTRL_ACCEPT_Q_DATA_POS               26
+#define RX_CNTRL_ACCEPT_CFWO_DATA_BIT            ((u32)0x02000000)
+#define RX_CNTRL_ACCEPT_CFWO_DATA_POS            25
+#define RX_CNTRL_ACCEPT_DATA_BIT                 ((u32)0x01000000)
+#define RX_CNTRL_ACCEPT_DATA_POS                 24
+#define RX_CNTRL_ACCEPT_OTHER_CNTRL_FRAMES_BIT   ((u32)0x00800000)
+#define RX_CNTRL_ACCEPT_OTHER_CNTRL_FRAMES_POS   23
+#define RX_CNTRL_ACCEPT_CF_END_BIT               ((u32)0x00400000)
+#define RX_CNTRL_ACCEPT_CF_END_POS               22
+#define RX_CNTRL_ACCEPT_ACK_BIT                  ((u32)0x00200000)
+#define RX_CNTRL_ACCEPT_ACK_POS                  21
+#define RX_CNTRL_ACCEPT_CTS_BIT                  ((u32)0x00100000)
+#define RX_CNTRL_ACCEPT_CTS_POS                  20
+#define RX_CNTRL_ACCEPT_RTS_BIT                  ((u32)0x00080000)
+#define RX_CNTRL_ACCEPT_RTS_POS                  19
+#define RX_CNTRL_ACCEPT_PS_POLL_BIT              ((u32)0x00040000)
+#define RX_CNTRL_ACCEPT_PS_POLL_POS              18
+#define RX_CNTRL_ACCEPT_BA_BIT                   ((u32)0x00020000)
+#define RX_CNTRL_ACCEPT_BA_POS                   17
+#define RX_CNTRL_ACCEPT_BAR_BIT                  ((u32)0x00010000)
+#define RX_CNTRL_ACCEPT_BAR_POS                  16
+#define RX_CNTRL_ACCEPT_OTHER_MGMT_FRAMES_BIT    ((u32)0x00008000)
+#define RX_CNTRL_ACCEPT_OTHER_MGMT_FRAMES_POS    15
+#define RX_CNTRL_ACCEPT_ALL_BEACON_BIT           ((u32)0x00002000)
+#define RX_CNTRL_ACCEPT_ALL_BEACON_POS           13
+#define RX_CNTRL_ACCEPT_NOT_EXPECTED_BA_BIT      ((u32)0x00001000)
+#define RX_CNTRL_ACCEPT_NOT_EXPECTED_BA_POS      12
+#define RX_CNTRL_ACCEPT_DECRYPT_ERROR_FRAMES_BIT ((u32)0x00000800)
+#define RX_CNTRL_ACCEPT_DECRYPT_ERROR_FRAMES_POS 11
+#define RX_CNTRL_ACCEPT_BEACON_BIT               ((u32)0x00000400)
+#define RX_CNTRL_ACCEPT_BEACON_POS               10
+#define RX_CNTRL_ACCEPT_PROBE_RESP_BIT           ((u32)0x00000200)
+#define RX_CNTRL_ACCEPT_PROBE_RESP_POS           9
+#define RX_CNTRL_ACCEPT_PROBE_REQ_BIT            ((u32)0x00000100)
+#define RX_CNTRL_ACCEPT_PROBE_REQ_POS            8
+#define RX_CNTRL_ACCEPT_MY_UNICAST_BIT           ((u32)0x00000080)
+#define RX_CNTRL_ACCEPT_MY_UNICAST_POS           7
+#define RX_CNTRL_ACCEPT_UNICAST_BIT              ((u32)0x00000040)
+#define RX_CNTRL_ACCEPT_UNICAST_POS              6
+#define RX_CNTRL_ACCEPT_ERROR_FRAMES_BIT         ((u32)0x00000020)
+#define RX_CNTRL_ACCEPT_ERROR_FRAMES_POS         5
+#define RX_CNTRL_ACCEPT_OTHER_BSSID_BIT          ((u32)0x00000010)
+#define RX_CNTRL_ACCEPT_OTHER_BSSID_POS          4
+#define RX_CNTRL_ACCEPT_BROADCAST_BIT            ((u32)0x00000008)
+#define RX_CNTRL_ACCEPT_BROADCAST_POS            3
+#define RX_CNTRL_ACCEPT_MULTICAST_BIT            ((u32)0x00000004)
+#define RX_CNTRL_ACCEPT_MULTICAST_POS            2
+#define RX_CNTRL_DONT_DECRYPT_BIT                ((u32)0x00000002)
+#define RX_CNTRL_DONT_DECRYPT_POS                1
+#define RX_CNTRL_EXC_UNENCRYPTED_BIT             ((u32)0x00000001)
+#define RX_CNTRL_EXC_UNENCRYPTED_POS             0
+
+/* Default MAC Rx filters that cannot be changed by mac80211 */
+#define CL_MAC80211_NOT_CHANGEABLE (            \
+	RX_CNTRL_ACCEPT_QO_S_NULL_BIT         | \
+	RX_CNTRL_ACCEPT_Q_DATA_BIT            | \
+	RX_CNTRL_ACCEPT_DATA_BIT              | \
+	RX_CNTRL_ACCEPT_OTHER_MGMT_FRAMES_BIT | \
+	RX_CNTRL_ACCEPT_MY_UNICAST_BIT        | \
+	RX_CNTRL_ACCEPT_BROADCAST_BIT         | \
+	RX_CNTRL_ACCEPT_BEACON_BIT            | \
+	RX_CNTRL_ACCEPT_PROBE_RESP_BIT          \
+	)
+
+u32 cl_rx_filter_update_flags(struct cl_hw *cl_hw, u32 filter);
+void cl_rx_filter_restore_flags(struct cl_hw *cl_hw);
+void cl_rx_filter_set_promiscuous(struct cl_hw *cl_hw);
+
+struct cl_tid_ampdu_rx {
+	spinlock_t reorder_lock;
+	u64 reorder_buf_filtered;
+	struct sk_buff_head *reorder_buf;
+	unsigned long *reorder_time;
+	struct ieee80211_sta *sta;
+	struct timer_list reorder_timer;
+	struct cl_hw *cl_hw;
+	u16 head_seq_num;
+	u16 stored_mpdu_num;
+	u16 ssn;
+	u16 buf_size;
+	u16 timeout;
+	u8 tid;
+	u8 auto_seq:1,
+	   removed:1,
+	   started:1;
+};
+
+void cl_rx_reorder_ampdu(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			 struct sk_buff *skb, struct sk_buff_head *ordered_mpdu);
+void cl_rx_reorder_close(struct cl_sta *cl_sta, u8 tid);
+void cl_rx_reorder_init(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u8 tid, u16 buf_size);
+
+#endif /* CL_RX_H */
-- 
2.36.1

