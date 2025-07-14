Return-Path: <linux-wireless+bounces-25344-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD3CB0345C
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 04:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F73177150
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 02:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA37F1C1AAA;
	Mon, 14 Jul 2025 02:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DkSkfVGa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012024.outbound.protection.outlook.com [40.107.75.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F5C17B50A;
	Mon, 14 Jul 2025 02:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752458923; cv=fail; b=KJu6wndyWSOhArvcppiafdeicCTSTwPDHfkvEaWhfE8Fj3bewLlRn5pWMIVqeBZNn/O5BiKrBAkhtDsIfk7djaiSKXg3c7BrkIQi7mEn3JvNY5j+3p2TxmdqfhhIg0NvQToymVQBbOdEADW3J3e7ZhowgJBMlelZmhQT/qMI6V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752458923; c=relaxed/simple;
	bh=DMKF/V5kkSQc8lvchbA9ardd2pFqUKSZoceoziESo7Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f20qi3mDZXn4WKycFvPWvUMb2rvOrkHNHGoAzvjewkuGXUBJUhHPHj+GEFOVnrWEzHM1/6352Sq2KOsHxnA+UBPwnm3/1TKCh+GwFmhJVjARrWM2BpW+gtN6E577E6prFdQ1Pdx1sxkMglyZcgeLR++MVZ619l11agIBVtt1fAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DkSkfVGa; arc=fail smtp.client-ip=40.107.75.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LorPiXsv16DftY3Xh2yOgwhkw1ZPaHEPKMjGEv3P+cSuHrze98P+8mZHupbGaXfsjn+QwXqaEoVNEV1HBghmw9rrcIScPy/d7pOfBD8eAqHXslUMr0Lm6y6hIqVH6OrmzEsfGIwt5MsM09a/kw208KZEf+9Ly0VoX/qm7+XsplHo0pUI0q9BkU0f+hXoFMRlM8bRPMVr17W35pV8KnhIlD6KNIwbZR2cJhrlRm4gAEXsFou8ru9NoWwYHpTUbDHxEThOQ3aJMbmXWjJWBmyoEygWM9SfPmXgXzuEBjF5Txad5BDwtRqiJ06QOIiUTw9A+4Qog+s8hcU92/RFo6feOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4bLiKCllBmBb3HM9Aa4NuuVZQmRRrSWo9BCiELIJPU=;
 b=NtBK6z395Bnbac8ut17K5NsaFhw+gF35NQF/m2BCJq/lIn4Q7ay6gi4Gq8pEgo4TEgnhQ0UgREwo6SheE9G2Cjv3lmhi702mt+GeidyCn3RbMnucXmpaIkagdsjO6fTI2mixFrrk8yOlSzNcxpcat751SqZLsfEa6WbnqJVFEyeqoDWRJnOJ6fvrg+ChMpSm9ARa/YrziPjLpWFCMfnlCU12PhS6ci0LtJSWH7pwmmz4rSIDxBX4VZbbnRi2QpZieLuY+J62JwZ/+YFj1Cg4VcK3phQvJnZDJ7IbkvJnAwJ+4S7eUo0vht/IgsMsbAcihKdSX82Jc2NbR3gpmMtEPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4bLiKCllBmBb3HM9Aa4NuuVZQmRRrSWo9BCiELIJPU=;
 b=DkSkfVGaKKqNZ+yPerYXhry/YIApf5pITMHmH10PXe9XhityEUsu2mwjtjGYnZ1k/YsivXMgJAVgn7LC013s9HD7zGY99WJRPHttwJgVTksIL/t4zjWgq1HJQ0xu7PWQWLkdtl+lZFSYVfxsVHsF8C0pZJnK/mp2EFlBbuMLCNgL1prTj+VmeApunG0hB7arEXQfYvvP+kqRJL6Lo5HPU4j/eR01uP+puKB6j9s+d7fy6a2taMQeZB1SLAW/tCwD4vyKqqBIMCWjtWfzSo0YT5FQOCKuNmd1teFLEcyf4tZMgej1XXHr2Os2EnrQ4XGdPRrsORn4u85YK3CN5tdsWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 PS1PPF80815FF87.apcprd06.prod.outlook.com (2603:1096:308::259) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.35; Mon, 14 Jul 2025 02:08:38 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Mon, 14 Jul 2025
 02:08:38 +0000
Message-ID: <d4652bc5-766b-436e-b207-49cf9838bf95@vivo.com>
Date: Mon, 14 Jul 2025 10:08:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] net: Use min()/max() to improve code
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Potnuri Bharat Teja <bharat@chelsio.com>,
 Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara
 <sedara@marvell.com>, Louis Peens <louis.peens@corigine.com>,
 Shahed Shaikh <shshaikh@marvell.com>, Manish Chopra <manishc@marvell.com>,
 "maintainer:QLOGIC QLCNIC (1/10)Gb ETHERNET DRIVER"
 <GR-Linux-NIC-Dev@marvell.com>, Jiri Slaby <jirislaby@kernel.org>,
 Nick Kossifidis <mickflemm@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Ping-Ke Shih
 <pkshih@realtek.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Aleksander Jan Bajkowski <olek2@wp.pl>,
 Lucas Sanchez Sagrado <lucsansag@gmail.com>, Philipp Hahn
 <phahn-oss@avm.de>, Eric Biggers <ebiggers@google.com>,
 Hayes Wang <hayeswang@realtek.com>, Wentao Liang <vulab@iscas.ac.cn>,
 Johannes Berg <johannes.berg@intel.com>,
 Sai Krishna <saikrishnag@marvell.com>, Jacobe Zang <jacobe.zang@wesion.com>,
 Dmitry Antipov <dmantipov@yandex.ru>, Kalle Valo <kvalo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, David Lin <yu-hao.lin@nxp.com>,
 Aditya Kumar Singh <quic_adisi@quicinc.com>,
 Roopni Devanathan <quic_rdevanat@quicinc.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Marek Vasut <marex@denx.de>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Arnd Bergmann <arnd@arndb.de>,
 "open list:CAVIUM LIQUIDIO NETWORK DRIVER" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@corigine.com>,
 "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
 "open list:ATHEROS ATH5K WIRELESS DRIVER" <linux-wireless@vger.kernel.org>,
 "open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS"
 <brcm80211@lists.linux.dev>,
 "open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS"
 <brcm80211-dev-list.pdl@broadcom.com>
