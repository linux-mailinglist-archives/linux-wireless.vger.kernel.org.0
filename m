Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9C01F579D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2020 17:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgFJPVW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Jun 2020 11:21:22 -0400
Received: from mail-eopbgr750110.outbound.protection.outlook.com ([40.107.75.110]:38746
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727102AbgFJPVV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Jun 2020 11:21:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7t1lPhwOnmghy7DhZ19YUvyaWEMe04gK1ZYPM4H8qMtq7+gl+qwHhUqSBJo4i7ofIUsfMax2RFmBfdsxyJfzbnyjWL4pYtCZOk7TKy1EF16aXw1LERkFKh83WTT9dZcGV7NzAyqMh8K5MT/GOgv68Jw6UIrpmfaYY9cVag0sNUKr36w92YiYiAZ7ggxBy8MbU2KHOwMfUl5zikf9HpPQVTVFMxLdx1tjJibzkSHba92lrtfaLD1bOsxR0XNAWpY/uLVpeAi8Rl1WNnoCuZLqTa0+po8LrXfwehj0wql6sSYn3AoCQg2sv2QSRbQXC6fPpLmQ2MYWvPTlK4VhMDq/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6hCBd/N3JOcl/l1jLoYrGAz18ECTLlK0LAuxUBiMCQ=;
 b=C+eTh22xa5xzH6GFIw0V66XIAczqaUFX0ZV6mTCZWsB0KrL4NYbNbqh4oftBibX+jdWN1qcQLKmQ61wWofkkfPwYk22MDkosvAhue7yI2n43sZ/xPhaEchHTHRFfpDhc3DUtsShk9pkr/SOdR/V2u19/7lJXlyu5kkwRMEpo6gMAp2ziVz9A3u+tsVXZBQNcTNGCyCZX+WuUvBMyfeMYP6taqJOMDiahWnBkQDeu0sZYkEGdzACrrUxb/53f/VUp2MOLIrSLBphJ3k51KrcVMhidWNMAI1xlQ89Z9F6pkqU1Ofoh5tdnrsbCmSku2d5QoK/DN5N2dvCyENOedhgUhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6hCBd/N3JOcl/l1jLoYrGAz18ECTLlK0LAuxUBiMCQ=;
 b=FtG5wBg927ggKLD+8UfLWcenBsUhst8sPOsKU/UOkC1h3hbTg1vQ6c3dlwS6rJfYydDTcP9EsEGasYNO90/L4la1/zGCC+lETEoLw1v0EDxGylBYxbdpe/2H++lQYYzMyHEy5RdVtW9Y4o7PrY3HdXsNZ70RY+YxgAttyN8XuA4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5621.namprd06.prod.outlook.com (2603:10b6:a03:ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Wed, 10 Jun
 2020 15:21:18 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3088.018; Wed, 10 Jun 2020
 15:21:18 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Raveendran Somu <raveendran.somu@cypress.com>,
        Jia-Shyr Chuang <joseph.chuang@cypress.com>,
        Chung-Hsien Hsu <stanley.hsu@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH V2 1/6] brcmfmac: allow credit borrowing for all access categories
Date:   Wed, 10 Jun 2020 10:21:01 -0500
Message-Id: <20200610152106.175257-2-chi-hsien.lin@cypress.com>
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
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR08CA0019.namprd08.prod.outlook.com (2603:10b6:208:239::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21 via Frontend Transport; Wed, 10 Jun 2020 15:21:15 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e409f7a0-8d64-4e58-b4bc-08d80d51ebe3
X-MS-TrafficTypeDiagnostic: BYAPR06MB5621:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB56214522BA9336C34F57905ABB830@BYAPR06MB5621.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTalAY+PqSA13QJi5E1jCAMWKnmTTEeTL+uH66kiPgkEGHq2L3m2E4N8iyZlfPrYExjfow7eWSSNiFY+m3Vqzx6SyYvxD9kWfK9uG/3+rdO/uKW8ng6bYft1V7QqnPGbEnGPmZJZjQog4SRwrzoA1F/EdwGR/Rbhk/1Ngni2Q6e0gHb0ep6aaoFv2nImebQNq70/hgKGom+C58dAWHiY4oUlMSuZn+/55sh0/fXiuOeHk3QjKPdizRLb2Scgh96FRv4cLCzShMsXHGAZ3eH6axBCX9VgvpXGGKK1Sgsh+c7E4BkZg4KOUZ9EJ1EHjpP3HIyrNhV28gZ2nzkOtFHEqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(136003)(39860400002)(346002)(376002)(16526019)(107886003)(2616005)(956004)(8936002)(26005)(1076003)(6916009)(316002)(6486002)(186003)(6666004)(2906002)(8676002)(7696005)(86362001)(66556008)(4326008)(36756003)(52116002)(54906003)(66476007)(5660300002)(478600001)(83380400001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: mIPXTI5IMECyn1Z8SV2KgXKWzp4o+JUZcMZtR1qfaoRpMiLb+HHjUaRZpLN8mxxq355JLgTmMGuq4KrXd55pQp7h58oR1wdPqjmg5fkXGFTubLix1pvyhks6ZS1odB4g0lC4ejxA96Mfzhg/BD6Ra40dF882pmByNaQUXE3gEzRSe82+xZ+PlYfy2fffgJNMwNCXt9Teo9DewyVfC98e7zy0/XEE/O1BUamQEv6vK3ZyBQYeNCK05w2YClZwHI6SuYm5lQgBGwo9JPKBCp7+xc/NqP7qjl7TYFXBs65Cg7rL2ATyDpALp3rdYNld+6IUApA0Crr0dw07q/pbOil43fRpEnoXPtPBKm/nzE2np7aldrl4cbDyhBj+pFAYA2/MocxSPzdsiiFLPvljDyPv3cE788czcpj3SiQj4SbMbOxq4Fa9rsSry2XNzXg+DovJju3H2ptT5/dMfcYYU4wTALI1WAJSCI3767CY7kHBks9vOGZ2/fV46SBPvsmxCOti
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e409f7a0-8d64-4e58-b4bc-08d80d51ebe3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 15:21:17.8983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DP98hHWOYA4Iawet7blVgVZBZFFq5Y8dbtIfE+XUDnC30WqwbrRc/bcN/22SEWqrnoPqoQwLzxg9iN48RxyoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5621
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Raveendran Somu <raveendran.somu@cypress.com>

Current credit borrowing allows only the access category BE to
borrow the credits. This change is to fix the credit borrowing
logic, to make borrowing available for all access categories
and also to borrow only from the lower categories. This fixes WFA
802.11n certs 5.2.27 failures.

Signed-off-by: Raveendran Somu <raveendran.somu@cypress.com>
Signed-off-by: Jia-Shyr Chuang <joseph.chuang@cypress.com>
Signed-off-by: Chung-Hsien Hsu <stanley.hsu@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 .../broadcom/brcm80211/brcmfmac/fwsignal.c    | 61 +++++++++++--------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
index 09701262330d..d7c36af4b566 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
@@ -383,6 +383,7 @@ struct brcmf_fws_mac_descriptor {
 };
 
 #define BRCMF_FWS_HANGER_MAXITEMS	3072
+#define BRCMF_BORROW_RATIO			3
 
 /**
  * enum brcmf_fws_hanger_item_state - state of hanger item.
@@ -479,7 +480,8 @@ struct brcmf_fws_info {
 	u32 fifo_enqpkt[BRCMF_FWS_FIFO_COUNT];
 	int fifo_credit[BRCMF_FWS_FIFO_COUNT];
 	int init_fifo_credit[BRCMF_FWS_FIFO_COUNT];
-	int credits_borrowed[BRCMF_FWS_FIFO_AC_VO + 1];
+	int credits_borrowed[BRCMF_FWS_FIFO_AC_VO + 1]
+		[BRCMF_FWS_FIFO_AC_VO + 1];
 	int deq_node_pos[BRCMF_FWS_FIFO_COUNT];
 	u32 fifo_credit_map;
 	u32 fifo_delay_map;
@@ -1185,13 +1187,11 @@ static void brcmf_fws_return_credits(struct brcmf_fws_info *fws,
 	if (!credits)
 		return;
 
-	fws->fifo_credit_map |= 1 << fifo;
-
-	if ((fifo == BRCMF_FWS_FIFO_AC_BE) &&
-	    (fws->credits_borrowed[0])) {
+	if (fifo > BRCMF_FWS_FIFO_AC_BK &&
+	    fifo <= BRCMF_FWS_FIFO_AC_VO) {
 		for (lender_ac = BRCMF_FWS_FIFO_AC_VO; lender_ac >= 0;
 		     lender_ac--) {
-			borrowed = &fws->credits_borrowed[lender_ac];
+			borrowed = &fws->credits_borrowed[fifo][lender_ac];
 			if (*borrowed) {
 				fws->fifo_credit_map |= (1 << lender_ac);
 				fifo_credit = &fws->fifo_credit[lender_ac];
@@ -1208,7 +1208,11 @@ static void brcmf_fws_return_credits(struct brcmf_fws_info *fws,
 		}
 	}
 
-	fws->fifo_credit[fifo] += credits;
+	if (credits) {
+		fws->fifo_credit[fifo] += credits;
+		fws->fifo_credit_map |= 1 << fifo;
+	}
+
 	if (fws->fifo_credit[fifo] > fws->init_fifo_credit[fifo])
 		fws->fifo_credit[fifo] = fws->init_fifo_credit[fifo];
 
@@ -2005,27 +2009,31 @@ static void brcmf_fws_rollback_toq(struct brcmf_fws_info *fws,
 	}
 }
 
-static int brcmf_fws_borrow_credit(struct brcmf_fws_info *fws)
+static int brcmf_fws_borrow_credit(struct brcmf_fws_info *fws,
+				   int highest_lender_ac, int borrower_ac,
+				   bool borrow_all)
 {
-	int lender_ac;
+	int lender_ac, borrow_limit = 0;
 
-	if (time_after(fws->borrow_defer_timestamp, jiffies)) {
-		fws->fifo_credit_map &= ~(1 << BRCMF_FWS_FIFO_AC_BE);
-		return -ENAVAIL;
-	}
+	for (lender_ac = 0; lender_ac <= highest_lender_ac; lender_ac++) {
 
-	for (lender_ac = 0; lender_ac <= BRCMF_FWS_FIFO_AC_VO; lender_ac++) {
-		if (fws->fifo_credit[lender_ac] > 0) {
-			fws->credits_borrowed[lender_ac]++;
+		if (!borrow_all)
+			borrow_limit =
+			  fws->init_fifo_credit[lender_ac] / BRCMF_BORROW_RATIO;
+		else
+			borrow_limit = 0;
+
+		if (fws->fifo_credit[lender_ac] > borrow_limit) {
+			fws->credits_borrowed[borrower_ac][lender_ac]++;
 			fws->fifo_credit[lender_ac]--;
 			if (fws->fifo_credit[lender_ac] == 0)
 				fws->fifo_credit_map &= ~(1 << lender_ac);
-			fws->fifo_credit_map |= (1 << BRCMF_FWS_FIFO_AC_BE);
+			fws->fifo_credit_map |= (1 << borrower_ac);
 			brcmf_dbg(DATA, "borrow credit from: %d\n", lender_ac);
 			return 0;
 		}
 	}
-	fws->fifo_credit_map &= ~(1 << BRCMF_FWS_FIFO_AC_BE);
+	fws->fifo_credit_map &= ~(1 << borrower_ac);
 	return -ENAVAIL;
 }
 
@@ -2216,9 +2224,10 @@ static void brcmf_fws_dequeue_worker(struct work_struct *worker)
 			}
 			continue;
 		}
-		while ((fws->fifo_credit[fifo] > 0) ||
+
+		while ((fws->fifo_credit[fifo]) ||
 		       ((!fws->bcmc_credit_check) &&
-			(fifo == BRCMF_FWS_FIFO_BCMC))) {
+				(fifo == BRCMF_FWS_FIFO_BCMC))) {
 			skb = brcmf_fws_deq(fws, fifo);
 			if (!skb)
 				break;
@@ -2228,10 +2237,14 @@ static void brcmf_fws_dequeue_worker(struct work_struct *worker)
 			if (fws->bus_flow_blocked)
 				break;
 		}
-		if ((fifo == BRCMF_FWS_FIFO_AC_BE) &&
-		    (fws->fifo_credit[fifo] <= 0) &&
-		    (!fws->bus_flow_blocked)) {
-			while (brcmf_fws_borrow_credit(fws) == 0) {
+
+		if (fifo >= BRCMF_FWS_FIFO_AC_BE &&
+		    fifo <= BRCMF_FWS_FIFO_AC_VO &&
+		    fws->fifo_credit[fifo] == 0 &&
+		    !fws->bus_flow_blocked) {
+			while (brcmf_fws_borrow_credit(fws,
+						       fifo - 1, fifo,
+						       true) == 0) {
 				skb = brcmf_fws_deq(fws, fifo);
 				if (!skb) {
 					brcmf_fws_return_credits(fws, fifo, 1);
-- 
2.25.0

