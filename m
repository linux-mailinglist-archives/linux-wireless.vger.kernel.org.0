Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D833AB881
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbhFQQI1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:27 -0400
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:59110
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232763AbhFQQHk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdZL4U5w6z1GSw6AwTx/YpBI0vwJq7b0Nnfz8VGwSNgbLJQva6IYWyj8h2Yo5T/e46kt8rLoWkLanqQf1BXiSO/phyZye5KoZYLWC4AZr5YR2ty8BgMrqPqOHQbghfDIC6JBicien69lTUU5hAcP4QJJTI1H1Kqssj5pRos7TZI+mDOCr16RO7pRZjMI/ALkuqKFE8abTxHCtYe9qvoiy7ceYzHtCOC4VK8BbjlqfA37gl6Leo54wk1hVI7r561u+UgLAaK3cOKdLdMx3fc0EFJxUjvsMb7+Qwz8UK2ppQDvzMBhom80vr89AcXaVZWd3J5ms/PQZkjco1EGWB3jsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDPcTGkgjZ/7KyDrrTJVnby4E12bUMw2sggUPvQe0lY=;
 b=SywRGzb008VKO9u/VSYzDrBmFm5Ia6M2DPwisOWX/6CcOZg0SKNCwO94mHubHHyIqueioZOzcpojgXU0O8/26qaQktiTB3Exv2Yn+GA+vfwqv487Muhbdg7IBOs+1UUM1Jx+CZsMh59KGtlXBuyYup45CjCjoIBW7jpATswOTpuKaSVyUC0T8wNbfJyG3npHEDozSA9WOUcNQ4V/fp7PKBswFnoaHStJDEjYc8T3x18heorKww5t7g+vGi5I7P30cfZhM2UdOjGz3lKvIKj8kHBqBlCrAJ24oiUu4AQFHj5QMTCoFjvX5jaKS8PrVJNe6ZJ7R/1HYd2Mk8/dnMVpQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDPcTGkgjZ/7KyDrrTJVnby4E12bUMw2sggUPvQe0lY=;
 b=zRPNzT+ilYYJWEIOg/s13LHbmA59O5teWPQAK8/yR3bmeP2CC7BbYfufTVHiN6zJg+riUPRfBAA3vnWppkWAddtIPoCHKoLUsji3eiTUcRrLGiqEMf+pc9S5dmqfDhro5uDZa1PD4ya4UpIHS879PTLwZCHlZjfKvk3NJFYNI6Q=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0887.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:02 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:02 +0000
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
Subject: [RFC v1 097/256] cl8k: add fw/msg_tx.h
Date:   Thu, 17 Jun 2021 15:59:44 +0000
Message-Id: <20210617160223.160998-98-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df71d5ff-5c33-49fc-88ae-08d931a9919d
X-MS-TrafficTypeDiagnostic: AM9P192MB0887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB08871EFD7C1C5F2C7D66E80CF60E9@AM9P192MB0887.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hLnLzl6BbHr+18VIK2fA5jmhggUC3oLxhMpIk2QW8G0GLQ68TLzjY8h7HXhCVzUfTLmGUevJZrNdjQvDVl9r2gHq6nPOEAGiJo2PgV5nzX5xkzY9hTyAV4yCk9yCJWk+gs2p+VvWnAaIYq3Q3BudUQAopwrepZsPKQxOyatKk7+vQzl+7fNmUIEZPSi/2Jr5mqRG5WAwb209ENUJ0/23Z5uJ5IRNnSleUz1OGRoS1ji36BFfVRPYvDjQK30syPKnLU92BtkCVZxhUz2pi+mqAjstnwOGC9xYnTTLSIL8p/kxiZHZlGpyNIqYFqkmZit1Vi79BnCVxM39ScXPK3ra3n4jU2gH7dC85K2UfgtcElzpd51oi1DVbVHj2mnhH5KFUTsKYoXYyH0u1p/P1rYKrcn4lEmoCCNAt/N3izwf75e0OS1kULbd30q+xyo5V0rOPMjcIMiIRo4+thQ6XDz8rL9xT5w+BWPuapuYmKlKy85s2ldeb1i14mv90uyGMVwNzg35X9OWKhWpVDg86GScHWOArJqdoSmD95v45Zew1x/DFR6un5owD+zPWJGTzMRzrsk4YtUqf4v4ipiPMI9EMmrc1Pp/+L/eU/7gXXVNBksO1ejTPkj7VNQgI+/+witfBoGyZUOLG4aH+hW7iNGzA0QgTlHSfT1gt79F6JNWoqLeP1dj7cI8wLeOqnA+kSnzZ4e9dp4NsOKko21KdXrz8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(39850400004)(136003)(346002)(83380400001)(6666004)(38350700002)(4326008)(186003)(16526019)(5660300002)(54906003)(6506007)(26005)(55236004)(38100700002)(316002)(1076003)(107886003)(52116002)(8936002)(508600001)(66476007)(66946007)(66556008)(36756003)(6916009)(6486002)(86362001)(2616005)(956004)(2906002)(8676002)(9686003)(6512007)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TEf1mp5MPHqDDEz+AcS64+tDoqSwC7VkTGj/tnJ2J69bfmLQOpSvjZF8UBfK?=
 =?us-ascii?Q?LrK9an81QAmy0WkMs2KIyWxIPHlbPOOR4sG7tX0PMDTTUEkZYLzQkdtYauhl?=
 =?us-ascii?Q?cXLxQ1sCMkm6n6CxBlEoqsDRIFZhEyIYd+YmoR0TEeAOgUK3xpS7w0su9QTQ?=
 =?us-ascii?Q?0mQL0+rbF+LWvUoDw8bZuH0mdjvzRhuqi7YW5Ot2llNgpYu4UOUSr2jvgreQ?=
 =?us-ascii?Q?aUoF4YZPYeHlx8fQIQziV3eC5SWl2YazyDAQV1MaFzYiqT95cE9f6wFofc9w?=
 =?us-ascii?Q?LMR0fZ2pzpZ/fpQiDo6YWlkI2Rh5CPmiWnbgEB474xDPwupvAIjy6jvgO8wN?=
 =?us-ascii?Q?Y2C8Jo3ZtgHbqeFRq61fJ26Ska2SABrfhZXnDCkS4GIJ3kQUPTowTn5c+ssW?=
 =?us-ascii?Q?RL579TlNd/GTSmykaHc3GYox3Mc31trlV0dtYve4+YRO4Fc41yUMqiYopgkf?=
 =?us-ascii?Q?qhQGyQvnVz0IXjh3Lyyx2e7oK8jD5tVkPgyxFa5WC5qInuurnhYeYcswatsK?=
 =?us-ascii?Q?KsubgpoYz3OFF+jkuZpej4BtNJU/tA0o//0UAhrkrOvIPTXwrO2tYEQ/rSgM?=
 =?us-ascii?Q?jBpUfIKChEBpGzkyV2N2sJn1S4axoO0avjmsrPwNI8apHMDy27bfMkv1hn3g?=
 =?us-ascii?Q?vCHQBzOHwS7Mwg9oEP17o1QCZkoSaBVYjT6o9cLWFoPSBF4vFosV8x28KWwr?=
 =?us-ascii?Q?yOKP1UPusmT9EUoSTj9QTi3KMKdHc2XZ2+T3wRk2JZPLEOOP3fFeFeF9TNVp?=
 =?us-ascii?Q?LMYnX4AD7Apq3pfSHNfhPiftFF+kKKa44rI13JegM+myaY016gh073ctX2U+?=
 =?us-ascii?Q?d52xV0Q5qTIZofz2P/WqKbowW4EiphY5RYtBoPokRaCR3p9opAmLUqdd346X?=
 =?us-ascii?Q?tfNf9Hippk9M8bJEN2X9X4TU7HHECJz0sC851BEsJvk0EKYU+3PWMxH8J1pW?=
 =?us-ascii?Q?6DbZRUkyI4Fh28nbCZKnuF0r0EEMx3Kbj/LGm/5+XJvqV2C1lZhQBPZrhotz?=
 =?us-ascii?Q?nLTgcbhcMdQBFANI4in7uJRytB4PXDts6fHGd9uDr1511Cfwl9JzWLDCJJeR?=
 =?us-ascii?Q?7m1jaHAXUZGD3iZLHEhy85dMSTgLdxOccWfDySqKNnO/p+8DetP7YbzsFG/Q?=
 =?us-ascii?Q?vMQZCJ3xxNXLOS7PO29fhZ6C282AulB/2W/8KsK0IwAHDqTaCYkPNZZJVw/H?=
 =?us-ascii?Q?nemr28x+qyKKSDekb7cnEBXoDBxLSe+iah/QRpQC/LSh5nt5xeKovknBviJG?=
 =?us-ascii?Q?MvojTg1nI1drNsiZ9qxLtDzsw65pr1vjupFv3VS1+ybohzDinnVKlo261aX+?=
 =?us-ascii?Q?VObsmerdjxnDFIyGEpt/4P0L?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df71d5ff-5c33-49fc-88ae-08d931a9919d
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:21.3622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qF6Jsb3V5bU7EcIonEBxvaDtNL43ee/RdTuGNcrU/iBLfV37R3pXbLSINrlFhlt4ST+tDX+4a7pMNbl2GkAfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0887
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/fw/msg_tx.h | 141 +++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw/msg_tx.h

