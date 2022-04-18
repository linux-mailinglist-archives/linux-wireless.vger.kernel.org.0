Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DF9504D1F
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Apr 2022 09:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbiDRHXC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Apr 2022 03:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbiDRHXB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Apr 2022 03:23:01 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2055.outbound.protection.outlook.com [40.107.115.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DE217074
        for <linux-wireless@vger.kernel.org>; Mon, 18 Apr 2022 00:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzVvqEtVeAbY9HIstwWIi2DREyxJsBMCerFkTX3C3iWhdz/LIa3lg1+AXYPVnHCWq6BIDCosv0tSNE5zXoYKQBOhoq28XEgxXfzElpVKJ7LAxSccvw+v/XbMmt4kv32zYae/ITIQPhNFWAUfDrji+xEIQW+h4VR+aTG6d0bjjl7ec3mZ7bR/vTJpYVMXgzK/JOiE+ZLNxveO9T4K/Pdak5g4OIPUB0QcJasBm7wCVDx+yMW7uwff3vru3tfYaqglvKhT3Y9GFgXno56nmapVF8uICvTiPCS/wUewXBRN5wEpo/qhZo6JjzeNRA9veNpZDdmOuvWHKXy8HUmsmE1X2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djhTn6gLndhHS8rYn50+RKi0qoDbdNhqS2/w5f7luns=;
 b=RC4dwa9n8rQkTVzplhyUJb2bQ503onUIRxh32ZfR+Kk3BoNQ+py/z0JY21/ongCFA9BGv2ixhSD4gEA69PURxZGvuXS8hVgYZhGYjCuoHWIVZS6fy7lt/SSvfnMkXuycwORz3Bg3gV6CknlqnJIckfnNXuzoXhQkmD5WIVhqLygyjRcj7MkzZoxuVsqhMNj/UOq7e6Pzex01Cyf6zndIpw989sM6R3Cj2drK9anHmHw3sONd7mjSK+NHiYJlbb093p+dIb7HmgFkSWoZv6+VJl7+Ikf8wi4fZXLjPiHDmddIunrWVe8NYiTRTn6RgJ4M5d7Mk5gwxyF6mutBPnCQbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YT1PR01MB4363.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 07:20:18 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::788b:f975:24ac:69f]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::788b:f975:24ac:69f%6]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 07:20:18 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH 4/9] ath9k: implement QCN550x rx
