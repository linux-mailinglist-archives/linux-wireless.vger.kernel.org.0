Return-Path: <linux-wireless+bounces-8588-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1808FD6D4
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 21:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF798281E9F
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 19:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187B21552E4;
	Wed,  5 Jun 2024 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mcMMVjxy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDCD154BF9;
	Wed,  5 Jun 2024 19:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617304; cv=fail; b=JQXtROCFODzUikY8TgKmSUTD0O5kaY5geS5GrK3owRqSMcfwWWwWlpANZIVQYi8gKKiiumtKOh9f4dWKmQI6W+mDaOWvr+qYCuZ8L5jZ1A7GMFJMfX0zSH3zn7dYZuGqJQOMoFdiLEs1hSTfQ2iIpzgomB1rv64/6O2r8HDcugg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617304; c=relaxed/simple;
	bh=87f5w6XCb9CcjCxOcCbUwNrQ2FJik7jC4DUwPo0Eb8U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uaOq/78fd5v/rl40NXeYMD2sCO/xXMLLS1ytKbGhdB0CzxXErWi4w3BLFl4H9VBkhkFux4kX38okQS2YScmYsPI3MIdE8U22kBn3NuJQOvcyvnHXSrBRdW9uICNt2Ww65HxWWUeopGSmdiC4kUctUr5+xuQDMsJZqwlXRqdLrxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mcMMVjxy; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717617303; x=1749153303;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=87f5w6XCb9CcjCxOcCbUwNrQ2FJik7jC4DUwPo0Eb8U=;
  b=mcMMVjxyc0DAslLa6t3Nmg6JJE9C0PkjILY6ex4bTOo9CXPyFceiMi2k
   mp1KscJlrWn4sxEqs1JMh3lFuYpN7GjUb4RA7ihJIt3gUisZaF/S3Md+w
   X9WTwYmRWoec/NkyWFYeo1/xFeiv95Z3BNTm3Ic9D91AvLsG5+5Zqa6HU
   3HOEWzk8GEfr2SAACvLPppqtLar/UHREqDrdAkGsDtc27DV2DsOE9UNih
   n8YTQuB0U2k7ebL27Xis/6zLPPeJHOSC87belQMEvCLgzDTEhwzYcPnl3
   0sHHmT9rBvZIjoO8yo95U4Vkmo/aFCJFbfigIrRh1hp8xNIRz7rYxA/fJ
   w==;
