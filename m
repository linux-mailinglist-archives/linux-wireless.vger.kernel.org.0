Return-Path: <linux-wireless+bounces-11799-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE2195B471
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 14:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906A21C22F6F
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 12:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30E61C9EA6;
	Thu, 22 Aug 2024 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ve2Jdk8M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010032.outbound.protection.outlook.com [52.101.69.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0B014A08F;
	Thu, 22 Aug 2024 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328000; cv=fail; b=GcOockmsjtjr+rh+QXsp5zKP9pOtQywXtYOE+EJNGKQTC4Uww2xG3ZZPMFSAxxdS4an1/kbJZJ7IrajOgHmh5qszV0RsMm2o49f8fBOrN4I7R98nO5tlGEerV9xfxD6XYbJRwtaVUre2OW4TDhJtOIBdzi55zsGY1nmlIlZu6gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328000; c=relaxed/simple;
	bh=KTBwd2WBHPjt5+PJTeFbonoG75knfy77+PyaTMCtwiM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L4XZYzzCtvrbGaAFoEl0fG78iqVbJPp6g5wpKIqMwKBwCdYCIdaWAzy4+vus2mP+P275LAA1yxypr+I4hhGK/gEH7U5RHwEPggISYT8F7+2pERS7GZSTV+NoAphDpxMi9UWS5kMR2O2UtEy27nV8oMw49PgxB3ylmuO0cOitnfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ve2Jdk8M; arc=fail smtp.client-ip=52.101.69.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UR/lz/K8Xc8ouT7VFFXCQDrM6jNMWdgrgBLNrbglESn8/6I1vsCqniKHNq+V8in+KnFh2vC3ZfpzN/EcGY327L//T9lZ3lc/xoz1nPxsPvhbWoI8KVWJDwhv435MSl2vZD78Qs5eUakxifAsV2zTrXfNh66cT2pQFz+RC5vTzk28+5O18PIGPDiRVcmz38rbJv2W6kBz2OuLyJSRNEGgajzUbveBwGFgka1hU/9aqaE1TdkMzM2HwEl7VZVKsIirl2LhvRRiyRUaKl1mKli9aZM3ScKKdBTd0pTj3Q6GT2FvM2SL3Qp+XyPxHKjHCbhhS3kjBlWCF3MRk9j6ES/Yjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTBwd2WBHPjt5+PJTeFbonoG75knfy77+PyaTMCtwiM=;
 b=CFELx5bD8WnggWjzVJVuSGiGzIsUmGbypZTumm7LsxkXGF4VhXEnxRxidvLWpjmaFOebON4inj/pPYKw01aAbZufP9EUIHpoOPUPRiZ1TJ0m1krbmWy7kpKqLFA90ZfjCJ2fzVWK6l2hTnt0kp/AJDgY6iMKjFypq8U2M2kXeyU6U1kT1OFUHAglMBVZXyILhKCZR+ar3xA7cwmwyYpZjIWLc9kLA2CYlkZ2Dz37bUUBuXXugkHXktAzn9h8WCLkM1FH+9aJ/8JQuDNMjvCHGTVTap9F/kLkqnI0r/mFwGbxh9w4Q50LyAHpzTw/wuFKx4fmCgqajhxAR9eTUGRngw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTBwd2WBHPjt5+PJTeFbonoG75knfy77+PyaTMCtwiM=;
 b=Ve2Jdk8ML+sJVaBlLT4M8YhnnWga6of1gXg0ZuIjt/JmzC9SaveUGliOChE2IgNa8RtghYesE8ySQ0OUjXitRZ5uoYKU9DAy8oR8axtiFi8526lZev4Y9/LXVeJ8OwF4LLZN5o4MkRcHrCx6YItVxbNNZ5wNOfue9pee31hnWR7clVCEVzagIpkkDPABUKaCoatyCnVYMCV+yLS6LKov0iNzI+wcsfcPfsjYfE9l5rz/H7PrR3CMG6iJ0e1rNszixorwfSV5CG3uNcgaLC6A25jldbs59gDulRTRUOyA2irCWZM+tKtYJ7PS413O4mxUoS+AGlf/HeEQ4IAntGS6gw==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM9PR04MB8161.eurprd04.prod.outlook.com (2603:10a6:20b:3e9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 11:59:56 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 11:59:55 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Sascha Hauer <s.hauer@pengutronix.de>, Brian Norris
	<briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, Kalle
 Valo <kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: RE: [EXT] [PATCH 10/31] wifi: mwifiex: fix indention
Thread-Topic: RE: [EXT] [PATCH 10/31] wifi: mwifiex: fix indention
Thread-Index: AQHa8vjaVhal52qkKUSAi5YxIXRvnLIzBf+wgAAGUoCAACLh8A==
Date: Thu, 22 Aug 2024 11:59:55 +0000
Message-ID:
 <PA4PR04MB9638C8D68F0F71C17E903DDAD18F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
 <20240820-mwifiex-cleanup-v1-10-320d8de4a4b7@pengutronix.de>
 <PA4PR04MB96382C0635603A51371C0E23D18F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <20240822-gay-myrtle-tarantula-bae0e0-mkl@pengutronix.de>
In-Reply-To: <20240822-gay-myrtle-tarantula-bae0e0-mkl@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM9PR04MB8161:EE_
x-ms-office365-filtering-correlation-id: e54aee1a-ac91-4655-68fe-08dcc2a1f023
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L05DQlRWNXlUUXpxVDBpTjdyTkgxWFNnYVdRTWppZS9STEN6LytjbE84K3JZ?=
 =?utf-8?B?VzdCaUo1NnhxV3YvdHQxWFdLZGRwV3JDTGFlRWdBUmozT2xUeFZONjY5ZVVW?=
 =?utf-8?B?bmxkcGNsN2laWU9tdGlNb09wNlEvbG1PdWtJUlU2ZC9SUC9tbWVPOHRRQkw5?=
 =?utf-8?B?VVRFSmdjMDJCMW5tOVM4MGZRcGovUUVXTlhTYzR4akxBdUZMY3pUSHR2VTBw?=
 =?utf-8?B?Tmg1MXBIVEJwZDlWS3JJN1c0KzJoTFNabFBhM2ZKdmNtS0hRdG45QTRUd291?=
 =?utf-8?B?Uyt1aXo1WXhUb291UXNTYXoyTWlDWVZadE9QZm03V25OckE4U051aXQ3ZkNJ?=
 =?utf-8?B?aWhlWXlNTWovVGFiMmZZM0ZRNGVtcUdJMDVubTNsZWxSMjBWQjVYOEVRL2Nm?=
 =?utf-8?B?NnA0a0pLcE0yMVNuZGQwV0JZblhvUDlUSEtZdG52WEU5alR2cGtveTIzN3pt?=
 =?utf-8?B?SlNvREhweGZkN0NQNDV1OUNtM21wVkY5RzVqUXo0VTVxNGlxYVdEK0lhTW5t?=
 =?utf-8?B?ZGZhZUxtcjJhQ1FiTnhSMjNsVWE0TURRUVRodUVxUGo0ZDRSWEVpcXhhNFlV?=
 =?utf-8?B?b3BpWVBycXJ2RkJ5Vzd3dmtGSy9ZTWxLd3R1NGVlOGdIZTVURkpYN05LcER6?=
 =?utf-8?B?YVhsTXZUenkrc1k2RnZiSnF4OFpLUzloSXNsQk1BaGlFcnN4STA1SjJGbzFn?=
 =?utf-8?B?UDI0cUI0eUtuQldFeGZQdkg3NjYvcFhINjFadWxWdWl6M1k0ZlRZK29KVEg1?=
 =?utf-8?B?NmQxNTVRS2pBMHJXYUJORUJycVQvQytEUVRvOEFoNzRvNGgrdXNGa1dQVm9M?=
 =?utf-8?B?R0t5b3ZSSWhEbno4VzFQQVQvN1BtV0tYODhBenhFWFByWTJwYVM0VmRLWVMz?=
 =?utf-8?B?eExheG9VdlIwMWo0ZC9jY1YvelByWjRPVGkyS0xOTVQ0aGI5LzRjeExCc2ZC?=
 =?utf-8?B?N3VMMjJQaEljTmZHaFpTbUk2dGdhUzd0MVpGZFI1WmttK2d6ekZGZUF4VU8w?=
 =?utf-8?B?MzVCZlRIM2ZYTDNyLy80bXhXK0hraFFieEpPVnVoTE0vTVdCVnJBb21LUHJC?=
 =?utf-8?B?Z1lENnFUN3A5NlNkN0tqQUxOd3ZRd0txQXAzR2N4YSttdXJvKzAyWmk5b0to?=
 =?utf-8?B?UDFPZFVXa0l1OGRjZ1VXWDNiQ2lqdzFxODlEYzd5NkM2K0xjMy9XWVVVbExG?=
 =?utf-8?B?RXBGRjlKT2owd1NraDJrRDlEYzNCaEpJL2lRTlJrM2JTWTNmZG9iQW1kUFFv?=
 =?utf-8?B?Rk4xbk94Q2lHWDJKV1dBSGVZdUtKZGVuVVNXVkFwMXBhZ1IzbDJ2VjY1T0xm?=
 =?utf-8?B?U3J1WHZoZ2NlbnBWTkhKL0dYRGhyYURPMnZVanp2QmZmTk1lN0ljM0R3ZjAw?=
 =?utf-8?B?anNJOU5SZ2RxU1ZDZ2NpNlFOL25FV3l2d0FFRFdQcFdabDQwbVViMVpsYnlO?=
 =?utf-8?B?SXpnRE81VlFvUkZvTHQ5MWJrakRBTmNTK2k5NUI2ampmSUJmc0dGSmp5Wnhr?=
 =?utf-8?B?Y3FTUmNQb0pmVmNoTGJuUGZhUW5PQitURzJHYUVqbVRaTjE3WkNzNjNIYll6?=
 =?utf-8?B?RWtjcWd4Zmg1Njh4UDd4eGFGS3VDU0NPeXgyUlk1ZnRWTlB2T3BrUHgyQmRM?=
 =?utf-8?B?VzJ1bG5NdUQyVWxGNllVbnFhY3F5Y1dablJuUUdIM3RIdEdqblZ6YS80QUF1?=
 =?utf-8?B?MGxwY3VyTzNCTDNTNXpsZzg2Z2piUjJ5UEZidGorV1U2QWRvNjBrazFOaTRW?=
 =?utf-8?B?SnJBMnFucE11RTBpVCsrdDZhbDZXZWE2dE9UWCtPa3lGMUZsUFp2SXM1czJa?=
 =?utf-8?Q?MOkF4MPnwiatEnS/QJlgof5fSNIrzkezid+yQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2wrRDRKTVBYLytPVnEwNkNYMmJLTWlxU2ozTUc3L2dUWUFGK0ZRL1JJYjQ0?=
 =?utf-8?B?SzEvU0NjVGkxOS92L3JQUFJ2YWpSaVh2WGgreVlDL2ZsT0dBd1Y4cjNwdHJj?=
 =?utf-8?B?b0U0TnRVWmNUNFZacTRId3NsdHE1bEdqN3lQNm13Nmdpd3N5OXBRTW9OYnY2?=
 =?utf-8?B?NDZwOUZ3Rmo4blIxYVVpZ2Y3MVUvSnVuVFZEdzJBMzZtQjJna0MzeGdZWk1y?=
 =?utf-8?B?Yjc4Y1BLamxHWmIvSGFNWnBDTEwxeEFmRGo5Ti9pNnk0cE9BUWtnK0pTL0Ru?=
 =?utf-8?B?c2s1N0R3alRQSE9RSEJMUUpTdWNHZWd0MTJWdVBQa2NqY0Z2b1gxTzE0TExQ?=
 =?utf-8?B?UFFIZGpNMmhQblpPYUw3L0RqWXhKUGhpNTI5MzRJelNuVzVmK0FiU09zYkVJ?=
 =?utf-8?B?ODArMkhsOXJySEFBWVJINGlSbEdOSzZia3R2VVdEYUJHc2RXMldqL3J5SUwz?=
 =?utf-8?B?TTB5SExDSWx4cEZIZnpKenROQkkrZG9YUzV0RmlxbEVBV3crVEtKeDF4ZEZL?=
 =?utf-8?B?bWliVHpUcldjcEpnVVl4dk5tYW1qVk01OVlxQkVlQlhESUtxQ05LWjRRaEVG?=
 =?utf-8?B?a3MzOWdSdXo0STc4Z3B0Nmcvbi9KTlJUNW1FaXdoc2k2b1IreFVjbHVTQ3hO?=
 =?utf-8?B?UEhFOVJpSW5RNW93UTNwTUY0VTBIR0JxTnhZdlhVMWpmajR0UCtEckFWWE5h?=
 =?utf-8?B?QndtMGh4Yk5qamVQbWZGV2lTSkR0ek5abExpNEU1TVdBYjk5K25vMmpEMTJQ?=
 =?utf-8?B?T2gwN2xJcGlxd0kwcnhJQmFVRm9Oa0RZR29oT2JmQmVQTFhORThWWndFTEFs?=
 =?utf-8?B?Y2dySW1MbUJZYlA5aTZnSkZOZDRZdWxCSy91c3FRd3pLMVp4VWFRQ3RwZTI1?=
 =?utf-8?B?SmRJVVFnL1pyajZ4UXIrWmVCU0NKWGp2WGdKamZDYXhqK2h3cWcwTzNSYXQy?=
 =?utf-8?B?NjVMVExiWjBhMEdsSTZjN1pOMWFER3A2eStUSU5nS2MwVzVQekZ2NHpadHBz?=
 =?utf-8?B?ZDQvSWp6cFVuNWE2SmxGUnBVS3ErdlNMMnNxYllVWStka2diTCtnRVlabGlW?=
 =?utf-8?B?QTNOemZUbXlmV3hFNXVocHQyN090TnhxSUVKckNDNkFTOEVOSlZNdzRIVXpw?=
 =?utf-8?B?dGR6Z2ZGKy9JUnRmRGVSZUp0Z2VSdDFId25EYWpoemNIZ2FjTUMwOEtrUFUr?=
 =?utf-8?B?VDMrU3JKL21TVkdaZ0prd3JWVEtJZEliSVUweVpnWHVkNU9veURtK2VCLzJz?=
 =?utf-8?B?b0doelJvdjZBR3VMaTZ2UjAzc2htRTVKVHN5UlFtVFNMQ1ZrUWpHTUFNV0tp?=
 =?utf-8?B?eUUveGZKaUxSSEEya2FvTzdvVFNML1dMN2NseVdjL1Jkem93V0JmQ0g2YzJv?=
 =?utf-8?B?OFpRdytLT3hnY1VoUVhtR3pvWlZYWkdaSUU0QkNtWnB2QURoYXV5aE83SjU4?=
 =?utf-8?B?NHA5TmRzVWlJZ01nMERGcktGUnRLTlJJZmk1VTl5cEdIV29GZG9vRitRNFpD?=
 =?utf-8?B?eGs5bjZzOTdOQzB2ZXFLT1NuTTlPNEFNWVRoTUJqMjFjanVodU1yVkNnTE42?=
 =?utf-8?B?K0srQkZ4TXArQmExTlpCVVNkUmtJNUhEVkliNitUdnQ2T2I3QlBXMmRhclBj?=
 =?utf-8?B?dzVYMy9RY1VmcnloMEErNlpVUzJEcWZGUWRJWVAwQlhBL3RQMUFxWU56Si9S?=
 =?utf-8?B?MFpDeVpQU2E5S2s4ZkhiWllGSkpvSDJlV0pjbkxOOW5WSDY2WlZPL0FhYTBT?=
 =?utf-8?B?WHVpRFc3WnU2aWlZay84RStLVUVpaG1zNUVxVUVnT2FJNVVXb0k2YjZxanFs?=
 =?utf-8?B?OFdrQnY3MW85U1RVVEVlVEZjelN6SVVCQk42U0JjL1ExbEg5Ukh2UUxhUEt5?=
 =?utf-8?B?VU5WRTNNV1Bjek0wdCtEMG5lSlBJWUxGN25TYkZOQVJXSGhjMEd6dnJXWnNz?=
 =?utf-8?B?TzUxWFlWOURtV045aWlmVnNoQW9EeU9Sc04zcG5LODdyRnN2OVpleWZLUGxX?=
 =?utf-8?B?d2NDUy92TFVQSTNldDlFbi9XNk9mMHZaZWozL2RtY1FKdGVPWFdBQ1dnQ0pR?=
 =?utf-8?B?WUNJTVhJaGJTUnlJMzRELytiQzdMTEFGUHVySUdrWU9ic2lUdWhlSlAzZGNa?=
 =?utf-8?Q?eB3ZfaeJ1XGFZR4MG2TTY/Ld+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e54aee1a-ac91-4655-68fe-08dcc2a1f023
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 11:59:55.3615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tvQQ3HWQaQcc76/FEeN9caRDxzc8U1WxvFZYIdbRFNB0t+l2zpSYRYWN8BOwSc3eCl+6A4caH0PsGbGgEjhQ7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8161

PiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiBU
aHVyc2RheSwgQXVndXN0IDIyLCAyMDI0IDU6NTMgUE0NCj4gVG86IERhdmlkIExpbiA8eXUtaGFv
LmxpbkBueHAuY29tPg0KPiBDYzogU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRl
PjsgQnJpYW4gTm9ycmlzDQo+IDxicmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc+OyBGcmFuY2VzY28g
RG9sY2luaSA8ZnJhbmNlc2NvQGRvbGNpbmkuaXQ+Ow0KPiBLYWxsZSBWYWxvIDxrdmFsb0BrZXJu
ZWwub3JnPjsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGUNCj4gU3ViamVjdDogUmU6IFJF
OiBbRVhUXSBbUEFUQ0ggMTAvMzFdIHdpZmk6IG13aWZpZXg6IGZpeCBpbmRlbnRpb24NCj4gDQo+
IE9uIDIyLjA4LjIwMjQgMDk6MzY6MjksIERhdmlkIExpbiB3cm90ZToNCj4gPiBJIHdvbmRlciB3
ZSBzdGlsbCBuZWVkIHBhdGNoIGZvciBpbmRlbnQgaXNzdWUgaGVyZT8gSWYgc28gSSBhbSBzdXJl
IHdlDQo+ID4gd2lsbCBuZWVkIGEgYnVuY2ggb2Ygc2ltaWxhciBwYXRjaGVzIHdoaWNoIEkgZG9u
J3QgdGhpbmsgcmVhbGx5IGhlbHANCj4gPiBpbXByb3ZlIG13aWZpZXggcXVhbGl0eQ0KPiANCj4g
bXdpZmlleCBpcyB0aGUgYmVzdCBtYWlubGluZSBkcml2ZXIgd2UgaGF2ZSBmb3IgdGhlc2UgZGV2
aWNlcy4NCj4gDQoNClllcywgd2Ugd2lsbCBjb250aW51ZSB0byBmaXggYnVncyBvZiBtd2lmaWV4
IGp1c3QgbGlrZSB3ZSBhZGRlZCB0aGUgV1BBMyBzdXBwb3J0IGZvciBpdC4NCg0KPiA+IEFjdHVh
bGx5IGluIGl0cyBzdWNjZXNzb3IgTnhwd2lmaSAoY3VycmVudGx5IHVuZGVyIHJldmlldyksIHdl
IGhhdmUNCj4gPiBjbGVhbmVkIHVwIGFsbCBpbmRlbnQsIGFuZCBjaGVja3BhdGNoIGVycm9ycy93
YXJuaW5ncy9jaGVja3MuDQo+IA0KPiBQdWJsaWMgcmV2aWV3Pw0KPiANCg0KTnhwd2lmaSBwYXRj
aCB2MiBoYWQgYmVlbiBzdWJtaXR0ZWQgcmVjZW50bHkuDQoNCj4gcmVnYXJkcywNCj4gTWFyYw0K
PiANCj4gLS0NCj4gUGVuZ3V0cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgfCBNYXJjIEtsZWlu
ZS1CdWRkZSAgICAgICAgICB8DQo+IEVtYmVkZGVkIExpbnV4ICAgICAgICAgICAgICAgICAgIHwg
aHR0cHM6Ly93d3cucGVuZ3V0cm9uaXguZGUgfA0KPiBWZXJ0cmV0dW5nIE7DvHJuYmVyZyAgICAg
ICAgICAgICAgfCBQaG9uZTogKzQ5LTUxMjEtMjA2OTE3LTEyOSB8DQo+IEFtdHNnZXJpY2h0IEhp
bGRlc2hlaW0sIEhSQSAyNjg2IHwgRmF4OiAgICs0OS01MTIxLTIwNjkxNy05ICAgfA0K

