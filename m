Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EFA3E36A4
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Aug 2021 20:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhHGScu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Aug 2021 14:32:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:1116 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhHGScq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Aug 2021 14:32:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10069"; a="201694735"
X-IronPort-AV: E=Sophos;i="5.84,303,1620716400"; 
   d="scan'208";a="201694735"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2021 11:32:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,303,1620716400"; 
   d="scan'208";a="468213698"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga008.jf.intel.com with ESMTP; 07 Aug 2021 11:32:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sat, 7 Aug 2021 11:32:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sat, 7 Aug 2021 11:32:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Sat, 7 Aug 2021 11:32:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Sat, 7 Aug 2021 11:32:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjbXUJ32wsJgpgAlid9yeEpXn6vtGIynJnCpwHPxFE3d6+LljE7DhFBkqU7P5AR2IQ+21y+lpL8af68ylb/CRrIZa/YI2FeznNNPsYuv3w0jkiEaeM0gzRK7Fyy1dmHPxtHUQXa/N/I+SEHhQRU78tzLYqI4cTq46jJk9GlfWbMBsq+8WQlddB/mt9G9NdxXPD+l3JdtqHMZrV9kMUOl7516jjIexVlWIg/1oREktMoam/ui1xvoFyuI1Ho0HF9pamvwfv80qp1/8ukpEJ5rbN4DV0fz7QU+pbnSRMINjzqx8DgqgAhUdPr08areXj+dlmiloTsh1/UkV4TVN5W5jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7n/O7X//hrQygId+XI55k1W5j74XGWc/l5czv7C01U=;
 b=GOSIwuxk3Z7iSUa/NNr3TgU5TBqQaBiMCLqIQsbE+9VuyiZAxaXqj27oqj5elGZ83O5thx/GJptv7QhBxulSmBbGTzj/5Rr2xo6eFhD/bsJol0bzG85ezw5A4KQ9qMzXStdy+4g4QE04zvWvifPfyeDscUmJD3SSBJ7B6MAIle7MfnIHpjRx5WGrfmx1UOabZSeb4+N8Q9Uw9AOdnjX459VyoPo3yYng6W2EiJN97lIFTNghNPvELezL9HKZyey5aamQhslYn+AdcANxVOzOqNdFMgr+z6621zVnpj2yCaDHn2OLGsagCKgsul6OqHSE8l9lbyWdP8w4idFAzgbwbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7n/O7X//hrQygId+XI55k1W5j74XGWc/l5czv7C01U=;
 b=RRk3kn9oq1SEztfK2A9EzLRbBKyd0KWRgLYP/uvebO1O6RRZA/n/stYGAIxauvg9y71btuWILV+qspjqoKD/kEoda/fZlFc46uuv7HY7w4uRixLXP73OFHtr63h4Jaq6ZJ2rMOMZkPpGS73byg+QrtaFuQtm+IIZ15gECDliMy0=
Received: from SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24)
 by SA2PR11MB4986.namprd11.prod.outlook.com (2603:10b6:806:114::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.22; Sat, 7 Aug
 2021 18:32:26 +0000
Received: from SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::4534:c66a:f050:3486]) by SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::4534:c66a:f050:3486%7]) with mapi id 15.20.4394.021; Sat, 7 Aug 2021
 18:32:26 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Emmanuel Grumbach <egrumbach@gmail.com>
CC:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "Beker, Ayala" <ayala.beker@intel.com>
Subject: RE: [PATCH v3 3/4] nl80211: vendor-cmd: add Intel vendor commands for
 iwlmei usage
Thread-Topic: [PATCH v3 3/4] nl80211: vendor-cmd: add Intel vendor commands
 for iwlmei usage
Thread-Index: AQHXif1wGoEh3hgq1EWl9IMc9He2FqtoYGOA
Date:   Sat, 7 Aug 2021 18:32:26 +0000
Message-ID: <SA0PR11MB47521818C15629E58B99525AF2F49@SA0PR11MB4752.namprd11.prod.outlook.com>
References: <20210623141033.27475-1-emmanuel.grumbach@intel.com>
        <20210623141033.27475-3-emmanuel.grumbach@intel.com>
        <87k0mji43p.fsf@codeaurora.org>
        <CANUX_P0d0jrq9x99jM824oKOhmi0Wa5WqhECMsX=hd269H6atw@mail.gmail.com>
 <87sfzoc9bw.fsf@codeaurora.org>
