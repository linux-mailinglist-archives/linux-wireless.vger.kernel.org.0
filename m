Return-Path: <linux-wireless+bounces-29727-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D49CBB411
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Dec 2025 22:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B4F43009AAE
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Dec 2025 21:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2194427BF93;
	Sat, 13 Dec 2025 21:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KfXeu4f5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA74236A8B;
	Sat, 13 Dec 2025 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765660808; cv=fail; b=r6idbrWysayjRySjTZGeqEzE21xS5gT4op/qTqB/ZMYepPKhMItVBuMVNdZxPvwqj4SIipaLQ3mubR+uEjdM3qKcLNdMym3oDziSAYJpHXVpL5Kd4VCF8OPWMA/2RohXTUuALCvfe9JriuX7Wz9rVkZeKOVD6QdP/gq3up5Q8t4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765660808; c=relaxed/simple;
	bh=h56B9GgMFb98sdeAKgGNVKdSEiQDmLGY1e2OKoHfd5U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W4VCdvMPFqgLr2bvhOkqxNaT44PE66CLMOv2L1ly+KG/LXS+cdXC0KxJveGmdvtXhmt+zrQYzspudc5qQAy58K51wtuhJ2PCk4fpwpwpFM2NRQ3MxIBUz7vys+HO0YoRUQdDJE6gcdNGBh4llwn7n7rGDpOR+JbpFEx89w3Lf8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KfXeu4f5; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765660806; x=1797196806;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h56B9GgMFb98sdeAKgGNVKdSEiQDmLGY1e2OKoHfd5U=;
  b=KfXeu4f5pp1gzhHCe0oWISyywXaR3Erwjd0keERqM8s56JMXZ+ipGV90
   tLm30UbH/2Qq6qPh4slSdLYuJBoGz2nH2l7mKwip+2jbyHajOctYu5WhA
   WCbAGPx6oDhLERKVU8nqrSz2XTGX2qdCx2byIT+wATmEZj0mCpbUTQpFP
   z++yyE8HHivUEPrYlJKLriUWB5Zbt1Fg7t8VOMpLycPZJgmiUia3r0VC4
   U+kqIwfJ6YVpfIRH38RyUZibss8EMPzzN7fx4GSr348pQNBNRn+U6lRyY
   xe5rt+T2R4Bu12aWo3Ighjft50C1vDL7pKpNyrQD98yFgEBO2Tpl6E3hn
   g==;
X-CSE-ConnectionGUID: xYm25OAUQoi40JSiTjnaTQ==
X-CSE-MsgGUID: d/VivuiUQ5KdDyH0ZbovmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11641"; a="67692959"
X-IronPort-AV: E=Sophos;i="6.21,147,1763452800"; 
   d="scan'208";a="67692959"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2025 13:20:03 -0800
