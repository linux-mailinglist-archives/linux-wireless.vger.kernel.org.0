Return-Path: <linux-wireless+bounces-1332-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAEF81FFC0
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Dec 2023 14:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478341C20AA2
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Dec 2023 13:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1503A11712;
	Fri, 29 Dec 2023 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BCrvE+2C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701F811706
	for <linux-wireless@vger.kernel.org>; Fri, 29 Dec 2023 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703857883; x=1735393883;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/akdBmneIea825pN/mks2ZvV/KY6lz48VTJuzQdYZPs=;
  b=BCrvE+2CEKlHhSp76/LGh+ELqjQaHwi+He3cwpPlaxWGyPVhP0tdreMg
   S9s5bI8Rvp/b4INX2Amlu2X1/Yh9pmXZn5hj8fBqbEbW4+w2fgbCHsXJ0
   W6CnROTtghlJ1OC2xjgogVz3cF6h0WRN4hjuunqNy4IE2b0YKH66IjsYc
   Wl+60qFE1I7G26MTYKtY+qn5971Gm3ouIExCJ2jmq516t2p6hhZlAIq0Y
   KWb3in4QxezGV/vUEC2Nrp63vb0Qf3bRXgu/X0OpdmQC5m2TN39zpDrVO
   FA59aZjIBRXMIJAUbMgCaUoIID3hBQ21mEMIZz1oQgdm691Zq9dMYGK6I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="10235669"
X-IronPort-AV: E=Sophos;i="6.04,315,1695711600"; 
   d="scan'208";a="10235669"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 05:51:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="897514251"
