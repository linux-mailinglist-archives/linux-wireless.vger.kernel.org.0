Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BD5597F9E
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Aug 2022 09:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239136AbiHRHzy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Aug 2022 03:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243965AbiHRHzw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Aug 2022 03:55:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B080D5A89B
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 00:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660809351; x=1692345351;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b08rQYIorFWJTZEq1epL12m1FQcNynCr/uwOnOCSfro=;
  b=ddouyV+hqzuoYuJqszbGJRqvtVMPNywku96+FXPD8hiCbcOQTSm6lfHE
   IwaeKF/M1jfDlxpsK+mKHtj8vmrPWhnAz8Bb/o6yBj3q180FUnQjiS3+J
   Rnrqhnw1weK7KYjVe9psVui4MFoq5RSCighFd8lTzKhmF2BpYgO2iVdcf
   hWuvolrNsU1/BojlAnXgkrnd5TglaojTFLQOGt6ws8NbTyZlZVS4+opji
   42qs8BgEFlvT4SYQqddRupHQ4sceFiwSOXKfYGsZsT/v1/PqLD1KK6+nf
   xbNFih08tbrI1vXz/3K0YsX3VQnXv04CkdGTO8Vz4VYGEjbL14MENJ9/6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="275741899"
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="275741899"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 00:55:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="610920720"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 18 Aug 2022 00:55:50 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 00:55:50 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 00:55:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 18 Aug 2022 00:55:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 18 Aug 2022 00:55:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vg2RWoqUSQH13XcVfs+vVqJknUmhkdIUfx+IPqkTwi9UwIxbaTJBDo8PE8jQ/W27JgqO4y3FM9Nj38AhLhMJ6Z5hLw/u8YbdudrcHarvVjlqbZIxaibscAaIxh6YN7Z6ggHMQ/CC6J5NyyigPM+od3LWxt3xUIC0zL0IYLY6a1uAjAuBaqsrmv34ff1Pf/u83z9IC0FnruCZ1qQK0ZA5xuK0KPK/diq8S1wzTIT2QfpTjd2Uj88Hs2C4HF3zYuyn/99afHBkCMa5L21cVAwPtVkIPy/Mu6JGKYvtgSukfCSNo12CleA4nFioGNGDM/ZPWxYZ1+cUrPlv8i88LlbTeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4MD/1uyXH2eyAO8yAg7jcgMfFyofRGMbEFguBTXLd4=;
 b=TT10lZ8Fv0vlllPHlER23cOVFteKoQzTBUpG2fInkCT5MXtyq+OJwc4QX6aLzyI/Gy8XLiRzScq1l3e6lnihDTE1XtXqiGkd4+bFeqzzfqIc49fvl3IjUivpnr7BH152iv8xn3m5cBQW0H/NL2bRGwmtY5QQooU1No3adXOqpb3eZ3EBntPgI323L2OsJpf45W1slY42pcvNwyZZFZOoZQzAzyJmzxg/mBrm0HmZ3dClLUARpPQJ2OOM48ySIiYxcl0KuWThrIgq+Y4NMFV4DUcYr4j+PusJlbSd5TmKdivq+I2GsSr8EQsiHctzm8oQGLnUDlqybEMKzGBfJjB3vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 07:55:48 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::81d4:9e2f:fafb:35fa]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::81d4:9e2f:fafb:35fa%4]) with mapi id 15.20.5525.019; Thu, 18 Aug 2022
 07:55:48 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     "Stern, Avraham" <avraham.stern@intel.com>,
        Joachim Breitner <mail@joachim-breitner.de>,
        "toke@toke.dk" <toke@toke.dk>
CC:     "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: iwlwifi devices disappear after suspend on kernel 5.17
Thread-Topic: iwlwifi devices disappear after suspend on kernel 5.17
Thread-Index: AQHYrmd1m9mnobFl60mNdzyBf8NdY620TwMAgAACz7A=
Date:   Thu, 18 Aug 2022 07:55:48 +0000
Message-ID: <SA1PR11MB58252D7615FA77692983C3D8F26D9@SA1PR11MB5825.namprd11.prod.outlook.com>
References: <87ilr4hv8k.fsf@toke.dk>
 <10b81471b9f1af8b15bc5b9a06792a0a605131fc.camel@joachim-breitner.de>
 <MWHPR1101MB225655474DB1C0998812A1FBFF6D9@MWHPR1101MB2256.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR1101MB225655474DB1C0998812A1FBFF6D9@MWHPR1101MB2256.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02926d13-805e-4c73-d778-08da80ef105d
