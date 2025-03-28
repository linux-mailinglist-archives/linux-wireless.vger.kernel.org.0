Return-Path: <linux-wireless+bounces-20905-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360A3A74301
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 05:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67F03BD79D
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 04:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06A119341F;
	Fri, 28 Mar 2025 04:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EfXsf/eh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ADC8F49
	for <linux-wireless@vger.kernel.org>; Fri, 28 Mar 2025 04:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743135899; cv=fail; b=Gxv+GR+kaKwoqbnc5atQc0jHoi4JeCo7L7xwDvZAzYrDG8p50M/QMfnwHj3hrb1iEPzbqNIYe0szTaPHy2GaurrTf0yqS22q2Dz0BF1ohd0PxJkncaTHxMZ/FVkXQGJgKqlRGx5d2PafteTbafoJ51Ucg85m3V9xInOPJlrgv+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743135899; c=relaxed/simple;
	bh=St07CiY01YXQFe0Q17DevLkch8fURgV2OHlsV8cIuYg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eAjRBKwhFpYbIHq3327K6XbJw9dqJvjN5hNwHzS8FSZC+ac4dJjEgv2WzyV+rE/Q0o4mqGd7WUBITzxoQcGQrZC8aZ1X2264YdZGlpBSJawz38P/JvPvdvFUWyo4wdSuzJWhapeAn4pYmfwEod09D7xPj14OvUSqqMJ3Fd0xzD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EfXsf/eh; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743135898; x=1774671898;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=St07CiY01YXQFe0Q17DevLkch8fURgV2OHlsV8cIuYg=;
  b=EfXsf/ehCHlHViTID7ZdO6MrzFRs4FIdGIOMBZ50FhsqQLa/iFROgPfe
   W1RoPqtut5KSTc8BVAMlvbfa2adFAhQSyLqiBL4tJJ2uIIMWrbmlC8JAn
   KcfEBdRSdW94lEb2VLZLAu9Uk5LwY3wkI1QurqQvpqEHtTEKLdyoUggRV
   2fflpYAN5yG6wTPGFxioY58cjKbP+Ymmd8n6JmRezhQ0YcuOB2pfderWU
   CWdmiVDUSLSegu/oyLCWcNyDE8+gLy1Dt6whgSXneykGvGjVRnz9DRjzY
   8+6ukGLDWJkK1usdmkJaWHfvxQq16kZrsIl82ib2aVQFiXw2zhrx+Ofs3
   A==;
X-CSE-ConnectionGUID: mh0/e9X8R6+ZniP5H99fCw==
X-CSE-MsgGUID: BKxggfJHT+q706w9D12Q+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="55858434"
X-IronPort-AV: E=Sophos;i="6.14,282,1736841600"; 
   d="scan'208";a="55858434"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 21:24:58 -0700
X-CSE-ConnectionGUID: Az0ID1aYS3CoFam4rFjHpw==
X-CSE-MsgGUID: pUZ3Y1/4S5e/PxuDFDK7ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,282,1736841600"; 
   d="scan'208";a="125092194"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2025 21:24:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 21:24:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 21:24:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 21:24:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRThcAdlccCdmfFMCkLhK300MszStByuS4kJphc2BV5LOPRQArs6xxC1Epljnu1E7Jv3ga3SDJ6SoqJpC97H2ycK1PPfUrWpODoryAUgeybpnmk9YQWlBXcTPiUCotUGyLIgXdjROnOU7cz+3pf/cTJyvgXTvb/PzeN8UziNQujJCe8Hr0P5DWYqmolL6nlr/G+bj3Q80nxAdrxotthWquSdotP/FdTKkjkdZRRY6/G++Ty9joRtzi3sSEhfAEyaMekjXT1v0EzVOyrzbolpvSEf5i9kItwC/ctfgHof+sDnbhmwvd9PWWV0UgH7mO9/MPMfw9AdF0CHfM0picjWPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=St07CiY01YXQFe0Q17DevLkch8fURgV2OHlsV8cIuYg=;
 b=M0dWb1Ig4sIBX9b0Byb6Yillms0O+QmEpNrWULue27M4RELzRR9NHw3KIX+SEwGicsv22GTTklo/BSlvGFlm2Tgm4jwgE8nkFbFlzDcNT2/ouvWqjweznyVm8ZYuha6RjGXy/rkplhjt8Asj/m+rztIoOWubwykPISEUI+tAOz5FUXZgbzVLcIAWlpIJ2XQEAsxrQ4Qdrpn1fzAJZXVvICxrlIGV+gdGvTVUl4IfNndM8ivYJmmb9FllXK4MgiQiuxKlNlOHqmP2bqToFs61KxMu5ZDbjqoVrhPE5MGbA302LB9PuNjw/6Qj6PphHnsuNcItp6ofnU2bpg8+cShtBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by PH7PR11MB7594.namprd11.prod.outlook.com (2603:10b6:510:268::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Fri, 28 Mar
 2025 04:24:54 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::41f9:e955:b104:4c0b]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::41f9:e955:b104:4c0b%7]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 04:24:54 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "chris.bainbridge@gmail.com" <chris.bainbridge@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "Korenblit, Miriam Rachel"
	<miriam.rachel.korenblit@intel.com>, "Berg, Johannes"
	<johannes.berg@intel.com>, "benjamin@sipsolutions.net"
	<benjamin@sipsolutions.net>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>
