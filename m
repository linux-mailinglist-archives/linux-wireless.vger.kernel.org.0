Return-Path: <linux-wireless+bounces-13306-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8BC989ABC
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 08:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B3D1F21BAC
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 06:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD23188710;
	Mon, 30 Sep 2024 06:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YFNCmXU2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EFA16F8EF;
	Mon, 30 Sep 2024 06:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727678333; cv=fail; b=uiY9loJnolzMX9/t/HTnBvB2BC23sm3z/VJ6/yyvmZp4Rv+QtwxE8dkrpFLrsIA6xM0fPWXouejInK3CtgdoeyaeMF8i2v9rpC9wWT6nLvkDfC/qSsWR84V/5cTNNHbQdqyIiGSMfcr599JQSgTaqEfBgY8QFfSgRXJrP+z6RGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727678333; c=relaxed/simple;
	bh=K/PWdCIOFjYl48F4wUAEUoIRnXjZgwJwIzMptF08IcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tGF5dExvZYMmD3h96RYJUJAzvey2+FIHbTJsW6OW3DlhVCNFP9q/ZGqN2/wn5gt44+ZcGywQRyGzs2hj55uu6PSC1Z1VYNYeeY3zSvXP9bUkw//hJFyb/gpp6WVOQuJ1E67KnbBFRMDGaLim7dTW25UWxYnpHIgbOhb9ppqRzEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YFNCmXU2; arc=fail smtp.client-ip=40.107.21.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiQ+ebtM3l7bh5n9uFdOfByv6eZJFTQN6VZSp7Wjrj9VHObCbXADfaRIdO4VobDd0iMc/ZSFUv4pD2+bHRruZJHPbV7Z3RTxnQNHzR7+cVhQteS0z9PWQgr3ilRLNQYNG91K0bhvCFC6LB+lD1mEstD+CESOyy4lBCsAaGbH8hTZE3/A6HlD4iy9DHELExaX/IJnFArpWEPZafGjVhDhbPiHSrJrnjIl2bWqrua2Ve4JkIPdvPBJEEgEJtbhBV9VQeDOGpYpIUXpuIk/23udZxm6ih2NgiTy4+XDe27mFCbSUzRdz8w60p+GMKB/cp4SIaPaT2RIW+qkk4adjVanpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7F/5uCs4d57RrRXy5qSG/FWyRdjhvfQpSinluQft4I=;
 b=l5i8j5tTHQTOe9teqZT1thWL2UK+t+SMlTbgGr31YrUNFRt/S3cO//rA41/l+tRSdr1S/wSZqVFlusHOa3leFo3vdPc9AHazub8QjPO5X6Fi+wQu4e/GE20zQMsIFOFoyTwU15qO1mpxAAjtHr7LCuvClucLurWq0/bxgksm0s0qoFl/z86PZPpXEw+icFGxRhELXzGxYEWtr0Ilb3b9mMPoEl3CO0G+MpC1WLT6dsHGdIcGxTf3Fr9N4cJSIAiz9rTNEKs14LHXAlPO4me5KjfJCTXN/u0YECH9DZQnEf/NeUV1thtbN13KbrungdvM9M0CQery7kuyzFV7iwpa7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7F/5uCs4d57RrRXy5qSG/FWyRdjhvfQpSinluQft4I=;
 b=YFNCmXU2k3JxOt9tbaH2jbZ3MmEuR1q6dAwF370xnlV0nT8NiQNnsumFSeke5khz0RPqm2HJp+NfjiI+Y8TBClsTNa1J+6O08MOtxijbsxtXa3SxzjsqsWVlSRiTxGJuvT2HGjSVwE/lP1cWvWX3H6kS8OvrBUSsmFDd87PL2/O/FcEz/8TgQ5dYRJVrsF4KG7i2BKBnom+DuPMnpqvATT+WB3IjVwOsF5odt+hA6VlqquOZc4yL3ByAGAOJRd1amhUAp4F65F2elVpD9RQVr+OEMyLAiHIk+2HB+BeN3BEJ46YnVJr/fJa630+NzpBP+5RGE5JRB68sGik2fpsRUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9154.eurprd04.prod.outlook.com (2603:10a6:102:22d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 30 Sep
 2024 06:38:30 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 06:38:30 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v3 20/22] wifi: nxpwifi: modify sdio_ids.h
