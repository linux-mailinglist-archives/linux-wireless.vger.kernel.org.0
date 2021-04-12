Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F47B35C5C2
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 13:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238448AbhDLLzq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 07:55:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:31276 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238121AbhDLLzp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 07:55:45 -0400
IronPort-SDR: LvuqvC1nCi2MVFJr5uvztgXYakfQX6INxJ/Ynb1sh9w5G4Tp7qssykawaPBd5gXq1aXCWsvzvL
 1YacbvOoCdNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="193733744"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="193733744"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 04:55:27 -0700
IronPort-SDR: i9Sx+/bSkSj3Me99zUJhuZoYa4sbaW44IY4aK2xEX6lgGFmTE9d+re3CVnCLOgWC++nSmDfNU3
 lCke7DbNk37w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="521157897"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2021 04:55:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Apr 2021 04:55:27 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Apr 2021 04:55:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 12 Apr 2021 04:55:26 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 12 Apr 2021 04:55:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ra7VQ8sd2Wx4Qm4Q8z58MPz2mq6ftwLDD78kXJwbnLgj1Rhwu5mE/75u6tJBrSGiY4UDDN4RxfmmcPRUPKMmQv5BjinZobz0u8+o3iCK/MVIACnAH4otF8Loi8q6Gn5TvWZI4y+kVNCnT46tEbU28fnhkpn/lEVEZ27IDhm9cVQ6UZKCgn8Z2Rd2r/u+VHwYaRjYajH7uwPtTDQcb+Nj67uedfG+v8rzqnPj1GV29hD2vDGceGHLusrEiGjV0bkxQZt1SFuSwsAVXccEeqcBy/9Y7JajpMWEoXuussgtij50awNajDUkGcuD6prYsmH+fHV3NtcxP5Jsfqyjn7dn0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3vCmJcVKLOHU2xQaOp4mewZju23rVpMbS0XiB2UT2o=;
 b=awg2c/RZeK9pODo3/zaKWiVEXcpmNhJFXaLXfA5wsrBU7+wRM+WtW/1+VgE5KeAM4mOEM92oiZ9M35JiniZlzFIj+MWe5GE3HOqw2rka39Pa6wdOP0lR2w3O9HCfFiwrr/ZrAlYnjVZZjrWhq8DVLbfwvYfw5M5+lemRZDbKxWFhxvPB+3uBE1L9URe+H63mt7Vs1asipPfIgCZpBImT2IrzbNBPAE2FcjVA8PWqkmGe7iKO4w7SP5uOr7HR/BCathsy2bA0upcHO6dhQd3LyjtmHSs3YOw6jHhaWchDHAAJTRO3iGemmJpP4UjJrbTTiXkaKaPPLoZ2o0XIy0mn5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3vCmJcVKLOHU2xQaOp4mewZju23rVpMbS0XiB2UT2o=;
 b=XQRnqrjYnZMijft9PTYACHlEYRu0oqiAbfYL2KO+kjcqoo57Eu7FA7oQ+mr9NmZfD49dWWQkyAWHPJDvEjGGGBLCE4Mr0Av9R5FM6dIlsiRG1vUw8GCoOUCaQTPhxqxid6mczSEEjvLz8O0xL6Ai+K2A0ot+GHuwiRaeuAjGr5Y=
Received: from SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24)
 by SN6PR11MB2925.namprd11.prod.outlook.com (2603:10b6:805:cf::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Mon, 12 Apr
 2021 11:55:23 +0000
Received: from SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::dc7d:1696:50b5:8598]) by SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::dc7d:1696:50b5:8598%7]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 11:55:23 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>, Luca Coelho <luca@coelho.fi>,
        "'Greg KH (gregkh@linuxfoundation.org)'" <gregkh@linuxfoundation.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>
