Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14590245E17
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Aug 2020 09:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgHQHd6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Aug 2020 03:33:58 -0400
Received: from mail-eopbgr760113.outbound.protection.outlook.com ([40.107.76.113]:42094
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbgHQHdz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Aug 2020 03:33:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wj6CS49wTLrmL4cQjEF6z7XpV+2ygM7gPgttSpqpSQHZFAHWS+lP8mZ8qOm3uFgS3hX8gx3vfbPaujW75B6pyPQqId3QPtjk4l0mY1kZKea1To8p2UuFIvxQT3moGQQ6I1XQm8oYUjKuqjDqlt2pa/8Qdved9saBFcEygSL3s22giiqeumZN1KwQoz70bli4P1aKYARv/coAWZjIFphEOyNadi3Q9/IO3TT1I+UwlEk4LJUZU+AaNhcYwPwogptlVEz4uLRGDstTLd3ElbUhfJwacvCGtF+KDUSOYGuKKu32Slj88sCZvL60XN7CXivYCRiB61nkvqdVybsWd0bfJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nE7+EIvKtQUdWHgEKGCin5fXXWpzj+SUjUx4UfHmol0=;
 b=GFzXYRhu7u1dPe3Ws1GsLh+4cMAYmt9GLZ1zxfoNJP/3b/hxfjZ5bG1OLe/MgUAXLom7lVVj/rvGgPVbcVpKjBMaBfP5cE4jzfAYlXFucZ1D/ahkoGxv9/L4tQAI/5x9awsk/Pot5B3Zz1fGPspQhaKrs38TG9kgZC5l6EBwAVJCoINqEpCwP1zLBCAv6n/jUhWwRoQaFfBX9kH/xtZfFkS/lDL/bO5HQ43KNFLRaqof7YO6gDLqREyJBRRN7RkR0WAsPtgHG2cf60/XG5q2RF6uxUohQxJwJXyaNbiXYuI/VnaKIxROK55i0FkgGxA+1aV8vHEH0/yFtVTy5vm/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nE7+EIvKtQUdWHgEKGCin5fXXWpzj+SUjUx4UfHmol0=;
 b=oUUsX8nuWUVE6gQHRYGmemKqaTD6jrenyOcd7fqIflt5cwIIt2VmiPsIzNempSs3QOh4DPS3X2/cXpzorgJvXruOLJT/aaVgwp/KWS9bkfz9CTf8ZwgTdVxWuEp4sGLxWuWXGe1B0zcJ5qwbkevnbr8dAbgOojKY/tMJdN67ZbI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN6PR06MB3043.namprd06.prod.outlook.com (2603:10b6:404:5a::23)
 by BN6PR06MB3009.namprd06.prod.outlook.com (2603:10b6:404:57::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Mon, 17 Aug
 2020 07:33:43 +0000
Received: from BN6PR06MB3043.namprd06.prod.outlook.com
 ([fe80::4196:7f99:bc78:4e7e]) by BN6PR06MB3043.namprd06.prod.outlook.com
 ([fe80::4196:7f99:bc78:4e7e%12]) with mapi id 15.20.3283.020; Mon, 17 Aug
 2020 07:33:43 +0000
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
Subject: [PATCH v2 3/4] nl80211: support SAE authentication offload in AP mode
Date:   Mon, 17 Aug 2020 02:33:15 -0500
Message-Id: <20200817073316.33402-4-stanley.hsu@cypress.com>
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
Received: from aremote06.aus.cypress.com (157.95.12.33) by MN2PR15CA0023.namprd15.prod.outlook.com (2603:10b6:208:1b4::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Mon, 17 Aug 2020 07:33:41 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [157.95.12.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92df3236-7d73-4996-0036-08d8427fdde6
X-MS-TrafficTypeDiagnostic: BN6PR06MB3009:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR06MB3009BAD07846775DF8855526F05F0@BN6PR06MB3009.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pHgaffIL/UaqkhCUUnHhCQuyQ/eZj874iScDqEeab+xsZjkHrM1Afz8zPWFZPMLcEbyrWxLIa9QRKYWiIydUpKuFiidYnDsUVIS+xAwUHWWzqY1sSp3e0LzBA4CpH8q4lG/cssxR8uTUf0oJ2iyYPAtbBLUarQuwAfdxe2pGt6kc0+xelAo/Gj3ULBTMkhvoT8/zjNaDZjgQkhx+XYtIOVR34S6jK8SxcSm6V9e+GnR2n+w8nYprAGXPMUbMWwncwL6NrYBkSxEc+CpE0lq+5rluK9emvQGnahmUdxYnaHZz40TgrOiUadmJ5wtT82dcUWDZ/3hhOqeKQtwaQKx0Ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR06MB3043.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(66946007)(2906002)(66476007)(4326008)(16526019)(83380400001)(54906003)(66556008)(186003)(8676002)(1076003)(6916009)(5660300002)(316002)(8936002)(36756003)(6666004)(7696005)(52116002)(107886003)(478600001)(86362001)(2616005)(26005)(6486002)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 0DDb1o8crjXfMCrsRcBKg+X5yBv/VcUwbF53VaBcrPIW9S171pCdgXPZ8irEo1oPXm/OUCYID/WzOXlHGuB8OGslb5uKt5a9M2sBYt7KcW+jSMubSHLWpk1P+d3sW6KYMdT+tchStmBdtR3liYM+8T7Yitr1TwyorU9yWkH5Vnbsu3kNjUoG0/mtqPxbEIjwDgJ1pUaLjSOVRW7YJZXYG6fO+gAAHo/gSpatAyxhlqBciiuTd37km72Y6zMdfnCzrOUrzf5UciActL8bfMoHJYdI+Vuxdo/m/fbazrBUINIi6uVC4lYLBsK38MHK73MDhNk9SiIz66NWIf5/9FShFOjIGZAO7E1aXP2cbBUW3KWOk+KLItLsHLsyoQXKVQUd66d/ib5sCyPqPs71oc66PatErt6/S+ZYkLjJP8gqqQcwtVJ8Nryfd+zxe8PD9ThEX53Qq6YMJ4REQaGzvHUTvGuo2oO0EINRdyfmKJkbYEz9D9sLsnppKxZsUuyQ3SoCvq1kcmMA5s/W+xMokWvbIPrBvF0YcpJ/5OjvNG76/yU66CwIKXiNXZ/qli7UuQj0tqeoeeKaFKrUmIUKeC8fX1b3aj5VS5GUgM7cz/b0ZhnKbMSGe6JpyoJd+NMOr0Khf9TM26dOSkRasJ++ef8kFA==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92df3236-7d73-4996-0036-08d8427fdde6
X-MS-Exchange-CrossTenant-AuthSource: BN6PR06MB3043.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 07:33:43.0110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Mmo7fFLXntBN9s1uSVtwZdd9cPibco/mS9TqZGlV7SaUdYfdzvqOn5f2SPLowtfeol9NQLFukHZ4Og+Br1ZsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3009
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Let drivers advertise support for AP-mode SAE authentication offload
with a new NL80211_EXT_FEATURE_SAE_OFFLOAD_AP flag.

Signed-off-by: Chung-Hsien Hsu <stanley.hsu@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
Chances in v2:
  - use a new flag for SAE offload in AP mode.
---
 include/uapi/linux/nl80211.h | 14 +++++++++++---
 net/wireless/nl80211.c       |  9 ++++++---
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 0d267ac3858c..038205fe19c3 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -252,9 +252,13 @@
  * DOC: SAE authentication offload
  *
  * By setting @NL80211_EXT_FEATURE_SAE_OFFLOAD flag drivers can indicate they
- * support offloading SAE authentication for WPA3-Personal networks. In
- * %NL80211_CMD_CONNECT the password for SAE should be specified using
- * %NL80211_ATTR_SAE_PASSWORD.
+ * support offloading SAE authentication for WPA3-Personal networks in station
+ * mode. Similarly @NL80211_EXT_FEATURE_SAE_OFFLOAD_AP flag can be set by
+ * drivers indicating the offload support in AP mode.
+ *
+ * The password for SAE should be specified using %NL80211_ATTR_SAE_PASSWORD in
+ * %NL80211_CMD_CONNECT and %NL80211_CMD_START_AP for station and AP mode
+ * respectively.
  */
 
 /**
@@ -5787,6 +5791,9 @@ enum nl80211_feature_flags {
  *	handshake with PSK in AP mode (PSK is passed as part of the start AP
  *	command).
  *
+ * @NL80211_EXT_FEATURE_SAE_OFFLOAD_AP: Device wants to do SAE authentication
+ *	in AP mode (SAE password is passed as part of the start AP command).
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5843,6 +5850,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_SCAN_FREQ_KHZ,
 	NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_TX_STATUS,
 	NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK,
+	NL80211_EXT_FEATURE_SAE_OFFLOAD_AP,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8e7c6a022205..497f8ea231fd 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4831,8 +4831,9 @@ static bool nl80211_valid_auth_type(struct cfg80211_registered_device *rdev,
 			return false;
 		return true;
 	case NL80211_CMD_START_AP:
-		/* SAE not supported yet */
-		if (auth_type == NL80211_AUTHTYPE_SAE)
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_SAE_OFFLOAD_AP) &&
+		    auth_type == NL80211_AUTHTYPE_SAE)
 			return false;
 		/* FILS not supported yet */
 		if (auth_type == NL80211_AUTHTYPE_FILS_SK ||
@@ -9447,7 +9448,9 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
 
 	if (info->attrs[NL80211_ATTR_SAE_PASSWORD]) {
 		if (!wiphy_ext_feature_isset(&rdev->wiphy,
-					     NL80211_EXT_FEATURE_SAE_OFFLOAD))
+					     NL80211_EXT_FEATURE_SAE_OFFLOAD) &&
+		    !wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_SAE_OFFLOAD_AP))
 			return -EINVAL;
 		settings->sae_pwd =
 			nla_data(info->attrs[NL80211_ATTR_SAE_PASSWORD]);
-- 
2.25.0