Date:   Mon, 18 Apr 2022 00:13:08 -0700
Message-Id: <20220418071313.882179-5-wlooi@ucalgary.ca>
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
X-MS-Office365-Filtering-Correlation-Id: 07d87fa8-5713-40b5-f1ca-08da210be456
X-MS-TrafficTypeDiagnostic: YT1PR01MB4363:EE_
X-Microsoft-Antispam-PRVS: <YT1PR01MB4363E952378FAC8A8853FC75B2F39@YT1PR01MB4363.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hrGRzs+klbrIMKF2ybugQfj8Q21+XJu3tEA3Me4Q0uXR3XQVmaFgmt5rlyYadD8/F92kiCq8XW6dhBPwRq0J2SfcjocUSKFgXe+5ANZWl2QKilwgt5zUzi+j0P1gd1Y4Vf91H1oNiqmrO2eOm0JVB/2033EzxShUCje1uR6jKrfcY7qz+NvTqmTOMj9a1kVSI0LT2gHrMeCVsk1HhUgih68Syr4di+VbiT1Pddm3XmV1WLplvHV/JR+6n1rci6RcXVtB9bUC73v09Yr0Mssav0MX/O/RXR73tMv7IEuxHGm977lEfTCWtbdyFMenisOIhdNXZApCuGVDaIlW+H5hqmY8uI+sE/vxlzy0kThWHCXnX+yIdsQAq86AdRGjWfipD1LUzMrWPmYWm2+54eu5rX2ZSPNakcRLh4qS3nPhw/VGsXx7moXwp8nVFzOlYZbQSaAxEIrinMEc8tgze65zp9F9muYUU3piTxm7ozY8WH4U4W6mkbVRYt/YMskqIsZqZd1pMAnQcCfE7yn7LUiqHVKXFvUgn1TWQhvt1htsBezV511TJQ0cKs0+sFNLGZdCOsEKYA1O8LcSApZN5TACeODVgkFfh675x+1IjiBHoSz3tlf71xgLJptOwcfpQu8gG1etoD65zBpsuRq2qAC9/LF33zd2GjdZk5NZZp1vlXtgBsns1c99xHRCoKZzg3kNXkR6V73JNBr83vTtcVyMWTJc6HR9KFk7N+wANQYdPAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(86362001)(83380400001)(6666004)(6916009)(54906003)(66946007)(316002)(186003)(26005)(786003)(38350700002)(6486002)(38100700002)(107886003)(2616005)(1076003)(4326008)(8676002)(66476007)(66556008)(508600001)(8936002)(6506007)(36756003)(52116002)(2906002)(6512007)(83323001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kGtM/eCUCjrLyFdmBWS32GouCGciuVIU/VHdFFyH+wxb9Me+cTF32ksqZ1XJ?=
 =?us-ascii?Q?ytn/y6TQvrUsNroOWZMddwre1tpRZk9ci9SF4Qbe/LZdaVOQ82nb+p+OwPcy?=
 =?us-ascii?Q?2WLB8xq0Vcmmi6KSRnD2d9zC3S4YPgePN8z9vhb3TjD3ldp89nHtGtcoA8lT?=
 =?us-ascii?Q?ySW8eXV0fwfLIkbFntV1RnLTMAD0DFTVdf27SXCMNiw5CDBCwcOTD7yENdOn?=
 =?us-ascii?Q?6wgWjPlGIfeCWINx6WSbal9C8WY05zS1A34XwZCDz50YjuoQ+MJbl7mn+uiK?=
 =?us-ascii?Q?bIVklfDGbBB7zZCMKIn25HZpE5fpLLZOZyoWdyrcmikPpzFBjhASI4YpBOjk?=
 =?us-ascii?Q?f5boPxI/ILz2o8oPXESHitSDx3VlbVPIqGVVMFEeUisQPvrhK3qpNZIUSL8h?=
 =?us-ascii?Q?WYnZNFasf1kkJiTO4RcLabfVW5uBVueyVNeNA+N28jN63+1lmec7wdLSyCFX?=
 =?us-ascii?Q?hfoNq63nyI/Mr2eRLejkSybgT9KM6umLuqudlHxyR7eOHbGfrprtlnNjeXbY?=
 =?us-ascii?Q?l/fJcz1pCN6MZojtJ6d8Y5ompNYi1zXCiHd/rAKYgFe5g3sl/4y2duYqTsA6?=
 =?us-ascii?Q?+iAI62UyCRKbp2hjMmEXv3lrexK5Ze37FeS4dNm1ROmybp5EdNaurP5Irry3?=
 =?us-ascii?Q?kuzJCiTN7PPmlgsZITIQAelbUFU1jW4KFqCAE+/t9rkc1R+lSk/peBNvTSs6?=
 =?us-ascii?Q?7yq8oktBqEhHTKpv09quIxoQF+w7twZ/6U6mBjIonumlnkulOMVd904VESyp?=
 =?us-ascii?Q?3/EElf9wTm57Zg/lidVlVQOghI5tLOpmkp/UIz7Idl1+KQrRs5OyLbyyznsz?=
 =?us-ascii?Q?m5YOqiDIkZd4eUJ3c/QMI560djuI47bBQHi5xI+kawEwzw/wj4yLnpBTdw3z?=
 =?us-ascii?Q?8XWod3VfArqxCJFNA+pu7/xIUi7z75Tk5qTkrZgRKtEhny8M4J9039/uBDcn?=
 =?us-ascii?Q?AXm/HxdFHhY6Zw5iTSLdlQuMQs/M8OYfZ+mthU8Euydmt5R1mnu78nEUOeDi?=
 =?us-ascii?Q?2Tb1ZrHr5UYS0Vd6ldshZfZhLNb0dFeraStA3RekBv+apXN9bRR2EoGWiEKH?=
 =?us-ascii?Q?C8zwZ09b7n53G3NSxqBmCPSfgxLfKLiVQYTf/Z8qr1155NWb1AoEoJS7Su4P?=
 =?us-ascii?Q?iH/msKaTbhh72n9sZVJMzEcuXixlptWrls2FbjDfN4HVlYvhv9PLff51/W0X?=
 =?us-ascii?Q?Lvn61nFiU92kSRf/nRIU8wLKrriVD7sITqoF3UN9KPSBLxbYgpJzRGfkQuYs?=
 =?us-ascii?Q?3qc+pGkZDVFNvqwK+rIzVOOmCoHEzJudDno1gL1jdXIEdc4WHLDePXhbsxI5?=
 =?us-ascii?Q?SvsYJrW9jianjwCQ7x/YafaZwjB5z8kM2gwfkRSWWTPDvgVXAGtczRGc3D0h?=
 =?us-ascii?Q?Pm/P5diO78TqiGrbTCoUP/kUr343yZWli94QtDCllAbqDdKNXdEePSYK1t2r?=
 =?us-ascii?Q?bb5tspI9Ma7WplxPRpSrwf9oGXEI9B5jQxo5PbJI3GPzERfxjZeNoa6baPns?=
 =?us-ascii?Q?vB2wvsU1NvxV0E22bueLi4XtXSv07i7wSfTD8BCZO3DPZAuM/wjCbiCI6VUe?=
 =?us-ascii?Q?SbKWQKmsjQ7TOHrpBxp8fmcMXr1lSMEj3pSVupCBpIBQaNPC5F19uKbP8X2c?=
 =?us-ascii?Q?jQrEwTJB7spZAQ6qZxiMuCFDjM3lvVWO2f9rEo1mQZ+Idfq89WhB+Qn9Nt9P?=
 =?us-ascii?Q?Q/dQKe2bP19WqPHuPGwcaJ4kyhEhyr+SOEVOCrQF6fpLNV2LQHLsrxp8yLN5?=
 =?us-ascii?Q?WXdLdt+mlw=3D=3D?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d87fa8-5713-40b5-f1ca-08da210be456
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 07:20:18.6544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwEGDC3yHibRUGopUGIfbE6Chr6uMxL3kyygd0kOnMX3zWaACA3K1vb3TJZvX02k+YhmJ5RWC/UcEcnhpEUwlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB4363
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ar9003_rxs in this device has 2 additional status values.
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