Date: Mon, 30 Sep 2024 14:36:59 +0800
Message-Id: <20240930063701.2566520-21-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930063701.2566520-1-yu-hao.lin@nxp.com>
References: <20240930063701.2566520-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::6) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|PAXPR04MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b8d190-e32b-4ea9-82c7-08dce11a7f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U2YUwzOnqzinWFLmqaw+JGJtWv9Ge5vXiSFemVOY/bxhauWrzVM+4N8EJrHR?=
 =?us-ascii?Q?BtBzjbVDLXobERcTPPxY55k7sMuDw8cmxB9VPKEs50bvspmIcP3HSypO/+eT?=
 =?us-ascii?Q?WxyIcZpM/ZzIdDqH7YImx57esGsHaIjiZBNivErEalVdfhmVqx6JrLUM5AjT?=
 =?us-ascii?Q?QrIZ62il4AVvHPbrfAJgHHIfo13J8WCaYfjmyuUM2OrIccR4+x09HAiDTeWx?=
 =?us-ascii?Q?Xovmq7ihJmc6J1tgdPJZ6IQKkRxAcWJziawn2Khcbwuwuqjri2L5jSyG0KSA?=
 =?us-ascii?Q?TN10m7Jj4SARo4XGp64GW/0JID0nYgadQ3a6+4X02ylVPkSbnXFoNca/ikTY?=
 =?us-ascii?Q?wahF2UyWWurxYrKp/HVpiADv3PBrJTaXrb/oHPjHmIUsznUwQMvIZAjvX5kl?=
 =?us-ascii?Q?3F4FBof3bP/fNxvn+xFDfGnvBBMUPPhC1nH9ki8fvoXJJCOpSNPpTmF5tyg5?=
 =?us-ascii?Q?JqXsuUFJKtdiCFxnoIf8wXoUGCOduRunLgV4tOfmY02t/AQafoI038Vy8Pp4?=
 =?us-ascii?Q?g4apxmYM9QVv4S6IoqyUsPYJqzsmnvdsDjeYUBc1MhiFv66EX9+/zmCOTDHa?=
 =?us-ascii?Q?GDx8FFkYt+7p5oIxyAcWsPbb1MH0YOF8TxyoYhAvT1/P5+T3eCH63HzrmjNU?=
 =?us-ascii?Q?6G7AcWDAcKVv3loOJHIUMpTEdfIXjpuCCy/0FFJ/nHA5ZiKUelxwdNrKqe+G?=
 =?us-ascii?Q?fH2m8PByt0vb/p9PrYPYGREx0ekrcWFdzrNHse5mTHq6zkNoeS3cx8m7ttnS?=
 =?us-ascii?Q?GgzrLyOpfddR23ito2Zbudh75LLlaSTe9wHdBI9GibZB2B5xplOSKI1+P6YT?=
 =?us-ascii?Q?Vu8yNUti02bf+3bNP1AhdwrfonkH9Roat+CUq04RsSUjKfOK5qg3a0/I50hI?=
 =?us-ascii?Q?xlfVjerfE30SYZ4OvSzWFmGrOQVZBzAHfpMhb6Tm2We54Blyr2NaxOiWO77B?=
 =?us-ascii?Q?TWmAn/K3DRKnS5hq93Xe8x0SzkcUpQls61xPl3Xga8bkRI0buxmoPp7iqlC9?=
 =?us-ascii?Q?42poFpFb8+IVOR4PPJV+1yzRUPt3OaDXIMHOQ/2BlBNqW3vCizocMZ1W5qMP?=
 =?us-ascii?Q?eb7in9BQlnYtsVtsc+75/o1Mm8xLBDVCKGVk2sUZ24ISIW7FgYLZpy+29qsd?=
 =?us-ascii?Q?r0SAXxk5nZxht/n0MBZw907EngGBuiWvRrfiq1T5WFgjYr+lLJvtrpEfcUdZ?=
 =?us-ascii?Q?/QWox7er3e6nGTXbMMkKNJS5gNSvj4WXq5sKhXr2yoWcZaTHVjd9Vvn8MUgV?=
 =?us-ascii?Q?5iEImNmfNYc/AkU9dVS3CnFNEYfkbJzOsytFfajk2PZeQNKQtVWEPekDLi3J?=
 =?us-ascii?Q?GQ33WLToLxkqfdDcdXus2T3Et4bP0RDs1tsK3/BGkFx87aIRJRar50msrVLq?=
 =?us-ascii?Q?GH85LFd/St1m3HILLDyvxxX8gh4v8gN2MdOa4TugatFL+mwr6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QqOIzQGMlFnOl7bjiC5P1UhrmbycsjytoWuZoBtWUK15d2HTnSS11f83lRWw?=
 =?us-ascii?Q?gK0jadjMjmE0v/nvc1mBvRHRq1W1wJgUmtu0Y7rRaRUUP/DiCrZ6FuMlC1QK?=
 =?us-ascii?Q?5/kW0SxaAV/Pc4cmL/j9VvTn3GfhW3HBOeYeeYORK57h8ocsmMjjQutubwmp?=
 =?us-ascii?Q?8RsZ7Eot2oTjfVrYqReLIAruxCRXunSUAaqTkeUaj45hA17zhs268jyc60u2?=
 =?us-ascii?Q?KxD5ShyMJbX6cYYqKiHMJjJci+fU1wPkyUvilFtkXqnGkrMwJlQw5cltv5Zj?=
 =?us-ascii?Q?3e/XypEOOZSg6kYgONGg617XQi2xsqMZBaGCpkbySnloTiDv4ZRoO6QLYEvf?=
 =?us-ascii?Q?LxIH3saE1AKFLVCqrFDyxijOQbYGSPkpdoD3OtPp53rG9sSgT0/ypqDxvvlH?=
 =?us-ascii?Q?xnMU4mQDOykSjRcrc5Yv+rB3XEqYybqKUe4s8uNCvGrP9Pdk+hMABLotcDyo?=
 =?us-ascii?Q?hUQf0zhzsyBn73pDD5nDxUWDp7LHFHIf+3DlOeh6SWrVoo090HxBAQ7cMJMn?=
 =?us-ascii?Q?6VSvQe71k6YrwRgx8vOHJhY82kh5wDb0snOpyOvXQ35s2gqiiJLAnAqmESg7?=
 =?us-ascii?Q?eKm1pHvWylVDyysnHjSPsq6Fk130tKqBnPPrLLiWiqL1dr/ZHXlqEhTbIWTw?=
 =?us-ascii?Q?bbnPKojSGuvFkkVkjGUJ6ZgB5peKMmRd5PQYmo65jtMTujJWnlAshBD4Nilr?=
 =?us-ascii?Q?rRrAWyvBBhOe24XmRdg662yKEZcO9YgotnZyyp8BxKPt1/nQvOs+lBp80cAG?=
 =?us-ascii?Q?+21aEZjc99Lfb2gwJqZbjaO+6NJWZiDSX7/FeM2TV54yPGabsqnTCthcBIle?=
 =?us-ascii?Q?8YyZtRw4nkE0EFCZraNL50S8Hj0A0CLGphfOVWwDLp3fIdADzkljdnzuaNm0?=
 =?us-ascii?Q?XUId4wF9lsJL/9vdXM59BNYYNLMi7ITWVPoJTsq2dUrPlK+tfq3Bn4jmEpA5?=
 =?us-ascii?Q?d3D05xs/m03krVx1OutUTPkWwCjrk6EAK0AGpe/FpbYoRg6fFjkZ4sEWeZ5l?=
 =?us-ascii?Q?hYqxBsBCpCjb7eFDjksjH/NixQZc37DQD+7UdbsQiqFQU0ZsVzWqczTPnrEn?=
 =?us-ascii?Q?yHhY33rxHb5sKNG1WJq7qy7Ms9LsGIFhsnCl6TPjUN8RvczYNA3jAUa9uenJ?=
 =?us-ascii?Q?ALuk6K3stYE2tXLQX5qqs8VEl0W4UYwvBVlBYSrAgrHnxc6bAyUq7HnxWTBl?=
 =?us-ascii?Q?NCstTFoPJrmeyDtml8Ri60Pb4qYyr9tIataoh/xfMeGswsQcJz3Gp8MGJjTc?=
 =?us-ascii?Q?PFm5TuRW2GdkQJlOYG13JDzHgpOnbZyRryYcXPq5LzZ0Ex2Hln8X5iRIh5Ln?=
 =?us-ascii?Q?EWWxjh4asPQhBNvRCQvQscrMtvcMgw3tMYDzVuvN8bV9YCAtxci3PvK01jOC?=
 =?us-ascii?Q?8kUe8nSRhnNYSLBJsTbe8YP+Kio2rFkXCcrlAInuzGrKwe6WKpiiIzaDBRJa?=
 =?us-ascii?Q?P7xRmdUkTbtyZMi7GZm6CbPli93zAesaHwTjHkSoOjovBeYs1Qf8NwhrL7nx?=
 =?us-ascii?Q?InPt3YMFdu38coxN3/zYuUrzDN8cHyadFAIUasF5dVhpxMHS8fJuo0ptI4sl?=
 =?us-ascii?Q?VjdOEX/GPI1eIVxCpPk3lC4gv6jw/BEjsonIbCCS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b8d190-e32b-4ea9-82c7-08dce11a7f82
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 06:38:30.7939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgTNlU3KJfBC/1TBWXv2UfMXaewDfkyLWjxU0+eMZT/rMoCqW5D4Aebv/E7rNivD77d6URSIyIjMG4sX4xjvSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9154

Add nxp sdio vendor id and iw61x device id.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 include/linux/mmc/sdio_ids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 7cddfdac2f57..a3bd88383c31 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -115,6 +115,9 @@
 #define SDIO_VENDOR_ID_MICROCHIP_WILC		0x0296
 #define SDIO_DEVICE_ID_MICROCHIP_WILC1000	0x5347
 
+#define SDIO_VENDOR_ID_NXP                     0x0471
+#define SDIO_DEVICE_ID_NXP_IW61X               0x0205
+
 #define SDIO_VENDOR_ID_REALTEK			0x024c
 #define SDIO_DEVICE_ID_REALTEK_RTW8723BS	0xb723
 #define SDIO_DEVICE_ID_REALTEK_RTW8821BS	0xb821
-- 
2.34.1


