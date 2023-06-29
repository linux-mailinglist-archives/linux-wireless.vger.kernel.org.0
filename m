Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0D77430F5
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jun 2023 01:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjF2XRA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 19:17:00 -0400
Received: from mail-yqbcan01on2054.outbound.protection.outlook.com ([40.107.116.54]:58502
        "EHLO CAN01-YQB-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231235AbjF2XQ4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 19:16:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMQfi/E4RFSF8aBZBskQRlSzytLzyp7G8Qty5gm3fynt9n/NVmQ2hCMPtmQgIhpNYGtUvKspa2UPXjSD8oVBtv2boXVkvdJnbJSTV76+pE9ebu1KqR8cRojWFz1LZZGpABEtdNWW6rSfVB6RvT10PeRHTNFRQNeuDjYrY+zJSvpMRWFKTe/jx2sPkF4f+gvjlD9fD6WETjDfsp/o8w8GFDmvPGCl3XpZSy+iHmpVrNTIvTmI+PsLURaKSiyCQdDIzWLMcW7RfnUQFFrBXB8fXl8yrHrOnJeQ89KCIzXadTU8SlCSpDltWLSxRHYsWLNSiHZvETwB5H/y1p/l9bbDpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyDhw/iyJGoGP8cOiNxuXezhhAg25aG9ExLc5f58uKo=;
 b=QMCbcempt2OcJTLBON39Y1aaq7j3X6zHgAgpsxOYWYcF9E48BBEOQT5/OZ16UFf8Y9Blm0HOYK8GtrytlE6NKAAV2R/ipIG5Y6FON7JZIlAeiqY3fh4Lj5DIvR3McAWZfreqLbc/4oYUFmguF0grNwxoAWGWbTdNOy2zE00apygqRmHBek1d150D4BC+Ru95QySQvd51tfin25LOs7NWm4FGuG2BdCPGJXtGvrp9jW3P7P5PKQFI7QYPpjY6L5cehQj0h0yH6OH/xRa50UvExp5guO9sajK6lUzSQt1igApEuMT9JTxjjsHni202xsXcY+n6jQgJrhTtPBdtWX0sTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:16::19)
 by YT1PR01MB8473.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 23:16:52 +0000
