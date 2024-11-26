Return-Path: <linux-wireless+bounces-15719-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93869D9AD5
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 16:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1374B28855
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 15:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69761D79B6;
	Tue, 26 Nov 2024 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="PLlT/ja/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2076.outbound.protection.outlook.com [40.107.241.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09BD1D63FD;
	Tue, 26 Nov 2024 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636458; cv=fail; b=ih5nzsj4cT2P5KA/CBN7MpH8zZ2ypNXujwqayS5YNz0BpbQn+EgtIFUAAE/G23MbDhnoexl8nLFa4wBVRZsfyuq7vjj6i0jgJWYi7YdL0bZs4lGMGJh1EJzZ45mVDQJVBgv+ruSbgMyJK5cZYUnduFSwYe3DXWWONPJ5XCLpryE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636458; c=relaxed/simple;
	bh=7/IJHo6id1j4pFovOvZp17iPNGyiAQLeTrzbNnLvoVA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XiFUsN2XA4i6/D/AR+CYKITxqk8Q+Lay+RO2u5eYSmGvZsnNcWDLT5OitvIi700q0ankLjH8+GRu8Ai0CKOucjLaWo6glbQDGEN0c7fLstOLI8hExga1UYY+3Gu1ee1jb2wRVWepTSsamTG3EaN/0RafI7xczx/5IZqOUxY6q1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=PLlT/ja/; arc=fail smtp.client-ip=40.107.241.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmIn7oSZr9t38GTXIifBV6U/2u6InSr6A6g3NcWUCciIQ2dm+39EynXEr9b9KjEPCCa+ETFy8GP+QjVNXJG/FLyY+Zk9RTJ5pUycVfWY6lwIlhKQVZzEYOMHr/rEDtxNqTcNHTGTNiYqV4Nr5vASsKzsFJtsYN3vN2RhrRQVk/6tHqziVewnU/0q7p5eAKlRwDmJKuD2leRs/5NVq0eN6Wh5Thver+BrjCPptXbZ4MKt+tkBhsR190NvYozS7105KxjGDPSLM59A2eKQ+SycmX4DAhzrmoPFgWD0fkxFEk34pm/nLeyLw5LhE/IEvPsreioPcH9gkA/oM2HdUGv26Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/IJHo6id1j4pFovOvZp17iPNGyiAQLeTrzbNnLvoVA=;
 b=McALTWJAQ3NoVn8KS0Tz6m4gyuH60fjm0nGi0VsV6cboj+UQ4b+oqtOtVxGYM/OC3+E3M40XH58Mi61Igqcwhvm+deXkw9OfRgXaS0ByBbz6zChZVxExopgyploOF0rbZqxe0J95X7FYLw4jWjcSYRTBzbtDcsx/qBlbI3+QOca4icyr9u1KFqGro0Qbp8jm1V2YXOc1Qv3MmdccfSaypcWZO2vqnbjBrxceAjtm/vzMShvRKbmNYPjJFaalqYTqsW1i9UpBEFN8IFXxFjF+vSqP1xcFtE76hKquMEFkF4o5WYWQr3abpcyjnaUWxBc7PmFmLH3ib/oeooRwOe70uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/IJHo6id1j4pFovOvZp17iPNGyiAQLeTrzbNnLvoVA=;
 b=PLlT/ja/aitfIcsuu4XBtXi33UC82i536wPxw1YRHNz2oSJz8LPHI/o+XN+G6tWBGfP7MA7hGXFn1uiXHLILJd48UDKIv4L9Wb6k0oKir9mW72NEy8cC4+10pVLZtvCh3LWAljoU21qPIPK2igDLaFyEp/NuYqgm1v70PKAUmR6CD/HeZ2TCzGdUdM/dxzbDvFj1goC0S5GAPJwqDz7lot8AX4v50y3Jlq5a+LZwqGNkeJm69dbt7j3UIpen5cFXetaCzpwNBPxney4LKF/RUkcmx/oFhmaDiglyIYMMs9X75ZP85gYQJQ8/9wSJzhyXV6S2//wrbtdOlSUUIL97kg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAVPR10MB7116.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:315::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.11; Tue, 26 Nov
 2024 15:54:12 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8207.010; Tue, 26 Nov 2024
 15:54:12 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "kvalo@kernel.org" <kvalo@kernel.org>, "jerome.pouiller@silabs.com"
	<jerome.pouiller@silabs.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/8] wifi: wfx: allow to send frames during ROC
