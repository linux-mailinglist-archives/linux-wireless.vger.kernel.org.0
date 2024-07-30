Return-Path: <linux-wireless+bounces-10648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 933CB9405DD
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 05:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D98A2830D7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 03:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0EF15699E;
	Tue, 30 Jul 2024 03:31:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020135.outbound.protection.outlook.com [52.101.128.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BD6146D6F;
	Tue, 30 Jul 2024 03:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722310274; cv=fail; b=Gbh2G0oVgttkpeL3ld588xkUYG/SS2iqiySz3iemN3A3grqQH23UFRUDsmMhOuPfNWh1xtpXUhEAcs3adCBk6UjvBZ8dzszCB8/cG61/bpHhmwgVgNNGCdVE90ZxnCi6NbecrptfELNXsfmvwNISuO1ILlVWVSLvj1lkvktGOE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722310274; c=relaxed/simple;
	bh=ktRJBsGGjJAW7tpIhCoDO5wtOo/XHcwQyHY92weMLU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GGd9a+ki/PF55IKMNB0q3tWPDKpY2G5zpAVPQYDkKl1XkF5gjPeo5vInjexiGLjYF2feyB9Yri3zVjfHCFQvL3H6n8hAvW18gelNFxQdipv1jKDWIEjFF3OWdvl36AuE2whvskyJIUX8/aLanLC27F9naUbH5XM3dzCBnGf0FnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=52.101.128.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3bnBSkeUwf0MskPZohyFw8TdpvXKzW3z9Xm5nboKHRZ83PtRAPLh4d1nDpxiUD9sBCbqX+8FF+taZsMe72u/ylkD3N7LEurTw5ZCRfxwV8yt5QVkD1RNYBpXvyVRWX3zdXwMv6vBwfmjhbdE8LfSFehW98Nfgjmw8XCOWJxsBJzSHp1lHx+wwYEOC75ofGzkt3flv1SsbwgTtswtgBupT1VsGG/SKZn3RM4MLEAYeFu77SqI4oKOpFICTSI7uwV95z8nSCXwqg1NcztSLZ/b9z1sfGlMZub35U5DCMfWBJ6j9mcmNz/YVq89Ru+YBFdB9anuWhrWiYTtu2IFLG97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6zTTdkpi6ahsF6jVbVHnvRxzFTyyYnmY/2NIU7IZ6g=;
 b=NcP1Wm8wg0vE1Ylj86v+TJj8As3AAKNg0tUVRNKOBSlbdAo4aMeRXCOG3UI3MUAKg2UdiVxMpMavKsHpZFGX9QLsGBbKtqbxbGXOHtNEMb5918jnHV9tPgnnoCO4EgAXHK7NNSSdkHFr08Z1XgBbWtX8o1NArPMEJF6aRMc0kep9juO5Qov+Xa6UoFoCOQIjcHAxcHfIiBHbWcFJqUlD3y3gnuD/d4Naav33BZSa5SiQrwIsUPMOfkO6/61CgzXy6OoCAZGB8SIKjusUVn52x7v3xZ/2BP3y66F9sbMunFNqwzppnyjELq8cHwTKWOmaDo89aD6horGRVZguFmqGBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYSPR03MB7705.apcprd03.prod.outlook.com (2603:1096:400:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 03:31:09 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7784.020; Tue, 30 Jul 2024
 03:31:09 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	heiko@sntech.de,
	kvalo@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	conor+dt@kernel.org
Cc: efectn@protonmail.com,
	dsimic@manjaro.org,
	jagan@edgeble.ai,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	arend@broadcom.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	megi@xff.cz,
	duoming@zju.edu.cn,
	bhelgaas@google.com,
	minipli@grsecurity.net,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	nick@khadas.com,
	Jacobe Zang <jacobe.zang@wesion.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH v5 1/5] dt-bindings: net: wireless: brcm4329-fmac: add pci14e4,449d
Date: Tue, 30 Jul 2024 11:30:49 +0800
Message-Id: <20240730033053.4092132-2-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730033053.4092132-1-jacobe.zang@wesion.com>
References: <20240730033053.4092132-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0122.apcprd03.prod.outlook.com
 (2603:1096:4:91::26) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TYSPR03MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd3f42c-124a-4ee5-2972-08dcb0480da1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x+4YdlnXem2Ut725KmYXgPzsUiYn7Q9C+7knHQJpz0R64nrEStvn2WsiI3T7?=
 =?us-ascii?Q?IIN7KojAs3auKNSYtDqXoz0mIZX+oP6LELt6CCJc86PH2RK2/j7cVrVYLpYJ?=
 =?us-ascii?Q?1vuYsbyU+4egRwwiyR/Un3gjzHQliG2hffE9yW5ajnZOHC+4W+nbtd4TDPGv?=
 =?us-ascii?Q?ir3//I/JUh/4/iVbvJcFVWhoQwQokesTcQ7b2YZW3TKm8V/wltvokHS5dr0A?=
 =?us-ascii?Q?KnArZhibQogU0BC0lVqFATRMIsJSjMshypIyGLAfaAIUg1utvIU3Pl5qXttu?=
 =?us-ascii?Q?0dgQH6ctTXKFD5DZMd+7FaE3et4By1RRzYBtcIUDEgZwVpwN9Yc1iF4kRAzQ?=
 =?us-ascii?Q?57rrveIop+VaCvoVr0ggMDT08T/VXmfgFkH5zLUD9oDUb9Ys1b/nBZeFiHK2?=
 =?us-ascii?Q?xq3eUSZs+WKmKq5zJR/Vyy6SGFSkqHx4Ys6Slphgz0XYUEpoHqOoVOk8Ducj?=
 =?us-ascii?Q?dOKdjvmLCuabIjE1grrqAm5bPCabaa/2lpRELlgXNCchheCunLG0Knr//mE3?=
 =?us-ascii?Q?342ha2szRDzLtn49mUl8VfZN6UHZIxH7KzhWuDlagqLOdR/LdrX/dxCfk/UN?=
 =?us-ascii?Q?J12l8Q+SUjqVDs65p7gou8OojvQfBKloQUzqtCL1aD6c0yfagmFFReAtu+c4?=
 =?us-ascii?Q?Ny+OtMSPk1XfGgbvAAoInC6RM7xYJSIM0EkU+gWqL3kqY96M52nDPpTxfFfg?=
 =?us-ascii?Q?4tTVayfDwoySjo0Zjcp+QIRLsbXnflFD4ZIb5sM6c6MR4Lpe4R9Dm3jeuRSD?=
 =?us-ascii?Q?dfQT7MWR0tS+aD8N1aXgr7mEGs2iBvxdTpSaPCKiuygWO/4dZfQWkGl1+30X?=
 =?us-ascii?Q?PYuXFy92ZLL9kzJ8dbR+QE+IgK0vv/fYVHxgBvNN/SeW9oGZ80B2bvd2/1lI?=
 =?us-ascii?Q?814c1H9qDjnEhaauZj7G5v3JUfkqjoI0DqfvESttslNbLu49jVw7BW0dWtVB?=
 =?us-ascii?Q?cWO8D9lP+LSQKH7ZHI3zgIe2GYM8kGoonalAAqM9MUXBA5iLMssc6zBnTxtd?=
 =?us-ascii?Q?z5X6kwjEZv17ub2lWjyNocl+dcbg8YKMpYIydYwAdeBC+RNYUBd1GKAZlVmj?=
 =?us-ascii?Q?66CjeQa8ck8TyxnoEQvH8jtcL+o+9izL1TZ3bciC2W1AIancnYY68KicRSr8?=
 =?us-ascii?Q?Xzl7wIwEJThTRbHZiODzW9or8jiA90bwqyYseENscVeV2taAZ1FahlwXb07F?=
 =?us-ascii?Q?pp5i4wzPcAxulUm0XSJGIXInJlSsFf9amJGoP0O5WPcixYki5NyPj68XT6HL?=
 =?us-ascii?Q?APhtzIszt5l6lGKn2/KpRv0RcKrnwKhjJ6GxzIQc8JEOgqmfqvfR/OzOPpMj?=
 =?us-ascii?Q?xLqDjNPw7XGg4MkuQ6pOnnwb2fezkVVF7fig/VQQdHl9W6JIDFblYB6YZpfx?=
 =?us-ascii?Q?NYncNfdSU65vGVnni4/eTYIaq60SeoebZ/5810nyVLXR/IJz+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q5k6XdVGi6wKR3AKkLQhMrpGMcEQ2gRxpH6KONYZrLOCkCsvW5Mz8Y87Drf/?=
 =?us-ascii?Q?oTVgNYAJWz4A2pNJTTZyA4FknLw24UULaiSg9Hdak7l5TL3wQVwIG1pPa2aZ?=
 =?us-ascii?Q?5HnNJAo3pPk1bEsrAHqjPES45z0Ztukec7HpYD7OoXSG2LKsjO0t/+27747d?=
 =?us-ascii?Q?1fZE5bY5FaP/k+dwop7xGshRfmzti94rDazaCDrkICEF7Bl+bjbK7Zep2TeQ?=
 =?us-ascii?Q?a3k4PaFnPKw1ocs/lmy31xoocNN+gzSewAgo9oMrDn+JvbqUOoPvHNrhnKxA?=
 =?us-ascii?Q?KPCoTWqXmoQhWbRx1Pdd0EwvwH9ro0IYREoy780HmDRucG3UTXb7HtrXmVO8?=
 =?us-ascii?Q?gGXzkyvDec3Amzm/DI4XDTudyiRGT9uKxKHVgwzYEVpr2b8fbI6Nj2Kw/7Xv?=
 =?us-ascii?Q?xYYv2dIhp+lYuZTUNsp+HldI3+ubYkR+4gFR85CFrKwuIqxbxVXkHtZMFgfk?=
 =?us-ascii?Q?Z91WT7F9mZD6W47eYoLPk/jDhxlFhFddc5Xey/30d/sa/itTL/6WBlfwvOiL?=
 =?us-ascii?Q?p6Mz8/xfmIzy1pACkqXlRjT34EDSoQpFx1HyXs3+k7M64fbgGeI9bNXlgu8O?=
 =?us-ascii?Q?2LB1Rq8sB507cs8KT5TE7MlporruKdDMHFM9j/EP6d3hgOsbQH9Z89DNexSi?=
 =?us-ascii?Q?JOQfVr4LsN9d/5QrXXJcfYU+7L1QZqMfJzgwUIYLMlQ/41rfvJvfmTNyf2xL?=
 =?us-ascii?Q?y2BgpxXHxSPwQ04ycijZQ2O2z6zR6htRbpLmG8m+EC8TkS+ObARrpGzSWHDS?=
 =?us-ascii?Q?cIMcTYLIxfazeZ425UZzLXEBMI47yjyQJKdktur5xyl4fFnwpRk2QPtIXQHy?=
 =?us-ascii?Q?gGQzwcOWt1QgU4LqdPONttaVd2YwOUjjT5Sf+1x+INcMJhkd2zdbHJeyuZao?=
 =?us-ascii?Q?5+LqZWf6dcWL+zDkmzH9SzqltpXObmAU/G1qaGHbYqqBI7nTIn3BmkWK8WGq?=
 =?us-ascii?Q?awt3DwoD7tLC8YlACtT8/0579IlhIS5kA5WqfqZaop4zXlfzwzLV40mdphXy?=
 =?us-ascii?Q?3GcM/u1FjUIjDTlZ58tRF+dyOhEk3SU6v0/ch+Aj4ZvY0JprSz8TQ7PHzE8D?=
 =?us-ascii?Q?13idClFq1j1z1RD9+OqR2Hhkorv229RjXyQeZiFen+yMb9lLV0KGAKNrUaTg?=
 =?us-ascii?Q?ivDNulAoqUMWlqlv+n5eVIcCv38CnRNIkHv8paCH59O8xjhBme/s74IFUCLS?=
 =?us-ascii?Q?FpZ8wJNDV9DIDpY9pO6wbN+l6pJcz7P1CfEVVADfGVdbqrR/a4SC8I+zxYiV?=
 =?us-ascii?Q?fvI339E/AvdvJ/1lh0Ml9+xzs4/nDddTMCmFwZhtsUfWYn3RLRm+fNGPPF2G?=
 =?us-ascii?Q?w+58YWZI//HJ8c17iMSRHd7pJG1kWPM6Y3+15j86Ns4/eQbCylYbqrfXUNu0?=
 =?us-ascii?Q?Z7P3KMoAZGk1naWU9pQAr0dB4ooKISxDPkhOgRx4KVVb7jetdFaTitk0zkQT?=
 =?us-ascii?Q?F1cb4i2exXYyp5DCyvsBRnf8h52dsZmAoTPpcjTdKUUC9Z+BNge/xa7p1nWv?=
 =?us-ascii?Q?FKHK1cMjoO842HrlMharMq1EAhklTxb1ZlbfjpJ77TNt6bHZePwm8LWV3ndG?=
 =?us-ascii?Q?+gMglQGyoTrPbAaYY7Hmm9FnXoLTjHV54PvGP4ay?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd3f42c-124a-4ee5-2972-08dcb0480da1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 03:31:09.4542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +U3zU9T0BHvsAPUjBUfhWFbaoMbH6Rxv268ORjTPpAEcLcKMBLuNJHJOQRrSSVi2Sbkkc9v6kPDZIhDU0dcbKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7705

It's the device id used by AP6275P which is the Wi-Fi module
used by Rockchip's RK3588 evaluation board and also used in
some other RK3588 boards.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index e564f20d8f415..2c2093c77ec9a 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -53,6 +53,7 @@ properties:
           - pci14e4,4488  # BCM4377
           - pci14e4,4425  # BCM4378
           - pci14e4,4433  # BCM4387
+          - pci14e4,449d  # BCM43752
 
   reg:
     description: SDIO function number for the device (for most cases
-- 
2.34.1


