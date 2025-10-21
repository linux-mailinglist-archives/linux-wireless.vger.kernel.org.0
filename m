Return-Path: <linux-wireless+bounces-28122-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B877BF4A83
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 07:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB78E18C2D84
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 05:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15396256C76;
	Tue, 21 Oct 2025 05:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MN1KruG1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41A82AD16
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 05:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761025316; cv=fail; b=MrpiKEAK+tfyb/qL4F/HdrNeoLoRa7073mTP1dWZAjYl9VUXLjKlyJsi3ZBWs7NRVR9YW6reiMf4P5ld5ODzYwZf8+Rb58Sxey/qbw2G5oBeJNkslPX8TIbNlZeLZbMhbheXLuEaxInjIwY3Hy2wCWWcfkJ8A8/QD1I83wRYPW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761025316; c=relaxed/simple;
	bh=Yj0LnqJH1epC3dk1NHnobaFLEn+rfFnlCG9+Mk0gUmI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ToStQB97OxLt9GTFgG0hHZACMPAjYOx5wXjG5nMKh2vlGdezPsLFmFqU8aiXpfC36TZxqQaHQJUF4YHMpL4vy/KSRMkLM6Z9+uSOICygADHEzfP67x7rqkgjJdMfxOuuovm/TpVQqt3gwrRZPEMiJytFpHSez7s+XNFXbqKnTV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MN1KruG1; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761025314; x=1792561314;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Yj0LnqJH1epC3dk1NHnobaFLEn+rfFnlCG9+Mk0gUmI=;
  b=MN1KruG1vOYewDTp8/gYw0pKI1lsBEO2x8Qp4L6tkeoGW5bBGZKIYRm+
   9kBvCY6l+ZREcQUqIn5y3W6+lOBPZaHAclfIm87S5INlCl3ZW5F0GranI
   mKgre0EnjQ3/zumDkA4uCNyFHaTo2dz11Gg1wgR+AQQk+uGF6TKujoVjI
   XyJxym/8lJwwCL/iRElfspMXlOs5/tIEaByfJfdBJZLQnsMV5bpdNqX8v
   mz8K1TFMQBvghVdomBDGJVlExF9MgdinNmM2RRCqNRWUTlc5eKYBYdH0m
   m6we/q6uCsfCTr9wDGUgCOdfNi0zEA0O6WrhRMzQRumDb3XNZHu1+UG/7
   Q==;
