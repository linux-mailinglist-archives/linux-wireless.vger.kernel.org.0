Return-Path: <linux-wireless+bounces-39081-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5feaMetaVmqg3wAAu9opvQ
	(envelope-from <linux-wireless+bounces-39081-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 17:51:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E48756A02
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 17:51:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=HrqtAYYG;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39081-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39081-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 899C4303AA92
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 15:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9646446856;
	Tue, 14 Jul 2026 15:49:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6068E346ACE;
	Tue, 14 Jul 2026 15:49:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044157; cv=fail; b=NfqnLncaFmcbCwztdAz0YfwitlUykRK2gtURvtbqPjgqFGJ6AbZeDSC6hcxwDSxOOy92r3qFRgtrK+G71pXKQNfnQ+SYzVMfmodyo7Ru6YZbU8IpsmEBup7z0drK7yZi+9jpjTxSJKkq0xT0M5/mY3hsbPD8RJo3SNMgZ+opDVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044157; c=relaxed/simple;
	bh=G8QmWIOUyuNwTuAmOi174AiaP3EOldaCRXV0HGYIhKo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VMmPhbtGs0kv8oGLE5mIFq1tqT/RMgyNO7JyVkEKuI20UI/bBjimnDoipg4/WqMN4wiwWY/uqY2IXasLt8AYBnoADOIcPFbyRlN8gd9uRpqaLSIdgIcmCWtKu0XIfJDFTh7ogCzQQ5V100enXcsX4I/qNxAoX8vj+oT+9tDOJoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrqtAYYG; arc=fail smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784044156; x=1815580156;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G8QmWIOUyuNwTuAmOi174AiaP3EOldaCRXV0HGYIhKo=;
  b=HrqtAYYG1S8grynQI9bcwq4zfSNep0w0MyzphT8VCykB1R0G++VSdeFx
   1rbSfIW9ohVisW3zUP3kWpa45lhaMnpU3MVh680iUSyyF+735uTz+oiGI
   tI05BW4jdBGLRPqwa0KXob9HNUclTnFe4srMYT5BBIVtkwZH02UOyXxku
   fJeUUntm/r97JnRueL9xSzZVMO5z43/aZIQzqEqbFSdmKVCHs6OdcYbmz
   /5upYyqasGkte7QbYRgFex8FhuOxVuTRaR6IMG6V2cyBLY6cY7cAol2wP
   TbGuIAFUpgnxD9b6Gbq/HBNBvTcGJVhVF5GmYpOv7qEV4ShsARcj9hf2P
   g==;
X-CSE-ConnectionGUID: DYFT8EkZRU2tN9lEwTRYIA==
X-CSE-MsgGUID: +VqvnED1RjeLsZ1lHDcGzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="88569733"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="88569733"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 08:49:15 -0700
X-CSE-ConnectionGUID: hB/fNogtTrqAj+jh9qPUTQ==
X-CSE-MsgGUID: Wy6K0mQRTUu1oAmJBPITIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="249535764"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 08:49:14 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 08:49:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 08:49:14 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.68) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 08:49:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPzL0OZ9pyTYw9Cou8dCrTkR4h6ivuMa0UFFa0vnLcj9PLjD0AlNgNi1vbTDm1cHGFeiaUACyvLCwOPtVry6uqe98R2XlyFHuSS0WhuBgwA+lSm2mC5+plO2oijpWVErZTXiy3I2rExxT80kpjDfA8aVAZF5lUs+Ck9jTe0WwzD4IZU+YrmIELY97Fl6QAyQviaUvBzFIoWe7zDMcaighbS3rXfffXk1e/8KOFbKdJRlmDBVAyYHBgVk8ovMMLG1uoc/YBEXisXcI4sI4aaqvwrdevytoPB9hnmQLzzEcC44uwwpnB5BYOvC/Fexr/Ac7WgPP4g5TID2xIX4uxm5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8QmWIOUyuNwTuAmOi174AiaP3EOldaCRXV0HGYIhKo=;
 b=jnTTdZ83Yovdp/I2KkBjXZbs0r1WPX+9/NAHZyuKxVHR7al9Lw25c42wLgP6Ka3JSD0W7KLvgylTqn/xvqvLH3V9lj/rqAnStCXA7OuJu7poKv4zNzCVS8Nm69wQMbagFdYPkhBfrm8Pzt03jRMYWAWLcdCb7MAhwqP28clq+gqhhuRHRhXEOmI0rNDpLM4n61xeFOReEe7jVvuYquPW6+PV9mZPAuTy8Dcf05t9nUjX48gUusIF2n9MKnq8KkKXmIavJiEv7YsDAVlcsqxGFRs/xtm696k7GGuSqWtJ1orsojygbxCp5c0X1KBsCVI9Q0Cl3Y8UCGN5AWAdvSpwcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) by
 LV3PR11MB8532.namprd11.prod.outlook.com (2603:10b6:408:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 15:49:11 +0000
Received: from DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2]) by DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2%2]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 15:49:11 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
CC: "Berg, Johannes" <johannes.berg@intel.com>, "Grumbach, Emmanuel"
	<emmanuel.grumbach@intel.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 2/4] wifi: iwlwifi: mvm: clamp set_freqs iteration to
 n_nd_channels