diff --git a/drivers/net/wireless/celeno/cl8k/fw/msg_tx.h b/drivers/net/wir=
eless/celeno/cl8k/fw/msg_tx.h
new file mode 100644
index 000000000000..c82ccc1752aa
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/fw/msg_tx.h
@@ -0,0 +1,141 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_MSG_TX_H
+#define CL_MSG_TX_H
+
+#include "hw.h"
+#include "vif.h"
+
+#define FREQUENCY_INT_MASK 0xfffc
+#define FREQUENCY_FRAC_MASK 0x0003
+#define FREQUENCY_COMP_INT_MASK ~FREQUENCY_FRAC_MASK
+#define FREQUENCY_INT_SHIFT 2
+#define FREQUENCY_FRAC_RESOLUTION 25
+
+#define GET_FREQ_INT(freq) (((freq) & FREQUENCY_INT_MASK) >> FREQUENCY_INT=
_SHIFT)
+#define GET_FREQ_FRAC(freq) (((freq) & FREQUENCY_FRAC_MASK) * FREQUENCY_FR=
AC_RESOLUTION)
+#define GET_FREQ_COMP_INT(freq) ((abs(freq) & FREQUENCY_COMP_INT_MASK) >> =
FREQUENCY_INT_SHIFT)
+#define GET_FREQ_COMP_FRAC(freq) ((abs(freq) & FREQUENCY_FRAC_MASK) * FREQ=
UENCY_FRAC_RESOLUTION)
+#define GET_FREQ_SIGN(freq) (((freq) > 0) ? "" : "-")
+
+enum ke_kern_tag {
+       KERN_HOST,
+       KERN_LMAC,
+       KERN_UMAC,
+       KERN_SMAC,
+
+       KERN_MAX,
+};
+
+#define SET_CHANNEL_MODE_OPERETIONAL  0x01
+#define SET_CHANNEL_MODE_CALIB_DCOC   0x02
+#define SET_CHANNEL_MODE_CALIB_IQ     0x04
+#define SET_CHANNEL_MODE_CALIB_LOLC   0x08
+#define SET_CHANNEL_MODE_CALIB        (SET_CHANNEL_MODE_CALIB_DCOC | \
+                                      SET_CHANNEL_MODE_CALIB_IQ | \
+                                      SET_CHANNEL_MODE_CALIB_LOLC)
+
+/*
+ * confirmation call back params
+ * @err: general msg transmitting error
+ * @param: pointer to lower layer feedback param (FW layer)
+ */
+struct cl_msg_cfm_cb_param {
+       int err;
+       void *param; /* Pointer to msg cfm param, the caller should be awar=
e to that type */
+};
+
+/*
+ * call back function definition, associate with all backgrounf triggered =
messages
+ * if caller intersting in message done feedback it must declare function =
of this type!
+ */
+typedef void (*cl_msg_cfm_cb_func)(struct cl_msg_cfm_cb_param *p_cfm_cb_pa=
ram, u32 token);
+
+void cl_msg_tx_free_cfm_params(struct cl_hw *cl_hw, u16 id);
+
+int cl_msg_tx_reset(struct cl_hw *cl_hw);
+int cl_msg_tx_start(struct cl_hw *cl_hw);
+int cl_msg_tx_version(struct cl_hw *cl_hw);
+int cl_msg_tx_add_if(struct cl_hw *cl_hw, struct ieee80211_vif *vif, u8 vi=
f_index);
+int cl_msg_tx_remove_if(struct cl_hw *cl_hw, u8 vif_index);
+int cl_msg_tx_sta_add(struct cl_hw *cl_hw, struct ieee80211_sta *sta, stru=
ct cl_vif *cl_vif,
+                     u8 recovery_sta_idx, u32 rate_ctrl_info);
+int cl_msg_tx_sta_del(struct cl_hw *cl_hw, u8 sta_idx);
+int cl_msg_tx_set_filter(struct cl_hw *cl_hw, u32 filter, bool force);
+int cl_msg_tx_set_channel(struct cl_hw *cl_hw, u32 channel, u8 bw, u32 pri=
mary, u32 center);
+int _cl_msg_tx_set_channel(struct cl_hw *cl_hw, u32 channel, u8 bw, u32 pr=
imary,
+                          u32 center, u8 mode);
+int cl_msg_tx_dtim(struct cl_hw *cl_hw, u8 dtim_period);
+int cl_msg_tx_set_beacon_int(struct cl_hw *cl_hw, u16 beacon_int, u8 vif_i=
dx);
+int cl_msg_tx_set_basic_rates(struct cl_hw *cl_hw, u32 basic_rates);
+int cl_msg_tx_set_bssid(struct cl_hw *cl_hw, const u8 *bssid, u8 vif_idx);
+int cl_msg_tx_set_edca(struct cl_hw *cl_hw, u8 hw_queue, u32 param,
+                      struct ieee80211_he_mu_edca_param_ac_rec *mu_edca);
+int cl_msg_tx_set_associated(struct cl_hw *cl_hw,
+                            struct ieee80211_bss_conf *bss_conf);
+int cl_msg_tx_set_slottime(struct cl_hw *cl_hw, bool use_short_slot);
+int cl_msg_tx_set_idle(struct cl_hw *cl_hw, u8 idle);
+void cl_msg_tx_idle_async(struct cl_hw *cl_hw);
+int cl_msg_tx_key_add(struct cl_hw *cl_hw, struct ieee80211_vif *vif, stru=
ct ieee80211_sta *sta,
+                     struct ieee80211_key_conf *key_conf, u8 cipher_suite)=
;
+int cl_msg_tx_key_del(struct cl_hw *cl_hw, u8 hw_key_idx);
+int cl_msg_tx_ba_add(struct cl_hw *cl_hw, u8 type, u8 sta_idx, u16 tid, u1=
6 bufsz, u16 ssn);
+int cl_msg_tx_ba_del(struct cl_hw *cl_hw, u8 sta_idx, u16 tid);
+int cl_msg_tx_phy_reset(struct cl_hw *cl_hw);
+int cl_msg_tx_available_ba_txq(struct cl_hw *cl_hw, u8 sta_idx, u16 tid);
+int cl_msg_tx_update_rate_dl(struct cl_hw *cl_hw, u8 sta_idx, u32 rate, u3=
2 rate_fallback,
+                            u8 req_bw_tx, u8 op_mode, u8 ltf, u8 ltf_fallb=
ack, u32 rate_he);
+int cl_msg_tx_set_vns(struct cl_hw *cl_hw, u8 sta_idx, u8 is_vns);
+int cl_msg_tx_set_tx_bf(struct cl_hw *cl_hw, u8 sta_idx, u8 is_on, u8 is_o=
n_fallback);
+int cl_msg_tx_sounding(struct cl_hw *cl_hw,
+                      struct mm_sounding_req *sounding_req);
+int cl_msg_tx_sounding_pairing(struct cl_hw *cl_hw, u8 sounding_id, u8 sou=
nding_type,
+                              u8 gid, u8 sta_idx);
+int cl_msg_tx_sounding_interval(struct cl_hw *cl_hw, u16 interval, u16 lif=
etime,
+                               u8 sounding_type, u8 sta_idx);
+int cl_msg_tx_config_cca(struct cl_hw *cl_hw, bool enable);
+int cl_msg_tx_set_dfs(struct cl_hw *cl_hw, bool enable, u8 standard,
+                     u8 initial_gain, u8 agc_cd_th);
+int cl_msg_tx_set_ant_bitmap(struct cl_hw *cl_hw, u8 bitmap);
+int cl_msg_tx_ndp_tx_control(struct cl_hw *cl_hw, u8 chain_mask, u8 bw, u8=
 format, u8 num_ltf);
