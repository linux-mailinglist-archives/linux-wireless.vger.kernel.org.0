Return-Path: <linux-wireless+bounces-11852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9993495D15E
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 17:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88B51B2E1B3
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 15:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2891A18B483;
	Fri, 23 Aug 2024 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fPB//so4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0FD189B8E;
	Fri, 23 Aug 2024 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724426079; cv=fail; b=qGNSFbxql5Pu3rUKf+X69F4vTGrf145uJiw4bXITXKWAIXLeEW0m3xz1gAAG3cz//Wly/ztw+o0eUB/nFxDG3zhmpUrwTzaaWdkQrO1ZVdyu5tTZQGk1W3j+s9npvNXhAdyFQk1kibH6AJPwOI/28Y28O17tNsuiwlV8hnpwe+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724426079; c=relaxed/simple;
	bh=YdW6SiCbU4r8xWsOxrjvnwA+oByanV56deWmHDyv2Bc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c8U3II3oY5WrzC3NFNxmIBHxuwGjUdPF4BhvaHEYrQsY88drRL843ptCzTUQVw6p24F76wgzdEIh8e1tIzgYlwtTEOqyNOCB5Fmyf4R8lKVzgFHyHOl/QoyT+klFkUfOtZmop7vFqxxJO6GIBq9UmTh8EiPusGiIubRpwT4+BEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fPB//so4; arc=fail smtp.client-ip=40.107.22.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TADYB4iVpEXzh8zjWDG1vcdlEQKt8a3lpsZp0Tl7fOY2tzxbFhlYJ94eDwidLdOYYWX9crXHIym+oCdg/nT0M1OvZMacZ2Bor/PGGtQ6LTSC8BSXrH+mEaHw/GjOWL7PZGoIizhX19XBLdAkqG+Ob6E/9TOVvGEcTqsYOvf4G+XBjHcVsbMBE4lOsCocQ9yyO9Kp7xY6OUpR/sgz8e9Yle9C3/cLAGtSDmzf49fTSf9zJjiwcpnJH9iC2CzhPDTWkzzvyb6FxXKppIVao8w3PZXyjfnrcTxiPeL9/4VowufaccUy+JwpjNj0IhRMu7kX6Rm0ygDQFQ38XxtReZ3UtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdW6SiCbU4r8xWsOxrjvnwA+oByanV56deWmHDyv2Bc=;
 b=pvElWOWjGGcjlEJ/Y/Bx3P/nrXGXYPFhiW9nfuR1/gZFPJAImB7899urBOauPuQuoHqeKib6XH3MR9/TlghwrSvwc+HKNBpplVzJg5lJZIEQAhyY/StNLl2WKoniywsJH633boPSpluVegdidiSoy2Bo3uofX3IW8ntcPMIt4OuzjgmgJsdq8/nfeDmrlo05ziUfQ+E1VAS5pMYdKPhplNRTyP7C0Bp91BCPwUrvXLXSpZ8RPHkENBvsXJlL0fnnttGm+5P9JPKvgzh0DQUPRO+TjSSFuQn6dkhv44o0lGw7G1vT6T9Oz9OIwtqT5UDC552cNJN8u43BZam77GKpuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdW6SiCbU4r8xWsOxrjvnwA+oByanV56deWmHDyv2Bc=;
 b=fPB//so4R7bLG7oKq9nRnDxwRdw7A7dW9pbzHvs654PquA4ANQYw6EvVaxsbTShiSupXj5GuVJm7+lk+KutXA2Z5uEc1z5/n42D6rL2SS5MZvaILon/q6ultfTcIBp02UiTl1YnBHDQiB2pwrMo2+FHThpRFAzBeNlbtqY/y/oehGqxQFgoRN3LOzgWnDWMr8FCN2v5FQjZrUgRFESG0l8103JHAsEX3Y/TtEx7Vd8AYHyDvEog8Cu57skkmp/A6efl0w6uddybfwek8UtcJ9nlV30fDDE6PDGvxnmLzjFveq+k9RVTb5LwQVlCFmL7DxkuzVxETAHQbkOV8fv01HQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB8PR10MB3944.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 15:14:33 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7875.023; Fri, 23 Aug 2024
 15:14:33 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "kvalo@kernel.org" <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"dmantipov@yandex.ru" <dmantipov@yandex.ru>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "jerome.pouiller@silabs.com"
	<jerome.pouiller@silabs.com>
