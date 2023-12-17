Return-Path: <linux-wireless+bounces-877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55165816016
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Dec 2023 16:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E131F21947
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Dec 2023 15:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C80745966;
	Sun, 17 Dec 2023 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMDGMnlS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01A144C94
	for <linux-wireless@vger.kernel.org>; Sun, 17 Dec 2023 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702825883; x=1734361883;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QPSrCX+o5hk2p8Okod/Gg/C9LXZkJjEkjDHqtOHyw1g=;
  b=WMDGMnlSPdGenJCOZ/lvbDpcgV3U/VEjG5KiBDyunChghPytngAj01n1
   ibzY6IerB13Nv9mtQC4gAEpEAJpwZcioX+jYVYZjB8c9t7LHHsE5MIXS1
   5DwiU/nfJ4fENUjV/WjjiFdm7/U+4IjEvlj5A4oW/KO0funuXQ242ZUej
   +gTTa3dHztn94G3xEO/evGkpLsPOAx0p9zm7i6i2LyXmUbuU1YxniOHGk
   Iuli1160ufGfU1lt7OdUlSAE/mpm1gvZIvg57JYM7XbAAN8dvhvvY/itQ
   qWdvO7q0jLETXvrVhOAf2mNlai3NJKmMxmTPcHcNifuJ7qpQ9ggnc6dCh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="395156818"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="395156818"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 07:11:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="725021765"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="725021765"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Dec 2023 07:11:22 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Dec 2023 07:11:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Dec 2023 07:11:21 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 17 Dec 2023 07:11:21 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 17 Dec 2023 07:11:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQkSxkzXSXvjKRJBpUoh9mRTLHQIcXG4uhUME5SyHf30NN4CCL9eP2IC5o3MTYAAFNLS4VR0E2BETvp/DouunsJnYbVphD+wAyVXp/R4t2YeLgS0gImcYm6dDJ5yaX+urHWFpBcwNJYewlpTezHjsNb7du/R4umqud1O2cQUDxj+B4lp52MkWcTCfdudxC90V923Rg9o2RQ/efWiT+QYPDKKe1MOLp1RM7KlUcqF/js3j2dH2CvJ6xB82lqOL8dspY2khMUFWS9I0ZczWSf4ZZZbn9iiKa70R6+Q5PQmRVL5AOfAOEuZHRXt6SmoEpK1PhoH3uEpizkupxKFfx/UZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aE3myzqmMW821Ccwa5fhb1YBt8yDOtf7Xekg9j1EGM0=;
 b=diA2xE3kF5Y6OWimnDm0CG0EmbY/f/a7jxUqghsJnoUrwh+7RAU+HbKVq/B1UleUeUCBvm8u9W6OKR8qGZG4ZV4OoC02dVoCz8DqXWBofXnrxeX9CnNg/IV0Gxf/tna7G6T1rcla748um6AejEzg4gANHpsuGXWjINa9c5LoMRgKCH1VrSjHX0Nk1yME+DRIIldvxrCUaQ+DaYvo86RtVVEOG9yNd4MtNmv5R4Z4ksQChfPVhkzmFzSzGciwfU9iMHqye3vCdfzUEYLXVr6GtNAXKjRdMEJabH97NAfZZFgkLpOYr+oCj5nDdeBQcCnwLukR8eVXjokKSeIqX5Avkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6043.namprd11.prod.outlook.com (2603:10b6:8:62::8) by
 PH7PR11MB8124.namprd11.prod.outlook.com (2603:10b6:510:237::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.36; Sun, 17 Dec 2023 15:11:19 +0000
Received: from DM4PR11MB6043.namprd11.prod.outlook.com
 ([fe80::4f50:37e1:d19:cc36]) by DM4PR11MB6043.namprd11.prod.outlook.com
 ([fe80::4f50:37e1:d19:cc36%3]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 15:11:19 +0000
From: "Peer, Ilan" <ilan.peer@intel.com>
To: Jouni Malinen <j@w1.fi>, "Korenblit, Miriam Rachel"
	<miriam.rachel.korenblit@intel.com>
CC: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "Greenman,
 Gregory" <gregory.greenman@intel.com>, "Berg, Johannes"
	<johannes.berg@intel.com>
Subject: RE: [PATCH 06/14] wifi: cfg80211: Update the default DSCP-to-UP
 mapping
Thread-Topic: [PATCH 06/14] wifi: cfg80211: Update the default DSCP-to-UP
 mapping
Thread-Index: AQHaK2mRrxuL2hBpb0mDmxS+sJxsd7CtQ8OAgAAoClA=
Date: Sun, 17 Dec 2023 15:11:18 +0000
Message-ID: <DM4PR11MB60430BF89551B1935E4472A0E991A@DM4PR11MB6043.namprd11.prod.outlook.com>
References: <20231211070532.2458539-1-miriam.rachel.korenblit@intel.com>
 <20231211085121.8a1c7d1f0034.I50aed38be78ae9aea052938e2cb6b5800010ecd4@changeid>
 <ZX7CbSCEv7Zvv476@w1.fi>
In-Reply-To: <ZX7CbSCEv7Zvv476@w1.fi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6043:EE_|PH7PR11MB8124:EE_
x-ms-office365-filtering-correlation-id: df806e4e-c04c-4635-c39d-08dbff126bdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DxAGaEjSVyDMPLatBOwmnX+41AuULK+zRM1nd6H2ymyyU4Zam79VlYeUPz7DJ8rt8TaDggVzemI9nn3HSX0ZhSySNmbhEQ9Tt+TQkLedgv4JPBcCfmugiasVSHp7ibPZuib/AMU5WmyUXKRQI2dHJ/k7F2OyUH37v/jYlP1J6mjFSTViPODai1npEBJEuj9Ewl4Jzo2qRg0F6kw9/LKveQgbfjL7rszVcDE2l5cmh3B71AODlrmU9KCmP0gdPZwxzAGPjSvce7UwApWYBZG98mhRkZHLDcT6t5Qggy/ybOI4w3og8/W/ZCrY2qqi8s5G9d3zogpeeSWJ2TKDD3mQtejM91WhMPEQMLMBxBzsVyxDrrVtoIuECCAmZf/rvX4Ecv3p84j9TJrGTgOA24ckN8j587YhTgHpo/OrW88+DZzqZc34f2kZkH9xKK8CJ2MbAd7Jo8G3rMP2BKw39tnTcnSZ8Ihcdvl+n8y0TOlkpGFf6oxkcAtAPg2dMtKhG04tB6r89TTFpAkXNQOAGqwKGJcZy4H5U4uVSGEwVwBtuaLYYUPGfJQU7+i0jlQMdx0yAX/9HcpON4pRIIXk1CG1KqG6tixNJ2bHKu3az35QiGC8CxEgu3a9Qa17MPRZcCTZO26V/8JT+DzwyMbAb45FIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6043.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(346002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(107886003)(83380400001)(53546011)(71200400001)(26005)(15650500001)(122000001)(38100700002)(316002)(66946007)(4326008)(8676002)(8936002)(52536014)(5660300002)(41300700001)(2906002)(478600001)(6636002)(6506007)(7696005)(9686003)(54906003)(64756008)(66446008)(66476007)(66556008)(76116006)(110136005)(33656002)(86362001)(82960400001)(38070700009)(55016003)(781001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l/kFR1tO7qNeE/4XG2YL4eLLnmqcLp4Ea8czgIzyphaksEJOXwUCZbRTIsrE?=
 =?us-ascii?Q?UJeuFwvuB3VeavUn92kUyObrhXxffpnowLzxCRsj0l50OOaNsB54r2uas8eg?=
 =?us-ascii?Q?jsCp0h1jaIHsRv5ppgDchc0A4BCOKEHPPHmTJrSpVOyIQie9lY9nEG1Q3leW?=
 =?us-ascii?Q?sPLZnfFeXUAwrusG8itfaaKC++MvTmUwVdlrA5FdZFP5QORzQmlVjWQJ7Mvm?=
 =?us-ascii?Q?lfHSdNSItYRGBaIkroy94QlkOS1E8DxVU1UoW00w8J29IDfNfJfMu7pI4R2B?=
 =?us-ascii?Q?u6Qaujo/Zlu7nsgRU2zcGfdTDocSlZqfTBNziwrGdUOIjHB8ibHybXC0Wqtr?=
 =?us-ascii?Q?9OdO8zeLWM/qUAjUg9XSD5n7TvP0OEfFA4EZiHuJnVfFYBhrDq8LFRgtXJHD?=
 =?us-ascii?Q?aPNN177J38zQzQ/XcwsB8LHuhBqPTbhdFXFW20IDC9s9jodW5/uaBnSSRvwt?=
 =?us-ascii?Q?CqMnATqMsi0e4Y0+0R0vVM96T4zs02TfMnY2Pdx57sbXfT1B/LMDoEalwVtS?=
 =?us-ascii?Q?4XpVHZjPUJgu3c6ul6bDyo3J/TED3CcuQYHh16llnT1dpwDDUebdngt6ihI9?=
 =?us-ascii?Q?NYYogdG7lmQuPfJCPgfTh51/qg3qRpMKDfmzpOpGWz3xp6sDPSoA5saLlfaN?=
 =?us-ascii?Q?IPfAGKIttNKHyhj9ovvYLFdHXRg0E1Ig/cF68CtaMPpCS/cE2zXF85KCD8TJ?=
 =?us-ascii?Q?pCQTSLpQAyVo/ZrpYeXjy7D9XCV5Fl+T500sQoUuj/VIRzi/wONZD5vay3D2?=
 =?us-ascii?Q?o5K/lEFZxank0Oxd6shyUULSM8G2HgDf/kanJW3Qamq56tBtkQZLdu8jjBbw?=
 =?us-ascii?Q?5nkD3XVv8RJV6rFYAz0kI8pbV3EyRZayMjEGanL9GoN2Z7F68cN5GYU3aAXI?=
 =?us-ascii?Q?PLvKmBTYwdIRqIF5KDkLWdyajhJxRblVhHEtzpJuiemAbfEfZ1QLxr9C1aKX?=
 =?us-ascii?Q?EaDjQcwYd7EjkN8PWOUlr5OnmT9tzthqZhk++LiVtyxQXXqyLCRIRhH6lz6D?=
 =?us-ascii?Q?ce2iNG/V2oW/Pw0eYvmMmwDdJJ7kYCrJI3fXRG77LHLqO1dEy+Ykp7zXhZkY?=
 =?us-ascii?Q?dE8jljWydHSMEvCfzQV33c0sxhRIon6I8N87tAwtluoNhBUmGll4+zGxhfsH?=
 =?us-ascii?Q?yCAgbnSL9w5eCwzt8BDGDmuzOuqGBKDHelfWlMj4HTj0fK9blHWkG7YAti2k?=
 =?us-ascii?Q?ECx8l9h2O4vRR0nSGQQKgEvt6txV7V6NxbTDyXOH3PUWa+x3sN3pxzl07rB5?=
 =?us-ascii?Q?7b1SldwaZuwDmZ5sXvW0Ijav10jShiUNecbRWTCfdyMrxZlNWS2haE5+N+ZA?=
 =?us-ascii?Q?VZ8d91hOV0zdITYFBd5LVa/ubYicTJ6VVujD6gpUCtBwfGDSSiIfck45Lkxc?=
 =?us-ascii?Q?iFfIjGt7M/jHUWfN76bjcKxSgXfNKYkNw05Gt2divPHJ92ribU/qUxyyj0qU?=
 =?us-ascii?Q?GZGUqP7ERHW9mdba1zEBp1DJPmd3z3LQ7Enhd/NFLMtUrxZUrbIhekLYJEDH?=
 =?us-ascii?Q?kUAIsHrHbBp52RymTXYXoenME8R/CLm4efJfW/1fyWlVE30mCEog61x6dnC5?=
 =?us-ascii?Q?3pPd/q+3PwadvHMdoPEyuIpFysmw7Fd4YtnB0RLq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6043.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df806e4e-c04c-4635-c39d-08dbff126bdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2023 15:11:18.6812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wQ3n0aKIGTnyjX0VVx0Gc2fatq+eBmhqk4iqX3xB0lzgPhWwLDmZiBRwlaCCKWXKxMRGKqkT/jYn0XaUddYESA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8124
X-OriginatorOrg: intel.com

Hi,

> -----Original Message-----
> From: Jouni Malinen <j@w1.fi>
> Sent: Sunday, December 17, 2023 11:42
> To: Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>
> Cc: johannes@sipsolutions.net; linux-wireless@vger.kernel.org; Peer, Ilan
> <ilan.peer@intel.com>; Greenman, Gregory <gregory.greenman@intel.com>;
> Berg, Johannes <johannes.berg@intel.com>
> Subject: Re: [PATCH 06/14] wifi: cfg80211: Update the default DSCP-to-UP
> mapping
>=20
> On Mon, Dec 11, 2023 at 09:05:24AM +0200, Miri Korenblit wrote:
> > The default DSCP-to-UP mapping method defined in RFC8325 applied to
> > packets marked per recommendations in RFC4594 and destined to 802.11
> > WLAN clients will yield a number of inconsistent QoS mappings.
> >
> > To handle this, modify the mapping of specific DSCP values for which
> > the default mapping will create inconsistencies, based on the
> > recommendations in section 4 in RFC8325.
>=20
> Could this commit message give some more justification for why these exac=
t
> specifications are the best source of this information? For example, shou=
ld this
> also reference the Wi-Fi QoS Management specification?
>=20

I was using these specifications since they were mentioned in the Wi-Fi QoS=
 Management specification
and because RFC8325 was specifically mentioned in the WFA test plan specifi=
cations.
I'll update the commit message.=20

> > diff --git a/net/wireless/util.c b/net/wireless/util.c @@ -980,7
> > +980,53 @@ unsigned int cfg80211_classify8021d(struct sk_buff *skb,
> >  		}
> >  	}
> >
> > +	/* The default mapping as defined in RFC8325 */
> >  	ret =3D dscp >> 5;
>=20
> Could you point to the exact location in RFC 8325 that has that as the de=
fault
> mapping? Figure 1 has this note: "Note: All unused codepoints are
> RECOMMENDED to be mapped to UP 0".
>=20
> Section 2.4 does describe what many APs do, but that section is called
> "Default UP-to-DSCP Mappings and Conflicts" which does not sound like a
> recommended default mapping in RFC 8325..
>=20

The term "Default DSCP-to-UP" is defined in section 2.3 in RFC8325. As note=
d there, this is
not a specification definition, but more a term to describe what is a "comm=
on practice in the
networking industry".

> > +	/* Handle specific DSCP values for which the default mapping doesn't
> > +	 * adhere to the intended usage of the DSCP value. See section 4 in
> > +	 * RFC8325.
> > +	 */
> > +	switch (dscp >> 2) {
>=20
> What about "Standard: DF" (0 --> 0) and "Low-Priority Data: CS1" (8 -> 1)=
?
> Are those omitted here because the "dscp >> 5" happens to have same value=
?
> It would seem to be good to have at least a comment here pointing that ou=
t in
> particular taken into account that comment above about the status of that
> "default mapping" and how it relates to RFC 8325.
>=20

Yes. I thought my comment above was clear about it, but I'll rephrase it to=
 make
It clearer.

> > +	case 10:
> > +	case 12:
> > +	case 14:
> > +		/* High throughput data: AF11, AF12, AF13 */
> > +		ret =3D 0;
> > +		break;
> > +	case 16:
> > +		/* Operations, Administration, and Maintenance and
> Provisioning:
> > +		 * CS2
> > +		 */
> > +		ret =3D 0;
> > +		break;
> > +	case 18:
> > +	case 20:
> > +	case 22:
> > +		/* Low latency data: AF21, AF22, AF23 */
> > +		ret =3D 3;
> > +		break;
> > +	case 24:
> > +		/* Broadcasting video: CS23 */
> > +		ret =3D 4;
> > +		break;
>=20
> Typo.. Should be "CS3" instead of "CS23".
>=20

Fixed.

> What about "Multimedia Streaming: AF31, AF32, AF33"? Shouldn't those
> values 26, 28, 30 be mapped to 4? If not, it would be good to add a comme=
nt
> explaining why that is not here while it is included in RFC 8325 Figure 1=
.
>=20

The default mapping maps AF31, AF32 and AF33 to 4 which is the recommended =
mapping.
I'll add a comment.

> What about "Real-Time Interactive: CS4"? Shouldn't that value 32 be mappe=
d
> to 4? If not, it would be good to add a comment explaining why that is no=
t
> here while it is included in RFC 8325 Figure 1.
>=20

Same here. The default mapping is used. I'll add a comment.

> What about "Multimedia Conferencing: AF41, AF42, AF43"? Shouldn't those
> values 34, 36, 38 be mapped to 4? If not, it would be good to add a comme=
nt
> explaining why that is not here while it is included in RFC 8325 Figure 1=
.
>=20

Same.

> > +	case 40:
> > +		/* Signaling: CS5 */
> > +		ret =3D 5;
> > +		break;
> > +	case 44:
> > +		/* Voice Admit */
> > +		ret =3D 6;
> > +		break;
>=20
> To be consistent, that comment should be "VOICE-ADMIT: VA".
>=20

Fixed.

> > +	case 46:
> > +		/* Telephony traffic: EF */
> > +		ret =3D 6;
> > +		break;
> > +	case 48:
> > +		/* Network Control Traffic: CS6 */
> > +		ret =3D 7;
> > +		break;
> > +	}
>=20
> This does not include "Network Control: CS7". Is there a reason for not
> covering that case 56 now? I know it is "reserved for future use", but RF=
C
> 8325 does provide mapping for it as well.
>=20
=20
Same.

Regards,

Ilan.

