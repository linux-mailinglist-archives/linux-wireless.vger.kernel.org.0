Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C213AB93B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhFQQNp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:45 -0400
Received: from mail-eopbgr80087.outbound.protection.outlook.com ([40.107.8.87]:53468
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233934AbhFQQMl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:12:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVrqI2fZUIDTiuK8UwjQI4hAtcuzNH8REK4qPeE4cLbzHvxcnK/zLH5otAwIIbaCL2DuoqSI0p5zZ5/430ICvqXvzZy1rP0w1jqvM37F1ZgriPebpNutA5a6V3mbluLYVYDrPCSMuwzyv1eD3sqqdTrT6JPsT/IJbYimGxXuK5FqJ2v9rpbsGE/agLuajFRmiFU5i0wAg/Y96F9/6gsWE1TlLT7mlk1suDK0nXigHZUmj2RY3ye3M5TkSbFYBTczF5g3ZHyPyP1HSbWAMxFTUaf1d0Y4k7znUoywCSiiOruStosED6nAmzJES6FKYoFjqVYc2XL6iSdrVBJkHUD/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfsbsRirTSgiRniMBPZFD052rtYYy5z6micGB9z1TkY=;
 b=kYvopriRlWwdCsN886a6zf4v6usnQ1nZdRkKxyylPc4LMqoZsotg2Rp0iIWAM08HsvNHwub+d0Y/ClR1kupPl9VP/9/uJHrTlD/RJK2uNJghqNS5Ow+ONqHYdi107KxRqcq6j8jhJbGCcm2PS6sqACRn2RVDxfb+SUyE9b4cWVxG9wHCblzXlBMGb4266yQzmEKuUqzWlEN5Kjj9QXHfWSrfjAAoDbrUKpXx+FbcJGF+k1xKWJNxhqCFxch3ulpqGF0UF/iS7q/HnMDKT3uW+yTrRtrjxms4mMdCTsWuL0859ZXHy5i24PMn40XMwe42XIsY1s8z4GmAMMZGUhsALA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfsbsRirTSgiRniMBPZFD052rtYYy5z6micGB9z1TkY=;
 b=dERb1knIoFoELaAdNPMwKNBNvT7xx8H61fOrUq8NMyV/1aWDMgCt+Ey24iY27PsHjQHiSJ5vCaM2J9xqjGH9/SS5q4d4PbGYmaRX8W+jGel6q2e00Uy957m+YoMsuiecrciSeJaGKZr2z5xNB4WqoB2MltvQFOPfDUbEnvor6ec=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0260.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:47::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 17 Jun
 2021 16:07:10 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:10 +0000
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
Subject: [RFC v1 186/256] cl8k: add tcv_config.c
Date:   Thu, 17 Jun 2021 16:01:13 +0000
Message-Id: <20210617160223.160998-187-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b8d2953-bc56-405d-f0ec-08d931a9cc80
X-MS-TrafficTypeDiagnostic: AM0P192MB0260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0260869A8B994D9DDCA93558F60E9@AM0P192MB0260.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MHH+bpAZwzfW3JeJBY3O3CMQPq02ukS7jUDgWpCdMwWpTofv/UdKbtOpYBBG1wf10rJjA2ahbRCGFBU+1DIG2QVIJOzndocw3GLgkYlHv1AUGioqo6ABOp1k7Jr5q2Wyx130Y1JqAVqo2HWtlPrMwgFjN6GLrsdRn7oJUoMC2q6gxC+0o3B4Gkg1goNEXNkXQqeepfiteYo0xWxm66z/gn7se200tuoLz6la31ircoBlL8gc3S29SYgxyf/8O3nbN0C1SzbWYNZ49S+QTneHngcihrRZsOObt8jvIEAauZIATjuNqmRfk1cfYdlsE2MY/K3DDjB2/1Vn/TVZrYHkI5Hm392vvfUMakXXmLoecPpD80u/baaFL+v7liCi8/vk3ivsFMx79mEO+R6JNl0GtPGN1sdun8AJoASf/z3JMklBvi7nFIaRnewZcjTqwo0pGSevk4PC8uA48TXDTCciTPO1LvYzNfHNm6PF1cmlzBhx3R5t/D1OeQaHES7AsLGrLOUL7wVrW0A8R9RS2ADdcttFvSlky9fqWEQnCYxPI7YrzEFOgubojziydUBHK+3F3nOT9ovb4lTJRVhwn/HPPPjkwteG8Q4xpk182zqTWyejLlQ8pUfFwXGwBpwMIVqQt7UEdo9qBZ203EWN4/F1E8BZUDXkV5rHV+d2Ki1LwLiGCOQ5e/Kh8dqv+VtYJAml2I2OwbWjQgHmp9GKGvC2pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(8936002)(86362001)(107886003)(4326008)(26005)(8676002)(956004)(186003)(6666004)(2906002)(6512007)(66556008)(2616005)(5660300002)(498600001)(38350700002)(54906003)(38100700002)(16526019)(66946007)(9686003)(83380400001)(55236004)(52116002)(66476007)(6486002)(6916009)(30864003)(6506007)(36756003)(1076003)(69590400013)(32563001)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U0i70d4mkkAbtObKEDlwxstYSemq66yWtV7RqiL9lfzPFgSbZ2p4DmWv5muO?=
 =?us-ascii?Q?mTJcFcnPXdk9YLV/ug4st/9J3XG6vKFDEDP5AspK8JzFFtsjwDRsnPo9Mt0j?=
 =?us-ascii?Q?OPQF2FH6BcKV85aWaa2zZdlwJKJZQpo4ehAwHnlBjIUNifU+n5i7UI57QvQb?=
 =?us-ascii?Q?LGqNLmpP7wYDK1EZfWa0FlCsO6nORpht/dbzk7y0BM0HZ+gUqJfExmuz6KJ9?=
 =?us-ascii?Q?iwrpjvq0TJgxUTGpXda/qWa5lXcEQY3K6VPCDCwrz1SZKr5wulwhizfyBZ0s?=
 =?us-ascii?Q?eK0jFkW3v91SinB4VeA+Iq19mrcxoLdU4vrTeNjeSMcQ32m/M8qUjs8YcTdH?=
 =?us-ascii?Q?QMI5ovkWnNLGzYyptAyvl/He5dBNoLMe/iWC0rwPIkTBtFnA2p9LdqtB0KzG?=
 =?us-ascii?Q?meSTvcZGP+HRssLyGq04LdTEO177zvg1ompyr7u72NDjXRBe4ufSH5mOH6Dc?=
 =?us-ascii?Q?n2vWVCgCzyEvdvybHWqCVQi/5MS2H8kzhWtrEb2TVg0xD6xeRJnjY2Y8DoqI?=
 =?us-ascii?Q?wa2RNlLivzcT/ulokQsN+/qjIi0wquxP2kUGNhXc/+jC6ETwuLip0A2954oJ?=
 =?us-ascii?Q?al+7/Nk1JMrAKjLzktnULxjelVuUrfiMlmyyYIo1wBpHNhu2praCqJay5EyF?=
 =?us-ascii?Q?n1AkmjuyAqPQa2uw3P6C+sEJhs04bj9gwAvJ0PWISE/5Gh+xracdciGbOamN?=
 =?us-ascii?Q?doN8RSkl/2SjDSRQ4A2AH3rktoGS1ikrQNvnGmg0co0yWgKGoag4NANj1gJK?=
 =?us-ascii?Q?Cnjzdqertl6d+5QAJjdmjPnBKTInEC/0y2akBoXAtXjtfJDjEWyLUNDeK9yp?=
 =?us-ascii?Q?+al33TwsM1BDpI7dDu8TzWX0GDBn9pIhpvNnjnFyRMIFCKFyJBT2XXUcYpdU?=
 =?us-ascii?Q?4ioqmtbh381ZSYjmXixU3giZgJyi55qphwjUCFSHMgnwdHihag5llHv1J14P?=
 =?us-ascii?Q?hT6bSkC9IkZLDrbvhSO0IeAdEonAyyAnVgZwfcrj/hf09VT+fj7PeaNRuzVv?=
 =?us-ascii?Q?m5LmXEfV94mMBzh2RJKJ69Hgk9VxnoMZs2/agTGAtONv5RdRcVYyyPPfHpPI?=
 =?us-ascii?Q?uHztI7Rm+7la4qlaOnY9vcjR9bdGp+1GeQQ25qKvNkOQoh3LORnm//3uNMup?=
 =?us-ascii?Q?wRL8CvF1H+YXpmIq+Fn1ttyzQKmcstkybd9rq4aZ3rzvDakVbl/YBZiorbsR?=
 =?us-ascii?Q?sFeVAWhpI+C/Ym3VphbBiZVQFgSHDYDAq/A6VBSlX9WjsOa7p16wnnQ2Ziug?=
 =?us-ascii?Q?7Np8+VX5VNgu87I0k+r+uFHYzJMgeen4G0xgLpMwEC2tokudEmoESi5EUrb1?=
 =?us-ascii?Q?2OKCNBQVndm42iDQle0E9gvP?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8d2953-bc56-405d-f0ec-08d931a9cc80
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:00.3058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uyPslcm0xKyIvlLr8nJ9UddaY715/VlkWthvf2iH3gI77DpK7AqKOWO5aNyxCzyFgDF55NQawQmQbFYF5arHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0260
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/tcv_config.c | 1463 +++++++++++++++++
 1 file changed, 1463 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tcv_config.c

diff --git a/drivers/net/wireless/celeno/cl8k/tcv_config.c b/drivers/net/wi=
reless/celeno/cl8k/tcv_config.c
new file mode 100644
index 000000000000..bb09ae332006
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tcv_config.c
@@ -0,0 +1,1463 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include <linux/slab.h>
+#include <linux/moduleparam.h>
+#include <linux/uaccess.h>
+#include "utils/file.h"
+#include "utils/utils.h"
+#include "prot_mode.h"
+#include "chip.h"
+#include "tx/tx_amsdu.h"
+#include "recovery.h"
+#include "band.h"
+#include "vns.h"
+#include "fw/msg_tx.h"
+#include "utils/string.h"
+#include "twt.h"
+#include "cap.h"
+#include "config.h"
+
+#define TX_BCN_PENDING_CHAIN_MIN_TIME 10 /* Usec */
+
+#define CL_MAX_NUM_OF_RETRY 15
+
+struct cl_tcv_conf conf =3D {
+       .ce_bss_num =3D 1,
+       .ce_debug_level =3D DBG_LVL_ERROR,
+       .ce_radio_on =3D true,
+       .ce_ps_ctrl_enabled =3D true,
+       .ha_channel =3D 0,
+       .ci_ieee80211w =3D false,
+       .ci_ieee80211h =3D false,
+       .ha_short_guard_interval =3D 1,
+       .ha_max_mpdu_len =3D IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991,
+       .ha_vht_max_ampdu_len_exp =3D IEEE80211_VHT_MAX_AMPDU_1024K,
+       .ha_beacon_int =3D 100,
+       .ce_dsp_code =3D "fwC.hex",
+       .ce_dsp_data =3D "fwD.hex",
+       .ce_dsp_external_data =3D "fwD.ext.hex",
+       .ce_uapsd_en =3D true,
+       .ci_eirp_regulatory_en =3D true,
+       .ci_agg_tx =3D true,
+       .ci_agg_rx =3D true,
+       .ce_txldpc_en =3D true,
+       .ce_ht_rxldpc_en =3D true,
+       .ce_vht_rxldpc_en =3D true,
+       .ce_he_rxldpc_en =3D true,
+       .ci_cs_required =3D false,
+       .ci_rx_sensitivity_prod =3D {
+               [0 ... MAX_ANTENNAS - 1] =3D -96,
+       },
+       .ci_rx_sensitivity_op =3D {
+               [0 ... MAX_ANTENNAS - 1] =3D -99,
+       },
+       .ce_cck_bcn_en =3D false,
+       .ci_min_he_en =3D false,
+       .ce_cck_tx_ant_mask =3D 0x1,
+       .ce_cck_rx_ant_mask =3D 0x1,
+       .ce_rx_nss =3D 4,
+       .ce_tx_nss =3D 4,
+       .ce_num_antennas =3D 4,
+       .ce_wireless_mode =3D WIRELESS_MODE_HT_VHT_HE,
+       .ha_wmm_enabled =3D {
+               [0 ... MAX_BSS_NUM - 1] =3D 1,
+       },
+       .ce_max_agg_size_tx =3D IEEE80211_MAX_AMPDU_BUF,
+       .ce_max_agg_size_rx =3D IEEE80211_MAX_AMPDU_BUF,
+       .ce_rxamsdu_en =3D true,
+       .ce_txamsdu_en =3D CL_AMSDU_TX_PAYLOAD_MAX,
+       .ci_tx_amsdu_min_data_rate =3D 26, /* 26Mbps (=3D BW 20, NSS 0, MCS=
 3, GI 0) */
+       .ci_tx_sw_amsdu_max_packets =3D 0,
+       .ci_tx_packet_limit =3D 5000,
+       .ci_tx_queue_size_agg =3D 500,
+       .ci_tx_queue_size_single =3D 50,
+       .ci_ipc_rxbuf_size =3D {
+               [CL_RX_BUF_RXM] =3D IPC_RXBUF_SIZE,
+               [CL_RX_BUF_FW] =3D IPC_RXBUF_SIZE
+       },
+       .ce_max_retry =3D 8,
+       .ce_short_retry_limit =3D 4,
+       .ce_long_retry_limit =3D 4,
+       .ci_assoc_auth_retry_limit =3D 0,
+       .ce_channel_bandwidth =3D 0,
+       .ce_iface_type =3D {
+               [0] =3D NL80211_IFTYPE_AP,
+               [1 ... MAX_BSS_NUM - 1] =3D NL80211_IFTYPE_UNSPECIFIED,
+       },
+       .ha_hw_mode =3D HW_MODE_A,
+       .ce_temp_comp_slope =3D 8,
+       .ci_fw_dbg_severity =3D CL_MACFW_DBG_SEV_WARNING,
+       .ci_fw_dbg_module =3D 0x0FFFFF,
+       .ci_hal_idle_to =3D CL_DEFAULT_HAL_IDLE_TIMEOUT,
+       .ci_tx_ac0_to =3D CL_TX_DEFAULT_AC0_TIMEOUT,
+       .ci_tx_ac1_to =3D CL_TX_DEFAULT_AC1_TIMEOUT,
+       .ci_tx_ac2_to =3D CL_TX_DEFAULT_AC2_TIMEOUT,
+       .ci_tx_ac3_to =3D CL_TX_DEFAULT_AC3_TIMEOUT,
+       .ci_tx_bcn_to =3D CL_TX_DEFAULT_BCN_TIMEOUT,
+       .ce_hardware_power_table =3D {0},
+       .ce_arr_gain =3D "0,3,4.75,6,7,7.75",
+       .ce_bf_gain_2_ant =3D "0",
+       .ce_bf_gain_3_ant =3D "0",
+       .ce_bf_gain_4_ant =3D "0",
+       .ce_bf_gain_5_ant =3D "0",
+       .ce_bf_gain_6_ant =3D "0",
+       .ce_ant_gain =3D "0",
+       .ce_ant_gain_36_64 =3D "0",
+       .ce_ant_gain_100_140 =3D "0",
+       .ce_ant_gain_149_165 =3D "0",
+       .ci_min_ant_pwr =3D "0",
+       .ci_bw_factor =3D "0,0,0,0",
+       .ce_mcast_rate =3D 0,
+       .ce_dyn_mcast_rate_en =3D false,
+       .ce_dyn_bcast_rate_en =3D false,
+       .ce_default_mcs_ofdm =3D 0,
+       .ce_default_mcs_cck =3D 0,
+       .ce_prot_log_nav_en =3D false,
+       .ce_prot_mode =3D TXL_PROT_RTS,
+       .ce_prot_rate_format =3D 1,
+       .ce_prot_rate_mcs =3D 4,
+       .ce_prot_rate_pre_type =3D 0,
+       .ce_bw_signaling_mode =3D 0,
+       .ci_dyn_cts_sta_thr =3D 2,
+       .ci_vns_pwr_limit =3D 0,
+       .ci_vns_pwr_mode =3D VNS_MODE_ALL,
+       .ci_vns_rssi_auto_resp_thr =3D -40,
+       .ci_vns_rssi_thr =3D -40,
+       .ci_vns_rssi_hys =3D 3,
+       .ci_vns_maintenance_time =3D 2000,
+       .ce_bcn_tx_path_min_time =3D 1000,
+       .ci_backup_bcn_en =3D true,
+       .ce_tx_txop_cut_en =3D true,
+       .ci_bcns_flushed_cnt_thr =3D 9,
+       .ci_phy_err_prevents_phy_dump =3D false,
+       .ci_tx_rx_delay =3D 0,
+       .ci_fw_assert_time_diff_sec =3D 5,
+       .ci_fw_assert_storm_detect_thd =3D 15,
+       .ce_hw_assert_time_max =3D CL_HW_ASSERT_TIME_MAX,
+       .ce_fw_watchdog_mode =3D FW_WD_INTERNAL_RECOVERY,
+       .ce_fw_watchdog_limit_count =3D 5,
+       .ce_fw_watchdog_limit_time =3D 30 * 1000, /* Msecs */
+       .ci_rx_remote_cpu_drv =3D -1,
+       .ci_rx_remote_cpu_mac =3D -1,
+       .ci_tx_remote_cpu =3D -1,
+       .ci_pending_queue_size =3D 500,
+       .ce_tx_power_control =3D 100,
+       .ce_standby_mode_en =3D false,
+       .ce_coex_en =3D false,
+       .ce_extension_channel =3D 1,
+       .ci_dfs_initial_gain =3D 77,
+       .ci_dfs_agc_cd_th =3D 48,
+       .ci_dfs_long_pulse_min =3D 100,
+       .ci_dfs_long_pulse_max =3D 5000,
+       .ce_dfs_tbl_overwrite =3D {0},
+       .ce_dfs_jump_channels =3D "36,40,44,48",
+       /* 6G */
+       .ce_ppmcs_offset_he_6g =3D {
+               [WRS_MCS_0] =3D PPMCS_DFLT_OFT_V3_MCS_0,
+               [WRS_MCS_1] =3D PPMCS_DFLT_OFT_V3_MCS_1,
+               [WRS_MCS_2] =3D PPMCS_DFLT_OFT_V3_MCS_2,
+               [WRS_MCS_3] =3D PPMCS_DFLT_OFT_V3_MCS_3,
+               [WRS_MCS_4] =3D PPMCS_DFLT_OFT_V3_MCS_4,
+               [WRS_MCS_5] =3D PPMCS_DFLT_OFT_V3_MCS_5,
+               [WRS_MCS_6] =3D PPMCS_DFLT_OFT_V3_MCS_6,
+               [WRS_MCS_7] =3D PPMCS_DFLT_OFT_V3_MCS_7,
+               [WRS_MCS_8] =3D PPMCS_DFLT_OFT_V3_MCS_8,
+               [WRS_MCS_9] =3D PPMCS_DFLT_OFT_V3_MCS_9,
+               [WRS_MCS_10] =3D PPMCS_DFLT_OFT_V3_MCS_10,
+               [WRS_MCS_11] =3D PPMCS_DFLT_OFT_V3_MCS_11,
+       },
+       /* 5G */
+       .ce_ppmcs_offset_he_36_64 =3D {
+               [WRS_MCS_0] =3D PPMCS_DFLT_OFT_V1_MCS_0,
+               [WRS_MCS_1] =3D PPMCS_DFLT_OFT_V1_MCS_1,
+               [WRS_MCS_2] =3D PPMCS_DFLT_OFT_V1_MCS_2,
+               [WRS_MCS_3] =3D PPMCS_DFLT_OFT_V1_MCS_3,
+               [WRS_MCS_4] =3D PPMCS_DFLT_OFT_V1_MCS_4,
+               [WRS_MCS_5] =3D PPMCS_DFLT_OFT_V1_MCS_5,
+               [WRS_MCS_6] =3D PPMCS_DFLT_OFT_V1_MCS_6,
+               [WRS_MCS_7] =3D PPMCS_DFLT_OFT_V1_MCS_7,
+               [WRS_MCS_8] =3D PPMCS_DFLT_OFT_V1_MCS_8,
+               [WRS_MCS_9] =3D PPMCS_DFLT_OFT_V1_MCS_9,
+               [WRS_MCS_10] =3D PPMCS_DFLT_OFT_V1_MCS_10,
+               [WRS_MCS_11] =3D PPMCS_DFLT_OFT_V1_MCS_11,
+       },
+       .ce_ppmcs_offset_he_100_140 =3D {
+               [WRS_MCS_0] =3D PPMCS_DFLT_OFT_V1_MCS_0,
+               [WRS_MCS_1] =3D PPMCS_DFLT_OFT_V1_MCS_1,
+               [WRS_MCS_2] =3D PPMCS_DFLT_OFT_V1_MCS_2,
+               [WRS_MCS_3] =3D PPMCS_DFLT_OFT_V1_MCS_3,
+               [WRS_MCS_4] =3D PPMCS_DFLT_OFT_V1_MCS_4,
+               [WRS_MCS_5] =3D PPMCS_DFLT_OFT_V1_MCS_5,
+               [WRS_MCS_6] =3D PPMCS_DFLT_OFT_V1_MCS_6,
+               [WRS_MCS_7] =3D PPMCS_DFLT_OFT_V1_MCS_7,
+               [WRS_MCS_8] =3D PPMCS_DFLT_OFT_V1_MCS_8,
+               [WRS_MCS_9] =3D PPMCS_DFLT_OFT_V1_MCS_9,
+               [WRS_MCS_10] =3D PPMCS_DFLT_OFT_V1_MCS_10,
+               [WRS_MCS_11] =3D PPMCS_DFLT_OFT_V1_MCS_11,
+       },
+       .ce_ppmcs_offset_he_149_165 =3D {
+               [WRS_MCS_0] =3D PPMCS_DFLT_OFT_V1_MCS_0,
+               [WRS_MCS_1] =3D PPMCS_DFLT_OFT_V1_MCS_1,
+               [WRS_MCS_2] =3D PPMCS_DFLT_OFT_V1_MCS_2,
+               [WRS_MCS_3] =3D PPMCS_DFLT_OFT_V1_MCS_3,
+               [WRS_MCS_4] =3D PPMCS_DFLT_OFT_V1_MCS_4,
+               [WRS_MCS_5] =3D PPMCS_DFLT_OFT_V1_MCS_5,
+               [WRS_MCS_6] =3D PPMCS_DFLT_OFT_V1_MCS_6,
+               [WRS_MCS_7] =3D PPMCS_DFLT_OFT_V1_MCS_7,
+               [WRS_MCS_8] =3D PPMCS_DFLT_OFT_V1_MCS_8,
+               [WRS_MCS_9] =3D PPMCS_DFLT_OFT_V1_MCS_9,
+               [WRS_MCS_10] =3D PPMCS_DFLT_OFT_V1_MCS_10,
+               [WRS_MCS_11] =3D PPMCS_DFLT_OFT_V1_MCS_11,
+       },
+       .ce_ppmcs_offset_ht_vht_36_64 =3D {
+               [WRS_MCS_0] =3D PPMCS_DFLT_OFT_V1_MCS_0,
+               [WRS_MCS_1] =3D PPMCS_DFLT_OFT_V1_MCS_1,
+               [WRS_MCS_2] =3D PPMCS_DFLT_OFT_V1_MCS_2,
+               [WRS_MCS_3] =3D PPMCS_DFLT_OFT_V1_MCS_3,
+               [WRS_MCS_4] =3D PPMCS_DFLT_OFT_V1_MCS_4,
+               [WRS_MCS_5] =3D PPMCS_DFLT_OFT_V1_MCS_5,
+               [WRS_MCS_6] =3D PPMCS_DFLT_OFT_V1_MCS_6,
+               [WRS_MCS_7] =3D PPMCS_DFLT_OFT_V1_MCS_7,
+               [WRS_MCS_8] =3D PPMCS_DFLT_OFT_V1_MCS_8,
+               [WRS_MCS_9] =3D PPMCS_DFLT_OFT_V1_MCS_9,
+       },
+       .ce_ppmcs_offset_ht_vht_100_140 =3D {
+               [WRS_MCS_0] =3D PPMCS_DFLT_OFT_V1_MCS_0,
+               [WRS_MCS_1] =3D PPMCS_DFLT_OFT_V1_MCS_1,
+               [WRS_MCS_2] =3D PPMCS_DFLT_OFT_V1_MCS_2,
+               [WRS_MCS_3] =3D PPMCS_DFLT_OFT_V1_MCS_3,
+               [WRS_MCS_4] =3D PPMCS_DFLT_OFT_V1_MCS_4,
+               [WRS_MCS_5] =3D PPMCS_DFLT_OFT_V1_MCS_5,
+               [WRS_MCS_6] =3D PPMCS_DFLT_OFT_V1_MCS_6,
+               [WRS_MCS_7] =3D PPMCS_DFLT_OFT_V1_MCS_7,
+               [WRS_MCS_8] =3D PPMCS_DFLT_OFT_V1_MCS_8,
+               [WRS_MCS_9] =3D PPMCS_DFLT_OFT_V1_MCS_9,
+       },
+       .ce_ppmcs_offset_ht_vht_149_165 =3D {
+               [WRS_MCS_0] =3D PPMCS_DFLT_OFT_V1_MCS_0,
+               [WRS_MCS_1] =3D PPMCS_DFLT_OFT_V1_MCS_1,
+               [WRS_MCS_2] =3D PPMCS_DFLT_OFT_V1_MCS_2,
+               [WRS_MCS_3] =3D PPMCS_DFLT_OFT_V1_MCS_3,
+               [WRS_MCS_4] =3D PPMCS_DFLT_OFT_V1_MCS_4,
+               [WRS_MCS_5] =3D PPMCS_DFLT_OFT_V1_MCS_5,
+               [WRS_MCS_6] =3D PPMCS_DFLT_OFT_V1_MCS_6,
+               [WRS_MCS_7] =3D PPMCS_DFLT_OFT_V1_MCS_7,
+               [WRS_MCS_8] =3D PPMCS_DFLT_OFT_V1_MCS_8,
+               [WRS_MCS_9] =3D PPMCS_DFLT_OFT_V1_MCS_9,
+       },
+       .ce_ppmcs_offset_ofdm_36_64 =3D {
+               [WRS_MCS_0] =3D PPMCS_DFLT_OFT_V1_MCS_0,
+               [WRS_MCS_1] =3D PPMCS_DFLT_OFT_V1_MCS_1,
+               [WRS_MCS_2] =3D PPMCS_DFLT_OFT_V1_MCS_2,
+               [WRS_MCS_3] =3D PPMCS_DFLT_OFT_V1_MCS_3,
+               [WRS_MCS_4] =3D PPMCS_DFLT_OFT_V1_MCS_4,
+               [WRS_MCS_5] =3D PPMCS_DFLT_OFT_V1_MCS_5,
+               [WRS_MCS_6] =3D PPMCS_DFLT_OFT_V1_MCS_6,
+               [WRS_MCS_7] =3D PPMCS_DFLT_OFT_V1_MCS_7,
+       },
+       .ce_ppmcs_offset_ofdm_100_140 =3D {
+               [WRS_MCS_0] =3D PPMCS_DFLT_OFT_V1_MCS_0,
+               [WRS_MCS_1] =3D PPMCS_DFLT_OFT_V1_MCS_1,
+               [WRS_MCS_2] =3D PPMCS_DFLT_OFT_V1_MCS_2,
+               [WRS_MCS_3] =3D PPMCS_DFLT_OFT_V1_MCS_3,
+               [WRS_MCS_4] =3D PPMCS_DFLT_OFT_V1_MCS_4,
+               [WRS_MCS_5] =3D PPMCS_DFLT_OFT_V1_MCS_5,
+               [WRS_MCS_6] =3D PPMCS_DFLT_OFT_V1_MCS_6,
+               [WRS_MCS_7] =3D PPMCS_DFLT_OFT_V1_MCS_7,
+       },
+       .ce_ppmcs_offset_ofdm_149_165 =3D {
+               [WRS_MCS_0] =3D PPMCS_DFLT_OFT_V1_MCS_0,
+               [WRS_MCS_1] =3D PPMCS_DFLT_OFT_V1_MCS_1,
+               [WRS_MCS_2] =3D PPMCS_DFLT_OFT_V1_MCS_2,
+               [WRS_MCS_3] =3D PPMCS_DFLT_OFT_V1_MCS_3,
+               [WRS_MCS_4] =3D PPMCS_DFLT_OFT_V1_MCS_4,
+               [WRS_MCS_5] =3D PPMCS_DFLT_OFT_V1_MCS_5,
+               [WRS_MCS_6] =3D PPMCS_DFLT_OFT_V1_MCS_6,
+               [WRS_MCS_7] =3D PPMCS_DFLT_OFT_V1_MCS_7,
+       },
+       /* 24G */
+       .ce_ppmcs_offset_he =3D {
+               [WRS_MCS_0] =3D PPMCS_DFLT_OFT_V2_MCS_0,
+               [WRS_MCS_1] =3D PPMCS_DFLT_OFT_V2_MCS_1,
+               [WRS_MCS_2] =3D PPMCS_DFLT_OFT_V2_MCS_2,
+               [WRS_MCS_3] =3D PPMCS_DFLT_OFT_V2_MCS_3,
+               [WRS_MCS_4] =3D PPMCS_DFLT_OFT_V2_MCS_4,
+               [WRS_MCS_5] =3D PPMCS_DFLT_OFT_V2_MCS_5,
+               [WRS_MCS_6] =3D PPMCS_DFLT_OFT_V2_MCS_6,
+               [WRS_MCS_7] =3D PPMCS_DFLT_OFT_V2_MCS_7,
+               [WRS_MCS_8] =3D PPMCS_DFLT_OFT_V2_MCS_8,
+               [WRS_MCS_9] =3D PPMCS_DFLT_OFT_V2_MCS_9,
+               [WRS_MCS_10] =3D PPMCS_DFLT_OFT_V2_MCS_10,
+               [WRS_MCS_11] =3D PPMCS_DFLT_OFT_V2_MCS_11,
+       },
+       .ce_ppmcs_offset_ht =3D {
+               [WRS_MCS_0] =3D PPMCS_DFLT_OFT_V2_MCS_0,
+               [WRS_MCS_1] =3D PPMCS_DFLT_OFT_V2_MCS_1,
+               [WRS_MCS_2] =3D PPMCS_DFLT_OFT_V2_MCS_2,
+               [WRS_MCS_3] =3D PPMCS_DFLT_OFT_V2_MCS_3,
+               [WRS_MCS_4] =3D PPMCS_DFLT_OFT_V2_MCS_4,
+               [WRS_MCS_5] =3D PPMCS_DFLT_OFT_V2_MCS_5,
+               [WRS_MCS_6] =3D PPMCS_DFLT_OFT_V2_MCS_6,
+               [WRS_MCS_7] =3D PPMCS_DFLT_OFT_V2_MCS_7,
+       },
+       .ce_ppmcs_offset_ofdm =3D {
+               [WRS_MCS_0] =3D PPMCS_DFLT_OFT_V2_MCS_0,
+               [WRS_MCS_1] =3D PPMCS_DFLT_OFT_V2_MCS_1,
+               [WRS_MCS_2] =3D PPMCS_DFLT_OFT_V2_MCS_2,
+               [WRS_MCS_3] =3D PPMCS_DFLT_OFT_V2_MCS_3,
+               [WRS_MCS_4] =3D PPMCS_DFLT_OFT_V2_MCS_4,
+               [WRS_MCS_5] =3D PPMCS_DFLT_OFT_V2_MCS_5,
+               [WRS_MCS_6] =3D PPMCS_DFLT_OFT_V2_MCS_6,
+               [WRS_MCS_7] =3D PPMCS_DFLT_OFT_V2_MCS_7,
+       },
+       .ce_ppmcs_offset_cck =3D {
+               [WRS_MCS_0] =3D 0,
+               [WRS_MCS_1] =3D 0,
+               [WRS_MCS_2] =3D 0,
+               [WRS_MCS_3] =3D 0,
+       },
+       .ce_ppbw_offset =3D {
+               [CHNL_BW_20] =3D PPBW_DFLT_OFT_BW_20,
+               [CHNL_BW_40] =3D PPBW_DFLT_OFT_BW_40,
+               [CHNL_BW_80] =3D PPBW_DFLT_OFT_BW_80,
+               [CHNL_BW_160] =3D PPBW_DFLT_OFT_BW_160,
+       },
+       .ce_power_offset_prod_en =3D true,
+       .ce_bf_en =3D 0,
+       .ci_bf_max_nss =3D 2,
+       .ce_sounding_interval_coefs =3D {
+               [SOUNDING_INTERVAL_COEF_MIN_INTERVAL] =3D 100,
+               [SOUNDING_INTERVAL_COEF_STA_STEP] =3D 4,
+               [SOUNDING_INTERVAL_COEF_INTERVAL_STEP] =3D 50,
+               [SOUNDING_INTERVAL_COEF_MAX_INTERVAL] =3D 500,
+       },
+       .ci_rate_fallback =3D {
+               [CL_RATE_FALLBACK_COUNT_SU] =3D 4,
+               [CL_RATE_FALLBACK_COUNT_MU] =3D 2,
+               [CL_RATE_FALLBACK_RETRY_COUNT_THR] =3D 2,
+               [CL_RATE_FALLBACK_BA_PER_THR] =3D 25,
+               [CL_RATE_FALLBACK_BA_NOT_RECEIVED_THR] =3D 2,
+               [CL_RATE_FALLBACK_DISABLE_MCS] =3D 1
+       },
+       .ce_rx_pkts_budget =3D 512,
+       .ci_band_num =3D 5,
+       .ci_mult_ampdu_in_txop_en =3D false,
+       .ce_wmm_aifsn =3D {
+               [AC_BK] =3D 3,
+               [AC_BE] =3D 7,
+               [AC_VI] =3D 1,
+               [AC_VO] =3D 1
+       },
+       .ce_wmm_cwmin =3D {
+               [AC_BK] =3D 4,
+               [AC_BE] =3D 4,
+               [AC_VI] =3D 3,
+               [AC_VO] =3D 2
+       },
+       .ce_wmm_cwmax =3D {
+               [AC_BK] =3D 10,
+               [AC_BE] =3D 10,
+               [AC_VI] =3D 4,
+               [AC_VO] =3D 3
+       },
+       .ce_wmm_txop =3D {
+               [AC_BK] =3D 0,
+               [AC_BE] =3D 0,
+               [AC_VI] =3D 94,
+               [AC_VO] =3D 47
+       },
+       .ci_su_force_min_spacing =3D CL_TX_MPDU_SPACING_INVALID,
+       .ci_mu_force_min_spacing =3D CL_TX_MPDU_SPACING_INVALID,
+       .ci_tf_mac_pad_dur =3D 0,
+       .ci_cca_timeout =3D 300,
+       .ce_tx_ba_session_timeout =3D 30000,
+       .ci_motion_sense_en =3D true,
+       .ci_motion_sense_rssi_thr =3D 8,
+       .ci_wrs_max_bw =3D CHNL_BW_160,
+       .ci_wrs_min_bw =3D CHNL_BW_20,
+       .ci_wrs_fixed_rate =3D {
+               [WRS_FIXED_PARAM_MODE] =3D -1,
+               [WRS_FIXED_PARAM_BW] =3D -1,
+               [WRS_FIXED_PARAM_NSS] =3D -1,
+               [WRS_FIXED_PARAM_MCS] =3D -1,
+               [WRS_FIXED_PARAM_GI] =3D -1
+       },
+       .ce_he_mcs_nss_supp_tx =3D {
+               [WRS_SS_1 ... WRS_SS_4] =3D 11,
+       },
+       .ce_he_mcs_nss_supp_rx =3D {
+               [WRS_SS_1 ... WRS_SS_4] =3D 11,
+       },
+       .ce_vht_mcs_nss_supp_tx =3D {
+               [WRS_SS_1 ... WRS_SS_4] =3D 9,
+       },
+       .ce_vht_mcs_nss_supp_rx =3D {
+               [WRS_SS_1 ... WRS_SS_4] =3D 9,
+       },
+       .ci_pe_duration =3D U8_MAX,
+       .ci_pe_duration_bcast =3D PPE_16US,
+       .ci_coredump_diff_time_ms =3D 0,
+       .ci_gain_update_enable =3D 1,
+       .ci_mcs_sig_b =3D 0,
+       .ci_spp_ksr_value =3D 1,
+       .ci_rx_padding_en =3D false,
+       .ci_stats_en =3D false,
+       .ci_bar_disable =3D false,
+       .ci_ofdm_only =3D true,
+       .ci_drop_to_lower_bw =3D false,
+       .ce_twt_en =3D false,
+       .ce_twt_default_interval =3D CL_TWT_DEFAULT_INTERVAL_US,
+       .ce_twt_default_min_wake_duration =3D CL_TWT_DEFAULT_MIN_WAKE_DURAT=
ION_US,
+       .ce_twt_max_sessions =3D CL_TWT_MAX_SESSIONS,
+       .ci_hr_factor =3D {
+               [CHNL_BW_20] =3D 2,
+               [CHNL_BW_40] =3D 2,
+               [CHNL_BW_80] =3D 2,
+               [CHNL_BW_160] =3D 1
+       },
+       .ci_csd_en =3D false,
+       .ci_signal_extension_en =3D false,
+       .ce_dscp_vlan_enable =3D {
+               [0] =3D true,
+               [1 ... MAX_BSS_NUM - 1] =3D false,
+       },
+       .ce_up0_7_default_vlan_user_prio =3D {0},
+       .ce_up0_7_layer_based =3D {0},
+       .ce_dscp_to_up0_7dec0 =3D "0,8,16,24,32,40,48,56",
+       .ce_dscp_to_up0_7dec1 =3D "0,8,16,24,32,40,48,56",
+       .ce_dscp_to_up0_7dec2 =3D "0,8,16,24,32,40,48,56",
+       .ce_dscp_to_up0_7dec3 =3D "0,8,16,24,32,40,48,56",
+       .ce_dscp_to_up0_7dec4 =3D "0,8,16,24,32,40,48,56",
+       .ce_dscp_to_up0_7dec5 =3D "0,8,16,24,32,40,48,56",
+       .ce_dscp_to_up0_7dec6 =3D "0,8,16,24,32,40,48,56",
+       .ce_dscp_to_up0_7dec7 =3D "0,8,16,24,32,40,48,56",
+       .ce_vlan_to_up0_7dec0 =3D "7,5,6,4,3,1,1,0",
+       .ce_vlan_to_up0_7dec1 =3D "7,5,6,4,3,1,1,0",
+       .ce_vlan_to_up0_7dec2 =3D "7,5,6,4,3,1,1,0",
+       .ce_vlan_to_up0_7dec3 =3D "7,5,6,4,3,1,1,0",
+       .ce_vlan_to_up0_7dec4 =3D "7,5,6,4,3,1,1,0",
+       .ce_vlan_to_up0_7dec5 =3D "7,5,6,4,3,1,1,0",
+       .ce_vlan_to_up0_7dec6 =3D "7,5,6,4,3,1,1,0",
+       .ce_vlan_to_up0_7dec7 =3D "7,5,6,4,3,1,1,0",
+       .ci_vht_cap_24g =3D false,
+       .ce_omi_en =3D false,
+       .ci_tx_digital_gain =3D 0x28282828,
+       .ci_tx_digital_gain_cck =3D 0x63636363,
+       .ci_ofdm_cck_power_offset =3D -13,
+       .ci_mac_clk_gating_en =3D true,
+       .ci_phy_clk_gating_en =3D true,
+       .ci_imaging_blocker =3D false,
+       .ci_ndp_tx_chain_mask =3D NDP_TX_PHY0,
+       .ci_ndp_tx_bw =3D CHNL_BW_MAX,
+       .ci_ndp_tx_format =3D FORMATMOD_NON_HT,
+       .ci_ndp_tx_num_ltf =3D LTF_X1,
+       .ci_calib_ant_tx =3D {
+               [0 ... MAX_ANTENNAS - 1] =3D U8_MAX,
+       },
+       .ci_calib_ant_rx =3D {
+               [0 ... MAX_ANTENNAS - 1] =3D U8_MAX,
+       },
+       .ci_cca_ed_rise_thr_dbm =3D -62,
+       .ci_cca_ed_fall_thr_dbm =3D -65,
+       .ci_cca_cs_en =3D 1,
+       .ci_cca_modem_en =3D 0xf,
+       .ci_cca_main_ant =3D 0,
+       .ci_cca_second_ant =3D 1,
+       .ci_cca_flag0_ctrl =3D 0x8,
+       .ci_cca_flag1_ctrl =3D 0x8,
+       .ci_cca_flag2_ctrl =3D 0x2,
+       .ci_cca_flag3_ctrl =3D 0xa,
+       .ci_cca_gi_rise_thr_dbm =3D -72,
+       .ci_cca_gi_fall_thr_dbm =3D -75,
+       .ci_cca_gi_pow_lim_dbm =3D -59,
+       .ci_cca_ed_en =3D 0x7ff,
+       .ci_cca_gi_en =3D 0,
+       .ci_rx_he_mu_ppdu =3D false,
+       .ci_fast_rx_en =3D true,
+       .ci_distance_auto_resp_all =3D 0,
+       .ci_distance_auto_resp_msta =3D 0,
+};
+
+static int update_config(struct cl_hw *cl_hw, char *name, char *value)
+{
+       struct cl_tcv_conf *conf =3D cl_hw->conf;
+
+       READ_U8(ce_bss_num);
+       READ_S8(ce_debug_level);
+       READ_BOOL(ce_radio_on);
+       READ_BOOL(ce_ps_ctrl_enabled);
+       READ_U8(ha_channel);
+       READ_BOOL(ci_ieee80211w);
+       READ_BOOL(ci_ieee80211h);
+       READ_U8(ha_short_guard_interval);
+       READ_U8(ha_max_mpdu_len);
+       READ_U8(ha_vht_max_ampdu_len_exp);
+       READ_U32(ha_beacon_int);
+       READ_STR(ce_dsp_code);
+       READ_STR(ce_dsp_data);
+       READ_STR(ce_dsp_external_data);
+       READ_BOOL(ce_uapsd_en);
+       READ_BOOL(ci_eirp_regulatory_en);
+       READ_BOOL(ci_agg_tx);
+       READ_BOOL(ci_agg_rx);
+       READ_BOOL(ce_txldpc_en);
+       READ_BOOL(ce_ht_rxldpc_en);
+       READ_BOOL(ce_vht_rxldpc_en);
+       READ_BOOL(ce_he_rxldpc_en);
+       READ_BOOL(ci_cs_required);
+       READ_S8_ARR(ci_rx_sensitivity_prod, MAX_ANTENNAS);
+       READ_S8_ARR(ci_rx_sensitivity_op, MAX_ANTENNAS);
+       READ_BOOL(ce_cck_bcn_en);
+       READ_BOOL(ci_min_he_en);
+       READ_U8(ce_cck_tx_ant_mask);
+       READ_U8(ce_cck_rx_ant_mask);
+       READ_U8(ce_rx_nss);
+       READ_U8(ce_tx_nss);
+       READ_U8(ce_num_antennas);
+       READ_U8(ce_wireless_mode);
+       READ_BOOL_ARR(ha_wmm_enabled, MAX_BSS_NUM);
+       READ_U16(ce_max_agg_size_tx);
+       READ_U16(ce_max_agg_size_rx);
+       READ_BOOL(ce_rxamsdu_en);
+       READ_U8(ce_txamsdu_en);
+       READ_U16(ci_tx_amsdu_min_data_rate);
+       READ_U8(ci_tx_sw_amsdu_max_packets);
+       READ_U16(ci_tx_packet_limit);
+       READ_U16(ci_tx_queue_size_agg);
+       READ_U16(ci_tx_queue_size_single);
+       READ_U16_ARR(ci_ipc_rxbuf_size, CL_RX_BUF_MAX);
+       READ_U16(ce_max_retry);
+       READ_U8(ce_short_retry_limit);
+       READ_U8(ce_long_retry_limit);
+       READ_U8(ci_assoc_auth_retry_limit);
+       READ_U8(ce_channel_bandwidth);
+       READ_U8_ARR(ce_iface_type, MAX_BSS_NUM);
+       READ_U8(ha_hw_mode);
+       READ_S8(ce_temp_comp_slope);
+       READ_U32(ci_fw_dbg_severity);
+       READ_U32(ci_fw_dbg_module);
+       READ_U32(ci_hal_idle_to);
+       READ_U32(ci_tx_ac0_to);
+       READ_U32(ci_tx_ac1_to);
+       READ_U32(ci_tx_ac2_to);
+       READ_U32(ci_tx_ac3_to);
+       READ_U32(ci_tx_bcn_to);
+       READ_STR(ce_hardware_power_table);
+       READ_STR(ce_arr_gain);
+       READ_STR(ce_bf_gain_2_ant);
+       READ_STR(ce_bf_gain_3_ant);
+       READ_STR(ce_bf_gain_4_ant);
+       READ_STR(ce_bf_gain_5_ant);
+       READ_STR(ce_bf_gain_6_ant);
+       READ_STR(ce_ant_gain);
+       READ_STR(ce_ant_gain_36_64);
+       READ_STR(ce_ant_gain_100_140);
+       READ_STR(ce_ant_gain_149_165);
+       READ_STR(ci_min_ant_pwr);
+       READ_STR(ci_bw_factor);
+       READ_U8(ce_mcast_rate);
+       READ_BOOL(ce_dyn_mcast_rate_en);
+       READ_BOOL(ce_dyn_bcast_rate_en);
+       READ_U8(ce_default_mcs_ofdm);
+       READ_U8(ce_default_mcs_cck);
+       READ_BOOL(ce_prot_log_nav_en);
+       READ_U8(ce_prot_mode);
+       READ_U8(ce_prot_rate_format);
+       READ_U8(ce_prot_rate_mcs);
+       READ_U8(ce_prot_rate_pre_type);
+       READ_U8(ce_bw_signaling_mode);
+       READ_U8(ci_dyn_cts_sta_thr);
+       READ_S8(ci_vns_pwr_limit);
+       READ_U8(ci_vns_pwr_mode);
+       READ_S8(ci_vns_rssi_auto_resp_thr);
+       READ_S8(ci_vns_rssi_thr);
+       READ_S8(ci_vns_rssi_hys);
+       READ_U16(ci_vns_maintenance_time);
+       READ_U16(ce_bcn_tx_path_min_time);
+       READ_BOOL(ci_backup_bcn_en);
+       READ_BOOL(ce_tx_txop_cut_en);
+       READ_U8(ci_bcns_flushed_cnt_thr);
+       READ_BOOL(ci_phy_err_prevents_phy_dump);
+       READ_U8(ci_tx_rx_delay);
+       READ_U8(ci_fw_assert_time_diff_sec);
+       READ_U8(ci_fw_assert_storm_detect_thd);
+       READ_U32(ce_hw_assert_time_max);
+       READ_U8(ce_fw_watchdog_mode);
+       READ_U8(ce_fw_watchdog_limit_count);
+       READ_U32(ce_fw_watchdog_limit_time);
+       READ_S8(ci_rx_remote_cpu_drv);
+       READ_S8(ci_rx_remote_cpu_mac);
+       READ_S8(ci_tx_remote_cpu);
+       READ_U16(ci_pending_queue_size);
+       READ_U8(ce_tx_power_control);
+       READ_BOOL(ce_standby_mode_en);
+       READ_BOOL(ce_coex_en);
+       READ_S8(ce_extension_channel);
+       READ_U8(ci_dfs_initial_gain);
+       READ_U8(ci_dfs_agc_cd_th);
+       READ_U16(ci_dfs_long_pulse_min);
+       READ_U16(ci_dfs_long_pulse_max);
+       READ_STR(ce_dfs_tbl_overwrite);
+       READ_STR(ce_dfs_jump_channels);
+       READ_S8_ARR(ce_ppmcs_offset_he_6g, WRS_MCS_MAX_HE);
+       READ_S8_ARR(ce_ppmcs_offset_he_36_64, WRS_MCS_MAX_HE);
+       READ_S8_ARR(ce_ppmcs_offset_he_100_140, WRS_MCS_MAX_HE);
+       READ_S8_ARR(ce_ppmcs_offset_he_149_165, WRS_MCS_MAX_HE);
+       READ_S8_ARR(ce_ppmcs_offset_ht_vht_36_64, WRS_MCS_MAX_VHT);
+       READ_S8_ARR(ce_ppmcs_offset_ht_vht_100_140, WRS_MCS_MAX_VHT);
+       READ_S8_ARR(ce_ppmcs_offset_ht_vht_149_165, WRS_MCS_MAX_VHT);
+       READ_S8_ARR(ce_ppmcs_offset_ofdm_36_64, WRS_MCS_MAX_OFDM);
+       READ_S8_ARR(ce_ppmcs_offset_ofdm_100_140, WRS_MCS_MAX_OFDM);
+       READ_S8_ARR(ce_ppmcs_offset_ofdm_149_165, WRS_MCS_MAX_OFDM);
+       READ_S8_ARR(ce_ppmcs_offset_he, WRS_MCS_MAX_HE);
+       READ_S8_ARR(ce_ppmcs_offset_ht, WRS_MCS_MAX_HT);
+       READ_S8_ARR(ce_ppmcs_offset_ofdm, WRS_MCS_MAX_OFDM);
+       READ_S8_ARR(ce_ppmcs_offset_cck, WRS_MCS_MAX_CCK);
+       READ_S8_ARR(ce_ppbw_offset, CHNL_BW_MAX);
+       READ_BOOL(ce_power_offset_prod_en);
+       READ_BOOL(ce_bf_en);
+       READ_U8(ci_bf_max_nss);
+       READ_U16_ARR(ce_sounding_interval_coefs, SOUNDING_INTERVAL_COEF_MAX=
);
+       READ_U8_ARR(ci_rate_fallback, CL_RATE_FALLBACK_MAX);
+       READ_U16(ce_rx_pkts_budget);
+       READ_U8(ci_band_num);
+       READ_BOOL(ci_mult_ampdu_in_txop_en);
+       READ_U8_ARR(ce_wmm_aifsn, AC_MAX);
+       READ_U8_ARR(ce_wmm_cwmin, AC_MAX);
+       READ_U8_ARR(ce_wmm_cwmax, AC_MAX);
+       READ_U16_ARR(ce_wmm_txop, AC_MAX);
+       READ_U8(ci_su_force_min_spacing);
+       READ_U8(ci_mu_force_min_spacing);
+       READ_U8(ci_tf_mac_pad_dur);
+       READ_U32(ci_cca_timeout);
+       READ_U16(ce_tx_ba_session_timeout);
+       READ_BOOL(ci_motion_sense_en);
+       READ_S8(ci_motion_sense_rssi_thr);
+       READ_U8(ci_wrs_max_bw);
+       READ_U8(ci_wrs_min_bw);
+       READ_S8_ARR(ci_wrs_fixed_rate, WRS_FIXED_PARAM_MAX);
+       READ_U8_ARR(ce_he_mcs_nss_supp_tx, WRS_SS_MAX);
+       READ_U8_ARR(ce_he_mcs_nss_supp_rx, WRS_SS_MAX);
+       READ_U8_ARR(ce_vht_mcs_nss_supp_tx, WRS_SS_MAX);
+       READ_U8_ARR(ce_vht_mcs_nss_supp_rx, WRS_SS_MAX);
+       READ_U8(ci_pe_duration);
+       READ_U8(ci_pe_duration_bcast);
+       READ_U32(ci_coredump_diff_time_ms);
+       READ_U8(ci_gain_update_enable);
+       READ_U8(ci_mcs_sig_b);
+       READ_U8(ci_spp_ksr_value);
+       READ_BOOL(ci_rx_padding_en);
+       READ_BOOL(ci_stats_en);
+       READ_BOOL(ci_bar_disable);
+       READ_BOOL(ci_ofdm_only);
+       READ_BOOL(ci_drop_to_lower_bw);
+       READ_BOOL(ce_twt_en);
+       READ_BOOL(ci_csd_en);
+       READ_U32(ce_twt_default_interval);
+       READ_U32(ce_twt_default_min_wake_duration);
+       READ_U8(ce_twt_max_sessions);
+       READ_U8_ARR(ci_hr_factor, CHNL_BW_MAX);
+       READ_BOOL(ci_signal_extension_en);
+       READ_BOOL_ARR(ce_dscp_vlan_enable, MAX_BSS_NUM);
+       READ_U8_ARR(ce_up0_7_default_vlan_user_prio, MAX_BSS_NUM);
+       READ_U8_ARR(ce_up0_7_layer_based, MAX_BSS_NUM);
+       READ_STR(ce_dscp_to_up0_7dec0);
+       READ_STR(ce_dscp_to_up0_7dec1);
+       READ_STR(ce_dscp_to_up0_7dec2);
+       READ_STR(ce_dscp_to_up0_7dec3);
+       READ_STR(ce_dscp_to_up0_7dec4);
+       READ_STR(ce_dscp_to_up0_7dec5);
+       READ_STR(ce_dscp_to_up0_7dec6);
+       READ_STR(ce_dscp_to_up0_7dec7);
+       READ_STR(ce_vlan_to_up0_7dec0);
+       READ_STR(ce_vlan_to_up0_7dec1);
+       READ_STR(ce_vlan_to_up0_7dec2);
+       READ_STR(ce_vlan_to_up0_7dec3);
+       READ_STR(ce_vlan_to_up0_7dec4);
+       READ_STR(ce_vlan_to_up0_7dec5);
+       READ_STR(ce_vlan_to_up0_7dec6);
+       READ_STR(ce_vlan_to_up0_7dec7);
+       READ_BOOL(ci_vht_cap_24g);
+       READ_BOOL(ce_omi_en);
+       READ_U32(ci_tx_digital_gain);
+       READ_U32(ci_tx_digital_gain_cck);
+       READ_S8(ci_ofdm_cck_power_offset);
+       READ_BOOL(ci_mac_clk_gating_en);
+       READ_BOOL(ci_phy_clk_gating_en);
+       READ_BOOL(ci_imaging_blocker);
+       READ_U8(ci_ndp_tx_chain_mask);
+       READ_U8(ci_ndp_tx_bw);
+       READ_U8(ci_ndp_tx_format);
+       READ_U8(ci_ndp_tx_num_ltf);
+       READ_U8_ARR(ci_calib_ant_tx, MAX_ANTENNAS);
+       READ_U8_ARR(ci_calib_ant_rx, MAX_ANTENNAS);
+       READ_S8(ci_cca_ed_rise_thr_dbm);
+       READ_S8(ci_cca_ed_fall_thr_dbm);
+       READ_U8(ci_cca_cs_en);
+       READ_U8(ci_cca_modem_en);
+       READ_U8(ci_cca_main_ant);
+       READ_U8(ci_cca_second_ant);
+       READ_U8(ci_cca_flag0_ctrl);
+       READ_U8(ci_cca_flag1_ctrl);
+       READ_U8(ci_cca_flag2_ctrl);
+       READ_U8(ci_cca_flag3_ctrl);
+       READ_S8(ci_cca_gi_rise_thr_dbm);
+       READ_S8(ci_cca_gi_fall_thr_dbm);
+       READ_S8(ci_cca_gi_pow_lim_dbm);
+       READ_U16(ci_cca_ed_en);
+       READ_U8(ci_cca_gi_en);
+       READ_BOOL(ci_rx_he_mu_ppdu);
+       READ_BOOL(ci_fast_rx_en);
+       READ_U8(ci_distance_auto_resp_all);
+       READ_U8(ci_distance_auto_resp_msta);
+
+       if (!cl_config_is_non_driver_param(name)) {
+               CL_DBG_ERROR(cl_hw, "No matching conf for nvram parameter %=
s\n", name);
+               return -EINVAL;
+       }
+
+       return 0;
+}
+
+static int set_all_params_from_buf(struct cl_hw *cl_hw, char *buf, size_t =
size)
+{
+       char *line =3D buf;
+       char name[MAX_PARAM_NAME_LENGTH];
+       char value[STR_LEN_256B];
+       char *begin;
+       char *end;
+       int ret =3D 0;
+       int name_length =3D 0;
+       int value_length =3D 0;
+
+       while (line && strlen(line) && (line !=3D (buf + size))) {
+               if ((*line =3D=3D '#') || (*line =3D=3D '\n')) {
+                       /* Skip comment or blank line */
+                       line =3D strstr(line, "\n") + 1;
+               } else if (*line) {
+                       begin =3D line;
+                       end =3D strstr(begin, "=3D");
+
+                       if (!end) {
+                               ret =3D -EBADMSG;
+                               goto exit;
+                       }
+
+                       end++;
+                       name_length =3D end - begin;
+                       value_length =3D strstr(end, "\n") - end + 1;
+
+                       if (name_length >=3D MAX_PARAM_NAME_LENGTH) {
+                               cl_dbg_err(cl_hw,
+                                          "Name too long (%u)\n", name_len=
gth);
+                               ret =3D -EBADMSG;
+                               goto exit;
+                       }
+                       if (value_length >=3D STR_LEN_256B) {
+                               cl_dbg_err(cl_hw,
+                                          "Value too long (%u)\n", value_l=
ength);
+                               ret =3D -EBADMSG;
+                               goto exit;
+                       }
+
+                       snprintf(name, name_length, "%s", begin);
+                       snprintf(value, value_length, "%s", end);
+
+                       ret =3D update_config(cl_hw, name, value);
+                       if (ret)
+                               goto exit;
+
+                       line =3D strstr(line, "\n") + 1;
+               }
+       }
+
+exit:
+
+       return ret;
+}
+
+static bool is_valid_min_spacing(u8 min_spacing)
+{
+       return ((min_spacing =3D=3D 0) ||
+               (min_spacing =3D=3D 1) ||
+               (min_spacing =3D=3D 2) ||
+               (min_spacing =3D=3D 3) ||
+               (min_spacing =3D=3D 4) ||
+               (min_spacing =3D=3D 6) ||
+               (min_spacing =3D=3D 8) ||
+               (min_spacing =3D=3D 10) ||
+               (min_spacing =3D=3D 12) ||
+               (min_spacing =3D=3D 14) ||
+               (min_spacing =3D=3D 16) ||
+               (min_spacing =3D=3D 18) ||
+               (min_spacing =3D=3D 20) ||
+               (min_spacing =3D=3D 24) ||
+               (min_spacing =3D=3D  CL_TX_MPDU_SPACING_INVALID));
+}
+
+static bool is_valid_cca_config(struct cl_hw *cl_hw, struct cl_tcv_conf *c=
onf)
+{
+       if (conf->ci_cca_ed_rise_thr_dbm <=3D conf->ci_cca_ed_fall_thr_dbm)=
 {
+               CL_DBG_ERROR(cl_hw, "cca_ed_rise_thr_dbm (%u) <=3D cca_ed_f=
all_thr_dbm (%u)\n",
+                            conf->ci_cca_ed_rise_thr_dbm, conf->ci_cca_ed_=
fall_thr_dbm);
+               return false;
+       }
+
+       if (conf->ci_cca_gi_rise_thr_dbm <=3D conf->ci_cca_gi_fall_thr_dbm)=
 {
+               CL_DBG_ERROR(cl_hw, "cca_gi_rise_thr_dbm (%u) <=3D cca_gi_f=
all_thr_dbm (%u)\n",
+                            conf->ci_cca_gi_rise_thr_dbm, conf->ci_cca_gi_=
fall_thr_dbm);
+               return false;
+       }
+
+       if (conf->ci_cca_gi_pow_lim_dbm <=3D conf->ci_cca_ed_rise_thr_dbm) =
{
+               CL_DBG_ERROR(cl_hw, "cca_gi_pow_lim_dbm (%u) <=3D cca_ed_ri=
se_thr_dbm (%u)\n",
+                            conf->ci_cca_gi_pow_lim_dbm, conf->ci_cca_ed_r=
ise_thr_dbm);
+               return false;
+       }
+
+       return true;
+}
+
+static enum cl_iface_conf get_iface_conf(struct cl_tcv_conf *conf)
+{
+       u8 i, num_ap =3D 0, num_sta =3D 0, num_mp =3D 0;
+
+       for (i =3D 0; i < conf->ce_bss_num; i++) {
+               if (conf->ce_iface_type[i] =3D=3D NL80211_IFTYPE_AP)
+                       num_ap++;
+               else if (conf->ce_iface_type[i] =3D=3D NL80211_IFTYPE_STATI=
ON)
+                       num_sta++;
+               else if (conf->ce_iface_type[i] =3D=3D NL80211_IFTYPE_MESH_=
POINT)
+                       num_mp++;
+       }
+
+       if (num_ap > 0 && num_sta =3D=3D 0 && num_mp =3D=3D 0)
+               return CL_IFCONF_AP;
+
+       if (num_ap =3D=3D 0 && num_sta =3D=3D 1 && num_mp =3D=3D 0)
+               return CL_IFCONF_STA;
+
+       if (num_ap =3D=3D 1 && num_sta =3D=3D 1 && num_mp =3D=3D 0)
+               return CL_IFCONF_REPEATER;
+
+       if (num_ap > 0 && num_sta =3D=3D 0 && num_mp =3D=3D 1)
+               return CL_IFCONF_MESH_AP;
+
+       if (num_ap =3D=3D 0 && num_sta =3D=3D 0 && num_mp =3D=3D 1)
+               return CL_IFCONF_MESH_ONLY;
+
+       return CL_IFCONF_MAX;
+}
+
+static int post_configuration(struct cl_hw *cl_hw)
+{
+       struct cl_tcv_conf *conf =3D cl_hw->conf;
+       struct cl_chip *chip =3D cl_hw->chip;
+
+       /* Production mode */
+       if (chip->conf->ce_production_mode) {
+               memcpy(cl_hw->rx_sensitivity, conf->ci_rx_sensitivity_prod,=
 MAX_ANTENNAS);
+               conf->ce_prot_mode =3D 0;
+               /* Production is done in station mode */
+               conf->ce_iface_type[0] =3D NL80211_IFTYPE_STATION;
+       } else {
+               memcpy(cl_hw->rx_sensitivity, conf->ci_rx_sensitivity_op, M=
AX_ANTENNAS);
+       }
+
+       cl_hw->iface_conf =3D get_iface_conf(conf);
+       if (cl_hw->iface_conf =3D=3D CL_IFCONF_MAX) {
+               CL_DBG_ERROR(cl_hw, "Invalid interface configuration\n");
+               return -EINVAL;
+       }
+
+       if (!is_valid_cca_config(cl_hw, conf))
+               return -EINVAL;
+
+       /* Validate: ce_bss_num */
+       if (conf->ce_bss_num > MAX_BSS_NUM) {
+               CL_DBG_ERROR(cl_hw, "Invalid ce_bss_num (%u). Must be <=3D =
%u\n",
+                            conf->ce_bss_num, MAX_BSS_NUM);
+               return -EINVAL;
+       }
+
+       /* Validate: ce_num_antennas, ce_rx_nss, ce_tx_nss */
+       if (conf->ce_num_antennas < MIN_ANTENNAS ||
+           conf->ce_num_antennas > MAX_ANTENNAS) {
+               CL_DBG_ERROR(cl_hw, "Invalid ce_num_antennas (%u)\n", conf-=
>ce_num_antennas);
+               return -EINVAL;
+       }
+
+       if (conf->ce_rx_nss < 1 ||
+           conf->ce_rx_nss > WRS_SS_MAX ||
+           conf->ce_rx_nss > conf->ce_num_antennas) {
+               CL_DBG_ERROR(cl_hw, "Invalid ce_rx_nss (%u)\n", conf->ce_rx=
_nss);
+               return -EINVAL;
+       }
+
+       if (conf->ce_tx_nss < 1 ||
+           conf->ce_tx_nss > WRS_SS_MAX ||
+           conf->ce_tx_nss > conf->ce_num_antennas) {
+               CL_DBG_ERROR(cl_hw, "Invalid ce_tx_nss (%u)\n", conf->ce_tx=
_nss);
+               return -EINVAL;
+       }
+
+       /* Validate: ce_cck_tx_ant_mask and ce_cck_rx_ant_mask */
+       if (cl_band_is_24g(cl_hw)) {
+               u8 ant_bitmap =3D ((1 << conf->ce_num_antennas) - 1);
+               u8 num_cck_ant_tx =3D hweight8(conf->ce_cck_tx_ant_mask);
+               u8 num_cck_ant_rx =3D hweight8(conf->ce_cck_rx_ant_mask);
+
+               if ((ant_bitmap & conf->ce_cck_tx_ant_mask) !=3D conf->ce_c=
ck_tx_ant_mask) {
+                       CL_DBG_ERROR(cl_hw, "Invalid ce_cck_tx_ant_mask (0x=
%x), "
+                                           "does not match ce_num_antennas=
 mask (0x%x)\n",
+                                    conf->ce_cck_tx_ant_mask, ant_bitmap);
+                       return -EINVAL;
+               }
+
+               if ((ant_bitmap & conf->ce_cck_rx_ant_mask) !=3D conf->ce_c=
ck_rx_ant_mask) {
+                       CL_DBG_ERROR(cl_hw, "Invalid ce_cck_rx_ant_mask (0x=
%x), "
+                                           "does not match ce_num_antennas=
 mask (0x%x)\n",
+                                    conf->ce_cck_rx_ant_mask, ant_bitmap);
+                       return -EINVAL;
+               }
+
+               if (conf->ce_cck_tx_ant_mask =3D=3D 0) {
+                       CL_DBG_ERROR(cl_hw, "Invalid ce_cck_tx_ant_mask, ca=
n't be 0x0\n");
+                       return -EINVAL;
+               }
+
+               if (conf->ce_cck_rx_ant_mask =3D=3D 0) {
+                       CL_DBG_ERROR(cl_hw, "Invalid ce_cck_rx_ant_mask, ca=
n't be 0x0\n");
+                       return -EINVAL;
+               }
+
+               if (num_cck_ant_tx > MAX_ANTENNAS_CCK) {
+                       CL_DBG_ERROR(cl_hw, "Invalid ce_cck_tx_ant_mask (0x=
%x), "
+                                           "number of set bits exceeds %u\=
n",
+                                    num_cck_ant_tx, MAX_ANTENNAS_CCK);
+                       return -EINVAL;
+               }
+
+               if (num_cck_ant_rx > MAX_ANTENNAS_CCK) {
+                       CL_DBG_ERROR(cl_hw, "Invalid ce_cck_rx_ant_mask (0x=
%x), "
+                                           "number of set bits exceeds %u\=
n",
+                                    num_cck_ant_rx, MAX_ANTENNAS_CCK);
+                       return -EINVAL;
+               }
+       }
+
+       if (cl_band_is_5g(cl_hw) && !(conf->ci_ofdm_only)) {
+               CL_DBG_ERROR(cl_hw, "ci_ofdm_only must be set to 1 for 5g b=
and\n");
+               return -EINVAL;
+       }
+
+       /* Validate ce_bcn_tx_path_min_time */
+       if (conf->ce_bcn_tx_path_min_time <=3D TX_BCN_PENDING_CHAIN_MIN_TIM=
E) {
+               CL_DBG_ERROR(cl_hw, "Invalid ce_bcn_tx_path_min_time (%u)\n=
",
+                            conf->ce_bcn_tx_path_min_time);
+               return -EINVAL;
+       }
+
+       if (conf->ci_tx_sw_amsdu_max_packets > MAX_TX_SW_AMSDU_PACKET) {
+               cl_dbg_err(cl_hw,
+                          "ERROR: Invalid ci_tx_sw_amsdu_max_packets (%u),=
 "
+                          "set default (%u)\n",
+                          conf->ci_tx_sw_amsdu_max_packets, MAX_TX_SW_AMSD=
U_PACKET);
+
+               conf->ci_tx_sw_amsdu_max_packets =3D MAX_TX_SW_AMSDU_PACKET=
;
+       }
+
+       if (conf->ce_tx_power_control > 100 || conf->ce_tx_power_control < =
1) {
+               cl_dbg_err(cl_hw,
+                          "ERROR: Invalid ce_tx_power_control (%u), set de=
fault 100\n",
+                          conf->ce_tx_power_control);
+
+               conf->ce_tx_power_control =3D 100;
+       }
+
+       if (conf->ce_max_retry > CL_MAX_NUM_OF_RETRY) {
+               cl_dbg_err(cl_hw,
+                          "ERROR: Invalid ce_max_retry (%u), "
+                          "set default to maximum (%u)\n",
+                          conf->ce_max_retry, CL_MAX_NUM_OF_RETRY);
+
+               conf->ce_max_retry =3D CL_MAX_NUM_OF_RETRY;
+       }
+
+       if (!is_valid_min_spacing(conf->ci_su_force_min_spacing)) {
+               cl_dbg_err(cl_hw,
+                          "ERROR: Invalid ci_su_force_min_spacing (%u), mu=
st "
+                          "be 0/1/2/3/4/6/8/10/12/14/16/18/20/24, set defa=
ult %u\n",
+                          conf->ci_su_force_min_spacing, CL_TX_MPDU_SPACIN=
G_INVALID);
+
+               conf->ci_su_force_min_spacing =3D CL_TX_MPDU_SPACING_INVALI=
D;
+       }
+
+       if (!is_valid_min_spacing(conf->ci_mu_force_min_spacing)) {
+               cl_dbg_err(cl_hw,
+                          "ERROR: Invalid ci_mu_force_min_spacing (%u), mu=
st "
+                          "be 0/1/2/3/4/6/8/10/12/14/16/18/20/24, set defa=
ult %u\n",
+                          conf->ci_mu_force_min_spacing, CL_TX_MPDU_SPACIN=
G_INVALID);
+
+               conf->ci_mu_force_min_spacing =3D CL_TX_MPDU_SPACING_INVALI=
D;
+       }
+
+       if (conf->ha_max_mpdu_len !=3D IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_38=
95 &&
+           conf->ha_max_mpdu_len !=3D IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_79=
91 &&
+           conf->ha_max_mpdu_len !=3D IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11=
454) {
+               cl_dbg_err(cl_hw,
+                          "ERROR: Invalid 'ha_max_mpdu_len' (%u). "
+                          "Must be 0/1/2. Setting to 0\n",
+                          conf->ha_max_mpdu_len);
+
+               conf->ha_max_mpdu_len =3D IEEE80211_VHT_CAP_MAX_MPDU_LENGTH=
_3895;
+       }
+
+       if (cl_hw_is_tcv1(cl_hw) && cl_chip_is_both_enabled(chip)) {
+               /*
+                * Check that sum of ce_num_antennas in both TCV's is small=
er
+                * than max_antennas
+                */
+               struct cl_hw *cl_hw_tcv0 =3D chip->cl_hw_tcv0;
+               u8 num_ant_tcv0 =3D cl_hw_tcv0->conf->ce_num_antennas;
+               u8 num_ant_tcv1 =3D conf->ce_num_antennas;
+               u8 total_ant =3D num_ant_tcv0 + num_ant_tcv1;
+
+               if (total_ant > chip->max_antennas) {
+                       CL_DBG_ERROR(cl_hw,
+                                    "Invalid ce_num_antennas tcv0=3D%u, "
+                                    "tcv1=3D%u, total=3D%u, max=3D%u\n",
+                                    num_ant_tcv0, num_ant_tcv1,
+                                    total_ant, chip->max_antennas);
+                       return -EINVAL;
+               }
+
+               if (cl_hw_tcv0->conf->ci_band_num =3D=3D 5 &&
+                   cl_hw->conf->ci_band_num =3D=3D 5) {
+                       u8 bw_tcv0 =3D cl_hw_tcv0->conf->ce_channel_bandwid=
th;
+                       u8 bw_tcv1 =3D cl_hw->conf->ce_channel_bandwidth;
+
+                       if (bw_tcv0 =3D=3D CHNL_BW_80 && bw_tcv1 =3D=3D CHN=
L_BW_80) {
+                               chip->conf->ci_dma_lli_max_chan[0] =3D 8;
+                               chip->conf->ci_dma_lli_max_chan[1] =3D 8;
+
+                               cl_dbg_verbose(cl_hw, "Overwrite ci_dma_lli=
_max_chan to 8,8\n");
+                       }
+               }
+       }
+
+       if (chip->conf->ce_production_mode && !conf->ce_power_offset_prod_e=
n) {
+               cl_dbg_err(cl_hw, "Disable PPMCS/PPBW in production mode\n"=
);
+
+               if (cl_band_is_6g(cl_hw)) {
+                       memset(conf->ce_ppmcs_offset_he_6g, 0,
+                              sizeof(conf->ce_ppmcs_offset_he_6g));
+               } else if (cl_band_is_5g(cl_hw)) {
+                       memset(conf->ce_ppmcs_offset_he_36_64, 0,
+                              sizeof(conf->ce_ppmcs_offset_he_36_64));
+                       memset(conf->ce_ppmcs_offset_he_100_140, 0,
+                              sizeof(conf->ce_ppmcs_offset_he_100_140));
+                       memset(conf->ce_ppmcs_offset_he_149_165, 0,
+                              sizeof(conf->ce_ppmcs_offset_he_149_165));
+                       memset(conf->ce_ppmcs_offset_ht_vht_36_64, 0,
+                              sizeof(conf->ce_ppmcs_offset_ht_vht_36_64));
+                       memset(conf->ce_ppmcs_offset_ht_vht_100_140, 0,
+                              sizeof(conf->ce_ppmcs_offset_ht_vht_100_140)=
);
+                       memset(conf->ce_ppmcs_offset_ht_vht_149_165, 0,
+                              sizeof(conf->ce_ppmcs_offset_ht_vht_149_165)=
);
+                       memset(conf->ce_ppmcs_offset_ofdm_36_64, 0,
+                              sizeof(conf->ce_ppmcs_offset_ofdm_36_64));
+                       memset(conf->ce_ppmcs_offset_ofdm_100_140, 0,
+                              sizeof(conf->ce_ppmcs_offset_ofdm_100_140));
+                       memset(conf->ce_ppmcs_offset_ofdm_149_165, 0,
+                              sizeof(conf->ce_ppmcs_offset_ofdm_149_165));
+               } else {
+                       memset(conf->ce_ppmcs_offset_he, 0, sizeof(conf->ce=
_ppmcs_offset_he));
+                       memset(conf->ce_ppmcs_offset_ht, 0, sizeof(conf->ce=
_ppmcs_offset_ht));
+                       memset(conf->ce_ppmcs_offset_ofdm, 0, sizeof(conf->=
ce_ppmcs_offset_ofdm));
+                       memset(conf->ce_ppmcs_offset_cck, 0, sizeof(conf->c=
e_ppmcs_offset_cck));
+               }
+
+               memset(conf->ce_ppbw_offset, 0, sizeof(conf->ce_ppbw_offset=
));
+       }
+
+       if (conf->ce_twt_default_min_wake_duration > conf->ce_twt_default_i=
nterval) {
+               CL_DBG_ERROR(cl_hw,
+                            "ce_twt_default_min_wake_duration > "
+                            "ce_twt_default_interval\n");
+               return -EINVAL;
+       }
+
+       /* 6g supports HE only */
+       if (cl_band_is_6g(cl_hw) && conf->ce_wireless_mode < WIRELESS_MODE_=
HE) {
+               CL_DBG_ERROR(cl_hw,
+                            "Invalid wireless_mode (%u) for 6g\n",
+                            conf->ce_wireless_mode);
+               return -EINVAL;
+       }
+
+       if (cl_calib_validate_ants(cl_hw))
+               return -EINVAL;
+
+       if (conf->ce_twt_max_sessions > CL_TWT_MAX_SESSIONS) {
+               cl_dbg_err(cl_hw,
+                          "ce_twt_max_sessions (%u) is too high. "
+                          "Setting it to the max value %u\n",
+                          conf->ce_twt_max_sessions, CL_TWT_MAX_SESSIONS);
+               conf->ce_twt_max_sessions =3D CL_TWT_MAX_SESSIONS;
+       }
+
+       if (!cl_band_is_24g(cl_hw) && conf->ci_signal_extension_en) {
+               cl_dbg_err(cl_hw,
+                          "ERROR: Invalid 'ci_signal_extension_en' (%u). "
+                          "Must be 0 for non 2.4Ghz band. Setting to 0\n",
+                          conf->ce_dyn_mcast_rate_en);
+
+               conf->ci_signal_extension_en =3D false;
+       }
+
+       if (conf->ce_dyn_mcast_rate_en && cl_band_is_6g(cl_hw)) {
+               cl_dbg_err(cl_hw,
+                          "ERROR: Invalid 'ce_dyn_mcast_rate_en' (%u). "
+                          "Must be 0 on 6Ghz band. Setting to 0\n",
+                          conf->ce_dyn_mcast_rate_en);
+
+               conf->ce_dyn_mcast_rate_en =3D 0;
+       }
+
+       if (conf->ce_dyn_bcast_rate_en && cl_band_is_6g(cl_hw)) {
+               cl_dbg_err(cl_hw,
+                          "ERROR: Invalid 'ce_dyn_bcast_rate_en' (%u). "
+                          "Must be 0 on 6Ghz band. Setting to 0\n",
+                          conf->ce_dyn_bcast_rate_en);
+
+               conf->ce_dyn_bcast_rate_en =3D 0;
+       }
+
+       return 0;
+}
+
+int cl_tcv_config_read(struct cl_hw *cl_hw)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       char *buf =3D NULL;
+       size_t size =3D 0;
+       int ret =3D 0;
+       char filename[CL_FILENAME_MAX] =3D {0};
+       u8 tcv_idx =3D cl_hw->idx;
+
+       snprintf(filename, sizeof(filename), "cl_tcv%u.dat", tcv_idx);
+       pr_debug("%s: %s\n", __func__, filename);
+       size =3D cl_file_open_and_read(chip, filename, &buf);
+
+       if (!buf) {
+               pr_err("read %s failed !!!\n", filename);
+               return -ENODATA;
+       }
+
+       ret =3D set_all_params_from_buf(cl_hw, buf, size);
+       if (ret) {
+               kfree(buf);
+               return ret;
+       }
+
+       kfree(buf);
+
+       ret =3D post_configuration(cl_hw);
+
+       return ret;
+}
+
+int cl_tcv_config_set(struct cl_hw *cl_hw, char *buf, size_t size)
+{
+       size_t new_size =3D size + 1;
+       char *new_buf =3D kzalloc(new_size, GFP_KERNEL);
+       int ret;
+
+       if (!new_buf)
+               return -ENOMEM;
+
+       /* Add '\n' at the end of the string, before the NULL */
+       memcpy(new_buf, buf, size);
+       new_buf[size - 1] =3D '\n';
+
+       ret =3D set_all_params_from_buf(cl_hw, new_buf, new_size);
+       if (ret =3D=3D 0)
+               ret =3D post_configuration(cl_hw);
+
+       kfree(new_buf);
+
+       return ret;
+}
+
+u8 cl_tcv_config_get_num_ap(struct cl_hw *cl_hw)
+{
+       struct cl_tcv_conf *conf =3D cl_hw->conf;
+       u8 types_cnt =3D min_t(u8, conf->ce_bss_num, ARRAY_SIZE(conf->ce_if=
ace_type));
+       u8 i;
+       u8 num_ap =3D 0;
+
+       for (i =3D 0; i < types_cnt; i++)
+               if (conf->ce_iface_type[i] =3D=3D NL80211_IFTYPE_AP)
+                       num_ap++;
+
+       return num_ap;
+}
+
+int cl_tcv_config_alloc(struct cl_hw *cl_hw)
+{
+       cl_hw->conf =3D kzalloc(sizeof(*cl_hw->conf), GFP_KERNEL);
+
+       if (!cl_hw->conf)
+               return -ENOMEM;
+
+       /* Copy default values */
+       memcpy(cl_hw->conf, &conf, sizeof(*cl_hw->conf));
+
+       return 0;
+}
+
+void cl_tcv_config_free(struct cl_hw *cl_hw)
+{
+       kfree(cl_hw->conf);
+       cl_hw->conf =3D NULL;
+}
+
+void cl_tcv_config_print(struct cl_hw *cl_hw)
+{
+       struct cl_tcv_conf *conf =3D cl_hw->conf;
+
+       pr_debug("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D\n");
+       pr_debug("  TCV%u configuration\n", cl_hw->tcv_idx);
+       pr_debug("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D\n");
+
+       print_unsigned(ce_bss_num);
+       print_signed(ce_debug_level);
+       print_bool(ce_radio_on);
+       print_bool(ce_ps_ctrl_enabled);
+       print_unsigned(ha_channel);
+       print_bool(ci_ieee80211w);
+       print_bool(ci_ieee80211h);
+       print_unsigned(ha_short_guard_interval);
+       print_unsigned(ha_max_mpdu_len);
+       print_unsigned(ha_vht_max_ampdu_len_exp);
+       print_unsigned(ha_beacon_int);
+       print_str(ce_dsp_code);
+       print_str(ce_dsp_data);
+       print_str(ce_dsp_external_data);
+       print_bool(ce_uapsd_en);
+       print_bool(ci_eirp_regulatory_en);
+       print_bool(ci_agg_tx);
+       print_bool(ci_agg_rx);
+       print_bool(ce_txldpc_en);
+       print_bool(ce_ht_rxldpc_en);
+       print_bool(ce_vht_rxldpc_en);
+       print_bool(ce_he_rxldpc_en);
+       print_bool(ci_cs_required);
+       print_signed_arr(ci_rx_sensitivity_prod, MAX_ANTENNAS);
+       print_signed_arr(ci_rx_sensitivity_op, MAX_ANTENNAS);
+       print_bool(ce_cck_bcn_en);
+       print_bool(ci_min_he_en);
+       print_hex(ce_cck_tx_ant_mask);
+       print_hex(ce_cck_rx_ant_mask);
+       print_unsigned(ce_rx_nss);
+       print_unsigned(ce_tx_nss);
+       print_unsigned(ce_num_antennas);
+       print_unsigned(ce_wireless_mode);
+       print_unsigned_arr(ha_wmm_enabled, MAX_BSS_NUM);
+       print_unsigned(ce_max_agg_size_tx);
+       print_unsigned(ce_max_agg_size_rx);
+       print_bool(ce_rxamsdu_en);
+       print_unsigned(ce_txamsdu_en);
+       print_unsigned(ci_tx_amsdu_min_data_rate);
+       print_unsigned(ci_tx_sw_amsdu_max_packets);
+       print_unsigned(ci_tx_packet_limit);
+       print_unsigned(ci_tx_queue_size_agg);
+       print_unsigned(ci_tx_queue_size_single);
+       print_unsigned_arr(ci_ipc_rxbuf_size, CL_RX_BUF_MAX);
+       print_unsigned(ce_max_retry);
+       print_unsigned(ce_short_retry_limit);
+       print_unsigned(ce_long_retry_limit);
+       print_unsigned(ci_assoc_auth_retry_limit);
+       print_unsigned(ce_channel_bandwidth);
+       print_unsigned_arr(ce_iface_type, MAX_BSS_NUM);
+       print_unsigned(ha_hw_mode);
+       print_signed(ce_temp_comp_slope);
+       print_unsigned(ci_fw_dbg_severity);
+       print_hex(ci_fw_dbg_module);
+       print_unsigned(ci_hal_idle_to);
+       print_unsigned(ci_tx_ac0_to);
+       print_unsigned(ci_tx_ac1_to);
+       print_unsigned(ci_tx_ac2_to);
+       print_unsigned(ci_tx_ac3_to);
+       print_unsigned(ci_tx_bcn_to);
+       print_str(ce_hardware_power_table);
+       print_str(ce_arr_gain);
+       print_str(ce_bf_gain_2_ant);
+       print_str(ce_bf_gain_3_ant);
+       print_str(ce_bf_gain_4_ant);
+       print_str(ce_bf_gain_5_ant);
+       print_str(ce_bf_gain_6_ant);
+       print_str(ce_ant_gain);
+       print_str(ce_ant_gain_36_64);
+       print_str(ce_ant_gain_100_140);
+       print_str(ce_ant_gain_149_165);
+       print_str(ci_min_ant_pwr);
+       print_str(ci_bw_factor);
+       print_unsigned(ce_mcast_rate);
+       print_bool(ce_dyn_mcast_rate_en);
+       print_bool(ce_dyn_bcast_rate_en);
+       print_unsigned(ce_default_mcs_ofdm);
+       print_unsigned(ce_default_mcs_cck);
+       print_bool(ce_prot_log_nav_en);
+       print_unsigned(ce_prot_mode);
+       print_unsigned(ce_prot_rate_format);
+       print_unsigned(ce_prot_rate_mcs);
+       print_unsigned(ce_prot_rate_pre_type);
+       print_unsigned(ce_bw_signaling_mode);
+       print_unsigned(ci_dyn_cts_sta_thr);
+       print_signed(ci_vns_pwr_limit);
+       print_unsigned(ci_vns_pwr_mode);
+       print_signed(ci_vns_rssi_auto_resp_thr);
+       print_signed(ci_vns_rssi_thr);
+       print_signed(ci_vns_rssi_hys);
+       print_unsigned(ci_vns_maintenance_time);
+       print_unsigned(ce_bcn_tx_path_min_time);
+       print_bool(ci_backup_bcn_en);
+       print_bool(ce_tx_txop_cut_en);
+       print_unsigned(ci_bcns_flushed_cnt_thr);
+       print_bool(ci_phy_err_prevents_phy_dump);
+       print_unsigned(ci_tx_rx_delay);
+       print_unsigned(ci_fw_assert_time_diff_sec);
+       print_unsigned(ci_fw_assert_storm_detect_thd);
+       print_unsigned(ce_hw_assert_time_max);
+       print_unsigned(ce_fw_watchdog_mode);
+       print_unsigned(ce_fw_watchdog_limit_count);
+       print_unsigned(ce_fw_watchdog_limit_time);
+       print_signed(ci_rx_remote_cpu_drv);
+       print_signed(ci_rx_remote_cpu_mac);
+       print_signed(ci_tx_remote_cpu);
+       print_unsigned(ci_pending_queue_size);
+       print_unsigned(ce_tx_power_control);
+       print_bool(ce_standby_mode_en);
+       print_bool(ce_coex_en);
+       print_unsigned(ce_extension_channel);
+       print_unsigned(ci_dfs_initial_gain);
+       print_unsigned(ci_dfs_agc_cd_th);
+       print_unsigned(ci_dfs_long_pulse_min);
+       print_unsigned(ci_dfs_long_pulse_max);
+       print_str(ce_dfs_tbl_overwrite);
+       print_str(ce_dfs_jump_channels);
+       print_signed_arr(ce_ppmcs_offset_he_36_64, WRS_MCS_MAX_HE);
+       print_signed_arr(ce_ppmcs_offset_he_100_140, WRS_MCS_MAX_HE);
+       print_signed_arr(ce_ppmcs_offset_he_149_165, WRS_MCS_MAX_HE);
+       print_signed_arr(ce_ppmcs_offset_he_6g, WRS_MCS_MAX_HE);
+       print_signed_arr(ce_ppmcs_offset_ht_vht_36_64, WRS_MCS_MAX_VHT);
+       print_signed_arr(ce_ppmcs_offset_ht_vht_100_140, WRS_MCS_MAX_VHT);
+       print_signed_arr(ce_ppmcs_offset_ht_vht_149_165, WRS_MCS_MAX_VHT);
+       print_signed_arr(ce_ppmcs_offset_ofdm_36_64, WRS_MCS_MAX_OFDM);
+       print_signed_arr(ce_ppmcs_offset_ofdm_100_140, WRS_MCS_MAX_OFDM);
+       print_signed_arr(ce_ppmcs_offset_ofdm_149_165, WRS_MCS_MAX_OFDM);
+       print_signed_arr(ce_ppmcs_offset_he, WRS_MCS_MAX_HE);
+       print_signed_arr(ce_ppmcs_offset_ht, WRS_MCS_MAX_HT);
+       print_signed_arr(ce_ppmcs_offset_ofdm, WRS_MCS_MAX_OFDM);
+       print_signed_arr(ce_ppmcs_offset_cck, WRS_MCS_MAX_CCK);
+       print_signed_arr(ce_ppbw_offset, CHNL_BW_MAX);
+       print_bool(ce_power_offset_prod_en);
+       print_bool(ce_bf_en);
+       print_unsigned(ci_bf_max_nss);
+       print_unsigned_arr(ce_sounding_interval_coefs, SOUNDING_INTERVAL_CO=
EF_MAX);
+       print_unsigned_arr(ci_rate_fallback, CL_RATE_FALLBACK_MAX);
+       print_unsigned(ce_rx_pkts_budget);
+       print_unsigned(ci_band_num);
+       print_bool(ci_mult_ampdu_in_txop_en);
+       print_unsigned_arr(ce_wmm_aifsn, AC_MAX);
+       print_unsigned_arr(ce_wmm_cwmin, AC_MAX);
+       print_unsigned_arr(ce_wmm_cwmax, AC_MAX);
+       print_unsigned_arr(ce_wmm_txop, AC_MAX);
+       print_unsigned(ci_su_force_min_spacing);
+       print_unsigned(ci_mu_force_min_spacing);
+       print_unsigned(ci_tf_mac_pad_dur);
+       print_unsigned(ci_cca_timeout);
+       print_unsigned(ce_tx_ba_session_timeout);
+       print_bool(ci_motion_sense_en);
+       print_unsigned(ci_motion_sense_rssi_thr);
+       print_unsigned(ci_wrs_max_bw);
+       print_unsigned(ci_wrs_min_bw);
+       print_signed_arr(ci_wrs_fixed_rate, WRS_FIXED_PARAM_MAX);
+       print_unsigned_arr(ce_he_mcs_nss_supp_tx, WRS_SS_MAX);
+       print_unsigned_arr(ce_he_mcs_nss_supp_rx, WRS_SS_MAX);
+       print_unsigned_arr(ce_vht_mcs_nss_supp_tx, WRS_SS_MAX);
+       print_unsigned_arr(ce_vht_mcs_nss_supp_rx, WRS_SS_MAX);
+       print_unsigned(ci_pe_duration);
+       print_unsigned(ci_pe_duration_bcast);
+       print_unsigned(ci_coredump_diff_time_ms);
+       print_unsigned(ci_gain_update_enable);
+       print_unsigned(ci_mcs_sig_b);
+       print_unsigned(ci_spp_ksr_value);
+       print_bool(ci_rx_padding_en);
+       print_bool(ci_stats_en);
+       print_bool(ci_bar_disable);
+       print_bool(ci_ofdm_only);
+       print_bool(ci_drop_to_lower_bw);
+       print_bool(ce_twt_en);
+       print_bool(ci_csd_en);
+       print_unsigned(ce_twt_default_interval);
+       print_unsigned(ce_twt_default_min_wake_duration);
+       print_unsigned(ce_twt_max_sessions);
+       print_unsigned_arr(ci_hr_factor, CHNL_BW_MAX);
+       print_bool(ci_signal_extension_en);
+       print_unsigned_arr(ce_dscp_vlan_enable, MAX_BSS_NUM);
+       print_unsigned_arr(ce_up0_7_default_vlan_user_prio, MAX_BSS_NUM);
+       print_unsigned_arr(ce_up0_7_layer_based, MAX_BSS_NUM);
+       print_str(ce_dscp_to_up0_7dec0);
+       print_str(ce_dscp_to_up0_7dec1);
+       print_str(ce_dscp_to_up0_7dec2);
+       print_str(ce_dscp_to_up0_7dec3);
+       print_str(ce_dscp_to_up0_7dec4);
+       print_str(ce_dscp_to_up0_7dec5);
+       print_str(ce_dscp_to_up0_7dec6);
+       print_str(ce_dscp_to_up0_7dec7);
+       print_str(ce_vlan_to_up0_7dec0);
+       print_str(ce_vlan_to_up0_7dec1);
+       print_str(ce_vlan_to_up0_7dec2);
+       print_str(ce_vlan_to_up0_7dec3);
+       print_str(ce_vlan_to_up0_7dec4);
+       print_str(ce_vlan_to_up0_7dec5);
+       print_str(ce_vlan_to_up0_7dec6);
+       print_str(ce_vlan_to_up0_7dec7);
+       print_bool(ci_vht_cap_24g);
+       print_bool(ce_omi_en);
+       print_hex(ci_tx_digital_gain);
+       print_hex(ci_tx_digital_gain_cck);
+       print_signed(ci_ofdm_cck_power_offset);
+       print_bool(ci_mac_clk_gating_en);
+       print_bool(ci_phy_clk_gating_en);
+       print_bool(ci_imaging_blocker);
+       print_hex(ci_ndp_tx_chain_mask);
+       print_unsigned(ci_ndp_tx_bw);
+       print_unsigned(ci_ndp_tx_format);
+       print_unsigned(ci_ndp_tx_num_ltf);
+       print_unsigned_arr(ci_calib_ant_tx, MAX_ANTENNAS);
+       print_unsigned_arr(ci_calib_ant_rx, MAX_ANTENNAS);
+       print_signed(ci_cca_ed_rise_thr_dbm);
+       print_signed(ci_cca_ed_fall_thr_dbm);
+       print_hex(ci_cca_cs_en);
+       print_hex(ci_cca_modem_en);
+       print_hex(ci_cca_main_ant);
+       print_hex(ci_cca_second_ant);
+       print_hex(ci_cca_flag0_ctrl);
+       print_hex(ci_cca_flag1_ctrl);
+       print_hex(ci_cca_flag2_ctrl);
+       print_hex(ci_cca_flag3_ctrl);
+       print_signed(ci_cca_gi_rise_thr_dbm);
+       print_signed(ci_cca_gi_fall_thr_dbm);
+       print_signed(ci_cca_gi_pow_lim_dbm);
+       print_hex(ci_cca_ed_en);
+       print_hex(ci_cca_gi_en);
+       print_bool(ci_rx_he_mu_ppdu);
+       print_bool(ci_fast_rx_en);
+       print_unsigned(ci_distance_auto_resp_all);
+       print_unsigned(ci_distance_auto_resp_msta);
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

