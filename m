Return-Path: <linux-wireless+bounces-9025-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F731909E07
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2024 16:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CAE8B20DF4
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2024 14:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F9E1172C;
	Sun, 16 Jun 2024 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AHQpveG8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A6910A35
	for <linux-wireless@vger.kernel.org>; Sun, 16 Jun 2024 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718549944; cv=fail; b=pMnqfgRlib9bxWV4DsD/0/ETjrsLZdIH93VrJazElNZTHD+XRkHtIZKoZ4xPxxWghy0xHHb2o9i+AP3pQ0PsvH47qZR597/AnZobyrn0guuZc6fkBAuUa25qn7Yom7cYnvo2rzO1jQJkD/R0PwDhJrZfJmPIAQ+zOeVxZ7FZsBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718549944; c=relaxed/simple;
	bh=wRBwMXDiK+sXrbXE68GVS77n53DLeLAmq8aoujNvq3E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A1Uhjag+me3fZ6gidSnAfa0uSQXDFRhBO8+U6mSsEk/cC5kgTa1M3jEsTwZySiFMvkZFy7jTHK9/Q55Fo3NIJ3Vb4BpfVriG/ucAHYsPbFG924qcEq4rOF4IEOX0gknxkfLQvJWkzoi56MUsKPLGZMO8mDIGFo2jzSDBDLlKjVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AHQpveG8; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718549943; x=1750085943;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wRBwMXDiK+sXrbXE68GVS77n53DLeLAmq8aoujNvq3E=;
  b=AHQpveG8bPqcTcl9aCUAQGA4jeZbXZa/YMpOs78Qbh3+WzmutBkt5fEK
   7vkBb4VwlG6dX4BSjbXJ1sksd29T8+bSnHFlulWyaYtLsh+5bvXaaTz6D
   45ulc66M3GF06D4vh9AVwqde+Ib6WdIsY68KzeY6HijeHkSU47/WBsN+k
   iGOTzBSSFxdHEVojuVKCs3xXaTOFL09MzdAHlTaOudFiuWBTWXeMr0jAk
   zy/uxGTldEXIyn+JPSg4KUsEQCapjv14+uoIgSyf2SJWVJcxqsZvBPiVy
   3G6pBqK1ucJcz+TwD6rjr7Oegt6A1jKvSxlhP7O7B798ir8M0Jjkz4JJR
   A==;
X-CSE-ConnectionGUID: rfyrjnNSSxe+mus/f7Q1IQ==
X-CSE-MsgGUID: uNAhwcEVSyCojWoSnj2KoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="19173151"
X-IronPort-AV: E=Sophos;i="6.08,242,1712646000"; 
   d="scan'208";a="19173151"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 07:59:02 -0700
