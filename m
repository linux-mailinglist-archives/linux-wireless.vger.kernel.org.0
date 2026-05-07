Return-Path: <linux-wireless+bounces-36067-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IspAV6t/GkNSgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36067-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 17:18:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E84184EAE5C
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 17:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97106300118C
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 15:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1651B3CF695;
	Thu,  7 May 2026 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SEmlTEjh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1783F9F41
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167128; cv=fail; b=kGJ3ZHR20r0QV50nXMgOnTGTGTpU+rG7BWEl3RoVX+3d4YDSDFPBbiizo8R445iNGG2rDq+Su+26wPGqx0ogppZM++TTMJM/8M79Zt+jN5dqYEO7ylzNuGPWP9zYeRkeTQRO34UK7xRO2Sed7Sj1pgyYrEkZfcfeBkFaAd0gc3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167128; c=relaxed/simple;
	bh=EiqP+itKjoLORKpCI9Ki1MJwVJCd9P0IV6nKg8Rdxrg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qMRGuzcnYlnxlj82esOOP41ukEU5kmrowKNns2agMT1KwLcejBmc+ePI5wTLKSegqT5UQtkkBwKB0ZRr2CJNTmiM/A7ZKDSkKWsqnR83AHKnWuHsANc5qOqNFt1uW/O/EAmgrXoaNkLhIFvUBQAjvD06ozcvjbJJ2oxJCW2wxjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SEmlTEjh; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778167126; x=1809703126;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EiqP+itKjoLORKpCI9Ki1MJwVJCd9P0IV6nKg8Rdxrg=;
  b=SEmlTEjhcAcv6WBG0d5cyoP+FFN0skGHjWkkAUYvoZCNfmsW5nYCyZ+x
   E6c+4S0G6dxGN5GGVAsbE+sW6m7YrEJjxI9oNFW/W5Qx6EKILojGfzhVQ
   Ndz+VgJnTGG7jvVqYhAirQk9kxwEEhE42i83Qw87YwBfWnLX5FHY/2rSO
   qD7TYQR+CM+2J79igqra28hKZhOV05vg42gn+P0IE+QuQ5TsU9EsowjAR
   trMmqe/cTWvNpXr4ogAtQbzHSq+ltHi4RG7YOjuzir2MWLS0q6JUv7rfM
   ixqf3/EE5Qx5ov0EVYRxqTkeAAUY9DyHDzFjH6KeJUIGAjqCocJGmydTr
   A==;
X-CSE-ConnectionGUID: LyeKvQBtRqG7v4aSU9ytVw==
X-CSE-MsgGUID: c0/5dPyRR/CS1j8O7kQhNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="89815824"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="89815824"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 08:18:45 -0700
X-CSE-ConnectionGUID: mh6IQlAjTO6frRTDQWfxYg==
X-CSE-MsgGUID: U/oTlpfhTviSKGLPCZtaWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="241491409"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 08:18:45 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 08:18:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 08:18:44 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.30) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 08:18:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4nNbK/aaNz2BoM7mq11quWl2cCuPnpgLH3bbVKmYC+T8ZStZ28OO3jKvMDIHE+iYE+yliyZFIY4SRmfVxK/wLGIeiVK3iF0yQetDnwoaNLFVT4DB2iOLun+MEBTdTZuQydhtr0NKesEQPHoJ+W/yvyq4600gcD84L6/iw0W1i2+wV4qGbOywTa6P97hhhtl4vpPtx4WIZYbgG6aKjHAXkjYEV4ApwM+ciVIYaHO4/k55qxxSo4Zmlg5wkZax7MBFjEbYydlqfRPhmB0SExpf3s5E0bq1z5UA9B+LbuEqkLp1SaLuNbZHurs/aV8qO/LO8zHr4xEQqIwDp0wsU0+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiqP+itKjoLORKpCI9Ki1MJwVJCd9P0IV6nKg8Rdxrg=;
 b=UkRQPC6MIDFJIPpGCFj9GUbqR2qQFPVDD9Gc12FwuJxBnUews3G6qUHCqQh0WsPRXVvO1HsgT3w0IsQI5CFw5HL9nyDqWygjvF3gtajvVyy5/8AXZwdMQqxkKl9SPzFe08rP5zQki8haYHsQzS6eg9ZIbeQayeQGq+9esYm+rNpjeduMEbX5LLGFWsrB2T3SQxl+/1tXEQ0bNGg9v5GuJNXFdW0bwIvgmY5QFtMiax+sw/PPgh9JyxEKB1XTa79vEhG36aQ226nYmsrwoo53W6Y0MGpqEasLTWdwlL+4KRq7bbEKsvpBHL5YNtVzLqubOAFEG9ZGXO0Q4JXSjog+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) by
 CO1PR11MB5170.namprd11.prod.outlook.com (2603:10b6:303:91::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.18; Thu, 7 May 2026 15:18:41 +0000
Received: from DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2]) by DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2%2]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 15:18:40 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Info <info@sunharmonics.co.uk>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Subject: RE: [BUG] iwlwifi: BE201 firmware NMI on Arrow Lake CNVi causes
 multi-CPU soft lockup and concurrent USB URB drops on adjacent devices
Thread-Topic: [BUG] iwlwifi: BE201 firmware NMI on Arrow Lake CNVi causes
 multi-CPU soft lockup and concurrent USB URB drops on adjacent devices
