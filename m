Return-Path: <linux-wireless+bounces-33162-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPhqI6sss2ksSwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33162-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:14:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB32279D23
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C85F730AB842
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 21:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D513B2FF6;
	Thu, 12 Mar 2026 21:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1XFfflD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFCA3B7B7E
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349877; cv=fail; b=elhixLRPfLsrfedMY71P+nz4970YFx/isdsE7I92ZDi81yre7XhQrHFZps1srDvndFoSPkmM3dI67aMsjcSBZOQ+a+YvKrBZC+C8CGiNXIDlvf4kEdjzZut0tVElZLxXl1o2JoF8f6L7UoXJ7WluMGxD+6XxUYbkQOfHnk75zs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349877; c=relaxed/simple;
	bh=0gCR1YFV5AerwHoph7H3Z8UO5aK76nZp/3Mr8jpTd4A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dLl9pZ4MEcRYcu4NZqEvIxY/0g+h89GWZes8VLR2cVqHUzDPaqR6YCp20EZ8yokld60G+/2yIJmOn3do0YNefJOgS9Eo4mHkCKFDgh+e0fWS1un5REGE9NUEyUayxVBFAuF/e4FA+BXw6yXmwoS3Jl1jxgWz4ff4JZWm0JLyO7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1XFfflD; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773349867; x=1804885867;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=0gCR1YFV5AerwHoph7H3Z8UO5aK76nZp/3Mr8jpTd4A=;
  b=J1XFfflDJlL7UyV+Xh/DRfwxxuomV1+JD+yfTrmjFsm72OrXlminKl8P
   YklSz2QdpqYyWuvS8YSJ+hMGVDJjXN3CjWoMSoSDd+qdpvho1fwS58/Tq
   AinNC8B0tf9BYXsSbLIcDkXORk9EwMIDyI20kMDTWJs0bB3Ntf8fsOrn5
   tT4Zdk8cC0D/DOnYEs4knxlDg5BUWLl3Mb/Ntrvb7ES4Z0PXcS2XQQF9G
   nRbb0N/xO5/ohSWUz0aACXGRKiPvdSqpDR6dQZNix8st/Z9p7CGIAtef1
   mOT68g68+/dwul0kt3i7/eQ+xZjSXxKLrrsVyZ5bm0V+0/JAtSxl4pnIi
   A==;
