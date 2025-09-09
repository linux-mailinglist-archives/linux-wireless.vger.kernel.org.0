Return-Path: <linux-wireless+bounces-27153-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFD6B4A77F
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 11:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807C4164242
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 09:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EB8288C0E;
	Tue,  9 Sep 2025 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YNfcDd/3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD8B2D5C6E
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409344; cv=fail; b=KkpQzc+9L97cTPTrCdy75Jevz1tBEct7L7rFAjNfDVObYrSEg3Ntlk+tcazYkrx5THbHVBsfNsYcwoW2QCyTD/6ffOMEv6peeO+/bQrAmWq+3SAYvqUrmNuZYiffPhdSqC93NJgQFHlznjZwM5TAQJUwT8SQPC9v2KN3WaQvN44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409344; c=relaxed/simple;
	bh=PZ1HSpMkLj2Q6Oket4u5VNqN6KU/1+Ls2f1XWvJxmnw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Y+BL3x/i5MXqHGfzbY1lyqcytzPrI++lbV9Q6FymTTf8z0syq/aCcXv3b3DtCbosRVXdjoTgYgNaleedb8nEQOYJadwkbpemlDRC0gqk/0Aj6oXv31OhJz9yn5C+kYot9hy3LMtvUV7GJBmFGx1gxZ2hZc2On2vJIAJeCN1HadM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YNfcDd/3; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757409343; x=1788945343;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=PZ1HSpMkLj2Q6Oket4u5VNqN6KU/1+Ls2f1XWvJxmnw=;
  b=YNfcDd/3bzpV5bmNkoZn1bGuQNLpdhPmcgLAtEctFnlLq4gkClxOGYih
   cYnqFcoJDLMngyFr4hupZj6TdyJ54mFv0M+ql1E112y0tG34YyqTRcCX7
   FWTn+ZI+KNczVpPQ4u7zDlIg4QEJuwDB6tA8cvmPYp5h+4J70ZESwJOs4
   uDzU10FutUUT0yEe5fdzyRrTkYrrJSKLg+tEI5QynDuFE4eUh8E+0lT6U
   cfRkyM4w3oUlbcqHvRGI4BZ5aSUlEO5Bd5GFaA6QOF8A0mt/2V42O7z0r
   YucVa4eoyFq7pcwSfYxxW2UjRSJLL0hQnwOdbQiH/VLtzTrcncCPy3hhK
   Q==;
X-CSE-ConnectionGUID: ph9di9NUTra/tPUCeiBM4w==
X-CSE-MsgGUID: HSxAyri0QWK7mYstxiYPHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63516338"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63516338"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 02:15:42 -0700
X-CSE-ConnectionGUID: 1n1seDtlSMu1QPlYfmly3A==
X-CSE-MsgGUID: pldGA8YXQWGVxc4ZFLY4hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="178237744"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 02:15:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 02:15:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 02:15:41 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.80)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 02:15:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcp65PHL7x316DWIvKGWEy4Cbffr3dbbhI4QF3ZiwZEco+lhrcxqEWvFozJRm0UOiQ/uTY/gVxNaPjlKvJIAuB2Yu8ftNjVRhT+btMNeUrAEvfca0Y98Vk+Cc88jp7bmuPw/ZaUZ05dYm45qce8vR3CAKA2gFymFb3SQJ+frBNLs3YG5lh4PJYmbYqy9bbV+zKwIkV/z/bjX7uDaGO5vaRs7a8asEWMmTsK8gPhxAZLUma5p9kYBnCv6PlAo/EAd/9uVlRM04gPjwhHt0Sg6dA/g6LFTwGbn9CwtUsyYyEpkBtnp7i5tXDubVr//9kCnCI2uCt8TzW77xfB7X11uEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZ1HSpMkLj2Q6Oket4u5VNqN6KU/1+Ls2f1XWvJxmnw=;
 b=TeH72i9+4Q/RUeIlYPTjseA2POJg+gt9RoVErw2KtwWf0gsculXW1+sWKawtrQ+zfMBrDX9gXUsm7OdLb3cyZPA9QEGZFIMXqsVKxd7rTT4QcJYZLwcknwdiHhF0A+/TkeQTkPjNBQrtCxA0a1D7V8RQGuMO8TgV+AIbArqCthVT+B0r9ejTXKks2qISTLKzaDVNSUnuu1ZrYXAQ3ajq9NxcoNLpZy/sT9N/yjYk+fbNUNUKUHN6cpNIVctouWqgYzxt7/O+kyuM2PFz4cJnz0l4zh+y64xBljaRLhkZIJDosfKoVkBV5IWXKlByQo9nUqG0PUhiD4HGs91/yjVexA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by DM6PR11MB4561.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 09:15:39 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 09:15:39 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "Berg, Johannes" <johannes.berg@intel.com>, Linux Wireless
	<linux-wireless@vger.kernel.org>
