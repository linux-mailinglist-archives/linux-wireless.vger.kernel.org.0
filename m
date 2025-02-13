Return-Path: <linux-wireless+bounces-18917-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B459A34079
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 14:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A9D3A9001
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 13:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BD423A9AB;
	Thu, 13 Feb 2025 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OmsSl0oS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75039227EB5
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453766; cv=fail; b=owgM1CuDjcKT1lVYMxlBeUr3QAT3cb4E3XxoqdZ+IVBXMcg3M/GN0hoA/hz4y43dmMKWto34MiUaREHKAFUhE8y5Uv7uL3RHiX6HqVMqNtlKvQr8ytPfOh49DxbmZE1HXfUWhDv7uv/W8eBGzY3tz4Ukf5iVQOPlXPjtRvLH0Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453766; c=relaxed/simple;
	bh=Td4KHqrgyJJM3RVdDYpOIx83o8h23ytQ2u/DmAyAGoU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tJ4OakDLBYT9cboaQelwTaIlvBE2eD56SQBcrLib/NtHOsQDgmzn/1wAG+J1fEONvFzVh9wZPQ7sKJ9z1QrHT45gcTDton/M2w2OSN7qZ3HM8gi+3+1y5XFcibbpro1ftWBD9VPLEz/Qhu1eNtV9db1dyPa4eIIe4Psp6AnbXPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OmsSl0oS; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739453761; x=1770989761;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Td4KHqrgyJJM3RVdDYpOIx83o8h23ytQ2u/DmAyAGoU=;
  b=OmsSl0oSXP9pDXLH1UxJ/9rQf1lrYnq0H6AiFyaQ238aNmNvNzHcCNWr
   EsnSn9755Euu4joiLOwlG6ogAjHSMLlxKKPYq8ucUaYLV2yGiA0uKKRJh
   k5X4qqDUNBlzPUa6AGPQWcM38aKxVp8KHynHCWGMiDSLRpINQmiGIVYpE
   4RrQpLusUGglHKBLp+z8kwl/EWsp26luFVk/fuxFVV/2eqQWKoZ6bUrly
   DATF462gFUG8aRs0CVYbB13XGXF3ljde1Iy/vOuSKjHq2w8fzxoJtEaqi
   1nZx9505jD2I8C7xjWv3h+7soWp/uuCUOlCXg37jzltjoZjRR/sGgC+XG
   w==;
