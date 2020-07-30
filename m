Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA91233265
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 14:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgG3MuJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 08:50:09 -0400
Received: from mail-eopbgr10119.outbound.protection.outlook.com ([40.107.1.119]:5635
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726535AbgG3MuH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 08:50:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmRuSE/sFI3zSR7woH86LgQCci16W7HjqmIEZSOgg7tptyncIW/fn2sE+kOI/Sthl6sLAMYIsabS0U5a/EEHfeOtBUnIVoNNBC04zkM14s+yomCzqfpLyPRPtcuhDIdGT8+voSsEDA1KbThdH1GeYcCCeLYQxZPBkSx1gyfWOlyYskbR2WGm/We2ME+yfSh5MtnaCFTMW66YjnBtPOzup5b6dNW0Rfa40vqTLN42yqiGb55Y7r7rK/xqsTUTyvY2q5kZSsT3SrJKTLhDiwuJgqBNb5qWNAk/XYyn3W9KOwsoj//4CgG7tZoIAXTWEYLVYFU1DtUnWJtjbRlWYMolug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oz5t78Gv7vpLiS7J9Aia7d4ZQPUvY4UV0mdMCpdW9Kc=;
 b=C6FtZkkuZem5R7qVgJ37UK3A1uiY8ZOXbJ2LVtPEvNk/FY8EjdwuaWPH7U0XzlCyOY0f6hrJ8hUAjmpaUZLSmQdFXeZfC6C8NMI5JF7ZR4evtHXco4FhqyREmHG8AYBBP93qyjtduCMBNihLvi8SiUpkeVBQXuGkvs6k5hsJ9cHsGShnBuw2ij9/oVGbocBdMDbftA9rmAq6r3T+dcttWkWHlAG6nnItvGPHSeXEjyp43us1L5/Wso6jYNZ1TI94VE8p1bPPgYi/oPPUtKhI2F/tFzn1qjE7OrSj6hPSSRfHoxFnWNM3hWWrOAhyq0M031gt9cUD/GVKp3Nxei7wdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oz5t78Gv7vpLiS7J9Aia7d4ZQPUvY4UV0mdMCpdW9Kc=;
 b=hCl+QNTW1dOvZMzoTb06vJaVz5N1DM48TB3kFhbGxH8FnhELxAOKG2m2ztzgCWWV+sM7LVzmfdxdRNNoZMm2DinlseBQPrMa46xJvECJkFWGsaLNKm8AV4XhfpFrCC9CV41hCgTQXbuxjH58wu46eG5gdfb4LZfj/yf1JpyaCdM=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=bang-olufsen.dk;
Received: from VI1PR03MB3166.eurprd03.prod.outlook.com (2603:10a6:802:32::30)
 by VI1PR03MB4912.eurprd03.prod.outlook.com (2603:10a6:803:be::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Thu, 30 Jul
 2020 12:50:01 +0000
Received: from VI1PR03MB3166.eurprd03.prod.outlook.com
 ([fe80::4b3:262a:b605:14ba]) by VI1PR03MB3166.eurprd03.prod.outlook.com
 ([fe80::4b3:262a:b605:14ba%5]) with mapi id 15.20.3239.017; Thu, 30 Jul 2020
 12:50:01 +0000
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>
To:     ath10k@lists.infradead.org
Cc:     =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Wen Gong <wgong@codeaurora.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        linux-wireless@vger.kernel.org
Subject: [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
Date:   Thu, 30 Jul 2020 14:49:23 +0200
Message-Id: <20200730124923.271429-1-alsi@bang-olufsen.dk>
X-Mailer: git-send-email 2.27.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P193CA0123.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:85::28) To VI1PR03MB3166.eurprd03.prod.outlook.com
 (2603:10a6:802:32::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from capella.home51.bang-olufsen.dk (193.89.194.27) by AM6P193CA0123.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:85::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Thu, 30 Jul 2020 12:50:01 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [193.89.194.27]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f72f20d2-7dff-484e-afa6-08d8348712de
X-MS-TrafficTypeDiagnostic: VI1PR03MB4912:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB4912BAD341C6DACE595BB97183710@VI1PR03MB4912.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: orfyT46MQ61Mxb5iPWFd2WpDoe+OrogMXwNbSH58bqPcQSs+AFAEM5nNBEsicahGoYrnMWGfU9w/CwrAjpoHHbcnbejzG6V2tckdFMKzv6PKZ5Ki/HIwS2OKeENLP10t31JNMIRKogDiCBrHUWOUO5QCDQbK68Ct71hIHDMMHGjLlbpbnJPzaYFMvZ2ajbVl058NsikCJqtD/jG++Go/P/NMhFqQnrPInSFOIbfLDmr227Zy0CUWZ8S9O1ea5+ZidSr+4FZzJhed1thDqiW8xsLyt53tt/Yog+yK7FdCncVO2F/hbz1nGPtnae6nQML0YKb4JYywUnCYDj/b7XAAKTAFVtEVHuIelvvlpFq99aNMmdSWO0eIwLncDl6dkbSqzLQ+QSgayJ2NtM0n6+pm7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3166.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(39850400004)(366004)(376002)(346002)(186003)(26005)(2906002)(16526019)(8976002)(8936002)(15650500001)(8676002)(66574015)(66946007)(52116002)(7696005)(66556008)(66476007)(83380400001)(956004)(2616005)(966005)(478600001)(4326008)(6486002)(6666004)(1076003)(5660300002)(316002)(36756003)(54906003)(6916009)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: sNpkBKPb3YBOESAUnfiu/4JBciyMA0kKXLNdwiolR6OvfQSeXiZzAW7y7k83hy3Bs+Ngcnto/BZAKaP1aoBh4DdHmcTsYf/I6+PrxqCSrusoHHvXBBYhPW/901RiE4cHid0VMpBu6AEog9IAH0+nC9Bj0WJE2biF7VzxF7sSp1HB/KgijX6XWWl1Ie2IfLr09K2jBR1BNrebGD2x0q5helGUj27CmVFs8ngCckNspTAZWVmThLptDfVycoHe7tMyIBWtMEXcmWN1iXC1sag9aYUG9gYta8xjTNCvMdxgJ4Ft6GAdAckn652PGjC+2q3sVIE/w7bJzvaoGjZyKHWFCIayhSF3g19CbH5XPecpbkYi+/7csw1aBlm9dblMR+7R+l0n5YGSlVIR99f0PoWMY8v9xMMzXNSG8wysxDmu8rChiqhXgIZlSNXmFOpVbW7I0XXdkbrgQEY3K5869ll6zmWgRmnj17IfE67DmLCZ0fRkUCcOM5WwBgYK4Aw2O1zT+E3NZtFhu4Sx68x+hMbN174QLPBhdnyOCgW87M3PFZFENsWNU5YO3XDDydK1WMbY75Ee6PCUz3NMv8f2z0isDSsi0NS9W/DvVpK05+LJdEn+nh+bKzaBAICI3mTymwvhfnA6X0bCSoIIlv8o++HjkA==
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f72f20d2-7dff-484e-afa6-08d8348712de
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3166.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 12:50:01.7757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGlnu4KcPTmoVPJM5zU1e3KtbbBki+c4qKLMxb+i9HoD04LRAGnEllcmz6Js/LIhib0zLZmXD7hztNSXr/9jEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4912
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This reverts commit 2dc016599cfa9672a147528ca26d70c3654a5423.

Per Atheros documentation to manufacturers, the EEPROM regulatory domain
code 0x0 must always map to "US". In particular, it should not map to a
custom world regulatory domain. For references, see [1] and [2] below.
Furthermore, __ath_regd_init() has a specific condition to set the
country code to "US" in this case, which emits the following log
message:

[    7.814307] ath: EEPROM indicates default country code should be used

The patch being reverted mistakenly maps 0x0 to the custom world
regulatory domain 0x64 - the most restrictive of the world regulatory
domains. The premise of the patch is that in the case of EEPROM
regulatory domain code 0x0, ath_is_world_regd() should return true. But,
as stated above, 0x0 should not map to a world regulatory domain, and so
the function should return false. The original behaviour, whereby
NL80211_REGDOM_SET_BY_COUNTRY_IE is ignored, was correct according to
the manufacturer's intent and should not have been changed.

[1] https://wireless.wiki.kernel.org/en/users/drivers/ath#the_0x0_regulatory_domain
[2] http://article.gmane.org/gmane.linux.kernel.wireless.general/38410

Fixes: 2dc016599cfa ("ath: add support for special 0x0 regulatory domain")
Cc: Wen Gong <wgong@codeaurora.org>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: linux-wireless@vger.kernel.org
Tested-on: QCA9880 hw2.0 PCI 10.2.4-1.0-00047
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 drivers/net/wireless/ath/regd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/regd.c b/drivers/net/wireless/ath/regd.c
index bee9110b91f3..20f4f8ea9f89 100644
--- a/drivers/net/wireless/ath/regd.c
+++ b/drivers/net/wireless/ath/regd.c
@@ -666,14 +666,14 @@ ath_regd_init_wiphy(struct ath_regulatory *reg,
 
 /*
  * Some users have reported their EEPROM programmed with
- * 0x8000 or 0x0 set, this is not a supported regulatory
- * domain but since we have more than one user with it we
- * need a solution for them. We default to 0x64, which is
- * the default Atheros world regulatory domain.
+ * 0x8000 set, this is not a supported regulatory domain
+ * but since we have more than one user with it we need
+ * a solution for them. We default to 0x64, which is the
+ * default Atheros world regulatory domain.
  */
 static void ath_regd_sanitize(struct ath_regulatory *reg)
 {
-	if (reg->current_rd != COUNTRY_ERD_FLAG && reg->current_rd != 0)
+	if (reg->current_rd != COUNTRY_ERD_FLAG)
 		return;
 	printk(KERN_DEBUG "ath: EEPROM regdomain sanitized\n");
 	reg->current_rd = 0x64;
-- 
2.27.0

