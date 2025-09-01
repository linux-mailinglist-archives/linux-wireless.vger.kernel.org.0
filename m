Return-Path: <linux-wireless+bounces-26894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DD1B3E68B
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 16:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C5C167178
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 14:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7014B20297C;
	Mon,  1 Sep 2025 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FMrSCKUA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C36C1D61B7
	for <linux-wireless@vger.kernel.org>; Mon,  1 Sep 2025 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735382; cv=fail; b=ZP4zAoGbTTH2/yydB4e2aAwda7GEXbo3YG7hJmflo34hNbizMdSDYAwlkAmfIluH8cv3e+ggBBFkYJ1OnyZ3l9h0UGbkRJ2f+On2p5p7nPzCVa891fFbu4Dis86REHbTC3jAkbEPZJ1dp//3mOFA4IVpoyAewOLtrgE7m1hB4rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735382; c=relaxed/simple;
	bh=J1cofl5o3aoVbWK8GcmTDCvgZJrwWnSPBl6NVMB1fgs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fPZD+8SN1Uil+P44I9vCyGl2/qxFadj1SFn72pHb0FPZrFFLc4M2kTHXLM7wBqkBR7QxTRMks21FzfmRF7JjvZ0A8EFE3d2Lf7Zq9S1i1isFj8EhdZj3vzSogODQoaDP9YhPFbsSXISy/KRHLUeEn63aofexLryiFHH5xJmWkxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FMrSCKUA; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756735380; x=1788271380;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=J1cofl5o3aoVbWK8GcmTDCvgZJrwWnSPBl6NVMB1fgs=;
  b=FMrSCKUA9qPOiOwkb3aLnAN1j4hcW05o8VM97JnJTDJscPmDrsONGeg3
   rQ7ZXfiiD90x+EY2NPtHWKfHxXbjoqC1XXqFxCfkYmKIPuzN7NYW+Sgxl
   tSXdQ7H38r1ZdtFltDJwogJo8NTPcA9d05V5rqTtoMNyAiD+Pa/fQ/+IH
   Ng+RfmtM6YBti+OFVfj3KIVCBpXJtf5mPcV7vLnDuGertFGX7rPXZLwyt
   Wznzsif8XuhmrdjnMLjqcaG/BxE4baZxRCaQAuz7ornEpsoxNSMmgo+BW
   CLHMtUgDT5X2SSkd+qY3eUquQxWQMOpQDwgqxZR+1TsUciC5gNvpN8lxj
   A==;
X-CSE-ConnectionGUID: /txoRx+uTG+35tPc4FZL8Q==
X-CSE-MsgGUID: /zeAQdF1TmKNzR5FUVWNHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="70099750"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="70099750"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 07:03:00 -0700
X-CSE-ConnectionGUID: QsfFU8czTTeJzq07d7oayg==
X-CSE-MsgGUID: rhcJtwJoQ2maXYOhjYbMtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="194678131"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 07:02:59 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 07:02:59 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 1 Sep 2025 07:02:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.55)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 07:02:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKNV51Vr9lI9lZODlPbaRlSbydP7hG8s1YCN1vA5ocblPjh3XQgP9uTvfdR29Cfiw3W/V006jFGBg2qnWKwJ/9mmkVzM22qHyHwILy2rhLAS+10lwxVMsLcI42kC+IXu+62BIrenDt2KayM9I0mhiTqJ5UuztAZ3qMgS14n0FyQ+2gsjDxiu28cucP+iusl/jEU0nVsojNSnxlV1MyIxkGh2xTaiBKL67jEXBLzQSI28hw5/wsJ73gZki01amSWDm4OOMzQ016/AjADzavBIMt2REPc+CLcNoDmxqZIk9N20nklhb/LT9pN+m86w8ZBxwJGvzDKen/ZAz3Kovur6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1cofl5o3aoVbWK8GcmTDCvgZJrwWnSPBl6NVMB1fgs=;
 b=xw6E/In9hN79c8jepf5zqNO/CRu1bPn5lAAFT8aQfdu/VjsZeness1cv2A7DsWX7S3n2wLWzkEjMgmKJafedEAbWM0wsenFoLYvyW5NwCW7sNPh/t9zPS1aCOG4O8IRJxJMPiO9oTegZ416Eb7+TGZLhS/vFLaC8OHuQZvdGOS2xpKo7D0ARrOsmbwRMyPaAGKQ7ZVQ4PaG5VFIdJk47KciwZ9AavDkmizmzE99hRGkuFlegqNwxK6pGnqYHBCdRji/aZs9sgobJMGVGRsy4a06P0T2Lzm13jBKbehUEkmVz2eZc0e7Yskz9NvSME3kbsagIt2Bq6ISeqo/n0/cczg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by IA4PR11MB9057.namprd11.prod.outlook.com
 (2603:10b6:208:55d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 14:02:56 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987%5]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 14:02:56 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC: Linux Wireless <linux-wireless@vger.kernel.org>, "Dreyfuss, Haim"
	<haim.dreyfuss@intel.com>, "kyle@infradead.org" <kyle@infradead.org>,
	"Hutchings, Ben" <ben@decadent.org.uk>, "Yang, You-Sheng"
	<vicamo.yang@canonical.com>, Josh Boyer <jwboyer@kernel.org>, "Grumbach,
 Emmanuel" <emmanuel.grumbach@intel.com>