X-CSE-ConnectionGUID: 3A49rHggRFySSDIFkczS1Q==
X-CSE-MsgGUID: CtS4cppaQ2OXtb5bq7Tvqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="78060891"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="78060891"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 14:11:06 -0700
X-CSE-ConnectionGUID: 2qYel/srSgiq2zZLVxkylA==
X-CSE-MsgGUID: NZps/C23TBeZAPxXLlKArg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="243991774"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 14:11:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 14:11:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 14:11:05 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.24) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 14:11:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzySwKY6znr0bgh9HwF8pd9c6ZOSDsn6k3Q525mWT6Aqdte0Swbd6cxCq7UyeS91S1KfczXRGF5rIYArV2ESxFfB2MYLiMgx+xibLtDnF/74SW2CJoreAUm4iggliNmP+9/CJTlZ/fAS7HQOg9i4AMjySv+SSTdOKzKWLy0aYS9FX0VwxMu93lRqpkbWMmZK83mYoMVmTAAWMUzlRGJJj2lL8H9zXAFi2WiqBEKJ7QpsySc780OdQ5fl67Yd3VnPXfpTjaO1vZKPWNLideMezYRPbaNV4DTgeSaUocq9udAjfGMgCadsyM/hQeMkx18VQPetcuk5FdCo/9KGWQ1tpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpQBuphyU8DUrRlcgCgZVHHp7OHd7s9k8B2CsSbYIuw=;
 b=G2QcldZ6bv4QhUWpdP9cmiqCOuErJKlGEQ50IhzUvScIfTjwC8IG3XOe3CYNEROh5ErFgXz6gX5PngjtbHYQNicCPpgFcbUAJDV2mssTyNAuI+q4LaSyIe+6bnOCry8Z/WPqCUr1SHWc+AesvPjX+37HxPMhKdmRDfnV3aOev5/UF2siuB8eMlqzkNg7zp2E9IR+FqIz+tLHzLzFfxWun5ZKPe9brnG5kvEP/7LBUUI0JCoGBkoTMGHmJ8rYicdhk0639UGcIsGzJwaTY0ibUJ+ZjFmfes+O+sJ3LL0fd8zyiMHzWCBZ+WqANy5Z2DAUiTl/keun51umgRkR0YvuOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by DM3PPFB0F355549.namprd11.prod.outlook.com (2603:10b6:f:fc00::f45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 21:11:03 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 21:11:03 +0000
From: "Stern, Avraham" <avraham.stern@intel.com>
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kavita.kavita@oss.qualcomm.com" <kavita.kavita@oss.qualcomm.com>
Subject: RE: [PATCH wireless-next v3 07/15] wifi: cfg80211: add continuous
 ranging and PD request support
Thread-Topic: [PATCH wireless-next v3 07/15] wifi: cfg80211: add continuous
 ranging and PD request support
Thread-Index: AQHcr8tfRZIRRntayUiahLIrg42pN7WraVgQ
Date: Thu, 12 Mar 2026 21:11:03 +0000
Message-ID: <CH3PR11MB8383BA2E902BF1359F4E050BFF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
 <20260305160712.1263829-8-peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <20260305160712.1263829-8-peddolla.reddy@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|DM3PPFB0F355549:EE_
x-ms-office365-filtering-correlation-id: f53bdb52-eb56-4dbe-a716-08de807bde57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: ocsHxZsFn2e55ntx3VF03K1vtpr4E27NiKnkiLU5e5GrECkWIiOkHP2tiF0syhR6htz42Y4xpjlUx9lxBvRm4QC76/x4q2+Ox81p1SW+3TlSTEYYQw7otYVRiOfeXtkw1aTnUjaTHwBqLiAVO58iBOGdbn/uJ9P2TYXxNqw48c/WF3nj4Dq4dLEaNTDqhw5/TXqKG8w1U7WGe4R1Wb+hY3XnaseHWVKm+VMzQe6ap5UR+my2grZunMPMlOFcwXYgRYpLYbhadTmNTpZAn2ydeL2vaPmvNq51OQ8KVkg1M0KUR8FYXASiRYdcaDxR2azwQTf7s/r7/Y+uQDWDwuao9+poDL2pQpLVtMrVFMU73KVY5pQeFl1mALhmKZib8ZwCZsGybidN622AtkML3PkK716P19OspcDPiPaK8K5cDoulefWiBE+LCcNABtJQrNpSsAgV/9M0GfmfkereHBE+ZIwYPmhh26NuhZ/Yb8jwa2sRLb05fexwxMibBCwBsmYsz+mDh8UlmQAQ8bzMvekaGibi4Py3Y+5XbKjP/Oc9XkXVCpEjrPIcCo4EU8MQP+aXTe9vl5g3A6HM+NyEsB4z34WtO4tq+kCLjTLvsbo4Cvcqk/zqPP7v8ol1E9RynRAOQ1bdLaRxCmehHp+3m+ivpmSm2jcHFKNlFN6ZHkLmK/mVSZB//KjzP6k6vfI1g1VycXSj+J991DmltEM/LjWHI36c+pB8STta8ZWkLjOb1Xn7bXMWTITioIDnYTn1YgINCaVHTFNIG7KPJMALk09ky7h4lKDuWH7kYQNb7b6oUaI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A6VvTKQ5nQ3F7b1uKIQKZM82m3FRi/+aSNxTmtg0AqVgkBrMgBoODOBMZmN2?=
 =?us-ascii?Q?LAIfvq2H7zPyHNLkRcrPJx2HnNhAB9NysR2xBIe525EOsuy5AJyPxK55Tqtm?=
 =?us-ascii?Q?FrcnfSNC0icpFWMj/65ppAhvr21b571cGq28PsH9BAuvKYRBDI/5qqfmvLmL?=
 =?us-ascii?Q?L4Hy1IXVfOKVQ/jUO96x1axc5QIy0j9cqeIv6ZeNPKN11tRFCPxMlJgYGezB?=
 =?us-ascii?Q?bFQDeYkxVgrvkj3p2HfeQYaIkFLX9QmcHICM1cYK/076y45wrc8NtC61bsQ0?=
 =?us-ascii?Q?dZKv67Okkn9TDwrfmEHqf3Z4yUBeFAflG6F5f2ymYhCzHSGgIci4gqCH7TV7?=
 =?us-ascii?Q?TPoVE2DVJpy+yXF5zuDdE5sqQ/yVHvajaB7dZvL7Pu5D4x169aUoB+Ac7FC5?=
 =?us-ascii?Q?kTwfHNTmwc3OzT6hUMRiUNEwdIJoQw/TdtqstrFfySbX3FEiIS+2wp2IKIhU?=
 =?us-ascii?Q?is0E0ejY6PuC4ZXzyUZxSUmg3YaeeAv6jdu6zxL5Go8nf0MwnQBdfQ5LWj/u?=
 =?us-ascii?Q?I5nZinzjzGJFJxhHxRaJebLyhqc9jikiOPdM/5T9Psc4SaPlbYujZU42WPuF?=
 =?us-ascii?Q?gQlcddNGra9GbBQjgGcx72mNLVILj5m2GR9ZSh49PVfs0Jbax5+wnZGlt2VF?=
 =?us-ascii?Q?S/FMYrKQoBBJI1NaDu9e68DI0oWKA4IJB93/vz9RAX0HSiZaGaA8yArFmszz?=
 =?us-ascii?Q?c/7Ynv5OpSkhjsTNOyQxi7qAr0maNCe+il6XFQzCB9hOjSkebNFyISy2+7eS?=
 =?us-ascii?Q?S/MblmTmXaV/7gT5isJS6mHFnoKe5ZkM7jH/kJ0nOWFYWTZiRYL4r5eU84J5?=
 =?us-ascii?Q?R2i4uJt40iNh8oy8pin0OWBY3eVXfEZGbMKpRrvd4eobzJcSI2xRzdCiHoiE?=
 =?us-ascii?Q?mHFq8wQN1p/MmKelMZe74IGuuQOrBSXWsHJzW0TKw4/xbqGXTkFWgoQVzQAO?=
 =?us-ascii?Q?oSu5k6j4S/hvRz+qUomgNvtyceTyBx3Sgy9YC/7U+2Nk7kVKSzJDq+7OUAOG?=
 =?us-ascii?Q?ll/VFL9tp60Ek1UtBLnjS+SpxQCCX3Smuw1tAszyvjUgTzAymrH0Dm5uy9/R?=
 =?us-ascii?Q?VhoatWD6yo0I3DaXq2eTxsMnETWu6qV9KxdgVq+xcgEG6nAZrn7DYvXYYsLr?=
 =?us-ascii?Q?AFlV9wx+MP6V4PbyF8zY2wsVPL7rfuUOdSRYNzalnIUu2feWYoWhxckn8WpS?=
 =?us-ascii?Q?Qz8N4ATVVdBwYXFmgy/vX60uTlQBCrdOqTo8j+FfOvJ9tIiDZ90xmz+2kFAt?=
 =?us-ascii?Q?6NhveIr//cVoSqe2JeFn9HZuVqhwVVFTVpkULI/imN/I5M1xmRwCSAoCMLi/?=
 =?us-ascii?Q?bO3OU6Ts0vOpSmHi9XNX6DUYU4bDXLQ4ZOqwolgWw0qSc4V9g23bAOW0zpD4?=
 =?us-ascii?Q?Jrnoh3cl7sa+70dUTtu9DKts5ut7sivN1VnPjHXPFVE77UDumuPKxpvRTW43?=
 =?us-ascii?Q?sRffPrkMLhEZnDphBU+BiXA88CA6R4fLv4fFZCoftmW/UityHwgjuSlYSyXX?=
 =?us-ascii?Q?tc7bs/kZbpiGmDrvxa/aHDN1MikVKVtPFtfQuxA7SVqLq1gN2Z2l7k/hXyN0?=
 =?us-ascii?Q?Ipf7S9LNjQp7dPe9hvye3R7am8DQPF6L/gyrSEBMgqVqwa5/HR6fy4RPrCOA?=
 =?us-ascii?Q?35ZiyamBzvxzFyst393uoaqVP0ok/2Z2dakYYumGOkrTKmcQEDEPmalCDL8E?=
 =?us-ascii?Q?Nlxz95Hk2g3xU6+mc0Om+9HZlLf5FxjNMng2g8nXWKRTbXtbA8dYrtSBvflw?=
 =?us-ascii?Q?rpMr7YfNEslxHQjWouhv9NwXk0a/XGYPLwAexrvOmATigwI2UE3kYs4I+m1V?=
x-ms-exchange-antispam-messagedata-1: n+CCYrp0soscdQ==
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hTvWfsRtLU5aOgGtkgptxrqPWjHyTgXhkSc0bJ3BibuDHbENs49GSpYAdjdVwQL5KME6YfmLYT0X+rkyQyn17bkfxu9JUkYPOhfiDMHM7kztSEOpjVVBh1NhIcxDx0PbJDZh19MzEHOJhfPNDx6Xb4FmFQ8DTPaFrbFj59yQ74lStpVUwSkijBjcAhUVsHPaDtxQjSJBCasm1o12GZxT419ovSTvmfQgjLlq5roKP2S5z/oWk+Ii3TZxSg2XAbSjPWs3wLljl47QHDFiQBqpK5y6KhLlSRvARK/yDGgiSxykTvaj5HbJdmjQqRn1LOGtsNFddUW0UMbTfSWHWOaRcg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f53bdb52-eb56-4dbe-a716-08de807bde57
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 21:11:03.2584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x93JowZmDSKGvVLTqTJg6kJyNjamUV7NeObtQzNYxCaU9lkUYb/n55WU4rP3WSWyYH2CUPPrIa4wHWCxN6j0ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFB0F355549
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-33162-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avraham.stern@intel.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: EBB32279D23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
> Sent: Thursday, March 5, 2026 6:07 PM
> To: johannes@sipsolutions.net
> Cc: linux-wireless@vger.kernel.org; kavita.kavita@oss.qualcomm.com
> Subject: [PATCH wireless-next v3 07/15] wifi: cfg80211: add continuous ra=
nging and PD request support

> Proximity detection (PD) applications require sustained measurement sessi=
ons without repeated FTM negotiation overhead. Currently, each ranging sess=
ion requires separate negotiation.

There are already NL80211_PMSR_FTM_REQ_ATTR_BURST_PERIOD, NL80211_PMSR_FTM_=
REQ_ATTR_BURST_DURATION and NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST, which=
 are practically the same as nominal_time, availability_window and measurem=
ents_per_aw, respectively. These are used for pd_request with EDCA.
Maybe these can be reused for pd_request with NTB as well (with clarifying =
the usage in their description?)


> + * @min_time_between_measurements: minimum time between two consecutive =
range
> + *	measurements in units of 100 micro seconds, applicable for
> + *	non trigger based ranging. Only valid if @non_trigger_based is set.
> + * @max_time_between_measurements: maximum time between two consecutive =
range
> + *	measurements in units of 10 milli seconds, to avoid FTM negotiation
> + *	applicable for non trigger based ranging. Only valid
> + *	if @non_trigger_based is set.

The user doesn't need to control these. Only the periodicity parameters bel=
ow.

> + * @availability_window: duration of the availability window (AW) in uni=
ts of
> + *	1 millisecond (0-255 ms). Only valid if @non_trigger_based is set.
> + * @nominal_time: Nominal duration between adjacent availability windows
> + *	in units of milli seconds. Only valid if @non_trigger_based is set.
> + * @measurements_per_aw: number of measurement attempts per availability=
 window
> + *	with a maximum value of 4. Only valid if @non_trigger_based is set.

All these should be valid only if repeated periodic measurements are reques=
ted. But there is no indication for that...
Need to add number_of_measurements (similar to NL80211_PMSR_FTM_REQ_ATTR_NU=
M_BURSTS_EXP) to indicate how many repetitions are requested.

> +	u32 availability_window;

u8 will keep the 255 limit.

> +	u32 measurements_per_aw;

u8 is enough for a maximum of 4.
 =

> +	   pd_request:1;
>  	struct cfg80211_pmsr_ftm_request_peer ftm;  };

Should be part of the ftm data. Not really needed. The device only cares if=
 multi repetitions are requested.
 =


> +	if (!out->ftm.trigger_based && !out->ftm.non_trigger_based &&
> +	    capa->ftm.max_ftms_per_burst &&
> +	    (out->ftm.ftms_per_burst > capa->ftm.max_ftms_per_burst ||
> +	     out->ftm.ftms_per_burst =3D=3D 0)) {
> +		NL_SET_ERR_MSG_ATTR(info->extack,
> +				    tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST],
> +				    "FTM: FTMs per burst must be set lower than the device limit but=
 non-zero");
> +		return -EINVAL;

If ftms_per_burst is not applicable for trigger_based and non_trigger_based=
, they must not be set together, not ignored.


> +	if (out->pd_request && out->ftm.non_trigger_based && !out->ftm.rsta &&
> +	    out->ftm.measurements_per_aw =3D=3D 0) {
> +		NL_SET_ERR_MSG_ATTR(info->extack,
> +				    ftmreq,
> +				    "FTM: Invalid parameters:measurements per avail window is zero f=
or NTB PD request");
> +		return -EINVAL;

measurement_per_aw is required for rsta as well.



---------------------------------------------------------------------
A member of the Intel Corporation group of companies

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


