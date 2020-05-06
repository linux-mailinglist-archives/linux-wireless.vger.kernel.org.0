Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFC01C7159
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 15:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgEFNFg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 09:05:36 -0400
Received: from mail-eopbgr680108.outbound.protection.outlook.com ([40.107.68.108]:38088
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728286AbgEFNFg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 09:05:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITwQmQ3QK1GVGF7YfKumLwLPC6QYxZOtS3Kj8Kd73i38Rmua/U6gT2m441/zVW2nkGFbuHjReZ9oxU8hHzIJfjTA/Ujy+rf9Ur/egY3UBWmG6+XZxrnhY8zaJd7EPNCZOshEuBIB0+jqPBb0oscQN4ZlbTacGS0MDN3uBsM8EZPMYIw8sj7CJWysxx0TjRw7RDQ8I2xX/9PRB51mqv1GD6u43Lagn4ii4DRrG2/ENJJztysDYpJItTlYzgAyk3lBVvNDVvMOdzs4B0B1WA7ozEXC4ruCnM7SN8HS21RVbh5muOisNtpSdWlLmaYQa/ZS6qRH3s4uWbqbf2GSD5O0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcPjWMyEWyOYUs1aTTPXH4WWm0hPBdkvJXteFmI4fDo=;
 b=TjoSTJcdt3s/4qGgptn4vw46bL50/Br71JGFntUESFZqlYS7LFB528hIoROdjBOG1jdLzIX16VQpLQ9Gw9vORh5SWHHwKdypF8CDXFB8dWcEGhIws576rAmnrB8rpqNo++3eJ4v8tJ7XXFbrZpFpL+5unskrMtOP5YBMJS/sGNWV6SaFmSqiBMOnwvhwOaW5knlI0gDJQn5Qta3L21RPND5mBxUw/adJXGqUty49cl2vpVuOOjdvKAprsUI9E8UHSsawMxbT7RdI2ZH2vHiff0VHIzQun6O242yq1U/i3m7MFRzQrMirvS/I51W5ARTVFUkNTsO9C9g482DUY0gBgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcPjWMyEWyOYUs1aTTPXH4WWm0hPBdkvJXteFmI4fDo=;
 b=NU6sY9SNrOEfkW5PlVgQ/1eB7a36NcgNxH2kXweTMXao8IzcK9G6lc6CCYhO5C1IMm+WahpnCh18blDiDXfpo5VLmOH6COPimK4ZbPB2zcrqJKZOLGR6fsiUTGSOkAucJ1R1QPehjfhipzyMHGhK++7qgHzTI9E9qGq/M02tnac=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB3994.namprd06.prod.outlook.com (2603:10b6:5:87::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19; Wed, 6 May 2020 13:05:33 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::85fb:1c0e:ce17:e7bb]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::85fb:1c0e:ce17:e7bb%7]) with mapi id 15.20.2979.028; Wed, 6 May 2020
 13:05:33 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com,
        Jia-Shyr Chuang <joseph.chuang@cypress.com>
