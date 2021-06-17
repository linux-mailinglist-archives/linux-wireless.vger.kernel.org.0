Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051F33AB8AA
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhFQQJm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:42 -0400
Received: from mail-vi1eur05on2083.outbound.protection.outlook.com ([40.107.21.83]:50945
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233705AbhFQQIW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6EUZERT0592Kk6OIbQ+v6EM9wDSqXGjsV2wkEH0/mI5duYVyugaJV/NbDxmUHddm/hc9L2vZoB2ET4Pyv7FSOlSWFq6RMJGfsGTI+JGbOtFYf9qQJO+gI0tar2NdPEbvzhlRb5DSFiKGUS5e+ZaRLya1uT2/ph3FOLhDtXWuDFclMEcZE0I0ZJk7KGh00RLrLbYgb7tHTA9Rfsx7AyGd4pndA9EmUik3ujivt9oW41a9FPXvl8QImzA/VloynyP0w0mYgad6dKVwVGW8L9prK7dY5ClhJ/u9k9hEkNRlr6E6+fPOaZzLR1IDPb2kAE2FQtjk1C/DIvOGzxAHxFddw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v99y19SRFAwJfpsm7qePqFhZRMUlwRl5E73B24WyBJk=;
 b=YMMABnJLukw/33d94K+bl1qvxq2Q/Hxi019zPsdKE9OImhqBRAJPUyRa1wODBBcYZpEGXElx+tkmSSppQNL+DrRDbSYS3ZROuoeQ+6Z6CopOVlPDYyMWgp00jmWb8bGu6qPFMFRHB+Y/gxNzoopWwWL5sVs2fSiU4/UmUE+ZlwgutiVvpqeK2CWSEJrMXEwTphho72bDkHAg42gsWIeNTesdeRd5kBYNcXsbTkyHlG4ChMbuJ9U48cSm3heCWdOpPEXL2CQtZZL9MNkM9eTm9IaWT7x+y1GNgZSxxgyreZdxZCZ10MTeBMmUW0qE9Ft0wLnkfWq1PliVGCsmVDxqcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v99y19SRFAwJfpsm7qePqFhZRMUlwRl5E73B24WyBJk=;
 b=Uci5dqauKWZLdTLX2CNxj8lOGHIgp8i2ErbNEYdrbP4rHZDxveXzqR0z5NoL5qhZEWW0egXqQ3Ff+unPJPsreXar7kfkzorDA2FvW+QMPqI0EpaMjOtRuoFDRN4UN0Qgwb1akCurrZhVYr9hpf35Agh86oAPquoOACVFbNtzAc4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1314.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:43 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:43 +0000
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
Subject: [RFC v1 123/256] cl8k: add ops.c
Date:   Thu, 17 Jun 2021 16:00:10 +0000
Message-Id: <20210617160223.160998-124-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f33eff4-85c0-4855-d1ab-08d931a9a27a
X-MS-TrafficTypeDiagnostic: AM9P192MB1314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB13140A840EF828C23D3E6ACDF60E9@AM9P192MB1314.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HRo+T7bVt36qdf2jlgSPCAA4O68HeWypoddj3wLDlt7OBUJ4e6deOeNrUufcHKCdP7P1+vXMo60ZePfOL0WOl3kaAs2LPxIN8tQfmI99uBk7g4v0dULPAAzduSkG7g2wL6EXmzmnSz80iuqr6TcxudSWZ1diW3K9w+TweZnJyP9IbubTCRCy/L8sweoz8URWef1tQpw/ab0Lul9k1Uher3kptJcuS2B3XWVO3sY19GOvJmEkovJ36Rol+vhMvC9P//Mf6rmsOgyw/q+ZrhAw5GkhuIe7i2blhkwiiGOAchBrlGURar7l3Kn4F2EwOT8sm/MRAVuhk/FA4qFDLgpR6rTG34tDuyKjb13qUzFtFY3dMbHtMMZs+XzHKs6jXrDKIfGEPLhMPGwe2jgAf/iPiT3ggSwuXoCyfC05xNOl3MRaDo5jwUZFHNnSyIQf0iTbs7PwSQ8tOndh+EOkBBrfrql8nvHRWAc/Yc9mr9LqOsPEVux/UiFFDUpI+9xgNH+BPTQS7uF5dmzdddtOnloB2lWvrtTxj4AJQYPvuoVcnLTAfSlGM/4sSS0M5p/Aq9TvIwy7rT/RNBCVHeyGioVPFGKQT/BsMFXnvWfkDnz35IUKy2+1P208f3gS58VANR50etC5qI244htLxYpBR3r4kVYb4m8rZzkSlfHOK3PnnYzCezhKajivy2FBFIfDpzNgfgA0OCViih+AvNbNX71Ubw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(39840400004)(366004)(376002)(136003)(346002)(8936002)(66946007)(83380400001)(186003)(5660300002)(26005)(36756003)(86362001)(8676002)(55236004)(1076003)(6916009)(2906002)(6506007)(66476007)(478600001)(6666004)(30864003)(38350700002)(52116002)(66556008)(956004)(4326008)(107886003)(54906003)(38100700002)(6486002)(2616005)(316002)(16526019)(6512007)(9686003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HKtydAGnaTDpcMQZkAKSpox5AbyZCKIvbM83ROvQ9HB6QVrJWMfOcNiNXJ2V?=
 =?us-ascii?Q?MjBKJDV5UVndIbgY6HhfYh1KvHSinFnSsxMAv4mGZqXyTGNvsYxMHb3K1dcH?=
 =?us-ascii?Q?3NWpt3NLNE1DYQi/0wu/pEAnKpni0ntBtwJKadYs+e3/CC+CiJmieWgLoR3o?=
 =?us-ascii?Q?ES7sElneukNORlOMa05x+v9pbr0zCiEB3XW/sQ8cVSjTbXBhJmBuz0jQ8bTF?=
 =?us-ascii?Q?dHMgY3KRnG08I8+z2dQuxJCozWBVoPQNWA6CsbnwZE9/m96Sp8MW0tpMQFt8?=
 =?us-ascii?Q?aFb10vGqQPqKsCzmNmkRpZRjrCzWl4PKw9NVMG7Fz2PzXdZ51yM5l/Ao0h6u?=
 =?us-ascii?Q?W2AWGqWjA1/Skme3jfK/lZVNv75oH90ffBDIjm1ERPD2JrWHFlmN44BSryff?=
 =?us-ascii?Q?aGcaiTIQTVE4aJqkfzgTv3HcYPEv2dCBZt6Ougthh1rViFwdVar4eHv+Hf6g?=
 =?us-ascii?Q?CykRDgn+8YDZD1XZJoyQ/RYtxJaCmlMDfFCeePesjZvoY9jqwopxk79BbI1F?=
 =?us-ascii?Q?8flc9dVeIAt1Rw/7BCJ2szrI4zuYeJDfxAharXg6mYLzXKvaPqeMN85yVjL/?=
 =?us-ascii?Q?FYu0EK357Aij2zffphWIE5Kh8ABFoC/PiVHy7FCZt3UGe2p94fxxFRHcw0JZ?=
 =?us-ascii?Q?I3Uu8bYaV/54Br7yORveuQr0yF35jRt6PLjerWBZrV/hYmCs3rW8ulLtEIrX?=
 =?us-ascii?Q?HDWn0SvM604THbsK0JcJFITYT3bJv6wHCmOXjVzQzGWWQr6OVFRnuEcTofFd?=
 =?us-ascii?Q?13VJGpZ073OfxthXjbifRyUCcYan5YdLSf60J3sM8LcE1RYTtSGS18DlLAsf?=
 =?us-ascii?Q?9FLBeZNnPkXQNQPhD29Jo4pbPf5lqp3qRZ6rhBEbKIzqwUntgBIFpRXAFRyw?=
 =?us-ascii?Q?YKrN3AYI1i2ZRg4s5sab2TtcbLEMhUnZ2B6Cn1C1UcIjjx+tunqzcs5YSDyP?=
 =?us-ascii?Q?LuIdgf8kLb11q2fDCnhnFgpvAYHVARbljuUAHhjDaEOgpruKQ6sZYQGG5nnE?=
 =?us-ascii?Q?1cvRu8D8lP1ntZMCfzPCB89gD3O/PAd+avcfk1ZHo81woMcHYdD4pPJLmCKc?=
 =?us-ascii?Q?Mrn5kL/nTKhkNdJAiySeYi5UFzbt1vQQyTuAJIELIwFPzYXp93HegT92jwaX?=
 =?us-ascii?Q?cnkqPHd7i3wl1jwEeoFMJ49K6dZw8PkVPIznxFX/DlXH5LiTb0S/23hTa+DE?=
 =?us-ascii?Q?YRrbEEvZ75bgQLn44x5Wl/41neBWbACT+JkaEZj6A/WzeMBlbclFgCqEZI8m?=
 =?us-ascii?Q?3xAZTyYDZF1tIo54DDru/97xdAAcngF66RkGWMACV3ilWNtmPXpFUZCQl3uP?=
 =?us-ascii?Q?p/L4Cpidn4XihN4k5jgyWHu1?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f33eff4-85c0-4855-d1ab-08d931a9a27a
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:49.7864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrLEvHQviqq2hPKrVTL20bqxyLRV3YQISiYgUloV+7Ml9q6BOB/BYYxOSTK36t8gwFLqcTRSqlZSx/0SZFl+5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1314
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/ops.c | 889 +++++++++++++++++++++++++
 1 file changed, 889 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/ops.c

diff --git a/drivers/net/wireless/celeno/cl8k/ops.c b/drivers/net/wireless/=
celeno/cl8k/ops.c
new file mode 100644
index 000000000000..16934984b7cd
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/ops.c
@@ -0,0 +1,889 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include <linux/log2.h>
+#include "ops.h"
+#include "utils/ip.h"
+#include "chip.h"
+#include "ampdu.h"
+#include "fw/msg_tx.h"
+#include "tx/tx.h"
+#include "tx/tx_queue.h"
+#include "radio.h"
+#include "recovery.h"
+#include "rate_ctrl.h"
+#include "temperature.h"
+#include "band.h"
+#include "rx/rx.h"
+#include "edca.h"
+#include "utils/math.h"
+#include "utils/utils.h"
+#include "ext/dyn_mcast_rate.h"
+#include "ext/dyn_bcast_rate.h"
+#include "vns.h"
+#include "dfs/dfs.h"
+#include "key.h"
+#include "temperature.h"
+#include "calib.h"
+#include "wrs/wrs_api.h"
+#include "chandef.h"
+#include "version.h"
+#include "power.h"
+#include "tx/tx_inject.h"
+#include "stats.h"
+#include "netlink.h"
+#include "calib.h"
+#ifdef CONFIG_CL_PCIE
+#include "bus/pci/ipc.h"
+#endif
+
+static const int cl_ac2hwq[AC_MAX] =3D {
+       [NL80211_TXQ_Q_VO] =3D CL_HWQ_VO,
+       [NL80211_TXQ_Q_VI] =3D CL_HWQ_VI,
+       [NL80211_TXQ_Q_BE] =3D CL_HWQ_BE,
+       [NL80211_TXQ_Q_BK] =3D CL_HWQ_BK
+};
+
+static const int cl_ac2edca[AC_MAX] =3D {
+       [NL80211_TXQ_Q_VO] =3D EDCA_AC_VO,
+       [NL80211_TXQ_Q_VI] =3D EDCA_AC_VI,
+       [NL80211_TXQ_Q_BE] =3D EDCA_AC_BE,
+       [NL80211_TXQ_Q_BK] =3D EDCA_AC_BK
+};
+
+static void cl_ops_tx_agg(struct cl_hw *cl_hw,
+                         struct sk_buff *skb,
+                         struct ieee80211_tx_info *tx_info,
+                         struct cl_sta *cl_sta)
+{
+       cl_hw->tx_packet_cntr.forward.from_mac_agg++;
+
+       if (!cl_sta) {
+               kfree_skb(skb);
+               cl_dbg_err(cl_hw, "cl_sta null in agg packet\n");
+               cl_hw->tx_packet_cntr.drop.sta_null_in_agg++;
+               return;
+       }
+
+       /* AMSDU in HW can work only with header conversion. */
+       tx_info->control.flags &=3D ~IEEE80211_TX_CTRL_AMSDU;
+       cl_tx_agg(cl_hw, cl_sta, skb, false, true);
+}
+
+static void cl_ops_tx_single(struct cl_hw *cl_hw,
+                            struct sk_buff *skb,
+                            struct ieee80211_tx_info *tx_info,
+                            struct cl_sta *cl_sta)
+{
+       bool is_vns =3D cl_vns_is_very_near(cl_hw, cl_sta, skb);
+
+       cl_hw->tx_packet_cntr.forward.from_mac_single++;
+
+       cl_tx_single(cl_hw, cl_sta, skb, is_vns, true);
+}
+
+void cl_ops_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *contr=
ol, struct sk_buff *skb)
+{
+       /*
+        * Almost all traffic passing here is singles.
+        * Only when opening a BA session some packets with
+        * IEEE80211_TX_CTL_AMPDU set can pass here.
+        * All skbs passing here did header conversion.
+        */
+       struct cl_hw *cl_hw =3D (struct cl_hw *)hw->priv;
+       struct ieee80211_tx_info *tx_info =3D IEEE80211_SKB_CB(skb);
+       struct ieee80211_sta *sta =3D control->sta;
+       struct cl_sta *cl_sta =3D NULL;
+
+       if (sta) {
+               cl_sta =3D IEEE80211_STA_TO_CL_STA(sta);
+
+               /*
+                * Prior to STA connection sta can be set but we don't
+                * want cl_sta to be used since it's not initialized yet
+                */
+               if (cl_sta->sta_idx =3D=3D STA_IDX_INVALID)
+                       cl_sta =3D NULL;
+       }
+
+       if (cl_recovery_in_progress(cl_hw)) {
+               cl_hw->tx_packet_cntr.drop.in_recovery++;
+               cl_tx_drop_dkb(skb);
+               return;
+       }
+
+       if (tx_info->flags & IEEE80211_TX_CTL_AMPDU)
+               cl_ops_tx_agg(cl_hw, skb, tx_info, cl_sta);
+       else
+               cl_ops_tx_single(cl_hw, skb, tx_info, cl_sta);
+}
+
+int cl_ops_start(struct ieee80211_hw *hw)
+{
+       /*
+        * Called before the first netdevice attached to the hardware
+        * is enabled. This should turn on the hardware and must turn on
+        * frame reception (for possibly enabled monitor interfaces.)
+        * Returns negative error codes, these may be seen in userspace,
+        * or zero.
+        * When the device is started it should not have a MAC address
+        * to avoid acknowledging frames before a non-monitor device
+        * is added.
+        * Must be implemented and can sleep.
+        * It does not return until the firmware is up and running.
+        */
+       int error =3D 0;
+       struct cl_hw *cl_hw =3D hw->priv;
+       struct cl_tcv_conf *conf =3D cl_hw->conf;
+
+#ifdef CONFIG_CL_PCIE
+       if (!cl_hw->ipc_env) {
+               CL_DBG_ERROR(cl_hw, "ipc_env is NULL! 'no_dhcpcd' is missin=
g in nvram folder\n");
+               return -1;
+       }
+#endif
+
+       /* Exits if device is already started */
+       if (WARN_ON(test_bit(CL_DEV_STARTED, &cl_hw->drv_flags)))
+               return -EBUSY;
+
+       /* Start firmware */
+       error =3D cl_msg_tx_start(cl_hw);
+       if (error)
+               return error;
+
+       /* Device is now started.
+        * Set CL_DEV_STARTED bit before the calls to other messages sent t=
o
+        * firmware, to prevent them from being blocked*
+        */
+       set_bit(CL_DEV_STARTED, &cl_hw->drv_flags);
+
+       if (!cl_recovery_in_progress(cl_hw)) {
+               /* Read version */
+               error =3D cl_version_update(cl_hw);
+               if (error)
+                       return error;
+
+               error =3D cl_temperature_diff_e2p_read(cl_hw);
+               if (error)
+                       return error;
+       }
+
+       /* Set firmware debug module filter */
+       error =3D cl_msg_tx_dbg_set_ce_mod_filter(cl_hw, conf->ci_fw_dbg_mo=
dule);
+       if (error)
+               return error;
+
+       /* Set firmware debug severity level */
+       error =3D cl_msg_tx_dbg_set_sev_filter(cl_hw, conf->ci_fw_dbg_sever=
ity);
+       if (error)
+               return error;
+
+       /* Set firmware rate fallbacks */
+       error =3D cl_msg_tx_set_rate_fallback(cl_hw);
+       if (error)
+               return error;
+
+       error =3D cl_msg_tx_ndp_tx_control(cl_hw,
+                                        conf->ci_ndp_tx_chain_mask,
+                                        conf->ci_ndp_tx_bw,
+                                        conf->ci_ndp_tx_format,
+                                        conf->ci_ndp_tx_num_ltf);
+       if (error)
+               return error;
+
+       /* Set default, multicast, broadcast rate */
+       cl_rate_ctrl_set_default(cl_hw);
+       cl_dyn_mcast_rate_set(cl_hw);
+       cl_dyn_bcast_rate_set(cl_hw, 0);
+
+       ieee80211_wake_queues(hw);
+
+       cl_calib_start(cl_hw);
+
+       clear_bit(CL_DEV_INIT, &cl_hw->drv_flags);
+
+       cl_edca_hw_conf(cl_hw);
+
+       return error;
+}
+
+void cl_ops_stop(struct ieee80211_hw *hw)
+{
+       /*
+        * Called after last netdevice attached to the hardware
+        * is disabled. This should turn off the hardware (at least
+        * it must turn off frame reception.)
+        * May be called right after add_interface if that rejects
+        * an interface. If you added any work onto the mac80211 workqueue
+        * you should ensure to cancel it on this callback.
+        * Must be implemented and can sleep.
+        */
+       struct cl_hw *cl_hw =3D hw->priv;
+
+       /* Go to idle */
+       cl_msg_tx_set_idle(cl_hw, MAC_IDLE_SYNC);
+
+       /*
+        * Clear CL_DEV_STARTED to prevent message to be sent (besides rese=
t and start).
+        * It also blocks transmission of new packets
+        */
+       clear_bit(CL_DEV_STARTED, &cl_hw->drv_flags);
+
+       /* Stop mac80211 queues */
+       ieee80211_stop_queues(hw);
+
+       /* Send reset message to firmware */
+       cl_msg_tx_reset(cl_hw);
+
+#ifdef CONFIG_CL_PCIE
+       /* Reset IPC */
+       cl_ipc_reset(cl_hw);
+#endif
+
+       cl_hw->num_ap_started =3D 0;
+       cl_hw->radio_status =3D RADIO_STATUS_OFF;
+}
+
+static int add_interface_to_firmware(struct cl_hw *cl_hw, struct ieee80211=
_vif *vif, u8 vif_index)
+{
+       struct mm_add_if_cfm *add_if_cfm;
+       int ret =3D 0;
+
+       /* Forward the information to the firmware */
+       ret =3D cl_msg_tx_add_if(cl_hw, vif, vif_index);
+       if (ret)
+               return ret;
+
+       add_if_cfm =3D (struct mm_add_if_cfm *)(cl_hw->msg_cfm_params[MM_AD=
D_IF_CFM]);
+       if (!add_if_cfm)
+               return -ENOMSG;
+
+       if (add_if_cfm->status !=3D 0) {
+               cl_dbg_verbose(cl_hw, "Status Error (%u)\n", add_if_cfm->st=
atus);
+               ret =3D -EIO;
+       }
+
+       cl_msg_tx_free_cfm_params(cl_hw, MM_ADD_IF_CFM);
+
+       return ret;
+}
+
+int cl_ops_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vi=
f)
+{
+       /*
+        * Called when a netdevice attached to the hardware is
+        * enabled. Because it is not called for monitor mode devices, star=
t
+        * and stop must be implemented.
+        * The driver should perform any initialization it needs before
+        * the device can be enabled. The initial configuration for the
+        * interface is given in the conf parameter.
+        * The callback may refuse to add an interface by returning a
+        * negative error code (which will be seen in userspace.)
+        * Must be implemented and can sleep.
+        */
+       struct cl_hw *cl_hw =3D hw->priv;
+       struct cl_chip *chip =3D cl_hw->chip;
+       struct cl_vif *cl_vif =3D (struct cl_vif *)vif->drv_priv;
+       struct ieee80211_sub_if_data *sdata =3D container_of(vif, struct ie=
ee80211_sub_if_data, vif);
+       struct net_device *dev =3D sdata->dev;
+       u8 ac;
+
+       if (!dev)
+               return -1;
+
+       /*
+        * In recovery just send the message to firmware and exit
+        * (also make sure cl_vif already exists).
+        */
+       if (cl_recovery_in_progress(cl_hw) && cl_vif_get_by_dev(cl_hw, dev)=
)
+               return add_interface_to_firmware(cl_hw, vif, cl_vif->vif_in=
dex);
+
+       cl_vif->cl_hw =3D cl_hw;
+       cl_vif->vif =3D vif;
+       cl_vif->dev =3D dev;
+
+       if (chip->conf->ce_production_mode)
+               cl_vif->tx_en =3D true;
+
+       /* Copy dev ops and change ndo_start_xmit to point at cl_tx_start()=
 */
+       cl_vif->orig_dev_ops =3D dev->netdev_ops;
+       memcpy(&cl_vif->dev_ops, dev->netdev_ops, sizeof(struct net_device_=
ops));
+       cl_vif->dev_ops.ndo_start_xmit =3D cl_tx_start;
+       dev->netdev_ops =3D &cl_vif->dev_ops;
+
+       if (chip->idx =3D=3D CHIP0) {
+               if (cl_hw_is_tcv0(cl_hw))
+                       sscanf(dev->name, CL_IFACE_PREFIX "0_%hhu", &cl_vif=
->vif_index);
+               else
+                       sscanf(dev->name, CL_IFACE_PREFIX "1_%hhu", &cl_vif=
->vif_index);
+       } else {
+               if (cl_hw_is_tcv0(cl_hw))
+                       sscanf(dev->name, CL_IFACE_PREFIX "2_%hhu", &cl_vif=
->vif_index);
+               else
+                       sscanf(dev->name, CL_IFACE_PREFIX "3_%hhu", &cl_vif=
->vif_index);
+       }
+
+       if (add_interface_to_firmware(cl_hw, vif, cl_vif->vif_index))
+               return -1;
+
+       if (vif->type !=3D NL80211_IFTYPE_STATION)
+               vif->cab_queue =3D CL_HWQ_VO;
+
+       cl_vif_add(cl_hw, cl_vif);
+
+       for (ac =3D 0; ac < AC_MAX; ac++)
+               vif->hw_queue[ac] =3D cl_ac2hwq[ac];
+
+       if (vif->type =3D=3D NL80211_IFTYPE_MESH_POINT) {
+               tasklet_init(&cl_hw->tx_mesh_bcn_task, cl_tx_bcn_mesh_task,
+                            (unsigned long)cl_vif);
+               cl_radio_on(cl_hw);
+               cl_vif->tx_en =3D true;
+       }
+
+       /* Set active state in station mode after ifconfig down and up */
+       if (cl_radio_is_on(cl_hw) && vif->type =3D=3D NL80211_IFTYPE_STATIO=
N)
+               cl_msg_tx_set_idle(cl_hw, MAC_ACTIVE);
+
+       return 0;
+}
+
+void cl_ops_remove_interface(struct ieee80211_hw *hw, struct ieee80211_vif=
 *vif)