Thread-Topic: [PATCH v3 7/8] wifi: wfx: allow to send frames during ROC
Thread-Index: AQHbP9KSRfOD6XnoWU6tYD17HfBVsrLJKbeAgAB6UoCAABMwgA==
Date: Tue, 26 Nov 2024 15:54:12 +0000
Message-ID: <45b7f72ee9b4b77bd05a63a4cae81481aea99157.camel@siemens.com>
References: <20231004172843.195332-1-jerome.pouiller@silabs.com>
	 <20231004172843.195332-8-jerome.pouiller@silabs.com>
	 <d8e9a080b3fa9a444e4634bcc85b22bcc1ed57a6.camel@siemens.com>
	 <1769588.QkHrqEjB74@nb0018864>
In-Reply-To: <1769588.QkHrqEjB74@nb0018864>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAVPR10MB7116:EE_
x-ms-office365-filtering-correlation-id: c320a125-8990-4af1-40ab-08dd0e329272
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T0RxeENJb0FUQWNVbE5VcHIxdXNObWN4a1h3NzJPTExsd2lFS1BSUU9EY04w?=
 =?utf-8?B?YmIvTml1RFhkNHA5TkJIWlA4RDNESGJPUDEvaXNENVlIZm9qNjlvdGxtT3dP?=
 =?utf-8?B?dEt2MnFKNjBSdWtGalFIbVJ6WHd1MkpCeHdhUUVQMGIzbXhOdE9ybDV6bkJh?=
 =?utf-8?B?SGdOUmpqN3cyS1YzN3ZmL280Q1J4OURDZVVTeW9Pdm9va3hxaWkwdWRSMW0r?=
 =?utf-8?B?NnB5Y0pPampCZzFIR2hobTlCTEx3N21WV0RNSTEyVXpLR2VGeHp1RlpKMmVz?=
 =?utf-8?B?dFA2dVRrdUkyMjgySGhJblNXcE5SOHRQN2QzSitNWThIRFlsVmVwaGgyQTVM?=
 =?utf-8?B?eG81U0RodjdTYkl3UlBkVzJweVBqTzdaOWhYMUpzcVp3UG0xS0d6b0NnOTV1?=
 =?utf-8?B?OHhUOGRjZmVHOFY3SmtyeXN6anY3Q0Z6bTdYRHUyZmpSK0JuKzdaVUk2S1Rl?=
 =?utf-8?B?bVFwZE9aVmlMd1gwOVRkNkhaYXZoY05uQTR4Z1drYURmaTVPS01zWGZiSzFt?=
 =?utf-8?B?SXlJV1FaQzdPRy8vSzMyMmhVZFRLd2xrVG8wcHhOSXVPWnkzQy9kejBRUzg1?=
 =?utf-8?B?MzBhQzlNSC9JbXEwb2crK2dFeTJJdmlzc01IRW81cGVXM01NQVZhalExWTdk?=
 =?utf-8?B?NjNLdG1TY0xCQjcrOStXRWtpS1pINnlNdVJRc1VZNUplUUtBSEFkOCsrZ01K?=
 =?utf-8?B?aUsxc3V6S1YwOWJKMUhuSFZEbEZvaGdHVUhnRkU4V1BtNDFyUTlUMVJYTzRG?=
 =?utf-8?B?dG44YnVWZVp1ckZZUTgzZG92Ulk0TnpadnliR1pxbndQS0dsZGk5dWYxT214?=
 =?utf-8?B?YW45aHdyTVE5bkV4b0F4RzZVR0RoS2IyclRSdDc3T2owWDJQT0lPcWl1ZzUy?=
 =?utf-8?B?Ujk2a0ExOFdHRklBZXVBU25VMU1Rc3JleHZXZk1DT2h0WVZEd0N1TGF3VTZ1?=
 =?utf-8?B?dTN3VnYwaldSV1VaazFyK1JRcDJFak92TkYxZTJBTlYrVUZCTmwvMTg4cXY2?=
 =?utf-8?B?U3h4QytNSDJ6bUUxVkNLU0d0cnRXM002VnhLRVRZTnlCd1gyeEd0NTdlT3hK?=
 =?utf-8?B?d0wvaC9ZVTlZMG1xamNraDllR0g1dlBKMGVFdElCa3h5bEpRZ211VTJNbDhW?=
 =?utf-8?B?K1JsQ2RhOGR0enI4VysrUmFwd0RuM1FTV21jRmRKSVpXUHFVSXBvbG44RG9q?=
 =?utf-8?B?Nkc3V0hNS3FsUXJnMnFDM2hzYkVacEI3eEIxNEdYb3JBS2N1OEZJK1J0c21a?=
 =?utf-8?B?YlNhZkc3Zkc2S2E4Ym1zR2krY1pPZGMvNnU4RmsycUdQUUMrYzQ5RUZXd3ZJ?=
 =?utf-8?B?bGs2OGpKbEMxNTk3aXFadjZxVURyZFcwRE93LzVXRW12M2twZGdaRjk3MWhj?=
 =?utf-8?B?UTRMSWY5RjU3d0dKNmZjVU9vN0hWTHQ2R3VjbUJtK3NVd0pPTFZ6TjA3dDJu?=
 =?utf-8?B?b2dRNjEwcExIYnBMcWFtYmw4VjRpbmxqbXEweGJ1ejJORGZwTHoxN1V6V0tl?=
 =?utf-8?B?bkQxTEpXN3Z3SkYyeU1sQUdZWGZlcFRFRE5pRnI3anlXVHpMeGRjdzBRT1gr?=
 =?utf-8?B?cW05NFBGSEZWdkh0YmtxaExHSHM5OHpGTlprR24zbUNSYVVtUlpzL2xlNG55?=
 =?utf-8?B?ekptb1NHaGduOW16eGVCTERyY1ZsK0VRRmYvWHI0MkVPa2dtb05yeDZablAw?=
 =?utf-8?B?VlhBVjkvUHpNM2h6UnRuSXlielo5N1JYbHQzR0ZBb25JQjdYWkNYSmxGSnhu?=
 =?utf-8?B?b1FuTjNyWmY2czBlOGUvWUk2NldFUjVlWm5ITzQyTUNrRzZIMURvdSt4MzVD?=
 =?utf-8?Q?QgP2MVB3QNK5At2Alsj3Af/y2eoW3Eu41sWWc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dWFERnBlcjlYbjdTSVlmamY2SktZK08wOHQzRzJ5azhiYWk1aG9CUVBxQW1n?=
 =?utf-8?B?blBLdVpFMU9MVFZmREZGVnMzcnNmQjc1UXpCOXl2aE9MWElvMGUzcGlWMzNh?=
 =?utf-8?B?dGlYcW0za3RDWmJDWFVjekJmMUdWVEh6V3dxdkN6YlB0RDV1OWtiUndtaVpM?=
 =?utf-8?B?NEhaaDZxdjFWbUhlSEhHSFhIOUYzZE5wMGJCVlVPTjMzaUtveWxOUkJ1K1BB?=
 =?utf-8?B?ZlFzZnZrcVFjcWlGR3FvSjV2NVp4cndFNXZSUkJ0aUhNQ08yR0Ywa3VKV0hV?=
 =?utf-8?B?WG9GYnp2N3dObFo1YkYwK21WbVZYNFdkQU81c1NWeWtaUER4TnR0MXRIcTRy?=
 =?utf-8?B?VDJLbnFoM3VHekh1ZjZ6MVAvQnAzYkRGeVlQRU8raWs0MDRFZEpjVUtlTFVM?=
 =?utf-8?B?SEoyU3BQZkZ5UVNselBmR2VXMlR3cis1cktNNmtQY3BjZ0xWcjVQcUh3eEYr?=
 =?utf-8?B?Unp6NmhHNWMxRFEwMC8wKzFKc2FUMXNZdW5BSFNTZkYzMVdxc2dDZFlBbXpI?=
 =?utf-8?B?bUVwY0xvYnJTVmdBSHJzaGVlekFPb3B2Q3JyR0lWSWhxd1FSTUhRTFhmdnVm?=
 =?utf-8?B?OUdVZVhOVFk5SUg4S0lld2lsZVNnQjdqbmwxb1kxaFVNYTFIclNSRDl5Yll6?=
 =?utf-8?B?b1puQmZETi9jV1p6QldKUUNDaGVXMFJrQzRoaHZNWU1kdnArZFErY1RWZlQy?=
 =?utf-8?B?N3NjUVR5b0NpY0s3NnNURFVMN09ha0ZtM1MzQXhDUFkvRG9oQVF2M0FQWDd5?=
 =?utf-8?B?N1pDNjBqV2plb2U3WHlpSktSVCtJdlFOM3M4SmdzRUVXVjBiZUV2WlF4ZTJW?=
 =?utf-8?B?dUlUelNXTExodHZMSVQ5NitSaitFYkY3aTEvazVoQ2RlTm9kdW4xZE9DQTB5?=
 =?utf-8?B?NjhZNVorMmlwT0JzdFZHQTRBc3l4RlQ0d0hhSWVKcHdyb1dUenRXOGdteVFU?=
 =?utf-8?B?WkhwTkx3SWZ5eVdzQkpqVndEbDAxZjUrOTZsSE9kWkQ1L0g1SUt1QmRTSnpl?=
 =?utf-8?B?TVN0bC9nOFNYd2wyQkRXOFl4RGRxa2FDbXhxdGNMOUpVakxHVDJtSmFaeHRo?=
 =?utf-8?B?MW1pRFg1akhDWXNQWmRZSnJOWlExZHV5RCttZXlsK240MlhQYUJHOTFIakJV?=
 =?utf-8?B?OFpJZzgrcGVuYWpTdEVVcWwzeFJkbHVpRklOeEFIaXlTTVRUdGZZNDBsZ1VJ?=
 =?utf-8?B?UG9nbjdQeUVKM2NmSHJwdlpmNHNaU0lmYmZwKzJ6V0wzTlJVK2JEd05iVm1m?=
 =?utf-8?B?RVcwWU1ZUEgzZGtSa0t1YlpCdVQ1dVZGcHdtM0hZU0VWM2tZUFZnUXY4My9y?=
 =?utf-8?B?cU1ubmV6YUhBKzd1VVFoQlE1ZUZwTnNXQkdCdmdoOUl1dlFzQlFyZ2s3TUdY?=
 =?utf-8?B?bFJpTUNLQkp6cmFDTGkrdDgyYUY2UTl5N3FlL1lmbjc3ejZEOXgvbzIwSjNC?=
 =?utf-8?B?ci9WL0xMcVMybWc4M01Eb2ZEUU54NTU1MmpselZ6SHpmODVMUUVmYTVwM0JW?=
 =?utf-8?B?RVo5TlJlbTh2MUxSaDZOWEVtYXdoY1RuVjZteFhvV0dKVzFYNWtYU290NGZh?=
 =?utf-8?B?cEtvdWpuR09qN3ErcVZVYlg5RnJBR1lBdXpFMHA0UWJETUlZbjh0ejNIdElz?=
 =?utf-8?B?alViV3dRN2pOSTdnVCswVEpiTlU3RlluL083R2xXdnlRekV6VlFva28wdGVS?=
 =?utf-8?B?dElVMTNYeFd4cXlPQ0ZqZk1Yd2VGQ0poL3kvTnN3ak95ZlN3L2I4R1ZjYXFq?=
 =?utf-8?B?UzBGb0VvOVg0aFo5ZnBkdE53QW83bjhORTcvMkEwQkIyektqcHB0L1F5bDFY?=
 =?utf-8?B?MnNRZ0lUd0NId0xqMG9KeGJsdkV6UHJzTE1WaXpIQ0E4d2tINEFpVm1TNVlZ?=
 =?utf-8?B?a0pQc2s1ZUtnR3ZrbUxsMDNTRHRYY3ZMYlFNdTVwVXVvZVViNjB2eGIzTk42?=
 =?utf-8?B?OFdkclVsSDBUSExFSUVVcnFBUGZrSlJHeE81K2FPRzM2NzJ1WUhWUSszQ1cw?=
 =?utf-8?B?SmQzamszQU1ZaG5OOGtibEQ2QVdxU1g4cXYycCtOK0t4NUJ5K0pIVEZDZ2Vl?=
 =?utf-8?B?WXI5OUtjcURIeHRvVTVkeHJZdU04TXlkKzJ3ajNJUHkxK2g0WXpkcjRVOGF6?=
 =?utf-8?B?OGExVGFOc2FTZndyRFpKOXNMTzYvelVhMCsrYXFDZW5ZZTVJQjdWeXdybHlw?=
 =?utf-8?Q?+ZMo56n39Wlo1DCqCSYodNE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C2882EB8FD12447A343B7759A1FDF28@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c320a125-8990-4af1-40ab-08dd0e329272
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 15:54:12.4517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X3j0AvemutvIsOcehiUxFR8w4N3DbkoA2W+4bKlr4lXhOnSNxtwcNoU+5pdG9bBFCrpcKRubrzJvvkLSLio9T+YY582wC7ETKh7TBWQl6UI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7116

