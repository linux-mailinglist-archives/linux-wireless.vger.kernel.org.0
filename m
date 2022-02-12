Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91AA4B36F1
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Feb 2022 19:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiBLSFD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Feb 2022 13:05:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiBLSFC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Feb 2022 13:05:02 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2101.outbound.protection.outlook.com [40.107.236.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972642FFE2
        for <linux-wireless@vger.kernel.org>; Sat, 12 Feb 2022 10:04:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E57EZh8onl6wirKzIkLKGEHpQUJ+mbcMu2rUOR9oeHXWYMtwx/w/09fEJxSY2KMve5hImS6XVp5iE1kKw66Zxd0L9Fevtpuzs8LbbVCwc1AiDP4sw64AVv7sFpcqFicwXry2VCvPaQJXOMfnDqJsXHk74eb0f1zvTpehhUpQqvKeOzc91LGsK13qDRfwV09ifodvQW+nzx8qdK0CgocnSyNt7uw7YJU59zF9hUVL2Be/G1NBw4S9Mpq4CS2eumEaNQY09OH3UAQckkjNrYJNfeTp/Q1+ppzqnAT2H4b294epoTjsRh0eaOMcpcuzo8dfeyejycnJI39+Elf/AgH0HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4vvXwEd8D8X6Unvuet9MM/gePNekHbHRQv963hRnP8=;
 b=ofBQDVFxxGB2UhQuhP+4rbJ33Z8lLvag8ITTScvvpkQngbnKkgkxouhYVrySJ1gagLo/HL2+uKGgTV+YACInjHtZCkiz6ivvcu/4Fpb0jjCOG5vom2Fn8+njle+poI2RBmhwj4XcWssRSsOWBsQZ/5hh6Jc7+JmmLMfGFPshOaoNKLiac1vYCIm4bSLa/McSKXGKcZsFhi5nCCu41UMxsfECopEA2EJAWrsMz3ITjBWfQf45HuU80hqFpkfWgLYRSY2BFW9HwzoUNY/Rx4wUP3Vf8+rnUuasAEZgA2E+jOihyPm3yXsU4DgrtRzmSJxKiVAnOZ7J94rQ0wsXcDkgzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ADTRAN.onmicrosoft.com; s=selector2-ADTRAN-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4vvXwEd8D8X6Unvuet9MM/gePNekHbHRQv963hRnP8=;
 b=XzTUMKgV7wrEH29q5Ca1WslLE5d8yjB8tGx1pwX+1SZ2g2Z1kU5T7sdaywUu1I0eye4CJw4urnKTQP9Ej7PU1iuEsHIDeS/l5kWTX9aybvh1Xzz8C5mT0wj0p/k8A3QUBnjN4rfyG7Nl4EzMNNfgu3WCYDpnkCFbRcW1UzLzgBb0lcXridZvXoCrpcfp7VHX1AXcFWRCoeOLlJ/XjRkE/9BdizTusYSrlsb0BGntZ0RNdNX0syXTOY9WYVI+vZYEqiYrpEV8/aE/Vh8oUEfLsXHrN02YBFm3stsX00OIVYvOd1LbXEE+KCwwIMyCOHnfWpvuCK0xEYRWl2mrFt6LCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=smartrg.com;
Received: from BY3PR19MB4915.namprd19.prod.outlook.com (2603:10b6:a03:362::19)
 by BYAPR19MB2918.namprd19.prod.outlook.com (2603:10b6:a03:b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Sat, 12 Feb
 2022 18:04:51 +0000
Received: from BY3PR19MB4915.namprd19.prod.outlook.com
 ([fe80::c4b6:39e6:4e2a:4206]) by BY3PR19MB4915.namprd19.prod.outlook.com
 ([fe80::c4b6:39e6:4e2a:4206%4]) with mapi id 15.20.4975.011; Sat, 12 Feb 2022
 18:04:50 +0000
From:   Chad Monroe <chad.monroe@smartrg.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chad Monroe <chad.monroe@smartrg.com>
Subject: [PATCH] mt76: connac: adjust wlan_idx size from u8 to u16
Date:   Sat, 12 Feb 2022 10:04:26 -0800
Message-Id: <a0644f7da6ba09195ee247a5affa562179328207.1644688718.git.chad.monroe@smartrg.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:a03:333::31) To BY3PR19MB4915.namprd19.prod.outlook.com
 (2603:10b6:a03:362::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f6b8644-ac5c-4de5-9f3d-08d9ee5229ac
X-MS-TrafficTypeDiagnostic: BYAPR19MB2918:EE_
X-Microsoft-Antispam-PRVS: <BYAPR19MB2918D50DF85E6953115B04ED8D319@BYAPR19MB2918.namprd19.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YGWuPdh7lNvxLzMXOqVgu6647lvzb4DpREXD5IQ2rOBrcR4SaDClnv5OwETHEvfuQktiCnFPDa97LSV+19rkApQP73Fqi7ihHG8dhVhcyXlHvKuDmtOaqR22YV8a860zOajzp/ENhodIEJNg5m0mDWL2yOs2E0qL1XiC2xg5xM93yL2NOFY6mjHmv7iw4RCuYVLVfvV59WuswwIrWPnnnDSmqpZHYf7m6uBvNT6NbQrHLqN94n4AIJ92JyNNG+48iFJE43DnrxIq+UvZJPjQJnpGtr33iEuKwOWLMeGfmorTY3p5fwadt2YUsmwKwBdk4LkxqPslC+RVNbPCqGQL3JK2C0fT8NrE+0zyJRQh+vHunmdoSz1U+ydQqqVGJIIqgj71WNVEQrqygp66OJALDvCsoqjOdE0B3Ez5hQ41/QpCpS+44S0bdjz2nuw+EDIVJ5hgA753zUZayunlyVhE9w+xet+aA8BieXWkRZ6m4v5KsDOKEqPa4gOl9COa8+moajE73i7A82QHY9rsYR7qv4H+b1wefvRRHAytH3jIUmsMrSs4bxKGuNZmCEGmjlqPg0dbV+FtIG7tbBLOWV7jWb4WGx3J+utVc118wkhwCaNSZLJjGugKz1OqRrOQcvXTYnVPUVwgRQq4pfc15KmrbHbw2c8GRb0qckVoWWjO3cLwnVfi1/XIXBDB51wCYGD9A82mqssn5aCffJz3/bI2fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR19MB4915.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(107886003)(66946007)(6512007)(42882007)(186003)(66556008)(8936002)(6666004)(2616005)(508600001)(83380400001)(8676002)(66476007)(2906002)(26005)(6506007)(38100700002)(5660300002)(38350700002)(6486002)(36756003)(316002)(52116002)(44832011)(83170400001)(54906003)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3tHpt8d/NLUZQ0cokYRH1gwAomCZ+FPmhLPWK7qFlqNDUbSMBfexERj7OGTp?=
 =?us-ascii?Q?GwOtP7NYpNHqFa9jUY8IIWxNx/BetFPq20S5Oxr1Mzy2yt08BNrYLzFfQves?=
 =?us-ascii?Q?7DEMy/spOpjw5PjcqzJf+g9jb72EXHBPWTU+93tWZFxkGwP56De1cnTlwUdz?=
 =?us-ascii?Q?gQiWSV7CenbbLyFitoVS1bQrQprp3KszKOHatKjP70O4YYgTbPBYHMlQ+6sR?=
 =?us-ascii?Q?gZXUMgo1AlkS2FvT5RZkimMhWVDIuMs12fyuGrz75tL/Yg8cBCa/esfnHp3Y?=
 =?us-ascii?Q?AVaUdEnOzefGlONPxmTLJUFe4tzExlPcATsMlT4k3r6u2E2vSi3kJys+OuvM?=
 =?us-ascii?Q?+HqCmnfDOUafH6YJ8RF0PIJXEpJZ5YkhcCpF5I+JAFGnkQas/SeJvHDdQ89g?=
 =?us-ascii?Q?Ra67U++jNZANH4im0NC2rai5Q7vTgKestCfH7t2Jm4Zr+ltOpDeVEG2eI4Fg?=
 =?us-ascii?Q?Z5KgMFGdK+gSxDAZ8WLle5bTlMKp1gx6FDcXXnMZ3Vvhm9m5Ik1uyms8WEpH?=
 =?us-ascii?Q?/y35xs6G9YvWhDBTpBSOMmfsQLHCXArFAdKX5qulFPOoqfG0wfIn1H0W7v3c?=
 =?us-ascii?Q?+J9nENAKj0agCutf+CSfLpHppnhBT/MEzJY8FNPaUrP18x0/CL6qun5hWsHv?=
 =?us-ascii?Q?Hlps6hQZGrxbbYQofcJXuaGL48XPRRQTRICej4oFmaPfPctkmbPN/E20FKPU?=
 =?us-ascii?Q?/cK2s8DE5IYlkxOo8SU385zfww8HJcRiH3yOR8EA0WyYaaxWX4j6AUWmH75n?=
 =?us-ascii?Q?OvcGOlct1arf6NvMzi9HJcteMtXJo1jIXv4yU0uGaTxDObUQVROqftwncY17?=
 =?us-ascii?Q?u6WlLIAnC7Dl+uOtGXrtSYqKHGVjxQ/dC9SIvDrgLU1uIi8AxTkTi2qR5v4I?=
 =?us-ascii?Q?ZiTmONNp67AO2CxfXDRfOJec7KOfvoqzf09t92h2yZIA6N5L0Tg1iDb+D4DE?=
 =?us-ascii?Q?MKbZBp3drr/Y+YC7TAusQbjYcnRQv/X6KX87s9yH46P1CKVfIPuq1GFuLKqy?=
 =?us-ascii?Q?UB2YO24u2bTsYtfiAyFScYUVIQFqyuERVrbA09ia6Clq6kc5DUTriF+4PaTn?=
 =?us-ascii?Q?vyIxc1PfjkJUuhzCsf7/gGFjDzEJ20fPkw6oU4hxG102qMR3r/9fbLNJHYC/?=
 =?us-ascii?Q?uU/KYrZx0InlFwLclpyiXUwYjws4Kj/T1IPzGMnE+JEmTmdKCxeE5b2z1AqT?=
 =?us-ascii?Q?f4u6B0H+MpKpEtdOrF/e7hOcV8gl54Nk53WHi1agDGXL/jCv4ucCj6kG7b5Q?=
 =?us-ascii?Q?PfHsfruI9TGrAOqRieu0um4T6D9LIqZTePmtKUFlsbuB6h2ktoR0O7Voss80?=
 =?us-ascii?Q?+T/8xch6DGpnOXePPP9HYN2iFQc2RPOFoYllc/ul0djGL5+1tHd5pTAWu8ZP?=
 =?us-ascii?Q?a5OhdDslXxJSrHoPgDt9K3UtUhMOX0hj7KTvf0UXTay15+JpMpcfCFUEZ4rg?=
 =?us-ascii?Q?L0TDy+KHeHn3LdVgJ4zArVNZd1vIj7EmyFh7xFlTeIYIkbwHmGRhyPusn9iJ?=
 =?us-ascii?Q?m9KBLYN0ZGkoHKnm0N7NcmKSV4n+qiM2v5UADry+7r2YGgeLb/XzVKhEqoXv?=
 =?us-ascii?Q?dFJJbz4yuG+zKP5dsxrOLr8ZUTXfqRyddZkjTu50zrz5OJijMvjFrUY8CRB3?=
 =?us-ascii?Q?jDjX4d6sOdECvsLHzZjHM88=3D?=
X-OriginatorOrg: smartrg.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6b8644-ac5c-4de5-9f3d-08d9ee5229ac
X-MS-Exchange-CrossTenant-AuthSource: BY3PR19MB4915.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2022 18:04:50.6980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRUNA6CG4DwYpaa/vmXiSaXYYSIN8pmoYX5iqMIpJIr8iyUV7W9I3Q5uw4OslB9T36S56gxcngvVtYuWEnJ5jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR19MB2918
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Newer chips such as MT7915 require up to 16-bits for this field.

Signed-off-by: Chad Monroe <chad.monroe@smartrg.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index cdd82a62eeb1..f3fdd755a3bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2656,7 +2656,7 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_bss_ext_tlv);
 int mt76_connac_mcu_bss_basic_tlv(struct sk_buff *skb,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_sta *sta,
-				  struct mt76_phy *phy, u8 wlan_idx,
+				  struct mt76_phy *phy, u16 wlan_idx,
 				  bool enable)
 {
 	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 7b9d82dd3f9d..384c3eab1c8a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1642,7 +1642,7 @@ void mt76_connac_mcu_bss_omac_tlv(struct sk_buff *skb,
 int mt76_connac_mcu_bss_basic_tlv(struct sk_buff *skb,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_sta *sta,
-				  struct mt76_phy *phy, u8 wlan_idx,
+				  struct mt76_phy *phy, u16 wlan_idx,
 				  bool enable);
 void mt76_connac_mcu_sta_uapsd(struct sk_buff *skb, struct ieee80211_vif *vif,
 			       struct ieee80211_sta *sta);
-- 
2.32.0 (Apple Git-132)

