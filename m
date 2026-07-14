Return-Path: <linux-wireless+bounces-39114-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aS3cN5N8VmrO7AAAu9opvQ
	(envelope-from <linux-wireless+bounces-39114-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:14:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF01757C5C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:14:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=bBMTtgpH;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39114-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39114-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F1F23026A84
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 18:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3A53CAA55;
	Tue, 14 Jul 2026 18:10:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003C13128AB;
	Tue, 14 Jul 2026 18:10:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052607; cv=fail; b=X47BKVI34kVbO3UeWEy+4btHiUTzMw1Z0PMd739zlUm842QrfS31EM+F90gaPsV6PJVSPhKKtqWJ/wxFg6TuLnu1Nh4aIu6wjy1P5d9l1+elxhbc2rQpVB5zRdaFsAPHvSr6mXsRIFCFabIAU0TaFpuTcgsbHJGwJD3BSpt1Ifc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052607; c=relaxed/simple;
	bh=a+85M2NujhrrS3IB3vIeVM5iSuU8QzN4BsAsDHaJJCk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UuJ6O1C1oiPRzzZ8u8ObPmNN64tWSKOTH2MBT3mAWhcSbp8TooHYYfHZNBej1XlwncCdJJYVYWCgU0WB87nznjGCLj3Nsqc0jjPw0+iAlIcN7cJ+m24sU6Xwptee1c9WpO1uETyS20c40t8aQ5EHpZd31PeHj7Vpu+0+gjZwFVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bBMTtgpH; arc=fail smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784052606; x=1815588606;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a+85M2NujhrrS3IB3vIeVM5iSuU8QzN4BsAsDHaJJCk=;
  b=bBMTtgpHnzVgztB5leUsnWRpESSBzSJwob8YHX9z3Vm4NPnambgkxB7j
   7dzW9exC+mWOpd25LE2JPuIFQlYs63o7txvolaA+qvEDzGY6Niz3DmXO7
   +pazvKaJm7n5wFXf9nDkm+1NJ2T202etnXgG5BZjDHFtjHYD5NEJUIMpq
   fpPk4GnvGh/VuOEEN66JsciR9PbAfAnpdyFbi/yxKBIJr6pE6Avo4Du9k
   cZwahoBgP6vMy/UYgsC5lQ2cRrsXUGGNcN21HVenQq8BDMyIGd2Ks1tV3
   DoO5ZrHdAwM5C5XIjVGMN5LAoQnaQ1ZlTUG6YmRoWAicfuMbLYHs1Cdfi
   w==;
X-CSE-ConnectionGUID: FvrPHREkTQqxefryfpUy8g==
X-CSE-MsgGUID: 0h5QK7fsQ4Koef5l/QMv1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="107477675"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="107477675"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:10:05 -0700
X-CSE-ConnectionGUID: zz53F98wRJSkwYwCLxwGvg==
X-CSE-MsgGUID: pLtWP7K3RXWtCtrNaQKqSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="259508081"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:10:05 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 11:10:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 11:10:05 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.69) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 11:10:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1iiZGYCQMQm1eL/Wmj7tfHmhrfgH2iWD7qUsVHTGVr8TublDo+TugdMoy1o21dx0jIRSH2ECkE28n8WWNwc8uJ5E7Ihivvm2llCWDUmr11AsymGrcONh53oUHBXH1bWRDYs37xrhw8UYyssVG8AoxuWDGU+PwldKnI3ybeNU8dJA3l4PDvq4BbJryPpixIyz9oQeuZA/bzrUaCKaGShwnBS97PYfxjjdu1J6Xf6moplLqGKG98AF+lZaAmMPCbSmco9TS0PshVqLvL/HgIokr0kq4P/RcJ2uMaxSGzT1vYQKyxZ4SdQ2fbQmqcfXF1BiYj1DbL13MizOZ0hklzZCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+85M2NujhrrS3IB3vIeVM5iSuU8QzN4BsAsDHaJJCk=;
 b=y5wfRI3lE1CfPxXLNlIUrk+/AWt7u3u2MnJBtyvPxkGLc6rCztnRiwwzjWjwkP7zPmZ6qBuBN7iE/rer00+MDZ8kxx30odI1LB6XTmpa+qEaV36c+Sv5S6edLKZbK9r4AUXgAHwTV+5U4hRuoJ2k7AqXN+tJwzeSZcYnDWgRhT7tuobyxz2uUlxoUiXugH6EPN4J+b/9CBEehI6jxjqMpgDd5Gt88qEszGeFi5QJX5kxLus68szYd6HSCWaBwVLwLG7T997vErDq03h+7t47gRM6zmN0K2dJxskBHDAEG24FCRf8+i6TVlROvdsZdhbeAIeZ7lg5n9c8ZhouwFCIRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) by
 DM4PR11MB6144.namprd11.prod.outlook.com (2603:10b6:8:af::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.19; Tue, 14 Jul 2026 18:10:00 +0000
Received: from DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2]) by DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2%2]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 18:10:00 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
CC: "open list:INTEL WIRELESS WIFI LINK iwlwifi"
	<linux-wireless@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: iwlwifi: validate PNVM SKU TLV length