+int cl_msg_tx_reg_write(struct cl_hw *cl_hw, u32 address, u32 value, u32 m=
ask);
+int cl_msg_tx_prot_mode(struct cl_hw *cl_hw, u8 log_nav_en, u8 mode,
+                       u8 rate_format, u8 rate_mcs, u8 rate_pre_type);
+int cl_msg_tx_goto_power_reduction(struct cl_hw *cl_hw, u8 mode);
+int cl_msg_tx_backup_bcn_en(struct cl_hw *cl_hw, bool backup_bcn_en);
+int cl_msg_tx_start_periodic_tx_time(struct cl_hw *cl_hw, u16 periodic_tx_=
time_off,
+                                    u16 periodic_tx_time_on);
+int cl_msg_tx_anamon_read(struct cl_hw *cl_hw, u8 mode, u8 param1, u8 para=
m2);
+int cl_msg_tx_refresh_power(struct cl_hw *cl_hw);
+int cl_msg_tx_set_ant_pwr_offset(struct cl_hw *cl_hw, s8 pwr_offset[MAX_AN=
TENNAS]);
+int cl_msg_tx_set_rate_fallback(struct cl_hw *cl_hw);
+int cl_msg_tx_twt_setup(struct cl_hw *cl_hw, struct mm_twt_setup_req *para=
ms);
+int cl_msg_tx_twt_teardown(struct cl_hw *cl_hw, struct mm_twt_teardown_req=
 *params);
