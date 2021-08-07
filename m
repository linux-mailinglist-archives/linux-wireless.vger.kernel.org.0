Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DA03E36CA
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Aug 2021 20:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhHGSiV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Aug 2021 14:38:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:20038 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhHGSiU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Aug 2021 14:38:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10069"; a="214506451"
X-IronPort-AV: E=Sophos;i="5.84,303,1620716400"; 
   d="scan'208";a="214506451"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2021 11:38:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,303,1620716400"; 
   d="scan'208";a="672939013"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga005.fm.intel.com with ESMTP; 07 Aug 2021 11:38:02 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sat, 7 Aug 2021 11:38:02 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sat, 7 Aug 2021 11:38:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Sat, 7 Aug 2021 11:38:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Sat, 7 Aug 2021 11:38:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+1qt6lPJ49ixmvf2NkEbKboF6USPi2FvYyWlRvpXZpSCOjF5fNNpdm7SE8SxL4QQ5j7CtkKdTwL4hH7I0db/wkU26S5j7g8WxGLscSYHT6+/44snLV/Wi/ON+BEjW53YJTD7us5moVMjK+jtfm+R6i60ZuIQ9j+aexKh55zQJ2bfncmJyoY56Yk7lI+Iyk1sZiRVCjMGE8/e4mw5Bsnylw1k2iTPewXPLQlUKQNlax1eHwigboNFhDKzuCEkB3MVPdpMwewE8DtFVKGM+2Ovao79bii29+Ux0iS51B5bVefz82tbS2GCmo4vv1275vFojTtgfaERejbrtCNPUbBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEMnrwoHTUmr76qLHVGC7EkVJfl+Qh1cjnK7loTmXs0=;
 b=L+TTcXTuJ4a1ywvkZ6Syt+oV1GyrWbbPcPWfS1Fx75aJMkSAGAwNEKSbNb26JsvOcxKZSC3m4xEHI/07dwUsyBiCKRbQ2fDvIZCEVbeSqIVaEa3cggUfYxzdBQE5gu6B8ZLUbr8H3NzRN0ncaVm6j+xPISV/cZE0C8s8nzUNU0pZ1LNkiJV3B1OwrNBH1gr5sPoPxPCayQ3t1dD2MilRswO2HQYEJDfKtlHS03KLrcMJoV39P4E2WdziyUY/0ICUb/0yTkt1JsNwxMpJRTtBppDNg0y6xsJjI1hdLiDVQS+LGbh6dZeUEkL6YLKUYFL76lLpsJ4YDFR+Khga09ZOVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEMnrwoHTUmr76qLHVGC7EkVJfl+Qh1cjnK7loTmXs0=;
 b=Qlmcse1ZZTUhZOFLBjUUtEylz2woIItVrviiEPKhp6IigPTaXtbaNFfayooCOI6/zwavfJtPCRZvylVD8HVcvceaIZwmYnSTmPD6z5MEc+yEOCXCw/znNYhTlD9S7R7U2cnGZ5XW0UG6RkwwoACDxqGdk/GA6+DBEFHciq0ZApA=
Received: from SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24)
 by SN6PR11MB2544.namprd11.prod.outlook.com (2603:10b6:805:5d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Sat, 7 Aug
 2021 18:38:00 +0000
Received: from SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::4534:c66a:f050:3486]) by SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::4534:c66a:f050:3486%7]) with mapi id 15.20.4394.021; Sat, 7 Aug 2021
 18:38:00 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Emmanuel Grumbach <egrumbach@gmail.com>
CC:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "Beker, Ayala" <ayala.beker@intel.com>
Subject: RE: [PATCH v3 1/4] iwlwifi: mei: add the driver to allow cooperation
 with CSME
Thread-Topic: [PATCH v3 1/4] iwlwifi: mei: add the driver to allow cooperation
 with CSME
Thread-Index: AQHXif89mPyUVY6cEEicwpT+rJZpFKtoYcMA
Date:   Sat, 7 Aug 2021 18:38:00 +0000
Message-ID: <SA0PR11MB4752B06F7330E6C14717E113F2F49@SA0PR11MB4752.namprd11.prod.outlook.com>
References: <20210623141033.27475-1-emmanuel.grumbach@intel.com>
        <87bl7vi3o1.fsf@codeaurora.org>
        <CANUX_P3QE9xNnQLT=mHNDp4VCv37Bcjuvn9O1wQ4Btejjkbrvg@mail.gmail.com>
 <87k0l0c8pa.fsf@codeaurora.org>