X-CSE-ConnectionGUID: MCA+p1RMQvufBmFsMKTNSg==
X-CSE-MsgGUID: r/GQd2E8QCKqEWWjI82WUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,147,1763452800"; 
   d="scan'208";a="196991601"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2025 13:20:03 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sat, 13 Dec 2025 13:20:02 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Sat, 13 Dec 2025 13:20:02 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.64) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sat, 13 Dec 2025 13:20:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6CR0ZEG0N7KBJKZPtcHzXrWdqZ7Kc3ZtMvcGyAzUJ7qc6dW4u1gYTU+VNI2j6P+MVa9UEwQaG0RGgcG34QHADq50lsaPdinbcj6AXUwTSv82RcbDZDwXTRfnoOZ+xe8ZXa3W996sE3gRxjvezDcjZxujh446G0F2A6cHUUpYQH1kSOjMy2VgBlDNj9MNQ+ORck05H6J/Rb7UKIfhNGTwRzJcsPu0dQXPGDo2bQtCjb//aCOqesqvddN12eVuz4Q5UMeuANI8/ukrTj0GHEy00x2M73HqhsqMYvAq1PLpLlF0Xy2Lbs7sB6vXmaBJ7lWbudv4gC9e/37T9Jar3i9Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h56B9GgMFb98sdeAKgGNVKdSEiQDmLGY1e2OKoHfd5U=;
 b=wJqfma2+EN6C5LBzfsowfZAg/n9bu9PQ+AIolgctv9GT/EQH3WNcT+zhfxXST/f61oYkO9EvJpI7nPKGt7w7/pYoxGE6hsbHqw+anAc6gtCzh8EJpJmsVYlocIuoZL2UwAjw/Evzsvh2H3Un210iLB5fvYtbI2x0PHeZoSiQLLCI74TeQov+Mktpx8HpluIiwXHYu5n4jA5bgvIcSUWSSlyCQGGVW5kLDIu/20/ZRYKDTCiHdh9HwM5p9LsXazuOmIX5r/mAkO8ZfX9c9dmjqIiWPtgaGek9Cv7yit+lKIdNlWNCrKiwXlxfmuERH3a/ZGAquZNwWPhhHPuOISGO6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by IA4PR11MB9231.namprd11.prod.outlook.com
 (2603:10b6:208:560::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Sat, 13 Dec
 2025 21:20:00 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::eed8:bee8:188e:b09c%2]) with mapi id 15.20.9412.011; Sat, 13 Dec 2025
 21:19:59 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Yao Zi <ziyao@disroot.org>, Richard Cochran <richardcochran@gmail.com>,
	"Berg, Johannes" <johannes.berg@intel.com>, "Anjaneyulu, Pagadala Yesu"
	<pagadala.yesu.anjaneyulu@intel.com>, "Gabay, Daniel"
	<daniel.gabay@intel.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Mingcong Bai
	<jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, Nathan Chancellor
	<nathan@kernel.org>
Subject: RE: [PATCH iwlwifi-fixes] wifi: iwlwifi: Implement settime64 as stub
 for MVM/MLD PTP
Thread-Topic: [PATCH iwlwifi-fixes] wifi: iwlwifi: Implement settime64 as stub
 for MVM/MLD PTP
