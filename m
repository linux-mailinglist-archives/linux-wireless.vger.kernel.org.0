Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBA5532938
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbiEXLiF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236773AbiEXLiD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:38:03 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A90D8CB3D
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:37:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlYKdxQTfsFtCrMoPbhvuNIco4X0EOa3b3kKL6J2CqyE0JVmtMlst8omIrRrCmdy6rsT331qqLIRBRchGbNl9h9CUIZVaulRwLaF8FSx7jlApRVTimBSODFQob2geXP+rB2PbNh0j05bkj0T9kNPBnilJeim8Hf6N5yTafx73typvTNaMdoFCMJ56y9rUKC4d0Fd5hh95K0QBH2No/Faec6DxL+BA/GXEeubvTqhsn1dBWOeuKtDuiElbTqs4LMuridIcKFLxvmGxQXFl4qyBA1Z9LR7kYUgV2vdQdRbA662RbD3vfq+Yn646aI/4hTxvxhnv7Jv7XQVf8kYBH2wEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GlnspchVv5AHBSQqu5yoZUXIRzjxSemY+DHvskgNa8=;
 b=K6z9MnhhBETXk1lWwr1Akve+ayZn/9bcSlcPQ0zPYKOzqnrdpBRw7VNWIuDs/CYxVVxr/hgsEt0Cl1ZvQMWkBBfosuBFKb+H2vSFS/yWsP0x0kSPUq+t9dEqOD7X8lFZ8mLFbZ2JgIOjtHTsMATXIbmfKn3UAmu+BmEyXUGmj2cl8kEM1oR4Cmzdn7tOz+j5pYbFKRsA23jF+B+BMtI6aAqL3No8t03SCpP5ggBiPyk1iqyKI3DqueDxyZUZweP8GL4qRO91EhIu3jfRgojZ4tIOF9DuLdrPBxQFONGV/ru9IDL6AJyWobKtJ8zX8TpKZjJq/RJgANn4YcD7i/tiGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GlnspchVv5AHBSQqu5yoZUXIRzjxSemY+DHvskgNa8=;
 b=aXMZEUhEBvcL8OPC4+R/4iwpkGADnjlRkZHCu4Rg1DMJtzUnSH0uabCdvemRDtx/qSGnRKEQsNRr/0juHV0EhhkpcSyfsr9zuS8TqxKOnEtfMl4ZbAN9RjnBn+B4IDw1mJjjP/c+JM4bjUsFbzA/bvB7SZxpbYp/mYYm5S8Em1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0305.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 11:37:50 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:37:50 +0000
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
Subject: [RFC v2 11/96] cl8k: add channel.c
Date:   Tue, 24 May 2022 14:33:37 +0300
Message-Id: <20220524113502.1094459-12-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8f23b0ff-89b7-4550-637c-08da3d79d3dd
X-MS-TrafficTypeDiagnostic: AM0P192MB0305:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM0P192MB0305AC66D84AAC167707A284F6D79@AM0P192MB0305.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DpmwIsn2PcGDvV6cIwScEhKns9qIJCbzsJ+Tn0hlHmKKMt6/eMBozgGa3H1vi1Nle5pOcQOU37YhTD70ZyocGWNCNJ6PzNFwmwSFsSUO/UukCnflX8l8x6kH/pLUOyzEEGFY0wrhAgUBC/91tQXMSK+4HF1iU9nnrO2hwMrDkcZhMM3eOYCc8c649t2BFHPInGxDNUb/r/piV+mdk3piRgpVy9fMG/7ZblrbA/qaGryq/ErUg4lr+KYCdsyssuInXWKpTRku/Xa9tpnQIcF2Q37LvaGgIbHoykh7hoZPD5VPd7z8sLK/8ySll8r6SPQL8fsbZSDP9mw52q1jsmTDog9KteneLcD35aEdBTI9aLe/3zrePCLqLR5/4oRHlf594Pgw9MgcXqKCgcmvGsap9KnjhAcv6sw0wgmVurMJxrUNdtR3PuO4ecd9L0tvIaBzKBTIqPPaqQANz99HxQj3s8ZBrNZ6E9zWVgPz9T6JTVX/a91YDEYuFegTNUgDRBdRnf+4LSPs4QmuWIpgr6rCWRQsgws81RW5OUYgB73uMM5Td9bu/b0qqU72o9tCPrQV0RWWBYQQg3utFMq7pwpgpnhZdcnSv0Im1vaXjmbkdXNcw/hdZ51QuPg9SJLhryShHeLaoDBc+exUGaz5mTZdi/QbGCSziSswLFsoTeBhSaKh0sd4zu7rfTPrP0v40zPTwV7Lzm+Aw+YgNFGuWRkDM/uDW0l2/99IJMlUPeQS8vk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(346002)(396003)(366004)(39850400004)(376002)(136003)(6486002)(6916009)(508600001)(38350700002)(38100700002)(52116002)(6666004)(2906002)(8936002)(54906003)(6512007)(6506007)(26005)(9686003)(30864003)(8676002)(36756003)(5660300002)(316002)(66476007)(4326008)(66556008)(107886003)(66946007)(1076003)(41300700001)(186003)(2616005)(83380400001)(86362001)(32563001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WVWvwrJ0qGwG9ro0q61K9HqUG9lLcadMLVe/KhJ0eTfXhr3mL4pogfj4ipjn?=
 =?us-ascii?Q?EMBJBqFn0U7iBhbe9+8PWxqK+wcztW0mlWcvUdxbglJVp5UuOWK2NwpH0n7N?=
 =?us-ascii?Q?bPOTrLOReMhcloUXWRBIgeiA0vxpY4xm5yDoDnQG4TsSPOi2MHicJgwuNBjP?=
 =?us-ascii?Q?Y4Y5uMBLxq7H/TqBiqBHkcem9lMuIsR/etzs06EKpw+om5gSpFn4I16WOJNc?=
 =?us-ascii?Q?E/YtRe06xFhs3DW8dYz11dq9yRuHYVEAcUsXauT4/+qDtv28oBMnHf28zJwx?=
 =?us-ascii?Q?Z6c1adbkxE+yh4upGCjj4yCKqcFaQjsspIvju0aAFWQqsHJjPF6EOQN3sQ6V?=
 =?us-ascii?Q?JLYd67z4bKaT1pk0jkQ8mXra3A6HcZ7Z846+Oil7QDU12NFdxF1luHzeiqbh?=
 =?us-ascii?Q?RPpTjdao+b9Akvu6IPhbJSLNkUy7kyCKcDjhU4/2vh5965YxMER/BSeGXOJT?=
 =?us-ascii?Q?BZLpuoafstwVC5JCYQ8G5Z85lIQ38lOz4CIeRRS2b0otIpuZ5wZ+wOw50IYI?=
 =?us-ascii?Q?uMZKWfMKqtPX5hx0L0+eaolMnR130s7VeYdN3sCnwl+kBUCP9YkVVpmazDUs?=
 =?us-ascii?Q?uvBe8EnjsG+8HldNbrbENRaL/c8PjxvDJrY0n9HAUA5HyBTpk8Rfos+eqav0?=
 =?us-ascii?Q?dWN60um5bu6QNsb/PLIPjm2KicHXF16OBFCIZlvMMZlvmlQ0mgkJJHbi1nRo?=
 =?us-ascii?Q?3z8zRi7aEFGOomJeDYgejaQsueuO9e7vtaZoFk8hBofDWzhYsWlNeSscBQAR?=
 =?us-ascii?Q?+JFsFdXgY6/vqPsbptRFNK9DB8YKQ/XheM641N3JAN31evVX3Sn/2lxmToWn?=
 =?us-ascii?Q?npa7ehDToC4/7XUAHLUvHRryC+nmi+SWabCcI4i+SaeME6EjcRssgWbBy2L5?=
 =?us-ascii?Q?2EaPQsrabMs3k0fmUUVvafn7VXcAN/ojJZfjZXHht7saLK3jnmwz1/+DVJnA?=
 =?us-ascii?Q?2NYVSGLEtr1Utrm4+QSc+Zp9n6LimNIi3BewkUx50OxgE+KbIve1FzycL97L?=
 =?us-ascii?Q?eX4RhRXcnSqtvFGgJLv6dc5SoZLwGvqBDQ1TmHEC/gQXunV1qNFvGNlHZn6h?=
 =?us-ascii?Q?vevK5vtkUQf148R/0l/4Qqozc0qryt4CG3NOewLb0sV1Onq0dJ8laQsHKxSv?=
 =?us-ascii?Q?ZOKu/Uy1W/7cAFhHN3A4/+F+UYSwcIyRFFWePV2l9y/WfpbliXb74JI0MP5i?=
 =?us-ascii?Q?bo5Qz4mQe557ezrwn8QTmu23huIpVkYrYY2OJytQtMANxUjYI76Jj5FAKM5B?=
 =?us-ascii?Q?j/sCHIfxOs0EcNuO/PAJFrbPXti7wl1e6A7ZnWZYvum93lIsxddXJHSFidIf?=
 =?us-ascii?Q?oFGQDNaiQfqaoqW9wlVesltGlIzgbfH3yMGDTNn5UgSAo07Ov7A8grbMqrgi?=
 =?us-ascii?Q?UYwLCdBM9SFlR+urxqifjqe7ZlY3falv1WfwYRHgsFP+XmGFaPP8fN3QCkv5?=
 =?us-ascii?Q?19/4ipbhVvaGalTqa0Houz1x0OMrabs9/j8KsiYBw89LX+hNfPKXqhtbxGHd?=
 =?us-ascii?Q?D8YP8cjUJgIdsK1nWL8I1JdPcWMujwQ4dnmuxwO7vSmQ+Gn9EhzTcqip1uAf?=
 =?us-ascii?Q?fAr3USVyec+9CqS7wQkUYfS2spC1fPFxs+AvfuCzciLZQ2Q+dWx+4RiqM18P?=
 =?us-ascii?Q?Kmzb1HIEgEUg3ZIJxAC7FneOaV9nLSUe4t4xoMUOeRYGt12n8YPt4Sv7KB6D?=
 =?us-ascii?Q?fLutkMAfGZvP7n+SuiHp7b9MsfGeEx/l+0ylkLMUX7ZKUT/TBo7Qwh/1yLDy?=
 =?us-ascii?Q?Q2YL5m1pzUTMYbPWPW21soiecBzM8dk=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f23b0ff-89b7-4550-637c-08da3d79d3dd
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:37:50.5557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ew+2t3blf0KtpkmvKd299suhyQZl6+yKHDz4T/ViyzyjWTsILUAM3SLFv59KweHyHCWGmAHd0XEvy7z7Iwg2Rw==
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
 drivers/net/wireless/celeno/cl8k/channel.c | 1656 ++++++++++++++++++++
 1 file changed, 1656 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/channel.c

diff --git a/drivers/net/wireless/celeno/cl8k/channel.c b/drivers/net/wireless/celeno/cl8k/channel.c
new file mode 100644
index 000000000000..777c5f749059
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/channel.c
@@ -0,0 +1,1656 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include "vif.h"
+#include "dfs.h"
+#include "reg/reg_defs.h"
+#include "hw.h"
+#include "utils.h"
+#include "channel.h"
+
+#define CASE_CHAN2BITMAP_IDX_6G(_chan) { case _chan: return (b6g_ch ## _chan); }
+#define CASE_CHAN2EXT_IDX_6G(_chan) { case _chan: return (ext_b6g_ch ## _chan); }
+#define CASE_CHAN2IDX_5G(_chan) { case _chan: return (b5g_ch ## _chan); }
+#define CASE_CHAN2IDX_2G(_chan) { case _chan: return (b24g_ch ## _chan); }
+
+#define CASE_BITMAP_IDX2FREQ_6G(_chan) { case (b6g_ch ## _chan): return FREQ6G(_chan); }
+#define CASE_EXT_IDX2FREQ_6G(_chan) { case (ext_b6g_ch ## _chan): return FREQ6G(_chan); }
+#define CASE_IDX2FREQ_5G(_chan) { case (b5g_ch ## _chan): return FREQ5G(_chan); }
+#define CASE_IDX2FREQ_2G(_chan) { case (b24g_ch ## _chan): return FREQ2G(_chan); }
+
+#define INVALID_FREQ 0xffff
+
+static u8 cl_channel_to_bitmap_index_6g(struct cl_hw *cl_hw, u32 channel)
+{
+	switch (channel) {
+	CASE_CHAN2BITMAP_IDX_6G(1);
+	CASE_CHAN2BITMAP_IDX_6G(2);
+	CASE_CHAN2BITMAP_IDX_6G(5);
+	CASE_CHAN2BITMAP_IDX_6G(9);
+	CASE_CHAN2BITMAP_IDX_6G(13);
+	CASE_CHAN2BITMAP_IDX_6G(17);
+	CASE_CHAN2BITMAP_IDX_6G(21);
+	CASE_CHAN2BITMAP_IDX_6G(25);
+	CASE_CHAN2BITMAP_IDX_6G(29);
+	CASE_CHAN2BITMAP_IDX_6G(33);
+	CASE_CHAN2BITMAP_IDX_6G(37);
+	CASE_CHAN2BITMAP_IDX_6G(41);
+	CASE_CHAN2BITMAP_IDX_6G(45);
+	CASE_CHAN2BITMAP_IDX_6G(49);
+	CASE_CHAN2BITMAP_IDX_6G(53);
+	CASE_CHAN2BITMAP_IDX_6G(57);
+	CASE_CHAN2BITMAP_IDX_6G(61);
+	CASE_CHAN2BITMAP_IDX_6G(65);
+	CASE_CHAN2BITMAP_IDX_6G(69);
+	CASE_CHAN2BITMAP_IDX_6G(73);
+	CASE_CHAN2BITMAP_IDX_6G(77);
+	CASE_CHAN2BITMAP_IDX_6G(81);
+	CASE_CHAN2BITMAP_IDX_6G(85);
+	CASE_CHAN2BITMAP_IDX_6G(89);
+	CASE_CHAN2BITMAP_IDX_6G(93);
+	CASE_CHAN2BITMAP_IDX_6G(97);
+	CASE_CHAN2BITMAP_IDX_6G(101);
+	CASE_CHAN2BITMAP_IDX_6G(105);
+	CASE_CHAN2BITMAP_IDX_6G(109);
+	CASE_CHAN2BITMAP_IDX_6G(113);
+	CASE_CHAN2BITMAP_IDX_6G(117);
+	CASE_CHAN2BITMAP_IDX_6G(121);
+	CASE_CHAN2BITMAP_IDX_6G(125);
+	CASE_CHAN2BITMAP_IDX_6G(129);
+	CASE_CHAN2BITMAP_IDX_6G(133);
+	CASE_CHAN2BITMAP_IDX_6G(137);
+	CASE_CHAN2BITMAP_IDX_6G(141);
+	CASE_CHAN2BITMAP_IDX_6G(145);
+	CASE_CHAN2BITMAP_IDX_6G(149);
+	CASE_CHAN2BITMAP_IDX_6G(153);
+	CASE_CHAN2BITMAP_IDX_6G(157);
+	CASE_CHAN2BITMAP_IDX_6G(161);
+	CASE_CHAN2BITMAP_IDX_6G(165);
+	CASE_CHAN2BITMAP_IDX_6G(169);
+	CASE_CHAN2BITMAP_IDX_6G(173);
+	CASE_CHAN2BITMAP_IDX_6G(177);
+	CASE_CHAN2BITMAP_IDX_6G(181);
+	CASE_CHAN2BITMAP_IDX_6G(185);
+	CASE_CHAN2BITMAP_IDX_6G(189);
+	CASE_CHAN2BITMAP_IDX_6G(193);
+	CASE_CHAN2BITMAP_IDX_6G(197);
+	CASE_CHAN2BITMAP_IDX_6G(201);
+	CASE_CHAN2BITMAP_IDX_6G(205);
+	CASE_CHAN2BITMAP_IDX_6G(209);
+	CASE_CHAN2BITMAP_IDX_6G(213);
+	CASE_CHAN2BITMAP_IDX_6G(217);
+	CASE_CHAN2BITMAP_IDX_6G(221);
+	CASE_CHAN2BITMAP_IDX_6G(225);
+	CASE_CHAN2BITMAP_IDX_6G(229);
+	CASE_CHAN2BITMAP_IDX_6G(233);
+	};
+
+	return INVALID_CHAN_IDX;
+}
+
+u8 cl_channel_to_ext_index_6g(struct cl_hw *cl_hw, u32 channel)
+{
+	switch (channel) {
+	CASE_CHAN2EXT_IDX_6G(1);
+	CASE_CHAN2EXT_IDX_6G(2);
+	CASE_CHAN2EXT_IDX_6G(3);
+	CASE_CHAN2EXT_IDX_6G(5);
+	CASE_CHAN2EXT_IDX_6G(7);
+	CASE_CHAN2EXT_IDX_6G(9);
+	CASE_CHAN2EXT_IDX_6G(11);
+	CASE_CHAN2EXT_IDX_6G(13);
+	CASE_CHAN2EXT_IDX_6G(15);
+	CASE_CHAN2EXT_IDX_6G(17);
+	CASE_CHAN2EXT_IDX_6G(19);
+	CASE_CHAN2EXT_IDX_6G(21);
+	CASE_CHAN2EXT_IDX_6G(23);
+	CASE_CHAN2EXT_IDX_6G(25);
+	CASE_CHAN2EXT_IDX_6G(27);
+	CASE_CHAN2EXT_IDX_6G(29);
+	CASE_CHAN2EXT_IDX_6G(31);
+	CASE_CHAN2EXT_IDX_6G(33);
+	CASE_CHAN2EXT_IDX_6G(35);
+	CASE_CHAN2EXT_IDX_6G(37);
+	CASE_CHAN2EXT_IDX_6G(39);
+	CASE_CHAN2EXT_IDX_6G(41);
+	CASE_CHAN2EXT_IDX_6G(43);
+	CASE_CHAN2EXT_IDX_6G(45);
+	CASE_CHAN2EXT_IDX_6G(47);
+	CASE_CHAN2EXT_IDX_6G(49);
+	CASE_CHAN2EXT_IDX_6G(51);
+	CASE_CHAN2EXT_IDX_6G(53);
+	CASE_CHAN2EXT_IDX_6G(55);
+	CASE_CHAN2EXT_IDX_6G(57);
+	CASE_CHAN2EXT_IDX_6G(59);
+	CASE_CHAN2EXT_IDX_6G(61);
+	CASE_CHAN2EXT_IDX_6G(63);
+	CASE_CHAN2EXT_IDX_6G(65);
+	CASE_CHAN2EXT_IDX_6G(67);
+	CASE_CHAN2EXT_IDX_6G(69);
+	CASE_CHAN2EXT_IDX_6G(71);
+	CASE_CHAN2EXT_IDX_6G(73);
+	CASE_CHAN2EXT_IDX_6G(75);
+	CASE_CHAN2EXT_IDX_6G(77);
+	CASE_CHAN2EXT_IDX_6G(79);
+	CASE_CHAN2EXT_IDX_6G(81);
+	CASE_CHAN2EXT_IDX_6G(83);
+	CASE_CHAN2EXT_IDX_6G(85);
+	CASE_CHAN2EXT_IDX_6G(87);
+	CASE_CHAN2EXT_IDX_6G(89);
+	CASE_CHAN2EXT_IDX_6G(91);
+	CASE_CHAN2EXT_IDX_6G(93);
+	CASE_CHAN2EXT_IDX_6G(95);
+	CASE_CHAN2EXT_IDX_6G(97);
+	CASE_CHAN2EXT_IDX_6G(99);
+	CASE_CHAN2EXT_IDX_6G(101);
+	CASE_CHAN2EXT_IDX_6G(103);
+	CASE_CHAN2EXT_IDX_6G(105);
+	CASE_CHAN2EXT_IDX_6G(107);
+	CASE_CHAN2EXT_IDX_6G(109);
+	CASE_CHAN2EXT_IDX_6G(111);
+	CASE_CHAN2EXT_IDX_6G(113);
+	CASE_CHAN2EXT_IDX_6G(115);
+	CASE_CHAN2EXT_IDX_6G(117);
+	CASE_CHAN2EXT_IDX_6G(119);
+	CASE_CHAN2EXT_IDX_6G(121);
+	CASE_CHAN2EXT_IDX_6G(123);
+	CASE_CHAN2EXT_IDX_6G(125);
+	CASE_CHAN2EXT_IDX_6G(127);
+	CASE_CHAN2EXT_IDX_6G(129);
+	CASE_CHAN2EXT_IDX_6G(131);
+	CASE_CHAN2EXT_IDX_6G(133);
+	CASE_CHAN2EXT_IDX_6G(135);
+	CASE_CHAN2EXT_IDX_6G(137);
+	CASE_CHAN2EXT_IDX_6G(139);
+	CASE_CHAN2EXT_IDX_6G(141);
+	CASE_CHAN2EXT_IDX_6G(143);
+	CASE_CHAN2EXT_IDX_6G(145);
+	CASE_CHAN2EXT_IDX_6G(147);
+	CASE_CHAN2EXT_IDX_6G(149);
+	CASE_CHAN2EXT_IDX_6G(151);
+	CASE_CHAN2EXT_IDX_6G(153);
+	CASE_CHAN2EXT_IDX_6G(155);
+	CASE_CHAN2EXT_IDX_6G(157);
+	CASE_CHAN2EXT_IDX_6G(159);
+	CASE_CHAN2EXT_IDX_6G(161);
+	CASE_CHAN2EXT_IDX_6G(163);
+	CASE_CHAN2EXT_IDX_6G(165);
+	CASE_CHAN2EXT_IDX_6G(167);
+	CASE_CHAN2EXT_IDX_6G(169);
+	CASE_CHAN2EXT_IDX_6G(171);
+	CASE_CHAN2EXT_IDX_6G(173);
+	CASE_CHAN2EXT_IDX_6G(175);
+	CASE_CHAN2EXT_IDX_6G(177);
+	CASE_CHAN2EXT_IDX_6G(179);
+	CASE_CHAN2EXT_IDX_6G(181);
+	CASE_CHAN2EXT_IDX_6G(183);
+	CASE_CHAN2EXT_IDX_6G(185);
+	CASE_CHAN2EXT_IDX_6G(187);
+	CASE_CHAN2EXT_IDX_6G(189);
+	CASE_CHAN2EXT_IDX_6G(191);
+	CASE_CHAN2EXT_IDX_6G(193);
+	CASE_CHAN2EXT_IDX_6G(195);
+	CASE_CHAN2EXT_IDX_6G(197);
+	CASE_CHAN2EXT_IDX_6G(199);
+	CASE_CHAN2EXT_IDX_6G(201);
+	CASE_CHAN2EXT_IDX_6G(203);
+	CASE_CHAN2EXT_IDX_6G(205);
+	CASE_CHAN2EXT_IDX_6G(207);
+	CASE_CHAN2EXT_IDX_6G(209);
+	CASE_CHAN2EXT_IDX_6G(211);
+	CASE_CHAN2EXT_IDX_6G(213);
+	CASE_CHAN2EXT_IDX_6G(215);
+	CASE_CHAN2EXT_IDX_6G(217);
+	CASE_CHAN2EXT_IDX_6G(219);
+	CASE_CHAN2EXT_IDX_6G(221);
+	CASE_CHAN2EXT_IDX_6G(223);
+	CASE_CHAN2EXT_IDX_6G(225);
+	CASE_CHAN2EXT_IDX_6G(227);
+	CASE_CHAN2EXT_IDX_6G(229);
+	CASE_CHAN2EXT_IDX_6G(231);
+	CASE_CHAN2EXT_IDX_6G(233);
+	};
+
+	return INVALID_CHAN_IDX;
+}
+
+static u8 cl_channel_to_index_5g(struct cl_hw *cl_hw, u32 channel)
+{
+	switch (channel) {
+	CASE_CHAN2IDX_5G(36);
+	CASE_CHAN2IDX_5G(38);
+	CASE_CHAN2IDX_5G(40);
+	CASE_CHAN2IDX_5G(42);
+	CASE_CHAN2IDX_5G(44);
+	CASE_CHAN2IDX_5G(46);
+	CASE_CHAN2IDX_5G(48);
+	CASE_CHAN2IDX_5G(50);
+	CASE_CHAN2IDX_5G(52);
+	CASE_CHAN2IDX_5G(54);
+	CASE_CHAN2IDX_5G(56);
+	CASE_CHAN2IDX_5G(58);
+	CASE_CHAN2IDX_5G(60);
+	CASE_CHAN2IDX_5G(62);
+	CASE_CHAN2IDX_5G(64);
+	CASE_CHAN2IDX_5G(100);
+	CASE_CHAN2IDX_5G(102);
+	CASE_CHAN2IDX_5G(104);
+	CASE_CHAN2IDX_5G(106);
+	CASE_CHAN2IDX_5G(108);
+	CASE_CHAN2IDX_5G(110);
+	CASE_CHAN2IDX_5G(112);
+	CASE_CHAN2IDX_5G(114);
+	CASE_CHAN2IDX_5G(116);
+	CASE_CHAN2IDX_5G(118);
+	CASE_CHAN2IDX_5G(120);
+	CASE_CHAN2IDX_5G(122);
+	CASE_CHAN2IDX_5G(124);
+	CASE_CHAN2IDX_5G(126);
+	CASE_CHAN2IDX_5G(128);
+	/* 130 - invalid */
+	CASE_CHAN2IDX_5G(132);
+	CASE_CHAN2IDX_5G(134);
+	CASE_CHAN2IDX_5G(136);
+	CASE_CHAN2IDX_5G(138);
+	CASE_CHAN2IDX_5G(140);
+	CASE_CHAN2IDX_5G(142);
+	CASE_CHAN2IDX_5G(144);
+	CASE_CHAN2IDX_5G(149);
+	CASE_CHAN2IDX_5G(151);
+	CASE_CHAN2IDX_5G(153);
+	CASE_CHAN2IDX_5G(155);
+	CASE_CHAN2IDX_5G(157);
+	CASE_CHAN2IDX_5G(159);
+	CASE_CHAN2IDX_5G(161);
+	/* 163 - invalid */
+	CASE_CHAN2IDX_5G(165);
+	};
+
+	return INVALID_CHAN_IDX;
+}
+
+static u8 cl_channel_to_index_24g(struct cl_hw *cl_hw, u32 channel)
+{
+	switch (channel) {
+	CASE_CHAN2IDX_2G(1);
+	CASE_CHAN2IDX_2G(2);
+	CASE_CHAN2IDX_2G(3);
+	CASE_CHAN2IDX_2G(4);
+	CASE_CHAN2IDX_2G(5);
+	CASE_CHAN2IDX_2G(6);
+	CASE_CHAN2IDX_2G(7);
+	CASE_CHAN2IDX_2G(8);
+	CASE_CHAN2IDX_2G(9);
+	CASE_CHAN2IDX_2G(10);
+	CASE_CHAN2IDX_2G(11);
+	CASE_CHAN2IDX_2G(12);
+	CASE_CHAN2IDX_2G(13);
+	CASE_CHAN2IDX_2G(14);
+	};
+
+	return INVALID_CHAN_IDX;
+}
+
+u8 cl_channel_to_index(struct cl_hw *cl_hw, u32 channel)
+{
+	/* Calculate index for a given channel */
+	if (cl_band_is_6g(cl_hw))
+		return cl_channel_to_ext_index_6g(cl_hw, channel);
+	else if (cl_band_is_5g(cl_hw))
+		return cl_channel_to_index_5g(cl_hw, channel);
+	else
+		return cl_channel_to_index_24g(cl_hw, channel);
+}
+
+u8 cl_channel_to_bitmap_index(struct cl_hw *cl_hw, u32 channel)
+{
+	/* Calculate index for a given channel */
+	if (cl_band_is_6g(cl_hw))
+		return cl_channel_to_bitmap_index_6g(cl_hw, channel);
+	else if (cl_band_is_5g(cl_hw))
+		return cl_channel_to_index_5g(cl_hw, channel);
+	else
+		return cl_channel_to_index_24g(cl_hw, channel);
+}
+
+static u16 cl_channel_bitmap_idx_to_freq_6g(struct cl_hw *cl_hw, u8 index)
+{
+	switch (index) {
+	CASE_BITMAP_IDX2FREQ_6G(1);
+	CASE_BITMAP_IDX2FREQ_6G(2);
+	CASE_BITMAP_IDX2FREQ_6G(5);
+	CASE_BITMAP_IDX2FREQ_6G(9);
+	CASE_BITMAP_IDX2FREQ_6G(13);
+	CASE_BITMAP_IDX2FREQ_6G(17);
+	CASE_BITMAP_IDX2FREQ_6G(21);
+	CASE_BITMAP_IDX2FREQ_6G(25);
+	CASE_BITMAP_IDX2FREQ_6G(29);
+	CASE_BITMAP_IDX2FREQ_6G(33);
+	CASE_BITMAP_IDX2FREQ_6G(37);
+	CASE_BITMAP_IDX2FREQ_6G(41);
+	CASE_BITMAP_IDX2FREQ_6G(45);
+	CASE_BITMAP_IDX2FREQ_6G(49);
+	CASE_BITMAP_IDX2FREQ_6G(53);
+	CASE_BITMAP_IDX2FREQ_6G(57);
+	CASE_BITMAP_IDX2FREQ_6G(61);
+	CASE_BITMAP_IDX2FREQ_6G(65);
+	CASE_BITMAP_IDX2FREQ_6G(69);
+	CASE_BITMAP_IDX2FREQ_6G(73);
+	CASE_BITMAP_IDX2FREQ_6G(77);
+	CASE_BITMAP_IDX2FREQ_6G(81);
+	CASE_BITMAP_IDX2FREQ_6G(85);
+	CASE_BITMAP_IDX2FREQ_6G(89);
+	CASE_BITMAP_IDX2FREQ_6G(93);
+	CASE_BITMAP_IDX2FREQ_6G(97);
+	CASE_BITMAP_IDX2FREQ_6G(101);
+	CASE_BITMAP_IDX2FREQ_6G(105);
+	CASE_BITMAP_IDX2FREQ_6G(109);
+	CASE_BITMAP_IDX2FREQ_6G(113);
+	CASE_BITMAP_IDX2FREQ_6G(117);
+	CASE_BITMAP_IDX2FREQ_6G(121);
+	CASE_BITMAP_IDX2FREQ_6G(125);
+	CASE_BITMAP_IDX2FREQ_6G(129);
+	CASE_BITMAP_IDX2FREQ_6G(133);
+	CASE_BITMAP_IDX2FREQ_6G(137);
+	CASE_BITMAP_IDX2FREQ_6G(141);
+	CASE_BITMAP_IDX2FREQ_6G(145);
+	CASE_BITMAP_IDX2FREQ_6G(149);
+	CASE_BITMAP_IDX2FREQ_6G(153);
+	CASE_BITMAP_IDX2FREQ_6G(157);
+	CASE_BITMAP_IDX2FREQ_6G(161);
+	CASE_BITMAP_IDX2FREQ_6G(165);
+	CASE_BITMAP_IDX2FREQ_6G(169);
+	CASE_BITMAP_IDX2FREQ_6G(173);
+	CASE_BITMAP_IDX2FREQ_6G(177);
+	CASE_BITMAP_IDX2FREQ_6G(181);
+	CASE_BITMAP_IDX2FREQ_6G(185);
+	CASE_BITMAP_IDX2FREQ_6G(189);
+	CASE_BITMAP_IDX2FREQ_6G(193);
+	CASE_BITMAP_IDX2FREQ_6G(197);
+	CASE_BITMAP_IDX2FREQ_6G(201);
+	CASE_BITMAP_IDX2FREQ_6G(205);
+	CASE_BITMAP_IDX2FREQ_6G(209);
+	CASE_BITMAP_IDX2FREQ_6G(213);
+	CASE_BITMAP_IDX2FREQ_6G(217);
+	CASE_BITMAP_IDX2FREQ_6G(221);
+	CASE_BITMAP_IDX2FREQ_6G(225);
+	CASE_BITMAP_IDX2FREQ_6G(229);
+	CASE_BITMAP_IDX2FREQ_6G(233);
+	};
+
+	return INVALID_FREQ;
+}
+
+u16 cl_channel_ext_idx_to_freq_6g(struct cl_hw *cl_hw, u8 index)
+{
+	switch (index) {
+	CASE_EXT_IDX2FREQ_6G(1);
+	CASE_EXT_IDX2FREQ_6G(2);
+	CASE_EXT_IDX2FREQ_6G(3);
+	CASE_EXT_IDX2FREQ_6G(5);
+	CASE_EXT_IDX2FREQ_6G(7);
+	CASE_EXT_IDX2FREQ_6G(9);
+	CASE_EXT_IDX2FREQ_6G(11);
+	CASE_EXT_IDX2FREQ_6G(13);
+	CASE_EXT_IDX2FREQ_6G(15);
+	CASE_EXT_IDX2FREQ_6G(17);
+	CASE_EXT_IDX2FREQ_6G(19);
+	CASE_EXT_IDX2FREQ_6G(21);
+	CASE_EXT_IDX2FREQ_6G(23);
+	CASE_EXT_IDX2FREQ_6G(25);
+	CASE_EXT_IDX2FREQ_6G(27);
+	CASE_EXT_IDX2FREQ_6G(29);
+	CASE_EXT_IDX2FREQ_6G(31);
+	CASE_EXT_IDX2FREQ_6G(33);
+	CASE_EXT_IDX2FREQ_6G(35);
+	CASE_EXT_IDX2FREQ_6G(37);
+	CASE_EXT_IDX2FREQ_6G(39);
+	CASE_EXT_IDX2FREQ_6G(41);
+	CASE_EXT_IDX2FREQ_6G(43);
+	CASE_EXT_IDX2FREQ_6G(45);
+	CASE_EXT_IDX2FREQ_6G(47);
+	CASE_EXT_IDX2FREQ_6G(49);
+	CASE_EXT_IDX2FREQ_6G(51);
+	CASE_EXT_IDX2FREQ_6G(53);
+	CASE_EXT_IDX2FREQ_6G(55);
+	CASE_EXT_IDX2FREQ_6G(57);
+	CASE_EXT_IDX2FREQ_6G(59);
+	CASE_EXT_IDX2FREQ_6G(61);
+	CASE_EXT_IDX2FREQ_6G(63);
+	CASE_EXT_IDX2FREQ_6G(65);
+	CASE_EXT_IDX2FREQ_6G(67);
+	CASE_EXT_IDX2FREQ_6G(69);
+	CASE_EXT_IDX2FREQ_6G(71);
+	CASE_EXT_IDX2FREQ_6G(73);
+	CASE_EXT_IDX2FREQ_6G(75);
+	CASE_EXT_IDX2FREQ_6G(77);
+	CASE_EXT_IDX2FREQ_6G(79);
+	CASE_EXT_IDX2FREQ_6G(81);
+	CASE_EXT_IDX2FREQ_6G(83);
+	CASE_EXT_IDX2FREQ_6G(85);
+	CASE_EXT_IDX2FREQ_6G(87);
+	CASE_EXT_IDX2FREQ_6G(89);
+	CASE_EXT_IDX2FREQ_6G(91);
+	CASE_EXT_IDX2FREQ_6G(93);
+	CASE_EXT_IDX2FREQ_6G(95);
+	CASE_EXT_IDX2FREQ_6G(97);
+	CASE_EXT_IDX2FREQ_6G(99);
+	CASE_EXT_IDX2FREQ_6G(101);
+	CASE_EXT_IDX2FREQ_6G(103);
+	CASE_EXT_IDX2FREQ_6G(105);
+	CASE_EXT_IDX2FREQ_6G(107);
+	CASE_EXT_IDX2FREQ_6G(109);
+	CASE_EXT_IDX2FREQ_6G(111);
+	CASE_EXT_IDX2FREQ_6G(113);
+	CASE_EXT_IDX2FREQ_6G(115);
+	CASE_EXT_IDX2FREQ_6G(117);
+	CASE_EXT_IDX2FREQ_6G(119);
+	CASE_EXT_IDX2FREQ_6G(121);
+	CASE_EXT_IDX2FREQ_6G(123);
+	CASE_EXT_IDX2FREQ_6G(125);
+	CASE_EXT_IDX2FREQ_6G(127);
+	CASE_EXT_IDX2FREQ_6G(129);
+	CASE_EXT_IDX2FREQ_6G(131);
+	CASE_EXT_IDX2FREQ_6G(133);
+	CASE_EXT_IDX2FREQ_6G(135);
+	CASE_EXT_IDX2FREQ_6G(137);
+	CASE_EXT_IDX2FREQ_6G(139);
+	CASE_EXT_IDX2FREQ_6G(141);
+	CASE_EXT_IDX2FREQ_6G(143);
+	CASE_EXT_IDX2FREQ_6G(145);
+	CASE_EXT_IDX2FREQ_6G(147);
+	CASE_EXT_IDX2FREQ_6G(149);
+	CASE_EXT_IDX2FREQ_6G(151);
+	CASE_EXT_IDX2FREQ_6G(153);
+	CASE_EXT_IDX2FREQ_6G(155);
+	CASE_EXT_IDX2FREQ_6G(157);
+	CASE_EXT_IDX2FREQ_6G(159);
+	CASE_EXT_IDX2FREQ_6G(161);
+	CASE_EXT_IDX2FREQ_6G(163);
+	CASE_EXT_IDX2FREQ_6G(165);
+	CASE_EXT_IDX2FREQ_6G(167);
+	CASE_EXT_IDX2FREQ_6G(169);
+	CASE_EXT_IDX2FREQ_6G(171);
+	CASE_EXT_IDX2FREQ_6G(173);
+	CASE_EXT_IDX2FREQ_6G(175);
+	CASE_EXT_IDX2FREQ_6G(177);
+	CASE_EXT_IDX2FREQ_6G(179);
+	CASE_EXT_IDX2FREQ_6G(181);
+	CASE_EXT_IDX2FREQ_6G(183);
+	CASE_EXT_IDX2FREQ_6G(185);
+	CASE_EXT_IDX2FREQ_6G(187);
+	CASE_EXT_IDX2FREQ_6G(189);
+	CASE_EXT_IDX2FREQ_6G(191);
+	CASE_EXT_IDX2FREQ_6G(193);
+	CASE_EXT_IDX2FREQ_6G(195);
+	CASE_EXT_IDX2FREQ_6G(197);
+	CASE_EXT_IDX2FREQ_6G(199);
+	CASE_EXT_IDX2FREQ_6G(201);
+	CASE_EXT_IDX2FREQ_6G(203);
+	CASE_EXT_IDX2FREQ_6G(205);
+	CASE_EXT_IDX2FREQ_6G(207);
+	CASE_EXT_IDX2FREQ_6G(209);
+	CASE_EXT_IDX2FREQ_6G(211);
+	CASE_EXT_IDX2FREQ_6G(213);
+	CASE_EXT_IDX2FREQ_6G(215);
+	CASE_EXT_IDX2FREQ_6G(217);
+	CASE_EXT_IDX2FREQ_6G(219);
+	CASE_EXT_IDX2FREQ_6G(221);
+	CASE_EXT_IDX2FREQ_6G(223);
+	CASE_EXT_IDX2FREQ_6G(225);
+	CASE_EXT_IDX2FREQ_6G(227);
+	CASE_EXT_IDX2FREQ_6G(229);
+	CASE_EXT_IDX2FREQ_6G(231);
+	CASE_EXT_IDX2FREQ_6G(233);
+	};
+
+	return INVALID_FREQ;
+}
+
+static u16 cl_channel_idx_to_freq_5g(struct cl_hw *cl_hw, u8 index)
+{
+	switch (index) {
+	CASE_IDX2FREQ_5G(36);
+	CASE_IDX2FREQ_5G(38);
+	CASE_IDX2FREQ_5G(40);
+	CASE_IDX2FREQ_5G(42);
+	CASE_IDX2FREQ_5G(44);
+	CASE_IDX2FREQ_5G(46);
+	CASE_IDX2FREQ_5G(48);
+	CASE_IDX2FREQ_5G(50);
+	CASE_IDX2FREQ_5G(52);
+	CASE_IDX2FREQ_5G(54);
+	CASE_IDX2FREQ_5G(56);
+	CASE_IDX2FREQ_5G(58);
+	CASE_IDX2FREQ_5G(60);
+	CASE_IDX2FREQ_5G(62);
+	CASE_IDX2FREQ_5G(64);
+	CASE_IDX2FREQ_5G(100);
+	CASE_IDX2FREQ_5G(102);
+	CASE_IDX2FREQ_5G(104);
+	CASE_IDX2FREQ_5G(106);
+	CASE_IDX2FREQ_5G(108);
+	CASE_IDX2FREQ_5G(110);
+	CASE_IDX2FREQ_5G(112);
+	CASE_IDX2FREQ_5G(114);
+	CASE_IDX2FREQ_5G(116);
+	CASE_IDX2FREQ_5G(118);
+	CASE_IDX2FREQ_5G(120);
+	CASE_IDX2FREQ_5G(122);
+	CASE_IDX2FREQ_5G(124);
+	CASE_IDX2FREQ_5G(126);
+	CASE_IDX2FREQ_5G(128);
+	CASE_IDX2FREQ_5G(132);
+	CASE_IDX2FREQ_5G(134);
+	CASE_IDX2FREQ_5G(136);
+	CASE_IDX2FREQ_5G(138);
+	CASE_IDX2FREQ_5G(140);
+	CASE_IDX2FREQ_5G(142);
+	CASE_IDX2FREQ_5G(144);
+	CASE_IDX2FREQ_5G(149);
+	CASE_IDX2FREQ_5G(151);
+	CASE_IDX2FREQ_5G(153);
+	CASE_IDX2FREQ_5G(155);
+	CASE_IDX2FREQ_5G(157);
+	CASE_IDX2FREQ_5G(159);
+	CASE_IDX2FREQ_5G(161);
+	CASE_IDX2FREQ_5G(165);
+	};
+
+	return INVALID_FREQ;
+}
+
+static u16 cl_channel_idx_to_freq_24g(struct cl_hw *cl_hw, u8 index)
+{
+	switch (index) {
+	CASE_IDX2FREQ_2G(1);
+	CASE_IDX2FREQ_2G(2);
+	CASE_IDX2FREQ_2G(3);
+	CASE_IDX2FREQ_2G(4);
+	CASE_IDX2FREQ_2G(5);
+	CASE_IDX2FREQ_2G(6);
+	CASE_IDX2FREQ_2G(7);
+	CASE_IDX2FREQ_2G(8);
+	CASE_IDX2FREQ_2G(9);
+	CASE_IDX2FREQ_2G(10);
+	CASE_IDX2FREQ_2G(11);
+	CASE_IDX2FREQ_2G(12);
+	CASE_IDX2FREQ_2G(13);
+	CASE_IDX2FREQ_2G(14);
+	};
+
+	return INVALID_FREQ;
+}
+
+u16 cl_channel_idx_to_freq(struct cl_hw *cl_hw, u8 index)
+{
+	/* Calculate frequency of a given idnex */
+	if (cl_band_is_6g(cl_hw))
+		return cl_channel_bitmap_idx_to_freq_6g(cl_hw, index);
+	else if (cl_band_is_5g(cl_hw))
+		return cl_channel_idx_to_freq_5g(cl_hw, index);
+	else
+		return cl_channel_idx_to_freq_24g(cl_hw, index);
+}
+
+bool cl_channel_is_valid(struct cl_hw *cl_hw, u8 channel)
+{
+	if (cl_band_is_24g(cl_hw)) {
+		return (channel > 0 && channel <= 14);
+	} else if (cl_band_is_5g(cl_hw)) {
+		if (channel >= 36 && channel <= 64)
+			return ((channel & 0x1) == 0x0);
+
+		if (channel >= 100 && channel <= 144)
+			return ((channel & 0x1) == 0x0);
+
+		if (channel >= 149 && channel <= 161)
+			return ((channel & 0x1) == 0x1);
+
+		if (channel == 165)
+			return true;
+	} else {
+		if (channel == 2)
+			return true;
+
+		if (channel >= 1 && channel <= 233)
+			if ((channel & 0x3) == 0x1)
+				return true;
+	}
+
+	return false;
+}
+
+u32 cl_channel_num(struct cl_hw *cl_hw)
+{
+	if (cl_hw->conf->ci_band_num == 6)
+		return NUM_BITMAP_CHANNELS_6G;
+
+	if (cl_hw->conf->ci_band_num == 5)
+		return NUM_CHANNELS_5G;
+
+	return NUM_CHANNELS_24G;
+}
+
+bool cl_channel_is_dfs(struct cl_hw *cl_hw, u8 channel)
+{
+	if (!cl_band_is_5g(cl_hw))
+		return false;
+
+	return channel >= 36 && channel <= 144;
+}
+
+u32 cl_channel_get_cac_time_ms(struct cl_hw *cl_hw, u8 channel)
+{
+	if (!cl_band_is_5g(cl_hw))
+		return 0;
+
+	if (!cl_channel_is_dfs(cl_hw, channel))
+		return 0;
+
+	/* FIXME: CAC time for weather channels may differ for some regions */
+	if (channel >= 120 && channel <= 128)
+		return IEEE80211_DFS_WEATHER_MIN_CAC_TIME_MS;
+
+	return IEEE80211_DFS_MIN_CAC_TIME_MS;
+}
+
+static void _cl_fill_channel_info(struct cl_hw *cl_hw, u8 bw, u8 ch_idx, u8 channel,
+				  u8 country_max_power_q2, u8 max_power_q2,
+				  u32 flags, u32 dfs_cac_ms)
+{
+	struct cl_chan_info *chan_info = &cl_hw->channel_info.channels[bw][ch_idx];
+
+	chan_info->channel = channel;
+	chan_info->country_max_power_q2 = country_max_power_q2;
+	chan_info->max_power_q2 = max_power_q2;
+	chan_info->flags = flags;
+	chan_info->dfs_cac_ms = dfs_cac_ms;
+}
+
+static void cl_fill_channel_info(struct cl_hw *cl_hw, u8 bw, u8 ch_idx, u8 channel,
+				 u8 country_max_power_q2, u8 max_power_q2)
+{
+	_cl_fill_channel_info(cl_hw, bw, ch_idx, channel, country_max_power_q2, max_power_q2, 0, 0);
+}
+
+static void cl_fill_channel_info_5g(struct cl_hw *cl_hw, u8 bw, u8 ch_idx, u8 channel,
+				    u8 country_max_power_q2, u8 max_power_q2)
+{
+	u32 flags = 0;
+	u32 dfs_cac_ms = 0;
+
+	if (cl_hw->conf->ci_ieee80211h && cl_channel_is_dfs(cl_hw, channel)) {
+		flags |= IEEE80211_CHAN_RADAR;
+		dfs_cac_ms = cl_channel_get_cac_time_ms(cl_hw, channel);
+	}
+
+	_cl_fill_channel_info(cl_hw, bw, ch_idx, channel, country_max_power_q2,
+			      max_power_q2, flags, dfs_cac_ms);
+}
+
+static inline s32 cl_convert_str_int_q2(s8 *str)
+{
+	s32 x, y;
+
+	if (!str)
+		return 0;
+	if (sscanf(str, "%d.%2d", &x, &y) != 2)
+		return 0;
+	if (!strstr(str, "."))
+		return x * 4;
+	if (y < 10 && (*(strstr(str, ".") + 1) != '0'))
+		y *= 10;
+	return (x * 100 + y) * 4 / 100;
+}
+
+static int cl_parse_reg_domain(struct cl_hw *cl_hw, char **str)
+{
+	/* Check if current line contains "FCC" or "ETSI" */
+	char *token = strsep(str, "\n");
+
+	if (!token)
+		goto err;
+
+	if (strstr(token, "FCC")) {
+		cl_hw->channel_info.standard = NL80211_DFS_FCC;
+		cl_dbg_info(cl_hw, "Standard = FCC\n");
+		return 0;
+	}
+
+	if (strstr(token, "ETSI")) {
+		cl_hw->channel_info.standard = NL80211_DFS_ETSI;
+		cl_dbg_info(cl_hw, "Standard = ETSI\n");
+		return 0;
+	}
+
+err:
+	cl_dbg_err(cl_hw, "Illegal regulatory domain\n");
+	cl_hw->channel_info.standard = NL80211_DFS_UNSET;
+	return -1;
+}
+
+#define MAX_CC_STR 4
+#define MAX_BW_STR 8
+
+static bool cl_parse_channel_info_txt(struct cl_hw *cl_hw)
+{
+	/*
+	 * Example of country information in channel_info.txt:
+	 *
+	 * [EU (European Union)ETSI]
+	 * 2.4GHz/20MHz: 2412(1,20) 2417(2,20) 2422(3,20) 2427(4,20) 2432(5,20) 2437(6,20)
+	 *               2442(7,20) 2447(8,20) 2452(9,20) 2457(10,20) 2462(11,20) 2467(12,20)
+	 *               2472(13,20)
+	 * 2.4GHz/40MHz: 2422(1,20) 2427(2,20) 2432(3,20) 2437(4,20) 2442(5,20) 2447(6,20)
+	 *               2452(7,20) 2457(8,20) 2462(9,20) 2467(10,20) 2472(11,20)
+	 * 5.2GHz/20MHz: 5180(36,23) 5200(40,23) 5220(44,23) 5240(48,23) 5260(52,23) 5280(56,23)
+	 *               5300(60,23) 5320(64,23) 5500(100,30) 5520(104,30) 5540(108,30)
+	 *               5560(112,30)5580(116,30) 5600(120,30) 5620(124,30) 5640(128,30)
+	 *               5660(132,30) 5680(136,30) 5700(140,30)
+	 * 5.2GHz/40MHz: 5180(36,23) 5200(40,23) 5220(44,23) 5240(48,23) 5260(52,23) 5280(56,23)
+	 *               5300(60,23) 5310(64,23) 5510(100,30) 5510(104,30) 5550(108,30)
+	 *               5550(112,30) 5590(116,30) 5590(120,30) 5630(124,30) 5630(128,30)
+	 *               5670(132,30) 5670(136,30)
+	 * 5.2GHz/80MHz: 5180(36,23) 5200(40,23) 5220(44,23) 5240(48,23) 5260(52,23) 5280(56,23)
+	 *               5300(60,23) 5310(64,23) 5510(100,30) 5510(104,30) 5550(108,30)
+	 *               5550(112,30) 5590(116,30) 5590(120,30) 5630(124,30) 5630(128,30)
+	 * 5.2GHz/160MHz: 5180(36,23) 5200(40,23) 5220(44,23) 5240(48,23) 5260(52,23) 5280(56,23)
+	 *                5300(60,23) 5310(64,23) 5510(100,30) 5510(104,30) 5550(108,30)
+	 *                5550(112,30) 5590(116,30) 5590(120,30) 5630(124,30) 5630(128,30)
+	 */
+
+	char *buf = NULL, *ptr = NULL;
+	char cc_str[MAX_CC_STR] = {0};
+	char bw_str[MAX_BW_STR] = {0};
+	size_t size;
+	u8 bw, bw_mhz, bw_max, max_power, channel, i;
+	char file_name[CL_FILENAME_MAX] = {0};
+
+	snprintf(file_name, sizeof(file_name), "channel_info_chip%d.txt", cl_hw->chip->idx);
+
+	/* Read channel_info.txt into buf */
+	size = cl_file_open_and_read(cl_hw->chip, file_name, &buf);
+
+	if (!buf)
+		return false;
+
+	/* Jump to the correct country in the file */
+	snprintf(cc_str, sizeof(cc_str), "[%s", cl_hw->chip->conf->ci_country_code);
+	ptr = strstr(buf, cc_str);
+	if (!ptr)
+		goto out;
+
+	if (cl_parse_reg_domain(cl_hw, &ptr))
+		goto out;
+
+	/* Jump to the relevant band */
+	if (cl_band_is_24g(cl_hw)) {
+		bw_max = CHNL_BW_40;
+		ptr = strstr(ptr, "2.4GHz");
+	} else if (cl_band_is_5g(cl_hw)) {
+		ptr = strstr(ptr, "5.2GHz");
+		bw_max = CHNL_BW_160;
+	} else {
+		ptr = strstr(ptr, "6GHz");
+		bw_max = CHNL_BW_160;
+	}
+
+	for (bw = 0; bw <= bw_max; bw++) {
+		if (!ptr)
+			goto out;
+
+		i = 0;
+
+		/* Jump to relevant bandwidth */
+		bw_mhz = BW_TO_MHZ(bw);
+		snprintf(bw_str, sizeof(bw_str), "%uMHz:", bw_mhz);
+		ptr = strstr(ptr, bw_str);
+
+		/* Iterate until end of line and parse (channel, max_power) */
+		while (ptr && (ptr + 1) && (*(ptr + 1) != '\n')) {
+			u32 flags = 0, dfs_cac_ms = 0;
+
+			ptr = strstr(ptr, "(");
+			if (!ptr)
+				goto out;
+
+			if (sscanf(ptr, "(%hhu,%hhu)", &channel, &max_power) != 2)
+				goto out;
+
+			if (!cl_channel_is_valid(cl_hw, channel) ||
+			    i == cl_channel_num(cl_hw))
+				goto out;
+
+			if (cl_hw->conf->ci_ieee80211h && cl_channel_is_dfs(cl_hw, channel)) {
+				flags |= IEEE80211_CHAN_RADAR;
+				dfs_cac_ms = cl_channel_get_cac_time_ms(cl_hw, channel);
+			}
+
+			_cl_fill_channel_info(cl_hw, bw, i, channel, max_power << 2,
+					      max_power << 2, flags, dfs_cac_ms);
+
+			i++;
+			ptr = strstr(ptr, ")");
+		}
+	}
+
+	kfree(buf);
+	return true;
+
+out:
+	kfree(buf);
+	return false;
+}
+
+static bool cl_is_parsing_success(struct cl_hw *cl_hw)
+{
+	/* Check that there is at least one channel in any bw */
+	u8 bw;
+	u8 max_bw = BAND_IS_5G_6G(cl_hw) ? CHNL_BW_160 : CHNL_BW_40;
+
+	for (bw = 0; bw <= max_bw; bw++)
+		if (!cl_hw->channel_info.channels[bw][0].channel)
+			return false;
+
+	return true;
+}
+
+static void cl_chan_info_set_max_bw_6g(struct cl_hw *cl_hw)
+{
+	u8 i, bw, bw_cnt, channel, channel_gap;
+	struct cl_chan_info *chan_info;
+
+	for (bw = 0; bw < CHNL_BW_MAX; bw++) {
+		chan_info = cl_hw->channel_info.channels[bw];
+		bw_cnt = 0;
+
+		for (i = 0; i < NUM_BITMAP_CHANNELS_6G; i++) {
+			channel = chan_info[i].channel;
+
+			if (channel == 0)
+				break;
+
+			channel_gap = channel - START_CHAN_IDX_6G;
+
+			/*
+			 * Verify that we don't combine together channels
+			 * from different 80MHz sections
+			 */
+			if ((channel_gap % CL_160MHZ_CH_GAP) == 0)
+				bw_cnt = 0;
+
+			if (i > 0)
+				bw_cnt++;
+
+			/* Verify that we don't make illegal 80MHz combination */
+			if ((channel_gap % CL_80MHZ_CH_GAP == 0) && bw_cnt == 3)
+				bw_cnt = 0;
+
+			/* Verify that we don't make illegal 40MHz combination */
+			if ((channel_gap % CL_40MHZ_CH_GAP == 0) && bw_cnt == 1)
+				bw_cnt = 0;
+
+			if ((((bw_cnt + 1) % CL_160MHZ_HOP) == 0) && bw == CHNL_BW_160) {
+				chan_info[i].max_bw = CHNL_BW_160;
+				chan_info[i - 1].max_bw = CHNL_BW_160;
+				chan_info[i - 2].max_bw = CHNL_BW_160;
+				chan_info[i - 3].max_bw = CHNL_BW_160;
+				chan_info[i - 4].max_bw = CHNL_BW_160;
+				chan_info[i - 5].max_bw = CHNL_BW_160;
+				chan_info[i - 6].max_bw = CHNL_BW_160;
+				chan_info[i - 7].max_bw = CHNL_BW_160;
+			} else if ((((bw_cnt + 1) % CL_80MHZ_HOP) == 0) && (bw == CHNL_BW_80)) {
+				chan_info[i].max_bw = CHNL_BW_80;
+				chan_info[i - 1].max_bw = CHNL_BW_80;
+				chan_info[i - 2].max_bw = CHNL_BW_80;
+				chan_info[i - 3].max_bw = CHNL_BW_80;
+			} else if ((((bw_cnt + 1) % CL_40MHZ_HOP) == 0) && (bw >= CHNL_BW_40)) {
+				chan_info[i].max_bw = CHNL_BW_40;
+				chan_info[i - 1].max_bw = CHNL_BW_40;
+			} else {
+				chan_info[i].max_bw = CHNL_BW_20;
+			}
+		}
+	}
+}
+
+static void cl_chan_info_set_max_bw_5g(struct cl_hw *cl_hw)
+{
+	u8 i, bw, bw_cnt, channel, channel_gap;
+	struct cl_chan_info *chan_info;
+
+	for (bw = 0; bw < CHNL_BW_MAX; bw++) {
+		chan_info = cl_hw->channel_info.channels[bw];
+		bw_cnt = 0;
+
+		for (i = 0; i < NUM_CHANNELS_5G; i++) {
+			channel = chan_info[i].channel;
+
+			if (channel == 0)
+				break;
+
+			if (channel < 149)
+				channel_gap = channel - 36;
+			else
+				channel_gap = channel - 149;
+
+			/*
+			 * Verify that we don't combine together channels from
+			 * different 80MHz sections
+			 * (i.e. 36-48 can be combined into 80MHz channels, unlike 40-52)
+			 */
+			if ((channel_gap % CL_160MHZ_CH_GAP) == 0)
+				bw_cnt = 0;
+
+			/* Check if 20MHz channels can be combined into 40MHz or 80MHz channels */
+			if (i > 0) {
+				/*
+				 * Verify that we don't combine together unsecutive channels
+				 * (like 36 and 44 when 40 is missing)
+				 */
+				if ((chan_info[i].channel - chan_info[i - 1].channel) >
+				    CL_20MHZ_CH_GAP)
+					bw_cnt = 0;
+				else
+					bw_cnt++;
+			}
+
+			/* Verify that we don't make illegal 80MHz combination (like 44-56) */
+			if ((channel_gap % CL_80MHZ_CH_GAP == 0) && bw_cnt == 3)
+				bw_cnt = 0;
+
+			/* Verify that we don't make illegal 40MHz combination (like 40-44) */
+			if ((channel_gap % CL_40MHZ_CH_GAP == 0) && bw_cnt == 1)
+				bw_cnt = 0;
+
+			if ((((bw_cnt + 1) % CL_160MHZ_HOP) == 0) && bw == CHNL_BW_160) {
+				chan_info[i].max_bw = CHNL_BW_160;
+				chan_info[i - 1].max_bw = CHNL_BW_160;
+				chan_info[i - 2].max_bw = CHNL_BW_160;
+				chan_info[i - 3].max_bw = CHNL_BW_160;
+				chan_info[i - 4].max_bw = CHNL_BW_160;
+				chan_info[i - 5].max_bw = CHNL_BW_160;
+				chan_info[i - 6].max_bw = CHNL_BW_160;
+				chan_info[i - 7].max_bw = CHNL_BW_160;
+			} else if ((((bw_cnt + 1) % CL_80MHZ_HOP) == 0) && bw == CHNL_BW_80) {
+				chan_info[i].max_bw = CHNL_BW_80;
+				chan_info[i - 1].max_bw = CHNL_BW_80;
+				chan_info[i - 2].max_bw = CHNL_BW_80;
+				chan_info[i - 3].max_bw = CHNL_BW_80;
+			} else if ((((bw_cnt + 1) % CL_40MHZ_HOP) == 0) && bw >= CHNL_BW_40) {
+				chan_info[i].max_bw = CHNL_BW_40;
+				chan_info[i - 1].max_bw = CHNL_BW_40;
+			} else {
+				chan_info[i].max_bw = CHNL_BW_20;
+			}
+		}
+	}
+}
+
+static void cl_chan_info_set_max_bw_24g(struct cl_hw *cl_hw)
+{
+	u8 i, bw, channel;
+	struct cl_chan_info *chan_info;
+
+	for (bw = 0; bw < CHNL_BW_80; bw++) {
+		chan_info = cl_hw->channel_info.channels[bw];
+
+		for (i = 0; i < NUM_CHANNELS_24G; i++) {
+			channel = chan_info[i].channel;
+
+			if (channel == 0)
+				break;
+
+			if (channel < 14)
+				chan_info[i].max_bw = CHNL_BW_40;
+			else
+				chan_info[i].max_bw = CHNL_BW_20;
+		}
+	}
+}
+
+static void cl_chan_info_set_max_bw(struct cl_hw *cl_hw)
+{
+	if (cl_band_is_6g(cl_hw))
+		cl_chan_info_set_max_bw_6g(cl_hw);
+	else if (cl_band_is_5g(cl_hw))
+		cl_chan_info_set_max_bw_5g(cl_hw);
+	else
+		cl_chan_info_set_max_bw_24g(cl_hw);
+}
+
+static void cl_chan_info_dbg(struct cl_hw *cl_hw)
+{
+	struct cl_chan_info *chan_info;
+	u32 max_power_integer, max_power_fraction;
+	u8 i, j;
+
+	for (i = 0; i < CHNL_BW_MAX; i++) {
+		cl_dbg_info(cl_hw, "Bandwidth = %uMHz\n", BW_TO_MHZ(i));
+		for (j = 0; j < cl_channel_num(cl_hw); j++) {
+			chan_info = &cl_hw->channel_info.channels[i][j];
+
+			if (chan_info->channel == 0)
+				continue;
+
+			max_power_integer = (chan_info->max_power_q2 / 4);
+			max_power_fraction =
+				(100 * (chan_info->max_power_q2 - 4 * max_power_integer) / 4);
+
+			cl_dbg_info(cl_hw, "Channel = %u, max EIRP = %3u.%02u, bw = %uMHz\n",
+				    chan_info->channel, max_power_integer,
+				    max_power_fraction, BW_TO_MHZ(chan_info->max_bw));
+		}
+	}
+}
+
+/* Band 6G - default power */
+#define UNII_5_POW_Q2     (27 << 2)
+#define UNII_6_POW_Q2     (27 << 2)
+#define UNII_7_POW_Q2     (27 << 2)
+#define UNII_8_POW_Q2     (27 << 2)
+
+/* Band 5G - default power */
+/* Default regulatory domain:
+ * country US: DFS-FCC
+ *       (2400 - 2472 @ 40), (N/A, 30), (N/A)
+ *       (5150 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
+ *       (5250 - 5350 @ 80), (N/A, 23), (0 ms), DFS, AUTO-BW
+ *       (5470 - 5730 @ 160), (N/A, 23), (0 ms), DFS
+ *       (5730 - 5850 @ 80), (N/A, 30), (N/A), AUTO-BW
+ *       (5850 - 5895 @ 40), (N/A, 27), (N/A), NO-OUTDOOR, AUTO-BW, PASSIVE-SCAN
+ *       (57240 - 71000 @ 2160), (N/A, 40), (N/A)
+ */
+#define UNII_1_POW_Q2     (23 << 2)
+#define UNII_2_POW_Q2     (23 << 2)
+#define UNII_2_EXT_POW_Q2 (23 << 2)
+#define UNII_3_POW_Q2     (30 << 2)
+
+/* Band 2.4G - default power */
+#define BAND_24G_POW_Q2   (30 << 2)
+
+static void cl_set_default_channel_info_6g(struct cl_hw *cl_hw)
+{
+	u8 i, j, k;
+
+	for (i = 0; i < CHNL_BW_MAX; i++) {
+		k = 0;
+
+		/* Ch2 is a special case */
+		cl_fill_channel_info(cl_hw, i, k, 2, UNII_5_POW_Q2, UNII_5_POW_Q2);
+		k++;
+
+		for (j = START_CHAN_IDX_UNII5; j <= END_CHAN_IDX_UNII5; j += 4) {
+			cl_fill_channel_info(cl_hw, i, k, j, UNII_5_POW_Q2, UNII_5_POW_Q2);
+			k++;
+		}
+
+		for (j = START_CHAN_IDX_UNII6; j <= END_CHAN_IDX_UNII6; j += 4) {
+			cl_fill_channel_info(cl_hw, i, k, j, UNII_6_POW_Q2, UNII_6_POW_Q2);
+			k++;
+		}
+
+		for (j = START_CHAN_IDX_UNII7; j <= END_CHAN_IDX_UNII7; j += 4) {
+			cl_fill_channel_info(cl_hw, i, k, j, UNII_7_POW_Q2, UNII_7_POW_Q2);
+			k++;
+		}
+
+		for (j = START_CHAN_IDX_UNII8; j <= END_CHAN_IDX_UNII8; j += 4) {
+			/* Channel 233 is valid only in 20MHz */
+			if (i != CHNL_BW_20 && j == END_CHAN_IDX_UNII8)
+				break;
+
+			cl_fill_channel_info(cl_hw, i, k, j, UNII_8_POW_Q2, UNII_8_POW_Q2);
+			k++;
+		}
+	}
+}
+
+static void cl_set_default_channel_info_5g(struct cl_hw *cl_hw)
+{
+	u8 i, j, k;
+
+	for (i = 0; i < CHNL_BW_MAX; i++) {
+		k = 0;
+
+		for (j = 36; j <= 48; j += 4) {
+			cl_fill_channel_info_5g(cl_hw, i, k, j, UNII_1_POW_Q2, UNII_1_POW_Q2);
+			k++;
+		}
+
+		for (j = 52; j <= 64; j += 4) {
+			cl_fill_channel_info_5g(cl_hw, i, k, j, UNII_2_POW_Q2, UNII_2_POW_Q2);
+			k++;
+		}
+
+		for (j = 100; j <= 144; j += 4) {
+			/* 160MHz is supported only in channel 36 - 64 and 100 - 128 */
+			if (i == CHNL_BW_160 && j == 132)
+				return;
+
+			cl_fill_channel_info_5g(cl_hw, i, k, j,
+						UNII_2_EXT_POW_Q2, UNII_2_EXT_POW_Q2);
+			k++;
+		}
+
+		for (j = 149; j <= 165; j += 4) {
+			/* Channel 165 is valid only in 20MHz */
+			if (i != CHNL_BW_20 && j == 165)
+				break;
+
+			cl_fill_channel_info_5g(cl_hw, i, k, j, UNII_3_POW_Q2, UNII_3_POW_Q2);
+			k++;
+		}
+	}
+}
+
+static void cl_set_default_channel_info_24g(struct cl_hw *cl_hw)
+{
+	u8 i, j;
+
+	for (i = 0; i <= CHNL_BW_40; i++)
+		for (j = 0; j < 13; j++)
+			cl_fill_channel_info(cl_hw, i, j, j + 1, BAND_24G_POW_Q2, BAND_24G_POW_Q2);
+}
+
+static void cl_set_default_channel_info(struct cl_hw *cl_hw)
+{
+	struct cl_channel_info *channel_info = &cl_hw->channel_info;
+
+	memset(channel_info->channels, 0, sizeof(channel_info->channels));
+
+	channel_info->standard = NL80211_DFS_FCC;
+
+	if (cl_band_is_6g(cl_hw))
+		cl_set_default_channel_info_6g(cl_hw);
+	else if (cl_band_is_5g(cl_hw))
+		cl_set_default_channel_info_5g(cl_hw);
+	else
+		cl_set_default_channel_info_24g(cl_hw);
+}
+
+/*
+ * cl_hardware_power_table_update: Applies individual regulatory table entry
+ *   Inputs: cl_hw      - pointer to cl_hw
+ *           bw_mhz     - current bandwidth in MHz
+ *           chan_start - match channels greater or equal to chan_start
+ *           chan_end   - match channels less than chan_end
+ *           reg_pwr    - ensure channel_info.channels[bw][ch_idx].max_power does not exceed this
+ *   Output: updated channel_info.channels[bw][ch_idx].max_power
+ *           and channel_info.channels[bw][ch_idx].max_total_power
+ *           on all channels that match specified range
+ */
+static void cl_hardware_power_table_update(struct cl_hw *cl_hw, u8 bw_mhz,
+					   u8 chan_start, u8 chan_end, u8 pwr_q2)
+{
+	struct cl_chan_info *chan_info = NULL;
+	u8 bw = 0;
+	u8 ch_idx = 0;
+	bool ch_found = false;
+	bool is_24g = cl_band_is_24g(cl_hw);
+
+	if (bw_mhz == 20 || bw_mhz == 40 || (!is_24g && (bw_mhz == 80 || bw_mhz == 160))) {
+		bw = MHZ_TO_BW(bw_mhz);
+	} else {
+		cl_dbg_err(cl_hw, "Invalid bw %u\n", bw_mhz);
+		return;
+	}
+
+	/* Iterate through all cl_channels[bw][ch_idx] - to find all matches */
+	for (ch_idx = 0; ch_idx < cl_channel_num(cl_hw); ch_idx++) {
+		chan_info = &cl_hw->channel_info.channels[bw][ch_idx];
+
+		if (chan_start <= chan_info->channel && chan_info->channel < chan_end) {
+			ch_found = true;
+
+			/*
+			 * Max-Power =
+			 * minimum beteen hardware_power_table and country code definition
+			 */
+			chan_info->max_power_q2 = min(pwr_q2, chan_info->max_power_q2);
+			chan_info->hardware_max_power_q2 = pwr_q2;
+		}
+	}
+
+	if (!ch_found)
+		cl_dbg_info(cl_hw, "Skipping invalid channel range: %u - %u\n",
+			    chan_start, chan_end);
+}
+
+/*
+ * cl_hardware_power_table_parse():
+ * Iterate through hardware power table entries and apply each one.
+ * Expected format:
+ *     bw1(chan1=reg_pwr1;chan2=reg_pwr2;...)#bw2(chan3=reg_pwr3;chan4=reg_pwr4;...) ...
+ * Example:
+ *     20(36=22.0;40=22.75;149=21.75)#40(36=22.5;40=23.0;149=21.75)#80(36=21.75;40=21.5;149=22.25)
+ */
+static void cl_hardware_power_table_parse(struct cl_hw *cl_hw)
+{
+	char *table_str = NULL;
+	char *table_str_p = NULL;
+	char *channel_str = NULL;
+	char *channel_str_p = NULL;
+	char *bw_set = NULL;
+	char *out_tok = NULL;
+	s8 in_reg_pwr[16] = {0};
+	u8 bw_mhz = 0;
+	u8 chan_start = 0;
+	u8 chan_end = 0;
+	u8 curr_pwr_q2 = 0;
+	u8 next_pwr_q2 = 0;
+
+	if (strlen(cl_hw->conf->ce_hardware_power_table) == 0)
+		return; /* Not configured */
+
+	table_str_p = kzalloc(CL_MAX_STR_BUFFER_SIZE / 2, GFP_KERNEL);
+	if (!table_str_p)
+		return;
+
+	channel_str_p = kzalloc(CL_MAX_STR_BUFFER_SIZE / 2, GFP_KERNEL);
+	if (!channel_str_p) {
+		kfree(table_str_p);
+		cl_dbg_err(cl_hw, "Failed to allocate channel_str\n");
+		return;
+	}
+
+	table_str = table_str_p;
+
+	strncpy(table_str,
+		cl_hw->conf->ce_hardware_power_table,
+		(CL_MAX_STR_BUFFER_SIZE / 2) - 1);
+
+	/* Iterate through all bandwidth sets included in table_str */
+	bw_set = strsep(&table_str, "#");
+	while (bw_set) {
+		channel_str = channel_str_p;
+		if (sscanf(bw_set, "%hhu(%s)", &bw_mhz, channel_str) != 2) {
+			bw_set = strsep(&table_str, "#");
+			continue;
+		}
+
+		/* Iterate through each channel in this bandwidth set */
+		chan_start = 0;
+		chan_end = 0;
+		curr_pwr_q2 = 0;
+		next_pwr_q2 = 0;
+		out_tok = strsep(&channel_str, ";");
+
+		while (out_tok) {
+			if (sscanf(out_tok, "%hhu=%s", &chan_end, in_reg_pwr) == 2) {
+				next_pwr_q2 = cl_convert_str_int_q2(in_reg_pwr);
+
+				/* Apply regulatory table rule. Skip initial case */
+				if (curr_pwr_q2 != 0 && chan_start != 0)
+					cl_hardware_power_table_update(cl_hw, bw_mhz, chan_start,
+								       chan_end, curr_pwr_q2);
+
+				/* Prepare next iteration */
+				chan_start = chan_end;
+				curr_pwr_q2 = next_pwr_q2;
+			}
+			out_tok = strsep(&channel_str, ";");
+		}
+
+		/* Handle last channel case */
+		if (next_pwr_q2 != 0 && chan_start != 0) {
+			u8 chan_end;
+
+			if (cl_band_is_6g(cl_hw))
+				chan_end = 234;
+			else if (cl_band_is_5g(cl_hw))
+				chan_end = 166;
+			else
+				chan_end = 15;
+
+			cl_hardware_power_table_update(cl_hw, bw_mhz, chan_start,
+						       chan_end, curr_pwr_q2);
+		}
+
+		bw_set = strsep(&table_str, "#");
+	}
+
+	kfree(table_str_p);
+	kfree(channel_str_p);
+}
+
+static void cl_chan_info_ieee80211_update_max_power(struct cl_hw *cl_hw)
+{
+	struct ieee80211_supported_band *sband =  &cl_hw->sband;
+	struct ieee80211_channel *chan = NULL;
+	int i = 0, channel;
+
+	for (i = 0; i < sband->n_channels; i++) {
+		chan = &sband->channels[i];
+		channel = ieee80211_frequency_to_channel(chan->center_freq);
+		chan->max_power = cl_chan_info_get_max_power(cl_hw, channel);
+	}
+}
+
+void cl_chan_info_init(struct cl_hw *cl_hw)
+{
+	struct cl_channel_info *channel_info = &cl_hw->channel_info;
+
+	channel_info->use_channel_info = true;
+
+	if (channel_info->use_channel_info) {
+		if (!cl_parse_channel_info_txt(cl_hw) || !cl_is_parsing_success(cl_hw)) {
+			CL_DBG_WARNING(cl_hw, "Error parsing channel_info.txt. Using default!\n");
+			cl_set_default_channel_info(cl_hw);
+		}
+
+		cl_chan_info_ieee80211_update_max_power(cl_hw);
+		cl_chan_info_set_max_bw(cl_hw);
+		cl_chan_info_dbg(cl_hw);
+	} else {
+		cl_set_default_channel_info(cl_hw);
+	}
+
+	cl_hardware_power_table_parse(cl_hw);
+}
+
+void cl_chan_info_deinit(struct cl_hw *cl_hw)
+{
+	if (cl_hw->channel_info.rd &&
+	    cl_hw->channel_info.use_channel_info)
+		kfree(cl_hw->channel_info.rd);
+}
+
+struct cl_chan_info *cl_chan_info_get(struct cl_hw *cl_hw, u8 channel, u8 bw)
+{
+	int i = 0;
+	struct cl_chan_info *chan_info;
+
+	for (i = 0; i < cl_channel_num(cl_hw); i++) {
+		chan_info = &cl_hw->channel_info.channels[bw][i];
+
+		if (chan_info->channel == channel)
+			return chan_info;
+	}
+
+	return NULL;
+}
+
+u8 cl_chan_info_get_max_bw(struct cl_hw *cl_hw, u8 channel)
+{
+	s8 bw = 0;
+
+	for (bw = CHNL_BW_160; bw > CHNL_BW_20; bw--)
+		if (cl_chan_info_get(cl_hw, channel, bw))
+			return (u8)bw;
+
+	return CHNL_BW_20;
+}
+
+s16 cl_chan_info_get_eirp_limit_q8(struct cl_hw *cl_hw, u8 bw)
+{
+	/* Eirp_limit = min(country_limit, hw_limit) */
+	struct cl_chan_info *chan_info = cl_chan_info_get(cl_hw, cl_hw->channel, bw);
+
+	return chan_info ? (chan_info->max_power_q2 << 6) : CL_DEFAULT_CHANNEL_POWER_Q8;
+}
+
+u8 cl_chan_info_get_max_power(struct cl_hw *cl_hw, u8 channel)
+{
+	struct cl_chan_info *chan_info;
+	u8 bw = 0;
+	u8 max_power_q2 = 0;
+
+	for (bw = 0; bw < CHNL_BW_MAX; bw++) {
+		chan_info = cl_chan_info_get(cl_hw, channel, bw);
+
+		if (!chan_info)
+			continue;
+
+		if (chan_info->max_power_q2 > max_power_q2)
+			max_power_q2 = chan_info->max_power_q2;
+	}
+
+	return max_power_q2 >> 2;
+}
+
+static void cl_chan_update_channel_info(struct cl_hw *cl_hw, struct ieee80211_channel *channel)
+{
+	u8 bw;
+	u32 chan = ieee80211_frequency_to_channel(channel->center_freq);
+	struct cl_chan_info *chan_info;
+
+	for (bw = CHNL_BW_20; bw < CHNL_BW_MAX; bw++) {
+		chan_info = cl_chan_info_get(cl_hw, chan, bw);
+		if (!chan_info || chan_info->channel == 0)
+			continue;
+
+		chan_info->max_power_q2         = channel->max_power << 2;
+		chan_info->country_max_power_q2 = channel->max_reg_power << 2;
+		chan_info->flags = channel->flags;
+		chan_info->dfs_cac_ms = channel->dfs_cac_ms;
+	}
+}
+
+void cl_chan_update_channels_info(struct cl_hw *cl_hw,
+				  const struct ieee80211_supported_band *cfg_band)
+{
+	int i = 0;
+
+	spin_lock_bh(&cl_hw->channel_info_lock);
+	for (i = 0; i < cfg_band->n_channels; ++i)
+		cl_chan_update_channel_info(cl_hw, &cfg_band->channels[i]);
+	spin_unlock_bh(&cl_hw->channel_info_lock);
+}
+
+#define CENTER_FREQ_24G_BW_80MHZ  2442
+#define CENTER_FREQ_24G_BW_160MHZ 2482
+
+static int cl_chandef_calc_6g(struct cl_hw *cl_hw, u16 freq, u32 bw, u32 offset,
+			      u32 *primary, u32 *center)
+{
+	u32 bw_mhz = BW_TO_MHZ(bw);
+	u32 min_freq = 0;
+
+	if (freq == FREQ6G(2)) {
+		min_freq = FREQ6G(2);
+	} else if (freq >= FREQ6G(1) && freq <= FREQ6G(233)) {
+		min_freq = FREQ6G(1);
+	} else {
+		cl_dbg_err(cl_hw, "Invalid frequecy - %u\n", freq);
+		return -EINVAL;
+	}
+
+	*primary = freq - (freq - min_freq) % 20;
+	*center = *primary - (*primary - min_freq) % bw_mhz + offset;
+
+	return 0;
+}
+
+static int cl_chandef_calc_5g(struct cl_hw *cl_hw, u16 freq, u32 bw, u32 offset,
+			      u32 *primary, u32 *center)
+{
+	u32 bw_mhz = BW_TO_MHZ(bw);
+	u32 min_freq = 0;
+
+	if ((freq >= FREQ5G(36) && freq <= FREQ5G(64)) ||
+	    (freq >= FREQ5G(100) && freq <= FREQ5G(144))) {
+		min_freq = FREQ5G(36);
+	} else if (freq >= FREQ5G(149) && freq <= FREQ5G(165)) {
+		min_freq = FREQ5G(149);
+	} else {
+		cl_dbg_err(cl_hw, "Invalid frequecy - %u\n", freq);
+		return -EINVAL;
+	}
+
+	*primary = freq - (freq - min_freq) % 20;
+	*center = *primary - (*primary - min_freq) % bw_mhz + offset;
+
+	return 0;
+}
+
+static int cl_chandef_calc_24g(struct cl_hw *cl_hw, u16 freq, u32 bw, u32 offset,
+			       u32 *primary, u32 *center)
+{
+	u32 min_freq = 0;
+
+	if (freq < FREQ2G(1) || freq > FREQ2G(14)) {
+		cl_dbg_err(cl_hw, "Invalid frequecy - %u\n", freq);
+		return -EINVAL;
+	}
+
+	min_freq = freq < FREQ2G(14) ? FREQ2G(1) : FREQ2G(14);
+	*primary = freq - (freq - min_freq) % 5;
+
+	if (bw == CHNL_BW_20) {
+		*center = *primary;
+	} else if (bw == CHNL_BW_40) {
+		if (freq <= FREQ2G(4)) {
+			/* Above extension channel */
+			*center = *primary + offset;
+		} else if (freq >= FREQ2G(10)) {
+			/* Below extension channel */
+			*center = *primary - offset;
+		} else {
+			/* Channels 8-9 must be below if channel 13 is not supported */
+			if (freq >= FREQ2G(8) && !cl_chan_info_get(cl_hw, 13, CHNL_BW_20) &&
+			    /* For Calibration, when using 2.4GHz channels on TCV0 to set SX0. */
+			    !cl_chan_info_get(cl_hw->chip->cl_hw_tcv1, 13, CHNL_BW_20)) {
+				*center = *primary - offset;
+			} else {
+				/**
+				 * Set below/above according to the current hapd configuration.
+				 * If undefined, preffer above offset.
+				 */
+				if (cl_hw->ht40_preffered_ch_type == NL80211_CHAN_HT40MINUS)
+					*center = *primary - offset;
+				else
+					*center = *primary + offset;
+			}
+		}
+	} else if (bw == CHNL_BW_80) {
+		*center = CENTER_FREQ_24G_BW_80MHZ;
+	} else {
+		/* 160MHz */
+		*center = CENTER_FREQ_24G_BW_160MHZ;
+	}
+
+	return 0;
+}
+
+int cl_chandef_calc(struct cl_hw *cl_hw, u32 channel, u32 bw,
+		    enum nl80211_chan_width *width, u32 *primary, u32 *center)
+{
+	u16 freq = ieee80211_channel_to_frequency(channel, cl_hw->nl_band);
+	u32 offset = 0;
+	int ret = 0;
+
+	switch (bw) {
+	case CHNL_BW_20:
+		offset = 0;
+		if (channel == 14)
+			*width = NL80211_CHAN_WIDTH_20_NOHT;
+		else
+			*width = NL80211_CHAN_WIDTH_20;
+		break;
+	case CHNL_BW_40:
+		offset = 10;
+		*width = NL80211_CHAN_WIDTH_40;
+		break;
+	case CHNL_BW_80:
+		if (!cl_hw->chip->conf->ce_production_mode && cl_band_is_24g(cl_hw)) {
+			cl_dbg_err(cl_hw, "Invalid bandwidth - %u\n", bw);
+			return -EINVAL;
+		}
+
+		offset = 30;
+		*width = NL80211_CHAN_WIDTH_80;
+		break;
+	case CHNL_BW_160:
+		/* Verify 2.4G bandwidth validity only in operational mode */
+		if (!cl_hw->chip->conf->ce_production_mode && cl_band_is_24g(cl_hw)) {
+			cl_dbg_err(cl_hw, "Invalid bandwidth - %u\n", bw);
+			return -EINVAL;
+		}
+
+		offset = 70;
+		*width = NL80211_CHAN_WIDTH_160;
+		break;
+	default:
+		cl_dbg_err(cl_hw, "Invalid bandwidth - %u\n", bw);
+		return -EINVAL;
+	}
+
+	if (cl_band_is_6g(cl_hw))
+		ret = cl_chandef_calc_6g(cl_hw, freq, bw, offset, primary, center);
+	else if (cl_band_is_5g(cl_hw))
+		ret = cl_chandef_calc_5g(cl_hw, freq, bw, offset, primary, center);
+	else
+		ret = cl_chandef_calc_24g(cl_hw, freq, bw, offset, primary, center);
+
+	cl_dbg_trace(cl_hw, "primary=%u center=%u\n", *primary, *center);
+
+	return ret;
+}
+
+int cl_chandef_get_default(struct cl_hw *cl_hw, u32 *channel, u8 *bw,
+			   enum nl80211_chan_width *width,
+			   u32 *primary, u32 *center)
+{
+	*bw = cl_hw->conf->ci_chandef_bandwidth;
+	*channel = cl_hw->conf->ci_chandef_channel;
+
+	return cl_chandef_calc(cl_hw, *channel, *bw, width, primary, center);
+}
+
+int cl_init_channel_stats(struct cl_hw *cl_hw,
+			  struct cl_channel_stats *ch_stats, u32 freq)
+{
+	memset(ch_stats, 0, sizeof(*ch_stats));
+
+	ch_stats->channel = ieee80211_frequency_to_channel(freq);
+	if (ch_stats->channel == INVALID_CHAN_IDX) {
+		cl_dbg_err(cl_hw, "Failed to get channel num for freq %u\n", freq);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void cl_get_final_channel_stats(struct cl_hw *cl_hw, struct cl_channel_stats *ch_stats)
+{
+	u32 tx_mine, rx_mine, edca_cca;
+
+	/*
+	 * Currently mac_hw_rx_mine_busy_get() doesn't work properly,
+	 * so use mac_hw_edca_cca_busy_get() as workaround.
+	 * After scan mac_hw_rx_mine_busy_get almost always returns zeros
+	 * or some very small values.
+	 * Use of EDCA CCA is less accurate, since it also includes non-wifi noise
+	 */
+	tx_mine = mac_hw_tx_mine_busy_get(cl_hw);
+	edca_cca = mac_hw_edca_cca_busy_get(cl_hw);
+	rx_mine = edca_cca;
+
+	ch_stats->util_time_tx = max_t(s64, tx_mine - ch_stats->util_time_tx_total, 0);
+	ch_stats->util_time_rx = max_t(s64, rx_mine - ch_stats->util_time_rx_total, 0);
+	ch_stats->edca_cca_time = max_t(s64, edca_cca - ch_stats->edca_cca_time_total, 0);
+
+	ch_stats->util_time_busy = ch_stats->edca_cca_time + ch_stats->util_time_tx;
+
+	ch_stats->ch_noise = cl_calc_noise_floor(cl_hw, NULL);
+
+	ch_stats->scan_time_ms = jiffies_to_msecs(get_jiffies_64() - ch_stats->scan_start_jiffies);
+}
+
+void cl_get_initial_channel_stats(struct cl_hw *cl_hw, struct cl_channel_stats *ch_stats)
+{
+	ch_stats->util_time_tx = 0;
+	ch_stats->util_time_rx = 0;
+	ch_stats->edca_cca_time = 0;
+	ch_stats->util_time_busy = 0;
+	ch_stats->ch_noise = 0;
+	ch_stats->scan_time_ms = 0;
+
+	ch_stats->util_time_tx_total = mac_hw_tx_mine_busy_get(cl_hw);
+	ch_stats->edca_cca_time_total = mac_hw_edca_cca_busy_get(cl_hw);
+	ch_stats->util_time_rx_total = ch_stats->edca_cca_time_total;
+
+	ch_stats->scan_start_jiffies = get_jiffies_64();
+}
-- 
2.36.1

