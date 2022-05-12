Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F018D525613
	for <lists+linux-wireless@lfdr.de>; Thu, 12 May 2022 21:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358204AbiELTyU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 May 2022 15:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356894AbiELTyT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 May 2022 15:54:19 -0400
Received: from CAN01-QB1-obe.outbound.protection.outlook.com (mail-qb1can01on2070.outbound.protection.outlook.com [40.107.66.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F052701B4
        for <linux-wireless@vger.kernel.org>; Thu, 12 May 2022 12:54:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYZQ1yexaoRc7CGJCzMmQWGyZlA1tQ1m+iS/VgvFYYRK81hcCTBxuqX8KdEbGvkVUPt65Pc3VatLDnfSO9KA8yaeXmPN7dZZWzwD1ZG8D8HYZCP8D5+fCIPwVuhMHEkxByjNj4qEiJvcsxL7Aqf/iy2uY4QElyTDc0i4/5fuiWEJNmGH0+bGLX+vNkPkkvIAWRrNulXj8ipJb/aCJOG+YQ5+aonWL5q3PFM7+IRCSf49+ygzbBeJ2LgcyYr/nGtePQVzNP1SF/OvmO3t4VA/YL87SPRWdyeR/zZJJbT0bSsvBUlvfpWCsug2KKmMt8Mgk+mOHm/3MZRV6eHqKanZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dpZETlNHUy8Q49OGk9DY4M7CBvgNRYRG/Sv6kce2/E=;
 b=WH2RvJzeYwhFrvjtaXNo6Pa291cV9otOza8kvcEktBTaC224xY4/Gdn9p5F+ua+HSNEFpBKhe9Q/4+qxQhl/hETpx7HlKrTdQ5EezqTACdZDADhnHSTjzVwnmQE1RUcdqM9vUrv5ZlSXOSMJVrhj83PGtKAMSsrvRINL6p8OjQO86dybqIIh6fyZ4FL1o5AJnOGVFBQlz5FsJLSIAB0cGnYjBdKz0HWHscI4c/8YlPkrw50L46xWQAyxtHFkgn+9FTnzzgbV/OoIuhO5FAiOZuCjSia5nHi6PECrQ/MF1uHEwhvznHlAG61C5PHM34011YYS3i7UOu7mZ5Vkvty1ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YQBPR0101MB9515.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 19:54:16 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a17b:bb51:f663:e98f]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a17b:bb51:f663:e98f%4]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 19:54:16 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH v2 1/9] ath9k: add QCN550x device IDs
