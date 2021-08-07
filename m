Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E67A3E36C8
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Aug 2021 20:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhHGSez (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Aug 2021 14:34:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:56432 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhHGSey (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Aug 2021 14:34:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10069"; a="214547898"
X-IronPort-AV: E=Sophos;i="5.84,303,1620716400"; 
   d="scan'208";a="214547898"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2021 11:34:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,303,1620716400"; 
   d="scan'208";a="502321358"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 07 Aug 2021 11:34:36 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sat, 7 Aug 2021 11:34:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Sat, 7 Aug 2021 11:34:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Sat, 7 Aug 2021 11:34:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gu1ILMpgV31QuUCh+07CXUvMpWsKtGXXP2zcPNgvjn5oSl+KMXatPZQZBVtRwggEmKuC+hynn+xaIuAaHdExQEqNI6RPhDEYRut1vE0C9xbmcYi1cXhpfMigsaozQXx5Ygf34+jfat9RDHLceRe4hVIs3B6g0tL3EiTKny/jyDliJfukwJjrqE18hlRgfME7H1u35VaY3QZGh6izB2UW2kF0LTcDG/fCII1gztN51K3RiOE7zvAjXvgP83aLHTA+kyNDz+cxeojY9RX+vyfx2cq574na3GRqv5f1KTYrL6l2jv2zhcJse+8wspnz1ZEcGMW6Bf/YWQ0VINkDS4Mliw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQOR5S1ZU7gCN5eQ5JASZSaEl98egeUVIvXGzOuqNsA=;
 b=VhNxJyhEFNh+tLCkKzsui42kSkJz+cNoKzal3qY1MKa5w55B5NMH1QCNciL+jibyDM1ZJLJ9qzd6Nj+giaM5lDs98yQeChYIbanzGe12HbuQoozv7onXU8wzSVAlFxJw6kAIJC0iK/GQj/Yer/PuyjMG031i9OwYR9dWuKfFfZ+1tCU8G0Tc7P4tgzsMTPoMRKAw0cf2+PYCiOYsZ5/g4k1u4NVguPPlhQGto4SzpuVB6xdeW0IfJfPBp6xc99pkpi9tga9bBwuG0eS4HazY4jdTTje0DfkVNn0ckI8G46h5aGji7KMHs9leP9CbCtmxSIrYz+slQMPOX/IyEg5YZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQOR5S1ZU7gCN5eQ5JASZSaEl98egeUVIvXGzOuqNsA=;
 b=gr3srszYidU6XxBbYqrJ+uKeUW+GybgAOXcxH9XxyrfZuhLPNvdnmsTHZQSB4OCIz5qLbPfhlpSKISsEhIR94yjY+GIyXUAnpQ8Ufj1sDagdYwzuiL2R0Pa4aqezgzYRkNY25FYqZiuOqLHfHvO2tPn2n9BhODRoH84EalKmavU=
Received: from SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24)
 by SA2PR11MB5017.namprd11.prod.outlook.com (2603:10b6:806:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Sat, 7 Aug
 2021 18:34:34 +0000
Received: from SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::4534:c66a:f050:3486]) by SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::4534:c66a:f050:3486%7]) with mapi id 15.20.4394.021; Sat, 7 Aug 2021
 18:34:34 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Emmanuel Grumbach <egrumbach@gmail.com>
CC:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "Beker, Ayala" <ayala.beker@intel.com>
Subject: RE: [PATCH v3 4/4] iwlwifi: mvm: add vendor commands needed for
 iwlmei
Thread-Topic: [PATCH v3 4/4] iwlwifi: mvm: add vendor commands needed for
 iwlmei
Thread-Index: AQHXif7lxFnULUNnIESM18ARXXkclatoYS8g
Date:   Sat, 7 Aug 2021 18:34:34 +0000
Message-ID: <SA0PR11MB4752D9B34C2A60B85CA3E5F3F2F49@SA0PR11MB4752.namprd11.prod.outlook.com>
References: <20210623141033.27475-1-emmanuel.grumbach@intel.com>
        <20210623141033.27475-4-emmanuel.grumbach@intel.com>
        <87fsx7i416.fsf@codeaurora.org>
        <CANUX_P3HWWBkeHHSw+-wdQEBFNF1V+GWRDFiEerH7NhksRvOzA@mail.gmail.com>
 <87o8acc8v1.fsf@codeaurora.org>
