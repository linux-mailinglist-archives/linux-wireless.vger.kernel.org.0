Return-Path: <linux-wireless+bounces-19937-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3994DA556C2
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 20:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C1D3A4FC4
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 19:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE511A2567;
	Thu,  6 Mar 2025 19:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="cpnGwevJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011036.outbound.protection.outlook.com [52.103.68.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462371A83EE;
	Thu,  6 Mar 2025 19:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289411; cv=fail; b=axdJhLXfUOdnEeXlABJ/33LNWGnBIlhuJ+rCVL5Tl5FkW+7mZ2UCJqBrUXoZvTzb7Xu7HaP0eujKmSTF1Sq+KVPrlz9OTS0xM7YSlBmh3/fr1ty4XyrtwA9njoWrBhEuDCKFF9JHo6J9QIRYokWSyYX+GoJ0J2PtKilcCrj79ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289411; c=relaxed/simple;
	bh=YV2hWexOlcOpdd3bUc3Ila4IuZ0fejd2RO2/56upR+s=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LKiCGUUHcqy6ZtO8Ml8WYAN1MwdeWR2NFAxsbogCSZenGkyt3UX9FhKt65jx0KfczbHqdA4hh+nLEL6I9JsxxdEle16IhsrSK3UFK60D7Beyks+OGzZh5Y3vNz/ODbDLVJpE/KBpJeYvGaOdCe+xqHXzHssSj2IbWB1yNUrtQ+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=cpnGwevJ; arc=fail smtp.client-ip=52.103.68.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYbjrhYOfjwt0ESuQZv4aoXFW9e9nGmXHGCogys/QWJPuQm23kPW6lNZSwXcMhjXFGfu6QBY1WXPYLUKX3wU+lGho/iFksOm/k/Ha81TA3Loueui2hNQsyUcovWJaB3L6B+l9SzANoNOWwxp262LG+/Y3V1H3MYIFyhuabM9Mu//nMo120XFjPWrTtTt5H0Rhvh+6mY2oLIeyAQcI88D3+pwrAWFoop6JHl5uX7x2V+U2/a1a1Xa68tuanLz9F6YcA8gbAsv1uvm+em4zBPK/jfu8VkdFCFMW5pekLEMQOvDprAC9I4jdvQjDRSbnhNe14itMD7pv5k6whVYXIEkXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YV2hWexOlcOpdd3bUc3Ila4IuZ0fejd2RO2/56upR+s=;
 b=jYQTVP9c0BHqMcXG4IMd8E1J0B7p3/b2asbtVEJhkzOvJtolJYRr+JaQV6dvFk4CMolJrDC9TFNQjVqWgh1ixt+YW83eFuWYQkUt4QlWgbgHSUxT4JuVgHNGave5vGJvR8Pm2NjmNuG/XI5d/mbldKxtIdGnroO8ZenjZCStECoY5wD1BTl6mBuPiXrLXnQHWvx1Eqvi4YKoVZBF9cAtQB7CuWmXRi/hMHYwknEFJOmyULT8Fd/G670NpFPYFFPytufv/WEY88OSKJrONbZXUrSqxgaKyeWQejhZhoYbVreUnYiJu9uPvNT2fDzO+/mAsXckdIgOKrFZhAF6IxtCcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YV2hWexOlcOpdd3bUc3Ila4IuZ0fejd2RO2/56upR+s=;
 b=cpnGwevJbtv2y8lO8A3BuI3QoyMx0uQb9nuEkhn8cVFP6CWqJWasqJ5lRBBa0YnT/QArmvuh4qJx9jYKM6ZQTA6fh24HF/7zTZ20Gr8dFgBJH1QGkAMyQOAYFO5/DtwDn2ZdnW2drX6beZQiyxcAG75GSeCG2IowH95tfUr99598U3qSAL03beyjS1ktwx9KTFzsVwZDwZZ683xwGTvUa+EmAStDs4OA+gO2ts1RtRFnlnwCuBWRb4ceW4XKKmkQ0pYxIKMOL/ePI05ef1CMLMXgR6RgfnbOxGhQt8hNBAiCLeWvrxzhkrEq3gZcQ75RCL6wuKNFhNiLDTzRFGN7RA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9910.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:128::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 19:30:04 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 19:30:04 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Sven Peter
	<sven@svenpeter.dev>, Janne Grunau <j@jannau.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: [BUG] BCM4377 wifi chip fails to suspend and resume
