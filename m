Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9740A4E1E40
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 00:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343794AbiCTXcG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Mar 2022 19:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343795AbiCTXcF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Mar 2022 19:32:05 -0400
Received: from CAN01-QB1-obe.outbound.protection.outlook.com (mail-eopbgr660086.outbound.protection.outlook.com [40.107.66.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327F4132E8C
        for <linux-wireless@vger.kernel.org>; Sun, 20 Mar 2022 16:30:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOEVL2tPOhTsQX9TDJVgomGXHwK9epTRaEhjuO6dYIYzbH8NDUP3RxTjRbIeJffpEBM6hRCFlWnAw74dNFJqPYOJdcDvu2Xi15K4Pxzf5uG6fGjWXrmblgUsqCB3Dku4n9GeGaa5gYqAlBGaaod4ejehEfbllDgXV5hjoVeapdWvzjr103Y5TifI61e/L0i+ek8gCsa6OUJRwQz9+/cgBqeLigvCmazJLAuLmfyiCJqrSosV25Mmdx0uRSQ+EJ21+ILLaiKaR+536N3ycO+1LyRgbKg+pUX2Xhg48vYj2pGpfhBK5tTn8el1rDoyWeVUTUQBx5UbPWcnZxlUp3GX2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3P/bbTUJj/+WdI/CITQLN5rbydm6fd7pty+OZOYwbJE=;
 b=E2Potz9ZRVlo4gOW+sEoa5qosQOn1hQAyiV87WCPcewIuleSbSQXms1PNfuMZLxVOUsljx0CiLwzW+vSGnNUCDfETeamRp5zrV/A8CZ4FcSjNMun1oQ4ads/vQ/HQgFOB6IUIFjyXZCoi4fRRMPwPcS4RThzW5ETgmvi/d/YJ3nyY/QGD5yQQSyiTwwAOXR8cxZX4it1D889xSojAILlGyQDXjoeNFwFmO3FuXM/M+qJtKH8YnruFxQTVqfWbwOz4Ylx6cP0/fDxocJedfZPlkVsOpFIEF0QgFD+rYJuGIAWhSUSIYEK1mBzeOaaIH5M2hexWBFOHpjM6mAkhsNrpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YTBPR01MB2989.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:18::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Sun, 20 Mar
 2022 23:30:39 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dd8c:6e57:c431:9323]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dd8c:6e57:c431:9323%6]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 23:30:39 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH 5/6] ath9k: refactor ar9003_hw_spur_mitigate_ofdm
