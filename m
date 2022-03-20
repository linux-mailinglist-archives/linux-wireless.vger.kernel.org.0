Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FB94E1E41
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 00:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343788AbiCTXcD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Mar 2022 19:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343787AbiCTXcB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Mar 2022 19:32:01 -0400
Received: from CAN01-QB1-obe.outbound.protection.outlook.com (mail-eopbgr660086.outbound.protection.outlook.com [40.107.66.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA9A132E92
        for <linux-wireless@vger.kernel.org>; Sun, 20 Mar 2022 16:30:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1u+zlCFJ/k+WlCi3nUmorEVpYoliooMZpf8lFjZ8vknr6SipTnPta7fF1P2cuNErtwCDs+IVJVDGkMQjhwg70KSX7T3FmsocbncLgQopSmQT84OkUngeL4kKqCZx6glIgiAdNvnQpCH8VhpkJa166RPs9UMr6B0mpg8ZZ3pCA21HIodgH4tBX8a+N/ZZFWmzc2erjQgJKY66utVkH4zkIbupJPYzwzydXQ9m2PrcM60PrfMGbJ0Wi7f30AHNQ7ze0EooKCDYNowyy/0qNep8YxoK2SheDJrf3dUJiacXSICdRUFSV0jAvqhi8OdkfxzlfXv/poP5jZLMkmOQ+qyVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JR/s85oMYnFNTtRcZ26p56QPVSezp52h/3LNoTInDmM=;
 b=MCfDSrKnwTg48KNl06G+804kZEPEu4LH5fCtWxSnpJI+LMpM4UlI+yYKJsNLP+hGXUscGBlg13u2QHNd8bTHd7O+/4ZTnOz/1ih7tt5IOH1+2x2uiLoUWhzmX6cb1wmXiTZUQtWeZ1n3cM2f2ufGY3pX3SAq505H4eaDsSktoAlwBNOJqlz68a4ykOkMBZb8F0+m5LAqclZeyfEBLLFY2OzLNriP9HvCrQVNEvwzjYD7Glk/XNlMfre7BX9NV0qlBotXF+lsmAVVlc9HFRebsbjbT+SKwXYN3Zg4jfK1dR2bjVCHc/RA5vcGGynt62Zrng+f8IDlYdqTZ0BsY85/gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YTBPR01MB2989.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:18::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Sun, 20 Mar
 2022 23:30:34 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dd8c:6e57:c431:9323]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dd8c:6e57:c431:9323%6]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 23:30:34 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH 2/6] ath9k: split set11nRateFlags and set11nChainSel
Date:   Sun, 20 Mar 2022 17:30:06 -0600
Message-Id: <20220320233010.123106-3-wlooi@ucalgary.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220320233010.123106-1-wlooi@ucalgary.ca>
References: <20220320233010.123106-1-wlooi@ucalgary.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MW4PR04CA0176.namprd04.prod.outlook.com
 (2603:10b6:303:85::31) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8a6220f-f1d0-4c31-5fc2-08da0ac9a197
