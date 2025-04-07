Return-Path: <linux-wireless+bounces-21183-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B433A7D464
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 08:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFEAD188A0C5
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 06:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717CD2253E9;
	Mon,  7 Apr 2025 06:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C0B1gOzf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1132253F9
	for <linux-wireless@vger.kernel.org>; Mon,  7 Apr 2025 06:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008201; cv=fail; b=CN4M4juLL4pORURtGdtfd3XJlRBrKgtkPQ9c3Mexw0EwXdT0l5JcRsmhOcAT18fSMsLsviWTqu4wmfrnaNrJwkX+bfEgg/pZnRZm2jVFvndax9PTJGACTG1ThYP3jpnZQloyPhE/uogoCPJqQ9DhcANCP2CoQMjU/QeoJG0nCIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008201; c=relaxed/simple;
	bh=j6rGNQgyW1W5YoeA72CUmahNN0hps8y804ddGpsvAFg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HHvI5eh6D8hRDzytyKMZjZIKXVhzK7f4pKCfhsCTvu1ahUDw7QavrvDlc1/GzdG+z8MJfpRo1wEKXQOPI4jRAtfcP+cXUaqD9zpYzmpwT8xkkbCI4U8/G13L7psmOJXvHb67mbF3DShHNwG3Eby+Wa9HtDuteHLEtQei8eTC42Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C0B1gOzf; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744008200; x=1775544200;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j6rGNQgyW1W5YoeA72CUmahNN0hps8y804ddGpsvAFg=;
  b=C0B1gOzf/tDLbAxIibz0KxEKi0CsGmeqD5JromwsJ1AveI9kNNvXAGju
   S2wE4Bz4ygvzfMS8SEfkEmkbb6MI/8VGBzri+3a7C1oopZYN4myyRJ7m7
   9Q+/I3Jxg65pEiUnsUn6aapf18tX1oa+d6RB8/zqcZyvXT1Jd0wTtPfSt
   KUe8Q83c4pD1slSKiUQ3bJ/m20u5cP6dwGZfCRUybelao4XSnC7VtiVjb
   V/oPLLXGvezU3kMbTdsY+QotnP7ly97s8GVVXVj/tzaPw8TkjQ9H+PSkO
   EN+EcVRU/goz8UX9GY+n8Y2QFJeMvzVNd+62uWTAxVIyjbSJqfZm4f4jv
   w==;
