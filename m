Return-Path: <linux-wireless+bounces-26870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EF8B3C30B
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 21:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C70A26F6E
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 19:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C086151991;
	Fri, 29 Aug 2025 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="4lCttaqt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C4C2A1AA
	for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 19:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756495867; cv=fail; b=W0UBmnvJ0Z8yAlldxxxNPh/NZQr1c+7i+5PRlTv5ffwp7SBM/fB5xWyGBPj2FAdzD5XD2UdZ4eOKCTx+D+igcfOKUNPZbKvgyGUXFAlp37LxU1qCL2RFFuDHYtxTuRf+rFe6AzkT+wSLtiBd51ZS78plvy07o2kp+xoZ0KOekxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756495867; c=relaxed/simple;
	bh=CFQsVO7/XnCtv8QE/2e5MTzHRQe6buMUv37Cnc5ziV8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BdoxRRqwJLZOWfVXdl8S9KMQzdNsRl40+PjNoxYRRI/dIpVQlWWX/EpewQ8f5hyGs/o+pNIhnvW5C7GHePlvvbFC9TsAXeREuA1AJ+XVrgzkm5Th+Kq407Mo/jBc+vjeFzBfVdSjU0JXOhjhTmrb8rjQQ0T1aS3GGkUz9HmrWPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=4lCttaqt; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIBzqLsl+xnLpMw497Sa8Z9rDuP+x0lx5s78Y3Ri93MJa4meA2P2sIcFUwkk4gkgYDi673BGzzATevFsbMaSTEMs5IMf7RRRm4YG982/yWyo91btCW8xklvC71xYfI24bwW964E42ja5uJm4mEYp39bkN2na4uuslmgtWBOIErE9UWn7o8+qDQD2snj0moqUaCnjr+KclW/4x+Wx2OnksYI5Mtk7leMQuYevFr+S6F+EDLq9NC4uJVoAtMiSB2J0LVbXIZfZfbk+m3fFLJZS8g6l1egAOlJ9n6WdDSMNZKMBv3lUOG5SC6N4sJ0FyFL8SIiX3a+GJGLZMQpwroCwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFQsVO7/XnCtv8QE/2e5MTzHRQe6buMUv37Cnc5ziV8=;
 b=WIGiZLPwFJ4pzdlL9iTKO3GYbT/OACeINkGJnnl5l9G3QMPteys6RtCNxUjUIAgAMCnSE5NVUxPb3QtT1DMHNvXEv4rWA/vB8Uhzwl1qLZLkbqeUqnW5e3KurcZ5vMMBEFB6t3tDJjyKZyMSxOi32gcr132fpPqY33hxnRN6b80BdUq1TDYtQKy8AUG4hB1ND5FowcZjrXxtCj4vKGsJQtoNdgrncfONoyYzgb00v4KAFwAW5t0bGRyywdhVZR+gXsWGQONFpW8LUpFs6xZY/qe74NujhukB6GaRuGEo4Y64EEIkcV3SbWmb9DgwabvdfafU6llzxYE6eRZ05NWI5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFQsVO7/XnCtv8QE/2e5MTzHRQe6buMUv37Cnc5ziV8=;
 b=4lCttaqt9YkBD9dGdENYGyadCaV6NMDaibcLGmYeoVbydlDz4rRe0WXgdX9+nQINcCoYDGmAoZ8lN/r2MTqDxOMKJdecJxm7ch7Rdp2DMNWWEI9MYnH9zECpVHvF/+cWpP3ebE7fA7EuZwNKgOW0wXdpmQGz4aNn1AWt6OGyXrcYBGFwJ4Nvx96ZhvYeJtLC6CFtYqpbyxqqUF8t4vmbno5kbvzuCihcJ94I1uEaVZF0Kslbixbn0GpkRZgBoWcJ9KKlt8QI9cCijRRuM3x+NZY1aQaKAPbbct2ie7q/Wwfi8+AuOfPTKirONIB3oitj6D1QUQI4vgaBtO4QghUmuA==
