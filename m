Return-Path: <linux-wireless+bounces-21188-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E429A7D6F5
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 09:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C0118897F7
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 07:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A217225A48;
	Mon,  7 Apr 2025 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJh9vaXg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AD41A8F93;
	Mon,  7 Apr 2025 07:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744012651; cv=fail; b=P42n4bBfsT9DNTwyFQOWuY9l1ZGy+yiFBJbUKGkKnPV/U10DHUWwArcXkQEn2wV/T6DEKrSGayvVNvmJbKGfZgGRJoqxZRYQizk86zPQivBfKHqQsxsiokyrZuv/Og/ATyMwA/6Zu1kdeiGRO+6o7cfnronkwLoV6+6q7FzInLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744012651; c=relaxed/simple;
	bh=xDNHEURe+tPA7Z/jFwBCGmTRpoIdAqC5Iu1vJcMP0Hc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dhdPkKOBvmZ8erctQ0b/ZdN5Iv3410kWV32yyAPNefMIM5hD8dAtyw/R20zSbrOC6lRjy+zzzLuZUce3hHzYZg0hXSZyiiDxwQmjQiCbvztCXtGi4CCKGfXOLLEYzKagay6+nk4WLxYM3ycGDDswiI6j/aoJCDVFgTvPKzBZ6QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJh9vaXg; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744012649; x=1775548649;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xDNHEURe+tPA7Z/jFwBCGmTRpoIdAqC5Iu1vJcMP0Hc=;
  b=XJh9vaXgEWu9VVGXyBtpP/bsnqypPcgU0KVLTqRv1NLSUYFX0O3fnvvT
   Niutw9cfEkexL2xRTjdlTiVUbSmIi3NrP0GZTad8Ir5rcE3jzv6ksiiFS
   Tp2WIXlPGRbHs5bmyXVW4eAbc5DcQWW6k2XQuyrTuz6fGAqWrayhaT8P/
   u0tvpqWqV4jOqOQffqH8T/rjgGKJrdC+PluGrJ8VnDBLwQAKz5uJ/h6RP
   toujVrX0gg3o+6bcPNs6u15Hb955QnA14mREtsFZ7GxVHkllNsG1vD+ur
   ZxPHIm62+kjLCIpv7TGhPFWJ+GNuPrGKQgGp4K+d7twlF/eMwg6xvVCEF
   g==;
X-CSE-ConnectionGUID: ujRcIVgzT8SmlKjTLweGiw==
X-CSE-MsgGUID: wIaJxlteSzmiiPpWup1wQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="45272295"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="45272295"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 00:57:29 -0700
X-CSE-ConnectionGUID: PIoSWLv9Sly4BV1gKDkTkw==
X-CSE-MsgGUID: Dwy3oRgEQ+y1sMxsOk3SjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="165073867"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2025 00:57:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 7 Apr 2025 00:57:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 7 Apr 2025 00:57:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 7 Apr 2025 00:57:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbhEuph5MhQEn+zHCK3woOzDX85AOhn1Iq85ol3dhx4NAheIbQJo2kB8FgjwPdjZVNXKi69/MjdkIrbCOe7CoiK8hLFY3W2+8Y9m8prOrCiZqisnt+wATwSHlbcOd0EkJ1StkHmJOVae7t8dIdSjviYqmXErty00tnXOSf2AJkSqBw3oHI2TEtoRO16YUB6EcUli0vkynKnGiBsQ4IY7Fhh72t7xicAcymjJ/pNE3zqStMeXUSqC+kYOPXLHEDTU3mXOkTxTU/I30rNfbPVNnUBq+urCRswZppTPrJlVXxbY4bFnRr8FVNlFxQM01Ee5m7q1jEH1hIN1N2K6+SHatg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDNHEURe+tPA7Z/jFwBCGmTRpoIdAqC5Iu1vJcMP0Hc=;
 b=JeTe2l/nMbgsC8aFvElGRAYE9TNUb/RSXNYgwXKYH0V3d+Qe44rDLTivvvbrAroDOzfBYLXiNn6gytUF9bsKTQnGu81mQfdFN+G6ti//T4LVhUk9QRzXk94p3Pw6L5ohMGmFVV2SfQGoAfj8HUaKPmYA1vke7RVkyTzVoO7q/tv1va6UL7pKEyKzzDw1YAgOzrrCUBIpEKTMUYLzrLXq/llNVVDAumHXF46uLoKi7Wgohv6vAXohG+7e8OhkD8zFNXo7N4JMBpekFriAUTP+fDEmy0V8PUU4Fs80xU4gWYaniQPF6JE5MsAbUdCadzPA9qCT/8XRsWqX7jOHPqPULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by MW4PR11MB7029.namprd11.prod.outlook.com (2603:10b6:303:22e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 07:56:45 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%6]) with mapi id 15.20.8606.027; Mon, 7 Apr 2025
 07:56:45 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Yang Li <yang.lee@linux.alibaba.com>, "kvalo@kernel.org"
	<kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Abaci Robot
	<abaci@linux.alibaba.com>
