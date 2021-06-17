Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467FA3AB8D1
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFQQKy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:54 -0400
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:26086
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233825AbhFQQJw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdoZBs2T2RZ6OgpTB/UR+cIB6QRT3l98Yy9Kon3nB3A2PLzeRdGtTKLb4w76YvGpnZ2z/JZPPJkj6As0Rb6HwkRxbfedLcyAl0PF67jgAToLAls4T2R/kSHdNegDYolHA7nON7H1nw4/fKhbAc/K/Fz6gvQvZjKzBUSE2cIrfVJ9AIBwYJiquR0h/q2tuZevRQwwJDznXOC9qR6iBJOq7kJIsB1T0+6OGvP4i9gI0xJROOrrLE2chghxb3CfeTXp4jF8Z0WHh5gFW+2tFGhN1QwUi9W7xxOPCv9YOZkO4FXdZEGKpVV7C08XGxMUSFVMy87ceQrCmqPvob/EtPnCyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytjRZzelfhv2J/aregWW4yKvd5+G/N203pf/9zA65GU=;
 b=UNbGnOndrpkFcanSFxPvwGsuJk+75otnH5qAG2SrFClC/FfwS2LD7i3/CvBmyroMnHPVCq2ygvKLsL8amKREwMmVkHck16a7iaZWGMYxtJmwFQJuwLOL8AwcTVNQmhokD4ZWnnjKsyJk0HoNjRNvwR/PgY15qOP7XpjmiM7wpdZ67vv72j81C3tOXzbB4oocqmAoA09Y+UA9vjUgXbrylcBNkdcJlhG31IznDrfVGzsLSkmzz5dQAp5iHCpcY5oQDLupU+jRo2qfh0H/wxcFSGHkDYWBDG7d+iOuoE9a+wTse1+uTCl9n/MFlOqntB/Z62npe1RDkslN0BMGRTGGgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytjRZzelfhv2J/aregWW4yKvd5+G/N203pf/9zA65GU=;
 b=fy+4ZPLZGNnNjkCjXIz76zm+p8wGbOSJMALA9DTmrW/sXSw7HqlBViXc7wMcYruMkT/CLl3gkAOOn1r/d3IsYudzkK1JT+Vbdasa4IC9jnJ01zBJYoaY/czw4UNZdxFffjlBQbgd9RdpbrzvPtrUuMDFIaOCYuxcSRAAMSSF8xY=
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
Subject: [RFC v1 174/256] cl8k: add rx/rx_amsdu.c
Date:   Thu, 17 Jun 2021 16:01:01 +0000
Message-Id: <20210617160223.160998-175-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c9f6085-69d5-4e20-92f1-08d931a9c3ad
X-MS-TrafficTypeDiagnostic: AM0P192MB0260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB02603D513C61448AC942089EF60E9@AM0P192MB0260.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EOZVqqJmeKgo7oMgBduyH5MQreyDe7DPBz6f98GBz8LsA5e/YJabPREkllSeOalAvrCMxXaEPuOwyal7aKbfkROOQYrB4gfUh/vzutK0AIzlQ9cdA5zOst0WuQdvNkAgKpfDE+JwtYeXx/KHB/CYL7meiZGz7XivKqcD0qR2H2tl7zt/ALHlZv/XNp5HncpoGelWUdJKGADOicabV/9EUrBbLtdXoVF7OHwhTQUW754BQqkU8exBbXIV7vISVrCoKWXKEGsHApMgm8Cp50UfIBxRNvLDVPjheXgNvDGRDEXbrRxiTHkRKnQGCU3JSPw+8hllekvcum+lugGgu7bTCU17Pt2ls546QDndc1GXUUS0PlDIAfkWW2KlZu3YD1FZh2oGMlJ/2H9U3V0vJtjbINvz1Fo2iUEyCPPkoRY606PzNCZ/tC6xIBpGtqaW9lbJnQuRGsQCdjoiGM3RcPRO/8KvzU2sh/JQI3r7ZLYB/+ANdju4vOecDKq7IMM8RnE/qXh/kpFiEd9Ms/I8xeoL0W06Vlt+1w5rnfL+ik5S5qPVCYYfwWpgo5czbuqV2HZ5fobYs+mi/cAWNIHnAIEglnHOBOEWdOiq4UN+darbmwkIdQt6IVXtOAdLkwwfwr17GRweauvgpSue+DR0c9RTaOEaWFoXnA4PZFvFtKE/iCO/Ojl3jth6+m/T8x6XcdbgB+zacOMxuGnVYLxylcuGYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(39850400004)(396003)(508600001)(8936002)(86362001)(107886003)(4326008)(316002)(26005)(8676002)(956004)(186003)(6666004)(2906002)(6512007)(66556008)(2616005)(5660300002)(38350700002)(54906003)(38100700002)(16526019)(66946007)(9686003)(83380400001)(55236004)(52116002)(66476007)(6486002)(6916009)(6506007)(36756003)(1076003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3p70nzQTUF6Ulo9lgR7DZ5t0FrAi5hJK7gsxHcAyqY5+FnDeK4fTQRaDHhhQ?=
 =?us-ascii?Q?mUuSpBBmqgg6uroxGAoOEN0E0pnfv0f9H5i0U+txjvFsRjlWgkCqREXak7ma?=
 =?us-ascii?Q?S+eHSumMGWiZG0SIrFRnvbOELYfZ08Mv9win8Ig2/QNr/GrkTXDD4XWL0Bg3?=
 =?us-ascii?Q?iP2omeoIfg+naMyLBuFRgOPHjxvtqM5brpW523Vugu31ZrRUc+PPxXcamo6i?=
 =?us-ascii?Q?traLTSE1tU1TIM7pXQTd3+2eFDFLXDXx6A7d46wzW2c/6a5uHNpWQdyb1zGq?=
 =?us-ascii?Q?XYYUlPPGcYvst+2a+q6NliIiH22wGqWDFZ0bHrf9B2LSzk8RlmbwaBOIvus6?=
 =?us-ascii?Q?qb997RGJkazGDe2GytTj971sYsMTNLScsqFTYf4jEgI3K/7cNmoFNL+j0nyf?=
 =?us-ascii?Q?Qv52mg3KLJ1z/dPVhAd63oRuFfDCL6taMyev/KV7h1u+5bSVgPJgljD7fgTd?=
 =?us-ascii?Q?TgkQXvXzKF+rbbsxaTdJRDnq8KTXORWfMnVFwSWTmtPBATafI10cJ+kH9PcK?=
 =?us-ascii?Q?I7JvbQD5k2gtJXII6tlSsM381eJldSmEWxpsWFQZ1+vDmrBY0Q5SuFvUas+G?=
 =?us-ascii?Q?Ays+yUmdBfBgL7kzhyxVnAentraJp9ecBVKRFS6A5iKBjxUZNpe+NZsTd2U6?=
 =?us-ascii?Q?8MCk0gPR55ZGPtTnJE+KtFDkBWBfzVmz2muT040FX4enlcSe1Szv3OriHEas?=
 =?us-ascii?Q?P2N915CcJEVXQcXU1VMMhwBFzMpFIqQVAK6xx++GGPc42iNVG5+p2vaWmVSt?=
 =?us-ascii?Q?XFikD2MsqMhWtay0n1ieYQwq/qpJcX+vkQpgBK/aTTca7XRBtsgbdP8aoLLV?=
 =?us-ascii?Q?slRqVormmQqNBzctPc1DqL9mPfamloN7YbIL7a4koSSPBi7BCSKeTajwwhCJ?=
 =?us-ascii?Q?pCPfNwhAv7WodZ/pvVCZtRC+RuiTkOZBiQNKHv2+TZvQloEl4IgewINXg+bO?=
 =?us-ascii?Q?I6n0p5VmlSPmfd5KhOr95NjsHgSyXmAbSS0cA2psVF1h7Jy6pl3yZEyfkWB3?=
 =?us-ascii?Q?4nzPay0qeigEHIbDQ1mEHg2WZTqr6f9b4V3A6IcOiJDHqDxNXWPTRNnCdmT8?=
 =?us-ascii?Q?yjaCuebj+tp8q1+y/SqzlviVXFpoGI0KaZuKBurt47NsXe6vCrDHejp48OjS?=
 =?us-ascii?Q?z1jIwbXtLk2n23nlyBWactq0mw1qiR6ayUfbc7AHlFApRlrXyQvKBcecD2LX?=
 =?us-ascii?Q?BBEtOELkeLPXK7lUpkS3Ld7nIH6AhlcJagm3mYk5geEmfZhJV6KGuHyAMhH+?=
 =?us-ascii?Q?mTlshqcJPN45pDoB0WB9cYsM2yrE8UCluuV+UvfUPpbzpXnuxijS5cBDxrmH?=
 =?us-ascii?Q?/leacb+vct7t2d0tp5Qpvn1M?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9f6085-69d5-4e20-92f1-08d931a9c3ad
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:45.7178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/IhqbOk/2kIN8rU1etbE4adMliwIsVLbNaNS0Nq/WV9Iv6j8mddysJV+TvMxBteNq7+N/TCY9hgfdWzkgE2Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0260
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/rx/rx_amsdu.c    | 257 ++++++++++++++++++
 1 file changed, 257 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/rx/rx_amsdu.c

diff --git a/drivers/net/wireless/celeno/cl8k/rx/rx_amsdu.c b/drivers/net/w=
ireless/celeno/cl8k/rx/rx_amsdu.c
new file mode 100644
index 000000000000..512a317227a1
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/rx/rx_amsdu.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "rx/rx_amsdu.h"
+
+struct msduhdr {
+       u8 dest[ETH_ALEN];
+       u8 source[ETH_ALEN];
+       __be16 len;
+} __packed;
+
+enum rx_amsdu_error {
+       RX_AMSDU_ERR_CORRUPTED =3D 0x1,
+       RX_AMSDU_ERR_LENGTH =3D 0x2,
+};
+
+static void set_flag_amsdu_more(struct sk_buff *skb)
+{
+       struct ieee80211_rx_status *rx_status =3D IEEE80211_SKB_RXCB(skb);
+
+       rx_status->flag |=3D RX_FLAG_AMSDU_MORE;
+}
+
+static void clear_flag_amsdu_more(struct sk_buff *skb)
+{
+       struct ieee80211_rx_status *rx_status =3D IEEE80211_SKB_RXCB(skb);
+
+       rx_status->flag &=3D ~RX_FLAG_AMSDU_MORE;
+}
+
+static void add_80211_hdr(struct cl_amsdu_rx_state *amsdu_rx_state,
+                         struct sk_buff *skb, struct sk_buff *first_skb)
+{
+       /* Copy the 802.11 header of the first skb */
+       struct ieee80211_hdr *hdr_first =3D (struct ieee80211_hdr *)(first_=
skb->data);
+       u32 hdrlen_first =3D ieee80211_hdrlen(hdr_first->frame_control);
+       u32 total_bytes =3D hdrlen_first + amsdu_rx_state->encrypt_len;
+
+       /* Total_bytes must be smaller than IPC_RXBUF_EXTRA_HEADROOM */
+       skb_push(skb, total_bytes);
+       memcpy(skb->data, first_skb->data, total_bytes);
+}
+
+static void copy_status(struct cl_amsdu_rx_state *amsdu_rx_state,
+                       struct sk_buff *skb, struct sk_buff *first_skb)
+{
+       struct ieee80211_rx_status *rx_status =3D IEEE80211_SKB_RXCB(skb);
+       struct ieee80211_rx_status *rx_status_first =3D IEEE80211_SKB_RXCB(=
first_skb);
+
+       /* Copy rx_status from the first skb */
+       memcpy(rx_status, rx_status_first, sizeof(struct ieee80211_rx_statu=
s));
+
+       /* If it is the last sub-frame clear RX_FLAG_AMSDU_MORE */
+       if (amsdu_rx_state->msdu_remaining_cnt =3D=3D 0)
+               rx_status->flag &=3D ~RX_FLAG_AMSDU_MORE;
+}
+
+static void cl_rx_amsdu_set_state(struct cl_hw *cl_hw, struct sk_buff *skb=
, struct hw_rxhdr *rxhdr,
+                                 u8 sta_idx, u8 tid, u32 packet_len, u8 en=
crypt_len)
+{
+       struct cl_amsdu_rx_state *amsdu_rx_state =3D &cl_hw->amsdu_rx_state=
;
+
+       amsdu_rx_state->msdu_cnt =3D rxhdr->msdu_cnt;
+       amsdu_rx_state->msdu_remaining_cnt =3D rxhdr->msdu_cnt - 1;
+       amsdu_rx_state->msdu_dma_align =3D rxhdr->msdu_dma_align;
+       amsdu_rx_state->amsdu_error =3D 0;
+       amsdu_rx_state->encrypt_len =3D encrypt_len;
+       amsdu_rx_state->packet_len =3D packet_len;
+       amsdu_rx_state->rxhdr =3D rxhdr;
+       amsdu_rx_state->first_skb =3D skb;
+       amsdu_rx_state->sta_idx =3D sta_idx;
+       amsdu_rx_state->tid =3D tid;
+
+       __skb_queue_head(&cl_hw->amsdu_rx_state.frames, skb);
+}
+
+static void cl_rx_amsdu_set_state_error(struct cl_hw *cl_hw,
+                                       struct hw_rxhdr *rxhdr,
+                                       enum rx_amsdu_error err)
+{
+       struct cl_amsdu_rx_state *amsdu_rx_state =3D &cl_hw->amsdu_rx_state=
;
+
+       amsdu_rx_state->msdu_cnt =3D rxhdr->msdu_cnt;
+       amsdu_rx_state->msdu_remaining_cnt =3D rxhdr->msdu_cnt - 1;
+       amsdu_rx_state->amsdu_error =3D err;
+}
+
+static void cl_rx_amsdu_first_length_error(struct cl_hw *cl_hw, struct sk_=
buff *skb,
+                                          struct hw_rxhdr *rxhdr, u32 len)
+{
+       cl_dbg_err(cl_hw, "RX-AMSDU length error (1/%u) - tailroom=3D%d, le=
n=3D%u\n",
+                  rxhdr->msdu_cnt, skb_tailroom(skb), len);
+
+       cl_rx_amsdu_set_state_error(cl_hw, rxhdr, RX_AMSDU_ERR_LENGTH);
+
+       cl_hw->rx_info.pkt_drop_amsdu_len_error++;
+       kfree_skb(skb);
+}
+
+static void cl_rx_amsdu_sub_length_error(struct cl_hw *cl_hw, struct sk_bu=
ff *skb, u32 len)
+{
+       struct cl_amsdu_rx_state *amsdu_rx_state =3D &cl_hw->amsdu_rx_state=
;
+       struct sk_buff *skb_tail;
+       u8 sub_cnt =3D amsdu_rx_state->msdu_cnt - amsdu_rx_state->msdu_rema=
ining_cnt;
+
+       cl_dbg_err(cl_hw, "RX-AMSDU length error (%u/%u) - tailroom=3D%d, l=
en=3D%u\n",
+                  sub_cnt, amsdu_rx_state->msdu_cnt, skb_tailroom(skb), le=
n);
+
+       /* All remaining skbs in the AMSDU will be treated as errors */
+       amsdu_rx_state->amsdu_error =3D RX_AMSDU_ERR_LENGTH;
+
+       /* Clear RX_FLAG_AMSDU_MORE in the last success skb that was receiv=
ed */
+       skb_tail =3D skb_peek_tail(&amsdu_rx_state->frames);
+       clear_flag_amsdu_more(skb_tail);
+
+       cl_hw->rx_info.pkt_drop_sub_amsdu_len_error++;
+       kfree_skb(skb);
+}
+
+void cl_rx_amsdu_first(struct cl_hw *cl_hw, struct sk_buff *skb,
+                      struct hw_rxhdr *rxhdr, u8 sta_idx, u8 tid, u8 encry=
pt_len)
+{
+       struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)(skb->data);
+       u32 hdr_len =3D ieee80211_hdrlen(hdr->frame_control);
+       struct msduhdr *msdu_hdr =3D (struct msduhdr *)(skb->data + hdr_len=
 + encrypt_len);
+       u32 packet_len =3D hdr_len + encrypt_len + sizeof(struct msduhdr) +=
 ntohs(msdu_hdr->len);
+
+       if (skb_tailroom(skb) < packet_len) {
+               cl_rx_amsdu_first_length_error(cl_hw, skb, rxhdr, packet_le=
n);
+               return;
+       }
+
+       /* Put the WLAN header + MSDU header + payload in the skb data */
+       skb_put(skb, packet_len);
+
+       cl_rx_amsdu_set_state(cl_hw, skb, rxhdr, sta_idx, tid, packet_len, =
encrypt_len);
+
+       /* Must be called after cl_rx_amsdu_set_state() */
+       if (cl_hw->amsdu_rx_state.msdu_remaining_cnt > 0)
+               set_flag_amsdu_more(skb);
+}
+
+bool cl_rx_amsdu_sub(struct cl_hw *cl_hw, struct sk_buff *skb)
+{
+       /*
+        * ----------------------------------------------------------
+        * | DMA padding 4 byte alignment | MSDU HDR | MSDU PAYLOAD |
+        *  ---------------------------------------------------------
+        */
+       struct cl_amsdu_rx_state *amsdu_rx_state =3D &cl_hw->amsdu_rx_state=
;
+       struct sk_buff *first_skb =3D amsdu_rx_state->first_skb;
+       struct msduhdr *msdu_hdr;
+       u32 packet_len;
+
+       /*
+        * Push the dma alignment to the reserved area, so that skb->data w=
ill
+        * point to the MSDU header
+        */
+       skb_reserve(skb, amsdu_rx_state->msdu_dma_align);
+
+       msdu_hdr =3D (struct msduhdr *)(skb->data);
+       packet_len =3D sizeof(struct msduhdr) + ntohs(msdu_hdr->len);
+
+       if (skb_tailroom(skb) < packet_len) {
+               cl_rx_amsdu_sub_length_error(cl_hw, skb, packet_len);
+               return false;
+       }
+
+       /* Put the MSDU HDR + MSDU PAYLOAD into the skb data area */
+       skb_put(skb, packet_len);
+
+       amsdu_rx_state->packet_len +=3D packet_len;
+
+       add_80211_hdr(amsdu_rx_state, skb, first_skb);
+       copy_status(amsdu_rx_state, skb, first_skb);
+
+       /* Store the pointer to sta in the skb->sk field */
+       skb->sk =3D first_skb->sk;
+
+       __skb_queue_tail(&amsdu_rx_state->frames, skb);
+
+       return true;
+}
+
+void cl_rx_amsdu_first_corrupted(struct cl_hw *cl_hw, struct sk_buff *skb,
+                                struct hw_rxhdr *rxhdr)
+{
+       struct ieee80211_hdr *mac_hdr =3D (struct ieee80211_hdr *)(skb->dat=
a);
+
+       cl_dbg_verbose(cl_hw, "Corrupted RX-AMSDU (1/%u), dest_addr=3D%pM\n=
",
+                      rxhdr->msdu_cnt, mac_hdr->addr1);
+
+       cl_rx_amsdu_set_state_error(cl_hw, rxhdr, RX_AMSDU_ERR_CORRUPTED);
+
+       cl_hw->rx_info.pkt_drop_amsdu_corrupted++;
+       kfree_skb(skb);
+}
+
+void cl_rx_amsdu_sub_error(struct cl_hw *cl_hw, struct sk_buff *skb)
+{
+       struct cl_amsdu_rx_state *amsdu_rx_state =3D &cl_hw->amsdu_rx_state=
;
+       u8 sub_cnt =3D amsdu_rx_state->msdu_cnt - amsdu_rx_state->msdu_rema=
ining_cnt;
+
+       if (amsdu_rx_state->amsdu_error & RX_AMSDU_ERR_CORRUPTED) {
+               cl_hw->rx_info.pkt_drop_sub_amsdu_corrupted++;
+
+               cl_dbg_verbose(cl_hw, "Corrupted RX-AMSDU (%u/%u)\n",
+                              sub_cnt, amsdu_rx_state->msdu_cnt);
+       } else if (amsdu_rx_state->amsdu_error & RX_AMSDU_ERR_LENGTH) {
+               cl_hw->rx_info.pkt_drop_sub_amsdu_len_error++;
+
+               cl_dbg_verbose(cl_hw, "RX-AMSDU length error (%u/%u)\n",
+                              sub_cnt, amsdu_rx_state->msdu_cnt);
+       }
+
+       kfree_skb(skb);
+}
+
+void cl_rx_amsdu_reset(struct cl_hw *cl_hw)
+{
+       /* Free pending frames */
+       __skb_queue_purge(&cl_hw->amsdu_rx_state.frames);
+
+       /* Reset RX A-MSDU state */
+       memset(&cl_hw->amsdu_rx_state, 0, sizeof(struct cl_amsdu_rx_state))=
;
+
+       __skb_queue_head_init(&cl_hw->amsdu_rx_state.frames);
+}
+
+void cl_rx_amsdu_stats(struct cl_hw *cl_hw, u8 msdu_cnt)
+{
+       /*
+        * Update A-MSDU statistics
+        * msdu_cnt 1 - 128 is mapped to 0 - 127.
+        */
+       if (msdu_cnt <=3D RX_MAX_MSDU_IN_AMSDU)
+               cl_hw->rx_info.amsdu_cnt[msdu_cnt - 1]++;
+       else
+               cl_dbg_err(cl_hw, "Invalid msdu_cnt [%u]\n", msdu_cnt);
+}
+
+/* Only ieee80211_hw_set() is defined in mac80211.h */
+static inline void _ieee80211_hw_clear(struct ieee80211_hw *hw,
+                                      enum ieee80211_hw_flags flg)
+{
+       return __clear_bit(flg, hw->flags);
+}
+
+#define ieee80211_hw_clear(hw, flg) _ieee80211_hw_clear(hw, IEEE80211_HW_#=
#flg)
+
+void cl_rx_amsdu_hw_en(struct ieee80211_hw *hw, bool rxamsdu_en)
+{
+       if (rxamsdu_en)
+               ieee80211_hw_set(hw, SUPPORTS_AMSDU_IN_AMPDU);
+       else
+               ieee80211_hw_clear(hw, SUPPORTS_AMSDU_IN_AMPDU);
+}
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

