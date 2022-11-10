Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA470623979
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 03:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiKJCEH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Nov 2022 21:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbiKJCDr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Nov 2022 21:03:47 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2056.outbound.protection.outlook.com [40.107.215.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119D62ED7C
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 18:03:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1deiUEGHd/Z7TDrSFDV35zz2mUwKokv+grcOGeCL7350nnd8OoaPeKHQS1UJHX4VxhKcnLF7JAUDjNjITIf46WQjZL/Xb6/9HjLhRy3YYKGl87vcCj/o7vIKzHQjBaVOBR30vCo92f1C+9iP/Yu8TdrEBh3jvOVnT9hEaq+20wAlXR8ysNb7vXPJrrDQVUn/PtESt+/M/tqWS/XPwstLtZmaPF4rvZb/RQLkSCO4D7Hy0CRKw7Hulj+4CiIPacF2pTce7buJW9C9aPKr7eqdWHH5bSXURALZRE4QWMngJanCe1vV/PHtqUhmrsvYg5uuJwNTClW6x4uQrgRLNyd/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQLNaLoQXz1Vol7YOjMllU/keOmNjnDQnaCt6Fa0AjI=;
 b=GydhBYhnjavYBx0mvlq51TbzE5tW5zc8i5p8qcDJOY5veFYplPrsAOymGDs1bIZKFF0i3mwN8y4QL6SKv89m44oATx8vhY+HJH33Y3RbYT1b2b0VxT3IseZdGBsFLM3cCWsAjtuJYLlbTWSS7nkPrzwhQCJ36ALh4vWNtPSQDnN2ByY/LY4oV/PjGZbAtgJxd1nbZPiLZoJjKR36C8ViJ4QR/gJELkhNhs8bIXqLwT4VJbOCl7M8lhM4DxP6lhcd4B91gM/UiIda/yap+CNMca0/e1K8uWk3u1+X+bdGtBiKXmlFkCAq/Hv9IrdgpGNc1NYWLWYRvAmKpWGCr1NTvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=newratek.com; dmarc=pass action=none header.from=newratek.com;
 dkim=pass header.d=newratek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=newratek.onmicrosoft.com; s=selector1-newratek-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQLNaLoQXz1Vol7YOjMllU/keOmNjnDQnaCt6Fa0AjI=;
 b=Fvi4cnBtz+cnBTjvIN6J6PNzKg3qOQAXYhU5xtyIw7kN+HmVYNkyRUE9Da730FKeMua29lijGO0wn6nV9YZstQjUBpBpKhhOYWYM7aBzlaQz9PjBBJTQUg/tgyzajctcVZIPEeUVJLSexRCq0lZ+xR1CWEk8t0PHh2frlQdemq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=newratek.com;
Received: from SL2PR01MB3291.apcprd01.prod.exchangelabs.com
 (2603:1096:100:58::18) by TYZPR01MB4781.apcprd01.prod.exchangelabs.com
 (2603:1096:400:28a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Thu, 10 Nov
 2022 02:03:03 +0000
Received: from SL2PR01MB3291.apcprd01.prod.exchangelabs.com
 ([fe80::81c0:36df:75d:2043]) by SL2PR01MB3291.apcprd01.prod.exchangelabs.com
 ([fe80::81c0:36df:75d:2043%6]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 02:03:03 +0000
From:   JUN-KYU SHIN <jk.shin@newratek.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, JUN-KYU SHIN <jk.shin@newratek.com>
Subject: Re: [PATCH] Classification of BSS with different frequencies in KHz.
Date:   Thu, 10 Nov 2022 10:58:52 +0900
Message-Id: <20221110015850.21117-1-jk.shin@newratek.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To SL2PR01MB3291.apcprd01.prod.exchangelabs.com
 (2603:1096:100:58::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2PR01MB3291:EE_|TYZPR01MB4781:EE_
X-MS-Office365-Filtering-Correlation-Id: ba9e3918-0b4b-4776-5e26-08dac2bfb37d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7CS2xZwPNIs9nuJgAHnAXA1JksKDbVeuT5rIbOFNgVRjDmkhSAS1ktjhnw7id5Iosp2s5nEBTKEHITNKmvXDcjjQqpxLn/De2bk3FzPB+bt9wSFza5QEnCplPV36sBZ64ymGJUkt/oWzg4R45mKKxXdaVDN9/FtSz5Z5ChQUBeh3uimHiVkbZIzC54aKGB64c/c+WcJsQChLmYtqfLpB9xTZ4WZ/mUWDbALgiJ9JjPtreV4fr3ij/MkFvxuF6zttyAVmPbOoqyKnrmO8NZ9+rujZQz0yNJejl8gOamm/FsdrvVlkhbz1EN9v1YGHd3/s1i0+54p77oc9ivlg3tetl/kUram3HA9IPexRA73mVUVi0j0tmR2Z+kOKwTJTgIDrUGaxHG/q/j/G8AOyPG6COsoL6ZHt7BjSpUWl2KmU6Asb7WQcO50q3KjnFNGMgiWxPgPn0n6z1MPd2NOxlovZGqV2FOBIqXsv0VnqlEhprKYeFndvtUVt4/8xfFsec4/MtXamd2Rit75zEqgZ2KXnCIwMXv8zxdWxlfLS+Yj+rMJUEopYXtladKqI1q8SWC/PWTdswSR7/ZupxBS+tjWx+ToiAPiZjLyrzPO8ZQ6KJSdfYfHm9SB+NMOmhsSEYp/0uQUpisj2BHuWhTRBOuLqjKneYy6Gs8/GrCKhxPPKiw8v+hXsYKDFK1+dQVN/wL+5Chqkr5NJ2Hw+LKn7tV5J5VL5ImPBAwjVYDqrRB/3XGReWJeybZLz2NP/LjE2fc0w9ZN2YfojxnBNvivrernbjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR01MB3291.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(39840400004)(366004)(136003)(451199015)(38100700002)(38350700002)(36756003)(8676002)(86362001)(6506007)(2906002)(4744005)(478600001)(52116002)(6486002)(4326008)(6666004)(107886003)(66556008)(66946007)(66476007)(5660300002)(8936002)(41300700001)(6916009)(316002)(26005)(1076003)(6512007)(2616005)(83380400001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7rf0RPdQ1LDl3SybnOTLcpGvPe3mmYiQicFR+C1TxCqTvCbW8Kk7IpI160q+?=
 =?us-ascii?Q?f9QgOehYXXBojPGkAGopyx7Yed9/o92a+LimnsVB/6ybamDHSCwuOOGC0H52?=
 =?us-ascii?Q?/XgG0qddu1jAaECOfF3uf4ca9ZEkKp5Bw/oMboc5e72/scqOMN/zULknz8G/?=
 =?us-ascii?Q?o25wvb0e/yb2HhWu8VJCT24A8a/UqosrElw7azD3Vhipz0b18RLPRf2heSM0?=
 =?us-ascii?Q?pw1Fsvws5YZJFeK2xijENLrNFBFRVFCpHKpKk//FLJ+oaNoHHjOulg+7HSeu?=
 =?us-ascii?Q?QwLj3VZmtum3azCweSxdfTl4lnSp607P1svlYdpn44uKAeWqEMIxI0wBm9th?=
 =?us-ascii?Q?qfoOtuep7jkSx/gCFe075m6nbEobNr/9SwIglWq2f43trfyxu9ZUILLeB+ye?=
 =?us-ascii?Q?A6gOq0c6pazd9AY165zBLCXIrZcmBNspgVzMwgUjKRP9JwSI+vDkoyrbpNRy?=
 =?us-ascii?Q?DdhPg4VHinrmZgP9ADvOsOb+feivODr8kABELKsS8yhtPjogQDxlgMq/5yob?=
 =?us-ascii?Q?MXXSSd5w6nwO0fJZfYCvEqt3dSkHqu1Yk2h64xo71XOQlDqPjHNSlvPnVxlO?=
 =?us-ascii?Q?gsIr46kE25fTtylqOICO82e/veRrZNNViT8hMixsui22R3zwcVD2nWr9appi?=
 =?us-ascii?Q?36BVBJh1bCQ8tUJmD54GaODBFbDi4uuhFbMnhRjnm1crq0JwsbdBOEm46odf?=
 =?us-ascii?Q?pVtHE0kzLEhq5kQpg27qKrx3NPdOAgjxdgmepGEC0A1csHwnlJ+KfUJIuOWF?=
 =?us-ascii?Q?0DbWxpIs/CRobgIPieVazs6jGeNF1lK+GaWKKkzCm+6loH0KYUC0CIvOlSNU?=
 =?us-ascii?Q?YhkuNzeLHb8kR0wezMyY2CbLOaai5cG6ksG4P2kNLrDguixfFI+BPFkYJZdH?=
 =?us-ascii?Q?g7D96IY8NU87GphJgNKydcXDLYSVlgXlts7TSWu5B/QxRf3qpTQWm/m0KaYs?=
 =?us-ascii?Q?CuU3yH8efZlcHgKb/BfyVsxuTGe7DlRzfIpUIZyhc+Soh2WpCdYhDy4C8Yii?=
 =?us-ascii?Q?sdb9S/hiqcivz4twuTzWLx+9VUmZ2fykH1IHH9L3uYEtlEbG2GJrN3cVzZt7?=
 =?us-ascii?Q?8/qcEKemHXyJawVWdgUGsSrHSA5NUC4aeOmGOqygqH5cVkHu9IH8ogYeDLyR?=
 =?us-ascii?Q?MWLw/O0AaoLFuIWCd3oTVI6bPZI0OVGeRChfJsYZp48aeETOClxn1DChJvxx?=
 =?us-ascii?Q?X1qMg9wx2lRaaDCnKVh9JsXt0LN9nY+xxH4D65fs7AzXbuhIWCY83uLmSSuS?=
 =?us-ascii?Q?yZf8n7gyczInWjACxpTFvBLrUFucUYxPvzFz7vRnBraltsLi6/Q6xkcyU/JO?=
 =?us-ascii?Q?uroRgBAR5qnUqW11Nxrx/i3WdKs6j9s1OjwnNCk5keaNwZQAFSSAcp5yj90A?=
 =?us-ascii?Q?unNcnFOSRXdI4xfLFPBJJvts6l5DsHjwwAHYVGUteCRM3LQoCLZgnBdvFtwe?=
 =?us-ascii?Q?Szmv+EPS+XO/a+/8U3zKCYLVJq6UQRm8nQfGfuJs1LptAY4eiHt2lGnjRU0S?=
 =?us-ascii?Q?j6jr/7pDEzPLfsvwYinlhHCPeqeYNCLd0z3ouSqEoggGi75r/6f7G48XlF4d?=
 =?us-ascii?Q?EFFMTycgFSrVkhcu7S/emLFVA806RXfPfdG/JdLp?=
X-OriginatorOrg: newratek.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9e3918-0b4b-4776-5e26-08dac2bfb37d
X-MS-Exchange-CrossTenant-AuthSource: SL2PR01MB3291.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 02:03:03.4569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5494d269-d3ac-4a40-bf0d-8c29f5475032
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7rngAazVIrRDuK5xVSK37LuPxiZpmcVSxHgcXt3IPSl8/frUkWSWOOI54VBqXhXZlT85pGPLYKA1nrt/QZrXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4781
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi johannes,

First of all, thank you very much for the review and feedback.
This mail is corrected part of your feedback.


"freq_offset" also needs to be compared on S1G Band.
If freq_offset comparison is omitted in cmp_bss,
other bss cannot be distinguished in units of khz.

Signed-off-by: JUN-KYU SHIN <jk.shin@newratek.com>
---
 net/wireless/scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 3cfc668c4189..22ae8996ada3 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1289,8 +1289,8 @@ static int cmp_bss(struct cfg80211_bss *a,
 	int i, r;
 
 	if (a->channel != b->channel)
-		return ((b->channel->center_freq + b->channel->freq_offset) -
-					(a->channel->center_freq + a->channel->freq_offset));
+		return ((b->channel->center_freq + (u32)b->channel->freq_offset) -
+					(a->channel->center_freq + (u32)a->channel->freq_offset));
 
 	a_ies = rcu_access_pointer(a->ies);
 	if (!a_ies)
-- 
2.25.1

