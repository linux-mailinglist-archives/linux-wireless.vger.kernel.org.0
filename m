Return-Path: <linux-wireless+bounces-11399-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D11495176D
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 11:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E1828456C
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 09:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34AC1448E3;
	Wed, 14 Aug 2024 09:12:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2126.outbound.protection.outlook.com [40.107.117.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EB4143C40;
	Wed, 14 Aug 2024 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723626757; cv=fail; b=KCynYdJCTtqcLMy24+5i+S7DCx4g0vcEi7iv5SGXBmBz6WDk8mVj5lUSIB//KziTPw3G8xbVYC0HfQkIuSrqUnGAs70XmcYc8KTR71hMEr0oLvSKdzIRmYhBANtrnS9z26b/K3AuLEzBz+iiNdxfSGdy52DKhxeZ/8U25T4cOw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723626757; c=relaxed/simple;
	bh=4WNb1Ixkn6UVoK8h2BWRr9J2Ra1XuY8XpkOosu3JM/w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wf8CG16mH2Es4c4g4k0Zdkh2y/HduCbxkp7pI8AjEZA3EvHLHNkvp+FlLH4BdpSoaR8CMwOn/+exaf/Jv9Jim9wP93IkfrWZxgGqQrdenioT+vZUZGKLGO56pC+pyijo+M5uBO5T1Uhh1m2GrID7gbEM6DtR9UdS2OwKCevh3tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQpueTpEDvFfy7vyNFlfPO8RXRIMm1IkHBLH4nItbcOv5sfjA2sPPLjc9DIjXXkUpoTbyimhkQXSJCV6zB8AhT5GAjLumr8iBqTPBmsIlryQYiF8W7BslCpDJSL+BTr8+Zf0ScDKDSqkar/neHcjbM3ey50GiYxXq/vuLH0vo+RXrC1ImMZAsIVHih86LRBaCdBpdERzSuQraF3VxPIeyiZQxJNMOoo2xYVIxuXw7DbUJZvLbtoTwS6kBaPDdioq968IkFZR34a2NhJ18oOfGX8ASVPp/iY83hsff2YT/JezYSJ61KzKZFApWX9t2XXRbiGYQIQ7PYjs3bo5fzAwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ekx+MKu3mtux56VZIxn0Fig16nNQE9oTOBsZXqmCnzY=;
 b=x/oZv2ryfGXu5tvcKHA1vB3hUmfZLEnyLZsc44fIxJoZPJ+BmsHk4xVopDLX1Ex94D/LmJkJwFtOMO8s/H6A1tzmp44ULXGHCnOqKwKIzuWOmjvp8JEjF6kjmSijg03ZhCp8/j+/b9ju8JDSnjJ1MOLC2lSKxGrcwAWDLBueCCyM7ujPPz5qOgVZobFbHfvqhRNSWKfgTOsnD4B0Q2i77s1rNZhSgQ+4gyKsQpoSUHl4FDYAy31FN9HTVVesDo1aaKnRrttJX0ToXYcsP30sfEYR2s8Jm2S5mj9Qf3Vd+tf/OPT8K4PIliTSOLPJr6Wz6Ym2yI6xZLvivFOgmg4G2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYZPR03MB7745.apcprd03.prod.outlook.com (2603:1096:400:421::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Wed, 14 Aug
 2024 09:12:29 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7849.019; Wed, 14 Aug 2024
 09:12:28 +0000
Message-ID: <05785794-6eca-4ade-a990-2deac7156c48@wesion.com>
Date: Wed, 14 Aug 2024 17:12:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/5] dt-bindings: net: wireless: brcm4329-fmac: add
 pci14e4,449d
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Arend Van Spriel <arend.vanspriel@broadcom.com>, robh@kernel.org,
 krzk+dt@kernel.org, heiko@sntech.de, kvalo@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, conor+dt@kernel.org
Cc: efectn@protonmail.com, dsimic@manjaro.org, jagan@edgeble.ai,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 arend@broadcom.com, linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 megi@xff.cz, duoming@zju.edu.cn, bhelgaas@google.com,
 minipli@grsecurity.net, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, nick@khadas.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240813082007.2625841-1-jacobe.zang@wesion.com>
 <20240813082007.2625841-2-jacobe.zang@wesion.com>
 <1914cb2b1a8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <e7401e25-7802-4dc3-9535-226f32b52be1@kernel.org>
Content-Language: en-US
From: Jacobe Zang <jacobe.zang@wesion.com>
In-Reply-To: <e7401e25-7802-4dc3-9535-226f32b52be1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0126.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::30) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TYZPR03MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 55e288b1-dc1e-420c-6c0b-08dcbc413873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	LX+UrrNMZY2ewFMnzYfCfQU0M93JBlTo1M2nvQUd9IzcWps5nE9Rjrpg763y0kf1JiAjUtrR/sKlDcLgPZWOSk99Gfnk+qYoFHlYlfv6WVesPuk48YBAbaz9e3/ZqfQlhhnvmqvVHDR1CisvZOclVgGFPG5I+/acDM40GxTy4G4+RAdz4vVlZ5v1sGgTfb7361rqDa7A0NnxVGEEfKwZrdxPBwptpyaj2z/4NOQA0jEw/QO01NtLiY/DOFXHHvVviEjF1IJYjF0zYxqA/yRC/kK8bvqf+2nWqbigegsYsVRId7aUqy6OXwm06sgZpv5QO1LOeCRSvxXV1naIEbJgre5h4HJpT/YMv3YTAnFOk6EnlHMgvB42hG8cJ68eAS1MVNOK1S2dA0igSOqXN7HgwUygE0wcvShruypDgoqMbCZWbdojUkrT1emTfHyqgEAr+GVwlhjrOoQnoSSvgsh7XmEFUviGsfcctd4PQIQTH/m49M9KbzVt3krFk6wmW0ArFu+hiqFpHARROAdr5a1y1m4yCCYVL9WlT3ApNPbbXY9vZSoo8fUGPNrbpDtLVu9D6qMa6EXvxIIN9LiIr+MtQpSmE4J6tgXzlflCizvmvYMsr2rKvtf/mKDA81S3qgaEeS4Hz5cqn2Fftel+fLIyBjiRGH8ICN56OAom2/8Vx63o+O7xiIQ6EHlIjLSmwBE29ZZZa0kHCVx6gif4XT+75g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGZrUHRvenpQU2tRNnJodGhXTTFLbkhMS09Ca0tnR05FQU9acnVqQWxlU0pz?=
 =?utf-8?B?WE5kT1A2WkJ6OWlhZlN1Ui9yV1g1QTZreHhPT3BwNm9QVnZORGljK0Njc3Zt?=
 =?utf-8?B?Qm5kYTdSTUpibzhHT1pPbnFoTFpkS0JQVkhLczZoZTF2TXVWUFUrb210a2FQ?=
 =?utf-8?B?ekZuRENRR2RTQSs4dFpYbTZQRU8rUWlTL1g2bERoaEhJeG1TZzlzOEp4VFRn?=
 =?utf-8?B?RUp0a3hCTzZRaHdsQjIrQzhPYjhUcUhVYWhvK1lFYTVTMEhWSzdxTlUyQkpr?=
 =?utf-8?B?K2NqMjY0V3RLaVZldisyOUtVSGFWU0FvcXhEV0J2TXhFQkVPVjlvK1FOUkxV?=
 =?utf-8?B?eERTdmM2Y0piKytOTWdGSTVaYlh6Rm5WbWUvTWdldSs2ZVoydUxxcHdxaVJz?=
 =?utf-8?B?YUVIYVpqS1FMeDlTczRaSlIxRy9xRGFzZVJMQlhCckE1UGplVWdKUXZXNWYv?=
 =?utf-8?B?NHZZM2ZYRXRESzVXYnV5TTl6Qm1XaWpWOXlFQzdNWkNhLzU3NEJxdE1sTkk4?=
 =?utf-8?B?UE5UK2g0NkZ2RXZ1MUY0TGE5SzRHTkRVcU14S250MzJmNlF6Vk5WQVlXaFc3?=
 =?utf-8?B?UnZZSzFUelhNUFdEY2twblJNeDRBT09WZmpqTVgrS09WL25keXUvclM2NStN?=
 =?utf-8?B?MEV2TnpOUVRYcjlaZ3hZMlFSc0VvZlg2MnNSQTZMZTBKTUdhWGtHNDc5QVBN?=
 =?utf-8?B?dTNFT1ZIaWp6MGJ5ek1Ga0dNWElFSExIZWtsSzZLUmdMTHRtbmFMV3pUVjJr?=
 =?utf-8?B?dkh2cDRBU1VQbkRRSERKeVB3Wi9NRmRNaytvTjBTcTcxVXpYWWlRMFpWbnBH?=
 =?utf-8?B?NWE4Wm92cGhPZGdrRmp4V2xJRGZUamVCSHUzUHZmOUdmV016dzNCbmNlR0k5?=
 =?utf-8?B?RU10aEZNd1R0T1YvVGR1Y3Nuc1VFd0pEUlBtVWwxNThSZk8vOXZHSHNyeE95?=
 =?utf-8?B?cXkyS2JpQTU1WThlLzU1WW1RdFVrc0Z0Y3pjOFNZL2t2cmFDUHJuWE1XenpZ?=
 =?utf-8?B?OWRyb3BWaHl0NVQ1Vi81NDNmaUhlKzJnN0xOc0pBZ1NweDBFaDdvSURuRGd0?=
 =?utf-8?B?azJWbkkzV3hkQWpDcHhNV3Z5QXZnWU1SSEkwS2oyMzIyTnk4bnkzZkZSaFZN?=
 =?utf-8?B?QnlDSWhHZWxkL3M1d0duUzJ3emhlTTI4UDZvU1FIUTR4ZnZjWW5VTGRCRkl1?=
 =?utf-8?B?QlZQT3kxQVpCR1phenNyTHN0K3NRSnRCRTh5QXloTFdrM3ozRlNCMWE0bm56?=
 =?utf-8?B?TnV3OE0xNERFc0t5MzF0TkpTcml1YklKS1drVDBkdFFOak1iQ1o2b1FLSlpQ?=
 =?utf-8?B?WCtRSUVlZ0d0eHd6ZkErbzVKbEJZK1lNMi9mT3RXYzdHREphalZKZHJBNkpB?=
 =?utf-8?B?cnV4blVHSGZYeHNnMTRzckQydmlJcXpVY1M1MStzTnlUcTdEOTZXOXkxNTJO?=
 =?utf-8?B?Zm84bFpGZkxwSVlIZjFTVU43QVpONzRhNDBSVFl2bGlCb1JIKy9PTEdTWVZt?=
 =?utf-8?B?SkUzc2hmTW4xU05wQzZVMTlqR1BIckpUQmZjMk5vTDltRnhLTk1lL3hXVnJo?=
 =?utf-8?B?TkVVUmxUc0ZXRkJ0TWx2blBWcThJVGlrNUc5V0Y5Nkw4UzFGNmducmo4ZXdG?=
 =?utf-8?B?Wm42NTd6OWxLamt1dFpnaGtudGhzTFRtR2FYanhKK1JkbGo2clNHRkVHak1B?=
 =?utf-8?B?NFBjQi9oV2VaYXBMWllhT3J3Y2UrYXhVY3cvczVLbUVma0ZCUEpXQ2NFUWdQ?=
 =?utf-8?B?ZVRyVVdmSk5USE1WakhJODMvRzh6Skx6VHRCWms0WVhDNUxoejhUcW1oRkU0?=
 =?utf-8?B?amhnUUR1WGxhbERVaC82aXJvcWVtM1ptMVhCVVFoOWFRUjY2UkJoQzkrOW5M?=
 =?utf-8?B?NGpSbVZEU3BuK2pZZ2MwWU9QTVEreUMrMHEvRmhSS25DNUtWNVo1TVFLUHNs?=
 =?utf-8?B?RzZtdEJvVGs1aHd4bVpRWjIwTzhCODl2Wm0zQ3JubmNLbFNsVUNSM2V4Ym42?=
 =?utf-8?B?SWhua0VSaGNqQnZQcVFPRHNhenZoaEhvNzkzMGpVMlFRWVFRbnIrdXRHRklx?=
 =?utf-8?B?SCtlY0NPOGNxOGduWDJyOStUOFFsRkVJU0p6N2VjYW5mdFhBVEJlQUZqdy8v?=
 =?utf-8?Q?PcnwCowuuk8T2W7DYtKO6AkS3?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e288b1-dc1e-420c-6c0b-08dcbc413873
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 09:12:28.7505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PGnmCue3N+84KEbXL17g3pVUEbfg2bkr2jitxRLB54Kd813uV+kGyZOvQVdkL/1Er+9RvNHa+UJa48I9G4UaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7745



On 2024/8/14 16:53, Krzysztof Kozlowski wrote:
> On 13/08/2024 19:04, Arend Van Spriel wrote:
>> On August 13, 2024 10:20:24 AM Jacobe Zang <jacobe.zang@wesion.com> wrote:
>>
>>> It's the device id used by AP6275P which is the Wi-Fi module
>>> used by Rockchip's RK3588 evaluation board and also used in
>>> some other RK3588 boards.
>>
>> Hi Kalle,
>>
>> There probably will be a v11, but wanted to know how this series will be
>> handled as it involves device tree bindings, arm arch device tree spec, and
>> brcmfmac driver code. Can it all go through wireless-next?
> 
> No, DTS must not go via wireless-next. Please split it from the series
> and provide lore link in changelog for bindings.
> 

I'm little confused that I should push bindings as a series, DTS as a 
series and driver as a series separately, so next time I should push 3 
series, right?

-- 
Best Regards
Jacobe

