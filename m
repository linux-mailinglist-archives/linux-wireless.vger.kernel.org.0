Return-Path: <linux-wireless+bounces-33163-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHUXFQ0ts2ksSwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33163-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:15:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDFC279DA8
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41ED03004F4E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 21:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623A5386571;
	Thu, 12 Mar 2026 21:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4cqE5hL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6373815D7
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 21:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349987; cv=fail; b=g9sObCcdzR9+eAl84/AkgRTIFXUDDY8bEbYiiFVbnBsDFzW1tgwLy3Q39wKWmpYKq+93X2ZvULRA6P66B8dPlHKPOTlbGdJYBWHNMqOJsAvkvn6fqnh8B5pbHJW8jN8OdIi9bo/4VYSqEfgkur3S0cSrro53jrjgN+aPbPDP6V8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349987; c=relaxed/simple;
	bh=srxKcZR62FnK+g7DfF8mwqPb7evXqHnVCcYiwTvSdtc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l7hU4pPrbVcreuxVGn16cXo4DC5tM09aPp6DA/XiszaUc1YigPS4qpanqDg9UeAf6hjpfxSBzfmdPG4qSsSeN+ZM5G0HRkWLeTY2Y4Xwi99FH6S9JZiJRYjdgSqbVnZmBSWRndXAmwUgFTNcJwjRTuC5yk7EkDSX8/W/qo1XHEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4cqE5hL; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773349985; x=1804885985;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=srxKcZR62FnK+g7DfF8mwqPb7evXqHnVCcYiwTvSdtc=;
  b=Z4cqE5hLcTPAnPnoRF0zI5waAxsqiES97VxG3H/tQPZK69cbU+v/Tm3d
   7YIJirFu0dymHmBSSZqe4482OmD9yEOhzaEiiVlMGdUaNO1bSzgmZzYJx
   08NRG7tOdKIAcnQvHeQTTm/S84zSn5h8gBPoHBbXyo5sJgiiqEtThNLpp
   qm/ZzqqV1pL1xDPu5/yuaHq3bNx2AIiqCVJAQm04/9H/3qCp+omYDABEo
   4X/5BENPcqz9KXfwUmdtY90thWXkJ7LbGlQZGDVC4Fa1jR8KvYaNBuAtl
   TtGmSGrAwRmhXtm60qtRjBI8A66oQ20ozLSOs3+p8QntXZ00Clo97KU30
   A==;
X-CSE-ConnectionGUID: yrdapPtLRdaHMlcRgXO3uA==
X-CSE-MsgGUID: A/MDI58KSDigMNWVojmZkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="78061140"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="78061140"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 14:13:05 -0700
X-CSE-ConnectionGUID: /LH4c2ilR5CWlj7q43BgFw==
X-CSE-MsgGUID: XLfJmwOSR6eEECCBgt23WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="243992447"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 14:13:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 14:13:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 14:13:03 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 14:13:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwiIAqQ/mIqPP4v7gTN6Ub1KNmeJdHUMp21c4SmTGWylfBKvExmvPywYZtcZyRdLFX9AuoK0oivKF4qqG2quQ2LKf9eIz1yOEh+x0GqQY0BTJ29BhusOGSCUwS9PYwmL7Diif125FMn8sM3iLiiutDKcGdppkSOrPtg3QGo8z4uL+OxIWE8BPu6zsdlUKUkhpIcLokZKwTdZXjiEE9aekGHzUBVOqYRl/v0OxcpnbYGvgdZVgRx+T7+U6Fr6Mc/wtb7opvveUssAgKEd4uJfRI92v3fU7f0LJyzuaIWeFdmRfFnc2kaDmej3qzOMVinScJDhOkn60vgP8H4eqyqdgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtaRh2e9cO140Mviv0eiehCYhHOhvTSUezuCYgi5Q+4=;
 b=oJ+FuyZQ6iXTsE2GMJIOZnKr5akpenpLnxEICrq2h/3A9aoIlEMRxIGrcAYnTWTKhUxfkxWePECRewzdjo8gMjUuQkStmcgb42S9dEi8XUmHmpXGtI+ZgXl/LXW4dj20fXnzl9Pk0YVhUp35OvzaExjfK4vvlXqEAlKA7RlKvuzP3aQZl1jSI0PCtQpnoKyvCFBFjzT/nF3pJ/NZe/MtqMxklzIOTyxfKABmXgxBM2sRDm10TIjAlI0RoPU5//jblV4TPXd1syYohSBFlPMrdz0qGP70/6xJyxavcuPDN337yXBrEDAv952Z/O+OOWa4piwt9U6GNKAGZBt3HWgDYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by DM4PR11MB6239.namprd11.prod.outlook.com (2603:10b6:8:a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 21:13:00 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 21:13:00 +0000
