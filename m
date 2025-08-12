Return-Path: <linux-wireless+bounces-26320-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F125FB22A4E
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 16:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 362A03A583D
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 14:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9108B291C19;
	Tue, 12 Aug 2025 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="h9+/ju6M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013012.outbound.protection.outlook.com [52.101.127.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B1261FFE;
	Tue, 12 Aug 2025 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755008035; cv=fail; b=kI0Phc0sa4E0bX4dG4Q6ZLdn2Ilh3hQANnrhETy8M5yJenyQLwc9LKvqYYFWoKfefb9Ht5CZZCu/M3HWa40fB+ozoYyvNdUcIIi4Znu/O13rnj6U733FGgJ1BZF8hAruDg+tyP3vF6Nz7EY6LdssVKtCN9VVIDa0AdKELWO+FGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755008035; c=relaxed/simple;
	bh=ljtmcUkUcSBTWsUSJGB4jRWez0YZvLnAp9YbujI8DlY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cxA5/HSoLZCaNKjMZXRuyNNpaQd5gJxM/8nsSuvLAXDkrkL6FDvU6srr7TU4dcXnSU7LOeSJA6jNXnF4GDJggEVQpTkeAV24i00y64rBfucGWm+d9daTUxKcJDIBaCiZpzlKUjHmFYYin7Y6Ko1TwwpRwgNW9N3Myfodai+S//w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=h9+/ju6M; arc=fail smtp.client-ip=52.101.127.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWuNhA04UJ6A2Y+ggVWQiJwMwBPY5BNHEoRuTErRSAhEWdzc2FzwGYXOp7YzkM7TPpLIsvMIMP9xVXW7tjEI/Xl/Pm8oQLJC/MkaJIJL+Wc9wK9oRqRVJMKv688i2+ep6t5d8R0+oN14ccAOFq4BdYd7YpLMjfauJWLEGPFTlUaJPpgJSA2CL41Rc1EsoFxuQfNdirivfz/nOtw47705IjDoRi6gJ8/YDgbIsjXCNEcKl6W+xiCfgEtXfL55FM29yQU6/p4Vve2YphvqKkmuw08QvOvkrgrD8oIuMjfVcRz489UBjcUfZYV4JyXFscSP0F4Nq9g5bSu1TpvRCFM7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZRw+P9V9zODY/TufI/AMRwQau7EPFTuKMOQfato1y4=;
 b=Fw5BfBPYKMov1OrGFaqtzTMNzWxQZgdyGiZah0Hm6fh/B96GvRKx15DGqFw4HTI5ZUkJx2ZSnbnoetnYtlHuLmmkyobvpPPzkrS6eJz8E6GNBTcDmzpZL+rHR4wZlOdYM8mKljbRSWsi5FVlEpfPtX8t50Keev1b0I7evB4+wVOTsXzRnRIy1HVvKN3Swu9PPZG/BKfUPdc8mRsyNVDNut0G2QQd+Zo4Sg2iI0ZCh9FUbFITE7188bAGP2p7KeUMJbdn/gxyaIyZch9SlfX/91jRHn5f0T7NKoxR3z8Ts4ueUSgDafvob0f9IZcmmupq8Cb6vk6MKCeHYZ938NCEHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZRw+P9V9zODY/TufI/AMRwQau7EPFTuKMOQfato1y4=;
 b=h9+/ju6M+1MgZLTtxBk8oReQ2eACHb8/4T+NJICbbNq2kit9UxTdEBq7L/KeeFUJKQy5+UVQ8SOPfYHQoqrLyQEQfPj0/cqtwSb0eoE2iVqFSlzobBXM+xtJsJUeDI9zZ5pkRI/f2gR5kEirfaMWRHIanUhqzmxxJhR49zEhe7vuGe6p913Dcc7KUOD1BEta7vLiUhgRvDfuHkgzD2YWsGKMk6F/AWNiaKzb8nhd1bg6Z2+2HUcNCX9Y3VNq45YWDK/MQlHRM2KPga/NI0TLDPvrUwjMph0DfNwPPcTk9HKBxX7IxbZL/ipUJGoc93vSwWWMaTz4J2w9W/n7D/OoJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB6251.apcprd06.prod.outlook.com (2603:1096:101:c4::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.20; Tue, 12 Aug 2025 14:13:47 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 14:13:47 +0000
Message-ID: <e66eb22f-5565-4f33-b523-f93dc81a1210@vivo.com>
Date: Tue, 12 Aug 2025 22:13:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] wifi: mwifiex: use vmalloc_array() to simplify code
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>,
 Johannes Berg <johannes.berg@intel.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Kalle Valo <kvalo@kernel.org>,
 Aditya Kumar Singh <quic_adisi@quicinc.com>,
 Rameshkumar Sundaram <quic_ramess@quicinc.com>,
 Roopni Devanathan <quic_rdevanat@quicinc.com>,
 "open list:MARVELL MWIFIEX WIRELESS DRIVER"
 <linux-wireless@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20250812133226.258318-1-rongqianfeng@vivo.com>
 <20250812133226.258318-6-rongqianfeng@vivo.com>
 <aJtGSxkRztAsy92h@stanley.mountain>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <aJtGSxkRztAsy92h@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0232.apcprd06.prod.outlook.com
 (2603:1096:4:ac::16) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c726a40-94e8-4879-7676-08ddd9aa7429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDU2NkpLVFNEWEJzMmxVQ2hmK2pFRGhOTkk5Nko1c1BGb1RYWWFxUmtLUmhB?=
 =?utf-8?B?bTgwZEtSSEluZGZjOVc3RW5wcFdkc2VZUzEvVmxrQXBrWUlwK25CNStXMmda?=
 =?utf-8?B?ZlZneTNHb0ppQTlhVjRxVFE0eit2OS8zRE5jbXA5RDVTczFmTG5PNjJwNnAx?=
 =?utf-8?B?Mk9OUlJLNUlOWEVucXVnZTBpRmNHUUFjRHoveEpGc2VTRjZNQ2dENGJzTnNT?=
 =?utf-8?B?a0RLbEpNYXJFdXRxcnVHNzZUbUhCWmlhemZzaC8zb2dpT0tVS0JxNzhEU2FP?=
 =?utf-8?B?VmJKMXNmekhnMnJJalp6SzhIYUIydXAxeWhKVExBVFlSZ281bmM2UzMwNVNu?=
 =?utf-8?B?MDZGbWtEM0Y1dE5WS0g0K0ExMERTZlUvVFduWTBEZHBLRSs1TjlFMkxmN2RL?=
 =?utf-8?B?MnFjRVJvY0g1bEQ5V0c1V05kQ3Brb1ZwNGR1SE1KVjRXNDcyWDVhTmxyNy9U?=
 =?utf-8?B?dEZML2ZHUGxrN3BMMHY3UHFJbkNBNnZIY3NTZkt2YTFVc2E4K3VVN08zdHhS?=
 =?utf-8?B?MzYrdktkbVNEL1p6OWRZM1lIQ0RUclNnTEZpVmQrZUdHbzE5Sy9ENkcrbWxY?=
 =?utf-8?B?UEIySStYdXhBM0xEU1BWM3B0a0dkOGdpajdlRksyb3ZFUFp6TmtjallDbmRX?=
 =?utf-8?B?aVF3NTFUa0FQWmhvQzB3cUorandFcTZIN0kzZnY2MUFEcW9Fdk5qUWxtT2Ja?=
 =?utf-8?B?N0Nwa3pURktKUHpuZkE1M3JJOWZnV0N0TnZhbkplL21Cd24xVzRnZWxLNFZa?=
 =?utf-8?B?R0xWdHFYWVNCbFZpYTVBcWVOcS9UV0FsalpXSjJUZnk5c3hkUDRFY1d1QXFu?=
 =?utf-8?B?T0hmMW9zbkdpNklaanBtdHdmSkwyK0lIUDFvblBLZlg3TkZpcUk4NnFFQm9D?=
 =?utf-8?B?T0szVkJ3OVNRRWJjdS9BNFphZUNqQ1N2M3JQdnY3SVRGTmhzc09KNGpBRDlP?=
 =?utf-8?B?QjloN0hIemRJVTBKU1VYME5xcW1iMGY5VHY2TDl0U2pTVUlON3NpV3JVSEdP?=
 =?utf-8?B?dmFMZmgrYzZVVGd4Ylg3ZUN0L2NRbVY5ajBUcmo0QzA0anY3ODBFb0lKUnpz?=
 =?utf-8?B?WDBncnpVQlNCT2l0ZGZFRnZJUlR5NzN2SE1VR0t3QkdKN0VUVm42bEFaNVoy?=
 =?utf-8?B?K0xFeVliNWZGQUJXV3RRZlpxNmJaWHgrK1JNVzlOdE4zMExObm5uNXZtYVZn?=
 =?utf-8?B?M2JZbXlkalhZSWpoOCtvcEsyMnlPQnFyYzEvTnp2NUE0YTdwdStJNVBJeDl5?=
 =?utf-8?B?ek5zOGsxTld3RmJVMWNhSmZkYkc3UzVRc2g0Z1AzOXUvN1BwYWJFTHFDY3ZJ?=
 =?utf-8?B?dGFRMEdnVHdRWGVSOE9nS0k5K2VEVlJjbkd0L1VGUHlmbVgvQldnUWRYODRv?=
 =?utf-8?B?WktaYjg0MnhSaXFTTVJOSjlZMW1DdDRDOXpkTWU4d1RTK1lhVXE3UVlpSHJa?=
 =?utf-8?B?L1ZtNnFxclhqMkdQZFRzc1c3UTduc0xRZGMyTU54VUdxekdmd3ZBVzN1bmZ0?=
 =?utf-8?B?ZXNLWmhYR1FFci9BeUFJdGc1Z1UvejN5aWxjeThlZ21CU2Y2eEJsK0Vidjll?=
 =?utf-8?B?aVA3cUpleXdVOW1jdVBnUk5uOVYwdTZNRlVqUE1iYjhPM2dIMHFLVkpZd1lQ?=
 =?utf-8?B?ZUxFV1hOMnNlVXlVTUF5dytXbnd5OEZlRzE5cGtRM2o0OC9YYnJZUjBSbXZw?=
 =?utf-8?B?eVVVeVRXZGFNa0RVRXNUcmI2emhYRGNVTzJNNXpKb2VDRG9WazVtcG01Z2FR?=
 =?utf-8?B?K3NqNHBpa1g0V05ONFZGQzZmMXgrWGhhR01mZmdSR3VvRWtkUEk3Y0hiTnZn?=
 =?utf-8?B?RDNJWHFsekE2QkM0alhaeGlGZzBseURBM05rY2FiMG1pbSs3Z211TkltaHda?=
 =?utf-8?B?ZzVXUUswa1E0enBWV2ZxMnVsUTVLMUNzdjZrem1ZaEUrRlBtcXFqKzNmVElM?=
 =?utf-8?Q?b8tfeaj/3gQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3JpcVpUWGtNaDFtUVV5a05td1VWMFlQbk9KcFEyUTdRa0NHWEZkUStzU3cz?=
 =?utf-8?B?alFBV0svemE4UzFxZTBucVBRUitvRGtJaFF3U1VEYklvZHhQN1g3Z09BNnlJ?=
 =?utf-8?B?Vm5JVXFsdkFPQzc2MVA5anpwRUptak9MTjB3RkM2T3kyazBvRVVrK1loMVlO?=
 =?utf-8?B?ZzRnWFQ2UGRZQzdreUlTS3phTU9YajRpTVpFbWtVMFdvTzRLb1RMZEh5bnRl?=
 =?utf-8?B?WG1UTXQyUWN3VG1wcmV4SE5PZEZvNURzZGtNWXJyS3BraGxaT09EQkFPY0pt?=
 =?utf-8?B?MHcvQ2VtMS9tbGxoOEZwVXhGYXdyeGdQTWxuOEZYNnlkNmxKKzV1ZzFRbGpU?=
 =?utf-8?B?M3JHUTl5UUFEZ3ZpRE5rb200MldZOFFlVEowcFhiSFRkdEF1WXpjU0lRM0pm?=
 =?utf-8?B?aExENUdUQk4vSnhkaXJ5RDlVZHVGclphOWtjWWZnTXBtbzY4T1NpbHdYVmJw?=
 =?utf-8?B?cWVZQ2x0aHhxTm1OREFBT25lZ21qWVdXZThEVHYzaCszMkRQclR1RTBnVjhD?=
 =?utf-8?B?d3FJRkh3ZExoSWVYMi9TN2pObFNRU3Zudi9LM2tKRVp3Q2Nkd3dDVithZE02?=
 =?utf-8?B?c3hoL05aYVdqaWRXMHVhRjRtem15cG83TjMrT1BiVDNyMTVmL3BEdzB6T0dM?=
 =?utf-8?B?Y3dCU1NTQUc1YVNZK2NsbUxEd1daYmJQaGpyMUVMWmNHNm9mbXdpQVJ0dmRX?=
 =?utf-8?B?QlRNK0wrNDlnbFNxVDJKbFgzWjVacExmL2Q0WDlUYnNoTnhPSnZscGFleFVn?=
 =?utf-8?B?NWJkQVlOMzJVcHY0c3NwbXNWR0NTM1Rlc0R2TmQvbkR4VFNHZ2tCNm5FSVdu?=
 =?utf-8?B?YWpiamVScE1kNEhGSUtVaVVMTnR1b09zdWJyUWdzVEx4NXJUOW5MSzlIcEE3?=
 =?utf-8?B?WVRlZkJGVTRUOUhibkY0WElySVIxbHNaMUxVTkgweHVoVEFoc0hrYStCK0pv?=
 =?utf-8?B?bmtHV210THM5RUdNTGhhcm9MblcxdEMrYThUQU9RN3dQclY5VWFjVWxNSTl0?=
 =?utf-8?B?YjQvNEppcDdkRkIweGdwNXdyMXR0Wm9MY2lnT2lGVmxXTHJiK3VmTU9HNUth?=
 =?utf-8?B?cUpGMTkyN2Vkd2IxU1dkeFkwck13VGIxZEMrcGM4TmJObmJxUVlrTCsxL1JB?=
 =?utf-8?B?dzRBWUtvRWRkZlNyQjVKMFZnUWNmak1Fck1YWjNMUXhsV2JldTh2WjZsSXJ3?=
 =?utf-8?B?UFR6S1UwMlFpdW5TaHVkS0xEa2Zpem1yZDhiMnd1Q2QyQWVrMWNQc0JHYTc0?=
 =?utf-8?B?WllQTi9zaDMzVHlLQ1oza3JQNy85TFN1b1JSWWx3Zm83bCtqaGdyUjBpeWU0?=
 =?utf-8?B?d2N6ai9XUC9RaGZpa1RsalVlTmdhUGU1eVVMZFBHWktCenZrRFJSekdBczd0?=
 =?utf-8?B?Y0lxWDBucVVtZ005OGhKS3daS0ROOTY0eERvWXZncHNmeGsxY1FRUGYyT0tz?=
 =?utf-8?B?L2dRTVd0ZGd1UjFOdlVLMWlPMGdDazA5YXNXQnNRNS9zMjNXclRSeXptZDdY?=
 =?utf-8?B?LzNSSlVsMWxqNWtUaDg5LzZIc3BYU0tSRUNDdGh1S1Z4U2hwWmh3RzNMZTJh?=
 =?utf-8?B?RDdiVURYUTdTcjcvN0JnT0VLaFFaMGgrU29seHlUS0FibUlyVUtNZnRXV0U5?=
 =?utf-8?B?YUZMVXBaSlBnMlhJQ2hTV2xPWFBYZEZ3K1RiZFcvYmdhdnpJNDkrRGdQc3F0?=
 =?utf-8?B?RWRoVGxubWI5NU1DL2I5eWNjUWZ1N25YRHNISGJBeUx4ZVlKcU9EN3hnM1Rh?=
 =?utf-8?B?Y2YxZXFab1M0Ym5EWXlKNzErcXpTOENJdTV4MFVKaldYSW5KRUhlRFhRTTFD?=
 =?utf-8?B?N1F6UHkzYUJQei90dm9KQ2pYWWFPdHBvcWU0Q1J6VC9nRGlqSTVPSFF3dG5p?=
 =?utf-8?B?Z0tsck9IZitad1NZTTFOUjlOY3V5RUlrcVRvMXhOd2l4UURMR1ladU5aK1pk?=
 =?utf-8?B?UUhYeHk4QUdQdi9ZRTlJcU9QY3AyZUp2bUZHUWEzV0RhNGc5VDNmRmpoSGNi?=
 =?utf-8?B?dTZZRGVETmRiOTRNRXpHcHBJem0yNlVZL3pPRXdRbEhMU1dpM1RqMisyck40?=
 =?utf-8?B?VnU0aGVGcTQ5dklWRjBvaE41bE5PSFFUY1p0VWtpbCtocVA1cWk4Wm16cjUw?=
 =?utf-8?Q?7sJDcZ9j2tOCN28VjzVdG7d1d?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c726a40-94e8-4879-7676-08ddd9aa7429
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 14:13:47.4132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uI2DDUR617zFbswEu5pN2uvL+LUuWBtKlpMPBKclfnN0P9fF/jDCQ4xt7pIrJb+T+xvU2BqprJaRHVrhq9IF3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6251


