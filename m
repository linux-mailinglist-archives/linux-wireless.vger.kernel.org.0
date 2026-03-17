Return-Path: <linux-wireless+bounces-33361-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADlWOS3GuWmcNQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33361-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 22:22:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5065F2B29B5
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 22:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A362313305F
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 21:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91525385516;
	Tue, 17 Mar 2026 21:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IhTKOy1G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7852133F8C2
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782480; cv=fail; b=N86UbYfqToQGQGUFkmmU4gwZw10lEjg4I7/d6GhvL0xGXHhANy8lzAEJf93R2LvNX/CDAZWHTtaYJKk/4F+laaPERP1muws/3s34uml5ZQwvaLoWMBiFacNxJSczOkHpLEWGCpdyvWLdC//Y+rY5n4qXDgAlkBfvXTG36/M9Uo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782480; c=relaxed/simple;
	bh=L7hOxcSQXxMckQO0VEt8HVqUM1Ao0x2gZQ9hXwhDSDw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ue6X7JeDKaU42EX/hQ/egF5h041O0sftU3r7XdI7qlZpryLl5DCX9lzXVLN7vExAgwNo2vXb3ETHelbl99Amrjtqm4WO97pwiJp/ApG+H+78AvrC4wCZmkNAMQiqW+eUxvuUi2Q6FRP74Bun9+9GDc1QY79QEDBD9+aOAzjafME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IhTKOy1G; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773782479; x=1805318479;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=L7hOxcSQXxMckQO0VEt8HVqUM1Ao0x2gZQ9hXwhDSDw=;
  b=IhTKOy1GIXoSRB1BJABQ5UO/p6MoGDRubhaq9vDma3+53EheSOQA2psR
   bo1Jc3wdok2W8z2zdS5tuSBwpPUBeT7mc7WKXsr/yEyC0G58YV8IQLG+o
   SEkCOfwAin8gJ5Xrc1icsw4tkxXbgj6XJ3Uo5eRSf5dhTgxPh6hSVc1ya
   wA3eQhV+ba7Yi7TgXOEeQWjCpTjAC+2GqngrEjrEf7yJXftKie/Uwh4dh
   MdyFNV1T9eIiQS8qJWgClJdk+E3sEtkRnWQ6k0KcOnvW90yN0hcRtHweC
   x+EfUeoUv4L87CveKH3JuROh4fSl4ECRdkUqWEmYHX4ieWAjGXW42+DUb
   g==;
X-CSE-ConnectionGUID: XuWjTa4zQVqH6UfRjZKCOw==
X-CSE-MsgGUID: rEKgRdLzTB+tYMWSG9tBTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="78684984"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="78684984"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 14:21:19 -0700
X-CSE-ConnectionGUID: GrmCK3g8QAeEvArIf9aocQ==
X-CSE-MsgGUID: 5dF7ZTc3RGaSoJothUTvGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="218039889"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 14:21:18 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 14:21:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 14:21:18 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.50) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 14:21:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oH0ZaF+tTUeF4Ueq7LiJWiVSbncaG7hxHViBiGR2NHSh4nrMcPrtyyKCVdlt9Z4zOuU9A6k+/QLS8XaxQdwNDv+xuZheJ5BDX/JI3guu9gXzwj9U5zFv1VEMA05Nc3yOo3bMi+sinZR7auQf/G+0uceunCv5Xguy5DtY6NLd9HOSrylatA/GmPGtRFX4UKYs2SyvIn6Lje4B/DflF1ad0tJH+sfDR0fZXh8v195tA8je+eoDIirfUtt71BjbZzQqoxNZHujDEVLe+nUmfy13PwXt8Mdj9J1+m0WqL2w/dXZ0a1yzZvF+THNHw82R0NMz0+aBIjrfaWdvAowRmlpZfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7hOxcSQXxMckQO0VEt8HVqUM1Ao0x2gZQ9hXwhDSDw=;
 b=hKWibTmTBq0fi5ODjp/Zg7M0ASoqtioojkdoltYtFWj6S1AGsWvMA6Tnt1RcHRV9Pcr31Rbgy1F72kc0j11PkaKuSlhXTTIk5F5Sj6KGjctiyUDQFcJo1hXvZlKOqLhqs4TqaXn9IF5NsmkjigD4NKHzJnxLp7yQvv0c0WeWxKGA2mC7NeEQQq2zP+gIYHPl6oswN+TSC/zL8ICcB8odDLj7I7La6ucBiZcbDTN2Yln/qE38XhnP7s7ADwXmhuxxVphzDrvjaepxuHnx7CnJdSEVmIHWBWKbxBIS+m39qCsTgUHl/3pE/CR8faDlpgBs9bCsjQxi3Q2Y3YVQvPbc8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by PH3PPFD01EAC3BA.namprd11.prod.outlook.com
 (2603:10b6:518:1::d4f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 21:21:12 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d%3]) with mapi id 15.20.9700.013; Tue, 17 Mar 2026
 21:21:12 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC: "kyle@infradead.org" <kyle@infradead.org>, Josh Boyer
	<jwboyer@kernel.org>, "Hutchings, Ben" <ben@decadent.org.uk>, "Dreyfuss,
 Haim" <haim.dreyfuss@intel.com>, "Yang, You-Sheng"
	<vicamo.yang@canonical.com>, Linux Wireless <linux-wireless@vger.kernel.org>
