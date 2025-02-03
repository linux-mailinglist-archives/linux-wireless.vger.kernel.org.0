Return-Path: <linux-wireless+bounces-18302-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC74A25C06
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 15:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E90E1883D4D
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 14:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA721FF1CE;
	Mon,  3 Feb 2025 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=syngate.onmicrosoft.com header.i=@syngate.onmicrosoft.com header.b="Sc3P7coI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PR0P264CU014.outbound.protection.outlook.com (mail-francecentralazon11022134.outbound.protection.outlook.com [40.107.161.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53711F94D
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.161.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592189; cv=fail; b=pMLO4bl3E795yJUkyMObvhio8jfppCsQDJvUCPCsQls6yImU0dTgKtsG6Zj68GiYYSIrbpZqBBPzwNEhylYvA8T+c4IptZvDg/uZpnAB+NZ6o0qdi4TKYXlF7ekhDayfMBq/7XJCmPy2JVM85G/VzlWHzYkH+23zjklOvx6Y8m8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592189; c=relaxed/simple;
	bh=N37WbehlaI4KdV9NC2oAYqfiL2sOuPZngzLM/tLKi7c=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=klIgmbxgGLhvvWR/fyPbndYMI+IdErT3PkFACNzP4yrCAWA5arpCikamBzuoR1p3zVbWQ48tcjUvNyCYe7TcU+Rw+8vNfciMw4iy6myAoazS/vY62zPeNVrSnaKJEKWbVs7Cyrn7CbkL7RJw5P29ICrpyNULglKrVzXg13fiIR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syngate.fr; spf=pass smtp.mailfrom=syngate.fr; dkim=pass (1024-bit key) header.d=syngate.onmicrosoft.com header.i=@syngate.onmicrosoft.com header.b=Sc3P7coI; arc=fail smtp.client-ip=40.107.161.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syngate.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=syngate.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=of08+OLMdkEj4R9pOJ9y1R5SqKa3JUnHetAa0G6yObs3R86D3uGEIFb2W2leGBvOWkus2ZojtG2NFitJ46NHmR3acCpS6yz8VQJ+0VFZMVQmig9P0NRh0AoL3XqJwJqBtOb7qTl1GJCGNpOiDC03Zpt/HtasfCeTeEkP4u2AqFFf2VA7boIWz1S1R1AseDJRdB/AQ2bUgC7jVXx+9R9MKdNUistGTDMiRUQi+rhE/BwG08L9aU8nhvtHMlbkoscIzngHHtFNJrH6RUVlCcPgfVgC+r7/PFBH4YNm8kKlVPWW+DAxu1hM062wjRoQ9I2SQ9lNb+xzAW2Zv1K9kSnw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N37WbehlaI4KdV9NC2oAYqfiL2sOuPZngzLM/tLKi7c=;
 b=mb7flvgnZHeCP0g9rCWgi3RIW7HmDUypj/bQPJ0xl9Z19C1IF3A0W4lzxgd0210FSb4FLREEaL2tqpxB9J2+2iWa7/bOjIs77YoQNC4VGqU2MD0XewKCQbfhLjIkrM8eRz6qUluazrQGkh/8T8Rg0PGI6uD20JWoZvdDpql4UPZzbwKKjNkjW6kaoMbxxvi2U6gcntEX0mzA9rFRl0hZHjJJFamA8DS2X4Bufu6sKaLO50L9t0ggrbc63DIGAx3F1aGyP3OuebMXic00OfSiafTiaxJNiEbHZP3utj9St9S6jmjIfdghApDoDm7kHLclpoQec489raiNWtVnAVI4qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syngate.fr; dmarc=pass action=none header.from=syngate.fr;
 dkim=pass header.d=syngate.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=syngate.onmicrosoft.com; s=selector1-syngate-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N37WbehlaI4KdV9NC2oAYqfiL2sOuPZngzLM/tLKi7c=;
 b=Sc3P7coI03Hf+kQoy4S8s3PLYcThJJHFxsv8SNgBa3fj6VPzhYxGJq0jfhilAdP3fVLOLLn9lsYjHACNAetAoij2d6DpXGZLsUCzWzK+6LYbHkUknY8798FljtHDwYmVX9bfbx0CGahKrKV/A5eB12Y3741nLYprM/q3lwBeE8Y=