Thread-Topic: [BUG] BCM4377 wifi chip fails to suspend and resume
Thread-Index: AQHbjs4pg+XpkxhgKUWJTUlXgoC86A==
Date: Thu, 6 Mar 2025 19:30:04 +0000
Message-ID: <6BDCB30A-8D6E-4071-83FF-C7CFBFF39224@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PR01MB9910:EE_
x-ms-office365-filtering-correlation-id: b88bde10-4aaf-4680-24b9-08dd5ce54bf1
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|7092599003|15080799006|461199028|8062599003|19110799003|102099032|1602099012|440099028|4302099013|3412199025|10035399004;
x-microsoft-antispam-message-info:
 =?utf-8?B?STRsZmF6UDBONndWckozZjB3VVRlMklzTXpZM1l3TTRDejFRVVRRMjVoSDMx?=
 =?utf-8?B?d3JoanlUMDJEbzYvTUt6TkJDcnRrM2VIWEJtZFpqMmhzYVBxYU4zUVBQaEg0?=
 =?utf-8?B?dkxwelk4cXFRd3pCQ0VnWExvR0hrQXlodnQ0MGZwRkZoM0NlRlpxSmd2c0Vv?=
 =?utf-8?B?K3VNa3BuYXU0bTJ4TXlLaHM0Q3FCQzVjRVhzMTRURCt4VXlYTncydnNSbktG?=
 =?utf-8?B?QWt2TjIvdnY2aFgwd0MyTkhmdWlDeFBpcXh0N3JkVXpSRXlBdVBZYWRxKzZQ?=
 =?utf-8?B?YWFCQWlqeE03VGF2bU0vOEZ6SVU5RzcwOHVtR0txSm5Icm5LY1kyRE0zVnBp?=
 =?utf-8?B?a0N1SzNWMnBabnllZUZmaUw2bXNIZmFYamZkZUJpcmxkaWlmakVzQmEyRnRj?=
 =?utf-8?B?d0hZZjFWZENZc08zWlNLQzhLVmVhR0RzeXZUUDR6bStYR0VBWm5XT25KbExu?=
 =?utf-8?B?eTZxSXZWMnZXL2l2N2EwTFV6WGNqS1JoUUVZb2RPWDdYTzhBcTJ6WFMwenJn?=
 =?utf-8?B?WDZzOE1yWE1WeGpxalhDaGZhb0cvQ0FoNlhJbHNBMXk4MndQMWpDL0lhN2lo?=
 =?utf-8?B?aUhXZnFUcnluelBOZGhHVHF1cVh6dGVweHNHTUtGT1hCc0NTN3FBajh6TjdT?=
 =?utf-8?B?MGNJaGtOUUt4cXlENmdkWlhsYmNGcUdrYmx2K3R0V3kzNWNES1ZGNjFZZVVu?=
 =?utf-8?B?ZWczdE10d2M0MmIzU0JuMldtenVxeC94V0pmV2RpUDk4SWJvYWNqV2Q0S2VI?=
 =?utf-8?B?R0xCa2hSdFdoTEJzZXA5cUlmbUhyY3Z4b2dWcWowN1ZsMWlJYllSc3F1UzN2?=
 =?utf-8?B?RTVWdnZaYmY4OHQ4bElQMUZvMGJNcDl6V1pyOCtyU3dHbXNOc2NGM1MrcDZK?=
 =?utf-8?B?U3ZRSTBkQ2JBeE9lVE44UzBsdTd1UHY1dXZBVkJyelkraE45NU5CM3pMclRZ?=
 =?utf-8?B?OHM0OGRIeVhnV0lTclpLb0czT3dYcWpwcEVQZEF0QWJIZDFGc2VrUHJmNXRU?=
 =?utf-8?B?Z3A5Rm10WFJFd0JrR0pBT1NRZjRHWW9pTmNXQU10ZE9XaXFJS01hNU5QWE1D?=
 =?utf-8?B?bUt5MHdWU25vcHNENjFmZ1VLUTYxZW9rU1JkWHNnWmJudWk3NUdIK3RFbFcv?=
 =?utf-8?B?ajQ4d2pzSnNNd0dMQ0FtVUY4SHdXVHNpMUt3dC91d1R4TldaUzNONlREQTRn?=
 =?utf-8?B?azNNVGZBYi90MUs5UVluMkliWHhycGwrY3F3VGYwWDk4WnNqdXlDUGJpTi9h?=
 =?utf-8?B?eHNBU2RISDF4elhUYjIrUnRKNTNIWTVBb2NiUUF0TGorUTRUK2p2UVhwR2ND?=
 =?utf-8?B?QlNBQnBIdG9qZVRhUUpwdTFJQmZmVWhpZEg0M0pIbFg5b0tVemF6TFQwZ3E2?=
 =?utf-8?B?UHIrQ3lFUjBYdk85ZFRldU9oYnM3Tkhvd21hV1NNRFl3YTBNWHJwUVdKdDgy?=
 =?utf-8?B?cDRsSjBLQ1NFZEtzOTlzNElZNThhYzlyWnZmdXFoL0lidGRpdEpQWVF6cjI3?=
 =?utf-8?B?UlQ2bHVHL3RzVy84WVZxVHk3OU4wdDU3VnBRNFFhR3k4QmVJQ3gvMFRkYmM5?=
 =?utf-8?Q?DtIsUR59NjbHiMV520//owju7e0b9IA+XH3O9bmjm2R3zN?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1JaeVRBMElNQlFJb212RDR1Wll4UW0zREx2UExwM25IZ1ZaZ2JGdVZhcExD?=
 =?utf-8?B?R09hd1R1cDYvSTlrOWQxRmFoUVdhMkFwVDJ4eitSK21xYno5TDNycURXbWVM?=
 =?utf-8?B?aXZYelRleW40cGU3Q3EzRkppYjlWM0dKOXJrNER1WDROQTdEYnBNMHI5a1Fo?=
 =?utf-8?B?RlQzSFFVcFJlcks2RmJ4VEVjQ2pkb1Brc0dielgvU2JkMHdzK1pZSkZyeDVj?=
 =?utf-8?B?V2k0ZVUyUVJzd0k4eiswUmpYdlAvOEl5UVEwKzd2Ymc4bnhYWTd0R3FFa2NX?=
 =?utf-8?B?cjN3L0NEUExFdm9uVUVLZVRWVjY1a2E0OVNLc0FnaXZxQ1hTQWJkSFNvM1dR?=
 =?utf-8?B?b1FUNDVLekVQcmV0U2dTSzZGbzRYYjNyUCt3MnZ1OFFmVW55Y3NVQzMzTDVR?=
 =?utf-8?B?TmRYSFU1UUVNNXBDWFFDeFdKQ3dGRkgweGZjNnJPaVYxeDZXVEg3a1dHb052?=
 =?utf-8?B?MnFpWGZZcXRseXJkN3JRQ3NxWlUvZExsaVYvNUFJQzZTL2pUTnMvcmUvY080?=
 =?utf-8?B?c0h4bjdLeUtUdjlMUzdmWm9DcE9LMUVEWHpOQTVBaFUydFRyazJtWWExRVIw?=
 =?utf-8?B?UWpiblNTQzZVMGI1ck1Cc1Bqd2IrSkVWSldKOUN6YmtlOStPWUE3YmQvRFZG?=
 =?utf-8?B?eU9zUVdpNG5JODhXOS9ReVF1NjdZaEpVaG1zYjl2bFlncnE0NGdGWkJ3dkZm?=
 =?utf-8?B?aTU3U2xPTFJkZEhUZWZVM1labTN3TGtHbVVWTXM3VTBiLzQwdmZVOCt3aDdM?=
 =?utf-8?B?eDU4YlpTZGQ4NXBVbTZvQ3hmUW1MZTRXakc4c1lqV2JYQU1GZElTMGtWZ3Qr?=
 =?utf-8?B?bGJMUlF0NkpIQUt4MVdlMmZLeGFsejVXVlhrTmJaSGUwMitjQ1pUcG5xSlZk?=
 =?utf-8?B?WnBXQkxGVThVWTNTTU9sMFl4LzVsWjhVS1E0bWNwd1Q1ZElKSGVzZEM1M0FL?=
 =?utf-8?B?TWlCcHhhbWZ4NmFRd2d1TXpjWG53NEFCaXZvVEUzNkR0bWRIa283dFRSZTUx?=
 =?utf-8?B?VHZYUDROYU1SaTZaOElIRkhxN3RxOUtZb0JCRGZaRlZUSGQvQit1VGNVMkcx?=
 =?utf-8?B?QWczNFFXNGVJeTlxV2RSYTB2bFlRbmhGZWhCNlVYdlFnZER4SSs4MjVSV1FT?=
 =?utf-8?B?bGZudG5RMjZYM3FnNWhDVU0zTVE4WDEzejJpZGhNem5jUGtNM1lLa0NObk9R?=
 =?utf-8?B?b2R0N2N4YmlSTEtxOGdXNThxZmUxYUxac1V6Y1EyM3hHZE5YSUFtQWg0NHZH?=
 =?utf-8?B?VkUvS25iRnBGT25Lc0s0ZnpDVlF0V1ptYlpFQndoSTBWTStaMmZvVTV5K3U5?=
 =?utf-8?B?aWxKTVhZc3NUQUEyMEtkTEd3ODg1ZjVyNkp0bGtuUXVwMG5yT094VzRMNjNE?=
 =?utf-8?B?Z0tGQVZNbFNDV2FPdkZlWnROUWJYOERzeFltdC9OOUVXYTV3TE53bkdFVlBz?=
 =?utf-8?B?TGswN1U1Y2owRUNnUU9TWUJIVmpnU0piMU9JdktWVW5hRXRoeE5mazk0bEJE?=
 =?utf-8?B?ZWZERzFocndnZzdYT3o4MjFybldVL0JNbmpycU5id1BWUVRmelpHNjFPdHh1?=
 =?utf-8?B?elp0Zi9ocDNIazV3SG5HU3orME5VUUt4UjdaU05tV2FlU2VZQTlQb04yL2pM?=
 =?utf-8?B?REl5dndUZldudGd6a0U0ZlczMVo0bFUrVEtKRU1uUjM1UFBOeWZYd0huTTJM?=
 =?utf-8?B?TWhYTmNOenNuME1WVWFZaXdHRUJhTmJYenFGcTNoZXZqb2RWV0dIeEt1OUZ5?=
 =?utf-8?Q?YFEVqhp0r89njg4261nFTRa+3Ct32HVhElITGHO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC9D4570281D1249A81C0771B77DEF9B@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b88bde10-4aaf-4680-24b9-08dd5ce54bf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 19:30:04.7326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9910

