Return-Path: <linux-wireless+bounces-36535-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNO+DuRdCWqmWwQAu9opvQ
	(envelope-from <linux-wireless+bounces-36535-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 08:19:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8809355F6F1
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 08:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 451E03009F8C
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 06:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C012BEC43;
	Sun, 17 May 2026 06:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NgCfpnZT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9FA242D89
	for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778998752; cv=fail; b=RGWzAa4lSu1bNUFDbcmcZhusCX1C+sr6v6xaPPauc06HTPKpWhzzff+vN2DHQ8bhLQ+D3qugf1JGo2BU8MZYxwfQeAE3qxbrmd98IT6xQWR89k9MWCUnPUxpKjr0dd/fM9moyazemg3xwV8LFPKRmaLKiwNZDFoIz2aqDPpFmoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778998752; c=relaxed/simple;
	bh=5FL3UE0Jnb7uuYq/CfxoFoqhtkw6sdReJW3T2n9Rqtk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ieOkDjVpheYmYJ6K2eH1JLC1AfifVOfOGZzngPlisAd2l8FZXi7kxzC59AYIpShu8pZQXJROS9geXU98aiRB2s2YwMCacFNhxdKPdk80+b6QmxDiDPlQS01QcFTtgfMPwGVMmjf2E1mk3qEEkwMLPb7cqSI1oBvPEBXJWyjY3+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NgCfpnZT; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778998751; x=1810534751;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=5FL3UE0Jnb7uuYq/CfxoFoqhtkw6sdReJW3T2n9Rqtk=;
  b=NgCfpnZT74ORHfuqqNlyV+lxQWv+RawjiSeaHiXoMCKSqtjg0oVnp7R2
   DWrKtkJ2sAI9GsNFjzL4NXj+RlM+37ad1GpYwtdeimzRezkjDJOS6l6Xa
   DqYLZWu3XseMnERhA3wrrgC4oSpFmw44k6ck46Wv59VXdjkcMJ7gesXpk
   pcTqtM3dksf6g6VHp0J+09sJ4dKQmHhpMlEkFiBuUOvFH+5E4Vc8ZHaB6
   T4HMVDdnuV21K7KvVmMLKy7OEXfGer+G3J2AU8AP1gQtqh4O2OiJnVCHf
   MsTcv5VAVPh4g41fnxkEosbUMiLqwdr5CWj1iq8Wv0TRjnnv5XPDzLs6o
   A==;
X-CSE-ConnectionGUID: DRXcT7r9SmeWW5QoGOOUZg==
X-CSE-MsgGUID: SLmZgloURIqOp1XC2ajnjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="105347770"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="105347770"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 23:19:11 -0700
X-CSE-ConnectionGUID: yF13z6KJQzSkTrekIXfL1g==
X-CSE-MsgGUID: QkT6nCAWR9msmBJAYQ5auQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="244072016"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 23:19:10 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 16 May 2026 23:19:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sat, 16 May 2026 23:19:10 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 16 May 2026 23:19:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhbHWCNyvqLrhYxYAmAOtE1JCUBlGg+Rh0rIrfd1zfuraVfJ2fDgi8zLDfnmQUqE/4Add5U8e7GGjSgKE/sQ3p6xq7ps/Sxf6B3FhgI9ZGnqqPca0YjXy/cyhSI9ryUQAXjh5dTG+socKdrq+NEJ2gE82hPt8wxvwTYHaTFDeDyoGCW1CVNhZ08uPUXtkvLZMQwZPLbM3sD1cAHuQ4m8tBApxFiuw1XPZHVShMOMVNVlCI/TiNfrf4kux7oId9lGtGf9HK4NSafjQnW/QD67QxupCNU9EeO/jnmyqHdZLeA+tKsaPkm+hJAJxgGFBggNLHy7oAJc6sBLfKS+k7SlTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FL3UE0Jnb7uuYq/CfxoFoqhtkw6sdReJW3T2n9Rqtk=;
 b=Rt4YLY5WcslfZ7HLP1pmnW20scFD6dKGhR/ln/HY7v08U8nlxrTOTxJChqUB4535VLACOZqFUfFOOX9Yk2qiczKCs/mvEsKuUKFwCzoIXEqTD+guf/uHCBjtMgspqBcihCok0tn1Z/GaHMhP0KdVcI+mSTpJPQnT3a3t47YMnN3t0YU093eVGmvau+90XOjNvZ8+srNK7AGvFdWPd5NH/ELNOYc9xUCxpCpZ4TIfuED6NDR5/GrMXtFdOQ++CVCbl1iM3RUHN7P7nyoK4vJLh83bjHxdqL7sYK1xgfOtnnsFL47kqKdtkRWMFLmNUVODm3pPEJ3w49icf/7QlqlL5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) by
 MW6PR11MB8339.namprd11.prod.outlook.com (2603:10b6:303:24b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.21; Sun, 17 May 2026 06:19:06 +0000
Received: from DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2]) by DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2%2]) with mapi id 15.21.0025.020; Sun, 17 May 2026
 06:19:06 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