X-CSE-ConnectionGUID: GR41Tp+0QG6dy2WZz7SssQ==
X-CSE-MsgGUID: aIRHe1y/TCGNX7PXwUcYIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="56356078"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="56356078"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 23:43:19 -0700
X-CSE-ConnectionGUID: a+fruvOYT/mm93mpIZ9Tzg==
X-CSE-MsgGUID: CGqV9078TNeTJ1Vq5HtD5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="128361858"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 23:43:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 6 Apr 2025 23:43:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 6 Apr 2025 23:43:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 6 Apr 2025 23:43:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tys1/N2eaJ2QstDT5sw0OfhR+nVsX2Pdir0bMnNxt4CxvAhO0sfWeXVnVVZ37EcHE9n3grRv0ywWLzzzIjPzVzBe/na5FNZb2jLfah09WDK2cMInF8zZoESPRsht1wyP06LNB1nZ+2hVrzDXwLHIAa40eKt/BoPsxNFp1Ayoc05MRuGhhqqBHF8JCTRgKQsihKlqjCX+cz81fhEkFhyitJeY9fj/2We+N/EWSRdtToHLauFD/iWSOi61KafVfXPQ8QbELldMMuBi1UrCeMtJQjhfO9b4VYau3RdKIXZWi4DkwWgnsga08iHjKSV91Sc0jYLaBRlX63h3+EggFkiWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6rGNQgyW1W5YoeA72CUmahNN0hps8y804ddGpsvAFg=;
 b=lUqPBMaimfzdOeTmxzoNWgA7PznK4qW+bnkp3V4mNuFPQ7i/ykE81w/+qQx2gPoJNtuQzfoJN1B1Nd54ovjikQzrqtmO5eZtZf2vxc5i2eeRPJ3YbjzCbXxqIPzbQTmdrsI4Aofmfu8LGPc7jhI8n6QUk5KwKYaLHEMwzVPWOEiou2Vh78DhKennkD/sA71ARWw47SWa3xnTdqmnrKxWCvIMFk1DWjYHvcHAO96hI9xl1KNEcJ8H8yzRfSvGcXYq52LdMVtP7THfEXBxp1u2LTPjGL+BWriGtxGlgD5NtkgCKpQIb5evvrkWmjSdu5GagZ9WHDCZKiUxdooMjgj7iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by SN7PR11MB6680.namprd11.prod.outlook.com (2603:10b6:806:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Mon, 7 Apr
 2025 06:42:47 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%6]) with mapi id 15.20.8606.027; Mon, 7 Apr 2025
 06:42:47 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Lukas Wunner <lukas@wunner.de>, "Berg, Johannes"
	<johannes.berg@intel.com>, "Grumbach, Emmanuel"
	<emmanuel.grumbach@intel.com>, "Berg, Benjamin" <benjamin.berg@intel.com>,
	"Ben Shimol, Yedidya" <yedidya.ben.shimol@intel.com>, Arnd Bergmann
	<arnd@arndb.de>, "Stern, Avraham" <avraham.stern@intel.com>, "Gabay, Daniel"
	<daniel.gabay@intel.com>, "Anjaneyulu, Pagadala Yesu"
	<pagadala.yesu.anjaneyulu@intel.com>, "Triebitz, Shaul"
	<shaul.triebitz@intel.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2] wifi: iwlwifi: mld: fix building with CONFIG_PM_SLEEP
 disabled
Thread-Topic: [PATCH v2] wifi: iwlwifi: mld: fix building with CONFIG_PM_SLEEP
 disabled
