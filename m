Return-Path: <linux-wireless+bounces-16404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E07629F2ADF
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 08:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA819167EBA
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 07:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986FD1CD1E0;
	Mon, 16 Dec 2024 07:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cgY/A+lY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E71B85E4;
	Mon, 16 Dec 2024 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734333692; cv=fail; b=XgCukcOzVz5zsohEeVwFqs51WBsJAjpzGWxsSNhKEwdJkLRh8x/JFvebD32tN3oyvCX/U6h0gHepVWIcVk5Xm210cOQw97IJd/AWee/8z+kypqe3F0DK6cQ6+uLQEHkHKBJzR8m8eEgWXth3mr6HsyAs1qqY8NT7npUmFT2uGkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734333692; c=relaxed/simple;
	bh=6l8VWQ0d6LYySlqZicYr1DxB9WKYdtGQx5nv+DfeojU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Odiun4t7AT8un4C0ZfMcxymVQLeutjhaM4dr9g+KuzgibW7j8+x4QSyZ5XpURrdDz9lUIFkOuYi69tgLoM9ZuV8VxpUF3VBx0+2G6DweyRbtXkTnPoD7Ahg1O+gJovhRf2OmgJti+J90jbZSrzu0sjTi3XzZBENa0p8flwx2O5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cgY/A+lY; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734333690; x=1765869690;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6l8VWQ0d6LYySlqZicYr1DxB9WKYdtGQx5nv+DfeojU=;
  b=cgY/A+lY4Y+tqaeOCqWqrI/9MhiWfTjDfDzlKA0tpfXQu5MCyLHBrNXo
   RsMsWVZykZXQAi+lwwC0ozWUv7xQF3MhBA47Ix0JqJPEYnDcZbLswoEY4
   ke7E5n4kQp192qviwig4zxTcUSBSznxazXZrBskWFofRkq6zeC30aZSMK
   P2i5l1Tw7tobfW50mnCddyLkSz/9kfAhA+VCOmRaXY62WkQryeBIYDYqb
   DSMz1XDau65CjV0MEynTo7lQoYaH5TPm0aGo0Sc9Lk4rFBZhRBOibIy87
   ZK8GqQrxrZ3R5FWbeV1JUsz6/jKlV27YRB1YZcaIV+tgKVvvyYhioN50U
   Q==;
