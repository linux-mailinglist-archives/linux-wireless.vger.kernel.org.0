Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B963625082
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Nov 2022 03:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbiKKCgI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 21:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbiKKCfh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 21:35:37 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2071.outbound.protection.outlook.com [40.107.215.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A3B6869F
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 18:34:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcdKgLnyqNTAWtdmrEcrqA5X7W0bx9E931TbJ0f93TTbyV+nHs0WH4yRu0YxXl1MK0D022sxhWfFB6rP0rGAE4H8InZLLpIDARxnEJMKxmFo0vU+sOv3W6+4rw2OryIU2wzaRYVpsr4x07pbxib9yWKaW+FvzjmnlpgO5gZGvfjtooBU9xYxpUvTlysFt5LF6zT8K2VEqC/zV4pQhtd3C78LO4i9E6WU9CLCPZIjRzAsPAa01FnNN9iO58RNbWHNKj0ZcXhOHtuwksL3JTahgj+ZgQDmT8rRERksJWofn5dUUsgHdpufouyOw++o2LZr+rmwGoOEPJxrOVQP1at1EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RkqvBJSvoYI/rYnkVpB9xRAdxlPbvdR2wtQdrKsR6k=;
 b=bbrtPn84bgmMkPxA23m62hIJjh0ShxzYLfgy8dtGAk4lFr40KubilvpGsQ7h3Pn3jyWAY0AQYHxjWwfVPaNDAgLwfsCUp2ozZdgOcKhWadgRDOF0SoHGEGLguI5IsaQ4WFupEEEovxACK9UhbY/2s2KDlBNMf25QB80RJeSFiwlJWTp1H60c8qQ5HjuZGyjR1NtNvYKXVk5OUR2LlA0ORa6npf7xl1SZ9tpl3RHAnnyfwXE75si1fTrHEyzGKFJ/Wc98eULJ9+/9+h71M9KaWxyW7/bkuXv/G4du7QZpWfmJgAbJR54ldHTOTJVNgR0hJDomcYLqeJ8RbLinua/ySA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=newratek.com; dmarc=pass action=none header.from=newratek.com;
 dkim=pass header.d=newratek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=newratek.onmicrosoft.com; s=selector1-newratek-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RkqvBJSvoYI/rYnkVpB9xRAdxlPbvdR2wtQdrKsR6k=;
 b=nTqnplfn7aACCj5k8xilw2nILvupA9KQACpF9FKyTx0R5VLJvIXQ1WqUxItYfM3IrHfjhwOZs8D/fLjPzyIKdsx73wyXD0Fh2RWbbkruJ0d1LU84/nq+IVUdMxBt4g+u3cjCekIf7NOlW7hdmjcEG/c9v2KYd9TzcnCefD/Fv3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=newratek.com;
Received: from SL2PR01MB3291.apcprd01.prod.exchangelabs.com
 (2603:1096:100:58::18) by SEYPR01MB5361.apcprd01.prod.exchangelabs.com
 (2603:1096:101:c6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Fri, 11 Nov
 2022 02:34:30 +0000
Received: from SL2PR01MB3291.apcprd01.prod.exchangelabs.com
 ([fe80::81c0:36df:75d:2043]) by SL2PR01MB3291.apcprd01.prod.exchangelabs.com
 ([fe80::81c0:36df:75d:2043%6]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 02:34:30 +0000
From:   JUN-KYU SHIN <jk.shin@newratek.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, JUN-KYU SHIN <jk.shin@newratek.com>
Subject: [PATCH] wifi: cfg80211: Classification of BSS with different frequencies in the S1G Band.
Date:   Fri, 11 Nov 2022 11:33:04 +0900
Message-Id: <20221111023301.6395-1-jk.shin@newratek.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To SL2PR01MB3291.apcprd01.prod.exchangelabs.com
 (2603:1096:100:58::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2PR01MB3291:EE_|SEYPR01MB5361:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae2c5d0-e798-42c0-d9f4-08dac38d4246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jteT236ihPcaZRWMRLQtdL9umYZDBlVNpzArT9Z1QTZUGxMswO3+gm9Es1NpSgzv4oDpgBmd4IBW0SAEF7Zcdy6gJpFYB1er3IMwkwkdlI+vza7uUTwQFFlmiJZv3Z9gkdYR2cEETw6KwAB4sIukr22I9YNPSJW0GEDI/sCxxeB+BoclsBZMVde84UEsFQdStRld0atl1Cqju4UF1Sc1bLWWTQiFSgt7wIFsVI438op2g78hI6KtlHya8Uc1wKtqB7rG4rBlVnS3CHQl4SfYNfAPWPvPn06m7aTVvkVxI85LQWaaA2Vlndvc3r5NDBhhoQyfKWGyHn/FNRp807fv5mp70yjsGXPPv2WPcGT65jRGbUnOaiKbmf7e5VtYE67EqlSUdQ5uwO4tDE8ujpfLizTGBHhfDWd+54I6xz+OrelHUmh5806VrM0G8E1VBqZRoW0Ez8OM7M/T/4TTY+z8jJ0fDFoyQP+79cWsjtOBGhCV8wX/R1KKLBix6ARrjsj9UAdC8kX2hJeKeiDfKJCs9AyJUS2N+FQ+t2E5zDB/3u5pJ8PLnoJMLPAbs0eET1/Ug1cmMR4csGSIF0pF+ZVikrZoJXZO1UkzkyDcf5RP5FpsHR452MCva6dKfqd75SUt0kDiNi0kBdjPkbyjyVbDKGsPY16xVph1iS6N5fiALTOW14hO5PfEKl5BHvhq0P1s62oJlX3zcPVl3zX1ZkCPz75LhQM+wMG6btSAMUdKPQK6o8OXJWytn5j7Ufkyl8IMd0QLucvhXc3UyGdM6XEUwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR01MB3291.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(376002)(39830400003)(136003)(451199015)(8676002)(2906002)(38100700002)(6666004)(38350700002)(107886003)(86362001)(478600001)(26005)(1076003)(41300700001)(6512007)(83380400001)(316002)(4744005)(4326008)(66556008)(66946007)(66476007)(8936002)(5660300002)(186003)(6506007)(2616005)(6486002)(6916009)(52116002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?urJ487K9imZbk3ZHyriBWM4KuM00FgMcGIEKiXHO69CdnSywvd4kEDGwv2O9?=
 =?us-ascii?Q?Psl1h4AH0M6RDJYHEEPgkpinr787SO6DpKdG3U26SsA/5AZPrQsZqqLm1r/j?=
 =?us-ascii?Q?islj6B1cd2xUWpQX3MdMroxGENeiIWZkUp60XR/44Gk/DxFgWH4iRC8KaVss?=
 =?us-ascii?Q?I1qnmZgYnFBpqLDHwhJg/EstGV68ITJS5ZfecJF4ev5nnpRjjhKM5Ydu/i5Z?=
 =?us-ascii?Q?qp8BTzgutAkGThgu9oe1NiJbg1fowc+jHcgGY7/w/vDbyj3oa5XPYhKaFGma?=
 =?us-ascii?Q?aB+bSKiMWPaIqREcn8w9kV2botqRDdhiEoA6PDJvyZOJvuxDD8DPrRbI6GSF?=
 =?us-ascii?Q?PZ6YBqEc8rnHdf/2hPaAeVgG51zaesDQ2uaD1f19jTEg9iEt/RN4mDy6Ic3G?=
 =?us-ascii?Q?5H4mLLVRmIBKKWkmlkpYJgCQgnFu0gEf8WRG8lR9dG65/ZhKmvZ0V6kH4eD1?=
 =?us-ascii?Q?eRyjivcHfxqNf35//s3UN1VilDnFGs/P1QJV48/ZDzot9QWEpd5q0Y/e2NZA?=
 =?us-ascii?Q?/Vu5rN7SScRELQhWRhqWqcnLdLAbJoOWDZ3JlHACrY0J7bLmWgWO3R4SIS9V?=
 =?us-ascii?Q?hhRiXkW+mkk5M4XlHV4VdTLDlpQRO71l4i6r4Vz9vdYO71sRmOaFqAH2k2py?=
 =?us-ascii?Q?Mh0J3YJrP3X8lm67fy2xDhxjPukLe+bBL5LH53uBSooRMLD3142Yje5EGHQw?=
 =?us-ascii?Q?DUR6c+N4i7pNhAO65ShNu3qfLW1D8wF1pgHznb/vTdrl8GvEiS6r3rx4KhgT?=
 =?us-ascii?Q?ax97LYEoDDQi9yxxjaSL9jnoQvLBG9ys+pRBWQbuQHd1wm3tkfoUCbJMmLtR?=
 =?us-ascii?Q?HX3cIumHwZeDVtCt0GU3lAv0Tk0rIf/HS8BO9qXGyYKfUkw7hOcEU+lqAOOn?=
 =?us-ascii?Q?Qic+pZwGK6gShIFKD4G6yjJ278AzFy0F97Xi30vALomPE9CDITffHFcDpUGx?=
 =?us-ascii?Q?kPkBPM8hVXZggZK59IcXSkS31MmxzwlPnwk6KPWZ6ysAFehYIM2JhxlteggV?=
 =?us-ascii?Q?6HjecUVKlK7TsOn1qJNX8YIu7pnV3VgXZaSyU7UYFUq7t8T9p4iUoRdG8aeg?=
 =?us-ascii?Q?ciewoewTwDdiKQFblqSvZJoEWiHEH0f7+S3mcBms4nErm7HiidoAR5DjGqLW?=
 =?us-ascii?Q?wUzCOvbi3t15jtg0QdgxMSNt6vD3dAj4aJFZqSHNuXbmovcjhK8zBQV9/8kr?=
 =?us-ascii?Q?Wo1WDWFKjReMTynwnv0ErntWWZY9lISSkNb0caePN6dter/NAz5ASwbJcied?=
 =?us-ascii?Q?5+AeFqv3W53PC6L8qZ54IBAmlThK+SMnIePbC6Rcu5kIs38loydYiomVWS4D?=
 =?us-ascii?Q?qcMpmU1XHWIto6JRhxs3LZrhBMHb1KfLG7m6cpm9ZmLYs6o5Sc5i9NnMmySK?=
 =?us-ascii?Q?FHhoHiShUfujKA63nRy7Bc18FFTfmKdW38IxrqlmAl5a4EqnUXq5zP+pnO7S?=
 =?us-ascii?Q?CaH6o5hOYKX9w+AnihEqLZhEKDftKUf2Ud4V1E9PN1CnaBjd4cgULWB4vlP6?=
 =?us-ascii?Q?3KXNOgcKI6a9gxGsiVwMiGPNMiF0L01z3oYt0isyG0ql4r2AmuMnyCsm6uxR?=
 =?us-ascii?Q?TwbYXlmw680u3/EbTSnhaYX7m00OiYbPrlKE68RO2nWNIlqJ+NWAAcH3Z3bW?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: newratek.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae2c5d0-e798-42c0-d9f4-08dac38d4246
X-MS-Exchange-CrossTenant-AuthSource: SL2PR01MB3291.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 02:34:29.9372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5494d269-d3ac-4a40-bf0d-8c29f5475032
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pOblvvzM3A2TDH6CB5+RGCWjPhRqqyr7/u0M6oO/+YvRAfF0eIeiPeFAM0ma6yD5azsJcy86UT0Ts+fn8YdbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5361
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If the "channel->freq_offset" comparison is omitted in cmp_bss(),
BSS with different kHz units cannot be distinguished in the S1G Band.
So "freq_offset" should also be included in the comparison.

Signed-off-by: JUN-KYU SHIN <jk.shin@newratek.com>
---
 net/wireless/scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 806a5f1330ff..f46762b36938 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1289,7 +1289,8 @@ static int cmp_bss(struct cfg80211_bss *a,
 	int i, r;
 
 	if (a->channel != b->channel)
-		return b->channel->center_freq - a->channel->center_freq;
+		return (b->channel->center_freq * 1000 + b->channel->freq_offset) -
+		       (a->channel->center_freq * 1000 + a->channel->freq_offset);
 
 	a_ies = rcu_access_pointer(a->ies);
 	if (!a_ies)
-- 
2.25.1

