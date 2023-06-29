Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF4F7430F3
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jun 2023 01:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjF2XQ5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 19:16:57 -0400
Received: from mail-yqbcan01on2069.outbound.protection.outlook.com ([40.107.116.69]:57870
        "EHLO CAN01-YQB-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229483AbjF2XQy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 19:16:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/ak/2TXMeRI2Yv6kv+PkeRH+H04pjB3Gvcdy+JdorUkJaKl6G+ZiKPyqK/WpinTxK474x+kjAt0dFRwHAWxAVdA/h0F+0JOAA9vIyKftuuMyiQmSfX+J3D8Lf5DNkq05oMPFGNJ23/QaOweoj2tQ7VB8zFYF+yXEJ93Y4iVNJ12s6Ea97qVL2Wnpp/jBqwY4GWK4hSBsVCESXUD2IK+K2etErGeZTiAC6qI5s8hjbWRLSsA86svI0Mg9AI7eXoDMiuasbC0YNfQlbs86yc0exLFvsSl+zyU8OPKXCC8+H5sEgUMerDpBCKlYmdKXBDq8Ym230tGWMPHbzM8kM3RsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vG5Bn4blQ3dbxXoTaLX+k1XHGMReA3RRP2MHKsWhv/0=;
 b=Hu1xevPQclMkGFRL3UEc1TgYQ5i7QazTQCvnVjzBT86rZhMPk+NdJZls9B9+KyEE2E7mX33DsYKdbCygB6XukBR8EnYQhoBLLokH4lD06lWbLqjvEAY8xOR60la3TnGSz3+NMnPJy7GUg6vvw54/mgm7odjOAr0CEgrQ8SaUEOWmGg5sG1x6rQEhT4dZ8D80wQYKQC0Q0DpAXc8JM/Vx1rqw0oV9ltVPYeOqZEIWpv9pQCkpu8MKdyYxFEkeWCxEIJPjtLtkybwEmbObfXoc6TS1kJSwJUm2q11+DZTjGy9iTC2thfWtbxRQf73KIejPywNuk3StqkvhnmrR3xFSCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:16::19)
 by YT3PR01MB6082.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 23:16:50 +0000
