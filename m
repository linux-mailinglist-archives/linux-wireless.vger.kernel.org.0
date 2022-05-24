Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96E3532970
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbiEXLka (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236105AbiEXLk1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:40:27 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC7A8DDC7
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n74o+2dNyF9phE9J673q+zk3OfJQuC6YqEt1q5YmIuHQ3lJUYDnuOXIaygcYC9lIBt5Qcve9UWBjksTp1nkGuKLv4rEtDXhDqmSlghnXdGAdUifvj1/VjB4bfNZIzbMQYPYdfUp6NvUuLA2dvdVGb+4J4yWhlWfBsu5Yn2uAFB77HkZSGYDAG7nSWRm5lxIHNvYs+Atfb1XE/AZ1NeqVjEmUTlgUcIQ7ASzdyvL7WnXk9gmmPBCnPqeEvtnlgcFgBui5udZjxvdGLyDMTOoAObnSjneStBqGLqLGYLk2m0enQChWxbrjDg2IArl09U19EcDXYGJJUivCAfCmu9Us6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9hpv4aDcmsApscyn6Y4MAEnUt5bAohDeoAFauk6axw=;
 b=LMLzU5SMUG+5JkqXLn32xBtBeU0VKRGpNugqYl9flE0/7jQmNG32RY9jfMahkWyUk0DmqDLFVAjW8s9huNgU70Wj8nkZ7yDDvZSduIyL3G9F83LB6vgIRKlviWI5WSGrjC+yfaqe0BdN3d8Yuq1kfR/SsQcC/Qmw99QIERpK0/a7xbqLcUriGT0nNyTw2Ow+F3LT316Ess9aN8X1wuZ/cuCIQt7JwGXhqBIFqpBriNYS1nvX02Ok6H/fM4KlJahfs2d2o0qSMQkGOZY5bGC4Ika1TdD/A938qjcFBddgHVosuJjNA8j2SbDDdM9lHLK8COEz4FjevoBHeVardulY4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9hpv4aDcmsApscyn6Y4MAEnUt5bAohDeoAFauk6axw=;
 b=n3d+RF6I1uBriEB8Y6bues9zBx0Sh6H3PVcPrgE6yecDCqGV6Cq8lsesjtL9foiQoUUmkJ3neTiJCEXt8kMzUKMcLHfQxGsJa/mjeMRaPmsM0dVnUgQojDmkZ8ZFwdLQaL3iGnaZKn0Ltqrw8P03PoBB1oFyxPoTaoWUo78QeQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VE1P192MB0669.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:16f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:39:28 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:28 +0000
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
Subject: [RFC v2 78/96] cl8k: add tcv.c
Date:   Tue, 24 May 2022 14:34:44 +0300
Message-Id: <20220524113502.1094459-79-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: e84ddf78-802a-4c57-b2c1-08da3d79f9fb
X-MS-TrafficTypeDiagnostic: VE1P192MB0669:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VE1P192MB0669F69215B64D7D665A92EEF6D79@VE1P192MB0669.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELKIofXPVk5lkIKICq1XAoppm7oKc58bG/cE7uLuxE6WIBxDKxGqV14Kb525ObLgCrT51eNbXdgVMmSdlkCN0oRn8y1o6cK7h4nOQyHk4gTE7vi6PATeC56MSh0542TKS29fQQt1p+uu+rMnFeIKZmHmsO0L4oFRlnr0UYBj9V1QWF6a9tugYUC+TdOvBuX39wgnzxsIOShHi8wZ16U7hHLwywPxSp61z5NvYgvmyFPxYQ03Z7yds7YwNSB2G39Bvw4wjG0r9abVl+k5aQ4Pp7hnMpfLqh67s9YJS0tg0YWpG3keCWvlmIDVVzPxb0msrgRr6TwcKHkNBemnzIW4TFwMxquCYYHNRuWB1MFU4nOj2iGJUQFgTB3fN73HLwYawocvU2syGjWSVV5eoHE30S75eXFvOOWquqV2OhXODRzE1Ys/nELCvYiT1QSAL+1T3ymhYL5eo8RsCRlac49bepgVrxjDQ7KCV4drsEYjByvnlsNdvAnA0cbyFv+qudmEZamWJEpbTdTVS+b1smBMuZFb6JMMj/XqDxLHg3dCUkeNOUA7UBBcQ/nMXLvmzA1ybtBEcWffFzHqo7g3nceMV/cut6d2znJD9XpL9pMPQqI4BpNDHnNtIa2WVq/55nfZ3+ZBq6RA5GZwzRRtjG3MMu1F04P7NSF5vyVrOCH6v4wZRsNSITXafbn649L5rdZnbPs114xWE0uqEwhNFd4Ds6x82UYGS/Z0E1hPoUZffz0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(376002)(136003)(366004)(346002)(39850400004)(8676002)(9686003)(26005)(36756003)(66946007)(66556008)(66476007)(4326008)(107886003)(83380400001)(6512007)(5660300002)(38350700002)(38100700002)(1076003)(2616005)(316002)(6916009)(6506007)(6486002)(54906003)(86362001)(8936002)(508600001)(41300700001)(6666004)(2906002)(186003)(52116002)(30864003)(32563001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QF29h8pB6RAXTEyBSW8mkaO/8wiOyhznmUNs3p61fqiHYkdiltTCC68nm8JE?=
 =?us-ascii?Q?Yef58uQ/Ol9VPnyyXfe96Fs95G3s39yTkXQtLTXvLvpXp3V+YEpTBZtZxp6A?=
 =?us-ascii?Q?CTLdZjWPxlUGz3jf7oopWC/d1KMX3JVObxIuBHgFO2RI7Jwwer0OChgfwkk5?=
 =?us-ascii?Q?DnmL3a0+bKnQx9N54+oPvui6Ct3Ids+4UvLeHT47tBoPyV3pQ2yaMMxc8fwr?=
 =?us-ascii?Q?KU46ucxgICxK9zZ3G0+fV4Ap2kJMRYdsNhjbvJQiNwmXCp32MXEGty9qxMUZ?=
 =?us-ascii?Q?YLCbmiNNytpK7cClCxUgrTZFXBzn7iiO0SmwHt7NSlAEcRcV5Ilw6aUanlqO?=
 =?us-ascii?Q?8s4BxXDdja4kZbAQJABeP1baFnqhKeNDJNRPgWc5FCB6IWVjO3cq1bKWfuSD?=
 =?us-ascii?Q?5LX5AEiJqdOQ1IyL6GU5/mc/Z/DTTQQWP3vBMWObhMLbIdiPfc7XLqRCwlj3?=
 =?us-ascii?Q?SnMC+hL/rlkPm8mBG3Jj6PgpHnRMQ1PAVMudWmYDIBznYmEzGnI+Vae2Tu3p?=
 =?us-ascii?Q?6/LD+XxAImNVCHMIsvka/HdFVRxjDRKhEfLg6Jo7hwOvATqRpoznHr+mQ3/G?=
 =?us-ascii?Q?FhoVvIagqcisYtI6sZxwlBGr7MxDXaUbfxpvNiCS3BQCBIuwmpsIxUUERg4P?=
 =?us-ascii?Q?ylL3YTHpf8z0yzNhuztND1ZA7pGt41PG25+rfp0KK4kTZXLqnblbv9GZb/lW?=
 =?us-ascii?Q?QU8WxepRRRww6ElfTsXnEqcPxoiNpSvhq6p/nz7a6I1b6e6578cdKaSNFqyE?=
 =?us-ascii?Q?b4GJwED363xcdetXX3O2EgX4HS1BnS//EaScPUmEVcFNcUJvJYZYOshfOXBw?=
 =?us-ascii?Q?NJdbfl9zUwCZ8RWV5XFqaSXxKYVNB/wPROkrZSTpmNQBtng41x9VVK62SBv9?=
 =?us-ascii?Q?3H/pieLVTrhc2rIBZpObdJb31yhORpRziBLr/JrQKeSKDoDGs8pmlHig52F7?=
 =?us-ascii?Q?OEJIUm20m3ZppMGmcbckDs+Yht5nAbMgrBxYqS2X02JnWYobHYXVMkNwGnAD?=
 =?us-ascii?Q?xhioPL4qxeseZgMYIY7QMiWiX2IFiNZVdYIJ/g1nw0HL8MOw0R87hlubvvPs?=
 =?us-ascii?Q?otwiBn1JYkdzmczCz8I7l23YqkV3JRrNIPoT2Y68TdJZ0SC7ODLvpldPhFyW?=
 =?us-ascii?Q?ekcGQK34pGUxfymyVHkY7yiZvzldIywYZru3EJIH/VPdv3DhHcwIU1urlDbn?=
 =?us-ascii?Q?7g6i1C4+lFJqGgVTDXHL0w6ECNybPrUDnX9ubpB0JJmsp3yjNPDoCZmpGYSw?=
 =?us-ascii?Q?WAU2tGoO8rIk3mpRse+ymQ2BBWC9GzbaqOTd5Ry4rkSZZZ7sBYurWHtkEepH?=
 =?us-ascii?Q?nZrdcH0UlW6t1a/5LfZh1kNkUtwuy+W+SZcPUiRgO35TXtnCfZ2MqXzKLpH4?=
 =?us-ascii?Q?vRQ0Txco9aITCoJPAGutr2/OjnePj3s/BIPmZiykh57nZ18L1bOd7qls5aAO?=
 =?us-ascii?Q?pwpwPFX53VnahPPwYDpQjLCpjbUijXH+xwcF0vMklEi8EppWgrd/gvuWk5jZ?=
 =?us-ascii?Q?o9j8WADAeADFfJn8fPFyva2KL+BzE3EX2uIqcC9612iWjEal0T9jfsM3B8LK?=
 =?us-ascii?Q?RPayrs+WYcUbgGXlYNLsjtgioeUKlWCJCNXCf4DxsjYrt9f9ZzeUko2Nuxr7?=
 =?us-ascii?Q?1TJqUpUIyE9AbhENNRfv/n5KmHGOcjRFfNmVVYbcxyRj0D5UKl6jX5bgt7ZD?=
 =?us-ascii?Q?MU6CTaLpZOfR8HBe5mpz7mKDzWsiKo3viS9E0jj13q1bVVXf37cKMQfyvFnt?=
 =?us-ascii?Q?KSZIvosP0zIVqoQUGRUkDOFR+wgkxVE=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e84ddf78-802a-4c57-b2c1-08da3d79f9fb
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:52.2736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pspCXPTnzsg0AsgQI5UZ9ZQvssvq6O4H0So7vckhoFiTrMW3o/INo1P5hFYf/6BX+Aw8InXhdw9OFaW9KP6AQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P192MB0669
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
 drivers/net/wireless/celeno/cl8k/tcv.c | 1259 ++++++++++++++++++++++++
 1 file changed, 1259 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tcv.c

diff --git a/drivers/net/wireless/celeno/cl8k/tcv.c b/drivers/net/wireless/celeno/cl8k/tcv.c
new file mode 100644
index 000000000000..1a17c4f4445a
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tcv.c
@@ -0,0 +1,1259 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include <linux/slab.h>
+#include <linux/moduleparam.h>
+#include <linux/uaccess.h>
+
+#include "chip.h"
+#include "recovery.h"
+#include "vns.h"
+#include "mac80211.h"
+#include "config.h"
+#include "rfic.h"
+#include "e2p.h"
+#include "hw.h"
+#include "radio.h"
+#include "utils.h"
+#include "tcv.h"
+
+#define CL_TX_BCN_PENDING_CHAIN_MIN_TIME 10 /* Usec */
+#define CL_MAX_NUM_OF_RETRY   15
+#define INVALID_CALIB_RX_GAIN 0xff
+
+static struct cl_tcv_conf conf = {
+	.ce_debug_level = DBG_LVL_ERROR,
+	.ce_radio_on = true,
+	.ce_ps_ctrl_enabled = true,
+	.ci_ieee80211h = false,
+	.ci_max_bss_num = ARRAY_SIZE(((struct cl_hw *)0)->addresses),
+	.ci_short_guard_interval = 1,
+	.ci_max_mpdu_len = IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991,
+	.ci_max_ampdu_len_exp = IEEE80211_VHT_MAX_AMPDU_1024K,
+	.ce_dsp_code = "fwC.hex",
+	.ce_dsp_data = "fwD.hex",
+	.ce_dsp_external_data = "fwD.ext.hex",
+	.ci_uapsd_en = true,
+	.ce_eirp_regulatory_op_en = true,
+	.ce_eirp_regulatory_prod_en = false,
+	.ci_agg_tx = true,
+	.ci_agg_rx = true,
+	.ce_txldpc_en = true,
+	.ci_ht_rxldpc_en = true,
+	.ci_vht_rxldpc_en = true,
+	.ci_he_rxldpc_en = true,
+	.ci_cs_required = false,
+	.ci_rx_sensitivity_prod = {
+		[0 ... MAX_ANTENNAS - 1] = -100,
+	},
+	.ci_rx_sensitivity_op = {
+		[0 ... MAX_ANTENNAS - 1] = -100,
+	},
+	.ci_min_he_en = false,
+	.ce_cck_tx_ant_mask = 0x1,
+	.ce_cck_rx_ant_mask = 0x1,
+	.ce_rx_nss = 4,
+	.ce_tx_nss = 4,
+	.ce_num_antennas = 4,
+	.ce_max_agg_size_tx = IEEE80211_MAX_AMPDU_BUF_HE,
+	.ce_max_agg_size_rx = IEEE80211_MAX_AMPDU_BUF_HE,
+	.ce_rxamsdu_en = true,
+	.ce_txamsdu_en = CL_AMSDU_TX_PAYLOAD_MAX,
+	.ci_tx_amsdu_min_data_rate = 26, /* 26Mbps (= BW 20, NSS 0, MCS 3, GI 0) */
+	.ci_tx_sw_amsdu_max_packets = 0,
+	.ci_tx_packet_limit = 5000,
+	.ci_sw_txhdr_pool = 0,
+	.ci_amsdu_txhdr_pool = 0,
+	.ci_tx_queue_size_agg = 500,
+	.ci_tx_queue_size_single = 50,
+	.ci_tx_push_cntrs_stat_en = false,
+	.ci_traffic_mon_en = false,
+	.ci_ipc_rxbuf_size = {
+		[CL_RX_BUF_RXM] = IPC_RXBUF_SIZE,
+		[CL_RX_BUF_FW] = IPC_RXBUF_SIZE
+	},
+	.ce_max_retry = 8,
+	.ce_short_retry_limit = 4,
+	.ce_long_retry_limit = 4,
+	.ci_assoc_auth_retry_limit = 0,
+	.ci_cap_bandwidth = CHNL_BW_MAX,
+	.ci_chandef_channel = INVALID_CHAN_IDX,
+	.ci_chandef_bandwidth = CHNL_BW_MAX,
+	.ci_cck_in_hw_mode = true,
+	.ce_temp_comp_slope = 8,
+	.ci_fw_dbg_severity = CL_MACFW_DBG_SEV_WARNING,
+	.ci_fw_dbg_module = 0x0FFFFF,
+	.ci_lcu_dbg_cfg_inx = 4,
+	.ci_dsp_lcu_mode = 0,
+	.ci_hal_idle_to = CL_DEFAULT_HAL_IDLE_TIMEOUT,
+	.ci_tx_ac0_to = CL_TX_DEFAULT_AC0_TIMEOUT,
+	.ci_tx_ac1_to = CL_TX_DEFAULT_AC1_TIMEOUT,
+	.ci_tx_ac2_to = CL_TX_DEFAULT_AC2_TIMEOUT,
+	.ci_tx_ac3_to = CL_TX_DEFAULT_AC3_TIMEOUT,
+	.ci_tx_bcn_to = CL_TX_DEFAULT_BCN_TIMEOUT,
+	.ce_hardware_power_table = {0},
+	.ce_arr_gain = "0,3,4.75,6,7,7.75",
+	.ce_bf_gain_2_ant = "0",
+	.ce_bf_gain_3_ant = "0",
+	.ce_bf_gain_4_ant = "0",
+	.ce_bf_gain_5_ant = "0",
+	.ce_bf_gain_6_ant = "0",
+	.ce_ant_gain = "0",
+	.ce_ant_gain_36_64 = "0",
+	.ce_ant_gain_100_140 = "0",
+	.ce_ant_gain_149_165 = "0",
+	.ci_min_ant_pwr = "0",
+	.ci_bw_factor = "0,0,0,0",
+	.ce_mcast_rate = 0,
+	.ce_dyn_mcast_rate_en = false,
+	.ce_dyn_bcast_rate_en = false,
+	.ce_default_mcs_ofdm = 0,
+	.ce_default_mcs_cck = 0,
+	.ce_prot_log_nav_en = false,
+	.ce_prot_mode = TXL_PROT_RTS_FW,
+	.ce_prot_rate_format = 1,
+	.ce_prot_rate_mcs = 4,
+	.ce_prot_rate_pre_type = 0,
+	.ce_bw_signaling_mode = 0,
+	.ci_dyn_cts_sta_thr = 2,
+	.ci_vns_pwr_limit = 0,
+	.ci_vns_pwr_mode = VNS_MODE_ALL,
+	.ci_vns_rssi_auto_resp_thr = -40,
+	.ci_vns_rssi_thr = -40,
+	.ci_vns_rssi_hys = 3,
+	.ci_vns_maintenance_time = 2000,
+	.ce_bcn_tx_path_min_time = 1000,
+	.ci_backup_bcn_en = true,
+	.ce_tx_txop_cut_en = true,
+	.ci_bcns_flushed_cnt_thr = 3,
+	.ci_phy_err_prevents_phy_dump = false,
+	.ci_tx_rx_delay = 0,
+	.ci_fw_assert_time_diff_sec = 5,
+	.ci_fw_assert_storm_detect_thd = 10,
+	.ce_hw_assert_time_max  = CL_HW_ASSERT_TIME_MAX,
+	.ce_bg_assert_print = 1,
+	.ce_fw_watchdog_mode = FW_WD_INTERNAL_RECOVERY,
+	.ce_fw_watchdog_limit_count = 5,
+	.ce_fw_watchdog_limit_time = 30 * 1000, /* Msecs */
+	.ci_rx_remote_cpu_drv = -1,
+	.ci_rx_remote_cpu_mac = -1,
+	.ci_pending_queue_size = 500,
+	.ce_tx_power_control = 100,
+	.ce_acs_coex_en = false,
+	.ci_dfs_initial_gain = 77,
+	.ci_dfs_agc_cd_th = 48,
+	.ci_dfs_long_pulse_min = 100,
+	.ci_dfs_long_pulse_max = 5000,
+	.ce_dfs_tbl_overwrite = {0},
+	/* 6G */
+	.ce_ppmcs_offset_he_6g = {
+		[WRS_MCS_0] = 0,
+		[WRS_MCS_1] = 0,
+		[WRS_MCS_2] = 0,
+		[WRS_MCS_3] = 0,
+		[WRS_MCS_4] = 0,
+		[WRS_MCS_5] = 0,
+		[WRS_MCS_6] = 0,
+		[WRS_MCS_7] = 0,
+		[WRS_MCS_8] = 0,
+		[WRS_MCS_9] = 0,
+		[WRS_MCS_10] = 0,
+		[WRS_MCS_11] = 0,
+	},
+	/* 5G */
+	.ce_ppmcs_offset_he_36_64 = {
+		[WRS_MCS_0] = 0,
+		[WRS_MCS_1] = 0,
+		[WRS_MCS_2] = 0,
+		[WRS_MCS_3] = 0,
+		[WRS_MCS_4] = 0,
+		[WRS_MCS_5] = 0,
+		[WRS_MCS_6] = 0,
+		[WRS_MCS_7] = 0,
+		[WRS_MCS_8] = 0,
+		[WRS_MCS_9] = 0,
+		[WRS_MCS_10] = 0,
+		[WRS_MCS_11] = 0,
+	},
+	.ce_ppmcs_offset_he_100_140 = {
+		[WRS_MCS_0] = 0,
+		[WRS_MCS_1] = 0,
+		[WRS_MCS_2] = 0,
+		[WRS_MCS_3] = 0,
+		[WRS_MCS_4] = 0,
+		[WRS_MCS_5] = 0,
+		[WRS_MCS_6] = 0,
+		[WRS_MCS_7] = 0,
+		[WRS_MCS_8] = 0,
+		[WRS_MCS_9] = 0,
+		[WRS_MCS_10] = 0,
+		[WRS_MCS_11] = 0,
+	},
+	.ce_ppmcs_offset_he_149_165 = {
+		[WRS_MCS_0] = 0,
+		[WRS_MCS_1] = 0,
+		[WRS_MCS_2] = 0,
+		[WRS_MCS_3] = 0,
+		[WRS_MCS_4] = 0,
+		[WRS_MCS_5] = 0,
+		[WRS_MCS_6] = 0,
+		[WRS_MCS_7] = 0,
+		[WRS_MCS_8] = 0,
+		[WRS_MCS_9] = 0,
+		[WRS_MCS_10] = 0,
+		[WRS_MCS_11] = 0,
+	},
+	.ce_ppmcs_offset_ht_vht_36_64 = {
+		[WRS_MCS_0] = 0,
+		[WRS_MCS_1] = 0,
+		[WRS_MCS_2] = 0,
+		[WRS_MCS_3] = 0,
+		[WRS_MCS_4] = 0,
+		[WRS_MCS_5] = 0,
+		[WRS_MCS_6] = 0,
+		[WRS_MCS_7] = 0,
+		[WRS_MCS_8] = 0,
+		[WRS_MCS_9] = 0,
+	},
+	.ce_ppmcs_offset_ht_vht_100_140 = {
+		[WRS_MCS_0] = 0,
+		[WRS_MCS_1] = 0,
+		[WRS_MCS_2] = 0,
+		[WRS_MCS_3] = 0,
+		[WRS_MCS_4] = 0,
+		[WRS_MCS_5] = 0,
+		[WRS_MCS_6] = 0,
+		[WRS_MCS_7] = 0,
+		[WRS_MCS_8] = 0,
+		[WRS_MCS_9] = 0,
+	},
+	.ce_ppmcs_offset_ht_vht_149_165 = {
+		[WRS_MCS_0] = 0,
+		[WRS_MCS_1] = 0,
+		[WRS_MCS_2] = 0,
+		[WRS_MCS_3] = 0,
+		[WRS_MCS_4] = 0,
+		[WRS_MCS_5] = 0,
+		[WRS_MCS_6] = 0,
+		[WRS_MCS_7] = 0,
+		[WRS_MCS_8] = 0,
+		[WRS_MCS_9] = 0,
+	},
+	.ce_ppmcs_offset_ofdm_36_64 = {
+		[WRS_MCS_0] = 0,
+		[WRS_MCS_1] = 0,
+		[WRS_MCS_2] = 0,
+		[WRS_MCS_3] = 0,
+		[WRS_MCS_4] = 0,
+		[WRS_MCS_5] = 0,
+		[WRS_MCS_6] = 0,
+		[WRS_MCS_7] = 0,
+	},
+	.ce_ppmcs_offset_ofdm_100_140 = {
+		[WRS_MCS_0] = 0,
+		[WRS_MCS_1] = 0,
+		[WRS_MCS_2] = 0,
+		[WRS_MCS_3] = 0,
+		[WRS_MCS_4] = 0,
+		[WRS_MCS_5] = 0,
+		[WRS_MCS_6] = 0,
+		[WRS_MCS_7] = 0,
+	},
+	.ce_ppmcs_offset_ofdm_149_165 = {
+		[WRS_MCS_0] = 0,
+		[WRS_MCS_1] = 0,
+		[WRS_MCS_2] = 0,
+		[WRS_MCS_3] = 0,
+		[WRS_MCS_4] = 0,
+		[WRS_MCS_5] = 0,
+		[WRS_MCS_6] = 0,
+		[WRS_MCS_7] = 0,
+	},
+	/* 24G */
+	.ce_ppmcs_offset_he = {
+		[WRS_MCS_0] = 0,
+		[WRS_MCS_1] = 0,
+		[WRS_MCS_2] = 0,
+		[WRS_MCS_3] = 0,
+		[WRS_MCS_4] = 0,
+		[WRS_MCS_5] = 0,
+		[WRS_MCS_6] = 0,
+		[WRS_MCS_7] = 0,
+		[WRS_MCS_8] = 0,
+		[WRS_MCS_9] = 0,
+		[WRS_MCS_10] = 0,
+		[WRS_MCS_11] = 0,
+	},
+	.ce_ppmcs_offset_ht = {
+		[WRS_MCS_0] = 0,
+		[WRS_MCS_1] = 0,
+		[WRS_MCS_2] = 0,
+		[WRS_MCS_3] = 0,
+		[WRS_MCS_4] = 0,
+		[WRS_MCS_5] = 0,
+		[WRS_MCS_6] = 0,
+		[WRS_MCS_7] = 0,
+	},
+	.ce_ppmcs_offset_ofdm = {
+		[WRS_MCS_0] = 0,
+		[WRS_MCS_1] = 0,
+		[WRS_MCS_2] = 0,
+		[WRS_MCS_3] = 0,
+		[WRS_MCS_4] = 0,
+		[WRS_MCS_5] = 0,
+		[WRS_MCS_6] = 0,
+		[WRS_MCS_7] = 0,
+	},
+	.ce_ppmcs_offset_cck = {
+		[WRS_MCS_0] = 0,
+		[WRS_MCS_1] = 0,
+		[WRS_MCS_2] = 0,
+		[WRS_MCS_3] = 0,
+	},
+	.ce_ppbw_offset = {
+		[CHNL_BW_20] = 0,
+		[CHNL_BW_40] = 0,
+		[CHNL_BW_80] = 0,
+		[CHNL_BW_160] = 0,
+	},
+	.ce_power_offset_prod_en = true,
+	.ci_bf_en = false,
+	.ci_bf_max_nss = 2,
+	.ce_sounding_interval_coefs = {
+		[SOUNDING_INTERVAL_COEF_MIN_INTERVAL] = 100,
+		[SOUNDING_INTERVAL_COEF_STA_STEP] = 4,
+		[SOUNDING_INTERVAL_COEF_INTERVAL_STEP] = 50,
+		[SOUNDING_INTERVAL_COEF_MAX_INTERVAL] = 500,
+	},
+	.ci_rate_fallback = {
+		[CL_RATE_FALLBACK_COUNT_SU] = 4,
+		[CL_RATE_FALLBACK_COUNT_MU] = 2,
+		[CL_RATE_FALLBACK_RETRY_COUNT_THR] = 2,
+		[CL_RATE_FALLBACK_BA_PER_THR] = 25,
+		[CL_RATE_FALLBACK_BA_NOT_RECEIVED_THR] = 2,
+		[CL_RATE_FALLBACK_DISABLE_MCS] = 1
+	},
+	.ce_rx_pkts_budget = 512,
+	.ci_band_num = 5,
+	.ci_mult_ampdu_in_txop_en = false,
+	.ce_wmm_aifsn = {
+		[AC_BK] = 3,
+		[AC_BE] = 7,
+		[AC_VI] = 1,
+		[AC_VO] = 1
+	},
+	.ce_wmm_cwmin = {
+		[AC_BK] = 4,
+		[AC_BE] = 4,
+		[AC_VI] = 3,
+		[AC_VO] = 2
+	},
+	.ce_wmm_cwmax = {
+		[AC_BK] = 10,
+		[AC_BE] = 10,
+		[AC_VI] = 4,
+		[AC_VO] = 3
+	},
+	.ce_wmm_txop = {
+		[AC_BK] = 0,
+		[AC_BE] = 0,
+		[AC_VI] = 94,
+		[AC_VO] = 47
+	},
+	.ci_su_force_min_spacing = CL_TX_MPDU_SPACING_INVALID,
+	.ci_mu_force_min_spacing = CL_TX_MPDU_SPACING_INVALID,
+	.ci_tf_mac_pad_dur = 0,
+	.ci_cca_timeout = 300,
+	.ce_tx_ba_session_timeout = 30000,
+	.ci_motion_sense_en = true,
+	.ci_motion_sense_rssi_thr = 8,
+	.ci_wrs_max_bw = CHNL_BW_160,
+	.ci_wrs_min_bw = CHNL_BW_20,
+	.ci_wrs_fixed_rate = {
+		[WRS_FIXED_PARAM_MODE] = -1,
+		[WRS_FIXED_PARAM_BW] = -1,
+		[WRS_FIXED_PARAM_NSS] = -1,
+		[WRS_FIXED_PARAM_MCS] = -1,
+		[WRS_FIXED_PARAM_GI] = -1
+	},
+	.ce_he_mcs_nss_supp_tx = {
+		[WRS_SS_1 ... WRS_SS_4] = 11,
+	},
+	.ce_he_mcs_nss_supp_rx = {
+		[WRS_SS_1 ... WRS_SS_4] = 11,
+	},
+	.ce_vht_mcs_nss_supp_tx = {
+		[WRS_SS_1 ... WRS_SS_4] = 9,
+	},
+	.ce_vht_mcs_nss_supp_rx = {
+		[WRS_SS_1 ... WRS_SS_4] = 9,
+	},
+	.ci_pe_duration = U8_MAX,
+	.ci_pe_duration_bcast = PPE_16US,
+	.ci_gain_update_enable = 1,
+	.ci_mcs_sig_b = 0,
+	.ci_spp_ksr_value = 1,
+	.ci_rx_padding_en = false,
+	.ci_stats_en = false,
+	.ci_bar_disable = false,
+	.ci_ofdm_only = true,
+	.ci_hw_bsr = false,
+	.ci_drop_to_lower_bw = false,
+	.ci_force_icmp_single = false,
+	.ce_wrs_rx_en = false,
+	.ci_hr_factor = {
+		[CHNL_BW_20] = 2,
+		[CHNL_BW_40] = 2,
+		[CHNL_BW_80] = 2,
+		[CHNL_BW_160] = 1
+	},
+	.ci_csd_en = true,
+	.ci_signal_extension_en = false,
+	.ci_vht_cap_24g = false,
+	.ci_tx_digital_gain = 0x28282828,
+	.ci_tx_digital_gain_cck = 0x63636363,
+	.ci_ofdm_cck_power_offset = -13,
+	.ci_mac_clk_gating_en = true,
+	.ci_phy_clk_gating_en = true,
+	.ci_imaging_blocker = false,
+	.ci_sensing_ndp_tx_chain_mask = NDP_TX_PHY0,
+	.ci_sensing_ndp_tx_bw = CHNL_BW_MAX,
+	.ci_sensing_ndp_tx_format = FORMATMOD_NON_HT,
+	.ci_sensing_ndp_tx_num_ltf = LTF_X1,
+	.ci_calib_ant_tx = {
+		[0 ... MAX_ANTENNAS - 1] = U8_MAX,
+	},
+	.ci_calib_ant_rx = {
+		[0 ... MAX_ANTENNAS - 1] = U8_MAX,
+	},
+	.ci_cca_ed_rise_thr_dbm = -62,
+	.ci_cca_ed_fall_thr_dbm = -65,
+	.ci_cca_cs_en = 1,
+	.ci_cca_modem_en = 0xf,
+	.ci_cca_main_ant = 0,
+	.ci_cca_second_ant = 1,
+	.ci_cca_flag0_ctrl = 0x8,
+	.ci_cca_flag1_ctrl = 0x8,
+	.ci_cca_flag2_ctrl = 0x2,
+	.ci_cca_flag3_ctrl = 0xa,
+	.ci_cca_gi_rise_thr_dbm = -72,
+	.ci_cca_gi_fall_thr_dbm = -75,
+	.ci_cca_gi_pow_lim_dbm = -59,
+	.ci_cca_ed_en = 0x7ff,
+	.ci_cca_gi_en = 0,
+	.ci_rx_he_mu_ppdu = false,
+	.ci_fast_rx_en = true,
+	.ci_distance_auto_resp_all = 0,
+	.ci_distance_auto_resp_msta = 0,
+	.ci_fw_disable_recovery = false,
+	.ce_listener_en = 0,
+	.ci_tx_delay_tstamp_en = false,
+	.ci_calib_tx_init_tx_gain = {
+		[0 ... MAX_ANTENNAS - 1] = CALIB_TX_GAIN_DEFAULT,
+	},
+	.ci_calib_tx_init_rx_gain = {
+		[0 ... MAX_ANTENNAS - 1] = INVALID_CALIB_RX_GAIN,
+	},
+	.ci_calib_rx_init_tx_gain = {
+		[0 ... MAX_ANTENNAS - 1] = CALIB_TX_GAIN_DEFAULT,
+	},
+	.ci_calib_rx_init_rx_gain = {
+		[0 ... MAX_ANTENNAS - 1] = INVALID_CALIB_RX_GAIN,
+	},
+	.ci_calib_conf_rx_gain_upper_limit = INVALID_CALIB_RX_GAIN,
+	.ci_calib_conf_rx_gain_lower_limit = INVALID_CALIB_RX_GAIN,
+	.ci_calib_conf_tone_vector_20bw = {6, 10, 14, 18, 22, 24, 26, 27},
+	.ci_calib_conf_tone_vector_40bw = {10, 18, 26, 34, 41, 48, 53, 58},
+	.ci_calib_conf_tone_vector_80bw = {18, 34, 50, 66, 82, 98, 110, 122},
+	.ci_calib_conf_tone_vector_160bw = {18, 34, 66, 98, 130, 164, 224, 250},
+	.ci_calib_conf_gp_rad_trshld = GP_RAD_TRSHLD_DEFAULT,
+	.ci_calib_conf_ga_lin_upper_trshld = GA_LIN_UPPER_TRSHLD_DEFAULT,
+	.ci_calib_conf_ga_lin_lower_trshld = GA_LIN_LOWER_TRSHLD_DEFAULT,
+	.ci_calib_conf_singletons_num = SINGLETONS_NUM_DEFAULT,
+	.ci_calib_conf_rampup_time = RAMPUP_TIME,
+	.ci_calib_conf_lo_coarse_step = LO_COARSE_STEP,
+#ifdef CONFIG_CL8K_EEPROM_STM24256
+	.ci_calib_conf_lo_fine_step = LO_FINE_STEP,
+	.ci_calib_eeprom_channels_20mhz = {0},
+	.ci_calib_eeprom_channels_40mhz = {0},
+	.ci_calib_eeprom_channels_80mhz = {0},
+	.ci_calib_eeprom_channels_160mhz = {0},
+#endif
+	.ci_mesh_basic_rates = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
+};
+
+static int cl_tcv_update_config(struct cl_hw *cl_hw, char *name, char *value)
+{
+	struct cl_tcv_conf *conf = cl_hw->conf;
+	int ret = -ENOENT;
+
+	do {
+		READ_S8(ce_debug_level);
+		READ_BOOL(ce_radio_on);
+		READ_BOOL(ce_ps_ctrl_enabled);
+		READ_BOOL(ci_ieee80211h);
+		READ_U8(ci_max_bss_num);
+		READ_U8(ci_short_guard_interval);
+		READ_U8(ci_max_mpdu_len);
+		READ_U8(ci_max_ampdu_len_exp);
+		READ_STR(ce_dsp_code);
+		READ_STR(ce_dsp_data);
+		READ_STR(ce_dsp_external_data);
+		READ_BOOL(ci_uapsd_en);
+		READ_BOOL(ce_eirp_regulatory_op_en);
+		READ_BOOL(ce_eirp_regulatory_prod_en);
+		READ_BOOL(ci_agg_tx);
+		READ_BOOL(ci_agg_rx);
+		READ_BOOL(ce_txldpc_en);
+		READ_BOOL(ci_ht_rxldpc_en);
+		READ_BOOL(ci_vht_rxldpc_en);
+		READ_BOOL(ci_he_rxldpc_en);
+		READ_BOOL(ci_cs_required);
+		READ_S8_ARR(ci_rx_sensitivity_prod, MAX_ANTENNAS);
+		READ_S8_ARR(ci_rx_sensitivity_op, MAX_ANTENNAS);
+		READ_BOOL(ci_min_he_en);
+		READ_U8(ce_cck_tx_ant_mask);
+		READ_U8(ce_cck_rx_ant_mask);
+		READ_U8(ce_rx_nss);
+		READ_U8(ce_tx_nss);
+		READ_U8(ce_num_antennas);
+		READ_U16(ce_max_agg_size_tx);
+		READ_U16(ce_max_agg_size_rx);
+		READ_BOOL(ce_rxamsdu_en);
+		READ_U8(ce_txamsdu_en);
+		READ_U16(ci_tx_amsdu_min_data_rate);
+		READ_U8(ci_tx_sw_amsdu_max_packets);
+		READ_U16(ci_tx_packet_limit);
+		READ_U16(ci_sw_txhdr_pool);
+		READ_U16(ci_amsdu_txhdr_pool);
+		READ_U16(ci_tx_queue_size_agg);
+		READ_U16(ci_tx_queue_size_single);
+		READ_BOOL(ci_tx_push_cntrs_stat_en);
+		READ_BOOL(ci_traffic_mon_en);
+		READ_U16_ARR(ci_ipc_rxbuf_size, CL_RX_BUF_MAX, true);
+		READ_U16(ce_max_retry);
+		READ_U8(ce_short_retry_limit);
+		READ_U8(ce_long_retry_limit);
+		READ_U8(ci_assoc_auth_retry_limit);
+		READ_U8(ci_cap_bandwidth);
+		READ_U32(ci_chandef_channel);
+		READ_U8(ci_chandef_bandwidth);
+		READ_BOOL(ci_cck_in_hw_mode);
+		READ_S8(ce_temp_comp_slope);
+		READ_U32(ci_fw_dbg_severity);
+		READ_U32(ci_fw_dbg_module);
+		READ_U8(ci_lcu_dbg_cfg_inx);
+		READ_U8(ci_dsp_lcu_mode);
+		READ_U32(ci_hal_idle_to);
+		READ_U32(ci_tx_ac0_to);
+		READ_U32(ci_tx_ac1_to);
+		READ_U32(ci_tx_ac2_to);
+		READ_U32(ci_tx_ac3_to);
+		READ_U32(ci_tx_bcn_to);
+		READ_STR(ce_hardware_power_table);
+		READ_STR(ce_arr_gain);
+		READ_STR(ce_bf_gain_2_ant);
+		READ_STR(ce_bf_gain_3_ant);
+		READ_STR(ce_bf_gain_4_ant);
+		READ_STR(ce_bf_gain_5_ant);
+		READ_STR(ce_bf_gain_6_ant);
+		READ_STR(ce_ant_gain);
+		READ_STR(ce_ant_gain_36_64);
+		READ_STR(ce_ant_gain_100_140);
+		READ_STR(ce_ant_gain_149_165);
+		READ_STR(ci_min_ant_pwr);
+		READ_STR(ci_bw_factor);
+		READ_U8(ce_mcast_rate);
+		READ_BOOL(ce_dyn_mcast_rate_en);
+		READ_BOOL(ce_dyn_bcast_rate_en);
+		READ_U8(ce_default_mcs_ofdm);
+		READ_U8(ce_default_mcs_cck);
+		READ_BOOL(ce_prot_log_nav_en);
+		READ_U8(ce_prot_mode);
+		READ_U8(ce_prot_rate_format);
+		READ_U8(ce_prot_rate_mcs);
+		READ_U8(ce_prot_rate_pre_type);
+		READ_U8(ce_bw_signaling_mode);
+		READ_U8(ci_dyn_cts_sta_thr);
+		READ_S8(ci_vns_pwr_limit);
+		READ_U8(ci_vns_pwr_mode);
+		READ_S8(ci_vns_rssi_auto_resp_thr);
+		READ_S8(ci_vns_rssi_thr);
+		READ_S8(ci_vns_rssi_hys);
+		READ_U16(ci_vns_maintenance_time);
+		READ_U16(ce_bcn_tx_path_min_time);
+		READ_BOOL(ci_backup_bcn_en);
+		READ_BOOL(ce_tx_txop_cut_en);
+		READ_U8(ci_bcns_flushed_cnt_thr);
+		READ_BOOL(ci_phy_err_prevents_phy_dump);
+		READ_U8(ci_tx_rx_delay);
+		READ_U8(ci_fw_assert_time_diff_sec);
+		READ_U8(ci_fw_assert_storm_detect_thd);
+		READ_U32(ce_hw_assert_time_max);
+		READ_U8(ce_bg_assert_print);
+		READ_U8(ce_fw_watchdog_mode);
+		READ_U8(ce_fw_watchdog_limit_count);
+		READ_U32(ce_fw_watchdog_limit_time);
+		READ_S8(ci_rx_remote_cpu_drv);
+		READ_S8(ci_rx_remote_cpu_mac);
+		READ_U16(ci_pending_queue_size);
+		READ_U8(ce_tx_power_control);
+		READ_BOOL(ce_acs_coex_en);
+		READ_U8(ci_dfs_initial_gain);
+		READ_U8(ci_dfs_agc_cd_th);
+		READ_U16(ci_dfs_long_pulse_min);
+		READ_U16(ci_dfs_long_pulse_max);
+		READ_STR(ce_dfs_tbl_overwrite);
+		READ_S8_ARR(ce_ppmcs_offset_he_6g, WRS_MCS_MAX_HE);
+		READ_S8_ARR(ce_ppmcs_offset_he_36_64, WRS_MCS_MAX_HE);
+		READ_S8_ARR(ce_ppmcs_offset_he_100_140, WRS_MCS_MAX_HE);
+		READ_S8_ARR(ce_ppmcs_offset_he_149_165, WRS_MCS_MAX_HE);
+		READ_S8_ARR(ce_ppmcs_offset_ht_vht_36_64, WRS_MCS_MAX_VHT);
+		READ_S8_ARR(ce_ppmcs_offset_ht_vht_100_140, WRS_MCS_MAX_VHT);
+		READ_S8_ARR(ce_ppmcs_offset_ht_vht_149_165, WRS_MCS_MAX_VHT);
+		READ_S8_ARR(ce_ppmcs_offset_ofdm_36_64, WRS_MCS_MAX_OFDM);
+		READ_S8_ARR(ce_ppmcs_offset_ofdm_100_140, WRS_MCS_MAX_OFDM);
+		READ_S8_ARR(ce_ppmcs_offset_ofdm_149_165, WRS_MCS_MAX_OFDM);
+		READ_S8_ARR(ce_ppmcs_offset_he, WRS_MCS_MAX_HE);
+		READ_S8_ARR(ce_ppmcs_offset_ht, WRS_MCS_MAX_HT);
+		READ_S8_ARR(ce_ppmcs_offset_ofdm, WRS_MCS_MAX_OFDM);
+		READ_S8_ARR(ce_ppmcs_offset_cck, WRS_MCS_MAX_CCK);
+		READ_S8_ARR(ce_ppbw_offset, CHNL_BW_MAX);
+		READ_BOOL(ce_power_offset_prod_en);
+		READ_BOOL(ci_bf_en);
+		READ_U8(ci_bf_max_nss);
+		READ_U16_ARR(ce_sounding_interval_coefs, SOUNDING_INTERVAL_COEF_MAX, true);
+		READ_U8_ARR(ci_rate_fallback, CL_RATE_FALLBACK_MAX, true);
+		READ_U16(ce_rx_pkts_budget);
+		READ_U8(ci_band_num);
+		READ_BOOL(ci_mult_ampdu_in_txop_en);
+		READ_U8_ARR(ce_wmm_aifsn, AC_MAX, true);
+		READ_U8_ARR(ce_wmm_cwmin, AC_MAX, true);
+		READ_U8_ARR(ce_wmm_cwmax, AC_MAX, true);
+		READ_U16_ARR(ce_wmm_txop, AC_MAX, true);
+		READ_U8(ci_su_force_min_spacing);
+		READ_U8(ci_mu_force_min_spacing);
+		READ_U8(ci_tf_mac_pad_dur);
+		READ_U32(ci_cca_timeout);
+		READ_U16(ce_tx_ba_session_timeout);
+		READ_BOOL(ci_motion_sense_en);
+		READ_S8(ci_motion_sense_rssi_thr);
+		READ_U8(ci_wrs_max_bw);
+		READ_U8(ci_wrs_min_bw);
+		READ_S8_ARR(ci_wrs_fixed_rate, WRS_FIXED_PARAM_MAX);
+		READ_U8_ARR(ce_he_mcs_nss_supp_tx, WRS_SS_MAX, true);
+		READ_U8_ARR(ce_he_mcs_nss_supp_rx, WRS_SS_MAX, true);
+		READ_U8_ARR(ce_vht_mcs_nss_supp_tx, WRS_SS_MAX, true);
+		READ_U8_ARR(ce_vht_mcs_nss_supp_rx, WRS_SS_MAX, true);
+		READ_U8(ci_pe_duration);
+		READ_U8(ci_pe_duration_bcast);
+		READ_U8(ci_gain_update_enable);
+		READ_U8(ci_mcs_sig_b);
+		READ_U8(ci_spp_ksr_value);
+		READ_BOOL(ci_rx_padding_en);
+		READ_BOOL(ci_stats_en);
+		READ_BOOL(ci_bar_disable);
+		READ_BOOL(ci_ofdm_only);
+		READ_BOOL(ci_hw_bsr);
+		READ_BOOL(ci_drop_to_lower_bw);
+		READ_BOOL(ci_force_icmp_single);
+		READ_BOOL(ci_csd_en);
+		READ_BOOL(ce_wrs_rx_en);
+		READ_U8_ARR(ci_hr_factor, CHNL_BW_MAX, true);
+		READ_BOOL(ci_signal_extension_en);
+		READ_BOOL(ci_vht_cap_24g);
+		READ_U32(ci_tx_digital_gain);
+		READ_U32(ci_tx_digital_gain_cck);
+		READ_S8(ci_ofdm_cck_power_offset);
+		READ_BOOL(ci_mac_clk_gating_en);
+		READ_BOOL(ci_phy_clk_gating_en);
+		READ_BOOL(ci_imaging_blocker);
+		READ_U8(ci_sensing_ndp_tx_chain_mask);
+		READ_U8(ci_sensing_ndp_tx_bw);
+		READ_U8(ci_sensing_ndp_tx_format);
+		READ_U8(ci_sensing_ndp_tx_num_ltf);
+		READ_U8_ARR(ci_calib_ant_tx, MAX_ANTENNAS, true);
+		READ_U8_ARR(ci_calib_ant_rx, MAX_ANTENNAS, true);
+		READ_S8(ci_cca_ed_rise_thr_dbm);
+		READ_S8(ci_cca_ed_fall_thr_dbm);
+		READ_U8(ci_cca_cs_en);
+		READ_U8(ci_cca_modem_en);
+		READ_U8(ci_cca_main_ant);
+		READ_U8(ci_cca_second_ant);
+		READ_U8(ci_cca_flag0_ctrl);
+		READ_U8(ci_cca_flag1_ctrl);
+		READ_U8(ci_cca_flag2_ctrl);
+		READ_U8(ci_cca_flag3_ctrl);
+		READ_S8(ci_cca_gi_rise_thr_dbm);
+		READ_S8(ci_cca_gi_fall_thr_dbm);
+		READ_S8(ci_cca_gi_pow_lim_dbm);
+		READ_U16(ci_cca_ed_en);
+		READ_U8(ci_cca_gi_en);
+		READ_BOOL(ci_rx_he_mu_ppdu);
+		READ_BOOL(ci_fast_rx_en);
+		READ_U8(ci_distance_auto_resp_all);
+		READ_U8(ci_distance_auto_resp_msta);
+		READ_BOOL(ci_fw_disable_recovery);
+		READ_BOOL(ce_listener_en);
+		READ_BOOL(ci_tx_delay_tstamp_en);
+		READ_U8_ARR(ci_calib_tx_init_tx_gain, MAX_ANTENNAS, true);
+		READ_U8_ARR(ci_calib_tx_init_rx_gain, MAX_ANTENNAS, true);
+		READ_U8_ARR(ci_calib_rx_init_tx_gain, MAX_ANTENNAS, true);
+		READ_U8_ARR(ci_calib_rx_init_rx_gain, MAX_ANTENNAS, true);
+		READ_U8(ci_calib_conf_rx_gain_upper_limit);
+		READ_U8(ci_calib_conf_rx_gain_lower_limit);
+		READ_U8_ARR(ci_calib_conf_tone_vector_20bw, IQ_NUM_TONES_REQ, true);
+		READ_U8_ARR(ci_calib_conf_tone_vector_40bw, IQ_NUM_TONES_REQ, true);
+		READ_U8_ARR(ci_calib_conf_tone_vector_80bw, IQ_NUM_TONES_REQ, true);
+		READ_U8_ARR(ci_calib_conf_tone_vector_160bw, IQ_NUM_TONES_REQ, true);
+		READ_U32(ci_calib_conf_gp_rad_trshld);
+		READ_U32(ci_calib_conf_ga_lin_upper_trshld);
+		READ_U32(ci_calib_conf_ga_lin_lower_trshld);
+		READ_U8(ci_calib_conf_singletons_num);
+		READ_U16(ci_calib_conf_rampup_time);
+		READ_U16(ci_calib_conf_lo_coarse_step);
+		READ_U16(ci_calib_conf_lo_fine_step);
+
+#ifdef CONFIG_CL8K_EEPROM_STM24256
+		if (cl_hw_is_tcv0(cl_hw)) {
+			READ_U16_ARR(ci_calib_eeprom_channels_20mhz,
+				     EEPROM_CALIB_DATA_ELEM_NUM_20MHZ_TCV0, false);
+			READ_U16_ARR(ci_calib_eeprom_channels_40mhz,
+				     EEPROM_CALIB_DATA_ELEM_NUM_40MHZ_TCV0, false);
+			READ_U16_ARR(ci_calib_eeprom_channels_80mhz,
+				     EEPROM_CALIB_DATA_ELEM_NUM_80MHZ_TCV0, false);
+			READ_U16_ARR(ci_calib_eeprom_channels_160mhz,
+				     EEPROM_CALIB_DATA_ELEM_NUM_160MHZ_TCV0, false);
+		}
+		if (cl_hw_is_tcv1(cl_hw)) {
+			READ_U16_ARR(ci_calib_eeprom_channels_20mhz,
+				     EEPROM_CALIB_DATA_ELEM_NUM_20MHZ_TCV1, false);
+			READ_U16_ARR(ci_calib_eeprom_channels_40mhz,
+				     EEPROM_CALIB_DATA_ELEM_NUM_40MHZ_TCV1, false);
+			READ_U16_ARR(ci_calib_eeprom_channels_80mhz,
+				     EEPROM_CALIB_DATA_ELEM_NUM_80MHZ_TCV1, false);
+			READ_U16_ARR(ci_calib_eeprom_channels_160mhz,
+				     EEPROM_CALIB_DATA_ELEM_NUM_160MHZ_TCV1, false);
+		}
+#endif
+		READ_U16_ARR(ci_mesh_basic_rates, MESH_BASIC_RATE_MAX, false);
+	} while (0);
+
+	if (ret == -ENOENT) {
+		if (cl_config_is_non_driver_param(name))
+			ret = 0;
+		else
+			CL_DBG_ERROR(cl_hw, "No matching conf for nvram parameter %s\n", name);
+	}
+
+	return ret;
+}
+
+static int cl_tcv_set_all_params_from_buf(struct cl_hw *cl_hw, char *buf, size_t size)
+{
+	char *line = buf;
+	char name[MAX_PARAM_NAME_LENGTH];
+	char value[STR_LEN_256B];
+	char *begin;
+	char *end;
+	int ret = 0;
+	int name_length = 0;
+	int value_length = 0;
+
+	while (line && strlen(line) && (line != (buf + size))) {
+		if ((*line == '#') || (*line == '\n')) {
+			/* Skip comment or blank line */
+			line = strstr(line, "\n") + 1;
+		} else if (*line) {
+			begin = line;
+			end = strstr(begin, "=");
+
+			if (!end) {
+				ret = -EBADMSG;
+				goto exit;
+			}
+
+			end++;
+			name_length = end - begin;
+			value_length = strstr(end, "\n") - end + 1;
+
+			if (name_length >= MAX_PARAM_NAME_LENGTH) {
+				cl_dbg_err(cl_hw,
+					   "Name too long (%u)\n", name_length);
+				ret = -EBADMSG;
+				goto exit;
+			}
+			if (value_length >= STR_LEN_256B) {
+				cl_dbg_err(cl_hw,
+					   "Value too long (%u)\n", value_length);
+				ret = -EBADMSG;
+				goto exit;
+			}
+
+			snprintf(name, name_length, "%s", begin);
+			snprintf(value, value_length, "%s", end);
+
+			ret = cl_tcv_update_config(cl_hw, name, value);
+			if (ret)
+				goto exit;
+
+			line = strstr(line, "\n") + 1;
+		}
+	}
+
+exit:
+
+	return ret;
+}
+
+static bool cl_tcv_is_valid_min_spacing(u8 min_spacing)
+{
+	return ((min_spacing == 0) ||
+		(min_spacing == 1) ||
+		(min_spacing == 2) ||
+		(min_spacing == 3) ||
+		(min_spacing == 4) ||
+		(min_spacing == 6) ||
+		(min_spacing == 8) ||
+		(min_spacing == 10) ||
+		(min_spacing == 12) ||
+		(min_spacing == 14) ||
+		(min_spacing == 16) ||
+		(min_spacing == 18) ||
+		(min_spacing == 20) ||
+		(min_spacing == 24) ||
+		(min_spacing ==  CL_TX_MPDU_SPACING_INVALID));
+}
+
+static bool cl_tcv_is_valid_cca_config(struct cl_hw *cl_hw, struct cl_tcv_conf *conf)
+{
+	if (conf->ci_cca_ed_rise_thr_dbm <= conf->ci_cca_ed_fall_thr_dbm) {
+		CL_DBG_ERROR(cl_hw, "cca_ed_rise_thr_dbm (%u) <= cca_ed_fall_thr_dbm (%u)\n",
+			     conf->ci_cca_ed_rise_thr_dbm, conf->ci_cca_ed_fall_thr_dbm);
+		return false;
+	}
+
+	if (conf->ci_cca_gi_rise_thr_dbm <= conf->ci_cca_gi_fall_thr_dbm) {
+		CL_DBG_ERROR(cl_hw, "cca_gi_rise_thr_dbm (%u) <= cca_gi_fall_thr_dbm (%u)\n",
+			     conf->ci_cca_gi_rise_thr_dbm, conf->ci_cca_gi_fall_thr_dbm);
+		return false;
+	}
+
+	if (conf->ci_cca_gi_pow_lim_dbm <= conf->ci_cca_ed_rise_thr_dbm) {
+		CL_DBG_ERROR(cl_hw, "cca_gi_pow_lim_dbm (%u) <= cca_ed_rise_thr_dbm (%u)\n",
+			     conf->ci_cca_gi_pow_lim_dbm, conf->ci_cca_ed_rise_thr_dbm);
+		return false;
+	}
+
+	return true;
+}
+
+static inline void cl_tcv_set_default_channel(u32 *channel, u32 value)
+{
+	if (*channel == INVALID_CHAN_IDX)
+		*channel = value;
+}
+
+static inline void cl_tcv_set_default_bandwidth(u8 *bw, u8 value)
+{
+	if (*bw == CHNL_BW_MAX)
+		*bw = value;
+}
+
+static inline bool cl_tcv_is_valid_bandwidth(u8 *bw, u8 max_value)
+{
+	return *bw <= max_value;
+}
+
+static bool cl_tcv_is_valid_channeling_context(struct cl_hw *cl_hw)
+{
+	struct cl_tcv_conf *conf = cl_hw->conf;
+	u32 dflt_channel = 1;
+	u8 bw_limit = CHNL_BW_20;
+	char *band_str = "?";
+
+	if (cl_band_is_24g(cl_hw)) {
+		dflt_channel = 1;
+		bw_limit = CHNL_BW_40;
+		band_str = "24g";
+	} else if (cl_band_is_5g(cl_hw)) {
+		dflt_channel = 36;
+		bw_limit = CHNL_BW_160;
+		band_str = "5g";
+	} else {
+		dflt_channel = 1;
+		bw_limit = CHNL_BW_160;
+		band_str = "6g";
+	}
+
+	cl_tcv_set_default_channel(&conf->ci_chandef_channel, dflt_channel);
+	cl_tcv_set_default_bandwidth(&conf->ci_chandef_bandwidth, bw_limit);
+	cl_tcv_set_default_bandwidth(&conf->ci_cap_bandwidth, bw_limit);
+
+	/* Forcibly change BW limit for production mode in 24g */
+	if (cl_band_is_24g(cl_hw) && cl_hw->chip->conf->ce_production_mode)
+		bw_limit = CHNL_BW_160;
+
+	if (!cl_tcv_is_valid_bandwidth(&conf->ci_cap_bandwidth, bw_limit)) {
+		CL_DBG_ERROR(cl_hw, "Invalid channel bandwidth (%u) for %s\n",
+			     conf->ci_cap_bandwidth, band_str);
+		return false;
+	}
+
+	return true;
+}
+
+static int cl_tcv_post_configuration(struct cl_hw *cl_hw, const char *buf)
+{
+	struct cl_tcv_conf *conf = cl_hw->conf;
+	struct cl_chip *chip = cl_hw->chip;
+
+	if (conf->ci_max_bss_num > ARRAY_SIZE(cl_hw->addresses)) {
+		CL_DBG_ERROR(cl_hw, "Invalid ci_max_bss_num (%u)\n",
+			     conf->ci_max_bss_num);
+		return -EINVAL;
+	}
+
+	/* Production mode */
+	if (chip->conf->ce_production_mode) {
+		memcpy(cl_hw->rx_sensitivity, conf->ci_rx_sensitivity_prod, MAX_ANTENNAS);
+		conf->ce_prot_mode = 0;
+		/* Production is done in station mode */
+		cl_hw_set_iface_conf(cl_hw, CL_IFCONF_STA);
+
+	} else {
+		if (chip->conf->ci_phy_dev == PHY_DEV_LOOPBACK) {
+			s8 rx_sens_loopback[MAX_ANTENNAS] = {-96, -96, -96, -96, -96, -96};
+
+			memcpy(cl_hw->rx_sensitivity, rx_sens_loopback, MAX_ANTENNAS);
+		} else {
+			memcpy(cl_hw->rx_sensitivity, conf->ci_rx_sensitivity_op, MAX_ANTENNAS);
+		}
+	}
+
+	if (cl_hw_set_antennas(cl_hw)) {
+		CL_DBG_ERROR(cl_hw, "hw set antennas failed!\n");
+		return -EINVAL;
+	}
+
+	if (!cl_tcv_is_valid_cca_config(cl_hw, conf))
+		return -EINVAL;
+
+	if (conf->ce_num_antennas) {
+		/* Validate: ce_num_antennas, ce_rx_nss, ce_tx_nss */
+		if (conf->ce_num_antennas < MIN_ANTENNAS ||
+		    conf->ce_num_antennas > MAX_ANTENNAS) {
+			CL_DBG_ERROR(cl_hw, "Invalid ce_num_antennas (%u)\n",
+				     conf->ce_num_antennas);
+			return -EINVAL;
+		}
+
+		if (conf->ce_rx_nss < 1 ||
+		    conf->ce_rx_nss > WRS_SS_MAX ||
+		    conf->ce_rx_nss > conf->ce_num_antennas) {
+			CL_DBG_ERROR(cl_hw, "Invalid ce_rx_nss (%u)\n", conf->ce_rx_nss);
+			return -EINVAL;
+		}
+
+		if (conf->ce_tx_nss < 1 ||
+		    conf->ce_tx_nss > WRS_SS_MAX ||
+		    conf->ce_tx_nss > conf->ce_num_antennas) {
+			CL_DBG_ERROR(cl_hw, "Invalid ce_tx_nss (%u)\n", conf->ce_tx_nss);
+			return -EINVAL;
+		}
+
+		/* Validate: ce_cck_tx_ant_mask and ce_cck_rx_ant_mask */
+		if (cl_band_is_24g(cl_hw)) {
+			u8 ant_shift = cl_hw_ant_shift(cl_hw);
+			u8 ant_bitmap = (((1 << conf->ce_num_antennas) - 1) << ant_shift);
+			u8 num_cck_ant_tx = hweight8(conf->ce_cck_tx_ant_mask);
+			u8 num_cck_ant_rx = hweight8(conf->ce_cck_rx_ant_mask);
+
+			if ((ant_bitmap & conf->ce_cck_tx_ant_mask) != conf->ce_cck_tx_ant_mask) {
+				CL_DBG_ERROR(cl_hw, "Invalid ce_cck_tx_ant_mask (0x%x), "
+						    "does not match ce_num_antennas mask (0x%x)\n",
+					     conf->ce_cck_tx_ant_mask, ant_bitmap);
+				return -EINVAL;
+			}
+
+			if ((ant_bitmap & conf->ce_cck_rx_ant_mask) != conf->ce_cck_rx_ant_mask) {
+				CL_DBG_ERROR(cl_hw, "Invalid ce_cck_rx_ant_mask (0x%x), "
+						    "does not match ce_num_antennas mask (0x%x)\n",
+					     conf->ce_cck_rx_ant_mask, ant_bitmap);
+				return -EINVAL;
+			}
+
+			if (conf->ce_cck_tx_ant_mask == 0) {
+				CL_DBG_ERROR(cl_hw, "Invalid ce_cck_tx_ant_mask, can't be 0x0\n");
+				return -EINVAL;
+			}
+
+			if (conf->ce_cck_rx_ant_mask == 0) {
+				CL_DBG_ERROR(cl_hw, "Invalid ce_cck_rx_ant_mask, can't be 0x0\n");
+				return -EINVAL;
+			}
+
+			if (num_cck_ant_tx > MAX_ANTENNAS_CCK) {
+				CL_DBG_ERROR(cl_hw, "Invalid ce_cck_tx_ant_mask (0x%x), "
+						    "number of set bits exceeds %u\n",
+					     num_cck_ant_tx, MAX_ANTENNAS_CCK);
+				return -EINVAL;
+			}
+
+			if (num_cck_ant_rx > MAX_ANTENNAS_CCK) {
+				CL_DBG_ERROR(cl_hw, "Invalid ce_cck_rx_ant_mask (0x%x), "
+						    "number of set bits exceeds %u\n",
+					     num_cck_ant_rx, MAX_ANTENNAS_CCK);
+				return -EINVAL;
+			}
+		}
+	}
+
+	if (conf->ce_prot_mode == TXL_PROT_RTS) {
+		CL_DBG_ERROR(cl_hw, "ce_prot_mode %u is not supported\n", TXL_PROT_RTS);
+		return -EINVAL;
+	}
+
+	if (!cl_tcv_is_valid_channeling_context(cl_hw))
+		return -EINVAL;
+
+	if (cl_band_is_5g(cl_hw)) {
+		if (!conf->ci_ofdm_only) {
+			CL_DBG_ERROR(cl_hw, "ci_ofdm_only must be set to 1 for 5g band\n");
+			return -EINVAL;
+		}
+	}
+
+	/* Validate ce_bcn_tx_path_min_time */
+	if (conf->ce_bcn_tx_path_min_time <= CL_TX_BCN_PENDING_CHAIN_MIN_TIME) {
+		CL_DBG_ERROR(cl_hw, "Invalid ce_bcn_tx_path_min_time (%u)\n",
+			     conf->ce_bcn_tx_path_min_time);
+		return -EINVAL;
+	}
+
+	if (conf->ci_tx_sw_amsdu_max_packets > MAX_TX_SW_AMSDU_PACKET) {
+		cl_dbg_err(cl_hw, "ERROR: Invalid ci_tx_sw_amsdu_max_packets (%u), set default (%u)\n",
+			   conf->ci_tx_sw_amsdu_max_packets, MAX_TX_SW_AMSDU_PACKET);
+
+		conf->ci_tx_sw_amsdu_max_packets = MAX_TX_SW_AMSDU_PACKET;
+	}
+
+	if (conf->ce_tx_power_control > 100 || conf->ce_tx_power_control < 1) {
+		cl_dbg_err(cl_hw, "ERROR: Invalid ce_tx_power_control (%u), set default 100\n",
+			   conf->ce_tx_power_control);
+
+		conf->ce_tx_power_control = 100;
+	}
+
+	if (conf->ce_max_retry > CL_MAX_NUM_OF_RETRY) {
+		cl_dbg_err(cl_hw, "ERROR: Invalid ce_max_retry (%u), set default to maximum (%u)\n",
+			   conf->ce_max_retry, CL_MAX_NUM_OF_RETRY);
+
+		conf->ce_max_retry = CL_MAX_NUM_OF_RETRY;
+	}
+
+	if (!cl_tcv_is_valid_min_spacing(conf->ci_su_force_min_spacing)) {
+		cl_dbg_err(cl_hw, "ERROR: Invalid ci_su_force_min_spacing (%u), must be 0/1/2/3/4/6/8/10/12/14/16/18/20/24, set default %u\n",
+			   conf->ci_su_force_min_spacing, CL_TX_MPDU_SPACING_INVALID);
+
+		conf->ci_su_force_min_spacing = CL_TX_MPDU_SPACING_INVALID;
+	}
+
+	if (!cl_tcv_is_valid_min_spacing(conf->ci_mu_force_min_spacing)) {
+		cl_dbg_err(cl_hw, "ERROR: Invalid ci_mu_force_min_spacing (%u), must be 0/1/2/3/4/6/8/10/12/14/16/18/20/24, set default %u\n",
+			   conf->ci_mu_force_min_spacing, CL_TX_MPDU_SPACING_INVALID);
+
+		conf->ci_mu_force_min_spacing = CL_TX_MPDU_SPACING_INVALID;
+	}
+
+	if (conf->ci_max_mpdu_len != IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895 &&
+	    conf->ci_max_mpdu_len != IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991 &&
+	    conf->ci_max_mpdu_len != IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454) {
+		cl_dbg_err(cl_hw, "ERROR: Invalid 'ci_max_mpdu_len' (%u). Must be 0/1/2. Setting to 0\n",
+			   conf->ci_max_mpdu_len);
+
+		conf->ci_max_mpdu_len = IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895;
+	}
+
+	if (cl_hw_is_tcv1(cl_hw) && cl_chip_is_both_enabled(chip)) {
+		/* Check that sum of ce_num_antennas in both TCV's is smaller than max_antennas */
+		struct cl_hw *cl_hw_tcv0 = chip->cl_hw_tcv0;
+		u8 num_ant_tcv0 = cl_hw_tcv0->conf->ce_num_antennas;
+		u8 num_ant_tcv1 = conf->ce_num_antennas;
+		u8 total_ant = num_ant_tcv0 + num_ant_tcv1;
+
+		if (total_ant > chip->max_antennas) {
+			CL_DBG_ERROR(cl_hw,
+				     "Invalid ce_num_antennas tcv0=%u, tcv1=%u, total=%u, max=%u\n",
+				     num_ant_tcv0, num_ant_tcv1, total_ant, chip->max_antennas);
+			return -1;
+		}
+	}
+
+	if (cl_hw_is_prod_or_listener(cl_hw) && !conf->ce_power_offset_prod_en) {
+		cl_dbg_err(cl_hw, "Disable PPMCS/PPBW in production mode\n");
+
+		if (cl_band_is_6g(cl_hw)) {
+			memset(conf->ce_ppmcs_offset_he_6g, 0,
+			       sizeof(conf->ce_ppmcs_offset_he_6g));
+		} else if (cl_band_is_5g(cl_hw)) {
+			memset(conf->ce_ppmcs_offset_he_36_64, 0,
+			       sizeof(conf->ce_ppmcs_offset_he_36_64));
+			memset(conf->ce_ppmcs_offset_he_100_140, 0,
+			       sizeof(conf->ce_ppmcs_offset_he_100_140));
+			memset(conf->ce_ppmcs_offset_he_149_165, 0,
+			       sizeof(conf->ce_ppmcs_offset_he_149_165));
+			memset(conf->ce_ppmcs_offset_ht_vht_36_64, 0,
+			       sizeof(conf->ce_ppmcs_offset_ht_vht_36_64));
+			memset(conf->ce_ppmcs_offset_ht_vht_100_140, 0,
+			       sizeof(conf->ce_ppmcs_offset_ht_vht_100_140));
+			memset(conf->ce_ppmcs_offset_ht_vht_149_165, 0,
+			       sizeof(conf->ce_ppmcs_offset_ht_vht_149_165));
+			memset(conf->ce_ppmcs_offset_ofdm_36_64, 0,
+			       sizeof(conf->ce_ppmcs_offset_ofdm_36_64));
+			memset(conf->ce_ppmcs_offset_ofdm_100_140, 0,
+			       sizeof(conf->ce_ppmcs_offset_ofdm_100_140));
+			memset(conf->ce_ppmcs_offset_ofdm_149_165, 0,
+			       sizeof(conf->ce_ppmcs_offset_ofdm_149_165));
+		} else {
+			memset(conf->ce_ppmcs_offset_he, 0, sizeof(conf->ce_ppmcs_offset_he));
+			memset(conf->ce_ppmcs_offset_ht, 0, sizeof(conf->ce_ppmcs_offset_ht));
+			memset(conf->ce_ppmcs_offset_ofdm, 0, sizeof(conf->ce_ppmcs_offset_ofdm));
+			memset(conf->ce_ppmcs_offset_cck, 0, sizeof(conf->ce_ppmcs_offset_cck));
+		}
+
+		memset(conf->ce_ppbw_offset, 0, sizeof(conf->ce_ppbw_offset));
+	}
+
+	if (!cl_band_is_24g(cl_hw) && cl_hw->conf->ci_signal_extension_en) {
+		cl_dbg_err(cl_hw, "ERROR: Invalid 'ci_signal_extension_en' (%u). Must be 0 for non 2.4Ghz band. Setting to 0\n",
+			   conf->ce_dyn_mcast_rate_en);
+
+		conf->ci_signal_extension_en = false;
+	}
+
+	if (conf->ce_dyn_mcast_rate_en && cl_band_is_6g(cl_hw)) {
+		cl_dbg_err(cl_hw, "ERROR: Invalid 'ce_dyn_mcast_rate_en' (%u). Must be 0 on 6Ghz band. Setting to 0\n",
+			   conf->ce_dyn_mcast_rate_en);
+
+		conf->ce_dyn_mcast_rate_en = 0;
+	}
+
+	if (conf->ce_dyn_bcast_rate_en && cl_band_is_6g(cl_hw)) {
+		cl_dbg_err(cl_hw, "ERROR: Invalid 'ce_dyn_bcast_rate_en' (%u). Must be 0 on 6Ghz band. Setting to 0\n",
+			   conf->ce_dyn_bcast_rate_en);
+
+		conf->ce_dyn_bcast_rate_en = 0;
+	}
+
+	return 0;
+}
+
+int cl_tcv_config_read(struct cl_hw *cl_hw)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	char *buf = NULL;
+	size_t size = 0;
+	int ret = 0;
+	char filename[CL_FILENAME_MAX] = {0};
+	u8 tcv_idx = cl_hw->idx;
+
+	snprintf(filename, sizeof(filename), "cl_tcv%u.dat", tcv_idx);
+	pr_debug("%s: %s\n", __func__, filename);
+	size = cl_file_open_and_read(chip, filename, &buf);
+
+	if (!buf) {
+		pr_err("read %s failed !!!\n", filename);
+		return -ENODATA;
+	}
+
+	ret = cl_tcv_set_all_params_from_buf(cl_hw, buf, size);
+	if (ret) {
+		kfree(buf);
+		return ret;
+	}
+
+	ret = cl_tcv_post_configuration(cl_hw, NULL);
+	if (ret) {
+		kfree(buf);
+		return ret;
+	}
+
+	kfree(buf);
+
+	return ret;
+}
+
+int cl_tcv_config_alloc(struct cl_hw *cl_hw)
+{
+	cl_hw->conf = kzalloc(sizeof(*cl_hw->conf), GFP_KERNEL);
+
+	if (!cl_hw->conf)
+		return -ENOMEM;
+
+	/* Copy default values */
+	memcpy(cl_hw->conf, &conf, sizeof(struct cl_tcv_conf));
+
+	return 0;
+}
+
+void cl_tcv_config_free(struct cl_hw *cl_hw)
+{
+	kfree(cl_hw->conf);
+	cl_hw->conf = NULL;
+}
+
+void cl_tcv_config_validate_calib_params(struct cl_hw *cl_hw)
+{
+	struct cl_tcv_conf *conf = cl_hw->conf;
+	u8 chain = 0;
+
+	if (cl_hw->chip->conf->ci_phy_dev == PHY_DEV_ATHOS) {
+		if (cl_hw->chip->rfic_version == ATHOS_B_VER) {
+			for (chain = 0; chain < MAX_ANTENNAS; chain++) {
+				if (conf->ci_calib_tx_init_rx_gain[chain] == INVALID_CALIB_RX_GAIN)
+					conf->ci_calib_tx_init_rx_gain[chain] =
+						CALIB_RX_GAIN_DEFAULT_ATHOS_B;
+				if (conf->ci_calib_rx_init_rx_gain[chain] == INVALID_CALIB_RX_GAIN)
+					conf->ci_calib_rx_init_rx_gain[chain] =
+						CALIB_RX_GAIN_DEFAULT_ATHOS_B;
+			}
+
+			if (conf->ci_calib_conf_rx_gain_upper_limit == INVALID_CALIB_RX_GAIN)
+				conf->ci_calib_conf_rx_gain_upper_limit =
+					CALIB_RX_GAIN_UPPER_LIMIT_ATHOS_B;
+			if (conf->ci_calib_conf_rx_gain_lower_limit == INVALID_CALIB_RX_GAIN)
+				conf->ci_calib_conf_rx_gain_lower_limit =
+					CALIB_RX_GAIN_LOWER_LIMIT_ATHOS_B;
+		} else {
+			for (chain = 0; chain < MAX_ANTENNAS; chain++) {
+				if (conf->ci_calib_tx_init_rx_gain[chain] == INVALID_CALIB_RX_GAIN)
+					conf->ci_calib_tx_init_rx_gain[chain] =
+						CALIB_RX_GAIN_DEFAULT_ATHOS;
+				if (conf->ci_calib_rx_init_rx_gain[chain] == INVALID_CALIB_RX_GAIN)
+					conf->ci_calib_rx_init_rx_gain[chain] =
+						CALIB_RX_GAIN_DEFAULT_ATHOS;
+			}
+
+			if (conf->ci_calib_conf_rx_gain_upper_limit == INVALID_CALIB_RX_GAIN)
+				conf->ci_calib_conf_rx_gain_upper_limit =
+					CALIB_RX_GAIN_UPPER_LIMIT_ATHOS;
+			if (conf->ci_calib_conf_rx_gain_lower_limit == INVALID_CALIB_RX_GAIN)
+				conf->ci_calib_conf_rx_gain_lower_limit =
+					CALIB_RX_GAIN_LOWER_LIMIT_ATHOS;
+		}
+	} else {
+		for (chain = 0; chain < MAX_ANTENNAS; chain++) {
+			if (conf->ci_calib_tx_init_rx_gain[chain] == INVALID_CALIB_RX_GAIN)
+				conf->ci_calib_tx_init_rx_gain[chain] = CALIB_RX_GAIN_DEFAULT;
+
+			if (conf->ci_calib_rx_init_rx_gain[chain] == INVALID_CALIB_RX_GAIN)
+				conf->ci_calib_rx_init_rx_gain[chain] = CALIB_RX_GAIN_DEFAULT;
+		}
+
+		if (conf->ci_calib_conf_rx_gain_upper_limit == INVALID_CALIB_RX_GAIN)
+			conf->ci_calib_conf_rx_gain_upper_limit = CALIB_RX_GAIN_UPPER_LIMIT;
+		if (conf->ci_calib_conf_rx_gain_lower_limit == INVALID_CALIB_RX_GAIN)
+			conf->ci_calib_conf_rx_gain_lower_limit = CALIB_RX_GAIN_LOWER_LIMIT;
+	}
+}
-- 
2.36.1

