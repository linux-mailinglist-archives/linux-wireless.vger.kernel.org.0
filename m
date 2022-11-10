Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3653D6239B4
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 03:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiKJCUL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Nov 2022 21:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiKJCUK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Nov 2022 21:20:10 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2085.outbound.protection.outlook.com [40.107.215.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0933D1FCE2
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 18:20:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HciGFlOvaS/4l//7SuBYPgiEMKs3Q4vSi9mLJJdaRry+q4bUVoPZWk8BKo7OBFLGNelB4VpKmk1qLfw0T6lGbfB7rcaPMw+dmK73GtdZNhBMb7p49AiyOfryolHBcoJWM2/fXxksfcw0HgLuLiYMeR5xadCyQCPwfSG93dd1rD0uK4zOJd6KFEpnMpBVM6TZVPWmBfNffOE3xU1cw+Gn7+/6RlrzyU1XZCmx2MmmMB+yBvQJrdZI1j/nZfOwgscRwlSQ26fZV/r2dd5R49YsFD7GfKuuPBkL+o8owBMcAtgki5cCw9m+bO41rWCHH/MD1nzevNrbDacoROT1cNAElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoKeeSSW34dwbm3QDdeeI476NNCa5gz3/5/Odh/l3CM=;
 b=crqey+Er5YheZyhepi4EEUn9SSTVDGelh+Ix4ibt1wdtUzH+h9XqXnV19KYVlcXZtBcad+nFeHqb7ESwgdjNcrdp0mS75Hp78KubhjWO/FI1P+08k7C6UKXH0M/WuXHIb4uDnaXd+RZlUDvqdSZw4APjIpvdyOmrzIVcpMiLlLam5A9AJ0H9aR6jfk/Mhuc8ygfpznCibQxVHFY0o8ayKLaXtgWskVxE1IHZ42uGZXJDUMOJ/MdctsxIiUjmJVWl5o7NbQjfaSzFrFrlneyLNavkkyz3S1BXYVPTGKeC3oOCAk0Dl0WHW/lXb5yBGX7coVMuN+vlvJTp1gAWA5+8wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=newratek.com; dmarc=pass action=none header.from=newratek.com;
 dkim=pass header.d=newratek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=newratek.onmicrosoft.com; s=selector1-newratek-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoKeeSSW34dwbm3QDdeeI476NNCa5gz3/5/Odh/l3CM=;
 b=ARgUivyVnlX1CVBq19M/R1gAwUoLjustXakqwkAPihfOpmBv2V8+3qR9kpDThuJ3Fbwo/hw/I+mzWc45GvQkTJ/TuG/1hN2FN+TX75Mv2HMtO8+6yzueuU3xUaFYaCq1hgmqfQn7qLfujcv9lBRVmnFNvcuKolw2uHiNf1AbL+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=newratek.com;
Received: from SL2PR01MB3291.apcprd01.prod.exchangelabs.com
 (2603:1096:100:58::18) by SI2PR01MB3786.apcprd01.prod.exchangelabs.com
 (2603:1096:4:ec::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 10 Nov
 2022 02:20:06 +0000
Received: from SL2PR01MB3291.apcprd01.prod.exchangelabs.com
 ([fe80::81c0:36df:75d:2043]) by SL2PR01MB3291.apcprd01.prod.exchangelabs.com
 ([fe80::81c0:36df:75d:2043%6]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 02:20:06 +0000
From:   JUN-KYU SHIN <jk.shin@newratek.com>
To:     johannes@sipsolutions.net
Cc:     jk.shin@newratek.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] Classification of BSS with different frequencies in KHz.
Date:   Thu, 10 Nov 2022 11:20:01 +0900
Message-Id: <20221110022000.21246-1-jk.shin@newratek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <45be33863c53edc5be261950b2592a777690a353.camel@sipsolutions.net>
References: <45be33863c53edc5be261950b2592a777690a353.camel@sipsolutions.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To SL2PR01MB3291.apcprd01.prod.exchangelabs.com
 (2603:1096:100:58::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2PR01MB3291:EE_|SI2PR01MB3786:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bfaa39c-466e-4e7d-fe47-08dac2c2153c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mZqMEoO2x563v/r34TLN6iOmAkAIcr+2v4Xb6+gC0N0fSCJj+Ov6TFRI3zXAh+ZwD6Q4Tr4pKkg94TL4wlw6uF8VIuUHJcUke9jCBu374VbDqpk7z2zeNEc0dLh+RdJEnhbNhfBuJXbDDyhIwSmXJdZ5VRiax/hJkgr0DldnL+Whix1PwsQqyBksluYIv3MCIGkRODWRJMrhUY6deWHqIMKVJvfZnGhuPZTL94VC5cWMerYX0bJebRW3eO9Bkmrbumob6Tym5afMkgjhjr/JFwME+m119hN1xnJL2DF5MxQSamg02f/lpNGhzMRw+tAF+DkePaeLBKS5WfjscKR118OCFdHmQDg2oH7UvU9ofWGaMDxOsL426H23oidlMogEM/EfzMC+pAVrHPIXSJAUpqJcjExLBgZXVtFJClsa2bKT5yza8XZfcw5BSBOOu8wFtQMONyTOVPAzpkpnIGH3pCXjE4AS+h19Df/NU9oXZLc9Lpd9dkHz6Wrnpu/YecUuj64Wdu1vI6GxuQMCGFNYg1N2N3pnSPcBrmHHyPSwIzfDyB0MVCnMgtzQ2R9vQQSdeLoSIKWsUHQ+8t6ldSf15byKtSu7qFf+ihP4o2D/qniix7L+h/W0uE7Ld925dslw7x9XoBwdHBBHriPjNwUuYr0nIlmENK4z1h79fykAgsUZc0D0gIKVNNLmlYh2Ry66Dzrzq9G7LrMwpR/dtwYf+mR1sTng0ZMEnoc0gAk+bz0z0nvf5J6XNK6sJhpz2nD8F+1H2mxNTe0DngNMG6dOSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR01MB3291.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39840400004)(346002)(376002)(396003)(366004)(451199015)(186003)(6512007)(1076003)(36756003)(2616005)(83380400001)(66476007)(38350700002)(4326008)(5660300002)(4744005)(8676002)(8936002)(86362001)(2906002)(316002)(6666004)(6486002)(478600001)(26005)(6916009)(38100700002)(41300700001)(52116002)(66556008)(66946007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pt8NmQ6sKtrbOoj3mxuY6/37GwzPw5qrbCcL7rx5FsdzfFoEzqNee6DLpP7V?=
 =?us-ascii?Q?SgxuiqaKQlRm+vjBQ053i9in9fZNV0k/0pLq0NCZ8scWRXzM1Hfv+7PMBhCO?=
 =?us-ascii?Q?CcWhN2Lvc0Yvi00rNpMbqB3AUZH28Ehnj5dmKPEjkjenK6X2XfTGSj0rxIY3?=
 =?us-ascii?Q?7rSf5fvoN2NyLn3auND8DWcRjrTb4GGH2kS1YwEItYfRWdI1zFcqKrEwKkew?=
 =?us-ascii?Q?Or88JCja3EzNRYJ+Q2C1u0323sb3kx4j4ADkzjpcn5gylLvU+SKxgToB80C1?=
 =?us-ascii?Q?zpaEzyBsRBpgY4asawklWykBBwo5xwhBoTlLG6qXau4Nsh0JM/LQ4RzgVhDN?=
 =?us-ascii?Q?LCFV0qZXNVVcjSqElr6N9x6Pz+lONjaEfqiKoVMFkfomRgnZNo63io2T2ONA?=
 =?us-ascii?Q?SsVDaGkMCzUzCO1Jmv7euY+44+KSCS7naOMhNWIeWEC+5m8RHQgyhWTr4AkH?=
 =?us-ascii?Q?+DuPeg/CPqo3AyZBGKEWvFN4w8Hz7aQ9I0aPdwl7wmeyNXUlYu9YmzI8hlNy?=
 =?us-ascii?Q?UHIifz1fzjgbzix1rCkwe69jJfLFGgwBtT3YDe+adxzFX3sJ8Uzta2gDN3wp?=
 =?us-ascii?Q?Yzxh0Lm1K0tpm4jCCqFRAJO84zZRsoFa7CNgjzbH7c8juVCc0am5zcZlwD+C?=
 =?us-ascii?Q?nJ8N2w41FntOfiMHwwxNhPHm9+WYI6R72EABVwRdfhcAKGH46+px6VReTVL1?=
 =?us-ascii?Q?xBz6OuaMM/c86joqbqEYdtaD9y0PdgRZ/MKtjiQXlHT2xLjyxTlHnii7+akn?=
 =?us-ascii?Q?ylJaSwfhoqtKqR984R01dWbW52wLOefT3S5Hc6zNhcwsJJgwGhhxTSGbMlqg?=
 =?us-ascii?Q?VNKQnElT1tK2mB1rEqdQCb5RFY2dyEIW7MbWrJX+HwwdTidCPGhJw1y/+xGq?=
 =?us-ascii?Q?jTk/Wi51qGOD/Dh73hInDNW6L9W62JMz5m7LMm6Hm3g7AVPUjYgG2iDjbH1T?=
 =?us-ascii?Q?O4l3fHvaFLeeTRH/X3l9KLibw2y8voWlaj99cKJOe1hfH+QBjHaK6lrvsPgi?=
 =?us-ascii?Q?onLe7UslmPXIpsc7u4lRf5neEnrewHpKQYlb0ExooQsiBPtl5e7PFzzhe7dL?=
 =?us-ascii?Q?pFFDNEkY811y63odLhOYw9Fav2BTOCRseHDlpHfGjuM5JyVHAvD/Uy19fv7S?=
 =?us-ascii?Q?Iu9QppQAe9A81Al1HNAwv5Ur/Gsb5l2iyGizRKBC/2MR7uygXb0eFOuYTMGy?=
 =?us-ascii?Q?+X0cyACkf8u6S+1UUcpmq8bYfZj1W9/uIZNvw+5nQ9E+43XddM6B0E64vD8j?=
 =?us-ascii?Q?aIDT8wWx/JQQY453ya9C3mWcedx2KXSxGsHONsCjkLwGI+U6SAzUL4UPmJWJ?=
 =?us-ascii?Q?OQOrZp7KAHYyLeO/F8R0p4J6c2+bx0hWJaxcvsw1AAgu/ZB4h6S0bSe+3r0V?=
 =?us-ascii?Q?1vkZ49T+lwVChSNu4vFdjMX4ZQpWRpq6VAb/IbSYu7iS+TFtPLAmkr4iqS+t?=
 =?us-ascii?Q?rfejfCPUzvbqS3+41+zwTn6IFot8Vs/VZ3nU06HjagaZAt/Cr7rohMYsGSHM?=
 =?us-ascii?Q?zM7DSWzm/UVVippbQCQOHZ9AC01QazybbOjfp3xOvV6NE9l3RRTXepjGqInn?=
 =?us-ascii?Q?WhdZNITuAsPrT240jVuo3RGX81y/6rnM+SVNAJ32zwRztasyY2PL7SUfBIhy?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: newratek.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bfaa39c-466e-4e7d-fe47-08dac2c2153c
X-MS-Exchange-CrossTenant-AuthSource: SL2PR01MB3291.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 02:20:06.3984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5494d269-d3ac-4a40-bf0d-8c29f5475032
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wu4zbw3A1vgHWzqifF2e5J3E5T2noHCLjKXY0HNjT4NeS9M+c3Rxxa9SfZ+CG3xT89LB6LsABgJGOEJPkYBUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR01MB3786
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

