Return-Path: <linux-wireless+bounces-17300-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC73A08A2E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 09:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF1907A3EF1
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 08:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DD9207E07;
	Fri, 10 Jan 2025 08:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="rvJHPC1p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2000207E04;
	Fri, 10 Jan 2025 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736497892; cv=fail; b=Iaorh5/Il7iqIacArwjbHqTDx3EpxslyPVjtjT/BguGHESQMiXlPGWoVm5ajF8aT2eSoIOSdBvpYmmnKfhT13qcJ8UIEl+HPcGojr2Fw2w9n9r2omDsTRtjxbKYspME6NnqYkNNA68Q4qifOuUU0zDWGwjPhrom+2y4raL0HJ4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736497892; c=relaxed/simple;
	bh=WsJTtm3IZLpgCxuU655q0e4i/Zkyxvm8nTFhQIcOxow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kvgsHvIFxsVxX/Nmp2I2EPqJhIUEBjVrWzN2x+AESCn8GiUCLgxwvdwCMVVSQGPJ+YpSIX/TSlhII/YQxXHzgJkCuuuuwEPM+pXGxEP7/RZw2iDCT5IUn4i6yshDtVthUZCRxliRhN4C/YhNPnCzxs7f0wHvHZBU27rw1hx5i44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=rvJHPC1p; arc=fail smtp.client-ip=40.107.22.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SaZRyOEYLqVxA23PaD9Ez1vHTE8mwbPf7Zuak+RQLQbaZXdA7jVhTVHlXiH7HaSuVJM1aLsEGxyPHRBPTydUMPtT1/qJlQfxDpePjbQ2Q8uFHXtHmwLnai78iA4KXuRcKG3jNjYh0MmMcZFaz6ITzs7JLwLY99z5YBz8VKCe7rwxIZUL64Ml08DMKGW/BpjGgXwZdWMuDRk8zZICO29frWfbaL3l+XYYT93o6bqPgerSMAt7Vvp8a2NsQiaECU3gGGp141lEYgiu3U2t0ZB6JGyNDRtLIpacN0c+EYKbyyBLPGAWE3Pagwz+rWotpvkiihBQH+UO6BJ9V2drY3k/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsJTtm3IZLpgCxuU655q0e4i/Zkyxvm8nTFhQIcOxow=;
 b=mzFZvoWbzcDZqK5Z4QqtGQOi4JQviV1Aakn0hEkTliRhmwnPg8bzp/PWg+iBqAsjAgGMqbsXyOdOAel/Y9dl2B9CeN7j0/jxfQHiWjxX9mCH8jNu2Q/8OOBVvFfhb0JUiw1Ebk1lDdDLuScGC8QgUwGdHLrbu1VxWvjG5l8Wkesi5gDSbrgSX1bJDKz3G8zFqeSXYESLOFRgUOFZ5I/vqHjdQS2hN59POcAz+YIyvLUIIxmjTulRZCwVUoApcJ7En5b4Yq+zNl6lmYlEJ/MZponBdhin6Imb3qkyI9nGDT9xlBt+GyVIYELhu3rQlt9oeo2/s8i+pDTCEQNjeWkyow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsJTtm3IZLpgCxuU655q0e4i/Zkyxvm8nTFhQIcOxow=;
 b=rvJHPC1pLeVOUYpgFreDpxkTQXfO8YDYS4XlTAayGQHUrSqJ9B7R2nLr5WgulSoPvHGecl8Dz/0dJin0HEYvrK2kVloB0Q3ohxMuKe9aFBmJK0Bs7h9tUS1+xiUbO0XaeihmvSly/u/BvqyHKXP8NTl1I0JDZG6y0+fTu4kuPpQ=
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com (2603:10a6:10:1a0::11)
 by DB9PR06MB7642.eurprd06.prod.outlook.com (2603:10a6:10:256::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 08:31:27 +0000
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0]) by DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 08:31:27 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: rfkill-gpio: enable
 booting in blocked state
Thread-Topic: [PATCH net-next 1/2] dt-bindings: net: rfkill-gpio: enable
 booting in blocked state
