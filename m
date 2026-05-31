Return-Path: <linux-wireless+bounces-37213-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AouFW1FHGrzLwkAu9opvQ
	(envelope-from <linux-wireless+bounces-37213-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 16:27:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DF0616AC0
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 16:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD2833016017
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 14:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75417331200;
	Sun, 31 May 2026 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dYeVmmui"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55742417D1
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780237673; cv=fail; b=mlXVlDc4xEAd/kG+hQ6kkKlSTd6svruF/+ONZBDweHjAmZncttjqtnH1qLQ82ZymlY8KIsCN6WPX15FNW+p9hQu1mp2GVWqEzKlEunVaP7k/N0RGLpkqPYEipvuYX74t+FrTBiAm6xz/Sxg1j2+nO2HhYbnPekBcmLQIjp+d+r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780237673; c=relaxed/simple;
	bh=w76RINiw0AwYS5X9rkM36swgQntqDdTUEC/nay94qA8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TgiwNDho3q2gFoTXztnrGJP23Yi3yBQW0el/smcJ6frG/WI88EFGJpqHQEskervtBRd5ec3ZgLj4hVwBi5CFB1yFHwqCSyRmiBXOryPI7A361sMJUpGtzVY+U0jeJ0PfAXMGZwwH+9TCtsHdiQZVRh2QboePZMzkxAernbVCtBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dYeVmmui; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780237672; x=1811773672;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=w76RINiw0AwYS5X9rkM36swgQntqDdTUEC/nay94qA8=;
  b=dYeVmmuiLG1rVIP5BxBcJ16TnL8vcZMjTyK/FLbuu5nUg18ifO+DZapl
   QwL4717KmkPaKu/GzYXh/QNdoIToudn2OG3E0Q4uVnR/2W9S+5ZaISG0F
   PD1V5IstfMOZocJ30mYr1fU9eU3Y/LIMuPjSDx1hgLUjuHu2skoXsIChF
   iU7QucB4xGrXTEqMwBGIbnR4se/PbmCsAtz1WWL4gesIEulRm9fbPKBXy
   MNmXTwgQx3KFoPhX7W8LazJA4K4g2BlBQZBo/OEZU0lJPeZpJr2JrRLCC
   zcv0yDZIcJmiCoUwzz8e7ENopnyDsxzjiJrmwMXd6r4Fs0LvwnxQT8uID
   w==;
X-CSE-ConnectionGUID: uo1k/NNcTUCvsu58CaV57w==
X-CSE-MsgGUID: Rz808bJrSZ6+oIrdHKi1Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="91323604"
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="91323604"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 07:27:51 -0700
X-CSE-ConnectionGUID: bua8W+NtTbS7lKzaTiiI4A==
X-CSE-MsgGUID: 9Bc3mVcaT/O3FuYNVGJFWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="281444569"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 07:27:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 31 May 2026 07:27:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 31 May 2026 07:27:50 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 31 May 2026 07:27:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GY9LStGJwVjphJk94NSPXDFc3qJdFAL9eHiFm9f3yIbSY98eaF4ff6eE0PwRScP4KAzA6DNnfrCuxF8PVypo+RmGPqWQqOrIJ+5nHTwP6B7tRnQ6AHPjX/7yeSM9A46gJwjuMa/7J/SvT1IguKmOMXxDK2EgM4WeM98Ije8LuIOv7SLzyFCgMSoWg3DOjR2SWucQMJlClAUGRIOfGdGOe4d83CwlsTfTnzicahudfH3Me/3jLcHwz0VUOBhZv0lXE4QpOyK04oF/Z73K1uFIklhExnbmq46TGVulPzIyoWrXdzdnGjtzfoBfSCEmkpkrravlHXzcphMQjbRWUgUhSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w76RINiw0AwYS5X9rkM36swgQntqDdTUEC/nay94qA8=;
 b=KEvZvQ9XUTbgo+Mc/oFoqjKJzsYMLw6WCt1y/ix/WrIR7LPM05sfDFN7LDLwRxWqFd7yjPYh9FChBG272vz+uwNfXzoEc4qdCUV9+DUPZ6XjzqvedsnZVAIft51/8Ty9IePubg579yqOFFjjG4uncmISwfC3QXsg2hQ3mHDLLlK5VYoxGNSRpUCHoCswUuoNXJqOFNOIrIaS3Kud44qhaUEFaPqmKhZfMVRYSiTZ3WzGvTyahecAz00eVrlTYEJyeDW7G9KS0Um8IXxeVs8ra/nu9BQhYhmt9qvlP1GlU4YlUek+pDEMaOOFMrgBh0NiFaU3e+agpgLKi8sYKrR+0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) by
 PH0PR11MB5015.namprd11.prod.outlook.com (2603:10b6:510:39::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.17; Sun, 31 May 2026 14:27:46 +0000
Received: from DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2]) by DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2%2]) with mapi id 15.21.0071.015; Sun, 31 May 2026
 14:27:46 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
