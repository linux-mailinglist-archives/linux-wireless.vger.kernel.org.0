Return-Path: <linux-wireless+bounces-34160-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMHtNdIfymmu5QUAu9opvQ
	(envelope-from <linux-wireless+bounces-34160-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 09:01:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B223A3562B6
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 09:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FAAE30512B7
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 06:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2636E38551A;
	Mon, 30 Mar 2026 06:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LqzH5kz0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC916382399
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 06:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774853709; cv=fail; b=HueuaRC8psm/qhtGAacXsWL9UalUW8THbjOqNwyufPIF1bd6XhqPQinbjBPgWzZIASXRyluLFi4Sdd6N1RXXWB8fFcViwDxelkWSBUPLh7xnd0X0i+nO6wgaWUddwQLzGHdDsLH0wvmD6bt8pG7T7GlXj9+ykEX7tvZiOSwfRfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774853709; c=relaxed/simple;
	bh=t64meLGKhEwYS+QK9XfGDa7cHGRWwZU+kaLmVbFLkLg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jnC1fhUEI4X41fFcLWLMb9r1v1VaTZtATHZXrnaMc4nkEzmsqLbxfKpWhfHLHt4+fCYzRVE1Jt0h5AgxE1CoJDmrBDHc5+w8XiDTpvJbwa8ALJNAWpKUe4FjXT+JU2rT+kv3E/jtkqC7WxRvF48e9QCJ0WG7xOD3MRLK5v5psKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LqzH5kz0; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774853707; x=1806389707;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=t64meLGKhEwYS+QK9XfGDa7cHGRWwZU+kaLmVbFLkLg=;
  b=LqzH5kz0ATiiIN1R6cSC5Rwky+dPFdRougxO73ft23VY9TsuvvTPi9we
   DXyYBswIsJIL5Xbv+1X0SOykyTEwvR/2Ntg1B/GzQ55ebusSd/wx60WNv
   iqvQbZrZFHeNXIR1J2hQxV4GCD2vbnDA3KMfNXKy5xyPthYKbu6IB8mec
   sqkrfR+jA5+g9tSnBaUUtZ/03Q+NTaZxnjXlfpgnCr1bcayoIQRFTySz8
   lE1ijGwydSbrXNQuJd1dZQsuBvRHzaAg9UxY4iCsfeCkqgr9CJUNrXpzq
   HLZUl849k8zTINeoZHwqDkBRJUsjuDyKiMVTFD3Lg0JiAt0slniphtbnb
   w==;
X-CSE-ConnectionGUID: LfjS0oUwQl+ErKXvQg1uLQ==
X-CSE-MsgGUID: vJ/L0T4bR9maCZpEkc0uQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="87227489"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="87227489"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 23:55:07 -0700
X-CSE-ConnectionGUID: rk/9lExtRcidmoNJ1r81CQ==
X-CSE-MsgGUID: OKhFjyYgSp6RqdBqAAptFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="230032471"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 23:55:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 23:55:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 23:55:06 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 23:55:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAFehOC5G5SIYqA4dupjhaU+T0YDyaMdfdsdpljDUToyYojzmMB0aZlvEqhI1uMgNvFSvitkUBQMzvMwkTdawKtfZ+LurXbFs23bqXtl5nsURoVY7/Wq3vcTGosesph1Jju5jeFrtob156MzKor1HVXdTRD0LYs7OvWif5HH73uYth5fstbeD52tcf7z3w0Or4CklQsU1NSLexXbDtA6jZO5E88VlYtfPR8NHnVKhhaNWhvDSbD9MBx9LP/HNBmOrav9/m4dswB6XjLVvaytZZuM2BpNKj475o8uaVM8hNyaxdnPZlMEeUksFIPBDaxTDR8gkv2N3ic3QT+u30OqKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t64meLGKhEwYS+QK9XfGDa7cHGRWwZU+kaLmVbFLkLg=;
 b=nEQ3kPKEQi3HSSa+CWnEU5Fb8RF6k97ZoCFURMZSmb7CoQp/DEAa4hmej9EPzmuy+2MJo0DMcLOyEppEHKNWWLsupAKqlitRIRqzsq9W5kSxSuOeDTWaUvJTDPfwJ0DbXYnol6iZ8OA4ZBlZa4MRv4M1+5XKhLqTBrBCviVGOJq6lm2RqguHubiWxqUw7zZByewQ0LncF5Uig0yRjE1Cf684zI0bxv9DyzjQfys2AKDxfDBVQTcE7mHn/ew1wvXpcW4apLabLApbDcPonxVBZDpw09MOOVUJUt049Sw0K2DCTClOLl7/KxzwKV9MAFjpqq7DGYwhWOPO68YFUaffRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by CO1PR11MB4963.namprd11.prod.outlook.com
 (2603:10b6:303:91::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 06:55:02 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d%3]) with mapi id 15.20.9700.013; Mon, 30 Mar 2026
 06:55:02 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	<linux-wireless@vger.kernel.org>