Thread-Index: AQHbYzh2w1YJSGJUlk+ax+ZtkGGI2LMPraOA
Date: Fri, 10 Jan 2025 08:31:27 +0000
Message-ID: <eb2d95fd-ae79-4bab-b4f8-8fc56e10c7bc@leica-geosystems.com>
References: <20250110081902.1846296-1-catalin.popescu@leica-geosystems.com>
In-Reply-To: <20250110081902.1846296-1-catalin.popescu@leica-geosystems.com>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBAPR06MB6901:EE_|DB9PR06MB7642:EE_
x-ms-office365-filtering-correlation-id: 7ad77271-2f27-4108-0c66-08dd31512d3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZWNydUNkNU4xTDZ0MkNqRjhkZFNSQkhkelRBYWZWVDBVKzVHNWdvaDg0QTdH?=
 =?utf-8?B?MmV0VGI3ZDMxK2R1T0prbnFiak8rOVFBK3lsT1lTcFJwMncxanpNYnlicnpM?=
 =?utf-8?B?L251ZWY3WGpNWDM3dldhdXhEVldFbitiTU9wQlo2YWNWeit0bXdsWWJ6ZmRs?=
 =?utf-8?B?eU9BZWtrZ1cvWitKL1lpYmRRZjMxTWxiK2QzRGJwWkxJZ01RNEQyRnlBajBJ?=
 =?utf-8?B?Qk9jVm5iRVpkVzZ2bVBDa2Nyb3hUd1RiNmg5bTVqY2dsa0EwTkdsOHBhTHN5?=
 =?utf-8?B?SmhMQ1FtdzFGYUNicVdnbU1OQUlLTVlPYWJUQlpIVEVhT2w1clpUeFJDQU1w?=
 =?utf-8?B?V1RMM2tWNTdReWJTSkdwcmp2OTBUSW9HOEo3SEtKMk8wTjdmTmdlS05kNHpN?=
 =?utf-8?B?L3RjV09jeENRRVVYdys2ZG8ydGkwbUQ5WmowNVFnTHhqZWpEVTF2NTVRdWVq?=
 =?utf-8?B?K2RuS0pVSnM1aVRGRFVYeVdUclVQZmN4WWZGU0NZV3A2MEtPd2lOZm5kRUtQ?=
 =?utf-8?B?RUhiUkl1QUtlV3c1THNLN3ZEd2lCYUhnU0dlNmJmdEt1YUFCNm5Fc3kzS0M1?=
 =?utf-8?B?Q2lOM21nR3FVQkhPc21Ea3lYS0l4TEdJRng0WXRDZ1RDSzJuQ25idEJFZ2d6?=
 =?utf-8?B?K1BTT2tQeXhhZ0lnTzRINVlJa3pVakVWK0dLeVVCUzdqd2EwcitNTGptaXVP?=
 =?utf-8?B?d2x5VGVVNXViR2tzcmNWbWQ4TVZENGpobXhMK09yaHBvSXJnc1l4V0w5THBI?=
 =?utf-8?B?d3Uva0lTZnBPRVlhRUVkN0xSRlJqNHNLZjJkRzF5aTNZUzRodXpuL21lM2NU?=
 =?utf-8?B?WDY4QVJsRTREK3duYUZEZlJkdGVTNjViN0dmdkdhOWlieW9GbzY3VU01ZzZT?=
 =?utf-8?B?cGNlWlYyejR0Sm1KMzdXUTRudTFFZTFkWGtnejV0c3pRbDYwUVkzVDN4WW1V?=
 =?utf-8?B?YVZJU1hRQ1hzQTY4R0d2SnZtOGUvVDYrOFY0U056bEppbGNveHBIeSthdjJK?=
 =?utf-8?B?SGI3TUVDcFhraVo4cnMzd2txMTV4eDhMcmV4Z0xNUGtzMEhrdFhZTmJiNERM?=
 =?utf-8?B?dFNwa1J2OENoSitqWnJjS2ZnMWhYaWlROFJIU2RxVVl0bk54QU1zS05wM2lq?=
 =?utf-8?B?VU5aR28yTFZxZ0ZXeXNxZnBwNDRiNXZNVk1DTFpVRGtwL2o1VWU1ZkZRaHVy?=
 =?utf-8?B?aFJHUGV3V2xFRnJrR0RUOUxVN0FyalpZWlNTdnlUOGJrVlp1eXZoUFpmZXV0?=
 =?utf-8?B?R3FzcTh2c2lxZWhHdm9lTlV4R1VnMmYzNDBEZ3AzZ2F2WlUxUFB1eGpxR0kw?=
 =?utf-8?B?SDhQcmtMa0FrNWVWVWlEbXJ1Zm9qUzVhUHBjZVNrZkx3d1FyckpZbERVT0NX?=
 =?utf-8?B?c2k3blpXOGVEM0VvZkRKTTBqMDY0VXd0NWdCT1JOODZlUHEzU0haa01iY2Rs?=
 =?utf-8?B?NTlqMVJqNXlranVsQlFHbWxKdis4QUNpdEhOWHM3bVpGSC9GMjlvWm9XVGZl?=
 =?utf-8?B?Ulc1cmVIbXBkODBzT3pNd1hrd0dib2dsSm5uSW1hL2tGSUYwbUcyMDh3Y0pv?=
 =?utf-8?B?V2dzWHVWcXc3VUhhblhNZGNndjdtQlNoc21nWWV3dlRqb0NVbytaYVdKcE53?=
 =?utf-8?B?TytpbU1oR3NXT24rODA0cklZOFdSQmhHV2pWWDZZbXl4OVBUZUtXaUQvY29X?=
 =?utf-8?B?RkQ2dTdGL1dRczRjSEl0Ty90M1VLcHNmYW5VZ0hvQ1NJMkNFNkloRVdJM0FQ?=
 =?utf-8?B?MGZoOVdNUFpsNGtMMUM2L1JsSjd1S1UvQkRpNUZ4OU14ZUw3SjNRUDE0RlBB?=
 =?utf-8?B?OHhXK3VoeTVsNHVBYnd3cmRkaW1ZUGJQMUhHMlozTkYrakpCMTJ1YlVsUWVQ?=
 =?utf-8?B?Mkt1czJkOUxNNUZDL0ErZ2w2M1V5WjhUTklqR3d6Ni9tdk9ZVGFBcjczL3lP?=
 =?utf-8?B?UlVTZWNIeWVPVDJReEc0aWFVd1JrSUtHd0JKRmhXVDlrN3FCV1Q5K1RYekUr?=
 =?utf-8?B?VUh1ZHRWbGZnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR06MB6901.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGpXTnUra1pVdThDVVAwNnh1NXltc0UvWkxZSU1SeFNCTitsS2FYdndFQktV?=
 =?utf-8?B?VytvRnVVV0hDQTZrcVRObFpVRGx2dTZ2c0hzeVY5MzFHeEJUN3Q0d0FmUHFB?=
 =?utf-8?B?amFJTVVqZUlIa1RlSkdMb3NjT3pCQkdMaUZtdTUyUGJSd3VWRlBJVzJldlc0?=
 =?utf-8?B?SXhjWkVXWm8rRFFqWDBscnI4bVd3SlFrT0pNemFVbTRMQUQvZDFBN3ZINnE2?=
 =?utf-8?B?RDRZYnNWaHhndTJhNS9DRmJTeTJHaDA4MnkwYTdvdFJQQXlraWphbDZZZXZi?=
 =?utf-8?B?L3loc3ZPMnBPOVFlVUNrckRqaEI0U3JNWXZpZEdsZ1lIdU1tQ0RYY3JnMUk1?=
 =?utf-8?B?dUZ2Yk9KckpyWkE2NnlOTEtscHhqdkYrM0FXejZWc2JhQ2NtbU8rRVk0M1hn?=
 =?utf-8?B?cjZUNWlnRkcweE96N3l0RjJheXB4bTRmeGxJM2NhWjFoSjNoQnNEUXB3d0JE?=
 =?utf-8?B?TmY3WThydEZ4MzJHZGtZdy9QNFBlZldYcDJ0MjBEQzYxbEpwbW5rZ05GRGg4?=
 =?utf-8?B?V0xTYkRWV0ZJMUo1enRyNks0eWJiQ1JzRVJqejVHTitIdUQrSWhtbFBvcFNM?=
 =?utf-8?B?T0JJLzAxY1BhMWpwenYwSWVWTG9aK1B5MDZCMEc5TmQ0K3p4bkY0bmFVNmV0?=
 =?utf-8?B?TE15ZndidnlYSm5Tcm5HZFBwYWE4aVlOWVl3cmRpSGNOdHFzQXN2Q3NrWVg0?=
 =?utf-8?B?QS90QnNLaXgxeXU3eVZRYklTdVFJNE9LdVBOMWFwYWpQdVdvYTN5RGtreUlD?=
 =?utf-8?B?cUxCY3M2WWRmdE5xcWh3TnVMdlFweDN4eVFFbU52SnNhNGpMV1RXblJjb0gz?=
 =?utf-8?B?c2dPWHpoQ1N2RGdBUjhoUU91ekh6bjNoaVpyNnpKcm5UZ2pqNnB4ZkFuUmY1?=
 =?utf-8?B?dXVhV3VCRndkMzdpNVREVHNMMHpvUmtxVDAraWFNbUpoMURyZmo3WVpWM1Fx?=
 =?utf-8?B?QTJFYmY0WkhrMVc4cDVCVkdBNXFUWVRDZU9CM2xXUzN2U0lrcndIdjk5TkFz?=
 =?utf-8?B?eUxiSmIxb1NkL1c2RlJabVNaM2hPYUpkVGNSUlBHd3lWcFc5RVE1Q0ZBMFFt?=
 =?utf-8?B?S2gwSUUrUHl5eGw2b3UrVHFhRjg4QVhkNFY1RWpmVFdsWmV5UmJTQk9LbGVn?=
 =?utf-8?B?eWhZa0lXNVp2THlrSUxNSU1CY2VxV0NCYjlNeG13ZWNOYW5GRDRFUWNXQ3pt?=
 =?utf-8?B?Rlg5MndtWURtbGliVURMNkoyQ2xoc0ZKTUdhS3BjTXN5NzFycnRtYVJCanQx?=
 =?utf-8?B?b2UxWDNaVE9TanBJR3VMWTlLWDVmWU5YN0hGTytndkNoMlhBZWVlakxCZ2V3?=
 =?utf-8?B?TTdDZENtWEswd2FCbmRtYXBTSlZ3QTFWYTBzRXR2bjFBNHZ0L3NKc3pmaDlI?=
 =?utf-8?B?c2J4ZWliRTRpeGg3MlBvNDRNa1NXS1ZSdVdjVVliWHBrVTBBZkRubElNMDhv?=
 =?utf-8?B?bGRlR2R6MEdSZVhIWTFNYVpEbzI0em00M0xHZ043ZGh3aW0rbmZTU1h3bWxp?=
 =?utf-8?B?U0dTZVdIM1djam52WGx2SkRXMytZdXpEcHJYNXB1ZjVseEJWY1l1OWRDMElo?=
 =?utf-8?B?aEx2NFkvKzdaU0lYaEQyaFBPR080VGdrWDJqajJjczU3WWFoemlFalRDUVBV?=
 =?utf-8?B?UUNZbHd4b1UxUXp3a2pYS1llM0ZYR0ptNmxaUXlDak9JR1ZMOHAxeFFJSncr?=
 =?utf-8?B?b0NLR3JEZ2o0TFllbXo1T3hWYkZXaENEZnFsMUxacFdwT0xNV0ZudzlxOVBs?=
 =?utf-8?B?NXJnK0ZHK0IvODZoVU5KeFhFcHN0bFBIR3pEb1JZY3MyUDZ4VVRwQlFrY1NV?=
 =?utf-8?B?UGRKTVJnQ29GTzE1UXdpcUZWNHNmYlJMbG1hS0E2NXNUR0FwSGVZVEwrSXJp?=
 =?utf-8?B?a3R4NG1KT2FFazhXcVdjNGJHOHd5RG8xTUc3T3ZXWXM3Z1U4UGRZRlQ2aVEw?=
 =?utf-8?B?V1RiU0RNL01zVTZCWkdWRWJvZHlOVVdjWEdkWDMwbFJZbUNIeWVXQ1huRjU0?=
 =?utf-8?B?Vy96Tk9ERXZkZFFsNGJYS3EzdmZWL2FmN0xUZTFMc3g4emFpMjRadzVlcGx1?=
 =?utf-8?B?WjNCRmIyWTIzSm9nR2QxRHd1U21wYTBqa2dnUlZiZ25VOWN2VjlsK2JLR2JV?=
 =?utf-8?B?cThsYnBwbmQ3ZW1MaWtzdzdPMzA4L3ZXQlNVc3M1OHdJMU1wY2t5VUhUSTV3?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CC071C023B4DA40A86309BE81D820FE@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBAPR06MB6901.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad77271-2f27-4108-0c66-08dd31512d3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 08:31:27.7388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c66uxVd4VP85wFMIe7RZ8eo/7iFVqIybjZpJZp6hWr/FHjRDI91KTCO6/NFYJMKaNk+jschBJpaodiuUNejTmVVjhahIL9xfnqXCLPnoouckLn+iTXL+wJcYHwm2CqRm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7642

