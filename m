Return-Path: <linux-wireless+bounces-19936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889ABA5546B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 19:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82DA33B9A76
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 18:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1262755E9;
	Thu,  6 Mar 2025 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uWkdgODw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011027.outbound.protection.outlook.com [52.103.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E5F271801;
	Thu,  6 Mar 2025 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284475; cv=fail; b=J37rb/Cn53/j7eImajkMFVicvclNfisVGInqYrgJp+DpAxTKirsqKygehlDKzjj/DNBwa3d3G2QTGVcls43fkhe/eVQtK9X/WTbJYZ/vSF34mlXwnXCfoR6i8n+r7B97f8KYQpxEck30cp+bmqWq1zsDIVnClHwo210ZylYUq9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284475; c=relaxed/simple;
	bh=/h0Td7jPsAC/h41dicnpAn4dI0u05+6wDHvhyPqqejU=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YBuX1GuJ7Gvta+KZuiafpa1x+afvNmAxl+4f+7Tue2FoL9aDMAo7Jc1atTFmMaEdem+5kvkyNKhq9JHCmM7FbpjngG6GxrchNTuhugkGrCw3B1V5t2byllNvDmbhDyD8P0SfxQmOWt/w7ynldwvUV8EX69m/GlPb4tuMU+qQi0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uWkdgODw; arc=fail smtp.client-ip=52.103.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rw53tP1DpZpwRsZIkBuJQYO7CIhOHxz95Tx7twRsdR1DSuF/azafCH2Wo1hq2vrfFw30L6Paa20xyVcJot9ZuWzIQfyb9zw/LTCcd4mE6pIN423Itb1S5Kuso1NJhjJXJm5bFC1qZrjBWdV8Nlu5Z8RZqmRJksCuf8rJOgyKJERsWeFPT1z+MWD735A3jorEQ3Qk+OCn0CPF793bTgeGwRYSQ6q71UpKr/QJiY3SHrpoqcciVSAf+nQYM//UP8BkmNHvRleQktJYO6yVgPZf7C0Bw4JpvSwM4Wr/rCucQZgTfYXelko1fRAmlOtJlQ21EqJbHJbxGAvGX3BrauJkLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/h0Td7jPsAC/h41dicnpAn4dI0u05+6wDHvhyPqqejU=;
 b=KFq9ePX73LGLFAC2cSDsNBGi9vmFBVmpxj04/Ksm14uH3ix8nrcG9DfTZ9oqHDU7Fng0HQqrgWWQfVhv9S2t28trgD38WF7KOs9kambD7RrgN9hP5UNCXv4J7i+LLdg5JnXQ3/wuLOvvLIjM7bMb//UCj0NIjxP6esE5ohsw9oR2o8WYX3sb3y5ELD0Bhia/Pt5/dORvzDeK4ClGnwIzIhYa/9URZS8A4M7oE5XFQUIQK6spRiVR4AxVyXqD166c7uliE7KBr29KVHPq/e8Giasdp+mo3J3IjlPrQmEgmFbs3ZTY90h0E7iokD4XSk/dQDTCOu1HMrReaMHwh2GMGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/h0Td7jPsAC/h41dicnpAn4dI0u05+6wDHvhyPqqejU=;
 b=uWkdgODwTkjPTdeSJsYPk5XJ+BsVWvLYoVpwPXICGUG9Ez+CwFf5+evKmW50KAuUSRF9xBmW8ayMBVe7Y8pxqynNzgoGAI5S5Bx7nBVnKe7TjNErnMrKVDV7PDrcoRn67guK3pIlqWrj3s0W6ev+Kf0t8jFPvqNTUT0ifTA/xeexWthmag8IapFKFxrZm14eyQIUt2dhjP5dqAlKL/ooJi9IOMDrELNBlVVohsgLQ3s8q8ZEygtaYihENip0doDmBDJl80M7wpGz7Ptmth3g8UhDhl/Afhw30Ux12pnBmBExG0Y2akXZ8ssiIjx8i+36LPRJ7rjgQzDqyE6VypzZIQ==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by TYBPR01MB5486.jpnprd01.prod.outlook.com (2603:1096:404:802d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 18:07:47 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%6]) with mapi id 15.20.8511.019; Thu, 6 Mar 2025
 18:07:47 +0000
