Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F710623B76
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 06:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiKJFsz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 00:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiKJFsw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 00:48:52 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2045.outbound.protection.outlook.com [40.107.255.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15275101F6
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 21:48:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKXD9M1fSQrXggDHHEhwpR5XA7KMrCwJjvGOcEGIjvcV3qLMbKV2ENITQ4SYina8DpP5VDpOTylhsivoNO3qbawjua3j3pjXk74FNmW7gJ9PAYEhjnmNOM2IDk2xXZC3mA2dIOCNYPzvcKSOw7wlqKcyivdxc2s3acsqCJX5yH/72Q1eTDGu0HxXfFJF2VnZf2YDtCUARhVLuMtFkn8wLZugF65MKN3/CfAKyJfZNGnR3WQv8YjIar1ikwLwcnTeBPoEr5FEgREl1xGTagMYUXY0RARZ2f0GH3vrhhibc74QwXI5k//W6y78Jvw3hQh927cduuNrf4OOu1lmWs10Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVxvOFej8PnNb47swldYroSjUsWKwF5DPzhuoavu4Z8=;
 b=IUOY9Kwyut4itTUKvJwawW84Bpb9G2zExaVhLW59XuO+WGOTy1PF8g+C9aTUIirHH1v8Zl2PUhUCEaA2AsSq752L7cRCwLvDLCRbqQkDxo6z9giN1F/C4MoRXF72lzl+UuzXV27eVduhUrttbDzRh3bDHOU+y9ZWopN7Yfi//iZVhMXIeKlaH1r7zWJUUKCiD/iM7YzKo0QtZIBtNaByNVODBjRmWcge8xlpThUvdkqbOOoggf2TLA05G5Hz/T0eInw692lSJAqh6Q81mMPwqT08iXEdlS8I23Ajc88VONE0zjaBcCPjamY7Be4dNtbX56sIBImX24TzL0ao1L2Qzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=newratek.com; dmarc=pass action=none header.from=newratek.com;
 dkim=pass header.d=newratek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=newratek.onmicrosoft.com; s=selector1-newratek-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVxvOFej8PnNb47swldYroSjUsWKwF5DPzhuoavu4Z8=;
 b=otcE9gNtHcETMe/RwIjyp8jNOnQ1GaCsMYgCsoYxlzmzaSJeRskg2AQsRKU8hcz8jJsq5a31r5G2R6psvyOzLWLTkkzk5mIUKc+Gnm+DWr21a7ZF9+s8hP2zl+/+FLtR3WUBLouKEj+qJit86zc8YPbHBj1vWWzWugpbJwQln4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=newratek.com;
Received: from SL2PR01MB3291.apcprd01.prod.exchangelabs.com
 (2603:1096:100:58::18) by TYZPR01MB4258.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 05:48:43 +0000
Received: from SL2PR01MB3291.apcprd01.prod.exchangelabs.com
 ([fe80::81c0:36df:75d:2043]) by SL2PR01MB3291.apcprd01.prod.exchangelabs.com
 ([fe80::81c0:36df:75d:2043%6]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 05:48:43 +0000
From:   JUN-KYU SHIN <jk.shin@newratek.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, JUN-KYU SHIN <jk.shin@newratek.com>
Subject: [PATCH v2] wifi: cfg80211: Classification of BSS with different frequencies in the S1G Band.
Date:   Thu, 10 Nov 2022 14:48:02 +0900
Message-Id: <20221110054801.7992-1-jk.shin@newratek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <45be33863c53edc5be261950b2592a777690a353.camel@sipsolutions.net>
References: <45be33863c53edc5be261950b2592a777690a353.camel@sipsolutions.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To SL2PR01MB3291.apcprd01.prod.exchangelabs.com
 (2603:1096:100:58::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2PR01MB3291:EE_|TYZPR01MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: db5c584f-c5e6-49a5-0659-08dac2df397f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XpmqHAyhXzQwQrSNWL0b+0LvHyaXg21b3VTvNsJqcDyQCfTTIUfjX69GGUcB/6M2LDybaGj9DsSK/Dhz18astqfu1jrncrpOimlCvKAyummarpwGLQHqiy2vdTZx7A3VD1DsNg4yUxOFRtHk+TDqele8SmHXgdAfB5GIgRYwwB8kiyR7S4dXc0aQZIcfbvY3Wd9tR98w5jQKdt5/BFNSxhJWM1FX/AS5tN36pF7iLDnxyOzB2ZexpWl0bgNXP+R2e01ZCEGHJ1CxGqohnp9KXM4FRGBKmz9mlzFzCGty47/pi8MhWBu8XGxrwn0dQSh85iMJXSRzsSss8/oAeegwNVKatA8m1f/A3S/6GrBjPhj3BL/9QEYB2Yv2I0UVs0R9HJ+UCE3WsrOjxXw761XHd/OU5WCyxrkT3nGfK27M1C1Ub8n2p0ej7StPEoZ5/Dmk9ylua3Be0CwaVYBPWW57eIz1ReyBTKjkVqSeYj5eBtPTFAaG5hnqZQg7C26iHIigJBPgwTonv47bCNu183DCzSYnJeQOcirIwNvpsjNGxHweJlC1evlr11lvfbBLawK2NKOjQQyIN/a1Cg8A3jwcCZ3Efir1gkkSDc2fmMT1scx8Nn7PKP5kTquemBMgn0xc7RQc6ZQyt5M5zhveFic2k2uaE95eednAjd7fkmLii7/F0dJ5aUUnCZmceJzMqhKbc5qK+jhKT7Osl2x6cN5q/qrRjryYS9mEeCqBL7VXTxLuNe7TsI7OQKAIcFMIdwRpWUx1eojOp9s0w0Dc/ypHjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR01MB3291.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(39840400004)(346002)(366004)(451199015)(2906002)(86362001)(8676002)(38350700002)(38100700002)(66556008)(66476007)(4326008)(6916009)(66946007)(26005)(4744005)(41300700001)(5660300002)(316002)(186003)(83380400001)(8936002)(2616005)(1076003)(478600001)(52116002)(6486002)(6666004)(6506007)(107886003)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?60SDX3pm2WWR2FcdS72FuOFUUFokQxG+Y3zWImVuiIk6XaF6oZn0fsufSrfK?=
 =?us-ascii?Q?zz3yLSMAD/RHOqydw5j6imurWNteAaQXOStF8N8Yb69hUIFhN4E9ic+KXUY3?=
 =?us-ascii?Q?RKe4LXwcG5NFZFFv818dck88G9i6GYMqPvfZIMAx+EYrbVdhclk4rka0Wgdq?=
 =?us-ascii?Q?FkrJfg8IrrKzhMxS5xhaGg2IxPr+sfeVuhenrT/nsaDFIDkmPPyUdSLRjR36?=
 =?us-ascii?Q?VV207CjgjQFD96u4aTLunQcRrgccfMz0xuudxMUUW3ABGB+wOFH+LvVowq7/?=
 =?us-ascii?Q?RJDGN21AKzBkb1zrMU3TxEodTfO6SYKBLqdBeNq4+HJn+qV20ZDRLl+dPUW4?=
 =?us-ascii?Q?Tt7NMjaR4faKSYUY+DDmpz8lXhM8cRXg9shCLaBOx3nB3kZVY0c8hdnyBrIw?=
 =?us-ascii?Q?/mXO7OcVdey0OZN7bvAO6quiujYOZDf0vcHKq/m/aZXQqKHtXnZfKj5dkQwn?=
 =?us-ascii?Q?ZEibTxMWtGicDSI2ODlP+j0h9gQgw7JRQJC+5ualkJMk3DOf5MtcJ4WLvFMW?=
 =?us-ascii?Q?rw9yUmN2DQmGkG7K5mUsmpIxZNjVv/WE2ucfpZucz+9uHn0asdG7RCGHTpUE?=
 =?us-ascii?Q?x3ACzYpVxtjA4MNAkeVKnzvjb+5cMdQU+XfBDE78UYkj/xZQSOVVm2Iqz9Gd?=
 =?us-ascii?Q?dYyhCdHffDefQlPfWfWeqv9gIGUldWhs83hdVdsrdXaaVBBy7wGpwi6HDUoh?=
 =?us-ascii?Q?YOoMyVb5fsADFUxe/JEbDB8rb4zKIkJ+6YoR2lKNurhndyhnNq8/uKr7Ez4G?=
 =?us-ascii?Q?Pl0p1BF+uttwQ4wblLyh8Xe/1SQ5vNVOU7MACS/xJAyfFtMrB514nbTHL+vL?=
 =?us-ascii?Q?FsV5eHkA0/hkWY87eoOSotB+TPZvGHaHlbPGEE73FgrY2OLXTDk/UQssZ2WB?=
 =?us-ascii?Q?ZyFujB9rftHNy+WZmL2bu2fZr4FolR68pI2BwFR1xJexeU+vecL0owCGsIhU?=
 =?us-ascii?Q?ocF5hHQZmqEoe590DLK6CXA0t8nAKMduMmzr09L6ITa6obxB5ZnP7zZfwnVD?=
 =?us-ascii?Q?kBC2E3AvFEPOTO4WeHDCubNtlpXHgCP4MMSEy2M+GYpmBHGLIwxx+38RazVh?=
 =?us-ascii?Q?bM1pCEmsA+PY3j0ilieE0scM/31wxKIbeIhe6zLY2Z8PKN/BrACBG1/2EAh4?=
 =?us-ascii?Q?N6jatJOlkWkdYgu4tS2ycEDkhcbSnQ9gCibz5ee/GfyUVS/GrvH8MFo4trcv?=
 =?us-ascii?Q?FhQgV5a4zeqwQmxtOGmlV/B7nh4IdJDhhfofbJ78AF+gZGpWKcFhA6HRpil9?=
 =?us-ascii?Q?E2A0JI2ucM1lP3r2BJQSyt3db94t9CFprh9Ri0XBtUpaCHD3ai+4lGDr+I7Q?=
 =?us-ascii?Q?5F4ALYkhnfTSZGlyKBjSx4pbDIj/gqUsFJev5zcrQdUOVUZyup3DJbrLGzGN?=
 =?us-ascii?Q?cedotCvyxubP2Zg2e7dplYmi/2OMN9FaOQ+5s/YQNAGGWCu9HCn0FeviRx+H?=
 =?us-ascii?Q?uc2IXFgZJnwQyZ2Ar2JFV0xmLsSk+2PcMjqH3RiBOzRu+XFatBAYmBGEr7Pa?=
 =?us-ascii?Q?PLcbTZVKDBtIRA/KW6RA6Pr9JPSnhN34lhlpudQZXA3jpsNNBRS5LF/TR0U6?=
 =?us-ascii?Q?+t2MN8cn1120aZRz+Svbh6kSvshprWNV1XaZu/4FNM3Yar+WC5+HQ1HLHzE0?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: newratek.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db5c584f-c5e6-49a5-0659-08dac2df397f
X-MS-Exchange-CrossTenant-AuthSource: SL2PR01MB3291.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 05:48:42.8999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5494d269-d3ac-4a40-bf0d-8c29f5475032
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTThbzr5SaGbgaszzOBPg7gL6NX8pzQxeGZN8A6zQEZEQVuylOiJKS9yhnUYfXgpp2Vbf7mXujQ4aQA/XXcJOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4258
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
 net/wireless/scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 22ae8996ada3..6bba130ea670 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1289,8 +1289,8 @@ static int cmp_bss(struct cfg80211_bss *a,
 	int i, r;
 
 	if (a->channel != b->channel)
-		return ((b->channel->center_freq + (u32)b->channel->freq_offset) -
-					(a->channel->center_freq + (u32)a->channel->freq_offset));
+		return ((b->channel->center_freq * 1000 + b->channel->freq_offset) -
+					(a->channel->center_freq * 1000 + a->channel->freq_offset));
 
 	a_ies = rcu_access_pointer(a->ies);
 	if (!a_ies)
-- 
2.25.1

