Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0394E1E3D
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 00:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343786AbiCTXcB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Mar 2022 19:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbiCTXcA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Mar 2022 19:32:00 -0400
Received: from CAN01-QB1-obe.outbound.protection.outlook.com (mail-eopbgr660086.outbound.protection.outlook.com [40.107.66.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA675132E86
        for <linux-wireless@vger.kernel.org>; Sun, 20 Mar 2022 16:30:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVzXFZCUv0zZuww1OKPZXs7gSkvYfGux+4R712zqDf+Cy93196TusIaIPNRv35OFMiA5SC01ji3NCLrLHKAxQwGfPp/PHbUjFDSjpCzYreVl4tVLbUWfpMy8qTrQVWMaCJClB9++C3Iuk/3+Y49IbRuARtPcRHpL3wKvGXrWq/pyEBJxOQ70ZFRDJZ37F+TFpsC/cT8XCZeEYqiT407FG8BdwWGC8BgynWjTJjYKB+9riJxlLRcn01Xlyyjxtiy++7rqQI6QJ56RnIWWxcbk1MrUhsWhiU09fE2L74vgZ0O6TERBW5lAacmn8m6NIZicNrHsdNVvIDrW/f9P1EunAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLF60ayAhZG81xVgDrxVUOb6up5Hg4WxZbU8wSzTGwo=;
 b=Xpy6WJ8TMzCe3Pw3Z8ZdGPl9eRO4Kmmr/onKIprnsT+pZjAyLDW0Pi5KCqGR81NOCqCTrXkqniMFISnahsmXNzCgIVMQcmZIfA/9IGPA7kfEnft0JMrHPg4SiH+AP+QU1I+5o6OFvhTW3DUHHZ26ApVHNaO0hICrA6IBX4AouHEju39Ker33aWi5E4bhnopPpvkWiCWt+6YFxntS0EA1zXfs08OTouBNfmN32n0tiQw5xdTCmbkNxUuPSNhOqlWgyzkREAnBD5YgOcCG4UI9vx2PNTYEoz+pj9p1B1YO4jLiN9SoYc1d+einVKjd1j+mIFOeckGczuYz6X1tEm43QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YTBPR01MB2989.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:18::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Sun, 20 Mar
 2022 23:30:31 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dd8c:6e57:c431:9323]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dd8c:6e57:c431:9323%6]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 23:30:31 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH 1/6] ath9k: make ATH_SREV macros more consistent
