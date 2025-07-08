Return-Path: <linux-wireless+bounces-24945-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1B2AFCBC8
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 15:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FEB3A7BC6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 13:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004672DCF59;
	Tue,  8 Jul 2025 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JvJ/1Fsq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665F21C6FF6
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980939; cv=fail; b=oTJ+cyiWmVZaLPrF0FySji0MMx0y4Yc35J45M/Tr2WTpwFxy/9A56avI5e6UZfy98NCjeE4A+B93apngWr+e5A+7exOJYW01zQvM+kxgg2bc8EfrvxOBNmDggLNMj3jPFewtj/8+ezpDMMUztkvrjXcJ168LD79MMAXYk0b9DVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980939; c=relaxed/simple;
	bh=8oXAtCYZ6YZaA5hm919/2ydQPpixjVPANhtE949ADUk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ryDb0kqqf7Ap4eYKvH6Xytb6C1fP8YICTWV+oAYx6CrwrkRqJqkHD7YmU2IZK/PiUzZnS85uh43aHzZLgfJHBXaBRzpmjaYLq3sfHdnh+pXMdJ6GYhrvpsjnLUgMNiLV2mZ8MTQ+pyceephcoOhHPt7yKcx7ED2n5NBAAQ+UIfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JvJ/1Fsq; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751980938; x=1783516938;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8oXAtCYZ6YZaA5hm919/2ydQPpixjVPANhtE949ADUk=;
  b=JvJ/1Fsq1/8d41NJ59Z7vl+Qi+C60cXHcQ5AcZiCCD57FlIYFjxoWz2z
   GU6KzBPDYkhAlhObz56kU7tadsInVFOpuTugdsu3arfvICKIAlpzZs2ka
   eaegpOfoj0mvW996rQegpPDAffOpQrjpetW+8DJiBfFK/LBagMVxh1gI0
   6UPYksfy5j44t6Sqj6vuiBx03vwqkt8/Z5XgVdhsJXBtLrTE0pLPjJAFg
   qNSVT4FMMqZipSkupIwUuoFlD9y6uRn6QHd9zAYcKmzP5+ktTFfI8DXP4
   t1ZyxGawswgYXKwXU6tPYSzcW5TmcJEqgyJ22pFP7tuahm6FgAxrBtAma
   A==;
