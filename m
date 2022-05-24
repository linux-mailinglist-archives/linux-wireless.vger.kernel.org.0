Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBEA532997
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbiEXLkn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236939AbiEXLkb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:40:31 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3D33C734
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Utc5RqpMHigRTnRoi35rkH9tjIZfMvSK4LtM3ImrGpgG62YkbBftiJgFzyE0le/XzxWHwZQ2TPmFuvGsE7FZSdjttMoAJqe7s2tPtc/X8ajoqSQOVq+H8hbC5cHiiy10nGQ17UXCIXN54UE/hmDiozdLEyb6usIhTCe6OI9wvlb3ySnfxqNWWObPSskW+Ym5iVs0FGXnuiG9KTzCV8djurCfpTPDuku+IoLz6ByxDvhIGrgcbWkR6Z2toMfd6HfbyNt/AuJ5v/zKwhHzU7juobvvd1qovv1f3pC8I3VUCoTbWNDJry8XS46ndhQLw+ttqcJ7+DuA44EZP87jZoVTWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgWPC1KCI3G9ezS9UigUn+P3W1nhuO+mGYJ8F5BubbA=;
 b=hoHisof7qu0X09fDELSGix804yMH98Op59CuLlnvCe1mq0EzlUETUaCJDJ+iWycW4NRL3/Nkc4H4uSjucNAqTxwlaSMjoRdUls33O63KtkVnyzFZvsjqCQeAW8OwlcJYWbHlLvYgp//jCrJXTO/z74l4/zAL0G63XVNzESYW809TqmuhAQe4EEHWVSZtRuSTOU0CnOQRNJOW+Y8odCsZ9gXdpr2AjAMdOm1swJiJp66xMyUnW6tTP46PW6edh8arqomhC17fpqdv3bAyU1Vx1q1RWmeqluPEFITLthFFXX6mHPqpp4TZfrmQoHU75JW2eFzW6SGbZuoFTmEhrc0JEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgWPC1KCI3G9ezS9UigUn+P3W1nhuO+mGYJ8F5BubbA=;
 b=Pq5gHyRWRs5nIk7traMkVmIoy4dN872hMQIc02EvSO7XRR86iBdWanqtyNp5WICLX32isYyAhYvG8u65qp73jgdB2V3ji22nj8P63jrbXhxNsDzVUCK2FnlUsjeGAk8umXdyqT4Ede+hO7EjYK8G1vJto79GpJdxfZ3uNIMtq24=
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
Subject: [RFC v2 80/96] cl8k: add temperature.c
Date:   Tue, 24 May 2022 14:34:46 +0300
Message-Id: <20220524113502.1094459-81-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: ddd1f043-20df-48fa-b8ac-08da3d79fae0
X-MS-TrafficTypeDiagnostic: VE1P192MB0669:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VE1P192MB066988E1297D376C6343A611F6D79@VE1P192MB0669.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pg5JyQgwArSC8+/Ts/C7eq9st4tao9+RHvyKgOh0/hxHNTfd+ajOLsPoNDKMp4ZrPDFZgJeaPEHNkRNFroe+MLVJ+zJAx/Q+UL8Ny9tdiw4IVD7B8ItiUJ8cy7qF9q77Le7TUT8zwho668avEy5nJRjR6uByJv/LPL4y7GGV2olh/dkdU/yNRYL8Iq77vyRLyOWPfzr06OvBi0P/mLRw/np9Mw7+kmsN/9pTdiYFn3xY4tKaISsz0qJHClEzT5rsiZl3l6T5mfDT3KbS06KDSApjcqntYb0g0mQZNn4Ta4mMmx0ng1opFOobu7JUsFhGKun/SoPyXfNo7lYUNr7l9j2Vko3OONepS4WuhRywx79p7ADuhnz3e8nwa8/J3zbWnFRQ6R43+uwi1U8u6714Q5DMtTllTL+AHKW7Yj1uNy0jh+k312TQkNujmx7o1NKrBDFIhQH4JECC6+g9dLuu6vF87/3RF+hHs2q3lVwYH+PjJOCGW/Eg7BW1GcBwHczxNA9pbHkWUa9v1yNYj4MwxwtXSPlR1KViw8wvtE5+ikZM7hoFoGOxCdJ3IEhes3gN37w9ndmGCQAXw57Sbq0h9h2V4C8yJXpJng5NHTOMjMaOP+XSEP2eLadKp43YYm4y3qp6HHC8OaoTa3ZOddgl7syH6BAvBT1v4Dg2ZBq304m1lu6VUmKO18jMY5ZJhzJ/d5DERZgQJf2UHlbciB1xqrtbqak74CyMka6ltc+mvDs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(376002)(136003)(366004)(346002)(39850400004)(8676002)(9686003)(26005)(36756003)(66946007)(66556008)(66476007)(4326008)(107886003)(83380400001)(6512007)(5660300002)(38350700002)(38100700002)(1076003)(2616005)(316002)(6916009)(6506007)(6486002)(54906003)(86362001)(8936002)(508600001)(41300700001)(6666004)(2906002)(186003)(52116002)(30864003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iI0cfWGiL20NybzQii5AO8vPsjzVVz1AT0cAWxVDTdMWIIYk8R5eFIx9OH4F?=
 =?us-ascii?Q?0teBFwV1mXUcWSIQ84cZNnMpgUNxIsbNoJjsJsXc9k6bQhjpoY2AnhI6k/FE?=
 =?us-ascii?Q?Hz0ioZF4nRIgXOo/o+MPhaCZtRar6L8H5TD6Ek33f5EBMjbCTzd/A2DeAZkw?=
 =?us-ascii?Q?25ztSYUwt4E1+fXq74bbzovGOikKwmjn8yfTlKwh7uTthkemIDDn5TgNJNcA?=
 =?us-ascii?Q?RRLhzZg1WdBnagHsJBlA9MpdmoVHUeIzlCvdKXmPbeRxP4hGbvKWxsz95+EB?=
 =?us-ascii?Q?5MKK6wW3hmVpwtXGPDJb/kCM91akSfvy31ObMSvcn5vbGTe5igzZFRFrUzfU?=
 =?us-ascii?Q?QR0GxTCjzHxKT/taVp3NIQxpEleBHFFNFcVf6Dx8wix/oBcLxfp+NKViQNhx?=
 =?us-ascii?Q?4htUm7KNbmY7cmuL05Q5fwaOiyGpc/2OsEiGj6IbtwSzWJDSKLOtp1uL/9kw?=
 =?us-ascii?Q?WaUVN1Yja8ftwpjDnmTwZ795RG93e5griczUdc0U7xns9Zu3I7IQiAngPLXm?=
 =?us-ascii?Q?S35YO7R6M0ft1N2DbHPlaK+r2qOg+P3IJR9z2aRjPm3DdSc/cY0QvVzsIxo9?=
 =?us-ascii?Q?cU0RgyahI5r9kqq/HtWPOdqc/HBkUsOREr/JbkF+b2Sk2t47AIOTv065BFkk?=
 =?us-ascii?Q?19f+idnc6GPjwJlvJ69EoXFZa+ixVjpO/fi3xEiYVANYtQZMKzwsrg4X2nwu?=
 =?us-ascii?Q?Of4Ca4cKeuH4piROwSu/Dq94ug+zVK47P/Wysdd8qJsCXOy52O5sIFnpUjl7?=
 =?us-ascii?Q?SRwVtYHnMVa+GfVZGW7/b8nsp4kCl0MOmKpN7YftIEjsYImxoxxjrc4Fea1B?=
 =?us-ascii?Q?jzwK2FnijZiU06ZTi+w6U3S46Ig4qNhql2ajNTms75ilvXNV6OlrMfjAeCvo?=
 =?us-ascii?Q?4ksibaC3RAby1ZI/sHgVMDXjXJ5gg93BVqRHDFsayqu1BJnNQ5EAHi7zCFya?=
 =?us-ascii?Q?k7GNRLTBiegfSPYeP+gZRKEGA3klUALbn1Xa6Wxaulf97iyKqjFMpbAXaSWs?=
 =?us-ascii?Q?iy/RtiX7ecGJGFl7+ZNXn0cbJoXvanJfvkerr/rUAHmNbTP0GXfP9IWAxJ8p?=
 =?us-ascii?Q?K4joTyLydXa/qsZqS9Pn7j3Co0vMABgfyF6cvafTbLB/mCBow0ayMrrgFRGU?=
 =?us-ascii?Q?OyDarCzCjVWiOlGPcPI9rW/j+1tvec8ZmvtGgsxbDilOBoU53WKiuGRHYz6g?=
 =?us-ascii?Q?Z+BTuHUbPB95oKAe7Wh0oLTMoFVxP8hI8flKnD4vS07O4yYX00hUAt2oM/U+?=
 =?us-ascii?Q?zNFF8rrcVhYj9NIS8uuumAvoVDvcMJHZ/lHE/UiBB/Y913iCONdqcSbQW2qD?=
 =?us-ascii?Q?qChK64yPJGPr4PKKYc+vz4+5Ix8Y1rA6vOchgZQYC1zmAIwtksE0cywUX9Rp?=
 =?us-ascii?Q?YMD//YMBA3MyFMfgA67E0FRXTqnh83b6OjXsBY0Iin6SmGP54RmZUHWaqKNV?=
 =?us-ascii?Q?tBNvy1TB2Uzmw3EnUzZE/M7VU4bkDZM1hFd4CL4N0EjlJ+WQSMNU8/jF9UTe?=
 =?us-ascii?Q?0EHpHD3831NPbGdFwfJQcGL78cEvj1Hgphqu41FFYxS+y+rGLVv6BQ1T6WhH?=
 =?us-ascii?Q?mD6ji1KtdkB99XfdGorH1GTDsQTbav8wqzNL1YPfd42iu/iDj1xyZTJr/4C1?=
 =?us-ascii?Q?JTBGYOTLXoY2lfgkndUH8J3umRCOLI+1+yHWtQxoTY4KKsCnjaiHamqXKOT5?=
 =?us-ascii?Q?5t40+Fw+l1ENOGON5kfBYjKwQZ+ej7oK5NAVJssX/xIDuZCzfbB6Os5Pabka?=
 =?us-ascii?Q?d9rnT2yy+4ad7lshb96ttHPGvm+2RzE=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd1f043-20df-48fa-b8ac-08da3d79fae0
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:53.7433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Ea5kyyFvIX2OOyRn7tsy0e2zGeFL47TG36cIR9pR6UonBjp7zpkXb0M4qTOvUtIpXh/z0dMR9V8mhvs6dVLmQ==
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
 .../net/wireless/celeno/cl8k/temperature.c    | 634 ++++++++++++++++++
 1 file changed, 634 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/temperature.c

diff --git a/drivers/net/wireless/celeno/cl8k/temperature.c b/drivers/net/wireless/celeno/cl8k/temperature.c
new file mode 100644
index 000000000000..f3c773d957f6
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/temperature.c
@@ -0,0 +1,634 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include <linux/kthread.h>
+
+#include "hw.h"
+#include "e2p.h"
+#include "channel.h"
+#include "power.h"
+#include "debug.h"
+#include "utils.h"
+#include "radio.h"
+#include "temperature.h"
+
+#define TEMP_DIFF_INVALID 0x7F
+
+#define TEMPERATURE_MIN 0
+#define TEMPERATURE_MAX 127
+
+#define DUTY_CYCLE_MAX  100
+#define DUTY_CYCLE_MIN  20
+#define DUTY_CYCLE_STEP 20
+
+#define TEMP_MEASUREMENT_TIMEOUT msecs_to_jiffies(500)
+
+static int cl_temperature_read_fw(struct cl_hw *cl_hw, enum cl_temp_mode desired_temp_mode,
+				  u16 *raw_bits)
+{
+	u8 retval = 0;
+	struct mm_anamon_read_cfm *cfm;
+
+	if (cl_msg_tx_anamon_read(cl_hw, ANAMON_MODE_TEMPERATURE, desired_temp_mode, 0) != 0) {
+		cl_dbg_err(cl_hw, "cl_msg_tx_anamon_read failed\n");
+		cl_msg_tx_free_cfm_params(cl_hw, MM_ANAMON_READ_CFM);
+		return -1;
+	}
+
+	cfm = (struct mm_anamon_read_cfm *)(cl_hw->msg_cfm_params[MM_ANAMON_READ_CFM]);
+	if (!cfm)
+		return -ENOMSG;
+
+	retval = cfm->retval;
+	*raw_bits = ((le16_to_cpu(cfm->raw_bits_data_0) + le16_to_cpu(cfm->raw_bits_data_1)) / 2);
+	cl_msg_tx_free_cfm_params(cl_hw, MM_ANAMON_READ_CFM);
+
+	return retval ? 0 : -1;
+}
+
+static s16 cl_raw_bits_to_temperature(u16 raw_bits, enum cl_temp_mode desired_temp_mode)
+{
+	s16 adcmv = cl_adc_to_mv(raw_bits);
+
+	/* Calculation of external thermistor */
+	if (desired_temp_mode == TEMP_MODE_EXTERNAL) {
+		/*
+		 * External-temperature calculation:
+		 * Ext_tmp = -196 * adcv ^ 3 + 403 * adcv ^ 2 - 356 * adcv + 146
+		 *
+		 * Ext_tmp = -196 * (adcmv / 1000) ^ 3 +
+		 *           403 * (adcmv / 1000) ^ 2 -
+		 *           356 * (adcmv / 1000) +
+		 *           146
+		 *
+		 * Ext_tmp = (-196 * adcmv ^ 3 +
+		 *            403000 * adcmv ^ 2 -
+		 *            356000000 * adcmv +
+		 *            146000000000) / 1000000000
+		 */
+		return (s16)div_s64(-196ULL * adcmv * adcmv * adcmv +
+				    403000ULL * adcmv * adcmv -
+				    356000000ULL * adcmv +
+				    146000000000ULL,
+				    1000000000);
+	}
+
+	/* Calculation of internal thermistor - ADCmv * slope - 163 (slope=0.290) */
+	if (desired_temp_mode == TEMP_MODE_INTERNAL)
+		return ((adcmv * 29) / 100) - 163;
+
+	return 0;
+}
+
+static void cl_temperature_set_power_offset(struct cl_hw *cl_hw, s8 power_offset)
+{
+	s8 total_pwr_offset[MAX_ANTENNAS] = {0};
+	u8 chan_idx = cl_channel_to_index(cl_hw, cl_hw->channel);
+	u8 i = 0;
+
+	cl_hw->temp_comp_db.power_offset = power_offset;
+
+	if (chan_idx == INVALID_CHAN_IDX)
+		goto out;
+
+	for (i = 0; i < MAX_ANTENNAS; i++) {
+		total_pwr_offset[i] =
+			(cl_hw->tx_pow_info[chan_idx][i].offset +
+			 POWER_OFFSET_RES * power_offset);
+	}
+
+out:
+	cl_msg_tx_set_ant_pwr_offset(cl_hw, total_pwr_offset);
+}
+
+static void cl_temperature_comp_tcv(struct cl_chip *chip, struct cl_hw *cl_hw, s16 temp_internal)
+{
+	struct cl_temp_comp_db *temp_comp_db = &cl_hw->temp_comp_db;
+	s8 new_power_offset = 0;
+
+	/* Accumulate temperature delta */
+	temp_comp_db->acc_temp_delta += (temp_internal - temp_comp_db->calib_temperature);
+
+	/* Check if it is time to make a new decision */
+	if ((chip->temperature.comp_iterations % CL_TEMP_COMP_ITERATIONS) != 0)
+		return;
+
+	/* Average the temperature delta over the last CL_TEMP_COMP_ITERATIONS samples */
+	temp_comp_db->avg_temp_delta = DIV_ROUND_CLOSEST(temp_comp_db->acc_temp_delta,
+							 CL_TEMP_COMP_ITERATIONS);
+
+	/* Reset accumulated temp delta */
+	temp_comp_db->acc_temp_delta = 0;
+
+	new_power_offset = (s8)DIV_ROUND_CLOSEST(temp_comp_db->avg_temp_delta *
+						 cl_hw->conf->ce_temp_comp_slope, 100);
+
+	if (temp_comp_db->power_offset == new_power_offset)
+		return;
+
+	cl_dbg_trace(cl_hw, "calib_temperature %d, avg_temp_delta %d, power_offset %d\n",
+		     temp_comp_db->calib_temperature,
+		     temp_comp_db->avg_temp_delta,
+		     new_power_offset);
+
+	cl_temperature_set_power_offset(cl_hw, new_power_offset);
+}
+
+static void cl_temperature_comp(struct cl_chip *chip, struct cl_hw *cl_hw)
+{
+	struct cl_temperature *temperature = &chip->temperature;
+	s16 temp_internal = 0;
+
+	if (!chip->conf->ce_temp_comp_en)
+		return;
+
+	temp_internal = cl_temperature_read(cl_hw, TEMP_MODE_INTERNAL);
+	temperature->comp_iterations++;
+
+	cl_dbg_chip_trace(chip, "comp_iterations = %u, temp_internal = %d\n",
+			  (temperature->comp_iterations % CL_TEMP_COMP_ITERATIONS), temp_internal);
+
+	if (cl_chip_is_tcv0_enabled(chip))
+		cl_temperature_comp_tcv(chip, chip->cl_hw_tcv0, temp_internal);
+
+	if (cl_chip_is_tcv1_enabled(chip))
+		cl_temperature_comp_tcv(chip, chip->cl_hw_tcv1, temp_internal);
+}
+
+static void cl_temperature_tx_duty_cycle(struct cl_chip *chip, u8 duty_cycle)
+{
+	u16 periodic_tx_time_on = chip->conf->ce_temp_protect_tx_period_ms * duty_cycle / 100;
+	u16 periodic_tx_time_off = chip->conf->ce_temp_protect_tx_period_ms - periodic_tx_time_on;
+
+	if (cl_chip_is_tcv0_enabled(chip))
+		cl_msg_tx_start_periodic_tx_time(chip->cl_hw_tcv0,
+						 periodic_tx_time_off, periodic_tx_time_on);
+
+	if (cl_chip_is_tcv1_enabled(chip))
+		cl_msg_tx_start_periodic_tx_time(chip->cl_hw_tcv1,
+						 periodic_tx_time_off, periodic_tx_time_on);
+}
+
+static void cl_temperature_protect_radio_off(struct cl_chip *chip, s16 temp_avg)
+{
+	struct cl_temp_protect_db *temp_protect_db = &chip->temperature.protect_db;
+	struct cl_chip_conf *conf = chip->conf;
+
+	if (temp_protect_db->force_radio_off)
+		return;
+
+	cl_radio_off_chip(chip);
+	temp_protect_db->force_radio_off = true;
+	cl_dbg_chip_verbose(chip, "temperature [%d] >= radio off threshold [%d] --> radio off!\n",
+			    temp_avg, conf->ce_temp_protect_radio_off_th);
+}
+
+static void cl_temperature_protect_radio_on(struct cl_chip *chip, s16 temp_avg)
+{
+	struct cl_temp_protect_db *temp_protect_db = &chip->temperature.protect_db;
+	struct cl_chip_conf *conf = chip->conf;
+	s16 temp_thr = conf->ce_temp_protect_radio_off_th - CL_TEMP_PROTECT_RADIO_OFF_HYST;
+
+	if (temp_avg >= temp_thr)
+		return;
+
+	cl_radio_on_chip(chip);
+	temp_protect_db->force_radio_off = false;
+	cl_dbg_chip_verbose(chip, "temperature [%d] < radio off threshold - hysteresis [%d] "
+				  "--> radio on!\n",
+			    temp_avg, temp_thr);
+}
+
+static void cl_temperature_protect_dec_duty_cycle(struct cl_chip *chip, s16 temp_avg)
+{
+	struct cl_temp_protect_db *temp_protect_db = &chip->temperature.protect_db;
+	struct cl_chip_conf *conf = chip->conf;
+
+	if (temp_protect_db->duty_cycle == DUTY_CYCLE_MIN)
+		return;
+
+	temp_protect_db->duty_cycle -= DUTY_CYCLE_STEP;
+	cl_temperature_tx_duty_cycle(chip, temp_protect_db->duty_cycle);
+	cl_dbg_chip_warn(chip,
+			 "temperature [%d] > protect_th_max [%d] --> decrease duty cycle [%u]!\n",
+			 temp_avg, conf->ce_temp_protect_th_max, temp_protect_db->duty_cycle);
+}
+
+static void cl_temperature_protect_inc_duty_cycle(struct cl_chip *chip, s16 temp_avg)
+{
+	struct cl_temp_protect_db *temp_protect_db = &chip->temperature.protect_db;
+	struct cl_chip_conf *conf = chip->conf;
+
+	if (temp_protect_db->duty_cycle == DUTY_CYCLE_MAX)
+		return;
+
+	temp_protect_db->duty_cycle += DUTY_CYCLE_STEP;
+	cl_temperature_tx_duty_cycle(chip, temp_protect_db->duty_cycle);
+	cl_dbg_chip_warn(chip,
+			 "temperature [%d] < protect_th_min [%d] --> increase duty cycle [%u]!\n",
+			 temp_avg, conf->ce_temp_protect_th_min, temp_protect_db->duty_cycle);
+}
+
+static void cl_temperature_protect_decision(struct cl_chip *chip, s16 temp_avg)
+{
+	struct cl_temp_protect_db *temp_protect_db = &chip->temperature.protect_db;
+	struct cl_chip_conf *conf = chip->conf;
+
+	/* Test mode - force test_mode_duty_cycle */
+	if (unlikely(temp_protect_db->test_mode_duty_cycle != DUTY_CYCLE_MAX)) {
+		cl_temperature_tx_duty_cycle(chip, temp_protect_db->test_mode_duty_cycle);
+		return;
+	}
+
+	/* Temperature protection logic:
+	 *
+	 * If the temperature is greater or equal to the radio off threshold
+	 * then set the radio off.
+	 * If the temperature is below the (radio off threshold - hysteresis [10])
+	 * then set the radio on again.
+	 *
+	 * Any time the temperature is greater than the max threshold then we
+	 * decrease the duty cycle.
+	 * Any time the temperature is below the min threshold then we increase
+	 * the duty cycle.
+	 */
+	if (temp_avg >= conf->ce_temp_protect_radio_off_th) {
+		cl_temperature_protect_radio_off(chip, temp_avg);
+		return;
+	}
+
+	if (temp_protect_db->force_radio_off) {
+		cl_temperature_protect_radio_on(chip, temp_avg);
+		return;
+	}
+
+	if (temp_avg > conf->ce_temp_protect_th_max) {
+		cl_temperature_protect_dec_duty_cycle(chip, temp_avg);
+		return;
+	}
+
+	if (temp_avg < chip->conf->ce_temp_protect_th_min) {
+		cl_temperature_protect_inc_duty_cycle(chip, temp_avg);
+		return;
+	}
+}
+
+static s16 cl_temperature_avg_protect(struct cl_temp_protect_db *temp_protect_db)
+{
+	/* Calculate average of last_samples */
+	u8 i;
+	s32 temp_avg = 0;
+
+	for (i = 0; i < CL_TEMP_PROTECT_NUM_SAMPLES; i++)
+		temp_avg += temp_protect_db->last_samples[i];
+
+	return (s16)(temp_avg / CL_TEMP_PROTECT_NUM_SAMPLES);
+}
+
+static void cl_temperature_protect_handle_read(struct cl_chip *chip, s16 temp)
+{
+	struct cl_temp_protect_db *temp_protect_db = &chip->temperature.protect_db;
+	unsigned long curr_time = jiffies_to_msecs(jiffies);
+	unsigned long delta_time = curr_time - temp_protect_db->last_timestamp;
+
+	/* Add current read */
+	temp_protect_db->last_samples[temp_protect_db->curr_idx] = temp;
+	temp_protect_db->curr_idx = (temp_protect_db->curr_idx + 1) % CL_TEMP_PROTECT_NUM_SAMPLES;
+
+	if (delta_time >= CL_TEMP_PROTECT_INTERVAL_MS) {
+		s16 temp_avg = cl_temperature_avg_protect(temp_protect_db);
+
+		cl_dbg_chip_trace(chip, "temp_avg = %d, delta_time = %lu\n", temp_avg, delta_time);
+		cl_temperature_protect_decision(chip, temp_avg);
+		temp_protect_db->last_timestamp = curr_time;
+	}
+}
+
+static void cl_temperature_protect(struct cl_chip *chip, struct cl_hw *cl_hw)
+{
+	s16 protect_temp = 0;
+	struct cl_chip_conf *conf = chip->conf;
+
+	switch (conf->ce_temp_protect_en) {
+	case TEMP_PROTECT_OFF:
+		return;
+	case TEMP_PROTECT_INTERNAL:
+		protect_temp = cl_temperature_read(cl_hw, TEMP_MODE_INTERNAL) +
+			conf->ce_temp_protect_delta;
+		break;
+	case TEMP_PROTECT_EXTERNAL:
+		protect_temp = cl_temperature_read(cl_hw, TEMP_MODE_EXTERNAL) +
+			conf->ce_temp_protect_delta;
+		break;
+	case TEMP_PROTECT_DIFF:
+		protect_temp = cl_temperature_read(cl_hw, TEMP_MODE_INTERNAL) -
+			chip->temperature.diff_internal_external + conf->ce_temp_protect_delta;
+		break;
+	}
+
+	cl_temperature_protect_handle_read(chip, protect_temp);
+}
+
+static int cl_e2p_read_temp_diff(struct cl_chip *chip, s8 *temp_diff)
+{
+	/* Read temp_diff from eeprom */
+	return cl_e2p_read(chip, temp_diff, SIZE_GEN_TEMP_DIFF, ADDR_GEN_TEMP_DIFF);
+}
+
+static int cl_e2p_write_temp_diff(struct cl_chip *chip, s8 temp_diff)
+{
+	/* Writing temp_diff to eeprom */
+	return cl_e2p_write(chip, (u8 *)&temp_diff, SIZE_GEN_TEMP_DIFF, ADDR_GEN_TEMP_DIFF);
+}
+
+static int cl_temperature_diff_update(struct cl_hw *cl_hw)
+{
+	s8 temp_diff = cl_temperature_read(cl_hw, TEMP_MODE_INTERNAL) -
+		cl_temperature_read(cl_hw, TEMP_MODE_EXTERNAL);
+
+	if (cl_e2p_write_temp_diff(cl_hw->chip, temp_diff)) {
+		cl_dbg_err(cl_hw, "Error occurred while writing temperature diff to EEPROM.\n");
+		return -1;
+	}
+
+	cl_hw->chip->temperature.diff_internal_external = temp_diff;
+	return 0;
+}
+
+static struct cl_hw *cl_init_measurement(struct cl_chip *chip)
+{
+	struct cl_hw *cl_hw = NULL;
+
+	mutex_lock(&chip->temperature.hw_lock);
+	cl_hw = cl_chip_is_tcv0_enabled(chip) ? chip->cl_hw_tcv0 : chip->cl_hw_tcv1;
+	if (cl_hw && test_bit(CL_DEV_STARTED, &cl_hw->drv_flags) &&
+	    !(cl_hw->conf && cl_hw->conf->ce_listener_en))
+		set_bit(cl_hw->tcv_idx, &chip->temperature.used_hw_map);
+	else
+		cl_hw = NULL;
+	mutex_unlock(&chip->temperature.hw_lock);
+
+	return cl_hw;
+}
+
+static void cl_deinit_measurement(struct cl_hw *cl_hw)
+{
+	struct cl_temperature *temperature = &cl_hw->chip->temperature;
+
+	clear_bit(cl_hw->tcv_idx, &temperature->used_hw_map);
+	wake_up(&temperature->measurement_done);
+}
+
+void cl_temperature_wait_for_measurement(struct cl_chip *chip, u8 tcv_idx)
+{
+	struct cl_temperature *temperature = &chip->temperature;
+	int timeout = 0;
+
+	mutex_lock(&temperature->hw_lock);
+	if (!test_bit(tcv_idx, &temperature->used_hw_map))
+		goto exit;
+
+	timeout = wait_event_timeout(temperature->measurement_done,
+				     !test_bit(tcv_idx, &temperature->used_hw_map),
+				     TEMP_MEASUREMENT_TIMEOUT);
+	WARN_ONCE(timeout != 0, "Measurment timeout reached!\n");
+
+exit:
+	mutex_unlock(&temperature->hw_lock);
+}
+
+static int cl_temperature_kthread(void *arg)
+{
+	struct cl_chip *chip = (struct cl_chip *)arg;
+	struct cl_hw *cl_hw = NULL;
+	unsigned long timeout = msecs_to_jiffies(CL_TEMPERATURE_TIMER_INTERVAL_MS);
+
+	while (!kthread_should_stop()) {
+		cl_hw = cl_init_measurement(chip);
+		if (cl_hw) {
+			cl_temperature_comp(chip, cl_hw);
+			cl_temperature_protect(chip, cl_hw);
+			cl_deinit_measurement(cl_hw);
+		}
+
+		if (wait_event_timeout(chip->temperature.wait_done,
+				       kthread_should_stop(), timeout)) {
+			cl_dbg_chip_trace(chip, "exit temperature kthread\n");
+			return 0;
+		}
+	}
+
+	return 0;
+}
+
+static void cl_temperature_recovery_protect(struct cl_hw *cl_hw)
+{
+	struct cl_chip *chip = cl_hw->chip;
+
+	if (chip->conf->ce_temp_protect_en != TEMP_PROTECT_OFF) {
+		u8 duty_cycle = chip->temperature.protect_db.duty_cycle;
+
+		if (duty_cycle < DUTY_CYCLE_MAX) {
+			u16 periodic_tx_time_on =
+				chip->conf->ce_temp_protect_tx_period_ms * duty_cycle / 100;
+			u16 periodic_tx_time_off =
+				chip->conf->ce_temp_protect_tx_period_ms - periodic_tx_time_on;
+
+			cl_msg_tx_start_periodic_tx_time(cl_hw, periodic_tx_time_off,
+							 periodic_tx_time_on);
+		}
+	}
+}
+
+static void cl_temperature_recovery_comp(struct cl_hw *cl_hw)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	s8 power_offset = cl_hw->temp_comp_db.power_offset;
+
+	if (!chip->conf->ce_temp_comp_en)
+		return;
+
+	if (power_offset)
+		cl_temperature_set_power_offset(cl_hw, power_offset);
+}
+
+void cl_temperature_init(struct cl_chip *chip)
+{
+	struct cl_temperature *temperature = &chip->temperature;
+	struct cl_temp_protect_db *temp_protect_db = &temperature->protect_db;
+	unsigned long curr_time_ms = jiffies_to_msecs(jiffies);
+
+	init_waitqueue_head(&temperature->wait_done);
+	init_waitqueue_head(&temperature->measurement_done);
+
+	mutex_init(&temperature->mutex);
+	mutex_init(&temperature->hw_lock);
+
+	temperature->internal_last = UNCALIBRATED_TEMPERATURE;
+	temperature->internal_read_timestamp = curr_time_ms;
+	temperature->external_last = UNCALIBRATED_TEMPERATURE;
+	temperature->external_read_timestamp = curr_time_ms;
+
+	/* Temp_protect_db init */
+	temp_protect_db->duty_cycle = DUTY_CYCLE_MAX;
+	temp_protect_db->test_mode_duty_cycle = DUTY_CYCLE_MAX;
+	temp_protect_db->last_timestamp = curr_time_ms;
+
+	temperature->kthread = kthread_run(cl_temperature_kthread,
+					   chip,
+					   "cl_temperature_kthread_%u",
+					   chip->idx);
+	if (IS_ERR(temperature->kthread)) {
+		cl_dbg_chip_err(chip, "Failed to create temperature kthread\n");
+		temperature->kthread = NULL;
+	}
+}
+
+void cl_temperature_close(struct cl_chip *chip)
+{
+	struct cl_temperature *temperature = &chip->temperature;
+
+	if (temperature->kthread) {
+		cl_dbg_chip_trace(chip, "stopping temperature kthread\n");
+		if (kthread_stop(temperature->kthread) != -EINTR)
+			wake_up(&temperature->wait_done);
+
+		temperature->kthread = NULL;
+	}
+}
+
+s8 cl_temperature_read(struct cl_hw *cl_hw, enum cl_temp_mode mode)
+{
+	u16 raw_bits = 0;
+	s16 temp_val = 0;
+	unsigned long curr_time = jiffies_to_msecs(jiffies);
+	unsigned long diff_time = 0;
+	struct cl_chip *chip = cl_hw->chip;
+	struct cl_temperature *temperature = &chip->temperature;
+
+	if (!IS_REAL_PHY(chip))
+		return UNCALIBRATED_TEMPERATURE;
+
+	mutex_lock(&temperature->mutex);
+
+	switch (mode) {
+	case TEMP_MODE_INTERNAL:
+		diff_time = curr_time - temperature->internal_read_timestamp;
+		if (diff_time <= CL_TEMPERATURE_UPDATE_INTERVAL_MS) {
+			temp_val = temperature->internal_last;
+			cl_dbg_chip_trace(chip, "Return last internal temperature %d\n", temp_val);
+			goto read_out;
+		}
+		break;
+	case TEMP_MODE_EXTERNAL:
+		diff_time = curr_time - temperature->external_read_timestamp;
+		if (diff_time <= CL_TEMPERATURE_UPDATE_INTERVAL_MS) {
+			temp_val = temperature->external_last;
+			cl_dbg_chip_trace(chip, "Return last external temperature %d\n", temp_val);
+			goto read_out;
+		}
+		break;
+	default:
+		cl_dbg_chip_err(chip, "Invalid temperature mode %d\n", mode);
+		goto read_err;
+	}
+
+	if (cl_temperature_read_fw(cl_hw, mode, &raw_bits)) {
+		cl_dbg_chip_err(chip, "Temperature read failed\n");
+		goto read_err;
+	}
+
+	temp_val = cl_raw_bits_to_temperature(raw_bits, mode);
+
+	if (temp_val > TEMPERATURE_MAX || temp_val < TEMPERATURE_MIN) {
+		cl_dbg_chip_err(chip, "Invalid temperature value %d\n", temp_val);
+		goto read_err;
+	}
+
+	/* Update temperature read db */
+	if (mode == TEMP_MODE_INTERNAL) {
+		temperature->internal_last = temp_val;
+		temperature->internal_read_timestamp = jiffies_to_msecs(jiffies);
+		cl_dbg_chip_trace(chip, "Read and save internal temperature %d\n", temp_val);
+	} else {
+		temperature->external_last = temp_val;
+		temperature->external_read_timestamp = jiffies_to_msecs(jiffies);
+		cl_dbg_chip_trace(chip, "Read and save external temperature %d\n", temp_val);
+	}
+
+read_out:
+	mutex_unlock(&temperature->mutex);
+	return temp_val;
+
+read_err:
+	/* If temperature read failed return the last valid value */
+	mutex_unlock(&temperature->mutex);
+
+	return (mode == TEMP_MODE_INTERNAL) ?
+		temperature->internal_last : temperature->external_last;
+}
+
+void cl_temperature_recovery(struct cl_hw *cl_hw)
+{
+	cl_temperature_recovery_protect(cl_hw);
+	cl_temperature_recovery_comp(cl_hw);
+}
+
+int cl_temperature_diff_e2p_read(struct cl_hw *cl_hw)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	struct cl_temperature *temperature = &chip->temperature;
+
+	if (cl_e2p_read_temp_diff(chip, &temperature->diff_internal_external) ||
+	    temperature->diff_internal_external == TEMP_DIFF_INVALID) {
+		if (cl_temperature_diff_update(cl_hw))
+			return -1;
+
+		cl_dbg_chip_verbose(chip, "Temperature difference: Internal - External = %d\n",
+				    temperature->diff_internal_external);
+	}
+
+	return 0;
+}
+
+s16 cl_temperature_calib_calc(struct cl_hw *cl_hw, u16 raw_bits)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	s16 temperature = cl_raw_bits_to_temperature(raw_bits, TEMP_MODE_INTERNAL) +
+		chip->conf->ce_temp_protect_delta;
+
+	if (temperature >= TEMPERATURE_MIN && temperature <= TEMPERATURE_MAX)
+		return temperature;
+
+	cl_dbg_chip_err(chip, "Invalid temperature = %d\n", temperature);
+
+	return (chip->temperature.internal_last + chip->conf->ce_temp_protect_delta);
+}
+
+void cl_temperature_comp_update_calib(struct cl_hw *cl_hw)
+{
+	u8 chan_idx = cl_channel_to_index(cl_hw, cl_hw->channel);
+	u8 ant, ant_cnt = 0;
+	s16 total_temp = 0;
+	struct cl_tx_power_info *info = NULL;
+
+	if (unlikely(chan_idx == INVALID_CHAN_IDX)) {
+		cl_dbg_err(cl_hw, "Unsupported frequency %u\n", cl_hw->center_freq);
+		return;
+	}
+
+	info = &cl_hw->tx_pow_info[chan_idx][0];
+
+	/* Sum up the temperature of all phys */
+	for (ant = 0; ant < MAX_ANTENNAS && ant_cnt < cl_hw->num_antennas; ant++) {
+		if (!(cl_hw->mask_num_antennas & BIT(ant)))
+			continue;
+
+		total_temp += info[ant].temperature;
+		ant_cnt++;
+	}
+
+	/* Average the total temperature and update chan_params */
+	cl_hw->temp_comp_db.calib_temperature = DIV_ROUND_CLOSEST(total_temp, cl_hw->num_antennas);
+}
+
-- 
2.36.1