X-CSE-ConnectionGUID: VqkEof6PQmCyPKBsLbB0Tw==
X-CSE-MsgGUID: WvEUWcWBSpGmPJWu4aWNAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,242,1712646000"; 
   d="scan'208";a="45898202"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jun 2024 07:59:02 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 16 Jun 2024 07:59:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 16 Jun 2024 07:59:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 16 Jun 2024 07:59:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9lnfS+oeE51Gi4+9SCTWs3CdjwRMwMJ+vQZ/Dy5skngVR6b11ubQI0YGcXyxYkidfPv6vKCcu5SmQeYaH6BhsmnHSmlZx1rUYLZt+FMew1nfwHJayNdXDNe3nERXOc99jFcruuA9EpLffStV90nSUllvLUiZHm8QsOm92IDQg/EjH7ViZZhQnVFEMqDt/BpfUJW2Po7DCqSSEEuKBGLo15Efkjmpq83rzcW/6R0BL4lSkKhWrAGIEB8oAHR90MqFeValhipW7caZPy5+3wEpZbFHf6tnm3ZqhKAwwaYp/K6e2khu69jAs0T4dtOEBWdmJJ1/xocQTHdZerwbRvV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRBwMXDiK+sXrbXE68GVS77n53DLeLAmq8aoujNvq3E=;
 b=ah8noPMswSpOEKxdOFRkW9JyrCTGZeHTDzItXyQoFm+CusR9q9YMQ1KNtV1xs2d1ylh8CkAnXv9oq9Cf/AyZcM87rK1Koe0YUckVgeP8lLAe88EqGhz5ynHc9KVsMcnWaED6+9/BzCMnEvo5o8t8ZRXMStgX4euY/0Qjxv4zAMicTkj1dHmLVzLSj2vD52xajEIPxg8aDKu8Ju7ks5WBwSyNqenL+11tJ0/CXsg7yd1/121VXpuXK6dBmnniZDngCChfhYVij6b6bmd24wR3x9CxvhdTbsvQ7jwkWPPmW2UQNtQRIO2cW0CfphqVn9pv/Sh4iXu04Jz2JOStwcuUXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6043.namprd11.prod.outlook.com (2603:10b6:8:62::8) by
 CYXPR11MB8692.namprd11.prod.outlook.com (2603:10b6:930:e4::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.29; Sun, 16 Jun 2024 14:58:59 +0000
Received: from DM4PR11MB6043.namprd11.prod.outlook.com
 ([fe80::4e37:abb:3577:fbf1]) by DM4PR11MB6043.namprd11.prod.outlook.com
 ([fe80::4e37:abb:3577:fbf1%5]) with mapi id 15.20.7677.027; Sun, 16 Jun 2024
 14:58:59 +0000
From: "Peer, Ilan" <ilan.peer@intel.com>
To: Kalle Valo <kvalo@kernel.org>
CC: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "Berg,
 Johannes" <johannes.berg@intel.com>, iil_jenkins iil_jenkins
	<EC.GER.UNIX.IIL.JENKINS@INTEL.COM>
Subject: RE: [PATCH 6/7] wifi: cfg80211: Add support for interface usage
 notification
Thread-Topic: [PATCH 6/7] wifi: cfg80211: Add support for interface usage
 notification
Thread-Index: AQHatzc0yb7T+43A3kaSl/T1R0ONJLG6eZjcgASS/ACABU2ww4AGL7cQ
Date: Sun, 16 Jun 2024 14:58:59 +0000
Message-ID: <DM4PR11MB60435B5F50827F6ED8E8115EE9CC2@DM4PR11MB6043.namprd11.prod.outlook.com>
References: <20240605105722.2034610-1-miriam.rachel.korenblit@intel.com>
	<20240605135233.23d15e758640.I7a62740a6868416acaed01e41157b3c0a7a41b4d@changeid>
	<875xummndx.fsf@kernel.org>
	<DM4PR11MB60436A9107BCBC27294DBF22E9C52@DM4PR11MB6043.namprd11.prod.outlook.com>
 <87ed92nngq.fsf@kernel.org>
In-Reply-To: <87ed92nngq.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6043:EE_|CYXPR11MB8692:EE_
x-ms-office365-filtering-correlation-id: a12a35ee-63f2-4bae-ee5a-08dc8e14da5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?eENTejhOQkJObThOZzUwSHhid3o2bVRnTjVtUVRnNWZjMkZ1VFpkclpPQ2oz?=
 =?utf-8?B?a056dzNMQ0hMd1loaFBYZFF0bThqYzdJVXJVb05lMUhCMHZ3cFhMWjM3U1pF?=
 =?utf-8?B?M0ZCYkdLa0xXVnVqcXZYbjdBK1l2SDZNS2NxV2JqV2tta2R6QVZZajNCNFNm?=
 =?utf-8?B?SnBIS0ZLc0ZFUUg0Z05MWlZQcG1kbWp1WUxUMWZKSWQ5RzB1alAyMTdZQnh1?=
 =?utf-8?B?SjR5UnNRSEpWSUhqMkdycmpqNzkxTWxZbmYveDl1TEgwUDlHTzh0cHk4d2Fq?=
 =?utf-8?B?eHRvejUxQktxRDhmSjczbkZkb3dMMlhiRS9ZcUdNbjlyOUphaVB4c1Uwd3dD?=
 =?utf-8?B?N0xDeXZKeXJQTE8vSURtRU01SjRPdVBROEZZckFhNjlaZ2FYZ01kYVJ1RWd2?=
 =?utf-8?B?aFdNM1V2OUc5VFZRZjlrZG5iYnRRWlh6MWprMGxmazEvU2NZWVZNWUVkUkVT?=
 =?utf-8?B?R1FjdHE3OW9YaWZPK0xlOXBJblIxeGtoMUF4RkQwVnVhWEtrVmVMbElWdEx5?=
 =?utf-8?B?Syt2RWI1c2s0bE1GNTdkOGx2ZEdCeS9KZ2RwL3NMQzlWSXpPRFR0SmU0UmFp?=
 =?utf-8?B?U2Zpdk9QSWZJV2VLQnRubzBYNE13YmJDQlZ6eTJiRGtaSjVybjJ5TUhjdFA2?=
 =?utf-8?B?TDFadDdFZ2FWazRuVnV5dWI0RDYwaDFJRGR3VVdTSHpETjNiSTFwMEN5YkJE?=
 =?utf-8?B?clVjT3NFNzJiak1pL1lMRmNWNTZMK2g4R3pXREFRTUJ5NnZHaHlIWmdDMUtj?=
 =?utf-8?B?U0tSa3VVZ1VUdlBXSllucmtxYUVLTTA1ZmhhaUtoR05OU3pFRDNVeTRNRnIx?=
 =?utf-8?B?MjNITkZaYUNXWnRqeVUzQjRvTkF6Qzhsb0Mzcnc0RVNCQXdCYVJmaVZLOHZI?=
 =?utf-8?B?WTZ2LzRYV3FqcVowSVhZb3NzTkVJYmJNajJ6UUlUZGQ0WC9ITGNvenpReGJJ?=
 =?utf-8?B?Z3YxdHZnMWJZTTYzMHF2Z1c3VjV3QkdjSXpNM1EzSlZSMjhnUlZ5aWJMTVVp?=
 =?utf-8?B?UFh6Tmk3RGJPTkhhTVJ2VWFEcmtDdGN0SDJUSFEwWmgxVDBvUXNYUVZxVUhq?=
 =?utf-8?B?dm9QNUo5Y0wycThGK1JieUlrdjRHSXRYY3BMZGRQeVJhSVlBOWhFRFdpS3FZ?=
 =?utf-8?B?RkpoczA0dUZmZmhnS29oNFlSdnMzd21JQWtLckNQd1lESUhBUTRWNDB6Vyt1?=
 =?utf-8?B?ejA5UWlUNDFqbzVWN3dYTTVvdkdFTFBGWkt5TXdDSEJMUWdYM1VtMkxjQUx6?=
 =?utf-8?B?NThsUVB0QnNKY1d5cGJRY1Jibm40aEViSnFSblVGaDFTY2N6aW5XdExLNkxr?=
 =?utf-8?B?YU5JcFNDTytGNUtnR0hDUjhQbDliQWMvWVBMNUQyWVZ4emFNUFFmNk4rM24w?=
 =?utf-8?B?MzJyUXdTL1gvZmZLbVhkc0orTkJ3d3Z1QkZqZFhUaHc3VG9ZblRYakdYYkxJ?=
 =?utf-8?B?TUJKUFlKT0NVZ3d1eDN6VkZralJJRE9oWE10R1BzWXBZcFlHYkpoRWZqa2I5?=
 =?utf-8?B?ZlM0MXhoalVXS3ViYzRNSkdnc2JHT05jWW1iajRMZjk5OHBxMzlHR1VCNU1v?=
 =?utf-8?B?RDdGdE1pZHQvblFGODNBRTNaZ1U0dEFrbUhGZTdZOTdad2pILzVGZ2c0eXh6?=
 =?utf-8?B?YldlRU1Wd09tOXZ3K2dsRTJDaVB4YWlCZzF0S1NOSnpaOXBPM2puS1lQZWtx?=
 =?utf-8?B?Vzk4WktkMFQ0d1ZDYUxCVHVuTXdMYXI1YjZPVmh4ZHQrSnpnWXg1WHZPU3R4?=
 =?utf-8?B?clNMREM4NWhISEZzekdLZkFSR2tCL05TSDM4Z1pOMW5RUTM2bXVFU1JGNlN2?=
 =?utf-8?Q?3IsJyzMC18wyJYu5DgSfQXeGeoMRiJFkoBA9g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6043.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sm80N2pSSDhNNk1FT0hrQll3Z0s5YXp1dVNRNTBaYkZCdFNzQUNXdDUzNU03?=
 =?utf-8?B?ZVFOUjlRaWdDYWZNK2p5SVBQWmFzV3ZOcXhrQUNEa2NKQnh2K21adDBDVzNn?=
 =?utf-8?B?QkFkNnJkczJaSHFJU1JXMkYzVHRBZC9lQUFXR2kwNS91cmJUcTltbk56dUU4?=
 =?utf-8?B?RFhDRE1wQXNpQnBVS1ovTUFUT2E3MFRrcXEzeTBJUU84aVN0b2UzaHBGUFlW?=
 =?utf-8?B?aVVzVTE5YkFmTVVZTEVqRytRc3hpZDVyeWNFNGM4V0d5aWlkVmRRRlJlWmJm?=
 =?utf-8?B?S2lUclZwM05URkI3Zi9FWkMyVkxTM0RwSlJKTWpsSEFoSlpmeTNCcngzUncz?=
 =?utf-8?B?cTc4SDgrOVNoLzE0eVVnb3lwVGFOKzNRNUh2ZDl4L1ZiMkNjWXBOV09PRDNS?=
 =?utf-8?B?dGNSOU52Z2RmSXN4MHhlM2RwNDdlZURqMjlMb1ZjMmVjTFVXVStsNEFuWDd0?=
 =?utf-8?B?cmkvR0dpZDh2WHNhTlI2dVJseUlENXZQaEt5OHhWaDZOMmZjQVVVVU5uQis5?=
 =?utf-8?B?MnM1SXlYd01jZjE2RGNQemdMM2VuYkFZTlYxZGNSbHJ0N243UDA0M3pvTjFB?=
 =?utf-8?B?VjBPVURIZGlGUmhKQk54WWV6UjJHbG1ITnpJRkRid3NhOW9BWmY0My9uS3ND?=
 =?utf-8?B?Sk1GYjBqamJBRnlwcys5T2VBdXNqeXd3RlpYMmpEcHIzdFdwTFQydnN0SHN0?=
 =?utf-8?B?Zmhha25VaHUwS29EWUpRU0p5Wnc5blFUbG5IYlZQTmFtK0Z2elJhZGt2azRS?=
 =?utf-8?B?a2pzYzFJOTV6RnhCZVNKOWNXVjVOaDd0YzNoQ3A5NDJXcW5LVnBITzYrU2Q5?=
 =?utf-8?B?MnVQTmdTVVAvTDNuTFlsTXVDd0VueG50SjRaZS8yWWdVejNQNGtlR21nUFpM?=
 =?utf-8?B?R09ZM2xCWFZVSDduVlJzWkExV1RrbVFtdkViM0lZa3VUUkYrU3l2TFdVb3pV?=
 =?utf-8?B?SlJabjNKQnVCN0xZRDlGQk4yQmdKZnRzbmVZWEtWVW9tZmRTY1V3djA2aEJJ?=
 =?utf-8?B?SU5kQXUrZEhoYUtZK240bExwdE9iOEJnMXNEY2wyc1NqYWsvOGZIVUZtSk1j?=
 =?utf-8?B?clpCU25DaTgzTmVqSmYxdXlrQXJOMC9EMDA5SU5FSFk3RU5kNit1NDVDUXJt?=
 =?utf-8?B?U29xKzlRKytqdllodDJmNVg0THRvaVNrVElCdjByU0lTclErSk5OdnpJdTYy?=
 =?utf-8?B?cUFrREw3M3R1OW5KaWtEU3YxL3JQaU9JMk54bnhzemx2Qkl3NytsYmtqU2lu?=
 =?utf-8?B?MzVZYkwzN3JpbzB4VlBMRkU3QnJHT0NaT1FsN1dSeVJnZm12T0JuQkw1TnBT?=
 =?utf-8?B?TE5LaTJPNnI3TUxXWHFmZHlNS1pLTnp5TnVKSXNJSWk1QmFZQk5tWmZyNGdG?=
 =?utf-8?B?dWoxOWJwSFF3UUpFM0luVjdDcUVOZ2xDZlNCS2ZjSnF6Nlh5ME9uSEhFZlNB?=
 =?utf-8?B?UmswdzN4YWR2bk9KTU5tbEtVaVpWNU1Qcm5FM2REQ2VOVXhQZlZDUm9kbWVX?=
 =?utf-8?B?T2xSMXBwYk1NcVFXeVVZbStxd2VVb2l0VWlPUzI4QlZKaHpPVUl5S3R6dXNz?=
 =?utf-8?B?cDE1TGhjQ1F6aURDamFZNFVLN2lRbEtOb3B5eDVGUmFnb3B2NkhqbzdJbUlD?=
 =?utf-8?B?d2ZjckJOc0dQS1hqcDNibDdiRnRlTjlISE04cjB5MkpXdDdOdGVFVVU4elhD?=
 =?utf-8?B?YkY4bG5CS1hkVFp0c2wxS1ZwcXAyNzgyZEVtcWZzd2I4TkczVjlBblkzN2pl?=
 =?utf-8?B?ZVF2SjVGTDNrL2hWdElKZnZmc085b2tFMFpvcURzMWxsSllRZUVsVXBQQU9L?=
 =?utf-8?B?OEFzQk9OSmZTNjFuM3V3NTl6NU8vOEo1bmw4d2dhbzZML3NOREE2cm1pa251?=
 =?utf-8?B?ajlRRU9MZXJkOFVTb09wOG5vRWtFYXVQZjRRVjB3THlJWE82YzhUMGQwdmRM?=
 =?utf-8?B?SUVLVTBnL00zRWVVUXhOSTAySTI0UUl0dVM3ZkdKRDRiaDkzRC8zb0lwYUp5?=
 =?utf-8?B?RzVxalhlMFRKWWVFSXVZWEREL3BHZU9vajhBNXhwTU5qc3hGaGRMc0VtclZN?=
 =?utf-8?B?SVlwNm8yQm1xdHZYclJlWUV4eWxtOW9tVnFMRTlMa2dJblpSNWduNHZPSzVh?=
 =?utf-8?Q?8zZU1f6zAVvIJ04i+Ey7Qpoa2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6043.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12a35ee-63f2-4bae-ee5a-08dc8e14da5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2024 14:58:59.3485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BiIWrwBFHSPoVlaMR8xEPVPKceWSP3yLwAxfPTYHIfZiZOTbGz7a1f4l55uvtqeJq4EelydYTHWXfnwvJo+zDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8692
X-OriginatorOrg: intel.com

SGksDQoNCj4gPg0KPiA+IEFzIGRlcGljdGVkIGFib3ZlLCB0aGUgbmVlZCB0byBpbmZvcm0gdGhl
IGRyaXZlciBhYm91dCB0aGUgaW50ZW5kZWQNCj4gPiB1c2FnZSBvZiB0aGUgaW50ZXJmYWNlIGlz
IHJlYWwuDQo+IA0KPiBTdXJlLCBJIGNhbiB1bmRlcnN0YW5kIHRoZSBuZWVkIGlzIHJlYWwuIFRo
aXMganVzdCBmZWVscyBsaWtlIGFuIHVnbHkgd29ya2Fyb3VuZCwNCj4gbm90IGEgcHJvcGVyIHNv
bHV0aW9uLg0KPiANCg0KSWYgeW91IGhhdmUgYSBkaWZmZXJlbnQgc29sdXRpb24gaW4gbWluZCwg
cGxlYXNlIHNoYXJlLg0KDQo+IEFuZCB0aGUgZG9jdW1lbnRhdGlvbiBmb3IgdGhpcyBpcyBxdWl0
ZSB2YWd1ZSwgSSdtIHdvcnJpZWQgaG93IGRvIHdlIGdldA0KPiBzaW1pbGFybHkgd29ya2luZyBk
cml2ZXJzPyBMZXQncyBzYXkgaWYgSSB3ZXJlIHRvIGltcGxlbWVudCBhIHVzZXIgc3BhY2UNCj4g
YXBwbGljYXRpb24gZm9yIHRoaXMsIG9yIGEgZHJpdmVyIGltcGxlbWVudGF0aW9uIGZvciB0aGF0
IG1hdHRlciwgaXQgd291bGQgYmUgYQ0KPiBndWVzc2luZyBnYW1lIGZvciBtZS4gRm9yIGV4YW1w
bGUsIHdoYXQncyAic29vbiIgaW4gdGhpcyBjb250ZXh0PyA1IG1pbnMsIDUwDQo+IHNlY3Mgb3Ig
NSBzZWNzPyBDYW4gdGhlIG1hYzgwMjExIG9wZXJhdGlvbiBzbGVlcD8NCj4gDQoNCkkgdW5kZXJz
dGFuZCB0aGlzIGlzIG5vdCBjbGVhci4gVGhlIGludGVudGlvbiB3YXMgdG8gc2F5IHRoYXQgYnkg
dGhlIHRpbWUgdGhlIGludGVyZmFjZSBpcyBlbmFibGVkLA0KdGhlIGludGVyZmFjZSB0eXBlIG1p
Z2h0IGNoYW5nZSwgYW5kIHRoYXQgdGhlIGRyaXZlciBzaG91bGQgYmUgYXdhcmUgb2YgdGhhdC4g
SSBjYW4gdHJ5IHRvIGJldHRlciBleHByZXNzDQp0aGlzIGluIHRoZSBjb21tYW5kIGFuZCBkb2N1
bWVudGF0aW9uLg0KDQo+IFNvIHVzZXIgc3BhY2UgaXMgbm93IGFsd2F5cyBzdXBwb3NlZCB0byBh
bHdheXMgY2FsbCB0aGlzIG5sODAyMTEgY29tbWFuZA0KPiBhbmQgYXQgd2hhdCBzdGFnZSBleGFj
dGx5PyBPciBpcyBpdCBvcHRpb25hbD8gQnV0IGlmIGl0J3Mgb3B0aW9uYWwgd2hhdCdzIHRoZSBw
b2ludA0KPiBvZiBhZGRpbmcgaXQ/DQo+IA0KDQpJdCBpcyBvcHRpb25hbC4gVXNlciBzcGFjZSBz
aG91bGQgdXNlIGl0IHdoZW4gaXQgZXhwZWN0cyB0aGUgaW50ZXJmYWNlIHR5cGUgdG8NCmNoYW5n
ZSBiZWZvcmUgdGhlIGludGVyZmFjZSBpcyBhY3RpdmF0ZWQuDQoNCj4gPiBXZSBlbmNvdW50ZXJl
ZCBzZXZlcmFsIFAyUCBjYXNlcyBpbiB3aGljaCBhbiBpbnRlcmZhY2Ugd2FzIGFkZGVkIGFuZA0K
PiA+IFAyUCBHcm91cCBPd25lcnNoaXAgTmVnb3RpYXRpb24gYW5kIFAyUCBJbnZpdGF0aW9uIHNp
Z25hbGxpbmcgd2VyZQ0KPiA+IGNvbXBsZXRlZCBzdWNjZXNzZnVsbHksIGJ1dCB0aGUgUDJQIEdy
b3VwIFNlc3Npb24gZXN0YWJsaXNobWVudCBmYWlsZWQNCj4gPiBzaW5jZSB0aGUgaW50ZXJmYWNl
IHR5cGUgY2hhbmdlZCBmcm9tIFAyUCBDbGllbnQgdG8gUDJQIEdPIGFuZCB0aGUNCj4gPiBsb2Nh
bCBkZXZpY2Ugd2FzIG5vIGxvbmdlciBhYmxlIHRvIGFjY29tbW9kYXRlIHRoZSBQMlAgR08gb3Bl
cmF0aW9uDQo+ID4gZHVlIHRvIHJlc291cmNlIGNvbnN0cmFpbnRzLg0KPiA+DQo+ID4gV2l0aCB0
aGlzIG5ldyBBUEksIHVzZXIgc3BhY2UgY2FuIG5vdyBpbmZvcm0gdGhlIGRyaXZlciBhYm91dCB0
aGUNCj4gPiBpbnRlbmRlZCB1c2FnZSBvZiB0aGUgaW50ZXJmYWNlIHNvIHRoZSBkcml2ZXIgd2ls
bCBtYWtlIHRoZSByZXNvdXJjZXMNCj4gPiBhdmFpbGFibGUgZm9yIGFsbCBwb3NzaWJsZSBpbnRl
cmZhY2UgdHlwZXMuIFdpdGggdGhpcyB0aGUgaW5mb3JtYXRpb24NCj4gPiBleGNoYW5nZWQgZHVy
aW5nIHRoZSBQMlAgc2lnbmFsbGluZyB3b3VsZCBjb3JyZWN0bHkgcmVmbGVjdCBzdGF0ZSBhbmQN
Cj4gPiB0aGUgUDJQIGdyb3VwIHNlc3Npb24gd291bGQgYmUgYWJsZSB0byBiZSBlc3RhYmxpc2hl
ZC4NCj4gDQo+IFdoeSBub3QgYWxsb2NhdGUgdGhlIHJlc291cmNlcyBkdXJpbmcgZHJpdmVyIGlu
aXRpYWxpc2F0aW9uPyBPciB3aGVuIGNoYW5naW5nDQo+IHRoZSBpbnRlcmZhY2U/IFdoeSBuZWVk
IHRoaXMgd2VpcmQgaW50ZXJmYWNlPw0KPiANCg0KQWxsb2NhdGluZyByZXNvdXJjZXMgdG8gYWxs
IHBvc3NpYmxlIGludGVyZmFjZSBjb21iaW5hdGlvbnMgZXRjLiBpcyB3YXN0ZSBhcw0Kbm90IGFs
bCBhbGxvY2F0aW9ucyB3b3VsZCBldmVudHVhbGx5IGJlIHVzZWQuIA0KDQpSZWdhcmRzLA0KDQpJ
bGFuLg0KDQpwLnMuOiBzb3JyeSBmb3IgdGhlIGxhdGUgcmVzcG9uc2UgKHdhcyBPT08pLg0KDQoN
Cg0K

