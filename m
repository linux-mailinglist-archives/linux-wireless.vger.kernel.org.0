Return-Path: <linux-wireless+bounces-9301-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9248F91032E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 13:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFFE288F06
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 11:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B790B39FD7;
	Thu, 20 Jun 2024 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eUMdiDT+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697884F606;
	Thu, 20 Jun 2024 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718883590; cv=fail; b=sgZJTJGZJvyj22U9i25jeSyHunOfN6mmvekI+7H9FQE9M9QQLfjwsi1x8PEsc8eZYvMIXT8JcDKGK0l5yF5oHQIeB4N2w3Cez3wuZ6iQjkbfU5lVmq8PXIuRJ8dlYVqUPd85g6V7z64VXkjml1qJa0mpgf0KaZeCGL0u0KVu4JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718883590; c=relaxed/simple;
	bh=wUpdcg/vriLRZ2rAZGdlchuWBogaLRX163ncQL00Ek8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CFG3v9cDU1mzfQ+l1pSu9M99ZPS3AmpAoMR6m1xwNWHY/rG6PI4bcly9YVN/bi3rQDUHTrj7ikYkRKYvGXLFMGMaBlvkDnGoFjg0Rror/qUfhaR0QGWFYluKd4NT7WTE9yJUhpaJbl0ZlyDkJqHGBIPveR0vLdzHwod1AQNv02M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eUMdiDT+; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718883589; x=1750419589;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wUpdcg/vriLRZ2rAZGdlchuWBogaLRX163ncQL00Ek8=;
  b=eUMdiDT+t4ecJlrbmxOcAEukfo8i3RJKu1e+saNJOwX2bFw+T/o1fXdn
   XaPgdV7HkT9ZMhpm+pSvbR+NcdL9E7h01sBIt9/uzxywlCTcKfvONmnwq
   U9PWc0SjJ15dEjyVbThplrI1hqw69C/3x89T56HU82evaeSo9HznNhTyn
   nEosGxvpJSar2kBlMhebf5jB+Bk7sZBwFj40/ddFE2pfvOHRqwJbVMu5A
   FSZaBtMagggNSyWciJwrTYHOKQDTySF5MD5T/GYhnM2J6cF/cBP1qaOfT
   ntGQlUi1WDHgFOGTlubH6sRf9/pbX+a5hYtTpRADMtMTskxgKUg9bOGiL
   g==;
X-CSE-ConnectionGUID: r5FZEUSzTS6/fWvpjyW4ew==
X-CSE-MsgGUID: Zc6M/03cQBSCqU+uDVjU4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="33310436"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="33310436"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 04:39:46 -0700
X-CSE-ConnectionGUID: FiCT1hK9SAuWkJ4GHHQfOA==
X-CSE-MsgGUID: KtAn+glHR7uYWYShdIeVEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42159088"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2024 04:39:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 04:39:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 04:39:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 04:39:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUTqDnaFW4fD5LdctmAY4VOl5nv8EVekQm/cuJpQVOaVYYgyuBkYrem9sbMnAbSNTxmkYL3y48pzoX+NBlS9f0sl6WJ+E6H8nxp4IKNcjjMwi1ZqR0/XodC1z3PwkEqUk+VqM2EfyjBnQF875jpkm2Cqew2lo9wzj2tpmNVJW6Eu4C/9rBeB0+/NXFCz4aEc/plmy1UbyMdHFqdzxRQ/k5FHNjoPxzN2PHpMI1B3z29qxH1iqF4uWfoBHqhFNEa0BJCsEpRwZIPAkCQ1C7LoIGQD+MlRYB/o01RzzjBCYuIhF20tHnHpWMMVUYBt9gncQ5BADFGlsdS502QDqP/twQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUpdcg/vriLRZ2rAZGdlchuWBogaLRX163ncQL00Ek8=;
 b=DYvx+2mcx5abjX0OneNGtzDjmDnPNa113+F9dD7WZiLXjUGwQaahSNvoLJwlnj/OYAtZaHCuyLE8MT0SIUF/V0QyBvlFU3sDdRSI5CnML6YZkWZrgVqm3ll8s5QJAY1Bt//3vyI1OIpMyPkQpcpas8LYrl4+LqnpdgzjswvPw0kei3e1AqxUqiNA+afLShvnKrjJ/nk87ib8YMZYwemuPiQXEPX2+BdNf/W4HKfAAsi9KzaWpQIRlKhf//CNZACulI6F8j2rS/7Z+e0IqyCniP/jnmn4XyQ2cdrk6bZS2ajcu6InuPlE+FzhxH6pwrRXr4oqyChwTTWH3i56kXnMIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DS0PR11MB7214.namprd11.prod.outlook.com (2603:10b6:8:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Thu, 20 Jun
 2024 11:39:39 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%4]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 11:39:39 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Takashi Iwai <tiwai@suse.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: iwlwifi firmware regression (6.9.5 kernel, Intel AX210)
