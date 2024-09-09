Return-Path: <linux-wireless+bounces-12699-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D059F9722EA
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 21:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006701C22D75
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 19:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0567189B99;
	Mon,  9 Sep 2024 19:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fufAA3D6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B66518A6B7
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725910774; cv=fail; b=ucYkH48r6JJSZYPigrREQ8tqFwhqgjDLYzQtXdrn3vZAGejuUjISFLQkfTblYZOS73QHIjKjLV8Z7MA1TnR5363Bfdl3ZA4/tntTWtsIdviEOtTGInx2zA3e5lzKo4pxrSgcWLO55nU2MLOSw3tksNianPKnJJHL4pzq3kBbJQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725910774; c=relaxed/simple;
	bh=3U2Yq+mmu9MNUIvSRxhhedM5DsLnQxv/24vAvdMyTto=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lS2c2y80jVNt39lfPZlwrt0hnoNXoMxhQk9zo1cL07JXHpYbWTUIRJmt0vaHk6Q3Lrkz6y1rqgr/P/DNbBRnmkKna/PtnV5zn/bnQMQy1IgI8EKkVkzWWiV9PK42c3YTDX1xmXB8vC8P834G2dTwYz7ifOq+5hLfBVSPuW6Z+UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fufAA3D6; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725910774; x=1757446774;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3U2Yq+mmu9MNUIvSRxhhedM5DsLnQxv/24vAvdMyTto=;
  b=fufAA3D6NygKJlhuBIQ8bitk1YEeV/+EgrfElBgxPJdHt59tvEfbiZBP
   uHjC/J4esNoAeG+wCZFUsGKRQNwLkNIfo17ztofxYn3UOn4ViSwEzGvwL
   SwBJ3CUWtmMQ3nVzUVp7emlPldywsex5IPIY8ca7loefZJFjEWFGPGmZd
   TZlQoFL1AwAtzWybX3y9/d6UtRtPBndXMLGWDVyiXChBJFWdW/MZmAGg4
   1R/3hfsYCXh8h+384L+XJwbO5BK6UlZDq3yfqU/5A6eEDS6fS1sK5Req1
   4ONZVcK8bgcaOKTK6UfMX+pr9DY7Zq+NbFpndbEAguhAohkwTYxKxQMDl
   Q==;
X-CSE-ConnectionGUID: EbaV4nDdRzybQ62L90URhQ==
X-CSE-MsgGUID: tL+tjqGeSc6pOQ1sX4Bq9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="28513293"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="28513293"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 12:39:20 -0700
X-CSE-ConnectionGUID: 4m8VRtunRTKhmnqky8MTew==
X-CSE-MsgGUID: LuAdeR4aQFqNbm3iVb4ECQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="97584111"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 12:39:20 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 12:39:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 12:39:19 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 12:39:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJFM9aR127lGaoYx/hXx7o4X8hI7og+2nse0OIZ79vNqk+pdcINmuqyRNPrKLRaOwxkzGyB4O6QB0arg3B57EjqYgf7LZT5n66o2BLFiKlCiQGpq/Bz58+/Fqz5SCVSlIevUQT94OSwPjuidhQwwLxr82S7ugo+bKtJGjRCwrLLKNGbag4BiqSuousfsO+IvbDd+GzacxtnOUe65NL0umI9wUebzc9olL/DxBPCl2v5XytuK93/+5tR2BQklglTeWcYA6wS4yHNOByqjNvdCRyMy/YwejXu7MlUxNHLJd1WapPlmmPC9/CHynmzb56QMqSLR5Ve/8TI3COWLmkBDaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3U2Yq+mmu9MNUIvSRxhhedM5DsLnQxv/24vAvdMyTto=;
 b=e0erPJ/oRnlgx3CxeYtIgq/A1u711iYMY+DPO7rzs1b9823wyli8E+EZczkkrqHUSlzyZBRtRe1b/kZRz+uHWktd1lRMyEs2lIDlijgdsuaKp5ow2Y6hfJLuJMJYCc6Kr40FO89AdEVKH9PCKznSdPs/uuzUmOwUvwrojdv5/UY4jjxghwCt604KH72ejRUScu5SbW21rg8ACRNvVD9/rpaOjAB0C1v0LkyFLUckT4aprt5gddxhZJJTfddvJ1rKaxxJIkI+Iaup30Fe55o7VNUY1GB+j910dOZfpqnZ6+3GcRHGUoOIc924R5gEL/v5uvpeMp3XEa6gJGN019F5MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by SA1PR11MB6686.namprd11.prod.outlook.com (2603:10b6:806:259::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 9 Sep
 2024 19:39:16 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::41f9:e955:b104:4c0b]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::41f9:e955:b104:4c0b%4]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 19:39:16 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "chris.bainbridge@gmail.com" <chris.bainbridge@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "Korenblit, Miriam Rachel"
	<miriam.rachel.korenblit@intel.com>, "Berg, Johannes"
	<johannes.berg@intel.com>, "benjamin@sipsolutions.net"
	<benjamin@sipsolutions.net>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>
