Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D363AB8C7
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhFQQK1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:27 -0400
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:32846
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233743AbhFQQJ1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0MLGTSbUGTHlMMttvbM8SpJOooqtq1nP7QN7kHax29FoWG+c6TOAZYr6mEkqmTFDxpOu1xMVpQW50adJBT7x5hJMl1DkYufXOpXKbltFehiDlSxsCwKWzBygGtwNbhskrsZx2DaBVD8CEU0KU7l46G78siV7cAQWvtwN5cm7g8mXJRKRN9m77puwRDkOI+djEI75VYPTTcD7muS/MuqbgSJQiLphMZdZciVuEiL+/dnCiDMtrjXxlOOMQenPwpkvCv4orXr5ReUZxbNCK54mnRvBQqyVEXSHusLKcD8plnjwQ6wDezDDFkxt/rvEj/AO4pDl3KiTXOv31paewHpMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcQLwPdtOdKhw+OqqitGiBnh8u09tm34mSrR048pgeQ=;
 b=duq89Iem+sKGzf2JnHqTGwCg/c1+4nNwTyjEB6NJ9T/FsmVugCN6CIZFYdDAgRByjcfbUsDP9f5Y/PgziMt0+hkB+WWP2kx6cUeI1atILAU58acAFKFN+eJxwX1zYnq938xWnPu9cXG/mtOl2ukp4R7qbiuHvLntwV7bOYCoDEamZiegCFWa4iLukO1OboWpmVJf5KRgKPgbSw0BNiZJn9sYaXEBVAjXXTNklOzpoMalh7igv9zsy0F7tIR99Y+4PLMfpt4jqO/DNeTh0GAIlvFxLUE9ANkP4LSup/EYU7Q6doqfhwgwzQhMlJ4839ZGq7ibVUiD871vxCttebhkkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcQLwPdtOdKhw+OqqitGiBnh8u09tm34mSrR048pgeQ=;
 b=C0Oi7z6kY/33yGj68eGp1truOm+w55IeXYYaSllYjtjMeEhM4sNqF/5GpApkxLnz/4miTRyG1/i7gA0ofmXbEpaSk6swY3vOyXNn5jrj39mINo5qk1xzQdCI1IiOzr/1y5bG9w9z+FHwLvc6KDlXWlLz9B1/ICxerhP91sCqru8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0260.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:47::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 17 Jun
 2021 16:06:34 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:06:34 +0000
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
Subject: [RFC v1 173/256] cl8k: add rx/rx.h
Date:   Thu, 17 Jun 2021 16:01:00 +0000
Message-Id: <20210617160223.160998-174-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ea68c52-c03e-4c4b-1793-08d931a9c2f9
X-MS-TrafficTypeDiagnostic: AM0P192MB0260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0260B00532DA83B5F14B3210F60E9@AM0P192MB0260.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 216U/xuQhMG1uGWs3shezETdrM1t2ZBGBctG5IBZMqCwIue3gM3wdy+CieYQJmV1I/k7vJL/wy27jyZrE0uwB2VBDr/Qs+dpMe3AXXRD9yF73vgT0fPyJx+L3On40aD101fayKvxmSrz5cQpTLDSI63kiDoC7gXYgrxN+1xOyHzE5LNsLsjKvj8uoNQhYE73ZSa6yDNbDsk2i0Tb4wZ9nPKzY1nu+/Lr8NL3SCX15g6nYQOcBMlkFSgK5iStqXg1j1AoGTclJdLsSDVPCmo1+UeBor0kMPS+6MZh4LLkNpNy8vsYxZIXhTDtfx+7Ft4j2w/lHWhoyXE4SGiOycsr+8rqXzH64FUtvITPPwO75gh+OciSKzTEN+R76HpfvGQXlLZir1rDeUoH4GlKgcRC6Nv2yMaDuAvYJx67cp7of+KDZZaxBm+EkJa7KnFWHg/RVGk2kb4zQnYLO6fhmIY5Z4JBtKg2QrKz/Co65KoyFdjWYsP1Tpss+YBVGSkRueu5ee1R7UGsPZheUl+UYdf8lCTX8DgsmtUEc8oZn9V8trVNaPh10eHJsMA+LRG3F/zoVwhSe3eWYEmZfdn18rBRu0WSwmoejaJcteqhDpTZTBB5qt1BDoa/YOJMT55nP3ISZVK5PUPXyiOgmAlBOtWgTcNKs9e+gof79vE9/ONAk2ZEClttoG6pqb02WeOOE9g8/tpq6ylatCVhJpLnRYA/zA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(39850400004)(396003)(508600001)(8936002)(86362001)(107886003)(4326008)(316002)(26005)(8676002)(956004)(186003)(6666004)(2906002)(6512007)(66556008)(2616005)(5660300002)(38350700002)(54906003)(38100700002)(16526019)(66946007)(9686003)(83380400001)(55236004)(52116002)(66476007)(6486002)(6916009)(6506007)(36756003)(1076003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tVwMZSd6d1C7fxzZHbuAn7HNHPe5UovE6koAbsckm8jhGsMtrGTN4odQUfRS?=
 =?us-ascii?Q?MFbvqNAlvKyTWZLuRqvIcYfQYfXODVai3JC6jVR+m+g15cAwR4Z40ClHlFha?=
 =?us-ascii?Q?wbo7k9SqWfaxxCQMZraR8bt/R8eqjLOftVe5h14wmtvrYEF3HfE2CIDwomTw?=
 =?us-ascii?Q?95gYaAFfakMsWFQMm494VbWtLZG9NSVP8Hk+MMIhze5r8A6Grws6daGRPmSO?=
 =?us-ascii?Q?OBO0Ni3wVwmo8Bc0RjmgCDGTR9VJcwU4NQznmE9IJ2CQJfDqLjRPmtS/wYjJ?=
 =?us-ascii?Q?uX0gHmBgrZxjDl2PY5/zdzHrRwJmDP9qNkrSW0B9Ea4lGFhomtwyuzQLeZsR?=
 =?us-ascii?Q?Dk7oCVcKz5c6f1TpGv3YwGlZ8lH2N0J/VTWHjYlHk1loyzMLewOxv2W3dEqp?=
 =?us-ascii?Q?kSUdutbEOuD+THX7AcNhw9PrvG5aqVyqQ7nQ/xk284izXm5F0Q66XkPi0NaS?=
 =?us-ascii?Q?zsBLLdtxcCWpkt7hQLTN+1DnXNJyykqLJH1ZXOE2AyWHQIkpRsuy1vQAHtIM?=
 =?us-ascii?Q?g0VIgu86lErVcoTAX0MaDLUfy/oAMjGkUTO3hwx5em3kcuCs1FXqQhAvrL4Y?=
 =?us-ascii?Q?syE/jwKWAAZS6r9rXjS2dh4LgyGnt3x9wGm2/VRDuOfWIjxhCv/JaYhYvIx5?=
 =?us-ascii?Q?rMy+hnLAhKKnT50OefrJp+VrFutnQHC3IYZLHGh8ZFK5/c570XQ3VpZ7CtG/?=
 =?us-ascii?Q?+XYG5lDBzlfg2LcJJXenNuhWWTxUisodqIXSWWD3qj/Uev8Dk14FpTikUqQr?=
 =?us-ascii?Q?3Y33zuzw2JmGAbO1fWExIfWi3zWUm36OSI7wUfM6lPnHkKHZxyHXMb1B+iZB?=
 =?us-ascii?Q?YvC/iBIbdzV73OgiiZ+WV5YCcQtZSxJmWClOLdagiS5VzCgadYBbtuEPO8n9?=
 =?us-ascii?Q?jCpPcc6qUsFC0ZLCqpTDwvulgcpnRYGsn61e50PgtW9QgmGwO6PLF7HXmUmo?=
 =?us-ascii?Q?A1Dn30xB2aoTl6FEcjWJPM1TO0oUGWppfOFMUpSoUFUwDbIzVzmIsrLtGiNp?=
 =?us-ascii?Q?Fn1CYhPBtdyms8jsi1Ux15s/hbGvlBkV+DeH29a5jRfNxn+gq2Z165hFhUzm?=
 =?us-ascii?Q?jTSero93wtMRk+lvUC7zE8vnqyiSPDlm7k3clf9loPaxF+0TvyXyvrbxnzCY?=
 =?us-ascii?Q?CCvc2pLTQE5/hNv/CRZ2nZKSZC3GXyDebEprgtW28fr3VQ6zfLQkQwL2JLiz?=
 =?us-ascii?Q?S9h4lJNcG2EvKtKV6Ml5FM2QBQhMODgMpsqvAdRPk3rfxOJ34i1ozknyXsdf?=
 =?us-ascii?Q?8IFGq9+hxR0uVb1OzmvIeC1WD5UCKJz+yjTifaIoxSUqDVsiJZXiB2NaapLa?=
 =?us-ascii?Q?b/Z3nw+8fHeWHx7brLd1mrNf?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea68c52-c03e-4c4b-1793-08d931a9c2f9
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:44.1537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlWf4Ga+bxLZEWfKMMVbhxlGBatcaz8126j3STj7KAdxxlWwEg1LtxJQFD5CXt7YqJAExfADAXhxdnWwjPg+Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0260
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/rx/rx.h | 173 +++++++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/rx/rx.h

diff --git a/drivers/net/wireless/celeno/cl8k/rx/rx.h b/drivers/net/wireles=
s/celeno/cl8k/rx/rx.h
new file mode 100644
index 000000000000..17225990ab50
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/rx/rx.h
@@ -0,0 +1,173 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_RX_H
+#define CL_RX_H
+
+#include "wrs/wrs_db.h"
+#include "hw.h"
+
+/* Decryption status subfields */
+enum cl_rx_hd_decr {
+       CL_RX_HDR_DECR_UNENC,
+       CL_RX_HDR_DECR_ICVFAIL,
+       CL_RX_HDR_DECR_CCMPFAIL,
+       CL_RX_HDR_DECR_AMSDUDISCARD,
+       CL_RX_HDR_DECR_NULLKEY,
+       CL_RX_HDR_DECR_WEPSUCCESS,
+       CL_RX_HDR_DECR_TKIPSUCCESS,
+       CL_RX_HDR_DECR_CCMPSUCCESS
+};
+
+#define CL_PADDING_IN_BYTES 2
+
+struct hw_rxhdr {
+       u32 msdu_cnt           : 8,   /* [7:0] */
+           corrupted_amsdu    : 1,   /* [8] */
+           reserved           : 1,   /* [9] */
+           msdu_dma_align     : 2,   /* [11:10] */
+           amsdu_error_code   : 4,   /* [15:12] */
+           reserved_2         :16;   /* [31:16] */
+
+       /* Total length for the MPDU transfer */
+       u32 len                :14,   /* [13:0] */
+           ampdu_cnt          : 2,   /* [15:14] */
+           rx_padding_done    : 1,   /* [16] */
+           rx_class_rule_res  : 7,   /* [23:17] */
+
+       /* AMPDU Status Information */
+           mpdu_cnt           : 8;   /* [31:24] */
+
+       /* TSF Low */
+       __le32 tsf_lo;
+       /* TSF High */
+       __le32 tsf_hi;
+
+       /* Receive Vector 1a */
+       u32 leg_length         :12,   /* [11:0] */
+           leg_rate           : 4,   /* [15:12] */
+           ht_length_l        :16;   /* [31:16] */
+
+       /* Receive Vector 1b */
+       u32 ht_length_h        : 8,   /* [7:0] */
+           mcs                : 7,   /* [14:8] */
+           pre_type           : 1,   /* [15] */
+           format_mod         : 4,   /* [19:16] */
+           reserved_1b        : 1,   /* [20] */
+           n_sts              : 3,   /* [23:21] */
+           lsig_valid         : 1,   /* [24] */
+           sounding           : 1,   /* [25] */
+           num_extn_ss        : 2,   /* [27:26] */
+           aggregation        : 1,   /* [28] */
+           fec_coding         : 1,   /* [29] */
+           dyn_bw             : 1,   /* [30] */
+           doze_not_allowed   : 1;   /* [31] */
+
+       /* Receive Vector 1c */
+       u32 sn                 : 4,  /* [3:0] */
+           warn_1c            : 1,  /* [4] */
+           stbc               : 2,  /* [6:5] */
+           smoothing          : 1,  /* [7] */
+           partial_aid        : 9,  /* [16:8] */
+           group_id           : 6,  /* [22:17] */
+           reserved_1c        : 1,  /* [23] */
+           rssi1              : 8;  /* [31:24] */
+
+       /* Receive Vector 1d */
+       s32 rssi2              : 8,  /* [7:0] */
+           rssi3              : 8,  /* [15:8] */
+           rssi4              : 8,  /* [23:16] */
+           rx_chains          : 8;  /* [31:24] */
+
+       /* Receive Vector 1e */
+       u32 txop_duration      : 7,  /* [6:0] */
+           beam_change        : 1,  /* [7] */
+           mcs_sig_b          : 3,  /* [10:8] */
+           dcm                : 1,  /* [11] */
+           dcm_sig_b          : 1,  /* [12] */
+           beamformed         : 1,  /* [13] */
+           ltf_type           : 2,  /* [15:14] */
+           ru_band            : 1,  /* [16] */
+           ru_type            : 3,  /* [19:17] */
+           ru_index           : 6,  /* [25:20] */
+           pe_duration        : 3,  /* [28:26] */
+           ch_bw              : 2,  /* [30:29] */
+           reserved_1e        : 1;  /* [31] */
+
+       /* Receive Vector 1f */
+       u32 spatial_reuse      : 16, /* [16:0] */
+           service            : 16; /* [32:17] */
+
+       /* Receive Vector 1g */
+       u32 bss_color          : 6,  /* [5:0] */
+           gi_type            : 2,  /* [7:6] */
+           antenna_set        : 16, /* [23:8] */
+           rssi5              : 8;  /* [31:24] */
+
+       /* Receive Vector 1h */
+       s32 rssi6              : 8,  /* [7:0] */
+           rssi7              : 8,  /* [15:8] */
+           rssi8              : 8,  /* [23:16] */
+           future_1           : 8;  /* [31:24] */
+
+       /* Receive Vector 2a */
+       u32 rcpi               : 8,  /* [7:0] */
+           evm1               : 8,  /* [15:8] */
+           evm2               : 8,  /* [23:16] */
+           evm3               : 8;  /* [31:24] */
+
+       /* Receive Vector 2b */
+       u32 evm4               : 8,  /* [7:0] */
+           warn_2b            : 1,  /* [8] */
+           reserved2b_1       : 7,  /* [15:9] */
+           reserved2b_2       : 8,  /* [23:16] */
+           reserved2b_3       : 8;  /* [31:24] */
+
+       /* Status **/
+       u32 rx_vect2_valid     : 1,  /* [0] */
+           resp_frame         : 1,  /* [1] */
+           decr_status        : 3,  /* [4:2] */
+           rx_fifo_oflow      : 1,  /* [5] */
+           undef_err          : 1,  /* [6] */
+           phy_err            : 1,  /* [7] */
+           fcs_err            : 1,  /* [8] */
+           addr_mismatch      : 1,  /* [9] */
+           ga_frame           : 1,  /* [10] */
+           first_qos_data     : 1,  /* [11] */
+           amsdu_present      : 1,  /* [12] */
+           frm_successful_rx  : 1,  /* [13] */
+           desc_done_rx       : 1,  /* [14] */
+           desc_spare         : 1,  /* [15] */
+           key_sram_index     : 9,  /* [24:16] */
+           key_sram_v         : 1,  /* [25] */
+           type               : 2,  /* [27:26] */
+           subtype            : 4;  /* [31:28] */
+
+       /* PHY channel information 1 */
+       u32 phy_band           : 8,  /* [7:0] */
+           phy_channel_type   : 8,  /* [15:8] */
+           phy_prim20_freq    : 16; /* [31:16] */
+
+       /* PHY channel information 2 */
+       u32 phy_center1_freq   : 16, /* [15:0] */
+           phy_center2_freq   : 16; /* [31:16] */
+
+       /* Patten **/
+       u32 pattern;
+};
+
+void cl_rx_init(struct cl_hw *cl_hw);
+void cl_rx_off(struct cl_hw *cl_hw);
+void cl_rx_remote_tasklet_sched(void *t);
+void cl_rx_remote_cpu_info(struct cl_hw *cl_hw);
+void cl_rx_push_queue(struct cl_hw *cl_hw, struct sk_buff *skb);
+void cl_rx_skb_alloc_handler(struct sk_buff *skb);
+void cl_rx_post_recovery(struct cl_hw *cl_hw);
+void cl_rx_info_reset(struct cl_hw *cl_hw);
+int cl_rx_info_print(struct cl_hw *cl_hw);
+void cl_rx_netif(struct cl_hw *cl_hw, struct cl_vif *cl_vif, struct sk_buf=
f *skb);
+void cl_rx_finish(struct cl_hw *cl_hw, struct sk_buff *skb);
+u8 cl_rx_get_skb_ac(struct ieee80211_hdr *hdr);
+bool cl_rx_process_in_irq(struct cl_hw *cl_hw);
+
+#endif /* CL_RX_H */
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