Thread-Topic: iwlwifi firmware regression (6.9.5 kernel, Intel AX210)
Thread-Index: AQHawwZA6QhAoP1vtU2DhybQKCPdlrHQhuJA
Date: Thu, 20 Jun 2024 11:39:39 +0000
Message-ID: <MW5PR11MB5810E7ADB2F7AF3C7DB51EFCA3C82@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <87zfrf26bl.wl-tiwai@suse.de>
In-Reply-To: <87zfrf26bl.wl-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|DS0PR11MB7214:EE_
x-ms-office365-filtering-correlation-id: a6657d92-284a-46c4-5535-08dc911dab5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?RUxyWWlHd05hTWZKcVc2YVRqQnkzeWpzdERiZndZYlp4YUtERnlVS0djZmxJ?=
 =?utf-8?B?L1k4UjhxOEF6NFp5VklOK0tpU1k3STM0bE44NGZGaXo1MlNPNmxIZ1U4N0Vn?=
 =?utf-8?B?c2JZeUl4VTMra1RmbVVVYXpiaXBZays3Rk5hTDErSURFaUpDZ2pLZUhDUGVj?=
 =?utf-8?B?OVNyRGd1TEFNR2NYVmVmYzQvczNQTnp0eG0zTWNFeW84WDBVQWZiN2w5c0hD?=
 =?utf-8?B?bkV5QlB6KzJ1bWpyVXpDRzdBMHJ5eVpBR1dOZ3R1RHpkbE1CMXgwcFl1amhF?=
 =?utf-8?B?dTVza29FWVRhRU05UXdhZ0ZhOGxhS2YwQ09TbjZWUEtSMDdlNkhERW0xWVYz?=
 =?utf-8?B?M2ZnN044TjZneWQ2VG9wMk9XMEV0enVGa3RMTDJFdUFCSFcvRjM2ellYdWxD?=
 =?utf-8?B?V1NDcDc5ZGVocE9HRm1tRm5CTERZSXhFSnZtVkl5TXVici9WYlRvckJhcE55?=
 =?utf-8?B?VHJCc2o0VGVUYnFaODNnNXpLdXIyTklrczNKbm45WkxwWDJoN29uUGJlOTJ6?=
 =?utf-8?B?bUpFYnhnWXprYVI1cDVjVHNpaTFBeXFNaW1obisvWm1mQmpGa3JYSDBUaVIw?=
 =?utf-8?B?U0RzOVJyMzhQM3h4eDNRZEdoSk5Sc0lMRXltbHpwZXdzc0xxTUFJVTZuMzU2?=
 =?utf-8?B?WUhWZlJGTkM5SmR3QWlIV2ZRa201N0ltWW81OEsra1JSdlZLOXUwMVVqZHJ0?=
 =?utf-8?B?TXZwOVVtSlVjVWswMlBnNlJXOFV6NXQ3MkRKaDE5enptN2NDeGNFemZIZEtL?=
 =?utf-8?B?M0ZhZ0NESjF6aTRLUWRwRmU1Nkk2ZThqUmZLbXVIaTdnT2IzRmx4eTREK1Fz?=
 =?utf-8?B?dXdIVk5ZeWkzN3lFQXVXUWdiaXpRM3BFVlMxc2M5bnRnWGtIck5EUm4xWC9Z?=
 =?utf-8?B?amJpalBxWHV2aTgyaGdCV0kycWVTUURwbUkvUm5TWG1OQ05EUDRQek9aQUJG?=
 =?utf-8?B?VllRQVlKT0JNV1g3UEt1SG5zQ3N6cHBPaDluV2xIckZucGY3K1RhTHd2V0tj?=
 =?utf-8?B?SWsyUURxOVpWdk9SemluNHVXZEk5eXN5ejNqRzROK05qeFVyZkxsNFBRRjEr?=
 =?utf-8?B?M0ZkdW9VaFJjdXRPdDVuQ2dwWUlqVDAxR0JsYVZ4aVJXSGZPQ2ZRVU9pRXdY?=
 =?utf-8?B?YmlFM1lvMjUzRWtwdmJ6MFRtQW5NTUV6Q0MydTI1QzRPK3M4WnczOTJkZHky?=
 =?utf-8?B?ZjJsaTUvM1dNZjM5dnhTZWVVYWZNU3hFMnBzd21NaTVvdU1OK3hGbU96N04v?=
 =?utf-8?B?a1BiS2hnRnVRTjZpMWZXSjhwdGJDK1FPZGhnZ1lyeThMV052NVpCYmdKSkt1?=
 =?utf-8?B?WDFkeTFramxZc1RUY01tQWVSRnR4SFZuOTFaU2crU25lb1g0WWRWb0dHcDhk?=
 =?utf-8?B?a2dyc3lZSHRYZHkzWHhYSlhoYlVsUTlxUWFxeEpVVWZ4SkpRcjlyQWhyMFJB?=
 =?utf-8?B?d0ZNY3dxeHNaWmpiVlgvRVVZYWljNXpYS2YyUk5iVXErNDVVMDhlS0k1WkJ5?=
 =?utf-8?B?VXNNdU1OMmkzdlBrSDhVR0hkU2wwVzRFNFJxUDFSSTJmM0ZTVXNMc0x0VEtu?=
 =?utf-8?B?VTBJR0pEWmQxTmhoMlQvcHJ3ZmZaeXlyRjh3Wk84QmhtN2oyc0p4bjdNTTdr?=
 =?utf-8?B?a25RL1BWdXBDSUQraE1XcVNTWWlJcUFGTEFieWFndS9kTm1lS0QwUlRYK0Ny?=
 =?utf-8?B?eVdyU2w1b0RQUHJISnpEekhkMm5heXhIdTVPbTQvaVFuOTBORGdWSEpuY25i?=
 =?utf-8?Q?4X7HxqGjNAMFCgJMWuRQWqdXqAGzNMQTyDI+SQX?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHc3UnR1dHRSYjk0RjBNMkQ2bDFnWXZsM1RJbStFUnVGKyt4d3RuelF1QW5m?=
 =?utf-8?B?YmhNZmlqdHNneVRQRFZBcC8vcGJ3NFFVWVdaZEhrREs4dlVVRit4Q1VoS2lw?=
 =?utf-8?B?Q0RBUmNVajlJdmdHQ3dkSTZYWUVNOFJPNHdKckdGdXhWSWVMLzNBTXVKVTNt?=
 =?utf-8?B?S2txL2pxTmdBemxwUzh6NUpybmNycHFlL3ZReUxPZExIYUxXejdrSWhYcFVT?=
 =?utf-8?B?REUzcFZ4d1FPdGREUWloUlljZlZQeW1ib1NqQzN5USt2MDJpK1BWd2htd2Zt?=
 =?utf-8?B?ZERyMyt3VTFHU2VzQXFzUzYwS2dHd3U5RVhEUmtaWGxET1luNTRUVEhGbEIr?=
 =?utf-8?B?czhLY2MyUFl1WE9FSkdsd0lzRnFua290RUErRGY3S21nQy9FQ0cxVjlra3RU?=
 =?utf-8?B?VG81OGVoZWR6NlJaeWlrZ292amxnRE1jVVNBaGNFSnRXRWtRSnJRakZSdWF2?=
 =?utf-8?B?azZ6dGFUME1XMmRzNnluQkQ2ekFRWHRhYVJpZldVcm1Tak9yanQraTVpRG9n?=
 =?utf-8?B?S2FTekd5Wkc1SjlXS0ZDU3k5dDlWZnZxTnoxQ2REMm4vODFreUp3dnBJNWx4?=
 =?utf-8?B?LzFkVE9FK3NBSzhPK2xpYldtaFVLcVh4eXlBODdmcFhhanNnVFBkSU14WFVw?=
 =?utf-8?B?enN1eGJzbnFJUkU3eExEcU12RnJ4UFk5Nk1VNTJSaDduaSs4YTdQT003cGRz?=
 =?utf-8?B?WWdqcHY1LzJOWjRhVmpxS1BkTVViNDQ5K0pFNmlRYWFXazVNb3Jwbm5rTmhR?=
 =?utf-8?B?WU1VNjBWa2p0SlBQejlITXhXdnQxNUIzdmlFdnovTjNFT1ZzZ3JXTHBndnNj?=
 =?utf-8?B?c3habVd6VVBkM280UlFpbXlFZ3ZlaWozd2RsckNGZkl4Q1M4eHJsQkFJS1Rr?=
 =?utf-8?B?UzNVdk9hcm9ITDZJbGVTdlYyNWZZRTJoQVRZeG5yRHM5QVo5czZJL3A1Sjhh?=
 =?utf-8?B?UktXcHgyak5XOVhDN3F0M3BUc2J3bUg1S1p5dXN6K053alViSEl3UkF4VnJC?=
 =?utf-8?B?YXhyVEZ5cUdVMkZIVTYzMmVCcGRkakM4OE9kdHZuYm9xbTA0elBGUW16UDRr?=
 =?utf-8?B?ZmMvNW9sMEFkbmVrcW9ENUNxODF3c0M2M1UzdTByTFBGekZoWVN4cDlOTXRk?=
 =?utf-8?B?OW1JYUQrSDhXUlEvRnlwMTRsdjN5T2lZRkxQU0pObjBWdjEyM1pRNnpVQW01?=
 =?utf-8?B?OXZqZVcvcE1acWNIczdZbmRCVTRYWXlQcUVxVTJLYzVSTCs3YkNzU1pBdmZR?=
 =?utf-8?B?WDdYVTFzL1ptQlp1ZkkxYUdZRDhZTWFxMDZhVVJuMTEvZG13RWY3R2Q3R2ha?=
 =?utf-8?B?VldYSUN2OTBnU2JmN2dzcDRNcTMvNWZSWmM4cFhiNGxwTWtGNSt3OGs5UFhm?=
 =?utf-8?B?c0NZMHBnYTBON1MvU01jNFZsemZnK1hWYTdKMHdLTnJITGFDS0Q4eGh3dDBE?=
 =?utf-8?B?NGtsVlJ6clI3S0p4RWUzVFhFZ0c1ckZFVEpKc2FpdUZCVmZoTTBURUo5eVNy?=
 =?utf-8?B?elVURldZbkp0QUlRMzZOSy9XMFpIWnRhNnhuSmE3dzJCZmpHNEhLZG5KOE1o?=
 =?utf-8?B?YTRMd1JzRW13MVgrTlpUcXUvaXk2eXFUNDZTeFJ0ZDdQTGVpV2tOYUpiZHVh?=
 =?utf-8?B?Wk5ueVVmSExYTEY2bkkwVTdBVE4yeG95ekFvM2hpS1NnY2pDVGNaY1dreXRR?=
 =?utf-8?B?OUdFNFo2UGpEN3FCZktMMVZHcjhqazhBcW4rWXhiWmEyNTh1QnUrMU1Kd25x?=
 =?utf-8?B?c0VLV25sNVJ4UGNQdENoeGZzdWZKaUxUQUlKTWlCajBUclg0Z1ArRUtZb0dz?=
 =?utf-8?B?L1lPaXJFU0Z6NU5EdGYrU0ZaTkhyUUhsdVVFdTlXSExLcGd5MEs2Nlc3clVZ?=
 =?utf-8?B?UjZWeGFscFBtaElvZlJOcG5YT0M5UmNXekp0a05tTWlFaXhzbXgzVmpzc3NP?=
 =?utf-8?B?K1BkODhtRnRPVW1lcnk2bUljOUh6cTdpQUJ5UnlacGM5QzluUG83S1F0Y2po?=
 =?utf-8?B?ZG50aFdCQ0F2MThza29Edy9uR1docXZ0Q2g0RDQxOTF6c2pOQTBoUURzUXRR?=
 =?utf-8?B?OGUwY08rQWtXY085b2JoSi9McHZIOVNtbC96amE4Y2J2ekpieWlYQy9HN3JY?=
 =?utf-8?B?bzU2cVBUS2FMYmlxeFRHaWlUY3NMTVdDbU1OdkduMWdKcDl1ditsTmJKU1du?=
 =?utf-8?B?TlE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a6657d92-284a-46c4-5535-08dc911dab5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 11:39:39.4756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oe2QWAHBYxsTIfFlh7wMBKKmn+FRENj9no0R4ONC2X8kL0oHXwGXQU+CzUd73CGWu1KMwjV9MMXHRGCyq3IHPNMsq44vStZwKU4xxUnOWCftffn7h4S9lCFz2TPWA8tX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7214