References: <20250709022210.304030-1-rongqianfeng@vivo.com>
 <20250710175921.09212fab@kernel.org>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250710175921.09212fab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0059.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::23) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|PS1PPF80815FF87:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a51257c-ce0a-48e6-2e80-08ddc27b588f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWxXK1B4VGowUzRPekZBZk1GaVorNUZHM2xHSEc3ZjF1eVNlRmZkSGpiNEY5?=
 =?utf-8?B?VEJCQjNKNzRsWDlYSml1ZjFWYkFhT0pjK0dKM3pvMTBCR20xcjRQWTR5a3h3?=
 =?utf-8?B?ZG1YUVBkNVNMSmZmRUFoSDVNQkdpNm9BeSttYlhwL28zQmhVcXRsZjhqZXBH?=
 =?utf-8?B?eGVBNUp3eGYzOGRpUUw2ME52Sm1KWUIzUTR6YmdOKzgvd3hTNkxyRkJrK2hk?=
 =?utf-8?B?SGhhRVVOK0tab2hPd2pYNmhPa001Wm5XM0xLOGJPZkpFY0hQMi9URlJLYVNa?=
 =?utf-8?B?L1lOT1FESjRucXFzckJ2MzVacW9Hd3dRaGF0N3IwWDBGdC9LRDg4SzZNUWpI?=
 =?utf-8?B?Y2tzd0c3NW5IZzlWa09TdjdyZXRWSE83b3dMaUxqVlBoMlBsZ3NRZEd5aDda?=
 =?utf-8?B?d1RsNUxnMlhibWp2amNOWFBKNmU0SUEyNk5XdXE3NGs1aldiaktDYWxNSHlH?=
 =?utf-8?B?U0ZvWE00ODVabGlXYmV4Rlo1VTMwaTZUZm9wcW8xR0lZQzBzb0VJVVp4Ukor?=
 =?utf-8?B?a3d6SmlhZHNwd2IyVi9ac29ZNXhOMjlsOVhoeGtnSnZOdWVRNFBabUVLaERp?=
 =?utf-8?B?UlUrelFDampnZG1rQlR4aUI2WWxFcm5kT3Zlc3d3NjZkajN4TlgrbFZPNFlN?=
 =?utf-8?B?dlVsZG5HTWRXeTBFOUFiZUUzODZId2tIU2ZOMGcvVjJwL0R0WHQ1VlpUeGRi?=
 =?utf-8?B?bFMzVElLUHZjRVlHblVHb0ZCZVczRU9kcUVkVHJGcDE2N0l0Yk9Oc2lhUmtr?=
 =?utf-8?B?WVhYUzhLcGxrNkpTcE1VMEFyQ1kzclcyczJUNHB2dWV6WkhodjVuc0VQWXFW?=
 =?utf-8?B?b3NRTXpYM2pKWlFiMndRdUh3TVBjaW5xTURzMXJVR2tZTjVsRy9QTGR4MEl6?=
 =?utf-8?B?cEtzcmlZSlNlTkFyMDBTS2dYaUZxcVNEQUE3TVhXb21DOWtNcjFVbUJYdWxD?=
 =?utf-8?B?N0FqNzZ4U1ZiN1VHM1lGWUwzZTdvcHBBZ2FXaTRFMTA4aWtxYmNJZjBBZnFL?=
 =?utf-8?B?bDd2YjVjTXVrKzVKbGloL0d3ZWIyWVMyV1FCUEl2N2RUdWh5TkpjdjVGcHFB?=
 =?utf-8?B?WEloYjBGWEpmZXpMSHJweTdXRWJoeU5IM2VtODhodWVrTCthK0wvQWE5VTkv?=
 =?utf-8?B?QzNoUkJlaXBCRXdjdGRGejRTTkFQdVVyWFMvQWZNZ29QZ2JyUFZON2VENDZa?=
 =?utf-8?B?TXJXU0o1TDNBR0lKVkh1MVVrbzlkbnlKVTBEK2pKQ3RHTDcyWFdpNnVUOFB4?=
 =?utf-8?B?djk4enI5WE9nM0QzdmIvZEh2dVBXb3FMb1VUbURTMHhQVDZqcjhQbmM5cWFG?=
 =?utf-8?B?bEw4UzhFZFE1OHVBaGR5eGhoTktFRVYzejd6SGs3RzU3UW1zMFdlYitxdktG?=
 =?utf-8?B?bHBGMjFleWR4dEp6VS93bUhpSURRUGs2dW5qeG9ENHd2M0hwT0F2ZG5rZkp6?=
 =?utf-8?B?Y1pSalAxQmV5bXBuNmRtWlREQXRUR0R3M0FFUHJxdXJnSmJGcXlyTWJsNGhX?=
 =?utf-8?B?d2N1QjJwR2V5MHFDeWYzNE9yK0szWmVaeGtqVnE4WGpsUGt1bUtwczhCQ2RE?=
 =?utf-8?B?TGNEMmZsakJEemM3ODVUU2prSGRKQzlseEVqaTZMTkFTcmFaekFaMlVTbjJ6?=
 =?utf-8?B?TGNFcENLSWNBak11bm9aTSsrR1dWdkZFVDRhU1lyWWNhSS9FaStpdG8xSmZI?=
 =?utf-8?B?cTlVM2ZJTjlFNGtreStyTkMzRkVScmJ6R3FZeVdDV0lpczA5dGNWeWlOVlBa?=
 =?utf-8?B?OFVpTTBwRW11VGpEMEdxY1p3a25IY2JnRVk4THZuL1g0dmlZeGVVbHQvNXZC?=
 =?utf-8?B?UHJ0amxpeXBaNjZlS0sxMEFveUdEN0hCdnpjOXZRWTRlTlNGc0FJT0dmQ1RK?=
 =?utf-8?B?TmZrQUp6NlZ3ZGtGWXB1MWJycWhGaUhHaGNicittZ0kwRm1NdmM1TStDd1B4?=
 =?utf-8?Q?c7ylH0duMrI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDQwTXh2dHNqZnc2MjJiWTlMNFNJUU52TjdsOHQxeFJxYTBOOVBESGFVWjBH?=
 =?utf-8?B?M2Nwa0RRYTZ2M09LOUZLVWhid3g2b3RwZjl0N2poM2pyZUxkNGVabTVJa0Zr?=
 =?utf-8?B?SG9YU3ZmMWFsSmpqeEt3SXNGZERKQUhrVlNzOW10RUZ6cXpibzVySEhHV2Q2?=
 =?utf-8?B?WGdlajlWSWNlQ1VwNHIxam15MmxJZjNtM1B3aWpiR2NWaythZFdJWC9lMU8v?=
 =?utf-8?B?cHRNZ2NaSE1UWlpQZXVQN1h5M2JWdnZLTFdRMXpkWTJIcXdGb1N1TXRnc3Fh?=
 =?utf-8?B?ekxYSm84cktFaUNrRldoQzAxenFhdndyK2swZUl4RG91a2pUUWtGV3J0V2VG?=
 =?utf-8?B?OUF5Q1d3bmpCRzJ1bE8zUHYxci9pVG5TcDA1UDdrS3ZGRFJQZGhqTHg3ZkpR?=
 =?utf-8?B?Unc0ZURFcitwbFJXdVd1YTczTXJpY0kxbzh3dUNRN3VEMXhHTy9McWlpbEFE?=
 =?utf-8?B?WDRUdURoOGY5RmJKd0czOXdpMUdycFh0SWZvcnZvTmczditleFJoc1lvclZy?=
 =?utf-8?B?Zkl6ZSsyQWVkcTNpemRvOTRIb3FLSllHaG9ZQlJGMTZ0OGwyZGxucmxJSkFU?=
 =?utf-8?B?NzdMenF6bzlNTlYvYjZQbUhsVElSVE5zeWNEbEdhekFhZkdLZ3lsNmk4emZX?=
 =?utf-8?B?RVNCYjNvVzRtTzhYWDIxOTVwQ2xqakFmNklFbUgySUN5dEFIZG1seXBlaFZr?=
 =?utf-8?B?ZWp0UWpWNE9QKzhkYytIQ0dlNVMzdTRDR2NlVVlvUzVsVWlSa0xPb210dTlx?=
 =?utf-8?B?VTR6QnBkanBWbU1DdmpuSzZnVjBGSWlVaEdveFhzZVRmbDdjVUM1TFFyYmJV?=
 =?utf-8?B?MTFhUE1Cc0o3ZGdQWHNSSXA2WUNSL0Npc20xQTdnL3hmaXNuOUhSaVM4a0d6?=
 =?utf-8?B?MTVLSzB0L0pEeGpnN2dGV3lDWDArNGZyNVg1R3lPSThITVZCMGFDYjB3Qmhi?=
 =?utf-8?B?SXlZSjdQVGtObTRvdHVEYVY0clhEMFZLcGxOWXhPRlE1OXB5VWhyNTEvNmN2?=
 =?utf-8?B?aGNsbDBQTW91SHkxaWF2UCtNa1gzOXRGaFdDT2lTY2tGbGhqbnZ4Q3V0Mm0x?=
 =?utf-8?B?ZWxEZXNMTHFwb0p6a0dPL2xKN0NMeUJkcC8wK0JuY1c3eVg2WUdtaEFCelZk?=
 =?utf-8?B?VGRuaEdPTVBrcENnVkt1MmtNSDNNUFNINDhUUzlhTWwzaUFYdUxxTnV2SUpj?=
 =?utf-8?B?c0plU0taRlpQMkt2NWF5eEQzMEs1UFZoQ3hhOUc1THFXREhPZ1ZGSGlKb0o3?=
 =?utf-8?B?MHZNVGsxWmdTaUJGNm4rbDR1UWkwMGxzQlRvb2JaT2xESndXOEdwRVVJU1or?=
 =?utf-8?B?Nk5xK3pxY3FwRmx1bmR5MUR4dkJQZmp3SEkwUmVFL1JCcUpuUjVkaGhSYjgv?=
 =?utf-8?B?c0liODYrQWYvaU02Sm5semd0VWVyeFF3RENuL1NOaGo2Sjd0MGxJRkVIUnF4?=
 =?utf-8?B?VzZJcittRWF1VlRNNktqc2RGRjRSdWx0dWpza0laWnBYUGo2NWJ6akZrcEZ4?=
 =?utf-8?B?UUlqMDIvK0l1ckw0Vi9neGZkL3k1YzY2TTF3aFVrMGFOWURwWm9CTndIdU5p?=
 =?utf-8?B?a2xzMU82VmJaMC9HUzQxdlhXRSt3cTl4WmE1b0dtKytpL29RM0RLWXFlNktE?=
 =?utf-8?B?TFZtWkQybGVRMkt2QXZERHdzVFEwVUxOL2ZlS2M4LzhYcDdWYXJTbjV3N1dS?=
 =?utf-8?B?LzJlMVAram93K0wrRGcvOWhsbkY0Tmd0NlkzRXF1VTdQOFB1OVBFZnl4dFBa?=
 =?utf-8?B?L3hvVGd4NFB2MXdVQ29icDBLU0NuR0h4djA1MEQxNlg3K2ZvbXdRQVczNVJB?=
 =?utf-8?B?ZFVGWlJsZ05zWklqdktpZG11cGQ5NUZBaGRlS2JLajdDNFFWb2c3Yko1S1BN?=
 =?utf-8?B?UVNUSmNWK0NsUzZpei93QXl0Z0tuRmFrWUQ0NHBGZXZjblI3UUNQL0N6b2x3?=
 =?utf-8?B?UDRHZjZWejNwM2x6amRyWk5tWU5HUkhPTEc2dDhkNWRMcUpLVmlITlZsOS9C?=
 =?utf-8?B?VGo0ZXlwM3lZZDVuZm03cGZmbUNKc2M5a1M0dEZwcURuRzB5b2czaFNlTm9C?=
 =?utf-8?B?d2d4Qmc4bzk4UFNIcVh5MEoyRlJOdHQ1NWFpeW5NSTQxVnRvdm04UzBtTnVw?=
 =?utf-8?Q?7exFwiiWYEYaE7iNrR9L3LTea?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a51257c-ce0a-48e6-2e80-08ddc27b588f
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 02:08:38.2992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnqCgY2TUe6u/AOG/bQmKf8U4B+EDVgPFUCyEbvXwTmVPv7JI7mKE3ONNZH5kgTdyZz8L+mT6qCbWJTnGcBp3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF80815FF87


在 2025/7/11 8:59, Jakub Kicinski 写道:
> On Wed,  9 Jul 2025 10:21:28 +0800 Qianfeng Rong wrote:
>> Use min() to reduce the code and improve its readability.
>>
>> No functional changes.
> For net/ethernet/ this is not worth the churn, sorry.

Never mind, thanks for your reply.

Best regards,
Qianfeng


