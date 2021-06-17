Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D6D3AB901
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhFQQLv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:51 -0400
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:12246
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233693AbhFQQKi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDa69X/BskKt9ajDvLWOhTgE3p+hfzK9CMTHJoTG2w+m630gqj2tZ93rU52277A+fqxwUqQGYsVxcX6jkpoScWhtgaosMu6I1kNVj+JKCp8QsahRz2tlpC8XNsqyILuNvJ5XabdUXEoJbeU1FTTvdGiKJQcN9/xUj5jXGq9/Y7foOPB0QwcuoAEwHX+cfRPn7UBjI0TBkwlnrMYo8xj9H1TxEkuJ+hjwnexvjta2KllF13xpKaQkG4OJtx+9c0WyQBVdzFFhieHhbP0DBgpsIOvbuX/e2aOME7SZzdwfS9u1X52LbHjI+hs7Sk3QjITDIFwl7HA9zCnFpgZuYKvFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lwdLNRvWM3kAyUq5X1YtLAmnp83t+vlx+y+v53DzZY=;
 b=mqpd48co+3V5/o2c18/Dq19frTKuUBs30K4yc7ShHURrCJJolm2apCinD4/ALu/QO7HWaOve12HNNwS921S7riYhfxovNh/JlilkNDJyRYdnFltkJiLfesNGwegOFc6Ede1DvCC3UnwZB2uKJBJUlpTFdt9dVIv/c+SRL7Ul5sI8WFr/No8S/qzMnD3EUhvVoDD9h6UPAdvdGohmbLog5IbHH77jWCBkOJRnEMONRHaXnZngee4AJmk3tauM0Kwj1AxYeJ1HrDNp6Pw1b3e9cxkHnOU4n0wwjxEN0IIkaAcJ6T80hteyqmO/6Qq1F+d4CkEV2lqbRwY5Qs8LSW8ynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lwdLNRvWM3kAyUq5X1YtLAmnp83t+vlx+y+v53DzZY=;
 b=ewQgG8FM/GpNN3J4LHM5vtYnqBOR26pweVH5kKt3IQofNqVvx9elijx6Q3KIuExpV4tjGeYQaY0OfGgag2Ioa4CdEFsD4Of0TNfS+e1JdFJmM3dvVzgo8TYc/fi2a8ebeuXZQgXFPNPy/DLwfPNheG2XEACaU15XWaX1bSfgwcs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1329.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:07:51 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:51 +0000
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
Subject: [RFC v1 213/256] cl8k: add tx/tx.h
Date:   Thu, 17 Jun 2021 16:01:40 +0000
Message-Id: <20210617160223.160998-214-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd792b73-a0c7-436f-3c73-08d931a9deee
X-MS-TrafficTypeDiagnostic: AM9P192MB1329:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1329E074AD664A1008ACC60DF60E9@AM9P192MB1329.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AqlVzG1Sgd4wAZqiZ44VQk9kWtkAaN9t788feP2MK49IkrszfIkvh2PAIj3u1w6CK93yUyzKr13ctG8Obi+b/5udsd7WOdCqgfiNrT0R0mEaoxZT6N3Wil5D+jiQH8pE80JFmb3nOCdZNoe90Y4Sc3xV7s3E7ZruU5Mwz8oiTFOJgFbcqowE+deAaIgb/RCxTdL+geQ566gBi71lWcsItsVivQ3uGjrvuADzucrPW8zsQ1qQtMeH36sm0UGR7SD4Q5Za5QZXdA70SFtq/ajG7cAPBJo6ipHhARqgWsFhVcNVYvwi/oXGYtNJjc8sM0CZGo6ijCg0Ho+LmDlP/3+1AE2+sXFkxeApOsW0E7jAZowfJ3IubEmWjiDSlLpohJPICPP/Yf2TnY09kpJ5FULJKwft12RtxQf79g+czDbNHf7p5ELGAqrKgf2ldoMtmbssNM+N/ureLr1HMbeVa68IgxEK20A5BOsj9CF5UXCTBM3dZiGPJ/CG9huB1/LgDAWabGNZ5qPM3ekNBdEwwBEDLOSxvw004hPa/m8cdBWXOMZjBH2V0Z6OIKFmlUuuISqbUUkYd2mWzBf0X13MIM/z9s0Hnc2s4HGplnJ2MbluIaBGGA+TQO/0xSdAI5dYJujXVB0otr9ZudPYbWtc1HIaPylx1/Z13O14C6wUwmCC6/xoXs6vP5GnVw/AqO0FkjDwJiRg8sg//ASZy4M2cBx8Ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39850400004)(376002)(136003)(346002)(396003)(86362001)(38350700002)(8936002)(38100700002)(6916009)(52116002)(6486002)(55236004)(54906003)(36756003)(6506007)(956004)(4326008)(186003)(2616005)(1076003)(478600001)(26005)(16526019)(107886003)(6666004)(66556008)(83380400001)(5660300002)(2906002)(6512007)(9686003)(8676002)(316002)(66476007)(66946007)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LQYneKUGoFGpL095ciM5qc8CAxnvQd+rusMhZY8NPyMKKK0Za+rb1OTz8Hho?=
 =?us-ascii?Q?auvc7NapFVd+fzfAUWizbNqz8J/r6TrkXJxbp97KrZO3mJP5y5eSENxx3cgG?=
 =?us-ascii?Q?Myvu7J7lnex+G6gw3tpwZtvTrH4qS8AOpgVPq+5MoaCkP3oUpH0LtpOGjSSY?=
 =?us-ascii?Q?smer4IaT7Z9JH9qVq0ISAvBy+dYRodQL9kCHn0uKTmDdg/N769migBxz/MAB?=
 =?us-ascii?Q?lNxLQBoYE0Ym1JAfoi8ugicUHyX14mFNXCFCoTxMintp/L6igvGRMKGzJKDi?=
 =?us-ascii?Q?1h2AGow7fDuTO/+zleLvi0fNrrdGOk451X/xHDrQxc9qcWplXgzYCNgQQfC5?=
 =?us-ascii?Q?sptTKitSMdeuuPwtqxvuWoncDr9c8SqaXOiQiTgUneE8gf032/HkSreOjxJU?=
 =?us-ascii?Q?RUEdBWWseB0ACmKrlVewRAFNkkfkuuNaomLkqdwtJ954tWOwC3TmuS63Ozrj?=
 =?us-ascii?Q?PHdIhP1+hzfr2rt1Vg/VNyz92QcttXd4XGM7HoxW3xEREEvmgROIe8vNFLsJ?=
 =?us-ascii?Q?aWKFYkg/bA1rwCM5TtOsGvAIIQPE1sj7rRvMw3U6q1HG3HEKuH8TAiUwrlNJ?=
 =?us-ascii?Q?yIOxeBbVAX00+NekhR6fXWfjcfIlMKUAPdHXbsdOG0hy8wHCPQyA5rrsx1DZ?=
 =?us-ascii?Q?PZ+Ja4ZqriD3FviiUytQ3pzPAjDmdDcwtHxS8nULxTqCF7gvo0mqzk71aN3E?=
 =?us-ascii?Q?aPmZ5z4pxjGSxcpaxdUmwFbUL70rSSjV+5QKk6G7dhhmju/p5/qEtAJZkzCV?=
 =?us-ascii?Q?PjL5hxhVTh6omhH8Hay2fBWMkew/Dr9t7YdtkFRv/qRehcutUuCZGjaDB/4h?=
 =?us-ascii?Q?PdLonS8RBdtFhghKv6pdnAsnL4ZVIgXlIamwGNs+1RoBMvYpRDBXZQz39brY?=
 =?us-ascii?Q?2VIQizvmmiQt6tTXdfWD7h6zwfJcTRWqJaApA36V9S9+hFdapJQW2vQSkxu9?=
 =?us-ascii?Q?PSpkOaXEtLQJjxFAbEr6F4Yle/C30KL0sfyasCHVPQolzZBJb2puRKJAqZyq?=
 =?us-ascii?Q?9SsLun9ie8rcw23bAS/vljA3Z/QYKiJ11foFon2gNxWmzKP7JWhOqTICJV+/?=
 =?us-ascii?Q?a53jB0YooLRfsO66kjfYMNxj34AIqSPJkyuMH6Ss58gzgPHlSODTn67Bb3Fh?=
 =?us-ascii?Q?1MLMj76rl17+DcY3QrGd+JFmbIf7QMn6HVeaae1KWzHG24KKbsNDYxOFLEB5?=
 =?us-ascii?Q?MQmIturW0Sc9OavWoolC2eY0aSc1PChrcJc+Wy8HMlFNFmOFnPYHBvnW0GAl?=
 =?us-ascii?Q?nyhpnaRF4VypjJ4TkbfAP9AuJCIZa4k1w8hEMum1hw4dczZMt34rFTGCEGcR?=
 =?us-ascii?Q?qu/rKoF9E9y6IQ/cxV5Bjs/v?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd792b73-a0c7-436f-3c73-08d931a9deee
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:31.0677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcBrEQOte5K3QgHRpTHUVOh3q/qZleRzwF4jcJgnCVGgTVp6zc9uIfGbXnC+Fx0whp6Sx3CTvvZj1/UaV8OmYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1329
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/tx/tx.h | 109 +++++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/tx.h

