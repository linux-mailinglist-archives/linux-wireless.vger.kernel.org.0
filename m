Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3605532937
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236824AbiEXLiw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbiEXLit (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:38:49 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70052.outbound.protection.outlook.com [40.107.7.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15654130C
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/oiYRUj+7CTbeqh3LZ5KQ3r/3sPTUhRcRkkub1QeEpv/H4HUPIqioAikjxnYcdivOpbrInKB2BIUoPajYGs5QoiDq4Yb4D5T86uD9+hrUoHCmoyeNAbFmlpzydzBU7DiOUtfy8yj5hXatuOaX02o+lSXg4GrWwe1yVEwVEDAN1O+oEjB6ly4JODm+JczpUYUwHdr82pmhoJhdQKE3gt/pT7q2IsV16MLK9KHLqJmbWszc/KTOpNSxpu4fuXb+ucijsZmSRo57s7sXH+Slh0bqvJc6/W619CM3Ga6lK5n7sl2jY4Cx+8u8HRVTi0uJSSn3Rrb6411Jmf9CmpbQqhWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34gWxQjNsWnRqnKnL7hgF8K8oGx292n9Ds70+XyAb1E=;
 b=nQaWaju465OqlpEw6ZwAFX9bCj/0Uo6NgbmDfUSYmcz3nJlH/QZAfFSoZLWiKAbLURh4da9uudiosh5N1xgfg7jGeulKdrpB7v5AVKG4DyuQG2sj1VehdoiRhx+FVYjbpKf68UNRaqgCZQIdnVsSqWntcHio3G9lg8D1iAUuflohJOF53Vm1Y90KIZI6M9IJqyqelmW8oLhyO97WJ+27Ac72qfo/tjqn2oNKNluFQmZ0H5bbynmIJ2nb+//TFywBBdxjoXHH5K3CSXQ6LW0QuioJ+MAQFNixjh3fjL+PB5uT4g5c9U9/AYdAnkp951GgwP7cRJAmOL6YUdcIqIvhGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34gWxQjNsWnRqnKnL7hgF8K8oGx292n9Ds70+XyAb1E=;
 b=OuBM0aZNZkZbE2Pff++OhQEjma/SN81/krdICa/AUo9hvhnL65dEejgygMTNnokWX3q8/j29HwD5kox/ZC1E6OuZdw+nhxBZMKOr3Ljl/mIK89vxIFN42gdjbrHfURVsYiyYhORSxdV2JfUOHiZOw+ZpHogjXKwu40qodfBJ5zA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM6P192MB0469.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:32::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:38:02 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:02 +0000
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
Subject: [RFC v2 26/96] cl8k: add eeprom.h
Date:   Tue, 24 May 2022 14:33:52 +0300
Message-Id: <20220524113502.1094459-27-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: d5094714-0b42-40e3-3d00-08da3d79dc5a
X-MS-TrafficTypeDiagnostic: AM6P192MB0469:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM6P192MB046979088F9B204846ADB861F6D79@AM6P192MB0469.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iXXmCPnNL/cpt0ShRn+5LWf/znLSWuikuHhTUaGs0cjm5ddsvQO1HmmwLRS7sIaI4vtBHy5++iqJKKJP8o86+kSH9dqj6r7vsfNTe3olVXztw5bwVUfhmms00ZS8GteawsPg39tmhSSIqIDDmCyE2wUpBG19sWLLGVtuCE+5elHGg1DiBzvx2CaZTLZVz6jC6evhqpCvT+uM/kYvjv4yeP92NNygujAprHJxFaA7Z1YzO4sAFhqe0jVlzbrIa2+RIjzzMVPuUpl6VIIfqpSc1+SjSONhravCBgs9iGdf4fHMXzdB/AUIjQ4gVwTpHEhvgYv21LaORSAV9bMjlLZgbbtkPEh2QZIOGkF+kyQRe3UDBqaZvPwoNpTDHk1IvgFYqPUPKPSGbqcmXEHnC05y3VchkmfpT1dl7uTwgWzCwGWwGriea7tdB5NiA1BU6+fYrYQUmR/80fHdP2h51V34e9LDLA0EeKW9QVzRbNiIm2SlJnMlUzI25jwHhGG8GpUCGd11d5FuKSmaPz+XToWSHL9OJw8rGzyBhofNlsruhkW2iWTAHHpShaiJ6ocMMUlTIjHTFhcw5vqGNnO2S8Rh4dPlDYFWfGAz8E0xIenwweQLBakptTnidHAx7BUa3M9dWEQgCP2btCJ20XLR1jl4JdSQMLWZ3bkJtCEn17JqHfByJHljVXOOJFcrnMccsHAG0+SIjrKZ09cbDhAgm1IrgCp+TZf0uKX/m7ro2YRcJVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(346002)(376002)(136003)(366004)(39850400004)(6486002)(30864003)(6916009)(508600001)(8936002)(86362001)(2906002)(5660300002)(4326008)(1076003)(36756003)(38100700002)(41300700001)(52116002)(186003)(66556008)(2616005)(6506007)(6512007)(26005)(316002)(54906003)(107886003)(8676002)(9686003)(66476007)(38350700002)(66946007)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3V18H+xqz+L4cq38/KtkIlN2VjJqBBxAGl401hnfuFSo9IC+ry+GRdJI8LXt?=
 =?us-ascii?Q?4rwGAY83fi/0zD2dzNhW50W7pNHcZfFABt84j8nFkITdfMoThmllAjrbTH+4?=
 =?us-ascii?Q?BMz0AO8sCSdsJyE6oFKOG155NEmqPjMl1D/C8JwCM64WjTesgZjhSdMoP6r/?=
 =?us-ascii?Q?dT8wH0rW4/qzVkaT7UVsH1ysVpf2MYVwJAzu8RH+/NjghFwDfYaYJLQjItiN?=
 =?us-ascii?Q?4vC31T3pvatYakLkPMqVUtvUgvNueaRDSLFHgllTn7ZGjVc7/Dly4R7suSos?=
 =?us-ascii?Q?RBiBD1VqdGlflBEd+14B2kDbkLSAiMhMs0qHpmNeyhieogOFhA+sqkwsVzIp?=
 =?us-ascii?Q?VgzIDgI8iqy7kG+QN0StmfzYuqTsjYk06mKYlGe4x8dUhz4OzPC+OM7K5xZY?=
 =?us-ascii?Q?vq9akBPOOMj0NJVegSgNkQzj7dzK59NiXmu0BDTWV5TWoGASANztTH6a/8e0?=
 =?us-ascii?Q?QI/QNhBahLONeJFNCUi/E8auQJ8u4ZNsePca4v137Z6KZuYEPBtsjH4XI5jZ?=
 =?us-ascii?Q?lP8V+lhRTDv4d+hDotE6SWlyODh7rWjyeAlxyIm8a3noswImcT/HuDPoCDI3?=
 =?us-ascii?Q?PXIk3MEcWUSrKJTHmIbRxwKmJvaHKCsJJaLsl2CI9FBKPj8jGi1rd/VV9ld1?=
 =?us-ascii?Q?/mjFv07p/WxO8u58eEorJTIJZ/kQMmyw34Hm4QYS09JnGst08Pvl9r0DqH1p?=
 =?us-ascii?Q?9WHqilx2ZvF4djEfBeuW7BW6ic0y8+S2mJpSOL6cYX9ABeMbmxFmLHoNTjAk?=
 =?us-ascii?Q?6XOBPnlobiM7pEfFrUTJ+Deh+SsFVvFlB1vQyipNKrGgSAJV0vgmjtRFqXMm?=
 =?us-ascii?Q?PCNTnUCuxZL5zsiXkI+DODc4wJTKwg6zZItsuKCPK8ZrkYd7T5D3eyIOaAlL?=
 =?us-ascii?Q?dksmoEWsTqYDsqkwhB1hKM4l9digIIQ5tGLuFsodDb/ChYFAKKmrKDdWG+2e?=
 =?us-ascii?Q?6PSSRWApiam1NhWjOQMy3fZ1v+NiPrz1/L/mvA8UqaiiWBzuw+j/9D41XJdV?=
 =?us-ascii?Q?Ysz/s/EF+/UGGIxkSAmp8fMuXOw0sm3fKlqul7EtsH6mhvsN3o8JQYeElrva?=
 =?us-ascii?Q?prRd4n6uU/iJKoSWWTYBaGqnQlywA2hWVXomxIR5ynw/xdVNUBTFvMXuW1ot?=
 =?us-ascii?Q?LTHonxp8SbRbk9Z8QfTBJJqAe5d2eMXCY/dXHcRrNIE6CJJPzcgNkneujcZC?=
 =?us-ascii?Q?+lFOI9rOrFjZip07pZVk8EFKETC1xvl6LzCWf9415gtF8LZIswDszfVXPdtH?=
 =?us-ascii?Q?rnaoZaGNCdXq/J+wDHHBSUYSeHigajXcX5WIzpOwGQCsR6lgQXm86LcUGT4/?=
 =?us-ascii?Q?Rbvf+9oG4qSLJuPbvNpFWAX7jZGrTgUFWgJbsfw+PNwWvnIWPhoVEu8obF9I?=
 =?us-ascii?Q?xQ7b5q+v4VAUkoajz12FzyYz0+eyR8Nhhsg6QTQB/Ktw29gQCwBOul4AIbYj?=
 =?us-ascii?Q?KphKbVx1GRtiXcJxNGfOAiG0sR211g9Szi7caXsm06u2PJwYRG+D+yBQKy1e?=
 =?us-ascii?Q?QQ9stl1U3l+r6jwxnvIhaWyHfHx5htrSnTuh/iLjnYLpZO+t7uitCc9rbRTA?=
 =?us-ascii?Q?EvrX0WmvgfE5uqcgtDJLAvx+nojqKnW2ZQ+03XYVO1PVqh4lAUxRN1jzY+c/?=
 =?us-ascii?Q?jeLg1/6xkRl1IpDzb6vCuAlr4Lncy2TpNJyc61XA2hGb/WGgZn8crTw9L/9c?=
 =?us-ascii?Q?OKliMfL/mojGwLDIiXgH9Xt7ulCs+q1z0FleRfbrb1uC9Scx7kAmtHSYfmkw?=
 =?us-ascii?Q?178XBMSmb5UdDd9aJNS+sL/pgb9/mJI=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5094714-0b42-40e3-3d00-08da3d79dc5a
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:02.5303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AzBeuHoCbDT7EC8tRBPOxDT1NxIxeGKb/2wbKw0lHpR34v+A7ZPyA8kGFep0jXLoVpZiD6q9EQCcFV641DYJHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6P192MB0469
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
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
 drivers/net/wireless/celeno/cl8k/eeprom.h | 283 ++++++++++++++++++++++
 1 file changed, 283 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/eeprom.h

diff --git a/drivers/net/wireless/celeno/cl8k/eeprom.h b/drivers/net/wireless/celeno/cl8k/eeprom.h
new file mode 100644
index 000000000000..2680af90484b
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/eeprom.h
@@ -0,0 +1,283 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_EEPROM_H
+#define CL_EEPROM_H
+
+#include <linux/kernel.h>
+
+#include "def.h"
+#include "phy.h"
+#include "calib.h"
+
+#define SERIAL_NUMBER_SIZE 32
+#define BIT_MAP_SIZE   20
+#define EXT_BIT_MAP_SIZE (BIT_MAP_SIZE * 2)
+#define NUM_OF_PIVOTS  20
+#define NUM_PIVOT_PHYS (MAX_ANTENNAS * NUM_OF_PIVOTS)
+
+#ifdef CONFIG_CL8K_EEPROM_STM24256
+#define BIT_MAP_SIZE_20MHZ_TCV0  9
+#define BIT_MAP_SIZE_20MHZ_TCV1  6
+#define BIT_MAP_SIZE_40MHZ_TCV0  4
+#define BIT_MAP_SIZE_40MHZ_TCV1  4
+#define BIT_MAP_SIZE_80MHZ_TCV0  2
+#define BIT_MAP_SIZE_80MHZ_TCV1  2
+#define BIT_MAP_SIZE_160MHZ_TCV0 1
+#define BIT_MAP_SIZE_160MHZ_TCV1 3
+
+#define EEPROM_CALIB_DATA_ELEM_NUM_20MHZ_TCV0   10
+#define EEPROM_CALIB_DATA_ELEM_NUM_20MHZ_TCV1   7
+#define EEPROM_CALIB_DATA_ELEM_NUM_40MHZ_TCV0   9
+#define EEPROM_CALIB_DATA_ELEM_NUM_40MHZ_TCV1   7
+#define EEPROM_CALIB_DATA_ELEM_NUM_80MHZ_TCV0   8
+#define EEPROM_CALIB_DATA_ELEM_NUM_80MHZ_TCV1   6
+#define EEPROM_CALIB_DATA_ELEM_NUM_160MHZ_TCV0  6
+#define EEPROM_CALIB_DATA_ELEM_NUM_160MHZ_TCV1  2
+#endif
+
+struct eeprom_hw {
+	u8 reserved[96];
+} __packed;
+
+struct eeprom_general {
+	u8 version;
+	u8 flavor;
+	u8 mac_address[6];
+	u8 temp_diff; /* Default value TEMP_DIFF_INVALID = 0x7F */
+	u8 serial_number[SERIAL_NUMBER_SIZE];
+	u8 pwr_table_id[2];
+	u8 reserved[53];
+} __packed;
+
+struct eeprom_fem {
+	u8 wiring_id;
+	u16 fem_lut[FEM_TYPE_MAX];
+	u32 platform_id;
+	u8 reserved[19];
+} __packed;
+
+struct eeprom_phy_calib {
+	s8 pow;
+	s8 offset;
+	s8 tmp;
+} __packed;
+
+struct point {
+	u8 chan;
+	u8 phy;
+	u8 idx;
+	u16 addr;
+	struct eeprom_phy_calib calib;
+} __packed;
+
+#ifdef CONFIG_CL8K_EEPROM_STM24256
+struct iq {
+	__le32 coef0;
+	__le32 coef1;
+	__le32 coef2;
+	__le32 gain;
+} __packed;
+
+struct score {
+	s8 iq_tx_score;
+	s8 iq_tx_worst_score;
+	s8 iq_rx_score;
+	s8 iq_rx_worst_score;
+	s16 dcoc_i_mv[DCOC_LNA_GAIN_NUM];
+	s16 dcoc_q_mv[DCOC_LNA_GAIN_NUM];
+	s32 lolc_score;
+} __packed;
+
+struct eeprom_calib_data {
+	u8 valid;
+	u8 temperature;
+	u32 lolc[MAX_ANTENNAS];
+	struct cl_dcoc_calib dcoc[MAX_ANTENNAS][DCOC_LNA_GAIN_NUM];
+	struct iq iq_tx[MAX_ANTENNAS];
+	struct iq iq_rx[MAX_ANTENNAS];
+	struct score score[MAX_ANTENNAS];
+} __packed;
+#endif
+
+struct eeprom_calib_power {
+	u16 freq_offset;
+	u8 chan_bmp[BIT_MAP_SIZE];
+	struct eeprom_phy_calib phy_calib[NUM_PIVOT_PHYS];
+} __packed;
+
+#ifdef CONFIG_CL8K_EEPROM_STM24256
+struct eeprom_calib_iq_dcoc {
+	u8 calib_version;
+	u8 chan_20mhz_bmp_tcv0[BIT_MAP_SIZE_20MHZ_TCV0];
+	u8 chan_20mhz_bmp_tcv1[BIT_MAP_SIZE_20MHZ_TCV1];
+	u8 chan_40mhz_bmp_tcv0[BIT_MAP_SIZE_40MHZ_TCV0];
+	u8 chan_40mhz_bmp_tcv1[BIT_MAP_SIZE_40MHZ_TCV1];
+	u8 chan_80mhz_bmp_tcv0[BIT_MAP_SIZE_80MHZ_TCV0];
+	u8 chan_80mhz_bmp_tcv1[BIT_MAP_SIZE_80MHZ_TCV1];
+	u8 chan_160mhz_bmp_tcv0[BIT_MAP_SIZE_160MHZ_TCV0];
+	u8 chan_160mhz_bmp_tcv1[BIT_MAP_SIZE_160MHZ_TCV1];
+	struct eeprom_calib_data
+		calib_20_data_tcv0[EEPROM_CALIB_DATA_ELEM_NUM_20MHZ_TCV0];
+	struct eeprom_calib_data
+		calib_20_data_tcv1[EEPROM_CALIB_DATA_ELEM_NUM_20MHZ_TCV1];
+	struct eeprom_calib_data
+		calib_40_data_tcv0[EEPROM_CALIB_DATA_ELEM_NUM_40MHZ_TCV0];
+	struct eeprom_calib_data
+		calib_40_data_tcv1[EEPROM_CALIB_DATA_ELEM_NUM_40MHZ_TCV1];
+	struct eeprom_calib_data
+		calib_80_data_tcv0[EEPROM_CALIB_DATA_ELEM_NUM_80MHZ_TCV0];
+	struct eeprom_calib_data
+		calib_80_data_tcv1[EEPROM_CALIB_DATA_ELEM_NUM_80MHZ_TCV1];
+	struct eeprom_calib_data
+		calib_160_data_tcv0[EEPROM_CALIB_DATA_ELEM_NUM_160MHZ_TCV0];
+	struct eeprom_calib_data
+		calib_160_data_tcv1[EEPROM_CALIB_DATA_ELEM_NUM_160MHZ_TCV1];
+} __packed;
+#endif
+
+struct eeprom {
+	struct eeprom_hw hw;
+	struct eeprom_general general;
+	struct eeprom_fem fem;
+	struct eeprom_calib_power calib_power;
+#ifdef CONFIG_CL8K_EEPROM_STM24256
+	struct eeprom_calib_iq_dcoc calib_iq_dcoc;
+#endif
+} __packed;
+
+enum {
+	ADDR_HW = offsetof(struct eeprom, hw),
+	ADDR_HW_RESERVED = ADDR_HW + offsetof(struct eeprom_hw, reserved),
+
+	ADDR_GEN = offsetof(struct eeprom, general),
+	ADDR_GEN_VERSION = ADDR_GEN + offsetof(struct eeprom_general, version),
+	ADDR_GEN_FLAVOR = ADDR_GEN + offsetof(struct eeprom_general, flavor),
+	ADDR_GEN_MAC_ADDR = ADDR_GEN + offsetof(struct eeprom_general, mac_address),
+	ADDR_GEN_TEMP_DIFF = ADDR_GEN + offsetof(struct eeprom_general, temp_diff),
+	ADDR_GEN_SERIAL_NUMBER = ADDR_GEN + offsetof(struct eeprom_general, serial_number),
+	ADDR_GEN_PWR_TABLE_ID = ADDR_GEN + offsetof(struct eeprom_general, pwr_table_id),
+	ADDR_GEN_RESERVED = ADDR_GEN + offsetof(struct eeprom_general, reserved),
+
+	ADDR_FEM = offsetof(struct eeprom, fem),
+	ADDR_FEM_WIRING_ID = ADDR_FEM + offsetof(struct eeprom_fem, wiring_id),
+	ADDR_FEM_LUT = ADDR_FEM + offsetof(struct eeprom_fem, fem_lut),
+	ADDR_FEM_PLATFORM_ID = ADDR_FEM + offsetof(struct eeprom_fem, platform_id),
+	ADDR_FEM_RESERVED = ADDR_FEM + offsetof(struct eeprom_fem, reserved),
+
+	ADDR_CALIB_POWER = offsetof(struct eeprom, calib_power),
+	ADDR_CALIB_POWER_FREQ_OFFSET = ADDR_CALIB_POWER +
+		offsetof(struct eeprom_calib_power, freq_offset),
+	ADDR_CALIB_POWER_CHAN_BMP = ADDR_CALIB_POWER +
+		offsetof(struct eeprom_calib_power, chan_bmp),
+	ADDR_CALIB_POWER_PHY = ADDR_CALIB_POWER +
+		offsetof(struct eeprom_calib_power, phy_calib),
+
+#ifdef CONFIG_CL8K_EEPROM_STM24256
+	ADDR_CALIB_IQ_DCOC = offsetof(struct eeprom, calib_iq_dcoc),
+	ADDR_CALIB_IQ_DCOC_VERSION = ADDR_CALIB_IQ_DCOC +
+		offsetof(struct eeprom_calib_iq_dcoc, calib_version),
+	ADDR_CALIB_IQ_DCOC_CHANNEL_20MHZ_BMP_TCV0 = ADDR_CALIB_IQ_DCOC +
+		offsetof(struct eeprom_calib_iq_dcoc, chan_20mhz_bmp_tcv0),
+	ADDR_CALIB_IQ_DCOC_CHANNEL_20MHZ_BMP_TCV1 = ADDR_CALIB_IQ_DCOC +
+		offsetof(struct eeprom_calib_iq_dcoc, chan_20mhz_bmp_tcv1),
+	ADDR_CALIB_IQ_DCOC_CHANNEL_40MHZ_BMP_TCV0 = ADDR_CALIB_IQ_DCOC +
+		offsetof(struct eeprom_calib_iq_dcoc, chan_40mhz_bmp_tcv0),
+	ADDR_CALIB_IQ_DCOC_CHANNEL_40MHZ_BMP_TCV1 = ADDR_CALIB_IQ_DCOC +
+		offsetof(struct eeprom_calib_iq_dcoc, chan_40mhz_bmp_tcv1),
+	ADDR_CALIB_IQ_DCOC_CHANNEL_80MHZ_BMP_TCV0 = ADDR_CALIB_IQ_DCOC +
+		offsetof(struct eeprom_calib_iq_dcoc, chan_80mhz_bmp_tcv0),
+	ADDR_CALIB_IQ_DCOC_CHANNEL_80MHZ_BMP_TCV1 = ADDR_CALIB_IQ_DCOC +
+		offsetof(struct eeprom_calib_iq_dcoc, chan_80mhz_bmp_tcv1),
+	ADDR_CALIB_IQ_DCOC_CHANNEL_160MHZ_BMP_TCV0 = ADDR_CALIB_IQ_DCOC +
+		offsetof(struct eeprom_calib_iq_dcoc, chan_160mhz_bmp_tcv0),
+	ADDR_CALIB_IQ_DCOC_CHANNEL_160MHZ_BMP_TCV1 = ADDR_CALIB_IQ_DCOC +
+		offsetof(struct eeprom_calib_iq_dcoc, chan_160mhz_bmp_tcv1),
+	ADDR_CALIB_IQ_DCOC_DATA_20MHZ_TCV0 = ADDR_CALIB_IQ_DCOC +
+		offsetof(struct eeprom_calib_iq_dcoc, calib_20_data_tcv0),
+	ADDR_CALIB_IQ_DCOC_DATA_20MHZ_TCV1 = ADDR_CALIB_IQ_DCOC +
+		offsetof(struct eeprom_calib_iq_dcoc, calib_20_data_tcv1),
+	ADDR_CALIB_IQ_DCOC_DATA_40MHZ_TCV0 = ADDR_CALIB_IQ_DCOC +
+		offsetof(struct eeprom_calib_iq_dcoc, calib_40_data_tcv0),
+	ADDR_CALIB_IQ_DCOC_DATA_40MHZ_TCV1 = ADDR_CALIB_IQ_DCOC +
+		offsetof(struct eeprom_calib_iq_dcoc, calib_40_data_tcv1),
+	ADDR_CALIB_IQ_DCOC_DATA_80MHZ_TCV0 = ADDR_CALIB_IQ_DCOC +
+		offsetof(struct eeprom_calib_iq_dcoc, calib_80_data_tcv0),
+	ADDR_CALIB_IQ_DCOC_DATA_80MHZ_TCV1 = ADDR_CALIB_IQ_DCOC +
+		offsetof(struct eeprom_calib_iq_dcoc, calib_80_data_tcv1),
+	ADDR_CALIB_IQ_DCOC_DATA_160MHZ_TCV0 = ADDR_CALIB_IQ_DCOC +
+		offsetof(struct eeprom_calib_iq_dcoc, calib_160_data_tcv0),
+	ADDR_CALIB_IQ_DCOC_DATA_160MHZ_TCV1 = ADDR_CALIB_IQ_DCOC +
+		offsetof(struct eeprom_calib_iq_dcoc, calib_160_data_tcv1),
+#endif
+	SIZE_HW = sizeof(struct eeprom_hw),
+	SIZE_HW_RESERVED = ADDR_GEN - ADDR_HW_RESERVED,
+
+	SIZE_GEN = sizeof(struct eeprom_general),
+	SIZE_GEN_VERSION = ADDR_GEN_FLAVOR - ADDR_GEN_VERSION,
+	SIZE_GEN_FLAVOR = ADDR_GEN_MAC_ADDR - ADDR_GEN_FLAVOR,
+	SIZE_GEN_MAC_ADDR = ADDR_GEN_TEMP_DIFF - ADDR_GEN_MAC_ADDR,
+	SIZE_GEN_TEMP_DIFF = ADDR_GEN_SERIAL_NUMBER - ADDR_GEN_TEMP_DIFF,
+	SIZE_GEN_SERIAL_NUMBER = ADDR_GEN_PWR_TABLE_ID - ADDR_GEN_SERIAL_NUMBER,
+	SIZE_GEN_PWR_TABLE_ID = ADDR_GEN_RESERVED - ADDR_GEN_PWR_TABLE_ID,
+	SIZE_GEN_RESERVED = ADDR_FEM - ADDR_GEN_RESERVED,
+
+	SIZE_FEM = sizeof(struct eeprom_fem),
+	SIZE_FEM_WIRING_ID = ADDR_FEM_LUT - ADDR_FEM_WIRING_ID,
+	SIZE_FEM_LUT = ADDR_FEM_PLATFORM_ID - ADDR_FEM_LUT,
+	SIZE_FEM_PLATFORM_ID = ADDR_FEM_RESERVED - ADDR_FEM_PLATFORM_ID,
+
+	SIZE_CALIB_POWER = sizeof(struct eeprom_calib_power),
+	SIZE_CALIB_POWER_FREQ_OFFSET = ADDR_CALIB_POWER_CHAN_BMP - ADDR_CALIB_POWER_FREQ_OFFSET,
+	SIZE_CALIB_POWER_CHAN_BMP = ADDR_CALIB_POWER_PHY - ADDR_CALIB_POWER_CHAN_BMP,
+#ifdef CONFIG_CL8K_EEPROM_STM24256
+	SIZE_CALIB_POWER_PHY = ADDR_CALIB_IQ_DCOC_VERSION - ADDR_CALIB_POWER_PHY,
+#else
+	SIZE_CALIB_POWER_PHY = sizeof(struct eeprom_phy_calib) * NUM_PIVOT_PHYS,
+#endif
+
+#ifdef CONFIG_CL8K_EEPROM_STM24256
+	SIZE_CALIB_IQ_DCOC_VERSION = ADDR_CALIB_IQ_DCOC_CHANNEL_20MHZ_BMP_TCV0 -
+		ADDR_CALIB_IQ_DCOC_VERSION,
+	SIZE_CALIB_IQ_DCOC_20MHZ_BMP_TCV0 = ADDR_CALIB_IQ_DCOC_CHANNEL_20MHZ_BMP_TCV1 -
+		ADDR_CALIB_IQ_DCOC_CHANNEL_20MHZ_BMP_TCV0,
+	SIZE_CALIB_IQ_DCOC_20MHZ_BMP_TCV1 = ADDR_CALIB_IQ_DCOC_CHANNEL_40MHZ_BMP_TCV0 -
+		ADDR_CALIB_IQ_DCOC_CHANNEL_20MHZ_BMP_TCV1,
+	SIZE_CALIB_IQ_DCOC_40MHZ_BMP_TCV0 = ADDR_CALIB_IQ_DCOC_CHANNEL_40MHZ_BMP_TCV1 -
+		ADDR_CALIB_IQ_DCOC_CHANNEL_40MHZ_BMP_TCV0,
+	SIZE_CALIB_IQ_DCOC_40MHZ_BMP_TCV1 = ADDR_CALIB_IQ_DCOC_CHANNEL_80MHZ_BMP_TCV0 -
+		ADDR_CALIB_IQ_DCOC_CHANNEL_40MHZ_BMP_TCV1,
+	SIZE_CALIB_IQ_DCOC_80MHZ_BMP_TCV0 = ADDR_CALIB_IQ_DCOC_CHANNEL_80MHZ_BMP_TCV1 -
+		ADDR_CALIB_IQ_DCOC_CHANNEL_80MHZ_BMP_TCV0,
+	SIZE_CALIB_IQ_DCOC_80MHZ_BMP_TCV1 = ADDR_CALIB_IQ_DCOC_CHANNEL_160MHZ_BMP_TCV0 -
+		ADDR_CALIB_IQ_DCOC_CHANNEL_80MHZ_BMP_TCV1,
+	SIZE_CALIB_IQ_DCOC_160MHZ_BMP_TCV0 = ADDR_CALIB_IQ_DCOC_CHANNEL_160MHZ_BMP_TCV1 -
+		ADDR_CALIB_IQ_DCOC_CHANNEL_160MHZ_BMP_TCV0,
+	SIZE_CALIB_IQ_DCOC_160MHZ_BMP_TCV1 = ADDR_CALIB_IQ_DCOC_DATA_20MHZ_TCV0 -
+		ADDR_CALIB_IQ_DCOC_CHANNEL_160MHZ_BMP_TCV1,
+	SIZE_CALIB_IQ_DCOC_DATA_20MHZ_TCV0 = ADDR_CALIB_IQ_DCOC_DATA_20MHZ_TCV1 -
+		ADDR_CALIB_IQ_DCOC_DATA_20MHZ_TCV0,
+	SIZE_CALIB_IQ_DCOC_DATA_20MHZ_TCV1 = ADDR_CALIB_IQ_DCOC_DATA_40MHZ_TCV0 -
+		ADDR_CALIB_IQ_DCOC_DATA_20MHZ_TCV1,
+	SIZE_CALIB_IQ_DCOC_DATA_40MHZ_TCV0 = ADDR_CALIB_IQ_DCOC_DATA_40MHZ_TCV1 -
+		ADDR_CALIB_IQ_DCOC_DATA_40MHZ_TCV0,
+	SIZE_CALIB_IQ_DCOC_DATA_40MHZ_TCV1 = ADDR_CALIB_IQ_DCOC_DATA_80MHZ_TCV0 -
+		ADDR_CALIB_IQ_DCOC_DATA_40MHZ_TCV1,
+	SIZE_CALIB_IQ_DCOC_DATA_80MHZ_TCV0 = ADDR_CALIB_IQ_DCOC_DATA_80MHZ_TCV1 -
+		ADDR_CALIB_IQ_DCOC_DATA_80MHZ_TCV0,
+	SIZE_CALIB_IQ_DCOC_DATA_80MHZ_TCV1 = ADDR_CALIB_IQ_DCOC_CHANNEL_160MHZ_BMP_TCV0 -
+		ADDR_CALIB_IQ_DCOC_DATA_80MHZ_TCV1,
+	SIZE_CALIB_IQ_DCOC_DATA_160MHZ_TCV0 = ADDR_CALIB_IQ_DCOC_CHANNEL_160MHZ_BMP_TCV1 -
+		ADDR_CALIB_IQ_DCOC_CHANNEL_160MHZ_BMP_TCV0,
+	SIZE_CALIB_IQ_DCOC_DATA_160MHZ_TCV1 = sizeof(struct eeprom_calib_data) *
+		ADDR_CALIB_IQ_DCOC_CHANNEL_160MHZ_BMP_TCV1,
+	EEPROM_BASIC_NUM_BYTES = sizeof(struct eeprom) - sizeof(struct eeprom_calib_iq_dcoc),
+#else
+	EEPROM_BASIC_NUM_BYTES = sizeof(struct eeprom),
+#endif
+	EEPROM_NUM_BYTES = sizeof(struct eeprom),
+
+	EEPROM_LAST_BYTE = EEPROM_NUM_BYTES - 1,
+};
+
+#endif /* CL_EEPROM_H */
-- 
2.36.1