Thread-Index: AQHcZRox8gXKTviIcEecDZ2/x8Mmy7UgIL1w
Date: Sat, 13 Dec 2025 21:19:59 +0000
Message-ID: <DM3PPF63A6024A9DAA9E34D7D49ABDFAC1DA3AFA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20251204123204.9316-1-ziyao@disroot.org>
In-Reply-To: <20251204123204.9316-1-ziyao@disroot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|IA4PR11MB9231:EE_
x-ms-office365-filtering-correlation-id: 12c609cc-b117-4b7a-1b0f-08de3a8d5f60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WTZmN2NRVUY5QXVIWk1Od3gySnl5WVgwREpLOHY3YnJ0b291QmxsWTJrVHN6?=
 =?utf-8?B?aER0dkl0Nk0xM09TZ0NQRFFkdkFqaFVDOEVRSytSa2JLWmJ6UmMyZXpQVjla?=
 =?utf-8?B?N1R0bFFPc2ZSWUU4QkZsbWJrcitIRFRUeHFrZU9BUEs3NnBJSVdwRzE0Zmoy?=
 =?utf-8?B?cTFDOEFiVjhPVFcyV2tSbEpTNU42YW41bFNLWithbnM0czlPSDZnMDJpbFFT?=
 =?utf-8?B?UUF5VDgvT3AyVEliYnJnK3I3QkIwWlJQSC9FQm1INUcxcGRHU0xraEdJQ3hw?=
 =?utf-8?B?TnJrL0hvZWtPQjB0VWJFcTFoTktsdElXTlBXYW9EQktMME1nS3ppQ1UyMmFV?=
 =?utf-8?B?ODdaM2NqWmFFTXZ2cjdNSFdpYzNEY0pOWXRFaHVYZmR3K1RnTStRQ21qai9V?=
 =?utf-8?B?NW91Zm5IdlBqT0lGc0JhMTdtMFhkdWlEVHdEbzNpM2VYOFI0Y3o1Y1Mvbk84?=
 =?utf-8?B?eWhqcHhhNHNnU2YyLzgyK082UFJFVCswcElNM3lpTUN4Y1dWelZ1eTU2ejBa?=
 =?utf-8?B?dkFCK0E0akw0Uy9FL0taNzFocFFFQW9uR3NxSVh1Slh2cWUvM29RQkhnMWRp?=
 =?utf-8?B?N1MxWTFFSnc1SzJlc3hyNU5CU1MwdXBEMjd3VzREYkV6bW1WR2pMSWpiK2d3?=
 =?utf-8?B?a1lWQjNJckVHVnlzbURncTBGUjArMzU5VkEwMFE1VTd5ZjlMd1g4TVY4djg5?=
 =?utf-8?B?elNXMnRSc3VZOXpOUHJ5SGxuUEJhbU0zMlIyVE5vL2dvZkRRYkgwMUNUTlVq?=
 =?utf-8?B?cDVraFBuYTlnNXMxNVBMZ3R0TExPMmJkUDhuSEdLTHAzUkxvYlQ3U0QrNzdD?=
 =?utf-8?B?a1pjc1drdjFPbE9kalJDMzlzVVh3U2xLSjA3ajVuakxoaU9IbThaaVlGaVJC?=
 =?utf-8?B?TzZHMEh3OXJ6eDlickhKNVp2NVQvaVVEdEhCWkhpZW05Q0VmQy84N3YvMW9N?=
 =?utf-8?B?aXNZcVdRMWk2TFVZMTdEOWs3SGQ5VjZvdE53S1hoRUxqSktSdDVDRG1GWXdF?=
 =?utf-8?B?QnM5aFNDeEliNWpSQU5PY1FPT0swdFI2elFIVHowMkUveDA0TTJydk9iRGRQ?=
 =?utf-8?B?SHlVOWRNMCtsdFA3RlY0Zm00VWtiU2RtY3IrbXlCVHMrNWlWOFh1NjFTK2Ft?=
 =?utf-8?B?dm43eFc4L25aekltRkxQaTdINlJqSGhhb3Boc3BDZDUrSXhtSWU4VmEwdURM?=
 =?utf-8?B?bVltNnpEeWc0WXpTL2Vob0JtcDBoQWprRFgzY2FEVXBwQ0ZDU1hJTGNpOHM4?=
 =?utf-8?B?OXpyV2U0NUdNL244VHhBUUJTTDlaMHZkWTJwVzExeWp6YkNUSS9ibzVlRG1Y?=
 =?utf-8?B?VkRpTnY1SE83YkNlSXVWVXI1TklrNXJuaEc3SE9CVlZoYm5aR2E5aDh6RTl3?=
 =?utf-8?B?dTM5NmxKTHNRL0ZUdWtuT0l0MEhsdy9IaTlhelk5d0I3aXFPbUVDSmNheTFm?=
 =?utf-8?B?ZEkycHd1SWdkZExOQkxZOUhxZUJ6RzdNSjExVStoSXBtNG0weUhZckFJM3lE?=
 =?utf-8?B?UDVqV2ZKYnpac1NnWTJwTEdrOUZSaVFIa0N1WUR3ZlkxNTZ2TFlCc2hmQ1NG?=
 =?utf-8?B?cE44Q2ZyUjRIOVdCMXlDT2VGS1lLeUJ5OWkwWER6TWordFRVVE1LclVGSHNw?=
 =?utf-8?B?L21JU0EzMHkzM2EzcWY2RFBKaWtXd3dnSnEwbEQxY1JKZWVob2xvRER3SlBw?=
 =?utf-8?B?VlNSSVZkZWU0bWFpektmUHZLbTkvOTUzdld1YnRDTE5vT2dXMjY5M0MvWjBw?=
 =?utf-8?B?M3orbzg2YndKcVpoT3BJa2RScWNmY28vVks5NlRqQVF6ZjlodE9qT2F2cUZT?=
 =?utf-8?B?MVhSeWQzK1cyRlN4M0NOM2tGa0YwYzRUdlNxTDQzMU9IazR1ZVVNdUZRLzd4?=
 =?utf-8?B?bkdGdTBDL0FKMGtaZ1JOY0NLdW43NE1Ybk5TeXRkajlDK1lzeG9vblViamNN?=
 =?utf-8?B?YlkwM2tqK24vMGdySjlsWVJXdFludktkTjhuWlVNUnR4SjExbWs1Q1FYZlBS?=
 =?utf-8?B?NmdqT09Xd1FLU2xjMk1BV2FybXFHY2NBclNWQ0hydEIzRTNHZGdtMytlUGdH?=
 =?utf-8?Q?NSpYIu?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2VCbDhGdjl4N3ZjRnd4bHB3QVFhVmJwbktoNDlHeDBsTVVoZE5kbiswU3hU?=
 =?utf-8?B?Q3habnpyaENMV0NHeGdNOXRkYktwWjh0bjc2bSt4d1lNWFJrejVYMlJrMVhH?=
 =?utf-8?B?bEQ1MUNrOG9zanBra1g2QlFONTk2RHRoY3RPREN0UUQ3M3NFVXVXaExPQTJS?=
 =?utf-8?B?NzB4ZHdWSGUxZmJLWjJIL0JRWGhkQk5FWldyOVcyQWE5SDRhYjdxNWdyV3dw?=
 =?utf-8?B?SitoNk1TSUxXa1ZUM0svQmsyaExDM2cxdWwvdU8xZm1BUzB2cnJJL3lPdjlv?=
 =?utf-8?B?MFBQSFJLdkxJTGRnaTZJTUJ0TmtuZGRVTG9GQjJuWU9KalYrQmU1WWpqYTlX?=
 =?utf-8?B?bXNmSmxWMmxPNERUL1NQRTZFZGEvWnd3ZFNtdkNJNWh1NUFuR1BCWmRQcCs2?=
 =?utf-8?B?eVNKWXNnZFVRSXI0MjVNa3lVZEpPdUV6UXk2cTVWVzYxNDBnTDgveWZaZnBS?=
 =?utf-8?B?RzlIY1gwUFczQ05yKytkZU5FYXhaMG0ycTA4L1U3Mk9IdFNpcy9xa0NCUCtT?=
 =?utf-8?B?bk9xYjdzV1pYdTFBeXhmUURsZnBrYmNleEJTSEJpYTVmQ1IxMS9xZDFXUGxw?=
 =?utf-8?B?a1RuaEsxRG5Sd2lSZHRwemgvQVR5ZmFiNWhJTWJXakw5REhDaDVNYkV5aUw3?=
 =?utf-8?B?VEJEOTg5Zm9uRHRwaHdvOXp3ayszSEJCbmZ2MVo4c0hDamQyQ0c2VGJnMnZH?=
 =?utf-8?B?ZWNMVEwxdHJtc1VyN2lZbDFZSnc0d3NhYlRnTm1XakQ5UVFNK1djZnQ0ODBr?=
 =?utf-8?B?azdiNCsyZFp4UFM5U0hHeURXcitKMmkwQ1FQczRPbDdGenRGZTc3MG5jeU9i?=
 =?utf-8?B?cWNsNG9RVU1MNHY0WjYvSm5qRGo0UEkwcndGMGpGeDNSWC9sb2ZHVlppWVlJ?=
 =?utf-8?B?WUJTNy9BNGN5c1BHZktQZVRlOWpGZ25rRXhJdG44dElyN1V2eEpLZXdoZk5p?=
 =?utf-8?B?d1p4aGFsalNQbDU4c0xWSXdXQzUyR1ZLQVZoM0FjNGtLUS9zYytMKy9FRzBF?=
 =?utf-8?B?WFgvaW9TaW82VEJab2lFNUhmekcxMytVenVFdU91dkw2RHFGcHVIcngvenY5?=
 =?utf-8?B?MzRmOEd5aVI1QTc5eG15V2h4UWNycmRzNmxGSUdGWnlxNU5OaFUvak1LRlFG?=
 =?utf-8?B?NHdzbEZrb1RacEtXUS9PN3hBbENZYmRpQnZLb3RxR3k0ZFhES0tabGRkY0p1?=
 =?utf-8?B?VWNKV05JeExPZHhzMEdDV3c3M1NEZ2NvakgrcWtQSmxLb1I2S1RvVGFEOTR3?=
 =?utf-8?B?UFpYUGQwNXZzalI5UlA0eXhCOGtZMFVldzNjZGlxaFF3RFpGK1VDNldFZHJp?=
 =?utf-8?B?QzQ0dXVyZWI2L1E2dUx4bFAvT0N3YTlQc2dTYmNEdXg5dlJMMjlzK2VGWlgy?=
 =?utf-8?B?MXNxVnJOOG41bi9XWlcxc3UyV2RVeWRrSkFCTTBiZlc3U2NETk1mU2J2dU1a?=
 =?utf-8?B?STRmY3YxdCtqYWoyUkVvR0ZXd0x2eWhmR0diYmxPL2pBTzZlR0RXMG4zK0M4?=
 =?utf-8?B?VVBhUkt4YW9VZUF4bTNydlJtR1UyOXJ0Z2VTUXhKN0ErZ2ozaXhyelo4bElJ?=
 =?utf-8?B?MFpUNmx3QlZiSTFBeUtEKzRSeVlJb1BpNCtqUzArQ2dPZGdqUytCN1NhS1pm?=
 =?utf-8?B?Vk0wQTA3MVZDU1cxKy9na29XMU9DSkhCaHVpek9ORnJaQTFzcDZIalA2Z0tk?=
 =?utf-8?B?a1FWTDQwWWlKRDF1Y0FUc2cwK3F6VHJBdjJ0Q1k1eU1iL0Q2RllkSWhFNWNE?=
 =?utf-8?B?NHVWcnNOcmhoSTV0OTBRalpQVi8yMnJ2alE3UXN1azh0UWxUcjhuRlNDV3Yr?=
 =?utf-8?B?Qi80Tm84Q0xZWWI1T1d4Z2MxOURBTFBhNkxTdkpvV3BWLzJ3WlpUTG56U1FZ?=
 =?utf-8?B?Qk42Q2ZpVEJtb0tHYlNkRmdMYmE5S1c2M2lJLzVVQ1BYVSthN2RuSFhzMWlt?=
 =?utf-8?B?dm10anNzcWtLUjhFaGFJTnJkT0tXMTBvUzF1b2h3dU44Zi9QMTIzYWh4UWZt?=
 =?utf-8?B?bkM2V2FqQ0ljdzlHY1A2WWFKSWJUZDYzTGMyUjN0NkVITlU5bGZnUTlpekk0?=
 =?utf-8?B?b3B4dDBJSDk0WFpLamF0L3RzNWVzUzBpNEpIWEVMdnNlYW9kb2tEd1g5WEJw?=
 =?utf-8?B?Vi85L0pRNXhpQ1poci9mM2lMVUx5QmdIK0F2eG44cXBwYUdLNWVhWXpRcWRZ?=
 =?utf-8?B?SVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c609cc-b117-4b7a-1b0f-08de3a8d5f60
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2025 21:19:59.8013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UksckeM/lwxb8Fdvn6JrGe/8ivWK9AfgdMy+VSN+WhZgMpddqyyFAPccRWFUaP3mqvt9pWMoEdnik3aXVya0nD7Rle8Qnjw5nqKn5TU/6Xv27FukWvA0vgE5PIA4WQLF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9231
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWWFvIFppIDx6aXlhb0Bk
aXNyb290Lm9yZz4NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDQsIDIwMjUgMjozMiBQTQ0K
PiBUbzogS29yZW5ibGl0LCBNaXJpYW0gUmFjaGVsIDxtaXJpYW0ucmFjaGVsLmtvcmVuYmxpdEBp
bnRlbC5jb20+OyBSaWNoYXJkDQo+IENvY2hyYW4gPHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbT47
IEJlcmcsIEpvaGFubmVzDQo+IDxqb2hhbm5lcy5iZXJnQGludGVsLmNvbT47IEFuamFuZXl1bHUs
IFBhZ2FkYWxhIFllc3UNCj4gPHBhZ2FkYWxhLnllc3UuYW5qYW5leXVsdUBpbnRlbC5jb20+OyBH
YWJheSwgRGFuaWVsDQo+IDxkYW5pZWwuZ2FiYXlAaW50ZWwuY29tPg0KPiBDYzogbGludXgtd2ly
ZWxlc3NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBu
ZXRkZXZAdmdlci5rZXJuZWwub3JnOyBNaW5nY29uZyBCYWkgPGplZmZiYWlAYW9zYy5pbz47IEtl
eHkgQmlzY3VpdA0KPiA8a2V4eWJpc2N1aXRAYW9zYy5pbz47IFlhbyBaaSA8eml5YW9AZGlzcm9v
dC5vcmc+OyBOYXRoYW4gQ2hhbmNlbGxvcg0KPiA8bmF0aGFuQGtlcm5lbC5vcmc+DQo+IFN1Ympl
Y3Q6IFtQQVRDSCBpd2x3aWZpLWZpeGVzXSB3aWZpOiBpd2x3aWZpOiBJbXBsZW1lbnQgc2V0dGlt
ZTY0IGFzIHN0dWIgZm9yDQo+IE1WTS9NTEQgUFRQDQo+IA0KPiBTaW5jZSBjb21taXQgZGZiMDcz
ZDMyY2FjICgicHRwOiBSZXR1cm4gLUVJTlZBTCBvbiBwdHBfY2xvY2tfcmVnaXN0ZXIgaWYNCj4g
cmVxdWlyZWQgb3BzIGFyZSBOVUxMIiksIFBUUCBjbG9jayByZWdpc3RlcmVkIHRocm91Z2ggcHRw
X2Nsb2NrX3JlZ2lzdGVyIGlzDQo+IHJlcXVpcmVkIHRvIGhhdmUgcHRwX2Nsb2NrX2luZm8uc2V0
dGltZTY0IHNldCwgaG93ZXZlciwgbmVpdGhlciBNVk0gbm9yIE1MRCdzDQo+IFBUUCBjbG9jayBp
bXBsZW1lbnRhdGlvbiBzZXRzIGl0LCByZXN1bHRpbmcgaW4gd2FybmluZ3Mgd2hlbiB0aGUgaW50
ZXJmYWNlIHN0YXJ0cw0KPiB1cCwgbGlrZQ0KPiANCj4gV0FSTklORzogZHJpdmVycy9wdHAvcHRw
X2Nsb2NrLmM6MzI1IGF0IHB0cF9jbG9ja19yZWdpc3RlcisweDJjOC8weDZiOCwNCj4gQ1BVIzE6
IHdwYV9zdXBwbGljYW50LzQ2OQ0KPiBDUFU6IDEgVUlEOiAwIFBJRDogNDY5IENvbW06IHdwYV9z
dXBwbGljYW50IE5vdCB0YWludGVkIDYuMTguMCsgIzEwMQ0KPiBQUkVFTVBUKGZ1bGwpDQo+IHJh
OiBmZmZmODAwMDAyNzMyY2Q0IGl3bF9tdm1fcHRwX2luaXQrMHgxMTQvMHgxODggW2l3bG12bV0N
Cj4gRVJBOiA5MDAwMDAwMDAyZmRjNDY4IHB0cF9jbG9ja19yZWdpc3RlcisweDJjOC8weDZiOCBp
d2x3aWZpIDAwMDA6MDE6MDAuMDoNCj4gRmFpbGVkIHRvIHJlZ2lzdGVyIFBIQyBjbG9jayAoLTIy
KQ0KPiANCj4gSSBkb24ndCBmaW5kIGFuIGFwcHJvcHJpYXRlIGZpcm13YXJlIGludGVyZmFjZSB0
byBpbXBsZW1lbnQgc2V0dGltZTY0KCkgZm9yDQo+IGl3bHdpZmkgTUxEL01WTSwgdGh1cyBpbnN0
ZWFkIGNyZWF0ZSBhIHN0dWIgdGhhdCByZXR1cm5zIC1FT1BUTk9UU1VQUCBvbmx5LA0KPiBzdXBw
cmVzc2luZyB0aGUgd2FybmluZyBhbmQgYWxsb3dpbmcgdGhlIFBUUCBjbG9jayB0byBiZSByZWdp
c3RlcmVkLg0KPiANCj4gUmVwb3J0ZWQtYnk6IE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRoYW5Aa2Vy
bmVsLm9yZz4NCj4gQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTExMDgw
NDQ4MjIuR0EzMjYyOTM2QGF4MTYyLw0KPiBTaWduZWQtb2ZmLWJ5OiBZYW8gWmkgPHppeWFvQGRp
c3Jvb3Qub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
bWxkL3B0cC5jIHwgNyArKysrKysrDQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvbXZtL3B0cC5jIHwgNyArKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlv
bnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3
aWZpL21sZC9wdHAuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxk
L3B0cC5jDQo+IGluZGV4IGZmZWIzN2E3ZjgzMC4uMjMxOTIwNDI1YzA2IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9wdHAuYw0KPiArKysgYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9wdHAuYw0KPiBAQCAtMTIxLDYg
KzEyMSwxMiBAQCBzdGF0aWMgaW50IGl3bF9tbGRfcHRwX2dldHRpbWUoc3RydWN0IHB0cF9jbG9j
a19pbmZvDQo+ICpwdHAsDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+IA0KPiArc3RhdGljIGludCBp
d2xfbWxkX3B0cF9zZXR0aW1lKHN0cnVjdCBwdHBfY2xvY2tfaW5mbyAqcHRwLA0KPiArCQkJICAg
ICAgIGNvbnN0IHN0cnVjdCB0aW1lc3BlYzY0ICp0cykNCj4gK3sNCj4gKwlyZXR1cm4gLUVPUE5P
VFNVUFA7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgaXdsX21sZF9wdHBfYWRqdGltZShzdHJ1
Y3QgcHRwX2Nsb2NrX2luZm8gKnB0cCwgczY0IGRlbHRhKSAgew0KPiAgCXN0cnVjdCBpd2xfbWxk
ICptbGQgPSBjb250YWluZXJfb2YocHRwLCBzdHJ1Y3QgaXdsX21sZCwgQEAgLTI3OSw2DQo+ICsy
ODUsNyBAQCB2b2lkIGl3bF9tbGRfcHRwX2luaXQoc3RydWN0IGl3bF9tbGQgKm1sZCkNCj4gDQo+
ICAJbWxkLT5wdHBfZGF0YS5wdHBfY2xvY2tfaW5mby5vd25lciA9IFRISVNfTU9EVUxFOw0KPiAg
CW1sZC0+cHRwX2RhdGEucHRwX2Nsb2NrX2luZm8uZ2V0dGltZTY0ID0gaXdsX21sZF9wdHBfZ2V0
dGltZTsNCj4gKwltbGQtPnB0cF9kYXRhLnB0cF9jbG9ja19pbmZvLnNldHRpbWU2NCA9IGl3bF9t
bGRfcHRwX3NldHRpbWU7DQo+ICAJbWxkLT5wdHBfZGF0YS5wdHBfY2xvY2tfaW5mby5tYXhfYWRq
ID0gMHg3ZmZmZmZmZjsNCj4gIAltbGQtPnB0cF9kYXRhLnB0cF9jbG9ja19pbmZvLmFkanRpbWUg
PSBpd2xfbWxkX3B0cF9hZGp0aW1lOw0KPiAgCW1sZC0+cHRwX2RhdGEucHRwX2Nsb2NrX2luZm8u
YWRqZmluZSA9IGl3bF9tbGRfcHRwX2FkamZpbmU7IGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9wdHAuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvbXZtL3B0cC5jDQo+IGluZGV4IDA2YTRjOWY3NDc5Ny4uYWQxNTZi
ODJlYWE5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZp
L212bS9wdHAuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212
bS9wdHAuYw0KPiBAQCAtMjIwLDYgKzIyMCwxMiBAQCBzdGF0aWMgaW50IGl3bF9tdm1fcHRwX2dl
dHRpbWUoc3RydWN0IHB0cF9jbG9ja19pbmZvDQo+ICpwdHAsDQo+ICAJcmV0dXJuIDA7DQo+ICB9
DQo+IA0KPiArc3RhdGljIGludCBpd2xfbXZtX3B0cF9zZXR0aW1lKHN0cnVjdCBwdHBfY2xvY2tf
aW5mbyAqcHRwLA0KPiArCQkJICAgICAgIGNvbnN0IHN0cnVjdCB0aW1lc3BlYzY0ICp0cykNCj4g
K3sNCj4gKwlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgaXds
X212bV9wdHBfYWRqdGltZShzdHJ1Y3QgcHRwX2Nsb2NrX2luZm8gKnB0cCwgczY0IGRlbHRhKSAg
ew0KPiAgCXN0cnVjdCBpd2xfbXZtICptdm0gPSBjb250YWluZXJfb2YocHRwLCBzdHJ1Y3QgaXds
X212bSwgQEAgLTI4MSw2DQo+ICsyODcsNyBAQCB2b2lkIGl3bF9tdm1fcHRwX2luaXQoc3RydWN0
IGl3bF9tdm0gKm12bSkNCj4gIAltdm0tPnB0cF9kYXRhLnB0cF9jbG9ja19pbmZvLmFkamZpbmUg
PSBpd2xfbXZtX3B0cF9hZGpmaW5lOw0KPiAgCW12bS0+cHRwX2RhdGEucHRwX2Nsb2NrX2luZm8u
YWRqdGltZSA9IGl3bF9tdm1fcHRwX2FkanRpbWU7DQo+ICAJbXZtLT5wdHBfZGF0YS5wdHBfY2xv
Y2tfaW5mby5nZXR0aW1lNjQgPSBpd2xfbXZtX3B0cF9nZXR0aW1lOw0KPiArCW12bS0+cHRwX2Rh
dGEucHRwX2Nsb2NrX2luZm8uc2V0dGltZTY0ID0gaXdsX212bV9wdHBfc2V0dGltZTsNCj4gIAlt
dm0tPnB0cF9kYXRhLnNjYWxlZF9mcmVxID0gU0NBTEVfRkFDVE9SOw0KPiANCj4gIAkvKiBHaXZl
IGEgc2hvcnQgJ2ZyaWVuZGx5IG5hbWUnIHRvIGlkZW50aWZ5IHRoZSBQSEMgY2xvY2sgKi8NCj4g
LS0NCj4gMi41MS4yDQpBY2tlZC1ieTogTWlyaSBLb3JlbmJsaXQgPG1pcmlhbS5yYWNoZWwua29y
ZW5ibGl0QGludGVsLmNvbT4NCg0K

