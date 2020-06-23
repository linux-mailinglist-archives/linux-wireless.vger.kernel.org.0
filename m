Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71992053DC
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 15:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732825AbgFWNt7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 09:49:59 -0400
Received: from mail-co1nam11on2132.outbound.protection.outlook.com ([40.107.220.132]:43488
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732821AbgFWNt6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 09:49:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nnjjq3SEUi4QkwNHkWiW9Eayel+beceNCFHAO1fMyW+QwdgJCdWePhf8PJFCMEw3ygpzeTh9gAfy8eqzm1hl7/UnS2ZFdOZFZoUiBNWF6bndtrYsNU3YA9VBBhkCNvzvmEFvaaG4CF31aO6pitvqFfpexx0arxi7txKOwIFmaRUWaWVFHIPzcTnF+9nFmTZU0z2hQGZt0dUE3obkH2c6Dg9W+12hvA3/tCUjTotP/jKw27aUjhhFcwExF7dDrQIC9vAvxFu8ZGjvt5KINCMDnovKF/LiOKmh+Hud9pHLciRn/pfPpk+PHKLcey96dAeENmiY2POx5yG61jEqRhAAdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTxac6cSBma+Nja5/YA5/m6EAJyBphR3P1b/2GFOfzo=;
 b=bzXSSacR9URwNgzQ/c/s5viB+2KdCazDD4bBae3tL4xXYxZ1l9kM66nEKUp4fIJY29a7FiGjVIdccoBO4lq4hVgwD7Aq/geTQfU3rx3GYFXN6mjQljoqu4lI3KuWxbSjUHZWgmX4DTSQ+8nKHIr3WbrYAReCc7fQ8ky2YXGmmpZybPtl7w6CtIEIIjGc4MItx5oJefHwDFbX3WdMhECJI4T68RJTlurDM9wBS+qvp5VII1+5pbxQx0QqehAscUfDFpUwj66brGmnjNb3QaNTLEDS9MR95QcF+nzgN3HN2RSp8PEtK3+XjC1lXXXC6jJIPjTI4luLq0uL7iHTs2TONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTxac6cSBma+Nja5/YA5/m6EAJyBphR3P1b/2GFOfzo=;
 b=Cs3jIQ+ZJ5Q0DZrEjmNwkaw2qLd3VwAvijQNZed24YlmlJoxr0NjIi4Vj5nz5/EvaZKqvjQ7JSrfsLjkbsCEebkEwxhG210kGD5srHd7TlBOKehW182jha1ivsM1UzcWgEcACRFiGM/Lokd7gxAn1WOlLDKdtJf6pvXwBmWUfCQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BY5PR06MB6449.namprd06.prod.outlook.com (2603:10b6:a03:23d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 13:49:53 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 13:49:53 +0000
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
Subject: [PATCH 3/4] nl80211: support SAE authentication offload in AP mode
Date:   Tue, 23 Jun 2020 08:49:37 -0500
Message-Id: <20200623134938.39997-4-chi-hsien.lin@cypress.com>
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
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:23a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 13:49:51 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eae66f25-8d4f-465a-00a9-08d8177c4e6a
X-MS-TrafficTypeDiagnostic: BY5PR06MB6449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR06MB644926B5EB9B92CFBB982AFEBB940@BY5PR06MB6449.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nLMCnKMoprnMpe9TAfJlpI5vNT38fMyFzXeuWk/NSKSgvZCMoknyFnvLZVIAKyEgd895n9PUaa3rmJ/jMURzIna3BG2ZL9GH+CxjFwKGJFfcMGv866vxM0lqsGYT1eVzjoe0z+6OpZIgwcfd6j+lzlKoXJ2eKk12IFie9oC4xd6cJc3YTXGJMIS+bbIxTGtZ4x580PxB7i+0UprgWyzKXGIY87n/zHp24WfkwDWJFNTB6NbAyRz/mk7O/ZxR0GYZtfknqyohswpoEmxCRmqYSc6qqG4pO3Y8Wzfzvkh1kkOumW2oh9L37YO/gNNdyuWw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(16526019)(186003)(26005)(6666004)(83380400001)(498600001)(66556008)(52116002)(66476007)(7696005)(66946007)(54906003)(2616005)(956004)(8936002)(6916009)(8676002)(4326008)(107886003)(2906002)(1076003)(86362001)(36756003)(6486002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ufvVQ6tOoeYOtMN1awU8R9ck/LYlGBPaPb7DTKYb4klnzS/bNi+7h8AhlmLISheamRFnuEwODE76TDBSOcxJgFRFOfq6YDU9EXWgJv5mUffTOM6jkSHc5K5GAWZUo+qOXUn+OtaYBcYAW0WLsRvXvXQLRBkomDbrDWuH1JE/rxrOIWsugjLXpCwbwfdE22IF3/pxLAzbRb2X1cV9qZ9duZT6CAl2lmfWYQYoKePP3IQb99W3tjFVYnM5AxTgSB7lrOwpZCP40i3DwnXJa4Inp4YHqNOVOsvcrrltxfwWgxO7OUDFl2+tPbkwsa+55HleeDy/H/gzTdxs+m0Te1qoRCwKmT5vN55NH23ssFuqqWe9+i4xx81Zdbl6UjyWk0Xau3dDYquwiTqqwjlQ3Hm9B8ipSISC4aayXT9PMiXPo4nhs/yMGY6dNH473Tcct/WOotlnmEQqgkckjydT5pEVuZWeOMcpg6r4U7srGCEgFPuC8lWN/Sqr4sBbyImu8gcT
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae66f25-8d4f-465a-00a9-08d8177c4e6a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 13:49:53.6026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bULX4p+ddJ04ZrW+cezdLT8o/sNzCY9mR3cNsKPPA21vxp3a50xGBs/6/Z29jCOrHsxXvKQKTr+AYiUyuTHQ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR06MB6449
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chung-Hsien Hsu <stanley.hsu@cypress.com>

Add support for SAE authentication offload in AP mode.

Signed-off-by: Chung-Hsien Hsu <stanley.hsu@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 include/uapi/linux/nl80211.h | 10 ++++++----
 net/wireless/nl80211.c       |  5 +++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f5bb69664b32..a340d88ee8a6 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -252,9 +252,10 @@
  * DOC: SAE authentication offload
  *
  * By setting @NL80211_EXT_FEATURE_SAE_OFFLOAD flag drivers can indicate they
- * support offloading SAE authentication for WPA3-Personal networks. In
- * %NL80211_CMD_CONNECT the password for SAE should be specified using
- * %NL80211_ATTR_SAE_PASSWORD.
+ * support offloading SAE authentication for WPA3-Personal networks. The
+ * password for SAE should be specified using %NL80211_ATTR_SAE_PASSWORD in
+ * %NL80211_CMD_CONNECT and %NL80211_CMD_START_AP for station and AP mode
+ * respectively.
  */
 
 /**
@@ -5736,7 +5737,8 @@ enum nl80211_feature_flags {
  *	to a station.
  *
  * @NL80211_EXT_FEATURE_SAE_OFFLOAD: Device wants to do SAE authentication in
- *	station mode (SAE password is passed as part of the connect command).
+ *	station mode (SAE password is passed as part of the connect command)
+ *	or AP mode (SAE password is passed as part of the start AP command).
  *
  * @NL80211_EXT_FEATURE_VLAN_OFFLOAD: The driver supports a single netdev
  *	with VLAN tagged frames and separate VLAN-specific netdevs added using
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 004c79338f31..bc4f066cf955 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4813,8 +4813,9 @@ static bool nl80211_valid_auth_type(struct cfg80211_registered_device *rdev,
 			return false;
 		return true;
 	case NL80211_CMD_START_AP:
-		/* SAE not supported yet */
-		if (auth_type == NL80211_AUTHTYPE_SAE)
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_SAE_OFFLOAD) &&
+		    auth_type == NL80211_AUTHTYPE_SAE)
 			return false;
 		/* FILS not supported yet */
 		if (auth_type == NL80211_AUTHTYPE_FILS_SK ||
-- 
2.25.0

