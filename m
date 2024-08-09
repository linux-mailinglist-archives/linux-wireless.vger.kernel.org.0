Return-Path: <linux-wireless+bounces-11218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C4394CDE5
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8821C1F22B28
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688E419FA72;
	Fri,  9 Aug 2024 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CaSPWbaW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011065.outbound.protection.outlook.com [52.101.70.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7711E19E826;
	Fri,  9 Aug 2024 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196895; cv=fail; b=EZlLDNztiAZOPVA4qDdESSBzS627lWeZN5KOcRhHeSqapfjKD/Ksmlorea5kAMnRU5Di1sdIFqNXy533J+OuWkLMH27+377X8pq6pcQuRNR9kdKQ/v8wQFcKvg4teCH1B1eTodGvFrBKMsJdlratKSsB6pgQrbneg2HzPUTCiF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196895; c=relaxed/simple;
	bh=n17QDADJXrjc3wuFOUIEeEJWZL+PpjoYbwMv0BO0H3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dNVXJq0FKi4DKUiv6eL9/uW9TEhzVUvB8EhczHtA7Kk3zOhnZ4MNdZ4vleDjtyDtzLFOLDdleov9AyO5+ibmqsyEkrk9NWQtgHGiFoMCqpHTdis/HEPKdAcvwQZDwlmaW/ETbxCyuzAxOb2wYPA8nHx3lgOQqto6dLiQgsoB3fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CaSPWbaW; arc=fail smtp.client-ip=52.101.70.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UoxjDra0kwceiVxKLsL0WoyqmVzNbdjEEfGw8GTNjmx/+IvVHusr+8oZWvj2VXrrP//jPfNUizH5+4WqbvdN78l3n0hEPrGU7ASb3M0sOd4Lb3/UIOPitE2f/7QOE0jv41SlDGEIniRmJju8NIxjcoUULNoIPvJfQJsWh8QecwVykYqwzmLeFAD1wplftKBR6gKgPgLC4GgG5Q5lSWLVMKHrXMTj4x9ci6M90TZHkzri+yXSaQ5fMQ8Vv2LpxNEFfExm42EGZnNueuek+RAVmsxTqM2WBGKgn1+kM9BfEJehH5j1/5PVhaf202AU3EYFMtIZ0DvmnnEkYaGcUCRaPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7MeuOgQrbSP0BuVj0rjMFxdtU8YgEfcffhYnh1ojkU=;
 b=DUpUA2ia2xppuxw8nSNWAcwX48cZIngt31uNtniNw+So7Sh2iZuHQ4nasjFF846aCou/JnAOiOHGnKZW0f9euYjq6VcIN9NvMO72yQ+vpVv61N+CQgVDXpIs6xU5768nSa4rFpYZw+S7SIRfrtk7QU014WtRcQ36SFHgSbEo2xwjHq2ODjLJQFHt7lCioZjval7lN5wsZKZ0wRSb6HC7DkZ9TTQIdO9OhKUKJdO4uHMvkLTFwQnjAdXYEYCkzBAYAz1Ow/tzsoe3TfFtVWaI6uoP4+JNA8nm/FPLgLdOwcsEUf+lW/rGQU+7nJLs0qwfaEzTb+JFChSppVamuQ/CLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7MeuOgQrbSP0BuVj0rjMFxdtU8YgEfcffhYnh1ojkU=;
 b=CaSPWbaWb8cORNfbEgQrnSIQzX5RTx8eUNiuhUZrRaDTkjKeHIfu0k9BdmyMdiyYbnZMbM2/FtxmLp5ZyrgNjqqpkAbxY9bJKA67dx5WG9HRfXSo7u6PAsNdcDYwt8Xz2jnwbFkpdVCboxgwLZtQAdsB/5kKjEOutBtynN0MJShynFSI+60ACAKTpXLuszmJidiPAAI1MB0x1ZEHmzsIu2YGWWdQ0KlRkUGSI61YyC/9Yq/b561D01rtKKGPef8N3AFNbZdpDVjGJ0otoXkE/yk2tiUgUCOlnpT4whF5z9GPkGs3myNrGx0JMdGI8hzbdlBtzme6pEJLzZbZAOyA8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GV1PR04MB9120.eurprd04.prod.outlook.com (2603:10a6:150:27::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 09:48:08 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:48:06 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 41/43] wifi: nxpwifi: add nxp sdio vendor id and iw61x device id
Date: Fri,  9 Aug 2024 17:45:31 +0800
Message-Id: <20240809094533.1660-42-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 82a8b469-f040-4102-eae7-08dcb8585e43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|52116014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l4iqm7iZP0FRUrvJMtj8bAoV1ZI0mvGyFKN/a7E7si9WDYyJBd/qto9880Sd?=
 =?us-ascii?Q?EDPPXrJYBBl2gVmJAE/Q7f3YSvHHSjG37W0hy9ZWbkjfvP/duvo9he+vvrWI?=
 =?us-ascii?Q?3QlRL/vO8mBwxpGataMEYzEx9Wems55v6O5xAFrOjWDtezs8RcEx6TnRMG+O?=
 =?us-ascii?Q?Z+2/vHPZTz75vf+pGfBbFMWPfx+wc9UffOesp2eLGr2wW69I/d8yUNgFzVXY?=
 =?us-ascii?Q?CKXxsJk254+CUSKDO14iVc34wc7hiC7uFN8kBaa6FxOcX4Nn1VjJyCaKkGVG?=
 =?us-ascii?Q?9cMv4bAxmbUjepSUqvojHVQMRQ68EbqZeHwbZ4Kwhn0f6iI0+k+5eBzSO4Su?=
 =?us-ascii?Q?lmG04cGCjLOXSEAH4OU2zof8IekjyJO0vKqE/xOcQk1jXkWtJC+UeErwKTXP?=
 =?us-ascii?Q?hU7gnrHBobsirMnCgO4D1A3ik3MauPQ4t9JYF5ocA21JAbfcpoVMCohyW/t2?=
 =?us-ascii?Q?ZuC00uIlL0X733iwJrWt6c1xegvvR8WNZIhmoeo026KRpPXv/NoxMyXI+WrI?=
 =?us-ascii?Q?NFLEdErATMKuPXIOAHkfhcucGqfLOZCS4MhDskyK6KxTU7mYyXH/NMAD1xF8?=
 =?us-ascii?Q?a966Jk2K5e6qSogE8s4T57LygTcvqom7z5Ci5HnahOQyD9SYmigkGWrI08rP?=
 =?us-ascii?Q?LgIy2eUQMqRpXwV4cp4gHksnxGiZngvl/cO2MAwGska779IY5PlFxDjQWpAc?=
 =?us-ascii?Q?6f5rF9rhFbivmVVXDsEK47WsPLFWtHhguKFEiU8Na+EZdRCWlE94Z3tC+f8P?=
 =?us-ascii?Q?B6ywFOmVGk9Gx1nxLLkzakkPjJftmW6PewYSGB+v5ezMG5BHkDZwl9u7Vu/r?=
 =?us-ascii?Q?f0vS3QLKcwApxyjaCcNXnQeJy23b4Czf9lAsqYpmShQOVEZOeZ5AC8/yIJJY?=
 =?us-ascii?Q?QIlQhGrV7bUGxowWtGSkDStKBONWh1uOcwuWHPuRRyhzBFI9pBoBqURclNKw?=
 =?us-ascii?Q?gdFmzpuRDVAOu1HTWevsyD+yu9k8g2DMu9XTczojUKVAiOGmw/uRaVGj/IyT?=
 =?us-ascii?Q?e73w0EGzmIl7wnH5NH/uOGq9zCIGqU76puZBauqHNm+7UYGsj+NqfUhEleX3?=
 =?us-ascii?Q?cFsjiuax8JZYbJsWVcSZleqKRLydnP8iil7N91LsE28oGjl/jchsALfIbotJ?=
 =?us-ascii?Q?hNQbocDxorkjJH9QKH37m1sBS2JgOoVpJ+vjDbOyj1XDdCciEJZAFIT85yG3?=
 =?us-ascii?Q?p0gHJF06bGHXc7oNulUvhYSmBQE1VAPb/fVWjYOduMWhLOUpH6mI40cnKcyE?=
 =?us-ascii?Q?timSWDOuSw85DmhWpNdriKfqTTSoSkep0krv8vv88+T7AzZzUzJgyOgdccu1?=
 =?us-ascii?Q?eNjEtjS63lMOqHlX35b1PlfKJ688yw4ItkhLUAh5TkdpEQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AVVZ8X9kRmbDSUOX0jZSbZipGIwOxzjfm1caZJv1k6ebbltd/kQTx14OmN8U?=
 =?us-ascii?Q?srZVZSJODjqoWZbJ2UYLg/mJWsOGUxqCbhw4Osz1+09LDjUMQEQLpJ3RW+5b?=
 =?us-ascii?Q?D6epVCOkILULCuNtQcs9OCPpdWfBIBmTbMbuwNOY/4YjXeB3KQl5UO5sKRzY?=
 =?us-ascii?Q?tcPl60nRjXT9PahShCctgHUM47IoUaYQGXX6IPOmyQt/fHjWyztfNnFFFkyq?=
 =?us-ascii?Q?PwVOLg4Nz8UQeNWr2Z6JoW2XsLJ7yuKQtevUd70I5lKTZhdMDjdaihH4Ic9a?=
 =?us-ascii?Q?CzLGll8i/OsYTn4kpEfUadaGopAVGC080DJYJM21MZNIMKtzY73IQr5rUkxP?=
 =?us-ascii?Q?E8nXqf8tevWk/6bMkivA5DzTwI1JAmSw351u0678ngz6XWTDQNXvinaX40/C?=
 =?us-ascii?Q?ummvsThQW2koZR2tB4feVixZqbJjJuAdprutQ2/bMKwh3q/UZpSYtw29VRkl?=
 =?us-ascii?Q?S3oJTLL5bKscyxVQ/f3Mu+GO1qf+m1L3osurnvO7FMUw043gnEdnEvzjeqFu?=
 =?us-ascii?Q?q5hf4dKkWp01DsBA4oA/hyoqJXoe/PwI7OTb/pbpdxRo5msxF5hs1AXmLGnP?=
 =?us-ascii?Q?UQTWx5E9m3jRJi26F0QzsgrwD8fhq5Yox9w1f32XrFrZFWMMNFzOdZJ9sSyN?=
 =?us-ascii?Q?UuEjyem/zz8XuE8iEXxHRrkk8Yni9tGxg1/tYYPOcPl+d2XpnujBeBCiiVoO?=
 =?us-ascii?Q?/RLc2ywQyXiPzITI9HFFYhXjRON6aqFz2Ss75Ozp5NmuOsB5GiU1YAgPlgK/?=
 =?us-ascii?Q?Y4FURX0Hp72ye6LA3BNhH2Y3YqjK8gVePfOZ/mzKTW2AkiggL8KNdRGIF0YC?=
 =?us-ascii?Q?rb6qiVdodOgQiMIXkQ1Wo/7WmRBeEWdENNhDLeEc5C/1hvkP2Uw61io97kn7?=
 =?us-ascii?Q?0d9Hl3VJfASzNDe+9VJwwR+dLAhTophcMg8VzJXDEy1fnNOdrhXx0LcCVREu?=
 =?us-ascii?Q?FqV6Z4L6lQppoI0PYwu6dQJ9g99OuZLnGfhec8hel82Vyl/CRgmQGsZ+s0mG?=
 =?us-ascii?Q?7oEWOxNjK+wLVBPqER7Jyx5FjoHPC/FaimUrJhNxEIQg5st9OHL2BAlBIGTi?=
 =?us-ascii?Q?4eA297P5QA1+n5OT7B/ZhQVAvfmr9SSDNNKfgAsWkYK64hAJfx06wYv3bTt/?=
 =?us-ascii?Q?cYsBtsoEyi3H27i+pnWE6CWVTYLsPjTOarOQgsycE+wWeAP9VU67lbgXAp2F?=
 =?us-ascii?Q?y6EgTRb8XqZ5fA2a0JHKCGRNaDVXx6rUF0XefmPmQuGFmXncvArdCWcXQdbj?=
 =?us-ascii?Q?sBEdLSC3xKKAotDATActO9liICZU0iEaFIgE9pdTRChBLaXCMKxx88LPW9Tx?=
 =?us-ascii?Q?3MVsHfBcq1yZgR3O1DmUS69zR+gmkM/6Syc6yPZhczf/daqyj6N0rIGMu9x0?=
 =?us-ascii?Q?Crbli++Wn49+QN95RRps0F5trCGqi2VNzFCl5dZPvAd6nVxjbzQaMXiLfDku?=
 =?us-ascii?Q?HeJr1Q8NaWtLAgVp7NFZ+mp89wN3+yvyG0CjBY37CMXRGu53Qpqc8iLhfP+W?=
 =?us-ascii?Q?naTnhhQY9bn/toRNc9sPi+bg0RUrCK6kDYnDOqCZY+7Ew00J0M8h76WW/6Im?=
 =?us-ascii?Q?HDeumaGEt28mcWBeiwyc3xEsl/9TC6/Bb5WvQ6LFYuWpDqotxK4TAXvB5+ks?=
 =?us-ascii?Q?jONluBwG7E/5ckhoELipV8cbT7jRoijxIyFJDIt+BtqX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a8b469-f040-4102-eae7-08dcb8585e43
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:48:06.1604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgJiNBIo0YO+9BsZqo0itEsnnTNue6RG768X++Zn9i4PvOUZQdjfUn3cAy9ktRBopskI2WfpJQG3A92Uxq5eBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9120

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
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