x-ms-traffictypediagnostic: DS0PR11MB6541:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CfUbIzVeAalPAoV8q8s93PkiIbErf5tuKJWEiiGJf2KqAnornXn25MpD0NGlcmBjN/oho7w9ySa2YvMfVGSRkJHbNk5AqfLNoG1ZsNjlVxEG+G1rZQgo7MyHkwLB3y1hRg5uHnqfwQsY8S1LNbVsmf5fj3d0yHfH1Iz6eeo95b2l6pcaHf/utxIqTwcDOul9Pv8gTzBmS6gKP8SyHggeR/KAJE/1buR1Mb/nScOS1H9PHJbSCL1RsNl9TM4pEzwPOHAkoPfZaf2j/dimztcP2xynFQmvrXD5ozKUUhHHmPXmGNfI/NAa/Xyc/xEPPXRTjxxAznfk7zYAqku/SiBX04bj/EfnKA4W0MYTbfSiXovDyUBBfrS+dz0YdXPc4XJlK2AOPN3hMrOFZwCMLUn1Wp3TiihpaLTOoIGeU/r+jTpHuyeRGio4p41S1MMV/o2Fj91lOoyjtEtiy0PHi9T+M1xmkLZ1jZIOCTdoYWtlp3Sm65oaVy9/gB/srrgwtXF18XQSkapIUIlWQND/ExMIAVtQ9EoIyl9Q5UTPenF5t6bK9aVLRz2dJjRNmHlvCbPB4NzKgrN1J+crKaL3PumTft4tOZzQcMrR8YzLK9RiID8GEAds9JnWKUy9Qov2o+rp4bOmw/BB5Fe5w7HV2cYO5atj6+iM+jD+DScb1ePgz7WWUaeKpvZMsGUiLK9LDd2NI9pXY410Rp3xIqpodPo8Iqcry68aeFT9fNHXzmhq66OBvDrkJah/1Twf6pLTfQBI8Tny99YJg6y/Hsi4bhi8gI6hHwejQ1+lJOk1Sz3cmCx13PNNcqSqpfYMviANTQ8oC6LCA9hLpPqf/QX4qt9ABA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39860400002)(366004)(396003)(15650500001)(33656002)(478600001)(86362001)(9686003)(7696005)(6506007)(26005)(41300700001)(966005)(71200400001)(53546011)(2906002)(122000001)(38100700002)(82960400001)(186003)(38070700005)(52536014)(83380400001)(55016003)(316002)(54906003)(8936002)(110136005)(5660300002)(64756008)(66946007)(66556008)(66476007)(66446008)(8676002)(4326008)(76116006)(18886065003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qIusY/E9li4AssjZBZTgon2lXd6zkgiKfiydSpl4uAZq+oGmQn9XZiG2ar/8?=
 =?us-ascii?Q?jkKJ+z0OlDg+eNuAmCMd9pIYoRNNbd8kj43sV7Kcy1rjDDs7Ct1KVJh0/rxa?=
 =?us-ascii?Q?vnEDEq639hAXIJGO7d7t+Lt+7yYg6dslawRi4rYMKpreud7oVcFCNL+SV7gY?=
 =?us-ascii?Q?7IqAMOmP5V7aXS5jzHEqpT6PB/hJ7DboAY91gWmeTrUHTBzsDJX1A5wpVPL2?=
 =?us-ascii?Q?K7f2mcgclBmomPne31gpz3lGFWu8IjaRu54fuBGNYPEp2ZZ8bUrtyn0i6bG+?=
 =?us-ascii?Q?PGpn7gfYhWblgG7MYVX/lGRzyYSez+9H3moJWhEblanLBHwj/qg+VrHK2lSx?=
 =?us-ascii?Q?gcUWNFiCmpKGh4/m9+UR7DA0Q1csaJwJewcGu34+MQr/wBgb5yLeOTooVoto?=
 =?us-ascii?Q?yMQsPMXwwpAkf7kGaABxsc8SGHvSGv4MYgG3c+WJxnSWl8/9ep2J4Cf+Ufkk?=
 =?us-ascii?Q?++jZ8Bt864DzbIIWNhGIIX2Q27C3LQpkSA5x/5+oKrdyWLKTDDBBeRKh1SMy?=
 =?us-ascii?Q?7fmsXlLs9a2sqXaIwJ3P4n3yFv9ChjPX5MYPnGVQ8V2gPB6rFU4s4bxZ0CTH?=
 =?us-ascii?Q?ur0irx24z4V0L089dSwh7RlzZNoC6S5gvpqDT5i6sNXVDpejHtSVRrJQcgUZ?=
 =?us-ascii?Q?WLoZe4or9TBsTiirOko8Nbr2jUeZO6EyojmGHau5/aQUlf0aqT5tYX3BWMwO?=
 =?us-ascii?Q?iUcDXzDyTHNJllMHLa4fX9MtkSftI6adx+DV5AVtYOPBgfEOJ+QeBUaxQkwh?=
 =?us-ascii?Q?1RLxbb2Du385opD7K7uNLgAUSCY8dUpfHH1TtLYLwSB2j15FD1t0lNObCR58?=
 =?us-ascii?Q?H318hlZkaKzKTTzg+jU6rOy/zN/6uWmGTa7OCFSCv1zrZDCeOO5L/RVFlWfL?=
 =?us-ascii?Q?J50LT3Kd/0IQNXYFP9cWx1m/rdBFII2GrvMtggf1XxWaokI9S1PFl0AbNLdr?=
 =?us-ascii?Q?4Oxtrh5c9j/VfBxHS7otOz/9f4sYLtB8h4HVy8DOdZHu6FVNmxLGI/3Oxgj5?=
 =?us-ascii?Q?yY/NxsQCuWyr1p8Vty7kbjY7nS9khC/9jK9nHvBijvCNMkf0L0QqO3JERs/4?=
 =?us-ascii?Q?3PxifxrACSMk3H34HzFnaY9Vql2vLQ+feYou2K+il7sgeYluOYTz1yauy85d?=
 =?us-ascii?Q?O5EhXc9tpObI5539wZqUnF6L0GEjOo/oe/BHwZ2fMQscA1c6LEeSrkeMUlLT?=
 =?us-ascii?Q?Meuwg/pH/IH7q2WIEeqhSDDUX0W4Sap2kwy46JqhDWjttZBPfPI09tMqYkA4?=
 =?us-ascii?Q?9f5N+cnGXm3OA1mZW/4a09Orj/ppe+vLWZNysi3pUUajiOeEqASpLQV+JuJA?=
 =?us-ascii?Q?SYZipGsWG76wDv3QMPw5RwuPzbD1Bhs9a6/gd6ts5XeqaElXx7hCgtkMlOqv?=
 =?us-ascii?Q?uWFh/ZqkO+YjsLJSBqCdOMcXfHN/+2lHTRg+DqUKp3VARjeC+TVnKya/ibgj?=
 =?us-ascii?Q?VXzEWN+E7BmE55wvXuoIH4f0jXNRlhlKadWFb8omnvXTCjuT42L1HuH/iyV9?=
 =?us-ascii?Q?yIf6xMUBtCOtv0jsJCsLfFK28LUBHzolxrS2ayKa7wh7KINZCp+j+2IUqrBS?=
 =?us-ascii?Q?5sLmBD1fmDkkQ8xOCG6uJv/T9pFGq/KVa3BFVLPj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02926d13-805e-4c73-d778-08da80ef105d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 07:55:48.6314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wxDI1ktjV3uwbs7Poc9c6Rswbcx93IpUdkB+u+45xHoRrUMWJZQ1QR1omLbBkL+FrLKFu2LXHc1dYppjcK/8e7ONGTNzq1p/5pv5ZZIS4kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6541
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>=20
> Hi Joachim,
>=20
> Do you see the iwd task hang stack trace like in Toke's logs?
> Can you please send full dmesg?
>=20
> Thanks,
> Avi.

FWIW: there is this fix for iwlmei that didn't make it upstream yet:
07f408bb49cc31dccc45c5150e6fbc26a608db10 in our internal tree.
This was meant to avoid the error messages that Toke reported, but
didn't fix the interface remaining down.


>=20
> -----Original Message-----
> From: Joachim Breitner <mail@joachim-breitner.de>
> Sent: Friday, August 12, 2022 19:20
> To: toke@toke.dk
> Cc: Stern, Avraham <avraham.stern@intel.com>; Grumbach, Emmanuel
> <emmanuel.grumbach@intel.com>; Greenman, Gregory
> <gregory.greenman@intel.com>; linux-wireless@vger.kernel.org
> Subject: Re: iwlwifi devices disappear after suspend on kernel 5.17
>=20
> Hello Emmanuel,
>=20
> > suspend. I get errors like these in dmesg:
> >
> > [104393.142264] wlan0: deauthenticating from 4c:60:de:ea:b8:58 by
> > local choice (Reason: 3=3DDEAUTH_LEAVING) [104393.347775] iwlmei
> > 0000:00:16.0-13280904-7792-4fcb-a1aa-5e70cbb1e865: Couldn't get ACK
> > from CSME on HOST_GOES_DOWN message [104393.347876] iwlmei
> > 0000:00:16.0-13280904-7792-4fcb-a1aa-5e70cbb1e865: failed to send the
> > SAP_ME_MSG_CHECK_SHARED_AREA message -19
> >
> > And when the host comes back up, there is no connectivity. Restarting
> > iwd fixes the problem.
>=20
> I am hitting the same problem, on Kernel 5.19, with the same Intel Wi- Fi=
 6
> AX201 device. I reported this initially to iwd, but they said it might be=
 a kernel
> problem, so I found this thread.
>=20
> Has there been a solution since?
>=20
> Thanks,
> Joachim
>=20
>=20
> --
> Joachim Breitner
>   mail@joachim-breitner.de
>   http://www.joachim-breitner.de/

