Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F75504D23
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Apr 2022 09:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbiDRHWy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Apr 2022 03:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbiDRHWx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Apr 2022 03:22:53 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2076.outbound.protection.outlook.com [40.107.115.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983DC639A
        for <linux-wireless@vger.kernel.org>; Mon, 18 Apr 2022 00:20:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgvV03fiwXZMqIuCGKpVSGzmsNCDKEgRVSjpnJIv5BetCA7jpqECEYVXfBVLgb1EqCQr4hhXq5uGEzy3C34iiw0uaTdVVQK+cW19dUzjxzmSFVHndx6bYCIrxDpN6Ytie28AajoKAZ/bFJ62FgyiovqpFZGL2d6Cyt0HHMizUJgC5TQF55N2+NYWyaR6meZ7vDVFT0N/K2/DB525AZ9Bo5ecQkQJ0asCiFqkDpTx5UYAPXs9aFomchuwuLPagRTutpz75CIWPGrGi4owPzyamqL4WjEgQlqKadYgoOw4GWJqRO/FxMDCAj/32ZkeGKXfYphOwzaGQVm4X2EJNQ2wdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6Uv8Gf2mZBV5R+DkZli37RsXpyQ5JnVDhjoxG54eHw=;
 b=XTbGPYIqTNQ7L1tgINLmnvEm/D1Op5EGyIRUrPD7FMKWwWW+5Niz/6vigpdGJrgS59SoyFppcnQXpPMY2QLJ4BSltyfYrhcFTHCctoqHOYNHUbLeR6ap6qI3Q1u/Z27aXRRbytoq/1kjXr2eTLtiuGgd3ZBVrAkiZkkcRO8ZS/C/okAqR9/94A+Jrgezaq1jaCrj3lwBVoORe1DTB2bWZHv8SNN9VRxwSDtdWIdPURmZsTlxQKkFYgCdmGv4fgTbcW9EjQeX8jlZgpPyTFdbbnq1qIDmrktBL0TKbwqaxW8NBPGT2mCuZF75GHRmhB+32dzkbThiJ4pMSr4MowMusw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YT1PR01MB4363.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 07:20:13 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::788b:f975:24ac:69f]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::788b:f975:24ac:69f%6]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 07:20:13 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH 1/9] ath9k: add QCN550x device IDs