Received: from YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::684c:a6dd:94c8:78bc]) by YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::684c:a6dd:94c8:78bc%4]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 23:16:52 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [PATCH v3 08/11] wifi: ath9k: implement QCN550x rx
Date:   Thu, 29 Jun 2023 16:16:22 -0700
Message-Id: <20230629231625.951744-9-wlooi@ucalgary.ca>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629231625.951744-1-wlooi@ucalgary.ca>
References: <20230629231625.951744-1-wlooi@ucalgary.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: BY3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::7) To YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:16::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YTBPR01MB3310:EE_|YT1PR01MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4fdcdd-6e77-4feb-f7bb-08db78f6ec6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GY18s1Za8uc1YHKWFg9S20KSgniHK60jlqDseCheaz+XF4An0mp4kEYOhGnShdPbo4+8qV3dIaZP3D0JHouuS4tGglI9X408u4HWShYrbVd0APFvZphNhecwMuWKezu+PRmSKA8Ch9wLloqVfOE4/EPkljCbQP4j1YtFdJ3R8nF3XEtwLCvOis8e8YU5ssPdPXx8KNVFLnrgarCbh5+Ib7dTRtTawDgBaN03tb3YRB0vQkdbLh8tCDFu8GD7UgADr527XuOr/1koz7ssrkSNliCa9fIR1gPlnK/kH0b5N/H+2qUvI00j2ogLK0CVnSzoUVGK2qAB+aOL5la8NVZf/2LKZuMhf71wgKO+6ziwCvCNrst8zU5H6UQT/i/hkM+g8vFiZ43a91k8gw0MTCsmIm4iidVhkbyR78klOwJL4QPMka+25KMx09asFHj3Qz0Sd2L1y8xqe7taCgan+Adn8paKH12V+eW5g1y3CUazFfD4IBItIRX/354AcFqXsPoKZcHmfjI5FQIXPBICwQyvKNqlj29LHQMH+SWm6D0hLUXCR3T4okwx5PaOud//3+m6e9xky5KtwA8vRdLri77HoHlJZ3wQHjM4mVVCd6AXXvVmv9u6cvPrljAVrOaFVs6v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199021)(26005)(4326008)(66556008)(66946007)(786003)(316002)(66476007)(8936002)(36756003)(6916009)(478600001)(8676002)(5660300002)(2906002)(1076003)(86362001)(41300700001)(6486002)(2616005)(83380400001)(6506007)(6512007)(186003)(38100700002)(6666004)(83323001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3hrfn6MsdVobctZm89sRnBxgeJJpzOKyZ225rFofxph3q+hV6I4lmK74rv6M?=
 =?us-ascii?Q?m2C4yVFLnLe9urdXkuUTjNifS1rYLme1kj5V27LGeN5jG0HSAQU2++KmAWqz?=
 =?us-ascii?Q?q6BQyn5H2GxLPWy7mX0YQGyb/xgYN3YptG42IgYhXWGB3tMt8XIkF1P4rvFT?=
 =?us-ascii?Q?9LNaqNTey31hH6twCr0jQyLhRIl/kH0L6z+5wBu679Pn6c8v1qcXYw0lLYHy?=
 =?us-ascii?Q?dAh7Y0K5Co5KRAM6TxTcOhc9JRPm0rEzSJc5XmcKnDITuN5kKkYh4rfnj0ca?=
 =?us-ascii?Q?2feY3rvn1B2/xX1YhVy841mr3Q3BALT8Wo6aLTiI5LP/+OKAdIaE6bWl+s6O?=
 =?us-ascii?Q?XfRhJsYfI3Oh5HhB+RLkX4C5yYMHLCrn2n2+eftZa6rk4RKwXiz925qTFiuZ?=
 =?us-ascii?Q?UWG2P27iI7xSfUiUPQbe8dH+Y5VWtX7TRpzJgLCnFCHgv8pKxUSev2leLMAh?=
 =?us-ascii?Q?rxCpAKzvB8ACWVuonyBr+pIOhulokhfotD/AXRYqQmRK6jFt7tm1hzwOsrOU?=
 =?us-ascii?Q?QwdMRPBe7GfNdZDKHQvkw7cKVqq4xox73VQbux5mmsCvnIQMEu2kd2+CmWkm?=
 =?us-ascii?Q?/vV8UI9l6+M1c3rPsPg9jAhk0raQRpoRslnbvrxtRVgQpAC4ncq+5WtyyjIh?=
 =?us-ascii?Q?xmG8jn8mDVcFaZiTJ8JbLHwwDuzDlJUQGAyTAy2Loc00ua2bsTX5nZOq/9CV?=
 =?us-ascii?Q?mk8XebDqZRbQOnCl9XB7af7ZdtJk3Ae5n+DXHkcpYiml/ZevZCzazHbVHYvg?=
 =?us-ascii?Q?Fwxe3HznkKNW6rmLLhDqC6nuqKC0xpYZHi/uwrQd/TBKha1X8+EQvkyTTvgP?=
 =?us-ascii?Q?BrldmvQ7o14FIYJaGufN1nzaRGEtbDv33h1nq8Kqo+uCsMQ2+09jTK3ADiAt?=
 =?us-ascii?Q?8vzvwFglSCk5YEIq2GqS7TEAyuoCjDImgjYZjjJXVn3v3dB5QmUEtx1eMR4N?=
 =?us-ascii?Q?k2CvDWiCU8npK+EDkSFZWKHKQQi9T5KOjDZqv4cPxsCk2auBb9SpQlXOhQYE?=
 =?us-ascii?Q?b6wcFNZcIYnfD3KQobu9gbExt+KJBvLTm4N9fUElzGp5Ggl/ktMExYjjMPRe?=
 =?us-ascii?Q?x1g7rn69sXNhpfiybLktGSgpAxXtsTXcj4KMmEfrL5RPhCG/qXiJuy60x8OW?=
 =?us-ascii?Q?B2v3lVj2NJkz+IPU4WOT3A/s9r3q4CdbH6O7f5IW43u9M1FYVq9H03SAG5/c?=
 =?us-ascii?Q?funfwRQvPVy/oB7Gdm/4tVYbkbgONXeUjGdI8hGkT+FyuDKFMEJDIWFX1Ygh?=
 =?us-ascii?Q?2dMlf8nkdE53Y+yKss8Nnw2TUMZ8KV8lyGpQzYBZ6YJEhWq7YH7bmFNQ0DBa?=
 =?us-ascii?Q?/f/Ajv1eo1q0IyHp60a9ki69f0Rd1VanbN5UjrhY0s0L292Ei35cwBIL401j?=
 =?us-ascii?Q?xcpPd68ek9SYGiz4LlnPV/CoAxgKxU1DizAjAqVb9QQI8/shEH/NV6QNK29p?=
 =?us-ascii?Q?FTRsT+/mHXwdiVAw+2gLmuL6g/FvoOgg6ZvbLRPwJ0lAXzCURC7+dp0wHMoI?=
 =?us-ascii?Q?K2+ZNQLrVzjtY5HQCtjRruEVes6wqKGlgXI6THqiw6pN/tYxQGM3YmR5oDcc?=
 =?us-ascii?Q?YNwCikKylOvsQ/ggvMYHdntzYsvGKSqrSWjMQ2kS?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4fdcdd-6e77-4feb-f7bb-08db78f6ec6c