Date:   Thu, 12 May 2022 12:53:11 -0700
Message-Id: <20220512195319.14635-2-wlooi@ucalgary.ca>
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
X-MS-Office365-Filtering-Correlation-Id: b90f8f8d-150a-40e7-dfd0-08da345131e3
X-MS-TrafficTypeDiagnostic: YQBPR0101MB9515:EE_
X-Microsoft-Antispam-PRVS: <YQBPR0101MB9515AED6D3217F9A5AD38AFBB2CB9@YQBPR0101MB9515.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iBL91E08EWPGIMsqXtkXe7nm11Sce8K+GMnx+Pg4Jl+Rlhx1Tskmv5PZSFXMMY+o56c9//9Uc3OF67lQPZgeFghSpZ/olk+uvTTdtD6zW6wbuxIcmofN3xoY9MInG1V/I38I/rOztWQ5CX8zwNsYmgW790hQTfrceWClKX1mI7p/wVas6Vkg2yq4bOpGnjSHp4NsQmKJod1TS5FWPIAyTBDH3Mp4kegACjrCkVm3DnE3oFlcVOcf6YUzaJfk6sXIRESVTey0fOaZaINlreWA8yvP9hXLra/BmBh7fFeINp+TzcbQtn3S4HWUyaojOFauMSmGmeE49Ygc2SDv2CpaV3aTFXju741rzxcP8MbWd6IOF9wCYo9T2NVbW1IKZe//vlQwx8H/MzBbg8iCXKY6PNOtxSpYqLvlNYx/E/jgI4kedN9/ZPpE0yBJVeabOQiWwiorpP4CUTuTn8G+Od09ot1fRS683wv/PG8f4Ss/o7oEDeuw9+us9annqjtV6P8cwIL0xUPBnPk+TcPIFOzOKi0K+Sc8EhQ8fW81xvTAj6AcO2vvURMStiuk1N2ZliDKOtDEg08PtB7CrMUh8GQuBgpftBSH4ylv05R8Fe1DErxnsLAOyXUHeupjfFlQQ3APGeVHOCBcZyJkv4k0Osq8Ub7R7u3D8y1CG8O0jbI6ABSLBbX8oyG9Eu1NLodDxh/0+GGTfF1zBfXIi7AWyvB4EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66946007)(6506007)(5660300002)(1076003)(107886003)(83380400001)(8676002)(4326008)(6666004)(26005)(186003)(66476007)(52116002)(2906002)(6512007)(86362001)(2616005)(6486002)(8936002)(508600001)(6916009)(54906003)(36756003)(786003)(316002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wdQB5nQvb0NDDyRTYBKfv/Nu7dOEO/HucBopIxXJ/IAVEiK7JOTML3AQBOdc?=
 =?us-ascii?Q?qTEhsgBXtZ690/ixA1UM7bYHvHYlUnXK3T+j/oci9SbxyE162j4ogYlD/i+V?=
 =?us-ascii?Q?2STsMsOaJMXtXA11Avhhe4TqeYuzn01Dt1jeC30Ab0G9Fi/8nbW69Xn96EYJ?=
 =?us-ascii?Q?o+Xzsp5nPvxzs7MuX1H6RU/hIaJc5354LrHtoZ2pVuCi9Gdo4fmWqTmVZRvS?=
 =?us-ascii?Q?q+6Bd2/YKZ3SDEcpSzP3po8vTVyO75NE47tf1/GqPIpTFIR2U0Oml1wEoidS?=
 =?us-ascii?Q?CS5rsB0m4iUZnFn7WEWkWP+RS4aLbfxRsgvyB2IKLpg6htGmXmdFqFFYXQl+?=
 =?us-ascii?Q?wrwEKAMLvKIYkgEGjPYKTHShQv+4SDd2PR6E+bphFkwyU6R1xcujF5dTY/wZ?=
 =?us-ascii?Q?qZdTyySv4+itAvoNZzRwGETwWqSMNM6FKxhH7ZlGZTM7lcD9mpnSuvNMwFQK?=
 =?us-ascii?Q?N7xKNZOhOKQIuWb1jglQnXxTRsRgQDbBftX8XMLWuCQEJRPvcKSJi2PE3VLu?=
 =?us-ascii?Q?7mZF/NfpYaICFCaW10lG46ojb1kIA1siiotBe29MiuXY0t27aablU4HbsOWr?=
 =?us-ascii?Q?jcB3dNR2+6keI6w9+yVD7Ll+WosqMnZRrs94wwNKuXXQMb127B8tBxXB52ny?=
 =?us-ascii?Q?5dieNK2nFpV658iMGGSfAjidtQY3hPkWZh/YBIcsor1aolOpxpoaWNxruR7t?=
 =?us-ascii?Q?X9xPeAsDw8rYqFaOQVOtPm9m4DQ3Zfg5xQVGhCouvsnfityqxAu6GNeRV3B4?=
 =?us-ascii?Q?qr1DFkQ/2se6KrxUzucPnAwQx2Efzd6jfWw0T37xPbdBfz++igwwyeOzmiUr?=
 =?us-ascii?Q?oIk7UTu0y+s30twWqCHgba9QxjDIXcJlgdvG+a9CvJSmt3+U8ImSr72pjH9J?=
 =?us-ascii?Q?u+DDoY4rb/QYE8aAwKnZMS6E5jNY24qBWD5El2TQrMCrZLbKjVD+mQxE/Sab?=
 =?us-ascii?Q?9d2SSFBKKzporptEwBYMrHIExweoQWUQZ0NEvHDpUfJ+1YPlp4pzsnCMKHrU?=
 =?us-ascii?Q?HdGLDCM5VTXNPbVTKCYtrlgMx8Xc3DXXplmf3yEqnH8bXDy3zaQSEAXjlJ8c?=
 =?us-ascii?Q?NZEAWIwfwn6R7620eeYJX3LjlCNlMvM6g3bdgVqusLAy7xJo4YgcspI+ZMKF?=
 =?us-ascii?Q?BiUh+qOXGapgsWqR5/g1598Lu9f6LSUw4aKGaOklMAtsT63a+y//KwJlIh9X?=
 =?us-ascii?Q?BRIdoducLm+UmH2pi5AyKfHjPq9YuZOXmYDue3raptUv/VSWOMpeMIoU6Zej?=
 =?us-ascii?Q?KRqfifJrgC2LwGQZPI49IE8swzOnOfCPlOQY+S6wmrO8ATKYDP3IY/GZs/ZH?=
 =?us-ascii?Q?L/VLn3Bowyl47uBXZYenDKS0KUVN1A0Yqx9klv5r3Vs1PFSpRKOOcygHi6rJ?=
 =?us-ascii?Q?wiJ3IpeL8q7nlKe49/wzMbrPA5+4O4xQl6qacRQU4tS68DJouH/MZFKUhYf3?=
 =?us-ascii?Q?WX3DdAhMfmh/qyJb9+dSI3dL+PthekjqGvCIfkMzLFAiYiCRRzN8Kjk1dh+Y?=
 =?us-ascii?Q?AHqmTLLVOImMwlFiMiy+hthwZLAGgy1eovk/KdJfLKNTebV8V7nbJ5uVmM0i?=
 =?us-ascii?Q?xJfSSb2ifNVG5zgC8EZXB7RZu8nWNnwwOKNKEXicCa/5+cjtAKhvQ1SeajfZ?=
 =?us-ascii?Q?q+z1RyjjnhYbKUEtVwGT87ALC4uuxPXh6cy7zM2OeBxR1Shf/VyXZLL1yFa4?=
 =?us-ascii?Q?eV6SnnxZBMgIMRKaX/rofl/5BFi/EOHrsdNbZJ/ka+MiC31Pj9yV7o+gZNG+?=
 =?us-ascii?Q?sQ/Iq4IU1w=3D=3D?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: b90f8f8d-150a-40e7-dfd0-08da345131e3
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 19:54:16.1453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7vPD+xRYRjOaNzQZ8hVnw8EgwSc1L7oLQ3aitFR2QSGBem1O7NYlBS6tR4gwa/etmxoGsFUk+aEG9XmUFuZLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9515
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adds the device ID constants and augments the initialization code to
recognize the device.

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