Subject: pull-request: iwlwifi-next-2025-09-09
Thread-Topic: pull-request: iwlwifi-next-2025-09-09
Thread-Index: Adwhak4QcgJFJl7/QWCjix9s95w4+g==
Date: Tue, 9 Sep 2025 09:15:38 +0000
Message-ID: <DM3PPF63A6024A930B77E512E91DD880398A30FA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|DM6PR11MB4561:EE_
x-ms-office365-filtering-correlation-id: 30e49965-efa9-444c-652c-08ddef81718a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MDlHWlhoZ0cwMW9KZFl0OHdyUDZ4UG1mUXVxelVFU1pTOXZCZ29SeUdoemJY?=
 =?utf-8?B?eXloRVV5aTBPd0NjOGRzZ3RHVmxWb1FLbnY5cVE3YkErcjZiaW9INlVaVnpn?=
 =?utf-8?B?RnpETjRWRFNGTnVkSlVyY215Q051OGlGczZsRDBJY1BZNDUxSTZ4K3crZ0Rs?=
 =?utf-8?B?eC9ndTBsaHRGYVRXc0phUHorVTdab213ZzUxVlVQc3pYRXZJNDd1bW1mY094?=
 =?utf-8?B?TXl5MDRYWUF5WktyRUF2QlFXOSsvQ211L1dRSUV6dU81bXh2T3BxZk1VMERn?=
 =?utf-8?B?cURpVURKQmg3ZTJ1T3ZzVEFROGlGU3M5Kzdvc0JpUU5LaHZpUUpCKzQzUnht?=
 =?utf-8?B?M2lNNmVsS2VXMzk1SnZCSE1BdXFIV1JRMnJaRlo4Z0V4L3JuK2dMeU5rTjlR?=
 =?utf-8?B?YzhoRzhNWElGRGhQaHNtVEQ5Qy9RTDg5d3ByY1JialRDV1Nyc003dnRjUENM?=
 =?utf-8?B?ckxCQ3p3bEg1bDU2dThiZGJSTTA2ZG1wODZ2TWpJOGZZaDROSFNoQ1k4aWVX?=
 =?utf-8?B?VzUvelJRL2xXdmdkakxDZDNNcXk2OVl4eDNWaWZ4aUtsbWlMNlo2N3VJOGp6?=
 =?utf-8?B?eS9rWVI1ZUdiRllOemlqd1Q4bDQzSjY4bzZLQWN6NzRzN2cyZDNwZ3EwclZU?=
 =?utf-8?B?b2J0NW5LdHAwZWVGZDlScll4NHREandOU2ZKOU9oU1IvdlVDMmo3Zi85SGw5?=
 =?utf-8?B?elBEZ1FneUxaR0dpQjlDWUZHZW1XVnZ3a2lrdmpJajIwRTdCZFRUQVI2amxh?=
 =?utf-8?B?c0R5UWpPcmQyOG50Uzk4Qlg5cFVYYVBYQk5ucElpMDhDaGYwM05vVUFHUDRV?=
 =?utf-8?B?TUJucHkvSTI3US9SNTVnYW90R2NUcTUzUytlOFVTbFJJdDc3UzJiY3F5U0FJ?=
 =?utf-8?B?NlRjWVZOcjFrWUxVSkZQQ1l5ZU0xQnh3dWdaYzFaZFRXZjNJSERKa0V3b2RY?=
 =?utf-8?B?NjdYMWxFaGphYkFQeFRhb2xiQ041RHlmQmhJYUFUM25VdVNkQVRUc0k0K1Nj?=
 =?utf-8?B?Q0pBT1dxeEYxTXc2WHR0aHdYeDQxMStNTUVZQi9xN3AyQjREOFl2WjhVUnlM?=
 =?utf-8?B?ZDEwWE1JWFdoSjZ0UkFBMEVvT0lhMi8xWGJFanJQa3VncmtOUlRYQkM2aThv?=
 =?utf-8?B?QkpadkJVWUp0VlJwL3NUaHBXWEMvRnYyNStMSnNEL1hJNmUvaHJPOEw1Wk5u?=
 =?utf-8?B?RTNwMEhBZTRmUUtoSlF5RjZ6bnZxUE5QemxyMFVqdTBpNGdLQWpieTBDWVh2?=
 =?utf-8?B?MFN3UmxwZGxCTE9oTnd4YkZsVGNXSWtRVzk4YzdjSHYydkpFeUFNU1E2SnVz?=
 =?utf-8?B?VjdWN0NKS2FiOVowbHArU1pscGZ6Vll6cUxxTVRYeW1pYjJENUNoTndqZVBl?=
 =?utf-8?B?WW9TbFp6elo4MXNiUGtiM1AwQytDNWxOejlYTmRwQzRnTjAzTHFsOTFuZ0Rj?=
 =?utf-8?B?YTVWdXJyVVA0MWNjTHVvSHA4SEtwYkR6cjVVZUVqeERoTktWTi9EdzBUeXpC?=
 =?utf-8?B?QlVJeGIxalQvMmVhNWdEZnMvMnZOYzNNU2xxSXk3ZkdtK0JMYXR3aXdiK0gw?=
 =?utf-8?B?TUpYSTNQdGRXVVZraHN3QzhvQmhiUHYzTlRmY0RtTmZEc0JvN2pReksycmR5?=
 =?utf-8?B?M0FQSDZDelRHMDAxZGlJcStRV1NjOHBNbFFVT0o2VHpWT1RqQnRwKzJkTWFV?=
 =?utf-8?B?cUhHdUErMHpTNzB3VkVGckNBaS9lV0NkMjlBSmpadFN4eXVHM00rYkFqaHdn?=
 =?utf-8?B?bkZsTkJWYXFBL2twcU16ZjM0L2dBbUQ3Mzk3eVE3SDh0V0RUTkhDZCtRUTRx?=
 =?utf-8?B?RitPdzhpTWladGt0aWVORUNleWhZd1ZUYnZDdG9BRmJmeFJva2lxOWJSSk5S?=
 =?utf-8?B?cWJjdXd3R21hWXB1dE55dXlwRS9INGtXWldSUmwvdEtXcFNwVVRaaDF0cTJK?=
 =?utf-8?B?bEdjR2lPTFZiRkM5blduVUUrN0x5bHF0VGRKSUc2TGFDbERybytLZUFJQVVp?=
 =?utf-8?Q?bYQaPTGLFHp24sVct/HASzh+FFyU2s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnRtbWlId0toNUp1SzVQbU1FNlFVbzRiRHB0Vm9WRnhDY2ZrcDUrTUUrYW5i?=
 =?utf-8?B?ZzNVTmV5bFNTVmJGZlZUQzUxQlA1Q09WNGJ6eUVheXdHQ2JWRll6R2JvN2xi?=
 =?utf-8?B?YnFrOGRZQ0ZUS2xCWnFsa21VaHNadWdFWldKc2gxYlFqbzJNVitxOVZMNmF3?=
 =?utf-8?B?RlByV2U4UnYvZjVRakY3bWRuakNFZ0FwQVVaVmJYcysyTWI2aEdyUDFwQXBK?=
 =?utf-8?B?UWxiNmZPdDNYSzZNbHU4Y0JuZ2lnQzc3VlZJWDMyWnMzS1R0R1I3V21xanhi?=
 =?utf-8?B?eVN1T2UxMS9xWG1LM3Q5WHZESzZEZVdFVklPNmtDSzE5YlZDS3FPRHNWdmZS?=
 =?utf-8?B?QWRyNWFCZVUwODZjTzRVSEd0YmgvNWIrajlQdlM2US9YR2pZYXBUSHgrYm5Z?=
 =?utf-8?B?M0xLNzFFT3lwWW1waUR3Sm4xRnJMZGVsV0U5Nm5PaXNGUHU5VnZpU1Z0VU9v?=
 =?utf-8?B?djFYTzJZWmthZTZVeUFuYWJ5QWRoeTUzMjJSSmxnUVQ5Q3FuSy9KNUFLV0x5?=
 =?utf-8?B?RFhtY1krSldjMkJER0NqaUp2VFAzWVBGNVRKUDRuWXhYMU9hQWp2S3JVNnJP?=
 =?utf-8?B?SUtYS1VyVmN1cnJDd1NmN2ExRGMrWFgrVHYvOXdtdnR0L3Vubk0ybHNjWlNC?=
 =?utf-8?B?UzdvNUQ2bm8zeVZJQ01KbWlQVkNHOEE4NkhtcGVNM0J5ZUJJVDRsemNHMnVD?=
 =?utf-8?B?QSt1OVVNaTJURXJ5SkMrZlRUMEx1eURIWmw1OUR6Nk5mM2ZqTG5WWkRTOWdR?=
 =?utf-8?B?SnZhdWFjZmxxL2U3aVBNaFR4OWw5QjBnWnFGREdmVVhvL2F3ZXkxTkZrVHJw?=
 =?utf-8?B?a01iWmNMMU5QMGFOeGJTZm9QVERqN0kzRG9zSEZoV1NLSzI0NVRIcS82NGNZ?=
 =?utf-8?B?NVorSHlIM0hXN01MNVZxMUdiOTZlOUI0eVJSRVBramR5WW9wcmJZcm42RURl?=
 =?utf-8?B?Ylc1OFhFUDEwVk55cWdjNDdUcFgycFhuWUFaWXp6cHdhV3NTV0RML0txODdo?=
 =?utf-8?B?eHN3VGsxK1Ewc1czZEpQTFdVVlptZ0ZBdGplQlk5cGlNd1RxZ1JtUDhvdUR1?=
 =?utf-8?B?cHhsREJVc1VQVnN5eDZtYzZDaDl2RG9nVTJodFlJaThVSC9FMjFzVEJLRnRE?=
 =?utf-8?B?cEFEY2dtZW1CUUVLL21LQ1ZmWldIMHFTTVZnN2xSZjdhbTR1MVFRWUZVMDdv?=
 =?utf-8?B?V1FqTk5VNkxDUnNLaGJXcjZveWdaRUd1T0o5aHd1TG54OEFvcVRXblhIU0lX?=
 =?utf-8?B?VzhKSlgwVUIwMHhxQ1FVMHNPb1lVNjRmMjZNSGFUbVdHTzRXcVhFMlVTT2FW?=
 =?utf-8?B?K28ycU1vM2hFeXBzREJ3eWk2WVJoUFB0UjhOSktKK0VIa1U4VkZhY3RZeWZV?=
 =?utf-8?B?bFlqcnJGL0R5aDFpUnV3U28xM1lxbUpvajRiYi9NcWpCVEZkOWNkbml4MXZx?=
 =?utf-8?B?dXpjeElyYTY5VVNiR2NMRG9acFhzYkVLamUrV3dwa3F6R3J2MVVUaHllQVFV?=
 =?utf-8?B?aHYvaUh1N3VKR1BhMHZEakQ4T21CWFR2dzBYQnRPaUwyZGg1Nm4vR2VqdlEy?=
 =?utf-8?B?M3FXWENFMm4yeWY1a01Ec1FpOWdXcndrZ2FCOEFPZTN2RTlBSDJHa3dQZjNl?=
 =?utf-8?B?Qmd0WGFzNy9pcTBycTZLbmxpb0pHK3VNaEhRdWtTTUlXRE9KRmpKek1hNm1z?=
 =?utf-8?B?d0k5VlJOdXpiQjN4TzJod1M0VDZ4bGRtWFFSOFVab2Z6WGZLZ2hVaC9WVDlT?=
 =?utf-8?B?UnJDaWZJRmM5WWg4YkwvbEIxQzE4ZS9NQW9lN0dsMThScUk1SFhLaUxCUGxL?=
 =?utf-8?B?VWd3V21tTm95V1ZhL2VFRk5XRGdwdmxNMmdYdUs0RVZvd2gvWlo0Y041NUZB?=
 =?utf-8?B?WTJhekwxZXJ4TmJjUTdYKzZoT1c1TXpxdWhqYmk5OVVaazR1Ry9JNXdYNzhF?=
 =?utf-8?B?TW5yS3BOQkFlK21idHJEODJzSWdDUmxtY3VwZUdEK25reTlzT2xEWE1acHFp?=
 =?utf-8?B?MHZOak5pRlBUWmxvSmRvQTFYODlYbzIrZUNpNzRZQWRmR21YLzRBYVlaNEFE?=
 =?utf-8?B?STc3MFRKNmpUVjhOZmFRd0ZKSlBBeHYwM0EwNXBBenJ1c1VXWVFGNmcyNEJo?=
 =?utf-8?B?UzdjM3A3WkREMTU2Rk9ic01nMUkycTkxU090M0N6ODNYWDl2ODF0SURRczZ5?=
 =?utf-8?Q?50B2zWclMdV7ECTP3p3EKwk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e49965-efa9-444c-652c-08ddef81718a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 09:15:39.1065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 08RlohzMCfZuGaCqJKriJCT2AXZ9/e9QS8NDWtXGDw7i10ng7HJnJel4Vm16FHXzsRmkJmPntaTFMO+S//6uVV7Y4b3Q/Z+wxCzSkYNX/220X73pgDplbqMgX8SLxiNY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4561
