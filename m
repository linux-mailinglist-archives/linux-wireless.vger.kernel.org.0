Return-Path: <linux-wireless+bounces-31873-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL48IbtLkWnThAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31873-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Feb 2026 05:29:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB68913E014
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Feb 2026 05:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9386D30137B7
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Feb 2026 04:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8FD22A4E9;
	Sun, 15 Feb 2026 04:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="evGyW+OV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1611E1DFC
	for <linux-wireless@vger.kernel.org>; Sun, 15 Feb 2026 04:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771129784; cv=fail; b=M0qyZLO4/0BNg8qfRIdSAxbzm1RMjrwWDYnbAYNEpXo4JHCX2v0CVeCHTrONlyZHUzHYtnVuuD5SMBHJXZ4eQXvCSUv1avWYtPLUHs3C1J4IhdJWX+DB+nkc0AJbGLo9AWjmhfowsZEGgHEB/oLOfNXkkbIDT15NxZ9fnvrHXwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771129784; c=relaxed/simple;
	bh=RVSig+vmP35Fhe+c32buMDQFKci/cBW4MmJeY8p0Zac=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eFPwGCNBtlE9OGSSftJbA9t6KXoupETKghtEYWIcp7Z9qAsteF/t0MAe7ZIAVz9UET5r0lyJC5LBKmIFIfQ6nLIeCEXs24BEfygQO6pg+zDMEm0t/+vAV9Ql5ZuNSZQv0X4MTcS4bQk5eFVhkp+Uh+F3NsGqO7FvvrzPtgHxyJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=evGyW+OV; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771129783; x=1802665783;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=RVSig+vmP35Fhe+c32buMDQFKci/cBW4MmJeY8p0Zac=;
  b=evGyW+OVe/29ZQaZOoxgGFmWr0UHN9JtY8Q8YxtMBGedsZY72qYbwTh1
   hWbRvFTkY2FBZBLGq8fALuOcfo5YXK4Ryx7SioRsZX3ck/eQutbXYSgcU
   3WBzkJg9pvAYSqxoZdOlm3Zvx/ZbOnfn+9fkWRJlycce0N7CmeSqWCH6p
   cIbbHvdW+GowpY1X/Q683bxlyi680HUpFEbDirwjTzyh3K+naqNsDhZ/z
   ZSSVjlrdukIgzMiYYyvBpTRqRkM1tZUd2TrlD6HAx6XcuL2WR+Fv6tcV8
   uK2NKosQMGPken6INqKv/XHeUfugjLM40j+WSWC3qlRYMwnFJHYfeyoLh
   Q==;
X-CSE-ConnectionGUID: jtaKo4yKSaWKH+UHZHPO8w==
X-CSE-MsgGUID: R37KwnF8TayZcx2Hx+VJgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11701"; a="76106275"
X-IronPort-AV: E=Sophos;i="6.21,291,1763452800"; 
   d="scan'208";a="76106275"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 20:29:42 -0800
X-CSE-ConnectionGUID: 1nbjx2ysQ3mchSb9S7oUAw==
X-CSE-MsgGUID: SD6uIxu4QkyHGHnpw/Hheg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,291,1763452800"; 
   d="scan'208";a="217439170"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 20:29:42 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sat, 14 Feb 2026 20:29:41 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sat, 14 Feb 2026 20:29:41 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.1) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sat, 14 Feb 2026 20:29:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkZEZw3CTwIKSAtvIQQgKXj5SUTR9CoZXc9Tyx2GCCdGcUWmyVY01fkN3MKNzB9yCG9ES/JDokVJcbCMiKKGN8NQemayw9UctRKSi8PTFvu1u6pUeo3dgBEe6CUIPtmz9lrjV9i/VTudlFP8SLfPPXt66UQDSADuEUw3V1MbJwgLXZ/4Z9nkn214vNhxieVEc7MPDr+V4jlmXkAMd1T1a9ubMIsDALqzUzQZlNznkRdcISfIynOIJKdSAYEDnhKjSQUrwhW3r1bVZMn17kytrVI92DB2hQIu9VhSgjdEa3PoL5A6ITHaTMrmH7S1H1JDUQqpT/xjp+588+YstpWdqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVSig+vmP35Fhe+c32buMDQFKci/cBW4MmJeY8p0Zac=;
 b=S7VLWoq04eZr4tXuA246ZCY5CkgDLdcq3BxfeoNNghFv/aacGiSW93xqgFgGmDpD9FuRJ5oHZmG4+OU37F9sNxeHxqckG26YGuRm6bcJJxi3CP0Xof6NiM8Xo9xX7parOShBahKDua2fSEnPK3mbhum99dl9uhTg7bhoVyUv7DsGH9SrlgjNf4CGeGob12mg6FFnVpxQGCnuohIo4dstiaBZPL5Ew4NtnSeAVg13cN52lxj13GzgQsa/JJrCPeG6b5p+d7MMoU3+6AJyVI2JZ+2MCuy4JpG+Hai0JJagcllBfPXToYtxbjwb1rObXgbvhwE/aL2TlurdCLIkD/namg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Sun, 15 Feb
 2026 04:29:39 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5%3]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 04:29:39 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Ben Greear <greearb@candelatech.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: iwlmld iwl_mld_change_vif_links can return un-initilized 'err'
