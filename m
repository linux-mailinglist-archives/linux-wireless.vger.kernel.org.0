Return-Path: <linux-wireless+bounces-9636-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1A2919DE3
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 05:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA8C2855F7
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 03:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BADA1BC46;
	Thu, 27 Jun 2024 03:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mubNK1SQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2067.outbound.protection.outlook.com [40.107.103.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1640B1BC41;
	Thu, 27 Jun 2024 03:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719459440; cv=fail; b=nEi6axhLG2Iyv9VPaht69+HbOKGpoE56a1H3D+5lT2kY+uymfX73DdF7TbJVZf8D3Rkk/qTj3v0FowOxL8LYwLrM4/VNJ6fqRyOoRaPuEHagbht5nGAHv1y65Nc2tdr6Ti2nMyJ9oSihx1zPWq6CN+GbOMoZW+QP8Hnv2m3K4fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719459440; c=relaxed/simple;
	bh=/CHuH1cszp5kI70/SkoqfJm+ju/nj977/yDvvqerM8k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ll36t/IFygxYfe3FchkRJ2WKXegN48Z8126MkDalaVSVm28OYjSb48gVLu23AZtbTb+UiFo8wt7zHDvybfzCG0ltJeZCWpqrD+g8LUJGxzkiMuVpYO+2eyLGDbup/a7Kd/qa9jbkjdVf5qsUPfMfUCYqCr+K6AAIiwFJWPdi6S8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mubNK1SQ; arc=fail smtp.client-ip=40.107.103.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlhyU7XoCKjQqfSuLSjcfZjv8rObwZUx00B201k6txp0FEx1Atm/q5YAaCDx+ya0+tqDYivjh4kxgoD1TiSTiLlMGnyZ/S6WfwtRwD9d7+9Wt2c/CJcxvoy4UGu8b00ABaU3sWtlA76Es8t0XMyGAMx7sbquZAD7QzCZAw3gy9rpHzLACfFkGu3zwcq6AyBQZEdCW90ZJUdhnDl0xDuQpXRKQNMwWoVkJlDhMI8mpUi1+TU5bc/QI9Yr5iA762A9k5h6p1AOcTfk+IkPtuZS1if40ny/dMqmaD7g/xjmBgeNhyJBmBXL7K8twf2ztKE+7hdMtaFNsC7eYRnbc3XGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CHuH1cszp5kI70/SkoqfJm+ju/nj977/yDvvqerM8k=;
 b=R5HSS2T1p9loxbKg/gvrLizMs6o+5l+hdduzYj6/godPYWGhMUxnIpLc2J/Dm5ZMdDwGRiS+pBbmyjasaU1vytBKm+B8o2AES3/DpsbsQwJNVnYEGmLZHzSD1pyXirje7q/nHt8zTsF0NWQxSwTuKpNo9eP3hJuSfr1m8m+zJCExv22io+dc82ogLzmR/gaWLwJv2vk45/XOB/Xohm1Lx4+P//Nv3JpGCdPi2PKZS1IrjuKMUDbMsNR12qYtfpjxI3sAcjGYP/4uJbKyh4dN5pmzRa5k1BtyQk2HVPzwJkKu/HCq7v9rqoayc2cnlY/Bc/ja1l0RK5lIdxKS3bbMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CHuH1cszp5kI70/SkoqfJm+ju/nj977/yDvvqerM8k=;
 b=mubNK1SQF9HnAcutoxwxRRyOFBuOhr+bSm5Ixqjwl37Kr0Kqv8HeKt2nif2Hl5M/NSb4GwYwFJPidFQYoENy+4KAvz8GOzg3oRL6SL4Zp0vAVjZ+pi1i/ztZmC3CWUfgMJ0JGKQOZJG2aKh028SVSThZDotlXhpBwJAtXzVbhPU=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DBBPR04MB7561.eurprd04.prod.outlook.com (2603:10a6:10:209::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 03:37:15 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 03:37:14 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: "Nemanov, Michael" <michael.nemanov@ti.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [EXTERNAL] [PATCH 26/43] wifi: nxpwifi: add sdio.c
Thread-Topic: [EXT] Re: [EXTERNAL] [PATCH 26/43] wifi: nxpwifi: add sdio.c
Thread-Index: AQHaw7Auck+MIYBAL02p6vlG838K5LHZ89kAgAELBxA=
Date: Thu, 27 Jun 2024 03:37:14 +0000
Message-ID:
 <PA4PR04MB963897BF79B6F05700263A7CD1D72@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240621075208.513497-1-yu-hao.lin@nxp.com>
 <20240621075208.513497-27-yu-hao.lin@nxp.com>
 <16de364e-bd80-4674-9125-74c33e551961@ti.com>
In-Reply-To: <16de364e-bd80-4674-9125-74c33e551961@ti.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DBBPR04MB7561:EE_
x-ms-office365-filtering-correlation-id: c58a4f81-d2c5-4e9d-b4b8-08dc965a6fd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Qm9zanBTbnRxVlUwTFFTOG0vd1IyNUZQRG5uc3IvbUhMTVVJVE5SSlpvaHBx?=
 =?utf-8?B?UVpudkNtaHJRU01hSFFSMmp3OE5rQUVRQ2hLMjZwNitnSHpsS1oxRU1zNHdO?=
 =?utf-8?B?d0E1bTJDb2pkSFU2ZzJqd2xSTURXcTRyRU13WXdPbE1BOTJWdGVFYm9OTGVV?=
 =?utf-8?B?VVl1cE1JbzNjQkwwN3FvNm1XWFgyb2gyTnJhNStxRW0vbG5Zc1ZoQ2RsQ29Q?=
 =?utf-8?B?cVk5OTMrZ1NLeUlmWlVPbzRkaG9Lelk0TXVBaDd6c3JGV3NHenBET0trcTZh?=
 =?utf-8?B?bWx2NVhNV2Nwcko4S1JOZytvS1E5cVpIaThNVnhRMFI5Smo1Nnh2Zm9mb2Jj?=
 =?utf-8?B?ZEZzcW9VUnI0MkJIejdweTFacHdTOC9qc2xPRVJSM00vcllaNTVQelh4Vk1O?=
 =?utf-8?B?YWpzYVlzR0YrMnYrN2FNd1hPS3ZsK0NpZlRFL2JJbUhYSkgvVzhPTHlwZXd5?=
 =?utf-8?B?cGN2eVRFcEo4OENOQmkxbWlSWGFJYUhqbE5mUWlEdWJ1emF3VWRSQk80a2cr?=
 =?utf-8?B?MmVTSkRCbjN0WnRMWWR5Smt2cWdZOWg1SlUxcStsRW1VbGpVYkFkTXc1Q0Rq?=
 =?utf-8?B?V1FoQ05BTWRYc0k1cndiZ2JFK2FKSG91Q3dYaldWb1pHMi92b2ZSNW5XUWtF?=
 =?utf-8?B?VHJTTWhzY3NGMWx6aXZQeWFJcGd5UjhURmN1KzBYcmE1eUNyTlp5eWtqWHM0?=
 =?utf-8?B?NGpUditGM2VrMmoyL01wZW1JcVBRK21oRjdyQ3dZN2oxTkRIRDhvY2g2Snox?=
 =?utf-8?B?Y0dEalRESDhmNlcvSHFib2dlK3d1UVhaK1ZKQWxGU216WWp2U1dSaWwycU0y?=
 =?utf-8?B?YmI1NjVvbnBHVG8zZ3NzdzM1cWNRdUhOSm1NM2xsUWRSTlNObnJYeWVmY3dP?=
 =?utf-8?B?WkNnT29teE1uTFVsa05Pa0d0SWdic1FJeUxBZjdrLytsZWFZa3ZMcjNTY2Q2?=
 =?utf-8?B?d25hT2tqQTljTE5hekNockhGWUE1L3lnSjk2OXd1SEJPam9NRGFMRmMvcUV6?=
 =?utf-8?B?bUgxenhBVkltTDl1SWxXVGtkM2pBWGVVeklMM2NLbndCOVA2MzVZUWwwS0J3?=
 =?utf-8?B?SVdvRlZ5Y1JPYURRK3Z5NURXbjZGTk5DdEFheXVEOGtmcGlVS1NUMmNHcFgv?=
 =?utf-8?B?bE5mSGxEbEdJb0RZR3RvMkkzQXhaSkFIQkQ2T1hoLzB5bUoxWUlJZGdLR0hw?=
 =?utf-8?B?eWhVdk9Cd0lxUzJkNXoxR1JTUGdPRGp0ZzZ2T2dxRmNjejlOTHJ2Y1FKUExp?=
 =?utf-8?B?TlBkbEV2eksyWHZBTUVzM0RheEd6WWtPalNiREpFSTdKb0k2QnBtWWVhSHJJ?=
 =?utf-8?B?ODd6YU9FT25uMWwwNjRRUGJpc3NnTTdxOUVYdjNBTURVTnZwd0lFSzVVSld6?=
 =?utf-8?B?Yld1TUZpM1ZaRlNpRFRjN1ZXMlpEbTJFVC91RXFBRndpdHcrcWE0eG1xT0xD?=
 =?utf-8?B?RXZSTzh6b1dJTEhJMm1rOFNuSVgxZVhnbEhsZzR2emVMVDlGaFpNRzhjU3M2?=
 =?utf-8?B?b2RpR1FuclpBbUhhTzVkSm1wVlA0WXFOaU5Rc2JVSlFpZzUrSVZPWnNrQk52?=
 =?utf-8?B?RkM0R25zNkloYmcwNmNvVnlUajdYNWJkWUNEUUthWjRabFF0bytiYjZXUEFY?=
 =?utf-8?B?K2xLT29PNGIzSjNRK3VKOWJSQ2xnTTFUQkVjcW1mbFF2a1pnKzdaVkd2c3Bm?=
 =?utf-8?B?L3o2TXQvWSsxUXlCd0R4eXdyVmphMHIwM083aFJ2UldtdUFRNVpFeHFVVkM3?=
 =?utf-8?B?VUdVc0c1SGpaVXBDWHRGbkE4TTZmSUMrWS84N1RVam9nck8yZkt1RmowL2JH?=
 =?utf-8?Q?WLTlBKM7E3wIssqfs7Dt/001xf4GQu2t5qxAA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWNCMkdndDBicEVEQXNSUE9TRzZRSGdweXNBZ2hxelE3Sk5MK1U5TUlhSkdM?=
 =?utf-8?B?MUtVU0FGdElYYklYRUJnZ0RXb3dwUncrY2xUMVpzVjlOT1NsUTV6bytralN4?=
 =?utf-8?B?WEtnYjY3cGR1ZVhtbENRSlVKejBid2xHMDB6K3JrQU93SW1OSituOU5ndTg5?=
 =?utf-8?B?VFIzbFA5UEhTc01yT2hyOUJidXk4Qk9RaXByTFdhODFGMkN0S3N0cU9ac1ln?=
 =?utf-8?B?bEh5WTE1cHdTZXhYVzRhRk02Z2gzMXZ2Ym02dGtrN0ZDYnVraHBpR1RjdEth?=
 =?utf-8?B?aG5WTEthV0pOR2ZLU3M3aVJkZlh5TjBPVXh3cThldFJJcVJONEZCSm11M2lD?=
 =?utf-8?B?NHd1WC9Sd3VrbHAxQWI4UmJNY0lkUlFoMGFKYWJHcGM5ajhwcE95T0JwZkNI?=
 =?utf-8?B?aXVDRFZHakx6VnQyWnh1NW5HVkZIZzVzUDJxZXZONmZyaFovZTFpZ3RlYXZH?=
 =?utf-8?B?aDZMUVJtU3FNOURRM2llQVJ2TUhja3pRMSthcUZIQXpmZnNONC9ZUzZUc2J5?=
 =?utf-8?B?VDdGS2wvU1ROUjRvYjNhYzRBQ2UyQklXbzRsTHpkTE53QzBBZ0tnNlQxbWZS?=
 =?utf-8?B?ay83MEVEYzNLeENpZzZZNDl4RW5DTVBoNkRzcXFhaWhCeHJ4eDJ0SUluRnJa?=
 =?utf-8?B?ZjJMbmNlc01nZkpEenZxM1VxWVNHcnpTbWpQUlRkN3NwbUQxaHBJRFRqQ0V3?=
 =?utf-8?B?VVA5UXBIbEhSVVFrblJSOGJ2TE9pZTZnTGo4Vm41dHp6U2t6RWxBTHhJQ21m?=
 =?utf-8?B?WXVOR1dzWmFFaDBIRnBTdjNGUkVEa0pKYTQraFE4bWFEN3Z2ZFF2YXFrWkFL?=
 =?utf-8?B?dWNQa0hIV3JkeUxiU05zbVNaWk10WmNJZjFmcVV0RzdlWXJsMXlOWkJudDg5?=
 =?utf-8?B?eVR1UVBxRVBibUpqeVhVRE1xVkJBb0hFVXdYQTkwREJOczY3MW1uaGFieEVj?=
 =?utf-8?B?K1F2ZG40MFdsS2R2anRJaGd2ZGlDdFF4VmVqMWZUV2FvVDlsRXV6UWp3dmRy?=
 =?utf-8?B?VGV3ZTloVS8ramdIYjM2QTVwOWw2TkozNlI0cm84MnR6K0xoaklEVGRUK3Jx?=
 =?utf-8?B?U0FCR1AxOTVENG10M0ZVZWZSZHgzQjJqTU9na3duMXhKdG9KRkYrWnhJaUJ6?=
 =?utf-8?B?WVZpendSdkZmNmtWR1h0azgxbmhQN2R4Z01vT284QkYyRy92ZkkxN2xrYTlV?=
 =?utf-8?B?YldvUHVZL1I0LzhaQmRtR3p0M05YL0kzeWt3bDJkVWdCd3ZYR3JvRTEyNFkx?=
 =?utf-8?B?bzViZ3puSTQzYjFzb1JDWGdWb1Z4ZW5qYUkzWHBFeUVYNkxucmFpVjVtcmVB?=
 =?utf-8?B?RFBIMmRHWmZyTi9SV25OUDUzNTVCSXhybG0vaU1WVDE2d001UkVVT3phcUZ2?=
 =?utf-8?B?Zk1KVmhQV1BBSkE3WlZXTlZGK2p5SmY3T0NxdWF4RE5IbG1RZERudVBzYXI0?=
 =?utf-8?B?TUJoRmJZZWlvcFpyZU91QjVqNE0wamZ5SWJWRkd4ZlgzMHNoOXZrS2NuYjd3?=
 =?utf-8?B?aHRyWDAreE9hZk5yS2ppaU9oZlllcldJKzhGd3dsemljNXlZaGxPeThUU1lB?=
 =?utf-8?B?T0NHWXRDNkZKTXdPS2FGMitCWHVtRnRYMEJ3VzlUUnBldUkvditiTmVDK2ox?=
 =?utf-8?B?NTNTODZLdjBpREFPc3hyMCszai9kKy9hMURua1QzWlYxUE91eTBXd1ZMVmRr?=
 =?utf-8?B?WVRsNEh0clpDSE9aaDBpTGNXTWp6amVNT2dzbG1tWjljNlVyWk1Kbno4bXZ5?=
 =?utf-8?B?ZXhacjdBa2pKbi9Ec3Z3ZkUwdTFxWHJQTnBMcXdFWEhKRWdZVlkzS0xBRVVj?=
 =?utf-8?B?aHZXdS9vTHcxUmQxeFl5RUc1aWJTNXJQcmh1Q2puRGVlanlNNlIwenNpNFZa?=
 =?utf-8?B?elpKN3M5ektNSHc2TGZYK2xWMFdqYjdNbGxJaFZ0bm9NdVlEbUdiQmVtRG5F?=
 =?utf-8?B?dFd6Z2VWakIwQkthZnFBQ0luc3Q3TVhXeEFjaHU3ZWZEVm5USGx5QktPSTRF?=
 =?utf-8?B?Ukx3VzBoVTR6cnExNDlyUFZrbVYxMkw5VVRHTUErZFcvM3FuOERRVXRQSEx0?=
 =?utf-8?B?djZhdklIOFVqSkxoaEVYUnNRUnVLVkdXQWJvbGRnbDJ6ckRDUVZuL1lOcFhL?=
 =?utf-8?Q?zyU5l8BjdOfxvl7L+V/itkMZR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c58a4f81-d2c5-4e9d-b4b8-08dc965a6fd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 03:37:14.7139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FOKYm5lvOvdY7Uks0fgxz68mNIdg1ZKCeBDWqHvJg63f8Jf7o9JsEDCj3abInaooN2Zx4ktls6FqXzStaRvFBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7561

PiANCj4gT24gNi8yMS8yMDI0IDEwOjUxIEFNLCBEYXZpZCBMaW4gd3JvdGU6DQo+IC4uLg0KPiA+
ICsNCj4gPiArLyogVGhpcyBmdW5jdGlvbiB1bnJlZ2lzdGVycyB0aGUgU0RJTyBkZXZpY2UuDQo+
ID4gKyAqDQo+ID4gKyAqIFRoZSBTRElPIElSUSBpcyByZWxlYXNlZCwgdGhlIGZ1bmN0aW9uIGlz
IGRpc2FibGVkIGFuZCBkcml2ZXINCj4gPiArICogZGF0YSBpcyBzZXQgdG8gbnVsbC4NCj4gPiAr
ICovDQo+ID4gK3N0YXRpYyB2b2lkDQo+ID4gK254cHdpZmlfdW5yZWdpc3Rlcl9kZXYoc3RydWN0
IG54cHdpZmlfYWRhcHRlciAqYWRhcHRlcikgew0KPiA+ICsgICAgIHN0cnVjdCBzZGlvX21tY19j
YXJkICpjYXJkID0gYWRhcHRlci0+Y2FyZDsNCj4gPiArDQo+ID4gKyAgICAgaWYgKGFkYXB0ZXIt
PmNhcmQpIHsNCj4gPiArICAgICAgICAgICAgIGNhcmQtPmFkYXB0ZXIgPSBOVUxMOw0KPiA+ICsg
ICAgICAgICAgICAgc2Rpb19jbGFpbV9ob3N0KGNhcmQtPmZ1bmMpOw0KPiA+ICsgICAgICAgICAg
ICAgc2Rpb19kaXNhYmxlX2Z1bmMoY2FyZC0+ZnVuYyk7DQo+ID4gKyAgICAgICAgICAgICBzZGlv
X3JlbGVhc2VfaG9zdChjYXJkLT5mdW5jKTsNCj4gPiArICAgICB9DQo+ID4gK30NCj4gDQo+IE1p
c3NpbmcgY2FsbCB0byBzZGlvX3JlbGVhc2VfaXJxKCkgPw0KPiANCj4gTWljaGFlbC4NCg0Kc2Rp
b19yZWxlYXNlX2lycSgpIGlzIGNhbGxlZCBieSBueHB3aWZpX3NkaW9fZGlzYWJsZV9ob3N0X2lu
dCgpLg0KDQpEYXZpZA0K

