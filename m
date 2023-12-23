Return-Path: <linux-wireless+bounces-1270-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557DE81D665
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Dec 2023 20:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641EC1C21565
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Dec 2023 19:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5FF15E97;
	Sat, 23 Dec 2023 19:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aqMk99lK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CDD15E96
	for <linux-wireless@vger.kernel.org>; Sat, 23 Dec 2023 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703361176; x=1734897176;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YVKmA2HgJvCiSHGncVFU2178V2EdzIawa+w1SqfQPO8=;
  b=aqMk99lKrOFISkSakfpKhESU0ME+sAIlNMW4faE8DpxTJAY0h7/r6B25
   m+FP44Uaj1qF6U8kfGsJSvOeryIzr1IKhzLHwiDdFWLcpVoPHvC2kqMl7
   h3YTdX0xNxVQ4wjTr/uN68HsiKJ5Kb8vapVrUgIFponrnT1xWs0/eZDGv
   eb2SvLGZ1tGwS/8fQ3IMlVUEfB7PLzB2AqAdCGUh3F6ASkfloh95foUK3
   trIUWLzbbU5XJzUOxARF7tq/2085i8Q49NjO/SmEnLDkPVzPbYGZGEwsR
   cVgEmmA8o8KFx1YBqORkN7G1NBkA74KwwAgrgZk40E+jN6JLi9O8m8ROi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="398992703"
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="398992703"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 11:52:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="777382347"
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="777382347"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Dec 2023 11:52:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 23 Dec 2023 11:52:54 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 23 Dec 2023 11:52:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 23 Dec 2023 11:52:54 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 23 Dec 2023 11:52:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObgxUdActZPemZ7CWB4iNzPCTlYGEMP0o+3eL0zkF2QMPMhBNI6wKfnTDf7UarOHVNNTipmw2RpGyw9bZBKa/zux0vus3QtvGgsknIP5jcyJx2Pa3/y5OoPeakkHNRm0EN9jD59Ra2rrOUn+gKhnACr9WWLVMVMC3jdgiEA17FhNhfQorAmuydTC8T4W8y3XfLtiKpVCO/js6TOukKanqTnu0RfEvrbRVyozagdkZw4kWjTNIMDjBfhiTnLCHjDqcWPTL26vBMWXf00bO10BopcPLcW0weIHYr1rmV/e2yqNT6VxseYYRRfROzp7TDbUx6n8Z8qi6BjMlbtDIWMrEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVKmA2HgJvCiSHGncVFU2178V2EdzIawa+w1SqfQPO8=;
 b=eQ5HcS8PxMI7ZE/QHe31Ju7yVJySA0n/wWH3gzaPMAZ6c+AhmBlPG0I3ffeSwMXANGKvz3A8YHqjuVqGMkHmQnD64uoeBUGOrNybVaCdghtHgWOcGVHSIDmjzxblIb8UnUD/dFWqFVz7VFCOPZw7+hE3if+9OhkPDxntNC5oB4+nNWKiT8b//cia8HyNyk7YN68ZbiS6QM9QFyymyWGHStZS8nTxlf5KMKUfHiug9JkLSm17ZAJoSdocv4Yp1LpIQ+p1r4i79kBsY8uKLnSLjbCFmC3seO74MNV7rJDn3uZgnKe559V5ygGzpPepmDqy5KH64s/9V1+IcbWstIv6qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by CYYPR11MB8332.namprd11.prod.outlook.com (2603:10b6:930:be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24; Sat, 23 Dec
 2023 19:52:51 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::94c7:eefa:414b:4757]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::94c7:eefa:414b:4757%6]) with mapi id 15.20.7113.022; Sat, 23 Dec 2023
 19:52:51 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Kalle Valo <kvalo@kernel.org>
CC: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "Sisodiya,
 Mukesh" <mukesh.sisodiya@intel.com>, "Greenman, Gregory"
	<gregory.greenman@intel.com>
Subject: RE: [PATCH v2 05/13] wifi: cfg80211: handle UHB AP and STA power type
Thread-Topic: [PATCH v2 05/13] wifi: cfg80211: handle UHB AP and STA power
 type
