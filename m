Return-Path: <linux-wireless+bounces-12145-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00409622C0
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 10:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3D51C2087D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 08:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBB816B74A;
	Wed, 28 Aug 2024 08:50:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2095.outbound.protection.outlook.com [40.107.255.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADFA16B392;
	Wed, 28 Aug 2024 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724835000; cv=fail; b=oMDdju5pTwerOhlgW420HjoU0DHvAYcPuV38hgc3k1daQX7xyY2b8Mp+/pMpAtl66g8MMjAGag5oLeBSV+F3beGP4X6n1swNAupnJjWkTtPvSb9ML6FKHy2LqGZFpWVeRQC0wklI5nFH5Bg2PpUOvkOLKlaQrGRaod/Cm3E2Rrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724835000; c=relaxed/simple;
	bh=eaPDKg4EgZjhgoZGjOIrFz/PouRc4pgRKLayAeEjx7s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=vAZOV491czqyovr1K16FV0FnMS33g+h+GZMptBdDeS3J5f1qBw4eadf+t3xjR+ohaei0LRa31DvGMYNaga+DEuH+gDRSidvmG9vYbqfxS22wtuSN7IISpP9/sxdR9mwHA8rWr1RRyZy5zCZZjDB7h9EhBEQsg5wQpUeUjgjUaSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNz1Gr2t/P72mbp4I7QhTpIRsegNtevQVdDOll1oILqEKvj0NA3vwbt1uHkpG4Q5QWwbPRDCwsldQhW1fxgLQUElxlomoL8rwiXaO6kXQfAJVwcMDBaqud7FibMNLgax1iPBrT22X+CXVaISNZTu2ZuS77BTGZCv2a9K4geT2/GGVLKNH3JgrPcLufuccGd3nEwPd4NBT8K8lV2geQFQQHHFgPzzpYOTLePRjdm7LwMBEfZgEHPHixdz998XAUIRzmhpiiQSdvv1yynN+kxb9xyc3cQmuMnkaB8nu2nduWovDa9JY3A/PhvyCTknRkoIKxSt4lPkvAM+yuRwjM5USQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIa/19ZSdmiXE/+0Ze0XxBHm6vHkH0nd5ZiJsa5DkWA=;
 b=v5vBkyhw/UXEonxoQDSI6ELwNgyu9BdvAMOHe3zurKGVevhhLtOtNDS0D+l8cvJe7eiqVnRueflwCTEBK3t1TdfGLM17v1J/GH6SeLcW8LLRaPbrqJaK/U5qysFyQPEuC7qHJO0mMCwYkSNkj/HRwvswk/Dm7Fvfwjl6mD4baXQTZpvIWA7R0gyzU0WMJo88womqilAsGZnEKYI+Wg1WEOiYr6l8iXQRzefCG67QUnCNfw2rS0fO/cVeRG8xS2p2HA6HI+Ff9cvdpm4qKcRcyMfV44OCKoj2aAWTVGQo9RPalF6AhKwOhz75K7B6IKnm4/lIn32X7rRLTdi0hvdJkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB7382.apcprd03.prod.outlook.com (2603:1096:990:12::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 08:49:53 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 08:49:53 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Date: Wed, 28 Aug 2024 16:49:26 +0800
Subject: [PATCH v13 5/5] wifi: brcmfmac: add flag for random seed during
 firmware download
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-wireless-mainline-v13-5-9998b19cfe7e@wesion.com>
References: <20240828-wireless-mainline-v13-0-9998b19cfe7e@wesion.com>
In-Reply-To: <20240828-wireless-mainline-v13-0-9998b19cfe7e@wesion.com>
To: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
 Jacobe Zang <jacobe.zang@wesion.com>, Ondrej Jirman <megi@xff.cz>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724834980; l=6614;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=eaPDKg4EgZjhgoZGjOIrFz/PouRc4pgRKLayAeEjx7s=;
 b=kiLGdUKWb0oysGKrbbOhlEA2XsGkNy97sBdjuxpQBh0k2MJ855MJU0tYB18RuHkYf278dZcEO
 a81tRLqFUrnBl3qh9XL3Rj1+QYYUhX+aXhPGtlbCgXjS3V4Zbe0V8Qo
X-Developer-Key: i=jacobe.zang@wesion.com; a=ed25519;
 pk=CkP5TjIqHSwHJwZXTGtadoXZucYvakXcO3HjbR6FoeU=
X-ClientProxiedBy: TYCP301CA0076.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::10) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|JH0PR03MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6dbb9b-a6dc-4793-91e1-08dcc73e6265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d05UeWYxKy9vbkhPdDUzb0JUTkpiUWc4VEJUODJoUnJZbkRFcjlRZzZCLzdp?=
 =?utf-8?B?MHN6SzRuQ25OWnJBTHE4NFE5dW5qK05WTjl6VXFzWkZRbXNNcm5Pa1RWRllX?=
 =?utf-8?B?SzhWU1dOdzB2dFlrdWE3bVZCTkVZR3UxTVg1MzB5YTBVQ1RxSUQ0c05pdEFw?=
 =?utf-8?B?T1NmNk9BNnFjMDRiclQyaUVEeDh5UTlNSGkvbUlld2NKUWFmTm1CblJaTWVO?=
 =?utf-8?B?NFdSb0F6VjVjWVgrSFhiUjhFZ0pjVUJuZUd6SkgzejZ0RGljZU1lVnMrbURi?=
 =?utf-8?B?SUFrZDY4UFJFQllKUC9DNXI5OXg0RThCZUxzRXBjOWgwU2V3VzBHaFpWcFli?=
 =?utf-8?B?RzB3UkY4QTZnbnQ5L2laY28rY2xVYWtpY1BNWDhvRHFKTEYzblREdThxenM3?=
 =?utf-8?B?d2xqZnN6R1ZyaGpvM2RzenUrT3RsMkF5SFRqQ3BHU1NCb25wMjhxT24zZ2dK?=
 =?utf-8?B?OGFUMm9CNG1tSzBRRmhVODlnV0xXQ1E3UWQ1cnBnczl0T25lM05IWnhpZ3VN?=
 =?utf-8?B?YSt3RkJhUHBLS0s2U2kvd3FOQmJJNkdEbGhXdHU1VUNCN0Fac3NtbDQxT0hS?=
 =?utf-8?B?M2xhZHNuSTljMC9mSHRFemwyMFY1elFUY2dzbnlzVFJad0NaWmcwd3dLcWo0?=
 =?utf-8?B?WUV4dTBhczdoak40TTRickNCKzhkMUozVjdIREkvaTlmNUJpcXR5WExkbkhT?=
 =?utf-8?B?TVJ4NmVjamRjTTN1QUpZdDhKd3Q2dFBnTlRvTDYrVkRMMG4rdG9MVnNJSEN0?=
 =?utf-8?B?V2cwNWNvSXBrUUxEaWZjSEtWNkUvdVNlWWMzS2ZIVDZJYk1wN2dUSlB5NXR4?=
 =?utf-8?B?dTk1NFNVblBvQkhQdlNOTEZUZWdLd2htbkpqZThoQVZrUE5sMmU4VDF4UVNy?=
 =?utf-8?B?eHMwb0ZGai92VVBQTnNWSVVJWXBSdkpvL0dnYlliWTJVb1ZzSENrZGs3RUFu?=
 =?utf-8?B?a3VocklWeXI3ZXRXUUZic2hrbVM4MG1zV3JoQTRGdmZHQmtBWE9NN1hneXlV?=
 =?utf-8?B?MEVqckgzL2RSd1dCbVBia2o0NzFkOUg1bS9TV0dlK2o1T0xLcXlDNmlZWFNH?=
 =?utf-8?B?YUltc01Nc2NseXBnUFZNcTdoWHNBbkhRbUdiVEpadlM2VmpKTnpkVTN1aSt5?=
 =?utf-8?B?K2NWV2p6QTRPcURRczFoTXUxVUpvbmxsUXNFb0h4SGwxaC9uT2tCTW5LU1J3?=
 =?utf-8?B?V05TaFY3Q0gvdHJ4WDVSV0wycWlVdHVqQVNYS0xXMUFLMTdrMXUzRndPL2Ns?=
 =?utf-8?B?dE56SEIzb3BEeGdsMzBZdzJEVG1xR3FhUWJLUk5CZEZ5cExmdUgwaVovUXNs?=
 =?utf-8?B?dkhXQnNrOEF3YzlrRTVEWjJTdkw0WVZwK2l0dE5qMDJObmtUdkRjYTRuYmVJ?=
 =?utf-8?B?dEN5ZWJINGp4QjJwVGlZa2ZVblRNdCt6YXBTUlI5a1NlMGNiRUd2OW9ZY2Vu?=
 =?utf-8?B?UGxpSTlZa0FYMzJLRmZUK0Q3NzJmWkRueWRPNkwyUU0zd0dWSDNQRjlOenNj?=
 =?utf-8?B?dWJ1dlozVDBxQ3lWWlgyWWRoMmRNWW81enlvVUF6UStqS0N2SGEzWDJZdTFP?=
 =?utf-8?B?QTVpTzJrS0UvdUdqeEVUbmJxNlhqZFRnM2o2VWhKY1RSK3RucDdQWlJNQk5u?=
 =?utf-8?B?cTBMZnU0Ri9ZR00yWjQ4QzVuRnBWdmJrVmVabWhmdm1IeTIxejNyYWxKWUR2?=
 =?utf-8?B?ZWhBZ091a3UzdGNOcEtNV3dWRFFwOVpHRDZlS1J4ZjR0REM4TDVjSjNSRkpY?=
 =?utf-8?B?RlQ3VWk1cHZUYUM0TWpBM1BUZDZGRSs3eFRUcjVNemk2UzBCT1RtcWtMYUtz?=
 =?utf-8?B?cjJGWnJTd1lNa25IeE8wNTdsRXFJN3RuN0ZnSG5ZT2tlTGdGVzNVVFhIdjJi?=
 =?utf-8?B?WDlPcEdmbHJ2L2dNKzl2WUQ4UCsrL3dveUx2UnBlaERtNDhubys4dkNHYldr?=
 =?utf-8?Q?9uNC+Uutkjg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjcybkhhTXVRR1ZpbDB3cUF3S1Z5OWFvd3ZCV2NJWExYVjlDd3ZXVGY4K09M?=
 =?utf-8?B?Y3p1bGgyVFh6cnoyMjFhSlpUT1EwZ3RzMW5jL1M2eVNMelVmSC9pOWkwU0hq?=
 =?utf-8?B?TkptVG56bUFzWGppUUFObXVkK1ZmY1o1aE0vb0NOR3BPWXJkUldXdmRscEZF?=
 =?utf-8?B?SHJjN05SV2V5UlVmZVgwdHQ3eWJuUW0vbTVuMlhGVVFuYThzQit6a1l4cXJp?=
 =?utf-8?B?SmQyNDl4Mll6eHAvekpES0lHNy9ncDhteXlhb05GYmx3M0hYd3RHWjlyMzdI?=
 =?utf-8?B?TGJVT0RGbWo0RStXMW1zbUZBNHI1RE54d3JacUhRZnhOVDRXZTQvajF2NFp3?=
 =?utf-8?B?Vk8xSnFNNkw3SUZpWHJiT3VWcFZzZSt4RkF1SkVpeDFQaWdCaGs5L3lTYzNZ?=
 =?utf-8?B?R2JpYzRoQ0JQZXQwdzcrbTJacVpYWkt4M1NDNTVIUGxCbVd5enovd0JHSlZz?=
 =?utf-8?B?OXJDL3VnZ2dlVUwyR3dsL2hCeFpRYXZpdS8vVk5ta1dtOU4zSDZqTzd0Q09j?=
 =?utf-8?B?VkJ1MXlnc2cvaDVxclRFU0xSZ0NsckV2WUk3RGtCdzJuNDV5dU5lb0prYTJN?=
 =?utf-8?B?bUtPbHQzTmk5eHBNcUN6aTBjVnVvbXY3YUVHbWsxUVBRTDYvZDE2cEVYRy9p?=
 =?utf-8?B?cEx4MWhPL1NOcE9IaC9SVU1zNmxtbXJjR3ZEWkEyY0JuaTlvb0I2RGVHM3NH?=
 =?utf-8?B?UTF2Sy8zUE16L3VlbjNyTnJqYkNnVmdEQVkwV0RSVE5UdDdjN2FEY0ZiWDNT?=
 =?utf-8?B?MnFUWmlDQm5JL29jUXN6L3RWVmNEN3RGdG5DZGNCVEJsRllvZmJXVDg1eE1n?=
 =?utf-8?B?cTRGN0RlSlQ4anZoK0s1SWxkanYwVW1aT0ZFdXBxVThrZ3E2U3BFLy9ST28r?=
 =?utf-8?B?VTBPeGV2Ly90bGY4OElEUE5YWmg1dFNuWHJyUm9DcC9PWnZQVE9oN0N4aFdP?=
 =?utf-8?B?MTIwQUJBVXN1RklwdGZTei94UzNXd0IvbEVmL0sybnhVWlBSNjkwWXFzYWZn?=
 =?utf-8?B?Ynl3MG1pM2taS2ozSkxYZ0JIQ0hoZ1dIbVJZMWV1QTU5MFJDMXRIZjk3RDFM?=
 =?utf-8?B?ZEJNMENiVWhSK2RvZmFOdFAxTlB1ZXpqMndPc2txK1dWLzBsS1NLVW1hUHVz?=
 =?utf-8?B?czRiYzA4RHdnUy9UalhLcHFnVEtDUWxBbk1tWEprRzMyL2U3R1dSYUU1SWI4?=
 =?utf-8?B?d2ZNZTZBeTFheVpVZEhRRWpidEhyblZVK2Yrc0JyTUhEVDhxZ0JydlBEckZD?=
 =?utf-8?B?OE80ZndQcFllaURsQ3NQZCsrM2svS01WanJScWxldjVQUXg4dVZIeURQMEVQ?=
 =?utf-8?B?MFdsaUcvOExXWTBiOTVVVmROc3hXTGFlMmtWQ2U4ZnNhZjdZVGJoV2NUN2oz?=
 =?utf-8?B?R1ZTY2VhWDQvcFR3YVVTUFh1cmMrWWczUUlQcHNHRjdVMEhIYTBlU0lBSDNM?=
 =?utf-8?B?ekxBeHJzd2xwN0hubCtydG83dFM1bGhjUkVvaVJqYnJZZnFXWkVCY1gyNlp2?=
 =?utf-8?B?N2EvYkgwYjkzODhDeitYZWo1NUVvYjhRUEtUendjN1RKZENwSVMwY3BuQ1E5?=
 =?utf-8?B?V2o0TnFmTkRnVFhQRGo5ajErczlTcU9TOEVTM2l5eC95dStyK1BJeGkrTkFG?=
 =?utf-8?B?dW9DYjRVVWUvc0ZhZ1EzWEtGUkFPQkFNZkNicHkyUnNzMk94STZhOFM3ZFZ0?=
 =?utf-8?B?cUR0M3B6ekd4bXRkaGkzQm9scnBvMjZkV1grcVUydDdCTnR3bzlWKzdGanox?=
 =?utf-8?B?akhqaFJzSUpkUnJEbjlvNk5wMnBzM1V4RGlZRzRaRjA4elA0M21NVzVUak9h?=
 =?utf-8?B?RU9tcHRETHBYdHJIM1ZKc3NoM3paczkyQWdVTXJXWm9iazRwMzJJNG1BQU1J?=
 =?utf-8?B?dW5GdDZpZmRxY2RZdS8wN043NitLUVBBcmJ3YmhJRmJGTUFPYXRvU2lvSDYr?=
 =?utf-8?B?ZVU2U1VqMjRxaVhqc05PRGxlY2dRaDZJZmtGUzJ5TWd4aDZrYVpNWHN1MzQz?=
 =?utf-8?B?c09GeThpL1hHUmlrZEk0Q2FrNWUrMW4zVTJJVE05NnpEcjRNM1JpVVl5RDc2?=
 =?utf-8?B?TGZKZFBnQUc0L29jYVIzNDRqcDExYTc5UGtHVWllOFIvOEUyT1VEbStGd3JE?=
 =?utf-8?Q?wST0O/z7H8hGRI22k5TdyRHQm?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6dbb9b-a6dc-4793-91e1-08dcc73e6265
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 08:49:53.3043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLIjaulDdLYiuUWCBxZ/s5VOutAGQh2GXXfUy2B4MpkvwK5EXql6qMt5HfZRDkdmnl0KdQ1PXEf8v0vuw3SaVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7382

Providing the random seed to firmware was tied to the fact that the
device has a valid OTP, which worked for some Apple chips. However,
it turns out the BCM43752 device also needs the random seed in order
to get firmware running. Suspect it is simply tied to the firmware
branch used for the device. Introducing a mechanism to allow setting
it for a device through the device table.

Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 52 ++++++++++++++++++----
 .../broadcom/brcm80211/include/brcm_hw_ids.h       |  2 +
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 190e8990618c5..c0fdaa4dceda4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -66,6 +66,7 @@ BRCMF_FW_DEF(4365C, "brcmfmac4365c-pcie");
 BRCMF_FW_DEF(4366B, "brcmfmac4366b-pcie");
 BRCMF_FW_DEF(4366C, "brcmfmac4366c-pcie");
 BRCMF_FW_DEF(4371, "brcmfmac4371-pcie");
+BRCMF_FW_CLM_DEF(43752, "brcmfmac43752-pcie");
 BRCMF_FW_CLM_DEF(4377B3, "brcmfmac4377b3-pcie");
 BRCMF_FW_CLM_DEF(4378B1, "brcmfmac4378b1-pcie");
 BRCMF_FW_CLM_DEF(4378B3, "brcmfmac4378b3-pcie");
@@ -104,6 +105,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
 	BRCMF_FW_ENTRY(BRCM_CC_43664_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
+	BRCMF_FW_ENTRY(BRCM_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752),
 	BRCMF_FW_ENTRY(BRCM_CC_4377_CHIP_ID, 0xFFFFFFFF, 4377B3), /* revision ID 4 */
 	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0x0000000F, 4378B1), /* revision ID 3 */
 	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0xFFFFFFE0, 4378B3), /* revision ID 5 */
