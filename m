Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A882053DD
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 15:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732827AbgFWNuB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 09:50:01 -0400
Received: from mail-co1nam11on2132.outbound.protection.outlook.com ([40.107.220.132]:43488
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732633AbgFWNuB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 09:50:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fytBb1CEFWlgQApcyrgs3vkoEGh+jadI5kGUafFBzyJJgLUh1h9ijxHnmd1bc6KWn4kwswLzAe6QHbooAi5vDKZ7sBUAKin7Se0G+100/IeB2EU+MPxsRRz+5TUb2lvr3c/u5Vsf2jgjA+dLHeAHh5aYbb4TucLHdSr4QLbBEjE3XJFe5oKgur2QRi/wiHVRUoFRLuz8TY/AzHWFcMQrPDrQq8QzsTzm5CFD/fQsz+X0UYiqTSc9DVMe08VrtSPUM83ATSM8wPm+bCN17BSqyj8shOqbPNtRzDH7QbyyCuJBFdvc2y0qsa8Rrd9uGQhaXGv9nQyjU9bL+Fa1kPo1ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaWJbf5qMHMAym4axHec3raXDtnTbBUJs25qCD08VjM=;
 b=SqCT3AYgR611ExBS1R5el1OR45/tnyIiYvaB1fU6nRJ9IaElmXPfgXT7BDWPtNBFkH7O58iryk+l7sV5oEUjPCoreP1iSNDa8tOIgu8M8C3x45Bydy3u1qCLSBkGubkDcj/aiS2ZUohx1dyfAYUCrRHLn7J21yEl+qWEFSCcPKPwSH9sDRRcG4ijfnatdfYQj8AnD/HtCRoyY1Z5eK7VBq1bX6LhnxB2lCBp/k9qfy60Q2ZFzQlvbsa2a7d4QJ+OvsUDtOlz3nx3AJskMEkB9Bd5VEFbGJMeb7MPzEwSofR7To0IQeLGCND1kc+Ye8k9/ojHjkdFX1Yli2Ahy6esxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaWJbf5qMHMAym4axHec3raXDtnTbBUJs25qCD08VjM=;
 b=df8WHVJKDNref7MIs2PY7gCW35sB4uj0t6cxg0pPfO8EBgV40zf1oPJIIj6mNWrSaMyR/TKUVhRbHmP74Xr3YNk+JxfixVEro0gwP20WpLAZ0zqnO+Fl2fRZ5oBXLqSvuk+D56L/7f9YHF3YbcOXsPSYQeUrk1YwkSgDWwRl+qA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BY5PR06MB6449.namprd06.prod.outlook.com (2603:10b6:a03:23d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 13:49:55 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 13:49:55 +0000
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
Subject: [PATCH 4/4] brcmfmac: support SAE authentication offload in AP mode
Date:   Tue, 23 Jun 2020 08:49:38 -0500
Message-Id: <20200623134938.39997-5-chi-hsien.lin@cypress.com>
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
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:23a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 13:49:53 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 619a9625-a797-4784-c35a-08d8177c4fa4
X-MS-TrafficTypeDiagnostic: BY5PR06MB6449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR06MB64490E1EE3BED4DB44A0D958BB940@BY5PR06MB6449.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HLKZXQt/f46S9EyyUG/MqPutz2cHdoeKrYNy51ioArGbeQEgstFUhKMpgv4dXWsZvqiEx+33/8la4MHmqbRKnaGME34mlOmxCdK3wEYZzxqu/MMDhPzViDPAgeWhuwUQp7VNKBOLZ6P9pP/CPEPNKppynokt4H7Yc79FhaqAEr8YHPzwJ0K4Xgvkuhnsbgsn8Ch6f33iTCqxMqON5Qc4Fg6FCJ7dww83kPBR/1rVo3OpoiwWOyB/9AyiI5gHw+l8EyQZMs5l3G5AVa26zWQOP2ptXpjp+8G9devyQVeWdBqt/VY5inJhZoOj/M56mhx1E85HEqZg+tzS1ldBuNvVkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(16526019)(186003)(26005)(6666004)(83380400001)(498600001)(66556008)(52116002)(66476007)(7696005)(66946007)(54906003)(2616005)(956004)(8936002)(6916009)(8676002)(4326008)(107886003)(2906002)(1076003)(86362001)(36756003)(6486002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: tFssi+2RHhigbVyKOSnKLljlzlIsbasIRJ+2bGFzvmXixnnZtjc1N51f6HUhfi1dym5u1ATWoEWq5wgqwrWATQnUEfUaq5qI0g6ofa3hoWDd+Fabnrx7AhVl1Q6Q/4p2RJTeN90mLbvKJ6sqLIkB2SqnvUpjQPe4GNfCVWX24zCGfU3w/gx8cCKLqWdtq0IqgEqzu9FgzNW9SL63SzdJ3cbRVdUjaQtojGRQldH1CGHgli47GbwpEFIEjn9x8mYoUEP/9P+NHef5lBtbmUQJg3mAxoUUZnfGmmctDQDnMyr2DGS2AI45duxgThiroklsp/YIFE5/Dz2Uvyau60BN7MsFt80lyTK5Nq9BveIsBMTEf2fgIlyUBRm0xCN+vqJlfjO1PcGBZ7EB4mHGPIiD3H/xoZZwXcLBrHs1a1ELZnCex8Nxh7cvNDUv95uP+Z3qtUSRKltK2clRlMEIKmpo30d8uRwYBDwH3FHGY1eoYMiOLB6qwMmYyom/FAuR2GNm
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 619a9625-a797-4784-c35a-08d8177c4fa4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 13:49:55.6584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lyr29e94+DQwG3dV06AdGtuui2woGr1RqzsCncqXPftabDTOQ/e1iwiHDsWR/1zRVQaqPojV4xNX6heMgosKqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR06MB6449
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chung-Hsien Hsu <stanley.hsu@cypress.com>

Firmware may have SAE authenticator code built-in. This is detected by
the driver and indicated in the wiphy features flags. Userspace can use
this flag to determine whether or not to provide the password material
in the nl80211 start AP command to offload the SAE authentication in AP
mode.

Signed-off-by: Chung-Hsien Hsu <stanley.hsu@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 28 ++++++++++++++++---
 .../broadcom/brcm80211/brcmfmac/cfg80211.h    |  4 ++-
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 002c355d2e38..3ef5cc1945ad 100644
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
@@ -4236,6 +4237,10 @@ brcmf_configure_wpaie(struct brcmf_if *ifp,
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
@@ -4253,11 +4258,12 @@ brcmf_configure_wpaie(struct brcmf_if *ifp,
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
@@ -4822,6 +4828,14 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
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
 
@@ -4924,6 +4938,8 @@ static int brcmf_cfg80211_stop_ap(struct wiphy *wiphy, struct net_device *ndev)
 		if (profile->use_fwauth != BIT(BRCMF_PROFILE_FWAUTH_NONE)) {
 			if (profile->use_fwauth & BIT(BRCMF_PROFILE_FWAUTH_PSK))
 				brcmf_set_pmk(ifp, NULL, 0);
+			if (profile->use_fwauth & BIT(BRCMF_PROFILE_FWAUTH_SAE))
+				brcmf_set_sae_password(ifp, NULL, 0);
 			profile->use_fwauth = BIT(BRCMF_PROFILE_FWAUTH_NONE);
 		}
 
@@ -7066,9 +7082,13 @@ static int brcmf_setup_wiphy(struct wiphy *wiphy, struct brcmf_if *ifp)
 			wiphy_ext_feature_set(wiphy,
 					      NL80211_EXT_FEATURE_SAE_OFFLOAD);
 	}
-	if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_FWAUTH))
+	if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_FWAUTH)) {
 		wiphy_ext_feature_set(wiphy,
 				      NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK);
+		if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_SAE))
+			wiphy_ext_feature_set(wiphy,
+					      NL80211_EXT_FEATURE_SAE_OFFLOAD);
+	}
 	wiphy->mgmt_stypes = brcmf_txrx_stypes;
 	wiphy->max_remain_on_channel_duration = 5000;
 	if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_PNO)) {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
index bf86e0ca941e..2b6f2a7a0a95 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
@@ -133,10 +133,12 @@ enum brcmf_profile_fwsup {
  *
  * @BRCMF_PROFILE_FWAUTH_NONE: no firmware authenticator
  * @BRCMF_PROFILE_FWAUTH_PSK: authenticator for WPA/WPA2-PSK
+ * @BRCMF_PROFILE_FWAUTH_PSK: authenticator for SAE
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