Subject: RE: pull-request: iwlwifi-next 2021-04-12
Thread-Topic: pull-request: iwlwifi-next 2021-04-12
Thread-Index: AQHXL4nvuP/xcvCmYUO1k2ZddBS9DqqwwyYxgAACUfA=
Date:   Mon, 12 Apr 2021 11:55:23 +0000
Message-ID: <SA0PR11MB47522E7EC6ECE33A9D1068BDF2709@SA0PR11MB4752.namprd11.prod.outlook.com>
References: <ee6d5faebc25c8fa447cf870cbc80b4236178756.camel@coelho.fi>
 <87v98rlod8.fsf@codeaurora.org>
In-Reply-To: <87v98rlod8.fsf@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [77.124.181.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef0120fd-4453-4d09-24ec-08d8fda9dadc
x-ms-traffictypediagnostic: SN6PR11MB2925:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB29251C50C5257AA622119817F2709@SN6PR11MB2925.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5+T/txj3vAQJu4LDpqItEei4hxlSC94iUowFgtUw3GatMHF8UfD/d8D2Lr3g6HPg6EqTDyV//BQCQrPtdYAOX9tkp0+NmXICWI29saGQ+Bfe5ivJJotKC2AAlhw9UYk443okAYCF76ooA72VzzJAjTBUc0lzTxGtmLCFpZdc18ZTZcKxPURii4Gq9pUEO1eXgDbVLkJx+VnAaq3s0dCf56S0FZwaBGnk87pZq1Mjwq2zEhX2OtrMmlVsCtHn/nr+EBVfw/Ve50rw4ceLYqsCFXzy9C9ihACzo7JTOrmq/5zuR2DHMxi5uHsk53G6CLXESIYznwQfl1Ti7cU3N9kHjGTCIE1bJFAgmvulz4Sj88dXK9VXYbJTiYFWzybUuOXUVBfHZqDL81VLZxiChMyya7juxP1OdLzmTAaO/T5XHb8VdnWIkDxeoDmLmXSiEnMzYOsdzBgk/cFSyTLbmPcwXBxID5rnZ6vYn+lX1ZlkLoWywiNuNCtq6RT0dNa6lwMqyeG7B+u+Q/iE1LwLbvAQPBCqTfb7uerPBpczYZFZUzwtIcGeFHBqbZdkUSk3VKhaz08PfQPOCBUE17ZjlpxKi95Fd90efW/TIJ7vHjMgTiYFDAHq44ns1uV6ipHzxHyzQb4ENbWFRFKx3/e0UgJsF+qE4KUSjmLsJM/zoL1r0s4Q4CBOKwe6nq4ATkIq9C5O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4752.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(39860400002)(136003)(366004)(38100700002)(4744005)(7696005)(966005)(5660300002)(71200400001)(52536014)(6506007)(86362001)(54906003)(8676002)(33656002)(107886003)(64756008)(26005)(316002)(66556008)(66946007)(66476007)(2906002)(66446008)(76116006)(55016002)(478600001)(8936002)(110136005)(4326008)(9686003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?grr+IwKtuxXvBxdxNv4oWdundI9Czvno/5Nr3blghloBNHmpncoZaaO1nNQp?=
 =?us-ascii?Q?yC2UFwsJ8kp5Rq/vRi9ir9491BkPPv2rWxr/JrCVV7dCi4wh1WN7AE+b4sr7?=
 =?us-ascii?Q?zVG4ozMXUhwNXvmfHtfUsCS6kq92X+4RJV24p/hSCaUULBzV0M78/fQvu5CG?=
 =?us-ascii?Q?t5visZnL6EymYH2ed+nlQ1930mdnnRPflQzclATQdhuaAZutTMl4AZK2fvSa?=
 =?us-ascii?Q?esCRBKTUWhegu0XyWBcFLcS0DluPNJNjBgoZTKYkvn/63BtlEglDxvuLEz9I?=
 =?us-ascii?Q?r1WwOPwbDxQWp4p/TfyEltMistKImYEz0GNzcaF4vAy61ugSDPsX0Bva3oA1?=
 =?us-ascii?Q?rOvDQX2gxKat6YIv5RpywBSulsxCp97Hkavu2TIVU9MdA6JlOqTJgkmLlr+F?=
 =?us-ascii?Q?E0RZYEq7pgsyNoIf3xFgm4HiigS0SH5KvkLn3VrPWI8vOLyNx8d2NsVgvpdV?=
 =?us-ascii?Q?2cbnlzeeeY5DxfxghRQ+UJQRv2q3M9IYMS//HFJW/IqXKoW7j26ylUKPc24W?=
 =?us-ascii?Q?qzuyco1UfKxZqEQs2iYs7eWgQDhqUoUVbtM2dDGXkKgFn+3Y6+1FwVQDsxqm?=
 =?us-ascii?Q?t8a2d2iNIjEKWufuApY90bxL4HVnWuD0W9MtVyPA3KlCXK17sFaJ0XPONekI?=
 =?us-ascii?Q?uNid2PtDmKJQ98SZEcfO0undIOsJuwNSJo6ISIAC646P5NwPJEmZiq37t/7I?=
 =?us-ascii?Q?Fbx0My/ncN/7Da5nDe/wNlzno8Kqj11qBJi32oC1zwqdGu0q/NlUsX7Oq2Qr?=
 =?us-ascii?Q?KfpPiaUcnosDsZIOTdrRNzMUHtUJuO4PAZ3k1qLmHZfjBoXczggJ4O1zO2zJ?=
 =?us-ascii?Q?Csb0IYU3oXqRFOWVMmgUQGsJU4rjNG72rHWgSeJI3vr+cY9T5Pa346gXMj4G?=
 =?us-ascii?Q?DJ5VGjRQbUoUlOwMHD4fGR1W1RFLnSODRqWk04qEk5N4QK+ioMrUgpnIyt0f?=
 =?us-ascii?Q?UsEm1rl3pyDHDgdqWqIzfY3Cm/xQl19bPfxec+pk+WjWelbPa7mykZZ2+n9J?=
 =?us-ascii?Q?ukhbQ0MbLGbprnM8ryxys6DCV97Du11Tzh5YJn+TlSK+Kdrsx/dcdJGmhLcW?=
 =?us-ascii?Q?Zo1lefS+7FP31neu+cwbRm2QBOBhp11C96Or2Oht2r77kDif+4/g5B+3EH0B?=
 =?us-ascii?Q?cpj0XS44pyQhr349NLDVTfDY/N/E7uXwVHeTk5AHog0aO2bZgLQCHHsIJuM1?=
 =?us-ascii?Q?zQ9qO3bA4Ih36OyYeWwS9YZVFHRT8oy7TL9DL4tehB49J6IGE/cnxsBDC1+Q?=
 =?us-ascii?Q?92LnvHl+IR38FBhshStlxXqNheHZN1t1WSC6d+uzUzbdH8gtI6w0rBAfDhRd?=
 =?us-ascii?Q?k89jx4t6A8mIGobKRiRL5S9v?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0120fd-4453-4d09-24ec-08d8fda9dadc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 11:55:23.5289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kck4lQ9dIhykHFk2UD9knccc978Ms3XF/YDDZeS7y4IPC6kBgQOzSNg1+WW6Hr9M5FRYztiKxcRj8Hb4od9XlwsUJZMy/YLVMZMSOgsLG7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2925
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ Greg

Hi Greg,

>=20
> Luca Coelho <luca@coelho.fi> writes:
>=20
> > Here's the first batch of patches intended for v5.13.  This includes
> > the four last patchsets I sent out for v5.13 with the usual
> > development work.  It also includes Emmanuel's series for adding the
> > iwlmei driver, including one patch by Alexander Usyskin in the misc dri=
vers
> directory.
> > (which Greg asked us to push via our tree).
>=20
> But no Acked-by from Greg? I would like to have that in the commit log.

Not sure if you remember, but Tomas sent a patch to you and then asked to r=
oute the patch through the user's tree. So here it is :)
Kalle would like to get an ACK from you. This is the latest version of the =
patch:

https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git/co=
mmit/?id=3D1b1910e2c82ed5392b90470885d91f3abc1619e2

Thanks!
