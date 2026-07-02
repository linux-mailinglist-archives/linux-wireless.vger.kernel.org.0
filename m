Return-Path: <linux-wireless+bounces-38523-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3aiHN5BaRmr+RQsAu9opvQ
	(envelope-from <linux-wireless+bounces-38523-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 14:33:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDAD6F7A7F
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 14:33:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=YYoSf0ej;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38523-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38523-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7715D3088574
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 12:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5147C47ECC0;
	Thu,  2 Jul 2026 12:29:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFB323EA94
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jul 2026 12:29:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995360; cv=fail; b=t0W+W7tdBDaRo/aLVdmw3kC3u25+HNR8nKOkQhrL1nwrGgb3QCVs+0bpgoc5+JLHVXai5W1IaI5fxj40oi8QiE3lez261LHNvuP6dzqoTJM+qoAoT7ZqxoMlugRsXRFYfF7OCHtLrpx2cYqWlg13qFj/4O/F1E1r5ofjq/gor3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995360; c=relaxed/simple;
	bh=4UvVbVeitoBPgyPA91qCKNN2SbOWYWyedpccwfDkbJI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=E1b3eW/eLWQRvhSRVuZUbOLj5pffOld36wqodbua4QGUrK+NPUGY8syBD133x75UNLYwHrnZp2PUeN34D9GGHgUvwylweXnCZCztkoaYYtNZEDvDR6FiY+/oAOoMgI/dwYXn9n0tnU+NQep5azqanwYw7/ew5GX3uvV5BezxwZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YYoSf0ej; arc=fail smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782995358; x=1814531358;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=4UvVbVeitoBPgyPA91qCKNN2SbOWYWyedpccwfDkbJI=;
  b=YYoSf0ejwj2H45t7nOqoKYq7aIZCdr8wuu1J4bKkWy9yDP3eFalT1PBO
   o4tNibaiQshL9kjWuGk7VpjbE2X2WAULqnBArbwmAcNznWwx/4pegPZc/
   kc8xFHzGMA4huSXrw1fpz97Yu7rHMAGchArlfuknAA8eiR1CHKLddXXl6
   KxU/32lxnlzcbrVvH1vIANp84uZTlQUrr4Tg8yXgwnf9S9dkJ3qFA5kd+
   uPkdNAMnMWeRfA5vjrbdE094r8Ep6vH96d4iuFN8bH82DWuuagwVPyBVi
   MM5/wQJLzlNkAsz6k6HYgEQdTVn0EHWJwZ0uZyR7JJj9M2kdXoMRW0SPl
   g==;
X-CSE-ConnectionGUID: fBASHXNKTkqziqsupnZpzQ==
X-CSE-MsgGUID: Yd64vHyISw6Qc5hs9eQq3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83878883"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="83878883"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 05:29:17 -0700
X-CSE-ConnectionGUID: ZBGxkuIDSiSCxmmu/gDzpg==
X-CSE-MsgGUID: 96Xy/Kq3Qjmt7paRjR0B5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="252399879"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 05:29:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 05:29:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 2 Jul 2026 05:29:16 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.28)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 05:29:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vs0pmhtKQUghA8Rth4AtplpAkc45tRnh/n28QsKhPWEGtlhBEVGg+YCu8l3Gs3HtYiXyW1u4Zzd8wfB2gzSwrV8yDOUFIuqr+WLDR+TtFd1Y9GpZYQzcP+O8FDmaYAdW4OVV8D17PmDMjetyTJsForCsJdfynyZYAzo8OM6FKrRV1Mz0WLBckSMAdIyiNhXJTnURKw973v+qdvmsb3EfO1lHLl098rOvpr+uqRyXb568mIaMf9hFVk61g7YaxcpTFpmN+nDLXpaTYvjggGVee4uzoUQ6aHx+AiFLe/h4kPdFbsgQW4eA8uQoFka0kn0R5rSg/5LUP6+ZKY/o1ltbog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UvVbVeitoBPgyPA91qCKNN2SbOWYWyedpccwfDkbJI=;
 b=yjiqV2Kda/HKmBdmIigaNxWrFOwVVou6hLozsYCre04qbR93bfWyvxyAcDWwhW+sxS7ZijiCQaeaPKJzDeTrkd95sPj0nTvfFOm3i6+ER0XvvE1uPHESJXeA2UQyotuVLdVwHbhKOoJxXnN5WKsQxEnv79Viwy9AWBj28B3RQ2SrKBBKugfKoMRNcovaIkR+Pej0JJwzzS5x33eFODa6PRqmyhzVmRfE7t80P4R9nnYZQJaG/nQo+zsLmYvWak7wf0INU9w6iL5i/tMl2HTE9Kc6JU7SUHmm4oPMkl7pSTFWFaODY4JOcO6vXPmykgZqm8RritTKa1Xcrvf6odcIGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) by
 LVUPR11MB9811.namprd11.prod.outlook.com (2603:10b6:408:39c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 12:29:13 +0000
Received: from DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2]) by DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2%2]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 12:29:13 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC: "Dreyfuss, Haim" <haim.dreyfuss@intel.com>, "Yang, You-Sheng"
	<vicamo.yang@canonical.com>, "kyle@infradead.org" <kyle@infradead.org>,
	"Hutchings, Ben" <ben@decadent.org.uk>, Josh Boyer <jwboyer@kernel.org>,
	linux-wireless <linux-wireless@vger.kernel.org>, "Grumbach, Emmanuel"
	<emmanuel.grumbach@intel.com>
