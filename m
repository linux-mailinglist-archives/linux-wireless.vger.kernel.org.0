Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B741245E16
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Aug 2020 09:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgHQHdz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Aug 2020 03:33:55 -0400
Received: from mail-eopbgr760113.outbound.protection.outlook.com ([40.107.76.113]:42094
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726746AbgHQHdp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Aug 2020 03:33:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cel/WD/VUyk/D2PXz9YH39G/amo42AnaklYlF/diS1z0IZxVqMObWhMzXPaHU35qG/sFRIx/shbTiEIFbaQfwFnhtAgW2v+87VnVBaNGBdOWD3sS1lAQDaFmLW7JOqX+w45e3y1ZoCqw1eLQ+w3ZBxZ94t2dSOCPy4W6G16SqEAypt1FmTPwUwFWff1qXmcbZUcU4uZFrNMi5ShUfYnUsK2WHKA0JEWK0jLbMlhxionJY+7r8+cx3f2FPvYIMooqxVRzGxe0kEl3rE4lUC/X2S/LhW8F7cGF9oqmcviS5MwuviSHGWTV+HdSL5nR3d0PMO5l+LF/E+7fkYpLC6GiUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaCcT+FmsHGT+Om9rnn3tCtvLP3thoKdw2NHKruOpoU=;
 b=KFsOt253RN3Hq3OrVN83r5VrgjxuJdFIhfy2kc7T3iZcrI4qSEtuJM1anzQzM1D2v8+bxk18CQ3y+Vl/LMLdSpG/vnAFfiXUy6L3LvUciBsAx/hfK6LVr028YQzBOx3pZ9sfe7iw4Zhe0uVrE09H+eDi6UKfNcNF/bgsA0rerQFCC4yASMycjVZtZ4LclYIYlhquILY5T2szOqPAS/cz/mIcCzOheF2C+N3oWXJXVl05eXKDO8fw4M6+DfvjI+yV9UQ/0Tfeaa+mDmrnkygWcqmC2xgZ9YZEYv8jjXZIRoq9ymb4kfWBvVCsMkuW1Ih8UCuoAFfWSNRgn4CrcrtvAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaCcT+FmsHGT+Om9rnn3tCtvLP3thoKdw2NHKruOpoU=;
 b=EUNHSGfCWUd/EXOAh2wXp8NCQ2mAmV0Kn7o8uHZkyp0IK5pUVcoyInNM8XHMTDr0gG1PT1UC8/dIQlAPg8mlfijoyVcf109IenjcdkU/72VV418iQDQOUZlzGgxnMtzBhD2k8GjZa1ckMrnsZbbltCj1lEkLUdWKQ9cS6XYXXqE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN6PR06MB3043.namprd06.prod.outlook.com (2603:10b6:404:5a::23)
 by BN6PR06MB3009.namprd06.prod.outlook.com (2603:10b6:404:57::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Mon, 17 Aug
 2020 07:33:39 +0000
Received: from BN6PR06MB3043.namprd06.prod.outlook.com
 ([fe80::4196:7f99:bc78:4e7e]) by BN6PR06MB3043.namprd06.prod.outlook.com
 ([fe80::4196:7f99:bc78:4e7e%12]) with mapi id 15.20.3283.020; Mon, 17 Aug
 2020 07:33:39 +0000
From:   Chung-Hsien Hsu <stanley.hsu@cypress.com>
To:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chung-Hsien Hsu <stanley.hsu@cypress.com>
Subject: [PATCH v2 2/4] brcmfmac: support 4-way handshake offloading for WPA/WPA2-PSK in AP mode
Date:   Mon, 17 Aug 2020 02:33:14 -0500
Message-Id: <20200817073316.33402-3-stanley.hsu@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200817073316.33402-1-stanley.hsu@cypress.com>
References: <20200817073316.33402-1-stanley.hsu@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0023.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::36) To BN6PR06MB3043.namprd06.prod.outlook.com
 (2603:10b6:404:5a::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote06.aus.cypress.com (157.95.12.33) by MN2PR15CA0023.namprd15.prod.outlook.com (2603:10b6:208:1b4::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Mon, 17 Aug 2020 07:33:38 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [157.95.12.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f9dbfe82-29b4-44ca-02ca-08d8427fdbc9
X-MS-TrafficTypeDiagnostic: BN6PR06MB3009:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR06MB30092810871EBBB7078B1633F05F0@BN6PR06MB3009.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pszd3zj8F+cSCuw2mWZ0q4hVS+E6+8XnwcebigXYT/cJ2NFiOm4R2269QIeNQ2dCt5B2CJJO5OQLE6RYAlCVTIKD2opZmmM/nttNDMpqci+jpuPpVNkeBmHaNKywXIyJ1WeljxNedoi8K0dc4/tVWvIZvzyuRD/aWcKheGyzrvJCPCapCN5Sa7aDTDZKeBLkg9gdZocqzDwavjJh3P1kj6Kal2Z0PNwiTDnx7k/iXeDj2cqSTDK5pt5goX2q7orn5dSTkxT0WgvvVN7quM48isSSA+iB1pI4r/LxlWTliHpPyaGfGHvCbQPkzpfNHO+a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR06MB3043.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(66946007)(2906002)(66476007)(4326008)(16526019)(83380400001)(54906003)(66556008)(186003)(8676002)(1076003)(6916009)(5660300002)(316002)(8936002)(36756003)(6666004)(7696005)(52116002)(107886003)(478600001)(86362001)(2616005)(26005)(6486002)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: z6V9k8vQcAwIvKXQYS1ERhowdPexfArQutnpt+N6Thaf5r9HS5D85haII81JbNdItnUwWRQYB4l2NvyVC3l02oqhuUA+AE7GcQPyWRGOkBdE/oxWSmZt7Sj93PFxtRv9g7v0Mdu/T7rE0x22C6vie2OAS7YAUiIEos6lBMpKiEr4LiEIqf2QxGPjx8/FQtfDscME9WpscgP2aofPdu+JcANatZxvOGEKDyhB9xTgnFt+XWJhxoNEjmbx0FnrTBrWYddfp40i/WAeG6T8CDpOItPes6IK1BcSyclXaZ0ujnK+z9sTwRwHBk/NcC2u4LbHwVitvNDsb/kWoSpCzL5moTXwBe5SVPGsMAv98DM0U1NoxdqAWwPRpv7CAmoWpWS6ZrvYArUm+y5fkDWAnp+WogmsSnWmUteNsPgUdGoqVBZ9Wa80HdlHjgfkVFkp+rdPzFvEIzFADQFZ9sOI0dmWqtd+Dp0T5KrD7f6WOxV5oCddbQ7zal4jkBnWL6ucEZlp20apovfBQR6vFaEM3Bx66BwNzrzqS4P1HZsiD7ZGQG0Wlix7P3cKFHLxI6HOJE57Hfc+UlcbFeUw28SL+ceIPZwK029GibVJlEOncy3utNKxdw32ar3p1m9m+Zl+IQNewic6KK6A5e+REvrAivXLYg==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9dbfe82-29b4-44ca-02ca-08d8427fdbc9
X-MS-Exchange-CrossTenant-AuthSource: BN6PR06MB3043.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 07:33:39.5215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKY+qIN9XdGSCKrSD5aXfX1p5NuZo2/9W8aybfHIWauwPrl/s9M103tpiaeRlGyHZUEfEZhtYFZ6nroXdJ1PMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3009
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Firmware may have authenticator code built-in. This is detected by the
driver and indicated in the wiphy features flags. User space can use
this flag to determine whether or not to provide the pre-shared key
material in the nl80211 start AP command to offload the 4-way handshake
in AP mode.

Signed-off-by: Chung-Hsien Hsu <stanley.hsu@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 23 +++++++++++++++++++
 .../broadcom/brcm80211/brcmfmac/cfg80211.h    | 12 ++++++++++
 .../broadcom/brcm80211/brcmfmac/feature.c     |  1 +
 .../broadcom/brcm80211/brcmfmac/feature.h     |  4 +++-
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 5d99771c3f64..0dc6afa2ee0e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -4674,6 +4674,8 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
 	struct brcmf_if *ifp = netdev_priv(ndev);
 	struct brcmf_pub *drvr = cfg->pub;
+	struct brcmf_cfg80211_profile *profile = &ifp->vif->profile;
+	struct cfg80211_crypto_settings *crypto = &settings->crypto;
 	const struct brcmf_tlv *ssid_ie;
 	const struct brcmf_tlv *country_ie;
 	struct brcmf_ssid_le ssid_le;
@@ -4813,6 +4815,17 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 			goto exit;
 		}
 
+		if (crypto->psk) {
+			brcmf_dbg(INFO, "using PSK offload\n");
+			profile->use_fwauth |= BIT(BRCMF_PROFILE_FWAUTH_PSK);
+			err = brcmf_set_pmk(ifp, crypto->psk,
+					    BRCMF_WSEC_MAX_PSK_LEN);
+			if (err < 0)
+				goto exit;
+		}
+		if (profile->use_fwauth == 0)
+			profile->use_fwauth = BIT(BRCMF_PROFILE_FWAUTH_NONE);
+
 		err = brcmf_parse_configure_security(ifp, settings,
 						     NL80211_IFTYPE_AP);
 		if (err < 0) {
@@ -4899,6 +4912,7 @@ static int brcmf_cfg80211_stop_ap(struct wiphy *wiphy, struct net_device *ndev)
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
 	struct brcmf_if *ifp = netdev_priv(ndev);
 	struct brcmf_pub *drvr = cfg->pub;
+	struct brcmf_cfg80211_profile *profile = &ifp->vif->profile;
 	s32 err;
 	struct brcmf_fil_bss_enable_le bss_enable;
 	struct brcmf_join_params join_params;
@@ -4910,6 +4924,12 @@ static int brcmf_cfg80211_stop_ap(struct wiphy *wiphy, struct net_device *ndev)
 		/* first to make sure they get processed by fw. */
 		msleep(400);
 
+		if (profile->use_fwauth != BIT(BRCMF_PROFILE_FWAUTH_NONE)) {
+			if (profile->use_fwauth & BIT(BRCMF_PROFILE_FWAUTH_PSK))
+				brcmf_set_pmk(ifp, NULL, 0);
+			profile->use_fwauth = BIT(BRCMF_PROFILE_FWAUTH_NONE);
+		}
+
 		if (ifp->vif->mbss) {
 			err = brcmf_fil_cmd_int_set(ifp, BRCMF_C_DOWN, 1);
 			return err;
@@ -7058,6 +7078,9 @@ static int brcmf_setup_wiphy(struct wiphy *wiphy, struct brcmf_if *ifp)
 			wiphy_ext_feature_set(wiphy,
 					      NL80211_EXT_FEATURE_SAE_OFFLOAD);
 	}
+	if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_FWAUTH))
+		wiphy_ext_feature_set(wiphy,
+				      NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK);
 	wiphy->mgmt_stypes = brcmf_txrx_stypes;
 	wiphy->max_remain_on_channel_duration = 5000;
 	if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_PNO)) {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
index 333fdf394f95..bf86e0ca941e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
@@ -128,6 +128,17 @@ enum brcmf_profile_fwsup {
 	BRCMF_PROFILE_FWSUP_SAE
 };
 
+/**
+ * enum brcmf_profile_fwauth - firmware authenticator profile
+ *
+ * @BRCMF_PROFILE_FWAUTH_NONE: no firmware authenticator
+ * @BRCMF_PROFILE_FWAUTH_PSK: authenticator for WPA/WPA2-PSK
+ */
+enum brcmf_profile_fwauth {
+	BRCMF_PROFILE_FWAUTH_NONE,
+	BRCMF_PROFILE_FWAUTH_PSK
+};
+
 /**
  * struct brcmf_cfg80211_profile - profile information.
  *
@@ -140,6 +151,7 @@ struct brcmf_cfg80211_profile {
 	struct brcmf_cfg80211_security sec;
 	struct brcmf_wsec_key key[BRCMF_MAX_DEFAULT_KEYS];
 	enum brcmf_profile_fwsup use_fwsup;
+	u16 use_fwauth;
 	bool is_ft;
 };
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
index 0dcefbd0c000..7c68d9849324 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
@@ -42,6 +42,7 @@ static const struct brcmf_feat_fwcap brcmf_fwcap_map[] = {
 	{ BRCMF_FEAT_MONITOR_FMT_RADIOTAP, "rtap" },
 	{ BRCMF_FEAT_DOT11H, "802.11h" },
 	{ BRCMF_FEAT_SAE, "sae" },
+	{ BRCMF_FEAT_FWAUTH, "idauth" },
 };
 
 #ifdef DEBUG
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
index cda3fc1bab7f..d1f4257af696 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
@@ -28,6 +28,7 @@
  * MONITOR_FMT_HW_RX_HDR: firmware provides monitor packets with hw/ucode header
  * DOT11H: firmware supports 802.11h
  * SAE: simultaneous authentication of equals
+ * FWAUTH: Firmware authenticator
  */
 #define BRCMF_FEAT_LIST \
 	BRCMF_FEAT_DEF(MBSS) \
@@ -49,7 +50,8 @@
 	BRCMF_FEAT_DEF(MONITOR_FMT_RADIOTAP) \
 	BRCMF_FEAT_DEF(MONITOR_FMT_HW_RX_HDR) \
 	BRCMF_FEAT_DEF(DOT11H) \
-	BRCMF_FEAT_DEF(SAE)
+	BRCMF_FEAT_DEF(SAE) \
+	BRCMF_FEAT_DEF(FWAUTH)
 
 /*
  * Quirks:
-- 
2.25.0

