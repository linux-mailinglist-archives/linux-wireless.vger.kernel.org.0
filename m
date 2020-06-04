Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82851EDDE3
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 09:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgFDHSz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jun 2020 03:18:55 -0400
Received: from mail-mw2nam12on2097.outbound.protection.outlook.com ([40.107.244.97]:32608
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726411AbgFDHSy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jun 2020 03:18:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coxv0CyPKOuvv9DsTp3HhWamPnXZV+F3v9Dqk7TwOYtca5MoIjkcn/w+tsFg9OAcEDgtHz8+B5bwTHBaPVKuKo1n4dX65vqOPcP6JhskVBRRpMO2Bc/dlUCzQ2PT62rAEZYtCYw7f8w5QESR2nN4DuWKgEV/ZfcZWYW3MvONL9tQOxZT6SpM5FphfgTu3Cvl5fWi/quOFhkThXp7iIeQmEwbTvaQC6G5PttBPeTNrG6edUlE+pgfmW+QNX5s17AzE0g3VWtPtVXOhUpS6Cz+zHRE/A2d0isjkUlxqN3iXYJU5RyIyHH0SHzxgEnIFVY1IdZCajlC1lkCSx5dLAxKrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LHqh6MfvZyJ/44AUtOGLku5BaYHKkmqsov0nWxOtyA=;
 b=bVWf5VO92+J8GY19YINQXcEu2wilkbthXj3+rHqEOYGvEUX/vszdHvOiMAkd/igHveZFpaeRYviGxdH/5A7ojATPxuqkE5EZPO6nkX/ylm1Gl7jiLEXaM0etGXGJtddoaUXR6pjldNh1sdcjN/yoqzneRuQpVI1bdHcInSNGsonrt5QiKHfW5bJZ1w2vf5LOh910SN4TgXYvMY9fL2BmnFga6SokxOziAJX9GjdAac98MDzyIStGvSivgK9bru6Jl26j+1j7TqV/H0dfSsG62zZ/ztEj2u9GbGzolB8QYvmG/Q5ZWdDnOcrLc/cuSmNhoenZJwvja05j3Q2iBtDOJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LHqh6MfvZyJ/44AUtOGLku5BaYHKkmqsov0nWxOtyA=;
 b=F3xJW8XRcXIngWj6WCTcChhCQwc88v+MkvihP5cdluNCcQZbiCYL33cLhdCY0E2E/1mKPlxjTAL9vTfWq7glOxZSqcXSLoH2dKlWS5/t1PqpQi7l/4UhwlQGoyTgGiVv2jcGerPLFkzE7MQLYgbZjONf8sSz89YuX4JRCyfmLX8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB5146.namprd06.prod.outlook.com (2603:10b6:5:112::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Thu, 4 Jun 2020 07:18:52 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb%5]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 07:18:52 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Subject: [PATCH v2 2/5] brcmfmac: fix invalid permanent MAC address in wiphy
Date:   Thu,  4 Jun 2020 02:18:32 -0500
Message-Id: <20200604071835.3842-3-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200604071835.3842-1-wright.feng@cypress.com>
References: <20200604071835.3842-1-wright.feng@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0049.prod.exchangelabs.com (2603:10b6:208:23f::18)
 To DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from iot-wlan-dev-u02.aus.cypress.com (12.110.209.245) by MN2PR01CA0049.prod.exchangelabs.com (2603:10b6:208:23f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Thu, 4 Jun 2020 07:18:51 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2de5c2da-33d9-4183-f62d-08d80857889e
X-MS-TrafficTypeDiagnostic: DM6PR06MB5146:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB51466879CE02373B692863F7FB890@DM6PR06MB5146.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1sSQzzfYXLsSw5D/nP+vN0CP9RGiBfqgFgTKDanPza3SoxZAHChPixvZ2hMhh+7Tu7ydZKhzfQoZOxuJYE5l042mUrkC0/jVLYY8UFBtOtOtfecYK3s8QyuHT5YhYv77SsoGOoMXT5VQY0pZpkKfwjj84hDO63lYzdtKovvzHyBrfPJpOoVVWL96w9hlxlJVkx8bh1v6YZ8d0VhRH6Zb7aei/W0Wndfimq9Zvf0ZUlEFPFGdZR2VybIebt1vx1w97wE94LVcpPM1WnGnLmh1VjKUA7JjyPi8709w08csLex3w3XncShqQJaCcDAknr20
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4748.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(346002)(396003)(366004)(136003)(316002)(54906003)(6666004)(26005)(16526019)(186003)(2616005)(52116002)(36756003)(956004)(7696005)(44832011)(1076003)(8936002)(8676002)(83380400001)(107886003)(6916009)(5660300002)(2906002)(4326008)(86362001)(6486002)(478600001)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Zs2/gu6BhKNZ66EIE/Q0S2P9Df+dfxRLGnCHGcquh6C9599U0xnnaDOhiZd8Bf6fGcu1qEa+qdI3ZFljGNkD/g2+BoRTr11SP/oy/9Lu3WjF8kloZecIP6AmbNpJ2A4KTtcjYiAeLYb58GcYbtQHF55Yb20xUkKQEvsQhLOYjoMdSUkAWYwcCPiepZd3kiRxDTA3YCRJ8PVs9OUr7AD7MCEjlRoI2m/hexp6c99yWw23ARtFGAWQ1Up+sCuhXWIoZ8h8xxS7kyUWGdISTc1vrxmVKiQ7eJifX7au1/PkYd61T4lNBjrGYfDlmizMbIQ9mH4xTrxp1GN2vl5XA1QnvH/PxDyKTbGhikSh0HbCH6OCshc0gpT0PSIt5tQK4C9VLYB5my8Vrvs1OSCpGa3hpdbwz+8L/iGoSdo7s377Cv/QamEPhsXertdMQdOumWbIHjCfzm25ihZCS9w5LdIw5cY263zkg6hinwwIPtUW0Jv7gqOdpRoH8VICdbSM/3ud
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de5c2da-33d9-4183-f62d-08d80857889e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 07:18:52.4039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xo4jZm3q215782NyS4tDy5e6p5EUdLvJmhkLrxKtsIGxPmDsY8gtBQgVNnDwBamoH7AYKziKBJAHjg/XhBdwZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5146
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When host driver retrieves mac addresses from dongle, driver copies memory
from drvr->mac to perm_addr. But at the moment, drvr->mac is all zero
array which causes permanent MAC address in wiphy is all zero as well.
To fix this, we set drvr->mac before setting perm_addr.

Signed-off-by: Wright Feng <wright.feng@cypress.com>
---
v2:
 - Correct the typo in commit subject

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index dec25e415619..e3758bd86acf 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -209,8 +209,8 @@ int brcmf_c_preinit_dcmds(struct brcmf_if *ifp)
 		bphy_err(drvr, "Retrieving cur_etheraddr failed, %d\n", err);
 		goto done;
 	}
-	memcpy(ifp->drvr->wiphy->perm_addr, ifp->drvr->mac, ETH_ALEN);
 	memcpy(ifp->drvr->mac, ifp->mac_addr, sizeof(ifp->drvr->mac));
+	memcpy(ifp->drvr->wiphy->perm_addr, ifp->drvr->mac, ETH_ALEN);
 
 	bus = ifp->drvr->bus_if;
 	ri = &ifp->drvr->revinfo;
-- 
2.25.0

