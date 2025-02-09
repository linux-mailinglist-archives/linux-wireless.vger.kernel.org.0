Return-Path: <linux-wireless+bounces-18671-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4529A2E02A
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 20:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A471642E6
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 19:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B04B1119A;
	Sun,  9 Feb 2025 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="EaYw22Oy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011026.outbound.protection.outlook.com [52.103.67.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300EF1E0084;
	Sun,  9 Feb 2025 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739128267; cv=fail; b=PDJ0b1HJZDBgnnWCQ3AzNf0qwgV6/nynP5a4JqpASdKteUd3YWz9m0xt+v9jQiBPbKSfI8QksSuhs/6EKVnQIuVDpqkraGnHcM5aAQVw17RM9Ag3C2qVyBPiIWwyhRhy8fft8CNXR3Pf/H4D8b/53ebOClBLkoO0XmzuTogAPMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739128267; c=relaxed/simple;
	bh=AjyoaoNxQBoxX/Wz6gK4rPx/wUVFAwOs2x4CKfQUPcE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rysElCvUovFKKu4HNC/R+ThryUGuNOQJkN0wdnhzIA3AQPs0PoUDVSlxaMkirpRBqXofuK2FqwEp9u2/YRd12YWE9PQGXv06AesTPM4jCImvPOUBivf2pJD8LKU2SoQRuFgVLdtox11U7biMJLoOTOFO6/+qXoNZAMN+jrnqOEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=EaYw22Oy; arc=fail smtp.client-ip=52.103.67.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gft1rBklz3TupW0mMuJNCkf3JjME+OFB9tJtAFQoSNq4rdtOAky6CDvAmQUpUbjDjkfDiYno1/82aTMk77DVMc0ZjHsq1G27LTfN1uqjQj13sZuc30QR4H8kRCFwFF7sfvdgdHY+ToeNMSRZp2MhYuPjLu3EEPmsPckAAll8g/5tviW9EziVJKBVUUt/dBTvmk2m8FF09eYSY9oIk+avLOElnZmPmu/E0eAj3rBlNE3Q6bkKrUVt704A2ahcG5I1gAte+YLCf5gm6u7V9Dfc/1LQwFv6BYp7VCsW4cZ61IR+zJzwJswozmFE7QuxdXOhcsz2H75GSJ1qnBcfEoGAdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjyoaoNxQBoxX/Wz6gK4rPx/wUVFAwOs2x4CKfQUPcE=;
 b=tWymmGUlhTFNXY6I9nVk394164e1rRWCLfjdnE7jBEiiB+Ydv4nHFam9867PNTPBeT6DrtrNoh1IqNLFkZyqpS1l6zlGmXkB57l7e1e6x9S+VcNhJLZ9/7n06OJGbOiuBncBBwL7+Ur4Z4kBFwA+ijYMMtzu7TSSxZMBOoOzagPQ/3kSNSqNxQa2psma4vfhK+h90R3RkQUBnK5wxdxTX/pWIAZd3goarvgc6z6X7IyzbctE37svogBLx/bs7OcT15ZhM7wC74Oy7s6bd8FSR1lBAWjL5PThv1SdJsE+9hhoBWn6pFLo+LwMn/F7910Xf7S0LTFT0kduko0P95aV3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjyoaoNxQBoxX/Wz6gK4rPx/wUVFAwOs2x4CKfQUPcE=;
 b=EaYw22OysB66z+PDlvBCHYIg9oKmvWzzDrtieFcKNkB3Pvj2laSHEVtDPFz4T8LsHqmdLlfpQzvwBiDo27CL8GFj+2kK1TxOrej01o63y9o4mcX/MEZ5NdEMk3TVlSWxuHGBmeENhtIWQ/vgzEo5HIh5vbXKL/9rk1pSkU+2DZBgjyWO5S/QYUQLBy8zNXHB5w8bRVz/4BexyuhILnhNI4bpSEPqhGdfyy2HwCRWWCuV7GUZQcM7t+jv5kg9NmTfBcBe1dw6prwJRMekRCdJ7hh5ivyoccFu/GAc8N+ur4lf58AouMDZP3F0Iz+52sgfNwdht5/Di4BpDrstaPf66A==
