Return-Path: <linux-wireless+bounces-8049-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F458CEC45
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2024 00:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C5A1F222F9
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 22:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A50433C9;
	Fri, 24 May 2024 22:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WQuQtQJi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2040.outbound.protection.outlook.com [40.107.13.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AF922334;
	Fri, 24 May 2024 22:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716588059; cv=fail; b=qcNbcoSAyGMHlbsDY9ZBa/alEuo9ShhFRaM6/UD/grbfj8bTWct/MyqTHHsITHVPGHbrwY6Pm31dbzThpOpMqTSOi4pOkMNjchLpUkKzsZA+3oTU0Fwj/+nOiz6X47jxV286j75hmqruNyYojzUnwpz28b9KZjT2zZq3ndC0dxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716588059; c=relaxed/simple;
	bh=UFzbt9J5Jsm7IMwMS0VoiJbJ/71qF6pjCI7tvScxr9Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ouc0xRcoja4Z67qvrPP38UMNe3TYepcngyqLFuuddzXptRErQNWLCKPp3l3WMINN9yh1Fk+2wAUhXvNn0IsBvONFQNhIo0h0hdGBAphHTUgZgS0d1LNquCQkWPO4CcTRDyhmtSh6q+b89PAcxAu7o267LpyLxuvzToBZn9WpSpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WQuQtQJi; arc=fail smtp.client-ip=40.107.13.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILEhT2rkeGuPc25V1LMByvBIoRNtrm4xVdwy94Gg6oRzrcPjvkGXkm+Pc9/o7YkCc4aTkMPXI3ri9NTbIKIyyAjtPVZyZ9T4ngLLq2ikt/oGplYfCMiAaECgtmsWIsx7Cd/iCn+JzBanG4o2gX24mXmwIbX1N7DZnQ9t2XhvdcVjkXGfiPOgyLM4aUb5+xEGEnubftsa9R3RSuXEkf0ffrVurffFY9Tkm+NyA2AXllFj+axNct9u1UghRPgS96k5TtngtWwyPmbcSjWhzC1LrA4bm7810cePtqlILZli7VBbS7IUJ51FINUVStdDy0EQuTa6Fkt4PhOQ0P43WyS3nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFzbt9J5Jsm7IMwMS0VoiJbJ/71qF6pjCI7tvScxr9Q=;
 b=SkIn80GwiDvNftS0pKGWLEyduwvndJpzFMvd8XTk8NVcwixLxA68YRevmKsfFC0jm8bbbvph75ZtYxbEqD92WsWljnVtP0LA1/1w7CT83dAwrEBWS7sf+AQkWGTSuAAjxkWwCmjwlj77qU/04K6EAkQT+mE24sT1+zVEEeU7xh6zdmZI1OfBnh1mCC7pl77qyKGF92FbGG9t8BVZDIs6AjB5lBZQWvwL5OVTOJWc+5gubvTPTxrMyR84XgWyJ10TIa9nUQpn6vOG51Ij4kUW7vdzWFuYzDxjQcMVjiVzadnSuag3kPmGDJHG9mnRk5nhttEclHxzHFnjnLWY35ng+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFzbt9J5Jsm7IMwMS0VoiJbJ/71qF6pjCI7tvScxr9Q=;
 b=WQuQtQJi0JZM+/5wEhgaylkj985J8TkgkZHUlnggdYqqNMayUW1j3Y/ilue4ygNvFYJkUQL/b8aCfTcTtwJZrzU+qqnGQYEEa0uhupSTQDqcglKdT38rMsVE/68xI1+ApePHsn+svdCGAdWvmt32dcUl9yK9/IwntpXAv9bpu/c=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PA1PR04MB10416.eurprd04.prod.outlook.com (2603:10a6:102:446::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 22:00:53 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 22:00:52 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Brian Norris <briannorris@chromium.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "francesco@dolcini.it"
	<francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, Francesco
 Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for client
 mode
Thread-Topic: [EXT] Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for
 client mode
Thread-Index: AQHakVadTJiKH7Fbwkii2Ljo0AqkAbGkNJ4AgAIC2FCAAJ4RgIAAUeEw
Date: Fri, 24 May 2024 22:00:52 +0000
Message-ID:
 <PA4PR04MB963875C85CFFA0EE2E914BEAD1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <20240418060626.431202-2-yu-hao.lin@nxp.com> <Zk6TklTIbxZxIWyb@google.com>
 <PA4PR04MB9638DC958102D07A7B7084B6D1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXOE2Pwv3kRhwkAd1e3+U8zxZi7cX0TeLDkycQya9xkdPA@mail.gmail.com>
In-Reply-To:
 <CA+ASDXOE2Pwv3kRhwkAd1e3+U8zxZi7cX0TeLDkycQya9xkdPA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PA1PR04MB10416:EE_
x-ms-office365-filtering-correlation-id: 278c1e8f-876d-4b47-1d7f-08dc7c3cfad7
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?eXJXcllaaVhlbVNHbm4xM0d3TWhLc1pHL1RWSytjbE91dVBVOFU3anVYZ09h?=
 =?utf-8?B?UzVHVVFQbWx2aDFhYzFvZGw3QlZ5bFRIWTZQV3FDYjgrc01uTE15UGh3OW9j?=
 =?utf-8?B?TWpwYnNCekQ5NThYWHRBYnM2RnJ1TURYbVlmTDZydWRFSG01a1BYbHdYWmto?=
 =?utf-8?B?VTkzTFhlTitwbkNqTlQzOW9iM0NJQnFmU0hCbGZmRjdoWVRmcUVKbFE2cTBB?=
 =?utf-8?B?dkZUVVVCWHA5Vi9OdVRpYU9yMmNQMFFqYVZkY25Fc2V4TDM2SzI2MTV0NWdU?=
 =?utf-8?B?KzZZbk1McDFGQy9KZ09aZURBUDB4a0djQzJOSlBydUVuLzFuRy9vdVhBNXFm?=
 =?utf-8?B?UlRVdUxCZlhBMWN6WUpmYWxnSGJ2TWVGTzhzUTJMNW1tVjh1VHY2L3FuR0lK?=
 =?utf-8?B?aU5CMUtWZGNYQks0UDVLUGdrQmREbEhkWjdnUi9Lc3hFcVpHd2NKclVEKzlC?=
 =?utf-8?B?THhHR2h2MlV0alAxRmpjRW5VblgxTEsvZ3dsSFpJODNVSEpuTGRwOFdZMk96?=
 =?utf-8?B?OGY0eTFkTzhhN0lISnlFZ2NVbGorVDNKbW9pVDRFUzZxN0FPb3pNSk94SGg0?=
 =?utf-8?B?N1RQd2hNOVhFSmNDZk16VGFuemRJeHFsa3FmYitqeHJqemhYdm9id0FrZm5F?=
 =?utf-8?B?eVZ0L2NSdEtvSEViUWxoTm4wTlM0NTJubmtkdkZuVG1FZEpHZmpJaWRNV0Ix?=
 =?utf-8?B?MHBGQ3VWKzRKM0xPUTE1WnkzMEN5QWpzY213c1VJWi9xYitkNkdFVjRzYzJJ?=
 =?utf-8?B?blAxeDQ3VzBIOVp0bTlyVFFRUENWRUUrcjdHRUZEOVFISkNxU1B4T25zTzcw?=
 =?utf-8?B?M0YydEt3ZnEydURTMnp5bmQ0WTE1VkNPd3NLQXRPTHVHdkxNeitkaXc4RVNn?=
 =?utf-8?B?V0FUVktUQnFkbFo2S3dRVExXTFFpME5qU3N5NG91eFhiQ01kVk50aGk4TXIx?=
 =?utf-8?B?NlBJaEZOdXg3T1F4TzkxMU92a0NlUy9TTHQ0NFpnL3VWc3EyV0RnVVNtajBp?=
 =?utf-8?B?dmRCWThaOERjeDN3MTVZbkFtUldpanBVQTBPcGl2aEUwNlpzWjY3TzJlRnJo?=
 =?utf-8?B?eFRvaFAwZHF2QnhCTkdLUTA1SUtkQ3JGK3Aza3VvTTg4RlhEMS9hTlZGUWNJ?=
 =?utf-8?B?ZHUzaE5zMmVLeGNLblQweG1HK1puZlNXUk1zN0ZIUmJzV2dmRXpiemZJbTJn?=
 =?utf-8?B?ZjVOU1VVdmNHNTRwTCtUeE1Wb2pxelFGRWc0MUhLR0RNTTZTb0RhVUN5L1dE?=
 =?utf-8?B?S0NlRXVxMXJsdmR3dWRKS2l0RVRiUUpNNFFxYjJpZnYwb0tENTZIMUYrZXor?=
 =?utf-8?B?dXpPMFkwNEFrSTdRQ29tQnZUdlVjVm16YjdZcUFGOXFlcWtjQjc4U3ZOUTMy?=
 =?utf-8?B?NDdCKzJhalo1NUk4MUI4RW5oMmozRC9SQjlCT0lseUxUb0xBWWhCWks3Tmpn?=
 =?utf-8?B?eXU2VVJQNk9idmJsU2lKNEFCN0FSbS9zamZmTm1mWmZXMC91am83MnJlQjdo?=
 =?utf-8?B?SmpIRFIzdHkzekVsTXJjd3ZuQ3BlVGV0eXlvZC9wRkptWWdkKzZnMjFFWVV6?=
 =?utf-8?B?L1hyT2hjREVLdTYzV0VUYU9NTElMbkFBcElsL1NhWTgvTEpEUCs2czR2RVo5?=
 =?utf-8?B?K0kyQm5vcWdEb0FudFhMYXVUS2FkS256Qm1yUjcyeEJ0ZVpnaW9nVkVscTNy?=
 =?utf-8?B?QnBsc0RwQW9ianE3VWMrU1U5bTVZekhweHUzT01UMTE0Z0cwakpvWDBBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZDZieXpCcEJkRS9ldDYxaGwxRlo0UHNnZ1A2U0FKOGlqMXJOa1NiRWNOeGpK?=
 =?utf-8?B?aXQ0NkF2c2x6cHRpMnh6bUdoU1o3L3I5R3JKYk9qZHVMaVh0SGMzWWs4aHMy?=
 =?utf-8?B?a0hiNXMvWHg0ajR2d25CUE1vUFdDYStXN21FY3BPK3dyZCtSeTh4Zk5XMzhM?=
 =?utf-8?B?QUZGY0dHZlFrcTZCb1VGT0tUR0Z1RERoTEFRTFVZUDh5YmFTQXRUWXExUW9J?=
 =?utf-8?B?K1UyS3h3bURtK2VGRzdJUzlxUVk3ZUM1R1I0VVBPb0tSdE02amREdHRpc0t0?=
 =?utf-8?B?UmhxQnVRS21MZkd3MU1jQ3NudU55R0Z1Qml1Rkl2eXZjQ0VQeHNPZ0lidXNF?=
 =?utf-8?B?QUJCbFo2QmVSQlhLY284b2ZsRndWaGVTYmVYWUo1OFlsR2xvWFg0MGRDbU9N?=
 =?utf-8?B?WFEydnZqelk0SmY3blc3STA5bVpYY0pWN29NRGhlNzc0Mld5Qm9ucFRTMEdU?=
 =?utf-8?B?V1AwSWgxb2Vud1pVaVo3VVZseVJDd0d6NldTQURQZGxSck1QRS9aRGQrMHBk?=
 =?utf-8?B?TkMwT3FoZld1Yk5ZcFNMYmR1STJmY0pXdWVlMm1vR25ZdzJQYU9VdW5TNEts?=
 =?utf-8?B?cWxKTHJkcHRXNzZtWnlpWUI3L2Z0YUxYbkh2eVdLakoyN0s1N1plUFAvNFVu?=
 =?utf-8?B?MUFIK0JvczZZZ0JtQ0JsNE9QTkVXY0Y0S2d4VzJqN1VRWnhmOVRJMWljNXJV?=
 =?utf-8?B?dnFmMGxyTm11bkdnMTVKQ0YwYWZENHdCcTFhdUphSm1HRm9BM2JlMjExS3JO?=
 =?utf-8?B?aFRFeUhhcWFSMzFGT2FKdHVmcDNRaSt0NExKa2FuTU5DUjBOaWxwYUJqTUZy?=
 =?utf-8?B?cGp0aE1WMDNMNXBPZCs4WGZRaDRPM1hOMkNnM3B0WkVIM25PR3dmU0NTUzc1?=
 =?utf-8?B?MGZMeE5Za1NTRGtMY0FkSnJhS3BkZURYZHlva2dGdlpCbnd2L0pHdG9Pd1dY?=
 =?utf-8?B?SytDY1pJV2FVT3JVMDRpRlNwT3FpdFA3MlJIV1I4ZjV1YjJzUm1pWmIwRERt?=
 =?utf-8?B?NVo3emhES1NKb0xSOUlGd2Q1LzJaTkxWQVFiZHZvMzNmYno4c2tSYnFxaGtF?=
 =?utf-8?B?OGdJSGJQNXhGeXlFd09QNERwUExxb2RaT3gxNXpvWG1vL0E3emkvaHAyMjVy?=
 =?utf-8?B?dmhOd3pCK1BLV01lVDIwQk9NZ0h2UG0wMmhyL2V0M0g2TmJDd2plaVMzMGhj?=
 =?utf-8?B?WFg2dEtHYVdSSmFtaU1ndVdxeDExLytSa3FFa2lLVDBISHVuN1hPdU5mMDFj?=
 =?utf-8?B?bXE4MW82VDNwaXE5VEJJSW9McFk1MXlXN2R3SlArYytZMElQdlNDcFRpL1U3?=
 =?utf-8?B?T1ZLcGlianVYbzNaTUk0RDFhT1AyeVdaMDRzSFBpUEUvbjFLalphYXBEcFNk?=
 =?utf-8?B?TzVnQmhubGlrcStkWU12S1U1N21kQTBZcXdFbWFmQkthZHRYbmRoN3R1U2Z3?=
 =?utf-8?B?WVJRYzZIVlZ5TUZUeEM5Mmk3YlNOMlJ5UjA4amg5ODFWdGhaSG1NSXpTLzdF?=
 =?utf-8?B?SStWbVdjSlhsNlEwblRlT0xFdHJJTTRuQnBEbWEzSE1pSS9iNFJUS0cyZWhk?=
 =?utf-8?B?dm9GMXhoZmpFMStBU1NYbUlIWTIzQkF2b2ZGTGtTTWhNTHZjR0xYNVBlWUpy?=
 =?utf-8?B?STFaR0Y0eVgvWU9LbWhzVG50MWxrRU9nbVRLdXhNNzBxTktoVWlMaDdVa1U4?=
 =?utf-8?B?Y20yVFpSQlM0Tk1JNldGZFhCMTVXdzdFTlk3SjNYbS9WNzEwK205amJ3cHVo?=
 =?utf-8?B?UEZ5UW0xSmlVanc5MGpwYjZLc2JZNk01NzZua3lnWkNzSVVEM09hczZVV2lN?=
 =?utf-8?B?czlUcVhBZ2ZudnZNcXdqZUhVald1dHFMY0wrelZabWNMdklIcGJvblVqcTln?=
 =?utf-8?B?MmtOMnhiYkRGWFU1UzZmWVVsRnBnc1BSWVZoSHk0eUU0WU8vRUdTTlg5cEI3?=
 =?utf-8?B?Tlk2cXB6ci9FZlJ4cjNPT3l1KzY3M0RzbEJ6L1BsWFEwRmtuNGpvV2lBNThN?=
 =?utf-8?B?K0RhQ0hBb2FubnNlbTRuNFRmWFRiTkk3MUxVSG5pRnBONHRxUjZiWWdEOW04?=
 =?utf-8?B?aXp1Wm1FckZ2bXdpSGJyQWRNNUxXSVZZRnJVMlRHUGhrcDl3V3FUbmpxVmc0?=
 =?utf-8?Q?3hPSqT2HlKF9WEe2WXOxaH5vc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278c1e8f-876d-4b47-1d7f-08dc7c3cfad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 22:00:52.7585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lCsLopq52dZcZHUgZ1gLk90shxLl8dRiIGVE3TjPsSCAPfOxkZEQX6tr3WzkhbOXtkgZ6uBuxeaN3a6q8s/zGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10416

PiBGcm9tOiBCcmlhbiBOb3JyaXMgPGJyaWFubm9ycmlzQGNocm9taXVtLm9yZz4NCj4gU2VudDog
U2F0dXJkYXksIE1heSAyNSwgMjAyNCAxOjAyIEFNDQo+IFRvOiBEYXZpZCBMaW4gPHl1LWhhby5s
aW5AbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga3ZhbG9Aa2VybmVsLm9yZzsgZnJhbmNlc2NvQGRv
bGNpbmkuaXQ7IFBldGUgSHNpZWgNCj4gPHRzdW5nLWhzaWVuLmhzaWVoQG54cC5jb20+OyBGcmFu
Y2VzY28gRG9sY2luaQ0KPiA8ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbRVhUXSBSZTogW1BBVENIIHYxMCAxLzJdIHdpZmk6IG13aWZpZXg6IGFkZCBob3N0
IG1sbWUgZm9yIGNsaWVudA0KPiBtb2RlDQo+IA0KPiBPbiBGcmksIE1heSAyNCwgMjAyNCBhdCAy
OjQ24oCvQU0gRGF2aWQgTGluIDx5dS1oYW8ubGluQG54cC5jb20+IHdyb3RlOg0KPiA+ID4gRnJv
bTogQnJpYW4gTm9ycmlzIDxicmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc+DQo+ID4gPg0KPiA+ID4g
T24gVGh1LCBBcHIgMTgsIDIwMjQgYXQgMDI6MDY6MjVQTSArMDgwMCwgRGF2aWQgTGluIHdyb3Rl
Og0KPiA+ID4gPiArc3RhdGljIGludA0KPiA+ID4gPiArbXdpZmlleF9jZmc4MDIxMV9wcm9iZV9j
bGllbnQoc3RydWN0IHdpcGh5ICp3aXBoeSwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIGNvbnN0IHU4DQo+ICpwZWVyLA0KPiA+ID4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgdTY0ICpjb29raWUpIHsNCj4gPiA+ID4gKyAg
ICAgcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPg0KPiA+
ID4gPiArICAgICAgICAgICAgIG13aWZpZXhfY2ZnODAyMTFfb3BzLnByb2JlX2NsaWVudCA9DQo+
ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBtd2lmaWV4X2NmZzgwMjExX3Byb2JlX2NsaWVu
dDsNCj4gPiA+DQo+ID4gPiBGb3IgdGhlIHJlY29yZCwgSSBmZWVsIGxpa2UgdGhpcyBxdWVzdGlv
biB3YXMgbm90IGFkZXF1YXRlbHkgaGFuZGxlZCBmcm9tDQo+IHY4Lg0KPiA+ID4gVGhhdCB0aHJl
YWQgaXM6DQo+ID4gPg0KPiA+ID4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5v
dXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbG8NCj4gPiA+DQo+IHJlLmtlcm4lMkYmZGF0
YT0wNSU3QzAyJTdDeXUtaGFvLmxpbiU0MG54cC5jb20lN0MyODE2YTMxMzVlZGQ0NDUNCj4gZDNh
NA0KPiA+ID4NCj4gNTA4ZGM3YzEzNDg1ZSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAx
NjM1JTdDMCU3QzAlN0M2Mzg1DQo+IDIxNjY5DQo+ID4gPg0KPiA0NTUzNjMyNDYlN0NVbmtub3du
JTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaQ0KPiBWMmx1TXoNCj4g
PiA+DQo+IElpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMCU3QyU3QyU3QyZzZGF0
YT1Tc0IlMkZEMWRVWA0KPiAlMkZaRA0KPiA+ID4galU0TVd1cnNyRm4zV1JmU002ZjNoJTJGbmQw
RlpNWW0wJTNEJnJlc2VydmVkPTANCj4gPiA+DQo+IGVsLm9yZyUyRmFsbCUyRkNBJTJCQVNEWE0x
UEVNUnl4UnBCcnlKN0c2ZTd5ekc4S3UlMkJnMl9xcEhOM2c1DQo+IGQNCj4gPiA+DQo+IGpGcEFX
a3clNDBtYWlsLmdtYWlsLmNvbSUyRiZkYXRhPTA1JTdDMDIlN0N5dS1oYW8ubGluJTQwbnhwLmNv
bQ0KPiAlDQo+ID4gPg0KPiA3QzBiNjVmN2U0YTVmYzQ2YzhiZGJjMDhkYzdhYzJjOWZmJTdDNjg2
ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDENCj4gPiA+DQo+IDYzNSU3QzAlN0MwJTdDNjM4NTIw
MjI0MjI3ODc2NzIwJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5Sg0KPiA+ID4NCj4gV0lqb2lN
QzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNE
JTcNCj4gPiA+DQo+IEMwJTdDJTdDJTdDJnNkYXRhPU1wcVcxVTR5VGdEY00wZzIwRFJTQXhFbkhr
Tk5rZDJod3NaclZBeGc4DQo+IHANCj4gPiA+IHclM0QmcmVzZXJ2ZWQ9MA0KPiA+ID4gUmU6IFtF
WFRdIFJlOiBbUEFUQ0ggdjggMS8yXSB3aWZpOiBtd2lmaWV4OiBhZGQgaG9zdCBtbG1lIGZvciBj
bGllbnQNCj4gPiA+IG1vZGUNCj4gPg0KPiA+IFRoZSBkaWZmZXJlbmNlIHdpdGggYW5kIHdpdGhv
dXQgaG9va2luZyBwcm9iZV9jbGllbnQoKSBpcyB0aGF0DQo+ICJwb2xsX2NvbW1hbmRfc3VwcG9y
dGVkIiBvZiBob3N0YXBkIHdpbGwgYmUgc2V0IG9yIG5vdC4NCj4gPiBJZiAicG9sbF9jb21tYW5k
X3N1cHBvcnRlZCIgaXMgbm90IHNldCAod29uJ3QgaG9vayBwcm9iZV9jbGllbnQpLCBpdA0KPiA+
IHdpbGwgbGV0IGhvc3RhcGQgdG8gc2V0ICJ1c2VfbW9uaXRvciIgYW5kIGNsaWVudCBjYW4ndCBj
b25uZWN0IHRvIEFQLg0KPiANCj4gWWVzLCBJIGFscmVhZHkgc2FpZCB0aGF0IGluIHRoZSBhYm92
ZSByZXBseS4NCj4gDQo+IElmIHlvdSByZWFkIG15IHY4IHJlcGx5LCBteSBzdWdnZXN0aW9uIHdh
cyB0aGF0IHlvdSBuZWVkIHRvIGZpeCBob3N0YXBkLA0KPiByYXRoZXIgdGhhbiBhZHZlcnRpc2Ug
bGllcyBpbiB0aGUga2VybmVsLiBZb3UgZG9uJ3Qgc3VwcG9ydCBwcm9iZV9jbGllbnQsIHNvDQo+
IHlvdSBzaG91bGRuJ3QgYWR2ZXJ0aXNlIGl0Lg0KPiANCj4gSSB0aGluayB5b3Ugc2hvdWxkIGRp
ZyBpbnRvIHRoZSByZWFzb25pbmcgZnJvbSB0aGlzIGNvbW1pdCB0byBmaWd1cmUgb3V0DQo+IHdo
YXQgdG8gZG86DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwcyUzQSUyRiUyRncxLmZpJQ0KPiAyRmNnaXQlMkZob3N0YXAlMkZjb21taXQl
MkYlM0ZpZCUzRGExMTI0MWZhMTE0OTIzYjQ3ODkyYWQzMjc5OTY2DQo+IDgzOWU5YzI3NDFkJmRh
dGE9MDUlN0MwMiU3Q3l1LWhhby5saW4lNDBueHAuY29tJTdDMjgxNmEzMTM1ZWRkNA0KPiA0NWQz
YTQ1MDhkYzdjMTM0ODVlJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdD
MCUNCj4gN0M2Mzg1MjE2Njk0NTUzNzQ3MTIlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lq
b2lNQzR3TGpBdw0KPiBNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJ
Nk1uMCUzRCU3QzAlN0MlN0MlN0MmDQo+IHNkYXRhPVFYRnJ6TFVNMkNnU2dXUjBDT28xdnJtaTVW
bGhwQ3pHQ21FYnhseXlTUzAlM0QmcmVzZXJ2ZWQ9MA0KPiANCj4gUGVyc29uYWxseSwgSSdtIG5v
dCBzdXJlIHdoYXQgaG9zdGFwZCBpcyBkb2luZyB3aXRoDQo+IE5MODAyMTFfQ01EX1BST0JFX0NM
SUVOVCAuLi4gYnV0IHlvdSdyZSB0aGUgb25lIHN1Ym1pdHRpbmcgdGhlIGNvZGUsDQo+IG5vdCBt
ZS4NCj4gDQo+ID4gTWF5YmUgSSBjYW4gcHV0IGZvbGxvd2luZyBjb21tZW50czoNCj4gPg0KPiA+
IEhvb2sgcHJvYmVfY2xpZW50IHRvIGF2b2lkIGhvc3RhcGQgdG8gc2V0ICJwb2xsX2NvbW1hbmRf
c3VwcG9ydGVkIiBhcw0KPiAwIGFuZCBzZXQgInVzZV9tb25pdG9yIiB0byAxLg0KPiANCj4gSWYg
d2UgcmVhbGx5IGNhbid0IGZpeCBob3N0YXBkLCBJJ2QgYXZvaWQgdXNpbmcgc3VjaCBsaXRlcmFs
IGRlc2NyaXB0aW9ucyBvZg0KPiBpbXBsZW1lbnRhdGlvbiBkZXRhaWxzIGxpa2UgdmFyaWFibGUg
bmFtZXMuIE1heWJlDQo+IGJldHRlcjoNCj4gDQo+ICJob3N0YXBkIGxvb2tzIGZvciBOTDgwMjEx
X0NNRF9QUk9CRV9DTElFTlQgc3VwcG9ydDsgb3RoZXJ3aXNlLCBpdA0KPiByZXF1aXJlcyBtb25p
dG9yLW1vZGUgc3VwcG9ydCAod2hpY2ggbXdpZmlleCBkb2Vzbid0IHN1cHBvcnQpLiBQcm92aWRl
DQo+IGZha2UgcHJvYmVfY2xpZW50IHN1cHBvcnQgdG8gd29yayBhcm91bmQgdGhpcy4iDQo+IA0K
PiBCdXQgYWdhaW4sIHBsZWFzZSBhY3R1YWxseSBleHBsb3JlIHRoZSByZWFzb24gaG9zdGFwZCBp
cyBkb2luZyB0aGlzIGZpcnN0LCBhbmQNCj4gc2VlIGlmIHlvdSBjYW4gZml4IGl0Lg0KPiANCj4g
QnJpYW4NCg0KSSB0aGluayBpdCBuZWVkcyB0aW1lIHRvIHN1cHBvcnQgcHJvYmUgY2xpZW50LiBD
YW4gd2UgcHV0IHlvdXIgc3VnZ2VzdGVkIGNvbW1lbnRzIHRvIHRoZSBjb2RlDQp1c2VkIHRvIGhv
b2sgcHJvYmVfY2xpZW50KCkgYW5kIGFkZA0KDQoiVE9ETzogc3VwcG9ydCBwcm9iZSBjbGllbnQi
IHRvIG13aWZpZXhfY2ZnODAyMTFfcHJvYmVfY2xpZW50KCkuDQoNCkRhdmlkDQo=

