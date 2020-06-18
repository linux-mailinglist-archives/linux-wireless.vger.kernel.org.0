Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387E31FF8BB
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2020 18:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731924AbgFRQIC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jun 2020 12:08:02 -0400
Received: from mail-mw2nam10on2114.outbound.protection.outlook.com ([40.107.94.114]:35040
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731871AbgFRQH6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jun 2020 12:07:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cu10AEyJNQAmpVpTbhdnMe/TeuVmSCLo8TgDZ5XpjBLauaRVYOBqXn6nRJBdGAadfZ5HS2EDCqONtmQ3UxJ+hB1x/FMRD1k9/thyyMCgWM2xIRrAVu4FMMG1qDynp2bQ/Ys7qcgH5lwOxZ1t4Ta2C+cL3Il/eaFc98k7NlzBe3fPyr2x6UpNlXZ2edg12CTR+fuigmm3nAkyjt4MICdkuDQUHm8+5Nf8p+Z7264/Ip+J8QOE4L4aYYqBlNL1l8Qz4Fuz1sQwGI6fjz1ymtonS9KfIj8k1iDDx64cwtQpNHENMrboSCggQkAS6YsRMbQtM9qyXPcF9MMTu4bEgOgYZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Up0+J+1C8povG4/mOMMEJPy0Rup7OYbgK07xssNcERw=;
 b=cRaOb+Y07MRtVFGKPQ0wNAcQTk+jeGbu55Lj7DxzygdqWg7MKT6E8UJODzXtupf8uocBLoADXbK4yqBdg11HdWd4gz4e/vJGMABUKlEesw5Ka3VScXaAcDYzC+r84x73730NUgU+BJRQaayX9V8bvZbELKhgNaZ2/BJmA7Ey+IgZ90Ods1YkmaEE2AcME1xmxaG8gKqpq94gyhPQrJp9SzniSjwYf38f355tPDRnsMqWcSmMMvhLLxbqZJXTzhEozCRn5IUiIF7poYg28k1OTSnTCKu4d86uePXXPpFP3Gp8S34tbWO54nZRK71p0iISdGwwwtfiqIOPF8qDh1qu2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Up0+J+1C8povG4/mOMMEJPy0Rup7OYbgK07xssNcERw=;
 b=VqRlDNEghcaVOZ0THIYZT3Qr5uAcLE5JbX8/efDsu9Ml8oA6ul7SBuGEwZGXCXq+N0m5H31i0GWO66cpVcTZu2OHeKUMYp2tuXzYsd2j1rkYx1+SjpRHyerEEr7MoO5l+dsY2NOy4qwRPxONmEYeuTS6cZ8X45d1R1zEH0nHGEg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BY5PR06MB6547.namprd06.prod.outlook.com (2603:10b6:a03:233::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 16:07:55 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3088.029; Thu, 18 Jun 2020
 16:07:55 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Soontak Lee <soontak.lee@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 2/3] brcmfmac: Fix for wrong disconnection event source information
Date:   Thu, 18 Jun 2020 11:07:38 -0500
Message-Id: <20200618160739.21457-3-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200618160739.21457-1-chi-hsien.lin@cypress.com>
References: <20200618160739.21457-1-chi-hsien.lin@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0051.namprd08.prod.outlook.com
 (2603:10b6:a03:117::28) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR08CA0051.namprd08.prod.outlook.com (2603:10b6:a03:117::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 16:07:54 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2af8f08b-e206-46c6-9d0e-08d813a1c2ab
X-MS-TrafficTypeDiagnostic: BY5PR06MB6547:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR06MB6547F4641CB5958652D92036BB9B0@BY5PR06MB6547.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pVj96yBoUXwgi+U0+QcQMXmBs8z0YlFnXZYRVjZrivOUCQ9F7cSNmho/WEDKgWklb3UAXFps0rjOFKhRiW6hp0DrTrPbvAE4SlYpVxMW6Uk6ivhpn2mnL7c4AXXLkseVPqBaZ0DYZo8ZbdLE6zgjvEG2ONAh2c088CeYSEwegVIxcdqBWlZilitoT+JDNNLROi0VkGrDDVyNPMUs5imSnvpngDBFYaQo9DSMbXx4EINN1x7PIA84aHvth7axYaGtemMjB5132qkZztoNohN58/HkOvISuvPyykPtl15PjZl5p06dFOwQq6rXYSk+v2eW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(136003)(366004)(39860400002)(376002)(316002)(478600001)(5660300002)(26005)(6666004)(8936002)(36756003)(107886003)(2616005)(86362001)(83380400001)(6486002)(2906002)(54906003)(8676002)(66556008)(7696005)(66946007)(52116002)(186003)(66476007)(1076003)(4326008)(16526019)(6916009)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: UDyhiNFw8QjSCL9Esa1h8JlUMyvQ7uuyT1yRPBFiEPVVpAp1eQ8ndeBPzRfuafEVencaVicq+0xG5iMyjAQlLxIvou+dt/3Wo/Xt+9ofSxJdjFnHlhhtDYgwlp7zpzfiO77gMSSIj9x5tPZx3rynxff1rniiGrlzZdpRc6qCSqEU3Sx/NK008XsRddvLQOUeHT7kzPuXgZ91KCRVTLD3SoUOfTtvzfqWRLd/3rzUtjL4tTBo+ZiC1qOnPfuwxBJ+ycsVp/w20yCtt2wsp+ZJ3HzjXSQdRFB+IzcyUrtLHPAUrvIx6Es6o/M2IyiANnG7WTRg2QXfw28if39fxG9zPd8vowXCJZEx2aX0ST9gtzsyJLcUvBRIF7se7In662OdHFMjdY+Tf1Jq3iQJMxlYe0sfd9M0fsyZqHq5y5rbY8qmD3QKWRDIu86Tm8fkg8Obwu6IqL0fdt9TtkUDDxHdXsspsOXqT1smVPIam4rhFDhKryQ+MgEnrMO9fYhoD+2f
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af8f08b-e206-46c6-9d0e-08d813a1c2ab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 16:07:55.5171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7m/lgBysh0s55CbA0yzeo592kd9guwvOgAsjpKbTaJYMATTPyyCDk9L9+JQ+Nhp6vB4qdQQig36Wm9hguaKj7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR06MB6547
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Soontak Lee <soontak.lee@cypress.com>

Current brcmf_link_down() always call cfg80211_disconnected() with
locally_generated=1, which is not always the case. Add event source
argument on link down handler and set locally_generated based on the
real trigger.

Signed-off-by: Soontak Lee <soontak.lee@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c      | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index d3d1100d56a7..4717867949bb 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1387,7 +1387,8 @@ static int brcmf_set_sae_password(struct brcmf_if *ifp, const u8 *pwd_data,
 	return err;
 }
 
-static void brcmf_link_down(struct brcmf_cfg80211_vif *vif, u16 reason)
+static void brcmf_link_down(struct brcmf_cfg80211_vif *vif, u16 reason,
+			    bool locally_generated)
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(vif->wdev.wiphy);
 	struct brcmf_pub *drvr = cfg->pub;
@@ -1409,7 +1410,7 @@ static void brcmf_link_down(struct brcmf_cfg80211_vif *vif, u16 reason)
 		if ((vif->wdev.iftype == NL80211_IFTYPE_STATION) ||
 		    (vif->wdev.iftype == NL80211_IFTYPE_P2P_CLIENT))
 			cfg80211_disconnected(vif->wdev.netdev, reason, NULL, 0,
-					      true, GFP_KERNEL);
+					      locally_generated, GFP_KERNEL);
 	}
 	clear_bit(BRCMF_VIF_STATUS_CONNECTING, &vif->sme_state);
 	clear_bit(BRCMF_SCAN_STATUS_SUPPRESS, &cfg->scan_status);
