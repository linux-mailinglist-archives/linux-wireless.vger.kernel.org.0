Return-Path: <linux-wireless+bounces-12206-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E571296453F
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 14:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31DC3B2547D
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 12:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7101AE85B;
	Thu, 29 Aug 2024 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jBHkU2FL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2083.outbound.protection.outlook.com [40.107.215.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26DD1AED48;
	Thu, 29 Aug 2024 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935436; cv=fail; b=cxK+zhfeDi9ygnGSIQDwFNnZ4hLRdUZWzcG3+sxg05+jkSLciR0u/m8mD8zv5GSGmyyReFJ4Urk6hJGJisII6HT6u1eMFmX/y4RFCHfg+PNaVpSRkuD9FKnnijUtGHT3Dm1B4g4+Bta7prMIlM8IwrusBGYfLVlSv+iR61A5oow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935436; c=relaxed/simple;
	bh=YC03SQnYj/T+za/oSSRZR7+EhzzdjSI4JhNe5YrZstk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CWyZvJ2S+rlXwC5yKAz2+FpAsNurnDU0Ex+3OfAOEtIKuHBFMurQgHNk1k1IlSnU77zKJIFRIq72I81VRqF8mXlqDqzrzkAyNQuhYgIJUQ9ccmlb87C2kdIVdLvJjBaiFRXfb6JGdM56iz34tfDbdhRA0KavBPwgYtpRxf/Dq6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jBHkU2FL; arc=fail smtp.client-ip=40.107.215.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFmC1dw9HaSE3st8B7hz/Y8NnIPPfoVIEohqo8Zmnc/P9idU898xhMhou++Vh6EBP81x7Gm4cEbZXleBgf/5IA8mjb5Lik9vb++wJN7+E4ow7gdcP2rZ0HcaJBG1uPhXxelyooX0DodjAqHOhrtp9vrB2Kv6ClbSghgt+Va87DsM8jUMFvP/O5jlHf7XdxV/TYkIi3B1a2vxBCLzOIW4rQ0VAmiRggxBx2vDxDlxHveLgUJ6a9WkirZTHZhUuDNUpZG01TJhCu9ED5ou58McsjKbnJjnAqlr1McEnHJ18Y7raLChXSAjblItXtc/2p1OkXbEUFlgjzeJcFMhMRerWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIvKF2fzg1uI2s0A3KofCkTNfX0t3SY53tI4ftOFVyY=;
 b=w/yRMpZoDdJy0o/+nkp7TSEdPBxshpQpyfG/yy4/N/JibHR6F9O48Wk7mMmdLuKkc+D7EDsc6k30a/qrj9mmz4+GysoQz35+XI0SB7NqmdeF0bnx63jw1H24+kOQLY5aQXV7+W0W+UlapwKCFh0hMlnVM3Wyi8ub/nN0VT2JBIQQbIAs2U0sNGxRbnp9jYEmyEGLZZtghV+oPnt6vQ4Ls3iJDYM3xh64PxHyLvhBNhmDlbkO52OjI5kU3IQPpabEpRNxatlIw1/4TAvObjyXo36jLL/lzOIqdcy0p1qnoxMFqecEdOz7HVdymhM8cphLmTbRUefU80lnrJ5FbJHmeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIvKF2fzg1uI2s0A3KofCkTNfX0t3SY53tI4ftOFVyY=;
 b=jBHkU2FL9exO8pzHKpZICcJtGrddaCZ4PjTSIL6LUA+vunCF1S8gauSGOz8vUMK17zVqvk4y1Z4fmCEIBqx0H6xVAMIUFqRlGQUpWU9tvJz1Lra1Y6AW5bJbXano5MA9bTs0j0rPQVxi7ROsycyv9Hi45bMi5EYYjbzFX6LyAOC49iiDsKPhwL9cgUX2tQY2T03832Z6PwUs48YL3aLSC1AYGqrjwrde68f6vHCQDVrtvQmOBz0rIFbagwTlYVY7Md06GqsRp/asUhYbQsFkGqxEz78/QUYKaXZh2fLJKeE+ZpPN3Y0U94gwVpWwrKrp9R038k1HT24dIjAj/xHvPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com (2603:1096:400:283::14)
 by TYSPR06MB6528.apcprd06.prod.outlook.com (2603:1096:400:47a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Thu, 29 Aug
 2024 12:43:51 +0000
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a]) by TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 12:43:51 +0000
From: Yuesong Li <liyuesong@vivo.com>
To: kvalo@kernel.org,
	kees@kernel.org,
	johannes.berg@intel.com,
	neal@gompa.dev,
	a@bayrepo.ru,
	justinstitt@google.com,
	marcan@marcan.st,
	j@jannau.net,
	wsa+renesas@sang-engineering.com
