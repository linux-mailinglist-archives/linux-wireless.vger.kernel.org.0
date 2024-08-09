Return-Path: <linux-wireless+bounces-11220-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9DA94CDEC
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 12:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C1A2B23206
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E721A08B9;
	Fri,  9 Aug 2024 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="muoDIXXJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011065.outbound.protection.outlook.com [52.101.70.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C47D1A072D;
	Fri,  9 Aug 2024 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196900; cv=fail; b=l4Ws47e7SrutfcjBHgqF6ybbORUi6BVUEXFzgdy7YN04OrBHVVZwd5Qjlc9zwti4nSrnFedyA4IWctkKwXqB0XYx/zuCzLOG4zV/JkmI2atEyeygKQQQDwYugZPIwN/zIIBpydgFTU6cVcn1e8PmNHfAg/6O707ufEoTjH8seDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196900; c=relaxed/simple;
	bh=98Pyhc1vmdONEtH69+rLK+sjsXdvJntJ4nMJov5RyGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j8uRmUg9Lv2fHopozkPPdBCebXq9MM50Bzuuk3e9JChu+67AANLtCyG0+Q1FtYtf8h0574RIhqg8kZsxr/638tGoV+B3kBqXUWG95vnOzpgeBOFiGlc/rDd//e+1jvDHEPq2pOeioYZvcgn31nxzRvPgpnr0gCppZZLCQ2GlzFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=muoDIXXJ; arc=fail smtp.client-ip=52.101.70.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjfVufCiX16q1Fbw4X43bpw/D1Xv3iFxu9l8baGAxguyo+UORos5fzZoxiexyQAO3stjme799/QhbbNdYjgwU/33QhZnKP8016f+pS87v6nMAkt9KVi8ZmUXBrBEldZoCanLgsAN5dxHy4vwU4iWt0be2fqcRllAfLlvWxcwjj+oFBJoTUkItlZ9r+GvY5G+wt42xJAMfe7M3FaBI26tRM435d+LsmucuJGTNBy8odmxg2AUaykrVoETBHHMZV2SqsNDvgvCK3zNK1qZRuVZ8CCMW/kiM6hdOD0TL1zYoYt0OZy2XRFVSVfl3VKVOOFZE03ImNOHydLXDX2B3yj4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqAjyqQDEwzBFE1vd1n7Finm5tDGokZZiNeKEDgM5hU=;
 b=LHnEruwdEKm4g9yPbqQIHlUipIJ3/ZbGrHch8HCCbHDGEwkwq4x9540O+lfzCBxsm90YrovAt82+T0fbhcfuq+LhBrM4gE/T4GbrXdYAN6gQQW+L07rdGv8iAczBpQCZdizxfUKtv3D3tsHyNUpFtZ9kCMrRGe+HnHtkn+wMfm5W0P4FW48o28CXFA9vMrFAK5jFiuvi6wS4ffK45K0ZTF8IMIhmbdPpRaCNSWEwxz9GZOco94FfESi38Pqm8KtztUL+9UZrcTtAeyRQ+hhxnciwU3n3k4Kcv5uM7/8NP92C5BYxwaqs4ysHtSghCM2pPZU0OyprfB8O+bKvOOzhkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqAjyqQDEwzBFE1vd1n7Finm5tDGokZZiNeKEDgM5hU=;
 b=muoDIXXJgV5RyBzB+d5MgkvxSMwnrbez5oUFKe15XLbLujgGp5pHO6bNgm1pzrMPMuGrs6B85MVW0LUkQW3fEVi8mxLB6LjArZzWv7BMh01AJTN8woINoJ99kA3lJmC8eNNI4KGYwvpEJOIP8x/8uwXqNIkr6/4w9jBg9ExF1ugHibV11hoJe9r8Ku3HDGCxiLa5Zd8RNdb9Cs/kpC9UlZei4IW3/8bx4yXMQMWQ/VFe/0nwOvrQC8URqneE+C1Yyi9kc3SU3K/7bnrIC9ZKhgBTRTvpPe7djyyoiG2Rv0rz1odeV4UQsisrm1rJ/++qv1QDPZjJRWk+u5dNfxTXhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GV1PR04MB9120.eurprd04.prod.outlook.com (2603:10a6:150:27::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 09:48:12 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:48:12 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 43/43] wifi: nxpwifi: add nxpwifi related information to MAINTAINERS
