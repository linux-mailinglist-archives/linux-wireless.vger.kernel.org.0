Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B8E4FE876
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Apr 2022 21:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349975AbiDLTIX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Apr 2022 15:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347018AbiDLTIV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Apr 2022 15:08:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ED455BC1
        for <linux-wireless@vger.kernel.org>; Tue, 12 Apr 2022 12:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649790362; x=1681326362;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4mj8AwZHbVI3cgMqEoAMCcIW54PLLIDARHtfy6FToEo=;
  b=ivz31hwTTiQ8j3wBVglsDj41Z+C2Ngwl80iW5CRZiQxdP7z7lkqlh/Bi
   z03MmCZdSNWMG6TZt85XJbxUAsmrHPpDvipDCWi8N0oCIN1e5E1nmWChG
   NIqUVcJ4aSuV4mZo+/iZb5BnH+YdtHA5uxli7sozc+6LCKHUAUWBuqxfQ
   5LqKJN0SNBs162N230bL6EuVEjLYc3ljN9XWj+nzUtJ0EVd3sUQU789Nv
   hb3E0hcjnJWf5QWwt/7rfCXZq3fGal0DSIVS/mCuBmuJHRVutUsjxceRZ
   RNPUZoMzbfzsjw3UeGRFI6zwgEpyqAimH1yAE1nUZfK76RS2DVu6dsuk6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="262662006"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="262662006"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 12:06:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="644869830"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Apr 2022 12:06:02 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 12 Apr 2022 12:06:02 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 12 Apr 2022 12:06:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 12 Apr 2022 12:06:01 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 12 Apr 2022 12:06:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ny3RuQR2GqK+rynPGnWueYJ3RY5e/AG5jXX4rsBvzfVGkd+jGbeosoPHX0XPd0A4p3yVup/9NE/72+CdzqmhHAbF4P3AKeTTNpsI7VW4yeC09HmrtGOhZ0CmveczIQrAm32LabfIbId7Q+Tr3PaFqFg28XuUih6nlevE922uoZDzoAk1/T3Iq5ZEd7EOUdNXL6pj0cycA6bOnkQFkHUD5orNZtkdGvX2+AQYXOKvGIdcAHWtonMZ6NpGTu6XmKLeyCQHQeIXt3phDZZR/rmP/avWDoEjaIO0kscLxbx9rGRFOIs8Ez7xRvLInqCGHWLtQemy9E7pyqgvuXNwneAtXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mj8AwZHbVI3cgMqEoAMCcIW54PLLIDARHtfy6FToEo=;
 b=ehVI29WYNUc/Gw00fCcD9qR97KWzT4u6vfjbOvZBnJUZl81l5+aCFC+ZcPnAgYDigg8gR8ZjfzLoYcVvA2sYdgQOgW/Tgekv1iG2UOi3kCrJMS/jGUp1jbIwKzjWqpr38kZr3AuBXRaF5a0vaVcoHydVlbAAa6xD79i5PfiHwP5fAdl3zUbWcIijslp+NM4Yj7u4XwtyMcH8xmrOigrurhu+Eo7QULWJWWvDowVzhH79Io8Ry4PBw76VGq63Y/4qo4UY1dZz/sMKIZJQPm51b2Ov2QrmdKdwPoKp4IofAxyPjiWjh/kelxUf6luUDeGD6Kx6NC6mLIweCIJ/KCXl9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by DM4PR11MB5501.namprd11.prod.outlook.com (2603:10b6:5:388::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Tue, 12 Apr
 2022 19:05:59 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::a428:75b3:6530:4167]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::a428:75b3:6530:4167%7]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 19:05:59 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: update iwlwifi driver maintainer
