Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA29A6A5CFE
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Feb 2023 17:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjB1QWQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Feb 2023 11:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjB1QWP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Feb 2023 11:22:15 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7074697
        for <linux-wireless@vger.kernel.org>; Tue, 28 Feb 2023 08:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677601331; x=1709137331;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MAgpESKeRY49owrbtog3WPVIj5FcbRwvY44hxTB076Y=;
  b=JLtfbu1w1wTp7pwuFbqjFScYNTQvfUnDGpzBw5rtMdFYxGeDZI0ZO1LM
   appZpx5SDyTUkg6U58HK/32ehHAPzrsYy5ilpCoTugc86M1h7zF5keci0
   UkYUERfjBa66ZfsufOMk3P+Jy6Z3i1eSmL7p5mGM7DbFLFFA/YMQrhBtW
   cCPb34ruVr2qrT6+eE6Q9p7QTuKKRPNfPd/iUaKJNXdjetOFLsuX33uht
   rvI3mv05JIZ4V6TIlNt3LnMjb+XfqzNwYQzpVlis/s9uJpqZ4DKuWXX0k
   89qVmSu9g9tA23DJzn7DGPSTnZSsijbpuLj6OmbWxjOg63SR0KNhN2QsB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="322434084"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="322434084"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 08:21:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="817132979"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="817132979"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2023 08:21:51 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 08:21:51 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 28 Feb 2023 08:21:51 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 28 Feb 2023 08:21:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duq/6tVK6szQKH8Q5w4CVHAl3bcAttEKcpboXiC8rLmSMUibrlSKIJu++kbLR86ApBpDZi1d6MBTePb73MjQfx/FEFaOwDkm65rLk9jbtf/v88gntwNCgeVt1IqnhJaA92zQ6VD9fCREsULkMZUgkX5UDJaCy/zchcJ8ek9xHI2FTLhmmJVYHO1Cb5Wp5BGNj7SBLVw6kh2WCyTj46e8NDxyOOuFt/kN4H3fEn6DQW+DFTsA3BXwWpWnLojTQCOm3IfO6+SJZik54jXulp84DmhPfvDfmOyVPRJBIHZeBB16RSvoyW5HG9y4mEUIBRAMZGmYT39FVwH+bXAWlD0JvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkNh4Tda5JF5CpPHM+buleFsKUuXWnXdEVGYgryrivI=;
 b=Dh3PeLU9QxXqogb/VLD544U+ATtclHXH8fbHcKFps4q3nIwVECD8zPh5tMrGSFlGkkFT+Up60akTCEFAlJR0cW9Xotl4qw3hYjEQ2pAeUhu8JqvYVIN1bW5ogyEaz7ELRmVVltulWIGw1gTgMTJLTQbBna/IDw9HdbllrW/E2DAVgjacZ8GPsDBKCkoBp0sPN+Nq3A4SZGp8nbZpR1PXOZNA7ezBrRpdbSlw7ESNg4FWmB7ptydMr2O0mCBP8YuxepdQBC3WLPVY9/5S80bcFmpWJB+eIYDHuroa6VTtDD8slKmUXTmWfz5lfzB+8esSyyJ7pOn4GQhXwNzIw8LUqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB6099.namprd11.prod.outlook.com (2603:10b6:208:3d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 16:21:48 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::5697:a11e:691e:6acf]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::5697:a11e:691e:6acf%6]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 16:21:48 +0000
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 0/3] net: wireless: use struct_size where appropriate
Thread-Topic: [PATCH 0/3] net: wireless: use struct_size where appropriate
Thread-Index: AQHZSuubAdnMi1GME0C2ncvrfeHms67j5M5XgACmypA=
Date:   Tue, 28 Feb 2023 16:21:48 +0000
Message-ID: <CO1PR11MB50898A1BFF1CF83520F14565D6AC9@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20230227203927.3662811-1-jacob.e.keller@intel.com>
 <87h6v61f59.fsf@kernel.org>