Message-ID:
 <TYCPR01MB8437874842FE7A17EB4D856598CA2@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Date: Fri, 7 Mar 2025 02:07:42 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com
Subject: Re: [PATCH v8] wifi: mt76: mt7915: add wds support when wed is
 enabled
To: Ping-Ke Shih <pkshih@realtek.com>, "nbd@nbd.name" <nbd@nbd.name>,
 "lorenzo@kernel.org" <lorenzo@kernel.org>,
 "ryder.lee@mediatek.com" <ryder.lee@mediatek.com>,
 "shayne.chen@mediatek.com" <shayne.chen@mediatek.com>,
 "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>,
 "miriam.rachel.korenblit@intel.com" <miriam.rachel.korenblit@intel.com>,
 "nicolas.cavallari@green-communications.fr"
 <nicolas.cavallari@green-communications.fr>,
 "howard-yh.hsu@mediatek.com" <howard-yh.hsu@mediatek.com>,
 "greearb@candelatech.com" <greearb@candelatech.com>,
 "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
 "benjamin-jw.lin@mediatek.com" <benjamin-jw.lin@mediatek.com>,
 "mingyen.hsieh@mediatek.com" <mingyen.hsieh@mediatek.com>,
 "quic_adisi@quicinc.com" <quic_adisi@quicinc.com>,
 "deren.wu@mediatek.com" <deren.wu@mediatek.com>,
 "chui-hao.chiu@mediatek.com" <chui-hao.chiu@mediatek.com>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "bo.jiao@mediatek.com" <bo.jiao@mediatek.com>,
 "sujuan.chen@mediatek.com" <sujuan.chen@mediatek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
References: <TYCPR01MB84374EEAC0DDDA4223B8997298CB2@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <c56c9714c754451a8255ece79353da2b@realtek.com>
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <c56c9714c754451a8255ece79353da2b@realtek.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------9qYJU8lDboO6nsSrxOzJe0kV"
X-ClientProxiedBy: TY2PR01CA0008.jpnprd01.prod.outlook.com
 (2603:1096:404:a::20) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID:
 <bf14111a-a6ed-442d-81e2-8c7dbc4b53fc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|TYBPR01MB5486:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b079bba-92c4-4e71-d540-08dd5cd9ccaa
