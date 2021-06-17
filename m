Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E803AB8C5
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbhFQQKX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:23 -0400
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]:33286
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231818AbhFQQJV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJ5GcjTlPvXHAWx5q0t+zR1ZhrIDZMH5PTgGlTXP3dk15ZF3ykhbJ6UhiY8cYOwfT3+yFFi22FZJx06+w9ldrc9Cs4YHGi3xcd/hsEGdtaOeBKpcWiemp6Vig/9jpYUQ0sSo0bGMlyf/oDiAJGmRbJlNWIVzb7neqZxMp3i7MlpFeNcyVvX2dRLuecizwS7mvTIiQZrflk9T2K6JFh56lud1yah3eFFhLYsUqtCrks6p3KOOzj4d6unBOIOG+oq0eAwylrfJx0R9YInWkmOu2ib4VEoXs2vOwGGibGz39UOn5WpEmlHJ+Jm7Ti/qPFJt2z2pxAKfUNw+1zIIuRlBog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MErkgWJhQLRQmmgYOaX5hojSLPxXyCOrLhiMzxyE2c=;
 b=acUl50NUg7oA61hLzDf8Sn1x4R4oQVcXH+Q9yqKBZmSrvf5VyrC4M4gN2m8w9dM7h54+fuL4A03QSK2QDCkTZupwAJD6/QoDlHbLjxYOMy+u/DB+X1Dz9SIoTxyBr0JpLz00R1CI4dsmVWsUvGHJZCbUG05i0KGq30ZszY090J5e1RWetwzIlyla8i3gSvNIwqxFfg8SbPcGtVDhRECKWwwUHnGgGilyzTqXgs5lSYUNSzl6g5ptGHA6RjGnMbMUACwAPtwkZ1v2w2GMRM/pqs3L1TfQJLo+Iexhi+1fp4u10qdbIwQvkiMFYN9SqPPQeqYyeQcX1zCOaoolZb7+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MErkgWJhQLRQmmgYOaX5hojSLPxXyCOrLhiMzxyE2c=;
 b=eLfpTkxfm9+dHGoHKLwFCEbjx13hXyetNd12qLcOF401+XgbhcNPdzpC4xSRnl5kmqGGCtHUcClwUCyQAYng7CtQJFvgaG4iLkVLOsE6+V1Iz9MXO5RSfMao6mibfWLFlbSBV4lAYpOcbdENsIRe3eDBZt88JDGk5Wv5ZQTq3OI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0260.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:47::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 17 Jun
 2021 16:06:33 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:06:33 +0000
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
Subject: [RFC v1 172/256] cl8k: add rx/rx.c
Date:   Thu, 17 Jun 2021 16:00:59 +0000
Message-Id: <20210617160223.160998-173-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e0a84db-3526-4263-0d76-08d931a9c240
X-MS-TrafficTypeDiagnostic: AM0P192MB0260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB02606ADEFD677F45DD0FDD78F60E9@AM0P192MB0260.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:327;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mUwBntwmx4DsrDHjHI6MF27c3zSCXKRV28CiGiBQnofCA6Ar/inpzcALgNjMU9wVd62F7Y6WKheLr/2/bj+yq2ION6N0I15MwREKfNuJme9rksA8QaeBJh7usbFXqA8hp5cCU+kqijj1atdEtVOHftWNM9Xw7RVEaxnbFSxO5rErn7+N60eV+lG+9NsGWf6iOcPgBePrml4dUyCy/pq/fDPtAK9PabU3k/28Bk3ERhEvwqNMhBSTJsWMsCIMe2B0xpUHHBD6ZS9B8qnDVLrowQZ/masWvQClNidlEQ/TTpD4uqJnAVlVm8IPDP++uCN/fOdkbXZSlSt7WlkUCHE9CA3GxkIffvwGuu/iyOqiFjSWK10jzcNFSXO7Kn8AnUePHKBczS4k2ybiiGSbA80CDc5rfKzVWwJXONNFIAFzVIcBHNoCsfppv0HkxfLBkWTOt5VudPxNEAR0Gco5Urd2OKl9HZiPNZ6GWTVjQ5oQxrFesVF2G60UbbyoqVvkmHyAh7UJf7JNvffkkCOO3lm0JMBIrdk/qthyP88yew0eUArjfZ096R0gIG8XYTFIA2h0jWuA8V7oJkTPzyjFuogprLrN0fuBNpZ+BXVTGfjdUxoLD7+KkSuzgS17BCu83Hu1EiYjDt/4wNd3/q1oloeN3g+462FIVSGUhae3qhHe33Eb4/J2q20zWbWvxCTRVksDOkDO48xqfL1lVIrYX8GXdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(39850400004)(396003)(508600001)(8936002)(86362001)(107886003)(4326008)(316002)(26005)(8676002)(956004)(186003)(6666004)(2906002)(6512007)(66556008)(2616005)(5660300002)(38350700002)(54906003)(38100700002)(16526019)(66946007)(9686003)(83380400001)(55236004)(52116002)(66476007)(6486002)(6916009)(30864003)(6506007)(36756003)(1076003)(69590400013)(32563001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d0IfkrtOJRhjRJ5cqeDkX+ROjEhWTKuDOVcm5kYzUBdhb//ir8Xx5FXALX64?=
 =?us-ascii?Q?7wr8/rBuYrFPN6hzH4jPRn6CZugXOQg/SrUzZpry3d52s6M7aWLqnBSWhNbD?=
 =?us-ascii?Q?rW8RXjkFy5D+UPRtJDtxZgzQJukar9xMFGt2m+Kq0Se3Mo1/29xw/a37wunc?=
 =?us-ascii?Q?Wf3vzoSs/bD1o+v1aBU1IFDllReddw8HR21ED9aMmkvkbNUUXLqhgAxQQjUX?=
 =?us-ascii?Q?WhZvGKi1dfHAscgkgaUhzm2+tJFVYocciopvIDNsnMo4NDxg8R7PdxHPpgku?=
 =?us-ascii?Q?9qcxXZIopIkT/2aqPiL+3wG+ho9EmUFrOWGtfuv/Uazzx4fghNmXuf4wq+qz?=
 =?us-ascii?Q?bNpXq66a1KGF0EZboSPM5YB8i7Eyv7UhAq8YfTwFJFQ+l4j2CQs+HwG6jpB8?=
 =?us-ascii?Q?Jro6w0mYkMq99oaV9S3BxXZmjvN4byzTg4mcqTGrOlpEDq+GFlxjSYAmGRck?=
 =?us-ascii?Q?rmTLEFZWP61qZL+z/LHnsR776bMqSTToQ4GMCg55RZymhQDjvzNbyY8NjcDN?=
 =?us-ascii?Q?LRG8TfkFN6Zhqu5mxBkO4+4nmH2fBhlrNLopoWp0cbS5V8vPYXL3ZHFqtUED?=
 =?us-ascii?Q?dbpivffksSgirC+ciQcP4b9stntYFChYQ4qWHQUMeCFMnIOZ5ob4APuU4FJY?=
 =?us-ascii?Q?fTchGX/4Tg/sxAifsbvPfzjyLt+GdWBcNDjUMVkdgAZDoJsUD/ai/xhqF0Of?=
 =?us-ascii?Q?DETJQx0KW+/2vSMDeduKmpn+Q3afMuMbTldM76GqzF9mJX39ugWg2VChXS4w?=
 =?us-ascii?Q?B0pQGDpKxxofgM07z5u++AzoDfybxNGW5XaR+cM33dL9ZxHQ6TiNcDTS3H6y?=
 =?us-ascii?Q?pMM/EkA0AbGihHkNqHD0tVPt111ZKsgYynm8bUzrSsTEfPQ8w8822zDj4CQ5?=
 =?us-ascii?Q?tZJZpKT9UryS7vD4sBOeGH+bLvwrUQQMZ+1w7FsDPMp0xqfYlhq4lz1O1DWf?=
 =?us-ascii?Q?1S51oxlxtL9dhpXap7JYYrUDgbY1wRIACu6y73rfuGJmkrAGwUhT7mnr/cI4?=
 =?us-ascii?Q?Yx1OKqFXp+OV5ue3p4zBlJcCHAIQmN5jxOvOec1lDSVBn25G1ah/6n2yAG8b?=
 =?us-ascii?Q?kqnhibS592OLEaXYEfV8neDRf6PnFHu6GuYXm/XlCgSLF63JSdGBI9Nt1jO2?=
 =?us-ascii?Q?rIBhuDJ0aOcXrLxWnrAb3nXk3+GWftZzTt68G6jbcM4gSyxHZGggCoWIacUw?=
 =?us-ascii?Q?qcFKRsjVr7ZG0K+Q1PLVAHFQXm13trD9SaqGW2e4Jhflz8xwPnJ8/Aiq3TZ4?=
 =?us-ascii?Q?zNzqW5SSIENaCGnVatwOcoReT+CG3PNEOz5raBygf3ALtHBrqN2+gsSRlTmD?=
 =?us-ascii?Q?r2spiPkSs82ZbtXsaG/dV0P7?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0a84db-3526-4263-0d76-08d931a9c240
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:43.1043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAZn8uCncdLj8KlkYdAGNP98PUO/E1PRunJGZ3x7p+9+xozcEZcdB8pnCJSKwvt2FBCAAUL1xmVN4QBvh2kTTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0260
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/rx/rx.c | 1108 ++++++++++++++++++++++
 1 file changed, 1108 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/rx/rx.c

diff --git a/drivers/net/wireless/celeno/cl8k/rx/rx.c b/drivers/net/wireles=
s/celeno/cl8k/rx/rx.c
new file mode 100644
index 000000000000..d55038ae2e85
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/rx/rx.c
@@ -0,0 +1,1108 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "tx/tx.h"
+#include "rx/rx.h"
+#include "rx/rx_amsdu.h"
+#include "stats.h"
+#include "rate_ctrl.h"
+#include "rssi.h"
+#include "band.h"
+#include "utils/utils.h"
+#include "vns.h"
+#include "dfs/dfs.h"
+#include "wrs/wrs_api.h"
+#include "twt.h"
+#include "recovery.h"
+#include "fw/fw_dbg.h"
+#include "def.h"
+#include "rx/rx_reorder.h"
+#include "ops.h"
+#include "chip.h"
+#include "channel.h"
+#ifdef CONFIG_CL_PCIE
+#include "bus/pci/rx_pci.h"
+#endif
+#ifdef TRACE_SUPPORT
+#include "trace.h"
+#endif
+
+/* Must correspond to FW definition of MM_SEC_DEFAULT_KEY_COUNT */
+#define MM_SEC_DEFAULT_KEY_COUNT 64
+
+#define VHT_MCS_MASK 0x0F
+#define VHT_MCS_OFT  0
+
+/* Number of entries in HW legacy rate conversion table */
+#define LEGACY_RATE_MAX 16
+
+static const s8 legacy_rates_lut[LEGACY_RATE_MAX] =3D {
+       0,      /* 0: 1 Mbps   */
+       1,      /* 1: 2 Mbps   */
+       2,      /* 2: 5.5 Mbps */
+       3,      /* 3: 11 Mbps  */
+       -1,     /* 4: Invalid  */
+       -1,     /* 5: Invalid  */
+       -1,     /* 6: Invalid  */
+       -1,     /* 7: Invalid  */
+       10,     /* 8: 48 Mbps  */
+       8,      /* 9: 24 Mbps  */
+       6,      /* 10: 12 Mbps */
+       4,      /* 11: 6 Mbps  */
+       11,     /* 12: 54 Mbps */
+       9,      /* 13: 36 Mbps */
+       7,      /* 14: 18 Mbps */
+       5       /* 15: 9 Mbps  */
+};
+
+/*
+ * rx_skb_cnt is an atomic counter that tracks the total number of skbs in
+ * the entire host.
+ * The counter is incremented when skb is allocated, and freed when the sk=
b
+ * is freed (=3Ddestructor function called).
+ * Therefore the counter is global (and not part of cl_hw or cl_chip).
+ *
+ * rx_skb_max is the configured to:
+ * max(chip0->conf->ci_rx_skb_max, chip1->conf->ci_rx_skb_max)
+ */
+static atomic_t rx_skb_cnt =3D ATOMIC_INIT(0);
+static u32 rx_skb_max;
+
+static void cl_rx_skb_destructor(struct sk_buff *skb)
+{
+       atomic_dec(&rx_skb_cnt);
+}
+
+static DEFINE_PER_CPU(struct tasklet_struct, rx_remote_tasklet_mac[TCV_TOT=
AL]);
+
+static void cl_rx_remote_cpu_mac(struct cl_hw *cl_hw)
+{
+       int cpu =3D cl_hw->conf->ci_rx_remote_cpu_mac;
+       struct tasklet_struct *t =3D &per_cpu(rx_remote_tasklet_mac[cl_hw->=
idx], cpu);
+
+       if (!test_bit(TASKLET_STATE_SCHED, &t->state))
+               smp_call_function_single(cpu, cl_rx_remote_tasklet_sched, t=
, 0);
+}
+
+static int cl_rx_check_err(struct cl_hw *cl_hw, struct sk_buff *skb, struc=
t hw_rxhdr *rxhdr)
+{
+       u32 status;
+
+       if (rxhdr->frm_successful_rx)
+               return 0;
+
+       /* The status field is in offset of 14 u32's */
+       status =3D *((u32 *)rxhdr + 14);
+
+       if (rxhdr->fcs_err) {
+               cl_hw->radio_stats[CL_RADIO_FCS_ERROR]++;
+               cl_dbg_err(cl_hw, "fcs_err (status 0x%x)\n", status);
+       }
+
+       if (rxhdr->rx_fifo_oflow) {
+               cl_hw->radio_stats[CL_RADIO_RX_FIFO_OVERFLOW]++;
+               cl_dbg_err(cl_hw, "rx_fifo_oflow (status 0x%x)\n", status);
+       }
+
+       if (rxhdr->undef_err) {
+               cl_hw->radio_stats[CL_RADIO_UNDEFINED_ERROR]++;
+               cl_dbg_err(cl_hw, "undef_err (status 0x%x)\n", status);
+       }
+
+       if (rxhdr->phy_err) {
+               cl_hw->radio_stats[CL_RADIO_PHY_ERROR]++;
+               cl_dbg_err(cl_hw, "phy_err (status 0x%x)\n", status);
+       }
+
+       if (rxhdr->addr_mismatch) {
+               cl_hw->radio_stats[CL_RADIO_ADDRESS_MISMATCH]++;
+               cl_dbg_err(cl_hw, "addr_mismatch (status 0x%x)\n", status);
+       }
+
+       cl_hw->rx_info.pkt_drop_not_success++;
+       kfree_skb(skb);
+
+       return -1;
+}
+
+static u8 chnl_bw_to_rate_info_bw[CHNL_BW_MAX] =3D {
+       [CHNL_BW_20] =3D RATE_INFO_BW_20,
+       [CHNL_BW_40] =3D RATE_INFO_BW_40,
+       [CHNL_BW_80] =3D RATE_INFO_BW_80,
+       [CHNL_BW_160] =3D RATE_INFO_BW_160,
+};
+
+static u8 chnl_bw_factor[CHNL_BW_MAX] =3D {
+       [CHNL_BW_20] =3D 0,
+       [CHNL_BW_40] =3D 3,
+       [CHNL_BW_80] =3D 6,
+       [CHNL_BW_160] =3D 9,
+};
+
+static int cl_rx_fill_status(struct cl_hw *cl_hw, struct cl_sta *cl_sta, s=
truct sk_buff *skb,
+                            struct hw_rxhdr *rxhdr, u8 *encrypt_len)
+{
+       s8 rssi[MAX_ANTENNAS] =3D RX_HDR_RSSI(rxhdr);
+       struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)skb->data;
+       struct ieee80211_rx_status *status =3D IEEE80211_SKB_RXCB(skb);
+       u8 tid =3D ieee80211_get_tid(hdr);
+       u8 factor;
+
+       memset(status, 0, sizeof(struct ieee80211_rx_status));
+
+       status->mactime =3D ((u64)le32_to_cpu((rxhdr->tsf_hi)) << 32) | le3=
2_to_cpu(rxhdr->tsf_lo);
+       status->flag |=3D RX_FLAG_MACTIME_END;
+
+       if (cl_sta && cl_sta->tid_agg_rx[tid])
+               status->flag |=3D RX_FLAG_DUP_VALIDATED;
+
+       status->antenna =3D rxhdr->antenna_set;
+       status->band =3D cl_band_from_fw_idx(rxhdr->phy_band);
+
+       if (rxhdr->format_mod >=3D FORMATMOD_HE_SU) {
+               status->encoding =3D RX_ENC_HE;
+               status->rate_idx =3D (rxhdr->mcs & VHT_MCS_MASK) >> VHT_MCS=
_OFT;
+               status->nss =3D rxhdr->n_sts + 1;
+
+               /* he_gi expectes to get values according to enum nl80211_h=
e_gi */
+               status->he_gi =3D convert_gi_format_wrs_to_fw(WRS_MODE_HE, =
rxhdr->gi_type);
+       } else if (rxhdr->format_mod =3D=3D FORMATMOD_VHT) {
+               status->encoding =3D RX_ENC_VHT;
+               status->rate_idx =3D (rxhdr->mcs & VHT_MCS_MASK) >> VHT_MCS=
_OFT;
+               status->nss =3D rxhdr->n_sts + 1;
+
+               if (rxhdr->gi_type)
+                       status->enc_flags |=3D RX_ENC_FLAG_SHORT_GI;
+       } else if (rxhdr->format_mod =3D=3D FORMATMOD_HT_GF) {
+               status->encoding =3D RX_ENC_HT;
+               status->enc_flags |=3D RX_ENC_FLAG_HT_GF;
+               status->rate_idx =3D rxhdr->mcs;
+
+               if (rxhdr->gi_type)
+                       status->enc_flags |=3D RX_ENC_FLAG_SHORT_GI;
+
+       } else if (rxhdr->format_mod =3D=3D FORMATMOD_HT_MF) {
+               status->encoding =3D RX_ENC_HT;
+               status->rate_idx =3D rxhdr->mcs;
+
+               if (rxhdr->gi_type)
+                       status->enc_flags |=3D RX_ENC_FLAG_SHORT_GI;
+       } else {
+               if (legacy_rates_lut[rxhdr->leg_rate] !=3D -1)
+                       status->rate_idx =3D legacy_rates_lut[rxhdr->leg_ra=
te];
+               if (status->band !=3D NL80211_BAND_2GHZ)
+                       status->rate_idx -=3D RATE_CTRL_OFFSET_OFDM;
+               if (!rxhdr->pre_type)
+                       status->enc_flags |=3D RX_ENC_FLAG_SHORTPRE;
+       }
+
+       if (rxhdr->aggregation) {
+               status->flag |=3D RX_FLAG_AMPDU_DETAILS;
+               status->ampdu_reference =3D rxhdr->ampdu_cnt;
+       }
+
+       /* Set bw field */
+       status->bw =3D chnl_bw_to_rate_info_bw[rxhdr->ch_bw];
+
+       factor =3D chnl_bw_factor[rxhdr->ch_bw];
+       cl_rssi_bw_adjust(cl_hw, rxhdr, factor);
+
+       /*
+        * Todo check if when a frame is received on 40MHz or more bandwidt=
h,
+        * we need to take the center1_freq instead of the prim20_freq
+        */
+       status->freq =3D le16_to_cpu(Q2_TO_FREQ(rxhdr->phy_prim20_freq));
+
+       status->signal =3D cl_rssi_calc_equivalent(cl_hw, rssi);
+
+       switch (rxhdr->decr_status) {
+       case CL_RX_HDR_DECR_UNENC:
+               if (ieee80211_has_protected(hdr->frame_control)) {
+                       cl_dbg_warn(cl_hw, "Protected frame unencrypted\n")=
;
+                       cl_hw->rx_info.pkt_drop_unencrypted++;
+                       return -1;
+               }
+               break;
+       case CL_RX_HDR_DECR_ICVFAIL:
+       case CL_RX_HDR_DECR_AMSDUDISCARD:
+       case CL_RX_HDR_DECR_NULLKEY:
+       case CL_RX_HDR_DECR_CCMPFAIL:
+               cl_dbg_warn(cl_hw, "Decryption failed (%u)\n", rxhdr->decr_=
status);
+               cl_hw->rx_info.pkt_drop_decrypt_fail++;
+               *encrypt_len =3D 0;
+               return -1;
+       case CL_RX_HDR_DECR_WEPSUCCESS:
+       case CL_RX_HDR_DECR_TKIPSUCCESS:
+               *encrypt_len =3D IEEE80211_WEP_ICV_LEN;
+               status->flag |=3D (RX_FLAG_DECRYPTED | RX_FLAG_ICV_STRIPPED=
);
+               break;
+       case CL_RX_HDR_DECR_CCMPSUCCESS:
+               *encrypt_len =3D IEEE80211_CCMP_HDR_LEN;
+               status->flag |=3D (RX_FLAG_DECRYPTED | RX_FLAG_MIC_STRIPPED=
);
+               status->flag |=3D RX_FLAG_PN_VALIDATED;
+               break;
+       }
+
+       return 0;
+}
+
+static void cl_rx_action_twt_setup(struct cl_hw *cl_hw, struct cl_ieee8021=
1_mgmt *mgmt,
+                                  int len, struct cl_sta *cl_sta)
+{
+       u32 min_size =3D 0;
+       u8 negotiation_type =3D
+               mgmt->u.action.u.twt_individual_setup.twt_elem.control.fiel=
ds.negotiation_type;
+
+       /* Individual TWT */
+       if ((negotiation_type & 0x2) =3D=3D 0) {
+               /* Verify min size */
+               min_size =3D IEEE80211_MIN_ACTION_SIZE  + 4 +
+                       sizeof(mgmt->u.action.u.twt_individual_setup.twt_el=
em);
+
+               if (len < min_size) {
+                       cl_dbg_err(cl_hw, "TWT: Individual setup action fra=
me length error\n");
+                       return;
+               }
+
+               /* Regular individual TWT */
+               if (negotiation_type =3D=3D 0)
+                       cl_twt_handle_individual_setup_request(cl_hw, cl_st=
a, mgmt);
+       } else { /* Broadcast TWT */
+               /* Verify min size */
+               min_size =3D IEEE80211_MIN_ACTION_SIZE  + 4 +
+                       sizeof(mgmt->u.action.u.twt_broadcast_setup.twt_ele=
m);
+
+               if (len < min_size) {
+                       cl_dbg_err(cl_hw, "TWT: Broadcast setup action fram=
e length error\n");
+                       return;
+               }
+       }
+}
+
+static void cl_rx_action_twt_teardown(struct cl_hw *cl_hw, struct cl_ieee8=
0211_mgmt *mgmt,
+                                     int len, struct cl_sta *cl_sta)
+{
+       u8 negotiation_type;
+
+       if (len < IEEE80211_MIN_ACTION_SIZE + 2) {
+               cl_dbg_err(cl_hw, "Invalid length of TWT teardown action fr=
ame\n");
+               return;
+       }
+
+       negotiation_type =3D mgmt->u.action.u.twt_individual_teardown.negot=
iation_type;
+
+       if (negotiation_type <=3D 1)
+               cl_twt_handle_individual_teardown_request(cl_hw, cl_sta, mg=
mt);
+}
+
+static void cl_rx_action_frame_handler(struct cl_hw *cl_hw, struct cl_ieee=
80211_mgmt *mgmt,
+                                      int len, struct cl_sta *cl_sta)
+{
+       /* Verify action code is present */
+       if (len < IEEE80211_MIN_ACTION_SIZE + 1)
+               return;
+
+       switch (mgmt->u.action.category) {
+       case WLAN_CATEGORY_UNPROTECTED_S1G:
+               if (!cl_twt_is_enabled(cl_hw))
+                       break;
+
+               if (cl_sta->cl_vif->vif->type !=3D NL80211_IFTYPE_AP)
+                       break;
+
+               switch (mgmt->u.action.u.twt_individual_setup.action_code) =
{
+               case WLAN_UNPROT_S1G_ACTION_TWT_SETUP:
+                       cl_rx_action_twt_setup(cl_hw, mgmt, len, cl_sta);
+                       break;
+               case WLAN_UNPROT_S1G_ACTION_TWT_TEARDOWN:
+                       cl_rx_action_twt_teardown(cl_hw, mgmt, len, cl_sta)=
;
+                       break;
+               default:
+                       break;
+               }
+               break;
+       case WLAN_CATEGORY_WNM:
+               /* TODO: Here may be bss_color_check_action */
+               break;
+       default:
+               break;
+       }
+}
+
+static void cl_rx_mgmt_check(struct cl_hw *cl_hw, struct sk_buff *skb,
+                            struct cl_sta *cl_sta, struct hw_rxhdr *rxhdr)
+{
+       struct ieee80211_mgmt *mgmt =3D (struct ieee80211_mgmt *)skb->data;
+       __le16 fc =3D mgmt->frame_control;
+
+       if (!ieee80211_is_mgmt(fc))
+               return;
+
+       if (cl_sta) {
+               if (ieee80211_is_action(fc))
+                       cl_rx_action_frame_handler(cl_hw, (struct cl_ieee80=
211_mgmt *)mgmt,
+                                                  skb->len, cl_sta);
+       } else {
+               s8 rssi[MAX_ANTENNAS] =3D RX_HDR_RSSI(rxhdr);
+
+               cl_vns_mgmt_handler(cl_hw, mgmt->sa, rssi);
+
+               if (ieee80211_is_assoc_req(fc) || ieee80211_is_assoc_resp(f=
c))
+                       cl_rssi_assoc_handle(cl_hw, mgmt->sa, rxhdr);
+       }
+}
+
+static void cl_rx_data_check(struct cl_hw *cl_hw, struct sk_buff *skb,
+                            struct cl_sta *cl_sta, u32 packet_len, struct =
hw_rxhdr *rxhdr)
+{
+       if (cl_sta) {
+               cl_traffic_rx_handler(cl_hw, cl_sta, packet_len);
+
+               if (!rxhdr->aggregation || (rxhdr->aggregation && rxhdr->mp=
du_cnt =3D=3D 0))
+                       cl_motion_sense_rssi_data(cl_hw, cl_sta, rxhdr);
+       }
+}
+
+static bool cl_rx_skb_done(struct cl_hw *cl_hw, struct sk_buff *skb,
+                          struct cl_sta *cl_sta, struct hw_rxhdr *rxhdr)
+{
+       struct ieee80211_rx_status *status =3D IEEE80211_SKB_RXCB(skb);
+       struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)skb->data;
+       __le16 fc =3D hdr->frame_control;
+       struct cl_vif *cl_vif =3D NULL;
+
+       /* Update trigger base statistics */
+       cl_fw_dbg_trigger_based_update(cl_hw, rxhdr, hdr);
+
+       if (cl_sta) {
+               cl_vif =3D cl_sta->cl_vif;
+               skb->dev =3D cl_vif->dev;
+
+               cl_stats_update_rx_rate(cl_hw, cl_sta, rxhdr);
+
+               if (!rxhdr->aggregation || (rxhdr->aggregation && rxhdr->mp=
du_cnt =3D=3D 0))
+                       cl_rssi_rx_handler(cl_hw, cl_sta, rxhdr, status->si=
gnal);
+       } else {
+               cl_vif =3D cl_vif_get_by_mac(cl_hw, hdr->addr3);
+               skb->dev =3D cl_vif ? cl_vif->dev : NULL;
+
+               if (cl_hw->chip->conf->ce_production_mode)
+                       cl_stats_update_rx_rate_production(cl_hw, rxhdr);
+       }
+
+       /* DATA */
+       if (ieee80211_is_data(fc)) {
+               cl_rx_data_check(cl_hw, skb, cl_sta, skb->len, rxhdr);
+               goto out;
+       }
+
+       /* MGMT/CTL */
+       if (cl_sta)
+               cl_motion_sense_rssi_mgmt_ctl(cl_hw, cl_sta, rxhdr);
+
+       /* MGMT */
+       cl_rx_mgmt_check(cl_hw, skb, cl_sta, rxhdr);
+
+out:
+       if (rx_skb_max &&
+           atomic_read(&rx_skb_cnt) >=3D rx_skb_max) {
+               cl_hw->rx_info.pkt_drop_host_limit++;
+               kfree_skb(skb);
+               return false;
+       }
+
+       return true;
+}
+
+static void cl_rx_pass_to_mac(struct cl_hw *cl_hw,
+                             struct ieee80211_sta *sta,
+                             struct sk_buff_head *frames)
+{
+       if (cl_hw->conf->ci_rx_remote_cpu_mac =3D=3D -1) {
+               struct sk_buff *skb =3D NULL;
+
+               while ((skb =3D __skb_dequeue(frames)))
+                       ieee80211_rx_napi(cl_hw->hw, sta, skb, NULL);
+       } else {
+               struct sk_buff_head *rx_remote_queue_mac =3D &cl_hw->rx_rem=
ote_queue_mac;
+
+               spin_lock(&rx_remote_queue_mac->lock);
+               skb_queue_splice_tail_init(frames, rx_remote_queue_mac);
+               spin_unlock(&rx_remote_queue_mac->lock);
+
+               cl_rx_remote_cpu_mac(cl_hw);
+       }
+}
+
+static void cl_rx_amsdu_done_reorder(struct cl_hw *cl_hw, struct cl_sta *c=
l_sta,
+                                    struct sk_buff_head *frames)
+{
+       struct sk_buff *skb =3D NULL;
+       struct sk_buff_head reorder_buf;
+
+       /* Init the reorder buffer */
+       __skb_queue_head_init(&reorder_buf);
+
+       while ((skb =3D __skb_dequeue(frames)))
+               cl_rx_reorder_ampdu(cl_hw, cl_sta, skb, &reorder_buf);
+
+       if (!skb_queue_empty(&reorder_buf))
+               cl_rx_pass_to_mac(cl_hw, &cl_sta->stainfo->sta, &reorder_bu=
f);
+}
+
+static void cl_rx_amsdu_done(struct cl_hw *cl_hw, struct cl_amsdu_rx_state=
 *amsdu_rx_state)
+{
+       struct sk_buff_head *frames =3D &amsdu_rx_state->frames;
+       struct sk_buff *skb =3D __skb_peek(frames);
+       struct ieee80211_rx_status *status =3D IEEE80211_SKB_RXCB(skb);
+       struct cl_sta *cl_sta;
+       struct cl_vif *cl_vif;
+       struct hw_rxhdr *rxhdr =3D amsdu_rx_state->rxhdr;
+       u32 packet_len =3D amsdu_rx_state->packet_len;
+       struct ieee80211_sta *sta;
+
+       /* START - cl_sta protected block */
+       cl_sta_lock(cl_hw);
+       cl_sta =3D cl_sta_get(cl_hw, amsdu_rx_state->sta_idx);
+
+       if (!cl_sta) {
+               cl_sta_unlock(cl_hw);
+               cl_hw->rx_info.pkt_drop_sta_null +=3D amsdu_rx_state->msdu_=
cnt;
+               __skb_queue_purge(frames);
+               return;
+       }
+
+       sta =3D &cl_sta->stainfo->sta;
+       cl_vif =3D cl_sta->cl_vif;
+       skb->dev =3D cl_vif->dev;
+
+       cl_rx_data_check(cl_hw, skb, cl_sta, packet_len, rxhdr);
+       cl_stats_update_rx_rate(cl_hw, cl_sta, rxhdr);
+
+       if (!rxhdr->aggregation || (rxhdr->aggregation && rxhdr->mpdu_cnt =
=3D=3D 0))
+               cl_rssi_rx_handler(cl_hw, cl_sta, rxhdr, status->signal);
+
+       cl_sta_unlock(cl_hw);
+       /* END - cl_sta protected block */
+
+       if (rx_skb_max &&
+           (atomic_read(&rx_skb_cnt) + amsdu_rx_state->msdu_cnt) >=3D rx_s=
kb_max) {
+               cl_hw->rx_info.pkt_drop_host_limit +=3D amsdu_rx_state->msd=
u_cnt;
+               __skb_queue_purge(frames);
+               return;
+       }
+
+       if (cl_sta->tid_agg_rx[amsdu_rx_state->tid])
+               cl_rx_amsdu_done_reorder(cl_hw, cl_sta, frames);
+       else
+               cl_rx_pass_to_mac(cl_hw, sta, frames);
+}
+
+static void cl_rx_invalid_tailroom(struct cl_hw *cl_hw, struct sk_buff *sk=
b, u32 len)
+{
+       cl_dbg_err(cl_hw, "Invalid RX header length - tailroom=3D%d, len=3D=
%u\n",
+                  skb_tailroom(skb), len);
+       cl_hw->rx_info.pkt_drop_rxhdr_len_error++;
+       kfree_skb(skb);
+}
+
+static void cl_rx_invalid_pattern(struct cl_hw *cl_hw, struct sk_buff *skb=
, u32 pattern)
+{
+       cl_dbg_err(cl_hw, "WRONG PATTERN - 0x%x\n", pattern);
+       cl_hw->rx_info.pkt_drop_wrong_pattern++;
+       kfree_skb(skb);
+}
+
+static int cl_rx_get_sta_idx(struct cl_hw *cl_hw, struct hw_rxhdr *rxhdr)
+{
+       int sta_idx =3D rxhdr->key_sram_index - MM_SEC_DEFAULT_KEY_COUNT;
+
+       if (sta_idx >=3D 0 && sta_idx < CL_MAX_NUM_STA)
+               return sta_idx;
+
+       cl_dbg_err(cl_hw, "invalid sta_idx %d, key_sram_index=3D%d\n",
+                  sta_idx, rxhdr->key_sram_index);
+
+       return -1;
+}
+
+static void cl_rx_handle_first_amsdu(struct cl_hw *cl_hw, struct sk_buff *=
skb,
+                                    struct cl_amsdu_rx_state *amsdu_rx_sta=
te,
+                                    struct hw_rxhdr *rxhdr, u8 sta_idx, u8=
 tid, u8 encrypt_len)
+{
+       /*
+        * First MSDU recived frame:
+        * ------------------------------------------
+        * || WLAN_HDR || MSDU HDR || MSDU PAYLOAD ||
+        * ------------------------------------------
+        */
+       cl_rx_amsdu_stats(cl_hw, rxhdr->msdu_cnt);
+
+       if (rxhdr->corrupted_amsdu) {
+               cl_rx_amsdu_first_corrupted(cl_hw, skb, rxhdr);
+       } else {
+               cl_rx_amsdu_first(cl_hw, skb, rxhdr, sta_idx, tid, encrypt_=
len);
+
+               /* If there are more MSDU's, hold on with the update
+                * to the upper layer until A-MSDU is complete
+                */
+               if (amsdu_rx_state->msdu_remaining_cnt =3D=3D 0)
+                       cl_rx_amsdu_done(cl_hw, amsdu_rx_state);
+       }
+}
+
+static void cl_rx_handle_sub_amsdu(struct cl_hw *cl_hw, struct sk_buff *sk=
b,
+                                  struct cl_amsdu_rx_state *amsdu_rx_state=
)
+{
+       /* Update the remaining MSDU counter */
+       amsdu_rx_state->msdu_remaining_cnt--;
+
+       /* Free MSDU with error */
+       if (amsdu_rx_state->amsdu_error) {
+               cl_rx_amsdu_sub_error(cl_hw, skb);
+               return;
+       }
+
+       /* Add the sub-MSDU to the existing ones */
+       if (!cl_rx_amsdu_sub(cl_hw, skb))
+               return;
+
+       /* This is the last MSDU, A-MSDU is complete, push to upper layer *=
/
+       if (amsdu_rx_state->msdu_remaining_cnt =3D=3D 0)
+               cl_rx_amsdu_done(cl_hw, amsdu_rx_state);
+}
+
+static void cl_rx_handle_ps(struct cl_hw *cl_hw, struct cl_sta *cl_sta, st=
ruct sk_buff *skb)
+{
+       struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)(skb->data);
+       struct ieee80211_sta *sta =3D &cl_sta->stainfo->sta;
+       bool is_ps;
+       __le16 fc =3D hdr->frame_control;
+
+       if (ieee80211_is_pspoll(fc) ||
+           ieee80211_has_morefrags(fc) ||
+           !(ieee80211_is_mgmt(fc) ||
+             ieee80211_is_data(fc)))
+               return;
+
+       is_ps =3D ieee80211_has_pm(hdr->frame_control);
+
+       cl_sta_ps_notify(cl_hw, cl_sta, is_ps);
+       ieee80211_sta_ps_transition(sta, is_ps);
+}
+
+static void cl_rx_handle_skb(struct cl_hw *cl_hw, struct sk_buff *skb)
+{
+       u8 encrypt_len =3D 0;
+       u8 tid =3D 0;
+       u32 mpdu_offset =3D 0;
+       u32 len =3D 0;
+       int sta_idx =3D -1;
+       bool is_amsdu =3D false;
+       bool skb_done =3D false;
+       struct cl_sta *cl_sta =3D NULL;
+       struct ieee80211_sta *sta =3D NULL;
+       struct hw_rxhdr *rxhdr =3D NULL;
+       struct cl_tid_ampdu_rx *tid_agg_rx =3D NULL;
+       struct cl_amsdu_rx_state *amsdu_rx_state =3D &cl_hw->amsdu_rx_state=
;
+       s8 remote_cpu_mac =3D cl_hw->conf->ci_rx_remote_cpu_mac;
+
+       if (amsdu_rx_state->msdu_remaining_cnt > 0) {
+               cl_rx_handle_sub_amsdu(cl_hw, skb, amsdu_rx_state);
+               return;
+       }
+
+       rxhdr =3D (struct hw_rxhdr *)skb->data;
+       mpdu_offset =3D sizeof(struct hw_rxhdr);
+
+       if (rxhdr->rx_padding_done)
+               mpdu_offset +=3D CL_PADDING_IN_BYTES;
+
+       /* Pull the HW RX header */
+       skb_reserve(skb, mpdu_offset);
+
+       /*
+        * Sanity check - the embedded layer is responsible to validate the=
 pattern correctness.
+        * If pattern is invalid then it is likely that the embedded layer =
did some thing wrong.
+        */
+       if (rxhdr->pattern !=3D IPC_RX_DMA_OVER_PATTERN) {
+               cl_rx_invalid_pattern(cl_hw, skb, rxhdr->pattern);
+               return;
+       }
+
+       if (cl_rx_check_err(cl_hw, skb, rxhdr))
+               return;
+
+       /* Convert gi from firmware format to driver format */
+       rxhdr->gi_type =3D convert_gi_format_fw_to_wrs(rxhdr->format_mod, r=
xhdr->gi_type);
+
+       /*
+        * For TCV1 fill in the rxhdr rssi "holes" so that values will star=
t from rssi1.
+        * The implementation below takes into account elastic mimo, and ma=
ximum number
+        * of antennas for TCV1.
+        */
+       if (cl_hw_is_tcv1(cl_hw)) {
+               if (cl_chip_is_6ant(cl_hw->chip)) {
+                       rxhdr->rssi1 =3D rxhdr->rssi2;
+                       rxhdr->rssi2 =3D rxhdr->rssi3;
+                       rxhdr->rssi3 =3D rxhdr->rssi4;
+                       rxhdr->rssi4 =3D rxhdr->rssi5;
+                       rxhdr->rssi5 =3D rxhdr->rssi6;
+               } else if (cl_chip_is_4ant(cl_hw->chip)) {
+                       rxhdr->rssi1 =3D rxhdr->rssi3;
+                       rxhdr->rssi2 =3D rxhdr->rssi4;
+                       rxhdr->rssi3 =3D rxhdr->rssi5;
+                       rxhdr->rssi4 =3D rxhdr->rssi6;
+               }
+       }
+
+       if (rxhdr->key_sram_v)
+               sta_idx =3D cl_rx_get_sta_idx(cl_hw, rxhdr);
+
+       cl_sta_lock(cl_hw);
+
+       if (sta_idx !=3D -1) {
+               cl_sta =3D cl_sta_get(cl_hw, sta_idx);
+
+               if (cl_sta) {
+                       sta =3D &cl_sta->stainfo->sta;
+
+                       if (cl_hw->conf->ci_fast_rx_en) {
+                               tid =3D ieee80211_get_tid((struct ieee80211=
_hdr *)skb->data);
+                               tid_agg_rx =3D cl_sta->tid_agg_rx[tid];
+                               cl_rx_handle_ps(cl_hw, cl_sta, skb);
+                       }
+
+                       /* Store the pointer to sta in the skb->sk field */
+                       if (remote_cpu_mac !=3D -1)
+                               skb->sk =3D (struct sock *)sta;
+               }
+       }
+
+       if (unlikely(cl_rx_fill_status(cl_hw, cl_sta, skb, rxhdr, &encrypt_=
len))) {
+               cl_sta_unlock(cl_hw);
+               kfree_skb(skb);
+               return;
+       }
+
+       /*
+        * RXM sets rxhdr->msdu_cnt=3D1 also for non AMSDU, so the correct =
check
+        * is the new amsdu_present bit.
+        */
+       is_amsdu =3D rxhdr->amsdu_present;
+
+       /* Is A-MSDU frame? */
+       if (is_amsdu) {
+               cl_rx_handle_first_amsdu(cl_hw, skb, amsdu_rx_state, rxhdr,=
 sta_idx,
+                                        tid, encrypt_len);
+               cl_sta_unlock(cl_hw);
+               return;
+       }
+
+       len =3D le32_to_cpu(rxhdr->len);
+
+       if (skb_tailroom(skb) >=3D len) {
+               /* Push the WLAN HDR + MDPU payload to the skb data */
+               skb_put(skb, len);
+               cl_hw->rx_info.non_amsdu++;
+       } else {
+               cl_sta_unlock(cl_hw);
+               cl_rx_invalid_tailroom(cl_hw, skb, len);
+               return;
+       }
+
+       skb_done =3D cl_rx_skb_done(cl_hw, skb, cl_sta, rxhdr);
+
+       cl_sta_unlock(cl_hw);
+
+       if (!skb_done)
+               return;
+
+       if (tid_agg_rx) {
+               struct sk_buff_head reorder_buf;
+
+               /* Init the reorder buffer */
+               __skb_queue_head_init(&reorder_buf);
+               cl_rx_reorder_ampdu(cl_hw, cl_sta, skb, &reorder_buf);
+
+               if (!skb_queue_empty(&reorder_buf))
+                       cl_rx_pass_to_mac(cl_hw, sta, &reorder_buf);
+       } else {
+               if (remote_cpu_mac =3D=3D -1) {
+                       ieee80211_rx_napi(cl_hw->hw, sta, skb, NULL);
+               } else {
+                       skb_queue_tail(&cl_hw->rx_remote_queue_mac, skb);
+                       cl_rx_remote_cpu_mac(cl_hw);
+               }
+       }
+}
+
+static void cl_rx_tasklet(unsigned long data)
+{
+       struct cl_hw *cl_hw =3D (struct cl_hw *)data;
+       struct sk_buff *skb =3D NULL;
+       u16 pkt_cnt =3D 0;
+
+       if (cl_recovery_in_progress(cl_hw))
+               return;
+
+#ifdef TRACE_SUPPORT
+       trace_cl_trace_rx_tasklet_start(cl_hw->idx);
+#endif
+
+       while ((skb =3D skb_dequeue(&cl_hw->rx_skb_queue))) {
+               cl_rx_handle_skb(cl_hw, skb);
+
+               if (++pkt_cnt > cl_hw->conf->ce_rx_pkts_budget) {
+                       if (cl_hw->chip->conf->ci_rx_resched_tasklet)
+                               tasklet_schedule(&cl_hw->rx_resched_tasklet=
);
+                       else
+                               tasklet_schedule(&cl_hw->rx_tasklet);
+
+                       cl_hw->rx_info.exceed_pkt_budget++;
+                       return;
+               }
+       }
+
+#ifdef TRACE_SUPPORT
+       trace_cl_trace_rx_tasklet_end(cl_hw->idx, pkt_cnt);
+#endif
+}
+
+static void cl_rx_resched_tasklet(unsigned long data)
+{
+       struct cl_hw *cl_hw =3D (struct cl_hw *)data;
+
+       tasklet_schedule(&cl_hw->rx_tasklet);
+}
+
+static void cl_rx_remote_tasklet_mac(unsigned long data)
+{
+       struct cl_hw *cl_hw =3D (struct cl_hw *)data;
+       struct sk_buff *skb =3D NULL;
+       struct ieee80211_sta *sta;
+
+       if (cl_recovery_in_progress(cl_hw))
+               return;
+
+       cl_rx_remote_cpu_info(cl_hw);
+
+       while ((skb =3D skb_dequeue(&cl_hw->rx_remote_queue_mac))) {
+               /*
+                * Get sta pointer from skb->sk (stored their in cl_rx_remo=
te_cpu_mac)
+                * and reset skb->sk.
+                */
+               sta =3D (struct ieee80211_sta *)skb->sk;
+               skb->sk =3D NULL;
+
+               ieee80211_rx_napi(cl_hw->hw, sta, skb, NULL);
+       }
+}
+
+void cl_rx_init(struct cl_hw *cl_hw)
+{
+       s8 cpu_mac =3D cl_hw->conf->ci_rx_remote_cpu_mac;
+
+       /* Set rx_skb_max to be the maximum of ci_rx_skb_max configured for=
 each chip */
+       rx_skb_max =3D max(cl_hw->chip->conf->ci_rx_skb_max, rx_skb_max);
+
+       skb_queue_head_init(&cl_hw->rx_remote_queue_mac);
+       skb_queue_head_init(&cl_hw->rx_skb_queue);
+       __skb_queue_head_init(&cl_hw->amsdu_rx_state.frames);
+
+       tasklet_init(&cl_hw->rx_tasklet, cl_rx_tasklet, (unsigned long)cl_h=
w);
+       tasklet_init(&cl_hw->rx_resched_tasklet, cl_rx_resched_tasklet, (un=
signed long)cl_hw);
+
+       if (cpu_mac >=3D 0)
+               tasklet_init(&per_cpu(rx_remote_tasklet_mac[cl_hw->idx], cp=
u_mac),
+                            cl_rx_remote_tasklet_mac,
+                            (unsigned long)cl_hw);
+#ifdef CONFIG_CL_PCIE
+       cl_rx_pci_init(cl_hw);
+#endif
+}
+
+void cl_rx_off(struct cl_hw *cl_hw)
+{
+       s8 cpu_mac =3D cl_hw->conf->ci_rx_remote_cpu_mac;
+
+       if (cpu_mac >=3D 0)
+               tasklet_kill(&per_cpu(rx_remote_tasklet_mac[cl_hw->idx], cp=
u_mac));
+
+       tasklet_kill(&cl_hw->rx_tasklet);
+       tasklet_kill(&cl_hw->rx_resched_tasklet);
+
+       skb_queue_purge(&cl_hw->rx_remote_queue_mac);
+       skb_queue_purge(&cl_hw->rx_skb_queue);
+
+       cl_rx_amsdu_reset(cl_hw);
+#ifdef CONFIG_CL_PCIE
+       cl_rx_pci_deinit(cl_hw);
+#endif
+}
+
+void cl_rx_remote_tasklet_sched(void *t)
+{
+       tasklet_schedule((struct tasklet_struct *)t);
+}
+
+void cl_rx_remote_cpu_info(struct cl_hw *cl_hw)
+{
+       u32 processor_id =3D smp_processor_id();
+
+       if (processor_id < CPU_MAX_NUM)
+               cl_hw->rx_info.remote_cpu[processor_id]++;
+}
+
+void cl_rx_push_queue(struct cl_hw *cl_hw, struct sk_buff *skb)
+{
+       skb_queue_tail(&cl_hw->rx_skb_queue, skb);
+       tasklet_schedule(&cl_hw->rx_tasklet);
+}
+
+void cl_rx_skb_alloc_handler(struct sk_buff *skb)
+{
+       skb->destructor =3D cl_rx_skb_destructor;
+       atomic_inc(&rx_skb_cnt);
+}
+
+void cl_rx_post_recovery(struct cl_hw *cl_hw)
+{
+       if (!skb_queue_empty(&cl_hw->rx_skb_queue))
+               tasklet_schedule(&cl_hw->rx_tasklet);
+
+       if (!skb_queue_empty(&cl_hw->rx_remote_queue_mac))
+               tasklet_schedule(&per_cpu(rx_remote_tasklet_mac[cl_hw->idx]=
,
+                                         cl_hw->conf->ci_rx_remote_cpu_mac=
));
+}
+
+void cl_rx_info_reset(struct cl_hw *cl_hw)
+{
+       pr_debug("Reset uplink stats\n");
+       memset(&cl_hw->rx_info, 0, sizeof(struct cl_rx_path_info));
+}
+
+int cl_rx_info_print(struct cl_hw *cl_hw)
+{
+       struct cl_rx_path_info *rx_info =3D &cl_hw->rx_info;
+       struct ieee80211_local *local =3D hw_to_local(cl_hw->hw);
+       int i;
+       bool uplink_amsdu =3D false;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       for (i =3D 0; i < RX_MAX_MSDU_IN_AMSDU; i++)
+               if (rx_info->amsdu_cnt[i] > 0) {
+                       uplink_amsdu =3D true;
+                       break;
+               }
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Uplink counters\n"
+                   "-----------------------------------\n");
+       cl_snprintf(&buf, &len, &buf_size,
+                   "rx_desc[RXM]                 =3D %u\n",
+                   rx_info->rx_desc[CL_RX_BUF_RXM]);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "rx_desc[FW]                  =3D %u\n",
+                   rx_info->rx_desc[CL_RX_BUF_FW]);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "elem_alloc_fail              =3D %u\n",
+                   rx_info->elem_alloc_fail);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "skb_null                     =3D %u\n",
+                   rx_info->skb_null);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "pkt_drop_amsdu_corrupted     =3D %u\n",
+                   rx_info->pkt_drop_amsdu_corrupted);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "pkt_drop_sub_amsdu_corrupted =3D %u\n",
+                   rx_info->pkt_drop_sub_amsdu_corrupted);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "pkt_drop_amsdu_len_error     =3D %u\n",
+                   rx_info->pkt_drop_amsdu_len_error);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "pkt_drop_sub_amsdu_len_error =3D %u\n",
+                   rx_info->pkt_drop_sub_amsdu_len_error);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "pkt_drop_wrong_pattern       =3D %u\n",
+                   rx_info->pkt_drop_wrong_pattern);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "pkt_drop_not_success         =3D %u\n",
+                   rx_info->pkt_drop_not_success);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "pkt_drop_unencrypted         =3D %u\n",
+                   rx_info->pkt_drop_unencrypted);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "pkt_drop_decrypt_fail        =3D %u\n",
+                   rx_info->pkt_drop_decrypt_fail);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "pkt_drop_rxhdr_len_error     =3D %u\n",
+                   rx_info->pkt_drop_rxhdr_len_error);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "pkt_drop_sta_null            =3D %u\n",
+                   rx_info->pkt_drop_sta_null);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "pkt_drop_host_limit          =3D %u\n",
+                   rx_info->pkt_drop_host_limit);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "netif_rx                     =3D %u\n",
+                   rx_info->netif_rx);
+
+       len +=3D snprintf(buf + len, PAGE_SIZE - len,
+                       "\nQueue length\n"
+                       "-----------------------------------\n");
+       len +=3D snprintf(buf + len, PAGE_SIZE - len,
+                       "rx_skb_queue                 =3D %u\n",
+                       skb_queue_len(&cl_hw->rx_skb_queue));
+       len +=3D snprintf(buf + len, PAGE_SIZE - len,
+                       "rx_remote_queue_mac          =3D %u\n",
+                       skb_queue_len(&cl_hw->rx_remote_queue_mac));
+       len +=3D snprintf(buf + len, PAGE_SIZE - len,
+                       "local_skb_queue              =3D %u\n",
+                       skb_queue_len(&local->skb_queue));
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "\nSKB count\n"
+                   "-----------------------------------\n");
+       cl_snprintf(&buf, &len, &buf_size,
+                   "rx_skb_max                   =3D %u\n",
+                   rx_skb_max);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "rx_skb_cnt                   =3D %u\n",
+                   atomic_read(&rx_skb_cnt));
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "\nBuffer processing\n"
+                   "-----------------------------------\n");
+       cl_snprintf(&buf, &len, &buf_size,
+                   "IRQ                          =3D %u\n",
+                   rx_info->buffer_process_irq);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Tasklet                      =3D %u\n",
+                   rx_info->buffer_process_tasklet);
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "\nUplink Non AMSDU\n"
+                   "-----------------------------------\n"
+                   "NON AMSDU =3D %u\n", rx_info->non_amsdu);
+
+       if (uplink_amsdu) {
+               cl_snprintf(&buf, &len, &buf_size,
+                           "\nUplink AMSDU\n"
+                           "-----------------------------------\n");
+
+               for (i =3D 0; i < RX_MAX_MSDU_IN_AMSDU; i++)
+                       if (rx_info->amsdu_cnt[i] > 0)
+                               cl_snprintf(&buf, &len, &buf_size,
+                                           "AMSDU[%d] =3D %u\n", i + 1, rx=
_info->amsdu_cnt[i]);
+       }
+
+       if (cl_hw->conf->ci_rx_remote_cpu_drv !=3D -1 ||
+           cl_hw->conf->ci_rx_remote_cpu_mac !=3D -1) {
+               cl_snprintf(&buf, &len, &buf_size,
+                           "\nRemote CPU\n"
+                           "-----------------------------------\n");
+
+               for (i =3D 0; i < CPU_MAX_NUM; i++) {
+                       if (rx_info->remote_cpu[i] =3D=3D 0)
+                               continue;
+
+                       cl_snprintf(&buf, &len, &buf_size, "cpu #%u: %u\n",
+                                   i, rx_info->remote_cpu[i]);
+               }
+       }
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "\nUplink schedule\n"
+                   "-----------------------------------\n"
+                   "exceed_pkt_budget =3D %u\n",
+                   rx_info->exceed_pkt_budget);
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "\nUplink buckets RXM\n"
+                   "-----------------------------------\n");
+
+       for (i =3D 0; i < IPC_RXBUF_NUM_BUCKETS_RXM; i++) {
+               if (rx_info->pkt_handle_bucket_rxm[i] =3D=3D 0)
+                       continue;
+
+               cl_snprintf(&buf, &len, &buf_size,
+                           "Bucket [%lu -> %lu]: %u\n",
+                           i * IPC_RXBUF_BUCKET_SIZE,
+                           (i + 1) * IPC_RXBUF_BUCKET_SIZE - 1,
+                           rx_info->pkt_handle_bucket_rxm[i]);
+       }
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "\nUplink buckets FW\n"
+                   "-----------------------------------\n");
+
+       for (i =3D 0; i < IPC_RXBUF_NUM_BUCKETS_FW; i++) {
+               if (rx_info->pkt_handle_bucket_fw[i] =3D=3D 0)
+                       continue;
+
+               cl_snprintf(&buf, &len, &buf_size,
+                           "Bucket [%lu -> %lu]: %u\n",
+                           i * IPC_RXBUF_BUCKET_SIZE,
+                           (i + 1) * IPC_RXBUF_BUCKET_SIZE - 1,
+                           rx_info->pkt_handle_bucket_fw[i]);
+       }
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+void cl_rx_netif(struct cl_hw *cl_hw, struct cl_vif *cl_vif, struct sk_buf=
f *skb)
+{
+#ifdef TRACE_SUPPORT
+       trace_cl_trace_netif_rx_start(cl_hw->idx);
+#endif
+
+       cl_hw->rx_info.netif_rx++;
+
+       netif_receive_skb(skb);
+
+#ifdef TRACE_SUPPORT
+       trace_cl_trace_netif_rx_end(cl_hw->idx);
+#endif
+}
+
+void cl_rx_finish(struct cl_hw *cl_hw, struct sk_buff *skb)
+{
+       struct cl_vif *cl_vif =3D NETDEV_TO_CL_VIF(skb->dev);
+
+       cl_rx_netif(cl_hw, cl_vif, skb);
+}
+
+u8 cl_rx_get_skb_ac(struct ieee80211_hdr *hdr)
+{
+       if (ieee80211_is_data_qos(hdr->frame_control)) {
+               u8 *qos_ctl =3D ieee80211_get_qos_ctl(hdr);
+               u8 tid =3D *qos_ctl & IEEE80211_QOS_CTL_TAG1D_MASK;
+               return tid_to_ac[tid];
+       }
+
+       return AC_BE;
+}
+
+bool cl_rx_process_in_irq(struct cl_hw *cl_hw)
+{
+       struct cl_ipc_ring_indices *indices =3D cl_hw->ipc_env->ring_indice=
s_elem->indices;
+       u32 read_idx =3D le32_to_cpu(indices->rxdesc_read_idx[CL_RX_BUF_RXM=
]);
+       u32 write_idx =3D le32_to_cpu(indices->rxdesc_write_idx[CL_RX_BUF_R=
XM]);
+       u32 free_buffers =3D read_idx - write_idx;
+
+       if (free_buffers < (IPC_RXBUF_CNT_RXM / 2)) {
+               cl_hw->rx_info.buffer_process_irq++;
+               return true;
+       }
+
+       cl_hw->rx_info.buffer_process_tasklet++;
+       return false;
+}
+
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

