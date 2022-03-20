Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8A54E1E42
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 00:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343791AbiCTXcE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Mar 2022 19:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343790AbiCTXcD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Mar 2022 19:32:03 -0400
Received: from CAN01-QB1-obe.outbound.protection.outlook.com (mail-eopbgr660086.outbound.protection.outlook.com [40.107.66.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C745132E89
        for <linux-wireless@vger.kernel.org>; Sun, 20 Mar 2022 16:30:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6WU07vEaVLBD0fayC6GlksWmhalKtvPiaf7UasMs8bhBovMLyh7HxVcL0crDpbm9dIQpEoTuddiMJtRndqBzldQHEvxrlWU9NnJx6GCqbFA7LCL5x72E9iDB5CWMnbW36GmJIDzbzfKWXbQwfnLEPelTAj/dIVButeeYMHNiIOL2FPWTTGLWt0gP0afBvav2e6dcqgjH+bjPNS+SAhJRL+RjJ7Az3XDZmINURNiFrAcG9Fr2Y0KbJYdH7Tc4ELVlkeF9aMzIGnPC8JITTEkxjwvek5RoAiydiQdoeFJvp3+M2xakw3+OlQt9MX16hleCRmHdMhMYvQvn/yT8rzeOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6PdhnFkSqTLNDRdmviaxpVSo4zz1Nks9HV5MOBLuc0=;
 b=HuQQDpC3Z91avSYgPd2Nuu7DJdMQIZc69Byh/l/hkNOJK8iCM2iP9qKuaXhfc3F2Tm9PBXitpggQndSe9HQ9Y+CqfsWmsys45J53wGcMg6ptJ0Y6K87M4XdYQFr8IvZNIheX/07zz+nUyBNtEKlZJjFNMZauezB4BJh5JgUoid08zS4TJ1bMaGzt1fnhHeQz/5DT1VVvs/VXT4xnYo9nX6pu97wJhmZsZYUf+51lkW+FfrOafTkYY55r/kYnC+F4BEJql8B9wrBjzJyOz47jKagJ7VyE77VuUkkJMbxNCwTQpi85ZMX1NCm2ZG5cdWKm0ElUPE1RfH2KLWATHPYtKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YTBPR01MB2989.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:18::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Sun, 20 Mar
 2022 23:30:36 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dd8c:6e57:c431:9323]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dd8c:6e57:c431:9323%6]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 23:30:36 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH 3/6] ath9k: use AR9300_MAX_CHAINS when appropriate
