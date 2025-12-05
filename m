Return-Path: <linux-wireless+bounces-29534-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D306CA704D
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 10:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BBA83989616
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 08:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803F930B515;
	Fri,  5 Dec 2025 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EXkYFKHm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011067.outbound.protection.outlook.com [52.101.70.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7882F747B;
	Fri,  5 Dec 2025 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764922428; cv=fail; b=SZqojqhCQPzVNNlYNa76C6vLHkGQcluUaC/oGUIC6cRnRXjkEnoMr9BJDB0yr+NOfCrMggB+Ic6lmxv8b3fOcTMtm6VXSmksJSSDUYDwOzKFIpUEEjh7pCXvEb2ZeKz4oCdmAgjs7UWHbCQD7VYsLnJ+0zrDA/SlbA1Em7EYfSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764922428; c=relaxed/simple;
	bh=Sduw6mfKVfhqB/iEBDTLItZn6BqhX9McsNCPEB+OCgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZE02Z6lA39x7PKSo4uTMnFeNi8dbNbBJzPyNLRPzTE/j+AinhIxrqs1X3jPKNS38/OniMGJfbT+d7JiBdo0Kr9sUuFaTmArHFem1TuffOcFM/aARR8/tYfC588dFetVLyoOiPmVlhjN5uUhdcnBhNqW3+/KMszuIu95PUhk/deg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EXkYFKHm; arc=fail smtp.client-ip=52.101.70.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9Z9yAXOyNwjJ2c3j8y9cct1UXU3cTFS81RFjsZRYuN12QsEe1uv807EUrSqP8Zw6O0/SnRnabhs4t671rS8ONzMKIYwHLQQ2o83BOAUSf94WpR05CLg6ZJxStNh/WzJxy0drEFcYwtzJQ7sv6hUVVyDaEyGP2RBFHr6tBwOd8hxShTbTaIe4nuQBNW8zzdehECwaQlPcCxWO6T7Kiv7rQJAIL38yCNij5k52nHJaebHp+a+lGFIl8zrqqT2eImf0HxWqudTTzCMD1ELm9bBnncG1CUS703v8ddzja+s53YhEdAW4HkNUJXMVNw3Qv/yoptNoL97KXoJQh3eAsUmZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qtp2tcPw9fsCobr847siRdeyHTEq6JRv2cU3HUGodv4=;
 b=miqe+tyYUHd0cRXsQFBcV4GfvpfAwQYBSwwt39aj6n8sAaKdmPGC8Jq4ZBVU84E81x+4yhSEi0MxKLAYfEJV3FWYEqoxLmNRaL2tSYOkQNVZzwg/j9I0gsCEzRgK15fAyvmhGOW7qI5zRWvZ4st0xKtLC5lMr+LHkOGIQoxbH9nyBDknbQXDUaFiYgwlLpj4B3JmEGT6JohYwAIkillEAsQ3DUIRdWB4EQzhCxg2oNazU7L2oUC3CNoP5lAL4UYHUNaepmpT1dnwV+/Ni+N6J1XF0yp7DVGAho8KKhONDffiWg/atRJdwh+Urw4cQgxfsecAgX0CXdsMpi7DbsIl8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qtp2tcPw9fsCobr847siRdeyHTEq6JRv2cU3HUGodv4=;
 b=EXkYFKHmCqdp0r/KqsANfOmuzFmj+Eiz7lcKaU4BQmdq4rMkTx5j4KQ18Nm657kHGwFEWeksdYt9DxBKIr7x2IMh9P0GBoi89wFHFSGDCHpKDKccA+bnN2gLPeZmaRkZ9FpUprpZCw5zhb927YMg15otUTZ0eLCHecs3d3wYo3+o4qaZD8otctku2Xc2UaDJVIzuMRREp6nb6DBYMjzSnSDnGMtJLG67kcyc/bBhxPVHL1BCqVnIsEb30P9xzixBGj9OMP9Vu11i9uRmDQFL2NWK0n7vu04RGF9EWGF8HYggDmEInFTDnq7tVtpE2VKr0IWBVFooK0jvUYYyOlceYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by GVXPR04MB10874.eurprd04.prod.outlook.com (2603:10a6:150:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 5 Dec
 2025 08:13:31 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 08:13:31 +0000
Date: Fri, 5 Dec 2025 16:12:25 +0800
From: Jeff Chen <jeff.chen_1@nxp.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, johannes@sipsolutions.net,
	francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de
Subject: Re: [PATCH v7 00/22] wifi: nxpwifi: create nxpwifi to support iw61x
Message-ID: <aTKT6RcWecQh1/CL@nxpwireless-Inspiron-14-Plus-7440>
References: <20251117110046.2810811-1-jeff.chen_1@nxp.com>
 <fe78857f-956c-439e-a1a7-95ea19c8e932@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe78857f-956c-439e-a1a7-95ea19c8e932@oss.qualcomm.com>
X-ClientProxiedBy: AS4P190CA0023.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::9) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|GVXPR04MB10874:EE_
X-MS-Office365-Filtering-Correlation-Id: 751f9aa4-78bb-4024-fdd2-08de33d62cc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alUwU1FOM3FmekRKeSswRVhDTUFyYU9oOVhVZkI4eDJXZmVnYVg1SjNrUGZa?=
 =?utf-8?B?b2VMOWV3NmNZZHIvKzI4b0xnMlhOTHVzRjFsTnlUem0wUVF6ZjRlY2NHQXZa?=
 =?utf-8?B?WjJaQnZVNURnRDNKdHRYbHlSL0MwSHdYRzhwbFhUcHNtWDdOVnhkOTVsbjlD?=
 =?utf-8?B?K2RCR3dIUGp2S3FaM055S2czY1pFM3dzYVArNDBCRHVZR05uSU4zTGdsYjhY?=
 =?utf-8?B?Wk9DdEhUaEJ2QkwybVBUSktHeTJWUE5NSlJxK29wL2xDQzd0aTY4KytEbDJn?=
 =?utf-8?B?bFgybUxRWVpZWGw3WjBSTk9TTjk5S3NwK2hYYmpKOXdUYTBqVGpER0FhV2Zj?=
 =?utf-8?B?d1JEUEMzeW56VTAyN0MwaFpTNHdzWG5zanl4Ky9OREs5SWNLT3Nyc2RrNk04?=
 =?utf-8?B?cndDNUtXRWxxWVVXYXM2YUpVbFpBamNJZFBYR3RYS2lLdW53YnA5emhETTdk?=
 =?utf-8?B?dk8rSlNEdk41aEh2SEZvakhVNTdZQkpESWhFNFQ3SXExdjVjRFdPZmp4eHVy?=
 =?utf-8?B?Rm1VcFdhUXNrN2JWZjZkRTd4dTgxRnlDdTJZSXpXdElkR3JSaFFWbzJZWi9y?=
 =?utf-8?B?bGFIcjhSQ0xJaTc3eGE4enlKblNQQmZTdVpsT2hkQmFsbFhvaTdPcFcxY3Fr?=
 =?utf-8?B?Z2dkUHVCdThWSWU0QjdmbWQwdmo3STh2ZklNcW52NDg0OHMzeURGQ2lRVDl2?=
 =?utf-8?B?Zml0Vm9DTmxUSmpKTE8xWENEWlJLQXdkUGNxaXlSc0ttM1BTZXVsS2ZkZi9E?=
 =?utf-8?B?VWhyTndPL1pqd0NDT3dtQ0g5SFc1aGtYeVQ4ZC9UQWVuc0RPcTBXYS9WbjFU?=
 =?utf-8?B?ZWtqbkdCS3lvRUE5V1NtOW9JeHlQMXJ1TmUzRmVsS0VuYzFtODF1UTBjckE3?=
 =?utf-8?B?eEJIWGFXYjhENHhqNlZvL1FzMDdmS2VTNUI2QjJVVTE3VjhLSU1CUTlRL2xh?=
 =?utf-8?B?OVEwUW1OMUFUNXE3dFlqa1gwaDJrdERncCtyMEgwZXpmY1Zpd1l2TTZFZlEz?=
 =?utf-8?B?U2tQcndBNWNwdGVmd0w5cHhwQmo2WHI4UTRKNmJTZ2U1QWMrSjlTQWdDbUtR?=
 =?utf-8?B?a05vSUNPazl1dGZEM3JETWwwYks3Vk4yM1hwaG1RZmR0SGlZejdqcDdwNTVT?=
 =?utf-8?B?c3ovYW1HN3BxdCtsMllGbk5xV3ArN25IS21XRC9CcG5PMXNXcENVTGtDbi95?=
 =?utf-8?B?Njc2d2tNOGxLUkxWUnpSSGI3U0lrajM3VFJDS0U0UWpXaVBCVWJ2aGxXV1hk?=
 =?utf-8?B?S3Bnb2VjRUpxZTU1NTdpN2lGN0F6bFQ1bWhFcmUrS0l1R0FXWlgvQ1duK2Ir?=
 =?utf-8?B?QldHV09XMXNIQytuMGpveHl4Y3ZTa3NPSk95TTduTEw4cFpjMnpDREJDb2Iw?=
 =?utf-8?B?YnJxRWkyM0VKaUdJZE5YZUwzTUhBZVh3dnBkK1JtQmEvWUNnUGhEbGh1bmdN?=
 =?utf-8?B?cjRBMG1YVmNldjlUcWg5dmNNckNONlRzQ0I1c0NhVHc1Nkc4NlpxK0NCZmN2?=
 =?utf-8?B?MVRYbGZHRS9BUTJxOWhGcVVMNFhjaVVibGZSSzB5czR0NXl5anZNZGR3WHBV?=
 =?utf-8?B?aTFqRytRblVsa3RHS0RycnVoNWR5VGZBZWFhbW1LQVQ2bENTUHBJT1pIbkMy?=
 =?utf-8?B?clpTbFJySkNLK2xSbitJY2gvUjFDcHM2WEMvU2hqOE42bUQxdnZ3MkpUM2dp?=
 =?utf-8?B?K0tua1BlakE0ZXk1QUxKbE4vcWxxcHlENjRKazNDRkY4TWdDVDhkeGwzL2ly?=
 =?utf-8?B?ekpHOEVJQldrUngwOHlBKy9nRDFYcTFmVVlZQVdaeXRDOVgrRkl5S2R0Sy9s?=
 =?utf-8?B?QW1XYjkxK3VHaE9MclBnZmJBUHdxMHk5TFZ0VkR2YTdnQWZxSFNoWnMyeFRI?=
 =?utf-8?B?a1dWSDdXL3pMelFpWEJ1V0FRRDFoMW1LMVN3OExjSDFKVWV1aU5sVTE5aGxy?=
 =?utf-8?B?Q1RMaENaUi9RTlY2NFJ6SWtzcmR3RUVkSDZCWWtzUk5MazJTWTJzbkpSRmZh?=
 =?utf-8?B?Z21oVmxxRGV2TW5NUWlzUHRreU5uZElicmdaU240MzRRVFZMcU1tM2J2VVNi?=
 =?utf-8?Q?+I6W9x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkxJYVFzSEs1SS82SlQ2cUZ3Z1pWOTBVYklWNzhXTEFORElwOGtwaUxtUTha?=
 =?utf-8?B?dDJabHBqU05YNjFIQnRFL2pBMHBMRlQ2RHZqUGRHd1QraGhCRUNlUG40dkFq?=
 =?utf-8?B?YXpvK3ZDY0g4emprVGN1cGwzOWltbUFrMjJuc29udVVYbkxmNUdudURKWXBE?=
 =?utf-8?B?NW1MN1VwSzVaME16NzZ2em4wMlBuTUFBWTZWd05qVEtJVVI3VnVrYWtqQmQ2?=
 =?utf-8?B?WE5MYWIzVVZDRTJXYUVrUjZmMmw3b3VFNVhnQmZHTTU3d1IrV2QycXFjTHIw?=
 =?utf-8?B?TXdONEY0UWtPTGFRcTRKUmdLSGZqTjh1V1c1bWtBUG42aGkxL2htWUFQU1A0?=
 =?utf-8?B?QzNHdk1mQ2I5M01qcnp2Q2RZeFJzaEtGSUhlczVadS85MEVacFI0dnBwbG9t?=
 =?utf-8?B?ZERiNXVtWTFwZzdHT3JRa0YyUlNldldyV2pocndiM3Y4K05WUEF4VFJvWisz?=
 =?utf-8?B?cGlEUnVDdVBCQXRCaU1tTFhiWk42VHZlWWNPYUZvbG1RMnQrc29mbndQVXRt?=
 =?utf-8?B?V3g4R2pTNm9Hd3BsRXM0M0NqcUx1TWpObEJVdmxWYlpCV0p2Wm5IL3k2MHFk?=
 =?utf-8?B?SkYvVnhJdGlGc25CVStpVWg1cUdXOXU1T2EvYzYwajAxaTkwbEhETXBzbkhy?=
 =?utf-8?B?b1ZmNlBFWitGT0NscDBpKytDenpqQlN1MHJSem1ueWk0dXJ2bXhMWmI0N0FX?=
 =?utf-8?B?VDRqLzh5VFdJK0NFTXphYVp4aFR3S1puMFExczZ0V3hTTzd0SWlFbjFyYzdW?=
 =?utf-8?B?SW9hNDJ3anhTRVI3RDFYM21zSzZLT3F5TDZGRHhJTmJ0U2ZPclRobUxhTzJK?=
 =?utf-8?B?SVROamptU2RjWWlhbjhEUGIxQ0wxcWFuV1Nmbm94VzFGM0NIeGg3OXB1byt2?=
 =?utf-8?B?VWRGdHZnVlpSRVRaNW1NWlhkK1lIL3hQT2FFLzNXVjlGbThoaFliVzdMSVlz?=
 =?utf-8?B?cWREQjFCV3VabFMwU1p3NURvNDAzK2NoMlhJMXNkTWtJMmNPNnEyTWFpVHpt?=
 =?utf-8?B?a1R1VGdOemhqQXkzZGRGZkdKcVE1ZS95RGdSUndObHpzeTBmYTgyNE5RSjlF?=
 =?utf-8?B?NldDcTRpb2dMcldZSDZzdmxhaU5UMW5vM3pBTUkvWHhGak03RStxSWdTNmdE?=
 =?utf-8?B?SVRwbzJ3UVNpSmRjS09PZ2k3bGZvaGMzTVZTbld0YWVYM1FuaHREREZXNkVX?=
 =?utf-8?B?S2JLajMxMi9pTXdQL1RSQlAvOEo0VDd4a3JVbHpEVzdjc0VRU0ZkUHFON1c1?=
 =?utf-8?B?dDNkd3E4NlUxemNJUWMxTk84MVR2S1hkV1FSRjVWZkdqVlg5SkdWamZOTzRl?=
 =?utf-8?B?MXVwWmlPQlVLV3RKOExhQXdFaW9vYnZDNWdDZEhqNzh0SmNXWm5vU25nRFdo?=
 =?utf-8?B?OUtzZ0FsV05PR3phWHVZcDdocXpobzE2bFZHbFBqK2M1aS9jSk5TSjJsQmZW?=
 =?utf-8?B?SE9lTlFNNEVHTlhaMXQ0bGdwTGlUcitaV0t0S0x3MGtScFNNbkdpUEtPTnA2?=
 =?utf-8?B?dFdlY3ZUZVNuaGJtM3VuSkRLSk04UjFBNlExL3orajMyVStBMzlZVTYvV0xQ?=
 =?utf-8?B?OTJvU0xPN3lqSjh1a1pOQnNKd09tRDJiN0N2QnJ3YjFaOTlNc0hNbUpycVcw?=
 =?utf-8?B?eG16Y0h2b1N2YWE0VXFybTdZSnFNZExQcmc1VDRscWxzUnVVa25kakt0aHRJ?=
 =?utf-8?B?cE9LVjU0cEVCRkZNSXR6K3hsQWtFdW1qRWhMYTV0S09IT1B4dFk2M3paVkVG?=
 =?utf-8?B?QkZnOGV4dlZ1aUxuMk5MM0U1enp4UzZoVWlOWnpXTDZUTWdTVXJ3SnRzMG1a?=
 =?utf-8?B?NzJ6c0J3OUpUWXFNRVAwS214VTd0cUVRMFNRWVZ0SUR4b1FNOFA2dTIvSWRt?=
 =?utf-8?B?aE04OEtOem9OTE85d1VzeEl2dnI0U0hDYVUzVTlMZDg4UmdSUFIzbWxHR1U2?=
 =?utf-8?B?ejFTK0xjWUpkelV0ZmVXa0xaMk1Eci9LNTVxOXMxcHJwbzU0V1FNeE05Z1NF?=
 =?utf-8?B?K1IxOXNyeHg0K0YvYUttbzNUSmZQVmdjMVc1MnptakozWkxxYlQ2NUZNOVFH?=
 =?utf-8?B?Wi9MY1EvV2g0VkFoVWlHWkpHN2VWUEZoUlQxdXBiMXFQcnRjLzVBTFRRbWJa?=
 =?utf-8?Q?k6ZYynxc8L3AG/yX9m1Tenr9A?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751f9aa4-78bb-4024-fdd2-08de33d62cc2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 08:13:31.4831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dldvUSTj2hv1S0CGwt8zFmtuWTCqLv73/tzRMqKtUz8FGC7OSwLZhrub+QRuqYPYKxZusR5mtQW26AmyH9Fn/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10874

On Mon, Nov 17, 2025 at 11:10:24 AM -0800, Jeff Johnson wrote:
> So that this series would have an additional set of eyes I ran this through
> the automation I use for ath.git.
> 
> It reports multiple instances of using the now obsolete networking multi-line
> comment style.
> Starting from the first patch:
> +/* Fills HT capability information field, AMPDU Parameters field, HT extended
> +/* This function returns the pointer to an entry in BA Stream
> +/* This function handles the command response of delete a block
> ...
> 
> Current guidance is to use the standard multi-line comment style
> /*
>  * first line of comment
>  * [more lines of comment]
>  * last line of commnt
>  */
> 
> It also flagged one incorrect use of kernel-doc comment style:
> +       /** rate for LG pkt, RATE flag will be present, it shows datarate in
> 
> There are also numerous spelling issues reported by checkpatch.pl --codespell
> TYPO_SPELLING: 'interation' may be misspelled - perhaps 'iteration'?
> TYPO_SPELLING: 'Dimentions' may be misspelled - perhaps 'Dimensions'?
> TYPO_SPELLING: 'interfacces' may be misspelled - perhaps 'interfaces'?
> TYPO_SPELLING: 'formate' may be misspelled - perhaps 'format'?
> TYPO_SPELLING: 'verion' may be misspelled - perhaps 'version'?
> TYPO_SPELLING: 'Timstamp' may be misspelled - perhaps 'Timestamp'?
> TYPO_SPELLING: 'intializes' may be misspelled - perhaps 'initializes'?
> TYPO_SPELLING: 'statistc' may be misspelled - perhaps 'statistic'?

Hi Jeff,

Thanks for running the series through your automation and sharing the feedback.
I’ve addressed these points in nxpwifi v8.

> Also "wifi: nxpwifi: add initial SDIO bus driver support" reports
> UNDOCUMENTED_DT_STRING: DT compatible string "nxp,iw61x" appears un-documented
> -- check ./Documentation/devicetree/bindings/
> 
> Is there an associated DT patch out there?
> 
> The MAINTAINERS patch reports multiple instances of:
> MAINTAINERS_STYLE: MAINTAINERS entries use one tab after TYPE:

In nxpwifi v8, I added the Device Tree binding for "nxp,iw61x". However, I received
some negative feedback on that patch, mainly about the description focusing on the
driver instead of the hardware and missing proper CC and subject prefix. I’ll address
these issues in the next revision.

> So suggest you use all options to checkpatch.pl on your series
> 
> /jeff
> 

