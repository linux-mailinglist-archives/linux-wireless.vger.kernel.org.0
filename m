Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B22DB15BAFB
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 09:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbgBMIpV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 03:45:21 -0500
Received: from mail-bn8nam11on2105.outbound.protection.outlook.com ([40.107.236.105]:59328
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbgBMIpV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 03:45:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIN/w3ovoXqk5Zi9bSvQ238LgoXpjoVzvWkufF0wMS/d7ldJtdbUjVvwwlexgbjLIb7bpGVg5XuDYvpjS+HHTaIai7YIy9kk/5ZSV94y+sFPNvaqGHJi0va9Sl10dvrm/GhjhsXGyodYgcSw7gwe4+ln4yJ141wKs0zVucT2/H3OOwiqs/ncoPvvykADwq6ztwn/Q1IwssFWmYgEsd9+QvQ5qcjMRBWD/YlXW/Fx0+gSOFa7OtzsV9oGM+FpUCaGffLKIJdsVjU2r4qEE9Hb0S7RB+NRDnrot3DHHP22K6Jt4qH16nmPL72uzsNllMnkvFY5RbHvFWF+BYJWa7uRpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHjIAUP8pch+iU7C2NvkHDOGwlDOkgTnRp9+Y5FR1pg=;
 b=glYE9pF7LJrP7/oUkim8Bit5DwXAlP9VfGLL172gNEIkw9UNG50lABBpmlKlRyH4ypixw+yMjjQlMPefx14UTVsI5czdk7AzB2NlUDenYdy3LTI5RnnZsRsYhJKBXoAW5OdNj28YpvmPTfqla6MbwCiJDUMNZOq4Zv01/0xc6UWE65Zg/EEaWUlmtLU9AryUhKqncz6RD08cQmKRawp6I1a4GKmgcHhJFN1VJF5EIvhYtzYjyPZD6jvH6iGsLKydxxZc5c1StjYHIKKJnqhOj8vnsnH+IBdntJlIVnTPmwmt1yo2ZGRqZLjPuYhjFXUPZLJr/dqRj7JUAvPI2g4zLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHjIAUP8pch+iU7C2NvkHDOGwlDOkgTnRp9+Y5FR1pg=;
 b=pe7n+PVrm/79EtUbzsTJAtl+nIjWiZn7+UU4JNUFXnonTCwBoHjapAApCybOYIQYy1bQGVZ7h+LpplOLEY4xX2sIDyee4NmtGi4AjmYPxquhYDxU/6mvkqLy/enlPpnTCeqJen1fyw4ujsS533s40E2lmNvvBOW3BWzdKAl/I4A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (20.177.184.30) by
 BYAPR06MB5623.namprd06.prod.outlook.com (20.178.196.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Thu, 13 Feb 2020 08:45:17 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::61cf:307a:df0a:c031]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::61cf:307a:df0a:c031%3]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 08:45:17 +0000
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
Subject: [PATCH 2/6] brcmfmac: Fix double freeing in the fmac usb data path
Date:   Thu, 13 Feb 2020 02:44:32 -0600
Message-Id: <1581583476-60155-3-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1581583476-60155-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1581583476-60155-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0050.namprd02.prod.outlook.com
 (2603:10b6:a03:54::27) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR02CA0050.namprd02.prod.outlook.com (2603:10b6:a03:54::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.29 via Frontend Transport; Thu, 13 Feb 2020 08:45:16 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 96671ed7-4ebe-48d6-855c-08d7b0610cd2
X-MS-TrafficTypeDiagnostic: BYAPR06MB5623:|BYAPR06MB5623:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB562322D2283CC80DFE8A3462BB1A0@BYAPR06MB5623.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(376002)(396003)(366004)(189003)(199004)(16526019)(478600001)(2906002)(186003)(4326008)(2616005)(316002)(26005)(5660300002)(36756003)(956004)(86362001)(6666004)(8676002)(54906003)(8936002)(66556008)(52116002)(107886003)(66476007)(81166006)(81156014)(6486002)(6916009)(7696005)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB5623;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /sYL9DxL9++XjkCitVWfSW1PkiAkGcShxniupxGPHVtJ7Q9EV5oiAEhuV2q97hIjwz/TuEjWnMEBAwD6tAVKG4HJiaWsAL6AfslAce6uBNnUbNCUDFNNgG9ieURfVchJoZUFpohA5PHg/y0M98qyVg79WzcnL9d5gHDbMimKRC21nUbVz3s111PdrzLjILuouQEvbzV2/xk7qbX9pwj3JUqrJPXxbALOafEtZvvZ+OM8AsZ8LP0TgHve28v4LVQyO9xW41VphQQ1TEBgLuguU2On5DiQmEerY6iwcfAs4fwzpCgojqRiWggh2O4TGPeY3kQLCJKpCNq2UEAoqgyYO8dK/7XdxiclxfzTzGMveIySHcxtlXF8UQLd5RUqJH6lrzAuJmBFUk/mDzbXvWNoMAFEiXEfcrFUG0gapZuFU+GX0ST5uTL/ZwezRScr9pR+
X-MS-Exchange-AntiSpam-MessageData: +yz5mKF+PBIhEl3m1iVuNVaLDI1/Vd5XQaMoGlSw1Bi4xFRv2lPbF4s+G7HnqH+ZonwHD16zKHHLSn0shGKcJ4t70Mk4k97cG5jgfrukgWpEpxTwzrfwZUc158NQ+WmOrNpqChhfS8lEnEN9QDrVqg==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96671ed7-4ebe-48d6-855c-08d7b0610cd2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 08:45:17.4461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMcGM2EhNn46eavUyx7J8HP4syVO3K5CsGr4zQZQbT8VxUQ/EkDSK5XZngKAS3O6rB5xewcHiI/tJdw471CZXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5623
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