Subject: pull request: iwlwifi firmware update 2026-03-17
Thread-Topic: pull request: iwlwifi firmware update 2026-03-17
Thread-Index: Ady2U8bhErhpG5EPTmeb0UfC9doxOQ==
Date: Tue, 17 Mar 2026 21:21:11 +0000
Message-ID: <DM3PPF63A6024A96E4ADFF6BC9FB4AAB041A341A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|PH3PPFD01EAC3BA:EE_
x-ms-office365-filtering-correlation-id: 3acaa548-d93d-4f90-9577-08de846b1d4a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: 691Z7HA7TsNTL+u/K/XOH4UhkIhuHKumZXn50BTxTv5gztfaA6lwVDbjhm6gzl52lXahI1YDkfPmBtvGHKdOnS5Wr70t3JpruYiB4RazOPjfz+CCSv/BMBk796/Sz5scn5PCqfZUmgHHLDg+92bKgCvr29oOSV+WfM8xjTuVAbIx1uoXe9OJ4xhtfR35oXOWH7uaCY7/IAL06+97lHO5su6BQcKCT9Yl43vfQurF0ufSb97vdvOPkYW/ug6mZT7933dJ4FWISlGu/UBR7HMo3JhnneNvXJLWxJq8pMHGPCcxw42Jj1f5KHOCvNTAk5wI/bnbda8+IRiLfQiCarxJTrLWLINbgui611npv1mjCEk+94FqwvTi9DqY46J2yqlkC9p01YbYGCTxUKsHxWn32Ho1TJvEFzjnYTApuNr7d96RasAgD1OQbAnNrYyVz1qSRSiJck5HxFsDU0V1mR/Q5I7qIDH81G705eqsu3Z3YSACw7dusXp0vRWQGnfqbSoxLKX5+aDC86q8Lwzh1Tg9/6ei3fGdLkmb9s4maZS1fQd3X9ljtS6Qxl7KI+8t0f344UgSdNzE5TIwsXVPJknGSwbgxZ0rFWe+KVYXM/0m5hL3d+Wrcc02cKEh90xIcjWzuUTucLsG2GeizTD96eJbc6OSFClNrfp82q0w6xu0Oc+Ctav2zY82+QCL3aWI4gA+jdrO0IdbGO8cJUvQnZ9RsIl8QN8X2xjmk1JwbcbER6jC3ISojBfrmzqDb7w/AYEJNtqlXbazgvliWYjivfIA4SWIx9dxnPPBaLqnpwLBkQw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0VBY1lyNW5DVGtJajkwVmp5VytjQWpvd2ZmdS9TMEE5WFdjTnBRRE5pb3Yw?=
 =?utf-8?B?dkxUaTFMQ0hSMmRPdDhnY2dWSDBweGc0cUUyNmpieUNOSWtuWTRJL0pHMlFo?=
 =?utf-8?B?aDVXd1FaZ1MzYk9kbEdMaG45OE8za1VWS1N6USszVTVzeVZiRnBsVk9XY1Jo?=
 =?utf-8?B?cFdndWxxRGR3dUpUSkN5ZHdxb1lhc1NpRUoycDY0K2hzcVJVNTBVUjJSdDZ4?=
 =?utf-8?B?VEl4QkZINzd5V2kwaGNIaFpINjlPWEJ4cFovVjNYUnVBOTg0V0lXYm5iN0I3?=
 =?utf-8?B?U1lCeXlaeU1xWWhXZ3M2aXYzWUkxRFV1Sm5TRk9ZWFpSdzFDa0ExMFNiQnpY?=
 =?utf-8?B?VWxXM2lHMDRpZ1JsRVdTRml5TnVueWw5c1NleXNBVjAzbCtrUzRoTThoSDFE?=
 =?utf-8?B?d3lBUHNMZXRnczltNXJsMmE5alQ3OVluU0piczk5KzdUWHp4bnBvNEd3Z0hx?=
 =?utf-8?B?RnZPTHdhRGtMY2RFQWpHM3doeHhHdGlCMjZuc09ub1lSWk56QXEweGdZalZE?=
 =?utf-8?B?SUFRZGJXSzJJL2NHU3ZKV05pUEIxRG1iVUZWci92bFY3TXFkUXlEN0JRTHg2?=
 =?utf-8?B?dFZ5bzhMWmtFVkYwMUpQN2V1VFZWdWRyLzVIQ0YvUjlyU2ZQQ1RGNDlpY3Rp?=
 =?utf-8?B?UThpSHhsOTZDWE01alUrVWlEVHlHTXQ1RW5VWHJpRmNnL1ZsSSt6cWppWkRS?=
 =?utf-8?B?UzdlckNYZTBHUGlyVTllTndndzFxUmFNcHpHYnJuVjJWSGdLRUl4S3p1YnVX?=
 =?utf-8?B?UGJOeEErS2s1QnJ5Y3RkM2JEakFBakhGOGNGL3hrcVkrMGhzU3lwY2hOTDNP?=
 =?utf-8?B?ZW5ENG4yVHVWN2dYRWlJTEpNM1A3d0tBaUJoZEwwYUIrQ2xpUTJLWDZLTmRP?=
 =?utf-8?B?VlNUVjZUNThWUVZzbTZXT2tsbExsODZBMTRoY3pDMzBvdER4OVhsckUxT215?=
 =?utf-8?B?S2pJS3llYk00RVZPUmVUNW5ZSEpPUHA5OWczeVJSOThyNFNJNk9zMTZObUNy?=
 =?utf-8?B?bGE5QWFicFVMbi8vNDVjUjIxUlR4eE9tZVBvTGFFVVJNUnBuSHlBNFFFMGEy?=
 =?utf-8?B?OVZGc1c5aXp4VzgxbkZFaUxRUkxDVmkxZ2lVR3Z1R1UwcCs1N1hlbFVzMDMx?=
 =?utf-8?B?MGRCaUdRdDNvZGZTWHNmRjljRlQ1Y1BMNXh5eXZkaG9VU2tHVmNVSFd1ZEQ3?=
 =?utf-8?B?RVhZL2I1ait0c3I2dGJyWWdqZmt0Tm1vaS9LM3FWcHZyUlU3MWtVRERVS2hj?=
 =?utf-8?B?YVVxTE9hazdXaHVidHUxMGJzbVh2SVZhQ2h3TnRpWGZ3eGMwWVg2ZElEcXlG?=
 =?utf-8?B?cjNmSGV5REQvOU4waE10WGZjcVZkdDhCZnlRV0hoSUNScklGRWJnTG9penUx?=
 =?utf-8?B?TnVxMlhiZnZVV0M1VWZlZU9uTTM0VWRLdVNMVnRIbHJvbktmWGo5VjFja3Vl?=
 =?utf-8?B?NUVWbHQyZlJYRTkreURBbEE3T2xOeUZQTXNXbFNDSUVMZDdFaUpoNTJ4SUlU?=
 =?utf-8?B?OXlmSmEzTzdrQi9SQWRzUkhIY2xHV1hCc0xnWiszN3NwM3BxTm0zb21TalJV?=
 =?utf-8?B?eDJIVjNDeUZhZGFvcTNXbmlNQWVlNzZjU3dGVkU1dHVpRGRFQm1XTUlOWG9U?=
 =?utf-8?B?Z2J1UjAyWStYaHZkbnJMV2JXQzBTRitJek5aOVkzRmZ3N24rdXlRRU9ZVXlR?=
 =?utf-8?B?LzduQUtqQUVrVFhuYmJDTGJxS0c3UlFkUzRnVHZHUngrL09MUGZHdWNsTUJ6?=
 =?utf-8?B?NzUydUd2ZmhqV0xzdjlMQWc4SURSMjd4ZEpiSS9lYm8rcmUrVkZINTBwZkZ1?=
 =?utf-8?B?NHpZVTRsdWEwRWx4UjcwWlFEejZsU2F1YkxXcGtSbWlqYlp3ZHpPWlJiU3ht?=
 =?utf-8?B?QVcwZXZCT014clF3S3U2NzN0SCtnOEpQT0l2N3FuaU5BQTdTSXdzVVg2Q2lU?=
 =?utf-8?B?VkFQTlc0SnhreEcwcXpjUzVycE0wQ1F5WjVSYlJaVG5KakFrVmRCcXlId1Rv?=
 =?utf-8?B?MEV3b28vb3hSb0djckhMbS9sazVOaHQ5cloyNEtrNHBCL1RFdjhLbFRDdXdC?=
 =?utf-8?B?WUFEQ2tqTTI1NGtMMThLU0ZmWkdJbXpqQjdNRkUrTjVKTjRzcklBeGx2R25P?=
 =?utf-8?B?NkVxNjd6SVVGVjhOcW41T0M2cnNkczFNalNNcWlnemJVeTgyZDBQN3A0RlVp?=
 =?utf-8?B?dXNEaHhpcUNONXpOTjdxT0h6Y0ZTdnJVVGU4OTgrYmhCQ2tqYVJsN2s2MUZ5?=
 =?utf-8?B?S3YyQ0MyTlErRjhPdHhXSWp0ODJkV2pWbmJZUDVRcWRjMGtScU1vaVhwU2t0?=
 =?utf-8?B?WFhyU2lUanBKc2hLcnlYcHdtdjZaL0xBNHc1amNqWU9ldTYwWW9ld1d1UmF2?=
 =?utf-8?Q?yPk5qW5VSjCJQWMQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jqIE3GqrXcxwi/ZbWih/bg/ffDSHOtq0onEU6fKRGPZ04japxcUl4C5sgkN6eug0Z6VseWI1cm8FQQ4EkyoGRct8E75eFh66khPS3MwMMfpODnN59nwMudBuYW+gcdFDS9C9Ys+bauY80ae2r5m8dRoDZao1B8jifJbkt8jqi/+SE2aN9saG+oy6jOBGbq7wvEEMm10ZJ7XQXYuQuhXGlWgQdMPF/HO3D8xpotLsR25XPb5N82aFvOptFIpvtMJKe6VbgyiL4sZCRJnOhBJR93ze8KEIO/vpaLef8uKguRx6934ZWxwS97lkDBqcKTLggZxKdYCQhyUadWRRBqdfxg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acaa548-d93d-4f90-9577-08de846b1d4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 21:21:12.0348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iHAJoDlJI3ZXsCxLjO7Qx2zLpwcydE8gu0h+fOBUlp8UBEqRXWMvgwIlVoDulwFt1ZWnNSFH/UoL95B0V7xZqQm3JEYLzL4W4eiH6CUCIaRQyavqWh+4o4+8AxN2hMur
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD01EAC3BA
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33361-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 5065F2B29B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGksDQoNClRoaXMgY29udGFpbnMgdGhlIGZpcm13YXJlIG9mIGNvcmUxMDIgZm9yIEJ6L1doLg0K
VGhpcyB3YXMgbWlzc2luZyBpbiB0aGUgY29yZTEwMiByZWxlYXNlLg0KDQpQbGVhc2UgcHVsbCBv
ciBsZXQgbWUga25vdyBpZiB0aGVyZSBhcmUgYW55IGlzc3Vlcy4NCg0KVGhhbmtzLA0KTWlyaQ0K
LS0tDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgODFmNzYxZDFiNWZkNTE0
NjlkODdkMTYzM2E5NTlkYmZmNDc4NWY1ODoNCg0KICBNZXJnZSBicmFuY2ggJ210NzkyeC1idCcg
aW50byAnbWFpbicgKDIwMjYtMDMtMTcgMTc6MzM6MzcgKzAwMDApDQoNCmFyZSBhdmFpbGFibGUg
aW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGh0dHA6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvaXdsd2lmaS9saW51eC1maXJtd2FyZS5naXQgdGFncy9pd2x3
aWZpLWZ3LTIwMjYtMDMtMTcNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIGFiY2Jh
ZDNjYzk1ODhiYzZlMmY0MTBiNTk4NDY0MmM5Y2Q0NjUyMGI6DQoNCiAgaXdsd2lmaTogYWRkIEJ6
L1doIEZXIGZvciBjb3JlMTAyLTU2IHJlbGVhc2UgKDIwMjYtMDMtMTcgMjM6MTQ6MTQgKzAyMDAp
DQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NClJlbGVhc2UgQnovV2ggb2YgQ29yZTEwMg0KDQpqZW5raW5zLUNvcmVfbWFu
dWFsX3NpZ25lZF9jb3JlMTAyLTU2DQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCk1pcmkgS29yZW5ibGl0ICgxKToNCiAg
ICAgIGl3bHdpZmk6IGFkZCBCei9XaCBGVyBmb3IgY29yZTEwMi01NiByZWxlYXNlDQoNCiBXSEVO
Q0UgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNCArKysrDQogaW50
ZWwvaXdsd2lmaS9pd2x3aWZpLWJ6LWIwLXdoLWIwLWMxMDIudWNvZGUgfCBCaW4gMCAtPiAyMTE2
ODg0IGJ5dGVzDQogMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgaW50ZWwvaXdsd2lmaS9pd2x3aWZpLWJ6LWIwLXdoLWIwLWMxMDIudWNvZGUNCg==

