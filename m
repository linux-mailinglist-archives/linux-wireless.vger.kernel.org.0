Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B546A643F40
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Dec 2022 10:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiLFJCo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Dec 2022 04:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbiLFJCk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Dec 2022 04:02:40 -0500
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2058.outbound.protection.outlook.com [40.107.116.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B081D650
        for <linux-wireless@vger.kernel.org>; Tue,  6 Dec 2022 01:02:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWmsL/umd1up+9o8pvHzoIeThYYTW1q+8CqzEXnqhvh+SQ4g8UCvz/NeMLW9P8giA354SArkBIXxclL96qOmiJXxrKOUawSOR0OCXtceOfJjPivUC1C1VqSC3vR7pnFvWOAVe30J8Oh3Lr0M1YVpBkwpwBDj3mh6TWLcRmLvVPniBU3bbxPy/VIxc7dK2CirXYtXlj0dqe0voG/ai+t1yrtbFWOAEKxc988rWqgQ3PnvgxZ9x3Ij7WN8ovHEUoxPCbuZvNV0IuLihjhwLNi9YsvH1v/HLbTFodhZPOAxR3crVA2SJo93FMRVfTyETknJRCnMU7XDyou8mSH7oKb1RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYmIg/7ihS49TfnmK/OG20J0mwv0WsvdMrZReI7iU2E=;
 b=jyxVhVnuS3SxPZJtL6D7uLl/qspdOGSLbEHkZCSAO1ILgoOggLkjyJmQtQAboPwdSBQ93cjSNCFjmK6wEewwhZC9b/xLcZnKH5ThzGrzW8uZHZ9JQtH4h68YKZLIkwB2X7pQOZCId4cJwzHfHlDyG4LXFb4+LN/YOBWUkaughVNnMdz0dd6TbINUmZwVkvl1oAn0DjibMhMrmUpkN1RvkdgfNOush9iSpdWbRulk4oJaAJRSowINJ/1JdCYmFARvE8+7W6Fpz4xhLWS/twTVIuzfajDOFHr3RFAbJU0mMsqkTBzFnGDtPaYFUMVHmt94Cnew1kXYbwrvZ3Hhq18N4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YQBPR0101MB8414.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 09:02:26 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a3d2:e86a:1a9a:9cc6]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a3d2:e86a:1a9a:9cc6%7]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 09:02:26 +0000
Date:   Tue, 6 Dec 2022 01:02:25 -0800 (PST)
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?ISO-8859-15?Q?Toke_H=F8iland-J=F8rgensen?= <toke@toke.dk>
cc:     linux-wireless@vger.kernel.org,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH] ath9k: remove most hidden macro dependencies on ah
Message-ID: <c8369317-cf84-f0e3-fe8-9b6e22e43a6a@ucalgary.ca>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BYAPR06CA0054.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::31) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQXPR01MB3302:EE_|YQBPR0101MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: ece9caf6-f0e7-4baa-f7c1-08dad7689873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8X2+sB+bmjHktceBi9Y2b6ZAvhKUmptOHdA/Rv34XL6XAvjjBTkMCvyb+/pdotCKC3fdwFS/m8bKDYwx32N1sy39szlacBxFoyNgjgu5gJQ90juDJ0nGePZCaTmqPFmAm0j72qrMR2rD4/IXp0V8sG0XSYoJrpYa2IQ9vzK28xeIVWJuWSw+b6NWxUUAAx/vY5Sh5ZEo+g9wJUYCM3nOz/4fua2GjMrbMK1YiKjwwW7saHFuBpAfgw7ypyC6l73ecq3q5tyxutF5ebXgu4ixIM/q/jjtFzgOgStLI0Wv1AV/Y4Gtdh7ONarnAwDRwemyTIzIH+LN/QtUyMJXAtpKnCUCKzEep4YFsREZRhybQ8F+A9o+lUh4gY/Bb7qc11IvHTllIYpfzvWhSJLppGOCTi/IkU26NJxPy68w13gboM4PDRPTJBfUMgCs9gn2Yc7udXxl16x3Qdg/5pkSYlZ91a0sG1pHmCeUlV7Y8HUcDZcWhWd2cDEVYMryr+yHf2QtwOONwlYEua9tM+Timht4M/MStFQfCJnQe3hg7lO2oE0gm1bw29mIKO6cDcmUV0pFyGblbPQJ2F51MlLFkwf1s5N4CuBH+VeMGN+y/FeTVCZqLfu4atFV08FQFs3otQen8W5X8wMiRiaYY7VlWB4r6y4nc2zUV/2Mcc0c5ni9Nec=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199015)(6486002)(966005)(316002)(786003)(478600001)(30864003)(5660300002)(2906002)(6506007)(6916009)(36756003)(83380400001)(26005)(41300700001)(6512007)(86362001)(186003)(8936002)(66476007)(8676002)(66556008)(66946007)(38100700002)(4326008)(2616005)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sCX6E5dhcDurnK6nFzep/Trf3158kdou17AAwMP0v00pE0dBrz5lu/9gIFqI?=
 =?us-ascii?Q?Vhs03Nv7BWYJhAsNBsseDZnm/X6kv3LVPPGuBZ1c7LtKOe1poxyM+GbJrbjw?=
 =?us-ascii?Q?XUq/YnfhmeZR+ntx6tP1ewYqan/q1CVKDdU1Z8L9y6GRLD7LeJ3+lkSalpyy?=
 =?us-ascii?Q?q8Ks1h4GNcxjq1tonIAbpZ95cCjWppRi2eSgyBpJ+vyjcuvOXksjuFtSAIIm?=
 =?us-ascii?Q?ygLdQ7xvGdF9CoIVGWlcJFV37aKo7cIv1voPjsyN8DqyCFajX2fGZkrmmqQ0?=
 =?us-ascii?Q?j3WkVWsWWiN9X/FOpbnz9A9IeV1EbVDclI8KFDwbBDgIZKJex4F6ar2Vyys/?=
 =?us-ascii?Q?7KgQ0Gm+ZIDRsUEm2USMEOsUAf6TaGB+utqO5ts4hCjU1DwmzxxlZ0Ob0W7w?=
 =?us-ascii?Q?nN1UvUkWifmG/DbZNCkk4EjRXnwIw/5UYK5uTVIEHT8o4S+0+qgdlEr1jOW7?=
 =?us-ascii?Q?KKh712XNlL0bavsL9EjsH1SAGTgXBO7UoJVMEPc9grWMPltpFtcFTIJMltww?=
 =?us-ascii?Q?n+YZU8+CaksLxn+vzplDDxkQxF8uPATn+lctME5XtwZbvgdkf9MGdJXNw0vb?=
 =?us-ascii?Q?WEjoFbk49IrXN3aeXg9pbUnGcSDdgn4KCW9pNWu6/HZEd6iL3WuymTZC5qoJ?=
 =?us-ascii?Q?F+i5Y3jo1//GDvoMFp0bY0qXlVpPXlmoaS1SQYeGhpwPTfM988WkA7ou5Jvs?=
 =?us-ascii?Q?qlgNVX4LoS6hfN0GSUooiWtybO1VX6WEycJ+7tnIwOkE0sRpYqIcQ3cq/v05?=
 =?us-ascii?Q?OR5f8N9V0DwsuKlG2srLOVqkl37uXDoazEYPM3Qvl1fUWO1autGbyYYi+LyI?=
 =?us-ascii?Q?Zt5s6lHTvRUgRNlAzhHBcI+ye5TtSxn3gq5AW6qIQuF0ix7cfzFyY7dLnHac?=
 =?us-ascii?Q?E+ATYzEE9FkjMtlu0rJRv2dlMF03e0Enx0dxC4o4SCzGWP51RZhxzlzF7cYl?=
 =?us-ascii?Q?8jzc9X9N/gwZl6U0s2KUUUd0j0yTMxUNB9195wpPJvALVbo/IfwZTySQb/oD?=
 =?us-ascii?Q?7mQdH0KpBDLHFX8o+s8A9FdgFVRjoVKcqmppwH7IUVkcvlqMI3YDezC9MlLp?=
 =?us-ascii?Q?BwG9a6Up4tyGRcS86S833hZJmDk9Ov+tEPyPvIaPEl3/rIOuyfSk0C1t2tZ3?=
 =?us-ascii?Q?E8GBWtzt2FDY0IBe5bjVexvF3ChHehAH59tXhOt2BZqdyT+Cr3L+sF6IsxDv?=
 =?us-ascii?Q?ydmAoqzFk1dtUtJmu9qtSkyl5VofGT8GgSLF3ruObZ+WOYdYgaCDAduxVkbg?=
 =?us-ascii?Q?+bC5J01EqSZzR31eubQWyFDi7AeRcokQ5/a5kk2HdGWjaBTcGZjdQVaO6cV0?=
 =?us-ascii?Q?5T6bEPUzkMQKlKQOWfPEYGmrLwHiqfWfgA1IMTOC1qSSq0F98iwpUBL/4DR1?=
 =?us-ascii?Q?wKVSLSHoj7hobo0RTeZuKiWx2BMiK5i6JbJAl4HyJq+q5USGdWQ/VgJl7esm?=
 =?us-ascii?Q?9vB5ABvDqivXlfQV64PdFoshQa+Adig8xXdGAmh3hfUjIVxHTWlbGF199Po3?=
 =?us-ascii?Q?yv+3BAqkVngeJz6G8qfa5j8jo1l06CMItIw2buH8VqCUsigeTGgAzVimoN5C?=
 =?us-ascii?Q?lclgp8jme+5GWq2P4p082VKEnXC66DgvouvZ1Kfh?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: ece9caf6-f0e7-4baa-f7c1-08dad7689873
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 09:02:26.2685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNvhQrizEhGu+bXi9cKLwdARFG0ys1fDHtqKUCf1aA9muh5FCpOIesQt4bgp4ttbicabOCnZzYfqaCYkfgpAHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8414
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adds an explicit _ah parameter to most macros that previously had a
hidden dependency on ah. This makes the code more compliant with the
style guide.

This change does not appear to affect the final binary.

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
This change is related to QCN550x support, in response to comments at
https://patchwork.kernel.org/project/linux-wireless/patch/20220512195319.14635-3-wlooi@ucalgary.ca/

 drivers/net/wireless/ath/ath9k/ar5008_phy.c   |  10 +-
 drivers/net/wireless/ath/ath9k/ar9002_calib.c |  30 ++--
 drivers/net/wireless/ath/ath9k/ar9002_hw.c    |  10 +-
 drivers/net/wireless/ath/ath9k/ar9002_mac.c   |  14 +-
 drivers/net/wireless/ath/ath9k/ar9002_phy.c   |   4 +-
 drivers/net/wireless/ath/ath9k/ar9003_calib.c |  74 ++++-----
 .../net/wireless/ath/ath9k/ar9003_eeprom.c    |  64 ++++----
 .../net/wireless/ath/ath9k/ar9003_eeprom.h    |  12 +-
 drivers/net/wireless/ath/ath9k/ar9003_hw.c    |   4 +-
 drivers/net/wireless/ath/ath9k/ar9003_mac.c   |  12 +-
 drivers/net/wireless/ath/ath9k/ar9003_mci.c   |   6 +-
 drivers/net/wireless/ath/ath9k/ar9003_paprd.c |  56 +++----
 drivers/net/wireless/ath/ath9k/ar9003_phy.c   |  26 +--
 drivers/net/wireless/ath/ath9k/ar9003_phy.h   |  82 +++++-----
 drivers/net/wireless/ath/ath9k/ar9003_wow.c   |  18 +--
 drivers/net/wireless/ath/ath9k/btcoex.c       |  14 +-
 drivers/net/wireless/ath/ath9k/calib.c        |  34 ++--
 drivers/net/wireless/ath/ath9k/eeprom.h       |  12 +-
 drivers/net/wireless/ath/ath9k/eeprom_def.c   |  10 +-
 drivers/net/wireless/ath/ath9k/htc_drv_init.c |   4 +-
 drivers/net/wireless/ath/ath9k/hw.c           | 128 +++++++--------
 drivers/net/wireless/ath/ath9k/mac.c          |  42 ++---
 drivers/net/wireless/ath/ath9k/pci.c          |   4 +-
 drivers/net/wireless/ath/ath9k/reg.h          | 148 +++++++++---------
 drivers/net/wireless/ath/ath9k/rng.c          |   6 +-
 drivers/net/wireless/ath/ath9k/xmit.c         |   2 +-
 26 files changed, 413 insertions(+), 413 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar5008_phy.c b/drivers/net/wireless/ath/ath9k/ar5008_phy.c
