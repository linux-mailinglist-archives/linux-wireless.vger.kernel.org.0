Return-Path: <linux-wireless+bounces-38171-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4LsHC6RkPmrcFAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38171-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 13:38:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B70C26CC8D7
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 13:38:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=YPKA2AjR;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38171-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38171-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D87A7300360C
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 11:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD84E3C81AD;
	Fri, 26 Jun 2026 11:33:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013074.outbound.protection.outlook.com [52.103.7.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4809460;
	Fri, 26 Jun 2026 11:33:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473590; cv=fail; b=rX3KyGpv1BrttS48/E/GSffFbqNdzH07Mt2amGrNSsm95dt7LdTOhmrrIiu46mshtQMIlbXaN6QjAzyVjaoYQYRAaJ3LA9ltpm+nAbSKqiTwuhnHNjuxG4J64btV8iEnEu07lPSHPEKDZQSTaxrG4YgcFPy52pwksqU2nO/4DSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473590; c=relaxed/simple;
	bh=JLWvj0v5kYZ1K0Emm8CNZwtcBNuHmp1bYBFUxSg33jw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lK2lAqLPgmUWqhh3dnAda9zrC9OTa8o6Sp+brZ40fmVls3xag8uEUHeRW7RZggV6+C5C/k/pOfQWvn/ocsHy4r+v4fPbwqjD3nVxosU27wJJXn4d049xLslm+nFy4h1D4UnHc2imDtVyNk8MEykAN5kCfje1Uj3LvHQP+cYN6Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YPKA2AjR; arc=fail smtp.client-ip=52.103.7.74
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0lRCG0aghqf8hZUVQ/uJ4d4C4VIm9FXd8sWIcCcqBkBmJ1fOtLrlmHOWN6vS0u405IMfpNUi9w/vey/HpRqcgFLHYwrwsUXHBkRET1x9L3dUHLy/E+g75ZeLY3SnGpGEgFFVljY9AO5q4L8sGgkY9IS2vENfR93UroQeqWLM9XKmd4gFbYgCrZw63x/Pnh+KB8n+Uy+VKSTw81LpbbqM1hts9eedm9UagLmvCa4T2SdCHOn601Rngxl7aimihFZt6deaK/zjU0hmw52/1EGhxH93IYJQICkE42Od4CdlS5PsuREQgS2mGPtXPECh4tc0MZsrN5E/CWGDkr1bMR1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=corYM7TW74lUq1/Pnz1PBy5eVYnH9WSJF93bXIC6udM=;
 b=JcD2k+5YUfneoUlYEujYnOfEr0J9WEvjSyl5KGOeqhuGNP9oyqEVjzfb00i/xIq+gv6rPdXKOP7wvVCtDCUFzXKtSa6UiBGn1uM2nwRUKDhf0KwdeHRsJCLA/PVcQ9q9HVGgDkkUCPX5iZ4RxgHjfkiwuuUXiHxkX+/htaSYpJ1koGgpQyWgnxcPhYTbqXFQKU/zo+LjuGlcVdEPTMWBlP8T8U58vIeBgjO/0ZnFiwLzdVDTiMz4FbgTSO9zCHLDzeU4CU1FBxtJTbqbLK5FUpbAlFvUcK6yWWCWtHV5lI/jD991HmB+gkvuo3hZYFrMPzsUl/8m1WIDGZ7UOVGIXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=corYM7TW74lUq1/Pnz1PBy5eVYnH9WSJF93bXIC6udM=;
 b=YPKA2AjRmW78GCAks6WamGPRHug0hQyeB7FMEmDcF6ovypH6Ob+BkUGtV5yoeaLQskktecko7/9s7vhcqoV3z6zEFx6bDWVINIdK1FUv9dISgLcTwttkdt2Jbb6vMlVFd3+4gpCMsBh08TwtDL+5snlU/03SpQ2Q03tBAelOhtGNUIqe8pzeKUNAEj5LOiJt4ybpO+YYKKhLpGFnL5/zJGxudYOxeKNWJdcsSxkqRAxXY0hoiAsl5eKzOo0b3wuZuQ4BPl4jhkILQK4lPdFx2VdGOUMaqtIgJqXArxEPrtVeyM3SpkZ7P7TW8nMh2PzakNdotMaPhCa5YstCqL+Tbg==
Received: from SN7PR19MB6736.namprd19.prod.outlook.com (2603:10b6:806:263::12)
 by PH0PR19MB5004.namprd19.prod.outlook.com (2603:10b6:510:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 11:33:05 +0000
Received: from SN7PR19MB6736.namprd19.prod.outlook.com
 ([fe80::4b6c:b84f:b71c:d0a]) by SN7PR19MB6736.namprd19.prod.outlook.com
 ([fe80::4b6c:b84f:b71c:d0a%3]) with mapi id 15.21.0159.007; Fri, 26 Jun 2026
 11:33:05 +0000
Message-ID:
 <SN7PR19MB6736CFB46F0B6339026FCAC79DEB2@SN7PR19MB6736.namprd19.prod.outlook.com>
Date: Fri, 26 Jun 2026 15:32:52 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] remoteproc: qcom: Add M0 BTSS secure PIL driver
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulfh@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Johannes Berg
 <johannes@sipsolutions.net>, Jeff Johnson <jjohnson@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
 Rocky Liao <quic_rjliao@quicinc.com>, Saravana Kannan
 <saravanak@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20260625-ipq5018-bluetooth-v1-0-d999be0e04f7@outlook.com>
 <20260625-ipq5018-bluetooth-v1-2-d999be0e04f7@outlook.com>
 <38aceb33-b28e-4994-b277-de070b6dae2b@oss.qualcomm.com>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <38aceb33-b28e-4994-b277-de070b6dae2b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR2P264CA0164.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::27) To SN7PR19MB6736.namprd19.prod.outlook.com
 (2603:10b6:806:263::12)