Received: from PN3PR01MB9615.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:107::8)
 by PN0PR01MB9431.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:111::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Sun, 9 Feb
 2025 19:10:59 +0000
Received: from PN3PR01MB9615.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8bdf:4c57:be81:7866]) by PN3PR01MB9615.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8bdf:4c57:be81:7866%3]) with mapi id 15.20.8422.015; Sun, 9 Feb 2025
 19:10:59 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Janne Grunau <j@jannau.net>
CC: "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>,
	"devnull+j.jannau.net@kernel.org" <devnull+j.jannau.net@kernel.org>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>,
	"brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, Hector Martin <marcan@marcan.st>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Handle SSID based pmksa
 deletion
Thread-Topic: [PATCH] wifi: brcmfmac: cfg80211: Handle SSID based pmksa
 deletion
Thread-Index:
 AQHa5hvoE5KcjEPn8km73NJrD5B72rIWoF0AgAAB5OWAAE2pgIAACSqAgAE7PoCBKEwqlw==
Date: Sun, 9 Feb 2025 19:10:59 +0000
Message-ID:
 <PN3PR01MB96157F71FB82CF36F3146ABBB8F32@PN3PR01MB9615.INDPRD01.PROD.OUTLOOK.COM>
References:
 <MA0P287MB021718EE92FC809CB2BB0F82B8BD2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <306c3010-a6ac-4f8a-a986-88c1a137ed84@app.fastmail.com>
 <MA0P287MB021725DE596EF4E5294FA5DDB8BD2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <1911d0fdea8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <ac9f0cb4-ba12-44f1-b32f-d17e24fe426a@app.fastmail.com>
 <9ed78539-35ca-4643-9a38-ac2c0379f395@app.fastmail.com>