+{
+       /*
+        * Notifies a driver that an interface is going down.
+        * The stop callback is called after this if it is the last interfa=
ce
+        * and no monitor interfaces are present.
+        * When all interfaces are removed, the MAC address in the hardware
+        * must be cleared so the device no longer acknowledges packets,
+        * the mac_addr member of the conf structure is, however, set to th=
e
+        * MAC address of the device going away.
+        * Hence, this callback must be implemented. It can sleep.
+        */
+       struct cl_hw *cl_hw =3D hw->priv;
+       struct cl_vif *cl_vif =3D (struct cl_vif *)vif->drv_priv;
+
+       if (vif->type =3D=3D NL80211_IFTYPE_MESH_POINT)
+               tasklet_kill(&cl_hw->tx_mesh_bcn_task);
+
+       if (!cl_recovery_in_progress(cl_hw)) {
+               cl_vif_remove(cl_hw, cl_vif);
+               cl_msg_tx_remove_if(cl_hw, cl_vif->vif_index);
+       } else {
+               cl_vif_remove(cl_hw, cl_vif);
+       }
+
+       /* Return netdev_ops back to it's original configuration */
+       cl_vif->dev->netdev_ops =3D cl_vif->orig_dev_ops;
+
+       cl_vif->cl_hw =3D NULL;
+       cl_vif->vif =3D NULL;
+       cl_vif->dev =3D NULL;
+}
+
+static int cl_ops_conf_change_channel(struct ieee80211_hw *hw)
+{
+       struct cl_hw *cl_hw =3D hw->priv;
+       struct cl_chip *chip =3D cl_hw->chip;
+       struct cfg80211_chan_def *chandef =3D &hw->conf.chandef;
+       enum nl80211_chan_width width =3D chandef->width;
+       u32 primary =3D chandef->chan->center_freq;
+       u32 center =3D chandef->center_freq1;
+       u8 channel =3D ieee80211_frequency_to_channel(primary);
+       u8 bw;
+
+       if (!test_bit(CL_DEV_STARTED, &cl_hw->drv_flags) ||
+           test_bit(CL_DEV_INIT, &cl_hw->drv_flags))
+               return -EBUSY;
+
+       /* WA: for the first set-channel in production mode use the nvram v=
alues */
+       if (chip->conf->ce_production_mode && !cl_hw->chandef_set) {
+               cl_hw->chandef_set =3D true;
+               cl_chandef_get_default(cl_hw, &width, &primary, &center);
+               channel =3D cl_hw->conf->ha_channel;
+       }
+
+       bw =3D width_to_bw(width);
+
+       if (cl_hw->channel =3D=3D channel &&
+           cl_hw->bw =3D=3D bw &&
+           cl_hw->primary_freq =3D=3D primary &&
+           cl_hw->center_freq =3D=3D center)
+               goto check_cac;
+
+       /*
+        * Flush the pending data to ensure that we will finish the pending
+        * transmissions before changing the channel
+        */
+       cl_ops_flush(hw, NULL, -1, false);
+
+       if (cl_band_is_6g(cl_hw))
+               cl_netlink_send_event_co_locate_update(cl_hw);
+
+       if (cl_msg_tx_set_channel(cl_hw, channel, bw, primary, center))
+               return -EIO;
+
+check_cac:
+       /*
+        * TODO: This callback is being spawned even in STA mode, moreover,
+        * "start_ap" comes later - it is unclear whether we are an AP at t=
his
+        * stage. Likely, may be solved by moving "force_cac_*" states to b=
eginning
+        * of "start_ap", but the request should stay in current callback
+        */
+       if (!cl_band_is_5g(cl_hw))
+               return 0;
+
+       /*
+        * Radar listening may occur at DFS channels during in-service mode=
,
+        * so CAC may clear the channels, but radar listening should be
+        * still active, and should start it as soon as we can.
+        */
+       if (hw->conf.radar_enabled) {
+               /* If channel policy demans to be in CAC - need to request =
it */
+               if (!cl_dfs_is_in_cac(cl_hw) &&
+                   chandef->chan->dfs_state =3D=3D NL80211_DFS_USABLE)
+                       cl_dfs_request_cac(cl_hw, true);
+
+               if (!cl_dfs_radar_listening(cl_hw))
+                       cl_dfs_radar_listen_start(cl_hw);
+       } else {
+               /*
+                * No sense to continue be in silent mode if the channel wa=
s
+                * cleared
+                */
+               if (cl_dfs_is_in_cac(cl_hw) &&
+                   chandef->chan->dfs_state =3D=3D NL80211_DFS_AVAILABLE)
+                       cl_dfs_request_cac(cl_hw, false);
+
+               if (cl_dfs_radar_listening(cl_hw))
+                       cl_dfs_radar_listen_end(cl_hw);
+       }
+
+       /*
+        * We have just finished channel switch.
+        * Now, check what to do with CAC.
+        */
+       if (cl_dfs_requested_cac(cl_hw))
+               cl_dfs_force_cac_start(cl_hw);
+       else if (cl_dfs_is_in_cac(cl_hw))
+               cl_dfs_force_cac_end(cl_hw);
+
+       return 0;
+}
+
+int cl_ops_config(struct ieee80211_hw *hw, u32 changed)
+{
+       /*
+        * Handler for configuration requests. IEEE 802.11 code calls this
+        * function to change hardware configuration, e.g., channel.
+        * This function should never fail but returns a negative error cod=
e
+        * if it does. The callback can sleep
+        */
+       int error =3D 0;
+
+       if (changed & IEEE80211_CONF_CHANGE_CHANNEL)
+               error =3D cl_ops_conf_change_channel(hw);
+
+       return error;
+}
+
+/*
+ * @bss_info_changed: Handler for configuration requests related to BSS
+ *  parameters that may vary during BSS's lifespan, and may affect low
+ *  level driver (e.g. assoc/disassoc status, erp parameters).
+ *  This function should not be used if no BSS has been set, unless
+ *  for association indication. The @changed parameter indicates which
+ *  of the bss parameters has changed when a call is made. The callback
+ *  can sleep.
+ */
+void cl_ops_bss_info_changed(struct ieee80211_hw *hw,
+                            struct ieee80211_vif *vif,
+                            struct ieee80211_bss_conf *info,
+                            u32 changed)
+{
+       struct cl_hw *cl_hw =3D hw->priv;
+       struct cl_vif *cl_vif =3D (struct cl_vif *)vif->drv_priv;
+
+       if (changed & BSS_CHANGED_ASSOC) {
+               if (cl_msg_tx_set_associated(cl_hw, info))
+                       return;
+       }
+
+       if (changed & BSS_CHANGED_BSSID) {
+               if (cl_msg_tx_set_bssid(cl_hw, info->bssid, cl_vif->vif_ind=
ex))
+                       return;
+       }
+
+       if (changed & BSS_CHANGED_BEACON_INT) {
+               if (vif->type =3D=3D NL80211_IFTYPE_AP ||
+                   cl_hw->iface_conf =3D=3D CL_IFCONF_MESH_ONLY) {
+                       if (cl_msg_tx_set_beacon_int(cl_hw, info->beacon_in=
t,
+                                                    cl_vif->vif_index))
+                               return;
+                       if (cl_msg_tx_dtim(cl_hw, info->dtim_period))
+                               return;
+               }
+
+               if (vif->type =3D=3D NL80211_IFTYPE_MESH_POINT &&
+                   cl_hw->iface_conf =3D=3D CL_IFCONF_MESH_AP)
+                       cl_hw->mesh_tbtt_div =3D (info->beacon_int /
+                                           cl_hw->conf->ha_beacon_int);
+       }
+
+       if (changed & BSS_CHANGED_BASIC_RATES) {
+               int shift =3D hw->wiphy->bands[hw->conf.chandef.chan->band]=
->bitrates[0].hw_value;
+
+               if (cl_msg_tx_set_basic_rates(cl_hw, info->basic_rates << s=
hift))
+                       return;
+               /* TODO: check if cl_msg_tx_set_mode() should be called */
+       }
+
+       if (changed & BSS_CHANGED_ERP_SLOT) {
+               /*
+                * We must be in 11g mode here
+                * TODO: we can add a check on the mode
+                */
+               if (cl_msg_tx_set_slottime(cl_hw, info->use_short_slot))
+                       return;
+       }
+
+       if (changed & BSS_CHANGED_BANDWIDTH)
+               cl_wrs_api_bss_set_bw(cl_hw, width_to_bw(info->chandef.widt=
h));
+}
+
+int cl_ops_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+       struct cl_hw *cl_hw =3D hw->priv;
+       u8 num_ap =3D cl_tcv_config_get_num_ap(cl_hw);
+
+       /*
+        * Increase num_ap_started counter and turn radio on only after
+        * all AP's were started.
+        */
+       cl_hw->num_ap_started++;
+
+       if (num_ap =3D=3D cl_hw->num_ap_started &&
+           cl_hw->conf->ce_radio_on) {
+               cl_radio_on(cl_hw);
+
+               return 0;
+       }
+
+       /*
+        * Set active state when cl_ops_start_ap() is called not during fir=
st driver start
+        * but rather after removing all interfaces and then doing up again=
 to one interface.
+        */
+       if (cl_radio_is_on(cl_hw) && !cl_recovery_in_progress(cl_hw))
+               cl_msg_tx_set_idle(cl_hw, MAC_ACTIVE);
+
+       return 0;
+}
+
+void cl_ops_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+       struct cl_hw *cl_hw =3D hw->priv;
+
+       cl_hw->num_ap_started--;
+}
+
+u64 cl_ops_prepare_multicast(struct ieee80211_hw *hw, struct netdev_hw_add=
r_list *mc_list)
+{
+       return netdev_hw_addr_list_count(mc_list);
+}
+
+void cl_ops_configure_filter(struct ieee80211_hw *hw, u32 changed_flags,
+                            u32 *total_flags, u64 multicast)
+{
+       /*
+        * configure_filter: Configure the device's RX filter.
+        * See the section "Frame filtering" for more information.
+        * This callback must be implemented and can sleep.
+        */
+       struct cl_hw *cl_hw =3D hw->priv;
+
+       cl_dbg_trace(cl_hw, "total_flags =3D 0x%08x\n", *total_flags);
+
+       /*
+        * Reset our filter flags since our start/stop ops reset
+        * the programmed settings
+        */
+       if (!test_bit(CL_DEV_STARTED, &cl_hw->drv_flags)) {
+               *total_flags =3D 0;
+               return;
+       }
+
+       if (multicast)
+               *total_flags |=3D FIF_ALLMULTI;
+       else
+               *total_flags &=3D ~FIF_ALLMULTI;
+
+       /* TODO optimize with changed_flags vs multicast */
+       cl_msg_tx_set_filter(cl_hw, *total_flags, false);
+
+       /* TODO update total_flags with truly set flags */
+       *total_flags &=3D ~(1 << 31);
+}
+
+int cl_ops_set_key(struct ieee80211_hw *hw,
+                  enum set_key_cmd cmd,
+                  struct ieee80211_vif *vif,
+                  struct ieee80211_sta *sta,
+                  struct ieee80211_key_conf *key)
+{
+       struct cl_hw *cl_hw =3D hw->priv;
+
+       return cl_key_set(cl_hw, cmd, vif, sta, key);
+}
+
+void cl_ops_sw_scan_start(struct ieee80211_hw *hw,
+                         struct ieee80211_vif *vif,
+                         const u8 *mac_addr)
+{
+       struct cl_hw *cl_hw =3D hw->priv;
+
+       if (cl_hw->conf->ce_radio_on &&
+           cl_radio_is_off(cl_hw) &&
+           vif->type =3D=3D NL80211_IFTYPE_STATION)
+               cl_radio_on(cl_hw);
+}
+
+int cl_ops_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif, s=
truct ieee80211_sta *sta,
+                    enum ieee80211_sta_state old_state, enum ieee80211_sta=
_state new_state)
+{
+       struct cl_hw *cl_hw =3D hw->priv;
+       int error =3D 0;
+
+       if (old_state =3D=3D new_state)
+               return 0;
+
+       if (old_state =3D=3D IEEE80211_STA_NOTEXIST &&
+           new_state =3D=3D IEEE80211_STA_NONE) {
+               struct sta_info *stainfo =3D container_of(sta, struct sta_i=
nfo, sta);
+
+               cl_sta_init_stainfo(cl_hw, stainfo);
+       } else if (old_state =3D=3D IEEE80211_STA_AUTH &&
+                  new_state =3D=3D IEEE80211_STA_ASSOC) {
+               error =3D cl_sta_add(cl_hw, vif, sta);
+       } else if (old_state =3D=3D IEEE80211_STA_ASSOC &&
+                  new_state =3D=3D IEEE80211_STA_AUTH) {
+               cl_sta_remove(cl_hw, vif, sta);
+       } else if (old_state =3D=3D IEEE80211_STA_ASSOC &&
+                  new_state =3D=3D IEEE80211_STA_AUTHORIZED) {
+               /* Do nothing, yet */
+       }
+
+       return error;
+}
+
+void cl_ops_sta_notify(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+                      enum sta_notify_cmd cmd, struct ieee80211_sta *sta)
+{
+       struct cl_hw *cl_hw =3D (struct cl_hw *)hw->priv;
+       struct cl_sta *cl_sta =3D IEEE80211_STA_TO_CL_STA(sta);
+       bool is_ps =3D (bool)!cmd;
+
+       cl_sta_ps_notify(cl_hw, cl_sta, is_ps);
+}
+
+int cl_ops_conf_tx(struct ieee80211_hw *hw,
+                  struct ieee80211_vif *vif,
+                  u16 ac_queue,
+                  const struct ieee80211_tx_queue_params *params)
+{
+       /*
+        * Configure TX queue parameters (EDCF (aifs, cw_min, cw_max),
+        * bursting) for a hardware TX queue.
+        * Returns a negative error code on failure.
+        * The callback can sleep.
+        */
+
+       /* We only handle STA edca here */
+       if (vif->type =3D=3D NL80211_IFTYPE_STATION) {
+               struct cl_hw *cl_hw =3D hw->priv;
+               struct ieee80211_he_mu_edca_param_ac_rec mu_edca =3D {0};
+               struct edca_params edca_params =3D {
+                       .aifsn =3D (u8)(params->aifs),
+                       .cw_min =3D (u8)(ilog2(params->cw_min + 1)),
+                       .cw_max =3D (u8)(ilog2(params->cw_max + 1)),
+                       .txop =3D (u8)(params->txop)
+               };
+
+               if (cl_hw->conf->ce_wireless_mode > WIRELESS_MODE_HT_VHT)
+                       memcpy(&mu_edca, &params->mu_edca_param_rec, sizeof=
(mu_edca));
+
+               cl_edca_set(cl_hw, cl_ac2edca[ac_queue], &edca_params, &mu_=
edca);
+       }
+       return 0;
+}
+
+void cl_ops_sta_rc_update(struct ieee80211_hw *hw,
+                         struct ieee80211_vif *vif,
+                         struct ieee80211_sta *sta,
+                         u32 changed)
+{
+       struct cl_hw *cl_hw =3D (struct cl_hw *)hw->priv;
+
+       if (changed & IEEE80211_RC_BW_CHANGED)
+               cl_wrs_api_bw_changed(cl_hw, sta, sta->bandwidth);
+
+       if (changed & IEEE80211_RC_SMPS_CHANGED) {
+               struct sta_info *stainfo =3D container_of(sta, struct sta_i=
nfo, sta);
+
+               cl_wrs_api_set_smps_mode(cl_hw, sta, stainfo->cur_max_bandw=
idth);
+       }
+
+       WARN_ON(sta->rx_nss =3D=3D 0);
+       if (changed & IEEE80211_RC_NSS_CHANGED) {
+               u8 nss =3D min_t(u8, sta->rx_nss, WRS_SS_MAX) - 1;
+
+               cl_wrs_api_nss_changed(cl_hw, sta, nss);
+       }
+}
+
+int cl_ops_ampdu_action(struct ieee80211_hw *hw,
+                       struct ieee80211_vif *vif,
+                       struct ieee80211_ampdu_params *params)
+{
+       struct cl_hw *cl_hw =3D (struct cl_hw *)hw->priv;
+       struct cl_sta *cl_sta =3D IEEE80211_STA_TO_CL_STA(params->sta);
+       int ret =3D 0;
+
+       switch (params->action) {
+       case IEEE80211_AMPDU_RX_START:
+               ret =3D cl_ampdu_rx_start(cl_hw, cl_sta, params->tid,
+                                       params->ssn, params->buf_size);
+               break;
+       case IEEE80211_AMPDU_RX_STOP:
+               cl_ampdu_rx_stop(cl_hw, cl_sta, params->tid);
+               break;
+       case IEEE80211_AMPDU_TX_START:
+               ret =3D cl_ampdu_tx_start(cl_hw, vif, cl_sta, params->tid,
+                                       params->ssn);
+               break;
+       case IEEE80211_AMPDU_TX_OPERATIONAL:
+               ret =3D cl_ampdu_tx_operational(cl_hw, cl_sta, params->tid,
+                                             params->buf_size, params->ams=
du);
+               break;
+       case IEEE80211_AMPDU_TX_STOP_CONT:
+       case IEEE80211_AMPDU_TX_STOP_FLUSH:
+       case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
+               ret =3D cl_ampdu_tx_stop(cl_hw, vif, params->action, cl_sta=
,
+                                      params->tid);
+               break;
+       default:
+               pr_warn("Error: Unknown AMPDU action (%d)\n", params->actio=
n);
+       }
+
+       return ret;
+}
+
+int cl_ops_post_channel_switch(struct ieee80211_hw *hw,
+                              struct ieee80211_vif *vif)
+{
+       /* TODO: Handle event */
+
+       return 0;
+}
+
+void cl_ops_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u32 =
queues, bool drop)
+{
+       struct cl_hw *cl_hw =3D hw->priv;
+       int flush_duration;
+
+       if (test_bit(CL_DEV_HW_RESTART, &cl_hw->drv_flags)) {
+               cl_dbg_verbose(cl_hw, ": bypassing (CL_DEV_HW_RESTART set)\=
n");
+               return;
+       }
+
+       /* Wait for a maximum time of 200ms until all pending frames are fl=
ushed */
+       for (flush_duration =3D 0; flush_duration < 200; flush_duration++) =
{
+               if (!cl_txq_frames_pending(cl_hw))
+                       return;
+
+               /* Lets sleep and hope for the best */
+               usleep_range(1000, 2000);
+       }
+}
+
+bool cl_ops_tx_frames_pending(struct ieee80211_hw *hw)
+{
+       struct cl_hw *cl_hw =3D hw->priv;
+
+       return cl_txq_frames_pending(cl_hw);
+}
+
+void cl_ops_reconfig_complete(struct ieee80211_hw *hw,
+                             enum ieee80211_reconfig_type reconfig_type)
+{
+       struct cl_hw *cl_hw =3D hw->priv;
+
+       cl_recovery_reconfig_complete(cl_hw);
+}
+
+int cl_ops_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,=
 int *dbm)
