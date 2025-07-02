Return-Path: <linux-wireless+bounces-24773-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F45AF5E64
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 18:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EF2016C063
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 16:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBD12D372C;
	Wed,  2 Jul 2025 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AOju/LE5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013078.outbound.protection.outlook.com [52.103.43.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65628272E60
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751473231; cv=fail; b=Vaq83x9L5brAT85ACJhtNgxcoD6YJbRb+mpSF7IO8Ij9qdnL9b5WikCuWA9xMBavXYs5Ll88Kjeaemcl9MnsOMGzC7kUli3vi5ti7sa+JFGs0WI/W3OLe4bVwKE7eJS85FTU1sIV2FgY5wF6sBJgwBLcgA0JxlPJwp9OcshRcis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751473231; c=relaxed/simple;
	bh=irJ6RE4cn2ar1xIMIGhKVdRg7xBodXcPeSXmt9JWWJ4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JK8nwCZq7mO+j7FwjFnuOcTYZz+4Jwo1M0d0XaO1eFJDu2fRMMej/FiEXXVFnHSNfQmsvm/TOixSWhIF2Up1Tq5uxrdH3BrjQ3UJEYWw2KKYVcHpf8VO8Nn975G8AG3zjwBjDPilkk35kOYKISTc8xLbDPr4xkuJTCb2FLjoJ88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AOju/LE5; arc=fail smtp.client-ip=52.103.43.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gB9RSvyZ5LzRdp7HCdrn1rN2sYYSpkQ5NK0xX4+8ZkFGH3+W2uZ0onX7QMHhYTnWaJeFpK/eisIcA4d724lktWi6jlNyacUzmxApOYFpZMx06zi1LN7Bcg03yivGYZiLCmZ9zhV3KxJx4iKsUm+mkD8hDWXYxZWugEwnd7Z/52lk6z1PptsNNi/iPkcuLM5dfPRjJvXsI7bb1Y0v5l6bJYT3olarEgpsEtub1HYeFlcgi1RQotCb03XKh1fBWksyAgidvfrIKnkVA22eqQVVSoy8nglP65s4wl/0No0C/BmcRATxh67NymMs4Mne34a8Fj+uwVSm2kw6dyZUV21Ozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4SLMXzg1WAuxh3nbZ83uHoPWgYxaGdQ3COtbsY+/WU=;
 b=leX4Pp6tmj5Drzwme3D81zzoAJOq2no2XvjKAFKlrlSbo4BJd++0BBCYbeJWJUGUDoZz/9zsrMnXix4ERIq+TrbkTtFd3R2JFmGpziRD8AkNz+k57ppWH3SyubOYm0Us9d3A+3vX3XzkMnvrqq/o77qB/7dZ8KA/Jv/ypxEB86p/EF9pG1Uls1oFse31jU9jmroqLB8cV3l6el/zI7SYN5DXOzgzfH5oNspEna3Xrl61zP+0wa1yo+kXPERJv7KfMV9HPaJ98RGdvicHUaphFiJz/8YCmg0vhmuke7/bwURyWB1ea6Qnz51q+M0r6xcj9qs2VGleHeHgZxU3kyN6sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4SLMXzg1WAuxh3nbZ83uHoPWgYxaGdQ3COtbsY+/WU=;
 b=AOju/LE5gnDMYMftFfksTyFBBGyjy4pNWVzp6Xvx/60FXYOiRm8l0VnRsYoLIZ1w7R4830LgYsKFf3HljJ1smy2qwLwCnoR/ZProV+bkKp2LF9qtnfKDsCyNN0vxa79IoQUoTNeTHZ7ZSfGxplCcypqg3nVdcK7kMQZJ3K86mtPe1h/FXS+ASL2hp5xCI9JBi7igpE6jQWSJFyPAdHtG4mvUSv8pzjjOyvz8gcKe5rnRWQEaTtJtLXcKgXBE5r2BTWkRqV4+Jng8P6nWQBP+JkqfuzA9lyMQTWywBFqN9fptUOuQs0w2eqB75IFc6GRXTS583lyyKEkWXX47tbkhLw==
Received: from KL1PR01MB5322.apcprd01.prod.exchangelabs.com
 (2603:1096:820:d6::7) by PUZPR01MB5043.apcprd01.prod.exchangelabs.com
 (2603:1096:301:e3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 16:20:25 +0000
Received: from KL1PR01MB5322.apcprd01.prod.exchangelabs.com
 ([fe80::179c:9f8f:aa5c:d0d6]) by KL1PR01MB5322.apcprd01.prod.exchangelabs.com
 ([fe80::179c:9f8f:aa5c:d0d6%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 16:20:24 +0000
Message-ID:
 <KL1PR01MB5322C6C207221EED26EE92DCB240A@KL1PR01MB5322.apcprd01.prod.exchangelabs.com>
Date: Wed, 2 Jul 2025 21:50:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: rtw89: RTL8852BE Frequent Bluetooth disconnections and occasional
 Wi-Fi dropouts
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <KL1PR01MB5322B34FA3997A94C6F12A3BB241A@KL1PR01MB5322.apcprd01.prod.exchangelabs.com>
 <1293cd1841414523ac2d159e69db482f@realtek.com>
Content-Language: en-US
From: Ansh Gupta <anshgupta1941@outlook.com>
In-Reply-To: <1293cd1841414523ac2d159e69db482f@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::21) To KL1PR01MB5322.apcprd01.prod.exchangelabs.com
 (2603:1096:820:d6::7)
X-Microsoft-Original-Message-ID:
 <3af6b319-9ebc-4d9e-8d94-326329b47268@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR01MB5322:EE_|PUZPR01MB5043:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cee26c4-f529-4bae-865e-08ddb9845954
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|461199028|15080799009|19110799006|6090799003|5072599009|440099028|40105399003|3412199025|26104999006|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1hGOElOMjVjNzhKT2lwdXJSTE15NllkRWFZeWh5WHpqWlVuUUdQK0hVaWNr?=
 =?utf-8?B?L0wwY1NLaFJXczZObFB5Vkh1ZDNhMUF1RXRHQWpIdkVqdm8wdWV0NTN4bkk5?=
 =?utf-8?B?bTR3bzgzNk45eDVqb2JnaDkzZ1E1anBkUGcvajF4ODh2U0JwVWdFMFJ6cHBN?=
 =?utf-8?B?Wml1dktIUUc1Ym51VEFSTGxaNUprOXlKT0tnQ201YTcyMmdweERuM1A1VzEx?=
 =?utf-8?B?OW1lSUg0SGtlaFhnKzFTYmtQcml6MUVmZWhpQXROTXFubkhtRDNGRHR1QlVG?=
 =?utf-8?B?UDRyampaeW56ZGhjMHJvcVAxSDhtbDQ1WEpDd2xTaElEbEtMTENWczBzZEdR?=
 =?utf-8?B?K2prVGZrcnNrSnFBRGdBSlYyOXFtMFU4dlR1bkdzOXFEYmJlY2tFZThJR05H?=
 =?utf-8?B?a04xVHJNdUZwcEd2TVVXcndrOHNlTzNzR2Y5WWVUZU0vMk1MWnovcXNvUGcy?=
 =?utf-8?B?Y3VvM0dyMHpMRGNJWVlINCt3QVF5dUpocGtMaUp5TjNIZ0pYcnltS3Q2NXYv?=
 =?utf-8?B?S1JPT3BWampIQU53Unc5VG50Q1pSWUFock1oSE5vNzJrTFNSbG96TyttZzUv?=
 =?utf-8?B?T2R3M1BLVk43dUQ5MnRsMVpDek1PbllVdm5CN2JhckROR3BCcXdpck1EQzY1?=
 =?utf-8?B?SEFWWkJCeHNHWVF2aFVzeFg2djg4WU1BeVVUQWtFaDRDNmxpdFJmblNCczNG?=
 =?utf-8?B?d1hOQ1pYYldQRTlYRE04dDFZcHp0MzBOT2FibzV2dVp6aDNBcUdVUDFFRzRZ?=
 =?utf-8?B?eG1VUHV4V0NmMThSL0NRUWVOZTZjL2ZqNHliU3ZwTmxPeE02MkVmYnluK1VO?=
 =?utf-8?B?c21BdDcyTzkyd2lqNjFyWkhEZlU3RnZ5NDFFWEpXNTZMcDFqeXF4bGMxUWlZ?=
 =?utf-8?B?d1BMMUV0bkZEMWpRNU9DcFFMYjZkQnI2K3c1bWQ3K2xBUFd6blU5cjkzWXZS?=
 =?utf-8?B?WDUzcDBKMnVRa0RYRE90Vkhpb3JoVmplQnFVbHo3VWU1Q0pFK29WaWQ3SWNE?=
 =?utf-8?B?ODZrYnJ4ZFZEbjJ3dE1meHlyaGRyWlVDVk9jTlJsOUt6TGpXQXZqc2NnMUF2?=
 =?utf-8?B?Z0laclorQ0FzV01FdDdGeDd0eVBjVjJyeWU0OWUza2RHTmhXeXRXUk9qNUZt?=
 =?utf-8?B?YldFSVpqems3WXhscDdDTDFuMWg5ZWdtSSs0K2FNUk1WZ01mQkZ3K1JrZlJr?=
 =?utf-8?B?Q3FFTjZRdWtyMGNoUHNWL3doYWlSQlJ1K1JuSmYxTnc0dVFRbE9mb2NnVlVj?=
 =?utf-8?B?VHpXNGs4NFg3d0Y4NGtDa2VzVlZnZjBnR0hqNlZ1ZE9FSFJGMGE4djJEb1Fk?=
 =?utf-8?B?THhkSUpPcjRqYzNlRDVpK3lVOTFZdTdRQU8zWlh3a0Y0MVpPMWJFY1Nud3oy?=
 =?utf-8?B?RU1uRDZlRElBMUdpSDRtOFcrTXVlaUZ3VldDRHduaTd1VU1pRkEvZ2JpUVk2?=
 =?utf-8?B?MWpaVDFvMytLUlNVUUIzU3hkTE9CYnUxWkF0K2hQSXEzRHJ1MHdldGJFMzc5?=
 =?utf-8?B?d3ZjVHZLZGxlSnhuZkMyb1M3RDBkU05NOC9MZWhFSUtIWjUwTUV4SUdPWmt3?=
 =?utf-8?B?UEhFMC8rTFB4U2dkNHd4U29tZWhmYlg2bkRrUmVIanQraHk3MXd4TFlIYUg1?=
 =?utf-8?B?eDRTNmNJeU1Kbldod01DWWdRdnJMNHc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mkd4Qkg5dUl5aDhPb0paMHNBVTlGK0RSL0tydEc4V3Q2eTJsZmZ1STkvSWJi?=
 =?utf-8?B?UlFtdkZZeEJXUFd5MVNiemJoWnA3YW05STIybEdFTDdPS1pHUHpFZFJaaFdl?=
 =?utf-8?B?ZEtmNzltcGpObGJDRHBCMjAyMFdVemRmQzc0WmV2RGRha0pxbnNUaVVBMGF2?=
 =?utf-8?B?SVBRUndNWkhESGtuWjlMUzl3ZzN5amlwOGl6ZFpQTDZjMlpRa3NwYkRHQitw?=
 =?utf-8?B?U2xkYXpPVGd0cWJaU29VMEZHMzNXNkV6dzJ3cTRmYjJNWWZzV0VLcDh6VW5q?=
 =?utf-8?B?T3BXczErWjZkUFprMTJkeWtibzNubit0MmhFV0hEUEQxMi8zNmJtUllpeFI4?=
 =?utf-8?B?YlR3M1B6ZWc3V0NSY2l4NXZNNDU5RjN3ZEJzOEI4cmJJUHNSMHAvWUdTSmNx?=
 =?utf-8?B?YndtUWpibUtzcHhpdlB4b3B1UTdoZkRPM3QyZkxzejMxS1FibTdhOFJXTkdC?=
 =?utf-8?B?UnQzb09XWnUvR05oVDNtV3Vud0ZEcGRld2w0YW9oVjRRbllvZjBrbGk0bWJs?=
 =?utf-8?B?emE4aXNqSDVoNEI5aEhZcEtvSG1qM1lmS3pqTkN0bWJtcFVqM3pUZHhoOUta?=
 =?utf-8?B?b1J3ODIycDhMd1NPaTNwREFPYkFIczhwMFFzaGd5eE9aZ1hpc25jS01JdlVo?=
 =?utf-8?B?cU5DSDBpUmZsQmVXU3l5VXptdVhHN0hZNFJVTTM0d01PaXhabCtYODZPNlZ4?=
 =?utf-8?B?TmpaM3VBUlQ3MmN3V0IzVDdHbHpWZG5ibjFDODVCTkRpUUJOaWpNazFxWllD?=
 =?utf-8?B?Wm1jWE9ESEJuTytEcWUyaDhjeng2c2tmSXZTTDNmRTk4N0VCOXp2Tmg3bTR0?=
 =?utf-8?B?VWltdkk5M3lRVVF5YWFBdExITE5DN1d1V004U0ltMXQ3ZGNlMWRQYXNCZzR4?=
 =?utf-8?B?Sml0WHcyV2F2eGtNaldSekthMFNPTjRJdzlGNUFHYjV5ODZjMFp2SlNCY1ZZ?=
 =?utf-8?B?YzV2L0lTZUptL2ZBdHp6MXhBa2xrZ0JOQVVla1RaMndBRlpWT0lGZWJMWG1i?=
 =?utf-8?B?UFZLR2dOVmpRUytmY0FoMCtlQ29vd203VFl6NllTZ1dPSjYyMkNaSWFUa21D?=
 =?utf-8?B?Vys0TG9BY0FqM2Y4MGVrNnU1QzY2WXBLQXJPQWJFVnZ3T1FtSHBnbTlERzVZ?=
 =?utf-8?B?L1ovVFAxVUxZK1NRcUs0djFDWk5BUlh1VmcrZDF5bUZFVXR3ZjFsN1dFSlRi?=
 =?utf-8?B?QU11WFZrQk9mR2cxWCtGQnA3S1NUcTVvNWhHUGVsL3FLd3d5SHNaSW90NTI3?=
 =?utf-8?B?RzZURmNQTFdTdnluZGpUR1dDalQ5bnVqLzNaQ2pCaW56RlhTNWtySnY0WDdI?=
 =?utf-8?B?MGl3ME9WN2FmTUY1eDFKVW54ZWZkdExPT2ViZ0E4K2J6VFZNbXd4OTlPWHAz?=
 =?utf-8?B?eTV0bVROOXR4SE8xdHRpZnVXR0lVMVNTWmdjcEJ3Tkl3RUdZWFZKZnZjZWpV?=
 =?utf-8?B?YjlNdVZNc1BOV2NJb3VnREUvTktMUW1wRnBYOEx1SnZsZlJZQ0NxMjV4MFVi?=
 =?utf-8?B?ZHM1eHptYkQydncvT1NkSHoxSjFzYStGeWE3TGMrb2hPV0g4bFMreDU0Rzdw?=
 =?utf-8?B?QXZtWW5tcC9qNi93V2xWbUJQNWJwNEtUSUJ4Tkh1SkhuVm5RUm05WHVDSTV5?=
 =?utf-8?B?WkFQRFpxYTJuSENjampyUkFiQVZTVk1UNjdTTG1xQVR6MHdDS3FreEdYSUtw?=
 =?utf-8?B?bS9MS1FJdHJXbjhUNGpENkpnRkptYWcxZ0dGRVRWQVV2bk1KVkh2TDVER09H?=
 =?utf-8?Q?UVlJ7XeZtLaDgu3lES3Sz7ePNKETyXYdhL55K77?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cee26c4-f529-4bae-865e-08ddb9845954
X-MS-Exchange-CrossTenant-AuthSource: KL1PR01MB5322.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 16:20:24.5356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR01MB5043

Hello,


> If you play a local music without WiFi connection, does it work well?

Works a lot better, no disconnections even after going to idle mode. 
There is still a delay in providing audio output, but the delay has 
reduced to 1 to 2 seconds, after which I can hear.


> If only WiFi connection (without Bluetooth), does connection drop?
No.


> Bluetooth operates on 2.4GHz band, so is it possible to connect AP on
> 5 GHz band?

The 5GHz band SSID does not show up in the available network list until 
I am 1 to 2 feet away from AP. This happens regardless of whether 
bluetooth is on or off. When connected, I can use that network at normal 
speeds even if I am about 3 meters away from AP with a wall in 
between. I have a separate SSID setup for both the 2.4 and 5GHz bands. I 
did cross check with other devices, and they could connect to the 5GHz 
SSID from a 3 meter distance.

Please note that I do not have access to this particular AP anymore than 
9 days, so I would not be able to provide information regarding it after 
that. The issue with bluetooth and 2.4GHz band is not unique to this AP. 
I tried this with my phone hotspot using 5GHz band, but the results are 
same for every device - it would connect only within a 1 foot radius.

Besides, bluetooth works fine on 5GHz band, although delay in audio 
output by 1 to 2 seconds is present.

> Turn off power saveing entirely by
>    sudo iw wlan0 set power_save off
>
> to see if ease symptom.
No improvements noticed in bluetooth and 5GHz wifi detection.


Additional details I thought would be useful:


I have a wireless usb mouse attached to my laptop,

$ lsusb -d 3938:1031

Bus 003 Device 003: ID 3938:1031 MOSART Semi. 2.4G Wireless Mouse

However, disconnecting the mouse did not make a noticeable difference.


Occasionally, the earphones disconnect when audio profiles are switched, 
from A2DP to HSP/HFP and vice versa.

This only occurred with the 2.4GHz band and not the 5GHz band. Software 
which records voice does this profile switching.


Thank you for your response and attention to this matter,

Ansh Gupta



