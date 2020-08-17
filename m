Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B3C245E19
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Aug 2020 09:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgHQHeC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Aug 2020 03:34:02 -0400
Received: from mail-eopbgr760113.outbound.protection.outlook.com ([40.107.76.113]:42094
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726583AbgHQHeA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Aug 2020 03:34:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUcOoCpl/3Yr/szPr3p7mYAqs2m/3+1GngbY/dLsfcsvP4bk5jSD1y/ePOoaVyVP489KRZEbku6MMXd0qoXU4Z+BflRwBuG3nMACYbbHcohq1FfU5CcwoUguEX4U4FF0Cd0HrvUdxASp21/j/tpSJPBoPXacT8vH/HIkwu/lL4Sef8USgZdpaKakG618i2Pqa3XduAP2ojwncZrwmNGWLeepZFEE9U/AUzjGm1QPUkATJkZN7rGc70hk37h81HOSWKCjkq9iojS8xd5RIbBB4P00MsZjJqAr7X8rzZsEtEJD7892530L/N115GC+Sm2RSlFhmT+jTEH+PPp7Yd+dWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yF9rRNKFsjihk0VwblQdA9sIfWTQ9v972BP3Po7ZEaE=;
 b=DE17bAFlpKQJ+At5wBLU2ONjUkuTgyT0+lnnmafdgQaPMgTGks7+IJ+9eCYeJ2ZiNLI+Q04d5Kd14ZgwJTVjtJfRthbXHZQtsaNaG0bItpLe2iFHGe3+/BBOE/491bo4Ek1hPuHkHvSv2lqdjfU7jXn5p7I5bBvzU3U+X3X8kd4WeHZOW8PKxx2lNBUw/ciunUE3kLMin0O/hoRSoAbgIN5PIiXHZ24NAmoMtW90bNMF/SKZP8H/pir0aZDCAk/Cx7CykL3o5V6M5rU2HqLECNxzKmPaYaBVzL4XK8br2CG9UstWaV4fWRBk6IyXnLwayvdxl3JikdgG/d8IBaryxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yF9rRNKFsjihk0VwblQdA9sIfWTQ9v972BP3Po7ZEaE=;
 b=bshYY6bducVhYvC51R/uZB0cvHDoWKY1lNfxRuU0TD5BIE5n05Gir49SUHV5r0cv3p/zBEojnTncGo9nD5zEFAwV+6BCR/HXn+pmJdT512tG4KtPNIR8Q1FemItkO+nRSS5DjJjzvX9BSfQ1XElLEq63M6Kc7XkrcWnirhNyW68=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN6PR06MB3043.namprd06.prod.outlook.com (2603:10b6:404:5a::23)
 by BN6PR06MB3009.namprd06.prod.outlook.com (2603:10b6:404:57::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Mon, 17 Aug
 2020 07:33:46 +0000
Received: from BN6PR06MB3043.namprd06.prod.outlook.com
 ([fe80::4196:7f99:bc78:4e7e]) by BN6PR06MB3043.namprd06.prod.outlook.com
 ([fe80::4196:7f99:bc78:4e7e%12]) with mapi id 15.20.3283.020; Mon, 17 Aug
 2020 07:33:46 +0000
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
Subject: [PATCH v2 4/4] brcmfmac: support SAE authentication offload in AP mode
Date:   Mon, 17 Aug 2020 02:33:16 -0500
Message-Id: <20200817073316.33402-5-stanley.hsu@cypress.com>
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
Received: from aremote06.aus.cypress.com (157.95.12.33) by MN2PR15CA0023.namprd15.prod.outlook.com (2603:10b6:208:1b4::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Mon, 17 Aug 2020 07:33:44 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [157.95.12.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5831df53-1d5f-48f3-bb5d-08d8427fdfad
X-MS-TrafficTypeDiagnostic: BN6PR06MB3009:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR06MB30099556EE3C9FA3E0C9434BF05F0@BN6PR06MB3009.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zIh5jT5pNDf4AOLWFywwS087r/Q3MvqwI9G/RkM31xN6iJ3IsUoFpc0i3ojEm2oJKECkXq2sLnKFfsDDdMr4SeT+9dC40sGzyXLnVASGipn2WyU8hNNdX2ZfpKG+ciJrqmtW7SJq+r/XuTbRuesZTSRIirG/kTOdAo/32vUexoIK7oB9JjCT8otAES7Zy7TyCOrmdT8Ktsfe2ZuVDGWf5ngasMoiYLvcqTtmsoMq/Zg6NHJ9NIeIV4Npkl+6OkDnURgJ954I6z9DoXw9gR4N46ES5lnrTxXt/blbiMvCnaMtAZpWjWMMRHnJ3k08y8MikD0mrvBZQEmNBRXks/8g/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR06MB3043.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(66946007)(2906002)(66476007)(4326008)(16526019)(83380400001)(54906003)(66556008)(186003)(8676002)(1076003)(6916009)(5660300002)(316002)(8936002)(36756003)(6666004)(7696005)(52116002)(107886003)(478600001)(86362001)(2616005)(26005)(6486002)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: QsKfoDNakD7UwLqmKeE8ZXlx5QzhiCNr1VJhTOauqFBaksat3e/Jn0LzvHYMYXw9tE2lZNv71ct8xfE1cN0dH/sHc6wDLq3HImNwGFWx6lvIJiqgni342O9Mc+NKRQ7nXzusNj2MAe3m6GOU6RYx7tTNGqUoJBm246pkp3kL++N34zp824s4yqY60hpu14yRK039NgW46IUgusF2C7RhYJbm5/o4xMK8dOkdyUIF0qPzrx8QCn4CR5o1weAnzk1EmAraRB19t7FHB57WAHg5OYhbFEaMRFdfAVxxe6vETOwSSkBByzHmj0KWYpp5ysnYQAFwVjoBj1hv3LtqYNdh0jDCK6il2dWit5hWXY+HnjND5fWQwKviEzZB8VBgElvMtQ75ox2y5iJ6nhPfcwzEM/6TlVWaZkZwUARdT8pXy+Qdk4VCNM4w8u9K4TwsSOsGtllbsd86OTgBw2QmvR4F0vSPtfbuXEsN2xo8Qm1N+Z6kPJdWbSy2HvB198JwMXeaGnDgquEsQ5CLx8VjzkYZ1EgOfdWw8Fmc4qnlSm/w29MAfvMbxeGq/kzyagX37+5RD9Uqf+fAHF0JSf5dctCwIMLnJa/kaUeBfSeUsPZsf8ZOoxHnfsLxD8hTTriZ5O/0YmS4mopXpx0MgoxcPf3JjA==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5831df53-1d5f-48f3-bb5d-08d8427fdfad
X-MS-Exchange-CrossTenant-AuthSource: BN6PR06MB3043.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 07:33:46.0227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYpXMzzqKHlJzSr6Yhf1Zt1n2vaPvg9knC+MNsnEuhpoSHjND6dWD332LM69HcsgHnFK0y4hL37EkfyQuxL4Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3009
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Firmware may have SAE authenticator code built-in. This is detected by
the driver and indicated in the wiphy features flags. User space can use
this flag to determine whether or not to provide the password material
in the nl80211 start AP command to offload the SAE authentication in AP
mode.

Signed-off-by: Chung-Hsien Hsu <stanley.hsu@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
Changes in v2:
  - use a new flag for SAE offload in AP mode.
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 28 ++++++++++++++++---
 .../broadcom/brcm80211/brcmfmac/cfg80211.h    |  4 ++-
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 0dc6afa2ee0e..3e6e8479f95c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -56,6 +56,7 @@
 #define RSN_AKM_PSK			2	/* Pre-shared Key */
 #define RSN_AKM_SHA256_1X		5	/* SHA256, 802.1X */
 #define RSN_AKM_SHA256_PSK		6	/* SHA256, Pre-shared Key */
+#define RSN_AKM_SAE			8	/* SAE */
 #define RSN_CAP_LEN			2	/* Length of RSN capabilities */
 #define RSN_CAP_PTK_REPLAY_CNTR_MASK	(BIT(2) | BIT(3))
 #define RSN_CAP_MFPR_MASK		BIT(6)
@@ -4237,6 +4238,10 @@ brcmf_configure_wpaie(struct brcmf_if *ifp,
 			brcmf_dbg(TRACE, "RSN_AKM_MFP_1X\n");
 			wpa_auth |= WPA2_AUTH_1X_SHA256;
 			break;
+		case RSN_AKM_SAE:
+			brcmf_dbg(TRACE, "RSN_AKM_SAE\n");
+			wpa_auth |= WPA3_AUTH_SAE_PSK;
+			break;
 		default:
 			bphy_err(drvr, "Invalid key mgmt info\n");
 		}
@@ -4254,11 +4259,12 @@ brcmf_configure_wpaie(struct brcmf_if *ifp,
 				brcmf_dbg(TRACE, "MFP Required\n");
 				mfp = BRCMF_MFP_REQUIRED;
 				/* Firmware only supports mfp required in
-				 * combination with WPA2_AUTH_PSK_SHA256 or
-				 * WPA2_AUTH_1X_SHA256.
+				 * combination with WPA2_AUTH_PSK_SHA256,
+				 * WPA2_AUTH_1X_SHA256, or WPA3_AUTH_SAE_PSK.
 				 */
 				if (!(wpa_auth & (WPA2_AUTH_PSK_SHA256 |
-						  WPA2_AUTH_1X_SHA256))) {
+						  WPA2_AUTH_1X_SHA256 |
+						  WPA3_AUTH_SAE_PSK))) {
 					err = -EINVAL;
 					goto exit;
 				}
@@ -4823,6 +4829,14 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 			if (err < 0)
 				goto exit;
 		}
+		if (crypto->sae_pwd) {
+			brcmf_dbg(INFO, "using SAE offload\n");
+			profile->use_fwauth |= BIT(BRCMF_PROFILE_FWAUTH_SAE);
+			err = brcmf_set_sae_password(ifp, crypto->sae_pwd,
+						     crypto->sae_pwd_len);
+			if (err < 0)
+				goto exit;
+		}
 		if (profile->use_fwauth == 0)
 			profile->use_fwauth = BIT(BRCMF_PROFILE_FWAUTH_NONE);
 
@@ -4927,6 +4941,8 @@ static int brcmf_cfg80211_stop_ap(struct wiphy *wiphy, struct net_device *ndev)
 		if (profile->use_fwauth != BIT(BRCMF_PROFILE_FWAUTH_NONE)) {
 			if (profile->use_fwauth & BIT(BRCMF_PROFILE_FWAUTH_PSK))
 				brcmf_set_pmk(ifp, NULL, 0);
+			if (profile->use_fwauth & BIT(BRCMF_PROFILE_FWAUTH_SAE))
+				brcmf_set_sae_password(ifp, NULL, 0);
 			profile->use_fwauth = BIT(BRCMF_PROFILE_FWAUTH_NONE);
 		}
 
@@ -7078,9 +7094,13 @@ static int brcmf_setup_wiphy(struct wiphy *wiphy, struct brcmf_if *ifp)
 			wiphy_ext_feature_set(wiphy,
 					      NL80211_EXT_FEATURE_SAE_OFFLOAD);
 	}
-	if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_FWAUTH))
+	if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_FWAUTH)) {
 		wiphy_ext_feature_set(wiphy,
 				      NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK);
+		if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_SAE))
+			wiphy_ext_feature_set(wiphy,
+					      NL80211_EXT_FEATURE_SAE_OFFLOAD_AP);
+	}
 	wiphy->mgmt_stypes = brcmf_txrx_stypes;
 	wiphy->max_remain_on_channel_duration = 5000;
 	if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_PNO)) {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
index bf86e0ca941e..17817cdb5de2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
@@ -133,10 +133,12 @@ enum brcmf_profile_fwsup {
  *
  * @BRCMF_PROFILE_FWAUTH_NONE: no firmware authenticator
  * @BRCMF_PROFILE_FWAUTH_PSK: authenticator for WPA/WPA2-PSK
+ * @BRCMF_PROFILE_FWAUTH_SAE: authenticator for SAE
  */
 enum brcmf_profile_fwauth {
 	BRCMF_PROFILE_FWAUTH_NONE,
-	BRCMF_PROFILE_FWAUTH_PSK
+	BRCMF_PROFILE_FWAUTH_PSK,
+	BRCMF_PROFILE_FWAUTH_SAE
 };
 
 /**
-- 
2.25.0