From: "Stern, Avraham" <avraham.stern@intel.com>
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kavita.kavita@oss.qualcomm.com" <kavita.kavita@oss.qualcomm.com>
Subject: RE: [PATCH wireless-next v3 08/15] wifi: cfg80211: extend PMSR FTM
 response for proximity ranging
Thread-Topic: [PATCH wireless-next v3 08/15] wifi: cfg80211: extend PMSR FTM
 response for proximity ranging
Thread-Index: AQHcr8tfphSBTL1WmEOEVgAJ34m5HrWrafRA
Date: Thu, 12 Mar 2026 21:13:00 +0000
Message-ID: <CH3PR11MB8383FD2F0D5E53C7F718B2BCFF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
 <20260305160712.1263829-9-peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <20260305160712.1263829-9-peddolla.reddy@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|DM4PR11MB6239:EE_
x-ms-office365-filtering-correlation-id: 2d948c9a-70f9-4edd-eeb0-08de807c2426
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: zN7UvABCvRroiJ+VDT/bIyvKk8YXBEVt0wO5aRWrEO0thAdOI7PXFsuwJyMkls7nKJRqsUwG5gYTvoeZlsJwmh7aHdFxVufpMR6hoInZrqIwg6mggeh2PRrrXJeoZDhtDPL8lmPxccHpyHkSsRFq6BKld+92DduQ8Mr72P48QV7vDE//kf1YQ//qEdb58dftVgv8aReUJT73WfK/jUK78PoL3x7QtBUxpmozRmrA3CJ0pZ8Az0Yt7wkXAzJq1/t4TagvfxpA3HeCHy+3XDgabpH/D29L+fYHQa4hHaAZfQ9RNuqbiU2z2Quq6IwochOmlvEAO+b2h8ArmYIpSjddAwbLOuHvMT6z13tc99JJF5OW3AE5QJhcYd9xr/tSw4BFUAxsz6J4pWHJJg9uMH2u1wlSqxqZ8cdh2NHbgNLRy3clsY3vffSPgaReuF3gT2VK0TaeDMG2vUvB/6XJcHrwYcUz68t0ot2APldvmlD+/T0c0wl5tm3c2QJ9baSjaAgvu8hlvYeThXGBcoKxfTlAzA2kDhPLBgQ5B0gkVTBa3xbcmhMg6zZLazqee/xI4wpZvX+/kqoiIsKR305Ahdfh7fjnrpIi5h9dAaPYJ21ZM8wKAsuwROLIb8zTl32GKg1UvBfp3/szjNrkuOsMJPd8a4ZyRgT/bk8PBiSpYL8AWWlpR8+THv1CZrNyWC5Wfs5k+0Aw895GTaIJ5Kh2SumxwU5oXTAm0c5jgAbFdw1XBx2y0WQiKi2CG22D3PClFwOhLD4e+pzTnK4+luJnWygeoLXjmtmIIJPbZ8/F+AO4tPk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iQ/bYyDubMYDuPMSOYtTP5X0ljnjWxoBSe9zQYs54A2ykcWXUTgAFcmb0HfS?=
 =?us-ascii?Q?k37Q9RC32jJkbeFD2w7P9HYqX0nrL1/HcBCxbA8qfJfXG7wZWC1A/c/J7O4N?=
 =?us-ascii?Q?BfH8UmloW6Oh98we03bIsJM0yXyFvxMInNJw3PUoBCnmMdws6vzx/omjfapn?=
 =?us-ascii?Q?IdNpp45OnJIVXkkcF4v6uZRErBn/AHKyoHY6bjB4U+gnKTcVoxc3EssHuUvr?=
 =?us-ascii?Q?yi6gWB2vvwe3dH+exSFGG6Oq9n8mBMOPmSc7sYucnTuYZNND4xjW3txD9qXz?=
 =?us-ascii?Q?CHV1RhrFZETGcXp3XK2oieKC+4ai7dXSPvJuF+mohOOVnUzOmDUSURrFkhuA?=
 =?us-ascii?Q?DxpZZ/JjBkVTVryw2thU/ly/yYDJyZrEqcufuBa/F6CegFQXzLHg/Samjl3y?=
 =?us-ascii?Q?x+3VmwO5J7ALSl6YR56yaHFq5mlwE9gNpMy1hy5wJVycW5f+C7x2dDY/B1Dd?=
 =?us-ascii?Q?SArPUUbnZNtXEE5tpK1nn3r0g5l46muaFze2w/nfHHEK5FIhkSDQo1N8GNwh?=
 =?us-ascii?Q?NFBmZ4qA3jimc9qkT3fYo4p3xKX1PzG5ZMQ0GRz9V342rbFGJLPlNNZHwbDv?=
 =?us-ascii?Q?mPgf0vx2FOnGhyNxLKTns/FIHDU3bgJjc9aY0F6SXjlLVT9+IMuwtGHATsUM?=
 =?us-ascii?Q?a4syVbKr4RpSGCvhM26+2jlg1cgdwnngCCIpnW0/lKn1aXELTQtLNiLRAowi?=
 =?us-ascii?Q?7qhnES6nMZ8JmEnBX/7XSp6tQCOu/KFF6jrYN7zKdjaNsJi/LjPEPbHr9vVZ?=
 =?us-ascii?Q?g+8ie+9sifwcLp2V/R9BEfQ9m6TsFFBNJHV3f77gQSC77qlKPah2OgzA1yxk?=
 =?us-ascii?Q?TmrGmtT6ZpTFLvjlYLQJQklRJ292WQ6cIDw/bjncVUnLrYjBNd2brT31dqF+?=
 =?us-ascii?Q?modndGbjBa2h7/RCgVVnRWuRvyfL7zU0E2juCOxwSLPxH4yO5oqyz3nW4DFf?=
 =?us-ascii?Q?Wyuhc1bP6pQ5eI1GLyKptIesmb4HbZWVVfuQORGanAEY5Sb4eQMY01gX6Hzl?=
 =?us-ascii?Q?pUXtSQLe0tvfO+A0ViDhhWG+E/elN9VOL6vLxd+Bl3X9Evsw1BzFNxuHWAN4?=
 =?us-ascii?Q?yHMdNgRFdk7OtmlwNiDjAKSLtnUFS8zB6Mf7xcgiSm7xEz69RLSy3emtEtn1?=
 =?us-ascii?Q?DmP8WOBXr78ckDyR3dDabqOr3tBigUVnJYcLJ3cUGCjFeiuLqfZbMBO0m6SK?=
 =?us-ascii?Q?kyJjdPqK6Oz5RQFqyGOw3OwZ7u+RZ8xmQd+araTDR0TEhSi7jMJ+LjrzbnED?=
 =?us-ascii?Q?B2CDrK6Kdf9WoOmjAq8ZHBRHVD6aHUBp4eUVzT/Xc0UiKiIYAsIritRuOhCB?=
 =?us-ascii?Q?kSI34zLcJv6/dsldOanabcLcCl0AM9VYGCJ9Pbtkgf1ntUq2QuUU0xKUeSE9?=
 =?us-ascii?Q?5GWR3710AzPj9rIB0yR3lqGtzDnl33TKeeS3Uqigp2jx9dZL4Q6gIBEVCMLh?=
 =?us-ascii?Q?Ns4EoUe20JWfd6aee5yCAFNOjYvA6/GZf0x9iM7PumewkDJvZ1JM4ni3HQaX?=
 =?us-ascii?Q?i2nLzOvM3WOYdYvI+zTDULPIP/1X4FeEVkWKnLfOKYR4eztj3gDt3hyh30ob?=
 =?us-ascii?Q?hlnBC+64vCTdzelZAdNc0zvl2HbMEX0GqLyFh6O87J6AdVj3HrgFY6CS/Axu?=
 =?us-ascii?Q?DgG1N9Jsa5x1UniuAyzPpCjBU4wq6W1VuUri0OodgG7NSURye8VgjRmV43IJ?=
 =?us-ascii?Q?Fri687hFyMWOP6woOkeUgXjjtO2NApVltmjg/hImYLNZXzXBDfPs/rUEr/b0?=
 =?us-ascii?Q?3/Z/lDyzwNJuR5LW+BsEBQpBBnHCn9mvfyADIKjuFoqGxBFeagV88ElaoU1e?=