Subject: Re: [REGRESSION] iwlwifi resume error, bisected
Thread-Topic: [REGRESSION] iwlwifi resume error, bisected
Thread-Index: AQHbASid0CU63h7wCU2RsueU4ZEG+rJMpxoAgAAufYCAA+5CgIAAEYCAgTXmVgCAABwWAIAAhkMAgAAyHoCAARv7gIAAEiMAgAByH4A=
Date: Fri, 28 Mar 2025 04:24:54 +0000
Message-ID: <d3f5b6aea39528ab7647e69f66fa90b26623a543.camel@intel.com>
References: <CAP-bSRbMbZe9LCE15SCbYNTGZjE_xiAm29qzO_WNVjHsJ6oyyg@mail.gmail.com>
	 <9ada34661b93fa5dfe3b0c66816a62c1a27f22a3.camel@intel.com>
	 <CAP-bSRZm4CyxY1VdtWvZRcfLMwc3njd3OTSd446Q5dcSfjJY=Q@mail.gmail.com>
	 <CAP-bSRbon4O=DCLHvOZHm452Svc3-gsZ133Jn7-TFt8f_Y1CFA@mail.gmail.com>
	 <36b0f88ff0f17e0246037d5f834ac545afa69cf0.camel@intel.com>
	 <CAP-bSRb_f1A=_+A9x8J75socYsKFKDtysZ-m0+6Ks7NdSjQ0-Q@mail.gmail.com>
	 <b2674ab2706c2ed81734f2c3d6261511414186bc.camel@intel.com>
	 <Z-SdYIm_lDvmCcO-@debian.local>
	 <2a8fe208aaae404a724dcd9844afc2182c1ebf45.camel@intel.com>
	 <43c0e4554151e015c068b79b5da7231f8674a474.camel@intel.com>
	 <CAP-bSRb+qO-FhtjrGThCy2OoXU-jb3rkzzyUUkk4vP_P-u53Cg@mail.gmail.com>