X-MS-TrafficTypeDiagnostic: YTBPR01MB2989:EE_
X-Microsoft-Antispam-PRVS: <YTBPR01MB2989171361F1BADAA91E82D8B2159@YTBPR01MB2989.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 30A0RTEfJflWWixr35I9IN4G5BD3e2+2E3gNuHaC0dDJhOn+viW6NOZEFa+v0xaoS2Hk/rMin46CKKEkpR0AETAfwiMBxN+apRj5x5Xxwt8rRzeIIQnHn3hNXLQmOhWCy2GRJGQv06VjGmgVAVNgUhXNBUa08XyS5wq75uq5K+I7pntNnW7xta9tKxP425ErnVUGsHPCaZkUwNVc6QV11PvqX8r9QEwapwl7rxqOqMP2buuFuw29Va82auZxxWMBt1MZo2wM2SsplOxBvepL85PfFaKN4g99F36seNrjao+YLXgRwIfwBZEa6AmMgYfa40xiFw+0JhAjy0uKH+fBF9NkdAsu1qXMUi4KBXiXLLh7SOioca45kZ9pLmyeRj0Nj4pkjJ2NDGVcBK++L+/lH5RT5I3ZAlsQmZ83K4LaMgSahlKgXmQPmOwkH5vJ9EKcNSk9SKbObODPyegwHkFCcKu6y76yMwDqpM0ly7N/Gb2cyZMO4btgDSYzi5bEYgBvfrheWjyP8HpGHW5QpgteSHThRNbC9Xb1Y47X/n2uos85sjnbpn6mYNeFSCF4txMED3ByfVwS3aS4z7Y1gkBP6K5GvOA47zYSzx69UJOHv1oL0s1u2maQAjFg1cqAPIry1I485f6YwtWYDKj79bIyw9pmfTlfHVVWcFaFBZXX8jOxiWqDyil9VZjl61M1j6pt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(2906002)(83380400001)(66946007)(66556008)(8676002)(66476007)(4326008)(786003)(316002)(6916009)(54906003)(86362001)(508600001)(5660300002)(38100700002)(38350700002)(8936002)(186003)(36756003)(6666004)(26005)(6512007)(2616005)(6506007)(52116002)(107886003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ju8nixe9sAeoEpquFZ1ZhkkVHdl+cewtJQ7TNQVRDtvJ7kXpDD5mqh0B3Qi1?=
 =?us-ascii?Q?6L4P1nmTdffV3NzX9ACENFufxz+5Ep9Goa0gCXz4Uj9S66qAlyerrhmn8J8a?=
 =?us-ascii?Q?WdrNl9U4QEQgJn49lrPs5oYbIUJ0p9gSQR1ssydV8QX/XOCEA/43LkJ2fo3X?=
 =?us-ascii?Q?IfdRvRTLES2O4CzbPFQyD3S8PjO6ngYHH3a8jwaaL8c1/WzoLJXA1i+1DQ0k?=
 =?us-ascii?Q?CBHrHc+b1rZEZ4MQiROH4nGEOgpBJ7zhOCte6zHGhSDFLzdSkXaR6omEVNkY?=
 =?us-ascii?Q?kD0LWrutnSIHfHM3e+Ro0f+tTDmfsO55IhntW0esrBaqPd2hZ2+IY/JSs+LG?=
 =?us-ascii?Q?iGu+wHxRSu95Rhos+tM0OO3ud+eCcZ7AdamD1vePDNLjpZP8za/oi8UJcXm3?=
 =?us-ascii?Q?i7Qv2/ve5HSX7JrAY1eScoFbG0JuNfZLU68KxvBxY8kwe6S3XwtdLWZGGHQ2?=
 =?us-ascii?Q?azt/tUSGCQ0lnFPpzfcHpwcgxCWaLMJHLKAEgGfyXRvPO9dpvYHgIdtxPTrW?=
 =?us-ascii?Q?x9Jz7Ip8lZ9c9YctYLAPMpsrWQGFrGaqQKZfixuwLC5fKNjkxlmURSRk2PYi?=
 =?us-ascii?Q?eZeuKU4HOJ6/Sp6vfCoR+wvsEGPPtioxA/10AmWXWtpapBhS6hCgOahz6Oqu?=
 =?us-ascii?Q?HWZdDJ3r1vwdtYLWYEPvSD17xNHP2LYugRDA2177OtvlA0Zm6BHcVn9fTrIE?=
 =?us-ascii?Q?g1S+41pDbJXOApMwV/7JB9tAUqVFOIKuOhl2WDFYxlVx+1ps0WUx0BQkGbP0?=
 =?us-ascii?Q?wo9fCefXF35u1KfyNEhrCun3HzlVQ81G8GVvyQvru7aICwdDiP1T8SscrLCA?=
 =?us-ascii?Q?HtbPfV+VgLWF7R03KbWKDrQauim6Y0RXg6sR/mMn8i/TMHTBHvQcrlwOR23c?=
 =?us-ascii?Q?9nNnET51yjll/s0pii2I9hvVkbZ9kfGlXXXQNiBC52q27hdrJY/QmW9FTPfO?=
 =?us-ascii?Q?5+R+mC0MLBsCyBk7Kt3IRP4oIkkRubjk/z1t/qKLgHsxLbZrtHypIZKXrRE5?=
 =?us-ascii?Q?Qj5AWw6ak8bdtL/lXPAegCi/JcpJviBgUs9+5tchJWI57+Ho9GX4RhMLcLQ6?=
 =?us-ascii?Q?sHpuXma456jFSoZ0555F5HYKm2yJii9+1TJYouAUZK7dMiWeKUzsfv/EosKG?=
 =?us-ascii?Q?r8zuKjibZKCx9LyDjXn9AqdemqCoyDTgCfq8E3RAkEcgUqKCBnYRasSa08PE?=
 =?us-ascii?Q?Xu780l4hdafj6jcQ60iKXgmQe/cgzOeJXAHMatSq9p+N3BczY2drcXf2onuY?=
 =?us-ascii?Q?i9uOu6Bmv60i38t3o4ACZw+PkMWSVr6xBsx381fSKPZ2ZLXIw0EPSY8kWeUI?=
 =?us-ascii?Q?ORPJRE/h8krWf+1EuTIV+kXRaca7cBRYM59UeKiglJIpHy/Vuzj3w7rQwJ36?=
 =?us-ascii?Q?tX61pRtQsfTLV+grN4sPA+Kq4fbKqOPWCTKX9e3Nax+EQnqv/Cdm/2jLZhH1?=
 =?us-ascii?Q?goDtkMGcqK035BQvixs9Z+Tei49IBZ2O?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a6220f-f1d0-4c31-5fc2-08da0ac9a197
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2022 23:30:34.3196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNrj5SjtGBRHNNHMVxeS5a8Gar6wMt0HzG8ga4flZOBBEuXfDW/2ChB91fkJ7z1Bin7RW+rTp26idFUICCw27A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTBPR01MB2989
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This makes the code clearer since set11nRateFlags currently sets
both the rate flags and chain sel. This may also be required for
QCN550x support, where the rate flags and chain sel are in separate
fields.

This change does not appear to affect the final binary.

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
 drivers/net/wireless/ath/ath9k/ar9002_mac.c | 9 +++++----
 drivers/net/wireless/ath/ath9k/ar9003_mac.c | 9 +++++----
 drivers/net/wireless/ath/ath9k/mac.h        | 6 ++++--
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9002_mac.c b/drivers/net/wireless/ath/ath9k/ar9002_mac.c
index fba5a847c..a8c0e8e2d 100644
--- a/drivers/net/wireless/ath/ath9k/ar9002_mac.c
+++ b/drivers/net/wireless/ath/ath9k/ar9002_mac.c
@@ -301,10 +301,11 @@ ar9002_set_txdesc(struct ath_hw *ah, void *ds, struct ath_tx_info *i)
 	WRITE_ONCE(ads->ds_ctl5, set11nPktDurRTSCTS(i->rates, 2)
 		| set11nPktDurRTSCTS(i->rates, 3));
 
-	WRITE_ONCE(ads->ds_ctl7, set11nRateFlags(i->rates, 0)
-		| set11nRateFlags(i->rates, 1)
-		| set11nRateFlags(i->rates, 2)
-		| set11nRateFlags(i->rates, 3)
+	WRITE_ONCE(ads->ds_ctl7,
+		  set11nRateFlags(i->rates, 0) | set11nChainSel(i->rates, 0)
+		| set11nRateFlags(i->rates, 1) | set11nChainSel(i->rates, 1)
+		| set11nRateFlags(i->rates, 2) | set11nChainSel(i->rates, 2)
+		| set11nRateFlags(i->rates, 3) | set11nChainSel(i->rates, 3)
 		| SM(i->rtscts_rate, AR_RTSCTSRate));
 
 	WRITE_ONCE(ads->ds_ctl9, SM(i->txpower[1], AR_XmitPower1));
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_mac.c b/drivers/net/wireless/ath/ath9k/ar9003_mac.c
index 5184a0aac..ff8ab58e6 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_mac.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_mac.c
@@ -144,10 +144,11 @@ ar9003_set_txdesc(struct ath_hw *ah, void *ds, struct ath_tx_info *i)
 	WRITE_ONCE(ads->ctl16, set11nPktDurRTSCTS(i->rates, 2)
 		| set11nPktDurRTSCTS(i->rates, 3));
 
-	WRITE_ONCE(ads->ctl18, set11nRateFlags(i->rates, 0)
-		| set11nRateFlags(i->rates, 1)
-		| set11nRateFlags(i->rates, 2)
-		| set11nRateFlags(i->rates, 3)
+	WRITE_ONCE(ads->ctl18,
+		  set11nRateFlags(i->rates, 0) | set11nChainSel(i->rates, 0)
+		| set11nRateFlags(i->rates, 1) | set11nChainSel(i->rates, 1)
+		| set11nRateFlags(i->rates, 2) | set11nChainSel(i->rates, 2)
+		| set11nRateFlags(i->rates, 3) | set11nChainSel(i->rates, 3)
 		| SM(i->rtscts_rate, AR_RTSCTSRate));
 
 	WRITE_ONCE(ads->ctl19, AR_Not_Sounding);
diff --git a/drivers/net/wireless/ath/ath9k/mac.h b/drivers/net/wireless/ath/ath9k/mac.h
index fd6aa49ad..af44b3381 100644
--- a/drivers/net/wireless/ath/ath9k/mac.h
+++ b/drivers/net/wireless/ath/ath9k/mac.h
@@ -35,8 +35,10 @@
 	 |((_series)[_index].RateFlags & ATH9K_RATESERIES_HALFGI ?	\
 	   AR_GI##_index : 0)						\
 	 |((_series)[_index].RateFlags & ATH9K_RATESERIES_STBC ?	\
-	   AR_STBC##_index : 0)						\
-	 |SM((_series)[_index].ChSel, AR_ChainSel##_index))
+	   AR_STBC##_index : 0))
+
+#define set11nChainSel(_series, _index)					\
+	(SM((_series)[_index].ChSel, AR_ChainSel##_index))
 
 #define CCK_SIFS_TIME        10
 #define CCK_PREAMBLE_BITS   144
-- 
2.25.1

