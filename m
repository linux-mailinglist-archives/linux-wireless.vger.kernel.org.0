Return-Path: <linux-wireless+bounces-32171-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HzVKbS+nmnYXAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32171-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 10:19:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F792194C9B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 10:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ABDDC300DF71
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 09:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3037438E5D6;
	Wed, 25 Feb 2026 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZ5StAVH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB8C38E11B
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011177; cv=fail; b=Th/DbAiD6/CKK+o7kHB3hlOTSKhguSU0Vj50dhIKDaH8FSl6pnhQLdCtq+kPKs9KXlMIjKlj+kvxNY9BGJGEI+fNsZOxTVViENxvGqIuhTzkZyiq2Tn8NmTo2OqASzb9QAN+BTA9Llf9PXKuIZRrir89Ols4tAHddCzNuN4M1kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011177; c=relaxed/simple;
	bh=NhtOq7+Vzka+smIKsh5gomhZAkeWvFiVkIWJdGAHqVI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jX0hf1t5jIfVfp5TddYtuzp8nHadfk8VfkzHovqx0/wO8Q3pTaYRGfCvZ5Jt9t7001BHUrAO/xbT8RfrX6Q9//dOCY/a9LD/z083N5P5175P0YxM3Bz7eyOQP6c1MdtjBUmgZqBLi3pjDj7KeR7/EZRwq31ZQmOepNLnStB2UFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZ5StAVH; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772011175; x=1803547175;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=NhtOq7+Vzka+smIKsh5gomhZAkeWvFiVkIWJdGAHqVI=;
  b=ZZ5StAVHJO2WE6BZ4cq+dpSmROzSIkEDnQGUL1UhPTnQtz2q2bgHbd24
   ztePrDnJyWFXxwuhSe6Z2nuIlE6iiKCNMEV+ZVDCISMudFNsgnHbX1dNR
   GpY5LrlsDr3eS7kpoAMiWvYdJdBvJmcz8nZ3+NtCgtXIOsLkWPb2+StJv
   VDyOg4LIQpcJQxuZyzvNPAdhAlIqG287sfEUpFqLxxxynmtmz44ijfqym
   Y09FWf/9DSJG45H9mprIQBAzfOrsOstWJzq8spmf01h7D4MyPw5e9GPFb
   bffzQNYpcywrK4Q1o6s0omN8C2hdLbmPkMRBEDrZ5ECM18K08PpkM5cFD
   Q==;
X-CSE-ConnectionGUID: a2nFxZFwR6y1IfFFpb+S8Q==
X-CSE-MsgGUID: vEj739wgRdSLqKPU8GJHQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="73150835"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="73150835"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 01:19:33 -0800
X-CSE-ConnectionGUID: PNc2fyEHTc+6gMC0h6G32g==
X-CSE-MsgGUID: XndB9rvITpCTziY2b0FKYQ==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 01:19:34 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 01:19:33 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 25 Feb 2026 01:19:33 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 01:19:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwGs7GKP/C7ph2oRDj2apHq7+Qnbrh30nFUNMy0m1kjB4yC4rh6qjTWWPifxbsCV3BjYf9RlSJq+QNeXHbQ19IVd59oj2v29CoPC79jKoUeTnHhcZarRnGcJC94zX/CN2o3nlyi0xpziwNt+K9qAT6aBaPy9bUrcv9DcComx73rXGvZl0luzlpvI0z4FFVjO9YxUlXfGQXwSyMoYiMzpAfSBHhDPpYlNDBlB1Wb+OmnCLxMJKe3FWg0eS1ry+99NaVOYpJybArY+BD8lzQbx+IUPcItAojCiOMnzybIkFt+2Rj+cTFEKhidauzuxxrYdXoiZ7aAr7Cn2hhz+U4FB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9nRxw8m9y7RxmTFcZV7sb5OKEPE5zNv/UbbaauXWfg=;
 b=w1yvUVOWV/9WfFf1txuQvAyMcJTo90CJ+pYxGPxa7LZbV8I2SVeQyXfBD6DSMH8C0duKIrKMAJh5CRhSFl0/3RSoL9sGV7G8K8baDAsPMLNTR9X7sIk2NPmpAnge6+RbC62T8Cx0m6OVlVyt9D6pSWt4lIw6hizej/XNNZJR7HJ1hMQ1NIjjQiqARGVe1iCHDx8hZFU0JN+cQQwcPDi09p0Eb/U3dUEM2mHlrxF8Bp2wH9HHRsukZWtNpkb/xWWxhDU8ubQd5UQApC+ew0Eqft4LMLzxxstoQBnyK9HkGLzEKDx7JriDjMIffKWm3rOHeV5UxtOtybgi/AupB1og6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9)
 by DM4PR11MB7326.namprd11.prod.outlook.com (2603:10b6:8:106::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 09:19:30 +0000
Received: from PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::a724:969d:4145:3e1d]) by PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::a724:969d:4145:3e1d%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 09:19:30 +0000
From: "Berg, Benjamin" <benjamin.berg@intel.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"ramasamy.kaliappan@oss.qualcomm.com" <ramasamy.kaliappan@oss.qualcomm.com>
CC: "rameshkumar.sundaram@oss.qualcomm.com"
	<rameshkumar.sundaram@oss.qualcomm.com>
