Return-Path: <linux-wireless+bounces-27813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A75BB91E6
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Oct 2025 23:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58B9C4E0452
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Oct 2025 21:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68A21A9FB0;
	Sat,  4 Oct 2025 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hEk2kuwi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6A019F111;
	Sat,  4 Oct 2025 21:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759611643; cv=fail; b=U0b7pQdVNVUFFnAL6UK3eLhDjZwhe+pA3czsc+45aPenvYVUNQoaXWazOyCyMC1BLj9Lql1UHyy1HNNVOrt5U5LxIl3yzYbdngZkVI6VpClwK1vvSDSMJAHPhSJADQE0rmQXGyt9DwLT6ZKtMivWoc4diJA5wel40V3VRe6bK3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759611643; c=relaxed/simple;
	bh=kFqIKPxD84gBwmajp1uQKB7VQ71j3Ktsv16fFAg1sX0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L6iPjd5ScbB0GcQBquqboIY35hEGzArQ3g9mqGgXB7JaSvKJMwx+tPpcp7hPTh4wN+O++zKjNim6+cK2ZKDzHSucVCwUZdadZ35sodhtYO+SIEDB7a/+yUAMnCZ6j7Ck+pQXMIBGtVtly+HMM7adFgV3/Qgl0PACFLmcJ/I/+/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hEk2kuwi; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759611642; x=1791147642;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kFqIKPxD84gBwmajp1uQKB7VQ71j3Ktsv16fFAg1sX0=;
  b=hEk2kuwiFBOGQNBLydtBoGKBgfZTb7Kz1RywQpJOVEBHWa3aYOPV5tyQ
   dC7VB2EaH9LFodVJmcP1pwK05KQkWYIzewV7+eSdBYku0wMQcoG1R4bNP
   OMBeVOJN9IKXXCP5Y+QV224SjhHEegBGersGavvBBkH5NPVnyXcwo7wRA
   +h7SENYYr6E/AOH6VadNfzKxJtUdgKPLDOTGMP//mSTqe4BArGjd0rPjr
   mt+UTqATIX064MtYkA/Cv9pd4gAytDQVemVnluTBKSrBJpo3YdElSqy3r
   Q8hTtWwOuYX05eJsoCRy8asTO/BkK4Ke9yBvQHvMQG14i3Ez3lbqbTyIL
   w==;
X-CSE-ConnectionGUID: C3WAdiL2RZKesqh5fS5GNg==
X-CSE-MsgGUID: pK2I3F7dR96BsFv9XOvgrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11572"; a="87308040"
X-IronPort-AV: E=Sophos;i="6.18,316,1751266800"; 
   d="scan'208";a="87308040"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2025 14:00:41 -0700
