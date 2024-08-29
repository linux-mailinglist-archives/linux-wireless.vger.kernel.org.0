Return-Path: <linux-wireless+bounces-12190-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D32899636A1
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 02:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF3B2860D7
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 00:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98720A29;
	Thu, 29 Aug 2024 00:05:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2129.outbound.protection.outlook.com [40.107.215.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669BE17FE;
	Thu, 29 Aug 2024 00:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724889959; cv=fail; b=MnbpCrERFLHGC14Wfpz2eZaQN7CLu16QYm4i0/hx3Z5jGfmC8XtXVQWkP0v2siWEjEf4vy+ZN38vartDceqkFuOWRQlY3kriS8Deowwy9qeWUy5DYGpTU68p7lcx5Su4m61+7uENEesBJrTyNeVySfOuHI9uFmv9QjfWy9BEpkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724889959; c=relaxed/simple;
	bh=3YyLAKZmos6OvnyNnjrH5/H8aerpeY5nK/ANjSPhpFA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oX6Y6M9s7wq+qnR4X9eY/QcQQB4aAPuEeTx9s5fsJKZEaWj6upjgN2N2hK7ofEY1JVuJ3IpMXWPUCEqhXfbrdAHyBnkOi1yr+HTJtbtinOq9nTYQqTDTnPsnmuSXL5EBdJkBij14KcSn2+MqNedRLNH5s/SDpSeF0D9lB5hqJYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6I8c4+rfqr30dx51z7rSzgs5mtZsiwLjk8kfhRhE0l7v5qfbaeKESEOk71O6No2VO8ULnkg9nffY1GjjgTh/dr7E29+6lv/4PTyg7UYdeizmZAzBucGKBAzwvcr3/xiHIpWFP3uE/ikhInHHxBzGffka0j2wW/K29fkWlLlmK3JuIYzHA946FKmEeM810/pMm1MttNPx+QVGVcu+6flMin4NgvMR0lHfWh5g53SXIXc94/mmGlOxBhJiWBoamyJVlqmkHVDk3c977IcEsYXpBZdtGNvArU6bnPUB33pxOSap9i1lZFdjlonXaEpt1gxGK9R5/8gNih/fzWb1r6AGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPQoAPqZHwQg0CSTbjqUsDidPYqSKrodwVyrFrRBnyY=;
 b=HSmsFeQDmrgr8BXFah/GJhBiBwJPBSiQUes/oELmzNBCWu0OEQ3KqRTe7ojQFvnOcNFrwin+GW3T0thEA2C9O8EmzmHHdoaLEoDUS/DnHyCtk7lXDFGCAXB8pfYZ9ohJBoZgfk4EH6bc0tyFAZnEe8JYy3FEAhLMQV4c0Mzy4UwVb4MjewNB7FQGUo4NTnUkw5a2x/IsQefgSx31d7Lzjv5pO+pXKELI34KoaeO0C4KgysR2NGaqFXNWUWnw1ptQ5wilbxgRKLx5IKlB+T+3lrrZT825svay5Ku355ALBHatY1cW8Ez5ebK196bZ397STPZO/RDivTCWR27M6DdjpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEZPR03MB7775.apcprd03.prod.outlook.com (2603:1096:101:126::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 00:05:51 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Thu, 29 Aug 2024
 00:05:51 +0000
Message-ID: <a6ff2ff3-f249-4fd4-b152-843e2872b1af@wesion.com>
Date: Thu, 29 Aug 2024 08:05:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
To: Simon Horman <horms@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 Ondrej Jirman <megi@xff.cz>, Sai Krishna <saikrishnag@marvell.com>
References: <20240828-wireless-mainline-v13-0-9998b19cfe7e@wesion.com>
 <20240828-wireless-mainline-v13-4-9998b19cfe7e@wesion.com>
 <20240828152019.GQ1368797@kernel.org>
Content-Language: en-US
From: Jacobe Zang <jacobe.zang@wesion.com>
In-Reply-To: <20240828152019.GQ1368797@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0187.apcprd04.prod.outlook.com
 (2603:1096:4:14::25) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEZPR03MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 118cc831-2479-4cc5-a9a5-08dcc7be57c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUZlYmxWSXgyajB0eUhzY20rNVZpOGt3dUFqRW1zbmcxb0swMzVrR2c1SEwv?=
 =?utf-8?B?SE54U2ZMTDJvMlJtZDRzeVhBUjNuZ0xUUXFqZjBGVTV3c2VlMmloYmFoTkM3?=
 =?utf-8?B?OTNrOEZwOFNPM1BLMUhScElpZHpIb3BXcHRXNkUxUmU4MHhvSzNlaDJkTFhw?=
 =?utf-8?B?MVZJL1BZRXI3V2JEYTgxT1o3ZjlqOE1TZTY5RWk2ZWtYZ2xHVitvV04zdXFi?=
 =?utf-8?B?aWFOMDl5THFZVUs4RnlxTm1nQml0STYyK01DOXpGcEtqT2JseWxpVThZbElO?=
 =?utf-8?B?d0lHTjZrMHRlWk1RWnpHNEM0QjlOaG5XOWVXZjREaDlGWmR2VnBRT3lHNGVQ?=
 =?utf-8?B?bTV4d1hLb280VFhnL3NtNXFsaFc4MTF6VTlWOFp1S0hseUk5aVJrU1FlbzBV?=
 =?utf-8?B?cnJxUFJtK1dSbHZxQ0NIMzQxL280dUdKK3lrbGVTT3IwVlFNNkxTZ1BmWTNO?=
 =?utf-8?B?dnlqbm5KaGxCZ3IwQXBUNnVlVzR1K1lsMzBNZDFnOEtTZTM4d0czR1Urck5B?=
 =?utf-8?B?bENqVUJrU3ZqdVQ0NHRxU0dHT1k3MzFWUmpweHBlRWhiU2tabWtzUThxSmRo?=
 =?utf-8?B?cHZXeFpnMEJDZUN1M2JiVlY4d0lVR2JQVFBVMVhldEZRYlpoQTllbEQ5bUtJ?=
 =?utf-8?B?TjVCeC9jeHV1TGVHUjhyQVJEMDVET1E5WlNpMnpmcjVDd2VURTBhQTdHUHUy?=
 =?utf-8?B?R3VPcGU3Y05QcE93bjBCZGdDYUd6RVdhQnlFc0xJM21Hbk1wblQ0ckNiRHBL?=
 =?utf-8?B?dnFRR2t5TWpRTXh2WG5TS3lla0p1NXlBNzFSZlZZUHZaYitPSmhraHNBanBX?=
 =?utf-8?B?TFNnaXhJeTErK0VjZEZEd2pXNGhwdlBlZkF2am1DK200QmZ3U3NMYXA3VFR5?=
 =?utf-8?B?d0svYWRuQTVNNTFhUk8yWHAyWExrS1pOMXhXNnR0OXNqdjZrS05MQkpUaUto?=
 =?utf-8?B?OWRwNjlNTWZpUkE5R3R1Nmg4QkFKek9mUDU2T2xPcytsbURyVDFFNy80VERp?=
 =?utf-8?B?b1pCK2N0Z2VUR0tJci9mYjllNC9wUmJSdW0rK2hDNDVIdFJhOEV1YUo0OEVE?=
 =?utf-8?B?QStkNjdCbXAxSG1pV3Y3dmlEQWpkZUc3LzRYN1g5UEVBTnBmL1ZEeVVDTTNP?=
 =?utf-8?B?QXhsRFpaNVZZMXd0L3VKZG9UN3UrYUdHVmFmdHJlSks0NmtJandHMWZqakJO?=
 =?utf-8?B?QVNhZ3NuVm56QlZDN05pekp5Z1Y2eWw4dE5lNTAxcUo4SjRvM0o4YzNkUFZD?=
 =?utf-8?B?OUk5QUpnbFE2dzkwalRhaXd1WHlaU3NieXJIT2lLYXdsdDljZlM3VWc4a3lq?=
 =?utf-8?B?dVRSdmN6L3V6MTJkU0h1b0QvWDRmanE0UVMvblRyV1dsWElZTjBpbEhEU08x?=
 =?utf-8?B?aURTcGRaQkZCTExFL0E0RlhUdWI2NUVJNmMzcjkzQ3FGZnpENnFYL1NDSm92?=
 =?utf-8?B?QzZCdFBnVjhSRFRBWWNyVGY3YlNBWkptNjJINlpKWC9sSmxOZ0svMHYvMXhP?=
 =?utf-8?B?UTc4L25MaVB3MElUUUdIRGQyZUgwS1dWQmF1UHlNWUJsb2FrTlpKazR4Wm9G?=
 =?utf-8?B?cStZeHZIL0xMOHFpcWxDdTVUUjIxK0Z4cXNhQlpDSThQeW80YUg0aVh4Sk1U?=
 =?utf-8?B?Mi9xSmdMQ2NmREs4VldydnVuZHdWUDV6bldrSFJJZDROVmNQQ1k1RmgxUkRE?=
 =?utf-8?B?SVUrTGp3V2hHd1BuMXJEY1Z2ODF5cktERE9YSkQ0WXVnSmZQMGJMZllkTzU3?=
 =?utf-8?B?bjF1VFJtODM4R2JBUXAxYXJmQm9qdmwrWExFRE1yRmZzQzM0c0JERU1FNVZh?=
 =?utf-8?B?Tm1HRGozaUhXZTVWbzUrQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3JZM1hIZjFlVGJMaithZUpSUVFUSndXQ3NpRzNLWHlURTVIMzk2d1FXNXE0?=
 =?utf-8?B?eVBPOHBqRzlmendlQXlyVU9DOWp6MkVxQzM4bVBKUkI4cGRwemh4c1BIMHdC?=
 =?utf-8?B?QTAvU2M1Z2tldFA0WVZiUEIyTWxpNVkyUlJBaDl3aFBNZnVYVzM0T21ud3Vt?=
 =?utf-8?B?MFVTVkhEUjdDcERCZ2hlMnFoTXhlRVByN2pxeFkrcmFXSWZqdHNjZUQxSW9r?=
 =?utf-8?B?dmYrQ25NNlNqK1FjeEhkdEs4WjdJVlFNMGViN09OZVgwUDNydG40emVHTTNB?=
 =?utf-8?B?eklqaCtLRjZid29KaWZlVVBhRjJpVXYrNXdBa3JwTTFSTTBQak12SVl0Y2Z3?=
 =?utf-8?B?M1p2VEZUUHJTeWNPcVY1NkVtZGt5b2ljV29qU3FnM3NNRmdrWEZRWHFOYkhW?=
 =?utf-8?B?cXQ2MTFEUWRMNHdzZmNpN0pZM3VwTzFOK21oNUFKZ1QxZnE2QmxQZ3FLWUNy?=
 =?utf-8?B?NFJqK3ZGUStDcmNncmZxVGZiSzd3eitzbDNwRnJsMTZha1F3WTRjWUxPcXRn?=
 =?utf-8?B?UENCdUoyLy9tOEIyMDRjN1dMT09DdVJYOHNDVjB0T2dQL0VBQlllMGFraTRo?=
 =?utf-8?B?R1gvN3NhT01sY2F2eE1uRHhUbUFnb2REN05pcGFSZ3BzVTZ5Q3Z3M3E0N3BS?=
 =?utf-8?B?U29ZTXZxc2doR01UM3ZxRm9IbmtqWVlOSGVkNTM4ZWFGWHR5U0dXVThyZ1l1?=
 =?utf-8?B?aDljRXdIUTdwUlJuYytFRWlEZkt1eU1XdEJwMEsybU0wbWMrVzVFQlJiNkVQ?=
 =?utf-8?B?OGJzeGJRK0JnSFR6d3hKWEVyTWo3R0RCdmord2FpZThSeWlDUTIyUGQwYnhq?=
 =?utf-8?B?dWR5L0dQU3VHY2p2S1VVd3B0T3Zub0dwY0tsWitta1BlMDM1OWFJdGhqTC85?=
 =?utf-8?B?Zkk5Wm5PQ2xDOE1VdHpLRXFXaWRkZkxqNTZjR2NSSyszL3lKK3pUMXBMeG02?=
 =?utf-8?B?R2IzMU9xYS9BUm5LSlNzbGJ1NGxTVzdlZzJHS09jaW5ia2FLQngzQ1J0SDdr?=
 =?utf-8?B?U08vNVVuODh0a0dqUmZpYjJ3TjdqR2g5S2JPUkZCbkxlVEZXREJRbElpc0FH?=
 =?utf-8?B?cEcyUHVYRGVnSlY4MURhUVQzWVFST1hHZUxRalFpaS84MjBZaWtCSktJVDdI?=
 =?utf-8?B?UDdpTnJzbjVnd0lGU1dpV3c5MVhHb2RQMURubWVzSzcrd0cvdFZndHA1aXZI?=
 =?utf-8?B?SWp1UkFyQWw2TXgrSUtnTGZPZk5FU0dzVkNwUWdac3B5ZWR2a0YveUxtUFNy?=
 =?utf-8?B?eklxbHh6WmFTaU04UEREZWprZ0ZTY3lMeXgvYWt3Q3VrRHR4cjFCMGhGZGpD?=
 =?utf-8?B?cVRFVnFVeEwzTkR4M2hKYWlCb0h4S0hRU3plbUw5VU9yN0FKYmwvK3dsajNC?=
 =?utf-8?B?MTFHV0JUelMzcUxsM05Mb3RHQUdKWFJTa09yYU9CUzRRMEZDZXNheGhqbGhM?=
 =?utf-8?B?aFRDSkRGTE9STjJ1K0NrK09VRUE0KzlXNUltQks1ZmtiZWxkRzdJREw2L0lX?=
 =?utf-8?B?K0ZDYmQvdHJuTElqTVduVFp3ZWN3UHRxV2R1UEhEWFd0ZVVBVkJtQi8zMEdm?=
 =?utf-8?B?TSs3T2FLV0YxbytCbDNRVlhIZFNCZXRFTVo1cGk2SnlVYnhKTHNzVlFMc2xs?=
 =?utf-8?B?Mks0ZmtLa05MU1BsMEJFSEFIQXpBbkhqL0tpMmxTTFNEbEsreStIMnVSUUdt?=
 =?utf-8?B?WlE2L3VkMEJFbXlQN0o0a3BjMk1VU2c3cUZjUGJiWFlmL2VsM2M5cGpZa1ZE?=
 =?utf-8?B?Rk9pVm8vU0FiblZlaWZKSDFTckZkcTE1c21QMmlpY1o3M25ORmdncjU2bVhw?=
 =?utf-8?B?RVJVSjB0Nk1wWXpBZElzVVZoL3JqRHVDcENNYU9NRE5tRTRWVjZJZ29pQjd2?=
 =?utf-8?B?R2c1b2F1TXNsWDBXeDM4QjVQekg0MVpKYkpjNTI3L2ZBcHFnNEZjdDhFb0xR?=
 =?utf-8?B?V09ESzBBbEFUc0UxL3dNL0gzZXdDVDFXSW5YSUdRMWdzM3RUNkw4NnZ6eSt6?=
 =?utf-8?B?a1p2dmw3QTAwNTgzTC9mZGpMQnk0U080bzQyU0ltOExpbXJEYW1YSThRbjBB?=
 =?utf-8?B?QTdpaHhmZ2JhTDhVQzFnODJOMGZZZVFOdEJUaXVoQmZrL1pkN1AxMGY5Z0VU?=
 =?utf-8?B?UWR3TlNMYWZOZWJpWndzaENqSytDckVCL2puVXRPemthdlJiMDY0bW9KMjlS?=
 =?utf-8?B?dWc9PQ==?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118cc831-2479-4cc5-a9a5-08dcc7be57c7
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 00:05:51.1462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZH3cdkP5SLF20Mo1oqu06BV+PbycYQCX7uTTXFW+63vzUSw4FS8LBcKqUsfE0nEbGu/HL/7u4Qe2zMMQzaKtJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7775



On 2024/8/28 23:20, Simon Horman wrote:
> On Wed, Aug 28, 2024 at 04:49:25PM +0800, Jacobe Zang wrote:
>> WiFi modules often require 32kHz clock to function. Add support to
>> enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
>> to the top of brcmf_of_probe. Change function prototypes from void
>> to int and add appropriate errno's for return values that will be
>> send to bus when error occurred.
>>
>> Co-developed-by: Ondrej Jirman <megi@xff.cz>
>> Signed-off-by: Ondrej Jirman <megi@xff.cz>
>> Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
>> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> 
> ...
> 
>> @@ -4452,7 +4454,9 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
>>   	/* Allocate private bus interface state */
>>   	bus = kzalloc(sizeof(*bus), GFP_ATOMIC);
>>   	if (!bus)
>> +		ret = -ENOMEM;
>>   		goto fail;
>> +	}
>>   
> 
> Perhaps a local change didn't make it into git, or something like that.
> But this does not compile. As was also the case in v12.
> Please take time to test your patches, not just the local tree.
> 

Thanks for your correction. I will fix it.

>>   	bus->sdiodev = sdiodev;
>>   	sdiodev->bus = bus;
> 

-- 
Best Regards
Jacobe