X-OriginatorOrg: intel.com

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBlM2FjOTNlOWQ5MTZlYmFlMDcxMWE0
MmY1MjQ0MjlkYWQ4OWM0ODg3Og0KDQogIHdpZmk6IG13aWZpZXg6IGZpeCBkb3VibGUgZnJlZSBp
biBtd2lmaWV4X3NlbmRfcmdwb3dlcl90YWJsZSgpICgyMDI1LTA5LTA1IDEwOjQ2OjA0ICswMjAw
KQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCg0KICBodHRwczov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9pd2x3aWZpL2l3bHdpZmkt
bmV4dC5naXQvIHRhZ3MvaXdsd2lmaS1uZXh0LTIwMjUtMDktMDkNCg0KZm9yIHlvdSB0byBmZXRj
aCBjaGFuZ2VzIHVwIHRvIGJjNGE0NWY4ZGE1NmNkMDJiYzZiODYxYjdhMTA1MWE3ZDc2NjU1OTY6
DQoNCiAgd2lmaTogaXdsd2lmaTogbWxkOiBDSEFOTkVMX1NVUlZFWV9OT1RJRiBpcyBhbHdheXMg
c3VwcG9ydGVkICgyMDI1LTA5LTA5IDEyOjA4OjM0ICswMzAwKQ0KDQotLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQppd2x3aWZp
IGZlYXR1cmVzLCBub3RhYmx5Og0KDQotIHVudXNlZCBBUEkgY2xlYW51cHMNCi0gdHJhbnNwb3J0
IGxheWVyIGNsZWFudXBzDQotIG5ldyBBUElzIHN1cHBvcnQNCg0KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KR3VzdGF2byBB
LiBSLiBTaWx2YSAoMSk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBtZWk6IFJlbW92ZSB1bnVzZWQg
ZmxleGlibGUtYXJyYXkgbWVtYmVyIGluIHN0cnVjdCBpd2xfc2FwX2hkcg0KDQpMaWFvIFl1YW5o
b25nICgxKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IFJlbW92ZSByZWR1bmRhbnQgaGVhZGVyIGZp
bGVzDQoNCk1pYW9xaWFuIExpbiAoMSk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBGaXggZGVudHJ5
IHJlZmVyZW5jZSBsZWFrIGluIGl3bF9tbGRfYWRkX2xpbmtfZGVidWdmcw0KDQpNaXJpIEtvcmVu
YmxpdCAoMTApOg0KICAgICAgd2lmaTogaXdsd2lmaTogcmVuYW1lIGl3bF9maW5pc2hfbmljX2lu
aXQNCiAgICAgIHdpZmk6IGl3bHdpZmk6IHBjaWU6IG1vdmUgcG1fc3VwcG9ydCB0byB0aGUgc3Bl
Y2lmaWMgdHJhbnNwb3J0DQogICAgICB3aWZpOiBpd2x3aWZpOiBwY2llOiBtb3ZlIGx0cl9lbmFi
bGVkIHRvIHRoZSBzcGVjaWZpYyB0cmFuc3BvcnQNCiAgICAgIHdpZmk6IGl3bHdpZmk6IGFwaTog
YWRkIGEgZmxhZyB0byBpd2xfbGlua19jdHhfbW9kaWZ5X2ZsYWdzDQogICAgICB3aWZpOiBpd2x3
aWZpOiBtbGQ6IGRvbid0IGNvbnNpZGVyIHBoeSBjbWQgdmVyc2lvbiA1DQogICAgICB3aWZpOiBp
d2x3aWZpOiBtbGQ6IHJlbW92ZSBzdXBwb3J0IG9mIG1hYyBjbWQgdmVyIDINCiAgICAgIHdpZmk6
IGl3bHdpZmk6IG1sZDogcmVtb3ZlIHN1cHBvcnQgb2Ygcm9jIGNtZCB2ZXJzaW9uIDUNCiAgICAg
IHdpZmk6IGl3bHdpZmk6IG1sZDogcmVtb3ZlIHN1cHBvcnQgZnJvbSBvZiBzdGEgY21kIHZlcnNp
b24gMQ0KICAgICAgd2lmaTogaXdsd2lmaTogbWxkOiByZW1vdmUgc3VwcG9ydCBvZiBpd2xfZXNy
X21vZGVfbm90aWYgdmVyc2lvbiAxDQogICAgICB3aWZpOiBpd2x3aWZpOiBtbGQ6IENIQU5ORUxf
U1VSVkVZX05PVElGIGlzIGFsd2F5cyBzdXBwb3J0ZWQNCg0KTmlkaGlzaCBBIE4gKDEpOg0KICAg
ICAgd2lmaTogaXdsd2lmaTogZnc6IEFkZCBBU1VTIHRvIFBQQUcgYW5kIFRBUyBsaXN0DQoNClBh
Z2FkYWxhIFllc3UgQW5qYW5leXVsdSAoMSk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBhZGQga3Vu
aXQgdGVzdHMgZm9yIG52bSBwYXJzZQ0KDQpSb3RlbSBLZXJlbSAoMyk6DQogICAgICB3aWZpOiBp
d2x3aWZpOiBhZGQgU1RBVFVTX0ZXX0VSUk9SIEFQSQ0KICAgICAgd2lmaTogaXdsd2lmaTogcmVw
bGFjZSBTVVBQUkVTU19DTURfRVJST1JfT05DRSBzdGF0dXMgYml0IHdpdGggYSBib29sZWFuDQog
ICAgICB3aWZpOiBpd2x3aWZpOiBpbXBsZW1lbnQgd293bGFuIHN0YXR1cyBub3RpZmljYXRpb24g
QVBJIHVwZGF0ZQ0KDQpZYW5nIExpICgxKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IFJlbW92ZSBk
dXBsaWNhdGVkIGluY2x1ZGUgaW4gdHJhbnMuYw0KDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50
ZWwvaXdsd2lmaS9kdm0vZWVwcm9tLmMgICAgfCAgIDIgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL2R2bS9wb3dlci5jICAgICB8ICAgMiArLQ0KIGRyaXZlcnMvbmV0L3dp
cmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYXBpL2QzLmggICAgIHwgMTEyICsrKysrKysrKy0NCiAu
Li4vbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYXBpL21hYy1jZmcuaCAgICB8ICAgMyAr
DQogLi4uL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2FwaS9vZmZsb2FkLmggICAgfCAg
IDIgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2RiZy5jICAgICAg
ICB8ICAgNCArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvZHVtcC5j
ICAgICAgIHwgICAyICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9y
ZWd1bGF0b3J5LmMgfCAgMTQgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZp
L2Z3L3JlZ3VsYXRvcnkuaCB8ICAgMSAtDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9pd2wtaW8uYyAgICAgICAgfCAgIDYgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL2l3bC1pby5oICAgICAgICB8ICAgMiArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNz
L2ludGVsL2l3bHdpZmkvaXdsLW52bS1wYXJzZS5jIHwgIDc2ICstLS0tLS0NCiBkcml2ZXJzL25l
dC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2l3bC1udm0tcGFyc2UuaCB8ICA3NCArKysrKysrDQog
ZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtdHJhbnMuYyAgICAgfCAgMTUg
KysNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2l3bC10cmFucy5oICAgICB8
ICAzMyArLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21laS9zYXAuaCAg
ICAgICB8ICAgMiAtDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQvZDMu
YyAgICAgICAgfCAyMzkgKysrKysrKysrKysrKysrKystLS0tDQogZHJpdmVycy9uZXQvd2lyZWxl
c3MvaW50ZWwvaXdsd2lmaS9tbGQvZGVidWdmcy5jICAgfCAgIDggKy0NCiBkcml2ZXJzL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9pZmFjZS5jICAgICB8ICAzMCArLS0NCiBkcml2ZXJz
L25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9tYWM4MDIxMS5jICB8ICAgMiArLQ0KIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL21sby5jICAgICAgIHwgIDI4ICst
LQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL25vdGlmLmMgICAgIHwg
ICAxIC0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9yb2MuYyAgICAg
ICB8ICAxMCArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL3NjYW4u
YyAgICAgIHwgICA0ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tbGQv
c3RhLmMgICAgICAgfCAgIDggKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZp
L212bS9kMy5jICAgICAgICB8ICAxMyArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvbXZtL2RlYnVnZnMuYyAgIHwgICAyICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50
ZWwvaXdsd2lmaS9tdm0vZncuYyAgICAgICAgfCAgIDIgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL3BjaWUvZHJ2LmMgICAgICB8ICAgMiArLQ0KIC4uLi93aXJlbGVzcy9p
bnRlbC9pd2x3aWZpL3BjaWUvZ2VuMV8yL2ludGVybmFsLmggIHwgIDIwICstDQogLi4uL2ludGVs
L2l3bHdpZmkvcGNpZS9nZW4xXzIvdHJhbnMtZ2VuMi5jICAgICAgICAgfCAgIDIgKy0NCiAuLi4v
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvcGNpZS9nZW4xXzIvdHJhbnMuYyB8ICAyMSArLQ0K
IC4uLi9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2dlbjFfMi90eC5jICAgIHwgICA1
ICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS90ZXN0cy9NYWtlZmlsZSAg
fCAgIDIgKy0NCiAuLi4vbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvdGVzdHMvbnZtX3BhcnNl
LmMgICB8ICA3MiArKysrKysrDQogMzUgZmlsZXMgY2hhbmdlZCwgNTg3IGluc2VydGlvbnMoKyks
IDIzNCBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxl
c3MvaW50ZWwvaXdsd2lmaS90ZXN0cy9udm1fcGFyc2UuYw0K