X-OriginatorOrg: intel.com

SGksDQpBIGZpeCB3YXMgcHVzaGVkIHRvIHRoZSBzdGFibGUgdHJlZS4NCg0KTWlyaQ0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRha2FzaGkgSXdhaSA8dGl3YWlAc3Vz
ZS5kZT4NCj4gU2VudDogVGh1cnNkYXksIDIwIEp1bmUgMjAyNCAxNDozOA0KPiBUbzogS29yZW5i
bGl0LCBNaXJpYW0gUmFjaGVsIDxtaXJpYW0ucmFjaGVsLmtvcmVuYmxpdEBpbnRlbC5jb20+DQo+
IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogaXdsd2lmaSBmaXJtd2FyZSByZWdyZXNzaW9uICg2LjkuNSBr
ZXJuZWwsIEludGVsIEFYMjEwKQ0KPiANCj4gSGksDQo+IA0KPiB3ZSd2ZSByZWNlaXZlZCBhIGJ1
ZyByZXBvcnQgZnJvbSBvcGVuU1VTRSBUdW1ibGV3ZWVkIHVzZXJzIHRoYXQgdGhlIGxhdGVzdA0K
PiBpd2x3aWZpIGZpcm13YXJlIHVwZGF0ZSBicm9rZSB0aGUgV2lGaSBvbiA2LjkueCBrZXJuZWw6
DQo+ICAgaHR0cHM6Ly9idWd6aWxsYS5zdXNlLmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTIyNjU0NA0K
PiANCj4gVGhlIHBhY2thZ2UgZnJvbSB0aGUgbGF0ZXN0IGdpdCA3ZDkzMWY4YWZhNTEgaXMgYnJv
a2VuIHdoaWxlIHRoZSBvbmUgZnJvbQ0KPiBhYWU4MjI0MzkwZTIgd29ya2VkLg0KPiANCj4gQ291
bGQgeW91IGludmVzdGlnYXRlIHRoaXM/DQo+IA0KPiANCj4gVGhhbmtzIQ0KPiANCj4gVGFrYXNo
aQ0K