Date:   Sun, 20 Mar 2022 17:30:07 -0600
Message-Id: <20220320233010.123106-4-wlooi@ucalgary.ca>
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
X-MS-Office365-Filtering-Correlation-Id: a9bb04fd-28f8-4edf-b23d-08da0ac9a291
X-MS-TrafficTypeDiagnostic: YTBPR01MB2989:EE_
X-Microsoft-Antispam-PRVS: <YTBPR01MB2989BA27644C92BBC3F73B6CB2159@YTBPR01MB2989.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wj1j934utkL7nFE8GtbGAZ6sMPV2sKVjM9e5Urmww8A+49FFr9QvlGsASkuaj94N3EtLmhSqkj1Pd7BaeEVznu/98akbvhsVuam2nYZiamOunqongbfyBurKyNgb/cyGoeMjTGpAp5Ue0QcvMxbfXR19gGMhgi4e25epqr6TK0ddvaQsupCgk11pSRoB/IbpD4UArvYYqNVP2OuSpHB+21NOw+QV6x/wsd9rHeP2YmCw6fa3xXKxomWPTud7pCDoiyZ6GnIjTxFIsd69HZOz8dn2rrKxU7HmQgAf/PXLA3EagmI0eYhStYgLjaN0PK72TOZaE+o1EMUBG9LvSBUQXICaFtlU9pe3cCJjOfvQ1moynFbu/AcsKo6lRljAFWVENm4dYqc+9WqAM5AkBPB9rm/Qj12xvIJUU6hSxfJMU981fc0Cf4QpsH45UARNi+xQcf8ziCavIxnYKh946Az6oTO3WFuuii7wwRH9VTICu9K+XtzBr7itiIYPU61/NNV3ZacDLS4jGNEpXeC31JVFfEWFXaKSfxi/+HU0wTPF2JsemPsEZg/c6zaiAsza5s2fitV5kyEuYQMErn2STyRULK2+BiXMFSBAkAXK86s/Gtf6ytc+9JQHuhQPObYxD9rGA5qgnyFtt/it1wfj7RbeeKQfJzDZ54qJli6DNZ4zEoSK7E/9bvdIAtDbce3mRAnk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(2906002)(83380400001)(66946007)(66556008)(8676002)(66476007)(4326008)(786003)(316002)(6916009)(54906003)(86362001)(508600001)(5660300002)(38100700002)(38350700002)(8936002)(186003)(36756003)(6666004)(26005)(6512007)(2616005)(6506007)(52116002)(107886003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vAT5N7tyjOiG851Ur4uRC9qT0P9wolxm+pv4yVXJAg0Twz1osmSOQ0QiX6fh?=
 =?us-ascii?Q?FPpd/ms/5DzVhEra7OE/jGIpGCipQtOavaHvizRXQfYWiynvg9iJOUN3k/m7?=
 =?us-ascii?Q?YOcMomtgTYsSyTfGymdye1Y/yRIiqwoDPw9F9SmBwlLrfw5lxWUw/grnpPlX?=
 =?us-ascii?Q?+72Zo+gNcBNXDb9o9GiHBdkoPhLasndhPFVQAzILFZUh2SUXu2NyyQiV3kab?=
 =?us-ascii?Q?D2hKAoH8tXN1FhyJidlbtuXpsyG4rS7Qosc6wgfKYpNdytS2WctPhSzn1BEP?=
 =?us-ascii?Q?v6SKG33bGMLsls2EVAzksVcmrQ8wkDs0LcJlbRrvj1Ky3ztcoCKdIjgsFXf0?=
 =?us-ascii?Q?dV98xRxkOTGwtbGO2Lly1WqsJJRe8YZGyzkkzTUVh6v9MXVLuh5F+1/uu8gp?=
 =?us-ascii?Q?9MEOdbveB1FE6YUOiukoXJg+Z0a1rndeU11AVMePX+s2f/8sbNesadnehV6y?=
 =?us-ascii?Q?2W+QO4SHKQWPhkKOQZDwR1xQhTM9L7H9fJDIhNppwjbIM4aNI/MhDMZlnApm?=
 =?us-ascii?Q?xwP1Olm+htujjHIBUpxwigk+zkwVVPDZUOoBiB+IyqlDlouIqHBneC1sOmXS?=
 =?us-ascii?Q?Tamak2deNj9ERwjuGgI5D78kiOHsDBwuyWpeZbQqx4I3ZB7eiVhP7h1x7cy5?=
 =?us-ascii?Q?wOqdQpbFxs4OmvOkdmYmax6ly6NO64UCY1DO2M3xhJX1PKgiQR+waf7BWcfO?=
 =?us-ascii?Q?tKh32jGaj3uSoyb8xWWiRirYKUooC0VDvKuAqiCE6J7PzlWGNoE74motlUuC?=
 =?us-ascii?Q?ucCPCUHwPKPoQgPUZ7QCNOBLFJAqz3ffw4JnQbCTVBC3jeQ9W66El690UWc3?=
 =?us-ascii?Q?TjQZX80RKigkTa/qeg7DMsyI84uRRcO580j6DyXrMDOtdoCFScByajUUet+R?=
 =?us-ascii?Q?pyms8MlHEHRFjsRNx/0BTrYfy8uGbHATGlpJQiU9ISpDX+6IN1bKxST/7cqp?=
 =?us-ascii?Q?sSNLjbEDfpJfrMIkuUiasRtd8zeuiy2NqPyLTWEWPLBBEfolaCMjm4Qv+ZVs?=
 =?us-ascii?Q?eNgQuXabTvldMk60PYg6A2fVzKumK+Xc6ORxkHUNYlrrn+zZYd5k2mF/r660?=
 =?us-ascii?Q?9Jnb3ERJFRawr2ZVE3KHQU+jJJUyelji6v5sedL+KIHusskEU1WyqC4+7xu5?=
 =?us-ascii?Q?iEa9UdWIxs4Y6KksbRWlkB4Hr9gKG7Zl6/VlJZHHWA6Q2dfRZTRJKeYVE1R/?=
 =?us-ascii?Q?/vi29bhW5NgdZLo0OI8f0/fkAwoxlzKu/xE8GDUrskkrdFn3QxGoz+jARJsF?=
 =?us-ascii?Q?1x14ogX8BxOdk7+jjM4sy5sEfam1EXCN2tgXVt72yysfMdwWu8cqEEXQdgJq?=
 =?us-ascii?Q?xYvY/NWMeVsi/by7NOzlQAqv5BHtJBUn+eGChLX7NF9ikzKiRBejnQvfCoc4?=
 =?us-ascii?Q?fRjopiP2rA5HhzJk7+JgU6SmYThQBTOwj9RY9QXRnkJCbYE5K2kflKcE92So?=
 =?us-ascii?Q?tcuIlSgkg6hEOlFz8woDNjl7Hyf2v4Hi?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: a9bb04fd-28f8-4edf-b23d-08da0ac9a291
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2022 23:30:35.9601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvUzLemmRNifm2c6+UGqtO7AufvYsFKSBRkMd/X2jE75ZA0V9DQZ31JS+K6it4niOYrZRGsiOr8DIe8qoeAqlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTBPR01MB2989
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Replace other constants with AR9300_MAX_CHAINS when appropriate.

This change does not appear to affect the final binary.

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
 drivers/net/wireless/ath/ath9k/ar9003_calib.c  | 2 +-
 drivers/net/wireless/ath/ath9k/ar9003_eeprom.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_calib.c b/drivers/net/wireless/ath/ath9k/ar9003_calib.c
index dc24da1ff..6ca089f15 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_calib.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_calib.c
@@ -177,7 +177,7 @@ static void ar9003_hw_iqcal_collect(struct ath_hw *ah)
 	int i;
 
 	/* Accumulate IQ cal measures for active chains */
-	for (i = 0; i < AR5416_MAX_CHAINS; i++) {
+	for (i = 0; i < AR9300_MAX_CHAINS; i++) {
 		if (ah->txchainmask & BIT(i)) {
 			ah->totalPowerMeasI[i] +=
 				REG_READ(ah, AR_PHY_CAL_MEAS_0(i));
diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
index b0a4ca355..669b49b56 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
@@ -3911,7 +3911,7 @@ static void ar9003_hw_atten_apply(struct ath_hw *ah, struct ath9k_channel *chan)
 	}
 
 	/* Test value. if 0 then attenuation is unused. Don't load anything. */
-	for (i = 0; i < 3; i++) {
+	for (i = 0; i < AR9300_MAX_CHAINS; i++) {
 		if (ah->txchainmask & BIT(i)) {
 			value = ar9003_hw_atten_chain_get(ah, i, chan);
 			REG_RMW_FIELD(ah, ext_atten_reg[i],
@@ -5126,7 +5126,7 @@ static int ar9003_hw_calibration_apply(struct ath_hw *ah, int frequency)
 		frequency, correction[0], correction[1], correction[2]);
 
 	/* Store calibrated noise floor values */
-	for (ichain = 0; ichain < AR5416_MAX_CHAINS; ichain++)
+	for (ichain = 0; ichain < AR9300_MAX_CHAINS; ichain++)
 		if (mode) {
 			ah->nf_5g.cal[ichain] = nf_cal[ichain];
 			ah->nf_5g.pwr[ichain] = nf_pwr[ichain];
-- 
2.25.1

