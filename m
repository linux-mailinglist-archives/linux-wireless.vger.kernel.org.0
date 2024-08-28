Return-Path: <linux-wireless+bounces-12130-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9A3962208
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 10:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F023B1C21248
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 08:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0505E15AD90;
	Wed, 28 Aug 2024 08:10:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2136.outbound.protection.outlook.com [40.107.117.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACC4B67A;
	Wed, 28 Aug 2024 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724832654; cv=fail; b=QYTYmNgix+LLWQRccudHzAYeMksMecPS1OrDsxR08YxnS8UzWNTsQ+nLwQZG3vct6ApKWWh8Lojfm/VeXlPwxdHotYcSqr+FwjofIoEOGT9c0ruLfu8MLJd0V1S8UAj+LR8AJrjrGpVrQDs6UdKYJKjadUwmIHAwLwMf7NuzpQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724832654; c=relaxed/simple;
	bh=1PfeMbbLYRrsaymNXBDmQ7mmVW2w8Ik325QLEpYb4+o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f9KxPJJnfE8SFOCCRWGG/ipKWyPD5o1q6ZkjSNrHVDdHtPx3NtHbTFemwekIWHw+BLBWwErOE8VPHJV2a6af2YRTU5ZDcKq2OBBiF6ssV9Yqm09RVDy8VYeSV1In0IsANDKxWeU6HsP4C/mppmB1V8XCG0GK9AFx0Feh8S2qq+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DljZBUbiKZo7MoiTdjwZ8E+H2N5sa4CeY7qUYR2M4dxBJKvaRSatJyFHsVowStxQ4j/aqd3SwLWWbguheiaiNmTvqY3E/7qK7l3o/ENNIlInHHMYMO8uu0dVZn8QZA1AAqTniW+Q6b1jJf8Kn/KFrHa/baYifjzJYBJtIffG7bDwZTQ9Ugf0IJFLKeR5oXHlzwKI0nxss4ZNFPZcUO459BXOLJC+bwkjYtn4qjPZuS7For2F5Gd4Rot0WfpYzGNAP9fsf8gki+bt18xsDKVZHVr69WjQUX8TGKZ1FmzLzjiLNvLUmBuw6npEnOsjhpiy6Yy808Sw+3j9VfIeLNY4aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hK+wF/UVXu1htGUTMCfzPw1Y2NicYjYXES/mcTmU7x0=;
 b=BpFsNV1LxWj+ab9Ns8oCWABDtwdD5CLG/yrHsIcE/nbNd7HDCoQTzQWwUQ3otBuuadQ2HZTxxvueBiNrlFe4Y1bELxQ7dkuNBJ3YyDX5kajhDIHkUq4LDcivDdmfVRxyZd4i9o9tINSqcuwm20CiQuf/EFg3lZF5WsitzEJjCzMMEiobzl2pItsSkd+SYQu8KLArOrHlMdHRydH1uf6RYmj5ZsAI3cPzCFPdyKquQBBpRFZa9+GDDPT/VRMt1Fr5A3F1B4SI/SJQO7VuMs0/mPySOnWUIJkblw6eePgb3rIsmQqETporuTIxnSn/lo/kdSSaaFOKoJe7E11mWLQNxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by PUZPR03MB7014.apcprd03.prod.outlook.com (2603:1096:301:f0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 28 Aug
 2024 08:10:47 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 08:10:47 +0000
Message-ID: <31b6852c-85d9-438e-88ba-46f6e8b528d7@wesion.com>
Date: Wed, 28 Aug 2024 16:10:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/5] Add AP6276P wireless support
To: Krzysztof Kozlowski <krzk@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Ondrej Jirman <megi@xff.cz>, Sai Krishna <saikrishnag@marvell.com>
References: <20240828-wireless-mainline-v12-0-9064ac7acf1d@wesion.com>
 <33d0151d-7708-45da-8414-b161892db937@kernel.org>
Content-Language: en-US
From: Jacobe Zang <jacobe.zang@wesion.com>
In-Reply-To: <33d0151d-7708-45da-8414-b161892db937@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|PUZPR03MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 05fa41dc-509b-4387-8b61-08dcc738ec31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEh2V0ljQlc1dEFYUVhqZjAzaVZNbUF4RlhqeHYrYSttcUtPTEppZG5nbHNW?=
 =?utf-8?B?bzZpd0tkZm9UNUhBc0ljWnZuTkNsNXZ0YWE2eVhXcUtITERIMkR4aFFuVmQ2?=
 =?utf-8?B?RTMzWkJOd250WW1PS2JsV1lwT1pMRy9MQVUrZS9Ba2RnRXpxNlVocHRkK0FR?=
 =?utf-8?B?bzdJUkMwdEJjL3cwWGxpbFE0M1RydG5XN1kwcXpKRE9remd4cFVHN1NTQ201?=
 =?utf-8?B?cDJlTVJPUnNydDZxMC9vQ3FoRGQyU3hYVkVBL1hjcGFRenFUQ3VsVVlKckRx?=
 =?utf-8?B?eS9jMDJ2YlNSVE1uZkVWQjNJUk9CYXIzVExjb044RFExbFdRL0VIR2dkR0ds?=
 =?utf-8?B?L3A4Q1FudndSV2gxNHNacHJmSVhEZk5tN0k4anAvOVlva3RIZmowWllKRHhq?=
 =?utf-8?B?b3RqK1l1T0JLYjNJVFFxbzlIdXUrT1E1c2cvRnBjN0oyUTBxUjRGQjIvOUxR?=
 =?utf-8?B?cFFNWHA4QWpKcElGRHU1ck1rQytKajhMdkQyTytKYnJjemFwWVg2Q0lZTkg5?=
 =?utf-8?B?VEhqWlFHSkdzcVBQeUZIdXFYQ1VZNWI1MlE5UGluaVFEblYrdktTS0tMQnE1?=
 =?utf-8?B?NXpEZXNzZzN6QXJJalVpbElFb0d4Q0tJZGFwazJrbEJ0STBiT3NrdlY4Nm9x?=
 =?utf-8?B?QzhTRzFJOElLWjJaT2VCNlFYWmFLRlAwNkh6REFQL2hxdzZBM29ZK1RrNlJn?=
 =?utf-8?B?RVZRVVpENEhVSnFyVEhESjlkSzJRdEJLT3lnMUJOS0IyTnFQQUY4Yi9ZK3Y4?=
 =?utf-8?B?RHVEOC95Q2JURExtY0xvMnFCc0xVcUhwRWJKd0xkSDhuWTNybmFrM1NxM01w?=
 =?utf-8?B?RENTTkpJWVY4WGVOQkgwYTVKZmpzMFhob0NyRHFCK1hqRnNZUnZSZVNkd05U?=
 =?utf-8?B?ekFOeDdackxkcnpUNitsUklnOVlobm1WbUduRC8wbVhyWFVVcisxc3JZUk1F?=
 =?utf-8?B?NFdJeVJSUHBaVzN6dER3T3hvK0dQTldqc1lqWDJTTGxadjlDcXJqUXRRV1Fr?=
 =?utf-8?B?aVE1NmJsUzRNZHQ3c2RrZmNLb21qMzU5WER1VkdnZGR1TUxyY1piaTB4R0FG?=
 =?utf-8?B?YWluMnpXRHlFak9BVVhzK3ZtU2xvb3ZHRjJlU2NETGpTb0VxRVd0NzMrKzVM?=
 =?utf-8?B?M1dPQzIvWTlQWWsxOE4zemdCRWE1N09VNHFXaktqMm82Nm4zVzhGQjdPQjg1?=
 =?utf-8?B?RHBJMTZQTENQT2VLL21FcjR4WGRmNFVKOHR1NFloSG5pR05meHo2dUxoMWhl?=
 =?utf-8?B?aVNFZStvYnY1L2NXSnlNVjAxVFY3dWNJSElaN3F0WVF6NDlmcGhDc3NTa2VO?=
 =?utf-8?B?QW44R1g4cU5VNGhFYThadWRwdWp6aDNqbGRRL3ZsbmMxVElqaHBGdXZtbWIr?=
 =?utf-8?B?c01mNHQ0akZJOUZiVEI0YjcwdzRleVc5YzI4dVRod295Q1VGOStMSnp4dUd3?=
 =?utf-8?B?eGhzbWVZeXEzaHgyM0ExMlJzNE9RTnZUWXBVMGVpR1BhbWxyUVl3cnRUa0Rp?=
 =?utf-8?B?M0RyWFNjQ2JyNDJOVEY4d1lvcGtHMzlMcU84S2dUWEpWOFRnS2g3NGF6dFBU?=
 =?utf-8?B?QlV5RnJKZjZ5UVpsMHo0azZwa2Q0Vkw1SGZ6MW9hR2F3WjQvcldNc2QyVVlj?=
 =?utf-8?B?cmhFaEMwYTZrZHNkY1RvS3N1UnNRQnZwdjFOV1lrN2liMEdSWnRZdThKdXBi?=
 =?utf-8?B?aENXSEE4RmEzUVRTUXhBRXlOZ200d2xDb2NHMy9NbWFjdC81YzBONWgxc1VH?=
 =?utf-8?B?NC96eE91QVJGdzBmMlhEMFQvWDh4NGY2Q3o4QXplUjVmb1ZERkQ1S1NoaWpG?=
 =?utf-8?B?TUJpdGphbVh4ZUc4cHdnK2xhbURzQk1LWHZGWDIzWTZVd2NLYU5CY2s1YzZa?=
 =?utf-8?Q?Jdy5yUEps5ZgX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUo1b25HV1M3WW44NGkxVG1nUjIwYU5IRzZPMzNrRGZycGNqVGorTXkwTHVi?=
 =?utf-8?B?RTBLMVFXcG5lVWFFMlJGbU8vT0lTYjV0cUtTd3VHQldzcEpTM3FrSUxnaG9I?=
 =?utf-8?B?cVBEU2JyN2p4eW9VVW04WmNXWFQyNWhFc2trWWE1Zjc4T3lZYzRVMGRmNHY5?=
 =?utf-8?B?MWloMlo1dWh4OVo4a3FxWUN6NmVMNEpnMmhKTEh4WTltc3pXd2dGM05ndWMv?=
 =?utf-8?B?UENGazlOamNQNm1pd3RWbWYyekk3cjU3eU9ZOW9CZDJ6Y2s2cjRxMklxRVVY?=
 =?utf-8?B?Zm1TeTFlUFU3SXZyOTc5NHh5MG1vV2hzczdFMm9hUkhORitqVTFFWUU0eGRJ?=
 =?utf-8?B?TitQQmkrdzd6bGhOK3pUSGF3d2hWakFuZllPYlV0TTZQQUNWN3hZazJ5R3pT?=
 =?utf-8?B?YlE1cVFtcVV1UHB6VGgyVVk4YlVyZm5sak9vNG0yc3k0Mll3Vm9NeDgwUzV5?=
 =?utf-8?B?eXc5ZjVacmM3alpBRUdINGxJdklFMmdsV1o1Yi81NTl1bWMveldMekE2VjBJ?=
 =?utf-8?B?RmtWN1BENFc5OFBjV1hRQlF3R0E4OEYyYWFmeWhuU2VpYldjSUJFd0ZaWnZK?=
 =?utf-8?B?cS9JSVJvYnJpNUs1NWxQUGpOczkzNlFQU0svY1hXOEtDbnRrSW9xdDlvSFgv?=
 =?utf-8?B?R0NKUzFlRDZTM3hIanpPTTg4NVlWeGhoK2NxREtGQXMzbHZOdG45RE9KQzF0?=
 =?utf-8?B?QitWOEdhR05iZGMvSkIrV2xmZEliYTAyb0gxMDJLbitYSDRQam14T3QzdE1G?=
 =?utf-8?B?bjdHYjF3M2FPZTdHS0ZRaDJ1eHBaQ095bkNkOG5XYXdGc3pickVqSmFobE9p?=
 =?utf-8?B?S2U0UFJMZktWaVljS2c1cVlNcUNxbERTTVE0UkltdDlqSDIzV0U3TkloQU1B?=
 =?utf-8?B?QnJTK3RZZXc4VGd1OXhvUXBpWGowblZ4N3RIQ3Zvd25UUmR5UXhtQ0UvM0lX?=
 =?utf-8?B?c01zYkVxUjdDRDZ0MzNyNWQ4N2w5cGt5aHpYZ3JoZUkyOU9VazRxVkcvTk5w?=
 =?utf-8?B?YTBOaXNudU80VHZyTi80VnBTRGFlQnNOQjVHRExidHJvMHpIWFFVVE1nVyt4?=
 =?utf-8?B?OUNldllhaG50dGZzK1NvMmsvRnFLcU9rZndjdEd4V1RwbTBTUGg4Zy9kczds?=
 =?utf-8?B?R0lPZ0RpUU5ZamVYYnlmQjJ0VXppTktJN2YxT2IwU1lKSWVNTWY5YXhBM2V3?=
 =?utf-8?B?WWgrVkRuQ1ZjclF1TzJKL2FJcytOMlN1MklzOVJYUXo1d3RWNS9vSUFQd3Ru?=
 =?utf-8?B?RU44QXdHazA5c3d3c1kxd1lMSUZkaC8rZE0vcSswY2NKYTJXV0ZLN2hnZzgy?=
 =?utf-8?B?Zk5NNEV6L3FMRTVOQ29iSlR6bVJWSnQxUithK3dsQWVwNDE1OC9MVTVEczgv?=
 =?utf-8?B?K0VQdERPTWVZRVc2bGFQYkl5Q0hjTWp2aSsrT0pnRy9mdmQvbDJZcE45NTFC?=
 =?utf-8?B?NmtyVklCQW9IdXRlRDhERWpkT1ppbW1NK1diMWtPNzFkSzUyclk2YlhQOSt3?=
 =?utf-8?B?a2ZldUNXTjhnR2dGdnFUUnpzY29GMitaU29ZWkRjMUZoNmEvby9lSTVlMHY4?=
 =?utf-8?B?c25UTDNYVHpJYmdZZ3UyaWhkUVl5cXVCVDlqN0dCTGFaWll4N29Tb2xKRysw?=
 =?utf-8?B?amhiY0NjUjU1NmxCMGRDVGlhMkdWRE9YV2FaVW1MYzVpcEtxUUZmZXUvNjhF?=
 =?utf-8?B?OUVqNVZ3Q1NsTUdWb1JnaDVPcml5OWFKVlczQ3JQNHVGWmJOZzhteTBYTm1B?=
 =?utf-8?B?Qmp4RDcraFRTVU00NXlBUG4zREwwMjVMVVllMitMa3FNZEM2ck92dnJQNTNo?=
 =?utf-8?B?YkpFNElSam1nbjR4Z1IvcTdDdUxEZUswOGlWZ2QxYzNLbnExbHh2SzRDZGor?=
 =?utf-8?B?bFdvTEZkQnh2NitDbXZFWEMwSUxlU1lsUXRPaURyR1RDd0t3cEZKcnY5bGpM?=
 =?utf-8?B?UWJUMlN6NFN0bXpjd1BqZ0hkYmF1YVNFSDI2dnFGYkhhbFQ3RXRBUW5kakV6?=
 =?utf-8?B?RmF4OFg5SnZHSFNhMW1BMEZRc1BQYW1mUU4vU3RBM3lMZmRFR3h5b3JJRU9v?=
 =?utf-8?B?cUVocFRzZXVXWkkwTG1OMDVvbUZ4ZE8rZWdpajNOV0lUOW9aaEpJZkFzZ295?=
 =?utf-8?Q?1yL4r2D9tLrX+WAvRfYpV+ojK?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fa41dc-509b-4387-8b61-08dcc738ec31
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 08:10:47.6267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7ljc0qsL9alZXJbSMaDxH/HXZlqFb5qLDF7NMXs7svjwKcFw1VwQXXD9hJG07S8jbqzbzA4yGfS3P2Vi1oNUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7014



On 2024/8/28 15:59, Krzysztof Kozlowski wrote:
> On 28/08/2024 09:40, Jacobe Zang wrote:
>> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
>> ---
>> These add AP6275P wireless support on Khadas Edge2. Enable 32k clock
>> for Wi-Fi module and extend the hardware IDs table in the brcmfmac
>> driver for it to attach.
>>
> 
> I saw v12 and responded to it. This is confusing. Also to other people
> if they start reviewing different copies.
> 
> Please read carefully submitting. This is v12, so I don't get why such
> basic submission guidelines are not respected here.
> 

Sorry.. It is my first time using b4 to send patch, so I made the 
confused versions..

-- 
Best Regards
Jacobe

