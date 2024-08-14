Return-Path: <linux-wireless+bounces-11400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0149517CC
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 11:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60485B23C72
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 09:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C9214658F;
	Wed, 14 Aug 2024 09:27:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2114.outbound.protection.outlook.com [40.107.117.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6D31448E1;
	Wed, 14 Aug 2024 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627625; cv=fail; b=DqthKXYtjeSr14WzvnG02664sRRks0FvSGriXVQFPuYIWuszSqcLFPPf8MSHHdl20oBF8rgqTJFR+l3oKalv6y5Ztzqo4eluA49QUPAwkVHGseUPnkvRu+PJX5baWKq1m1/MkEbd3mlVVF/wouv9nWgjhZsNzX87OlsdBdi3dck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627625; c=relaxed/simple;
	bh=v0X8MLMKlOCYoJa6aRexeNnYQUMr+HrLPcCQNINRAOA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p4a9zJpJgye5yQUv3Vgqg9JlvVUz385fjFhpAe16lfnTEtRhTS06LlvgCd9GixtBjQSdlBP+QklnuA/+eA90AvmRZO7PzSC4P1tYLvCxvqMAq4RRfcAIy9oyzgbhhiOiSQVB9E+FkkseYSi7BSm1j3V/SiVJXIEwmWPBuHZ07nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PW3hF2QkIjRCKJF8WkrUZ2wIBinmKidTZLq03ybLMl+RLiM3XDL1lOLf7DExC8gy+KgFW2SJtYy6Ua0aJhHoYASyhBUzlljPYx430qsfGGZrB4lGOk0TAUdfSRW8smSE3buLfcw67L8PiT5f8paEC5Xwk1GzppqqbvLrmQ4KaqzR/DxMQjbQmj+xHZ64F8UGW1RqnkwH3pL0TNKHS6Tm2M+CTH5fiAuwDulI2wlATWH1ZLgIOTs/cGcqD65KbqsNKbTa1+Zm89fYuilEg+f31UBdSdr5kISd2GmPisS0OUJ/W/WeJ/SpoiiJs0Ifc62lvmiF+eV3K2fX9+SqC8oiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlLxjTwwGMWcFVvyf3jskWsnJNGBlBI3VMLO+42+7VY=;
 b=ye7YAKoXmXuDVCCJM2USzyZV1p+u/6HfoaBZyVxDIFGtY/RO5q3bTzGtaYPglotrMvmDXv9RSoE7fK+Lh3WxClPBx4sJzhRlme/brNQuV6oib/d2x2TUdXnML91IKM3hatlDbWTfKZeHPqpx7OKPx/2nOtWvncsk9zM3xybvf1HTfAqtHD5Utml/clWJMTb1F2svt3/ZmXrmTsgd7ECg9nWIGfZxEkvKXP+5GEyXPpDqnyox0QrC+vQxvWRVY8tizH5b6y/xQV89zEUPa7TybEBg3sviVDyUUrKXghna5UFTlLq1DfoJGwuwOKlvzXJCIWpwNEazP45tnXBCEeTY+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEZPR03MB7486.apcprd03.prod.outlook.com (2603:1096:101:10d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Wed, 14 Aug
 2024 09:26:57 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7849.019; Wed, 14 Aug 2024
 09:26:57 +0000
Message-ID: <fa019ee9-3f4d-4bea-92a7-929713518dc9@wesion.com>
Date: Wed, 14 Aug 2024 17:26:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
To: Alexey Charkov <alchark@gmail.com>, robh@kernel.org, krzk+dt@kernel.org,
 heiko@sntech.de, kvalo@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, conor+dt@kernel.org,
 linux-rockchip@lists.infradead.org
Cc: efectn@protonmail.com, dsimic@manjaro.org, jagan@edgeble.ai,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, arend@broadcom.com,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, megi@xff.cz,
 duoming@zju.edu.cn, bhelgaas@google.com, minipli@grsecurity.net,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 nick@khadas.com, Sai Krishna <saikrishnag@marvell.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>
References: <20240813082007.2625841-1-jacobe.zang@wesion.com>
 <20240813082007.2625841-5-jacobe.zang@wesion.com>
 <721da64c-42ec-4be6-8ad3-e2685a84823a@broadcom.com>
 <2269063.vFx2qVVIhK@latitude-fedora>
Content-Language: en-US
From: Jacobe Zang <jacobe.zang@wesion.com>
In-Reply-To: <2269063.vFx2qVVIhK@latitude-fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY1PR01CA0201.jpnprd01.prod.outlook.com (2603:1096:403::31)
 To TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEZPR03MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 54935c16-6a7b-438c-22fa-08dcbc433e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	M99gbZqljmCwhryxh2XTlKZLHIonOZKR2SNmLdx7D4j3k4/6UdmEvJvU58THBpM+MsyGMTcGObY8/KfK8mcjPMkknexXYmwyOfoNDv22AADKmCGxW5pEvzmAkRf2uva15N8RDoDfTR+tXoqW5m+4WMRC6h9eqrbjQ83XHeaKLm9iZKo7xdMVBi+Vkh9xGg0PYpeuEX4nPTpT2n+9sey2PPzenBaQoEmrpy8rW2TUvSFqoqcpNVI3mkH2y5JO61xwAevDT1Sdrron5PrPHwYebZdlcnFfHnvThyn0mFrmZu7soYKNAT8oPW/pwR7LDJRwnOjh5A9whEaYsBgQf+7sNaOfGhiEpdvAvC8DAcVtsPzOOnEvRFENRWQNvpWxZVo6ZBw7sNEezrEqz+mCdyzEwBkcMKWG5cEk9Yd7NHCoatDwaPdu/3z/rRnirhnw+KARbCZKMfcL4hEI41gUUNjFWsjuShZMRYaQ42bBucBFp1Kz0OBGBENmCiPff/ZpSmcryIpNMAOfxvs2sosPku3Yc0eEUZtnRsl5u0nj6cAbSLKGgDCk6uYHa30oDhDfZ63METnXZC2Lfq5U94m6EpyGQgbnR1LQCJ596s0Zf+Pa6BM5D4RF/F5/ziOZoS9gnT4UZyuVdUfftEWpkXwcKfPTcIDzOqsA/rhWhE+qPPQJRIhQ9gbvWvZ33g5Xq5XYmaiTPsrqPumO1q8NpbMJR/IaOw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejhjcDJWOCt2aHdldkFzOHdqWVk4MVZnS0tKd1BwdXR5Vk5FMEQvTFd6bmds?=
 =?utf-8?B?cWNNdE54aWh1czc0MGozM0VwQUVEejRadXJ4TVlqY25xTTRhSThicFV6VFVi?=
 =?utf-8?B?VzlHa0pwMGFCeGFsckswY3lUNDd3UTFOTHMxUTQ0TTIxY2lQeko4cmZxSjVR?=
 =?utf-8?B?dkZySTFhK3dxeEVpWXZiTVRqR0hPNUY1bmpmaWV6QUJKOFVOeTNCdDZ2UGxh?=
 =?utf-8?B?TmlFTzlURVI0L1JJcmN1ejFORDNkeXJ2MG5ZczUxUENGbEc5MGxaNEpUZElp?=
 =?utf-8?B?MUhkb3FhUFliTEdYN2s2bUlpRkVPajdyNURCTG5kOXNpSGlFclFoY0hDT0Z1?=
 =?utf-8?B?N1JCNEJtNFlLSXFsVWRMaVBJNGFsSXU4VGtNWjl3bnZtZDFHRTBEaW5UUlFj?=
 =?utf-8?B?RUE5a1lCRVF1Y0RVUXlSQUlxZDNZUHNwQWRRTHk1eVQ2Wkp6N2o1WFhpaTEw?=
 =?utf-8?B?ZXFmUTZSMDEwdnZPSnJDaitnVWFaUXVGWkhsRU8vb2prUHFwVHFMTkRVcHZG?=
 =?utf-8?B?VTFmTExsbGJaNG1CaC9teTdXVkhIekkyVW5xdHZvclFEcDRaSnVLVktHbVo4?=
 =?utf-8?B?UXJFWS90VDd5bWlZaHlTK2k5RmthSWJYOFEvUGx5bGVsQUhwSWhWbDgzdkt1?=
 =?utf-8?B?UUxEZXBUOGtTQmkzWnNQeGNNRmF5c1FTcTVyYmFGOE5OazUwRGVrQzl0YnRa?=
 =?utf-8?B?Q05hVXo1UDM1ZEVkTjdmNnBERkFIRXJmdmZ4bTdyQkpJeWorTklWT3UzV0tV?=
 =?utf-8?B?S1ZlaXhJbXk4MTNPVXFIV0IzS3I3RE82ODU0T3diekE3eFBXMkJjbXdSL1Ew?=
 =?utf-8?B?S2ZtY0VxZVM4WjBuNFhocVBXTVArVG1XYTdsckRPeUFYWGhJSVhhUEE1LzZZ?=
 =?utf-8?B?TFd4a0VaSmY2QldNUGR0Z2JnaEluZlJYUnFKMkZBNnAwWTNMeUFSK1kwZmdL?=
 =?utf-8?B?KzI3cUQvaTZKMUtXMzBtY2xNbFpLYmxUSXptd2ttVUwwQ20ycFc1Mnp0TDVl?=
 =?utf-8?B?dkJHcTRDTUZ5LzVhOENXQUZYSC8wc3k2b1VZTzA5SFljdWE3azBNRWRWdmwr?=
 =?utf-8?B?KzhKYU1OeklIUFVmRDM4eEZWdlpOY0U1SkNYdlN0dCtmVWJTSUk0bnFEKzEx?=
 =?utf-8?B?N3BuZ2VLa0IrcHNkMzJsU1ppUEtTZlJQd3lKUjZnMEFCZWhXd2FTWFViN0xX?=
 =?utf-8?B?S3ljYk1QZWw0TFVhWElubU9VbW9ZcHZFZm1uSFlaY01OalZlTzlJVWZIOWdx?=
 =?utf-8?B?ck9zczBaMkx0OUMra3dtZzdOV3R3YXRGWmFCQWVNVTRReWx3Z25GTWtXaUlo?=
 =?utf-8?B?WGtrSURjK3RsNkl4N2VaZnFBUzNGRExoaSt0R241bzNXZWs0bmdHTkZFWjd3?=
 =?utf-8?B?RUdyTUk3ay93dXdnUlUzblNxcEU1QXA3Y2QxQ2o4M2hwRzlaN3BNYWxidklO?=
 =?utf-8?B?Y0wyYnRXRmJCZDdtVUJweGpBMW1neHluZEJTc2NpRC9JVm9weVNlRXFZV0lZ?=
 =?utf-8?B?RzBkcjNDSHAzL25BMno4RUNGQmdBcjN0SUJOYjBvOWhXa1ZMTDVEMnpSazZX?=
 =?utf-8?B?Q1NkUGdzMFV2WUFiRlphb3hDeDU4alZHSUVpY1BFUHhzWXhvMmd1cUxjbjUw?=
 =?utf-8?B?eHVEaVc1dHE3NUI4KzVDYy84SXlCaERZV3F1WTNVdk9KcThVdk5ZQ0hNK0NN?=
 =?utf-8?B?cW9uSm5FTmdTeWxxZnkzV0J6bm81MXVmWkVuOWc3TzdJUmkyV1h4RzRmU25p?=
 =?utf-8?B?NThiOENxSzl6ODlkREhqZ2dYQjI3SXJaOWFFUW5qK1NhQXJ4eWoxZktIajNF?=
 =?utf-8?B?NjlXVUI2Rm9XNW11MWJhT3Qxb2VDT1BkUG9lWUN0Z2dkVm5OQ1EwQ2wxdTFE?=
 =?utf-8?B?YlNLWkYzY0srVE1vSC9nZEcxZDQ4ejNYM081OTBEQituMlAvdFFoelJpNzdQ?=
 =?utf-8?B?ZjI4Qk5OUUZvMVJCYitTRFl3TElmVzhrSEZ0UnFzS3lFOW1uWHhCTXVDNW96?=
 =?utf-8?B?WWNmcDRiMUNUYWFreXZZOFhhbGY3aDNxeC9iYmlyZDhMNGVCZHFFME9ZMTF4?=
 =?utf-8?B?RVlWZ0VOU1pMODJKSXphZnU3aUlWaDl4MDY0b0wxVTl5N1lrdVpULytsMy95?=
 =?utf-8?B?bDhTdWphL00xQTh6OVorK1lXcldIWFFvdHlsMFRRN0NTZnE2SnR0T3VKUkdZ?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54935c16-6a7b-438c-22fa-08dcbc433e18
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 09:26:57.1229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5fW5SUxFkY8d1j8XgTW0+aV3NQFQH6SHTkBh6aRzCx7dX4h2KSWW3AKGzni2rMCtP3X+H3fBwdbl/5OTBdFJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7486



On 2024/8/14 16:47, Alexey Charkov wrote:
> Hi Arend, Jacobe,
> 
> On Tuesday, August 13, 2024 2:57:28 PM GMT+3 Arend van Spriel wrote:
>> On 8/13/2024 10:20 AM, Jacobe Zang wrote:
>>> WiFi modules often require 32kHz clock to function. Add support to
>>> enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
>>> to the top of brcmf_of_probe. Change function prototypes from void
>>> to int and add appropriate errno's for return values that will be
>>> send to bus when error occurred.
>>
>> I was going to say it looks good to me, but....
>>
>>> Co-developed-by: Ondrej Jirman <megi@xff.cz>
>>> Signed-off-by: Ondrej Jirman <megi@xff.cz>
>>> Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>> Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
>>> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
>>> ---
>>>
>>>    .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 +-
>>>    .../broadcom/brcm80211/brcmfmac/common.c      |  3 +-
>>>    .../wireless/broadcom/brcm80211/brcmfmac/of.c | 53 +++++++++++--------
>>>    .../wireless/broadcom/brcm80211/brcmfmac/of.h |  9 ++--
>>>    .../broadcom/brcm80211/brcmfmac/pcie.c        |  3 ++
>>>    .../broadcom/brcm80211/brcmfmac/sdio.c        | 22 +++++---
>>>    .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
>>>    7 files changed, 61 insertions(+), 36 deletions(-)
>>
>> [...]
>>
>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c index
>>> e406e11481a62..f19dc7355e0e8 100644
>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>>
>> [...]
>>
>>> @@ -113,33 +118,39 @@ void brcmf_of_probe(struct device *dev, enum
>>> brcmf_bus_type bus_type,>
>>>    		of_node_put(root);
>>>    	
>>>    	}
>>>
>>> -	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
>>> -		return;
>>> -
>>>
>>>    	err = brcmf_of_get_country_codes(dev, settings);
>>>    	if (err)
>>>    	
>>>    		brcmf_err("failed to get OF country code map (err=%d)
> \n", err);
>>>    	
>>>    	of_get_mac_address(np, settings->mac);
>>>
>>> -	if (bus_type != BRCMF_BUSTYPE_SDIO)
>>> -		return;
>>> +	if (bus_type == BRCMF_BUSTYPE_SDIO) {
>>
>> Don't like the fact that this now has an extra indentation level and it
>> offers no extra benefit. Just keep the original if-statement and return
>> 0. Consequently the LPO clock code should move just before the if-statement.
>>> +		if (of_property_read_u32(np, "brcm,drive-strength",
> &val) == 0)
>>> +			sdio->drive_strength = val;
>>>
>>> -	if (of_property_read_u32(np, "brcm,drive-strength", &val) == 0)
>>> -		sdio->drive_strength = val;
>>> +		/* make sure there are interrupts defined in the node */
>>> +		if (!of_property_present(np, "interrupts"))
>>> +			return 0;
>>>
>>> -	/* make sure there are interrupts defined in the node */
>>> -	if (!of_property_present(np, "interrupts"))
>>> -		return;
>>> +		irq = irq_of_parse_and_map(np, 0);
>>> +		if (!irq) {
>>> +			brcmf_err("interrupt could not be
> mapped\n");
>>> +			return 0;
>>> +		}
>>> +		irqf = irqd_get_trigger_type(irq_get_irq_data(irq));
>>> +
>>> +		sdio->oob_irq_supported = true;
>>> +		sdio->oob_irq_nr = irq;
>>> +		sdio->oob_irq_flags = irqf;
>>> +	}
>>>
>>> -	irq = irq_of_parse_and_map(np, 0);
>>> -	if (!irq) {
>>> -		brcmf_err("interrupt could not be mapped\n");
>>> -		return;
>>> +	clk = devm_clk_get_optional_enabled(dev, "lpo");
>>> +	if (!IS_ERR_OR_NULL(clk)) {
>>> +		brcmf_dbg(INFO, "enabling 32kHz clock\n");
>>> +		return clk_set_rate(clk, 32768);
>>> +	} else {
>>> +		return PTR_ERR_OR_ZERO(clk);
>>>
>>>    	}
>>
>> Change this to:
>>   > +	clk = devm_clk_get_optional_enabled(dev, "lpo");
>>   > +	if (IS_ERR_OR_NULL(clk)) {
>>   > +		return PTR_ERR_OR_ZERO(clk);
> 
> Perhaps in this case we should go for IS_ERR and PTR_ERR respectively.
> devm_clk_get_optional_enabled would return NULL when the optional clock is not
> found, so NULL is not an error state but serves as a dummy clock that can be> used with clk_set_rate.

I think we don't need to set clock rate for clock is NULL. So it should 
be changed to:

+	clk = devm_clk_get_optional_enabled(dev, "lpo");
+	if (IS_ERR(clk)) {
+		return PTR_ERR(clk);
+	} else if (clk) {
+		brcmf_dbg(INFO, "enabling 32kHz clock\n");
+		clk_set_rate(clk, 32768);
+	}

> 
> This way we won't skip over the interrupts initialization below in case the
> clock is absent.
> 
>>   > +	}
>>   > +	brcmf_dbg(INFO, "enabling 32kHz clock\n");
>>   > +	clk_set_rate(clk, 32768);
>>
>> As said above this should be moved before the if-statement:
>>   > -	if (bus_type != BRCMF_BUSTYPE_SDIO)
>>   > -		return 0;
>>>
>>> -	irqf = irqd_get_trigger_type(irq_get_irq_data(irq));
>>>
>>> -	sdio->oob_irq_supported = true;
>>> -	sdio->oob_irq_nr = irq;
>>> -	sdio->oob_irq_flags = irqf;
>>> +	return 0;
>>>
>>>    }
> 
> 

-- 
Best Regards
Jacobe

