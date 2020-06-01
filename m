Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8FE1E9EFB
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2020 09:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgFAHVA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jun 2020 03:21:00 -0400
Received: from mail-bn8nam11on2111.outbound.protection.outlook.com ([40.107.236.111]:48577
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727826AbgFAHU7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jun 2020 03:20:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SajcKI5+WUEgjF38jtEulj6AQgLc3WNznVkAqak/BM+UkX5l5Nse9kxO7J5FYYpfC5znEw1h61vvaqmUbMVsqYxnhdCXqHsOLFJRufAYxzYiV9bLJw9ghYlIwK4N2lejZ42JHcx3Ng5fcVIjk3/j87oq92qI6vSsvhjcHJqDyDVCAS0O+o+Yr9GMT6ZsXIRNzzMnBwSc1X1GzTLZA2oCB97ax4/ZDlsfNy1tPoXp0zQEFRYfsmFryf2tiSAJpmiwjsV8lcrzgP+Nb3GXw0X5nI99pAU5nHD0qWe4K+nZiiRflXALxjZln0cETpRwZVVO8D1PnaxG8y5YVE39SdRhyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EEWxLAn4JisYgPe95IvJblyHv1izWVJ9nxhtQRuTKs=;
 b=iYplFLroO+8D/z8R5jkFTQ11ezrGAtLQ3vspBDigr+PAAahyK2KcWQagZm9Ri/WinsWPTTRGI/W4VdJ19fZWI4RWBUEVwft8ShZ0MS31VYtG9iT8314O8kgK4ZdAy9qasKFXskqPGHGrG+A3IYTymya4pqNtf3XGwbE5WsEQq/PFVfnH0vHEwVGe2r5KvRBvCPF4YwFyNBJnILN6wqdjx4IjTpOvlMxFPuxCFt/wK8o/kZ8IetHA1sMn3L+Ztg7i3aVDTRPFo/j3OZbpTeHb6Kp2S0YlJf7JfTZQent3ZYXGM6QUY6YLjYNuf2d/kGMHsgxWdpFNF73HtSQxONVlLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EEWxLAn4JisYgPe95IvJblyHv1izWVJ9nxhtQRuTKs=;
 b=RSZrUiU22c8RMt7/y0GnYq/1eH371FsJvNDqJkCXdEIjXyWJ2cNuKKu6qcX6yGWekJzHpUoEPDo36jbGSg/T7fzYE7IKx2TxsT7e6iNg4pBrahGeK298c5D519bwLXot8a2jxSK5iFYuH7gyGbm/hSclR30RpTPOZ3GAsSunAmA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB6074.namprd06.prod.outlook.com (2603:10b6:5:10f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17; Mon, 1 Jun 2020 07:20:56 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb%5]) with mapi id 15.20.3045.018; Mon, 1 Jun 2020
 07:20:56 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Subject: [PATCH 4/5] brcmfmac: reduce maximum station interface from 2 to 1 in RSDB mode
Date:   Mon,  1 Jun 2020 02:19:52 -0500
Message-Id: <20200601071953.23252-5-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200601071953.23252-1-wright.feng@cypress.com>
References: <20200601071953.23252-1-wright.feng@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0048.namprd15.prod.outlook.com
 (2603:10b6:208:237::17) To DM6PR06MB4748.namprd06.prod.outlook.com
 (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from iot-wlan-dev-u02.aus.cypress.com (12.110.209.245) by MN2PR15CA0048.namprd15.prod.outlook.com (2603:10b6:208:237::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3045.21 via Frontend Transport; Mon, 1 Jun 2020 07:20:55 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd01fe6f-e589-4bf4-38e5-08d805fc5325
X-MS-TrafficTypeDiagnostic: DM6PR06MB6074:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB60749F8FFD3628FCD172C5F0FB8A0@DM6PR06MB6074.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c19BgR5V+GewOBuFIPvVGrKZquODkmNVqrVdvexGORTMQj3+MAQfpEyXDrDKyaMPYFUoOHzNFWtR2b5llVo7BVkS7M+Cfwrp+/qnGvSj0pvsCxJv+r1wCpxqt79QwHrHZkGQ1coiUpD763V4SRemeQP9Ryw3yTBD696wVa3B8C6gDHaAPN6+rl5jPrboEN2TEDmDME5b6IisuOqdNBO2BMIZtSTUB3I92DcTCu2CzXzHvBfP2BdEQizkp+0bEp4RCcgz/JF4F34kxFvx6buBXvL5XtnPu1i++RVIjnEq+qtsV/Z0edDZyChSJLpMBt8f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4748.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(136003)(346002)(39860400002)(376002)(107886003)(6486002)(83380400001)(6666004)(66476007)(66556008)(66946007)(4326008)(316002)(54906003)(8676002)(8936002)(36756003)(7696005)(52116002)(5660300002)(6916009)(44832011)(186003)(16526019)(478600001)(86362001)(2616005)(26005)(1076003)(956004)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: lZWicxpFZpn4kG/pjyQp/6OsLAYzYKtTVvbj7FqTDmnH/0ZZIr7hUlUAl19AMMuOcailCHmFcqfXa4Lvi9PNofuYAAPyjW/cTwsOIPkrdWUXu7KCS7jisCAcAWfD1xRcmr4uj5f2FC1jXMkqPs6Pp80jTi256uTVHE+MhwG0t79bBEIVHPYS7JOFYOLdKqUvzHxpfrH6Qwo4oSl328RKWcewG2BKsE/LGUugGSkkSnMfo1tOezZGUAeyetifPPe2IxDW/2iCgQP5TGyGii/5m7eo0t6zxlxriAYCZNWFMXuWRpLCcur6vLfAEHIaO2o8Obv/jL28+OupeAm29F5vnNu9LBxsZUrRd1UsmutQwk6KS5DjhJc23kPUaixvlv1+cw627ML9P4Xz0fNGSNN5yIPM65WACXxU4RqFltzNXQ0gzdEMFNcL+VfWRl816wTVPL0xbvlG7eigSgxdDuLpRdEFJlxx7aLO7K7cbs/0CIVqjRZzBucBsb5oxQw4qd+E
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd01fe6f-e589-4bf4-38e5-08d805fc5325
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 07:20:56.1538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uh2FipZG+exbTwaD/sDADvVVLEm90ubDnE7cIpsA4FY3ykZYOojSASN/RZX3FtK1MJp+kfyBSMTkugz2izek4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6074
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

