Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24364E1E3E
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 00:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343793AbiCTXcF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Mar 2022 19:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343792AbiCTXcE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Mar 2022 19:32:04 -0400
Received: from CAN01-QB1-obe.outbound.protection.outlook.com (mail-eopbgr660086.outbound.protection.outlook.com [40.107.66.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63271132E94
        for <linux-wireless@vger.kernel.org>; Sun, 20 Mar 2022 16:30:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTK2TidiE9PcHa3Ldk2mF3BfpIOIzds8NiDiDj5/z2xIHHXJyLJEcNXUsfd0y9473GHZ3t8Eu78HXJqdy3KGnm4jdo7wEg/roBV/PHlHDIwmiOqT+hdPUObu27sL0LXNb5F1cyzzcDtmgFyz2i9Crwhp9BNR2+q5wQ2ztZX1SCRNIAj1rAyvnD1TQ6T8OJ6+RTCoOLrMwYsBZweWlAnPCt1lT2QvE+Fb2cLmlUO/NCngCl8rR4uqbJLpnkHFLaQSo5EUxfqEyMNSHxIGdJHdWr7tEkEXsDnP0LRzdXyLECKAboQc2W6J3cjllIiYXZzy55lqMkbgHWVqNwlADVWClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2reHbE0WPgtyWD89wih7l4T4Dvd0Lh9f54OomM55zsA=;
 b=YGh5+DtMmDTvpuEA2Cgd/zC8zzkzktLgr80a++WPbYwcPFcKf0k1d3pOMHmG97ETdNoB/xkvQiBkbN1tdcDqT99zFUVIgFM/E2G51yydxen0ks2Hz/A/NQDclgyv5pwL+ahdACZ00gOuS/PFZ9KgWXOpTYyEF3fYwRIJIlaMPlvvB+J3aRdbiCOIBo0xhAWfyIs/eUvYE0Kxh7mr59I7xootm8FX+CqSF5Ke01BoO4NHW6mj0r5OUZqq7US0FtAEw5E7w+uiIDe5FKhphEdqdjLdGc3+ESDsldgv8l3lDNaO9+4sqY8mUfGeFz279H8P2F0DhhhG2mIbRKp9In+CCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YTBPR01MB2989.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:18::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Sun, 20 Mar
 2022 23:30:37 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dd8c:6e57:c431:9323]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dd8c:6e57:c431:9323%6]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 23:30:37 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, Wenli Looi <wlooi@ucalgary.ca>
