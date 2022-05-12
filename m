Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385C1525615
	for <lists+linux-wireless@lfdr.de>; Thu, 12 May 2022 21:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358207AbiELTyZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 May 2022 15:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358208AbiELTyX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 May 2022 15:54:23 -0400
Received: from CAN01-QB1-obe.outbound.protection.outlook.com (mail-qb1can01on2070.outbound.protection.outlook.com [40.107.66.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEE72701B4
        for <linux-wireless@vger.kernel.org>; Thu, 12 May 2022 12:54:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H75t9nypmHcxT7h8c0cb1ukxMadrJf95ITCPi0bNnXWbMq3TJ/SKUX/9IRBPH6341s2E+x4AHSmU6y7S6TrrzVow3x5G2YX8sPminS70Il/PsNzKPar40HX1swi2zhM/aSKLPV6SpP/ZLMg2tuxwWMngxPeL2L/vqc0D2BBGagFIk3O5i5ci5mN6ReyehA2UTL7Fv5y9SWklaFy/U5VpqX1o6pRMPYXzgnFWlFk4WDxkyXqShR6aulK9iycyyL6MwuEh/NPNRtuqK/DcmZbmU3LJt0LabRQFcJ3qji1T86QEYJsGtmtrDKK7XKmwGyOenIzDbLVWgAgEAAkq0yOQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RJ6gQPtRHsXMex/bkqsdemvP90bkjJRcc4whXjvl7s=;
 b=m1L9V75j5ke1NFwlOZUEXKFmMWLH+gQiL/0vqPPT5dmZK59w8Ght2NziHihsyRkFtUvYDPhq4Kb+UO+Xn7VpwgT93KQ2yYwnArpif1W4wVIHh6+/Y7D/YV5YxtimzGVGZ8s7k6Ao08IsbogVkmGN8LJxZI+ZvEqliCdfaBhOEUW7ogaigKCNvkQNmSno8sW0TjZO1ze+6sXoEI5QLyxcB9EZYreNdqzbc5J4m1nHrdL0UjAHfGb4mzhuZdVAv1tjmaLCIvxXpkRda4DNMxBA/BdBhxvWN/8d6I6VYsHI5CNcr4X16ofLCV98mJXcgAHup1ykuaT8vdzZs4qYZIgBrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YQBPR0101MB9515.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 19:54:21 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a17b:bb51:f663:e98f]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a17b:bb51:f663:e98f%4]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 19:54:20 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH v2 4/9] ath9k: implement QCN550x rx