Subject: [PATCH 1/3] brcmfmac: set security after reiniting interface
Date:   Wed,  6 May 2020 08:03:19 -0500
Message-Id: <1588770201-54361-2-git-send-email-wright.feng@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1588770201-54361-1-git-send-email-wright.feng@cypress.com>
References: <1588770201-54361-1-git-send-email-wright.feng@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:254::27) To DM6PR06MB4748.namprd06.prod.outlook.com
 (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BY3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:a03:254::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.18 via Frontend Transport; Wed, 6 May 2020 13:05:32 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 269b1c5a-a9e9-48c1-1e08-08d7f1be2905
X-MS-TrafficTypeDiagnostic: DM6PR06MB3994:|DM6PR06MB3994:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB3994E3E921A10BCBBA926071FBA40@DM6PR06MB3994.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KPgcNl/65hzqf/jAguEmXOxiTB7hiYoXee7rdxyvCE38dYlhZ+1a7lQIKIp3HyoF0S1/Wh8mbP1jNRcCoIMf1vOEu/wFFckH0T93WXHrjlkUtLO5iOY8GmPKihCjtRfsUpdbbhpb0zoefXe5XQA2MfZmzhuiOjzwzyZ8VS2NMs7JIHiuz/E5pRXZRAYaVnuwSd+ZaUSjRVSPTOT2a5ElwabXnYeFsvhjmq/Ma53D3J4NmIDoO2oGsIO2doehifmNBNcydrIw9edm/PZYOLdGmeDVYpMaGy6JOUXknFhaE6zsDPv1O5PzS/irzfK/1nqr0UgOhFywU23ua9HURtdSnAE7mo6LJ1ugoV0cYkrFXEReleR0n18MFWbU7/aAt3TblfmvfExqFs6C6ToLvYrxuOp3vK4hbgXo9jrXejXeWFFTA24E5eJQffUuUGuyGV+VX9+c30Omwq2uBT6pcWISXXX7Brjf5BubobwskVp6eROQwZ5u9jALGKO6yAnJ85gR+tB0Sx+oAaqUUNsDnKJG4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4748.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(376002)(366004)(346002)(136003)(396003)(33430700001)(15650500001)(86362001)(6666004)(107886003)(2906002)(33440700001)(52116002)(7696005)(4326008)(66476007)(5660300002)(54906003)(2616005)(66556008)(26005)(186003)(44832011)(66946007)(956004)(36756003)(6486002)(316002)(478600001)(8936002)(8676002)(16526019)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: BZGuZW3PGu44W+oerz9VBrBcGw9OgbPErEJ8jrklsmwKtVdwEWJZdTBA41QKcujeV4zZr207hTK/q42/KZ+jNFuuQo9MzmuOD2pKY6fPz9HRR60ZunP1lN677uD3QG3yrrW27vuW32568HSP4SMJVVydXAfSRv/DlQ4A2ndItlk6wJrd6USEv2jIXveXITp6uw5kskx6VEVEyUe3DOaLPRqZTku6gnlvp21VDbbWmh2zUWEqOhBWKCWL1WWRKDZy5+TYy6uh6Y92gBOmbV4pGzODnS9pBscvHCkmGVta9uYG7503ty4lOjl2TspYRWRyNW7mNsjfvJvWlZOu0Gz2g9nE1Avajwfw8wFtRW+Zyi30L2tTHEc6r8/lW64ZECwH5sLpZzEX/S7xUyAOmMpWEUAPBwEqT+XdbNQS7oHCrp3rM2HaMTjTo6hqvM/zk/mnPSV1pT9c7uN/X+JQGde30yyuDBl+aRv5j47VA4dM1BgJ0T8AwKUXODnTsil7T0ZbVZRK0Q8bfzXoJVl0JzrriHegV8OykTakATatW5kNhh2Q7SH4fK4DeVLXqnXZ4cCL72gNquftYUWrIViCLP1Be7/UDW8lBFVST7hPZbBdnQGt3jvVpGdO7J/YCWX/aZ+X6vdVc48l5bcmz6PGdAA5U9J5BLoTkTCouK1yruvti8dPAhoA8OkbPQSmLNI7amcxJC6hFhWrGL5SnOjj1BinuKmeSsVeeGXXpFbXMFBVaFN0SpUrk1CQQXW/iCUtpG8uYKRD3kDqQY2CqowDbifVCrN9FXwHOlvCVaCwW3nSK4Y=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 269b1c5a-a9e9-48c1-1e08-08d7f1be2905
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 13:05:33.4723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hIu4potdv553I2Z6fxzMOh9dNwlGmM6v0es/OBYEl8JvdwmbPHSwJwG62jbAmRBEEivHXj8vIRNs6qg4v7gRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB3994
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Jia-Shyr Chuang <joseph.chuang@cypress.com>

Host driver parses and sets security params into FW passed by
supplicant. This has to be done after reiniting interface in the
firmware.

Signed-off-by: Jia-Shyr Chuang <joseph.chuang@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Wright Feng <wright.feng@cypress.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 90 ++++++++++++++--------
 1 file changed, 58 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index fa84647..4c86ed2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -4599,6 +4599,48 @@ brcmf_config_ap_mgmt_ie(struct brcmf_cfg80211_vif *vif,
 }
 
 static s32
+brcmf_parse_configure_security(struct brcmf_if *ifp,
+			       struct cfg80211_ap_settings *settings,
+			       enum nl80211_iftype dev_role)
+{
+	const struct brcmf_tlv *rsn_ie;
+	const struct brcmf_vs_tlv *wpa_ie;
+	s32 err = 0;
+
+	/* find the RSN_IE */
+	rsn_ie = brcmf_parse_tlvs((u8 *)settings->beacon.tail,
+				  settings->beacon.tail_len, WLAN_EID_RSN);
+
+	/* find the WPA_IE */
+	wpa_ie = brcmf_find_wpaie((u8 *)settings->beacon.tail,
+				  settings->beacon.tail_len);
+
+	if (wpa_ie || rsn_ie) {
+		brcmf_dbg(TRACE, "WPA(2) IE is found\n");
+		if (wpa_ie) {
+			/* WPA IE */
+			err = brcmf_configure_wpaie(ifp, wpa_ie, false);
+			if (err < 0)
+				return err;
+		} else {
+			struct brcmf_vs_tlv *tmp_ie;
+
+			tmp_ie = (struct brcmf_vs_tlv *)rsn_ie;
+
+			/* RSN IE */
+			err = brcmf_configure_wpaie(ifp, tmp_ie, true);
+			if (err < 0)
+				return err;
+		}
+	} else {
+		brcmf_dbg(TRACE, "No WPA(2) IEs found\n");
+		brcmf_configure_opensecurity(ifp);
+	}
+
+	return err;
+}
+
+static s32
 brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 			struct cfg80211_ap_settings *settings)
 {
@@ -4610,8 +4652,6 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 	const struct brcmf_tlv *country_ie;
 	struct brcmf_ssid_le ssid_le;
 	s32 err = -EPERM;
-	const struct brcmf_tlv *rsn_ie;
-	const struct brcmf_vs_tlv *wpa_ie;
 	struct brcmf_join_params join_params;
 	enum nl80211_iftype dev_role;
 	struct brcmf_fil_bss_enable_le bss_enable;
@@ -4665,36 +4705,6 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 		brcmf_configure_arp_nd_offload(ifp, false);
 	}
 