Received: from PR0P264MB2968.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d7::18)
 by MR1P264MB2372.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:35::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 14:16:24 +0000
Received: from PR0P264MB2968.FRAP264.PROD.OUTLOOK.COM
 ([fe80::920d:1f7c:2939:b5d4]) by PR0P264MB2968.FRAP264.PROD.OUTLOOK.COM
 ([fe80::920d:1f7c:2939:b5d4%6]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 14:16:24 +0000
From: Tistou MOITA <tistou@syngate.fr>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: wifi radom disconnects
Thread-Topic: wifi radom disconnects
Thread-Index: AQHbdkYhi+DCpSTEeUSJPfPVpOpGsA==
Date: Mon, 3 Feb 2025 14:16:24 +0000
Message-ID:
 <PR0P264MB2968C37DBDB24BD8151F8162B3F52@PR0P264MB2968.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syngate.fr;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR0P264MB2968:EE_|MR1P264MB2372:EE_
x-ms-office365-filtering-correlation-id: 373bc263-8f25-48b1-0735-08dd445d5715
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c3ArMCtzcFFCbVYwYzNMMHZFMEM2ekJBYVFQQ3d1WXhsZjJrdkJyTVVPVUNX?=
 =?utf-8?B?blNtOExiOFBiOTlUS2FkbmR3SmRKOE9HMHBhS3VmdkF3Njd0YXMzUytScUd6?=
 =?utf-8?B?bUFITkZrUklzcHJieGtMcHRHMS9NS3ZJdzJ6TmJkMWJjSmFVSEcrVVRjQzdK?=
 =?utf-8?B?c1RMVERkNWpTYkk4RlNxcTJhb1pWWWdCQ1JFU3h0THl0UlpDQzhVYmRPZ09H?=
 =?utf-8?B?YmxoT0wrRFk0c2hhV1ZMNUw3RTFCa05XUG93QysvMHJRRjNTNjRLY1NMa3Fl?=
 =?utf-8?B?Q0YrVzJMOWNidTRJN0VXaTRYUnNPdzJGait3Qk5FVnZhUndzb3UxeHZCZjdn?=
 =?utf-8?B?U0dBekdNUldmUkZwVGwxbHUvZHA2WGJiZTJnT1VqSGJiZFB3bm9LZFczUk9U?=
 =?utf-8?B?OEoyQlRtaHVHVWRvODRGWHRIaVI1VnBUeVdzSENoOVRoLzBVLzRMdFdHS0FB?=
 =?utf-8?B?MmJYSDNMVnBVR1M2aFlpNzV2M1ZUTWVGekJxZzg4Wk5zeG5OckIrRzBUbk1q?=
 =?utf-8?B?VkhZWHBEUjRSOUtaazR6RWt4SkFpdEVXMkpaSHhwQjdBR2hvckg0TVVQcExu?=
 =?utf-8?B?algxa3FXcjgweXhMSDgwRnBIZXZ4OU5DWUNBTnJ1ZE94aFRRMVl6c081OE5u?=
 =?utf-8?B?TkthVkt3eURkMXlCM2lsNlJaZW5jeG5nZFVGdFNYRUdiaFYyODdsZ0pTWUQz?=
 =?utf-8?B?QXdkL1NXZlkxZEIveGh5N1RwWWdYbjZubnZ6YmNXNWFvbG1rTVpHMGlUZXZz?=
 =?utf-8?B?NUJEWVJGSDNjQU1uc0F0aG52SVlQQzZVQVV3ODF4TWlRM0R4YXEwNTB1S2E2?=
 =?utf-8?B?UnYwQlZRaVVLSDRoMlhackRmQVlyUlQraUQwblNhSjllNGdkOGZJWlB3ZGZn?=
 =?utf-8?B?RlNuOUIzcmtibGdPVjNTc0tCbGRCK1BpMnphMUI1eSt2a2J1ZEhySEhPM3BM?=
 =?utf-8?B?QStHL0ZVUTZaYVpDUDNpejBKQUd3aWF6YTZ3czVKZGtlNEI4WXl4NGJQMERo?=
 =?utf-8?B?cFBTNnV6cTA2ZFpIQ1N5Q3JYSDc3TndPaTF0THh1ZCtlUWxHV1FIM3lyWmFI?=
 =?utf-8?B?bm4vZ21WQTZGZWhIMkYzdEtvMldJWFdQZWRvRmFYckJKMXNHcmx0Q05PQWVB?=
 =?utf-8?B?dlVvWWxSTDkvTjFVcmhiTHd4eE4ySzY4TW1mSXlISDZOZ2x1ay91US9ldkgx?=
 =?utf-8?B?TFlYbVVBbDA3Z2xwQzlIeUIxbVI0dG5KeVV6R3o1WElmTm42bjQ5K1Qwa0hL?=
 =?utf-8?B?T3ZobEhLVEExWW1KR1dGRXdrZFQzU3Q1Vk1DMFBoNnJKcG1MYVJyTFFWZTRn?=
 =?utf-8?B?THg4YjEyV0hlM2gxcTFKNTRrODNRbUxPejRjU2NYZFZGNGxBNjd4akR6bHNy?=
 =?utf-8?B?OEpjTnhQeW1maDBiSjVnZmZvT0grdEVwWHl6RUJPYXYyMitRbVZBTkpKUUM2?=
 =?utf-8?B?TGNvWDhaWWk4M0IydG5Pcm9jY2RsR3VuS2lMYlBwMHNWSVFnVnVQYTBBaVBI?=
 =?utf-8?B?ZVdaVEZkY0p3UWQvN2R2QUdkc1ZNaTRpRERsRmh6NUNxR2RtVUZqekNWcDRu?=
 =?utf-8?B?RlVEclgwQ0hhMm83S1pGc1hpdG01YWlteUlrelpCc05LQkQ2YnJpQzdvNEE1?=
 =?utf-8?B?U3ZDd1lHTmxQN3lSWDN5RXE1alZpcmxVMXlrOWlQdnZnM2lRczNpbzVBVG5a?=
 =?utf-8?B?eVk0aUxUYjd3N084M1VlQjdIN0NITndKWUw4b1JsRmlpSVkwTXdCN29sZjNL?=
 =?utf-8?B?ZmJzSTVyNEgvM3M4bkZ4bzM4TFBOd0c2cHdiWnJ6akRjR1FiQTZueUpUdGJi?=
 =?utf-8?B?L3VwbEhZZ05VSm5pRGpUWHp4ZDQvVW8vRm5KQmU3UldFazNseDFuNE5EakF0?=
 =?utf-8?B?TmtiSnhUZElGc1RlajkwSVlHc2QvNTRGNDVaeThLUm01Qk5UbHJnYnBzbjRH?=
 =?utf-8?Q?pWfsdCd5IGFelsPvzj68+H2cbwqJgC4q?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB2968.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDgyU0dIRjhyQ2RyckVaRmFnYlI2Ri9SeHlJdUUweTh2QTRBMTJTb3YySjEz?=
 =?utf-8?B?VjIya0JOZGIwS29UbGd3RXJCd05TR25PQzJiWUxtWm5nejQvVXdlQWhuK0l4?=
 =?utf-8?B?L2FsdG9xb001aU0rb1VvRVRoOE9ubURDSXRmQU9UWExVSzRFQ0Z5T1IrVWRY?=
 =?utf-8?B?MUdBQTJTRXFtOHpiT2hsM0ZjbFF4enNkSXdQQWVDUWtscGpWRzJQVTAvcFJH?=
 =?utf-8?B?bnBsL1gvUFlhbGNNWGNiRTg3bWowTXRFZUs1ZkJJelhHN1hkVldlaHdUSHJR?=
 =?utf-8?B?Q2t2ZjRJT0dmSW1XMXZpSlBybGVZNHRFM09wZzNqV2RLYVZRanNwWlhGV1FN?=
 =?utf-8?B?eDAvMXNHV1JlS2NLazBsN0VMOGFsQ0Q2dWl6RjB1K0Z3OHNnNFV0eUEvYVl4?=
 =?utf-8?B?d2FBRk01UlNUcVFXdWtpcFQvbFBkTjBoTU5KanRCMHBpeHdxaU5QZlVJL25h?=
 =?utf-8?B?TFNDSkRhU0hOTXZtSTh2SkRUcGFZem9LdzJQaHZuNG1uUzJsZGhra3RyQ0Ra?=
 =?utf-8?B?cW9GUVFBdGdYaXlZR1IrV1dRQStaWFJNMkVGZFBUYmpvNkdIc2xPTDdLZllG?=
 =?utf-8?B?cXhvMWhhTHJVR3RDRGdSQjRyQk8zZ3orc3BkbGxVaEc3WmZDbXZneVExWjhn?=
 =?utf-8?B?SXBnK0txYWNVSkdxMmhmb2wxcWRFU0dsYUJZL3I0SmF1ejBLa0d4cERoankw?=
 =?utf-8?B?OXZIUnd1eGdlbXp2b0JmZWZxQk9vVldsY3lROXFtZk5IaHZTK3VBSTFQWFF1?=
 =?utf-8?B?Q0VIS0tNWnpYSkR0d1FZZ0hTZlZPblpQbXQ0RU8xUVlpV2EwU1pPMDFSWnFF?=
 =?utf-8?B?aWpOa2RocDRnZldPb3FhMmJrbldhaVYwTUVHUEd6NlJOTWpQWi9VeXFMZWYr?=
 =?utf-8?B?UmVRQnAyOEFPMTBuWUxERjg3cHN2WXVvVGxWNEcxODQra3JiUjFueTVIcTlU?=
 =?utf-8?B?SWJOWVk0S3BpWDFlcEoyTmdYblBJa1M2anVUd2ZlWllsbVRHd2s5VllHTHpj?=
 =?utf-8?B?bHpuRnp6bVpMbU9Sa2tBd2c4RVR5dEVucWJCTEZSbVBXZTZ4dWZTSk8ybncv?=
 =?utf-8?B?NlZpTjVsZkNKcVJPT3Z3UE5VWGhkSnFMakkrR2Vhbzg4Tm1QNzhMaEtRdnhw?=
 =?utf-8?B?K0pEVHN5UEFWd29FdjArMmFpSFRxMXVMNU5qajFyaWZvdnpvalo3RzF2ak1I?=
 =?utf-8?B?U1F0cFZZc3UwODh0WmhsVHh1bVcyMXQwOWN3aWMwSnJ1UUI1MVpzL3A3RXZr?=
 =?utf-8?B?S0l1TnJnVXRGWDVvWmJyTEwwVlVpZjFkYXJPb1RKRGhHUTMzSldOUmlHNDZP?=
 =?utf-8?B?Y1YvOXlyT0Qrd3N2cldER0xIZTBSTGM4Y3Y1ZXBLN1RuTnFNK0hzbEM3c1Nz?=
 =?utf-8?B?LzdjcklBbWl2TU94Q3BoWUo2L3hTL2Fnc3RvMFlBeUR2RHUvNlNmOEFybERi?=
 =?utf-8?B?QlRIZlMyb1FGN1dobDBXWS91Slk2MUZVNWRwM1FBUVpWelFWTysvM2wxREg4?=
 =?utf-8?B?U0plSVFCUEpEdWVjeFY0dzlhNHBZdmgrWk9Nck92U2l0L1BBUHBLOXZRR0t5?=
 =?utf-8?B?bkNVL0pCRlEvNUNGYW0yTHV6RWEwS2xEZjdNb0RsckxkRmtzWUhhcEhIMHM1?=
 =?utf-8?B?UXB3eXZoZGU5M1o1eUZqVHJxL1NxTzBaT3pvNkJCQ2d1OEhiUXkxU080MkNH?=
 =?utf-8?B?VUlobW5wWDYxR1B4VDJSR0Zma1RpUFEvN1hWUlk0V3dpelRBZmc0S2Q2cGlL?=
 =?utf-8?B?bW9henJPN1BmTDBLNktUQ3E2RkhSelBRSWxKR05KV2szamFheFlONkF1dG9x?=
 =?utf-8?B?WDFvTG8vK2F5ay9wdHFtYjRPNyszWEpyamRZUUVUbVRkakFkUGxHSUJzN2hZ?=
 =?utf-8?B?eXVqN3FYT3c4RnZFbWVmSTIvRW5DSm43MVVsdlhSTWt4TWsyR2xBK1NuMWkz?=
 =?utf-8?B?UHJuVDNJeEVsZ3NoTmhlMVYzMmE4djVndGY5MVQ1Q0JscGRwNmltd2thR0ZL?=
 =?utf-8?B?UUxWVldZcUREckhqSGJMQzkxOXoxeXJXN3BsaE9GNEV6V09rQTdVaEY1VnJB?=
 =?utf-8?B?Y2lXdlYrM3JOaFkveTIzcUZOV21DSUFTUGF3RTVWaUxyZ2VrWlUyeDRQZGh2?=
 =?utf-8?Q?MYcU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: syngate.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2968.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 373bc263-8f25-48b1-0735-08dd445d5715
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 14:16:24.0045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3c3294d1-4175-4d1a-b0b9-845520a5fffc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rzD/yrHS4EKhURiPvOmWWA4JMJ7r9ZNEVtfL6eX1psh8dzBQ94l972uvIdWPRara1P9JDvKbE1eWHt9QknNAog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2372

SGksCgpXaUZpIHJhbmRvbWx5IGlzIGRpc2Nvbm5lY3RlZCBvbiB1YnVudHUgMjQuMDQKCnVuYW1l
IC1hCkxpbnV4IFBDUC1RVUlNUEVSLTA0IDYuOC4wLTUyLWdlbmVyaWMgIzUzLVVidW50dSBTTVAg
UFJFRU1QVF9EWU5BTUlDIFNhdCBKYW4gMTEgMDA6MDY6MjUgVVRDIDIwMjUgeDg2XzY0IHg4Nl82
NCB4ODZfNjQgR05VL0xpbnV4CgpPbiBzZXZlcmFsIHNhbWUgUENzIDoK4oCC4oCC4oCC4oCC4oCC
4oCCTWFudWZhY3R1cmVyOiBMRU5PVk8K4oCC4oCC4oCC4oCC4oCC4oCCUHJvZHVjdCBOYW1lOiA4
M0ExCuKAguKAguKAguKAguKAguKAglZlcnNpb246IExlbm92byBWMTUgRzQgSVJVCgpXaWZpIENo
aXBzZXQgOgpSZWFsdGVrIFJUTDg4MjJDRQoKRXJyb3JzIDoKCk1vZGVtTWFuYWdlclsxODg4XTog
PG1zZz4gW2Jhc2UtbWFuYWdlcl0gY291bGRuJ3QgY2hlY2sgc3VwcG9ydCBmb3IgZGV2aWNlICcv
c3lzL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFkLjAvMDAwMDowMjowMC4wJzogbm90IHN1
cHBvcnRlZCBieSBhbnkgcGx1Z2luCgp3cGFfc3VwcGxpY2FudFsxODM0XTogVERMUzogSW52YWxp
ZCBmcmFtZSAtIHBheWxvYWR0eXBlPTEgY2F0ZWdvcnk9MjQwIGFjdGlvbj0yNgoKWyAgMzAyLjYy
MzQyN10gcnR3Xzg4MjJjZSAwMDAwOjAyOjAwLjA6IGZhaWxlZCB0byBkbyBkcGsgY2FsaWJyYXRp
b24KCndwYV9zdXBwbGljYW50WzEzMzFdOiB3bHAyczA6IENUUkwtRVZFTlQtU0lHTkFMLUNIQU5H
RSBhYm92ZT0wIHNpZ25hbD0tNjQgbm9pc2U9OTk5OSB0eHJhdGU9MjE2MDAwCgpbIDMyMDMuNTY3
OTcxXSBydHdfODgyMmNlIDAwMDA6MDI6MDAuMDogZmFpbGVkIHRvIGdldCB0eCByZXBvcnQgZnJv
bSBmaXJtd2FyZQpbIDMyMzMuOTI5MDc2XSBydHdfODgyMmNlIDAwMDA6MDI6MDAuMDogZmlybXdh
cmUgZmFpbGVkIHRvIHJlcG9ydCBkZW5zaXR5IGFmdGVyIHNjYW4KCkFscmVhZHkgdHJpZWQgdG8g
YWRkIG9wdGlvbnMgdG8gcnR3ODggbW9kdWxlIDoKCmRpc2FibGVfbHBzX2RlZXA9eQpkaXNhYmxl
X2FzcG09eQoKClRoYW5rcyAsCgpiZXN0IHJlZ2FyZHMs

