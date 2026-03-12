Return-Path: <linux-wireless+bounces-33165-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCMeGwMts2ksSwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33165-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:15:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 747FC279DA0
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 974A2300B443
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 21:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61F23C2771;
	Thu, 12 Mar 2026 21:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dqVwErze"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73213B7B78
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 21:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773350142; cv=fail; b=cBybi1di5iNtyHfSTbCDODyFm6Moo+a2szs/cqwPztH5lz2fG2O5u/8+3pcYFTBsNvXDN6dftoBriZyRxkOL1topANyQbuzpDnxSJG3svvNfRoBabfSATDR/nSc/fm0jKU/d0eEEtArhEwt06SITBh/AdyGT15zvnnDs01eBStM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773350142; c=relaxed/simple;
	bh=XFoPTMXS/qDnFxTL/+mZslocbbhqFcdNtBnBlPhEF0o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NLffxQX+gleRy27+7D4W67ZlAyiN+Df1tcI8uznXhyZxnsQJgpgiyTjheh2WEDXrX4AOHndpaCkYhP6/+eLqXhxENIEoVuM0sywgTV1gn5eAMW2qaOLWieCIHY3R/4Q8GTFIIEpNXeWptRzyOoZXp13QlkYGcHmtO2A5H6UmUYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dqVwErze; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773350142; x=1804886142;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=XFoPTMXS/qDnFxTL/+mZslocbbhqFcdNtBnBlPhEF0o=;
  b=dqVwErzeQ+UKFNaoIrWHjESW12UXtaa9Htq2J1Xf3GAdRlBRyXup+4gm
   +bsEijb4tWL1XC8MJe39pKlnjQol4OL5kf41j0jTtZDr/8bWxZ7onPULy
   qBEH1n7DYNtkv21SazzX9ygls7SZ1uTPzooawnA5/ZEniaPpwqk57zFWp
   Xdz6pQ33HnGA3RKLcbYGTiOg+y7+NbFm5KEqP6jO08vypIF762ueKwfWR
   RH6wROE9IClrFSHmx7mbzhDRPGAGxfQgPmBywCObPWlGNKPEWsV4YGloF
   CaUscaTJOpk/VS7l2DWSyP2Jv1fxBc9ahmSqYStT5RnWqu7uwbkcklIWE
   w==;
