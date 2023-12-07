Return-Path: <linux-wireless+bounces-534-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EB780854A
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 11:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B60D1F20FF8
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 10:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF63B341BB;
	Thu,  7 Dec 2023 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bL5HCI0r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D7CA4
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 02:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701944190; x=1733480190;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9mlkSzaqIf7sNRGXJmxsY7HD2xmV8WHkJk1WzIcElrE=;
  b=bL5HCI0rSs7RQ7iHVQmmbeIXlyd6oW+EOmF4V2FKar/InUezHHNFhlhK
   5a5vUDyduWnIQlzmjZ/sIEPh+V4QkkhdQUF8IT87Q0Nq4E9LjF7HM74NW
   VzWUtmRxn0qK3WXsERmwhNDp0FuOw0bHONO+Hh1STHfMG/OLU09ZFts/j
   0c9uaY/8+XJF93cFrx2u36KG2TXy3VRuEDhl1Rzi2bUNmvcnUlQl9ORGy
   SHBKht1wCQ0UZb79I4o0MPyakVPTekpkF2wA4sf6kI1cMec7Bxi4MgwBj
   ARG3uVFLxH3qKn9vuVEDlZ9OOG8AAJxMm05wY53Gjotz9PpY1S3xMoqN4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="15757415"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="15757415"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 02:16:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="747922807"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="747922807"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 02:16:28 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 02:16:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 02:16:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 02:16:28 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 02:16:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZ1AvCwqMrrf3cHbi1WWCnBSu+9IJx4HGPNrt7DVeubThFNNku9F3zN2Mm9ZzaGSUSkl9pCzGFmKYgngAZAKhDXfqvC8MKtXTkQLEx+R2jlQC8TaAbJYGe+dWM8tGxO6kL4QLUIedav6rLIcgZn+jU4N/26nFddEbk+0zsqp25CSjul5NRGoK4aOJwTMw6dQbDYfOJqjwmkgS0C6651TKFWLqFuib76JGEgkiAVIgsFQl/wJ5g951m3rACkuYbNmqm78RAnK0Geql+vPaSLAnTeCqxhk0Q85cMmyKgklKvU545I6nOGQt5b36xE4sUmzTM8U5tpx4AOtwm30hiAlaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mlkSzaqIf7sNRGXJmxsY7HD2xmV8WHkJk1WzIcElrE=;
 b=n/VgkqBPZeCgMrHPkyIeOyx2A2Kbwbd8VYp+y71MXcBC1yzKLA3WvOfy+er7cuLaCAtOImPv1PyJp+ItC42PM6nMiHis8/a/5kn8Q8ZQnluLi/sc72YnRRDlMgGPIAy+DUlmK13bnGDmHbsKUygI/17wH2n6Kqua6pLDPUCkTfHlEjeNQd8bWGk7HLKPqaFjz6gQApgRIigJ2nAhqLklL+SIQWemXqx221nioIUqvgs+VcZl28VLG9kstHlfdHXgFj9a1kvv8f5wTAkynf2glh8Rm+8HUxeQrsQDzDuzs0SCLrRpNeU9YfTkrYcz7vBjXpn3Vic/M3DJQoBQ50opXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by IA0PR11MB7211.namprd11.prod.outlook.com (2603:10b6:208:43f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 10:16:25 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::94c7:eefa:414b:4757]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::94c7:eefa:414b:4757%6]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 10:16:25 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Paul Grandperrin <paul.grandperrin@gmail.com>, "Greenman, Gregory"
	<gregory.greenman@intel.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Kernel oops in iwlwifi 6.6.3 with AX210 while scanning (looks
 like firmware bug)
Thread-Topic: Kernel oops in iwlwifi 6.6.3 with AX210 while scanning (looks
 like firmware bug)
