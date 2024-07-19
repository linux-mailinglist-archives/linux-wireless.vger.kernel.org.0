Return-Path: <linux-wireless+bounces-10387-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47BD9375F0
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 11:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBA4285F90
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 09:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F405D823AC;
	Fri, 19 Jul 2024 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2IyW7fH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F091112A177
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721381939; cv=fail; b=cTSTVhS/8fWIrlO/PhvPEuuOC9S5eaGkni858xYsYqrOpPKHyWffEZiDsAG7Dg1HW2OO+jx2RX+fcD3YAd0m8CPb3IIGKkfm9LqJqCbDKwJxCuQp46FLbfk8K3CJECB+il6kHvf+F8UgNGxyOQRZQoo5H1TOufzPqbKx6HX9Lao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721381939; c=relaxed/simple;
	bh=7VNpoZKF/2h1kTWKSSyWsiw4XQroaTXQt7njlUh5cyk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QHbqpNG2lrsuwuJYY+Nwuuj8hUrEJZ5qqXTW4jUBh/pwxjBq49e20DUX139VvrQqw7i+rmfjfBCNPqJGd6kR62vC4rA5HSp8c47WNnVEA7RoQZVznSGD6xj5rslpz8KijkXY63zBOvI1iAuX4wtZKKCfeCS6cP5iI/ebvE2sHig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2IyW7fH; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721381938; x=1752917938;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=7VNpoZKF/2h1kTWKSSyWsiw4XQroaTXQt7njlUh5cyk=;
  b=V2IyW7fHEA+88V7h1VZz3ljT/WnUBkuRD2haV0TocfAwffjJG2EgHa4Y
   XyDavcGAnHisz5f45gg3STufWDJfE+woJUBL5d2rd5p0YBe75/PPDalUO
   WGCnZKsfzSIecPwOexUxKyi/K3/Y7C5jJc4tQmqx9AJqQ9zSg8AEEqFZE
   zTdIKfIUQemOLKZZcCE5yJfHDHGWlNltq00cxFXg5ll/3D9joMmo5NYMi
   reRyucACa+oxrEqOrWXsMfKZEKDgUGfmzT7aBer4aULqWJ9i0d6XHwT3t
   PI43lf01N4mA3/Z2Xo+DKVM+/2A+7AkwehZUvld96YlaeAARsVCBapxm8
   Q==;
X-CSE-ConnectionGUID: qjvyZo1HTCS+D6hneFE3Dw==
X-CSE-MsgGUID: Z+lHYaihQnGTZKJf74cNEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="19169018"
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="19169018"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 02:38:57 -0700
X-CSE-ConnectionGUID: 0wFm9L0YTvKysAV4oo7whg==
X-CSE-MsgGUID: 3llZcHwnTamtv4bW9wWO9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="50750538"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jul 2024 02:38:57 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 19 Jul 2024 02:38:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 19 Jul 2024 02:38:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Jul 2024 02:38:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=su+f0cgaS+xt3xox/3DJD15Scu80xorV8SIEttepSraWUUMHzq+dX9rS7e5/AL/HZ1lvNBAr8PxxZlrsRsJ5GM3ka//dp4CnuYx3/djAaY+pGGOECTnEN/SZV++WSFELqBuk7XgIaChDIrjeF0AdTWgXShB2rwao4Z/rL7agSxzg9JTUZjb1JlfR8oUl/PNhyA1m/7MpQ3KjvHRuxMAk6062olxbzG2Ce64FvUogoS3U3144/IWGZHukm3YfzZi6P6JQgHUAS1pq251Tusdg61ZZvGvWvbiPU4kH1F0Kicv/FoqWGSBiZhkRKX7t/2gOqcbul56tsN+dYXxcFWtCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4Himk6Cg9jQIIv6DlYlPkq1mbZ/EzVfZ+Xy6Q+D72s=;
 b=uu8jGiQgtospaVWxDuH1HLGYAi1NdzkX14WyiuAcglCUuEwJ6Vhw/CWTsMEQovG84yhZ6IdyHOrftRixf9LGF2CFs3TLKihGNpf3efpl7sfX232dEGI+2zd8XkUtcKqL92OkqgyAOkIavmfPc4vsaiBTod21QjA3sM0bnmQkMK9vOUojZiK9vDhnXsjsYluuv59AmbGwuYoYUh0a4/9nk66+PUFuOgNZPbH9b/P+JapIoGaVFXyB5/YfZqFqtcKPCYP2lQ765sb0VERxalLaeFnwSraNvl607k4vdG1nCpihfNwmBp4N9Ie3hUbM3O6lZMAiFK1OBPmBDx1hq1UZ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9)
 by CY8PR11MB7291.namprd11.prod.outlook.com (2603:10b6:930:9b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Fri, 19 Jul
 2024 09:38:54 +0000
Received: from PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f]) by PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::1b60:d7c9:1b2a:2a7f%5]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 09:38:53 +0000
From: "Berg, Benjamin" <benjamin.berg@intel.com>
To: "dmantipov@yandex.ru" <dmantipov@yandex.ru>, "Berg, Johannes"
	<johannes.berg@intel.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: Managing debugfs entries and
 https://syzkaller.appspot.com/bug?extid=d5dc2801166df6d34774
