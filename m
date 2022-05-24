Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE63532962
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbiEXLkK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236891AbiEXLkI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:40:08 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50045.outbound.protection.outlook.com [40.107.5.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661738CCFF
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9jk1fJVpgxh1yYdUQsG6MrM+gMtVF1C9sJQZyjgV4b5x1jzfh0PL+c2GyDiTmkQqdqfCWGe14QPRVe/98nhuMOO86ohNciG7i5deW3INswAzPY8dHRqrm2q2Q8Awh4rn6ZUEBv4dNHdag3prDiboF72CNPKA0b9yE/QHsQnc9vEmG4zpCgUGzqiBl3ya1+dsVAKeUCK+m0iMZJwgis7MvM+zJKZVu1bRTyoWtebInWvS2IHH/dYNOahCmv93ijWSsjz+e0IybfmBiU6CpLo5j4v98VWLAj4fUd/IGQ4Xh77UQnZ5ZfHKh/iqtqAA+4JEI+BRnjwCy13XAbr97sVQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KN5/acjSrvju7EIG0eZqJXiXf6PPmxLqwR4iqqJGsXo=;
 b=Ke/rkm5B2aMGPG5g8IJvwSfyUsv7NEUALvmfHdDq3Ds8NXds0z2RqUVeJNFjjqk0tFfvLENRXZFkIRYFH6r7VouVBncVRAN34iWEf39L8INHKHkGNkHNOc1/Cqnv71X//mOr/9Chu8rmkwMPeIn3SQbJxyV02ANyNhfgekvazDosZrSlqxAZNTWn1UwzFVFkZY5GG2azVziVeiTBE/IrtN8/qfFswBLKedSN5bRJcWwZTdv2bbbkj890En9PT5KtVT69GupeXj/xpdR9gLlzExr3X3/dxJvlg+1FhZIKvkmE+VTsBArkj97/Ltl+Ox1uq4Ixdvb93zXMCmdjE9mugw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KN5/acjSrvju7EIG0eZqJXiXf6PPmxLqwR4iqqJGsXo=;
 b=Kf8ZyvhnfHEjiGLoeYtZK2JQxg9AkCLLuQJ85GzVBGzHTYFW3+0tElrF8nYrC4lLQvlr+ieIOdAW2LqAi26sKbJNQ52g6WqRSNTamTWkkQW0NxVPoCniZYIqE8B/lzG9VgKUNN/rtqoMLbU+I74A7RAiLKgTvEgBgIKP+cO4tek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by DU0P192MB1571.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:34c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 11:38:52 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:52 +0000
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
Subject: [RFC v2 57/96] cl8k: add radio.h
Date:   Tue, 24 May 2022 14:34:23 +0300
Message-Id: <20220524113502.1094459-58-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 12ba11b1-fb28-4320-7b11-08da3d79efca
X-MS-TrafficTypeDiagnostic: DU0P192MB1571:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <DU0P192MB1571C0820F4666B61C7F4DDCF6D79@DU0P192MB1571.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J7XlE43Pq3iU9hJreqcCkE8AF4pVSfS+pkUCsNwZSEG4+Uvk9LKt3u+IeOqTxLo2NsZyjhgD1ZxCZBCZiZsaDsam9QauSkQrcEaO6qdXNrrleuE8uSr31/4TfBm2EqbgZZNeGNHkeZyp7ZUf78ReXqk+25kjLXk6M4npuoiacM2X1N6DSHHWiADIPGJOBzrJq8Vfo3ZBfWv9mquVTkjITupVSh9+rWXsXs3eIWlPNQ+yhTUMAGnoxXtGhjlSNI/yJigJR6PiV+AHXri7rzTO7kBbmf5guiJYjxQnaUJaZB4d9UYEjQrWA0jt7ShVMcKLRmvSzcaQGzAOorbgdlXliF3iauGrSpDoDujBT1TzCTj5oEL++yqIhAlVWzbEkzyv6zsTChn34e7V00t3qzhmZJwINbwfhFAQTz9k0DXtFa3LBkOkL2lCO+BtNBhPrbrOjLRHBakKDtBglkW2TSm4orYwJhHS1TxBIFcV3d2WOALzJtE8x+9lYi+b/jZY0O+9BW26KcAVojNV1BZLECnLl2F4TW/XG16496DH38UjuMJ3oXMvZ1Mjcd5zWvb6pBYnJSU9Ty7LN98pB5Qz9ZHbswlER92tfZs4EqHgsMqzW9otVmpJtiF7AGGVp6PLWI4EXfEMUz9jKVxQ8EzTlJ0Eo9kyVNDGwOPpT75bEntK80faaUu2OPuAnIlzwYK+MXUSLy4/2fbYlpwOuzGfOic1Rvw2fAuVT8Y8ZjZvS9A9T6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(39850400004)(346002)(396003)(376002)(6512007)(186003)(6916009)(9686003)(38350700002)(38100700002)(41300700001)(36756003)(316002)(54906003)(2616005)(1076003)(86362001)(107886003)(8676002)(66476007)(4326008)(66556008)(66946007)(52116002)(8936002)(6666004)(6506007)(2906002)(83380400001)(508600001)(5660300002)(6486002)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/+fjcLxVwSrTTpnNQUdsZK8EkJpCEbBKw7yxdnkibOdaG/l+Lu+41V9963IV?=
 =?us-ascii?Q?lotJ2iXoBbb1da33+QlM17WveeUAl1zMzF2eWe+UO2fHHKtdGYAN0auVob4q?=
 =?us-ascii?Q?lbkLKphNf9+spCf0uNo0g13lABS3EJi0FIEpfcINbeuddtybyynK9JXAX5Ev?=
 =?us-ascii?Q?WwpVeQKuWNBTmGcpqOWkIHcdF77mrxynVIZJHEEBf0Pe6lAfwU8Tliq35dt9?=
 =?us-ascii?Q?aMD1KApnHXZTMUrlvQRnonTFR6JBQLGiBfKt3G+UwYIRtkR3O+BDVsb2bHzH?=
 =?us-ascii?Q?1d8RLaAnDuHdvrWI+CQWhwhIWWHM3Wf+g8IZi3vEggopsCHj1jCG+ok2JfYp?=
 =?us-ascii?Q?nOb3Dl9iwv4kC3So/UG/iM3LPH7whCG9iwHieTOQBNC6hBmnj+WpP1Q+58yr?=
 =?us-ascii?Q?MzzSq7bFJHAZ5A7UI3EgZ7HquHG2Ljqkxfv5xY8JFGhOaj8o2gxq1D7YetoY?=
 =?us-ascii?Q?ZlwU/lU+h+5lRw9B0TFKD4ghP6winxeTulkrs61Eh+RI8Tzp7dJngu02sOQ7?=
 =?us-ascii?Q?5HHvFG543sHyG/PenlkY6vBn7v0ntjlc4TXeI9feE5e88O+7mF2rfoJgEXVZ?=
 =?us-ascii?Q?SeyTxNv8QaKfqYD5eRFxHjJyvzDOHNFRZ+dV8vC9xnhJS30rGxSQxOHtuEEK?=
 =?us-ascii?Q?+bINo2Nw6MreGWNlwa0+hTyKWWjJNeGS+PJDgEDn965gYXsNhVel3jmtcPKc?=
 =?us-ascii?Q?PVlvk9aGslpyUEV8VF3xcPGMob8h6v7iosklO1a4U71SMmfR6XgTvmEPLc6k?=
 =?us-ascii?Q?RxlMSDvs6IZW9yjKSeL2ENwHYk562xASDum8OrRexVnd3Co7aiCON8gbC8UU?=
 =?us-ascii?Q?6MH0GjOS/yj+Abzgl4IddCH0K28ZHmdhXA69x98wOKeHQyNNJRo3/NKbhbOO?=
 =?us-ascii?Q?rPnQ74hC7p4tU66WAt7T8vxHo7XoJqnZzt8RZg2GkNC3DNjYYqcizT2cRwdS?=
 =?us-ascii?Q?c39KAhzQLQj5ePC0HKkVn7t0oAvUZx9KtbtrywImott/nXHMsN1idezf0har?=
 =?us-ascii?Q?1+HIDrAicCLtHC3DCA/dkaMnzP+3dquS1NSwdyPQcSNYOO+0ai43ZhCNeZYe?=
 =?us-ascii?Q?zTpQOn5G1rAnovyQ80XTqHSHQTm56YdvYdgBJBW2F00f1EaHfbVRYHW1n7wz?=
 =?us-ascii?Q?Ph9zeE6GeMKZnJKKvJxPL6uol4RltYX5KWQ7n+X8NLEumbkjGzTC8UOz4464?=
 =?us-ascii?Q?Q9KhG8NrXtiotKUF2y6YY2hkhQdilRYaDKewzTK/IHfTQagPa1GHvgzsQtJX?=
 =?us-ascii?Q?b/HRxof9m5lj3dirTUD0ZGjUBR/a9llq2J3XA3+AVRl1eZ25CN3uIQBfE486?=
 =?us-ascii?Q?0flvrmbq4oBBpMmm34MmhKViKsg5TX24IXx0gmZhYyvEYLFXc5unzDN45/Hs?=
 =?us-ascii?Q?IwHO+O4is4rB0YvK+jRvrYb9zHxQf8oQy/GWDbV/EAGAnH1ScJsTNAjtGQdN?=
 =?us-ascii?Q?zcXRqqpPy8qMIVEkzWnJDj5UZRhCv5E7uv9dNereGaCY9iZfewF8juS/OZwq?=
 =?us-ascii?Q?0QQijp63FElu7iuz6H2TZRWObhUp2CBg1m4KS8T38qFQe1w2ypVj6p2gEUQy?=
 =?us-ascii?Q?Ct+IzJsWjeOoiKOaz2BvCuOWDZwcRtR5K7Qj1ZcJxGO50BgyCexn+souxSNg?=
 =?us-ascii?Q?PDHAiPk9NCB+rWosC+YOwlT5I3qahFA92u+er2RTLz0XmnQYPayYIomHOsSy?=
 =?us-ascii?Q?O4vcGEld+/a/SGUai9m2zEO3J3/Mxg+L/EOUIsCrN+W6U6VdKtFbrK0JWfrs?=
 =?us-ascii?Q?SVV5VjSwURO7nReei8YF1mlhEkWX80E=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ba11b1-fb28-4320-7b11-08da3d79efca
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:35.0970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCpYLw2sCQHXtc+cIi0lryS4G39qjWRkwOU2px2erXhqTBNHnIho4KmTlWsIkKbgN78URtkPp+UGkDzQQMxmdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB1571
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
 drivers/net/wireless/celeno/cl8k/radio.h | 130 +++++++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/radio.h

diff --git a/drivers/net/wireless/celeno/cl8k/radio.h b/drivers/net/wireless/celeno/cl8k/radio.h
new file mode 100644
index 000000000000..b51dec5b7b1e
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/radio.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_RADIO_H
+#define CL_RADIO_H
+
+#define RADIO_STATUS_OFF        0
+#define RADIO_STATUS_ON         1
+#define RADIO_STATUS_GOING_DOWN 2
+
+int cl_radio_on(struct cl_hw *cl_hw);
+void cl_radio_off_chip(struct cl_chip *chip);
+void cl_radio_on_chip(struct cl_chip *chip);
+bool cl_radio_is_off(struct cl_hw *cl_hw);
+bool cl_radio_is_on(struct cl_hw *cl_hw);
+bool cl_radio_is_going_down(struct cl_hw *cl_hw);
+void cl_radio_on_start(struct cl_hw *cl_hw);
+int cl_radio_boot(struct cl_chip *chip);
+int cl_radio_boot_recovery(struct cl_hw *cl_hw);
+/* Wakes up cl_radio_off_kthread after all the stations have disconnected. */
+void cl_radio_off_wake_up(struct cl_hw *cl_hw);
+
+struct cl_noise_reg {
+	struct list_head list;
+	u32 np_prim20_per_ant;
+	u32 np_prim20_per_ant2;
+	u32 nasp_prim20_per_ant;
+	u32 nasp_prim20_per_ant2;
+	u32 np_sub20_per_chn;
+	u32 np_sub20_per_chn2;
+	u32 nasp_sub20_per_chn;
+	u32 nasp_sub20_per_chn2;
+	u32 np_sec20_dens_per_ant;
+	u32 nasp_sec20_dens_per_ant;
+};
+
+struct cl_noise_db {
+	struct list_head reg_list;
+	bool hist_record;
+	u8 active_ant;
+	u8 sample_cnt;
+};
+
+void cl_noise_init(struct cl_hw *cl_hw);
+void cl_noise_close(struct cl_hw *cl_hw);
+void cl_noise_maintenance(struct cl_hw *cl_hw);
+
+#define RX_HDR_RSSI(rxhdr) \
+	{(rxhdr)->rssi1, (rxhdr)->rssi2, (rxhdr)->rssi3, \
+	 (rxhdr)->rssi4, (rxhdr)->rssi5, (rxhdr)->rssi6}
+
+struct cl_assoc_queue {
+	struct list_head list;
+	spinlock_t lock;
+};
+
+void cl_rssi_assoc_init(struct cl_hw *cl_hw);
+void cl_rssi_assoc_exit(struct cl_hw *cl_hw);
+void cl_rssi_assoc_handle(struct cl_hw *cl_hw, u8 *mac_addr, struct hw_rxhdr *rxhdr);
+void cl_rssi_assoc_find(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u8 num_sta);
+void cl_rssi_sort_descending(s8 rssi[MAX_ANTENNAS], u8 num_ant);
+s8 cl_rssi_calc_equivalent(struct cl_hw *cl_hw, s8 rssi[MAX_ANTENNAS]);
+s8 cl_rssi_get_strongest(struct cl_hw *cl_hw, s8 rssi[MAX_ANTENNAS]);
+void cl_rssi_block_ack_handler(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			       struct cl_agg_tx_report *agg_report);
+void cl_rssi_rx_handler(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			struct hw_rxhdr *rxhdr, s8 equivalent_rssi);
+void cl_rssi_bw_adjust(struct cl_hw *cl_hw, struct hw_rxhdr *rxhdr, s8 bw_factor);
+void cl_rssi_simulate(struct cl_hw *cl_hw, struct hw_rxhdr *rxhdr);
+
+/**
+ * CCA (=Clear Channel Assessment)
+ */
+
+struct cl_cca_db {
+	unsigned long time;
+};
+
+void cl_cca_maintenance(struct cl_hw *cl_hw);
+void cl_cca_init(struct cl_hw *cl_hw);
+
+/**
+ * Protection mode (RTS/CTS) control
+ */
+enum cl_txl_prot_mode {
+	TXL_NO_PROT,
+	TXL_PROT_RTS,
+	TXL_PROT_CTS,
+	TXL_PROT_RTS_FW,
+	TXL_PROT_CTS_FW,
+
+	TXL_PROT_MAX,
+};
+
+struct cl_prot_mode {
+	u8 current_val;
+	u8 default_val;
+	u8 dynamic_val;
+};
+
+void cl_prot_mode_init(struct cl_hw *cl_hw);
+void cl_prot_mode_set(struct cl_hw *cl_hw, u8 prot_mode_new);
+u8 cl_prot_mode_get(struct cl_hw *cl_hw);
+
+enum edca_ac {
+	EDCA_AC_BE,
+	EDCA_AC_BK,
+	EDCA_AC_VI,
+	EDCA_AC_VO,
+
+	EDCA_AC_MAX
+};
+
+struct edca_params {
+	u16 txop;
+	u8 cw_max;
+	u8 cw_min;
+	u8 aifsn;
+};
+
+struct cl_edca_db {
+	struct edca_params hw_params[AC_MAX];
+};
+
+void cl_edca_hw_conf(struct cl_hw *cl_hw);
+void cl_edca_set(struct cl_hw *cl_hw, u8 ac, struct edca_params *params,
+		 struct ieee80211_he_mu_edca_param_ac_rec *mu_edca);
+void cl_edca_recovery(struct cl_hw *cl_hw);
+
+#endif /* CL_RADIO_H */
-- 
2.36.1