Thread-Index: AQHaKKjeKmI7awjzYUiWBYEBCBNLPrCdmicA
Date: Thu, 7 Dec 2023 10:16:25 +0000
Message-ID: <MW5PR11MB5810C544ACFD6CB471A1CF1DA38BA@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <LSU95S.IM9H1Z3FXUAS2@gmail.com>
In-Reply-To: <LSU95S.IM9H1Z3FXUAS2@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|IA0PR11MB7211:EE_
x-ms-office365-filtering-correlation-id: 87b5c912-0e0e-4260-e22b-08dbf70d917d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UyOdI0S5iQDC/ktwYuvUg68vy815P9q/jHvy+UkDPFT1LENuWyfH1JN4Y6OAOFgLFbYqIHvKNOSKfeF4uMKPPn0GEEpuMAp702DiXhvALhSpUpVEAsWWGYuC5CFcTMpSEjYmL9ID1lRh15DMNtutKZpzzRGsUEqCxpgY15YH5DWWhbV0LzXIL93ioatjTNH5SS1E+tlMajuzqvdT+EmU4+/4UGx0qm+VFr3++R42c/PGPG7p1Hbp7VVU/axB/7IvSKQv3YeoCf/MZEEN2NXZjku60+Zw0PsA+S5NnHclQ7kJZSzdplWSP+x3xEey9gMYpknCde9QSQttJA3cmcdJGiPtm+MpgqqZwar+b8NhszO7nSBsDCO7w407SDUF0hKXDt6NBjAeF2x58uTtBTjob+tssLWeTG39y/lAD893bk+pVKZtpKHyo04suH8g4PxtN8O944fF/zfsGfQntGjQq2h9oDW1EOz5cyobn669Q4FRIlyLtHL78G7/qmuqkUtJhnSndhbZT4uZTpd/v6s1ozrGe6Z9XDdMJcQzgm2g5Hbwbsp4JBxm/nqTDOkRUv+9WSEvZ2LHyG8/enUIGllm+8T6Qizv9OC3pIRH9ihCGuE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(2906002)(41300700001)(122000001)(38100700002)(66556008)(76116006)(86362001)(82960400001)(66476007)(66446008)(64756008)(66946007)(110136005)(71200400001)(478600001)(26005)(53546011)(6506007)(7696005)(9686003)(966005)(83380400001)(8936002)(52536014)(8676002)(4326008)(316002)(6636002)(33656002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sZL9MO/lijRgqMkNvDIp5vnnFdomEGcBQClvMdqk1awMsjHAOnVFZy29eLvH?=
 =?us-ascii?Q?PQ7urrY0tIuiEJWqH5nRL1meVbRr5LFZbB3nf7RDSL0loA4VYrv+h3q9JTjH?=
 =?us-ascii?Q?g8wEPJgqRfNtSSxzcRoqcYVjco6d4DxD5NEs5i30bcG2F/q0jTtc8Tx6f9n4?=
 =?us-ascii?Q?ziAOfG9SsqWXfQIb852G+cnzpwQ0H+hgq8i+kmL7JarySUFoxPLCm3KZIxoG?=
 =?us-ascii?Q?OE+xSI04I8abPT9csDpSeiCbEKCHWgk6NKowXcY0I468UxDumHOD3sCOxkth?=
 =?us-ascii?Q?XmdEwHCJlao7nMRSl5dey81dILuaEuwdVKGvqRskZMq+jxvS+W6fhhhbtXwv?=
 =?us-ascii?Q?zfZx5FNiaguERrFsKFzLXXFVWiubm907dme7OfxShBHY9AKihYa8ZN1aUeb5?=
 =?us-ascii?Q?Llm2k/fZll0qpMu9q/qP8SPHjHoCtiEkB87XMJsov3l/O8+hZCkeIqjybkLO?=
 =?us-ascii?Q?PEFAWuM2E8Y7I+yff2cLT4i9fncYjusurJdtpFMQN6IAVtpt6zzdZQGvtJRk?=
 =?us-ascii?Q?mv/ejNGH1IOY8lVpFlG47/x3gRkLPrx38MJduWUkuFmu50WFVrRDfFbEa/Fp?=
 =?us-ascii?Q?aU+qwMJ+m3atrISQeyU9REEqrOhaJdGgTS3qluyTdxGYM5WhQ+70XxAd96pl?=
 =?us-ascii?Q?JYkQYEPcZi0Ulu1KR8ql9f3XiVlcrkJH4+NUKwitcd4lkffN7+48csUh1BJ7?=
 =?us-ascii?Q?CXawJprx6yMAID7AZwglxIsnLgk9oBUVbnX1KO8HhTvx4D9sSLI+GRTsIARO?=
 =?us-ascii?Q?6qY270EvbsT6nQ80YVic/h8La0xl159xvAiRlZVg8fi/9P/MVmBF9z5AyJfh?=
 =?us-ascii?Q?0xKipK40y89IxuHxaB7VaSw1MRmJtzjb5mZE4+ShpX/GXLQQSMDOU6UJkkSp?=
 =?us-ascii?Q?/lDTl9LOMbx3nGCgjH/X9eaeK2u/XEgTcqnmtYvVJsqdR0vcpPMg6uRrBQyu?=
 =?us-ascii?Q?nO2nw5BZk7t/olIhVMqpudiZ/ehWYO6xRksS9GOy3OS/A/orvWbfvxa1ZOX3?=
 =?us-ascii?Q?OYnwus4VMMlOSTF0DWDbAOBjkXcUMRXxn1PpmyspadXTUBZSC4nTwSUvtilR?=
 =?us-ascii?Q?/EPmfsM12XrkSv1YE4D1rGE9n+SG4Vt6vd+tTpRcy+j5yfFwgyLQaB25ejmL?=
 =?us-ascii?Q?3iVafrLRQ5FuctXxCR1bJuXgCpTN1qWUgaZAyfTPj/KlN9h7yzqlaxUssTtA?=
 =?us-ascii?Q?VXTwAu1lVftmRGcNCtDKm28RfNK3iZE2zX+YU1za0dK31Z8DcwIbeTfFmrqL?=
 =?us-ascii?Q?HV0vS3A+PsdXcuXgoDEkEJA/YMk0lL8nArQi9ukzi8VgVwfUjTnJ1gwaDROr?=
 =?us-ascii?Q?xv3LAtcIaFViW3CVbmUw1ZlP02R8tb+0MdXc72txS9XPEaT9nfQMoi0k14ei?=
 =?us-ascii?Q?/0ssaF6mBMAQFXBMMWBBFpo/w+La687AUiI8Mu/TZsi41Zfqg9A78tmIhjYf?=
 =?us-ascii?Q?5JwacxfxDaaJSOwrHraB4kI1m1o/yR341DJ0G3k82laA7evdbx9SyHt7aQzb?=
 =?us-ascii?Q?KZi8NVHCldUegGZxQwbPIoUZ83dXQiKgYSXFLam7+reW2luCcIS6kqO49t6G?=
 =?us-ascii?Q?6SOUDkH/tahzQfkcm7fwAXQWvfOWIAWkClisKz07Lbtc8XSIvwdzJBuBxLnb?=
 =?us-ascii?Q?DkChk47XtEFMipdNlnJgdZ8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b5c912-0e0e-4260-e22b-08dbf70d917d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 10:16:25.0191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TigMwEnvqw92CarLliDzRpmVXzVr5zrrqpGh4cRoSm+1GpeCf8aCYoiuPk80jK/LruJ9WT4RbfWhVsIwuZUcuJeNAriEjMFeMlQLEpj5EAFsDMJFFvv4gtFiygLafqzk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7211
X-OriginatorOrg: intel.com


> -----Original Message-----
> From: Paul Grandperrin <paul.grandperrin@gmail.com>
> Sent: Thursday, December 07, 2023 03:00
> To: Greenman, Gregory <gregory.greenman@intel.com>
> Cc: linux-wireless@vger.kernel.org
> Subject: Kernel oops in iwlwifi 6.6.3 with AX210 while scanning (looks li=
ke
> firmware bug)
>=20
> Hi!
>=20
> My system was running fine, no errors in the logs, and then it started to=
 happen,
> an infinite flow of oops in the kernel logs.
>=20
> The bug seems to happen in "__ieee80211_scan_completed" and it seems to
> involve the firmware: "Microcode SW error detected. Restarting",
> "ieee80211 phy0: Hardware restart was requested" and "iwlwifi
> 0000:02:00.0: FW error in SYNC CMD SCAN_REQ_UMAC".
>=20
> Since then, the iwlwifi module oops all the time, even after unloading an=
d
> reloading it.
>=20
> My system:
> NixOS 23.11
> Linux 6.6.3
> Intel(R) Wi-Fi 6 AX210 160MHz, REV=3D0x420 firmware version: 83.e8f84e98.=
0 ty-
> a0-gf-a0-83.ucode
>=20
> Here's the logs attached and more info about my system.
>=20
> I tried very hard to get decode_stacktrace.sh to works with module symbol=
s but
> the NixOS file hierarchy makes things quite difficult.
> I can try again if needed.
>=20
>=20
> Sincerly,
> Paul Grandperrin
>=20
>=20
>=20
>=20
>=20
>=20

Hi Paul,

Can you please open a bug in Bugzilla, so we can handle it there?

Please attach there a sniffer capture and a trace-cmd log.
This is how to: https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi/d=
ebugging

Thanks,
Miri



