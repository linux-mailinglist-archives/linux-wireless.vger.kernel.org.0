Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8E11F38D9
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 12:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgFIK7d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 06:59:33 -0400
Received: from mail-dm6nam10on2129.outbound.protection.outlook.com ([40.107.93.129]:26720
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728446AbgFIK7b (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 06:59:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Id35zqMf2V3Vxyv0bt20ipsPeew1WhcSibJbC9pbm59T5LnneevUrIq0L9KjxtlpvvmGL24SGN8Q825wQkXWUrPplr6Y9RvvDb3B0nhryNe5b1kM5Gp/HADNSHxUriU7lLnlxY9VyRTJIfN0ZhkqzC4jrDIj3M1tqXxPmM0j97t0ccnU5CSPySQ9BkFDKJvYlq5V0Dg+Ts5Yi/GStrb9y1Y1Dw2MG7fuHGKy5ttSqtgqOOe/RpScNV0njsWRQvUf0KbWM++F30WTSBBwTbuf6QcF4YuCg48z8IaKBXNqbp8lD6CTCQJ1pG72PEEHxKnOU26cvZ5fJHLPTNQ/ghs90Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6hCBd/N3JOcl/l1jLoYrGAz18ECTLlK0LAuxUBiMCQ=;
 b=BPIgjrureciik3rRlIVRBmesC5dVU64zDvqneTVE5FbpeH4f8D1q30HnWJ7iikJZE6T4nwKSfnaYm9+dfKJCfWbmdsExACugKcXy1Fzt5jAT8FsI9MFyFJqG6lEelqDxSo/FkgWyl78jKkmsRQvyjA3lSr2kDhf645blv8PfGo9XSFj0dLVmR3sa7DfqJgkzm+//dhnMqlo6IMTa/ZKOmt6mce6SN6r9+mVlU+g0wifP861c3+wHtkH0acfzsfpY+qZaRnIoO7z+XtYFVaqytzM0b/y3rRYb5tH7psulJYWr+7Y9JJTGUztYj52DcNDZyRDZiGukQEe08/8W2e9LNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6hCBd/N3JOcl/l1jLoYrGAz18ECTLlK0LAuxUBiMCQ=;
 b=SfdOo/ejbW0mFhDAE/40fg+T9jnvAympTivIES5C7PVhN6WI6tjVDvhh7Oo0sJc6JdgWgOreVLUew4BVpeGmocn6B+3LHBo6HkXlx7ZglkYlSjU0WqsFrCS234pcJSpGDH/UEKJaR4TLsCNfFCIMz+RqLkm+MvOUx5fRsFKqhxM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5064.namprd06.prod.outlook.com (2603:10b6:a03:19::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 10:59:25 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3088.018; Tue, 9 Jun 2020
 10:59:25 +0000
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
Subject: [PATCH 1/6] brcmfmac: allow credit borrowing for all access categories
Date:   Tue,  9 Jun 2020 05:59:08 -0500
Message-Id: <20200609105913.163239-2-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200609105913.163239-1-chi-hsien.lin@cypress.com>
References: <20200609105913.163239-1-chi-hsien.lin@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0068.namprd19.prod.outlook.com
 (2603:10b6:208:19b::45) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR19CA0068.namprd19.prod.outlook.com (2603:10b6:208:19b::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Tue, 9 Jun 2020 10:59:23 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5ffebc05-edca-43c9-7dd1-08d80c642c4e
X-MS-TrafficTypeDiagnostic: BYAPR06MB5064:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB5064241699112CBAB7C47291BB820@BYAPR06MB5064.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wO43NuKFsZ3uAEzTcjUEUYe9iTot04l5bxSjDw2lx0jA/QqVBGMA2B0Q81pUM5kB7KTJdXIwtSeW3r82la5gXFJN37Umc+KLHRWR93EqYsgiMKnniV51UYgfcPksK+qS3usVngS8ha980ATIYAVP8YK0J9k0yiuJJUCU4yVfYbaI8/mzLo/KPA0M9mfovCnHjB4PcKZNOCLJzBrK63ATv/nREvxoBTKvsygCJMNV+guSrz5yF8k5wlGy6HN0JEjs4kUsQoV+KEw/0A+qq58tGxdFJfuzktwHSD28d0aJqsZ5C8ftjPxeSL2W+4pfdnp6/svrabDQsHLcrZmfSNXgpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(396003)(39860400002)(366004)(36756003)(316002)(2616005)(52116002)(66946007)(8936002)(956004)(83380400001)(16526019)(4326008)(2906002)(186003)(5660300002)(6916009)(7696005)(8676002)(66556008)(107886003)(478600001)(1076003)(26005)(86362001)(6486002)(54906003)(6666004)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: RDF9Paa384Pl6W10rUsmGL5ZHgIHvcl9F/R/1mi+ITkaqSOgWFI+81YdB7FJfocx7ISGxB3HL/1jIlM3qn7kvDq4Hd2luMCLriY4gVLUDtY/3W+NaMcW7HE1+MLBdd/BSZAqirOU4JZD7DN+74JpVEtHqS52Dk44N+V1yCvl8HwUvPpIh/tNzQ6V8rdFBG3/J1n4UHhkGWVe3d0vywOJBCYmAOVPmEBMx7XgwV4o8liFW18ng4gIUJE1Nb/T8RuhIyFEcsi2hDN4K7MjbL3QSs8XLS1WqOWlafKb5RfUvZRT+KF7qCgxfxwMpw8BY7AzkfqH9J9E+GPNQtrCgrJv80H9SiSaEKm6gKYhfkb1g5ND3u2qxIZ6UdN6yvL9HUqV241b3I1zMUzW2mI2hApe5pOk0M4KMP2cel8NbDCCoFVh7bFZLG2610DmoLuY+dM0YWmcVwokGZ3t3XSB3+8xdtUO3+QYYq06oyc8SkUgX0/tEnbnAHa6jZ+RYMtvSVNr
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffebc05-edca-43c9-7dd1-08d80c642c4e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 10:59:25.6077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +10Wz+DUwweIIuoRVVUGuuLzyw9B0DMvd9CnkHcEOyzA6tuXbU8XsRsLMnCau7MBzR/HcduSOTbbTo+Ngeb6XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5064
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