Thread-Index: AQHbpvoMjZjUtwDLbUG8nOtsdV6UnbOXwlng
Date: Mon, 7 Apr 2025 06:42:47 +0000
Message-ID: <MW5PR11MB581086E3DEFC1D6710892E68A3AA2@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <f435bd9c8186176ffa12fd3650fac71cacdeebe1.1743946314.git.lukas@wunner.de>
In-Reply-To: <f435bd9c8186176ffa12fd3650fac71cacdeebe1.1743946314.git.lukas@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|SN7PR11MB6680:EE_
x-ms-office365-filtering-correlation-id: 3a34a072-09a6-40ba-ea7b-08dd759f68c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?cWNqNUI3cHNGZmtGaFdXNk5iS0kyVjNDWnNPbXNXNnlDd0ZOaGRyWUNCSXpU?=
 =?utf-8?B?UytPblltV3V0VGFGaVJ3VUEySEVPWUgxSStZRnpxSTNCR2hLN2p1Rm5mZks5?=
 =?utf-8?B?V2VEUmd1NU9QTDk1NG9kaHNqaXdMbXI2cXVCL2R0SVl5Nk4zczFoSXJTa2VO?=
 =?utf-8?B?cHRJRGxxSHBJcHYyTUJUTXl3UC9PWkJwajdDT0FsanBFUWlhL2ExT0JiQzUw?=
 =?utf-8?B?ZEZtMHgwRm92eitYMGtIY3JJOStibnBHTjJRY1E2RjJkT1oyMEx6a0dZVU5S?=
 =?utf-8?B?ZXhQTCtBRUt0Z1l6djdZUVh1L25wTUpxSjVVVHVEZ3hiaWsyUDBrOFBSNEJQ?=
 =?utf-8?B?VEJGUGl2T3hiMVF6amtHa2RaOVc0U21qSnkvWkIxS3hRdTZtTFFUZWlaUkc0?=
 =?utf-8?B?RG1VeWxHb2U1OXZNSVNheHBsQnBMM21tQmw0ZEh5dmlHU3RnM2VQMW9DWnds?=
 =?utf-8?B?cjNVTW5ZdmIxeFoxK2pRR3lHZmlBTVZQdERpQ3FjV0c2ZHh2RTZadk15Tzhn?=
 =?utf-8?B?ZTN5K3Y5RGdPYXhiSDM3ZkVuMGxkb3M3MlhQZjI2SmxTcXNRRWRGT3hlWUti?=
 =?utf-8?B?b0Y5S0ZxUDFaNzcrTHc1WS9QcnV4RUxpVHc4R0lFaHRlWkdUYitsWGh3aEJN?=
 =?utf-8?B?SGF0ODFRYzRQU2dmWm02d3NBaStySzNweHh2MGlsR1FhL1haZ3R3cGZIc3g5?=
 =?utf-8?B?VThwbXE2L0kwV2F2VWdyaGFidkV4ZTV0Zko2N2VuZkVsZ0hVVGFzTTFYWVNI?=
 =?utf-8?B?ZVJDNjVreVdoaVRnREdNUThBVWV1VHhpdS9mZnBUSGVaSCt0NnBCNjh3bmln?=
 =?utf-8?B?UWhsMmtaQ0NSSHN5SHRwS2VsMkxIVGZpYVk2bzhIS25vRC9xckZ4RUlYVDl4?=
 =?utf-8?B?VHdYYXJYd1hJV2hhNzgwT2F2aUo3dmVnQlAwVmhwbGRPRU9WYWJjNUNwZGFQ?=
 =?utf-8?B?T1NCR1JmV2pLQVlBTjRRa0NuZWJkWEp5WmtuNklMRE5kOWxaK2NjMEJudmRy?=
 =?utf-8?B?b2QyVGIvNlV1Y3g4MkJkZ2xhRkRKQ0pqb040VlJ4NmgrRGVOalM0aG9Fb2ZK?=
 =?utf-8?B?cWlqQkV4YUVnZmtzWHM0Rnh5L1RNRkVmOWpGb0YzR1o0bFViY0RsTXVvWStL?=
 =?utf-8?B?VTdFQW10Z3l3VGFpQ2F3b0Q3Wm5iSzRHUEpnaUVENktwY01YY0VWYm91M0Fv?=
 =?utf-8?B?YkJJeWZjaEZlVW1CZ0FyNkp1clNuWDZmYWg1ZDNXdEZRVnZVK3ladmhZUDBN?=
 =?utf-8?B?YTN3cTkxcEwvWG53eC82SEhEWGtFcnVjd3FsNFpMU2Z6ZGxBd28zQ0FPOUh4?=
 =?utf-8?B?N3NadmFSWHV0NXFKK1l0VjJiUFhxdU5RUFA0WWlKQ3o1UVdEbmxyWE5zM0tH?=
 =?utf-8?B?ZUVleTB0ZlM0dnJNS0hoYlZtVjJJaDloWk9vN0t5TWl5WW5DcUtOQ1hDdXZL?=
 =?utf-8?B?dlgyR0t2TWZLZjNjaGNLUkcrTmZaRXBuRFdpdkFXL0t1enlPNmxIaThoZ2RU?=
 =?utf-8?B?Z1RjMGNMN1dxZjluWHJZanE5dTRrM2s0Nm9aWUpGL0ROSlpseW1kVzhoVTlr?=
 =?utf-8?B?K0Y3OVUzQTJOTEdWcER6Nm9uZFJ3R1U4TDkwT0VFeFlsSU44cmVQSUpaOHVp?=
 =?utf-8?B?TzZkSmVJaUVlS2p5TFk3RnVKSVFtR1AvWVdBVSt0VUdZZHlGenp4UUM3eVpV?=
 =?utf-8?B?S29mOFhoZE5kMDBvNHV0VjFFSVFoRTBkditwODdKTkQrYkg5VWdzV1pOdHdo?=
 =?utf-8?B?K3d2L1dNeFZmbU1UZkpKc1Y2WEVVSzdjUFo5dUVMdjJnczBPQS9XSjlTa0hx?=
 =?utf-8?B?eFBxYkVEN3FEU3JudWZhb0w5RnZwOUhRbmUwS2pVSU5TY29ZUVQ4WTA4S0xi?=
 =?utf-8?B?cCtsS1NpQldUWEZnek5IV0E1UE9nUDAwT09NUjdWRWpYRE9Fb3NuZ1NzKzlG?=
 =?utf-8?B?M2lHaVpWVHhCL3A4VGtVZVVoakdVVG1wNjU5M0NUWkNUbWFRTDlUd2FwWERN?=
 =?utf-8?Q?C1eiutuXGmXTg3rKEDPanDnEwuDQpc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjQzSS9MN3JYMGhOWU54SlRGQlA5T1lkWGtjeEx3OFN2Q0JGTFRCNkdXUnNS?=
 =?utf-8?B?bTlWWU1kZ1M3RkVMcHltVi8wZGZ6VUZqN0RrZzVWVEFJSS9MVEZzdFhKS2Q4?=
 =?utf-8?B?UWp4K3paTWhFTGlPRk0yVmpZSUNQM3pidk5YM2JyOEVza3pUWFVOZUY2UXBR?=
 =?utf-8?B?WDl0d1RpRXM5aTJQZFg2RUt5ZUZ6MTJpb2ZjV2RSRXgvOFZsdFBNNm1wMDRS?=
 =?utf-8?B?RC9KRUpYR3A2cUhyOFdhN2cvbjBJVGhqQlJJN0RuamdLZzlLTlppZWd2Y2cz?=
 =?utf-8?B?WWs3TGNMcS82eFNCdUc0V3o3Q1psMmhaMzFsa1hlQU8zRk5sMmgwYm83ZG01?=
 =?utf-8?B?b1NaZWx4UFNOdjFnUmtRRGR5SVV0cFF5Y1NOU2FFN25Pd0hnZnhsODgyMmIv?=
 =?utf-8?B?RjI2TDRmcDdVcmFsdlZrU1JvTUdzTDdqQkFpZjZRVHZUWk8veVFVRjFQV2Vs?=
 =?utf-8?B?SU1Cdk9IOFhvM3QvaVIyZVJhc3JUekJ6dThNaHdkM1BBOG11aHVVWi9yZXhD?=
 =?utf-8?B?THFxN09RYmlRazY4dDhvaGpJMUMxMFpucWZ3eXU4NnBlbHNFNUtOeFBJcjNk?=
 =?utf-8?B?OU9Yc2toZk8rYkxCTWpqaE93UEtzSitTUkJsM2xRR1FETFZMSElXeXI0MHJ6?=
 =?utf-8?B?UjNDZGkrYmJVaG5ZNHMxaUdnUFJNVjMvK3RGL3V0YnlrcVNPVDNCbkNkSDhq?=
 =?utf-8?B?WStrcUFMbDg1ZHhLbDd4RnZhdWU1OThOL3ZUNnUvUG5Pei9KaWdZVGlybWdx?=
 =?utf-8?B?M0YxM01LK2ViNXJlZEVXVVNmOFZuL3RyR2NBbHZuRlBKL0tCQmhXYzBnYUlP?=
 =?utf-8?B?WjBRZFVqY3YvSzFxQ0Q4djU0WmxsdkdqT3BIblgvbEo0bHBSRlRsd3UzekVm?=
 =?utf-8?B?OG9UaHlOcjZMUFhJcncwRHFPMUc1ZXYzRVd5VmdMUkoxRGxSZFBwVlNEQVJC?=
 =?utf-8?B?TzBabFluY2laU1ZHYXdCQVh0eitoT2d4Si9NVVQxRGhIc20xcVlnTzhua2Zm?=
 =?utf-8?B?WmpEUmV3RWNSRWErcDliY1pSdWFVeDZqQVJ1a1JkaHFzR1lOS2VSb0RLZ2hr?=
 =?utf-8?B?Vm1KTUZBYllVdXduVU1yd3ROdlRVRjVoY3N2SWNGZjgyaElhUzBWVkhvVjNK?=
 =?utf-8?B?QVY0OW14TkhxbWRrS0QwUXBHWEVDa1BnMnVvR1dCK3l2U0k3Mks3a3pvd2RM?=
 =?utf-8?B?SzVoT1hJZHFaN09IMitnWEYzNWR1d2RiTWNLZFlWc0lvUUt6TlFmMk1FaXhB?=
 =?utf-8?B?dllhMjFZNWVJeDBraDFrUFZuM0FrVXBpWmZGOEpXK0s3UE1pd01JZkE4YnJZ?=
 =?utf-8?B?aUhuS2lKODJMTHJXZFlLUHFMRVJrbCszb1VBc1lHdTFpVWd4aWJBTkMyZ0FO?=
 =?utf-8?B?dHhrZ280eEU4S3JrSjNZZ3BnWDB1N2hoTXdtdTExMkpqam5NL1pPVm9nNmh3?=
 =?utf-8?B?Z05NcHdUb1dYYjRJMWcveWh0L1g4S0U2ditSR1lnWVBiZi9zZWdVbTNIYWgx?=
 =?utf-8?B?YjhKNjNnOVJNUlhRZXlML1k1dGUrMGo4cXdsYm9ZU3JYN0VPTEdhL1JCNlZM?=
 =?utf-8?B?R3FzSElTWVZPV0lhbTlGTDNmMjB4T1ppanNGNnB2a256L2NTZnFzd254b3p0?=
 =?utf-8?B?SVhzSHd2RTI1VldleWx4eTh6MEtjbEs5c0VvbHk3azljVktJd1lPa09JTTkr?=
 =?utf-8?B?MEMyV3ZoYWJQZWNhSmNYdXYzYTBHcmE3WkZQWnRuWmpNLzVBRFNLV1FVQnBP?=
 =?utf-8?B?ellOREZSSW9wK3Zya0NpYWRWdTF2YmFRdFc4UTdFRXZBR0RHQ2p1VnN5UE5X?=
 =?utf-8?B?YU1abmlSanlLMlJlL2lHdy91VVpORXZUcW5VOHlXTEtxQ1ZqVmRhSG9JMGxr?=
 =?utf-8?B?Rm9yQUFJNE5lRHpjTzRDOFRnNGVzbmNpc0FsdW1HbWwwV0d4ZDJmSWFQTXJH?=
 =?utf-8?B?clcvdDZPeDVZd2JzUU1Vdzltc2FXazRIaFkwdjFKVmM2aXRSVi9oUlVHaW01?=
 =?utf-8?B?VS9kWDR3NVVybHBGTVB3c2FQWDVrNzlYVURTUDcvZU9xSDlHenowMVJzL2FP?=
 =?utf-8?B?VHNHMmY3d3dsL0UreENPS3FXTDI0MlpyQ3RmTDFOWVBtVTlZQmZ2b0p1NkVp?=
 =?utf-8?B?WFhxYzVITTRyL2cyYlc2ZEJkcG5EYmM0Yml4SjdPL0JjTkZjaFJXTXRLbm9O?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a34a072-09a6-40ba-ea7b-08dd759f68c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 06:42:47.4302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hGNLqyM1sePNd1GnrTXIGFsR2US3eWWUwVdMvJphc6EIWxEEALii3w6mOUXSSNJtd0Tvy4twvh5LkKjucDwX9AI32AjERLMe4UaUwATTX104cYwYof6TC/mPZCpzUnyi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6680
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVrYXMgV3VubmVyIDxs
dWthc0B3dW5uZXIuZGU+DQo+IFNlbnQ6IFN1bmRheSwgNiBBcHJpbCAyMDI1IDE2OjQ0DQo+IFRv
OiBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgPG1pcmlhbS5yYWNoZWwua29yZW5ibGl0QGludGVs
LmNvbT47IEJlcmcsDQo+IEpvaGFubmVzIDxqb2hhbm5lcy5iZXJnQGludGVsLmNvbT47IEdydW1i
YWNoLCBFbW1hbnVlbA0KPiA8ZW1tYW51ZWwuZ3J1bWJhY2hAaW50ZWwuY29tPjsgQmVyZywgQmVu
amFtaW4gPGJlbmphbWluLmJlcmdAaW50ZWwuY29tPjsNCj4gQmVuIFNoaW1vbCwgWWVkaWR5YSA8
eWVkaWR5YS5iZW4uc2hpbW9sQGludGVsLmNvbT47IEFybmQgQmVyZ21hbm4NCj4gPGFybmRAYXJu
ZGIuZGU+OyBTdGVybiwgQXZyYWhhbSA8YXZyYWhhbS5zdGVybkBpbnRlbC5jb20+OyBHYWJheSwg
RGFuaWVsDQo+IDxkYW5pZWwuZ2FiYXlAaW50ZWwuY29tPjsgQW5qYW5leXVsdSwgUGFnYWRhbGEg
WWVzdQ0KPiA8cGFnYWRhbGEueWVzdS5hbmphbmV5dWx1QGludGVsLmNvbT47IFRyaWViaXR6LCBT
aGF1bA0KPiA8c2hhdWwudHJpZWJpdHpAaW50ZWwuY29tPg0KPiBDYzogbGludXgtd2lyZWxlc3NA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gd2lmaTogaXdsd2lmaTogbWxk
OiBmaXggYnVpbGRpbmcgd2l0aCBDT05GSUdfUE1fU0xFRVANCj4gZGlzYWJsZWQNCj4gDQo+IEZy
b206IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+IA0KPiBUaGUgbmV3bHkgYWRkZWQg
ZHJpdmVyIGNhdXNlcyBtdWx0aXBsZSBidWlsZCBwcm9ibGVtcyB3aGVuIENPTkZJR19QTV9TTEVF
UA0KPiBpcyBkaXNhYmxlZDoNCj4gDQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvbWxkL21hYzgwMjExLmM6MTk4MjoxMjogZXJyb3I6DQo+ICdpd2xfbWxkX3Jlc3VtZScgZGVm
aW5lZCBidXQgbm90IHVzZWQgWy1XZXJyb3I9dW51c2VkLWZ1bmN0aW9uXQ0KPiAgMTk4MiB8IHN0
YXRpYyBpbnQgaXdsX21sZF9yZXN1bWUoc3RydWN0IGllZWU4MDIxMV9odyAqaHcpDQo+ICAgICAg
IHwgICAgICAgICAgICBefn5+fn5+fn5+fn5+fg0KPiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL21sZC9tYWM4MDIxMS5jOjE5NjA6MTogZXJyb3I6DQo+ICdpd2xfbWxkX3N1c3Bl
bmQnIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV2Vycm9yPXVudXNlZC1mdW5jdGlvbl0NCj4gIDE5
NjAgfCBpd2xfbWxkX3N1c3BlbmQoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBjZmc4
MDIxMV93b3dsYW4NCj4gKndvd2xhbikNCj4gICAgICAgfCBefn5+fn5+fn5+fn5+fn4NCj4gZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvbWFjODAyMTEuYzoxOTQ2OjEzOiBl
cnJvcjoNCj4gJ2l3bF9tbGRfc2V0X3dha2V1cCcgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XZXJy
b3I9dW51c2VkLWZ1bmN0aW9uXQ0KPiAgMTk0NiB8IHN0YXRpYyB2b2lkIGl3bF9tbGRfc2V0X3dh
a2V1cChzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgYm9vbCBlbmFibGVkKQ0KPiAgICAgICB8ICAg
ICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fg0KPiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL21sZC9tYWM4MDIxMS5jOiBJbiBmdW5jdGlvbg0KPiAnaXdsX21sZF9tYWM4MDIx
MV9zdGFydCc6DQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL21hYzgw
MjExLmM6NTA0OjIwOiBlcnJvcjogJ3JldCcgaXMgdXNlZA0KPiB1bmluaXRpYWxpemVkIFstV2Vy
cm9yPXVuaW5pdGlhbGl6ZWRdDQo+ICAgNTA0IHwgICAgICAgICBpZiAoIWluX2QzIHx8IHJldCkg
ew0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICBefg0KPiBkcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL21sZC9tYWM4MDIxMS5jOjQ3ODoxMzogbm90ZTogJ3JldCcgd2FzDQo+
IGRlY2xhcmVkIGhlcmUNCj4gICA0NzggfCAgICAgICAgIGludCByZXQ7DQo+ICAgICAgIHwgICAg
ICAgICAgICAgXn5+DQo+IA0KPiBIaWRlIHRoZSB1bnVzZWQgZnVuY3Rpb25zIGFuZCBtYWtlIHN1
cmUgdGhlICdyZXQnIHZhcmlhYmxlIGlzIGluaXRpYWxpemVkIGJlZm9yZQ0KPiBiZWluZyB1c2Vk
Lg0KPiANCj4gRml4ZXM6IGQxZTg3OWVjNjAwZiAoIndpZmk6IGl3bHdpZmk6IGFkZCBpd2xtbGQg
c3ViLWRyaXZlciIpDQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVs
LmNvbT4NCj4gQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwNDAzMjI1NS5O
NnB0dUNORy1sa3BAaW50ZWwuY29tLw0KPiBTaWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdtYW5uIDxh
cm5kQGFybmRiLmRlPg0KPiBbbHVrYXM6IGluaXRpYWxpemUgcmV0IHRvIDAsIHVzZSBzdGF0aWMg
aW5saW5lXQ0KPiBTaWduZWQtb2ZmLWJ5OiBMdWthcyBXdW5uZXIgPGx1a2FzQHd1bm5lci5kZT4N
Cj4gLS0tDQo+IENoYW5nZXMgdjEgLT4gdjI6DQo+ICBJbml0aWFsaXplIHJldCB0byAwIGluc3Rl
YWQgb2YgcmVtb3ZpbmcgaXQgZnJvbSB0aGUgaWYtY2xhdXNlIChNaXJpYW0pLg0KPiAgVXNlIHN0
YXRpYyBpbmxpbmUgZm9yIGl3bF9tbGRfbm9fd293bGFuX3N1c3BlbmQoKSBpbnN0ZWFkIG9mIGFu
ICNpZmRlZiAgaW4NCj4gYWNjb3JkYW5jZSB3aXRoIHNlY3Rpb24gMjEgb2YgRG9jdW1lbnRhdGlv
bi9wcm9jZXNzL2NvZGluZy1zdHlsZS5yc3QuDQo+IA0KPiBMaW5rIHRvIHYxOg0KPiAgaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDMyNTA4NDM0MC4zNzg3MjQtMS1hcm5kQGtlcm5lbC5v
cmcvDQo+IA0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvZDMuaCAg
ICAgICB8IDQgKysrKw0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQv
bWFjODAyMTEuYyB8IDQgKysrLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9p
bnRlbC9pd2x3aWZpL21sZC9kMy5oDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9tbGQvZDMuaA0KPiBpbmRleCA2MThkNmZiLi40MTU3ZjgyIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9kMy5oDQo+ICsrKyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL2QzLmgNCj4gQEAgLTM0LDYgKzM0LDcg
QEAgc3RydWN0IGl3bF9tbGRfd293bGFuX2RhdGEgew0KPiAgCXN0cnVjdCBpd2xfbWxkX3Jla2V5
X2RhdGEgcmVrZXlfZGF0YTsNCj4gIH07DQo+IA0KPiArI2lmZGVmIENPTkZJR19QTV9TTEVFUA0K
PiAgaW50IGl3bF9tbGRfbm9fd293bGFuX3Jlc3VtZShzdHJ1Y3QgaXdsX21sZCAqbWxkKTsgIGlu
dA0KPiBpd2xfbWxkX25vX3dvd2xhbl9zdXNwZW5kKHN0cnVjdCBpd2xfbWxkICptbGQpOyAgaW50
DQo+IGl3bF9tbGRfd293bGFuX3N1c3BlbmQoc3RydWN0IGl3bF9tbGQgKm1sZCwgQEAgLTQ3LDUg
KzQ4LDggQEAgdm9pZA0KPiBpd2xfbWxkX2lwdjZfYWRkcl9jaGFuZ2Uoc3RydWN0IGllZWU4MDIx
MV9odyAqaHcsDQo+ICAJCQkgICAgICBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLA0KPiAgCQkJ
ICAgICAgc3RydWN0IGluZXQ2X2RldiAqaWRldik7DQo+ICAjZW5kaWYNCj4gKyNlbHNlDQo+ICtz
dGF0aWMgaW5saW5lIGludCBpd2xfbWxkX25vX3dvd2xhbl9zdXNwZW5kKHN0cnVjdCBpd2xfbWxk
ICptbGQpIHsNCj4gK3JldHVybiAwOw0KWW91IGFyZSBub3Qgc3VwcG9zZWQgdG8gZ2V0IHRvIHRo
aXMgZnVuY3Rpb24gbm90IHVuZGVyIHRoZSBpZmRlZi4gU28gaWYgeW91IGRvLCBJJ2QgcmV0dXJu
IGFuIGVycm9yIHZhbHVlLCBub3QgMD8NCiB9ICNlbmRpZg0KPiANCj4gICNlbmRpZiAvKiBfX2l3
bF9tbGRfZDNfaF9fICovDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL21sZC9tYWM4MDIxMS5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwv
aXdsd2lmaS9tbGQvbWFjODAyMTEuYw0KPiBpbmRleCA2ODUxMDY0Li4xOGNkNjA3IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9tYWM4MDIxMS5j
DQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL21hYzgwMjEx
LmMNCj4gQEAgLTQ3NSw4ICs0NzUsOCBAQCBpbnQgaXdsX21sZF9yZWdpc3Rlcl9odyhzdHJ1Y3Qg
aXdsX21sZCAqbWxkKSAgaW50DQo+IGl3bF9tbGRfbWFjODAyMTFfc3RhcnQoc3RydWN0IGllZWU4
MDIxMV9odyAqaHcpICB7DQo+ICAJc3RydWN0IGl3bF9tbGQgKm1sZCA9IElXTF9NQUM4MDIxMV9H
RVRfTUxEKGh3KTsNCj4gLQlpbnQgcmV0Ow0KPiAgCWJvb2wgaW5fZDMgPSBmYWxzZTsNCj4gKwlp
bnQgcmV0ID0gMDsNCj4gDQo+ICAJbG9ja2RlcF9hc3NlcnRfd2lwaHkobWxkLT53aXBoeSk7DQo+
IA0KPiBAQCAtMTk0Myw2ICsxOTQzLDcgQEAgc3RhdGljIHZvaWQgaXdsX21sZF9zdGFfcmNfdXBk
YXRlKHN0cnVjdA0KPiBpZWVlODAyMTFfaHcgKmh3LA0KPiAgCX0NCj4gIH0NCj4gDQo+ICsjaWZk
ZWYgQ09ORklHX1BNX1NMRUVQDQo+ICBzdGF0aWMgdm9pZCBpd2xfbWxkX3NldF93YWtldXAoc3Ry
dWN0IGllZWU4MDIxMV9odyAqaHcsIGJvb2wgZW5hYmxlZCkgIHsNCj4gIAlzdHJ1Y3QgaXdsX21s
ZCAqbWxkID0gSVdMX01BQzgwMjExX0dFVF9NTEQoaHcpOyBAQCAtMTk5NCw2DQo+ICsxOTk1LDcg
QEAgc3RhdGljIGludCBpd2xfbWxkX3Jlc3VtZShzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodykNCj4g
DQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICsjZW5kaWYNCj4gDQo+ICBzdGF0aWMgaW50IGl3bF9t
bGRfYWxsb2NfcHRrX3BuKHN0cnVjdCBpd2xfbWxkICptbGQsDQo+ICAJCQkJc3RydWN0IGl3bF9t
bGRfc3RhICptbGRfc3RhLA0KPiAtLQ0KPiAyLjQzLjANCj4gDQoNCg==

