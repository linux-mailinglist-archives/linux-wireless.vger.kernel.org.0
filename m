Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4004293311
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Oct 2020 04:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390593AbgJTC3w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Oct 2020 22:29:52 -0400
Received: from mail-eopbgr750098.outbound.protection.outlook.com ([40.107.75.98]:53075
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730463AbgJTC3w (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Oct 2020 22:29:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsxaVPFn/QsMfnhigUnBe7WBR7XNZJkMPZ7vQB5TE/JBJ9DpGjtQwchFbqoI3/IGEWsIil/xn4hC6k3cq3M92i9XBwHedXAuRCkGzT0ZSnKovGcco6VEpK/hjjN9ayNnZyMR6gX3dAElN/l5FeALmmatvW1eVVrLof58aqV0uQnYiVuJB5Ow3KnR87bPcwGvBGpWLz/3lHH9yI7eHr1LWyuhhQ8A8KZz+wt130F00apDRQ+JrVtDB/qcqTpujsOS7FAfPmWKlU2yE9LO2EdhysNcBTsCXiJZdaQpETITsYIyzhZbgWquAqQbLtHu3vgufECf922JvhmHFQJ61s7CdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9zG1x01E81IBitMIpvBbuBIcK1BZ5S+ABE3baWRw0M=;
 b=n0HcbVqNTKhlx8h5Gg3QRaUsoHqyVKzwD9TeiSQcgMf8NxdIJRi/HKC8dmQ7TXH9voXyup9hv9jBCvqSTDs2tIQ0Ck/z/7PZSVuq1rNgBMQ2SzanCtJC1K5oa/6dWvNk4dVQEZOUpoznYDzP8A2QyccBDP2lhWrA+ewS5YN8vlZW7kOOGeY9vAyzIOSJ7LpmidTjf99YsYdmCKE1858Dmx1MRXSomuzHi+nkbpmzXXEip9Ri/D5gW0UkCZ8RHWj1jEIiw2hnpNGZmn3myaMRvge1H/L7nsWp/oB4ES1U9iw0y0trvGVzTwRNTjWhHU+POZqNrFStjQhwTuWVHJXPQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9zG1x01E81IBitMIpvBbuBIcK1BZ5S+ABE3baWRw0M=;
 b=polEDBTkZ0uzapWF9OooquU1NZQP4hBH3IsHmaqK0+Q665qek7BqEBma1sY9dcPcIrVf7n0wKCNrE+GYFCApY+MmXp+bq86V/OTb7HA+2LTrjfm8QTWIMtdW5PIplnwF5JxwNCZvRJ8W5em14XVIgSinrCUVCVVfci7UVNtV28M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN6PR06MB3251.namprd06.prod.outlook.com (2603:10b6:405:3e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Tue, 20 Oct
 2020 02:29:40 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::59fc:a93d:7f49:e843]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::59fc:a93d:7f49:e843%5]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 02:29:40 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Subject: [PATCH v2 1/4] brcmfmac: add change_bss to support AP isolation
Date:   Mon, 19 Oct 2020 21:28:09 -0500
Message-Id: <20201020022812.37064-2-wright.feng@cypress.com>
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
Received: from aremote06.aus.cypress.com (157.95.12.33) by MN2PR15CA0027.namprd15.prod.outlook.com (2603:10b6:208:1b4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Tue, 20 Oct 2020 02:29:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 818be0e5-5a2e-437a-b308-08d8749ffefb
X-MS-TrafficTypeDiagnostic: BN6PR06MB3251:
X-LD-Processed: 011addfc-2c09-450d-8938-e0bbc2dd2376,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR06MB3251E63C3BAA15AF8E763A69FB1F0@BN6PR06MB3251.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v7aWXeXLE3YXzyelW/ugfZ7IVbHU0Z3Ut9FjLczuPSuDt9YEkrGNrVyIKootqQsqtKsvzw3nmfZ0ctPTSKAfkm56ryYAe6nCneF3TJdWR3yIdaF1chdwU0QZUbwaPCZQ+JOdbX/JrT7GJwAnX7DmiZnxRw11cWa8I7epzRFAyBnG6Wc2cEahWZD/YztPYpz2ifQP/hF3sgI34kL9vtmGXj973ncv7856mr+FlxbQiYlEKSHxfEl1UNfeYq+DjgCZkhbqcIhPZ5+3qfUn4PlM/BL9vZXQZmXByHgMxRO68hMnVDepWol8ke8bzHD7E23j9bKhChneNii2TYo80Kbjvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(66946007)(66556008)(66476007)(7696005)(52116002)(6486002)(8676002)(186003)(16526019)(1076003)(316002)(44832011)(6666004)(478600001)(26005)(5660300002)(2906002)(86362001)(6636002)(54906003)(83380400001)(36756003)(8936002)(956004)(110136005)(2616005)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: m1Lm/fy8lY43fu61J88leboYCz8+o5DSWhzSkJYGxLquPIwq0feAS2FrY4Qc9kDzMLM8LrJNdQSnEoR+rDKQUC928h9z/96tCbv5ro3B5BKmyxs03WfFDNjuRkDVFI29JYPxKQdcXVcsKzKLJh6ARNoqS/LD7+qgX6S35InBJa7CYl5dDBdh+j42qOtBs4Z9EwNcvNVTu3N18/DMjSusXrYCZ4zlSOSYCL3KsqTyFP33R+udoN1BIuaFQJMXYFpdBE/wyJ6y6NlzZz87WQf5B0myoGTc6HqPuK32/lNe8q2W1Z4JLl+POpAQsLE5XUzVxC/SHB/TTB5T7Euy0xKpA6fEavPyfIGVgWtItXz5itaecgLhuIzv2mz5Pgyu8jfQXWzqHOXWrFxNgImWHHD8J2lW8AKGro5n5gGNsqz5aHi/RA+NfUMmb+9nWSrIhVQfBG7f4bNoJYg491Z+Ary6ibE8w82WF+gcS2viKRcrKMG04j3l3W5ijijjyvuHm8sMHZbuLOpUnqCe2qWSrd1MHurrbkGfS/GnAEpjUKLq0/pDOL7NNcEAkWQYAKjGk6Ng3camcht+krOaFk2OKHdjvhobTTFgAcHA4i2mew8BOwycv8nDwMbORag3VJm+H0AVA2IFNKDQhrt7MbWoXtXy+Q==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818be0e5-5a2e-437a-b308-08d8749ffefb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 02:29:40.3813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVN81/Fc/axwryUxioqP+BGU958KlVQ6W4Gd8hgBALDkVkoYCKrD/1FFjdnzQYu6fz3uR7cB2oz80VlzfB5cNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3251
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
v2: Remove u32 cast
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 23 +++++++++++++++++++
 .../broadcom/brcm80211/brcmfmac/feature.c     |  1 +
 .../broadcom/brcm80211/brcmfmac/feature.h     |  3 ++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index a2dbbb977d0c..4d0447784426 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5466,6 +5466,26 @@ static int brcmf_cfg80211_del_pmk(struct wiphy *wiphy, struct net_device *dev,
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
+		ap_isolate = params->ap_isolate;
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
@@ -7540,6 +7560,9 @@ struct brcmf_cfg80211_info *brcmf_cfg80211_attach(struct brcmf_pub *drvr,
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
index 7c68d9849324..1118b291fb29 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
@@ -279,6 +279,7 @@ void brcmf_feat_attach(struct brcmf_pub *drvr)
 	brcmf_feat_iovar_int_get(ifp, BRCMF_FEAT_RSDB, "rsdb_mode");
 	brcmf_feat_iovar_int_get(ifp, BRCMF_FEAT_TDLS, "tdls_enable");
 	brcmf_feat_iovar_int_get(ifp, BRCMF_FEAT_MFP, "mfp");
+	brcmf_feat_iovar_int_get(ifp, BRCMF_FEAT_AP_ISOLATE, "ap_isolate");
 
 	pfn_mac.version = BRCMF_PFN_MACADDR_CFG_VER;
 	err = brcmf_fil_iovar_data_get(ifp, "pfn_macaddr", &pfn_mac,
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
index d1f4257af696..cec5a9c4b18c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
@@ -51,7 +51,8 @@
 	BRCMF_FEAT_DEF(MONITOR_FMT_HW_RX_HDR) \
 	BRCMF_FEAT_DEF(DOT11H) \
 	BRCMF_FEAT_DEF(SAE) \
-	BRCMF_FEAT_DEF(FWAUTH)
+	BRCMF_FEAT_DEF(FWAUTH) \
+	BRCMF_FEAT_DEF(AP_ISOLATE)
 
 /*
  * Quirks:
-- 
2.25.0

