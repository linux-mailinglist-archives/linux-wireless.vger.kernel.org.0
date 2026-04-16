Return-Path: <linux-wireless+bounces-34875-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EcwKeWi4GkEkgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34875-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 10:50:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE2640BD63
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 10:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EE3A302E0DB
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 08:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BAD37F8DB;
	Thu, 16 Apr 2026 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EOE+NWlo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1109637F013;
	Thu, 16 Apr 2026 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776329223; cv=fail; b=Fteg9US6NMVLzgyhzhn9piSBNDQOUjtft5HHD1LMUXjGmLdNaex6f1/Sc3EuQwduRZ8h8IHH3W7Y/uRddtHWv4MyUrNMZJgfjjECJsO+e1lJjRRtUyU+Puff4VGgjVa18/bY3M8PBJH4APgNary8mGHsRmI8nuZnI7qQPIc7nSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776329223; c=relaxed/simple;
	bh=JaPCJS1SImXCa7w4sUlzIyrAi+Ojy5TyfMSKxAzr3nk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NNgrINdZLoMDSy+X38Ysey1xdmcwbBz5SJFNWjnTV3CuyOicmFvLAS3wBHE6UTVtZ/yPrwBtbRUxkIkM8QDJmiOdGU+6QoeNoGwB11HvtMyFpIXHYq3Z0AErCpp6Gm25HBy4+dLG1Te6KMro2sdSZlJ7zYmPBENAsRI2l5OAQp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EOE+NWlo; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776329222; x=1807865222;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JaPCJS1SImXCa7w4sUlzIyrAi+Ojy5TyfMSKxAzr3nk=;
  b=EOE+NWloHXEK1nk3IbvGKVob93EKnYTMccnALlK9AEWHCuaGVe9SSaD0
   TdzaovEuSkPaVPBOLZVx//aCrbC0gGSB5eofo/n/bt0ckIg7k3cZ+f7I6
   rVF81Eu4+/lb9YTeIjpIExHG3/iU+RrG94rYydgcvp/PNfADowkvJVri0
   uDZjKKkRnWGbD5cI6JRjiQRrDavQqAxj5WzNol6E+FFl2a1INSzjEnemE
   aF7w9zBwlffOhExDxrQFGCaIBRac4Ann6pIARuvfpMm9JY5o8OyjE0PF/
   OZmnA0e4kCDv4r6hQgTp+EJPxtzYfUdnqknh90JSpK+Ry4PDy3lpFKSgN
   Q==;
X-CSE-ConnectionGUID: iXC3LlkDRh+Zc3OXxiPn2w==
X-CSE-MsgGUID: fsnDb47DR2Sv9299faF+EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77395448"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77395448"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:47:01 -0700
X-CSE-ConnectionGUID: kqweUdR6Rh27e0rsHkGHnw==
X-CSE-MsgGUID: yDiD9fFXSwutieipZ0s0BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="261097906"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:47:00 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 01:47:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 01:47:00 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 01:46:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkmntYi2DfxvnG8zRzqxBtEvN4gYT6c1K6nT5KIiZiJV5skdG0btiAumjwetpyQsVrrROmF9gAuxMNsPnyDnKMixzzx7dY/kRa+Nu2BYCk1Dytpf2YRkIK8/OSiFmB/2+kWxFmr2x1hy5OTXoi5/XpBQS2VhW9BfvcKrYKcqrhLlWOvwTqtwOdbSscj8BRzIIA9IkViHiIF6ICP1K3GQBi5OQDFNuQqWDc8Oc+tfwjr5CRimUiGLRwIzbTuQc8rqNewI9iT8uqVOUO3UCD/6CwWyCXoiCnYJ4ApO1iKVXhi7WW+pf3rBYtuAwc+je6JsotvcaZuiq5NCBPX1gUyzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaPCJS1SImXCa7w4sUlzIyrAi+Ojy5TyfMSKxAzr3nk=;
 b=atOC5RYGUY/Zhs8sFg/RxZGC9xcfSoExsKUMy+VNjdKivBtxi93oB6V9J/lN35/ulA15jEptb+ed02TZ89fsbzoQsCoy+gh1IUjni4SXVSI+sSYBu6gbeduYhnsdSX+KnVnrCtwuyfpal3EjvY/bIkx4ElLS01Shi7z7BGNJr764jzXUaiK0mxVcEvnBubsaMlbtw9a591iFfCjLcG035kAvUgbN8LBggK2spRZYv8iPs5HjpPBzGeTSsLlCkmgUvamkxbqEd+glB9hSKvkp3oUYwJQJCQF0ggA2iKxlXWFMazJLnFoWiDmZC1/g+CnnEOpDQII6eNeQe6AZc0OcwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) by
 SJ0PR11MB6816.namprd11.prod.outlook.com (2603:10b6:a03:485::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 08:46:50 +0000
Received: from DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2]) by DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2%6]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 08:46:50 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Sheroz Juraev <goodmartiandev@gmail.com>
CC: Johannes Berg <johannes@sipsolutions.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH wireless v2] wifi: iwlwifi: mld: stop TX during firmware
 restart
