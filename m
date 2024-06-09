Return-Path: <linux-wireless+bounces-8720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 827D79014DA
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2024 09:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C691F21AA9
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2024 07:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE951799D;
	Sun,  9 Jun 2024 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6CG3Uaw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C933B28F0
	for <linux-wireless@vger.kernel.org>; Sun,  9 Jun 2024 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717918512; cv=fail; b=q/vZXxcoJdXgHwN3VnOHUrAdEwS97JD0MiutDHX6W+P4j4QVw1PF44rvtPGfWd2qvxNPh4zV4tuBItO3xeSEf44GxZyMjkWv32DtOZq0e6Kqve4/teY/pUjsuf6u3y71gqQzrK6vngJXSTqz1IjEj6GGTkeRUkVHzxotandKbvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717918512; c=relaxed/simple;
	bh=X8Gt8gVM1HAgCch7vW/IynRFzR9ZjIVhFsK0UpetC/Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D7FqEq6mHKDW3ss34lNasf2GDb6t/8g+F5na1qCP/DkqVvyy9C9sUYBTS8MMPJaFLSK5WS+ObdnhZQSFFp1UgzmLCssk/GjGvqRxPyT4qXLam/P6pmR4f8L0h/vETtlIIDsaau8sq21mX1mRjDUALJuLpQ5pIaIxJZV2zJyI//o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6CG3Uaw; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717918511; x=1749454511;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X8Gt8gVM1HAgCch7vW/IynRFzR9ZjIVhFsK0UpetC/Y=;
  b=E6CG3UawOVUSgB5+R9iELlXNBdfKmLd3WL8fV1WzvGDxDGFIxcI9o09i
   mmk0Fc1gaXciwY5AkNEQELrtL0SSCrY7mfWW8A8pTPuk7E/GswhepTrvr
   3ll0QIeSbX6eLgi+xToCX2N6GYSv5kZKnkI7Tep/oI0krdbsRjDiRsRWZ
   WBburNDQVTsySu3GR3DGXbP1HUwEBJ15sEOPukXLesjZceoR114aFCdzR
   BL85encmrliL6TojAC9njXejjRklQ3Yx42atgNn/WbLrRUUMjsIeUaRzG
   VlShsZ2eq+On6usket5L2YtMZK+hi/XvNi35fmvliW60TyRMInZ/o2u7c
   g==;
X-CSE-ConnectionGUID: xqmAotaUSICWsPmRWxquLg==
X-CSE-MsgGUID: at7Qgh2sSrq3bFDPnS2rRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11097"; a="18386356"
X-IronPort-AV: E=Sophos;i="6.08,225,1712646000"; 
   d="scan'208";a="18386356"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 00:35:10 -0700