Subject: pull-request: wifi: iwlwifi: fixes - 2026-05-16
Thread-Topic: pull-request: wifi: iwlwifi: fixes - 2026-05-16
Thread-Index: AdzldB8uQpKvUAxySRa2xKUokSPHQw==
Date: Sun, 17 May 2026 06:19:06 +0000
Message-ID: <DS0PR11MB788049C3A06783951B2E11DFA3022@DS0PR11MB7880.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7880:EE_|MW6PR11MB8339:EE_
x-ms-office365-filtering-correlation-id: dcf9674e-4c0b-43e6-c823-08deb3dc32f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|11063799003;
x-microsoft-antispam-message-info: X53g2Ft4ls5Nw6LSju1LZRV/KxD+vYAEW08K7/6d/l3ZDve74zIJJgkooYa/ow37P5XYM+qx04364muP8FTZxqgNDw4ROtSl8OAs2RmR1KZoFZHwD0OQwAtvj+YyeK0PJ/0jRixomBX1qIamfs7ThqgOAiOREUvqExezwZj70+erlBxOiI70m4QTovD1i8QcL8W2QBLwQQ353NE9HI19UmDQsEHDsDA713GpLEpYg73TAON/yroQPK7geS/rQ/4f6XF/BknsM1aklW0OqVC0u1eftSEw2Favt+GNimgkk20sjsT1JtAUcuhvXnKzNTzzfBJ6J73BCcbN2x01nSzuObTTIcICrzZBIfL45IHdKvU1n6NyIXZjXajDTyUN8aVNPxrTXFEpe6kUPeYbcOBLrdwTZxvckB+/HTYc2U9kpN0XJpckNA1PA5M+M2D5xM0X0Q6NUuNb6bqmr/PRbDINwVfTSQbrwMXZZPTVqEb5AExVgMdX5zFywsJtuO98gnvVlELv1FcHiJ8jlD4HoFxaqwtMXd4e9OtEui/2Nfivm3pt9lXLAPKi75nduoFFm0Vh6N/cDwLj9PfrA5pYYDbhG1NXlouO14OJJfiIaT0ZikFfv1LRMF1DzpqLksULgAsx42ysso56rUH+4x8r6LF755y6GXaPxqgSDFh3nRAp6A3mzPB7Xxj4KV8YBb//oeR8CfHXFUle1jLJmVE8XUgPmNztB5aYcNJk637HeHWCYv9Z+YM7LD5c2s0yB0VoE27X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVZVQUY0ZlYyUXRDTnRjMWVLUE0zRWJNSUVnandYVzVoV2tycnFEaCsyQk5E?=
 =?utf-8?B?aGZSaXhoU2xIaERRWUVXTGwrY2xPMis4aUdMRnRVd0x5Z3RhZ3FuY0VIS3ZS?=
 =?utf-8?B?Tk1YQ0NPWU13TWhuMmVOWWlkU0V2c0RjNnhNUGZlSTdldlI3dmM3REhlTDlS?=
 =?utf-8?B?Mm5QbEJsRjJSaTcrNnprT01IanVtSUo1akxITy9Nc3RlMStRQUNCSkE1V2tO?=
 =?utf-8?B?SW9qQmE5T0VDRHVzZTVnQnphZ1l0KzlmSndnUWV6RUFiQVJKUXVPbEFscWtx?=
 =?utf-8?B?QzhCZlJDWFA5VjNUVXFGSmFvZi8veVQ5QWk5NE1JZFhPc1pVU3NneVFwQlBv?=
 =?utf-8?B?Ump0amxSUm1TRXlkOVdVK2c2TWdNZnRselMzekt4b2pYQ0ljak5hbkwvT2la?=
 =?utf-8?B?NUhXMGxMdWhDd3NRb3d3cG5SWlJFODZZSTg1V1E4OFcwdFVYd2pPTzFKQ0ZG?=
 =?utf-8?B?QVdNWXNBTHl4aGlRelViQmgycUZPTmEzd2IvV2VYcHNSRTZGVUg5MW8rTita?=
 =?utf-8?B?SXo1UVJIVi9lc2NTcHZQRjJTU0hMKzBHOUZheEhBeE9GYWE2RlorWHUyc0JR?=
 =?utf-8?B?b1lOVzBJQStjRmk1dGhEM0VzOVZRYmxhcVJaV0hoUzkwektCeVJ3VFhzTzRT?=
 =?utf-8?B?elR1eHFkOW1jQllKNGlqWmZleGRxVG45NlFHRHhyQTJFemlHM0x6ZEJheGto?=
 =?utf-8?B?KzdkQVNrL21HK3pMM0FUQmlkOERrNzBQbndydW9aUTRLcml4Z2FILzRTa09W?=
 =?utf-8?B?djFmM3V2dUlPUGFLNnMzWklpbldrWEsvV3g4Sy9oWHVwdUI5eWVXbDAreWNU?=
 =?utf-8?B?TlhFdmFzZGhJN09SdVp2VHprY0gyeHY5RnNjd0ZxYitqMGwwYjk2WURhTXpF?=
 =?utf-8?B?eGFNTEgrN0ZEU0tURCtMVit0dlJ4R1o4emU5Mlh2MnI4TlR0VVhrWmpkbGNl?=
 =?utf-8?B?WFBGMXhhcWd2NWdTMjZEem1vQndzSjlCYm5ZWDR3c2tTbUtFWkEwMHE5d25Y?=
 =?utf-8?B?QmQ2YlBkUmtBMDNOSWlueTB3eUw5bk9WOTEzbVFBQUlQOVQ5bWtBSHROT2hJ?=
 =?utf-8?B?N0N5NkY0NFFwclpRalU3YTcxV3l6Q3dJdG8rZWpMd0lnTGp6Y2dHVUlHMzR5?=
 =?utf-8?B?bmdFeWFqckwyWC8zNHFkUHZhWXM0NFp0UFhWcTRjYzk0dk5lUGowOFpON0NH?=
 =?utf-8?B?eDkxQWU5MW40eTQ2Q0hURWR0WUxSdm5jQTZmZUZlTEpxVDUrQ0hibmREU2lH?=
 =?utf-8?B?ZnBiQXIxTEhkRGV2ZHJzaFFYQUViUXFlR1VNOG1HcFpFSlE0ZjBlSVlaQ2Q0?=
 =?utf-8?B?bFFCdk5CYkdhZHlDNkQ2eFU2MTIvdTNhZ09WOEY3eGRSVE5uWmk2SW5FRlhm?=
 =?utf-8?B?T0Z5cGxQdGcrdXU5STF4STV4REIyMDByclZoekZBQnRPZC9RbUdJR3YwSWhV?=
 =?utf-8?B?RWt6T0V4dFQ4T2VYRUkvSkF6SFhvb213Z0orSGVZOHA2SmtJNnZNZTRpMVBW?=
 =?utf-8?B?QWFoMCtIMm5nWU5Td1NSRkhSeEVUZkRINjRkL0wwL0J6YXhPb2hGazZoRDVY?=
 =?utf-8?B?UHVXR21pdWRKb3JlWmlVelR3bHF6Z3lBcnhwa1RWVWhqbHk0cnRhTGhFR29s?=
 =?utf-8?B?OGljcXUyTklCOU5XZDdtSnUvOVExWVY5NlBvLzBXUVl6VXFRUkZ1OFd4UXho?=
 =?utf-8?B?T1B6cE5HVlVsK1pEbjlkZGU5MVgyVjRQakxUYXBKL21hVVNacFdKRlN6M2pm?=
 =?utf-8?B?TVY1MmpqTmwyNjBwanFtQ2R4SmEzOEJSYnV3NnkwR3QrekI2Uyt0OG44T0xv?=
 =?utf-8?B?eXRxaDJvdXNZN0JuQnowU2NMcjU3K1ZGeUZMeEFweEJpV056WHh6WTlaNS9W?=
 =?utf-8?B?bk1xdFRQcGN4MVBqVVZ4NVEyamEzZFB1SjZCcmd3alQ5SC9HU1ZrQTlEckpX?=
 =?utf-8?B?MU94alFWaW9Ja0hYWExOMXJUZDkvQ1ltZjZTeUZzSnEzK1pwMnNlVFFIektU?=
 =?utf-8?B?dFpPOVRoQ2ZaeWt2ZFI3Wml3WWxDWFI1ZiszcTZqOUZSNXFxaTRkdjN4ako1?=
 =?utf-8?B?eXBqK3UyTDNwdWo2Rlg0cjUvaGdrbTZjdnptQzJYMEM2VEVGWGJrNVhwcXpa?=
 =?utf-8?B?YWp6M3lXZVI1d2hyU3VDZ1EyT2VBV054WjNjenVpaTJtdXlrdnRFVUYrOWxs?=
 =?utf-8?B?SDBnR1VIYXptTWRTYXd5VEk0b3RVdGdFNHVNY2FqeHNsZzVFQm5ILzBIMzFN?=
 =?utf-8?B?amxoaC9VMFNIRDZqd0kzdldJR0pFME84OXErNlNQQVBybzRWWElvK3RyODZY?=
 =?utf-8?B?Q3J4VWpsWVU5TEtXK2kyWDltMTVHQndycW9SN3VrdTdJRnJzdTBWSENrYzBk?=
 =?utf-8?Q?geTFGYjjoOoNJLfk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CQdAxvBjxMGjb67wSpbJO8NpxzmMwTUlBxE6WF/vjHH4tgCtg7IFvqTk6WrynaOmEpHkPIZi1qi75eleE6DpCsy8FG8Tf7n+awJfyP+DAOd/gLwRhDEftvz1OkHcjzq1z+oa19YsozTznG4x+FPOlA3WWHR1VAu13KeiaxAfO6UWTvZg438BnB/WKAZwh51HhllLFiBFYQNVfaw/0QXGnOm36H6FaicyR70aZzevexAta88IGQqt106R/SFJnUn38YGTxsjbDjIl4rt+J4ihijle6BM2X0r1qX6Ijk92tH9TBd91L1NRXtZOe2Fuotzxy+HQxAkQ3f8EUkG0vRUcVg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf9674e-4c0b-43e6-c823-08deb3dc32f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2026 06:19:06.2392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XeIylplkpqOf0GlTP+VxkQ0FuXmpOd0K7bw6q0/L0oyj2FFgIGk9VMd5V8cH0W4qPplDHZo5wPpRheJHpcxKzmL0T6rLMtlNHcziKEDYm7SotQ8KrBuq/+B0hB4EDPGf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8339
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 8809355F6F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-36535-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.980];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA3NjY2ZGJiMWJhY2M0YmE1MjJiOTY3
NDBjYmE3MjgzZDI0M2QxNmUxOg0KDQogIHdpZmk6IGNmZzgwMjExOiBhZHZhbmNlIGxvb3AgdmFy
cyBpbiBjZmc4MDIxMV9tZXJnZV9wcm9maWxlKCkgKDIwMjYtMDUtMDggMDk6MjA6MDMgKzAyMDAp
DQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2l3bHdpZmkvaXdsd2lmaS1u
ZXh0LmdpdC8gdGFncy9pd2x3aWZpLWZpeGVzLTIwMjYtMDUtMTYNCg0KZm9yIHlvdSB0byBmZXRj
aCBjaGFuZ2VzIHVwIHRvIDczNGE0ZTA1MWI5NzY3ZjQzOTEzNzk0MDA5NWQ2M2FmYmZlZDA3NDU6
DQoNCiAgd2lmaTogaXdsd2lmaTogbWxkOiBkaXNjb25uZWN0IG9ubHkgYWZ0ZXIgNiBiZWFjb25z
IHdpdGhvdXQgUnggKDIwMjYtMDUtMTYgMjM6MzE6MjUgKzAzMDApDQoNCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCndpZmk6
IGl3bHdpZmk6IGZpeGVzIC0gMjAyNi0wNS0xNg0KDQpDb250YWluczoNCndpZmk6IGl3bHdpZmk6
IG1sZDogZml4IFRTTyBzZWdtZW50YXRpb24gZXhwbG9zaW9uIHdoZW4gQU1TRFUgaXMgZGlzYWJs
ZWQNCndpZmk6IGl3bHdpZmk6IG1sZDogc3RvcCBUWCBkdXJpbmcgZmlybXdhcmUgcmVzdGFydA0K
d2lmaTogaXdsd2lmaTogbWxkOiBkb24ndCBXQVJOIG9uIFdvV0xBTiBzdXNwZW5kIHcvbyBCU1Mg
dmlmDQp3aWZpOiBpd2x3aWZpOiBtdm06IGZpeCBkcml2ZXItc2V0IFRYIHJhdGVzIG9uIG9sZCBk
ZXZpY2VzDQp3aWZpOiBpd2x3aWZpOiBtbGQ6IGRpc2Nvbm5lY3Qgb25seSBhZnRlciA2IGJlYWNv
bnMgd2l0aG91dCBSeA0Kd2lmaTogaXdsd2lmaTogbWxkOiBkb24ndCBkZXJlZmVyZW5jZSBhIHBv
aW50ZXIgYmVmb3JlIE5VTEwgY2hlY2tpbmcgaXQNCndpZmk6IGl3bHdpZmk6IHVzZSBjb3JyZWN0
IGZ1bmN0aW9uIHRvIHJlYWQgU1RFUF9VUk0gcmVnaXN0ZXINCg0KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KQ29sZSBMZWF2
aXR0ICgxKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1sZDogZml4IFRTTyBzZWdtZW50YXRpb24g
ZXhwbG9zaW9uIHdoZW4gQU1TRFUgaXMgZGlzYWJsZWQNCg0KRW1tYW51ZWwgR3J1bWJhY2ggKDEp
Og0KICAgICAgd2lmaTogaXdsd2lmaTogbWxkOiBkaXNjb25uZWN0IG9ubHkgYWZ0ZXIgNiBiZWFj
b25zIHdpdGhvdXQgUngNCg0KSm9oYW5uZXMgQmVyZyAoMik6DQogICAgICB3aWZpOiBpd2x3aWZp
OiBtdm06IGZpeCBkcml2ZXItc2V0IFRYIHJhdGVzIG9uIG9sZCBkZXZpY2VzDQogICAgICB3aWZp
OiBpd2x3aWZpOiBtbGQ6IGRvbid0IFdBUk4gb24gV29XTEFOIHN1c3BlbmQgdy9vIEJTUyB2aWYN
Cg0KTWlyaSBLb3JlbmJsaXQgKDEpOg0KICAgICAgd2lmaTogaXdsd2lmaTogbWxkOiBkb24ndCBk
ZXJlZmVyZW5jZSBhIHBvaW50ZXIgYmVmb3JlIE5VTEwgY2hlY2tpbmcgaXQNCg0KTW9yaXlhIEl0
emNoYWtpICgxKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IHVzZSBjb3JyZWN0IGZ1bmN0aW9uIHRv
IHJlYWQgU1RFUF9VUk0gcmVnaXN0ZXINCg0KU2hlcm96IEp1cmFldiAoMSk6DQogICAgICB3aWZp
OiBpd2x3aWZpOiBtbGQ6IHN0b3AgVFggZHVyaW5nIGZpcm13YXJlIHJlc3RhcnQNCg0KIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL2NvbnN0YW50cy5oIHwgIDQgKystLQ0K
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWxkL2QzLmMgICAgICAgIHwgIDYg
KystLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21sZC9saW5rLmMgICAg
ICB8IDEzICsrKysrLS0tLS0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9t
bGQvdHguYyAgICAgICAgfCAxNSArKysrKysrKysrKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9p
bnRlbC9pd2x3aWZpL212bS9tYWMtY3R4dC5jICB8IDI3ICsrKysrKysrKysrKysrLS0tLS0tLS0N
CiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS91dGlscy5jICAgICB8IDE0
ICsrKystLS0tLS0tDQogLi4uL2ludGVsL2l3bHdpZmkvcGNpZS9nZW4xXzIvdHJhbnMtZ2VuMi5j
ICAgICAgICAgfCAgNiArKy0tLQ0KIDcgZmlsZXMgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKSwg
MzUgZGVsZXRpb25zKC0pDQo=