Thread-Topic: [PATCH] MAINTAINERS: update iwlwifi driver maintainer
Thread-Index: AQHYTp/drX+5fCJTU0+NOSN1wmM4tqzso28A
Date:   Tue, 12 Apr 2022 19:05:59 +0000
Message-ID: <d00ac5d2dc54e3ceeed5f44ae76736b187876b8a.camel@intel.com>
References: <20220412190141.4543-1-gregory.greenman@intel.com>
In-Reply-To: <20220412190141.4543-1-gregory.greenman@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.0-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 593cafba-3465-4331-aca7-08da1cb77afd
x-ms-traffictypediagnostic: DM4PR11MB5501:EE_
x-microsoft-antispam-prvs: <DM4PR11MB5501D739A8158E21493F530B90ED9@DM4PR11MB5501.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rzJnFSNeJrUfw+ydFbRA92y03br8vfuLHqz2/RDbrbCdQrO1jSB7wOQT0zWpqrp9iI18iGqPM9j+0m/XdlGYiec14C06EFhgVoiV9F2qfPq9iOD/mJTf8krFn7fl2prx6uDzxtHw3H7Ex7XuXKeaUgvMu8B1BIgc/cOFRz8aKx/RXow4JEE0oFj0AQrv92PHVGjRoDc9rxPlrig/sWUj03/6inFcPuEaWz8A9V7t/GjzZdCfETBIBYxw1QAV8lidu/UqQIeY5Xs1MY2ou3i0uhZgIrQE2zm8TmXwyHrG1eCuya5Oznuz9xPcT5FOBKZwOkK5WLagW4NmV4jvg1S4aR2HJGJKeqWiPv/e1F/GPfm52BR5ZsgQ50O+kC69b4L7BPH5aoaVfpdIs+Iau34RrG/8XC/ne/IFADQwE9scbUxr6xSxqQkwQ3l3mYAAfhMd+QytGslMuz8uLiL9iyqj0ZNfCYrBosj9lEwG7k6o3SXcG4zylmFWDx55OYP9XGED9nJPk519C/o4T6j8cf6Gr7XK6dQg8Jqkv0v0w7G5LQF1PmLW6HEfH0NCDZ/vxAT9AVnMNuDvfpm9AdSc4jnP0BmobxVw+VbXbzvnLaR1hGYyUPO1BYpjBEiVFGgdBf7vzeAN/a0h9I13wUMz+GIUqkL5r6yy1uK6jC2pRRt+FMbv1tPTolKZN5fDkM5+D+x4be30GUva3yaVBnorzKb6nX51yQZFGJhmLyt7ZS63davKg0onfPcoI9M7bPgPOyM24CuIHsnKF4wQ1OdeOD8rm8GNAHvWM2HQKinUiSlwR4E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(66946007)(8676002)(4326008)(38100700002)(82960400001)(2906002)(122000001)(5660300002)(4744005)(83380400001)(316002)(186003)(2616005)(508600001)(38070700005)(8936002)(26005)(6512007)(86362001)(6506007)(71200400001)(6486002)(966005)(66476007)(76116006)(91956017)(110136005)(66556008)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1I2R09RWCtmTEM1dnRXSWpyVHF5WkNqZWhCVkVaNEtaSXRVN1BQUHUyS3Yx?=
 =?utf-8?B?bkpnUk9RL2hLdmNxUGdQNDYrZlhBU1pNZWt4M1R5UVlUZHppY05NR0NqM2VQ?=
 =?utf-8?B?Ny90WFFrOTI4akJDSmF2UjZDSE4vYzR3V1FvenNKS2l0WWNPUHRUZWhON1JK?=
 =?utf-8?B?QnVOYWx4d2JPdUxOZklIV3k5VGpCeThLYks3TDdUMFlRTmNGQmVhYTdZOWdB?=
 =?utf-8?B?QTRtR2QwT2FkMXF0NElMSmhHRXJPVVUxSmp5NWhrVWhFRTJEMzdWdmZWbGRO?=
 =?utf-8?B?MkdlTHhMSmNnSVU3T1BVYjJ3N3p4VytsL3FqNDgzVDVnK3crcFZ4K0dNL1pG?=
 =?utf-8?B?emJ2d2dDN1plRitkVWwyOVp4V2xmZWJYa2dXUDVPYkcxSVIxbEdxcVJ1OFpF?=
 =?utf-8?B?Ny9OZ21LT285MW93dWcxekVWMER4UzhDaTBpUjVjTWhJbTNidDRWZWpYMkU3?=
 =?utf-8?B?Q2xUTVBWWkx6YUNGVlgxWVZPNjdEb2FxUGJDUzgzWmVrazRiOGhWZXpiRG5K?=
 =?utf-8?B?aWhDOWZ6OEhBRTBFRGRPMVEraDFEbWp1SDRlb2NuS1V6T1BSajNSa3hqZDN2?=
 =?utf-8?B?RlZhSHlVdTIyS05sV3FaczZoWWpGN3lEdHFTWXNhMVdnUzAwRVNObTB6by9X?=
 =?utf-8?B?dk5NOUJVeUlhOFlnSE9SblNjcThseCtqQXRrU3RZRXNiM0RJaTdXaVUydGQ1?=
 =?utf-8?B?b2NmYm5OVXMzY1I4TCtiREtndUM0QU15ZVBNcVZLMDI2M2l4U0EwYlBEYjhj?=
 =?utf-8?B?emlJdVJFRXNSZTRKL3A2Vm51Mk9LMWdPTHR4eURjR2Z2UGh6WnNrNjhvQUpE?=
 =?utf-8?B?YXArRy96aTRpWjB0STAxbGFocEpINW13c0dmcnNhajZLM3pSeGJ0S1E1YTJj?=
 =?utf-8?B?Z09PUUo2TE1EaXBSbmxUdVdtRndBQzdzNy9OcDhYUXNGeUJYblhvc3BmaXBT?=
 =?utf-8?B?c2NmNVE5c1ZaeGIwWDFsN1ZGVWpiRlp4SkFFc01ubXpJMlc0bTdDOHpWZit2?=
 =?utf-8?B?eGQ2NHNUVGVLeEk2QVNheTZQdEZRQjBNT1dMMG1RempPVjl6OWVRSS9mNGUv?=
 =?utf-8?B?WWQxdFVucmlrNXN4Vll5UDFUdnpLSTJKbi9mWHlhQ0pGYzRxenR0NWdkSHpo?=
 =?utf-8?B?RXpjRS9GYTdaZ3JTOGFtMklkeEp0Rnp1VFRnTVh0ck9SSk1GSUh2YVVpdzJX?=
 =?utf-8?B?dm1acTlSeDBwRUxvYVQwd0pBdDl0TFFRZjl1M3kyM2Nwcno3OEp3Y1NFTkRm?=
 =?utf-8?B?Y09ycUUvYkJITWNhb2R0Q3d4WlZpcjFRck91QVZ4ZGJtMW9wdDByRmtzend3?=
 =?utf-8?B?WHpTcXpEM2ZmREpseWU5Z2lWTFZlNThBQVVHSVRmWjJVbEMvUkphQmsydmhK?=
 =?utf-8?B?dDZENnA4R0hWU29qTVFWNGNIZlNSNTU5VFg2WWhha0dxQUd3QWg0OXBKcHUy?=
 =?utf-8?B?ZFhiVGZ3ZGVzeW1DdXpnZjBaN245MnBpNEh6cFFnV0FXUVQ2b2I2eUI0c2h5?=
 =?utf-8?B?SnJ6K21OWk5TWExoVFlPZ3lDd29VMWxobUUvVWtOeTR6ZDQydDVoL0J6RTIv?=
 =?utf-8?B?QW9xVHp5cWZBZmVkRktsVHpybHZaTGxBM01XRER3Q2xUbzV3aVNkbFlQQldG?=
 =?utf-8?B?SHVjbHQ0ckI3Yjk1Q3ZsRjRKZjZEQ2MwTGQxMllQMGJTNzE2dlQzSFdGZFo4?=
 =?utf-8?B?b0VrR25JTCs0Smp6eU1tU2VQZUlFREpqeW82TFE4eUxLdkpzemhYUmloZjRt?=
 =?utf-8?B?TGNvODVXTzl6eHVsdFVTV2Y0UnEzZDJNekZDUkxSTWE4ejMxbEpWVXpab3d4?=
 =?utf-8?B?Rk9nZnYzYnZRcnlESmJQb1dPNVBrSVA1M3g5cDlpaS9KcEZJVW5WbXZVemha?=
 =?utf-8?B?RFRYdjhyNjYxSmduR1ErcXFRZGs4K1hRRlZYVGZZVUVZZ1o4aEpxWWxFaVJv?=
 =?utf-8?B?dzVrc1RhT0llN3FSeVdDTE1DYjRpZFRKWEFWVG1EUkgxZDhrRWw1ZDhHcld6?=
 =?utf-8?B?azBXeEFRaGdJZHR3L3U1c1JySUVnQ08vQlFnS0MxVjlBV3NzYW00dE9oOXpu?=
 =?utf-8?B?TzJuQldWZG01OU1BTk5mSTk5dFNtTkxqUnI4YUZvRy9YbDhtSCthZTBpZ1Rj?=
 =?utf-8?B?bE1LbnRZNDFGY1pLbDRTZUN0WE94UnhyMzNGRWp6UWVoVnU1SllMbTVqRjFD?=
 =?utf-8?B?bUVJYUpBN0YxK3d0dGIyQjBVUTUrWDZ1RFBTclBLR3puUUpBSWc5ZVFITy90?=
 =?utf-8?B?Vmk5Y1BpWnJGbEFjaWJLRXR6cHpnUEVoSnpnNTViZlJvT1UwaDQxWUNHN3Zm?=
 =?utf-8?B?VjJGWjErZHhjOTV2clAwcWdUU3BKcENkSXViQ21OZk82ZHdwNGJmU0lpM0gv?=
 =?utf-8?Q?WEcKzg/IGmcIYXp0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CE03C23A8A7A74C9A7C821C8EE4CBEE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593cafba-3465-4331-aca7-08da1cb77afd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 19:05:59.3603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P6FSkyjjBt0H42IvTsTPCCwT+Sq0OTojywRCSs9BqQi5F1uFFwZDNnUuevR1UaJHIR+50Q8rf9rwEDQxtOIODGA2TrFy4bkAcC3lT7M14P4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5501
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIyLTA0LTEyIGF0IDIyOjAxICswMzAwLCBncmVnb3J5LmdyZWVubWFuQGludGVs
LmNvbSB3cm90ZToNCj4gRnJvbTogR3JlZ29yeSBHcmVlbm1hbiA8Z3JlZ29yeS5ncmVlbm1hbkBp
bnRlbC5jb20+DQo+IA0KPiBTZXQgbXlzZWxmIGFzIGEgbWFpbnRhaW5lciBvZiBpd2x3aWZpIGRy
aXZlciBhcyBMdWNhIGlzDQo+IG1vdmluZyB0byBhIG5ldyByb2xlLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogR3JlZ29yeSBHcmVlbm1hbiA8Z3JlZ29yeS5ncmVlbm1hbkBpbnRlbC5jb20+DQo+IC0t
LQ0KPiAgTUFJTlRBSU5FUlMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5U
QUlORVJTDQo+IGluZGV4IGU1Y2U0ZjYwNzg2ZS4uMjgzZGRiMDYwZTZjIDEwMDY0NA0KPiAtLS0g
YS9NQUlOVEFJTkVSUw0KPiArKysgYi9NQUlOVEFJTkVSUw0KPiBAQCAtOTk0NSw3ICs5OTQ1LDcg
QEAgUzoJU3VwcG9ydGVkDQo+ICBGOglkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2xlZ2Fj
eS8NCj4gIA0KPiAgSU5URUwgV0lSRUxFU1MgV0lGSSBMSU5LIChpd2x3aWZpKQ0KPiAtTToJTHVj
YSBDb2VsaG8gPGx1Y2lhbm8uY29lbGhvQGludGVsLmNvbT4NCj4gK006CUdyZWdvcnkgR3JlZW5t
YW4gPGdyZWdvcnkuZ3JlZW5tYW5AaW50ZWwuY29tPg0KPiAgTDoJbGludXgtd2lyZWxlc3NAdmdl
ci5rZXJuZWwub3JnDQo+ICBTOglTdXBwb3J0ZWQNCj4gIFc6CWh0dHBzOi8vd2lyZWxlc3Mud2lr
aS5rZXJuZWwub3JnL2VuL3VzZXJzL2RyaXZlcnMvaXdsd2lmaQ0KDQpBY2tlZC1ieTogTHVjYSBD
b2VsaG8gPGx1Y2lhbm8uY29lbGhvQGludGVsLmNvbT4NCg0KVGhhbmtzIGFuZCBnb29kIGx1Y2sh
IDopDQoNCi0tDQpDaGVlcnMsDQpMdWNhLg0K