Thread-Topic: Managing debugfs entries and
 https://syzkaller.appspot.com/bug?extid=d5dc2801166df6d34774
Thread-Index: AQHa2TSGAGXzZl8uOUCQ2mpLjfwPXrH9zIOA
Date: Fri, 19 Jul 2024 09:38:53 +0000
Message-ID: <2e57365ad4b0a5e63bf1d54ff776d57d08d462b0.camel@intel.com>
References: <1ff58acb-4171-46ff-8a33-821600a8d8e4@yandex.ru>
In-Reply-To: <1ff58acb-4171-46ff-8a33-821600a8d8e4@yandex.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7964:EE_|CY8PR11MB7291:EE_
x-ms-office365-filtering-correlation-id: 8e5ad562-bad4-4484-7fb6-08dca7d69aab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QmlNa0Z0cmRmb2Jpb05VSUVxY2w4aGYwK1BsYUVhNC9FY3ZaMWFhRmhMeGRj?=
 =?utf-8?B?RXIyTlhPbmlyTFpET2MwSDNxOXJDbTRheksyUDZLeGo3M2loMHkvM0VVZk9m?=
 =?utf-8?B?MXlhdXg1S09WVFFsUlNibHM5SVdqcFJaMjU0SDdmbXY1VEltcEswNG9mWVdT?=
 =?utf-8?B?cmFLZkE5MEVuOS80bklWKzMyOEdJNFVISE50RkxmSTQ5cFNFQzAxSUZSYkph?=
 =?utf-8?B?VjROaFJEMEhra0pYdkRpQlJGY3VMTUVnTFpNaFN6L3UyMTdkL2VjV0VHc0gy?=
 =?utf-8?B?ZHdkaGZrTExMR1VqMmN1WDA3WFJMSGJjOWJFTHRsWGE4c0lFRkhZN1FTSXpC?=
 =?utf-8?B?bGs2cXY1Vm9Pa1ZoVUd5dkt6MzYydnI0QW9sZjZUQy8wNkZtQnpqQndzSlJv?=
 =?utf-8?B?SjNjUUsvRnF6Zmx6WXZNcE9ZRXB3dlQ2MkppV0lYRGQ4MFlkRTFzSWZxcTFP?=
 =?utf-8?B?V1JxTlFYdFJ6K1FQdFUvSW9WNUgrUURiaFc3YXdGVWR6Y1VMc1Fld3VlOU5h?=
 =?utf-8?B?RytmWmZWUktNWGdGVU9hOXBzMmxPMTVxdU4xYlJJQjVPNnNhZFFueVRRVC9x?=
 =?utf-8?B?RVl5TFRzTGJVN043bEdsNytIU29ic093MjRyMHpTR1JsaG1Mc01CSlBOZW5j?=
 =?utf-8?B?Q0hydjJ0NGg2NW9DMFA3OTFsNkJGTkYvZ1ZWVWtsSlZQM2RLS01YUW8ycm94?=
 =?utf-8?B?MDh5Y0YwVnpKVnY3U2lWdjVFWGJXa2tCWVE1M2E2WlhPbkU0T0owYW9MSXNx?=
 =?utf-8?B?c0RZUG5OZHJsWjdEOS9EZHliY1pCbmd4OEg1dTVTUnJpeUdSMTliMlFweGJh?=
 =?utf-8?B?ek1NVkd4N2lydDkrNlE3Rk1OQ0txUllhaUpTV0w2MmRyZkNBTnlLZndaZFVX?=
 =?utf-8?B?MzZmS3M1bXJjc1o3Qms3S0VBMlBuMWtHTCtyRjkrekZvOHlOUGpTUlIzb2Fo?=
 =?utf-8?B?YzRSSVFtSFlDbE9zSS9ycW5vQ1ZyMDRna1NNb0FZSjhQK2VFSGpBVkE3Zy9K?=
 =?utf-8?B?TFVuVnZwL1VoVm1ta05iVFRFaTQzeHRlZ2tBaU54SVpQK1crZDhHdlNrT3hs?=
 =?utf-8?B?L0lwUWQvdzRNS1R2QUFJZ2F2K3ptdXJCWGFXZ0FFb0JWQUtNY2dmeWk2M2pi?=
 =?utf-8?B?SEFGM3lDaWZqTEVEWlh2VHNtU2NNYTErODhrQ2JaMmpSRjlOL1NrSG5ac3l5?=
 =?utf-8?B?ajNYbWQzWUVKYmZ0dnNSNWxLTTFCeVpGL21uV2VWRzJNcG9uS1NZNUpNS08w?=
 =?utf-8?B?cGEwdHFFM3VhWFF1M3hmSjRIMWJ1bll5cFZtSFdOb2pGYnJZQUpCd0IwbVUv?=
 =?utf-8?B?bnZEYzhJYXRnZTg4ajNmM2x4YkJNNmZiQWsyRCt6UWR2d1hpWjdtYnFvdjRG?=
 =?utf-8?B?YzZUWmpwSGFKS3VlcWwzQjlLMk9YcGNqYTk3b3o3Sm1sNzVjMitBcUs2WWxr?=
 =?utf-8?B?S0YzQjBWRys3djFYdmw1RVZQK0MwVTZnbkFxUDMxcTU2OVNtTFhVdlIzOUZr?=
 =?utf-8?B?R0xyNmFTNWVzTGRCVTFoUW4rcUZ3L004Smp5MzBFUTJaR0hpZlVJSW5TUTlQ?=
 =?utf-8?B?aENvODFjSkRBdm1xTkE4cTVPWFdWOFAyaVBkTm9nZjZwNzN2anJwUEtIK3Fw?=
 =?utf-8?B?cmdIMDlZOHRWdDJvbVdFMTNleGxsaWhKV0htMXY2dW5QcW93TS9OcXRBYlk3?=
 =?utf-8?B?SkxkdFJmWVRYZjlBN2VZOGEvWGlxbTB4QVZZK0tKOW9EajlpNXdBejhSQXRO?=
 =?utf-8?B?QVNGemZMMUFMQmFtTG5DMjlJYnFVTnZ1UFpRWEkyR0NNNHRPaGRQT0Q2MmJr?=
 =?utf-8?Q?TsNsLSuAjVXgc2AgcnGKZ573F7ekGVPU3DJwM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7964.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZENJOWVSNWxwU2Zmb0JZTW9RQ3hlNHQ0dm5JTUJ5WjUwTHhoZCtiazVpN2hF?=
 =?utf-8?B?bUFJTWNFWVNsSEQzdmtIYWVKbE96azFsN0hIZlR4RzJCeUFaUUJ4VjM1Sm5Y?=
 =?utf-8?B?MFZVUFNxOVVaTm9oQ1NWaEVxb3hCT1phZWwreUE4MU90L2FyMzJRT2RsRU9p?=
 =?utf-8?B?cDV5MzJOVXVBWXEvNlVaN2ZIRVU0b2xVS1Z4MFl6NldPb3BrR2hMUnNpLzhx?=
 =?utf-8?B?WFcrWVU3YUw0SU9XNWRJM0kyajc3d3Z6UlBNUWdmNnN0Mnl4WjlUN1BwSXhy?=
 =?utf-8?B?dHRjRy8ybkErZld0VXhYL1Y3K1VnOUFTOW05VG9RYXM2QzdwRTlqSnFtc0Zy?=
 =?utf-8?B?ZzdCZGVsbEtVaUZyNU8vYkR2bjd2QkZ2RlZJaXBpZzRTSnE1VGkzNE02L1dm?=
 =?utf-8?B?OHJ3QW90QWl6VW1VNEQ1NEx6eUhySFdyWnF4NlROYlF4TVFEeEFRcU1nM2Jw?=
 =?utf-8?B?aWRnOVNkUzB1M2xPNjVXWE4zcWpiUjNKVGdMNXp2VnpUcmVaQ1dMTDFEbWNx?=
 =?utf-8?B?TzVBSVd5Zy9sbmpmalpET29tVHlKNmZJd2hORVR1TXlQUGwreDY4b2VsbEl1?=
 =?utf-8?B?K3RSaWladXNmTm1ycHY5Uy9pN1JDRjdVc2NyRVV3WFFKYkVuQ2dDdnZkdnpG?=
 =?utf-8?B?SThoQUdsODN4NmJJYWpKQ0tkZnZpdFZuTDUveml3Zi93QlYwakIxaEhCU2dK?=
 =?utf-8?B?NEtpOW9mUFNudjY1K25XK2lrSk8ySnIzNUp5QmRjZFpjSGlrNUdNVFJ5a1Fj?=
 =?utf-8?B?eG1PZStkRmwzK04xUS8wNUh2THoyUEpwTlNFc1c0UW9oK1lSOSttV0JwNS9u?=
 =?utf-8?B?T2VXZ3pMaG1EdGNXNlk0eTVkb0dzV0J3dm0vY2Q0NXRYMGlDNGwydWFXaGZS?=
 =?utf-8?B?SnhFeFQ3UXNJanB5b0RGRmlEWGJJY3BNbDhjdDA2UVpGTUZXc0Z2ZTIvTlBt?=
 =?utf-8?B?ZDNidlI1a3M0cjJ5ay8reVlsZENBWHNqRnowWUxmUkR0NVVpYWtvcGhSaElo?=
 =?utf-8?B?QWxGMWF2YWp3YTRvS1grWXFLYzh5MmU4eTR0V1kvMHY4SW83b3BpODJSY09o?=
 =?utf-8?B?WE5GNGNVMnNQRTNvVTh6VG94SUNlQ1piYm10KzBoSFY1cHBsSERCS1FDN1RP?=
 =?utf-8?B?UEFKZnR5dkJ4V25nR09RZWJ0SVUrbnRYbk9UY1FJeUZyZExJczBiTU1OQ2ti?=
 =?utf-8?B?emo5VmVJeENlUmJHVHE4dTRYeEVMWlNxYTFiTWVtQlQ0RitzWEp1cktHR2dP?=
 =?utf-8?B?MDF0c0ZGVldpQTVOUHMyK0pIM2dWVXNUaFc0RTJXM2FmZURCL2tFUXJ0dW9T?=
 =?utf-8?B?d3RSQ0lGRlU2bkVtMWZEbDhtWDg1S1UxbytESVlPQUtWNFM2Rng5aFBieTE2?=
 =?utf-8?B?MEJnUU4wS1hkRTlFWThXaGFpRDRkWDlCaWFEbXJSVGwvaFJzSVVQbDZIVXVz?=
 =?utf-8?B?T1lUMUo4Qm1aVDhSY1dEb1RNM05IOXFHM1lTS1JsWG1oMTNvcisrV09lSTN4?=
 =?utf-8?B?bllmV2FlallYTkRlZEFvTlVpalB3RXZodzhTQWxRT21xeHkyZ2ZKNytlZTN1?=
 =?utf-8?B?dUp6TFhzaFZRQjNJeVQ2K3ZrUGxMR3pXaGV1OHNKVHNMdG12ZlBtREY4VGhG?=
 =?utf-8?B?OC9aNy9YeEErcU1idmkzN3FONktwUnhBWUhwb2RzV1dZbVMzVDhzQUkvNzRs?=
 =?utf-8?B?L09aeFczQTJIVHVNNjFLaHp1b054WGgvb0xhT1hBRjdCUC9Mam1Ya1hTTE5C?=
 =?utf-8?B?VnZXZysza1ZqNmNtUTU3YlpnZjlYUXRjSkt1bGtNaDNKOElNT0h3QllvNi8w?=
 =?utf-8?B?MmpWRFRKZE1HdU5SNVc3aG9haDQzV2xmaGh3NVVxQjFtakd1b2JSTWlESlFn?=
 =?utf-8?B?ckhzRENQSGtObHVLZzBVaXpIRUR5dnh1MGlmanZvL04zYVJYWlZTWDJRRDFv?=
 =?utf-8?B?MmtGOHdUL3hoVERGZkxZbDNNWHRlc3hPdzBMMHJNSFo0Zk1QK0doeUpLZ0Yx?=
 =?utf-8?B?Y29ubkxrYi9xYm0xeDYwMlFSWEphcGlpQWFGUnJGVWY2M1Zua3psRWlIM1Z5?=
 =?utf-8?B?WGJ1VmdLODNpdFdKUkFsbFU2aGZhWURDdEp0aHc5QUFoUlRnR3NEZ0RkNDdq?=
 =?utf-8?B?dmNHQ3RndzZURklCc3JidlpOZ1ZsZnZnN2ZQbk5jYzAyemR5OEwxdzNEMThP?=
 =?utf-8?B?eHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <014C14C495F98A4E82893E1B31EAB1AB@namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7964.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5ad562-bad4-4484-7fb6-08dca7d69aab
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 09:38:53.9293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i0pJlBw6bD1VsFdWSMYbTguHV9J9+WygvD2ohjmOHHeLFJDwamCO4OiOyM6xuvdrEYg7v1XtRHoxDzUtwSYMww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7291
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64

