Return-Path: <linux-wireless+bounces-24027-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB56AD65A1
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 04:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FCE11788B2
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 02:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EDF1AAA1D;
	Thu, 12 Jun 2025 02:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="kyrPT69J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013036.outbound.protection.outlook.com [40.107.44.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00013145A05;
	Thu, 12 Jun 2025 02:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749695190; cv=fail; b=WDs1YWayAQZJcJ6aDEMyccwcVkC45zhGxeHcIRHZELAGPOa4MDzzRLPjoMsgg97J3Qm3RLjZFRoRX2F+xxtLuJ0Aw3qGXtm+N42NtxryOLzAm80qVsCdpzbuRCeVp1FgvKqJbY286sMzrNy7jhSZLR5GD0e3PmKQmMltOH30skg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749695190; c=relaxed/simple;
	bh=O/8U/Z2AuQDytkhN22sWrusNJ+YsT7PppJ5Ws8RliDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=N/RL14zwVqV4F52T/14pglcsPy03rLyPtQ9tvFdK5CJ3G5tbLdavluDpFlxCeQ0mAzvgIyLxpIOw76/ECdn3a4wrpiX7+JxAtb1GzqPLS0Zc7gRC8gBoNyno17eCS49ymECHcJ60ILm87gSkeM1jzc7v+uUO48MZIZad6Afjug4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kyrPT69J; arc=fail smtp.client-ip=40.107.44.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oaXMrdUE1qVBhVRb9XLVwuV/NJJ/b7F3aIFliRZCB23z/uGMuM8wjDfAjFsLY4rDpRPpmy2x/n1lw7J20PQyAsHgnLcUSM/0U7RNZ+2mn/bVj6mf7Gw1VrmDK9VXs9sq82rtli8W3gMM+m91owu9thI8PN5jSX/rwVHo/SZ8mSn7uBOwCZlpc2NJ+zVKlIP+m9q+bp+DG2GMcfoFELNn1Es6AQU69JYiZ24ppUkrPksZfndRaTmEF9wPCgAhbMDBPf3mVUyhu0rDCRLZnONI0GgSGY50Mtuxf2ezELlc6oCoHNhWJlN6GkOQQzv1RIjfMwRYmpxj/2NkwltPly6EZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9XpKMZoWpT42jIM9V8otiXjzvf1q13JPwEwdcQAt14=;
 b=h5CHDM/jTt/AvKgNh0ZgRIAzv+oLSzxynIvlc0pkkiVMVEdCkZVdhCoRJt/6RxUa8gaRfsmd83eCxMadFMFsjslkqzjOJATLX5hTuBUrbYHHb8cf2Tr94FWeauwpSEPsVaUy0+r4ceXgBLgE8c6R64jTfz3ESat4GuZ+sb5rrjVz8FnHOJ9mYAfuyNDvbVYBvLFFtLzycm4RQzRBrooVZ27yRT4dAUl2JpWMzRJIoMKD2CzQ3VyBsJJZPYwhhlcAQxpPfBqae693G12EYK4O7m7WSGUzMe2kQecPaAv6zUVYcvwwS06ltb9RAHMehYiB6sfLWfND7FKLP/XK6qAD8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9XpKMZoWpT42jIM9V8otiXjzvf1q13JPwEwdcQAt14=;
 b=kyrPT69JBCyLMMkDUrG12hvLR5+GiwAakfJOYNvIh0wvp08qzRXSNyNptWP92zO8uSFP59980lBOgZXseXQ1l3nS+pBbnqnNJjmXtKDR8kRLXEYAORtUqlp9qxNzh5mYrJGEaoBYp7Bn52FWyV7XNRg0kaVyFpTXOTrJ+lsLFTouelWB9Ynr+aM7Sr0FfdNyaf3nQCU8YLM/wT6rv6nGUuhZlpuoXXVVDHrpsBwr04anvX0NLuBPB97BZvAbSyvbnMpwnZbYJhbU4cFKVtyNIpczqjgYxlUT5+GLXAiJwqQMQLRKZhJ19s6AR701E5p6cEacacCDcCNULvISPDTO5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB4802.apcprd06.prod.outlook.com (2603:1096:4:169::8) by
 SEYPR06MB6524.apcprd06.prod.outlook.com (2603:1096:101:171::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.29; Thu, 12 Jun 2025 02:26:22 +0000
Received: from SG2PR06MB4802.apcprd06.prod.outlook.com
 ([fe80::685f:929d:f06c:a349]) by SG2PR06MB4802.apcprd06.prod.outlook.com
 ([fe80::685f:929d:f06c:a349%3]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 02:26:22 +0000
From: Yuesong Li <liyuesong@vivo.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Yuesong Li <liyuesong@vivo.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH iwlwifi-next v1] wifi: iwlwifi: convert to use secs_to_jiffies()
Date: Thu, 12 Jun 2025 10:24:53 +0800
Message-Id: <20250612022501.3492345-1-liyuesong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR04CA0019.apcprd04.prod.outlook.com
 (2603:1096:404:f6::31) To SG2PR06MB4802.apcprd06.prod.outlook.com
 (2603:1096:4:169::8)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB4802:EE_|SEYPR06MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 710cbeb5-8c6f-457c-189b-08dda9588598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BqG0FYCsbsp/R2gwrckRKYv3XxtMmeTwSGEz0cLltT51rErR0M1i4lulWseL?=
 =?us-ascii?Q?CdDgaIOkEuxmbmWlr9N3mftep0RG2mZp1vJG3+W444DCegcjzv0RAHM2WAhB?=
 =?us-ascii?Q?yXeXKtEcMcNukF9APJRkVrfOEpQppYlqyZ3fidVl5NeJ//CNEWsKsyXchXTo?=
 =?us-ascii?Q?8LawAE99/lx/+0tWVim2SO4SUhmP/x1u7CfmG8lKpIlzUDimapWsCxyZDyvt?=
 =?us-ascii?Q?y0DD7aOVqytZRzuDxFJB22AC7CxhNkTz0bVZnEGSHSE/S7wpBcj5r60rWkjo?=
 =?us-ascii?Q?Na4X3dGvDX5K8R8evEGkG6Y+rZt46lC84IdNB0YD7MqOfkwOASJQtYtiHv9T?=
 =?us-ascii?Q?VAHH6GwhS1FhtfEP0f4BOPvabcuKb+ibkb56jd07hW9coxwMr5AztTyXhQT8?=
 =?us-ascii?Q?4+LoOsVVVvD7tOC6efqJNuDamTSKG5VXAcl6aevSPXKVd/Cnc5bcKI5+zuKr?=
 =?us-ascii?Q?q63/mAChq7LBLlSCCPDL3MhRnhseQ0NDWVFCp5TqUEFclqaLnxgEANxig/xu?=
 =?us-ascii?Q?9N44JCX0k4RUZ4EPLtDXrnhbD3E/UxK5djDegyCelqZRA2PLd9hPrNQYLMwS?=
 =?us-ascii?Q?YnWvuHnAJ2YB5y2Ag90sMC9R+SRfd+z7DTMqbmm7pZ9o2Y4wytyhCvAwjjt6?=
 =?us-ascii?Q?ITqM350JNR8Y0+k/chfvkEMf8XmvER5yL0/boHbw/CoGIgO5sUYr/F8FX2vA?=
 =?us-ascii?Q?t0y1CyD8jkKaWiwKAEVwwhSJRzwaLPnAOxYLV2to8mdGRV91EZDub8KuzUSM?=
 =?us-ascii?Q?3HmKr2aWB5JbY1uwcec0ErT0S5c+2RVDFcRtkBdbGyR/70G2BadFz+DJGXXH?=
 =?us-ascii?Q?l+QSQD6+kYPmUjgj796+eVE/G8Z6zgeNO9xX5JOYQhI8po70Hui5YpRZX6tR?=
 =?us-ascii?Q?dNC/O+mNMmldo3Ju+CrR+UO/pIUg0WS0lMXzioN2oaPjLoDkv0RviX2Aj8Lt?=
 =?us-ascii?Q?a1jJTR9xehNhbx3wat/6zo7T0u5pTigqDF9rSFDrLSdY7ngsJ7mfotIjg/B7?=
 =?us-ascii?Q?ZhRjPyePmkTPP9Q4BBpL8pfYwWGiu5rp5hjwfySE3PZ6JnK3+uy64Gg8KvyK?=
 =?us-ascii?Q?HIbpjjUvJcqmodgzzfiCgYG9Hz0jojn8dFFJQlQDtHm9X4rrOMOpy+jgHteh?=
 =?us-ascii?Q?fKLytzMmz+wSESLKN659BC9H+XiKxIIvMTY6mjq0fjZ4tKND/sBir6ywLGB1?=
 =?us-ascii?Q?myz3ZIN0CIX9ntje+ZAcZyxv83gmZiBocA/L43uBJgIXMi0D0iPgwXTTFZ9K?=
 =?us-ascii?Q?FenIHr07LKJ7VisMQeYagQNHU6vQ1ccdgJI0OpdmFrX7uA8vvwK5fZblDSSz?=
 =?us-ascii?Q?v8oip1W6y9CcX+IYqKFu6BAJj36V85aPRttNaz012ve1iEreReXsXiKObK0p?=
 =?us-ascii?Q?/GwSzfVCGwOgZ7JdEYVScfS2WjQok70RvRg0IH0M7jvNvTRTkLhJDrqRAjEp?=
 =?us-ascii?Q?bs/sQus5NEbCrFS9kLDhy4linCfUwCuypbPRBOgWC8+IOdB7lMEweg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB4802.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hIiT0IpjgxfGDa1ymZFYc++TZnK7V19d8W3gSbybFWhs3TXaZ8eJ/W/WOHBt?=
 =?us-ascii?Q?8HS78MO+Z92N1LHyXBkMSyR59bqLMEqT05aKk1tSqdd5MgeDz8fTbA8zvIdC?=
 =?us-ascii?Q?tz64yR/IqaLAEG3YIVRoExzUMSL4pe6KLzAi/4AC7DWWMLSeD775iMFvOpaq?=
 =?us-ascii?Q?sKiqZQMUziP++cfqpnHWSOemEui12Af7U/oBSTRoefOTjgjzXcFk5P8rngPH?=
 =?us-ascii?Q?+/LjZ3oG6B4jUIhxzlhBcxE8yTwd3uc/y2ZAtHztvmI5Hs3JoB+SYBuWxed5?=
 =?us-ascii?Q?ucGgzpoo7846RJK5FcO/iTRd3/FdJSVXG8pVTG/AzN/IYexz5svzpS2kIMnI?=
 =?us-ascii?Q?OGe+bGWGHPDZbdC01npEnY/KQvqka/1Wd85HvKxFEJ1vduLLVlHieGN6Mp+t?=
 =?us-ascii?Q?vX+KincWlht5aLKGeHHkvfasZVEwKjzwLgMLOxRnPx52rqoD0m9SVtsy95Uw?=
 =?us-ascii?Q?whhL/iDbY+Vcz/UHaCx0DXsCtDo9JkI0tUBMRZskJFYmtcadiCQelEcMndug?=
 =?us-ascii?Q?lDjdu8y7aSDSu6Yda/I9UyfSgescOyGrILMZdlvK6TB4ZK4+lpMkQqzTEbNc?=
 =?us-ascii?Q?PopKVo4EqdS5IYj7F+Apew2+nbbVY5ZSiRdU0W0QWjxF5/X94RnJkzuF+UNV?=
 =?us-ascii?Q?jDZaXH0oWJLLCqUfPxlWst81n68OgoNrb51oL8/K/cg62nZ9Qi0eJLp0N15I?=
 =?us-ascii?Q?jNBm7uUVQ6/KGIUFAGznYT1GwU1jmRicKv4mY1GWnbv7W2obVRoLcawerv8w?=
 =?us-ascii?Q?YFQt1y1Fqk5tuvPdOS5ORx25Irm3INEsGYyTQ/4FhSW7t0g4XvmDWVGoGV69?=
 =?us-ascii?Q?uXoZFA7gQWYIwrrzXjeyGVnF8EuTC5GQvyW7m0PO4joN8knMiCBeIJrlGJap?=
 =?us-ascii?Q?ZZHxdIm2VHUNXAVOrLciqeiPf8HdqXcVX+U111sgwhO+uB4n6ZPw28MB6Izr?=
 =?us-ascii?Q?USSmtbhYONe1O/oad3jjN8ieDlhSAdxEDjun36vadxNzBVJbWuC4zIj6P/3/?=
 =?us-ascii?Q?oyQbKiQZNLlMw4UseTXrTGF5EQVbOydDsnpn4/iW26sc57whoe62WzlWOnBW?=
 =?us-ascii?Q?aJy+lHUkvbNJzBOpIjotV0m64GJG4aC75PT6kLa0hz5S5+xq3gumCALSHAiW?=
 =?us-ascii?Q?R0vR8aGKej5bX/O14HBhU+6WkUumz5sz+5tW44RzdKUJr6eH3WKPEjU/+7b9?=
 =?us-ascii?Q?r0OimMFOyH316NVgDAQB3ji4pXKQaayqV1YKD5PrLW/fr6SzXMHB/lXJBFLi?=
 =?us-ascii?Q?6BvIm1tFMNkEtG3WzwffbxI+nCyH+FpoGIYXqh2pn4MUUbtAQqmZGV8lSbvU?=
 =?us-ascii?Q?WylUnZWWTY38BY7tToI5D/BIVtD3nkr3l7bKDG/EpR0mnlAgtLepCCBnmW2n?=
 =?us-ascii?Q?CE4966Q0LINZH/1f2o1+/FB7qTU84nTD7e2K3KJpRhgeRRPxQe4TTZgkNZVG?=
 =?us-ascii?Q?UY2h4Puo8PIZ5rgAly8YPX2KVW8bM9ej//rPUIHaFlPnDO6s0uUg1bCc6NLE?=
 =?us-ascii?Q?NS94vQgNyEYle69v92YK8iYW1MKl4rbcRhkY93fzaFQJEw2zZd/G0RG0/usd?=
 =?us-ascii?Q?EsvgU6LInRhxAUSFNgN4QAI0S6A7JxMI0lQJtWYF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710cbeb5-8c6f-457c-189b-08dda9588598
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB4802.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 02:26:22.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0K3+ZmBFBrHrfPMv/4bzEtJauaSJAel4wy5/0FCBCxvW1HYaCjo5GYO3j6OQTZqCo4EpdHV61lYmpP9ckPdCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6524

Since secs_to_jiffies()(commit:b35108a51cf7) has been introduced, we can
use it to avoid scaling the time to msec.

Signed-off-by: Yuesong Li <liyuesong@vivo.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c     | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rx.c b/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
index 5f8b60824043..b34ee68f3dce 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
@@ -429,7 +429,7 @@ static void iwlagn_rx_statistics(struct iwl_priv *priv,
 	 * thermal update even if the uCode doesn't give
 	 * us one */
 	mod_timer(&priv->statistics_periodic, jiffies +
-		  msecs_to_jiffies(reg_recalib_period * 1000));
+		  secs_to_jiffies(reg_recalib_period));
 
 	if (unlikely(!test_bit(STATUS_SCANNING, &priv->status)) &&
 	    (pkt->hdr.cmd == STATISTICS_NOTIFICATION)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index c70f2a20f7d5..803ba35e7501 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -198,7 +198,7 @@ void iwl_fw_trigger_timestamp(struct iwl_fw_runtime *fwrt, u32 delay)
 
 	iwl_fw_cancel_timestamp(fwrt);
 
-	fwrt->timestamp.delay = msecs_to_jiffies(delay * 1000);
+	fwrt->timestamp.delay = secs_to_jiffies(delay);
 
 	schedule_delayed_work(&fwrt->timestamp.wk,
 			      round_jiffies_relative(fwrt->timestamp.delay));
-- 
2.34.1


