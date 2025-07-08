Return-Path: <linux-wireless+bounces-24949-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F19AAFCD2C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 16:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD362188A6F7
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 14:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE45204583;
	Tue,  8 Jul 2025 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="GJdoLlyK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013064.outbound.protection.outlook.com [52.101.127.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C2879CF;
	Tue,  8 Jul 2025 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984130; cv=fail; b=CEUYtHcijfPkoBmAGeUrEUMz2hrC7T5ZyOk4v+4la7tpY4TUtziTegbF7Aiz4wcjmqzq3DcRt4RPlzpxUr8jwZeJXwhYUf2KZg2XxgApCpJez9/LJZIcJ5pBzC4BKNf6vtG/3xdWSUQgKqX4sxpxBFO4xQfwWifV9a5A/ItQn60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984130; c=relaxed/simple;
	bh=AcvvYr6susvkW64ZgwK1q2U4DVQY58MVDiTNXDQ1Wj0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Je9MQ+cytjeGVOo/IzCjC6dLZORubrNFmkwaDV2nLHt19Ssaceeb3iH+oqL2ERsBOxXTnv9DISFXI2H0oqRhWnnAfzsGNsSOWFrIken5tIUwyJiMoU9CVp6NR/nYg0kz0sK2Y6pZzaw8DyuZ7sKbvfHAA+u8Dxbg9QLzwQfOys0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=GJdoLlyK; arc=fail smtp.client-ip=52.101.127.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDrh5iBTj5OxeuegMOTPLI5VpWzv77qPJxG94KujRn9x89y+VPFs4pAk5RRF0znPPx5PVZh2z87Y2L9WBUYC/T1/+epqsw7US+oSIlsCk+3wrckop7S77K41TJ/M0vgQcXQxf5bBsvecXtkB0nQGHapzxztL3lhAlMoiqaMhVL6um+VHjwMmx4wp3JZ0sjNE76zEBUN7SYyq/BH/stV4MtGFYAp8v1dmGeggj4WG2BR16Bu7plDxc8Ii7Jpbqcuz+lacoHYJ916FQyZDppv458tuwD8yVNtZOw0UGyV+SnOHTC3iG2f58k/DB7QHDN4EZg5afuZD12hAOcQRXeYcKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zb2apQCSyBjlbQ7kXEyFxfVC6V+tDt6FeQcESm66/zM=;
 b=WeN7chxrn4oo97axBBgyiwQi6A4RT7VBJIjH6jS6eHYi6RyMI1DVEn+pmMjN74NZiV5M7PPZSkcymp1DfksPxHs8KNQmYFaeKtIxl73Fz40IEUqa9Mb2aBAwWhBktJFaFmTAhutord8ANsZddHOXEUutSXBJ840tc4t8zDAz66Vo4XhvD9IsBVSCHn1zoDx42Vc6j2uVtt9k1tm8y3ZOeITUK2ZGuJT8udNk0EGU0XV3F4QNFtyyOwgxrkwPQouI/zB9upfhAUTS5y70ciMUBr5k7U4tnZV63JAVYjsf7QPbXQ5pW/iYbgiIbTvIscmJCNL4gGT24RHwyh9WsIH/tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zb2apQCSyBjlbQ7kXEyFxfVC6V+tDt6FeQcESm66/zM=;
 b=GJdoLlyKPbMk2IhyYuUtSQoim+1q26e7DnbVMXguPysZaJ/sY50Q5hwjr42k3alh+TF3Syh8ioBTYlGyGCKyd2cf8wWjZ+9j5bRD99EZfra5mhPxQWEJvBNrnDsewP96uYgkXYaTsUgI85ToiiO8TH5nfxktR0wf5PP6w/gh64TG9LVIOAFSjLf/hgGUZX1+tZxwvu9dqrjU2hWT1gNjAbFK8nnIGUzSHXtmdIF6q8l/p6Lg5r6ldLyYiiwKy0YVdofuoiMZc1MNIMyX+gZ5iZaz2sHUCwkH9Fny1EIYQuZue91weUCYakBdMV2+CaX34j+yJlX5R6Uf/EVt/aGbKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 KL1PR06MB6369.apcprd06.prod.outlook.com (2603:1096:820:e4::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.26; Tue, 8 Jul 2025 14:15:24 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Tue, 8 Jul 2025
 14:15:24 +0000
Message-ID: <463c327b-a349-47bc-a403-9192eb5b299d@vivo.com>
Date: Tue, 8 Jul 2025 22:15:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] net: Use min()/max() to improve code
Content-Language: en-US
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara
 <sedara@marvell.com>, Louis Peens <louis.peens@corigine.com>,
 Shahed Shaikh <shshaikh@marvell.com>, Manish Chopra <manishc@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Jiri Slaby <jirislaby@kernel.org>,
 Nick Kossifidis <mickflemm@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Ping-Ke Shih
 <pkshih@realtek.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 =?UTF-8?Q?Benjamin_Gro=C3=9Fe?= <ste3ls@gmail.com>,
 Hayes Wang <hayeswang@realtek.com>,
 Lucas Sanchez Sagrado <lucsansag@gmail.com>, Philipp Hahn
 <phahn-oss@avm.de>, Aleksander Jan Bajkowski <olek2@wp.pl>,
 Eric Biggers <ebiggers@google.com>, Wentao Liang <vulab@iscas.ac.cn>,
 Johannes Berg <johannes.berg@intel.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Ondrej Jirman <megi@xff.cz>, Jacobe Zang <jacobe.zang@wesion.com>,
 Dmitry Antipov <dmantipov@yandex.ru>, Kalle Valo <kvalo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Aditya Kumar Singh <quic_adisi@quicinc.com>, David Lin <yu-hao.lin@nxp.com>,
 Roopni Devanathan <quic_rdevanat@quicinc.com>,
 Rameshkumar Sundaram <quic_ramess@quicinc.com>, Marek Vasut <marex@denx.de>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, oss-drivers@corigine.com,
 linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