SGksDQoNCmhtbSwgZG91YnQgdGhhdCB3b3VsZCB3b3JrLiBGdW5kYW1lbnRhbGx5LCB0aGUgcHJv
YmxlbSBpcyB0aGF0IHdoZW4gd2UNCnN3aXRjaCBiZXR3ZWVuIE1MTyBhbmQgbm9uLU1MTyAobXVs
dGktbGluayBvcGVyYXRpb24pLCB3ZSBuZWVkIHRvDQpyZWNyZWF0ZSB0aGUgZGVidWdmcyBiZWNh
dXNlIHRoZSBsYXlvdXQgY2hhbmdlcy4gSG93ZXZlciwgaW4gdGhhdCBjYXNlDQp3ZSBzaG91bGQg
bm90IGhhdmUgYW55IGFjdGl2ZSBzdGF0aW9ucyBhbmQgcnVubmluZw0KaWVlZTgwMjExX2RlYnVn
ZnNfcmVjcmVhdGVfbmV0ZGV2IHNob3VsZCB1c3VhbGx5IG5vdCBiZSBwcm9ibGVtYXRpYy4NCg0K
U28sIHRoZSBzaW1wbGUgd2F5IHRvIHByZXZlbnQgdGhpcyBlcnJvciBpcyB0byBtYWtlIHN1cmUg
dGhhdA0KaWVlZTgwMjExX2RlYnVnZnNfcmVjcmVhdGVfbmV0ZGV2IGlzIG5ldmVyIGNhbGxlZCB3
aGlsZSB3ZSBoYXZlIGENCnN0YXRpb24uIEluIHRoZSBjYXNlIG9mIHRoaXMgcmVwb3J0IHdlIHNl
ZW0gdG8gYmUgZ2V0dGluZyB0aGVyZSB2aWEgYQ0KbWFjIGFkZHJlc3MgY2hhbmdlIChpLmUuIGll
ZWU4MDIxMV9jaGFuZ2VfbWFjKSBhbmQgdGhlIHNhbmUgdGhpbmcgd291bGQNCmJlIHRvIGp1c3Qg
cmV0dXJuIC1FQlVTWSBpbnN0ZWFkIG9mIHBlcm1pdHRpbmcgdGhlIG9wZXJhdGlvbiB0bw0KY29u
dGludWUuDQoNClRvIGZpeCB0aGUgZXJyb3IsIG9uZSBjb3VsZCBwb3NzaWJseSBwcmV2ZW50IHRo
ZSBzdGF0aW9ucyBkZWJ1Z2ZzDQplbnRyaWVzIGZyb20gYmVpbmcgZGVsZXRlZCBieSBpZWVlODAy
MTFfZGVidWdmc19yZWNyZWF0ZV9uZXRkZXYgb3IgYWxzbw0KcmVjcmVhdGUgdGhlbS4gSG93ZXZl
ciwga2VlcGluZyB0aGVtIGlzIG5vdCByZWFsbHkgY29ycmVjdCB1bmxlc3MgTUxPDQppcyBub3Qg
dG9nZ2xlZCBhbmQgSSBhbSBub3Qgc3VyZSBob3cgc3RyYWlnaHQgZm9yd2FyZCBpdCB3b3VsZCBi
ZSB0bw0KcmVjcmVhdGUgdGhlbS4NCg0KQmVuamFtaW4NCg0KT24gVGh1LCAyMDI0LTA3LTE4IGF0
IDIwOjAzICswMzAwLCBEbWl0cnkgQW50aXBvdiB3cm90ZToNCj4gVGhlIGZvbGxvd2luZyBxdWly
ayBsb29rcyBsaWtlIGEgKGJyaWVmbHkgdGVzdGVkIHdpdGggQ09ORklHX0tNRU1MRUFLKQ0KPiBm
aXggZm9yIGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD1kNWRjMjgwMTE2
NmRmNmQzNDc3NDoNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvbWFjODAyMTEvZGVidWdmc19zdGEu
YyBiL25ldC9tYWM4MDIxMS9kZWJ1Z2ZzX3N0YS5jDQo+IGluZGV4IDFlOTM4OWM0OWE1Ny4uODIy
NDI1N2U1ZDkzIDEwMDY0NA0KPiAtLS0gYS9uZXQvbWFjODAyMTEvZGVidWdmc19zdGEuYw0KPiAr
KysgYi9uZXQvbWFjODAyMTEvZGVidWdmc19zdGEuYw0KPiBAQCAtMTI4NCw3ICsxMjg0LDkgQEAg
dm9pZCBpZWVlODAyMTFfc3RhX2RlYnVnZnNfYWRkKHN0cnVjdCBzdGFfaW5mbyAqc3RhKQ0KPiAN
Cj4gwqAgdm9pZCBpZWVlODAyMTFfc3RhX2RlYnVnZnNfcmVtb3ZlKHN0cnVjdCBzdGFfaW5mbyAq
c3RhKQ0KPiDCoCB7DQo+IC3CoMKgwqDCoMKgwqAgZGVidWdmc19yZW1vdmVfcmVjdXJzaXZlKHN0
YS0+ZGVidWdmc19kaXIpOw0KPiArwqDCoMKgwqDCoMKgIGlmICghc3RhLT5kZWJ1Z2ZzX3NoYXJl
ZCkNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVidWdmc19yZW1vdmVfcmVjdXJz
aXZlKHN0YS0+ZGVidWdmc19kaXIpOw0KPiArwqDCoMKgwqDCoMKgIHN0YS0+ZGVidWdmc19zaGFy
ZWQgPSBmYWxzZTsNCj4gwqDCoMKgwqDCoMKgwqDCoCBzdGEtPmRlYnVnZnNfZGlyID0gTlVMTDsN
Cj4gwqAgfQ0KPiANCj4gQEAgLTEzMTksNiArMTMyMSw3IEBAIHZvaWQgaWVlZTgwMjExX2xpbmtf
c3RhX2RlYnVnZnNfYWRkKHN0cnVjdCBsaW5rX3N0YV9pbmZvICpsaW5rX3N0YSkNCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4gDQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxpbmtfc3RhLT5kZWJ1Z2ZzX2RpciA9
IGxpbmtfc3RhLT5zdGEtPmRlYnVnZnNfZGlyOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBsaW5rX3N0YS0+c3RhLT5kZWJ1Z2ZzX3NoYXJlZCA9IHRydWU7DQo+IMKgwqDCoMKgwqDC
oMKgwqAgfQ0KPiANCj4gwqDCoMKgwqDCoMKgwqDCoCBERUJVR0ZTX0FERChodF9jYXBhKTsNCj4g
ZGlmZiAtLWdpdCBhL25ldC9tYWM4MDIxMS9zdGFfaW5mby5oIGIvbmV0L21hYzgwMjExL3N0YV9p
bmZvLmgNCj4gaW5kZXggOTE5NWQ1YTJkZTBhLi5kNzZiYTM2Y2E3OTQgMTAwNjQ0DQo+IC0tLSBh
L25ldC9tYWM4MDIxMS9zdGFfaW5mby5oDQo+ICsrKyBiL25ldC9tYWM4MDIxMS9zdGFfaW5mby5o
DQo+IEBAIC03MDgsNiArNzA4LDcgQEAgc3RydWN0IHN0YV9pbmZvIHsNCj4gDQo+IMKgICNpZmRl
ZiBDT05GSUdfTUFDODAyMTFfREVCVUdGUw0KPiDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBkZW50
cnkgKmRlYnVnZnNfZGlyOw0KPiArwqDCoMKgwqDCoMKgIGJvb2wgZGVidWdmc19zaGFyZWQ7DQo+
IMKgICNlbmRpZg0KPiANCj4gwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgY29kZWxfcGFyYW1zIGNw
YXJhbXM7DQo+IA0KPiBTbyB3aGF0IGFib3V0IG1hbmFnaW5nIGRlYnVnZnMgZW50cmllcyB3aWgg
a3JlZnM/IEUuZy46DQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L21hYzgwMjExL3N0YV9pbmZvLmgg
Yi9uZXQvbWFjODAyMTEvc3RhX2luZm8uaA0KPiBpbmRleCA5MTk1ZDVhMmRlMGEuLjFmNDU2MTUz
MzUzMCAxMDA2NDQNCj4gLS0tIGEvbmV0L21hYzgwMjExL3N0YV9pbmZvLmgNCj4gKysrIGIvbmV0
L21hYzgwMjExL3N0YV9pbmZvLmgNCj4gQEAgLTQ2Niw2ICs0NjYsMTUgQEAgc3RydWN0IGllZWU4
MDIxMV9mcmFnbWVudF9jYWNoZSB7DQo+IMKgwqAJdW5zaWduZWQgaW50IG5leHQ7DQo+IMKgIH07
DQo+IA0KPiArI2lmZGVmIENPTkZJR19NQUM4MDIxMV9ERUJVR0ZTDQo+ICsNCj4gK3N0cnVjdCBz
dGFfZGVidWdmc19lbnRyeSB7DQo+ICsJc3RydWN0IGRlbnRyeSAqZGVidWdmc19kaXI7DQo+ICsJ
c3RydWN0IGtyZWYga3JlZjsNCj4gK307DQo+ICsNCj4gKyNlbmRpZiAvKiBDT05GSUdfTUFDODAy
MTFfREVCVUdGUyAqLw0KPiArDQo+IMKgIC8qDQo+IMKgwqAgKiBUaGUgYmFuZHdpZHRoIHRocmVz
aG9sZCBiZWxvdyB3aGljaCB0aGUgcGVyLXN0YXRpb24gQ29EZWwgcGFyYW1ldGVycyB3aWxsIGJl
DQo+IMKgwqAgKiBzY2FsZWQgdG8gYmUgbW9yZSBsZW5pZW50ICh0byBwcmV2ZW50IHN0YXJ2YXRp
b24gb2Ygc2xvdyBzdGF0aW9ucykuIFRoaXMNCj4gQEAgLTU2Myw3ICs1NzIsNyBAQCBzdHJ1Y3Qg
bGlua19zdGFfaW5mbyB7DQo+IMKgwqAJZW51bSBpZWVlODAyMTFfc3RhX3J4X2JhbmR3aWR0aCBj
dXJfbWF4X2JhbmR3aWR0aDsNCj4gDQo+IMKgICNpZmRlZiBDT05GSUdfTUFDODAyMTFfREVCVUdG
Uw0KPiAtCXN0cnVjdCBkZW50cnkgKmRlYnVnZnNfZGlyOw0KPiArCXN0cnVjdCBzdGFfZGVidWdm
c19lbnRyeSAqZGVidWdmc19lbnRyeTsNCj4gwqAgI2VuZGlmDQo+IA0KPiDCoMKgCXN0cnVjdCBp
ZWVlODAyMTFfbGlua19zdGEgKnB1YjsNCj4gQEAgLTcwNyw3ICs3MTYsNyBAQCBzdHJ1Y3Qgc3Rh
X2luZm8gew0KPiDCoMKgCXN0cnVjdCBzdGFfYW1wZHVfbWxtZSBhbXBkdV9tbG1lOw0KPiANCj4g
wqAgI2lmZGVmIENPTkZJR19NQUM4MDIxMV9ERUJVR0ZTDQo+IC0Jc3RydWN0IGRlbnRyeSAqZGVi
dWdmc19kaXI7DQo+ICsJc3RydWN0IHN0YV9kZWJ1Z2ZzX2VudHJ5ICpkZWJ1Z2ZzX2VudHJ5Ow0K
PiDCoCAjZW5kaWYNCj4gDQo+IMKgwqAJc3RydWN0IGNvZGVsX3BhcmFtcyBjcGFyYW1zOw0KPiAN
Cj4gRG1pdHJ5DQoNCkludGVsIERldXRzY2hsYW5kIEdtYkgNClJlZ2lzdGVyZWQgQWRkcmVzczog
QW0gQ2FtcGVvbiAxMCwgODU1NzkgTmV1YmliZXJnLCBHZXJtYW55DQpUZWw6ICs0OSA4OSA5OSA4
ODUzLTAsIHd3dy5pbnRlbC5kZQ0KTWFuYWdpbmcgRGlyZWN0b3JzOiBTZWFuIEZlbm5lbGx5LCBK
ZWZmcmV5IFNjaG5laWRlcm1hbiwgVGlmZmFueSBEb29uIFNpbHZhDQpDaGFpcnBlcnNvbiBvZiB0
aGUgU3VwZXJ2aXNvcnkgQm9hcmQ6IE5pY29sZSBMYXUNClJlZ2lzdGVyZWQgT2ZmaWNlOiBNdW5p
Y2gNCkNvbW1lcmNpYWwgUmVnaXN0ZXI6IEFtdHNnZXJpY2h0IE11ZW5jaGVuIEhSQiAxODY5MjgK


