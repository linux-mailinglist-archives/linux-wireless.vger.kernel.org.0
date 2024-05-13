Return-Path: <linux-wireless+bounces-7572-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF938C39D7
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 03:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A5C2811FE
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 01:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6905BBE4F;
	Mon, 13 May 2024 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BREvC+y+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2059.outbound.protection.outlook.com [40.107.13.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C768EBA2F;
	Mon, 13 May 2024 01:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715563639; cv=fail; b=EqPeiL7F6kpHzzmtfmpTp1XLv0kDet06pQZM+cb1xHBVkS+Qk63fXCWldc5YujNlY/5WCLqKtk+bNpkbOD2v1bESNC1l+ChkHGBkaunPWDJOqEio4pNWIbN3qmnEdCU3sfujeRca/QrALRVDbYg7Xi9f72yxB12ph3SjOpRID3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715563639; c=relaxed/simple;
	bh=uxus1Oy0qLjUZq1DFINxQ6W9a3m3FffmQFaZrLt3RWQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eRd6lTSk3YWRBAaNi8ICBOPR2UcRoptoH/aDcAMkrxWbjsUJ6ZbF0dUpuzAYt6aarc49wfM8DxYI/0yuZ8BHz2WRohka0xg+AGauIxEC3M6xiwuuvA+t2uFXjSTa/WT9Qtk6atAR0vPEGASVZsDnkv/LA9QoL3SImElgRFUQcQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BREvC+y+; arc=fail smtp.client-ip=40.107.13.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPBIoh3rspvXzm68ffb/r3BijqjZ9k5tsCRBj5nnbho/FW5oA1m3OyHnikIeFOQFTqpG+hsmFee9V5VKvlURPGOzZ2a665wdfPe1ttkTrR3WsZfga+mw9iKQoTEQfqzG/FLoEvMLa4DEqfuL77ypiF4KEZP05ZxbrfL3eOZaAviF9n14KxsQm/hiOiBSMkjXF4yUWwUISk/FfHB9KjwtCJcUhkvAUz0mDYmCyCffWHi9wLez+e5zRo/Ai2FjP99fm3qnogD2LETI5hXaNZDXKJhehP4fhD9doebysb1NrlAq6Tprx+oSuXu6PGH21lhweb23Z5K6shoQa5SPv4ey3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxus1Oy0qLjUZq1DFINxQ6W9a3m3FffmQFaZrLt3RWQ=;
 b=lBnWrFugLf6B4+wXkb/dcpTR7jrVwiOcJePhiEd56WsgRgI/8a/UvNyuQ2wAGVXZhfN0n/x4xsZHmeyFVCM+iaFMA7HeiFCcuQMNOv+Gpb2kBAiPEuljWgyxbR2F+KG7fcDTr3G+ZVVmaAqVPDi8dp4xKQEX+83WguHrTESdf3ChpTlrFAfkchC8Qja/wUmSc6fPPCEkbK5TC5+WbVCQbthECCrutjJg/+2M95w5DUVkX4UmcQZf4OM8bo+8i5XMOLlEox7maq8crfC2E8gJgK0PkCsXATdJa7wcd844ShW9GeFTCNNyI1Uod10Oq9p9rhLNcz+nSUCBzWqjV5CPXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxus1Oy0qLjUZq1DFINxQ6W9a3m3FffmQFaZrLt3RWQ=;
 b=BREvC+y+NYRyPp6pQqHa/zXvqiUPQw+wOmph1gt06vKQ6aov4VsGy4LfPRaFAmd0xL2TXNa+2WpA0yYDYcx6CFKHadrWV6eaIXsG71R3jk+dPHXaHzFu54M0V4O6fR9x4iQRMGyJVE48RZsUaabGwCQAuDjLelee20BCGm/7VNc=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PA2PR04MB10129.eurprd04.prod.outlook.com (2603:10a6:102:3ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 01:27:13 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 01:27:13 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: David Lin <yu-hao.lin@nxp.com>, Brian Norris <briannorris@chromium.org>
CC: Marcel Holtmann <marcel@holtmann.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Kalle
 Valo <kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, Pete
 Hsieh <tsung-hsien.hsieh@nxp.com>, rafael.beims <rafael.beims@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Index:
 AQHakXD8ZSzvjLENHE+cjdiIi3WD9LFu+PhwgAEpDwCAA9ThQIABL2MAgAH0wQCAATIZwIABfIwAgAnpxRCAENF80A==
Date: Mon, 13 May 2024 01:27:13 +0000
Message-ID:
 <PA4PR04MB96381B9675BCA5861AEDEF25D1E22@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <0ED16BAB-6E7D-487C-BBCA-E63FEF37C60D@holtmann.org>
 <PA4PR04MB963815B9FDA6119683A28CADD10E2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <6CB59E09-F34E-4986-AA88-8EC4EE5E71DF@holtmann.org>
 <PA4PR04MB9638B62BC25F773C6922A4BCD10D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZiLlPOvKlfCySZwF@google.com>
 <PA4PR04MB96383D46C1187C237DFC7988D1122@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB96389E67F826216C44FE19FFD1112@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <C8F76484-1359-437B-85BF-C646A21F7BCE@holtmann.org>
 <PA4PR04MB9638670FD6768AD8A69F5125D1172@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXNhkHi47=d-TMkjy3oebsK_NvWuC9CQtEEQYN-nHHbx-g@mail.gmail.com>
 <PA4PR04MB9638F35B2FF70A1E514C25D0D1182@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To:
 <PA4PR04MB9638F35B2FF70A1E514C25D0D1182@PA4PR04MB9638.eurprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PA2PR04MB10129:EE_
x-ms-office365-filtering-correlation-id: bac6fc7c-8e71-478a-b3e0-08dc72ebd157
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?MDV5Ryt2aW9STUhJS0xrdlVUNTJqUS9HYkZRMUtZL1dWL0laWHRWNFN5aTg5?=
 =?utf-8?B?dWpoeDlyMTVkMHFZMjQ3Yld0aUNjVnhnSWNmcU4vKzJvN0J2ZVlGYXQrT1F0?=
 =?utf-8?B?RDkwekFablN4bW9xTEM5WFNXSUpxWWg0VlFERkV4NE0wbnM2b3h3Z1Z2eVF4?=
 =?utf-8?B?UmQ1ek1KMEFyVDQxMEpIZGtNM0pNNjU5QWUxdDQ3Uk9uMHAycld1Q1VuSE1U?=
 =?utf-8?B?RnRQUDlZM2pRbXJ6MDlnOVNaTjBuL2hwWnNhdVpqbm1pVU5HcE4xSzFSOVQz?=
 =?utf-8?B?MHd2Q2NBNGNPT3VTOGV0Sm8ycmMzYUF6WHE3am8wY0FPZFcvamx1Wk1kMkVH?=
 =?utf-8?B?czBZRm9OWnN1WE5TZEw3VkZvc040OVlBakdqeXgwWXN3UVRNM0M0THVMRllr?=
 =?utf-8?B?K20yT3pFb0dIdElzQVczWkUwRGt4YmJnUEo3SWMzRmpXZnU5OElMa3dRdUIr?=
 =?utf-8?B?V0tQeGlxTFpnSGl5MVB2K0t4RjZUTlFoeG9oRjRVMDMwUjhaeU9NZGxTVEJR?=
 =?utf-8?B?VXZBaEZET3dJQXlhUEZyVUwxS2tqc0N3SlgzYnNGM3dpNGgzSkVRdzhIa1Uv?=
 =?utf-8?B?UVVvZUVKLzZKTlMxTHlUOWVYTVBoUkhPMVlyTmx2T0pPWk05dU1OTWhKRDd4?=
 =?utf-8?B?Qy9GcVBnQ1h0RGthOXIrK2NpUU92Qlh3Qmd0eXZZOUhQSUtOeUxVQW9iSG1R?=
 =?utf-8?B?TXByWUJERUUydmFiK21PdVo4MjErN201THBUZG1ua1Z6dXhWdENrUHVZMXNa?=
 =?utf-8?B?U1A0bkxrK0I1WDBSUU00bFRiRE5BcEJ2VC9lbXVJc0JlMHp2TXg0SjlwOXNw?=
 =?utf-8?B?NUJGT0tvUXlCMzB4cGNESkFuUFYwelVtRm9uMTUyb1dkVWFiNlcxMi94S21w?=
 =?utf-8?B?MWJtRnlOUDZXZXo4VDlTeHN3V29NRkZBZHZ3NWlHNXhETzFCanBuRmlCaHEv?=
 =?utf-8?B?dU94b0M2czNyQW1oU2pJcnh5WW1rL3VRWjlyRm11WVpNQ0VNNDVnNWhseG13?=
 =?utf-8?B?TEppNVJRRGc5U3Fma2R6YWVKdkVXQVRqOXhxU2d4SVF0Q0lhUnFOQlFMbzZr?=
 =?utf-8?B?RVdwekhMUktHOEdEbkNyZ2lZTmFEdFk4M0hEbUllL0l3Mkdmb1c2Ui9VY1g1?=
 =?utf-8?B?dE9pTm55cVBFK2wvWStRVElRRC9tUDh5NSszb1VIci9KUW0xbmlaUDhKL3hQ?=
 =?utf-8?B?NFJvNWJ4Q2Z6RWk2VExoZDlGNFh5WVlRYmFzM3Bwd0syV05hZ3lqZ1hqSmp4?=
 =?utf-8?B?ZStDMy95Z3N1S2wrVmpUdlg3ZE5aV3djbS81SnMwMllsM1pXQlcxN3VzYkVW?=
 =?utf-8?B?N3h5VDdxVDNoMDNxcGNCR0pWN0RNZWYxMVRRdUpGaDMwTU9LRXc5UGpqVVJx?=
 =?utf-8?B?NjdEMVNVV2NWNnNLM2tDaElIdWNsOW8vL1B5Z3JKYk03SDV2akpvWHZQZGR3?=
 =?utf-8?B?Ky9NR2IzVkhUSjVJTEdlOTVydVBjMWVMR1pndFFPWVpKcWc2UEhBcGZDUmpm?=
 =?utf-8?B?aW5lSW9WYVdoSVViOVlmN1diM3pkNmZ0OGhXTlhxaHM4SmhmanlzWFlUVUFr?=
 =?utf-8?B?ZTNwRG13ZWVKaVIrdFJNTzlyU0ZEYXZDREhSeisrb3BDRXdVMi9GMkxPeThF?=
 =?utf-8?B?UkZLeXBCT0k4bnhsQmJNZktMakZmd2VYSGdnYW1XcXJRalhpQ2w2ZmFLcnBp?=
 =?utf-8?B?alg4bk42NytnMi8vT3hSMXhrdlY2bkpaWENxdjduclRWQ3BnZHcyMGRNSmxs?=
 =?utf-8?B?dzJVcTdWY0pza1k1MHdTNUM3N2l3eUd2QkhxRDNpZGs1NGtiVFhLTzJ4SG9W?=
 =?utf-8?B?L29vUVIvaTJ2ampyRzRKdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SG5rdXEyWVBRM04rdXFhVlVVQ1QyeWhhL3hTV0JZWjYwbkNGVGFYcVFPRDVm?=
 =?utf-8?B?SzBWUWJMUnN1MHJjbEltVTlPTE5xSkkwei9NdXNoeERtbWh5RjFvRGlwc05j?=
 =?utf-8?B?Z2pyZEpCamh0UGhSSURxNzhVL1JVcVBmNFlxNVFJNWdOWEVMemZhNFlNVHFI?=
 =?utf-8?B?TiswTEZ6TjRyTFVvYUc5c3NTeTEwSWN1MG5BUzk2VGlSY0svY3Eya2ZOUzE0?=
 =?utf-8?B?cnVFVEt0ejJRZzkyS2xKZWg4S1ZwV0RXVlY1K2hzeVB3VUtTcjdxQXNnd0s5?=
 =?utf-8?B?a1hwdFZWcEs0dmZKV2RldGVWR0x4UmpQQnFyK01NYk15QWpKbHFSQlc1U1R1?=
 =?utf-8?B?cUN5NjZqN0IyazRMbkdEaW9nUnJBdVRZMW13M1lwakZyakpDWURlaDJPbjBQ?=
 =?utf-8?B?UGE5Zm1oZ1AyMy9uRHJpZFBGYWg0Qmh2aEo3ZXFvUHJuWEEzMHhRTzMrVEkx?=
 =?utf-8?B?ODNkaFRZTHI0RmR5cjFneGtWbldkWTl4T053Uit4L2ZhWFZYa0syNThscDA0?=
 =?utf-8?B?U284SmZ0d0UyNElpeDNsMDNCRGIwb1JqYWszaW5SV01vdGdSL01UZGxWazgw?=
 =?utf-8?B?ODV0d0wxV2dsaDFpbDkwK3F2eFNXM1B4eEI2MUQrVHJqM0h4ZnJia3puZkdV?=
 =?utf-8?B?aXE2d2dhc2lrUmVWek02Tmt4ZEpUM0JqenhHUERRTVdBbFJEUlRkMStMcHVC?=
 =?utf-8?B?eWpLbXlZT3hQeGY1U3prVkNacEdqdmt5OFdibWFaU0ZkUTlhVTZHYXRHQlFW?=
 =?utf-8?B?L3NDYlZEdThwL0xjVEJwOVZGWWlPa2FBTGM4bEl4ekV2am4vNjRlQlJIZzV4?=
 =?utf-8?B?ckRZamtPYk5zNCt3N2tJMnJTTnRCUTNPNWEyTmFDcVBtMjgrTlhjUms5Y3M0?=
 =?utf-8?B?ZktidDFVZkh1NCtURUkwbFBBd1UyWSt6THVEdnJOTmJiempGWXVtMlA1Kys3?=
 =?utf-8?B?UUZya2VTcCtzY1RmM29BSjAzQm43Rkh6SG92YXJIMFdtMXZicXNmWnB1QVZG?=
 =?utf-8?B?VUcwTFVtSzRwUlR0MnRBMnVpNnNteWExR2d0NEdlTWtNdWdMSXYrYTZUTEJX?=
 =?utf-8?B?VEdwTFNyNVVwL1RXN3NDWHNMSE9IWFRBOFdVeVdtWlV2OWkza0traGFSZjBs?=
 =?utf-8?B?YjdYNEhOVGNXNTY4dS9XVTJSOWUxS3dtaXRtM2VwUW4xREd4UUx4MllkREdW?=
 =?utf-8?B?T2xReDgraUp4MHBTME12dERzeEpHYU9SUnoyb2ZZdGVhZ0w2WkVYeDYyM1hp?=
 =?utf-8?B?NFRWQmt1UERsVFZZV0lYeFpaY0pGeXMvSUpkOTZaajE5ZE1vTGhMMVFFR1Nw?=
 =?utf-8?B?VWN6MXFlYkNvQlNCVS9ZTndleG5wWjNjbkg2bWZuQ1EwZEFGMDRBTkliNW1o?=
 =?utf-8?B?RUxzd1gyeTM3UUU3VlZIcVhiN2dxb0x4Yk9TY21Rd3JKaDFYVEEzNzN4SVU1?=
 =?utf-8?B?Vk5GZkRmN0E2R2dkdDlOSXRuQ1hpY014RGVPVU5yWTk2TTA0MzEwMng1T3Ru?=
 =?utf-8?B?RWQ2UWhEd00xaEhmTWN5S3lHbmg5Y3ZDNk90MTdldEl1Q05QSk5SeDNpQi9s?=
 =?utf-8?B?eCtIakJ4Qy9udW9jc1o0djBvR2Y2VEl3S2U1cU85b2xwRHVBQUhOR3haMUl1?=
 =?utf-8?B?RVhDYlM2YWNGL1Z6Zm9Vb0YxbVdhcnNhWHVJZ3hYb2pZQlplRFY1eEhDRjNl?=
 =?utf-8?B?VGxHQkJYOG5jVE9pTXI3VW9zdkMwU3R5SmdEaGQ0NFRtYnRqRFpvMk9DZlhG?=
 =?utf-8?B?bFMrN1JxREF1RWJuWFI5VUtlRG0rVFBtUnFyTm1jT3ZZY29xYVhZRlFBaW05?=
 =?utf-8?B?eEJPeExQRlgyWG1mQ21hYjJnM05keDNPYm9sYWVaSHFYeG1XZk1OTjIzcUVJ?=
 =?utf-8?B?LzNhQW1KUGY5TW0xSmNGaEN2NVduVDRCQnVhLy84b3BOSDUxdERPZkRkODdY?=
 =?utf-8?B?Y0RzYndNalJ0V2xhbHRsc2IrOHZnMXdRSXphZjBPMGtkcFEwRHFCT3RKVktt?=
 =?utf-8?B?NmJ4OW9lM0N6ZTFGVm1qVEQxSVVtc0FKdk5vbno4QnBFRjhFS1VWRmp6c2pD?=
 =?utf-8?B?QWdERTVWWDArVHdNNWN4WDlBNkJKWldyeFl0Wk1lak15OW16NCtqL0YyMVVL?=
 =?utf-8?Q?KTm0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bac6fc7c-8e71-478a-b3e0-08dc72ebd157
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 01:27:13.4735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Idt3Ax27PAK2GWkVbGV2Eo1T8ZsfOLQmb+Qtdx66uH7G6SoZVQJkEEh5fjtiKxZfrFjwu1EBtqxb3fSR+QICdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10129

SGkgQnJpYW4sDQoNCj4gRnJvbTogRGF2aWQgTGluIDx5dS1oYW8ubGluQG54cC5jb20+DQo+IFNl
bnQ6IFRodXJzZGF5LCBNYXkgMiwgMjAyNCA0OjM1IFBNDQo+IFRvOiBCcmlhbiBOb3JyaXMgPGJy
aWFubm9ycmlzQGNocm9taXVtLm9yZz4NCj4gQ2M6IE1hcmNlbCBIb2x0bWFubiA8bWFyY2VsQGhv
bHRtYW5uLm9yZz47DQo+IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgTEtNTCA8bGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IEthbGxlDQo+IFZhbG8gPGt2YWxvQGtlcm5lbC5v
cmc+OyBmcmFuY2VzY29AZG9sY2luaS5pdDsgUGV0ZSBIc2llaA0KPiA8dHN1bmctaHNpZW4uaHNp
ZWhAbnhwLmNvbT47IHJhZmFlbC5iZWltcyA8cmFmYWVsLmJlaW1zQHRvcmFkZXguY29tPjsNCj4g
RnJhbmNlc2NvIERvbGNpbmkgPGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tPg0KPiBTdWJq
ZWN0OiBSRTogW0VYVF0gW1BBVENIIHYxMCAwLzJdIHdpZmk6IG13aWZpZXg6IGFkZCBjb2RlIHRv
IHN1cHBvcnQgaG9zdA0KPiBtbG1lDQo+IA0KPiA+IEZyb206IEJyaWFuIE5vcnJpcyA8YnJpYW5u
b3JyaXNAY2hyb21pdW0ub3JnPg0KPiA+IFNlbnQ6IEZyaWRheSwgQXByaWwgMjYsIDIwMjQgOTow
OSBBTQ0KPiA+IFRvOiBEYXZpZCBMaW4gPHl1LWhhby5saW5AbnhwLmNvbT4NCj4gPiBDYzogTWFy
Y2VsIEhvbHRtYW5uIDxtYXJjZWxAaG9sdG1hbm4ub3JnPjsNCj4gPiBsaW51eC13aXJlbGVzc0B2
Z2VyLmtlcm5lbC5vcmc7IExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiA+
IEthbGxlIFZhbG8gPGt2YWxvQGtlcm5lbC5vcmc+OyBmcmFuY2VzY29AZG9sY2luaS5pdDsgUGV0
ZSBIc2llaA0KPiA+IDx0c3VuZy1oc2llbi5oc2llaEBueHAuY29tPjsgcmFmYWVsLmJlaW1zIDxy
YWZhZWwuYmVpbXNAdG9yYWRleC5jb20+Ow0KPiA+IEZyYW5jZXNjbyBEb2xjaW5pIDxmcmFuY2Vz
Y28uZG9sY2luaUB0b3JhZGV4LmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW0VYVF0gW1BBVENIIHYx
MCAwLzJdIHdpZmk6IG13aWZpZXg6IGFkZCBjb2RlIHRvIHN1cHBvcnQNCj4gPiBob3N0IG1sbWUN
Cj4gPg0KPiA+IEhpIERhdmlkLA0KPiA+DQo+ID4gT24gV2VkLCBBcHIgMjQsIDIwMjQgYXQgNzo0
MOKAr1BNIERhdmlkIExpbiA8eXUtaGFvLmxpbkBueHAuY29tPiB3cm90ZToNCj4gPiA+ID4gRnJv
bTogTWFyY2VsIEhvbHRtYW5uIDxtYXJjZWxAaG9sdG1hbm4ub3JnPg0KPiA+ID4gPg0KPiA+ID4g
PiBIaSBEYXZpZCwNCj4gPiA+ID4NCj4gPiBQZXJoYXBzIEknbSBtaXNzaW5nIHNvbWV0aGluZyAo
dmVyeSBsaWtlbHkpLCBidXQgSSBkb24ndCBpbW1lZGlhdGVseQ0KPiA+IHNlZSBtdWNoIGRpZmZl
cmVuY2UgKHdpdGggcmVzcGVjdCB0byB5b3VyIEZXIEFQSSwgYW5kIGZ1dHVyZQ0KPiA+IGV4dGVu
c2liaWxpdHkpIGJldHdlZW4gZXh0ZXJuYWxfYXV0aCgpIGFuZCB5b3VyIGN1cnJlbnQgc29sdXRp
b24gKG9mDQo+ID4gaW50ZXJjZXB0aW5nIGF1dGgoKS9hc3NvYygpIGFuZCBjb25zdHJ1Y3Rpbmcg
eW91ciBvd24gQVVUSCBmcmFtZXMpLiBJdA0KPiA+IG1vc3RseSBqdXN0IG1lYW5zIHRoZSBBVVRI
IG1nbXQgZnJhbWVzIHdpbGwgYmUgY29taW5nIGluIHZpYQ0KPiA+IE5MODAyMTFfQ01EX0ZSQU1F
IGluc3RlYWQgb2YgYmVpbmcgbWFudWFsbHkgY29uc3RydWN0ZWQgd2l0aGluIHlvdXINCj4gPiAu
YXV0aCgpIGhvb2suIFRoZSBleHRlcm5hbF9hdXRoKCkgYXBwcm9hY2ggYWN0dWFsbHkgbG9va3Mg
Km1vcmUqDQo+ID4gbmF0dXJhbCB0aGFuIHlvdXIgY3VycmVudCBzb2x1dGlvbi4NCj4gPg0KPiA+
IEhvdyBleGFjdGx5IGRvZXMgeW91ciBzb2x1dGlvbiBtYWtlICJmdXR1cmUgY2hhbmdlcyBbZWFz
aWVyXSB0bw0KPiA+IHN1cHBvcnQgW3RoYW4gd2l0aCBleHRlcm5hbF9hdXRoXSI/IERvIHlvdSBu
b3QgdHJ1c3QgdGhhdA0KPiA+IHdwYV9zdXBwbGljYW50IHdpbGwgcHJvdmlkZSBleGFjdGx5IHRo
ZSByaWdodCBOTDgwMjExX0NNRF9GUkFNRQ0KPiA+IGNvbnRlbnQgeW91J3JlIGxvb2tpbmcgZm9y
LCBhbmQgeW91IG5lZWQgdG8gdHdlYWsgaXQgdG8gbWFrZSB5b3VyDQo+ID4gZmlybXdhcmUgaGFw
cHk/IFlvdSdyZSB0YWxraW5nIGluIGV4dHJlbWUgZ2VuZXJhbGl0eSwgd2hpY2ggZG9lc24ndA0K
PiA+IG1ha2UgaXQgZWFzeSBmb3IgbWUgKGFuZCBwcmVzdW1hYmx5DQo+ID4gTWFyY2VsKSB0byB1
bmRlcnN0YW5kIHdoeSB5b3UncmUgY2hvb3Npbmcgb25lIHNvbHV0aW9uIGFuZCByZWplY3RpbmcN
Cj4gPiBhbm90aGVyIHByZWV4aXN0aW5nIG9uZS4NCj4gDQo+IDEuIFRoZSBwcm9jZXNzIG9mIGV4
dGVybmFsX2F1dGggc2hvdWxkIGJlIGFzIGZvbGxvd3M6DQo+ICAgYS4gY2ZnODAyMTFfb3BzLmNv
bm5lY3QoKSBpcyBjYWxsZWQgdG8gZXN0YWJsaXNoIGNvbm5lY3Rpb24gd2l0aCByZW1vdGUNCj4g
QVAuDQo+ICAgYi4gSWYgYXV0aGVudGljYXRpb24gaXMgbm90IFdMQU5fQVVUSF9TQUUsIEZXIHdp
bGwgcHJvY2Vzcw0KPiBhdXRoZW50aWNhdGlvbi9hc3NvY2lhdGlvbg0KPiAgIGFuZCByZXBseSBj
b25uZWN0aW9uIHJlc3VsdCB0byBjZmc4MDIxMS4NCj4gICBjLiBJZiBhdXRoZW50aWNhdGlvbiBp
cyBXTEFOX0FVVEhfU0FFLCBGVyBzaG91bGQgbm90aWZ5IGRyaXZlciB0byBjYWxsDQo+ICAgY2Zn
ODAyMTFfZXh0ZXJuYWxfYXV0aF9yZXF1ZXN0KCkgdG8gb2ZmbG9hZCBhdXRoZW50aWNhdGlvbiB0
bw0KPiB3cGFfc3VwcGxpY2FudC4NCj4gICBkLiBGVyB3aWxsIHdhaXQgZm9yIGF1dGhlbnRpY2F0
aW9uIHJlc3VsdCBwYXNzZWQgYnkNCj4gY2ZnODAyMTFfb3BzLmV4dGVybmFsX2F1dGgoKSB0bw0K
PiAgIGRlY2lkZSBpZiBhc3NvY2lhdGlvbiBzaG91bGQgYmUgcHJvY2Vzc2VkIHdpdGggcmVtb3Rl
IEFQIGZvciB0aGUgb3JpZ2luYWwNCj4gY29ubmVjdGlvbg0KPiAgIHJlcXVlc3QgYW5kIHJlcGx5
IGNvbm5lY3Rpb24gcmVzdWx0IHRvIGNmZzgwMjExLg0KPiAgIE5YUCBGVyBvbmx5IHN1cHBvcnRz
IGFzc29jaWF0aW9uIHdpdGggb3Igd2l0aG91dCBhdXRoZW50aWNhdGlvbiwgaXQgY2FuJ3QNCj4g
c3VwcG9ydCBleHRlcm5hbF9hdXRoLg0KPiANCj4gMi4gSG9vayBzZXBhcmF0aW5nIGF1dGgvYXNz
b2Mgd2lsbCBvZmZsb2FkIFNNRSB0byB3cGFfc3VwcGxpY2FudA0KPiBjb21wbGV0ZWx5LiBEcml2
ZXIvRlcgZG9uJ3QgbmVlZA0KPiAgIHRvIGludm9sdmUgdGhlIHByb2Nlc3Mgb2YgYXV0aGVudGlj
YXRpb24ganVzdCBsaWtlIGV4dGVybmFsX2F1dGggZGlkLiBUaGVyZQ0KPiBpcyBubyBlZmZvcnQg
Zm9yIGRyaXZlci9GVw0KPiAgIHRvIHN1cHBvcnQgYW55IGZ1dHVyZSBtb2RpZmljYXRpb25zIG9m
IGF1dGhlbnRpY2F0aW9uIHByb2Nlc3MuDQo+IA0KPiBEYXZpZA0KPiANCg0KQ2FuIHdlIGNvbmZp
cm0gdGhhdCBob29raW5nIHNlcGFyYXRpbmcgYXV0aC9hc3NvYyBpcyBtb3JlIHN1aXRhYmxlIHRo
YW4gImV4dGVybmFsX2F1dGgiIGZvciBtd2lmaWV4Pw0KDQpEYXZpZA0K

