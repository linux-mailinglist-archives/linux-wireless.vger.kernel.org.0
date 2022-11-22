Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F87633389
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 03:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiKVCrd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 21:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiKVCrc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 21:47:32 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2043.outbound.protection.outlook.com [40.107.255.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842561DD
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 18:47:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0jaJBksQDfM9DnOzi5MknPnPgfmGKrZxn2vb+YmJZJurvvM7I4fWiyH4o+KFDIY3hjedukBBERHtwR2b00BZJZeyVDkNQ6Bt2qPdjLoywVrbmDhsBsM5ObxPPwEGYAY8EqllbyVUWR43e5GeAiorVibtxTagvtMTVb08+K0H62huxZM8d/+CpXJk+kZc/Fw/jdSEF3iB6Gslfa6CATV7qqg4C1HpzjrZnoKIpU4uVgWth5GWoOqQ1x00SYQqtjUer5ZWsfhKVbX910S4RQu1SkujuWQKUgP83Ba1bs50D58P8h/P1y9CFtEMtob5uJo9jvq/b2AGVPY/lJDBTRAXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXYL7XCdjn34p96lZiyL7qaGzK0aKUfngqCJWrYgtDM=;
 b=TjdjSWXmAsoy9hHF3pFZgPcB9zKxisgcBS1oqq92yV87tajEieRY+fsqDtXjcfJdqt3+EhK9zAw79EoPiASBWnQHnnm2aRo7sFu5/Wa9NTAjY52C7RxgNyHgMRSEikg3vFe1jDLv8F2I+EuCMEYeSMfNNiUOWyMisgpZ70FUXnC58BZddba1oSulJ7J0sQCDAbTSum43we4dGaKh97HC4gel+XNgObrPpj73v6we/PVl7Fi149hCIzAWwY+z66YgyAaX9wQiz3u3zoba/IqwEllOGyTtGd4OYpOG9lR5pKgPzTdNNdgWt09CbGY+pQUuXM8rHoB0pS59uyHKon1blA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=newratek.com; dmarc=pass action=none header.from=newratek.com;
 dkim=pass header.d=newratek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=newratek.onmicrosoft.com; s=selector1-newratek-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXYL7XCdjn34p96lZiyL7qaGzK0aKUfngqCJWrYgtDM=;
 b=Pth6XV2IC08znbWY6LbUfmxi9XCD3cBW0TxUWbwqjsSwhxSjM7o5U9Gy5PrLi7ad9+jRfGq0BTLPbkxE8Jbz17WK0S2qpBz1u/8MKLM9VRrzdj79RBploeS5YLjjludzC9ihbKqLuX2bjMPbsjMzmBaLw1aBBVVB/HYEPVpcfGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=newratek.com;
Received: from SG2PR01MB3286.apcprd01.prod.exchangelabs.com
 (2603:1096:4:80::10) by TYZPR01MB3968.apcprd01.prod.exchangelabs.com
 (2603:1096:400:3a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Tue, 22 Nov
 2022 02:47:25 +0000
Received: from SG2PR01MB3286.apcprd01.prod.exchangelabs.com
 ([fe80::57bd:57e3:c12f:b6ce]) by SG2PR01MB3286.apcprd01.prod.exchangelabs.com
 ([fe80::57bd:57e3:c12f:b6ce%7]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 02:47:25 +0000
From:   JUN-KYU SHIN <jk.shin@newratek.com>
To:     sforshee@kernel.org
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        JUN-KYU SHIN <jk.shin@newratek.com>
Subject: [PATCH] wireless-regdb: add support for KR S1G channels
Date:   Tue, 22 Nov 2022 11:45:52 +0900
Message-Id: <20221122024550.11415-1-jk.shin@newratek.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To SG2PR01MB3286.apcprd01.prod.exchangelabs.com
 (2603:1096:4:80::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR01MB3286:EE_|TYZPR01MB3968:EE_
X-MS-Office365-Filtering-Correlation-Id: 883d66dc-465c-4300-e4a0-08dacc33e2d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I5Nop8og90iXdFl4ycBdcHJLQt8UJoLwtUY4GeMLbHS7V0HJooewO3SOOLy4mLjbTGdYrYgQnotgcn9ncd50PclYt/3BicYCdx4T6JL4HmTWsFKS65OExM8fdYEE2o8YWQhTlVvWI0fnL3pmG5bnotHF3WEY1zr8V73xtXwyVXphhVtTZhjVERFhCMn4UevmYo6vl/GiK+gJNuolx6l1J0uzk0zqHRvznKyTr/RIxWzVEMC12PHZWG2CarkA3sbBVPULZvQfQkqBl4OTOS6hdQJTqD6vQ9/bYbL7vCw3UWLp9gwiyvGLG17OWIqOS7Hw6EwpAJ96jJ4a1ZeNKH8+hiuZbx1dSnzlUQRLynxPeTj+sDuIIhpGWK6fpG1PYZSG/Wra71cnvL+ZC/m047fo8jwtxbJJwFw3A9ptfZChQWMrE4EKV86wNoduUoBwA7p90HLh1LnAb6TZ9BHbuPXPtgVVUsurlEwENcZzQdFAhgq5yPv1PX9Bp/t1jTbxsQ4bnBKx+BN+1JOme95bl8SsagQynIS5YCOtIqyhTw7CzXXkBm184SmNPGtLaWJrxjqcN1sslOfTr5ujoKlj+SA5ZyySu69ZXaqwjGYC+ZPmIJtA12+XoeaZMAfS9bOUzNaLwY8I14hEzG/tQ+dPWsotlesFJs1RdWHgGc1COoKZxGfYXwoklX1WvHeY67NfuK/KVvclx9x99VnnF5n+fqi6bNyNNHIAwxqxMNFqnslaBW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR01MB3286.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39840400004)(396003)(376002)(136003)(346002)(451199015)(38100700002)(966005)(38350700002)(86362001)(4326008)(2906002)(8936002)(66556008)(5660300002)(66946007)(41300700001)(26005)(6506007)(107886003)(6666004)(52116002)(6512007)(186003)(2616005)(1076003)(316002)(8676002)(36756003)(6916009)(66476007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGRDM2lSV1JPSUxJOW5Dencxaks0OGtaOUVlOUsyT2lzejRsak9vNEQ1OWxD?=
 =?utf-8?B?SnFlanBNOHhRVmhEYU04c1p0a1NpNlJyT3FXWW5paElURitJREY3NHdWcTRx?=
 =?utf-8?B?U1R1cmVOL3lvVE9XR1M4dkJQbDJFanBCaGhYVEJPWjRkVGlTM3EwWlY1RWsx?=
 =?utf-8?B?U2ZmTEdVOGtnak5PYUlFWXhuTEc4UE9rRUxnRmlxR3YxaS9CK1hidXNlWW1j?=
 =?utf-8?B?M3RYZTMwcG5SQUVGbjFvVmViSkk0WmhOV3UvWnlzRkwwTEt1WGVkWWkrbXF1?=
 =?utf-8?B?Y2VGYUR5UjNER1N3aVM3VnhKRnpINlkwaEhod05sakZSNkIrM21FcnBza1JO?=
 =?utf-8?B?UWlmMDFidW1DbVdDRnhHY0Jxd3JOMmtyRU1TeE51Y2VyV0ZrNnJrcDE3cXZD?=
 =?utf-8?B?OUtsNk9WbDgxUW5lc0lPNEFKUkV1L0pibmxFZVNhNktWSzFxZmRtNzJmc0g0?=
 =?utf-8?B?WEpWRE44cXU5NUVYSm15a05tU3J5Ky85Ulg4ei9hM2ZWMk1vNUo2ZTFrVTN6?=
 =?utf-8?B?TEhRZlJBbnRGS1RMQ1FPcEk1cEttK2JnZWZyRzJPZU44Ly9oL2V4aVVOTzUv?=
 =?utf-8?B?Y3Bwem44NVkwRXBBaDJhaGdBdzVHZjBRKzlwLzdlYlc3ZXlNVG5GTUZZWUVS?=
 =?utf-8?B?TVh0c1orNG5nTm5ERkhZU0xwdDlVNmVudGxBTENId3c0a0FTQm1HTVl3OUQ3?=
 =?utf-8?B?TC9XQ3BmOHNmN1JMTkljR0MwcUo5TUxjZ1diakNHZ2JpMWIwWmlzKzlSY2RG?=
 =?utf-8?B?VlRSaUNqa1c4dnBiUVpyd3U2YVRjWlViRW16UytpWXV2dWtGYkpVV2hXTXJH?=
 =?utf-8?B?d0w0dzlJeTZab2R1NGhtdE56eGhsSFlpcnExb2wydS9oTVBmbGExdGxoVXlJ?=
 =?utf-8?B?SHhOVTNDbDlZaGVwdnB5amk1THJtOTBUYUF2SFFVamtNV3RpbGZoNElaL1ov?=
 =?utf-8?B?Uk96VUVZNlN1aHB2YThXQTJTbVBBNEE5TkNtekh1OENmR2JyalhEeXhmTlpK?=
 =?utf-8?B?MkdIK1hyN202WTVHSHYycWg0QURMOU9oQktibmpXMUxURG1YUXE0UUFyK002?=
 =?utf-8?B?dCtzQ1RjM0prNllKKzFMVmdKekwycFNJMlN6NHc5K0Zzb0NMc1ZLQkNybndj?=
 =?utf-8?B?L2dVVjNORDNoQ05GT0pqaHRwUFB2VTRzR2Y5VDVHWUd2SFRmcld5TXp1Tmli?=
 =?utf-8?B?N0lUQnYzSC92elk4bmFoOW1SOEpPLzFneUF0RStmTW44SkQ2emRJK0VHZXhB?=
 =?utf-8?B?UFY2NDAxZmpWRXNFSU5KKytkdDdPVjlZZENMdjZMS3BZbG9wdWRJcnBFYW9a?=
 =?utf-8?B?N1d1WEw2OFZMTldiM05xY2l4ZTc5R2dBYU9ZSmR2eGRDWS9IUE1EaTdaOU12?=
 =?utf-8?B?bW9wWmhBSkp4NVVFaHd6WjZQTjY5Q3c0bkY4K0g4QVZmaytwdmRwZkdVeURK?=
 =?utf-8?B?eERWbjVaMlhseTVGbVdDL0ZMdDU1OFE3cXVaV3dEWFczNEhYbEc2MlN6ZDM2?=
 =?utf-8?B?dDVOVlFLM3NPSjZxbExoNFpxbHdBMjU3VmR5OEw4WHhieGdDZzZTUzA3L3h0?=
 =?utf-8?B?dnNoY3hGSWRqNFYwcVlUTEovcEY0U0hLN3luUlZZRzYxSW9pc2tmQTl4dWsy?=
 =?utf-8?B?K2ZNY0toSm5idWx2bFREZ3Jla2FKUHN5OEZCSnVjV1BzNVJXSTBVdWxCV3lr?=
 =?utf-8?B?eWZxZkZKSjhHbTFsMkJxZ1ZsdnpiczBMWkhBNGt1TC9KOEZRQ0c5UFhZYWh6?=
 =?utf-8?B?SkNxZlVRVDVPSFFQeUVBZ0k4YjhsRExhMTdQS1ZIbjJhQSttVTZndmZ1NWc1?=
 =?utf-8?B?bjVvN3dSUXFoVEJiWndKWE9YN2NjUGJyV28wd25sWmplK0hsN3AzQVNaL2tM?=
 =?utf-8?B?b1l2R0J5NUxkY041bzlhVzg5dkhOcGlYY1ZlYytLbHgrRVUvdXVZNlhCMEhy?=
 =?utf-8?B?VDE4NzhocnJPNUllcTZVUUN2c1Q5U1czYTg5eDdBT0NBclBNTE9rRE5Md0RT?=
 =?utf-8?B?SWFsZG1vcHpWcTF5VDRocXM1cnJTMDlUSFhuangvSUVmSmZXVGJvVkZBR1g0?=
 =?utf-8?B?MDNZQ3p6SERDWW9XOE5VbTBreSsxMGNpRWZpdVkxL2pOYURCZzgyd2J2NVAr?=
 =?utf-8?Q?UGa64BKvaDUTVViZ+cYBH5xil?=
X-OriginatorOrg: newratek.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883d66dc-465c-4300-e4a0-08dacc33e2d0
X-MS-Exchange-CrossTenant-AuthSource: SG2PR01MB3286.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 02:47:24.9741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5494d269-d3ac-4a40-bf0d-8c29f5475032
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzZBwLk5RjJfdwC4PUwJuvSyW0VmXGZG9IC5lK/kzUKFADyTWN8CwONiyrZYzr1NjJqhrtAJWVy/9kRjc2cJLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB3968
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The 917-923.5MHz band is KR USN 1 band, so follows
the emmision limists described in part 8.4.4

The 925-931MHz band is KR USN 5 band, so follows
the emmision limists described in part 8.8.1

Signed-off-by: JUN-KYU SHIN <jk.shin@newratek.com>
---
 db.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/db.txt b/db.txt
index 012824f..1b4fe11 100644
--- a/db.txt
+++ b/db.txt
@@ -950,7 +950,14 @@ country KP: DFS-JP
 # https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000205195
 # https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000205187
 # https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000206568
+# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000211335
 country KR: DFS-JP
+	# S1G Channel USN 1 (917 - 923.5)
+	(920.5 - 921.5 @ 1), (10)
+	(921.5 – 922.5 @ 1), (14)
+	# S1G Channel USN 5 (925 - 931)
+	(926 - 930 @ 1), (17)
+	(926 - 930 @ 2), (20)
 	(2400 - 2483.5 @ 40), (23)
 	(5150 - 5230 @ 40), (23), AUTO-BW
 	# max. PSD 2.5 mW/MHz in 5230-5250 MHz frequency range
-- 
2.25.1

