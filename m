Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420AF293312
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Oct 2020 04:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390595AbgJTC3y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Oct 2020 22:29:54 -0400
Received: from mail-eopbgr750098.outbound.protection.outlook.com ([40.107.75.98]:53075
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730463AbgJTC3x (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Oct 2020 22:29:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPPuqOrEyFkIARtxxiiaKl88umuNyoGKExELIa3H5AuyNuR5eEsgISMLqhNCS8cg8mvZYq/vnIeV5NWLuHVRiSKkD+F23qEE9Y3079FsCZKTGNn6iamBfQtAuZh8z+o/JoY0YWBcGgYGa6daLIqACLMruh5xqC2qD9cGvwqHLQYU7I/XJMZJkBdmudVzG4xvXNx6s7BpnfuvWatfuM/hly6stmqQUYP+/I9NqRtg8yFshbl5NIRp1zFK7yJ8ora/zfiU6pKYd8kRtJRSluAon59UEb+StAou0Zt4fNyq+hpccZBEgNKGsB1JW9Tj5putflyyrFkaGaqvz8i2o0Gx1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gWFDXO0mNXa8fiviPYI8Adk+Q/GrWTvNRYblPi7kD0=;
 b=Tp/qmVRgXgazlcwPa4wRbjXn8xniSSTojoYzfrea4fWx/033YqYA0hlcsmzBnQ5+VicdXjAELQEhLw9m7KSPC6C9ZuZpyYdeBPs/WYI8zyNJ6zkW1/3de7UrAO6WJpoRf1KGe//mxTH/RvRddfKaR3y+mdE+DWGb3z59dGX2teLcxwsK3YqpeT28z6HX3ex8mMxq1WQd6srp+Fxpv+m05lNrgjagAf2qoX+Lo703lTF6pwPpL2nlTqizktiuiLypRcRDyhzR4K9TISa2lOP0Y/1qPyaCCzL2bRPmrCtYkxdf0uDUaZ9G+xxy1GDviRWwvi50h/k/w5ePq/A4wWmMPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gWFDXO0mNXa8fiviPYI8Adk+Q/GrWTvNRYblPi7kD0=;
 b=PGqYlon5mUA2KRNddRCNelI7iik+8mBhMaE2rIiK3E4glbETzr0WrwMzygLJE6sy+AMhZwrhnaB7VsyddDco6UvTR9lTzDvKePJb1VkUplP5mZSB+UtAtdsLlxD1hlM46/kQsC/6leS2MVqYcr/bnzpLgE7+vRMLQqdDzNf2V3w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN6PR06MB3251.namprd06.prod.outlook.com (2603:10b6:405:3e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Tue, 20 Oct
 2020 02:29:43 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::59fc:a93d:7f49:e843]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::59fc:a93d:7f49:e843%5]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 02:29:42 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Ting-Ying Li <tingying.li@cypress.com>
Subject: [PATCH v2 2/4] brcmfmac: don't allow arp/nd offload to be enabled if ap mode exists
Date:   Mon, 19 Oct 2020 21:28:10 -0500
Message-Id: <20201020022812.37064-3-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20201020022812.37064-1-wright.feng@cypress.com>
References: <20201020022812.37064-1-wright.feng@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [157.95.12.33]
X-ClientProxiedBy: MN2PR15CA0027.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::40) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote06.aus.cypress.com (157.95.12.33) by MN2PR15CA0027.namprd15.prod.outlook.com (2603:10b6:208:1b4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Tue, 20 Oct 2020 02:29:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 20aba77a-aa72-453b-447b-08d874a0005e
X-MS-TrafficTypeDiagnostic: BN6PR06MB3251:
X-LD-Processed: 011addfc-2c09-450d-8938-e0bbc2dd2376,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR06MB325110B504FCB448B166D275FB1F0@BN6PR06MB3251.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EyzaU7SHUHYsaQI6nzji2B3aKGBHt/AsD2XmcEhwttCTEiIpkJV/DKWPhm1pNpOU1bhOf31sfWqAdMjjT1DJ2Y6NIi0OqUOO17CTX8vP7PrOcbHRoWj0z+Cmg3xbsBVXnakprufCa1FmKBUxflKGxWUenJZXcpdfVIQMgeEa99mqwYU3N5I+YkeBcG9QJnIKhOT+WVeVmpd0jCY9PVSCXzTzoVwgy35+TUnMl3TXbZZLwg2K1f9Zi8eQRegB4Y8Bn2S9bkkR0fUVJKjKx4Ui54hQpI2ScLWXvOrP0wKhaqRYmUE+FlyNBQ2AFH3wZj2G21PLLqc7gdHqAmQ0Pb4H1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(66946007)(66556008)(66476007)(7696005)(52116002)(107886003)(6486002)(8676002)(186003)(16526019)(1076003)(316002)(44832011)(6666004)(478600001)(26005)(5660300002)(2906002)(86362001)(6636002)(54906003)(83380400001)(36756003)(8936002)(956004)(110136005)(2616005)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 05Rf/pEl9y10dNdfg8RVWjSUIBMzTgNpbCH5Sx+MGbIRGPjsEkmroFm0O176qqQWhSn7w8hIb1KBFbBLAN/ugcbBe+8yKATz1RuAjVMniPiE4PHRSQVVkSHJNbccUlI8lLmiNB+9WlfliwVxNXkK9FpDHaNr8xKliFEN0K9SMvpNlhJINvkDTVrVB4dKBz0N9PlR/zbuoHmB7y03FS0yxdeMkF01eh8zyPh2UZjkvLTHjtrWHXv7fbGDxlQ+t/PuqYHDbaLCheH8hjTBPg2fv8eHG0TJNpSNPVeacQEkWaYnI8L1bs8xed7vv8F3S1GBEvpMXlDwMAU2huBt7Q9toI3c50qkzoUmYIfrLaF9AFXH1O/clYFW6Kzgg2yuxwXSqOv6MuQbHYWp2yuqycuAbWlzaPfip6w/f0SRX20HGjwjw8/d9qCv18CKFfFZtBoJ2uAF2xtK1qpjMAl0ary2NJ217/S4mzJnCzfxIbRiF0cxQLup81viNotaQ2WuWg5Qt7CMIXDmO1RlG6UZQ7W5RPlB1iJaICROWr14qHJ4iDh3maiKPRfBXzf8ycC+KSi4TwmvImmCiPdLr611UVAdvvykqymgKD8ZyHrdAtot6mqsnKhL8AZtcvY0D3yAxDiUJhTmFvHYtN9VE+LeskxZKA==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20aba77a-aa72-453b-447b-08d874a0005e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 02:29:42.7909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6RcfybOd1GmeSZoPxSFvaOLwvh+FlflGdLz8O0J4fcGNQ2fEusNh7Apnoj0IukqM0zi9Fsy7u2z3QfpijPA8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3251
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ting-Ying Li <tingying.li@cypress.com>

Add a condition to determine whether arp/nd offload enabling
request is allowed. If there is any interface acts as ap
mode and is operating, then reject the request of arp oflload
enabling from cfg80211.

Signed-off-by: Ting-Ying Li <tingying.li@cypress.com>
Signed-off-by: Wright Feng <wright.feng@cypress.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c      | 17 ++++++++++++++++-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h      |  1 +
 .../wireless/broadcom/brcm80211/brcmfmac/core.c |  5 +++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 4d0447784426..2f24222eb59c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -769,6 +769,21 @@ void brcmf_set_mpc(struct brcmf_if *ifp, int mpc)
 	}
 }
 