X-CSE-ConnectionGUID: ZbRKbJI3RyezHie5KcfBgA==
X-CSE-MsgGUID: Wmiq6mjVR2ypLyoMTrCGTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="65760780"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="65760780"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 22:41:53 -0700
X-CSE-ConnectionGUID: QVaFVK4RQqKhalpFF1tsKg==
X-CSE-MsgGUID: NwMSQxxCQn6X5vqSEnm+sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="183063815"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 22:41:53 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 22:41:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 22:41:52 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 22:41:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wllPlJLBz7D42ym5G/qgfyOQoIRYqDMg1eXqvECV4u+sUSRpp9DluPTDaYR61ZgS0KxgWTqpvHx4yr38CCqRjjiJgL+Ah866NnQZtd2jAJYES21+u06iuuXk5Xd/M1hPf/Ex2ES6wVMNiIHS37Ioy0MSgZfQCAdLTDgI7ZAOdAAh1pbo+jyXjDrVtknDkTNnOjFyO8PGqIrcYXZGovLaLFKNW85Ue3In3cUzggsR/QxwkYvkJyhy5UH1ja1wv20F1DvTnnSCKLHEeFfUMYBx6kQqVKpT6b2mTvf+xbXROhjiiE8xLBLpVjWeIlNIbZYikDXmE0QlFxo0xkKxTspcaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yj0LnqJH1epC3dk1NHnobaFLEn+rfFnlCG9+Mk0gUmI=;
 b=VXL/rheoxKbmkSkdfYUjkzGBdCXFMI7lKVeQmHq2SD/i4UGAYWNSYiCkyWegVjK1Gg4m2o2hvE0CZRlyXKRDvF3w3tq6yJjvJD1GUETn3jXOc93XBoXyGoRp15x8OR9RQuJ/q6sV8fxdYm5Zf7WBnEaxPI9zUCXdViUTMNJLVA58LL7XtpFBSP2OpA0G0WpKJMcIXHereeHdmRpAAC0I99amuIpKsG3J5B5JapUy0ApL3YyM91SltIacQ/CAOdp6FDf7rtgA/LSFBgbPAaSfEDv0ZJmUrIkXCPdGSOCgMOsSScACYVDxiVnGCPV4jB8HWMbNjrruSj9/Lm2nmqMpYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6043.namprd11.prod.outlook.com (2603:10b6:8:62::8) by
 CY5PR11MB6413.namprd11.prod.outlook.com (2603:10b6:930:37::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.16; Tue, 21 Oct 2025 05:41:50 +0000
Received: from DM4PR11MB6043.namprd11.prod.outlook.com
 ([fe80::4e37:abb:3577:fbf1]) by DM4PR11MB6043.namprd11.prod.outlook.com
 ([fe80::4e37:abb:3577:fbf1%7]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 05:41:50 +0000
From: "Peer, Ilan" <ilan.peer@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>, "Korenblit, Miriam Rachel"
	<miriam.rachel.korenblit@intel.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH wireless-next v2] wifi: mac80211: Try to overcome bad HE
 operation in association response
Thread-Topic: [PATCH wireless-next v2] wifi: mac80211: Try to overcome bad HE
 operation in association response
Thread-Index: AQHcQNW/pDhH3SiflkeJlYcoWTXiCrTLFGKAgAEEKIA=
Date: Tue, 21 Oct 2025 05:41:50 +0000
Message-ID: <DM4PR11MB60430B283B7FCB93E8C49E0EE9F2A@DM4PR11MB6043.namprd11.prod.outlook.com>
References: <20251019115152.e1cf791232a6.I69591428f2b9bde9df3c78c333e9b4fc264da0d9@changeid>
 <6b0634994bc8428f8ebcf4032ff98604660c52fa.camel@sipsolutions.net>
In-Reply-To: <6b0634994bc8428f8ebcf4032ff98604660c52fa.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6043:EE_|CY5PR11MB6413:EE_
x-ms-office365-filtering-correlation-id: 8ade496e-77fc-4328-4848-08de10648845
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dXV6OE4wOStpRW9YTC9qWGlJWEMvSWIwTnFUTnUyNDZtOXB4V015Q29INXhW?=
 =?utf-8?B?TGprMzBsZHU3QWdkcFI4SzBsMnc2RU90UUZBbGdlMHZWT2pyd25EYndKUjBL?=
 =?utf-8?B?SGpCR2NvazlnbXBDY21VWjduQnBPVWNNWGk5UEV2cUlVMVUwZW9RWHNVNlhP?=
 =?utf-8?B?cE5QRnFlOGpEVzN0RzY2a1A2bWJqeWdPeFIrRytXNEVXT3FyVGY4cGtKSEw3?=
 =?utf-8?B?M25taTBpK1Zjemdqb0hVQnA5aTV1NWxob2tONVBHekphdGdubGFBdUdBb2Jv?=
 =?utf-8?B?QjVJNmdvdnFNVjc1SzFwRXhEMWZZVXJLWTZTeHhIUWMraDlHb0o0dThZR05j?=
 =?utf-8?B?WnFkQWQ5R1Q2Ly81c1Z1eTNWSVdYeVJRaVNCWklwSWpRY3ZhTkRZbm0waVVC?=
 =?utf-8?B?TnVzN2c0bDZ6SGVjdXplQUgzODR1QURWMFJ4NFJWdkw3U3NiV1RCMVFuZkVH?=
 =?utf-8?B?bS9OTGcwT3U1c2xXVVQvemUxYktWU1RJK3VpeXlpUElXanRMcllsMFpzclJP?=
 =?utf-8?B?VUphbHI4ZHIrYVViOFQwQ0pzWXVHWDVJS3RXenRIY0duYkJBU2JtZHRSNGdE?=
 =?utf-8?B?SVdHa0RQZVZlRWhnK3NxY29CZEZMSTFvMFBLQ2pxM2hRUC9vdVVKUSs3ZjZp?=
 =?utf-8?B?M1BMNU1RdFVLdkY0RXNvKzJ6TnNTZnRQMGd6WldpaldGeGZ2UHpmVGw4dTdr?=
 =?utf-8?B?Q09tZUxDcjlUS2xCLzR2UmZRekxiaktvLyswenlBVmpYODVSd2xFbXlTNitG?=
 =?utf-8?B?M3RhcVlDYklHampaL2ZCMVRDcXRJUWUyQ1U5eVVKZEw5ck04eFJQckZwMS9J?=
 =?utf-8?B?WmZHOVFUeGs4WkRkY1B1YUM2UWJnT3UxK2ZpRUt6RWo1WGJxNHJDM3U1NnZU?=
 =?utf-8?B?MktBREcwMHFLUFVDYXlaT3o0L0xoOTdpcEl1VVFVN01MeFJ4SW5ZRFlyT3Ur?=
 =?utf-8?B?M3Z3TEwvM3l1cnNXbDhIU3VrR3EzdUNmdTFXaUFZYjNlU0ovKzh5Tkt2VTNQ?=
 =?utf-8?B?UzVXbFhXaGR4ampvUml1dkw5d3ZIdFphSnpnYmsyL1ZHZlJIbXJnYTFLdVFt?=
 =?utf-8?B?TnVUV0txcUFidUwxM0VDcEdEcEJrM1EybDVTb1huVnJ5MFBpTXpNeW9ST3dN?=
 =?utf-8?B?dzk5K0NJQ0M5ajQyMDNKK05DZGtNRG5DOFdxM0x2TUlnTk9oNWRTOFk0MC9O?=
 =?utf-8?B?QXQ0cHB4S2ZURGhCZGFxb1RsNGVQb1I3UHBLcGlSUEgwMi9BN29JMVhrMGVM?=
 =?utf-8?B?TVU4T1lsRjFYbWlsU2ZBSmRhQmxYdHA1dUNjb2p5emhSWVNpdW5iYU5GQU4r?=
 =?utf-8?B?aFhRWW1TaHgya3hPN2ZyVUlBY3oweTRBRTNiNUh0d0t4bk00VDkrL0ova0dZ?=
 =?utf-8?B?cG5vRm9KaTNpZkRNK0xqSEVyZnV3Y0plQmlkdGVOOFlGdjBUdUJGRk5UeGRz?=
 =?utf-8?B?bE40ZjEzdHM0cXAwejJLTGg4UHhMOCtneE9OVEhWU0pQV3MxS2hlY3VIMVRE?=
 =?utf-8?B?TVk2eFVIVGhrTnY3cmFURzQzL0paN1cybWt5TUwrb1ZFVnNQVHlicmYrRmxv?=
 =?utf-8?B?ZjJVT3dSdFpid2U1VVBvVndkemFTb3UxQy90WjNjSmNuTlFkYkhlbUVxUnFn?=
 =?utf-8?B?Ti9zL2Z1VFQvOE1BNE9TOTRBaHpTTW9odS9VZENTaEkrb0RKamN4U0QrYzJk?=
 =?utf-8?B?QnphVGRYZFJNKzhEOTlSMlFQYzZid0QxbUs5M3RkaEZINVA0RnM1S01QcGNa?=
 =?utf-8?B?L3lmczdoMjlPOUl6MnhwRmQ3YXpLb1RJN0pDMC9ZdVJwVUdNdDJDUFdrbWlI?=
 =?utf-8?B?cUVGdW95SkUyMnR3bmx6MDlCVlBaZ25iSzhTRWZBeDBIWXBCeEZCdDR5K0tU?=
 =?utf-8?B?MkFXY1l6cENhVXp5dGF6empiYllNUCs3NGxTOHovalhMbjZVRm10dUszMEVW?=
 =?utf-8?B?ZzV5QVpLV1kyWU05ZTBqYXp4ajZhNFAzbnFHQVdnYUY5c2hYMWpQM1hybFR6?=
 =?utf-8?B?ZCtzdm85RUlNZmNsalBwcmNXaitFOXlFMzh3NmFEUFNsL1h1RC9CSlNIdUd6?=
 =?utf-8?Q?w/ckPx?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6043.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WG9qUWx4V3B1UzNQVTA3dHN5QWtPMXR0QVFkVzVKR1NpMCtKaFdodUNJUFpS?=
 =?utf-8?B?cHNVSUZVa2poTWhFOE94NTEvR1BTMDA4aHZTenM3d2FpbVVFY3NnZ2t6ZUJ1?=
 =?utf-8?B?bThLZUFucXdzaENVaEwwdndoaTNoZ1ZqWFhmLzhxeFVmaGM5TTk3TDVjS0VN?=
 =?utf-8?B?SmlEWXFWa3RHY00rQlZINmIwMnp5TlAzdC9HbTJFWXJiazVBWUIzSlpkbW5j?=
 =?utf-8?B?UXJHZmpHUUluSStVeTJGRnU1b1JERlVNZnBZRm1iY1RiakVNV3NxV2l3V3hX?=
 =?utf-8?B?THRIM25vU1k5amRzc0VqbzFEOHp6YkdTelR5cXpPVmJRT0xYNExqNHFETFVV?=
 =?utf-8?B?b0ZDVWszRHZpWW56YzdUWkxMVW4veDZLcjJvOEVPL2xTN2E1SFRTSFhuU1Zu?=
 =?utf-8?B?RG1teVFnR3RXQmttbTc5emE3K2tzSi84aEJWREZNZzNQcUZOZXNGYVFpclMx?=
 =?utf-8?B?cEhOQ3dSWmNzN05tZmxvOW4zYXoyMFJWcnJsSGZlTmFQMVJWS281cFlBOGV5?=
 =?utf-8?B?TWF6Mzl4NzVQM0tuNEl3bUZQMzM1ZUxmYy9qK2R2MytVbitaUHJ5RUdsTEs1?=
 =?utf-8?B?ZUhGTTRPMGZUcXNYSG5ORlVSVHppamlsdWJoemVTS3NhUEpWZU1wM1BrdVZh?=
 =?utf-8?B?d0NlWkJHSmh0eWl6Rzl4M2paek8yRWplQ2hmVUNSVXp1NlFoMEM1ZWJ2ZUc4?=
 =?utf-8?B?NG5GdnlNcEJQVTZ2Z1o0VkRPMmNhV0xIRGs3VWpuTXpNZy8zNXlSSm1yREhj?=
 =?utf-8?B?ZXkxSTNmdkFkVEJ2aVp6aFhQaW9IdThaKzRPT0pGTHd1dHdpQ2FRRnJra2pT?=
 =?utf-8?B?WVFGOVcxM2pCWkVjYWY3eVhIMlJobUU5TTJXaHdib0dKMzZBYVN5a3lhRVVo?=
 =?utf-8?B?cDFPUDVxMWwvSXhTMXNUK2FTaGVxWjh3VmgwakRVUWk5cGI3cDhkbkdoMFQr?=
 =?utf-8?B?Wk4rSHJFTFBiT1BKbitrb3d2MDVsRnFLYk1FTTlSUmRhbGhHZTRJdFdQNXVZ?=
 =?utf-8?B?VS9mc0ZCdyt3Y2RQU0VCUGpXenhIS29ja0RwTzdEWFF6bm5VOGxDSnJrVnRp?=
 =?utf-8?B?aks3OG40TVNrZGxJOE1CcG1iSVRRSUNaOHJjVCthM0taKzdPZ0NPQmM5MzRY?=
 =?utf-8?B?QjJWOEVNdVl4d09xb3N4NXdJdHZYWm9tZ1I3bEdHbjZhenREcERCS0VJOGx5?=
 =?utf-8?B?cWNiVklnZ1EyUWpzdCt4ZHpxSUZGVzh3Nm0xTEhMZ1dPaFd6b0hqekErVzVQ?=
 =?utf-8?B?SmxidUZWZXI3b0lZaTM0V2VROTZxeDZhYmFsYTMzcWUvbGY1dGdwYTVrRTVr?=
 =?utf-8?B?NHE1cUp2SDlIempMUG9YK3RQemtsRE1SUHZKcnpuVjB2Wnl5V0xlUXhIdVVL?=
 =?utf-8?B?RXFQSm9DWk9QYUZDTTBMMzVxVUZtdWdCUnQ0N281UXA0WVhnaDRsTXhsLy85?=
 =?utf-8?B?Vjdhd1IxZlFVaXpkSFNhbExSc3JPbnFPMGFrVWNJQ0NQaktQYmVtNFArWWZh?=
 =?utf-8?B?T1ZIbFp6N1JYNFkwNlBEOWxxNDlhYWs3UHVXVHFHVVFrdHdmMVgyRzF3MWYr?=
 =?utf-8?B?RlZaWStsOER1TGdEazZqOEQzdTZHVDdyTnVycEpPb3hVSUwwZWlTSmxVblhL?=
 =?utf-8?B?c0hhc1p2eDdZVHExNm55VFhwOUxzcEZZWGxnSWlwZkdYVVZteDZmT2t4NFJU?=
 =?utf-8?B?cVF0aWpOb21POElsWGZINE45S1FkZit6N2YwYVZXc0lSZ2htYkQxTVdaNVRZ?=
 =?utf-8?B?c1BsREorTThERmo2RDNkWkVQRUJmK08ybHUzTHlRUk0zNXRMelBiZk01TXNO?=
 =?utf-8?B?WEE4a0VMdEw5UmdHcGx3V0FTWTNDaC9nb2R5MDZWUlkxajV1N0wwN1d3VDQ0?=
 =?utf-8?B?VDQxUXZCVUJ1TDV6MGROOEJpdXQzY2ZRMVJ5NTRSRGtkZGdKVGRzZ1hEV2py?=
 =?utf-8?B?M0tHdjJyR0NmZ2NLU1lNUGF2RkhRMXRQT1AzMFVzRTBHbTZnYTRqYi8zcUp6?=
 =?utf-8?B?UVNrQkNFVnI5Y3dQY3hQS2hrdHNBVnlPblZrc3Irdk55dU0vdjZEcGZNYXhi?=
 =?utf-8?B?Q3pIQlBVNWNSZ25rQkk4WjMwQkZqZlZpZHZaMlJPdEp0RzBvWWZOcEw3aW4w?=
 =?utf-8?B?MzMrc0RuSFV5ZU1xSThUNkxPckN2RGFrRXVyMUtSL2lxanNvRVo2enEzVlF1?=
 =?utf-8?Q?hy74a4St+BFHy6NgdezuM58=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6043.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ade496e-77fc-4328-4848-08de10648845
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 05:41:50.1665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UdHLITEawbgqonTwRjglcHiQdCG8t1WFU012X8NX29YGSw+ZeWVgiPj7+Qsm4bitaNgUJ8am4nUnoldFYwPDIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6413
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaGFubmVzIEJlcmcgPGpv
aGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAyMCwgMjAy
NSA1OjA5IFBNDQo+IFRvOiBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgPG1pcmlhbS5yYWNoZWwu
a29yZW5ibGl0QGludGVsLmNvbT4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9y
ZzsgUGVlciwgSWxhbiA8aWxhbi5wZWVyQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB3aXJlbGVzcy1uZXh0IHYyXSB3aWZpOiBtYWM4MDIxMTogVHJ5IHRvIG92ZXJjb21lIGJhZCBI
RQ0KPiBvcGVyYXRpb24gaW4gYXNzb2NpYXRpb24gcmVzcG9uc2UNCj4gDQo+IE9uIFN1biwgMjAy
NS0xMC0xOSBhdCAxMTo1MiArMDMwMCwgTWlyaSBLb3JlbmJsaXQgd3JvdGU6DQo+ID4gRnJvbTog
SWxhbiBQZWVyIDxpbGFuLnBlZXJAaW50ZWwuY29tPg0KPiA+DQo+ID4gU29tZSBBUHMsIGUuZy4s
IHNvbWUgdmVyc2lvbnMgb2YgQXJ1YmEgQVBzLA0KPiANCj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0
aGF0IGJvdGggUnVja3VzIGFuZCBBcnViYSBoYXZlIGZpeGVkIHRoZXNlIGlzc3VlcyBub3cNCj4g
KG5vdCBzdXJlIGhvdyB0aGF0J2xsIHJvbGwgb3V0IHRob3VnaCksIHNvIEkgdGhpbmsgd2Ugc2hv
dWxkIHByb2JhYmx5IG5vdCBtYWtlDQo+IHRoaXMgY2hhbmdlIGF0IHRoaXMgcG9pbnQsIHVubGVz
cyB3ZSBrbm93IHRoYXQgd2lsbCBiZSBhIHNpZ25pZmljYW50IG51bWJlciBvZg0KPiBBUHMgdGhh
dCBjYW5ub3QgZ2V0IHVwZGF0ZWQ/DQo+IA0KDQpXZSBjYW4gcHJvYmFibHkgd2FpdCB3aXRoIHRo
aXMgcGF0Y2ggdW50aWwgd2UgaGF2ZSBhIGJldHRlciB1bmRlcnN0YW5kaW5nIGFzIHRvDQpob3cg
bXVjaCBpdCBpcyByZWFsbHkgbmVlZGVkLg0KDQpSZWdhcmRzLA0KDQpJbGFuLg0K