X-IronPort-AV: E=Sophos;i="6.04,315,1695711600"; 
   d="scan'208";a="897514251"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Dec 2023 05:51:21 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Dec 2023 05:51:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Dec 2023 05:51:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Dec 2023 05:51:17 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Dec 2023 05:51:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuUMfrhJlfFejc3ZdXFkY4kEBDnDjtZVoxRFQl1xt1Hupa5cRs2XsdZO7YkME+2VhOjgO6hn/NgL/n01WzIv71ZRVx370MHdQOj6Cw2XfhL9zWY7V2+vZrOzgYc64hay2KsodOpRbZoj+OSZhf5oNpdItjYFAdDN4NMMYmIpDgAKxqeJSguHxkSfp53olU5aV4+vnlXgzYwh2TnSjM/lcudJoFA+sUC1/iXB+gQpf+xeVFdAqHb2zyFwmS4AfpPZvbVZaDFbfhkZW2NZQcodhbYuYGMH2PWPOPSmORyoUJmqYq2v/+A3Bqk0cqXhYu3JSTjY+dP/CkhoCRdoaeWqOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HC/2AtXuOww7R4zK/j9e64oJf+nENftkRRi1sSk4zro=;
 b=cR5uvOmCOJD4IegiVSfRvOc7rlxUCU7lXF85x+0CbsgKnjJtGzsMTV0vuWlbd/00cNoTHQPn/9gx1DFMD0NOMmLkZyT46wnlE9d1TvPi1/LfARf8t+iS+NU2pSqNBoXENcmbrkXzjgQsHJfXfRA79WDU6tfT0Tusf44bFF2XHrtphWYyLCbvb3JQgiUMj0Z0bki5jnIl0GU2E56qRIIN9+M6TYmxqPtfNbgbyLHIqBFydYlMxu8a3gO2GbtrCM+WkKxmfAsCgjj99DzLfXx+xajpZN6+sCTosjS3JsDRlne2qWI0Tec0KqJB68uQkERkhgh+XArVUtxB0IDEkznKeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN6PR11MB3421.namprd11.prod.outlook.com (2603:10b6:805:cd::27)
 by PH8PR11MB8064.namprd11.prod.outlook.com (2603:10b6:510:253::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 13:51:13 +0000
Received: from SN6PR11MB3421.namprd11.prod.outlook.com
 ([fe80::1de5:f667:333f:189]) by SN6PR11MB3421.namprd11.prod.outlook.com
 ([fe80::1de5:f667:333f:189%2]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 13:51:13 +0000
From: "Sisodiya, Mukesh" <mukesh.sisodiya@intel.com>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>, Kalle Valo
	<kvalo@kernel.org>
CC: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "Greenman,
 Gregory" <gregory.greenman@intel.com>
Subject: RE: [PATCH v2 05/13] wifi: cfg80211: handle UHB AP and STA power type
Thread-Topic: [PATCH v2 05/13] wifi: cfg80211: handle UHB AP and STA power
 type
Thread-Index: AQHaMqKb0j5Wr7NUwk6UdK6KdQSdcLC1J4DNgAImc4CACQhRwA==
Date: Fri, 29 Dec 2023 13:51:12 +0000
Message-ID: <SN6PR11MB3421B9AC91E1FBDAD531C662FF9DA@SN6PR11MB3421.namprd11.prod.outlook.com>
References: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
	<20231220133549.cbfbef9170a9.I432f78438de18aa9f5c9006be12e41dc34cc47c5@changeid>
 <87jzp61ox0.fsf@kernel.org>
 <MW5PR11MB581024768AEC355DEE8F15D5A39BA@MW5PR11MB5810.namprd11.prod.outlook.com>
In-Reply-To: <MW5PR11MB581024768AEC355DEE8F15D5A39BA@MW5PR11MB5810.namprd11.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB3421:EE_|PH8PR11MB8064:EE_
x-ms-office365-filtering-correlation-id: 6d35f717-a104-4942-1655-08dc08753836
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c38L2H/RA4zOx7G9X3PO/wG6HiiyqF9ksmZ2wX9NcGpYWEztinrwTXHqNiE6Fjfq5KiIx2KzhpEcXNQ3KR3EHYL7bt0GUHIMnLsyiQRp6iYXBaWRK3u5XIkOHlrfZuzFQTpyhAM/G+HFcDWEDmTDvZC8Wg5/09rry8ywZoBC7rvJABnhyQJV8d0Cx+k0ikwLXVZQn0baCCmwMxhKybnl7hLJ1/ViNEEd99Amf3LSi7k3AeiNdBuYwushq3Uc8pRkeBph90TBRVBi44Qv4USxmvHkf9ag6iRnLR4ZbE8ZE+x9lYznjuYHIpfW22rX7tqprx15TY/CBlrm8VVUwzHKnjLPG5ehtgDGi3UJFeb17w7pU7ixZJmmUYitEaumyZTQ7spaLaoR7qAbIkMnffajbu9qFy5pjfxyEP2I4BH12P/bmGVm2nC4GtLPck++hojHoRQsPCNkktmYV2s2SpayZ8imtdOWMYiINX76Fu8yfXtQth3N243PRLtVW4Kr3ASPK0vEFywe/pogFWRSGzNpwaymt442Z/8EVUG7DErE/uM8d2Rj4T3AV91d4bSaAsPmfClsi9ewjafKxN8qO/iyEq3gajScDx025QjZ57XN/4Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3421.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(33656002)(82960400001)(122000001)(38100700002)(41300700001)(54906003)(55016003)(110136005)(8676002)(8936002)(66476007)(66946007)(316002)(64756008)(66556008)(76116006)(66446008)(86362001)(83380400001)(38070700009)(107886003)(26005)(4326008)(52536014)(7696005)(2906002)(71200400001)(6506007)(53546011)(9686003)(478600001)(5660300002)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JB7T7cV+70g49XpplOp4Gl84AIHieGR8iwn3Agt6j92OcJR+OxRrQ/JKMMmF?=
 =?us-ascii?Q?fBd0vZJKgj85dI7ey5I6subD0kNQ97UEVrdACyzmhAGvT/RajWDURXJfQ4qK?=
 =?us-ascii?Q?TavSIB9TBeSh6MmHOANaSMzoycaFXdw2WZ01C6y3RoJNKjIbfWcRLH6tcojG?=
 =?us-ascii?Q?zEJQ3ol+nUB56UKYZ87pj0x12/il1EQiSNb0LZtaPW4cI4PXZEd1Z3gYRRrt?=
 =?us-ascii?Q?e0ZaFXcUf3DGiirtVh2N+Xk9zuLs9OGT+sfd6xwXfSLlXOlXMXDbcGPEzkse?=
 =?us-ascii?Q?ilGG8S4AluZCsHwbUxWILRWek0cl69IblxTLCc20aKiKURj15s0vAGj1vVnQ?=
 =?us-ascii?Q?EQvZETUVZvbcpVcSAy8gQT7IT2NShAJ4d/OY8UOW208DVl0mQuKjGGgAPZT3?=
 =?us-ascii?Q?DRKjkDcLTWMMU4Gnj4Zb38qLhaTsrG8ih3OYdNjrbZzAa8w6slFPumBJa16D?=
 =?us-ascii?Q?aA8FLP/LKf301lMAj1a8x0BzmUFuLw5vDwPJv49gKpC4xiqLaWfZZvQ6mWN0?=
 =?us-ascii?Q?rxlP9m2ZWllrMchMrTLbgEDwarRimmppxcFrijgeRICy/dY0S0oto5SosUSo?=
 =?us-ascii?Q?23QJ4fUnCdbd3/24Pvc13/aF0ICkdjrgINhOk37KugIWsvvqoNj7CcbWmyQu?=
 =?us-ascii?Q?cxwJpw/6btJzWrKCWzG7wfguwlBwLRQ61agU5lI5Ns4A68ZFdDTH0VFcQ8xu?=
 =?us-ascii?Q?+6qkHSsV8HSo6milZv3Pk5IiHnaZHnCihn+CDo6iEeSyzSMt8+db1e8SbSsA?=
 =?us-ascii?Q?BPXIMoXJjVMOBFN4NMZgj7aIF54yj7iveVgNZH+PMvf+EUaI/x5gc+6mbPab?=
 =?us-ascii?Q?Wot5d/tcRTj55GOHyO3DI/9Nw/cdAPKdbNGvw/vXKqyalBUxP4iQofUCRmfD?=
 =?us-ascii?Q?QyRhTwJ62t96tL2WoBShJdqa6ZBI3Srr08JDf4gvGEaHsP4RVlCbG76VTq9m?=
 =?us-ascii?Q?TEwiVxAg6aT45HmWUPlAVqRCX1xfZvl26ll55g60chtHIRMrXyEDyDCJUYp+?=
 =?us-ascii?Q?uGXisVV4BuSaJuXCsn6tt8AM6dsnMd9WhP8MLy2LMvzzdENnLCYJpj3J6svt?=
 =?us-ascii?Q?Sv2husEgZJD6cpg5TaS2zpjb2SNatohoan/ysaIWoUpgKl09JTZ/RNC2W4KY?=
 =?us-ascii?Q?EMC4JJzNiV0U0BaJP+xLUu0w0eyHZyoJp9Zevclcan8Z/2Xnp/V8nYl7WXtU?=
 =?us-ascii?Q?iquO3BluLpsPES5HG66/QkAO5GtWNEeMgqjJahb4/qqJIMWrZTLdsVPvAsFT?=
 =?us-ascii?Q?fb8PjPqm44kC//OWzWukEmabQd9wckGE81Moc5z+L3RahXvKO25wExOmwBzb?=
 =?us-ascii?Q?yrwJbtYWMv+WLtnP25Xqq+B4Id1TpxAUiaj6c8oZ7xG4JCeVSXMF9MC74wCV?=
 =?us-ascii?Q?KivFFrrrFAacZlEgpvHXdSAKqobwzDqLCVeksjgsZFuN5t7ezJS+j8T87GtG?=
 =?us-ascii?Q?f+89RMl7tYcD/T2VUIWAm+YUBiEkAm9PLjdkzFBEXMgNkhj2LKGOD2KzHIUM?=
 =?us-ascii?Q?CxNdQiiKcMFdP/blICVUhC0ch1cGm5GmOfSXriMGPYdPXxQAt5qVba6PpDnZ?=
 =?us-ascii?Q?DUnf/SFH4T+zJ67HpBTHmcxd9nkZD0OEBTV0fKka?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d35f717-a104-4942-1655-08dc08753836
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2023 13:51:12.6703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c4Wx3etWf7jtsuNimJUzrgnyb3Y35a+nmJzWKa1rlEvrpCbusydtZ/ePRsEE8gzU66IHnYg7a0P2egvEsV2RS3WJ6tLgLAIP75TIJqp4BGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8064
X-OriginatorOrg: intel.com

Hi Miri/ Kalle,
Yes,  it is Ultra High band(6Ghz) AP.
Regards,
Mukesh Sisodiya
-----Original Message-----
From: Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>=20
Sent: Sunday, December 24, 2023 1:23 AM
To: Kalle Valo <kvalo@kernel.org>
Cc: johannes@sipsolutions.net; linux-wireless@vger.kernel.org; Sisodiya, Mu=
kesh <mukesh.sisodiya@intel.com>; Greenman, Gregory <gregory.greenman@intel=
.com>
Subject: RE: [PATCH v2 05/13] wifi: cfg80211: handle UHB AP and STA power t=
ype

> -----Original Message-----
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Friday, December 22, 2023 13:02
> To: Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>
> Cc: johannes@sipsolutions.net; linux-wireless@vger.kernel.org;=20
> Sisodiya, Mukesh <mukesh.sisodiya@intel.com>; Greenman, Gregory=20
> <gregory.greenman@intel.com>
> Subject: Re: [PATCH v2 05/13] wifi: cfg80211: handle UHB AP and STA=20
> power type
>=20
> Miri Korenblit <miriam.rachel.korenblit@intel.com> writes:
>=20
> > From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
> >
> > UHB AP send supported power type(LPI, SP, VLP) in beacon and probe=20
> > response IE and STA should connect to these AP only if their=20
> > regulatory support the AP power type.
> >
> > Beacon/Probe response are reported to userspace with reason "STA=20
> > regulatory not supporting to connect to AP based on transmitted=20
> > power type" and it should not connect to AP.
> >
> > Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
> > Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
> > Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
>=20
> What's an UHB AP? Never heard of that before.

Ultra High Band (6 GHz) Aps

>=20
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittin
> gpatch
> es