In-Reply-To: <9ed78539-35ca-4643-9a38-ac2c0379f395@app.fastmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9615:EE_|PN0PR01MB9431:EE_
x-ms-office365-filtering-correlation-id: 9d8400c4-5847-46cd-4b97-08dd493d7cbd
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599003|19110799003|8062599003|8060799006|6072599003|461199028|15080799006|440099028|10035399004|3412199025|102099032|56899033;
x-microsoft-antispam-message-info:
 =?utf-8?B?NHpnWFVzZ2E0WU9RYzFZT3pqeVVuNWhwNjhvSmZvbWJVNnc2Uko1bFlobkxL?=
 =?utf-8?B?My8rRERpb0RsT1JKYmVsNXVDaXBHL3lNYVNyZHkzN2o3WGNlQnB4dG1jcm1H?=
 =?utf-8?B?REo0T2k4UkZLNTdmM2RrWmdXUldTaVBUQndFS3RKM3Z3em1WRDdhajdEQWpq?=
 =?utf-8?B?blFScTMram9uUVpmSU95ckJ0MVlNd2VkMlJRYWhpNmE1NVZLRjczN293bUZx?=
 =?utf-8?B?ZnB2eGJwVDZSUE1pS3ZGbjlhalM3WTVwbUZkSG5CTHc4cVhKN1VMSWg5a3Zh?=
 =?utf-8?B?SGRRQWZlNzQyblUvWHZ2MFJFUjN5Z0toWVdRc0VIQUJCZHdTSEliSmF1amgv?=
 =?utf-8?B?QVFWaFlObUMxbDczekxVNFFXanZzdTZzellPRi8vVnJHaERlMkYxQ0g4ZEhw?=
 =?utf-8?B?VHVRUWRIOGVNaFRDczZXbnhVbFYwL1ArN25KcHlQRGxuWXhucHlaTVcxWjd5?=
 =?utf-8?B?R3YvSnA3czVtSG9kbGR6NlVUdHJoMnVkQjBzZlF4MFl4ekkrNk16U1RWVTlD?=
 =?utf-8?B?TUVtVWJPUFVQQy9LZTJxTHd5bkQvMlJydmtiTVN0V1ExYkZVRFVSYVM2MTNO?=
 =?utf-8?B?SDNNWUg4dzl5ZTVRdWJTVTlEWUhzdjVWRkVlMCsxTzRhZmVpQnNka0Noa2RB?=
 =?utf-8?B?U3FocDlNTFdVUTBjSm81dXA5YlpIa0hCYks0V05FcmNJcS9sYWd0OHBjTWs1?=
 =?utf-8?B?YUk0VjZwdllnZ3JvZTRCOWJsbllJcjZlOWxBelYzamZZUk95ZkNCemltSktt?=
 =?utf-8?B?NE0wa25nUEUzT3NNUU5wc0dxM1pvY1JMaytWdW91c3F4cHRZLzgxemRFbWVj?=
 =?utf-8?B?TjlQUXhIWldCWXNvV3dHemk3NFArK0pXUWg3Ym5XNkJ3MzVJM2VZNFhMdDJz?=
 =?utf-8?B?Qi9nRllSSE1SNGFwbmIrbUZVdlVhdkNENzY1WmVSRHcvK2xibG9nMlg1YzdX?=
 =?utf-8?B?bmR0M2pDd1BFaTEwTWc2YXZDUzBzK1Y1d3FNMzFEMUFnTmE2dVg2dCtjS1Fl?=
 =?utf-8?B?TGtJOG1UQldOVnhCS05lclFtcGxjUXhCcDlBbEdDemhjekFLcHA5bXlsYU5n?=
 =?utf-8?B?MjdMeGZ1Mm1CR21GdVFBRWdJS1dON0U5dG1SL0VzeDZ6bWJpeVlwdlowUUph?=
 =?utf-8?B?NEF5QnNOZU5CVXBQRUU5b29Bczh6NVBVS0V2OCsxbVRhMHpEenp4c3lGTWc5?=
 =?utf-8?B?bGVFY3kzQ3o0NC9sWUg3NGErNEgydkdNN0pnU0RyNXBic1RXQ2xGaU5veHM1?=
 =?utf-8?B?YVdoYkZyaXhsYm8vNVF1elFhdFgvNlU4dmppZGNsSU5aVWpud09WUkR4Smht?=
 =?utf-8?B?akhUOHl1N2VXY1U1UVcwQ21XYzM2WkZyY1pha05tYlpEN3JFK3MzS1NZblBB?=
 =?utf-8?B?MkFoSGhKaE81Q0hiRUQ2V1NranpOWDVHS2c4RVY0OWt3VzFQQ05rR1BweE53?=
 =?utf-8?B?NkNLeHIzbmNZVkFpQk8xWUJzN3RvYnA0dktJdml2QS92ek1kTmVyMGFlOFpI?=
 =?utf-8?B?WDF3OHBIRWVObnYxUStzWWkxY2xKVVhYUW5rYVJHa1ZCRkxNR0RQZ1lsUFV1?=
 =?utf-8?Q?AEB1zs0mDYmqVEdV+inUSGVT4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SFdBV2J0WmJlT3BqWndiTllQaUtKaHVmcGxSZ1JTZi90NkVzRzRxQkRiSFFE?=
 =?utf-8?B?UVY5cDRzRGpQMkFLM0l1akErZkhOcW9Dd2ZxL0VndlVqa2I2WTVxN2V6YVlj?=
 =?utf-8?B?c3FtU0pQR3lmd0c0TUtSL1BFeTNWSUVaTGpYWmt5T29EVnNNRWNwdmZ1RVd5?=
 =?utf-8?B?QWtSM3R5UFpxT2NEMVB4cU54SC9ueWlBZ3ppZzMzYXM3U3QwSEMxTGFuNklJ?=
 =?utf-8?B?Wk5LYThOazVBYWlIbitMbTZ4cnIzTzBmdTI3YjFrOEwyaG9CMDllY2JEbVNu?=
 =?utf-8?B?QU9iQ0UyR0dTbkdTOTBWTHNJYUJsdlFOU0VCTDVoeVljaXplUCtIZ0ROdzh5?=
 =?utf-8?B?LzY3ZDV6aENjblRuK0NVZ0JoSW1vTXNnc0tqblR3a3hySDhYRk9wV2VEbDhU?=
 =?utf-8?B?SmdwK0crTUlxUFhheit6YVpVU3RZOTYyT0RUa2JDMG9WVDNJY2RjMEZoQ3pv?=
 =?utf-8?B?NkZ0blVZSE0vbWgvK3creElDQmNSZHk0MUVUeDl3d21Cb29MRUJwK1lzT1dK?=
 =?utf-8?B?Zi85bFJ3bE05UXJYdW5obHo3UmlwUEsrSnA4U280TWRmVStNaDU0N0xtbjFS?=
 =?utf-8?B?eXBmQ1JaeDliVEloUSt3eGJkQkpZMjVxdGN5SXFTd0Zlc3F1SGdhUjNHeUEv?=
 =?utf-8?B?dXpPNmhYMU5iTVo5Q2wvYVBqQVhBRktmaVhGSWxnWWU1RUhVYUNYVGVYNjdB?=
 =?utf-8?B?NlI3c0l5RW5YY1AyTFhqdVhwVS8zeFdXS0pkaFpxRHd0QjloQUFWVEJrMSti?=
 =?utf-8?B?N0Jpa3F1cnJXMGxLYXVQak91ZkVwanJocHlYVHNDeTVNaHZEQm5DaGhaYi9m?=
 =?utf-8?B?YzQ5Z0NVRGRuc0VSeWFZRWFVSHNSU3VKN3dlV3BraXBNLzFKNnBHdktOcUFh?=
 =?utf-8?B?YUlkU004c216MUV0NXNoTWJDN0ZiQWxybmlVWGNrYWc2TWxneXFLSmhmc0tu?=
 =?utf-8?B?L1NoRHNOZ0RTdDBEQjl3WWlyVXZIZTZ1Skk2ajZDeDFac0htMkFXUWs4b0Zn?=
 =?utf-8?B?aVVPUzAzZ2lsUnQ3OThRUThoQlhzeGxXVkU0S08xTUM2SUR6d0k0dmhhRW53?=
 =?utf-8?B?TzlhWUdaL0pUTFJRbjBlaSswUkFEVTJvZkZmQWQ3RmVJaTFUMlVob2tucnh4?=
 =?utf-8?B?NmR1VFBnaDFZMjU1R3hnRnRaWlhXWThMU2dmNURHZ2tQSVVHQUtvYjQveVRO?=
 =?utf-8?B?emI0TlJ3ZmdqanhibGdiUUUxUXRUZWdpOG42WFBNWk96R29SSDY5MFZDTitQ?=
 =?utf-8?B?N0FRcWxUcTZla3p5UG1LMERsdUFqaThFYkwxR0RKZTBjcVhNcDlhb3N4OTRq?=
 =?utf-8?B?TzFHVm9Sek1FQW5NUEszdGpyNEJGS0dyNGFPWDhPZ01XSjZtR3NrbHREWE1a?=
 =?utf-8?B?UlI0MVZBWUcwbEpVZXYyalptK0dPa092ZEwrZXJ4ZjhQZDhSZGt3a0Z6S3Q0?=
 =?utf-8?B?QTdNb0pYT2pJd1BDTVZma1FDUjNVRlJmSlRQMkxIdmpUM2NlQlVyV2ZYNW9K?=
 =?utf-8?B?Ny9vRU15aVBYTXdUUG1Gd2R4MGFXdGZyVko2WUFTV0ZuTHNFQ0h1WFFnTWNs?=
 =?utf-8?B?dUI5YkpaRlp1L2VnUzhiYXBOU0xuSGtwZzAxVit4NFJhYklYcG1VbFhZR3pE?=
 =?utf-8?Q?ajtCPmdbR9KXPqQj+hlPCg0kEyFes4xp38/uuijUOk20=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9615.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8400c4-5847-46cd-4b97-08dd493d7cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2025 19:10:59.0987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9431

