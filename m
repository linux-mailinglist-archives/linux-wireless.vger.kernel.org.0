Return-Path: <linux-wireless+bounces-12168-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF90B962881
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 15:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D8C282106
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 13:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717AC181328;
	Wed, 28 Aug 2024 13:20:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2093.outbound.protection.outlook.com [40.107.215.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50AA18030;
	Wed, 28 Aug 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851242; cv=fail; b=QCeuoVY91GE2jqBfhnxQNe+DgrW0YS/nncQwWaSUZBkz7l+7GG05gLevWmOu/E6+sQAHNX5zzJC93MBfiMKp8veF9ItEiE6hkW+8lbZvC35shSO3BwLWwX/snY7WlCNvIUvOt3Z2Bf+vmjKO1E11T7TO5p2dQEb4v/a9BAVGpyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851242; c=relaxed/simple;
	bh=G9MuJcnWDS14E5SgzXoVv/4lEOJwo+1ndsEgfOvkFOc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NCESS9njnWxGThUgWZTJNHEFbEako/TVA626LQ5pxsGleJ6nscsurGFFItmy5Jb8naczhS83ayT6VRD1x3n2Vsfj/jIlDhqe+yTIJe0tcEqHBQFKkHEH9d//QB2bLT1GXHJGbpWjAwwe9Cicyh+xOxtvKSd4uhDGvqgk3gOrtiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucRwedDTCsEOQBGnw/fF/JffjRuk60kbOHSSu48VUYEQe4BYS0G4Ez6v82WhizX8RyVZ6iDx+6vSTu5XtdJoWyvm/fDN4PH/zlxMqVxgWTL7FT4C0PWx4AnW4YUWCh6sjSklHmPc281NiHwEZaORIeR7zpHUhh1SHtNOecBS12BQ2Ch4kjPGY1iYDwZZkLomNlggq4VMWbTJub4RnfhN5Gjk/MpgB9e9rJuL4Lh5Fwe3pHHeUcrW2Dv5RVM7Wnuaql388Y3cotzFFgaC8G2KhzcJJCixmM6jvTT63E5+MMPB9YegAfv3ZpxcB1WpPSdBREs/3UN6/eWiCjj+9z/gvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOmoWnkFDwcSCnHG3dD9ZDkMqwct9ad55czwiEazbjA=;
 b=lXUzF+00GVRTNoscEOewWn1sfofpog9IWsDZU4Qoaj2EXNbbWinxxjdwKA0m62DH99FSpSCYiHBPah8KlrYpwcWijKy0QrtW1FpzHEmcItO/xLZtPtWe5cn0DlCu/yCfdW0LwjLa/KOs7ZGMOfi8Dci/pmWUeJBPfbPOit/VFCadsgX1HzAJtpZvThGwwCtnsKwHOudpB7J+9fOwWGi723ILXyy8wgwFWaFMkOU/D2GSfWn7ig53/5nldTAqsOcAYy/8XFsj/wM3+Qrnucazi0Fdn6ZhsF+NIT9RBBmQU2z2k3Yqhe+D7CmtVEA+JQjF9LaXSOJtOTth6vn31BmHMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB8115.apcprd03.prod.outlook.com (2603:1096:990:35::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 13:20:33 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 13:20:33 +0000
Message-ID: <bd19fd84-2595-41d0-b9cc-7e2c5e62f1c5@wesion.com>
Date: Wed, 28 Aug 2024 21:20:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 3/5] dt-bindings: net: wireless: brcm4329-fmac: change
 properties enum structure
To: Krzysztof Kozlowski <krzk@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
References: <20240828-wireless-mainline-v13-0-9998b19cfe7e@wesion.com>
 <20240828-wireless-mainline-v13-3-9998b19cfe7e@wesion.com>
 <ed670624-2b97-41e0-a243-26b8c5cda70b@kernel.org>
Content-Language: en-US
From: Jacobe Zang <jacobe.zang@wesion.com>
In-Reply-To: <ed670624-2b97-41e0-a243-26b8c5cda70b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|JH0PR03MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: b6357ff7-1f68-4bd7-f3c2-08dcc7643265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHE0Z3pzazgvdE80ZWl2cDVMZVBhZHBueWVjQ2N5djNTMFd0MlB4ZCsybDND?=
 =?utf-8?B?bmw1bjFlQWpmeUtITlNTRFgzTG95L0lnVkJoVUtzdWFNbFhhNnJzUnd6THVW?=
 =?utf-8?B?dElONExEQU03bzdaVjdWS1FaaGs5SllleC9XVm5rQS9NaCtNUFI0VnNvTnlI?=
 =?utf-8?B?T2QrZGxZYnl6bjdmdjYzMXlMVCtrNEdETVp4MEwzcmRERitsbnl0TkozYnJS?=
 =?utf-8?B?MXZydnhROHhqWWp4cWcyR0VLdElLNjRKUlF5ODRWd2pneTVURUJTWTRnTnpo?=
 =?utf-8?B?WHpSb1VQRjhmeTlEMDRTSUJyb0Erc2tTZTRQMVNlUEsva1l3KzFDSnJ1a0Nh?=
 =?utf-8?B?ZU1kYWh2clF2NzR1WFVseHhWNWFpV0k1Ty9GK1BnNzh1b2F2YVM3WlMzYkpx?=
 =?utf-8?B?ODg2Zi8vbDU2Ti9YNkxQRUwxY2ZMeEQxWERQOUdFNTZYRmxRaGNncUdWQkZP?=
 =?utf-8?B?a2N5Y3A1bDQvenBQRlBoOEwyUUFxd0V2US9sbXdRVndzUmtRc3A5aXhIeTNn?=
 =?utf-8?B?TnVDQlh0dGdQUEJzZm16OUJEZWRvQUN4cFR6enAxSHo0SHMwRS9DVHV5dHNC?=
 =?utf-8?B?Nmd4b3RqUm1kT1pxNUFyOE95MUtFOGd1WDFlSnp0aGNMNTF5ZFZtaGxuRHBl?=
 =?utf-8?B?ejNuMjBvckhZRmUvR1BLbDdsMFBlMVhBVG1jWG9XN25HcW5FTk1LNnhUUVUw?=
 =?utf-8?B?R3V2MnhUbnlaRmh0REh2Rzc3RlB2Mm03d09MNk1xM2grKzJXVlVWUHRYWEtB?=
 =?utf-8?B?czdORW01RzI3TmJjR3F1UWZVZU92SDBLVWQxWGRMd2JWVFo5V3RtYVA1VEFH?=
 =?utf-8?B?L09tU2RnSUd0cEdDb3liLzlaTnBSWEMwRkNXbVpTcElyZ0lONmljTkZGcUdX?=
 =?utf-8?B?YmZNNnlYUzM1anQ5YS9WVHVTZy9zSnovZnRtT0lxVVB4cjlSNVl2WWtYQVdt?=
 =?utf-8?B?dXY1OUJJcnZTUHYyZWVUMWRud2lEVE5kQ3hIWEVSWSs4VlFrRWlGZE9tYjBF?=
 =?utf-8?B?RURmQTlXYlpwS2R3anRXMGZEU3dFWEtScUEyWmR3bHdUTzV5RE1FWWI1V0hQ?=
 =?utf-8?B?RWxRSXNGL2tXV3RTVHZOOG13UEttZzhueGM1b0pUZFBkUVl3bFZacWh2dGFl?=
 =?utf-8?B?TUJmVmlrVkMrTVM0TXBVZERsWWp5anJheGh2TGpVUXVRTVMzZkUyQVYybTJq?=
 =?utf-8?B?SnhZWWQ0Q0VYaGsvdWgyZm5wZXRuNDhtbnA4L0twRHNlaCtoSzRCV2Fza1o0?=
 =?utf-8?B?MXJ1UkRHOEVVTVY1bDlUNnN5VnAwTHpMS1lTWHJzc29Oa0MxdmJPYkp4bGNw?=
 =?utf-8?B?T1htZjM1VkxJZE9pMVRCa2EvZDI4S3FKcy9aSWtadzZRMG1VbjdIRnE5QVRC?=
 =?utf-8?B?b29XNG5VUHQxVjVOQ1dUWG81NUFpN1NDZnBsbVhIWDRzTHQ4R1BSYSt6d0hW?=
 =?utf-8?B?ZWhCRUcvaERaL1dpYkM2cEp5UkI5Zm9SMUdvdWNQdmJDNkNDODljNk51MXJu?=
 =?utf-8?B?SklZZ2FNTXFjS2srUEZMekVkZ01ndWhyemwxdTY5NDZaZ0d0b2dGU01lZ0Q0?=
 =?utf-8?B?TjdjZndxd0FDaTlXbk4rK3dIRkhITlBLNUwyVHNtci9EL0dmMlE1L3RzN0VE?=
 =?utf-8?B?MTlTZFc4UDZWWUZSVlVPdVF4ajdodnFmZmUwWXpZMVlrQXo4eUtLRmlocFUr?=
 =?utf-8?B?YVJlWmxJUnl5S0ZmcU5XZGtVR2xEaGpTVEt6RUZuRm9DdU8vUEdsdmsxcVpu?=
 =?utf-8?B?VCtKVjk5MUdtczRWZE9BQnJTQ2VnSVZWa3Nic3V5VERMMHlPQzNpNE03WFdM?=
 =?utf-8?B?a0dLUFVKRGFrYzJublBpYnFNblBVQWVOY3RRbEdHa05tRW5vbUhOUVRoRWNm?=
 =?utf-8?Q?ljRQTWc1dzMQ5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHdOdWpHVzRocDBSWGloRUk5b1ZqTnNUaXZ3UTV1eW8vK2VJLzJoK2ZxZVVM?=
 =?utf-8?B?c25oU2ZUdjlRbzM4RmVQQmdsWVNQYUNjZWR2a0p5Ny81dGZKdE5ld1FpYnN0?=
 =?utf-8?B?OWliUm9GNkpUditWSnNiZUlya3pyeVJPdUZkczlCcXZJOXpJMS9nU2llQ3Jp?=
 =?utf-8?B?QVkraUZ4NHhhajdlRlhVdEZwZFpMdDR1dzRjRmNYYVRNN2x6VVltN2RSTXdt?=
 =?utf-8?B?RGhsOHlSSG1ONy9BdFVKeTBPdzcwdGpNUXBuaU1FS2tWVzNFZkV5M2J1Lzls?=
 =?utf-8?B?WXhRT0IwVmZUaEdOazBrZmFQRzc1MWhBUDZzUmk0WmdrYXNlNGM2Nmx3VnV1?=
 =?utf-8?B?Z003QnAxcGpDU1NTMm90WTFETllFb011SW9GSVYyamtpSEszdU5UODFJc1A3?=
 =?utf-8?B?UWlMd3lJVU15UVJ6b0tSbjUrK0pjRlljM0UxTURYYWRjL0tKTk1EdFpmN0o3?=
 =?utf-8?B?VzBPUmZQTEovZkZueDNSVlZuRXkyb0M1M1hYaTlUZXpBUVlPNXd1NDJBN1p3?=
 =?utf-8?B?NTVpRVQ2bkFVRFA5a2NzSjNWeWo1WGh5NWpjTGFveGF4L3lvNnBYc0RLSXBx?=
 =?utf-8?B?UVNSeUdUNzRjeUw4UnhXZldGTW1TQVNsdUNoNTM4eHZWSmxyOWYwek5wVWIx?=
 =?utf-8?B?Y0Z3c29NZzZSWHQvdFdNUFFZMzlMWnBlY0p3akUzREJyUTdVSEsyZEVCTGxU?=
 =?utf-8?B?ZXNuVGJpOUMzUFVuRUd0OFdUMFRvRUl6UVdmNHk3VFNKQnkyMnczK0thVERR?=
 =?utf-8?B?czB2R0o2MXd4RXBMVDF3MnBJLzdjYkJRVlV1Y0hOdmRhWXcxblM1RVhXWnNi?=
 =?utf-8?B?QmplV3ZoZmp0WWNPOWtrNk4zT1hkVE1pdkxZb3Zxc2RPSkFTN080LzlOWUVt?=
 =?utf-8?B?ZlpMU1pTZkU3SVYxUkhCdVBpZkhKOStmaVQvbC93NWdvSm1xYTQvYW1lU3VQ?=
 =?utf-8?B?a1puTkdVNjZYOXZkZzZBMWVTY2ZyZXJ3UDUvMzlZaVVCNG9YN2hGNmU0Lzkw?=
 =?utf-8?B?SWhhQ0RnNnl6Y3UzMk40YVNIQzBJY09vN2g2bFdTVnRxSDRMdHJOQjhhalhx?=
 =?utf-8?B?TGNJWlpBT3Y3WmI4YmEwcFFqd1p6cldtWXRqc3RLSFh5OU50TmZLZTZwcjh4?=
 =?utf-8?B?T2lZZ3hJZjBKK3UxK3h5b3Y1QUZOZmp3a24zQS9zMmNpbjZNVmxaK0lDcGVt?=
 =?utf-8?B?TmpibVVlZDg2V2hWanFZa2p5STlIQXRldm1HSEc2RUp2bUhXeVl1dEFRMkRi?=
 =?utf-8?B?cWRFbkpKKzB2L3dCRWZpTnZHZVhTTWpnWU1lWlQ2ZkNraHVpTWZjRzFPUUVh?=
 =?utf-8?B?a3ZwVUYrdDRaM1ZDeUo2djA0VFY0MmV0cDU5Zyt5a2xOZHY4NWZhVlg4OWpK?=
 =?utf-8?B?Skw5eUxtUW0yRmNIOVRiZ2dtTm50eFFkMzZHdVlxazdtVU9SZFc3TlZEbCtZ?=
 =?utf-8?B?bXc0a1RvRGI2NlpEK09MakpBK1RzZGY2KzV6TXJ3MTdMVCt2YkJlK2dTbzFE?=
 =?utf-8?B?RVRacnhSOGFzNGZINWRRdUVjbDg1b2hhMitYdVcweTZOTlZnbFRuMXJ0SEJT?=
 =?utf-8?B?R3d2MWRUWXlzWUdGMGpYQURVaWV4bUJLemU4ZDhtZktnOEU4YVpKaUFOUWZq?=
 =?utf-8?B?N1kxSkd2L0tMckttSzVyTlhNY1NnaUZNYVdjQXMyUURkbFpYdnZ6cVJJQlFS?=
 =?utf-8?B?d3owclJNaVRlaUNDUDFHZzBtVFEzbUwzVDVMa0RHOEVIaU9HdTQ1eTVwb2FX?=
 =?utf-8?B?dk9QS2d5QXdnUlU5YUlXN1NmemgzamJJQzVoYmQ0djN2K0lJcmRTWktPdVBz?=
 =?utf-8?B?a3dycUlVYnZDVUYzbDl1ajZUT2ExdjZpMmF6Y2hQUjdSbGN4c01pTFYvZVJq?=
 =?utf-8?B?SnZBZ3hkVk1PSFN4Z0orY3RpYmFhWFRXTWFOZTFuOUNGS21LSTl3c2RhYW84?=
 =?utf-8?B?Y0ZGN1VYWWlVYkM0azhkWjl2VndWdmZXTGN6cXFWOGNyMis2T1Yya01jRnBX?=
 =?utf-8?B?MmNvRHdhY0phVGloZjkrMzZpOGRaT1Zkcndsay9CU1FpT2R1MWRIWVM1Unc1?=
 =?utf-8?B?UmNZUGl3cHVMZkNKYmFib2lPVzJ2eUxHblFqbTlpeGxhZXp3VUpEV09CTVNO?=
 =?utf-8?B?c2I4NWkzUjhOUnZWRjNhSk1yNWlSYkd0RHNzQnhPTGNOdjJpajlHaFpkUXVO?=
 =?utf-8?B?TnZ2Z010Mld3bHRXVXRtck1Ec0VVSW02UEN6UVA3U1dxUHBlZ2ppVjN4Q0sr?=
 =?utf-8?B?aVFiTHNTUEl1OU1QMk80bVVNa0tRPT0=?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6357ff7-1f68-4bd7-f3c2-08dcc7643265
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:20:33.7279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: edYIClskumJYknuMyzhhms8IU94QHn9z/wvufBUrpnZpIGmrydAcUBRvTSEOSois8qhnQf3pudOxhuy5188T4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8115



On 2024/8/28 21:04, Krzysztof Kozlowski wrote:
> On 28/08/2024 10:49, Jacobe Zang wrote:
>> Add "brcm,bcm4329-fmac" as fallback compatible for wireless devices that
>> used PCI ID based compatible. So that can pass the compatible check in
>> driver.
> 
> Driver? Why this has to pass compatible check?
> 
> I think I asked to provide proper rationale based on hardware... if not,
> then let me ask here: Please provide proper rationale explaining how
> this hardware is compatible, especially considering these are entirely
> different buses (SDIO and PCI!).
> 
> It feels you patch up bindings and DTS, because of buggy driver. Sorry
> no, fix the driver.
> 

All right. Anyway after discussion in the other series, this patch 
should be dropped, and driver also need to fix.

-- 
Best Regards
Jacobe