Cc: opensource.kernel@vivo.com
References: <20250708135632.152673-1-rongqianfeng@vivo.com>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250708135632.152673-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0125.apcprd02.prod.outlook.com
 (2603:1096:4:188::13) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|KL1PR06MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: f956307f-1d4d-471c-b0ee-08ddbe29e13c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzdwSnNSZjdMZ1FaaktWa1pNTGR1bS8vQXJ3TVZhbnlwUmZwT3FKaDYxbk5Y?=
 =?utf-8?B?cGROWitNRDQwRzVKenFCWkp4ekRMeGEvOWVIdGI4Rkd1VnVVRFhjdzQ5cVM4?=
 =?utf-8?B?NGdzUnRWZVNjeElzK1E0VmRnemswQ055UWRpbzRSY2tNT0tjd3VyZGtmSkNM?=
 =?utf-8?B?UWJsd0JOV0hFaVppTk03L3kxV2tGMGYzZnA3dXNPWGFaTkkrYWpXUFREOVJK?=
 =?utf-8?B?WHJzOFp2TDlhUHlJNWRJMGtYVU1ESkU1VmV6L04zcXRwTUVIb3V3T0tmUEd0?=
 =?utf-8?B?citZWld4VnNUWFpkcDVNYVlsT1ZVMXdka0tHSlBlN1pMNDJ6MlNKOC9Gc3Uy?=
 =?utf-8?B?WXdoNWF3VlBZSWZjamNIOFhORjFpMmpmVEpycU1nYjlrTU4xWDNnMWkzYmJl?=
 =?utf-8?B?a1Joa2d5QVY4bFJNanhWUHp0RnBuWGpQcS9vdWhtNU5PL0pLUjU2emVsb1dD?=
 =?utf-8?B?TE5vWjJ4cDBxRCtwakVUbDVKTHhXdDZSaDUxNnI4QU9OSUI2cW55TlNzUS82?=
 =?utf-8?B?UGE0RVUzV0dvejJwZGNxRlVLbUVpMHBkSVRQZ3phK1BqQ0VTUjFEVXlhZURR?=
 =?utf-8?B?U3N6NTllajJOOEJCdm45NFBJbVlvWXEzc0tkbW9PYU05NURYTndZcUQwaWRp?=
 =?utf-8?B?NlBZQUtUK2EvWTlmWjZvOU9DK0l5NXV6UkRKZVc1d2lUMEJaelR2eVFRR3lW?=
 =?utf-8?B?R25RQWpENjB4UXhhb01Ca3owVGZ0Q3BvZEREY3lyZkpwbUh6bVMvclUrWFdl?=
 =?utf-8?B?YktHOCtIMWJPVHpETGxkQ0Q3VC91Zk9DdDhKdXBycmpzcjhwRkFBWERNMytw?=
 =?utf-8?B?OWFPVW50MGRoUnF2bDRKUVBieTRQV1Z1b2RYZUVQdEh6TG43RWNpQS85cXJs?=
 =?utf-8?B?S0IxTkc1eGRVRi9QSHpLdlpDYkNFMy8rZDNlbnQ2U05Fb2k2bDcrbnZnQjgy?=
 =?utf-8?B?NWhkdHJrR0VIUFVCUUw0MUZpbkcrZUxnN25CMGZkdk95aHNjRE9SQzkzeno5?=
 =?utf-8?B?YzFBTTFUbkF6MlhkMnlGUjU0dWJXNVZ6QWI5QUlub3dCRXZ0eFl2a255bWdC?=
 =?utf-8?B?TG5Pemh3ZzJRYXdmV05pY0tRSmlUNTNjSEx4UVNIOE84ZVFhZzhJekFQSVJt?=
 =?utf-8?B?SHB6ZU1Scng2dEQxdDRqbE8xNEdVYkJvdHE1MW1ZWTNaLzlTNC9GK1FQVTRm?=
 =?utf-8?B?QTBoL29MUVpHcnlYWUZ6UEVROW15YytjaEdtK244NStPWnczQ3lwVlBocmRH?=
 =?utf-8?B?WmkxRGRJTGl4TERPalpWdDJ6bys0R1h1cnZhdld4SmVQK3YyTDVsbjFtNkZi?=
 =?utf-8?B?Q3c0dTNyRUNFRmhhNEFHcnB0OC9lTHU4SmlRNkJ6L1V6dXNaWklxNGtIdVVq?=
 =?utf-8?B?TWJNTGVMenVLWEJCRUpRV3VkL1FoeFR3TS9MSTBtVlFjWHh2cnVhYWRqRzA5?=
 =?utf-8?B?bHAra1BoMXhXcHhXc0I4R3NGZGdCUVpIUmNSZnJ4VnZDaXVjQWtSVEQrY2kr?=
 =?utf-8?B?R2ttb2ZiN1F1VS9ra1B1TjFJVUdia20xYU03SzREUjlUUjJSK3hKR3plQ3E2?=
 =?utf-8?B?eTJnWnZiaVEzczh5eXB6MytnV3gxYkNiUFA4RXRvdWo5S25ZYktmZStKMW1y?=
 =?utf-8?B?bGtVOEVnSEtIQUx6SnhVcC9aejlBK1YwdXFKbUdlVEpIS2ZGbGcvU2lnQ2tv?=
 =?utf-8?B?T3ZuVDBYdHl1MEdITTRWNmMwRHFpeGxoUzBJVjgvcy9vY1E2SHZ5K1FmblJD?=
 =?utf-8?B?M3QyNExUUWhRckdRV2k3bGZzVFVWK1hvekJ0NDc1RUJlNlM3aW5Va0Z1MTUr?=
 =?utf-8?B?a1R6aGRrajlaa2NZZC93bjFBeTFnNDJVMHhjd2w0RmRYNHpHN0diWWptYjlo?=
 =?utf-8?B?NWljeU5GVmNneHhoMndYK3pSV1FSZGZKZ1QvRnZ3RHB0OVdHdkZ4NVlkSmJI?=
 =?utf-8?B?ZG9GL2R3UkdHTndHYk9aa3U3cjB2ZnRRWEtpa1BQUS9lbTB1VE9RR1kzeFU1?=
 =?utf-8?B?b3JPd0E3VVp3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3ZmNENYSk5SZDYvTFgyRTNKZmFxdXNiWVBwaTBTSjk3QzdNcG5yTzNlek5B?=
 =?utf-8?B?VmRETE9KRlNxOW5taktxelJ2K21Tc2xzV09WRHlvRy96TXlMWE52QkFDakRN?=
 =?utf-8?B?ZVlNdVQrNFhEUE1obEFMMzlzc2FuLzg2UkVjK1ZLeDQzR0dXWkdVUHF0RlYy?=
 =?utf-8?B?M2t1THRXN2ZjSTZNU1pDenowMGdRbVFYKy95ZVhxQURYWVNHMkY0UU94ZW43?=
 =?utf-8?B?OGY3NTlQTE5CbnZqWStoYTYwNFZGQ1RFa2VsUzg4TE03ZkU2dzY5MUdiTnAx?=
 =?utf-8?B?SUEzcWhvRkVXSU4rcURweVRjL0tvSlQ3MDBHTnlYejAwL2JVR2k5clc3Z0RY?=
 =?utf-8?B?MjJNUEQ3a0VMeERIN21PTnF2dlZLWUhaekg5WEU5ZTViRU5sNFBNUVF2WDJ6?=
 =?utf-8?B?ZGZzaXg2aEdybjdEMG1uU0p1aWx3TXJ3SUJLekdpOG5oRkVyaDhQQ2doYkM3?=
 =?utf-8?B?Nm1RRElBYXYxVi9YeFBKcThPUjdQZTFGdkM0L1dpbittVXlpQnROcFFzcDBR?=
 =?utf-8?B?RHVoU3BmOHBLZjB6K2o0Yk42QkIwSElkNUJFeDRSSzJ3NDgxenNsOXJJZUxZ?=
 =?utf-8?B?emxscDQwcHR1M2xTaFJGa3p3OC9Ydk5wYzQ5ZGdDMDdUeWpFZ2lzM3ZVTmkr?=
 =?utf-8?B?UUlIc1g3bDhJbGtUNGhpVTRjdFUwR3NhdlNFenlyZGx3eEkvZ2tvYnhYc2lS?=
 =?utf-8?B?dVp6SUl0bm94V0pDcFlHeGtoR2dsRHY4RklkQUhFSGtSdkdiVnorZHVNZE9j?=
 =?utf-8?B?Q0dlWDJQMklnWm0xQTZZaWZUTlhjbUM1MHJJNjRMV1J3VnRzM1Q0cGQyTC8w?=
 =?utf-8?B?cHArZ2s0UG5jTU1JYWN3UWYwekR1K0FVVkdVUmZwckt0Yy9iVlo5UHYvZmZO?=
 =?utf-8?B?SU1qL1lHd1hiUXVGL0NUQjRYZXVFT0svUnRhQ0xJbVFia0pOU3RIaEphL3dy?=
 =?utf-8?B?QnZHVFByd05pbG0zbm9WeE84VmlLQnVidHVoakZIN2lneGxqRDdyeFVuV0I5?=
 =?utf-8?B?em9Jcjl5U3dBRWdTcHN1M2hqbDhlMGo3UnlRNkZVVWczMmpyeU1hUzdiOG5W?=
 =?utf-8?B?QWxSbnRxWmZudVJpb0Z6cmREM01tRy9qVEpPYmRvUW56NXFwanQ4QjNDWUla?=
 =?utf-8?B?bTRBeGl2SHdrcUNlTzcwTmNsU2pxemNLd1dobUFNRXBqK2dSdUt2L2Y2RHAz?=
 =?utf-8?B?SThNdCtJSnRsZFJTQnpvYk5mSVBubWsyWHJCM3FxOHIzenVuQnpjQ2FxZUhC?=
 =?utf-8?B?aitXUjZDdjlheFNsWDE4Z2F4Uk10eWFmbS8ybTRvQm41Z0lEdGhaZ0xBcGRX?=
 =?utf-8?B?MWRyYWtDaFh1M2pIcnl3SEpEYUFHRUhnN1ZIYTJ3U3FuaXE3by9HR0NnOHhW?=
 =?utf-8?B?QUdiYk1TK0tDQlNMVjlYYk9qNEVBMlREVWpad040SzJERnFqc1RhV3Ezdkhs?=
 =?utf-8?B?MC9HWG9aTkhYUWxWbnk3ZzBQNks2ZkRZSythQmpiUlkwbDJOMlJYZUc4S1JP?=
 =?utf-8?B?eDhHUzVDWFk1QWlHMUFzYUM0dzZEdncvVktyajRGQlhXcFhOTEN5Yk5LUVkx?=
 =?utf-8?B?UmxMRldhUUVIYVZwaHpoenQ2c3IreFllS3F3MnJZdnJKL09QOWhqSEpYdnht?=
 =?utf-8?B?MDg5QjdIeGNRT0ZoWnpraVFaNnlzVXhBYzdRMFk4Q1BZRU9tWGU1dVlySUZX?=
 =?utf-8?B?R1hYL2ZkeDhQd1dNYlhZbzRWUFhEa0U0NXY3VlZBbFFoK3lsajZodnlFUFlB?=
 =?utf-8?B?UWhPQ1ZwQjNCdzdiOHJsYUx4RnlPRlQvczBCRkJ5UXR6RFRYUzM3c1ByaXIv?=
 =?utf-8?B?Znk4Q3I2bldCMVZIeHIxU1psdUtSdTJJTURGSDIzVkNScjd0aWdWb0krTGQ0?=
 =?utf-8?B?YUs4MlRvQXV5MzN3RFNTcVlzMUtqcVVSOG9aUzcwYlR1VVkxNDZiMWkyYW9Y?=
 =?utf-8?B?aVNWTk45SmpHR29nYVdzS1hmY3llV2R5eHlhSFRDMDJNSm9SdnRFT2hrMWZ5?=
 =?utf-8?B?RlNGaEpZYkp3dWI4TlBnei9BNjYzdmFabGJmK1QrREt6dlFvRWFGYU91Q2lI?=
 =?utf-8?B?ZzgwbzlvbXF3clE0NUdyUmFnYWsrNERIQzk2c2gzL1A3c1hyY2NLSnRaVmY5?=
 =?utf-8?Q?yilpSOIQ99KXSMydbIZbPYcPF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f956307f-1d4d-471c-b0ee-08ddbe29e13c
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 14:15:23.9765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9cFKjnWVeKChrgje1BzAp22/C+Fkn3s9xNgnWhWUTWncVSz5g6M2yjt5KO0iJmd9YF7OkL5lj+kDNsvFvY6eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6369

