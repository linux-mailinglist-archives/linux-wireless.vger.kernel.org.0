Return-Path: <linux-wireless+bounces-31583-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJlMHOFVhGlb2gMAu9opvQ
	(envelope-from <linux-wireless+bounces-31583-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 09:33:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 807D0EFECC
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 09:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED3BB3002D36
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 08:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23605344D94;
	Thu,  5 Feb 2026 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPg3K6hH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4653446CA;
	Thu,  5 Feb 2026 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770280411; cv=fail; b=AI+Lo096liyfoAJ+fS69jZ1v61V8GTHZ//CHVjZUdJQmSrLldU+8nXipzUfmRpNjOtxbnrMJ4NSUZaNcdyuqWtBrb5l19qLlW9Mf4hXbFn0Ad5OICFMt9jNzzJI9i0fuJNCjcRq94pm9fVs8/k3KPi+yLUg9e0O3rCzo2vcCbws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770280411; c=relaxed/simple;
	bh=hFPLmV8HZkPKPM108QHrQXzHR2z7Uv8QzeJwGMYaOPM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jXmjWZNmQpg7v0Yw6j2NTEuo9Fq6/pRUIt7IjJWwGiZMQ3eE6+UEeOR6+MpRCjBANBkGEDdt7EYNq9VfW08pgcXE6MpXXt4NyWl5JmU2GYuL0ezQDzA6O88QhCzbWV86F1gwFTniPXKc/5z3feYFHo6oqJsofzazEvT6OydB78A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SPg3K6hH; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770280410; x=1801816410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hFPLmV8HZkPKPM108QHrQXzHR2z7Uv8QzeJwGMYaOPM=;
  b=SPg3K6hHiUFsoAS+27psVQOaZANV549CUEPqd7ELXWU2rG9czGCYla9R
   Ac5JT12I3Ud1D9vcg8ASF4xCo2Kt7x8Hr69XYLnBd0N5L2zDB1v/6mA1s
   5SzPUJN7RO/hZLF/jFQhVtM4hudHXlKAKxdl7/8aMljbXHzJPB9y8RMHK
   UZs93WQqosp6LI/+EQeCvLjMMqy/Y8DyJbVIlESgE/risJSh2sVcfXheJ
   pKBzlOvRqaS0xuzepTIL+uZqww2JFi8oQDuvQlmMynpMCUHiFBGkIFhME
   lkKv6UhQ4LMbTxQhoGwTaEOMKt9ySH0x/lElvrAMtMvFqzZruObc0PjXX
   w==;
X-CSE-ConnectionGUID: 178tcEkATV6TTGyXdg0O6Q==
X-CSE-MsgGUID: Wt/4Y9IZRa+HRCSsOBxQ3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="70494118"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="70494118"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 00:33:27 -0800
X-CSE-ConnectionGUID: 2Ch95sVMTvq4uxzuFn38QQ==
X-CSE-MsgGUID: p3xdn+pVRK6AJW+kYHUIJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="210229798"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 00:33:25 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 00:33:25 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 5 Feb 2026 00:33:25 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 00:33:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5P1JXwn2Toi7GIzicit/487Z0SuJ4kP7lpUAHNd+5F+7sMa6lS12+NWzbcKqkpgI2K0xClazImtvQVaoMwc1xdAiWZG03dN6d4cDC51+69HLpDa5m8FKPCfZpo42eUCcmg93rNSdQOjy1qzC42Oi0bo1pVOMmXtickAH5Q9lGPXzESIA8sfldQSlAegYSthwWjT7o0KtZlka82BTHAVi/A9Y+aGCv5DE/sZdgs7nfIx7iDVdxTX/7YmRxxMvoZ/cGiA+NG2udbt5A+kgChUP3GP/FaxFXg0SDOGZREIR/+RmeKpw3zhniOdPRxnzM0pb4lxPIujCQw6V+bhhoV5mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFPLmV8HZkPKPM108QHrQXzHR2z7Uv8QzeJwGMYaOPM=;
 b=NXDu/JBVqofE7oA8hMk+ThTDChAu7AQgks9YRAqifqo4C2B6TlkGxg9lpMhrOgpVkTlIrCWucBidv7FoM/mqruNzily6EkeQJ2lx/pFagjwRZZS/qqfwfAeWv1108RAmEu2isH1vWE8c0UJpgGxqGaJmlkj875Nqds3Vua/LrdsTd3zk7khpfK7LYJmjRSuvkpuI2XsGFPh/76uaDtrQbNW8RduvLuJ2KZCcZ59pJwXrwYcFPIeFRpqvkIFRnPlMf+0oYmJiBPkwpTzc+7yotuuMeYeAG03iAZWQpfJpk1TP3hHefDtVvQQMmkv4UVlfk03PqaGJLDxWwXUSWxKH2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ0PR11MB4991.namprd11.prod.outlook.com (2603:10b6:a03:2df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 08:33:22 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 08:33:22 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "Johannes
 Berg" <johannes@sipsolutions.net>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Stanislav Yakovlev <stas.yakovlev@gmail.com>, "Alice
 Michael" <alice.michael@intel.com>
Subject: RE: [PATCH net-next] net: intel: fix PCI device ID conflict between
 i40e and ipw2200
Thread-Topic: [PATCH net-next] net: intel: fix PCI device ID conflict between
 i40e and ipw2200
Thread-Index: AQHclnTCGHK9IvvOO0WamlZBgXRFZLVzwCQwgAAC4YCAAAQRUA==
Date: Thu, 5 Feb 2026 08:33:22 +0000
Message-ID: <IA3PR11MB8986716738B85D0CEF52EAD2E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260205075445.43347-1-enelsonmoore@gmail.com>
 <IA3PR11MB89868B6110780F90795E4ED7E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <CADkSEUiNrMCGzECO2t+Stx7Xnk=bCAp+mk=99FrMZFq4wOmgFQ@mail.gmail.com>
In-Reply-To: <CADkSEUiNrMCGzECO2t+Stx7Xnk=bCAp+mk=99FrMZFq4wOmgFQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ0PR11MB4991:EE_
x-ms-office365-filtering-correlation-id: a4af951c-26d3-4e75-cc43-08de6491390e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eVE1SzQzbWZKVHM1WFhIZWprSnRmQS9zV1QzcFQ2N2pwUUNEWHVINGxPT0w3?=
 =?utf-8?B?Y0VLWkFVKzFuZnljTnRmM2NKeUtENHlNN2ZKTUVrdkxUd1Y1TXhHamNlcFN4?=
 =?utf-8?B?eVhJTG9iWVJmWWRDZ3ZsT3JBSnNUOTRZdzRsTW9oUXhoNE8rR1YzRmFJb2J2?=
 =?utf-8?B?L0JPZWdJQmtyeXJ2ZGVEWTlDbWFWbDRHdXowMDVGak1mQ1JyQ1VJSHVuUHZU?=
 =?utf-8?B?OHdMV3AvVEFYVDk4Z2xrb1hIemdYc3BKQXA1UVNyZFJ6WVh2MUpheXdYbFlC?=
 =?utf-8?B?QmFGb3F3bmNMVFRYOFA0VVExakdjdjArTTlueEx2b2VZcHBXRWhzald1N0lK?=
 =?utf-8?B?dHR6YjBGODQ4RG15ZGU2aTd0Q2hsdkJwZU9QOEJmYUhTV0hwSkxrWTR6RHIv?=
 =?utf-8?B?Wi8zemtYdWUzUmFPZjV4dUtJOVZuRk5QTjh0N0RNT3FIbzRmbnIyVnBpeXRk?=
 =?utf-8?B?RGEwcUJOc1g5eUVHZlV0cmM3dFdDdDdxbzNkRjNDQmN0bFVsMHBCZ1JuSWNM?=
 =?utf-8?B?cE5vRFVSR2hPM3h0WGlpNG1vdDFZd1FObG1VUDdhY0hhWmU2MkV2bmNpbjZB?=
 =?utf-8?B?MnlITHUxM2o0ZS80VEZ5UmhGTW5BY2dmbW1yNys2bjFZcEtINUpsS0VpQWdP?=
 =?utf-8?B?U3h0VHViZmxmMHBKaTJBSzlsL2RiZ0U5cGFrVjdwK0tFdmZDczlGSE1jM3lB?=
 =?utf-8?B?bnRIREg3dVhRdU0rVHdVaHp0dVNGdmNaWHZWbmN1WHZXUG8vaHpLQzVFTFEr?=
 =?utf-8?B?c3FsWkdQdnN1ZEZtUWt4UTJvVWROVHltcjVWUHg3bFErUW5EaDRtbDkxSHJk?=
 =?utf-8?B?NW1wajdsM2tENTZoSGVrS1Q2RVdwSXVnaUhrNEdXTTRYTGRHMlJVTHVuTE13?=
 =?utf-8?B?NUxxTTczakpXa2F2cjYxNWN3QzdRSldKb1BUcXJOSVJocWFBQ3d3azFSS1Yv?=
 =?utf-8?B?VVhFbVdPR1ZLN2xDWVpTMEo2ZFVqdlBqU29yYk1EVlFobUwwdkN5ODF4QXFo?=
 =?utf-8?B?TzllcE5UYVNnQ1NURXo4VnE0bzhQOTZGSXF2K2tJTzkxeFp3ckFPSnQrenZK?=
 =?utf-8?B?amRNU0s5c1JxTTN2aW5jYlZyU2hyMmhQRGF6OFltMGVIbmxhN21CQmpCTjRz?=
 =?utf-8?B?WHdYSHZlaDd0QmNlUlBBYVZGZkFIYmtudUlMV3NJUVpLcVZqMTZSOFpXMis1?=
 =?utf-8?B?SmxHaHhreXVqeXpPTXlQWER1THc2VmpRNHZKcHg2d2hxc1F5dWdjdE1pczNt?=
 =?utf-8?B?TnNodkxVbEdMZzBSZncvV3FISkNLdDJjWk1jeWhadWY3dkxnMjNaRWZjMWU3?=
 =?utf-8?B?RHc2c09GNEU5bW5acmNjWk9ZZ3lWajlGUHg0eDhoaUJzcVZvcU9Vb1ZyQ2M4?=
 =?utf-8?B?Ny8zYVNFV1ZUcHVuMnRRRjkraHRBREQwcENkOFhmSmIzUk9EcHZNbk1QNFov?=
 =?utf-8?B?S01HSnhNOEQ0OHpaOWg1TkFic2lUcWlsUnhOWjBIZEUyVHN5MjV4cldRRThX?=
 =?utf-8?B?bndZKzdYV2ExY0ljVXlYMlNadTdQQlJSTzBPZS9iamdDeG9uL2lqcTBxN05i?=
 =?utf-8?B?WGcxVncvSStKN0luZkpKYmxJbG9lTHlEL0I5eTU1Ky9SdzJaUlhPcVZ5b090?=
 =?utf-8?B?aVMzZXE0blhWWWFkZmx4dUJldE1PY2trSzh2dW51NHBNaWMvOW1meDVEblJz?=
 =?utf-8?B?OU1wNzZ0VzFuVllORk1yR1I3VUxrQXM3WFoxZWJnNVdiblcvbStDdHpmdldV?=
 =?utf-8?B?TERHVWhISWErbmxwSGMyZC8xL1RZSjBtTkZJazNnR3NOMkU3U21jcEhTMXFy?=
 =?utf-8?B?dDhxd0loUTBNUFl6TkNoZEsyNUZkTzlRSi9jZ2ZkbHVub1hsK0k5M1F6QzRj?=
 =?utf-8?B?U01PYTRXS3E4aW5nMmlkZ1B3TDlWQlBPbExDK0ZEVDlTekZPejltZnBoYXhm?=
 =?utf-8?B?R052RkJxMEN1czFwbk0vQmJYRlRVYjRGcVdvY2xBZ3FjSi92ei9LQ1VSTlNX?=
 =?utf-8?B?Q2VDWlpYV3Y5ays0OXZJcUMwSm4vSnUxZ0pacHJRYTYveHQ2eHRrN1BFZGgr?=
 =?utf-8?B?c2pkQmhoMS9oZnNsNjZhc095UzZIbk9PWkxtVlQzcFZ6cWNuRHdVK0RxVjd2?=
 =?utf-8?B?RnFKOFVFM2Y1S2tEN0lKVlhkcjk4endRRzhEbVFiNUhXYytFOFowMEFnQnN1?=
 =?utf-8?Q?/CHxpPeQ1cpNPiM+PaXVBiY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZW84ekg1cW9tYVBUWTNOZ0sxa1ZrUzJzWlNwNnNBSVczdlA4UnVCWCtkNEl4?=
 =?utf-8?B?SnRlSlNoRU4rbmJGZ081U1ZUUTVKMnFENG0rbVJGbWM3dUN6aitEQnNGeWxj?=
 =?utf-8?B?UkZROEpjUHR6cTRvWWhQT3hZdkZKTDZ6WXZFd0xjS2ZnMXZ6bUduVUttTFBU?=
 =?utf-8?B?akMyQTNJRmtTWVZsQzRqd2tpQzJEUjNUQmFXbml2cGJibnMwekJRaTdRSGlN?=
 =?utf-8?B?K2hBRC9xdFBHay90bTkwTnBYU1cyLzVXVFU2aDNDRjN2a1hkZnpUc0N4L0Iv?=
 =?utf-8?B?M1JSYmVGNjlXQ2RYU1hzWU5obzg5T0hYRjRBYW9CUTRZc25TbCtmcGRoVStt?=
 =?utf-8?B?dzF4Q0ViTm5kbmZpOUZDUGhVazYzUEVGcElHMlpDZE95dFpTOEZSdis4clRX?=
 =?utf-8?B?QTE4TXpZS3dMYTJLUHY2YkV5azdiMGxZbXVDU2NNT1BMbzJLZVYwTERqbEdE?=
 =?utf-8?B?OWFzWnpONzl2TXdDTlNuRWpvbmVIcWNsWmxLdEJ3S2JtdUhZZkdGMkFKVW1w?=
 =?utf-8?B?RHFOM1RXRURtcmJSOTN2aVBaOHAxUlJLR3NYRDRNZUZxY1J2UEZpK1M2Z0R0?=
 =?utf-8?B?STE5OEZoaEJEQzlMYk5hdWlMK2tNZ2VFSVN4ZkFMWkdrcEFzaithT09oRGMx?=
 =?utf-8?B?RjZOL0d0NjdoemZ4Tkl6SGVvL3lDQjFESi9FOG1DZFZITnEzbkxkblBUR2xk?=
 =?utf-8?B?OUZrUTZiTVJBY2l4NitSdk4yaWJOb1hneVl4RHdyU1BLaUVWa0FMbzczRlN2?=
 =?utf-8?B?THZ6WDhpQ25jMnR4Z3psZWp1NmM1R2c3SkN5QTFtOWxMZVMyeUZDTjRSU29w?=
 =?utf-8?B?VUlScHVmWmFDQnlBZnlpNGJIcHJ3Q1FyMDl4NytNUG1KK0RkdWFLY21IekFJ?=
 =?utf-8?B?TTNBTmVyV2FnYVNsTDJncE1sOG1vdnR1dSs5ckJ3VC9iYWJPRnFGK2RLWVc5?=
 =?utf-8?B?bUVkaDRaY2ZiWEZwNWpkVCtpMURZNTk4YVJGN2ZESG9vb1YwbHdRaDJZcFJm?=
 =?utf-8?B?TnM1TzJ0L3ZzUXJmZnIvMnRxSW5SSmhnYUtMQko3Ky95Kzh6Y1NXSU9aTUVq?=
 =?utf-8?B?L2YxWEYybzNMN2VFN2V3aTN4a2hCNFZzbUtzTGZnVDlEZGk3ZTF5MlpIVVNl?=
 =?utf-8?B?b1RMOC9HZHI2b2RhTXBiMGFyNHBCNVJyUDVMQ2pOZkowenpRVXNjRHpTRlRa?=
 =?utf-8?B?S3ZRVERLYkd1RGNiQlc0OXFjbWlwZGhqbXBvdDdPcEVPc0gvOWFPa1F3SXZs?=
 =?utf-8?B?U3Y5VXBkM2FERzN0ekdSUWdNNVRwUlovWnM3WlU1blFxWnVhbHU2Slo3MXM0?=
 =?utf-8?B?dm1qaFMwaWszNzU5REFabURkNHdRV0hoMVljRVJERWdocWh5OGRvamVTa2Zn?=
 =?utf-8?B?VG5XK0pwY3R5SERSMkNEcFJzQ29IRk5Wa3MwQURBVzdlaENSYUsyb1piTlBx?=
 =?utf-8?B?b1B6ckVFUmM0Wi9xV1hITlMyN1lDVDFxenIycWZzMlkwUUxPUzFLeXJ5VlpV?=
 =?utf-8?B?SE9pdFlKSWlwYWk2SU9BcFJzSExxaUhGMUx3OW5ZcGlTaFdWbmNnMTdhZ2s1?=
 =?utf-8?B?Skk4Snc1NzFwZS94b29iQWt1TE9PWEVhRVkrRS9nRnVXcjhYcFVJNGtPaml3?=
 =?utf-8?B?Z1gwTVZTSkRpVElkRGpHWjc0R0x2SGlLSmFGUkMya3V1elY0VlYxYlQyT3lZ?=
 =?utf-8?B?akpHWVh4WFRleTk2TTZCQ3NEQytLdE5zUWxQRitUVXpzcVdnRXhaNGtQOEdr?=
 =?utf-8?B?dmJnMStqZGUrZDZsNHFWd3l2ZDl5UTZQaGlPVnJLZHM0S3A0a2hwTFhQT3lZ?=
 =?utf-8?B?N0lrNTF5TjRWTGE0UGJzOWxTcFlYbE5RWW1OVWluZzBoZ1ptanNpUmVra09S?=
 =?utf-8?B?K0RPTm9PaTBsUkR0dHkwazQ5aEp1dm9xb1pGTWlCNlZnMlh6WTc2K1FhaVJM?=
 =?utf-8?B?K253SkFFUnJneDUvWkVBb2Z1elF3NnlxcmpUcHhKWHZHUFptOHVUV291U2Qw?=
 =?utf-8?B?M004dFAxYWx3cFY4bDZlTHUxLy9pZy9DT3hlTi9wSUNxQUQ5d0pCWkJZZmxt?=
 =?utf-8?B?WnBLME5EM2QrK2FMTTJxbS9QdEsrMXJENmFBUWczb2VoZllITzFiTitCVWlU?=
 =?utf-8?B?UWVZVUhKd2w1UkJtNVVFc1phVHptTWlZd2lVL0Foci9Ua0pmVGtVbGdRV3U4?=
 =?utf-8?B?RDJ3UFZXZ0hVQjNNMHpxRHJMbWw0emRzMytaYWt6em9lY3RRcndScWkyclZm?=
 =?utf-8?B?ZzM3VWdQN0JuaW1TdmJ2QTVnMVlaay9qUEY2TG15N0VEdm9FaHNVU0xCU0Vn?=
 =?utf-8?B?a1BZcjBCcllvTkhoSytKaFFMLzVYZWJ3M0NtMEtOZ01vYVJSWHJEeUEzWXZV?=
 =?utf-8?Q?cdXw5o4cIFFRtaeg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4af951c-26d3-4e75-cc43-08de6491390e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 08:33:22.2506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AnVRrMBZ2YZgPiFMWVwGHw7xK7k9bzHjIGG8YpNk/6HcOCMz0D3EhjR7jczzaBL97pLkmrEglECXQZCZQ46j5cSMLgVzOeei369EfhFLhhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4991
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31583-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,sipsolutions.net,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 807D0EFECC
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXRoYW4gTmVsc29uLU1v
b3JlIDxlbmVsc29ubW9vcmVAZ21haWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkg
NSwgMjAyNiA5OjE4IEFNDQo+IFRvOiBMb2t0aW9ub3YsIEFsZWtzYW5kciA8YWxla3NhbmRyLmxv
a3Rpb25vdkBpbnRlbC5jb20+DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC13
aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IEpvaGFubmVzDQo+IEJlcmcgPGpvaGFubmVzQHNpcHNv
bHV0aW9ucy5uZXQ+OyBzdGFibGVAdmdlci5rZXJuZWwub3JnOyBOZ3V5ZW4sDQo+IEFudGhvbnkg
TCA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBLaXRzemVsLCBQcnplbXlzbGF3DQo+IDxw
cnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPjsgQW5kcmV3IEx1bm4gPGFuZHJldytuZXRkZXZA
bHVubi5jaD47DQo+IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMg
RHVtYXpldA0KPiA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtl
cm5lbC5vcmc+OyBQYW9sbyBBYmVuaQ0KPiA8cGFiZW5pQHJlZGhhdC5jb20+OyBTdGFuaXNsYXYg
WWFrb3ZsZXYgPHN0YXMueWFrb3ZsZXZAZ21haWwuY29tPjsNCj4gQWxpY2UgTWljaGFlbCA8YWxp
Y2UubWljaGFlbEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHRdIG5l
dDogaW50ZWw6IGZpeCBQQ0kgZGV2aWNlIElEIGNvbmZsaWN0DQo+IGJldHdlZW4gaTQwZSBhbmQg
aXB3MjIwMA0KPiANCj4gSGksIEFsZXhhbmRyLA0KPiANCj4gT24gVGh1LCBGZWIgNSwgMjAyNiBh
dCAxMjoxM+KAr0FNIExva3Rpb25vdiwgQWxla3NhbmRyDQo+IDxhbGVrc2FuZHIubG9rdGlvbm92
QGludGVsLmNvbT4gd3JvdGU6DQo+ID4gQ29tbWl0IG1lc3NhZ2UgY291bGQgYmUgbW9yZSBkZXRh
aWxlZC4NCj4gPiAtIFdoeSB0aGUgUENJIElEIGlzIGJlaW5nIHJldXNlZCAoaWYga25vd24pIElz
IHRoaXMgYWN0dWFsbHkgYSByZXVzZQ0KPiBhZnRlciBFT0wsIG9yIGlzIHRoZXJlIGEgbWlzdW5k
ZXJzdGFuZGluZz8gVGhlIGNvbW1pdCBtZXNzYWdlIGhhbmQtDQo+IHdhdmVzIHRoaXMgY3JpdGlj
YWwgZGV0YWlsLg0KPiA+IC0gV2hldGhlciB0aGlzIGlzIGRvY3VtZW50ZWQgaW4gaGFyZHdhcmUg
ZGF0YXNoZWV0cw0KPiA+IC0gSWYgdGhlcmUgYXJlIGJ1ZyByZXBvcnRzIG9mIHRoZSBjb25mbGlj
dCBpbiB0aGUgd2lsZA0KPiBJIGRvbid0IGtub3cgYW55IG9mIHRoaXMgaW5mb3JtYXRpb24uIEkg
Zm91bmQgdGhpcyBjb25mbGljdCB2aWEgYQ0KPiBzY3JpcHQgSSB3YXMgbW90aXZhdGVkIHRvIHdy
aXRlIGJ5IG5vdGljaW5nIGFuIElEIGNvbmZsaWN0IGJldHdlZW4NCj4gcjgxNjkgYW5kIDgxMzl0
b28uDQo+IA0KPiA+IElmIGl0J3MgcXVpdGUgY3JpdGljYWwgZml4IHdoeSBub3QgdG8gc2VuZCBp
dCB0byBbUEFUQ0ggbmV0XSA/DQo+IEkgdXNlZCB0aGF0IHByZWZpeCBiZWNhdXNlIHRoZSBwYXRj
aCBpcyBhZ2FpbnN0IG5ldC1uZXh0LiBJdCB3aWxsIG1ha2UNCj4gaXQgaW50byBzdGFibGUgdmVy
c2lvbnMgcmVnYXJkbGVzcy4NCj4gDQo+IEV0aGFuDQoNCkkgdGhvdWdodCAnZml4JyBwYXRjaGVz
IG11c3QgZ28gdG8gbmV0IGZpcnN0LCBpc24ndCBpdD8gDQo=

