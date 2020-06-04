Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119341EDDE6
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 09:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgFDHTA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jun 2020 03:19:00 -0400
Received: from mail-bn7nam10on2107.outbound.protection.outlook.com ([40.107.92.107]:50472
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726411AbgFDHTA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jun 2020 03:19:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RA+Zx2kmzGTlehEM8LU25ho7CP/tSXnPI1WKXH08WRwMPhXZAFsNI547M3F9LGv5X3tZYbvH4KtpSUl1VziJUohTn1QUnxkOX3hFQY6fFA5CcNzr5CQ9PUK+KXX4MrF+6LnTMUdRwYLD1X5K85FGfuQA14GLOsrqXpwWhxQvka1A66GFoLcKkqSfBQ4Ym4xXBzbbWLeCL+Xqnxk8PImqjy3jGsW5kXqwiqSvcWMkngD3GYeZOoeaOzTk+PqWX+y9Li2z7dq4tIsXX3jhJPYAV5IsiQBlWfQrwD6RUQqiEcxkSmte4hSCaLfqM4Ufqlu/YnS1V+IwlIXBPpiFUcTOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EEWxLAn4JisYgPe95IvJblyHv1izWVJ9nxhtQRuTKs=;
 b=hs9xgRCGH0Hy/IieQVcWI68Epxcin5FPphZJ0bSDMc748bwuMzsPkqoWMS2MrbyJTfTRQbBPWWaeXd9LgFDFJT7v8hWWM7pLrzP4FF+odBpV7cvJlgwRW5Hi+Wls2Hfc9ZENiouGqk+2OrpA+ygYZ1r/dY/0KsdCakmpK6nqrF/yoWSaT5XnwC0ntZhq3EFip81B/2gduGLzDUXscu3HLQoIibclI+HqjIOjDj3CTpEOyBfmq8TQj4w1geUytI99jPJ4pPcUh27gUcZDkKaNQ27NVJkahMLWQ7Ulk/g1BSPuPZdAN+gKe6EozCbsFNLTp/BJzEqvGnI1yi0wzZRE7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EEWxLAn4JisYgPe95IvJblyHv1izWVJ9nxhtQRuTKs=;
 b=dYACxgBbvY0SHCWtCECXwg/7aACliBVM0IplkX0/xXuOZ0Iig9CpTbSJ74RTATSNFqjev3bQmJLtj54+RcJkzFSbSI0Bk03/x2PLDEOsIVmn0JAIS3zyPFLGHE/ybRkMZWZguvv3BpPp7eYR9l3HJ/CNZGrz+frhUiblSYlleiU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB5146.namprd06.prod.outlook.com (2603:10b6:5:112::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Thu, 4 Jun 2020 07:18:57 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb%5]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 07:18:56 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Subject: [PATCH v2 4/5] brcmfmac: reduce maximum station interface from 2 to 1 in RSDB mode
Date:   Thu,  4 Jun 2020 02:18:34 -0500
Message-Id: <20200604071835.3842-5-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200604071835.3842-1-wright.feng@cypress.com>
References: <20200604071835.3842-1-wright.feng@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0049.prod.exchangelabs.com (2603:10b6:208:23f::18)
 To DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from iot-wlan-dev-u02.aus.cypress.com (12.110.209.245) by MN2PR01CA0049.prod.exchangelabs.com (2603:10b6:208:23f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Thu, 4 Jun 2020 07:18:55 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a6b5ad76-b1a6-4cf8-e714-08d808578b48
X-MS-TrafficTypeDiagnostic: DM6PR06MB5146:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB514638A14625E30C24042EFBFB890@DM6PR06MB5146.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o122OfIu6GC2SdJiPXC0uwwGyDTMeDDJFDXWcx0Rfeqzb+RQzEckqY1JqDqm+34nouj/Z61g72ePQ27Du9b8DO8x27io0WPa2xCJL3qAypD7UHTgMvNBcv4k3D+rIIZIQAzzJ5e49nofFpLE4aD36x68lHV87HTEduiNmrv9wnP7vJsTtf50eZhOiZ0bUB3yfJkR/iAY9UhNPXvOnfKi7oPEJ/4VHPjtKe92eJ70A8SNPKWKHLQ5u6aCCNtApa5vhf6/Qiw09MBUkNkdOkQkfsx1VhV0xaY1pk984RXWWKQC70MSWHIJfWzvOQh4GZbB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4748.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(346002)(396003)(366004)(136003)(316002)(54906003)(6666004)(26005)(16526019)(186003)(2616005)(52116002)(36756003)(956004)(7696005)(44832011)(1076003)(8936002)(8676002)(83380400001)(107886003)(6916009)(5660300002)(2906002)(4326008)(86362001)(6486002)(478600001)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: NDqOk47HBKW/AbXpM8Uz1f9Jd9ffzy+8wO+yjHtwqh4zeTcs6YA8/Jr82mJ6fdwIofy2LnVl2y6HdJ16A//w+p0QSg3UefiOLzLPzTsYERX8tEunJgSmBAivR745FILcASetYZvbuZnmpjo7kCFlIA7DgGdb+cHACqg2Ptlp7KU8h9FhlCwd/rB1kfqQ0gV/KtFkeUrViH3mdgAyxaJuhC6UFSTFfoAq151lDgvma1c8agAcaD2heuJZegdLnQDSqEq7/3E2fpYMc8Bh17/pXp8nyV+fSPB2jlwyZ5wvkuQ4lJ0hQxrqB5PU3YWqo8LUcmVl58iZ5O7pXKuApTaufXp6eqlaQIMNyK2nSZNT6X/JfvQkftC53DSZmjeyyPuYIltJQgNMCxjVXNd7g5CpZlU6i1FmElz5QbkBS0EZTTQ+t4GqIHQL4Vr29tKmGxGVoT9PrI3YnyjbkIAZnKUBk2Rm68qfnsCoNrzEZD1WcF4ACoA4v+hA6rL8Umxq85bk
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b5ad76-b1a6-4cf8-e714-08d808578b48
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 07:18:56.8511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55SDyfhzlztOhmkh7oWOHyRSqW2rWN1NXgUj0QAGv3xotNM5A7BDRJMz4d56dDRfiNmtRb2OVyAfnm9P4q6jDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5146
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The firmware state machines are not fully suitable for concurrent
station interface support, it may hit unexpected error if we have 2
different SSIDs and the roaming scenarios concurrently.
To avoid the bad user-experience if this is not fully validated, we
dis-allow user to create two concurrent station interfaces.

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c   | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index a757abd7a599..8c1801fb59e7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6801,7 +6801,7 @@ brcmf_txrx_stypes[NUM_NL80211_IFTYPES] = {
  *	#AP <= 4, matching BI, channels = 1, 4 total
  *
  * no p2p and rsdb:
- *	#STA <= 2, #AP <= 2, channels = 2, 4 total
+ *	#STA <= 1, #AP <= 2, channels = 2, 4 total
  *
  * p2p, no mchan, and mbss:
  *
@@ -6816,7 +6816,7 @@ brcmf_txrx_stypes[NUM_NL80211_IFTYPES] = {
  *	#AP <= 4, matching BI, channels = 1, 4 total
  *
  * p2p, rsdb, and no mbss:
- *	#STA <= 2, #P2P-DEV <= 1, #{P2P-CL, P2P-GO} <= 2, AP <= 2,
+ *	#STA <= 1, #P2P-DEV <= 1, #{P2P-CL, P2P-GO} <= 2, AP <= 2,
  *	 channels = 2, 4 total
  */
 static int brcmf_setup_ifmodes(struct wiphy *wiphy, struct brcmf_if *ifp)
@@ -6857,7 +6857,7 @@ static int brcmf_setup_ifmodes(struct wiphy *wiphy, struct brcmf_if *ifp)
 		goto err;
 
 	combo[c].num_different_channels = 1 + (rsdb || (p2p && mchan));
-	c0_limits[i].max = 1 + rsdb;
+	c0_limits[i].max = 1;
 	c0_limits[i++].types = BIT(NL80211_IFTYPE_STATION);
 	if (mon_flag) {
 		c0_limits[i].max = 1;
@@ -6873,7 +6873,7 @@ static int brcmf_setup_ifmodes(struct wiphy *wiphy, struct brcmf_if *ifp)
 	if (p2p && rsdb) {
 		c0_limits[i].max = 2;
 		c0_limits[i++].types = BIT(NL80211_IFTYPE_AP);
-		combo[c].max_interfaces = 5;
+		combo[c].max_interfaces = 4;
 	} else if (p2p) {
 		combo[c].max_interfaces = i;
 	} else if (rsdb) {
-- 
2.25.0

