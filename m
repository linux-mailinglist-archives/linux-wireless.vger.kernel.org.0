Return-Path: <linux-wireless+bounces-29357-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2DFC88E6C
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 10:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22CB3B09E9
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 09:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CB93161B3;
	Wed, 26 Nov 2025 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="H39WhPYd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012078.outbound.protection.outlook.com [52.103.11.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8962C0281;
	Wed, 26 Nov 2025 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764148765; cv=fail; b=EfQi2NrkSCg8xl4TJu1f9Pa+l624AS24iKN1sBWUbe7r493TSms7K87ybhZzPf5MjOb81mznZQJm2isEV+b1kGcYAAL2fwG1f1VmMEAUdBA5m16eFwYbo/jDCgoD4ZfiYHwNzT45mDs/GLw7TbCur1OS/6PtNADBTrBaKNulOu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764148765; c=relaxed/simple;
	bh=/aoKHVtyACPNc8nmu8+CTr6MaZ1pWYFysUYzZcQcv6M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rJqFVKwOqDUQ36AsPsEz5vHaQWKnZbQa/ll1eI91HQVFI4acmn1IHyp7PpvBqAtylFI4eMIPA6/4AW2l0B18iKDQlIaBJNNkp33uwfDCX11V1GxAyXuWMLQPkxGpvpgNfu3Xxlvt+7/0DKtvdWvk9BFG6YFjhxep+i7ELBkB3A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=H39WhPYd; arc=fail smtp.client-ip=52.103.11.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHydX3JF/ipUXUoGkhH4/SY+FEK9PVQ/8+KmylTNRifosjCcavQRvGFwmKYceD1ciYjtHYAQC3/yWGPSf1TBfWREqIwiPA9XrCjf5F3MwWUhT9sboD5Kk6AlerFd6phkxBmDFA9oMND2lBv85EX4JUF+Ao0g39F6pfrC9UXT+rhSfKQvOjXFqoLqifvUHxWQ0rEkAbCbkNKvKVv7ldCiW/xkB05MSPI+OvsuDSdezLVSNOvcEAW4CFf9TcPvE4Ei5mfctoUgsd8UobpfHwNPz/A1iWOoMHnQUVxMuR51WGgWX+9uErz43jjjEeqQPjXMQLkaoSS+t/uXBEltuXHnKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aoKHVtyACPNc8nmu8+CTr6MaZ1pWYFysUYzZcQcv6M=;
 b=ZEEDxAjNmsePFhNWQewn68U8DIZGGPj/s28Oyk5waLdOUaANnU7cbeCbEnRJ8EEnRdJy8sCzK0oBU184teayzL83Mew4eo0eP9yH3okO1+kbA0w3vOhT9e8f6fYs3XDRiz7z1suAfML8QLjhqT49McB5gpsAkjGQAVrTExMmkC1DFOCRe8TAi7hxCrM9+hBfeOtgVT3S9FciQ9Z8TsPTmDLSxQ1FvMPEiPuOSmIMT57AlSW2LYtSXbsFG2fY3cTaydCPvIxHFCWe0ugMNGTwVVjf5RfBGMKd8VmRgWC3AOndpCtA/jCLGgp9S8RMlB62Az+AHZpKNHtWldxM/TWflw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aoKHVtyACPNc8nmu8+CTr6MaZ1pWYFysUYzZcQcv6M=;
 b=H39WhPYdQTHjk8hw0iWJPI+Rz3bbzFMZo4rwN1KwcxovaUm+XJh3QgjUAK/9xttBYhiOA7IlckxEXTuWvrfVWECz4S3IlpNBj3HlM0cXMmZtPP2sU/9gpPP5apvrP8sovs6D7+0JqeneKUjn6RmNMSgwrdMdY/qrNXjn16BV8IfcHrA/Yv+8Sk1s7X1whHgljWcd2meomrAIQwkULnBFxXKzzkW+gAltXyc2uUqlUGqJ5rN4H7tSO+iw8UzdzKiLusKuEOzvSM6KtuBIcqCNMIh9oHVxA6ogyNeCLaVW60q9YvQJ84Hr973xvDXjJM9bpE0+tvM4vxV07xJ6Gz0Eeg==