Subject: Re: [RFC PATCH v2 2/8] wifi: mac80211: change public RX API to use
 link stations
Thread-Topic: [RFC PATCH v2 2/8] wifi: mac80211: change public RX API to use
 link stations
Thread-Index: AQHcpMGqi9Su98Tu5UOCJhyFV9LI7LWSIASAgAEGKIA=
Date: Wed, 25 Feb 2026 09:19:30 +0000
Message-ID: <25509fc783602173dfbdb16f72d74070690c86d8.camel@intel.com>
References: <20260223123818.384184-10-benjamin@sipsolutions.net>
	 <20260223133818.f2ed2b718c41.I4a2d45609e94b52654b10ec572e59a45d09c41f4@changeid>
	 <b2679df4-c8e3-43f4-81f3-8434cd9efd12@oss.qualcomm.com>
In-Reply-To: <b2679df4-c8e3-43f4-81f3-8434cd9efd12@oss.qualcomm.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7964:EE_|DM4PR11MB7326:EE_
x-ms-office365-filtering-correlation-id: c26d3202-b0ba-40be-c978-08de744efb62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: R4HZhiN3clOlqsZdFr6oM+HgkcHOEDcZl2SCPTGEXg/CUB3GEsOC5L4VKpPlWtWBpAoZAtM9PwOxmJQAJcS2U+gwrfODKSIqzAkzIDhN6wseUw6ARnMIaUTS37FPypjJVv6d8D5iRlxjW1Rjt0uASlfTups+/urpHclSXUpu0IQnU6joQJdUfp8yQhe3zdoY9sqv6OcZ3QSzOYJBLMxsSrmyQt3JrGRiqF6ViUGADM934D99jbZkLioX1l3op0ApJ517xzbh3nV8HupiK9B6VkFvMNqKqnYl/gyRj9OfllMY1UjwCsKCCEF/nm9Ho50kU2vTonLG4r1SvgGsmj3eAi4G+kBr8RbS3eSPXC9li2PPxuMs5c3/tEVzxoLsTRjQbyeiLuWpK2UTe8049osRvanY5cIlrOVd6/hYHIIRtWMNQKNmIJlCtpKqEPCr1sF4Mrx/eBjd2i4Gv5vxDXd8nqaoXmeR78O4zsXntbUMlyQYFAhuRNiV6hU2V6uaAuM1xHgD/ZahXJpQkIIEaT4MSkxkXgKs3kvFCy2t9SrXDi4+cDDDc5f/nCwwUhEXTQ7spkCN9d3wpWld5g+fRUseswEZqpG04NU1W0OLkDwYcC7hxY4VQ9+MNOp5S0O3iQzA3TZ8LB1pMh6WUGSwaxqwAWEOA3tArgQKW6BoXVuyMvgZ4Ke+eAKvEqFI4ty8jBRwEyj+7N9Iq0XU1uMl2OKBsXrCZjreOTmyv+0/b5k3/qOLTmWwQC1AHqypMG0wBOcpyZYIusx3jlnB1sYi+R2uVoXYqrYtq7fbu0NXhuu2EAw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7964.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVFSZ1d2N1hBaDV0SEZQM1JlNTU5UGpwTlJvSjVMMVRmQk9SMlMzc0hXRmpZ?=
 =?utf-8?B?TC90SUVFOE4vUHROZy95aS9DbUgzOU52bmdDQkQ5eEUxSzZqNmtYNDlYSFBo?=
 =?utf-8?B?WGRnNys4cW1rbmhLUGVQaTJDcnV5M01kVHpTQ2VpSnVUQWhiUGlCMmVoSGNy?=
 =?utf-8?B?Q3N0SG0wMURucXVkMkdBUG44eU5CclBTb2J4Y2VrSE52VFI0dE4zQkpjUWJx?=
 =?utf-8?B?NDdTNXptNGtaa25mNEZxRXp3dUE2cEZXMTZkQytmQWdJb0xrUW9mV2UyQ1c3?=
 =?utf-8?B?aDlUc3Q3RGJ2M3p5cnh2T3lqcm9ENjFDa2Y4N0ZHd3pPU1psd1laUlVMa25o?=
 =?utf-8?B?bERWdkM4dlY3TVRjbzR5d1dpbm4wVDNDYjdkYnZybXZYYkoxSHBGRWJXQ3FW?=
 =?utf-8?B?UFVCZ3FBeURNSVRpY2tyQm1KOHpWTWp5TFFhb3JOdTZYckpaV1VLQjhJdGpR?=
 =?utf-8?B?enNHd080NThBdnhIa2dldTVSa1piUTFkUHljNGRHaXQ4WEJHbjJ1ZHcyd1ZE?=
 =?utf-8?B?OTJzNjFJUmpKSjI1ZjFGU3djODMvenE3VkxuYWZ4UWV2Z096b3JkRzBHdHVl?=
 =?utf-8?B?QmFVdTdqd2VaRVFsR09JSHBEU2REelJYanorY2JxOFFyL0JJbnkwZWZiUkNW?=
 =?utf-8?B?S0JmTythMUlaanBIelJseUFDZDRsdlc4MHlwdDVyRDlkZzJkU21KY1JWOTlm?=
 =?utf-8?B?RjJwd3orWklSbmpWbG9BaFl5VGlXTGMzaWZPcVFVanNISmJRRGxKREs3dmJ6?=
 =?utf-8?B?Q3VXQXZiK0VHZkVSUHJVenJjVE9lSU1HTnlaME94VUtYdk5qdlJWa3BZaGo4?=
 =?utf-8?B?SXpwcXNQMHpETGFwL1R6dmZNb3YvN25DdzBSbGwrNjJkaWZXVk9uRzZLV2ps?=
 =?utf-8?B?WWNSUkRPRW9HQjE0cHZ1amZWeVpaYm9vMG03VEhyR2VJYkh1UUhvMllmb0Zv?=
 =?utf-8?B?THhEaTdoUUFnVWpGOGxTZ0VvVGMreDlUV1RjZDJNck5aRCtqeE1jNTRNQTMy?=
 =?utf-8?B?L0R3Nm0wMFFEZSt4b2U0QWxvbkQ1KzV1WHhDN3piZXFsZU16VUI2K2RCYktL?=
 =?utf-8?B?eHY4d0RqRkNoL0RKTmFhYTNYZlJZalQ0VTYwMDR6NTZqOGFnS2VZSXo0eU1m?=
 =?utf-8?B?Wk1kRTBrMktpbFM5MUlHT2NRMTkrZjZVUTFvNmZTYmJsRjNjNkZaMURpaDhi?=
 =?utf-8?B?a0ErRXdrYm1oejZrekFxY1lvSTFBWmJ2OXhVVGZ3OVZOZEV1d3ZXQWRudEJC?=
 =?utf-8?B?WXZCQkI4TEJ5dnY4MXpkTE54N1VwZXVaZXJkMnQ3cGo4QVplWllUWUtKVUhr?=
 =?utf-8?B?TTJoaDN0bkcvb3ZGcXpqQUNlMHlQYWpuL3IwNzUrRElxYjk3ZGc3U00ybURt?=
 =?utf-8?B?T0FnMGlrd2lhMHEvUGNlaDRaU3lya1RVVnZOL09CdE8yYTdrWVJrb0g5MFg2?=
 =?utf-8?B?QTJtTGlhWE5qSGd0Njk5T0VWNjRWOFFtQW5lbnZTUzUxS05wd2VqbXA4dmgv?=
 =?utf-8?B?Qitxa21rZHNZV2FtMG50djhVWnVJWkRPWDNxYW1KLzMvMzNPUysvOE5Tc2dJ?=
 =?utf-8?B?dVdOdm5rWjJqSGoza2phN0JnYjJuSVpGK29LaTMwTHVyamQ1bWdDdlc2ektu?=
 =?utf-8?B?QTh5ZmZFTlVNSGdFMStROUdLOUtVVXdZays2d0hVaVJObWlRKytuckxCcmMx?=
 =?utf-8?B?eFpEQlNNVTNRaWs5U2xpL25DL0g2SDdOUTZvSEdkUUEyOEZ5ZFN1RDVBKzBs?=
 =?utf-8?B?UHV5eWQ3S3hoZVpWUW82d25xcE81ZVlHWVUxd3dyNEdaUlhWTW0vbVd4aUcw?=
 =?utf-8?B?TlpGVGVFN0FVMW94RUhObFBwRDN2WjBSWlFIMFVDQnBqSGlVOG5hcTJvUm5k?=
 =?utf-8?B?dmN6ZmFEUnByb1NLbnFFZmRRNFlCdFlyZUFraEI3U2wzMFZrV3RNZ1lSWCto?=
 =?utf-8?B?dmhmWms5YzM5RGZxaThWN3ZZNnFIU3l3bTFBL1NRb0FmMm9zN1NMNFMra0tU?=
 =?utf-8?B?eVdhenRFYkgzLzk2VDlDKzVaTFkxVndJVnpNREFDYXo4cWk4OGZ0ejRSVWVL?=
 =?utf-8?B?TCsvSXlHcUw4ZTMyTmV0QVo4Y095MENWcGNQaW8xTktiQlBwZ0ZXZzFWemJK?=
 =?utf-8?B?UW54MGlsVkJJK1ZCZ1R6Z2p3UDZIVHorcTR2dm8zME56MnNUSHphMlpDWEM3?=
 =?utf-8?B?b0hUVld1VkJBVHR3TnVKNG1IN1AvZ090c0tvaldsRVNLSVpuZ2ZQeTJuQkgw?=
 =?utf-8?B?VzdZMmcxZjlaaXdzRll6ZzdIUWx0dnhKVCtuOWRnZnFROVF5b0NTcjNVQ0Ju?=
 =?utf-8?B?MTNFL01veEMwaC9vU0JBNHJ4UzhYbGlJdFZ3UENRRzJNQVh5Y3NRQStvV1Zj?=
 =?utf-8?Q?rDV5ePooz6OMN7Q2sruxBe//V/Vn55HhHbDKQtRQDU7JA?=