x-ms-exchange-antispam-messagedata-1: e8S+mNi/++hCWA==
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AOGoqgJ+mRs2f5sQ0c1G9Xa0vGYfDw2W7IkYcCmXR6FpC1oiclBQ66Nq2Q08F4GGgpiEaIID/6eRTp+7q+wTYSWDmzDfprPQLKjVoyJSGU4YYM5Te861zyd284CiAJCqMje/IO+K/CaGdrOMYV966rorTK86TA9Gg3TS3z7umIJEzTc58KwtueRamLhW6mZiu2A+z2VyX5IGbaahuZCyOfJ8Bjch10OFuKWwpnxhbcK4zZWbWA9E33lFDmk/vYB4hHibIGkFakwQwXgDlJOZRzh0InmHuMHRQewztF1zt9GPMnUmdMbEqcmCL06GF0SlK2QdJGJ4WfV5g3x0juY52g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d948c9a-70f9-4edd-eeb0-08de807c2426
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 21:13:00.3590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QPpj5nc6EQ3fPLNO9aC9sES8SMRm/ML1Z016vr/Goi4+k21kU7UCIcJf7x+2GzQ5sHb7gVP/LEIDdJAkAhLy+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6239
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-33163-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: CDDFC279DA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com> =

> Sent: Thursday, March 5, 2026 6:07 PM
> To: johannes@sipsolutions.net
> Cc: linux-wireless@vger.kernel.org; kavita.kavita@oss.qualcomm.com
> Subject: [PATCH wireless-next v3 08/15] wifi: cfg80211: extend PMSR FTM r=
esponse for proximity ranging

+ * @max_time_between_measurements: the negotiated maximum interval (in uni=
ts of
+ *	10 ms) by which the ISTA must complete the next measurement cycle.
+ * @min_time_between_measurements: the negotiated minimum interval (in uni=
ts of
+ *	100 us) between two consecutive range measurements initiated by the
+ *	ISTA.

These are not useful when processing the result

+ * @availability_window: negotiated availability window time used in this
+ *	session in units of milliseconds (u32).

This one too.

> @@ -4295,8 +4329,19 @@ struct cfg80211_pmsr_ftm_result {
> +	u32 tx_ltf_repetition_count;
> +	u32 rx_ltf_repetition_count;
> +	u32 num_tx_spatial_streams;
> +	u32 num_rx_spatial_streams;

u8 should be enough for all these.

---------------------------------------------------------------------
A member of the Intel Corporation group of companies

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


