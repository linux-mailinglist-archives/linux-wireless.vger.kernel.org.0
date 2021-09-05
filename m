Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A8E400EB3
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Sep 2021 10:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbhIEI3f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Sep 2021 04:29:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:17467 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhIEI3b (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Sep 2021 04:29:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10097"; a="199288240"
X-IronPort-AV: E=Sophos;i="5.85,269,1624345200"; 
   d="scan'208";a="199288240"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2021 01:28:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,269,1624345200"; 
   d="scan'208";a="647386856"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 05 Sep 2021 01:28:26 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 5 Sep 2021 01:28:26 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 5 Sep 2021 01:28:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sun, 5 Sep 2021 01:28:26 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Sun, 5 Sep 2021 01:28:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRP6HNFxf0dTwszk8Gee8sYfzTnA4MRalSs3mCmgBTpb493k8lxYV0o3CrpKF8Ivi+iYnTZMIxDnQwdHL3RqCDzn21DE5HahX4dNdsMOCHlNmx2C4jXvARzcjzfiWpgFky/urmIS3q5Nom5P+RaPq4YDZ6N7Ca9DUZkCtn08cRI2WWeQ7Zp2ujAilQt4JiZqSBpsLPUzcEM0COa8kzY2rXLIK9AdTYh12pPOr+tZcK/dZbsb1VMgEXiTmr70fakGmBggZphLIoOYXgIwFHcTg5h1UUSFHHQ1Na2pIdZrQ1BqEgx3fk7g8u5cvDwCJu9BMpPu36svZjs9zhTgj5qulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ccxvfDd1RC3zdi0hyvAM46zcsgj9bBwHX171oTfYYn0=;
 b=lC5omYb/0VxiLoufgqI+uzuKYoDHU/lvpTtMzw2H+aJuPr+tHw0a5YdccIyojqe2rDrcSYhTk7MGonM3hNeJ+r9sQszGSTZc9KDzDFYpSkcgi5ODpYzoJMdltkMkzHhTBbypdB+3SN50kfiwgp8k5FLhCTeTrNxRz+pAuy4cSA4b8iLdYeDBlB8kYeOYdKV+zUSrivRLjj3qXKj1WZ+qpQJIEJC+J/pes5E3ThWhS2vQTB+9ATX7RQbAQ22ZNewFQrufWCz8cAWthgh2P2omJqwcBfqIg5rsIC7wEb6pFjyZ+atC/8q8rDKZxVls9fbWLHG317Wuz7DZfAmAFg0ivw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccxvfDd1RC3zdi0hyvAM46zcsgj9bBwHX171oTfYYn0=;
 b=wSiUtXQAM8f7z+jXgjgsagtfgI19zAVSewFViumE0cCnAvrXKFbSdKB9eLx1/WkRC0+4Z/KPMEl/kLaV/qYAmD+ExoMHdrD5KnYAg4mizmPjNPpuC3qf/tOFq2xSnK3NDbNfKbEl/5CCr82wGlQK+ySNQdE/mjbmnbCydzFLSGQ=
Received: from BN7PR11MB2610.namprd11.prod.outlook.com (2603:10b6:406:ab::31)
 by BN8PR11MB3650.namprd11.prod.outlook.com (2603:10b6:408:8f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Sun, 5 Sep
 2021 08:28:24 +0000
Received: from BN7PR11MB2610.namprd11.prod.outlook.com
 ([fe80::7068:8d64:d941:5a5a]) by BN7PR11MB2610.namprd11.prod.outlook.com
 ([fe80::7068:8d64:d941:5a5a%3]) with mapi id 15.20.4478.025; Sun, 5 Sep 2021
 08:28:24 +0000
From:   "Peer, Ilan" <ilan.peer@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Coelho, Luciano" <luciano.coelho@intel.com>
Subject: RE: [bug report] iwlwifi: mvm: Explicitly stop session protection
 before unbinding
Thread-Topic: [bug report] iwlwifi: mvm: Explicitly stop session protection
 before unbinding
Thread-Index: AQHXnjvyHBHrb2NRPk2mZQQclafsHauVIzxA
Date:   Sun, 5 Sep 2021 08:28:24 +0000
Message-ID: <BN7PR11MB261058ACB7D2ACD53B69D8DBE9D19@BN7PR11MB2610.namprd11.prod.outlook.com>
References: <20210831074305.GA11178@kili>
In-Reply-To: <20210831074305.GA11178@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29728597-d3e4-4cf2-fc35-08d9704720b9
x-ms-traffictypediagnostic: BN8PR11MB3650:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR11MB36504DEAFA3A4B0B520587A3E9D19@BN8PR11MB3650.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Js6aBgoJf+7bo0BayDYTNCXudZYFF4OApFUM/PaF5Pfvp1PAeG6/9Grmw89h2QnPOJpBqP244Z55qnvl+SWEnPGvl5Fi13+i2NPVnMEgjo9WZE1M36kTm7wnBlseU0bTGhHmk341wD2RDhhK2rhNcSztEYJsT3cIIEbqIPpfeaq7VeU/Bm1UiaxBTa1AeBx2kyTTr60kSxS6OxlFjl6VTzWbDaw6e0DIxhfzvSjoQOw6RUe9GBhp11VeQ9mqQdfk7XEnPjfCaobnkonWanax0QnrxB7INyuXpZ8b9D3t8Wrr1cks7ZTeCrVJYZ/BvTSbU1Gt4MrGnZDN7DEHfTWDgk/rE8Oq6uM7BdSujls3CXEB+hP9ZkHIAchLDMymC82qzBVE/NoxNEXLH3ZGAKXvZoMS6WhMcqPDnPzVOu4WMX0x+OAm0UGSdYOMBdINIh42wQpamyIhZFAnIoZnd/SY12zp/nMQAlm9OnNVGxpL1XG30shHMdgO6BjWd0Lzju0oQRZ05KqQCBaFRRUuTW14ZgEP9QGv80CFjPyT75gvAUsKntREbEDspF2iHKLxwmdJ4pcUPWIlJncjQFglGpfNeyY/MzKA+WL8sXUTUsEDkSwSWa/4KznYOEel5ltGSwxP78/6VcB/ga8hpL4zS9Dex6JenoD7CwnvQgX0EWk4b4LzFvLY0HXDUU7l0MS6E0lHT0S8gRH4ORKn4iFc7p1QA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2610.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(8936002)(38070700005)(186003)(66446008)(71200400001)(64756008)(66556008)(66476007)(4326008)(52536014)(26005)(9686003)(86362001)(66946007)(83380400001)(76116006)(53546011)(6506007)(8676002)(55016002)(478600001)(6916009)(316002)(38100700002)(5660300002)(7696005)(54906003)(33656002)(122000001)(107886003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6HVKUSefvRTXibrI7RajxkCcgDFIrbXmR/jPIQeNVLj72goAxdWsAULEVH/a?=
 =?us-ascii?Q?97vG4dykdXTieQWo7szXPfcOPs+cYoFLVvdCmU/4i5Y/yDCEJnNbeOyozCn1?=
 =?us-ascii?Q?fmMPJ4NUeGz1QZYN/969s0hx+sKez+y4k/zz5fQt54iMIqXLBHVvn3F7qGxF?=
 =?us-ascii?Q?G5GjEKns6QraqeyjZkiOflU4n/7US/CZseXC8tUZdY06gADFJkibDqrFtENs?=
 =?us-ascii?Q?FIdEZ8l0yABPFCMPe3eHIlws2MYrWAgRfwwXEMQRcRKShs5mVf4FC85fL/U5?=
 =?us-ascii?Q?aqggJVnvhuOL0CdX+JX68y/3Afwz8aB8yiePrLIYu9rav/vGI6jdEXKCOYAf?=
 =?us-ascii?Q?TsQH39oVa+j+BIZEjb8WNkdXM3L9do8ixb+pV4FuPqogZchb3gXj35B15LeC?=
 =?us-ascii?Q?AEMESKI5tZaUzWJZ9t/zNKhMeZ+0y8374LwtAl9EPz5fj3FTgu6ZXRDfuhy9?=
 =?us-ascii?Q?BLr4E/OZbX2QzzPs/H8ydK/CRxkoEdKSk0eUvm1FlFGIVJW8wYeBW5g6get8?=
 =?us-ascii?Q?B0FEDOYjup6DCJ0r86fi4Rva9lCi3VredDubwnn1DOUrC8xdL5CM2XoG7XrW?=
 =?us-ascii?Q?4Z+3fQtd7MKTrWnMi011w2g/kfbAtQYgHKv9H9lQeEsZ2XjHxA8bIl3sSkkA?=
 =?us-ascii?Q?56jOTGDENlYD7HZd76teujoT7t0/W9oBNgNPO+RKVNFdOznsG/sGh1fU007n?=
 =?us-ascii?Q?Ym5AtQNniEpH311hPiaFuoMsjbbKlr5Egg1KzkaknExg3zKJ3U9CDg26vUnm?=
 =?us-ascii?Q?9SiOqR4CVRLSBJjDaUC5j3KjqrgbFsllO8XQLdJOPDnuOuaN4ohoJWw6wD1z?=
 =?us-ascii?Q?8E4ZlNQ94SsMj048NIM8FFVsF8CAEJFjec9s39iNKpEsMShvcIF6gf9KelmV?=
 =?us-ascii?Q?JG4/4RTcrn+9p375uvq2tOhkNHCIWn9RHCNPoCKKzyZRggiqEe24ScYs8wIu?=
 =?us-ascii?Q?op94xfbp36dr8m1eYW9S72hv7AOp/VI8NECE9I1DUkhTsxv2oisPokHV+Opn?=
 =?us-ascii?Q?GQ9fhUyyKnkUx94bAaEBDm6krBPxxTrGdlynStQWzFEq6R4tSPwVl4HjFDgr?=
 =?us-ascii?Q?M6JRGGYnAJSTxNf6u8EBQkyC4IYbj+Sca+wXjyPofWnE83ic13KK8v3/bxGm?=
 =?us-ascii?Q?BQQTzHdvTjVpV8jyZUILVanr8bT8dpomNQHaEpXCACzesY05v6VAmqWEmMM3?=
 =?us-ascii?Q?RJKmYtoxEqmlPzAlrD5hthDZw45NIyqFzwSlg/ngibYVmdGnc5+WPQQ13hxB?=
 =?us-ascii?Q?V6y+IivfD6vV1ORtShx2nwVNQRfbQvqDBeXlB1YSX4BOSMAt7nUd64hLsH3l?=
 =?us-ascii?Q?hiKcyah/WZS8tVGrJX7X5dSZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2610.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29728597-d3e4-4cf2-fc35-08d9704720b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2021 08:28:24.2395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CddyoXn/9T6Ynnx8RtYat8mqChRaJy+POq4mln8wCP5tlImI4gw3WlN68g4Az7wUJ6DhahKI995IX6+fYfzU6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3650
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Dan,

I'll prepare a fix for this.

Thanks,

Ilan.

> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Tuesday, August 31, 2021 10:43
> To: Peer, Ilan <ilan.peer@intel.com>
> Cc: linux-wireless@vger.kernel.org
> Subject: [bug report] iwlwifi: mvm: Explicitly stop session protection be=
fore
> unbinding
>=20
> Hello Ilan Peer,
>=20
> This is a semi-automatic email about new static checker warnings.
>=20
> The patch 7b3954a1d69a: "iwlwifi: mvm: Explicitly stop session protection
> before unbinding" from Jun 18, 2021, leads to the following Smatch
> complaint:
>=20
>     drivers/net/wireless/intel/iwlwifi/mvm/time-event.c:668
> __iwl_mvm_remove_time_event()
>     warn: variable dereferenced before check 'te_data->vif' (see line 665=
)
>=20
> drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
>    664		u32 id;
>    665		struct iwl_mvm_vif *mvmvif =3D
> iwl_mvm_vif_from_mac80211(te_data->vif);
>                                                                        ^^=
^^^^^^^^^^ This is dereferenced
> inside the function.
>=20
>    666		enum nl80211_iftype iftype;
>    667
>    668		if (!te_data->vif)
>                     ^^^^^^^^^^^^^
> The new patch adds a check for NULL, but I don't think it is required.
> The kernel would have already crashed at this point at any rate so the
> dereference needs to be moved.
>=20
>    669			return false;
>    670
>    671          iftype =3D te_data->vif->type;
>    672
>    673          /*
>    674           * It is possible that by the time we got to this point t=
he time
>    675           * event was already removed.
>=20
>=20
> regards,
> dan carpenter
