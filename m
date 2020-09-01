Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BDE258844
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Sep 2020 08:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgIAGdI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Sep 2020 02:33:08 -0400
Received: from mail-bn8nam11on2136.outbound.protection.outlook.com ([40.107.236.136]:32243
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726586AbgIAGdH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Sep 2020 02:33:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dx+VFkX6wlsD79eur9bc3aRcqX0ha6XtWdCBI1M+Jv4jU9qDCV280h82zofBgtSMUwX1X2Xnl717ZEjfOO0RJx1RiS65gU7xG7iV4s1k0sgXDgvLoAQIaq9OKZTDXoqDp5QB2MLgo7SRIuZiC3RLKy9b8UKtDrFocIecxlzjjFcRXp7gGk38kuV9gxdjpDFuOJH3j2yLctLqM5dFkeyrbYf4bNRf3Vv5HirDhfKaAIKuAzbn+LGql66OtGN+2USWCJbe7xRIJh2deeuOK9T33TDLS4JeJ73ut/0xnU7diJivriv5UTzhE5S92qjyG22lQLD+IlqFb7BoXsw+MS9idA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R74FJNe0wB0ngb/sp/5B1pYwCUew++USVnbW8gawy0A=;
 b=g6uTHt52yTROwHJYpwQ3WACiaDeRqTNdwKuSWjy/Hq4M/aKD1ddmiSS59MESlNLzqG/5LflN3xBusQzPEZeD5H8IwbLn1zpffEkmtXuVUNzJC4RmKnHK73sRExBN+qhLyMU9CiouV0SCqsca5IDV4A3m5TBd2hAtK3SitobCZcJSHGdXlivHFcG6TAzh7pJKcHSQjgHTfsrfg2+artk+t5hre+Om00CxdEBGzjXN/P/m741VuEU/ShulgowHl9l3rs5PgSdx8/YpIVw0uiJhZvlHE/jFHagEng4axXL/UYdqoMLuCmi8EggECBiaMo96k+epPtp9THL8HtyrN61/NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R74FJNe0wB0ngb/sp/5B1pYwCUew++USVnbW8gawy0A=;
 b=hiRWMPHGoieTdl3CqlMhaOhMFdjRp4mUDa22Pu2NW4QlDGhsLvyOOnXyw+n66VJAuB+MQvkpo587Nu+JVyCoyX9EyNdqWNwyiN4AHEWPaz7/572OB4B08xUILcp3WbB7ntIn/zHEAKL6uatDEc85UZ4g4kWg94MkChvDSyjjMBw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN6PR06MB2867.namprd06.prod.outlook.com (2603:10b6:404:114::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Tue, 1 Sep
 2020 06:32:53 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819%3]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 06:32:53 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com,
        Ting-Ying Li <tingying.li@cypress.com>
Subject: [PATCH 2/4] brcmfmac: don't allow arp/nd offload to be enabled if ap mode exists
Date:   Tue,  1 Sep 2020 01:32:35 -0500
Message-Id: <20200901063237.15549-3-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200901063237.15549-1-wright.feng@cypress.com>
References: <20200901063237.15549-1-wright.feng@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:208:23d::33) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR06CA0028.namprd06.prod.outlook.com (2603:10b6:208:23d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 06:32:52 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [157.95.12.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c09c09ce-19ee-491b-b737-08d84e40daca
X-MS-TrafficTypeDiagnostic: BN6PR06MB2867:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR06MB28672E1D47D60790782C5603FB2E0@BN6PR06MB2867.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bNGfMQVBKL58VXmvQHycghpGWFIepyruXc2O1806XRq3Ac1bdVudio0l5W/Jy8lhjkYhm/SmEe/NlOda72q7tMwy5woNUSWtjh0x/EK5Z6+SJLMMeIB8LIBquY8oYzGMrmtPnhe+rabxpf0uaVcVUC0sC5E7KMw8UVMh7PbzlilNprxPKdbto2WaPWBys84Kn42u7QrL20xvHZcP+kiSOBZXSq6Ar7IRXsdYWNWASyrgPTlxHXshKFmOKZcP3Jana5X4u/h2vz87XeKcpoGNvlnZ7Ii5mVWO4eRvUDWAQ/xj0pLhpJKW3B2LyH6XbIvMDbr1KvgPtoG9Z53bcIk07Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(54906003)(478600001)(5660300002)(66476007)(66946007)(52116002)(26005)(66556008)(107886003)(4326008)(6486002)(16576012)(316002)(186003)(36756003)(86362001)(1076003)(44832011)(6916009)(2906002)(6666004)(8676002)(8936002)(956004)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ZVb0jYU4DreEkgwMa3V2u4yLAZRn9m322FPBR6kAl2aWB5fFgVxYOyrINua+uFvqMEkzpiqgvPG80x0JsMpqG2YWucgKJG0BHmtOr7/6ve3iXfekp0JM3FZbud53oUJRl/dEJIbOihHMaDS+K5DGfjxNVSLDnAxCBzzlPPDVVd555HcFSZzoyFrG3G3FTIF31nN1moKKHFTyEmQ1NSjmZsTHAcR51nrZrR0XSbtjwVvYCLsqZl5Ru2QOGuB07MdPcrJ/6M32xAm4l3+80fWLPFIcm2XfLosyOe2ltWkU/WxEQdUHq6z6dXn8dG7jvIkiicWm77ltxfHVU86vAQgV6k+GKjdUtooahmY7liwBHEqBCTl0wPnrFOjJOdgZ6ZEi+qnC5UtApKPX5tOD5isTG2Tr31eAm/wIDH6OXg9iP+nbjmzrpmYntihdSWTucARs8oEFxtxd8Sc/RYgqlG8BkEokyv+rcE4ARvjLEScZPh3E/kgJ2ZYlC0lIwl6G1ZBQZuOPOvHrQ9P0r621WzT9pJxHaQ3Z1A6Z3NC4XhrjgAaIYytTnk9AtO/hLGbc48zy2fZzk2NnYMIZ+WyWv0WTfC8EY4Mcxf9OeuGXSCLXHWb95WxqFwMu/P/wG4siwNdibYVOJ5nfJc9SEUt4XKaiiA==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c09c09ce-19ee-491b-b737-08d84e40daca
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 06:32:53.3554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oCKoEVgrL3DVvCZDFmiA5T9RW22CvoqzBSu+VGXz9j/xOOX9aVcMd3EK6Q/HvLj3TYbTyjFjuufc8TvvPsk/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB2867
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ting-Ying Li <tingying.li@cypress.com>

Add a condition to determine whether arp/nd offload enabling
request is allowed. If there is any interface acts as ap
mode and is operating, then reject the request of arp oflload
enabling from cfg80211.

Signed-off-by: Ting-Ying Li <tingying.li@cypress.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c      | 17 ++++++++++++++++-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h      |  1 +
 .../wireless/broadcom/brcm80211/brcmfmac/core.c |  5 +++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 7ef93cd66b2c..d6972420d426 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -766,6 +766,21 @@ void brcmf_set_mpc(struct brcmf_if *ifp, int mpc)
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
@@ -4949,8 +4964,8 @@ static int brcmf_cfg80211_stop_ap(struct wiphy *wiphy, struct net_device *ndev)
 			bphy_err(drvr, "bss_enable config failed %d\n", err);
 	}
 	brcmf_set_mpc(ifp, 1);
-	brcmf_configure_arp_nd_offload(ifp, true);
 	clear_bit(BRCMF_VIF_STATUS_AP_CREATED, &ifp->vif->sme_state);
+	brcmf_configure_arp_nd_offload(ifp, true);
 	brcmf_net_setcarrier(ifp, false);
 
 	return err;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
index 333fdf394f95..8c14d00c6d0e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
@@ -447,5 +447,6 @@ s32 brcmf_notify_escan_complete(struct brcmf_cfg80211_info *cfg,
 void brcmf_set_mpc(struct brcmf_if *ndev, int mpc);
 void brcmf_abort_scanning(struct brcmf_cfg80211_info *cfg);
 void brcmf_cfg80211_free_netdev(struct net_device *ndev);
+bool brcmf_is_apmode_operating(struct wiphy *wiphy);
 
 #endif /* BRCMFMAC_CFG80211_H */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index f89010a81ffb..20c510dca601 100644
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