In-Reply-To: <87sfzoc9bw.fsf@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7c7155c-9752-4f50-4d79-08d959d1b4ef
x-ms-traffictypediagnostic: SA2PR11MB4986:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB4986794AB77835FDB95E1E98F2F49@SA2PR11MB4986.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TaSTm9Yio91RR//PMDB2a3OuqdMpd7Mcr3DjZ58U34HNurioNInV4Ae/0UZfLJVt96VU3V5h5IvJh+wqXj8Yq/TnZFojkEGJlJls+f6ReB5mj/QGImz8Huto7vTH6gjv6E3trWltF62+mPXmvkiki5+va6ImD8SmzSk7rWP7/1r3jPdfk5UXw/f6xKYOvw1sBa58UUzTOSkg7KDp7gK4RyVD+1v1WL/H+OS7lkxpD7KDgZZ4jHy9ktI2hcSHoEkp84k5CS/aRHHRog2DZ3ZbugLXFvEn7Tc6mnHhj/3nDwvDDe7U7CPyUQHMr8lWPvfq//VG5NgL0ThIyhWVW5sDhcFhsYV1pI8ZzXtOmSZoy70MuKNbAxz69Lfw0kGYoe7F4amVaPKtVyM7T2D/4kOsrzZXY/ijf5Lquk/8TnMl/nr+w+k+Ab2ck6Wlc/CJob/EYdPfhgfMSfviMGot/zVHtfjCV4AvqTSX6LxhtjMT5vWpK+g4V8MCxXPLKRh5Ph38B/UjfXRwZlsu2ULb7X2q95u2a97vlq2Vm7BDDAf2Momu6htG8WQF3jFNLtmVs/5ab5ET7UXdT8txJtt6hEUuHuYhVx42AqVzZYImH5p0iUCCgOeKB/XN0sHSScOTrbwUz+74S4aSnk8xR6OweeUUxMik6schqcAV3u6cQ1YqKz/xKXc/WH51lWSqFWWLpn/NlriOT8xv0RkAjJojK9b9HeJxh8QMqwDF7ALczsYVKlIIplL7+9ULFEmXEa2uKgr3+QKK2K0EGW8REb8tKXvCPWEgx54AMNoXrzlfe2NEv9Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4752.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(107886003)(86362001)(2906002)(186003)(52536014)(7696005)(55016002)(53546011)(6506007)(8676002)(5660300002)(71200400001)(26005)(8936002)(110136005)(66476007)(66946007)(64756008)(76116006)(966005)(478600001)(33656002)(4326008)(66556008)(9686003)(54906003)(83380400001)(316002)(38100700002)(122000001)(66446008)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dWvPIhjkuJRinbhf5/kqMK4TjRshy9nsQA7ruwLYdbMInCWojxBs88v0CenR?=
 =?us-ascii?Q?iMvTBsJUuYutTExzhvIqvciemzTpoyjTqX0zOX5iFD+Uyf93Y+74KEq3D82M?=
 =?us-ascii?Q?wRN1jXL3hloXFi3uSVzZaeQrQNjF0ERXiJcFpbclzvahV66BZvKzMdPAiB20?=
 =?us-ascii?Q?dhRvBp4rGB3X4KodsjHbpNAhMIFYYRl+Fcajdr8L1TdDyB9jO5489FPBaP+i?=
 =?us-ascii?Q?Q6zQzX/ytBJnXK8THN3aj+PMA1jjLDVzKOf5f7W0JAP8hXcgawEqUOwj7PKh?=
 =?us-ascii?Q?qWEHZx68CmoMMnDpAzT4jpX6+82atrWWayAz6i01j9UPiO/sF+SaLT4484Eo?=
 =?us-ascii?Q?q6pbHUY/mQkb7eo9HLozE0dyWujBwlAmkq+4UxXmP8VpRm2ukRS6N0XB5xE6?=
 =?us-ascii?Q?vgyFDpZcRx36QkCuJIQkIK/DssRFA8CkAPZ9qbNCQ8rJI/v7CY1LHJ74Li4B?=
 =?us-ascii?Q?vVKx+Ahe5ZoYL5BkcZon6mKHRMHfem9n7xhbSVLiY12MjQYgl/ootStKhUat?=
 =?us-ascii?Q?CTtM0G9OB4R2kOcG6bPsXUSX369KovW5nprQnRn0f0rh+p7MsizwPsroqIZn?=
 =?us-ascii?Q?eT9eNOP1bxaVfre0xRN1QiGjANcXZ1I1pkHRlUeyLzq8ArUC4qhZJSm+i9xm?=
 =?us-ascii?Q?drT4q4qxKAf5mUJVULfa0Hg6EV+GPoSu0I5jobwW+0WYi0uJ/kHUEz5owYkr?=
 =?us-ascii?Q?H8mx2rBPlumg31mmqMJiqYg5LKKrsjM+qgVmKUT/j7rg/rCulVmgtyITaEMt?=
 =?us-ascii?Q?fECXXCki7pL2pUN2oOk0me/v/8RpwnRhheQEnms+kLSSU30l6FONfKHYRdQO?=
 =?us-ascii?Q?/7yCgClKGtD5JbJc4pTS5X03Yrv5DPxdnfAEn1AZNgD8Sd7qIkcwK9mkHDtd?=
 =?us-ascii?Q?ABAuyWvj4moedbqAZ0bcA7QTk/nEl25/zATjRV6q3ABVYOXNjTRgBB0D+MOY?=
 =?us-ascii?Q?0TVuinOxOnpvlATRK44nJclLAnVFKLkI0KRPmr6RdkS8kfm2wkbE1MmAP5pR?=
 =?us-ascii?Q?wE6B0SNdjmu9YdmrSkcyX2/+f3+VBgzzaaqgX7/WDUjftb0lGKLHHoNDFbBP?=
 =?us-ascii?Q?i3mPBd/K6AeaPcV8tT2+ZTEXwiascpSakVUFoGDqSjFJMGDiZYLHGxWHCV8a?=
 =?us-ascii?Q?8UrDzZKFGP2/vfZVAr1wUOxzTY8MdSHCz5CkEcV1GoLIJqvfucHCM+/low8x?=
 =?us-ascii?Q?VXDjM4aD8Zj9+s2N4NiZ6VH/iG20Str5Gcd5ACNze3TJ4mrreV0el57RnRRh?=
 =?us-ascii?Q?DghWNLiCxo5FdzkTG/d+/16GOISKTvH7/JEBbhQ3ExgcxNWzr8clXVw11m/Y?=
 =?us-ascii?Q?DfI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c7155c-9752-4f50-4d79-08d959d1b4ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2021 18:32:26.7418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: krfege+Vo7Y0Tp/D/U6xLNoougYbhN1bWPiX8GSlnyAljSM4lKoHQg0xkuWsmg8moU5s5iAjlLJZs1jHjV9OTErNjZ9TG77mNYObz6SsmOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4986
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>=20
> > On Thu, Jun 24, 2021 at 8:09 PM Kalle Valo <kvalo@codeaurora.org> wrote=
:
> >>
> >> Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:
> >>
> >> > iwlmei allows to integrate with the CSME firmware. There are flows
> >> > that are prioprietary for this purpose:
> >> >
> >> > * Get the information the AP, the CSME firmware is connected
> >> >   to. This is useful when we need to speed up the connection
> >> >   process in case the CSME firmware has an TCP connection
> >> >   that must be kept alive across the ownership transition.
> >> > * Forbid roaming, which will happen when the CSME firmware
> >> >   wants to tell the user space not disrupt the connection.
> >> > * Request ownership, upon driver boot when the CSME firmware
> >> >   owns the device.
> >>
> >> Vendor command requirements are documented here:
> >>
> >> https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#
> >> vendor-specific_api
> >>
> >> The commit log is not really answering to those. For example, how a
> >> user would use this? Or is there a user space tool?
> >
> > We intend to send those command from the NetworkManager.
>=20
> I'm not really fond of the idea that NetworkManager uses nl80211 vendor
> commands, sounds quite hacky to me. I would prefer that NetworkManager
> uses generic nl80211 interface so that it works with every driver. But I =
need
> to look at v4 to understand more how this all works.
>=20

You'd need to look at v5 which I already sent.
Nothing of this can be generic, because it is really Intel proprietary. CSM=
E can only use Intel devices by design.
It uses a proprietary bus implemented only in Intel devices (and not even a=
ll of them, only the ones in systems
with the vPRO sticker).
I already touched base with the NetworkManager's maintainers about this. Th=
ey asked the vendor commands
to be upstream in the kernel, so this is what I am doing.
