Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA0453293A
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbiEXLhr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbiEXLho (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:37:44 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150084.outbound.protection.outlook.com [40.107.15.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E814C798
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFNzUVscc2IkkHmLnLgmfue7Ib7INcKZTLbdZAsvYDMWTL3UZiEBKmAPBRLqgsSdU8YOpSxbMvX1r7rZwfFx2MeMzsyX8zbCFRrMfKmvMduT9/rmH78bVpvbqRYrDzo/y2EQUaGny+GzqsAoKguh+VTtQtA1Lej6DBCv/Jku9jE4udwC0x0OD9mmsk6fu1aQPI3eBQcUbn99V91pgaE5lxnowbRv6sD7bqPlT+BOAfiItoAoclo2CzWYvP/UvrxN8/ZdZauPjfqAHzi9GgYJJNiO4JMhpfoVrBL+gNb+ZmFxeGS+pLXF0OAd9L0LmWBwzKQFAkFMcO8x2j3cAvh1sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXQoUGCypQEtzmTxrkaO7q/cSd9t758qDLwK3u8/EFc=;
 b=huLl00MLlhX3x5q6Zr0D/26W/YQ+4svc6gxvIbSVj3VOuFGBFlUvRlBAD/rLAeIF4QiFOJAnXhi72PBEgYuOPIB7gF0pLOVN1dz1AfntLMt2B/smNKkjConAZSThw0PEii+XjqdVLnUYvAdQqJjetT8zfDC/CtOcuXTQEOCMOzE30ch1FCws7ZkONORUiSIrDViz92ZioY+Rk9M5nIX52zy2nLLpOR7f2v/UZ2EQjwWHsEhNWguaVqH6TvsnijZaT4HdUJqLSBCuD4O7uv8VHMUaDINcFCPTkvJn1pcXUE40upzThKV2KMNR2YFezewJZA22ZymOlSaYLKkXFfg7iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXQoUGCypQEtzmTxrkaO7q/cSd9t758qDLwK3u8/EFc=;
 b=SvDQos0RMufjRwtDeRjw6PopR+FpkteHHFHb8f6L/0d2E5HPKe7S+N2t3oXIZDfiIkEdqXJFv51tOqV78KjYf7rbSvPB/F4BMvFluFPEb6oZMImlcn9pm4V05Pf5j8muJVIK1/mC2TLAsRjQ0W2w0bgos3WraoQr0rdoYUIzBSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM6P192MB0501.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:3c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:37:38 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:37:38 +0000
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
Subject: [RFC v2 04/96] cl8k: add Makefile
Date:   Tue, 24 May 2022 14:33:30 +0300
Message-Id: <20220524113502.1094459-5-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: b9438722-b8a2-436e-03a9-08da3d79cdc9
X-MS-TrafficTypeDiagnostic: AM6P192MB0501:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM6P192MB0501CB2F80B61AA02960A2B1F6D79@AM6P192MB0501.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fcIqv9eSs7PLL1OIoo/4ugfKMRZfqvpzYAZP08XZXXJ1F9DzyqTrJBXLlrvgdFWPAB/wFqQi1NtzatSX80FuIgQlcgHaq+4vhJlLgiVRcNlF7UaFq5g/SGfhzqL6cSNMyQp5fC0/tn479npEEvfrLI0IDmvyMQBz69GR1Ke5X66U81kgeCyBcpl5Iy0h+6/bR+VKpZI8R+FZmDnjXx79CZ7XimX5oC8OMQJ2gYNP4Mokdo0d+wcvWrMx6wIRQVCCit0TwPXkrnIqXBkOpnECZt7+vBeAnjL8lqFChYdUjI/dXLtBOvI3hUJRIkVxgDkR/5+dqFncdwf+FcwN0FAWOLZS+Ipd46Yo9n7KPw1cyBG3eM8FfEYR8Apca/DtQviNCBkEOn1vH4Fzh/MVnlNn6OPWId2prwIsSXH3fr2/yPOY7mieJPT+VntWfGCA6/yTkWEJbALQOaAugVLzPrW75DfbLWAN6JQnoQxCArrjjxj0nYZCjY78Rz3Az4kY3MCiEZ6dWUB+oFSBWDpDkmV95xAo81Q3ic4WtP6YLMGc91GSGQtuoIpiLT2G4KxJPBHRd3hsytZJppJRH1rgcUXzUOmTV771+T0pbQh6co7/aHzYIFw4u5+iCNCiwCHnegDM+W26l4jtpwpBWwvMSfvlxxS8scDkhKAe4mkj9zal6TsMvizLBnttQUf9deBc+jtLHUQX7e8rkR8gg/E+0OqoYAoYad1lEzsLiX7Z5tq+5vM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(376002)(136003)(39850400004)(366004)(346002)(396003)(6512007)(186003)(38100700002)(2616005)(1076003)(9686003)(86362001)(6666004)(6506007)(107886003)(38350700002)(52116002)(6916009)(66946007)(83380400001)(54906003)(6486002)(4326008)(316002)(8676002)(5660300002)(41300700001)(66476007)(36756003)(66556008)(8936002)(508600001)(2906002)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KkDoh9c6GkLwuJVs7P9Cy6HbmTUQVbUB8EDOLsX/WTEkyEWaMQ1GleYmWrXk?=
 =?us-ascii?Q?ZwQ+X5rdnNTq65kw2sGPqu8UG7zn98d6t483XkGBLbt9I0BR0zQqiYn8qE8W?=
 =?us-ascii?Q?EXRuQxgrO43rmi12CmwiR6osKQd1oxECCbDFU9PEXbO7l1ExxMisoSWPdagw?=
 =?us-ascii?Q?rsfLOrzQC5nD/6oxUB4y+ZGF8ZrDiMeWn7jUt/UM0qlxqP+ymnp1ICKWDW9S?=
 =?us-ascii?Q?8YCN8X42kKWzbu4kDAAsPfkh1/fippzuUHGGhDqfNqbs9cQ9o5oqc63YLvoe?=
 =?us-ascii?Q?2zDAtbnWxlb3QrwLy9p6AEnBPlo+3gQaBTad4WQBIP/fshS/Dl0z1E/RykcJ?=
 =?us-ascii?Q?6VFBidoyeaxJz2RGc6HVXhAz7EMSsX0443Dyv/YAmbPRGlPiv+V3UtuKi/F8?=
 =?us-ascii?Q?AaEnwcJRr+ttF8vgPhkLXDNLHyCs078VL78ICHa40WcugGGUQW3rso/KJS74?=
 =?us-ascii?Q?a4VSWeWCUOBS26RnUNfPWuKTIO++XtXImTmzkX+mnQFFbazGLruqu3yfq7zr?=
 =?us-ascii?Q?teaCvgQD5KDu5RJ8LiwZOb+3U5ow7FCdQjZQJbzjLCQ+D7Q/pkm1KBi5yVzF?=
 =?us-ascii?Q?1eN5BAdG6DBDPkRWfO3ViJhi4ON0dzQK0mLlHDviTjzRLn0RYcNxMIlKQnIV?=
 =?us-ascii?Q?dq0FaQxCtHXwYa+wUOg71iP56iMNA1UoJPQiMDMLPvI+I/TDNOzKqMf4zo/4?=
 =?us-ascii?Q?2jwJtnTPHwUjw7r2weoYO2uAnKw0OMIQeBiVteXW//7HN6kEESu0mY/J9t0O?=
 =?us-ascii?Q?eDmo4g62A9bICW0F0f/158YG0SC+1xh74m3Kg8RZeqab9tx+zMNbv/pbThaa?=
 =?us-ascii?Q?p2IC+EHwrFo+fMjs3M3kbipb6v+fWOkSN7Yus1aur925FcshRTVVgy5SsNuF?=
 =?us-ascii?Q?Oi7g4NyeavbhjnOUGU1yIkDr3WhNHHSW8m4sbPNA6s9mCpYPKnO84FbrdNKM?=
 =?us-ascii?Q?tFntluJ0RzXWZAH5K7LeE5vDnnRrF7ZXZ31FBnwsRPpbGX83yrlFYiu6h/Pr?=
 =?us-ascii?Q?9RN920AJgjUMdQU165KOCy6S5keY/U1KVCV5eqYkhlqp+SiD52MfZPLi3ilc?=
 =?us-ascii?Q?TY0NRdHbiwlqnZIS0fGcMOghePtNNxF1fe9SaR2862etE66Ui1LTLIDTqhKE?=
 =?us-ascii?Q?mqjA/UqO1rSEEDokt3nZ6OzRcDsPk8YbfU9tKwgPB2hBg4XWrVIN9nr+8YFb?=
 =?us-ascii?Q?CK+59mHU/+18mfY2MtoVaCBPkulLQzz1W5xYAfBubM4dAevZl+z5GJV4Z10i?=
 =?us-ascii?Q?3w7svE+xocbdoBuA2jZq6krtEWNa0YfYXHGeggypulmgz265c/C/+sywkjks?=
 =?us-ascii?Q?XfrCwoDRSBM7VjrOq+bVQngp67IK6YLV2bXjHCz+v3HhUj/OzMDzjq1YCa19?=
 =?us-ascii?Q?ofPoyiGUeFF+SdTEVJm7uZ2MWWk1czHDUPxYN8EjrxpsfLz2ImHYyRUZMHFn?=
 =?us-ascii?Q?F5S3rAp1KrqhmDmYMce+bcrEfTQopq5shH4uKwlutJ5IZesKGoEpHfvODFJ/?=
 =?us-ascii?Q?UBuhJiS+dijiBdmgdvc5YZPODD1QP8uvvz1vbELiNamTay0baddyBqVZ6VI3?=
 =?us-ascii?Q?ZmjE9kZVgvBxCsTDQ4KOvgGil+92iaU7ugx9H6mqIrbD6zxj+5naQc1NrXKa?=
 =?us-ascii?Q?ATJdydTypDb7rSVo2x3M4G38x7k0B+6Qlj27JDrNUECOkB97ju7rpsiTpRlQ?=
 =?us-ascii?Q?PcLiI/9H7tVo+0QhgJTQ1WgtIJxN51WvXubHa+DMB7zODAj0V44lTsQaTaWT?=
 =?us-ascii?Q?Mv/+XFyaNznXsY56+o0zPP6FNySQT9Q=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9438722-b8a2-436e-03a9-08da3d79cdc9
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:37:38.0592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVZCcgxC3Tckxsl9V4moCOTSnHPUDXwFmjI6OfvlKZO24Vqj6fBha16ob8lHJjFNMtiGKtrzs4H5WJkddRFifg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6P192MB0501
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
 drivers/net/wireless/celeno/cl8k/Makefile | 66 +++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/Makefile

diff --git a/drivers/net/wireless/celeno/cl8k/Makefile b/drivers/net/wireless/celeno/cl8k/Makefile
new file mode 100644
index 000000000000..9ff98cda5261
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/Makefile
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+obj-$(CONFIG_CL8K) += cl8k.o
+
+ccflags-y += -I$(src) -I$(srctree)/net/wireless -I$(srctree)/net/mac80211/
+ccflags-y += -I$(src) -Werror
+
+define cc_ver_cmp
+$(shell [ "$$($(CC) -dumpversion | cut -d. -f1)" -$(1) "$(2)" ] && echo "true" || echo "false")
+endef
+
+ifeq ($(call cc_ver_cmp,ge,8),true)
+ccflags-y += -Wno-error=stringop-truncation
+ccflags-y += -Wno-error=format-truncation
+endif
+
+# Stop these C90 warnings. We use C99.
+ccflags-y += -Wno-declaration-after-statement -g
+
+cl-objs += \
+	wrs.o \
+	phy.o \
+	key.o \
+	sta.o \
+	hw.o \
+	chip.o \
+	fw.o \
+	utils.o \
+	channel.o \
+	rx.o \
+	tx.o \
+	main.o \
+	mac_addr.o \
+	ampdu.o \
+	dfs.o \
+	enhanced_tim.o \
+	e2p.o \
+	calib.o \
+	stats.o \
+	power.o \
+	motion_sense.o \
+	bf.o \
+	sounding.o \
+	debug.o \
+	temperature.o \
+	recovery.o \
+	rates.o \
+	radio.o \
+	config.o \
+	tcv.o \
+	traffic.o \
+	vns.o \
+	maintenance.o \
+	ela.o \
+	rfic.o \
+	vif.o \
+	dsp.o \
+	pci.o \
+	version.o \
+	regdom.o \
+	mac80211.o \
+	platform.o \
+	scan.o
+
+ifneq ($(CONFIG_CL8K),)
+cl8k-y += $(cl-objs)
+endif
-- 
2.36.1