In-Reply-To: <87k0l0c8pa.fsf@codeaurora.org>
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
x-ms-office365-filtering-correlation-id: c354f3a2-cc0b-4740-954d-08d959d27be2
x-ms-traffictypediagnostic: SN6PR11MB2544:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2544CB7AC9DEF9B3BCCC50A9F2F49@SN6PR11MB2544.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8zSB9t6POoP7yFuGGwAaHSPgRJl40CAKLhPuO7css2am9IZvRa4gpJ7KdKYFlUCIzeQh1F/XrNBa7gGB/Z7Zgg60+H/DqvqD2KPvmQ9kWWgT9HXA9JjvO2N9eAdN2ZD99oh3zd9RAuLnis0DLMH1ToIjcZUhMwV0DguxMlilHSX3VN4tOboHwwscij5EPbpqaca30SBYuOZ3esGmgFoj4Z90NUIdirWNdbbc4JYkFxghtCw/8CoIlhTSHjt+lsLZZ+RwBHB5Q0dPAQoVAEl+pFI7blkwr5qJv7y8ttommOjPvcaDfF993cQFVbHB6X03zAauZI4chtiLOi5AcTCzAWTTLIBuvyCr/RxSPWNh4B1uURyDUTIOybbvxbuYTCFOoSblYzLrR//OpVCqgarGhvxeCZ5fWYDPbR2DogthFIe5eFg8h8egc4lTER4BSAbnYxQCzTJ9e+x5lLPVW7giVrpl+yIG1CZ6zLKtnSH7Goc0G8bf6M1uow2WDPoJUu+HPdhRF7PttCglig/XTP0DgL+gjsD4RR/ix5BSzIgTXYgwjRgdrgMPRDd5Y1dAsxKJMR0wnAAtsEpq61vp9JxiHjEbG7pMsWKx2wozj4uRP16TOgoDXHPFYhOv/RRplpaf6deLGHBJXsagyKs+DyIW+8yZ9M5nu/Y1M/K6yu85IVwMN9rptpH0OolFiijKX4CzAZXUKslQNZSX9Q2bA9aXng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4752.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(26005)(66946007)(33656002)(38100700002)(7696005)(316002)(110136005)(2906002)(122000001)(38070700005)(5660300002)(64756008)(71200400001)(66476007)(52536014)(8676002)(6506007)(54906003)(66446008)(8936002)(83380400001)(76116006)(478600001)(66556008)(107886003)(86362001)(55016002)(4326008)(9686003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6yLzPx2WrWQk6t/58mkL1IBBviWCWVPLrPll/BuMtxbpIgy3RUMiRD7CEcDK?=
 =?us-ascii?Q?Kfw5Wl9Xrp7uE/XvSko7k+DD+5VzUhzMFV/3/XvEoDLmtm6xdkNt/5AEOxOH?=
 =?us-ascii?Q?7r9ynymeXFBg0PZGH00OqbLkLR1pKy2400Zacq1RVntqy/XsacX5atd2Sxd4?=
 =?us-ascii?Q?BVuhLO59+8BB3P2OFq7nbdW54niihbaoEFPKXU2dGb8nFcNV+R9s4et8Xyni?=
 =?us-ascii?Q?CoRqspTP+1wXJPgWMDhH33SSTW3weoQ6ALgIXhopERtxG/tmfBgfJSwhUAgb?=
 =?us-ascii?Q?H+0xeFtquLD9EAyacS7CAsM5tE1JORdIeMZuIWUs/DVGB1dPrEiXFPMD0O4A?=
 =?us-ascii?Q?s7SMpJ7e39f9cDe1sgaWBN3IMFsi0RT87ed7iWXIlb7303NqmV7qoesyaz0p?=
 =?us-ascii?Q?76dKXchBdnNzcpBy3Ho8K1xlytTL6UlYMpVRzZNhmBtWcmMULhPkCqIBSbb8?=
 =?us-ascii?Q?2wV0AWUcM4iyeMfwbl1BvpyEp8PgUqyK5/YkUpotAAwRnZPQ05SiPIuEzmxw?=
 =?us-ascii?Q?aEiOM7LKstMwofH5xTHBgQ5tKM8l7hKQhZhLhLUVF8xjZWlm308YaHXtDCJT?=
 =?us-ascii?Q?kb5mueBAbkxF8288cLnLf1JvuOiTFG7N00PQqTrv4GT7gCaxInJrBbJVRYmE?=
 =?us-ascii?Q?oQyUTK8XKddYSbe5kXzGLxwBuMcCsEzOoFXebiCPvGCWIBmS19JErxPysfVF?=
 =?us-ascii?Q?79cvPeXt0zwZrNoQWjYeh8RG5Rew22OmpIEF3AaUpcnktpgtasMdQOgTj6aa?=
 =?us-ascii?Q?Rn0tmswBChLX2rDbEvhJBtt2O9TuTz49qQg9vC1HjEUUUClHndW4MlmJqBW0?=
 =?us-ascii?Q?jr9s7q60D5ZaqSa4aemCooZNXTfSjQU+ph24oLlJDjnQEVA/1HHGBP7krDID?=
 =?us-ascii?Q?ItUYlrCvhsfel/ggnpb7E4Ja9s7OINNBngb4NyJqU87vKajO/PDEiXDUeoZa?=
 =?us-ascii?Q?C8KtjDUVeT062b0uBK4VB/vnCSMWPLo/q4LrWJmvWgBYxsgYQEprW3HjfAVr?=
 =?us-ascii?Q?iiqxfgGZBUUb7lZcf1iRRycrzD7yT02T1Ye1SW8pCfxhWwMxSHBeFKfKL6lT?=
 =?us-ascii?Q?qCJhj6BvLEfsW1QhMSPS0bXj56xEbxKhIxCtUTidvTjtVEDKsYe7kvuMYMR0?=
 =?us-ascii?Q?9u/xevmz4wPPBlK52lYFNnp9vLKdWOTCVm4dcIFwXuTzqc28FDUMS+f8fn8A?=
 =?us-ascii?Q?HCLT42YK4pP/5OTk4U2NrAY4p8qAMVMaCLOR0c26l86120U+5aIb+VV1f9l/?=
 =?us-ascii?Q?GGZUDu0Iqg9w+hD2J8iQr0D9BhETLYLWJxyKYfvhYaGMg2btjn+WuuLNPeav?=
 =?us-ascii?Q?rxavNJRR9qqvjBN2SoGhI0ol?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c354f3a2-cc0b-4740-954d-08d959d27be2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2021 18:38:00.4593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YVn33+cCX9QoUlA6qRVzUsRrIg34p2VWuiD9apOIZ1i8OJiYb7FtZSk/nAEd7EZ6juVaSPsiod0fsJIsYnMEbPM/QXklXUTFMQRHEN3GT30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2544
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>=20
> >> > +     BUILD_BUG_ON((u32)IWL_MEI_AKM_AUTH_OPEN !=3D
> >> > +                  (u32)SAP_WIFI_AUTH_TYPE_OPEN);
> >> > +     BUILD_BUG_ON((u32)IWL_MEI_AKM_AUTH_RSNA !=3D
> >> > +                  (u32)SAP_WIFI_AUTH_TYPE_RSNA);
> >> > +     BUILD_BUG_ON((u32)IWL_MEI_AKM_AUTH_RSNA_PSK !=3D
> >> > +                  (u32)SAP_WIFI_AUTH_TYPE_RSNA_PSK);
> >> > +     BUILD_BUG_ON((u32)IWL_MEI_AKM_AUTH_SAE !=3D
> >> > +                  (u32)SAP_WIFI_AUTH_TYPE_SAE);
> >> > +
> >> > +     BUILD_BUG_ON((u32)IWL_MEI_CIPHER_NONE !=3D
> >> > +                  (u32)SAP_WIFI_CIPHER_ALG_NONE);
> >> > +     BUILD_BUG_ON((u32)IWL_MEI_CIPHER_CCMP !=3D
> >> > +                  (u32)SAP_WIFI_CIPHER_ALG_CCMP);
> >> > +     BUILD_BUG_ON((u32)IWL_MEI_CIPHER_GCMP !=3D
> >> > +                  (u32)SAP_WIFI_CIPHER_ALG_GCMP);
> >> > +     BUILD_BUG_ON((u32)IWL_MEI_CIPHER_GCMP_256 !=3D
> >> > +                  (u32)SAP_WIFI_CIPHER_ALG_GCMP_256);
> >>
> >> These look just weird, and suspicious. You are using two different
> >> enums but they have to be same values, or what?
> >
> > Exactly. I don't want the userspace to have to include all the SAP
> > protocol header file. OTOH, I don't want to have to translate between
> > vendor commands attributes values and the SAP values.
>=20
> Why not? I assume you would just need a helper function with switch
> statements to "translate" between enums, not much more lines of code but
> a lot cleaner code.
>=20

I disagree that it'll give us a cleaner code.
What we'll have is two different enums with two different values and functi=
ons
that translate from one value to another. This is very bug prone. When you =
want
to debug, you get a value, you always need to think of what type of enum yo=
u're
dealing with.
I believe your suggestion is not good, but since I am tired arguing I will =
do it to
make you happy.
