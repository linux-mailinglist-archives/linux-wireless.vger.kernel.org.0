Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C9135C91B
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 16:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242544AbhDLOrU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 10:47:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:5435 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242519AbhDLOrS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 10:47:18 -0400
IronPort-SDR: bBnkCfE1yclmjedQp0f8WQTr5UuAFnfXrJ50zlb6CRW3gHGlVMlcyBGgs2q+sQg/bl/pJQv015
 qCXFJPO7o0jA==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="258180617"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="258180617"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 07:46:59 -0700
IronPort-SDR: wgydlkxHzdbPkAHlRcc5xIYsrqEQGcXfiPbo3gYZKX/SSCCRRDZfU8PMfwqret09vHOqkz9tbN
 EGbMBolbKFVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="531902833"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga004.jf.intel.com with ESMTP; 12 Apr 2021 07:46:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Apr 2021 07:46:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 12 Apr 2021 07:46:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 12 Apr 2021 07:46:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+q5XL3uKM5/DOmXGx9t4cj6PER/6PUuZENaQFzzWfytIWciOmD8cp3ylvokPvHG0GMPMoNyarWz3UnvhSDHrVE48jnF9gbeMFeCC//FcBgIBwkavthba6TGBg3AChwy1NDFAoJD9d6laUZDmatvvy7U8/tWzSzIWy3ueVqB1M0mVbK4CSq3aoAyDwK1FpDUT8eyosBREsfbl1J6LDVpnKpqlzwcIlAQz7z19qHvkv5m80fAJFtI/5TXdOaM2+ZZExfxKypwpSyWBv9QiQdbDFnTRWQf0NSzscqHUsBSux7An8B4GKP/k5AjQrj8KVY7iH4oeg7hKkFgJMd2VWTfSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDC4SZ7D84pwsySFjMoBUvle9Z6KcBAvaZqd1Wr5BWo=;
 b=YszCG08e/kG+ZNAbveO3P9m/Mqml1w9bfHgXJTB33HCSMsD8WWwQk3qgc5icgkTwCsFXHCLqIcN5azXrSniRSIGu4fC2kPzAImdkAVqQ/e8meSVPvgZqBoLQ312iiU80uatMFllJ1I7bSV6HlWOt/BvJPeD/WDzlwqr4vGQLG39lr+6e2ABhJ9m8xRMtz66PLbcNlPJcqCiuRid/zYIs/0F9RXx6U8JFABrSS9qS8h/Xfuwx/Bi36NllPifkFIWQabdHqC4YhG/ce7jiaclVMBrqvbfz97xX5ZLJD7Bos4pGxdnIfLZ0t6ruvGX6NJpXMD1TMvhYCEdqfq0BDWCo+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDC4SZ7D84pwsySFjMoBUvle9Z6KcBAvaZqd1Wr5BWo=;
 b=RBWUtky6nM/H6O+r7UvoWQ5ndYj+oAfj1G2hKwpYDnaZ5gT39nCKhCnc10D+39pf3qLCJTp/2iIQoitM0Nv6kIRWbGrwfe1p0A01aX9m54S1S9Vs01qjJvFj2vj+I5jXF+JB9EmFQ9lAtpVYfIi4MV/LJCpDXpDgnfZiOCwQHtU=
Received: from SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24)
 by SA0PR11MB4702.namprd11.prod.outlook.com (2603:10b6:806:92::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Mon, 12 Apr
 2021 14:46:53 +0000
Received: from SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::dc7d:1696:50b5:8598]) by SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::dc7d:1696:50b5:8598%7]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 14:46:53 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "luca@coelho.fi" <luca@coelho.fi>,
        "Beker, Ayala" <ayala.beker@intel.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>
Subject: RE: [PATCH RESEND 2/3] iwlwifi: mei: add the driver to allow
 cooperation with CSME
Thread-Topic: [PATCH RESEND 2/3] iwlwifi: mei: add the driver to allow
 cooperation with CSME
Thread-Index: AQHXL5l8AAlmpHtWLk6IhaLef8ZD26qw2g6AgAAEIoCAABAHAIAAAg7ggAACuoCAAAF48A==
Date:   Mon, 12 Apr 2021 14:46:53 +0000
Message-ID: <SA0PR11MB47522D6E66CAD30CF0A63651F2709@SA0PR11MB4752.namprd11.prod.outlook.com>
References: <20210412124328.24472-1-emmanuel.grumbach@intel.com>
 <20210412124328.24472-2-emmanuel.grumbach@intel.com>
 <YHRFy3aq/gB7Vde6@kroah.com>
 <SA0PR11MB475215678ADCCE657C6574D6F2709@SA0PR11MB4752.namprd11.prod.outlook.com>
 <YHRWtJqbuFGmR2Sw@kroah.com>
 <SA0PR11MB475228709B9B0B6D74CE07A2F2709@SA0PR11MB4752.namprd11.prod.outlook.com>
 <YHRat4egd/LM8DNJ@kroah.com>
