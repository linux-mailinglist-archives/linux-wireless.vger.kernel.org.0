Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86281F57A1
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2020 17:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgFJPVa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Jun 2020 11:21:30 -0400
Received: from mail-eopbgr700104.outbound.protection.outlook.com ([40.107.70.104]:36321
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728446AbgFJPV3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Jun 2020 11:21:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLphncUR1oIiFTnxD7MKDfNNU9Z8PNqYRop/T1tFD9oJuQ5t6KTYYlD6MY49a7DrsKV4PoKrC8JzjqSB1wtnRQyXQA+r2eHAiILI5RSA/frqdLKJYeR4c6u6X1nEkaVEMOJa7RMaVbyaIquMouw7Ro4VfZiuLiNIRZL/WeIvQbqgqkNcVI3R/EYk4WCVG0RmKuCM1i1Q7E9c2ca5K18rW6Obx3UJga7HRZve5FHOOflNOlyFNCS3sfLimZb8eAN+zgVZ07mp2dET/sM48GvRfcYg+Sa7ouDkYuN220UkbNBwQV+SjWfnG+KJ5bzUAAiyMSxJbionG2YnZhr5a3bisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2PRGbJjvoky2oUijMQwOLo+jmU0gf3d4kuO80Uz1uI=;
 b=el/ER+H8SRQFpR0ns8TJ2K9sh7wzlJmkDv3ilyiv4/iyxB+ZScf3Gmca6BTkaI3y6HOjgKhYIdohJkasIWkluV/L+6kB3rP2AdKe6rATQWo/m6GOx2iaYHH+bHi8VmqBQLrgEYLsVO5PovvsZLp4CyO5wIutvUZkoEr5q6iN8dXBdHq50dIYxUQlcwAYnGHhITi4EAOrkZRkX5XVU6xRZHsNpf41ACePfmir4H8+/ITWfWKzxuW4Y/ggp2Z+4ep39SgYWoCMeCfNWYyyYunNLeeClfk5a7CXQn3IHeHbrWRpWW6lHg+WZbHgLGZE2Qi4ttarku16+dUDZq0Q+s5YpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2PRGbJjvoky2oUijMQwOLo+jmU0gf3d4kuO80Uz1uI=;
 b=PEpiwUtRYsbw9xrTgWnFNqcDXUoH7LlKOb7WeZU6Zqa39i9/m8u3W05s/orhmAI2m2JdP6vgjNCuhRvZ6H+ej00nIPLQiGoawd1RNaT6lkKXjFl7ZgqDtem86mHrhdDKkjstzao2DeaVmljbL86eIIgmIzmhnfM7LxHlfta7eZU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB3912.namprd06.prod.outlook.com (2603:10b6:a02:86::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 15:21:26 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3088.018; Wed, 10 Jun 2020
 15:21:26 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Double Lo <double.lo@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH V2 5/6] brcmfmac: fix throughput zero stalls on PM 1 mode due to credit map
Date:   Wed, 10 Jun 2020 10:21:05 -0500
Message-Id: <20200610152106.175257-6-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200610152106.175257-1-chi-hsien.lin@cypress.com>
References: <20200610152106.175257-1-chi-hsien.lin@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:208:239::24) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR08CA0019.namprd08.prod.outlook.com (2603:10b6:208:239::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21 via Frontend Transport; Wed, 10 Jun 2020 15:21:25 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e8925c1-8107-46c8-0faf-08d80d51f137
X-MS-TrafficTypeDiagnostic: BYAPR06MB3912:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB391207621C1D9F31EF75CAA6BB830@BYAPR06MB3912.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rNTXFVFTjbYV317jHfC8/DU8VUt965gpgHNpSRhrbaM9dNU2mBrLFp/PheMZLzF/7DC5R6dE6hICn06qAbMEXEkH+yuZvgta8073gcMi0mSkkaBD2F9Z/bm9IdbEIlZmQbciE2XY3GGV7DF9lY4S1vJSoDXAslkoookQ9B90TTbs3J+S85Sx9npabXgp5NkbcrhqGDo9guWrmxNqz/czVwiutrkIBBgGDrWwwG2NWMFGVJ3dfWQ8IsJITib1zR/qT7mz3OuT8eaJ1GtjEW19LBgvImpaw7NK0TflRcedsyZHNGZk8dnt9DkuVHspsoft9D4htuRHxYIzkIT9vEyyWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(366004)(396003)(39860400002)(136003)(6666004)(4326008)(52116002)(316002)(478600001)(1076003)(7696005)(86362001)(83380400001)(54906003)(6916009)(107886003)(186003)(5660300002)(956004)(2906002)(36756003)(26005)(8676002)(66476007)(6486002)(8936002)(66556008)(2616005)(66946007)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: x9drNuKzINetoUoPojjb5MkH8+CONyS5ozQUhc/UNwdWj7jHR460x2ETB8RDskcfHCyzQRHvntbag+YVvVfRA8wuCGUhjwnYhenQnoLGyQwVFiKfb54kZdgX74KdbxgGjw4LGpDeYddcv1IcNlFwQK0ijLb08NG+b/YewhADqK/QEJQ7GOPWSoBVpk+kBoZOtGpjqDDiu2VGJo8xirZDlGfTb1NZpUumjCppWyMWu3n8egAhoGgQOEk3eOf174ryktbbYeHT4iLilyDYj0rsCp+8lFPR/M3d6GIF0la8TRf5C/ODeRuecYG6otmJZdbR3OLufBZFPrie6HJf/reBX+XXV+XCdEAKw2Z9fuIZjS7bkjR9KToikXDrLUc2+5drYzPGQxZYaPTplvoGaru20VQo81o6moQ4lnahNl7bkEbXcx2jTC1X8oaV5CsxwcVG6/aAhm2jDVsSf7IPhLkAIuN6Qk7B7Th0oSAK/UZRUWg+I1AfbZaAmxFC68R4KWKB
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8925c1-8107-46c8-0faf-08d80d51f137
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 15:21:26.7942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9IMVrBpjIwwJDFsfSQK1avg4eXvsJrh4C16G8NPPswokxaY9jd73jKdVMILfjkL6yH9FpIN/Qj3XrmbBVWSL5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB3912
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Double Lo <double.lo@cypress.com>

This patch move the credit map setting to right place to avoid
brcmf_fws_return_credits() return without setting the credit map.
It fix the thoughput zero stalls issue in softAP mode when STA
using PM 1 mode.

Signed-off-by: Double Lo <double.lo@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
index ce8c6ceafc58..ab4526223a93 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
@@ -1193,6 +1193,8 @@ static void brcmf_fws_return_credits(struct brcmf_fws_info *fws,
 	if (!credits)
 		return;
 
+	fws->fifo_credit_map |= 1 << fifo;
+
 	if (fifo > BRCMF_FWS_FIFO_AC_BK &&
 	    fifo <= BRCMF_FWS_FIFO_AC_VO) {
 		for (lender_ac = BRCMF_FWS_FIFO_AC_VO; lender_ac >= 0;
@@ -1216,7 +1218,6 @@ static void brcmf_fws_return_credits(struct brcmf_fws_info *fws,
 
 	if (credits) {
 		fws->fifo_credit[fifo] += credits;
-		fws->fifo_credit_map |= 1 << fifo;
 	}
 
 	if (fws->fifo_credit[fifo] > fws->init_fifo_credit[fifo])
-- 
2.25.0