X-MS-Exchange-SLBlob-MailProps:
	AZnQBsB9XmpI8tRyoOXaSUmOkLVCBKas/pxhz+WS5VA/YYZ/0F923bJtddRDFy1/WOOBpSnsyHLnmNWhYUMBqW43/WFHcM43oE/PTcWTq9LDPgpghqnb2JiuFBuOzEfkUpM+73RNEADj0Ug5iTemK2VmoRjggrCqGvV8tygkMm9cRjljMK0CeiO+BIfj9B4H+EeJOVTB0FcbFYpgcJ+5dm//uUEz2FrzzzUtRxt43JBjCEyKbvc2qTeBa+T2nflg2unMbRMvKvcR85kOiEOZgVg5uYeyIotyLm+0+6uBivLSeqvl6bgoyt8xFeZJUscLWQHTuq0ecCn18fvAhNq9NFMK4L9cvyTD/BwRmBVpCs1Ln1hG23b01LSQCZRAlAhYQaN5vyIxonMJdu6fxj1vy5ev5ohgAVSzo78rcWZMtr9c9HI1HtEZ3q2F1ZB3qqFJ/VP1WMervxCVuUmdTRIgcGyp8Rnzy7lbs+g8pEiez+Hek1OkbPJeL+UCkHXi39r2xONcikN9+tqS0tK+4vzp5WGi8Q/rd/qRFby0S2QNgGavkDtuR8sXnVGNHx1y9DOxEpscBMtycpPUxQ3BHWB6BNYcClvgG/I4o1f2eeCDk1zdeq5vp/8el6OPvpWLFKh5X6/cUA/kkGvXyfvvz+wGlO2qXJjpksPzFHx5JxCQ7xPAFU2QsnyEAOnIcnF5EPzEq9tygZgb8WXZzn3IS6apQpkFSzB+n/Tw4I/MpwkXYcE9jNeygPgbtKJio+Lh2IlPZ5LDW3BsSac=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999004|5072599009|19110799003|8060799006|461199028|7092599003|15080799006|6092099012|3412199025|13095399003|440099028|41001999003|26115399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkExR0pNdit3WnpvM3k4aEJYUnlSNjFNYmlURVJLa2xzWHk0VGRhVHRhRjJ1?=
 =?utf-8?B?bSswcGlwc0lwS1RhbnpqQnFmMmsxa2NnK3QrMGM0Y2pORldSQVJGRm05RlRN?=
 =?utf-8?B?bEVkazFrNjRsUDNGaUMzUHhlMmtURG5QTTNack9XQWFORHVaaytNakRsQ0hL?=
 =?utf-8?B?cjJhenQyQTNJODBjeksxVFRJeHZ1MjJLTUNlcU4ySWpoUEc0OEErRkx1MEdn?=
 =?utf-8?B?eG0zUWFwNkFVS3lLQkptVkJ0cytnTDQ3QmJIVVJqNnB4WjI1S3pvWE5wVE1M?=
 =?utf-8?B?S2ZXelJaMGJhQlVOUFZHMHNnTTBaTkd3STA2S0RYZ2hVRGxISEV4QndEUDV6?=
 =?utf-8?B?M0ltUWR6QVdXbE5NcDJVR21RdUZIcGExNll4VGJrT1gzWno4eitFYnNJZ2Jz?=
 =?utf-8?B?c1NxM2xtV3NjNVhSSVFRSW1KSmk5RTB2eERqb3orSHZNWnZ5RTg2SzdmbTBK?=
 =?utf-8?B?T1B5RHI1V2VabFA2SHVBUC82UGVNVHZ6dTVNZXc1S1ZFeHZjRWxZZDdkM29w?=
 =?utf-8?B?amRWK0RzaEE0WkpjNUowKzRSU1ZKNGhhZHhnai8xS2x0b0dEVVR2eEFUSGVs?=
 =?utf-8?B?Y1Zlb2dvT2ptdFpCZ0FJU3hjeHEzRCtOajBmdktrRHk2Q0ZXa0FUOXFpQUxi?=
 =?utf-8?B?NGtiQ3BUTDdBMmh1VElUWlZKbFlhS0NyTDREQ0FzWGdXdktuamVkZDN1M1kv?=
 =?utf-8?B?YkpQeHcxcVBwZG04UEJhUEF3Y216WnRPQ015TjBUL2dEZFBnTkxzWGpBSDk0?=
 =?utf-8?B?cWZDOVZqTzROa0xsREI5TGpDbEo3Um4xZU5KbERoMGZXT0lTZ1pZSEVvdTVj?=
 =?utf-8?B?NHIvVmlMaXVxem0rR09sWTg0N2UxSnN3RUFmS1JESXNVL1I1dFo4Yy9KMEFy?=
 =?utf-8?B?QlY4c0NBOFpOcW5lazhrU2czNVljcnVjWVE0bFVGa0g1QzNnQisxYnJxYXRX?=
 =?utf-8?B?NGZBMndaQ1NoK1YvcWpMSlV1MFVVVFp6NERNdlFnbWlDSTVxTVlHWkdTOGY3?=
 =?utf-8?B?R3dNL2cyd2xDU2ZaUHAxMEFrTzFKMFg5VlN4K04vUDgzaW1KakQ5SEtqQUJJ?=
 =?utf-8?B?anZOdXFxbU5MYWlyejVuN0FVT2dPcm01TWVFZTNwWkwyWTdlMjZha09NVSsy?=
 =?utf-8?B?bGpDQ2oxMjB3T0ZUUklrYi9RZ2YvZllLa0tHaDQ4K2ViYldDWFBLMlBBaWFa?=
 =?utf-8?B?anhJWnBHdjVUNzFCeDBsajJwdkx0UjhtcUE0MXg5cjJYWmxCMm5zYmRMZ3ZM?=
 =?utf-8?B?OEh2ako1THlaYjRBbXYxTDd1WkJxbGNYSllqY2I0cTEzUkpyQnYvN0EvOTlG?=
 =?utf-8?B?dURmVXlsU3ROWFJKNytCK2VLNEdrRlprZG9BLzhNTjNscTZISGo0UE1pczQr?=
 =?utf-8?B?ZU9kdkttZ0ZJc0crMHVSWkJxbjBOSTljK2JPN1c5a1IvVVkzaS9nSE9zQmpX?=
 =?utf-8?B?aXV3ZUQva0JwK0ZQVm9rbWU5M3JEZFk2a3BLeHJYNjFneUloTVFBYmh2VEdK?=
 =?utf-8?B?OVJYZ3ZSQi9VcmZsaXFJNEIzc2JYY2N4Mm53YVMxRWJXNHlZNFN2UUlGN2I3?=
 =?utf-8?B?OGZKM1FDNjYvV25vZmI3MitxWlZWK05nQ1pIS2k2cHpENXRaVG9RdlNjdWtn?=
 =?utf-8?B?T1ZnbUZlc3VaTEV4S0ViTFh0dGkyTGhBZXV2VlREYzYrS2o0Y3BFQURpZ3dK?=
 =?utf-8?B?MkNYRndKSGVPYVdoU2NWa0M2MDZYZnVHSmxOWjBGZlpobm94ZmR1Y3RnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlRMaURzeEg3R3RJdUtLQjlZMkQ1SlpjS041cHl6R3VvL3VzQXpQb1RoYUdt?=
 =?utf-8?B?dHdLeXZCQklzblRWT3hUSHpQY3hCazdmbUtoVU80aU83L0tKUEJuOUMyRG5M?=
 =?utf-8?B?YVdFckRJbjE3YVp1MGhUWHBvOVRxUW1HOTZiam5YZU9HTWtZMTFUZ0JmUUJa?=
 =?utf-8?B?Sk9nd2QrVUluZHVnWVdOUlZoZDZiMGt2L2p6VXVKcEU3dVIxWU5GNkk1dDZz?=
 =?utf-8?B?Z04vcXIxeWJWNUFjUXJmaEk4Z3J1ajBxMXU3bUk3MUM5aFViUUFiRzR1dEpN?=
 =?utf-8?B?dFhhajRCWXJPcnVuREZGUGsydFZ4OWpWV2sxakM3T0w2S1ZLVEVqRmpGUEEy?=
 =?utf-8?B?RnJHTlh2U282aVc5bEsyZjRBcXBwSnhxSDZDVS9hcks3aEFteWNuTHU1Vm5t?=
 =?utf-8?B?emJmRHdEbzJuMituY01PRERzUy9YUUJRNyszS1RVWTZpNS9BTUFublhPaE1N?=
 =?utf-8?B?ZWlISVVBanYrN1dxUjBuNmNGb3U0WTlreHZLU2QzbXBSTFdvV3FpZVA4QkNN?=
 =?utf-8?B?UWJkTFQwRUhqbWpHMGN6bFNXNXVoakFhK0RHRnN4UEZqb3dROGh6Q0Jwc09U?=
 =?utf-8?B?TlVlaVQwcThvd3FOSXpCRW5GMFhvMDJmb05pRmhjcnJ3UmdWV04yM0xqYS91?=
 =?utf-8?B?MTVScEdsdWNXQkpSOU9LRHBHVzRjVktNUVZBcjcyK1FqQ0hVUkxrZGg1UUZ4?=
 =?utf-8?B?MTdiR0FtYnp4NkNVSjFlajl2ZUNQMlRMR05nbWFEdm92ZE8zeWc1ME1nSC9a?=
 =?utf-8?B?M2VFMFFLWGZXNTJXUnlwMjJ2dmU5Rjk2ZXlmRDVsa3FUSzZJK0VKL3pGK3l4?=
 =?utf-8?B?em9tcXIvM0Jzc2F4VEF1dnpSbFYyUW14TUlLVHBtSmRTUDZ6d1VIVENVOGZi?=
 =?utf-8?B?Z0crYVJzKzVYM1dOSTM2QmNIOHJIUUVmdm5LS2JqSGFuTyt3UFlFck9uMEVE?=
 =?utf-8?B?UmNqKzVKRUtMeHRhUklqdXBuTUlBSktpT0xJdFFTa3Nybm1zakx6dkZzYklL?=
 =?utf-8?B?eXpiaGZpUWVWZlJvMmNVY1h0anVwbXhRcm03bnBkQTdJNnRxTkdiZ2xWZnEx?=
 =?utf-8?B?OG0rTjB0SDRMSkU2UUVzRjJGN2ZMNHVBTVh2bi9LY1BjU3E5T2hpeU5TZXZu?=
 =?utf-8?B?V09lSk1MWnlra2V6aXNrSFBOTXhoS0tqLzB5ZE5hbjc4R2VycmNzTjE4NVZY?=
 =?utf-8?B?UWdsT0ZqMDdYWllqZytuRjc3THAwNDlTU1A1K2tpT3Vkeit1UTFsSEszdUNP?=
 =?utf-8?B?dWs4VXZQczlnMW8yakUzMUJucGZJTUJYTzlKWHpmUUFLMlBpSzcxc2I1bWxu?=
 =?utf-8?B?WUtZcDdHNVFPYWFRQTRrMlh5ZWJ4blA1a2FIaWF3MDRIMGxoYjFiTkUvdHh2?=
 =?utf-8?B?UUhWTXM5dTkwZ2NkOEhnZkwwVW54Z1VxVkRySTBiQkpqekVvRzVTVXoveE9B?=
 =?utf-8?B?SnZaRTE3Ly81d2owSDlOejA1dVFrUlE0VVk4WjNvUk9VWGRGVFNZOVY5YzVL?=
 =?utf-8?B?Z1JPdk5KMEl0bkVSdVVYQVRvWjVrQTc5aEErSiszU0NPQWVINU4rYzFwNXRs?=
 =?utf-8?B?S0szSFpWNHBVUExELzQxY3hobS9maU5pNkRZWGEzUEppNE9SUllKMFVDNmxt?=
 =?utf-8?B?dHY0bzJ0M3ZES2FMUGJleHFWZVhFQ2lVOHVMVmp5T1ZtYVlhd3FXdU9sMWt5?=
 =?utf-8?B?THJmWXppd3dOMGl4aFRPYVIxaUpsZGlIellBZld4NHdzRGRzUWMwcHZtN3lE?=
 =?utf-8?Q?VOg0Rmd77i34Nk4qa4=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b079bba-92c4-4e71-d540-08dd5cd9ccaa
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:07:47.1571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5486