Subject: pull request: iwlwifi firmware updates 2025-09-01
Thread-Topic: pull request: iwlwifi firmware updates 2025-09-01
Thread-Index: AdwbSN4GSFdGdzzSRrOqUW053/LUfQ==
Date: Mon, 1 Sep 2025 14:02:55 +0000
Message-ID: <DM3PPF63A6024A9A398FEA588192B174565A307A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|IA4PR11MB9057:EE_
x-ms-office365-filtering-correlation-id: 4192cb1e-45c6-428c-de05-08dde9604032
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SEt6Tzl6TUYyV1dPTUZpZFV1L0x2bjFDTlVkMGNwZ0JOdGg0TlZOSitIMjIx?=
 =?utf-8?B?Uk9IdU5SRk9nWXJjU3FHc203Y2tuUFFkZnVJS0FZL3ZYODIyYXZ4OXRVY20x?=
 =?utf-8?B?TUcyaEhOMTdNdFlodWhJM01Xd0ZFWXpaeFVtVkJEMmNTcEh2UUNtc1lSNTc0?=
 =?utf-8?B?Z3pYd0hXdkcxYzBuZUZVZ3NhVVp3c2ExaUFCSFNVZEd6T3lRMStaeFNpWTh4?=
 =?utf-8?B?Q0NuQ1BRTVNuY2ZGVWlYM25PK3RvWS9Tc2ZOdk41RWZlU3ZGS213SGQ4eW0w?=
 =?utf-8?B?WHVDUkxIOVlreG1aVm9oUUZDQ3ZZVDg3eW9NckRHRi9NYmxZQnZHLysxWGF6?=
 =?utf-8?B?cnlQSEhwd2dhRUk1UUdCSEZsclJvaDFPVUtmQjNwYkhKUmpDUjlWUU1ZQVNI?=
 =?utf-8?B?emkyR3ZzYjBFaVBhanBEaVhNL1RsRzRYdE9pRTUxRHd1Z3BkOWR4Znd5SWNS?=
 =?utf-8?B?enZOZHN1SnFFV3VMR1pqVnBqVnN6ZnFnT21kUUJWQUZ3RU1sL3o2ZkpFUWpn?=
 =?utf-8?B?a0UxcU9BR29UcGYvdzZRNVNxVDgxdmJaaUdIZ1ppbmRQTisrVlJZSGwwTFRH?=
 =?utf-8?B?T3lzZW5ISTh2M1crVGVYTmp5SFBZWm5URXMxUHZVQSsrKys0V0s1T1NzeFNI?=
 =?utf-8?B?dVU4cWFDaWFFQ0VYWGhQR2lqaVBZaXBQNWNPYUlBWEVrTjZib2FWL2xQbHdG?=
 =?utf-8?B?STIxTnd1UUQ2eXNjWTRUTnpXT2c5eTF5bmhmcFF1RHN1SERoQnlZSHZjQlJm?=
 =?utf-8?B?djZnUjZocHRDcTZzTVZ5eS95N0dRd1R0MHg1NUhKd0tsL2cwT3VLdm1NQm9a?=
 =?utf-8?B?clBQNXZxMTB5bUxvRW1UVnZ0YWRkaW5BbW1VQ2kxR29LY2hjeU9BNnVDRXIx?=
 =?utf-8?B?ZlRySWd6MDZ1eDZVVklwZHFUbkZyZCtxYnFzcmlUdDUrYzBsUTVTdytVTXcw?=
 =?utf-8?B?QmxDQ29EdU1mckFVc1NQcVN6UVFENzZSd3FwU2tEekYrSEluY0tPVkNCTzFl?=
 =?utf-8?B?VENoQ29vdnRzRERocm5NSWhybzBBckN1d2NQSmd5VERoaU1SWkd3S1BjZzJ4?=
 =?utf-8?B?T2lEelBGVStNSXA2bmZqTkh5LzhHaG05MGhXb0pCVUY5MjJKTmlHbklXQ0Zz?=
 =?utf-8?B?c0hxV2JJWUVCeTgzUnJkMHVFeGxYWHAxSjB5NWlDSFJ0R3BtdWFhbGJwV0Nk?=
 =?utf-8?B?VG80Y3h2SVJsUlNEajRQTDVGMDFzakpkTmhaNndlb05Bd01jKzdCN29SbG9v?=
 =?utf-8?B?MjdlNUVqYVkvVGNOdnRjYU0yc1Jla00yS3dnZWdCOVN3RTFER3JSZWFGZzhp?=
 =?utf-8?B?TldqY250NjFjeWdpblQxbjlKT3ArNEFBQjlMK2JnODRMZ3gyR2JESXFLUU9w?=
 =?utf-8?B?ZFFVeFptVURDcUd5ZnBLaGxhb0syN1BiZ3BLUUdlT1E2VjE0NEFYcG1yR2c1?=
 =?utf-8?B?WWJmRGhNN3NpSFZ6RUY0WWJaa1cyNmw1ckJwL3BzL0haVmU3MUREUnFGV0dE?=
 =?utf-8?B?YTYzVDU2RTA3UVBRb1pOdEJmZUxqRk1yOWN5ZXorRXMrUlIvbDhDSFQzd3hS?=
 =?utf-8?B?SCtVMFBQTEdsR1hlN0R6bUhLNXpjTSt1Nno0ZU1sbDg5WlR3dDc0andzRzZa?=
 =?utf-8?B?ZWZkQzEwck1RZ1RXM0tnMnhMQXNUbHNQNEN2OVVFSWFZU3NpNk0yU0ZSc2lY?=
 =?utf-8?B?dzMxdGJpK1QvOFNYUW1ENmJNME9HdmhCdzkxaDlNcWxZRkJzRHZpWiszbmV5?=
 =?utf-8?B?NFFYZnpJQk5nN3N2SkwwSmVDRmJLTE9jZEpiVGp5ZnpRWS9Zajc1dFZqbkIz?=
 =?utf-8?B?TE9yOWpScGcvV0h2RmN6OHpXMzBjd2dFMDdyMmRlZXZIQUtWNW5ES1dwZC9i?=
 =?utf-8?B?ci81UjFVaFhHN2ZhZWR2dU1DWWlIKzRmRi9tZjBhWEZHNkRoaS9meHVaUm5s?=
 =?utf-8?B?RzFuclpESWl3eG1ZdGkwNjYvZXFlQy9ReGVsK0RmVTJpQjBIOFZ4K3VHeUpt?=
 =?utf-8?Q?vjoZrCYB8UNWgZG98cw6Y23SbzqdJU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkxHN2FyVkdtdUJSOThiSkZ1dWtZclVyRzRNbXgzQ1M0NHJQWjVvc1ZCRzY4?=
 =?utf-8?B?WjBYa21aZmhWLzdaNDRHRW1IN1M5TG95RURvY053NUtHMmdCSGpBRTdFQ2JL?=
 =?utf-8?B?dm94ekI5ZU1VQkZFN3FvWkFsa1l4UEtBQW4xeXFNaVorTXcrY01wV3l1YU5a?=
 =?utf-8?B?SXpab3lxZHNKNWYwSE91MFpJNjZVeTVURlBFQ1dsbnVhSGZ2NXJicG9LTXBI?=
 =?utf-8?B?YUFXUFNBNFk3NUVpelFXNnIrNlNQN1BaSWFpNkFSTEJadVZ3SEg5T2hGb2M4?=
 =?utf-8?B?WW1adG55WUlyUjhDZ1ZVZk5JdmRJa1F3bldlRmF2RktSbWgyWm52SUIvOTJC?=
 =?utf-8?B?NnhIaktlZVZMMGR0Y0dJMlZLdjZaN095WDNPRGs2T09IaEhXK2RITmhOSWZP?=
 =?utf-8?B?ajAvV0Q0YlcyLzdsdDhiMkl1SGtsMjIwUXlwYWZxNzVtei9VVUVPeER6d1pn?=
 =?utf-8?B?WWFBWGhmTFNaUW5oWnVPSzVFVkVaem51SUR1d0hhNThoSVJDMmFiYzJXeHZS?=
 =?utf-8?B?YXFWNlBTbENYakxzRmZIdndTendLU1pNcG01aFdQOWl1aklVS1d0dWdhMzJv?=
 =?utf-8?B?QWhXQnk0R3kxck85dTNrQ2lXRUFOZWZ0Tyt0UUszd0RZUVlXdnhkcHkzTjFj?=
 =?utf-8?B?c29wK0k3RER2UTR0SGdBcXM2b2g0TG1KS2Zhcnp1VFdUMXpGQkRRV0pJc2ow?=
 =?utf-8?B?TDVOV2FhUmlwVFZsRVY1cVhpVDhIMG9Hcllha3htM3VYYXVUZ0FsYlRZb3BQ?=
 =?utf-8?B?eEpsVmU4cWNRekZZeTFUQlcrWDhUdEpkdXhrbjZ4Ujd0anpGWERJc2VsUlo5?=
 =?utf-8?B?OVJEcm9BWWJobjlPRVVndG82ZGN3S05GdkVndkZyUS84NnRVeS83VzNCSlhI?=
 =?utf-8?B?Mis5end1RDdaVDhXK1hVNWVuRnRUZXB6N0gvMlpTTUU4ZmUzcll6RGNXSnBK?=
 =?utf-8?B?U0tKQkN6WEc5ZFhFaFpYTC9NQmk1WGZGc0c1NlhROUYzUHU2WmJyVkRKYkVQ?=
 =?utf-8?B?elJ6ekhBZURHZm5CMVljeTJWcGRVWThMOGp6MjV1alArcDNCRG5FUjN1UFps?=
 =?utf-8?B?Tm1RZDlGcjQ3dHFHQlY2b3RUT2x6TGpTRjA1eFRPVTBDWEoyYy9wVGJXb1dR?=
 =?utf-8?B?ZUY3UFdVUkxZZXBtR0F5dVkveEFDZXpSd3hkMDc3TTMvTHowTjdrWjU0cWVY?=
 =?utf-8?B?a0hVUGxWWlBqOHFuTHZYUCtvb01USkt1c0FlQVZOOTlZaHZTVGJTaTNlR3I5?=
 =?utf-8?B?aEROT1hENm5qSzBCU3dPMXVLUGlhRXkvNjdqb3dFZHJKeVJ6a0kzSVRuTjRs?=
 =?utf-8?B?R1ZUUWwzdzFIaHhTY052VGpSRkxONXJCSHhXejljRWxTM2h6WXlsK0pvTEpk?=
 =?utf-8?B?UUoweXRoU0V5Q09WeGNIVE9QQWdGSFVic3p6WjErYjBseC9RWnZLTkdBZTBi?=
 =?utf-8?B?WjQyYTFET0dpLzI1eDFaZ1lIQXpTVEppWFZTdXJzQ2lpb3hrMEthNmRrK0R3?=
 =?utf-8?B?bURqQUtqaGJjL204Q2FaL04zdFFaZHd5UjZxRWFwNk1UTlJ1K1Y4TWF1NGxj?=
 =?utf-8?B?ZVhoc2d6N3h3NlRDU0JuTlFPMlFidFBLSnNGWVpwbXlQY1VUWmRLQUdSQnI2?=
 =?utf-8?B?dlIrWXA5U3VCNEQxamh0NW5NTUM5ZjNvN1BRSHBYRTNNLzVKc1VlSytsR3d2?=
 =?utf-8?B?d1c2Y3puc0haSENRK3Jkd0ROQjZPa011RDF2K3VNYnRNajhwdHlkR2dtZHc0?=
 =?utf-8?B?RzcrQ1d5cnJERTZsRTJGaHVyb1dCWXlvQ3JGTy82dE9meWhOQ25HMERMc0JM?=
 =?utf-8?B?L1g2dENRYjBoOVo4cGFuSXFQcGVqaHg0OE9KRXZCaXExaEpuNWtSalZHRlRk?=
 =?utf-8?B?VXl5Ym1xRDJnTEtSUUdReGV1VXkvUW5relQzYnhCK2lacjVwTW8rQnZwYXNI?=
 =?utf-8?B?ZWtKTHRlS3JWbjl0OFptV3U5TmJLbXRqSnJNeklGa2NZN3d0YVVRb1I1NlY0?=
 =?utf-8?B?Y3I2YlFWaS9nV0dRYkphSFFFNUZHT2VwT2djR1ZYWkYzc091aDFZbzlvRGxJ?=
 =?utf-8?B?ZDNxMFhhQVlFS0VKTHJiQUhJNGpsUjVuYVhTMTVjM2JvOW9mYUdKRVljOWxC?=
 =?utf-8?B?Q01Gck56M2ZIUHNtcGZiWnZVQ3NTMkhzeVhtYUU2WGlGS1VCLzdWQWJRbzdG?=
 =?utf-8?B?SlE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4192cb1e-45c6-428c-de05-08dde9604032
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 14:02:55.9466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tEUOj3tErNuu7sbBxQPmlno9ND1YGauynogX/vfj0qmIQ8iwENhtRTlE0rQnE5Gu/0N5BRE3b95C2wVK9WAY37MSgSigU0GRTg1+fyp9Wzp9JtSp8U4JKiU9T/kMYVLU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9057
X-OriginatorOrg: intel.com