Subject: Re: [REGRESSION] iwlwifi resume error, bisected
Thread-Topic: [REGRESSION] iwlwifi resume error, bisected
Thread-Index: AQHbASid0CU63h7wCU2RsueU4ZEG+rJMpxoAgAAufYCAAMEcgIAAIYgAgACoNQCAAGgqgIAA3DaAgAA4xoA=
Date: Mon, 9 Sep 2024 19:39:16 +0000
Message-ID: <5b372558da9aed3a33e466970a64a5eda8f82454.camel@intel.com>
References: <CAP-bSRbMbZe9LCE15SCbYNTGZjE_xiAm29qzO_WNVjHsJ6oyyg@mail.gmail.com>
	 <9ada34661b93fa5dfe3b0c66816a62c1a27f22a3.camel@intel.com>
	 <CAP-bSRZm4CyxY1VdtWvZRcfLMwc3njd3OTSd446Q5dcSfjJY=Q@mail.gmail.com>
	 <d59125316423abd2f67e1c111eb54d083b7cc014.camel@intel.com>
	 <d3a83162570aaede579ecde64e00350ce1e6b452.camel@intel.com>
	 <Zt4PKMCp_FTx3kac@debian.local>
	 <cd2ec07a08c9a51e0dfa5be70b35d39e5cc5e577.camel@intel.com>
	 <CAP-bSRbmKvaoU662XtgjaPaOwR7fHZaJyrYxkpT=DfuCxwsJ4w@mail.gmail.com>