X-MS-Exchange-CrossTenant-AuthSource: YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 23:16:52.7777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4PqiScjKF1KS3n3v7ohD4pVLDQLfWhCYYSIeCCLOii6VZNlO/AfNWTgvjcHoGWng7B/Yh9q6S0+MdL/UARHaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8473
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The rx status for this device has 2 additional status values.

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
 drivers/net/wireless/ath/ath9k/ar9003_mac.c | 47 +++++++++++++--------
 drivers/net/wireless/ath/ath9k/ar9003_mac.h |  6 +++
 drivers/net/wireless/ath/ath9k/hw.c         |  4 +-
 3 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_mac.c b/drivers/net/wireless/ath/ath9k/ar9003_mac.c
index a8bc003077..3d512916a2 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_mac.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_mac.c
@@ -481,10 +481,21 @@ EXPORT_SYMBOL(ath9k_hw_addrxbuf_edma);
 int ath9k_hw_process_rxdesc_edma(struct ath_hw *ah, struct ath_rx_status *rxs,
 				 void *buf_addr)
 {
-	struct ar9003_rxs *rxsp = buf_addr;
+	const struct qcn5502_rxs *qcn5502_rxsp = NULL;
+	const struct ar9003_rxs *rxsp = NULL;
 	unsigned int phyerr;
+	u32 last_status;
 
-	if ((rxsp->status11 & AR_RxDone) == 0)
+	if (AR_SREV_5502(ah)) {
+		qcn5502_rxsp = buf_addr;
+		rxsp = &qcn5502_rxsp->ar9003_rxs;
+		last_status = qcn5502_rxsp->status13;
+	} else {
+		rxsp = buf_addr;
+		last_status = rxsp->status11;
+	}
+
+	if ((last_status & AR_RxDone) == 0)
 		return -EINPROGRESS;
 
 	if (MS(rxsp->ds_info, AR_DescId) != 0x168c)
@@ -510,17 +521,17 @@ int ath9k_hw_process_rxdesc_edma(struct ath_hw *ah, struct ath_rx_status *rxs,
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
@@ -533,16 +544,16 @@ int ath9k_hw_process_rxdesc_edma(struct ath_hw *ah, struct ath_rx_status *rxs,
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
@@ -551,14 +562,14 @@ int ath9k_hw_process_rxdesc_edma(struct ath_hw *ah, struct ath_rx_status *rxs,
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
@@ -573,7 +584,7 @@ int ath9k_hw_process_rxdesc_edma(struct ath_hw *ah, struct ath_rx_status *rxs,
 			 * delimiter for an A-MPDU subframe (0x4E = 'N' ASCII).
 			 */
 			if ((phyerr == ATH9K_PHYERR_OFDM_RESTART) &&
-			    (rxsp->status11 & AR_PostDelimCRCErr)) {
+			    (last_status & AR_PostDelimCRCErr)) {
 				rxs->rs_phyerr = 0;
 			} else {
 				rxs->rs_status |= ATH9K_RXERR_PHY;
@@ -582,7 +593,7 @@ int ath9k_hw_process_rxdesc_edma(struct ath_hw *ah, struct ath_rx_status *rxs,
 		}
 	}
 
-	if (rxsp->status11 & AR_KeyMiss)
+	if (last_status & AR_KeyMiss)
 		rxs->rs_status |= ATH9K_RXERR_KEYMISS;
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_mac.h b/drivers/net/wireless/ath/ath9k/ar9003_mac.h
index cbf60b090b..ec8f3fac67 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_mac.h
+++ b/drivers/net/wireless/ath/ath9k/ar9003_mac.h
@@ -67,6 +67,12 @@ struct ar9003_rxs {
 	u32 status11;
 } __packed __aligned(4);
 
+struct qcn5502_rxs {
+	struct ar9003_rxs ar9003_rxs;
+	u32 status12;
+	u32 status13;
+} __packed __aligned(4);
+
 /* Transmit Control Descriptor */
 struct ar9003_txc {
 	u32 info;   /* descriptor information */
diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index f572fca3e6..8d1dc77da0 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -2622,7 +2622,9 @@ int ath9k_hw_fill_cap_info(struct ath_hw *ah)
 
 		pCap->rx_hp_qdepth = ATH9K_HW_RX_HP_QDEPTH;
 		pCap->rx_lp_qdepth = ATH9K_HW_RX_LP_QDEPTH;
-		pCap->rx_status_len = sizeof(struct ar9003_rxs);
+		pCap->rx_status_len = AR_SREV_5502(ah) ?
+					      sizeof(struct qcn5502_rxs) :
+					      sizeof(struct ar9003_rxs);
 		pCap->tx_desc_len = sizeof(struct ar9003_txc);
 		pCap->txs_len = sizeof(struct ar9003_txs);
 	} else {
-- 
2.34.1

