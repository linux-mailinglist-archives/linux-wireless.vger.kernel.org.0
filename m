Return-Path: <linux-wireless+bounces-11847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE0195CE3D
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 15:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0967B24BFB
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 13:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A98187870;
	Fri, 23 Aug 2024 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="CgCQNedp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2080.outbound.protection.outlook.com [40.107.241.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3F7188582
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724420577; cv=fail; b=pGp6TSJ+0tInYhePij2tchnSdyijUMxR8Jjf/08QSpQVLD4sZ6w7Hqr1CaOwnBKp1Y/Cauudkw8Qnhe6Y5YY7k0J8LNyvLmcvx6Y+DmI6CkohO4Xj9sTM6yjVByKBFuQ5/eg82w35av6iMRqGQ43FpmhqL7530/TWAEb4BZ8oQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724420577; c=relaxed/simple;
	bh=r1kW33fvCwVq4SuicFfZJx0FLuojKW5Le3pPQ3KsUZg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rsP/lbQA7zqsn/4/XrUwFb8SXxI1gu+Sgm52kDPWTcW2xJqS1FQQimwxV4ciyOSk3y5yK1JtnG4llHTTrVUZYCHbbIpo/c5U7UB1L4Vqf+2+dYg/R3AucbSzLA392Dq7wYRkccJ7b3+yvs7mFqRD8VbIyFWyaoFD5nyt7pMX2uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=CgCQNedp; arc=fail smtp.client-ip=40.107.241.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIrD2G5rMqu2y4xvFCUsHOdbbskpScbnVEz+U9xOXRBfUnSNQE0Nm28YWL+x/GeLAaRYv/OcR8opTImFV0lQ9Bc4gf4iuDDNr9vmTDxab0hZNS22kJLI6wEzyv1yd7D5BzmQZhrxMUtlRYk/tWoEbrOeIPgvVA1IUOA1nEM/mAqJJCWMXDPkUx5w5styAp2WhbRgfsNLsjbNBznvchPypC1ezmG+/qQWxM5v+tFRWxuXawtTA7w6h4W18Sqmio/jqC8rVJZf+BM2qhAzPBrZ9G9a/uyO2hejee3ob2qAF8jb+LDD1VrLM4pgEp1ScyPbFXCNzlpDpHYxCHh86h6Jrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1kW33fvCwVq4SuicFfZJx0FLuojKW5Le3pPQ3KsUZg=;
 b=jUZ85iSzg+XByofeONCv2BmABbQkBqFBDD8DmM3o0ori0dFAcDDrZBA+bp25Bc+IWuBR8Ut311zzmpXIakyOfePRUtNdnLxOJGR87L/MMA54rZV6jO+3LQ/d3OAe+UhRJMgInGNU2LjxvjpklRIq6KsF6n9+FdQe1gZ7CWdEB5kAPgrizP7vte26Tv+Rz2GmLSIRWRCDG9BWD5xXvh+9giq2RfesZ8gIqDTtXa6KziYmVUUqZuZyVwMsQ20l/h81hZGqQA2JieZEQGJ8nup9y0aobwVcx9yssw9mLXpqRzGJlYGXlxkqWWUozLgeuG9Du5fNDvskTiqyuVYTcFu+Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1kW33fvCwVq4SuicFfZJx0FLuojKW5Le3pPQ3KsUZg=;
 b=CgCQNedpDAPxII0fDm08eUNo4+TliDcEhpiL+7LQOeDqa+myqQt+4ONYSrcdQ3DomnugkLb9Z6jAjAGtOO9DlDP/MUtJCO/AtVlHe8OicAKnFTuy8waKEDcSbN8lkQZ+cY/ZLvVAynJiEVT+U0rUrHVpjEEsTAsNb+jlBjJr8M9e/AP9d1REROcfTsTASfMIEidg7XJoEfCk6tzPRMNd4dQERcHpOcFfBtkH9LnVMVdZ78zTvVnDUlHRdgsDTXJwiMsheE/J4EmQgUeTvq4os6e4ux7Al8V8JrtlVgZOg8UsBu1d4auvM5+5AoCAYoXRNbJOga0uOh+2wpJ7zFcmlw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB9PR10MB8144.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 13:42:52 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7875.023; Fri, 23 Aug 2024
 13:42:51 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "kvalo@kernel.org" <kvalo@kernel.org>