Thread-Topic: [PATCH wireless v2] wifi: iwlwifi: mld: stop TX during firmware
 restart
Thread-Index: AQHczXxKk4wncqCqG0GMuEyMqx8aK7XhX3Kg
Date: Thu, 16 Apr 2026 08:46:50 +0000
Message-ID: <DS0PR11MB788054E766E886D97C965E89A3232@DS0PR11MB7880.namprd11.prod.outlook.com>
References: <CADPJysx0mCpzh7b=kJC_OsZGvME9inx7EYo0imYwniCFO02FLg@mail.gmail.com>
In-Reply-To: <CADPJysx0mCpzh7b=kJC_OsZGvME9inx7EYo0imYwniCFO02FLg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7880:EE_|SJ0PR11MB6816:EE_
x-ms-office365-filtering-correlation-id: de01ddd1-ff35-4bb7-23fd-08de9b94b3a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18096099003|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: hv8INn86Of1P7B329rG5ZBmtRJdeJljypWrFQxLTTtbqrEtOJY7cEw2fK2OUABgzsOE9O29n1fE2UWA6IKGE07ASvs2QMyhtF32SycThYKgK1j99GRkZc7zDgoAkHKvG9mixdl5jpy18lP+wQVS2Q+nFWchyCSRT23ukBUayKhZAYMB2IHTWkUKOwJrNEi8WE6FBNIhR9tgqLH5AIY90/DlFyKqqrr3h8utM4qnuampAm5QxgEaAqFnDzPNLMA6H7gy1TM5iOvEtpVJ/tt7+fqV2RNJkboLne8GcI/2vb9XXXL6dz2LteZ4eUw+4xbbDcB6qUVCNPqcKjnAwMjOD7cBy8MHZjbtlp6TwNB1lEgVgfn4Zn2+6cp3N9gC1pV/fI1Zp+m/lzuk/WvPf9EQXp0yYGRcvg1HXVLB+IZakTYRySTtV+vXD+UhzhUZT9ojQjgMtGifQEi8dUn3I/VCYsOeoDNdj4is/333JhmzBzXSaDDwQtjd5MYLc1dZIBAuKoQ5v9ZZimxKDu4um0KTAOL+IZVzgLDqhgi540FBfJthry9w9y3olAxc5811ZfwkYHh7erNF8+mwxNJ5bkcgevlFTEz46ynIvu4+NzGtILSnYMrthUb2BOtkdMa8YDo6v2LgxamoZbMEZpOgqSn2eKFMJ7s1LnQVETC8h1bwKeIWTpjJhAkrTkjpWSfsWsZSIQDc/7x/B4CrQnH6vzRJ4ypAZvZM59sRa7V+jpCkpsmOolNjBSwatnSPDQl2/xMOveQ8wYSRVb2ssLF0Kb29TscPmU3bo9+jCIvhMyvh4O0k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18096099003)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkZMOXBvSGJaTmZrQjRNVS9nclZxaW1OWWxjSC9mU2ZnNCtza1ZOL3JYQTdC?=
 =?utf-8?B?bDZqRVYzWTlEZHlQbTI5UXIwSndYOVo4ZCtnWEZqaVZFcm1ZYlQvVG8wd2p2?=
 =?utf-8?B?K3lnb3Y4empHcVRwbkJnZm1OQVV5dG80L056ZFZqc0o3WFlVancvVXcydGdq?=
 =?utf-8?B?OC9Tb0h2Q05xWjZpS1Fvek13M2hkbm9vUzhnN3NrZisrcitlcEVqeUozcWJn?=
 =?utf-8?B?c0EvR2RJYmtrSUlyU0xXSjc2V29qUVdNbmIyRUh6T09peVhoTngxaFZGNisz?=
 =?utf-8?B?cmoxTWVIQktkZjhjNXV0ejZYd28rdUorZHBRZ0JUaTBoZE1wbmNXM01idEor?=
 =?utf-8?B?TmdESWZicHdLc2RPdDZGODJHNGNXNkoyd0ZnZnlleHlzeVNLTEJhd2RxQXhs?=
 =?utf-8?B?d0UwSW5LMERBVmtBWHhweHdWZ3ZVVnNycmpIbHhQOFFZL2QzMXREb2dFcHo0?=
 =?utf-8?B?Y0w2dHV6SW5lYlRjNmRTUjhOMHpKZjB2NU5FaG9sNklBSktISVp6RlBoL2xY?=
 =?utf-8?B?Z3d0c2xqczRGUUtEMHJZSVdCdEc2T2xybFQxMFprbG50MmlkQit4aEpjaXZj?=
 =?utf-8?B?eWlna1ZBcEVlR0RSWWNjNFJHSVlwU3haanhqSm1BVzE4Wk9xVkRhYnhZOFpW?=
 =?utf-8?B?bjFTZjd1cUF0MmtEY01nWVhOUWxRYzRaOURWMUNObTA5cEJwOFF3ZHMzSXNl?=
 =?utf-8?B?cmFMSWRkMXdMR1gzakgxRXY0RHQ5Um41QkdvWFdhMncyOU5ZcWY0QVNxOCsy?=
 =?utf-8?B?Rm1hdkpkRCszbGRuRFZPTUxEWVJCcEpsaTgzZG9qVm82SnBlRmFuTUZqQlpm?=
 =?utf-8?B?T1psQTFULzFMSlNCbDZLN0I1NnpjaEtDb3VCNFVXbC9NeTVYY21PRTJjcHRh?=
 =?utf-8?B?d0k1V2pwVHJSVVh0VjR5ZkhLblVxNzd1bnpENEtCWENtU1hpdG1MbmJXMysw?=
 =?utf-8?B?NWVUbFMzTUhHYjhGemFsekxEeUQ5Qzg1NkdOdjRNaXBFYjljWEpvTmVSTGM4?=
 =?utf-8?B?R3I1c0NRN3NOankwdW15QUFBVDAweUx6eGozL1YvYkEvOWpFS2NYNHNCSWZ4?=
 =?utf-8?B?bG5FY0F5TkVwRGRUMi9Jd0FrQlUxK2FaV01pTG1XYWh2RlRvcVJ0T2VVM1RE?=
 =?utf-8?B?MmcrcE5wdXUzWThJNkpJMlhvcU44b1ZxRDZGMXRsNkJzTnhzbTZUa005ck8z?=
 =?utf-8?B?VCtlbTJxUnpHYXJ1STRnSEdmbDl6WVFyOStoT1BkaUNMNEVaZC9hR1dFK3dT?=
 =?utf-8?B?V3B4MHlzOWRiTEFxKzJCdGRWSlZZMVE3cis5cnQ1cE80UU9rTXE1QWw5TEtD?=
 =?utf-8?B?blNVRTM2aE0zZGJPQno2RnNndTV6dzhCSGxnOFlZcnI5RWkrTjB1MWN6cnFu?=
 =?utf-8?B?Yy9zN1c3SmtjZ3JVNUhNeDNaZXJsNzJKZFBXRXpWMFkxbWdYUjFIOUY3RG81?=
 =?utf-8?B?Zk96N2VqcVZiaEhwWDJYQ3dEdkUrUHZWbi94NmpNZWF4WWtQZW9qWU1zTWd0?=
 =?utf-8?B?MWlYekhkR0dJdzNyVnlwVDZIdkVHNnlsTUdPZlMxeDhycFlVeThXRXdBZlln?=
 =?utf-8?B?bGJFL1ZwK2RzUXFUc2oxTysyaXNIVUM0T0JMNHFpTThSZENYUkFmNGErdi92?=
 =?utf-8?B?QUxaV2tDaUlQYmlTWDNJNTVvRkE0bXBrU1JYTnRiTlpydkhqVTdvNUJzMlJL?=
 =?utf-8?B?UXV0d3hHM3l0Qm9xTFJ4Ris4a002eFRodEQvSlE3a29rTTFFOFhwUXJXY2Ni?=
 =?utf-8?B?ZWhjeDkvaDJ4c29SVy9oVDQxeEliQXNCUUNoN3hteVJZdzl5anRYWGJ3VVg2?=
 =?utf-8?B?QWJEdFhlZUpPZTNLa0dNUERORzQrT0VtMVo3NDAwWStRSGNzRXZEOVo1R1Jl?=
 =?utf-8?B?bzJxclhNWk5TUVJxOEpNM3BZeFJLbXBoRnB1UnZod3ZUVVFyczlIb0FFRU9Y?=
 =?utf-8?B?eE5USE5VQUgwdGdXaExsMktqbjRMVFVCSXhPNlR4bVJKMHU5dW1DMW5GVVFp?=
 =?utf-8?B?YTBlcTJGMUhRRk0xMmVSYkFOZHhlaGtYbVBERW9kTXV0MCsxREY2MnFFQTFD?=
 =?utf-8?B?ZHBsajlHZVRXRGxlWGJqRUZBNmdlZlBKKzJvV0pyRzZ3OXBNSnltNndoK25B?=
 =?utf-8?B?TmRGRXQ0a3dJckpWbmV3aU5XVzNiK1VRQlNDSFM4cm5hemFXSUNYYUlrV0p3?=
 =?utf-8?B?TXZXa0RyK2xNUEo3OUZ2QWpTbEFSRlBZZXE3cC9VQkpVeFdhODZ1aXcxbnE4?=
 =?utf-8?B?VmY5d1VEemVVVFJpRDBPWksxSGRkQ2M1WnNVZDlRbVFGeTZvNjljQjhIQU5l?=
 =?utf-8?B?QVFRTUI1SjU1V0R5VklvQUVHMUY5YUxwcFRUczZVWkNqSjYxV0VRRHpxb1lO?=
 =?utf-8?Q?0809XVL/4mWx1IdI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tXWlrA8w+U9Qt+17hG16j6FuF25/mHWl87otRDkgUrEyB5gghcGV9d1GcRZNestDxTVDKMfi+xJ1KR2XfLyrLeO4ormSJdirRgV+YdSEZla3SjrllsuGR5kDzlqPktXAVGZ4ZTYL2xEvBUysx+kvkhovMA9RCF8EpcHZvvXn3eDU6ZN9BB4mPgFWQwr7C0uUi9JeUbzTWnMfHzovtmKsf7QYuojTnqx9YOKRC37TZdP0yX5KziTjeuivvTWDr3PtasaeXE3LlfB2yUn+WTySuKDMmIQUZCp/bIdLqf7vUd41xS3e59yXAlQgT8IXKL0eG+iYmwEMd481+0q1dENFTA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de01ddd1-ff35-4bb7-23fd-08de9b94b3a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 08:46:50.3801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h5UbfM0XVgvlSQYH9wt9kkWaOM4SoB/hvea+Sh/WZNa40lQZJWKj6dAoT63pUoFaZMqm5CFXSvPf1214hLsk7tqUt1EMvwBO0VX0CA+lnMYifFSFF74thzQAy/VNtcjP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6816
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34875-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:email]
X-Rspamd-Queue-Id: 2CE2640BD63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hlcm96IEp1cmFldiA8
Z29vZG1hcnRpYW5kZXZAZ21haWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMTYsIDIw
MjYgMTE6MzcgQU0NCj4gVG86IEtvcmVuYmxpdCwgTWlyaWFtIFJhY2hlbCA8bWlyaWFtLnJhY2hl
bC5rb3JlbmJsaXRAaW50ZWwuY29tPg0KPiBDYzogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lw
c29sdXRpb25zLm5ldD47IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsNCj4gc3RhYmxl
QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHdpcmVsZXNzIHYyXSB3aWZp
OiBpd2x3aWZpOiBtbGQ6IHN0b3AgVFggZHVyaW5nIGZpcm13YXJlDQo+IHJlc3RhcnQNCj4gDQo+
IEhpIE1pcmksDQo+IA0KPiBUaGFua3MgZm9yIGxvb2tpbmcgaW50byB0aGlzLiBVbmZvcnR1bmF0
ZWx5IEkgZG9uJ3QgaGF2ZSB0aGUgcmF3IGRtZXNnIGxvZ3MgZnJvbQ0KPiB0aGUgb3JpZ2luYWwg
Y3Jhc2ggZXZlbnRzIOKAlCBJIGRpZG4ndCBzYXZlIHRoZW0gYXQgdGhlIHRpbWUgYW5kIHRoZSBq
b3VybmFsIGhhcw0KPiBzaW5jZSByb3RhdGVkIHBhc3QgdGhvc2UgYm9vdHMuIEkgZG8gaGF2ZSB0
aGUgc3lzdGVtIGNvbmZpZ3VyYXRpb24gZGV0YWlscyBhbmQgdGhlDQo+IG1lbW9yeSBwcm9maWxp
bmcgZGF0YSB0aGF0IGxlZCB0byB0aGUgcGF0Y2guIEhlcmUncyBldmVyeXRoaW5nIEkgY2FuIHBy
b3ZpZGU6DQo+IA0KPiA9PSBIYXJkd2FyZSAvIEZpcm13YXJlID09DQo+IA0KPiAgIE1hY2hpbmU6
ICAgIEFTVVMgWmVuYm9vayAxNCBVWDM0MDVDQQ0KPiAgIENQVTogICAgICAgIEludGVsIENvcmUg
VWx0cmEgOSAyODVIIChBcnJvdyBMYWtlKSwgMTYgY29yZXMNCj4gICBXaUZpOiAgICAgICBJbnRl
bChSKSBXaS1GaSA3IEJFMjAxIDMyME1Ieg0KPiAgIFBDSTogICAgICAgIDAwMDA6MDA6MTQuMyBb
ODA4Njo3NzQwXSAvIHN1YnN5c3RlbSBbODA4NjowMGU0XQ0KPiAgIEludGVyZmFjZTogIHdsbzEg
KHJlbmFtZWQgZnJvbSB3bGFuMCkNCj4gICBGaXJtd2FyZTogICAxMDEuNmU2OTVhNzAuMCBiei1i
MC1mbS1jMC1jMTAxLnVjb2RlLCBvcF9tb2RlIGl3bG1sZA0KPiAgIEtlcm5lbDogICAgIDYuMTku
NSAod2hlbiBjcmFzaGVzIHdlcmUgb2NjdXJyaW5nKQ0KPiAgIE9TOiAgICAgICAgIE5peE9TIChy
b2xsaW5nIHJlbGVhc2UpDQo+ICAgbW9kcHJvYmU6ICAgb3B0aW9ucyBpd2x3aWZpIHBvd2VyX3Nh
dmU9MA0KPiAgICAgICAgICAgICAgIG9wdGlvbnMgaXdsbXZtIHBvd2VyX3NjaGVtZT0xDQo+IA0K
PiA9PSBPYnNlcnZlZCBiZWhhdmlvciAoa2VybmVsIDYuMTkuNSkgPT0NCj4gDQo+IFVuZGVyIHN1
c3RhaW5lZCBUYWlsc2NhbGUgKFdpcmVHdWFyZCkgVURQIHRyYWZmaWMgKyBhY3RpdmUgU1NIIHNl
c3Npb25zIG92ZXINCj4gV2lGaSwgdGhlIGZpcm13YXJlIGNyYXNoZWQgd2l0aCBOTUlfSU5URVJS
VVBUX1VOS05PV04gYXBwcm94aW1hdGVseQ0KPiBldmVyeSAxMOKAkzE1IG1pbnV0ZXMuIEVhY2gg
Y3Jhc2ggdHJpZ2dlcmVkIGllZWU4MDIxMV9yZXN0YXJ0X2h3KCkuDQo+IA0KPiBUd28gc3ltcHRv
bXMgd2VyZSBvYnNlcnZlZCBhZnRlciBlYWNoIGZpcm13YXJlIHJlc3RhcnQ6DQo+IA0KPiAxKSBN
YXNzaXZlIHNrYiBtZW1vcnkgbGVhay4gTWVtb3J5IHByb2ZpbGluZyAoL3Byb2MvYWxsb2NpbmZv
KQ0KPiAgICBzaG93ZWQgdGhlIGZvbGxvd2luZyBhZnRlciBhIHNpbmdsZSBmaXJtd2FyZSBjcmFz
aCBjeWNsZToNCj4gDQo+ICAgICAgMTAuOCBHaUIgIDE2NTQ2MTU3ICBuZXQvY29yZS9za2J1ZmYu
Yzo1ODYgIGZ1bmM6a21hbGxvY19yZXNlcnZlDQo+ICAgICAgIDMuOTQgR2lCICAxNjU0NjE0NCAg
bmV0L2NvcmUvc2tidWZmLmM6Njc5ICBmdW5jOl9fYWxsb2Nfc2tiDQpXaHkgaXMgdGhlcmUgYSBs
ZWFrIGlmIHdlIGZyZWVpbmcgdGhlIFNLQnMgYWZ0ZXIgd2UgZmFpbGVkPw0KPiANCj4gICAgfjcg
R0Igb2Ygc2tiIGJ1ZmZlcnMgbGVha2VkIHBlciBjcmFzaC4gVGhlIFRYIHBhdGgga2VwdA0KPiAg
ICBkZXF1ZXVpbmcgZnJhbWVzIGZyb20gbWFjODAyMTEgYW5kIHB1c2hpbmcgdGhlbSB0byB0aGUg
ZGVhZA0KPiAgICBmaXJtd2FyZSAoaXdsX3RyYW5zX3R4KCkgcmV0dXJuaW5nIC1FSU8pLCBhbGxv
Y2F0aW5nIGFuZA0KPiAgICBpbW1lZGlhdGVseSBmcmVlaW5nIHNrYnMgaW4gYSB0aWdodCBsb29w
Lg0KPiANCj4gMikgU3lzdGVtIGZyZWV6ZSB3aGVuIFRTTyB3YXMgZW5hYmxlZC4gV2l0aCBUU08v
R1NPIGFjdGl2ZSBvbg0KPiAgICB3bG8xLCB0aGUgY3Jhc2ggcGF0aCB0aHJvdWdoIGl3bF9tbGRf
dHhfZnJvbV90eHEg4oaSDQo+ICAgIGl3bF9tbGRfdHhfc2tiIOKGkiBpd2xfdHhfdHNvX3NlZ21l
bnQg4oaSIHNrYl9zZWdtZW50IOKGkg0KPiAgICBza2JfcmVsZWFzZV9oZWFkX3N0YXRlIGNhdXNl
ZCBhbiBSQ1Ugc3RhbGwg4oaSIGNvbXBsZXRlIHN5c3RlbQ0KPiAgICBmcmVlemUuIERpc2FibGlu
ZyBUU08vR1NPIHZpYSBldGh0b29sIHByZXZlbnRlZCB0aGUgZGVhZGxvY2sNCj4gICAgYnV0IG5v
dCB0aGUgc2tiIGxlYWsuDQpUaGlzIHdhcyBmaXhlZCBieSBodHRwczovL3BhdGNod29yay5rZXJu
ZWwub3JnL3Byb2plY3QvbGludXgtd2lyZWxlc3MvcGF0Y2gvMjAyNjA0MDUwNTQxNDUuMTA2NDE1
Mi0zLWNvbGVAdW53cmFwLnJzLw0KPiANCj4gPT0gV29ya2Fyb3VuZHMgYXBwbGllZCA9PQ0KPiAN
Cj4gICAtIGV0aHRvb2wgLUsgd2xvMSB0c28gb2ZmIGdzbyBvZmYgIChwcmV2ZW50cyBzeXN0ZW0g
ZnJlZXplKQ0KPiAgIC0gc3lzdGVtZCB3YXRjaGRvZyBzZXJ2aWNlIG1vbml0b3Jpbmcgam91cm5h
bGN0bCBmb3INCj4gICAgICJpd2x3aWZpLipyZXN0YXJ0IGNvbXBsZXRlZCIsIHRoZW4gcm1tb2Qv
bW9kcHJvYmUgY3ljbGUNCj4gICAgIHRvIHJlY2xhaW0gbGVha2VkIHNrYiBtZW1vcnkNCj4gICAt
IG5ldC5jb3JlLndtZW1fbWF4IC8gcm1lbV9tYXggY2FwcGVkIGF0IDJNQiAobGltaXRzIHBlci1j
cmFzaA0KPiAgICAgbWVtb3J5IGNvbnN1bXB0aW9uKQ0KPiANCj4gPT0gQ3VycmVudCBzdGF0dXMg
KGtlcm5lbCA2LjE5LjExLCBsaW51eC1maXJtd2FyZSAyMDI2MDMwOSkgPT0NCj4gDQo+IE9uIHRo
ZSBjdXJyZW50IGZpcm13YXJlIChsaW51eC1maXJtd2FyZS0yMDI2MDMwOSwgc2FtZSB1Y29kZSB2
ZXJzaW9uIHN0cmluZw0KPiAxMDEuNmU2OTVhNzAuMCksIHRoZSBOTUlfSU5URVJSVVBUX1VOS05P
V04gY3Jhc2hlcyBoYXZlIHN0b3BwZWQNCj4gZW50aXJlbHkuIEkgcmFuIGhlYXZ5IFNTSCArIFRh
aWxzY2FsZSB0cmFmZmljIGZvcg0KPiAxMCsgbWludXRlcyB3aXRoIFRTTyByZS1lbmFibGVkIGFu
ZCBubyBmaXJtd2FyZSBjcmFzaCBvY2N1cnJlZC4NCj4gDQo+IEkgY2hlY2tlZCB0aGUga2VybmVs
IGNoYW5nZWxvZ3M6IHRoZXJlIGFyZSB6ZXJvIGl3bHdpZmkgY2hhbmdlcyBiZXR3ZWVuIDYuMTku
Ng0KPiBhbmQgNi4xOS4xMSwgc28gdGhlIHN0YWJpbGl0eSBpbXByb3ZlbWVudCBpcyBtb3N0IGxp
a2VseSBmcm9tIHRoZSBmaXJtd2FyZQ0KPiBwYWNrYWdlIHVwZGF0ZSAodGhlIGxpbnV4LWZpcm13
YXJlIHNuYXBzaG90IGNoYW5nZWQgYmV0d2VlbiBteSA2LjE5LjUNCj4gc3lzdGVtIGFuZCB0aGUg
Y3VycmVudCBvbmUpLg0KTm90IHN1cmUgSSB1bmRlcnN0YW5kIGlmIHlvdSBoYXZlIGEgbmV3IEZX
IG9yIG5vdD8NCj4gDQo+ID09IFdoeSB0aGUgcGF0Y2ggaXMgc3RpbGwgbmVlZGVkID09DQo+IA0K
PiBFdmVuIGlmIHRoZSBzcGVjaWZpYyBOTUlfSU5URVJSVVBUX1VOS05PV04gdHJpZ2dlciBoYXMg
YmVlbiBmaXhlZCBpbiBuZXdlcg0KPiBmaXJtd2FyZSwgdGhlIGNvZGUgcGF0aCBpcyBzdGlsbCB1
bmd1YXJkZWQ6DQo+IGl3bF9tbGRfdHhfZnJvbV90eHEoKSBkb2VzIG5vdCBjaGVjayBtbGQtPmZ3
X3N0YXR1cy5pbl9od19yZXN0YXJ0IGJlZm9yZQ0KPiBkZXF1ZXVpbmcuIEFueSBmdXR1cmUgZmly
bXdhcmUgY3Jhc2ggdW5kZXIgbG9hZCB3b3VsZCBoaXQgdGhlIHNhbWUgc2tiIGNodXJuIC8NCj4g
bWVtb3J5IGxlYWsuIFRoZSBSWCBwYXRoIGFuZCBUWFEgYWxsb2NhdGlvbiB3b3JrZXIgYWxyZWFk
eSBoYXZlIHRoaXMgZ3VhcmQg4oCUDQo+IHRoZSBUWCBkZXF1ZXVlIHBhdGggaXMgdGhlIG9ubHkg
b25lIG1pc3NpbmcgaXQuDQo+IA0KPiBMZXQgbWUga25vdyBpZiB0aGVyZSdzIGFueXRoaW5nIGVs
c2UgSSBjYW4gcHJvdmlkZSwgb3IgaWYgeW91J2QgbGlrZSBtZSB0byB0cnkNCj4gcmVwcm9kdWNp
bmcgb24gYW4gb2xkZXIgZmlybXdhcmUgdmVyc2lvbi4NCj4gDQo+IFRoYW5rcywNCj4gU2hlcm96
DQo=

