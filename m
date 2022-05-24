Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30D753297F
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbiEXLl1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237045AbiEXLlK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:41:10 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB5094181
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:40:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvYHWzJS7WogT6dRVwS8X7XQT38oXay9UytdXdrlwouH2MIkEqaX3yHEAj378XJHiBleNl26sEGEpyE38w3GGhsY6l5Tu7K0txYWmsdjHJvz4KGTXp6mU9v26C2A3l4QUXIHywcGY26oa+MwoPbdEO043Qi/SPxo55TB/2dfQ0O6Yn7RDbYyeRiDeZNH69a0czVNKo6Yf5/ec9aqI6sVgUK1xuKpTQ9e6E4KveYZWtwN0oZnVDvn+2GV69E7QtORr34ccFm55P+vjRg8AlmJWhgBH5+jRyXi9AcPnM0OhrkrvE7px2Z2Z0dwh6oURKa+9h0pITQrsbqXBVxhjNIacg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQ5oewS1o33UM4gcl+FntTjVuVyd+jWmG0sYFqV785I=;
 b=aNPUPrWSmKyEMscJjZWcoDwpjvrkYr3h3ZlkL/i07L5baeoMclqyno3M4BHGTIlAApwyt44/GUigSD5bISnwQJw+80iDkbXOMksqbPqdqhJRuuDL/BDYZVPxK0uJDe9NlGyOexA9mzmPD6c74GiE9iMGvRsbe3HMS7G7MNlGaWTkBWxOfwUM9bYPb2IVZjtctapr5AVcJBhxHHQq5O3hWWsFk0ktqCgvXXWwnTGa3sLYZtAdO2/Pjh1dV73LsaaPKg4s0f/1FbRHeYq1CmZQ6Ogwf9t67y0M+Z/GHJdvvb8tYw1hIQ5u7mezhQdqSvZZoANNGDNQ7aK8yN0+/uEIrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQ5oewS1o33UM4gcl+FntTjVuVyd+jWmG0sYFqV785I=;
 b=OGQ9g3wp7V4SanFmUwd0fdOzUu7L1Fq4y7njaon8hsLxoIEaiY8usI2HnY2s5SLdTIp30ItpruKHhbbASpvKhW0FCZPmwYC8QDIKOWWpjRnqhfE8rKVB6w/77BA9QJ3hptqYDi1Z7Exr5Y+h0D0Bsl5jx2+IVt5KVGGaTq5T6NQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VE1P192MB0669.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:16f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:39:33 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:33 +0000
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
Subject: [RFC v2 86/96] cl8k: add utils.c
Date:   Tue, 24 May 2022 14:34:52 +0300
Message-Id: <20220524113502.1094459-87-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0e8b9b24-e92f-4ec0-e7cd-08da3d79fde2
X-MS-TrafficTypeDiagnostic: VE1P192MB0669:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VE1P192MB066950B75AAC9B64337470AFF6D79@VE1P192MB0669.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fQ48fZtIwOEuCJJGaGhL4hm7lV4UrDjEZJlYLvmcKuV8QfmjbJ1Ov0ttfYwLrL4RGJwiwXeNAkdi+uacc/mKERwnnpdBNGo3XHZ5flH0zCQqXnNEIb5LphyRAL++Ofj+Xr6WyEQPtsRNpeqWz/1vuW7++qqKuQZNehad1d/neYUTzbblH0yMq7lxJa9bTSu8ebfp043wcLtPzo881nGrmV7vDLx9kVMy8ZByrbuiHp8gfr3QdcEZpqh+yi20WcwD7yzQeQwh3Xp594CBExQGZ07o9bJ4PQvSjzXktYPKJHA7R9D5Zu5KfqyMCwe3FRYI8dL8GoCqWv1WmXpA4e1pury9ZxZKDYJZT6ruwT6e0LQubp+P8B9H1gM7gAcP6qvQ7kUI3IgJQwYq2Rp+ev3rbaRKCpVue8JBQTVFxVVmz0FsvVa2S3KYkKsmREWbXu0/BEwXibTlGCcQTob7fLXMifFOVjCF4JJM+xhqXlQzkce+A96Bl464Vcq1aLIFEAeP5mAtnEwrfleF5ctjA62rzxznzf+N7h3BgrEQWONhFZEf/n5L4PTj3tspfBGk17jOvIj4DeTBGQewUUU0HbZhDl+yr7VLxSYkY0WnnNQRtEoOmKMvx86sta/Qzk235sDUWQzsm8Sw9grLTxd2NbK/jlZeyJNVL3eu2y9RT1wAwKKPUx67BmtR4ojxAS5pRJ4JsMtAVX40pN+AJQn6b42hAhWGP1YS2YGg6VxlZ3h10eQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(376002)(136003)(366004)(346002)(39850400004)(8676002)(9686003)(26005)(36756003)(66946007)(66556008)(66476007)(4326008)(107886003)(83380400001)(6512007)(5660300002)(38350700002)(38100700002)(1076003)(2616005)(316002)(6916009)(6506007)(6486002)(54906003)(86362001)(8936002)(508600001)(41300700001)(6666004)(2906002)(186003)(52116002)(30864003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?il3780JClZic2+wL8K3eixoxL9c9jIqsRKb4dtor4LScFF4uYKsCJzYcpvWF?=
 =?us-ascii?Q?ydTIhqiWg0TZkItWrHKYxgLpOkHF+SgqpCWUIxoZ8ieS/rL7SnW+waNMkoxz?=
 =?us-ascii?Q?GprUqz6DhBiza/dbcTMf7FshC0pgnhg8jOuwHj2KAEtXoUBQheP4G8W3gyP3?=
 =?us-ascii?Q?UCCse+Q7UGQ+HASIfJrTJGG3MRu/LYSJ1NT7D5SGsZ8kKitK7eOUMQqobRI7?=
 =?us-ascii?Q?20mJl0cCb7N6iWnZlDIV9cWAu+43mGEcOsTnrO+efNnLOPQY9PkxzJF+fZ2l?=
 =?us-ascii?Q?iTC/vmi+ZDpNYHcR2otci7ByqcPfW7/uBVCIdYHmfJdeQx+gPyxro2jy/RWp?=
 =?us-ascii?Q?gusNU6nKxWsONlH4Uqtm76PM1+AaupEVKo8pU3TgfnLhSKzCH+3paoWS6u7C?=
 =?us-ascii?Q?0j9aPvNe7K8fOygiysiSYxoLylle3BlbX5RgrnDarQvv69TfZDppm4EhDOng?=
 =?us-ascii?Q?YTZeDO8C2TFbQd9GtbfpnJFXrpCq/lTH9JBughU3OzVcUiPSrwPZ1uCt/ypj?=
 =?us-ascii?Q?LMzgqawFBoksXm0oWWy6fxZU8q1mqhQXNGXgqHewZ5mt8zW1pO4V1v8NUPtB?=
 =?us-ascii?Q?xRlCQ+7SKYb/HEIsuujKuLduyUByOYMd3KSNLZYzgBDuC+weEEqfDA6WVlLB?=
 =?us-ascii?Q?Q5zy08pSVcVJETd2uIK4B/tQI4/I2pnLjxp0LsTwwPdb7qz/iug3iHzC9XP5?=
 =?us-ascii?Q?RXnagFAQ9dp43oTgWTnsD5YLOqnwwclUD9t/MgWBntBCCdskxjv12UuMb5pS?=
 =?us-ascii?Q?gSAo6YGpR7i3nmrKeZPsCCJIQlmbzShsmKk7Li+mj++JPDjKAocLmrLFI06z?=
 =?us-ascii?Q?xtJW+hDs4vVqHoeE+RD2D8bozEGLxcHCvMa50Ma3NcPxDMdVsGR1/fk7s/gZ?=
 =?us-ascii?Q?2/sGtZsnYAwdlprAU7BvUGhE3UhoTjmtSv4MIw8mkOrlHN273TUsSmHPh17z?=
 =?us-ascii?Q?DlP76ut04Z3rjS4VloYgwQCO2mS6SycTz7BYtEP/7BqTdB2DZG4y8WfG0H57?=
 =?us-ascii?Q?466UZG81wDRZUil796XMsK4VcD/wFTGxLG0jV9Y5dhq6OlpN2VGHYg+hA03H?=
 =?us-ascii?Q?DBkJ+xMHJjRMInchDksr1kDDAAI4CMCaS0c8ln/7t4G4DtuMwY2Q02+2AUVi?=
 =?us-ascii?Q?JHKMRDT2ek/WK7Crbk+oxDLNjuDoY5OEGzW2E8rRWxtr18ozeWi7EwHBK3Pd?=
 =?us-ascii?Q?USB/poyqc8y4JJzt3BQXv6uVrPbOCCut0IncQ76iv3prJFu7mIqWWn0rL0Lu?=
 =?us-ascii?Q?fWCTXgI5K7hNnKqWN/5a77zHLba82ENrfs6r19S8HqMD7dttQnRO7ZyS65qR?=
 =?us-ascii?Q?53hY68Fg+f9NBCy/zpeyTpn+pL5CVjAJ+hlDceWqjt8Kj6xh0SlTVpR3B5OW?=
 =?us-ascii?Q?oP1hkCJDUyb2vvVXGIMTNP08sK4/BKdNcPDbyGrj9ttJC0d4VhfxihJV5hR2?=
 =?us-ascii?Q?0UOwg/B2ebzfS5zmjCahsaaBKhQtdLFRXCISpRMz7QaQkMJdMzvMVer4nLV4?=
 =?us-ascii?Q?rkR1FH3of1btK0S/FjKDVMentY93Y2O5f1vEFy2l/MTyQG7weANyIAeCo3hn?=
 =?us-ascii?Q?a3LnGlGij2W+h6MxEMv0yS8pG/hP0yGqWC73IcSO5R/2rQ/bDUeAHhwkdp9i?=
 =?us-ascii?Q?pPD9KOUeYL/SIW6musVKdTgyuUyZGHK3ItpqvjByDjiOQTlvwHO2hQj5CQn8?=
 =?us-ascii?Q?mnW1xeA7ON61OutO+x/zB7JXNC3XVvuCP9+dkw/VHt1C78VApuGxac20KdMW?=
 =?us-ascii?Q?lQdoa79bfOWcu0/EpnW0Ywm6wKMhJzM=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8b9b24-e92f-4ec0-e7cd-08da3d79fde2
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:58.7908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qISVjIc1bqTM6+bnzCV/HVh/4MREDHTKds7iwQGI+kpW30k2rM/LuqrAaqPW7+YsRIgeMWjMb5t0Rzj8sdam7w==
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
 drivers/net/wireless/celeno/cl8k/utils.c | 642 +++++++++++++++++++++++
 1 file changed, 642 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils.c

diff --git a/drivers/net/wireless/celeno/cl8k/utils.c b/drivers/net/wireless/celeno/cl8k/utils.c
new file mode 100644
index 000000000000..fadc586e9579
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/utils.c
@@ -0,0 +1,642 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include <linux/dma-mapping.h>
+#include <linux/list.h>
+#include <linux/jiffies.h>
+#include <linux/kthread.h>
+#include <net/mac80211.h>
+#include <linux/sched/signal.h>
+#include <linux/firmware.h>
+#include <linux/if_vlan.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+
+#include "hw.h"
+#include "ipc_shared.h"
+#include "radio.h"
+#include "traffic.h"
+#include "reg/reg_defs.h"
+#include "utils.h"
+
+#define GI_08  0
+#define GI_16  1
+#define GI_32  2
+#define GI_04  3
+
+#define GI_MAX_FW 4
+#define GI_MAX_HE 3
+#define GI_MAX_HT_VHT 2
+
+static u8 conv_wrs_gi_ht_vht[GI_MAX_HT_VHT] = {
+	[WRS_GI_LONG] = GI_08,
+	[WRS_GI_SHORT] = GI_04
+};
+
+static u8 conv_wrs_gi_he[GI_MAX_HE] = {
+	[WRS_GI_LONG] = GI_32,
+	[WRS_GI_SHORT] = GI_16,
+	[WRS_GI_VSHORT] = GI_08
+};
+
+static u8 conv_fw_gi_ht_vht[GI_MAX_FW] = {
+	[GI_08] = WRS_GI_LONG,
+	[GI_16] = 0,
+	[GI_32] = 0,
+	[GI_04] = WRS_GI_SHORT,
+};
+
+static u8 conv_fw_gi_he[GI_MAX_FW] = {
+	[GI_08] = WRS_GI_VSHORT,
+	[GI_16] = WRS_GI_SHORT,
+	[GI_32] = WRS_GI_LONG,
+	[GI_04] = 0,
+};
+
+static const u8 cl_mu_ofdma_ru_type_to_bw_conversion[CL_MU_OFDMA_RU_TYPE_MAX] = {
+	CHNL_BW_2_5,
+	CHNL_BW_2_5,
+	CHNL_BW_5,
+	CHNL_BW_10,
+	CHNL_BW_20,
+	CHNL_BW_40,
+	CHNL_BW_80,
+	CHNL_BW_160
+};
+
+void cl_hex_dump(char *caption, u8 *buffer, u32 length, u32 offset, bool is_byte)
+{
+	u8 *pt = buffer;
+	u32 i;
+	bool end_nl = false;
+	char buf[STR_LEN_256B] = {0};
+	int len = 0;
+
+	if (caption)
+		pr_debug("%s: %p, len = %u\n", caption, buffer, length);
+
+	if (is_byte) {
+		for (i = 0; i < length; i++) {
+			if (i % 16 == 0)
+				len += snprintf(buf + len, sizeof(buf) - len,
+						"0x%04x : ", i + offset);
+			len += snprintf(buf + len, sizeof(buf) - len,
+					"%02x ", ((u8)pt[i]));
+			end_nl = true;
+			if (i % 16 == 15) {
+				pr_debug("%s", buf);
+				len = 0;
+				end_nl = false;
+			}
+		}
+	} else {
+		for (i = 0; i < (length / sizeof(u32)); i++) {
+			if (i % 4 == 0)
+				len += snprintf(buf + len, sizeof(buf) - len,
+						"0x%04x : ",
+						(u32)(i * sizeof(u32) + offset));
+			len += snprintf(buf + len, sizeof(buf) - len,
+					"%08x ", *((u32 *)(pt + i * sizeof(u32))));
+			end_nl = true;
+			if (i % 4 == 3) {
+				pr_debug("%s", buf);
+				len = 0;
+				end_nl = false;
+			}
+		}
+	}
+
+	if (end_nl)
+		pr_debug("%s", buf);
+}
+
+u8 cl_convert_gi_format_wrs_to_fw(u8 wrs_mode, u8 gi)
+{
+	if (wrs_mode == WRS_MODE_HE && gi < GI_MAX_HE)
+		return conv_wrs_gi_he[gi];
+	else if (wrs_mode > WRS_MODE_OFDM && gi < GI_MAX_HT_VHT)
+		return conv_wrs_gi_ht_vht[gi];
+	else
+		return 0;
+}
+
+u8 cl_convert_gi_format_fw_to_wrs(u8 format_mode, u8 gi)
+{
+	if (gi < GI_MAX_FW) {
+		if (format_mode >= FORMATMOD_HE_SU)
+			return conv_fw_gi_he[gi];
+		else if (format_mode >= FORMATMOD_HT_MF)
+			return conv_fw_gi_ht_vht[gi];
+	}
+
+	return 0;
+}
+
+static u8 map_gi_to_ltf[WRS_GI_MAX] = {
+	[WRS_GI_LONG] = LTF_X4,
+	[WRS_GI_SHORT] = LTF_X2,
+	[WRS_GI_VSHORT] = LTF_X2,
+};
+
+u8 cl_map_gi_to_ltf(u8 mode, u8 gi)
+{
+	if (mode == WRS_MODE_HE && gi < WRS_GI_MAX)
+		return map_gi_to_ltf[gi];
+
+	return 0;
+}
+
+/* This table holds 10^(-110 -> 0) Q39 values for rx RSSI and noise floor calculations */
+#define CL_EXP_TBL_SIZE 111 /* 10^x table size (-110 -> 0dBm) */
+
+static u64 CL_EXP_10[CL_EXP_TBL_SIZE] = {
+	0x7FFFFFFFFFULL, 0x65AC8C2F36ULL, 0x50C335D3DBULL, 0x4026E73CCDULL, 0x32F52CFEEAULL,
+	0x287A26C490ULL, 0x2026F30FBBULL, 0x198A13577CULL, 0x144960C577ULL, 0x101D3F2D96ULL,
+	0x0CCCCCCCCDULL, 0x0A2ADAD185ULL, 0x08138561FCULL, 0x066A4A52E1ULL, 0x0518847FE4ULL,
+	0x040C3713A8ULL, 0x0337184E5FULL, 0x028DCEBBF3ULL, 0x0207567A25ULL, 0x019C86515CULL,
+	0x0147AE147BULL, 0x01044914F4ULL, 0x00CEC089CCULL, 0x00A43AA1E3ULL, 0x008273A664ULL,
+	0x00679F1B91ULL, 0x00524F3B0AULL, 0x0041617932ULL, 0x0033EF0C37ULL, 0x002940A1BCULL,
+	0x0020C49BA6ULL, 0x001A074EE5ULL, 0x0014ACDA94ULL, 0x00106C4364ULL, 0x000D0B90A4ULL,
+	0x000A5CB5F5ULL, 0x00083B1F81ULL, 0x000689BF52ULL, 0x0005318139ULL, 0x000420102CULL,
+	0x000346DC5DULL, 0x00029A54B1ULL, 0x000211490FULL, 0x0001A46D24ULL, 0x00014DF4DDULL,
+	0x0001094565ULL, 0x0000D2B65AULL, 0x0000A75FEFULL, 0x000084F352ULL, 0x0000699B38ULL,
+	0x000053E2D6ULL, 0x000042A212ULL, 0x000034EDB5ULL, 0x00002A0AEAULL, 0x0000216549ULL,
+	0x00001A86F1ULL, 0x000015123CULL, 0x000010BCCBULL, 0x00000D4B88ULL, 0x00000A8F86ULL,
+	0x000008637CULL, 0x000006A9CFULL, 0x0000054AF8ULL, 0x000004344BULL, 0x00000356EEULL,
+	0x000002A718ULL, 0x0000021B6CULL, 0x000001AC7BULL, 0x000001545AULL, 0x0000010E5AULL,
+	0x000000D6C0ULL, 0x000000AA95ULL, 0x000000877FULL, 0x0000006BA1ULL, 0x000000557EULL,
+	0x00000043E9ULL, 0x00000035F1ULL, 0x0000002AD9ULL, 0x0000002209ULL, 0x0000001B09ULL,
+	0x000000157AULL, 0x000000110FULL, 0x0000000D8DULL, 0x0000000AC3ULL, 0x000000088DULL,
+	0x00000006CAULL, 0x0000000565ULL, 0x0000000449ULL, 0x0000000367ULL, 0x00000002B4ULL,
+	0x0000000226ULL, 0x00000001B5ULL, 0x000000015BULL, 0x0000000114ULL, 0x00000000DBULL,
+	0x00000000AEULL, 0x000000008AULL, 0x000000006EULL, 0x0000000057ULL, 0x0000000045ULL,
+	0x0000000037ULL, 0x000000002CULL, 0x0000000023ULL, 0x000000001CULL, 0x0000000016ULL,
+	0x0000000011ULL, 0x000000000EULL, 0x000000000BULL, 0x0000000009ULL, 0x0000000007ULL,
+	0x0000000005ULL
+};
+
+static s8 cl_eng_to_noise_floor(u64 eng)
+{
+	s8 i = 0;
+	s8 noise = 0;
+	s64 min_delta = S64_MAX;
+
+	for (i = CL_EXP_TBL_SIZE - 1; i >= 0; i--) {
+		if (abs((s64)(((s64)eng) - ((s64)CL_EXP_10[i]))) < min_delta) {
+			min_delta = abs((s64)(((s64)eng) - ((s64)CL_EXP_10[i])));
+			noise = i;
+		}
+	}
+
+	return (-noise);
+}
+
+static void cl_read_reg_noise(struct cl_hw *cl_hw, s8 res[4])
+{
+	u32 reg_val = riu_agcinbdpow_20_pnoisestat_get(cl_hw);
+	u8 i = 0;
+
+	for (i = 0; i < 4; i++) {
+		u8 curr_val = (reg_val >> (i * 8)) & 0xFF;
+		/* Convert reg value to real value */
+		res[i] = curr_val - 0xFF;
+	}
+}
+
+s8 cl_calc_noise_floor(struct cl_hw *cl_hw, const s8 *reg_noise_floor)
+{
+	s8 noise_floor[4] = {0};
+	u64 noise_floor_eng = 0;
+
+	if (reg_noise_floor)
+		memcpy(noise_floor, reg_noise_floor, sizeof(noise_floor));
+	else
+		cl_read_reg_noise(cl_hw, noise_floor);
+
+	noise_floor[0] = abs(noise_floor[0]);
+	noise_floor[1] = abs(noise_floor[1]);
+	noise_floor[2] = abs(noise_floor[2]);
+	noise_floor[3] = abs(noise_floor[3]);
+
+	BUILD_BUG_ON(CL_EXP_TBL_SIZE > S8_MAX);
+	noise_floor_eng = (CL_EXP_10[min_t(s8, noise_floor[0], CL_EXP_TBL_SIZE - 1)] +
+			   CL_EXP_10[min_t(s8, noise_floor[1], CL_EXP_TBL_SIZE - 1)] +
+			   CL_EXP_10[min_t(s8, noise_floor[2], CL_EXP_TBL_SIZE - 1)] +
+			   CL_EXP_10[min_t(s8, noise_floor[3], CL_EXP_TBL_SIZE - 1)]);
+
+	noise_floor_eng = div64_u64(noise_floor_eng, 4);
+
+	return cl_eng_to_noise_floor(noise_floor_eng);
+}
+
+u8 cl_convert_signed_to_reg_value(s8 val)
+{
+	bool sign = val < 0;
+	u8 res = abs(val);
+
+	if (sign)
+		res |= (1 << 7);
+
+	return res;
+}
+
+static const int nl_width_to_phy_bw[] = {
+	[NL80211_CHAN_WIDTH_20_NOHT] = CHNL_BW_20,
+	[NL80211_CHAN_WIDTH_20]      = CHNL_BW_20,
+	[NL80211_CHAN_WIDTH_40]      = CHNL_BW_40,
+	[NL80211_CHAN_WIDTH_80]      = CHNL_BW_80,
+	[NL80211_CHAN_WIDTH_80P80]   = CHNL_BW_20,
+	[NL80211_CHAN_WIDTH_160]     = CHNL_BW_160,
+	[NL80211_CHAN_WIDTH_5]       = CHNL_BW_20,
+	[NL80211_CHAN_WIDTH_10]      = CHNL_BW_20,
+};
+
+u8 cl_width_to_bw(enum nl80211_chan_width width)
+{
+	if (width <= NL80211_CHAN_WIDTH_10)
+		return nl_width_to_phy_bw[width];
+
+	return CHNL_BW_20;
+}
+
+u8 cl_center_freq_offset(u8 bw)
+{
+	if (bw == CHNL_BW_160)
+		return 70;
+
+	if (bw == CHNL_BW_80)
+		return 30;
+
+	if (bw == CHNL_BW_40)
+		return 10;
+
+	return 0;
+}
+
+u8 cl_max_bw_idx(u8 wrs_mode, bool is_24g)
+{
+	if (wrs_mode < WRS_MODE_HT)
+		return CHNL_BW_20 + 1;
+
+	if (wrs_mode == WRS_MODE_HT || is_24g)
+		return CHNL_BW_40 + 1;
+
+	return CHNL_BW_MAX;
+}
+
+bool cl_hw_mode_is_b_or_bg(struct cl_hw *cl_hw)
+{
+	return (cl_hw->hw_mode == HW_MODE_B ||
+		cl_hw->hw_mode == HW_MODE_BG);
+}
+
+#define LENGTH_LLC   3
+#define LENGTH_SSNAP 5
+
+bool cl_is_eapol(struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	__le16 fc = hdr->frame_control;
+	unsigned int hdrlen = 0;
+	unsigned short ethertype = 0;
+	u8 *temp = NULL;
+
+	/* Find the wireless header size */
+	hdrlen = ieee80211_has_a4(fc) ? 30 : 24;
+
+	if (ieee80211_is_data_qos(fc)) {
+		hdrlen += IEEE80211_QOS_CTL_LEN;
+
+		if (ieee80211_has_order(fc))
+			hdrlen += IEEE80211_HT_CTL_LEN;
+	}
+
+	/* Skip wireless header */
+	temp = (u8 *)(skb->data + hdrlen);
+
+	/* Skip LLC and SNAP header */
+	if (PKT_HAS_LLC_HDR(temp))
+		ethertype = cl_get_ether_type(LENGTH_LLC + LENGTH_SSNAP - 2, temp);
+
+	return ethertype == ETH_P_PAE;
+}
+
+u8 cl_ru_alloc_to_ru_type(u8 ru_alloc)
+{
+	if (ru_alloc <= CL_TF_RU_ALLOC_MAX_TYPE_1)
+		return CL_MU_OFDMA_RU_TYPE_26;
+	else if (ru_alloc <= CL_TF_RU_ALLOC_MAX_TYPE_2)
+		return CL_MU_OFDMA_RU_TYPE_52;
+	else if (ru_alloc <= CL_TF_RU_ALLOC_MAX_TYPE_3)
+		return CL_MU_OFDMA_RU_TYPE_106;
+	else if (ru_alloc <= CL_TF_RU_ALLOC_MAX_TYPE_4)
+		return CL_MU_OFDMA_RU_TYPE_242;
+	else if (ru_alloc <= CL_TF_RU_ALLOC_MAX_TYPE_5)
+		return CL_MU_OFDMA_RU_TYPE_484;
+	else if (ru_alloc <= CL_TF_RU_ALLOC_MAX_TYPE_6)
+		return CL_MU_OFDMA_RU_TYPE_996;
+	else
+		return CL_MU_OFDMA_RU_TYPE_2x996;
+}
+
+bool cl_is_valid_g_rates(const u8 *rate_ie)
+{
+	int i, rate;
+
+	for (i = 0; i < rate_ie[1]; i++) {
+		rate = rate_ie[2 + i] & CL_SUPP_RATE_MASK;
+		switch (rate) {
+		case CL_80211G_RATE_6MB:
+		case CL_80211G_RATE_9MB:
+		case CL_80211G_RATE_12MB:
+		case CL_80211G_RATE_18MB:
+		case CL_80211G_RATE_24MB:
+		case CL_80211G_RATE_36MB:
+		case CL_80211G_RATE_48MB:
+		case CL_80211G_RATE_54MB:
+			return true;
+		}
+	}
+	return false;
+}
+
+enum cl_wireless_mode cl_recalc_wireless_mode(struct cl_hw *cl_hw,
+					      bool ieee80211n,
+					      bool ieee80211ac,
+					      bool ieee80211ax)
+{
+	enum cl_wireless_mode wireless_mode = cl_hw->wireless_mode;
+
+	if (!ieee80211n && !ieee80211ac && !ieee80211ax)
+		wireless_mode = WIRELESS_MODE_LEGACY;
+	else if (ieee80211n && (cl_band_is_24g(cl_hw) || ieee80211ac) && ieee80211ax)
+		wireless_mode = WIRELESS_MODE_HT_VHT_HE;
+	else if (ieee80211n && ieee80211ac)
+		wireless_mode =  WIRELESS_MODE_HT_VHT;
+	else if (ieee80211n)
+		wireless_mode = WIRELESS_MODE_HT;
+	else if (ieee80211ax)
+		wireless_mode = WIRELESS_MODE_HE;
+
+	return wireless_mode;
+}
+
+enum nl80211_he_ru_alloc cl_ru_type_to_nl80211_he_ru_alloc(enum cl_mu_ofdma_ru_type ru_type)
+{
+	switch (ru_type) {
+	case CL_MU_OFDMA_RU_TYPE_26:
+		return NL80211_RATE_INFO_HE_RU_ALLOC_26;
+	case CL_MU_OFDMA_RU_TYPE_52:
+		return NL80211_RATE_INFO_HE_RU_ALLOC_52;
+	case CL_MU_OFDMA_RU_TYPE_106:
+		return NL80211_RATE_INFO_HE_RU_ALLOC_106;
+	case CL_MU_OFDMA_RU_TYPE_242:
+		return NL80211_RATE_INFO_HE_RU_ALLOC_242;
+	case CL_MU_OFDMA_RU_TYPE_484:
+		return NL80211_RATE_INFO_HE_RU_ALLOC_484;
+	case CL_MU_OFDMA_RU_TYPE_996:
+		return NL80211_RATE_INFO_HE_RU_ALLOC_996;
+	case CL_MU_OFDMA_RU_TYPE_2x996:
+		return NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
+	default:
+		return 0;
+	}
+}
+
+u8 cl_mu_ofdma_grp_convert_ru_type_to_bw(struct cl_hw *cl_hw, u8 ru_type)
+{
+	if (ru_type >= CL_MU_OFDMA_RU_TYPE_MAX) {
+		pr_err("Invalid RU type %u\n", ru_type);
+		return 0;
+	}
+
+	return cl_mu_ofdma_ru_type_to_bw_conversion[ru_type];
+}
+
+void cl_ieee802_11_parse_elems(const u8 *ies, size_t ies_len, struct ieee802_11_elems *elems)
+{
+	u8 *ie = NULL;
+
+	memset(elems, 0, sizeof(*elems));
+
+	ie = (u8 *)cfg80211_find_ie(WLAN_EID_SSID, ies, ies_len);
+	if (ie) {
+		elems->ssid = (const u8 *)&ie[2];
+		elems->ssid_len = ie[1];
+	}
+
+	ie = (u8 *)cfg80211_find_ie(WLAN_EID_SUPP_RATES, ies, ies_len);
+	if (ie) {
+		elems->supp_rates = (const u8 *)&ie[2];
+		elems->supp_rates_len = ie[1];
+	}
+
+	ie = (u8 *)cfg80211_find_ie(WLAN_EID_HT_CAPABILITY, ies, ies_len);
+	if (ie)
+		elems->ht_cap_elem = (struct ieee80211_ht_cap *)&ie[2];
+
+	ie = (u8 *)cfg80211_find_ie(WLAN_EID_HT_OPERATION, ies, ies_len);
+	if (ie)
+		elems->ht_operation = (struct ieee80211_ht_operation *)&ie[2];
+
+	ie = (u8 *)cfg80211_find_ie(WLAN_EID_VHT_CAPABILITY, ies, ies_len);
+	if (ie)
+		elems->vht_cap_elem =  (struct ieee80211_vht_cap *)&ie[2];
+
+	ie = (u8 *)cfg80211_find_ie(WLAN_EID_VHT_OPERATION, ies, ies_len);
+	if (ie)
+		elems->vht_operation =  (struct ieee80211_vht_operation *)&ie[2];
+
+	ie = (u8 *)cfg80211_find_ie(WLAN_EID_TIM, ies, ies_len);
+	if (ie) {
+		elems->tim = (struct ieee80211_tim_ie *)&ie[2];
+		elems->tim_len = ie[1];
+	}
+
+	ie = (u8 *)cfg80211_find_ie(WLAN_EID_RSN, ies, ies_len);
+	if (ie) {
+		elems->rsn = (const u8 *)&ie[2];
+		elems->rsn_len = ie[1];
+	}
+
+	ie = (u8 *)cfg80211_find_ext_ie(WLAN_EID_EXT_SUPP_RATES, ies, ies_len);
+	if (ie) {
+		elems->ext_supp_rates = (const u8 *)&ie[2];
+		elems->ext_supp_rates_len = ie[1];
+	}
+
+	ie = (u8 *)cfg80211_find_ext_ie(WLAN_EID_EXT_HE_CAPABILITY, ies, ies_len);
+	if (ie) {
+		elems->he_cap = (const u8 *)&ie[2];
+		elems->he_cap_len = ie[1];
+	}
+
+	ie = (u8 *)cfg80211_find_ext_ie(WLAN_EID_EXT_HE_OPERATION, ies, ies_len);
+	if (ie)
+		elems->he_operation = (struct ieee80211_he_operation *)&ie[2];
+}
+
+size_t cl_file_open_and_read(struct cl_chip *chip, const char *filename,
+			     char **buf)
+{
+	const struct firmware *fw;
+	size_t size = 0;
+	int ret = 0;
+	char path_name[CL_PATH_MAX] = {0};
+
+	snprintf(path_name, sizeof(path_name), "cl8k/%s", filename);
+	ret = request_firmware_direct(&fw, path_name, chip->dev);
+
+	if (ret) {
+		cl_dbg_chip_err(chip, "request_firmware_direct %s failed\n",
+				path_name);
+		return 0;
+	}
+
+	if (!fw || !fw->data) {
+		cl_dbg_chip_err(chip, "Invalid firmware %s\n", path_name);
+		goto out;
+	}
+
+	size = fw->size;
+
+	/*
+	 * Add one byte with a '\0' so that string manipulation functions
+	 * used for parsing these files can find the string '\0' terminator.
+	 * Make sure size is aligned to 4.
+	 */
+	*buf = kzalloc(ALIGN(size + 1, 4), GFP_KERNEL);
+	if (!(*buf)) {
+		size = 0;
+		goto out;
+	}
+
+	memcpy(*buf, fw->data, size);
+
+out:
+	release_firmware(fw);
+
+	return size;
+}
+
+static __be16 cl_get_eth_proto(struct sk_buff *skb)
+{
+	if (!skb->mac_header)
+		skb_reset_mac_header(skb);
+
+	if (eth_hdr(skb)->h_proto == htons(ETH_P_8021Q))
+		return vlan_eth_hdr(skb)->h_vlan_encapsulated_proto;
+	else
+		return eth_hdr(skb)->h_proto;
+}
+
+bool cl_set_network_header_if_proto(struct sk_buff *skb, u16 protocol)
+{
+	if (cl_get_eth_proto(skb) == htons(protocol)) {
+		const bool has_vlan_header = eth_hdr(skb)->h_proto == htons(ETH_P_8021Q);
+		const size_t h_offset =
+			(eth_hdr(skb) == (struct ethhdr *)(skb->data)) ? ETH_HLEN : 0;
+
+		skb_set_network_header(skb, h_offset + ((has_vlan_header) ? VLAN_HLEN : 0));
+
+		return true;
+	}
+
+	return false;
+}
+
+bool cl_is_ipv4_packet(struct sk_buff *skb)
+{
+	return cl_set_network_header_if_proto(skb, ETH_P_IP) &&
+	       (ip_hdr(skb)->ihl >= 5) &&
+	       (ip_hdr(skb)->version == IPVERSION);
+}
+
+bool cl_is_ipv6_packet(struct sk_buff *skb)
+{
+	return cl_set_network_header_if_proto(skb, ETH_P_IPV6) &&
+	       (ipv6_hdr(skb)->version == 6);
+}
+
+#define TCP_ACK_MAX_LEN 100
+
+bool cl_is_tcp_ack(struct sk_buff *skb, bool *syn_rst_push)
+{
+	if (skb->len > TCP_ACK_MAX_LEN)
+		goto out;
+
+	if (cl_is_ipv4_packet(skb)) {
+		struct iphdr *iphdr = ip_hdr(skb);
+
+		if (iphdr->protocol == IPPROTO_TCP) {
+			struct tcphdr *tcp_hdr = (struct tcphdr *)
+						 ((char *)iphdr +
+						  IPV4_HDR_LEN(iphdr->ihl));
+			u16 data_size = ntohs(iphdr->tot_len) -
+					IPV4_HDR_LEN(iphdr->ihl) -
+					(tcp_hdr->doff * 4);
+
+			*syn_rst_push = tcp_hdr->syn || tcp_hdr->rst || tcp_hdr->psh;
+
+			return (data_size == 0);
+		}
+	} else if (cl_is_ipv6_packet(skb)) {
+		struct ipv6hdr *ipv6hdr = ipv6_hdr(skb);
+
+		if (ipv6hdr->nexthdr == IPPROTO_TCP) {
+			struct tcphdr *tcp_hdr = (struct tcphdr *)
+						 ((char *)ipv6hdr +
+						 sizeof(struct ipv6hdr));
+			u16 data_size = ntohs(ipv6hdr->payload_len) -
+					(tcp_hdr->doff * 4);
+
+			*syn_rst_push = tcp_hdr->syn || tcp_hdr->rst || tcp_hdr->psh;
+
+			return (data_size == 0);
+		}
+	}
+
+out:
+	*syn_rst_push = false;
+	return false;
+}
+
+bool cl_band_is_6g(struct cl_hw *cl_hw)
+{
+	return (cl_hw->conf->ci_band_num == 6);
+}
+
+bool cl_band_is_5g(struct cl_hw *cl_hw)
+{
+	return (cl_hw->conf->ci_band_num == 5);
+}
+
+bool cl_band_is_24g(struct cl_hw *cl_hw)
+{
+	return (cl_hw->conf->ci_band_num == 24);
+}
+
+u8 cl_band_to_fw_idx(struct cl_hw *cl_hw)
+{
+	if (cl_hw->nl_band == NL80211_BAND_6GHZ)
+		return FW_BAND_6GHZ;
+
+	if (cl_hw->nl_band == NL80211_BAND_5GHZ)
+		return FW_BAND_5GHZ;
+
+	return FW_BAND_2GHZ;
+}
+
+static u8 fw_to_nl_band[FW_BAND_MAX] = {
+	[FW_BAND_6GHZ] = NL80211_BAND_6GHZ,
+	[FW_BAND_5GHZ] = NL80211_BAND_5GHZ,
+	[FW_BAND_2GHZ] = NL80211_BAND_2GHZ,
+};
+
+u8 cl_band_from_fw_idx(u32 phy_band)
+{
+	if (phy_band < FW_BAND_MAX)
+		return fw_to_nl_band[phy_band];
+
+	return FW_BAND_MAX;
+}
-- 
2.36.1