X-CSE-ConnectionGUID: Jo6/O1B1QHqVDbmBWsBNYg==
X-CSE-MsgGUID: eZacj9tmRJug6GcS4Q3LBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,316,1751266800"; 
   d="scan'208";a="178843632"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2025 14:00:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 4 Oct 2025 14:00:40 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sat, 4 Oct 2025 14:00:40 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 4 Oct 2025 14:00:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGThDaV1R0bbs+XS0qkGawmBeFPoXOGhS5sh3R5pIYkHZwiOetvV5Y/NtUORuEf7qytEw37yPmiJypHMSPQ1960DmiXxLBiRP9ecmfhfYCoh6LqAPHNFdzLiP3xfQHlSbSlkYdqwx068EjqRKuPTeZ+zMLbC/WFGjWvPQFypM6OBb+XEYptfnfBrUgBq8fKExasE1aKgzlcEvAso+n3dRfc6CtnzbTOCrCkRPvuX4B64sZqW20z4ht4YS4bzU8/8IJ2tlkdDeuA7D6y7zRFFhR7qyji/D//Ke9XTNXoPIRqEKKEYGr93F5tx1Mx3/siioQ+xNH7Vqta3qmlBPLAEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFqIKPxD84gBwmajp1uQKB7VQ71j3Ktsv16fFAg1sX0=;
 b=k7wk50qltuI3XabuAr0vUVZbDJF36CN4Hcz4shKBbl3XQRdLMWIIJUQxYsaTzF+XIdpc079cyEMImDKuYkkDlE7Z07NeTTZx8ueWyLme9b5y/5GY7IRgKC86ruF5kXzE5KApRV3xIi73Es+K8s/ZMm8p19zYIIfIoC/LURSZXGOKwJYFNPmiJxUG1gzbUZntC8fXzUaNyRbvtdPCUX/xaH1in029dU/nkMIMMKe2jdwTxvcUTJLr0StXYV9XjbLiMztWm8W+jUDM3XPfEtbfeGljtcap365y/d5ztBCkjPJbegIc5EaSE5AFT940OOrTlrMQGbcKFwWBbqioSIJ6FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by PH7PR11MB6772.namprd11.prod.outlook.com
 (2603:10b6:510:1b6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Sat, 4 Oct
 2025 21:00:34 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987%5]) with mapi id 15.20.9137.018; Sat, 4 Oct 2025
 21:00:34 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>, "Berg, Johannes"
	<johannes.berg@intel.com>, "Anjaneyulu, Pagadala Yesu"
	<pagadala.yesu.anjaneyulu@intel.com>, "Grumbach, Emmanuel"
	<emmanuel.grumbach@intel.com>, Bhaskar Chowdhury <unixbhaskar@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, "Peer, Ilan"
	<ilan.peer@intel.com>, "Gabay, Daniel" <daniel.gabay@intel.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Revert "wifi: iwlwifi: mvm: remove support for
 REDUCE_TX_POWER_CMD ver 6 and 7"
Thread-Topic: [PATCH] Revert "wifi: iwlwifi: mvm: remove support for
 REDUCE_TX_POWER_CMD ver 6 and 7"
Thread-Index: AQHcNTlm+VnB67gfYEuELYoxWi9tT7SyCSiAgABvtjA=
Date: Sat, 4 Oct 2025 21:00:34 +0000
Message-ID: <DM3PPF63A6024A97A503FF0208F582651E1A3E5A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20251004141539.6512-1-brgl@bgdev.pl>
 <CAMRc=Mepopam1zhUONtratqopa6zHhsJfah9JO9D2VKyXcqjEQ@mail.gmail.com>
