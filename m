Return-Path: <linux-wireless+bounces-25736-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22605B0BCAF
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 08:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2129A1753B5
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 06:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75270289812;
	Mon, 21 Jul 2025 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kilcJJ1y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A4D27CB02;
	Mon, 21 Jul 2025 06:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753079548; cv=fail; b=WEU2zaT6OqchmXI1k//VwtUcf0ZSHs9vZVZch7Px2RZX+4HaCWhcvBAt8oJ9JBvprxj/QkFiIrMvUnYPl3x1kwbEfaBAoRlGTyVUHrac7jUKH9+N/k+HZtKB7n8bWaojOGQu+uE7xetwTTJbpgP3a8eYQvn2g8cnr0bY/PoIL9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753079548; c=relaxed/simple;
	bh=t/0fw27hRtqGC+ItWGiQp0XvWuYlwKN2LZWMCGJWlIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FH2Ye4AxVRWGsxF/dAKP+8ogNcQCRvXpXUGLhHPQCIRgGcGwxOKam+Wh7xnxwzAU8icQMS8WDagQIts9oSp3bQMpXRZeWN88sI7VuybLH4HppY3x4KDIpdWOImCVWpuPItVv7oKrL7bqnJnGre9ChoqTCl+RZLup5qV0B/H/yn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kilcJJ1y; arc=fail smtp.client-ip=52.101.69.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6HEqnpxqWM6/03u5HQEWDakU++6nWqhdzOi88STlatWwLRX7o4WPXvYTBXLtwLEy9ZH2wMfOLj/jt2IH7kkgLznzKR3TM9yKA+UhVGcmdnad700yBcWhDxurS3qVf81cCwdCqjXOVKu0UZnyz7xUrhwsKxWIaqNf92pOS0Q5hzSzExfBJSINPZMkykZjtN+a//y068NUtArzpeOPPePFuaomrXx+MaPgu/8oAxPM72TFmOLuI7hDMDjJbssmHWoL53Sd2ddM0bCjMMko+nFeY1xwKNyAhij/bOF0LCnoexxljHjssp9C5/DIhqSag1Mrzfx9jygNqgVLTY/HdGAkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePwQG5utObHKY+e/FlU4CKxfO408qCQ+opWXvwZN90o=;
 b=h3xn1TiLgQSEyOOQv9fjNIy+Ev9yoIgPWiLAa5l36GMDqfzZybGtMlvgXWNndNa8Go2lBldacVf3B+g9EYVI9xDnuJgAqswyVnQOFOVq0/0KsSE8tJy2a4fTPs8LagW/aoZvqfBHuLC5sQKuppA9p9I21RetLEqGVgBbU4EZc+Gy9mm+D+AldISR9cmok330HFsgl8YVfhf95yrdEqLD3S9ZsEHM+/x/PhVBa4ClTeyqa9Hwj+5quUrWqn12h8uU326VLk1C/pQ2Yckp2spslAe4REd2V9XpDFG1rEG9PejGJLryJyJL5KrAnX58yVB3MQKGRVWPL4fqzJu7GSgWJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePwQG5utObHKY+e/FlU4CKxfO408qCQ+opWXvwZN90o=;
 b=kilcJJ1ybMjD5EJNtD/uH1iXWZXn7DwZLPpto1nMG3zXvWzvMo6vudokyR56uPcP+DKdG/VR/7un/9xRem8k/BjKdFX5HXveHMaH/fwifDGxkX38FoxCTTxM2Qg0fx/n5FoAoY23rfZ6h0rUCecwuMYamCcwM8+FOtJYgGUn1ERBM28qV0vbW4AD/H64SGxpOWCJuJqceoSwp3CGZZNV3FkSwsvh8NjZCyRs3+Lt7E5GcNMI/2VGnQKzGOSlq7fhdUJ/joflAovbh6sq2DCz6HB3qQNdglBbmUcTUbl9ER33uoYP3+ubkJS5thi4qpojxyCgsBorhB19vwAWceINzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by AM8PR04MB7780.eurprd04.prod.outlook.com (2603:10a6:20b:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 06:32:12 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 06:32:12 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org,
	johannes@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	francesco@dolcini.it,
	s.hauer@pengutronix.de,
	tsung-hsien.hsieh@nxp.com,
	jeff.chen_1@nxp.com,
	brian.hsu@nxp.com
Subject: [PATCH v4 20/22] wifi: nxpwifi: modify sdio_ids.h
Date: Mon, 21 Jul 2025 14:26:39 +0800
Message-Id: <20250721062641.2001796-21-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250721062641.2001796-1-jeff.chen_1@nxp.com>
References: <20250721062641.2001796-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0440.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::19) To DBBPR04MB7740.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|AM8PR04MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: ff810f88-06ec-4399-aa67-08ddc820538a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XQiRgDhml3Pb7RLC/SjJX7A35jsHJZ2hqQ4cuDo6XX4L2OAVjUYqMengPbNl?=
 =?us-ascii?Q?krhLBD180CdBr7tXbS6w1UgTUU+kj/AwXiAnMgx3YItJtPIoWWw/MTKc/oSY?=
 =?us-ascii?Q?NhLeMEbf9ZHQ3/bj4vPFuL9TyVXtFhy2lkritBNzwyN49+4O2Yrn+TvwAFyz?=
 =?us-ascii?Q?fX59T6l6uXpfGEW6+eds+aN/CAkoJxnEyN7ErfjSn+QcqpSo1epNgtAQlRb6?=
 =?us-ascii?Q?5SZngXDvq6GrBLISX1g8DIh+2Mzy0gds+mMvlijwijoarqkSPu81mNhZ+kw+?=
 =?us-ascii?Q?nzS0Da4l45ifLI74W8sCUlvvgu+VlnsaxxzvVGkuBRKN3VAvbAHtR6tj3hfz?=
 =?us-ascii?Q?o972zoOQO6SbfsdZekD0tyFRAHaZ7bfIqxBdPcYm0OXupAUe1fIqXKXFEoG+?=
 =?us-ascii?Q?jmF2lgnkDP7r/kuFlfQYmegDkHRJtjCUWjpNZJAtbPkZ6+pN/DYu1nEgpen+?=
 =?us-ascii?Q?K05uDCfvP15EQBVlvQ+a0phiC2KOEpn6gNq4VXyCh4fEI0j9FGUdUcZfECKj?=
 =?us-ascii?Q?V6T9T3NkJzUydpnjbIGXc/tXAVKcoAWxKukH/crKE7n+Nfug5LPTb56hi3Nf?=
 =?us-ascii?Q?MNJdu//rZM+oEcqzKvqvhb1KgW6y3QufSRmhOLSMoU/YUwEGLUZnx9HFbmRo?=
 =?us-ascii?Q?rhTa4YKdyYkvPSjUAxYu3j+W7zzGmZaTrTon08hwVzcCW6MGrwliOLFKhym6?=
 =?us-ascii?Q?Vwh6TcfXqo0H+vd5NSHvasJCOF0QGGOXIfhfMVBQyAaeF4g0ZRQTNJwTxW9K?=
 =?us-ascii?Q?gqiFXvtJLMNVAKMt3WoN9OrWPb4QnIlsc5HnBfLFnuh4mvyiKTWXocXW+t+c?=
 =?us-ascii?Q?r5hJ28hocRwbewAcjiiKp8TqrSbcGmOWELG5LkNOR24ByoZ96Swrch2+WjXI?=
 =?us-ascii?Q?T1PEkepCUcZ9uKuzZLdXehXMDx0Gv5099Kxrga2VpLqMMXLZiV9o+rL3j/ys?=
 =?us-ascii?Q?uI2N0NIu7A7J6J/M2CNTcA8b+3dpTr5UK7o+k5L/pAdbQw/nhITts+pxyGAN?=
 =?us-ascii?Q?P1PAX49m+SMsmGogUBzPrg9kLoMqKc7iZ3LT6jm17wKwlobsxSiubrBSQPvm?=
 =?us-ascii?Q?SMmrM5RSJ38x7xr6FhdLmweFLQyYsXDnhrRGe4V2QPV2y2dDgeVLPX8Rp54U?=
 =?us-ascii?Q?D8r7bQUcRkQyZGaPoxHMf7npBqveiUqSTR0THqwdVPFsp/02hMbFQgQ7XXrI?=
 =?us-ascii?Q?VKfG+JEYZVnmyB7chALUJ01Gi/vah9fhTPZzN7t4cmn/6sdEzqL63w40puJI?=
 =?us-ascii?Q?qIWEGpMjfvq4rauNoqKSlypMs/j/a/FptnelhNkSGZNHzXDKIYB1zQfCaFDL?=
 =?us-ascii?Q?9sD9OGr6HLHGgC9oHVPOA0FPIX3OUXyZITJrGzml639JmMbgDbT/lHtjwp91?=
 =?us-ascii?Q?T4WqYIFWMx3mcN1hRNFKyU4Sj9zZvzASxupZFuHadWpUQFU1+pfBwgJdnoPn?=
 =?us-ascii?Q?03DXWnRTRdYO3JssapIBkDZLfe6E2qqKhjOfKRMwK0t17fqYYK/3uw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5fFF/f1VcFAe6hsGCcDjjJ5nFLvBHwK/nw/8+nAKcPuugumNR7kLzDV7q7Gt?=
 =?us-ascii?Q?99/q0ZFDBKECKwjzVV34ovMcpM5WtSFqnFWoPI9eymeH0JKJ7+7fooDjCJRs?=
 =?us-ascii?Q?GAsuuFeuQHNzLcEr+ylBkd/98+BN+U2uD1AMHpgSP+64GOKh/cv7nQc+d8OP?=
 =?us-ascii?Q?OEmPuOIga4MEDkimj7U1k2PDdHGCKSJTZeRMIbVZmmTcALEKEviCW2XZ/cw+?=
 =?us-ascii?Q?Gcwxxx95pSZtUgjrukC8aMkgLscWoYiEZKUS0zMGesITBhkwtCXbJNNvjV/m?=
 =?us-ascii?Q?WqoolBkMKKrfdLCmW/d1dBh+sK8veCR3EfHlG0ivKN46F/b3vpgJ7V6XIQ90?=
 =?us-ascii?Q?4h8c7MvNIyg1cjhJwMWSwxNYr7zNRAL/qin+Jub69u1ohTevA6VSajceUkRs?=
 =?us-ascii?Q?45oMBQ+idE2XZMY9VtxO2Z8LRYuMyLAi4eMXYglhs8NoP7nWK3sZQ9dLsk9I?=
 =?us-ascii?Q?8AfGB7iqcQ/LXuJ35UDTQyRZ7emI0CjbUlXq8pChg8zqAmYoph1Vwd0ffaI/?=
 =?us-ascii?Q?6vcp4FrVbq/Mi2AL7GgB8VrntSqoL1YBrrydObmtEIvvKfCHl/Joc9IyHWpq?=
 =?us-ascii?Q?J47NDBGW7louEczePQjSoxyTu4VHvuKbRKj0kOuS0vSFIWFFKALGh4iXKq3X?=
 =?us-ascii?Q?vXvmgZoA2V7WOowlFkvRjXNpbmz7qpw2xjAmBTNC+zebG7IxMrRIzdyKeTJy?=
 =?us-ascii?Q?9nm3u382MzYha/yd4H0DhoqDTDtLQnsezma7Ps5M/aRbZjSA56Skm1q2cdA+?=
 =?us-ascii?Q?IN2i60QoxHk5Xk+vu+jECmPpu/UDHViLNI9PU58PSVKsLuFb4mw5pJH5iTPF?=
 =?us-ascii?Q?WR378igy4Okotimf7uaGfc1FznyUJJJ7TnZM4/T8s+Lvt/tOKwVsSYU7kISq?=
 =?us-ascii?Q?2iUE4GFylJb4pzIW2BmRyfbwfXxt1Y/dcophlX0LJAAW7KBy5FJrIg7yWVGB?=
 =?us-ascii?Q?GZCECIOHSRHvoRMbIaFMotfIGw0oz+HZbAH7Hl/Pcy08TBuh8QP1XKc46EY4?=
 =?us-ascii?Q?h9VcXh1tN1XGZCSqdTAixPoBdofGB+VVJt9xEgvXLUabNg9okTEiV+JANMyj?=
 =?us-ascii?Q?SOhteNRAL2WondDRaNv4H5O+tZU9e8qf6goF3gYfpAI4lmpl2Ee7cS6tIU+N?=
 =?us-ascii?Q?lKrR5bO+Hl90an98uaRGNtl91deJf1VOH0HFnLUMmEQLgkK8DHcMSOhyzGhQ?=
 =?us-ascii?Q?9c+0G0QAyLTQUJ/wGNVnNquwsjZ9MEDF3DmeMmj23c3FakLgDsnIUdUgG9nM?=
 =?us-ascii?Q?wdzyMkHmLUtvG9NqT8hduj1t9Zax+XhbbrrS+H1NVUlnauRYhO+ghzObSYPE?=
 =?us-ascii?Q?oOSSUKbosUIuGJxqzqP5kDtNAHJngSJmpAKWbkQQXdMr7uBj4dNAnAIOiq2L?=
 =?us-ascii?Q?c7x2tWT4IIGqbV/PaYZ/wTQH2Hc7Hw2e4twO7qHUAWsllL/X7PtYYHAWxXEH?=
 =?us-ascii?Q?WNwy7u/L60goKY1CFO+RNUASV76okz9SRUQJEX5tSev6t9+R5BZi+UxLhCJF?=
 =?us-ascii?Q?Y93Azxbc/wZNBuXiqgIVrTiHWERmUJv99IV0eVzWj9+AWUonTuGjLlWeL8sH?=
 =?us-ascii?Q?+hYr4zKD574bNwvNjE0XnEs7o8RK0FC5t6AXY/JF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff810f88-06ec-4399-aa67-08ddc820538a
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 06:32:12.6119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9bSHTgF+8HspdK1kPv3T81xy1gJksO5uaVl1Wsls3uPS1R77qgGvcUkvzMrBYM9eodAR6QOGGGhJrSQDyZF0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7780

Add nxp sdio vendor id and iw61x device id.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 include/linux/mmc/sdio_ids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 7cddfdac2f57..8446841d62ef 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -115,6 +115,9 @@
 #define SDIO_VENDOR_ID_MICROCHIP_WILC		0x0296
 #define SDIO_DEVICE_ID_MICROCHIP_WILC1000	0x5347
 
+#define SDIO_VENDOR_ID_NXP			0x0471
+#define SDIO_DEVICE_ID_NXP_IW61X		0x0205
+
 #define SDIO_VENDOR_ID_REALTEK			0x024c
 #define SDIO_DEVICE_ID_REALTEK_RTW8723BS	0xb723
 #define SDIO_DEVICE_ID_REALTEK_RTW8821BS	0xb821
-- 
2.34.1


