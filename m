Return-Path: <linux-wireless+bounces-9743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1DF91D5A8
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 03:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674411F210A3
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 01:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DEB1C32;
	Mon,  1 Jul 2024 01:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HukyPOiB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2077.outbound.protection.outlook.com [40.107.241.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC7B1388;
	Mon,  1 Jul 2024 01:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719796329; cv=fail; b=UjhlXBr67orfpErF8n3rn7+47tTxUpg7E6UL4dk0clQH1Q5Bf2oj8TF1/Ox2RudKYOUc1E36wRleeCywHLDJOgKtrGq+9JrAJx/cd5o1xA+ZqzrB2tPIEn5NrgJPVivZBCFwzvwlwKSRYDoNZMgpRcDJJ1LurxnoNejmVYxe/UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719796329; c=relaxed/simple;
	bh=Rzg11bWv9ZwsXqzuwe/b3dyyyOleSlGSCXyzOkYEPbE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PCgmkbV8M4+GhHOvmSv1exgAHbcJ6/l9gf5Sa7QBnreFkUCYmY11zH82ffowKORviDuyQFfQZA13Y/HV3yb2+qVyEQriEdtf9S2Z2SlOYRvnY9w44B1BtLioHxtinjY+7QYyaGRJjvg3O8O3XO9PX+NbOWhN5CA9VA+lKD7zazg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HukyPOiB; arc=fail smtp.client-ip=40.107.241.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbVLCWnCA6k+7hrynLbUZgMmeiVVSxKEKllH1wxNNKeQYQ9dCvz1WTmAgJGkBMT6+61M6byYkBsB83d3lyVUFs7WCQOHasBdgBA95naQVwG/ul6v1D+o/WmvVV4wE8bHKNXRwDOq4TigHWzbuXK5QKBL5MfdI7gVM9l3G9ZEXcVh1zCIkmTl/WPxEXGg/HfG7MstNrVnWIG1dgDzg7BMGsY/7apMNrVuH45QIerNY9yOHCX6mrGBRvyeBtuv1VScwb41DqZ7Dq7OV4HZBiUly9Phr6OQtwqnYc3nTRhrrgdiTQ6YfFjMXkSIe933t4oWt0C4umWig0WhqdByKb1Kng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rzg11bWv9ZwsXqzuwe/b3dyyyOleSlGSCXyzOkYEPbE=;
 b=U5S0cwpf4w1GrQYsldENdPg5ub5q/U3Z4caEbmVTqq908bczbYY+YVcsus32sRn4yN3tikTvVYcNkab/hOdyEM6yGScDY2JucC1J6EDlCqf7mCBSOYIlEvPaE5mp4PYVZ4YqC8nMVc9xrzDDK+DD4LKH7ZJQ2kHUVQogFrW6K5nMahdz0Fva5mInCGlfcBFH0ZDvJxr8ezbaRml3wLqwkTBCjN8nTUpPsurP/rO+AzUWYYr/t+PqoImTnir77n7oXt38ywb5FFT6nmmk6ZBeWSAGrPEzv32VOXRGLx4mXdcc1CC35ZBoKjVPPoiG4xA4D80uu0Zsq0J79ipZR+NX5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rzg11bWv9ZwsXqzuwe/b3dyyyOleSlGSCXyzOkYEPbE=;
 b=HukyPOiBdRj0CXgYfe7vfCwUhk4kZhGRDzObzXhYICaamWgPbAjatWzHTGqIExScT5jK235U5Ii0sbe+2H+V+2vDPqdLC4lrH53vxUSZlGRYjEYgUqn/mzNt9J1upuvCFD+7XtOm+4thICiplIopCS/8vC9wxJQKNhO6dqJmjDI=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB8787.eurprd04.prod.outlook.com (2603:10a6:20b:42e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 01:12:03 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 01:12:03 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: David Lin <yu-hao.lin@nxp.com>, Brian Norris <briannorris@chromium.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "francesco@dolcini.it"
	<francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, Francesco
 Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for client
 mode
Thread-Topic: [EXT] Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for
 client mode
Thread-Index:
 AQHakVadTJiKH7Fbwkii2Ljo0AqkAbGkNJ4AgAIC2FCAAJ4RgIAAUeEwgAAQrACAAB/CYIAp+uAAgACzNCCAD344wA==
Date: Mon, 1 Jul 2024 01:12:03 +0000
Message-ID:
 <PA4PR04MB9638F352F7026C4DFBD8C562D1D32@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <20240418060626.431202-2-yu-hao.lin@nxp.com> <Zk6TklTIbxZxIWyb@google.com>
 <PA4PR04MB9638DC958102D07A7B7084B6D1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXOE2Pwv3kRhwkAd1e3+U8zxZi7cX0TeLDkycQya9xkdPA@mail.gmail.com>
 <PA4PR04MB963875C85CFFA0EE2E914BEAD1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXMzHRs=CeyVeMbY44ornTa7f8G3ek3bFeyX39QAwr5bog@mail.gmail.com>
 <PA4PR04MB96380A04A6830AB69024E4B2D1F62@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZnRsfiau_JSWBXTZ@google.com>
 <PA4PR04MB9638E38BF0C8391582EDB121D1C92@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To:
 <PA4PR04MB9638E38BF0C8391582EDB121D1C92@PA4PR04MB9638.eurprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AS8PR04MB8787:EE_
x-ms-office365-filtering-correlation-id: a7a98a93-5347-4177-6538-08dc996ad124
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cWlkZ3pUYzNZNHZCdDZ1S1V2VHgrbHdzUzMrM21TZkF5b3BTN0p6UVprNmoz?=
 =?utf-8?B?eEw4MXVSSitTYjBBeHZlL3lUWmVLQ0Vub0VPNENCN0dtRGw4ZVJXRElPY0ta?=
 =?utf-8?B?MVQrWVFQRGs2SnVQbHFiYkJyNEpYdkFVSlg0YVdiSVNzS3dHUWhGdjhLZ0t5?=
 =?utf-8?B?eEl6SEg1NTJ1cWtVdTBIMGE2TWlobGZUZjdJSDRaQjY4MHQ0V1MwSEpuYlF4?=
 =?utf-8?B?M2IybjJoaFRqNTFubDlRZHlGNVQ0Wm96ME10a2VZTEZaeG5TMzhOUHdPd0xr?=
 =?utf-8?B?am81NHJITllXdy8rY21YZE04UVdTaDlxR1BuY0NCRnZzUCtDcmhWZ1NnVUx4?=
 =?utf-8?B?d0dwb2MvT1pnc040YWdDRWgxeE1ka0JnbVhkUnZoYWlHK2k2VVVjVlo5SklX?=
 =?utf-8?B?d3R6UUFud1p5WnE5dkRZTDAxRHpGV1IvcmUrc3lpMW96QmFPdXJWanlGdUhs?=
 =?utf-8?B?M0V5Wnl6QVlSWXNxYVNXY1I0eXVnbWxDcVIvUmZlUWxkaEp4Y2x3VFJHK1ZY?=
 =?utf-8?B?eFFIM0loYWZDRVFDNzhtUUdURzBHZW9lSFNvRkNIZE91SHVOcTU1UnhoT3Jl?=
 =?utf-8?B?enBGekVtY1ZsZm1DbjVxYU01TlkvczMweVMxK3NrSm9PTzRENkEzMGNDRlFy?=
 =?utf-8?B?a3BaNUFDeHlNS0FuNVN0Undhc1NpMXlvSUtYVzJ1QnVoTGIyMENFZlZwMVAr?=
 =?utf-8?B?ZWRERWZYMDVnb3V5Y0dzZTdUbHVOcGw3ek5mVlhKTUMvRHZJaEh1YXF2alBz?=
 =?utf-8?B?Tmh4QlpyVFdycjhKOWt3VlVBVm9oMHBnWEtuZ2YwdVB4MmMvYkM0QTZCQWNC?=
 =?utf-8?B?Mlg3WHB6d0dtU2xINkFIWlkyampMeWNvSzBLcUFlU3RmeWx4RW81U2dDdTgx?=
 =?utf-8?B?UjdGOHluU1JscmNVWUVzV2lPTGtHWnl2S3VEZkh5SFZqblhQdjVKV3lONUVr?=
 =?utf-8?B?QnQ2YXZOZmpZY3ZGN2lueUZSSkF5L0wzM0dxbjFsSEpDNHE0ZnRBS0lLNHIw?=
 =?utf-8?B?ZXZ2TE9NSGZta1lBcTNkekcyTTRKRVR5bytBd2pFMFBlYmZod1l2VGsrVTNQ?=
 =?utf-8?B?dGs0QWpFV01xSnRyVzZIbnBaMk9QdjFQL0dUUkJGTUVDd2gwNUZRRnNLZm5k?=
 =?utf-8?B?d2RUZDhvQndnQitxZE4xZmgzeFM3TUF4VmFhT1ZLejcrSk0zV2JKazIrZDJa?=
 =?utf-8?B?S1BzRC9KcjZycXdKVFlwOTB1dTRLNzdMVkpKMmFVYXFUa3MwUGZmdnFVTU9o?=
 =?utf-8?B?ckJua1FzUFQ1VjhzeURqbGRIVzhPMGFIVTdTM1g0U1R6SFZMUUcxVHRTZ01P?=
 =?utf-8?B?ZFlZMlF5OUxMaDhOYXkvSFBqUkRVKzVtcE1BS09vTStzU3FFTy85OGdVOEtU?=
 =?utf-8?B?S2NNWExEbkNWZTZTVjBLbS9xc25RQmExcVlrTFNTRXpZS3JqakVPdVpnb2Uv?=
 =?utf-8?B?ZXY5RFM5R2NTQzJXdHZpdGZjdDRIcWtRRkhvb0ZzSE5McWxxVllBdjNZb3B1?=
 =?utf-8?B?RUNEUnMySFB6aGM3SUhRVW1QOVRtYURCQVM0YzRBVXNoQ1plZWpQcmVBYXZl?=
 =?utf-8?B?Zm5mQzBIZ2FlOEkrbHlVcHhNR1hqSFhyMDRGKzdXS2FWMVRaeForMXdyQWhu?=
 =?utf-8?B?NWJkaEpuaWJrMkFBdUhzTUJRNkNzMFFSWTJuNkRRV1U5cFFaWmJva0tmUHh2?=
 =?utf-8?B?NVVjNTd2dDR0QkFHRk5EN2E2SThvMlVrSzFoQmVjWjhWNG9CWVdTUll0dTEz?=
 =?utf-8?B?a1lLOVl0N3I3V1pXNDZLT1NGbFNxSHh6cVhlQ1BIZmFETit2dVJod0ZtbWJu?=
 =?utf-8?B?RnRsUGxZMzR1ZHU4RzBKanQrQW1Nd0pTSWNoSFlYVTYzUzBFdkZNK0o4QnVD?=
 =?utf-8?B?aXNuZ3hpbmw0TGNOSGtleTBtQkUweW9XZ3lyUDBYQ2NGQnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y0NSSGlNZkhuc1VkaWYxb3ZTSWx5akdkelNiL2hNMzdWN1BRR05wZFJBRklF?=
 =?utf-8?B?dkttUno3Q2ZoTnZFTVNRSXErMDBPL3hqLzBKS0VLODZJT2UxWkRHakYwclZX?=
 =?utf-8?B?V1JORGYwZzcySGphcEE5NG1WZXpYNFZ3K0MrRmNMRHdpSHF0aEJRVHUvamF5?=
 =?utf-8?B?MTI0dmJtbkVSMFAxQ00zZWUzMDdFUEloaFZvN2hMaWZiMlhJZW1PVHN0OGxQ?=
 =?utf-8?B?bEVNSDZ3UjczSGhxNmdjOFkxclloWlB0T09UMTM1dURCYWtNRUtNZ1FPcjhR?=
 =?utf-8?B?dy9yRDNJaFNHTmwrV3pDVCtCUXJoT2lJbTllSFlsaDNGaDAwTlUvYkNPSjFp?=
 =?utf-8?B?dXpVZ1RrNGlFSzFwR3R2T2U2cGNoMExrVmhNYzF4ditSMTFjbWR6bDNlUUhC?=
 =?utf-8?B?ZEQ1VXZwVHdFK3J6UjlnenBhS1c0U0FERytHeGsvUy9FSldWNjNZcTZSdDc4?=
 =?utf-8?B?SlM4bG0zY05nOFpYSmY1ZlN5M2p2bTJmKzlqNmJPQW1uUnV6d3FqcWFjcVBC?=
 =?utf-8?B?ZTIwQUNyTTY1UVovRnhmNithMDNrenhQL3lKWDl3ZEpTakEzWGl5OWNUSGlW?=
 =?utf-8?B?Vk1aWU1wbHhKMU5YZjl6SjgrOVBFU1ZvdXo0bm9Jc1JhQldGRHdTOXQycm5N?=
 =?utf-8?B?aCtzYUdIK1RUSnlDbVUySG1MNHo3SGJkaysyZFNjblR2by84anVBamtTa2VD?=
 =?utf-8?B?clFQQ1FsRlZvY21nU2V4YWZONklMejA3dTI2UkU1TEhOajJaQWU0MnJUNGlm?=
 =?utf-8?B?c2RmWUZiTGlhc25tMlhxa0YzNWF6UE50bGlDSnpTa2VsL2JOTVQvUXUxL1pn?=
 =?utf-8?B?RXU1dkxjeVJDMW15VERLRDVqOGhzSXIxejYvd3hsd2ZzTFZrdlhFT2M4MEJJ?=
 =?utf-8?B?dGpGclo2Yys0ZEpaait5eU9pZHNhekd1ZVV4ZUk1VWk3dS9PbUhPeUhkZmp0?=
 =?utf-8?B?ZTFFbXI3amptem4wWjdxbVVwSGl2d1hUZDlBa0RhYmpEZ29XbWZnSEtobHRL?=
 =?utf-8?B?QTZTeVhLNlVWRmxlMU93c3pIMXhvakd2cnNYVFgvTWlnblVhT2szVWdaelNF?=
 =?utf-8?B?K3g3bmRlLzJvRmNZZ214MnlpMHUvb3ZBbjRreTNyZ0ZHNUk3azY1OWRqYXEz?=
 =?utf-8?B?VVliQXM3VTRxb2NsMEEzNzZVTDlIVGc3UnlCZ1NjNVFtWlBna0pMUG5Kdjd3?=
 =?utf-8?B?QjREbFhpVkhkM3NrWEpSUHQ0NHJUR0x1Y2JFdXN1VWtneWpUWDY3aERGZ0FK?=
 =?utf-8?B?V00zd2ppaG4zUC9wTWVKZTh1NjdkcWpsNHErYmwyWHp2aTJkVmRFRG9lWTZ5?=
 =?utf-8?B?VHhJaHBucWJUNkRoUlJ3bW1ZVUJVNFI5b1VVcFA1ajZFTHhKRWgwdFI4b2t3?=
 =?utf-8?B?cm1YT1Jna1FObUlsVk1YbWhKaU9BT0ZaaTZwR2hqbUQ3cUVZckQvK2szSWRh?=
 =?utf-8?B?Y1Y3OStZTnlYRmVVT001dm1FaW0ycFliajBYK2NqQVdwbDhaVGpnelRwSnpI?=
 =?utf-8?B?WFNXM3RjY0YwRHdVY1JWQUlmS3FIc3FWeEd0dnhuejJjU3RPZE9vdWdrV1VV?=
 =?utf-8?B?Y24rOVg1cmhTNGM3S1JuTkgvdHZKRTE1N0ZUSjFYclRieHB3Ymo5S0VyTFV5?=
 =?utf-8?B?Q2ZOeGN0SjNNYVFOR3NWY0lERHM5SHJyUUIxUFpvcFpNclNqRXE2REwzMmZG?=
 =?utf-8?B?R0ttbkhEbUNFYUtJRSs0cFJvM1VlamF5OEl5bng2RzlOd2F4dm9nUnBoYkpz?=
 =?utf-8?B?MTJxeTBSOW9nenh6VWVNaFZsenNSOHFtWHRQcHR0YmM1OFpKY0ZwMTlJQm1L?=
 =?utf-8?B?dHZaMFBYY2o2Q09jbFRxY0p4TWw2NU1VR3EyYm81WXFMVFBUOXBMTGY2Rlht?=
 =?utf-8?B?b1N5ZHJYUlBiTGlDSGNYdmJ2RUNoQVY0N1NFanZFTXloSzNDL25vcEk0VDY4?=
 =?utf-8?B?dGFaTzl6Y1pZakVlTUJVbXNEaHhqaWg4Q3l0QnoySU1SVHhaMWVvR0JLdm1u?=
 =?utf-8?B?WU5rVUp5VUhOTHJpd3pmblc1Q2liSnF4WmZvODFTWXRSc1Q5SGJYRXBNVXB0?=
 =?utf-8?B?ZE11WkFaREFpdVN0TnNSejJCSmZzWVNvL2hBMm1zSFMwK3R2QUNtajhoS3NB?=
 =?utf-8?Q?N3rvmyRqdezE11aZwIXTatrMM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a98a93-5347-4177-6538-08dc996ad124
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 01:12:03.3600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qmpMuWkNKifbuKi9pab2tAhsR9a6KOYzjrCEU5e87KHkYP9DKL+AASk1EJbiW83lDfxKOs1vl/tNCjNd7vn9pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8787

SGkgQnJpYW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQg
TGluIDx5dS1oYW8ubGluQG54cC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAyMSwgMjAyNCAx
MjozNiBQTQ0KPiBUbzogQnJpYW4gTm9ycmlzIDxicmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc+DQo+
IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGt2YWxvQGtlcm5lbC5vcmc7IGZyYW5jZXNjb0Bkb2xjaW5pLml0OyBQZXRl
IEhzaWVoDQo+IDx0c3VuZy1oc2llbi5oc2llaEBueHAuY29tPjsgRnJhbmNlc2NvIERvbGNpbmkN
Cj4gPGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tPg0KPiBTdWJqZWN0OiBSRTogW0VYVF0g
UmU6IFtQQVRDSCB2MTAgMS8yXSB3aWZpOiBtd2lmaWV4OiBhZGQgaG9zdCBtbG1lIGZvciBjbGll
bnQNCj4gbW9kZQ0KPiANCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxl
YXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcgYXR0YWNobWVu
dHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydA0K
PiB0aGlzIGVtYWlsJyBidXR0b24NCj4gDQo+IA0KPiBIaSBCcmlhbiwNCj4gDQo+ID4gRnJvbTog
QnJpYW4gTm9ycmlzIDxicmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc+DQo+ID4gU2VudDogRnJpZGF5
LCBKdW5lIDIxLCAyMDI0IDE6NTMgQU0NCj4gPiBUbzogRGF2aWQgTGluIDx5dS1oYW8ubGluQG54
cC5jb20+DQo+ID4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiBrdmFsb0BrZXJuZWwub3JnOyBmcmFuY2VzY29AZG9s
Y2luaS5pdDsgUGV0ZSBIc2llaA0KPiA+IDx0c3VuZy1oc2llbi5oc2llaEBueHAuY29tPjsgRnJh
bmNlc2NvIERvbGNpbmkNCj4gPiA8ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb20+DQo+ID4g
U3ViamVjdDogUmU6IFtFWFRdIFJlOiBbUEFUQ0ggdjEwIDEvMl0gd2lmaTogbXdpZmlleDogYWRk
IGhvc3QgbWxtZQ0KPiA+IGZvciBjbGllbnQgbW9kZQ0KPiA+DQo+ID4gQ2F1dGlvbjogVGhpcyBp
cyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nDQo+ID4g
bGlua3Mgb3Igb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBt
ZXNzYWdlIHVzaW5nDQo+ID4gdGhlICdSZXBvcnQgdGhpcyBlbWFpbCcgYnV0dG9uDQo+ID4NCj4g
Pg0KPiA+IEhpIERhdmlkLA0KPiA+DQo+ID4gT24gU2F0LCBNYXkgMjUsIDIwMjQgYXQgMTI6NTA6
NTlBTSArMDAwMCwgRGF2aWQgTGluIHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4gRnJvbTogQnJpYW4g
Tm9ycmlzIDxicmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc+DQo+ID4gPiA+IFNlbnQ6IFNhdHVyZGF5
LCBNYXkgMjUsIDIwMjQgNjo1NSBBTQ0KPiA+ID4gPg0KPiA+ID4gPiBPbiBGcmksIE1heSAyNCwg
MjAyNCBhdCAzOjAx4oCvUE0gRGF2aWQgTGluIDx5dS1oYW8ubGluQG54cC5jb20+DQo+IHdyb3Rl
Og0KPiA+ID4gPiA+IEkgdGhpbmsgaXQgbmVlZHMgdGltZSB0byBzdXBwb3J0IHByb2JlIGNsaWVu
dC4gQ2FuIHdlIHB1dCB5b3VyDQo+ID4gPiA+ID4gc3VnZ2VzdGVkIGNvbW1lbnRzIHRvIHRoZSBj
b2RlIHVzZWQgdG8gaG9vayBwcm9iZV9jbGllbnQoKSBhbmQNCj4gPiA+ID4gPiBhZGQNCj4gPiA+
ID4gPg0KPiA+ID4gPiA+ICJUT0RPOiBzdXBwb3J0IHByb2JlIGNsaWVudCIgdG8gbXdpZmlleF9j
Zmc4MDIxMV9wcm9iZV9jbGllbnQoKS4NCj4gPiA+ID4NCj4gPiA+ID4gQXJlIHlvdSBzdWdnZXN0
aW5nIHRoYXQgeW91IHBsYW4gdG8gYWN0dWFsbHkgaW1wbGVtZW50IHByb3Blcg0KPiA+ID4gPiBw
cm9iZV9jbGllbnQgc3VwcG9ydD8gRGlkIHlvdSBhbHJlYWR5IGRvIHdoYXQgSSBzdWdnZXN0ZWQs
IGFuZA0KPiA+ID4gPiB1bmRlcnN0YW5kIHdoeSBob3N0YXBkIG5lZWRzIHByb2JlX2NsaWVudCBz
dXBwb3J0PyBUaGlzIHNlZW1zIHRvDQo+ID4gPiA+IGJlIGEgY29tbW9uIHBhdHRlcm4gLS0gdGhh
dCByZXZpZXdlcnMgYXJlIGFza2luZyBmb3IgeW91IHRvIGRvDQo+ID4gPiA+IHlvdXIgcmVzZWFy
Y2gsIGFuZCBpdCB0YWtlcyBzZXZlcmFsIHJlcXVlc3RzIGJlZm9yZSB5b3UgYWN0dWFsbHkgZG8g
aXQuDQo+ID4gPiA+DQo+ID4gPiA+IE5vdyB0aGF0IEkndmUgdHJpZWQgdG8gZG8gdGhhdCByZXNl
YXJjaCBmb3IgeW91IC4uLiBpdCBsb29rcyBsaWtlDQo+ID4gPiA+IGhvc3RhcGQgdXNlcyBwcm9i
ZV9jbGllbnQgdG8gYXVnbWVudCBUWCBNR01UIGFja3MsIGFzIGEgcHJveHkgZm9yDQo+ID4gPiA+
IHN0YXRpb24gcHJlc2VuY2UgLyBpbmFjdGl2aXR5LiBJZiBhIHN0YXRpb24gaXMgaW5hY3RpdmUg
YW5kDQo+ID4gPiA+IG5vbi1yZXNwb25zaXZlLCB3ZSBkaXNjb25uZWN0IGl0IGV2ZW50dWFsbHku
IFNvIHRoYXQgbG9va3MgdG8gbWUNCj4gPiA+ID4gbGlrZSBwcm9iZV9jbGllbnQgc3VwcG9ydCBz
aG91bGQgYWN0dWFsbHkgYmUgb3B0aW9uYWwsIGlmIHlvdXINCj4gPiA+ID4gZHJpdmVyIHJlcG9y
dHMgVFggc3RhdHVzPyBBbmQgaW4gdGhhdCBjYXNlLCBJJ2Qgc3RpbGwgcmVjb21tZW5kDQo+ID4g
PiA+IHlvdSB0cnkgdG8gZml4DQo+ID4gaG9zdGFwZC4NCj4gPiA+ID4NCj4gPiA+ID4gQnV0IGlm
IHlvdSdyZSByZWFsbHkgcGxhbm5pbmcgdG8gaW1wbGVtZW50IHByb3BlciBwcm9iZV9jbGllbnQN
Cj4gPiA+ID4gc3VwcG9ydCwgdGhlbiBJIHN1cHBvc2UgdGhlIFRPRE8gYXBwcm9hY2ggaXMgYWxz
byBPSy4NCj4gPiA+ID4NCj4gPiA+ID4gSSdkIGFsc28gcmVxdWVzdCB0aGF0IHlvdSBwbGVhc2Ug
YWN0dWFsbHkgZG8geW91ciByZXNlYXJjaCB3aGVuDQo+ID4gPiA+IHJldmlld2VycyBhc2sgcXVl
c3Rpb25zLiBJJ20gZnJhbmtseSBub3Qgc3VyZSB3aHkgSSdtIHNwZW5kaW5nIG15DQo+ID4gPiA+
IHRpbWUgb24gdGhlIGFib3ZlIHJlc2VhcmNoLCB3aGVuIHRoZSBvbnVzIHNob3VsZCBiZSBvbiB0
aGUNCj4gPiA+ID4gc3VibWl0dGVyIHRvIGV4cGxhaW4gd2h5IHRoZXkncmUgZG9pbmcgd2hhdCB0
aGV5J3JlIGRvaW5nLg0KPiA+ID4NCj4gPiA+IFllcy4gSSBrbm93IHdoZW4gYWdpbmcgdGltZSBv
ZiBzdGF0aW9uIGlzIG91dCwgaG9zdGFwZCB3aWxsIHVzZQ0KPiA+ID4gcHJvYmVfY2xpZW50DQo+
ID4gdG8gY2hlY2sgaWYgc3RhdGlvbiBpcyBzdGlsbCB0aGVyZSBiZWZvcmUgcmVhbGx5IGRpc2Nv
bm5lY3QgaXQuDQo+ID4gPg0KPiA+ID4gV2l0aG91dCB0aGlzIGZlYXR1cmUsIGl0IHdvbid0IHJl
YWxseSBhZmZlY3QgbWF5b3IgZnVuY3Rpb24gb2YgaG9zdGFwZC4NCj4gPg0KPiA+IEknbSBnbGFk
ICp5b3UqIGtub3cgYWxsIGFib3V0IHRoZSBhYm92ZSBiZWhhdmlvciwgYnV0ICpJKiBkaWRuJ3Qg
a25vdw0KPiA+IGFib3V0IGl0IHVudGlsIEkgd2VudCBhbmQgcmVzZWFyY2hlZCB3aGF0IHRoaXMg
QVBJIGRvZXMsIGFuZCBob3cNCj4gPiBob3N0YXBkIGlzIHVzaW5nIGl0LiBCdXQgdGhhdCBpc24n
dCBteSBqb2IgLS0gaXQncyB5b3VyIGpvYiwgYXMgdGhlDQo+ID4gY29kZSBzdWJtaXR0ZXIsIHRv
IGV4cGxhaW4geW91ciByZWFzb25pbmcgYW5kIHJlZHVjZSB0aGUgYW1vdW50IG9mDQo+ID4gd29y
ayB0aGF0IHJlYWRlcnMvcmV2aWV3ZXJzL21haW50YWluZXJzIGhhdmUgdG8gZG8gdG8gdW5kZXJz
dGFuZCB5b3VyDQo+IGNvZGUgYW5kIGFncmVlIHRoYXQgaXQgaXMgdGhlIHJpZ2h0IHRoaW5nIHRv
IGRvLg0KPiA+DQo+ID4gSXQncyBub3QgY2xlYXIgdG8gbWUgdGhhdCB5b3UndmUgcmVhbGx5IGxl
YXJuZWQgdGhlIGFib3ZlIGxlc3NvbiwgYW5kDQo+ID4gaXQncyByZWFsbHkgYWZmZWN0aW5nIHRo
ZSByYXRlIGF0IHdoaWNoIEkgcmV2aWV3IHlvdXIgY29kZS4gVGhpcyBpcyBieQ0KPiA+IGZhciBu
b3QgdGhlIGZpcnN0IHRpbWUgdGhhdCB5b3UndmUgcGxhY2VkIHRoZSBidXJkZW4gb24gdGhlIHJl
YWRlci4NCj4gPiBBbmQgaWYgeW91J3JlIGdvaW5nIHRvIG1ha2UgdGhlIGpvYiBkaWZmaWN1bHQs
IHRoZW4gSSdsbCBwcmlvcml0aXplDQo+ID4gZW5qb3lpbmcgbXkgZnJlZSB0aW1lLCBvciBzdHVm
ZiB0aGF0IGFjdHVhbGx5IHBheXMgbWUgYXQgJERBWV9KT0IsIG9yIC4uLg0KPiANCj4gSSB3aWxs
IGtlZXAgdGhpcyBpbiBtaW5kLg0KPiANCj4gPg0KPiA+ID4gVGhhdCBpcyB0aGUgcmVhc29uIHRo
YXQgSSBzdWdnZXN0IHRoYXQgd2UgcHV0IGNvbW1lbnRzIGFuZCBUT0RPIHRvDQo+ID4gPiB0aGUN
Cj4gPiBjb2RlLg0KPiA+DQo+ID4gT0ssIEkgc3VwcG9zZSB0aGF0IHdvcmtzIGZvciBtZS4NCj4g
Pg0KPiA+IEJyaWFuDQo+IA0KPiBJIHN1Z2dlc3QgdGhhdCB3ZSBqdXN0IHB1dCB5b3VyIGNvbW1l
bnRzIGFuZCBwcmVwYXJlIHBhdGNoIHYxMS4NCj4gDQo+IFRoYW5rcywNCj4gRGF2aWQNCg0KSSB0
aGluayBXUEEzIGlzIG1vcmUgcm9idXN0IGFuZCB1cGRhdGVkIHNlY3VyaXR5IG1ldGhvZC4gUGxl
YXNlIGhlbHAgdG8gbGV0IHRoaXMgcGF0Y2ggYmUgYWNjZXB0ZWQuDQpQbGVhc2UgbGV0IG1lIGtu
b3cgd2hhdCBlbHNlIHNob3VsZCBiZSBkb25lIHRvIGxldCB0aGlzIHBhdGNoIGJlIEFDS2VkIGJ5
IHlvdS4gQW5vdGhlciBpcyBhbHJlYWR5DQpBQ0tlZCBieSB5b3Ugd2l0aCBtaW5vciBtb2RpZmlj
YXRpb24uDQoNClRoYW5rcyBmb3IgeW91ciBlZmZvcnRzIGFuZCBoZWxwcy4NCg0KRGF2aWQNCg==

