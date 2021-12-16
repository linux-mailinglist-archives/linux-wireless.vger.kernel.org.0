Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E73476EC7
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Dec 2021 11:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbhLPKW7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Dec 2021 05:22:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:14231 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230396AbhLPKW6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Dec 2021 05:22:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639650178; x=1671186178;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H7ERBq12BnRSC+STmq9N56QQ4dj+fXVy48ZLfL0H6nY=;
  b=IPAQCEge9CDN9moyjsXbnb6B90k8dT8E6SvXcRw7sNp83I8IrOIb4o90
   NprS8vnCRz4+afeK/CZFyap3HuqvGjLYWhJnLAWJVpMtp9hmvutStAW3o
   fl9erjo/lwKWW6JJ/1aCf/XuG6b5KUWQ1RwOrfmio3Bw6fnngaKJvDSui
   xyM+QEnugS70nZCfkNJdAFBfpQkl+32IxzH1ipa2Pfp0rgbMf+CXc8xJV
   wHcAzM2Ypcakt0wSSgRr1BKadKcFpNyI6H6qUQLkxFfhkj/p9MggmYj3I
   Qbo2Vr/j4rF5vHq7TjLdVCPKQu0h2/hOtYAp2t4Txhf39gaI/55qqTIvo
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="238195493"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="238195493"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 02:22:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="519191975"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 16 Dec 2021 02:22:58 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 02:22:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 16 Dec 2021 02:22:57 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 16 Dec 2021 02:22:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAaRkGpkID14S9TZk8YQdJjQi9tK1NqmK9seAEQo49rmIT/gLZUxazlmyuRf+8dTgCNa1dK+ijHn+oyX59WnHEsl2/lk0GGrnQFXgA7T1MKFSOdpHIGH+nubw4URTS8wnok+K8o5tLenpek/qw+v2o/ZLG/vKJ665lfNBGZ5QDoQTjhOhCuT2qCySngkavQ+NYIKX2iFUM3+9EdLHDShr5k1yErghp3DUGLH/7CS6xNkSPIfL847urN2w9wM97GqDAJkC5bE4rDw2CZQgoORFNIHN8xowxLw0BYn6Sk/mJ91u/0ivPHjntYU9ixeXi3OL9HYLplTbJ4gVEl/Au5LKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeLuGNpF8a02vaMETFeMwc5WTmYrxEE1+gI8zKjRMS8=;
 b=eXRnqg9bRHiKUMI/KOEj6MKljeiU3HIUBaLCrFpPlZbFgp/hIspDiblEHAH7RlgfgG4C/J5Jeg2ECwS6lXx+yHonmOiNZUkn6fWDWQq+1NjPuQ9yXraviVSWQN76umFaMHC9qGzQowSH0OFv4dUPMktk0kKqDdUsY13V/lfj9pxDtJXlS7mmbh2opjN8LqmPe5eQE+SExbTimt6tlf+M3XkiKw1uOCdTbwPe79ZAhpj2CL3ZWi07A/k4SDXu1iES/PNB54yzyLMhnD9T+cb61KEpZ0uItIzErT/SGBjWfxRkVE9weKEejwQadQqS+TiYWoNCAxQZXU4vTOvnTWAzXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by SA1PR11MB5826.namprd11.prod.outlook.com (2603:10b6:806:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Thu, 16 Dec
 2021 10:22:56 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::787a:2f03:efff:c273]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::e814:a13b:4bbf:ef2%9]) with mapi id 15.20.4669.016; Thu, 16 Dec 2021
 10:22:56 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [bug report] iwlwifi: mei: add the driver to allow cooperation
 with CSME
Thread-Topic: [bug report] iwlwifi: mei: add the driver to allow cooperation
 with CSME