--------------9qYJU8lDboO6nsSrxOzJe0kV
Content-Type: multipart/mixed; boundary="------------3clt05kshpAbI7bt0juMLZI1";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Ping-Ke Shih <pkshih@realtek.com>, "nbd@nbd.name" <nbd@nbd.name>,
 "lorenzo@kernel.org" <lorenzo@kernel.org>,
 "ryder.lee@mediatek.com" <ryder.lee@mediatek.com>,
 "shayne.chen@mediatek.com" <shayne.chen@mediatek.com>,
 "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>,
 "miriam.rachel.korenblit@intel.com" <miriam.rachel.korenblit@intel.com>,
 "nicolas.cavallari@green-communications.fr"
 <nicolas.cavallari@green-communications.fr>,
 "howard-yh.hsu@mediatek.com" <howard-yh.hsu@mediatek.com>,
 "greearb@candelatech.com" <greearb@candelatech.com>,
 "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
 "benjamin-jw.lin@mediatek.com" <benjamin-jw.lin@mediatek.com>,
 "mingyen.hsieh@mediatek.com" <mingyen.hsieh@mediatek.com>,
 "quic_adisi@quicinc.com" <quic_adisi@quicinc.com>,
 "deren.wu@mediatek.com" <deren.wu@mediatek.com>,
 "chui-hao.chiu@mediatek.com" <chui-hao.chiu@mediatek.com>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "bo.jiao@mediatek.com" <bo.jiao@mediatek.com>,
 "sujuan.chen@mediatek.com" <sujuan.chen@mediatek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Cc: wiagn233@outlook.com
