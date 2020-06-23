Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F682053DB
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 15:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732823AbgFWNt5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 09:49:57 -0400
Received: from mail-co1nam11on2132.outbound.protection.outlook.com ([40.107.220.132]:43488
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732633AbgFWNt4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 09:49:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJz0fc92mok2xpI9yWD0409p5kQDjkWTZHzbuI3ISParK3hsR2LHa0x12Vh9gBAFhV9UnEz0Q/0qCZhV0YxZNsFOJmMoVEd4RoVzY3ysJFRVTO63e8w7Z/r61C5Ou/HW6vvfQA+eQl9bp8u0lROe1t7WVaM4C/C2mpBwSF8Gm5W0HktpjvHnfDDSm4b46u7Yx4s0mDPcmjgcD/yCdIWLVVyfQmM1FT5Rz3wf+QzQFTBVmrdoi4FMTbKosAf+LNRXwkEshYLLLTRZJcR3tHZw41J5BHxu3xxjoWrWR34LVg/muN0L2cnkP30CxKWhX//0fQJkYaWSwVGVsrUSajdZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZ9bIB7AhNISQI2aa5xjMbmm440GNSyP4ENoQo9zrbY=;
 b=W1rpZiT/BSX//xTmYD3V077KKF2zKimSG0xW1NqMVNjcD/wCAGLuxQueRHWE1JuIXXvO8fuJeg0F5h90Izhasb5qWfIyGr0eyPSfHU5IOCliJQAAMJf5JEbWzsuFcIMgYByEHumkH5kDByU0COrDNzX7v6tBn9DzNCGKte4mISR2GyLdB9Ln5vRDYuhj2pe5U4gVvLLtGxwdXKj3zWJC7YAPi81Z0ijVa9CY3IGMe3t+JHknlN8D5hG+LfMyPv0kZ/e2T7aKav+xWhSdrbgq0NtISH0ypbzfrJ3wZVBQ4mzjQIodah0AcEvGDZRE3N1/0t9ZXiJqWbHJkSxiA+izRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZ9bIB7AhNISQI2aa5xjMbmm440GNSyP4ENoQo9zrbY=;
 b=IDCZgYsTIYKh/GNnnslKaonHIgSd7xryNgp0sfhrWqtvkiQiRA4AKVStxiDADj5SYYBbm/3YonOET3O8Tu7S9a9lFVoHBGBSML66LLSbXNqajQv6Tv94qmN8xDt7N9zwuJatN/sHvD8F6Pr+1kd8S/+PnOgIL4gyjNj+qtJZlEA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BY5PR06MB6449.namprd06.prod.outlook.com (2603:10b6:a03:23d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 13:49:51 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 13:49:51 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chung-Hsien Hsu <stanley.hsu@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 2/4] brcmfmac: support 4-way handshake offloading for WPA/WPA2-PSK in AP mode
Date:   Tue, 23 Jun 2020 08:49:36 -0500
Message-Id: <20200623134938.39997-3-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200623134938.39997-1-chi-hsien.lin@cypress.com>
References: <20200623134938.39997-1-chi-hsien.lin@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:208:23a::21) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:23a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 13:49:49 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dd09977d-28b4-4d1d-88db-08d8177c4d1f
X-MS-TrafficTypeDiagnostic: BY5PR06MB6449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR06MB644905CA6775C515496B009FBB940@BY5PR06MB6449.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjZjikoun2Bn//JaSUOg/vsJoOfmPJPPL4H10fRXLKSYHkW694wGd/aiZ8rgABswqN4X8pHkLoJzqXb7yq2JGOeiRluO6eBENaTDXxFVoWlRVIWq7M6Lxh3QvDh5wHs3RUEPOAdkwa9XFD00dqpacATgIFdr1kFTtT5DJr93Nu/D0lnNfLytPzhIqgWD8tMR5551SDfQOLwMMwe6GyGQGpIBeTmuxdBBLShnBQb9F315GQDxAlIksw5d089KNYYJ1XleebnAeIHgxE+Tb3mWhrT0gP2y0QTaQToNgtslAopvxJP0tyRWUllD+K0DFabb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(16526019)(186003)(26005)(6666004)(83380400001)(498600001)(66556008)(52116002)(66476007)(7696005)(66946007)(54906003)(2616005)(956004)(8936002)(6916009)(8676002)(4326008)(107886003)(2906002)(1076003)(86362001)(36756003)(6486002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Z28F/VMTzKZyWG6TTcY0TbEIAguH10lYGZBltRc6T2WXvcXC9FEHp1gLXmjls2KNRCnXAZEXw9fmjCDfUJ8YxBkHAtRhM9OF+2Ty7Y7JV/xsjYcV5BaCiN9xjBQDPp7LKrRJwdq618pMHMWkRpSITi7nE+ASfZahjFg0e5RCaAHO8CzLlfK49ypLTrhtA3nVlciJRPYkr94ar0vgmY94H9asJWFSiKuIs8/cvKq9KfDmD/5NV41b0UKdZ8+xF3GCmKoy0hyCenoz7Qyq4XJZZmzn+1fwLLXN2+olNW0ylcbUBwxZVpazaXWtpa+xm+GDU3CWfPKftrcSaic85eRDnywYBVkYbrYpvbXePSptA4cn/biOCcNLMyCgVanqi73Ins4JGUSxQSWe1t4m4meB5bLC4xp6YN8DiKaDKwcO/YDX2kJb3pHwLRWgTtqpgeMIDEnV7xpS8a7THdophZ3hsO9HXheS7OYEVeRuMgayhsmigTu8IkTGd22Gxtbinjnd
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd09977d-28b4-4d1d-88db-08d8177c4d1f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 13:49:51.4498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ju/YTWgxUw+Lc+WksMhK5Ibp33abQw9tec5aTrkifMZCICcFGRhUiGxoafW0CU0Ch0RDWX8plb8J1TdsoZcCDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR06MB6449
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chung-Hsien Hsu <stanley.hsu@cypress.com>

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
index a757abd7a599..002c355d2e38 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -4673,6 +4673,8 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
 	struct brcmf_if *ifp = netdev_priv(ndev);
 	struct brcmf_pub *drvr = cfg->pub;
+	struct brcmf_cfg80211_profile *profile = &ifp->vif->profile;
+	struct cfg80211_crypto_settings *crypto = &settings->crypto;
 	const struct brcmf_tlv *ssid_ie;
 	const struct brcmf_tlv *country_ie;
 	struct brcmf_ssid_le ssid_le;
@@ -4812,6 +4814,17 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
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
@@ -4896,6 +4909,7 @@ static int brcmf_cfg80211_stop_ap(struct wiphy *wiphy, struct net_device *ndev)
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
 	struct brcmf_if *ifp = netdev_priv(ndev);
 	struct brcmf_pub *drvr = cfg->pub;
+	struct brcmf_cfg80211_profile *profile = &ifp->vif->profile;
 	s32 err;
 	struct brcmf_fil_bss_enable_le bss_enable;
 	struct brcmf_join_params join_params;
@@ -4907,6 +4921,12 @@ static int brcmf_cfg80211_stop_ap(struct wiphy *wiphy, struct net_device *ndev)
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
@@ -7046,6 +7066,9 @@ static int brcmf_setup_wiphy(struct wiphy *wiphy, struct brcmf_if *ifp)
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

