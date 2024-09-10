Return-Path: <linux-wireless+bounces-12722-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAB1972777
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 05:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1141C20D43
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 03:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD71018132A;
	Tue, 10 Sep 2024 03:05:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2097.outbound.protection.outlook.com [40.107.255.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84C914F122;
	Tue, 10 Sep 2024 03:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725937549; cv=fail; b=V54lweI+OEFYrVdon1tr1A8DoLIfvv+XGOwi5IyFjJ0psQTByq1/m/gaRiNkCeZUIeJ9QFhAwTt2vHZnBQZK0NrwTwbU83u3Vd1tDl/jhcX3x92clEluHejf0pzNPqzl4aGDE56hSkB4OtJty/hRzSAXUs33Gmcv00/nMBoYW80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725937549; c=relaxed/simple;
	bh=6rKptISgX+yTYN/ILXeFCE7UDdObYAJtbyRJTS9NOTM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PAlM68szBXgaGPlsjJDe+kTSWTIdKcwgrnexR9EC+p9oczGScWr72Q2bpplmh83PKejhTNKnNjT87t7YHecyUWkgA/Y/XSmBIBmfZ4W2vj8uSuVUqksaa8B5m5vCWAQmgt4DkfuT0F2yWT2jC+P4yP3dVCd6n0Biyar1DZU6s00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMhTvLpd+kaGoU5P37pY4eOi/51uX9zcuI032ZXes/bQoLFhXCpTpXsDc9Esp4Z71brRPnsuhtJgMhtB0zDg0t44mxbjCErfh7vfAswTvVqTiMMbd1XYTJa90MtII8AVq/xSbwK9xawkC7iSE01vwfaKLpGHY2QHRZ/8JfSU2cu9TOixMmUml6lvwG76orfrZJDg3KNeUrwXeFVm/QKSqYLXn0vFJkQedtwuucLwLX2Xa2pPBOTRuGDz3KyYGrWHjfUv0db2OHDaoToaXZz+Sgrd3jky0TX+ifE7KGoWxRliEtqLq6c+QwrE9Xak1oKB0a/YH9Cf5qCrMIZjozkN3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xydvwPU1NKoa0szBoqrw+5ACxascr/GdnlvKtAfEmlc=;
 b=aHbtFmI3e1GNd9pSv4q2u7Dg59uIKgbROW7XhirmoaVUV1QmLbmkqgP3OdSUC17CBEzmsDpnFricfq4BsADnDc9vqKk7nrP728ukTtr0dPIzC3eHnKYXYmwbn8xwhuVZSV4XbJm21LNJmuD5EJJ2329s5nv5O5vraRE009x6fF10N3/3Fme/iI5FYkSOJUfRvzfhErcZdSRNzLxXewbIR8z6Yy863AfOka8lhfAYcr107oZL/scLP1dfxFddO/SGLJ//oYoEDcpnH5rC3s28jKYwEA/EIvBpBYmGEW1VQtXYhqgvDhQrH65vuRytvNV/rtsoWrQG+E798ze6642MBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEZPR03MB8442.apcprd03.prod.outlook.com (2603:1096:101:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 03:05:42 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 03:05:42 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Date: Tue, 10 Sep 2024 11:04:13 +0800
Subject: [PATCH v14 3/4] wifi: brcmfmac: Add optional lpo clock enable
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-wireless-mainline-v14-3-9d80fea5326d@wesion.com>
References: <20240910-wireless-mainline-v14-0-9d80fea5326d@wesion.com>
In-Reply-To: <20240910-wireless-mainline-v14-0-9d80fea5326d@wesion.com>
To: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
 nick@khadas.com, Jacobe Zang <jacobe.zang@wesion.com>, 
 Ondrej Jirman <megi@xff.cz>, Sai Krishna <saikrishnag@marvell.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725937530; l=10056;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=6rKptISgX+yTYN/ILXeFCE7UDdObYAJtbyRJTS9NOTM=;
 b=tPcsDlzGN/GthEJ/1dklyATX5NUY5tSDnxEV1V8freOXZlIqwyDDa3SwijABin6QOTvA/AA38
 S0RkqJl6MqLCbEzv/fMEZ8vhym8aQ+jwMHRnJZlb1wMDhpZfhuiu4j7
X-Developer-Key: i=jacobe.zang@wesion.com; a=ed25519;
 pk=CkP5TjIqHSwHJwZXTGtadoXZucYvakXcO3HjbR6FoeU=
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEZPR03MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2c5905-06a4-4d32-7f31-08dcd14574d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDRoRTV6VVpuVzFsZE9PUktFb3QzUXNrUzRETi9LL3FSdjVJZUZzNXdseUdG?=
 =?utf-8?B?MlZiSWEvdWcvM3ZVTTFWSzFhMFI5V0VDTExOZmZXd1ZuSi92dHVCMGlFdlly?=
 =?utf-8?B?Mlg5K2R3VFUrRFMyUmI0S3VXSVFxVStzTlFFQjNQYWkvWHl1K3RHSVl2NGN0?=
 =?utf-8?B?OWJOU2JFOEpiRFFEaWVNVE5kRGVSVnJTQnNlUXhxUFlPSUZEV0gzMTNLSW1W?=
 =?utf-8?B?SVJhNlVmdk85d3RaZXhHNERObnBXcnpzck1ISTZxMjErVXFOa3k0U3BFWEpK?=
 =?utf-8?B?ekYybVhoUjgzZ3BGcnhIT1ZWMDdaSWV0TVNKYlpWMDBTYmNaTUpBZ284aGs2?=
 =?utf-8?B?ckw5d1dmUWpUTytVMkxMSTZ2Q1Z2cklqaExlSTVSMnRBcS9IUTRjL256NFMv?=
 =?utf-8?B?VmJ6RXBtRnRNdHg4S2l1eGZ2TUZIWTlJb1RnUHVja0cxbFo1cm5leFl1bHph?=
 =?utf-8?B?QWJEOEw4bUE3dUZZNm1LbDZ0M2U5WEo3b2x0ekRITWtOeHU0T2g1czBuVjFZ?=
 =?utf-8?B?a0Q0UWRtL01YODkxeDg5aWFhWlB6UnZRcUlhcVpzUVhyVEhYekJadzFPbllv?=
 =?utf-8?B?U3orWVNHdWVDU0dkRHZrYTRwci9wSzIrRE00ZG1IU3o5YkRGZGV1Tmk5a2hU?=
 =?utf-8?B?ZDNockhpYVFNNG5mbEFwRmVqcDlLSjgxQ0Uwc2ZKQjd6b1V1azJkYWdzNlBz?=
 =?utf-8?B?NytRMW5Tc2VkTUg3T05VUWQyNXROY1hLbHZzTWhYb2t5eC9RakhFdVBWckhm?=
 =?utf-8?B?L0NEQ3NzM1FEVUJxKzBWbGNSK0pzNUd5NFlpenM0eGErL3JVS0VNckpQYTNW?=
 =?utf-8?B?TGp6bElaV2hDQlZyUHVvbUNreFdKL0ZFd3dSMHdLZENBRXhXTm5RNnduck9Y?=
 =?utf-8?B?endESkhHYVQ0RE1JQnZJWm0rV3p2aTJDWitNTEsrNUZhRjBSTG1kb1RQMEkz?=
 =?utf-8?B?cGwyZnpSa2cyTzZFKzZBYWdlRXdac1ZKckkvVk5TY2lYdHBpL2JZbUh2SXMx?=
 =?utf-8?B?S2tUck4yZXRjVFVOU0UzSjdPRldMN1MvNDRpaTNzVnlTTFZaYzR1bXZJWldG?=
 =?utf-8?B?TDNnRHdsMDNwLzdVNXJCMk0wWS9vaGxHLyt4UTdqajRiY0hic2N0QnFxY29z?=
 =?utf-8?B?QmFEa2RTVGdnSjJUbzN6bmx5dGY2SnppMmRUc3hydFpBN1p3WnFhMVpHaXJk?=
 =?utf-8?B?QkpwaWdDRUUxaGVaUmxhdzR5UkxSWk8wekFzTjdYVU9Sd00wU2RKclBKUG1l?=
 =?utf-8?B?N0hFR21KQ2wrb2hCMzhsYW5OaTloTUxEVVcxNnJYYklOendqUFMzWGdjTHgw?=
 =?utf-8?B?Njc3Y1NTUkhkSlp6ekVNYTl4aFE5RGxPaVdoWXBTcVIweG9QZGc1c05zc1Jj?=
 =?utf-8?B?NzBGMjFpWDlReEpSYnJYN0RIOFQ2azFJeUJuTXpLWmZadjM1ZnpEcDh0TUk3?=
 =?utf-8?B?UHVaanBWQkJET0hBU2JuUUJRS0tqalJOMDZDZTJFRXVsL0pqdE8ybGpWRUFO?=
 =?utf-8?B?VVBQUWFCQ1hqaXF4SEJlaFUrcERGUUwyZHkraGV5a0hOT3F5V0UvWTcrME8r?=
 =?utf-8?B?alpPaUhOWEJKR2kyUGJOYTJacklURUdpOERwUVhNM0F5Y1FMc0VEVUE0NHZ3?=
 =?utf-8?B?b2dmWk1la3d6MEJWcjVZZE8rMzNwSXdTUXpySlczWGRmdnlDMmZKOEpIRitk?=
 =?utf-8?B?L0JoTU9COVpHZTVtN0pnUmRTQ2tzNFd5elZKMHhsUDBhckE5Q053ZnRYME9W?=
 =?utf-8?B?REtqNXgyUkkwMFZBcjhkbEMrUUFyTS96NDJUOGFrcHZ5ZUdNT2t5QnM1WG5B?=
 =?utf-8?B?Zm1TdGVqUXk5UzlvblZycURoZkxEMXF6bGJvSVc3dFpDbjNYTjBBc1MxSXE1?=
 =?utf-8?B?S2FEZXMwZVdyaXVzM0tYTFBVRElGZDMxdWhtU25paHFxRmk1VEYwMTRreVpB?=
 =?utf-8?Q?SC/LSbT7YEQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFNiMnMrQklPMUtwVzQwM1lLcEZDSnF5WjdhSEdycXRRMVNMMEljdzdPOVVa?=
 =?utf-8?B?bzFRcHBFckxKNjI0OHVIU2NLTE9rWFZ3UUNDQ09xSUR5Tm5XeEoyN0pUbXdo?=
 =?utf-8?B?enFURUt6dXpLdzdKVjU3UVN0eS9oQ3BGRzFTcU1Bb2VNNCtlK0Nhakd2bGhQ?=
 =?utf-8?B?ejBUQzlHQ2RXUDRTTFdnclNHVGE3SGQwM0JEczNkSXRpYU5ZaWR4S0J4MFEv?=
 =?utf-8?B?UUpZKzB3KzZsdEtLU2FvcmZaOGl0QXNUeGxrY1BEaStMM2lmd1BMS0dVU3JB?=
 =?utf-8?B?REt4ZEhXMWxFUzE5YjYzTXJIa3NrY0pFVjBRNEtrbEc1L2tNRlg4VWw2elNQ?=
 =?utf-8?B?Z0d3dTBoeUZVZExlQU8yTEJGU0lLRUNlR2dhNUhzWVl1U1BzejdtOU5tUkxV?=
 =?utf-8?B?TG5tZ3FrZ1hIQ2RZak1VRmdIUTBVVVNBd1p3Y0V5OS9keTNadHhSbkhoU0hT?=
 =?utf-8?B?eWZZV3Q3YVBmNzF6bXo3bnQ1VTM2RGJDeE04dm5ZVHdoaDRTODFCaFhFM2Z4?=
 =?utf-8?B?SjREV2dYdHhWNWUrTFBiT3FhTmVwWVBlZ2dMMWNpZHhSTEJyb0VwdzlqSFBy?=
 =?utf-8?B?RkY4RUp5QlV1eVVSdXdabC9sRWxVL2JMSUc3RlJZam1lQmprNWE1QzFXMnZG?=
 =?utf-8?B?ZTBYZDNwd0g4MkxaSE1rTmkxMGVjREluK0lPNVNWWVZRcmczKzMzSWxDcThV?=
 =?utf-8?B?NE42QitVWTJBN3g4djZIbFMxVWtYQ2tHNGVKdXhuYzRYVkVrUjlJQk45cjlF?=
 =?utf-8?B?dDUveUdsczg0WGVaQXJoS1FDQ1lLajg1cmxtYm5IbUNOdnZ4SlhqY3ZQbkV0?=
 =?utf-8?B?QThuOFNJODJwU3FMRDlIZFhKb2s3NGFsWHRLL1ZJZHdYR0VvOWI5VEphaDZo?=
 =?utf-8?B?a1hXQklFaERGWnR3VGxxUlZUZnI3OFNway9jaTJFS01wUW8xWDF1UnBtamVn?=
 =?utf-8?B?elpjcFFBYmg2NzZZTzg0TnhkSmFZOVdkTU40YTVQZzNpQjBPTk5wSGJUOS81?=
 =?utf-8?B?eHBnK0trS1Y2TGFOMWNZaFNtZ3BQWWNVUlpRRjJHeUp4RGpwTGpCWXZjOTBO?=
 =?utf-8?B?eWp5WitFcVhjU2lzRzJPaytxaEFaRGxpNjN3YkREc242aXNuQkhYL3Y0R0pH?=
 =?utf-8?B?SXd3c1A4NnJBd1FCZ3doaWdGYlRoY3FPVmVFdmtmcEhhWk4yZnNZNEpxMGNN?=
 =?utf-8?B?L3d3MUl6aDA4ZjFOYldQSllyZjJac3FHQU4yVm1BcWxTNk1NZTkyWG9uUzZG?=
 =?utf-8?B?K1B5b0FFOVpLUHFnd2J4cHlzbjlVRjg1RHdGSmpvV3h5am5NWE1FUElCSGNY?=
 =?utf-8?B?bVhOQStCSVlIYmlQYzlwTmZJNUtvQ2xTM1VYL3lCUFFKRU1RR0t1OHQ3RVc4?=
 =?utf-8?B?blR6TCtPY0poOWVydGNLNyticTZod0ZPZzBoeFVIenI1S0hESWtQbTlBdXJh?=
 =?utf-8?B?QWYvNGJYNTV1RlVTVVV6d2ZQTW9EdC90R0Jqaml3NHk1cEY5dmdoOW1pVWV5?=
 =?utf-8?B?RmhjUUdvNDYweEF1dzZxdE9JVkVHQ1BQUk9PZUlIVG9BWjNNVW9CdGtpaEhi?=
 =?utf-8?B?c2pvcWFQVlhpUlJ1Yi9TUnJmTFN2QkVJaExJcXRicGdWSllvU2QwaFFBdkEr?=
 =?utf-8?B?dUJmWjdMNXh3UWFkVzdtaFh2eDJXTzh0d3JsM2tyOG9aL3dxem9CVDNyRy9Z?=
 =?utf-8?B?N0o2eG0yK1NWeHJ3YXNMZEM0cS9MRnMyOXh5NnBLeVRkM2M4Z0pEakp1UndS?=
 =?utf-8?B?OUtOVkVjT0VqUXFlQXNmcnNTU0VBcHZ1N1JPNnMyQVRtQURBVS8zMWc3TDRX?=
 =?utf-8?B?dVo4M1doU3pYTmovd0tTc0dsdC9GbitUNkxBbm1kZHNEZEI5aDRTaDJQTlRO?=
 =?utf-8?B?VkJjWkU4azhKZVpta3B0QlZzUTNCZWJFUmJBR0lVdHJscktzN0MxTk1XYkFU?=
 =?utf-8?B?Yy9KSjMxZTV1ald3MHAxTC9NTVpXZGRSMDM1QWtaYm5QR3B0UlRuNnQzQTdx?=
 =?utf-8?B?cHFCZDFNVmZEOGovWnlVWVhGNWY1VCtLdHFkeTJxUmZmOUFhVnhjK1U5VTVH?=
 =?utf-8?B?cXl2cVNPWXZ1VW9PMjVGenMxb3J4VVVUVHArcUM5aUdNbjNiK0c5dlRMUDY1?=
 =?utf-8?Q?UUtxAWqNUGHpAiK2/JmZMI2lx?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2c5905-06a4-4d32-7f31-08dcd14574d8
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 03:05:42.4386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spXNor9TBsnaslc2DKD7jgHPiRpnkU661dckIMn5O6jQi8joDIFhmeQfDunVJQ8oEnCo9qKNqy3K8q9uj6MEJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8442

WiFi modules often require 32kHz clock to function. Add support to
enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
to the top of brcmf_of_probe. Change function prototypes from void
to int and add appropriate errno's for return values that will be
send to bus when error occurred.

Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |  4 ++--
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  |  3 ++-
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.c  | 25 ++++++++++++++++------
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.h  |  9 ++++----
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |  3 +++
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    | 22 ++++++++++++-------
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |  3 +++
 7 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index d35262335eaf7..17f6b33beabd8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -947,8 +947,8 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 
 	/* try to attach to the target device */
 	sdiodev->bus = brcmf_sdio_probe(sdiodev);
-	if (!sdiodev->bus) {
-		ret = -ENODEV;
+	if (IS_ERR(sdiodev->bus)) {
+		ret = PTR_ERR(sdiodev->bus);
 		goto out;
 	}
 	brcmf_sdiod_host_fixup(sdiodev->func2->card->host);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index b24faae35873d..58d50918dd177 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -561,7 +561,8 @@ struct brcmf_mp_device *brcmf_get_module_param(struct device *dev,
 	if (!found) {
 		/* No platform data for this device, try OF and DMI data */
 		brcmf_dmi_probe(settings, chip, chiprev);
-		brcmf_of_probe(dev, bus_type, settings);
+		if (brcmf_of_probe(dev, bus_type, settings) == -EPROBE_DEFER)
+			return ERR_PTR(-EPROBE_DEFER);
 		brcmf_acpi_probe(dev, bus_type, settings);
 	}
 	return settings;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index fe4f657561056..6d90be9529012 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -6,6 +6,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_net.h>
+#include <linux/clk.h>
 
 #include <defs.h>
 #include "debug.h"
@@ -65,12 +66,13 @@ static int brcmf_of_get_country_codes(struct device *dev,
 	return 0;
 }
 
-void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
-		    struct brcmf_mp_device *settings)
+int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+		   struct brcmf_mp_device *settings)
 {
 	struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
 	struct device_node *root, *np = dev->of_node;
 	struct of_phandle_args oirq;
+	struct clk *clk;
 	const char *prop;
 	int irq;
 	int err;
@@ -106,7 +108,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
 		if (!board_type) {
 			of_node_put(root);
-			return;
+			return 0;
 		}
 		strreplace(board_type, '/', '-');
 		settings->board_type = board_type;
@@ -114,8 +116,15 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		of_node_put(root);
 	}
 
+	clk = devm_clk_get_optional_enabled(dev, "lpo");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	brcmf_dbg(INFO, "%s LPO clock\n", clk ? "enable" : "no");
+	clk_set_rate(clk, 32768);
+
 	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
-		return;
+		return 0;
 
 	err = brcmf_of_get_country_codes(dev, settings);
 	if (err)
@@ -124,23 +133,25 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 	of_get_mac_address(np, settings->mac);
 
 	if (bus_type != BRCMF_BUSTYPE_SDIO)
-		return;
+		return 0;
 
 	if (of_property_read_u32(np, "brcm,drive-strength", &val) == 0)
 		sdio->drive_strength = val;
 
 	/* make sure there are interrupts defined in the node */
 	if (of_irq_parse_one(np, 0, &oirq))
-		return;
+		return 0;
 
 	irq = irq_create_of_mapping(&oirq);
 	if (!irq) {
 		brcmf_err("interrupt could not be mapped\n");
-		return;
+		return 0;
 	}
 	irqf = irqd_get_trigger_type(irq_get_irq_data(irq));
 
 	sdio->oob_irq_supported = true;
 	sdio->oob_irq_nr = irq;
 	sdio->oob_irq_flags = irqf;
+
+	return 0;
 }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