VGhhbmtzIGZvciB0aGUgcXVpY2sgcmVwbHkgSmVyb21lLA0KDQpPbiBUdWUsIDIwMjQtMTEtMjYg
YXQgMTU6NDUgKzAxMDAsIErDqXLDtG1lIFBvdWlsbGVyIHdyb3RlOg0KPiA+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgbnVtX3F1ZXVlczsgaSsrKSB7DQo+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBza2IgPSBza2JfZGVx
dWV1ZSgmcXVldWVzW2ldLT5vZmZjaGFuKTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXl5eXl5eXl5eXl5eXl5eXl5eXl5e
Xl5eXl5eXl5eXl4NCj4gPiANCj4gPiBOZXZlcnRoZWxlc3MsIHRoZSBsb2NrZGVwIHNwbGF0IGNv
bWVzIGZyb20gaGVyZSwgYmVjYXVzZQ0KPiA+IHdmeF90eF9xdWV1ZXNfaW5pdCgpIGhhcyBuZXZl
ciBiZWVuIGNhbGxlZCBmb3Igd3ZpZi0+aWQgPT0gMi4NCj4gPiANCj4gPiBXaGF0IHdhcyB5b3Vy
IG9yaWdpbmFsIHBsYW4gZm9yIHRoaXMgdG8gaGFwcGVuPw0KPiA+IERvIHdlIG5lZWQgYW4gZXhw
bGljaXQgYW5hbG9ndWUgb2Ygd2Z4X2FkZF9pbnRlcmZhY2UoKSBmb3IgdmlmLT5pZCAyIHNvbWV3
aGVyZT8NCj4gPiANCj4gPiBJIHN0aWxsIGhhdmUgbm90IGNvbWUgd2l0aCBhIHJlcHJvZHVjZXIg
eWV0LCBidXQgeW91IGRlZmluaXRlbHkgaGF2ZSBtb3JlDQo+ID4gaW5zaWdodCBpbnRvIHRoaXMg
Y29kZSwgbWF5YmUgdGhpcyB3aWxsIHJpbmcgc29tZSBiZWxscyBvbiB5b3VyIHNpZGUuLi4NCj4g
PiANCj4gPiBQUy4gSXQncyB2Ni4xMSwgZXZlbiB0aG91Z2ggaXQncyBleGFjdGx5IHRoZSBzYW1l
IHNwbGFuIGFzIGluDQo+ID4gInN0YWdpbmc6IHdmeDogZml4IHBvdGVudGlhbCB1c2UgYmVmb3Jl
IGluaXQiLCBidXQgdGhlIHBhdGNoIGluIGluZGVlZCBpbnNpZGUuDQo+IA0KPiBZZXMsIHByb2Jh
Ymx5IGEgdmVyeSBzaW1pbGFyIGlzc3VlIHRvICJzdGFnaW5nOiB3Zng6IGZpeCBwb3RlbnRpYWwg
dXNlIA0KPiBiZWZvcmUgaW5pdCIuIEkgZG9uJ3QgYmVsaWV2ZSB0aGUgaXNzdWUgaXMgcmVsYXRl
ZCB0byB3dmlmLT5pZCA9PSAyLg0KPiANCj4gWW91IGhhdmUgb25seSBwcm9kdWNlZCB0aGlzIGlz
c3VlIG9uY2UsIHRoYXQncyBpdD8NCj4gDQo+IEkgd29uZGVyIHdoeSB0aGlzIGRvZXMgbm90IGhh
cHBlbiB3aXRoIHF1ZXVlc1tpXS0+bm9ybWFsIGFuZA0KPiBxdWV1ZXNbaV0tPmNhYi4gSXMgaXQg
YmVjYXVzZSBxdWV1ZXNbaV0tPm9mZmNoYW4gaXMgdGhlIGZpcnN0IHRvIGJlDQo+IGNoZWNrZWQ/
IE9yIG11dGV4X2lzX2xvY2tlZCgmd2Rldi0+c2Nhbl9sb2NrKSBoYXMgYW4gaW1wYWN0IGluIHRo
ZQ0KPiBwcm9jZXNzPw0KPiANCj4gSW4gd2Z4X2FkZF9pbnRlcmZhY2UoKSwgdGhlIGxpc3Qgb2Yg
d3ZpZiBpcyBwcm90ZWN0ZWQgYnkgY29uZl9sb2NrLg0KPiBIb3dldmVyLCB3ZnhfdHhfcXVldWVz
X2dldF9za2IoKSBpcyBub3QgcHJvdGVjdGVkIGJ5IGNvbmZfbG9jay4gV2UNCj4gaW5pdGlhbGl6
ZSBzdHJ1Y3Qgd3ZpZiBiZWZvcmUgdG8gYWRkIGl0IHRvIHRoZSB3dmlmIGxpc3QgYW5kIHdlDQo+
IGNvbnNpZGVyIGl0IGlzIHN1ZmZpY2llbnQuIEhvd2V2ZXIsIGFmdGVyIHJlYWRpbmcgbWVtb3J5
LWJhcnJpZXJzLnR4dA0KPiBhZ2FpbiwgaXQncyBwcm9iYWJseSBhIHdyb25nIGFzc3VtcHRpb24u
DQoNCkkndmUgYWN0dWFsbHkgZGlzYXNzZW1ibGVkIHRoZSBzdGFjayB0cmFjZSBleGFjdGx5IHRv
IG9mZmNoYW4gcHJvY2Vzc2luZy4NCkkgaGF2ZSBubyBpZGVhIHdoeSBrZXJuZWwgc2VuZHMgb2Zm
Y2hhbiBvbiBhIG5vbi1jb25maWd1cmVkIGlkbGUgaW50ZXJmYWNlLA0KSSBzdGlsbCBuZWVkIHRv
IGNvbWUgdXAgd2l0aCBhIHJlcHJvZHVjZXIuDQoNCkJ1dCBhcyBzb29uIGFzIHRoZXJlIGlzIGFu
IG9mZmNoYW4gaW4gdGhlIHNvcnRlZCBsaXN0IG9mICJxdWV1ZXMiIChjb21pbmcNCm9yaWdpbmFs
bHkgZnJvbSBWSUYgMDoNCg0Kdm9pZCB3ZnhfdHgoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0
cnVjdCBpZWVlODAyMTFfdHhfY29udHJvbCAqY29udHJvbCwgc3RydWN0IHNrX2J1ZmYgKnNrYikN
CnsNCi4uLg0KICAgICAgICBpZiAodHhfaW5mby0+Y29udHJvbC52aWYpDQogICAgICAgICAgICAg
ICAgd3ZpZiA9IChzdHJ1Y3Qgd2Z4X3ZpZiAqKXR4X2luZm8tPmNvbnRyb2wudmlmLT5kcnZfcHJp
djsNCiAgICAgICAgZWxzZQ0KICAgICAgICAgICAgICAgIHd2aWYgPSB3dmlmX2l0ZXJhdGUod2Rl
diwgTlVMTCk7DQogICAgICAgICAgICAgICAgXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5e
Xl4NCg0KUHV0cyBhbnkgb2ZmY2hhbiBpbnRvIG9mZmNoYW4gbm90IG9mIFZJRiAyLCBidXQgb2Yg
dGhlIG9ubHkgVklGIDAuLi4NCg0KSSB0aGluayB5b3UgYXJlIHJpZ2h0LCB0aGlzIGNvdWxkIG9u
bHkgYmUgb2ZmY2hhbiBxdWV1ZSBvZiBWSUYgMC4NCkJ1dCB0aGVuIGl0J3MganVzdCBhIHJhY2Ug
b2YgVFggd29ya3F1ZXVlIGFnYWluc3QNCndmeF9yZW1vdmVfaW50ZXJmYWNlKCkvd2Z4X2FkZF9p
bnRlcmZhY2UoKSBwYWlyICh3aGljaCBJIHNlZSByZWd1bGFybHkpLg0KDQpXZSBwcm9iYWJseSBu
ZWVkIFJDVSBpbiB0aGUgVFggcGF0aCBhbmQgTmV0TGluayBsb2NrIGluIHRoZSBWSUYgYWRkL3Jl
bW92ZQ0KcGF0aCBzaW1pbGFyIHRvIG90aGVyIG5ldHdvcmsgZHJpdmVycy4uLg0KSSBjYW4gdHJ5
IHRvIGNvbWUgdXAgd2l0aCBhIHBhdGNoIGZvciB0aGlzLi4uDQoNCi0tIA0KQWxleGFuZGVyIFN2
ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==