In-Reply-To: <87o8acc8v1.fsf@codeaurora.org>
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
x-ms-office365-filtering-correlation-id: 1cb430be-be12-42c1-99f3-08d959d200e3
x-ms-traffictypediagnostic: SA2PR11MB5017:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB5017A996D5510D3C70F7E59BF2F49@SA2PR11MB5017.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lPn5MRxECykaiaZmkXMI1tF2HTX1jO6D2qBrBvKkotx3AGMFAQB+pcL5u1JPNVnjC+XW07DTdg4w8oolA+XpDmu+nxPdcGpC4XyxwCEr7O/sUyrH+RG5vEzXJMuuxnyIcMQtnbnonjIf/dIIJnHjQvsca2Yq/qSetjtMzZQdCU/zXo8JsgMEEeuGbOisJJLW8BpzlC22RFMbYSWqhoHH/+4yyj36zTicT0h29MUTlJHFyQZRN8rTiRiTtzJbC0EFut3dMqVOWs1ElH3IVkbT0qIP6EpnVQUARkZwXpNtBZ2Q8hf267Ipq6NmZF3fW0I7grC8U3HukgaRqCgzV8Sfol9nvvn6CcYf1xJw10Mk0lGo6qZheZgKexJuE1naiz50GngHRgZQ59gejv2d0J/WEPOry8AmnhNQWlKCjeieRBT1vMUqRZXpPKhX6YXAgk9R+yB8XONokYhRmdQIdu8j5sRHZ9mx69RakD29lV6OVGc3yugmw0C27eV+XUc1Ot7g9x7wfDRWMz7FM2qsJ+xiGULFs44AuLyILbgXBODeIhvJHtvo7l1VGrMsQ/GhTfso+kcdLa/QRHOU2m5iTJNXO7YALuGeR7PJB/y6f9UJ5lMcu6msXqyF67+9HfU8KMWMqPbEbrVyaY92YlezED2BtGIX5gyCdBjGzbud6z/uAHOEvG75Hde+x/dYMEuQYkgA+hDXhAONNFqnOXz3mWAy8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4752.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(2906002)(66946007)(66556008)(76116006)(64756008)(66446008)(53546011)(33656002)(6506007)(55016002)(316002)(508600001)(5660300002)(107886003)(122000001)(38070700005)(8936002)(54906003)(4326008)(186003)(86362001)(38100700002)(52536014)(9686003)(83380400001)(71200400001)(110136005)(7696005)(26005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JcUwZHhjfvpv4Bg3Wexg/kNWeXNtukA39QMBMxg0cN7YH4siFn6FWLl6CjzD?=
 =?us-ascii?Q?1CTfKdQ5s/JxwglqjvkIQTml97oTCBINPzGWSoYwlKfgwe3ytE9Jq5wI1y4M?=
 =?us-ascii?Q?6nKdPmbsuST/4Stdpieg0NHP1Amf9O+r6Oo45YvHA5zM13h6lFNl+JxVS5j3?=
 =?us-ascii?Q?S5xO952VOiPoJIeNI34SuLt9JCCB8QSoPdMBPYSs4k9tqXJa9XHpDhvohx7p?=
 =?us-ascii?Q?INwx+xyhsVz2/Oyfj6om0sMDYRQiw5zjYSbBPgR1gOLx5KgKUNJq88UF7uuu?=
 =?us-ascii?Q?JvRYXS8HpsksVEvI/9ydH5V078pdBgWxtcvevmIns+FWWFia/ZGQKZDwknJa?=
 =?us-ascii?Q?4IokGNZpWSISy0OIZF6E6DL47pBC5G9+3/aldd5vrzYQ2TPajBs5ONb/1KE1?=
 =?us-ascii?Q?KiSKrozHjKppQwIcJ/M3ruWmvkR+tH5PaSHNCUTsSI7j4BSffkz8d+dTjbRs?=
 =?us-ascii?Q?x7rF5+DZLGzvv+AjdqFvJOaB0XyBN0CictpHRUASNEO0w0elqpDmsQrZWj+R?=
 =?us-ascii?Q?ftmNeZel+syv30N5GWqJZyt/PtONZC9czr+aMqtiU8pNC2J9KKmvf6Jn6/N8?=
 =?us-ascii?Q?oe1hCV15lF6S/qZNU+6Y0rJy50mnlOktVtDfJSlzL05j4DctJGMwq4WdamrU?=
 =?us-ascii?Q?vlC0RnhdgnBc6QPMIEqR7ZOifILeJQAndXsescVAZ4S03rAGC29Q7ky6cYAd?=
 =?us-ascii?Q?plch6RBLYjXLmcZkjlmXM9Ut5xI3CvstLDAAgON/fM5D5ieDK3PagAuFRrea?=
 =?us-ascii?Q?55LkRI3ma0/LrmayfI21YqaonGvdYm4lwlOgHO+jx3ZgSL9piz0yU21GOYfK?=
 =?us-ascii?Q?6B5llllduxaZP3kn05jkDPO1OcWV9O83L7lc5Kd0aUQegqaA/7RBSNM07f9V?=
 =?us-ascii?Q?Hi7TamFlRErr1aNQZWgreuP5DLRHQzVjHqfsHKKndACDkeHuI80sq88KdHSD?=
 =?us-ascii?Q?jjRY1tQfMI8g1BCNrckjJWAmNCHxGfJHBa2WtH2cgEdb4+ZBdmO66b0OTYRM?=
 =?us-ascii?Q?TN5DoB9g9RfFBpdpfF++cbgVVV+HAhvyX2IVApkhpZb/r1qdlhNpGRyqdIlN?=
 =?us-ascii?Q?mYJxybiPl4jLUxYZ0StqHg/GaZEYaxyaW5ryEJGY7mH5kzabCH1Iqy1ThIyp?=
 =?us-ascii?Q?rn3dYnCyNeZ42y20MKtjjWj2mmpts2ifVWbFbY8hdI/lPRdon+FSFl3YYxEA?=
 =?us-ascii?Q?2S2/aIGhvL9TRF/S5NhgeXOaUOe2H1TSG8ptKg383laV/e3H1uNUHuza6hrI?=
 =?us-ascii?Q?uk9EqA/5TIoSND8dNACBXiFCIePYt5t2Mth3tvL8hlr11pPHWnPKJ+gTA8kU?=
 =?us-ascii?Q?vneKbmuuctezW+z07+S0MNAq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb430be-be12-42c1-99f3-08d959d200e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2021 18:34:34.1032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c6gLl0S38YKt9z6E3AJ8jbo+Y8zNgCj8kcDH2e+Sd1lQXS0w7IEYn1FuvHIMaXpiGVFgNFIJP4ifh/2ty0OQBwuXH6qUdjC1KasVkx67dJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5017
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

=20
> > On Thu, Jun 24, 2021 at 8:13 PM Kalle Valo <kvalo@codeaurora.org> wrote=
:
> >>
> >> Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:
> >>
> >> > Add the vendor commands that must be used by the network manager
> to
> >> > allow proper operation of iwlmei.
> >> >
> >> > * Send information on the AP CSME is connected to
> >> > * Notify the userspace when roaming is forbidden
> >> > * Allow the userspace to require ownership
> >> >
> >> > Co-Developed-by: Ayala Beker <ayala.beker@intel.com>
> >> > Signed-off-by: Emmanuel Grumbach
> <emmanuel.grumbach@intel.com>
> >> > ---
> >> >  drivers/net/wireless/intel/iwlwifi/Kconfig    |  11 ++
> >> >  .../net/wireless/intel/iwlwifi/mvm/Makefile   |   1 +
> >> >  .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   2 +
> >> >  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   9 +-
> >> >  .../wireless/intel/iwlwifi/mvm/vendor-cmd.c   | 186
> ++++++++++++++++++
> >> >  5 files changed, 203 insertions(+), 6 deletions(-)  create mode
> >> > 100644 drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c
> >> >
> >> > diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig
> >> > b/drivers/net/wireless/intel/iwlwifi/Kconfig
> >> > index 629aaa26a230..f91516d08b28 100644
> >> > --- a/drivers/net/wireless/intel/iwlwifi/Kconfig
> >> > +++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
> >> > @@ -92,11 +92,22 @@ config IWLWIFI_BCAST_FILTERING
> >> >         If unsure, don't enable this option, as some programs might
> >> >         expect incoming broadcasts for their normal operations.
> >> >
> >> > +config IWLMVM_VENDOR_CMDS
> >> > +     bool "Enable vendor commands"
> >> > +     depends on IWLMVM
> >> > +     help
> >> > +       This option enables support for vendor commands, including s=
ome
> >> > +       that don't have their own Kconfig option. Other Kconfig opti=
ons
> >> > +       depend on this one as well.
> >> > +
> >> > +       This is not enabled by default, if unsure, say N.
> >>
> >> Why do we need a new Kconfig option? Why not always include it in the
> >> compilation?
> >
> > I expect 99.9% of the users to want to disable this.VENDOR_CMDS adds a
> > user space API and in a sense, it increases the attack surface. You
> > can claim that I can reuse the IWLMEI Kconfig option, which is true,
> > but we have other features that need VENDOR_CMDS that are not (yet)
> > upstream. So the idea here is that any feature that needs the
> > VENDOR_CMDS will select it and if none of them are enabled (for 99.9%
> > of the use cases), then, we would disable VENDOR_CMDS and decrease
> the
> > attack surface.
> >
> > Makes sense?
>=20
> How do you prevent users or distros from enabling the feature? They can b=
e
> in a hurry, lazy or not caring and enable the feature anyway. So no, I'm =
not
> really buying this. If the interface is not secure it should not be in up=
stream, I
> think only exception to this is the nl80211 testmode interface which is f=
or lab
> or similar use.
>=20

So what do you want?
To make it depend on IWLMEI Kconfig knob and not add the VENDOR_CMDS one?
Fine.