Subject: [PATCH 4/6] ath9k: fix ar9003_get_eepmisc
Date:   Sun, 20 Mar 2022 17:30:08 -0600
Message-Id: <20220320233010.123106-5-wlooi@ucalgary.ca>
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
X-MS-Office365-Filtering-Correlation-Id: 382e7f97-682a-4253-b708-08da0ac9a37d
X-MS-TrafficTypeDiagnostic: YTBPR01MB2989:EE_
X-Microsoft-Antispam-PRVS: <YTBPR01MB2989FA3E36FBA643820AE6BDB2159@YTBPR01MB2989.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j6+GFUUldEPDFavbQlnxf8KME7XkW/cqZNclYKknDJUFmd+qHzaGQ0l3qMzbTbPQ8VXDzKS7cyKwMl8vs+xijB0zpTjJN7l69BXHht188NkxOQyuls+bKQUYhEeFmVOn+Dt3deWadVzTx6c8GHzshhlfh/6b0P6477kyMWXJWlOY1Oo64xoodqZTQty5Js+dS3lOvfF63D/DydxXY6K78DCh+du3mpQKcd9t164aWR/Fxg3IfoqlLMrCIyS62MBMB9S7CwvTLGT97slPJBFwlKUeSGxQ3ni0Dle1B/PKJhZYUuJ8ScXfG5qASTFbifzQ122+//CM3hUvxNcNkrS9IPs+1vRFKCtW4g3yg3K9H1WzIH9mT+oA6Txtuxt2taKI+/NbLroqYhet1vHNQDC+2guBcsE7wt5MOPaG8VancCPEn8vP6Ajx1DS9PnIg3k3rXfgVhSb1IjAFlTAzrP7e/LgB2VcrF27ZUq1iLhW5kfq2ui7cQY5Gn0KiCybXqpCzHlx9d13kUVyz61DPK0Wcd1BywfruQ9MDxj9jmRr83lA1uxyBpSnpRAqY9TVZocbu095V5uKPb8Gnl84uyUNH9LKl+PkxOi/sTFWXUm1d3gIPhQ8M6TP8361kk0G2tKfCfeC76yaUlvuAUNR4YMq/EKSIf5B/GOkmOw/T6JaQlsJAaWP/fBi1tlEp/yVwUANx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(2906002)(83380400001)(66946007)(66556008)(8676002)(66476007)(4326008)(786003)(316002)(6916009)(54906003)(86362001)(508600001)(5660300002)(38100700002)(38350700002)(4744005)(8936002)(186003)(36756003)(6666004)(26005)(6512007)(2616005)(6506007)(52116002)(107886003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OLIOt37zWCimUeSmGgexgRk9fLn7R9CwfU4wjoebBfZ3JFZsQW8vUqcF3QQO?=
 =?us-ascii?Q?RNwQaQFqQ6rFU/6LV1zpsIfSFHb+T741/+1KcxbER4PbWJSBrQxdeS0F3S2b?=
 =?us-ascii?Q?3kdtSAdW6LqT/BUGEMk42Jzvg/iGOO+VGSytm86dj8wZ8LVNzyWDgXXp+1Qj?=
 =?us-ascii?Q?2ubS9AQNXdLn0Ur/gPJmTRNFdehITLfw9pabp3IKxuuQ4vN46qgqV/2J2TfH?=
 =?us-ascii?Q?wbhya7VtQZO4vlJcUum8DPS3GM9Zqz7fbaWuH9ejDqwXZJxDdz6h3tZHPGgV?=
 =?us-ascii?Q?U+rtHsEAqs9dIBdYmwJa2JPSNH+/VLKRTqjOrrUEHOmTgqfV6QUdvynuaIJa?=
 =?us-ascii?Q?9+IYeaMGPB13uxO+dX4dU/PGh4Bo4v+QMIkWBiR7Il+pMTh3a3y1K2YUsjss?=
 =?us-ascii?Q?UD2I/nizWv4TztqQ1mZLWcHoiDK9M2+KYtAhFCQhU27slVRaiagrItjzctG7?=
 =?us-ascii?Q?ih8Jd2JlPBHVn2/0fctV1LZ82M6pZQNTUMjyAMEtqnKXRom0707YYYbCtdku?=
 =?us-ascii?Q?Y1Pezx7wXqbTQlWzeFaDJW8Wl0gYUGHJDDrAqxt4wyp/y72aAmksq5fLCT25?=
 =?us-ascii?Q?7z6PQHqO7cnWs48/2Di1D0vLGCZYWWMK7FtS0LlIrXUvMEdd4fkwlitAbQbl?=
 =?us-ascii?Q?YXVEMZ4uhZCQcz9/j4efEjAhBGIFVNghawR8R6nYqbl4bx3xMv9zlHA+cZNP?=
 =?us-ascii?Q?nKmKJfWEMNgUDs/mI69kzA66ttxfi74Wu3xfLaZy/NLnEli5HkjVdvDepbSq?=
 =?us-ascii?Q?4cpsN5Sh1dRLAOg6e6r5Gh61ocZSot/hyrLiGeYeKetzXhd/cl0SuXlO/1X1?=
 =?us-ascii?Q?eFEp4moS6bPVPwb1wQmnSenm5nPOx53up0k3fr9tm6Nx7WGi4HZpVHASKyaq?=
 =?us-ascii?Q?+cSlHRGXS+p1yiTkR9TM8My/Zz3YcwuP9ptOY+rH/QTOebYzUDV6R9+iosVN?=
 =?us-ascii?Q?NKmG3AIwSmX9GLqSB1C3i3R4cbjjQGv92B/6PV4dNWBsGg46LTp6eKatm3xP?=
 =?us-ascii?Q?PSXv54ePWnQZ/OI/do3vAb5/vhjxftKMcey+V87eOezEiecqI+tbpLc1B7QA?=
 =?us-ascii?Q?qCRW9VRKxoeg4Pqgd7ro1TyFT2VO3hn6SUUHlHanfR29Easzl4S3oARD3Sxv?=
 =?us-ascii?Q?v/UJ4+laonE1ZhBieVEjD+Eu4uBNvVuIrjy36WGwz0w3DQtBWmHyWkKmXg/H?=
 =?us-ascii?Q?KHOVYmLX4GZpIyKLTWbh29lg87kjn1afbwqN80nPjIQmFcvP5C/LM2B5FX7Z?=
 =?us-ascii?Q?az+M2NFiFYYyt1crVUBl/fWbJ4dAn+8gSjK8aAqzM81r/djRTEmIXaHB7zou?=
 =?us-ascii?Q?7OmMncrzwXNRQIe/he9aPWPp2sSMcKGpc0u7WvIwuvye4zl07a3xWiJcgMu4?=
 =?us-ascii?Q?MfH49oyxzQmPaitJE0WI6fy1uSLkY9xK3kALAS1horvMlgTNm7Y3dHwMS674?=
 =?us-ascii?Q?+MO7jUXH+u28oeQiBxkn8h4XDoe3RV+7?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 382e7f97-682a-4253-b708-08da0ac9a37d
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2022 23:30:37.5538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxtTWErNdoLIcz948umcvJ2XeS0+wL/AQXPNqvLDuicAC0Nj1+NSSUn/Xr/YY3XZzJof1mNHgmeZGWE469e27Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTBPR01MB2989
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The current implementation is reading the wrong eeprom type.

Fixes: d8ec2e ("ath9k: Add an eeprom_ops callback for retrieving the eepmisc value")
Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
 drivers/net/wireless/ath/ath9k/ar9003_eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
index 669b49b56..a109a44a1 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
@@ -5615,7 +5615,7 @@ unsigned int ar9003_get_paprd_scale_factor(struct ath_hw *ah,
 
 static u8 ar9003_get_eepmisc(struct ath_hw *ah)
 {
-	return ah->eeprom.map4k.baseEepHeader.eepMisc;
+	return ah->eeprom.ar9300_eep.baseEepHeader.opCapFlags.eepMisc;
 }
 
 const struct eeprom_ops eep_ar9300_ops = {
-- 
2.25.1