X-CSE-ConnectionGUID: uVr3FhMvQqyvqiz3X+6kpg==
X-CSE-MsgGUID: zGqA56KARTSzKMZm98X37w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,225,1712646000"; 
   d="scan'208";a="39182019"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jun 2024 00:35:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 9 Jun 2024 00:35:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 9 Jun 2024 00:35:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 9 Jun 2024 00:35:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 9 Jun 2024 00:35:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8wiqHD10paqLP3f44YcselvZ/Ml7aOZm1c18mY4F0GQ1UON1UEZvZ+OwzNlDqr+C+6oCiAMCn3DBYkt4nE/DU9zrfir9fhDaM66G6vwFAKKQ2e2ilh2ArNRvjaf3GHKg7J5eDMA5o2Y0cPqCP5iPPtAaOdNSgn2i63uUTX8JgBJ9zp6sbpDY8Dc8I8A3O5AdYTKq9ADj1IhemHSq8dr90DYGmHzCxECidFhaWcES2IaA4I6UH4AAm2eMzDOfGi3QKAj/ucIzYlGwr2UJbcOiUdyY1ap6MsBIS+5Ps6qtGFP+RqLaf+Sd2TKrqm5WLwaKCi7RWx+06hj8OwGl/EIyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8Gt8gVM1HAgCch7vW/IynRFzR9ZjIVhFsK0UpetC/Y=;
 b=g4ItBQlMrHnO3PSNNpeA9T4LPubTrkKQSWAAKjPCdlpc3L3SxC8rIUWnGL/hWya0484ICFxhzb44fBWe2mMOBVc4mxdkyMp10WAXEIo0qb0bREggduJ42pV9MZEjGK4aQMRzGPleTZKmoPyzaG3qwoyuOC4/mu+OfK7VTved0uOpvsWJR1b0Tv5/hdJcHR90yEsteq5Y+IQ+OgrVoYMtzPSSHZOEMWfAIlOfwYDBGuaLxPVGZs2ZLeAzlCfm+bWX3fachk9aEriuP1eZOadzdlSEzXSbY/zI2bZRm9T1UV0zeizzii0GCiMy3rojL2fKTSruRrdWtfeX4IZk4EMKkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6043.namprd11.prod.outlook.com (2603:10b6:8:62::8) by
 MN2PR11MB4613.namprd11.prod.outlook.com (2603:10b6:208:26d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Sun, 9 Jun
 2024 07:35:07 +0000
Received: from DM4PR11MB6043.namprd11.prod.outlook.com
 ([fe80::4e37:abb:3577:fbf1]) by DM4PR11MB6043.namprd11.prod.outlook.com
 ([fe80::4e37:abb:3577:fbf1%5]) with mapi id 15.20.7633.036; Sun, 9 Jun 2024
 07:35:07 +0000
From: "Peer, Ilan" <ilan.peer@intel.com>
To: Kalle Valo <kvalo@kernel.org>, "Korenblit, Miriam Rachel"
	<miriam.rachel.korenblit@intel.com>
CC: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "Berg,
 Johannes" <johannes.berg@intel.com>, iil_jenkins iil_jenkins
	<EC.GER.UNIX.IIL.JENKINS@INTEL.COM>
Subject: RE: [PATCH 6/7] wifi: cfg80211: Add support for interface usage
 notification
Thread-Topic: [PATCH 6/7] wifi: cfg80211: Add support for interface usage
 notification
Thread-Index: AQHatzc0yb7T+43A3kaSl/T1R0ONJLG6eZjcgASS/AA=
Date: Sun, 9 Jun 2024 07:35:07 +0000
Message-ID: <DM4PR11MB60436A9107BCBC27294DBF22E9C52@DM4PR11MB6043.namprd11.prod.outlook.com>
References: <20240605105722.2034610-1-miriam.rachel.korenblit@intel.com>
	<20240605135233.23d15e758640.I7a62740a6868416acaed01e41157b3c0a7a41b4d@changeid>
 <875xummndx.fsf@kernel.org>
In-Reply-To: <875xummndx.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6043:EE_|MN2PR11MB4613:EE_
x-ms-office365-filtering-correlation-id: e5331d1d-e23a-4380-9300-08dc8856af86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dG5RWklPN01hQkZnL2t0b2dFMS9KQWx5MGx4ZEV6WGJraUJyMFZjZUtqaGpm?=
 =?utf-8?B?cE54cmM1emVQV3BkVUFtQlpmcmZvMDJHT2ZkNllQUDdPejFGMU9LQzJZMDBp?=
 =?utf-8?B?T0h3NFF5aHc2WWpHWDlvQ0lScnpSbDZBU0pEKys2dllzZWV4SS9PNml5SEZV?=
 =?utf-8?B?N1B5ckQwVnU2Y0FHZWlGN2RQaXY2QnM0em5BYkp1Um8ycGlaQ2pIVjkwbVVk?=
 =?utf-8?B?c2Rock1IY0d3WThoRFh3ZjFnZndTVmRabC85cUhHTyt5NWN2WUxmUEMyQjRS?=
 =?utf-8?B?Zk9zbTN4Z2hRVXpEWWplL2VvT3pLeHZYTWJ4amk4NnlCQi9UTWRPdm5Hc2Q1?=
 =?utf-8?B?MzVDcnJ2OVd1MTBPdlQyZlIvS1VCcnJvUnNyRG44cDNobFBUdHQ5NFhjRkVY?=
 =?utf-8?B?Mk85TlVlZGQ1WHJ1ZklEcVEwMkFuS3dkT2laRVJSck5JRlkzclZBUnQvWk5p?=
 =?utf-8?B?QmlremZWQmEwWTFSRXJ6SHIzM2JlbjF3YnlNQXdHY0Mwa0I4QVJjN0RDWDhH?=
 =?utf-8?B?dTBpWTMxUnk3K0gvZWg1STdmYmJVQ2JRaUZRclVCaUxKN0IzbVZvZVVQRU5D?=
 =?utf-8?B?aXROa0ErWENKR1BYR29ObW5ZYlJVQTAzclBJakFwbGFzbWMxdmV4TDRCQi9E?=
 =?utf-8?B?QlBRakU1ZVc3aTlPaFBaZmZKWDdWd281VDZ2dWdZYjdBMzlTUkdjTmk5clNs?=
 =?utf-8?B?KzdoeFZBV05IL0xwaDlndUNiMzd4Y3RwUUdsakxxcU5EWHRJL3Fxd2plSXZr?=
 =?utf-8?B?azJyWjhzV1hpdlN4a1hHbmlUTFpYUVV1UlMvc25qbExkN2VITnBWNW03ZVcz?=
 =?utf-8?B?OXA0ei9VcjZ1RGsvVUhVbXdETTk2bEI2b25Pa3JPcW1PdWNYTlVybXk4WGZ3?=
 =?utf-8?B?MEpib2VHUWVuYkUzYzI0cU41Q3Y0NTFiU1RkbzhoeEQzMEcrSnA1a25CN2pp?=
 =?utf-8?B?Y0krNVVCalZzc3JEK0Jib0hQT3RvVXlRMkhYTS9BYVFPTmxnNUhJZi84MDZx?=
 =?utf-8?B?RlVtbWZtMVJrM3pQNmxHVmUvS3V4emJLQTR2OGd6TjFndTl5OWp5VHV0aXpD?=
 =?utf-8?B?U2xwZUhVNjZjMUZRMU5QMEl4c2ZPTlNzRFdVVjlRN2o3dk05QkxzWFI2aHdC?=
 =?utf-8?B?M3ZTdDdUalpoZHJhOXRhVFp5VThTNFhTSjJjN1FjS0g3UmRSRzhYeTd6UEMx?=
 =?utf-8?B?QnNaeHR5U3VPak1FWHltR2MwUTdMTkVxYzNzczVxbEhEYVoyM1BFdkZ3NEtP?=
 =?utf-8?B?S2NwUjl0R09iUGx2bTNVVU1lTnc3anRPaVJjQXpUaUVCVHpxMGlkb1BCSytM?=
 =?utf-8?B?QTVGRVhCc21sdEZpSjJwMXMzNkZrVGVPd0dzU2tHekhHcUk0WTJsN09NbWM5?=
 =?utf-8?B?eWFIV0VlTDN1aGVyYThpQ1BGY2d3SGNhdDNmUlVTU2lRMG9oazJESklwblc2?=
 =?utf-8?B?NW81MjVxa05rN25NbE5UM2ZibVRIbmVhTUZ1aG1RMjNrcTJsY2hiSnp4ZnEz?=
 =?utf-8?B?b1RGOTNGdFVyMGU5YUZWL0lTMXlNRWZFanFnUkkza1EzUmdnTlhkdU5OYnUv?=
 =?utf-8?B?eDdSTmUvbVU0UldyRzN6WWN0TmlobFdDRzJxR1ZrVEU3cnM0V0JCUm8yaCsw?=
 =?utf-8?B?YUc0RGgxM2pOcHJHOXFWQ3o2NlZYSDNOaWVNbmNpZDh2Q2wzaGw3L01xaDNw?=
 =?utf-8?B?U29aVkRVZ2JZR3J3T0JWc3VkUUx0dys3aFBENTlRbFJiODZGZC96YjRycWtv?=
 =?utf-8?B?TFhVT2czZWIydWRka2EwTndtdXZkalNkWjZLamZQd3NZa1J5UDV2ZExxbmhI?=
 =?utf-8?Q?Xq79IUh4kluzADN6NSybNJ+63N/N+458JiBPg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6043.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bU1oeHlUb3BlTklRM0I4MG1ZMG1jenRLcEEyWWo2R0p3M0ZkK1JBT2hCY1Nh?=
 =?utf-8?B?Tmx4QVArTUVUSGtXSldMcVdFSGVkOGFiSWhlNUFVbTlmTVA4c3R4OWxVb0Qy?=
 =?utf-8?B?aXZtaXpOenBCNDRZb1NPais0S3JpTnNUUHBTS0J6UDN0TzVzNnMyTDcxK0VM?=
 =?utf-8?B?eElOWEtZRDl6OHNkRnQrK3BPK2Z6VlU3RzlhUWpDcTA0WVFmM1VJZm1nd0Ji?=
 =?utf-8?B?UFR2MVBJaVd6cnBRVUE0SjhpNlZ5VFU4ZzJTWDB0RnhTM0s4QkdHYU1EbkNU?=
 =?utf-8?B?YUZza1J6TjRRSlFRNW9KRnNwdm5CQXl4b2h0bHFnUWorUnBCMEhBRnIvajE3?=
 =?utf-8?B?WDZFK0xFeTNkcXloY3QxeStNNTUvbFoxSDFHb3c2YmRydFgzTWFNdkozbU45?=
 =?utf-8?B?VUpPVGV1VHFpVGJqd05jOGNVQ2VKNjZHV1JmZG5jKzl4Z3JxNERyOXduVDZo?=
 =?utf-8?B?ZU9UZjZSc3hvcW5XbkYrNmNuL1R1TjJ2bUd4VHhJbTRINTBESFV1SHhkeWNS?=
 =?utf-8?B?akdCNkt1b0doUm5jVDMrWm9kM1ZxT2VpQ2RMcytVdFBoZk9YWlRiQjE4MHJ1?=
 =?utf-8?B?eVBvVnZ3K2VGZDBQZ1g4djNaWVhRc1J0SkRqczlKWWZiNnBPaVV0RWpzcmpy?=
 =?utf-8?B?bmhVb1VWT2lJbFpOTC9BKzBkQ1VyN2M3NzVvMnh2SnNtWVlVcVFNc3VFZXZm?=
 =?utf-8?B?Q1JJUjdYdFNaZm1yQlh5NkNtQjg3b0VReGwwQTlsMkgwMEE3djBPMTNUNGJz?=
 =?utf-8?B?MWVocGY4Y2lraHB6S1ZXaHJYL1VIOTZ3aWJUaGNzWk9wUG8xbUxoNHRkOHB2?=
 =?utf-8?B?ME9JU3ZPTWRuOSs2dnlTdS9wM3p3WmpsUDBxVy9mYWNzdVpFcXpxQ25NY0Vn?=
 =?utf-8?B?WUhSNVFEWFBlSjhDMTNOZWJyNjVDYnlwWkZ4eElFeWgvdm1vRFZmQ1VPcUVu?=
 =?utf-8?B?aEdSS0REeld4S3R2ZTNuV2lFVGVJek9VajF6d1NRZi9zcFVtenRmMDBtc2VF?=
 =?utf-8?B?NEFkYktiaWlXcng5a0hxUE5nYms2aU8rUUxIbkV3QkM1TmxkQy9ScmdJRndN?=
 =?utf-8?B?UUdPaEdtREVhaHV3QnFtVlhSaE1pYXV1b2psL1cxRXN5NVFsUldSUnJ2aDA1?=
 =?utf-8?B?YkJRcnZJQzh4Q05OdXFpcC9zRFhqWGswUjBvZGREYXUxOHdRVGRUUldKQmNk?=
 =?utf-8?B?blp3U0hpNE9ON1pFbk9JanRwalJRS0srWEUvckRXYkZVc3NHaGNkdWJOK3hV?=
 =?utf-8?B?WFJuZkVPbzZ3Q1d6R2duZTBjZzZvcm5ZN3V2T0d3cU14K3hPU0Rna2pEMUw3?=
 =?utf-8?B?b2FWUFplK3AxaWdMTmgwc09VSzZvY3JLWHliR0VKQzl3d3VJaEtISk1GdXVO?=
 =?utf-8?B?dGhPWGxDSHRjVDNLVUkyNkRLZllya0lKUitqdk5OV1MzUzJQanRFNzlKYzlC?=
 =?utf-8?B?OVZIRFU1UHhvT0ZxVlFYT091NU5rR3RsZnppRi9EOE5xSFIvRldxYnRpemNB?=
 =?utf-8?B?SUFWMFhJdVJOUnV2UDVmNkw0NEhBcU5Uc1gvek1yNXlNcFBrZ2ZiMENmTkZW?=
 =?utf-8?B?TkpOMDFNYm1oYUtHVlJHMDJ3aHNIV2pGZjl5bVdIb1FLRlhqME91ekJYK0hV?=
 =?utf-8?B?Y0hjN3o2ZkNGdmZNZ29uL2V3QXY2dnQvL0JhVEJiZkRzQVRvb09GNFhRa3dv?=
 =?utf-8?B?Qnp4WFFnd1hoMGxmMERkaExIc3JwaUhXRHpRckdiWmNGTUI1VllUbXk1L3hk?=
 =?utf-8?B?NkJDYk9WY3BBdzFZL01kVDRaRlJwZStMWXhRRFJCNmVHczVZamt2YWJhSlAz?=
 =?utf-8?B?bDl1ZVk5ZG9QSlY3RUZmZzY5eGhQbFBpZEtiZXJybTh2YmxYYUd0VGtVNXVj?=
 =?utf-8?B?eWVxTDZqRDRXYkRoWFhTdnpKLzRPck96bjdzREwrNHlmWTNIOVJ5dldXUlhM?=
 =?utf-8?B?ak03VnZHS3BzTnFQZ1Y0OHhCOEorSng4V3N1T0hMdDRQVk90MFFtSGJ3NnA4?=
 =?utf-8?B?SitHN0piaFlkZk00UDZ3eDN1YzZpR1lHRnpYUWZSNVNvT3E5alp1RFU0QWQw?=
 =?utf-8?B?WkIzNWxwTzJYS2RJL2Z6eVpuSlQwZ2s0SEJPNkQ2TTk5NFVzUmFTeWN0cVJJ?=
 =?utf-8?Q?HObSZLv+ZSj1Cua7pymew4k/B?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e5331d1d-e23a-4380-9300-08dc8856af86
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2024 07:35:07.2736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A0xpU7RL7Pee/xY2IhtBTllTEIs/vi5NUFwkeUycfpWpYIIDbtnYE67SF1zcosMGJZrPFlCSfndT6x7w0cr3qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4613
X-OriginatorOrg: intel.com

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2FsbGUgVmFsbyA8
a3ZhbG9Aa2VybmVsLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIDYgSnVuZSAyMDI0IDEyOjI4DQo+
IFRvOiBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgPG1pcmlhbS5yYWNoZWwua29yZW5ibGl0QGlu
dGVsLmNvbT4NCj4gQ2M6IGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ7IGxpbnV4LXdpcmVsZXNz
QHZnZXIua2VybmVsLm9yZzsgUGVlciwgSWxhbg0KPiA8aWxhbi5wZWVyQGludGVsLmNvbT47IEJl
cmcsIEpvaGFubmVzIDxqb2hhbm5lcy5iZXJnQGludGVsLmNvbT47DQo+IGlpbF9qZW5raW5zIGlp
bF9qZW5raW5zIDxFQy5HRVIuVU5JWC5JSUwuSkVOS0lOU0BJTlRFTC5DT00+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggNi83XSB3aWZpOiBjZmc4MDIxMTogQWRkIHN1cHBvcnQgZm9yIGludGVyZmFj
ZSB1c2FnZQ0KPiBub3RpZmljYXRpb24NCj4gDQo+IE1pcmkgS29yZW5ibGl0IDxtaXJpYW0ucmFj
aGVsLmtvcmVuYmxpdEBpbnRlbC5jb20+IHdyaXRlczoNCj4gDQo+ID4gRnJvbTogSWxhbiBQZWVy
IDxpbGFuLnBlZXJAaW50ZWwuY29tPg0KPiA+DQo+ID4gSW4gc29tZSBjYXNlcywgd2hlbiBhbiBp
bnRlcmZhY2UgaXMgYWRkZWQgYnkgdXNlciBzcGFjZSwgdXNlciBzcGFjZQ0KPiA+IG1pZ2h0IG5v
dCBrbm93IHlldCB3aGF0IGlzIHRoZSBpbnRlbmRlZCB0eXBlIG9mIHRoZSBpbnRlcmZhY2UsIGUu
Zy4sDQo+ID4gYmVmb3JlIGEgUDJQIEdyb3VwIE93bmVyc2hpcCBOZWdvdGlhdGlvbiAoR09OKSBh
biBpbnRlcmZhY2UgaXMgYWRkZWQNCj4gPiBidXQgb25seSBhdCB0aGUgZW5kIG9mIHRoZSBHT04g
ZmxvdyB0aGUgZmluYWwgaW50ZXJmYWNlIHR5cGUgaXMNCj4gPiBkZXRlcm1pbmVkLiBUaGlzIGRv
ZXNuJ3QgYWxsb3cgdGhlIGtlcm5lbCBkcml2ZXJzIHRvIHByZXBhcmUgZm9yIHRoZQ0KPiA+IGFj
dHVhbCBpbnRlcmZhY2UgdHlwZSwgZS5nLiwgbWFrZSByZXNvdXJjZXMgYXZhaWxhYmxlIGZvciB0
aGUNCj4gPiBpbnRlcmZhY2UgdHlwZSBldGMuDQo+ID4NCj4gPiBHZW5lcmFsbHksIGFkZGluZyBh
biBpbnRlcmZhY2UgZG9lc24ndCBuZWNlc3NhcmlseSBpbXBseSB0aGF0IGl0IHdpbGwNCj4gPiBh
Y3R1YWxseSBiZSB1c2VkIHNvb24sIGFuZCBhcyBkZXNjcmliZWQgdGhlIGludGVyZmFjZSBtaWdo
dCBub3QgYmUNCj4gPiB1c2VkIHdpdGggdGhlIHR5cGUgaXQncyBhZGRlZCBhcy4NCj4gPg0KPiA+
IFRoaXMgbmV3IEFQSSBhbGxvd3MgdXNlciBzcGFjZSB0byBpbmRpY2F0ZSB0aGF0IGl0IGRvZXMg
aW5kZWVkIGludGVuZA0KPiA+IHRvIHVzZSB0aGUgaW50ZXJmYWNlIHNvb24sIGFsb25nIHdpdGgg
dGhlIHR5cGVzIChvZiB3aGljaCB0aGUNCj4gPiBpbnRlcmZhY2UgbXVzdCBiZSBvbmUpIHRoYXQg
bWF5IGJlIHNlbGVjdGVkIGZvciB0aGF0IHVzYWdlLiBUaGlzIHdpbGwNCj4gPiBhbGxvdyB0aGUg
dW5kZXJseWluZyBkcml2ZXIgdG8gYWRqdXN0IHJlc291cmNlcyBhY2NvcmRpbmdseS4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IElsYW4gUGVlciA8aWxhbi5wZWVyQGludGVsLmNvbT4NCj4gPiBS
ZXZpZXdlZC1ieTogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXMuYmVyZ0BpbnRlbC5jb20+DQo+ID4g
VGVzdGVkLWJ5OiBpaWxfamVua2lucyBpaWxfamVua2lucyA8RUMuR0VSLlVOSVguSUlMLkpFTktJ
TlNASU5URUwuQ09NPg0KPiANCj4gVGhpcyBuZXcgY29tbWFuZCBqdXN0IGxvb2tzIHdlaXJkIHRv
IG1lLCBkbyB3ZSByZWFsbHkgbmVlZCBpdD8gSSB3b3VsZA0KPiBleHBlY3QgdG8gc2VlIGEgd29y
a2Fyb3VuZCBsaWtlIHRoaXMgaW4gb3V0LW9mLXRyZWUgZHJpdmVycyBidXQgbm90IGluIHVwc3Ry
ZWFtLg0KPiANCg0KQXMgZGVwaWN0ZWQgYWJvdmUsIHRoZSBuZWVkIHRvIGluZm9ybSB0aGUgZHJp
dmVyIGFib3V0IHRoZSBpbnRlbmRlZCB1c2FnZSBvZiB0aGUgaW50ZXJmYWNlIGlzIHJlYWwuIFdl
IGVuY291bnRlcmVkDQpzZXZlcmFsIFAyUCBjYXNlcyBpbiB3aGljaCBhbiBpbnRlcmZhY2Ugd2Fz
IGFkZGVkIGFuZCBQMlAgR3JvdXAgT3duZXJzaGlwIE5lZ290aWF0aW9uIGFuZCBQMlAgSW52aXRh
dGlvbiBzaWduYWxsaW5nDQp3ZXJlIGNvbXBsZXRlZCBzdWNjZXNzZnVsbHksIGJ1dCB0aGUgUDJQ
IEdyb3VwIFNlc3Npb24gZXN0YWJsaXNobWVudCBmYWlsZWQgc2luY2UgdGhlIGludGVyZmFjZSB0
eXBlIGNoYW5nZWQgZnJvbSBQMlAgQ2xpZW50DQp0byBQMlAgR08gYW5kIHRoZSBsb2NhbCBkZXZp
Y2Ugd2FzIG5vIGxvbmdlciBhYmxlIHRvIGFjY29tbW9kYXRlIHRoZSBQMlAgR08gb3BlcmF0aW9u
IGR1ZSB0byByZXNvdXJjZSBjb25zdHJhaW50cy4NCg0KV2l0aCB0aGlzIG5ldyBBUEksIHVzZXIg
c3BhY2UgY2FuIG5vdyBpbmZvcm0gdGhlIGRyaXZlciBhYm91dCB0aGUgaW50ZW5kZWQgdXNhZ2Ug
b2YgdGhlIGludGVyZmFjZSBzbyB0aGUgZHJpdmVyIHdpbGwNCm1ha2UgdGhlIHJlc291cmNlcyBh
dmFpbGFibGUgZm9yIGFsbCBwb3NzaWJsZSBpbnRlcmZhY2UgdHlwZXMuIFdpdGggdGhpcyB0aGUg
aW5mb3JtYXRpb24gZXhjaGFuZ2VkIGR1cmluZyB0aGUgUDJQIHNpZ25hbGxpbmcNCndvdWxkIGNv
cnJlY3RseSByZWZsZWN0IHN0YXRlIGFuZCB0aGUgUDJQIGdyb3VwIHNlc3Npb24gd291bGQgYmUg
YWJsZSB0byBiZSBlc3RhYmxpc2hlZC4NCg0KSSB0aGluayB0aGF0IHRoaXMgY291bGQgYmUgdXNl
ZnVsIGluIG90aGVyIHVzZSBjYXNlcyB3aGVyZSB0aGUgaW50ZXJmYWNlIHR5cGUgaXMgY2hhbmdl
ZCwgZS5nLiwgd2hlbiBzdGFydGluZyBBUCBvcGVyYXRpb24gb24gdGhlDQppbnRlcmZhY2UsIGJ1
dCBiZWZvcmUgdGhlIEFQIGlzIHNldHVwLCB0aGUgaW50ZXJmYWNlIHR5cGUgaXMgc2V0IHRvIHN0
YXRpb24gbW9kZSB0byBhbGxvdyBzY2FubmluZyBvcGVyYXRpb24gZXRjLg0KDQpSZWdhcmRzLA0K
DQpJbGFuLg0KDQo=