Thread-Index: AQHX8mYmSrAbT6NOxkul+y9hEQ4TbKw06NkQ
Date:   Thu, 16 Dec 2021 10:22:56 +0000
Message-ID: <SA1PR11MB58258BFD4BC44C26F8BD2FCFF2779@SA1PR11MB5825.namprd11.prod.outlook.com>
References: <20211216101706.GA20233@kili>
In-Reply-To: <20211216101706.GA20233@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c401be6-b941-431e-ff09-08d9c07e06e3
x-ms-traffictypediagnostic: SA1PR11MB5826:EE_
x-microsoft-antispam-prvs: <SA1PR11MB5826307DE0C06987C480C667F2779@SA1PR11MB5826.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xoj34QhrGXRhOHoinZb8k8cT1PaG3TnR4OVNhm3rdX5udrjt8Vo16r60Iq91bIVgqc5CdV1LMPWBeXeLoFcAVuvzxWYYI7J8RKkDZ67s6Z2nrhp+QwBzrPC9eCOaKPeHubHfi2H5/1Ls7fxOWLUuSMmk1cda+mj8QZw3CFDMY06YRNKmiH59Ho//NIhH8aLt5eAOO14R6YdEAozedYVjyQcZp8yTA7fG/eiMC7uDz+N2x+smlLL4nzEW3chld8fFw6g3KJwV5K7fRUeDEe2+x53AiyE7xCSzjMijulWHhp4bql0WvFB1YB7+K9j9mW0qMRJV2UBld1eEJGtqJAqve75JDCMJDY1ZTHH07F0VxRbNLoqzvz2MjHv5Ug89WCOqeuiH4OkhFsMFkH6pPK4qrmNjTfj+Cr1roHb+DVA6l5GwVUPEePk9P5ClnibgBY0RjS/Fm9y3aSj4aV+70J4hbM6TKO0i9cUQB/9BdfQvkdq795ff8cYT1yFtoywnaYAMrZqMhgyW1n63y+08Z5C4PBknHHB6nroYGsNd+/jNySbHzKYkXYe9FcLA9vY3G5TmM/xh/txtbQ5+Zstbh73TPlEWlpeQI2zR+YBpTdfSHSSPMy5LnMwyn5vnw+OpbkrJdeRTv0lTdqK1HXjOUUV6BqI9o5QpR+5nIAc2HBFnH9QjeMYEHTwcJeGh1i7hZL0ncx59A6yHrSdRXByPN4yT8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(508600001)(86362001)(6916009)(38100700002)(66446008)(66556008)(55016003)(186003)(8936002)(9686003)(26005)(2906002)(8676002)(83380400001)(7696005)(66476007)(66946007)(6506007)(64756008)(76116006)(5660300002)(4744005)(4326008)(122000001)(82960400001)(52536014)(38070700005)(33656002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rjKYXkN5dojAkmOApv+mbqC2kLli5llohSDk1YwBStWrYOmsog+hjEDDClOu?=
 =?us-ascii?Q?+x8DvBQw7MRmgcK8a+HUeYT7yLx9G9Bu8lGcklHstAlVOHnGxIRASbnZV+Op?=
 =?us-ascii?Q?+xQ5KdAmZxlvm3jhJ2Ps7zs2rWzKTnF/uw35HCX4h4D37OCG+P2kugB+ddMn?=
 =?us-ascii?Q?SKrUgM54kgcixyv2EfFqlniewwSkZq/2Hn7P6wIrv6peCdcsTLC9l4e6BBgZ?=
 =?us-ascii?Q?Zknb5ZAU5yJg4TWJuWScx5HSaFdgiF3SbFSEdB6cLLhfAxk+1UAHhmt9rwRb?=
 =?us-ascii?Q?pgBwnY05OvVdBaLsGwLTK1raMqyZ/cDd97mwps1vwzlFQC30UHszr64GH0n1?=
 =?us-ascii?Q?ztyYWz5XtXVJx7wa3VKIYELznfH7QG1rdgVVnnrl4octLetUUJCeBz/cU2w6?=
 =?us-ascii?Q?X0R6YuJ06Q3HSk8qVIkyHuDhh2NXiAMQb750iEHusPggm3jO8hApASwrxqQB?=
 =?us-ascii?Q?5OkCreQdRv7DbacWGTtGV31y5n6/IgDryuMq1Ltujkjks0BMgGz1RDwqYdX0?=
 =?us-ascii?Q?ks+14FV80pvikCIFgLUzDTdvfBmJqIJmOqaQPKCuic0PcKADjpuAlrKQcvGv?=
 =?us-ascii?Q?JJUQJUw0apGhZFUAlvXh0sT5Txezo7HtmSeoUHSLaLrpKuKcQEIpCHXiOEIF?=
 =?us-ascii?Q?A9aCx/D6stNYzwh/O+tlxWLVft5CZ3fjs8BaLU17eYZ9tdaEJtja77AcrjFj?=
 =?us-ascii?Q?Mf9iAK19oOpIJZMD35YpGuC7P0yidQvQaoA4HoxTepFlWo/UYm70YrTwX+AP?=
 =?us-ascii?Q?xf27tY9ADsS2zaDIxAWjbdJg/4ODqU6+CxJ4CdKTl+Wz3pW/UrnyeBtlob0X?=
 =?us-ascii?Q?hRO60unYhlVPTZBpQYgvXWVRnduQ7GxAOLriDuVKLzNx6Hg/tNdBc7FiYdZx?=
 =?us-ascii?Q?56CgZGhE0Wy1eCUoG+lafZJhwOhqEJuMcijhL+V/289ahfL1Jz58ZNMBbquE?=
 =?us-ascii?Q?MsXIrQ23WP7AJ3ihwcFs68zcyXuAb8FYparewT99JRGlFvKlbdsPdVRsQ0De?=
 =?us-ascii?Q?0w+p4jimNF4SR3re4BIGfoOvLemG7cAvU+0/3L5toIg2zpgG3dNYEaHI3YMm?=
 =?us-ascii?Q?sCYLIW2acqTu4hOpADIVIYtc+NMa64DJGy791OXV+JaDFa/tPQn8gzdm/sqX?=
 =?us-ascii?Q?PScVOA45nZwYZtpC6LGrfuWlsFN3OK4NU50kKBh/8Z2byq0QlAtq2Zd807QS?=
 =?us-ascii?Q?C46V/YyZsHODRy2ncLlgCZ6RxnnFDdegggjRANAvoP0416OdgtXO5r+8HZu0?=
 =?us-ascii?Q?t1MW+dd7pywGI58JoMNDGXrN2etEmW+Hp1IS68//+SuDhvfaFZVmDbP1LlYy?=
 =?us-ascii?Q?wOe08bK5d1mUOGpKnQtvVY0trcdGetyWKDu/rtQVjmHSnUy8SVIKwJGDTQJZ?=
 =?us-ascii?Q?TQWmXbloJtyIIPLvYWUG1zHZ2RQF5fRPq36GamC9M8vssgKtbs5MVSj4Y2mJ?=
 =?us-ascii?Q?0QwAxngw3bnlQAaNqNgPDfSTlwyVEm5o+5xQNPLGEhPM2SeQ9JLbOjuvQfvC?=
 =?us-ascii?Q?UHKvEUWfoC0ARjFFl1i1XLk9wbviY/pgzs7Uf9txPCtpijyF08oe9SO1+GOS?=
 =?us-ascii?Q?Uz30qR8s5kLpExdR9kU+1rzHGSCcQKJurGhw4YBnLRECE1sth3V9LIA1EYdB?=
 =?us-ascii?Q?0J1MaQbCaTLDxn5gZMX6o29MRCBRJ8EhOUxWPHb54hAbjkC5wpKaGYYltw/9?=
 =?us-ascii?Q?N8gvmA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c401be6-b941-431e-ff09-08d9c07e06e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 10:22:56.2329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H5ELhOQMjYcXa7w+rZJg/7I1TOHM5qCaniU88h28g19SLwkRvGpLKXbi9LgCGz35SG25WSboernhmhcYAmfbZYSyoQE/7CnZ9g5QOgZsbPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5826
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Hello Emmanuel Grumbach,
>=20
> The patch 2da4366f9e2c: "iwlwifi: mei: add the driver to allow cooperatio=
n
> with CSME" from Nov 12, 2021, leads to the following Smatch static checke=
r
> warning:
>=20
> 	drivers/net/wireless/intel/iwlwifi/mei/net.c:199
> iwl_mei_rx_filter_ipv4()
> 	warn: taking sizeof binop
>=20
> drivers/net/wireless/intel/iwlwifi/mei/net.c
>     188 static bool iwl_mei_rx_filter_ipv4(struct sk_buff *skb,
>     189                                    const struct iwl_sap_oob_filte=
rs *filters,
>     190                                    rx_handler_result_t *rx_handle=
r_res)
>     191 {
>     192         const struct iwl_sap_ipv4_filter *filt =3D &filters->ipv4=
_filter;
>     193         const struct iphdr *iphdr;
>     194         unsigned int iphdrlen;
>     195         bool match;
>     196
>     197         if (!pskb_may_pull(skb, skb_network_offset(skb) + sizeof(=
*iphdr))
> ||
>     198             !pskb_may_pull(skb, skb_network_offset(skb) +
> --> 199                            sizeof(ip_hdrlen(skb) - sizeof(*iphdr)=
)))
>=20
> Probably this should be: ip_hdrlen(skb) - sizeof(*iphdr)?

Ouch....
Thanks!
