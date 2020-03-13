Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 670DC184543
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2020 11:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgCMKvJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Mar 2020 06:51:09 -0400
Received: from mail-dm6nam12on2096.outbound.protection.outlook.com ([40.107.243.96]:56545
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726475AbgCMKvI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Mar 2020 06:51:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNsRQwppupq2UznSR4uNRKhHzwMKHtJ1mL523fJtGXE1ePU8E3YNQLh8EcHvv01voAvc3hsr0s1bv78/MrDDpi4yn87LUCbcplPQRlOljjH1n/3IbfYmGHsBOSGNJx+6Ed0KS7aClRsZwjG8ePQZ4sXtAVYzZEVtkYTJcUTGCHPgNWHSvhrKh6PWyswjPi2Dz3Up+9ToZ/AZPt5u+fpFKWJC+Ttkn/nAzMoa+QQVfPVK4VGXq9HEFgmJjNXlWge0PHloZy/ZKJs6rY/p7rMhrPC2O8ls5dfOXwE2Ti5RR6RrVIgZW4P/0y3NCzEoGYZXPIjJJiPJT2IYCdBL75986g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHjIAUP8pch+iU7C2NvkHDOGwlDOkgTnRp9+Y5FR1pg=;
 b=n+B7TDL+VVyyEko4fbMsrfah/92jakQHw/V6nitglZ8fRM0YPRgq/LOkd0BTxHB6kyNePHz7nZ9HhEpivfWRz+yyG9HiWL/S+405TnA2ma09tEJXE876UoDliXltzO9YIwJHMbML3y4fGoiYmILE53sd5/Pc4uIdC65vnazF5E1NI2xnKrcPJQn670RTd1dRGqRs9+ejXFySIFRrxE1wR0wDlBwPPKcDSTeJhWl0xD3fXFxTBta63Alm5WqRFCHrzqh+adnk2H3BsgqymxfZToP/96SdJ4KG9nyPFhI560NjbGZKqkoLIbGx5fYGGmXcYLlK7hj/cRpb11p9wUMRdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHjIAUP8pch+iU7C2NvkHDOGwlDOkgTnRp9+Y5FR1pg=;
 b=LRMwv2L3rmA3yE+G3Q9/rHVhvqf5yMKMQx1YHkI/QS5ZP98vLmz3KdBJjIct0M9OQ5mG9xAC0hzg8HyMIcIA3z6jlSRYDIWolVUX3fA6/VEz4PEQ8xBlYNqX/A+FrGw/U7gPpu/eLD47Oc981BYCvGYP6bFZYiuYfxIWJYBeTqM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5303.namprd06.prod.outlook.com (2603:10b6:a03:cf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 10:51:06 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::3cc3:7b1a:bd7b:a0a9]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::3cc3:7b1a:bd7b:a0a9%5]) with mapi id 15.20.2793.021; Fri, 13 Mar 2020
 10:51:06 +0000
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
Subject: [PATCH V2 2/6] brcmfmac: Fix double freeing in the fmac usb data path
Date:   Fri, 13 Mar 2020 05:50:16 -0500
Message-Id: <1584096620-101123-3-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1584096620-101123-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1584096620-101123-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:207:3d::31) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BL0PR02CA0054.namprd02.prod.outlook.com (2603:10b6:207:3d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17 via Frontend Transport; Fri, 13 Mar 2020 10:51:04 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d29ed669-5008-444a-4837-08d7c73c6e2c
X-MS-TrafficTypeDiagnostic: BYAPR06MB5303:|BYAPR06MB5303:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB5303C496D47E29C29BA0D67DBBFA0@BYAPR06MB5303.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(136003)(199004)(6486002)(2906002)(54906003)(107886003)(4326008)(5660300002)(6666004)(316002)(2616005)(66946007)(66556008)(956004)(66476007)(6916009)(8936002)(81156014)(8676002)(81166006)(478600001)(26005)(36756003)(86362001)(52116002)(7696005)(186003)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB5303;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xLSL6lMHe4VR1yVy1GRbyTPBG/BzYFm7MSN2NKCVcO+WZywqJS6iHbGS+PRxxIGAlLrrzbFijd4D4ErHQIFgCa3HH/NxPOAGXM1xdisrwQ0wkKRH1WFBxbGcJrItb6A11VAP3dn+pAuZ6j7iQSxs8J0KGvS6lAorA94cBfLpMiZ+pf8a/d2td3//OmZJ5+DV8JXYNPXOX6zkxzWtuoUCEkgQRhGVwoXW36UixEGkTNkY1+p75ENaYMbmJ8R8mDdFX7EDi5q0NgTd/GazbKe7FrrbVwvj1BYYTPODVQViXxtjRt2nWDjHV6Ttq/HsBFgInCEUUq3avGbg/gdTNZGJK/iHLeyC+EOnRj/DWHOiodgbR1WbRjnjlX3tDodlQBFI/32m9kcVabmG/Vp6udGMnFHQtLT9DwnXeZr/mEaBBIVBNPZYUKtjCIY/AEyMWHW+
X-MS-Exchange-AntiSpam-MessageData: D6xdpGrEdzb5+Mv6ZCKUbd0NuhkGhTlVgtJCgy/Cn5Gt8+Sk5k8T4Wt5Lsun86XEXMb4QtqEz7SatNS2E7aHyKL6olBpS5rHuT6+vKIa0/ZT4ZGMcRA+MeN0JtUaLnxmEkaNUYInqfrLigZAh1FNrQ==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d29ed669-5008-444a-4837-08d7c73c6e2c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 10:51:06.1522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7q76BHBM5WxCnUeLrArM3lF1X+uYhaz3WzN5ivWoDvhXp68eltw9v5gq9Re480k3jxFLzovrXm490ZISxR4aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5303
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Raveendran Somu <raveendran.somu@cypress.com>

When the brcmf_fws_process_skb() fails to get hanger slot for
queuing the skb, it tries to free the skb.
But the caller brcmf_netdev_start_xmit() of that funciton frees
the packet on error return value.
This causes the double freeing and which caused the kernel crash.

Signed-off-by: Raveendran Somu <raveendran.somu@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
index 5e1a11c07551..10022c765354 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
@@ -2145,8 +2145,7 @@ int brcmf_fws_process_skb(struct brcmf_if *ifp, struct sk_buff *skb)
 		brcmf_fws_enq(fws, BRCMF_FWS_SKBSTATE_DELAYED, fifo, skb);
 		brcmf_fws_schedule_deq(fws);
 	} else {
-		bphy_err(drvr, "drop skb: no hanger slot\n");
-		brcmf_txfinalize(ifp, skb, false);
+		bphy_err(drvr, "no hanger slot available\n");
 		rc = -ENOMEM;
 	}
 	brcmf_fws_unlock(fws);
-- 
2.1.0

