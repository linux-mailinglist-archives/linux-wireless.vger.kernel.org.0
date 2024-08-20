Return-Path: <linux-wireless+bounces-11655-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E72A958373
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62D641C20F83
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 10:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FCE18CBF8;
	Tue, 20 Aug 2024 10:00:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020082.outbound.protection.outlook.com [52.101.128.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C8518CBF0;
	Tue, 20 Aug 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148034; cv=fail; b=gzRM62/bljMbKaY+FqkIvjEDOU5ljc9G4nLBBLdusbni5lKn8EG+69XuqLgwYTJhCOdtbOlktcu5HMQSN+T2AAzt5zX/6lz3M0/+lp6tRMGUp61WlpQp+0zPLwe7wLsvM2FvFnUF+o2txp9KmGLnx6PNGNP0MWjqEsjpEAJ6qSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148034; c=relaxed/simple;
	bh=z8uFkA6oogNSQ1mF9qYkD+BjUoZ7NemwKc8A9SJNRsw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZYd1tx3/dzN+pMl7Iy0p9HaitH5m/CNcXFlw/91A7lkN26LH5nnV+/4s8NKH3rhdo/slYkXxKqpQ2YXq0yq6UMfdM8dOAlxgPWJqXPJPZ33ygNkUctbK7WASfIlsWrmJOau+lMF/09phWYk/w9YlQZ3DnZBodULCRpqHBx2SHVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=52.101.128.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAZ9nWWL9yuT/lIb3rCqhAqcGfKSZ7N9YwsAqAF7cRZYEOQGZIiVimueNrnUqndFirI38P9hweU6G/3kZfTyt+/pSRI3jxZb3dQFiEjRH2d9D6nV99sEP4aRKNuSlt5H5r7EK+zAuSW6+FPKjRyxpaLwY74OvUuOIehWuAXrdCv6OTGBvfYHL0j/7LRLADpHcmgotPMAKZHufBt6PkI1j0WZVf7JD9QjBUP9NJqDHh/yhMai7U766HD9OOx4YoTGRPShJk6sdHMAacy+UGp3tdA9d0LOfZK+aVbrMhAsWZns+Z8TW3zJ09sh6+8PN8Dpo3ET9ZVFKGE9KaLWOdIyEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKsUmqsKWw+RQJbtu8bJvCYZICnDsaChy4lmooDkf5k=;
 b=c/jCM36qBzDV0hw+WYTv3VSGAwq7jvlGYUTLJxz7jWWGh5zB4/TncO8IHMjJwSreVosomV+hiXniBCTludKh36Tb7eXmt61k8tuCSJJ7LqnVRsZA15rzp0Da+7kNl/eLQZLh3i0rCa6UKBt53F2kKD76wdKQkGE8RDcyCLJKMZL+U3ucGVKZbkF9bRWQBfJoKu/jWplhzx9xaXxX6zye+ive9L5goecMRtCbvmqMeZG3kxuZHAIaL1UszoMzQ79AE/GrCFTJE4JoecdZI+GzQ1pVy5fjXnfmWGISKOKCVFEkZCoGUjdIlED3kHVkLuIi9XNPGYameo3exKsU72W5CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYZPR03MB7638.apcprd03.prod.outlook.com (2603:1096:400:423::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 10:00:26 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 10:00:26 +0000
Message-ID: <924339e5-4dba-4068-8cea-a64ce0a20eef@wesion.com>
Date: Tue, 20 Aug 2024 18:00:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/4] Add AP6275P wireless support
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: bhelgaas@google.com, brcm80211-dev-list.pdl@broadcom.com,
 brcm80211@lists.linux.dev, christophe.jaillet@wanadoo.fr,
 conor+dt@kernel.org, davem@davemloft.net, devicetree@vger.kernel.org,
 duoming@zju.edu.cn, edumazet@google.com, gregkh@linuxfoundation.org,
 krzk+dt@kernel.org, kuba@kernel.org, kvalo@kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, megi@xff.cz,
 minipli@grsecurity.net, netdev@vger.kernel.org, pabeni@redhat.com,
 robh@kernel.org, saikrishnag@marvell.com, stern@rowland.harvard.edu,
 yajun.deng@linux.dev
References: <uzmj5w6byisfguatjyy2ibo6zbn7w52bg2abgf7egych7usv6j@ec4xdmaofach>
 <67d67f15-4631-44ba-bc05-c8da6a1af1bf@broadcom.com>
 <xc5226th2sifhop3gnwnziok4lfl5s6yqbxq6wx4vygnuf4via@4475aaonnmaz>
Content-Language: en-US
From: Jacobe Zang <jacobe.zang@wesion.com>
In-Reply-To: <xc5226th2sifhop3gnwnziok4lfl5s6yqbxq6wx4vygnuf4via@4475aaonnmaz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TYZPR03MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: e655226d-82a0-49eb-d53b-08dcc0feea30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGR5elpFNHhFTDUxOUs4dUFYRmlFY1lUYkU2M0ZZMHA0V3hhWFQ2eEVPdEpQ?=
 =?utf-8?B?WFFxNnBQZjJZTzF5THJEMkF4cnMyTkRoM2hsNFdRMVUxSWo0alJxT2dYa3FJ?=
 =?utf-8?B?UWFLL3JpN1NFRGlCalZTakkrSzBleE1BeXg4TGhjdTgxODBPNys4NGZyS1ls?=
 =?utf-8?B?TVRHM2JnaHl5U2RVTHdSc05mMFZuMkVzbk9EOGUydXdlQUs5RWtRUi9GakFj?=
 =?utf-8?B?SEdPWFR3M1ZEZEtpVkJhZGkwNjZaRXdpMFFjTWFXVm1LQVpJaUJ3THNGTXI3?=
 =?utf-8?B?NnVpUTRudnA5bURyYkdPWDBrNEpzNU9FTjBkUlJTVjVPWmMvb2ZHbmQyZFZG?=
 =?utf-8?B?NHpDaHZ2RWRDU0ZveHpaeDhOd1p2NkkyZWlnd0MzQitwemZ1UkYzalVVckRh?=
 =?utf-8?B?VkRMQloxMzhyajh5VEs3cHFRbXNQTVBQc056RUhNWktsOW9aTjBNOWJrOHUy?=
 =?utf-8?B?aDVzNXBGcWhJYWJtUHFCTVVmQWFoZFBQY3RMV0hjeDdKSml4MUFTbWJMQVFJ?=
 =?utf-8?B?UHdkSTcwZWsxdXY5Zmg1RVFxRkswaFNVWms1bGZhTlhrbFpvWEx1K3pFbkFU?=
 =?utf-8?B?V1BNRzVzcHgwVk53akVxQThpWlhPOWo1ZkpBMzJFbjB0QmlsU0hEancwTlpl?=
 =?utf-8?B?MVhlUTRhNnBCWkZHZ2tIMVE5RUtOaGw3dHNDeHo5aXRrTWg2VkFBb1ptSklv?=
 =?utf-8?B?dzhYUEpUZ3MwbHZiek5nSWxpS3k0czZOSXExeW4xYm9FODFLVmxvTTNGaElU?=
 =?utf-8?B?b1dGYm9Yd1U1Wk1GVkFBcmtIaFhNeG5Ud1lkYTNmOGdBTm1qZWJ0dUJjVkxN?=
 =?utf-8?B?MHY2V3d0N004cms1ZjVEOTFMR0VEUHlnN1lTZnJLMFV2dE1Mdk9JeVUvUFQz?=
 =?utf-8?B?U2s1WGNiMFRmYUtoYzFmQXFaRnB6c09hT3A4eGwxMmZhdTV4bHV2a0xuT2sw?=
 =?utf-8?B?bEY0elFlczVhQzNsTzlITzZCMXBLR2NlOXg2OWJPY0Nob0F2R25HbnlybkJs?=
 =?utf-8?B?eTRTTWF6a3dwSU1JTEdDYzR1RXNGWVZPUjhyZkRiUzJwaGplT2tYQ3lvNkQv?=
 =?utf-8?B?MmRTSFI4VGR4OFUyN0N3Y1Y5UUR4OTBabUpxQWFodFZZRHpGOUZjRERkOXMr?=
 =?utf-8?B?YUxpd2VodlRZeS9pc3JFVElNbnF1UmY2R0JTUUU5WVZLaVM2Z1BMZFA5ZVVV?=
 =?utf-8?B?bHo1cFoxS2poaGlLaDBkakd5QkhZWVBUTGhoMDRjdVRTbnU1Qzhhc3lRelFk?=
 =?utf-8?B?Vy85MW5UQjFiS2Z6WUtYN25rU0o1RC9OSmJMV3dkZUFGWkw4Y3RteWxKbktX?=
 =?utf-8?B?SXhnR1hjbmE1NXhaSVF0dWwvMU5ndFA5UkNUVGpNZnBacDdJK1RQNVRTUHg0?=
 =?utf-8?B?c2M2OGt2YWFmeWtaRlJmc0REV295SnhGQXdiQ3BaYnhMamdtRHRHRzVQWThE?=
 =?utf-8?B?YmplaGR5b1V6c1RlTzA2dSt2b3RGS2dLSHlNa1NRdG1rNWM3NDBLUkVyQUs4?=
 =?utf-8?B?eHRTVGtyVmhiWEk1dDZrSHpudDNpelhhUE5xbXhOUENIbk0yRk41cFg1aW9Y?=
 =?utf-8?B?UldINURQek0vdStGRFhDRUg4eHVYQU5adUptclBBdzAwOFlrZ2FQZHpxeVJs?=
 =?utf-8?B?VDJ5cEFqWkFYQk43RFJid2ZQUFBHaXBDZTVSU3VDdlliSTl5Tnc3alBpbEpm?=
 =?utf-8?B?UzR6WDliRUpack1VOGp6OWVWQWJjRlJtWlNWZ1JiYWVpY3kvalZ0alNSQkRX?=
 =?utf-8?Q?/u18FvLINajUm5bBHo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTZtZGNCVkVvejZZeEtYQ0hvdFplUXJ3bGx2bmpiWVQ0Nk1tSkp3ZWRnSDB2?=
 =?utf-8?B?U2JYN3R5SnN2azE2d3luTkQ1WkhtMDV4WUpDU3hPeVBRdG1JSE9wbkpwYUVy?=
 =?utf-8?B?QW9KNTQ4cU9sTkFXVWpYbGlESjhzY2M1Q2haSWZaNkJtb2N3QkFibkQrTTVQ?=
 =?utf-8?B?UjRzN1ZGUDkzRm1Ub2Fxbkl1cjVpeXdpL1lXWWl6TitISS80ZXAvbk03aHAw?=
 =?utf-8?B?cXZ4cm5yTUF5bGxTZEQ1K0N6ZGZvQ0U1U1hZZHBwa0s4Y1N1Q0lWWGZCVjNp?=
 =?utf-8?B?S0hOSmN6QmxCNkxReC9ZNWRnK2h1WVZMQXFTZnlEL1JRc2V6aGcrZTlIdWs3?=
 =?utf-8?B?azl6RDJEcm5FUEJIUUM1Nk01NVNCMWRUT002STBRNEtvay9Jd0syZURCZmxu?=
 =?utf-8?B?b01KbHNQMURGUWhHLzRjcWJpMjVjbGJ1cEI3aG0vS3dTSGltWkQ5ekhNUFlZ?=
 =?utf-8?B?Vm5oQkZSTDdwZnQ0WnFzMEhnTSs5cXZZd0pUV2luTFlCWjlCMzFqWmZqSTE1?=
 =?utf-8?B?eXhGNmQ0dlF2UGtwMGQwaHJEQW1nWWtlQm1ZN3FoNHFpbU8yWlU1RDd2OURl?=
 =?utf-8?B?aFlwazN5cW9hL1YzaEdySWxTOTJrbUYwajZIZ0hnUCt4TFpURjBLYmtMQ3h1?=
 =?utf-8?B?cjE4eHNtcFRpZ1IwdEhqcllNSEpOU3VxdlZKajNGYmI1TWx4dHo1QXg5K2lF?=
 =?utf-8?B?dkRFeFhwaWh2N1g4R1hEUTM3elFIOGZxSXpibFpLaEJIV2E1VEJPNitjM2Mv?=
 =?utf-8?B?djJqdVhiNm4wbzEvNnpKOHdJdFhWVWJrZDdKczRjd2luL3YwRGtNWVp6L294?=
 =?utf-8?B?ZkpNb1grZHNRclY2d21WajllWkJVV0I3ZDlWc2QwdVN0SUREZUphY00rWUFC?=
 =?utf-8?B?NS83M1BQVE5WK3VqYmRNbmk5ZUtQY1ErbVZ0U3dLc3F5UUFpdlNWbmFWdExn?=
 =?utf-8?B?R0hycjRIRzdsNmVOS1RoeVJGaXRkMkdTRTR6TEFOUlJFejM4QUdFSzBlTEx2?=
 =?utf-8?B?R2tXcjJWa2NkQkJ6R1pMUGd2eGQ4NlVtR1E2Y1N2QmpjaHhKaVl1MTJQOTJj?=
 =?utf-8?B?K3EzM0J3VE9uaFJsM1hheW1veXo1TDdDLzBJTTh2eTBVVk9NNml6b3FUaUFK?=
 =?utf-8?B?ZTNCQmVVeFZpVmp4akxqSGJjOGxpTkJWbXFyV3pWbFZMKzJBUkRsL2k2UURH?=
 =?utf-8?B?NEZHN2w1dEIxQlJtUzQ0b2Z3UlJjV3R5MzRiVm5HejFDeXdReFZORE5DUWpx?=
 =?utf-8?B?MkQrQ0dGbXZ2Z0N3S2VqcTY5WUgrNFJCRXg2NytOampJQ1F3SWEzaG10SUE1?=
 =?utf-8?B?ZlpqTENyeDNNSTFqaUZjSk8ydWtmY2ZDNEZxV3dldmVFRVRXaGszanZHRThv?=
 =?utf-8?B?SDBNM3Z0VDh0L2hNVVJ0WE1MeE5uNkFHQjM3ZEdlY3NGMTZ1dFR1bjFUM3Zq?=
 =?utf-8?B?SlNhU2ZrcUtsYU9GbEkzSzRtM0NvU2g3QS96VDA4Ly9nTVc1S0h5TlhOOHhl?=
 =?utf-8?B?NUJ6aU9EZ2poaGM1Szk0aFgvbkRxZ1FjM2xQNk9EOE01akJuSmdPbnhKem44?=
 =?utf-8?B?SENoYW5nUDhVeE8xS1h2dHNCZ3JuVCs0ekRiNlUwSmRvanZXT3Arb3JXYkhX?=
 =?utf-8?B?Tzh6VW5xMFl2MjJ1MWJ5VUlsUHhXR0V0K20yU3pSZXc2SVBPdk5TZlI3dHZS?=
 =?utf-8?B?Rzd0cXBBeGJSK2dyWThsdDZ0RUN4b2VoZmFmZHZ1WFFoTDFWMkVaeGVEM1RO?=
 =?utf-8?B?T0Z3VkZlWForNm9xb1k0c1ZkNFhYVzNkeUJrVVlnUzRyNHd3ZWpkLzZMaHBa?=
 =?utf-8?B?b2k5eU15M3ZZY1htSFdNOVJiZzVJSTVub0lOUVhzcDJPSi9lc0FBaGRWVjB0?=
 =?utf-8?B?TmxGaXpRZkh6TUpsd25qZVg3NkVVZnE4VUFyZ0Q3NkpHS0hiRUFpMWNjMkZC?=
 =?utf-8?B?SkVzQjhOS2x2ME5IaklPby9ORE14aXF0NkNpaWpHUUVIS2E0M2hnOElEd2Y4?=
 =?utf-8?B?ajZERmJtMUI1SDZmVGVMZllwS0VrUUtwZ3hRZ1NMd1FWMU5PL0dQUzY2cVZj?=
 =?utf-8?B?WjFxNkpOSGlobG4zS0xqbHR0TEhTS3NPSitwNXF2SzNjTVBZQnplcXVtODBM?=
 =?utf-8?Q?x7hOPX4O1grScUZIjIcQNFYYa?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e655226d-82a0-49eb-d53b-08dcc0feea30
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 10:00:26.4474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgwA4rEyOWtCjjFChopdbXzJ8o9q9qS3fgBRpqnER0SzZ/+12PpPRAgC3KMp8rbosCU00ZUxdjYwHjz3PSGI7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7638



On 2024/8/20 4:33, Sebastian Reichel wrote:
> Hello,
> 
> On Mon, Aug 19, 2024 at 09:35:12PM GMT, Arend van Spriel wrote:
>> On 8/19/2024 6:42 PM, Sebastian Reichel wrote:
>>> I tested this on RK3588 EVB1 and the driver is working fine. The DT
>>> bindings are not correct, though:
>>>
>>> linux/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb: wifi@0,0:
>>> compatible: 'oneOf' conditional failed, one must be fixed:
>>>
>>> ['pci14e4,449d', 'brcm,bcm4329-fmac'] is too long
>>> 'pci14e4,449d' is not one of ['brcm,bcm43143-fmac', 'brcm,bcm4341b0-fmac',
>>> 'brcm,bcm4341b4-fmac', 'brcm,bcm4341b5-fmac', 'brcm,bcm4329-fmac',
>>> 'brcm,bcm4330-fmac', 'brcm,bcm4334-fmac', 'brcm,bcm43340-fmac',
>>> 'brcm,bcm4335-fmac', 'brcm,bcm43362-fmac', 'brcm,bcm4339-fmac',
>>> 'brcm,bcm43430a0-fmac', 'brcm,bcm43430a1-fmac', 'brcm,bcm43455-fmac',
>>> 'brcm,bcm43456-fmac', 'brcm,bcm4354-fmac', 'brcm,bcm4356-fmac',
>>> 'brcm,bcm4359-fmac', 'brcm,bcm4366-fmac', 'cypress,cyw4373-fmac',
>>> 'cypress,cyw43012-fmac', 'infineon,cyw43439-fmac']
>>> from schema $id: http://devicetree.org/schemas/net/wireless/brcm,bcm4329-fmac.yaml#
>>>
>>> It's easy to see the problem in the binding. It does not expect a
>>> fallback string after the PCI ID based compatible. Either the
>>> pci14e4,449d entry must be added to the first enum in the binding,
>>> which has the fallback compatible, or the fallback compatible
>>> should not be added to DTS.
>>
>> Never understood why we ended up with such a large list. When the binding
>> was introduced there was one compatible, ie. brcm,bcm4329-fmac. People
>> wanted all the other flavors because it described a specific wifi chip and
>> no other reason whatsoever. The PCI ID based compatible do obfuscate that
>> info so those are even less useful in my opinion.
>>
>>> If the fallback compatible is missing in DTS, the compatible check in
>>> brcmf_of_probe() fails and the lpo clock is not requested resulting
>>> in the firmware startup failing. So that would require further
>>> driver changes.
>>
>> Right. The text based bindings file in 5.12 kernel clearly says:
>>
>> Required properties:
>>
>>   - compatible : Should be "brcm,bcm4329-fmac".
>>
>> In 5.13 kernel this was replaced by the json-schema yaml file. The PCI ID
>> based enum which was added later does also list brcm,bcm4329-fmac so why
>> does that not work for the compatible list ['pci14e4,449d',
>> 'brcm,bcm4329-fmac']? Looking at the compatible property in yaml which I
>> stripped a bit for brevity:
>>
>> properties:
>>    compatible:
>>      oneOf:
>>        - items:
>>            - enum:
>>                - brcm,bcm43143-fmac
>>                - brcm,bcm4329-fmac
>>                - infineon,cyw43439-fmac
>>            - const: brcm,bcm4329-fmac
>>        - enum:
>>            - brcm,bcm4329-fmac
>>            - pci14e4,43dc  # BCM4355
>>            - pci14e4,4464  # BCM4364
>>            - pci14e4,4488  # BCM4377
>>            - pci14e4,4425  # BCM4378
>>            - pci14e4,4433  # BCM4387
>>
>> So how should I read this. Searching for some sort of syntax description I
>> found [1] which has an example schema with description that has a similarly
>> complicated compatible property. From that I think the above should be
>> changed to:
>>
>>   properties:
>>     compatible:
>>       oneOf:
>>         - items:
>>             - enum:
>>                 - brcm,bcm43143-fmac
>> -              - brcm,bcm4329-fmac
>>                 - infineon,cyw43439-fmac
>>             - const: brcm,bcm4329-fmac
>> +      - items:
>>             - enum:
>> -              - brcm,bcm4329-fmac
>>                 - pci14e4,43dc  # BCM4355
>>                 - pci14e4,4464  # BCM4364
>>                 - pci14e4,4488  # BCM4377
>>                 - pci14e4,4425  # BCM4378
>>                 - pci14e4,4433  # BCM4387
>> +          - const: brcm,bcm4329-fmac
>> +      - const: brcm,bcm4329-fmac
>>
>> This poses a constraint in which the last string in the compatible list is
>> always 'brcm,bcm4329-fmac' even if it is the only string. At least that is
>> my understanding so if my understanding is wrong feel free to correct me on
>> this.
>>
>> [1] https://docs.kernel.org/devicetree/bindings/writing-schema.html
> 
> Your proposed change should work as you describe. But it will result
> in DT check errors for some Apple devices, which followed the
> current binding and do not have the "brcm,bcm4329-fmac" fallback
> compatible:
> 
> $ git grep -E "(pci14e4,43dc)|(pci14e4,4464)|(pci14e4,4488)|(pci14e4,4425)|(pci14e4,4433)" arch/
> arch/arm64/boot/dts/apple/t8103-jxxx.dtsi:           compatible = "pci14e4,4425";
> arch/arm64/boot/dts/apple/t8112-j413.dts:            compatible = "pci14e4,4433";
> arch/arm64/boot/dts/apple/t8112-j493.dts:            compatible = "pci14e4,4425";
> 
> I guess patch 3/4 from this series will also introduce some
> regressions for these devices by moving the check. What is the
> purpose of the compatible check in brcmf_of_probe() in the first
> place? Can it just be dropped?
> 
> I see it was introduced 10 years ago in 61f663dfc1a09, probably to
> avoid a spurious error message for systems not having the IRQ
> described in DT? The current code exits quietly when none of the

Before these patches, the compatible check in brcmf_of_probe() is only 
used for interrupt configuration in DTS. Wi-Fi compatible in some boards 
without IRO configuration is just a compatible don't have real function 
but required by the binding. So if the compatible check is no longer 
needed, I think it can be dropped.

And also just adjusting the yaml is a good choice, but need to add 
fallback compatible for boards just like Apple.

> optional resources are defined.
> 


-- 
Best Regards
Jacobe