SGksDQoNClRoaXMgY29udGFpbnMgYSBmaXJtd2FyZSBvZiBjb3JlOTAgZm9yIEJaLUhSLiBXZSBt
aXNzZWQgaXQgd2hlbiByZWxlYXNpbmcgdGhhdCBjb3JlLg0KDQpQbGVhc2UgcHVsbCBvciBsZXQg
bWUga25vdyBpZiB0aGVyZSBhcmUgYW55IGlzc3Vlcy4NCg0KVGhhbmtzLA0KTWlyaQ0KLS0tDQoN
ClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgOTkzZmYxOWI1NTNjZDRkMjUyZmRm
OTlmMDdjMjg4MjVlZjU3Yjg2MjoNCg0KICBNZXJnZSBicmFuY2ggJ21haW4nIGludG8gJ21haW4n
ICgyMDI1LTA4LTI5IDE3OjEzOjEwICswMDAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQg
cmVwb3NpdG9yeSBhdDoNCg0KICBodHRwOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L2l3bHdpZmkvbGludXgtZmlybXdhcmUuZ2l0IHRhZ3MvaXdsd2lmaS1mdy0yMDI1
LTA5LTAxDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byA5MWZkNWZmYTE1MTBkNmE0
NGM0YWM3MmU4MTgyNDQ4YzEzZGJmODI1Og0KDQogIGl3bHdpZmk6IGFkZCBCei1IUiBGVyBmb3Ig
Y29yZTkwLTkzIHJlbGVhc2UgKDIwMjUtMDktMDEgMTY6NTE6NDkgKzAzMDApDQoNCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
ClJlbGVhc2UgY29yZTkwIGZvciBCei1IUg0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpNaXJpIEtvcmVuYmxpdCAoMSk6
DQogICAgICBpd2x3aWZpOiBhZGQgQnotSFIgRlcgZm9yIGNvcmU5MC05MyByZWxlYXNlDQoNCiBX
SEVOQ0UgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQgKysrKw0KIGlu
dGVsL2l3bHdpZmkvaXdsd2lmaS1iei1iMC1oci1iMC05My51Y29kZSB8IEJpbiAwIC0+IDE1NjM5
OTIgYnl0ZXMNCiAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBpbnRlbC9pd2x3aWZpL2l3bHdpZmktYnotYjAtaHItYjAtOTMudWNvZGUNCg==

