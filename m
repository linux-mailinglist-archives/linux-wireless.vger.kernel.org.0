Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA36532929
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbiEXLh7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbiEXLh4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:37:56 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7A250440
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:37:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAk7glnvtBaZFv4rUwV4dbiHK//TQWbehLFdzXmS+NgPL1nV+6YTHtB5nWs90cR4yK9jEkYvThkEfINqUETerHC2VNn6Mf/IWnBAn0VNTFaaL2sJ8BFuvyLUDblF1PDdt1wLKOQtxJZWJXOREY4os5rmHtbQ+b74ivAScTpesTa7l1c8upiHB5R6C3Hm0T2P9jc2f9b1siWgZv+NMZlrlgCxDRwkehMegqhSt47KlQnqmZNY3Tqb1dknki4sM2FAbHL9ODUZulZQEnhHIvwSDajLOBMh8DFElcnqNvFqAKUPh6kCYRM4UwprSVbvsL4ImNIk5RYnjEmsmm+ObrZK1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPB501un7HifiDDO/x8nSGT3zwV7EsAaQmP87vBaum0=;
 b=Nw3o9skDu4rN+dpm09eGaa0IkW8SK9CLB5P1EWcM032rjKnBiQd7SzEeYZjn/jKREsAnN6TWOFRTnBHoS0++US1FHJ1U5qjTO4camkBWZBiIwbQTUsB4qFuqHJGb5ZaAGMWKBdfGi8/g4bbv4dQqbGA9/pHv2pXckT9X6IPGmNmeHpSzwYhcs9Abq76uni1h8p4otFtMkhcN1ZWTCrsyN6+5h1ch1zb/bBR4xthkCL+onSNrTjcv6BuCTn+jqlwYuw8nqeWuyZP+kmD4yKRZQ9FNuerWsmmEX71vtKHGq7innn7a7XJK7rX05xmvGQmFWCEI2iPmPh3Jc9a4P8Rmkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPB501un7HifiDDO/x8nSGT3zwV7EsAaQmP87vBaum0=;
 b=KT8DbOeDVUnkrT3AFqGYAkJ3KeGlvJb0BttMa9KCYzbvRuO7wkzJzP8nfPa9iUPIsm55zF+0O1fTkftAWCsLYkAjNcL0FLHJ4kmK7f18hEMNvs5igUeLbOVQJe2z6WX8GjfVAOdk/Q6me00SuTNFVgHhkwo4pk/yznNNkS9En1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0305.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 11:37:51 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:37:51 +0000
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
Subject: [RFC v2 12/96] cl8k: add channel.h
Date:   Tue, 24 May 2022 14:33:38 +0300
Message-Id: <20220524113502.1094459-13-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: ac75a6e8-62da-422a-ff79-08da3d79d5b0
X-MS-TrafficTypeDiagnostic: AM0P192MB0305:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM0P192MB030562322F7E33D242484360F6D79@AM0P192MB0305.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gAAWPhj31W6T6Y7d+aXDweu8sgMX8xkMJ1crU1jvM6JeY11vqPK8ucayqQw20sa0xgDJ5GQHa921TLr3JrNXKnJSOe5dwtPvw5iXkVWqsI7xZ+bueXvapqotnyx5u8N/rKJkPbHYa8CgbcmhQOsAyb/tOhCU8/5ZDjwgkKlOOzw1Gz7Yf93Q+2d+b9ZeyWDJXVtyBQnxsO75AVpSdppBcKOjnl4tMN7EFWa6hWqf+j+9PgQ5Bm/Du5bZtEbFvmYr4iQDf3u+b62kZRhNzXhqN0DTKyqxIipll7erFx8PHCZHZCSJDIdeDnQ4VKYgVeO/FlTwtM8dYAGtXyZD8VSlZmIQexTKRIR6NVM0rM0sd1AUogCMnPvFHPe04EysTsXRcQegk5EaeZ3KkWoGPfWPpNthRiZbZER1PuTRqpN6q4w/9rKNkV+t3a2l84WxTMHfqcljWc3TV/Mq3ozN+Y91n/Q7NGmbZaOxYE2+3TDJVmEOp9VOFVG9FEEakoSRLtxK4Fmdf7j7dBSjEQQMTqwjOglOhNF3aZ/CxIXn/Qtuh/udlG4JxbcQm+fg9zdNM5lh3eHDamUBPGMdKBb0bs8xL4C/nluR+zpCKhiro4rdlCZQQ2Hc0rKnRFmpwp/oJl6GHSvkeE2AJpF/7am4XtGQyFb54FjZlpbQyAvnOJk2IpTj3IkJw0480NaCyhxL2NHiX3F1CP45ehVydmxMc0BFMXS6Nn7WbPlFQmuZTqtxWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(346002)(396003)(366004)(39850400004)(376002)(136003)(6486002)(6916009)(508600001)(38350700002)(38100700002)(52116002)(6666004)(2906002)(8936002)(54906003)(6512007)(6506007)(26005)(9686003)(8676002)(36756003)(5660300002)(316002)(66476007)(4326008)(66556008)(107886003)(66946007)(1076003)(41300700001)(186003)(2616005)(83380400001)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lZ+wozAJ6eJHAaKyKs+pvi6zs5WzAvRMudEOIHCv6W2pU2maBwdyI7yNCF8a?=
 =?us-ascii?Q?q1+7EyIzanNk6L2udQie50d5RJd1Rl/Fa4rXcTztSA4MkXRHH2maObctXUIO?=
 =?us-ascii?Q?7NIBqYGwU0DO29D7JjhvU8Pzd1R4Msian8zBIPd7tWV8YytATp8N49fu+Z6A?=
 =?us-ascii?Q?CQbtHpQGt66dN0VG/24ojlHp6BlFtjul43QSWqQHlDXk44tVGMUhKXks/U5L?=
 =?us-ascii?Q?NiIP3v0eG70+fR//Szf1w7SbiHjN1Amw5gbCZ4niT/j7U/Z+wY7PYM/Eq79p?=
 =?us-ascii?Q?ap288k0jcnVZa6CBnSCBhkiU0L+kJhiImCoaiaSCuuBCegM9f0ZQ9LhO2ek/?=
 =?us-ascii?Q?RjlCYCFOPWhdBYwqOkwldtIlIb+AgrqF8c0D3sEWh7fWXKuu7ulKesLhtpT7?=
 =?us-ascii?Q?ddSp+woFwBs7Dy9XxhP8nC1Lm3vORm3QxJW3tPsK117IV0ruuodedtif+f9M?=
 =?us-ascii?Q?cn341tgoCNKsOuvHF5+DRGjneZnnrJZs8AOga805ORaNITJA86L3+odFKrWj?=
 =?us-ascii?Q?0j1ivl0b8ty5wruzRTgzwvzhtyfyvcYh5T58BWGVfysY8WAEVXK+AazwA20c?=
 =?us-ascii?Q?dNO1AVemfvszYrTBU19O9hzsRtyq2ftxPrILwW3j7UHMCGCn0bbbwM8aV8jh?=
 =?us-ascii?Q?EVafoF3a9mWAga5ICDJuQ2MzvnGNyojtkKb9Dus+Rw+TV/qJMHp84etyZY+k?=
 =?us-ascii?Q?KELA5xytQcOnq0rGIXeuWIn9MygPbOgqj83UReiAqnGYezXl2gMUnJAg+TPj?=
 =?us-ascii?Q?yLpsVaIONul1j3UYluZT3naJlJp/5BgHPO5hKTSFrqiDlMpdYyNV/G6nL3Lw?=
 =?us-ascii?Q?ecTWE9SNxlZAOHK1vnkXfVxpRSjF7AjhSAk60VwUmmANl8Bm2uIkVsEbLzGS?=
 =?us-ascii?Q?1y3khUF7hfXkzIhLdOh5HsLpkWl0WlUIt2yAN9ODlaInxn6+7hRm5tm27kC1?=
 =?us-ascii?Q?ePSN/zqcFAFPBEDjZ34fKR6hb5OeBU6Ljkm1UZjsF5zli+0oAElWI1UHGlqS?=
 =?us-ascii?Q?AVmd01/MV9+mTCKXjfvz6JXrhRGcM/mnwUIwAq1zK8ZdSgb55Wk+DKU47oMV?=
 =?us-ascii?Q?fmhFO/y1XZvb9a8EkFFlnK+QPFHZc40AEmJQiWbbMPoArCxbne8aMhge+U02?=
 =?us-ascii?Q?6Uh8/VRwUCV0giUxi+8QnJQti0qv1IG0myt3rQUc7HONcUFrO1cx3RKFF5la?=
 =?us-ascii?Q?Ud4wBL9JuR7sewaEFfYKGvfX1zF52eAjK1WU7iVV2u8sRYJR6yx0VGaYmBhO?=
 =?us-ascii?Q?JlbL24Kam0bWuvvoAg9ud2fi82R3EnGjjZLGdSryomFcCyT6EErH3f6ymlNU?=
 =?us-ascii?Q?ftxpIX6FOM4yEpGHBYumRkyB+10RtFJBP5ShsEfq6slMqJl7b15yPlX2B7WQ?=
 =?us-ascii?Q?WFCt3OpfxvxEthQfcILa8SsDhZY4pXgDrjHH1na/cuMTwQLkb4CFXcivxPjs?=
 =?us-ascii?Q?krDYumaDBXQb9u9SGFOIDPfG9VX0z8ns++zUtqj+DMVhvRUdHivEiNyP2XUP?=
 =?us-ascii?Q?226Iz4CWI3vvYcHh8NOVXNCn0TXbPyiwlWeV2MXqp1qe/ncgsst0xDF31SEk?=
 =?us-ascii?Q?xYSDXcQZLOF/rKxaUX05Q/VVpMJOIoir20P71BP/VCyenmIDtw+nXBrec+o9?=
 =?us-ascii?Q?KRVczgj1hR2WLkw/fQbyUx0AuhHLGMq4knEBxmtOGYWZm369fiijZRxmlNB3?=
 =?us-ascii?Q?6PjlTrK1zQ8AX8538vFA3kUNw9pZcwWViNGgzHvSIfB1/gm/iKIgp7L2kzx4?=
 =?us-ascii?Q?pfrFXiqb1TSCmgngCyIYPKMY+h+LY7U=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac75a6e8-62da-422a-ff79-08da3d79d5b0
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:37:51.3392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBKh2/1WLVOiF26KfgWqZpV11OB80sIy4AYLUSNUqVDguV3EF75cDyzUJYJf5xGVoszUS9GVrm0+c1lMtYGHzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0305
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
 drivers/net/wireless/celeno/cl8k/channel.h | 401 +++++++++++++++++++++
 1 file changed, 401 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/channel.h