X-CSE-ConnectionGUID: MiuMN4naTMG3UiNVD+vH0g==
X-CSE-MsgGUID: 1mUeG+K2QpuX+S1AvkvO0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34586346"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34586346"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 23:21:18 -0800
X-CSE-ConnectionGUID: 2O3QYrLlTnm56jQ9aM3jtw==
X-CSE-MsgGUID: daF5extWS6uHgn2Oywy6lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101265525"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2024 23:21:16 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 15 Dec 2024 23:21:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 15 Dec 2024 23:21:15 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 15 Dec 2024 23:21:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9kt8A/U3MVwZfrt6fjmgf1BjcVQo2E7YNr2tSB/mJcXkqqrl1YYOeCfZYky+CxSRI9FZ7NJ6HJiOvYzccXyi2Mdijhrop25dNAPt8Iof7JZawYZL/zD5LVvFHG4j4eaQnMCk2zjPZ/Tcz4OOD/yrUbuwPzApq1WBoWvM64S8iJ9yUo6Praz67sw+pez2eY+fh1MK7kQtbMZ9dstLD75dtaZeQ5qiipg2U60O1nF9x1mRSV444Mb+sPj0OnahXmRn6zPpUZqVSBzhc5gPiudN/r9Yp9q8+KTtuM3KtDm3pAyY2qk6OU6acvUPqEBLncWjZfpZgl5D9jvIAjvNh7Wxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6l8VWQ0d6LYySlqZicYr1DxB9WKYdtGQx5nv+DfeojU=;
 b=j1y8X0sjvNZiu/S1hLkIwGC7fGigs9fDHTUlOdIe2DHc2hmj2KuAx4ESNnfwNtKn6ivGVvkGQw717jX0D/8cwQyypgs9/QKMS/SBoabQxNESNYv8vo78p9KTS5hZDrhf3IxMyvCb3y+psCEQ/HPUl/mTu8jfmKoMauTIvgo30pvpZ3ZdYjzUo4dso7omB14OIrhYPFLqq71Y7O9tjsI9SP2pQumgfLWUZZy7RPp0+6yt3rTlQ3lQJE66wYg65+jG7thYpUInHnZw3S3nHzGNxUFDBcRkR+yQiOFyXq4a8r1fGIGXS2LOrSL3XWZBy8/IF7Td8bJ8TPvZ5TPHrdqx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by CH0PR11MB5315.namprd11.prod.outlook.com (2603:10b6:610:be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 07:21:11 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 07:21:11 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Kees Cook <kees@kernel.org>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>
CC: "Gustavo A . R . Silva" <gustavoars@kernel.org>, Kalle Valo
	<kvalo@kernel.org>, "Berg, Johannes" <johannes.berg@intel.com>, "Triebitz,
 Shaul" <shaul.triebitz@intel.com>, "Grumbach, Emmanuel"
	<emmanuel.grumbach@intel.com>, "Ben Shimol, Yedidya"
	<yedidya.ben.shimol@intel.com>, "Berg, Benjamin" <benjamin.berg@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>
Subject: RE: [PATCH RESEND] wifi: iwlwifi: mvm: Fix __counted_by usage in
 cfg80211_wowlan_nd_*
Thread-Topic: [PATCH RESEND] wifi: iwlwifi: mvm: Fix __counted_by usage in
 cfg80211_wowlan_nd_*
Thread-Index: AQHbT3ML9bmX+mO67UWB7Nn0+TR8nbLods/Q
Date: Mon, 16 Dec 2024 07:21:11 +0000
Message-ID: <MW5PR11MB58100FB6B101568871F8A4ECA33B2@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <20241216042843.work.498-kees@kernel.org>
In-Reply-To: <20241216042843.work.498-kees@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|CH0PR11MB5315:EE_
x-ms-office365-filtering-correlation-id: e1bb4711-a53a-497d-d809-08dd1da237b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Qk10RWFvN0tDcS90NW9mSUt2MVlGVGp5R0ZFTmY5WlRFRG1YSm9vUlhsQkFG?=
 =?utf-8?B?ZDV1cThWNDcrenJXVmV5dTloNlNycVlrYlVuRHVwUDJwRWdoVUhEQzNYbUtt?=
 =?utf-8?B?dWtHb3d6Y2JnWlpaanVvb3UzOXdxd1pxZkQwVmJQbXU3WDdmWGJiazF5Tnkr?=
 =?utf-8?B?ZW96cXhtNlR5eHJpVnFUTjgzYUtqZ2NxUFVmeUlrSVpGNHlBWkJnanpDUmpU?=
 =?utf-8?B?TS90dm1SSXlWWERvblNxRDUzVjVzaDlSQmJ4TS9SN1VRYytlSDQyd2tQK0dr?=
 =?utf-8?B?SGJrYkFhSEs3c1djeDFpNFV6OTJNVS91TnlleklrTFpHeDdPQUVDYlNTWXJB?=
 =?utf-8?B?Zmw3akZxUGxqdmd3Nm5janRCNmFUb2NLekdQSnJEY21oa2VydStDZjRIdmFx?=
 =?utf-8?B?VHBtODJkOWl1eWtGNXpuL0Eyazk1c1J3d0lhaVRkRGVSS013SFlVVWpDODJJ?=
 =?utf-8?B?YnFFL2N4dThDdWNNc1I4Yk5NK2RCVm9jL1l1ZEdXZ2s3MWk4Ym9xaEtzWEpT?=
 =?utf-8?B?QzJSbzVaMU1kOWFtaEJKUEJ1ZjJyRDFSSitwaTdoWGt4MkVBREU2bGhTK2hW?=
 =?utf-8?B?ZEZGYzc0aUdlb2E5UlVJWlRCV0RmNU9rb3VVM3FQODJpOVRiTzRtaWF6UHFE?=
 =?utf-8?B?ajh1Mm9MZTNOSExRR0ltN2hUMnQ4MFVScEpReUJiY0FaZTlvcnlENHdJK2c2?=
 =?utf-8?B?dUhNcDdkUHZmQ1RBSGloVmphMUtwbWZ5eWhOY0Y4dDlWY2R2TGVWQUdpbVFV?=
 =?utf-8?B?VXF5WDN0UEtFYXpNbGZKQVo0OVVTSmxxcTBkdGRIa05Lc2dyRjhlejdtZWdz?=
 =?utf-8?B?OGxTSDBtUnBNbEZVb0Q1TFFvdzZpSWNESnQzaGpGdmQrYTZIRmU5eURQUHhV?=
 =?utf-8?B?bkQ0WDRDVTQwV2tPcVVzenlCRTM5Z25EeDZyWDJiVHBxbGJLNXkzbTcwMjFW?=
 =?utf-8?B?VDAzWVJXMkFKSlI2MDdSa1l2TDFubUxvVjBnNElJN2tURjdsaEhiNDN2U2Fw?=
 =?utf-8?B?TWFwZ0FvQUkvYzZldUVQWFR2QVZEVXFvOElObHZJM3V2cFdXaW96N3dHbHIr?=
 =?utf-8?B?WHExdHQ0cXRWcmNMY3JNaE9wcVBReGI2RGtuVk1SOFVmOVZqRWZMOVMrUVJP?=
 =?utf-8?B?SVRSS3RQS29yQm9VY3dhN3d1a3pwNHBYRWpvSTJmRlJnRXFoRGNIYjFUa2Qx?=
 =?utf-8?B?cWFLT3JoZGtFd2dHN2pkRGF0aHlVY0lpNmg5dllaMEdSSmFHQXFpVi9Uc2xo?=
 =?utf-8?B?L1JKSWF2U3MvZmVnUnRsWlFjSDB2L1ROKy9CLzlaZ1BHbUtDUXdBTi9QQ2lo?=
 =?utf-8?B?cUVQT3NIOXdoUEdHQ2pIeHVySzRCQTF5bXhDdXZudUZlb0Y1TnZNTllrNktB?=
 =?utf-8?B?c1FNVW1PUUo5ZEo0STE1aDV5M2NQYWlWQ05US2c1NFBlOGRWS2EvTWpBRTFO?=
 =?utf-8?B?YzZOSGoreEw2WStoSjluaFhlOUpDM3ZqL1hDeXNNUCtiZ1NyNms3UWFHbzMy?=
 =?utf-8?B?YjdyODMrVVViSlJacDF5dlhQclQySFI1U1g5VlBxcHJpbzRtcHE3c2NNc0tT?=
 =?utf-8?B?YVBMa0pPc1Fra3N1Vk9yVkRWbGxldzJyTlFwSUdFaXJOWU53SlpkdlpBWXNY?=
 =?utf-8?B?VEdTYmtmOVFVNHNZNzM3bDZjM2dsY2pRVWRPYzBLOUtkT28rSGY5OHViMFhX?=
 =?utf-8?B?c1pDMjJXSnk2RnVLakRKNEZvVVJoYzkvNjh3TU0zKzd0aUpQbWdvbFlJTzgy?=
 =?utf-8?B?QnEyY0RNamZOL0FWUjBoV2pnM0xzU2hwWE1weXVpaTBPWVQ3TjVUbXFSampW?=
 =?utf-8?B?bmlmcC9OaHhpaTRZaU9ROW01Nm1LY0hMS0xRRG9RUEsyeUNpbG1DSWZUZVhD?=
 =?utf-8?B?c0cvM3JjdWorc2Jxa292OEk0aUNwc0E0c0Q2T2VHeFZjZXY5OEJPOEJKMEpF?=
 =?utf-8?B?SkpBUlBMQmdhTVZLQitLb0JTVTVYMDR1RDF3NkFFTVlMRFRDeldFT3pzOSt2?=
 =?utf-8?B?dEZhYkxBN1F3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHI3akRsM0RETFhuRzQ4NEh5S0s5WWtpNWpJNWQ4MnBsb2dEdkVSb05kQVRu?=
 =?utf-8?B?VCtYbnJYanlvMTZmdTYyanB0MTJPMlVVZzVwdTFlM21kVDhmNmFHeEJRTGhF?=
 =?utf-8?B?bmczNVpJdFZrRTVOL2k3UUYvaEZzWXgyUmsrNUdPV1FxWm54OVJPUmdtSUov?=
 =?utf-8?B?d3ZIUldlbFExVlhoWEdFNWNYTFlQNWUrK3lVSkR4aFMyTDdJMlZBYnFmeDB2?=
 =?utf-8?B?YzNPUm5YLzN2S1JvVTJJZTMzZGo1U2dvNGFXZlFMM1pBUzNIMmU2UVdoRXlE?=
 =?utf-8?B?TUMyM0VYeUtveUFJTEd3VURHR3ZpRWJia3drRHA2WXhnbk94b1VOdkE4aVox?=
 =?utf-8?B?ejFtRGJCcXdWeThFWk1nQ1V6SDNGSEtkMXZTUGh5aXdaZ3dBeWlaZWorK0lm?=
 =?utf-8?B?Wk5wS2xrdU9aakdtc2xJZit3aFUxTnlTTHdMbHlPeExjVVg2L2kyc3lmYjZh?=
 =?utf-8?B?TW1BTVlsT2dxTGt5WDYxQmFTa2FkWlMrMEloYUFEaVNtZjIzZHlFVkVtMmhH?=
 =?utf-8?B?WmtiY0R4WmNVMUZTVGQzQlN3RGJLUDNoTGVGdk9NN1gzMFM3bHlSU0F1bDJF?=
 =?utf-8?B?bXFNLzVxNXVDd1JyYkRMaCtVMXAyamxOUGd2STZDWno4WnFzVkZyM1Z1bTBZ?=
 =?utf-8?B?NGJHMXU4Y01SemVUYmhIZVQ2VGpSQjdseUJ1cmduUUZ2NjlhV0dCMEdYK1Jw?=
 =?utf-8?B?N1JJNjdublBqNzkzQmsyQm9jZ2RMSk9lemJvZW82MGU0N2NXS3Vuc3JmQzZz?=
 =?utf-8?B?ZW9uc3JvVW1WMytCNXQ4OENvUGg4VE9GYk9JaDJyckp6MlZvZGhOc0ExTzR2?=
 =?utf-8?B?bWtUaHEzaXFXbk1SUGNzTTlpZUY2bGpaaVd6Z0pXRlpWUzV3ZGNXc3diWlgy?=
 =?utf-8?B?eTRtbkpnUDg4ZkpJWjJnR2w0ZkROVDQzdVhtMTUzZWxhb2JXdzdBN0owYmU0?=
 =?utf-8?B?T2FUM2JNUk16WktvOWZxUDN3RlI2RXZXM1ZFSC9DbXlCdkd6TXdVeWw3U3R2?=
 =?utf-8?B?RHl3dXlrdkQ4bmNSekxFNFVJaTI3TmVMd0YrQWlCOTY1YUFrSG0zVEQ4Q3Jq?=
 =?utf-8?B?Z1pwNWJQUVRKRmNyOVZ0dHEybkVqMWh1dmJCYTNMcWZPTWUxalV5QXhpSnk2?=
 =?utf-8?B?NkgvRnpkNzVTVFptN3ZQbHMrM0d3QVErcktKMTVsR1RrakRUNC9Da0cvSnEv?=
 =?utf-8?B?R29TcDFoeVdkTSt3Y0ZUdzljb2I2TFNtT2ljS01mZDh0SDl2Q0VYeXRGNXpa?=
 =?utf-8?B?aWk1V0RBYUkvc3BqQW9FaTZiSHdDdTZtSEdpKzZpeUhza1ZFbmcrSWZkaE9M?=
 =?utf-8?B?alFpaFpzQWVNY0JXUkZQSTRDWitjUFZndDlCb3ZtOSttclVVRVB6ZTRVclFu?=
 =?utf-8?B?Ty90U1hYZngrdU8vdUEyVHE2RWFXWnA0Uk1EalRPUzdTdGlpaWNpM2ExWERJ?=
 =?utf-8?B?NEk4MklVcldKeVQyMGF6KzlKU3BFendrRk5HRjQzMFMrMFl5QTJkMWtnVFBV?=
 =?utf-8?B?QU9BaG44WW5SeWlYd2FkR0ZIMFd2MjVjcHFPTUpKd0szRHkvVGloVEJBRHVx?=
 =?utf-8?B?d0Y5UE1BTzcrNFZIRWFEdkIxaW10SHVobXR3OWM3V0JJaGRVMUQ0a2taQVVh?=
 =?utf-8?B?cEYwcGFEeUlvZERNRFlZQ0VDdVErbGxNK3EwZEtHWGdRWldkRnMxVXhYYVNm?=
 =?utf-8?B?M1JPUjUxMDhzU2h1RDQxTHoxRHhFU3JJWUpqSzFGTEtkUGhGdG9jR2xQYUlq?=
 =?utf-8?B?dUlTNFlMT2p3ZUN2dXJaR3llZEtERXFNY1NZVjdiSzY0cWdjQllnWnVCSFdi?=
 =?utf-8?B?VERQT2tpT3BQTC8walYyYktNTFVIRnlKR3I2S242QzFuci8xNmFJaFRoU1VY?=
 =?utf-8?B?eVEvOTA0YmJ3THpyL1BaWmhRK2JsVXVkK2ZWdk9YVWJxMVNjS2dvR3ZSN1hp?=
 =?utf-8?B?aE04WE10Nll5cFhnSmdlNGdtVXFDYnVyNHpMR1psUEhFTWhaTWxXbzdMUlBY?=
 =?utf-8?B?MHlnbGNMZTV4M0lNU3hzenBwaXc0WkVLc1lORldxN294U2RwZE1mbEpOb2pL?=
 =?utf-8?B?R3l3dHlHV29VQ3g4WHVvc2M5b2s5RzllY1lOaFdpUUxwdTUxNFl0MzlmbThK?=
 =?utf-8?B?NnUzbWRWQnBSWERMaTFUSCtCNmlWWUdHc0JjSnNSQjNCemNaUkdPcTRWa1Qr?=
 =?utf-8?B?dEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bb4711-a53a-497d-d809-08dd1da237b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 07:21:11.3023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 18OIwiOaAxPZtSgmK92yUypDxOvmvo5Li+XKDBttL+m3eTV4e4X4M/hwhAD5SlDD0MRAw7yabcYyDM2L8CMjIZqfLIP2h5RtXDeyruPO966zQtkeRSumgRlV5K8FDGxP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5315
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2VlcyBDb29rIDxrZWVz
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgMTYgRGVjZW1iZXIgMjAyNCA2OjI5DQo+IFRv
OiBDaHJpc3RvcGhlIEpBSUxMRVQgPGNocmlzdG9waGUuamFpbGxldEB3YW5hZG9vLmZyPg0KPiBD
YzogS2VlcyBDb29rIDxrZWVzQGtlcm5lbC5vcmc+OyBHdXN0YXZvIEEgLiBSIC4gU2lsdmEgPGd1
c3Rhdm9hcnNAa2VybmVsLm9yZz47DQo+IEtvcmVuYmxpdCwgTWlyaWFtIFJhY2hlbCA8bWlyaWFt
LnJhY2hlbC5rb3JlbmJsaXRAaW50ZWwuY29tPjsgS2FsbGUgVmFsbw0KPiA8a3ZhbG9Aa2VybmVs
Lm9yZz47IEJlcmcsIEpvaGFubmVzIDxqb2hhbm5lcy5iZXJnQGludGVsLmNvbT47IFRyaWViaXR6
LCBTaGF1bA0KPiA8c2hhdWwudHJpZWJpdHpAaW50ZWwuY29tPjsgR3J1bWJhY2gsIEVtbWFudWVs
DQo+IDxlbW1hbnVlbC5ncnVtYmFjaEBpbnRlbC5jb20+OyBCZW4gU2hpbW9sLCBZZWRpZHlhDQo+
IDx5ZWRpZHlhLmJlbi5zaGltb2xAaW50ZWwuY29tPjsgQmVyZywgQmVuamFtaW4gPGJlbmphbWlu
LmJlcmdAaW50ZWwuY29tPjsNCj4gRG1pdHJ5IEFudGlwb3YgPGRtYW50aXBvdkB5YW5kZXgucnU+
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gd2lyZWxlc3NAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1oYXJkZW5pbmdAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQ
QVRDSCBSRVNFTkRdIHdpZmk6IGl3bHdpZmk6IG12bTogRml4IF9fY291bnRlZF9ieSB1c2FnZSBp
bg0KPiBjZmc4MDIxMV93b3dsYW5fbmRfKg0KPiANCj4gQm90aCBzdHJ1Y3QgY2ZnODAyMTFfd293
bGFuX25kX21hdGNoIGFuZCBzdHJ1Y3QgY2ZnODAyMTFfd293bGFuX25kX2luZm8NCj4gcHJlLWFs
bG9jYXRlIHNwYWNlIGZvciBjaGFubmVscyBhbmQgbWF0Y2hlcywgYnV0IHRoZW4gbWF5IGVuZCB1
cCB1c2luZyBmZXdlcg0KPiB0aGF0IHRoZSBmdWxsIGFsbG9jYXRpb24uIFNocmluayB0aGUgYXNz
b2NpYXRlZCBjb3VudGVyIChuX2NoYW5uZWxzIGFuZCBuX21hdGNoZXMpDQo+IGFmdGVyIGNvdW50
aW5nIHRoZSByZXN1bHRzLiBUaGlzIGF2b2lkcyBjb21waWxlLXRpbWUgKGFuZCBydW4tdGltZSkg
d2FybmluZ3MgZnJvbQ0KPiBfX2NvdW50ZWRfYnkuIChUaGUgY291bnRlciBtZW1iZXIgbmVlZHMg
dG8gYmUgdXBkYXRlZCBfYmVmb3JlXyBhY2Nlc3NpbmcgdGhlDQo+IGFycmF5IGluZGV4LikNCj4g
DQo+IFNlZW4gd2l0aCBjb21pbmcgR0NDIDE1Og0KPiANCj4gZHJpdmVycy9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9tdm0vZDMuYzogSW4gZnVuY3Rpb24NCj4gJ2l3bF9tdm1fcXVlcnlfc2V0
X2ZyZXFzJzoNCj4gZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vZDMuYzoy
ODc3OjY2OiB3YXJuaW5nOiBvcGVyYXRpb24gb24NCj4gJ21hdGNoLT5uX2NoYW5uZWxzJyBtYXkg
YmUgdW5kZWZpbmVkIFstV3NlcXVlbmNlLXBvaW50XQ0KPiAgMjg3NyB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgbWF0Y2gtPmNoYW5uZWxzW21hdGNoLT5uX2NoYW5uZWxzKytdID0N
Cj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB+fn5+fn5+fn5+fn5+fn5+fl5+DQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvbXZtL2QzLmM6Mjg4NTo2Njogd2FybmluZzogb3BlcmF0aW9uIG9uDQo+ICdtYXRjaC0+bl9j
aGFubmVscycgbWF5IGJlIHVuZGVmaW5lZCBbLVdzZXF1ZW5jZS1wb2ludF0NCj4gIDI4ODUgfCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hdGNoLT5jaGFubmVsc1ttYXRjaC0+bl9j
aGFubmVscysrXSA9DQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfn5+fn5+fn5+fn5+fn5+fn5efg0KPiBkcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL212bS9kMy5jOiBJbiBmdW5jdGlvbg0KPiAnaXdsX212bV9xdWVyeV9u
ZXRkZXRlY3RfcmVhc29ucyc6DQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
bXZtL2QzLmM6Mjk4Mjo1ODogd2FybmluZzogb3BlcmF0aW9uIG9uDQo+ICduZXRfZGV0ZWN0LT5u
X21hdGNoZXMnIG1heSBiZSB1bmRlZmluZWQgWy1Xc2VxdWVuY2UtcG9pbnRdDQo+ICAyOTgyIHwg
ICAgICAgICAgICAgICAgIG5ldF9kZXRlY3QtPm1hdGNoZXNbbmV0X2RldGVjdC0+bl9tYXRjaGVz
KytdID0gbWF0Y2g7DQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfn5+fn5+fn5+fn5+fn5+fn5+fn5+Xn4NCj4gDQo+IEZpeGVzOiBhYTRlYzA2YzQ1NWQgKCJ3
aWZpOiBjZmc4MDIxMTogdXNlIF9fY291bnRlZF9ieSB3aGVyZSBhcHByb3ByaWF0ZSIpDQo+IFJl
dmlld2VkLWJ5OiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvYXJzQGtlcm5lbC5vcmc+DQo+
IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDA2MTkyMTEyMzMud29yay4zNTUt
a2Vlc0BrZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IEtlZXMgQ29vayA8a2Vlc0BrZXJuZWwu
b3JnPg0KPiAtLS0NCj4gUGluZ2luZyB0aGlzIHBhdGNoIGFnYWluLCBzZWUNCj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGttbC8yMDI0MDYxOTIxMTIzMy53b3JrLjM1NS1rZWVzQGtlcm5lbC5v
cmcvDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vZDMu
YyB8IDE0ICsrKysrKysrKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL212bS9kMy5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwv
aXdsd2lmaS9tdm0vZDMuYw0KPiBpbmRleCBmODVjMDFlMDRlYmYuLjdkOTczNTQ2YzlmYiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vZDMuYw0K
PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9kMy5jDQo+IEBA
IC0yOTU0LDYgKzI5NTQsNyBAQCBzdGF0aWMgdm9pZCBpd2xfbXZtX3F1ZXJ5X3NldF9mcmVxcyhz
dHJ1Y3QgaXdsX212bQ0KPiAqbXZtLA0KPiAgCQkJCSAgICBpbnQgaWR4KQ0KPiAgew0KPiAgCWlu
dCBpOw0KPiArCWludCBuX2NoYW5uZWxzID0gMDsNCj4gDQo+ICAJaWYgKGZ3X2hhc19hcGkoJm12
bS0+ZnctPnVjb2RlX2NhcGEsDQo+ICAJCSAgICAgICBJV0xfVUNPREVfVExWX0FQSV9TQ0FOX09G
RkxPQURfQ0hBTlMpKSB7IEBAIC0NCj4gMjk2Miw3ICsyOTYzLDcgQEAgc3RhdGljIHZvaWQgaXds
X212bV9xdWVyeV9zZXRfZnJlcXMoc3RydWN0IGl3bF9tdm0NCj4gKm12bSwNCj4gDQo+ICAJCWZv
ciAoaSA9IDA7IGkgPCBTQ0FOX09GRkxPQURfTUFUQ0hJTkdfQ0hBTk5FTFNfTEVOICogODsNCj4g
aSsrKQ0KPiAgCQkJaWYgKG1hdGNoZXNbaWR4XS5tYXRjaGluZ19jaGFubmVsc1tpIC8gOF0gJiAo
QklUKGkgJSA4KSkpDQo+IC0JCQkJbWF0Y2gtPmNoYW5uZWxzW21hdGNoLT5uX2NoYW5uZWxzKytd
ID0NCj4gKwkJCQltYXRjaC0+Y2hhbm5lbHNbbl9jaGFubmVscysrXSA9DQo+ICAJCQkJCW12bS0+
bmRfY2hhbm5lbHNbaV0tPmNlbnRlcl9mcmVxOw0KPiAgCX0gZWxzZSB7DQo+ICAJCXN0cnVjdCBp
d2xfc2Nhbl9vZmZsb2FkX3Byb2ZpbGVfbWF0Y2hfdjEgKm1hdGNoZXMgPSBAQCAtDQo+IDI5NzAs
OSArMjk3MSwxMSBAQCBzdGF0aWMgdm9pZCBpd2xfbXZtX3F1ZXJ5X3NldF9mcmVxcyhzdHJ1Y3Qg
aXdsX212bQ0KPiAqbXZtLA0KPiANCj4gIAkJZm9yIChpID0gMDsgaSA8IFNDQU5fT0ZGTE9BRF9N
QVRDSElOR19DSEFOTkVMU19MRU5fVjEgKg0KPiA4OyBpKyspDQo+ICAJCQlpZiAobWF0Y2hlc1tp
ZHhdLm1hdGNoaW5nX2NoYW5uZWxzW2kgLyA4XSAmIChCSVQoaSAlIDgpKSkNCj4gLQkJCQltYXRj
aC0+Y2hhbm5lbHNbbWF0Y2gtPm5fY2hhbm5lbHMrK10gPQ0KPiArCQkJCW1hdGNoLT5jaGFubmVs
c1tuX2NoYW5uZWxzKytdID0NCj4gIAkJCQkJbXZtLT5uZF9jaGFubmVsc1tpXS0+Y2VudGVyX2Zy
ZXE7DQo+ICAJfQ0KPiArCS8qIFdlIG1heSBoYXZlIGVuZGVkIHVwIHdpdGggZmV3ZXIgY2hhbm5l
bHMgdGhhbiB3ZSBhbGxvY2F0ZWQuICovDQo+ICsJbWF0Y2gtPm5fY2hhbm5lbHMgPSBuX2NoYW5u
ZWxzOw0KPiAgfQ0KPiANCj4gIC8qKg0KPiBAQCAtMzA1Myw2ICszMDU2LDggQEAgc3RhdGljIHZv
aWQgaXdsX212bV9xdWVyeV9uZXRkZXRlY3RfcmVhc29ucyhzdHJ1Y3QNCj4gaXdsX212bSAqbXZt
LA0KPiAgCQkJICAgICBHRlBfS0VSTkVMKTsNCj4gIAlpZiAoIW5ldF9kZXRlY3QgfHwgIW5fbWF0
Y2hlcykNCj4gIAkJZ290byBvdXRfcmVwb3J0X25kOw0KPiArCW5ldF9kZXRlY3QtPm5fbWF0Y2hl
cyA9IG5fbWF0Y2hlczsNCj4gKwluX21hdGNoZXMgPSAwOw0KPiANCj4gIAlmb3JfZWFjaF9zZXRf
Yml0KGksICZtYXRjaGVkX3Byb2ZpbGVzLCBtdm0tPm5fbmRfbWF0Y2hfc2V0cykgew0KPiAgCQlz
dHJ1Y3QgY2ZnODAyMTFfd293bGFuX25kX21hdGNoICptYXRjaDsgQEAgLTMwNjYsOA0KPiArMzA3
MSw5IEBAIHN0YXRpYyB2b2lkIGl3bF9tdm1fcXVlcnlfbmV0ZGV0ZWN0X3JlYXNvbnMoc3RydWN0
IGl3bF9tdm0NCj4gKm12bSwNCj4gIAkJCQlHRlBfS0VSTkVMKTsNCj4gIAkJaWYgKCFtYXRjaCkN
Cj4gIAkJCWdvdG8gb3V0X3JlcG9ydF9uZDsNCj4gKwkJbWF0Y2gtPm5fY2hhbm5lbHMgPSBuX2No
YW5uZWxzOw0KPiANCj4gLQkJbmV0X2RldGVjdC0+bWF0Y2hlc1tuZXRfZGV0ZWN0LT5uX21hdGNo
ZXMrK10gPSBtYXRjaDsNCj4gKwkJbmV0X2RldGVjdC0+bWF0Y2hlc1tuX21hdGNoZXMrK10gPSBt
YXRjaDsNCj4gDQo+ICAJCS8qIFdlIGludmVydGVkIHRoZSBvcmRlciBvZiB0aGUgU1NJRHMgaW4g
dGhlIHNjYW4NCj4gIAkJICogcmVxdWVzdCwgc28gaW52ZXJ0IHRoZSBpbmRleCBoZXJlLg0KPiBA
QCAtMzA4Miw2ICszMDg4LDggQEAgc3RhdGljIHZvaWQgaXdsX212bV9xdWVyeV9uZXRkZXRlY3Rf
cmVhc29ucyhzdHJ1Y3QNCj4gaXdsX212bSAqbXZtLA0KPiANCj4gIAkJaXdsX212bV9xdWVyeV9z
ZXRfZnJlcXMobXZtLCBkM19kYXRhLT5uZF9yZXN1bHRzLCBtYXRjaCwgaSk7DQo+ICAJfQ0KPiAr
CS8qIFdlIG1heSBoYXZlIGZld2VyIG1hdGNoZXMgdGhhbiB3ZSBhbGxvY2F0ZWQuICovDQo+ICsJ
bmV0X2RldGVjdC0+bl9tYXRjaGVzID0gbl9tYXRjaGVzOw0KPiANCj4gIG91dF9yZXBvcnRfbmQ6
DQo+ICAJd2FrZXVwLm5ldF9kZXRlY3QgPSBuZXRfZGV0ZWN0Ow0KPiAtLQ0KPiAyLjM0LjENCg0K
SGkgLA0KDQpUaGUgcGF0Y2ggd2FzIGFscmVhZHkgYXBwbGllZCBhbmQgbWFya2VkIGluIFBhdGNo
d29yayBhcyBzdWNoLiANCg0KTWlyaQ0KDQo=