Subject: RE: [PATCH -next] wifi: iwlwifi: mvm: Remove duplicated include in
 iwl-utils.c
Thread-Topic: [PATCH -next] wifi: iwlwifi: mvm: Remove duplicated include in
 iwl-utils.c
Thread-Index: AQHbZugTE9DFquck+UGm0vc/0bwNA7OQ4jrA
Date: Mon, 7 Apr 2025 07:56:45 +0000
Message-ID: <MW5PR11MB58105CBB2B6A715C85857A56A3AA2@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <20250115005431.89510-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20250115005431.89510-1-yang.lee@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|MW4PR11MB7029:EE_
x-ms-office365-filtering-correlation-id: da93acc4-fd9e-4568-5af5-08dd75a9be36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QmhSYVh1YlYxY2RqaUdDUE94Tk1zeWVpNmVQajhUR05teDRRUFFONHNndFgr?=
 =?utf-8?B?NmZ4ME4xNWZsbUdBeVhRQnhPN21Eclk5QWpZaW5EL0pONzVlc01PWitUa2pH?=
 =?utf-8?B?Z2V0TklsUmx6aFdkeFE0NUh1d0I5M2lrS1krdC95MmthbEVkRml2WXpUdEpS?=
 =?utf-8?B?bzRjMlZXMWt3TlM0M29QbUJUZVVldnRJRGpzMDNFdWdNWmNkYlZucE4vTVFi?=
 =?utf-8?B?aUx4NjFYVjZGWWdQR2lqYm01UDF0K0JlRGRSTVpsSGUzQUR6ajJwVUF1aXMx?=
 =?utf-8?B?S1h2OVB3NmhWUUJjRHIyTmpsTE5ndVZrcmZLR0tDMlczRUZyN2tXcy8rdlFK?=
 =?utf-8?B?VU9jUmQrM3ZoS0NwNnRwQ3VXTHlFaDFkOElReXZRdithTGJEREdTRUhmeEhw?=
 =?utf-8?B?eURyVk5QZ0x6Um9UVDJ2YlJwc0lHR0d4ZEpEYTV2STZhSWdJN3hnRWhOTm1I?=
 =?utf-8?B?TG9ERy9JbHhkcjdCWklzRHM3UjFIQ2JCbS84WDJkSUZqQmF4TFZGbUFOWExk?=
 =?utf-8?B?WHJFbjBJZVNBUlZsSEJhQjc3T25MR05aVEdDVGlteE91RkRLOTBXWWtuOC8y?=
 =?utf-8?B?WWdQZXUyZHFBQ05XckxBZFd4YWFuSHpLVlVsWnpMWUM1SlcwVkRFVHFKZXM0?=
 =?utf-8?B?Vi90dUI1TlNmSkxFSUdPTUtzWHZ5aGdZeE1CQVdqQytuM3hxZzdEcUExb1g3?=
 =?utf-8?B?MmxVRTd0NGJCdVdwdW5ZQmJRbU1NaGROVnRmaHNrVW0yQURaQzdPdjkxV1N1?=
 =?utf-8?B?K3RSSnNyaGF1YnEwNHNJc2lTQWNtVjdFeFlSZEU5Tm13eWJhbnNzSFVUR0FQ?=
 =?utf-8?B?VmljakhTa0RQRjhkbVlOL1hrNDg0VTZ3YWF0OElUcTBjRzdSajNKbTZBWmhH?=
 =?utf-8?B?WlptL3J2QjVJTTJ3Zkc1cTlLNnRCYkFqZlBaVkUxTmZwTEV0cUFGcEJDMU5a?=
 =?utf-8?B?WUEwY3lndkUyL01qU3QxWWdyVTlHOU5abkFMblNTeTdvTTVsWnNOTTROSVho?=
 =?utf-8?B?SVBvWGVGdWk1SXFwZlZxNkphTWw0aXYxU2dUYTFPZEllUGdxSWplSmQrRmRl?=
 =?utf-8?B?S0hCT2hwR3V0RzBLSDNHZVJWYkVRY01qRGJCNFVDYkgzT0Nibm5DMnRYdzE2?=
 =?utf-8?B?dXc5TEFsUVFCY0xJMGlVTGErSjFHcU9XN3IzOXBtZlFUUnVjMUc4REI1b0Rr?=
 =?utf-8?B?aVZGVGNuVW5POWd0ZVBMNEVOK3I0bk9OMEVMeUdqSTBFQi94NGk1SStMcXdO?=
 =?utf-8?B?T3pPMHNxTXNtMUw3cFpBOWEzN2tQZHIwc2NucGYxeFRHU3lHK25rOFdSZHJU?=
 =?utf-8?B?c0c5ZVFKcWtxV1FZSXA1L25MOXRUMHl4WGk3bG5GT0g5MC85OE9Ta29BWU9I?=
 =?utf-8?B?NFpXamR4Q1BLRU1UZVI3S1VNc2ttUGJOUnpEWjJUYU1FYlJCNVFubUg5RGZx?=
 =?utf-8?B?WHRIMFpyTWxucVh5aEdMNmpwcjZTbGtydDl0Z1FuNGVta2Zwb3VTZjJlQjR1?=
 =?utf-8?B?NUszVGkwZitHWHpkb2lBMEd1RVRoaG1udE0yaWFyNERUUEdGbDhvSDlaQ09U?=
 =?utf-8?B?VkVQcVlIc0dlc0UvYUx0WjlBYXZTano3SUdkR3RLeUlSY00xSWVKQVB3UXBI?=
 =?utf-8?B?U0JBd2NPOVJMYXYvY2tLdnY0YytNTVZHdENyRlZaTTZncEhmTXVieXJhWDVK?=
 =?utf-8?B?bTliNlp2WGF3dXBJLytlM2hIOVZQQWdmNGdObWZ0OVByeGVpWWdjQzBiZ3I3?=
 =?utf-8?B?dzBCeDZUZkE1RjBnYmxDMmlkSkpIZ0lHSWpwS2JUWFNwajgzUE9ySmJwbnVF?=
 =?utf-8?B?UGlNUzkzRC9qZHpHU09PWEwxUjBtTmdsT2pjNE5rQmRudm9KNSsrQVllanlO?=
 =?utf-8?Q?jDVw/+H8MSCJd?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTNpamNDRzFUai9xcTlvbklramlYenoySnVaVEdyL2FQR3ozNDhYSkJqUDdS?=
 =?utf-8?B?VWt2SENPcHNxZmNvMVdaUjFHVUxGTXFwMVJvYXRtRUVQMXNlRG96N1owZzBC?=
 =?utf-8?B?d2k1ZTdDNnhNUVFJTU90NHlmZm1lbkl6OVlka3dvaVprczdGdUFjOUJNRWtZ?=
 =?utf-8?B?TkhQeDUvb1BiTlM3NmlNSXFqWCtzMmZmbXFjV0E3L1AzTGRIR2tXUllLSEZz?=
 =?utf-8?B?eUFDWWVUVjVWajZLell5MFlZdmE1Y2pRekJ0Y0Q0SUpnQXJlRkxnSDd3eWsy?=
 =?utf-8?B?V2wyRGtqMFVWUUgrenlpYVlSQWJkUWYvbWkyaDBIUWY2VkMxdWlBWnJLK3k5?=
 =?utf-8?B?QjZxeENPWE5GTXlZTzBzQVlCblpGaGIvY1ZyR1VvSUxzK1JRbjZ5VGhSeDNz?=
 =?utf-8?B?OW1JS2lnWlhrZGU1NHVRKzRnQmNiSUVnTVloWmpnd3M5NEVVV216dUpEZEZT?=
 =?utf-8?B?WGhEeDRCTklCdHU1QnQ5OUU4cHBTLzJLVU5mNHNvS2VUeWVlakJnbGMvVk9u?=
 =?utf-8?B?RFhoUlRZeWsvVi9qelc5bWkzbFhFSlVYRk51aEhjRzNRd3RxS2x0NVJrVnlI?=
 =?utf-8?B?WmZqNVoySkRjWktsVUVHbEtrb0VTSUU2eE8zSkxKalkvRTNCSFIzNFRITng1?=
 =?utf-8?B?VGdleXJ4aWoxL1RMeXA1eFkxeGRXbGN4MWJYTVVRSFRneWg4eklneXhvRmJG?=
 =?utf-8?B?bW1pZGhuU0RQOERjcWg3VXo5WC9ZMlBFTzVzMUZUWjlzVUpIMnFCN2FackhJ?=
 =?utf-8?B?SzgxRURqQk9LRXh0NS9MQ3UvdERiMEpFSzJ1VjIyUHlvUUVBNE1zUVQ1MkJy?=
 =?utf-8?B?U1FDajF4WjlUa1JxVnd0R2pMYzRvQ3Ewb1U1dmh3WEpJeXJJSWtEaXArcmkz?=
 =?utf-8?B?UTMyNWdBeVV5TzNmMmtZMEd2Y3FBWUk1dkExblQvaWtSdXE4YTdYTUF2N3ZY?=
 =?utf-8?B?Z2ZWNG9ST3RLUnptUkhyMFhucWdrWW9Jd2ZZTE5qV0dQZkk4eWZnVEN3Vm1w?=
 =?utf-8?B?WHhDaElnNENQTytqZDFyVnVwV1d0am9lZVdrUExpdHMxNFpzWExaQ2Z1N1RY?=
 =?utf-8?B?ZEEyektNS2h0dG5qajZVSnlQWlo4dkdmWVFIVEtFTG13M1hieWYwRjBlZllV?=
 =?utf-8?B?KytvVjNxSThVWEZUOFpNbnhEaHZRZTgzbzB5UEtCS3JLUHJod2tHaGtsUmZr?=
 =?utf-8?B?cmNyVEN4K0tOMU94QWZ5S2g2QWZBKzJhdFYrU1lpcUtCb3ZuRS9JSStGZ1li?=
 =?utf-8?B?alpwRjhnMGhrQ3AwYUZZVnNadVNXc21GZUQ2SU5qbW5TaWVIR1Budm0zMmZ6?=
 =?utf-8?B?N2pMd1J2WCtQZVc4TnRRZWp5SjNXbFBNcGhzTCt5bDRadWJLcGcxMkE2akRR?=
 =?utf-8?B?d3NwQzdhS1RvSGVmTU4zSlZjYkVoQkpzTjA0OEtLN2hYK3NDOGhKMkVHZnpE?=
 =?utf-8?B?N0dMQldVNmdqWEtac3Q4T1B5ekdXZW82Nko3VEFnOU0ydVpFNE1LajRES0dY?=
 =?utf-8?B?amJrUWxidDREazd2OVoxRm05dVMzQ1ZxRXVBaDRVWTRyaDdXRHZkcWliSGpj?=
 =?utf-8?B?OERLcTl5UDlOKzdlTG1uNXhjVTRoTi9FVWIzZ3VqRTJPdTcvdnhCQzUvd2hw?=
 =?utf-8?B?OVBIOHB1ZzN6TDRNNHlCZlREcmpyZ3hUejBrMnhEN3UwWFUvTFk3dkNQOEJz?=
 =?utf-8?B?MjBJQTZPRVA0NlJrOGdLQlpCTk1oUGZ4T1M5S0MydzF3dDYwSVJMMWJNTkhV?=
 =?utf-8?B?bVg3L09hMWxzQU9MaHhqQ2NsWEVwYUJRSDFmc21SYzFHKy9IOGowTDZmcUdh?=
 =?utf-8?B?dnpkUHYveDBjN1dybWEvWTlTeTBOYzhicW9rQWhqQ1dLOTNoYTQ4djVyOFRJ?=
 =?utf-8?B?a0dHYklQZGVpamtYa2pwZVp2aXBUTlpvNUFFNTJ1Q0xWSzAyeGU5YVk5NHpS?=
 =?utf-8?B?L1lCY0dENzF3T0ltL2lNZ0swZkp0RklPdXNGeXBWOStjd2prVnEyNWRub3pB?=
 =?utf-8?B?eVpuUUFTWXpEL3ZtZXVJSnFwWGpJL21tYzhtR2dFUGxqNDhTZm96dStGN0h0?=
 =?utf-8?B?THI4Z0VBaUNFNWlJK29veU1BdHUweGVBWFJGNFVDeHBzdmozMWxCUmpmQVk0?=
 =?utf-8?B?enVOK1BMT3RsYmUzd3BwVUJ1cEhqZ1FKUjNOMnpwV2F5aXhWbmtyYThYa1dM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: da93acc4-fd9e-4568-5af5-08dd75a9be36
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 07:56:45.7196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RFS5j7QBIgh2AxHME0oQfCKj5x5HUrkcnpMz/BQSYGxS85t/Mm7bh3cDUd7W9GBXYUcZEBp5S5hM2tHNTPxNFLoYw/65ChjmFoQ84KOAbLwoHy8aV3yV4gE7iFEUxY3Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7029
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWWFuZyBMaSA8eWFuZy5s
ZWVAbGludXguYWxpYmFiYS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgMTUgSmFudWFyeSAyMDI1
IDI6NTUNCj4gVG86IGt2YWxvQGtlcm5lbC5vcmc7IEtvcmVuYmxpdCwgTWlyaWFtIFJhY2hlbA0K
PiA8bWlyaWFtLnJhY2hlbC5rb3JlbmJsaXRAaW50ZWwuY29tPg0KPiBDYzogbGludXgtd2lyZWxl
c3NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBZYW5nIExp
DQo+IDx5YW5nLmxlZUBsaW51eC5hbGliYWJhLmNvbT47IEFiYWNpIFJvYm90IDxhYmFjaUBsaW51
eC5hbGliYWJhLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIC1uZXh0XSB3aWZpOiBpd2x3aWZpOiBt
dm06IFJlbW92ZSBkdXBsaWNhdGVkIGluY2x1ZGUgaW4gaXdsLXV0aWxzLmMNClNob3VsZCBiZSB3
aXJlbGVzcy1uZXh0DQo+IA0KPiBUaGUgaGVhZGVyIGZpbGVzIG5ldC9nc28uaCBpcyBpbmNsdWRl
ZCB0d2ljZSBpbiBpd2wtdXRpbHMuYywgc28gb25lIGluY2x1c2lvbiBvZiBlYWNoDQo+IGNhbiBi
ZSByZW1vdmVkLg0KPiANCj4gUmVwb3J0ZWQtYnk6IEFiYWNpIFJvYm90IDxhYmFjaUBsaW51eC5h
bGliYWJhLmNvbT4NCj4gQ2xvc2VzOiBodHRwczovL2J1Z3ppbGxhLm9wZW5hbm9saXMuY24vc2hv
d19idWcuY2dpP2lkPTEzNTU1DQo+IFNpZ25lZC1vZmYtYnk6IFlhbmcgTGkgPHlhbmcubGVlQGxp
bnV4LmFsaWJhYmEuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvaXdsLXV0aWxzLmMgfCAxIC0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9p
d2wtdXRpbHMuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLXV0
aWxzLmMNCj4gaW5kZXggYjE0ZWM5OGUyOGI2Li5jNWI0OTg1MWU0YjkgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLXV0aWxzLmMNCj4gKysrIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtdXRpbHMuYw0KPiBAQCAtNCw3
ICs0LDYgQEANCj4gICAqLw0KPiAgI2luY2x1ZGUgPG5ldC9nc28uaD4NCj4gICNpbmNsdWRlIDxs
aW51eC9pZWVlODAyMTEuaD4NCj4gLSNpbmNsdWRlIDxuZXQvZ3NvLmg+DQo+ICAjaW5jbHVkZSA8
bmV0L2lwLmg+DQo+IA0KPiAgI2luY2x1ZGUgIml3bC1kcnYuaCINCj4gLS0NCj4gMi4zMi4wLjMu
ZzAxMTk1Y2Y5Zg0KQWNrZWQtYnk6IE1pcmkgS29yZW5ibGl0IDxtaXJpYW0ucmFjaGVsLmtvcmVu
YmxpdEBpbnRlbC5jb20+DQoNCg==