Received: from DM8PR11MB5752.namprd11.prod.outlook.com (2603:10b6:8:13::15) by
 SJ0PR11MB5039.namprd11.prod.outlook.com (2603:10b6:a03:2da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 19:30:57 +0000
Received: from DM8PR11MB5752.namprd11.prod.outlook.com
 ([fe80::6ad7:8f77:89fe:bc03]) by DM8PR11MB5752.namprd11.prod.outlook.com
 ([fe80::6ad7:8f77:89fe:bc03%3]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 19:30:57 +0000
From: <Ajay.Kathat@microchip.com>
To: <linux-wireless@vger.kernel.org>
CC: <dan.carpenter@linaro.org>
Subject: Re: [PATCH] wifi: wilc1000: avoid buffer overflow in WID string
 configuration
Thread-Topic: [PATCH] wifi: wilc1000: avoid buffer overflow in WID string
 configuration
Thread-Index: AQHcGRHp1VGJn0dJb0+crwSfcWfS4LR6BL0A
Date: Fri, 29 Aug 2025 19:30:56 +0000
Message-ID: <39b4e0d8-4c84-402b-ba26-24f243c06921@microchip.com>
References: <20250829182241.45150-1-ajay.kathat@microchip.com>
In-Reply-To: <20250829182241.45150-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5752:EE_|SJ0PR11MB5039:EE_
x-ms-office365-filtering-correlation-id: c229dd73-eb07-451b-248a-08dde73293c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dHRKY0txRzRNS0JxZWVuMWZad3B4ZDVaOTZxRjRVNW9tTGFiSGJpVmhFdFU1?=
 =?utf-8?B?Y0pER0Y5WjY3NzBEMHZsWEd6S1JicHR4Uno5K2p5K0YvTlhkWkYydTJVQ1BL?=
 =?utf-8?B?RWJ1UDBwc2VuZmFZVWptV0NpbXZ0QXJXRkVVYzlTTWUrdHl2YUY3QXBnMHBO?=
 =?utf-8?B?TVBkU1lCUDlZTmFCY1FSN0E5TTFBU3k0Q0x2TnJBZXlsWEt2VnZ2QzQ2cWhG?=
 =?utf-8?B?aUtKbGIzNkJFR1F2TjYvdDZNMzd0Ykp0UDRhVXRJYmRVU0lpU1BMdWZERzgx?=
 =?utf-8?B?NkJxSkVNblVndnJsNEw4bjJ3NEM1cDVnZU5id0ljVSszVHlhT3o1SURNenVy?=
 =?utf-8?B?dnpxNXJFeHQ0NmljVDNLRUZYcGlFbnRySmQ1R2UwR3VrUCt5Tjc5UWJrQmcv?=
 =?utf-8?B?cmlMcGVQazNKa1k3eDdVTXlUM0hFQXEzNlF2SE0ramYrMTh1endZM0owa0dX?=
 =?utf-8?B?K0sxNjMvR1NXWkZybWRxenoxTUR3Y2kzOWpzVGNjV2ZBRXVGeUZuRE9JOG5n?=
 =?utf-8?B?VlRTalhxbFUyQXNlYURSako3aWNTVnJsbGRpbnEzai9ENkg2dDB4WHIvb2Mr?=
 =?utf-8?B?SU41TTBCdnhxS3Z6eitnWmxzcTBSMTBWeWRaWGpJMGV2N1QwZGFpRjBPWUNx?=
 =?utf-8?B?UnZrY0JHd3B5enhOSVJ0bzNCU0pNRVo1dXVGd2Y5YWVLSG9ETWRIVGtiUmxK?=
 =?utf-8?B?cXZVQlhidVA0UTRpTmJ6d0hpSWU0UURjbTFiT1B6SGtmWEV6cTJHa2dYN3F5?=
 =?utf-8?B?ZG1RYkp4NFJkMzFZa2VjVm9jZWxnWXZKS2RGOVJnWUkyRGVCQmswOWRNc1ZM?=
 =?utf-8?B?UVowOEhLU3ROV2QzbTB4WGl1RmtzUFA4TndtSWZDbjVvb010ZEFIRERIZEc3?=
 =?utf-8?B?Tmhjd1JJQkkrR1ZYamZhV0hmNU40NEZqYWQ3SVRKdDY4Mzk5aU14THZZNXhZ?=
 =?utf-8?B?aGN5UEFDSU91VzFUSUhZWnl5YTRpTk9vbTFXTnJqOE9ZRTM4a2Y2V0JrVEFT?=
 =?utf-8?B?bVhqV3JTOHBLRzQvUHdLVXRjVHpkdE5tWkFqM2VpbUdrSnNWZFNnYWpmNHpm?=
 =?utf-8?B?cEM2U0VjMDRldlFzTWxxbDZhRFVPc045TnBJbnlRajBFd0JYRGpHMlhDUjE4?=
 =?utf-8?B?QmVRdHBxM2FlS1MvY3NJVUk1Wi96U2w1WTF2S05FL1psN2FmRHdNM2M1QkFu?=
 =?utf-8?B?UnM2TVJBZm9SaGpmVElELzlmekt5YmZXdUlqcGNkSmNKWGt2WDdPTTB5WENr?=
 =?utf-8?B?dE5YOHNIR0xpSnFhSU9wUFI1enp6eFMyUktNRnRIZllPZ1F2TVNEVmhKMWJw?=
 =?utf-8?B?SzJYWEQ0dmpNNWc3c3lNeFltWGFEOS9POHNUa251K0w4WDlrTkc2TStuS2ZO?=
 =?utf-8?B?TzlKRGdQSmFFOW91b0s4MThSR1BsTnROUEF5akppTHJxaWJLUDJ2U1hXM2tC?=
 =?utf-8?B?cW9mS0xpM0JDb2RGTzhMSlc1Sk1OdlNzYXVYSDVWUHYwYnZVVEwxSjE4TjlY?=
 =?utf-8?B?QU1EL3R5OTlWQTN4SFpJU0Q2Ni9TVmFsakpWVEFTSnpVTWFoVHpJVVlSWlQ5?=
 =?utf-8?B?K3dHL2dTdW0wR0ZQbmdRSW5oR2NSZjVFZUEyeTlFUldsUE16ZTdSNUVvMU83?=
 =?utf-8?B?RlRBVXdXMTZkQUtnWEo3YkRjSzNPcjZuRkZHem1iUzd5SC9XRDdxQTgwOXM2?=
 =?utf-8?B?akNRYVZyUU1SbGZRVU1VUll6SGxLbGpvMmJER3U0Z05BWUFsUDRjQkhkd0p1?=
 =?utf-8?B?VnBvWEZPOU5pejBZeWpNbnRibWdSL1hzL3R3a3ZDV1oyelFiM3M4TzVBMnlG?=
 =?utf-8?B?czRVZWZvQkJYUmkwR2tNZ2wvOWVXalRqMmVrd0c5TS9XRTlJRTUwRkcyYUtO?=
 =?utf-8?B?OExYL0dCYWoyS3ZYeVlUOG1vMUl0RFVZRVVqN09oaTc2eUNxTXVTSEx1c2Yz?=
 =?utf-8?B?UDV3aGtadzJpSHNnZ1RDM3U3dm9SMVR4bVArcGFYbnEvNHdDaTJHK29hdmYz?=
 =?utf-8?Q?o452UO/nGmrdBYWySU0stN62nYW0Qc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5752.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWJFbWs0RUFWcndUTXNGL1VqUysrejk5VmoyMGdWaFJQZXVYSXlYSUh0VUJv?=
 =?utf-8?B?VC9Xak5FMnVWazBnblZ3QTJsWngxMHJZVWJ1MUcwS3Y1VTRuVEdaV0lYWldU?=
 =?utf-8?B?ZnV0QXZmUTFNUGZDSUdqRjI4ZVpRRm55UkJNbWE5cTI5T3FZZ2RuQVU2UXUx?=
 =?utf-8?B?L09sOFczbHE1Ull4dTVTRDM5cTBhbnF6ejJBYzhDYXBpQ2ZTUXRYOEtZRE4r?=
 =?utf-8?B?TVVFN3JqNi9NRjVPc2xaNHYrakJYTTg0cS9aWHhCWk5IeWVnakRNV29QOGhh?=
 =?utf-8?B?aExZOEc4MEJ0WkFwUDRLUUh3eXBHUDBEOGwyT1NQeGtIdE9hcEUvTlFwNHVT?=
 =?utf-8?B?M3FpQmhEYlBUSG1xelhsZXM0bjh4R2dvU3ZtTUZMOEFWTFpWMCtxcTFrTjFP?=
 =?utf-8?B?QkN4bDlsYlV4b253V1FONFF3NFczS1JEOGNJeXpVZGlBb3BlS3o2UFlZNXht?=
 =?utf-8?B?VGRMS09yc3Vuc1RmdzBoS0pyS3N6UkNZSjduMk9GYW9oSDloNnplOWdLaTNq?=
 =?utf-8?B?cy9jRCtURUFTdWI2T1dTVXdWdE1zOWpkM1IyeXF1NWg1YkZPRXk0bmRNb2VW?=
 =?utf-8?B?UEpHMTN1OFV5dkNuUi9EZWJhaEJhUDJBMWFTakRtZXlqc2VCbERSNVRVUDZp?=
 =?utf-8?B?cFpYY2dkL2VjU1dveHlZU2RTOTBvUXdmNzRWNlVUVVFKWXNzR2FPbGlUMVlj?=
 =?utf-8?B?QVgyQ3NzNjBxQVphNU5HM0k3QjZKT0NnNThTT3hySU9mNFZBKy8yMXRDci93?=
 =?utf-8?B?MXhyVWk3VUdzb3ptelhqNUhFWXJ5QndCa3VOa1ZTblN4V3p3MXBQUzdob3lX?=
 =?utf-8?B?bzVmbzFjWXB4dlNIN1pxZkV5RnhFb2YxSmFlNS9mWGpacm5DVDQ2bW4zaVdI?=
 =?utf-8?B?R2xOV3pZNEdqS2pFVXVLZ1JhWUtxSE5xM3lOTVhZWW5xWDhqL0JxdDlUYTdR?=
 =?utf-8?B?a1k4eVhTcFJvY0hzVVhaSDl4Z3pmdWhub2llWVhlVFN4TlFBNGg4MklaVFE1?=
 =?utf-8?B?OW92U1FaT0R3aWlFTllObU5JTVFPMHREeHhzZk82eHJKQ09naEg2czBCWis5?=
 =?utf-8?B?bkFaYXVINE9adjhBc3hDSUQ0WThUZUFiNnZ5WTFQdDJHMG9Oejg5SFVhTzhT?=
 =?utf-8?B?ZnFqZkJJcy8zdlErYklGMDVCL1M0eHNDcFQ4b2lERFJnR1V6Uys0b2pZeGxw?=
 =?utf-8?B?NkVPcmk2RU1wMDliam1PZnN4M1BkOU5aWnNTR1VkTnRLcHUvTTEvc0tKdFVL?=
 =?utf-8?B?S0NEWW1vNFc2U0pGYmV5RHphZkQvZ1dVK3h6WkhRMFZ3NGx6a091MkZCQTNC?=
 =?utf-8?B?NzNKcmJFMVFiV2JseTQzU2NpR3pmUnJrVmdyTDhyYzFqdDdCTXJXOTB5UmZk?=
 =?utf-8?B?UVVuUm1SU3BXQzZ5QURYYlFHZUVPUGcrMGpCOFJXZjhkWmEyN0tYK3lFcFZZ?=
 =?utf-8?B?eGlJMmp4dk9wRmpGM0U2QjE1OE1QOHR2MkpsSXRYSUJSeXRxdWNqTkRWbzY5?=
 =?utf-8?B?bzFvTGg5Tll3MkVGTWZvTW5UdC9ONFlzQy9RTGhTS29kRjJlb1U5Q24xZkRP?=
 =?utf-8?B?OUl1UUhhTzl5UWZyY051MGZ3ZGFReVI4KzBQNDd0YW4rblBwMXE1QnlBdml1?=
 =?utf-8?B?Vmx5UUxGOUUyQVVNcDc0MTZVY0xuYU54N244RHlmNU4rK2o5QUk2SlcwMGxL?=
 =?utf-8?B?elJqeVRnTUNMSk5tTXJ2ODkzWVJ1UzlyRHlyc3dlbEVsdDVRYVhaMnQ2TER6?=
 =?utf-8?B?aU1VOTQ2b2Q4MjZyZ1R5TGZMbzZvdDlsOGdNUFIyZ0QvWGsrdmwxZmJJUXBo?=
 =?utf-8?B?cHllOUpRMjRXYTAzbk5lbHFURFE4cGNsNTJPNUxYMU1KbGxUR201OHhoUGlt?=
 =?utf-8?B?em9Za0Z5c3czTFd3UDhYUVdBWXNlYlhnWXdhTzB6SjhCd1I4a1M3dTEzTmZ1?=
 =?utf-8?B?Vi9GNElRRld4UjU5ekxZcXlmY2YzRXhYeWpSRjNoK2w3TEdMeFp0ektveHlL?=
 =?utf-8?B?bXlDTEpYUG9id3hHUWRnaUF5VnNwV0RiOUt2NWRWSE9CelhkTkpGKzVFSm5F?=
 =?utf-8?B?QVhzMDJOa0ZReURoNzBpVnhUT2M1UmpqRkF5cytmMVNwSm9PQW9RaS9qSTdR?=
 =?utf-8?Q?hVpY7h5JFPc3MOhYgVcUdZWlo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <536761E9FF5DD245A8B4F7BC6EE85A8D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c229dd73-eb07-451b-248a-08dde73293c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 19:30:56.9862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pW2dgArMEGvnualMcHaC6eKBchJ0rcIx40DFkgIXrMpbS4GqR/zdhvcpC2U6rwpkHXHsjKt3xG/1ZgOeO96HCg3EFVp5GDkSQP6+U1EMjXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5039

T24gOC8yOS8yNSAxMToyMiwgQWpheSBLYXRoYXQgLSBDMTU0ODEgd3JvdGU6DQo+IEZpeCB0aGUg
Zm9sbG93aW5nIGNvcHkgb3ZlcmZsb3cgd2FybmluZyBpZGVudGlmaWVkIGJ5IFNtYXRjaCBzdGF0
aWMgY2hlY2tlci4NCj4gDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEw
MDAvd2xhbl9jZmcuYzoxODQgd2lsY193bGFuX3BhcnNlX3Jlc3BvbnNlX2ZyYW1lKCkNCj4gICAg
ICAgICBlcnJvcjogJ19fbWVtY3B5KCknICdjZmctPnNbaV0tPnN0cicgY29weSBvdmVyZmxvdyAo
NTEyIHZzIDY1NTM3KQ0KPiANCj4gVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIHNpemUgY2hlY2sgYmVm
b3JlIGFjY2Vzc2luZyB0aGUgbWVtb3J5IGJ1ZmZlci4NCj4gVGhlIGNoZWNrcyBhcmUgYmFzZSBv
biB0aGUgV0lEIHR5cGUgb2YgcmVjZWl2ZWQgZGF0YSBmcm9tIHRoZSBmaXJtd2FyZS4NCj4gRm9y
IFdJRCBzdHJpbmcgY29uZmlndXJhdGlvbiwgdGhlIHNpemUgbGltaXQgaXMgZGV0ZXJtaW5lZCBi
eSB0aGUgbWF4aW11bQ0KPiBlbGVtZW50IHNpemUgaW4gJ3N0cnVjdCB3aWxjX2NmZ19zdHJfdmFs
cycuIFRoZXJlZm9yZSwgV0lMQ19NQVhfQ0ZHX1NUUl9TSVpFDQo+IG1hY3JvIGlzIGFkZGVkIHRv
IGNvbmZpZ3VyZSB0aGlzIHNpemUuDQo+IA0KPiBSZXBvcnRlZC1ieTogRGFuIENhcnBlbnRlciA8
ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0KPiBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LXdpcmVsZXNzL2FMRmJyOVl1OWpfVFFUZXlAc3RhbmxleS5tb3VudGFpbg0KPiBT
dWdnZXN0ZWQtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz4NCj4g
U2lnbmVkLW9mZi1ieTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlwLmNvbT4NCj4g
LS0tDQo+ICAuLi4vd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL3dsYW5fY2ZnLmMgICAgfCAy
MyArKysrKysrKysrKysrKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9taWNyb2NoaXAvd2lsYzEwMDAvd2xhbl9jZmcuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21p
Y3JvY2hpcC93aWxjMTAwMC93bGFuX2NmZy5jDQo+IGluZGV4IDEzMTM4ODg4NmFjYi4uYTlhMTYw
MTJmOWYzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2ls
YzEwMDAvd2xhbl9jZmcuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAv
d2lsYzEwMDAvd2xhbl9jZmcuYw0KPiBAQCAtNTIsNiArNTIsNyBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IHdpbGNfY2ZnX3N0ciBnX2NmZ19zdHJbXSA9IHsNCj4gICNkZWZpbmUgV0lMQ19SRVNQX01T
R19UWVBFX05FVFdPUktfSU5GTwkJJ04nDQo+ICAjZGVmaW5lIFdJTENfUkVTUF9NU0dfVFlQRV9T
Q0FOX0NPTVBMRVRFCSdTJw0KPiANCj4gKyNkZWZpbmUgV0lMQ19NQVhfQ0ZHX1NUUl9TSVpFCQkJ
V0lMQ19NQVhfQVNTT0NfUkVTUF9GUkFNRV9TSVpFDQo+ICAvKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioNCj4gICAqDQo+ICAgKiAgICAgIENvbmZpZ3VyYXRpb24g
RnVuY3Rpb25zDQo+IEBAIC0xNDcsNDQgKzE0OCw1NiBAQCBzdGF0aWMgdm9pZCB3aWxjX3dsYW5f
cGFyc2VfcmVzcG9uc2VfZnJhbWUoc3RydWN0IHdpbGMgKndsLCB1OCAqaW5mbywgaW50IHNpemUp
DQo+IA0KPiAgCQlzd2l0Y2ggKEZJRUxEX0dFVChXSUxDX1dJRF9UWVBFLCB3aWQpKSB7DQo+ICAJ
CWNhc2UgV0lEX0NIQVI6DQo+ICsJCQlsZW4gPSAzOw0KPiArCQkJaWYgKGxlbiArIDIgID4gc2l6
ZSkNCj4gKwkJCQlyZXR1cm47DQo+ICsNCj4gIAkJCXdoaWxlIChjZmctPmJbaV0uaWQgIT0gV0lE
X05JTCAmJiBjZmctPmJbaV0uaWQgIT0gd2lkKQ0KPiAgCQkJCWkrKzsNCj4gDQo+ICAJCQlpZiAo
Y2ZnLT5iW2ldLmlkID09IHdpZCkNCj4gIAkJCQljZmctPmJbaV0udmFsID0gaW5mb1s0XTsNCj4g
DQo+IC0JCQlsZW4gPSAzOw0KPiAgCQkJYnJlYWs7DQo+IA0KPiAgCQljYXNlIFdJRF9TSE9SVDoN
Cj4gKwkJCWxlbiA9IDQ7DQo+ICsJCQlpZiAobGVuICsgMiAgPiBzaXplKQ0KPiArCQkJCXJldHVy
bjsNCj4gKw0KPiAgCQkJd2hpbGUgKGNmZy0+aHdbaV0uaWQgIT0gV0lEX05JTCAmJiBjZmctPmh3
W2ldLmlkICE9IHdpZCkNCj4gIAkJCQlpKys7DQo+IA0KPiAgCQkJaWYgKGNmZy0+aHdbaV0uaWQg
PT0gd2lkKQ0KPiAgCQkJCWNmZy0+aHdbaV0udmFsID0gZ2V0X3VuYWxpZ25lZF9sZTE2KCZpbmZv
WzRdKTsNCj4gDQo+IC0JCQlsZW4gPSA0Ow0KPiAgCQkJYnJlYWs7DQo+IA0KPiAgCQljYXNlIFdJ
RF9JTlQ6DQo+ICsJCQlsZW4gPSA2Ow0KPiArCQkJaWYgKGxlbiArIDIgID4gc2l6ZSkNCj4gKwkJ
CQlyZXR1cm47DQo+ICsNCj4gIAkJCXdoaWxlIChjZmctPndbaV0uaWQgIT0gV0lEX05JTCAmJiBj
ZmctPndbaV0uaWQgIT0gd2lkKQ0KPiAgCQkJCWkrKzsNCj4gDQo+ICAJCQlpZiAoY2ZnLT53W2ld
LmlkID09IHdpZCkNCj4gIAkJCQljZmctPndbaV0udmFsID0gZ2V0X3VuYWxpZ25lZF9sZTMyKCZp
bmZvWzRdKTsNCj4gDQo+IC0JCQlsZW4gPSA2Ow0KPiAgCQkJYnJlYWs7DQo+IA0KPiAgCQljYXNl
IFdJRF9TVFI6DQo+ICsJCQlsZW4gPSAyICsgZ2V0X3VuYWxpZ25lZF9sZTE2KCZpbmZvWzJdKTsN
Cj4gKwkJCWlmIChsZW4gPiBXSUxDX01BWF9DRkdfU1RSX1NJWkUgfHwgKGxlbiArIDIgID4gc2l6
ZSkpDQo+ICsJCQkJcmV0dXJuOw0KDQpNeSBiYWQsIEkgZGlkIGEgbWlzdGFrZSBoZXJlLiBBZnRl
ciByZXZpZXdpbmcgdGhlIHBhdGNoIGFnYWluLCBJIHJlYWxpemVkIHRoYXQNCnRoaXMgY2hlY2sg
Y2FuJ3QgYmUgYWdhaW5zdCBhIHNpbmdsZSBtYXhpbXVtIHZhbHVlLiBJbnN0ZWFkLCBpdCBuZWVk
cyB0byB1c2UNCnRoZSBzaXplIG9mIHNwZWNpZmljIGVsZW1lbnQgd2l0aGluIHN0cnVjdHVyZSBy
ZWNlaXZlZCBmcm9tIGZpcm13YXJlLg0KUGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNoLiBJIHdpbGwg
dXBkYXRlIGFuZCBzZW5kIHRoZSB2MiB2ZXJzaW9uLg0KDQpSZWdhcmRzLA0KQWpheQ0K