X-CSE-ConnectionGUID: HhmHLudzSmOY7V/k8rYdRw==
X-CSE-MsgGUID: +q1dtpn+TTaDn2Xc1AG5Bw==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="18075061"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="18075061"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 12:55:03 -0700
X-CSE-ConnectionGUID: lIGwImfySCOMEnn7USoT7w==
X-CSE-MsgGUID: q4MYxL+TSOW26x5kEs1sUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="42819062"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 12:55:02 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 12:55:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 12:55:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 12:55:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKf/dRBgQXm5/aK/fnH+Jb6KSsW2q0uuLWQLjFyyr9XipQurgAGPIGBIk11bsJIOTDV7zURu0J1mBvTDFWT2xOstpggblrxxQab1Ymj4Az3NCpRA8Gu11u8+tVaYP5npHU8BhaJg+hZrUzBO4bWTIcym3Zr70jROcx9G0bAVDRtNBNQmBYaq4XOxE+iLW1KZUg+3OVcOqb9HSPAh4hrktzR+ypt6RGsHjeE2RD+D4wp+B3c8Kv27kmt+xp4cRpJNlmM6LZrk7Ea36bfTsuYDC5T2HIfZpfL/+wy1kBJCgFrgCKrBIZFenrqmJP3B13AFq+EVoUjC2K6GY+D3ifgrkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jtn/wE9Bv2BwWhPy36hh+UAsQAgRN4HWKjnyATsiMW0=;
 b=XvDGJKigp1d68fAe5tMmZ+yGmcILdCZ1Umb76xhRKtDD0XUWPSVog9kj3ChWtAEhrjB4X/Ya/jz5b+yjlNs7R+icf4c7bmkV24vAjW9+B+A7u0r29+/d3PvGyac7bPT6V29R7lGYLJVOXItFH7kGI5kipgvND4MDdiU28EDKWD1xhFL93DJnH2ygTzRngwrfHqs3FmaAb5UCKpLzz14QwWyDLRTNVwbCZ2rzu4nP9PgzLivrB0c+j1adiugvTr0RIzyi1QbO3ll7Yu4lh2lTAtOI/9BQiwu4+hDSVBgIKs9zaI5tzAMpAirl0NxoBoIIQsFUbYJc2AqFgIhG+wjH6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by BL3PR11MB6339.namprd11.prod.outlook.com (2603:10b6:208:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 19:54:58 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 19:54:58 +0000
Message-ID: <621eb61c-87e1-417f-ad9f-f14d858ec8aa@intel.com>
Date: Wed, 5 Jun 2024 21:54:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iwlwifi: mvm: adding check if the thermal firmware is
 running
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	<miriam.rachel.korenblit@intel.com>, <kvalo@kernel.org>,
	<daniel.lezcano@linaro.org>, <johannes.berg@intel.com>, <dmantipov@yandex.ru>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240605195129.89353-1-trintaeoitogc@gmail.com>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20240605195129.89353-1-trintaeoitogc@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0021.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::14) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|BL3PR11MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: c5bf6683-4bb4-4d7b-51d8-08dc859960f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmdOdXphNEJuNHVXQks4cFBGODhpRzQ5K0JMYlpFbTUzaXA0OG5FVWFyWTJE?=
 =?utf-8?B?VExnVXcrS05EY0NDQktJa3dXWHVOdm1ncTRlTm9FMWNaL0tlekxXT1NlSFNr?=
 =?utf-8?B?N3ZZcUZGNnFhR3l5QlJKT041RFU0YnpWRCtYSm02Snp5cWlIRy9JaGd1R3RV?=
 =?utf-8?B?L3J4Nm50Wmd0dk1SNVJpYXhYdGlRUEYwTTRKWnY4QlJXT25rV1lUWkhjNHoy?=
 =?utf-8?B?L0V2T0tDQ1U5M0ZHZDNDQTRIVmpaWXFyQUpVSUZVTmRkWTRGM3N5amliQ3Fm?=
 =?utf-8?B?ODA0Z0RaS3NOd3lEQVAyTXRkc3ZPTTRzcm9rQWNqb3BJRTRjYmJDNXhrWktX?=
 =?utf-8?B?VVJnc1FoM3Jwb3RRNDYxRGYzaXp2NEZvaXVBTyt2cm1BajJXTFljY09YY2F6?=
 =?utf-8?B?V3BoRzhRNFA4eDNWd2xaQzBsVE5YUDhoQlQ0VSs0RGNUU1VneFduQXRYeFFx?=
 =?utf-8?B?cDNZR3pRcE5JbmxNbmdRd1grOU8xMHYzUlJ4VDZzQzZzQmMrRU9xczRmd3hC?=
 =?utf-8?B?NlFDVktPMVV2UitXZ1ZsZ0NQYnoxbG1lZEd0d2FnejR4RGFoeTB4THBPVG1B?=
 =?utf-8?B?MDhEd1N4YU95ZysyeHJ4WklMc0FpMEt6L3M3dzJ1RlVFMUVhcnRZSkVJaGxS?=
 =?utf-8?B?OWVjcFh3RU4yRDEvV0RrbE1xNm5EaExkdVB0Y1YzTEFrdUx6UW0renc4RU1n?=
 =?utf-8?B?dVlFcWp2UnhmWjV0Ylc5VnNjTFhiNTNzVDZLTzUyK3B5ZkhHb2lOWTNOUlox?=
 =?utf-8?B?WG5vMk8vMDUrb2txSndKTExrMW00TXpCZTYxbEtpYmlwN1hVYWJBVm5aYkFP?=
 =?utf-8?B?a292S3JLa1cyTzBXcEc5UzBrRnlmRmhBRUFQMUlqRHkxR3NYVFJITFliMHdi?=
 =?utf-8?B?MngxSUNreUtreEU1TEU2Um5yTzBnc2pLVWc2RnNWaTl6eEhQVEd0OThCMVEw?=
 =?utf-8?B?allSQkQ1UHlKZXBKWVZ3OTdJUmlPUUhLSlZKTTNPY3RwbEgxakhzOVhnWFpT?=
 =?utf-8?B?emVpaXdlQWgvK0dMUmtBZ01PZkQ0UnBGbUo3alZkTy9nYWJRaG5DaXVCVXM0?=
 =?utf-8?B?cEViNUl1RHJ5ZlR5NFlycHNROVROMW9nRnhjSGQ4VytzRWhIMjZKVTRVMDVk?=
 =?utf-8?B?TDl6RXozUGZoS2x6ckI5N2Y3NWh0cFFmQVlFcG5td0ZCM2VPSFlGM1JSRmxF?=
 =?utf-8?B?SDRVNlNQVXQzSXl5MEw0SWR2ZEltVHVUZ1ducDVqZGtJT1kwTWNxS0JEWU51?=
 =?utf-8?B?cGJKbk1nWm55S0lkTTl6T0RNOE9JaVZrcjkvM0sxdHVmTTQ3anZxS3JiTncz?=
 =?utf-8?B?eW9kYy9keDI2UmM5TXVONWRRTWZPNUFSak8wLysrayt4NytqeG1kRHdEN2JI?=
 =?utf-8?B?eHFSWHFoTU5hNGFHZTZabTRTYUwyb0hPbkZZZlJXaGhrMEljOHR4WnI4RWI4?=
 =?utf-8?B?VjNxWmxXR1oreXh0WWMxZUcrcGpxdXh3VVdMN1RGWjh0SjhUQVV3UE5ySnZ0?=
 =?utf-8?B?MFUyWmVnUU9lQnQ5VEcrdktVaFNWd3h6dFNOK0pyZ3B3WmNqK1NKU2crOWJ4?=
 =?utf-8?B?aVo3ODgxWkdBZ0RaeGg1RER2TFpvWDY0aTZSUkRPMlVNdXNRZ01GSmhscjBG?=
 =?utf-8?B?WFZwckhpN2lhSWpGNVhlS3BtTXo0R3VsVHVGV0NBWldjNitjajdudlZlV0VT?=
 =?utf-8?B?NEo3MDNOM0YxMm5pa3pWdlZCK0VWa3FOTGMzNGtzbDRpaGlOTVVMNFJkMDdj?=
 =?utf-8?Q?NT4kSnvEUp5E49xLFw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlNmV2pyVHhuVVVqN0FhUmEvZDdTZjVub2JPaG9QSFI0Um0yaEdOWXBzNGhQ?=
 =?utf-8?B?VmdoQVdoR2ZLUWtGeTk5SFRWVm4vOTRUc1d4RlZvd2tHL0kwOThoSzRWMXdN?=
 =?utf-8?B?SGd1YXFiWnlYVUhZQUswZVhyb1BpYkdTYk5LT1BoQkhsdk9vajI5VVQ3S1hG?=
 =?utf-8?B?R1BLVnEwSitwOHpRVXFFTDZVZ3VmbFhJWC9lU09UZU5COFdWbEg3Zm5OeXdN?=
 =?utf-8?B?N0wvaGdHZ1dLdVQ2emk4SHJhUnpyVnEweXBZODNXbkgwMkM0Vmg2bG42c1Zs?=
 =?utf-8?B?ZldYRSt2OE0xZW0zWGlHU0laVTJpUWJwcmd6ZFB1ZGZoREk2Q1ovTXFVOENx?=
 =?utf-8?B?YVJXMWZSWTlpVUR2TEhCQzlMdFV2RXBwbGtPMjM1a2ZxcW9xb3lhS2FhWWpj?=
 =?utf-8?B?aE5paGVSVWJWemRBK3JITXdiRWtQbWNBUi9aT05OaXNmRFAwdC90TzUwWDFR?=
 =?utf-8?B?aVY4Z0l0QnlMUDZjL2I3eDYreGVDY0V1eEhsVkJmbnZmMzNRTWdQSDJsS0lL?=
 =?utf-8?B?dE1kT2gyWms5Q2haNmhNR1VxMy8zQmZpQ29lbnQzQ2lNOG5iRHZtOFVXaVU5?=
 =?utf-8?B?UlN4WTBpKy92MHBYWXRzUDFjTVhGRG0weWFiQytkNEtjUGFnNFhibFk0bHhV?=
 =?utf-8?B?WC9DdlhnSFBqNHRrZXlSN05OSkcxcUhlbnQzeGFYZXJTOS9rOGRvVEdSeUxF?=
 =?utf-8?B?dUxXQngvLzdodHRsWkJzcUViY2oyZUdEUTV2UlZNSGV0VzM5L2xwVkdjRS9S?=
 =?utf-8?B?akkvZUxkY0lyYnZoOVBsaHR1RzIzZ3MwTnBSTzNsMEFlK2NqMnN4bElRdlpy?=
 =?utf-8?B?SW5XNlpaQzdKNEhSYm5nbG55UXovZnNWWnN6bDhmNGN1cFlxMGk3cXYrK2RJ?=
 =?utf-8?B?cmtoOUpyR2pMZXovZERrMkhUbkdwbDhzWnk0cG1IcXhybE9Sb3ZpVHhIZ05W?=
 =?utf-8?B?Z0cyQUw3YjNxOGNLUGlENzJqcTcrZm96dTZBWHFqSGRRL0JVOFdVU3d6V1NX?=
 =?utf-8?B?akFUcExLWlFtTXlNYnBQZ3AweDg1TGd4V0lBRG1hSHFCOU9lMWgxbU9nRnR2?=
 =?utf-8?B?Z1FxTkZNNnREWkRINUU1U3dDU3FidTh3Zjh0d3FVVHpORGgrUU43K09pUmhJ?=
 =?utf-8?B?Y1Rnb3AxR1FFR2poNHQ0ekRVSEszM1JBK0NUdkRWcHExT0NFc1V6SmpUSVVN?=
 =?utf-8?B?K0I1aElJSE1Hckl2WU1qOHdERUhDMGxyZFdwWWhSTklNRk5zaGVmZnVBMXZI?=
 =?utf-8?B?UWpiVCtTbGxaMmhaNHpsa0E1dkcyWnhEVS85RGdTbTJqNzdqdTNaN1REb2Ex?=
 =?utf-8?B?cjVHOHZwVUJ3ZVMyRFhTRFVYZXVFUmlKMEVCaHZZWmJpTWR5NXVPOWtJbTFD?=
 =?utf-8?B?Q1ZuZ2NMTWdLQVNZRnJlL3h3MUMrQ2YyZUVHclVUNWpSa0lmUG5RbkY5NGE1?=
 =?utf-8?B?dmduVW81eWF6ZlFoWFB3UitVY2pESFFHZzhjelBuWmtrRWJ3YXBFM3krRkI3?=
 =?utf-8?B?ZGo1cW9SeXBEWmswMmZTOUdiLytENXpzbkREczhpakhqNEtnSjY1UDB3NHBC?=
 =?utf-8?B?b1JyRHp0UVFCajlUdHhQTjdXWGFRbmovM0JmV3EyVmR4bDNIQ2pWbU1NWXA4?=
 =?utf-8?B?VjR1UVY1c0laU3RaSjJnMUZFZEVITUUydnZlVm80cFhaQTBqVmxRT0NyTWFp?=
 =?utf-8?B?KzNnZm9EcWRVbWdiUWdBTkhzbk5TUzkzS0RJWkZoelc0UFBIejl0ekJpb1pp?=
 =?utf-8?B?SDZIYnUxeW1ldzZrc05ZcWU0UXI1ZmVuN0JUSUs5NlJFZ2p6Z3YvSlY3VlpG?=
 =?utf-8?B?UmY0N0c1NVhJTkZYMWFickdQSUNGbGFUcWxvbmRodURtMUNONHBWOVhubU5Y?=
 =?utf-8?B?Z1UzbWEraDc1L0RtY05tZ3Y5ZGZuOGpKenh0Q25UejRUNklLc3dkSWpTMkZw?=
 =?utf-8?B?WmhMR1M3ZE9GM3FVVURYY2R6OGFjRDZUYWR6WDBQMDVqQTVjeXZIZXN6b25s?=
 =?utf-8?B?WHVLcDBHcEhva3BpUktFMmd0b1FtTTY5c2NwMEU4OUVNTm8vMSttdzRSc0o5?=
 =?utf-8?B?c09Ca0lFZkZtSTBGdWNkYnRVeXlVWEZ5Ym5xNHhXTkNWZW9TaURZL2p6N01T?=
 =?utf-8?B?TVcyaGtCTE1wckRxbXBCM3cyTWxlN0tlYWRRSEtxVnVFdnV4ZGdqaFp2R3JM?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5bf6683-4bb4-4d7b-51d8-08dc859960f7
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 19:54:58.5585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2dS9fxEPZUXm7RVazf3USzIbNBA6axOzbdEs/1gj+KhQHy54z+MAN0Npu8sof0Lm3FFORgnBlwevTr6skgGfxhBMPG5bpf61Etrzc3G8OA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6339
X-OriginatorOrg: intel.com

