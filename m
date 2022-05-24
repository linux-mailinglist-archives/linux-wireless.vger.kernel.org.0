Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30BE532960
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbiEXLkH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiEXLkD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:40:03 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689F092D1D
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gdl3UvNq2Asyk/2nKA2s2JUKhDjrMs5PE3u2ZDJtUIaHJu3738jzz4QjQ0ePYF6TbocMT7TgHHBBhIF4/T37OnT/iSzHedBmvE+g7V1beU6y3R636iOxPVvStrlIM13UbrcDWeFHaiHwM2kvltqIhkf5PxVjw/qM8xD5qyGEB7wQPT8Vrnmm6mhd9YxqDTVD+yEizyGnPWXVbX4jNYpZ5mH1fzVwO9/g4Wt7Tmm7YSAabLyhGxPGBQnKDB3G4JtkIViWAwTLuljIEalmWWIO2aOvnympCjssMPzSRi3LoAj1BSUyxhP5+0g8w6KbaiXhLKwG/Q+I6er8YPa0UdHC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9328ff3sTPhLBWkOiYeDjCXOhOes3Yr2nLyBjnHesnI=;
 b=F2XY+1q0YQA5/PmjzdtwZ7eysf0JrmPFluK4ai7zjrm/wykee5yBat/BvVBlEp9sN6qb2un0YYVxRDHdSsHx/DoTP6wva3hBqKhalTKD2Nogmmu05WahL9AsO1nJYiSYYPlOkYk51+zrI8QjeQxmcRnEF5L3AoHqymWkUtctMj/NGEg8k7r+AxVpt6HmjrThgVuAsDhKf3KtMRVwgiQEF53rncnrw6SPetGPT49OQxX6twQO3Djy4kegbcMSR/YOxyW4ttIhnQiOfoy5Ht8fVfW5uiAMsxidojXA0QBiKKDcRh6NgL6BqFGpfGm4IrzqoNlxLfZ4uTl89hY2dHFFAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9328ff3sTPhLBWkOiYeDjCXOhOes3Yr2nLyBjnHesnI=;
 b=CCa+5hUiyEV8uPWFJqAUHm3jQhF1qLJk6JU5AZ+E1xTxXiz/ah6jNPI3+WGoI32kB982vnATItLvNVRVKqsTg7/m218auua7CYnrwoOCecYl3KtXFFQ/CdE38BD4MIHqrUWZSaL6z5nCTxpEBU2ZmdjGGX1JipQXUtfbyXd+pUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VE1P192MB0669.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:16f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:39:29 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:29 +0000
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
Subject: [RFC v2 79/96] cl8k: add tcv.h
Date:   Tue, 24 May 2022 14:34:45 +0300
Message-Id: <20220524113502.1094459-80-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 03743f81-66c1-4fd8-1e01-08da3d79fa6e
X-MS-TrafficTypeDiagnostic: VE1P192MB0669:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VE1P192MB06694D2E9B351B46364AAE22F6D79@VE1P192MB0669.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TUfrqMs9VH9RPLePEqKDeCj9+SRD8EL/8vFuHvs8osKKa9QGsPhhwTdzmvCFusTJ8TrTd2A5/tzjFN76/8EFVIxR28LGfBIoApuhISXQVW5bMr2UJ/i/Gm1qdaVjw4UP3bgWT8a4OeBMabBbuZvvHm+WttLqfnvMlsjJYIkSRbG9+yvhfJmG2jU01RqEh3K4GrnY0rPQZMKMlCQ0w7EV/VFMgXq6pE3NGGtvm7AiP5PF3OzjtHUgOW8HMHBOsT9zqUNcPJJiQQc5Z822RF7/7jJP6lvM33wYJqK5JMZDx9l+5Vui9jRbZqhmmdycx7ebthQ3Bi/A3iqIX8ApyhwgQeTtyXNvTjWP/bSDSZxM5HBuxdf3ZDNGTzwvB7i8OkbnJ59nAquWnYodyCg2QaRlfQ6Zm/DjItKj65D9J3Sj55ongzJJKDlpxTeiz9tmdcNAzx4AEf4vNrKjHBhZnqnjvym4umoRJhyabfvLSnkF70lQH0x5ABteobTAISHFqNFOg5YRhOJsE0ZCmlbn3bDZNu7ZDOnezv23FBEOqKP7Y+VHFBLI03/bD8eFwK1XAcUS7c3y67I80s6Kr8qZUCK2HoPDh1bB+PUn/nVIwNuFjjsBMag6p+WKRgR9+RGZhol420FZRz1RRRsxaANKVyVe0gIylw4vKnPH4+79Dkbcbh0GpDALAirldxhwjhAQ0cMfJJ+xlfmMkzFr/5g5VL5s1D++N+ZX4UlcfLz+DsM1O24=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(376002)(136003)(366004)(346002)(39850400004)(8676002)(9686003)(26005)(36756003)(66946007)(66556008)(66476007)(4326008)(107886003)(83380400001)(6512007)(5660300002)(38350700002)(38100700002)(1076003)(2616005)(316002)(6916009)(6506007)(6486002)(54906003)(86362001)(8936002)(508600001)(41300700001)(6666004)(2906002)(186003)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E47eIdm9mHSz4xrzKB6ArshjEFDLS736Nk0jbAc0gMYwF6wNF5JthmXt0Doh?=
 =?us-ascii?Q?wlhyjsL+EjodTjaPiy33Qruz4RhLcDj/w2DkFUDu4zZknNyXfu6oAwG+3n7s?=
 =?us-ascii?Q?aObSOvrDK3saqdh8yHA4Y7+oGjI3dNgdh/IGRHjzCw9D6JTlIWhRt98guQ/k?=
 =?us-ascii?Q?YlDshzZsHY5+uaFH6eN5vAdI5toIlwqBzpgb6uBD+kg3HJj93Fv8zOg2f0cM?=
 =?us-ascii?Q?aqg0/IZlDhI7osycfm+Z2F/TpiyvXSxy1a2HU3PiJ/qv1PoIa27HPk+g3JH6?=
 =?us-ascii?Q?wTQQt9fJqULyEZpovMH/30HvaZJokRYJmG9ywrD/TWaJL9S+UjXGXls+Uc6a?=
 =?us-ascii?Q?ElIf0S0G/h9lRfejTE9IkkXgWj+gUkg+nnFzcgDZvX2BcJUURb5ZV5/lt29A?=
 =?us-ascii?Q?+2slSzbQbqcSfGhG+Rk50AOd9kLNELucXIr6cRK6peNk0es7o4uvDpGnrOAJ?=
 =?us-ascii?Q?0j0iguENBJkA+P61NLk/6GTlcskTpGjQOQPMzowEkTCMckbeAM+2poHQSESc?=
 =?us-ascii?Q?PGUP5zYuXVNv0uCC3nVY8maV1qp8ibhcKPzq0pyYJOTS7djmpLD5r5W+VmMV?=
 =?us-ascii?Q?IqP8yChv5ksRpwPJPGSH5YQ5fQNyQ9Df/1TXc1ootFIH7qptff4Uh/cPZWLH?=
 =?us-ascii?Q?IvmBVPWpfN+7wPCKcRHhePeL703wchNsfFy2ukv0GAbPF6Qi4xzV4Vaof/Lp?=
 =?us-ascii?Q?GtucvjAS9b3F9st1lgX9BQxVWMkrRiX7YTMPpmjnYyab2lpIzD3VhVb7JWHA?=
 =?us-ascii?Q?gtzPMkxxQM60ED5Y0GiEnaFi+CcQrIlC+cWIt7zQV7StF4EryhUN5fgHCPYI?=
 =?us-ascii?Q?Hl/WFJSv+8xS1W8FFsxlSmuztKOp2qpG0NLTWqR/z+oZukZF55TWHi5EFfEb?=
 =?us-ascii?Q?/JRH26N7Ca+h3RuxTR/gpwZ+F7Pg9puk3b18TAWrzXwfEEGRHR3iGTzunugX?=
 =?us-ascii?Q?j9Kq681s8Hy+/cKHve03T6XYYjD9VLPTK8pq8E7SgbHqNOOcw3IxbO4TghmE?=
 =?us-ascii?Q?Ctdn8PMdUGYs9X2RoyP/rPdwBvOjiclTPWzDw2MQBegGXWh427hSyey175EH?=
 =?us-ascii?Q?qI/RM7A1tcOLViqt8JL/Ii3jD1C1l5PzhblrPvtY9ZFk8mi/WPPRVKLoyijS?=
 =?us-ascii?Q?2F/ljCAgbjRU15S4dJW+R4MhfGQ1qcNmCfTulsAiJJUsdeN71My7eCAAykMw?=
 =?us-ascii?Q?UAlbYMBOqCH1toL7TB1DDfUQENLwlzkRiGnsvPTUjnNHaS9gfhzowMo7pcWZ?=
 =?us-ascii?Q?IBu53ALx1401Lltq8lil3VLH65F/5PDx4iB2+lEaJcpRvJiZoVUT5ZYqV4VZ?=
 =?us-ascii?Q?va+N+b211D14I2g9QbmartMvnNeNKiE1EQRrqjZGxRN9dm+YkRV6PioWIxVf?=
 =?us-ascii?Q?3T4mwLA+0TT+ixuj4XEUNEK+z1C9AsaMetHdGJymQmsZCmccLw2cY5QLGpXA?=
 =?us-ascii?Q?tjc3gcN8xT+ICiq4AMi02fWQsbDaMAqNrmM0K438vyDpcI2LOXUxDKkEa+7o?=
 =?us-ascii?Q?JtP5TCdwgkqYhZTjh4ky/1rkImQhVri6ymD+Q+UZk/aAvoQLagxAJFlW1dZ0?=
 =?us-ascii?Q?ijg+JMM25Q50E8PGy+l/X9+0IkwGNR6CdC9nI35Svo8YfqlpwXT8QcNh4i/U?=
 =?us-ascii?Q?g+YAUHBEHk/1ss8PIEvQqeu4HbkQZQyj/9Qf/26emJWxH1/OUpP+mGVsf6Vx?=
 =?us-ascii?Q?BLsyO/hEVxD6gv5EUmNQvupOcy76gAwGg0UBhv00ZW5ZD+5vSxlxyH+Lt1Gb?=
 =?us-ascii?Q?kWGUZatOaGd1DVizlsT6Tltjvr9bdBs=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03743f81-66c1-4fd8-1e01-08da3d79fa6e
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:52.9610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J87myJsEOHKR7Ne/3Prh4mHj7H73iob9JPWiE4rhlHxnCKbQE8/R67g9dF3sMazvK1UwoZ/AJ1flexYIn7hdwQ==
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
 drivers/net/wireless/celeno/cl8k/tcv.h | 283 +++++++++++++++++++++++++
 1 file changed, 283 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tcv.h