Message-ID: <bf14111a-a6ed-442d-81e2-8c7dbc4b53fc@outlook.com>
Subject: Re: [PATCH v8] wifi: mt76: mt7915: add wds support when wed is
 enabled
References: <TYCPR01MB84374EEAC0DDDA4223B8997298CB2@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <c56c9714c754451a8255ece79353da2b@realtek.com>
In-Reply-To: <c56c9714c754451a8255ece79353da2b@realtek.com>

--------------3clt05kshpAbI7bt0juMLZI1
Content-Type: multipart/mixed; boundary="------------0QdGxh0tyno0WT4f9Si003ge"

--------------0QdGxh0tyno0WT4f9Si003ge
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNClRoYW5rcyBmb3IgcmVwbHkuIEknbGwgY2hhbmdlIHRoZSBjb2RlIGluIG5leHQg
dmVyc2lvbi4NCg0KQmVzdCByZWdhcmRzLA0KU2hlbmd5dQ0KDQrlnKggMjAyNS8zLzYgMTA6
MjcsIFBpbmctS2UgU2hpaCDlhpnpgZM6DQo+IFNoZW5neXUgUXUgPHdpYWduMjMzQG91dGxv
b2suY29tPiB3cm90ZToNCj4gDQo+IFsuLi5dDQo+IA0KPj4gQEAgLTEyNzEsNiArMTI3OCwx
MCBAQCBzdGF0aWMgdm9pZCBtdDc5MTVfc3RhX3NldF80YWRkcihzdHJ1Y3QgaWVlZTgwMjEx
X2h3ICpodywNCj4+ICAgew0KPj4gICAgICAgICAgc3RydWN0IG10NzkxNV9kZXYgKmRldiA9
IG10NzkxNV9od19kZXYoaHcpOw0KPj4gICAgICAgICAgc3RydWN0IG10NzkxNV9zdGEgKm1z
dGEgPSAoc3RydWN0IG10NzkxNV9zdGEgKilzdGEtPmRydl9wcml2Ow0KPj4gKyAgICAgICBp
bnQgbWluID0gTVQ3Nl9XRURfV0RTX01JTiwgbWF4ID0gTVQ3Nl9XRURfV0RTX01BWDsNCj4+
ICsgICAgICAgc3RydWN0IGllZWU4MDIxMV9zdGEgKnByZV9zdGE7DQo+PiArICAgICAgIHU4
IGZsYWdzID0gTVQ3Nl9XRURfREVGQVVMVDsNCj4+ICsgICAgICAgaW50IHRlbXBfaWR4Ow0K
PiANCj4gSW4gZ2VuZXJhbCAndGVtcCcgaXMgc2hvcnQgZm9yIHRlbXBlcmF0dXJlLiAndG1w
JyBpcyBwcmVmZXJyZWQuDQo+IA0KPj4NCj4+ICAgICAgICAgIGlmIChlbmFibGVkKQ0KPj4g
ICAgICAgICAgICAgICAgICBzZXRfYml0KE1UX1dDSURfRkxBR180QUREUiwgJm1zdGEtPndj
aWQuZmxhZ3MpOw0KPj4gQEAgLTEyODAsNiArMTI5MSwzMCBAQCBzdGF0aWMgdm9pZCBtdDc5
MTVfc3RhX3NldF80YWRkcihzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywNCj4+ICAgICAgICAg
IGlmICghbXN0YS0+d2NpZC5zdGEpDQo+PiAgICAgICAgICAgICAgICAgIHJldHVybjsNCj4+
DQo+PiArICAgICAgIGlmIChtdGtfd2VkX2RldmljZV9hY3RpdmUoJmRldi0+bXQ3Ni5tbWlv
LndlZCkgJiYNCj4+ICsgICAgICAgICAgICFpc19tdDc5MTUoJmRldi0+bXQ3NikgJiYNCj4+
ICsgICAgICAgICAgIChtc3RhLT53Y2lkLmlkeCA8IG1pbiB8fCBtc3RhLT53Y2lkLmlkeCA+
IG1heCAtIDEpKSB7DQo+PiArICAgICAgICAgICAgICAgcHJlX3N0YSA9IGt6YWxsb2Moc2l6
ZW9mKCpzdGEpICsgc2l6ZW9mKCptc3RhKSwgR0ZQX0tFUk5FTCk7DQo+PiArICAgICAgICAg
ICAgICAgbWVtbW92ZShwcmVfc3RhLCBzdGEsIHNpemVvZigqc3RhKSArIHNpemVvZigqbXN0
YSkpOw0KPiANCj4gU2VlbWluZ2x5LCBrbWVtZHVwKCkgPSBremFsbG9jKCkgKyBtZW1tb3Zl
KCkuDQo+IA0KPj4gKw0KPj4gKyAgICAgICAgICAgICAgIGZsYWdzID0gdGVzdF9iaXQoTVRf
V0NJRF9GTEFHXzRBRERSLCAmbXN0YS0+d2NpZC5mbGFncykgPw0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgTVQ3Nl9XRURfV0RTX0FDVElWRSA6IE1UNzZfV0VEX0FDVElWRTsNCj4+
ICsNCj4+ICsgICAgICAgICAgICAgICB0ZW1wX2lkeCA9IF9fbXQ3Nl93Y2lkX2FsbG9jKGRl
di0+bXQ3Ni53Y2lkX21hc2ssIE1UNzkxNV9XVEJMX1NUQSwgZmxhZ3MpOw0KPiANCj4gU2lu
Y2UgX19tdDc2X3djaWRfYWxsb2MoKSBjb3VsZCByZXR1cm4gLTEgZm9yIGVycm9yIGNhc2Us
IHNob3VsZG4ndCB5b3UgaGFuZGxlIHRoYXQ/DQo+IA0KPj4gKyAgICAgICAgICAgICAgICgo
c3RydWN0IG10NzkxNV9zdGEgKilwcmVfc3RhLT5kcnZfcHJpdiktPndjaWQuaWR4ID0gKHUx
Nil0ZW1wX2lkeDsNCj4gDQo+IERlZmluZSBhIGxvY2FsIGBzdHJ1Y3QgbXQ3OTE1X3N0YSAq
cHJlX21zdGEgPSAoc3RydWN0IG10NzkxNV9zdGEgKilwcmVfc3RhLT5kcnZfcHJpdmANCj4g
YWhlYWQuIFRoaXMgc3RhdGVtZW50IHdvdWxkIGJlIHNpbXBsZXIuIEp1c3QgYHByZV9tc3Rh
LT4gd2NpZC5pZHggPSAodTE2KXRlbXBfaWR4YCwNCj4gYnV0IGNhc3Rpbmcgb2YgJyh1MTYp
JyBpcyBzdGlsbCBub3QgdmVyeSBwcmVmZXJyZWQuDQo+IA0KPj4gKyAgICAgICAgICAgICAg
IG10NzkxNV9tYWNfc3RhX2FkZCgmZGV2LT5tdDc2LCB2aWYsIHByZV9zdGEpOw0KPj4gKyAg
ICAgICAgICAgICAgIHJjdV9hc3NpZ25fcG9pbnRlcihkZXYtPm10NzYud2NpZFt0ZW1wX2lk
eF0sICZtc3RhLT53Y2lkKTsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgICB0ZW1wX2lkeCA9
IG1zdGEtPndjaWQuaWR4Ow0KPj4gKyAgICAgICAgICAgICAgIG1zdGEtPndjaWQuaWR4ID0g
KChzdHJ1Y3QgbXQ3OTE1X3N0YSAqKXByZV9zdGEtPmRydl9wcml2KS0+d2NpZC5pZHg7DQo+
PiArICAgICAgICAgICAgICAgKChzdHJ1Y3QgbXQ3OTE1X3N0YSAqKXByZV9zdGEtPmRydl9w
cml2KS0+d2NpZC5pZHggPSAodTE2KXRlbXBfaWR4Ow0KPj4gKyAgICAgICAgICAgICAgIHJj
dV9hc3NpZ25fcG9pbnRlcihkZXYtPm10NzYud2NpZFt0ZW1wX2lkeF0sIE5VTEwpOw0KPj4g
Kw0KPj4gKyAgICAgICAgICAgICAgIHN5bmNocm9uaXplX3JjdSgpOw0KPj4gKyAgICAgICAg
ICAgICAgIG10NzkxNV9tYWNfc3RhX3JlbW92ZSgmZGV2LT5tdDc2LCB2aWYsIHByZV9zdGEp
Ow0KPj4gKyAgICAgICAgICAgICAgIGtmcmVlKHByZV9zdGEpOw0KPj4gKyAgICAgICB9DQo+
PiArDQo+PiAgICAgICAgICBtdDc2X2Nvbm5hY19tY3Vfd3RibF91cGRhdGVfaGRyX3RyYW5z
KCZkZXYtPm10NzYsIHZpZiwgc3RhKTsNCj4+ICAgfQ0KPj4NCj4gDQo+IFsuLi5dDQo+IA0K
DQo=
--------------0QdGxh0tyno0WT4f9Si003ge
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------0QdGxh0tyno0WT4f9Si003ge--