Date:   Sun, 20 Mar 2022 17:30:09 -0600
Message-Id: <20220320233010.123106-6-wlooi@ucalgary.ca>
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
X-MS-Office365-Filtering-Correlation-Id: ad7bed0e-4013-4294-0998-08da0ac9a478
X-MS-TrafficTypeDiagnostic: YTBPR01MB2989:EE_
X-Microsoft-Antispam-PRVS: <YTBPR01MB2989CB4AAFB1962BFCDC05A0B2159@YTBPR01MB2989.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hS3kSJEIES/r+Rjksjksz0pVG8mB6GCdEbsYQvGEOmhoEe63gf2q4/trU/iqZD/gvMsPJrRP+f4DU+L2IKIBT39Fvwnudwfwlkc+Su6bL6j8XMaRpMy8ULJkqGhoIkJhJvKXgiF0VU1/7EkrQopSBhc/axepQjKQUSiemSkhMsPAEVzQn6xhGhUfTYcsYp0x1wmwojhdPKQbZoM27zK/d3m5V/IyMTPGAVCRyl7nX9EZo9oleJE9/KSuPmHeb14wKh0cLcMUFV3cV0Tirfi9px5XaO1dDh6yOnqUSSOMY15UzXvfABgcTjJq0OzpPXrswoFl3TB+JCppUUVheQOHpKXo5LINSD2Mtv87T0y/lP0+SzPlpDQzwfnP8KIkJO3qsQTOZaERbM2grX79PjarzI61o0vvvzskKsWeNEaGQcKZmaQePnUYQaDcX+lsHIcVVxfSV7fD3GwFkh70YIHjuaHUflYY0Qp23A0c7JjK92cCoGrVppGiF4rPxmtgGhbm6kqVggF4/M+iD11C2LDsYVggXdW7216Q+2STTbl766gPbAF+5HGnzuv0IFsao+WU7t67kn0R5pHsFzqg0ddEq4qWTfoPeJXwbGgOyN0xBbypHDJUweGsoSXtbyktYrxSK655tzSwmnboK4z3JnQ8rPjlaLminhUgBfvLTQyOEZKxzxmJBOKuvDaunKy0bIbACF/4kl35JXVFvYXhZNf0fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(2906002)(83380400001)(66946007)(66556008)(8676002)(66476007)(4326008)(786003)(316002)(6916009)(54906003)(86362001)(508600001)(5660300002)(38100700002)(38350700002)(8936002)(186003)(36756003)(6666004)(26005)(6512007)(2616005)(6506007)(52116002)(107886003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M1wAcmprbpjfQ8/CgqhNebm8KCs5F4PSMsOh2hgxulJhNHfPMrCB3rQC4zSv?=
 =?us-ascii?Q?4KSA//55moRtBeez3JGCa+W1YaFaWKXx17C1C4wjMTeKNFqFvFdiu3jESZ+I?=
 =?us-ascii?Q?NIhJv2ynul2QEJCVfI2WdJJRRZ8yNTfhfhRRzasdrQ5ttkYdyip1JdMV+4cE?=
 =?us-ascii?Q?/KBIZ+L1OzHcdttg+ldkuRaK5xI9TcsXN+SFSaflqXveRvtUonpkucO8aQ9E?=
 =?us-ascii?Q?Nr4GGAq/V5/wRC+ML5RlRytSy248rezE8Ewkge+4lmAlGoTgEWj3Jb1V1F+s?=
 =?us-ascii?Q?ur0n1+CTRH2eaecK4azfopnLex5lTEe6eocHzRsDRXlBeoTxWXc3bpJ6X9s1?=
 =?us-ascii?Q?d5ncBavD/hryQQ7Vo2m2IezWl6KLgiluK3zLimHmlDLeEtBU6VzV/7COulzz?=
 =?us-ascii?Q?jNVJwjBJoGmIp+Evq+e3B9EyVuiDoi2jQknxxfxONQix7BhexV55NDs1rsxU?=
 =?us-ascii?Q?DF2bR7tJZh7Cp6AFybfBwUeKlOn4EVTwdDyERHdAhZhM1XjLaNWbQC6eFWxp?=
 =?us-ascii?Q?TJXD50AydKPFOGvJt7k1y3djian1UMV2NUstLskInpBVY7ETE1wHZ71nAh2V?=
 =?us-ascii?Q?FxShFrZEG0R15IImUYO0U1F8Wx8FzAUCJU6xnscGcXwZODjTiJGkuVK8yfwG?=
 =?us-ascii?Q?0B1j/YVhJeCXPQVElvUSbwhkXzbMPmGiRawlC5uK507RDxBsGMUEvO/V0Kr0?=
 =?us-ascii?Q?D1MGJ4JfkLeMX+VA5Un7YhfPtWzOZ7MjtBjRD6pmJvH7+CHXnislaGTr7mWl?=
 =?us-ascii?Q?gaSZ9GdnKOwJbXWYNNgv+Rh55ofv2KCiyHMQgFx6epFK/sgZg294jd6h1UiO?=
 =?us-ascii?Q?s+g+F4WxJQeXGrnNSagmQr82iuzhb/WvzjHX/khCul/hJnbGyj7L5G1hFgHj?=
 =?us-ascii?Q?rf6gYqZEjVsmyLdwd6NlbTNR0CoPPQ3rCyKW/n1ULrWBjpXlpP6U5/KRTzLq?=
 =?us-ascii?Q?C7CEdIH+Z+EhfHkZvCawS92GotWuXatX/R46pKgdbdj76L2MGavTEdJnAhsI?=
 =?us-ascii?Q?sd+f3/YweWDfK1pWrMIhuf8v05PkzUOAHOrJfxouUdsY5Re4Txu3Tc5h1Q6e?=
 =?us-ascii?Q?3XIviI+LcWEeJj4hHt6AKDVj4nTfDdzhULe/qqF+XrRmOFbvjcD/7iv8U5Dt?=
 =?us-ascii?Q?Gi8lN3ewhMGwZhlooWKJFOkcanRnFKuBZzIaWP3HVXxkXugzzw3ncew4vph0?=
 =?us-ascii?Q?14C3M9j77Wg+TcQgyfhiMeXV8sNBe1udb4Fzo6l8unOYAQE9UIE0hP2zgKOJ?=
 =?us-ascii?Q?n1svmxsLWKSzbnnxtPCsBJHRiTRmYC7UkHTJGfbcliP3h7Go7L5IrB7+wmSK?=
 =?us-ascii?Q?WnlA4YlOPnGSVKHzHsenuO5yTQFyMq1OuLUuRbS6MhniaZP/PA1tFDki36E4?=
 =?us-ascii?Q?AtDoCRP3aTggB/oTDd40+5aMwItbTa0Kd/ujiAU3ismr1Co5TEZzIg8V4N72?=
 =?us-ascii?Q?ujpg/5kjIziIupoZmrsy7Z/A67o66K2t?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7bed0e-4013-4294-0998-08da0ac9a478
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2022 23:30:39.1318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FEKmnImcXpd1lknarZSENhRS51W1h6t5bGBqMJBeCtZB0F5aSB1z1uYQwmwDUMtCpCvom38EmQXoBqt9K5dagA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTBPR01MB2989
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to ar9003_hw_spur_mitigate_mrc_cck, simplify the code by using
ar9003_get_spur_chan_ptr. This may also be required for QCN550x support,
to provide an abstraction over the underlying EEPROM format.

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
 drivers/net/wireless/ath/ath9k/ar9003_phy.c | 25 +++++++--------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_phy.c b/drivers/net/wireless/ath/ath9k/ar9003_phy.c
index daf30f994..dc0e5ea25 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_phy.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_phy.c
@@ -523,21 +523,10 @@ static void ar9003_hw_spur_mitigate_ofdm(struct ath_hw *ah,
 	int synth_freq;
 	int range = 10;
 	int freq_offset = 0;
-	int mode;
-	u8* spurChansPtr;
+	u8 *spur_fbin_ptr = ar9003_get_spur_chan_ptr(ah, IS_CHAN_2GHZ(chan));
 	unsigned int i;
-	struct ar9300_eeprom *eep = &ah->eeprom.ar9300_eep;
-
-	if (IS_CHAN_5GHZ(chan)) {
-		spurChansPtr = &(eep->modalHeader5G.spurChans[0]);
-		mode = 0;
-	}
-	else {
-		spurChansPtr = &(eep->modalHeader2G.spurChans[0]);
-		mode = 1;
-	}
 
-	if (spurChansPtr[0] == 0)
+	if (spur_fbin_ptr[0] == 0)
 		return; /* No spur in the mode */
 
 	if (IS_CHAN_HT40(chan)) {
@@ -554,16 +543,18 @@ static void ar9003_hw_spur_mitigate_ofdm(struct ath_hw *ah,
 
 	ar9003_hw_spur_ofdm_clear(ah);
 
-	for (i = 0; i < AR_EEPROM_MODAL_SPURS && spurChansPtr[i]; i++) {
-		freq_offset = ath9k_hw_fbin2freq(spurChansPtr[i], mode);
+	for (i = 0; i < AR_EEPROM_MODAL_SPURS && spur_fbin_ptr[i]; i++) {
+		freq_offset = ath9k_hw_fbin2freq(spur_fbin_ptr[i],
+						 IS_CHAN_2GHZ(chan));
 		freq_offset -= synth_freq;
 		if (abs(freq_offset) < range) {
 			ar9003_hw_spur_ofdm_work(ah, chan, freq_offset,
 						 range, synth_freq);
 
 			if (AR_SREV_9565(ah) && (i < 4)) {
-				freq_offset = ath9k_hw_fbin2freq(spurChansPtr[i + 1],
-								 mode);
+				freq_offset =
+					ath9k_hw_fbin2freq(spur_fbin_ptr[i + 1],
+							   IS_CHAN_2GHZ(chan));
 				freq_offset -= synth_freq;
 				if (abs(freq_offset) < range)
 					ar9003_hw_spur_ofdm_9565(ah, freq_offset);
-- 
2.25.1