Subject: RE: iwlwifi-mld: Fix fw id leak in OOM case
Thread-Topic: iwlwifi-mld: Fix fw id leak in OOM case
Thread-Index: AQHcqplJOAYdPCdPFEOqlM516Y2cwLWcaYPwgABzToCAKfIfIA==
Date: Mon, 30 Mar 2026 06:55:01 +0000
Message-ID: <DM3PPF63A6024A91F45CEFDD04F62A8BC91A352A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <02f66cee-4892-24a3-9a07-1e722fe8888f@candelatech.com>
 <DM3PPF63A6024A927179DD5C6D8BEB45B11A37FA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <495b7e8d-454c-4c0f-8976-c31fcee0783d@candelatech.com>
In-Reply-To: <495b7e8d-454c-4c0f-8976-c31fcee0783d@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|CO1PR11MB4963:EE_
x-ms-office365-filtering-correlation-id: 14a2ff53-9475-4efd-6f0d-08de8e294410
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: fVEUTbxMPjO8PaxZOrLqfOypQGSXNeqxpv9xO3IB32X0GxFEX9ezPUPnl/w8Q4BALuLRNFlvdq6N1PnBrZQfY3IIRj3l+Rs+qyI1n/J2EVeKq3XdHHXX742r8oU90PeJpeCgBCjSeIgA6y0UWlhhL3/hTf2TT+fD/XfwVD8cYrR12D7yVb4EN1jlhZxeGg0ajDRYFBhPEkR0L0UTPcD5lgXGY/CpX48NLakokwzS4RvBKN+Puf2CVYknuIUmr3GBZaSrvuH74IldbcvS9vqQtj5jZm0AB7DmBJjs4qFOC8b7Loe+h+w774qgPqMam6iCj/N6sGm/l4Px06mlvfWMohr9ozn4cbRD7OL2KAjzndhwlDkxMJGd76OfEWdKEPjbEL2UXvmZHDQdSDR9MVrGAG+Ink3LGFdBDj75vP6HSABaY/57BzW0z26+zq1pL/o0w0CqZoZxMLciRaKDBlj8pdCCMkVDgICJxq+/c3EmUcnotSWEQq90ZZymWMIF1BNCT63ksARId4aZeRqOlQZ0P3hqPOYncvkUykvx1QtOp463uo9nMBSrPVCPYwNezPQilIMJBkQOsJvhqUxPHzHF+DFV42l0bT8GTnIO5NJptm9uykJ10F58j1ZqtPG2E0B04juh97x1nH5oSGU7+UJQ5rnXQMwLyTu5i8SMwYU4cIGbQjhR1ix1gi+VS/bphEk2F0LqO9AGJeljH2oZxvt/Jsb1DZSrkKYzKFBibchgs2A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1JPSWNCaXlmTFVaYnhPaitEZ0pPaE1RZ291eHc3M2FWNmN3UDJ3R2YrQkI2?=
 =?utf-8?B?cnRpUnoxMEcwUjhtY2c2RS9Da0VBTFdKNTBnenZTWGJOeVV5Tkc3V1BXOFNM?=
 =?utf-8?B?MHpRMndoeHM1SGw2M3dSS2E3cWZzMlNnTnFEVHg0a1NlR1ozc3VRNGZnajRO?=
 =?utf-8?B?MlN4Q0hJU1ExNGxRSHU2TUpBOG5aSWZyY0JENXFBYklNR0FQZ2ZZYkl3Umlq?=
 =?utf-8?B?Z0o3SEJsNlZVWVVpYS9pdTErQzRIUEM3Yk1NUDM0MUtZZGNmbVRwWEJGejVD?=
 =?utf-8?B?MW9vbVcwSDQ5NkpOdmQwWFRyVXdoM1dMenI2aVp5cjlTdHVjMkRUSFhDWnUz?=
 =?utf-8?B?Qk1mcmcvTG9DczdRL3ZRTnNTaWVnNzZHQ1k0NS82N05BeEQrdklKOXc0WHl5?=
 =?utf-8?B?MlRqSDlVTERuSW9jYmJ0OXhBR0NwbnRzMUhKbEY0QUVzRWs1eGNRWXBSRG5I?=
 =?utf-8?B?bnI2cmRtdUZHbTdFTCtNbDM2ZEwxSWZHOHpYdFFWTm4rRDMrakkwMUV6T0Jw?=
 =?utf-8?B?V21BbVFhY2YzenV1TDdwU1lSem55d2paNXJKK01HSzhGOG1IS25sYnJxQ1g4?=
 =?utf-8?B?L1hpTmVkZDFHLytKd0JxTjNqOSt1d3k3TTI3UmYreHVnbElrZks3cmUxK2s0?=
 =?utf-8?B?bnVDU2lZZU1TbEJtYzdjZEF3K0lNd1hjN3RySnMyVGJKdHZ2QkcxTy92OWNl?=
 =?utf-8?B?U21LYXY4RlVWVUpFUDZNMFdmOGFHaEVwSTd3VGV2R25XUWNGcnA1a3JnNTJx?=
 =?utf-8?B?NDYyRCtMWDc0ZWk2MlpJd0p5NzRzdE1RVHpWcDY4YjMzZGIvc2RFU3YwdXpG?=
 =?utf-8?B?bDg0YzEwdWVOcjFrMzMzUHVsL1F0K3hTK0JpLzR1U2dSUWpMMk5SZnAxdDZH?=
 =?utf-8?B?RkJnM0VYUXphenFLcTcwcFZIYXFoWEdSbENjcmNsUmk3YkFlYUV4Rk1qMUlj?=
 =?utf-8?B?ZHlDbllTbVlQTnpvdnd3U3JaOCsvS0NndlFEK05WWVFwa2REQ0JHRkliR2xE?=
 =?utf-8?B?bjJOZ0ZEUDJCSlRzRS9NWE5OY29SK0ZRczBaMXVGWFJsNmJDYnJucnBDck0r?=
 =?utf-8?B?REg2ckt1YVBxRWNhWVphMHdoTi9oNkpjZ2RHZjFBWjBnb2FSVU1ldmJCcUNV?=
 =?utf-8?B?VGVvZUZsVFkyT251YUdrMWxTSGxFVzVGWkxVZDByQVF1ZkZBMmtuVEhwSExX?=
 =?utf-8?B?WWwwaVJvVThCUGRTM1hScitZRk1ZMncwVHcwKzBHSEthc1NxODBCK3RWTGFC?=
 =?utf-8?B?bmVZc21mVURDeVZ0ZW9kdXQ3RUF2Rkh3bEFKSmZiYWNVUDA3dXMrMnQ0aXlI?=
 =?utf-8?B?UlhnR2JHZ2Z3RjZML08yNS9xTGl6cVJ5UkpwYUJxRnlWRWtGajl0RkZ0V202?=
 =?utf-8?B?YXlKcGJUN0JITHNPYjk1ZDBFQlNWa094TzNjTVFObnl4Z1oxNlcrTHhGRnRv?=
 =?utf-8?B?M2hBY3NsT2JlMTNta1JRNllPUG5hTDBaZ2s3NWVCQm1LL3g1YmlpRFdCajdi?=
 =?utf-8?B?d2p4ejc0ZGlhNkFvdTBzQ00xN3BrN3ZFME40S09sNld6QTVnbTFWeWNoOFRX?=
 =?utf-8?B?TC9FMm1TVENKcENPSHJxZDFVRXplOThDc3p4bGJTdjdRSHFxWDVMbFNGZGtD?=
 =?utf-8?B?cHM5MDY4NkVVR0puZ0d5T2FUR2lsdi91VlF0dmowZnB0T2tqUXoyb2NZSGdT?=
 =?utf-8?B?YllsVFowWXhDZ0Z4SHdUM2pkTm5HeUU2QnFRdTVGaHBOSzNJVnNoUDcweGlX?=
 =?utf-8?B?SlJhUzBiS3p1ZXZGczVQNGVNbVFXZmc5QlQ0Q3A4dDJHaFhFUCt6VXF5NzBa?=
 =?utf-8?B?TzdhU0E0Wlo1VG5iZTBWYkhPSEo5WVoxd3AvbERCR2drRGkva0RiUWdYN0lF?=
 =?utf-8?B?c1pIRXdDenpCLzZBeXU1TFlhMTJnSi9iNzhZeGZOUzd0b3A1Ym9HeTBoMkFv?=
 =?utf-8?B?MEdFeHZWZStLazM4SVBjR04rR3NuWU1ra01ZNnFRRnhGQThNSDFlb2xwTWF2?=
 =?utf-8?B?ME9oZ1VraStDZ3UxandSRk9QM0FNZVJMd2daKzcvV1JyUER5TzcxNWJUaVNs?=
 =?utf-8?B?UXMrRTFVVXozbUU1dGFrdnZjM3VYZkdWRlpEYWRBeEYvNFYwWC84b1g0VVFh?=
 =?utf-8?B?UXBUSXpFRnNYNFJXZm1xLzVzbEtaZjZFRjMzL09JVnAwR0NLaFRZaW5UNDJr?=
 =?utf-8?B?RWtuWkk5QmlNUHhncFRQV3VWMTI5UzJPVnpKVWpZVHZFZ3o3czV4Y0Nia3Nl?=
 =?utf-8?B?NG9LLzN6em1NV2o5M3Vza0JnY242Tk1OTytIVlFsTGJOT3VqM0x3ZW0rd3lC?=
 =?utf-8?B?OXFTb1JtUkVqWWlWdWFVRHUvY1JJaFdzOUlRWUxrMmdxRUczLzZKcEZuOGJQ?=
 =?utf-8?Q?rXsvHEZ4Xntia4uw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wiGKTlKcJw3JNSjNHJkd3tpMIy2fBLTnQin4lXOeOcJzKAMxqfoH7Q5bXmfOtDtFKcErq0fF8lvKF2xGFUOjx11XR1bLrO+63r+CQasbxlb5WUrGNgYx/ahq6jv68c2UrMjNfOz+fCg17wOv4mLIrefG63rkNJ/En4fFEJL2swep5bjalmD/x2yP7GZKA3F3+tdYgQYRCDhdZZyhdCx8o/tDES+/2ya6EqrSg3RSpXv+uvKz7IEvsUwz2cD2MoAsXUr7yVL5R1t6ZhwUYzndp4mpHmS38Im0MtF+TkcaEuvZab5PMjvLewOg3h3wHLqmCghZXqDHLP0cmOxz4+Ja3g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a2ff53-9475-4efd-6f0d-08de8e294410
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 06:55:01.9777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6dM1EDJuMW9MqfLTqY8AheN0PVNLaU4VIajga1qso7UtGz4wE2TL6Fi9ay3zi4KzNRwB6Z89s+lgvODTksYpGLRC+Mgpdrej8Zm1gWDQCvA3ytFhI6EfAkx+UGmKGbgr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4963
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-34160-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,DM3PPF63A6024A9.namprd11.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B223A3562B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmVuIEdyZWVhciA8Z3Jl
ZWFyYkBjYW5kZWxhdGVjaC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDMsIDIwMjYgNDoy
MSBQTQ0KPiBUbzogS29yZW5ibGl0LCBNaXJpYW0gUmFjaGVsIDxtaXJpYW0ucmFjaGVsLmtvcmVu
YmxpdEBpbnRlbC5jb20+OyBsaW51eC13aXJlbGVzcw0KPiA8bGludXgtd2lyZWxlc3NAdmdlci5r
ZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogaXdsd2lmaS1tbGQ6IEZpeCBmdyBpZCBsZWFrIGlu
IE9PTSBjYXNlDQo+IA0KPiBPbiAzLzIvMjYgMjM6MjgsIEtvcmVuYmxpdCwgTWlyaWFtIFJhY2hl
bCB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+
IEZyb206IEJlbiBHcmVlYXIgPGdyZWVhcmJAY2FuZGVsYXRlY2guY29tPg0KPiA+PiBTZW50OiBU
dWVzZGF5LCBNYXJjaCAzLCAyMDI2IDE6MDcgQU0NCj4gPj4gVG86IGxpbnV4LXdpcmVsZXNzIDxs
aW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc+OyBLb3JlbmJsaXQsDQo+ID4+IE1pcmlhbSBS
YWNoZWwgPG1pcmlhbS5yYWNoZWwua29yZW5ibGl0QGludGVsLmNvbT4NCj4gPj4gU3ViamVjdDog
aXdsd2lmaS1tbGQ6IEZpeCBmdyBpZCBsZWFrIGluIE9PTSBjYXNlDQo+ID4+DQo+ID4+IEhlbGxv
IE1pcmlhbSwNCj4gPj4NCj4gPj4gSSBiZWxpZXZlIHlvdSB3aWxsIHdhbnQgdG8gYWRkIHNvbWV0
aGluZyBsaWtlIHRoaXMgdG8geW91ciBkcml2ZXIgdG8NCj4gPj4gY2xlYXIgdGhlIGZ3X2lkX3Rv
X2xpbmtfc3RhIElEIGluIGNhc2UgeW91IGhpdCB0aGUgRU5PTUVNIGNhc2UuDQo+ID4+DQo+ID4+
IEkgaGF2ZSBubyByZWFzb24gdG8gYmVsaWV2ZSBJIGFtIGFjdHVhbGx5IGhpdHRpbmcgdGhpcyBl
cnJvciBjYXNlLA0KPiA+PiBidXQgSSBzYXcgdGhpcyBxdWVzdGlvbmFibGUgY29kZSB3aGlsZSBs
b29raW5nIGZvciByZWFzb25zIGZvciB0aGUgdXNlLWFmdGVyLQ0KPiBmcmVlIEkgYW0gaGl0dGlu
Zy4NCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvbWxkL3N0YS5jDQo+ID4+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lm
aS9tbGQvc3RhLmMNCj4gPj4gaW5kZXggNWZiMmE0NjI0MWU0Li5kZTk5MzlhZDFkNTggMTAwNjQ0
DQo+ID4+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL3N0YS5j
DQo+ID4+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL3N0YS5j
DQo+ID4+IEBAIC01MzUsMTMgKzUzNSwxOSBAQCBpd2xfbWxkX2FkZF9saW5rX3N0YShzdHJ1Y3Qg
aXdsX21sZCAqbWxkLA0KPiA+PiBzdHJ1Y3QgaWVlZTgwMjExX2xpbmtfc3RhICpsaW5rX3N0YSkN
Cj4gPj4gICAgICAgICAgIHJldCA9IGl3bF9tbGRfYWxsb2NhdGVfbGlua19zdGFfZndfaWQobWxk
LCAmZndfaWQsIGxpbmtfc3RhKTsNCj4gPj4gICAgICAgICAgIGlmIChyZXQpDQo+ID4+ICAgICAg
ICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4+DQo+ID4+ICAgICAgICAgICBpZiAobGlua19z
dGEgPT0gJmxpbmtfc3RhLT5zdGEtPmRlZmxpbmspIHsNCj4gPj4gICAgICAgICAgICAgICAgICAg
bWxkX2xpbmtfc3RhID0gJm1sZF9zdGEtPmRlZmxpbms7DQo+ID4+ICAgICAgICAgICB9IGVsc2Ug
ew0KPiA+PiAgICAgICAgICAgICAgICAgICBtbGRfbGlua19zdGEgPSBremFsbG9jKHNpemVvZigq
bWxkX2xpbmtfc3RhKSwgR0ZQX0tFUk5FTCk7DQo+ID4+IC0gICAgICAgICAgICAgICBpZiAoIW1s
ZF9saW5rX3N0YSkNCj4gPj4gKyAgICAgICAgICAgICAgIGlmICghbWxkX2xpbmtfc3RhKSB7DQo+
ID4+ICsgICAgICAgICAgICAgICAgICAgICAgIElXTF9FUlIobWxkLCAibWxkLWFkZC1saW5rLXN0
YSwgT09NLCBjbGVhcmluZw0KPiA+PiBmd19pZF90b19saW5rX3N0YVslZF1cbiIsDQo+ID4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZndfaWQpOw0KPiA+PiArDQo+ID4+ICsgUkNV
X0lOSVRfUE9JTlRFUihtbGQtPmZ3X2lkX3RvX2xpbmtfc3RhW2Z3X2lkXSwNCj4gPj4gKyBOVUxM
KTsNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gPj4g
KyAgICAgICAgICAgICAgIH0NCj4gPj4gICAgICAgICAgIH0NCj4gPj4NCj4gPj4gVGhhbmtzLA0K
PiA+PiBCZW4NCj4gPj4NCj4gPj4gLS0NCj4gPj4gQmVuIEdyZWVhciA8Z3JlZWFyYkBjYW5kZWxh
dGVjaC5jb20+DQo+ID4+IENhbmRlbGEgVGVjaG5vbG9naWVzIEluYyAgaHR0cDovL3d3dy5jYW5k
ZWxhdGVjaC5jb20NCj4gPg0KPiA+IFBsZWFzZSBzZW5kIGEgcGF0Y2gNCj4gDQo+IEFyZSB5b3Ug
ZmluZSB3aXRoIGhhdmluZyBJV0xfRVJSIGluIHRoZSBwYXRjaCBsaWtlIEkgaGF2ZSBhYm92ZT8N
Ck5vIG5lZWQgZm9yIGFueSBtZXNzYWdlLg0KQW5kIHlvdSBzaG91bGQgaGF2ZSBhIHByb3BlciBj
b21taXQgbWVzc2FnZQ0KPiANCj4gVGhhbmtzLA0KPiBCZW4NCj4gDQo+ID4NCj4gDQo+IC0tDQo+
IEJlbiBHcmVlYXIgPGdyZWVhcmJAY2FuZGVsYXRlY2guY29tPg0KPiBDYW5kZWxhIFRlY2hub2xv
Z2llcyBJbmMgIGh0dHA6Ly93d3cuY2FuZGVsYXRlY2guY29tDQoNCg==

