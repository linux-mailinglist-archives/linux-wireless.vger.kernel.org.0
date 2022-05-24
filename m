Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2738D53292D
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236760AbiEXLht (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236765AbiEXLhq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:37:46 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D1440A01
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:37:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhYsoxiOhaDPwPOCV7YqWNPUSrrcElUK85lxUiBvQ6yYPPDJUVGn35sB5GlnQLsCI/KJ0CDZwgfvGPNGf2UN++3lVY+Ykd50eeAAKSsf6qXvRlICdNxhVl4KGIVmO9mlXFW8jp/qQxVfUgPxbUa0CkJ991QIvM8eelfq5va3OFdOSLVdtV9LWZALSszaozDXSaueLSOtJHaDgYWMdjzsYeYhQJoIEwfOSjgt6df1ZDSBwpxsIz0QcZHbNiyqLfkTHUsgB5ZSQrJRl8emJMLvua4B3SiOYkrltFj+LOe8BdRcTTmVzumyQIQV9fRJQUpItXq7wbOBJVWNtPR207jFLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNQ6pE+vvFRa6s/LeF2OE00Kc+/AD9sf0peaVC7hHrc=;
 b=D/Lt6tbQxTvQoXpqGzbGnHGQskSOzx48K9U1gUI4nGVgw/boZbsSvsYLBJ0/zQtbJpcGvDdYsnU2jxBAjXZs+GC5uJyE26NR2jWWeNaTvQ0LnkGixAD2FKsHwju1hDutA5BWTyxm7Em8E9bZSr82o2GQIe23Id910ezFtUvSneJd3rruVJjSoT3GXfQ9tYJ6iFhJ8oHyfVx37gnI9vVasdjQrtRyPdw8qspPSlM1WbR0yFO6KZ4WDRd5u4VnPIglGXf+fSlurAwSww4sPrQlRZglNsUoWL6XTTqbZXW0pK+uUy3gxkn8wFdb1rbJfNjwmB1kVTujqHFj7S2R3sgjMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNQ6pE+vvFRa6s/LeF2OE00Kc+/AD9sf0peaVC7hHrc=;
 b=mVBGq71kA1U3hVih/lLxHW4t6aJbcMj07w7iiK1lOgXq3LmLLVlIntDuK9NCY6Xp7v6gE+SDlKlwH1EkgRkS3UAnDVzWUGndVqCK8UnedG64ZaswFWMbJtxGBUQKyWShwThD+qEjQPnFAkSYRQp3SqDj0WbYHp+/82DfbuGryoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0305.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 11:37:41 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:37:41 +0000
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
Subject: [RFC v2 08/96] cl8k: add bf.h
Date:   Tue, 24 May 2022 14:33:34 +0300
Message-Id: <20220524113502.1094459-9-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 64f93661-c531-4029-5da4-08da3d79cfc5
X-MS-TrafficTypeDiagnostic: AM0P192MB0305:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM0P192MB03054432DF62919AC7630E5AF6D79@AM0P192MB0305.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I3NvIY77cr7+j2pb2o9kCTRo9vr+b2arONAWmn0wjfapuIK8n8PeK/9DgsBicgzsqwo5M8ZT3cQTjsCWOBEg8Jhm1xj452A31cEftqd2vKdn3NunC4N27oSnpwKFSG2SjpX3ixAk5Halah2FFDuuODEbApsFLptHZG6LyIPfHk45+3FIHdUNosV02cLKgHfpT9F76t9z4ocy2mSH/24U2dwgsMRq8LlSnyW/4c0c+CqFv+OW7MyCEZBjmp/mzzvpqSyrYrIaBWOU+AmrU8+7bh/Zk0UUC8Ri5nDUNx9JREFIYSgHZhW1N5xIiWHoBB+sWYIjppEDTkis8Ix094fHUcV/4cd4hJdbzEvcLa06b4GVCEE4P7vtF4yCMUzV3KjVF3RxmOtTHCOjWxTl9U4eJ+jAkG7A6H6I+kVyC5ewo76zEkeMtcooeR8UhgYx8KlkzlKL7pHnbBFfdf0blci4GC/UQlaptEd1pkBhgsRjgGkRpJMRq8ok7mrRojxACCZ6k3togqYufUmxAweY2LlcMBof857rBUgybzBbAMoLxBNLoYYBYPs4OVZRjW63NX2RDX0z++vRDZzHCOnqgKcvKSQ4ph1FcpFddwV4hmDQDi35pKlSVZUwiZEAX9xVb6iPknfHnmLt1OEHuVUCACGT30h2zUjDYMu8IKmmZqWZzxD3o40JENmy/S7T1CPS/7q469YOs+bejQvbu3V7KuN4w6umSAVjJhYZfhgxAQncCJw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(346002)(396003)(366004)(39850400004)(376002)(136003)(6486002)(6916009)(508600001)(38350700002)(38100700002)(52116002)(6666004)(2906002)(8936002)(54906003)(6512007)(6506007)(26005)(9686003)(8676002)(36756003)(5660300002)(316002)(66476007)(4326008)(66556008)(107886003)(66946007)(1076003)(41300700001)(186003)(2616005)(83380400001)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X3Nxbechh5VKzGMr5KA9NmnqBpI3naFwGExx23zxiICnd4RPBUQs2smoBZdC?=
 =?us-ascii?Q?NPkzMAZX3YRSk0QTuQaRTG+4hT/P/SEGly3wuhzsgXyIYdhPz9El0EapwCp/?=
 =?us-ascii?Q?+f4KDSRWBZAsICP4B6G3UoEfzr5MsDW/cVpEBBjOPVTKBXj7ioRi2DpcIoK3?=
 =?us-ascii?Q?506XITmyPZHhfHzSonFE94A/K5ZR9wIS4rBNCUr9r73bJCFOsHPA5WwUqvPs?=
 =?us-ascii?Q?q5unGeXgaKuKz1nfu61rn4YqDfDHP161MqtxZg0oV3GGWHAC0/xX9z4/FJuO?=
 =?us-ascii?Q?XjlHlcl1GYAzc2D+KRdsuwoDu6e4iqryTmf+lfT98GtjLz/s7pFN5VmEmUeX?=
 =?us-ascii?Q?IOYX3bnDZhe61/P4BQVTtsxoRBuZU/JXJLXonkrnx5qmmcdvmCgk8wZU5Ti+?=
 =?us-ascii?Q?qqfQrP+KI8/Ohc5wsHSu48ZRE44M9A+/XzYRDbuUgwSe7hfNyXjckSasdBq6?=
 =?us-ascii?Q?yHXai+wQV7H5f//eR3lnSB7baYj1xOI5tddBsb1ukqsnj+p75XgGIXuVVNwO?=
 =?us-ascii?Q?K6WLJHnexRQNiyi72HfES/Ej7fH6x8EqopXEtwLEVokacet1PxXS0/GEv4RB?=
 =?us-ascii?Q?EYw6zQ3yVY+bLjU7+KbLv9cj33fLHSILgwWdJdCJRuy3cXV8/atVWuOYuSS6?=
 =?us-ascii?Q?q6qA4Y/5xDmH10qkXDqnrBtumIOTiI9YjEg8E2sn0ZY8caGlO7uNwKPJH7Gu?=
 =?us-ascii?Q?ewcgydrVDJAQKuZB4398xa/0wJoB6fmmZ9cVEgYbWsK5xeqAWbYhRLbnLRvV?=
 =?us-ascii?Q?K6FNcYb72LBupncAobZLbCF2vsUJx5R+DZqk/yBYGJOKfJlXY5PYe7I2Pc9M?=
 =?us-ascii?Q?65Oab2KpsKKFJD8Kcjm24vvbKX82QxfNczwS4Eozkf5ZZ0UP4uCcX/wvOYwC?=
 =?us-ascii?Q?v7XmFFm5ApzYydatylcPQKwT0I0HCwoIOQxwGjtKU30fVtLlZm4lsYHZGRwC?=
 =?us-ascii?Q?gpA0QISoBlxG/4nWxbmT2B1m6qNpjGeM8hRvRYHCiSX0hFg5qwSY4tKSJfpx?=
 =?us-ascii?Q?JwiLiQ8I/O+WLmHTnU1FTPzboIwHdxRMsGdZsAa083ye58YBCGrnMdW8Fpbv?=
 =?us-ascii?Q?dCGLhgvBNYhNdXU+cjlc+otNxsyfQvmA2nOz4Z4gSNh+XfX81gUiWo6oIp8F?=
 =?us-ascii?Q?9lGp49cAQJ8GWuheYZT95wdA28A2u2MofxGXOwrj2wjwis19hrlVMtLAnzlx?=
 =?us-ascii?Q?arYVHsDAHY3d/3qhBnitU+OQ7I0OU8LLHoGHFbLLhoDa45Jdcfo2nh10Bctv?=
 =?us-ascii?Q?fdy3OVRHCBTXmUbSLTGQGe/OQ5Ca+IVCIJWGNEtaZYokh0Yy54cIk45Ef4E0?=
 =?us-ascii?Q?SiBOXchuQT1eLJCCL8aDBQx7+OPL2BoimIYaBRuo2GU91Gsoa7SivEZjN7U5?=
 =?us-ascii?Q?UYJ7DoJD6+te41fmyHC3BRUN9OU0yCliposmhAiv/zmSn3/Xv0NlpvYr2njA?=
 =?us-ascii?Q?P7tl7lwSQjs28HEJo1yO3yNd65hDaVEtwSHPY+izfTVWTiY2oHZN5ZXBT/PM?=
 =?us-ascii?Q?cwBoRyesqlU5tt0VezuFIS3N63fs7CduV7RigNvcNrHoy5LLcOEaOXlkUWI1?=
 =?us-ascii?Q?PesY+FbiijrU9Zk1wFpSxsM1xm0AkDFP4uLgXqZG2MPzGguUzUmv0+AEtTM5?=
 =?us-ascii?Q?Y4tNIn5+cnJVx8l1cq1O2yIdmvezEJEqVerkUd9Miigf0ORLyYrI5O6R7Nu7?=
 =?us-ascii?Q?NuV7tqM7O5O+dW2I4AjJGWfIB26asW48bDtwy7L5H9JIVPi7U+aamtdC02JF?=
 =?us-ascii?Q?Vcy+kHU2HWiSOd9PGpOVToUh4fuuxVM=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f93661-c531-4029-5da4-08da3d79cfc5
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:37:41.3907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVGt1lrUHsTl2/zyHk6OgWDWqa816rEFqqmMKGfmtJZ8Pr5pKV6PmYahEvrYlq9jlwTKHxPezL5onSMwOOr/Kg==
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
 drivers/net/wireless/celeno/cl8k/bf.h | 52 +++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/bf.h

diff --git a/drivers/net/wireless/celeno/cl8k/bf.h b/drivers/net/wireless/celeno/cl8k/bf.h
new file mode 100644
index 000000000000..efe433f55f7f
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/bf.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_BF_H
+#define CL_BF_H
+
+#include "debug.h"
+#include "sounding.h"
+
+/*
+ * BF (=BeamForming, 802.11)
+ */
+
+struct cl_bf_db {
+	bool enable;
+	bool force;
+	enum cl_dbg_level dbg_level;
+};
+
+struct cl_bf_sta_db {
+	bool traffic_active;
+	bool sounding_start;
+	bool sounding_remove_required;
+	bool indication_timeout;
+	bool synced;
+	bool is_on;
+	bool is_on_fallback;
+	u8 num_ss;
+	u8 num_ss_fallback;
+	u8 beamformee_sts;
+	u8 nc;
+	u32 sounding_indications;
+	struct timer_list timer;
+};
+
+void cl_bf_init(struct cl_hw *cl_hw);
+void cl_bf_update_rate(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_bf_sta_add(struct cl_hw *cl_hw, struct cl_sta *cl_sta, struct ieee80211_sta *sta);
+void cl_bf_sta_remove(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_bf_sta_active(struct cl_hw *cl_hw, struct cl_sta *cl_sta, bool active);
+void cl_bf_reset_sounding_ind(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+bool cl_bf_is_enabled(struct cl_hw *cl_hw);
+bool cl_bf_is_on(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u8 nss);
+void cl_bf_enable(struct cl_hw *cl_hw, bool enable, bool trigger_decision);
+void cl_bf_sounding_start(struct cl_hw *cl_hw, enum sounding_type type, struct cl_sta **cl_sta_arr,
+			  u8 sta_num, struct cl_sounding_info *recovery_elem);
+void cl_bf_sounding_stop(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_bf_sounding_decision(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_bf_sounding_req_success(struct cl_hw *cl_hw, struct cl_sounding_info *new_elem);
+void cl_bf_sounding_req_failure(struct cl_hw *cl_hw, struct cl_sounding_info *new_elem);
+
+#endif /* CL_BF_H */
-- 
2.36.1

