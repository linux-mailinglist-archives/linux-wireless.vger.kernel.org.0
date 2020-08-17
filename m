Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08063245E13
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Aug 2020 09:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgHQHdp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Aug 2020 03:33:45 -0400
Received: from mail-eopbgr760113.outbound.protection.outlook.com ([40.107.76.113]:42094
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727772AbgHQHdk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Aug 2020 03:33:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcZI7ZWFef2nEXL4jmmU9SB8gz02/P63YrGqPo+hKzGgYZBDvD/1MVyaS/WAsWaVjmR7mAH0OYFl/J/BRS11CaPC2VYHBqFEFe/j0WG4dHj/mQlacGULhyBmoBDS5Uv6KHTwAblio1e7Q28DlbtFuWHgSrxCzB+5eCeVz/RwFR8REGouUkyQO0saKanAQfnIT/axxGfkLpwyRTdSS3F3xziZ/loWF08MeGluLz6Kl/QQTCdfUr/FZhsiOCGTfWcUxQL+6wkAUrD2UNMNMhFGfzoZKd3CrNo+pOxaW/Tv68Suzow4zSC/iphkZMW1nPRZPPozi9y21g9rafcUzscMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8ee4sdvyBqT7GHvkto+o5x2P2mshBK5Km2+hujcD5g=;
 b=ZZUx9Bas8ObPqQp2Wo8ZIsncdOCJDRafDkZ6oQLnGnJu3s2HAGmGlJuK2SuRhlWXcwuXzi8jBeSG1dfAkjBi97SxgI5q6rJyqCYEJWMAfmbKh4KVfMUrzuzlystriKEbcZo5Xp4gUOUqVrdaONT6UNPOzgBV7biEPGVDOczns+Dzo6RQl2rJ3rQuTXp+uDivq1KcjzbqKK+3sGFQDE8JVG9BUdcaAfaU6CpUqiqDrJXaw6daK5GhYTz0QDMcc030Y7tNJhckcAWYAHhE4VNPBdqXSVorVUQoRb2ogQImnTbQgI+s5X2MmRKosKAL8QbnZsyAEq1XLzw+rxKRyoAfGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8ee4sdvyBqT7GHvkto+o5x2P2mshBK5Km2+hujcD5g=;
 b=OQH0Ou8uBpDay6m5yv/ho6TTQAFS5jBpKOzQWiPa7VjNmcIc/LbsiMpnRa6s5RHMLtGqglIq+MLaYOuchRiGgipspNHYWDprXDLKyquBRUv6UkWWiCKNnfgROz5Y28vEYH+9ZYV/Pvte+Z86ELqAYUDJvmg+vpxH5me1OZ7DvvU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN6PR06MB3043.namprd06.prod.outlook.com (2603:10b6:404:5a::23)
 by BN6PR06MB3009.namprd06.prod.outlook.com (2603:10b6:404:57::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Mon, 17 Aug
 2020 07:33:35 +0000
Received: from BN6PR06MB3043.namprd06.prod.outlook.com
 ([fe80::4196:7f99:bc78:4e7e]) by BN6PR06MB3043.namprd06.prod.outlook.com
 ([fe80::4196:7f99:bc78:4e7e%12]) with mapi id 15.20.3283.020; Mon, 17 Aug
 2020 07:33:35 +0000
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
Subject: [PATCH v2 1/4] nl80211: support 4-way handshake offloading for WPA/WPA2-PSK in AP mode
Date:   Mon, 17 Aug 2020 02:33:13 -0500
Message-Id: <20200817073316.33402-2-stanley.hsu@cypress.com>
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
Received: from aremote06.aus.cypress.com (157.95.12.33) by MN2PR15CA0023.namprd15.prod.outlook.com (2603:10b6:208:1b4::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Mon, 17 Aug 2020 07:33:33 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [157.95.12.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 782b4c8f-5de3-438b-e802-08d8427fd919
X-MS-TrafficTypeDiagnostic: BN6PR06MB3009:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR06MB3009119332E12813A0EE35BDF05F0@BN6PR06MB3009.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SDZsoZGGD22KROESAdNB/aSza2TrGGuK9bXxiRgzvCx0Xve7EJCt6W1jf6ozsJHYjvcvXSTwQllGYNCtsG+XOQAvnggmPTTn5LL2FkR6yaF7Wta5ITRzFdDCQqBJYzIOLNlB1oqZu8VEE7NXNxp3hROmizdmMRXzBRTzncANSrefLi5x5UbWsH+mXu2Vy3k+/Tv/eIfc6IfGqCg4x4m5IiWU/9lCk9J5J7ksPqON7r7gQALF1UvI1YGgUQix2Fys1QSAL8Rg6cso4FRM8vqiSSLY3BEnv00r85h13wyuY6Tb1vMeSV/DjT3JQ0MYY1Of
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR06MB3043.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(66946007)(2906002)(66476007)(4326008)(16526019)(83380400001)(54906003)(66556008)(186003)(8676002)(1076003)(6916009)(5660300002)(316002)(8936002)(36756003)(6666004)(7696005)(52116002)(107886003)(478600001)(86362001)(2616005)(26005)(6486002)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Br1j+v5kL8KmxfEniaiAio//otQrPxpEk3AOB9TPlg6KLlmhUz7i2fW9EBxeStpWMdROzX1KabYWp3J6om4Mg0765oNi9Bs7t8W1GjFNjLKt5QgaWvvyM4Hgodhp9I+k9HHYFctT758oLAVUaXqJ+vVGARTYnW2cl7xZs+8V5aYy7aLPWqAoCon3EQCeYHBYrgM/NgkCJWDLH24tRWlI+T1pwDj2POs5jd/rG8Qo5mKiws4CstuebW4p54qPMvj5LNW1Uw45MzobK2cVOF/NhDUYO9748KW9D2Nff5UQ2lgGU46Hp7tQwqfKvrGf9nOlrZTEjiaznxcg/O6kuMAFl9oqgofPGfmTeQ2KWRxSPm9jmeu9/5fu9BdBW2+NUW0dShzYS44kMR5yDlgcHfOFlQ9D1FuhaOOKKf1T84y6C7sSFNi7Cyi/eCM7SkNhUkLk17WD75Pdl1xrtWXc1PfuArTk0fHARyX6KqK0Sg0i6/4O7BlOK8YLitqOv3b3z79FI1aYrretK0SGusTMmrusASIM4iTNxxfq6sZxRxxjuJsCTigxWup2xie0I4AZd8p+7utTjmmVs6bDz0hPu80Dwg+MNl2x5pgGb3N8hvwD688B3WShecXOcM45FuBfNR95buRBvvwZW87HHHKmTsINKg==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782b4c8f-5de3-438b-e802-08d8427fd919
X-MS-Exchange-CrossTenant-AuthSource: BN6PR06MB3043.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 07:33:34.9805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qE83G4GlhLtH4S0xCjT2w8cX57uTXcKy8cyGi4d+w3o6A1iFK1f3Sa2aBFPomCDHTz0dY4uib11TuA+ij4WPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3009
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Let drivers advertise support for AP-mode WPA/WPA2-PSK 4-way handshake
offloading with a new NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK flag.

Extend use of NL80211_ATTR_PMK attribute indicating it might be passed
as part of NL80211_CMD_START_AP command, and contain the PSK (which is
the PMK, hence the name).

The driver is assumed to handle the 4-way handshake by itself in this
case, instead of relying on user space.

Signed-off-by: Chung-Hsien Hsu <stanley.hsu@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 include/uapi/linux/nl80211.h | 41 ++++++++++++++++++++++++------------
 net/wireless/nl80211.c       |  4 +++-
 2 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 4e6339ab1fce..0d267ac3858c 100644
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
@@ -5773,6 +5783,10 @@ enum nl80211_feature_flags {
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
@@ -5828,6 +5842,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_BEACON_PROTECTION_CLIENT,
 	NL80211_EXT_FEATURE_SCAN_FREQ_KHZ,
 	NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_TX_STATUS,
+	NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0e07fb8585fb..8e7c6a022205 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9438,7 +9438,9 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
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