Received: from SA2PR10MB4460.namprd10.prod.outlook.com (2603:10b6:806:118::23)
 by MN6PR10MB8119.namprd10.prod.outlook.com (2603:10b6:208:4f8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 09:19:21 +0000
Received: from SA2PR10MB4460.namprd10.prod.outlook.com
 ([fe80::59c5:5e37:ba2b:6bd4]) by SA2PR10MB4460.namprd10.prod.outlook.com
 ([fe80::59c5:5e37:ba2b:6bd4%3]) with mapi id 15.20.9343.011; Wed, 26 Nov 2025
 09:19:20 +0000
From: Les Boys <lesboyspp43@outlook.com>
To: Ping-Ke Shih <pkshih@realtek.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHJ0dy1uZXh0IHY1XSByZWFsdGVrOiBydGx3aWZpOiBy?=
 =?gb2312?B?ZW1vdmUgZGVhZCBjb2RlIGFuZCBlbnN1cmUgdW5pY2FzdCBpcyBhbHdheXMg?=
 =?gb2312?Q?set_explicitly_in_every_iteration?=
Thread-Topic: [PATCH rtw-next v5] realtek: rtlwifi: remove dead code and
 ensure unicast is always set explicitly in every iteration
Thread-Index: AQHcXrW+Z0CSRGVJNEGpaLrTe6ESLQ==
Date: Wed, 26 Nov 2025 09:19:19 +0000
Message-ID:
 <SA2PR10MB4460B6485B1104727C02701BA6DEA@SA2PR10MB4460.namprd10.prod.outlook.com>
References:
 <SA2PR10MB44609AAC5888DC0334D140E0A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <d664a966f7754e879948039189aba8e8@realtek.com>
 <SA2PR10MB44605A853386FE1BB7174498A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <SA2PR10MB4460861A8224AA99EE5ACF6BA6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <731806e542f245b3b3ae6d2429c499e5@realtek.com>
 <SA2PR10MB44606485C05B0FC57402C40FA6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
 <ab5c8bb1f6f443c9a08882be5a1ba24d@realtek.com>
 <SA2PR10MB4460E7C842251428DB9D253EA6DEA@SA2PR10MB4460.namprd10.prod.outlook.com>
 <77827732646345698e1bf133bbc87494@realtek.com>
In-Reply-To: <77827732646345698e1bf133bbc87494@realtek.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR10MB4460:EE_|MN6PR10MB8119:EE_
x-ms-office365-filtering-correlation-id: 16667684-7b73-403c-72b5-08de2ccce107
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrORrPiYp+O3K37bg/D3hdjh57F0aBgvVQfg9WBoTiYqS97NZs48h2QFwlh0IkZG3DFAUkxjGsBJtptHRxZWUvqnnoJgOazmC5FMRQG0e6g5YeLz5iszjNRcdrF6+0hpKnbFyVtf+Uacf+gUuqTv+sgbc45k2s4r4+k66bY2J3rnJw2nbSedGjG1tMRssWcH4vYcwS66PPwYY3xNfuLpEg91rIIsBeT5B19gFBnjaJ0T8j8myWJdNiLte8LdwZbVaKwZOx5VTLfppFG85x1zMaICZOtg8UTfT6K/HYybXg42ENdTUKLrMBaA36N/CmQFV1D/G1gPTWVRYKOaXWNjfTKFduHDEhkIL60WmpljhAdkF699d/QwKgZsRn41v/qnuoFAfJQs9qQ0r3rI7KDYcL5xVXRWasX4cB4+DXRbaBRPVvA25nonRNXFSLe3xWmEAu7tCGTW+gERpr8xcEkvV0sNL39c9KXadyPJDq3tief3a1zik6X23Jw/YNBekTfkxDCqN0w8SYOXmeZfZRZBG3dwpBCeJhn3+dpnTxEWknAcBV0Ss3L1ZFsrMyiQeO7bepVUF6MjHSObmqUfPh+PK9JfFUSeNwmqiRVnV7cnQmQfgSQeYJiVAtOHtvvrXqNKfVcs+bDbr+Y2KC6gyclADjcUv3cg5ihjArWkvwVUZe0MPxmiJRc9MNLQLq5fzJqdmlxYQhMopeoxIIjQi6M7NO94jKgS9eBjaxQKtEJugkexzZlOX13M2ac5XnA9MorClr4=
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|51005399006|19110799012|15080799012|461199028|15030799006|8060799015|7042599007|8062599012|12121999013|440099028|3412199025|40105399003|26104999006|102099032;
x-microsoft-antispam-message-info:
 =?gb2312?B?bm9pdlNzTXpPbG96N09aTlRGOXZsMkRKVmV1SGI0RkV6dk1GUGNveTRqTnYy?=
 =?gb2312?B?VXpYNmFoKzVLNm5xNUlKNThnN2hmZ0J2NnRqc1lncERMc2FQVVJydWFqb3pm?=
 =?gb2312?B?RndBL09mWjJLbi9LR3BxOXVQcmt1U3FHVkJkRmpyOVFOWEpkZGJiUDFMRkhO?=
 =?gb2312?B?d1dRQWZwMG1nQjZDcVV2ZzFBV0dnMFVibTA3cXpjQitwUVFjUzFjNG8xZCsv?=
 =?gb2312?B?b1pTaEFtRnZmeFpjdGRkYmhsQnJzYllEZ1poVm9DbExXbnpGelc5aEpMTngv?=
 =?gb2312?B?YmozSkdWMkFSZG5aMUNYeFN6VDR2NXRGd0dvbUc1NzVQRlZ2S0FQRXFGVExY?=
 =?gb2312?B?ejZHYzZHSFlVWUl4Y3I1bjhsNGxiVGx2WkpZL2k4MVNHb0tHb1cyM2FtdklK?=
 =?gb2312?B?UkE5SXcwVmxsM0FmT3NtWktYUDY1eTdTOEU4SlhEVHFHMFdXOGdaMjRxRTds?=
 =?gb2312?B?Y1NNakdDYkJOYlpXNXpDeTgxU2VCS1YvVlE3QXFrN2VNc0IwWlJXZDNKa2Ru?=
 =?gb2312?B?OGdIcGpPR1ZoSkY4ellGdDRGdUZVd1N2ZldHNnd0REh5YmpOMFlHOXNBZEsz?=
 =?gb2312?B?TGpsRDBzbTllT3hRdm5OM3d2VnlyVXZMam9mYVZuOVVPS2pIc1Z3b3E5WGZ3?=
 =?gb2312?B?ZVhOcVJaMUZMejcxL2loL3p6TkFwZm5BbGhoQW8yT1VwVlh5a3lVUHpUOVk1?=
 =?gb2312?B?eWNQMTNpdkJDbjJjSzdUY0REbzd6Y2p2RUNwbVJpOTEzbEFXMk83azl2bTBT?=
 =?gb2312?B?WGwxRHV5WEczQ0ZwRWZDT1BzN2FnTDNYTmJFeVJIKys2MDF0aG0yRFlmSTY5?=
 =?gb2312?B?Y0JYWXV3cWlNNWtkNEZXWFVHaDJ4K3dkeEFFZVhpcXkxMXJuM2xST1MwSW5y?=
 =?gb2312?B?eWZJNDRtMTVKaEQzNlhmWXIxY1BVaURHRkJsS3MrQTRDK2I3eXVCRWs5Sjdw?=
 =?gb2312?B?dXU3cmtpODM0UlBnTFFlaXhHL0xvQTNqOTV1b0dNMzdDVzBGN2t3c0htK2No?=
 =?gb2312?B?RjN3S0xBeENielp6VEc1S3FUMU4rSW8rMFNSMVRueEhUR2svWkhvZnlHM2lq?=
 =?gb2312?B?QlV6cmNsR0Z6NUVvVkY5OE0wdFYxWUZGc1FEc0FxQmwzdUFoRGE2bmtEeUd3?=
 =?gb2312?B?Z3FUcFBzdDZ4ZHdtZzY5Um5hZkozZnl1bmNadklTSzYveTJSZE1jTlhmZFRh?=
 =?gb2312?B?VTJ1ZUUyYkgrdzRmU0Y1amFEUlF4Y3dPeGhKMTRMaUtjanJQZzJVbmd2Z1hJ?=
 =?gb2312?B?YWpaQUZIUlBTNzZOUEFvdWtHL2ErSCs2WS8zMDB4SzJvUWJTTm96MW9QSTRk?=
 =?gb2312?B?a1lIV2p2aFZha2VsWGJpRGRCV0ZuU3ZiY1QyQUwwWjN5enRkMlpNVXFXbEJF?=
 =?gb2312?B?V2MrLzQyMFdVeTFWaEZjSkNxSGFzODRtbDIvYTZUbnlkaUhoU2dUKzVhOWgy?=
 =?gb2312?B?NFcwZHBZckJzektUUmRZNkl2ZHI3MTVnbEVSY2w2NjVKYVc3a3hKMDg0aUJG?=
 =?gb2312?B?SnJVS0c1aDhoQTltSkovdTkxSWhQWE9mSDRua1ArNWtMMitWZ2xWTi9KOWJw?=
 =?gb2312?B?UTN5TGJFTHlWOTFGMEx4dTg2M2Q3NXppY3BiaVNoNjBGc0cvWW5uTmVmOGp1?=
 =?gb2312?B?N0FERkFUTEUxOFFxZVcxTEFTbXJ6QU5vdDVZc3JsUXNxRlhRUjFwWCs5RWkr?=
 =?gb2312?B?TTRTbWxxMzhOcnRlb3ZuSXVDZ3ZMUEVDZnB5UFFlZ3liVFNrVlhmVkc3NzRv?=
 =?gb2312?Q?6mFBGJSRyGBiEY95cL5QZwBRjNYLGZObCleAZpu?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Zk12cm1YRnBVbzZYZmhCOTV2Z2xpM2VNeUYwRnVtNUZsa3JjWFRacURkajRl?=
 =?gb2312?B?Z3dGcXlFR2Z0cVhWakgwcW90ZmZZMEF6bVVwcHZOYzFWQUtldVpadzJtb1Nj?=
 =?gb2312?B?L2thc2EwYklKODhPT21wNjVCSHVheUdZUkZmUUdwbDFLZnN2aUZWNWlZY3gz?=
 =?gb2312?B?Q1dPVUFXTk9zM3hNWlZJQ3ZpTWE0eDFvSldtbzE1SUNhOWpCMVNFWU55YmVY?=
 =?gb2312?B?Y3psNW5YZlpaK3I0V3E4NzhuZkhUL0dnelg1MUFJQ0x3RFpubG9FVzUzOUV5?=
 =?gb2312?B?ZnRhdWtFbm1WeVlLNVBHT0U3ek5XajBSeWpwY1NjMDdocmVpTFZNNVJtalBz?=
 =?gb2312?B?REJ5ZjhWaldHVUJjeHJ1M0dzREhVenZ5U0pJRkRERmdReVZRdDVLc3BhYWZW?=
 =?gb2312?B?YU42MGVkaFZRemdpRlNjNS9VM0VyQ2lmUi9oWWdvM1ZsbkxJVWxYaDM3TUcv?=
 =?gb2312?B?QldFOWo3SHhmSVplRlBscCt1R1FxbE93Q2ZsVXVkWHF6RCtPK0dSa2tsVFRG?=
 =?gb2312?B?S1lSQTgwZ1lvZ0JnZFFDdlVnVW1kTlkvNmpLazB2ZURzUldkb3JUdlpMeTQy?=
 =?gb2312?B?Q1dvemJrSlNzRFROUUpWcFFzWFhEQTE4aGltUUo0TW9XcnpYSnFjSGVISmpq?=
 =?gb2312?B?R3hTNEpnYTBMWFFCYlBWYUdTclZiL1JYNDlzN0R5RitFUnppd01QalB0ZytH?=
 =?gb2312?B?WXJJdWkxUE0yKzFGWFAvbkVrSzNiSXhCOEVTZ2lLWG5haDY5YVd0U2NsWWlX?=
 =?gb2312?B?OTFrOGhabW8rY3VPZUg0amxqdDkvamFlZ0xjSjNaSjFYM2RaS0VyVHdsMGtu?=
 =?gb2312?B?TkRic3BRaXdLM0tiQnpPbWxJRk5SYjQwRDVOQ2lwM09JSnlrakdSdW42emxR?=
 =?gb2312?B?a2VZeE1aK0pHMk50a1dzVmNJNHZ1QzlOdHlGdk5Ya3Y0YnJtbHVtWFk5Vzhk?=
 =?gb2312?B?d1BpSVNpL1hJSE5yQ0RCeGNVbUhBT3JnSlJkTnBSMmpLdXdPUExCN3B5N1o1?=
 =?gb2312?B?UWcxMnRmb0daUUxzeXIxcjV3a29oNzFibXBTdS96MDJXaGdLcjU3WU9SQTFp?=
 =?gb2312?B?MjUxWktaTFRwYmZWd3kvVExkTjVtRnhDTElYUjk0QnZZM2lLQzhESnBlNzM5?=
 =?gb2312?B?NlByZ25CaGJidXFoNDFyZEFENVFXR1pJaVdWbWdzSzJzQ2pBWDdoS1V2bHgz?=
 =?gb2312?B?OWtXeTBNeXZXTlhmNXY1dXhSTVlCZ0NyRUpoTVlIMTd6VW9uZmdNYTY1VHFY?=
 =?gb2312?B?dzBORHpySG0yRlpBUUN4bEdiSGJoYTlQbTZhZHlaZHQ3MU1rZWdNSHNGTGlF?=
 =?gb2312?B?MVUxN2lRS2JIdkt6em9jdkgwY2FEUUNkN0RIbElTVVAycmY2aU9tKzgvUVVs?=
 =?gb2312?B?eEZ3K3VtdjI3d0RBMnpkM0F0N1JHQnRzQituSnZwK1h0eHltZEpRVGY3WGxO?=
 =?gb2312?B?VlpKM1RIMGkzclJYRnBscXdjd3NYZUgrUkU0elVhbHhCT0x4UGQrYWFGQzJT?=
 =?gb2312?B?MERRcFBDTGs0RXpFYjlsUTB5ODNwKzAxQUw0Ylg0bjJKUEhnemw4QVFNOEhr?=
 =?gb2312?B?USt0dVQ1YmtZYUNycng5LzZNdzREQmQvaGtBT2tMS0xJdHA1bmFsOFZwUGdn?=
 =?gb2312?Q?DF8RNCvPstQX0ZcqHKOzrOBv79T1VIlImnOie/icm2cw=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4460.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 16667684-7b73-403c-72b5-08de2ccce107
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 09:19:19.3082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8119

UmVtb3ZlZCBkZWFkIGNvZGUgYW5kIGVuc3VyZWQgdW5pY2FzdCBpcyBhbHdheXMgc2V0IGV4cGxp
Y2l0bHkgaW4gZXZlcnkKaXRlcmF0aW9uIHRvIGVuc3VyZSB0aGUgdW5pY2FzdCBvZiAobi0xKXRo
IGl0ZXJhdGlvbiB3aWxsIG5vdCBhcHBseSB0byBudGgKaXRlcmF0aW9uLCB0aGUgcHJldmlvdXMg
Y29kZSBjaGVja2VkIG11bHRpY2FzdCBhbmQgYnJvYWRjYXN0IGJ1dCBubyBhbnkKbG9naWMgaWYg
dGhlIHN0YXRlIGlzIG11bHRpY2FzdCBvciBicm9hZGNhc3QsIHRoaXMgcGF0Y2ggcmVtb3ZlZCB0
aGVtIGFuZApjaGVjayBpdCBpcyB1bmljYXN0IG9yIG5vdCBvbmx5LCBhbmQgcmVtb3ZlZCB0aGUg
aW5pdGFsaXplciBvZiB1bmljYXN0CmJlY2F1c2UgYWxsIHBvc3NpYmxlIHBhdGggd2lsbCBzZXQg
dW5pY2FzdC4KClNpZ25lZC1vZmYtYnk6IExlcyBCb3lzIDxsZXNib3lzcHA0M0BvdXRsb29rLmNv
bT4KLS0tCkNIQU5HRToKMS4gT3B0aW1pemUgY29tbWl0IG1lc3NhZ2UKMi4gQ2hhbmdlIHN1Ympl
Y3QKLS0tCiBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcGNpLmMgfCAxMSAr
KysrKy0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcGNp
LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcGNpLmMKaW5kZXggZDA4
MDQ2OTI2Li5lZGEzYjgwZGYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnRsd2lmaS9wY2kuYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdp
ZmkvcGNpLmMKQEAgLTY1Miw3ICs2NTIsNyBAQCBzdGF0aWMgdm9pZCBfcnRsX3BjaV9yeF9pbnRl
cnJ1cHQoc3RydWN0IGllZWU4MDIxMV9odyAqaHcpCiAgICAgICAgdW5zaWduZWQgaW50IGNvdW50
ID0gcnRscGNpLT5yeHJpbmdjb3VudDsKICAgICAgICB1OCBvd247CiAgICAgICAgdTggdG1wX29u
ZTsKLSAgICAgICBib29sIHVuaWNhc3QgPSBmYWxzZTsKKyAgICAgICBib29sIHVuaWNhc3Q7CiAg
ICAgICAgdTggaHdfcXVldWUgPSAwOwogICAgICAgIHVuc2lnbmVkIGludCByeF9yZW1haW5lZF9j
bnQgPSAwOwogICAgICAgIHN0cnVjdCBydGxfc3RhdHMgc3RhdHMgPSB7CkBAIC03NTIsMTQgKzc1
MiwxMyBAQCBzdGF0aWMgdm9pZCBfcnRsX3BjaV9yeF9pbnRlcnJ1cHQoc3RydWN0IGllZWU4MDIx
MV9odyAqaHcpCiAgICAgICAgICAgICAgICAgICAgICAgIG1lbWNweShJRUVFODAyMTFfU0tCX1JY
Q0Ioc2tiKSwgJnJ4X3N0YXR1cywKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVv
ZihyeF9zdGF0dXMpKTsKCi0gICAgICAgICAgICAgICAgICAgICAgIGlmIChpc19icm9hZGNhc3Rf
ZXRoZXJfYWRkcihoZHItPmFkZHIxKSkgewotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDsvKlRPRE8qLwotICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2UgaWYgKGlzX211bHRpY2Fz
dF9ldGhlcl9hZGRyKGhkci0+YWRkcjEpKSB7Ci0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgOy8qVE9ETyovCi0gICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7CisgICAgICAgICAg
ICAgICAgICAgICAgIGlmIChpc191bmljYXN0X2V0aGVyX2FkZHIoaGRyLT5hZGRyMSkpIHsKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bmljYXN0ID0gdHJ1ZTsKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBydGxwcml2LT5zdGF0cy5yeGJ5dGVzdW5pY2FzdCArPSBza2It
PmxlbjsKKyAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIHsKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1bmljYXN0ID0gZmFsc2U7CiAgICAgICAgICAgICAgICAgICAgICAgIH0K
KwogICAgICAgICAgICAgICAgICAgICAgICBydGxfaXNfc3BlY2lhbF9kYXRhKGh3LCBza2IsIGZh
bHNlLCB0cnVlKTsKCiAgICAgICAgICAgICAgICAgICAgICAgIGlmIChpZWVlODAyMTFfaXNfZGF0
YShmYykpIHsKLS0KMi40NC4w

