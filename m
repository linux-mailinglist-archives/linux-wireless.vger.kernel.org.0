Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF52E19227E
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 09:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgCYIVD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 04:21:03 -0400
Received: from mail-dm6nam10on2113.outbound.protection.outlook.com ([40.107.93.113]:25385
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbgCYIVD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 04:21:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXYu7My3cU0oTY7cOUYPIcyL0GCsZHs2AdkbLE5j0pogPnJa/6iGswGB7/KSOAleK12jZfHa2Mg5c0RItLM4rMfU4OEr2mwdZI00KiJUDkVlSDgB1pkJQTE+K8n8tqwWMz9AsQ6Fx0v6fJmfYsLgV4TdbUIQ/s8/mhYcOHhHrjiMnpgneSyeTe3k12YVrKljax2dWmlPhd7mMNdnZw4aBsQ1SzVOxxzRX7BWSPUJQflNBKwBaHZwEHTWdwNhfsYKDES7IPlK/csNbRIbCCB8BZobyPZ6fMVNGxrnLZSQggangLxMrhMWA9/QGoYaUNbpS77i2FLCsi+HsimNHreyaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHjIAUP8pch+iU7C2NvkHDOGwlDOkgTnRp9+Y5FR1pg=;
 b=kmf/gmbXIgyAds6Aj+R7m8H3lgCeqbFwXQNfr/8jQ+uqiYp8U+A/vm0KyGRnidXv0gyhkOPI4lJlUCyA6jwN10yVTw+ywbEbiv1QyNE9vrr8tLGXXk9uMoIdL9jhznKq5O2h0f3Kafbq7t6Fzt2YnlXiGXgSMSPgiivowFKwD2Q1t9DAWnY5z0EpxPY9z43ifXTgPa46Tvx7PCY1msaYTX6YWBl4bNI383Q1boeLKI2kQM7HpJDjUDPQqdLmRULmOXJ/YnZdxTDuQJNnCSIBkDFcM91bnyVq0fSkuGE2kXpCwyhGJoe5bXMecRcKOSLWn+rg39OHauq1+v+K8zC38g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHjIAUP8pch+iU7C2NvkHDOGwlDOkgTnRp9+Y5FR1pg=;
 b=ZeQpbw+bvn4yR/GyhRvOpV8tTHGqJOTUYaEL3Eg5HcMITmwTsRyTkBHZdiQOOnW/9fXnqI8SbHMIY6CI34Eam3cz+g2flWxrwaMjN9d+TMX1CyIpev9DjwuRbXGfN7VP51q79QQWlS4H7ZCd/DBGWY0s3Epsoh90+ghecIM0B3w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5189.namprd06.prod.outlook.com (2603:10b6:a03:cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15; Wed, 25 Mar
 2020 08:20:54 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1%3]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 08:20:54 +0000
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
Subject: [PATCH V3 2/6] brcmfmac: Fix double freeing in the fmac usb data path
Date:   Wed, 25 Mar 2020 03:20:25 -0500
Message-Id: <1585124429-97371-3-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1585124429-97371-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1585124429-97371-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:a03:100::40) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR08CA0027.namprd08.prod.outlook.com (2603:10b6:a03:100::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend Transport; Wed, 25 Mar 2020 08:20:52 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3093e7df-9913-4625-fbe3-08d7d0956f6c
X-MS-TrafficTypeDiagnostic: BYAPR06MB5189:|BYAPR06MB5189:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB5189AF097BBDEE86A559FBD7BBCE0@BYAPR06MB5189.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(66556008)(8676002)(81156014)(2906002)(66476007)(66946007)(81166006)(6486002)(8936002)(6916009)(16526019)(26005)(956004)(2616005)(498600001)(6666004)(54906003)(86362001)(52116002)(7696005)(186003)(36756003)(5660300002)(107886003)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB5189;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y5B7ZRAcAHyAljo7flt+xsgDru+7eInkYGDiOnYyPgesiwZ7nGmknw8voL0UY/IifbZf42VE2FMV9gV2ECaNwMFnyLCdkyFxge5cF1IQgcU1fe+auOJoefw0k3s1mZpTEEr7xxOFoU6x5z/66UeNpBwhcstWab/U388s64u5MAZYTXyEwVDDPexU4n7UUmK8Vwq12G933ndg8lcSZP7tXyU1txvWrNigKKq19WggdNBG1DkhFxM4iPEMKBKaTgkvnubcZDglPpc0acJq8PxWJoiZBu2BCT1g9zQF2qAjhWSAFK3IGB7M7PYYO1KMZz2Dvjq12nRjgDzcnuvWJ0oosIjtz7gYxLiyZJHgsamIkf5jvgr0QyauqymT6e112jrvwEnIEdMJcmH6LGN4nuqSs46Tyx8gr17JjbaRR57f+mGMO53+ArEi8QE75MFIO9bQ
X-MS-Exchange-AntiSpam-MessageData: 9ziLpQugvDafq8i2rdDGw3M1izytLuNsIDnQt05yll4keuzEKpHfD77dmrN60yYsCjnGXk0GWEi2Ei6Y+MbE6my6/fNaQRz7/t4iytYCXB4Tdn7tbY37ci2hJ+Z12CRH8kcSke0gggr7VdZ2IMZHvQ==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3093e7df-9913-4625-fbe3-08d7d0956f6c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 08:20:53.9479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLZxMejCZ52nz+hj9XcJ4xC4/jJJMj3gIHEZB+SnI+q9r6aMAo+mRw/b+VXy3/DZAbX3/gcO15zdJRdxH1xrPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5189
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