--------------3clt05kshpAbI7bt0juMLZI1--

--------------9qYJU8lDboO6nsSrxOzJe0kV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmfJ5G8FAwAAAAAACgkQX75KBAfJsRmL
eQ/+JZsfN/utBbNju5R2FQAHQBPuIU4Y133D2nU/V9eDOYyVoiHNswjOIxkaocXP/dVsQjJMC9zd
Q7V1WmTpMh2uEp5a9MR+qosOrX648QznEmf0jFeCboFWKQgJKimu9gkVPoGJSxBn7lrcBABxg4PW
YzuYUndZXnb9PQ4I0JFoxCEOOJW1S9Iagft3gto/fnztWdIXZXJDI8yAOA2fZnvfNYt3sPuH0Ap9
qHVVhU4ly+SSJH2jFYAQcBoFvuFLN5yHniYyQyOmxsU5dwpk+RUekXTT63FCaPmJx+mUdpN7u7H3
RcXVJ6aceIubDNRnRvt7oWLKErMkvOa9OKbuDmytzA3EvCpXQqvWj/L+hnMmcEJ7SVVFW3V/AKNZ
4FcJjcVkU83Rs2k+AWszhE4t+jlltxZJ6O7amZ7ecNDqCwGWK1CVdeSxxpjsWyWAjtQ1aw/WW8ur
6wju0VOVbp56yZ2plnbjmMGvKveVmdmUUvwhj+LdJGc8ZMdNUFLJ9FKprVwHYLv0nC97mthjJCkK
OHrR2G9rls6aJhSN8Zv2f9hl1tRtubB48y9iQzF1KvM6gINnZKLpczs1dRX0Fu/Y8zg7eko8LjbM
taJDAVbZwtXLvQhyr0Tlr6w5ei2AIp+nmtodlqL1k0m1Fb/Fz6+gICcsKGfYt3Noh71uex1ANtXv
CnQ=
=bBDA
-----END PGP SIGNATURE-----

--------------9qYJU8lDboO6nsSrxOzJe0kV--