Thread-Topic: iwlmld iwl_mld_change_vif_links can return un-initilized 'err'
Thread-Index: AQHcndUKKrBM4+B8tUGla4aMTQXeTrWCb16AgAC8EhA=
Date: Sun, 15 Feb 2026 04:29:39 +0000
Message-ID: <DM3PPF63A6024A93AF7E3FFFA2038153DA2A36FA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <5ffe48af-e02d-4d02-b669-6a9d6797b956@candelatech.com>
 <1cf6d7aa-7ced-4fba-88e1-adb1cfdecadf@candelatech.com>
In-Reply-To: <1cf6d7aa-7ced-4fba-88e1-adb1cfdecadf@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|DM3PPF7D18F34A1:EE_
x-ms-office365-filtering-correlation-id: 6384b33d-31f2-47ea-63a4-08de6c4ad52e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?YzNSbWxWS3pkaFh5ZVV0OExJVzBrbWVNQU5JTUlRT1BFdXZJNFJyOTJGUjdV?=
 =?utf-8?B?d2s5SzRZU2RnZ2U5Q2ZRclBYWk10MHNLTU9qbERmcVFJTDF4cGdlV0JJRXhj?=
 =?utf-8?B?WW9qU1VBVlZlaHRmc3B0ZnJocGE0d0Y2WHVLMExhTHNuby83b3ZLUDN6b2RC?=
 =?utf-8?B?Zi9lSFFJaE56S0tielJhZUtiblVVRXpOb2JsTE1ZalEwUTNRcTVVMk1vamow?=
 =?utf-8?B?QkFIaFNqa2lHdzdVQmZ3UWNxN0NMZ0o0MWROVnZkRzFvYjFsdmhGaHF1TGNw?=
 =?utf-8?B?RzBuZlQ4UzQyd3laSzhtRk1XcTBpeHBFaUNQakVHZldhWXdUcS9CVm0rUmdo?=
 =?utf-8?B?Ty93ajFXdm55R21Cd3E4cXMwYm1CYnhpMUVxYldOOXU0ZjhGWmV1bmpoNWpG?=
 =?utf-8?B?djNwWVlWLzZrd05SVGxVSDJUU3BsZENVeVZxdUovK3ZKZXAyLy9scmJFQ0Nx?=
 =?utf-8?B?Yi9hQURBZUdhYWVGMnA2UTI2OVgwbGZzYVE2dWlyNVc3YW95UlF4SWg0bjRG?=
 =?utf-8?B?d0FHOHBiYUNuUUl2bjExYlNwd05vNmdkMm9sdE1zWTlUMlRxQ2VQck5DZU11?=
 =?utf-8?B?OHh2WktqRmJ5bjlmNm9ldDNBMUJPa2pZZ3BuamZkNjZIZWxDRFN0SGF4K3Bz?=
 =?utf-8?B?RmZOWjQzTWZXNG1kcHZ3YmNzUElkTTB0UllHVStBNmxTaDJWMm5XWDg5OFVp?=
 =?utf-8?B?ZzMxRUFCNW1wditpQkR2WHlqd1FhcFJWcFh0aGZ5Tk5wTnNNVHZCZUdTOVlC?=
 =?utf-8?B?TE1ZZmVIeDduVVRRNWJ6WU1NQnhsd0M2dFNLYm56T2prcncrc01UQWRtdUxC?=
 =?utf-8?B?dzFYVTBnYndCMXVxbGZJRkdtZjg2UWcvWUVjeEl1cURvR3N4YUZpVDdncExS?=
 =?utf-8?B?T1drN0NpOTlqUGZIS1A4RUpWOEpXZ1lWcTJVSVRUdzhoQk1nWHVaR2xRZU90?=
 =?utf-8?B?Tnhwb3pIRDh6dyt0K0R6RjZHeG4vVHpDcTFDLzRJa0lINTlDOTBFbzQ5ZTdI?=
 =?utf-8?B?L3hiaVEzclRQQy8waDJoU09uSXhjYllSUEpETXlINEZoZFVodlpDSWVVSWhQ?=
 =?utf-8?B?YUV2QkF6QVdSODB3WDJjKzA3SWE5R2JUdloxQUxmOEM1N01mamJDdElkMmJw?=
 =?utf-8?B?OUVBTy9TRlJnS3ZrcitPV0M5MVltM1M1dzhwT2RJNFU3Y3AvMkE1Y0pxYXJi?=
 =?utf-8?B?MmI2WWNaaUI4TC9pNFlGelFxN0xJZlNIc0V0azZwQjFnMlBXaHJGWHM2K0hU?=
 =?utf-8?B?NVhrKzNwUUJuQ3NmMWJHTjBQbmNhNWRFVEF1YTNaMHlKd3BDNFZSeGZwSGdL?=
 =?utf-8?B?UnQydENLd0Erdkg4cEJzNGNGaWxLMzNlVlR3RlJ6cFpPMEhCT0FWVlp6SFlv?=
 =?utf-8?B?cUtiem5TSGhiNHdrTTNYbWZSN0lNeWtiY0NPOG1GTk5DS296WG16bEswK015?=
 =?utf-8?B?cmdxWXdIMEhrbVlucHhmVXh2ejAydVdzS0V2VklxM0dNclY0UG02Z3dHRk9U?=
 =?utf-8?B?QmhianFjdzZUN0t0OExsdW9ibWRWTmpyd1Npamc5RnV2b2NheTI3MzhIUjNo?=
 =?utf-8?B?eWtQS01VS0FFQjM3S0N2aWw3ZGM4clhia0o0cDRpWEs1RHVuY0NNeFRnYStk?=
 =?utf-8?B?RkUxK3hpYXNIQVlmbStMSzNXUXE4NGU1eHBSQ2s2TEI2VmI2VDJ0Rkx0VXdK?=
 =?utf-8?B?dkhlVFozaExwR3NvV1ZqRitGbnlRd09wVzQwbUlOUmswWUlrbXcxNEpNaU5z?=
 =?utf-8?B?UEZYQktsWkZOM2F3UkE2QmllemhZcE9YREp5Umc4dmdrcUdFc3BaZVJkNkk3?=
 =?utf-8?B?TDhJLy85M2lnQ1RGTnh5bWM4VlNkZlozaGgrd2FjZ2x1bjk1QzRGaFd0TDBh?=
 =?utf-8?B?T1hyNUVzOWUwTElQYXBkQ3cwdERjdFFwRVVQbm1Wak5RUzdjdmtqS2RkejlD?=
 =?utf-8?B?SE9JZThOMDRuQkcwSXdSdmhMa1N5Vk1oZCtrQjRjcmtPQUVPbUFoVS9vbU9r?=
 =?utf-8?B?Zmdqc3RmelJTcjBWVEx1cm8wTTZPcDM3ckZtbmNxWEJuWWMxM1FqeFdNNksw?=
 =?utf-8?B?Tm5YUXNsSzVtLytQN1hScVRNdkVpaGpLcks3TU9UWENNM3JQZitqR1ZBeVlX?=
 =?utf-8?B?Z2JITWoxbFdYSllYZjZvZ0dwaUpQLytvMVJCZEo2RHNMQWM2clJZdzhYWWJG?=
 =?utf-8?Q?GKvS7o9FpdhXggbOFAW/bhk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REtOTm9sVlRqVzNDQWp4dENqb3NSZDFvVzJhVytlU2VEN0RRQ0Z2elZSa2VG?=
 =?utf-8?B?R0FsMjZISExEbmhHYk9qQld5dEMxYkJha05FcUVkMEdMdUtTTVlxc04zY0Fh?=
 =?utf-8?B?eWlTNjRHZFFyUXNyRjlVeng3KzN1bDVLZDZubkh1NkhjY2Fyditmb3ZOeExy?=
 =?utf-8?B?MkhzWnJGZFVsUHpCM0k0dGFKUng4K1UwTDQwUmg3UWY4MGFETHdtbG43dnNQ?=
 =?utf-8?B?YmxzQ2szNmZzSGRCVW85eFhOUldxUHk3Z0JZOWRtWHVlTmlzMzUzNGVxSTFw?=
 =?utf-8?B?VGkwWFI1cVpDdHpIbTM5Z3lzS2sxQVBxUVZDdXBuRitUeE5rTC9Kb1FJOTlW?=
 =?utf-8?B?TkdPNnA5WEx4cGtKQ3ZwV1NRV0JWdm9ZS1ZDeFpKeWowcHhnelJud1NnYzI4?=
 =?utf-8?B?MGYvUHJJNE9aTFdYbG01Rk9neWwrRW9nWi9DN2UrblViSlNEdmo4alZYRXFt?=
 =?utf-8?B?V2xRN1lIK3AxYUhoZmRENUVxaWZLamNjU3k5eEhZNU13VGZRWGEyRVhXSDhi?=
 =?utf-8?B?dFdpZ3pFcVVzOUJnaStsUkJyVlNwbmpkTjVoRFc3QmNSS0ViN01uVWFTQThF?=
 =?utf-8?B?M2c2TmRCbEY5cUtDeVZYc1lRdko1TWxZWVNQSWc0QUt4VjlTeE9UMFpjSlNX?=
 =?utf-8?B?Q1ozQ25Dci9vUUZxS1lzbEZ6MHJpME1ncXFMc2IyT1pMK0xIZEd0cUJYcnlw?=
 =?utf-8?B?dFpKUkVZSktuVFAwOHFpUndRcHh3Ty91YSsrS3gzSjdSbU5BRmgyQ3QvbVdi?=
 =?utf-8?B?eEFtcDk1cEN6TnQzdWx4VkRJQlh4bWh2a3RkSHFjTkkxekpkSmE4bWVwc29C?=
 =?utf-8?B?dFV2aDkySndqVkg2ZXdrRWZ4cUZvdFh0TExmd1FtbUNtVkdaYU01dW9leWpH?=
 =?utf-8?B?YiswN083QjQ5UXQ3VGhCa0w5OFVQVFVEWVpoSUg1STBjYU1mMlJNT2FvS2R2?=
 =?utf-8?B?VXN6b0hXOHd2dWxWbjN0bGNBSFN3VG4wY3VWcDZKRVJQWWJUbEJFSlhBWktS?=
 =?utf-8?B?dld0VmNSWFBpelBYSHNDNGx0YjkwV05TTmF2Rm1KaE5DRW96eVB6MVl0MnJJ?=
 =?utf-8?B?alNLRURRb0l5cDNFdlF4VW1uUDhFOHJZeG1PU1lXaHE5MGthSG83R1FXSDhr?=
 =?utf-8?B?SWVQNC9BWWNnNUxxN1NkUVhVclhod0ptdUgvYU1Reko4MVB4dnVLU1A4VXhC?=
 =?utf-8?B?K01KWW1meUFxVncyL1lEbEpWQlVzN1JJeS9XZVBtMVRsVm4xbXd4d2VyTnFt?=
 =?utf-8?B?Sm84OTVXU2x2eitmbDRxaFZPV3JTVExNdUVyZ2pyUEpFZGlaVUdiNmU4NFBW?=
 =?utf-8?B?N3Z6ZVdMUlVXRU9xZFhrV2lwSndoajZpMGJqYVN5NEFPS2dzc3daOU1RMkdq?=
 =?utf-8?B?aktzSFArOWFuVTRaL2NrOG5YZ090NjRVN0U4dVRHUEdpMXFPYjFJRklrdlcx?=
 =?utf-8?B?TDhCK3ZyK0FiNDFqS28rdUQzZTRIUnZRMmQwSlJxQmJrSnJRRDltbmZCVlcz?=
 =?utf-8?B?K01CR0FkdTdjdktJSVRuaitzakZ5eUYrZFVjSGhFL25INUJ3Q2ZkamNod3d4?=
 =?utf-8?B?L0pXOHZueXZnMEt0VVRpZWE5dDZCU0V2RHhieHNSRWttOE9xMGUzVkFFM05V?=
 =?utf-8?B?YkF1cnpNK014RUllZUxsK3VSOWdYbU40ZmhVeEdUNzBOaHFJWFFUZSswR3Mw?=
 =?utf-8?B?Z25nWHpucksySXplOTYwWHZaVVBycTYzdms2d0EyUzAxZGpYMUpxaXdZMGoy?=
 =?utf-8?B?SG1rZDh0TGppSkdETUxwdjRDUDhlaFM1cUVpZGkyY2hHTjZ6U0NSU0MvQlpB?=
 =?utf-8?B?SFVMTDBiVStmMHk2d0xKY05HSTdVMmFjaUlRRHN1M1d6ckY3NDNTWkx6TjV2?=
 =?utf-8?B?L0ZweVRlZlRhVXlvbnQ4cU5YZ2NRUkpsMmY3RUlicGJtNmU0ekhSV0JSYkR6?=
 =?utf-8?B?cTE0QnU5ZGFJN3lGbmwvQkkzMnhRQ3FmVEVVSXA0K2J0YzNjZERHZmRGQkRk?=
 =?utf-8?B?SUloQmRSclg0ZUt4b3JnUG1DVGw5T05CUnNIb091d05jN3EybkZMMk9YVG0v?=
 =?utf-8?B?QzRsWC9qSlZyaS95dTF5K05KZmttejkrM2F3MjhGN3U3ZkUwYlFsN2JZaGRK?=
 =?utf-8?B?SmQzbFYwcE5kdkZ0Zzd3SnFvc2lDeDdNRXNuZ2prdndkRnN2RTU3TEI3UWUz?=
 =?utf-8?B?MTJqQlVweVFEdG9oeW1SYlNpWUZGTTZtaWZYU1AxY0htNWVxRkg0cnVOY1Fk?=
 =?utf-8?B?Q3RRM1A3MTdpYStBRWhWdE1pdCsvQ3dzTTFCS2V3Zk10WTJCNm9qdDVpZkJ3?=
 =?utf-8?B?eGxSdlZmT2xXY3NPTmJJeWVwdEdwczV3amF4TDZXaHhBM0ZRWkdzN2RhRXdB?=
 =?utf-8?Q?PU1WijZvi+jt27EQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6384b33d-31f2-47ea-63a4-08de6c4ad52e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2026 04:29:39.3106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OdJHW9CMi7C4yvJr/6YQPa6yEC/pO0Hs6EMfw4SpytzYwGVCMJdYixPwaYqY1nJd/bA3qlGIRsYCXRSiZSGcJBEuO5vAF8nTHkO2KkBoMPhKVErO2s6X5SF28Th3hJNI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF7D18F34A1
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31873-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,candelatech.com:email,DM3PPF63A6024A9.namprd11.prod.outlook.com:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: DB68913E014
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmVuIEdyZWVhciA8Z3Jl
ZWFyYkBjYW5kZWxhdGVjaC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBGZWJydWFyeSAxNCwgMjAy
NiA3OjE1IFBNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEtv
cmVuYmxpdCwgTWlyaWFtIFJhY2hlbCA8bWlyaWFtLnJhY2hlbC5rb3JlbmJsaXRAaW50ZWwuY29t
Pg0KPiBTdWJqZWN0OiBSZTogaXdsbWxkIGl3bF9tbGRfY2hhbmdlX3ZpZl9saW5rcyBjYW4gcmV0
dXJuIHVuLWluaXRpbGl6ZWQgJ2VycicNCj4gDQo+IE9uIDIvMTQvMjYgMDk6MTEsIEJlbiBHcmVl
YXIgd3JvdGU6DQo+ID4gSGVsbG8sDQo+ID4NCj4gPiBJIGJlbGlldmUgdGhpcyBtZXRob2Q6DQo+
ID4NCj4gPiBzdGF0aWMgaW50DQo+ID4gaXdsX21sZF9jaGFuZ2VfdmlmX2xpbmtzKHN0cnVjdCBp
ZWVlODAyMTFfaHcgKmh3LA0KPiA+DQo+ID4gQ2FuIHJldHVybiB1bi1pbml0aWFsaXplZCAnZXJy
JyBpbiBjYXNlIHRoYXQgdGhpcyByZXR1cm4gcGF0aCBpcyB0YWtlbjoNCj4gPg0KPiA+ICDCoMKg
wqDCoGlmIChXQVJOX09OKCFpd2xfbWxkX2Vycm9yX2JlZm9yZV9yZWNvdmVyeShtbGQpKSkNCj4g
PiAgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGVycjsNCg0KSWYgd2UgYXJlIHVuZGVyIHJlbW92ZV9h
ZGRlZF9saW5rcywgdGhpcyBtZWFucyB0aGF0IGVyciBpcyBpbml0aWFsaXplZC4NCg0K

