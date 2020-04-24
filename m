Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F45A1B7318
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 13:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgDXLaY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 07:30:24 -0400
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:49918 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726698AbgDXLaY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 07:30:24 -0400
Received: from pps.filterd (m0048106.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03OBQAOI032281;
        Fri, 24 Apr 2020 05:30:20 -0600
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2058.outbound.protection.outlook.com [104.47.37.58])
        by mx0a-00183b01.pphosted.com with ESMTP id 30fvd7224q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 05:30:20 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7bTKHBv/MM9bMUukT6GymytWJxFyODWNMsFQsJHGrBMilUxggntrI0SbHtdi5bVX4w/9bHz6nmyxw/IEM4OhkeOZj10gkXJpXu7sN0YUKI0yLRe8/bZMGyz8uExPrhV61F3+D8bba1UszWx6aVR6pH3Tf8rRR3twYsotPRriuWqv4nuSWYIqW9vxhduRT64+/prFLG2hDUjLHJxn9AWu/DXbxuiiTiSfp6Lg1qSN9GMHqvBs18w7P2whoCVDDQPCy4vo4DOn6U6ijigozrkt29j18ltw+ymxxy3Tu1t1YX00gdUGRRFzDUG8hIRUO+RQIBHyw1diPzoFdTIpiva6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wf3Y1vQNn+fJww7TC0rZqad9jFHn3A3G3Tu66cdOzzk=;
 b=bKyw1gaWnHwilcshyFzRDvxks3EgukbbXr+z7Lr5GZpOqkc2Xa/rpYWqF/NbKl7lY21H7QZ2cugOlXi+OE/o/29YAylFgC8tQPz7yn5pf1aoA7bcpN0tTedzSdoPTGY1FAcOrEDu5U/OQ3DRbFYf8Hm9EKo0KS9AUaccL3jibLcyAPXPOtZePxCq1EqaZVLomet4YGq45xeRaed1kOmXOxV8ETJWu4daM1kXBh5CEeEwgM94EzwERbBFu+FCyVKHZaQDbPJK0Z+GFqPeZEycRFOuyAB3nNyns81AZOsA6JqJbiH/0VXU7lMOnCa6oqEBkpxYu9Opo/9w+266h1c3eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wf3Y1vQNn+fJww7TC0rZqad9jFHn3A3G3Tu66cdOzzk=;
 b=fV2WlKxa/WKB0vPDGiWz9W4QWsySTVGu8UH38a15hWYBVPHJK4rGNe7Iw/RY16i8JZPwUqmIBcfUU/qaYnSGpl66gTkkVInRlET3RUSRatTTZghIv2ZlpR8Y/aUu9Gnr5VWz3Igai7QkA4GFfTxMHlKpK9lP/EujRaM9HpX7KDg=
Received: from SN6PR05MB5519.namprd05.prod.outlook.com (2603:10b6:805:c7::26)
 by SN6PR05MB4813.namprd05.prod.outlook.com (2603:10b6:805:9e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.11; Fri, 24 Apr
 2020 11:30:18 +0000
Received: from SN6PR05MB5519.namprd05.prod.outlook.com
 ([fe80::d16f:9f91:9f9d:11b6]) by SN6PR05MB5519.namprd05.prod.outlook.com
 ([fe80::d16f:9f91:9f9d:11b6%3]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 11:30:18 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com (2603:10b6:910:53::39)
 by CY4PR05MB3160.namprd05.prod.outlook.com (2603:10b6:903:f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.11; Fri, 24 Apr
 2020 11:29:20 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048]) by CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048%6]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 11:29:20 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     linux-wireless@vger.kernel.org
