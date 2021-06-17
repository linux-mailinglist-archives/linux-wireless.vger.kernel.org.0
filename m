Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECF73AB8F9
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbhFQQLh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:37 -0400
Received: from mail-eopbgr10042.outbound.protection.outlook.com ([40.107.1.42]:19479
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233773AbhFQQKQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDEwCnJ2askiq7rKC6mTrnhxXsQxKCXT+wsuD8fyfULx0IwaAr4XWdYLWvSdMb3tkUKj4sjFyqnasYLSuS6c2XOp/8NqNKAd164inVl6mO+LoFZ95A+nIrJOhv1bjbWbFxogRIZj49dLFYUKsL9faWrKIBw43Yd/xk/XsYq9/IzJt3KvS2Awj3/x5BNBV/pgwTTN4sdkCRKrQbwofsc9a5CeXd7fOs77cIA8Ylj4sZ/xW0LURA4Qv6qZHULtuAZdYNI3KiFiUBDFndCxpwVZ1+zuT+a+7xQcKCwYEJsdIW6d9wnQqDptAydL4R/jLJAjwnUJVLu5MOoa19qbkjDnVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLhnEA4L5RlebqXIgs2oB4ZkahhKHLgyzP0HPMg3FKM=;
 b=l2R5ddwQ+tD+HMVXoxI3PfY8N3WW2WHDIFtMQm5TWYNhNnHQQz3Htvo4GlPHvOpjjlfAlF4vAU2aUAvIiQCE9hLu88YE7yDPAiiOuqLkmXhE3oYDpzdro0YKAcDwRWcECV1cU1F21L7YvHPevhAWCVCWfOZBvyvafNUfial1t7T/kFIeECHWcCpFgGtfbPJovQbEtGXAxNYjVFY6HJYezXl8BYvZx3wJro8wKCh/EFesTPJdMaz7inw6hu3f443meTNEW8L78FnnxKF2hrV0UZRcQQ570tKCNgUK+vaqrEfeAXRSv2Oxys/YTYBin/NsAgNdmlFJBsg5tvVrD+3TeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLhnEA4L5RlebqXIgs2oB4ZkahhKHLgyzP0HPMg3FKM=;
 b=O4MwLOIrQ2D2AOiuuUfEpHasRY2JcrE8w66c0VD3wecQfwwA/B2K+CQGwd+rHNomkWW1aY6imJLGwxhLi2knaqA5HGM9Zj6dmLqJZOYanEe4OaPmlQqQA8yunKvYenkJYK4atBfgqvSs2rOLPnvAJm8qlVKEiW5lfR1GcLkdDAE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0515.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:07:57 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:57 +0000
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
Subject: [RFC v1 230/256] cl8k: add utils/utils.h
Date:   Thu, 17 Jun 2021 16:01:57 +0000
Message-Id: <20210617160223.160998-231-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25058e7f-a25f-45c4-712b-08d931a9eae3
X-MS-TrafficTypeDiagnostic: AM0P192MB0515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB051572E7086D0AFEF39785F0F60E9@AM0P192MB0515.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:494;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AXyv/Pb3G7QKXuilVTpjoxgMzeLJHCuhG8BbrtajN42k5iKJcvHMx4xYjaz9ELhKDCL663W7T1TCNwMvREc7KSbg7OCYZ6oATVL854TnmdJlVPXSF8Fe4pneiRBt166sRlYF58PvXWb4gv7j61GKe8stwDQBqVmV+T8fxC2Pe6MQ9p+S3qYg0O/n01tusn4JxHFBm4U3vosgfDWW03ObzI0zdb2fHmDcMY3fLGCfVH8WIPyTTpvBTMBCpYWsV5l9FrE9quJtxXwj4ZpHLS7htegVRc3ZINaBTn4JwoJalngOWQDzZNBlY/K7GCzHuptBaninlZ+bS2tv/GNdO5Tl6nFws1AkJ9xKBAtayXIWbuzSZeJ12XcdXit1epwET0HKRhgnRTp2ODmbctw/kZvJ1KuCZNVgZBNqQ9q1wjwd7Wl/MWJ8+udjUsHcCkjVt7c/WGJP9PP0o2fjNZLwsT9IoYq84Q96yotXufmI1Dux8QtnzOIXznc9QSbE9L6n74vzJLNbaNq118QqPWrfpl4F+GwaR5uoy+QBwJRz0MwqvUaQe3rFUZzH95r7cwdEnR6MX8BCRlFxq+/DsM+kHH9aYCi6/HAvCtJAHLdTqFrzg1w35Tu6DSasZMlAHNswsvE2Eav3owpiYyAQ+k5Gg6Z1t/q/Zo6CqdsqhMTbtmHzCNNzrihdCLF+23rnZToZtmiy7mTxDs9IL6SNdJUKsOUhKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(376002)(39850400004)(136003)(366004)(346002)(4326008)(16526019)(83380400001)(1076003)(8676002)(9686003)(55236004)(36756003)(478600001)(8936002)(956004)(186003)(6486002)(38350700002)(6512007)(6916009)(52116002)(86362001)(5660300002)(2906002)(38100700002)(66946007)(2616005)(316002)(6506007)(26005)(54906003)(66476007)(107886003)(66556008)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bxjZGJl1sdNH0ZecczDb9NmQPBwNM3zO02RBTgTvLcVy3PyAWvANQPgt4Rrt?=
 =?us-ascii?Q?+Qsy5Y905hgksBZl16ezhgeWXeOHNXThE+CZkpnnlXZEGMziaKpcLUwsuo27?=
 =?us-ascii?Q?Ln0JAstGMNZm0SHgqMZ77GAHmmjEW2+Oklf+jRDwAeT2G42m07TwJgmUaYJ3?=
 =?us-ascii?Q?vW4dwFgpExUmmWPNjKR6p9BVX3jHBEJ6yMyox99MFZij07oK+P2Pq4UXFFlG?=
 =?us-ascii?Q?vdUJa+QZuQD8Ie4aBF/bJ/1wSAM52up96LQJ61OmfVT8vcZXleld1937s1Mb?=
 =?us-ascii?Q?liWgtOMJ11BusVJ+nPV9Zo2J95PlfRoMlirNCB9TIElCbok34dbJyxkhbnB6?=
 =?us-ascii?Q?Y5ABoF0NP3Uipi/cwBvWuuFcNo+WTLZbT84bgzDfqGxV92E3Zq2RbNzauwJ0?=
 =?us-ascii?Q?UU2j4dWKfjwN8BQ086E8/IjRMC6LLBGrfT6r8nAjDqfkxJbff7N9bw6FlLdS?=
 =?us-ascii?Q?ixzc1xkRaqf/6lCwacXLtB3CI4PolJgcDJgIR5ZHj9dw5Cy8zfocUllvFop3?=
 =?us-ascii?Q?R8QQ7/bWa0FlOInUawK1iiYk405qd2LyIx9hHC3Lt2APyIrLuI9QTvIfG7zW?=
 =?us-ascii?Q?1QMf9KRh5Kf89fK1/6gEI0/Uvy88OblSbW9jhmzdpnPrMQXmv49U8W8tMdZs?=
 =?us-ascii?Q?1O7RceKNlv3V0IyRM/S3JE1IAiVYzEdUtrpC01XEr3GpcpaX07XAozfCbiBI?=
 =?us-ascii?Q?CCyolovQb5FJDN6mlLQl1tl9cLQuqzzaRkbX67NTXVHoKosaKv50CoDi7eK9?=
 =?us-ascii?Q?wZf/O1TheIOx0ovNePl+MmcHKSlHDiwTvP0s56Um6SYqs90OT5w461LCWOrj?=
 =?us-ascii?Q?UMDxaWFIUUuMK+vk/YqrnmuPquHn3zqUPHPRC83GBdsQpRBG2Ig0j/S/s3VV?=
 =?us-ascii?Q?LiOAFRtzgWy73Sq5cYedYAO9TxBL72ny7EaQPsPQWSpOXHSBWyhWP8xYi6uW?=
 =?us-ascii?Q?a3swSkoBQBEbtmpG7KlH9i3/aqNozD6ex+X3JilIMzhdS2SY1rCRr/3gtPS+?=
 =?us-ascii?Q?jYtSC2EBccBbjhqfDx3OvnwqoU+VBBAx55MXNNaFvQy86wIYLUUIy2L8Kdm7?=
 =?us-ascii?Q?HfwyAJJWLqwQaJhAGKrGPZF11e47RaRaj+ic2uSFXjRRBeIyVyaT7iHTPcb1?=
 =?us-ascii?Q?dDxxXJp84HyTtrAOxfnceSy0jOUKtahXPG5T7NHll2gFljDrxbICdAWFcQ6e?=
 =?us-ascii?Q?WtiAbvVfBtBnrOG0xGTU3u1yoiQwmyGZWmgMPiC5d5HrM+vNpsKpC0vg86JY?=
 =?us-ascii?Q?67GdTbsQuDpK6PGOOOQcAusz2SFWMFla0ZruoMSMlo5zHaNakVdeyIPnnwS/?=
 =?us-ascii?Q?HsHMQ0t/4wARoyq/nbPx5o+n?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25058e7f-a25f-45c4-712b-08d931a9eae3
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:51.0898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CW8ZOaSiGSvnG5ts4c9+lBcMR2adl/N8Md+BcU1c2hhVUls/RvTda5OB7i7eHXS0q95rRC4AruhDnSq9bi+sFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0515
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/utils/utils.h    | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils/utils.h

diff --git a/drivers/net/wireless/celeno/cl8k/utils/utils.h b/drivers/net/w=
ireless/celeno/cl8k/utils/utils.h
new file mode 100644
index 000000000000..d08cb23513ef
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/utils/utils.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_UTILS_H
+#define CL_UTILS_H
+
+#include "hw.h"
+#include "vendor_cmd.h"
+#include "vif.h"
+#include "ipc_shared.h"
+#include "ieee80211_i.h"
+
+static const u8 tid_to_ac[] =3D {
+       AC_BE, AC_BK, AC_BK, AC_BE, AC_VI, AC_VI, AC_VO, AC_VO
+};
+
+static inline struct cl_vif *NETDEV_TO_CL_VIF(struct net_device *dev)
+{
+       struct ieee80211_sub_if_data *sdata =3D netdev_priv(dev);
+
+       return (struct cl_vif *)(sdata->vif.drv_priv);
+}
+
+static inline struct cl_hw *NETDEV_TO_CL_HW(struct net_device *dev)
+{
+       struct ieee80211_sub_if_data *sdata =3D netdev_priv(dev);
+
+       return sdata->local->hw.priv;
+}
+
+static inline struct cl_hw *WIPHY_TO_CL_HW(struct wiphy *wiphy)
+{
+       struct ieee80211_hw *hw =3D wiphy_to_ieee80211_hw(wiphy);
+
+       return (struct cl_hw *)hw->priv;
+}
+
+void cl_hex_dump(char *caption, u8 *buffer, u32 length, u32 offset, bool i=
s_byte);
+
+bool cl_is_valid_auth_mode(bool wpa_ie, u8 auth_mode);
+bool cl_is_open_auth_mode(u8 auth_mode);
+u8 convert_gi_format_wrs_to_fw(u8 wrs_mode, u8 gi);
+u8 convert_gi_format_fw_to_wrs(u8 format_mode, u8 gi);
+u8 cl_map_gi_to_ltf(u8 mode, u8 gi);
+
+s8 cl_calc_noise_floor(struct cl_hw *cl_hw, const s8 *reg_noise_floor);
+
+u8 cl_convert_signed_to_reg_value(s8 val);
+
+u8 width_to_bw(enum nl80211_chan_width width);
+enum nl80211_chan_width bw_to_width(u8 bw);
+u64 cl_get_tsf_u64(struct cl_hw *cl_hw);
+
+u8 cl_center_freq_offset(u8 bw);
+
+u8 max_bw_idx(u8 wrs_mode, bool is_24g);
+
+bool cl_hw_mode_is_b_or_bg(struct cl_hw *cl_hw);
+
+void cl_snprintf(char **buf, int *offset, size_t *size, const char *fmt, .=
..);
+
+bool cl_is_eapol(struct sk_buff *skb);
+
+static inline bool cl_are_host_bytes_le(void)
+{
+#ifdef __LITTLE_ENDIAN
+       return true;
+#else
+       return false;
+#endif /* __LITTLE_ENDIAN */
+}
+
+/* Most likely, bit endianess is the same as the byte endianess, but turn =
on
+ * paranoid mode and check separately */
+static inline bool cl_are_host_bits_le(void)
+{
+#ifdef __LITTLE_ENDIAN_BITFIELD
+       return true;
+#else
+       return false;
+#endif /* __LITTLE_ENDIAN_BITFIELD */
+}
+
+/* We could inverse *_le checks here, but the motivation is the, as per bi=
ts
+ * endianess - anyway, it is better to check */
+static inline bool cl_are_host_bytes_be(void)
+{
+#ifdef __BIG_ENDIAN
+       return true;
+#else
+       return false;
+#endif /* __BIG_ENDIAN */
+}
+
+static inline bool cl_are_host_bits_be(void)
+{
+#ifdef __BIG_ENDIAN_BITFIELD
+       return true;
+#else
+       return false;
+#endif /* __BIG_ENDIAN_BITFIELD */
+}
+
+#endif /* CL_UTILS_H */
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