X-CSE-ConnectionGUID: P+jdNL3IQX62McYdtgmqdw==
X-CSE-MsgGUID: nkr0qqqpQVaqgYK04vp2Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="64468404"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="64468404"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 06:22:03 -0700
X-CSE-ConnectionGUID: fqMj9hsuSpGnNw9sXm6XIg==
X-CSE-MsgGUID: JnPg00cJRNuj/HLJm6SwUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="159817357"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 06:22:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 06:22:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 06:22:02 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 06:22:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inxO/TEgp/OKWHrhI0iQ5oZYFPrgaDUZepzoz/5BLfym3J0UFf6QOH3gMoUsGlKp5RI8vCJ3bjPxEZPxAb1/x72FeHJ2T31XvLWiq+7D0ILW2kGzjXGMOtIDVU/JpwjYm2mFBwJObL6mmqB+jWDkxgHeNPz99FsNAQHKcMVe0P3azjHBKNuGIGgVAdG20xia6rNu/6LqVh9dxyyh8NO1OBpAx10i68hjTZdivOPYYV5YlIhQt6fpkxRU4oJWllGfveaqugPFc57VrzV6NAlDv/TMj4Uy7pl/hmcBHTpW+H3gdkPkpIQUIc95vO0K780dyyRexKc/dZu6pgkzzon34A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oXAtCYZ6YZaA5hm919/2ydQPpixjVPANhtE949ADUk=;
 b=KlTg/yJkMXuiFqVnY9SKtgPJyByn0pbOml+/jtIh2SHhjXNK3MWb5qn5ygoPKKvdq4DDBiS8ufJEPreREVB3H5WWPJLujKEMPe3p9Srvud+qJHWh5uWXrhuecmRl5SDpBqJinwnJtpkRnWYj+urut58AsHRUcGwnwyE9YQ+4sA63cypmkYyo6VKbu903uaAptVG2aE6ISYCfrDYMKyObQY+mP/Dk5MWgU/0b0k5ai+K4YzMLcvroFwB+MY0J6K5jx5DAcxjPKkafqGqpLJsVKb9wnQxZmCvBjY+LEtZR9pBWfoLofgLR7J5ZJON94gxF/mEea5aJP4bgJ9vW3M2dSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6252.namprd11.prod.outlook.com (2603:10b6:a03:457::21)
 by PH8PR11MB6609.namprd11.prod.outlook.com (2603:10b6:510:1cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 13:21:32 +0000
Received: from SJ1PR11MB6252.namprd11.prod.outlook.com
 ([fe80::9dc9:52bf:6024:cd95]) by SJ1PR11MB6252.namprd11.prod.outlook.com
 ([fe80::9dc9:52bf:6024:cd95%6]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 13:21:32 +0000
From: "Otcheretianski, Andrei" <andrei.otcheretianski@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [RFC 4/5] wifi: cfg80211: Add cfg80211_next_nan_dw_notif() API
Thread-Topic: [RFC 4/5] wifi: cfg80211: Add cfg80211_next_nan_dw_notif() API
Thread-Index: AQHb48SkUbQH245Ewkq0QftGpZDGgLQWt/ppgBGWA0A=
Date: Tue, 8 Jul 2025 13:21:31 +0000
Message-ID: <SJ1PR11MB62525B284D5BCBE96C015802F54EA@SJ1PR11MB6252.namprd11.prod.outlook.com>
References: <20250622222444.356435-1-andrei.otcheretianski@intel.com>
	 <20250622222444.356435-5-andrei.otcheretianski@intel.com>
	 (sfid-20250623_002844_715376_FEB65046)
 <d7c932775750d9f9be6eee470a52ec3b34a7baf7.camel@sipsolutions.net>
In-Reply-To: <d7c932775750d9f9be6eee470a52ec3b34a7baf7.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6252:EE_|PH8PR11MB6609:EE_
x-ms-office365-filtering-correlation-id: 7089548c-fcd2-41d1-c664-08ddbe225af0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SEcyRVNMbXcrUGRlMktYQkd0K1VDWkk2aDdtZDdpRVZlT00zQ1JvNThsUmh6?=
 =?utf-8?B?aFZTVHE2T2RTbTRzN05DVnhvUnlHTENDcDhrM0Q5cFhCNmhONDNRQTlqRENs?=
 =?utf-8?B?akxjemFIbElnbEhpTVR6cW02VnBuTnhBWTJldW1EcE01eFpGTS9sSENCWUZt?=
 =?utf-8?B?ZnJ2M290SW12OThqQmhoZmxNN2NNYjBYd25MYlZXb3BQTUJ3ckI3RHUrM1F5?=
 =?utf-8?B?RGlEY3ZIVFFFT2thK0FnS1ArUnlHRVBSM2plZFhYRmRMUm54a0NLcXgwUVJV?=
 =?utf-8?B?OTMvM0tvcGcrYjNaazNzQ1I1SnN6Q1FQaVlUT2pQS1FXOWZnQTNRNnNVclNh?=
 =?utf-8?B?ZS8yTWEwZWNTUHpUbklHZ3NtRFlTKyt0amgveCtJeENLYVV3QXErdmI0WHVp?=
 =?utf-8?B?VWtBR3NTbHBYRE1zZ3g4VVJyWmc1SHFtZkE2TkgyNHpkYk5uY1ZWM2Z2LzRN?=
 =?utf-8?B?VE9OZ1NBejBGQnZDMlFKd0tyQmFCVksxUHZ5OGh4Z0VVMDVyMDc3QVRPVHI1?=
 =?utf-8?B?TFVBa3BMcEdtcHlvaDhQbmI1NXlaVkFqZkFweXNSTzFnZWNEdHVqd1lEMnBI?=
 =?utf-8?B?L0pvSmJucjlIdkQxTnpxY2lhNzF1L25SSXF1Rm9tOUhhRDN0OS9kZXdIdk9v?=
 =?utf-8?B?REFRNU9kNzlTQTRjL3Y3SGVpSjZtN2I1enFqZFdZbURoT3p1bjRFM3dWWldz?=
 =?utf-8?B?OUx0WnV0LzRCUHUwODhKVTVWMHJGZ3JaRFZvSmQvODRkMWU4Uy9QNm80ZDhm?=
 =?utf-8?B?MFo1NlhSKzZUWkJUNlV1TlVIOStHZFdWZTIrV2hvbTdJRnJFNlBSRU1KalhB?=
 =?utf-8?B?RUwxdE1IWXJTNVZEQThhRkVpT1dUdXpVYTUwTEUreEQrc2ltZzBDUk5FbWpY?=
 =?utf-8?B?QjlrcVFxWVZrSVA4Ym5LbUl4UThpMW1uakd1QnhieDUwcnRxa2VCdXhPcmk4?=
 =?utf-8?B?U0E4d0JNYnZSRFJsaDk5aTN1SWJvdVdRcjNZRGlFcGg0dHcvOStBeTFEWWJR?=
 =?utf-8?B?YllPeldwRGc2aVpBSkpFbWlIc2Q4NTZhSEx3eVJENi95WHB2MGFTM3JLRlNL?=
 =?utf-8?B?OEplaHZSd0Z1eGRtY2ZRRFVCeU5ObzR4ZmcwSCs2WU8wTit1SmF2SDJsa01z?=
 =?utf-8?B?S3lsNVVMRncvQ2daeW8rWms4TmIvVjlkV3NrU01xNG81Rmd6TC96SWtCVHkr?=
 =?utf-8?B?dUUzRGw1SmhJdHVPWjN0emRLQW5DTGZWTFJzb202b01MVEZncFBJVUJUMFhJ?=
 =?utf-8?B?RGZpVGxCUEMrN0w1SktoY2FWV280eGtTSk1ZaGRjSUQ3aWJGTXl2YmFaSGZS?=
 =?utf-8?B?TVdPYWo4amJieHRDMzJEdHNncGphTWhQVnRoMGNSV2IxS0g1V0RCbUpxYnZ6?=
 =?utf-8?B?ZmxLYWtGaGlRT0J2V1p0WTdYK01yRFhwQS9pTDdIRmJHelpGVkVhTlhyaTNN?=
 =?utf-8?B?eVNzODVSZHhKdmZJcE53RGo3aVk1dGNXRTdnT2lKdW1jODV4SFo5SGpwUFdT?=
 =?utf-8?B?clBQMG5TME1Ddis3bDJUWUw1Y0pPRHdKYlZ1a1hQYklVajhzeXlORmg4OUZi?=
 =?utf-8?B?d3RtTlNuNEFXREhBNEZWZ0RnbWJmbVFyN0FsQnlHUXFIdVBSZGgvVTV0aXFp?=
 =?utf-8?B?T0Y0ZHpMckVhRjZtSVJiTFY4ZEFLRGgvWk05SUFsekpRczg3L2NJTXBsZXJI?=
 =?utf-8?B?bEhBcmVVS2tzSzlFaFZQa3JxcnVRMW9yN09oL3BuZTZ1WWM2Q3lYaFArLzk1?=
 =?utf-8?B?bDJXUEFITVp5NWVjT3pVcEpHdjBpQ2h1RkE2dWdRQzl2UTBYR29TbFNoK09S?=
 =?utf-8?B?eTg0bzZEVEVlczNCUW1RYTF5NVRsdjV1Um5ZL2ZiNXRNb05LeWFWRE5FKyt3?=
 =?utf-8?B?ZnJXcTdkZTllbFMyWlZaT0Qxc2hWVFVST2NRRUxIRXNQcnpDdTBKZUFXUmor?=
 =?utf-8?B?UzFaWTQ4QVJuK2ZvUmFMclJ5NWhvMXI4RlE5TEUveGMrQ3JxaU91QkFJMzRJ?=
 =?utf-8?B?eDZBSGVZa2hnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6252.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHlqKzcxcjNwMmZsMjBCREF2clRHRXpxQVdadmJGTC9JQlFGMWNIc0tKNVdT?=
 =?utf-8?B?NUZuT05UTmJlazFIREx6Tmdtbi9BT21Ea25PK0hWSmoybDNYZDJpd21YTkdC?=
 =?utf-8?B?UXdOcWJIUUxlTHVmcmZlNWJuZDQzcjQwUlhaQWR1YzZKWjdZZzhuSU52b0NX?=
 =?utf-8?B?WWxkaSsyWGlVRUFvdCs2SnFXRzJkb0U0QWtLT0o5QkFmQ3lWSHZhVnp1Vkd1?=
 =?utf-8?B?NHNZSXR1UlVyNWJ3RVVVbXdtdGZUUVlySDBWWUxhUWNlbzhyTDEyclFiMi9C?=
 =?utf-8?B?dk9zSzV5T2V5S09RY3Y3amR3UnBWOVJ6R0prejdnbTIzd0FqMVlkbVM5cjJv?=
 =?utf-8?B?UDlHVnR5MC8xWEhMOW1zdHVLdzI3alAvYVh1QzUrcFlLdXQ0c204aXY0b3Ur?=
 =?utf-8?B?eWgyWmhCRjU5ZVk0VHJ2RnVQTWVPT2NpeThVNWZvUWk0czg0aTBsd0V0MkN5?=
 =?utf-8?B?di9WSjFZd1BNYVFjTFdBaGozWFdEV0FYc3oxcDV1UEMvS2pwK2ZPa3djbUxa?=
 =?utf-8?B?L3hjUkV2SURKeThwUHR2Mm9XWWJXdk9LeXhrT2ljVVF3RlNUWVdVMzVqU1Nj?=
 =?utf-8?B?aU5mRFNQKzk0YzhRZGh3RWV0UDYxcFU4MC9rUW1va2NIK0VoSjdFVXkzY2JM?=
 =?utf-8?B?S3MzTVlpUGpDUnFrMGd3TjYzWjlMVlRWek1Zc0hnVGxucUc1YUUzSWNDMHRO?=
 =?utf-8?B?MUFnaDVYWHc3ZFRtdEFibVhaZ3JQS0llMWF5VGgrMVFFaGFhcUs2cWp4R1p1?=
 =?utf-8?B?ZDlWOWQwNENwYWYvMHRzQzVjUkdJV3gzVG9rNlAxY0Rzai9JUS9sYlVISXJH?=
 =?utf-8?B?WWVid2hCOVVPMk1MMkw5UytaeHkwSG1iM2I5MDdDMWJ0dWw5Z3dVYTZMRUp3?=
 =?utf-8?B?aHZYQXI0QnVlRUxzNFhMU21MblpXNG9kV1BZV2YwK0d6VDVCQVovUFE5Tndn?=
 =?utf-8?B?UlNRMUNyOFN2NUJBSjhFZVVOQnpHZlJHTTEwRVYrcEwrN0hLSi9jT0diZXAw?=
 =?utf-8?B?UmRPZkFyamJUVi9rc0FzWEZnTHdsNmxwQTdUR2ZNY2IrTVI2b29Sbnp5RDNj?=
 =?utf-8?B?ZU5HWDZmTk8yNDJkR0FvbDlyN1cwSExNZEFHWVUyNmpYS2xCekpkVWdXMGtS?=
 =?utf-8?B?bkNsd0dDdUVxajNzaTQ0dSsyQXJva1BXeFJ3MTRuY01GcmVDUlpJNzhSQmhh?=
 =?utf-8?B?TjdPa01xNWpxYTVtQ3FRZ000Z2F6SXB1eEtXeXY2RmRBUnhVSDhMbjZWQ1lu?=
 =?utf-8?B?ZHZVTmIwd0E0ejQxTG92eUNqU1UwdW1WVFhwN2h1R2VmSkVKZ1lUUTlaT2Q2?=
 =?utf-8?B?QzViSzE4RTVnSkJlQ2FxZ3V6ODE2SVBSeG5aNHpFcVVMTVc0bkpJVHZzSGRz?=
 =?utf-8?B?eWVnbE5jVzJ4RVJBUFl4ai9GOVVCWjhJYWpWN1E2T2xmRDBTOGM5aTNqTjRu?=
 =?utf-8?B?UTMrUzNxVjFyQ1ROZzVNZXZJajV4bG41QytyMytPb0liRTBEeEQ3UkhKcWRw?=
 =?utf-8?B?VlRmQXRsaGNORCtscXpOU28xc1dJN2FodnZKcC9SNTFBNlVVWWErNnRZVXV4?=
 =?utf-8?B?d0FORFBDcDhwZytmY3E0MHN6aUlEbFA5a2YrNmdBUlV2VFdzWVR5cDNHNmlp?=
 =?utf-8?B?VGZjSmxPcStrQ3p4bUhhQVFLbFoyYXhtSjV6VHhGSUp0MWJBbEUwQ0xsK21v?=
 =?utf-8?B?NFJSWS9TU2ZIVXV1akRVNU9RQ1czZUhUbk9ERUN6eGh5enl1L01iUkVYcnBm?=
 =?utf-8?B?dm44Y3F5YURKeFZTajFkRlNxRWI2MVR4Nkxodmw2RGFkckdJb2kxait2Qndr?=
 =?utf-8?B?aFp5OEZYcWloaEdZU2N6UVIvcVc0RnBzWEcrRmo1RXJRQnNkNWpkUDhFQlQx?=
 =?utf-8?B?Q3FaV0IrWU9ERDJWZVgrQmlRS2JINVd2Ync5MUwzZzdieHZERmVhVDNOenZv?=
 =?utf-8?B?VXQzUXkyL3E0bzNXQlZLR0FsSmxlZVd2TDRJazg3eUxOMWVBanVFTzlocVhU?=
 =?utf-8?B?SjBwU0VidXRvbGpPeFRyUWdkVnRjSkoyWmRqTlhIb0llSjcrNUdoajZ5a3Fn?=
 =?utf-8?B?cGcrNmFrSmFZRXZWcVpOOEhYTERJZld4S1hKMUg0ZHZsL3ZvRnhKTmtEMTAz?=
 =?utf-8?B?MHdnRlhjc3k0VGplek92VUxUYVB4ZlZEdEpKRTM4QXdFWE9mV3JhMzlJTGJr?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6252.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7089548c-fcd2-41d1-c664-08ddbe225af0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 13:21:32.0047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3HpSfE58ReTiu4lT6ichSKgceA4HwI2IWj0Xz4XEOV5ln2xt+dp2C6G4Aw19RleSw9dWtAtV72XcOmXxtuWdfGssIEM+U4oiwwOm+XmSj94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6609
X-OriginatorOrg: intel.com

PiBTZWVtcyB0aGVyZSdzIG5vdCB0aGF0IG11Y2ggcG9pbnQgaW4gc3BsaXR0aW5nIGEgNjcgbGlu
ZSBwYXRjaCBhbmQgYSA3IGxpbmUgcGF0Y2gNCj4gKCMzKSB0aGF0IHJlYWxseSBiZWxvbmcgdG9n
ZXRoZXI/DQoNClN1cmUsIG1lcmdlZCB0b2dldGhlci4NCg0KPiANCj4gPiArCWlmICghd2Rldi0+
b3duZXJfbmxwb3J0aWQpDQo+ID4gKwkJZ2VubG1zZ19tdWx0aWNhc3RfbmV0bnMoJm5sODAyMTFf
ZmFtLCB3aXBoeV9uZXQoJnJkZXYtDQo+ID53aXBoeSksDQo+ID4gKwkJCQkJbXNnLCAwLCBOTDgw
MjExX01DR1JQX05BTiwgZ2ZwKTsNCj4gPiArCWVsc2UNCj4gPiArCQlnZW5sbXNnX3VuaWNhc3Qo
d2lwaHlfbmV0KCZyZGV2LT53aXBoeSksIG1zZywNCj4gPiArCQkJCXdkZXYtPm93bmVyX25scG9y
dGlkKTsNCj4gDQo+IEkgZmVlbCBsaWtlIHBlcmhhcHMgdGhlIG5ldyBkZXNpZ24gc2hvdWxkIGp1
c3QgZW5mb3JjZSB0aGUgb3duZXI/DQo+IE90aGVyd2lzZSBob3cgd291bGQgYWxsIG9mIHRoaXMg
cG9zc2libHkgd29yayAuLi4gYW55IGFwcGxpY2F0aW9uIHN0YXJ0cw0KPiBsaXN0ZW5pbmcgYW5k
IHNlbmRpbmcgZnJhbWVzPyBTZWVtcyBsaWtlIGEgcmVjaXBlIGZvciBjb25mdXNpb24uDQoNCkkn
bGwgZW5mb3JjZSBoZXJlIG93bmVyIG5sIHBvcnQuDQoNCj4gDQo+IGpvaGFubmVzDQo=