Subject: Re: [PATCH] wifi: wfx: repair open network AP mode
Thread-Topic: [PATCH] wifi: wfx: repair open network AP mode
Thread-Index: AQHa9V6F2AsytMDZyUaSKfiA10tTFrI08aGfgAAB8QA=
Date: Fri, 23 Aug 2024 15:14:33 +0000
Message-ID: <9d7bf12be420426d6a86ba6081431e880446fc46.camel@siemens.com>
References: <20240823131521.3309073-1-alexander.sverdlin@siemens.com>
	 <87o75juvke.fsf@kernel.org>
In-Reply-To: <87o75juvke.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB8PR10MB3944:EE_
x-ms-office365-filtering-correlation-id: 6a988798-89a6-4a1f-cc60-08dcc3864b31
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YmtIcDJza3ExVXBFenlPbXVPU0FkR3NBZXUxUk9kbU11L3dpS2RGaFMveXQy?=
 =?utf-8?B?TnlLZmlJdlVpanFIa2g5OTdMRVNwSWNjbUtnUFdQcE1Yd3VzSHl6VDZiZmc3?=
 =?utf-8?B?UXBZM3NhRXRGVEVyVW5CdDhrMDUzaEJIU0Q2RkNxTTIzQnJ4SWJLWVN1QkRp?=
 =?utf-8?B?QTB6aWhyTm9zUnlVekZYc09JQi9uWTZmS0Z5S2hzaXZpYUpvbGJaUFBqN2RG?=
 =?utf-8?B?YXdWT1RZNUJKTjNSUWJqWEppM3I2V3BMVTlkYU5IS2NJSEtnbnZROUNEOFBq?=
 =?utf-8?B?WFpidkZTbGdYUzdZRzcvbXBYakR6d2g1OHByaTVpQStON05pclA5RXFOTm1L?=
 =?utf-8?B?WWhrS3Z4ZEo3Y3RDSTRiaFR0VVJVcDg4SWhYUmRkQlUvZWNwREhwbFRvakQ2?=
 =?utf-8?B?OUlJbTE5cFVNa0RrNXJZcEk3UkJkZ1FidXBGNlk4Y1EvQVZMTVdnODVFSFJy?=
 =?utf-8?B?UFY3R296QlBoODZFR1JFd3VIcGxwd3pscm9tcUszcE5RVzh0bnlGa1MvVXlT?=
 =?utf-8?B?a3Rld0lzZktiZnVJWU5uc1hvazVvNW1tcm5JUUlHMVBSK1RwWGNhMmtwZ0Nh?=
 =?utf-8?B?Z0Rta29zdzBnVkV4SVhhWk5lTEN0aG9Wdm96aGc3K3BRanRpL29PaVMvYmtD?=
 =?utf-8?B?UGU5emY5dlZzT3BGZmRRWC9DeVZ1TWxhTkNtT2tnNFpyU1NyMkZTSzR2aXlO?=
 =?utf-8?B?RVdDVHBIYllFd1dwNFZ1aTc1RXdtL29FVTg0OUdWbUc1cXZLRmM5dnVDZGxh?=
 =?utf-8?B?WW1qM3JkSCtFRmxiRUh2eG1MeXV5ZjVoSCsxUWV2aVFlK3l1bm1QaGl5bEFu?=
 =?utf-8?B?SlN0S1o5bmJ0QUpXeDBqRWNiVDVpWlZ5NVlZQjNLaTJSY0N6M3o4N3hUQW9G?=
 =?utf-8?B?eXFraGs1bHNoRnR2eDRWMVlvWkJseFg1L3hVQXp0SkdwYmRWemFURmJkUW5v?=
 =?utf-8?B?bUl3Q1JHKzVGQ0VZc1BNYVZBbjB4NG5STlp6S29ZRWdMbWVmK1N0a1JSWXRt?=
 =?utf-8?B?UG9CanFXWEU3S09jeWU1T1U0c2xkL1ppb0hlaGg5T0Yvb2FHNDM1R0JFR3V3?=
 =?utf-8?B?TnJlK3RpQ2lTWHJiU2xZbUcvSlRnMVZIbWtSRTFsUFYvUnlrYTJhb2NJRHF0?=
 =?utf-8?B?STdtMWp4WkxPdnV3YWdzRENTZjN2Z09uUm5ka2xlZ1padi9Oc0Zndm1jSXdO?=
 =?utf-8?B?ZXovblE1MkNKcktlYTZnMjV2WUpHQjVtZjc2ay9EV1Y4dytJZUU2Z1RmcWJu?=
 =?utf-8?B?empTNmZFWUV6U3hvNHB0Vlkvb2FRTGZ6bUpHazN0Z01idGF4MTdBWjBNOGN0?=
 =?utf-8?B?VlFjZ1FtbkZEaGk3K1pVd0QwV0dEekNQWE9WQWpNdStzM3IwSWY3TFFvRncw?=
 =?utf-8?B?dlpCbDRlYWpHZkRxNmM5NXVYYnNnSzVvTFNBdlRkMUdacVMyNjhlRGpxa213?=
 =?utf-8?B?NkZxUldkdTd5Mnl2WG1WK0x3ZmduT09qYmdBTDdvOGNPbmtlMUNEenh5dXhJ?=
 =?utf-8?B?TVkzdGNBcG9DUzZMNm9Mc0p3MXJlaEg1Q1Z3cFQ3Q05nMGpqU1VNTUVhUlhB?=
 =?utf-8?B?YldWYUN4TjE0ZjZNNzJrenpxM3d1RWgxVndCT1liaWhiK2JWcmgwOU5ZNFBI?=
 =?utf-8?B?TE1BZG5xb1h4c3YzcGFXMmVBVENadWNQL1pqM015TFRHeFE4Tm9TQjM0MFNp?=
 =?utf-8?B?dTZGdUFkY1d1ZkphUUlGcitjNklSdzJuOXBUc3lWMWdNR1l2ZkxYMUlSRUpo?=
 =?utf-8?B?clRubTVuMXp6c25QWjJROGp0Y3o4UUlsOUFrQUZ2M2J0eTg3YXMxOTNnSFlO?=
 =?utf-8?B?eHNVcXpZNmd0d0pYU1RKUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejRiSWZhOWNBY2N3YUJDdGFlMnFTL1czUjh4NEpYYUYxd0xLODNXdXRZNW5F?=
 =?utf-8?B?V0U2Zy9BMXdsR21YelVCcTRIZ0ZIdEFaeW9WZCtsaVJObHB0L3ZDM0dZa01O?=
 =?utf-8?B?S3h5VWdUL3V3NkFWdWdFbVpIOVhWSHhoREp5UHl5aHdlQjNuenhiS0JIY3Jn?=
 =?utf-8?B?ZkRaT0lEL0pPY0NEZHJWelRJb3Z1bTQxeFRpYVVWVzBVOWE1eUdmOEpST3hT?=
 =?utf-8?B?ZGYrZmVrd0xRU2VhR2dYRXk0eUpPb2IxNDQ3dXdNT2ZKbWhIcUpOQlhtVzBR?=
 =?utf-8?B?SHZvNHlRMU92bzkrQlFSeHMzU1hhckROS1ZLTE11dFdkVHQwRXhQQVBOWjFK?=
 =?utf-8?B?TnJEZ2VNSzErRVpkY203SWVzbWRmNTRBVUI5UTQraHRJL2JWMEdHMXp5YkZR?=
 =?utf-8?B?K1FrY3F3L3lJNEkwWEFBdEYwenVYL2dtNUNoSWFsRWxibzRZamN2aEcyby94?=
 =?utf-8?B?Q1RkU3BpWjhSd1cwRVJSR2ZDbm5VY2dDYk1CZVVaR3JZNjBsRk5aSXQxVVl0?=
 =?utf-8?B?dExXYnBLQ3RuZ0l2cC9IMklMSldZak5IY2VCeWp3RG14L3ZiNWVYbXVDSWZB?=
 =?utf-8?B?MEwyRjJIMzgrd0F4TEhmUVRzV2U1enN5L0h6MW9kWVNUTkM4OXZkZGM5dHY0?=
 =?utf-8?B?Y2d4K1ZyM1JPNENkQWVvazJtRTFuS2dFY2JZRHVFZmVEQTJrM3FIU0wvNVpQ?=
 =?utf-8?B?Q1U2S0ZxVUo5U1UxRG9IZGxwdk9sUGZtaWU3ZUVHVGNqY0lnUDYrM1I0c05j?=
 =?utf-8?B?VFFTdmduS3Rvc0I3UnREUzA5c05QZTVaY2ZlS3ZOZzBjK1ByZWZBYXJJVlJp?=
 =?utf-8?B?N1hNaVZhaG9ocUlVcDNIVTV2aWRNWWhnNFlVeW5RT2ZuSm1ZcHcyVTVDTXRE?=
 =?utf-8?B?M2tJdDlDUFEvQVlQa2dFTk8rQzVvUkFjZDFKWUdXeDgwYXVOMC9RayszSkEr?=
 =?utf-8?B?VTZ1WUVjZVpHaHJ3SXdNWVJVOTAzWFl0aXcxNnh4Ly9DaEFqTE02bkpSU3dr?=
 =?utf-8?B?VEw1bHJQdHhwMUdYRU83UEVZMTYyaVlqdGFoT2YyOWZmWEd5ZmtDTnQvRFJ4?=
 =?utf-8?B?RE9XTlNpSGtMa1VteVZBeXpHVHhNQUU3ODZTTS9GVXRRTmx3YjZxTTNCZGds?=
 =?utf-8?B?WXZNektMN1BCVHFRb0VyUk5ZTUFlNWJQWUd3MmV3SXFBWjFEaXc3Ty9PaU1y?=
 =?utf-8?B?MmlDVEc5dkNUSEFEeEUyM2xqNE1nQXloci9PWXA3SndjTGFadXpCejRPQWEr?=
 =?utf-8?B?bGhGSFJDZllxNGxOeGhLdkg0TnlVd0wrVmVpWER2RVdBRi9ZZTNFL1M3T21h?=
 =?utf-8?B?WDYxRDU5OWQvYmdMRlZsRUN4MnBGQzY3T1RlNlgvTDRyZWF2Zk9mK0gvcXV4?=
 =?utf-8?B?dW1OWExLcDVsYlNWTDdKU2hxUThEeVBOVlF5NXR6dDZxNkh3UFA0YUNXMWNi?=
 =?utf-8?B?S2dvR0dHV1hwVjlKb3l5Q1BaZnBEVzV2WnZFRlZ1RzM0anNqemNmYm9wbHZB?=
 =?utf-8?B?UC8rNUY3REh6ZXhvcFArWE9XZGdMOU8zZkpHMEMvcWd1R2VJRVlZWDhPZVpk?=
 =?utf-8?B?Z0lCQkZqdlhpWkdkaFIxa2JoWmllUVVVZysrRWdEV0NpaGdJaER0eDZ6ZVVs?=
 =?utf-8?B?WmRnN3hnWlVuYk1mVFNXejJpL05vUTZQdHJBc2NpOTlHZ1U4aGxqTmh0a1JQ?=
 =?utf-8?B?NmtDeW5QNlR1RzIyTGtEaUJ3SHd3dVlRTGhrVFBGNjczVGFWKzNLV1g0ZWJn?=
 =?utf-8?B?RmU1emI2ZThwSmNhVlQvTS9jS040MTl2aXJOaFhEVEtJVnFyaEVURDZDcVkv?=
 =?utf-8?B?bjQzYWhEb2Q4ZytvUVRBMlB1ZHZsQVJrenYrT25LY05vaTFCYTVNb3R0M3lV?=
 =?utf-8?B?SG0wc1ZnWnJjdjlTN0ROM28wcFEreFFRYWRGZllHUmNOL3NZNitWNVVyMy8r?=
 =?utf-8?B?b2U5QlVMUzdNQk5rNTdRWk1vRnJkQU54bUtnbEV6ZmlYV2N5dWVDSlV2bXc2?=
 =?utf-8?B?OTB6YmVKWERLZDhtbkloS2tOT21pcVc4am1Ud3ZDR0VJYW5ocXMvQ2kyRzNn?=
 =?utf-8?B?c3BWdHUwT29zUHZnTTBFblpXaXRiQTlESFRVem5KWHJrYzNDNDllR1I2Qjc3?=
 =?utf-8?B?SjZJWHNjYVhrcm9kQlBPcFQxMFh0ZUliZFBIWklFaXNobG5aMEFDTVU2QmUx?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31FF30D31F12E94FA8061314F12EFE82@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a988798-89a6-4a1f-cc60-08dcc3864b31
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 15:14:33.3791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C77yHXFAOZCIktZ/8Q6S3ncujWC41e4zXVdgrf6RZwdOmlbvtlddzj7IXdfLoumIdq/ZPf7CvZaREF80i/Mh38MCHIGzSCcsoNW8kmnDprQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3944

