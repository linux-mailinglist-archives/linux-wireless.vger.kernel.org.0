Return-Path: <linux-wireless+bounces-39080-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u5alEJdXVmrE3gAAu9opvQ
	(envelope-from <linux-wireless+bounces-39080-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 17:36:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C71AA7567E5
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 17:36:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=LuQk6OqY;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39080-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39080-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4137A3006835
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B052D4418DC;
	Tue, 14 Jul 2026 15:36:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A913A453A;
	Tue, 14 Jul 2026 15:36:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043411; cv=fail; b=D7toBbtZtJqnbq/30SNg8Gf1QtZworkDpd6isiuTPQ/8GpcTd1WQINdW7wD2WkzcYCwHB93mjGhN7PCayq20ZX7eppgadfFcC7wtTaJDGy1yDhOSQG3D/xHR5YWQ+NU+ipmY/omTG9zhu6UPqIBKcKDth22UJkoNcpfx04Tj8z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043411; c=relaxed/simple;
	bh=K/Iq88sEhZTGte+ZBW3Vm4F7Td1lR0L3nErDk3SPBZI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L79YNGPJ9JBr0xfll5NEGMwdxoxPMpQ/moR5yqYYXvgKBlPlIP6N8SQAq/yjW/PnPQ6rbG6RL4J+AvbxJJlbj5SfXcCWa/Y9AgHkNx/N3X74kSxDd5mwkEuvW6NDP4BritBGrDS46mJmA4y9bMw2w6pV2Ts9TyrxCrh8sovU9xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LuQk6OqY; arc=fail smtp.client-ip=192.198.163.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784043410; x=1815579410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K/Iq88sEhZTGte+ZBW3Vm4F7Td1lR0L3nErDk3SPBZI=;
  b=LuQk6OqYuIafdIlMi8dpAAvKwweNBEGa0Kok/+0SnZabSBcwcf5n3P0/
   q96A7hvYV1rMJLZ7rEUg+ykvT9F9osCGfbfrQaUFyY6u80/dt0beChbdB
   6T6heec4tEmrtbhEKw2BYq2gEMlCIhnYu5FjdvuUfG829exge8bKXVtBN
   Srh0Tv1xGgyFbxB7iuFbPFHFiLIEB+YKcW6wpMXVUM3EME3L8Hmhkt5F0
   Bt97ej0TDGwKf6OmQL5OCoykuyfuDwjTHVBHr5hREybNNi7/9ac0tE9UL
   T7kt1YSQXtieZBBAs2KhAJ8FalhvI3rGvhCmefz4KJpuhKu4hS4g7hXhw
   w==;
X-CSE-ConnectionGUID: dC2gwF7LQ+m/v0qYnq4xhw==
X-CSE-MsgGUID: 9I08LXTSTq2sHGtspKPSeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="87212447"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="87212447"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 08:36:49 -0700
X-CSE-ConnectionGUID: h7Iq7qAsSPaBprgAuP6A/g==
X-CSE-MsgGUID: dmPsjNmAQ0a7FMeXTL9ibA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="294095740"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 08:36:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 08:36:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 08:36:46 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 08:36:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5IPxVKjoTqLJ8ku+4iRnFj6UdWt4IMDG8587t6JG253zcVSmVDNXiCfApKw+t48kLjqB/4EkDk/UCUOLfbHz6WnEdKcSl+FA0BUuWWdLp3hF2R6YKtplbPC4Sz7ZgEq1UKxWCEfpsQdtr8jko1gMWShWC892vWGjvrhTFCri4Y7QgpjX2KzqPFIJL6E45lSI3UpK8I/uN0a+j2yfpNZLkPllWfzrJ2yNdytSb+gve3JygVQYKPRD2SCMFJgZeR+wVsqiNyy0LbLfHSr0OKtCexlI1ZJfLaiEk7hT4jF9O2e5t7txotAM4g5EO4Y5DZPD3UjnrQ7m36/aygo6Qz1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/Iq88sEhZTGte+ZBW3Vm4F7Td1lR0L3nErDk3SPBZI=;
 b=X5nypMxL7Sfb+Of94ZTRoPzj9gjwfAQEWVyC73Yc/+pW/krhN5A9HqVSRyWnzZ+cR0xfM7va8wZJyg/os29E6I/ri35LEwdWt95Zx7q0Iv39vBxKTfbZKXwfcbo5iXDaqsZ74U4s+LbEbdE7VMl903ZKVuDdpIvSx9/m2KPzT/8Z2jCe2YHIPR4m/fMpWlFBWPOpTC1FGt1O7zLOCOBpHlISyc2QbeRMoKJGHlRi+WpNu9GUdocYg5EcKxcmmTsTYJlYzqW3Aiy1dI45Y1OdganWs1Zojx9tYaK3D7TLaAGJjkU5OBjgI8nNTdi0tdBOiGg7b5W5r60cUCYhPmEfOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) by
 LV0PR11MB9816.namprd11.prod.outlook.com (2603:10b6:408:383::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 15:36:43 +0000
Received: from DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2]) by DS0PR11MB7880.namprd11.prod.outlook.com
 ([fe80::7485:4354:e91d:2%2]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 15:36:42 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
CC: "Berg, Johannes" <johannes.berg@intel.com>, "Grumbach, Emmanuel"
	<emmanuel.grumbach@intel.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 0/4] wifi: iwlwifi: harden netdetect resume-path parsing
 against firmware-controlled inputs (mvm + mld)