index 10bf52253337e..ae124c73fc3b7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
@@ -3,11 +3,12 @@
  * Copyright (c) 2014 Broadcom Corporation
  */
 #ifdef CONFIG_OF
-void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
-		    struct brcmf_mp_device *settings);
+int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+		   struct brcmf_mp_device *settings);
 #else
-static void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
-			   struct brcmf_mp_device *settings)
+static int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+			  struct brcmf_mp_device *settings)
 {
+	return 0;
 }
 #endif /* CONFIG_OF */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index ce482a3877e90..190e8990618c5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -2452,6 +2452,9 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		ret = -ENOMEM;
 		goto fail;
 	}
+	ret = PTR_ERR_OR_ZERO(devinfo->settings);
+	if (ret < 0)
+		goto fail;
 
 	bus = kzalloc(sizeof(*bus), GFP_KERNEL);
 	if (!bus) {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 1461dc453ac22..a9b4d560cbfc7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -3943,7 +3943,7 @@ static const struct brcmf_buscore_ops brcmf_sdio_buscore_ops = {
 	.write32 = brcmf_sdio_buscore_write32,
 };
 
-static bool
+static int
 brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 {
 	struct brcmf_sdio_dev *sdiodev;
@@ -3953,6 +3953,7 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 	u32 reg_val;
 	u32 drivestrength;
 	u32 enum_base;
+	int ret = -EBADE;
 
 	sdiodev = bus->sdiodev;
 	sdio_claim_host(sdiodev->func1);
@@ -4001,8 +4002,9 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 						   BRCMF_BUSTYPE_SDIO,
 						   bus->ci->chip,
 						   bus->ci->chiprev);
-	if (!sdiodev->settings) {
+	if (IS_ERR_OR_NULL(sdiodev->settings)) {
 		brcmf_err("Failed to get device parameters\n");
+		ret = PTR_ERR_OR_ZERO(sdiodev->settings);
 		goto fail;
 	}
 	/* platform specific configuration:
@@ -4071,7 +4073,7 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 	/* allocate header buffer */
 	bus->hdrbuf = kzalloc(MAX_HDR_READ + bus->head_align, GFP_KERNEL);
 	if (!bus->hdrbuf)
-		return false;
+		return -ENOMEM;
 	/* Locate an appropriately-aligned portion of hdrbuf */
 	bus->rxhdr = (u8 *) roundup((unsigned long)&bus->hdrbuf[0],
 				    bus->head_align);
@@ -4082,11 +4084,11 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 	if (bus->poll)
 		bus->pollrate = 1;
 
-	return true;
+	return 0;
 
 fail:
 	sdio_release_host(sdiodev->func1);
-	return false;
+	return ret;
 }
 
 static int
@@ -4451,8 +4453,10 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 
 	/* Allocate private bus interface state */
 	bus = kzalloc(sizeof(*bus), GFP_ATOMIC);
-	if (!bus)
+	if (!bus) {
+		ret = -ENOMEM;
 		goto fail;
+	}
 
 	bus->sdiodev = sdiodev;
 	sdiodev->bus = bus;
@@ -4467,6 +4471,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 				     dev_name(&sdiodev->func1->dev));
 	if (!wq) {
 		brcmf_err("insufficient memory to create txworkqueue\n");
+		ret = -ENOMEM;
 		goto fail;
 	}
 	brcmf_sdiod_freezer_count(sdiodev);
@@ -4474,7 +4479,8 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	bus->brcmf_wq = wq;
 
 	/* attempt to attach to the dongle */
-	if (!(brcmf_sdio_probe_attach(bus))) {
+	ret = brcmf_sdio_probe_attach(bus);
+	if (ret < 0) {
 		brcmf_err("brcmf_sdio_probe_attach failed\n");
 		goto fail;
 	}
@@ -4546,7 +4552,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 
 fail:
 	brcmf_sdio_remove(bus);
-	return NULL;
+	return ERR_PTR(ret);
 }
 
 /* Detach and free everything */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 8afbf529c7450..2821c27f317ee 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1272,6 +1272,9 @@ static int brcmf_usb_probe_cb(struct brcmf_usbdev_info *devinfo,
 		ret = -ENOMEM;
 		goto fail;
 	}
+	ret = PTR_ERR_OR_ZERO(devinfo->settings);
+	if (ret < 0)
+		goto fail;
 
 	if (!brcmf_usb_dlneeded(devinfo)) {
 		ret = brcmf_alloc(devinfo->dev, devinfo->settings);

-- 
2.34.1