diff --git a/drivers/net/wireless/celeno/cl8k/channel.h b/drivers/net/wireless/celeno/cl8k/channel.h
new file mode 100644
index 000000000000..aec65b2d1b19
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/channel.h
@@ -0,0 +1,401 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_CHANNEL_H
+#define CL_CHANNEL_H
+
+#include <linux/types.h>
+#include <uapi/linux/nl80211.h>
+#include <net/cfg80211.h>
+
+#include "def.h"
+
+enum bitmap_chan_idx_6g {
+	b6g_ch1,
+	b6g_ch2,
+	b6g_ch5,
+	b6g_ch9,
+	b6g_ch13,
+	b6g_ch17,
+	b6g_ch21,
+	b6g_ch25,
+	b6g_ch29,
+	b6g_ch33,
+	b6g_ch37,
+	b6g_ch41,
+	b6g_ch45,
+	b6g_ch49,
+	b6g_ch53,
+	b6g_ch57,
+	b6g_ch61,
+	b6g_ch65,
+	b6g_ch69,
+	b6g_ch73,
+	b6g_ch77,
+	b6g_ch81,
+	b6g_ch85,
+	b6g_ch89,
+	b6g_ch93,
+	b6g_ch97,
+	b6g_ch101,
+	b6g_ch105,
+	b6g_ch109,
+	b6g_ch113,
+	b6g_ch117,
+	b6g_ch121,
+	b6g_ch125,
+	b6g_ch129,
+	b6g_ch133,
+	b6g_ch137,
+	b6g_ch141,
+	b6g_ch145,
+	b6g_ch149,
+	b6g_ch153,
+	b6g_ch157,
+	b6g_ch161,
+	b6g_ch165,
+	b6g_ch169,
+	b6g_ch173,
+	b6g_ch177,
+	b6g_ch181,
+	b6g_ch185,
+	b6g_ch189,
+	b6g_ch193,
+	b6g_ch197,
+	b6g_ch201,
+	b6g_ch205,
+	b6g_ch209,
+	b6g_ch213,
+	b6g_ch217,
+	b6g_ch221,
+	b6g_ch225,
+	b6g_ch229,
+	b6g_ch233,
+
+	NUM_BITMAP_CHANNELS_6G
+};
+
+enum ext_chan_idx_6g {
+	ext_b6g_ch1,
+	ext_b6g_ch2,
+	ext_b6g_ch3,
+	ext_b6g_ch5,
+	ext_b6g_ch7,
+	ext_b6g_ch9,
+	ext_b6g_ch11,
+	ext_b6g_ch13,
+	ext_b6g_ch15,
+	ext_b6g_ch17,
+	ext_b6g_ch19,
+	ext_b6g_ch21,
+	ext_b6g_ch23,
+	ext_b6g_ch25,
+	ext_b6g_ch27,
+	ext_b6g_ch29,
+	ext_b6g_ch31,
+	ext_b6g_ch33,
+	ext_b6g_ch35,
+	ext_b6g_ch37,
+	ext_b6g_ch39,
+	ext_b6g_ch41,
+	ext_b6g_ch43,
+	ext_b6g_ch45,
+	ext_b6g_ch47,
+	ext_b6g_ch49,
+	ext_b6g_ch51,
+	ext_b6g_ch53,
+	ext_b6g_ch55,
+	ext_b6g_ch57,
+	ext_b6g_ch59,
+	ext_b6g_ch61,
+	ext_b6g_ch63,
+	ext_b6g_ch65,
+	ext_b6g_ch67,
+	ext_b6g_ch69,
+	ext_b6g_ch71,
+	ext_b6g_ch73,
+	ext_b6g_ch75,
+	ext_b6g_ch77,
+	ext_b6g_ch79,
+	ext_b6g_ch81,
+	ext_b6g_ch83,
+	ext_b6g_ch85,
+	ext_b6g_ch87,
+	ext_b6g_ch89,
+	ext_b6g_ch91,
+	ext_b6g_ch93,
+	ext_b6g_ch95,
+	ext_b6g_ch97,
+	ext_b6g_ch99,
+	ext_b6g_ch101,
+	ext_b6g_ch103,
+	ext_b6g_ch105,
+	ext_b6g_ch107,
+	ext_b6g_ch109,
+	ext_b6g_ch111,
+	ext_b6g_ch113,
+	ext_b6g_ch115,
+	ext_b6g_ch117,
+	ext_b6g_ch119,
+	ext_b6g_ch121,
+	ext_b6g_ch123,
+	ext_b6g_ch125,
+	ext_b6g_ch127,
+	ext_b6g_ch129,
+	ext_b6g_ch131,
+	ext_b6g_ch133,
+	ext_b6g_ch135,
+	ext_b6g_ch137,
+	ext_b6g_ch139,
+	ext_b6g_ch141,
+	ext_b6g_ch143,
+	ext_b6g_ch145,
+	ext_b6g_ch147,
+	ext_b6g_ch149,
+	ext_b6g_ch151,
+	ext_b6g_ch153,
+	ext_b6g_ch155,
+	ext_b6g_ch157,
+	ext_b6g_ch159,
+	ext_b6g_ch161,
+	ext_b6g_ch163,
+	ext_b6g_ch165,
+	ext_b6g_ch167,
+	ext_b6g_ch169,
+	ext_b6g_ch171,
+	ext_b6g_ch173,
+	ext_b6g_ch175,
+	ext_b6g_ch177,
+	ext_b6g_ch179,
+	ext_b6g_ch181,
+	ext_b6g_ch183,
+	ext_b6g_ch185,
+	ext_b6g_ch187,
+	ext_b6g_ch189,
+	ext_b6g_ch191,
+	ext_b6g_ch193,
+	ext_b6g_ch195,
+	ext_b6g_ch197,
+	ext_b6g_ch199,
+	ext_b6g_ch201,
+	ext_b6g_ch203,
+	ext_b6g_ch205,
+	ext_b6g_ch207,
+	ext_b6g_ch209,
+	ext_b6g_ch211,
+	ext_b6g_ch213,
+	ext_b6g_ch215,
+	ext_b6g_ch217,
+	ext_b6g_ch219,
+	ext_b6g_ch221,
+	ext_b6g_ch223,
+	ext_b6g_ch225,
+	ext_b6g_ch227,
+	ext_b6g_ch229,
+	ext_b6g_ch231,
+	ext_b6g_ch233,
+
+	NUM_EXT_CHANNELS_6G
+};
+
+enum chan_idx_5g {
+	b5g_ch36,
+	b5g_ch38,
+	b5g_ch40,
+	b5g_ch42,
+	b5g_ch44,
+	b5g_ch46,
+	b5g_ch48,
+	b5g_ch50,
+	b5g_ch52,
+	b5g_ch54,
+	b5g_ch56,
+	b5g_ch58,
+	b5g_ch60,
+	b5g_ch62,
+	b5g_ch64,
+	b5g_ch100,
+	b5g_ch102,
+	b5g_ch104,
+	b5g_ch106,
+	b5g_ch108,
+	b5g_ch110,
+	b5g_ch112,
+	b5g_ch114,
+	b5g_ch116,
+	b5g_ch118,
+	b5g_ch120,
+	b5g_ch122,
+	b5g_ch124,
+	b5g_ch126,
+	b5g_ch128,
+	b5g_ch132,
+	b5g_ch134,
+	b5g_ch136,
+	b5g_ch138,
+	b5g_ch140,
+	b5g_ch142,
+	b5g_ch144,
+	b5g_ch149,
+	b5g_ch151,
+	b5g_ch153,
+	b5g_ch155,
+	b5g_ch157,
+	b5g_ch159,
+	b5g_ch161,
+	b5g_ch165,
+
+	NUM_CHANNELS_5G
+};
+
+enum chan_idx_24g {
+	b24g_ch1,
+	b24g_ch2,
+	b24g_ch3,
+	b24g_ch4,
+	b24g_ch5,
+	b24g_ch6,
+	b24g_ch7,
+	b24g_ch8,
+	b24g_ch9,
+	b24g_ch10,
+	b24g_ch11,
+	b24g_ch12,
+	b24g_ch13,
+	b24g_ch14,
+
+	NUM_CHANNELS_24G
+};
+
+/* 6g band has the largest list */
+#define MAX_CHANNELS        NUM_BITMAP_CHANNELS_6G
+#define MAX_EXT_CHANNELS    NUM_EXT_CHANNELS_6G
+#define START_CHAN_IDX_6G   1
+
+/* 1 ==> 5955 */
+#define FREQ6G(_chan) ((_chan) == 2 ? 5935 : 5950 + 5 * (_chan))
+/* 36 ==> 5180 */
+#define FREQ5G(_chan) (5000 + 5 * (_chan))
+/* 1 ==> 2412 */
+#define FREQ2G(_chan) ((_chan) == 14 ? 2484 : 2407 + (_chan) *  5)
+#define CHAN_BITMAP_IDX_6G_2_EXT_IDX(_idx) ((_idx) ? ((_idx) << 1) - 1 : 0)
+#define CHAN_EXT_IDX_6G_2_BITMAP_IDX(_ext_idx) (((_ext_idx) + 1) >> 1)
+
+/* 6G channels - UNII-5 */
+#define START_CHAN_IDX_UNII5 1
+#define END_CHAN_IDX_UNII5   85
+/* 6G channels - UNII-6 */
+#define START_CHAN_IDX_UNII6 89
+#define END_CHAN_IDX_UNII6   109
+/* 6G channels - UNII-7 */
+#define START_CHAN_IDX_UNII7 113
+#define END_CHAN_IDX_UNII7   165
+/* 6G channels - UNII-8 */
+#define START_CHAN_IDX_UNII8 169
+#define END_CHAN_IDX_UNII8   233
+
+#define INVALID_CHAN_IDX 0xff
+
+#ifndef IEEE80211_DFS_WEATHER_MIN_CAC_TIME_MS
+#define IEEE80211_DFS_WEATHER_MIN_CAC_TIME_MS 600000
+#endif
+
+struct cl_hw;
+
+u8 cl_channel_to_ext_index_6g(struct cl_hw *cl_hw, u32 channel);
+u8 cl_channel_to_index(struct cl_hw *cl_hw, u32 channel);
+u8 cl_channel_to_bitmap_index(struct cl_hw *cl_hw, u32 channel);
+u16 cl_channel_ext_idx_to_freq_6g(struct cl_hw *cl_hw, u8 index);
+u16 cl_channel_idx_to_freq(struct cl_hw *cl_hw, u8 index);
+bool cl_channel_is_valid(struct cl_hw *cl_hw, u8 channel);
+u32 cl_channel_num(struct cl_hw *cl_hw);
+bool cl_channel_is_dfs(struct cl_hw *cl_hw, u8 channel);
+u32 cl_channel_get_cac_time_ms(struct cl_hw *cl_hw, u8 channel);
+
+#define CL_MAX_STR_BUFFER_SIZE 1024
+
+#define CL_DEFAULT_CHANNEL_POWER_Q8 (30 << 8)
+
+#define CL_20MHZ_CH_GAP  4
+#define CL_40MHZ_CH_GAP  8
+#define CL_80MHZ_CH_GAP  16
+#define CL_160MHZ_CH_GAP 32
+#define CL_40MHZ_HOP     2
+#define CL_80MHZ_HOP     4
+#define CL_160MHZ_HOP    8
+
+struct cl_chan_info {
+	u8 channel;
+	u8 max_bw;
+	/* Resolution of 0.25dB */
+	u8 max_power_q2; /* MIN(country_max_power_q2, hardware_max_power_q2) */
+	u8 country_max_power_q2;
+	u8 hardware_max_power_q2;
+	u32 flags; /* channel flags from &enum ieee80211_channel_flags */
+	unsigned int dfs_cac_ms;
+};
+
+struct cl_channel_info {
+	bool use_channel_info;
+	struct cl_chan_info channels[CHNL_BW_MAX][MAX_CHANNELS];
+	enum nl80211_dfs_regions standard;
+	struct ieee80211_regdomain *rd;
+};
+
+void cl_chan_info_init(struct cl_hw *cl_hw);
+void cl_chan_info_deinit(struct cl_hw *cl_hw);
+struct cl_chan_info *cl_chan_info_get(struct cl_hw *cl_hw, u8 channel, u8 bw);
+u8 cl_chan_info_get_max_bw(struct cl_hw *cl_hw, u8 channel);
+s16 cl_chan_info_get_eirp_limit_q8(struct cl_hw *cl_hw, u8 bw);
+u8 cl_chan_info_get_max_power(struct cl_hw *cl_hw, u8 channel);
+void cl_chan_update_channels_info(struct cl_hw *cl_hw,
+				  const struct ieee80211_supported_band *cfg_band);
+int cl_chandef_calc(struct cl_hw *cl_hw, u32 channel, u32 bw,
+		    enum nl80211_chan_width *width, u32 *primary, u32 *center);
+int cl_chandef_get_default(struct cl_hw *cl_hw, u32 *channel, u8 *bw,
+			   enum nl80211_chan_width *width,
+			   u32 *primary, u32 *center);
+
+struct cl_channel_stats {
+	bool scan_enabled;
+	u8 channel;
+	enum cl_channel_bw scan_bw;
+
+	s8 avg_snr;
+	s8 avg_non_wifi_noise;
+	u32 avg_channel_util;
+	u32 avg_retry_rate;
+	u32 total_frames;
+	u32 total_retries;
+	u32 vendor_specific;
+
+	/* Time radio spent rx on channel + non wifi noise */
+	u64 edca_cca_time;
+	u64 edca_cca_time_total;
+
+	/* Time radio detected that channel was busy (Busy = Rx + Tx + Interference) */
+	u64 util_time_busy;
+
+	/* Time radio spent tx on channel */
+	u64 util_time_tx;
+	u64 util_time_tx_total;
+
+	/* Time radio spent rx on channel (Rx = Rx_obss + Rx_self + Rx_errr (self and obss errs) */
+	u64 util_time_rx;
+	u64 util_time_rx_total;
+
+	s8 ch_noise;
+
+	u64 scan_start_jiffies;
+	u32 scan_time_ms;
+
+	/* Currently this metric can't be calculated because fromat_mod in rxheader is always 0 */
+	/* u64 util_time_self; */
+};
+
+int cl_init_channel_stats(struct cl_hw *cl_hw,
+			  struct cl_channel_stats *ch_stats, u32 freq);
+void cl_get_final_channel_stats(struct cl_hw *cl_hw, struct cl_channel_stats *ch_stats);
+void cl_get_initial_channel_stats(struct cl_hw *cl_hw, struct cl_channel_stats *ch_stats);
+
+#endif /* CL_CHANNEL_H */
-- 
2.36.1

