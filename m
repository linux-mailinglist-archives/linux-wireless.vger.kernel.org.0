Return-Path: <linux-wireless+bounces-11802-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFEB95B4BC
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 14:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6B51F2230C
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 12:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775E21C9429;
	Thu, 22 Aug 2024 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WWnR8vm2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D251AAE36;
	Thu, 22 Aug 2024 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328683; cv=fail; b=MUGxCXBimeiJLr/WWh/QPZ+rBs0bpE3GvQhEaUmLK0QcSU9P92OWdrtefn4a4slt8Wl5skSXLvnAwPlxVD0Hrq3b/9KsxvH6gROCLXet2vwdbLfCQu98yw1LsAPKQBDQGWs+0kcflis2nvJqikmI/AIT7j8YDhUmnScs/zd7Fsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328683; c=relaxed/simple;
	bh=RFWENyNT+HwNEsRlvm/JGkavfB5urfnirfJJ3F2gI5k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dp/FoDQizGz13TWcHlu4pKYIngMX+RO9kyXoTbE968X76dxXd8b1LjZSuxh+yzoQmau2iHz5htaNY0EPwDm4lXVKj1kNEy3fP1AewQncL87+ILg/n1/t2JRQ9cQHWCJ6k/x7Z9WgrQkO3XlTozswZWhumDdyDZIg3mg/5Lxn9Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WWnR8vm2; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNwPWVco4OIMHRkS3RvXeTFNFjaBkHgXNCk74RsLMNXV/AgD7rfac62ZOrRUZ/OxH7wZ+kDvKN9JjPpZzgE98PpJGRAK+3exfp81mZ81bf8ZWl1xhi4l9gwChGFv+QrM9bZqY0Hv02CigAQc4+dTeGCaziuMQWRbNkh2ziIM/0y5KxFAoGMpYWoPTPoQyDIKESex2mlWF/q3wq+ipYvVgvYPRxu/jxViM/3baJI/8QbFsqm2bWfG5z/PEe4P+ImKpYQiqfKGXUOcp6HAWigZgP2lrVsuDgw+Sktt+odzgfFEODpuWHKJtOywPJRQGLR7gVJHhPasV9GL51+zRpxbqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFWENyNT+HwNEsRlvm/JGkavfB5urfnirfJJ3F2gI5k=;
 b=r5cw3LRykti+Hg9BRj7WxGji2H5sQ2TFA9lk1NPyQHOCLMNku78hF21xRM1ImdZ8UdzD/1AeJZBX1kanP5ZnHiWQVjrIbdcrueMFFq0QBLIAyBWpRPwo0XPRTNZnYhYE6TqbFcC1JCG0yNNqbg8wxG+yUsBYRyjAXoUTk9cKo4l3y4IM41+HT3xNcqCzAw8Fr5CHF+kDt9zRusweQdRVtbR/RoEXO7gKkb0c6eIeX/lzGdXi8cwF+oibq3yjGDuSyJZD3GX/Ug+YRgI6NF0popICG/rqjdknnjmrq8XOVDcdXJTZ//OqZaYKw+xBH3FaQNOuS9C3xak6ty67xpktzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFWENyNT+HwNEsRlvm/JGkavfB5urfnirfJJ3F2gI5k=;
 b=WWnR8vm2K8lK7kTQhGRMH3WL0DgB4FMMogyjp3KJs7tpJgHvcep+CkQWhi1m9bfKl+vb6DCXPZ3vE4qN1wtkzdnfAXZPRDzBIzgHqp2S/zr4jMN2Bm5mMyDNzkFgohl8GpDO5nYRF+TPq6Cbk85+KU4JRCkk8j3BUxyXhy9aKPiLS0xGZSYhAWCHouGxEP42fLET3XV/AedyhE2vJg9DXG2hhW5qfNHmExq+l8nAZJMMBElhIjyUDLfCBkEL1qPD687mN7QQQXb2eQCbxRItLLKxOqeGqpA32cczQk2UN6bozc99gBDtVByBMC23P/KmhpvvCerOPADYp57gwMpg2g==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9569.eurprd04.prod.outlook.com (2603:10a6:102:24c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 12:11:16 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 12:11:16 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Sascha Hauer <s.hauer@pengutronix.de>, Brian Norris
	<briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, Kalle
 Valo <kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: RE: RE: [EXT] [PATCH 10/31] wifi: mwifiex: fix indention
Thread-Topic: RE: RE: [EXT] [PATCH 10/31] wifi: mwifiex: fix indention
Thread-Index: AQHa8vjaVhal52qkKUSAi5YxIXRvnLIzBf+wgAAGUoCAACLh8IAAAfwAgAABBGA=
Date: Thu, 22 Aug 2024 12:11:15 +0000
Message-ID:
 <PA4PR04MB963813C76F476449A5003FFCD18F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
 <20240820-mwifiex-cleanup-v1-10-320d8de4a4b7@pengutronix.de>
 <PA4PR04MB96382C0635603A51371C0E23D18F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <20240822-gay-myrtle-tarantula-bae0e0-mkl@pengutronix.de>
 <PA4PR04MB9638C8D68F0F71C17E903DDAD18F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <20240822-brainy-liberal-toucan-bc498c-mkl@pengutronix.de>
In-Reply-To: <20240822-brainy-liberal-toucan-bc498c-mkl@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PAXPR04MB9569:EE_
x-ms-office365-filtering-correlation-id: 97198b69-49ef-436d-6319-08dcc2a385be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZitrVnNYZVp0YnlwQ2F3TXROeUFjQmFOSWk1N1BMTWViMjc0cEhRRkxlc3Ax?=
 =?utf-8?B?YVFQcnRQSVdHdXkva2Z4bDlTUFUvajZvZXhwVEN1T3R4QVJLdCtDNkVFVVhM?=
 =?utf-8?B?eDRoVk16OWNHQXE1ejlNQnp4c0dUdzM4ZkVrSXFJOW9IR3NRMFpST0hnRzBw?=
 =?utf-8?B?Sy92RVcxb0IvRWsxc2FwSHp4eG5PaFRmQ1ljbEtwc2VrM0ExYlpDWjJhZEM5?=
 =?utf-8?B?NzZUdTRmUm1EUjkvQzNha1RPamR5NEgrZHZWM2tTSUNmSVBFbXJvcVBqM3VY?=
 =?utf-8?B?d0p1UnJnS3huSjljb3FFVWt2ditrVXdXUVRZYmo1akg1MmZaK3RQU3ZvV2pB?=
 =?utf-8?B?cmFOaXZLS2c3WUdFL2lrYmNyV1FnbU03Vm1JYmNTVEFKdk5yTWVFYzJscHNC?=
 =?utf-8?B?aXZnbjJrNDF1S3o3YnAxUjdiNDF5MUJQYUpySjdELzNkSWZLVXFwcDZranp6?=
 =?utf-8?B?K0p3NEhLeXpwUFhDTXVjYStzU0dsL1hhbmxFc243VWlKRmJJcmU5dmhPZVpl?=
 =?utf-8?B?NnZxV1hlUkxhTWwzUFFLMFNCWkhnOWIzSWY3K2ZmOVpWVDgzZnV6eUFPRWlE?=
 =?utf-8?B?Qi9CbHRtNGhHMU9hMzNxZUFuSzIxWkU1VHNKeS9uN1JydDQzS1F3QmYwck4r?=
 =?utf-8?B?SllDd1JDRXZ6a1M3Uk1LOFl5UU5NU2RXaWhOMzkwUFc3RUhFS0FBTURUakZz?=
 =?utf-8?B?RWx4b3NFZ1FvWkl1Zm5pK2R4NFBhSmYwVStSUXFIajk1bnZRMG1zOTlUWUVV?=
 =?utf-8?B?N3d3bStKQm56N1hzWUlMYzBjemdtbVdnOVhDL3Q0UjZwc2h4a1FVdEF3eUgv?=
 =?utf-8?B?cjk0aEtYbGtVdE51NnY0ZmNMVzdOcWpsaDRVM1NmNjdIRTNyQmM4UnhoQThF?=
 =?utf-8?B?bm5COHhqamQvekVDazlSTHZWS1VMaUMxZ3ZLMk9Db1pqalJ2SEZic0JUc29x?=
 =?utf-8?B?dlpjekpaWGxZRklTSXFXSzZxbHdRZGtxbEVpcGVwcUtYTEtzVmxaRFlIU1J3?=
 =?utf-8?B?WXBPelYzUnRKQUt5Zko4WU5NVEEreUN4M25Qb29Fb05jeDczeUlxMUdkcjRx?=
 =?utf-8?B?MjkvNTRtQ3VMOUViMkxvVFNJek5ISjdCNmVsRjR0Y0JZeDJhNXZYakxEanh3?=
 =?utf-8?B?OHdOL29RSUZIZnpjYTE3cldCQUYyNTB2dXpFbWM2dDdYbS9EUnlQMy9wSnh5?=
 =?utf-8?B?aVB4bCsxcms3OVVvT2ZxQXEyTUNMYXNQSjlleUFSVHloSE54am9OUzF1cXdG?=
 =?utf-8?B?RE9qNzZmbmJtMngxakZxQjhEU0xVeFh3M0d4MHp1Rk1TaHRLOFk2N3djc0lN?=
 =?utf-8?B?VXBVRzBNRWk3SHg1OWF0MUlHVEtoNGJWb21odlFvRnFWOVNHbExPNG1WQmU1?=
 =?utf-8?B?Nm1aS291dWU0N2pRd05HbGgwMW5RNmQ5dmdOM0pCRStxR3FJbGpmZWQ4UVU4?=
 =?utf-8?B?dDN6Zmwxb3RXL1RRTmVQSEFRcjI0K1U1dDFhaHl5RkpWR0JMSFVRaWd3WFov?=
 =?utf-8?B?Q2xOUWJESUw4elNySVQ4TzJ3d3VoeGVmSm03Y3djRG9RcTRTTjFOelJnM3dF?=
 =?utf-8?B?L2R2RkI3QkxqeXZtV2ptUFRuM1d0TE1kTFE5Tk1sY3FHVTI2SHFhczM0K2Rh?=
 =?utf-8?B?M0RvaVdEOUJYNEJNMHNORlVvYXlOTFNBeGV3SktFNjJwZk1sMXRQd0FDaFR1?=
 =?utf-8?B?MFFIY0JkNnBYU3hETStHV0Zxd3hoRlBRVVUwR1MzWjBWLzAwcG02ZU1rUVE3?=
 =?utf-8?B?aDZxcDE4dWEwZGs2ZnVLVHp5aXRGdjh4Y0kvTVVDYnhrZE9UZjdkeVpnd1Av?=
 =?utf-8?Q?b/iFRIIVCht27CY0v/eb32igjXTKo1iZSL7X4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHpRZTVqb3I1bHNuM2wvRGZIWUsxNEIyWHNyK0lYZE9jT2poMWNIVXRMYjl6?=
 =?utf-8?B?RlVpV1FVVzhNa05uelA1bXZGWEhDRldnTEFTM3NEa1ZVbUZ2Z0VaQlg1ZGFv?=
 =?utf-8?B?TTkvakI4bWMzcy9YbFVlSFVXbjNmeEtqZWlMdFp4SEw2dWxTVUJYUWFiWkRz?=
 =?utf-8?B?N1BmQ3RsdFZQLzFFc1BRd3kyNzZvTXBTMHZ1U3JzeXFINEJqUkFnNnlseFZh?=
 =?utf-8?B?REhMYnVGN3AzZXIwd1BDNG9qaGlFQmUvcVU0dU80TWZPbVpleXd5NGtTWU00?=
 =?utf-8?B?VS9weERZQms1YzkwYmVyL1JxSnpYNElEV1JEQ25BNm05YXpRU0JOKytTYWFU?=
 =?utf-8?B?QWxoU2owcHRSNTcyQkV4TmNJaU9RTmJiS3BCQ28ySW1meEtsQnozaDV0eGJU?=
 =?utf-8?B?MTVBVGxKOUlEYmgxNVYyaVhjcTl5RzRoZzJjSTJlOUJkWktVTWkrUDNycmpx?=
 =?utf-8?B?MmVlNnBQeEZ2UmJsakM1bFZ6LzBveS81d3ZjdmlMTFFFaHJaMnhmeEFPcHlW?=
 =?utf-8?B?b2l5aFQ2V0E3R2ZmYTRpN0pHdlpHSEM3aUtZSkNvSXBMaUZNU20reXlPYWEx?=
 =?utf-8?B?eEFCcUhOWVR2eGJDNEpiQldSWkNzd3Fld2txYnNmQUg0MjI4NERCWHFyS2NI?=
 =?utf-8?B?ZWlGTGFHQldXVDZBY1JOSWtmTHp2L2RuOGN0NllHT2w2ZkdtK1k1eFpGTm9u?=
 =?utf-8?B?b241Mm5DMDBvUXVSOC9FSmNFbTVvOEp6MFg5eFpId3N1TnI4eVFMYW9ZVTFM?=
 =?utf-8?B?WGF1Z3JrUnlTOVNpUVFuQVZUOHdDRGhxVGRTWGY4Nk9nQ2gwQThabnZsWHBQ?=
 =?utf-8?B?eVJkdzJaSWFrNjc3MUV0ZkpkWFpiT3VhcW9YVDNHZCtnTmNGNUJIVjBOT1Fa?=
 =?utf-8?B?UXIwZ2RzSi9PVGFNU292NmNheTExdU5wMUM2bVY4UXBSMVAxL1l0MzhYT1Mv?=
 =?utf-8?B?WERLK2Z6K3p3RjZlN0N2SDVOYzg2dVdpMTI1anNUZlNTcHBsVW12Z003bmlT?=
 =?utf-8?B?VzB3Wk94NjZvY2gyNURteDNQSzNCK2IvUElPTS83WEVKSHJSdlpDRi9QTHR5?=
 =?utf-8?B?UUR5TXo1TElJMzUzOEZ1S3JJRlZGZjYwWE5tV0x5Vnh5b3JJYmJhNGF6dmNP?=
 =?utf-8?B?djA1NzlzWDlzTTB1dm5uUHRIQ3RsNGlyUmphR21iZFh6N3dMMFNJbkM1U2F5?=
 =?utf-8?B?QVU2VjlJVm1zaENxckhKaE5qV29rc1pxS0pRN3VGNkRNLzZQQXp2NXlIWnAv?=
 =?utf-8?B?YklSL1BGOGpSaFhlRlhUYkRzS2V3OWRBWDg0NXVVRlpMZWVrOXYxdlVYODFS?=
 =?utf-8?B?cUh5ZFdoMVdDT1dYaEhLYldOc1J3M0IrWlJhTVgvRkYybHdWZHZlZkRTTzVP?=
 =?utf-8?B?MGZNWEtmdVNGZTRBeEdnSTdZZ0RvTUNlM2owbWptMFY3R3ZHZ1BGQm43aXdX?=
 =?utf-8?B?VHloZHEvcTVtTWhnWHAxSERCNmkzV0JTMHFwN3NaZElneXQzTkRsUEROMTNh?=
 =?utf-8?B?VVVtdzNoNytUMkE2TzY5V2hEWGlHblR3QXJKM0xXblhIc3M2eTBoYUZBM1RT?=
 =?utf-8?B?d2VSRUNRUjVrSnIwYVVOZ3BsT1pkdUFyYzlyRVNmb2VqN1dERXY1SkpjemZs?=
 =?utf-8?B?TlFhOGs4WFpLRGxENk91eHlaNXNPekJIeDdvTkJPejlraGV1Q3g5TXdLTXh0?=
 =?utf-8?B?MEt1bHpSWnNDOHV1WnVMeGsrc3VNVm8rUndZZ09uRm5jcUFTcUU1UVI0YUhv?=
 =?utf-8?B?UHFMV2FMUGVvcUpxYmpmOEh6Q1NnNFF6Nll1bGNFS2tTMy9RaS81Mkx1Q3hU?=
 =?utf-8?B?Vlg3aER3dXR6amdKZG9aQkw5MC9rQ2dNTFNjdEZOZXd3aDhCK05FYThwOFZw?=
 =?utf-8?B?eVQxVkJvRkhoemVvZERmVXVvQlluRGZ2RjVsZ2JPam50YWl2bnlhVTZEUGFK?=
 =?utf-8?B?K0dLN2laUzZiTUlCbXhPd0x4clpwMHFnSDVReFk1V2x0OE9BeVJzL2NIaWt4?=
 =?utf-8?B?MzdYWGc3ZllwNmFURldma0RkVDVTcnFobUxjWE1ubGxxOVcydEdydmNLS2Ny?=
 =?utf-8?B?bkhRdFF4T09IemphUEp4RDhhZ2ZBd25aM1B0d2oxT1BseHVkeHlwQkR5RHN6?=
 =?utf-8?Q?qiQUgOorwWyXOHGgJR8FY/Qex?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 97198b69-49ef-436d-6319-08dcc2a385be
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 12:11:15.8729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LAezyGf5E52liLMhBFNKjZqN2t5LGRerVtEpgRTaLEL26BY5rXqliCxBftV7bextuq30Oit+7i9ikXND5MDcDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9569

PiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiBU
aHVyc2RheSwgQXVndXN0IDIyLCAyMDI0IDg6MDUgUE0NCj4gVG86IERhdmlkIExpbiA8eXUtaGFv
LmxpbkBueHAuY29tPg0KPiBDYzogU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRl
PjsgQnJpYW4gTm9ycmlzDQo+IDxicmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc+OyBGcmFuY2VzY28g
RG9sY2luaSA8ZnJhbmNlc2NvQGRvbGNpbmkuaXQ+Ow0KPiBLYWxsZSBWYWxvIDxrdmFsb0BrZXJu
ZWwub3JnPjsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGUNCj4gU3ViamVjdDogUmU6IFJF
OiBSRTogW0VYVF0gW1BBVENIIDEwLzMxXSB3aWZpOiBtd2lmaWV4OiBmaXggaW5kZW50aW9uDQo+
IA0KPiBPbiAyMi4wOC4yMDI0IDExOjU5OjU1LCBEYXZpZCBMaW4gd3JvdGU6DQo+ID4gPiBGcm9t
OiBNYXJjIEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiA+ID4gU2VudDogVGh1
cnNkYXksIEF1Z3VzdCAyMiwgMjAyNCA1OjUzIFBNDQo+ID4gPiBUbzogRGF2aWQgTGluIDx5dS1o
YW8ubGluQG54cC5jb20+DQo+ID4gPiBDYzogU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJv
bml4LmRlPjsgQnJpYW4gTm9ycmlzDQo+ID4gPiA8YnJpYW5ub3JyaXNAY2hyb21pdW0ub3JnPjsg
RnJhbmNlc2NvIERvbGNpbmkNCj4gPiA+IDxmcmFuY2VzY29AZG9sY2luaS5pdD47IEthbGxlIFZh
bG8gPGt2YWxvQGtlcm5lbC5vcmc+Ow0KPiA+ID4gbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4ga2VybmVsQHBlbmd1dHJv
bml4LmRlDQo+ID4gPiBTdWJqZWN0OiBSZTogUkU6IFtFWFRdIFtQQVRDSCAxMC8zMV0gd2lmaTog
bXdpZmlleDogZml4IGluZGVudGlvbg0KPiA+ID4NCj4gPiA+IE9uIDIyLjA4LjIwMjQgMDk6MzY6
MjksIERhdmlkIExpbiB3cm90ZToNCj4gPiA+ID4gSSB3b25kZXIgd2Ugc3RpbGwgbmVlZCBwYXRj
aCBmb3IgaW5kZW50IGlzc3VlIGhlcmU/IElmIHNvIEkgYW0NCj4gPiA+ID4gc3VyZSB3ZSB3aWxs
IG5lZWQgYSBidW5jaCBvZiBzaW1pbGFyIHBhdGNoZXMgd2hpY2ggSSBkb24ndCB0aGluaw0KPiA+
ID4gPiByZWFsbHkgaGVscCBpbXByb3ZlIG13aWZpZXggcXVhbGl0eQ0KPiA+ID4NCj4gPiA+IG13
aWZpZXggaXMgdGhlIGJlc3QgbWFpbmxpbmUgZHJpdmVyIHdlIGhhdmUgZm9yIHRoZXNlIGRldmlj
ZXMuDQo+ID4gPg0KPiA+DQo+ID4gWWVzLCB3ZSB3aWxsIGNvbnRpbnVlIHRvIGZpeCBidWdzIG9m
IG13aWZpZXgganVzdCBsaWtlIHdlIGFkZGVkIHRoZQ0KPiA+IFdQQTMgc3VwcG9ydCBmb3IgaXQu
DQo+IA0KPiBXaHkgZG8geW91IHRoaW5rIDIgZHJpdmVycyBhcmUgZWFzaWVyIHRvIGhhbmRsZS9z
dXBwb3J0L21haW50YWluLy4uLg0KPiB0aGFuIDEgZHJpdmVyLCBlc3BlY2lhbGx5IGdpdmVuIHRo
ZSBsb3cgYXZhaWxhYmxlIHJldmlldyBiYW5kd2lkdGg/DQo+IA0KDQpOeHB3aWZpIGlzIHVzZWQg
dG8gc3VwcG9ydCBuZXcgTlhQIFdpRmkgY2hpcHMuIFlvdSBjYW4gY2hlY2sgdGhlIGNvbW1pdCBt
ZXNzYWdlIG9mIE54cHdpZmkgdG8NCmtub3cgdGhlIHJlYXNvbiB3aHkgd2UgbmVlZCBhIG5ldyBk
cml2ZXIgdG8gc3VwcG9ydCBuZXcgTlhQIFdpRmkgY2hpcHMuDQoNClRoYW5rcywNCkRhdmlkDQoN
Cj4gcmVnYXJkcywNCj4gTWFyYw0KPiANCj4gLS0NCj4gUGVuZ3V0cm9uaXggZS5LLiAgICAgICAg
ICAgICAgICAgfCBNYXJjIEtsZWluZS1CdWRkZSAgICAgICAgICB8DQo+IEVtYmVkZGVkIExpbnV4
ICAgICAgICAgICAgICAgICAgIHwgaHR0cHM6Ly93d3cucGVuZ3V0cm9uaXguZGUgfA0KPiBWZXJ0
cmV0dW5nIE7DvHJuYmVyZyAgICAgICAgICAgICAgfCBQaG9uZTogKzQ5LTUxMjEtMjA2OTE3LTEy
OSB8DQo+IEFtdHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2IHwgRmF4OiAgICs0OS01MTIx
LTIwNjkxNy05ICAgfA0K