+int cl_msg_tx_rsrc_mgmt_traffic_event(struct cl_hw *cl_hw, u8 event_type,
+                                     enum cl_traffic_level level,
+                                     enum cl_traffic_direction direction,
+                                     u8 active_sta_cnt);
+int cl_msg_tx_rsrc_mgmt_rates_event(struct cl_hw *cl_hw, u8 event_type,
+                                   struct cl_sta *cl_sta);
+int cl_msg_tx_set_freq_offset(struct cl_hw *cl_hw, u16 val);
+
+/* Debug messages */
+int cl_msg_tx_dbg_set_mod_filter(struct cl_hw *cl_hw, u32 filter);
+int cl_msg_tx_dbg_set_ce_mod_filter(struct cl_hw *cl_hw, u32 filter);
+int cl_msg_tx_dbg_set_sev_filter(struct cl_hw *cl_hw, u32 filter);
+int cl_msg_tx_dbg_beamforming_tx(struct cl_hw *cl_hw, u32 param32);
+int cl_msg_tx_dbg_get_e2w_stats(struct cl_hw *cl_hw, bool clear);
+int cl_msg_tx_dbg_set_la_mpif_mask(struct cl_hw *cl_hw, u32 mask);
+int cl_msg_tx_dbg_set_la_trig_point(struct cl_hw *cl_hw, u32 trigger_point=
);
+int cl_msg_tx_dbg_set_la_mpif_debug_mode(struct cl_hw *cl_hw, u8 mode);
+int cl_msg_tx_dbg_set_la_trig_rule(struct cl_hw *cl_hw, u8 idx, bool enabl=
e, u32 address,
+                                  u8 oper, u32 value, u32 mask, u32 durati=
on);
+int cl_msg_tx_dbg_tx_trace_debug_flag(struct cl_hw *cl_hw, u32 bitmap, u8 =
w_r_cmd);
+int cl_msg_tx_dbg_print_stats(struct cl_hw *cl_hw, u32 command,
+                             u32 param0, u32 param1, u32 param2, u32 param=
3);
+int cl_msg_tx_dbg_trigger(struct cl_hw *cl_hw, char *msg);
+int cl_msg_tx_dbg_test_mode(struct cl_hw *cl_hw, u32 *params);
+int cl_msg_tx_dbg_sounding_cmd(struct cl_hw *cl_hw, struct dbg_sounding_cm=
d_param *params);
+
+#endif /* CL_MSG_TX_H */
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