Date:   Sun, 20 Mar 2022 17:30:05 -0600
Message-Id: <20220320233010.123106-2-wlooi@ucalgary.ca>
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
X-MS-Office365-Filtering-Correlation-Id: 1356db55-eb76-4b99-41e4-08da0ac99fcb
X-MS-TrafficTypeDiagnostic: YTBPR01MB2989:EE_
X-Microsoft-Antispam-PRVS: <YTBPR01MB298908AD68B3784B9574AFB3B2159@YTBPR01MB2989.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HpIcdphwF4CcrU50OhgW2ahzpu5Y3dgiT1sfdDJ5Yo140RTst0kam4pHnFIUcBQxv/fFPkwDfibDsyx52SP4rTT5BtzYEFVfvMO28HgmpAJvhp9A34OI7+D0+wQWO4RkGAElTuZT3P6eKg/dFg+zyhnsaCNrnGJm2vSbpDQsCc9z3m1Bnonu5xlZgTOmfJR/pihq+3O+upSWb3a9aak4it2f615qKc3nG6iAZ5g2yE7q7x3MkSI+NSLHZGpqtHkKoyamvgx9F/jDGC8ZmH+XeuEICDC7ktuSsBKXnUGb6yUW8KtzJpL6MRaGC1iMcYaeWPMmQw6HF0Bs3gSfchcZ/ClgjYbWZrSppIQlJwZH4aT4g1SyypG25feUhzkwQ/uFjAPdTFN0JLxGDYeupLKdB1I0ZMBkR8PGzDkogK7N1hOi7KWrNTVfow7hDP3Y99BF4SouhStQoBYqCIKoeRCxyNHLdPdOz828/hFYFnhbUiGSCUf7R5RbkJXbeobgxNcKrs5X/zBES6pEeujpijUzFpYm3YWwN1IOGt3JgNWJ9uIGSmzqCUu6TC8G1BvEr8LAoeD9Psy7DRklUNoKSxtwjoE6GlKuIndqJChnMvLy9WhfnRy3LJuPbslGUj0XXYVWrtvo2tgXF/ts2ciXwEw8xgm7v/Ar1+AxQux6EFj+aatC3juRmb6MG/d28K8TIpK5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(2906002)(83380400001)(66946007)(66556008)(8676002)(66476007)(4326008)(786003)(316002)(6916009)(54906003)(86362001)(508600001)(5660300002)(38100700002)(38350700002)(8936002)(186003)(36756003)(6666004)(26005)(6512007)(2616005)(6506007)(52116002)(107886003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VAEkBtdo90beJLB878CX8mP1wJ9a0JtHbPbVE02+4jawWBEQbqDUNmKa18z0?=
 =?us-ascii?Q?HY/KjtfzPGFTvb1meOtXELrV5L5zNgcI4dSHb+zs0BhfacOnI632i/ptA8mp?=
 =?us-ascii?Q?oBq0rocrrVlRHCfvahHZoiuEgNQOBeuKK1Z57Pp3OI9JTJebCsuRBcBl5nVV?=
 =?us-ascii?Q?8QHOMirHo33AWjM9WUOfewXm/PeYIwX9FJPopV3kT8H9hABlDwGSYsFBmbJe?=
 =?us-ascii?Q?F/oMD4nUFNn04/vwFIeGihU2SEwtlWC9jyU/xBp/YYX89JRTiOIb9b71N06W?=
 =?us-ascii?Q?AEtiPRJheUY7JsvCV/ChykJg7IteRTO6Dczhegr923Q8n6lIl9kJYWiprSct?=
 =?us-ascii?Q?UzIeYMRd/rImJbx/LTCzDEOzTI64rxECqBrnlpve/1Fn4dE6X0FSFAMk3Va2?=
 =?us-ascii?Q?tFBgU7t/71bEBhs88lbI/pCKXA6BMiMyu0KjbY6BwJArei7IBXftssr6wRyg?=
 =?us-ascii?Q?dK4/VZuU47eTiAa6LQNdd2XFo/J2eiE0GYr+J5Q0BuQ9yW5+qu2Pq7+6TboT?=
 =?us-ascii?Q?A5X5/KxA6eCP2oqMCruhJ+dj5eWrugc4zutIwyfAnAnjv9XWB7mznGm8hUJX?=
 =?us-ascii?Q?tVbnXkfJWtq+opUvxTZTTp9WxFPvWhleG/rc4ZTKJO84Lc2QrmVw700/7Tcd?=
 =?us-ascii?Q?D3yMSHr8K37xATpnl8Uo9nlQeyUfjZH9ydt+tE4XEMhFHxFbw+lcmV+vclCi?=
 =?us-ascii?Q?vfuxTPWH7I6haA07CBWH5q+qrmbO5Kg7Latq/PnYULH/76/UnJ1sVzcUHRH8?=
 =?us-ascii?Q?6x2PjVC37jJME1Fd0bkKMO2QCtSZXr7EpbpZ+8m6JQ5dJXyv64zppwmh2SAW?=
 =?us-ascii?Q?Yx2NSqQPBnNxvNnWbSg0dokyF/tlLZnWi5xwyoPPMFisad9J+ArWEj+tD4qv?=
 =?us-ascii?Q?LsPhoDQPEke4mNAd3/SGBuRvPs37I5fe4Psp7kbjQCMjOTs8onP0yGy64GRr?=
 =?us-ascii?Q?EZ7uOMBcDxSMWwNbjezWvAnNlYzqjvTHk23Mm0KPCF9KtWVML7192RxNRrp1?=
 =?us-ascii?Q?rbH//1nbND69rO8R3hPhGIO0cC3/noBZq9CICNrfN12jhC+Oo5z5bqUdlcr2?=
 =?us-ascii?Q?CBCDibu+2KgH7V7xoWLBWsEzg3c35zQXRoR1q77tQGZfsCJssft5hXm8uoY9?=
 =?us-ascii?Q?gWhtkRJkZolWJzJtFAE2I24W2sNT/8wqtbqaqhPYwuTMgH+PIKcdazhfaEqj?=
 =?us-ascii?Q?VA/kPzgIMot8i8rMfWcRd72mfkpadsrWuDq08RJJjWuuhgFDJSTgCGycDTmC?=
 =?us-ascii?Q?vyWaOmeDUkrtcjvkd6b+dbVi3NvTRxi0MGPhX4AbpAlYoimHZmgQ6YcMFqoZ?=
 =?us-ascii?Q?pKzAxll6TsWiQgKTSU+iLZurEQ5Su0jwCUf7DKBMijvoiSONPHV9dnqB3Veq?=
 =?us-ascii?Q?RKmazoi/QRZuNFI8+tZAW8Po166iI7uayGCTYaHdwc0P1N+FdangmVdZWzFI?=
 =?us-ascii?Q?nIwbClDnKGI8nkyZ+BC+4wYgWmdjw7bH?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 1356db55-eb76-4b99-41e4-08da0ac99fcb
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2022 23:30:31.3354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07mzsvV0mLdCwiGmoz5K8FSd/3ty+p1iBpSzhhfnfZHbyhlQDxe57Ku3n6G/t+fJJQce1tVPaetT0xJEQh4o8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTBPR01MB2989
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This makes the macros more consistent and removes hidden dependencies on
ah for macros that take _ah as a parameter.

This change does not appear to affect the final binary.

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
 drivers/net/wireless/ath/ath9k/reg.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/reg.h b/drivers/net/wireless/ath/ath9k/reg.h
index 653e79611..8983ea6fc 100644
--- a/drivers/net/wireless/ath/ath9k/reg.h
+++ b/drivers/net/wireless/ath/ath9k/reg.h
@@ -834,8 +834,8 @@
 	 ((_ah)->hw_version.macRev >= AR_SREV_REVISION_5416_22)) || \
 	 ((_ah)->hw_version.macVersion >= AR_SREV_VERSION_9100))
 