X-CSE-ConnectionGUID: 5JoFC23dQUyYIzPQ+LRoDQ==
X-CSE-MsgGUID: UpJYfPbVSUavoQ49hLZazw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40186701"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40186701"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:36:01 -0800
X-CSE-ConnectionGUID: CnwLsQpBRyaTUFKotJdtLw==
X-CSE-MsgGUID: xL6mmcYyQ0SdvvYrn0sXgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117257883"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 05:36:00 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 05:35:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Feb 2025 05:35:59 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 05:35:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjKSIi2zJOIOvzk8AAmNPKIjymq9To3UFRYwbCFTs0bn+xG0hW7YjO2Kj1csUxsy02CeaAuK9Bv/dXZzE47JjhZcXHN1UxTL2naGUml26csKZeEgnezHXTFlL9DNk4uYzI349IaaNjRm1aYGCgM9rHbtrH2v3xiFA7O0O+0dlZKjuQZ2eq+ssHpD/Py7nXjCnhdwzdwzi/UV0O7MZ1uZckh8bTRDL+/TDowH4jpCg345SCeP/k6Z2IM5zSbbyZrizzxlFw9X6vmJ+K9xqZKNdthPcyxjIL6JmWgsK32OtN0DkcLjv53X7L1jmXyZCB6QP3N1TFu6OqdZ6l0UM7LW/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Td4KHqrgyJJM3RVdDYpOIx83o8h23ytQ2u/DmAyAGoU=;
 b=RBjXbJfS5jTjQh7VZ0PFYimQi32CwJejSYrYEWqHAoTXzzTRnIEtYwClC4alX1CebDmIgjOwvHvY2VIHmQUxEiCL4S5pxapmKGPGKXPFgvTq9RsfsaPuHcUrLfT6tS5icpG/94ASIonvmOYFk/wBABi9iQKLcOLCLurdkE4w5mtKwNmwkB66qJ6nu3nAtTAO3/hlqYENOTWFyiLxCxstO3euhR/2GVE0gRcF3QGOwP9H9FK5lQXvygyf/dR9t8rh3gY1w0ZEgCbPc3Sj+wcB18qZ2DBHBA9VfKvmGsa9UGRZpYZKic5e3c6+Q3O9DrGo8YMQseMzALABxSoguJKIfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6043.namprd11.prod.outlook.com (2603:10b6:8:62::8) by
 CH3PR11MB8561.namprd11.prod.outlook.com (2603:10b6:610:1ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 13:35:55 +0000
Received: from DM4PR11MB6043.namprd11.prod.outlook.com
 ([fe80::4e37:abb:3577:fbf1]) by DM4PR11MB6043.namprd11.prod.outlook.com
 ([fe80::4e37:abb:3577:fbf1%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 13:35:55 +0000
From: "Peer, Ilan" <ilan.peer@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [bug report] wifi: mac80211: Add support for EPCS configuration
Thread-Topic: [bug report] wifi: mac80211: Add support for EPCS configuration
Thread-Index: AQHbfe1wl+Zs8RASJ0Cwau5XJr6HubNFOmaA
Date: Thu, 13 Feb 2025 13:35:55 +0000
Message-ID: <DM4PR11MB604318E3B7B56B57216E0922E9FF2@DM4PR11MB6043.namprd11.prod.outlook.com>
References: <1f7d9499-5183-4d4c-81f6-dd43899d6746@stanley.mountain>
In-Reply-To: <1f7d9499-5183-4d4c-81f6-dd43899d6746@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6043:EE_|CH3PR11MB8561:EE_
x-ms-office365-filtering-correlation-id: 6d3817d8-393f-474f-859b-08dd4c3357df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SXVhVVBNanM1bVM0RWJyYmg5NnhpbXJIU3dIQmdneG1VRGg0RnBUQmUyL0Na?=
 =?utf-8?B?Qkp5MDg5RWM2Z2R0Smh3T1F1Uko3VzFabHV3WjQzTlNjWmQ0emRTS09OazVW?=
 =?utf-8?B?VkJjckg4ZE5DNCtnbDdsSUZkYnNxN0pTeGlTK09BNERYb3VOUlRXQjcvby94?=
 =?utf-8?B?eXlwcXdTdFhnMS9ocjBldzhXUlVHSWVtaFFtZmxQQWxKcjZzWFFDbG9MK2dQ?=
 =?utf-8?B?NkQ5UkYydWpqOTRGbUU1eHJXTm1MNDE2UHFtdzlCVklYREIrRHhuWEdLQzgz?=
 =?utf-8?B?bUdQYjkycWpDb2hlcktuUU1jR1FNMUhwY0NzS3U1blB1NGI0ZllJTXR2MmFu?=
 =?utf-8?B?ZUpFL1JHNFZhK2Zyb1BKMjdMeWRwandNZlhMNXNPVmJQaEx6NCtINEJ1YWl3?=
 =?utf-8?B?ZVN3ZGVKL0toVXdSRG54dkFPb3dMeEYwcDJmVktiM25qL3h6czQyZW9JQUR2?=
 =?utf-8?B?WnRlcnpVV0RSRnpOU3dSLzJ3QXdzVUZCQkdFczBJV0ZmdVlBWU5NNWZIOGNG?=
 =?utf-8?B?Q2xIM3lXcFg1U2FOQU1VWWozK2IvZzFYazRTQndnT0lzSldqam1zeTE2dUNU?=
 =?utf-8?B?WHRkK0F2SlZKY0I2S1Vqb0t1bEQ3c1FXbVVjeWxhNHppUDJsdCtmMjFtLy9I?=
 =?utf-8?B?eFZIM21qZWFmVUxhWExlZ1hmY0tjc1dQYmRxZFpOOVd2QUwyK1hnQWcvWXNK?=
 =?utf-8?B?dDFHMklXWUx0azVLV0Fiajc5Ti9ReVRvNFFrT1dVWUgwaDZrZlVNV1VzdVND?=
 =?utf-8?B?NENmTENhamhBOG4vY1pJcFZPaTdZNkhHYmM1MkdLZThRTlF2L3l6a0p5OXhX?=
 =?utf-8?B?TzFUMzJRR1FsMUtDWTFYdHJndmJnc1l1Vzc0UHdKWVo0cXNRdDBYTGFrQ09G?=
 =?utf-8?B?Wmt4OXZDK2VMS2NXb0VGdytHdXZMTGY5S1Y3MXdUNVZveXpwTWgzSENpblg3?=
 =?utf-8?B?NXZ1TFJrdTIyNE54KzNwTkkrNWY3TW40RlpFTDh0N29xa1d5UmdldW9Cdy90?=
 =?utf-8?B?dmxiV0xLbUJEUGJHTU43d2hXeGdtU2ZrUlVVODNGb1RGZWlMd1YxRFNBTnhX?=
 =?utf-8?B?SDFWdnRXU0x0UGs1NWlsa1hwN2pjUXpFMURCTFJPR2RzblZyUnozRklSa3hW?=
 =?utf-8?B?Uy9ZOGxrdVBmSjRFWTc2RGdvYmJ0WkxKbkp4Njh0NmN4eThuU1JQem11cFox?=
 =?utf-8?B?cFRib01BRDExemlWYU5ZNHpjQjZDUWx1cjg1WkQrK1E1TWlReTJhTzQ1VWNw?=
 =?utf-8?B?ei9JK0hycTk1d0hMbzJMZ0Nrb01DbEZERk5aZEZZUU5tWmRqbDhGakNQM2J6?=
 =?utf-8?B?RGNYd1luM2Fyb0RNMGJSQ2p0TXk2SkVSd0Rrd1YzaXFyVldWOGJURXc5Z1hM?=
 =?utf-8?B?QUFGcmJ3TGlhUCtKd092U3Y1QnRSdG9lbmVnejBSOEpVZUhHYlNWTVBVTjdT?=
 =?utf-8?B?RExySmhXYXF6V1dmUTJuY25YMndIL1NnM2VmaWpJdTBFeDZZMGpGdmhEbkNF?=
 =?utf-8?B?c2YvczI4VmxEamp0QzFITnRGMWFuRUJ0N2FPQ2hQTm1Qd1pSUEVQNmpCUlps?=
 =?utf-8?B?Q1lTTVlhWDBDYmJXb3hrRE85dU92cGl2VXpFbW1JNDY0WDNhT1d0TlJRZWNz?=
 =?utf-8?B?SEc0aFhyalV0V1VIUWtHbEsvSDU5TzBhSmoxTDI1eUtjR2J4Tlg4TksxMjJN?=
 =?utf-8?B?aHJ5dnRaNmViaTBzc25jNkpueW9NWXQ3U2dvcVdKKytoT1lOUGIyNDM5cUJs?=
 =?utf-8?B?UDRGL3dpTXBHU0dDbEUzQkp6dlhxWlJ6TUthVlVRaEtUL25qM3VGK2ZSUW9y?=
 =?utf-8?B?TFFFbGc1Z0ZWWnJuRWxrRUdKM09ERkphMFI0V3ZMVlZPNzlGNmIzb2JPRGJT?=
 =?utf-8?B?Qmd3cENmMHNEYVFRVGE1dlFsOE1QUXVSZTY1SWE2NXk5Q09rN21OTWtaSC9U?=
 =?utf-8?Q?8jmZNmWqhbsCwztI9OiW8tbbwYQfwZ4Q?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6043.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGtjYnFndSs4NXMzVTlPbU1scmZBZ1BGZlo2YTk4aHRxSktHM2IyelZLVUlY?=
 =?utf-8?B?QWJTTEgyWG9NRDRxRDhQZjZ4MVlaOHBiN3RJTnRxazJMTmZkb0psQVc1b2dQ?=
 =?utf-8?B?NU1TdXl6UnkzUE5Qd1hjYlM3TUVtT2lPOXZZakx0amtIWWV1eGVLN0RjbkZ2?=
 =?utf-8?B?YytZL2ZPdmkraEZqQklDMWhpTWEvZGlodWdYdzQ0VXA3T3U3MGFKekZuL24x?=
 =?utf-8?B?TUZuQmlPajRBNStnSzJ0NmpNSWpKUDBiNlJQRHl3d1p4Y2NURGpNbDN0VXJD?=
 =?utf-8?B?Zjh6RTZkVDBTcjRFRzFydGhGVWJYbmwwWDhtVW9kOGdiUUt6M0sxMXhtL3Ju?=
 =?utf-8?B?amtWMXVCTHBibE1sd3JEa25UN1dtTkNHdnY4dTNNZXV5enVYZEdJdm1DRHp5?=
 =?utf-8?B?Q2N0S1NvNW5FNkk0Y0dheHdXZGprOVk5UHd0L1JhNDlUTnZrTlRubTVxT0lH?=
 =?utf-8?B?bGdHVnRsZk1Qb09zZDN6OWZROEh0TGFpaXRuSXdPaTBzNUxKWS9jTDJ3MmQv?=
 =?utf-8?B?WE1YSmlReVBXallFVlcwanRLOEhFMGRlR3h4eFIranlpRno4Q1liSWlmWHMx?=
 =?utf-8?B?Q0FWMWFjVTVEQ0d1cm5NdzJIOUFKQ2tnM0lnTjg1eGNLK1pkYmF0aU1KcVRt?=
 =?utf-8?B?WURCZWVaMjNldnZJdUtJbXBaaWI3cEhLcmF0bUVRcW1KNWoyQXQxUEtDcWlh?=
 =?utf-8?B?aVUweVZOSGlydER0N0hJa0Z1ZWFwYnJVZFVRQVh4WXdRNDVkTnRQUHZoWVdu?=
 =?utf-8?B?R0l5dXZIdEVQYll3THFsRUlhNndObUprK1BkMTVvVHZLbTY3dzl6Mm1SNDNn?=
 =?utf-8?B?VFJsZ1BhYXQ0bmlrajY4UWhkOEx6QVlIWWJCZzZzSlBmU05scElQQUFta1d0?=
 =?utf-8?B?eFRjdXlWVzhlQTd0YW5TTndEcGtBWWNKWlNLbXdTb0I1RllOSjAxNjR4VGls?=
 =?utf-8?B?WTdvYWk3OCtSN2RUNEtrcUdDK2doK25yTmYrWm5HWHdCZDNpWjRFZUthZC9O?=
 =?utf-8?B?S1FNQUpDaHNsQTNpUDhVVzJPdWo3eVcvZHBZWHBTdWdVejYvTGtDaWkxOG9K?=
 =?utf-8?B?aVhET2xHRjQ4d3J5QjdodGYzWnpXUTAxUFNEYUpXSk1mbmlETDQwZU9tdkQx?=
 =?utf-8?B?akxkZDNiRXhjZGtmNnduUnJ0UHM4MXE2dUV0VVhRbm5HajBkNVpIR1YvOXVn?=
 =?utf-8?B?QTM5QlNZbXlwSWVlYzRUbmp0U2loZ1QxdkVoenJFRzBxLy9JYXdwWW5na3F0?=
 =?utf-8?B?QjdtUDZwb3d4RmtlcG9meWVnVDVGMzR0SGdwZTdTQUo2c1ZJTmVKb2w0RTk2?=
 =?utf-8?B?ZUN0SEFkcjVYN1ZjV1l6dkFDR1R6MFBiRmlPWWU3c2J0OUkxakZnYTVnTVpn?=
 =?utf-8?B?WDhCQ21SWHNvbi81TU9NanE4bEFNQ0Zoc3RKMUxSN0NCNEQxU2F2RUNiUGFm?=
 =?utf-8?B?dHVqaURqTGhzcjVNTStna2RDNGFDSkVFYU4ra3V0UDExSWxDRzQzODIyaXl3?=
 =?utf-8?B?dG1MKzUvT1B6R1hXWm1nTGgxMjJPeDJ2TWdWU05hQUNHOThGYjhkWjNIY25V?=
 =?utf-8?B?MnRjZVk4MUNEcS9qSXZkN1E0Y0N0bUJtWlZuTkNoVDVhZ1NPS2xiVTluZElp?=
 =?utf-8?B?VVNnZmZNeHRLM1dQN3lHbjJBdGZienRYOHhEcU1aQnBMM0JGVE16bGxqN2hQ?=
 =?utf-8?B?bjFzczJBTlkxQzJkMkdTVjB4eUdIODZLaGU4elFMTHlsR0IwcFlZVFhWUXVS?=
 =?utf-8?B?aXpCRjAxRTBvT0FXaG1HQWoyQUxuOXpSZG00bDN5UENSS01iSlJzaFZUN3hu?=
 =?utf-8?B?S0RzZzZ0TGJZUHZ5Z0hlWTNOZFdQNVN2RGFFR1NhRnc4cGtlMXExdWtmeHRn?=
 =?utf-8?B?WHFoeEtqSWdYdFg5Nnc2ajI1MVZqWnJYUXdGOFFXQU9hUkZETTAyMjhqa0cy?=
 =?utf-8?B?U2RGRnpDTHF5MHd3N0hLbXh2eGNyN1E1SEJRZ0VXZ1JVV0pDaE5kWnJvU1dL?=
 =?utf-8?B?NzZMMHN2czJyRmJKN0hCakZqUThhbm1kV1RMQjc5TW9ORG5Ta2dCa2YvdVB0?=
 =?utf-8?B?d0NBQ2FaVmpDZzVsK1A4RG93NEw4KzVOcU5WNnppbmdMTFpWUmJlMjUvS0k3?=
 =?utf-8?Q?hATs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3817d8-393f-474f-859b-08dd4c3357df
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 13:35:55.7217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4KvUED+YlKt5DkFGzPjW/quh/fYegGV4Lnj69sdVWdR22E+pX2IvgLDCIZWP6/kKOJXnqnC//ViOqRMPYTaGqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8561
X-OriginatorOrg: intel.com

SGkgRGFuLA0KDQo+ICAgICAxMDcwNCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGVsZW1zLT5tbF9lcGNzX2xlbiwNCj4gICAgIDEwNzA1ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2NyYXRjaCwgc2NyYXRj
aF9sZW4sDQo+ICAgICAxMDcwNiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIElFRUU4MDIxMV9NTEVfU1VCRUxFTV9GUkFHTUVOVCk7DQo+IC0tPiAxMDcw
NyAgICAgICAgICAgICAgICAgaWYgKGxlbiA8IHNpemVvZihjb250cm9sKSkNCj4gDQo+IElmIGNm
ZzgwMjExX2RlZnJhZ21lbnRfZWxlbWVudCgpIHJldHVybnMgYSBuZWdhdGl2ZSBlcnJvciBjb2Rl
IHRoZW4gYmVjYXVzZSBvZg0KPiB0eXBlIHByb21vdGlvbiwgdGhlIGVycm9yIGNvZGVzIGFyZSBj
YXN0IHRvIHNpemVfdCBhbmQgYmVjb21lIGhpZ2ggcG9zaXRpdmUNCj4gdmFsdWVzLiAgVGhleSBh
cmUgdHJlYXRlZCBhcyBzdWNjZXNzLg0KPiANCj4gSXQgd291bGQgYmUgZWFzeSBlbm91Z2ggdG8g
c2F5Og0KPiANCj4gCQlpZiAobGVuIDwgKHNzaXplX3Qpc2l6ZW9mKGNvbnRyb2wpKQ0KPiAJCQlj
b250aW51ZTsNCj4NCj4gQnV0IEkgcmVhbGx5IGFtIG5vdCBzdXJlIHRoZSBjb250aW51ZXMgaW4g
dGhpcyBsb29wIGFyZSBjb3JyZWN0Lg0KPiBTaG91bGRuJ3Qgd2UgaW5zdGVhZCBiYWlsIG91dCBh
bmQgcmV0dXJuIGF0IHRoZSBmaXJzdCBzaWduIG9mIGNvcnJ1cHQgZGF0YT8NCg0KVGhpcyBpcyBu
b3QgbmVjZXNzYXJpbHkgY29ycnVwdCBkYXRhLiBJdCBpcyBwb3NzaWJsZSB0aGF0IHRoZSB3aGls
ZSB0aGUgc2NyYXRjaCBidWZmZXIgaXMgbm90DQpsYXJnZSBlbm91Z2ggZG8gZGVmcmFnbWVudCBh
IHNwZWNpZmljIHN1YiBlbGVtZW50IGl0IGNhbiBiZSBsYXJnZSBlbm91Z2ggdG8gZGVmcmFnbWVu
dA0KYW5vdGhlciBvbmUuIFRoaXMgaXMgd2h5IEkgdGhvdWdoIGl0IGlzIHZhbGlkIHRvIGNvbnRp
bnVlLiBGV0lXLCB0aGUgb25seSBpbnZhbGlkIGRhdGENCmNhc2UgaGFuZGxlZCBieSBjZmc4MDIx
MV9kZWZyYWdtZW50X2VsZW1lbnQoKSBpcyBub3QgcmVsZXZhbnQgaGVyZS4NCg0KSSdsbCBwcmVw
YXJlIGEgcGF0Y2ggd2l0aCB5b3VyIHN1Z2dlc3RlZCBmaXguDQoNClJlZ2FyZHMsDQoNCklsYW4u
DQo=

