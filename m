Return-Path: <linux-wireless+bounces-38334-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CW2OF6ZxQ2oFYgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38334-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 09:35:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F11886E1325
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 09:35:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=sr4VD3ln;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38334-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38334-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EE4F303CE19
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 07:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6321D3B2FDD;
	Tue, 30 Jun 2026 07:31:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010018.outbound.protection.outlook.com [52.103.23.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48FBEEC0;
	Tue, 30 Jun 2026 07:31:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782804693; cv=fail; b=n/qG+tifyXSWO/LtZIGpUfbYdCJdEuQA7l1EApiBcj8tIkGu0EHIXoYTixAb+KtQ9FVIuVt1hie8iPg6n3OCm4ayVTXiGoxyXzYNB5jUjOXTblajZXPytX9K0JDMXqJ/z9BYf/4JDYUKPLagfKRdRoj2k/aLwlDEHbWQeJIDJEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782804693; c=relaxed/simple;
	bh=8Y2NVsNOs0/w/hwz8jDr7Go3uKx42OJafCXBQxTp5YI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U7r9leaInRWV0b3VicmNizS/xLcJ6bg+5r3A1XRxJdDUb7D7/QjIwk1KRQ3XYWVr03GM6kh9IdtfPFNtP8AlbRFjIKq9czE5yMT7s8ty122CkpDTwcA1BSU1C2qWV4NKoeZBLLluKzKS6hmLOikGn7qwdnaEgPkof7EwAWFfqMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sr4VD3ln; arc=fail smtp.client-ip=52.103.23.18
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyi/gHVm8Z8E2Vm4DkCoWyW0K91VNTR+Mb+ULRYFmRur6KFRIhUm2003rkwCrneO/8Fnpm+m8cvRKnpba0psYDZSmZpMshLnQ9JVLgeJNFUMIVbLrsKixFUT3ukscNZLgHu0XjEo+Pq/SMW6cE8z9kOBsRRk8G0Yxt5Af60T3yz6+C3tSjdoVe0Mx1DM0kGXKkAM9lLQp7YhNPYalvwcaNMHqNJhYIf2Uvl/Xt64Qjw5CdUcv8yGsFx27PNXOtOhQo7WA4UvTnzhoYfwVSWTf0sDG9JSSHAjjcZUUH1M8v4vpBaVz5ZgrVZaa2jO/UqbbjAyoh5ucPXLaoKlWy36XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oz8y8Sp4BqvfLDEnAumo3LRYeIaMHWgpKpaGx4F1R/Y=;
 b=k26mcFII0fIYeGXKU8wUEpFFfLti75vC9cQFFpQl4z1RIuJzcSbELsxfgK3EQfVN1uCQtxkQHm1nxjqEHHCdo/Yo0Fjl8Ln0iNs8TX6AXSZVW0/d8Srn2rbE3iMKnRUIgbAeWvwzefg3xyrzY9dWeerlNIeeFKW+/qJo/71GIOoLMfCam8cVnfPhmrEsBGQDtKolEnUP+WIgm9lRfb8GHDqpj3OlYIxL2kJOElF+MNexHCtxtyZfE6sTYsLHj9JtBnaxAvHOTNJYfZTbgAOCfJfpx9+90Ka5V6jroWUE1zo16/CXaEpYsZeK7RXKsK1w/4NZykBdvMYWsU8DlhrzEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oz8y8Sp4BqvfLDEnAumo3LRYeIaMHWgpKpaGx4F1R/Y=;
 b=sr4VD3lnqewOVBSGnzUMECAjExxTH9amwqLbfWNJ6ZQ6W5eylEHdc6XPU41Rr95FihhJyX5vLa7sfstwwDHbOi7IdP47hMmEQIMZyl01A1cknMCSE85E58llhP6+Qc0ww55X8hxw8+rthmFoLr7TQ5oGLMLOmHPeuSu+mG99L3wCGkhrW31AXRdEg2MOwvfPiY94OtCqcocep800q/lenE97e+XpbFflUkbZQnV6WrdY73z8eQROf8RcP29r9Lve3lzQMS9oygR+x7JZG3NPKlf9NAQix9rCVI4rvfGtocO5/OlXNs4YHIDWchzGSdvHxRKm0+WZaVUVpIqUdiEyww==
Received: from SN7PR19MB6736.namprd19.prod.outlook.com (2603:10b6:806:263::12)
 by DS0PR19MB7622.namprd19.prod.outlook.com (2603:10b6:8:dc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.19; Tue, 30 Jun 2026 07:31:28 +0000
Received: from SN7PR19MB6736.namprd19.prod.outlook.com
 ([fe80::4b6c:b84f:b71c:d0a]) by SN7PR19MB6736.namprd19.prod.outlook.com
 ([fe80::4b6c:b84f:b71c:d0a%3]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 07:31:28 +0000
Message-ID:
 <SN7PR19MB67361ED99501853D6BD968E69DF72@SN7PR19MB6736.namprd19.prod.outlook.com>
Date: Tue, 30 Jun 2026 11:31:13 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: net: bluetooth: Document Qualcomm
 IPQ5018 Bluetooth controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulfh@kernel.org>,
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
 Philipp Zabel <p.zabel@pengutronix.de>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-remoteproc@vger.kernel.org
References: <20260629-ipq5018-bluetooth-v2-0-02770f03b6bb@outlook.com>
 <20260629-ipq5018-bluetooth-v2-1-02770f03b6bb@outlook.com>
 <20260630-wondrous-lean-stoat-be0b9a@quoll>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <20260630-wondrous-lean-stoat-be0b9a@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0010.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:26::16) To SN7PR19MB6736.namprd19.prod.outlook.com
 (2603:10b6:806:263::12)
X-Microsoft-Original-Message-ID:
 <f6bac86d-d88a-4b25-95c1-807c3803ec00@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR19MB6736:EE_|DS0PR19MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: c97f201a-2324-432e-acc7-08ded67998f0
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwUXBahuwteIkQeW30lJPuxOInnodx1UWtcOS8g7VjZuE01LOvP5n73x7WgqsBKTZw9i7jPCzz1ftpPAgZ1O9xfg8jTy1ovFWVDfYegiEFJbWh/rR0Y6kaXOwBFSEIp8xRghgQzHexiHy8gU7dXBhGweLxM6ckSrOpruj9Pa2DAcHf8hmOu+ELdj6RB+X+r1vWFToF2IHXu/Kx9mPzKDab+VvuTvEdn1tuv+jl5SKCr8DEdcwsKBKSNS0fwljH4fcBlNg5fdbzgCGedIlu7JhIKVWKHZl6gO9HkLJDrVDDINyj05iPWaYp5Bhhh/UbEUVh3XeGg+UKVWlgWMSBUWmRmkxV2rzTo8ij84ixU2zPoKKRyw7WL5oA8JBNh35JZlDkoLzKuAVKfgUSutY9WWh1vx8VqrNQWdGkbR0M42Od3Q32t1McJ+lez3R2GpDhyeLJgtNpUdNQgU/PBhl55zhG6GGoUrTPyt+Bo68VCZvsL17nu53rs0lmqhwUg5wwq0DO8ICv++PMESA6+Mvt+bzCqnETKWyACTBmoSElNTxm/8rv3tCpQa82i+r2b25HVg4m8RX2uNChZRhjl9wPZX1FS3yLBWLhjCgm0deUTqglUE/UBL8AZpHjRYx/2Icodl5DxF8ia8kaWQQrHJmKt5nBCgiV7icfA38jRCnpCcVvEOVB3owv1zIQkjweSXFZWuVh8zjwsnv1Js4Iws7qnILc/ewBx485v+AXg6cU1aAtWL7+zcXCGn6Tp0okFXGb4RavU=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25010399006|5072599009|8060799015|19110799012|15080799012|37011999003|23021999003|51005399006|6090799003|24021099003|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEhHTHJIT29tUFF5eTB6ZjJ3RXFIcVA4elZBREpGcDNHQWlFcnQ5d1hjdThV?=
 =?utf-8?B?OXNhaFkwOFBXUjlidnlnV3pSQlo3d1RYcU5ZcDlRVGR6MjYrM0FuOVJlWXM3?=
 =?utf-8?B?VXFZcHlGL0lFaVN6YmU1MGZuQ3ZSc3JxTkdKMFJWWmo3YVZpUDFyVnA4TytK?=
 =?utf-8?B?WHZoVVJVK01jNTI1djg3UTRNK2dIcTVQQXFtS3pGL2NZVTBNdzYvaWJDRVdp?=
 =?utf-8?B?eE1MVkoxUlRVUWJ3MUkzQmJHczNSTmkzUDF0K21SZXVpdVZQanJ1cVR0NjRW?=
 =?utf-8?B?REZoS3NYbEFQNXFYdUdkTDRxbW10S3VsZjdQaXJqWWFSTlp0UWRNbE4razVM?=
 =?utf-8?B?cC9YVDU5cjU2SnV4NHRJdUE1Tkg1V2hHd2dPZElndHo1OFV1VE1aTEZ4TXdE?=
 =?utf-8?B?cHRVTkQ4QnhmV0JyU2tIYXMzYUEzejkyMXdjSHpQZHhKUFpBbFYzREo1cTkx?=
 =?utf-8?B?MTQyYmowU3Bka3dCdHNQK0RtSHhRYVdzQ0p1ZmRPRnRVZkFFZ0tzWUdvWVB3?=
 =?utf-8?B?eHVXSTg3VnFVRjdGYnRWSXpmVS8xR3R0Z1dLZzAzbFRYWVRCTTBObFNzRHRm?=
 =?utf-8?B?dTk5MnZ4cis1N3dGVUhHT2hmZERtTy9idGRCd2h3M2M0Z3VFRlpoSVBGaW1C?=
 =?utf-8?B?U3ZhMFN2b0M3Wlk4dzdBalBMaUFHU3V3Uk53Z29EdGc2VWZsSmFUWjFFV21h?=
 =?utf-8?B?bmZEOW02eHVVeG5KZVg1YWU1QUtUV090WjhPeWxWNmQwVkVXZ1NIZXhpNDNl?=
 =?utf-8?B?QTZpdGd2ZkM5ZEdTc3hLRGdqN3prUUtoWXBvb0dLSWZMaXhGR1ZYR21lQzRp?=
 =?utf-8?B?SndNVlo2ZTNMN2lLVGxxaUk1ZmttSUVRdldDcHJmRzJyRFFENHBwY2pLM0pV?=
 =?utf-8?B?MTdlbm0rRVVzc0xDQzV5Q3V1OFdDRHVZQmlUdDI4bElYY0pXanhPek4rbVBm?=
 =?utf-8?B?TFhiWnFvRTczRndRTlpCTW5mcFJwTlNaSDdQYmhsYXZVRWFzYkJmcWNNTkJD?=
 =?utf-8?B?d0JoVWhQRGVCU3BCZnpHclhxRjVQcmdibm5zTEdvNW9yaCtLR25vZnRmWFRO?=
 =?utf-8?B?VUY2QjNRd3BxQlhFTlYyVUR5SEJZcHBiYWNkdVJaaXV1bnFvOWtrOHNHQnE1?=
 =?utf-8?B?Vmd5UGJJY1dPcmNHTC92cDBCMk51WXJEdzJraFNxbVhTMGJ3cFlhSzRHVzY0?=
 =?utf-8?B?alJoWU54ZDJSQmJOcUJyRTNhOXVaTDNFeFpsUVB3Ym54TDRoL1RQd3ZrUWVS?=
 =?utf-8?B?K3NvenlsNDlWak9BcUJROCszTFZUeWxOa2JaRzRGcmVhUlpNRUlRNTJmUnFX?=
 =?utf-8?Q?myPnIAELc+O8cY+/kOXtqZ+uBpywl353WN?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TURjNUdlZE1JdWNWU2ZGYUNYRGFkNjQ5cXAySzkxYTk1Zks4b3VObmVtU3hy?=
 =?utf-8?B?R1l1TFhXdjA3U3hQMUNRMU9OeGo3RUFadmYyRmVUZ2UrRzdRVlFvNmp1V1Bs?=
 =?utf-8?B?TTBnTmlZanVpSU9HRDhwMCs2bTFEU0dxVllCMm1naFlSVDRkWmNMbkZBeHBl?=
 =?utf-8?B?em1oNWlZbzdqcWFUUURBblB4a29QMDlRQlM1bE9pbWtoRGVGditsSGE2T0Fv?=
 =?utf-8?B?MEJsaWVkQzZPMVN6L0R3SHAwMCtFT2pwcHlnWU5VV3JmZE5IdEg3WlFNYmY0?=
 =?utf-8?B?M1o5VktsR0lwR1N6ZHJzNjdsT3RSUnh6MkV4Z2x1NTdqNjRwZkdTbXBISnho?=
 =?utf-8?B?NDNTaElGU1MzaEpyM0dqcWxveHR0WGYrM3dKS0pGVlBaejlqTmV4SFhDMmVW?=
 =?utf-8?B?UXZ3UUpSWDNzamhCVFBIakg4WlpuVStrcjdRYzYzY0FFVEVWcHhMbDNJOEtC?=
 =?utf-8?B?Y01vUWR2U1hlNFNUYWsxOWFRTjNPdk0yS05hUktpQXJSbUpLLy9PeFhSQUpv?=
 =?utf-8?B?SHVTOTZkTC9uZlJoWGJIWDFSOVJOMGdJb0lMNzRvWS8vT21PMS9UVzgxd0kv?=
 =?utf-8?B?bVh2RENhNnRnajFGZ1ZOZHRhQ1oxK3hsWVBXN2QrRk0vOEtCQ2xGQm1TNnE0?=
 =?utf-8?B?M0l3MTBZdjl1ajA1a200K3g5L1RUUzlrYUswVDlRS3d3ajRrdjRnWVJPUVY0?=
 =?utf-8?B?Z25RVHlmVWFvZURLN1l0RHRtU25qR3R3bUVUUTN4Q3c4YkFYOTFwZXZSbk8w?=
 =?utf-8?B?SHRrNHJXaGMzZFRUQUtuOWhoTTYzVnBVaCs5TnZpWDFUbzR5bjlkOFFLa2Y2?=
 =?utf-8?B?VGlvTWlSUkVnNWZucTZ6bkZyUlkwcHhkQWYvdEgwOTY4YlJOMWpObno2MU9I?=
 =?utf-8?B?eWVlMXFiNFJxdnV1SUJFaElHYjNYZlhXOFprSFJHdDRKSzhNdXJ4NDdjdEpO?=
 =?utf-8?B?QmlFcDlSa0hkcnRucUt0WWdKcFRxMnMxNVIxbmtwWE8xaEZzSnZpRmhQRWFa?=
 =?utf-8?B?dFcvTmhSTFRiLzN6UE84VmJPY3ljTUEwOHRGOEo0Vm5HdDRzOHh2ajJWdVVI?=
 =?utf-8?B?UlJtTzdBTFNxOGhhZVBKZkVmb0RuclRFTm1IaHM0M2lGeGJTcUk2aUV4ajk2?=
 =?utf-8?B?Z1FXMEFxQWpENm1VSDdqV25qTlE3WXhtWEdJSENUZjVWV0FrY0x6TjRJOW9z?=
 =?utf-8?B?RDZPd1ZiVG5nam5JZzlWbHM4R3lSbjZEMTdEcE5zdERjYTNoRjJQWDY1MTZl?=
 =?utf-8?B?QSt4dWRMZk5aS1dlNlVmTklyVXBsL0JFdlN1NmRqRFkvRDdHNXN0bGVsaHZE?=
 =?utf-8?B?UlMrejNDbGVDTnU4UVE1Zzc2WmtIZ0lBWDIzRXBhZUFVM3NOMjdPUWlRekNr?=
 =?utf-8?B?RXR5aTh1U21hWWRhc1NUYlpiNXB2SnFyU1QwVlZpMkozbVNMUmRaOE9obkVp?=
 =?utf-8?B?NGJlU1RLUFBTOWJ5ditIQlVtS2w3N3dKVWFBdVFGajAxSkYwS3NCWXpCeXdW?=
 =?utf-8?B?K0ZyMUNWNnVjckVrbEZ4N0NOZFVkU0hIRkR2RDd2TzFFdUVXcUIyVjZtdjlI?=
 =?utf-8?B?ZG5TblZKMlRyaWNzOThPanVPaG9iT1pyZzMxeHpmODJUUFp5QkhjWDM2SjEy?=
 =?utf-8?B?NUFqT1dPclFNckF3WEwvckp4ckROQ2w3YUNvekMwMVd4VFNPejEzRm9SUG9S?=
 =?utf-8?B?ZXlTbHZQYUpuQ0hFTC81WjlnYnBIUDllbUNZQkdYeFQ0OUZpSWU3YWNGVEZB?=
 =?utf-8?B?SFZrcU5ZZEV3SG1Nenh3NWE4dDdrUFgzcHZzbEk1Z083ZDF3WXpSVXlxbmN4?=
 =?utf-8?B?Q2MyVHQ1SDYzTFVPVEEvQWlyTXhaWm5GR0VCSXdmSlMwT2Y2UVpwaW5UY0ZQ?=
 =?utf-8?B?UUs5bXV2VWhSbUoyaGpGUW9jTFNSRHU1ZXNnbDl4a1RPa0E9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97f201a-2324-432e-acc7-08ded67998f0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR19MB6736.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:31:28.2940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7622
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:axboe@kernel.dk,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:saravanak@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mathieu.poirier@linaro.org,m:p.zabel@pengutronix.de,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-remoteproc@vger.kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[george.moussalem@outlook.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FORGED_MUA_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38334-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,pengutronix.de,vger.kernel.org,lists.infradead.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,outlook.com:dkim,outlook.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F11886E1325

On 6/30/26 11:15, Krzysztof Kozlowski wrote:
> On Mon, Jun 29, 2026 at 05:01:44PM +0400, George Moussalem wrote:
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/reset/qcom,gcc-ipq5018.h>
>> +
>> +    bluetooth {
> 
> Don't send new versions while discussion is still going. I need to
> repeat my question - what bus does that sit on?
> 
> Device nodes represent real devices. Real devices sit on a bus, usually.
> Do you have here a bus?

I'm afraid I don't have a definitive answer. Again, my understanding
based on downstream code is that the 'controller' is basically a Cortex
M0 processor running Bluetooth firmware connected to an RF. Data
transport is over a shared memory carveout with APPS signaling the
controller through writes to an IPC mailbox register, while the
controller has an interrupt line back to signal APPS.

> 
>> +      compatible = "qcom,ipq5018-bt";
> 
> Best regards,
> Krzysztof
> 

Best regards,
George