In-Reply-To: <CAMRc=Mepopam1zhUONtratqopa6zHhsJfah9JO9D2VKyXcqjEQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|PH7PR11MB6772:EE_
x-ms-office365-filtering-correlation-id: 564fa793-bb1f-4b32-ccb9-08de03890fae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|921020;
x-microsoft-antispam-message-info: =?utf-8?B?VUgvdkppVmJzUVc5aGYxWHhQVW80a2dNYkxpb3VjWEdDeW1ua3JKdTN0UUcw?=
 =?utf-8?B?VnpQUHhuVW11ck5Vd2lVemNPTmdUZW9VQXZmSjIxdGNBam15eE52SUJQdGZ2?=
 =?utf-8?B?OUdmc2dYbG9WV3o0RzJXeCtaWHlvS2plVDNSalpWT0tpV2tmc3lRNmtDVmpV?=
 =?utf-8?B?cmVNWFJyS2c5R29BVUNrdmtmV1lPanVZS3d6RENiSWhYb3IwN2VFaFFLNFlq?=
 =?utf-8?B?NHBFQXRCZ1hNL0xpVHpVZDZLUnFRSWJpQnhscnBVcXM2V3BEV1JIUHhkZEh6?=
 =?utf-8?B?OFVrK05TcXd0dFpkSEJGWk9DT0pDVnhoTVNpUEdmcEloTFM1OC9GVEtZYjdO?=
 =?utf-8?B?bXM0MWdSMElEeVRaSThadENtV1VtZ1BycTkyZXVjeWJzVW9EaElnOGNqek9p?=
 =?utf-8?B?ZXg4MkttQ3Q1SjFBMVEzanFFSnl6dTBOdXlPUUZYWkxSdDlRRmZOWVAwVDBN?=
 =?utf-8?B?NDR4V2hiRGdXS0N6T1hQZzA4bVJXMzVaZUE4Ynl3RXVRakhNTkZHQnhYZW9J?=
 =?utf-8?B?MlBEMXZyT0pxU0xMdW0xeUpoakVDcmkyVzBwK1ZncGpXYkd2bXNRNzJSK1k4?=
 =?utf-8?B?T0FwNE5CU0JiWTVDMURiZ0U4STN3cDNKSm1pZUxJUnRxN3NnNnpjSHBQRUZT?=
 =?utf-8?B?c2hhWHJoQ2hsNkNaMlkrS2tZOXZ1OWFnQnlrekJEa3JiS1B2LzQ3ZVlTZzNL?=
 =?utf-8?B?b0IxbWVJVDFXNEZHRWZWT1hJUjZCR3pzYTlkL2JmbmNmU2ZDbFo1TGd3c0xD?=
 =?utf-8?B?MldjOXc2bDBJTnNjVlZTZE8yVmh1dGcvK29tQTVnYmVsTlE2S1l2WTlXdnRB?=
 =?utf-8?B?U2NCUTBCeFR1b2R5Q3F3YXVvWWc1aEF4SmhjcVNMRHRvOTNaSWgrd2c2UWYw?=
 =?utf-8?B?OVM2SGtWd2tyYWlxaG5KZlFrbHo1SWNMY29sV2x4RzYwMUE1WU82Nm5UdnE1?=
 =?utf-8?B?QWQxUll2R1Qrby9jQTB5eGFvNjJZZEFJZk9TSFJQNXY5Ly9OOFl0b29mZnRW?=
 =?utf-8?B?UHY5MmVyeklyY2lmcDl3OEFmZldhbjNyUDRrbUZmOUt2VHMyNnpiZmU1cWZH?=
 =?utf-8?B?b2dDc0ZnMGhhTFN6Q1hHQnFrR2NWNmtZdUNMQTFGY08yQW9JdlNkL0FqYmhI?=
 =?utf-8?B?SHVmOGU0ZXJucXA1dDd5Vm1LZmV6ZDcxb1pVS2dsclpiOGwrWHBNTWRDQ2dV?=
 =?utf-8?B?UEFFNVlicEMrd3NWNHIvRzA1c3dFVUtrdHJaRUZPQkM2S0IvZmJzcjNMZ0Qx?=
 =?utf-8?B?QjY5SElQYUxRa01WUGtkdXlEaWgvM0tza2hQVGpWcldSQTBWMTFxejg4Q2pp?=
 =?utf-8?B?YXg4aVU1R0Y5MTkxdFlrd3dmbGxSMElVYW5Uc2pSTDJ2ZXRkTEZsK1FtNmNP?=
 =?utf-8?B?UnVBVG96R3pvN2xPOWRqOGNWR1JPbUp2OVFHcUtnQWJHZ0Y3SllNUklhQkdQ?=
 =?utf-8?B?UHo0M2lUQm5TWXhhVEJoTlkwM0Vib2lqSnhYam1mZUJndWYxbkJ2clRCZTNr?=
 =?utf-8?B?cjBndmw0bEtHeUEvT21tY0tmcjVYMzVnNVk0bTZOSUMwci9ROFVMWmRhVDRw?=
 =?utf-8?B?b0FNM3Fmd1pxekt0QjVzN3dwUXJuNGVMaktJOWJjWXc2OHErOXJlamVFUVVv?=
 =?utf-8?B?KzI5bCtsdlY2a3JPQXQ5bjJDOWFIV1hkYWhxRFFDTytzRStEQ2g5V0Jmc3F5?=
 =?utf-8?B?RDIzZEpuc2F5MEd4dC91YUFDUDB1YTM2T3VjUnpXZGJzcU1pQUxpY2pXczJW?=
 =?utf-8?B?U1hhWWpseVlqVHkrYnlTZndIUm9LR1krNDdwZWhhLzJ3cEt3bWxUMThuUWZh?=
 =?utf-8?B?dFNQUmlGTmdKRjZZMFFHU0pNcmNOK3lNbmp3Z0NNZzRxa3lEMGl1SUdCQVRW?=
 =?utf-8?B?SlVKd2ZPWDdtSGM4L0dVVERaamUxRHZFaFV2U0UxM2w0ckFFckhLeWFNelBT?=
 =?utf-8?B?aEM5QWcrTmhwck9US1N5YXlhMUROeFZaQWQrMGR3R0RlOGtvRFNMRC9CNFZu?=
 =?utf-8?Q?+vSRc8ANf6bu4dSZ2FdkkqglO4pndA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFBDcHRyamJEMExNdDRjcmkxeWx1R2czZ3B2dHA2TkUxZVJmTUNEWnlwN3A5?=
 =?utf-8?B?c2NUYys3aVQzdUdxUFpORTFxUE1oTTRYMTQxYkFLSmdhSzduMWovY0FyaWNL?=
 =?utf-8?B?STR6dWpTZDlyOUQxYkR0aHF4NVhUV093VCtkVmd5NWtwWU9jVmFtcGUwenBs?=
 =?utf-8?B?dENDNmFrZkw0MVVBUW5BSmdaN2xGNkIvdXEwd2NyMCtOcUo3eERmdnlyZ3No?=
 =?utf-8?B?SEJYUHFOa09vY09VVThSUm9hQmZWMEcwQW5BZytDNjRXU0VBNExUWHRXNlFh?=
 =?utf-8?B?U2x3MjNGcmZKOWNqZFlJU2NINjkraERINHRQaWRxNDAxMk1FZG1vbGwyNWZi?=
 =?utf-8?B?MjBOMUVvdmwycm90OUlvSDVvUzNHb0gyVUpnSm03czU1WWM5WmlRZEwvYmlB?=
 =?utf-8?B?ak1vRERPM1hqK0lBbTN4ZU9RQUxKZTIyTEFTaGd6WCswSzMxYXpxRlczbURO?=
 =?utf-8?B?Z1pKalQ3cEE4MFB2RnJNRUZ0MDdlbjJFc0pnZjFMRGtGelZyaWdnVHE1YWpL?=
 =?utf-8?B?ejJua0t1TTN0WS9hdnpCZzFmU1FTdEFKcW9NbVhRY1IvM0ZCR20rTGpwWmp5?=
 =?utf-8?B?OVVqNGNqdWNOdHJKOHlwTFJvRHcva3ZjTG82TjhUempxc1ltZk5DZ0VJWkEw?=
 =?utf-8?B?YnY4cUd3L2NKTlI0VTQvNk92M3NrSDM0QmJ2eUV0cm50N0RrS0lBRFZmc2Rk?=
 =?utf-8?B?TlBZbndsN0RmUFJmNCt1QUhoRVNrdys0anFwbWFNdkc0OSs5WGwxd09xMGFL?=
 =?utf-8?B?eHZWVHBGcWt2TCtQTExobHUzNVJYbWZFaUs5S2RrNnBjdDFtM016UHFQL1ky?=
 =?utf-8?B?ZTg5TTRtdHp1TncrLzRidTRPQUVkc2JUa0NJZU1qTDdQZnN4TmkrZWU3SFZ0?=
 =?utf-8?B?YXV6VXlMWjdnMnRRUUxFMGtKci9qeUJpaTIwVDRwS2g3ZExFQnJsWkZXdjkx?=
 =?utf-8?B?R0pCSlh2Z0QxL3M2MmVzWXhGeEZMS0dYZUNLYXVYQ1c5NXV4eEs2M0lQQmJB?=
 =?utf-8?B?bTdGV0NQRjZVL3ZNRllBMmdlWlI2Z3ZJNkdudkRGYUJsWnZ6eStzTGJseUxF?=
 =?utf-8?B?aDB1b05LeEd3QUc0TXlpa1c1Nm9vZGhDZzB3QTVXODI1bDJuSFpqdkpFN25y?=
 =?utf-8?B?YVMzQzVnTGo4WFErZDBiN0tRNHlZVDlEMDkzT1V3MnVZMGZNWE5YeDlxTE9M?=
 =?utf-8?B?TE1lRTlDRXZhQUoyclZWV21rUS9HaXcxdDVVZEJYSWhHeDRGVXNjMFJwY3Qz?=
 =?utf-8?B?eGxwK2N1T2l4WmY4ZDVOWkZrZWtrR0l0am1IWnlsY2FyOVVpbnU4Y3NyMmY0?=
 =?utf-8?B?ZGw2SjBML2lFejArUmNFQnRkVWNDY0Y3eGJQN3VEaEZLOU9xZFlJWXkrZ05o?=
 =?utf-8?B?a3ZWY3ZqNkNLTWZMN0lkeEZhSGk0SnR5cFV5SXZIWFdsOVlqLy9JVzYrTnRv?=
 =?utf-8?B?bCtKSjQ4QS9WRGx5WXdOSzZsTHBIK3ZOMmNwQ0dROTV6MGdyeDFCcGJ5a0Ja?=
 =?utf-8?B?OENsODJUV1M1R0lzRi80RFZtakYyMnAvOEYrTzdEVTZWNkZDVHplRUR4RGdN?=
 =?utf-8?B?aEpXY2IxNlp6ZkM3Q1lYWDVkTDlrMlY1Y2xFaWc5NTRNeWdBN2VmdjRWWTI4?=
 =?utf-8?B?ekVXbEo0UDErYTc1ZmN6TFh2VW1kV1hsbnRPclRud2JNbXN2NnR3Y0x2cUpv?=
 =?utf-8?B?VDdZaTIxOUQzcnY3SG1haGY5TmlJcG9OUzZsbG9lUGFHRDNvN0lCNkFBWEhV?=
 =?utf-8?B?Ymk1eHViem1IY0pRTy9uZGR2NkRjVEhQU3YxTXorRjZvMWlUajlOQXEyMHF1?=
 =?utf-8?B?ZndrYlllNHNQd25keEI2Z2pTOUNVT3Fhc2ROVlFENnMycEhTblFPeFh0aThW?=
 =?utf-8?B?NVk5ZVg2ZEErcW5SMW1MbUJOSFRzMlJYenFCekpkbzBoMXF0WjNMdWduMy9p?=
 =?utf-8?B?eFFVb09oTjVlL05hRHJoOHJadVJvUjJXWmptVXJTdWRHS2RoUnhtRUpjb1lV?=
 =?utf-8?B?OUErWGUvYnBzNkVvUUNKUG43cVpoN1BZWWRNVDJYa2x0MWd6K3RuRlJGMVRk?=
 =?utf-8?B?bG4xMi9OR1k1UDZ6bDdtTjNUaURDWEEzNW1mSGcrTjEwUkp0TGNlYWh4WStW?=
 =?utf-8?B?bEJZYm5peWRza2dLS01yTmRtdlExMHdNM2ZlQUQ1WFpRbWdqVlJjZFZwSTZ0?=
 =?utf-8?Q?z6qbk9Wfa8KMZAYR9phqKrM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564fa793-bb1f-4b32-ccb9-08de03890fae
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2025 21:00:34.1606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3+tyEyu6OYWhPD92acWutoZbeYb2p+mIUqk3+XGAkgdo7H5PrGTwkMDgmrJJakh5bcfqzMcTDS+vHxkAKnF/onezkm50ug1p+iJQYLbV5yQDZdqYyEDroj+XjaMw0O/q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6772
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFydG9zeiBHb2xhc3pl
d3NraSA8YnJnbEBiZ2Rldi5wbD4NCj4gU2VudDogU2F0dXJkYXksIE9jdG9iZXIgNCwgMjAyNSA1
OjE5IFBNDQo+IFRvOiBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgPG1pcmlhbS5yYWNoZWwua29y
ZW5ibGl0QGludGVsLmNvbT47IEJlcmcsDQo+IEpvaGFubmVzIDxqb2hhbm5lcy5iZXJnQGludGVs
LmNvbT47IEFuamFuZXl1bHUsIFBhZ2FkYWxhIFllc3UNCj4gPHBhZ2FkYWxhLnllc3UuYW5qYW5l
eXVsdUBpbnRlbC5jb20+OyBHcnVtYmFjaCwgRW1tYW51ZWwNCj4gPGVtbWFudWVsLmdydW1iYWNo
QGludGVsLmNvbT47IEJoYXNrYXIgQ2hvd2RodXJ5DQo+IDx1bml4Ymhhc2thckBnbWFpbC5jb20+
OyBCYXJ0b3N6IEdvbGFzemV3c2tpDQo+IDxiYXJ0b3N6LmdvbGFzemV3c2tpQGxpbmFyby5vcmc+
OyBQZWVyLCBJbGFuIDxpbGFuLnBlZXJAaW50ZWwuY29tPjsgR2FiYXksDQo+IERhbmllbCA8ZGFu
aWVsLmdhYmF5QGludGVsLmNvbT4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBS
ZXZlcnQgIndpZmk6IGl3bHdpZmk6IG12bTogcmVtb3ZlIHN1cHBvcnQgZm9yDQo+IFJFRFVDRV9U
WF9QT1dFUl9DTUQgdmVyIDYgYW5kIDciDQo+IA0KPiBPbiBTYXQsIE9jdCA0LCAyMDI1IGF0IDQ6
MTXigK9QTSBCYXJ0b3N6IEdvbGFzemV3c2tpIDxicmdsQGJnZGV2LnBsPiB3cm90ZToNCj4gPg0K
PiA+IEZyb206IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJhcnRvc3ouZ29sYXN6ZXdza2lAbGluYXJv
Lm9yZz4NCj4gPg0KPiA+IFRoaXMgcmV2ZXJ0cyBjb21taXQgZTNmZDA2ZDFkODg2OTc0N2UwMmEw
MjJlM2M5MDQ1YTMxODdmM2FhNSBhcyBpdA0KPiA+IGJyb2tlIHdpZmkgb24gbXkgVGhpbmtwYWQg
UDEgKEludGVsIEFYMjEwKSBpbiB2Ni4xNy4gSSBkb24ndCBoYXZlIGENCj4gPiBiZXR0ZXIgaWRl
YSB0aGFuIHJldmVydGluZyBhcyAtIGNvbnRyYXJ5IHRvIHdoYXQgdGhlIGNvbW1pdCBtZXNzYWdl
DQo+ID4gY2xhaW1zIC0gdGhpcyBjaGlwIHNlZW1zIHRvIHN0aWxsIGJlIHVzaW5nIHRoZSBjb21t
YW5kcyByZW1vdmVkIGJ5IHRoaXMNCj4gY29tbWl0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
QmFydG9zeiBHb2xhc3pld3NraSA8YmFydG9zei5nb2xhc3pld3NraUBsaW5hcm8ub3JnPg0KPiA+
IC0tLQ0KPiANCj4gQW5kIGhlcmUncyB0aGUga2VybmVsIGxvZzogaHR0cHM6Ly9wYXN0ZWJpbi5j
b20venJUUGJFMGoNCj4gDQo+IEJhcnRvc3oNCg0KSGkNCg0KSSB0aGluayB5b3UgcmV2ZXJ0ZWQg
dGhlIHdyb25nIGNvbW1pdD8NCkRpZG7igJl0IHlvdSBtZWFuDQplM2ZkMDZkMWQ4ODYgKCJ3aWZp
OiBpd2x3aWZpOiBtdm06IHJlbW92ZSBzdXBwb3J0IGZvciBSRURVQ0VfVFhfUE9XRVJfQ01EIHZl
ciA2IGFuZCA3IikNCj8NCg0KQW55d2F5LCBmb3IgZml4aW5nIHRoaXMgaXNzdWUsIGNhbiBJIGFz
ayB5b3UgdG8gdXBncmFkZSB5b3VyIEZXPyBUaGVuIHlvdSBzaG91bGQgbm90IHNlZSB0aGlzIGVy
cm9yIGFueW1vcmUuDQoNCk1pcmkNCg==