In-Reply-To: <87h6v61f59.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|IA1PR11MB6099:EE_
x-ms-office365-filtering-correlation-id: 0d8b82ba-8ffb-4321-8a06-08db19a7e431
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aOk+6Z0grxXqDYuUIiFkeFRwgd3DoRANmnpPwbecGcC4WMXa1be4lh8MR5eMJ7IGiMhzK7crVX4EHCqx+EvUJWh4+uKYOyN7twCzGxw6JQ6sgocdp+MbyQZjXbEazWMlJgkHY1CKAdRzvjUN9k1pzbCJOv0eNtHixPv6NgA4cj1T1UDqJvxUANZd2hkafJ4UyiLnB4m2I/TzqnZwiBGXjw87zhuMs4Xh5RVcz/zPJCBNzwyl25U3htMNaCbEGEQIAn5CGpnk62IO1hnIZ238TD6g/4Diw1SvvWe2335i8aW3aMYTGwUD3l+KH5yC29pFUiUGAQyps1vN05wX2KUFd/tg+umfapLGINgptoaFzJ7lJgA1f1NrR7uKqZoVXZbUvs1NrL0vi4haO+jkCAxblC4oaHRuf29oDzSUv8hDLdkY329Ad2QeSyS5aZPPeh/WeqPW0vC9GtKo1h7d9woVFq0RVWXDlnQqrLHfYV8IutBgPr1d1jGf/4+8QtJonG2iEigiXcgFDB+AeKLIvprKeuYid135Qb9TEalKBxteErOXCIPAgNlplJSw8hyWJdEkRXiYFRV1JdQrf/G8+GZBgpAG/7fx9jVOhJKZ9GKz7WYauHb45PXR1w48aopqjLlI6FCgOglihobcgfYUiD3fDGOR+UwjSy9VrCnjV1GLxhyBW6ap501D4KF+oOLV9qZabH41kaLnmPIMCQU2ztw154TqiBaaTPblsy3koaZzmyw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199018)(83380400001)(33656002)(966005)(54906003)(478600001)(82960400001)(38070700005)(316002)(122000001)(7696005)(26005)(41300700001)(186003)(9686003)(71200400001)(53546011)(6506007)(5660300002)(38100700002)(55016003)(52536014)(66946007)(86362001)(2906002)(6916009)(8936002)(66446008)(76116006)(4326008)(66476007)(8676002)(66556008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9M/gUr9weyF+eOSPHQubz1lhF3LEir2nv0mB13PmUxF6m0u3D3CPBRLIIp5m?=
 =?us-ascii?Q?rg9zEeOSZa44TIHNWotYSTY/D6gaimooRyQKCcO1SjNo+bElCFCbEN4kVn5m?=
 =?us-ascii?Q?EuH8E4ZaaU//DxsZwDn+WTz/EBnTxZKvkvc4Uc+p20RU3jzM8Yr1YiojmfG2?=
 =?us-ascii?Q?9LZpw6ibgY401hgstt82UUJO5Br8AmtD2HBMuIA5cYR2YSSnKsUzzGhLHYnC?=
 =?us-ascii?Q?uqNAFysH7OAkT2OCPvq1clyCZXLWsL3EokCYwD2irjJzWypPcUQ039T8/xAk?=
 =?us-ascii?Q?FOFJmJogWTam5xI3tBQx/ZQ+kqCZXjVsh2o85pksjs00fy/Wp0A0Rossjo/b?=
 =?us-ascii?Q?usQ4jXOWeSXDWtjb/WpsWA3D4x0oy0mmNuTLSq3khaXFTpZAyZei9ulKemqg?=
 =?us-ascii?Q?dp+nQvM0FydlFr3Mt0uGPBPKKH8xTSuFevaooeBe4vNteqoC/SZfCIHPXjqG?=
 =?us-ascii?Q?59j2Gxzw1p48hPmh9l8XOzPX7vKsS4KV+oLPoISQXwgtZI0vH98QPYPp2khw?=
 =?us-ascii?Q?ReyH3Ahc2ZvajyjS/gj6VCX2JKCBFXQf8v1tvuJiCLKg4d/pR370BtH+FNTL?=
 =?us-ascii?Q?QGJcNkby01n43B5TkH3PAuqg9mQfJm9dL74rOKMqdGoDUeEC7TUUrkJf7XH4?=
 =?us-ascii?Q?2fiYLW0LK3ibXNmK2znHmxRmUrv6VFp+oXTLzRHzYv+N2xz+MSi48hyCbX7A?=
 =?us-ascii?Q?CZaIlbQA0E/MLPe8fPzbdkqm1NTehxAvRqUyPQZi+R2oIzSJeLZTMCNEnxRV?=
 =?us-ascii?Q?LtmkrUl/nf5Uxw8wllyfVGaREJA31uPCZvMZ2QBVSxDK2mIt2z9xG/Qeertd?=
 =?us-ascii?Q?lWNwfX9IIG2+nIXH36HCZ3tsFBOOETUpTpszGgbxCXKdyhWXxAL/uM6gAEOg?=
 =?us-ascii?Q?2W1rzwXmi/3GGNfGNMNVcLlP8un4Ln0zNzZFcbOtis/Hig/C7HQ+0peUr4NL?=
 =?us-ascii?Q?HGtOh9DUU5ZzVW5j9pX1HbuZo7orLI8+1tXI8xaDyinuCRQWqLBdkge02jdL?=
 =?us-ascii?Q?ORt23WZTHMLvk2MjrjnyIcwoO2M5ORJCkiCHTAZOW234ZfXuVnytpgNwQMLV?=
 =?us-ascii?Q?bu+ooB5rs4Sv2hfgMDVzTAPgxe0HThZuJ+GTWZ6BP/Jc0W/h7QkDCJkHzoA0?=
 =?us-ascii?Q?foKmvVJ0CcEHw4av8gGy2ZtTeNv1hDC+oT3qbHpWT8rgp8lRUIVadL/ovrW4?=
 =?us-ascii?Q?sS0p/Xu1KsDDALkc/jIng4Q19aS2iYR3iGumB6Fe5dNKtXHj6iYYp9mA+uX9?=
 =?us-ascii?Q?COfCuJ1MZtf4DjfmSVk645bzgeb4hig5Ie9I/Bq5tLuckZ6GF3oswlgpkf1M?=
 =?us-ascii?Q?yNhuoEIllwoy7L2/MFINS4WZTOooIHEcf17jYCvOxCCmUo7WQFtUHHIimPfN?=
 =?us-ascii?Q?Ts5vX9WD70QS5fljwxv4unPXc6D1mKXwH14ncPiQ8QmBeYdfFWBG47ISg5WA?=
 =?us-ascii?Q?BCJ4LYH2lsQz1/eJ4ygZQr+WHIHyYySy55h6TlPSZv7h8cCuUUZAMT227lPl?=
 =?us-ascii?Q?zIrXr45/lPwS7iw6qNvNS66+9+CDPGFj8t8isgkOB5YakdEPEJTFl+7J7/+E?=
 =?us-ascii?Q?4X+mqs67uSutIDFzjSlwrMtdzy8B0jdKZa5F5mZy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8b82ba-8ffb-4321-8a06-08db19a7e431
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 16:21:48.1585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lIHoUc/b8YxrA7TSC1K018U7/JJ6gb1im3Mlrs56IS8n/M0cIGGcFDW0E3ttf1I9Io7Pc7LAQxjIY+V9VCwM1aYUuNnXQh8f9pRjq5YIdhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6099
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Kalle Valo <kvalo@kernel.org>
> Sent: Monday, February 27, 2023 10:24 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>; linux-wireless@vger.kernel=
.org
> Subject: Re: [PATCH 0/3] net: wireless: use struct_size where appropriate
>=20
> Jacob Keller <jacob.e.keller@intel.com> writes:
>=20
> > This series fixes a few wireless drivers to use struct_size rather than=
 open
> > coding some equivalent checks. This ensures that these size calculation=
s
> > will not overflow but instead be bounded at SIZE_MAX.
> >
> > In the first case, the code is first converted to a flexible array, whi=
ch
> > saves a few bytes of memory in addition to the fix with struct_size.
> >
> > These were caught with a coccinelle patch I recently posted at [1].
> >
> > [1]: https://lore.kernel.org/all/20230227202428.3657443-1-
> jacob.e.keller@intel.com/
> >
> > Cc: Johannes Berg <johannes@sipsolutions.net>
> > Cc: linux-wireless@vger.kernel.org
> >
> > Jacob Keller (3):
> >   wifi: ipw2x00: convert ipw_fw_error->elem to flexible array[]
> >   wifi: cfg80211: use struct_size and size_sub for payload length
> >   wifi: nl80211: convert cfg80211_scan_request allocation to *_size
> >     macros
> >
> >  drivers/net/wireless/intel/ipw2x00/ipw2200.c  |  7 +++--
> >  drivers/net/wireless/intel/ipw2x00/ipw2200.h  |  3 +--
> >  .../net/wireless/quantenna/qtnfmac/commands.c |  7 ++---
> >  net/wireless/nl80211.c                        | 26 ++++++++++---------
> >  4 files changed, 22 insertions(+), 21 deletions(-)
>=20
> I don't see the actual patches, only the cover letter. Also nothing on
> patchwork:
>=20
> https://patchwork.kernel.org/project/linux-wireless/list/?state=3D*
>=20

Hmm.. Let me resend.

Thanks,
Jake

> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tch
> es