+bool brcmf_is_apmode_operating(struct wiphy *wiphy)
+{
+	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct brcmf_cfg80211_vif *vif;
+	bool ret = false;
+
+	list_for_each_entry(vif, &cfg->vif_list, list) {
+		if (brcmf_is_apmode(vif) &&
+		    test_bit(BRCMF_VIF_STATUS_AP_CREATED, &vif->sme_state))
+			ret = true;
+	}
+
+	return ret;
+}
+
 s32 brcmf_notify_escan_complete(struct brcmf_cfg80211_info *cfg,
 				struct brcmf_if *ifp, bool aborted,
 				bool fw_abort)
@@ -4990,8 +5005,8 @@ static int brcmf_cfg80211_stop_ap(struct wiphy *wiphy, struct net_device *ndev)
 			bphy_err(drvr, "bss_enable config failed %d\n", err);
 	}
 	brcmf_set_mpc(ifp, 1);
-	brcmf_configure_arp_nd_offload(ifp, true);
 	clear_bit(BRCMF_VIF_STATUS_AP_CREATED, &ifp->vif->sme_state);
+	brcmf_configure_arp_nd_offload(ifp, true);
 	brcmf_net_setcarrier(ifp, false);
 
 	return err;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
index 17817cdb5de2..94996574c9c7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
@@ -461,5 +461,6 @@ s32 brcmf_notify_escan_complete(struct brcmf_cfg80211_info *cfg,
 void brcmf_set_mpc(struct brcmf_if *ndev, int mpc);
 void brcmf_abort_scanning(struct brcmf_cfg80211_info *cfg);
 void brcmf_cfg80211_free_netdev(struct net_device *ndev);
+bool brcmf_is_apmode_operating(struct wiphy *wiphy);
 
 #endif /* BRCMFMAC_CFG80211_H */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 3dd28f5fef19..043c9cbc6394 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -96,6 +96,11 @@ void brcmf_configure_arp_nd_offload(struct brcmf_if *ifp, bool enable)
 	s32 err;
 	u32 mode;
 
+	if (enable && brcmf_is_apmode_operating(ifp->drvr->wiphy)) {
+		brcmf_dbg(TRACE, "Skip ARP/ND offload enable when soft AP is running\n");
+		return;
+	}
+
 	if (enable)
 		mode = BRCMF_ARP_OL_AGENT | BRCMF_ARP_OL_PEER_AUTO_REPLY;
 	else
-- 
2.25.0

