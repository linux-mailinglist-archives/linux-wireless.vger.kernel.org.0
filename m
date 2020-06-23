Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9389C2053DA
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 15:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732711AbgFWNty (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 09:49:54 -0400
Received: from mail-dm6nam12on2120.outbound.protection.outlook.com ([40.107.243.120]:64448
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732633AbgFWNty (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 09:49:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXjoLQFhWkBGd/3qEUM5zuaUgtiCzQHArj64BaMoOPEVpWM/l3dbrY5KIvHe43z9IKmfdiEjju6x6szXofPAACHgVYJHezJpsbt4juUbCiQ9Q7HlC1crzc8R+v10kLQec05HzMcp7fQNkyCX5CoPSO5ccffiGJXaAI78klCUx8gBIe6xF4GgDm9AzYfb88evfDhFumZo7sot1x9VlCWULU5LpIl5uD1GI9B3+Bf7wOndbMY08JLUOK1ONypEd4z0pducaSvEIIN9Qne38XiVVBPkWY9CuKVR6NohPYNAMkOJ8BXipbTFH7P6gXs4f8chlNLoXhMSdBMDZ1FKfYsJGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdPopjI9R0M0Z3bUrewNAGHyONga6tbm7Am/xQIpzio=;
 b=LHc4Lfj3BE/Isgrkt/Mwc3fKf9ZkSnLGkMDPmgGN/j8THbhTUfO119UYU4yxTIM+3hVG6qGkGSDOwqqVwAbvMolMxHxWFx0/MgjY60RBhFuAJfeqm8YgYnVbQRAzWdKL9/tu+301ax3DSrBuCnFcxqzHdOFQN3Jppa2r31RaNRKyA2IXcw/Pv/Vp7H0/JxRu0dA+8b1QDUc2sMP91O3or0gIfGJCHi8HuBaprEknwuFcmgEzx2Ucb8l2nSmbMukokPpWLJFavvWbWfkVosnX7XgLUbLKmljGznkVgHyHSzMg5OtGzzXFMSPTh1m6QKXewAzVGVx1VeNO9d56ext7FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdPopjI9R0M0Z3bUrewNAGHyONga6tbm7Am/xQIpzio=;
 b=ABXk1V5xn/78WrRixTE6RHyYj1vE57KmKuc3KX6vKiuXkyWU85ZIyAoddvF1mkxmJIb72gT7sVtRzwb2pe1kBYMpImyMKo6CA8FWwE+MviROS2DuKRw22WnkXBKV+mf5lasnqyimJ+G2cWPHWAj572iAVzxw9QiBRrRptE6IlPg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5192.namprd06.prod.outlook.com (2603:10b6:a03:c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.24; Tue, 23 Jun
 2020 13:49:49 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 13:49:49 +0000
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
Subject: [PATCH 1/4] nl80211: support 4-way handshake offloading for WPA/WPA2-PSK in AP mode
Date:   Tue, 23 Jun 2020 08:49:35 -0500
Message-Id: <20200623134938.39997-2-chi-hsien.lin@cypress.com>
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
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:23a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 13:49:47 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 40747615-d8a4-4781-b95e-08d8177c4be1
X-MS-TrafficTypeDiagnostic: BYAPR06MB5192:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB51926F580F4F87E196A7A072BB940@BYAPR06MB5192.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rg4VH33IqrmRiwrDeAA84Fouvhgw6TOUQwxv8MYgdvfeL6G0TjM00BUVPFAlKPQk0Q5ti0EG9EUjBWc8dt2mK8o/QVpfqDg6uz9b0teYyVuse/MNzVS3wWP8i3a5HYmUm4XS+dziOJ9RZklvLZ13MXyI3nzk9Nrs/3A0Vr9S+YZIeIVMuUPbeUYf4BkcIfqNpM+ZYAf2xZs2P/1SkwFzYwGlHDmsUPJ1MqL5iBPB7MmYGmOzE8pTcWErMxa2WBBJhX4vrcOofyVQo/BJ6YGqwbvbjhoEg3A2J3I+PJ/aIO0uxUCeJpsi1p7I3rb+fzZr6iRovCPERUnBfNm0Py1WmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(8676002)(26005)(186003)(16526019)(66946007)(6486002)(5660300002)(66556008)(956004)(66476007)(36756003)(2616005)(107886003)(4326008)(6666004)(2906002)(54906003)(1076003)(7696005)(8936002)(6916009)(498600001)(86362001)(52116002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: M10GYR5cqScqjexOpWk4iV0T942ymn8ixkdnUD7q62VeUY0InkU+iwQObh86/9aWs6aCEKhBXUZDuJrOHc/Fjn9MrHZt2VL43L2KuqbNZ6x8d89P2klOvEqXthLjYXzzuJY4oulrn/pqAwVflWZ/CYOZHJZqEDXu8Yv3x90e6B9TELj6E/juNJzqNIbuepPzX/+F0vE7NqdWjFb+/DTZyG3kMSq9fTdD/p9ctZP2Woi7Q1SGFdGP6mtXo87xCtAjnv/Kh/bMVeDMTsXd9zJvQwEswkrKfluZ/h57zvR3Oz6O2TOicMESxS5ILsp5mclmlC3jmK2nG9z7ztnOjT+PW3Djr1KhXnoWBq110vX1y7FF8dMPLg3PT1A5N+IDtQCURbyaz8ACcUfEOdLCwuqGg4rWcCSWrlhkt4cd3iLwoVcx5agENQU+5lqE4DitboPOq7XSdu+6IETr1AoL2KoEcpcvWQbaegIflMe/mFtD1Lgu7/pCJkp7lLBWVIbUSwvV
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40747615-d8a4-4781-b95e-08d8177c4be1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 13:49:49.3790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4MHqWNcDmYVBvQ/UjAve0Wlm4wuI494uP33kgcYd8mNeg1t7on9FGSyaFp3L87f6lJPi8vR0/3lehIUz/rPmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5192
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chung-Hsien Hsu <stanley.hsu@cypress.com>

Let drivers advertise support for AP-mode WPA/WPA2-PSK 4-way handshake
offloading with a new NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK flag.

Extend use of NL80211_ATTR_PMK attribute indicating it might be passed
as part of NL80211_CMD_START_AP command, and contain the PSK (which is
the PMK, hence the name).

The driver is assumed to handle the 4-way handshake by itself in this
case, instead of relying on userspace.

Signed-off-by: Chung-Hsien Hsu <stanley.hsu@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 include/uapi/linux/nl80211.h | 41 ++++++++++++++++++++++++------------
 net/wireless/nl80211.c       |  4 +++-
 2 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c14666b75e57..f5bb69664b32 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -183,18 +183,27 @@
  *
  * By setting @NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_PSK flag drivers
  * can indicate they support offloading EAPOL handshakes for WPA/WPA2
- * preshared key authentication. In %NL80211_CMD_CONNECT the preshared
- * key should be specified using %NL80211_ATTR_PMK. Drivers supporting
- * this offload may reject the %NL80211_CMD_CONNECT when no preshared
- * key material is provided, for example when that driver does not
- * support setting the temporal keys through %CMD_NEW_KEY.
+ * preshared key authentication in station mode. In %NL80211_CMD_CONNECT
+ * the preshared key should be specified using %NL80211_ATTR_PMK. Drivers
+ * supporting this offload may reject the %NL80211_CMD_CONNECT when no
+ * preshared key material is provided, for example when that driver does
+ * not support setting the temporal keys through %NL80211_CMD_NEW_KEY.
  *
  * Similarly @NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_1X flag can be
  * set by drivers indicating offload support of the PTK/GTK EAPOL
- * handshakes during 802.1X authentication. In order to use the offload
- * the %NL80211_CMD_CONNECT should have %NL80211_ATTR_WANT_1X_4WAY_HS
- * attribute flag. Drivers supporting this offload may reject the
- * %NL80211_CMD_CONNECT when the attribute flag is not present.
+ * handshakes during 802.1X authentication in station mode. In order to
+ * use the offload the %NL80211_CMD_CONNECT should have
+ * %NL80211_ATTR_WANT_1X_4WAY_HS attribute flag. Drivers supporting this
+ * offload may reject the %NL80211_CMD_CONNECT when the attribute flag is
+ * not present.
+ *
+ * By setting @NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK flag drivers
+ * can indicate they support offloading EAPOL handshakes for WPA/WPA2
+ * preshared key authentication in AP mode. In %NL80211_CMD_START_AP
+ * the preshared key should be specified using %NL80211_ATTR_PMK. Drivers
+ * supporting this offload may reject the %NL80211_CMD_START_AP when no
+ * preshared key material is provided, for example when that driver does
+ * not support setting the temporal keys through %NL80211_CMD_NEW_KEY.
  *
  * For 802.1X the PMK or PMK-R0 are set by providing %NL80211_ATTR_PMK
  * using %NL80211_CMD_SET_PMK. For offloaded FT support also
@@ -2362,10 +2371,11 @@ enum nl80211_commands {
  *
  * @NL80211_ATTR_PMK: attribute for passing PMK key material. Used with
  *	%NL80211_CMD_SET_PMKSA for the PMKSA identified by %NL80211_ATTR_PMKID.
- *	For %NL80211_CMD_CONNECT it is used to provide PSK for offloading 4-way
- *	handshake for WPA/WPA2-PSK networks. For 802.1X authentication it is
- *	used with %NL80211_CMD_SET_PMK. For offloaded FT support this attribute
- *	specifies the PMK-R0 if NL80211_ATTR_PMKR0_NAME is included as well.
+ *	For %NL80211_CMD_CONNECT and %NL80211_CMD_START_AP it is used to provide
+ *	PSK for offloading 4-way handshake for WPA/WPA2-PSK networks. For 802.1X
+ *	authentication it is used with %NL80211_CMD_SET_PMK. For offloaded FT
+ *	support this attribute specifies the PMK-R0 if NL80211_ATTR_PMKR0_NAME
+ *	is included as well.
  *
  * @NL80211_ATTR_SCHED_SCAN_MULTI: flag attribute which user-space shall use to
  *	indicate that it supports multiple active scheduled scan requests.
@@ -5761,6 +5771,10 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_TX_STATUS: The driver
  *	can report tx status for control port over nl80211 tx operations.
  *
+ * @NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK: Device wants to do 4-way
+ *	handshake with PSK in AP mode (PSK is passed as part of the start AP
+ *	command).
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5816,6 +5830,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_BEACON_PROTECTION_CLIENT,
 	NL80211_EXT_FEATURE_SCAN_FREQ_KHZ,
 	NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_TX_STATUS,
+	NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 22c4d13e28cb..004c79338f31 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9407,7 +9407,9 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
 		if (nla_len(info->attrs[NL80211_ATTR_PMK]) != WLAN_PMK_LEN)
 			return -EINVAL;
 		if (!wiphy_ext_feature_isset(&rdev->wiphy,
-					     NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_PSK))
+					     NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_PSK) &&
+		    !wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK))
 			return -EINVAL;
 		settings->psk = nla_data(info->attrs[NL80211_ATTR_PMK]);
 	}
-- 
2.25.0