Thread-Topic: [PATCH 0/4] wifi: iwlwifi: harden netdetect resume-path parsing
 against firmware-controlled inputs (mvm + mld)
Thread-Index: AQHc5GQgukhBBFy93UCbUdlUaIk2/bZtglmg
Date: Tue, 14 Jul 2026 15:36:42 +0000
Message-ID: <DS0PR11MB78801B329DDEDEE13B16ACCAA3F92@DS0PR11MB7880.namprd11.prod.outlook.com>
References: <20260515121100.649334-1-michael.bommarito@gmail.com>
In-Reply-To: <20260515121100.649334-1-michael.bommarito@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7880:EE_|LV0PR11MB9816:EE_
x-ms-office365-filtering-correlation-id: bb41e324-d490-4d5f-8b3b-08dee1bdb494
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|38070700021|56012099006|11063799006|6133799003;
x-microsoft-antispam-message-info: h6ZL9bZnwNg5RlA70KWHanJq2c3Xp98IOUr5DBRS2U96r/VyG/kGtH4+rQqu8Yp4NbhPUVrB07c+Ks8Odq92klijQQdjmfB9b+6ju+caNCF5PCtrdCUrdAv1raER7OpyIjKWrBwd13jN7FEAQdn7/ZWOirZqzSvqMgyryn6QfpHyLKyBfP/AuSEXVLyPf1BDaCsQKv2wDTucimVg0ubM+pwKlusTh3T26NpXJDKfLSpK5WcO0ZgfRfrShv7s11TKir7GQmncq11Kd1nWEA2s0asQsImksdJahB3a4I0/Re/7z0Za1WsNVt0ep5VJKbtS5QMG20OeSc9OZyzdODmXd6SRGpzPblFauWjFqAFSttwGbaLCaBpdWG4kkhf6n4b1P638Fj0+0DBz9WHLtugtKDiMEqzRG6liKGgQCE/IbIuxf4YHvNUsqlwpkiZEW7CiWw9VOX3CThRkoLhKDgFhXrRJxbbnwOfdu0Em0zuQjRbVvMyowXfA2g5PAZjF4ZuOwV1sPQ33PuNMekrVvqs1vdv81Y3M8A+rzxl6244SNV93SiG8csJ+7HF0w1wik+lhpfuYad/fquTEIV/ayW8w/1hb7sdPOqMNEWRN8We2N7syHGMQ6adQRtx08saeRFYRllKXPFGdmATiUqzgXpYWdZK5UQmbwPKX/KR+BCWRfq6RjBRm/pBb2hc6LcHMCd+HQNks3s1/s0DW8xreylafeKeaDgHCWV6QL2RN/95ROe4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmVuei81Kys3RFJIb2drVlUxMHIwVTlTN2FYN0Y2cUEwVEU2d01SSktXNjFy?=
 =?utf-8?B?MnlCWmJaakx6RlBnTTdPemh4YWpCbUFWUHN0dXIraUI1bEFvcDM5N0NqdnVr?=
 =?utf-8?B?NW9scnBQdUNrWTBIbHNhdUFBbGpORmpISGZUR3dteExidzdkNURraXZ3eUd6?=
 =?utf-8?B?dmtLeWpNOUZ4czJMZGx5ejVjOXloU1Bjc0ZpTm1hbGx2OGJZWG5jTzdrQVFC?=
 =?utf-8?B?TURqd3ZZTDFHNksweDRsazY0bWFoV25TSVh1WHVLZXkzZkpzQlh2clVTRzZz?=
 =?utf-8?B?K3QyNHhwWkhGK3ROS29RTk9oZlNCcWVhd0taOWpZZytPUHExWGorczM1OU45?=
 =?utf-8?B?eGIzMnJwZnhkUTlJYWtlVnVBZzNZT3NNUUhMRVF2WXFoM3hrSjFBekxYK2k2?=
 =?utf-8?B?N1pHa3VTYk5MZTFXYm9SN0E3Vm5CQ0VVUmFSaTZsYXlwaFB6QXN0ZXZqa3Zx?=
 =?utf-8?B?Qmtua1o0c0lmVmErd1hhUDY3MDdmY3IycEpXSy9mV3JjZkpLb0FCTnpjS3Ra?=
 =?utf-8?B?YTcwcHQ0T1NlTnBkWmQwZFcreVBvelV3dTNLVlI5UmwrWEt2MU1XVkF6KzZL?=
 =?utf-8?B?djRaaWhMVytlZ1FWck1UaXAxaUhIdXc0SG5uYnNjcFFPU0tOd0ZRV0pBd3Nq?=
 =?utf-8?B?SGd1emRHMHUzWEpHWWNLVlJMQ0IvTExiYVIxeEg3SFlMTG4yRUtDcFVUSHdv?=
 =?utf-8?B?LzVEcXVVT2tURURzTzZhUTNNZ2xvRXhKNzVPYWkvQ1VTZXhsVEs2YlJ2L1ds?=
 =?utf-8?B?Vlo0azFZeGo0TG41NjF2dDZ3ZUcrUjc0eUFPdHhNUmJUYXh4Wk9rS3U0MTVu?=
 =?utf-8?B?TFdvWlRscmdRQUc4N0lHaDZVS3ROS2poWjZOVDJhVWFTeGJRWnplL2I5eklx?=
 =?utf-8?B?YTU0ZzRlSUhmU1pUM0Mrbmxaa0ZuNU5POGN3NHEyUDZKNmRKUm9tWExUM3FI?=
 =?utf-8?B?cy9GUTRFRUFKSittUkYvY0wxdjR4VXFua01IK1pxYUdTemdjQTBBT29xRjh3?=
 =?utf-8?B?b2tPQU8zbXdxZUsydmxJRUw2NUxZU2I5cmJnaDU2N2Y2eXNHM0h4a3JnMUdH?=
 =?utf-8?B?WWpuVW05d1FWdmNYdnRTUmhjQjJDNXV2U0p2bWhzSnVvYkh5R0RuTkorUlNw?=
 =?utf-8?B?TVY4YlN2NHE2bEdvWm9mRkFSWmg4K1lmcCtEbWJYejNRR2UzNzJOTGdYT3FB?=
 =?utf-8?B?d3VVa21ILzhVeWh5WXlqOUxpa28rSmRZeWh1RVVpN1FoUWg5UE1TSjJhNURN?=
 =?utf-8?B?RytmTytxSHlTR1RJdHc1RWVYVzJsZ295NlpWQmNja0xJeUIrRVJxL25GNDRn?=
 =?utf-8?B?Um9zOUdWQzRyeGdIcVJ2RCt6V2FGSUhHdGJtUXJvVThsaTREOG1XSitlU0VM?=
 =?utf-8?B?MDM2MDBQK0NoeEFGbXUxc3ZkVVJQbFBPOHNha2ZqTEdZdlRTVWtCdlVDZzFL?=
 =?utf-8?B?TXR6alZ4c2tIS0FPeXhMMFBvaXFkRzgvZWJqakxrUDdvSExYei9TZnJBN2hp?=
 =?utf-8?B?NFJKVjlObDEraWs2a3pIQ09iUWM2N0NVK25MTUhYa0lyMnVmb0prRm16bXpX?=
 =?utf-8?B?S1pBUFlIWVh6WEhyc05wTEpybFlVK0dLajZacUtwencyd0dsK21NeTRJaHV1?=
 =?utf-8?B?T1Y3K3ZoZUNSb21sMFRsbGo2ZmEvYXBLTGNCdnlPV0tZSjYrbkY0SHFvQkJt?=
 =?utf-8?B?TjhDdlhPU2s3aEJxTXVtZklRMjhNQ0Zqdm1zK2QvZWh2dGs3bXNycEVBZFVE?=
 =?utf-8?B?QSt6b0IwcFFVVEpnRWdxcmNTNDloZE1mMUt3ZERLbHZ0Z2dvbXMwanJXZjg2?=
 =?utf-8?B?NHFCQzlmeTM0c21xN1N3dHU3eXR6WlkrdlY5NWIvSHo2RDdPM2ZxQ2swUnNO?=
 =?utf-8?B?MDdTeUFMZ3FKVjkzTk9xQ1o4S3E3MTRsUW1QRHBrTk5EVFIvaVZycy9HQnlV?=
 =?utf-8?B?cTVRTWtSdkpwMVN4Z1Izdnk1endhMU9HaStwNk45cUh0dWFoeVZqb3UwTTU1?=
 =?utf-8?B?VWdGc0pjVk41N2dqNUZobkZpMURuNGcxcjZCUjZzNWZyajVJOWZzNjY5SGV5?=
 =?utf-8?B?c3FLak05a21LNkJpeUwzTGhtZkVWTXE0bWFDdWJYTGpWMkpYM2VqbEhjWkRO?=
 =?utf-8?B?cFVoM0EzRHhURlhCaVRtQTBtcnZPSmk1NmxaUWhRRDdUQk81c3dYRzBsYm9j?=
 =?utf-8?B?R09CT2JtaThJUmNlN3V4eXJ3YmlSbjBabFN5NGtSeE1JWFpMQTRBRGJnYnFN?=
 =?utf-8?B?ZHZpRlM3MTd5czZQNVhoUXh6QjRsOElIMFREYmloOHkydy9sNDRKb0psdmt5?=
 =?utf-8?B?M3NFekhIZFBCc3VRTFBjRFVhWGlYSjlKOHorK0gxQkFXSmFGMncrSitpSXk5?=
 =?utf-8?Q?D4W7nHvmCmbm/7Ic=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DulX2Ea/sU64QYafRfdDX40KgFUsmsAxCqNvyGn7GFkbIHjz8nT4Fl8cUI3cNsRYcwu7dqHwCA3O0CC33ywd6ETM5cq8ozJcBcjEUNeUHpxYPB3SuZs9iQnNFMNdn9Cu4fyASkgEjz4DXDjxPd1rJuFmcZpKVufHcX23JydeNKPSVowKC7rNDT23L7FyGEZixUQVKzZ+puSWKCwL653UduAVdTw2nMKoaL4FE+q4lzHqN6WlIg9JU2Xgl66GcVK7IIY7PG41rY+2WcfPLWfWH1ZVxrSuLsWjjGJjqK2n/nMA55NmeBtK/JEVZPRU6KbdBOb7N7pha3rcVUVBJPJO4A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb41e324-d490-4d5f-8b3b-08dee1bdb494
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 15:36:42.7732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: edtg+sE67HkbBLONgLtbCMJVH2/xVluyokV2HQi/FDa7jIRDWrFM6A3dqERMEE1Ed/kFWg1EgtjEJjuE3UlNt4WDuluicHKTTSsOZ83V3IHZyjV4BK/jrLZDTGnFiGhy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB9816
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.06 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:johannes.berg@intel.com,m:emmanuel.grumbach@intel.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-39080-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:dkim,DS0PR11MB7880.namprd11.prod.outlook.com:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C71AA7567E5

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBCb21tYXJp
dG8gPG1pY2hhZWwuYm9tbWFyaXRvQGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXkgMTUs
IDIwMjYgMzoxMSBQTQ0KPiBUbzogS29yZW5ibGl0LCBNaXJpYW0gUmFjaGVsIDxtaXJpYW0ucmFj
aGVsLmtvcmVuYmxpdEBpbnRlbC5jb20+DQo+IENjOiBCZXJnLCBKb2hhbm5lcyA8am9oYW5uZXMu
YmVyZ0BpbnRlbC5jb20+OyBHcnVtYmFjaCwgRW1tYW51ZWwNCj4gPGVtbWFudWVsLmdydW1iYWNo
QGludGVsLmNvbT47IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
W1BBVENIIDAvNF0gd2lmaTogaXdsd2lmaTogaGFyZGVuIG5ldGRldGVjdCByZXN1bWUtcGF0aCBw
YXJzaW5nIGFnYWluc3QNCj4gZmlybXdhcmUtY29udHJvbGxlZCBpbnB1dHMgKG12bSArIG1sZCkN
Cj4gDQo+IEZvdXIgZGVmZW5zaXZlIGJvdW5kLWNoZWNrIGFkZGl0aW9ucyBvbiB0aGUgV29XTEFO
IG5ldC1kZXRlY3QgcmVzdW1lIHBhdGggaW4NCj4gaXdsd2lmaSwgdmFsaWRhdGluZyBmaXJtd2Fy
ZS1jb250cm9sbGVkIHJlc3BvbnNlIGxlbmd0aHMgYW5kIGJpdG1hcC1iaXQgcG9zaXRpb25zDQo+
IGF0IHRoZSBob3N0L2Zpcm13YXJlIHRydXN0IGJvdW5kYXJ5LiBUd28gcGF0Y2hlcyBlYWNoIGlu
IHRoZSBtdm0gYW5kIG1sZCBvcC0NCj4gbW9kZXM7IGJvdGggb3AtbW9kZXMgYXJlIGxpdmUgaW4g
Y3VycmVudCBrZXJuZWxzIChtdm0gZHJpdmVzIDcwMDAtc2VyaWVzDQo+IHRocm91Z2ggcHJlLUJF
MjAwIGhhcmR3YXJlOyBtbGQgZHJpdmVzIFdpLUZpIDcgLyBCRTIwMCsgd2hlbg0KPiBDT05GSUdf
SVdMTUxEIGlzIGVuYWJsZWQpLg0KPiANCj4gVGhlIHNlcmllcyBpcyBpbiB0aGUgc2FtZSBzaGFw
ZSBhcyB0aGUgcmVjZW50bHkgZml4ZWQgc2libGluZyBjb21taXQgNzQ0ZmFiYzMzOGU4DQo+ICgi
d2lmaTogaXdsd2lmaTogbXZtOiBmaXggcG90ZW50aWFsIG91dC1vZi1ib3VuZHMgcmVhZCBpbg0K
PiBpd2xfbXZtX25kX21hdGNoX2luZm9faGFuZGxlcigpIiksIHdoaWNoIGxhbmRlZCBpbiBzdGFi
bGUgb24gMjAyNi0wNC0xMS4NCj4gV2VsbC1iZWhhdmVkIGZpcm13YXJlIHNob3VsZCBub3QgdHJp
Z2dlciBhbnkgb2YgdGhlc2UsIGJ1dCB0aGUgaG9zdCBwYXJzZXINCj4gc2hvdWxkIG5vdCBkZXBl
bmQgb24gdGhhdC4NCj4gDQo+IFBhdGNoZXMgMSArIDM6IGxlbmd0aC10YWlsIGd1YXJkIG9uIHRo
ZSBmaXJtd2FyZSByZXNwb25zZS4NCj4gaXdsX212bV9uZXRkZXRlY3RfcXVlcnlfcmVzdWx0cygp
IGFuZA0KPiBpd2xfbWxkX25ldGRldGVjdF9tYXRjaF9pbmZvX2hhbmRsZXIoKSB2YWxpZGF0ZSBv
bmx5IHRoZSBmaXhlZCBoZWFkZXIgc2l6ZSBvZg0KPiB0aGUgcmVzcG9uc2Uvbm90aWZpY2F0aW9u
LCB0aGVuIG1lbWNweSB0aGUgZmxleC0gYXJyYXkgdGFpbCB1bmNvbmRpdGlvbmFsbHkuIEENCj4g
cmVzcG9uc2Ugb2YgZXhhY3RseSBxdWVyeV9sZW4gLw0KPiBzaXplb2YoKm5vdGlmKSBieXRlcyBw
YXNzZXMgdGhlIGd1YXJkIGFuZCB0aGUgbWVtY3B5IHJlYWRzIG1hdGNoZXNfbGVuIC8NCj4gTkVU
REVURUNUX1FVRVJZX0JVRl9MRU4gYnl0ZXMgb2YgYWRqYWNlbnQgc2xhYiBjb250ZW50LiBLQVNB
TiByZXBvcnRzIHRoZQ0KPiBzbGFiLW91dC1vZi1ib3VuZHMgUkVBRCAiMCBieXRlcyB0byB0aGUg
cmlnaHQgb2YgdGhlIGFsbG9jYXRlZCAyNC1ieXRlIHJlZ2lvbiIgaW4NCj4gdGhlIGttYWxsb2Mt
MzIgY2FjaGUuIFNhbWUgZml4IHNoYXBlIGFzIHRoZSBzaWJsaW5nLg0KPiANCj4gUGF0Y2hlcyAy
ICsgNDogY2xhbXAgdGhlIGNoYW5uZWwtaXRlcmF0aW9uIHVwcGVyIGJvdW5kIGFnYWluc3QgdGhl
IG5ldGRldGVjdA0KPiBjaGFubmVscy10YWJsZSBsZW5ndGguIGl3bF9tdm1fcXVlcnlfc2V0X2Zy
ZXFzKCkgYW5kDQo+IGl3bF9tbGRfc2V0X25ldGRldGVjdF9pbmZvKCkgaXRlcmF0ZSB0aGUgcGVy
LW1hdGNoIG1hdGNoaW5nX2NoYW5uZWxzW10gYml0bWFwDQo+IGFuZCBpbmRleCBhIGNoYW5uZWxz
W10gcG9pbnRlciB0YWJsZSBieSBiaXQgcG9zaXRpb24sIHdpdGhvdXQgYm91bmRpbmcgdGhlIGJp
dA0KPiBwb3NpdGlvbnMgYWdhaW5zdCB0aGUgdGFibGUgbGVuZ3RoLiBUaGUgcHJlLWV4aXN0aW5n
IGNhbGxlci1zaWRlIGd1YXJkcyBjb21wYXJlDQo+IHBvcGNvdW50IHRvIHRhYmxlIGxlbmd0aCwg
bm90IGJpdCBwb3NpdGlvbiB0byB0YWJsZSBsZW5ndGguIFRoZSBtdm0gcGF0aCBpdGVyYXRlcw0K
PiBvdmVyIHRoZSBmdWxsIDAuLjU1IGJpdCByYW5nZTsgdGhlIG1sZCBwYXRoIGlzIGFjY2lkZW50
YWxseSBib3VuZGVkIHRvIDAuLjYgYnkgYQ0KPiBiaXRzLXZzLWJ5dGVzIGNvbmZ1c2lvbg0KPiAo
Zm9yX2VhY2hfc2V0X2JpdCgpIHRha2VzIGJpdHMsIGJ1dCB0aGUgY2FsbCBwYXNzZXMgc2l6ZW9m
KC4uLikgd2hpY2ggaXMgNyBieXRlcykuIEJvdGgNCj4gY2FuIGluZGV4IHBhc3QgdGhlIGNoYW5u
ZWxzW10gYWxsb2NhdGlvbiB3aGVuIHRoZSB1c2VyJ3MgbmV0LWRldGVjdCBjb25maWd1cmF0aW9u
DQo+IGhhcyBmZXdlciBjaGFubmVscyB0aGFuIHRoZSByZWxldmFudCBib3VuZC4gVGhlIHdpbGQt
cG9pbnRlciBkZXJlZmVyZW5jZSBvZg0KPiBjaGFubmVsc1tqXS0+Y2VudGVyX2ZyZXEgaW5zaWRl
IHRoZSByZXN1bWUgd29yay1xdWV1ZSB0aGVuIHBhZ2UtIGZhdWx0cyB0aGUNCj4ga2VybmVsOyBh
IEtVbml0IGhhcm5lc3MgZXhlcmNpc2luZyB0aGUgbXZtIHNoYXBlIHBhbmljcyB3aXRoDQo+IA0K
PiAgIEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBTZWdmYXVsdCB3aXRoIG5vIG1tDQo+IA0K
PiBhbmQgdGhlIG1sZCBzaGFwZSBwYW5pY3MgaWRlbnRpY2FsbHkgd2hlbiBuX2NoYW5uZWxzIDwg
Ny4gVGhlIG1sZCBmaXggZm9sZHMgdGhlDQo+IGJpdHMtdnMtYnl0ZXMgY29ycmVjdGlvbiB0b2dl
dGhlciB3aXRoIHRoZSBjbGFtcCBiZWNhdXNlIGFwcGx5aW5nIG9ubHkgdGhlIGJpdHMtDQo+IGNv
cnJlY3Rpb24gd2l0aG91dCB0aGUgY2xhbXAgd291bGQgd2lkZW4gdGhlIE9PQiBleHBvc3VyZSBm
cm9tIGogPCA3IHRvIGogPCA1Ni4NCj4gDQo+IEFsbCBmb3VyIGJ1Z3MgcmVxdWlyZSB0aGUgZmly
bXdhcmUgdG8gcHJvZHVjZSBpbnB1dHMgb3V0c2lkZSB0aGUgaW1wbGllZCBkcml2ZXINCj4gY29u
dHJhY3Q6IGEgc2hvcnQgcmVzcG9uc2UgKHBhdGNoZXMgMSwgMyksIG9yIG1hdGNoaW5nX2NoYW5u
ZWxzW10gYml0cyBzZXQgYXQNCj4gcG9zaXRpb25zIG91dHNpZGUgdGhlIGNoYW5uZWxzLSB0YWJs
ZSBib3VuZCAocGF0Y2hlcyAyLCA0KS4gV2VsbC1iZWhhdmVkDQo+IGZpcm13YXJlIHNob3VsZCBu
b3QgZG8gZWl0aGVyLiBUaGUgcGF0Y2hlcyBhZGQgZGVmZW5zaXZlIHZhbGlkYXRpb24gYXQgYSB0
cnVzdA0KPiBib3VuZGFyeTsgdGhleSBhcmUgbm90IGEgY2xhaW0gdGhhdCBjdXJyZW50IEludGVs
IGZpcm13YXJlIG1pc2JlaGF2ZXMuDQo+IA0KPiBSZXByb2R1Y2VyOiBzZWxmLWNvbnRhaW5lZCBL
VW5pdCBzdWl0ZSB0aGF0IGxpZnRzIGFsbCBmb3VyIGJ1Z2d5IGNvZGUgcGF0aHMgaW50bw0KPiBz
dGFuZGFsb25lIGhhcm5lc3NlcyAobm8gZmlybXdhcmUgb3IgaGFyZHdhcmUgZGVwZW5kZW5jeSwg
fjEwcyBvbiBVTUwpLg0KPiBQYXRjaGVkLXNoYXBlIHN1YnRlc3RzIHBhc3MgY2xlYW5seSB1bmRl
ciB0aGUgcHJvcG9zZWQgZml4ZXMNCj4gKHRlc3RfcGF0Y2hlZF9yZWplY3RzX3Nob3J0LCB0ZXN0
X3BhdGNoZWRfYWNjZXB0c19mdWxsLA0KPiB0ZXN0X3NldF9mcmVxc19wYXRjaGVkX2NsYW1wcywg
dGVzdF9tbGRfbWF0Y2hfaW5mb19wYXRjaGVkX3JlamVjdHNfc2hvcnQsDQo+IHRlc3RfbWxkX3Nl
dF9mcmVxc19wYXRjaGVkX2NsYW1wcykuDQo+IA0KPiBBbGwgZm91ciBwYXRjaGVzIGJ1aWxkIGNs
ZWFuIHVuZGVyIHg4Nl82NCBhbGxtb2Rjb25maWcgd2l0aCBubyBuZXcgd2FybmluZ3M7DQo+IGNo
ZWNrcGF0Y2ggLS1zdHJpY3QgcmVwb3J0cyAwLzAvMCBvbiBlYWNoLg0KPiANCj4gTWljaGFlbCBC
b21tYXJpdG8gKDQpOg0KPiAgIHdpZmk6IGl3bHdpZmk6IG12bTogaW5jbHVkZSBtYXRjaGVzX2xl
biBpbiBzY2FuLW9mZmxvYWQtcXVlcnkgbGVuZ3RoDQo+ICAgICBjaGVjaw0KPiAgIHdpZmk6IGl3
bHdpZmk6IG12bTogY2xhbXAgc2V0X2ZyZXFzIGl0ZXJhdGlvbiB0byBuX25kX2NoYW5uZWxzDQo+
ICAgd2lmaTogaXdsd2lmaTogbWxkOiBpbmNsdWRlIG1hdGNoZXMgdGFpbCBpbiBtYXRjaC1pbmZv
IGxlbmd0aCBjaGVjaw0KPiAgIHdpZmk6IGl3bHdpZmk6IG1sZDogY2xhbXAgbmV0ZGV0ZWN0IGNo
YW5uZWwgaXRlcmF0aW9uIHRvIG5fY2hhbm5lbHMNCj4gDQo+ICBkcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL21sZC9kMy5jIHwgMjAgKysrKysrKysrKysrKysrLS0tLS0NCj4gZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vZDMuYyB8IDEwICsrKysrKystLS0N
Cj4gIDIgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4g
DQoNCkhpIE1pY2hhZWwsDQpUaGFuayB5b3UgZm9yIHlvdXIgdGltZSBhbmQgeW91ciBmaXhlcyDw
n5iKDQoNCjIgb2YgdGhvc2Ugd2VyZSBhbHJlYWR5IGZpeGVkIGludGVybmFsbHksDQpCdXQgdGhl
IDIgJ2NsYW1wJyBvbmVzIGFyZSBub3QuIFdpbGwgY29tbWVudCBvbiB0aG9zZSBzZXBhcmF0ZWx5
Lg0KDQpNaXJpDQotLS0NCj4gLS0NCj4gMi41My4wDQoNCg==

