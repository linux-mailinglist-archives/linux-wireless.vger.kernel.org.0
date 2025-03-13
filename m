Return-Path: <linux-wireless+bounces-20320-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F83A5F4C0
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 13:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B53F3BD6BA
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 12:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9208022F150;
	Thu, 13 Mar 2025 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="II/l6ZjY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010015.outbound.protection.outlook.com [52.103.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A786678F59;
	Thu, 13 Mar 2025 12:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869814; cv=fail; b=jZI9IlpfiFiGSkki6e5DGDzbaQq/LdMCc/d18actY6zXYYFVhVvvLnPEELjdN6qDhFS/6LMXmfUNnavQIgqJa+VXhYH+skzDmWz/bHJaMAsfveTIYg4hsaZUq3mXjsyIWsuX5n/hJJAkW2coboimcIbsHj3jT/z7j8PLw4gLK9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869814; c=relaxed/simple;
	bh=k/EzvccMUrfnPOUAxGK9vSw/JL+bmfUx5Bzi24ZVz5w=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=txwruT6WLfVTOtqR1/Afsi/DV4fTOhwgT7V2IPPWq71vR2FmCrduxq7BmAsQcM8ze5o6qziLW7rBQArhw0CDsVkPLULdtPTjK98aTexiKkXGPBp+VMx2RczcnUdC4Jg/fps64kzXrQkXqcL5rlK1oG5xcI36WYrkvxoKtfUZJ2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=II/l6ZjY; arc=fail smtp.client-ip=52.103.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCscEv4nvjY1aeMl+nwaBJBAholIi/p0MoJlqsPgjwH8hGunNKvAE8BLl8nUMnhiQtdavciVuuUYRKOIrtD4a8JhsYpANzk6LeF233pqB4KEB5i3Gtkdt+QK9iXcbrqBC4X/h1vmKoV0RX85YQYWAM3TAtI+FfchTy5Eh1vGQmUzHyljUegwRtVUXRVd5ICpVRXrg2pfyg4tGEqBHfgxgcmq2IIFukLpDcRkZiDZ33RHDBxuP04aKFYQYWAjD3IUN/fHB18ysvuWUcRM6NR3QDgZLpGz5C33ktp8iOY3QyzA8p6AeiyMVFpFlBqjCxXCu4Thkd1Wv1loW7Wu+4Y7Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/EzvccMUrfnPOUAxGK9vSw/JL+bmfUx5Bzi24ZVz5w=;
 b=O0WRE8qd2iNV2e86DrVs9gbYU4zE3w/AgaM96Pkwl38vgQBZ/QGP5SmhiweeEe8xdbIj5ApcRs1Yz1UsX+iDroOBDYxazIWrFPeP3zzfaUKNrJZdOkVxCpU9/evK4rH4XLszXpjQ4fP01iQPcBhN4LwhdPrA1729jp5fsKQ5vT3OJzj39BX7EIYCx7nvuehh0KTUX0eyT4SvBnR4d2r7x9sAc/6Sc9PCUY6MEKtTwa5q2VOuEX1Ypj8ZLYaKFctHf4LGoq+VGMRtJNq8jdjqsid9Q+vA9rN9ckiugVK6O+eYEcCpo4DEpOXTe4cHOMXXNlbWzU+Dw8ggAvIO1XJQuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/EzvccMUrfnPOUAxGK9vSw/JL+bmfUx5Bzi24ZVz5w=;
 b=II/l6ZjY4xF8+vOaF/gRZ1iKCFejR6VAx4sMu26To9yJNsUZk2WtI3inW8TsWCj3avvBdyFupFxrnm0Omu8VoXrL8ByrKRQweZzWK1a0jEqKWyw2CQ4gYWoo3UL95YvsNE6TGGlZZFdIf2D31rfvKiTq1ka5R2u/pap9RiWGJhaMOn+hwVapvN7MdLmwceAbOUdGervCs5FVwi7A5T4CDc49U45gCa2V8FTX3De1dqf/RmzXMvMyI9fzMZ7cWk+9wj8zVbdHxshHkiQq1kx3z8Jq5cJe5uqgH4KlcG5bU/c8yXRjZ6qSNsGK4ARlBK0Ux3ebT5JzFAgcR3l51GzUiw==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by TYCPR01MB11801.jpnprd01.prod.outlook.com (2603:1096:400:3b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 12:43:27 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 12:43:27 +0000
Message-ID:
 <TYCPR01MB843770121E6576BB3807CD0A98D32@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Date: Thu, 13 Mar 2025 20:43:18 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>,
 Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: Re: [PATCH v1] mt76: mt7915: wed: find rx token by physical address
To: Felix Fietkau <nbd@nbd.name>, Ping-Ke Shih <pkshih@realtek.com>,
 "lorenzo@kernel.org" <lorenzo@kernel.org>,
 "ryder.lee@mediatek.com" <ryder.lee@mediatek.com>,
 "shayne.chen@mediatek.com" <shayne.chen@mediatek.com>,
 "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
References: <TYCPR01MB8437EE1595CD4AB581C006E898C62@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <TYCPR01MB843726907C170CFE2D3EB7BE98D12@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <e144d2ffe9924d81a7b60f38cdcf516a@realtek.com>
 <1c46870f-965b-4f70-a01b-adbcd60c2876@nbd.name>
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <1c46870f-965b-4f70-a01b-adbcd60c2876@nbd.name>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------GqJBLmVZnPD73PsbIAydY2b0"
X-ClientProxiedBy: TYCPR01CA0022.jpnprd01.prod.outlook.com (2603:1096:405::34)
 To TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID:
 <373aee72-8048-4939-9068-b58a129e9c88@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|TYCPR01MB11801:EE_
X-MS-Office365-Filtering-Correlation-Id: adde36a3-7371-4a09-4d12-08dd622ca6be
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|15080799006|8060799006|12121999004|5072599009|461199028|7092599003|6092099012|1602099012|13041999003|20055399003|440099028|4302099013|3412199025|41001999003|19111999003|14041999003|26115399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEZVYjNzOU93NXkyYVBNaEd5aloxWWVEZTYvSU4wSWlTVzM3STg0SWJHb1hi?=
 =?utf-8?B?N0xxN29tbnVXMDVnOStsdVNGM3J3eXpDMU5tY1NGZkxqS0IrME43cEhGY2RF?=
 =?utf-8?B?c0Y4YjZ0elpVaDJHTjZlSkxaVWNzWGlzOVVoUkNuYjJLYVpCR2JRMXlrMXlu?=
 =?utf-8?B?UmhMWnZKTXRMazBucW1uYk9KRno5SjhyczRPbmFMYUI3VThLTGRoNFZUemhI?=
 =?utf-8?B?MTRtVWZ5VmtwcUsrdVNOT3ROZmorTDEvQnJKR3dhZmhKUE8wUWVhNWhpMHFx?=
 =?utf-8?B?S295NTAxYy90bDR1RGhmMUErSjcwc2FMaUVvMWdxN3lmQWJwbldEVThYUHZZ?=
 =?utf-8?B?M0l6V2laT21qN205UmI2SVo0aGlrRWtYbUxpNmFjS05ERnZCZnZMbE1RNWJB?=
 =?utf-8?B?RnZlb2tKU1pwdzZRNEFHdkxRT05STVp1WVRzTVZaZ1hRUzhrU25KUlAxRW82?=
 =?utf-8?B?M3NucTVnYWZKQ3NFQUNXT1dyK0NMMSsxNmJKdHp6WkFMWSthV05PL1NWdnh0?=
 =?utf-8?B?K0grakNkY2FmYk15cWtPdyt2TlBrYzNkM2Q0aGlxSmQ4THBoUzdqUHEzaVBB?=
 =?utf-8?B?aFR2WmI5cDhLTWdHb24xanZNcFBqc2Z1UVdxUnNsQkZlQ0xhWTdhNGJ6Sk1Z?=
 =?utf-8?B?bnBDVVc4Q1VEOWJlN3JTRVhOYVJyYXlyTVBXRjZTYU9sQ1pHeG5oQkQra3hl?=
 =?utf-8?B?KzBlMHVtK2xWbFpFWWZwQlJzZ2Q1RWc3NTZhMjlFTUI1dXVybGwzVkNxRUhX?=
 =?utf-8?B?VENMZGkyZkEyWnhnKzNLdkIzbFAraU0vUnZaRUwrNjVCbnlya3JaZjJOZTJt?=
 =?utf-8?B?NUY4REFWcjhxemlKR2dFR2pocTI3Z1UvN3dJNjBhN21vQm5xUnE1QzNUNS9v?=
 =?utf-8?B?ZjBXdk51d3dkVEFsb1U2UFVKOWlCRlF0YlJTMmtvRk1ySkhyRXo1TXVYdUNZ?=
 =?utf-8?B?NjRKdHNaamRLUHJrOGdxZFVXU2UyUFh5OVdKK2Q0dVBRSFdvenNqMzRzRmhN?=
 =?utf-8?B?cUk4MzBaMmRPWmlDVnBrMk05aUhzVEhYN1ZnYW9KTm5GRmlMZ2NlTFRBV0c5?=
 =?utf-8?B?dEFEZDJtQWlNcExobWFBU0Y0cVBHTE83WnV4dHF2aVJrM3E0UERxVmhVSlFw?=
 =?utf-8?B?aXZsZWZFTzNkNkZ0UlJSMUdxSDdPSXpCeXJuRkxuTEtCSzQyNHo4UDVpaEN5?=
 =?utf-8?B?bTM5ekN6bEZrbWdxcm1zd3VEQjd0dW9ScUFSRnliNm1qczhmMk5aTlhuVlVJ?=
 =?utf-8?B?d2pYeXRCbFE0d2dWL3dDSXlEVXRrSHJOdE9RT2lOSWNDcUFTaUFSUjJVTmRQ?=
 =?utf-8?B?NnluU2sxSzJUWWxqb0phcWF4OElaMW9kUWdRUGJkUldQZ1EyMFF1cndRcSti?=
 =?utf-8?B?Vi9jWENVNGRWT3lqSzFKR0FDNytETU5uTENKWFdNZ010T1RiSEdWNFRhcFBK?=
 =?utf-8?B?OXNsR2dXN2hJclpQVlRaK0c0UHhjWkJlOEp2MmtHbnBWZzMreFVIUktORVdp?=
 =?utf-8?B?eEtzTjJab2RrR20veDJ1bFFvekZGb2dlcnJpMU5YUkRKZC94dVRJVU1pU0Fw?=
 =?utf-8?B?emRMSGZXMVVJTUY3b051elhpYUFVbXJKdWFROVA0d0tIRkRxZDIzb0paVCtC?=
 =?utf-8?B?QUpjdTZzV0xFZVZWem1DYUhBbGMydGRTQ1VDOWM4bFRZQUhndHp5ZkVyNG5M?=
 =?utf-8?B?SGZEdUdjVnAvYjFkaTlsMFhrM1d1dHZ4a1NhZHFYNldHdXlPUWJLUTRacGJV?=
 =?utf-8?B?NTA0cUM1TVJ2SGxQUzY3dElndHEyZDcwVzdraG0vaXR5Tm55UWNQalRnNkJR?=
 =?utf-8?B?eUVDWE54WVFTalFGTkdNMTZvc0ZUZytoc1k3VjdacG43b25veHd3N0F1OHU3?=
 =?utf-8?B?RThmRU9KWnl3UlhQWDRHZ2lubkliRFhhaXVVR0ZBa283RmxwVUNhMTN2cFdJ?=
 =?utf-8?Q?98zj9pjsaVoDSBjppO8qyHrs4C3Mrl77?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEEycEJwaTU1SnlibmdjSnoyczkwU0dJWElCdTRsUXcvWUNzdG1KcHNkamhr?=
 =?utf-8?B?bXpaUU5jSjEyZGRsTHhhQy9EazQ4cFRtY3RianlTNDBlKzdKZk5VRGE4dWdx?=
 =?utf-8?B?UkQ0V0FWOVRxNWFZMFdqOVdKTUZ6YlRtWk1KZWVuQUorZVBNNis4WWF3bStt?=
 =?utf-8?B?VFh6aElNYjhNMjFzZ2xkbllWSHVwQWtSZzFiaGxER1h6a09hdGhoclFQSzR1?=
 =?utf-8?B?YVdFb2IrU0lsUE1WNk51OWtFZVJ5ZlB5RGxoUTVkYzI1ZDFMYmRPR29DUGVn?=
 =?utf-8?B?WnFrdXhhSmw5Mnl2bXdkNTZkWjBSQ24rUE5ialo4b1h0bEdveko2dCtzWnRq?=
 =?utf-8?B?Mi9hNFpjY1puNzVIQk16N0RrbnlLOWJoU3U1blZKbmxkSVZNbnZEOUw3Ym1E?=
 =?utf-8?B?czZRWmkyNXBYUU1QUUQ4VW1Icm1VelFrcjRKc1o0WU54ZWE4R3dZNHNYbUJV?=
 =?utf-8?B?R1hwMjBiS3VhV2R1d3FSWktJMHJDWS94QmI1djBiMmxFUmxxcmI1b3RKUVFU?=
 =?utf-8?B?dDdIMDI3ZFpBM3NFUGdXaW1iV2ZwZ01pRjBPRDRyR1lVcEszUWhPWkk0VVhr?=
 =?utf-8?B?S0hqQVlLK093RW9Ccmxoa1RRMThxdE9Lbjh4djNjSGhSRXE2bVhvazBwblZq?=
 =?utf-8?B?NDJCNU4yTEwvOGZJdmhUMXdsL1JJMHpkeXVCSmNtZTAwNmsvRWt2QTV4Ny84?=
 =?utf-8?B?bVZaM0NrSG1UWEV4T3JLQTl5dVV3a3BSQzY5eWp3M24zcjZlbSs1N2tNUGlp?=
 =?utf-8?B?RVBwWVJFQkYrZVcweGlIOEVMcUROOG8vWTJ4UjF6dU5QalVVYUZhZE1JVFMy?=
 =?utf-8?B?Wll1OEVNdkRPVzQwYlZqUW5PNzhoVExheUt2ODcxMTUzTGFYSG1DRElWWUxT?=
 =?utf-8?B?WVE0RFpzS0szM1M4OTNwcmVLWllMOG9iVS9TZVVuT043Tm93dy9VenMrOExy?=
 =?utf-8?B?Nmcvb0ZkaytIZ1dHaXJiNjFUUnB2RFBWMG02eE8yT0R5UkoxSC9CdG9WMU9N?=
 =?utf-8?B?U3ptZDAvbjhubTh3QXViaHBLSkxWcXBrdnN6Mk9RSURGWkNkcFY1N2N2Zits?=
 =?utf-8?B?MlVLMzYzc2hHZU41Ky9yQ0oxQURaQlc0RmI1OC9EcUJUYnhXUTdwNXMrUEQy?=
 =?utf-8?B?dVVvZ25QdUNEUVAvZGVXZVFxMUxBc0Vmczg2SUpsbDVrNWJPbmMwUjhlM1Rq?=
 =?utf-8?B?aHQza2NFVlNWbGRvZ1dUNlFFN0hSckJpcFM1ajRJS0JZUFBqWnY2eWorWjRk?=
 =?utf-8?B?Z2drU0d1VU1sQlRZTVNWVTFPWnB2SWZGMDNCU1pFODNuMzM1TzFOVGQxS1Z4?=
 =?utf-8?B?VlVPZlJVUjMrZmI0OGpPZkNSSHdOeDBsV0VPaitCaENlTHQ1Q29rTUE5bnhv?=
 =?utf-8?B?Z0NXU1BGQVZhWmNIZTc2Y1dWRjZmSm11RjFoaUw3SUJCQXJRZzNIZWZSMENM?=
 =?utf-8?B?MUtPQk9keXBVV1JYYVY0RFEzaHBZZmFFaWdBNWNDNzBqSHJvdW95bklRZHJC?=
 =?utf-8?B?U2M3a3R5S1FFTlo3WHVoeTE1OUtiRnY1ODc3dE16WTYzR05xd3hVYjdrWTla?=
 =?utf-8?B?TzMyTStVV2U4ckY2R2xOUzBkZHVVZUV1ZU9tcC9UL1lTbFp0bC9UOERCMk5V?=
 =?utf-8?B?WGdQTklNQUE4cCsrWm96UWo3V3laT2Z2MnFQdWdQbmNhUklRN1VQL21HRERT?=
 =?utf-8?B?TVFQb2NUR1l0dUdDL1Z0UDFFY1hyYmNYRkFNRTlSNmdiTXd4dVV0RnFkcm9B?=
 =?utf-8?Q?hyXwQ9J+L2vNHbJfVQ=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adde36a3-7371-4a09-4d12-08dd622ca6be
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 12:43:27.4952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11801

--------------GqJBLmVZnPD73PsbIAydY2b0
Content-Type: multipart/mixed; boundary="------------6ff3x4jWv0HFVki0OZQewF3J";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Felix Fietkau <nbd@nbd.name>, Ping-Ke Shih <pkshih@realtek.com>,
 "lorenzo@kernel.org" <lorenzo@kernel.org>,
 "ryder.lee@mediatek.com" <ryder.lee@mediatek.com>,
 "shayne.chen@mediatek.com" <shayne.chen@mediatek.com>,
 "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Cc: wiagn233@outlook.com,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>,
 Peter Chiu <chui-hao.chiu@mediatek.com>
Message-ID: <373aee72-8048-4939-9068-b58a129e9c88@outlook.com>
Subject: Re: [PATCH v1] mt76: mt7915: wed: find rx token by physical address
References: <TYCPR01MB8437EE1595CD4AB581C006E898C62@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <TYCPR01MB843726907C170CFE2D3EB7BE98D12@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <e144d2ffe9924d81a7b60f38cdcf516a@realtek.com>
 <1c46870f-965b-4f70-a01b-adbcd60c2876@nbd.name>
In-Reply-To: <1c46870f-965b-4f70-a01b-adbcd60c2876@nbd.name>

--------------6ff3x4jWv0HFVki0OZQewF3J
Content-Type: multipart/mixed; boundary="------------WmQdo21PcUsK1GqptCekqX57"

--------------WmQdo21PcUsK1GqptCekqX57
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgRmVsaXgsDQoNCkknbSBub3Qgc3VyZSBhYm91dCB0aGUgdG9rZW4gSUQgaW5jb3JyZWN0
IGZyZXF1ZW5jeSwgdGhpcyBpcyBqdXN0IGEgcG9ydA0Kb2YgZG93bnN0cmVhbSBwYXRjaCwg
c29ycnkuDQoNCkJlc3QgcmVnYXJkcywNClNoZW5neXUNCg0K5ZyoIDIwMjUvMy8xMiAxNzow
OSwgRmVsaXggRmlldGthdSDlhpnpgZM6DQo+IE9uIDEyLjAzLjI1IDAyOjQxLCBQaW5nLUtl
IFNoaWggd3JvdGU6DQo+PiBTaGVuZ3l1IFF1IDx3aWFnbjIzM0BvdXRsb29rLmNvbT4gd3Jv
dGU6DQo+Pj4NCj4+PiBIaSBTaGloLA0KPj4+DQo+Pj4gQ2FuIHlvdSBhbHNvIGdpdmUgdGhp
cyBwYXRjaCBhIHJldmlldz8gU2VlbXMgSSBhbHNvIG5lZWQgdG8gY29udmVydCB0bw0KPj4+
IHJldmVyc2UgWG1hcyB0cmVlIG9yZGVyIGZvciB0aGlzIHBhdGNoLCB3aWxsIGRvIGl0IGlu
IG5leHQgdmVyc2lvbi4NCj4+DQo+PiBZZXMuIFBsZWFzZSBkbyBpdC4NCj4+DQo+Pj4NCj4+
PiBCZXN0IHJlZ2FyZHMsDQo+Pj4gU2hlbmd5dQ0KPj4+DQo+Pj4g5ZyoIDIwMjUvMi8yMiAx
OTozOCwgU2hlbmd5dSBRdSDlhpnpgZM6DQo+Pj4gPiBUaGUgdG9rZW4gaWQgaW4gUnhETUFE
IG1heSBiZSBpbmNvcnJlY3Qgd2hlbiBpdCBpcyBub3QgdGhlIGxhc3QgZnJhbWUNCj4+PiA+
IGR1ZSB0byBXRUQgSFcgYnVnLiBMb29rdXAgY29ycmVjdCB0b2tlbiBpZCBieSBwaHlzaWNh
bCBhZGRyZXNzIGluIA0KPj4+IHNkcDAuDQo+Pj4gPg0KPj4+ID4gRG93bnN0cmVhbSBwYXRj
aCBsaW5rOg0KPj4+IGh0dHBzOi8vZ2l0MDEubWVkaWF0ZWsuY29tL3BsdWdpbnMvZ2l0aWxl
cy9vcGVud3J0L2ZlZWRzL210ay1vcGVud3J0LSANCj4+PiBmZWVkcy8rLzczNzM0MDMyMmFi
MjJiMTM4ZmQyMDBlMDINCj4+PiAwZDYxZmZkYmUzZTM2YTkvYXV0b2J1aWxkL2F1dG9idWls
ZF81LjRfbWFjODAyMTFfcmVsZWFzZS8gDQo+Pj4gbXQ3OTg4X3dpZmk3X21hYzgwMjExX21s
by9wYWNrYWdlL2tlcm5lbC9tdDc2DQo+Pj4gL3BhdGNoZXMvMDA2Mi1tdGstd2lmaS1tdDc2
LW10NzkxNS13ZWQtZmluZC1yeC10b2tlbi1ieS1waHlzaWNhbC1hLnBhdGNoDQo+Pj4gPg0K
Pj4+ID4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgQ2hpdSA8Y2h1aS1oYW8uY2hpdUBtZWRpYXRl
ay5jb20+DQo+Pj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGVuZ3l1IFF1IDx3aWFnbjIzM0BvdXRs
b29rLmNvbT4NCj4+PiA+IC0tLQ0KPj4+ID7CoMKgIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvZG1hLmMgfCAyNSArKysrKysrKysrKysrKysrKysrIA0KPj4+ICsrKyst
DQo+Pj4gPsKgwqAgMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4+PiA+DQo+Pj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9kbWEuYyBiL2RyaXZlcnMvIA0KPj4+IG5ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L2RtYS5jDQo+Pj4gPiBpbmRleCA4NDRhZjE2ZWU1NTEuLjViZjYzMDE0MjYz
YyAxMDA2NDQNCj4+PiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvZG1hLmMNCj4+PiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvZG1hLmMNCj4+PiA+IEBAIC00NDQsOSArNDQ0LDMyIEBAIG10NzZfZG1hX2dldF9idWYo
c3RydWN0IG10NzZfZGV2ICpkZXYsIHN0cnVjdCANCj4+PiBtdDc2X3F1ZXVlICpxLCBpbnQg
aWR4LA0KPj4+ID7CoMKgwqDCoMKgwqAgbXQ3Nl9kbWFfc2hvdWxkX2Ryb3BfYnVmKGRyb3As
IGN0cmwsIGJ1ZjEsIGRlc2NfaW5mbyk7DQo+Pj4gPg0KPj4+ID7CoMKgwqDCoMKgwqAgaWYg
KG10NzZfcXVldWVfaXNfd2VkX3J4KHEpKSB7DQo+Pj4gPiArwqDCoMKgwqDCoMKgwqAgdTMy
IGlkLCBmaW5kID0gMDsNCj4+PiA+wqDCoMKgwqDCoMKgwqDCoMKgwqAgdTMyIHRva2VuID0g
RklFTERfR0VUKE1UX0RNQV9DVExfVE9LRU4sIGJ1ZjEpOw0KPj4+ID4gLcKgwqDCoMKgwqDC
oMKgIHN0cnVjdCBtdDc2X3R4d2lfY2FjaGUgKnQgPSBtdDc2X3J4X3Rva2VuX3JlbGVhc2Uo
ZGV2LCANCj4+PiB0b2tlbik7DQo+Pj4gPiArwqDCoMKgwqDCoMKgwqAgc3RydWN0IG10NzZf
dHh3aV9jYWNoZSAqdDsNCj4+PiA+ICsNCj4+PiA+ICvCoMKgwqDCoMKgwqDCoCBpZiAoKm1v
cmUpIHsNCj4+DQo+PiBCZWNhdXNlIG9mIHNjb3BlLCBzaG91bGQgZGVmaW5lICdmaW5kJyAo
b3IgJ2ZvdW5kJz8pIGFzIGJvb2wgaGVyZS4NCj4+DQo+Pj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBzcGluX2xvY2tfYmgoJmRldi0+cnhfdG9rZW5fbG9jayk7DQo+Pj4gPiArDQo+
Pj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZHJfZm9yX2VhY2hfZW50cnkoJmRldi0+
cnhfdG9rZW4sIHQsIGlkKSB7DQo+Pg0KPj4gaWRyX2ZpbmQoKSBjYW4gb25seSBnZXQgYSBw
b2ludGVyIGFzc29jaWF0ZWQgd2l0aCB0aGUgSUQuIE5vdCBzdXJlIGlmIA0KPj4gaXQgY2Fu
DQo+PiBoYXZlIGEgcmV2ZXJzZSB3YXkgLS0gZ2V0IElEIGZyb20gcG9pbnRlci4gV2l0aCBz
ZXF1ZW50aWFsIHNlYXJjaCBpbiANCj4+IGRhdGEgcGF0aCwNCj4+IGNvc3QgaXMgaGlnaGVy
Lg0KPj4NCj4+IE1heWJlIHlvdSBjYW4gY29uc2lkZXIgdG8gYnVpbGQgYXNzb2NpYXRpb24g
YmV0d2VlbiBhcmd1bWVudCAnaWR4JyBhbmQNCj4+IHBvaW50ZXIvdG9rZW4gYnkgYW5vdGhl
ciBwYXRjaC4NCj4+DQo+PiBCdXQgbG9naWMgaXMgb2theSB0byBtZS4NCj4gDQo+IEFkZGlu
ZyB0byB0aGF0LCBpdCBtYXR0ZXJzIGhvdyBmcmVxdWVudGx5IHRoZSB0b2tlbiBJRCBpcyBp
bmNvcnJlY3QuIElmIA0KPiB0aGUgdG9rZW4gSUQgaXMgY29ycmVjdCBtb3N0IG9mIHRoZSB0
aW1lLCB0aGVuIGl0J3Mgd29ydGggb3B0aW1pemluZyBmb3IgDQo+IHRoYXQgYXMgdGhlIGRl
ZmF1bHQgY2FzZS4gSW4gdGhhdCBjYXNlIHlvdSBzaG91bGQgYXZvaWQgdGhlIGV4dHJhIGlk
ciANCj4gc2NhbiBpZiB0aGUgcG9pbnRlciBmb3IgdGhlIHByb3ZpZGVkIHRva2VuIGlkIGFs
cmVhZHkgbWF0Y2hlcy4NCj4gDQo+IC0gRmVsaXgNCg0K
--------------WmQdo21PcUsK1GqptCekqX57
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------WmQdo21PcUsK1GqptCekqX57--

--------------6ff3x4jWv0HFVki0OZQewF3J--

--------------GqJBLmVZnPD73PsbIAydY2b0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmfS0uYFAwAAAAAACgkQX75KBAfJsRmJ
CA/+P3JJJx3xx9Xx+oy2GYn6dFp0W/5/cknka7Mo+djYoL2pCcF0AQ34I9RNZKPw6x6eG0OGSP8o
3VSsr0loUgtQn4+9DVMlESw3f/Pdu+fwLfDtcRWbgQVTUdetJ1h+b77n7mra7xSCEs/YqOyGabPG
YID09ppO6bAEQs7475L5Er1zbrws/GNfgsnNov3k7yIl7oQEqoN9rzNIBWkw/JNMIoJmdr3TFsxJ
HHHRdCWNw70edbw/bJ8G0/HIcr5YXUuY4YDr6Ca1Jd949/6HmLw/n8mHm/hHFG1cWtLDcukt8pJg
cWrIwO0Y34y68p8Z0cOmerUdxm66//CBB5cRrzcwdsi4izwMTl7AioAfVddufD+nka0X2D8gB17Q
+C7aj2ywE3q0ckxRsX3NTjRBidvp8xT4IkGHA18/SmMKBLFdai3+/gVdTnwV8eQlN2wepFH60lC8
MHYDa1Zzm1HaALHp7MoD8xcdbj6RI6mb+A6DTrOJzlPXceyNDGoFvg9uuKUtLQIfcbUMLGKqpOkK
zxrGBjWyq9kElxOTi3+MK6JmnDd/17MjWhfsZzHQPIvQMGmCuGtHJz8Y7e+SrP6wIw/RsJesZajf
pVdCsyFs/W1Fx4YEM9q+FMtds8FscQBBfdPkSXWsWUg0QWWKxMkGXMzULIrgELlsPlLQNkG1NFcl
ag4=
=DfJ5
-----END PGP SIGNATURE-----

--------------GqJBLmVZnPD73PsbIAydY2b0--

