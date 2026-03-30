Return-Path: <linux-wireless+bounces-34144-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF7EJIXvyWnl3QUAu9opvQ
	(envelope-from <linux-wireless+bounces-34144-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 05:35:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB693550B8
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 05:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0881D30068F0
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 03:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0130F37CD28;
	Mon, 30 Mar 2026 03:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahA4SexW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3E028C87C;
	Mon, 30 Mar 2026 03:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774841730; cv=fail; b=ivgYi3ekpQLOOPW+TR24KYxVO/qYA3jDlZMsOYZOIDvsxwuZLxMC7YIZg7Sp/q2/M8iQQ3Kzvje9aGkrlLAdFeZVKegYfgpT7Txh56enQb7zMaP+Vs5DmllfJeli72w5cu5a8Vubnr+Ub0zdW2fFGVbkYxihw77NcgEbwDAXxCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774841730; c=relaxed/simple;
	bh=tYpa/EVSw4mKhNfKk46hXvfkKAMFttLH2ENUPALB3Q8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SgSxMZcOtll7kMUbnjfEPdeBcYV6p4u1QwvjwSV2RBxAv3DPYxfvrYh93xIqRPYBxiwuCNoTSxg4EM9n1Y9tPfznouaxbnkrxaYYF2tTXG+mSFCDzaUzBPvhrVZV4FPrs5bxbd1B2AnVrvXN9xdzl8gs5lPDPNSl4aLngwP32/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahA4SexW; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774841729; x=1806377729;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tYpa/EVSw4mKhNfKk46hXvfkKAMFttLH2ENUPALB3Q8=;
  b=ahA4SexWEhUY4vxrW2XHhAej+GsHM6pC1650m6bCndglzY3ogpgx7Aic
   sEl3t86GN+SYjCSQ2E3AhQ00PqwhxP1zJVXvgDn/hTEc2ynm66Z7WJBPb
   7vZ2snpN3pfqwabL7arrZALryYurz+7b27Z/1Y4Mwy1cQIkbWBS1KijoX
   JbqdS0vxs8oGQtV7+W6LVkB2wQY5cPiZQIUYJ6wO5gQwR515pzzt3DnWP
   k64k0jmqy4hm3wXJ37bWbtRSy55oPk4gDm9y6FaWIlNEOd2+ex4qe31qs
   Nt5pGYYh0RRtBzEihkllcDBHWI7KB0JSg4tXa9CDLpIlU26vsGPvjnKyB
   w==;
X-CSE-ConnectionGUID: VyYw9flsT560kqfIlTwlRw==
X-CSE-MsgGUID: CPKh7B3PS++Y+g7h3Z8vRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75712931"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="75712931"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 20:35:29 -0700
X-CSE-ConnectionGUID: 1LkrHQIMT82kavwLhSsSig==
X-CSE-MsgGUID: 6GEAXvJPTmKj/sN0nBJ7Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="263859490"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 20:35:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 20:35:27 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 20:35:27 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 20:35:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njCkS6NnwOYhm4SsI2o2tkrnr0Br+g5j7NSZmWgQd7/iSakOI29N9319Iwy/cyUSMQ/kfPNk/5chsCytfPfOJNAxhpe80Z915A0Mhrm+Pv9BRZ0bsJ6PhLYuiYOw95XlG0DUEuXV6j/KnvIVSZBQzvfSBUlSXk/ADjST7vshCFwLOwlAFyLk9ECj97RtHLGUxkzoktgJ7mvDK93F2tH3Aq5BLrWRohDOJa6Kws3z/ihQ7SZMcwM8TF5FkbvoThRdRtae5WcH78/zrDar3bMroVI0Fb/EP37wCi4dqpTJldnmsIZKqelZkukHKKs7sFBml5cS1oNY8CC9iKKjYPhMZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYpa/EVSw4mKhNfKk46hXvfkKAMFttLH2ENUPALB3Q8=;
 b=GNyXVmw8k81TIm/w3klkU2vT7I8mGbbGRI+3Z0dfXahCkT9tlgZ0ohcYJmZAr2BpbSRvhny3/qugvdinh7t6y/HWHWxEO3GFKRwAseZFTMqoIHljN12UC3pLWr5KFZizC14F1RBqMtiHIREBhErQzevA8AwDxRTOrdBqDn5J3xoxuMrVjDZiwHbplx4Vt4VxEj5q1PeHXUnadiBxZMz3NqBTNfT4j0RjUS5tDsdLPDeGP3fINwaBKMHP7Jdiqb9hsLnP3mIeILCHlHO47jkKjTe8OP62HlHvmP02k8R3fqeu5NXZQk/VVDqE/6kU12HqSdLQXDkYRXN+yJRXzUD+iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by IA3PR11MB9304.namprd11.prod.outlook.com
 (2603:10b6:208:57d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 30 Mar
 2026 03:35:25 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d%3]) with mapi id 15.20.9700.013; Mon, 30 Mar 2026
 03:35:25 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, "Berg, Johannes"
	<johannes.berg@intel.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iwlwifi: dvm: add missing cleaup for on error path