index 6610d7613..7a45f5f62 100644
--- a/drivers/net/wireless/ath/ath9k/ar5008_phy.c
+++ b/drivers/net/wireless/ath/ath9k/ar5008_phy.c
@@ -1277,13 +1277,13 @@ static void ar5008_hw_set_radar_conf(struct ath_hw *ah)
 
 static void ar5008_hw_init_txpower_cck(struct ath_hw *ah, int16_t *rate_array)
 {
-#define CCK_DELTA(x) ((OLC_FOR_AR9280_20_LATER) ? max((x) - 2, 0) : (x))
-	ah->tx_power[0] = CCK_DELTA(rate_array[rate1l]);
-	ah->tx_power[1] = CCK_DELTA(min(rate_array[rate2l],
+#define CCK_DELTA(_ah, x) ((OLC_FOR_AR9280_20_LATER(_ah)) ? max((x) - 2, 0) : (x))
+	ah->tx_power[0] = CCK_DELTA(ah, rate_array[rate1l]);
+	ah->tx_power[1] = CCK_DELTA(ah, min(rate_array[rate2l],
 					rate_array[rate2s]));
-	ah->tx_power[2] = CCK_DELTA(min(rate_array[rate5_5l],
+	ah->tx_power[2] = CCK_DELTA(ah, min(rate_array[rate5_5l],
 					rate_array[rate5_5s]));
-	ah->tx_power[3] = CCK_DELTA(min(rate_array[rate11l],
+	ah->tx_power[3] = CCK_DELTA(ah, min(rate_array[rate11l],
 					rate_array[rate11s]));
 #undef CCK_DELTA
 }
diff --git a/drivers/net/wireless/ath/ath9k/ar9002_calib.c b/drivers/net/wireless/ath/ath9k/ar9002_calib.c
index fd53b5f9e..c8b3f3aaa 100644
--- a/drivers/net/wireless/ath/ath9k/ar9002_calib.c
+++ b/drivers/net/wireless/ath/ath9k/ar9002_calib.c
@@ -659,9 +659,9 @@ static void ar9002_hw_pa_cal(struct ath_hw *ah, bool is_reset)
 
 static void ar9002_hw_olc_temp_compensation(struct ath_hw *ah)
 {
-	if (OLC_FOR_AR9287_10_LATER)
+	if (OLC_FOR_AR9287_10_LATER(ah))
 		ar9287_hw_olc_temp_compensation(ah);
-	else if (OLC_FOR_AR9280_20_LATER)
+	else if (OLC_FOR_AR9280_20_LATER(ah))
 		ar9280_hw_olc_temp_compensation(ah);
 }
 
@@ -672,7 +672,7 @@ static int ar9002_hw_calibrate(struct ath_hw *ah, struct ath9k_channel *chan,
 	bool nfcal, nfcal_pending = false, percal_pending;
 	int ret;
 
-	nfcal = !!(REG_READ(ah, AR_PHY_AGC_CONTROL) & AR_PHY_AGC_CONTROL_NF);
+	nfcal = !!(REG_READ(ah, AR_PHY_AGC_CONTROL(ah)) & AR_PHY_AGC_CONTROL_NF);
 	if (ah->caldata) {
 		nfcal_pending = test_bit(NFCAL_PENDING, &ah->caldata->cal_flags);
 		if (longcal)		/* Remember to not miss */
@@ -752,11 +752,11 @@ static bool ar9285_hw_cl_cal(struct ath_hw *ah, struct ath9k_channel *chan)
 	if (IS_CHAN_HT20(chan)) {
 		REG_SET_BIT(ah, AR_PHY_CL_CAL_CTL, AR_PHY_PARALLEL_CAL_ENABLE);
 		REG_SET_BIT(ah, AR_PHY_TURBO, AR_PHY_FC_DYN2040_EN);
-		REG_CLR_BIT(ah, AR_PHY_AGC_CONTROL,
+		REG_CLR_BIT(ah, AR_PHY_AGC_CONTROL(ah),
 			    AR_PHY_AGC_CONTROL_FLTR_CAL);
 		REG_CLR_BIT(ah, AR_PHY_TPCRG1, AR_PHY_TPCRG1_PD_CAL_ENABLE);
-		REG_SET_BIT(ah, AR_PHY_AGC_CONTROL, AR_PHY_AGC_CONTROL_CAL);
-		if (!ath9k_hw_wait(ah, AR_PHY_AGC_CONTROL,
+		REG_SET_BIT(ah, AR_PHY_AGC_CONTROL(ah), AR_PHY_AGC_CONTROL_CAL);
+		if (!ath9k_hw_wait(ah, AR_PHY_AGC_CONTROL(ah),
 				  AR_PHY_AGC_CONTROL_CAL, 0, AH_WAIT_TIMEOUT)) {
 			ath_dbg(common, CALIBRATE,
 				"offset calibration failed to complete in %d ms; noisy environment?\n",
@@ -768,10 +768,10 @@ static bool ar9285_hw_cl_cal(struct ath_hw *ah, struct ath9k_channel *chan)
 		REG_CLR_BIT(ah, AR_PHY_CL_CAL_CTL, AR_PHY_CL_CAL_ENABLE);
 	}
 	REG_CLR_BIT(ah, AR_PHY_ADC_CTL, AR_PHY_ADC_CTL_OFF_PWDADC);
-	REG_SET_BIT(ah, AR_PHY_AGC_CONTROL, AR_PHY_AGC_CONTROL_FLTR_CAL);
+	REG_SET_BIT(ah, AR_PHY_AGC_CONTROL(ah), AR_PHY_AGC_CONTROL_FLTR_CAL);
 	REG_SET_BIT(ah, AR_PHY_TPCRG1, AR_PHY_TPCRG1_PD_CAL_ENABLE);
-	REG_SET_BIT(ah, AR_PHY_AGC_CONTROL, AR_PHY_AGC_CONTROL_CAL);
-	if (!ath9k_hw_wait(ah, AR_PHY_AGC_CONTROL, AR_PHY_AGC_CONTROL_CAL,
+	REG_SET_BIT(ah, AR_PHY_AGC_CONTROL(ah), AR_PHY_AGC_CONTROL_CAL);
+	if (!ath9k_hw_wait(ah, AR_PHY_AGC_CONTROL(ah), AR_PHY_AGC_CONTROL_CAL,
 			  0, AH_WAIT_TIMEOUT)) {
 		ath_dbg(common, CALIBRATE,
 			"offset calibration failed to complete in %d ms; noisy environment?\n",
@@ -781,7 +781,7 @@ static bool ar9285_hw_cl_cal(struct ath_hw *ah, struct ath9k_channel *chan)
 
 	REG_SET_BIT(ah, AR_PHY_ADC_CTL, AR_PHY_ADC_CTL_OFF_PWDADC);
 	REG_CLR_BIT(ah, AR_PHY_CL_CAL_CTL, AR_PHY_CL_CAL_ENABLE);
-	REG_CLR_BIT(ah, AR_PHY_AGC_CONTROL, AR_PHY_AGC_CONTROL_FLTR_CAL);
+	REG_CLR_BIT(ah, AR_PHY_AGC_CONTROL(ah), AR_PHY_AGC_CONTROL_FLTR_CAL);
 
 	return true;
 }
@@ -857,17 +857,17 @@ static bool ar9002_hw_init_cal(struct ath_hw *ah, struct ath9k_channel *chan)
 			if (!AR_SREV_9287_11_OR_LATER(ah))
 				REG_CLR_BIT(ah, AR_PHY_ADC_CTL,
 					    AR_PHY_ADC_CTL_OFF_PWDADC);
-			REG_SET_BIT(ah, AR_PHY_AGC_CONTROL,
+			REG_SET_BIT(ah, AR_PHY_AGC_CONTROL(ah),
 				    AR_PHY_AGC_CONTROL_FLTR_CAL);
 		}
 
 		/* Calibrate the AGC */
-		REG_WRITE(ah, AR_PHY_AGC_CONTROL,
-			  REG_READ(ah, AR_PHY_AGC_CONTROL) |
+		REG_WRITE(ah, AR_PHY_AGC_CONTROL(ah),
+			  REG_READ(ah, AR_PHY_AGC_CONTROL(ah)) |
 			  AR_PHY_AGC_CONTROL_CAL);
 
 		/* Poll for offset calibration complete */
-		if (!ath9k_hw_wait(ah, AR_PHY_AGC_CONTROL,
+		if (!ath9k_hw_wait(ah, AR_PHY_AGC_CONTROL(ah),
 				   AR_PHY_AGC_CONTROL_CAL,
 				   0, AH_WAIT_TIMEOUT)) {
 			ath_dbg(common, CALIBRATE,
@@ -880,7 +880,7 @@ static bool ar9002_hw_init_cal(struct ath_hw *ah, struct ath9k_channel *chan)
 			if (!AR_SREV_9287_11_OR_LATER(ah))
 				REG_SET_BIT(ah, AR_PHY_ADC_CTL,
 					    AR_PHY_ADC_CTL_OFF_PWDADC);
-			REG_CLR_BIT(ah, AR_PHY_AGC_CONTROL,
+			REG_CLR_BIT(ah, AR_PHY_AGC_CONTROL(ah),
 				    AR_PHY_AGC_CONTROL_FLTR_CAL);
 		}
 	}
diff --git a/drivers/net/wireless/ath/ath9k/ar9002_hw.c b/drivers/net/wireless/ath/ath9k/ar9002_hw.c
index ae68f6748..d08ea0b28 100644
--- a/drivers/net/wireless/ath/ath9k/ar9002_hw.c
+++ b/drivers/net/wireless/ath/ath9k/ar9002_hw.c
@@ -249,9 +249,9 @@ static void ar9002_hw_configpcipowersave(struct ath_hw *ah,
 
 	if (power_off) {
 		/* clear bit 19 to disable L1 */
-		REG_CLR_BIT(ah, AR_PCIE_PM_CTRL, AR_PCIE_PM_CTRL_ENA);
+		REG_CLR_BIT(ah, AR_PCIE_PM_CTRL(ah), AR_PCIE_PM_CTRL_ENA);
 
-		val = REG_READ(ah, AR_WA);
+		val = REG_READ(ah, AR_WA(ah));
 
 		/*
 		 * Set PCIe workaround bits
@@ -286,7 +286,7 @@ static void ar9002_hw_configpcipowersave(struct ath_hw *ah,
 		if (AR_SREV_9285E_20(ah))
 			val |= AR_WA_BIT23;
 
-		REG_WRITE(ah, AR_WA, val);
+		REG_WRITE(ah, AR_WA(ah), val);
 	} else {
 		if (ah->config.pcie_waen) {
 			val = ah->config.pcie_waen;
@@ -314,10 +314,10 @@ static void ar9002_hw_configpcipowersave(struct ath_hw *ah,
 		if (AR_SREV_9285E_20(ah))
 			val |= AR_WA_BIT23;
 
-		REG_WRITE(ah, AR_WA, val);
+		REG_WRITE(ah, AR_WA(ah), val);
 
 		/* set bit 19 to allow forcing of pcie core into L1 state */
-		REG_SET_BIT(ah, AR_PCIE_PM_CTRL, AR_PCIE_PM_CTRL_ENA);
+		REG_SET_BIT(ah, AR_PCIE_PM_CTRL(ah), AR_PCIE_PM_CTRL_ENA);
 	}
 }
 
diff --git a/drivers/net/wireless/ath/ath9k/ar9002_mac.c b/drivers/net/wireless/ath/ath9k/ar9002_mac.c
index a8c0e8e2d..b70cd4af1 100644
--- a/drivers/net/wireless/ath/ath9k/ar9002_mac.c
+++ b/drivers/net/wireless/ath/ath9k/ar9002_mac.c
@@ -21,7 +21,7 @@
 
 static void ar9002_hw_rx_enable(struct ath_hw *ah)
 {
-	REG_WRITE(ah, AR_CR, AR_CR_RXE);
+	REG_WRITE(ah, AR_CR, AR_CR_RXE(ah));
 }
 
 static void ar9002_hw_set_desc_link(void *ds, u32 ds_link)
@@ -40,14 +40,14 @@ static bool ar9002_hw_get_isr(struct ath_hw *ah, enum ath9k_int *masked,
 	struct ath_common *common = ath9k_hw_common(ah);
 
 	if (!AR_SREV_9100(ah)) {
-		if (REG_READ(ah, AR_INTR_ASYNC_CAUSE) & AR_INTR_MAC_IRQ) {
-			if ((REG_READ(ah, AR_RTC_STATUS) & AR_RTC_STATUS_M)
+		if (REG_READ(ah, AR_INTR_ASYNC_CAUSE(ah)) & AR_INTR_MAC_IRQ) {
+			if ((REG_READ(ah, AR_RTC_STATUS(ah)) & AR_RTC_STATUS_M(ah))
 			    == AR_RTC_STATUS_ON) {
 				isr = REG_READ(ah, AR_ISR);
 			}
 		}
 
-		sync_cause = REG_READ(ah, AR_INTR_SYNC_CAUSE) &
+		sync_cause = REG_READ(ah, AR_INTR_SYNC_CAUSE(ah)) &
 			AR_INTR_SYNC_DEFAULT;
 
 		*masked = 0;
@@ -138,7 +138,7 @@ static bool ar9002_hw_get_isr(struct ath_hw *ah, enum ath9k_int *masked,
 		u32 s5_s;
 
 		if (pCap->hw_caps & ATH9K_HW_CAP_RAC_SUPPORTED) {
-			s5_s = REG_READ(ah, AR_ISR_S5_S);
+			s5_s = REG_READ(ah, AR_ISR_S5_S(ah));
 		} else {
 			s5_s = REG_READ(ah, AR_ISR_S5);
 		}
@@ -201,8 +201,8 @@ static bool ar9002_hw_get_isr(struct ath_hw *ah, enum ath9k_int *masked,
 				"AR_INTR_SYNC_LOCAL_TIMEOUT\n");
 		}
 
-		REG_WRITE(ah, AR_INTR_SYNC_CAUSE_CLR, sync_cause);
-		(void) REG_READ(ah, AR_INTR_SYNC_CAUSE_CLR);
+		REG_WRITE(ah, AR_INTR_SYNC_CAUSE_CLR(ah), sync_cause);
+		(void) REG_READ(ah, AR_INTR_SYNC_CAUSE_CLR(ah));
 	}
 
 	return true;
diff --git a/drivers/net/wireless/ath/ath9k/ar9002_phy.c b/drivers/net/wireless/ath/ath9k/ar9002_phy.c
index ebdb97999..23ac6b7c2 100644
--- a/drivers/net/wireless/ath/ath9k/ar9002_phy.c
+++ b/drivers/net/wireless/ath/ath9k/ar9002_phy.c
@@ -281,10 +281,10 @@ static void ar9002_olc_init(struct ath_hw *ah)
 {
 	u32 i;
 
-	if (!OLC_FOR_AR9280_20_LATER)
+	if (!OLC_FOR_AR9280_20_LATER(ah))
 		return;
 
-	if (OLC_FOR_AR9287_10_LATER) {
+	if (OLC_FOR_AR9287_10_LATER(ah)) {
 		REG_SET_BIT(ah, AR_PHY_TX_PWRCTRL9,
 				AR_PHY_TX_PWRCTRL9_RES_DC_REMOVAL);
 		ath9k_hw_analog_shift_rmw(ah, AR9287_AN_TXPC0,
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_calib.c b/drivers/net/wireless/ath/ath9k/ar9003_calib.c
index 6ca089f15..2224cb74b 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_calib.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_calib.c
@@ -346,14 +346,14 @@ static bool ar9003_hw_dynamic_osdac_selection(struct ath_hw *ah,
 	/*
 	 * Clear offset and IQ calibration, run AGC cal.
 	 */
-	REG_CLR_BIT(ah, AR_PHY_AGC_CONTROL,
+	REG_CLR_BIT(ah, AR_PHY_AGC_CONTROL(ah),
 		    AR_PHY_AGC_CONTROL_OFFSET_CAL);
-	REG_CLR_BIT(ah, AR_PHY_TX_IQCAL_CONTROL_0,
+	REG_CLR_BIT(ah, AR_PHY_TX_IQCAL_CONTROL_0(ah),
 		    AR_PHY_TX_IQCAL_CONTROL_0_ENABLE_TXIQ_CAL);
-	REG_WRITE(ah, AR_PHY_AGC_CONTROL,
-		  REG_READ(ah, AR_PHY_AGC_CONTROL) | AR_PHY_AGC_CONTROL_CAL);
+	REG_WRITE(ah, AR_PHY_AGC_CONTROL(ah),
+		  REG_READ(ah, AR_PHY_AGC_CONTROL(ah)) | AR_PHY_AGC_CONTROL_CAL);
 
-	status = ath9k_hw_wait(ah, AR_PHY_AGC_CONTROL,
+	status = ath9k_hw_wait(ah, AR_PHY_AGC_CONTROL(ah),
 			       AR_PHY_AGC_CONTROL_CAL,
 			       0, AH_WAIT_TIMEOUT);
 	if (!status) {
@@ -367,13 +367,13 @@ static bool ar9003_hw_dynamic_osdac_selection(struct ath_hw *ah,
 	 * (Carrier Leak calibration, TX Filter calibration and
 	 *  Peak Detector offset calibration).
 	 */
-	REG_SET_BIT(ah, AR_PHY_AGC_CONTROL,
+	REG_SET_BIT(ah, AR_PHY_AGC_CONTROL(ah),
 		    AR_PHY_AGC_CONTROL_OFFSET_CAL);
 	REG_CLR_BIT(ah, AR_PHY_CL_CAL_CTL,
 		    AR_PHY_CL_CAL_ENABLE);
-	REG_CLR_BIT(ah, AR_PHY_AGC_CONTROL,
+	REG_CLR_BIT(ah, AR_PHY_AGC_CONTROL(ah),
 		    AR_PHY_AGC_CONTROL_FLTR_CAL);
-	REG_CLR_BIT(ah, AR_PHY_AGC_CONTROL,
+	REG_CLR_BIT(ah, AR_PHY_AGC_CONTROL(ah),
 		    AR_PHY_AGC_CONTROL_PKDET_CAL);
 
 	ch0_done = 0;
@@ -387,10 +387,10 @@ static bool ar9003_hw_dynamic_osdac_selection(struct ath_hw *ah,
 
 		REG_SET_BIT(ah, AR_PHY_ACTIVE, AR_PHY_ACTIVE_EN);
 
-		REG_WRITE(ah, AR_PHY_AGC_CONTROL,
-			  REG_READ(ah, AR_PHY_AGC_CONTROL) | AR_PHY_AGC_CONTROL_CAL);
+		REG_WRITE(ah, AR_PHY_AGC_CONTROL(ah),
+			  REG_READ(ah, AR_PHY_AGC_CONTROL(ah)) | AR_PHY_AGC_CONTROL_CAL);
 
-		status = ath9k_hw_wait(ah, AR_PHY_AGC_CONTROL,
+		status = ath9k_hw_wait(ah, AR_PHY_AGC_CONTROL(ah),
 				       AR_PHY_AGC_CONTROL_CAL,
 				       0, AH_WAIT_TIMEOUT);
 		if (!status) {
@@ -531,7 +531,7 @@ static bool ar9003_hw_dynamic_osdac_selection(struct ath_hw *ah,
 		}
 	}
 
-	REG_CLR_BIT(ah, AR_PHY_AGC_CONTROL,
+	REG_CLR_BIT(ah, AR_PHY_AGC_CONTROL(ah),
 		    AR_PHY_AGC_CONTROL_OFFSET_CAL);
 	REG_SET_BIT(ah, AR_PHY_ACTIVE, AR_PHY_ACTIVE_EN);
 
@@ -539,7 +539,7 @@ static bool ar9003_hw_dynamic_osdac_selection(struct ath_hw *ah,
 	 * We don't need to check txiqcal_done here since it is always
 	 * set for AR9550.
 	 */
-	REG_SET_BIT(ah, AR_PHY_TX_IQCAL_CONTROL_0,
+	REG_SET_BIT(ah, AR_PHY_TX_IQCAL_CONTROL_0(ah),
 		    AR_PHY_TX_IQCAL_CONTROL_0_ENABLE_TXIQ_CAL);
 
 	return true;
@@ -897,7 +897,7 @@ static void ar9003_hw_tx_iq_cal_outlier_detection(struct ath_hw *ah,
 	memset(tx_corr_coeff, 0, sizeof(tx_corr_coeff));
 	for (i = 0; i < MAX_MEASUREMENT / 2; i++) {
 		tx_corr_coeff[i * 2][0] = tx_corr_coeff[(i * 2) + 1][0] =
-					AR_PHY_TX_IQCAL_CORR_COEFF_B0(i);
+					AR_PHY_TX_IQCAL_CORR_COEFF_B0(ah, i);
 		if (!AR_SREV_9485(ah)) {
 			tx_corr_coeff[i * 2][1] =
 			tx_corr_coeff[(i * 2) + 1][1] =
@@ -914,7 +914,7 @@ static void ar9003_hw_tx_iq_cal_outlier_detection(struct ath_hw *ah,
 		if (!(ah->txchainmask & (1 << i)))
 			continue;
 		nmeasurement = REG_READ_FIELD(ah,
-				AR_PHY_TX_IQCAL_STATUS_B0,
+				AR_PHY_TX_IQCAL_STATUS_B0(ah),
 				AR_PHY_CALIBRATED_GAINS_0);
 
 		if (nmeasurement > MAX_MEASUREMENT)
@@ -988,10 +988,10 @@ static bool ar9003_hw_tx_iq_cal_run(struct ath_hw *ah)
 		REG_RMW_FIELD(ah, AR_PHY_TX_FORCED_GAIN,
 			      AR_PHY_TXGAIN_FORCE, 0);
 
-	REG_RMW_FIELD(ah, AR_PHY_TX_IQCAL_START,
+	REG_RMW_FIELD(ah, AR_PHY_TX_IQCAL_START(ah),
 		      AR_PHY_TX_IQCAL_START_DO_CAL, 1);
 
-	if (!ath9k_hw_wait(ah, AR_PHY_TX_IQCAL_START,
+	if (!ath9k_hw_wait(ah, AR_PHY_TX_IQCAL_START(ah),
 			AR_PHY_TX_IQCAL_START_DO_CAL, 0,
 			AH_WAIT_TIMEOUT)) {
 		ath_dbg(common, CALIBRATE, "Tx IQ Cal is not completed\n");
@@ -1056,7 +1056,7 @@ static void ar9003_hw_tx_iq_cal_post_proc(struct ath_hw *ah,
 {
 	struct ath_common *common = ath9k_hw_common(ah);
 	const u32 txiqcal_status[AR9300_MAX_CHAINS] = {
-		AR_PHY_TX_IQCAL_STATUS_B0,
+		AR_PHY_TX_IQCAL_STATUS_B0(ah),
 		AR_PHY_TX_IQCAL_STATUS_B1,
 		AR_PHY_TX_IQCAL_STATUS_B2,
 	};
@@ -1076,7 +1076,7 @@ static void ar9003_hw_tx_iq_cal_post_proc(struct ath_hw *ah,
 			continue;
 
 		nmeasurement = REG_READ_FIELD(ah,
-				AR_PHY_TX_IQCAL_STATUS_B0,
+				AR_PHY_TX_IQCAL_STATUS_B0(ah),
 				AR_PHY_CALIBRATED_GAINS_0);
 		if (nmeasurement > MAX_MEASUREMENT)
 			nmeasurement = MAX_MEASUREMENT;
@@ -1096,7 +1096,7 @@ static void ar9003_hw_tx_iq_cal_post_proc(struct ath_hw *ah,
 				u32 idx = 2 * j, offset = 4 * (3 * im + j);
 
 				REG_RMW_FIELD(ah,
-						AR_PHY_CHAN_INFO_MEMORY,
+						AR_PHY_CHAN_INFO_MEMORY(ah),
 						AR_PHY_CHAN_INFO_TAB_S2_READ,
 						0);
 
@@ -1106,7 +1106,7 @@ static void ar9003_hw_tx_iq_cal_post_proc(struct ath_hw *ah,
 						offset);
 
 				REG_RMW_FIELD(ah,
-						AR_PHY_CHAN_INFO_MEMORY,
+						AR_PHY_CHAN_INFO_MEMORY(ah),
 						AR_PHY_CHAN_INFO_TAB_S2_READ,
 						1);
 
@@ -1161,7 +1161,7 @@ static void ar9003_hw_tx_iq_cal_reload(struct ath_hw *ah)
 	memset(tx_corr_coeff, 0, sizeof(tx_corr_coeff));
 	for (i = 0; i < MAX_MEASUREMENT / 2; i++) {
 		tx_corr_coeff[i * 2][0] = tx_corr_coeff[(i * 2) + 1][0] =
-					AR_PHY_TX_IQCAL_CORR_COEFF_B0(i);
+					AR_PHY_TX_IQCAL_CORR_COEFF_B0(ah, i);
 		if (!AR_SREV_9485(ah)) {
 			tx_corr_coeff[i * 2][1] =
 			tx_corr_coeff[(i * 2) + 1][1] =
@@ -1346,7 +1346,7 @@ static void ar9003_hw_cl_cal_post_proc(struct ath_hw *ah, bool is_reusable)
 	if (!caldata || !(ah->enabled_cals & TX_CL_CAL))
 		return;
 
-	txclcal_done = !!(REG_READ(ah, AR_PHY_AGC_CONTROL) &
+	txclcal_done = !!(REG_READ(ah, AR_PHY_AGC_CONTROL(ah)) &
 			  AR_PHY_AGC_CONTROL_CLC_SUCCESS);
 
 	if (test_bit(TXCLCAL_DONE, &caldata->cal_flags)) {
@@ -1424,12 +1424,12 @@ static bool ar9003_hw_init_cal_pcoem(struct ath_hw *ah,
 
 	if (rtt) {
 		if (!run_rtt_cal) {
-			agc_ctrl = REG_READ(ah, AR_PHY_AGC_CONTROL);
+			agc_ctrl = REG_READ(ah, AR_PHY_AGC_CONTROL(ah));
 			agc_supp_cals &= agc_ctrl;
 			agc_ctrl &= ~(AR_PHY_AGC_CONTROL_OFFSET_CAL |
 				      AR_PHY_AGC_CONTROL_FLTR_CAL |
 				      AR_PHY_AGC_CONTROL_PKDET_CAL);
-			REG_WRITE(ah, AR_PHY_AGC_CONTROL, agc_ctrl);
+			REG_WRITE(ah, AR_PHY_AGC_CONTROL(ah), agc_ctrl);
 		} else {
 			if (ah->ah_flags & AH_FASTCC)
 				run_agc_cal = true;
@@ -1452,7 +1452,7 @@ static bool ar9003_hw_init_cal_pcoem(struct ath_hw *ah,
 		goto skip_tx_iqcal;
 
 	/* Do Tx IQ Calibration */
-	REG_RMW_FIELD(ah, AR_PHY_TX_IQCAL_CONTROL_1,
+	REG_RMW_FIELD(ah, AR_PHY_TX_IQCAL_CONTROL_1(ah),
 		      AR_PHY_TX_IQCAL_CONTROL_1_IQCORR_I_Q_COFF_DELPT,
 		      DELPT);
 
@@ -1462,10 +1462,10 @@ static bool ar9003_hw_init_cal_pcoem(struct ath_hw *ah,
 	 */
 	if (ah->enabled_cals & TX_IQ_ON_AGC_CAL) {
 		if (caldata && !test_bit(TXIQCAL_DONE, &caldata->cal_flags))
-			REG_SET_BIT(ah, AR_PHY_TX_IQCAL_CONTROL_0,
+			REG_SET_BIT(ah, AR_PHY_TX_IQCAL_CONTROL_0(ah),
 				    AR_PHY_TX_IQCAL_CONTROL_0_ENABLE_TXIQ_CAL);
 		else
-			REG_CLR_BIT(ah, AR_PHY_TX_IQCAL_CONTROL_0,
+			REG_CLR_BIT(ah, AR_PHY_TX_IQCAL_CONTROL_0(ah),
 				    AR_PHY_TX_IQCAL_CONTROL_0_ENABLE_TXIQ_CAL);
 		txiqcal_done = run_agc_cal = true;
 	}
@@ -1485,12 +1485,12 @@ static bool ar9003_hw_init_cal_pcoem(struct ath_hw *ah,
 
 	if (run_agc_cal || !(ah->ah_flags & AH_FASTCC)) {
 		/* Calibrate the AGC */
-		REG_WRITE(ah, AR_PHY_AGC_CONTROL,
-			  REG_READ(ah, AR_PHY_AGC_CONTROL) |
+		REG_WRITE(ah, AR_PHY_AGC_CONTROL(ah),
+			  REG_READ(ah, AR_PHY_AGC_CONTROL(ah)) |
 			  AR_PHY_AGC_CONTROL_CAL);
 
 		/* Poll for offset calibration complete */
-		status = ath9k_hw_wait(ah, AR_PHY_AGC_CONTROL,
+		status = ath9k_hw_wait(ah, AR_PHY_AGC_CONTROL(ah),
 				       AR_PHY_AGC_CONTROL_CAL,
 				       0, AH_WAIT_TIMEOUT);
 
@@ -1507,7 +1507,7 @@ static bool ar9003_hw_init_cal_pcoem(struct ath_hw *ah,
 
 	if (rtt && !run_rtt_cal) {
 		agc_ctrl |= agc_supp_cals;
-		REG_WRITE(ah, AR_PHY_AGC_CONTROL, agc_ctrl);
+		REG_WRITE(ah, AR_PHY_AGC_CONTROL(ah), agc_ctrl);
 	}
 
 	if (!status) {
@@ -1558,11 +1558,11 @@ static bool do_ar9003_agc_cal(struct ath_hw *ah)
 	struct ath_common *common = ath9k_hw_common(ah);
 	bool status;
 
-	REG_WRITE(ah, AR_PHY_AGC_CONTROL,
-		  REG_READ(ah, AR_PHY_AGC_CONTROL) |
+	REG_WRITE(ah, AR_PHY_AGC_CONTROL(ah),
+		  REG_READ(ah, AR_PHY_AGC_CONTROL(ah)) |
 		  AR_PHY_AGC_CONTROL_CAL);
 
-	status = ath9k_hw_wait(ah, AR_PHY_AGC_CONTROL,
+	status = ath9k_hw_wait(ah, AR_PHY_AGC_CONTROL(ah),
 			       AR_PHY_AGC_CONTROL_CAL,
 			       0, AH_WAIT_TIMEOUT);
 	if (!status) {
@@ -1596,7 +1596,7 @@ static bool ar9003_hw_init_cal_soc(struct ath_hw *ah,
 		goto skip_tx_iqcal;
 
 	/* Do Tx IQ Calibration */
-	REG_RMW_FIELD(ah, AR_PHY_TX_IQCAL_CONTROL_1,
+	REG_RMW_FIELD(ah, AR_PHY_TX_IQCAL_CONTROL_1(ah),
 		      AR_PHY_TX_IQCAL_CONTROL_1_IQCORR_I_Q_COFF_DELPT,
 		      DELPT);
 
@@ -1605,7 +1605,7 @@ static bool ar9003_hw_init_cal_soc(struct ath_hw *ah,
 	 * AGC calibration. Specifically, AR9550 in SoC chips.
 	 */
 	if (ah->enabled_cals & TX_IQ_ON_AGC_CAL) {
-		if (REG_READ_FIELD(ah, AR_PHY_TX_IQCAL_CONTROL_0,
+		if (REG_READ_FIELD(ah, AR_PHY_TX_IQCAL_CONTROL_0(ah),
 				   AR_PHY_TX_IQCAL_CONTROL_0_ENABLE_TXIQ_CAL)) {
 				txiqcal_done = true;
 		} else {
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
index 16bfcd0a1..944f46cdf 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
@@ -3084,13 +3084,13 @@ static bool ar9300_read_eeprom(struct ath_hw *ah, int address, u8 *buffer,
 
 static bool ar9300_otp_read_word(struct ath_hw *ah, int addr, u32 *data)
 {
-	REG_READ(ah, AR9300_OTP_BASE + (4 * addr));
+	REG_READ(ah, AR9300_OTP_BASE(ah) + (4 * addr));
 
-	if (!ath9k_hw_wait(ah, AR9300_OTP_STATUS, AR9300_OTP_STATUS_TYPE,
+	if (!ath9k_hw_wait(ah, AR9300_OTP_STATUS(ah), AR9300_OTP_STATUS_TYPE,
 			   AR9300_OTP_STATUS_VALID, 1000))
 		return false;
 
-	*data = REG_READ(ah, AR9300_OTP_READ_DATA);
+	*data = REG_READ(ah, AR9300_OTP_READ_DATA(ah));
 	return true;
 }
 
@@ -3607,15 +3607,15 @@ static void ar9003_hw_xpa_bias_level_apply(struct ath_hw *ah, bool is2ghz)
 
 	if (AR_SREV_9485(ah) || AR_SREV_9330(ah) || AR_SREV_9340(ah) ||
 	    AR_SREV_9531(ah) || AR_SREV_9561(ah))
-		REG_RMW_FIELD(ah, AR_CH0_TOP2, AR_CH0_TOP2_XPABIASLVL, bias);
+		REG_RMW_FIELD(ah, AR_CH0_TOP2(ah), AR_CH0_TOP2_XPABIASLVL, bias);
 	else if (AR_SREV_9462(ah) || AR_SREV_9550(ah) || AR_SREV_9565(ah))
-		REG_RMW_FIELD(ah, AR_CH0_TOP, AR_CH0_TOP_XPABIASLVL, bias);
+		REG_RMW_FIELD(ah, AR_CH0_TOP(ah), AR_CH0_TOP_XPABIASLVL, bias);
 	else {
-		REG_RMW_FIELD(ah, AR_CH0_TOP, AR_CH0_TOP_XPABIASLVL, bias);
-		REG_RMW_FIELD(ah, AR_CH0_THERM,
+		REG_RMW_FIELD(ah, AR_CH0_TOP(ah), AR_CH0_TOP_XPABIASLVL, bias);
+		REG_RMW_FIELD(ah, AR_CH0_THERM(ah),
 				AR_CH0_THERM_XPABIASLVL_MSB,
 				bias >> 2);
-		REG_RMW_FIELD(ah, AR_CH0_THERM,
+		REG_RMW_FIELD(ah, AR_CH0_THERM(ah),
 				AR_CH0_THERM_XPASHORT2GND, 1);
 	}
 }
@@ -3960,9 +3960,9 @@ void ar9003_hw_internal_regulator_apply(struct ath_hw *ah)
 		if (AR_SREV_9330(ah) || AR_SREV_9485(ah)) {
 			int reg_pmu_set;
 
-			reg_pmu_set = REG_READ(ah, AR_PHY_PMU2) & ~AR_PHY_PMU2_PGM;
-			REG_WRITE(ah, AR_PHY_PMU2, reg_pmu_set);
-			if (!is_pmu_set(ah, AR_PHY_PMU2, reg_pmu_set))
+			reg_pmu_set = REG_READ(ah, AR_PHY_PMU2(ah)) & ~AR_PHY_PMU2_PGM;
+			REG_WRITE(ah, AR_PHY_PMU2(ah), reg_pmu_set);
+			if (!is_pmu_set(ah, AR_PHY_PMU2(ah), reg_pmu_set))
 				return;
 
 			if (AR_SREV_9330(ah)) {
@@ -3984,28 +3984,28 @@ void ar9003_hw_internal_regulator_apply(struct ath_hw *ah)
 					      (3 << 24) | (1 << 28);
 			}
 
-			REG_WRITE(ah, AR_PHY_PMU1, reg_pmu_set);
-			if (!is_pmu_set(ah, AR_PHY_PMU1, reg_pmu_set))
+			REG_WRITE(ah, AR_PHY_PMU1(ah), reg_pmu_set);
+			if (!is_pmu_set(ah, AR_PHY_PMU1(ah), reg_pmu_set))
 				return;
 
-			reg_pmu_set = (REG_READ(ah, AR_PHY_PMU2) & ~0xFFC00000)
+			reg_pmu_set = (REG_READ(ah, AR_PHY_PMU2(ah)) & ~0xFFC00000)
 					| (4 << 26);
-			REG_WRITE(ah, AR_PHY_PMU2, reg_pmu_set);
-			if (!is_pmu_set(ah, AR_PHY_PMU2, reg_pmu_set))
+			REG_WRITE(ah, AR_PHY_PMU2(ah), reg_pmu_set);
+			if (!is_pmu_set(ah, AR_PHY_PMU2(ah), reg_pmu_set))
 				return;
 
-			reg_pmu_set = (REG_READ(ah, AR_PHY_PMU2) & ~0x00200000)
+			reg_pmu_set = (REG_READ(ah, AR_PHY_PMU2(ah)) & ~0x00200000)
 					| (1 << 21);
-			REG_WRITE(ah, AR_PHY_PMU2, reg_pmu_set);
-			if (!is_pmu_set(ah, AR_PHY_PMU2, reg_pmu_set))
+			REG_WRITE(ah, AR_PHY_PMU2(ah), reg_pmu_set);
+			if (!is_pmu_set(ah, AR_PHY_PMU2(ah), reg_pmu_set))
 				return;
 		} else if (AR_SREV_9462(ah) || AR_SREV_9565(ah) ||
 			   AR_SREV_9561(ah)) {
 			reg_val = le32_to_cpu(pBase->swreg);
-			REG_WRITE(ah, AR_PHY_PMU1, reg_val);
+			REG_WRITE(ah, AR_PHY_PMU1(ah), reg_val);
 
 			if (AR_SREV_9561(ah))
-				REG_WRITE(ah, AR_PHY_PMU2, 0x10200000);
+				REG_WRITE(ah, AR_PHY_PMU2(ah), 0x10200000);
 		} else {
 			/* Internal regulator is ON. Write swreg register. */
 			reg_val = le32_to_cpu(pBase->swreg);
@@ -4021,25 +4021,25 @@ void ar9003_hw_internal_regulator_apply(struct ath_hw *ah)
 		}
 	} else {
 		if (AR_SREV_9330(ah) || AR_SREV_9485(ah)) {
-			REG_RMW_FIELD(ah, AR_PHY_PMU2, AR_PHY_PMU2_PGM, 0);
-			while (REG_READ_FIELD(ah, AR_PHY_PMU2,
+			REG_RMW_FIELD(ah, AR_PHY_PMU2(ah), AR_PHY_PMU2_PGM, 0);
+			while (REG_READ_FIELD(ah, AR_PHY_PMU2(ah),
 						AR_PHY_PMU2_PGM))
 				udelay(10);
 
-			REG_RMW_FIELD(ah, AR_PHY_PMU1, AR_PHY_PMU1_PWD, 0x1);
-			while (!REG_READ_FIELD(ah, AR_PHY_PMU1,
+			REG_RMW_FIELD(ah, AR_PHY_PMU1(ah), AR_PHY_PMU1_PWD, 0x1);
+			while (!REG_READ_FIELD(ah, AR_PHY_PMU1(ah),
 						AR_PHY_PMU1_PWD))
 				udelay(10);
-			REG_RMW_FIELD(ah, AR_PHY_PMU2, AR_PHY_PMU2_PGM, 0x1);
-			while (!REG_READ_FIELD(ah, AR_PHY_PMU2,
+			REG_RMW_FIELD(ah, AR_PHY_PMU2(ah), AR_PHY_PMU2_PGM, 0x1);
+			while (!REG_READ_FIELD(ah, AR_PHY_PMU2(ah),
 						AR_PHY_PMU2_PGM))
 				udelay(10);
 		} else if (AR_SREV_9462(ah) || AR_SREV_9565(ah))
-			REG_RMW_FIELD(ah, AR_PHY_PMU1, AR_PHY_PMU1_PWD, 0x1);
+			REG_RMW_FIELD(ah, AR_PHY_PMU1(ah), AR_PHY_PMU1_PWD, 0x1);
 		else {
-			reg_val = REG_READ(ah, AR_RTC_SLEEP_CLK) |
+			reg_val = REG_READ(ah, AR_RTC_SLEEP_CLK(ah)) |
 				AR_RTC_FORCE_SWREG_PRD;
-			REG_WRITE(ah, AR_RTC_SLEEP_CLK, reg_val);
+			REG_WRITE(ah, AR_RTC_SLEEP_CLK(ah), reg_val);
 		}
 	}
 
@@ -4055,9 +4055,9 @@ static void ar9003_hw_apply_tuning_caps(struct ath_hw *ah)
 
 	if (eep->baseEepHeader.featureEnable & 0x40) {
 		tuning_caps_param &= 0x7f;
-		REG_RMW_FIELD(ah, AR_CH0_XTAL, AR_CH0_XTAL_CAPINDAC,
+		REG_RMW_FIELD(ah, AR_CH0_XTAL(ah), AR_CH0_XTAL_CAPINDAC,
 			      tuning_caps_param);
-		REG_RMW_FIELD(ah, AR_CH0_XTAL, AR_CH0_XTAL_CAPOUTDAC,
+		REG_RMW_FIELD(ah, AR_CH0_XTAL(ah), AR_CH0_XTAL_CAPOUTDAC,
 			      tuning_caps_param);
 	}
 }
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.h b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.h
index f8ae20318..b91ef1250 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.h
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.h
@@ -82,16 +82,16 @@
 /* AR5416_EEPMISC_BIG_ENDIAN not set indicates little endian */
 #define AR9300_EEPMISC_LITTLE_ENDIAN 0
 
-#define AR9300_OTP_BASE \
-		((AR_SREV_9340(ah) || AR_SREV_9550(ah)) ? 0x30000 : 0x14000)
-#define AR9300_OTP_STATUS \
-		((AR_SREV_9340(ah) || AR_SREV_9550(ah)) ? 0x31018 : 0x15f18)
+#define AR9300_OTP_BASE(_ah) \
+		((AR_SREV_9340(_ah) || AR_SREV_9550(_ah)) ? 0x30000 : 0x14000)
+#define AR9300_OTP_STATUS(_ah) \
+		((AR_SREV_9340(_ah) || AR_SREV_9550(_ah)) ? 0x31018 : 0x15f18)
 #define AR9300_OTP_STATUS_TYPE		0x7
 #define AR9300_OTP_STATUS_VALID		0x4
 #define AR9300_OTP_STATUS_ACCESS_BUSY	0x2
 #define AR9300_OTP_STATUS_SM_BUSY	0x1
-#define AR9300_OTP_READ_DATA \
-		((AR_SREV_9340(ah) || AR_SREV_9550(ah)) ? 0x3101c : 0x15f1c)
+#define AR9300_OTP_READ_DATA(_ah) \
+		((AR_SREV_9340(_ah) || AR_SREV_9550(_ah)) ? 0x3101c : 0x15f1c)
 
 enum targetPowerHTRates {
 	HT_TARGET_RATE_0_8_16,
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_hw.c b/drivers/net/wireless/ath/ath9k/ar9003_hw.c
index 42f00a2a8..4f27a9fb1 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_hw.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_hw.c
@@ -1032,8 +1032,8 @@ static void ar9003_hw_configpcipowersave(struct ath_hw *ah,
 	/* Nothing to do on restore for 11N */
 	if (!power_off /* !restore */) {
 		/* set bit 19 to allow forcing of pcie core into L1 state */
-		REG_SET_BIT(ah, AR_PCIE_PM_CTRL, AR_PCIE_PM_CTRL_ENA);
-		REG_WRITE(ah, AR_WA, ah->WARegVal);
+		REG_SET_BIT(ah, AR_PCIE_PM_CTRL(ah), AR_PCIE_PM_CTRL_ENA);
+		REG_WRITE(ah, AR_WA(ah), ah->WARegVal);
 	}
 
 	/*
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_mac.c b/drivers/net/wireless/ath/ath9k/ar9003_mac.c
index ff8ab58e6..a8bc00307 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_mac.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_mac.c
@@ -193,16 +193,16 @@ static bool ar9003_hw_get_isr(struct ath_hw *ah, enum ath9k_int *masked,
 	if (ath9k_hw_mci_is_enabled(ah))
 		async_mask |= AR_INTR_ASYNC_MASK_MCI;
 
-	async_cause = REG_READ(ah, AR_INTR_ASYNC_CAUSE);
+	async_cause = REG_READ(ah, AR_INTR_ASYNC_CAUSE(ah));
 
 	if (async_cause & async_mask) {
-		if ((REG_READ(ah, AR_RTC_STATUS) & AR_RTC_STATUS_M)
+		if ((REG_READ(ah, AR_RTC_STATUS(ah)) & AR_RTC_STATUS_M(ah))
 				== AR_RTC_STATUS_ON)
 			isr = REG_READ(ah, AR_ISR);
 	}
 
 
-	sync_cause = REG_READ(ah, AR_INTR_SYNC_CAUSE) & AR_INTR_SYNC_DEFAULT;
+	sync_cause = REG_READ(ah, AR_INTR_SYNC_CAUSE(ah)) & AR_INTR_SYNC_DEFAULT;
 
 	*masked = 0;
 
@@ -280,7 +280,7 @@ static bool ar9003_hw_get_isr(struct ath_hw *ah, enum ath9k_int *masked,
 			u32 s5;
 
 			if (pCap->hw_caps & ATH9K_HW_CAP_RAC_SUPPORTED)
-				s5 = REG_READ(ah, AR_ISR_S5_S);
+				s5 = REG_READ(ah, AR_ISR_S5_S(ah));
 			else
 				s5 = REG_READ(ah, AR_ISR_S5);
 
@@ -345,8 +345,8 @@ static bool ar9003_hw_get_isr(struct ath_hw *ah, enum ath9k_int *masked,
 			ath_dbg(common, INTERRUPT,
 				"AR_INTR_SYNC_LOCAL_TIMEOUT\n");
 
-		REG_WRITE(ah, AR_INTR_SYNC_CAUSE_CLR, sync_cause);
-		(void) REG_READ(ah, AR_INTR_SYNC_CAUSE_CLR);
+		REG_WRITE(ah, AR_INTR_SYNC_CAUSE_CLR(ah), sync_cause);
+		(void) REG_READ(ah, AR_INTR_SYNC_CAUSE_CLR(ah));
 
 	}
 	return true;
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_mci.c b/drivers/net/wireless/ath/ath9k/ar9003_mci.c
index 8d7efd80d..2b9c07961 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_mci.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_mci.c
@@ -458,7 +458,7 @@ static void ar9003_mci_observation_set_up(struct ath_hw *ah)
 	} else
 		return;
 
-	REG_SET_BIT(ah, AR_GPIO_INPUT_EN_VAL, AR_GPIO_JTAG_DISABLE);
+	REG_SET_BIT(ah, AR_GPIO_INPUT_EN_VAL(ah), AR_GPIO_JTAG_DISABLE);
 
 	REG_RMW_FIELD(ah, AR_PHY_GLB_CONTROL, AR_GLB_DS_JTAG_DISABLE, 1);
 	REG_RMW_FIELD(ah, AR_PHY_GLB_CONTROL, AR_GLB_WLAN_UART_INTF_EN, 0);
@@ -466,12 +466,12 @@ static void ar9003_mci_observation_set_up(struct ath_hw *ah)
 
 	REG_RMW_FIELD(ah, AR_BTCOEX_CTRL2, AR_BTCOEX_CTRL2_GPIO_OBS_SEL, 0);
 	REG_RMW_FIELD(ah, AR_BTCOEX_CTRL2, AR_BTCOEX_CTRL2_MAC_BB_OBS_SEL, 1);
-	REG_WRITE(ah, AR_OBS, 0x4b);
+	REG_WRITE(ah, AR_OBS(ah), 0x4b);
 	REG_RMW_FIELD(ah, AR_DIAG_SW, AR_DIAG_OBS_PT_SEL1, 0x03);
 	REG_RMW_FIELD(ah, AR_DIAG_SW, AR_DIAG_OBS_PT_SEL2, 0x01);
 	REG_RMW_FIELD(ah, AR_MACMISC, AR_MACMISC_MISC_OBS_BUS_LSB, 0x02);
 	REG_RMW_FIELD(ah, AR_MACMISC, AR_MACMISC_MISC_OBS_BUS_MSB, 0x03);
-	REG_RMW_FIELD(ah, AR_PHY_TEST_CTL_STATUS,
+	REG_RMW_FIELD(ah, AR_PHY_TEST_CTL_STATUS(ah),
 		      AR_PHY_TEST_CTL_DEBUGPORT_SEL, 0x07);
 }
 
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_paprd.c b/drivers/net/wireless/ath/ath9k/ar9003_paprd.c
index b2d53b6c0..83d993fff 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_paprd.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_paprd.c
@@ -201,19 +201,19 @@ static int ar9003_paprd_setup_single_table(struct ath_hw *ah)
 
 	ar9003_paprd_enable(ah, false);
 
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL1,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL1(ah),
 		      AR_PHY_PAPRD_TRAINER_CNTL1_CF_PAPRD_LB_SKIP, 0x30);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL1,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL1(ah),
 		      AR_PHY_PAPRD_TRAINER_CNTL1_CF_PAPRD_LB_ENABLE, 1);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL1,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL1(ah),
 		      AR_PHY_PAPRD_TRAINER_CNTL1_CF_PAPRD_TX_GAIN_FORCE, 1);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL1,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL1(ah),
 		      AR_PHY_PAPRD_TRAINER_CNTL1_CF_PAPRD_RX_BB_GAIN_FORCE, 0);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL1,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL1(ah),
 		      AR_PHY_PAPRD_TRAINER_CNTL1_CF_PAPRD_IQCORR_ENABLE, 0);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL1,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL1(ah),
 		      AR_PHY_PAPRD_TRAINER_CNTL1_CF_PAPRD_AGC2_SETTLING, 28);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL1,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL1(ah),
 		      AR_PHY_PAPRD_TRAINER_CNTL1_CF_CF_PAPRD_TRAIN_ENABLE, 1);
 
 	if (AR_SREV_9485(ah)) {
@@ -229,15 +229,15 @@ static int ar9003_paprd_setup_single_table(struct ath_hw *ah)
 		}
 	}
 
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL2,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL2(ah),
 		      AR_PHY_PAPRD_TRAINER_CNTL2_CF_PAPRD_INIT_RX_BB_GAIN, val);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL3,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL3(ah),
 		      AR_PHY_PAPRD_TRAINER_CNTL3_CF_PAPRD_FINE_CORR_LEN, 4);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL3,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL3(ah),
 		      AR_PHY_PAPRD_TRAINER_CNTL3_CF_PAPRD_COARSE_CORR_LEN, 4);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL3,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL3(ah),
 		      AR_PHY_PAPRD_TRAINER_CNTL3_CF_PAPRD_NUM_CORR_STAGES, 7);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL3,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL3(ah),
 		      AR_PHY_PAPRD_TRAINER_CNTL3_CF_PAPRD_MIN_LOOPBACK_DEL, 1);
 
 	if (AR_SREV_9485(ah) ||
@@ -246,10 +246,10 @@ static int ar9003_paprd_setup_single_table(struct ath_hw *ah)
 	    AR_SREV_9550(ah) ||
 	    AR_SREV_9330(ah) ||
 	    AR_SREV_9340(ah))
-		REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL3,
+		REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL3(ah),
 			      AR_PHY_PAPRD_TRAINER_CNTL3_CF_PAPRD_QUICK_DROP, -3);
 	else
-		REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL3,
+		REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL3(ah),
 			      AR_PHY_PAPRD_TRAINER_CNTL3_CF_PAPRD_QUICK_DROP, -6);
 
 	val = -10;
@@ -257,16 +257,16 @@ static int ar9003_paprd_setup_single_table(struct ath_hw *ah)
 	if (IS_CHAN_2GHZ(ah->curchan) && !AR_SREV_9462(ah) && !AR_SREV_9565(ah))
 		val = -15;
 
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL3,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL3(ah),
 		      AR_PHY_PAPRD_TRAINER_CNTL3_CF_PAPRD_ADC_DESIRED_SIZE,
 		      val);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL3,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL3(ah),
 		      AR_PHY_PAPRD_TRAINER_CNTL3_CF_PAPRD_BBTXMIX_DISABLE, 1);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL4,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL4(ah),
 		      AR_PHY_PAPRD_TRAINER_CNTL4_CF_PAPRD_SAFETY_DELTA, 0);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL4,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL4(ah),
 		      AR_PHY_PAPRD_TRAINER_CNTL4_CF_PAPRD_MIN_CORR, 400);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL4,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL4(ah),
 		      AR_PHY_PAPRD_TRAINER_CNTL4_CF_PAPRD_NUM_TRAIN_SAMPLES,
 		      100);
 	REG_RMW_FIELD(ah, AR_PHY_PAPRD_PRE_POST_SCALE_0_B0,
@@ -313,7 +313,7 @@ static unsigned int ar9003_get_desired_gain(struct ath_hw *ah, int chain,
 	int desired_scale, desired_gain = 0;
 	u32 reg_olpc  = 0, reg_cl_gain  = 0;
 
-	REG_CLR_BIT(ah, AR_PHY_PAPRD_TRAINER_STAT1,
+	REG_CLR_BIT(ah, AR_PHY_PAPRD_TRAINER_STAT1(ah),
 		    AR_PHY_PAPRD_TRAINER_STAT1_PAPRD_TRAIN_DONE);
 	desired_scale = REG_READ_FIELD(ah, AR_PHY_TPC_12,
 				       AR_PHY_TPC_12_DESIRED_SCALE_HT40_5);
@@ -812,7 +812,7 @@ void ar9003_paprd_setup_gain_table(struct ath_hw *ah, int chain)
 
 	ar9003_tx_force_gain(ah, gain_index);
 
-	REG_CLR_BIT(ah, AR_PHY_PAPRD_TRAINER_STAT1,
+	REG_CLR_BIT(ah, AR_PHY_PAPRD_TRAINER_STAT1(ah),
 			AR_PHY_PAPRD_TRAINER_STAT1_PAPRD_TRAIN_DONE);
 }
 EXPORT_SYMBOL(ar9003_paprd_setup_gain_table);
@@ -833,7 +833,7 @@ static bool ar9003_paprd_retrain_pa_in(struct ath_hw *ah,
 	capdiv2g = REG_READ_FIELD(ah, AR_PHY_65NM_CH0_TXRF3,
 				  AR_PHY_65NM_CH0_TXRF3_CAPDIV2G);
 
-	quick_drop = REG_READ_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL3,
+	quick_drop = REG_READ_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL3(ah),
 				    AR_PHY_PAPRD_TRAINER_CNTL3_CF_PAPRD_QUICK_DROP);
 
 	if (quick_drop)
@@ -906,7 +906,7 @@ static bool ar9003_paprd_retrain_pa_in(struct ath_hw *ah,
 
 	REG_RMW_FIELD(ah, AR_PHY_65NM_CH0_TXRF3,
 		      AR_PHY_65NM_CH0_TXRF3_CAPDIV2G, capdiv2g);
-	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL3,
+	REG_RMW_FIELD(ah, AR_PHY_PAPRD_TRAINER_CNTL3(ah),
 		      AR_PHY_PAPRD_TRAINER_CNTL3_CF_PAPRD_QUICK_DROP,
 		      quick_drop);
 
@@ -932,14 +932,14 @@ int ar9003_paprd_create_curve(struct ath_hw *ah,
 	data_L = &buf[0];
 	data_U = &buf[48];
 
-	REG_CLR_BIT(ah, AR_PHY_CHAN_INFO_MEMORY,
+	REG_CLR_BIT(ah, AR_PHY_CHAN_INFO_MEMORY(ah),
 		    AR_PHY_CHAN_INFO_MEMORY_CHANINFOMEM_S2_READ);
 
 	reg = AR_PHY_CHAN_INFO_TAB_0;
 	for (i = 0; i < 48; i++)
 		data_L[i] = REG_READ(ah, reg + (i << 2));
 
-	REG_SET_BIT(ah, AR_PHY_CHAN_INFO_MEMORY,
+	REG_SET_BIT(ah, AR_PHY_CHAN_INFO_MEMORY(ah),
 		    AR_PHY_CHAN_INFO_MEMORY_CHANINFOMEM_S2_READ);
 
 	for (i = 0; i < 48; i++)
@@ -951,7 +951,7 @@ int ar9003_paprd_create_curve(struct ath_hw *ah,
 	if (ar9003_paprd_retrain_pa_in(ah, caldata, chain))
 		status = -EINPROGRESS;
 
-	REG_CLR_BIT(ah, AR_PHY_PAPRD_TRAINER_STAT1,
+	REG_CLR_BIT(ah, AR_PHY_PAPRD_TRAINER_STAT1(ah),
 		    AR_PHY_PAPRD_TRAINER_STAT1_PAPRD_TRAIN_DONE);
 
 	kfree(buf);
@@ -977,14 +977,14 @@ bool ar9003_paprd_is_done(struct ath_hw *ah)
 {
 	int paprd_done, agc2_pwr;
 
-	paprd_done = REG_READ_FIELD(ah, AR_PHY_PAPRD_TRAINER_STAT1,
+	paprd_done = REG_READ_FIELD(ah, AR_PHY_PAPRD_TRAINER_STAT1(ah),
 				AR_PHY_PAPRD_TRAINER_STAT1_PAPRD_TRAIN_DONE);
 
 	if (AR_SREV_9485(ah))
 		goto exit;
 
 	if (paprd_done == 0x1) {
-		agc2_pwr = REG_READ_FIELD(ah, AR_PHY_PAPRD_TRAINER_STAT1,
+		agc2_pwr = REG_READ_FIELD(ah, AR_PHY_PAPRD_TRAINER_STAT1(ah),
 				AR_PHY_PAPRD_TRAINER_STAT1_PAPRD_AGC2_PWR);
 
 		ath_dbg(ath9k_hw_common(ah), CALIBRATE,
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_phy.c b/drivers/net/wireless/ath/ath9k/ar9003_phy.c
index 090ff0600..a29c11f94 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_phy.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_phy.c
@@ -296,7 +296,7 @@ static void ar9003_hw_spur_mitigate_mrc_cck(struct ath_hw *ah,
 
 			cck_spur_freq = cck_spur_freq & 0xfffff;
 
-			REG_RMW_FIELD(ah, AR_PHY_AGC_CONTROL,
+			REG_RMW_FIELD(ah, AR_PHY_AGC_CONTROL(ah),
 				      AR_PHY_AGC_CONTROL_YCOK_MAX, 0x7);
 			REG_RMW_FIELD(ah, AR_PHY_CCK_SPUR_MIT,
 				      AR_PHY_CCK_SPUR_MIT_SPUR_RSSI_THR, 0x7f);
@@ -314,7 +314,7 @@ static void ar9003_hw_spur_mitigate_mrc_cck(struct ath_hw *ah,
 		}
 	}
 
-	REG_RMW_FIELD(ah, AR_PHY_AGC_CONTROL,
+	REG_RMW_FIELD(ah, AR_PHY_AGC_CONTROL(ah),
 		      AR_PHY_AGC_CONTROL_YCOK_MAX, 0x5);
 	REG_RMW_FIELD(ah, AR_PHY_CCK_SPUR_MIT,
 		      AR_PHY_CCK_SPUR_MIT_USE_CCK_SPUR_MIT, 0x0);
@@ -352,7 +352,7 @@ static void ar9003_hw_spur_ofdm_clear(struct ath_hw *ah)
 		      AR_PHY_TIMING4_ENABLE_CHAN_MASK, 0);
 	REG_RMW_FIELD(ah, AR_PHY_PILOT_SPUR_MASK,
 		      AR_PHY_PILOT_SPUR_MASK_CF_PILOT_MASK_IDX_A, 0);
-	REG_RMW_FIELD(ah, AR_PHY_SPUR_MASK_A,
+	REG_RMW_FIELD(ah, AR_PHY_SPUR_MASK_A(ah),
 		      AR_PHY_SPUR_MASK_A_CF_PUNC_MASK_IDX_A, 0);
 	REG_RMW_FIELD(ah, AR_PHY_CHAN_SPUR_MASK,
 		      AR_PHY_CHAN_SPUR_MASK_CF_CHAN_MASK_IDX_A, 0);
@@ -360,7 +360,7 @@ static void ar9003_hw_spur_ofdm_clear(struct ath_hw *ah)
 		      AR_PHY_PILOT_SPUR_MASK_CF_PILOT_MASK_A, 0);
 	REG_RMW_FIELD(ah, AR_PHY_CHAN_SPUR_MASK,
 		      AR_PHY_CHAN_SPUR_MASK_CF_CHAN_MASK_A, 0);
-	REG_RMW_FIELD(ah, AR_PHY_SPUR_MASK_A,
+	REG_RMW_FIELD(ah, AR_PHY_SPUR_MASK_A(ah),
 		      AR_PHY_SPUR_MASK_A_CF_PUNC_MASK_A, 0);
 	REG_RMW_FIELD(ah, AR_PHY_SPUR_REG,
 		      AR_PHY_SPUR_REG_MASK_RATE_CNTL, 0);
@@ -419,7 +419,7 @@ static void ar9003_hw_spur_ofdm(struct ath_hw *ah,
 		      AR_PHY_TIMING4_ENABLE_CHAN_MASK, 0x1);
 	REG_RMW_FIELD(ah, AR_PHY_PILOT_SPUR_MASK,
 		      AR_PHY_PILOT_SPUR_MASK_CF_PILOT_MASK_IDX_A, mask_index);
-	REG_RMW_FIELD(ah, AR_PHY_SPUR_MASK_A,
+	REG_RMW_FIELD(ah, AR_PHY_SPUR_MASK_A(ah),
 		      AR_PHY_SPUR_MASK_A_CF_PUNC_MASK_IDX_A, mask_index);
 	REG_RMW_FIELD(ah, AR_PHY_CHAN_SPUR_MASK,
 		      AR_PHY_CHAN_SPUR_MASK_CF_CHAN_MASK_IDX_A, mask_index);
@@ -427,7 +427,7 @@ static void ar9003_hw_spur_ofdm(struct ath_hw *ah,
 		      AR_PHY_PILOT_SPUR_MASK_CF_PILOT_MASK_A, 0xc);
 	REG_RMW_FIELD(ah, AR_PHY_CHAN_SPUR_MASK,
 		      AR_PHY_CHAN_SPUR_MASK_CF_CHAN_MASK_A, 0xc);
-	REG_RMW_FIELD(ah, AR_PHY_SPUR_MASK_A,
+	REG_RMW_FIELD(ah, AR_PHY_SPUR_MASK_A(ah),
 		      AR_PHY_SPUR_MASK_A_CF_PUNC_MASK_A, 0xa0);
 	REG_RMW_FIELD(ah, AR_PHY_SPUR_REG,
 		      AR_PHY_SPUR_REG_MASK_RATE_CNTL, 0xff);
@@ -449,7 +449,7 @@ static void ar9003_hw_spur_ofdm_9565(struct ath_hw *ah,
 		      mask_index);
 
 	/* A == B */
-	REG_RMW_FIELD(ah, AR_PHY_SPUR_MASK_B,
+	REG_RMW_FIELD(ah, AR_PHY_SPUR_MASK_B(ah),
 		      AR_PHY_SPUR_MASK_A_CF_PUNC_MASK_IDX_A,
 		      mask_index);
 
@@ -462,7 +462,7 @@ static void ar9003_hw_spur_ofdm_9565(struct ath_hw *ah,
 		      AR_PHY_CHAN_SPUR_MASK_CF_CHAN_MASK_B, 0xe);
 
 	/* A == B */
-	REG_RMW_FIELD(ah, AR_PHY_SPUR_MASK_B,
+	REG_RMW_FIELD(ah, AR_PHY_SPUR_MASK_B(ah),
 		      AR_PHY_SPUR_MASK_A_CF_PUNC_MASK_A, 0xa0);
 }
 
@@ -710,7 +710,7 @@ static void ar9003_hw_override_ini(struct ath_hw *ah)
 		REG_WRITE(ah, AR_GLB_SWREG_DISCONT_MODE,
 			  AR_GLB_SWREG_DISCONT_EN_BT_WLAN);
 
-		if (REG_READ_FIELD(ah, AR_PHY_TX_IQCAL_CONTROL_0,
+		if (REG_READ_FIELD(ah, AR_PHY_TX_IQCAL_CONTROL_0(ah),
 				   AR_PHY_TX_IQCAL_CONTROL_0_ENABLE_TXIQ_CAL))
 			ah->enabled_cals |= TX_IQ_CAL;
 		else
@@ -726,11 +726,11 @@ static void ar9003_hw_override_ini(struct ath_hw *ah)
 	if (AR_SREV_9340(ah) || AR_SREV_9531(ah) || AR_SREV_9550(ah) ||
 	    AR_SREV_9561(ah)) {
 		if (ah->is_clk_25mhz) {
-			REG_WRITE(ah, AR_RTC_DERIVED_CLK, 0x17c << 1);
+			REG_WRITE(ah, AR_RTC_DERIVED_CLK(ah), 0x17c << 1);
 			REG_WRITE(ah, AR_SLP32_MODE, 0x0010f3d7);
 			REG_WRITE(ah, AR_SLP32_INC, 0x0001e7ae);
 		} else {
-			REG_WRITE(ah, AR_RTC_DERIVED_CLK, 0x261 << 1);
+			REG_WRITE(ah, AR_RTC_DERIVED_CLK(ah), 0x261 << 1);
 			REG_WRITE(ah, AR_SLP32_MODE, 0x0010f400);
 			REG_WRITE(ah, AR_SLP32_INC, 0x0001e800);
 		}
@@ -1795,7 +1795,7 @@ static void ar9003_hw_spectral_scan_wait(struct ath_hw *ah)
 
 static void ar9003_hw_tx99_start(struct ath_hw *ah, u32 qnum)
 {
-	REG_SET_BIT(ah, AR_PHY_TEST, PHY_AGC_CLR);
+	REG_SET_BIT(ah, AR_PHY_TEST(ah), PHY_AGC_CLR);
 	REG_CLR_BIT(ah, AR_DIAG_SW, AR_DIAG_RX_DIS);
 	REG_WRITE(ah, AR_CR, AR_CR_RXD);
 	REG_WRITE(ah, AR_DLCL_IFS(qnum), 0);
@@ -1808,7 +1808,7 @@ static void ar9003_hw_tx99_start(struct ath_hw *ah, u32 qnum)
 
 static void ar9003_hw_tx99_stop(struct ath_hw *ah)
 {
-	REG_CLR_BIT(ah, AR_PHY_TEST, PHY_AGC_CLR);
+	REG_CLR_BIT(ah, AR_PHY_TEST(ah), PHY_AGC_CLR);
 	REG_SET_BIT(ah, AR_DIAG_SW, AR_DIAG_RX_DIS);
 }
 
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_phy.h b/drivers/net/wireless/ath/ath9k/ar9003_phy.h
index ad949eb02..57e2b4c89 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_phy.h
+++ b/drivers/net/wireless/ath/ath9k/ar9003_phy.h
@@ -454,8 +454,8 @@
 #define AR_PHY_GEN_CTRL          (AR_SM_BASE + 0x4)
 #define AR_PHY_MODE              (AR_SM_BASE + 0x8)
 #define AR_PHY_ACTIVE            (AR_SM_BASE + 0xc)
-#define AR_PHY_SPUR_MASK_A       (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x18 : 0x20))
-#define AR_PHY_SPUR_MASK_B       (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x1c : 0x24))
+#define AR_PHY_SPUR_MASK_A(_ah)  (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x18 : 0x20))
+#define AR_PHY_SPUR_MASK_B(_ah)  (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x1c : 0x24))
 #define AR_PHY_SPECTRAL_SCAN     (AR_SM_BASE + 0x28)
 #define AR_PHY_RADAR_BW_FILTER   (AR_SM_BASE + 0x2c)
 #define AR_PHY_SEARCH_START_DELAY (AR_SM_BASE + 0x30)
@@ -498,7 +498,7 @@
 #define AR_PHY_SPUR_MASK_A_CF_PUNC_MASK_A                       0x3FF
 #define AR_PHY_SPUR_MASK_A_CF_PUNC_MASK_A_S                     0
 
-#define AR_PHY_TEST              (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x15c : 0x160))
+#define AR_PHY_TEST(_ah)         (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x15c : 0x160))
 
 #define AR_PHY_TEST_BBB_OBS_SEL       0x780000
 #define AR_PHY_TEST_BBB_OBS_SEL_S     19
@@ -509,7 +509,7 @@
 #define AR_PHY_TEST_CHAIN_SEL      0xC0000000
 #define AR_PHY_TEST_CHAIN_SEL_S    30
 
-#define AR_PHY_TEST_CTL_STATUS   (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x160 : 0x164))
+#define AR_PHY_TEST_CTL_STATUS(_ah) (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x160 : 0x164))
 #define AR_PHY_TEST_CTL_TSTDAC_EN         0x1
 #define AR_PHY_TEST_CTL_TSTDAC_EN_S       0
 #define AR_PHY_TEST_CTL_TX_OBS_SEL        0x1C
@@ -524,22 +524,22 @@
 #define AR_PHY_TEST_CTL_DEBUGPORT_SEL_S	  29
 
 
-#define AR_PHY_TSTDAC            (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x164 : 0x168))
+#define AR_PHY_TSTDAC(_ah)       (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x164 : 0x168))
 
-#define AR_PHY_CHAN_STATUS       (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x168 : 0x16c))
+#define AR_PHY_CHAN_STATUS(_ah)  (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x168 : 0x16c))
 
-#define AR_PHY_CHAN_INFO_MEMORY (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x16c : 0x170))
+#define AR_PHY_CHAN_INFO_MEMORY(_ah) (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x16c : 0x170))
 #define AR_PHY_CHAN_INFO_MEMORY_CHANINFOMEM_S2_READ	0x00000008
 #define AR_PHY_CHAN_INFO_MEMORY_CHANINFOMEM_S2_READ_S	3
 
-#define AR_PHY_CHNINFO_NOISEPWR  (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x170 : 0x174))
-#define AR_PHY_CHNINFO_GAINDIFF  (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x174 : 0x178))
-#define AR_PHY_CHNINFO_FINETIM   (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x178 : 0x17c))
-#define AR_PHY_CHAN_INFO_GAIN_0  (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x17c : 0x180))
-#define AR_PHY_SCRAMBLER_SEED    (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x184 : 0x190))
-#define AR_PHY_CCK_TX_CTRL       (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x188 : 0x194))
+#define AR_PHY_CHNINFO_NOISEPWR(_ah)  (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x170 : 0x174))
+#define AR_PHY_CHNINFO_GAINDIFF(_ah)  (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x174 : 0x178))
+#define AR_PHY_CHNINFO_FINETIM(_ah)   (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x178 : 0x17c))
+#define AR_PHY_CHAN_INFO_GAIN_0(_ah)  (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x17c : 0x180))
+#define AR_PHY_SCRAMBLER_SEED(_ah)    (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x184 : 0x190))
+#define AR_PHY_CCK_TX_CTRL(_ah)       (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x188 : 0x194))
 
-#define AR_PHY_HEAVYCLIP_CTL     (AR_SM_BASE + (AR_SREV_9561(ah) ? 0x198 : 0x1a4))
+#define AR_PHY_HEAVYCLIP_CTL(_ah) (AR_SM_BASE + (AR_SREV_9561(_ah) ? 0x198 : 0x1a4))
 #define AR_PHY_HEAVYCLIP_20      (AR_SM_BASE + 0x1a8)
 #define AR_PHY_HEAVYCLIP_40      (AR_SM_BASE + 0x1ac)
 #define AR_PHY_HEAVYCLIP_1	 (AR_SM_BASE + 0x19c)
@@ -611,16 +611,16 @@
 
 #define AR_PHY_TXGAIN_TABLE      (AR_SM_BASE + 0x300)
 
-#define AR_PHY_TX_IQCAL_CONTROL_0   (AR_SM_BASE + (AR_SREV_9485(ah) ? \
+#define AR_PHY_TX_IQCAL_CONTROL_0(_ah)   (AR_SM_BASE + (AR_SREV_9485(_ah) ? \
 						 0x3c4 : 0x444))
-#define AR_PHY_TX_IQCAL_CONTROL_1   (AR_SM_BASE + (AR_SREV_9485(ah) ? \
+#define AR_PHY_TX_IQCAL_CONTROL_1(_ah)   (AR_SM_BASE + (AR_SREV_9485(_ah) ? \
 						 0x3c8 : 0x448))
-#define AR_PHY_TX_IQCAL_START       (AR_SM_BASE + (AR_SREV_9485(ah) ? \
+#define AR_PHY_TX_IQCAL_START(_ah)       (AR_SM_BASE + (AR_SREV_9485(_ah) ? \
 						 0x3c4 : 0x440))
-#define AR_PHY_TX_IQCAL_STATUS_B0   (AR_SM_BASE + (AR_SREV_9485(ah) ? \
+#define AR_PHY_TX_IQCAL_STATUS_B0(_ah)   (AR_SM_BASE + (AR_SREV_9485(_ah) ? \
 						 0x3f0 : 0x48c))
-#define AR_PHY_TX_IQCAL_CORR_COEFF_B0(_i)    (AR_SM_BASE + \
-					     (AR_SREV_9485(ah) ? \
+#define AR_PHY_TX_IQCAL_CORR_COEFF_B0(_ah, _i)    (AR_SM_BASE + \
+					     (AR_SREV_9485(_ah) ? \
 					      0x3d0 : 0x450) + ((_i) << 2))
 #define AR_PHY_RTT_CTRL			(AR_SM_BASE + 0x380)
 
@@ -684,8 +684,8 @@
 #define AR_PHY_65NM_CH0_RXTX2_SYNTHOVR_MASK        0x00000008
 #define AR_PHY_65NM_CH0_RXTX2_SYNTHOVR_MASK_S      3
 
-#define AR_CH0_TOP	(AR_SREV_9300(ah) ? 0x16288 : \
-			 (((AR_SREV_9462(ah) || AR_SREV_9565(ah)) ? 0x1628c : 0x16280)))
+#define AR_CH0_TOP(_ah)	(AR_SREV_9300(_ah) ? 0x16288 : \
+			 (((AR_SREV_9462(_ah) || AR_SREV_9565(_ah)) ? 0x1628c : 0x16280)))
 #define AR_CH0_TOP_XPABIASLVL (AR_SREV_9550(ah) ? 0x3c0 : 0x300)
 #define AR_CH0_TOP_XPABIASLVL_S (AR_SREV_9550(ah) ? 6 : 8)
 
@@ -705,8 +705,8 @@
 #define AR_SWITCH_TABLE_ALL (0xfff)
 #define AR_SWITCH_TABLE_ALL_S (0)
 
-#define AR_CH0_THERM       (AR_SREV_9300(ah) ? 0x16290 :\
-			    ((AR_SREV_9462(ah) || AR_SREV_9565(ah)) ? 0x16294 : 0x1628c))
+#define AR_CH0_THERM(_ah)  (AR_SREV_9300(_ah) ? 0x16290 :\
+			    ((AR_SREV_9462(_ah) || AR_SREV_9565(_ah)) ? 0x16294 : 0x1628c))
 #define AR_CH0_THERM_XPABIASLVL_MSB 0x3
 #define AR_CH0_THERM_XPABIASLVL_MSB_S 0
 #define AR_CH0_THERM_XPASHORT2GND 0x4
@@ -717,26 +717,26 @@
 #define AR_CH0_THERM_SAR_ADC_OUT   0x0000ff00
 #define AR_CH0_THERM_SAR_ADC_OUT_S 8
 
-#define AR_CH0_TOP2		(AR_SREV_9300(ah) ? 0x1628c : \
-					(AR_SREV_9462(ah) ? 0x16290 : 0x16284))
+#define AR_CH0_TOP2(_ah)		(AR_SREV_9300(_ah) ? 0x1628c : \
+					(AR_SREV_9462(_ah) ? 0x16290 : 0x16284))
 #define AR_CH0_TOP2_XPABIASLVL		(AR_SREV_9561(ah) ? 0x1e00 : 0xf000)
 #define AR_CH0_TOP2_XPABIASLVL_S	(AR_SREV_9561(ah) ? 9 : 12)
 
-#define AR_CH0_XTAL		(AR_SREV_9300(ah) ? 0x16294 : \
-				 ((AR_SREV_9462(ah) || AR_SREV_9565(ah)) ? 0x16298 : \
-				  (AR_SREV_9561(ah) ? 0x162c0 : 0x16290)))
+#define AR_CH0_XTAL(_ah)	(AR_SREV_9300(_ah) ? 0x16294 : \
+				 ((AR_SREV_9462(_ah) || AR_SREV_9565(_ah)) ? 0x16298 : \
+				  (AR_SREV_9561(_ah) ? 0x162c0 : 0x16290)))
 #define AR_CH0_XTAL_CAPINDAC	0x7f000000
 #define AR_CH0_XTAL_CAPINDAC_S	24
 #define AR_CH0_XTAL_CAPOUTDAC	0x00fe0000
 #define AR_CH0_XTAL_CAPOUTDAC_S	17
 
-#define AR_PHY_PMU1		((AR_SREV_9462(ah) || AR_SREV_9565(ah)) ? 0x16340 : \
-				 (AR_SREV_9561(ah) ? 0x16cc0 : 0x16c40))
+#define AR_PHY_PMU1(_ah)	((AR_SREV_9462(_ah) || AR_SREV_9565(_ah)) ? 0x16340 : \
+				 (AR_SREV_9561(_ah) ? 0x16cc0 : 0x16c40))
 #define AR_PHY_PMU1_PWD		0x1
 #define AR_PHY_PMU1_PWD_S	0
 
-#define AR_PHY_PMU2		((AR_SREV_9462(ah) || AR_SREV_9565(ah)) ? 0x16344 : \
-				 (AR_SREV_9561(ah) ? 0x16cc4 : 0x16c44))
+#define AR_PHY_PMU2(_ah)	((AR_SREV_9462(_ah) || AR_SREV_9565(_ah)) ? 0x16344 : \
+				 (AR_SREV_9561(_ah) ? 0x16cc4 : 0x16c44))
 #define AR_PHY_PMU2_PGM		0x00200000
 #define AR_PHY_PMU2_PGM_S	21
 
@@ -974,7 +974,7 @@
 #define AR_PHY_TPC_5_B1         (AR_SM1_BASE + 0x208)
 #define AR_PHY_TPC_6_B1         (AR_SM1_BASE + 0x20c)
 #define AR_PHY_TPC_11_B1        (AR_SM1_BASE + 0x220)
-#define AR_PHY_PDADC_TAB_1	(AR_SM1_BASE + (AR_SREV_9462_20_OR_LATER(ah) ? \
+#define AR_PHY_PDADC_TAB_1(_ah)	(AR_SM1_BASE + (AR_SREV_9462_20_OR_LATER(_ah) ? \
 					0x280 : 0x240))
 #define AR_PHY_TPC_19_B1	(AR_SM1_BASE + 0x240)
 #define AR_PHY_TPC_19_B1_ALPHA_THERM		0xff
@@ -1152,7 +1152,7 @@
 #define AR_PHY_PAPRD_CTRL1_PAPRD_MAG_SCALE_FACT		0x0ffe0000
 #define AR_PHY_PAPRD_CTRL1_PAPRD_MAG_SCALE_FACT_S	17
 
-#define AR_PHY_PAPRD_TRAINER_CNTL1 (AR_SM_BASE + (AR_SREV_9485(ah) ? 0x580 : 0x490))
+#define AR_PHY_PAPRD_TRAINER_CNTL1(_ah) (AR_SM_BASE + (AR_SREV_9485(_ah) ? 0x580 : 0x490))
 
 #define AR_PHY_PAPRD_TRAINER_CNTL1_CF_CF_PAPRD_TRAIN_ENABLE	0x00000001
 #define AR_PHY_PAPRD_TRAINER_CNTL1_CF_CF_PAPRD_TRAIN_ENABLE_S	0
@@ -1169,12 +1169,12 @@
 #define AR_PHY_PAPRD_TRAINER_CNTL1_CF_PAPRD_LB_SKIP		0x0003f000
 #define AR_PHY_PAPRD_TRAINER_CNTL1_CF_PAPRD_LB_SKIP_S		12
 
-#define AR_PHY_PAPRD_TRAINER_CNTL2 (AR_SM_BASE + (AR_SREV_9485(ah) ? 0x584 : 0x494))
+#define AR_PHY_PAPRD_TRAINER_CNTL2(_ah) (AR_SM_BASE + (AR_SREV_9485(_ah) ? 0x584 : 0x494))
 
 #define AR_PHY_PAPRD_TRAINER_CNTL2_CF_PAPRD_INIT_RX_BB_GAIN	0xFFFFFFFF
 #define AR_PHY_PAPRD_TRAINER_CNTL2_CF_PAPRD_INIT_RX_BB_GAIN_S	0
 
-#define AR_PHY_PAPRD_TRAINER_CNTL3 (AR_SM_BASE + (AR_SREV_9485(ah) ? 0x588 : 0x498))
+#define AR_PHY_PAPRD_TRAINER_CNTL3(_ah) (AR_SM_BASE + (AR_SREV_9485(_ah) ? 0x588 : 0x498))
 
 #define AR_PHY_PAPRD_TRAINER_CNTL3_CF_PAPRD_ADC_DESIRED_SIZE	0x0000003f
 #define AR_PHY_PAPRD_TRAINER_CNTL3_CF_PAPRD_ADC_DESIRED_SIZE_S	0
@@ -1191,7 +1191,7 @@
 #define AR_PHY_PAPRD_TRAINER_CNTL3_CF_PAPRD_BBTXMIX_DISABLE	0x20000000
 #define AR_PHY_PAPRD_TRAINER_CNTL3_CF_PAPRD_BBTXMIX_DISABLE_S	29
 
-#define AR_PHY_PAPRD_TRAINER_CNTL4 (AR_SM_BASE + (AR_SREV_9485(ah) ? 0x58c : 0x49c))
+#define AR_PHY_PAPRD_TRAINER_CNTL4(_ah) (AR_SM_BASE + (AR_SREV_9485(_ah) ? 0x58c : 0x49c))
 
 #define AR_PHY_PAPRD_TRAINER_CNTL4_CF_PAPRD_NUM_TRAIN_SAMPLES	0x03ff0000
 #define AR_PHY_PAPRD_TRAINER_CNTL4_CF_PAPRD_NUM_TRAIN_SAMPLES_S	16
@@ -1211,7 +1211,7 @@
 #define AR_PHY_PAPRD_PRE_POST_SCALING				0x3FFFF
 #define AR_PHY_PAPRD_PRE_POST_SCALING_S				0
 
-#define AR_PHY_PAPRD_TRAINER_STAT1 (AR_SM_BASE + (AR_SREV_9485(ah) ? 0x590 : 0x4a0))
+#define AR_PHY_PAPRD_TRAINER_STAT1(_ah) (AR_SM_BASE + (AR_SREV_9485(_ah) ? 0x590 : 0x4a0))
 
 #define AR_PHY_PAPRD_TRAINER_STAT1_PAPRD_TRAIN_DONE		0x00000001
 #define AR_PHY_PAPRD_TRAINER_STAT1_PAPRD_TRAIN_DONE_S		0
@@ -1226,7 +1226,7 @@
 #define AR_PHY_PAPRD_TRAINER_STAT1_PAPRD_AGC2_PWR		0x0001fe00
 #define AR_PHY_PAPRD_TRAINER_STAT1_PAPRD_AGC2_PWR_S		9
 
-#define AR_PHY_PAPRD_TRAINER_STAT2 (AR_SM_BASE + (AR_SREV_9485(ah) ? 0x594 : 0x4a4))
+#define AR_PHY_PAPRD_TRAINER_STAT2(_ah) (AR_SM_BASE + (AR_SREV_9485(_ah) ? 0x594 : 0x4a4))
 
 #define AR_PHY_PAPRD_TRAINER_STAT2_PAPRD_FINE_VAL		0x0000ffff
 #define AR_PHY_PAPRD_TRAINER_STAT2_PAPRD_FINE_VAL_S		0
@@ -1235,7 +1235,7 @@
 #define AR_PHY_PAPRD_TRAINER_STAT2_PAPRD_FINE_IDX		0x00600000
 #define AR_PHY_PAPRD_TRAINER_STAT2_PAPRD_FINE_IDX_S		21
 
-#define AR_PHY_PAPRD_TRAINER_STAT3 (AR_SM_BASE + (AR_SREV_9485(ah) ? 0x598 : 0x4a8))
+#define AR_PHY_PAPRD_TRAINER_STAT3(_ah) (AR_SM_BASE + (AR_SREV_9485(_ah) ? 0x598 : 0x4a8))
 
 #define AR_PHY_PAPRD_TRAINER_STAT3_PAPRD_TRAIN_SAMPLES_CNT	0x000fffff
 #define AR_PHY_PAPRD_TRAINER_STAT3_PAPRD_TRAIN_SAMPLES_CNT_S	0
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_wow.c b/drivers/net/wireless/ath/ath9k/ar9003_wow.c
index bea41df9f..ac32afbf2 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_wow.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_wow.c
@@ -43,7 +43,7 @@ static void ath9k_hw_set_powermode_wow_sleep(struct ath_hw *ah)
 	/* set rx disable bit */
 	REG_WRITE(ah, AR_CR, AR_CR_RXD);
 
-	if (!ath9k_hw_wait(ah, AR_CR, AR_CR_RXE, 0, AH_WAIT_TIMEOUT)) {
+	if (!ath9k_hw_wait(ah, AR_CR, AR_CR_RXE(ah), 0, AH_WAIT_TIMEOUT)) {
 		ath_err(common, "Failed to stop Rx DMA in 10ms AR_CR=0x%08x AR_DIAG_SW=0x%08x\n",
 			REG_READ(ah, AR_CR), REG_READ(ah, AR_DIAG_SW));
 		return;
@@ -61,7 +61,7 @@ static void ath9k_hw_set_powermode_wow_sleep(struct ath_hw *ah)
 	if (ath9k_hw_mci_is_enabled(ah))
 		REG_WRITE(ah, AR_RTC_KEEP_AWAKE, 0x2);
 
-	REG_WRITE(ah, AR_RTC_FORCE_WAKE, AR_RTC_FORCE_WAKE_ON_INT);
+	REG_WRITE(ah, AR_RTC_FORCE_WAKE(ah), AR_RTC_FORCE_WAKE_ON_INT);
 }
 
 static void ath9k_wow_create_keep_alive_pattern(struct ath_hw *ah)
@@ -226,7 +226,7 @@ u32 ath9k_hw_wow_wakeup(struct ath_hw *ah)
 	 */
 
 	/* do we need to check the bit value 0x01000000 (7-10) ?? */
-	REG_RMW(ah, AR_PCIE_PM_CTRL, AR_PMCTRL_WOW_PME_CLR,
+	REG_RMW(ah, AR_PCIE_PM_CTRL(ah), AR_PMCTRL_WOW_PME_CLR,
 		AR_PMCTRL_PWR_STATE_D1D3);
 
 	/*
@@ -278,12 +278,12 @@ static void ath9k_hw_wow_set_arwr_reg(struct ath_hw *ah)
 	 * to the external PCI-E reset. We also need to tie
 	 * the PCI-E Phy reset to the PCI-E reset.
 	 */
-	wa_reg = REG_READ(ah, AR_WA);
+	wa_reg = REG_READ(ah, AR_WA(ah));
 	wa_reg &= ~AR_WA_UNTIE_RESET_EN;
 	wa_reg |= AR_WA_RESET_EN;
 	wa_reg |= AR_WA_POR_SHORT;
 
-	REG_WRITE(ah, AR_WA, wa_reg);
+	REG_WRITE(ah, AR_WA(ah), wa_reg);
 }
 
 void ath9k_hw_wow_enable(struct ath_hw *ah, u32 pattern_enable)
@@ -309,11 +309,11 @@ void ath9k_hw_wow_enable(struct ath_hw *ah, u32 pattern_enable)
 	 * Set and clear WOW_PME_CLEAR for the chip
 	 * to generate next wow signal.
 	 */
-	REG_SET_BIT(ah, AR_PCIE_PM_CTRL, AR_PMCTRL_HOST_PME_EN |
+	REG_SET_BIT(ah, AR_PCIE_PM_CTRL(ah), AR_PMCTRL_HOST_PME_EN |
 		    			 AR_PMCTRL_PWR_PM_CTRL_ENA |
 		    			 AR_PMCTRL_AUX_PWR_DET |
 		    			 AR_PMCTRL_WOW_PME_CLR);
-	REG_CLR_BIT(ah, AR_PCIE_PM_CTRL, AR_PMCTRL_WOW_PME_CLR);
+	REG_CLR_BIT(ah, AR_PCIE_PM_CTRL(ah), AR_PMCTRL_WOW_PME_CLR);
 
 	/*
 	 * Random Backoff.
@@ -414,7 +414,7 @@ void ath9k_hw_wow_enable(struct ath_hw *ah, u32 pattern_enable)
 	/*
 	 * Set the power states appropriately and enable PME.
 	 */
-	host_pm_ctrl = REG_READ(ah, AR_PCIE_PM_CTRL);
+	host_pm_ctrl = REG_READ(ah, AR_PCIE_PM_CTRL(ah));
 	host_pm_ctrl |= AR_PMCTRL_PWR_STATE_D1D3 |
 			AR_PMCTRL_HOST_PME_EN |
 			AR_PMCTRL_PWR_PM_CTRL_ENA;
@@ -430,7 +430,7 @@ void ath9k_hw_wow_enable(struct ath_hw *ah, u32 pattern_enable)
 		host_pm_ctrl |= AR_PMCTRL_PWR_STATE_D1D3_REAL;
 	}
 
-	REG_WRITE(ah, AR_PCIE_PM_CTRL, host_pm_ctrl);
+	REG_WRITE(ah, AR_PCIE_PM_CTRL(ah), host_pm_ctrl);
 
 	/*
 	 * Enable sequence number generation when asleep.
diff --git a/drivers/net/wireless/ath/ath9k/btcoex.c b/drivers/net/wireless/ath/ath9k/btcoex.c
index 618c9df35..9b393a8f7 100644
--- a/drivers/net/wireless/ath/ath9k/btcoex.c
+++ b/drivers/net/wireless/ath/ath9k/btcoex.c
@@ -173,16 +173,16 @@ void ath9k_hw_btcoex_init_2wire(struct ath_hw *ah)
 	struct ath_btcoex_hw *btcoex_hw = &ah->btcoex_hw;
 
 	/* connect bt_active to baseband */
-	REG_CLR_BIT(ah, AR_GPIO_INPUT_EN_VAL,
+	REG_CLR_BIT(ah, AR_GPIO_INPUT_EN_VAL(ah),
 		    (AR_GPIO_INPUT_EN_VAL_BT_PRIORITY_DEF |
 		     AR_GPIO_INPUT_EN_VAL_BT_FREQUENCY_DEF));
 
-	REG_SET_BIT(ah, AR_GPIO_INPUT_EN_VAL,
+	REG_SET_BIT(ah, AR_GPIO_INPUT_EN_VAL(ah),
 		    AR_GPIO_INPUT_EN_VAL_BT_ACTIVE_BB);
 
 	/* Set input mux for bt_active to gpio pin */
 	if (!AR_SREV_SOC(ah))
-		REG_RMW_FIELD(ah, AR_GPIO_INPUT_MUX1,
+		REG_RMW_FIELD(ah, AR_GPIO_INPUT_MUX1(ah),
 			      AR_GPIO_INPUT_MUX1_BT_ACTIVE,
 			      btcoex_hw->btactive_gpio);
 
@@ -197,17 +197,17 @@ void ath9k_hw_btcoex_init_3wire(struct ath_hw *ah)
 	struct ath_btcoex_hw *btcoex_hw = &ah->btcoex_hw;
 
 	/* btcoex 3-wire */
-	REG_SET_BIT(ah, AR_GPIO_INPUT_EN_VAL,
+	REG_SET_BIT(ah, AR_GPIO_INPUT_EN_VAL(ah),
 			(AR_GPIO_INPUT_EN_VAL_BT_PRIORITY_BB |
 			 AR_GPIO_INPUT_EN_VAL_BT_ACTIVE_BB));
 
 	/* Set input mux for bt_prority_async and
 	 *                  bt_active_async to GPIO pins */
 	if (!AR_SREV_SOC(ah)) {
-		REG_RMW_FIELD(ah, AR_GPIO_INPUT_MUX1,
+		REG_RMW_FIELD(ah, AR_GPIO_INPUT_MUX1(ah),
 			      AR_GPIO_INPUT_MUX1_BT_ACTIVE,
 			      btcoex_hw->btactive_gpio);
-		REG_RMW_FIELD(ah, AR_GPIO_INPUT_MUX1,
+		REG_RMW_FIELD(ah, AR_GPIO_INPUT_MUX1(ah),
 			      AR_GPIO_INPUT_MUX1_BT_PRIORITY,
 			      btcoex_hw->btpriority_gpio);
 	}
@@ -404,7 +404,7 @@ void ath9k_hw_btcoex_enable(struct ath_hw *ah)
 
 	if (ath9k_hw_get_btcoex_scheme(ah) != ATH_BTCOEX_CFG_MCI &&
 	    !AR_SREV_SOC(ah)) {
-		REG_RMW(ah, AR_GPIO_PDPU,
+		REG_RMW(ah, AR_GPIO_PDPU(ah),
 			(0x2 << (btcoex_hw->btactive_gpio * 2)),
 			(0x3 << (btcoex_hw->btactive_gpio * 2)));
 	}
diff --git a/drivers/net/wireless/ath/ath9k/calib.c b/drivers/net/wireless/ath/ath9k/calib.c
index 0422a3339..1a6548fdd 100644
--- a/drivers/net/wireless/ath/ath9k/calib.c
+++ b/drivers/net/wireless/ath/ath9k/calib.c
@@ -231,17 +231,17 @@ void ath9k_hw_start_nfcal(struct ath_hw *ah, bool update)
 	if (ah->caldata)
 		set_bit(NFCAL_PENDING, &ah->caldata->cal_flags);
 
-	REG_SET_BIT(ah, AR_PHY_AGC_CONTROL,
+	REG_SET_BIT(ah, AR_PHY_AGC_CONTROL(ah),
 		    AR_PHY_AGC_CONTROL_ENABLE_NF);
 
 	if (update)
-		REG_CLR_BIT(ah, AR_PHY_AGC_CONTROL,
+		REG_CLR_BIT(ah, AR_PHY_AGC_CONTROL(ah),
 		    AR_PHY_AGC_CONTROL_NO_UPDATE_NF);
 	else
-		REG_SET_BIT(ah, AR_PHY_AGC_CONTROL,
+		REG_SET_BIT(ah, AR_PHY_AGC_CONTROL(ah),
 		    AR_PHY_AGC_CONTROL_NO_UPDATE_NF);
 
-	REG_SET_BIT(ah, AR_PHY_AGC_CONTROL, AR_PHY_AGC_CONTROL_NF);
+	REG_SET_BIT(ah, AR_PHY_AGC_CONTROL(ah), AR_PHY_AGC_CONTROL_NF);
 }
 
 int ath9k_hw_loadnf(struct ath_hw *ah, struct ath9k_channel *chan)
@@ -251,7 +251,7 @@ int ath9k_hw_loadnf(struct ath_hw *ah, struct ath9k_channel *chan)
 	u8 chainmask = (ah->rxchainmask << 3) | ah->rxchainmask;
 	struct ath_common *common = ath9k_hw_common(ah);
 	s16 default_nf = ath9k_hw_get_nf_limits(ah, chan)->nominal;
-	u32 bb_agc_ctl = REG_READ(ah, AR_PHY_AGC_CONTROL);
+	u32 bb_agc_ctl = REG_READ(ah, AR_PHY_AGC_CONTROL(ah));
 
 	if (ah->caldata)
 		h = ah->caldata->nfCalHist;
@@ -286,7 +286,7 @@ int ath9k_hw_loadnf(struct ath_hw *ah, struct ath9k_channel *chan)
 	 * (or after end rx/tx frame if ongoing)
 	 */
 	if (bb_agc_ctl & AR_PHY_AGC_CONTROL_NF) {
-		REG_CLR_BIT(ah, AR_PHY_AGC_CONTROL, AR_PHY_AGC_CONTROL_NF);
+		REG_CLR_BIT(ah, AR_PHY_AGC_CONTROL(ah), AR_PHY_AGC_CONTROL_NF);
 		REG_RMW_BUFFER_FLUSH(ah);
 		ENABLE_REG_RMW_BUFFER(ah);
 	}
@@ -295,11 +295,11 @@ int ath9k_hw_loadnf(struct ath_hw *ah, struct ath9k_channel *chan)
 	 * Load software filtered NF value into baseband internal minCCApwr
 	 * variable.
 	 */
-	REG_CLR_BIT(ah, AR_PHY_AGC_CONTROL,
+	REG_CLR_BIT(ah, AR_PHY_AGC_CONTROL(ah),
 		    AR_PHY_AGC_CONTROL_ENABLE_NF);
-	REG_CLR_BIT(ah, AR_PHY_AGC_CONTROL,
+	REG_CLR_BIT(ah, AR_PHY_AGC_CONTROL(ah),
 		    AR_PHY_AGC_CONTROL_NO_UPDATE_NF);
-	REG_SET_BIT(ah, AR_PHY_AGC_CONTROL, AR_PHY_AGC_CONTROL_NF);
+	REG_SET_BIT(ah, AR_PHY_AGC_CONTROL(ah), AR_PHY_AGC_CONTROL_NF);
 	REG_RMW_BUFFER_FLUSH(ah);
 
 	/*
@@ -309,7 +309,7 @@ int ath9k_hw_loadnf(struct ath_hw *ah, struct ath9k_channel *chan)
 	 * (11n max length 22.1 msec)
 	 */
 	for (j = 0; j < 22200; j++) {
-		if ((REG_READ(ah, AR_PHY_AGC_CONTROL) &
+		if ((REG_READ(ah, AR_PHY_AGC_CONTROL(ah)) &
 			      AR_PHY_AGC_CONTROL_NF) == 0)
 			break;
 		udelay(10);
@@ -321,12 +321,12 @@ int ath9k_hw_loadnf(struct ath_hw *ah, struct ath9k_channel *chan)
 	if (bb_agc_ctl & AR_PHY_AGC_CONTROL_NF) {
 		ENABLE_REG_RMW_BUFFER(ah);
 		if (bb_agc_ctl & AR_PHY_AGC_CONTROL_ENABLE_NF)
-			REG_SET_BIT(ah, AR_PHY_AGC_CONTROL,
+			REG_SET_BIT(ah, AR_PHY_AGC_CONTROL(ah),
 				    AR_PHY_AGC_CONTROL_ENABLE_NF);
 		if (bb_agc_ctl & AR_PHY_AGC_CONTROL_NO_UPDATE_NF)
-			REG_SET_BIT(ah, AR_PHY_AGC_CONTROL,
+			REG_SET_BIT(ah, AR_PHY_AGC_CONTROL(ah),
 				    AR_PHY_AGC_CONTROL_NO_UPDATE_NF);
-		REG_SET_BIT(ah, AR_PHY_AGC_CONTROL, AR_PHY_AGC_CONTROL_NF);
+		REG_SET_BIT(ah, AR_PHY_AGC_CONTROL(ah), AR_PHY_AGC_CONTROL_NF);
 		REG_RMW_BUFFER_FLUSH(ah);
 	}
 
@@ -341,8 +341,8 @@ int ath9k_hw_loadnf(struct ath_hw *ah, struct ath9k_channel *chan)
 	 */
 	if (j == 22200) {
 		ath_dbg(common, ANY,
-			"Timeout while waiting for nf to load: AR_PHY_AGC_CONTROL=0x%x\n",
-			REG_READ(ah, AR_PHY_AGC_CONTROL));
+			"Timeout while waiting for nf to load: AR_PHY_AGC_CONTROL(ah)=0x%x\n",
+			REG_READ(ah, AR_PHY_AGC_CONTROL(ah)));
 		return -ETIMEDOUT;
 	}
 
@@ -410,7 +410,7 @@ bool ath9k_hw_getnf(struct ath_hw *ah, struct ath9k_channel *chan)
 	struct ieee80211_channel *c = chan->chan;
 	struct ath9k_hw_cal_data *caldata = ah->caldata;
 
-	if (REG_READ(ah, AR_PHY_AGC_CONTROL) & AR_PHY_AGC_CONTROL_NF) {
+	if (REG_READ(ah, AR_PHY_AGC_CONTROL(ah)) & AR_PHY_AGC_CONTROL_NF) {
 		ath_dbg(common, CALIBRATE,
 			"NF did not complete in calibration window\n");
 		return false;
@@ -478,7 +478,7 @@ void ath9k_hw_bstuck_nfcal(struct ath_hw *ah)
 	 */
 	if (!test_bit(NFCAL_PENDING, &caldata->cal_flags))
 		ath9k_hw_start_nfcal(ah, true);
-	else if (!(REG_READ(ah, AR_PHY_AGC_CONTROL) & AR_PHY_AGC_CONTROL_NF))
+	else if (!(REG_READ(ah, AR_PHY_AGC_CONTROL(ah)) & AR_PHY_AGC_CONTROL_NF))
 		ath9k_hw_getnf(ah, ah->curchan);
 
 	set_bit(NFCAL_INTF, &caldata->cal_flags);
diff --git a/drivers/net/wireless/ath/ath9k/eeprom.h b/drivers/net/wireless/ath/ath9k/eeprom.h
index 31390af6c..f1cde43fc 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom.h
+++ b/drivers/net/wireless/ath/ath9k/eeprom.h
@@ -68,8 +68,8 @@
 #define AR5416_EEPROM_OFFSET        0x2000
 #define AR5416_EEPROM_MAX           0xae0
 
-#define AR5416_EEPROM_START_ADDR \
-	(AR_SREV_9100(ah)) ? 0x1fff1000 : 0x503f1200
+#define AR5416_EEPROM_START_ADDR(_ah) \
+	(AR_SREV_9100(_ah)) ? 0x1fff1000 : 0x503f1200
 
 #define SD_NO_CTL               0xE0
 #define NO_CTL                  0xff
@@ -110,10 +110,10 @@
 #define FBIN2FREQ(x, y)		((y) ? (2300 + x) : (4800 + 5 * x))
 #define ath9k_hw_use_flash(_ah)	(!(_ah->ah_flags & AH_USE_EEPROM))
 
-#define OLC_FOR_AR9280_20_LATER (AR_SREV_9280_20_OR_LATER(ah) && \
-				 ah->eep_ops->get_eeprom(ah, EEP_OL_PWRCTRL))
-#define OLC_FOR_AR9287_10_LATER (AR_SREV_9287_11_OR_LATER(ah) && \
-				 ah->eep_ops->get_eeprom(ah, EEP_OL_PWRCTRL))
+#define OLC_FOR_AR9280_20_LATER(_ah) (AR_SREV_9280_20_OR_LATER(_ah) && \
+				 _ah->eep_ops->get_eeprom(_ah, EEP_OL_PWRCTRL))
+#define OLC_FOR_AR9287_10_LATER(_ah) (AR_SREV_9287_11_OR_LATER(_ah) && \
+				 _ah->eep_ops->get_eeprom(_ah, EEP_OL_PWRCTRL))
 
 #define EEP_RFSILENT_ENABLED        0x0001
 #define EEP_RFSILENT_ENABLED_S      0
diff --git a/drivers/net/wireless/ath/ath9k/eeprom_def.c b/drivers/net/wireless/ath/ath9k/eeprom_def.c
index 9729a69d3..7685f8ab3 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom_def.c
+++ b/drivers/net/wireless/ath/ath9k/eeprom_def.c
@@ -800,7 +800,7 @@ static void ath9k_hw_set_def_power_cal_table(struct ath_hw *ah,
 		numPiers = AR5416_NUM_5G_CAL_PIERS;
 	}
 
-	if (OLC_FOR_AR9280_20_LATER && IS_CHAN_2GHZ(chan)) {
+	if (OLC_FOR_AR9280_20_LATER(ah) && IS_CHAN_2GHZ(chan)) {
 		pRawDataset = pEepData->calPierData2G[0];
 		ah->initPDADC = ((struct calDataPerFreqOpLoop *)
 				 pRawDataset)->vpdPdg[0][0];
@@ -841,7 +841,7 @@ static void ath9k_hw_set_def_power_cal_table(struct ath_hw *ah,
 				pRawDataset = pEepData->calPierData5G[i];
 
 
-			if (OLC_FOR_AR9280_20_LATER) {
+			if (OLC_FOR_AR9280_20_LATER(ah)) {
 				u8 pcdacIdx;
 				u8 txPower;
 
@@ -869,7 +869,7 @@ static void ath9k_hw_set_def_power_cal_table(struct ath_hw *ah,
 
 			ENABLE_REGWRITE_BUFFER(ah);
 
-			if (OLC_FOR_AR9280_20_LATER) {
+			if (OLC_FOR_AR9280_20_LATER(ah)) {
 				REG_WRITE(ah,
 					AR_PHY_TPCRG5 + regChainOffset,
 					SM(0x6,
@@ -1203,7 +1203,7 @@ static void ath9k_hw_def_set_txpower(struct ath_hw *ah,
 		  | ATH9K_POW_SM(ratesArray[rate24mb], 0));
 
 	if (IS_CHAN_2GHZ(chan)) {
-		if (OLC_FOR_AR9280_20_LATER) {
+		if (OLC_FOR_AR9280_20_LATER(ah)) {
 			cck_ofdm_delta = 2;
 			REG_WRITE(ah, AR_PHY_POWER_TX_RATE3,
 				ATH9K_POW_SM(RT_AR_DELTA(rate2s), 24)
@@ -1259,7 +1259,7 @@ static void ath9k_hw_def_set_txpower(struct ath_hw *ah,
 					 ht40PowerIncForPdadc, 8)
 			  | ATH9K_POW_SM(ratesArray[rateHt40_4] +
 					 ht40PowerIncForPdadc, 0));
-		if (OLC_FOR_AR9280_20_LATER) {
+		if (OLC_FOR_AR9280_20_LATER(ah)) {
 			REG_WRITE(ah, AR_PHY_POWER_TX_RATE9,
 				ATH9K_POW_SM(ratesArray[rateExtOfdm], 24)
 				| ATH9K_POW_SM(RT_AR_DELTA(rateExtCck), 16)
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_init.c b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
index 07ac88fb1..0fb1b3f62 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_init.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
@@ -523,13 +523,13 @@ static bool ath_usb_eeprom_read(struct ath_common *common, u32 off, u16 *data)
 	(void)REG_READ(ah, AR5416_EEPROM_OFFSET + (off << AR5416_EEPROM_S));
 
 	if (!ath9k_hw_wait(ah,
-			   AR_EEPROM_STATUS_DATA,
+			   AR_EEPROM_STATUS_DATA(ah),
 			   AR_EEPROM_STATUS_DATA_BUSY |
 			   AR_EEPROM_STATUS_DATA_PROT_ACCESS, 0,
 			   AH_WAIT_TIMEOUT))
 		return false;
 
-	*data = MS(REG_READ(ah, AR_EEPROM_STATUS_DATA),
+	*data = MS(REG_READ(ah, AR_EEPROM_STATUS_DATA(ah)),
 		   AR_EEPROM_STATUS_DATA_VAL);
 
 	return true;
diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index 172081ffe..5982e0db4 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -266,7 +266,7 @@ static bool ath9k_hw_read_revisions(struct ath_hw *ah)
 	case AR9300_DEVID_AR9330:
 		ah->hw_version.macVersion = AR_SREV_VERSION_9330;
 		if (!ah->get_mac_revision) {
-			val = REG_READ(ah, AR_SREV);
+			val = REG_READ(ah, AR_SREV(ah));
 			ah->hw_version.macRev = MS(val, AR_SREV_REVISION2);
 		}
 		return true;
@@ -284,7 +284,7 @@ static bool ath9k_hw_read_revisions(struct ath_hw *ah)
 		return true;
 	}
 
-	srev = REG_READ(ah, AR_SREV);
+	srev = REG_READ(ah, AR_SREV(ah));
 
 	if (srev == -1) {
 		ath_err(ath9k_hw_common(ah),
@@ -292,7 +292,7 @@ static bool ath9k_hw_read_revisions(struct ath_hw *ah)
 		return false;
 	}
 
-	val = srev & AR_SREV_ID;
+	val = srev & AR_SREV_ID(ah);
 
 	if (val == 0xFF) {
 		val = srev;
@@ -601,12 +601,12 @@ static int __ath9k_hw_init(struct ath_hw *ah)
 	}
 
 	/*
-	 * Read back AR_WA into a permanent copy and set bits 14 and 17.
+	 * Read back AR_WA(ah) into a permanent copy and set bits 14 and 17.
 	 * We need to do this to avoid RMW of this register. We cannot
 	 * read the reg when chip is asleep.
 	 */
 	if (AR_SREV_9300_20_OR_LATER(ah)) {
-		ah->WARegVal = REG_READ(ah, AR_WA);
+		ah->WARegVal = REG_READ(ah, AR_WA(ah));
 		ah->WARegVal |= (AR_WA_D3_L1_DISABLE |
 				 AR_WA_ASPM_TIMER_BASED_DISABLE);
 	}
@@ -618,7 +618,7 @@ static int __ath9k_hw_init(struct ath_hw *ah)
 
 	if (AR_SREV_9565(ah)) {
 		ah->WARegVal |= AR_WA_BIT22;
-		REG_WRITE(ah, AR_WA, ah->WARegVal);
+		REG_WRITE(ah, AR_WA(ah), ah->WARegVal);
 	}
 
 	ath9k_hw_init_defaults(ah);
@@ -814,7 +814,7 @@ static void ath9k_hw_init_pll(struct ath_hw *ah,
 		REG_RMW_FIELD(ah, AR_CH0_DDR_DPLL3,
 			      AR_CH0_DPLL3_PHASE_SHIFT, 0x1);
 
-		REG_WRITE(ah, AR_RTC_PLL_CONTROL,
+		REG_WRITE(ah, AR_RTC_PLL_CONTROL(ah),
 			  pll | AR_RTC_9300_PLL_BYPASS);
 		udelay(1000);
 
@@ -832,7 +832,7 @@ static void ath9k_hw_init_pll(struct ath_hw *ah,
 		   AR_SREV_9561(ah)) {
 		u32 regval, pll2_divint, pll2_divfrac, refdiv;
 
-		REG_WRITE(ah, AR_RTC_PLL_CONTROL,
+		REG_WRITE(ah, AR_RTC_PLL_CONTROL(ah),
 			  pll | AR_RTC_9300_SOC_PLL_BYPASS);
 		udelay(1000);
 
@@ -911,7 +911,7 @@ static void ath9k_hw_init_pll(struct ath_hw *ah,
 
 	if (AR_SREV_9565(ah))
 		pll |= 0x40000;
-	REG_WRITE(ah, AR_RTC_PLL_CONTROL, pll);
+	REG_WRITE(ah, AR_RTC_PLL_CONTROL(ah), pll);
 
 	if (AR_SREV_9485(ah) || AR_SREV_9340(ah) || AR_SREV_9330(ah) ||
 	    AR_SREV_9550(ah))
@@ -925,7 +925,7 @@ static void ath9k_hw_init_pll(struct ath_hw *ah,
 
 	udelay(RTC_PLL_SETTLE_DELAY);
 
-	REG_WRITE(ah, AR_RTC_SLEEP_CLK, AR_RTC_FORCE_DERIVED_CLK);
+	REG_WRITE(ah, AR_RTC_SLEEP_CLK(ah), AR_RTC_FORCE_DERIVED_CLK);
 }
 
 static void ath9k_hw_init_interrupt_masks(struct ath_hw *ah,
@@ -977,7 +977,7 @@ static void ath9k_hw_init_interrupt_masks(struct ath_hw *ah,
 	REG_WRITE(ah, AR_IMR_S2, ah->imrs2_reg);
 
 	if (ah->msi_enabled) {
-		ah->msi_reg = REG_READ(ah, AR_PCIE_MSI);
+		ah->msi_reg = REG_READ(ah, AR_PCIE_MSI(ah));
 		ah->msi_reg |= AR_PCIE_MSI_HW_DBI_WR_EN;
 		ah->msi_reg &= AR_PCIE_MSI_HW_INT_PENDING_ADDR_MSI_64;
 		REG_WRITE(ah, AR_INTCFG, msi_cfg);
@@ -987,18 +987,18 @@ static void ath9k_hw_init_interrupt_masks(struct ath_hw *ah,
 	}
 
 	if (!AR_SREV_9100(ah)) {
-		REG_WRITE(ah, AR_INTR_SYNC_CAUSE, 0xFFFFFFFF);
-		REG_WRITE(ah, AR_INTR_SYNC_ENABLE, sync_default);
-		REG_WRITE(ah, AR_INTR_SYNC_MASK, 0);
+		REG_WRITE(ah, AR_INTR_SYNC_CAUSE(ah), 0xFFFFFFFF);
+		REG_WRITE(ah, AR_INTR_SYNC_ENABLE(ah), sync_default);
+		REG_WRITE(ah, AR_INTR_SYNC_MASK(ah), 0);
 	}
 
 	REGWRITE_BUFFER_FLUSH(ah);
 
 	if (AR_SREV_9300_20_OR_LATER(ah)) {
-		REG_WRITE(ah, AR_INTR_PRIO_ASYNC_ENABLE, 0);
-		REG_WRITE(ah, AR_INTR_PRIO_ASYNC_MASK, 0);
-		REG_WRITE(ah, AR_INTR_PRIO_SYNC_ENABLE, 0);
-		REG_WRITE(ah, AR_INTR_PRIO_SYNC_MASK, 0);
+		REG_WRITE(ah, AR_INTR_PRIO_ASYNC_ENABLE(ah), 0);
+		REG_WRITE(ah, AR_INTR_PRIO_ASYNC_MASK(ah), 0);
+		REG_WRITE(ah, AR_INTR_PRIO_SYNC_ENABLE(ah), 0);
+		REG_WRITE(ah, AR_INTR_PRIO_SYNC_MASK(ah), 0);
 	}
 }
 
@@ -1341,7 +1341,7 @@ static bool ath9k_hw_ar9330_reset_war(struct ath_hw *ah, int type)
 			return false;
 		}
 
-		REG_WRITE(ah, AR_RTC_RESET, 1);
+		REG_WRITE(ah, AR_RTC_RESET(ah), 1);
 	}
 
 	return true;
@@ -1353,26 +1353,26 @@ static bool ath9k_hw_set_reset(struct ath_hw *ah, int type)
 	u32 tmpReg;
 
 	if (AR_SREV_9100(ah)) {
-		REG_RMW_FIELD(ah, AR_RTC_DERIVED_CLK,
+		REG_RMW_FIELD(ah, AR_RTC_DERIVED_CLK(ah),
 			      AR_RTC_DERIVED_CLK_PERIOD, 1);
-		(void)REG_READ(ah, AR_RTC_DERIVED_CLK);
+		(void)REG_READ(ah, AR_RTC_DERIVED_CLK(ah));
 	}
 
 	ENABLE_REGWRITE_BUFFER(ah);
 
 	if (AR_SREV_9300_20_OR_LATER(ah)) {
-		REG_WRITE(ah, AR_WA, ah->WARegVal);
+		REG_WRITE(ah, AR_WA(ah), ah->WARegVal);
 		udelay(10);
 	}
 
-	REG_WRITE(ah, AR_RTC_FORCE_WAKE, AR_RTC_FORCE_WAKE_EN |
+	REG_WRITE(ah, AR_RTC_FORCE_WAKE(ah), AR_RTC_FORCE_WAKE_EN |
 		  AR_RTC_FORCE_WAKE_ON_INT);
 
 	if (AR_SREV_9100(ah)) {
 		rst_flags = AR_RTC_RC_MAC_WARM | AR_RTC_RC_MAC_COLD |
 			AR_RTC_RC_COLD_RESET | AR_RTC_RC_WARM_RESET;
 	} else {
-		tmpReg = REG_READ(ah, AR_INTR_SYNC_CAUSE);
+		tmpReg = REG_READ(ah, AR_INTR_SYNC_CAUSE(ah));
 		if (AR_SREV_9340(ah))
 			tmpReg &= AR9340_INTR_SYNC_LOCAL_TIMEOUT;
 		else
@@ -1381,7 +1381,7 @@ static bool ath9k_hw_set_reset(struct ath_hw *ah, int type)
 
 		if (tmpReg) {
 			u32 val;
-			REG_WRITE(ah, AR_INTR_SYNC_ENABLE, 0);
+			REG_WRITE(ah, AR_INTR_SYNC_ENABLE(ah), 0);
 
 			val = AR_RC_HOSTIF;
 			if (!AR_SREV_9300_20_OR_LATER(ah))
@@ -1414,7 +1414,7 @@ static bool ath9k_hw_set_reset(struct ath_hw *ah, int type)
 		REG_CLR_BIT(ah, AR_CFG, AR_CFG_HALT_REQ);
 	}
 
-	REG_WRITE(ah, AR_RTC_RC, rst_flags);
+	REG_WRITE(ah, AR_RTC_RC(ah), rst_flags);
 
 	REGWRITE_BUFFER_FLUSH(ah);
 
@@ -1425,8 +1425,8 @@ static bool ath9k_hw_set_reset(struct ath_hw *ah, int type)
 	else
 		udelay(100);
 
-	REG_WRITE(ah, AR_RTC_RC, 0);
-	if (!ath9k_hw_wait(ah, AR_RTC_RC, AR_RTC_RC_M, 0, AH_WAIT_TIMEOUT)) {
+	REG_WRITE(ah, AR_RTC_RC(ah), 0);
+	if (!ath9k_hw_wait(ah, AR_RTC_RC(ah), AR_RTC_RC_M, 0, AH_WAIT_TIMEOUT)) {
 		ath_dbg(ath9k_hw_common(ah), RESET, "RTC stuck in MAC reset\n");
 		return false;
 	}
@@ -1445,17 +1445,17 @@ static bool ath9k_hw_set_reset_power_on(struct ath_hw *ah)
 	ENABLE_REGWRITE_BUFFER(ah);
 
 	if (AR_SREV_9300_20_OR_LATER(ah)) {
-		REG_WRITE(ah, AR_WA, ah->WARegVal);
+		REG_WRITE(ah, AR_WA(ah), ah->WARegVal);
 		udelay(10);
 	}
 
-	REG_WRITE(ah, AR_RTC_FORCE_WAKE, AR_RTC_FORCE_WAKE_EN |
+	REG_WRITE(ah, AR_RTC_FORCE_WAKE(ah), AR_RTC_FORCE_WAKE_EN |
 		  AR_RTC_FORCE_WAKE_ON_INT);
 
 	if (!AR_SREV_9100(ah) && !AR_SREV_9300_20_OR_LATER(ah))
 		REG_WRITE(ah, AR_RC, AR_RC_AHB);
 
-	REG_WRITE(ah, AR_RTC_RESET, 0);
+	REG_WRITE(ah, AR_RTC_RESET(ah), 0);
 
 	REGWRITE_BUFFER_FLUSH(ah);
 
@@ -1464,11 +1464,11 @@ static bool ath9k_hw_set_reset_power_on(struct ath_hw *ah)
 	if (!AR_SREV_9100(ah) && !AR_SREV_9300_20_OR_LATER(ah))
 		REG_WRITE(ah, AR_RC, 0);
 
-	REG_WRITE(ah, AR_RTC_RESET, 1);
+	REG_WRITE(ah, AR_RTC_RESET(ah), 1);
 
 	if (!ath9k_hw_wait(ah,
-			   AR_RTC_STATUS,
-			   AR_RTC_STATUS_M,
+			   AR_RTC_STATUS(ah),
+			   AR_RTC_STATUS_M(ah),
 			   AR_RTC_STATUS_ON,
 			   AH_WAIT_TIMEOUT)) {
 		ath_dbg(ath9k_hw_common(ah), RESET, "RTC not waking up\n");
@@ -1483,11 +1483,11 @@ static bool ath9k_hw_set_reset_reg(struct ath_hw *ah, u32 type)
 	bool ret = false;
 
 	if (AR_SREV_9300_20_OR_LATER(ah)) {
-		REG_WRITE(ah, AR_WA, ah->WARegVal);
+		REG_WRITE(ah, AR_WA(ah), ah->WARegVal);
 		udelay(10);
 	}
 
-	REG_WRITE(ah, AR_RTC_FORCE_WAKE,
+	REG_WRITE(ah, AR_RTC_FORCE_WAKE(ah),
 		  AR_RTC_FORCE_WAKE_EN | AR_RTC_FORCE_WAKE_ON_INT);
 
 	if (!ah->reset_power_on)
@@ -1521,7 +1521,7 @@ static bool ath9k_hw_chip_reset(struct ath_hw *ah,
 		else
 			reset_type = ATH9K_RESET_COLD;
 	} else if (ah->chip_fullsleep || REG_READ(ah, AR_Q_TXE) ||
-		   (REG_READ(ah, AR_CR) & AR_CR_RXE))
+		   (REG_READ(ah, AR_CR) & AR_CR_RXE(ah)))
 		reset_type = ATH9K_RESET_COLD;
 
 	if (!ath9k_hw_set_reset_reg(ah, reset_type))
@@ -1955,7 +1955,7 @@ int ath9k_hw_reset(struct ath_hw *ah, struct ath9k_channel *chan,
 	ath9k_hw_settsf64(ah, tsf + tsf_offset);
 
 	if (AR_SREV_9280_20_OR_LATER(ah))
-		REG_SET_BIT(ah, AR_GPIO_INPUT_EN_VAL, AR_GPIO_JTAG_DISABLE);
+		REG_SET_BIT(ah, AR_GPIO_INPUT_EN_VAL(ah), AR_GPIO_JTAG_DISABLE);
 
 	if (!AR_SREV_9300_20_OR_LATER(ah))
 		ar9002_hw_enable_async_fifo(ah);
@@ -2017,7 +2017,7 @@ int ath9k_hw_reset(struct ath_hw *ah, struct ath9k_channel *chan,
 	ath9k_hw_set_dma(ah);
 
 	if (!ath9k_hw_mci_is_enabled(ah))
-		REG_WRITE(ah, AR_OBS, 8);
+		REG_WRITE(ah, AR_OBS(ah), 8);
 
 	ENABLE_REG_RMW_BUFFER(ah);
 	if (ah->config.rx_intr_mitigation) {
@@ -2111,7 +2111,7 @@ static void ath9k_set_power_sleep(struct ath_hw *ah)
 	 * Clear the RTC force wake bit to allow the
 	 * mac to go to sleep.
 	 */
-	REG_CLR_BIT(ah, AR_RTC_FORCE_WAKE, AR_RTC_FORCE_WAKE_EN);
+	REG_CLR_BIT(ah, AR_RTC_FORCE_WAKE(ah), AR_RTC_FORCE_WAKE_EN);
 
 	if (ath9k_hw_mci_is_enabled(ah))
 		udelay(100);
@@ -2121,13 +2121,13 @@ static void ath9k_set_power_sleep(struct ath_hw *ah)
 
 	/* Shutdown chip. Active low */
 	if (!AR_SREV_5416(ah) && !AR_SREV_9271(ah)) {
-		REG_CLR_BIT(ah, AR_RTC_RESET, AR_RTC_RESET_EN);
+		REG_CLR_BIT(ah, AR_RTC_RESET(ah), AR_RTC_RESET_EN);
 		udelay(2);
 	}
 
-	/* Clear Bit 14 of AR_WA after putting chip into Full Sleep mode. */
+	/* Clear Bit 14 of AR_WA(ah) after putting chip into Full Sleep mode. */
 	if (AR_SREV_9300_20_OR_LATER(ah))
-		REG_WRITE(ah, AR_WA, ah->WARegVal & ~AR_WA_D3_L1_DISABLE);
+		REG_WRITE(ah, AR_WA(ah), ah->WARegVal & ~AR_WA_D3_L1_DISABLE);
 }
 
 /*
@@ -2143,7 +2143,7 @@ static void ath9k_set_power_network_sleep(struct ath_hw *ah)
 
 	if (!(pCap->hw_caps & ATH9K_HW_CAP_AUTOSLEEP)) {
 		/* Set WakeOnInterrupt bit; clear ForceWake bit */
-		REG_WRITE(ah, AR_RTC_FORCE_WAKE,
+		REG_WRITE(ah, AR_RTC_FORCE_WAKE(ah),
 			  AR_RTC_FORCE_WAKE_ON_INT);
 	} else {
 
@@ -2163,15 +2163,15 @@ static void ath9k_set_power_network_sleep(struct ath_hw *ah)
 		 * Clear the RTC force wake bit to allow the
 		 * mac to go to sleep.
 		 */
-		REG_CLR_BIT(ah, AR_RTC_FORCE_WAKE, AR_RTC_FORCE_WAKE_EN);
+		REG_CLR_BIT(ah, AR_RTC_FORCE_WAKE(ah), AR_RTC_FORCE_WAKE_EN);
 
 		if (ath9k_hw_mci_is_enabled(ah))
 			udelay(30);
 	}
 
-	/* Clear Bit 14 of AR_WA after putting chip into Net Sleep mode. */
+	/* Clear Bit 14 of AR_WA(ah) after putting chip into Net Sleep mode. */
 	if (AR_SREV_9300_20_OR_LATER(ah))
-		REG_WRITE(ah, AR_WA, ah->WARegVal & ~AR_WA_D3_L1_DISABLE);
+		REG_WRITE(ah, AR_WA(ah), ah->WARegVal & ~AR_WA_D3_L1_DISABLE);
 }
 
 static bool ath9k_hw_set_power_awake(struct ath_hw *ah)
@@ -2179,14 +2179,14 @@ static bool ath9k_hw_set_power_awake(struct ath_hw *ah)
 	u32 val;
 	int i;
 
-	/* Set Bits 14 and 17 of AR_WA before powering on the chip. */
+	/* Set Bits 14 and 17 of AR_WA(ah) before powering on the chip. */
 	if (AR_SREV_9300_20_OR_LATER(ah)) {
-		REG_WRITE(ah, AR_WA, ah->WARegVal);
+		REG_WRITE(ah, AR_WA(ah), ah->WARegVal);
 		udelay(10);
 	}
 
-	if ((REG_READ(ah, AR_RTC_STATUS) &
-	     AR_RTC_STATUS_M) == AR_RTC_STATUS_SHUTDOWN) {
+	if ((REG_READ(ah, AR_RTC_STATUS(ah)) &
+	     AR_RTC_STATUS_M(ah)) == AR_RTC_STATUS_SHUTDOWN) {
 		if (!ath9k_hw_set_reset_reg(ah, ATH9K_RESET_POWER_ON)) {
 			return false;
 		}
@@ -2194,10 +2194,10 @@ static bool ath9k_hw_set_power_awake(struct ath_hw *ah)
 			ath9k_hw_init_pll(ah, NULL);
 	}
 	if (AR_SREV_9100(ah))
-		REG_SET_BIT(ah, AR_RTC_RESET,
+		REG_SET_BIT(ah, AR_RTC_RESET(ah),
 			    AR_RTC_RESET_EN);
 
-	REG_SET_BIT(ah, AR_RTC_FORCE_WAKE,
+	REG_SET_BIT(ah, AR_RTC_FORCE_WAKE(ah),
 		    AR_RTC_FORCE_WAKE_EN);
 	if (AR_SREV_9100(ah))
 		mdelay(10);
@@ -2205,11 +2205,11 @@ static bool ath9k_hw_set_power_awake(struct ath_hw *ah)
 		udelay(50);
 
 	for (i = POWER_UP_TIME / 50; i > 0; i--) {
-		val = REG_READ(ah, AR_RTC_STATUS) & AR_RTC_STATUS_M;
+		val = REG_READ(ah, AR_RTC_STATUS(ah)) & AR_RTC_STATUS_M(ah);
 		if (val == AR_RTC_STATUS_ON)
 			break;
 		udelay(50);
-		REG_SET_BIT(ah, AR_RTC_FORCE_WAKE,
+		REG_SET_BIT(ah, AR_RTC_FORCE_WAKE(ah),
 			    AR_RTC_FORCE_WAKE_EN);
 	}
 	if (i == 0) {
@@ -2701,16 +2701,16 @@ static void ath9k_hw_gpio_cfg_output_mux(struct ath_hw *ah, u32 gpio, u32 type)
 	u32 gpio_shift, tmp;
 
 	if (gpio > 11)
-		addr = AR_GPIO_OUTPUT_MUX3;
+		addr = AR_GPIO_OUTPUT_MUX3(ah);
 	else if (gpio > 5)
-		addr = AR_GPIO_OUTPUT_MUX2;
+		addr = AR_GPIO_OUTPUT_MUX2(ah);
 	else
-		addr = AR_GPIO_OUTPUT_MUX1;
+		addr = AR_GPIO_OUTPUT_MUX1(ah);
 
 	gpio_shift = (gpio % 6) * 5;
 
 	if (AR_SREV_9280_20_OR_LATER(ah) ||
-	    (addr != AR_GPIO_OUTPUT_MUX1)) {
+	    (addr != AR_GPIO_OUTPUT_MUX1(ah))) {
 		REG_RMW(ah, addr, (type << gpio_shift),
 			(0x1f << gpio_shift));
 	} else {
@@ -2754,13 +2754,13 @@ static void ath9k_hw_gpio_cfg_wmac(struct ath_hw *ah, u32 gpio, bool out,
 			AR7010_GPIO_OE_MASK << gpio_shift);
 	} else if (AR_SREV_SOC(ah)) {
 		gpio_set = out ? 1 : 0;
-		REG_RMW(ah, AR_GPIO_OE_OUT, gpio_set << gpio_shift,
+		REG_RMW(ah, AR_GPIO_OE_OUT(ah), gpio_set << gpio_shift,
 			gpio_set << gpio_shift);
 	} else {
 		gpio_shift = gpio << 1;
 		gpio_set = out ?
 			AR_GPIO_OE_OUT_DRV_ALL : AR_GPIO_OE_OUT_DRV_NO;
-		REG_RMW(ah, AR_GPIO_OE_OUT, gpio_set << gpio_shift,
+		REG_RMW(ah, AR_GPIO_OE_OUT(ah), gpio_set << gpio_shift,
 			AR_GPIO_OE_OUT_DRV << gpio_shift);
 
 		if (out)
@@ -2813,7 +2813,7 @@ u32 ath9k_hw_gpio_get(struct ath_hw *ah, u32 gpio)
 	u32 val = 0xffffffff;
 
 #define MS_REG_READ(x, y) \
-	(MS(REG_READ(ah, AR_GPIO_IN_OUT), x##_GPIO_IN_VAL) & BIT(y))
+	(MS(REG_READ(ah, AR_GPIO_IN_OUT(ah)), x##_GPIO_IN_VAL) & BIT(y))
 
 	WARN_ON(gpio >= ah->caps.num_gpio_pins);
 
@@ -2829,7 +2829,7 @@ u32 ath9k_hw_gpio_get(struct ath_hw *ah, u32 gpio)
 		else if (AR_DEVID_7010(ah))
 			val = REG_READ(ah, AR7010_GPIO_IN) & BIT(gpio);
 		else if (AR_SREV_9300_20_OR_LATER(ah))
-			val = REG_READ(ah, AR_GPIO_IN) & BIT(gpio);
+			val = REG_READ(ah, AR_GPIO_IN(ah)) & BIT(gpio);
 		else
 			val = MS_REG_READ(AR, gpio);
 	} else if (BIT(gpio) & ah->caps.gpio_requested) {
@@ -2853,7 +2853,7 @@ void ath9k_hw_set_gpio(struct ath_hw *ah, u32 gpio, u32 val)
 
 	if (BIT(gpio) & ah->caps.gpio_mask) {
 		u32 out_addr = AR_DEVID_7010(ah) ?
-			AR7010_GPIO_OUT : AR_GPIO_IN_OUT;
+			AR7010_GPIO_OUT : AR_GPIO_IN_OUT(ah);
 
 		REG_RMW(ah, out_addr, val << gpio, BIT(gpio));
 	} else if (BIT(gpio) & ah->caps.gpio_requested) {
diff --git a/drivers/net/wireless/ath/ath9k/mac.c b/drivers/net/wireless/ath/ath9k/mac.c
index 58d02c19b..b070403e0 100644
--- a/drivers/net/wireless/ath/ath9k/mac.c
+++ b/drivers/net/wireless/ath/ath9k/mac.c
@@ -707,7 +707,7 @@ bool ath9k_hw_stopdmarecv(struct ath_hw *ah, bool *reset)
 
 	/* Wait for rx enable bit to go low */
 	for (i = AH_RX_STOP_DMA_TIMEOUT / AH_TIME_QUANTUM; i != 0; i--) {
-		if ((REG_READ(ah, AR_CR) & AR_CR_RXE) == 0)
+		if ((REG_READ(ah, AR_CR) & AR_CR_RXE(ah)) == 0)
 			break;
 
 		if (!AR_SREV_9300_20_OR_LATER(ah)) {
@@ -762,14 +762,14 @@ bool ath9k_hw_intrpend(struct ath_hw *ah)
 	if (AR_SREV_9100(ah))
 		return true;
 
-	host_isr = REG_READ(ah, AR_INTR_ASYNC_CAUSE);
+	host_isr = REG_READ(ah, AR_INTR_ASYNC_CAUSE(ah));
 
 	if (((host_isr & AR_INTR_MAC_IRQ) ||
 	     (host_isr & AR_INTR_ASYNC_MASK_MCI)) &&
 	    (host_isr != AR_INTR_SPURIOUS))
 		return true;
 
-	host_isr = REG_READ(ah, AR_INTR_SYNC_CAUSE);
+	host_isr = REG_READ(ah, AR_INTR_SYNC_CAUSE(ah));
 	if ((host_isr & AR_INTR_SYNC_DEFAULT)
 	    && (host_isr != AR_INTR_SPURIOUS))
 		return true;
@@ -786,11 +786,11 @@ void ath9k_hw_kill_interrupts(struct ath_hw *ah)
 	REG_WRITE(ah, AR_IER, AR_IER_DISABLE);
 	(void) REG_READ(ah, AR_IER);
 	if (!AR_SREV_9100(ah)) {
-		REG_WRITE(ah, AR_INTR_ASYNC_ENABLE, 0);
-		(void) REG_READ(ah, AR_INTR_ASYNC_ENABLE);
+		REG_WRITE(ah, AR_INTR_ASYNC_ENABLE(ah), 0);
+		(void) REG_READ(ah, AR_INTR_ASYNC_ENABLE(ah));
 
-		REG_WRITE(ah, AR_INTR_SYNC_ENABLE, 0);
-		(void) REG_READ(ah, AR_INTR_SYNC_ENABLE);
+		REG_WRITE(ah, AR_INTR_SYNC_ENABLE(ah), 0);
+		(void) REG_READ(ah, AR_INTR_SYNC_ENABLE(ah));
 	}
 }
 EXPORT_SYMBOL(ath9k_hw_kill_interrupts);
@@ -824,11 +824,11 @@ static void __ath9k_hw_enable_interrupts(struct ath_hw *ah)
 	ath_dbg(common, INTERRUPT, "enable IER\n");
 	REG_WRITE(ah, AR_IER, AR_IER_ENABLE);
 	if (!AR_SREV_9100(ah)) {
-		REG_WRITE(ah, AR_INTR_ASYNC_ENABLE, async_mask);
-		REG_WRITE(ah, AR_INTR_ASYNC_MASK, async_mask);
+		REG_WRITE(ah, AR_INTR_ASYNC_ENABLE(ah), async_mask);
+		REG_WRITE(ah, AR_INTR_ASYNC_MASK(ah), async_mask);
 
-		REG_WRITE(ah, AR_INTR_SYNC_ENABLE, sync_default);
-		REG_WRITE(ah, AR_INTR_SYNC_MASK, sync_default);
+		REG_WRITE(ah, AR_INTR_SYNC_ENABLE(ah), sync_default);
+		REG_WRITE(ah, AR_INTR_SYNC_MASK(ah), sync_default);
 	}
 	ath_dbg(common, INTERRUPT, "AR_IMR 0x%x IER 0x%x\n",
 		REG_READ(ah, AR_IMR), REG_READ(ah, AR_IER));
@@ -841,26 +841,26 @@ static void __ath9k_hw_enable_interrupts(struct ath_hw *ah)
 		ath_dbg(ath9k_hw_common(ah), INTERRUPT,
 			"Enabling MSI, msi_mask=0x%X\n", ah->msi_mask);
 
-		REG_WRITE(ah, AR_INTR_PRIO_ASYNC_ENABLE, ah->msi_mask);
-		REG_WRITE(ah, AR_INTR_PRIO_ASYNC_MASK, ah->msi_mask);
+		REG_WRITE(ah, AR_INTR_PRIO_ASYNC_ENABLE(ah), ah->msi_mask);
+		REG_WRITE(ah, AR_INTR_PRIO_ASYNC_MASK(ah), ah->msi_mask);
 		ath_dbg(ath9k_hw_common(ah), INTERRUPT,
 			"AR_INTR_PRIO_ASYNC_ENABLE=0x%X, AR_INTR_PRIO_ASYNC_MASK=0x%X\n",
-			REG_READ(ah, AR_INTR_PRIO_ASYNC_ENABLE),
-			REG_READ(ah, AR_INTR_PRIO_ASYNC_MASK));
+			REG_READ(ah, AR_INTR_PRIO_ASYNC_ENABLE(ah)),
+			REG_READ(ah, AR_INTR_PRIO_ASYNC_MASK(ah)));
 
 		if (ah->msi_reg == 0)
-			ah->msi_reg = REG_READ(ah, AR_PCIE_MSI);
+			ah->msi_reg = REG_READ(ah, AR_PCIE_MSI(ah));
 
 		ath_dbg(ath9k_hw_common(ah), INTERRUPT,
 			"AR_PCIE_MSI=0x%X, ah->msi_reg = 0x%X\n",
-			AR_PCIE_MSI, ah->msi_reg);
+			AR_PCIE_MSI(ah), ah->msi_reg);
 
 		i = 0;
 		do {
-			REG_WRITE(ah, AR_PCIE_MSI,
+			REG_WRITE(ah, AR_PCIE_MSI(ah),
 				  (ah->msi_reg | AR_PCIE_MSI_ENABLE)
 				  & msi_pend_addr_mask);
-			_msi_reg = REG_READ(ah, AR_PCIE_MSI);
+			_msi_reg = REG_READ(ah, AR_PCIE_MSI(ah));
 			i++;
 		} while ((_msi_reg & AR_PCIE_MSI_ENABLE) == 0 && i < 200);
 
@@ -918,8 +918,8 @@ void ath9k_hw_set_interrupts(struct ath_hw *ah)
 	if (ah->msi_enabled) {
 		ath_dbg(common, INTERRUPT, "Clearing AR_INTR_PRIO_ASYNC_ENABLE\n");
 
-		REG_WRITE(ah, AR_INTR_PRIO_ASYNC_ENABLE, 0);
-		REG_READ(ah, AR_INTR_PRIO_ASYNC_ENABLE);
+		REG_WRITE(ah, AR_INTR_PRIO_ASYNC_ENABLE(ah), 0);
+		REG_READ(ah, AR_INTR_PRIO_ASYNC_ENABLE(ah));
 	}
 
 	ath_dbg(common, INTERRUPT, "New interrupt mask 0x%x\n", ints);
diff --git a/drivers/net/wireless/ath/ath9k/pci.c b/drivers/net/wireless/ath/ath9k/pci.c
index a074e2301..a09f9d223 100644
--- a/drivers/net/wireless/ath/ath9k/pci.c
+++ b/drivers/net/wireless/ath/ath9k/pci.c
@@ -804,14 +804,14 @@ static bool ath_pci_eeprom_read(struct ath_common *common, u32 off, u16 *data)
 	common->ops->read(ah, AR5416_EEPROM_OFFSET + (off << AR5416_EEPROM_S));
 
 	if (!ath9k_hw_wait(ah,
-				AR_EEPROM_STATUS_DATA,
+				AR_EEPROM_STATUS_DATA(ah),
 				AR_EEPROM_STATUS_DATA_BUSY |
 				AR_EEPROM_STATUS_DATA_PROT_ACCESS, 0,
 				AH_WAIT_TIMEOUT)) {
 		return false;
 	}
 
-	*data = MS(common->ops->read(ah, AR_EEPROM_STATUS_DATA),
+	*data = MS(common->ops->read(ah, AR_EEPROM_STATUS_DATA(ah)),
 			AR_EEPROM_STATUS_DATA_VAL);
 
 	return true;
diff --git a/drivers/net/wireless/ath/ath9k/reg.h b/drivers/net/wireless/ath/ath9k/reg.h
index 8983ea6fc..9f5b8a538 100644
--- a/drivers/net/wireless/ath/ath9k/reg.h
+++ b/drivers/net/wireless/ath/ath9k/reg.h
@@ -20,7 +20,7 @@
 #include "../reg.h"
 
 #define AR_CR                0x0008
-#define AR_CR_RXE            (AR_SREV_9300_20_OR_LATER(ah) ? 0x0000000c : 0x00000004)
+#define AR_CR_RXE(_ah)       (AR_SREV_9300_20_OR_LATER(_ah) ? 0x0000000c : 0x00000004)
 #define AR_CR_RXD            0x00000020
 #define AR_CR_SWI            0x00000040
 
@@ -352,10 +352,10 @@
 #define AR_ISR_S1_QCU_TXEOL    0x03FF0000
 #define AR_ISR_S1_QCU_TXEOL_S  16
 
-#define AR_ISR_S2_S           (AR_SREV_9300_20_OR_LATER(ah) ? 0x00d0 : 0x00cc)
-#define AR_ISR_S3_S           (AR_SREV_9300_20_OR_LATER(ah) ? 0x00d4 : 0x00d0)
-#define AR_ISR_S4_S           (AR_SREV_9300_20_OR_LATER(ah) ? 0x00d8 : 0x00d4)
-#define AR_ISR_S5_S           (AR_SREV_9300_20_OR_LATER(ah) ? 0x00dc : 0x00d8)
+#define AR_ISR_S2_S(_ah)      (AR_SREV_9300_20_OR_LATER(_ah) ? 0x00d0 : 0x00cc)
+#define AR_ISR_S3_S(_ah)      (AR_SREV_9300_20_OR_LATER(_ah) ? 0x00d4 : 0x00d0)
+#define AR_ISR_S4_S(_ah)      (AR_SREV_9300_20_OR_LATER(_ah) ? 0x00d8 : 0x00d4)
+#define AR_ISR_S5_S(_ah)      (AR_SREV_9300_20_OR_LATER(_ah) ? 0x00dc : 0x00d8)
 #define AR_DMADBG_0           0x00e0
 #define AR_DMADBG_1           0x00e4
 #define AR_DMADBG_2           0x00e8
@@ -699,7 +699,7 @@
 #define AR_RC_APB            0x00000002
 #define AR_RC_HOSTIF         0x00000100
 
-#define AR_WA			(AR_SREV_9340(ah) ? 0x40c4 : 0x4004)
+#define AR_WA(_ah)			(AR_SREV_9340(_ah) ? 0x40c4 : 0x4004)
 #define AR_WA_BIT6			(1 << 6)
 #define AR_WA_BIT7			(1 << 7)
 #define AR_WA_BIT23			(1 << 23)
@@ -721,7 +721,7 @@
 #define AR_PM_STATE                 0x4008
 #define AR_PM_STATE_PME_D3COLD_VAUX 0x00100000
 
-#define AR_HOST_TIMEOUT             (AR_SREV_9340(ah) ? 0x4008 : 0x4018)
+#define AR_HOST_TIMEOUT(_ah)        (AR_SREV_9340(_ah) ? 0x4008 : 0x4018)
 #define AR_HOST_TIMEOUT_APB_CNTR    0x0000FFFF
 #define AR_HOST_TIMEOUT_APB_CNTR_S  0
 #define AR_HOST_TIMEOUT_LCL_CNTR    0xFFFF0000
@@ -750,12 +750,12 @@
 #define EEPROM_PROTECT_RP_1024_2047   0x4000
 #define EEPROM_PROTECT_WP_1024_2047   0x8000
 
-#define AR_SREV \
-	((AR_SREV_9100(ah)) ? 0x0600 : (AR_SREV_9340(ah) \
+#define AR_SREV(_ah) \
+	((AR_SREV_9100(_ah)) ? 0x0600 : (AR_SREV_9340(_ah) \
 					? 0x400c : 0x4020))
 
-#define AR_SREV_ID \
-	((AR_SREV_9100(ah)) ? 0x00000FFF : 0x000000FF)
+#define AR_SREV_ID(_ah) \
+	((AR_SREV_9100(_ah)) ? 0x00000FFF : 0x000000FF)
 #define AR_SREV_VERSION                       0x000000F0
 #define AR_SREV_VERSION_S                     4
 #define AR_SREV_REVISION                      0x00000007
@@ -1038,11 +1038,11 @@ enum ath_usb_dev {
 #define AR_INTR_SPURIOUS                      0xFFFFFFFF
 
 
-#define AR_INTR_SYNC_CAUSE                    (AR_SREV_9340(ah) ? 0x4010 : 0x4028)
-#define AR_INTR_SYNC_CAUSE_CLR                (AR_SREV_9340(ah) ? 0x4010 : 0x4028)
+#define AR_INTR_SYNC_CAUSE(_ah)               (AR_SREV_9340(_ah) ? 0x4010 : 0x4028)
+#define AR_INTR_SYNC_CAUSE_CLR(_ah)           (AR_SREV_9340(_ah) ? 0x4010 : 0x4028)
 
 
-#define AR_INTR_SYNC_ENABLE                   (AR_SREV_9340(ah) ? 0x4014 : 0x402c)
+#define AR_INTR_SYNC_ENABLE(_ah)              (AR_SREV_9340(_ah) ? 0x4014 : 0x402c)
 #define AR_INTR_SYNC_ENABLE_GPIO              0xFFFC0000
 #define AR_INTR_SYNC_ENABLE_GPIO_S            18
 
@@ -1084,18 +1084,18 @@ enum {
 
 };
 
-#define AR_INTR_ASYNC_MASK                       (AR_SREV_9340(ah) ? 0x4018 : 0x4030)
+#define AR_INTR_ASYNC_MASK(_ah)                  (AR_SREV_9340(_ah) ? 0x4018 : 0x4030)
 #define AR_INTR_ASYNC_MASK_GPIO                  0xFFFC0000
 #define AR_INTR_ASYNC_MASK_GPIO_S                18
 #define AR_INTR_ASYNC_MASK_MCI                   0x00000080
 #define AR_INTR_ASYNC_MASK_MCI_S                 7
 
-#define AR_INTR_SYNC_MASK                        (AR_SREV_9340(ah) ? 0x401c : 0x4034)
+#define AR_INTR_SYNC_MASK(_ah)                   (AR_SREV_9340(_ah) ? 0x401c : 0x4034)
 #define AR_INTR_SYNC_MASK_GPIO                   0xFFFC0000
 #define AR_INTR_SYNC_MASK_GPIO_S                 18
 
-#define AR_INTR_ASYNC_CAUSE_CLR                  (AR_SREV_9340(ah) ? 0x4020 : 0x4038)
-#define AR_INTR_ASYNC_CAUSE                      (AR_SREV_9340(ah) ? 0x4020 : 0x4038)
+#define AR_INTR_ASYNC_CAUSE_CLR(_ah)             (AR_SREV_9340(_ah) ? 0x4020 : 0x4038)
+#define AR_INTR_ASYNC_CAUSE(_ah)                 (AR_SREV_9340(_ah) ? 0x4020 : 0x4038)
 #define AR_INTR_ASYNC_CAUSE_MCI			 0x00000080
 #define AR_INTR_ASYNC_USED			 (AR_INTR_MAC_IRQ | \
 						  AR_INTR_ASYNC_CAUSE_MCI)
@@ -1105,13 +1105,13 @@ enum {
 #define AR_INTR_ASYNC_ENABLE_MCI_S       7
 
 
-#define AR_INTR_ASYNC_ENABLE                     (AR_SREV_9340(ah) ? 0x4024 : 0x403c)
+#define AR_INTR_ASYNC_ENABLE(_ah)                (AR_SREV_9340(_ah) ? 0x4024 : 0x403c)
 #define AR_INTR_ASYNC_ENABLE_GPIO                0xFFFC0000
 #define AR_INTR_ASYNC_ENABLE_GPIO_S              18
 
 #define AR_PCIE_SERDES                           0x4040
 #define AR_PCIE_SERDES2                          0x4044
-#define AR_PCIE_PM_CTRL                          (AR_SREV_9340(ah) ? 0x4004 : 0x4014)
+#define AR_PCIE_PM_CTRL(_ah)                     (AR_SREV_9340(_ah) ? 0x4004 : 0x4014)
 #define AR_PCIE_PM_CTRL_ENA                      0x00080000
 
 #define AR_PCIE_PHY_REG3			 0x18c08
@@ -1156,7 +1156,7 @@ enum {
 #define AR9580_GPIO_MASK			 0x0000F4FF
 #define AR7010_GPIO_MASK			 0x0000FFFF
 
-#define AR_GPIO_IN_OUT                           (AR_SREV_9340(ah) ? 0x4028 : 0x4048)
+#define AR_GPIO_IN_OUT(_ah)                      (AR_SREV_9340(_ah) ? 0x4028 : 0x4048)
 #define AR_GPIO_IN_VAL                           0x0FFFC000
 #define AR_GPIO_IN_VAL_S                         14
 #define AR928X_GPIO_IN_VAL                       0x000FFC00
@@ -1170,12 +1170,12 @@ enum {
 #define AR7010_GPIO_IN_VAL                       0x0000FFFF
 #define AR7010_GPIO_IN_VAL_S                     0
 
-#define AR_GPIO_IN				 (AR_SREV_9340(ah) ? 0x402c : 0x404c)
+#define AR_GPIO_IN(_ah)				 (AR_SREV_9340(_ah) ? 0x402c : 0x404c)
 #define AR9300_GPIO_IN_VAL                       0x0001FFFF
 #define AR9300_GPIO_IN_VAL_S                     0
 
-#define AR_GPIO_OE_OUT                           (AR_SREV_9340(ah) ? 0x4030 : \
-						  (AR_SREV_9300_20_OR_LATER(ah) ? 0x4050 : 0x404c))
+#define AR_GPIO_OE_OUT(_ah)                      (AR_SREV_9340(_ah) ? 0x4030 : \
+						  (AR_SREV_9300_20_OR_LATER(_ah) ? 0x4050 : 0x404c))
 #define AR_GPIO_OE_OUT_DRV                       0x3
 #define AR_GPIO_OE_OUT_DRV_NO                    0x0
 #define AR_GPIO_OE_OUT_DRV_LOW                   0x1
@@ -1197,13 +1197,13 @@ enum {
 #define AR7010_GPIO_INT_MASK                     0x52024
 #define AR7010_GPIO_FUNCTION                     0x52028
 
-#define AR_GPIO_INTR_POL                         (AR_SREV_9340(ah) ? 0x4038 : \
-						  (AR_SREV_9300_20_OR_LATER(ah) ? 0x4058 : 0x4050))
+#define AR_GPIO_INTR_POL(_ah)                    (AR_SREV_9340(_ah) ? 0x4038 : \
+						  (AR_SREV_9300_20_OR_LATER(_ah) ? 0x4058 : 0x4050))
 #define AR_GPIO_INTR_POL_VAL                     0x0001FFFF
 #define AR_GPIO_INTR_POL_VAL_S                   0
 
-#define AR_GPIO_INPUT_EN_VAL                     (AR_SREV_9340(ah) ? 0x403c : \
-						  (AR_SREV_9300_20_OR_LATER(ah) ? 0x405c : 0x4054))
+#define AR_GPIO_INPUT_EN_VAL(_ah)                (AR_SREV_9340(_ah) ? 0x403c : \
+						  (AR_SREV_9300_20_OR_LATER(_ah) ? 0x405c : 0x4054))
 #define AR_GPIO_INPUT_EN_VAL_BT_PRIORITY_DEF     0x00000004
 #define AR_GPIO_INPUT_EN_VAL_BT_PRIORITY_S       2
 #define AR_GPIO_INPUT_EN_VAL_BT_FREQUENCY_DEF    0x00000008
@@ -1221,15 +1221,15 @@ enum {
 #define AR_GPIO_RTC_RESET_OVERRIDE_ENABLE        0x00010000
 #define AR_GPIO_JTAG_DISABLE                     0x00020000
 
-#define AR_GPIO_INPUT_MUX1                       (AR_SREV_9340(ah) ? 0x4040 : \
-						  (AR_SREV_9300_20_OR_LATER(ah) ? 0x4060 : 0x4058))
+#define AR_GPIO_INPUT_MUX1(_ah)                  (AR_SREV_9340(_ah) ? 0x4040 : \
+						  (AR_SREV_9300_20_OR_LATER(_ah) ? 0x4060 : 0x4058))
 #define AR_GPIO_INPUT_MUX1_BT_ACTIVE             0x000f0000
 #define AR_GPIO_INPUT_MUX1_BT_ACTIVE_S           16
 #define AR_GPIO_INPUT_MUX1_BT_PRIORITY           0x00000f00
 #define AR_GPIO_INPUT_MUX1_BT_PRIORITY_S         8
 
-#define AR_GPIO_INPUT_MUX2                       (AR_SREV_9340(ah) ? 0x4044 : \
-						  (AR_SREV_9300_20_OR_LATER(ah) ? 0x4064 : 0x405c))
+#define AR_GPIO_INPUT_MUX2(_ah)                  (AR_SREV_9340(_ah) ? 0x4044 : \
+						  (AR_SREV_9300_20_OR_LATER(_ah) ? 0x4064 : 0x405c))
 #define AR_GPIO_INPUT_MUX2_CLK25                 0x0000000f
 #define AR_GPIO_INPUT_MUX2_CLK25_S               0
 #define AR_GPIO_INPUT_MUX2_RFSILENT              0x000000f0
@@ -1237,18 +1237,18 @@ enum {
 #define AR_GPIO_INPUT_MUX2_RTC_RESET             0x00000f00
 #define AR_GPIO_INPUT_MUX2_RTC_RESET_S           8
 
-#define AR_GPIO_OUTPUT_MUX1                      (AR_SREV_9340(ah) ? 0x4048 : \
-						  (AR_SREV_9300_20_OR_LATER(ah) ? 0x4068 : 0x4060))
-#define AR_GPIO_OUTPUT_MUX2                      (AR_SREV_9340(ah) ? 0x404c : \
-						  (AR_SREV_9300_20_OR_LATER(ah) ? 0x406c : 0x4064))
-#define AR_GPIO_OUTPUT_MUX3                      (AR_SREV_9340(ah) ? 0x4050 : \
-						  (AR_SREV_9300_20_OR_LATER(ah) ? 0x4070 : 0x4068))
+#define AR_GPIO_OUTPUT_MUX1(_ah)                 (AR_SREV_9340(_ah) ? 0x4048 : \
+						  (AR_SREV_9300_20_OR_LATER(_ah) ? 0x4068 : 0x4060))
+#define AR_GPIO_OUTPUT_MUX2(_ah)                 (AR_SREV_9340(_ah) ? 0x404c : \
+						  (AR_SREV_9300_20_OR_LATER(_ah) ? 0x406c : 0x4064))
+#define AR_GPIO_OUTPUT_MUX3(_ah)                 (AR_SREV_9340(_ah) ? 0x4050 : \
+						  (AR_SREV_9300_20_OR_LATER(_ah) ? 0x4070 : 0x4068))
 
-#define AR_INPUT_STATE                           (AR_SREV_9340(ah) ? 0x4054 : \
-						  (AR_SREV_9300_20_OR_LATER(ah) ? 0x4074 : 0x406c))
+#define AR_INPUT_STATE(_ah)                      (AR_SREV_9340(_ah) ? 0x4054 : \
+						  (AR_SREV_9300_20_OR_LATER(_ah) ? 0x4074 : 0x406c))
 
-#define AR_EEPROM_STATUS_DATA                    (AR_SREV_9340(ah) ? 0x40c8 : \
-						  (AR_SREV_9300_20_OR_LATER(ah) ? 0x4084 : 0x407c))
+#define AR_EEPROM_STATUS_DATA(_ah)               (AR_SREV_9340(_ah) ? 0x40c8 : \
+						  (AR_SREV_9300_20_OR_LATER(_ah) ? 0x4084 : 0x407c))
 #define AR_EEPROM_STATUS_DATA_VAL                0x0000ffff
 #define AR_EEPROM_STATUS_DATA_VAL_S              0
 #define AR_EEPROM_STATUS_DATA_BUSY               0x00010000
@@ -1256,13 +1256,13 @@ enum {
 #define AR_EEPROM_STATUS_DATA_PROT_ACCESS        0x00040000
 #define AR_EEPROM_STATUS_DATA_ABSENT_ACCESS      0x00080000
 
-#define AR_OBS                  (AR_SREV_9340(ah) ? 0x405c : \
-				 (AR_SREV_9300_20_OR_LATER(ah) ? 0x4088 : 0x4080))
+#define AR_OBS(_ah)             (AR_SREV_9340(_ah) ? 0x405c : \
+				 (AR_SREV_9300_20_OR_LATER(_ah) ? 0x4088 : 0x4080))
 
-#define AR_GPIO_PDPU                             (AR_SREV_9300_20_OR_LATER(ah) ? 0x4090 : 0x4088)
+#define AR_GPIO_PDPU(_ah)                        (AR_SREV_9300_20_OR_LATER(_ah) ? 0x4090 : 0x4088)
 
-#define AR_PCIE_MSI                             (AR_SREV_9340(ah) ? 0x40d8 : \
-						 (AR_SREV_9300_20_OR_LATER(ah) ? 0x40a4 : 0x4094))
+#define AR_PCIE_MSI(_ah)                         (AR_SREV_9340(_ah) ? 0x40d8 : \
+						  (AR_SREV_9300_20_OR_LATER(_ah) ? 0x40a4 : 0x4094))
 #define AR_PCIE_MSI_ENABLE                       0x00000001
 #define AR_PCIE_MSI_HW_DBI_WR_EN                 0x02000000
 #define AR_PCIE_MSI_HW_INT_PENDING_ADDR          0xFFA0C1FF /* bits 8..11: value must be 0x5060 */
@@ -1272,10 +1272,10 @@ enum {
 #define AR_INTR_PRIO_RXLP             0x00000002
 #define AR_INTR_PRIO_RXHP             0x00000004
 
-#define AR_INTR_PRIO_SYNC_ENABLE  (AR_SREV_9340(ah) ? 0x4088 : 0x40c4)
-#define AR_INTR_PRIO_ASYNC_MASK   (AR_SREV_9340(ah) ? 0x408c : 0x40c8)
-#define AR_INTR_PRIO_SYNC_MASK    (AR_SREV_9340(ah) ? 0x4090 : 0x40cc)
-#define AR_INTR_PRIO_ASYNC_ENABLE (AR_SREV_9340(ah) ? 0x4094 : 0x40d4)
+#define AR_INTR_PRIO_SYNC_ENABLE(_ah)  (AR_SREV_9340(_ah) ? 0x4088 : 0x40c4)
+#define AR_INTR_PRIO_ASYNC_MASK(_ah)   (AR_SREV_9340(_ah) ? 0x408c : 0x40c8)
+#define AR_INTR_PRIO_SYNC_MASK(_ah)    (AR_SREV_9340(_ah) ? 0x4090 : 0x40cc)
+#define AR_INTR_PRIO_ASYNC_ENABLE(_ah) (AR_SREV_9340(_ah) ? 0x4094 : 0x40d4)
 #define AR_ENT_OTP		  0x40d8
 #define AR_ENT_OTP_CHAIN2_DISABLE               0x00020000
 #define AR_ENT_OTP_49GHZ_DISABLE		0x00100000
@@ -1339,8 +1339,8 @@ enum {
 #define AR_RTC_9160_PLL_CLKSEL_S 14
 
 #define AR_RTC_BASE             0x00020000
-#define AR_RTC_RC \
-	((AR_SREV_9100(ah)) ? (AR_RTC_BASE + 0x0000) : 0x7000)
+#define AR_RTC_RC(_ah) \
+	((AR_SREV_9100(_ah)) ? (AR_RTC_BASE + 0x0000) : 0x7000)
 #define AR_RTC_RC_M		0x00000003
 #define AR_RTC_RC_MAC_WARM      0x00000001
 #define AR_RTC_RC_MAC_COLD      0x00000002
@@ -1357,8 +1357,8 @@ enum {
 #define AR_RTC_REG_CONTROL1     0x700c
 #define AR_RTC_REG_CONTROL1_SWREG_PROGRAM       0x00000001
 
-#define AR_RTC_PLL_CONTROL \
-	((AR_SREV_9100(ah)) ? (AR_RTC_BASE + 0x0014) : 0x7014)
+#define AR_RTC_PLL_CONTROL(_ah) \
+	((AR_SREV_9100(_ah)) ? (AR_RTC_BASE + 0x0014) : 0x7014)
 
 #define AR_RTC_PLL_CONTROL2	0x703c
 
@@ -1378,15 +1378,15 @@ enum {
 #define PLL4_MEAS_DONE    0x8
 #define SQSUM_DVC_MASK 0x007ffff8
 
-#define AR_RTC_RESET \
-	((AR_SREV_9100(ah)) ? (AR_RTC_BASE + 0x0040) : 0x7040)
+#define AR_RTC_RESET(_ah) \
+	((AR_SREV_9100(_ah)) ? (AR_RTC_BASE + 0x0040) : 0x7040)
 #define AR_RTC_RESET_EN		(0x00000001)
 
-#define AR_RTC_STATUS \
-	((AR_SREV_9100(ah)) ? (AR_RTC_BASE + 0x0044) : 0x7044)
+#define AR_RTC_STATUS(_ah) \
+	((AR_SREV_9100(_ah)) ? (AR_RTC_BASE + 0x0044) : 0x7044)
 
-#define AR_RTC_STATUS_M \
-	((AR_SREV_9100(ah)) ? 0x0000003f : 0x0000000f)
+#define AR_RTC_STATUS_M(_ah) \
+	((AR_SREV_9100(_ah)) ? 0x0000003f : 0x0000000f)
 
 #define AR_RTC_PM_STATUS_M      0x0000000f
 
@@ -1395,32 +1395,32 @@ enum {
 #define AR_RTC_STATUS_SLEEP     0x00000004
 #define AR_RTC_STATUS_WAKEUP    0x00000008
 
-#define AR_RTC_SLEEP_CLK \
-	((AR_SREV_9100(ah)) ? (AR_RTC_BASE + 0x0048) : 0x7048)
+#define AR_RTC_SLEEP_CLK(_ah) \
+	((AR_SREV_9100(_ah)) ? (AR_RTC_BASE + 0x0048) : 0x7048)
 #define AR_RTC_FORCE_DERIVED_CLK    0x2
 #define AR_RTC_FORCE_SWREG_PRD      0x00000004
 
-#define AR_RTC_FORCE_WAKE \
-	((AR_SREV_9100(ah)) ? (AR_RTC_BASE + 0x004c) : 0x704c)
+#define AR_RTC_FORCE_WAKE(_ah) \
+	((AR_SREV_9100(_ah)) ? (AR_RTC_BASE + 0x004c) : 0x704c)
 #define AR_RTC_FORCE_WAKE_EN        0x00000001
 #define AR_RTC_FORCE_WAKE_ON_INT    0x00000002
 
 
-#define AR_RTC_INTR_CAUSE \
-	((AR_SREV_9100(ah)) ? (AR_RTC_BASE + 0x0050) : 0x7050)
+#define AR_RTC_INTR_CAUSE(_ah) \
+	((AR_SREV_9100(_ah)) ? (AR_RTC_BASE + 0x0050) : 0x7050)
 
-#define AR_RTC_INTR_ENABLE \
-	((AR_SREV_9100(ah)) ? (AR_RTC_BASE + 0x0054) : 0x7054)
+#define AR_RTC_INTR_ENABLE(_ah) \
+	((AR_SREV_9100(_ah)) ? (AR_RTC_BASE + 0x0054) : 0x7054)
 
-#define AR_RTC_INTR_MASK \
-	((AR_SREV_9100(ah)) ? (AR_RTC_BASE + 0x0058) : 0x7058)
+#define AR_RTC_INTR_MASK(_ah) \
+	((AR_SREV_9100(_ah)) ? (AR_RTC_BASE + 0x0058) : 0x7058)
 
 #define AR_RTC_KEEP_AWAKE	0x7034
 
 /* RTC_DERIVED_* - only for AR9100 */
 
-#define AR_RTC_DERIVED_CLK \
-	(AR_SREV_9100(ah) ? (AR_RTC_BASE + 0x0038) : 0x7038)
+#define AR_RTC_DERIVED_CLK(_ah) \
+	(AR_SREV_9100(_ah) ? (AR_RTC_BASE + 0x0038) : 0x7038)
 #define AR_RTC_DERIVED_CLK_PERIOD    0x0000fffe
 #define AR_RTC_DERIVED_CLK_PERIOD_S  1
 
@@ -2114,7 +2114,7 @@ enum {
 #define AR9300_SM_BASE				0xa200
 #define AR9002_PHY_AGC_CONTROL			0x9860
 #define AR9003_PHY_AGC_CONTROL			AR9300_SM_BASE + 0xc4
-#define AR_PHY_AGC_CONTROL			(AR_SREV_9300_20_OR_LATER(ah) ? AR9003_PHY_AGC_CONTROL : AR9002_PHY_AGC_CONTROL)
+#define AR_PHY_AGC_CONTROL(_ah)			(AR_SREV_9300_20_OR_LATER(_ah) ? AR9003_PHY_AGC_CONTROL : AR9002_PHY_AGC_CONTROL)
 #define AR_PHY_AGC_CONTROL_CAL			0x00000001  /* do internal calibration */
 #define AR_PHY_AGC_CONTROL_NF			0x00000002  /* do noise-floor calibration */
 #define AR_PHY_AGC_CONTROL_OFFSET_CAL		0x00000800  /* allow offset calibration */
diff --git a/drivers/net/wireless/ath/ath9k/rng.c b/drivers/net/wireless/ath/ath9k/rng.c
index 58c0ab017..e1def7759 100644
--- a/drivers/net/wireless/ath/ath9k/rng.c
+++ b/drivers/net/wireless/ath/ath9k/rng.c
@@ -29,9 +29,9 @@ static int ath9k_rng_data_read(struct ath_softc *sc, u32 *buf, u32 buf_size)
 
 	ath9k_ps_wakeup(sc);
 
-	REG_RMW_FIELD(ah, AR_PHY_TEST, AR_PHY_TEST_BBB_OBS_SEL, 1);
-	REG_CLR_BIT(ah, AR_PHY_TEST, AR_PHY_TEST_RX_OBS_SEL_BIT5);
-	REG_RMW_FIELD(ah, AR_PHY_TEST_CTL_STATUS, AR_PHY_TEST_CTL_RX_OBS_SEL, 0);
+	REG_RMW_FIELD(ah, AR_PHY_TEST(ah), AR_PHY_TEST_BBB_OBS_SEL, 1);
+	REG_CLR_BIT(ah, AR_PHY_TEST(ah), AR_PHY_TEST_RX_OBS_SEL_BIT5);
+	REG_RMW_FIELD(ah, AR_PHY_TEST_CTL_STATUS(ah), AR_PHY_TEST_CTL_RX_OBS_SEL, 0);
 
 	for (i = 0, j = 0; i < buf_size; i++) {
 		v1 = REG_READ(ah, AR_PHY_TST_ADC) & 0xffff;
diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 39abb59d8..ef9a8e0b7 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -1216,7 +1216,7 @@ static u8 ath_get_rate_txpower(struct ath_softc *sc, struct ath_buf *bf,
 			txpower -= 2 * power_offset;
 		}
 
-		if (OLC_FOR_AR9280_20_LATER && is_cck)
+		if (OLC_FOR_AR9280_20_LATER(ah) && is_cck)
 			txpower -= 2;
 
 		txpower = max(txpower, 0);
-- 
2.34.1