Subject: pull-request: wifi: iwlwifi-next - 2026-05-31
Thread-Topic: pull-request: wifi: iwlwifi-next - 2026-05-31
Thread-Index: AdzxCaUXbMY9LswQTMeJdoZJzSQ+qA==
Date: Sun, 31 May 2026 14:27:46 +0000
Message-ID: <DS0PR11MB78809C3AE2C2F3348D39581AA3142@DS0PR11MB7880.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7880:EE_|PH0PR11MB5015:EE_
x-ms-office365-filtering-correlation-id: afd7b66c-4329-4e6d-8963-08debf20c8cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|56012099006|6133799003|3023799007|11063799006;
x-microsoft-antispam-message-info: /WnljPiYN0ECeEDM9Is9hmLkeawijDMW1X3JOflpDjenL/uIcLxzfKPmpWBblOC/yyRVI17ukMXxuKUXRf+PLT4vFcirUb7dja4FdrhcZm1ebc3z/q/vrVudnKjQ1s6ucgAU31ChhcNWzB0If3UNlyiJ5DeXA1pExkTjpVzykfVZBuTyrMD3Wx1gWVxmTfQKYtMJc6Q/HJimXFniTRoQFGdXTPIFLl2Rr5WKOif4hFU1E4iu3AN5I8FRDySLr3dnYf9b8HppjFX0bG5u0bxY/OVZ6A1Qkfz47eJo16kolLllxT1hQY3CVl32m72q1K1Krr+I62BqPNLkJmK6uiWphJAIPROWKCtcZ7o9AM1Wtau0XRJtn1fc/YxZbFw+FJcxN5yeOm4jhBbdvfPT3X8cvxUef1+SI6ji6yjqEWZNDNUtLuvJx4WDsNwaYCmbHLOD+OqQiR2ks26wlaLHLowN8aHkxSne6Mz06DSk3Iu6h2tGYpbx7JexhLS5PEFtrk6+qh5vCwrTxSaKmHw+Bvfs44XmTyppjAAlNnedHVJHlmfw91dHT+id3Nn6pYX6tWSrvzuPRKgGyxClhgLYVW+R7C+/S0S0Jiym+eGBj4U/hfhbTqxh8Q7L6V/P9Hgsz0jMGw+0sCdlifJWKTR92UfW1Kmq7vBDBnZn1OtjQoybA1ddQ00yakMkRIe/py5UglJjCjCasp9EZttcx5zOovvXLb/2zaThfBj+xM1xzZYnofuOrFuxtwJsRxvDpNwwmJ7J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(56012099006)(6133799003)(3023799007)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDFVdHNLU29LcjFqSVpOSUlaeENrU05lTE9mekV3Nml1cUVtWkhHdjY2WDk5?=
 =?utf-8?B?blhMQjhqMTJWcmxmTFhUM3d1ZjZ0Z0FVcDlBM0xBb252eUhGRUM3ZmtVMS9I?=
 =?utf-8?B?dDh0L1FCVnkrbFJaRXJoODRlZ0YyenBvSE0yZFB2Ry9wb1h6TkphMkVHRkRh?=
 =?utf-8?B?M05qYWlkTmJsazVmMXdDSUE5aTNCL1ZaU1N2ZktkQ3U3ZDBNdUlxMEI4c2dU?=
 =?utf-8?B?bnRYTk9PNFA2T0x6aVBjZ0JDR1lwejgrZm5wV1BhZGJVclJkVER2dHpDdEVo?=
 =?utf-8?B?SU0raWdpR1gyUXc4Q2dzR2Z6OXdsc3YwcWc0MjBObkp2OHdnRjUzSCtUV3RN?=
 =?utf-8?B?clNSbkpZOHhXVlpXQW9UMm5EbndZN0FNNDMzRjEzWWlxVllmeGxuaFdpY3p3?=
 =?utf-8?B?U2NmQkdQZ1JpQjBvYWlBaGsvWlo4a1RJMHB0QVNpNTlHUkJ5eFJxN085dkYr?=
 =?utf-8?B?MkpxcWU2alZub3hqWVBVaEVaQ0lyQ1ByWmxDT3VNRjVDcHpocEc1QWYrLzEx?=
 =?utf-8?B?Ly9EVHAvSDJ6NVBKYy9vMGVJRG54WURTcUQyNE5rN0pmNnB5dFA3aUhBNlRQ?=
 =?utf-8?B?QnlZMVIxNThQdm9jYTRPTXFZR0JIN2c5MnJMbEU0bkdySU1EUytXdUVuM0xk?=
 =?utf-8?B?WFg4eTA1YnF4cFJpY1NWcUl4QTZ0Q053SG1Lck9MMGtkMEpZdUhJSDU3WHh1?=
 =?utf-8?B?YWVtV2kzakJzTVVkc3lkSHJEdnBhVHhjdDVuVHFHRGxndHlDLzNxc0k4eDAw?=
 =?utf-8?B?ZFdyaklxdHlya1l0Q0FCV0tSK0FleTF2bE1DN1B1TXJiZW0zQzJvQVUyWTgr?=
 =?utf-8?B?cEFneENuRjEzUnluSWYwRjlZZ2QxL1RYUmxyUm5wY3VyanZsc05wZ3h6cmUz?=
 =?utf-8?B?Uy9rdXpweVJNQWpKSG9lUm5xTUpyRGIxQi9JRyt6SFQrSmNtWi80aitmekQy?=
 =?utf-8?B?WnkxZUxZRncvbWxzTTVKYzY1UFpFNWZvOGtGRW0ydWhVL1JDLzRQR2tHTlBo?=
 =?utf-8?B?bjRLaW1uMW56MDlMUUZjZiszMHJzUHZsMUlTSmd5cG5mamxtdWRzbDdoK1Q0?=
 =?utf-8?B?TXE4b1BoelE4eFBDNVdXNnVFa2R4RW5lTk1RM2FhdkhSbmpHRUNLTWR1aTZB?=
 =?utf-8?B?WnYxeVgyRkRTcnlxOFpzYllsZ2FiZEZ4anJ1OWRqN3BFSzVnZXFNYnJMUDJm?=
 =?utf-8?B?dUt6VmpYMW9IVU1EMTgvVXVncDFWanZLVE1tZG9sL0VmakdXWDRwMFZVNk5p?=
 =?utf-8?B?SG5qN3g5UVlzU204cmc4cTAvaStkbE1ZQ2o5dXZVWEZlVm02a0pVQzYvRjVP?=
 =?utf-8?B?UEl2WnRuWGI5OWk5SjM0NXJJc3ZZSXZGdzhVS0pvZmMwY3FUSTVYbnJoc3JN?=
 =?utf-8?B?ek8rL0VWcG1FeHVCYUJwK2JjL0tSeVhkL0JZL1psYmowWW9jUloyc3Y1QVFl?=
 =?utf-8?B?dTROYU5MczBLeU44RHNuS2VNK3lMMGFLQTlONFRTKzNJNFJhYzJSeHN2ZEN3?=
 =?utf-8?B?LytrSXFSMVUxclVITktwRVNZMmo5TVFRc2NPd2tjZUFZZ0FZbGwrY1BlY0pM?=
 =?utf-8?B?UFRnOTlnMzFrQUVqcWZEMmlJaWRhakdwQi9seVRyRitMNWI3MFp6aDJCc3dW?=
 =?utf-8?B?d2t5TVE1RjJDNlFuMTRORXNPbTZ0d2pnWm9Ea2JoR2t6TWFrNXBTT1NId2RS?=
 =?utf-8?B?bGNqV0VLMEJ2cU45ZXJBcUZnQ0hQSnRJRzdkRWFRRksvVDRkU29GRzZ5K1p3?=
 =?utf-8?B?Z0NHQlR5K0l1SlRiQ2d6T1U4OStKZm5ZUkkwci9MeHF1d2xHZ1RpalM1MUs2?=
 =?utf-8?B?VkVWY1pJYStjUXgrWVUydXVXdkZZOFl0ZVJLUjRybkxVNFE0dWRLZmdxUkRW?=
 =?utf-8?B?V2FSN0tTaXZtenR5d3RxaWRlOEZQaGx1SG03cm9oYzdnQldGc1JETWdsRnFX?=
 =?utf-8?B?aVBKTVRqM09CUkJ3d0JROVptRGxBZTFEbElQYmRwZXpxK3RuRjl0UmpjS3Zv?=
 =?utf-8?B?MGltQ29YZzNtOVg3c1lNdks5UXhRZG1SZzFGU3cvcVJMbVFVcTF1OW1BVits?=
 =?utf-8?B?SGVFdU1PQ0U2a2tveFFRcEJwQ0JObGdZb0R0WHFMeDZRVFp4MklpcEsrUVF5?=
 =?utf-8?B?L0RFN1RMZ1NRWG5LQ0c3bW4ydlJWTzNIMmllWXhmYjIzV0NEeDN1RmhvdExB?=
 =?utf-8?B?RHNDRVA0Yi96MitrZDdBbDNFTEd6cS8zcHVLczREWFNoL1BXcWNOa1BFQmVt?=
 =?utf-8?B?OEpLRGZvdGlQWnpmQUcrY000UFk3YmV2azgzc0x0bXJOejFOSXpTYVB4dkFi?=
 =?utf-8?B?emU3NWJmMmlQMTlCRHhSZkVma1pLSFlpUXNDRWdzU05uZUxxTmpQOWdxNU5h?=
 =?utf-8?Q?MWoO+pRXZcPWsTzc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PT2lPY7IuR5L23HvqkXekAaw4pfTWsbwl+4aNrZafQZ1XdibppGGG0Yd8fVUBzvYeb+KlN7+bMLPilr9CQJQey6m4XhCUkWw3c8B2phaZw6c/ZsdHR0138snbLso/iFYvyOEKu4VM3o/1HZ5z0XokjPvGiP6ycOd5ivkDoawXSpaKCYkLSnqFqAWtjhk5juw5ilmEUDTMEXNYI8+deW2fo5aJsyoQmG75GaGCork7tB15ShH86z+hupMB2lnPjPPMY8pcBQozm/XNub9HFEdfirh9uAD9/0sutvKEUWcA9Fb9tLXHG74OzveY7SLapOFjiE9639xwNGYOg+fXWIWqQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd7b66c-4329-4e6d-8963-08debf20c8cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2026 14:27:46.1575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ifj8fQENg5eLYRr8OfN/EBwhTdT0YufA3hjdZ5OfybOFibVgOTHMSHJqd0QZ4kjr5FDaeFXom0CXTR9m9k6Bn7El6JJryLVZR0RRVxoSQX4orLyvuYMSSMCuPtQpxLzZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5015
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-37213-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,DS0PR11MB7880.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.863];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C4DF0616AC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA2ZjVkYzE5ZjQ2ZjRiZDBlMTA0Yzlh
NGRhMmYwYTkxMmNkZjNiZDg2Og0KDQogIE1lcmdlIHRhZyAnYXRoLW5leHQtMjAyNjA1MjYnIG9m
IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9hdGgvYXRoICgy
MDI2LTA1LTI4IDEwOjIzOjE1ICswMjAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVw
b3NpdG9yeSBhdDoNCg0KICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC9pd2x3aWZpL2l3bHdpZmktbmV4dC5naXQvIHRhZ3MvaXdsd2lmaS1uZXh0LTIwMjYt
MDUtMzENCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDkzM2M3ZTU5MWU0MTEyZGMz
ZDY2NDM3NGM2YTYyZDcxNTNkZjFkMTY6DQoNCiAgd2lmaTogaXdsd2lmaTogYnVtcCBtYXhpbXVt
IGNvcmUgdmVyc2lvbiBmb3IgQlovU0MvRFIgdG8gMTA2ICgyMDI2LTA1LTMxIDE3OjIyOjU1ICsw
MzAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQp3aWZpOiBpd2x3aWZpLW5leHQgLSAyMDI2LTA1LTMxDQoNClRoaXMg
Y29udGFpbnMgZmVhdHVyZXMsIGNsZWFudXBzIGFuZCBmaXhlcy4NCg0KVGhhbmtzLA0KTWlyaQ0K
LS0tDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCkF2aW5hc2ggQmhhdHQgKDMpOg0KICAgICAgd2lmaTogaXdsd2lmaTog
bWxkOiBhZGQgS1VuaXQgdGVzdHMgZm9yIGR1cGxpY2F0ZWQgYmVhY29uIFJTU0kgYWRqdXN0bWVu
dA0KICAgICAgd2lmaTogaXdsd2lmaTogbWxkOiBhZGQgS1VuaXQgdGVzdHMgZm9yIFBTRC9FSVJQ
IFJTU0kgYWRqdXN0bWVudA0KICAgICAgd2lmaTogaXdsd2lmaTogbWxkOiBhZGQgS1VuaXQgdGVz
dHMgZm9yIGxpbmsgZ3JhZGluZw0KDQpFbW1hbnVlbCBHcnVtYmFjaCAoMik6DQogICAgICB3aWZp
OiBpd2x3aWZpOiBhZGQgc3VwcG9ydCBmb3IgQVgyMzENCiAgICAgIHdpZmk6IGl3bHdpZmk6IGJ1
bXAgbWF4aW11bSBjb3JlIHZlcnNpb24gZm9yIEJaL1NDL0RSIHRvIDEwNg0KDQpJbGFuIFBlZXIg
KDEpOg0KICAgICAgd2lmaTogaXdsd2lmaTogbWxkOiBSZXF1aXJlIEhUIHN1cHBvcnQgZm9yIE5B
Tg0KDQpJc3JhZWwgS296aXR6ICgxKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1sZDogc3VwcG9y
dCBGVyBUTFYgZm9yIE5BTiBtYXggY2hhbm5lbCBzd2l0Y2ggdGltZQ0KDQpKb2hhbm5lcyBCZXJn
ICg2KToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IGZ3OiBjdXQgZG93biBOSUMgd2FrZXVwcyBkdXJp
bmcgZHVtcA0KICAgICAgd2lmaTogaXdsd2lmaTogbXZtOiByZW5hbWUgaXdsX212bV9tYWM4MDIx
MV9pZHhfdG9faHdyYXRlKCkNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1vdmUgaXdsX2Z3X3JhdGVf
aWR4X3RvX3BsY3AoKSB0byBtdm0NCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1sZDogZG9uJ3QgV0FS
TiBvbiBXb1dMQU4gc3VzcGVuZCB3L28gbmV0ZGV0ZWN0DQogICAgICB3aWZpOiBpd2x3aWZpOiBt
dm06IGZpeCBQMlAtRGV2aWNlIGJpbmRpbmcgaGFuZGxpbmcNCiAgICAgIHdpZmk6IGl3bHdpZmk6
IHBjaWU6IGZpeCB3cml0ZSBwb2ludGVyIG1vdmUgZGV0ZWN0aW9uDQoNCk1pcmkgS29yZW5ibGl0
ICg3KToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IHJlbW92ZSBzdGFsZSBjb21tZW50DQogICAgICB3
aWZpOiBpd2x3aWZpOiByZW1vdmUgbXZtIHByZWZpeCBmcm9tIG1hcmtlciBjb21tYW5kDQogICAg
ICB3aWZpOiBpd2x3aWZpOiBtbGQ6IGZpeCBzbWF0Y2ggd2FybmluZw0KICAgICAgd2lmaTogaXds
d2lmaTogbWxkOiBhbHdheXMgYWxsb3cgbWltbyBpbiBOQU4NCiAgICAgIHdpZmk6IGl3bHdpZmk6
IGZpeCBhIHR5cG8NCiAgICAgIHdpZmk6IGl3bHdpZmk6IHRyYW5zOiBleHBvcnQgdGhlIG1heGlt
dW0gc3VwcG9ydGVkIGhjbWQgc2l6ZQ0KICAgICAgd2lmaTogaXdsd2lmaTogbXZtOiByZW1vdmUg
X19tdXN0X2NoZWNrIGFubm90YXRpb24gZnJvbSBjb21tYW5kIHNlbmRpbmcNCg0KTW9yaXlhIEl0
emNoYWtpICgxKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IGZpeCBTVEVQX1VSTSByZWdpc3RlciBh
ZGRyZXNzIGZvciBTQyBkZXZpY2VzDQoNClBhZ2FkYWxhIFllc3UgQW5qYW5leXVsdSAoMSk6DQog
ICAgICB3aWZpOiBpd2x3aWZpOiBtbGQ6IHNldCBmYXN0LWJhbGFuY2Ugc2NhbiBmb3IgYWN0aXZl
IEVNTFNSDQoNClNoYWhhciBUemFyZmF0aSAoNCk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBjZmc6
IFJldmVydCAid2lmaTogaXdsd2lmaTogY2ZnOiBtb3ZlIHRoZSBNT0RVTEVfRklSTVdBUkUgdG8g
dGhlIHBlci1yZiBmaWxlIg0KICAgICAgd2lmaTogaXdsd2lmaTogcmVtb3ZlIG9ycGhhbmVkIERD
MkRDIGNvbmZpZyBlbnVtDQogICAgICB3aWZpOiBpd2x3aWZpOiBzdG9wIHN1cHBvcnRpbmcgY29y
ZTEwMQ0KICAgICAgd2lmaTogaXdsd2lmaTogbWxkOiBkcm9wIFRMQyBjb25maWcgY21kIHY0L3Y1
IGNvbXBhdCBjb2RlDQoNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2NmZy9i
ei5jICAgICAgICB8ICAxNiArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
Y2ZnL2RyLmMgICAgICAgIHwgICA0ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9jZmcvcmYtZm0uYyAgICAgfCAgMTIgLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVs
L2l3bHdpZmkvY2ZnL3JmLWdmLmMgICAgIHwgICAzICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9jZmcvc2MuYyAgICAgICAgfCAgIDQgKy0NCiAuLi4vbmV0L3dpcmVsZXNz
L2ludGVsL2l3bHdpZmkvZncvYXBpL2NvbW1hbmRzLmggICB8ICAgNCArLQ0KIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYXBpL2NvbmZpZy5oIHwgIDExICstDQogLi4uL25l
dC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2FwaS9kYXRhcGF0aC5oICAgfCAgIDIgKy0NCiBk
cml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2FwaS9kZWJ1Zy5oICB8ICAxNiAr
LQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYXBpL3JzLmggICAgIHwg
IDM0ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9kYmcuYyAgICAg
ICAgfCAgOTYgKystLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2Zp
bGUuaCAgICAgICB8ICAgMSArDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9m
dy9pbWcuaCAgICAgICAgfCAgIDEgKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvZncvcnMuYyAgICAgICAgIHwgIDI3IC0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwv
aXdsd2lmaS9pd2wtY29uZmlnLmggICAgfCAgIDYgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9p
bnRlbC9pd2x3aWZpL2l3bC1kcnYuYyAgICAgICB8ICAgNiArDQogZHJpdmVycy9uZXQvd2lyZWxl
c3MvaW50ZWwvaXdsd2lmaS9pd2wtcHJwaC5oICAgICAgfCAgIDMgKy0NCiBkcml2ZXJzL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2l3bC10cmFucy5jICAgICB8ICAgNSArDQogZHJpdmVycy9u
ZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtdHJhbnMuaCAgICAgfCAgMTUgKw0KIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL2QzLmMgICAgICAgIHwgICA3ICstDQog
ZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvbGluay5jICAgICAgfCAgMTUg
Ky0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9saW5rLmggICAgICB8
ICAgNiArDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvbWFjODAyMTEu
YyAgfCAgIDkgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9uYW4u
YyAgICAgICB8ICAgMyArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxk
L3NjYW4uYyAgICAgIHwgICA4ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lm
aS9tbGQvc3RhLmMgICAgICAgfCAgIDYgKw0KIC4uLi9pbnRlbC9pd2x3aWZpL21sZC90ZXN0cy9s
aW5rLXNlbGVjdGlvbi5jICAgICAgIHwgMjgwICsrKysrKysrKystLQ0KIC4uLi9uZXQvd2lyZWxl
c3MvaW50ZWwvaXdsd2lmaS9tbGQvdGVzdHMvbGluay5jICAgIHwgNDc0ICsrKysrKysrKysrKysr
KysrKysrLQ0KIC4uLi9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvdGVzdHMvdXRpbHMu
YyAgIHwgIDYwICsrKw0KIC4uLi9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvdGVzdHMv
dXRpbHMuaCAgIHwgICA5ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9t
bGQvdGxjLmMgICAgICAgfCAgNzQgLS0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvbWxkL3R4LmMgICAgICAgIHwgICAzICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50
ZWwvaXdsd2lmaS9tdm0vYmluZGluZy5jICAgfCAgIDUgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL212bS9tYWMtY3R4dC5jICB8ICAgNiArLQ0KIGRyaXZlcnMvbmV0L3dp
cmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL21hYzgwMjExLmMgIHwgIDEyICstDQogZHJpdmVycy9u
ZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbXZtLmggICAgICAgfCAgMjYgKy0NCiAuLi4v
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3RpbWUtZXZlbnQuYyAgICB8ICAgMyArLQ0K
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3R4LmMgICAgICAgIHwgIDEw
ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vdXRpbHMuYyAgICAg
fCAgMzIgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL3BjaWUvZHJ2LmMg
ICAgICB8ICAgMyArLQ0KIC4uLi93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL3BjaWUvZ2VuMV8yL2lu
dGVybmFsLmggIHwgICAxICsNCiAuLi4vaW50ZWwvaXdsd2lmaS9wY2llL2dlbjFfMi90cmFucy1n
ZW4yLmMgICAgICAgICB8ICAxMiArLQ0KIC4uLi9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9w
Y2llL2dlbjFfMi90cmFucy5jIHwgICA3ICstDQogNDMgZmlsZXMgY2hhbmdlZCwgMTAzMSBpbnNl
cnRpb25zKCspLCAzMDYgZGVsZXRpb25zKC0pDQo=