SGkgQXJlbmQsIEphbm5lDQoNCkV2ZW4gdGlsbCB0aGlzIGRhdGUsIHRoZSBpc3N1ZSBzdGlsbCBw
ZXJzaXN0cyB3aXRoIHdwYV9zdXBwbGljYW50LiBTbywgd2lsbCB3ZSBoYXZlIHRvIHVzZSBicmNt
Zm1hYy5mZWF0dXJlX2Rpc2FibGU9MHg4MjAwMCBmb3JldmVyIChub3QgdmVyeSBpZGVhbCkgb3Ig
ZG8gd2UgaGF2ZSBhbm90aGVyIHBsYW4gaW4gbWluZD8NCg0KPiBPbiA1IEF1ZyAyMDI0LCBhdCAx
MTo1NuKAr0FNLCBKYW5uZSBHcnVuYXUgPGpAamFubmF1Lm5ldD4gd3JvdGU6DQo+IA0KPiDvu79I
ZWosDQo+IA0KPj4gT24gU3VuLCBBdWcgNCwgMjAyNCwgYXQgMTM6MzcsIEphbm5lIEdydW5hdSB3
cm90ZToNCj4+PiBPbiBTdW4sIEF1ZyA0LCAyMDI0LCBhdCAxMzowNCwgQXJlbmQgVmFuIFNwcmll
bCB3cm90ZToNCj4+PiBPbiBBdWd1c3QgNCwgMjAyNCA4OjI3OjA0IEFNIEFkaXR5YSBHYXJnIDxn
YXJnYWRpdHlhMDhAbGl2ZS5jb20+IHdyb3RlOg0KPj4+PiANCj4+Pj4gV1BBMyBpcyBicm9rZW4g
b24gVDIgTWFjcyAoYXRsZWFzdCBvbiA0MzY0KSBmb3IgYSBsb25nIHRpbWUuIEkgd2FzDQo+Pj4+
IHVuZGVyIHRoZSBpbXByZXNzaW9uIGJyY21mbWFjIGRvZXNuJ3Qgc3VwcG9ydCBpdC4NCj4+Pj4g
DQo+Pj4+IEFueXdheXMsIEkndmUgYXNrZWQgYSBmZWRvcmEgdXNlciB0byBjb21waWxlIGEga2Vy
bmVsIHdpdGgNCj4+Pj4gQ09ORklHX0JSQ01EQkcuDQo+Pj4+IA0KPj4+PiBJZiB5b3Ugd2FudCBs
b2dzIHdpdGhvdXQgaXQsIGxvb2sgb3ZlciBoZXJlOg0KPj4+PiBodHRwczovL3Bhc3RlYmluLmNv
bS9mbmhIMzBKQQ0KPj4+IA0KPj4+IE5vdCBzdXJlIHdoYXQgdG8gbWFrZSBvZiB0aGlzLiBUaGUg
aW50ZXJmYWNlIGNvbWVzIHVwIHdpdGhvdXQgYW55DQo+Pj4gb2J2aW91cyBlcnJvciBhbmQgdGhl
biBhbm90aGVyIGludGVyZmFjZSBpcyBjcmVhdGVkIGJ5IGFub3RoZXINCj4+PiBkcml2ZXI6DQo+
PiANCj4+IEkndmUgYmlzZWN0ZWQgdGhlIGF1dGhlbnRpY2F0aW9uIHRpbWVvdXRzIGZvciBXUEEy
LVBTSyBhbmQgV1BBMy1TQUUNCj4+IChhbmQgcHJvYmFibHkgZXZlcnkgb3RoZXIgYXV0aGVudGlj
YXRpb24gbWV0aG9kKSBkb3duIHRvDQo+PiANCj4+IGh0dHBzOi8vdzEuZmkvY2dpdC9ob3N0YXAv
Y29tbWl0Lz9pZD00MTYzODYwNjA1NGEwOTg2N2ZlM2Y5YTJiNTUyM2FhNDY3OGNiZmE1DQo+IA0K
PiB0aGlzIGlzIHJlcG9ydGVkIHVwc3RyZWFtIGluDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL3BpcGVybWFpbC9ob3N0YXAvMjAyNC1BdWd1c3QvMDQyODkzLmh0bWwNCj4gDQo+IERpc2Fi
bGluZyBvZmZsb2FkaW5nIGluIGJyY21mbWFjIHdpdGggImJyY21mbWFjLmZlYXR1cmVfZGlzYWJs
ZT0weDgyMDAwIg0KPiBvbiB0aGUga2VybmVsIGNvbW1hbmQgbGluZSB3b3JrcyBhcm91bmQgYm90
aCB0aGUga2VybmVsIGFuZA0KPiB3cGFfc3VwcGxpY2FudCBpc3N1ZS4NCj4gDQo+IEhUSCwNCj4g
SmFubmUNCg==