Subject: pull request: iwlwifi firmware update 2026-07-02
Thread-Topic: pull request: iwlwifi firmware update 2026-07-02
Thread-Index: Ad0KHjOr8VXj1SVtSsmawX+kJRs4Ng==
Date: Thu, 2 Jul 2026 12:29:13 +0000
Message-ID: <DS0PR11MB788099813ABEFABD32A85E36A3F52@DS0PR11MB7880.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7880:EE_|LVUPR11MB9811:EE_
x-ms-office365-filtering-correlation-id: ba078853-3037-4c59-2619-08ded83586a9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|18002099003|38070700021;
x-microsoft-antispam-message-info: 7SCJdcgUEafkWFxV51jih0zGZLPzOGUNmdmrv0qLVYDT9yzE+sXc/fQMd9BI5zD0qoIhGUgTPyWz963iU+MKlpzkIthOAvs+TpDIDszqnxUDs7Z6R7euW4uNHQhbu9seec6gKvSdo7zAP+FuuSD0IxKK7nEP8NFJEwrVKV0Ob+MT00I7F7bvs24JfFfoI3K6pOsLgvXe7AUjFmhJRe4rq1CxJoDiZSf1Zh7ucLBrE2gd/ZO/fo20zhSvCyBvog7NevlUmoRiVpH8eJNubX/85O5YCpiaTiob5F2y1ZzSZAa57+afqTGAha51LqW4wzGlfWkSecy1ISvWBOTHvgSjmknJneC1iVyiGN3I9qLqa0dI/7dSI+H8rj7AajxKmbwSrfNSHGqqPO2mQht9gpy8yJfuACaTeiu18uIEZhYbyedZpSmi8XnnRclVkCZ97tqUTV1v/KZciARG4sHmhff9TCaA2KqYTZEwjh1x65wv3bvaWF+71+ie/H1JtQY5lrwaSmWbWsZriufPX39pLo0K2MoA2WusA788hP3kA3mjETpbCWuU9Km+w26+2zzQly1dS3DHZ6xf+53neIMyzQm5Hz8b5BABO+TPtQGKYiPpDFHzgv2eIPOLQQjRDyCRyFH6u2IVuE+i6SMiBziXWnTDQlzAzd7siGg2Ci/AKVoOS3YdHO7TkojkExQwpy3NrXxKMl01redn+UyY2EZUh7wffc2duLTmQYtI9US3BmcO5dc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1VtWnFPVUZTWDhRWXZtWGNLRXhxNlZmVDdzQXFmZEt0bHdRSUIzS0tOOWpJ?=
 =?utf-8?B?cmthMi9pNnUza1BDcVNnVkNBTG8wS3pTWkhyWWpGZ2VmMS9wclMvckVQcXpv?=
 =?utf-8?B?TmJQakFOeFgyckRZWHNEUkpHanUvK3ZqOWdaNVFtSlJIdGVicnVxQmtxTUh6?=
 =?utf-8?B?bHpmZWRVNVlTRUVLYTJQenh1RmtTblpPQVhOaXVhUU55TDZjVXVrMEpGbmxn?=
 =?utf-8?B?dzFlZFNrUU0rSHhGeURMQ0U1R1oyTVNYSzZRQ2pDNnozOFVFdU0yN2RTNHVx?=
 =?utf-8?B?UVBIczlDWktkWnNHNU9GNU1hZHA1bFBYTlQxTTc5Mm1RTzB3WjVuUFFRRjNS?=
 =?utf-8?B?R28xOUhZQ3BWcEd4VHdQUHJnU1o2bWZYM2htN1VCNlVWcmRWY3dYaDJqNkR0?=
 =?utf-8?B?cnlNaXZwMHI4VFozNlZDRDNsaXBrWFhPbnpuU0pCSTBPSmZaUjZpRCtkYlc5?=
 =?utf-8?B?WDAwNFNVbnFaM0daeTdIUWx2WWE3cmZJV2VJRGVINVdjb0tVbzZhWUJ0OUlt?=
 =?utf-8?B?VVRqem9EM1AxNjIzN0RuSFFiVUp5Rkdid0ZtTFM4VFBFTHluMm5nZzRIazJU?=
 =?utf-8?B?dnY2Ly9GTXo3TisrZU5UdTBIY0cvRm90VXNNbVhxZTZRNDVIcFB1OFdLMlNr?=
 =?utf-8?B?ZXRZMm9ibmdUZzR1Ykh5Z1NEQkt5RnZjN2ZaVTFXVUE3NEdPK1NSVnNGUTFX?=
 =?utf-8?B?cHlnT0lwS0hNc2Y0eVZyci8rSlg1Y0tZZTNmN0pHRTE3L2Npc3haV3lXVlZR?=
 =?utf-8?B?VXNCUFJMRURSTy9GZDFId3k5RjJTZEhtNmN1TDdCQnU5R2hHVXAzTDVRRzB1?=
 =?utf-8?B?VnNZc053NVB2ZlJla0ZMR25HaHFteGwyK1ZqbVV2MzBkTWpycnZhTWxIc3Zt?=
 =?utf-8?B?STBGSnMydyt3VlIwaWtURHM1QWhJVW9mMCt2T2dZU2d4K25uYS9WL0xQenBP?=
 =?utf-8?B?K29vbUVtUCtLV3pla1F4cUUwbFhWeTZEY3hJM253MXpmdkZhTm1qUENTbnV5?=
 =?utf-8?B?cE9xOVVtYXU0SjJvYW1VaG5lTEIxaTJuZVJzSGhpa0U5YU9yeXhIRVUzcmFy?=
 =?utf-8?B?bjBBZ2k5L0x0WXdXbnV0bER1dkFGd0F6d1FvOHlxM0ZaY0ROdEt0b0FIMXBo?=
 =?utf-8?B?aFJ0eVdqWXZGODExLzNNRFJGRnEvclFHeTIzMTNiNTkvMzJNeWY0cWVia1Rk?=
 =?utf-8?B?ejFBclU0d2p3NUozanR5Nkt0ZUU4K3JFbDc0MWQzajdBRzBtTW5TQmM5RHZz?=
 =?utf-8?B?RTZiWHBoLzh2WFFtcUIxNVJZSjE3TTlTUlM1aVp6OTVRenpSNUtsbkJHRmRq?=
 =?utf-8?B?RHJKL1NKTllrbEllQnVIWHhBUnFMZ0tneWRXK3MraHZYSnpwc3F6ck8weTRE?=
 =?utf-8?B?U0xXR0d0NHF4WjRTVENZMzA5NWhNbTZVbHhMdzNkNHB5OTFudmJ5L1ovT0FX?=
 =?utf-8?B?OFphd3pxR3BpVlM5MFNTM1dpZUJCQURveXg3MUtLSkJrc0p5eXJXUXY4VXZB?=
 =?utf-8?B?M3ZBRnlFbkxoUWFnekVxVmk3SVYxaTdWeFIvMVVPNW5hcXRydkJVQjhlMUs2?=
 =?utf-8?B?N2RqekdlZDhSTlBBN0QyYmd1VWp4WGZSM0NMR2hhNmJlWGl4NTNOZjJTR2w2?=
 =?utf-8?B?NytweUN5T3ZZeTFzS2dycWVqdzBUR3V1ektiMmlieWd4OGkvZlJZY3lNQXBY?=
 =?utf-8?B?cEVXZU5vZEJ6R3hoTWY2TUN3ZDZic2lTZ1dMZm9FV0NvTzF2TEtQTXlvQlpt?=
 =?utf-8?B?eHEyRG5hZ2Vxb3RoejZnUEJTam9uQlpoZUJIYlNRVzFuV3FHOFBaY2NiZUs4?=
 =?utf-8?B?R1hEMGRVZmRjWStYd2w0Y3U5YSs5Y2lWMzdXMlZXd3p5Q21JcWpRcktFWVQ3?=
 =?utf-8?B?V29sUEdqRzNMZGhhQjhZLzg1UzZkM1VFbWdQVVNyUDl3NlZITU10VVUybDRH?=
 =?utf-8?B?aXBhUkFQeUJIUTJVRjd3ZDdsR2RaeTMwOHQvN01KQUJLK2RwZVpuZy9yQW9D?=
 =?utf-8?B?azNCVHJtU2pldlc5Q2xoRDF0YlJHNWNEdUlGaEd5VHgyVVV2b2VIdVlKVEkz?=
 =?utf-8?B?ak01RzI5VjkwMGh1dkMwS1lBdVE2MDcrNWliL1hYak85dFk1d0JCYVppOFhq?=
 =?utf-8?B?UFJnZGh6NGswcEE0am8rMlVHR3RQeHpQQXZ1M21zaDVsbHExS3dvRnRJdXVr?=
 =?utf-8?B?ZWZBRVpZZWU0SDlKVVMzYWgvbUh4WkhaeVBqeTh2b0d5bFBVZGVYT1ZEdlR3?=
 =?utf-8?B?ZDhXM0NFTkwrSitHOHhaT0xPUWxTVFBHZzZsdlUyeDFIVEMrbkdsR1VTcVFF?=
 =?utf-8?B?VUJDMzVOQlZUVGhqRzd2ZmZ2YjRqUFJNN2JBMmlMcXF3ajN4c09IRFZsOVJ5?=
 =?utf-8?Q?sKVQBiC50t0ocO4M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RZK5lTU4+dgWq4XKJuZLWQCuMogWll1xAoSsjEAnHB/mINTxIKsqP0n3Ggru7c30P3ZiTsxGi8qze/rkyAPg5Km6P2EjRFbKpShZ2JapxabING53upg+ON/F1g5vx2+Nr7Nv/GPNvbd55OdcF0AgF1AhEzC0fKTOwuqv0UEkGBvzpkJFuaXQvkL189XvkQi8ZyVc5ibaOoKSgFBQZgUttbGt/juGXzqE0MwO6YOFGT6voZ3sKIrRwT75T/91o0ybb8RAE2odcrYg/gDSFzlVYw5fek2xGTy9ToDRxGwL3GQnwJXero3SA+AF4d5//GOz9CrWZw1czBNuRg/Gd/AKZg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba078853-3037-4c59-2619-08ded83586a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 12:29:13.7023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1eO4PzxI1ewMHIWcHSkF/TUqDKZhqLSzw828XNMaEogz6Wk3E96/7f7SoFaUWeBH/4jXmjdeO1UFjkn2r5NxNNiJxzz0QRtgJf44P9bWhvrTMfBbDv9nIacPsdbTDlMH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9811
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.06 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-firmware@kernel.org,m:haim.dreyfuss@intel.com,m:vicamo.yang@canonical.com,m:kyle@infradead.org,m:ben@decadent.org.uk,m:jwboyer@kernel.org,m:linux-wireless@vger.kernel.org,m:emmanuel.grumbach@intel.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38523-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDDAD6F7A7F