+{
+       struct cl_hw *cl_hw =3D hw->priv;
+
+       if (cl_hw->phy_data_info.data)
+               *dbm =3D cl_power_get_max(cl_hw);
+       else
+               *dbm =3D 0;
+
+       return 0;
+}
+
+int cl_ops_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
+{
+       return 0;
+}
+
+static void cl_ops_mgd_assoc(struct cl_hw *cl_hw, struct ieee80211_vif *vi=
f)
+{
+       struct ieee80211_sub_if_data *sdata =3D container_of(vif, struct ie=
ee80211_sub_if_data, vif);
+       struct cl_vif *cl_vif =3D (struct cl_vif *)vif->drv_priv;
+       struct ieee80211_sta *sta =3D ieee80211_find_sta(vif, sdata->u.mgd.=
bssid);
+
+       if (!sta) {
+               /* Should never happen */
+               cl_dbg_verbose(cl_hw, "sta is NULL !!!\n");
+               return;
+       }
+
+       cl_sta_mgd_add(cl_hw, cl_vif, sta);
+
+       if (cl_hw->iface_conf =3D=3D CL_IFCONF_REPEATER) {
+               cl_vif_ap_tx_enable(cl_hw, true);
+               set_bit(CL_DEV_REPEATER, &cl_hw->drv_flags);
+       }
+}
+
+static void cl_ops_mgd_disassoc(struct cl_hw *cl_hw)
+{
+       if (cl_hw->iface_conf =3D=3D CL_IFCONF_REPEATER) {
+               cl_sta_disassociate_ap_iface(cl_hw);
+               cl_vif_ap_tx_enable(cl_hw, false);
+               clear_bit(CL_DEV_REPEATER, &cl_hw->drv_flags);
+       }
+}
+
+void cl_ops_event_callback(struct ieee80211_hw *hw, struct ieee80211_vif *=
vif,
+                          const struct ieee80211_event *event)
+{
+       struct cl_hw *cl_hw =3D hw->priv;
+
+       if (event->type =3D=3D MLME_EVENT) {
+               if (event->u.mlme.data =3D=3D ASSOC_EVENT &&
+                   event->u.mlme.status =3D=3D MLME_SUCCESS)
+                       cl_ops_mgd_assoc(cl_hw, vif);
+               else if (event->u.mlme.data =3D=3D DEAUTH_TX_EVENT ||
+                        event->u.mlme.data =3D=3D DEAUTH_RX_EVENT)
+                       cl_ops_mgd_disassoc(cl_hw);
+       }
+}
+
+/* This function is required for PS flow - do not remove */
+int cl_ops_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta, boo=
l set)
+{
+       return 0;
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