SGkgYWxsDQoNClRoaXMgYnVnIGhhcyBiZWVuIHRoZXJlIGZvciBhIGxvbmcgdGltZS4gQkNNNDM3
NyB3aWZpIGNoaXAsIGZvdW5kIG9uIFQyIE1hY3MsIGZhaWxzIHRvIHN1c3BlbmQgYW5kIHJlc3Vt
ZS4gQXMgZmFyIGFzIEkgdW5kZXJzdGFuZCwgaXTigJlzIHNpbWlsYXIgdG8gQkNNNDM3OCBmb3Vu
ZCBvbiBBcHBsZSBTaWxpY29uPyBBbnl3YXlzLCByZWxldmFudCBsb2dzOg0KDQpKb3VybmFsY3Rs
OiBodHRwczovL3Bhc3RlYmluLmNvbS9SVGt0SGdHMg0KDQpXaGljaCB0aGlzIGJlaW5nIG1vc3Qg
cmVsZXZhbnQgSU1POg0KDQpNYXIgMDYgMTQ6MDg6NDAgbWVsdmluLU1hY0Jvb2tQcm8ga2VybmVs
OiBicmNtZm1hYyAwMDAwOjAxOjAwLjA6IGJyY21mX3BjaWVfcG1fZW50ZXJfRDM6IFRpbWVvdXQg
b24gcmVzcG9uc2UgZm9yIGVudGVyaW5nIEQzIHN1YnN0YXRlDQpNYXIgMDYgMTQ6MDg6NDAgbWVs
dmluLU1hY0Jvb2tQcm8ga2VybmVsOiBicmNtZm1hYyAwMDAwOjAxOjAwLjA6IFBNOiBwY2lfcG1f
c3VzcGVuZCgpOiBicmNtZl9wY2llX3BtX2VudGVyX0QzIFticmNtZm1hY10gcmV0dXJucyAtNQ0K
TWFyIDA2IDE0OjA4OjQwIG1lbHZpbi1NYWNCb29rUHJvIGtlcm5lbDogYnJjbWZtYWMgMDAwMDow
MTowMC4wOiBQTTogZHBtX3J1bl9jYWxsYmFjaygpOiBwY2lfcG1fc3VzcGVuZCByZXR1cm5zIC01
DQpNYXIgMDYgMTQ6MDg6NDAgbWVsdmluLU1hY0Jvb2tQcm8ga2VybmVsOiBicmNtZm1hYyAwMDAw
OjAxOjAwLjA6IFBNOiBmYWlsZWQgdG8gc3VzcGVuZCBhc3luYzogZXJyb3IgLTUNCk1hciAwNiAx
NDowODo0MCBtZWx2aW4tTWFjQm9va1BybyBrZXJuZWw6IFBNOiBTb21lIGRldmljZXMgZmFpbGVk
IHRvIHN1c3BlbmQsIG9yIGVhcmx5IHdha2UgZXZlbnQgZGV0ZWN0ZWQNCg0KS2VybmVsIGNvbmZp
ZzogaHR0cHM6Ly9wYXN0ZWJpbi5jb20vd3hiUk5BMFc=