Thread-Index: AQHc3hDlln2WMV79YEaD2aMrgOwm+bYCrLsg
Date: Thu, 7 May 2026 15:18:40 +0000
Message-ID: <DS0PR11MB788083A5DC986CE2FB06485CA33C2@DS0PR11MB7880.namprd11.prod.outlook.com>
References: <kWdQxoT6SOo-L5mFpGiJHBM7kebdAV23ij59C29G99xkAGyyQRSaRO4auPC71zeTyi3EIgHoL-Lz4Fab2DtOCOSb9_vDATBFC0Vy_5mj2wQ=@sunharmonics.co.uk>
In-Reply-To: <kWdQxoT6SOo-L5mFpGiJHBM7kebdAV23ij59C29G99xkAGyyQRSaRO4auPC71zeTyi3EIgHoL-Lz4Fab2DtOCOSb9_vDATBFC0Vy_5mj2wQ=@sunharmonics.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7880:EE_|CO1PR11MB5170:EE_
x-ms-office365-filtering-correlation-id: 4d92dbb2-d09a-4074-6553-08deac4beba4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003|3023799003;
x-microsoft-antispam-message-info: IokLegNZcT/oagKqksgeWZsbGTAW0qvpWbTFO8LxnUfDBxrKcbgUirktsDv4JQtf+msWhqLd0TBit6Z8F2yQUE7+14PwJN3vwfJg1lYwYm1G1zFvsrmlRN97axS5fTnHMwghAu8OiHEh7UrLVvfOz8gXRUJTPiDUoewSs/HjNQWPlTZ8LwD1bR1cd0ARpnSvcq3ux62YPoLQtScLkTep+oyRMaaBbQS7tYyZqqLhjkqbWca360PCeKjvnXjcosa1/8khPeNBQEwXXnOIijObKcV+WHyt4vLoDp2SthV7wSDE0wM0ommZNxRxY60BmivUC/4E5nc0pHo/4AvuKoQi2rwh79Z8L1nQleiyBDjWXTb6q54drfbBG5zUlwWLZeZKt3/vKS9sPCgViLIZ9Fzx5xpHu9caNmsP+hRolEwCD2Qqv+k5MldgrCINZwy2r5sFt8ji0/8cKwFcYlI+/rtwN1evXqlY1Yrv9UMFxXjoKsK9kJyqCBQwp2uBNCeMfW4n1rp3fsqbyQqRivz6CMzvqzxlGBGxeyagT1v63Eap17U+ckW57WCqxLqI9esidOpFbVo1CWAWeUin07LwUzDaQHk8vFYiVZSwWK9ym7/gAd5opCKa+3SVPJnP6QuhlKIVMuPsaj5NFK4rzfQAcuzPp3f31T+CekTrEQeBHFopByVmxelENBBe3m7Q6ALx1Ju2svOW8bX0mPhOcxXGwLv+i1DEflwEnNmJbg6zrTjS/B3dym9/i7E+cjdGnVOaWrc5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003)(3023799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDJxbFFOYzVQVkxkREh1UlFPd2NTTjBYZUN4ZnJKalhyaEQrcTFwbDBWTkpD?=
 =?utf-8?B?Y1hhS0J3a2RycFNCTDlaQWUxYVFxSmJ0aEdibnhtV3lVQ2l4YURIVHZZOGdW?=
 =?utf-8?B?RDVoSVNGMWlFTlMxM3RtdHNtY3RMUGJyNGtQZ1Jma0FML25hdWtHbEljaGRZ?=
 =?utf-8?B?eDVxenREbDNaTVRuVy8yUEdGcXR4VUFiZ3J0YlRZbnJLd3dwUTJCbS9BdTVp?=
 =?utf-8?B?dVpFQURaSzl6RDl3NkVjWEVTWWxMRDNBenRQRG5JMm9SNCtJUEVvVGZLeTlK?=
 =?utf-8?B?ZURzbTNxRUNuc1lFV2g1Zlc4UzEwM1RVRWthSUF6bjVWMW9XTGkvcSs2ZHRw?=
 =?utf-8?B?bTErZWdyc1dDZEJBK2d1aUZvV2FPdDlHaVpPa25Wa2MreGF3blNjemhKUzFG?=
 =?utf-8?B?TnBUejk0dWZXRlRhWGNndXowWVR6Q0RsVXB5MW8yMHFBZ3czLy84dmVCUlNx?=
 =?utf-8?B?VDgwL0hKZ3pRa0EreXpsY1pieEhSN21VMjZ0T2I1TS9TYXpBVENyTldWeEJL?=
 =?utf-8?B?cjNRUTR1a2p4RVhUSnZQUnRDODdWbFNZVCtDdGdrNGhlemRRdWlieHZVTEhF?=
 =?utf-8?B?YVluVkdBL0F3bnZTL09Xa1VDWFdKL2djNkdoeGp1b0JEOWxYUWswcmdrYVFy?=
 =?utf-8?B?b2p6OFpFMlNhYkJMNlN0aitMVlBoeVNKNE5ZZWhIZ1hyVzZueks3RGljRUFM?=
 =?utf-8?B?NjVObFN3U1RGNWpUUWpvWkhpZkI2MDY4dTI0Z3NKZDAxcWNqdUdlZ3JvLysz?=
 =?utf-8?B?L2t6bmc5UDZwRjUrT0dvTndXUkhiZ1c0ZHpsTXgxMnR4bm51a1Qzait5NklL?=
 =?utf-8?B?elpoZGRQS0xCLzRPWVhUcFJMOHRTTGZralI1d2p0bEE3Tk52UlhYVnNiM1lX?=
 =?utf-8?B?ejVCMGZoMUkreWdOUkNFc3MwT20rYVlhM0hMZWxEb1JNTUcwNE1icGNhUW5M?=
 =?utf-8?B?NHhsYk1tSWNJMUxGdzhJVnZCeWgwZXV3N0VQdEV0cElxd05HbGhlNEhlb2sy?=
 =?utf-8?B?dlduTzd4OWlpbmtFVmQwS0o0b0tYeTQwOUNRS3daeWVybnE4czEwRjY1Tlpj?=
 =?utf-8?B?VHpDaW8rSTBrWk10ZFExNG8zSkw3ZVBOMzdRKzRscWtDYlZ3MXd2b1FOU0RY?=
 =?utf-8?B?amllYWRFblJBUmtxRFE4T3FlT05hV00ydktOY2xHSE4rbWpNV2sxNmIzdHBF?=
 =?utf-8?B?ejh4UWZndHQwdm9IOFUvSEVqOUdCQ0J6SStlUjJUWUNRTDkySnQ3NHBHd2lr?=
 =?utf-8?B?dG8rdzFWTGxrMHhUSk5SK3htc3E5ZnA0ci9hNEdaME50UGhpQnlDemFINDAw?=
 =?utf-8?B?U3p6UkhITVlYc0tWc201Ry9BRm5MQUJyamJ3emFudUpYSmVnRXdjb0dFd2ZV?=
 =?utf-8?B?RW5IQUk4ZUVUSmQxTXZubkhkVGlvVmlvT2NwWTFNYUpTNVg5MmxsS3dTRlkw?=
 =?utf-8?B?YVUwWGt0WGlqNWZLdmtmRUpXbWIrYWl4UGxoR2drb3JwWHlTRXhqRXJvTXYv?=
 =?utf-8?B?YjBGQ0w4NXpDbFlJaTZ2SmdNbVFnVU9FZFd0ejlNQXNPcUxDMnNRTXVIODB4?=
 =?utf-8?B?bngzNGVSRllkeVVOblNPY0lCbm1BVDlzS05yckRMYXMveUFMNlBxMkw5VmdQ?=
 =?utf-8?B?ZkxWQUtYMHNMVUwvVzhWOUF0R2RXZ1FvZEwzQ0xzN0lsNWZYM2ExWU1aVlFj?=
 =?utf-8?B?UWswWDQxT3pNeCtYVTRUQ2ExY0xPTy9YMUM4MlhobTdlWGYyVTI1bGRzZDUr?=
 =?utf-8?B?dDcxblErVkZsRGRzNDlGSytyNmRCcXNkaGpwSmZQOXlzODA4Vk5JWHBsSzhM?=
 =?utf-8?B?WTM2TFVucGVXV3Uwb3FIZi8zemtqYnBYUkRiZHVteXgwL0NLOXptSXBPaDNB?=
 =?utf-8?B?MTZCN1oyb2lOK3hvSWV2dG42Mk9BbHRIUk93NXExUEVNUWZWd1pzNU1wdzNw?=
 =?utf-8?B?T2pxd2ptQTN6SGU4RVJTdWZ4b1J5N3Y0MURrbTV2YjFTOE1HeXVIc2pObXpC?=
 =?utf-8?B?M0NFY1ZpWURLbmlLZUdRcFlEdnhqZExoV01Qa2xXWmo4NlFTQXNkRWN0bUJ2?=
 =?utf-8?B?NG15cEZyV2hvQzBQdjR1SmlNYU02QXk1RFZNWTZpN2ZqTTJuS3J0clRTOUdL?=
 =?utf-8?B?WVQ4b28yNzhvVHJNMkVNMG4rVG5BYzRJNHdKQWl1NGZUL0J0TXNmV2VCMkJ2?=
 =?utf-8?B?WDN4aGZvbGMzQk5BdlkyUzE3UlBQOEJQK0lIeXhzUUsydDhHNEpSWnRRdGda?=
 =?utf-8?B?V1FJUUNDbmUzbXJrYkQrQ3VMODFTMElyRDBvSGFTdmFvdUx6enpiMkxKRVF5?=
 =?utf-8?B?ZEUyYmF1aHJTQ2RXaURJb3JMbzUwZ3BWRnNLQUpWY0YyeDJiOTlMRkVyNGdq?=
 =?utf-8?Q?3+WVI1zgBMBRdK3uzJRChM/jRSvYfiTYMy64RXVzhtdRI?=
x-ms-exchange-antispam-messagedata-1: 6CbKggA63/fj/XjIeb8gl457iI5t25fCHyU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wRS/78CKFlr01f3qe3eEM49PD7oaTw6XzbV5VXktDR2Izl99KmqSiSheRwDFBrjsFMUx/jjc9fxE+jqkObYIj2VXHKtXuzokYZbNQHGW6VWWSSU3Ja2/mGw7/auI9I19AmOoyASu6hMi6j8cuUjQgukNNkppBYKWLQl9PLp4fbshpyKWBP5G8VGQgODpeKTbnVMr2X+PfyeY3/eJVRiuopkcjCjhijIVjPmeXBzrgnuac4l+V9llJgdm6GYWPIQk9ZAlnbsWotcVkJHH10AbNVY8eTymHv2qIn9MNmNeai//PCMaoYwoOEhbKIT9OGjzAbFfG+1vbhQXib3a0EraLA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d92dbb2-d09a-4074-6553-08deac4beba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 15:18:40.8913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vVhljQIoHBcoe7/byEOLnuOAcm5Nz0phO7Wc6DU3bnGv+e8IMMDYbHBlqtJlRhUlMRksX91FwgNe/S8YSfXWM4JDkknbZY+MELwHiVOopmg8wodLKU4t8PflYXEkl+Z7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5170
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: E84184EAE5C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36067-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sunharmonics.co.uk:email,DS0PR11MB7880.namprd11.prod.outlook.com:mid];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW5mbyA8aW5mb0BzdW5o
YXJtb25pY3MuY28udWs+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkgNywgMjAyNiAyOjAxIFBNDQo+
IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEtvcmVuYmxpdCwgTWly
aWFtIFJhY2hlbCA8bWlyaWFtLnJhY2hlbC5rb3JlbmJsaXRAaW50ZWwuY29tPjsNCj4gam9oYW5u
ZXNAc2lwc29sdXRpb25zLm5ldA0KPiBTdWJqZWN0OiBbQlVHXSBpd2x3aWZpOiBCRTIwMSBmaXJt
d2FyZSBOTUkgb24gQXJyb3cgTGFrZSBDTlZpIGNhdXNlcyBtdWx0aS0NCj4gQ1BVIHNvZnQgbG9j
a3VwIGFuZCBjb25jdXJyZW50IFVTQiBVUkIgZHJvcHMgb24gYWRqYWNlbnQgZGV2aWNlcw0KPiAN
Cj4gSGkgTWlyaSwgSm9oYW5uZXMsIGFsbCwNCj4gSSdtIHJlcG9ydGluZyBhIHJlY3VycmluZyBp
d2x3aWZpIGZpcm13YXJlIE5NSSBvbiBhbiBJbnRlbCBXaS1GaSA3IEJFMjAxDQo+IChpbnRlZ3Jh
dGVkIEFycm93IExha2UgQ05WaSwgUENJIDgwODY6Nzc0MCkgdGhhdCB0YWtlcyB0aGUgd2hvbGUg
c3lzdGVtIGRvd24NCj4gZm9yIDEwLTM1IHNlY29uZHMgYXQgYSB0aW1lLiBUaGUgY3Jhc2ggaXMg
cmVwcm9kdWNpYmxlIG11bHRpcGxlIHRpbWVzIHBlciBkYXkNCj4gdW5kZXIgb3JkaW5hcnkgaW50
ZXJhY3RpdmUgZGVza3RvcCB3b3JrbG9hZCAod2ViIGJyb3dzZXIsIFZQTiwgbWF0cml4IGNsaWVu
dCwNCj4gdmlkZW8gY29uZmVyZW5jaW5nKS4NCj4gDQo+IEFsc28gZmlsZWQgYXQgUmVkIEhhdCBC
dWd6aWxsYToNCj4gwqAgaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9p
ZD0yNDY3Njc0DQo+IA0KPiBBIG5lYXItaWRlbnRpY2FsIGNhc2Ugd2FzIHJlcG9ydGVkIGluIENh
Y2h5T1MgTGludXggaXNzdWUgIzY3MyB3aXRoIHRoZSBzYW1lDQo+IGZpcm13YXJlIGZhbWlseSAo
dUNvZGUgMTAxLjZlNjk1YTcwLjAsIG9wX21vZGUgaXdsbWxkKSBvbiBkaWZmZXJlbnQgaG9zdA0K
PiBoYXJkd2FyZToNCj4gwqAgaHR0cHM6Ly9naXRodWIuY29tL0NhY2h5T1MvbGludXgtY2FjaHlv
cy9pc3N1ZXMvNjczDQo+IA0KPiANCj4gSGFyZHdhcmUNCj4gPT09PT09PT0NCj4gwqAgU3lzdGVt
OiDCoCDCoExlbm92byBUaGlua1BhZCAyMU5YQ1RPMVdXDQo+IMKgIEJJT1M6IMKgIMKgIMKgTjRN
RVQyOFcgKDEuMTUpIDAyLzI1LzIwMjYNCj4gwqAgQ1BVOiDCoCDCoCDCoCBJbnRlbCBDb3JlIFVs
dHJhIDcgMjY1VSAoQXJyb3cgTGFrZS1VKQ0KPiDCoCBXaS1GaTogwqAgwqAgSW50ZWwgV2ktRmkg
NyBCRTIwMSAzMjBNSHosIGludGVncmF0ZWQgQ05WaQ0KPiDCoCDCoCDCoCDCoCDCoCDCoCDCoDAw
MDA6MDA6MTQuMyDCoDgwODY6Nzc0MCwgc3Vic3lzdGVtIDgwODY6MDBlMA0KPiDCoCDCoCDCoCDC
oCDCoCDCoCDCoENSRiBpZCAweDIwMDE5MTAsIENOViBpZCAweDgwOTMwLCB3ZnBtIGlkIDB4ODAw
MDViMjANCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqBSRiBGTSByZmlkPTB4MjAxMTIyMDANCj4gwqAg
Qmx1ZXRvb3RoIChwYWlyZWQgaGFsZiBvZiB0aGUgQ05WaSk6IEludGVsIDgwODc6MDAzNyBvbiBV
U0IgMy0xMA0KPiDCoCBGaXJtd2FyZTogwqBpd2x3aWZpLWJ6LWMwLTEwMS51Y29kZSAtPiBiei1i
MC1mbS1jMC1jMTAxLnVjb2RlLA0KPiDCoCDCoCDCoCDCoCDCoCDCoCDCoHVDb2RlIDEwMS42ZTY5
NWE3MC4wLCBvcF9tb2RlIGl3bG1sZA0KPiANCj4gU29mdHdhcmUNCj4gPT09PT09PT0NCj4gwqAg
RGlzdHJvOiDCoCDCoEZlZG9yYSA0NCBLREUgUGxhc21hIDYuNi40IFdheWxhbmQNCj4gwqAgS2Vy
bmVsOiDCoCDCoDYuMTkuMTQtMzAwLmZjNDQueDg2XzY0DQo+IMKgIEZpcm13YXJlOiDCoGxpbnV4
LWZpcm13YXJlLTIwMjYwNDEwLTEuZmM0NC5ub2FyY2gNCj4gDQo+IGl3bHdpZmkgbW9kdWxlIHBh
cmFtZXRlcnMgYXQgdGhlIHRpbWUgb2YgdGhlIGNyYXNoDQo+ID09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IMKgIGJ0X2NvZXhfYWN0aXZlOiBZDQo+
IMKgIGRpc2FibGVfMTFheDogwqAgTg0KPiDCoCBkaXNhYmxlXzExYmU6IMKgIE4gwqAgwqAoV2kt
RmkgNyBtb2RlIGlzIGVuYWJsZWQpDQo+IMKgIGZ3X3Jlc3RhcnQ6IMKgIMKgIFkNCj4gwqAgcG93
ZXJfc2F2ZTogwqAgwqAgTg0KPiDCoCB1YXBzZF9kaXNhYmxlOiDCoDMNCj4gwqAgc3djcnlwdG86
IMKgIMKgIMKgIDANCj4gwqAgaXdsbWxkLnBvd2VyX3NjaGVtZTogMg0KPiANCj4gDQo+IFN5bXB0
b20NCj4gPT09PT09PQ0KPiBUaGUgZmlybXdhcmUgTk1JcyB3aGlsZSBpbiBub3JtYWwgdXNlOyBp
d2x3aWZpIHJlcG9ydHMgIkVycm9yIHNlbmRpbmcNCj4gU1lTVEVNX1NUQVRJU1RJQ1NfQ01EOiB0
aW1lIG91dCBhZnRlciAyMDAwbXMiLCBkdW1wcw0KPiBOTUlfSU5URVJSVVBUX1VOS05PV04gLyBO
TUlfSU5URVJSVVBUX0hPU1QgcmVnaXN0ZXJzLCB0aGVuICJ0aW1lb3V0DQo+IHdhaXRpbmcgZm9y
IEZXIHJlc2V0IEFDSyAvIERldmljZSBlcnJvciAtIFNXIHJlc2V0Ii4gUmVjb3ZlcnkgdGFrZXMg
MTEtMjUNCj4gc2Vjb25kcyBwZXIgTk1JOyBldmVudHMgZnJlcXVlbnRseSBjb21lIGluIHBhaXJz
IH4xMC0yMCBzIGFwYXJ0Lg0KPiANCj4gRHVyaW5nIHRoZSBTVyByZXNldCwgdGhlIExpbnV4IG5l
dHdvcmsgZGV2aWNlIHF1ZXVlIGxvY2sgYmVjb21lcyBiYWRseQ0KPiBjb250ZW5kZWQgYW5kIG1h
bnkgQ1BVcyBpbiB0aGUgc3lzdGVtIHNpbXVsdGFuZW91c2x5IGhpdA0KPiBuYXRpdmVfcXVldWVk
X3NwaW5fbG9ja19zbG93cGF0aCB2aWEgX19kZXZfcXVldWVfeG1pdCBhbmQgdHJpcCB0aGUgc29m
dC0NCj4gbG9ja3VwIHdhdGNoZG9nLiBJbiBvbmUgZXZlbnQgMTIgQ1BVcyB3ZXJlIHNvZnQtbG9j
a2VkIGF0IG9uY2UsIGluY2x1ZGluZyB0aGUNCj4gaWRsZS9zd2FwcGVyIHRhc2sgb24gQ1BVIzEz
IChwcmVzdW1hYmx5IGZyb20gaW5jb21pbmcgd2FrZSB3b3JrIGl0IGNvdWxkIG5vdA0KPiBwcm9n
cmVzcykuIEFmZmVjdGVkIHByb2Nlc3NlcyBpbiB0aG9zZSBldmVudHMgaW5jbHVkZWQgdGFpbHNj
YWxlZCAoVFVOKSwgQ2hyb21lDQo+IG5ldHdvcmsgSU8gdGhyZWFkcyAoVml2YWxkaS9UZWFtcyks
IHRoZSBtYXRyaXggY2xpZW50IG5oZWtvLCBzc2gsIGFuZCB0aGUgaXdsd2lmaQ0KPiBJUlEgdGhy
ZWFkcyB0aGVtc2VsdmVzIChpcnEvMTk0LWl3bHdpZmk6MTA0NiwgaXJxLzE5Ni1pd2x3aWZpOjEw
NDgsIGlycS8xOTctDQo+IGl3bHdpZmk6MTA0OSwgZXRjKS4NCj4gDQo+IA0KPiBUaHJlZSBldmVu
dHMgY2FwdHVyZWQgMjAyNi0wNS0wNyBpbiB+OTAgbWludXRlcw0KPiA9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiDCoCAxMDozNDoyMSAtIDEwOjM0OjM4
IMKgIH4xNyBzIMKgIDEyIENQVXMgc29mdC1sb2NrZWQuDQo+IMKgIDEwOjQ4OjM1IC0gMTA6NDk6
MDAgwqAgfjI1IHMgwqAgMTEgQ1BVcyBzb2Z0LWxvY2tlZC4gQ05WaSBVU0IgMy0xMCAoQlQpDQo+
IGRpc2Nvbm5lY3RzLg0KPiDCoCAxMjowNzoyNiAtIDEyOjA4OjExIMKgIH4zNSBzIMKgIFR3byBi
YWNrLXRvLWJhY2sgTk1JcyAxOSBzIGFwYXJ0Lg0KPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBXZWJjYW0gVVJCcyBkcm9wcGVkIGF0IGJvdGggTk1Jcy4N
Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgQVAgZGVh
dXRoZWQgdXMgd2l0aCBSZWFzb24gNiA9DQo+IENMQVNTMl9GUkFNRV9GUk9NX05PTkFVVEhfU1RB
Lg0KPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBVU0Ig
aHViIGRpc2FibGVkIHBvcnQgMTAgd2l0aCBzdXNwZWN0ZWQgRU1JLg0KPiDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBVc2VyIHdhcyBvbiBhbiBhY3RpdmUg
TWljcm9zb2Z0IFRlYW1zIGNhbGwgYW5kIHdhcw0KPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkaXNjb25uZWN0ZWQgbWlkLXNlbnRlbmNlOyBmdWxsIFRl
YW1zIHJlY29ubmVjdA0KPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCB0b29rIH45MCBzIG9uIHRvcCBvZiB0aGUga2VybmVsIG91dGFnZS4NCj4gDQo+IA0K
PiBSZXByZXNlbnRhdGl2ZSBpd2x3aWZpIGVycm9yIGV4Y2VycHQNCj4gPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09DQo+IMKgIGl3bHdpZmkgMDAwMDowMDoxNC4zOiBFcnJvciBz
ZW5kaW5nIFNZU1RFTV9TVEFUSVNUSUNTX0NNRDogdGltZSBvdXQgYWZ0ZXINCj4gMjAwMG1zLg0K
PiDCoCBpd2x3aWZpIDAwMDA6MDA6MTQuMzogTG9hZGVkIGZpcm13YXJlIHZlcnNpb246IDEwMS42
ZTY5NWE3MC4wIGJ6LWIwLWZtLWMwLQ0KPiBjMTAxLnVjb2RlDQo+IMKgIGl3bHdpZmkgMDAwMDow
MDoxNC4zOiAweDAwMDAwMDg0IHwgTk1JX0lOVEVSUlVQVF9VTktOT1dODQo+IMKgIGl3bHdpZmkg
MDAwMDowMDoxNC4zOiAweDIwMDAwMDY2IHwgTk1JX0lOVEVSUlVQVF9IT1NUDQo+IMKgIGl3bHdp
ZmkgMDAwMDowMDoxNC4zOiAweDY2QTAwMDAwIHwgRlNFUV9FUlJPUl9DT0RFDQo+IMKgIGl3bHdp
ZmkgMDAwMDowMDoxNC4zOiAweDAwMDAwQjAzIHwgSU1ML1JPTSBlcnJvci9zdGF0ZQ0KPiDCoCBp
d2x3aWZpIDAwMDA6MDA6MTQuMzogdGltZW91dCB3YWl0aW5nIGZvciBGVyByZXNldCBBQ0sgKGlu
dGFfaHc9MHg0LA0KPiByZXNldF9kb25lIDEpDQo+IMKgIGl3bHdpZmkgMDAwMDowMDoxNC4zOiBE
ZXZpY2UgZXJyb3IgLSBTVyByZXNldA0KPiDCoCBpZWVlODAyMTEgcGh5MDogSGFyZHdhcmUgcmVz
dGFydCB3YXMgcmVxdWVzdGVkDQo+IMKgIGl3bHdpZmkgMDAwMDowMDoxNC4zOiBIQ01EX0FDVElW
RSBhbHJlYWR5IGNsZWFyIGZvciBjb21tYW5kDQo+IFNZU1RFTV9TVEFUSVNUSUNTX0NNRA0KPiDC
oCBpd2x3aWZpIDAwMDA6MDA6MTQuMzogcmVzdGFydCBjb21wbGV0ZWQNCj4gDQo+IENvbmN1cnJl
bnQgc29mdGxvY2t1cCBiYW5uZXIgKHRydW5jYXRlZCkNCj4gPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQ0KPiDCoCB3YXRjaGRvZzogQlVHOiBzb2Z0IGxvY2t1cCAtIENQ
VSMxMCBzdHVjayBmb3IgMjZzISBbaXJxLzE5Ni1pd2x3aWZpOjEwNDhdDQo+IMKgIHdhdGNoZG9n
OiBCVUc6IHNvZnQgbG9ja3VwIC0gQ1BVIzEzIHN0dWNrIGZvciAyNnMhIFtzd2FwcGVyLzEzOjBd
DQo+IMKgIHdhdGNoZG9nOiBCVUc6IHNvZnQgbG9ja3VwIC0gQ1BVIzcgwqBzdHVjayBmb3IgMjZz
ISBbbmhla286NTA2MV0NCj4gwqAgVGFpbnRlZDogW0xdPVNPRlRMT0NLVVANCj4gwqAgSGFyZHdh
cmUgbmFtZTogTEVOT1ZPIDIxTlhDVE8xV1cvMjFOWENUTzFXVywgQklPUyBONE1FVDI4Vw0KPiAo
MS4xNSkgMDIvMjUvMjAyNg0KPiDCoCBSSVA6IDAwMTA6bmF0aXZlX3F1ZXVlZF9zcGluX2xvY2tf
c2xvd3BhdGgrMHgyNTEvMHgzMDANCj4gwqAgQ2FsbCBUcmFjZToNCj4gwqAgwqAgX3Jhd19zcGlu
X2xvY2srMHgyOS8weDMwDQo+IMKgIMKgIF9fZGV2X3F1ZXVlX3htaXQrMHg3YzMvMHg5ZjANCj4g
wqAgwqAgaXBfZmluaXNoX291dHB1dDIrMHgyNDEvMHg1ZjANCj4gwqAgwqAgaXBfb3V0cHV0KzB4
NjMvMHgxMTANCj4gwqAgwqAgX19pcF9xdWV1ZV94bWl0KzB4MTZkLzB4NDYwDQo+IMKgIMKgIF9f
dGNwX3RyYW5zbWl0X3NrYisweDkyMy8weDllMA0KPiDCoCDCoCB0Y3Bfd3JpdGVfeG1pdCsweDUz
OC8weGI3MA0KPiDCoCDCoCBfX3RjcF9wdXNoX3BlbmRpbmdfZnJhbWVzKzB4MzcvMHgxMTANCj4g
wqAgwqAgdGNwX3NlbmRtc2dfbG9ja2VkKzB4NWM5LzB4MTI3MA0KPiDCoCDCoCB0Y3Bfc2VuZG1z
ZysweDJmLzB4NTANCj4gwqAgwqAgX19zeXNfc2VuZHRvKzB4MjI5LzB4MjQwDQo+IA0KPiANCj4g
Q29sbGF0ZXJhbCBkYW1hZ2Ugb24gYWRqYWNlbnQgVVNCIGRldmljZXMgKGV2ZW50IDMsIG1pZC1U
ZWFtcy1jYWxsKQ0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KPiA9PQ0KPiDCoCAxMjowNzoyNiBpd2x3aWZpOiBFcnJv
ciBzZW5kaW5nIFNZU1RFTV9TVEFUSVNUSUNTX0NNRDogdGltZSBvdXQgYWZ0ZXINCj4gMjAwMG1z
DQo+IMKgIDEyOjA3OjI2IGl3bHdpZmk6IHRpbWVvdXQgd2FpdGluZyBmb3IgRlcgcmVzZXQgQUNL
DQo+IMKgIDEyOjA3OjI2IGl3bHdpZmk6IERldmljZSBlcnJvciAtIFNXIHJlc2V0DQo+IMKgIDEy
OjA3OjM2IHV2Y3ZpZGVvIDMtOToxLjE6IEZhaWxlZCB0byByZXN1Ym1pdCB2aWRlbyBVUkIgKC0x
KSDCoCDCoCDCoCDCoDwtIHdlYmNhbQ0KPiBkcm9wcGVkDQo+IMKgIDEyOjA3OjM3IGl3bHdpZmk6
IHJlc3RhcnQgY29tcGxldGVkDQo+IMKgIDEyOjA3OjQ1IGl3bHdpZmk6IEVycm9yIHNlbmRpbmcg
U1lTVEVNX1NUQVRJU1RJQ1NfQ01EIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC0gc2Vjb25kDQo+
IE5NSSA4IHMgbGF0ZXINCj4gwqAgMTI6MDc6NDUgaXdsd2lmaTogRGV2aWNlIGVycm9yIC0gU1cg
cmVzZXQNCj4gwqAgMTI6MDg6MDEgdXZjdmlkZW8gMy05OjEuMTogRmFpbGVkIHRvIHJlc3VibWl0
IHZpZGVvIFVSQiAoLTEpIMKgIMKgIMKgIMKgPC0gd2ViY2FtDQo+IGRyb3BwZWQgYWdhaW4NCj4g
wqAgMTI6MDg6MDEgaXdsd2lmaTogcmVzdGFydCBjb21wbGV0ZWQNCj4gwqAgMTI6MDg6MDEgd2xw
MHMyMGYzOiBkZWF1dGhlbnRpY2F0ZWQgZnJvbSA8YnNzaWQ+IChSZWFzb246DQo+IDY9Q0xBU1My
X0ZSQU1FX0ZST01fTk9OQVVUSF9TVEEpDQo+IMKgIDEyOjA4OjAzIHVzYiB1c2IzLXBvcnQxMDog
ZGlzYWJsZWQgYnkgaHViIChFTUk/KSwgcmUtZW5hYmxpbmcuLi4gwqAgwqA8LSBCVCBjaGlwDQo+
IGVsZWN0cmljYWwgZmF1bHQNCj4gwqAgMTI6MDg6MDMgdXNiIDMtMTA6IFVTQiBkaXNjb25uZWN0
LCBkZXZpY2UgbnVtYmVyIDUNCj4gDQo+IFRoZSB3ZWJjYW0gKFVTQiAzLTkpIGlzIG9uIGEgZGlm
ZmVyZW50IFVTQiBkZXZpY2UgdGhhbiB0aGUgQ05WaSBCbHVldG9vdGggKFVTQg0KPiAzLTEwKSAt
IHRoZXkgc2hhcmUgb25seSB0aGUgeEhDSSBjb250cm9sbGVyLiBUaGUgd2ViY2FtIFVSQiBmYWls
dXJlcyBhcmUNCj4gY29uY3VycmVudCB3aXRoIHRoZSBpd2x3aWZpIE5NSSBpdHNlbGYsIG5vdCB3
aXRoIHRoZSBCbHVldG9vdGggZGlzY29ubmVjdCwNCj4gc3VnZ2VzdGluZyB0aGF0IHRoZSBpd2x3
aWZpIE5NSSBoYW5kbGVyIC8ga2VybmVsIHdvcmsgcGlsZSBkdXJpbmcgdGhlIFNXIHJlc2V0IGlz
DQo+IHN0YXJ2aW5nIFVTQiBVUkIgY29tcGxldGlvbnMgb24gYWRqYWNlbnQgZGV2aWNlcy4NCj4g
VGhlICJkaXNhYmxlZCBieSBodWIgKEVNST8pIiBvbiB1c2IzLXBvcnQxMCBpcyBhbHNvIG5vdGFi
bGUgLSB0aGF0IGlzIGEgaGFyZHdhcmUtDQo+IGxldmVsIHNpZ25hbCBmcm9tIHRoZSB4SENJIGh1
Yiwgc3VnZ2VzdGluZyB0aGUgQ05WaSBpcyBlbGVjdHJpY2FsbHkgbWlzYmVoYXZpbmcNCj4gZHVy
aW5nIHRoZSBTVyByZXNldCBhbmQgbm90IGp1c3QgY29uZnVzaW5nIHRoZSBzb2Z0d2FyZS4NCj4g
DQo+IA0KPiBXb3JrYXJvdW5kcyB0cmllZCBzbyBmYXINCj4gPT09PT09PT09PT09PT09PT09PT09
PT09DQo+IE5vbmUgYXBwbGllZCB5ZXQuIFR3byBhcmUgd2lkZWx5IGNpdGVkIGluIGRpc3RybyBm
b3J1bXMgZm9yIHRoaXMgZmlybXdhcmUNCj4gZmFtaWx5Og0KPiANCj4gwqAgMS4gZXRodG9vbCAt
SyB3bHBYc1kgdHNvIG9mZiBnc28gb2ZmIGdybyBvZmYNCj4gwqAgwqAgwqAoY2l0ZWQgYXMgdGhl
IGFjdGl2ZSBtaXRpZ2F0aW9uIGluIENhY2h5T1MgaXNzdWUgIzY3Mzsgc3VzcGVjdGVkDQo+IMKg
IMKgIMKgYnVnIGluIGZpcm13YXJlIFRTTyBzZWdtZW50IGhhbmRsaW5nIG9uIHRoZSBCei9CZSBw
bGF0Zm9ybSkuDQo+IMKgIDIuIGl3bHdpZmkuZGlzYWJsZV8xMWJlPTENCj4gwqAgwqAgwqAoZm9y
Y2VzIFdpLUZpIDYvNkU7IHJlbW92ZXMgdGhlIHRyaWdnZXIgZW50aXJlbHkgLSBoZWF2aWVyIGhh
bW1lcikuDQo+IA0KPiBJIGFtIGhhcHB5IHRvIHJ1biBlaXRoZXIgb2YgdGhlc2UgYW5kIHJlcG9y
dCB3aGV0aGVyIHRoZXkgc3VwcHJlc3MgdGhlIE5NSSwgYW5kDQo+IHRvIGFwcGx5IGFueSB0ZXN0
IHBhdGNoZXMgeW91IGhhdmUgaW4gZmxpZ2h0LiBJIGNhbiBhbHNvIHJlcHJvZHVjZSBvbiBkZW1h
bmQgYXQNCj4gdGhpcyBwb2ludCAtIHRoZSBldmVudHMgYXJlIGZyZXF1ZW50Lg0KPiANCj4gDQo+
IExvZ3MgYXR0YWNoZWQNCj4gPT09PT09PT09PT09PQ0KPiDCoCBpd2x3aWZpLWJ6LW5taS1zdW1t
YXJ5LnR4dCDCoCBwcnVuZWQgc3VtbWFyeSBvZiB0aGUgdGhyZWUgZXZlbnRzIG9uIDIwMjYtMDUt
DQo+IDA3DQo+IMKgIGl3bHdpZmktYnotbm1pLWZ1bGwudHh0IMKgIMKgIMKgZnVsbCBkbWVzZyBm
cm9tIHRoZSAxMDozMC0xMDo1MCB3aW5kb3cgd2l0aCBhbGwNCj4gwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmaXJtd2FyZSByZWdpc3RlciBkdW1wcyAodUNv
ZGUvTk1JIHJlZ2lzdGVyIHN0YXRlLA0KPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoEZ1bmN0aW9uIFNjcmF0Y2ggdmFsdWVzLCBGU0VRX0VSUk9SX0NPREUs
DQo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgSU1ML1JP
TSBlcnJvci9zdGF0ZSkgZm9yIGNvcnJlbGF0aW9uIGFnYWluc3QNCj4gwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmaXJtd2FyZSBpbnRlcm5hbHMNCj4gDQo+
IEhhcHB5IHRvIHByb3ZpZGUgYWRkaXRpb25hbCBkYXRhOiBmdWxsIHN5c3JlcG9ydCwgZnd0cywg
aXdsLWRlYnVnLXlveW8gY2FwdHVyZXMsIG9yDQo+IGFueXRoaW5nIGVsc2UgeW91IGFzayBmb3Iu
DQo+IA0KPiBUaGFua3MsDQo+IEl2YW4NCg0KQ2FuIHlvdSB0cnkgdG8gYXBwbHkgaHR0cHM6Ly9w
YXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXdpcmVsZXNzL3BhdGNoLzIwMjYwNDA1
MDU0MTQ1LjEwNjQxNTItMy1jb2xlQHVud3JhcC5ycy8gYW5kIGNoZWNrIGlmIGl0IHN0aWxsIGhh
cHBlbnM/DQoNCk1pcmkNCg==