@@ -1588,7 +1589,7 @@ brcmf_cfg80211_leave_ibss(struct wiphy *wiphy, struct net_device *ndev)
 		return 0;
 	}
 
-	brcmf_link_down(ifp->vif, WLAN_REASON_DEAUTH_LEAVING);
+	brcmf_link_down(ifp->vif, WLAN_REASON_DEAUTH_LEAVING, true);
 	brcmf_net_setcarrier(ifp, false);
 
 	brcmf_dbg(TRACE, "Exit\n");
@@ -3907,7 +3908,7 @@ static s32 brcmf_cfg80211_suspend(struct wiphy *wiphy,
 			 * disassociate from AP to save power while system is
 			 * in suspended state
 			 */
-			brcmf_link_down(vif, WLAN_REASON_UNSPECIFIED);
+			brcmf_link_down(vif, WLAN_REASON_UNSPECIFIED, true);
 			/* Make sure WPA_Supplicant receives all the event
 			 * generated due to DISASSOC call to the fw to keep
 			 * the state fw and WPA_Supplicant state consistent
@@ -6029,7 +6030,11 @@ brcmf_notify_connect_status(struct brcmf_if *ifp,
 		if (!brcmf_is_ibssmode(ifp->vif)) {
 			brcmf_bss_connect_done(cfg, ndev, e, false);
 			brcmf_link_down(ifp->vif,
-					brcmf_map_fw_linkdown_reason(e));
+					brcmf_map_fw_linkdown_reason(e),
+					e->event_code &
+					(BRCMF_E_DEAUTH_IND |
+					BRCMF_E_DISASSOC_IND)
+					? false : true);
 			brcmf_init_prof(ndev_to_prof(ndev));
 			if (ndev != cfg_to_ndev(cfg))
 				complete(&cfg->vif_disabled);
@@ -7182,7 +7187,7 @@ static s32 __brcmf_cfg80211_down(struct brcmf_if *ifp)
 	 * from AP to save power
 	 */
 	if (check_vif_up(ifp->vif)) {
-		brcmf_link_down(ifp->vif, WLAN_REASON_UNSPECIFIED);
+		brcmf_link_down(ifp->vif, WLAN_REASON_UNSPECIFIED, true);
 
 		/* Make sure WPA_Supplicant receives all the event
 		   generated due to DISASSOC call to the fw to keep
-- 
2.25.0

