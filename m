Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1974953295E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbiEXLkF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbiEXLj7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:59 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50088.outbound.protection.outlook.com [40.107.5.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682CC84A19
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvqZ1xXTNzZaiXnRLrs0LTAp8zADMj76U9yVCRv8GlNWEGZv6AQTBnNb1zDrz0+3Pu2Le80gVcH+Wuy0279SE5Bz0dh7ARLVHN03LK1THWeVbUtV94Wt8xHXlWzirgCGj8YEJqmaqun7+VutI1+kfT+pE1d60MYbZYCUT3DrcymC4nOi5d+OPk2sRzb1C/sARin+C298grM277Uj6muSBxxGl/BvDH20jV13m7JdUTWfh61OCo9kjYDiePyLyFNERXRfxh/UGJe+ZKw528wBQBmJde1RK3XTe6/v60IU40r8T40YaH47fKikRoZ/p0CSR1KrJk8GYj0YxxtT2WSbNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVF/eLK5F0zynKTKaRr0M8gz7HAmsb11dMH/03d49gA=;
 b=MMnZhBzYHnaiCiy3Lm6QKIKX6qkoh6abINZdhD4gdpPRgCghDDBIZ4yYyrTUElrjz15DKCDOz0s70hTO2wCqjILsJR7yBZHlCvT+si1stxGHitCMx0kx4sV23NdDnXvbwi3HwNizSt6az+cKU6TiF3fSr1/e8QSvM42XVFGElxnoSkEHuHsk0IcAdMtyMQEIpPqMZyrmcLb9LHP1V/SfD0ttSb52S8SJcjn6ICOfewE8w5Kswq74PA4L6PR+mOY9DVTRDku+0VXQyO4F8RZtVwrqow0Hx3pIDerLnZPDKYq//6d7B9GPkyMIJjBngkIxelXZq1koioS5HQBdaviS+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVF/eLK5F0zynKTKaRr0M8gz7HAmsb11dMH/03d49gA=;
 b=mtJ0Ug+fXOz9+BEPVZl86UyaCSg3+Bvn5I/+x9B4Cbqub9AMl4F5rNe/chpbqKz6xEykjYwHDqkmxASQ20RkoayJFMZjBXChJrJcTaD/AJEosBP7T6UogbFUUX1578dA9z2b9fGYgv6CGu0yMYEBZ1zGbhpxG/03orVOe1/uG+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by DU0P192MB1571.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:34c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 11:38:50 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:50 +0000
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
Subject: [RFC v2 54/96] cl8k: add power.c
Date:   Tue, 24 May 2022 14:34:20 +0300
Message-Id: <20220524113502.1094459-55-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: b9b2b9f4-446c-49ae-599c-08da3d79ee5b
X-MS-TrafficTypeDiagnostic: DU0P192MB1571:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <DU0P192MB1571585BCF95136EE1CA67D3F6D79@DU0P192MB1571.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +egcCvViSMd7Endnutu+yOKKN7tWFXduu4A21qHal/RHWw/sc1IMIhaPIlVcZ0ODoIAwdLxo1bkoCcipqw5k7xX2CqS6rAUb/GzgG4vkjNufQLinfTDiJVzaBQMaR9F6lAWetYAh1mE9fHYpVMd+yj0EOf3bcvqvuvCEFBPdNusByy16CYukiD7wd6IGRggRkc7gSnTmkRg0vO+YhEBjVG3SIsWbvBTqkAQD1H+jcOFmVvYQcrNzZjZIApnPkST9En245e2sUEqo2GpmSTsLvbaQ/xkbreXwtvqGEgSyeJHLxDQTkN4pITC3tYH42/OQ7SnCEIuePvCEURbB9FxqghtnVQiRF6SuPPMBT7jg8HdjRKI7dAP4yLV+g9hMfQ7ZkweP9fqCPvsQDQ10EU4eC7Ub8ZnMKKYol5G/TAbyek8gLI5zcd0XxUaR/HSc2Fnew3yxx2FxuvhG8HU6FWrDYRe+Ty24lmhyJvnktvW+Ch+3wRv9ryHagmIeUlp2plCoV1tQsmSu24eSqE1fU+962f0L8FV4Quza4BtcOmGy3TLTH3W/jfG/JHlfpo61cDvPHAwIN9oHCXFNq4bNJI2JGRGqyjpWxTkm5F9/lED2e1D49w2JIYpCnncmbyIYu3hjUG17oA9stf9f/ykgBnMtVTB3EQzWn0Rj9DR2SZ8SXo1V2C/U0J95zFHZ6LN13Gmmc9Xy9lH6KHekAUkPO8DivK7rZKosVonq8X4f8IEuceo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(39850400004)(346002)(396003)(376002)(6512007)(186003)(6916009)(9686003)(38350700002)(38100700002)(41300700001)(36756003)(316002)(54906003)(2616005)(1076003)(86362001)(107886003)(8676002)(66476007)(4326008)(66556008)(66946007)(52116002)(8936002)(6666004)(6506007)(2906002)(83380400001)(508600001)(30864003)(5660300002)(6486002)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K0+gLve4m0zVBbgMqfkoBrJftqROBRZVYZToBNcblI7B8aVQvoDx4+9vDtpf?=
 =?us-ascii?Q?zh7IWQ0X71Xxw7d1DKyVSHLVl5Oh86KQaRVHt5ZmvDJfweqjfrAH0LCDCaOy?=
 =?us-ascii?Q?KTzpTnWLJWHRDbC/NIfrcwJv7Ej4kcx7d60aEI9UbWHKZv07wRBScXSQzT8a?=
 =?us-ascii?Q?3xKWIdneQv7Cgwnex7+5BbKkFkV1w+WFLv/HLq0QTUw5ddWIF5/fZhR/upQb?=
 =?us-ascii?Q?XvhJrcYZVtdsoTLsjPKbzV/cYvDJpzb9n2AWAF7Plt/p5YtgNckVWSp3vyOe?=
 =?us-ascii?Q?Z57GvperIW0yPuBuD/okLCcIysmZZ/yz5ghvQ000/hGzXbKv1qv3p1tIZGK6?=
 =?us-ascii?Q?WqlXzO9xSMljzK+qafsnWKk0oiaUAizwBfD57zgkYFFNHa/02yhR4uPegnGn?=
 =?us-ascii?Q?/NM0o14hA8GxQ7zxrnfIOvjzv3ucpE6MzgaSN29jxvAzhW0N/rg4aoMZgaN0?=
 =?us-ascii?Q?GuM4zV/OBsfYYMImstOfX/LOHQnhKAGhxYRaMs3Tnf05xjQHWzFctethnd2R?=
 =?us-ascii?Q?Frw2jD43S+OE3KJYEOT+R+Pus4VtovXWnAP9jSHUgIrnpS+qrEzRzj17+MbJ?=
 =?us-ascii?Q?Ndc5CVyKmcMdUJ+3iU3hLxEnsSj1yMgLsI3MNyf0XZu9VAOakxcizq0vXDZc?=
 =?us-ascii?Q?AbUO58/Yq/7Nr/JCBfVkZEEgleMfL1SsE1ERrPN47LhhrXK1pkPJPzZXL9Le?=
 =?us-ascii?Q?Hmpw9h2mGA5ZPPlwMgErptP+HqqXiMwdCec0KX5TOj9Qa+c48NGz8E01k84n?=
 =?us-ascii?Q?bu7SS6NquFxKCYitG7QIsgqdoA/IhF1FiU1BCTwiwsb6MhLhP8YutPngpj6O?=
 =?us-ascii?Q?DWGU3x1Iir/L4d0nVDNx5jwzTjlAyAJDPVSnBLlvKlIq/oQWI8LAaluF/OFK?=
 =?us-ascii?Q?gVpodqUCPOio5MBQ1jOEsQMp2YeUpUlhNW69bXXCGh8PtbmBMZILhN4iKqDW?=
 =?us-ascii?Q?eUuOmebt2HfW05hAyoDwphBtco9PZnS8rtY/pZ0JH34TrnO/T3Xixr/zm6aX?=
 =?us-ascii?Q?KRtPwspJIRE37NJkkx1FC/Dt9x96ELHeBZzGa7e7gHn0E5XiM+SvXvAAJQFp?=
 =?us-ascii?Q?NaalVeDbkJWoR4z+VWYRPIjSmx9pN5WoEjWiwqtyO3FHkQA6MnnBVSFtjKU5?=
 =?us-ascii?Q?u2l0+K2Lpf6gNgQ7U9XCuahSnfONerE/i+8Ub5OXnU14HmW3r7j8eEqRZ0Au?=
 =?us-ascii?Q?is/ZzsiUia63XnnQ1kqBxnyxbTkkJoK4wb3Ww0+S0L6TaVOtVxLbjyjmaDvg?=
 =?us-ascii?Q?6G5Lj4L2DGga2nqbwQXbgTgW3Z7xPZF9GYxHZLiXCzVDzffe86LO0vsvqWPU?=
 =?us-ascii?Q?xIMEMbAjkPa7avvE0ecjtQel/xeItGXgseuIx9JzN+rNjukLvswfM9TGeO7j?=
 =?us-ascii?Q?G25u2tTijnH0DmZUlbbLzYn4Q6UPIWY8HyIRL7APzNCczMu0kclzU1Xvrfn6?=
 =?us-ascii?Q?MG7KtKrumm2wg4SNADYO5szJy388FbNRDue7ZAsbqIye8KRAfxBe2hY2XErA?=
 =?us-ascii?Q?cPHqopSdIpemszv8wK/J2T+mkneVOIPtB7Fa9qr5LMF+zae+pej439kClQNQ?=
 =?us-ascii?Q?/9dX1RBJzaK7WglisKDKE3Sj1/jG/ycLz+m5FwBbq9Oobm5Af+ECfcFabQ+t?=
 =?us-ascii?Q?t2pu6dIuTgoQ45vspxNXv8p7j2grAuqKRWi/Da8F/x/D+47AQiOyeIxw+k7T?=
 =?us-ascii?Q?U+1xzqUjmr5YopjqVe5N9E2NRFlP4VN6xGAlhb2/PtJyMH32relS9C7CNfFl?=
 =?us-ascii?Q?aLy8sJWsphEHxMXPIFWhpvnBHtz1IOw=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b2b9f4-446c-49ae-599c-08da3d79ee5b
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:32.7522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +72NWNSvdU4/9hC+Ldm+htdv7weCo1ozAz+WbYE4FLzLQAww/HYC4dd32jUzG5x6duVGlmd8Mpe19Y2A0w4AHg==
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
 drivers/net/wireless/celeno/cl8k/power.c | 1123 ++++++++++++++++++++++
 1 file changed, 1123 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/power.c

diff --git a/drivers/net/wireless/celeno/cl8k/power.c b/drivers/net/wireless/celeno/cl8k/power.c
new file mode 100644
index 000000000000..ef62c4b7a332
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/power.c
@@ -0,0 +1,1123 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include <linux/string.h>
+
+#include "reg/reg_access.h"
+#include "channel.h"
+#include "debug.h"
+#include "utils.h"
+#include "e2p.h"
+#include "power.h"
+
+static u8 cl_power_table_read(struct cl_hw *cl_hw)
+{
+	u8 pwr_table_id = 0;
+
+	if (cl_e2p_read(cl_hw->chip, &pwr_table_id, 1, ADDR_GEN_PWR_TABLE_ID + cl_hw->tcv_idx))
+		return U8_MAX;
+
+	return pwr_table_id;
+}
+
+static int cl_power_table_fill(struct cl_hw *cl_hw)
+{
+	u8 pwr_table_id = cl_power_table_read(cl_hw);
+	u8 platform_idx = cl_hw->chip->platform.idx;
+	struct cl_platform_table *table = NULL;
+
+	table = cl_platform_get_active_table(cl_hw->chip, platform_idx);
+	if (!table)
+		return cl_hw->chip->conf->ce_production_mode ? 0 : -1;
+
+	switch (pwr_table_id) {
+	case 0:
+		if (cl_band_is_5g(cl_hw)) {
+			memcpy(cl_hw->power_table_info.data->conv_table,
+			       table->power_conv_table_5,
+			       NUM_POWER_WORDS);
+			cl_hw->tx_power_version = 5;
+		} else if (IS_REAL_PHY(cl_hw->chip)) {
+			CL_DBG_ERROR(cl_hw, "Power table ID (%u) is valid for 5g only\n",
+				     pwr_table_id);
+
+			if (!cl_hw_is_prod_or_listener(cl_hw))
+				return -EINVAL;
+		}
+		break;
+	case 1:
+		if (cl_band_is_24g(cl_hw)) {
+			memcpy(cl_hw->power_table_info.data->conv_table,
+			       table->power_conv_table_2,
+			       NUM_POWER_WORDS);
+			cl_hw->tx_power_version = 25;
+		} else if (IS_REAL_PHY(cl_hw->chip)) {
+			CL_DBG_ERROR(cl_hw, "Power table ID (%u) is valid for 2.4g only\n",
+				     pwr_table_id);
+
+			if (!cl_hw_is_prod_or_listener(cl_hw))
+				return -1;
+		}
+		break;
+	case 2:
+		if (cl_band_is_6g(cl_hw)) {
+			memcpy(cl_hw->power_table_info.data->conv_table,
+			       table->power_conv_table_6,
+			       NUM_POWER_WORDS);
+			cl_hw->tx_power_version = 1;
+		} else if (IS_REAL_PHY(cl_hw->chip)) {
+			CL_DBG_ERROR(cl_hw, "Power table ID (%u) is valid for 6g only\n",
+				     pwr_table_id);
+
+			if (!cl_hw_is_prod_or_listener(cl_hw))
+				return -1;
+		}
+		break;
+	default:
+		if (IS_REAL_PHY(cl_hw->chip)) {
+			CL_DBG_ERROR(cl_hw, "Power table ID is not configured in EEPROM\n");
+
+			if (!cl_hw_is_prod_or_listener(cl_hw))
+				return -1;
+		}
+	}
+
+	cl_dbg_verbose(cl_hw, "Power table ID %u (V%u)\n", pwr_table_id, cl_hw->tx_power_version);
+
+	return 0;
+}
+
+int cl_power_table_alloc(struct cl_hw *cl_hw)
+{
+	struct cl_power_table_data *buf = NULL;
+	u32 len = sizeof(struct cl_power_table_data);
+	dma_addr_t phys_dma_addr;
+
+	buf = dma_alloc_coherent(cl_hw->chip->dev, len, &phys_dma_addr, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	cl_hw->power_table_info.data = buf;
+	cl_hw->power_table_info.dma_addr = phys_dma_addr;
+
+	return cl_power_table_fill(cl_hw);
+}
+
+void cl_power_table_free(struct cl_hw *cl_hw)
+{
+	struct cl_power_table_info *power_table_info = &cl_hw->power_table_info;
+	u32 len = sizeof(struct cl_power_table_data);
+	dma_addr_t phys_dma_addr = power_table_info->dma_addr;
+
+	if (!power_table_info->data)
+		return;
+
+	dma_free_coherent(cl_hw->chip->dev, len, (void *)power_table_info->data, phys_dma_addr);
+	power_table_info->data = NULL;
+}
+
+static s32 convert_str_int_q8(s8 *str)
+{
+	s32 x, y;
+
+	if (!str)
+		return 0;
+	if (sscanf(str, "%d.%2d", &x, &y) == 0)
+		return 0;
+	if (!strstr(str, "."))
+		return x << 8;
+	if (y < 10 && (*(strstr(str, ".") + 1) != '0'))
+		y *= 10;
+	return ((x * 100 + y) << 8) / 100;
+}
+
+u8 cl_power_tx_ant(struct cl_hw *cl_hw, enum cl_wrs_mode mode)
+{
+	if (mode == WRS_MODE_CCK)
+		return hweight8(cl_hw->conf->ce_cck_tx_ant_mask);
+
+	if (mode <= WRS_MODE_VHT)
+		return min_t(u8, cl_hw->num_antennas, MAX_ANTENNAS_OFDM_HT_VHT);
+
+	return cl_hw->num_antennas;
+}
+
+s32 cl_power_antenna_gain_q8(struct cl_hw *cl_hw)
+{
+	u8 channel = cl_hw->channel;
+
+	if (channel >= 36 && channel <= 64)
+		return convert_str_int_q8(cl_hw->conf->ce_ant_gain_36_64);
+	else if (channel >= 100 && channel <= 140)
+		return convert_str_int_q8(cl_hw->conf->ce_ant_gain_100_140);
+	else if (channel >= 149 && channel < 165)
+		return convert_str_int_q8(cl_hw->conf->ce_ant_gain_149_165);
+	else
+		return convert_str_int_q8(cl_hw->conf->ce_ant_gain); /* 2.4g and 6g */
+}
+
+s32 cl_power_antenna_gain_q1(struct cl_hw *cl_hw)
+{
+	return cl_power_antenna_gain_q8(cl_hw) >> 7;
+}
+
+s32 cl_power_array_gain_q8(struct cl_hw *cl_hw, u8 tx_ant)
+{
+	/*
+	 * Format in NVRAM of ce_arr_gain=A,B,C,D,E,F
+	 * A is the array gain with 1 tx_ant, B is with 2 tx_ant and so on...
+	 */
+	int arr_gain_val = 0;
+	int arr_gain_len = 0;
+	int idx = 0;
+	char *arr_gain_cpy = NULL;
+	char *arr_gain_cpy_p = NULL;
+	char *arr_gain_str = NULL;
+
+	arr_gain_len = strlen(cl_hw->conf->ce_arr_gain) + 1;
+	arr_gain_cpy_p = kzalloc(arr_gain_len, GFP_ATOMIC);
+	arr_gain_cpy = arr_gain_cpy_p;
+
+	if (!arr_gain_cpy)
+		return 0;
+
+	/* Copy cl_hw->conf->ce_arr_gain so its value won't be changed by strsep() */
+	memcpy(arr_gain_cpy, cl_hw->conf->ce_arr_gain, arr_gain_len);
+
+	/* Arr_gain_str points to the array gain of 1 tx_ant */
+	arr_gain_str = strsep(&arr_gain_cpy, ",");
+
+	/* Only a single value in ce_arr_gain - same value will be applied for all tx_ant */
+	if (!arr_gain_cpy) {
+		arr_gain_val = convert_str_int_q8(arr_gain_str);
+	} else {
+		/* Keep iterating until getting to the correct ant idx */
+		for (idx = 1; arr_gain_str && (idx < tx_ant); idx++)
+			arr_gain_str = strsep(&arr_gain_cpy, ",");
+
+		arr_gain_val = arr_gain_str ? convert_str_int_q8(arr_gain_str) : 0;
+	}
+
+	kfree(arr_gain_cpy_p);
+
+	return arr_gain_val;
+}
+
+s8 cl_power_array_gain_q2(struct cl_hw *cl_hw, u8 tx_ant)
+{
+	return (s8)(cl_power_array_gain_q8(cl_hw, tx_ant) >> 6);
+}
+
+s32 cl_power_array_gain_q1(struct cl_hw *cl_hw, u8 tx_ant)
+{
+	return cl_power_array_gain_q8(cl_hw, tx_ant) >> 7;
+}
+
+static s32 cl_power_bf_gain_q8(struct cl_hw *cl_hw, u8 tx_ant, u8 nss)
+{
+	/*
+	 * Format in NVRAM of ce_bf_gain=A,B,C,D
+	 * A is the bf gain with 1 NSS, B is with 2 NSS and so on...
+	 */
+	int bf_gain_val = 0;
+	int bf_gain_len = 0;
+	int idx = 0;
+	char *bf_gain_cpy = NULL;
+	char *bf_gain_cpy_p = NULL;
+	char *bf_gain_str = NULL;
+	s8 *bf_gain_ptr = NULL;
+
+	if (tx_ant == 6) {
+		bf_gain_ptr = cl_hw->conf->ce_bf_gain_6_ant;
+	} else if (tx_ant == 5) {
+		bf_gain_ptr = cl_hw->conf->ce_bf_gain_5_ant;
+	} else if (tx_ant == 4) {
+		bf_gain_ptr = cl_hw->conf->ce_bf_gain_4_ant;
+	} else if (tx_ant == 3) {
+		bf_gain_ptr = cl_hw->conf->ce_bf_gain_3_ant;
+	} else if (tx_ant == 2) {
+		bf_gain_ptr = cl_hw->conf->ce_bf_gain_2_ant;
+	} else if (tx_ant == 1) {
+		goto out;
+	} else {
+		pr_err("[%s]: invalid tx_ant %u\n", __func__, tx_ant);
+		goto out;
+	}
+
+	bf_gain_len = strlen(bf_gain_ptr) + 1;
+	bf_gain_cpy_p = kzalloc(bf_gain_len, GFP_ATOMIC);
+	bf_gain_cpy = bf_gain_cpy_p;
+
+	if (!bf_gain_cpy)
+		return 0;
+
+	/* Copy cl_hw->conf->ce_bf_gain_*_ant so its value won't be changed by strsep() */
+	memcpy(bf_gain_cpy, bf_gain_ptr, bf_gain_len);
+
+	/* Bf_gain_str points to the bf gain of 1 SS */
+	bf_gain_str = strsep(&bf_gain_cpy, ",");
+
+	/* Keep iterating until getting to the correct ss index */
+	for (idx = 0; bf_gain_str && (idx < nss); idx++)
+		bf_gain_str = strsep(&bf_gain_cpy, ",");
+
+	bf_gain_val = bf_gain_str ? convert_str_int_q8(bf_gain_str) : 0;
+
+	kfree(bf_gain_cpy_p);
+ out:
+	return bf_gain_val;
+}
+
+s32 cl_power_bf_gain_q1(struct cl_hw *cl_hw, u8 tx_ant, u8 nss)
+{
+	return cl_power_bf_gain_q8(cl_hw, tx_ant, nss) >> 7;
+}
+
+static s32 cl_power_min_ant_q8(struct cl_hw *cl_hw)
+{
+	return convert_str_int_q8(cl_hw->conf->ci_min_ant_pwr);
+}
+
+s32 cl_power_min_ant_q1(struct cl_hw *cl_hw)
+{
+	return cl_power_min_ant_q8(cl_hw) >> 7;
+};
+
+s8 cl_power_bw_factor_q2(struct cl_hw *cl_hw, u8 bw)
+{
+	/*
+	 * Format in NVRAM of ci_bw_factor=A,B,C,D
+	 * A is the bw factor for bw 20MHz, B is for 40MHz and so on..
+	 */
+	int bw_factor_val = 0;
+	int bw_factor_len = 0;
+	int idx = 0;
+	char *bw_factor_cpy = NULL;
+	char *bw_factor_cpy_p = NULL;
+	char *bw_factor_str = NULL;
+
+	bw_factor_len = strlen(cl_hw->conf->ci_bw_factor) + 1;
+	bw_factor_cpy = kzalloc(bw_factor_len, GFP_ATOMIC);
+	bw_factor_cpy = bw_factor_cpy_p;
+
+	if (!bw_factor_cpy)
+		return 0;
+
+	/* Copy cl_hw->conf->ci_bw_factor so its value won't be changed by strsep() */
+	memcpy(bw_factor_cpy, cl_hw->conf->ci_bw_factor, bw_factor_len);
+
+	/* Bw_factor_str points to the bw factor of 20MHz */
+	bw_factor_str = strsep(&bw_factor_cpy, ",");
+
+	/* Only a single value in ci_bw_factor - same value will be applied for all bandwidths */
+	if (!bw_factor_cpy) {
+		bw_factor_val = convert_str_int_q8(bw_factor_str);
+	} else {
+		/* Keep iterating until getting to the correct bw index */
+		for (idx = 0; bw_factor_str && (idx < bw); idx++)
+			bw_factor_str = strsep(&bw_factor_cpy, ",");
+
+		bw_factor_val = bw_factor_str ? convert_str_int_q8(bw_factor_str) : 0;
+	}
+
+	kfree(bw_factor_cpy_p);
+
+	return (s8)(bw_factor_val >> 6);
+}
+
+static s32 cl_power_average_calib_q8(struct cl_hw *cl_hw, u8 ant_num)
+{
+	u8 ant = 0, ant_cnt = 0;
+	u8 chan_idx = cl_channel_to_index(cl_hw, cl_hw->channel);
+	s32 total_calib_pow = 0;
+
+	if (chan_idx == INVALID_CHAN_IDX)
+		return 0;
+
+	for (ant = 0; ant < MAX_ANTENNAS && ant_cnt < ant_num; ant++) {
+		if (!(cl_hw->mask_num_antennas & BIT(ant)))
+			continue;
+
+		total_calib_pow += cl_hw->tx_pow_info[chan_idx][ant].power;
+		ant_cnt++;
+	}
+
+	return ((total_calib_pow << 8) / ant_num);
+}
+
+s32 cl_power_average_calib_q1(struct cl_hw *cl_hw, u8 ant_num)
+{
+	return cl_power_average_calib_q8(cl_hw, ant_num) >> 7;
+}
+
+static s32 cl_power_total_q8(struct cl_hw *cl_hw, s8 pwr_offset_q1, u8 tx_ant, u8 nss,
+			     enum cl_wrs_mode mode, bool is_auto_resp)
+{
+	s32 bf_gain_q8 =  0;
+	s32 antenna_gain_q8 = cl_power_antenna_gain_q8(cl_hw);
+	s32 array_gain_q8 = cl_power_array_gain_q8(cl_hw, tx_ant);
+	s32 pwr_offset_q8 = (s32)pwr_offset_q1 << 7;
+	s32 calib_power_q8 = cl_power_average_calib_q8(cl_hw, tx_ant);
+	s32 total_power_q8 = 0;
+
+	if (!is_auto_resp)
+		bf_gain_q8 = (mode > WRS_MODE_OFDM) ? cl_power_bf_gain_q8(cl_hw, tx_ant, nss) : 0;
+
+	total_power_q8 = calib_power_q8 + bf_gain_q8 + array_gain_q8 +
+		antenna_gain_q8 + pwr_offset_q8;
+
+	/* FCC calculation */
+	if (cl_hw->channel_info.standard == NL80211_DFS_FCC)
+		total_power_q8 -= min(bf_gain_q8 + antenna_gain_q8, 6 << 8);
+
+	return total_power_q8;
+}
+
+static s32 cl_power_eirp_delta_q1(struct cl_hw *cl_hw, u8 bw, s8 pwr_offset_q1, u8 tx_ant,
+				  u8 nss, enum cl_wrs_mode mode, bool is_auto_resp)
+{
+	/* Calculate total TX power */
+	s32 total_power_q8 = cl_power_total_q8(cl_hw, pwr_offset_q1, tx_ant, nss,
+					       mode, is_auto_resp);
+
+	/* EIRP power limit */
+	s32 eirp_power_limit_q8 = cl_chan_info_get_eirp_limit_q8(cl_hw, bw);
+
+	/* Delta between total TX power and EIRP limit */
+	return (total_power_q8 - eirp_power_limit_q8) >> 7;
+}
+
+static s8 cl_power_calc_q1(struct cl_hw *cl_hw, s8 mcs_offset_q1, u8 bw, u8 nss,
+			   enum cl_wrs_mode mode, bool is_auto_resp, u8 *trunc_pwr_q1)
+{
+	/* Result is in 0.5dBm resolution */
+	u8 tx_ant = cl_power_tx_ant(cl_hw, mode);
+	s32 calib_power_q1 = cl_power_average_calib_q1(cl_hw, tx_ant);
+	s32 res_q1 = calib_power_q1 + mcs_offset_q1;
+	s32 min_pwr_q1 = POWER_MIN_DB_Q1;
+	u32 trunc_pwr_val_q1 = 0;
+	bool eirp_regulatory_en = cl_hw->chip->conf->ce_production_mode ?
+		cl_hw->conf->ce_eirp_regulatory_prod_en : cl_hw->conf->ce_eirp_regulatory_op_en;
+
+	if (cl_hw->channel_info.use_channel_info && eirp_regulatory_en) {
+		s32 delta_power_q1 = cl_power_eirp_delta_q1(cl_hw, bw, mcs_offset_q1,
+							    tx_ant, nss, mode, is_auto_resp);
+
+		if (delta_power_q1 > 0) {
+			/*
+			 * If tx power is greater than the limitation
+			 * subtract delta power from the result
+			 */
+			res_q1 -= delta_power_q1;
+			trunc_pwr_val_q1 = delta_power_q1;
+		}
+	}
+
+	if (is_auto_resp)
+		min_pwr_q1 += cl_power_min_ant_q1(cl_hw);
+
+	if (res_q1 < min_pwr_q1) {
+		trunc_pwr_val_q1 = max((s32)trunc_pwr_val_q1 - min_pwr_q1 - res_q1, 0);
+		res_q1 = min_pwr_q1;
+	}
+
+	if (is_auto_resp)
+		res_q1 += cl_power_array_gain_q1(cl_hw, tx_ant);
+
+	if (trunc_pwr_q1)
+		*trunc_pwr_q1 = (u8)trunc_pwr_val_q1;
+
+	return (s8)res_q1;
+}
+
+static s8 cl_power_offset_he(struct cl_hw *cl_hw, u8 bw, u8 mcs)
+{
+	u8 channel = cl_hw->channel;
+	s8 *ppmcs = NULL;
+
+	switch (cl_hw->conf->ci_band_num) {
+	case BAND_5G:
+		if (channel >= 36 && channel <= 64)
+			ppmcs = cl_hw->conf->ce_ppmcs_offset_he_36_64;
+		else if (channel >= 100 && channel <= 140)
+			ppmcs = cl_hw->conf->ce_ppmcs_offset_he_100_140;
+		else
+			ppmcs = cl_hw->conf->ce_ppmcs_offset_he_149_165;
+		break;
+	case BAND_24G:
+		ppmcs = cl_hw->conf->ce_ppmcs_offset_he;
+		break;
+	case BAND_6G:
+		ppmcs = cl_hw->conf->ce_ppmcs_offset_he_6g;
+		break;
+	default:
+		return 0;
+	}
+
+	return ppmcs[mcs] + cl_hw->conf->ce_ppbw_offset[bw];
+}
+
+static s8 cl_power_offset_ht_vht(struct cl_hw *cl_hw, u8 bw, u8 mcs)
+{
+	u8 channel = cl_hw->channel;
+	s8 *ppmcs = NULL;
+
+	switch (cl_hw->conf->ci_band_num) {
+	case BAND_5G:
+		if (channel >= 36 && channel <= 64)
+			ppmcs = cl_hw->conf->ce_ppmcs_offset_ht_vht_36_64;
+		else if (channel >= 100 && channel <= 140)
+			ppmcs = cl_hw->conf->ce_ppmcs_offset_ht_vht_100_140;
+		else
+			ppmcs = cl_hw->conf->ce_ppmcs_offset_ht_vht_149_165;
+		break;
+	case BAND_24G:
+		ppmcs = cl_hw->conf->ce_ppmcs_offset_ht;
+		break;
+	case BAND_6G:
+	default:
+		return 0;
+	}
+
+	return ppmcs[mcs] + cl_hw->conf->ce_ppbw_offset[bw];
+}
+
+static s8 cl_power_offset_ofdm(struct cl_hw *cl_hw, u8 mcs)
+{
+	u8 channel = cl_hw->channel;
+	s8 *ppmcs = NULL;
+
+	switch (cl_hw->conf->ci_band_num) {
+	case BAND_5G:
+		if (channel >= 36 && channel <= 64)
+			ppmcs = cl_hw->conf->ce_ppmcs_offset_ofdm_36_64;
+		else if (channel >= 100 && channel <= 140)
+			ppmcs = cl_hw->conf->ce_ppmcs_offset_ofdm_100_140;
+		else
+			ppmcs = cl_hw->conf->ce_ppmcs_offset_ofdm_149_165;
+		break;
+	case BAND_24G:
+		ppmcs = cl_hw->conf->ce_ppmcs_offset_ofdm;
+		break;
+	case BAND_6G:
+	default:
+		return 0;
+	}
+
+	return ppmcs[mcs] + cl_hw->conf->ce_ppbw_offset[CHNL_BW_20];
+}
+
+static s8 cl_power_offset_cck(struct cl_hw *cl_hw, u8 mcs)
+{
+	s8 *ppmcs = cl_hw->conf->ce_ppmcs_offset_cck;
+
+	if (cl_band_is_24g(cl_hw))
+		return ppmcs[mcs] + cl_hw->conf->ce_ppbw_offset[CHNL_BW_20];
+
+	return 0;
+}
+
+s8 cl_power_offset_q1(struct cl_hw *cl_hw, u8 mode, u8 bw, u8 mcs)
+{
+	if (mode == WRS_MODE_HE)
+		return cl_power_offset_he(cl_hw, bw, mcs);
+	else if (mode == WRS_MODE_HT || mode == WRS_MODE_VHT)
+		return cl_power_offset_ht_vht(cl_hw, bw, mcs);
+	else if (mode == WRS_MODE_OFDM)
+		return cl_power_offset_ofdm(cl_hw, mcs);
+	else if (mode == WRS_MODE_CCK)
+		return cl_power_offset_cck(cl_hw, mcs);
+
+	return 0;
+}
+
+#define UPPER_POWER_MARGIN_Q2 (38 << 2)
+#define LOWER_POWER_MARGIN_Q2 (50 << 2)
+
+s8 cl_power_offset_check_margin(struct cl_hw *cl_hw, u8 bw, u8 ant_idx, s8 offset_q2)
+{
+	s8 new_offset_q2 = 0;
+	s8 bw_factor_q2 = cl_hw->power_db.bw_factor_q2[bw];
+	s8 ant_factor_q2 = cl_hw->power_db.ant_factor_q2[ant_idx];
+	s8 total_offset_upper_q2 = bw_factor_q2 + offset_q2;
+	s8 total_offset_lower_q2 = bw_factor_q2 + ant_factor_q2 + offset_q2;
+	bool upper_limit_valid = (total_offset_upper_q2 <= UPPER_POWER_MARGIN_Q2);
+	bool lower_limit_valid = (total_offset_lower_q2 <= LOWER_POWER_MARGIN_Q2);
+
+	if (upper_limit_valid && lower_limit_valid) {
+		return offset_q2;
+	} else if (!upper_limit_valid && lower_limit_valid) {
+		new_offset_q2 = UPPER_POWER_MARGIN_Q2 - bw_factor_q2;
+
+		return new_offset_q2;
+	} else if (upper_limit_valid && !lower_limit_valid) {
+		new_offset_q2 = LOWER_POWER_MARGIN_Q2 - bw_factor_q2 - ant_factor_q2;
+
+		return new_offset_q2;
+	}
+
+	new_offset_q2 = min(UPPER_POWER_MARGIN_Q2 - bw_factor_q2,
+			    LOWER_POWER_MARGIN_Q2 - bw_factor_q2 - ant_factor_q2);
+
+	return new_offset_q2;
+}
+
+static s32 cl_power_calc_total_from_eirp_q1(struct cl_hw *cl_hw, s32 tx_power, u8 nss,
+					    enum cl_wrs_mode mode, u8 *trunc_pwr_q1)
+{
+	s32 pwr_q1, total_pwr_q1, delta_pwr_q1 = 0;
+	u8 tx_ant;
+	s32 antenna_gain_q1;
+	s32 array_gain_q1;
+	s32 bf_gain_q1;
+	bool eirp_regulatory_en = cl_hw->chip->conf->ce_production_mode ?
+		cl_hw->conf->ce_eirp_regulatory_prod_en : cl_hw->conf->ce_eirp_regulatory_op_en;
+
+	pwr_q1 = tx_power << 1;
+
+	tx_ant = cl_power_tx_ant(cl_hw, mode);
+	array_gain_q1 = cl_power_array_gain_q1(cl_hw, tx_ant);
+	antenna_gain_q1 = cl_power_antenna_gain_q1(cl_hw);
+	/* bf gain is not used for CCK or OFDM */
+	bf_gain_q1 = (mode > WRS_MODE_OFDM) ? cl_power_bf_gain_q1(cl_hw, tx_ant, nss) : 0;
+
+	/* FCC calculation */
+	if (cl_hw->channel_info.standard == NL80211_DFS_FCC)
+		pwr_q1 -= min(bf_gain_q1 + antenna_gain_q1, 6 << 1);
+
+	if (cl_hw->channel_info.use_channel_info && eirp_regulatory_en) {
+		s32 eirp_pwr_limit_q1;
+
+		eirp_pwr_limit_q1 = cl_chan_info_get_eirp_limit_q8(cl_hw, 0) >> 7;
+		if (pwr_q1 > eirp_pwr_limit_q1) {
+			delta_pwr_q1 = pwr_q1 - eirp_pwr_limit_q1;
+			pwr_q1 = eirp_pwr_limit_q1;
+		}
+	}
+
+	total_pwr_q1 = pwr_q1 - antenna_gain_q1 - array_gain_q1 - bf_gain_q1;
+	if (total_pwr_q1 < POWER_MIN_DB_Q1) {
+		delta_pwr_q1 = max(delta_pwr_q1 - (POWER_MIN_DB_Q1 - total_pwr_q1), 0);
+		total_pwr_q1 = POWER_MIN_DB_Q1;
+	}
+
+	if (trunc_pwr_q1)
+		*trunc_pwr_q1 = (u8)delta_pwr_q1;
+
+	return total_pwr_q1;
+}
+
+static s32 cl_power_calc_auto_resp_from_eirp_q1(struct cl_hw *cl_hw, s32 tx_power, u8 nss,
+						enum cl_wrs_mode mode)
+{
+	s32 auto_resp_total_pwr_q1, auto_resp_min_pwr_q1;
+	u8 tx_ant;
+	s32 array_gain_q1;
+	s32 total_pwr_q1;
+
+	auto_resp_min_pwr_q1 = POWER_MIN_DB_Q1 + cl_power_min_ant_q1(cl_hw);
+	tx_ant = cl_power_tx_ant(cl_hw, mode);
+	array_gain_q1 = cl_power_array_gain_q1(cl_hw, tx_ant);
+	total_pwr_q1 = cl_power_calc_total_from_eirp_q1(cl_hw, tx_power, nss, mode, NULL);
+
+	auto_resp_total_pwr_q1 = array_gain_q1 + total_pwr_q1;
+	if (auto_resp_total_pwr_q1 < auto_resp_min_pwr_q1)
+		auto_resp_total_pwr_q1 = auto_resp_min_pwr_q1;
+
+	return auto_resp_total_pwr_q1;
+}
+
+static s8 cl_calc_ant_pwr_q1(struct cl_hw *cl_hw, u8 bw, u8 nss, u8 mcs,
+			     enum cl_wrs_mode mode, u8 *trunc_val)
+{
+	s32 eirp_pwr = 0;
+	s8 ant_pwr_q1;
+
+	eirp_pwr = cl_hw->new_tx_power;
+	if (eirp_pwr) {
+		ant_pwr_q1 = cl_power_calc_total_from_eirp_q1(cl_hw, eirp_pwr, nss,
+							      mode, trunc_val);
+	} else {
+		s8 pwr_offset_q1;
+
+		pwr_offset_q1 = cl_power_offset_q1(cl_hw, mode, bw, mcs);
+		ant_pwr_q1 = cl_power_calc_q1(cl_hw, pwr_offset_q1, bw, nss,
+					      mode, false, trunc_val);
+	}
+	return ant_pwr_q1;
+}
+
+static s8 cl_calc_auto_resp_pwr_q1(struct cl_hw *cl_hw, u8 bw, u8 nss, u8 mcs,
+				   enum cl_wrs_mode mode)
+{
+	s32 eirp_pwr = 0;
+	s8 auto_resp_pwr_q1;
+
+	eirp_pwr = cl_hw->new_tx_power;
+	if (eirp_pwr) {
+		auto_resp_pwr_q1 = cl_power_calc_auto_resp_from_eirp_q1(cl_hw, eirp_pwr,
+									nss, mode);
+	} else {
+		s8 pwr_offset_q1;
+
+		pwr_offset_q1 = cl_power_offset_q1(cl_hw, mode, bw, mcs);
+		auto_resp_pwr_q1 = cl_power_calc_q1(cl_hw, pwr_offset_q1, bw, nss,
+						    mode, true, NULL);
+	}
+	return auto_resp_pwr_q1;
+}
+
+static void cl_power_tables_update_cck(struct cl_hw *cl_hw,
+				       struct cl_pwr_tables *pwr_tables)
+{
+	u8 mcs;
+	u8 trunc_value = 0;
+
+	/* CCK - Enforce EIRP limitations */
+	for (mcs = 0; mcs < WRS_MCS_MAX_CCK; mcs++) {
+		pwr_tables->ant_pwr_cck[mcs] = cl_calc_ant_pwr_q1(cl_hw, 0, 0, mcs, WRS_MODE_CCK,
+								  &trunc_value);
+
+		cl_hw->pwr_trunc.cck[mcs] = trunc_value;
+
+		/* Auto response */
+		pwr_tables->pwr_auto_resp_cck[mcs] = cl_calc_auto_resp_pwr_q1(cl_hw, 0, 0, mcs,
+									      WRS_MODE_CCK);
+	}
+}
+
+static void cl_power_tables_update_ofdm(struct cl_hw *cl_hw,
+					struct cl_pwr_tables *pwr_tables)
+{
+	u8 mcs;
+	u8 trunc_value = 0;
+
+	/* OFDM - Enforce EIRP limitations */
+	for (mcs = 0; mcs < WRS_MCS_MAX_OFDM; mcs++) {
+		pwr_tables->ant_pwr_ofdm[mcs] = cl_calc_ant_pwr_q1(cl_hw, 0, 0, mcs, WRS_MODE_OFDM,
+								   &trunc_value);
+		cl_hw->pwr_trunc.ofdm[mcs] = trunc_value;
+
+		/* Auto response */
+		pwr_tables->pwr_auto_resp_ofdm[mcs] = cl_calc_auto_resp_pwr_q1(cl_hw, 0, 0, mcs,
+									       WRS_MODE_OFDM);
+	}
+}
+
+static u8 cl_power_tables_update_ht_vht(struct cl_hw *cl_hw,
+					struct cl_pwr_tables *pwr_tables)
+{
+	bool is_24g = cl_band_is_24g(cl_hw);
+	bool is_5g = cl_band_is_5g(cl_hw);
+	u8 bw;
+	u8 nss;
+	u8 mcs;
+	u8 trunc_value = 0;
+	u8 min_bw_idx_limit_vht = 0;
+	u8 max_mcs_ht_vht = (is_5g || (is_24g && cl_hw->conf->ci_vht_cap_24g)) ?
+		WRS_MCS_MAX_VHT : WRS_MCS_MAX_HT;
+	s16 min_bw_limit = 0;
+	s32 eirp_power_limit_q8;
+
+	for (bw = 0, min_bw_limit = 0xFFFF; bw < cl_max_bw_idx(WRS_MODE_VHT, is_24g); bw++) {
+		if (!cl_hw_is_prod_or_listener(cl_hw) &&
+		    !cl_chan_info_get(cl_hw, cl_hw->channel, bw))
+			continue;
+
+		/* Find lowest EIRP power limitation among all bw for auto resp calculations */
+		eirp_power_limit_q8 = cl_chan_info_get_eirp_limit_q8(cl_hw, bw);
+		if (eirp_power_limit_q8 < min_bw_limit) {
+			min_bw_limit = eirp_power_limit_q8;
+			min_bw_idx_limit_vht = bw;
+		}
+
+		/* HT/VHT - Enforce EIRP limitations */
+		for (mcs = 0; mcs < max_mcs_ht_vht; mcs++) {
+			for (nss = 0; nss < PWR_TBL_VHT_BF_SIZE; nss++) {
+				pwr_tables->ant_pwr_ht_vht[bw][mcs][nss] =
+					cl_calc_ant_pwr_q1(cl_hw, bw, nss, mcs, WRS_MODE_VHT,
+							   &trunc_value);
+				cl_hw->pwr_trunc.ht_vht[bw][mcs][nss] = trunc_value;
+			}
+		}
+	}
+
+	/* Auto resp HT/VHT - Enforce EIRP limitations */
+	for (mcs = 0; mcs < max_mcs_ht_vht; mcs++)
+		pwr_tables->pwr_auto_resp_ht_vht[mcs] =
+			cl_calc_auto_resp_pwr_q1(cl_hw, min_bw_idx_limit_vht, 0, mcs,
+						 WRS_MODE_VHT);
+
+	return min_bw_idx_limit_vht;
+}
+
+static u8 cl_power_tables_update_he(struct cl_hw *cl_hw,
+				    struct cl_pwr_tables *pwr_tables)
+{
+	bool is_24g = cl_band_is_24g(cl_hw);
+	u8 bw;
+	u8 nss;
+	u8 mcs;
+	u8 trunc_value = 0;
+	u8 min_bw_idx_limit_he = 0;
+	s16 min_bw_limit = 0;
+	s32 eirp_power_limit_q8;
+
+	for (bw = 0, min_bw_limit = 0xFFFF; bw < cl_max_bw_idx(WRS_MODE_HE, is_24g); bw++) {
+		if (!cl_hw_is_prod_or_listener(cl_hw) &&
+		    !cl_chan_info_get(cl_hw, cl_hw->channel, bw))
+			continue;
+
+		/* Find lowest EIRP power limitation among all bw for auto resp calculations */
+		eirp_power_limit_q8 = cl_chan_info_get_eirp_limit_q8(cl_hw, bw);
+		if (eirp_power_limit_q8 < min_bw_limit) {
+			min_bw_limit = eirp_power_limit_q8;
+			min_bw_idx_limit_he = bw;
+		}
+
+		/* HE - Enforce EIRP limitations */
+		for (mcs = 0; mcs < WRS_MCS_MAX_HE; mcs++) {
+			for (nss = 0; nss < PWR_TBL_HE_BF_SIZE; nss++) {
+				pwr_tables->ant_pwr_he[bw][mcs][nss] =
+					cl_calc_ant_pwr_q1(cl_hw, bw, nss, mcs, WRS_MODE_HE,
+							   &trunc_value);
+				cl_hw->pwr_trunc.he[bw][mcs][nss] = trunc_value;
+			}
+		}
+	}
+
+	/* Auto resp HE - Enforce EIRP limitations */
+	for (mcs = 0; mcs < WRS_MCS_MAX_HE; mcs++)
+		pwr_tables->pwr_auto_resp_he[mcs] =
+			cl_calc_auto_resp_pwr_q1(cl_hw, min_bw_idx_limit_he, 0, mcs, WRS_MODE_HE);
+
+	return min_bw_idx_limit_he;
+}
+
+static u8 cl_power_calc_max(struct cl_hw *cl_hw, u8 bw, enum cl_wrs_mode mode)
+{
+	u8 tx_ant = cl_power_tx_ant(cl_hw, mode);
+	/* Total TX power - pass is_auto_resp = true in order to ignore bf gain */
+	s32 total_power_q8 = cl_power_total_q8(cl_hw, 0, tx_ant, 0, mode, true);
+	/* EIRP power limit */
+	s32 eirp_power_limit_q8 = cl_chan_info_get_eirp_limit_q8(cl_hw, bw);
+
+	return (min(total_power_q8, eirp_power_limit_q8) >> 8);
+}
+
+static s8 cl_power_vns_calc_q1(struct cl_hw *cl_hw, u8 bw,
+			       enum cl_wrs_mode mode, bool is_auto_resp)
+{
+	u8 max_tx_pwr = cl_power_calc_max(cl_hw, bw, mode);
+	u8 tx_ant = cl_power_tx_ant(cl_hw, mode);
+	s32 vns_pwr_limit_q8 = min_t(u8, cl_hw->conf->ci_vns_pwr_limit, max_tx_pwr) << 8;
+	s32 antenna_gain_q8 = cl_power_antenna_gain_q8(cl_hw);
+	s32 array_gain_q8 = (is_auto_resp ? 0 : cl_power_array_gain_q8(cl_hw, tx_ant));
+	s32 min_ant_pwr_q8 = cl_power_min_ant_q8(cl_hw);
+	s32 min_pwr_q8 = is_auto_resp ? (POWER_MIN_DB_Q8 + min_ant_pwr_q8) : POWER_MIN_DB_Q8;
+	s32 res_q8 = vns_pwr_limit_q8 - antenna_gain_q8 - array_gain_q8;
+
+	if (res_q8 < min_pwr_q8)
+		res_q8 = min_pwr_q8;
+
+	/* Result should be in 0.5dBm resolution */
+	return (s8)(res_q8 >> 7);
+}
+
+static void cl_power_tables_update_vns(struct cl_hw *cl_hw,
+				       struct cl_pwr_tables *pwr_tables,
+				       u8 min_bw_idx_limit_vht,
+				       u8 min_bw_idx_limit_he)
+{
+	/* VNS */
+	pwr_tables->ant_pwr_vns_he =
+		cl_power_vns_calc_q1(cl_hw, min_bw_idx_limit_he, WRS_MODE_HE, false);
+	pwr_tables->ant_pwr_vns_ht_vht =
+		cl_power_vns_calc_q1(cl_hw, min_bw_idx_limit_vht, WRS_MODE_VHT, false);
+	pwr_tables->ant_pwr_vns_ofdm =
+		cl_power_vns_calc_q1(cl_hw, 0, WRS_MODE_OFDM, false);
+	pwr_tables->ant_pwr_vns_cck =
+		cl_power_vns_calc_q1(cl_hw, 0, WRS_MODE_CCK, false);
+
+	/* Auto response VNS */
+	pwr_tables->pwr_auto_resp_vns_he =
+		cl_power_vns_calc_q1(cl_hw, min_bw_idx_limit_he, WRS_MODE_HE, true);
+	pwr_tables->pwr_auto_resp_vns_ht_vht =
+		cl_power_vns_calc_q1(cl_hw, min_bw_idx_limit_vht, WRS_MODE_VHT, true);
+	pwr_tables->pwr_auto_resp_vns_ofdm =
+		cl_power_vns_calc_q1(cl_hw, 0, WRS_MODE_OFDM, true);
+	pwr_tables->pwr_auto_resp_vns_cck =
+		cl_power_vns_calc_q1(cl_hw, 0, WRS_MODE_CCK, true);
+}
+
+static void cl_power_tables_update_by_offset(struct cl_hw *cl_hw,
+					     struct cl_pwr_tables *pwr_tables,
+					     s8 offset)
+{
+	u8 mcs = 0;
+	u8 bw = 0;
+	u8 nss = 0;
+
+	/* CCK - Enforce EIRP limitations */
+	for (mcs = 0; mcs < WRS_MCS_MAX_CCK; mcs++) {
+		pwr_tables->ant_pwr_cck[mcs] += offset;
+
+		/* Auto response */
+		pwr_tables->pwr_auto_resp_cck[mcs] += offset;
+	}
+
+	/* OFDM - Enforce EIRP limitations */
+	for (mcs = 0; mcs < WRS_MCS_MAX_OFDM; mcs++) {
+		pwr_tables->ant_pwr_ofdm[mcs] += offset;
+
+		/* Auto response */
+		pwr_tables->pwr_auto_resp_ofdm[mcs] += offset;
+	}
+
+	for (bw = 0; bw < CHNL_BW_MAX; bw++) {
+		/* HT/VHT - Enforce EIRP limitations */
+		for (mcs = 0; mcs < WRS_MCS_MAX_VHT; mcs++) {
+			for (nss = 0; nss < PWR_TBL_VHT_BF_SIZE; nss++)
+				pwr_tables->ant_pwr_ht_vht[bw][mcs][nss] += offset;
+
+			/*
+			 * Auto response:
+			 * always with disabled BF so the offset of the last nss is used
+			 */
+			pwr_tables->pwr_auto_resp_ht_vht[mcs] += offset;
+		}
+
+		/* HE - Enforce EIRP limitations */
+		for (mcs = 0; mcs < WRS_MCS_MAX_HE; mcs++) {
+			for (nss = 0; nss < PWR_TBL_HE_BF_SIZE; nss++)
+				pwr_tables->ant_pwr_he[bw][mcs][nss] += offset;
+
+			/*
+			 * Auto response:
+			 * always with disabled BF so the offset of the last nss is used
+			 */
+			pwr_tables->pwr_auto_resp_he[mcs] += offset;
+		}
+	}
+}
+
+static s8 cl_power_get_offset(u16 percentage)
+{
+	if (percentage >= 94)
+		return 0;
+	else if (percentage >= 84)
+		return -1; /* -0.5dBm */
+	else if (percentage >= 75)
+		return -2; /* -1dBm */
+	else if (percentage >= 67)
+		return -3; /* -1.5dBm */
+	else if (percentage >= 59)
+		return -4; /* -2dBm */
+	else if (percentage >= 54)
+		return -5; /* -2.5dBm */
+	else if (percentage >= 48)
+		return -6; /* -3dBm */
+	else if (percentage >= 43)
+		return -7; /* -3.5dBm */
+	else if (percentage >= 38)
+		return -8; /* -4dBm */
+	else if (percentage >= 34)
+		return -9; /* -4.5dBm */
+	else if (percentage >= 30)
+		return -10; /* -5dBm */
+	else if (percentage >= 27)
+		return -11; /* -5.5dBm */
+	else if (percentage >= 24)
+		return -12; /* -6dBm */
+	else if (percentage >= 22)
+		return -13; /* -6.5dBm */
+	else if (percentage >= 19)
+		return -14; /* -7dBm */
+	else if (percentage >= 17)
+		return -15; /* -7.5dBm */
+	else if (percentage >= 15)
+		return -16; /* -8dBm */
+	else if (percentage >= 14)
+		return -17; /* -8.5dBm */
+	else if (percentage >= 12)
+		return -18; /* -9dBm */
+	else if (percentage >= 11)
+		return -19; /* -9.5dBm */
+	else if (percentage >= 10)
+		return -20; /* -10dBm */
+	else if (percentage >= 9)
+		return -21; /* -10.5dBm */
+	else if (percentage >= 8)
+		return -22; /* -11dBm */
+	else if (percentage >= 7)
+		return -23; /* -11.5dBm */
+	else if (percentage >= 6)
+		return -24; /* -12dBm */
+	else if (percentage >= 5)
+		return -26; /* -13dBm */
+	else if (percentage >= 4)
+		return -28; /* -14dBm */
+	else if (percentage >= 3)
+		return -30; /* -15dBm */
+	else if (percentage >= 2)
+		return -34; /* -17dBm */
+	else if (percentage >= 1)
+		return -40; /* -20dBm */
+
+	/* Should not get here */
+	return 0;
+}
+
+static void cl_power_control_apply_percentage(struct cl_hw *cl_hw)
+{
+	struct cl_power_db *power_db = &cl_hw->power_db;
+	u8 percentage = cl_hw->conf->ce_tx_power_control;
+
+	power_db->curr_percentage = percentage;
+
+	if (percentage != 100) {
+		power_db->curr_offset = cl_power_get_offset(percentage);
+		cl_power_tables_update_by_offset(cl_hw,
+						 &cl_hw->phy_data_info.data->pwr_tables,
+						 power_db->curr_offset);
+	}
+}
+
+void cl_power_tables_update(struct cl_hw *cl_hw, struct cl_pwr_tables *pwr_tables)
+{
+	bool is_24g = cl_band_is_24g(cl_hw);
+	bool is_6g = cl_band_is_6g(cl_hw);
+	u8 min_bw_idx_limit_he = 0;
+	u8 min_bw_idx_limit_vht = 0;
+
+	memset(pwr_tables, 0, sizeof(struct cl_pwr_tables));
+
+	if (is_24g)
+		cl_power_tables_update_cck(cl_hw, pwr_tables);
+
+	cl_power_tables_update_ofdm(cl_hw, pwr_tables);
+
+	if (!is_6g)
+		min_bw_idx_limit_vht = cl_power_tables_update_ht_vht(cl_hw, pwr_tables);
+
+	min_bw_idx_limit_he = cl_power_tables_update_he(cl_hw, pwr_tables);
+
+	cl_hw->new_tx_power = 0;
+
+	cl_power_tables_update_vns(cl_hw, pwr_tables, min_bw_idx_limit_vht, min_bw_idx_limit_he);
+
+	cl_power_control_apply_percentage(cl_hw);
+}
+
+static s32 cl_power_get_max_cck(struct cl_hw *cl_hw)
+{
+	struct cl_pwr_tables *pwr_tables = &cl_hw->phy_data_info.data->pwr_tables;
+	u8 mcs = 0;
+	u8 tx_ant = cl_power_tx_ant(cl_hw, WRS_MODE_CCK);
+	s32 ant_gain_q1 = cl_power_antenna_gain_q1(cl_hw);
+	s32 arr_gain_q1 = cl_power_array_gain_q1(cl_hw, tx_ant);
+	s32 total_pwr_q1 = 0;
+	s32 max_pwr_q1 = 0;
+
+	for (mcs = 0; mcs < WRS_MCS_MAX_CCK; mcs++) {
+		total_pwr_q1 = pwr_tables->ant_pwr_cck[mcs] + ant_gain_q1 + arr_gain_q1;
+
+		if (total_pwr_q1 > max_pwr_q1)
+			max_pwr_q1 = total_pwr_q1;
+	}
+
+	return max_pwr_q1;
+}
+
+static s32 cl_power_get_max_ofdm(struct cl_hw *cl_hw)
+{
+	struct cl_pwr_tables *pwr_tables = &cl_hw->phy_data_info.data->pwr_tables;
+	u8 mcs = 0;
+	u8 tx_ant = cl_power_tx_ant(cl_hw, WRS_MODE_OFDM);
+	s32 ant_gain_q1 = cl_power_antenna_gain_q1(cl_hw);
+	s32 arr_gain_q1 = cl_power_array_gain_q1(cl_hw, tx_ant);
+	s32 total_pwr_q1 = 0;
+	s32 max_pwr_q1 = 0;
+
+	for (mcs = 0; mcs < WRS_MCS_MAX_OFDM; mcs++) {
+		total_pwr_q1 = pwr_tables->ant_pwr_ofdm[mcs] + ant_gain_q1 + arr_gain_q1;
+
+		if (total_pwr_q1 > max_pwr_q1)
+			max_pwr_q1 = total_pwr_q1;
+	}
+
+	return max_pwr_q1;
+}
+
+static s32 cl_power_get_max_ht_vht(struct cl_hw *cl_hw)
+{
+	struct cl_pwr_tables *pwr_tables = &cl_hw->phy_data_info.data->pwr_tables;
+	u8 tx_ant = cl_power_tx_ant(cl_hw, WRS_MODE_VHT);
+	u8 mcs = 0;
+	u8 bw = 0;
+	u8 bf = 0;
+	s32 ant_gain_q1 = cl_power_antenna_gain_q1(cl_hw);
+	s32 arr_gain_q1 = cl_power_array_gain_q1(cl_hw, tx_ant);
+	s32 total_pwr_q1 = 0;
+	s32 max_pwr_q1 = 0;
+
+	for (bw = 0; bw < CHNL_BW_MAX; bw++) {
+		for (mcs = 0; mcs < WRS_MCS_MAX_VHT; mcs++) {
+			for (bf = 0; bf < PWR_TBL_VHT_BF_SIZE; bf++) {
+				total_pwr_q1 = pwr_tables->ant_pwr_ht_vht[bw][mcs][bf] +
+					ant_gain_q1 + arr_gain_q1;
+
+				if (total_pwr_q1 > max_pwr_q1)
+					max_pwr_q1 = total_pwr_q1;
+			}
+		}
+	}
+
+	return max_pwr_q1;
+}
+
+static s32 cl_power_get_max_he(struct cl_hw *cl_hw)
+{
+	struct cl_pwr_tables *pwr_tables = &cl_hw->phy_data_info.data->pwr_tables;
+	u8 tx_ant = cl_power_tx_ant(cl_hw, WRS_MODE_HE);
+	u8 mcs = 0;
+	u8 bw = 0;
+	u8 bf = 0;
+	s32 ant_gain_q1 = cl_power_antenna_gain_q1(cl_hw);
+	s32 arr_gain_q1 = cl_power_array_gain_q1(cl_hw, tx_ant);
+	s32 total_pwr_q1 = 0;
+	s32 max_pwr_q1 = 0;
+
+	for (bw = 0; bw < CHNL_BW_MAX; bw++) {
+		for (mcs = 0; mcs < WRS_MCS_MAX_HE; mcs++) {
+			for (bf = 0; bf < PWR_TBL_HE_BF_SIZE; bf++) {
+				total_pwr_q1 = pwr_tables->ant_pwr_he[bw][mcs][bf] +
+					ant_gain_q1 + arr_gain_q1;
+
+				if (total_pwr_q1 > max_pwr_q1)
+					max_pwr_q1 = total_pwr_q1;
+			}
+		}
+	}
+
+	return max_pwr_q1;
+}
+
+s32 cl_power_get_max(struct cl_hw *cl_hw)
+{
+	bool is_24g = cl_band_is_24g(cl_hw);
+	bool is_6g = cl_band_is_6g(cl_hw);
+	s32 max_pwr_cck_q1 = is_24g ? cl_power_get_max_cck(cl_hw) : S32_MIN;
+	s32 max_pwr_ofdm_q1 = cl_power_get_max_ofdm(cl_hw);
+	s32 max_pwr_ht_vht_q1 = !is_6g ? cl_power_get_max_ht_vht(cl_hw) : S32_MIN;
+	s32 max_pwr_he_q1 = cl_power_get_max_he(cl_hw);
+	s32 max_pwr_q1 = 0;
+
+	max_pwr_q1 = max(max_pwr_q1, max_pwr_cck_q1);
+	max_pwr_q1 = max(max_pwr_q1, max_pwr_ofdm_q1);
+	max_pwr_q1 = max(max_pwr_q1, max_pwr_ht_vht_q1);
+	max_pwr_q1 = max(max_pwr_q1, max_pwr_he_q1);
+
+	return (max_pwr_q1 >> 1);
+}
+
-- 
2.36.1