x-ms-exchange-antispam-messagedata-1: TERrROkE0Dx+pFAxwn34dLf8ptOAgmqWBb8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <692CEDD6FF5E5C438D0DDD9B6C8B6E30@namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7964.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c26d3202-b0ba-40be-c978-08de744efb62
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 09:19:30.6457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oUevR8UbdJeHAPiIDM9WB+xu1UwB1XBQKaenYewPh+uUWS5Vm4XF2EO8bhemHlBzEcjgoytqT1uAwVJv4q8oVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7326
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32171-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.berg@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4F792194C9B
X-Rspamd-Action: no action

SGksDQoNCk9uIFR1ZSwgMjAyNi0wMi0yNCBhdCAyMzoxMSArMDUzMCwgUmFtYXNhbXkgS2FsaWFw
cGFuIHdyb3RlOg0KPiBPbiAyLzIzLzIwMjYgNjowOCBQTSwgQmVuamFtaW4gQmVyZyB3cm90ZToN
Cj4gPiBbU05JUF0NCj4gPiBAQCAtNTMyLDEyICs1MzAsMTEgQEAgdm9pZCBhdGgxMmtfZHBfbW9u
X3J4X2RlbGl2ZXJfbXNkdShzdHJ1Y3QgYXRoMTJrX3BkZXZfZHAgKmRwX3BkZXYsDQo+ID4gwqDC
oAlzcGluX2xvY2tfYmgoJmRwLT5kcF9sb2NrKTsNCj4gPiDCoMKgCXBlZXIgPSBhdGgxMmtfZHBf
cnhfaF9maW5kX2xpbmtfcGVlcihkcF9wZGV2LCBtc2R1LCAmcnhfaW5mbyk7DQo+ID4gwqDCoAlp
ZiAocGVlciAmJiBwZWVyLT5zdGEpIHsNCj4gPiAtCQlwdWJzdGEgPSBwZWVyLT5zdGE7DQo+ID4g
LQkJbWVtY3B5KGFkZHIsIHBlZXItPmFkZHIsIEVUSF9BTEVOKTsNCj4gSXQgYXBwZWFycyBtZW1j
cHkgb2YgcGVlciBhZGRyZXNzIGlzIHJlcXVpcmVkLCB0aGlzIHNob3VsZG4ndCBiZSANCj4gcmVt
b3ZlZCwgcmlnaHQ/DQoNCll1cCwgdGhhdCB3YXMgYWNjaWRlbnRhbC4NCg0KQmVuamFtaW4NCg0K
PiA+IFtTTklQXQ0KSW50ZWwgRGV1dHNjaGxhbmQgR21iSA0KUmVnaXN0ZXJlZCBBZGRyZXNzOiBE
b3JuYWNoZXIgU3RyYcOfZSAxLCA4NTYyMiBGZWxka2lyY2hlbiwgR2VybWFueQ0KVGVsOiArNDkg
ODkgOTkxIDQzMCwgd3d3LmludGVsLmRlDQpNYW5hZ2luZyBEaXJlY3RvcnM6IEhhcnJ5IERlbWFz
LCBKZWZmcmV5IFNjaG5laWRlcm1hbiwgWWluIENob25nIFNvcnJlbGwNCkNoYWlycGVyc29uIG9m
IHRoZSBTdXBlcnZpc29yeSBCb2FyZDogTmljb2xlIExhdQ0KUmVnaXN0ZXJlZCBTZWF0OiBNdW5p
Y2gNCkNvbW1lcmNpYWwgUmVnaXN0ZXI6IEFtdHNnZXJpY2h0IE3DvG5jaGVuIEhSQiAxODY5MjgK