Received: from YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::684c:a6dd:94c8:78bc]) by YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::684c:a6dd:94c8:78bc%4]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 23:16:50 +0000
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: [PATCH v3 04/11] Revert "ath9k_hw: fall back to OTP ROM when platform data has no valid eeprom data"
Date:   Thu, 29 Jun 2023 16:16:18 -0700
Message-Id: <20230629231625.951744-5-wlooi@ucalgary.ca>
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
X-MS-TrafficTypeDiagnostic: YTBPR01MB3310:EE_|YT3PR01MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 47500aae-018f-433b-ae14-08db78f6ead7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: twxhOSuZXMUey89yqzRSbG75lttNHYaOs1Fa/wTvNrUE0A4LLRd82Px9DlRIjhIHfndOrn53HO8EEnDLB6c1TkYnnfpdTERcYzSC13gysrwpcX7WsaLzaGstWYsFmOsKiQP9h8poJNRwBxs6TlCJvJ8TDvgg7yYnPpCPzuYgv4tgD6VOHHJAi1AyW2aeuoXaehX4tvK1vCYeXZn6sUfqCZNEe/HbLPXqOFlUzJGn31IOhIMQIQvSNNFqOVnDr46hMYkZz1qroRTprEaBcVaqkjMJhQcZHcAxPJiF84lQxTiaDYALl79p9emQw0Dcm/RmbO684yIbYWQc2ahAsZSOO1eNI5pyI5l8+ardkmMUo3kIc0Q/R1YxEdqSR6f5QtK5WsiL/gO8vTWQ4iWi28fC7NROSKz2nwrSoBXfn25OYEkUmoU0agBuUjWUsyGwpV65oBBPIElrNxqntT5CmuYMDBx5odSoEpsoedN88gt4kmwnJitghXihkAL4UlkczUZZuJlSdyfmki4W6CPb36uAJjcwxpnioVpC9zyOOJIHxPPM0PNjsRSJsmXjNamst5Rn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199021)(6506007)(1076003)(36756003)(8676002)(2906002)(6512007)(6486002)(478600001)(54906003)(83380400001)(6666004)(2616005)(186003)(26005)(5660300002)(316002)(86362001)(6916009)(41300700001)(66476007)(8936002)(4326008)(38100700002)(786003)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ETNCHU2ai8m4Mz7S/ezpyRgbGPlhaqX2ldw/XmWUA6PqHmFikXHApRdJO6uu?=
 =?us-ascii?Q?8gm3W6SGFtQDzNV2RP54+gOINN8gIshyRPRWbwVE6Jpu5E8mAkDn91qAUUhg?=
 =?us-ascii?Q?iQ3xzEQpmZSztQhB8ZbB9GuxktRWfJvGlXoO74PW3Ga0vpKSdZUzgcVeC/bC?=
 =?us-ascii?Q?Z9sK6VEB1JEj48NYRYW8eQtieNzuMcEKqiIDZRYzaZvWXMuFedBeUgmt6vxd?=
 =?us-ascii?Q?PxTlSBliIkn22XO6eF8JU7uuDK5Ydvxz44Ay713kJ11aN0W68anUoExSf95X?=
 =?us-ascii?Q?1Yg8vP5tioolfrRYiu7va2yIinzSSzmsRphDnJePdWzqnjykGlqaPk/9MUil?=
 =?us-ascii?Q?T8w/CGtSSEFyrtdbHd0Elh6ndq5kNApUvUWBaZ3I4JTvnXgOizoOEtGZlfLl?=
 =?us-ascii?Q?mo8OhL53d5wW0nOGMvn5XgwWkGz9fmWb3A3RvjjjxDv9wX7G+c0Qf7JgxTmR?=
 =?us-ascii?Q?/PkYzkm6KTezbnTryypVHxHo6iSfqBE9zZCNOaVFBrnM5Z4snTqCV0+JB/f7?=
 =?us-ascii?Q?H3Hgi35hzbimdcoLUohZvoULwDc+d0vHET9ftD/eJtLLDOH5KEYXtP4fL3Y7?=
 =?us-ascii?Q?jL6nhOWdDbOnZv6L9jzGFsyHUILVJv5ytpP/OiQLy5GOBTRiXIP2knCj6gZp?=
 =?us-ascii?Q?2oP+HcMnNNF43z+kazKlwEaDaluHn9ZTEAYl6mdic7ACA6Vl7EwaIDp7JwVf?=
 =?us-ascii?Q?Q9BDp7KArrVsGXri3CRQxyZ9Q6EPCYS73LYR2YdxEk5S8e/frCe5baH52Sh0?=
 =?us-ascii?Q?84ouZit/dturgL5MtHs4rmFG1W1fTbBZASBpFJhTZXmoOh9+fcQVe24hXVtN?=
 =?us-ascii?Q?gsT7wiApBrix6Q6/HqbapuB+pR2qqF6JFRBRY1zj+0Igx06KSZjLi0Av0i/d?=
 =?us-ascii?Q?UDfDRIAcVLj8h91cFTj/gCMMFtnPNpnadRq+FQnvuDR3v/UNo3zATJsVXBg8?=
 =?us-ascii?Q?0YAgbRgK1eViplhw6a6jFt763Vzuxc3mr2a8WbDQGtyWoVvuPJyvvmrdUaEa?=
 =?us-ascii?Q?pLzejAGMTdX0/4/ayscW74V8Lbp6r94qAdvEGh45wNwMbrF/hSiZDQV9+op6?=
 =?us-ascii?Q?1w5TahCq96C4aMNcHBnmoyIRgD48IWIQGCsfBytQdUGrpK00tw8ybaSyujmR?=
 =?us-ascii?Q?vs5wqL4sVw4/83hm4WiDT5b+vLinZYOVlDBY4Xx/97/j0pRofe9TKxVnMdJB?=
 =?us-ascii?Q?jQdIUQtHay6AjrdxHqnmmUbfJscs/+5vZ0OV4OfyRqnWH0Ss4aoFlh+Q9lm5?=
 =?us-ascii?Q?6eQGuNYhyaXgqaBxwYebwAD1DU7cRyFRLoEuvM1s+CLv6uTpBoJCaXPr5PPw?=
 =?us-ascii?Q?cwNNdlS4nGj2UGsluZ2YLjq8/R2x1ZUk9DayuWHuhJ1Sw4vqlZ9lQywYNtf4?=
 =?us-ascii?Q?SV+JMBo4uE/YeFdq6k1NxUy0xmDVEmADDBs6s+zYpmvuqugc74WKEcNd98UA?=
 =?us-ascii?Q?DLSXahzXpB8th9RWK8P5tXlXcKeo8gZJVLpajCOZMGQWqICZhsZTlSrIQpCC?=
 =?us-ascii?Q?DZ7T/RRW1qKPl++52mRwcLi/6/+nNKrChfFEOyV7wcSd4FPhBZ//ZnTD7la4?=
 =?us-ascii?Q?dXNLUmHAhuawS1/cN2f15x8kSleCp1D0BL/Dx7SL?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 47500aae-018f-433b-ae14-08db78f6ead7
X-MS-Exchange-CrossTenant-AuthSource: YTBPR01MB3310.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 23:16:50.2081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRJBTKHe3NclgzU6DK8UlE5UQjfb/TZUk2zSQphhigzwdWDcqezaVXCzrH/RsUp6/bURdRqedkVmUogDvdYR0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6082
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This reverts commit 01967360a20598f95947a86af26c930ab1b50205.

QCN5502 is a 4-stream device, so 0xff is the normal txrxMask. Users
currently relying on this silent fallback will need to stop providing
invalid EEPROM data to the driver.

Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
---
 drivers/net/wireless/ath/ath9k/ar9003_eeprom.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
index 3dab290d8a..0f8af8c958 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
@@ -3321,21 +3321,10 @@ static int ar9300_eeprom_restore_internal(struct ath_hw *ah,
 	int it;
 	u16 checksum, mchecksum;
 	struct ath_common *common = ath9k_hw_common(ah);
-	struct ar9300_eeprom *eep;
 	eeprom_read_op read;
 
-	if (ath9k_hw_use_flash(ah)) {
-		u8 txrx;
-
-		if (ar9300_eeprom_restore_flash(ah, mptr, mdata_size))
-			return -EIO;
-
-		/* check if eeprom contains valid data */
-		eep = (struct ar9300_eeprom *) mptr;
-		txrx = eep->baseEepHeader.txrxMask;
-		if (txrx != 0 && txrx != 0xff)
-			return 0;
-	}
+	if (ath9k_hw_use_flash(ah))
+		return ar9300_eeprom_restore_flash(ah, mptr, mdata_size);
 
 	word = kzalloc(2048, GFP_KERNEL);
 	if (!word)
-- 
2.34.1