RHVlIHRvIHR5cG8gaW4gbXkgc2VuZC1lbWFpbCBjb21tYW5kLCBzb21lIHJlY2lwaWVudHMgd2Vy
ZSB0cnVuY2F0ZWQuDQpBZGRpbmcgdGhlbSBoZXJlLg0KDQpCUiwNCkNhdGFsaW4NCg0KT24gMTAv
MDEvMjAyNSAwOToxOSwgQ2F0YWxpbiBQb3Blc2N1IHdyb3RlOg0KPiBCeSBkZWZhdWx0LCByZmtp
bGwgc3RhdGUgaXMgc2V0IHRvIHVuYmxvY2tlZC4gU29tZXRpbWVzLCB3ZSB3YW50IHRvIGJvb3QN
Cj4gaW4gYmxvY2tlZCBzdGF0ZSBhbmQgbGV0IHRoZSBhcHBsaWNhdGlvbiB1bmJsb2NrIHRoZSBy
ZmtpbGwuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IENhdGFsaW4gUG9wZXNjdSA8Y2F0YWxpbi5wb3Bl
c2N1QGxlaWNhLWdlb3N5c3RlbXMuY29tPg0KPiAtLS0NCj4gICBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbmV0L3Jma2lsbC1ncGlvLnlhbWwgfCA1ICsrKysrDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9yZmtpbGwtZ3Bpby55YW1sIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9yZmtpbGwtZ3Bpby55YW1sDQo+IGluZGV4IDk2MzBj
ODQ2NmZhYy4uMjJmMjZmMWEzODU2IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbmV0L3Jma2lsbC1ncGlvLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9yZmtpbGwtZ3Bpby55YW1sDQo+IEBAIC0zMiw2ICsz
MiwxMCBAQCBwcm9wZXJ0aWVzOg0KPiAgICAgc2h1dGRvd24tZ3Bpb3M6DQo+ICAgICAgIG1heEl0
ZW1zOiAxDQo+ICAgDQo+ICsgIGRlZmF1bHQtYmxvY2tlZDoNCj4gKyAgICBkZXNjcmlwdGlvbjog
Y29uZmlndXJlIHJma2lsbCBzdGF0ZSBhcyBibG9ja2VkIGF0IGJvb3QNCj4gKyAgICB0eXBlOiBi
b29sZWFuDQo+ICsNCj4gICByZXF1aXJlZDoNCj4gICAgIC0gY29tcGF0aWJsZQ0KPiAgICAgLSBy
YWRpby10eXBlDQo+IEBAIC00OCw0ICs1Miw1IEBAIGV4YW1wbGVzOg0KPiAgICAgICAgICAgbGFi
ZWwgPSAicmZraWxsLXBjaWUtd2xhbiI7DQo+ICAgICAgICAgICByYWRpby10eXBlID0gIndsYW4i
Ow0KPiAgICAgICAgICAgc2h1dGRvd24tZ3Bpb3MgPSA8JmdwaW8yIDI1IEdQSU9fQUNUSVZFX0hJ
R0g+Ow0KPiArICAgICAgICBkZWZhdWx0LWJsb2NrZWQ7DQo+ICAgICAgIH07DQo+DQo+IGJhc2Ut
Y29tbWl0OiAyNWNjNDY5ZDZkMzQ0ZjU3NzJlOWZiNmE1Y2Y5ZDgyYTY5MGFmZTY4DQo+IHByZXJl
cXVpc2l0ZS1wYXRjaC1pZDogMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MA0KDQoNCg==

