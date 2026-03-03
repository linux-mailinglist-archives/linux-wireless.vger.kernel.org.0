Return-Path: <linux-wireless+bounces-32382-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF64AZiOpmnxRAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32382-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 08:32:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AE31EA331
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 08:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C6E130CF735
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 07:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169D339098E;
	Tue,  3 Mar 2026 07:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LxOiZran"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62C132E126
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 07:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522942; cv=fail; b=Eztndocm9iQTFrAmV0NlaLi69AVRpKciBpdzvtlRmWprCMFTGQEW+unLkBswasKRV5v1e6+jvwqe+9su5buGhkeVJCRlBjas5WU573+2ArLUT4xE3G7fR05LnXVGn+th/hcikorKm/dcymdfiVlxX2M8B1bXV49ue8V9+t4+8Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522942; c=relaxed/simple;
	bh=Mpy4kLfgojPN6iF7EOVxLvC2a1hXnNpmm6K52z/uMO0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ec/N2qCEd8+ifs/21ZL3qPWI+xTNXkaMe7Tlqc24mDKDMpNcUctGrY6oneALyYZWVE2COGg6ZVs/mzTv9AJ3KtEkPF1cwuFSxzvLotDdMA82LEihCk3WDH5wJako0A/kmkcjdkk9dvnp5hzcG1JwFhkBUEZ7uKSkM4Kc38JaHk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LxOiZran; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772522940; x=1804058940;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Mpy4kLfgojPN6iF7EOVxLvC2a1hXnNpmm6K52z/uMO0=;
  b=LxOiZranicWZ4BTFtaNdeFf4xo3Dg660gUlNNzoY4X9etxdi3C8Hd0LP
   emcpDt+ere/wwYGdbbhGrfio2jiyzID6TyE8jAwxcsPOuJ9m2i4Xgvte0
   epubgX/Vc2XrMYQfqnrQ/V03oqk1gYK49mXiUEHSxa2b9CkKq4tQs4Jh0
   usE6R1i0bnAUTrkDd2zKsDCvdZMGHxONmymETZcvIGXtxnpZZkk4hvtqO
   sgdfYdYFxBqYJ23E4ObTnKCj89e1XHRu+eanSw2rw0Uzcnfh+JmsUjQvK
   o+/ja8CXuioq1mcbCuqFaqlI8UbZzgFZAnkHU5vMyCbQVcaxpVB0UAq9+
   g==;
X-CSE-ConnectionGUID: kwuTgx4cRE+opx1jc69gZA==
X-CSE-MsgGUID: S2fyLFmvRCGRppZzEmXpGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="77414501"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="77414501"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 23:28:59 -0800
X-CSE-ConnectionGUID: mZcXGiNjSQK0BVOtZpgERg==
X-CSE-MsgGUID: DGsU8ytdQpyZUgigJUW84A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="216314495"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 23:28:59 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 23:28:58 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 23:28:58 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.43) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 23:28:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEEZ96U1ui79tJGZmLF9SXdR1i5d9rdH4RQ2Y0O+n3jZXUy04zgFFrMmmaOfp8erpfvYlv742MoGG9pR9X5Hqo9lyihb2fsT4y3R4eBXuNYGBGnnbZVegM1CkzRgUWAo4hOcTOtGpRF8kldwn/M9WbwLDFOzATrjkSYDCf8Ey9iBaGGpb44dHx3cXsrEqVsw+UMJ99Gm27BY9kqA3WH0lhjCJ2wLe+7gy/kl6XaLDwduHlyYFoYxqOO0Eqw5OjtH+iRyYzt6NCD6e6J62EW3N+4Rqw/bSGn7DhD/vGo0Yfe4bl+xEV7oRw1ioktPfOZ++hE+SjFtk48k7wSa0vFrgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mpy4kLfgojPN6iF7EOVxLvC2a1hXnNpmm6K52z/uMO0=;
 b=ir+S9zfITd+1d4PcNvC+LCjsc981KwqZDcLYR5jKgwewiEVjaYxdtnj4LJykpJckebrK7eYBXjhFlqNq1rPtoA614DZWF2kmbRCGRI2jzx/sAynbKRFts5wFbPoJc2Gy1K62ssj7Gx+DNlQk3AbXWBmyhuBq8oGtF4jgA4s9l3Ano2LmplMtpnXjq49taCZgmAbjDm5tSIHGqfXkMFYphnZweYchYZvj6rYxUfuZl7mAodGrvj4kB4VYH/652q9GxgtVCsMl1rV90/y86qSFTDeBDakIL+LgqioKrffoBcYZPLT89hAZk7kQRiFjHPDUbErymu5Cts1dLD5PeeO75Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by IA1PR11MB7728.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 07:28:54 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d%3]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 07:28:54 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	<linux-wireless@vger.kernel.org>