Thread-Index: AQHaMqLNeZBHIJhEsUqH8kzH1VQiPrC1J1rLgAImJNA=
Date: Sat, 23 Dec 2023 19:52:51 +0000
Message-ID: <MW5PR11MB581024768AEC355DEE8F15D5A39BA@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
	<20231220133549.cbfbef9170a9.I432f78438de18aa9f5c9006be12e41dc34cc47c5@changeid>
 <87jzp61ox0.fsf@kernel.org>
In-Reply-To: <87jzp61ox0.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|CYYPR11MB8332:EE_
x-ms-office365-filtering-correlation-id: 20a20e4b-4384-4af6-3707-08dc03f0befe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iAW+VWN9C6RxBCLEcWFgMbRyNRdpR1JBYpYqqEOuNTFOhaj88XqGznI9CL/cyX9mWWdXQuE3mBXECEzWWf9bb8kLvl1ymBXzluEDa0z6fiEI8q289/44pccKNNXlQdUJLrUMbm6w0VTy73rzuurLyF6niaxLfFhH9zKjZBW/pgz5tG49JpgTkhNbx4SBNFH8gr9pi3NJ6Z1VFt9xmSnUFAikIVFmpZZfj253lRBtbGpa2k15l3DfVbA1aWeD7FwfP/iV2mTt4ghRnmpwvfcCkoZn+8ONM/8NOXtRHKwTUxO4WIDxr93h3MZtlaU8NISTci8ZddFch1yi9XCq3cdwdxMB8tTiBAHP1qYBOaElJmMQgsQoJfgIiGZqQ+LgzCUT8e1dcreSGxS/BTY/fsNbMBRcDEGURgXSIeAPM3DHSIvvMNXmtcmH22n+/ZprlbzNCY70aaz1NWW7taZJwuBwqqMYsxIYC3b39db3fEkoAxH6bjWWAdS4UPfF2jEMfU0mgXfmNgNQ0PyNkYX45hfOJtaqqLefWA1HH7B26EOnPcd3bt7TszKAfmCwra8tEtG4NcHbiZ0b9zzpq/RiC5wJaZY4/ec8xNR25+rhAgGr7DM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(83380400001)(82960400001)(33656002)(86362001)(41300700001)(122000001)(38100700002)(52536014)(966005)(478600001)(8936002)(8676002)(4326008)(316002)(6916009)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(5660300002)(9686003)(107886003)(26005)(6506007)(7696005)(53546011)(71200400001)(2906002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9vqoTjFWyLIxO/M9ap3z97J1UQKdOxwFSPdiMjyzsZRTWNF/GAxvluYINa7U?=
 =?us-ascii?Q?zws+C9eyeI0bwMD5wGISlE9OnNpFpSLltJ4+RaIQ+MkiJxd9iH1j/gczDk8M?=
 =?us-ascii?Q?ttl76pYW+7j/pHvWdRIFsMG8X9iBaHU3mrUjamS+U+FFKnMWAAAF/vjcDeFc?=
 =?us-ascii?Q?tC8f65KLg/H2tETM7JdsE3VYxnNBLD5xPWaxFkRdc1Wi8rzzOJj39ebSGt5d?=
 =?us-ascii?Q?3dkRC8eipzcijiX1lHnNQxzT01CUHiIWZs+8YZ2uHZYqYjxZu6OEpTiou/P+?=
 =?us-ascii?Q?T5GqF9Wo7EGrIZGtOjxrSv8SRETYAniW4sUbMN9wZfMgs6TTL8RPuZM7irA2?=
 =?us-ascii?Q?fbGQzM9Cgi71inO9iltNtaNwo81MIV4LXcThtadV/YZmHvpQEsXLSd9vG/su?=
 =?us-ascii?Q?pTTdDh4al5UWYYBx7z2rZCKZ0JSj8mVqFpKDt2FuilZOFLCQ1FRJZNO1tPwd?=
 =?us-ascii?Q?PT6VfbrZnlXjtTDlQTvnUUtzVe+t+YLH/iZoYh4OecPAU3uuJ69j5hn4y8N6?=
 =?us-ascii?Q?vJXi1XEnNuelKV6nG6M34UXwFm2O1eEdU/v5SDlupn3Ho0UjQePk2X6hbjyS?=
 =?us-ascii?Q?wQlGdnPAoz8Mn0ka78f0waCqbypd7OtPOO6wWIuqPWe4nAx1TPjfmXOiw/xT?=
 =?us-ascii?Q?nAnp+dKSeyLEL9i05u185ZQ1hedhpKAk+hkb1cV1IDePshMQWleTaJP2/24d?=
 =?us-ascii?Q?xfHGMq62QH6ezUkNRZ9ZbzAe+GedIWnvfHGfvly+1YL3pccIDlR0oEqWrc4l?=
 =?us-ascii?Q?PhVCFenBhJyCtR2aUno8ysbr+P+Bq0iXXi+BGLeEby/WJsAy4XjXIJ2mEK7c?=
 =?us-ascii?Q?GUb4vwTCY7oAmqOKQ2fSZW0GhrxnVXR04LYDMTvPwwTeSA3/u7T8D2516FWE?=
 =?us-ascii?Q?smH+hZzFMkPW43ogv+k5uuUieelf86PH2vE0AhdTWh3Rmts/hlwVsEfFMq9x?=
 =?us-ascii?Q?2wU7d1orgvqsMTELPz0xivHnBcXa64WX0S/t51sgJCa7MmeU3iH94qvtxRBS?=
 =?us-ascii?Q?nuPWBnh7+EAm3Lu0A6eHaAHdz+VthDgSKpJAVv1dASDAJIYGNuV4co0xzfYJ?=
 =?us-ascii?Q?l/cM7gJjDqNO928zAIqTEC5q9w/0UvbMGAbHz8F1+2GZNMzwwts6oITfejf9?=
 =?us-ascii?Q?Q9vX7oqC2grR91Ymx109GepSDqhZStHET9yMtqwpk8bTdNSYX8cO0U5OrP/3?=
 =?us-ascii?Q?sQiCbWYRwPjoqkDfrTzEnzE0jLcnsvwa9ymrWrtuoX8yI2YOsheDcWsV9bXs?=
 =?us-ascii?Q?7D+AWX2mp9qJomj2mlDDQwGZKrcppNpwBo2YO/pyMsEOiX5ESZofUEwQOsHJ?=
 =?us-ascii?Q?5x1CqT0D5MWChkpPLsPkXnRyQzgX2kjiTslAE4S2BjJGhYLrsMezGhnFP/IE?=
 =?us-ascii?Q?TTgHKJLJRaHlf8aoCmGd4kCqy8dfMu67OWxjBIgOo0gx4af8BK51DiU9ZIwv?=
 =?us-ascii?Q?gHR2X/VmRP6uk1uvCHdimWPDR5B0j4TJuuRK5FXcxhCX5ae2yD4ZES0Rfo0O?=
 =?us-ascii?Q?cHdh9NxVuc1TlO+ME37Y/7JwM7k2pnBVQaATrojtylHqO2J2jDpXqvbFs46I?=
 =?us-ascii?Q?22sPagZmEkTQECbK3K0YqTAM9yFHXBYl2zI7qMdRwKbgqEVU7Ld2BUBBfvq+?=
 =?us-ascii?Q?EA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a20e4b-4384-4af6-3707-08dc03f0befe
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2023 19:52:51.0633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hjKapXXIE43PR93S+RHcU/QEs9GsxAZE1S1rlP4c+1ir5oOp+NTyKUbMort46xps/14pOuaiX2lPpY/eimY0vAbXECJW3ZF3t0H00lE6kU7m4VXgaPv0NIIIfSUV0TL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8332
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Friday, December 22, 2023 13:02
> To: Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>
> Cc: johannes@sipsolutions.net; linux-wireless@vger.kernel.org; Sisodiya,
> Mukesh <mukesh.sisodiya@intel.com>; Greenman, Gregory
> <gregory.greenman@intel.com>
> Subject: Re: [PATCH v2 05/13] wifi: cfg80211: handle UHB AP and STA power
> type
>=20
> Miri Korenblit <miriam.rachel.korenblit@intel.com> writes:
>=20
> > From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
> >
> > UHB AP send supported power type(LPI, SP, VLP) in beacon and probe
> > response IE and STA should connect to these AP only if their
> > regulatory support the AP power type.
> >
> > Beacon/Probe response are reported to userspace with reason "STA
> > regulatory not supporting to connect to AP based on transmitted power
> > type" and it should not connect to AP.
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
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tch
> es