X-Microsoft-Original-Message-ID:
 <28eaa516-7c6d-450e-b2cd-e86eb16084bb@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR19MB6736:EE_|PH0PR19MB5004:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a90ce2e-bf43-4369-133a-08ded376b043
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwUXBahuwteIkQeW30lJPuxOhuXbZtqyYbUxU6oJXY2hc/RJbjo/0cv8NhnZawQgS6oWE/3l/0jusfAXWQDE7tVqCL+Aavr6IfoMCH42EneEJu2hPGoaqakwxzHzdcgq1uyA9PeJF/PnMsJdw6dtwsw4LndOX+LHEdbUdCbho0yJK75nE4TiWtlDK+RaUF8NrWASqYRPUN2eUZwdC+2qyz6jf3ufxPPyyDv4I+3sPGSlydnYP0z+o86T2E93nRhX1bZ8d2kY0GeIPjXYZBG77yA3fAwQHmV7udsuk+v4iGyjWB/ITQbIXFfcQZC6nF29WdepPqdy1MJMKA7lv2H2jg5qbjS0Vao6HBDiXiWm0XLTSAVFYcpLLyLfCcHX+CRkkoWKxICHZ/kRW4cOEcXUzaJ92/sG0oM+lFoKEcQOWEJZgqnK6pxliype3zX4QByraLSc3yg+JV3iX+XaU5KxzLMd7ssVbLwJBy0/KzF8M+J99lwVhgPt2H7wji8YA/ikGkGmhz9gUVJYcPv3h1fdgDuFe6xClHrcymtS0QWNIsoRuHDXKAgtarqS5XGvXxkaBC5XHwyImdLgPcEVLbq+/S5gmEbSR5+mOq7gC7bq4XuCG+XmbPckwJ+CvfXuZ9LDH47jSEcP6QtfsnIgmzL95/L15AAVyoOqfav9CShn294ZUtTA5rAcGiGP/udOYIIjjtdYqq7lZXy7ZDUg5R0mKZbh14ksljd4p6RAMK7W0SLXBNtPxHjLda+47DXqRWFqqvU=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|37011999003|2604032031799003|25010399006|24021099003|6090799003|51005399006|16051099003|15080799012|23021999003|41001999006|19110799012|8060799015|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1lmdm9GblFjanpYNnplL1J2ZkdDUUp0QzFmTXJBV2EyWmJBVXZCd0FMTERq?=
 =?utf-8?B?WnkyNEN5SWhSdjcrQTJFa0ZvbEdEQUJYMUZRdDFpRmw4ekpHcGNBLzRSeXMv?=
 =?utf-8?B?SXd4TVphWDljdC9CamlNN3k1eVhuR05INk5HVVA5VTQvQXZIdktiaTd0Z0Vq?=
 =?utf-8?B?QUtaYUE5ZTBzWURTYTIyOVhweWRDRUFxQnlETVU1WEFoY0VnN0hjb2xwVnh6?=
 =?utf-8?B?clowTEUrYklQVFJoUHZWZlYxdmo0N0hZb3NPaHloTkpvcDMzREIvS3FkVC9x?=
 =?utf-8?B?OElNeU1zQUc1ZjYvd0RCcCtDNkc4d0wrU0VwVGtLOUpZTzhmb0R4VmkvMitk?=
 =?utf-8?B?OXoxM21ydTY5anZ2MzZmaEtDdlBIYld5WEE2UUZsT3JubW5GdU1vTVBlSWtZ?=
 =?utf-8?B?UlF1Unl1S0l1K1UydzhnSERxUVovY0RoazNHWm9rOXVsN2ljNHBCdENWTSs3?=
 =?utf-8?B?b3l1bUdkVDRoczBwbmVTbWVzMzFZdFZGS2g0SFdqVTBhN3ZUL2FvK0U0bmVw?=
 =?utf-8?B?a2s2UlJxaGorTEpmR0ZLdDRvL0gvbVhoM05oTWtXd3lHT01iQi9TRTZTeVkx?=
 =?utf-8?B?eHRrRzlTU0F0Tzc3RnNKcEFCa2hrWlJOOEVHSjFTbWlUSjBLT2NMd2hkSW1Z?=
 =?utf-8?B?YldIb05FeTgvNjVNOWljcno0YllLczIxUzRDWEIvTFV6YjduTGJvS0NlaG9D?=
 =?utf-8?B?Y3l0ZGpVVnk2MjZWaU9RQUhEcForVGtVY3BHcHgwVXNwNnRVZGRENFZNc3Bz?=
 =?utf-8?B?VVZqSmxnMER5SnEveDFzUFllQjRLZ2MxRmxRc241UkVnZEdLQWlmNjNTdThF?=
 =?utf-8?B?Y2pJVzMzUzZKaU9KZFZUS3RHNFIwMHhEQVptVVVNdWdhdy90M0NkdG0yS2dP?=
 =?utf-8?B?Z2JJYWo3YitkKzJxVkZlOGxZSWtoeXFUSXNPOFBKSFltZnRXeEpUM3pzcWUz?=
 =?utf-8?B?U0lFVDhvQzhHWGRub0RJMjlFdzA3UnpONDJLdE1WNlQ0LzBUUE1teUhheTF1?=
 =?utf-8?B?REJoZXBxNUVYSThRMFN4M3pZSnphQk5wV01DVFFDNjhLbVNacGNGMExWN0NL?=
 =?utf-8?B?R09nT2YrNGU5QjYyYVVQWWdpVFpGNGJVUXZsczhXY1JSa0xZK1o3TjBMT2Ja?=
 =?utf-8?B?UUhVanVKeUp1bk9UazVBRTdqSEJTVERRRGFJSnFuVDVPNTNybzBTOTJnRVRR?=
 =?utf-8?B?WUljeWtmelkwMWNsMWdPeEs0T0JhUVVCYlloNk1mNjFRR1lEQ3RYSUpCVGJS?=
 =?utf-8?B?WWJwcGM4WFIyTlNzd0FRODFLbjZHV3lBNzgwUFB0VnpsNW5NNXdISXIxVTg1?=
 =?utf-8?B?a2Q5WWZXR1R5T1g1Wmt5eWhRMTEvZ2NFU3gyMHRoNDZUaTV3dG8wRUdYTkFk?=
 =?utf-8?B?bVJ4OHlUL3I3b3I5aTV0K3V5RVc1SFJxZUlseWhHRDJPVE1YNFhqRFZLOUZs?=
 =?utf-8?B?M0JyUnlPYkRMVzZhSGkzWGNhTVo1QzV3RUcyTUFVR0t5QWZiN1Zzd2xRbEgr?=
 =?utf-8?Q?2m5zPw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjk1cnppVHZrdDVIbUp6UnArL29aMUNWTXg2TEVIWXhKOUZvZGR1dExsQlVh?=
 =?utf-8?B?TE5IdmFybVBjZDQrd0NUaVJTK21XeEppTHB1cWowb1dnWTI3SnJZRjJhUXVj?=
 =?utf-8?B?eks5QTdLdjB2RjRmeC9Gc2JXcXNac3Qvbm1XREVwK0lMU2lFcnB1K1hLbkhs?=
 =?utf-8?B?Si9LVWsrOHg3OUVTc2lVWkZsUnRtL3BOMGQ2Wmh5ZUxMTmp2d0Q5Mlc1ZjJo?=
 =?utf-8?B?ekZmLy95bUEyenQ5SXUzcEtrQ1c1cWZmU2M4WVhCZFkwS05kMzZKeTlGK1Ay?=
 =?utf-8?B?Z2dBOTR5VmViazRrSUMycUs0MHZOYWN2VjVGcGJxcnQwc1pEVDVoWGp6bFhM?=
 =?utf-8?B?aGsyMFE2S0hYMjIrRW0wMHhpS2xjNk1hTTkvc1hRNEpLRXFINEp2dVIvaGZz?=
 =?utf-8?B?bFoxS2dISzg4V0dmekRob2JsQm9KeFpFNmVDUE5SaFREOHZOSndRMlA1VVRm?=
 =?utf-8?B?cG1QQ0VaQ2pLRTFQOVhrQmJ2RU9PSlNydWxjT2ZMSHNyY1hncUtOQXd5VGVt?=
 =?utf-8?B?c2xOWXZyQ0x6cWUvWUxhMFBTM0k3OHowQ2lHNVpZSlQzY2s4L1FqWngyYTRC?=
 =?utf-8?B?akFxNHM1THQzWi95anpCMThCTGkxaFdFcncrQ0JlL25UODdtRWlGeFNtcWsv?=
 =?utf-8?B?b09UNllzRW5UN2xUWVJPWTlQYW9FbGUxOEoydS9OcWlpbU95NWpPa0E2ZHk2?=
 =?utf-8?B?WFZmMGhtRWM4MDlBQzdQdW90Y25ocnEwWFBKSGVPQzZqa3VuVlB4bmhYZnNk?=
 =?utf-8?B?Z294Rm5uK2srN1hHNmMxSmpnZlZ0QkU3VlcwUGpSUXh5N3pxRnEyenJPOGVl?=
 =?utf-8?B?LzVWS3dYMTViUEN1TVRIazNTbEFvZkdBYVJOSFI5cC91MFlOaGxQWDFLN0xU?=
 =?utf-8?B?VVNvZHNOYktJbUsvOGlGOEVGRDFUcUdXdUFvcXRDMkc4RVRqSGxCbW9kcmVQ?=
 =?utf-8?B?ZU4rVWdYcStuZUNwSTY4QVhlenFHRy9hZEVTci9Cd0xIZkF5dy9VZjY0T1Mv?=
 =?utf-8?B?WEIrT2pRQXhWQmw1d2JlOGZoRXdRS1RVYUh3U05wTjBYaVdwM1ZhaUIzWTh1?=
 =?utf-8?B?ZUs3Vy8xS082b25qSTNKN1lhdEUyMWcxNU5BQWEyVTRaNmViTUlrcFBRbTBY?=
 =?utf-8?B?aHd4SHEzaVhXaVZaejI4T3BJb095cmI3QjVRVURQeWtjZjdhVWlFQ3Y2eC90?=
 =?utf-8?B?ZE4waVNHeGdoeVlhbWlObERDT1gzU0ZlYUl1QVlIbWV5MHhxMDlxVHJJYy9M?=
 =?utf-8?B?TVhRRG15UE1Edy9Vb2VKakpNV2h6V0t1dURMSkIxS2dON1oydFZiWmJDem5B?=
 =?utf-8?B?eUswSWpndFl4UUtUN2E0d2t3cTZGN2xRczdVWGlzR0lNQi9WWlIrZWhhMHc4?=
 =?utf-8?B?aG1sZGpnRC94M2dYcFRjdTBvNzV5cExOeFc2SU5lTjdHSVVlR05KQm0rSlVa?=
 =?utf-8?B?bCtjY2JDVVJ0ZVU2WnJvZ3A2NFhyM0lIZnpQakVVdkx4cXN0QmNxNDVsanJv?=
 =?utf-8?B?NE1zbnZLNjE2S2lvM0RKa3ZVNWI0ZkFNR2ZieVVNTHdrK0NaTFhMeDRRczRy?=
 =?utf-8?B?Qmw4L1FFYklIRnpTa1didzgycWZMSm9GMVl3M2lnSitTSHdNODUvY2hwMkhz?=
 =?utf-8?B?Y2Z4OUtWb0lib2V2aEtBR2Z5MG9tZDQ0WVNGdHp2QjZkWFVHZmV4QldpSGF1?=
 =?utf-8?B?T2dlaC9PZWJTVW4zVWlzNUkrdEJCL1RQMnkrYmZ5YUlWcTRSWmJNbnBCZkVM?=
 =?utf-8?B?UGh2KzMxT0M2ekNNblY0WjArUEhyZE85bk1QNW11YTlhSFJPRU9YVVdmbldK?=
 =?utf-8?B?T3o1MUdrV3dDcUxQbHVNWXJsZTdlZjZ6cjVxeG1Ram0yT28zWEpmdGFrRFJM?=
 =?utf-8?B?VmtnTXd5VnN4TENDRW5LT0tUMHF0c3NMd25wd1BNMng2NXc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a90ce2e-bf43-4369-133a-08ded376b043
