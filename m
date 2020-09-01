Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871E7258842
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Sep 2020 08:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgIAGcy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Sep 2020 02:32:54 -0400
Received: from mail-bn8nam11on2136.outbound.protection.outlook.com ([40.107.236.136]:32243
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbgIAGcx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Sep 2020 02:32:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+ghoBoff/fNgTJfg75Uda8MkoWgy5Bf4OB5Vw2AjCoNPgJCCnzATFY4FgRCTr8uOVuC2R9Z0Xqai1pWpNPOwUwP4udGbcCdrW88nXRIWHFla4x6EdLFEmWFQPfIKPDuzLYanPskD/LhyBjjqrzxVSNmp3cD5RYBT3HuFrkT6HqZWwYo/sk2Qr+hgt4Meq4bjfY0ni1SxJOoFwfDGmZq00/1f1Y6p3Q9Wr7UvGHDbIumfWeIxioXJLslTgMPYvc9UB6tE3l+lyf22e1snp5c+RnmA+7dtpksYK6+IgdZmR66JXI10lyy/T5F2hN85P6+yxZHJJDUbbm/rYfJV9ov0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MpGiPjnDLF9HprRDVXneZSIuoI0foKR0ud2KcWljy8=;
 b=LF6ApP8rQYVFv6mcYo5FXETRTM/eD9/GLj33F20v6xD4usdh6pTrDQOGcxF40QgCfrO65YOGihBeSs678GCf1nP6cN/2Vx4qdKQuGwve3HEjOZ0+AAAGUiAW1ZOTuRWJdpA5ZadCPRANqN4uAkOuxdBf4jL+dtGcPkOZpeTsa/r73L3dNvJHUD9sqaUspFQHT4gRWRKc/Le0byWBLARUaH09cFzE9hRGG0uLIBl72Zpr+BOQXun4o1wYVVU3hgmjyY2Y3yNqh4PVgePlUIKfzsnbpxJ5MGX8NvI5F2VrxwqelBiCPVrMEQApck9/OUeGDySaTbwnr31ZTL14ropYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MpGiPjnDLF9HprRDVXneZSIuoI0foKR0ud2KcWljy8=;
 b=WfaoZXBzb+HIpxkMUA9jVz6KCD6S2umv9oY4aZ9nhccADvXYH14EJ6WIyOTH3dUwbGp+1/Bjaoy1LBkogu+eA6OOjnfQcd8oS/zEA3d8Ia/TXptmKFTr0Nd8qBHn6buXhreS+iRTar9UkOQQRSdty/3U9Tf4G0GmWTFSQr+xi0w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN6PR06MB2867.namprd06.prod.outlook.com (2603:10b6:404:114::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Tue, 1 Sep
 2020 06:32:50 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819%3]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 06:32:50 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Subject: [PATCH 1/4] brcmfmac: add change_bss to support AP isolation
Date:   Tue,  1 Sep 2020 01:32:34 -0500
Message-Id: <20200901063237.15549-2-wright.feng@cypress.com>
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
Received: from 255.255.255.255 (255.255.255.255) by MN2PR06CA0028.namprd06.prod.outlook.com (2603:10b6:208:23d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 06:32:49 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [157.95.12.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: af61b1d3-b035-44fc-cb9b-08d84e40d915
X-MS-TrafficTypeDiagnostic: BN6PR06MB2867:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR06MB2867791263A67A8577E4D54CFB2E0@BN6PR06MB2867.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AqHqDmL9vNM/28vvvcUe7xROuKaQEc+4BhH2/R7Bcu5WlIVVCY2imSv4KFwAAQfYHPw600Og2nTNixHjSnaQItk5zpysBi3frhFIwqVQSvzaMupQjSRvLBqaBmxkStJqTcV5sIXkdcVC/TtbPymIIeAqx/eAH8bggVqGjtRuc7eJaSUhlp+zfiaddG5gQeALzvhNj9+11PNAYQSPfZNHHIl7AvUChe5qlDoD6m4CmvECBbsSCWgSYfs0VzVi5cTfRdmkhvqxhHebWKa43fYS4OCg/6+uEQohmDRY0U6eCo4bsorys4IIBoAnMMuNUKly
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(54906003)(478600001)(5660300002)(66476007)(66946007)(52116002)(26005)(66556008)(107886003)(4326008)(6486002)(16576012)(316002)(186003)(36756003)(86362001)(1076003)(44832011)(6916009)(2906002)(6666004)(8676002)(8936002)(956004)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Y1BdfyGOC1u4E+XS6p32CwWM6D3fXvI+AmXSpKjdCoQUqJ5lp1fIyBC8/uCvoOARwh8MJXSBF0KgqkG7QDy4+nr6o1jQBLQ6EJlsl1PjrpPs+12WzI6gw13tMGhtLJW5uyQu6jFgqztWTkqVafxu9MJkLki38whFRU2K2HtxQz/+ARC2lEwzcaLntWEsj4tjpAhSGApjcuIHAGFUwwijiEeYSjr3K7RJz0V+3zIul8eFMZelvw1PEWWAOO2wRG4a5K+5gtjU81cvBpkRpFB97zKDjC+PMOJ1CGZRqtNif4DKjCExLEC0atqp7e7BI74J7PpMlHIbbfXaoCnpH3TToDPse3tEB93+VqLHq0qs4Eqancs8BUr1D9s2w7eM0/yLc51V+ruNhNNYt1iq/zSMfU0BRgRObKJjnMCXRoYBJuX+N9ZbUu3CwFm+dU+X2Hi8ynnOpmiwohKthHBmM7qtYT6lmUrGGktJsLscpqRajhPK5rx5OZ4DlfyD6Ifc+4qnOP0rl+ydzFamPLrH8Y4lyB4qFEAxkgCiOkgAaXW4QcH7LHI6BrSCQvKYFbM3Gp6hhB+C+yzTaTzcAZ0YvfGir5ZwejuIZQhUy2gRxzMxO4D5NMls1SwxUSy5z0FGAOboZhX7VoXxysK5uy99l/HTfQ==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af61b1d3-b035-44fc-cb9b-08d84e40d915
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 06:32:50.3760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66N9F0eP+lIuBxZTj02ZU59daRFuY9z5uNN14itBF3nEMZj/DUXUE240dj1oMG98uBj0AtAVgQlBYzXtpIXIwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB2867
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hostap has a parameter "ap_isolate" which is used to prevent low-level
bridging of frames between associated stations in the BSS.
Regarding driver side, we add cfg80211 ops method change_bss to support
setting AP isolation if firmware has ap_isolate feature.

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 23 +++++++++++++++++++
 .../broadcom/brcm80211/brcmfmac/feature.c     |  1 +
 .../broadcom/brcm80211/brcmfmac/feature.h     |  3 ++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 5d99771c3f64..7ef93cd66b2c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5425,6 +5425,26 @@ static int brcmf_cfg80211_del_pmk(struct wiphy *wiphy, struct net_device *dev,
 	return brcmf_set_pmk(ifp, NULL, 0);
 }
 
+static int
+brcmf_cfg80211_change_bss(struct wiphy *wiphy, struct net_device *dev,
+			  struct bss_parameters *params)
+{
+	struct brcmf_if *ifp;
+	int ret = 0;
+	u32 ap_isolate;
+
+	brcmf_dbg(TRACE, "Enter\n");
+	ifp = netdev_priv(dev);
+	if (params->ap_isolate >= 0) {
+		ap_isolate = (u32)params->ap_isolate;
+		ret = brcmf_fil_iovar_int_set(ifp, "ap_isolate", ap_isolate);
+		if (ret < 0)
+			brcmf_err("ap_isolate iovar failed: ret=%d\n", ret);
+	}
+
+	return ret;
+}
+
 static struct cfg80211_ops brcmf_cfg80211_ops = {
 	.add_virtual_intf = brcmf_cfg80211_add_iface,
 	.del_virtual_intf = brcmf_cfg80211_del_iface,
@@ -7492,6 +7512,9 @@ struct brcmf_cfg80211_info *brcmf_cfg80211_attach(struct brcmf_pub *drvr,
 	if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_WOWL_GTK))
 		ops->set_rekey_data = brcmf_cfg80211_set_rekey_data;
 #endif
+	if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_AP_ISOLATE))
+		ops->change_bss = brcmf_cfg80211_change_bss;
+
 	err = wiphy_register(wiphy);
 	if (err < 0) {
 		bphy_err(drvr, "Could not register wiphy device (%d)\n", err);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
index 0dcefbd0c000..1ffa9742612d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
@@ -278,6 +278,7 @@ void brcmf_feat_attach(struct brcmf_pub *drvr)
 	brcmf_feat_iovar_int_get(ifp, BRCMF_FEAT_RSDB, "rsdb_mode");
 	brcmf_feat_iovar_int_get(ifp, BRCMF_FEAT_TDLS, "tdls_enable");
 	brcmf_feat_iovar_int_get(ifp, BRCMF_FEAT_MFP, "mfp");
+	brcmf_feat_iovar_int_get(ifp, BRCMF_FEAT_AP_ISOLATE, "ap_isolate");
 
 	pfn_mac.version = BRCMF_PFN_MACADDR_CFG_VER;
 	err = brcmf_fil_iovar_data_get(ifp, "pfn_macaddr", &pfn_mac,
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
index cda3fc1bab7f..243d9afddb8c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
@@ -49,7 +49,8 @@
 	BRCMF_FEAT_DEF(MONITOR_FMT_RADIOTAP) \
 	BRCMF_FEAT_DEF(MONITOR_FMT_HW_RX_HDR) \
 	BRCMF_FEAT_DEF(DOT11H) \
-	BRCMF_FEAT_DEF(SAE)
+	BRCMF_FEAT_DEF(SAE) \
+	BRCMF_FEAT_DEF(AP_ISOLATE)
 
 /*
  * Quirks:
-- 
2.25.0