在 2025/8/12 21:48, Dan Carpenter 写道:
> On Tue, Aug 12, 2025 at 09:32:18PM +0800, Qianfeng Rong wrote:
>> Remove array_size() calls and replace vmalloc() with vmalloc_array() to
>> simplify the code.
>>
>> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
>> ---
>>   drivers/net/wireless/marvell/mwifiex/cfg80211.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
>> index 3498743d5ec0..fb4183ff02a9 100644
>> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
>> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
>> @@ -4673,8 +4673,8 @@ int mwifiex_init_channel_scan_gap(struct mwifiex_adapter *adapter)
>>   	 * additional active scan request for hidden SSIDs on passive channels.
>>   	 */
>>   	adapter->num_in_chan_stats = 2 * (n_channels_bg + n_channels_a);
>> -	adapter->chan_stats = vmalloc(array_size(sizeof(*adapter->chan_stats),
>> -						 adapter->num_in_chan_stats));
>> +	adapter->chan_stats = vmalloc_array(adapter->num_in_chan_stats,
>> +					    sizeof(*adapter->chan_stats));
> n_channels_bg is 14
> n_channels_a is either 0 or 31 depending on if we're using BAND_A.
> sizeof(*adapter->chan_stats) is 10.
>
> So we're either allocating 280 or 900 bytes, which is quite small.  We
> should just use kmalloc_array() instead of vmalloc_array().
Switching to kmalloc_array() requires changing vfree() to kfree(),
but I couldn't locate the memory release code.  This modification
likely requires deep familiarity with the codebase.  Also, for
variable-sized allocations, kvmalloc_array() is preferable, but
requires kvfree() for proper memory release.

Best regards,
Qianfeng
>
> regards,
> dan carpenter
>