Subject: Re: [PATCH] wifi: wfx: repair open network AP mode
Thread-Topic: [PATCH] wifi: wfx: repair open network AP mode
Thread-Index: AQHa9V6F2AsytMDZyUaSKfiA10tTFrI02fMA
Date: Fri, 23 Aug 2024 13:42:51 +0000
Message-ID: <1926e71dfbe3fd4735db59879211e9d319ea9ddd.camel@siemens.com>
References: <20240823131521.3309073-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20240823131521.3309073-1-alexander.sverdlin@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB9PR10MB8144:EE_
x-ms-office365-filtering-correlation-id: 618b33c7-f0a1-4907-eb8a-08dcc3797bff
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SU1VN0pJdzVOTThEQlhXL3IvTlNEWTZIQmFDdW40RUhEZmpkT09KSEV3NDYv?=
 =?utf-8?B?djE0cmVMSVQydFpYc0pNbDRjU08vSGt3a0p3L1ZVL2hUVVdmZ3Q4YkVpZzhu?=
 =?utf-8?B?MFIrbUdEdjVsZVdPSCs5VDJwc0lldWNPUHEzajAvemIzRjNnMkJ1cHdIeUFL?=
 =?utf-8?B?Nm5KeitvbVVkVHdQSTVMaEtRNGtSYzh5VFpuSVVDQ1FKU01SQWJnc2tPZXBk?=
 =?utf-8?B?L0owWDN5dzE4WFpmNk1lY0hQTGV6VW1GczFIS3A3UkcraU5sMnFCdDNuSHIw?=
 =?utf-8?B?VklKRFZsb0x2WTVBL2VLNFpkeXlIcXRzN2hyeDQ1Wm5Ca0F4UUpqeHUvUHBa?=
 =?utf-8?B?YVFZSTJxR1hiU0JqY3pVRDNRRW1rTTBjUVZveHZpY3lWTlgyN1RZaHhBb3do?=
 =?utf-8?B?ZDI4YmxITVhtbDlsb1lGY0w2Y3B2MzIwS0RTSG81a3l2VDhGWWZ5OFl0UWJi?=
 =?utf-8?B?eUloRFJ1S0l1cVcrQ0dQdVJaNnBRaE1ON3djaTViMEVYcENOOGFocytXUTJs?=
 =?utf-8?B?V1ZsSlprSU9SUy9ETnliR2lsbGswZVVNY1BqV2ZnM2RQNnZscnJoNHE5blJD?=
 =?utf-8?B?REt5WlFaRitkNU5zT3JvSEE4NElidTJkVUVFTkdFRWRFUW5VREE0Vm9wSmps?=
 =?utf-8?B?RHIvaGZoNVhSTW85NUcwZGlsMUtRd2YvSnRVcWpUcW9sc2Q5WjdiMTJpd2o1?=
 =?utf-8?B?bldreWJvdW42S2dPamVtQms4UHBCOXBsemtEbncrZEdtRk0xd3pzMS9CczZN?=
 =?utf-8?B?TFlXTTVPMFJuNTE4dHUyVnBITzhCa0dpcUdidGZxc1NwM3kzSExzK0xrTlpq?=
 =?utf-8?B?ZVE4OEM5S0FiUWplcFZla1VJSW9nSmUxYUhMeUpXZkZZZXVPdWRaT1M1MGI2?=
 =?utf-8?B?aXdWdjZwSmxudHErdVZMTno0YUtjU3cyL2N3ODBUVTRUYllKZlJrMjduUlhP?=
 =?utf-8?B?YW1iUWZ4M2xISzdMcDZLTno5RFhhY3BaVVc3cGU5b3A4NmJGditETkQ3WFhi?=
 =?utf-8?B?ZzlMM2tDa0pIZ1R1dWpGTDhVcU1KNksyV1Mxb05JSXhaVGdIRHN4VjQ0V1Fs?=
 =?utf-8?B?SnFwa2xJWUt3bVdmUld2dStGbWN1M3FDdHlUYkd6WFNmSkdDd2VTWVR5cGli?=
 =?utf-8?B?cHRTS3J6K1JsQjNET0VJWkRSTHYvU08xWWcwSHBQNVBWV1V5NTNwMkFYVEJh?=
 =?utf-8?B?Zzh0cFZqOERBZ3Qydm5lYkhYWUJrRkJXMEFMRFNVbGxZNzdLQUdrK2tMNkJY?=
 =?utf-8?B?OHdRWlpyRlcvLzRqK1U4Y0lXakloT2JabkNLVXdHVUU1M2VHWmw1UE5Bbm9O?=
 =?utf-8?B?NEMyZGcyL09HakU1YmZ4SkdtNUUyeFk0ZDNtL3Rib1dVRnlsV3FmcXUrZkw5?=
 =?utf-8?B?MGdZb09RT1JvOEc2a3puYVhXSTB2blg0ckNOalFXb2E0L2ZSKy90dDRPUDlv?=
 =?utf-8?B?WEpxRWJzaS8vYk1KZmFONlVQWElmL0diM1RHbG9MaWl0elhBNHg0Y0pZL3VY?=
 =?utf-8?B?anFGVXA1L3RFSDdpZEVsazNaU0V6czFET3Fua0hmMFlkdXFiWjlqcFdmTEw2?=
 =?utf-8?B?RDdEckRscjVWVnJiYitYRy8wenFDY2JkV2orWVczZzNCVkdmVnVESC9Jb2VO?=
 =?utf-8?B?cWl6STJmWGZkZml3RjgwdXoxeGRJZTg2ZlkxM1JFcE9BR2lwK0VhSlVnWk9q?=
 =?utf-8?B?TTluWXNKTEZrSTdZVjlHYWVXRkRjV0VJSnVOeXE1ODBEU2liN3l6K3lrZ0Rl?=
 =?utf-8?B?ZHlxZU5BUGNDQ3dxaUVIRURmTFpvL0QwWk1Ea1Jad3VkSzNpc3VKYzNiZmZG?=
 =?utf-8?B?WFNZWFFYRlVTZnNUS1QyUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eW9vbkg1NlRtV0tTV3BWeHlDRHdpTVNFYjlhYlRvR2hkV3JzWENLZlBMSlVU?=
 =?utf-8?B?c0tCUUdsYnZsTUVBdXNYUjNFY2czTndDWFFxUTUxS1lFQmsxd1MvRDZZLzRm?=
 =?utf-8?B?ME8wS1B5NVV4d1poM2tJK3FXNzBNU3BDOXBjMFJEMFE0SE9wL290dTFteU1i?=
 =?utf-8?B?OEYwcldTMkswWHJUYkFtVVdBVHg3YUR4QUhHMlJ6RCsxaVpyZi9NTFp0S2Z5?=
 =?utf-8?B?cmpxdUwyY0NacVVoaFNEWnpzU0NoVUMwcUhmYlgySU9KZTlNUWFsVit1d0tW?=
 =?utf-8?B?ZzdjV3ViV3cwMjlCS2p5eDlFeGVBSTVrb0dsaXdrL2t0L0R3Y2JYMFVaQkJN?=
 =?utf-8?B?NzQvWVdqVVpsdkdHTCtxVWk3ejNnRVVpODY1TWs1a0pMTU9Jb085OVVTajdW?=
 =?utf-8?B?aW9peVlFRDQ3Yjc5dzJnVk5UL1RYZGV3cHZlY25EdElvaWxtRDRjek00cmhN?=
 =?utf-8?B?WS9MUUE3TUd6dng1L21aSm4rOGJXZzR0N01Ec1ZneEtKYmtoNFJXcmhoRytI?=
 =?utf-8?B?SnFQMkRITUtFdzVSZTZSTzFXeHl5cEtVcmtNWnl4cFcxWW5va25LcmlVUjc0?=
 =?utf-8?B?bHZhK3o4M2l2WnVoYjlpN1ZVSnc1TmFQWjVrcnViSktkY3VXckphY2hMdWN6?=
 =?utf-8?B?cUloMmRvOENnenVnV1MzcE9TRUJEWjRVei9ScThVYStHUE5WSFRxZk9MUFJG?=
 =?utf-8?B?R244YnhQSnIrRXBuRmdXSjNlUjFPQlJpR2dUazlBTnVrMzJhUTFwYnVla1VR?=
 =?utf-8?B?TWdtd3g0Y1U5WHFveWFYWUdnMnllakdmNXhLdFV0UVdxUjFMbDRQaDlqbWNV?=
 =?utf-8?B?TmlCZVNaQmhnUTVkUW5naU1PNDhYUjZEaVBOWXRIdDJ6SmM1Qk00Z2JqR1Rz?=
 =?utf-8?B?NjNtUmxUWHI4YzVuVzlDUTcxUHVOMVBOaGIxc0RRTnB2V0tmTUNSVHN2Yjcw?=
 =?utf-8?B?YXR4KzFMQ081bUFWOGxKWkFRa0pqSkJVVklsTUkxNUlEMVUrd0xueGFKNXpS?=
 =?utf-8?B?WldsMnFKeisyazdWa3JzTXFLaVNtN0R0eFgzUWdlcWRvVEVsSkNscmtCS3lY?=
 =?utf-8?B?UC9CYnRWbHYyOC9tLzdtY1YwTlZFYm5vNkNXbFJFOTJzS0l6WVBHVTZJcUdo?=
 =?utf-8?B?ajJMVG5Ib3cvR2lKS1JlRDVyRzBzRHRYYWUrV3hMb2lxQWNjV2tBcVVhaWl2?=
 =?utf-8?B?WHV2TUtUU3hhNjhaQVJFeXYybWNZcXdHNVpTYW1leDZlVk9uMFp2R2x1VVNH?=
 =?utf-8?B?dThuR1dJZi9XZlZZeFdnUU1LMHBQMmdwMmdNUjJIVUhIRUZmQW1maWo5N2NY?=
 =?utf-8?B?UmVwdU9vMmVjMm9LeUxoVGMyS0ZRZVRmYUo1RkFXbjJKZUYxbHJoa3Nyb0pw?=
 =?utf-8?B?b0hjYXk2eURkRlJXUkJySkVkaC82THhEOFdES2FaSFk4K1dBRENRakt6Skd4?=
 =?utf-8?B?d0ZrYUNJdUc1alUvRmEvd3hzWTIxMmIrSGQ1eVM4ZjFiYS9IZU0xVlZXUnpi?=
 =?utf-8?B?NjVjUGx1S1RkZXF6ZGh3NS8wT2ZlWDNTU0xkbkp5eUNLSDJnOXlLdGNsMDVZ?=
 =?utf-8?B?RTVnaGtNQndYMENBd01zcmF6U1ZXNEpNWlNpWFB0bEJ1eHhHWFV5RUVUWUxC?=
 =?utf-8?B?bHJzQjVLQ0dzQjhqT0ZwUVlKS2VBRXNMWXNrdWJQTi9WSHR2TE9GOVJYb2c0?=
 =?utf-8?B?Qmx4RC9va1J6bkdGaUZuQm5YWGs0OGRXOGl2NlFmNHJhRjF6cjFWV3d1Q2RL?=
 =?utf-8?B?ek1aNVpvSE9iaTJDSXZoYlNXYjdldWNpbzYrNGovR2F0NWxyNU80bHU5QVJV?=
 =?utf-8?B?L2JlbmhNWHl2dWNnUHJFalRscFFYT1kxWDljRnMrTDkrTlhsN2FQTkxTVkMz?=
 =?utf-8?B?R0RzWEl5WUxVZ0VpT01reVdJcHBVUmRLZENPdndrRlZ6eFhCdjhCYUNtY1p2?=
 =?utf-8?B?ZFJZRm5wUkZGNTd5a2U1ZlRxQ1dQSVRTcUZZYnZKUU13L0RYUXV5ZHlXaWVB?=
 =?utf-8?B?dDh3QWxjS1RrOVlvLzg3N2V3NlcycUtvKzIvOE9vcjhNL1lSYTc1YnNtcm1K?=
 =?utf-8?B?NFJMSlNPNk05bkFJc24vMW5RTUFlZjlzSlBNVitibDhpaVJJT1ViOE0zVjE1?=
 =?utf-8?B?TXUwc2FXQnBMcWMrYm1aQnloV0FkNDR1R3dITWpRcHNHQU1pZmk2RGN1WXRn?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45B17589DE6EF34CBBEC55E7C735EF8C@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 618b33c7-f0a1-4907-eb8a-08dcc3797bff
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 13:42:51.8080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4kwlb43bgPAA431mR0+1rXPvUT9uc43Ns/SUfJSrObzAYI9UuXR3DL++uttgK3nCKHrl8fUzRPd9L/XHySdvHULbtC1UgyLK0fHylxdHpjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8144