Date:   Mon, 18 Apr 2022 00:13:05 -0700
Message-Id: <20220418071313.882179-2-wlooi@ucalgary.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418071313.882179-1-wlooi@ucalgary.ca>
References: <20220418071313.882179-1-wlooi@ucalgary.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SJ0PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::9) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d95de47-6318-4f66-b107-08da210be11b
X-MS-TrafficTypeDiagnostic: YT1PR01MB4363:EE_
X-Microsoft-Antispam-PRVS: <YT1PR01MB4363E568B7290ABD7F95BF66B2F39@YT1PR01MB4363.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w+/mJxvIG66xs/pNRG3mOroSZGzx3MCfYlMiR9+4d7q1fFhJati7Ql8FFCv4izQ1V1xALUB+xqE4hYE/czRX245xFrWv4lP5O0gM86EwAUTaCfLs1CrgdJFw84PhGQfEfoDi90QQrhmEqrBrVNmBktlKolLwku208SV0Xrhg28xCQcOHmfVzZxPNbkQM+sqtwEutoQGqjIPBszeR6RY4I/2bFc6IBRwSEnoO7OizGslw89j2BcdQozj4Y4AH8nFJw+u4+K7LoTlWgiJzINyorzOkC8GuRXgE6EGoScUlNUMMtRet0zgScr/wzYldkoFZNYR+PiUuLvqQyFhLKv3T1EZwqmU/rsvERqQNGCnQg29ot2Z7TTi679znWTFe6Y5CDdzSoJmN+++ji3qWDMTYXbdrtbXe15k2wRQPWY3CrFMC0GjzG1gq/OftwC3uVjnRp79hYaneWhbOQW8x8uASaDRVpmrJysBCSQfKFv2cEKHtclgil0Df+AWcgWlrRMNDyfXGDj7yL5VTXDWk3aKcWUnbnpwtJJDl04H2Qz/dmFFmwlwrlqY+7ouPZyZNCcgtei8GIiRBhH83zsgJrqIuR3/C3zkvLLcFRD80IVJVGI6gbcatas1gO/TsG4517oCAt0020piLo9KK1bEGQHyJWbe8rTSv3kVCM36U3X1vFDRG7tdFHBwdb3aGqpZos1JdCveNYRgnas90eO37U1GIZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(86362001)(83380400001)(6666004)(6916009)(54906003)(66946007)(316002)(186003)(26005)(786003)(38350700002)(6486002)(38100700002)(107886003)(2616005)(1076003)(4326008)(8676002)(66476007)(66556008)(508600001)(8936002)(6506007)(36756003)(52116002)(2906002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?588lRgmmAkZzjI4jdbp3QhftMQUQoDhryQZ0a9tt/nS89Pq2ffB+9pskykVf?=
 =?us-ascii?Q?yQ8N9WyHUUm3nCnh7aVJ+Vw/RsuY0gs0TEhfuK1LEKoloTzlVoeTAtBiFCZr?=
 =?us-ascii?Q?Ns2/F7gJtQ+0J77zELXNh4NKXcnUPD431DqgxdkYjF+hUNExDpCuqupEIrMw?=
 =?us-ascii?Q?AimNoYduuhdZTUTip0oyUK7DXVmUPh4DDgtD6gm7N0zaVJDITu7mgjRKtvxm?=
 =?us-ascii?Q?LtPpyN6qLXNEsVmo/z25pxjIhOIfXSEmXYFeE7pX5gSylh1I18IOL2ngkoyd?=
 =?us-ascii?Q?batotvk7hRP6p40IM64DgpNrvDcOTNfDIu6wxXNSnoBe4svWSynO3E9r6T7L?=
 =?us-ascii?Q?TKP8r/Trj4lCTcnHWNVzFYjr+er/mYW95sjU6ZwKXvEjZG2MSMGvMB7UDvFY?=
 =?us-ascii?Q?2OISRJ1w79kiHrJ1WigjvI6xLVUJQHaDGkF+lyXqZJjhkL67lD+2aJTG8eJ5?=
 =?us-ascii?Q?mmWoKUuGJ7/cYS+97ehbtRepwwsAsO1DeBmK1+Ip/4TsPA3YWjgO8RwK3ace?=
 =?us-ascii?Q?VoW3LWLe12M2Rx7cRja39FFYF4rQ8ix9A62ZmzmlQRFqiHAYeSynep7y1j7Z?=
 =?us-ascii?Q?RKCNv7YZvjUfyQv90vrEjc+7xamBiaOQXTiNrET5PB6NTmYk8mKG8Kpq9S2A?=
 =?us-ascii?Q?g/TgYAI63nL43eUvRWG/nh8LQAwnqDxAGiIvrG2CibEq9ko2n4wdrDWUX6pf?=
 =?us-ascii?Q?f6dtXB+LUmiEJXFEURpv+uDc18+jm6ZSmEAb4Si4VRCj3spqIA7kg3odKsj0?=
 =?us-ascii?Q?7GZVZVIOExZUjUn01GOntRmaKuKM9KEERK+zvrgEvuMxOdXgR2klHTJuROkd?=
 =?us-ascii?Q?M5WWQIYV53W6luwyE0FOI2MjRvlwm4sovj3qKYcNaz4Ru5ITZNIak+ANOhtW?=
 =?us-ascii?Q?fgtRWXX8XXSQBloFBEm+S8XNo+PncilJyvWSKCPrtZ2TgQveoeDNijpdaWa5?=
 =?us-ascii?Q?mVB/5Wb9zxPRAH+eqUj9iFiOtM5hXz6SGORRMn/qtTNJipSYeWlc+5rZ7Y2R?=
 =?us-ascii?Q?6x3RCmq/CEm6bKPyOmaTpjwtLFQWDUcGPQXzF3/eEN5fUeJd09MVsu7HKylz?=
 =?us-ascii?Q?rgqZJdGr2s6y8jpIMfFx/2inNjO5+tLRKeY9AMU0lUNpCaIr0nVTifM+rAfI?=
 =?us-ascii?Q?J7Izsy7SC/oGtWxTFtPYZTFVnuLJQjFhhSRSjkR3XOgN0gC0M+f4zpqcvJsr?=
 =?us-ascii?Q?EjRGBoQ+1tSYnyxQwRKAug/W36khsf23VABzyfXeS5ZjIld4RXMy1YC06/pw?=
 =?us-ascii?Q?Dnt+GlmmrQrEpikHowEtaTlNZor4IqS1fHGnakbaUzDLRnio9SIXh5XGBTvb?=
 =?us-ascii?Q?6bH6Gnt1HaCP7+pqVId7vZdp2jfqoWqFKtZPcXt861Ig03PF0dJsXF54htX+?=
 =?us-ascii?Q?iyhZpQUcRdJRUlncaNbqS8pLP2VZF+TgkdaLHJlzJGFNtHiYZyjOs0op0nA5?=
 =?us-ascii?Q?hsbAC8w5GaD2nCDEhl6Y9i9KaLDxDZLKqKDc5FH8DC9TdJyOsDnP3eYRz9j5?=
 =?us-ascii?Q?7ZqalAuU55rEoAUMbM2vjM2NJBhmQYXvQwqZyeBR6ZMEDiHuX+NuDSSSPrcD?=
 =?us-ascii?Q?0r3YfcdCUwGmcav8U/QTS3doR46h7PV8h5VcKXmxIz7mcpmIA9IlspmLL1a/?=
 =?us-ascii?Q?iwqsBhRpncpP77uJVzjhDZc1CZZwb7i39PAjWkkiNks7G9xFr6mmCMIeJtgt?=
 =?us-ascii?Q?xLM1BJLsWUEUxUtcxfhfeRRz7tFa3DB98YzPFCIgJ62D2zeSiQ2NlwuD7p8j?=
 =?us-ascii?Q?ddDgm3GTAA=3D=3D?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d95de47-6318-4f66-b107-08da210be11b
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 07:20:13.2485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RaZFQNp6pjddazRqAh28Ecz4YwoJPZysBj34QdU47w/wOy1q4XtsNoxntV+5O1mdrdG7pCX95xxXBikDExgXBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB4363
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
 drivers/net/wireless/ath/ath9k/ahb.c | 4 ++++
 drivers/net/wireless/ath/ath9k/hw.c  | 6 ++++++
 drivers/net/wireless/ath/ath9k/hw.h  | 1 +
 drivers/net/wireless/ath/ath9k/reg.h | 5 ++++-
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index 9cd12b20b..1835b4469 100644
--- a/drivers/net/wireless/ath/ath9k/ahb.c
+++ b/drivers/net/wireless/ath/ath9k/ahb.c
@@ -47,6 +47,10 @@ static const struct platform_device_id ath9k_platform_id_table[] = {
 		.name = "qca956x_wmac",
 		.driver_data = AR9300_DEVID_QCA956X,
 	},
+	{
+		.name = "qcn550x_wmac",
+		.driver_data = AR9300_DEVID_QCN550X,
+	},
 	{},
 };
 
diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index 172081ffe..047512ce1 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -282,6 +282,9 @@ static bool ath9k_hw_read_revisions(struct ath_hw *ah)
 	case AR9300_DEVID_QCA956X:
 		ah->hw_version.macVersion = AR_SREV_VERSION_9561;
 		return true;
+	case AR9300_DEVID_QCN550X:
+		ah->hw_version.macVersion = AR_SREV_VERSION_5502;
+		return true;
 	}
 
 	srev = REG_READ(ah, AR_SREV);
@@ -592,6 +595,7 @@ static int __ath9k_hw_init(struct ath_hw *ah)
 	case AR_SREV_VERSION_9565:
 	case AR_SREV_VERSION_9531:
 	case AR_SREV_VERSION_9561:
+	case AR_SREV_VERSION_5502:
 		break;
 	default:
 		ath_err(common,
@@ -688,6 +692,7 @@ int ath9k_hw_init(struct ath_hw *ah)
 	case AR9300_DEVID_AR9565:
 	case AR9300_DEVID_AR953X:
 	case AR9300_DEVID_QCA956X:
+	case AR9300_DEVID_QCN550X:
 		break;
 	default:
 		if (common->bus_ops->ath_bus_type == ATH_USB)
@@ -3315,6 +3320,7 @@ static struct {
 	{ AR_SREV_VERSION_9565,         "9565" },
 	{ AR_SREV_VERSION_9531,         "9531" },
 	{ AR_SREV_VERSION_9561,         "9561" },
+	{ AR_SREV_VERSION_5502,         "5502" },
 };
 
 /* For devices with external radios */
diff --git a/drivers/net/wireless/ath/ath9k/hw.h b/drivers/net/wireless/ath/ath9k/hw.h
index 096a206f4..759a5991a 100644
--- a/drivers/net/wireless/ath/ath9k/hw.h
+++ b/drivers/net/wireless/ath/ath9k/hw.h
@@ -56,6 +56,7 @@
 #define AR9300_DEVID_AR9565     0x0036
 #define AR9300_DEVID_AR953X     0x003d
 #define AR9300_DEVID_QCA956X    0x003f
+#define AR9300_DEVID_QCN550X    0x0040
 
 #define AR5416_AR9100_DEVID	0x000b
 
diff --git a/drivers/net/wireless/ath/ath9k/reg.h b/drivers/net/wireless/ath/ath9k/reg.h
index 8983ea6fc..5a07cf7d8 100644
--- a/drivers/net/wireless/ath/ath9k/reg.h
+++ b/drivers/net/wireless/ath/ath9k/reg.h
@@ -825,6 +825,7 @@
 #define AR_SREV_REVISION_9531_11        1
 #define AR_SREV_REVISION_9531_20        2
 #define AR_SREV_VERSION_9561            0x600
+#define AR_SREV_VERSION_5502            0x700
 
 #define AR_SREV_5416(_ah) \
 	(((_ah)->hw_version.macVersion == AR_SREV_VERSION_5416_PCI) || \
@@ -992,10 +993,12 @@
 
 #define AR_SREV_9561(_ah) \
 	(((_ah)->hw_version.macVersion == AR_SREV_VERSION_9561))
+#define AR_SREV_5502(_ah) \
+	(((_ah)->hw_version.macVersion == AR_SREV_VERSION_5502))
 
 #define AR_SREV_SOC(_ah) \
 	(AR_SREV_9340(_ah) || AR_SREV_9531(_ah) || AR_SREV_9550(_ah) || \
-	 AR_SREV_9561(_ah))
+	 AR_SREV_9561(_ah) || AR_SREV_5502(_ah))
 
 /* NOTE: When adding chips newer than Peacock, add chip check here */
 #define AR_SREV_9580_10_OR_LATER(_ah) \
-- 
2.25.1