diff --git a/drivers/net/wireless/celeno/cl8k/tx/tx.h b/drivers/net/wireles=
s/celeno/cl8k/tx/tx.h
new file mode 100644
index 000000000000..01c8f6b6306f
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tx/tx.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_TX_H
+#define CL_TX_H
+
+#include "hw.h"
+#include "sta.h"
+#include "vif.h"
+#include "debugfs.h"
+#include "ipc_shared.h"
+#include "tx/sw_txhdr.h"
+
+#define INC_SN(sn) (((sn) + 0x10) & IEEE80211_SCTL_SEQ)
+#define DEC_SN(sn) (((sn) - 0x10) & IEEE80211_SCTL_SEQ)
+
+#define CL_TX_LIFETIME_MS 4000
+
+#define CL_SKB_DATA_ALIGN_SZ      4
+#define CL_SKB_DATA_ALIGN_MSK     (CL_SKB_DATA_ALIGN_SZ - 1)
+#define CL_SKB_DATA_ALIGN_PADS(x) \
+       ((CL_SKB_DATA_ALIGN_SZ - ((ptrdiff_t)(x) & CL_SKB_DATA_ALIGN_MSK)) =
& CL_SKB_DATA_ALIGN_MSK)
+
+#define CL_TX_MAX_FRAME_LEN_SINGLE 4096
+#define CL_TX_MAX_FRAME_LEN_AGG 2000
+
+struct cl_hw_tx_status {
+       u32 mcs_index          : 7; /* [6:0] */
+       u32 is_bcmc            : 1; /* [7] */
+       u32 num_mpdu_retries   : 4; /* [11:8] */
+       u32 rsv                : 4; /* [15:12] */
+       u32 format_mod         : 4; /* [19:16] */
+       u32 bw_requested       : 2; /* [21:20] */
+       u32 bf                 : 1; /* [22] */
+       u32 frm_successful     : 1; /* [23] */
+       u32 bw_transmitted     : 2; /* [25:24] */
+       u32 freespace_inc_skip : 1; /* [26] */
+       u32 keep_skb           : 1; /* [27] */
+       u32 gi                 : 2; /* [29:28] */
+       u32 descriptor_done_sw : 1; /* [30] */
+       u32 descriptor_done_hw : 1; /* [31] */
+};
+
+enum cl_tx_flags {
+       CL_TX_EN_DFS,
+       CL_TX_EN_ACS,
+};
+
+enum cl_tx_single_frame_type {
+       CL_TX_SINGLE_FRAME_TYPE_QOS_DATA,
+       CL_TX_SINGLE_FRAME_TYPE_QOS_NULL,
+       CL_TX_SINGLE_FRAME_TYPE_MANAGEMENT,
+       CL_TX_SINGLE_FRAME_TYPE_OTHER
+};
+
+void cl_tx_init(struct cl_hw *cl_hw);
+void cl_tx_check_start_ba_session(struct cl_hw *cl_hw,
+                                 struct sta_info *stainfo,
+                                 struct sk_buff *skb);
+void cl_tx_bcns(struct cl_hw *cl_hw);
+void cl_tx_single_free_skb(struct cl_hw *cl_hw, struct sk_buff *skb);
+void cl_tx_single(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                 struct sk_buff *skb, bool is_vns, bool lock);
+void cl_tx_fast_single(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                      struct sk_buff *skb, bool lock);
+void cl_tx_agg_prep(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr,
+                   u16 frame_len, u8 hdr_pads, bool hdr_conv);
+void cl_tx_agg(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+              struct sk_buff *skb, bool hdr_conv, bool lock);
+void cl_tx_fast_agg(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                   struct sk_buff *skb, bool lock);
+u16 cl_tx_prepare_wlan_hdr(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                          struct sk_buff *skb, struct ieee80211_hdr *hdr);
+void cl_tx_wlan_to_8023(struct sk_buff *skb);
+int cl_tx_8023_to_wlan(struct cl_hw *cl_hw, struct sk_buff *skb, struct cl=
_sta *cl_sta, u8 tid);
+void cl_tx_push(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr, struct =
cl_tx_queue *tx_queue);
+void cl_tx_bcn_mesh_task(unsigned long data);
+void cl_tx_en(struct cl_hw *cl_hw, u8 reason, bool enable);
+void cl_tx_off(struct cl_hw *cl_hw);
+void cl_tx_drop_dkb(struct sk_buff *skb);
+netdev_tx_t ____cl_tx_start(struct cl_hw *cl_hw, struct sk_buff *skb, stru=
ct net_device *dev);
+netdev_tx_t ___cl_tx_start(struct cl_hw *cl_hw, struct sk_buff *skb, struc=
t net_device *dev);
+netdev_tx_t __cl_tx_start(struct cl_hw *cl_hw, struct sk_buff *skb, struct=
 net_device *dev);