In-Reply-To: <YHRat4egd/LM8DNJ@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [77.124.181.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32693546-879e-4cc6-ee5f-08d8fdc1d052
x-ms-traffictypediagnostic: SA0PR11MB4702:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR11MB4702C67AE57A4203DEDB1F7EF2709@SA0PR11MB4702.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gN1xoBrzr6Hhk6d30ZMZZe6OiTVvYJ3Uws1Biatz4nRmIQZkGzq7TF4q7kpdSoRE8s2jZ88HebKNkDYB6nQzglshIf0QNtSJR0wrpHyh0a/irC58wxfnNht5cypHjXBulYDXR5Jhoa1MzZ+quUkZl7n/2u/6SqHlSw5dNV0bA3691enJLjwMNigf0u3tUarlbrwKBomOr9v5Yv/Z76+gfbpsNeBHIkZjGfGGO6tQ7sm2LD/uLpIDie5usgGVF9Rw/wPMv0mfTqLbAZdNA/xTyvmiJw2tJXGV9IQYANneCBhPN1JTfkkPqJ4467rbcsSSKU7pAPcCqlcZtAC8D6NuMuJ9iE0WRs4MBbFNb4SDwUdgHvjzb3qYvLdBT6L54nqSyQ1bKAzQ0YcYXBSL58W+Dig51SD3/5tQ/As6RwvfhJMI6Z88a8tzImFI9n846IU7Ls6AklHivm9cLrLeu60xddMAy4Mv+xxNXlKkyu9yWzsJbf+q9jvADSMv7asrk+OCDB1WsA35+tgw2b82jJDQz6HXx7v+c3iX6LITh6D9dB2iDW74POAeBEb40F4G9WIEf5RZuXNcfBeJb4I1yD6IrhjRHJzqhLnEv9XMM3NH/Gg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4752.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(376002)(39860400002)(396003)(7696005)(8676002)(6506007)(2906002)(55016002)(107886003)(8936002)(316002)(38100700002)(6916009)(4326008)(33656002)(5660300002)(71200400001)(54906003)(26005)(86362001)(83380400001)(66446008)(64756008)(66476007)(76116006)(9686003)(52536014)(66556008)(66946007)(478600001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?td6mAonKfWS+Orc/VQcUgcip13qpccNyn83B++VbMjTfk7fnDIYy11Fb/aZL?=
 =?us-ascii?Q?4f9uTrMB/we3kQpcCAPGnDanq8kE7Vt/s/2mGYPoVGoLma9odmnd4n4oOlxB?=
 =?us-ascii?Q?WYTd3q8AgpTGRrjVKn0T8i4iGvoABBl6xM7J5b2Z+tzI1wOTxT4KdLQW3srJ?=
 =?us-ascii?Q?XgbCAGo1U5JK3GoU4BmXdiYC4ktUUW0/71CEMM9J9snh+ztCMwu3W8PQ3Ush?=
 =?us-ascii?Q?MVGZj8/WQzerB9dopkV+KUcSpgXO97v4jOyH2gAiOSY3Ff4zctw2Lh6LgZKb?=
 =?us-ascii?Q?582K+dgZ/0Hz3WvPvE4vr5UF9wd0Ruuhe5NeGTdYtt/miFuR7Mucs0Ga4gLJ?=
 =?us-ascii?Q?DaO9JHkSn3L9qcn+JxGfYomvt6GaO8BW2b0PNka/CLueHNTTH+nVfsmj0iqV?=
 =?us-ascii?Q?CbsjKN/dqby5dEo+QV8IdEVDxZNxSX3DLsTVYtgrY+1Zzh3+qUFrGjtEmooL?=
 =?us-ascii?Q?ilqGiHft+WWMvMTNordASG2OGA+2+jALUlyE/y8g5ZUuEkZNggOCzOh/pb6Y?=
 =?us-ascii?Q?LEGo1Yrk54ZK8Qx/GBcn7vewKYNgbtKvoPmiO1464oKPNMQms2/fcjk715st?=
 =?us-ascii?Q?zFvChrXV6nBVbF/ZE2eQU3d3BE8NwfXAs/F9b7RspuYINpSBNXfGRvM0IX3C?=
 =?us-ascii?Q?mhYvEGob4BfB1X6xrsv9ioetJ2eYiG0v1dkeRFABaK293eMgkkeRiDSZUjOe?=
 =?us-ascii?Q?jUWnDUNrd66mqF6VfSmK5+kf+pSy8F/PATiDJqs5kvqmhJNDtTXuRn+OBaNC?=
 =?us-ascii?Q?QQTSaqvEZKCep1daIbVhOaN58YYHWUsizJGE406hwHrkJNMQSQ3mDDz1yWJX?=
 =?us-ascii?Q?4VQhK8Qyq8YuzkSfWu4e4P6Q93S5UZxPoZkhKVkLar8A+gjUP4VyxcIIvpmP?=
 =?us-ascii?Q?/6mWMVnKIwprr/6wsFG5khpOb1oRLFaorB5E2k/jiVhzaoi3wHoI7C5RRUkH?=
 =?us-ascii?Q?Z39Bse1S6FnhEQzUGpTUXioZXSa4fxm38z+Z8jEVNoXfs3RDZ8wmkrMtg9ct?=
 =?us-ascii?Q?cw1vF/XrMQ9Gs2oZgWi/9W0WLDNeIyuUrxzAbYWZbKiFgGWUbB48Pkofh3Ch?=
 =?us-ascii?Q?sn1/Ny3Xb7l8j2ULzk0lj0O7jQxhFRMtK3CGfzo/b5IKTDsq5bbU0+aU2N4l?=
 =?us-ascii?Q?COkUsw3fy+4hIB7e7nQVvPurEHbU3zWxUnW7PO8vANBbYNcmXJgdS7frNVmh?=
 =?us-ascii?Q?uPfwhGjRf9xKNbRkMZ1tBmXrgXYRjd/gXNV9UaUbH9dpLuBgDoEPbDiKtHD4?=
 =?us-ascii?Q?RF7AdhPNNjtahEvbSReuUt0stpkfNeuMSzLT/8jOXXUngWCCXbG6pXVBYVRm?=
 =?us-ascii?Q?eLWqcxpvLcyOAnI7bx0ZDph3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32693546-879e-4cc6-ee5f-08d8fdc1d052
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 14:46:53.7321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8c1esVgXtYbjQXKcmkusqK/Exa376MinKAezj5uny9oOXH2Zx16uyuG4T8UeLYqbnAnGejoIO3zHWeaAFaU8vSU7FXmuwIRlxfeG0m4vsyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4702
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> On Mon, Apr 12, 2021 at 02:29:45PM +0000, Grumbach, Emmanuel wrote:
> > >
> > > On Mon, Apr 12, 2021 at 01:44:58PM +0000, Grumbach, Emmanuel wrote:
> > > > > > +#define IWL_MEI_DEBUG(c, f, a...)		\
> > > > > > +	do {					\
> > > > > > +		CHECK_FOR_NEWLINE(f);		\
> > > > >
> > > > > Huh?
> > > > >
> > > > > > +		dev_dbg(&(c)->dev, f, ## a);	\
> > > > >
> > > > > Just use dev_dbg(), don't be special for a single driver, it
> > > > > hurts when trying to read different drivers.
> > > >
> > > > I took this from iwlwifi. I can change if needed, not a big deal.
> > >
> > > Please do.
> > >
> > > > > > +module_param_named(defer_start_message,
> defer_start_message,
> > > > > bool,
> > > > > > +0644); MODULE_PARM_DESC(defer_start_message,
> > > > > > +		 "Defer the start message Tx to CSME (default
> false)");
> > > > >
> > > > > Why do you need this?  Who is going to set it to anything else,
> > > > > and why would they?  This isn't the 1990's anymore, please do
> > > > > not add new module parameters.
> > > >
> > > > For testing. I need this to be able to force a certain order of
> > > > initialization
> > > which is possible (and hence must be tested) but not likely to happen=
.
> > > > Another point is tracing. This allows me to load the module but
> > > > prevent any
> > > real operation. Then, start tracing. This way, I can see the whole
> > > flow in tracing, even the very beginning.
> > >
> > > Then call this something obvious,
> > >
> "kernel_hacker_debuging_testing_only_use_if_you_know_what_you_are_
> > > doing".
> > >
> > > Or better yet, just put it in debugfs to turn it on/off and no
> > > module parameter is needed at all.
> > >
> >
> > Debugfs is not a replacement for module parameters. Debugfs can be
> > used only after the driver already ran quite a bit of its
> > initialization code path. Here I want to be able to catch the very
> > first messages with tracing.
>=20
> Then use the proper trace functionality of the kernel, which is not modul=
e
> parameters :(

I am sorry if I drive you nuts but I don't know any "proper trace functiona=
lity" in the kernel that the user could enable / disable and that would be =
available immediately at init. The user needs to "activate" the trace point=
s using trace-cmd or whatever other tool. By the time the user does so, the=
 driver has already run the code path I wish to debug. I can use debug prin=
ts, but you didn't seem happy about it. So I am happy to use tracing, but t=
hen we need to make sure it cover all the cases. The way I make it cover al=
l the cases is with this module parameter. If you know a better way, I'll b=
e happy to use it.