-	/* find the RSN_IE */
-	rsn_ie = brcmf_parse_tlvs((u8 *)settings->beacon.tail,
-				  settings->beacon.tail_len, WLAN_EID_RSN);
-
-	/* find the WPA_IE */
-	wpa_ie = brcmf_find_wpaie((u8 *)settings->beacon.tail,
-				  settings->beacon.tail_len);
-
-	if ((wpa_ie != NULL || rsn_ie != NULL)) {
-		brcmf_dbg(TRACE, "WPA(2) IE is found\n");
-		if (wpa_ie != NULL) {
-			/* WPA IE */
-			err = brcmf_configure_wpaie(ifp, wpa_ie, false);
-			if (err < 0)
-				goto exit;
-		} else {
-			struct brcmf_vs_tlv *tmp_ie;
-
-			tmp_ie = (struct brcmf_vs_tlv *)rsn_ie;
-
-			/* RSN IE */
-			err = brcmf_configure_wpaie(ifp, tmp_ie, true);
-			if (err < 0)
-				goto exit;
-		}
-	} else {
-		brcmf_dbg(TRACE, "No WPA(2) IEs found\n");
-		brcmf_configure_opensecurity(ifp);
-	}
-
 	/* Parameters shared by all radio interfaces */
 	if (!mbss) {
 		if ((supports_11d) && (is_11d != ifp->vif->is_11d)) {
@@ -4775,6 +4785,14 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 			bphy_err(drvr, "BRCMF_C_UP error (%d)\n", err);
 			goto exit;
 		}
+
+		err = brcmf_parse_configure_security(ifp, settings,
+						     NL80211_IFTYPE_AP);
+		if (err < 0) {
+			bphy_err(drvr, "brcmf_parse_configure_security error\n");
+			goto exit;
+		}
+
 		/* On DOWN the firmware removes the WEP keys, reconfigure
 		 * them if they were set.
 		 */
@@ -4807,6 +4825,14 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 				 chanspec, err);
 			goto exit;
 		}
+
+		err = brcmf_parse_configure_security(ifp, settings,
+						     NL80211_IFTYPE_P2P_GO);
+		if (err < 0) {
+			brcmf_err("brcmf_parse_configure_security error\n");
+			goto exit;
+		}
+
 		err = brcmf_fil_bsscfg_data_set(ifp, "ssid", &ssid_le,
 						sizeof(ssid_le));
 		if (err < 0) {
-- 
2.1.0