On 6/5/2024 9:51 PM, Guilherme Giacomo Simoes wrote:
> In the dmesg is showing the message "failed to read out thermal zone"
> as if the temperature read is failed by don't find the thermal zone.
>
> After researching and debugging, I see that this specific error is
> occurrenced because the thermal try read the temperature when is started,
> but the firmware is not running yet.
>
> For more legibiliti i change the tt.c for return EAGAIN when this was occurrence.
> After this change, in my computer I compile and install kernel in /boot
> and in my dmesg the message "failed to read out thermal zone" is not show
> any more.
>
> I would like to thanks for Rafael Wysocki <refael.j.wysocki@intel.com> ,
> Kalle Valo <kvalo@kernel.org> and Johannes Berg <johannes@sipsolutions.net>
> for your suggestions in my previous patch.
>
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
> ---
>   drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> index 8083c4b2ab6b..9aa9e3be39b8 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> @@ -620,8 +620,14 @@ static int iwl_mvm_tzone_get_temp(struct thermal_zone_device *device,
>   
>   	mutex_lock(&mvm->mutex);
>   
> -	if (!iwl_mvm_firmware_running(mvm) ||
> -	    mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
> +	int res = iwl_mvm_firmware_running(mvm);

Why do you need the res variable at all?  You can just call the function 
directly in the if () statement.


> +
> +	if (!res) {
> +		ret = -EAGAIN;
> +		goto out;
> +	}
> +
> +	if (mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
>   		ret = -ENODATA;
>   		goto out;
>   	}