SGkhDQoNCk9uIEZyaSwgMjAyNC0wOC0yMyBhdCAxODowNyArMDMwMCwgS2FsbGUgVmFsbyB3cm90
ZToNCj4gPiBSU04gSUUgbWlzc2luZyBpbiBiZWFjb24gaXMgbm9ybWFsIGluIG9wZW4gbmV0d29y
a3MuDQo+ID4gQXZvaWQgcmV0dXJuaW5nIC1FTk9ERVYgaW4gdGhpcyBjYXNlLg0KPiA+IA0KPiA+
IFN0ZXBzIHRvIHJlcHJvZHVjZToNCj4gPiANCj4gPiAkIGNhdCAvZXRjL3dwYV9zdXBwbGljYW50
LmNvbmYNCj4gPiBuZXR3b3JrPXsNCj4gPiDCoAlzc2lkPSJ0ZXN0TmV0Ig0KPiA+IMKgCW1vZGU9
Mg0KPiA+IMKgCWtleV9tZ210PU5PTkUNCj4gPiB9DQo+ID4gDQo+ID4gJCB3cGFfc3VwcGxpY2Fu
dCAtaXdsYW4wIC1jIC9ldGMvd3BhX3N1cHBsaWNhbnQuY29uZg0KPiA+IG5sODAyMTE6IEJlYWNv
biBzZXQgZmFpbGVkOiAtMjIgKEludmFsaWQgYXJndW1lbnQpDQo+ID4gRmFpbGVkIHRvIHNldCBi
ZWFjb24gcGFyYW1ldGVycw0KPiA+IEludGVyZmFjZSBpbml0aWFsaXphdGlvbiBmYWlsZWQNCj4g
PiB3bGFuMDogaW50ZXJmYWNlIHN0YXRlIFVOSU5JVElBTElaRUQtPkRJU0FCTEVEDQo+ID4gd2xh
bjA6IEFQLURJU0FCTEVEDQo+ID4gd2xhbjA6IFVuYWJsZSB0byBzZXR1cCBpbnRlcmZhY2UuDQo+
ID4gRmFpbGVkIHRvIGluaXRpYWxpemUgQVAgaW50ZXJmYWNlDQo+ID4gDQo+ID4gQWZ0ZXIgdGhl
IGNoYW5nZToNCj4gPiANCj4gPiAkIHdwYV9zdXBwbGljYW50IC1pd2xhbjAgLWMgL2V0Yy93cGFf
c3VwcGxpY2FudC5jb25mDQo+ID4gU3VjY2Vzc2Z1bGx5IGluaXRpYWxpemVkIHdwYV9zdXBwbGlj
YW50DQo+ID4gd2xhbjA6IGludGVyZmFjZSBzdGF0ZSBVTklOSVRJQUxJWkVELT5FTkFCTEVEDQo+
ID4gd2xhbjA6IEFQLUVOQUJMRUQNCj4gDQo+IEJUVyBleGNlbGxlbnQgY29tbWl0IG1lc3NhZ2Us
IGltbWVkaWF0ZWx5IG9idmlvdXMgd2hhdCB3YXMgdGhlIHByb2JsZW0NCj4gYW5kIGhvdyBpdCB3
YXMgdGVzdGVkLiBJIHdpc2ggZXZlcnlvbmUgd291bGQgZG8gdGhlIHNhbWUuDQoNClRoYW5rcyEN
Cg0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gRml4ZXM6IGZlMGE3Nzc2ZDRk
MSAoIndpZmk6IHdmeDogZml4IHBvc3NpYmxlIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBpbiB3
Znhfc2V0X21mcF9hcCgpIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4g
PGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4NCj4gDQo+IEkgdGhpbmsgdGhpcyBzaG91
bGQgZ28gdG8gd2lyZWxlc3MgdHJlZSBmb3IgdjYuMTEsIHJpZ2h0Pw0KDQpNYWtlcyBzZW5zZSB0
byBtZSEgU29ycnksIEkndmUgbWlzc2VkIHRoZSBwcm9wZXIgdGFnZ2luZyENCldoYXRldmVyIG1h
a2VzIGl0IGludG8gc3RhYmxlLiBJJ3ZlIGFscmVhZHkgdGVzdGVkIHY2LjEgYW5kIHY2Ljggd2hl
cmUgaXQgYXBwbGllcw0KYXMtaXMuDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5z
IEFHDQp3d3cuc2llbWVucy5jb20NCg==