SGkhDQoNCk9uIEZyaSwgMjAyNC0wOC0yMyBhdCAxNToxNSArMDIwMCwgQS4gU3ZlcmRsaW4gd3Jv
dGU6DQo+IEZyb206IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1l
bnMuY29tPg0KPiANCj4gUlNOIElFIG1pc3NpbmcgaW4gYmVhY29uIGlzIG5vcm1hbCBpbiBvcGVu
IG5ldHdvcmtzLg0KPiBBdm9pZCByZXR1cm5pbmcgLUVOT0RFViBpbiB0aGlzIGNhc2UuDQoNCk9v
cHMsIHRoaXMgaXMgYSB0eXBvIGFuZCBzaG91bGQgaGF2ZSBiZWVuICItRUlOVkFMIi4NCkknbSBy
ZWFkeSB0byByZXNwaW4gd2l0aCBjb3JyZWN0ZWQgY29tbWl0IG1lc3NhZ2UsIGJ1dA0KSSdtIGFs
c28gT0sgd2l0aCBhIG1haW50YWluZXIgbWFzc2FnaW5nIGl0Lg0KDQo+IA0KPiBTdGVwcyB0byBy
ZXByb2R1Y2U6DQo+IA0KPiAkIGNhdCAvZXRjL3dwYV9zdXBwbGljYW50LmNvbmYNCj4gbmV0d29y
az17DQo+IAlzc2lkPSJ0ZXN0TmV0Ig0KPiAJbW9kZT0yDQo+IAlrZXlfbWdtdD1OT05FDQo+IH0N
Cj4gDQo+ICQgd3BhX3N1cHBsaWNhbnQgLWl3bGFuMCAtYyAvZXRjL3dwYV9zdXBwbGljYW50LmNv
bmYNCj4gbmw4MDIxMTogQmVhY29uIHNldCBmYWlsZWQ6IC0yMiAoSW52YWxpZCBhcmd1bWVudCkN
Cj4gRmFpbGVkIHRvIHNldCBiZWFjb24gcGFyYW1ldGVycw0KPiBJbnRlcmZhY2UgaW5pdGlhbGl6
YXRpb24gZmFpbGVkDQo+IHdsYW4wOiBpbnRlcmZhY2Ugc3RhdGUgVU5JTklUSUFMSVpFRC0+RElT
QUJMRUQNCj4gd2xhbjA6IEFQLURJU0FCTEVEDQo+IHdsYW4wOiBVbmFibGUgdG8gc2V0dXAgaW50
ZXJmYWNlLg0KPiBGYWlsZWQgdG8gaW5pdGlhbGl6ZSBBUCBpbnRlcmZhY2UNCj4gDQo+IEFmdGVy
IHRoZSBjaGFuZ2U6DQo+IA0KPiAkIHdwYV9zdXBwbGljYW50IC1pd2xhbjAgLWMgL2V0Yy93cGFf
c3VwcGxpY2FudC5jb25mDQo+IFN1Y2Nlc3NmdWxseSBpbml0aWFsaXplZCB3cGFfc3VwcGxpY2Fu
dA0KPiB3bGFuMDogaW50ZXJmYWNlIHN0YXRlIFVOSU5JVElBTElaRUQtPkVOQUJMRUQNCj4gd2xh
bjA6IEFQLUVOQUJMRUQNCj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IEZpeGVz
OiBmZTBhNzc3NmQ0ZDEgKCJ3aWZpOiB3Zng6IGZpeCBwb3NzaWJsZSBOVUxMIHBvaW50ZXIgZGVy
ZWZlcmVuY2UgaW4gd2Z4X3NldF9tZnBfYXAoKSIpDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRl
ciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KPiAtLS0NCj4gwqBk
cml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5jIHwgNSArKysrLQ0KPiDCoDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5jIGIvZHJpdmVycy9uZXQv
d2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYw0KPiBpbmRleCAyMTZkNDNjOGJkNmUuLjdjMDQ4MTBk
YmYzZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEu
Yw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5jDQo+IEBAIC0z
NTIsOCArMzUyLDExIEBAIHN0YXRpYyBpbnQgd2Z4X3NldF9tZnBfYXAoc3RydWN0IHdmeF92aWYg
Knd2aWYpDQo+IMKgDQo+IMKgCXB0ciA9ICh1MTYgKiljZmc4MDIxMV9maW5kX2llKFdMQU5fRUlE
X1JTTiwgc2tiLT5kYXRhICsgaWVvZmZzZXQsDQo+IMKgCQkJCcKgwqDCoMKgwqAgc2tiLT5sZW4g
LSBpZW9mZnNldCk7DQo+IC0JaWYgKHVubGlrZWx5KCFwdHIpKQ0KPiArCWlmICghcHRyKSB7DQo+
ICsJCS8qIE5vIFJTTiBJRSBpcyBmaW5lIGluIG9wZW4gbmV0d29ya3MgKi8NCj4gKwkJcmV0ID0g
MDsNCj4gwqAJCWdvdG8gZnJlZV9za2I7DQo+ICsJfQ0KPiDCoA0KPiDCoAlwdHIgKz0gcGFpcndp
c2VfY2lwaGVyX3N1aXRlX2NvdW50X29mZnNldDsNCj4gwqAJaWYgKFdBUk5fT04ocHRyID4gKHUx
NiAqKXNrYl90YWlsX3BvaW50ZXIoc2tiKSkpDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpT
aWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==