Cc: brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	linux-wireless@vger.kernel.org,
	Yuesong Li <liyuesong@vivo.com>
Subject: [PATCH wireless-next v2] wifi: brcmfmac: Convert to use ERR_CAST()
Date: Thu, 29 Aug 2024 20:43:26 +0800
Message-Id: <20240829124326.3257874-1-liyuesong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::17) To TYZPR06MB5709.apcprd06.prod.outlook.com
 (2603:1096:400:283::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5709:EE_|TYSPR06MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e96aa1-9826-4462-80e0-08dcc8283bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?agRE1Yy2ETho+J1I6tZwUX2HMt0V+T5XeIuRzyhwzJyud1h2uzIBOCrr7unu?=
 =?us-ascii?Q?ppwa+OABgvyQmHJFboXsFJOKixk+aNV6kBIpXAg/yv0ed+QpRLhhfp/lh6cW?=
 =?us-ascii?Q?GHXaUJ7QVDDwYkjH+VYNmISNho0jQh+xs+NMzp8qbHL59ZNdjBZYNXPo8zQV?=
 =?us-ascii?Q?n4SMbHRQv3uCArKutJJMwCVtw5CFHPgPTqGZq1z237NpcbggIdsb17lfjC/D?=
 =?us-ascii?Q?nL4ix2bfnG9Zxtlio93w9WmtLqW5vVs3q9WXYZd1kvi2GvO4mLNANnkOWPnq?=
 =?us-ascii?Q?IVAGnyKcxQMPcE+BOiCKXoYPWAvkoioqsKVTb3MLjcO92UOp00T722tMddX5?=
 =?us-ascii?Q?8UKEHaJgXwkOD72dHrjJlIAfYSsHOGXFpmVZcUtOolNqV8jOnrKPFOIiQmrA?=
 =?us-ascii?Q?f8pH6kNFyjJ55PizJNooSkjozn0V/8Tc8D4QG88Vz/07u0UltTFstlCARsOt?=
 =?us-ascii?Q?GVrys5+dgcjTX1nCjkYvBhtJ0stdEqtwKcoMga42IiAcgpI9DuJ07omYjpO2?=
 =?us-ascii?Q?9DOr7e13tg7hO9S93NqtzS71yZCOl0KLIOMmMgXSaL94pJKF3Cwl0HsJqAGn?=
 =?us-ascii?Q?uMYo9dKB1Sx2pyRxoCOMRWVJJOEsoTUIDLUwJ7F8Ekjs6ac/CwUiBg8gFE6V?=
 =?us-ascii?Q?8zDN5oMYmUzQiYKeWbUk7QG6Usa2J8gMUl3FNOLsAE5grFnGVvA8132F9xYA?=
 =?us-ascii?Q?r6w+XoAnh92u7ethdoYgQNcPR8tf18tnYzFpZMBx2+F/YdPjRbSv9PWgt3M1?=
 =?us-ascii?Q?5EKLVam2e3B8mspeYE/rFbkcHYn3lrFph1aWndxqYlsAFCDpG7EyOLFd4ix5?=
 =?us-ascii?Q?jxT2HGhuQpV8gBSuSTMFfwfv5i+UUPJqrZtPHaNJRv+dKlV7i7HGgYU4PHZ5?=
 =?us-ascii?Q?7+nW3d7CPi2mRUZGAFvzzvP1HFcyI0N/TCbCalWIDs4iVCAbmadBCdUO/O1X?=
 =?us-ascii?Q?TERi9v65R/v+QtWj34dStRHtkz94JDn0DEimgLZyDmSJNweTHBQSpGxDydK3?=
 =?us-ascii?Q?xltG26i32W+J8yyUc4G8F+efWeqh8aRSog68V9ckpdSbl6XMo1p+d8ufE4Ng?=
 =?us-ascii?Q?kJMLgqp8MX/eDeYmuzIr/G2PV7nw4TsJT8JqtL+MLL58QB+N9Nsea512bXAa?=
 =?us-ascii?Q?/p1kvgAy3nAU8UBue1ISfUDdRK6eUReXVmDokVx6QwLZ52W2MGM5EwrUqWF5?=
 =?us-ascii?Q?e8+7P9j1z2h4I07/1bwWDcmdGgpAvU147q+8GZzF8/l6wpRDS+pCO8YN0N/z?=
 =?us-ascii?Q?v1sNVDc0SMjPZr2oXTWleAkHrUaWsm/6RFsJWmOZcIXbfQHduBgqRuwqvCjq?=
 =?us-ascii?Q?JzRzKziCID/6HneZLAM59cJSXyUn1rhwoah0tCmSg8aBAjZnelcSctJLWf9W?=
 =?us-ascii?Q?RUlWcmwpH00cZwTksFmrrGWQ14CaaiL94ccBjBpEkjMqR6AMOA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5709.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kn6f/pGr5gq9hujvCXrAndH4jryAuOj8ZxEUDJVuJLaCaHGmNl2vuz52P6py?=
 =?us-ascii?Q?thZlgZE3mbfpQITmIDgzx2AUEdgW31o0Mxxh1wFRuVmwPAy0LBjbOu5ys9EF?=
 =?us-ascii?Q?zl0dgEw9dJhw79nhwfD3AJanxrqcArlChc397C+zzIJshdiG0rkUbhMd8s2Y?=
 =?us-ascii?Q?PGRZrhm6cgSfIna91wv24Jx/V1gSpKddPhAQTDyfURNcdHeUDyI2GhKGZq7d?=
 =?us-ascii?Q?amfMpBX/vBOERpMR8WZmWqj/5t6s70SEfU82KN2LUFd3JnD6hQFG1neiPeEz?=
 =?us-ascii?Q?NwVs93+z+yDrPaULI3CDIwg8tdFWkpRpXvBm0enSTiNb4m0xYlKRQBQX/yct?=
 =?us-ascii?Q?n85AfIQHyE/55QxTNJMKyt/iFbL7BLKqRdyHcFuZSNYAmaoDIApHZDKMeWn/?=
 =?us-ascii?Q?NBO4GDVyHpsp5D4PROU0Ik8POX/53PwCwg4i+5sx7NxeXbpXQwVKGCrNI4Dt?=
 =?us-ascii?Q?4y66tI81zha0WwOSzCkgmBlnyp7s2LGTbReama85kwsXGyBx/EsaMfTb2dL7?=
 =?us-ascii?Q?0FjCqMx13Cq6y+DG7fcl4auNdMvYb6WjDVH1xHf0ry3d1idSkC3PfiUwws/B?=
 =?us-ascii?Q?zqWkdk2ztnHqewlqq8BQhwRZ49w8PEbVHuGkOy2apvaCIkyO2hhTf4cQEz8/?=
 =?us-ascii?Q?KZWn89nbWKgl6JTxK7m6hTDwROqKSr3TvNY8K2TPYTVJgAIdFGZ3SbaA8RIM?=
 =?us-ascii?Q?o3yGz/4ypm2EBOhNxqiQXxw991f6ZBT+ezv5uRN1pclkUNiN6Gu/90gJZNXj?=
 =?us-ascii?Q?wIY7uGTARrSzhYwH/w/iq5AbAVLODBqWLGffHrDLf36EPOkWwDsIzf0JNxjF?=
 =?us-ascii?Q?9EhJgHBpoSvMVqOZnasfx4nObC7xNMeSa4mbYK5r0ScoBLRqDhZtgfOHJD4A?=
 =?us-ascii?Q?iYIw/ZIxdVFq82pII0i6w2nnJPBGLUtpGdwy6wJfIIIQ6Xc0diZnQNAJbRP7?=
 =?us-ascii?Q?XBfyO7Bf0a2MC3OEqzq+gtAeYSo3/Opv7/9pW6cAeyksC3EaSAg77kfqw0eu?=
 =?us-ascii?Q?aA7YXtk2XEmMrIgyMu5hkZwu5N8KBvj2RI1ijX1cumI60a0hhSinDaEtbAwW?=
 =?us-ascii?Q?OtSW0ezLIpdhmTvrormFRt1GswUlnNwHKUXXEWYmkgMtlcRQq4JydedrNCih?=
 =?us-ascii?Q?slH+gkDKIOSewXTkZsqshW5Oa+ImnZ9XpTOlHG13imAg4OU39IgB+MLZ2xZ7?=
 =?us-ascii?Q?Md9pJZUmlbJAk/CDdV22Z9B3zNoBirZWkDs3hHjq9bw5tGd/D+mkrxquCUCo?=
 =?us-ascii?Q?luWamNLyj9g+lCj35+grclZn4ULQ71MgD6yeCbQ4jVOjI97Fh7DpNi6nLVmW?=
 =?us-ascii?Q?mp9jpAOFsFW6ZC91ZRiJkSVa4H0rSgMfjHTlLZOmIpxoy89kAv9K0Vm3jEeJ?=
 =?us-ascii?Q?NluPXIt5yok8oFEmCXo/2lW8IxjcwoO/l4HnY8AjfJZgB4CHJ2sRctERpPyA?=
 =?us-ascii?Q?WTPbn33GZDlMN1VNV6n+ghSkQq9TmpA+TmvM/hxLS18ZbVzNKBGZ+X0eGd61?=
 =?us-ascii?Q?hOiSWZJlauohQnDARum+3u/okVJfP/JnTROm8c6XEG6OL/HwoYfEUnP7uKPu?=
 =?us-ascii?Q?gcS65XGWOzZ4JP5LhO2/comeG8qfVCjHd6ZPV3GI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e96aa1-9826-4462-80e0-08dcc8283bd3
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5709.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:43:50.9364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lpe0NsifCaTFAR2/3gAoLO59ETlwPAftGXEGnoNsYl0YSZ1sFQbUymGWY7bcVqJI4ZVZqcsRYmhNzK8AYvggQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6528

Use ERR_CAST() as it is designed for casting an error pointer to
another type.

This macro utilizes the __force and __must_check modifiers, which instruct
the compiler to verify for errors at the locations where it is employed.

Signed-off-by: Yuesong Li <liyuesong@vivo.com>
---
v2: - Fix the subject and the PATCH name
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 815f6b3c79fc..3ea2824f8a68 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -836,7 +836,7 @@ struct wireless_dev *brcmf_apsta_add_vif(struct wiphy *wiphy, const char *name,
 
 	vif = brcmf_alloc_vif(cfg, type);
 	if (IS_ERR(vif))
-		return (struct wireless_dev *)vif;
+		return ERR_CAST(vif);
 
 	brcmf_cfg80211_arm_vif_event(cfg, vif);
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index 6e0c90f4718b..2e627f428f5f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -2164,7 +2164,7 @@ static struct wireless_dev *brcmf_p2p_create_p2pdev(struct brcmf_p2p_info *p2p,
 	p2p_vif = brcmf_alloc_vif(p2p->cfg, NL80211_IFTYPE_P2P_DEVICE);
 	if (IS_ERR(p2p_vif)) {
 		bphy_err(drvr, "could not create discovery vif\n");
-		return (struct wireless_dev *)p2p_vif;
+		return ERR_CAST(p2p_vif);
 	}
 
 	pri_ifp = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif->ifp;
-- 
2.34.1