-#define AR_SREV_9100(ah) \
-	((ah->hw_version.macVersion) == AR_SREV_VERSION_9100)
+#define AR_SREV_9100(_ah) \
+	(((_ah)->hw_version.macVersion == AR_SREV_VERSION_9100))
 #define AR_SREV_9100_OR_LATER(_ah) \
 	(((_ah)->hw_version.macVersion >= AR_SREV_VERSION_9100))
 
@@ -891,7 +891,7 @@
 #define AR_SREV_9300_20_OR_LATER(_ah) \
 	((_ah)->hw_version.macVersion >= AR_SREV_VERSION_9300)
 #define AR_SREV_9300_22(_ah) \
-	(AR_SREV_9300(ah) && \
+	(AR_SREV_9300((_ah)) && \
 	 ((_ah)->hw_version.macRev == AR_SREV_REVISION_9300_22))
 
 #define AR_SREV_9330(_ah) \
@@ -994,8 +994,8 @@
 	(((_ah)->hw_version.macVersion == AR_SREV_VERSION_9561))
 
 #define AR_SREV_SOC(_ah) \
-	(AR_SREV_9340(_ah) || AR_SREV_9531(_ah) || AR_SREV_9550(ah) || \
-	 AR_SREV_9561(ah))
+	(AR_SREV_9340(_ah) || AR_SREV_9531(_ah) || AR_SREV_9550(_ah) || \
+	 AR_SREV_9561(_ah))
 
 /* NOTE: When adding chips newer than Peacock, add chip check here */
 #define AR_SREV_9580_10_OR_LATER(_ah) \
-- 
2.25.1