Thread-Topic: [PATCH] iwlwifi: dvm: add missing cleaup for on error path
Thread-Index: AQHcv+RDIM63gDVhYkubynLwzb6VjrXGa+1g
Date: Mon, 30 Mar 2026 03:35:25 +0000
Message-ID: <DM3PPF63A6024A9D5E8CDD616EA26F3BAABA352A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20260330012620.2715796-1-lihaoxiang@isrc.iscas.ac.cn>
In-Reply-To: <20260330012620.2715796-1-lihaoxiang@isrc.iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|IA3PR11MB9304:EE_
x-ms-office365-filtering-correlation-id: 8fa6bee9-33cc-4733-6a03-08de8e0d6146
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: cEoVaUFBQLdZIkdYUCkw6bM+uVaE0JHDBkHGSlplgpMWG50Vnj7MWv0t6N0aWyzwDSICmBUaIO5uuxqVTkLKwOiUZp0sjUWYgNi7Nb5Uh5ykWaLpJMuV/IDksW9OWH15D98aack5OqR1AIWwzhFS1myyLrD7wXJvXwVuWR2+6GY3nodBlma/I8vCFOfsChCJIfB67NE6/82JjFWFdE/q/05J75TqT6Gn5ofOec0I1dBCscTpWN0EYXtxa8z95lHB1g4kGdCV4TQu3iF5xw2BLVSz4s+IQgspxKpe1RP8P5wP0/nnly1hvx8qzWWJzSqmrb6IKX8/RduwX+WEqbyfRAHwIfVH7JR4fpk3nd5+63app5Eq7rWxUDqeDy7mEsmPb7P8tnP3z/4fy+3R/GNn13FgzQJUsb+ckzo7IDBzsKVxDkc9mdwZTxMNj0Ol72Y/ChrOXfjdki1UV+J/eBwgSKM/h7o/JC2Kfvz7FQa1zNmUqUJk8XPy9QscsVY0+NXwyO22DVHq3e6fht3Z6VSShwy2qoXwLQTgnkPuUWVVBJ/ZrJb6FHxNeg1LtTlpb8zaTDUUSshaBitDuf1MRV0b6YGu6jUgR/wU3KUM9hr4xMz9HzhElvpMBPJlQoXSTGJM9cXSsatjaebK0cL+7KCDJ69LB9fhmk3b6Tz1H3KClaavfx2uTWv7P08VjtEmC3eAu604BrRJNijaoZ06CfEyzZeO+Fo1GZlxjLvKqEdCr85/b07Db/g7xSwznwUki/yWxB5AJlQ9al95XDnGPng5JvVJzD4sZY0jc64tOHGll98=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWZnYk5vaXlNeVVDL1VlN3Fwem45UEYrSXRnM210OUdpSDFYclhrNXQ2S25i?=
 =?utf-8?B?anVJQjdkb0tPMTVONmpRNjZLNnphR09Pd1BHOXJiZEJkald0NlFjNWc2R1Jv?=
 =?utf-8?B?TVI4eHpyMzNNd3BqNWNJRG82L0JMNEcyMGxTdG9RNnorb3J1U3gwcTJTZXp0?=
 =?utf-8?B?dFZveDVXQU1jeWt2VGxUamo3UGl0V1JQREtQVUpxQkxrQ0oyRFFEdCtWK3VE?=
 =?utf-8?B?aCtkT3NVdjRST29JR2ZDOS9VcXdKSE10NmhPTURqLzExMFN0WE85WFY0dTYx?=
 =?utf-8?B?MmsxVVZ1Mi85RGdhM1FJMEV3OXhPdWJ0NmZoTi8wb2ZZTlE3VGFTSSs4UVFJ?=
 =?utf-8?B?ZVdkV3hXU0dnd1ViMC9NRENnVHFXUEpJWWVVY1dxekdGRjJYUG8wdWt5S1ZE?=
 =?utf-8?B?bEZ0ZEJQZ3NneVZsQUcxOEdzTjFISnYybE5oRkxlSVhkMTVYMWdaVWE5STNn?=
 =?utf-8?B?UEZ0Z1YwaEFzTW9GdUkwWTN3YjE2bGJKNUlySHNaclUzbmxJOS9idWlya3Bs?=
 =?utf-8?B?VG5wOCtVdHgyb1V3Y1liZy9nLy9jamU5bkh4b204KzBrZXlOb3ZXM1AyUGsv?=
 =?utf-8?B?ZXR0LzJUVStCaXpoRUt3Y2QwVkxyZklxZE55ZkRDbFNKNHMyMFpMUWZVanZZ?=
 =?utf-8?B?UU5jVy9UTWF0MDNJOVpMeitac1R5YVhrOHN5L05YWmgwZXBkV2RIZWluVDU5?=
 =?utf-8?B?S1BwS3pEMmlpZEc3bTdrNTFjNXZSeUtXRVRBZTZBeGlFZ25KR2dzZVBCeDJx?=
 =?utf-8?B?T2JPZFplZFRWc1FOVGlVWm9GQlRrcWEwRjhoMU1NNjVENDA3bDZ0ZTNKUXF2?=
 =?utf-8?B?Tk5aZlhFRWNybnBPbzNsNll2MDgwVzJZWUd0bWZ6TGlGaFJTOFZwY3lNcEFa?=
 =?utf-8?B?SVV3QVBJME5oSnVadmRhZ29wN090RE1LWXhjdnVwL0RFdm5IN0RObk9WUG5j?=
 =?utf-8?B?NWVOSjU0M2hnZ1J6T0dJK0I0anNxSElVSlo3ZVVxcjdTOXV3YUg3NldMMXJ5?=
 =?utf-8?B?U21sWGpGall3UUVWaGRaRWF2aG1jWTdQcitob28rUHV6OUp0bWQ4RkxUTmZL?=
 =?utf-8?B?UUQ0Qk03R2ZuaEszdnVPUUlleFh4TFM4QTg3NjhaNit1cVJ1dDhuSVlhV29I?=
 =?utf-8?B?cUpEYXhXWGVMV2luUzVxT0JEKzA5WkduMFBpcGF5cWNuUUxHYnh6ODBYQzNV?=
 =?utf-8?B?WHlsWnAwK21lQloyMm56QmREb2szY1h5MlY0TUlOdWRvYjRsRkdPYWZidmM0?=
 =?utf-8?B?ZTZtQVN1TnpRb3pNT2lHbnZ6ZFZTaElBUVZ6aVFkODdmOTBVa290b0xKWVlC?=
 =?utf-8?B?VFJMd01CQXBldlF6RHI5MEx0a2pJemlXN1QzS3ozNmdXdVU1NnBzYVJPaldu?=
 =?utf-8?B?b2ZrQlYzNm14a1NYOEN1Uk4yNG5iS2VsM29idUwrOXdoRjhnamFUMDZKbGlq?=
 =?utf-8?B?Q1dISjVaVHlQdm5PTEdybEZxbDg3NW81MnFKQmZicktWRFNQRFZCSFduVVZG?=
 =?utf-8?B?V2kyRzdSbWxVZmxzLy9ES09YR2hyUDNUNXNET1hQV1RaV2ZsS0xNTXRFMDBq?=
 =?utf-8?B?K2ZxeUJLM3JMdTdYcjhrSzFYam5Od0Q1Nm55SDJFaFhjM1FXcERqMUdpUmEw?=
 =?utf-8?B?WEhacFhVQXN4MmVtYlo1bklvdHI2U1NPdEFRaXB2VllONGd1eGNjWXROcnkv?=
 =?utf-8?B?Uk9zYTNTMUFnN1o1OHIwMjEyR2tkNnRUTkZVa2JydDBxMG8wS29Sb2tHSlBZ?=
 =?utf-8?B?K25nYjBYbFN3K2JTT2hkRGVodVJ2Mk1yNzM3UCszUVJqN0ppNzZIbldtYUlk?=
 =?utf-8?B?Umo1L0FqV1BYSVdXOUlwNFBMUXJNdkVTcG9nSGo1NTdtczJFYVBzc2VhbEdm?=
 =?utf-8?B?dHN0U01Ya2M0cmVwR0JlN2tqcGhvYTR3ZDJYQ3FDbVV4Yy9tWXdtL2Z2T200?=
 =?utf-8?B?SFNuVU92RDlQcFBqQVZtRUJuQ25zZXZlbm1kZ2xpWWQ2RWdUdHBnVVhRMTR2?=
 =?utf-8?B?ZElVbG1EZklZc29ZdFFZYjVMQndKWUdkZXRzUTVyQy9PSWZYRkd2dGFZQlBU?=
 =?utf-8?B?U1dCdEd2ZzFVQllRT05ibnZUWjBsUHZpc2d6UmtYRFZyRmpwRFFzRU02bzQz?=
 =?utf-8?B?SHpvN1h2S0g4K3pTOTdJZWVNVDdDa3JFK0cvUWZ5dGozR2VZNWVWSGVhSVhq?=
 =?utf-8?B?OC8zVmtmeWFFdVBDcS9DVVdxMkZqcHJKNGYzMXFHOCtJYVZVYURNWXIxSXFO?=
 =?utf-8?B?dEJydmxIRStuVytKVlF0WkpieGtSczdMU2kxOUF0WEpoNURjTmd5enRJTjFs?=
 =?utf-8?B?aXpKVDJDeVhRT0dlYWFZbTIvY2FlQXg3VlFVaFBRcXBRS0JFcUQ0amtJQk4w?=
 =?utf-8?Q?GCJ1wEImEg0wI0Yk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mgOry9DDANXLZhKfQdRVvD9eBPx1as/4EqBf6SrzGmbr1GOwYowAL75ympYkkREXUrIlIrXitkDgggCIIM5KVlKIN5gEp0STzUDFkaeTfSA3kubUYgTsC49uh2SkA7NEYIX4AR6jClZTyYggusMV3CVPic8ivJ0RUieWpjkljtqXFw1vybc3Zz7+GNzzlO9uAF4ehu1EdRPE+x2qFycp8gdIPH1RivNiGfBVRTvBpaOZjzi76Ueb7ecBfrBwAQ9gQX7P5HfizwSeIRJTGEYKH3q+QtOy30tJdmrd94wgxv8YC0uKBGlyNNtMH/GCsPoWikYX74ESEW8s882dq8mnEA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa6bee9-33cc-4733-6a03-08de8e0d6146
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 03:35:25.0318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TqtCUzKfM8qZGpVfymmGzSJGBm9ZcjfB3SvGCAhMiPrdXqCrhaG208TtaHzAM7+yhFcqXWCG15AYdus6P5+Dq6VY/qvkveEn3yb96pPJjm0PpiMbCIBopf459jhVwhyc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9304
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34144-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iscas.ac.cn:email,DM3PPF63A6024A9.namprd11.prod.outlook.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 0CB693550B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGFveGlhbmcgTGkgPGxp
aGFveGlhbmdAaXNyYy5pc2Nhcy5hYy5jbj4NCj4gU2VudDogTW9uZGF5LCBNYXJjaCAzMCwgMjAy
NiA0OjI2IEFNDQo+IFRvOiBLb3JlbmJsaXQsIE1pcmlhbSBSYWNoZWwgPG1pcmlhbS5yYWNoZWwu
a29yZW5ibGl0QGludGVsLmNvbT47IEJlcmcsDQo+IEpvaGFubmVzIDxqb2hhbm5lcy5iZXJnQGlu
dGVsLmNvbT4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgSGFveGlhbmcgTGkNCj4gPGxpaGFveGlhbmdAaXNyYy5pc2Nh
cy5hYy5jbj4NCj4gU3ViamVjdDogW1BBVENIXSBpd2x3aWZpOiBkdm06IGFkZCBtaXNzaW5nIGNs
ZWF1cCBmb3Igb24gZXJyb3IgcGF0aA0KPiANCj4gSW4gaXdsYWduX3R4X2FnZ19zdGFydCgpLCBj
YWxsIGl3bGFnbl9kZWFsbG9jX2FnZ190eHEoKSB0byBjbGVhciBiaXQgb24gZXJyb3IgcGF0aHMu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIYW94aWFuZyBMaSA8bGloYW94aWFuZ0Bpc3JjLmlzY2Fz
LmFjLmNuPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZHZt
L3R4LmMgfCA1ICsrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwv
aXdsd2lmaS9kdm0vdHguYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
ZHZtL3R4LmMNCj4gaW5kZXggYTc4MDY3NzZhNTFlLi44MzU3YmNmMGQwNWUgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZHZtL3R4LmMNCj4gKysrIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9kdm0vdHguYw0KPiBAQCAtNjA0LDgg
KzYwNCwxMCBAQCBpbnQgaXdsYWduX3R4X2FnZ19zdGFydChzdHJ1Y3QgaXdsX3ByaXYgKnByaXYs
IHN0cnVjdA0KPiBpZWVlODAyMTFfdmlmICp2aWYsDQo+ICAJfQ0KPiANCj4gIAlyZXQgPSBpd2xf
c3RhX3R4X21vZGlmeV9lbmFibGVfdGlkKHByaXYsIHN0YV9pZCwgdGlkKTsNCj4gLQlpZiAocmV0
KQ0KPiArCWlmIChyZXQpIHsNCj4gKwkJaXdsYWduX2RlYWxsb2NfYWdnX3R4cShwcml2LCB0eHFf
aWQpOw0KPiAgCQlyZXR1cm4gcmV0Ow0KPiArCX0NCj4gDQo+ICAJc3Bpbl9sb2NrX2JoKCZwcml2
LT5zdGFfbG9jayk7DQo+ICAJdGlkX2RhdGEgPSAmcHJpdi0+dGlkX2RhdGFbc3RhX2lkXVt0aWRd
OyBAQCAtNjI0LDYgKzYyNiw3IEBAIGludA0KPiBpd2xhZ25fdHhfYWdnX3N0YXJ0KHN0cnVjdCBp
d2xfcHJpdiAqcHJpdiwgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwNCj4gIAkJCQkgICAgIm5l
eHRfcmVjbGFpbWVkID0gJWRcbiIsDQo+ICAJCQkJICAgIHRpZF9kYXRhLT5hZ2cuc3NuLA0KPiAg
CQkJCSAgICB0aWRfZGF0YS0+bmV4dF9yZWNsYWltZWQpOw0KPiArCQlpd2xhZ25fZGVhbGxvY19h
Z2dfdHhxKHByaXYsIHR4cV9pZCk7DQoNCkkgZG9uJ3QgdGhpbmsgdGhhdCB0aGlzIGlzIGFuIGVy
cm9yIGNhc2U/DQo+ICAJCXRpZF9kYXRhLT5hZ2cuc3RhdGUgPSBJV0xfRU1QVFlJTkdfSFdfUVVF
VUVfQUREQkE7DQo+ICAJfQ0KPiAgCXNwaW5fdW5sb2NrX2JoKCZwcml2LT5zdGFfbG9jayk7DQo+
IC0tDQo+IDIuMjUuMQ0KDQo=

