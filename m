Return-Path: <linux-wireless+bounces-2525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D2A83D49C
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 09:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61242284E8C
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 08:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9B720B21;
	Fri, 26 Jan 2024 06:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ecu8oIXM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275C720B20
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 06:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706252033; cv=fail; b=MMqb1l1WJMNpK4I/+POzL9crGTbxhXA7ASSPgW2+3T2clWql1sQ+zohI2OHnPgsqGRUWT/DzQOL54jjmVt7+VDXMG7zrCYXeKGmlwF989HLDDgjsw7fB9aQ69V7Snw3+VFvQ2nYccddxbKRTpMqL6lXTxOgxIshf/8X2dYciQK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706252033; c=relaxed/simple;
	bh=6Nmh4z0FUELWv8X+JQ5VlkWp2lyyrPXNc7aTWad/e80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JrauRDqdkYE1FShSAQGeF5bCdJ5Z0hRPK5zN9pdOCGOtpiSp/D+UO5gM/2PrdEY3Pqvfi3ZonFYN/LLX80f34dFPyySLRsbQXNr/KZXW6VMEPe2g9l13fkMcTOAEmTs9IPmCUTG5wvC6rw6UgW8p3JW16o8D5PVUVZ92ESXPuWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ecu8oIXM; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706252032; x=1737788032;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6Nmh4z0FUELWv8X+JQ5VlkWp2lyyrPXNc7aTWad/e80=;
  b=Ecu8oIXMiFgL4CB3RnneU29AwyMD+qIetCDTlUNi+OIgCeo5CzqEqCOS
   KMlxNx2zPTrLT9sI+5H3szrZqU5sDNJ8hX9KN9ir0CN7czwftTQFyvW/j
   YQXG03D1e75h7lRANb3GbHT3Qi7itnAL7kSyfmakTLLUNKicD0o8BdHlQ
   nhbhOqMuvM4Y22m8LR4WHqM4BfPnExqe6pCMiIy1ztFtZAD4oGbJMUC8T
   OkFYbf0rGzEzBATNnugnxd/waClyxv+2N7TqT79Q7ZExb3HXiHg3cfZrU
   GdzmN7wr4t8UdrIvpfvVi+LgoOAsG6vTWH1niEbGfUebY7sqbMJkX8A2b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9057862"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9057862"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 22:53:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2526817"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2024 22:53:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 22:53:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 22:53:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 22:53:50 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 22:53:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiUMDB5z8ZoyDwcpXvxTy3WxA/8KNtb8rXY4OMmLgULhJzJqb5ifkz6fUkhRCOO+durwmhrMD0xqGI9ik5z3wxDNRFaZMXB4ZzZKbePkpMhlhfoUgULWTV5rBAPW5dPHsW4FPhqQAjKdyozce2WOC9gREW2wq4qPaX1DAo7NjixKBofQBchwUhoNUc10MCypxAi3+gxBVrm5U/Lv1HtIUrrWwXFkTO7VThvJ/xi4a3icwLXBjwBmKWWicKaELiBL5WwboBQQCzqQZP2sAbr0NZVSaquAv1oFC8XVmP4jCIJsCWSQGgJJhKDUL89jRV0MORpueQOqpVUGxfCAHXZOfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Nmh4z0FUELWv8X+JQ5VlkWp2lyyrPXNc7aTWad/e80=;
 b=SQsaFrbOSEaE1wF71NL7xPpJSL8R8aBTkr5++yD5/mHxGYfOVDoLBHfFnd7qT3/g3eItZhTC790u0AOiFu1B2tfpNrH6kdGcsayqltHv9FJZrgw94Ch52wlQJqeHx2tbRzkcH2Qiro3E9f0G+Qu6Lp9YLO1bszckiJYqAMjOctahDQuYlFuWmtXJvarme+j1D3pPGmVrUljJvHlNpBPYeY9YdnfCNgwxoGGiUQ25jrvOJNS3ie7rK8AYrMcTy0Wb68uxHEyz9+IU6Mq7Odhams+HqWroH/euTZDEjB7cP3Vev2pN3tqufs6jBc+gtn4d5EbFPBYiCel+os2IbkX+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by PH7PR11MB8550.namprd11.prod.outlook.com (2603:10b6:510:30c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 06:53:48 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::d140:9bf1:fdca:b206]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::d140:9bf1:fdca:b206%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 06:53:48 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Kalle Valo <kvalo@kernel.org>
CC: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "Sisodiya,
 Mukesh" <mukesh.sisodiya@intel.com>, "Goodstein, Mordechay"
	<mordechay.goodstein@intel.com>
