Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC35B19227F
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 09:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgCYIVE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 04:21:04 -0400
Received: from mail-dm6nam10on2113.outbound.protection.outlook.com ([40.107.93.113]:25385
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbgCYIVE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 04:21:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqtEV48y4CfnUrD/xoL1kn2i5Ur+2yc/LFHCCGRCvLA05rjiTTwfdRhQjZZAxKy+nMrkRzcSXwReJ/q3fd8HlYF0WMQyERxNxCUAsBk9YtIYgQ7C2HZ0sJCvUdf03KT2PYlqwf70tuvXn6YYYOmn095r/LJptY2PyPO3Sf2M+e3Pun21yPy9kPFUikLC6Oj6ADJ+2fI0IP+3Jmv1zMRnd+cKECbcxf4LyBjgSf4D2ZWz6opGtcLfe5gei9bxFwofYDzQJSAyZBZU44+sGhnEBdqHoVOaUflzF+MIlwMxNGz0nk22AZXEbQ8J07kigx5x3bagb9ABmkueWKUMT4e0EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tp/XWRTwvr80437RcBtCuvYDovgnHn+kzgYBZ3/mbyk=;
 b=EeftBN1e2cFJ+cbI6kWyuqE5qt39j0lkQP63ydDfzh/F3V/83i/SgIwqarj/FV5FBRN2xbw6r/4c/lPGFi39HfAYtwk8ibkkyvNrdzRWrk0CY8J1AJdWpewcR2RtEniuqXl5+GzR2sBxI6KiqW6pKrQsaVs41QF9PJdyKZpG42RT7MKd5U0H1qzp7EftJs5BULkTu5enYz8QuzqmMY8/PXK3fCWo9Qq9y9q9NkQ+4qhXzQlu4vrAp7K557Crcb1/IV6mq06+kz5h1BJGx+Rv8YDHEVN1q+R3SQVH3siemrNmiWpDN3I39KywUpjby5FAxbY2/iCliS39rnR+4RodXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tp/XWRTwvr80437RcBtCuvYDovgnHn+kzgYBZ3/mbyk=;
 b=iaPItU+Pxz+t4bJVQLvD7JrCC00BVk4Rbx1oyvnW41gn68zdJEMjXgRgt4J9SAJvULffhhFtwynMdmnrwoqkAT37ERXxqYwW1jm+vKoGv3dwgrACdVM/o0XE4wKtb/2n+QF6n4QHYQUa4XGHo5WHjkmxNXmbQWrF6e5/+x0cLKc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5189.namprd06.prod.outlook.com (2603:10b6:a03:cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15; Wed, 25 Mar
 2020 08:20:55 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1%3]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 08:20:55 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Raveendran Somu <raveendran.somu@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH V3 3/6] brcmfmac: fix the incorrect return value in brcmf_inform_single_bss().
Date:   Wed, 25 Mar 2020 03:20:26 -0500
Message-Id: <1585124429-97371-4-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1585124429-97371-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1585124429-97371-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:a03:100::40) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR08CA0027.namprd08.prod.outlook.com (2603:10b6:a03:100::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend Transport; Wed, 25 Mar 2020 08:20:54 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6d4635c3-89c3-44a2-94b9-08d7d095701d
X-MS-TrafficTypeDiagnostic: BYAPR06MB5189:|BYAPR06MB5189:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB518976FC6DBCCB6129F5EE89BBCE0@BYAPR06MB5189.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(66556008)(8676002)(81156014)(2906002)(66476007)(66946007)(81166006)(6486002)(8936002)(6916009)(16526019)(26005)(956004)(2616005)(498600001)(6666004)(54906003)(86362001)(52116002)(7696005)(186003)(36756003)(5660300002)(107886003)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB5189;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n8mNemSU5Td0qfHX1xvQ3IGN4Zeh+lZpkuOZV5UsNHnkOlHGg8gnYaPwiD0z1e5ifL2oT7ooxXpaGvFlnZuiCeQbxalb7Zqk3yFFEVBGKl1zrmcagUx2w4VHtccJ36EbzLU0ClkTO0rgDulsrNDZfMeh1DifNFu3tnXYnLcPIBQrCjrZlxDM0jF5LXJRdfPG7FhCYER8TZXIOhUFYrWc8/DkzWF64pjv9SWvdXE2X9NEMjFyek7Bo8RNROh5MlwACLrznONCmPY+1JhrCUkWyc1PclFkFegOKULpbTgDN7UNL1BtEEV669l1OALeL7N3IbN5JcPO9bFnabnhVrAK5PQvp14zTKg7lKmK81CxPRXnSV1tw/Mzltb59iAeavnk4FyWbDmI7nKl48my8PC6WvI7k1vX60kHd2d89BubuI5wAaqxRVjpc4VAMNnmocuI
X-MS-Exchange-AntiSpam-MessageData: 2oTbmh43Uw+pTRVroibQFW8SPAzVUt1VqYF+BEJmbq2vUGpSzJAQnX/piEqHP5ynnfBkCuyKDLbdRuXVCIj5VqaoeUbl/rUpY7shIkAb2s+RVdAPFq1gQalnBwl3SCDwALX/eSgajhRp69mbJjRQiQ==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4635c3-89c3-44a2-94b9-08d7d095701d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 08:20:54.9963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UOEDeLwp1VMhPTYjKoFHBLqm6X5j1PZxjoMx3R6msRqVrndRxwvhNriT1XdEoAEs9nDo/T9FYe4OgcNqiS3tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5189
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Raveendran Somu <raveendran.somu@cypress.com>

The function brcmf_inform_single_bss returns the value as success,
even when the length exceeds the maximum value.
The fix is to send appropriate code on this error.
This issue is observed when Cypress test group reported random fmac
crashes when running their tests and the path was identified from the
crash logs. With this fix the random failure issue in Cypress test group
was resolved.

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Raveendran Somu <raveendran.somu@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index a2328d3eee03..2ba165330038 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -2953,7 +2953,7 @@ static s32 brcmf_inform_single_bss(struct brcmf_cfg80211_info *cfg,
 
 	if (le32_to_cpu(bi->length) > WL_BSS_INFO_MAX) {
 		bphy_err(drvr, "Bss info is larger than buffer. Discarding\n");
-		return 0;
+		return -EINVAL;
 	}
 
 	if (!bi->ctl_ch) {
-- 
2.1.0