diff --git a/drivers/net/wireless/celeno/cl8k/tcv.h b/drivers/net/wireless/celeno/cl8k/tcv.h
new file mode 100644
index 000000000000..99cf0938c5c4
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tcv.h
@@ -0,0 +1,283 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_TCV_CONFIG_H
+#define CL_TCV_CONFIG_H
+
+#include "def.h"
+#include "ipc_shared.h"
+#include "radio.h"
+#include "sounding.h"
+#include "eeprom.h"
+
+/**
+ * TCV (=Tranceiver) configuration, is related to the specific band on top
+ * of specific chipset.
+ */
+#define CL_DEFAULT_HAL_IDLE_TIMEOUT 16000  /* Idle request - 16ms */
+#define CL_TX_DEFAULT_AC0_TIMEOUT   500000 /* Background - 500ms */
+#define CL_TX_DEFAULT_AC1_TIMEOUT   300000 /* Best effort - 300ms */
+#define CL_TX_DEFAULT_AC2_TIMEOUT   200000 /* Video - 200ms */
+#define CL_TX_DEFAULT_AC3_TIMEOUT   200000 /* Voice - 200ms */
+#define CL_TX_DEFAULT_BCN_TIMEOUT   150000 /* Beacon - 150ms */
+
+/* Minimal MPDU spacing we support in TX - correspond to FW NX_TX_MPDU_SPACING */
+#define CL_TX_MPDU_SPACING_INVALID 0xFF
+
+enum {
+	CL_RATE_FALLBACK_COUNT_SU,
+	CL_RATE_FALLBACK_COUNT_MU,
+	CL_RATE_FALLBACK_RETRY_COUNT_THR,
+	CL_RATE_FALLBACK_BA_PER_THR,
+	CL_RATE_FALLBACK_BA_NOT_RECEIVED_THR,
+	CL_RATE_FALLBACK_DISABLE_MCS,
+
+	CL_RATE_FALLBACK_MAX,
+};
+
+struct cl_tcv_conf {
+	s8 ce_debug_level;
+	bool ce_radio_on;
+	bool ce_ps_ctrl_enabled;
+	bool ci_ieee80211h;
+	u8 ci_max_bss_num;
+	u8 ci_short_guard_interval;
+	u8 ci_max_mpdu_len;
+	u8 ci_max_ampdu_len_exp;
+	s8 ce_dsp_code[STR_LEN_32B];
+	s8 ce_dsp_data[STR_LEN_32B];
+	s8 ce_dsp_external_data[STR_LEN_32B];
+	bool ci_uapsd_en;
+	bool ce_eirp_regulatory_op_en;
+	bool ce_eirp_regulatory_prod_en;
+	bool ci_agg_tx;
+	bool ci_agg_rx;
+	bool ce_txldpc_en;
+	bool ci_ht_rxldpc_en;
+	bool ci_vht_rxldpc_en;
+	bool ci_he_rxldpc_en;
+	bool ci_cs_required;
+	s8 ci_rx_sensitivity_prod[MAX_ANTENNAS];
+	s8 ci_rx_sensitivity_op[MAX_ANTENNAS];
+	bool ci_min_he_en;
+	u8 ce_cck_tx_ant_mask;
+	u8 ce_cck_rx_ant_mask;
+	u8 ce_rx_nss;
+	u8 ce_tx_nss;
+	u8 ce_num_antennas;
+	u16 ce_max_agg_size_tx;
+	u16 ce_max_agg_size_rx;
+	bool ce_rxamsdu_en;
+	u8 ce_txamsdu_en;
+	u16 ci_tx_amsdu_min_data_rate;
+	u8 ci_tx_sw_amsdu_max_packets;
+	u16 ci_tx_packet_limit;
+	u16 ci_sw_txhdr_pool;
+	u16 ci_amsdu_txhdr_pool;
+	u16 ci_tx_queue_size_agg;
+	u16 ci_tx_queue_size_single;
+	bool ci_tx_push_cntrs_stat_en;
+	bool ci_traffic_mon_en;
+	u16 ci_ipc_rxbuf_size[CL_RX_BUF_MAX];
+	u16 ce_max_retry;
+	u8 ce_short_retry_limit;
+	u8 ce_long_retry_limit;
+	u8 ci_assoc_auth_retry_limit;
+	u8 ci_cap_bandwidth;
+	u32 ci_chandef_channel;
+	u8 ci_chandef_bandwidth;
+	bool ci_cck_in_hw_mode;
+	s8 ce_temp_comp_slope;
+	u32 ci_fw_dbg_severity;
+	u32 ci_fw_dbg_module;
+	u8 ci_lcu_dbg_cfg_inx;
+	u8 ci_dsp_lcu_mode;
+	u32 ci_hal_idle_to;
+	u32 ci_tx_ac0_to;
+	u32 ci_tx_ac1_to;
+	u32 ci_tx_ac2_to;
+	u32 ci_tx_ac3_to;
+	u32 ci_tx_bcn_to;
+	s8 ce_hardware_power_table[STR_LEN_256B];
+	s8 ce_arr_gain[STR_LEN_32B];
+	s8 ce_bf_gain_2_ant[STR_LEN_32B];
+	s8 ce_bf_gain_3_ant[STR_LEN_32B];
+	s8 ce_bf_gain_4_ant[STR_LEN_32B];
+	s8 ce_bf_gain_5_ant[STR_LEN_32B];
+	s8 ce_bf_gain_6_ant[STR_LEN_32B];
+	s8 ce_ant_gain[STR_LEN_32B];
+	s8 ce_ant_gain_36_64[STR_LEN_32B];
+	s8 ce_ant_gain_100_140[STR_LEN_32B];
+	s8 ce_ant_gain_149_165[STR_LEN_32B];
+	s8 ci_min_ant_pwr[STR_LEN_32B];
+	s8 ci_bw_factor[STR_LEN_32B];
+	u8 ce_mcast_rate;
+	bool ce_dyn_mcast_rate_en;
+	bool ce_dyn_bcast_rate_en;
+	u8 ce_default_mcs_ofdm;
+	u8 ce_default_mcs_cck;
+	bool ce_prot_log_nav_en;
+	u8 ce_prot_mode;
+	u8 ce_prot_rate_format;
+	u8 ce_prot_rate_mcs;
+	u8 ce_prot_rate_pre_type;
+	u8 ce_bw_signaling_mode;
+	u8 ci_dyn_cts_sta_thr;
+	s8 ci_vns_pwr_limit;
+	u8 ci_vns_pwr_mode;
+	s8 ci_vns_rssi_auto_resp_thr;
+	s8 ci_vns_rssi_thr;
+	s8 ci_vns_rssi_hys;
+	u16 ci_vns_maintenance_time;
+	u16 ce_bcn_tx_path_min_time;
+	bool ci_backup_bcn_en;
+	bool ce_tx_txop_cut_en;
+	u8 ci_bcns_flushed_cnt_thr;
+	bool ci_phy_err_prevents_phy_dump;
+	u8 ci_tx_rx_delay;
+	u8 ci_fw_assert_time_diff_sec;
+	u8 ci_fw_assert_storm_detect_thd;
+	u32 ce_hw_assert_time_max;
+	u8 ce_bg_assert_print;
+	u8 ce_fw_watchdog_mode;
+	u8 ce_fw_watchdog_limit_count;
+	u32 ce_fw_watchdog_limit_time;
+	s8 ci_rx_remote_cpu_drv;
+	s8 ci_rx_remote_cpu_mac;
+	u16 ci_pending_queue_size;
+	u8 ce_tx_power_control;
+	bool ce_acs_coex_en;
+	u8 ci_dfs_initial_gain;
+	u8 ci_dfs_agc_cd_th;
+	u16 ci_dfs_long_pulse_min;
+	u16 ci_dfs_long_pulse_max;
+	s8 ce_dfs_tbl_overwrite[STR_LEN_64B];
+	/* Power Per MCS values - 6g */
+	s8 ce_ppmcs_offset_he_6g[WRS_MCS_MAX_HE];
+	/* Power Per MCS values - 5g */
+	s8 ce_ppmcs_offset_he_36_64[WRS_MCS_MAX_HE];
+	s8 ce_ppmcs_offset_he_100_140[WRS_MCS_MAX_HE];
+	s8 ce_ppmcs_offset_he_149_165[WRS_MCS_MAX_HE];
+	s8 ce_ppmcs_offset_ht_vht_36_64[WRS_MCS_MAX_VHT];
+	s8 ce_ppmcs_offset_ht_vht_100_140[WRS_MCS_MAX_VHT];
+	s8 ce_ppmcs_offset_ht_vht_149_165[WRS_MCS_MAX_VHT];
+	s8 ce_ppmcs_offset_ofdm_36_64[WRS_MCS_MAX_OFDM];
+	s8 ce_ppmcs_offset_ofdm_100_140[WRS_MCS_MAX_OFDM];
+	s8 ce_ppmcs_offset_ofdm_149_165[WRS_MCS_MAX_OFDM];
+	/* Power Per MCS values - 24g */
+	s8 ce_ppmcs_offset_he[WRS_MCS_MAX_HE];
+	s8 ce_ppmcs_offset_ht[WRS_MCS_MAX_HT];
+	s8 ce_ppmcs_offset_ofdm[WRS_MCS_MAX_OFDM];
+	s8 ce_ppmcs_offset_cck[WRS_MCS_MAX_CCK];
+	/* Power Per BW values - all bands */
+	s8 ce_ppbw_offset[CHNL_BW_MAX];
+	bool ce_power_offset_prod_en;
+	bool ci_bf_en;
+	u8 ci_bf_max_nss;
+	u16 ce_sounding_interval_coefs[SOUNDING_INTERVAL_COEF_MAX];
+	u8 ci_rate_fallback[CL_RATE_FALLBACK_MAX];
+	u16 ce_rx_pkts_budget;
+	u8 ci_band_num;
+	bool ci_mult_ampdu_in_txop_en;
+	u8 ce_wmm_aifsn[AC_MAX];
+	u8 ce_wmm_cwmin[AC_MAX];
+	u8 ce_wmm_cwmax[AC_MAX];
+	u16 ce_wmm_txop[AC_MAX];
+	u8 ci_su_force_min_spacing;
+	u8 ci_mu_force_min_spacing;
+	u8 ci_tf_mac_pad_dur;
+	u32 ci_cca_timeout;
+	u16 ce_tx_ba_session_timeout;
+	bool ci_motion_sense_en;
+	s8 ci_motion_sense_rssi_thr;
+	u8 ci_wrs_max_bw;
+	u8 ci_wrs_min_bw;
+	s8 ci_wrs_fixed_rate[WRS_FIXED_PARAM_MAX];
+	u8 ce_he_mcs_nss_supp_tx[WRS_SS_MAX];
+	u8 ce_he_mcs_nss_supp_rx[WRS_SS_MAX];
+	u8 ce_vht_mcs_nss_supp_tx[WRS_SS_MAX];
+	u8 ce_vht_mcs_nss_supp_rx[WRS_SS_MAX];
+	u8 ci_pe_duration;
+	u8 ci_pe_duration_bcast;
+	u8 ci_gain_update_enable;
+	u8 ci_mcs_sig_b;
+	u8 ci_spp_ksr_value;
+	bool ci_rx_padding_en;
+	bool ci_stats_en;
+	bool ci_bar_disable;
+	bool ci_ofdm_only;
+	bool ci_hw_bsr;
+	bool ci_drop_to_lower_bw;
+	bool ci_force_icmp_single;
+	bool ce_wrs_rx_en;
+	u8 ci_hr_factor[CHNL_BW_MAX];
+	bool ci_csd_en;
+	bool ci_signal_extension_en;
+	bool ci_vht_cap_24g;
+	u32 ci_tx_digital_gain;
+	u32 ci_tx_digital_gain_cck;
+	s8 ci_ofdm_cck_power_offset;
+	bool ci_mac_clk_gating_en;
+	bool ci_phy_clk_gating_en;
+	bool ci_imaging_blocker;
+	u8 ci_sensing_ndp_tx_chain_mask;
+	u8 ci_sensing_ndp_tx_bw;
+	u8 ci_sensing_ndp_tx_format;
+	u8 ci_sensing_ndp_tx_num_ltf;
+	u8 ci_calib_ant_tx[MAX_ANTENNAS];
+	u8 ci_calib_ant_rx[MAX_ANTENNAS];
+	s8 ci_cca_ed_rise_thr_dbm;
+	s8 ci_cca_ed_fall_thr_dbm;
+	u8 ci_cca_cs_en;
+	u8 ci_cca_modem_en;
+	u8 ci_cca_main_ant;
+	u8 ci_cca_second_ant;
+	u8 ci_cca_flag0_ctrl;
+	u8 ci_cca_flag1_ctrl;
+	u8 ci_cca_flag2_ctrl;
+	u8 ci_cca_flag3_ctrl;
+	s8 ci_cca_gi_rise_thr_dbm;
+	s8 ci_cca_gi_fall_thr_dbm;
+	s8 ci_cca_gi_pow_lim_dbm;
+	u16 ci_cca_ed_en;
+	u8 ci_cca_gi_en;
+	bool ci_rx_he_mu_ppdu;
+	bool ci_fast_rx_en;
+	u8 ci_distance_auto_resp_all;
+	u8 ci_distance_auto_resp_msta;
+	bool ci_fw_disable_recovery;
+	bool ce_listener_en;
+	bool ci_tx_delay_tstamp_en;
+	u8 ci_calib_tx_init_tx_gain[MAX_ANTENNAS];
+	u8 ci_calib_tx_init_rx_gain[MAX_ANTENNAS];
+	u8 ci_calib_rx_init_tx_gain[MAX_ANTENNAS];
+	u8 ci_calib_rx_init_rx_gain[MAX_ANTENNAS];
+	u8 ci_calib_conf_rx_gain_upper_limit;
+	u8 ci_calib_conf_rx_gain_lower_limit;
+	u8 ci_calib_conf_tone_vector_20bw[IQ_NUM_TONES_REQ];
+	u8 ci_calib_conf_tone_vector_40bw[IQ_NUM_TONES_REQ];
+	u8 ci_calib_conf_tone_vector_80bw[IQ_NUM_TONES_REQ];
+	u8 ci_calib_conf_tone_vector_160bw[IQ_NUM_TONES_REQ];
+	u32 ci_calib_conf_gp_rad_trshld;
+	u32 ci_calib_conf_ga_lin_upper_trshld;
+	u32 ci_calib_conf_ga_lin_lower_trshld;
+	u8 ci_calib_conf_singletons_num;
+	u16 ci_calib_conf_rampup_time;
+	u16 ci_calib_conf_lo_coarse_step;
+	u16 ci_calib_conf_lo_fine_step;
+#ifdef CONFIG_CL8K_EEPROM_STM24256
+	u16 ci_calib_eeprom_channels_20mhz[EEPROM_CALIB_DATA_ELEM_NUM_20MHZ_TCV0];
+	u16 ci_calib_eeprom_channels_40mhz[EEPROM_CALIB_DATA_ELEM_NUM_40MHZ_TCV0];
+	u16 ci_calib_eeprom_channels_80mhz[EEPROM_CALIB_DATA_ELEM_NUM_80MHZ_TCV0];
+	u16 ci_calib_eeprom_channels_160mhz[EEPROM_CALIB_DATA_ELEM_NUM_160MHZ_TCV0];
+#endif
+	u16 ci_mesh_basic_rates[MESH_BASIC_RATE_MAX];
+};
+
+int cl_tcv_config_read(struct cl_hw *cl_hw);
+u8 cl_tcv_config_get_num_ap(struct cl_hw *cl_hw);
+int cl_tcv_config_alloc(struct cl_hw *cl_hw);
+void cl_tcv_config_free(struct cl_hw *cl_hw);
+void cl_tcv_config_validate_calib_params(struct cl_hw *cl_hw);
+
+#endif /* CL_TCV_CONFIG_H */
-- 
2.36.1