In-Reply-To: <CAP-bSRbmKvaoU662XtgjaPaOwR7fHZaJyrYxkpT=DfuCxwsJ4w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB5825:EE_|SA1PR11MB6686:EE_
x-ms-office365-filtering-correlation-id: e2aa9a56-a038-4757-7720-08dcd1071741
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SDh3bDVjUi9oWGlnSVlkS3luTmJLNzRZZ2dyVjdxQVYxZU93dUN5YnlDTGVm?=
 =?utf-8?B?Tk01cDdVSXo1dlJaaDFtY283c1BRZ3JGTkFrMW90VUwzZjJVbHlyUWZMb0Z1?=
 =?utf-8?B?QTB3dmlqTlJ5c3lmSHpjOHZTK05Ca1pkeElmTHFDT1JTaUROejJLK3RwOTVK?=
 =?utf-8?B?L2ZYT3FrdzVreVhuMXMreS85VUdJNGZtdmRmckh2bjBhMWN2b3FReGtVdnB6?=
 =?utf-8?B?N0ttdzJST1JuUlV2eGhXVnc2d0dUbFphbEEwTFBOU2hMTHdMK01Bb0RwUmhH?=
 =?utf-8?B?d2FsZnBzRXBMK0hLRkZzSW9IMlA1Sjg2aEI2VGwramtwNEhhYVJvM285akhp?=
 =?utf-8?B?V1BtUDR1K1NwMndvMytLUDZ6c3BNNHNLVWY5a1QwMDBBSWxRc0REd1U1aTZq?=
 =?utf-8?B?S0JpeS9kdTRhSjliY1doY3JHZEQ1UVM3T3NFc25iT3M4Z2tPblJIb3NHZkY1?=
 =?utf-8?B?ZElsTEtDWnNwZW1CamlCNWRadXRDMDdjaGRxWENtZm9Sc3F4LzRRKzJVRlNU?=
 =?utf-8?B?QVJ6V1lld1ZhMjdFSlhlL2l3dkdrVmtTS3UraWFEcUZRSUdTYnAyRVZ0UFE2?=
 =?utf-8?B?WGNuTE9NNUhMYURaVXFrbk1yRCswMDhhR0wzS1N0UEtuN0ZtNnBEbjlIUVE1?=
 =?utf-8?B?bmNERUxjQjFJeEZRRFBINGpad1ptTlJpMExUYVo5QjFTbkR4TlNKcExud3g1?=
 =?utf-8?B?NU9vbXQzRThkRjhNdWlKcGYxNTI4TldNRk1zK3I1ZkE3TCtlZ2ZpUDc0WHBT?=
 =?utf-8?B?dWowc0M2anlTeUtmTlBQWDhPVzZJU0I0MEFqTEkvVUQ3QUxQUUhHQi9KQWVS?=
 =?utf-8?B?Y1doQjM1T2NaR1dBZVZYclI3NTVJS1NYSjQvQlZXQ2JidkYzOTdHcVh6d29V?=
 =?utf-8?B?Nmw0UnozMjlwcWdpZjNNZUhOVFVYRTVWSFZCOUpWMUhEdHdybk5RbEIvc1VL?=
 =?utf-8?B?d1RpTDVMUmx0NUhpRStGQWs1alBiTHVNM3pIWmZPamEwcUlmVGZoYkRpVG1Z?=
 =?utf-8?B?c0hWWGJnUDJ5Tk01aUp6eWpQUkIzazgzL0N4WCswbHMxcUZzU3JsaVl0cllQ?=
 =?utf-8?B?TXNEejhLK3JPd1lmTHNrYnlMcDVLWHM2ZExYcVg4dnJxTytHVm1ZZHRmb284?=
 =?utf-8?B?NjA1M21BQUJUWG9OeVhoTUhGaGE1eXRCN0tWZkpUcDVTbGVJNVBRRTNYeG0w?=
 =?utf-8?B?NW0vQzJTRWYrQnNya2tpQThUSHpkR0RHRG9Md3cwdFByYmtWRXBXTHdEYWFJ?=
 =?utf-8?B?TUdRM2F3cUtQQ2lZYU5MT2JESTFIOERwUVRmcnZlQU9sa1dRYnNxSmN1c01u?=
 =?utf-8?B?d3Q3NWs0ZGRJK2lPM2cvMVNleTNzc08zQlBQR1o0VnJ3YTBGVzQzS2NwSm53?=
 =?utf-8?B?ZjBIQ3VvL0JPVk9MNk1JUzJ4SVBaaW94L2tUWjhsMTZ2VHlYbnNwczJ6TVVp?=
 =?utf-8?B?dW1abXkxNElXQWcrYUxSbnNGQlE1KzlkYk85eHFXaTNXMzBIQUhTSmdRQTlW?=
 =?utf-8?B?U2JpaDFxUytjZXJ0VmZYdzdvZ3hXbGdtMW02dUNPV3Y5NmgreWpCOVBmNGs0?=
 =?utf-8?B?ak1rTlpZdEJMU2JRWGpmZi9EeUgvQWY5aCtmSzErVnJsMUlKYWRHRTFzMmRi?=
 =?utf-8?B?aVltSlBoMkRPSzdlTWNLa2JzLzlqSFdKcStYb2xBRXA1VFMrQUJIQSs0MVBC?=
 =?utf-8?B?d29Pb3JhaFhFUFZmWStPTnBOYytiZlFxK3l6WE9Ib2RHK2FUMlJiVmljejdF?=
 =?utf-8?B?dFFYMzdDa3c1eERjUHNVMkN5NmQ2VUUyUWFCdmxkS3gwOE9ZQS82NkhRaFJH?=
 =?utf-8?B?ckk2MHNUbVdFaUNKUi95WkMwNXN1T053MzhmK1oxV1k4UlB1SDNUcUNOR0x0?=
 =?utf-8?B?VUdrclRYUk8vR0FTY2xtR1RmeTFUenoxdW0yQUcyTHFhNHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHZFRUU4N001c2hjZ0VXdUVQKzlLU2hXTlg2K09jSE9tWEhkWm93K0xhT1ZB?=
 =?utf-8?B?a0RFdDVaR0hvdXRram5EREVMSXBVTjh4V0R0dlV4M05VLzBoMHlKZE1qS24z?=
 =?utf-8?B?a3E2ak5oK3F4VSs0Vko1SUNROHVnQnE2TnZuT1VJc0RuS3FVS1dIaFl6TGxJ?=
 =?utf-8?B?ZWczVXUrQVV3TzAxUlBQam8vYzBSdGJqdDBhSzJ2cjFaazQ4eEh6SFByWWs4?=
 =?utf-8?B?WWN6Umh2L1lRYnJlSG9ramtWU2ZkNTdqbVZjNVlXYWhlMWYrTit0UXFlY3hm?=
 =?utf-8?B?QU0wcE93eUk3TmpRMUlpQXYwNENSMDRkakxRMmpNdUpYbStsL2d1MWd2WTdK?=
 =?utf-8?B?SlVjZDlZOEt0VW1BZWtlUStjZ1hoY0pQdUVYL2ZJRUtCZGVPSU5LRmJyblg4?=
 =?utf-8?B?Uk1HZll2TzFFaFFXaWk0YkVXNkIrU3hocXRDWFVIaWlhRlhrT2QwVXN6ZldO?=
 =?utf-8?B?c284b2Jwa00ydHVDSTJkRHllSFhQQ3FoNnRyR1QwNVNLK1Y2eGdRZkxQQzhK?=
 =?utf-8?B?VDNWS0pEcTkrT2tORjh0T1hkdFl2M1RHeVJQWGxKdWpKc2lJTkdsdGVSSU1B?=
 =?utf-8?B?UlVzTzJia1BOQ3hnZWV0K1NvQk5BZVBNVVpqb2wyTGtNUzRndUhEckEvK3o5?=
 =?utf-8?B?Q3ZCajdLakNPSndRdCtsMG01MFFvbVVlbGJRSUZ5aTNJSGttSzMrd1RKTTRZ?=
 =?utf-8?B?dGIxSzdCN251QTU4U3BuM2ZtZ29mdGRqY3Zhd05pZ2hXZXJTZUNHNTF3d1M4?=
 =?utf-8?B?VTNPeHhmdWRsNzB4TWdIaHcwWWdjZTN0d2U4dnNtNUg3dllsSk1xSFhYYkIv?=
 =?utf-8?B?d1NCcjUvTmJxZWwyeTlhc0Y1YXRyVFdCT0JGSklXaEpJSUJYRVhDRTNkb244?=
 =?utf-8?B?bmUreXM3YTh3Z0hDdmlacHpGYmJ4SzhMVnFIc1NmMHByRkhleEUwY2Q1Qnhj?=
 =?utf-8?B?aTFnekg0YjRNYmhIUzlXSTIzTnRDZVJmd20vMTlKZTc4cXBob3oyZE1oQ0dn?=
 =?utf-8?B?QkFrK2M0TjI1elZqWUgyMTZwWTNKK2U1aHhIcFo5OFNROWhLT1d0ZUFSbWgy?=
 =?utf-8?B?a01xY0dPNXhZNnJSVjJrV1hQT2RzbEtiR2Z6ckFMZjhDeWd1MllBS3pNd0s5?=
 =?utf-8?B?OUsyYXF3aFQxQmhwbk1yb0NSbWZTcTdnK2xZdkFHZm4yNGRoZWxueUZ6S3Er?=
 =?utf-8?B?c0lKZXg2aHp5RjRzYWZIeDg3clNvOEQ5V3dmL0U4NzJGTWVZN2lkdEJsRXY0?=
 =?utf-8?B?L0FKOFNBQU8rSnAzQlJMZEY0Y0JXelQzVlNCejdKUjAwSHhxblJpamFBYTdQ?=
 =?utf-8?B?cFZWQXlSYVdDRHhOc1VUd0hmUzBCeFgxajJycXNHWG9BNnVmT2x2S044cElL?=
 =?utf-8?B?WU9PdURIdTlWcFF0YStMb1VYTHFHRVczM05Fcml3dU5Yc1BCR20ybWIwbDh4?=
 =?utf-8?B?aFlISVBlZmJZUDQ5QTBscXV3NXJUUWRIZGptbjdpODBWdTMxRmlFMHhCK3V5?=
 =?utf-8?B?TFFPd3c4OXQ1eDRkZjNiK3Q0UTVZTkpGSmZzdVZrdXdXVnpoRnNIRWd0MXVU?=
 =?utf-8?B?Vk43ZEw3Wm96RFRUTlAyd2dXajJRMmFuQU9YS2dBaTUxQzJpSFpKV1VSQjlW?=
 =?utf-8?B?cG5Dam9mdWFjZWFKTklSSXNIeU1tcEN1bm15RGlRQmk2cDZDRDROUlJjc0Vo?=
 =?utf-8?B?dkJPYXBpRVc5eG9aUSswZ3hpdUNkZjdxOC85YjlMYlhuZStnejh6VkFhdXc4?=
 =?utf-8?B?cGYxS3BqQUZGVWpoM2twRDdSK2RDUC9YQ2ppbHBlWm5qbmNsNlByVlluTHJO?=
 =?utf-8?B?Yys5S1pzZnd0UVVLTFBlQnVESUlsTDFVazNmVmovbnJUa01hWURBQkd4T25x?=
 =?utf-8?B?TXk1TUJUVElqZnJPeFRkS0pUOW5FVUN0eTJqOXdLM0I5QlBmTW1uRE9DOUp4?=
 =?utf-8?B?aTBXSDN1QzQ2ZnNvdnNFM2tEK3dDWW8yZWpDbDBvczdPMHZtODBpMDE3T2No?=
 =?utf-8?B?T0lHaG5oTmRNMkZYOHBod1RKZGVSdzVXaVN1Tkg2dmFZbTlKTEVEenBlNlYw?=
 =?utf-8?B?dzVGc2diR21XV1R0bmNXd1BnVlBVNXBDUktNa25VazdrK1RJQTNHY2l1Wmcr?=
 =?utf-8?B?M0RDUGM3MWdyeHVycE9IdnhvSjNvYy9XTmdqZmZIeld2NzJtV0x4S3lsNWZI?=
 =?utf-8?Q?KP6O5vN70kGXWcrttdzloDk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB0FB9F8DC07714892F55B03BE9083BC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2aa9a56-a038-4757-7720-08dcd1071741
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 19:39:16.4355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LGCk15Y3AUGFyAnGchNC1spPgowQXopA+uUYYrGYCoOyHNrCumNVRlrYc9A1GSLtfRR1VrcTYRQBVVvxkeSAHPA+Xp4BQ5MMZaaGeXaUS0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6686
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA5LTA5IGF0IDE3OjE2ICswMTAwLCBDaHJpcyBCYWluYnJpZGdlIHdyb3Rl
Og0KPiBPbiBNb24sIDkgU2VwdCAyMDI0IGF0IDA0OjA4LCBHcnVtYmFjaCwgRW1tYW51ZWwNCj4g
PGVtbWFudWVsLmdydW1iYWNoQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gU3VuLCAy
MDI0LTA5LTA4IGF0IDIxOjU1ICswMTAwLCBDaHJpcyBCYWluYnJpZGdlIHdyb3RlOg0KPiA+ID4g
T24gU3VuLCBTZXAgMDgsIDIwMjQgYXQgMTA6NTQ6MDlBTSArMDAwMCwgR3J1bWJhY2gsIEVtbWFu
dWVsIHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gU3RyaWtlIHRoYXQuDQo+ID4gPiA+IA0KPiA+
ID4gPiBDYW4geW91IHBsZWFzZSB0YWtlIHRoZSBwYXRjaCBpbiBhdHRhY2hlZCBpbnN0ZWFkPw0K
PiA+ID4gDQo+ID4gPiBTdXJlLCB0aGUgZXJyb3Igd2l0aCB2Ni4xMS1yYzYrcGF0Y2ggaXM6DQo+
ID4gDQo+ID4gSSBleHBlY3RlZCB0aGF0LCBidXQgaXMgd2lmaSBmdW5jdGlvbmFsIGFmdGVyIHJl
c3VtZT8NCj4gPiBOb3QgaGF2aW5nIHdpZmkgYWZ0ZXIgcmVzdW1lIGlzIG9uZSB0aGluZy4NCj4g
PiBIYXZpbmcgd2lmaSBidXQgd2l0aCBsb3RzIG9mIGdhcmJhZ2UgaW4gdGhlIGxvZ3MgaXMgYW5v
dGhlciB0aGluZy4NCj4gDQo+IFllcywgd2lmaSBpcyB3b3JraW5nIGFmdGVyIHJlc3VtZS4NCg0K
RG9lcyBpdCB3b3JrIHdpdGhvdXQgbXkgcGF0Y2g/DQoNCg==

