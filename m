Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775DA623D58
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 09:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiKJIVp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 03:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbiKJIVn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 03:21:43 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2055.outbound.protection.outlook.com [40.107.255.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0961F2FA
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 00:21:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiT151wi32tr4DlxDwlEaDP10TSemdpixER/brhHEgZyjyTrcgolrgrpADdU8v2k1+M/asFs2hR65dqxVxz7BF01SUbfe0foH2EwQzO9N7V25KJiSLwX/o3VlgE9CCyULCguNpDjw4v68/8gU01DqY8aHE8M8EL7G1A/PujSERXzEwJ4Js1PJeKIs807vdehPTHSzyJQKNd0TwLyCpARzl2GDzr7JQeNi/dyKSh1FE94q/cz++/8sxegnVN32NVPSYstQ3SLAbJSa1WO8uwA2pS8o8N2Tm/rXQx+NS6BnXFEsy849sFTJiw45FQbmegIUCu2aztvIHOpApvy2xWy/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1dr4y7TI9WP/TE255iC3ADUMJ0jfm36jfZn1SyZ2J4=;
 b=iEpCr3ZAo72Bej51JaU70q37lucxm/5AdJ6V4A5Jr1htg37CTjBbOnwX0i6fBBoc5VkiPaH0FBGlC3hAmGVU5rc89ZZhr/Ohbp7uy9gAmjpN9BB8dsuwVgo/Do3tyBgRV+/BKM+8Yy75P8/YkmWIf/tIYHm8aAJsd78LMl9W4XvHi30hmKa4P1TesGxhJtIQJR4Y/MuMN9koFI3AondxeoNiTPw5LEtNIQaH8mT1uTfIPIKGpjOwxMJZi1zCXggMweDPlBmQtvUJPZRYfN0o7Lp7RKFO3/tpSRKnvrPjha1Fxj0EV3xA8pcnSDWEIcZEbSDtq4he6kMXepU7n5KVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=newratek.com; dmarc=pass action=none header.from=newratek.com;
 dkim=pass header.d=newratek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=newratek.onmicrosoft.com; s=selector1-newratek-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1dr4y7TI9WP/TE255iC3ADUMJ0jfm36jfZn1SyZ2J4=;
 b=CWD/540ZiaBrA3sy2VPD+ZwXxPIsUGJg1iqSpwJdCtXEDda+g3VWbV/RY3r51h/dSQgnyAipoRzTggPkibHjC7X/IE2HFQGgQyggq72FCGc/Rt9f7FoK1/3utfYgnBZcCccrlDgiVQws7ChYuTrumjd8EJM2Z8z4p8D/SnZ92OE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=newratek.com;
Received: from SL2PR01MB3291.apcprd01.prod.exchangelabs.com
 (2603:1096:100:58::18) by TYZPR01MB3950.apcprd01.prod.exchangelabs.com
 (2603:1096:400:38::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Thu, 10 Nov
 2022 08:21:39 +0000
Received: from SL2PR01MB3291.apcprd01.prod.exchangelabs.com
 ([fe80::81c0:36df:75d:2043]) by SL2PR01MB3291.apcprd01.prod.exchangelabs.com
 ([fe80::81c0:36df:75d:2043%6]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 08:21:39 +0000
From:   JUN-KYU SHIN <jk.shin@newratek.com>
To:     johannes@sipsolutions.net
Cc:     jk.shin@newratek.com, linux-wireless@vger.kernel.org
Subject: [PATCH v3] wifi: cfg80211: Classification of BSS with different frequencies in the S1G Band.
Date:   Thu, 10 Nov 2022 17:18:00 +0900
Message-Id: <20221110081758.16927-1-jk.shin@newratek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <8a1c1c6ba925b03920fd491407ad710d6bd0d80e.camel@sipsolutions.net>
References: <8a1c1c6ba925b03920fd491407ad710d6bd0d80e.camel@sipsolutions.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To SL2PR01MB3291.apcprd01.prod.exchangelabs.com
 (2603:1096:100:58::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2PR01MB3291:EE_|TYZPR01MB3950:EE_
X-MS-Office365-Filtering-Correlation-Id: 5896691e-b8bc-474e-f369-08dac2f49728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GpcI1IyEVQcGbJMYSpXX76Faa5REhoSk06wz0wn2Jb0sRp9jXVsq3bDXZR63UK0RLjStxCzeD7MGjwBX6tSNJ393lQMccd2gijgEJSdANxF0DCAg1LTEOfsxFCkwjdfFWUZSTYkUZ0/IoWDh70+y3dhkO2MLMNilti9YDLGXOfT2KAF+Jm/8o0jDEbo2mebSvJnoSKABEcZQSIL5JM86YZz4GAUptfDYapQdkiRsBiA4JtWM2yptPKGqVN2P5DQ9YKKLGqWG9X4Ggjpn0+lA4yslT1QcfWzurzGUJeteQHqMSTLIBVIpxKXRvFmtVM/cMKUXkIkhHrVRtwK4817jnKyK2VXomVo0/ZEARsfm2LuA6TPFITudW3nKznZYwQjnell+yX8YOtrhi0WTuwbZd7x9IMNN8GlSXOybWVHs00ti+424PSBtetmvxD5kJCDU56BX//XIxNQVYMYoj7dqBWrThnbaaJpLJI00k85rblyu/6of431z0b7emZOO1QWKj2ap79jYuRDMST01e/BFgCDGE8W5ylKrUNwyVTHkTqRg5T/2aT8dSMzqjjnePkCFTxuZAxI5OK2v37WVFVudmwOOOWNWxD7cZRmQVUHTKOZY71U4b8Uj4gIOJL2YXJfbXiQ4ST+yaAHsobLQP1n1so4SQilrA7gcptD+t2WuCZ1YJRtRekZjNjkIGXsLGWHpFsFEsckZAW0+yWxnZZD6LithCskCHd1DOay3c5C2yJKHS0HLUt3K7XSXnm6cGmk+hQPcn734yuEw2mzA7+xphA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR01MB3291.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(39840400004)(366004)(376002)(451199015)(66946007)(86362001)(6916009)(41300700001)(8936002)(5660300002)(2616005)(38350700002)(38100700002)(478600001)(6486002)(2906002)(4744005)(52116002)(36756003)(6512007)(4326008)(8676002)(26005)(66556008)(6506007)(66476007)(316002)(83380400001)(1076003)(186003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h27aVTRVaJAgCZUdSeWrIg63Dd9QXaqcWJyON3jxqauG7+KBXPLKd/gB35k+?=
 =?us-ascii?Q?y8SzKXHGkghDqYpc4mCzH2EyLlpg6ceBk6fwRaLAYtLVLVZyVPeVw/qByR+m?=
 =?us-ascii?Q?/0ZYmuUQVHsYgGVOUD3J6qdci6doC9eqYSIc/zxY/gzbLNsZk1M93jGdtM2p?=
 =?us-ascii?Q?F6kBVbsgBjigFbJsO8txLLAkNOIxNrtdrDaa7Bk1gDkL+Oker7mUPXucxJrW?=
 =?us-ascii?Q?Hk5S3K7IH9tGyM8JO+GfKkUDbPtPVEAVPx5EsjyXqYX57YTcDrVquxK4d/Hy?=
 =?us-ascii?Q?iZEX9Mv359dRRL5K6Bbq3NdQBac52VOiLrl/tjjikvVm7xciljnXGRIeXQBv?=
 =?us-ascii?Q?iTC2s0JCAep3bHuQFcf13/vGZyS/3c46BQEO4kWiy3Cmk+uu1UkZYIpp7Tah?=
 =?us-ascii?Q?lhfQHByNT/DjzY8Jl3PNbALaHq8WXeNtcWQgwtH/uwk+A/LJb1T3cjaKEmmn?=
 =?us-ascii?Q?AETqDfONMjYTnpLL/s1fF6sbAjZ7d3A08hdjIs3/tA9wAorbf+lL1mZNHkt5?=
 =?us-ascii?Q?bfq8QnrBAb4RPK/QUZPIsleQO+k7piKSmVCHRlxU70I0HTcP9MOK87IptDfs?=
 =?us-ascii?Q?t0HsGNzmvkuFsl9UvJY0fe6Mg8IuXVXrRDMhpLh0uMZIk/4L+NwxvuX5HzYy?=
 =?us-ascii?Q?beZ0f7/342OlZCuceDZdThxeJDpkOkpFgqq26NRoDxePptsPXPS3k3kVXxTe?=
 =?us-ascii?Q?0werV8K+JKn927fg7r+Q+MGN/UBiHheiwnm/6Dpo5tlvaifJpcPPe9+T9M71?=
 =?us-ascii?Q?klJnVkVD51EBdeVKFm6Nwh9kclbu7grLrj+XUGjhJDkPS68ugGIqqBGwI/k+?=
 =?us-ascii?Q?aIoL7igKC7/rZfbGCo6XoiDnT69kQPCV0ZD6hDhP29kyOsQr/XgnB6g7R9H6?=
 =?us-ascii?Q?+MnFjxtbAVQcc/qOny7g26y6bif/c13UaB435T4MKWUINegba+pv6vsP8qgG?=
 =?us-ascii?Q?qj3hVAShMNvU/ovFpTgJQLahiMMSTS7Cgg1Nz0+xM+6Mvs6+XxSdonCDO++R?=
 =?us-ascii?Q?D7QdejBn5PDhoChVIniVn4kWWP/GZtkJtlMgZL8RLytnkt/TuJT/Wa4TijJc?=
 =?us-ascii?Q?4on8QRYs039R6RqFQJLP3LDIeIOZiYPIN6bK4fQMWXMYHK++z6hJlTP8hzOq?=
 =?us-ascii?Q?kKyktzc56JwmZA1/PmeFt5Ui/IoIWzr49i7BLrhW/YZEJGkaqo72k4Iqi1Vu?=
 =?us-ascii?Q?gaIKcvKdqRDBnf5P+/IFzU0xpWQv3lG9MP3R6rWeosQGlPrhs0PzAaR4jax3?=
 =?us-ascii?Q?/PhLOdjaYBZpBwmJMkHuiXkBLSN9zRiup8FT1wpWDEl2ObBRNXS6RBvCTYKF?=
 =?us-ascii?Q?ef52AdV7ZIr9IxkH4vVmp0pRYc7jlzf2eHc4DkpmgP8JDfwtM3yIXN0/j3/W?=
 =?us-ascii?Q?tpc5CSJlj/tOuTKvebP8p5cTQqjSwXEL1ewbCz2ZmnSRzP940+fuqA7Oaf2Z?=
 =?us-ascii?Q?uivdYvXj26IxcN7P027rkDxi+vOaf37gaz4c7vUxrrGWs7Q1zqXVv875k0qW?=
 =?us-ascii?Q?3rdnDYsgGYRZ6Omaup2XmR3hQ1wm9/+QN+bDtojzyal7UcTjK3AkNKLe8Exe?=
 =?us-ascii?Q?uVPispQZ0GmxxC4XpfwCEYmPvw60J7pB9LiWstX7?=
X-OriginatorOrg: newratek.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5896691e-b8bc-474e-f369-08dac2f49728
X-MS-Exchange-CrossTenant-AuthSource: SL2PR01MB3291.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 08:21:39.6448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5494d269-d3ac-4a40-bf0d-8c29f5475032
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxPCD2CzWtc9LGkB8ML5esUB671fcETPrXlqYRSvzJWSijuN4EjtJPig0lIhtFpMqg21fi7NFPOKsrgqz3siLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB3950
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If the "channel->freq_offset" comparison is omitted in cmp_bss(),
BSS with different kHz units cannot be distinguished in the S1G Band.
So "freq_offset" should also be included in the comparison.

Signed-off-by: JUN-KYU SHIN <jk.shin@newratek.com>
---
 net/wireless/scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 806a5f1330ff..6bba130ea670 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1289,7 +1289,8 @@ static int cmp_bss(struct cfg80211_bss *a,
 	int i, r;
 
 	if (a->channel != b->channel)
-		return b->channel->center_freq - a->channel->center_freq;
+		return ((b->channel->center_freq * 1000 + b->channel->freq_offset) -
+					(a->channel->center_freq * 1000 + a->channel->freq_offset));
 
 	a_ies = rcu_access_pointer(a->ies);
 	if (!a_ies)
-- 
2.25.1

