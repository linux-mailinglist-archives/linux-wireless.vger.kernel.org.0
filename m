Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67371FF8BC
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2020 18:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbgFRQIC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jun 2020 12:08:02 -0400
Received: from mail-eopbgr760112.outbound.protection.outlook.com ([40.107.76.112]:7750
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731674AbgFRQIA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jun 2020 12:08:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gx0RSXJqWfQH0Zt8AkB1JkMfDq3B5T/PuUXCa6YzYULMNBxytJUPjpvF+MrGRcw83mSfmxHg6oT7aAi4P86Sa98z3uF+P5BvSJi6JnYwrHVLNgtVRTOaz0tsvlAiuqv3gKdxPU8X0JhLbHN1gwxu16rrkTL6C0BEol1YjuJ/hXaxqPKVBWVDFAOeVSxYZLTBLWggudU/XPgrwjfUzGilVIcEJCakbmomlC6Mjj+UW0Wkdi2GOa8SzOEN905qUHEiHSETgYPYZFi076n6c7fOutrPFOCMiq9dv7dKDnEmGlm22ptdnSP/E3YBa6p2bpctnapj9kEUkkHhv1tv8Hg6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMmeJhq8cVm18APXEJqjyDDjf/ynFwRURp3iakrr+nI=;
 b=bNyvlyMa+Q6hi4LpDrexYdXZ3QwXHHxecwQGlY5zU/bMjBqX7Uzim4YmMNiaRb0HooHUQNwXqxwAc/5LKzJpzvDv7ntpQJm0VpLwaxpH890XdW469jIrEt5SPYrSjevKRqUOBLX/lafLW47p9cWDUu9/7M2LJXeSn5zyfUZ3ymwht9AcESicIeIy+Jyl1gn8v0R2DRTyz8I8pmZr70RY4cGjZi2r/ThTmzVwn7aprgALYp5hYZ/hVrT+CA7ZiEo041PnHxfhSiwtDTzRTU3gH97xHDsIF0nq1VfTrqmj2FSgb2RkdLlMsPizD82WrBVI9U3UaOqaJAXbRmmUFwcs/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMmeJhq8cVm18APXEJqjyDDjf/ynFwRURp3iakrr+nI=;
 b=UD84f3t4M6zYqmf8SBaOKh6gu1WL8K2O30ukSDpSnh9aNFNxdDiNEhT3VDwajzRZCzJtA3qXZrIut0uowdFiv/WUTj4qx0nVjATa+RiHkOZoenCql48WW226l6pM6X9K01jBaWMaX8pHBXYZr870WZbJVTMF0AZM0+4JQnK4IZc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB4549.namprd06.prod.outlook.com (2603:10b6:a03:4d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 16:07:54 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3088.029; Thu, 18 Jun 2020
 16:07:54 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Soontak Lee <soontak.lee@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 1/3] brcmfmac: Fix for unable to return to visible SSID
Date:   Thu, 18 Jun 2020 11:07:37 -0500
Message-Id: <20200618160739.21457-2-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200618160739.21457-1-chi-hsien.lin@cypress.com>
References: <20200618160739.21457-1-chi-hsien.lin@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0051.namprd08.prod.outlook.com
 (2603:10b6:a03:117::28) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR08CA0051.namprd08.prod.outlook.com (2603:10b6:a03:117::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 16:07:53 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ac1eaa66-9867-47c6-f134-08d813a1c1d7
X-MS-TrafficTypeDiagnostic: BYAPR06MB4549:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB45490CB7D9BFFACFD8EE02E7BB9B0@BYAPR06MB4549.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:605;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+0UiwDHuVF0m4TNbtCvQT+Q+Itl6NCQqkNLQyTyqDuHkk1C0u29wjilz3wi+adPMBCxCUxjYploYRpttlOJPY3n9J3jWooz/S2khpMAc6b1tG6o5LM9Kz4fkhhXpzXqImlbFxJmr+T1vFQMTCo1MKztYRRprsEBJrkivFRoLKeQ4oJtJNo9/eGrWQm1JhSGY5UiZF6KndIhI8G1C8x/n2YOZA9pjAwV49IdyVPmYuW20cY6ZPmIktWiR2JAhOPJZlkOouEYpujj4QcrAHxaT0Myy+89nwdIJNFXeQig1beRqXnfNKFulhDYqmDdzNhHEgynt968Jf3HBVUNo7MEoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(376002)(136003)(396003)(39860400002)(107886003)(5660300002)(316002)(86362001)(6666004)(16526019)(186003)(4326008)(1076003)(54906003)(26005)(66946007)(2616005)(6916009)(8676002)(6486002)(7696005)(66476007)(478600001)(66556008)(36756003)(83380400001)(956004)(2906002)(8936002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: qiQOwBiiNLZhptf8AAqaTRUaMTAjlwNXUAfoxlO9GzZZjOOp+TTL2eLLlanTscDSJ8LNDhhLYnv4m17wHYEGrKiFgV9kfF2uL3Q/jxdd6U6XT9eeeEBGJHq6bAPlpwkN4BRwKNFLG26IjtJYETaVsitLmPngNKPxznCffXqAKWdb/qCy9+FNfYZ04J2KD6nVaoX8JIpMEyhrxCPL+c9eShCixQpRCbvV/eaxmNP2gUUchZhDmGfgkEgBFIV+AauMHEut8k4rCzDewSopc6zBr1mSjeXxyurZqdvVEiKjhkCubpdJasZT7/2NXu8WzLnBaVOs8Plhgsps4aG70TFJV8YEY00hvxtwfRVsHA8vR4nhbdxYIL/Okd1iBWYYwu854vHpGicVlqdKqmj9jknja97/fAki99TcqM1cCVRUcKkDms5H1ON79Jgn6uXHS7K7d/UX7wPf+FbCtoozFgSqyCQR4oQ2+99oCLYBTVnC0H9kO52sr0xaBloKbjNFcMKV
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1eaa66-9867-47c6-f134-08d813a1c1d7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 16:07:54.2138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8m2FBl8CFRa66Q8hzR74Tl/WqSCkI8azcG/Di+JMPZ//FF6phXRaNF3tbGPOOX8uqeuAPWrPRHAkGmCmNMT7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4549
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Soontak Lee <soontak.lee@cypress.com>

Unable to change back to visiable SSID because there is
no disable hidden ssid routine.

Signed-off-by: Soontak Lee <soontak.lee@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index a757abd7a599..d3d1100d56a7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -4835,12 +4835,14 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 			goto exit;
 		}
 
-		if (settings->hidden_ssid) {
-			err = brcmf_fil_iovar_int_set(ifp, "closednet", 1);
-			if (err) {
-				bphy_err(drvr, "closednet error (%d)\n", err);
-				goto exit;
-			}
+		err = brcmf_fil_iovar_int_set(ifp, "closednet",
+					      settings->hidden_ssid);
+		if (err) {
+			bphy_err(drvr, "%s closednet error (%d)\n",
+				 settings->hidden_ssid ?
+				 "enabled" : "disabled",
+				 err);
+			goto exit;
 		}
 
 		brcmf_dbg(TRACE, "AP mode configuration complete\n");
-- 
2.25.0