Subject: RE: [PATCH v3] wifi: iwlwifi: disable 160 MHz based on SSID
Thread-Topic: [PATCH v3] wifi: iwlwifi: disable 160 MHz based on SSID
Thread-Index: AQHaT5tDoM2ioIRKzUOeFwo4wklSjbDqxayBgABQTwA=
Date: Fri, 26 Jan 2024 06:53:48 +0000
Message-ID: <MW5PR11MB581057008E1D85805226585AA3792@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <20240125163103.578d2d3a617f.I558e8d0cf19dc862b1c4124df78a4cb690095bb2@changeid>
 <87o7d9cp2i.fsf@kernel.org>
In-Reply-To: <87o7d9cp2i.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|PH7PR11MB8550:EE_
x-ms-office365-filtering-correlation-id: 6ed0289a-82ff-4527-41ed-08dc1e3b8c27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lxMjIBTs4oVtX3vvVHExuIUOMYvhob7bewWHHNfCIA4vv/5BLPEqupY5ZPBNh7g1HTUpAcBf+2i4Si9L83u1y6rMnpQ0I//8DY1dMKaKOp+w36b8Rzy4uitpI6u/vvSqRJ0b8VU41Q7lmpPXamrjKziwVyQPVlmeh2p0J2c4QciZNCbs27AKINFEpBXxxOxQNl3R2N8suiRrU58joOQyuepN4Mpz8DnPoT5eFVUqUU7xgGsbTaHpViHGmjKsIlu52sfrsV3jTj+Np9EP5ODg5ogBHrJQe3gX9ce7PgKd9ygBt6p1909PnQl444MsD+GBjiW4uikSUx34TQbNlZ8zFAcg6AslTmXdDlMCzkyfCsW5Ih7zggtL3s0uhtG6GKh6wrCOY6NQogUXfsAhlBQq0Tj9qLw+H304iji/5QdC7hsHxfQhvQqCl239H+CPCqPhixZ+6CABK4IqBLaE3098fr/EZYcNhrtypyYuYVAL/75BXC8oRFwTbRtRnteh7QsF6qLoUNH8gXVHXMefW3jwWIoBRkV5v4nNmukKXCrKHQ6ybNfC/Ecg83zDKSapVoiMM3v6up+rYpDXlRyMHXWF1WWPONeksoGPe7T3sOmIbGc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(33656002)(41300700001)(4744005)(86362001)(478600001)(966005)(2906002)(52536014)(4326008)(8936002)(8676002)(66556008)(5660300002)(54906003)(66446008)(64756008)(76116006)(66946007)(66476007)(6916009)(316002)(122000001)(26005)(83380400001)(82960400001)(38070700009)(9686003)(71200400001)(6506007)(53546011)(7696005)(38100700002)(55016003)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FkcTMFPQla/Ekg8la+gMNqUW9fDQf/2Pw85SVD3ZRJ+KJMQNcjgd4guEPMKm?=
 =?us-ascii?Q?Qr/Cdwu9yRld0pninqSGCNyKRHmX5aXcTGUP/bjb0qv8KUF2kN+SLvAoyBdN?=
 =?us-ascii?Q?NRUBZZTBOWsQTHuQT/GL+pFjkJ0vHYRNZXggfh/ovFgSywoh1TyKpJ67QBZG?=
 =?us-ascii?Q?Be32x9PFfr7nqwIfbArHQvnwzUVitzC9jDXyMMl2deJ4VtFKDqVtklcOyRpv?=
 =?us-ascii?Q?DbuBgtMxRBqMoQPFX0pUyj4NUq/K1f3efUUIKvFoXLO6BU9s2/vkVWgDL8Au?=
 =?us-ascii?Q?gADKbknIqm2ogPMss14FdMVIj1e4P2vU5XOI/lJ/VkrZnEP7vt07vZ7v/zuB?=
 =?us-ascii?Q?3QvahMx2GdnWU67hzHmXBYVz9Gx6qJ8pZjrYAMWSfmjRwxUOmZH6sZ/YtmL5?=
 =?us-ascii?Q?x4n7E4cH31MZymoLVvJW5GXN8oK+x4xe8/DnxCuP3Oxjcp1ti9ZLJW29B/ku?=
 =?us-ascii?Q?9Pg5Lqrjb7dWKF/oYHfndOg8EA2CQQ5f9RqBcTFQgTZ1AbpeX692lonAYfDQ?=
 =?us-ascii?Q?3JKTSc8/0P4gQv488gd1KhB6RugNfN6zd/NTSWM3ovUxA846tNZhsnXHvNxq?=
 =?us-ascii?Q?i5dDNeIsrTW9Nh2j7Aski2fGKafyDtnGXjd7hOWxUbJExysTrWWMBsYVze25?=
 =?us-ascii?Q?LF1BAN2qz6TEan3v5Evo15cX/mneA4pZsp3vNTJFd9lLfDa6at/WVs6p8ESj?=
 =?us-ascii?Q?kwVR2XKTE+/ROk85Ho/ULpuUHMtDZ3bXkLsssSjia8mPk6f9vnfogJz9OlKy?=
 =?us-ascii?Q?gaMVoGAIr/Lr8BF5i0/CMZKkvIdSYkXLewXb65mkpdOFRe3ey1LXi1zTIS8y?=
 =?us-ascii?Q?Ej7tMi/zXt5LBgyfa42xTZzryZ6XCIbSW6q7VUMbKJbLYaS0iudXEZl57S4J?=
 =?us-ascii?Q?HxgP3RTOPBzwtPNC1KGkkxkSxDDHEmaiLKz26PjGyAt57Dfbcs2sYe9qCURE?=
 =?us-ascii?Q?6tnP7rO4/GmR1tGE5wR0SqM95SMbwZbpGY3N2B3d9t/RvyAwEunf8rXPGDnd?=
 =?us-ascii?Q?mKHRtVWJaiNuQfUJKToE4vmmq1G1cpwaxsQo+j/m5O4w3YKFEql4gedYfmVl?=
 =?us-ascii?Q?xE9obex4eyED8Mm07ISdwLP72VAobEL4Kh2Ilxhe1wEkUVQ3c+GpPS7I6duF?=
 =?us-ascii?Q?WLCtrV3oWhNzEiIbHQX2bY//BbldYZMWbgPNWavFDqFtKP1QtwMIORxR3yfv?=
 =?us-ascii?Q?3kZn6zPlQ4fgcpV8wtEupLFz8oy4n0hjaJbkRo8KtWDrK5mRKWWliDLrOW5A?=
 =?us-ascii?Q?Pnqshjx6kEvH3GYQU0Cmu9LbHcc47BnqQpSPFSHz2tG1kp93pWAluC/ufKKE?=
 =?us-ascii?Q?CZO87mDv6b5Ttq+rt0tw7ywDnmPiZW4Y1FBJoGcoP1nc6lSCWlkxkeqAGSIB?=
 =?us-ascii?Q?tDzW7EfJlBQoSIGkgXY7HTFv37Q4OtZ6CbBLyG1Y2N9Pr6nAn/L9o2vs0zwb?=
 =?us-ascii?Q?hYpDrx0L+UvTqShb4RQTZeK278n8+pJcWjqZy6bOU0lx3j+zlkUWC8xBp0cs?=
 =?us-ascii?Q?wqL0TFTFJCF8Q2wp7Ll4UA5z4uGkdNp9uMLAq3iuLwk+dKvXH9sgCLEzYAXE?=
 =?us-ascii?Q?xxSJnE3zwIR6DhvCo8mCq8xMfg8ZBXv+uElYlHF/eNLiBRJBsG/xPgfKCImd?=
 =?us-ascii?Q?Zw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed0289a-82ff-4527-41ed-08dc1e3b8c27
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 06:53:48.2438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: syM8rh7xOVT8Qt2cl4Mmh6lCYBeeBdlLcMS9UJns8kyixymU6LwhjvEC4pbtWtGI4z+/KJ6TvEXHAN9WuRPk8NCjfAx0Slf4J5wvr2NApw8QbdXK/tpXo5FHs3MY+wph
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8550
X-OriginatorOrg: intel.com


> -----Original Message-----
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Thursday, January 25, 2024 19:15
> To: Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>
> Cc: johannes@sipsolutions.net; linux-wireless@vger.kernel.org; Sisodiya,
> Mukesh <mukesh.sisodiya@intel.com>; Goodstein, Mordechay
> <mordechay.goodstein@intel.com>
> Subject: Re: [PATCH v3] wifi: iwlwifi: disable 160 MHz based on SSID
>=20
> Miri Korenblit <miriam.rachel.korenblit@intel.com> writes:
>=20
> > From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
> >
> > The driver should not send 160 MHz BW support for 5 GHz band in HE if
> > PCI Subsystem read indicates no 160 MHz support.
> >
> > Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
> > Reviewed-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
> > Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
>=20
> Stupid question: how this is based on SSID (Service Set Identifier)? I ju=
st can't
> figure it out, I guess I'm missing something.

So SSID here actually stands for Sub-System ID. I agree that this is mislea=
ding, let me fix it.

>=20
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tch
> es