Thread-Topic: [PATCH] wifi: iwlwifi: validate PNVM SKU TLV length
Thread-Index: AQHdCGFF/SIO8uz9+kKHC+Y1t4oSxbZtZyJw
Date: Tue, 14 Jul 2026 18:10:00 +0000
Message-ID: <DS0PR11MB7880720FCA2A39F400D09354A3F92@DS0PR11MB7880.namprd11.prod.outlook.com>
References: <2026063008044943.4-ccfa108-0019-wifi-iwlwifi-validate-PNVM--pengpeng@iscas.ac.cn>
In-Reply-To: <2026063008044943.4-ccfa108-0019-wifi-iwlwifi-validate-PNVM--pengpeng@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7880:EE_|DM4PR11MB6144:EE_
x-ms-office365-filtering-correlation-id: 63feebf8-362b-484a-1873-08dee1d31eeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|38070700021|56012099006|11063799006;
x-microsoft-antispam-message-info: s20qWbBeyUmNww34rmgSoaU/NDMQ0OLggrGXwPO6Jp65L9i5qyiVKeT2DcL0+ummI+49kzdJCAPvW8pIuL977ufXh16AQ63QMD5gAlMFbSE6NClfnc9qTnlNsttOCm3rrA5lwRcfY+x45J2HhbDh7fOyw4t0RROmfW76/I3dcZ5dhiSmqF7iag9nS33o9F6xSr8BgJ2NBDv/raM54bUpVU00Ec+PluI+yZYVgxuwFTIQr8IhLURUC7nSVA89F3RzIPDfEQNF6OjvaTT2qq4OMWbkOAjTxWegMd+wOWPJklP7h4v4F6Tnb5lclOLTGu950wMYO0emKql2bQinct+1JXePFKnL3rwJ2wLPzYfy0WQItMaA+qZ4AutNcM835T4gJk160tU1g6xvYAmtJWH8Z0fbv/tcJtAlFAUOEGJeqgeFcmjDZmxEoof69J7bZhnEGZCJavDa67dAcpHlTZVPUglE1f0s7HB5GBI9bwekK5vjgGLUYgl3LcQ4C+umS7kp9TuQdJ4lPMERChxPwPM791FovQdUVlQUuSg+V0RmRdq1r1io8/FpgfVTmz6g26TdZr2FLqRrqFqk/tENopnWIG8KOH3qAniW/mkDlnZqV4VeAROFTivOsKMsUB/c8+Aj/XZdGio1gcjAw3jTQmtlYhVer21x0Fei67Bq4obU0qApaBB6pDJZ+ucua/oRTHdGa08u6R68o9R0EfAI/sTtB3ueOV8C6tI1cTZmTdgdEOs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(38070700021)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zlh2NjJiWnlDWnVvWW9wKzR0bFJZWHNnWnM0UHpsMVE0ZythWSs1Yk5Db3lU?=
 =?utf-8?B?NUxCT0pGQ0NiMEtWRTRTT3BjaDUrdU8wcWJCTWFzajVhS1UyajNQSzNDSnRL?=
 =?utf-8?B?Z1hKWndYZEF2OTRhZ2dBcE9ocDVOUGMrYVhKZFFUdmtzQUgvbEVDVktDblNl?=
 =?utf-8?B?VW42ajNOcGZoQWZtT0FCaE0zWWJEWWF3bjZpd3l0bU5hYTgyb3ROdUlYcjZm?=
 =?utf-8?B?L2YvdTVYUmdqaUhzWWQyVjVuL2NSKzhOQ2YvRVFyUVI5T0FLa081N3dUOXhr?=
 =?utf-8?B?TUJqZXhuSEtyUWdXc21tTkg4VnhzWHB4QzhhVTh1aHlBTnYvcDNFMTlTMHdo?=
 =?utf-8?B?Y1dxem84NkNuaG91RFZFRHlZUDBRcHNIU2ZDRGV6WFk4c2xsMUJxV25wMnVl?=
 =?utf-8?B?TUJQSXFCNUVLY1RBSHlQdDlpODMvZkRycm8zeUJzMUJwSk5QWHI4UVZML2Jw?=
 =?utf-8?B?UW5iQVhnNmh5QnYrRlF1WkIxSjBONkdZaHREcHIxUi9zdkFxZmJidUQyTlQz?=
 =?utf-8?B?eHBMUUNOdndkWVpmVzZ6UVc2czlVVTAzcG1SaS9nTDd0R2V0MDk4ZFJGQ0Z6?=
 =?utf-8?B?WEtSR0EybFBSNWQ2V1E5S2FTTklBYzh2ZDZ3TTJTcFZuL0lhNGQyVDRZamk1?=
 =?utf-8?B?U2tOTVo3QmFkVFdDNjhUNWt0c0hDVFZCMldyQlJhU2g1THZwMjJ2THQ4d3g4?=
 =?utf-8?B?M1Q3a0hZMlorOXZ6Y3VkSGFueFdkbHd3SzlGWFJJRFUwR2ZrVERXTnNkblV6?=
 =?utf-8?B?QTJZaHJ0a29iRWEyemVCbjNHOEFwditKMlpScVhkcmFWUlhMV1daVE5UdmVM?=
 =?utf-8?B?OGg2SzNBamp2eENRd0pLRWYxY0NEeUp4QVRHbkxaeW9lTmNoN0MrQ3c3TkRX?=
 =?utf-8?B?SFRxbldnQ2htMmtXQkVZeTlKQm9zNGk3N3VZbVh4WFNWdkI3aDBqbFB1K0Ru?=
 =?utf-8?B?dzZ1bGlKWXNub3AwNFhiUGNtcTlrMm4wdzVIZCszRnllRkxRajQ3akNrNUdN?=
 =?utf-8?B?WVM0VWNJRUQwUDhuRjlBRVExSmRXejhJVjJaZjczMzkzTkwvWElhclZFbjVo?=
 =?utf-8?B?a2tWUURyV3ZlQlBQaVRXTVdhaEw5ZjNJcW5qem4yOS9aR3ZvN3FXRXBTUFVm?=
 =?utf-8?B?WTMrU2JEcDZNdm1Ka240YnNFVHZ5dkF6TE00dGpHVS9ublZPOVpVNXBxeVJs?=
 =?utf-8?B?TllReGlCdlg4cmhPSVZQOFpjWVRiazNiRmQ3eGhiU1pNWUNBZmxWK1ZiK3JZ?=
 =?utf-8?B?TzdEL2d5ZHhRTzhBeTNsaktSb3o1RkkxOVo4MnFrdjRVNkZIbWJ3dGtDcXZB?=
 =?utf-8?B?ZXhEM0RmZlRLOHhiaUcxdHlaSHFJdHkzQ3F5ZGFBZENBUXNnT2NwSi9xTmpq?=
 =?utf-8?B?Q1Z2VUZXTC8rKytQbi9uVW5XTXc3V3d3Z21ETlZrWWRwcERFZURTdXJrWjJM?=
 =?utf-8?B?WC9TYTU2ZDFFWVphK2hhMWVIN1IrOGxtbW9ER3UwRk90eEJtbXVHZmFSM3lL?=
 =?utf-8?B?enkxamRhRDVteDRCWE5Bd1hidTBhSGl2WTRNVGJPQlNuTnhvOEU2QkRCNTJj?=
 =?utf-8?B?RDliZ3Z4eHRjUDB0MWNEc01MRlArM0lWdDRuS01VV3U3OWRkMGxPeGdvYW1P?=
 =?utf-8?B?a0g4aktnSW5WVi90WnArYnpaK1UzUFpocCt2WmRBQ0hudHRDTHVuZkFjbkJt?=
 =?utf-8?B?cnZ3SjM1eC96ekkzRWY5aE9sZDI0K2szZnozY05Oc2xXM01CdlQ5dGN5UTJM?=
 =?utf-8?B?QzM4VytEZ2lRc0Q1UFBxNDgvQlhKamVTV1BVSm9Udk9oUWxNcGFWM1phN3Y3?=
 =?utf-8?B?djc0TUtvNXZlYzhLbzVzTjNaTEdja0FyRmlVaTFkUEwrdEZUeGJYZEVEY2hW?=
 =?utf-8?B?MStJUWF1VEVyZWxWNUoxVkVvZ1lGMWpzVkRyaEZ0Vm9xWUFwdWRhajVxS3g3?=
 =?utf-8?B?TWRPNElrMVV4MEtjendkczdoR3BiRUJvRkhvdzBSSXV2U2dKdWt3ZktYQUgv?=
 =?utf-8?B?czRjM1RFMXpBd0NVQlczMGdqeTlYUjFuOXlRWTZzTm1tdDZITWw0ejRUNisy?=
 =?utf-8?B?Zy91cG5JRElZMXpORllJTFRETFhMN2kzM01lM01UTmF5b2lvYUtCY1crbFhu?=
 =?utf-8?B?Q0kxRlNJVlJ6VW1rb1JmSkJSVkt6cm5MRjVEMjBqaXNRK3RCR3c3WitWSmZq?=
 =?utf-8?B?bk5TbUJmdGRBemVXbVVybHVtTFg5emdmLzU1bkxmTW9MNDVleW9KRjhlb0Ev?=
 =?utf-8?B?RTdKby96a2ZpL0Vvd0xHbmVEK3hPRWlqSnpybU1OVEtUbGkxVlhSN2NoYTdW?=
 =?utf-8?B?Qi9zekdNQkFyVXljK0YxSllxMFJybWIwT0Y4dFNzTnE4cGVMVU9vVnVMY1RM?=
 =?utf-8?Q?ODMjzQiPYFYFRPaE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T9ffTF+NuTkWPCpUw4GSpX4nk+R64i7lEvw7UG0IxIKHdn4X6SkrVyRmlrsCubujNk0A2AjhmLnXG2kY24KrGvXXwgh/DcCxqaXvdvbcH2ZMG1IizXmx7ihfnXPxBvGY+8m6PNwICa+4lxV2XqRlB9A5U9sgoUKX3r4S5cKy01eB7380SQLkWO3QslSC5vOGTRxtNCUqIavqIRZgFpsEsrBcpbt0SU+/CrCyIYUCi5NOh3EnmWAd30TjLF1AjsMbtWtndCU426LebYU74R+fmy7WLl3o8zSBRRSM1fdOTfSuYyPJKWSaAoX9St+oX+Ovjmdtt2n7lAAQZHElTt63kQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63feebf8-362b-484a-1873-08dee1d31eeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 18:10:00.5735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mvXmrNq5/LtPAoZDAkaZSmKn87lfsVFsHQJmDt7CjHMI3bCRPs6MZ5YP/ymnKrxfat+NNYrgG7RwC7SdQSQj5S6S4s2oiueNcKnoq6hIGNafopjKvC3w+Q1cJYYKmKI7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6144
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.06 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-39114-lists,linux-wireless=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:from_mime,intel.com:email,intel.com:dkim,DS0PR11MB7880.namprd11.prod.outlook.com:mid,iscas.ac.cn:email,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1EF01757C5C

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGVuZ3BlbmcgSG91IDxw
ZW5ncGVuZ0Bpc2Nhcy5hYy5jbj4NCj4gU2VudDogVHVlc2RheSwgSnVuZSAzMCwgMjAyNiAxMDoy
MiBBTQ0KPiBUbzogS29yZW5ibGl0LCBNaXJpYW0gUmFjaGVsIDxtaXJpYW0ucmFjaGVsLmtvcmVu
YmxpdEBpbnRlbC5jb20+DQo+IENjOiBvcGVuIGxpc3Q6SU5URUwgV0lSRUxFU1MgV0lGSSBMSU5L
IGl3bHdpZmkgPGxpbnV4LQ0KPiB3aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc+OyBvcGVuIGxpc3Qg
PGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBQZW5ncGVuZw0KPiBIb3UgPHBlbmdwZW5n
QGlzY2FzLmFjLmNuPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIHdpZmk6IGl3bHdpZmk6IHZhbGlkYXRl
IFBOVk0gU0tVIFRMViBsZW5ndGgNCj4gDQo+IGl3bF9wbnZtX3BhcnNlKCkgcmVhZHMgdGhyZWUg
U0tVIHdvcmRzIGZyb20gSVdMX1VDT0RFX1RMVl9QTlZNX1NLVQ0KPiBUTFZzIGFmdGVyIG9ubHkg
Y2hlY2tpbmcgdGhlIGdlbmVyaWMgVExWIGxlbmd0aC4NCj4gDQo+IEFkZCBhIHR5cGUtc3BlY2lm
aWMgbWluaW11bSBwYXlsb2FkIGxlbmd0aCBjaGVjayBiZWZvcmUgcmVhZGluZyB0aGUgU0tVIHdv
cmRzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGVuZ3BlbmcgSG91IDxwZW5ncGVuZ0Bpc2Nhcy5h
Yy5jbj4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L3Bu
dm0uYyB8IDYgKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9wbnZt
LmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L3Budm0uYw0KPiBp
bmRleCBhZmZmOGQ1Li5mNjFlNjliIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL2Z3L3Budm0uYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9p
bnRlbC9pd2x3aWZpL2Z3L3Budm0uYw0KPiBAQCAtMTk4LDYgKzE5OCwxMiBAQCBzdGF0aWMgaW50
IGl3bF9wbnZtX3BhcnNlKHN0cnVjdCBpd2xfdHJhbnMgKnRyYW5zLCBjb25zdA0KPiB1OCAqZGF0
YSwNCj4gIAkJCUlXTF9ERUJVR19GVyh0cmFucywNCj4gIAkJCQkgICAgICJHb3QgSVdMX1VDT0RF
X1RMVl9QTlZNX1NLVSBsZW4NCj4gJWRcbiIsDQo+ICAJCQkJICAgICB0bHZfbGVuKTsNCj4gKwkJ
CWlmICh0bHZfbGVuIDwgMyAqIHNpemVvZihfX2xlMzIpKSB7DQpTaXplb2YoKnRsdl9za3VfaWQp
DQoNCj4gKwkJCQlJV0xfRVJSKHRyYW5zLCAiaW52YWxpZCBQTlZNIFNLVSBUTFYgbGVuOg0KPiAl
dVxuIiwNCj4gKwkJCQkJdGx2X2xlbik7DQo+ICsJCQkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJCQl9
DQo+ICsNCj4gIAkJCUlXTF9ERUJVR19GVyh0cmFucywgInNrdV9pZCAweCUweCAweCUweCAweCUw
eFxuIiwNCj4gIAkJCQkgICAgIGxlMzJfdG9fY3B1KHRsdl9za3VfaWQtPmRhdGFbMF0pLA0KPiAg
CQkJCSAgICAgbGUzMl90b19jcHUodGx2X3NrdV9pZC0+ZGF0YVsxXSksDQoNCg==