@@ -353,6 +355,7 @@ struct brcmf_pciedev_info {
 			  u16 value);
 	struct brcmf_mp_device *settings;
 	struct brcmf_otp_params otp;
+	bool fwseed;
 #ifdef DEBUG
 	u32 console_interval;
 	bool console_active;
@@ -1715,14 +1718,14 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 		memcpy_toio(devinfo->tcm + address, nvram, nvram_len);
 		brcmf_fw_nvram_free(nvram);
 
-		if (devinfo->otp.valid) {
+		if (devinfo->fwseed) {
 			size_t rand_len = BRCMF_RANDOM_SEED_LENGTH;
 			struct brcmf_random_seed_footer footer = {
 				.length = cpu_to_le32(rand_len),
 				.magic = cpu_to_le32(BRCMF_RANDOM_SEED_MAGIC),
 			};
 
-			/* Some Apple chips/firmwares expect a buffer of random
+			/* Some chips/firmwares expect a buffer of random
 			 * data to be present before NVRAM
 			 */
 			brcmf_dbg(PCIE, "Download random seed\n");
@@ -2394,6 +2397,37 @@ static void brcmf_pcie_debugfs_create(struct device *dev)
 }
 #endif
 
+struct brcmf_pcie_drvdata {
+	enum brcmf_fwvendor vendor;
+	bool fw_seed;
+};
+
+enum {
+	BRCMF_DRVDATA_CYW,
+	BRCMF_DRVDATA_BCA,
+	BRCMF_DRVDATA_WCC,
+	BRCMF_DRVDATA_WCC_SEED,
+};
+
+static const struct brcmf_pcie_drvdata drvdata[] = {
+	[BRCMF_DRVDATA_CYW] = {
+		.vendor = BRCMF_FWVENDOR_CYW,
+		.fw_seed = false,
+	},
+	[BRCMF_DRVDATA_BCA] = {
+		.vendor = BRCMF_FWVENDOR_BCA,
+		.fw_seed = false,
+	},
+	[BRCMF_DRVDATA_WCC] = {
+		.vendor = BRCMF_FWVENDOR_WCC,
+		.fw_seed = false,
+	},
+	[BRCMF_DRVDATA_WCC_SEED] = {
+		.vendor = BRCMF_FWVENDOR_WCC,
+		.fw_seed = true,
+	},
+};
+
 /* Forward declaration for pci_match_id() call */
 static const struct pci_device_id brcmf_pcie_devid_table[];
 
@@ -2475,9 +2509,10 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	bus->bus_priv.pcie = pcie_bus_dev;
 	bus->ops = &brcmf_pcie_bus_ops;
 	bus->proto_type = BRCMF_PROTO_MSGBUF;
-	bus->fwvid = id->driver_data;
 	bus->chip = devinfo->coreid;
 	bus->wowl_supported = pci_pme_capable(pdev, PCI_D3hot);
+	bus->fwvid = drvdata[id->driver_data].vendor;
+	devinfo->fwseed = drvdata[id->driver_data].fw_seed;
 	dev_set_drvdata(&pdev->dev, bus);
 
 	ret = brcmf_alloc(&devinfo->pdev->dev, devinfo->settings);
@@ -2663,14 +2698,14 @@ static const struct dev_pm_ops brcmf_pciedrvr_pm = {
 		BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
 		PCI_ANY_ID, PCI_ANY_ID, \
 		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
-		BRCMF_FWVENDOR_ ## fw_vend \
+		BRCMF_DRVDATA_ ## fw_vend \
 	}
 #define BRCMF_PCIE_DEVICE_SUB(dev_id, subvend, subdev, fw_vend) \
 	{ \
 		BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
 		(subvend), (subdev), \
 		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
-		BRCMF_FWVENDOR_ ## fw_vend \
+		BRCMF_DRVDATA_ ## fw_vend \
 	}
 
 static const struct pci_device_id brcmf_pcie_devid_table[] = {
@@ -2698,9 +2733,10 @@ static const struct pci_device_id brcmf_pcie_devid_table[] = {
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_5G_DEVICE_ID, BCA),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4371_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43596_DEVICE_ID, CYW),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC_SEED),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC_SEED),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC_SEED),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_43752_DEVICE_ID, WCC_SEED),
 
 	{ /* end: all zeroes */ }
 };
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index 44684bf1b9acc..c1e22c589d85e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -52,6 +52,7 @@
 #define BRCM_CC_43664_CHIP_ID		43664
 #define BRCM_CC_43666_CHIP_ID		43666
 #define BRCM_CC_4371_CHIP_ID		0x4371
+#define BRCM_CC_43752_CHIP_ID		43752
 #define BRCM_CC_4377_CHIP_ID		0x4377
 #define BRCM_CC_4378_CHIP_ID		0x4378
 #define BRCM_CC_4387_CHIP_ID		0x4387
@@ -94,6 +95,7 @@
 #define BRCM_PCIE_4366_5G_DEVICE_ID	0x43c5
 #define BRCM_PCIE_4371_DEVICE_ID	0x440d
 #define BRCM_PCIE_43596_DEVICE_ID	0x4415
+#define BRCM_PCIE_43752_DEVICE_ID	0x449d
 #define BRCM_PCIE_4377_DEVICE_ID	0x4488
 #define BRCM_PCIE_4378_DEVICE_ID	0x4425
 #define BRCM_PCIE_4387_DEVICE_ID	0x4433

-- 
2.34.1