Date:   Thu, 12 May 2022 12:53:14 -0700
Message-Id: <20220512195319.14635-5-wlooi@ucalgary.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220512195319.14635-1-wlooi@ucalgary.ca>
References: <20220512195319.14635-1-wlooi@ucalgary.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: BYAPR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::39) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a39def9a-5a8f-44b5-62b6-08da345134bd
X-MS-TrafficTypeDiagnostic: YQBPR0101MB9515:EE_
X-Microsoft-Antispam-PRVS: <YQBPR0101MB951573298BDFA00C55A831D8B2CB9@YQBPR0101MB9515.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wzBOXu/nVzf/DRhooNoiymWRairRS7rJSDRJDm3qBdpXUyWCI6clJFbxp+dvyMW6sS8OIJqufKd78MCKDhLAYX+P1XmK81gmkivOGyJhUUIqe4UZK8iOqB8dcvt83rZ15JpiySqGPzOkXAfrXHSCBAR/nKmMylslMqz3hP9mi25DuXqkqqX/Qor83FR+eU/WWkB54hv/S+Fc62VEM7Z63G5c94hjyuAFT6ccxFq6PW0oxsSMHMuBsRQPNghpLlk1Flus5/hdvvu/FBwi6QUOYtSqakHiUVi2cslWKUMDQazzoOj504qZuQ/RvvUSmhBLnqmnjsVPjel9xPbakXtS5C6DtQbH3laDRmomTYeVCfwq0W3SMC9JkcFC/PGvO88OoGLTTVgDflcelvZF5ajtv+gbI9BDSpHsBDIs5q6MpYeT52Ucpjfx49aPbbD86xDJuBTcwNUJycJcd+LU3fYQ4F5aU7okU+J8Jx7l2DC77NsMkg2fZendXz4kLJEKclVwXp1P0BTKfP4Hm5+nj5HEwFNSlta/u037AGg/7RxhTsXNm38mqr/o5UXeef4ckLsSGh0YVeWz0NdpUqMqHfjBFZD6b/q8NM/1IblMEEqD5gD+uK4baurjBed0IfJZr61kjKR61Run3UUgPAnuafUR2BmOTgIAKscmkOWmqAVEuHyLjhKjwSYRYRWd5ZeadHXqCnh0w8Tc08BSht/n5uB9v0GP/FXGvjdEBhJBQfIcTOc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66946007)(6506007)(5660300002)(1076003)(107886003)(83380400001)(8676002)(4326008)(6666004)(26005)(186003)(66476007)(52116002)(2906002)(6512007)(86362001)(2616005)(6486002)(8936002)(508600001)(6916009)(54906003)(36756003)(786003)(316002)(38350700002)(38100700002)(83323001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A3xzryQA+hma6u8Ek1/7Rm6S3sqq7iVwiGmgShJ/13PcQWl9fsK9SJB1EiOk?=
 =?us-ascii?Q?Gfo0t/sAZ9kPROGoCYZvWPyJA9TT7VPniDXWlP++QeDywgKojuVJsJJz+uAg?=
 =?us-ascii?Q?daR+h75W4+YDiBvRlY6B9kOcrKytzDS5+WG0ys3NlAN+UOtDqExESAWWIbJ3?=
 =?us-ascii?Q?kl7OqHWV0AhbzWU1HYcsb/aECBIGGiQ7rrI/VUvN8TQgihag2uF5l4oLSpdz?=
 =?us-ascii?Q?Okb62+aiVkYWuPzloIk47E1WgBmexE0ThuOsszGGhw1dg4QcuHOgbsGFOCmE?=
 =?us-ascii?Q?x8EurufWp6Yc7IwJJETOHHDfcqmw0c+qPHfpf14TCk30f52D3cli+O4bkrSL?=
 =?us-ascii?Q?3Uvggm/kUC0BRDgrVByDr+sMPdUcNjEA5pD1OdlS5WqEcd00YYaBD7fhryrX?=
 =?us-ascii?Q?RVJM4Rf8Wyxcd8To95CDz1fIO8imyXYXRavTwPz2L95jl9HS7DSpoLVHDtrk?=
 =?us-ascii?Q?6zGj4chmG3WnKIKCTmQTakMwCaYbnfydjlkEG5oq7s7beG7h9kcvYdfiQv07?=
 =?us-ascii?Q?gszZQBWe0gnWvfuz4AvjSh63C1XF6f7zr89IMToqOSOh3IWhb9R9ik/PuTyp?=
 =?us-ascii?Q?Vym2jl1n7AGTPhoN0anff8kEuabdT2ODM0LuDfhtVJsMfJ8QVGDHwmdJgjA/?=
 =?us-ascii?Q?JHCwAEo2w7GS4AgURwKwKNc3l+X8LeitRFP8r0OJsGPKfib6OSthG3Jq4EC+?=
 =?us-ascii?Q?XJxTU7qaDJA1cHY4IpeNI8O7zK7MSZ0fyVhAwRVbBtu4NzDifuvgSGfdw+7d?=
 =?us-ascii?Q?ij0T67C13BxAn21KewSaBNRObtSLH8ervIE12kbFUvRGAsVmIhH8xDy0gbUI?=
 =?us-ascii?Q?tyfo2CLAIOXWYW1QOmHxSWVSP8aiiekqHeH9CwI3fi30btgK8i7yQRYDKNqE?=
 =?us-ascii?Q?f8TTH6m0ToToSO5mELKft3tuMlH/vLLWuApE+PVcRAOEt1VXwcOtzulZJPJa?=
 =?us-ascii?Q?tHuPeLI521kzXznS/QpofVBCNUFHQApEMjZEKJIEvwUb7Qvnr+wbHAaWFxZf?=
 =?us-ascii?Q?MPlFEVdkuocklpGUvlPHpkS+FKcBoIqPveLK9C7DdP3d2HgHmdPp0BlQAd55?=
 =?us-ascii?Q?Rd/5R52AmJoIuJ14m3hUfYF2qUyQSd89XFrJEP/isA3lKc9ptfjIjyWNHm23?=
 =?us-ascii?Q?6dw/M3yHRJxw+TtKgzL5V/KyxdsWfMRUtJJhwwJTSV8mHNjaB9h7WBtu0J60?=
 =?us-ascii?Q?lPXOMMA4viVcBuV/SjRtdk4PuT45dyoZYPq+v8uEblLUBU35f2T+XA0VpT6a?=
 =?us-ascii?Q?ejVgae+REIGq+f4N2peGWJiQ7Nc3kFXrzM3V8I1QmnxC7WA5r29T+KdhG/wE?=
 =?us-ascii?Q?Sl9RyYR3SPLG5P7RdSmhv8N01GAoMnmCmo0+BOB5H/r5FGw81pYBN+VrvI0t?=
 =?us-ascii?Q?v50L4weEKPCJLF8CXH8CDMAtfFgVmRnTEnsZz3fhMaw5BkaF2R8DmBY0IuFS?=
 =?us-ascii?Q?oYNmle9v+i9FcXpReUWYHL9SgNtCQM3ibtmVKYfbczhTpoZYYZyyG0n+1tnI?=
 =?us-ascii?Q?mR9FlLJAQdmEyWL9boQcFS5zmCwV2agVg1a9tt6Js450JM1VsX5POlimGJho?=
 =?us-ascii?Q?y3z7ysQN2Fwj/+YWldxdUhGQ3Zy58387hTWrzX3bkKCnSNbaBPikIxp0x57t?=
 =?us-ascii?Q?J895hRfjvyG6a/AM8FX7sJTk43S+SxMj//SrIYKyg3k4a5P1/e0g1eq1Q3/Q?=
 =?us-ascii?Q?rWbn1jTpajdmm6GxpwtKL2w5+ZrwJsPrbm4BxIyCPgiDjMbrq+qyIdlgxLuR?=
 =?us-ascii?Q?jdvKg93YuA=3D=3D?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: a39def9a-5a8f-44b5-62b6-08da345134bd
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 19:54:20.9418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouL55sC/EVfOl0KE1870b2rvmGQSlBcp7MQqFsEh/q121nhwu2vFihpe6Y/JY9yRl7nuldwL7uqmWDaS7mTM9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9515
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ar9003_rxs in this device has 2 additional status values.

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
 drivers/net/wireless/ath/ath9k/ar9003_mac.c | 37 +++++++++++----------
 drivers/net/wireless/ath/ath9k/ar9003_mac.h |  6 ++++
 drivers/net/wireless/ath/ath9k/hw.c         |  4 ++-
 drivers/net/wireless/ath/ath9k/reg.h        |  1 +
 4 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_mac.c b/drivers/net/wireless/ath/ath9k/ar9003_mac.c
index ff8ab58e6..059e4bfce 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_mac.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_mac.c
@@ -483,8 +483,11 @@ int ath9k_hw_process_rxdesc_edma(struct ath_hw *ah, struct ath_rx_status *rxs,
 {
 	struct ar9003_rxs *rxsp = buf_addr;
 	unsigned int phyerr;
+	/* status12 and status13 are only present in ar9300_rxs V2. */
+	u32 last_status =
+		AR_SREV_AR9003_RXS_V2(ah) ? rxsp->status13 : rxsp->status11;
 
-	if ((rxsp->status11 & AR_RxDone) == 0)
+	if ((last_status & AR_RxDone) == 0)
 		return -EINPROGRESS;
 
 	if (MS(rxsp->ds_info, AR_DescId) != 0x168c)
@@ -510,17 +513,17 @@ int ath9k_hw_process_rxdesc_edma(struct ath_hw *ah, struct ath_rx_status *rxs,
 	rxs->rs_rssi_ext[1] = MS(rxsp->status5, AR_RxRSSIAnt11);
 	rxs->rs_rssi_ext[2] = MS(rxsp->status5, AR_RxRSSIAnt12);
 
-	if (rxsp->status11 & AR_RxKeyIdxValid)
-		rxs->rs_keyix = MS(rxsp->status11, AR_KeyIdx);
+	if (last_status & AR_RxKeyIdxValid)
+		rxs->rs_keyix = MS(last_status, AR_KeyIdx);
 	else
 		rxs->rs_keyix = ATH9K_RXKEYIX_INVALID;
 
 	rxs->rs_rate = MS(rxsp->status1, AR_RxRate);
 	rxs->rs_more = (rxsp->status2 & AR_RxMore) ? 1 : 0;
 
-	rxs->rs_firstaggr = (rxsp->status11 & AR_RxFirstAggr) ? 1 : 0;
-	rxs->rs_isaggr = (rxsp->status11 & AR_RxAggr) ? 1 : 0;
-	rxs->rs_moreaggr = (rxsp->status11 & AR_RxMoreAggr) ? 1 : 0;
+	rxs->rs_firstaggr = (last_status & AR_RxFirstAggr) ? 1 : 0;
+	rxs->rs_isaggr = (last_status & AR_RxAggr) ? 1 : 0;
+	rxs->rs_moreaggr = (last_status & AR_RxMoreAggr) ? 1 : 0;
 	rxs->rs_antenna = (MS(rxsp->status4, AR_RxAntenna) & 0x7);
 	rxs->enc_flags |= (rxsp->status4 & AR_GI) ? RX_ENC_FLAG_SHORT_GI : 0;
 	rxs->enc_flags |=
@@ -533,16 +536,16 @@ int ath9k_hw_process_rxdesc_edma(struct ath_hw *ah, struct ath_rx_status *rxs,
 	rxs->evm3 = rxsp->status9;
 	rxs->evm4 = (rxsp->status10 & 0xffff);
 
-	if (rxsp->status11 & AR_PreDelimCRCErr)
+	if (last_status & AR_PreDelimCRCErr)
 		rxs->rs_flags |= ATH9K_RX_DELIM_CRC_PRE;
 
-	if (rxsp->status11 & AR_PostDelimCRCErr)
+	if (last_status & AR_PostDelimCRCErr)
 		rxs->rs_flags |= ATH9K_RX_DELIM_CRC_POST;
 
-	if (rxsp->status11 & AR_DecryptBusyErr)
+	if (last_status & AR_DecryptBusyErr)
 		rxs->rs_flags |= ATH9K_RX_DECRYPT_BUSY;
 
-	if ((rxsp->status11 & AR_RxFrameOK) == 0) {
+	if ((last_status & AR_RxFrameOK) == 0) {
 		/*
 		 * AR_CRCErr will bet set to true if we're on the last
 		 * subframe and the AR_PostDelimCRCErr is caught.
@@ -551,14 +554,14 @@ int ath9k_hw_process_rxdesc_edma(struct ath_hw *ah, struct ath_rx_status *rxs,
 		 * possibly be reviewing the last subframe. AR_CRCErr
 		 * is the CRC of the actual data.
 		 */
-		if (rxsp->status11 & AR_CRCErr)
+		if (last_status & AR_CRCErr)
 			rxs->rs_status |= ATH9K_RXERR_CRC;
-		else if (rxsp->status11 & AR_DecryptCRCErr)
+		else if (last_status & AR_DecryptCRCErr)
 			rxs->rs_status |= ATH9K_RXERR_DECRYPT;
-		else if (rxsp->status11 & AR_MichaelErr)
+		else if (last_status & AR_MichaelErr)
 			rxs->rs_status |= ATH9K_RXERR_MIC;
-		if (rxsp->status11 & AR_PHYErr) {
-			phyerr = MS(rxsp->status11, AR_PHYErrCode);
+		if (last_status & AR_PHYErr) {
+			phyerr = MS(last_status, AR_PHYErrCode);
 			/*
 			 * If we reach a point here where AR_PostDelimCRCErr is
 			 * true it implies we're *not* on the last subframe. In
@@ -573,7 +576,7 @@ int ath9k_hw_process_rxdesc_edma(struct ath_hw *ah, struct ath_rx_status *rxs,
 			 * delimiter for an A-MPDU subframe (0x4E = 'N' ASCII).
 			 */
 			if ((phyerr == ATH9K_PHYERR_OFDM_RESTART) &&
-			    (rxsp->status11 & AR_PostDelimCRCErr)) {
+			    (last_status & AR_PostDelimCRCErr)) {
 				rxs->rs_phyerr = 0;
 			} else {
 				rxs->rs_status |= ATH9K_RXERR_PHY;
@@ -582,7 +585,7 @@ int ath9k_hw_process_rxdesc_edma(struct ath_hw *ah, struct ath_rx_status *rxs,
 		}
 	}
 
-	if (rxsp->status11 & AR_KeyMiss)
+	if (last_status & AR_KeyMiss)
 		rxs->rs_status |= ATH9K_RXERR_KEYMISS;
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_mac.h b/drivers/net/wireless/ath/ath9k/ar9003_mac.h
index cbf60b090..07f073821 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_mac.h
+++ b/drivers/net/wireless/ath/ath9k/ar9003_mac.h
@@ -65,8 +65,14 @@ struct ar9003_rxs {
 	u32 status9;
 	u32 status10;
 	u32 status11;
+	/* status12 and status13 are only present in ar9003_rxs V2. */
+	u32 status12;
+	u32 status13;
 } __packed __aligned(4);
 
+#define AR9003_RXS_SIZE_V1 (12 * sizeof(u32))
+#define AR9003_RXS_SIZE_V2 (sizeof(struct ar9003_rxs))
+
 /* Transmit Control Descriptor */
 struct ar9003_txc {
 	u32 info;   /* descriptor information */
diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index c32b201a3..df59bea41 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -2621,7 +2621,9 @@ int ath9k_hw_fill_cap_info(struct ath_hw *ah)
 
 		pCap->rx_hp_qdepth = ATH9K_HW_RX_HP_QDEPTH;
 		pCap->rx_lp_qdepth = ATH9K_HW_RX_LP_QDEPTH;
-		pCap->rx_status_len = sizeof(struct ar9003_rxs);
+		pCap->rx_status_len = AR_SREV_AR9003_RXS_V2(ah) ?
+					      AR9003_RXS_SIZE_V2 :
+						    AR9003_RXS_SIZE_V1;
 		pCap->tx_desc_len = sizeof(struct ar9003_txc);
 		pCap->txs_len = sizeof(struct ar9003_txs);
 	} else {
diff --git a/drivers/net/wireless/ath/ath9k/reg.h b/drivers/net/wireless/ath/ath9k/reg.h
index d465167ac..5ec263b7f 100644
--- a/drivers/net/wireless/ath/ath9k/reg.h
+++ b/drivers/net/wireless/ath/ath9k/reg.h
@@ -999,6 +999,7 @@
 #define AR_SREV_SOC(_ah) \
 	(AR_SREV_9340(_ah) || AR_SREV_9531(_ah) || AR_SREV_9550(_ah) || \
 	 AR_SREV_9561(_ah) || AR_SREV_5502(_ah))
+#define AR_SREV_AR9003_RXS_V2(_ah) (AR_SREV_5502(_ah))
 
 /* NOTE: When adding chips newer than Peacock, add chip check here */
 #define AR_SREV_9580_10_OR_LATER(_ah) \
-- 
2.25.1