+netdev_tx_t _cl_tx_start(struct cl_hw *cl_hw, struct sk_buff *skb, struct =
net_device *dev);
+netdev_tx_t cl_tx_start(struct sk_buff *skb, struct net_device *dev);
+
+static inline bool cl_tx_ctrl_is_amsdu(struct ieee80211_tx_info *tx_info)
+{
+       return !!(tx_info->control.flags & IEEE80211_TX_CTRL_AMSDU);
+}
+
+static inline bool cl_tx_ctrl_is_eapol(struct ieee80211_tx_info *tx_info)
+{
+       return !!(tx_info->control.flags & IEEE80211_TX_CTRL_PORT_CTRL_PROT=
O);
+}
+
+static inline bool cl_tx_ctrl_is_inject(struct ieee80211_tx_info *tx_info)
+{
+       /*
+        * Check that IEEE80211_TX_CTL_INJECTED is set and that
+        * IEEE80211_TX_INTFL_NL80211_FRAME_TX isn't to distinguish between
+        * TX-inject packets that Celeno driver generates and TX-inject pac=
kets
+        * that mac80211 generates in ieee80211_tx_control_port().
+        */
+       return ((tx_info->flags & IEEE80211_TX_CTL_INJECTED) &&
+               !(tx_info->flags & IEEE80211_TX_INTFL_NL80211_FRAME_TX));
+}
+
+#endif /* CL_TX_H */
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