X-MS-Exchange-CrossTenant-AuthSource: SN7PR19MB6736.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 11:33:05.5321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB5004
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_MUA_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:konrad.dybcio@oss.qualcomm.com,m:axboe@kernel.dk,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:saravanak@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mathieu.poirier@linaro.org,m:p.zabel@pengutronix.de,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-remoteproc@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[george.moussalem@outlook.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.dk,kernel.org,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,pengutronix.de];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38171-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[george.moussalem@outlook.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,outlook.com:dkim,outlook.com:email,outlook.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,SN7PR19MB6736.namprd19.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B70C26CC8D7

On 6/26/26 15:20, Konrad Dybcio wrote:
> On 6/25/26 4:10 PM, George Moussalem via B4 Relay wrote:
>> From: George Moussalem <george.moussalem@outlook.com>
>>
>> Add support to bring up the M0 core of the bluetooth subsystem found in
>> the IPQ5018 SoC.
>>
>> The signed firmware loaded is authenticated by TrustZone. If successful,
>> the M0 core boots the firmware and the peripheral is taken out of reset
>> using a Secure Channel Manager call to TrustZone.
>>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>> ---
> 
> Can this not fit inside the existing PAS driver?

I've tried but there were two issues with that:

1. a custom way to load the firmware into memory is required because the
loadable segment needs to be offset by the virtual address in the mbn
file (see 0x20250 below). The standard mdt_loader uses the physical
addresses.

readelf -l bt_fw_patch.mbn

Elf file type is EXEC (Executable file)
Entry point 0x20255
There are 3 program headers, starting at offset 52

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  NULL           0x000000 0x00000000 0x00000000 0x00094 0x00000     0
  NULL           0x001000 0x0001a000 0x0001a000 0x00088 0x01000     0x1000
  LOAD           0x002000 0x00020250 0x00000000 0x06154 0x190f8 RWE 0x4

2. memory needs to be ioremapped using ioremap, not ioremap_wc, else TZ
will complain and throw XPU violations due to strict memory alignment
and non-cache requirements.

> 
> Konrad

Cheers,
George