Hi all,

Sorry, please ignore this incomplete email.

Thanks
在 2025/7/8 21:55, Qianfeng Rong 写道:
> Use min() to reduce the code and improve its readability.
>
> No functional changes.
>
> Qianfeng Rong (12):
>    ethernet: liquidio: Use min() to improve code
>    ethernet: cxgb4: Use min() to improve code
>    ethernet: octeon_ep: Use min() to improve code
>    ethernet: nfp: Use min()/max() to improve code
>    ethernet: qlcnic: Use min() to improve code
>    net: usb: Use min() to improve code
>    wifi: ath5k: Use max() to improve code
>    wifi: ath9k: Use max() to improve code
>    wifi: brcm80211: Use min() to improve code
>    wifi: mwifiex: Use max() to improve code
>    wifi: wilc1000: Use min() to improve code
>    wifi: rtlwifi: Use min()/max() to improve code
>
>   .../ethernet/cavium/liquidio/octeon_console.c |  5 +----
>   drivers/net/ethernet/chelsio/cxgb4/t4_hw.c    |  5 +----
>   .../marvell/octeon_ep/octep_pfvf_mbox.c       |  5 +----
>   .../ethernet/netronome/nfp/nfp_netvf_main.c   | 13 ++++---------
>   .../ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c   |  5 +----
>   drivers/net/usb/r8152.c                       |  5 +----
>   drivers/net/wireless/ath/ath5k/phy.c          | 12 +++---------
>   drivers/net/wireless/ath/ath9k/dfs.c          |  5 +----
>   .../broadcom/brcm80211/brcmfmac/usb.c         |  5 +----
>   .../broadcom/brcm80211/brcmsmac/phy/phy_n.c   |  6 ++----
>   .../net/wireless/marvell/mwifiex/cfg80211.c   |  6 ++----
>   .../net/wireless/microchip/wilc1000/wlan.c    |  5 +----
>   .../wireless/realtek/rtlwifi/rtl8192ce/hw.c   | 19 +++----------------
>   .../wireless/realtek/rtlwifi/rtl8192cu/hw.c   | 17 +++--------------
>   .../wireless/realtek/rtlwifi/rtl8192ee/dm.c   |  5 +----
>   .../wireless/realtek/rtlwifi/rtl8723ae/hw.c   | 15 +++------------
>   .../wireless/realtek/rtlwifi/rtl8723be/dm.c   |  5 +----
>   .../wireless/realtek/rtlwifi/rtl8821ae/dm.c   |  5 +----
>   18 files changed, 31 insertions(+), 112 deletions(-)
>