CC:     Tamizh Chelvam <tamizhr@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [RFC PATCH v2 4/5] nl80211: simplify peer specific TID configuration
Date:   Fri, 24 Apr 2020 14:29:04 +0300
Message-ID: <20200424112905.26770-5-sergey.matyukevich.os@quantenna.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200424112905.26770-1-sergey.matyukevich.os@quantenna.com>
References: <20200424112905.26770-1-sergey.matyukevich.os@quantenna.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0087.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::28) To CY4PR05MB3558.namprd05.prod.outlook.com
 (2603:10b6:910:53::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bars.quantenna.com (195.182.157.78) by AM0PR01CA0087.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 11:29:18 +0000
X-Mailer: git-send-email 2.11.0
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99701b80-15ab-48da-8501-08d7e842baf6
X-MS-TrafficTypeDiagnostic: CY4PR05MB3160:|SN6PR05MB4813:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR05MB3160DD43EC19C98B480E70B7A3D00@CY4PR05MB3160.namprd05.prod.outlook.com>
X-Moderation-Data: 4/24/2020 11:30:16 AM
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR05MB5519.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(39850400004)(136003)(366004)(346002)(4326008)(6916009)(66556008)(26005)(6666004)(66476007)(186003)(66946007)(6486002)(16526019)(103116003)(86362001)(1076003)(107886003)(81156014)(8936002)(8676002)(7696005)(52116002)(54906003)(36756003)(2616005)(478600001)(956004)(2906002)(316002)(5660300002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LPBi7/N52utuJxTHJlGGbgXvEbNJJX2GIPRryHToTu51uOUsDbJG7b32oxAeVhuqyD3vIaDnCrr6wjo/RZLO6/rngau7whVhNdivm+Xhblwu9+Da/5e/hf7KaE3QE7C4bPdh98trwXxj17A/sO1FBRprhDNzWSvpB8beTOcEYsMZOhyLng9bA4EaQBOUMZbnlXnKs1Pe9bma4zLU6YreW6jSd6NYi+uvv60bu6iSA//9pmUvvfnzqk+ovPHyWlNCIyLCeN6PcnCiNHFHyGS6Mwfq6YJ36WagQTo7pMsoaKQD2vH2nmyVgYHCOeCDPrxkUHDc89l/zenPmYEHNJ73XgapBxnvq64gQ0erGxCQjH6J0czFEFuAWSlGYE87WsbNZ7vLRnpaRn2ePr88O1FmhgvrrvYrVWUqXxRCnaq7keww5thWTC6zWhTAWxTRx06b
X-MS-Exchange-AntiSpam-MessageData: y9Rg66k8qRdi6m+DckGS8DCd3YnqNkPSHDCEu3oZ2DiHu9X5UsShI/0FgLk7ltvZOkwxZ1L9ZgBQPDVZyEx+lA7IUvY1E1pitPxFMw+TSchnx/CnvBKFRHNLQ7+Kg8hg7Wkga+NCZZqwNAXLcZC3OA==
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99701b80-15ab-48da-8501-08d7e842baf6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuqpx2gk1swiPjdLjhjWPAoaR4D3h1elASWlMh0pC5rSxhLOQWwz/NZNAoOmXItDOIfvI0+mbCfA/ZIB/Ky7Y2aWzHlSKMjNkHGb3+iJMdECucdUkNKMy4qsO8aIcI4PuoUGFRviW/akcJkNNM7zUpRkGjec+GHwwoIpAQvhOUIk2GYxKgw7FexHvirhR5eyHZE0tHimzA5egqw4PsQPHQ==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 11:30:18.6481
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4813
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_04:2020-04-23,2020-04-24 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Current rule for applying TID configuration for specific peer looks overly
complicated. No need to reject new TID configuration when override flag is
specified. Another call with the same TID configuration, but without
override flag, allows to apply new configuration anyway.

Use the same approach as for the 'all peers' case: if override flag is
specified, then reset existing TID configuration and immediately
apply a new one.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 include/uapi/linux/nl80211.h | 10 ++++------
 net/wireless/nl80211.c       |  5 +----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 1ccb0bf657ec..d1b1d9e49887 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4823,12 +4823,10 @@ enum nl80211_tid_config {
  *	(%NL80211_TID_CONFIG_ATTR_TIDS, %NL80211_TID_CONFIG_ATTR_OVERRIDE).
  * @NL80211_TID_CONFIG_ATTR_PEER_SUPP: same as the previous per-vif one, but
  *	per peer instead.
- * @NL80211_TID_CONFIG_ATTR_OVERRIDE: flag attribue, if no peer
- *	is selected, if set indicates that the new configuration overrides
- *	all previous peer configurations, otherwise previous peer specific
- *	configurations should be left untouched. If peer is selected then
- *	it will reset particular TID configuration of that peer and it will
- *	not accept other TID config attributes along with peer.
+ * @NL80211_TID_CONFIG_ATTR_OVERRIDE: flag attribue, if set indicates
+ *	that the new configuration overrides all previous peer
+ *	configurations, otherwise previous peer specific configurations
+ *	should be left untouched.
  * @NL80211_TID_CONFIG_ATTR_TIDS: a bitmask value of TIDs (bit 0 to 7)
  *	Its type is u16.
  * @NL80211_TID_CONFIG_ATTR_NOACK: Configure ack policy for the TID.
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index aef0dd59dd4f..31c61e8739d9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -14083,10 +14083,7 @@ static int parse_tid_conf(struct cfg80211_registered_device *rdev,
 		if (rdev->ops->reset_tid_config) {
 			err = rdev_reset_tid_config(rdev, dev, peer,
 						    tid_conf->tids);
-			/* If peer is there no other configuration will be
-			 * allowed
-			 */
-			if (err || peer)
+			if (err)
 				return err;
 		} else {
 			return -EINVAL;
-- 
2.11.0