Subject: RE: iwlwifi-mld: Fix fw id leak in OOM case
Thread-Topic: iwlwifi-mld: Fix fw id leak in OOM case
Thread-Index: AQHcqplJOAYdPCdPFEOqlM516Y2cwLWcaYPw
Date: Tue, 3 Mar 2026 07:28:54 +0000
Message-ID: <DM3PPF63A6024A927179DD5C6D8BEB45B11A37FA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <02f66cee-4892-24a3-9a07-1e722fe8888f@candelatech.com>
In-Reply-To: <02f66cee-4892-24a3-9a07-1e722fe8888f@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|IA1PR11MB7728:EE_
x-ms-office365-filtering-correlation-id: 9a7d2169-b417-45b2-76ca-08de78f6867f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: y8VQAKJZCqfacbSmm1C4B9zvNUymTUuO061NHiQuH0T5Q02JoLvi8+zoSXc4i9c2SNRwBxCmQot23l2XJ7w4RTOxBS/c91lSEisa+UTtKq4epnct1/WjCiowMamZpyRweaaqjYm66P+XhneGcuyQghq2H9nIZZQN86btWr+LI4swv0yQyig1k7bveyl61rWFt3zXUInuqIMun43n2LrHoDhPw9sUaqppQ8zBxBPz3ZIgnUQJ+unGaqQthg8yHsWT6BbzHInt7O9I+R6L5JWwhfyJEYk773XcwT8UxbHZT0MTnFiAQEe5KuyveaToVjbau+CacyEx1IOAqw0j7ZtSr2v9WlgYk0m5lZcE0OV/9Nf/wymmpg6qYdjV089CsNlqcAQNgXVkLMjnFjpfW4KZxaeZVT1opxN6mbydMIxRjzl1tz2Be/gQGQkwT7UdUHA7u6++YvMJFtvrr/UgNDB336asoKstUy7b0PrMQHc7pTbgaCPwvNC/RWAPRxg86C20oLNcauxHFxKfCrstgwDzFnCYBwhWzoWnVBQD6TiEURImhw5UmnhEgLpnaUtej0AHjRrdYobrCONRd8Rm+Qnd9lBlVFP7I6LBt/V7eFtC1cAbuJxtpQWa0eIAQD7r//TIBNtjQLH7f59LA8GZcj4YneCgBvM5WJAWJ3rtopp3Y7YdlLNZCK6XNErRm30DOE65Xlyb5K/FuH4JFY+dHWj0suBK5QzAsbHixXbdoJmdA7k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEpkdy9RTmZEQzBHMnBWV2JnQk9YamZHMWtSc01zNW14aHhrbDhWenhGR29q?=
 =?utf-8?B?TU5NRTFXUlMyaXcrMlloOGlqZkNZVkZIWGpTR3J3WTVJd2ptWkd1akE2OVNt?=
 =?utf-8?B?OGR3amRxVGVNK0lud0lxcFpPN3RrY2FSYThCRTBlOWdDLzJ4NlBRRXhBa3N3?=
 =?utf-8?B?Q1ZhbGx4a25pSDV3WDFkYXpHWXN3NHNtWXFYK1NsblBtTC95eFBnQ3BqQmlP?=
 =?utf-8?B?YTlRVzE0QUdDeVlhSXhRRFVwekZrY0FNRDFKLy9TYWRacDYxR0U4U2N2TlRW?=
 =?utf-8?B?MEl2Q1VMejlBU0lEcTM1LzZDN1hoczg4SmJ4WWdIc25VUU04UzQ3L1FzWWhz?=
 =?utf-8?B?QXRXOUI4M1dCZU5hNDhlTExrZDJrZXFCdjBKK1J0b001Q1Y1V0h6MWh6Tmlt?=
 =?utf-8?B?NWkzSUQrYnlNQVUyTkU5Mllud2dyekN3SVZIVE8zRWhCT29NSFFoVVFiVjJi?=
 =?utf-8?B?dnFyVTVFRDRFb0RjRjArR2ZOcDQrWDl0NVMxdjdSajJmRWRTbGZpem8yWFRy?=
 =?utf-8?B?ZzRySXhvczY3eENwazd5Ym9VRFRrQW1hR1RSd1hnU3B4dEorbHBCSnJIaTQw?=
 =?utf-8?B?WFdFL3E1RmsrZUl3VzhEeEp5bzF3T0djMjN2NWtuNG5SY2lXekgrVXkyUjhE?=
 =?utf-8?B?SENXTHRlemdDSW1Ycktua0VLMytOZk82OVBmNWMydlFCakVEcHJ3L1o3Y0gr?=
 =?utf-8?B?WG9xSkExUmN3NUVHOU1FL1d5dVMwRmFZNmF0TnJuNFZQT0dLb1AvWHgrVWQr?=
 =?utf-8?B?NDljbHAyM0hMRDluamxsK3lMWmtqalhPY01IdUdxUmFuK1ZPQW5HVWNrVEFD?=
 =?utf-8?B?cVhHWkxGc3dZQys0WUdHYW5ZUU82bEloVUo2UGF5VFczOEZqNHhGZzFKN0pk?=
 =?utf-8?B?OVl3N3VWMDk2QUpKdlpkYzlaR1RGc3EyeHliQ3h3U2U0cGpWdGFaVTZRVGdO?=
 =?utf-8?B?bjRad1NYZjlDZTVmYkgxY1ZpTEJIMnRtZkNlWHBmQ3ZOTjNXdUhYV0ZtL1U1?=
 =?utf-8?B?aGErUUN0bEw1cXVtckF0MjcxWW51QnhJcTVZRFEwc3d6RlQ2T0xSRHFxTS9L?=
 =?utf-8?B?WGNCYmptM2grUURCZ25XVXA0c0x1cWdZb2t3SUpNamt3WktDWVNYNitLTHhU?=
 =?utf-8?B?YlI3MXFUckZqUE5aL2ZsTlBBa0hNdGJjS0orMWNNMDBEbldFaWZGK1Nla1Zi?=
 =?utf-8?B?czlENzlYK2dZcUNpZWZLTFN0L0d5RkFsdnVMekliems3eVd0emVjZUZ5UFpk?=
 =?utf-8?B?NGRzQnRZVDVPVkt4R2srbmJ6em9TdFBCdkJwRXFFaS9tdXIvMjNwSVBXWFdh?=
 =?utf-8?B?Q3lZUXNRVHVoUjdEWkhJbWYxeU54WUo3RE1GU0VlQzBzaHFqQXlQLzNUSWtn?=
 =?utf-8?B?Vit0MlJzL3BZUStEOUZtQ3pLUDFxTThDaDcrRHBidVplakRLVEMvNElULzVJ?=
 =?utf-8?B?RFo1WUNjWk1NQTBTNElpdk9GVWt1bzNRelZUc1NsaWNySU5vRS9XaGljOThl?=
 =?utf-8?B?WjFIN2F3UFgzNEdxZEZRM2NYRm50YXJBUnVnZ0VuYWQvSDlYRWpBaVhYaE9F?=
 =?utf-8?B?QjM3UjRwblZEOW5OdnI5TnFjT1A2MVVMcWg3Y0JWYU1ETDQrQ2t4NDhZbFF2?=
 =?utf-8?B?MjlNQzBkMUlGK2VKVUpkZEdDVTE5UlY0cDkrRmNYQXhwVzhnSUwyWHgxLzlN?=
 =?utf-8?B?VlFjaitzSHhVSGZOV1RMN0JkNnJkQzNqb1JPZ0VGZzk4dTdvMzkxeDhOOW9E?=
 =?utf-8?B?TzVKR3RmTVBPNmVLS1ArcWlFc1RqdDMycU9jVmN3enlUVlRHaTEzM3BkcDFB?=
 =?utf-8?B?NjMvY3l5UjJ5VU1rVDhxREdlOUpmTUpXL0pMS0N2clB3cXcwcUppdWUvSU5Y?=
 =?utf-8?B?R1NBVVVPcDRVM0dvRmRzUTduQ1poY01Wem9CVFhoVkw2cEJ3aWRlSU9SKzhB?=
 =?utf-8?B?Nk5wajNZR29IcTRyMlRVcGRTUTV3dXBiVSs1U3R3elJEQlI4STRnR2M4NGZN?=
 =?utf-8?B?UUVVT1N6YzFWeFB2QnVmZkFhRG9uUHlhQkJvaXh5bHlXSUsrWnczdlE5VDlx?=
 =?utf-8?B?T2xMRFBqb2NxQVVBV1Zsb0lRbGNnZW0zaUlhd0NNRERwbFFPVUxyM3M0N2Iz?=
 =?utf-8?B?OUdUQnljY1F0OUh3NUdONjBtNk0vV3R1L2FLSGlaWUpFUTUwZVZUNVJERmhP?=
 =?utf-8?B?clJwME5henVuU1g3Y3BBUEdlOW9YTDFOeXZpbFp2d0F5UWM4MHdJV2FpcDV1?=
 =?utf-8?B?K1RPblprZ3RUKzJPdkMvbXJGdlYrK0YvVlc0WE42VEFIcVJXWXFIUGVuaDl6?=
 =?utf-8?B?NkRsMXlWRlkrVDNyc21xNVUzQ0NCc1R2WXdTK2V3bDVlTktmZ3Q2K2pWSkl4?=
 =?utf-8?Q?tj4zCjPHT+2kp2kU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7d2169-b417-45b2-76ca-08de78f6867f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 07:28:54.6935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mnBDwDhFtn79TksiZMLFAGcrT6ijg0jQptytZwP8qVW961xbq91F0JED6DtHNAzhlEJ0dCJaTNRZOlmV3Xm8U0fhcqjzr1faTuZCQzK0E++XgHLYi84IBZUdHW8JM2PD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7728
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: E9AE31EA331
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-32382-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,DM3PPF63A6024A9.namprd11.prod.outlook.com:mid,candelatech.com:url,candelatech.com:email];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_DNSFAIL(0.00)[intel.com : query timed out];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmVuIEdyZWVhciA8Z3Jl
ZWFyYkBjYW5kZWxhdGVjaC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDMsIDIwMjYgMTow
NyBBTQ0KPiBUbzogbGludXgtd2lyZWxlc3MgPGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9y
Zz47IEtvcmVuYmxpdCwgTWlyaWFtIFJhY2hlbA0KPiA8bWlyaWFtLnJhY2hlbC5rb3JlbmJsaXRA
aW50ZWwuY29tPg0KPiBTdWJqZWN0OiBpd2x3aWZpLW1sZDogRml4IGZ3IGlkIGxlYWsgaW4gT09N
IGNhc2UNCj4gDQo+IEhlbGxvIE1pcmlhbSwNCj4gDQo+IEkgYmVsaWV2ZSB5b3Ugd2lsbCB3YW50
IHRvIGFkZCBzb21ldGhpbmcgbGlrZSB0aGlzIHRvIHlvdXIgZHJpdmVyIHRvIGNsZWFyIHRoZQ0K
PiBmd19pZF90b19saW5rX3N0YSBJRCBpbiBjYXNlIHlvdSBoaXQgdGhlIEVOT01FTSBjYXNlLg0K
PiANCj4gSSBoYXZlIG5vIHJlYXNvbiB0byBiZWxpZXZlIEkgYW0gYWN0dWFsbHkgaGl0dGluZyB0
aGlzIGVycm9yIGNhc2UsIGJ1dCBJIHNhdyB0aGlzDQo+IHF1ZXN0aW9uYWJsZSBjb2RlIHdoaWxl
IGxvb2tpbmcgZm9yIHJlYXNvbnMgZm9yIHRoZSB1c2UtYWZ0ZXItZnJlZSBJIGFtIGhpdHRpbmcu
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9t
bGQvc3RhLmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9zdGEu
Yw0KPiBpbmRleCA1ZmIyYTQ2MjQxZTQuLmRlOTkzOWFkMWQ1OCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvc3RhLmMNCj4gKysrIGIvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvc3RhLmMNCj4gQEAgLTUzNSwxMyArNTM1
LDE5IEBAIGl3bF9tbGRfYWRkX2xpbmtfc3RhKHN0cnVjdCBpd2xfbWxkICptbGQsIHN0cnVjdA0K
PiBpZWVlODAyMTFfbGlua19zdGEgKmxpbmtfc3RhKQ0KPiAgICAgICAgICByZXQgPSBpd2xfbWxk
X2FsbG9jYXRlX2xpbmtfc3RhX2Z3X2lkKG1sZCwgJmZ3X2lkLCBsaW5rX3N0YSk7DQo+ICAgICAg
ICAgIGlmIChyZXQpDQo+ICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gDQo+ICAgICAg
ICAgIGlmIChsaW5rX3N0YSA9PSAmbGlua19zdGEtPnN0YS0+ZGVmbGluaykgew0KPiAgICAgICAg
ICAgICAgICAgIG1sZF9saW5rX3N0YSA9ICZtbGRfc3RhLT5kZWZsaW5rOw0KPiAgICAgICAgICB9
IGVsc2Ugew0KPiAgICAgICAgICAgICAgICAgIG1sZF9saW5rX3N0YSA9IGt6YWxsb2Moc2l6ZW9m
KCptbGRfbGlua19zdGEpLCBHRlBfS0VSTkVMKTsNCj4gLSAgICAgICAgICAgICAgIGlmICghbWxk
X2xpbmtfc3RhKQ0KPiArICAgICAgICAgICAgICAgaWYgKCFtbGRfbGlua19zdGEpIHsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgSVdMX0VSUihtbGQsICJtbGQtYWRkLWxpbmstc3RhLCBPT00s
IGNsZWFyaW5nDQo+IGZ3X2lkX3RvX2xpbmtfc3RhWyVkXVxuIiwNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBmd19pZCk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIFJDVV9J
TklUX1BPSU5URVIobWxkLT5md19pZF90b19saW5rX3N0YVtmd19pZF0sDQo+ICsgTlVMTCk7DQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gKyAgICAgICAgICAg
ICAgIH0NCj4gICAgICAgICAgfQ0KPiANCj4gVGhhbmtzLA0KPiBCZW4NCj4gDQo+IC0tDQo+IEJl
biBHcmVlYXIgPGdyZWVhcmJAY2FuZGVsYXRlY2guY29tPg0KPiBDYW5kZWxhIFRlY2hub2xvZ2ll
cyBJbmMgIGh0dHA6Ly93d3cuY2FuZGVsYXRlY2guY29tDQoNClBsZWFzZSBzZW5kIGEgcGF0Y2gN
Cg0K

