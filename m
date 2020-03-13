Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E7E184545
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2020 11:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgCMKvN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Mar 2020 06:51:13 -0400
Received: from mail-dm6nam12on2102.outbound.protection.outlook.com ([40.107.243.102]:56420
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726414AbgCMKvM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Mar 2020 06:51:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JERAecs64pb2DMsKgYYPpJcXJP3YOBR5ZuuSMAvD4HlP3Q1+ZhAvSe4WOMtl2FxcKoskewJC6J2ukcbGCMjKVFoDqTfjVC/yuh+oRG6XsklCAmsOaaSW37trLEqEn7vrcnxj7+naJMynE3GNK7hpgPqNPXdWptZ/QJ2eJoltl21FKbShqQt/wT6q8/wVSqhwWX6vauO/0ZKOCMooaECZb2dZ8qN3OxYzg4fFodGsH6UN0LUde0RN+Hp9t8JUP6wQLc9sTisSQ1akPv67GcKOiMbF5XoYC7ce6Vf1+K0pLPxBs1/LcfKVNR80fd9UQkcVd0vjnHu9ERd6GvH9TvT7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVwKgTRJ+ZGENUgkjH6k1eLuK8rNyFEdHOaSWhrh/ZY=;
 b=RXsMxhQjJtrp5GgT2Qgksh60E+nx1hFasD0hjCkDIZ2dEQ6ZvjfNQQgP0gtgBUtdyL+mYZQ5UBtK0tdyfO4+D0Xh78YhD9zbiwxVcjLQ2x+ZL4TvnyO8u/F+e9/fotD+yFU5Uleeq+NYpDLuH8fAUuPZJMEBlhH0x7Fw9POxp6TdHFhgXB1dNkjbPpK7BHVj3/JtxsvT69A5cV0JniQWOOLBMxqzr1wLozSz8i4dCRLu8jhhq8t6LnWQbR3DCGKqQaMTjdzdbNZKEimr+bqjgUo3iI6dAHVggowoWi8mB1y0J03RppZx97T6oceXJZSgrCwPgc8AylVCXADz8KRNtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVwKgTRJ+ZGENUgkjH6k1eLuK8rNyFEdHOaSWhrh/ZY=;
 b=VlmlSkhx5+UYu2CJK2QRuXghnpODr9GU0+HuYagB2rRbPKFYn1yoXtoKsib2D5TzA8di3TvVqOd3hymsxWwDeSgFEjA+j2afldJj3u/IPlg3NXwYPbHbZQmkijjUeel6m40OWTxfpY8jaNfxW257DRthWJZInOVe5luMPwF65rM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5303.namprd06.prod.outlook.com (2603:10b6:a03:cf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 10:51:10 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::3cc3:7b1a:bd7b:a0a9]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::3cc3:7b1a:bd7b:a0a9%5]) with mapi id 15.20.2793.021; Fri, 13 Mar 2020
 10:51:10 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Madhan Mohan R <MadhanMohan.R@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH V2 4/6] brcmfmac: increase max hanger slots from 1K to 3K in fws layer
Date:   Fri, 13 Mar 2020 05:50:18 -0500
Message-Id: <1584096620-101123-5-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1584096620-101123-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1584096620-101123-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:207:3d::31) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BL0PR02CA0054.namprd02.prod.outlook.com (2603:10b6:207:3d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17 via Frontend Transport; Fri, 13 Mar 2020 10:51:08 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cc41ef87-4fab-4b65-b588-08d7c73c709b
X-MS-TrafficTypeDiagnostic: BYAPR06MB5303:|BYAPR06MB5303:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB530377969BCE87E6E1FD630FBBFA0@BYAPR06MB5303.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(136003)(199004)(6486002)(2906002)(54906003)(107886003)(4326008)(5660300002)(6666004)(316002)(2616005)(66946007)(66556008)(956004)(66476007)(6916009)(8936002)(81156014)(8676002)(81166006)(478600001)(26005)(36756003)(86362001)(52116002)(7696005)(186003)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB5303;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pkj8xQdt4gzXD4jh93Eh3jI+Rq1jRVahW0CYsnelpbqKvfjqbAa2rGS71Y8GmsT3/FDLzB0elz93bSUuAedm+dxsWoUWKooqLlllG/9UBzzWDVD64/Wh6oolwjLODIer/iKeVi+8injhPs7xz3mcXv41PtEAJPYcZe8Hv59NG2k4EUCo2yMqJgJw3CRlE9qn0v/LQfM3LJ5MLt//DQ0j8zlGZVCp8NEohYlrcNbagcKPBsxpphX+D+9b2FOk9b6mfHQ8C/rlNgmYbLTR2eQAK8S98wBfrmDjU43HPpc32GZBifeA9XedgtN9Gh3YjsnCodfCb6YJwpkr4nAEzl6BG+SnSuxd2DPA1ebqGzDphtWuNYkkh8YZ3GBktgdxXN2AUgGFtsmpWQvudoQ9/7RjIC237l7FjMhRzFHSDBb53PS24Ncr/6UpBVq3eCvGSTPH
X-MS-Exchange-AntiSpam-MessageData: Ty/B2zfmbsuZCw8mZvU5oV9cih71lfaLFIR0Y6hCIk2hLTAAe5bwXCc1SXwOzfmG0dtgPTvhLb4VaTWGgMCmLcRhie9Fn1sVPGvr/TyaBFIUaTOcX3IPL0hbwaOqqMgGoV/LtDkN/8qlHhM3qQcJug==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc41ef87-4fab-4b65-b588-08d7c73c709b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 10:51:10.1919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2vMu++tPblok3uEA528NtrWp7/lonrDk/cLF2kzF7vBN8f7eAApFyqFvK9gaXSls8NZoo/JJeMvNETVAyKuWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5303
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Madhan Mohan R <MadhanMohan.R@cypress.com>

Will enable FMAC to push more packets to bus tx queue and help
improve throughput when fws queuing is enabled. This change is
required to tune the throughput for passing WMM CERT tests.

Signed-off-by: Madhan Mohan R <madhanmohan.r@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
index 10022c765354..8cc52935fd41 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
@@ -404,7 +404,7 @@ struct brcmf_fws_mac_descriptor {
 	u8 traffic_lastreported_bmp;
 };
 
-#define BRCMF_FWS_HANGER_MAXITEMS	1024
+#define BRCMF_FWS_HANGER_MAXITEMS	3072
 
 /**
  * enum brcmf_fws_hanger_item_state - state of hanger item.
-- 
2.1.0