Date: Fri,  9 Aug 2024 17:45:33 +0800
Message-Id: <20240809094533.1660-44-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809094533.1660-1-yu-hao.lin@nxp.com>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|GV1PR04MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c477a5e-b5bf-4e90-2d4e-08dcb858622c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|52116014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?STaYYNr/cMfBvEHbd44bwKxfJrKvuXN+5TC9f8ulO9yAycZrWqDc31QzUzbF?=
 =?us-ascii?Q?0671gAZ6BxS0csdFvjsd8THrK5TuNcTqWJW+11V/OjvkXxq7TUtgo2t6xYak?=
 =?us-ascii?Q?Q0thRQlBRJEXH3kKDa3CXrHytkRuNUO1rXMLpVQ7BahcgiutqXHWhv2krIsF?=
 =?us-ascii?Q?x52mfTK6WB6/rGEsMjR3UxNxfM02xsTqPGru84g1aHACYXwIgPr8vQ2+Bujb?=
 =?us-ascii?Q?p7fe++1Xr6l+kCIyNCG5z02L4kwO9NKmF3SGZChi5uTnoTx0AM2Ed34rBInz?=
 =?us-ascii?Q?IJe7veXwPX2/5ouCBDhPlWjYWkhqc9GUxBRSoLIxCZq7DWb+BbeuS6LuoOy+?=
 =?us-ascii?Q?OPmuMIz8+7mEAqKFNFVI4zSKKtkeu57kab337P7DBSJpKjTizX3BQboMJ6Pg?=
 =?us-ascii?Q?03bZkJdR/HhJv/khGXe82EAvVCZMq5yWOk5qfCFwzKm1Na8vS3/VJasxiJyB?=
 =?us-ascii?Q?qUipjYnXRamHWIyXNgsgNrpM9b27Y7qlLf/Va0qwYouZ+9w49Gh4MIDO09zO?=
 =?us-ascii?Q?PRQWxd6gz644CVIXM/IDDE5g9opUPyRuIcTAwXPAYjIxeJw0hCsYURaYFW/O?=
 =?us-ascii?Q?Mj0oJs1cFZ+1Zk/0VhTMpWMZuO0CUR0JQB5uEXBB9R0PDh+vgcX6OthM5M9b?=
 =?us-ascii?Q?bUtey0sB/ZYXkS7Azz9XECq6Uy8fQViS55QaadjLJhmkz82dbB0BiK/2Uwas?=
 =?us-ascii?Q?oX0ItZaP1u+GVQydmS3hm/KNeiNroiuUF9W2sww7gbpuSLw+InpsAIqu0Vfd?=
 =?us-ascii?Q?bX9mLOBnR0yR+pE3g7DfgVhjMbsvCO1pZ/f3aj+esMxKDF7DtIaN2xXTWY/N?=
 =?us-ascii?Q?pX1XBehao/oRkRyPjRJLONOWSWuRN1wB5DljH9FjZWiR+Ojv5Fsh7gKvH+qh?=
 =?us-ascii?Q?yo05mOproiz7jI9157G1h4il3Oci1/IvtyMi76Xps8wyR/QIl2/WNHsko351?=
 =?us-ascii?Q?uFPSZlqoQOoXKOgZJYPQTkleZxaV6dECK1QKr6/rXMk2QAj87ph3mTY14IYg?=
 =?us-ascii?Q?+hsKTYFzQqEgo8P6DzSB243/INKf3LxnNQu/AsaHYHGAeOr6ppTwHRo33MsP?=
 =?us-ascii?Q?k23PJaRJwJ1F/3VRpxb0XIIYKTrVdnqCGsyPfICdWjkzj1jdgSg9ciplH9lm?=
 =?us-ascii?Q?Z8+nLppioVpQIHis3+KRGvBBVGPhC2ReWckhfbPxb5LEsCB//p5SAmEYf9+Z?=
 =?us-ascii?Q?0r850GckIsEGBI4DibHGNCOpJKXbj8aiYqHfSlz7Md/4tl08eXDu8yIZJR+z?=
 =?us-ascii?Q?mnPbSvNlt0HXs3zqwqweOkSdxuFSl8Hv8blSUVNjcYm2wwE/AQm0gOC7eHef?=
 =?us-ascii?Q?e/w/zKn3sES/n4bE/ngjg5O8E8YJe0UoPD4uzXrguquYTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wsJir3a8yo0s8NvH0gbm5iFxX1XaooBL3VlB4/S2km9MZj4lg0lTlWqjBcfc?=
 =?us-ascii?Q?yh8zDmc9Jkf1fr9UDmL+7WULCxvXP1b/6aaHuxSeWiQaBUuRYlPSjybyr1p8?=
 =?us-ascii?Q?zDDOu3HkpRZJQLTLeXZS6j1PRXiAzHeHx3VzgVXSGQdw3K84C592RP2+EyMW?=
 =?us-ascii?Q?cCxHf1U/EMlZc5NjQGo1Lee8HSIpPeMgRat7Pb/pnnsJajktpTQkmwjd5Wv3?=
 =?us-ascii?Q?i08tRNA1feop5ChpRPR/FhC3CfhDgGP6GHZgc3oBlSMOI+GsNIb4LvKxg96N?=
 =?us-ascii?Q?TGVNjJMu38nu6m6rPECgx9ZC6m+RR7H/ZpiFGbtXDUvFRKdBGod74j7oM35B?=
 =?us-ascii?Q?ST9HVOXpQcZmeUIarS9g1yFUUt7I7uhKWIR2ElAuBy7BHuwyEf0LvpzIvcC0?=
 =?us-ascii?Q?+Tat+41UX9+ncV0GN37MFfJ0bgniqFjQnqogUh2xfS6cTzSaKD41dpXi7Nba?=
 =?us-ascii?Q?0No2gE+KDaHvuUEJ1SJ4u02UZQDh6cMr3METDt8mmlWsHobx/x7Za6xsZHrE?=
 =?us-ascii?Q?lXAfpFuIy90h1rDcPdMAOM0ItSoceJ8KOV5DMunyOpeJLSBeh+7R4cvyI+cE?=
 =?us-ascii?Q?mef16BWV6bwxIBkUOygwLrqo3sAZe/MZCXQI73jXcM3U3fTbea6+Eu2KTk4B?=
 =?us-ascii?Q?CG/vw+8basaATX1RBRzRbP1CA5mJIejvHKCXzc0vCsUEkKo/6Z1SW5PX+MFU?=
 =?us-ascii?Q?3m6XoX5tFViqU/6KFds/626uoUh9lah/+2zhzETvPmq6fiQAKnpxuyT8/W18?=
 =?us-ascii?Q?jYK3b4xRuKxgbIwi0HxfwfgYtBXFb2En54QzTNzBNjvJD4pwGDXpbxHsciub?=
 =?us-ascii?Q?sEO3j7gAoZW3zJ0zTUt6dQQcSDR12gwNz7wZq+UdvrgnDpy4XKSBQpCBDj1C?=
 =?us-ascii?Q?6X/p292cFUbVqAdoPTJPn3aRnmCpGNN2exKbqknJTE/bM0D4f/uK/cQTURg1?=
 =?us-ascii?Q?YYwrXrWL6zslT+61vLaFRq0JE1yCMPGpLNpDGfrMgCpoAKXlB6UEnHzMPdLZ?=
 =?us-ascii?Q?FmP1ar7a/F2EUvmAhoYQrST5OFi57NSl5BF/oEqe4O2sFPVwwvoAdoGw+Ufw?=
 =?us-ascii?Q?U3OKDF+DkjG++SMcbQtRT8NrdmXsoKb1ERLVYyEc31W/a82pPQKmzLSz704n?=
 =?us-ascii?Q?G26FVFBkXjvt/I02n4bM7VAC1NFn7RUW0SumfruiWRqVQ06aGV4LDoaFvioo?=
 =?us-ascii?Q?C3qD9PiSusU73ouAXyR8O8wC8aHEAuwGS7MiQsgh2SLpDDy1oVq76mzOlxv0?=
 =?us-ascii?Q?/ncET0x0CzVij3cmzF9O90qHJZtiyf7lkw2gDeuttWgVcJHkSQNkkrpttZW8?=
 =?us-ascii?Q?Q2ScK+OIpWwhM/a2MWTHL5H7FRxi6YMzIulhaO+fv2oRvBkiu2cStpOibhFE?=
 =?us-ascii?Q?f+DDZqJBpXqPP0bABiqz1txMyJx/+q1cT3AA7AL3DDWZjd+Lr6G2Ox94fshx?=
 =?us-ascii?Q?yNVEa0+KeVOo3oj7nhxvi1ecxMDv1kKl8v8LBMXmobk2Mp3FUkEPcsqMuSP3?=
 =?us-ascii?Q?bnqEFS9YMY0VIP8ujVDuX8ciDWQUuJWSSsKZFCLdMRTYnfye70DoYO4CGJa3?=
 =?us-ascii?Q?tZZ1PrQZ0H6pkERPeQ773J6xc4K0ho31w5OBVNzToVRfuFXdh8+/yPnbF3gS?=
 =?us-ascii?Q?ZfKPML01lc2AvoguBYpbqYvc7ZhyNg9NCVsHlBVHrW2s?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c477a5e-b5bf-4e90-2d4e-08dcb858622c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:48:12.7046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rs4W1iqNkhI5XjaBOZNRKs75/Yuz6UjW50gl/tymK+ZDVlltehT/2sWiL5kuhh2fI11lkeoopho5m8zW7Zj93g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9120

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde38320..a7f8d53615a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16461,6 +16461,13 @@ F:	Documentation/devicetree/bindings/clock/imx*
 F:	drivers/clk/imx/
 F:	include/dt-bindings/clock/imx*
 
+NXP NXPWIFI WIRELESS DRIVER
+M:      David Lin <yu-hao.lin@nxp.com>
+R:      Pete Hsieh <tsung-hsien.hsieh@nxp.com>
+L:      linux-wireless@vger.kernel.org
+S:      Maintained
+F:      drivers/net/wireless/nxp/nxpwifi
+
 NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
-- 
2.34.1