In-Reply-To: <CAP-bSRb+qO-FhtjrGThCy2OoXU-jb3rkzzyUUkk4vP_P-u53Cg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB5825:EE_|PH7PR11MB7594:EE_
x-ms-office365-filtering-correlation-id: 45b70c30-377f-4b96-3862-08dd6db07d90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WllKdk11a2YyeENGMk5SaEMybGJ3TXlNZ1pXNktJRWU0VC8rcXIxNXBvQ0pO?=
 =?utf-8?B?UkdkUEFvRnpGS0g2YW9adjVaR2dCekR0RTNScTM4cFRDTnBQbjZHLzFvREdR?=
 =?utf-8?B?OWxybzNRMENQOGpGbmVvWkpvWkQ2S3B2QVJJTCtkTkNTanVkaXZOaFBCYjk1?=
 =?utf-8?B?aENjeWlGS3JONGN5TTcrcmM0bnNPTzlzb2E4TjF4RXJUcjAxRGc5cSt4bHdF?=
 =?utf-8?B?aTN3b0g2QjM1N0t6MitYZU1NSVNBMUwwYkNkS29RWDJPemdMbDNuMlB1SHF2?=
 =?utf-8?B?aGsyd1JEWlFDMld1UGxvSUZ4MDJQdk85TmMvNW5hRmVKVGpGRHZkOFdYcFdl?=
 =?utf-8?B?OHhjVFFEOEpiNmNUYVQzdHpwN2dNMHhqZHVOQzNZSDcvREhyUkpldDBqT290?=
 =?utf-8?B?WEJPRkFPRDN2VlNRc25uQlJlcndUTlp3ZmJMTTc3cVNVZ1U0dFY1bVp6d1JN?=
 =?utf-8?B?RVROdnZBREJSUzJ5M3lWTGtOc3FFbDhsWnMvM3FrREo0RXdFOVRyZnVmTnk0?=
 =?utf-8?B?VmViRTBWK1NIS1dESkt0c3cyYys0bTZPdVVqVWhma2NNOXNqU3VSaE1HRXAy?=
 =?utf-8?B?TFpVTFRyNDZKRXR4UFAwV01LRUVpd3o3WVhtekxYd3VYQjVkMVFUaW14WXpD?=
 =?utf-8?B?RWdzWTFZY3pCUUJBdHpDWnZIbDdpZHJIWm52MjRHM1BWK21jdzFsZTk3MWlG?=
 =?utf-8?B?RTZkcXBmeFVsQWo4T1RtT1RodVFQaEJ3WEhjWHVFdXlaSHJVamxob2FFR1FB?=
 =?utf-8?B?bjNsVU84b2dYUXBtZWRrTzdNS1UvNmFaVFgydWNkRDU0Sm5DVktST0pVamlk?=
 =?utf-8?B?UldXWG9Ld0dad3V6MWZ1eHljUXhUZ2pyQ3oweXU1OHlBY3VjVU5zZGZMVklN?=
 =?utf-8?B?RGRtT2kxZUROa0N0T29TcktXRExQZzFHT25WSUJUbTBDWWNEcGVQdkdnQzU4?=
 =?utf-8?B?WEJXSnJndzVCdC9xSkliS0lmL25PR2JRK2tJbjZLT3M1eDFmT3A5K3FkSmln?=
 =?utf-8?B?ZWY3WUlrU1JmeHYyNmV4cW9ZMGZtSnU0NWRXa2dLbnRKekQ1dXdkK05HNi9Z?=
 =?utf-8?B?aG1wc1Q3b1F6c0dyWFcwbnhRdU5GeXpsZnZkcENsbWsvL1A1aGM2UnFOajVp?=
 =?utf-8?B?TTltQTRLREhsUVN3bFBqamU5a3JiZnk0TFJmbll5dGZ6MllTaDNTQVVKYVhR?=
 =?utf-8?B?QkV1SjRrRmpYNWljdHBTTHdqUUE4WGxKOTRFQ3hESEh1S3VvWnM3TWNGZm9T?=
 =?utf-8?B?aDd0b0N0MlVBVWJnMjQ1czBYRU8vR29XZ0VSbm1ZTGx5SnVkOGpXdExBVzJo?=
 =?utf-8?B?cVRmNmZWZHNzRGErRXQ4VDNicjJqdUFHUktoZTBNTEpmaVl2UHVSUldkQnlv?=
 =?utf-8?B?SGJSZ1ZISmhjVXZqRXAvT2ZCRjVBU0RNT0xRVWllbnBLVVpoQ21pV2JBSm5Y?=
 =?utf-8?B?M0ZFWlJnT29ZWTk5aE45UC81ZTRSTmlNKytCZ3pMY3U2N0RoQUNXcXVrbnhU?=
 =?utf-8?B?dHNJdnBaVHAvVmMyYXhPS2RxWG9RM3hHUTUvcjFyTEo1Q1RlOUhJR1lSV1VX?=
 =?utf-8?B?L1RKRnA3WThyUG41RzhCSVpWdXJySTRVYnBBUC9xMlAyUjh3ckRKbmo2Mzh0?=
 =?utf-8?B?SjhWTktQYTU5bGJlanluNlNJNUcwYW82Yisxb2J5RFBHak4wM2lJSll0MnBj?=
 =?utf-8?B?SHIyN2ErVm5INXJ6WU1PNEl2NG9JV3FVK01PTnhJS2pCUndOSTFMQmI4c0VQ?=
 =?utf-8?B?S1BmS0VuMUJJMUhkTW9lZHVaUlBGY1ZwRmY1MThRVEtGaUZ0RWQzSzNlUTVX?=
 =?utf-8?B?NGtwQlF1a3oxaGlDcWRvY1hqYUtPbjNKb3MxcDNTOFlLY3pRckFlUDZvN3Qv?=
 =?utf-8?B?MlpPSWhGU0VjWlpGM3FBT2pkNktLQmlmK3Jrdy9MdWlxNHdmZDdHMkdGSUVj?=
 =?utf-8?Q?4J/S328+YuaMB7mgkibBOXGW8eKFsmQs?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmtjYUVvb0djNWoyOEx3RDI5STltdm5PcWdqeFJGaEFHbU9hNCtwTklPSzA1?=
 =?utf-8?B?MmlBcGd5WnNMekUrMTdmYlUwZDhicFhQV0pqdXd4QnM4WFJpZGVFVzlRbXhZ?=
 =?utf-8?B?QklMdWxlM0VEYnhnL2NRbGlhZGxsR2ZXbnZRR3NSTVFSbmlDaExyL2NQckZQ?=
 =?utf-8?B?TUo5aU5UaWc5dXBZdWRKcEx4c3htemtzeW9aVFZRQU5vRWNHSXR5MUFONWV1?=
 =?utf-8?B?d3lBZFFidkZvdkJRdWxxMWZNWXc2VS84eFdmR2J1cFByUnh1Z00rbUMxcjh1?=
 =?utf-8?B?WmRUZnlOeEJRYUhjQXlFU05HVEpDSlA4SEFLM21JV0huaThndFBDWlQ1S3hr?=
 =?utf-8?B?Q2NiWkNHZVc1eHZscVltWGxTbEhLRU01UkpKRTBWM0ZOeUVnOVNJS2xIaFNu?=
 =?utf-8?B?Tzlhb204QktLRDZteHYzSFZ6TVZhQUd5dVY1WnVkTFUvNkF1c21GamxKcG9D?=
 =?utf-8?B?SE9YcCtBNVJJY0JLSHMzYjdIZVkwaENjK214QzYwcW12dTNrbnZyVnFXSmRX?=
 =?utf-8?B?UEpEMVphSU4xdU5HQVZHVm9IVnFaUUFrUXBuNW91SW56dzR3U05DK0hLMDVz?=
 =?utf-8?B?b3R5NU5iRXU1b1VncFExYzZTNzlXUm1jRE04S0RNcEhQQ2FKNDJiQ2VGbGZR?=
 =?utf-8?B?MVJiTlVWVERRbTUyMXFjSmNNZ09GTzFxa3BZV01Hek9XZk1oUGNaY3FPVjFB?=
 =?utf-8?B?UHhQT1h2VlZIaXZjaktjNERtSFRZUmwvR0xvdkNJcmNzemFDTGNOWDJKRmNx?=
 =?utf-8?B?a01LbFFycERIaHRCdXVkR2xULy9IdUhLaVo2S0szelc5NXJEOVV5RFdMc0I5?=
 =?utf-8?B?MVkwaVVXTGNPVnZCZkorU2VrNGMzK1FNb0xhb0p5UkNUMHlObGNrY3c2d3Nl?=
 =?utf-8?B?emNCWHo2d0xSU1BkbWc0T1FFbFNkZlorN21JZFhVYWZSRXJyNWloZE5HRFpu?=
 =?utf-8?B?YmJlYUZTWmdnYVIveE1XVVJiTVQyREhBQ3NDZk1xdDZzeTlGZVhmdmphT3Y2?=
 =?utf-8?B?VWJWYUhTb0pMZGxTemR2eXdKbFIxVnBIbTlGWTAvQUVnOHJub3BWQUFLT1dO?=
 =?utf-8?B?enJ1VVNkTXZyL1dzZjh5ZTl5bVdNbHJMQVZXMCtJVVNqQ0ZyL0ZWN3U2WGE4?=
 =?utf-8?B?b0tjYktsV1dDd3hSbVVzbmdLTDlqcnJ3TDlpOXZvcVVlMm1ocjIxNWVSdVRS?=
 =?utf-8?B?UUpXRmh4R2VBanlXNi9uTUdPS1c2dytwaHc2SXkvZGlVc29nS0dHVXNVWGNj?=
 =?utf-8?B?MTlVbWRmZ0xJdWllQTFwanh4VDlNSDZENndiN2lwc0YxbzVnM2Y4TFB0YW1a?=
 =?utf-8?B?cTZHTlpMUzc3Njhjc1cvT1ZmdGZrVFMvUEpjdlY0R3ZqOVlkWFMwbE5mQU1q?=
 =?utf-8?B?TCthY0lQdzFNclRFclZWQjJqcUlYK2VGSU1RbVlud0tHM3Iyb3V4dzJDMEho?=
 =?utf-8?B?T2xuWmRhaHRzcDhzbXlHOGp3UFdta1BzcHRQTEhJczFsa0RBMjlFQU9VLzRh?=
 =?utf-8?B?b3hUbmM2dURGclo0SWRadUxRQWxkYnAyamZIMERMTHVjMzZHMDBsQVFvYlNZ?=
 =?utf-8?B?ZDVoYVZHRDZzcnExOGVSK0hWakdEWTYwTVdLWStKMWY3ZHBZZUp3ajJFT04r?=
 =?utf-8?B?eWdhTEcwb1lZTlRmR1BMdm5GZmcrTnNqZUxrRVd4VTh2eENtbzdaZk1GWEdl?=
 =?utf-8?B?aVAwaXFqcmVSazZ5N2FrcFVwOU5Mbk56bXJFdEZjNDVyNmtaWUNiL0diU2Rz?=
 =?utf-8?B?ZkF1NWhFK2hqSFhBRkdWL0R0SjNIVTVhZG5tNWpVNHpzOXd6VmJjcktISUkz?=
 =?utf-8?B?dU52cnFoWnBiQlFZUEZFWDJCdmp4Y0dvdGM0NVYzOWgvMTEweHVjcER6TVhB?=
 =?utf-8?B?R2IwU2Q4ek5kVlQ1ZFlweEJ3US9UeFVRdDd1bzd6OGE4N2NhL2xYVDMrdE9y?=
 =?utf-8?B?QlRqaU5hN3piQWNYNisxR2FwVjRUbGZ1OXhLTERkam1pb01pRDdXa3dTakZh?=
 =?utf-8?B?cU9NdlJROENiQnlsZzd5ZFFjUS9hcGM1ZDByZHFwMThaVkR1dEFENWYzWXlZ?=
 =?utf-8?B?QUp2YTBMbmE4SjJ5ckxhVEJ1QmllS0Fob04vZ085M01xUmhCanEvaE5DVFIy?=
 =?utf-8?B?c0ZRQ3hONXZJd3NjS0ZtMXlqYUVUYjBXRXNwU2FBZTliSExPMGhCU0RuN055?=
 =?utf-8?Q?a1SRbGx4nnoWWch7tKawBXk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78DDC287070B8342A504E444183EC7D4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b70c30-377f-4b96-3862-08dd6db07d90
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 04:24:54.4392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +eroShoxHqiDVpNojpvQ0SiUTOQAPjj6/SYIZa1lHnzwgy3Y6yG9uwposdLTpx8M+CVqFO63wEAaMG3VK7yxhUtrqmgyRVOrkLP5KzwUClg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7594
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTAzLTI3IGF0IDIxOjM2ICswMDAwLCBDaHJpcyBCYWluYnJpZGdlIHdyb3Rl
Og0KPiBIaSwNCj4gDQo+IE9uIFRodSwgMjcgTWFyIDIwMjUgYXQgMjA6MzEsIEdydW1iYWNoLCBF
bW1hbnVlbA0KPiA8ZW1tYW51ZWwuZ3J1bWJhY2hAaW50ZWwuY29tPiB3cm90ZToNCj4gPiBBbmQg
aGVyZSBpcyBhIG5ldyB2ZXJzaW9uIG9mIHRoZSBwYXRjaC4NCj4gDQo+IFRoZSBwYXRjaCBkaWRu
J3QgYXBwbHkgY2xlYW5seSB0byB2Ni4xNCBvciBtYWlubGluZSBtYXN0ZXINCj4gKHByZXN1bWFi
bHkNCj4gaXQgd2FzIG1hZGUgZnJvbSBzb21lIG90aGVyIHJlcG8/KSwgYnV0IGFzIGl0IHdhcyBz
bWFsbCBJIG1hbnVhbGx5DQo+IG1lcmdlZCB0aGUgY2hhbmdlcy4gQXNzdW1pbmcgSSBkaWQgaXQg
YWxsIGNvcnJlY3RseSwgdGhlbiBpdCBsb29rcw0KPiBnb29kIHRvIG1lLiBJIHN1c3BlbmRlZCBz
ZXZlcmFsIHRpbWVzLCBvbiByZXN1bWUgdGhlcmUgd2FzIG5vIGVycm9yDQo+IGFuZCB3aWZpIHdh
cyBzdGlsbCBmdW5jdGlvbmFsLg0KDQpUaGFua3MgZm9yIHRlc3RpbmcuDQpJbmRlZWQgSSBjcmVh
dGVkIHRoaXMgcGF0Y2ggYmFzZWQgb24gb3VyIGludGVybmFsIHRoYXQgaGFzIGFuIGlmZGVmIGlu
DQpkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL3BjaWUvaW50ZXJuYWwuaCB0aGF0
IGRvZXNuJ3QgZXhpc3QNCnVwc3RyZWFtLiBTb3JyeSBhYm91dCB0aGF0Lg0KDQpJbiBhbnkgY2Fz
ZSwgdGhlIHBhdGNoIHdpbGwgYmUgcmV2aWV3ZWQgaW50ZXJuYWxseSBhbmQgZm9sbG93IGl0cyB3
YXkNCnVwc3RyZWFtIGZvbGxvd2luZyB0aGUgcmVndWxhciBwcm9jZXNzLg0K