SGksDQoNClRoaXMgY29udGFpbnMgdGhlIGZpcm13YXJlIG9mIGNvcmUyNC42MCAoMTA2KSBmb3Ig
YWxsIHN1cHBvcnRlZCBkZXZpY2VzLg0KDQpQbGVhc2UgcHVsbCBvciBsZXQgbWUga25vdyBpZiB0
aGVyZSBhcmUgYW55IGlzc3Vlcy4NCg0KVGhhbmtzLA0KTWlyaQ0KLS0tDQoNClRoZSBmb2xsb3dp
bmcgY2hhbmdlcyBzaW5jZSBjb21taXQgMWRlN2RmMjQ4NDA1NzhlZmRlOGVhNmIzNGQyZDY4MDll
YTFiODU3NToNCg0KICBNZXJnZSBicmFuY2ggJ3JvYm90L3ByLTAtMTc4MjkwMDg4OCcgaW50byAn
bWFpbicgKDIwMjYtMDctMDEgMTA6MTg6MTYgKzAwMDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhl
IEdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGh0dHA6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvaXdsd2lmaS9saW51eC1maXJtd2FyZS5naXQgdGFncy9pd2x3aWZpLWZ3
LTIwMjYtMDctMDINCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDJhYjRjZTIxNjAw
M2VlMmMyMzk2YzY5ZTE5NDU1ZTQzNzliMGUxZjA6DQoNCiAgaXdsd2lmaTogYWRkIEJ6L1NjIEZX
IGZvciBjb3JlMjQuNjAtMzMgcmVsZWFzZSAoMjAyNi0wNy0wMiAxNToyMDoxNiArMDMwMCkNCg0K
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KUmVsZWFzZSBDb3JlX21hbnVhbF9zaWduZWRfY29yZTI0LjYwLzMzDQoNCjIwMjYt
MDctMDINCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KTWlyaSBLb3JlbmJsaXQgKDQpOg0KICAgICAgaXdsd2lmaTogdXBk
YXRlIGNjL1F1L1F1WiBmaXJtd2FyZXMgZm9yIGNvcmUyNC42MC0zMyByZWxlYXNlDQogICAgICBp
d2x3aWZpOiB1cGRhdGUgdHkvU28vTWEgZmlybXdhcmVzIGZvciBjb3JlMjQuNjAtMzMgcmVsZWFz
ZQ0KICAgICAgaXdsd2lmaTogQWRkIEhyL0dmIGZpcm13YXJlIGZvciBjb3JlMjQuNjAtMzMgcmVs
ZWFzZQ0KICAgICAgaXdsd2lmaTogYWRkIEJ6L1NjIEZXIGZvciBjb3JlMjQuNjAtMzMgcmVsZWFz
ZQ0KDQogV0hFTkNFICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNjIg
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQogaW50ZWwvaXdsd2lmaS9pd2x3aWZpLVF1LWIw
LWhyLWIwLTc3LnVjb2RlICAgfCBCaW4gMTQwNjU3MiAtPiAxNDA2NTc2IGJ5dGVzDQogaW50ZWwv
aXdsd2lmaS9pd2x3aWZpLVF1LWIwLWpmLWIwLTc3LnVjb2RlICAgfCBCaW4gMTMyMzI5MiAtPiAx
MzIzMjk2IGJ5dGVzDQogaW50ZWwvaXdsd2lmaS9pd2x3aWZpLVF1LWMwLWhyLWIwLTc3LnVjb2Rl
ICAgfCBCaW4gMTQwNjU4OCAtPiAxNDA2NTkyIGJ5dGVzDQogaW50ZWwvaXdsd2lmaS9pd2x3aWZp
LVF1LWMwLWpmLWIwLTc3LnVjb2RlICAgfCBCaW4gMTMyMzMwOCAtPiAxMzIzMzEyIGJ5dGVzDQog
aW50ZWwvaXdsd2lmaS9pd2x3aWZpLVF1Wi1hMC1oci1iMC03Ny51Y29kZSAgfCBCaW4gMTQwNjcx
NiAtPiAxNDA2NzIwIGJ5dGVzDQogaW50ZWwvaXdsd2lmaS9pd2x3aWZpLVF1Wi1hMC1qZi1iMC03
Ny51Y29kZSAgfCBCaW4gMTMyMzM3NiAtPiAxMzIzMzIwIGJ5dGVzDQogaW50ZWwvaXdsd2lmaS9p
d2x3aWZpLWJ6LWIwLWZtLWMwLWMxMDYudWNvZGUgfCBCaW4gMCAtPiAyMTUwOTY4IGJ5dGVzDQog
aW50ZWwvaXdsd2lmaS9pd2x3aWZpLWJ6LWIwLWdmLWEwLTEwMC51Y29kZSAgfCBCaW4gMTgzNjcx
MiAtPiAxODM3NTM2IGJ5dGVzDQogaW50ZWwvaXdsd2lmaS9pd2x3aWZpLWJ6LWIwLWhyLWIwLTEw
MC51Y29kZSAgfCBCaW4gMTU4NDYyMCAtPiAxNTg0NzQ4IGJ5dGVzDQogaW50ZWwvaXdsd2lmaS9p
d2x3aWZpLWJ6LWIwLXdoLWIwLWMxMDYudWNvZGUgfCBCaW4gMCAtPiAyMDIyNTIwIGJ5dGVzDQog
aW50ZWwvaXdsd2lmaS9pd2x3aWZpLWNjLWEwLTc3LnVjb2RlICAgICAgICAgfCBCaW4gMTM2ODA5
NiAtPiAxMzY4MTAwIGJ5dGVzDQogaW50ZWwvaXdsd2lmaS9pd2x3aWZpLWdsLWMwLWZtLWMwLWMx
MDYudWNvZGUgfCBCaW4gMCAtPiAyMTM0NjYwIGJ5dGVzDQogaW50ZWwvaXdsd2lmaS9pd2x3aWZp
LW1hLWIwLWdmLWEwLTg5LnVjb2RlICAgfCBCaW4gMTc1MjcxMiAtPiAxNzUyNzU2IGJ5dGVzDQog
aW50ZWwvaXdsd2lmaS9pd2x3aWZpLW1hLWIwLWdmLWEwLnBudm0gICAgICAgfCBCaW4gNTUwOTYg
LT4gNTUwOTYgYnl0ZXMNCiBpbnRlbC9pd2x3aWZpL2l3bHdpZmktbWEtYjAtZ2Y0LWEwLTg5LnVj
b2RlICB8IEJpbiAxNjA0NzUyIC0+IDE2MDQ3OTYgYnl0ZXMNCiBpbnRlbC9pd2x3aWZpL2l3bHdp
ZmktbWEtYjAtZ2Y0LWEwLnBudm0gICAgICB8IEJpbiAyNzgyMCAtPiAyNzgyMCBieXRlcw0KIGlu
dGVsL2l3bHdpZmkvaXdsd2lmaS1tYS1iMC1oci1iMC04OS51Y29kZSAgIHwgQmluIDE1Mzk3ODgg
LT4gMTUzOTgzMiBieXRlcw0KIGludGVsL2l3bHdpZmkvaXdsd2lmaS1zYy1hMC1mbS1jMC1jMTA2
LnVjb2RlIHwgQmluIDAgLT4gMjIyNjg0NCBieXRlcw0KIGludGVsL2l3bHdpZmkvaXdsd2lmaS1z
Yy1hMC1nZi1hMC0xMDAudWNvZGUgIHwgQmluIDE4MTA1NDggLT4gMTgxMTIxMiBieXRlcw0KIGlu
dGVsL2l3bHdpZmkvaXdsd2lmaS1zYy1hMC13aC1iMC1jMTA2LnVjb2RlIHwgQmluIDAgLT4gMjEy
ODc4OCBieXRlcw0KIGludGVsL2l3bHdpZmkvaXdsd2lmaS1zby1hMC1nZi1hMC04OS51Y29kZSAg
IHwgQmluIDE3MzY3NDggLT4gMTczNjc5MiBieXRlcw0KIGludGVsL2l3bHdpZmkvaXdsd2lmaS1z
by1hMC1nZi1hMC5wbnZtICAgICAgIHwgQmluIDU1MTc2IC0+IDU1MTc2IGJ5dGVzDQogaW50ZWwv
aXdsd2lmaS9pd2x3aWZpLXNvLWEwLWdmNC1hMC04OS51Y29kZSAgfCBCaW4gMTU5MTcyMCAtPiAx
NTkxNzY0IGJ5dGVzDQogaW50ZWwvaXdsd2lmaS9pd2x3aWZpLXNvLWEwLWdmNC1hMC5wbnZtICAg
ICAgfCBCaW4gMjc4NjAgLT4gMjc4NjAgYnl0ZXMNCiBpbnRlbC9pd2x3aWZpL2l3bHdpZmktc28t
YTAtaHItYjAtODkudWNvZGUgICB8IEJpbiAxNTI2OTU2IC0+IDE1MjcwMDAgYnl0ZXMNCiBpbnRl
bC9pd2x3aWZpL2l3bHdpZmktdHktYTAtZ2YtYTAtODkudWNvZGUgICB8IEJpbiAxNjc4ODE2IC0+
IDE2Nzg4NjAgYnl0ZXMNCiBpbnRlbC9pd2x3aWZpL2l3bHdpZmktdHktYTAtZ2YtYTAucG52bSAg
ICAgICB8IEJpbiA1NTAyMCAtPiA1NTAyMCBieXRlcw0KIDI4IGZpbGVzIGNoYW5nZWQsIDQxIGlu
c2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbnRlbC9p
d2x3aWZpL2l3bHdpZmktYnotYjAtZm0tYzAtYzEwNi51Y29kZQ0KIGNyZWF0ZSBtb2RlIDEwMDY0
NCBpbnRlbC9pd2x3aWZpL2l3bHdpZmktYnotYjAtd2gtYjAtYzEwNi51Y29kZQ0KIGNyZWF0ZSBt
b2RlIDEwMDY0NCBpbnRlbC9pd2x3aWZpL2l3bHdpZmktZ2wtYzAtZm0tYzAtYzEwNi51Y29kZQ0K
IGNyZWF0ZSBtb2RlIDEwMDY0NCBpbnRlbC9pd2x3aWZpL2l3bHdpZmktc2MtYTAtZm0tYzAtYzEw
Ni51Y29kZQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbnRlbC9pd2x3aWZpL2l3bHdpZmktc2MtYTAt
d2gtYjAtYzEwNi51Y29kZQ0K