X-CSE-ConnectionGUID: G79MyE8TQBuEq+KX/eGTGQ==
X-CSE-MsgGUID: dBxoeODCSeeYWWzEalZbig==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74426745"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74426745"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 14:15:42 -0700
X-CSE-ConnectionGUID: qUWFIcj4SmWWKYORBK/nFQ==
X-CSE-MsgGUID: ZuTbJ/pJSdKhzflbsFnUQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="218337893"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 14:15:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 14:15:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 14:15:40 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 14:15:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WL9gAeh2fq/F2Ly7HWFhEYdqapgGPBSXvkL0Q3uN4qliYw56eqWPMT9esLmjhQYeRylUu3yV3IPDYtzCEOWVGu+4WlR/rg/elDms4vZlUIYwAJMFXnfapJ4th5A36U5wuTHSgkpXQrpCIXEvDuiMKFeYkFnY+/8ztX+aM1V2xSK9xzHH5CfqYZIbEXs0+VWeL5Na+k6EMior7vQonEPOyKLv+U2t7GZe5u4e8PVViqvy3GRH2ldDHd8S1YBE5KEvDDG6+m/kdgls63aCkh6fagR+cODUAXYQz41TBJpCjViAO7jTlTpZM9FAhXTfk4VKMZ4dtAM3P59iZlOoUneeuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZP36vWIX3+0fcCBUU2LncEoXFe/eq8W+iuZuvEAm84Q=;
 b=ykRmgROxjII16WCXdl5Zi7WezN8fzAOa6qHefpnoO4zvmxL2V2MF9P/aos2zaYmMX7uqbTiOgBcBOH7biQMYhWrrC8yMqJ6LGnnE+bM1rtyp7Y3VklAR7tbHYGSbC3lchlHRHDsZZNVP8VQ5VuX2fVD0Fvvd7PGbZFGDhRD9SLvFES9z4ngAVhXnYbEhZewgdjd3JJ5HHT7rlJjtqSbiyX52v7Ngg76Gf5BNXG6YYoYlD2nHITN1g5j8zchk6DY3+e2WC9ULT+BDozlyxyGf1mAqP5tc6yyGvhEsYrquULp37a2mgvZc6VUE3SFNYExoxwF/w2WoxTx/zDLjERqWhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by IA3PR11MB9325.namprd11.prod.outlook.com (2603:10b6:208:571::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Thu, 12 Mar
 2026 21:15:35 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 21:15:35 +0000
From: "Stern, Avraham" <avraham.stern@intel.com>
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kavita.kavita@oss.qualcomm.com" <kavita.kavita@oss.qualcomm.com>
Subject: RE: [PATCH wireless-next v3 12/15] wifi: cfg80211: add FTM range
 report negotiation support
Thread-Topic: [PATCH wireless-next v3 12/15] wifi: cfg80211: add FTM range
 report negotiation support
Thread-Index: AQHcr8tf63fy+EavxEumU+GlX/PNUrWrau9A
Date: Thu, 12 Mar 2026 21:15:35 +0000
Message-ID: <CH3PR11MB838301E435C801AF69C87B96FF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
 <20260305160712.1263829-13-peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <20260305160712.1263829-13-peddolla.reddy@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|IA3PR11MB9325:EE_
x-ms-office365-filtering-correlation-id: 1868e905-476e-40c6-fb45-08de807c80b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: ZuhAELWElxcYzzhmCEzfanNdzPTWO9ezfBcZnCw7hWKG9nwH4Ux0DnOgG6OWffQTLKjQiV5oMIhfuQfYywKeHI1S+awcWd5fQIW6F1/kyzHC7T12OyXQOq2KbBdAvdRNCKwhL8U8d+WZMhRylMiLiu0nfxFfFF6S1fDZsd5bYG+11srcMZsOyExsHF1+hKoVVr6aJTXBQl3eehXuB7Jj7e7eEsSOdNf2v8FllVT/AFf6XMunW4dpZlFWDAfOgIzw1zYF56zYZHmCCJvI9YxccjDJM5qqyvPKz9XCj2eJ+9oMCUbZRT/AoHd/UqPo7kdjUkmtcknWIbpFAyqJ6o8411xVWQijMxxWBlV/bfFXHaPEARpJEvgeVhqdzthfYgYnHLCjwGxCSs13LEwI/t/8TkF7ocAxBAJyreiXWDv7UVTZjEtLZ1l6KXAvobbTSJsJClLG4TgyxcB1WtPE8iXhpIxqY9YdrVTMBp14IrErc1mnAYkc1rI4bh2BDpQtt5py9m33VoT4kOQIsqhHH3FViMu1UQoGVxsskZ47fsSgX8lBTeCrkJWfbEFwa46TxIKQzM5yCJsAYOKCmPWrf0KhqIdzi/0MQAGkq1I1evYVWJYGdAtQOnQxRtxah0wkDiyI6T7WWJfSfHzjfI+aGY1EYdBwEQLsDM2tlhyNRq1VxqlFVERMq9u5XjJsrqLCWLWq/KgL2eNuQLlDtOlTJam5b4IaOJmKBLpxv2oAfryRwwJIYZnpMu+7uSh1wn7G28krxhPYq6OQdDjGat8PWclREqSWu5tEVaKgL/Ed04+M+BM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OT9gENpisazPhywcJuoDIDvUUHI6zKSZtgJGKEhkBOUW2ZIK9U1JVpuTBrkL?=
 =?us-ascii?Q?+57yjyYVUO4C5ONcluPL61FMwKrkiu95Zf5WVSu4hO4/Um/XbeQ3iglX5LgA?=
 =?us-ascii?Q?q3ZO6OsV9OnF2UV7e/zerpLQjZj3TTDg+2b68fTCnsVECn+mDmtddJXosqyK?=
 =?us-ascii?Q?H+k+zdSJmbaPq++1eEGuylXnFCGeseMb/UwU0WLV8UqPHgJvAMXHjbujYz/N?=
 =?us-ascii?Q?B9WwweKVToJZPh3UrSR4DTqvULOmCnVSQzP9Lwaa5sCV9anupyMadbD8JxI8?=
 =?us-ascii?Q?PnbbrbL7nHZ0U7A47fIuXicqdSL1r4YM1lX2vqhRAPLrOy2++hQZa11uRHN0?=
 =?us-ascii?Q?83oNwwUvE1fyEu/Y3tsjKwcCSorHcfn5VrOUwF++Kph+auRJF4VJdKgmmlkG?=
 =?us-ascii?Q?Yrsyf8HV1D0zl3cvzWLyflnABgz1kUwZhrDJOVl3maRE3XqpkPMLN4EfkR/v?=
 =?us-ascii?Q?jwbdmE5i0BAnAqu8QAVMovaAX9QxqHjQ9Uf2N00MOd9O9p/F0wJPCx9VyM8q?=
 =?us-ascii?Q?BHeyqo2ttH/8eCVDJfUcTINF1DrMcAQkc9pYM8QygmCKm0QnvTLCyzu8aQTS?=
 =?us-ascii?Q?M0TR32qfvmEHtyO9t+7fbD1fq8pl1xdf84EMIGyMsDqfAe60c5RLdHEAyDfv?=
 =?us-ascii?Q?4UVXTIyjo0Ts2W5EOIAhKYofh6dwZXFqVRsITYqGOdwHvpMTG0SQeyZ/SS9r?=
 =?us-ascii?Q?mfnPvjt0KonWnLxP0IpDRxJDQkFAcBDoj5hiQSZciSY2vK6D/PDHZnP8mqTy?=
 =?us-ascii?Q?gh+KH8g/xvt1+FFWGn1lgTrxzwc784qpcwunV32stmXBFWJJfWIQC1Uwc9Sj?=
 =?us-ascii?Q?+07NvGqjJ+az0wVhbU/ZbQn1p2i1FzwVXJ4ESXU5V40deSnpe0dkMw5hJlCI?=
 =?us-ascii?Q?Yy2gBq8EcXKF5wXJWnOs6TsMyMmZ2ewNWzaQtp35fugbac64p5VvlKKtJfn0?=
 =?us-ascii?Q?Jw9SKBMZfzogzKFCMOj/n1ed464HD1RPRu9nzju8MA909Pgmdsq/KfZSGguC?=
 =?us-ascii?Q?efJrX8PhJw3RSWyQcAlbSCVs090Ikr6JuoDQLYZsgv+Ba6IAE3hc/zpfe/Gp?=
 =?us-ascii?Q?20IZhcM59xPNxmgxpPrWv48O8DjuuxPjBRDmGCXsDEbQ50SJuFUFcCHQkHKa?=
 =?us-ascii?Q?dxsFMKQEMtV0680GnaKf5lenDRI/Cce1R8qKRTTqr3OvC05TjoAnM0Iikb7W?=
 =?us-ascii?Q?+Saw+wFfniHJhkl+M/31cww8Tlgk8vzByYW8uwjineZeeAjOf9PIc2p6AQtn?=
 =?us-ascii?Q?4Quon1gJ+re1iaBDMIDAGOJ16+mAER9MuDzibgVEFkvFply9hsTPu0SgzF1n?=
 =?us-ascii?Q?pG9iyq5NV0SNuB7gC3RgcTtakLq+tRaWP1vAhWuztHUmjTEqd/rUVxJCzrFF?=
 =?us-ascii?Q?0j9M+Wu1NOCVrmNcoTWwwNuMAQHG4Xf0QpNs+I+Nw6KECm1PQ5HO1R+CcKWG?=
 =?us-ascii?Q?Bgw/+qDrTC7SNZb24R2qBAs6GJQgqOKLwplgLlfdV5nGv03vdMkwU4z6FE7M?=
 =?us-ascii?Q?OplRGZxpKT50Dn4NPNZUaxPoj/DEPCXH88yTbErvTjXOfp7EPJTKcphciPax?=
 =?us-ascii?Q?AirpfSB1YVvgWb5sn394Or5D8qbUnunMVV835PXtgVUbLKv7g2aa1vdnNezo?=
 =?us-ascii?Q?7vkJq/7TB7yycoZSlouiPjU8qTXjF5dPkQ+4/DjYH+eejsHnXi//rCmVfXM4?=
 =?us-ascii?Q?14XcKPcycEzxW4gBXOrHu+3Mu0WrkixHH5oK08CnKUUvNdmfmtXZz3exr5zD?=
 =?us-ascii?Q?m8Z4qr6LdQenqBAlld653S3mHEtVMa0DlDarxIp3Or21qBjU4T2BlnRYxuqa?=
x-ms-exchange-antispam-messagedata-1: t1u1QElCHzIbjA==
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: W1b4EtbNVXQuO2m9utnvFtw838VHFgqZ2iJJSW/HG4NgXvyTXbUujyCYEaKwf20Mjhic9RSfLpe/zxP+Ud1KKv/5bDVt/bKjNamXlOE9rpFzGEB3+Y30QgfCjFuH0FltoRCsHfF6lt8KOSKbZQdQMqhpA30pOSvb0GacNA7QjBoptXhkm6kCz2+BRCPie6TAxYw+jVUulI/16Ex+6snXLCyZb4PpeDckxWM7A9A4ImYmAcsvCrX4tkIqLdhMmRHHQ2GS2bYO4LUtpNTUDiISEdb1RrBPQAAJbQa+K32lH8gU8y6tXU97duRUEKQJQ2Buk6dGH011R0YUJ6GI+U3U/g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1868e905-476e-40c6-fb45-08de807c80b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 21:15:35.6756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gKsHZwhTL6VRxeal9aJWjr6z6lhKwmRGfshSD1UdutfbxTBABu3wOMh6ToKNMsAY6v9gAf4fiahzaeZVXjtUyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9325
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-33165-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 747FC279DA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com> =

> Sent: Thursday, March 5, 2026 6:07 PM
> To: johannes@sipsolutions.net
> Cc: linux-wireless@vger.kernel.org; kavita.kavita@oss.qualcomm.com
> Subject: [PATCH wireless-next v3 12/15] wifi: cfg80211: add FTM range rep=
ort negotiation support

> + * @range_report: negotiate for FTM range report. Only valid for
> + *	EDCA based ranging.

FTM range report is not negotiated. It is mandatory for PD EDCA based rangi=
ng. So this is implied by the pd_request and is redundant.

---------------------------------------------------------------------
A member of the Intel Corporation group of companies

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


