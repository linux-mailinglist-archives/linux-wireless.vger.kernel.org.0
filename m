Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B28532963
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbiEXLjv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbiEXLjs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:48 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50064.outbound.protection.outlook.com [40.107.5.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA188D6AE
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nY6bea0EVB6BKbCMsePOf+48UAHHUyKDyClPyxlwGk4BPVnWzAmaZSAVxOonCm9ntsGdDTSSTkmX/5EcQ4aUpqOBbfRP+VyRKvn5gFZODBqlonJxwZVJp4VnGPWoTfqxIJjrkXAO2u2vsMWF7RQ51XBd+fR/TWFstESmPyL38OOryDTkg1tGG+Qe8k8i5mPo7kcK+EaF0NYqdtremX9y/tnDnBQo5Kl/gnqqP0ZU20YOM9WPU3XVuv0vbh53rxJ5GwraO8ohFf5I4aJso1f1UqZ8xtRCpQihBwJqJth3sCsZeTNK5TZjJqMzgCpEf6cpxiqf6oQQHpsczkiG+j9PJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oafhv9s5MwtR6ncqhHajnROUMJPJRs6kCLjamomQxpA=;
 b=NiKZiP3RtGnxQjMAETNCCIFQZxgCPODkkDht714pDRWrT40ewKGJ0KXBUu/IfoM60zBuum+0tcg5zRBkOCkMOdrx6W5awtIKgFvQXzOXsk3D59CZqg+zWyCwAnsrKRIjKkNWsUWpmAY3kdzBgZ+gxM26FIr2WsEpgQ3qs5ZfaBZS8siJ5gPmffcgwbZb+8B8U8kSeaAYoXE/um/noJxPwQgSl2Nt/MbgXG3tTJ83DpgQS2IDPimSsFLFyTlF0KwtaqS1v9GkPT84yNEqiWkHhjybxoFCyEjvYuHVYC5pzg1LM1Vi7zEeqTjGNrZUTAAWLS7GhCGwVvsthstcBNi48A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oafhv9s5MwtR6ncqhHajnROUMJPJRs6kCLjamomQxpA=;
 b=e+Qc51/EZDBRGOFuL2uXymdWNDkbtIOK4yEfV/98In3lSStfYgu+LT7CMqJkx0VvmjHlPUb8erfjg7g3j97kZw5JypawyKZSoSvisF5TMy63c9x7b9YKlm+voBKziEf/zVWdeU6LgUig9XXfAGGmyypBNXUhYA4ATKkgRD/e1I8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by DU0P192MB1571.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:34c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 11:38:51 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:51 +0000
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
Subject: [RFC v2 55/96] cl8k: add power.h
Date:   Tue, 24 May 2022 14:34:21 +0300
Message-Id: <20220524113502.1094459-56-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: d102efec-6672-4362-58d7-08da3d79eed0
X-MS-TrafficTypeDiagnostic: DU0P192MB1571:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <DU0P192MB15713A6CF9E343CB6C7D95BDF6D79@DU0P192MB1571.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MqGBTPeR/JFe5HIjM1PeM3uyN0TldgjzDprSmYIWpfEXN96ZbjFZN4B42+SpHwDvNUMokDVerRwrTpUSCrDXfdsleMaRan/aLLOxi/fxlZ9UWDBffeLb5skqsdSQlOVZ+DKbZ+V8S836704BHsuZo9WArDxMRABmigjU043+Tdxi56YZ3i/d6HnSNEv3ITpQ1d51lUtivRR7I08aWwCcLPde8xTE8mIZtV3cpL54Zr2CW/4epg5ed7gSd1UKJO6Rd5eMBLD/lMPLjt9RfC1rzg1T2Oesuvzd7NxOME+HOTG/1PtjdjHfUQ0jDCI9DAKJM8hiXIDufG28ygKFcuZC+DqporPdcXyzx02McfQifsUTT6Ru0J28/PjVCV+NJ3m0V3jUEBaV17dhD86EP3WzUnPEsE81moCQFN7CqKIOMRQbH3/JnQTKFTPO6HmB17/t66nftZCdlo2IKj7ckI0UfgoWigx6oGvjSSlmc15loxczmriH2zMJ2VT6/pLJMXY+G+THjZdN8IIXkD/iAzrMhS9qa0xcy1VY8YaN7qsnClKk6aYhw0NvdQhGplzJR7bHVX1o33Z/S3rNqA118DDazN5zNwVIrl44U+7RMLB0jurYqjLg3QMTJyZ502Xv25hJrELX6t/wlySuxnOCRsSj4yzoRWskfaJNekGi9nKGOdV5QOr629UKXo1TwpeasZBYLo+9GjUvC3S1CnMTDyUvGs9qxXlpvbgORiT82mP7s5E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(39850400004)(346002)(396003)(376002)(6512007)(186003)(6916009)(9686003)(38350700002)(38100700002)(41300700001)(36756003)(316002)(54906003)(2616005)(1076003)(86362001)(107886003)(8676002)(66476007)(4326008)(66556008)(66946007)(52116002)(8936002)(6666004)(6506007)(2906002)(83380400001)(508600001)(5660300002)(6486002)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nyBvilXCDat/WhsnpgwgypN1D+oiwJOM8nOFvqU44WL7gOE+JDKInQjE1jNW?=
 =?us-ascii?Q?7OkBIIdX9QhnD6zd1R2Dqtg+33lOGa8q6stJ/w0gEQZW3Diq0eCg3/8YE/nU?=
 =?us-ascii?Q?rd667jrqWEYyPhDXbTk67YmY6Suy6mt8DHcUAOV3DP7erBr+V0QoJxkBUGwO?=
 =?us-ascii?Q?WpUPFrjheZNnlmVdpgUOtY4U1LxKsh3vKJ7VteLdIk5eFGtWrjDWLDNCZDHj?=
 =?us-ascii?Q?WkkvLXzI03mvuWn6104IIHfPOq8qGMIDn/uZ9mi7n4P57sL1OWnZU+hBJbAv?=
 =?us-ascii?Q?BMUcnYM2uvRdwsackqqBI00Ak2J26Pvh0sdaB/+U67Mf910IwTyFxBM8Jxzx?=
 =?us-ascii?Q?hNizw50JtBLAaSSyj85dCPKU/rOZIdw6kpPc7SHKIxH2f1ZTW/E+QclLxYW7?=
 =?us-ascii?Q?XD9W/EQY1078L9psUeHsvkvapBuE+VArs47l+WKUzvtIzjZzDEU4WMxCmH6J?=
 =?us-ascii?Q?OWQR7/h239/n1wFjJLXErzBM0kSN9xDk4OsUL2XMzI45PSnJg8Ljp9QICzYR?=
 =?us-ascii?Q?4ZaEO1h/dJcqNIVLt608RGVZ6oEmuiHkVWLR56doRXKhajFlNgIP53kHTw81?=
 =?us-ascii?Q?PXvx/hFAoft9Ff0wZegqM1Ch6jra1TWh5DKOJfO+xffjbnwB0B1/ZyUwjdfT?=
 =?us-ascii?Q?9WqvUdqwX7m/JgWRWo95eyM0g3gyHBtpOmVVuf/ANJVCutFxmsuZiaVsxWmd?=
 =?us-ascii?Q?qnluUWTS7zzKFlWzdfNXllzct2LKDyoeRDBEGCZyXrdWQYzYgv+wsW5LE1Wc?=
 =?us-ascii?Q?W2FlyqHJtZUsBeDrIU/NTEe/NY13P8hTvmqvC29oEOk2xWNWlyar4zOxn+0+?=
 =?us-ascii?Q?aA79S0xf8eh25XW8hTNmhj2+vQpyKstD6PFYTDX/FDwr4Tmh+4MszTYr29dQ?=
 =?us-ascii?Q?ZvU7wOFustSB/dR+p8oh+h+l0y7sm7+60VZ2npB6gs8wQc2F+E3rPjHwqA1Q?=
 =?us-ascii?Q?RgPH0QYtcbTt0edpRIWN3C6yFZSUPct4Nv2BtSR0yyhpfrmFMMq1l6rEhpNb?=
 =?us-ascii?Q?jPPWNq0uy1vhWwm+x6+zAxXHThCO6GJZTSJqFAY2he13RzEnmY2OT03HxDxI?=
 =?us-ascii?Q?COXkyw1O9PmuzVP7uK0GbE/wybB9C5tZyv6vccSZ5qJaNjd5RAaSsHbA4bXD?=
 =?us-ascii?Q?udjveTv0ha7SyGpvKkX61V5khB5zHLTYf32L5jtGqARfovvxKbitqGRctwAY?=
 =?us-ascii?Q?9HdLm6ap/OCNI1M/uAcVpic43+6I2Oo2mBDJxuB9NnkMRXeDe0x7sap9SYk7?=
 =?us-ascii?Q?HaX+rBLOnhD1ah/CP6Qs4WcnsfuJd61Y6bjZoUd8CzxTHgGRVviuzA0vIX3V?=
 =?us-ascii?Q?zFGKfqZfteLk34KBjM4OcKYUjQF0IPNQzwwfkIQoPDb9P9ZRRBd2qs30fDZ0?=
 =?us-ascii?Q?1sYeRZw0/pW/yZdinUbS48GWYQ7Vp38pPy3u8/IaNPoci8sk7XUgBa6j+ETy?=
 =?us-ascii?Q?bXks08M991c4VpVXGbuPvXLg97uRxLyzDJn1/+sXd4KQ8a3Zdzq2BCBjY7Qi?=
 =?us-ascii?Q?+W90KUd6FdPh0OfvIEBqvV/hxEBLz3zcJGPumVZCW91M5R6lMz5xHSu4ohJs?=
 =?us-ascii?Q?G4iv+T4NsnPOdFhDQKGt7EaOpnb3fAUDBANHHxWCrAAUFLmltNc1+j5hQsC5?=
 =?us-ascii?Q?O1UtYTb2qRr2Nd++zEFlbYSw/1kArO7vnVKVg/P6+HxtPc5mnL6F+OCgpBzp?=
 =?us-ascii?Q?fdowtL1a5qJC+DYASFy00u7vTcxp+Ln31hNpRcug4bKHDMhdGGekAeuCsoFr?=
 =?us-ascii?Q?tWXebckVldrlI7GXgiZZioZrfNkKHoQ=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d102efec-6672-4362-58d7-08da3d79eed0
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:33.5346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXQllP0dCSBNL1NGhx5ddw5C48F7I0+PMzQpPZwAb7Kf2cPBGeVudPGUJ6fN56M8TB8MFskMeEmaPMUcJnqpcg==
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
 drivers/net/wireless/celeno/cl8k/power.h | 90 ++++++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/power.h

diff --git a/drivers/net/wireless/celeno/cl8k/power.h b/drivers/net/wireless/celeno/cl8k/power.h
new file mode 100644
index 000000000000..cd1d36492317
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/power.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_POWER_H
+#define CL_POWER_H
+
+#define NUM_POWER_WORDS  256
+#define POWER_MIN_DB     -10
+#define POWER_MIN_DB_Q1  (POWER_MIN_DB << 1)
+#define POWER_MIN_DB_Q8  (POWER_MIN_DB << 8)
+#define POWER_OFFSET_RES 4
+
+struct cl_power_table_data {
+	u8 conv_table[NUM_POWER_WORDS];
+};
+
+struct cl_power_table_info {
+	struct cl_power_table_data *data;
+	u32 dma_addr;
+};
+
+#define PWR_TBL_HE_BF_SIZE  (WRS_SS_MAX + 1)
+#define PWR_TBL_VHT_BF_SIZE WRS_SS_MAX
+
+/*
+ * Structure containing the power tables
+ * All values are in resolution of 0.5dBm
+ */
+struct cl_pwr_tables {
+	/* Regular Tx */
+	s8 ant_pwr_he[CHNL_BW_MAX][WRS_MCS_MAX_HE][PWR_TBL_HE_BF_SIZE];
+	s8 ant_pwr_ht_vht[CHNL_BW_MAX][WRS_MCS_MAX_VHT][PWR_TBL_VHT_BF_SIZE];
+	s8 ant_pwr_ofdm[WRS_MCS_MAX_OFDM];
+	s8 ant_pwr_cck[WRS_MCS_MAX_CCK];
+	/* VNS */
+	s8 ant_pwr_vns_he;
+	s8 ant_pwr_vns_ht_vht;
+	s8 ant_pwr_vns_ofdm;
+	s8 ant_pwr_vns_cck;
+	/* Auto response */
+	s8 pwr_auto_resp_he[WRS_MCS_MAX_HE];
+	s8 pwr_auto_resp_ht_vht[WRS_MCS_MAX_VHT];
+	s8 pwr_auto_resp_ofdm[WRS_MCS_MAX_OFDM];
+	s8 pwr_auto_resp_cck[WRS_MCS_MAX_CCK];
+	/* Auto response VNS */
+	s8 pwr_auto_resp_vns_he;
+	s8 pwr_auto_resp_vns_ht_vht;
+	s8 pwr_auto_resp_vns_ofdm;
+	s8 pwr_auto_resp_vns_cck;
+};
+
+struct cl_power_db {
+	u8 curr_percentage;
+	s8 curr_offset;
+	/* Used to validate margins of MAC power */
+	s8 bw_factor_q2[CHNL_BW_MAX];
+	s8 ant_factor_q2[MAX_ANTENNAS];
+};
+
+struct cl_tx_power_info {
+	s8 power;
+	s8 offset;
+	s8 temperature;
+};
+
+struct cl_power_truncate {
+	u8 he[CHNL_BW_MAX][WRS_MCS_MAX_HE][PWR_TBL_HE_BF_SIZE];
+	u8 ht_vht[CHNL_BW_MAX][WRS_MCS_MAX_VHT][PWR_TBL_VHT_BF_SIZE];
+	u8 ofdm[WRS_MCS_MAX_OFDM];
+	u8 cck[WRS_MCS_MAX_CCK];
+};
+
+int cl_power_table_alloc(struct cl_hw *cl_hw);
+void cl_power_table_free(struct cl_hw *cl_hw);
+u8 cl_power_tx_ant(struct cl_hw *cl_hw, enum cl_wrs_mode mode);
+s32 cl_power_antenna_gain_q8(struct cl_hw *cl_hw);
+s32 cl_power_antenna_gain_q1(struct cl_hw *cl_hw);
+s32 cl_power_array_gain_q8(struct cl_hw *cl_hw, u8 tx_ant);
+s8 cl_power_array_gain_q2(struct cl_hw *cl_hw, u8 tx_ant);
+s32 cl_power_array_gain_q1(struct cl_hw *cl_hw, u8 tx_ant);
+s32 cl_power_bf_gain_q1(struct cl_hw *cl_hw, u8 tx_ant, u8 nss);
+s32 cl_power_min_ant_q1(struct cl_hw *cl_hw);
+s8 cl_power_bw_factor_q2(struct cl_hw *cl_hw, u8 bw);
+s32 cl_power_average_calib_q1(struct cl_hw *cl_hw, u8 ant_num);
+s8 cl_power_offset_q1(struct cl_hw *cl_hw, u8 mode, u8 bw, u8 mcs);
+s8 cl_power_offset_check_margin(struct cl_hw *cl_hw, u8 bw, u8 ant_idx, s8 offset_q2);
+void cl_power_tables_update(struct cl_hw *cl_hw, struct cl_pwr_tables *pwr_tables);
+s32 cl_power_get_max(struct cl_hw *cl_hw);
+
+#endif /* CL_POWER_H */
-- 
2.36.1