Thread-Topic: [PATCH 2/4] wifi: iwlwifi: mvm: clamp set_freqs iteration to
 n_nd_channels
Thread-Index: AQHc5GQirC/mD7s9Z06RJETDi5Tda7ZthGkw
Date: Tue, 14 Jul 2026 15:49:11 +0000
Message-ID: <DS0PR11MB78806177FC37F31D0887DB96A3F92@DS0PR11MB7880.namprd11.prod.outlook.com>
References: <20260515121100.649334-1-michael.bommarito@gmail.com>
 <20260515121100.649334-3-michael.bommarito@gmail.com>
In-Reply-To: <20260515121100.649334-3-michael.bommarito@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7880:EE_|LV3PR11MB8532:EE_
x-ms-office365-filtering-correlation-id: 0653ccd6-3b67-4e55-36f5-08dee1bf72ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|56012099006|11063799006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: NmtCgN5GdsdKbO+WAW+hpjrv/StWSbPQSac6Y752G3NUdXFoXvpCovlVO9SH3uQYDOtiu2Id4y/LHdLUu30Gt3YYbE2+KigGmvUo0J1DxUIQEgxxUuqNfbjKEKEUubNRt7ptSh006xDBFFHDlLeKixT2XihcxvK218L2/LdPdjrkKXeHxR4BqgYijhQlprn9oG1toh94Uz9LtFakxsXL/C/aBEJEvkxKww0+Xlxcp16M6DgloR0g8M/bpUkHb2xqMvjRMLw4bMHu/RQ7bxdFpvsAD8goqm0mIbaC3Lkiz4bqyjHB0gikzGT30UBZUpzO8gr0mYPrEqFaVPW07bmmFMhijBPzBt0ad91hkLqeH3QYXu2nxL2xKmuXXVCcnutf3vOBPXiGWzvSby/H8D2ksUgznGzxhFMDcAVorSVSQeerEjv6fUNUcXih7o65gS4ojnQwMbeNbMK9deJBUNDFqRZOsA/DGXjzDcqtrXEyvmpj0TMGwUL65jZGg5M4npTg4LbTLXR7qcgujS3tMZqwk1l3geVE2vyPduvGVyYygCvM2Ttz/VUqESNAt0asz470VxAaQdZn5bUHD9VaMKw65Z5HWmEgixHeh+cB0QdTnrHPDws4HgtXfAeBRXaH8PDt010vjWFdhWNj50hS881eJ2FTr/p0iEHBHsId6zNcr7pHXlnRQ0+uvaoZbrRmUTruRwKbJO1h9VXDMNsdLMCxya0iJm7DN5nSw05KDNEAfrI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGpxTGNqVjBDVnZhV3JMTVU5bHVSd0kvdXF5c2E4QklCRkk0VzZtWTVEV0tj?=
 =?utf-8?B?Yk5PckFQdFRDdzg0L0J0bHVlZHpxSFFxeEh4NCtNdlNhdWxYY25Kb3pseks1?=
 =?utf-8?B?ekVnNG9UalRvZGxuL0swMzRLV0NNNWRMNGJsb3YrbHFHMUtTSUhFTG9iNUFt?=
 =?utf-8?B?cDMvNWxSTVNETlBnRi83WVg3VStSd0luRm5YcS84aStPalhtN1dQSXZ0TERP?=
 =?utf-8?B?RHAxT1ZRSitvZVpmYzZzTDhmRlBiV3RSZ0FjUkRXYTYwQzRvTnNSRDlGc3pZ?=
 =?utf-8?B?emFrQUVlL2hwMUNZeDhBK1J6NkgvWWhCS0ppYVp1dUE5OUI5RUZrTWNjdzJs?=
 =?utf-8?B?S21qOGdMS0hnb2VKVWl4OXRhbFVNaG9wWE5DZ3pHcjV2THorR0R1UkN4L0ht?=
 =?utf-8?B?NHB5NHVPcW5ITVdqbUVwUUZiQ2ZhOHlwc00rRjVSbHU4Ry9iNjJwdDVrQngz?=
 =?utf-8?B?Zmc0ZGxIYTFmckw1RlhCdDl6TjRYNm90Tm5wOUVhS0lvcFFZWnUwRnkyM0hY?=
 =?utf-8?B?L2praS9vUGM5Uzk1d3lPQ282cjUxSE8wQ3FaS2ZIWFdLQWxHcTdqdGNJSjZ3?=
 =?utf-8?B?M21VNnRVOWNVVjMwdHd4TnhhUlNlMWpjOVpIdlAzWWlCVTRHajZZc0RUeE1L?=
 =?utf-8?B?a2tIenJPN1lDcHJSbXlGaTgzV0ttTExKY3hpNHQ1dHB3SFZQYUdSa2RuQ3lQ?=
 =?utf-8?B?MnBuWW93QVJkdmE5SzVLNXZGU0ZFYWRDaUlEWktNSW5VbjNxVHVPUUJSWVhY?=
 =?utf-8?B?UFhqOGh4bDZPWjhuWmVRZEFOajlEbzNBUUt1ZUhqb0lrYTNVT29MNHQydmdE?=
 =?utf-8?B?dFkzTEIxTm9IV1VlcHNLT2JFYzF6b29ERmc4b1BhUkhQYjEzOEt1VkwyY0gr?=
 =?utf-8?B?V1k4U01nalBTUk0vSld1UXZXV1Rhc1UwRTk1V2M0R3lJc29aYmVnRUpoakE3?=
 =?utf-8?B?WVZpcWZUVGNUcHRaQkEwU3VoUkw1OXlpT2tUMmxMamtBdjhYR3RTZlFTa3l1?=
 =?utf-8?B?RWFObU4vaTBvVW4ySEtUdmlYL29MVXpWUnBDZU9IV0d0YllPY2FqRjZsZDBz?=
 =?utf-8?B?emZOSi9yRm8zZUw2ZUx2NzR0N0xuQTdnNTdCRUJFSGxtaHlqOStTRWEvUUtP?=
 =?utf-8?B?a2g5S0R0bnFSRlZteVlQd3VBV2UwanpXenlxdEZEMng5YWF1amVOdEp4QXZ0?=
 =?utf-8?B?cExTK0xjMFBkTDZidUYzSHlNZWJMOHNQRGVVZ0czdVhPZU5wdkVueTlYckg5?=
 =?utf-8?B?VWs4TU94QnorR3BGanp3QnJGTmdFaGRFRkFRTkRlZk9reWxGb2FTakRPU3Ji?=
 =?utf-8?B?STF5dDFGWm5wa0ZaYVJITVhQSkVEcG5lTzNHdGhLK2VLTEljMDh0dGk2UkNq?=
 =?utf-8?B?S1cweFlHWFF5WUVMbU9Va2NtMVdzWXdSeGFtT1RVdHJlRU5yS3NIbW5xd0Y1?=
 =?utf-8?B?WDNHL0JwNVA0SXdPdVFhZmV6TmlwWnhQcXJpb25zVGkzdW90Z2VxenRtV29p?=
 =?utf-8?B?VitjY09FNWdaUnZJR2ovZ1lKRlRFQXZvYUZjbmQ1OGdTWGpGaGsyVldwejRz?=
 =?utf-8?B?RmNhbWNxeGk2NTRRSk9KNVZiRFhwM3A1L1F1U29DTmVFNXY2SXJIY3ozL0Vl?=
 =?utf-8?B?OFk0MDVBNEF5Q1B5NDdXT0Vta0FFSFhGWEtHclRGWTJKNXF4cnFXNUdtV0Zy?=
 =?utf-8?B?ZzkrYXlCMkNKTzdQWHRZOTIyeEgzMWpCdjFVZE1RUS9jNXZKYmZsZ0djRmlx?=
 =?utf-8?B?NXFvcktNWXpUM0dMZVlzRlY5UmVuYU5MOHludFpUUE1wa1RkN25neS9ZaitV?=
 =?utf-8?B?dWE2V0ZzdDFVOHFqcGpSN2QxOGdDY1hOdzBIeThSTlY1ME5abWlIRXBSL1JZ?=
 =?utf-8?B?b24rSk9UYzZnUitKcnRVTGlHUjREYzM5NjJEUk9GWml1WEVTUHZIYy8xU3FB?=
 =?utf-8?B?dDZwNmJqblFObEJWSGtHV2o0SDA1d0R6c25CckxuTng4andCNUNYdHRqQzlo?=
 =?utf-8?B?U0sxMzBGZXlNN2VvcDQyVnN1Z0ZJdzhQUm93MXp4djBJTEtNVFdmN3kvSWZM?=
 =?utf-8?B?YlYxa0E4aGpwaVR6K1J1b1FKc3J4Z1ZacXlLTkJNQVdXdzIyUDZiZzdBRStM?=
 =?utf-8?B?S2pWNnYrZ0hNSCs1Sk8zdDhUT0RnL2ZIeXJ2V2RwL3kyQ3Z4cmRKQ056RHVp?=
 =?utf-8?B?ZTJWWHd2YzdDTzVEU2dRNnd4eGdlUEpweHFiTmIyYWY1WVZIN1NEZVovYUl2?=
 =?utf-8?B?dXJiU1U1UGxBTmlWVVJvZkV2TVNJdTJkRjZyazZSYml2VDF3bjJiTE41R2wr?=
 =?utf-8?B?YVdyMjBjLzZlQ2tyNGlvQXFHVEZNSWQ1QkVUbmlybmpnditBdzZpMmtMRWIz?=
 =?utf-8?Q?bohDjSZZl7mO7wco=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DBA6LOySStWpn2L+gJQIr8UZzwZMVmi+tAr+Iqe3t0CxJ/tSzLkvCiWpv1amoXBRxB0jpNf0MZymaiUk71nIy811s9Y4A+YVXc6r4bH7JEKnnDEs9oy+ZGOuzRbnFsQQrJxqNKUyUxReN5jjHQnQI5cbOOgEoxZ3vopQv0B+zISDYD0kwxhh9lg01eYCrS2J5F4I4vm6YOk27FFYa+CuoCKKGsug5pIIgYfBRbbwUEq6Tm7bAP3ylV3Q8deVSVxdIScD5OarBG039MZC+UZm7YGeiQjhsq9pcuIGC76WHZ08zmD6my4M70ZNJNs5AUFnnQ1wGhEB4cGWox3DrwaiJA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0653ccd6-3b67-4e55-36f5-08dee1bf72ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 15:49:11.5734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B/7pQIpBZgicwFLZZHKsGY+W9GzGaqk3H9/jreO+sHgQkdTyRwb+hNL2KAXUjJBeSoUsQ6F+nD6ucF49BDkj45J13uCRMkOyySL2JKLYKonNHZHQ1wovGb9rqqSxyR6M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8532
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.06 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:johannes.berg@intel.com,m:emmanuel.grumbach@intel.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:email,intel.com:dkim,DS0PR11MB7880.namprd11.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-39081-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21E48756A02

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBCb21tYXJp
dG8gPG1pY2hhZWwuYm9tbWFyaXRvQGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXkgMTUs
IDIwMjYgMzoxMSBQTQ0KPiBUbzogS29yZW5ibGl0LCBNaXJpYW0gUmFjaGVsIDxtaXJpYW0ucmFj
aGVsLmtvcmVuYmxpdEBpbnRlbC5jb20+DQo+IENjOiBCZXJnLCBKb2hhbm5lcyA8am9oYW5uZXMu
YmVyZ0BpbnRlbC5jb20+OyBHcnVtYmFjaCwgRW1tYW51ZWwNCj4gPGVtbWFudWVsLmdydW1iYWNo
QGludGVsLmNvbT47IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
W1BBVENIIDIvNF0gd2lmaTogaXdsd2lmaTogbXZtOiBjbGFtcCBzZXRfZnJlcXMgaXRlcmF0aW9u
IHRvDQo+IG5fbmRfY2hhbm5lbHMNCj4gDQo+IGl3bF9tdm1fcXVlcnlfc2V0X2ZyZXFzKCkgaXRl
cmF0ZXMgb3ZlciBiaXQgcG9zaXRpb25zDQo+IDAgLi4gU0NBTl9PRkZMT0FEX01BVENISU5HX0NI
QU5ORUxTX0xFTiAqIDggLSAxICg9IDAuLjU1IG9uIHRoZSB2MiBwYXRoLA0KPiAwLi4zOSBvbiB0
aGUgdjEgcGF0aCkgYW5kLCBmb3IgZWFjaCBzZXQgYml0LCBwZXJmb3JtczoNCj4gDQo+IAltYXRj
aC0+Y2hhbm5lbHNbbl9jaGFubmVscysrXSA9DQo+IAkJbXZtLT5uZF9jaGFubmVsc1tpXS0+Y2Vu
dGVyX2ZyZXE7DQo+IA0KPiB3aXRob3V0IGNvbnN0cmFpbmluZyBpIGFnYWluc3QgbXZtLT5uX25k
X2NoYW5uZWxzLiBUaGUgcG9pbnRlciB0YWJsZSBtdm0tDQo+ID5uZF9jaGFubmVscyBpcyBrbWVt
ZHVwKCllZCBhdCBzdXNwZW5kIHRpbWUgd2l0aCBleGFjdGx5IG12bS0NCj4gPm5fbmRfY2hhbm5l
bHMgZW50cmllcyAod2hhdGV2ZXIgdGhlIHVzZXJzcGFjZSBOTDgwMjExX0NNRF9TRVRfV09XTEFO
DQo+IHJlcXVlc3Qgc3VwcGxpZWQgYXMgbmRfY29uZmlnLT5uX2NoYW5uZWxzOyB0eXBpY2FsIHJl
YWwtd29ybGQgdmFsdWVzIGFyZSA1Li41MCkuDQo+IElmIHRoZSBmaXJtd2FyZSByZXNwb25zZSBj
b250YWlucyBhbnkgbWF0Y2hpbmdfY2hhbm5lbHNbXSBiaXQgc2V0IGF0IGEgcG9zaXRpb24NCj4g
Pj0gbXZtLT5uX25kX2NoYW5uZWxzLCB0aGUgaW5kZXhlZCBsb2FkIHJlYWRzIGEgdTgqIHNsb3Qg
cGFzdCB0aGUgZW5kIG9mIHRoZQ0KPiBwb2ludGVyLXRhYmxlIGFsbG9jYXRpb24sIHRoZW4gdGhl
IGltbWVkaWF0ZSAtPmNlbnRlcl9mcmVxIGRlcmVmZXJlbmNlcyB0aGF0IHdpbGQNCj4gcG9pbnRl
ci4NCj4gDQo+IFRoZSBwcmUtZXhpc3RpbmcgY2FsbGVyIGd1YXJkDQo+IA0KPiAJaWYgKG12bS0+
bl9uZF9jaGFubmVscyA8IG5fY2hhbm5lbHMpDQo+IAkJY29udGludWU7DQo+IA0KPiBjb21wYXJl
cyB0aGUgYml0bWFwJ3MgcG9wY291bnQgdG8gdGhlIHRhYmxlIGxlbmd0aCwgbm90IHRoZSBiaXQg
cG9zaXRpb25zIHRvIHRoZQ0KPiB0YWJsZSBsZW5ndGguIEEgYml0bWFwIHdpdGggdGhyZWUgc2V0
IGJpdHMgYXQgcG9zaXRpb25zIHs1MCwgNTEsIDUyfSBoYXMgcG9wY291bnQgMw0KPiBhbmQgcGFz
c2VzIHRoZSBndWFyZCB1bmNvbmRpdGlvbmFsbHksIHRoZW4gd2Fsa3MgNTArIGVudHJpZXMgb2Zm
IHRoZSBlbmQgb2YNCj4gbXZtLT5uZF9jaGFubmVscy4NCj4gDQo+IFJlcHJvZHVjZWQgdW5kZXIg
VU1MK0tBU0FOIHZpYSBhIEtVbml0IGhhcm5lc3MgdGhhdCBsaWZ0cyB0aGUgaXRlcmF0aW9uIGxv
Z2ljLg0KPiBXaXRoIG5kX2NoYW5uZWxzIGFsbG9jYXRlZCBhcyA1IGVudHJpZXMgYW5kIG1hdGNo
aW5nX2NoYW5uZWxzIGJpdHMgc2V0IGF0DQo+IHBvc2l0aW9ucyA3IChpbW1lZGlhdGUgcmVkem9u
ZSkgYW5kIDUwIChmYXIgT09CKSwgdGhlIGtlcm5lbCBwYW5pY3Mgb24gdGhlIHdpbGQNCj4gZGVy
ZWY6DQo+IA0KPiAgIEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBTZWdmYXVsdCB3aXRoIG5v
IG1tDQo+ICAgUklQOiAwMDMzOnNldF9mcmVxc19idWdneS5jb25zdHByb3AuMCsweGMxLzB4MTVl
DQo+IA0KPiAoVGhlIHNlbGVjdG9yIDB4MDAzMyBpbiB0aGUgUklQIGxpbmUgaXMgVU1MJ3MgdXNl
ci1tb2RlIHNlZ21lbnQ7IHVuZGVyIFVNTCwgaW4tDQo+IGtlcm5lbCBjb2RlIHJ1bnMgaW4gcmlu
ZyAzIG9uIHRoZSBob3N0LiBUaGUgdHJhcCBpcyBhIGtlcm5lbC1jb250ZXh0IHBhZ2UgZmF1bHQg
b24NCj4gdGhlIHdpbGQtcG9pbnRlciBkZXJlZi4pDQo+IA0KPiBCdWlsZGluZyBkcml2ZXJzL25l
dC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9kMy5vIHVuZGVyDQo+IHg4Nl82NCBhbGxtb2Rj
b25maWcgd2l0aCB0aGUgZml4IGFwcGxpZWQgeWllbGRzIG5vIG5ldyB3YXJuaW5ncy4NCj4gDQo+
IENsYW1wIHRoZSBpdGVyYXRpb24gdXBwZXIgYm91bmQgdG8gbWluKG1hdGNoaW5nLWJpdHMtd2lk
dGgsDQo+IG12bS0+bl9uZF9jaGFubmVscykgc28gaGlnaC1wb3NpdGlvbiBiaXRzLCBob3dldmVy
IHRoZSBmaXJtd2FyZQ0KPiBlbWl0dGVkIHRoZW0sIGNhbm5vdCBpbmRleCBwYXN0IHRoZSBwb2lu
dGVyIHRhYmxlLiBNaXJyb3IgdGhlIGZpeCBmb3IgdGhlIHYxDQo+IGZhbGxiYWNrIGFybS4NCj4g
DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IEZpeGVzOiA4ZWQ0ZTY1OWYzNGMgKCJp
d2x3aWZpOiBtdm06IGFkZCBjaGFubmVsIGluZm9ybWF0aW9uIHRvIHRoZSBuZXRkZXRlY3QNCj4g
bm90aWZpY2F0aW9ucyIpDQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgQm9tbWFyaXRvIDxtaWNo
YWVsLmJvbW1hcml0b0BnbWFpbC5jb20+DQo+IEFzc2lzdGVkLWJ5OiBDbGF1ZGU6Y2xhdWRlLW9w
dXMtNC03DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0v
ZDMuYyB8IDggKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50
ZWwvaXdsd2lmaS9tdm0vZDMuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvbXZtL2QzLmMNCj4gaW5kZXggYzE3YWM2MmZlZWMzLi5iMDRkOGRkMjZjZDAgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2QzLmMNCj4gKysr
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vZDMuYw0KPiBAQCAtMjUx
NCwxNiArMjUxNCwyMCBAQCBzdGF0aWMgdm9pZCBpd2xfbXZtX3F1ZXJ5X3NldF9mcmVxcyhzdHJ1
Y3QNCj4gaXdsX212bSAqbXZtLA0KPiAgCQkgICAgICAgSVdMX1VDT0RFX1RMVl9BUElfU0NBTl9P
RkZMT0FEX0NIQU5TKSkgew0KPiAgCQlzdHJ1Y3QgaXdsX3NjYW5fb2ZmbG9hZF9wcm9maWxlX21h
dGNoICptYXRjaGVzID0NCj4gIAkJCSAodm9pZCAqKXJlc3VsdHMtPm1hdGNoZXM7DQo+ICsJCWlu
dCBtYXggPSBtaW5fdChpbnQsDQo+IFNDQU5fT0ZGTE9BRF9NQVRDSElOR19DSEFOTkVMU19MRU4g
KiA4LA0KPiArCQkJCW12bS0+bl9uZF9jaGFubmVscyk7DQo+IA0KDQoNCkluIGNhc2UgdGhlIEZX
IGlzIG1pc2JlaGF2aW5nLCB3ZSB3YW50IHRvIGtub3cgYWJvdXQgaXQsIGFuZCB3ZSB1c2UgDQpJ
V0xfRldfQ0hFQ0suIEFsc28gaW4gbWxkLg0KDQoNCj4gLQkJZm9yIChpID0gMDsgaSA8IFNDQU5f
T0ZGTE9BRF9NQVRDSElOR19DSEFOTkVMU19MRU4gKiA4Ow0KPiBpKyspDQo+ICsJCWZvciAoaSA9
IDA7IGkgPCBtYXg7IGkrKykNCj4gIAkJCWlmIChtYXRjaGVzW2lkeF0ubWF0Y2hpbmdfY2hhbm5l
bHNbaSAvIDhdICYgKEJJVChpICUgOCkpKQ0KPiAgCQkJCW1hdGNoLT5jaGFubmVsc1tuX2NoYW5u
ZWxzKytdID0NCj4gIAkJCQkJbXZtLT5uZF9jaGFubmVsc1tpXS0+Y2VudGVyX2ZyZXE7DQo+ICAJ
fSBlbHNlIHsNCj4gIAkJc3RydWN0IGl3bF9zY2FuX29mZmxvYWRfcHJvZmlsZV9tYXRjaF92MSAq
bWF0Y2hlcyA9DQo+ICAJCQkgKHZvaWQgKilyZXN1bHRzLT5tYXRjaGVzOw0KPiArCQlpbnQgbWF4
ID0gbWluX3QoaW50LA0KPiBTQ0FOX09GRkxPQURfTUFUQ0hJTkdfQ0hBTk5FTFNfTEVOX1YxICog
OCwNCj4gKwkJCQltdm0tPm5fbmRfY2hhbm5lbHMpOw0KPiANCj4gLQkJZm9yIChpID0gMDsgaSA8
IFNDQU5fT0ZGTE9BRF9NQVRDSElOR19DSEFOTkVMU19MRU5fVjEgKg0KPiA4OyBpKyspDQo+ICsJ
CWZvciAoaSA9IDA7IGkgPCBtYXg7IGkrKykNCj4gIAkJCWlmIChtYXRjaGVzW2lkeF0ubWF0Y2hp
bmdfY2hhbm5lbHNbaSAvIDhdICYgKEJJVChpICUgOCkpKQ0KPiAgCQkJCW1hdGNoLT5jaGFubmVs
c1tuX2NoYW5uZWxzKytdID0NCj4gIAkJCQkJbXZtLT5uZF9jaGFubmVsc1tpXS0+Y2VudGVyX2Zy
ZXE7DQo+IC0tDQo+IDIuNTMuMA0KDQo=

