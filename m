Return-Path: <linux-wireless+bounces-12142-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F949622B6
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 10:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B5F1C23F63
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 08:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9ED16630F;
	Wed, 28 Aug 2024 08:49:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2095.outbound.protection.outlook.com [40.107.255.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DD41607A4;
	Wed, 28 Aug 2024 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724834994; cv=fail; b=P4G9OCHSeOyeMgJxKyopx0fUHwRrV6U98CDd3EGC6VSZzrXnWEiMFEVwDslkRhL6jqU+0lMK765cXVv9WxqwE3NgRtGKgkA4vY1BSFFEcTx9eLevmY+eoG/flwD4lbKKGE4y6ZI//+0bm2YukcY5kusQeXroPpyo+QodB4TMCJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724834994; c=relaxed/simple;
	bh=m4jywguzwzc9q75AMLYOPix+C0ZE5a5MGA4IZ7EIp5c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UoqWE9d9HUss80j0Vtli/jnYb2rX+wKg00v3XTp65NxUDeGr/RxXGfwuT2GyyQzgPyZay4hyMyyBahYn02pRhQmWa3YQ5EfjVkTPPTravduNYWoxJXw92JApp6XsSClFtBwTON/0Uut1ZIO8k9ukkaqVSn6ebdAUgPjKvdc84aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqY37MC2ZS+j8Ug/hRsjngL3ZfvVddkvyuBsy8WMdlkoDUqKdTpdC5tuJhhPCd8AMmysajE8pftEXSKUyTRTHc3wUE7p5q+WmUOdI2GdGJBfYTtb6rl55ZzbHfJBXwptsebrkTo5NRAL3QFPHoYCDDN++VAu/aymlUI3AEdab3rS3GOM0pzOM/KvlLDle+MKlVp09lGQJVwKZCkUN1RnWFZIezPMVcQ/6OIPgBr0dvVSG1FbhFGsSCxR8yHuvL2ur7Lc0hbv1RqX+78pGufHYlXuNrF0fSOY6YxW1mRhAhWzjmOgb0BIsvc7b2h7rInCzblPp1lLTGbSg53PiPxSGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/E0WGgE6Ehzy8g7GiG6jEMXz/oYkQ2gd4cyn/tSzSs=;
 b=fOi5IQQBJLr/9lCwQuQbpI8te1+A9Lia6tN2DWzXffxGGCFCRHnFwjkAhsErDhO22cjwCxd19KEXQGZ6efITHaL/7mb9M3JXrGj/jiuOQFP5ZFtEQn441IFrYNXpKl4pzZvOiNHxipuu6yRlGpij6uRDb9EHnkgQMsTCKr8idKH0Cr9ZaLgad8OfaduXLoRh+Jnmq7wFcrnwcQW1ZFyrtVK1xL4H3C4lO+bMlpXzlZ7n2F+Tqu5Xz4ZXdc+MSOVc2wRYThbeKkKFiQZgRJ+D6ZCoM5daW80AQ9452YtGrGUaM5OC2IkgXfGmsfU1R0OowbYgCXIZ6tyT6PVjh1FDYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB7382.apcprd03.prod.outlook.com (2603:1096:990:12::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 08:49:47 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 08:49:47 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
Date: Wed, 28 Aug 2024 16:49:23 +0800
Subject: [PATCH v13 2/5] dt-bindings: net: wireless: brcm4329-fmac: add
 clock description for AP6275P
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-wireless-mainline-v13-2-9998b19cfe7e@wesion.com>
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
 Jacobe Zang <jacobe.zang@wesion.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724834980; l=1192;
 i=jacobe.zang@wesion.com; s=20240828; h=from:subject:message-id;
 bh=m4jywguzwzc9q75AMLYOPix+C0ZE5a5MGA4IZ7EIp5c=;
 b=KLeLsBimKFPzRuZaHBiU35cL7qhe80ZdQpq9Uch1ta4xStmMh/3ido45vVML24qXKq1gWoPjY
 qiBQ9za1WqKDXIpQsTXctY9lnSHjmislTAOkRZoaj4K/pA+JpOrwOZe
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
X-MS-Office365-Filtering-Correlation-Id: 78843d66-a255-44d3-ef52-08dcc73e5eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjZkUVdoQ3JvbFVQdTEzOERPdGJnT1ZxY3VLNzA4UDlveHJiS1RFa3dlem9y?=
 =?utf-8?B?WG9MazBRcVc2R2NMR0tzWXVSV1U2MElMZitSd0ZKRm5LYkVleW5LdDIzZEpY?=
 =?utf-8?B?eGNvcGpaOEZjTXlaRWlsWVVuNDRaTFNiS24vcmxRdnVDTW81eEdlOWFRbGgx?=
 =?utf-8?B?R1B1bG10dDU2enNLeHBHdG4wREo0VUZicEl0cVA1WmY1eXEwS09mYVFJcFpL?=
 =?utf-8?B?WkZxWVZPUERMUHJhUThWRUdnT0IveXhnNFRVdGxIbDlEU0FJSDJDUWtmajdH?=
 =?utf-8?B?VDVIaHlRekVQN0ZtbHlMbWFGUCthN0lHQTFYM3hYUTBHTXloQ2ZrNzZUZzk2?=
 =?utf-8?B?NkY3Ny9wOGhwTGNKR3FRNlFURlFwdzR6Q1VydkZTdEJzWWdtZytRRGJPRFlo?=
 =?utf-8?B?c2pZS3pFalV1SnRibTR4S1R0WUh6MzhUTU9Kb3A0K0NnTmsvVTFCa2QxWGR6?=
 =?utf-8?B?UzB0TDBrZkJzbEdIcGlHUDB2dDBtYjBuN0Z1MjlNN0NNdlRLYzNTNFVDUUxF?=
 =?utf-8?B?b0FUcndjelB1Q29hSEVOS0duK2hsYmFEQjZaQm5MZ0hjYTEzSmZMRDlmRmJZ?=
 =?utf-8?B?d01kdm1aZUNwc1d0ZVUrUmxPNTVKOGhZUWFKZTFtQ29EeTZrRktmcXcwRGRq?=
 =?utf-8?B?ZWhwOFhmYWI3d1ZPdzdVSDhuNlA3Y0pFOFNyRjNUaEgyZGh6emdXa0NtdGhP?=
 =?utf-8?B?cE9VK0NBdFlKWmN6dGJvcDk4TWgxZnkzTXNTNE5udHBiOTE5VGMwUll1MVFk?=
 =?utf-8?B?RTFQWktmbkRKNkdtMTZTUVFvSnRhZnNnK0EyMGRDZm9VSWFoMmZpWXNXc0ZJ?=
 =?utf-8?B?blUraXh5dElLUmJEOFViRkVCUkRSS0FrbEhGRDlpWk5BN0l6cnMxdVQ1OXFW?=
 =?utf-8?B?aS9rZWdaajkzY25yUTlHRUZjamR5bjJkSlI3endYWDRZTVRnZXdLcTZncW5P?=
 =?utf-8?B?WGdhTmxoSHhjbTFDTTFQUHg4amhGUVM0ajBPMG4yYTBXUXphMllLcEVOOWx6?=
 =?utf-8?B?UjdhMDU1THUva21MOTVlUHdROS8zYkwzTXVHK2tlZVdYcHYxSlVPYWZYbmdE?=
 =?utf-8?B?VTNIRElVa0hjVFVXY3REc200dzdWYmJoYnp1M2tydFFoTmtrbVJtSTdqUXZx?=
 =?utf-8?B?N3BxVlJoK3A0bFBnM0tNUzY2UHZSQ0sycWFQTlVBRHFpUzVVSERRdkhaYkVr?=
 =?utf-8?B?WGFMQTNBQlVGSnkyZDZaOEZKWXVnb1BGT0J0S0diNHVLUkxDZW1iT1dCVmtr?=
 =?utf-8?B?TmdLbFQyYUcvbFdmUEloY3hRMjZnM3Z0UkkzREMyYWlOYm44bVhrRUFsVzc1?=
 =?utf-8?B?NGxQdytGUjlBbXh4K1lsWmRDRE53VEVjNlZEVlRsbVJvV0FVS1AwdG5ETnRV?=
 =?utf-8?B?V0YrQ2hJd1BxcmFkYkdRVGlSdGU3djE3WGd2NmVaUmp6dk5TVkhIRi85aWhD?=
 =?utf-8?B?WVBvSEZlZjhaS0VQQ3p0VGpFWS92dmJKNzI2V3M3YmJ2bU5TUGliV3hqeUNL?=
 =?utf-8?B?MHh2bHFhNDdzZTA1dW1RSk5TZWl1cWtUaXZneHJjdnpqZStDZXFJNlpVNTBx?=
 =?utf-8?B?TUlrWUxXMjlreWZPaE82UjFobHJKMzFEd2xmeFoxMGpyQjFUWGk1SStkM1NR?=
 =?utf-8?B?bVE5RkRlWEFMdTNzUUVWQk9TcHpzZE1mc1pIWXhLYW42OU9GWkJJUFo5NmJ6?=
 =?utf-8?B?bUVVZzZSZ0Fkd0tRcEk5SjRyWWdINVlVZ1VPa2RIMkxnMEdPam9heUtQN01n?=
 =?utf-8?B?Y1NGVDVLK3F0Y2hIWE0rRURsLzF1UE9uT3A4N1BGU0szcHJMQS81WEhBanVk?=
 =?utf-8?B?OVJpSWh1aFl5YWNXY0NIOWVwWGpHS0xIcWZ4T1hsMGRLQXhyQ3BUYkZMUWZO?=
 =?utf-8?B?a3kxRnF4bGxrZVZRaTU5RFk2bjZ3dHJvTXNmMFY5VVFyaHovYXdLNHY5N2Zs?=
 =?utf-8?Q?Wjm5gDkoWXw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2d0SWMyWWdObjV6Wjd0QUxnTmE0MENkenlYMUJwWG9wVkZnSFFBb3JoUFRU?=
 =?utf-8?B?dUtFb0tqdlNtK1JJaVYyM3MxcjRWeGhSb3JNVVBDa3V6M1djR3dscE5vUnpu?=
 =?utf-8?B?MTJCSWU5eEZPd3laMW1lY2ZkZTUrT283MjJBVUIxWUlZL2NRdXgvTWx1MUxp?=
 =?utf-8?B?Rzg3VXJJOFhkcDE2OW9kSkpEYVpqUUlpdCtoWUtnNkdySENIcEVHR1FFSm91?=
 =?utf-8?B?bmRtRXBqNG5iR0xwQzNkN0lmWlRkTzJqTThld2RvbXJWUWYxN1Z5SmMyOTdv?=
 =?utf-8?B?b0M4RFBMWmpQdkFYeTZqZW5NNy9QblN3OEYzakZaVE1Jd0hpN00rc1NrdGpM?=
 =?utf-8?B?Ry9yTTROZ3MvZmdQbmJ5T3hDYjYzRTAxaFByeU1IcmJDVURSMWxucE1UWVpr?=
 =?utf-8?B?MVZkd09VMnNxOFVnQnpPb1RkdUdWcHZnQmRoQ1Q3UnZaaTgrMUhhSDZhaG5x?=
 =?utf-8?B?cERHM010VnF0SHlDbGVITU5DR2s5NFUxUy95UmYyaEViSm9wa2ticmxFekI0?=
 =?utf-8?B?aDZlL0JYcFcrT1k4dGpQTURpVkVQQ2JoK3dEbGF0eDZTZFRQQTR4ei84a1Az?=
 =?utf-8?B?ZzJ1NVFacXVRWWdJVCtSY3piUFR6aktGcXlMbm9yNFhuUWJoYi8yVFlVcE1T?=
 =?utf-8?B?bm9WMHNzMXYreCtKRGZ3ZlVFYU5vQk9adWZUK0hKRzVmMW5hM2NnT3RnWmpi?=
 =?utf-8?B?KzE1eXBrL1phODJiMjdaWnYwTWM4RUVxRzluVTV6Zm53ejRWK2JpeXA5Z28z?=
 =?utf-8?B?YnVSeXJZM25ndXhNaVlzQXB4Z0xIZHJaTFMwRGt4WmU2V2ZaSmQxVTdMbDhO?=
 =?utf-8?B?RHVFNW1uY3BMai8vV1RKUDNXa1kzV0ZxRCs5MU5rVndOY2RZY1BxR2ZCSmh6?=
 =?utf-8?B?VWY1cVhpTUJ5cU42UHRMR29FUlVJUGpIbWJTQllxcllvZmwrTGFFNDVHWDJD?=
 =?utf-8?B?UTJpT0pLUEVEV3RIaHdCdTJUSTcyYmVtUGR0Tmo3Tk50WkttU0VMbnROb05j?=
 =?utf-8?B?YlNyWk9telkyUXBDSjRaRkliSWM4UG1Fd1Jtekc5Tk1saTd3T0Q5UFRrOWlh?=
 =?utf-8?B?YmFxZUNKdEVrZWs4MHRhOG4rejBFdUNWL2t6OXhtcTNrYXNUL0lUZ2piamV3?=
 =?utf-8?B?OXNNNmloeXVXcFMwL2F1TW42TDYwK2tqb2k3UU5hSE9reGZSaERQazd4SE9P?=
 =?utf-8?B?cVU3cVMvNGpZTk80YTNIT1pUZXV0YnhObGhVaFZZa0Q4bHV0eW1scGViMWdK?=
 =?utf-8?B?Y21MOHNsNkYrK2V1SWk3SXJkUTNsSjJRNE14ZE5Db0hidlB2ZU9oTlVvNFMv?=
 =?utf-8?B?SVJQR241MWlBUGt6NURkeG5RYlpjSytMUTVZRUVadVZUUU9JdXhmY2VjWmlD?=
 =?utf-8?B?K2VLU1pjMi9OSXB1bTI5NE40OC9qd21RN3dsU2lFUTh6bHlOVGhGUTZham1n?=
 =?utf-8?B?WWV0T2p6MVM5Z1g0T1VscUhqQTlOTm5hTmV3cmRrVXAwYkI1eXVMMGUzY0lx?=
 =?utf-8?B?QkF5bkgvajhwYktuZzl0a1ZUcDZ1RHhmZkd3cEpHaC96UDI2VXM0aVNodDZN?=
 =?utf-8?B?UFEyZkVjVG1mcE54VUo5VzlwcEkxWkFOZXNFNU1ZRmRqZGc5VW8wbU5qWjVu?=
 =?utf-8?B?eTlmalFUZ0F1Um1LUURIQ09RcXRteWt3c3BFN1dSZ2pxZEJucERiN2VKUk13?=
 =?utf-8?B?cXFIUGVkbFN6VFhjd0RrR0VjcUE5SEdPR1lXWUh4VjBxS0E4WWZFdjk5RmFn?=
 =?utf-8?B?UFkzT0JzTE0vdjdsZjZwaFB0dG9ldHE3emtIT2NiVTk0QVJnK0VCekVhQ2Er?=
 =?utf-8?B?STE3ZlNUTm1CeGhwRXdONkxkMmZZVFliK1dBdGNuckRqZUpxbURvL3BPaEU2?=
 =?utf-8?B?Z3BSV0dJOGRNU1pwZno1SHZjbWU0TnNLL2VicFZodFExVE54RlVvck9NS3V5?=
 =?utf-8?B?TXhRUmp2QWxFaXJBazk3ZzhKRTFyakljcS9RQk16cnJNYkt1MDF4M2Rma1BU?=
 =?utf-8?B?WTFVZDJrcGNaNk1zT3hQZjIrK0ttVm4wNGZTTVRkQUZLd2ZYdGs1WUVqWmtR?=
 =?utf-8?B?cFBiYWo3QUlEMDkxRk8rMjYwdjk4aXVmdXpxVWJqMUl2Yi9WeElOMCs1M0Ju?=
 =?utf-8?Q?7uhZgHRTwjF+Ijncso+gvNFWt?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78843d66-a255-44d3-ef52-08dcc73e5eba
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 08:49:47.1711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEwKr5N0HjvGbJdclkDqz9owosX+cWtZg+pPx1TBWBVhdD7efDDPDU77b6QdhHbf8eOqmjqmyY3XMqF2hP66cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7382

Not only AP6275P Wi-Fi device but also all Broadcom wireless devices allow
external low power clock input. In DTS the clock as an optional choice in
the absence of an internal clock.

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml       | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index 2c2093c77ec9a..a3607d55ef367 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -122,6 +122,14 @@ properties:
       NVRAM. This would normally be filled in by the bootloader from platform
       configuration data.
 
+  clocks:
+    items:
+      - description: External Low Power Clock input (32.768KHz)
+
+  clock-names:
+    items:
+      - const: lpo
+
 required:
   - compatible
   - reg

-- 
2.34.1


