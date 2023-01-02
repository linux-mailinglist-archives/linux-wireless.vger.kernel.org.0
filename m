Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3746A65B2B5
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jan 2023 14:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjABNfc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Jan 2023 08:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbjABNfO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Jan 2023 08:35:14 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E956462EE
        for <linux-wireless@vger.kernel.org>; Mon,  2 Jan 2023 05:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672666512; x=1704202512;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ivLGsXn/sf9AxsulYgNU/QA77/T6cJzvDSMU7m7g/EY=;
  b=nx8cAmtJ79cxtdwU+MC7VIVl7niX/80oeEZxxO1OWVlZaRqbjgkXRDe/
   geVGAzXw4I1dGURFuSB05Q6+wr5UWOocWYBek3+Dbn6rI+hYkJfjX2zKM
   B1RYx979MvIiB9qiYKHJTTaoM4/BT5zTvJxEfpHhXj2QTl2sDKNY5zFCb
   ErHIby9TZQOOghaqqZqRu+xlf8P/5Zo+CZVuIF6nStCP6I3vxGYmoq8cY
   BPGvK36apXHhGuPFEKTtD01JhJ4zyoJ4hbX82Qspbz80TxLzDxtBD52je
   3Kml+CVDzF4QeN+RpcKmGsybnuRU5NOIQGtfKJ+g85LVfhtKunc8MnFZD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="319184788"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="319184788"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 05:35:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="656477777"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="656477777"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 02 Jan 2023 05:35:12 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 2 Jan 2023 05:35:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 2 Jan 2023 05:35:11 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 2 Jan 2023 05:35:11 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 2 Jan 2023 05:35:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKFHC3CD2oLQmisi0n0s6bq+qio+mEssYQxJVOtUlACdHy2pNlOA8WzygWMlBbtt1PGjClV3qZpbiLlEruCo4F202aU6XAuDRsEpdpJ85RkWPyBn5bL7gkaiT0IkyixmfLiBfC2jSNsomigfi7wxF7GZIQkjGXXHU0/2lolQGs9G/jQt2Odt94FQFfDagfKFVUw6rOQ3upYCDLYsUKeNFE9Ee1NSfADU+ATDLJX6Ey2/KvYwNGdHAIWn5219QdsfCA7jf5OcTphqPEkG1bZw1Q/Noo/1AFkSMczi4FcA/BzEt7BumxuUlt7PolZ+ih76KHg+A1BZ9Hgnh1X2PQBkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivLGsXn/sf9AxsulYgNU/QA77/T6cJzvDSMU7m7g/EY=;
 b=N53m52yPyFQ0WDp55wdb5uXzESGR3EUZv2pMm9INqCK3izhJaj0FEfaMgsuAsSSLOa0eBdcftvyNnVeYURmYROF5ZkXFpxHAougM1sM8GklE2caMzkWijJyuI+H44gAx6PSojzSe4VdpVwfkOBXhPOStxhXD5GsRRCbt/rlBKYp/QgoOfUkKTgUhsgvTKF0V6Kp0iSgieKQzr0z+INV/XtYaEtUHZd2ddPhXG/qLQARW/j34BcfnaPJBwa+uXtl7AzuFElDbNOwHbicqQcLml2mLAjeS67A8Q8jxc0y7+YNiYS7VAZsJ63xj0COK7mi4m72DHk2Vl94Hygx0aMuDOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by PH7PR11MB6524.namprd11.prod.outlook.com (2603:10b6:510:210::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 13:35:06 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280%5]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 13:35:06 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "aiden.leong@aibsd.com" <aiden.leong@aibsd.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH 2/2] iwlwifi: pcie: add support for AX101NGW
Thread-Topic: [PATCH 2/2] iwlwifi: pcie: add support for AX101NGW
Thread-Index: AQHZHlOjuF2abI1yS0mxGQy3aQuRuK6LIWMA
Date:   Mon, 2 Jan 2023 13:35:06 +0000
Message-ID: <00a7a47051ead3032f383868248d89e56d3617f4.camel@intel.com>
References: <20230102024038.2915-1-aiden.leong@aibsd.com>
In-Reply-To: <20230102024038.2915-1-aiden.leong@aibsd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|PH7PR11MB6524:EE_
x-ms-office365-filtering-correlation-id: 7a7447aa-73bc-41ff-a1d3-08daecc6292d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2b9CCZTpr/Ui0UJH8SO70fjaP3z5xGbGlKWTjd0BGhfiQRJtJ5xxq6nbT+PcVBYNxU4UItAAMGt4F3VSCR+rRAQUUcM+Tfa/2a3nR2M7KLM43GX5mXGY/CViCPWptesDSQh7g2mILhSyETioXHDZ8uDbL2SzLca/KRuWtUrIfnUfG/N3LMu+U73Ju8V+oNcoD5aSseuYScK3zQkoqlnkT65ACrHzR4qTaajVe7JWxgtLEj2ooYaMeMJqCYofhY2y/bkjyXoFJ6oW4QO0qcq0Bnd8JLHFRkSBrF6Cldsc1O9dSBkV6iOkIjaeZMeIla6AzgvHn7UE4YJxNeSgQb4mmittbY+8HDQJ2I22B0bYsoe83IDtKZj+utZnDwK8d8qFlEFe/9Yh9R2wLVmjXl1WH3s0PGBqiSK2rJD/3I4w5breDAYAQp3Q8DUgFwD45TRiDVVR2T3eKdCAGmMSRIbjvqjfq9XJQmmRHM/4CtXu3H33tslKALwn1ExsIE9LwBhie97FXNy69DrdRJzrbAh0H5qlFCf5qzxpGQlzqMw71hjHvGuko9H5sqm1TwD140ksSbVipewHesStEvO9U8B1zwvnL0PVp7PQN59SnEEMKXd7tOtYNS//vjeUA/McXlAKzuSCkaiNAN0AWfMn5W4Gb1OKrz0haJ2Vte0zaiXkQry7req2dqem1xTVtov8wVJWAqAcEH1ibGHPOnk/YJYzPBeIBBx7hEmeaVGZlG4jscT+szjxsS/kro/ZXGKxK8G4HuX71M3ujUKfMd9/zMqr7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199015)(4326008)(5660300002)(8676002)(91956017)(64756008)(66446008)(76116006)(66946007)(66476007)(66556008)(41300700001)(8936002)(316002)(54906003)(110136005)(2906002)(71200400001)(6506007)(478600001)(6486002)(38070700005)(38100700002)(82960400001)(2616005)(6512007)(26005)(186003)(36756003)(122000001)(86362001)(83380400001)(22166006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDFNcTFEQ1dMbFlkUGF1NUNpcm91UGcyMTNVTjQ1S1l3c1J3TlNzQ1pVWXF5?=
 =?utf-8?B?OFUxSmxGQTNIdDEvMzdRblRnT1kzcEt0YjVLbkhtaHZvQXNLT0VvZW9oN1Iw?=
 =?utf-8?B?Ymt4Q3I0NmtPcXAzVHlZdkJqajhPeWR4N25wUFZwNjZtd204YXVmbU96c1d5?=
 =?utf-8?B?RVJCTnl0WDRna3VvMVEvMkxlaTY0bHhOYndTU200ZW1leGlZVDlQLyttZS9Z?=
 =?utf-8?B?RWdrd2tTRERTVCtibVAvYUhxcndhclE4MnNDVS9sKzRmdEh0ekRNamU2a1Jm?=
 =?utf-8?B?QzVrSjNSMllpREV1VnRpWDRMbHJxQnI4MjJLM2RRaTZlUmdONWhRbXN2WVU5?=
 =?utf-8?B?U2NkNFV3YzJvWGQyR1gxbmg3ZjkzRUJvYTBMbDNMWFJISXp6R2JSc25HOVRH?=
 =?utf-8?B?eExxckE0Ky94K0h0M0R5Y2pKQlhxZ3U1Szh5Um82SmJjM0RlMjhRUVcrdjhw?=
 =?utf-8?B?YlBOZGpqeGJNQkVwUDlXQzFmUzVheFNvNzBqd3FGdnlLV0VkQzcrSXpRVHJs?=
 =?utf-8?B?b2JXOFZaRGhJZUZOYm9VQWNUcllWaDViR3Y0cHZPV0JiUTJZY2hZb0RzaFBB?=
 =?utf-8?B?SHhLaGZXelhnNXhNN1RpRGJ6TzVjMWhBM2tyNzBFeXFYRWorcGMyWlhRNTFD?=
 =?utf-8?B?b3pld3pNT3dXNGtUS01CclZBdURVN2ZQTjNtRzFQMG42Y1RDRTQ1WkZSY29B?=
 =?utf-8?B?QUN5aUg2YlZiSGVOR0VKUmdsZXZXUEE1MHBSYVAvZEdmUTlsc05KZmd0Y3JB?=
 =?utf-8?B?M1pOR3h1TnJBMi93aGI2dy9YWGUwZ1Y4RGhMVzJUaGlMbWw5dm9SQVovd1hL?=
 =?utf-8?B?OFFvbnprRjZSbFJGZTBzWlVjRU5iRTZNelE2VU85QWRZUC9YNkN6K2xuWWkv?=
 =?utf-8?B?a2U5cnhzeUlyVDByQnZ2d0JuaHZUOXh6SzlTQTd4UHVlMGpqOGtVMTh2dmxD?=
 =?utf-8?B?ZEcxWm9kQmFNN0Q1MlBCQ2xPcDdpRFlGdUdwa3V4dWJmcWhkMWIwRFVWa05B?=
 =?utf-8?B?NFRva3hFcXVyOWtpZ1kwdUhuL29FMXI0R1BYcER6WGRsL3dDbmRzZjRtSXM0?=
 =?utf-8?B?YXozd0J2dHpjYWNLdVBVS2wwRitCMUtBbkRnNFVPaUZRaXFkRkc2YWlNV2lx?=
 =?utf-8?B?bmdCYTV2emNvZFZiVjFRaDM0amhtakhtN2VjNGRXOHA5MFpxWklFQUZsUGFC?=
 =?utf-8?B?YUIyY0ErYWxDS2tnN2RxSEtuV0JHV1pRM2NEQzQzMDV4R1Y4d2xYRnd5d1Fa?=
 =?utf-8?B?RU1LTURGcXVTbEtaNTFFZHZrSHpBTS95djJSYmsyZXNaTFd0d29PeTJ2bS9Z?=
 =?utf-8?B?UUpFUUVpWklPYWxWRndidlRYclppaWhZNmdMZEFUQTFqTm5OTjR4UzhCVWto?=
 =?utf-8?B?ZVdJb3dRajh2QTB6RitldmtOTUdMRWVEUEp4Zlg5UFhVL0ZTME1rdjR3VDJ2?=
 =?utf-8?B?RUdSMy8rZ3JVcXZ1SlBGNEFnRlp1U3hSTVhCc28zOGVFMU1PYkRDaERISmQ3?=
 =?utf-8?B?eVJCaWRubWw3OUJtNjdhQmJvdVlueCs0UXh3cG81cmo1RUlEcVVFZGF5YnFa?=
 =?utf-8?B?OXBGdExRY2g0K2RLS01MOVh1YVl6NzdkNXFRMCtWR0pDcmVCbWZtL0lTZHVl?=
 =?utf-8?B?SkFSeFcwU3RuR0VkN0tlWWNDYml5dXN6U1F3VWtaQnJvMHlCbDNNOUdyQmZa?=
 =?utf-8?B?ZXlTVXg1eU9WR3kzaVRXOEhvaUFXcnExRmdTK2lSRWhqYWtMQi9uY1huaWlm?=
 =?utf-8?B?czNEOC9Ta1h5dDBqbEp5TkdwWmh4a0VrVzV1d3RGbVZiWU5acS9BT3kya0Rp?=
 =?utf-8?B?U1l6eWs4VlZlSFpXZDJXRlc4UUxFcHc0QWFENU9JaDRVd0pXOUZzWHd5MXUy?=
 =?utf-8?B?NHllb1U1ZDE4NW8ybjZ3ME1QOXd2eHZwUWlhN0JQSFVvbUpCeXh2T25YczlF?=
 =?utf-8?B?VGlJMXdOSWxMaU5ZckhGQ3BmeXhuVkFzaks3V3JzMURBZHJBOUlGT05zMGgr?=
 =?utf-8?B?V2lNQ0pGemxMd215T1pwUngwTGtPWmhkV1VTNi9pRHJvV1hzanJ0a2ZnOUpI?=
 =?utf-8?B?SjdJN3VZdExKU0w1QnE1dVVyaGhPQ0VkUGFXY3Z0VlFua0xTTVdXVWRPNG9y?=
 =?utf-8?B?VmtRT2Y4aFEzQmg5QkFNV0xoYXRDMkpYL0Jnblczc25YblliUGJ1empIVEY2?=
 =?utf-8?Q?VLvACyxDU+W1fkGGwY9L74Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E169F7CCB686914A95C7F51BC8AC2D6C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7447aa-73bc-41ff-a1d3-08daecc6292d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2023 13:35:06.4571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o6LHOsBWxKGCMp9HnXX7EjI1bUpeO2LMpFRg2hzhEHM98IRsfbzetqAh3oTnmX4tFWE4Y6tD2WuhFeuF9GD7vfSd62H0hgeH0KIbRgraRJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6524
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTAyIGF0IDEwOjQwICswODAwLCBBaWRlbiBMZW9uZyB3cm90ZToNCj4g
UmV2ZXJ0Og0KPiBjb21taXQgM2Y3MzIwNDI4ZmE0ICgiaXdsd2lmaTogcGNpZTogc2ltcGxpZnkg
aXdsX3BjaV9maW5kX2Rldl9pbmZvKCkiKSANCj4gDQo+IEEgYnVnIHdhcyBpbnRyb2R1Y2VkIGJ5
Og0KPiBjb21taXQgMzJlZDEwMWFhMTQwICgiaXdsd2lmaTogY29udmVydCBhbGwgUXUgd2l0aCBK
ZiBkZXZpY2VzIHRvIHRoZSBuZXcNCj4gY29uZmlnIHRhYmxlIiksIA0KPiB3aGVyZSBhIGdvdG8g
c3RhdGVtZW50IHdhcyByZW1vdmVkLg0KDQpOb3Qgc3VyZSBJIHVuZGVzdGFuZCB3aGF0IHByb2Js
ZW0gcmV2ZXJzaW5nIHRoZSAiZm9yIiBsb29wIHNvbHZlcy4NCg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQWlkZW4gTGVvbmcgPGFpZGVuLmxlb25nQGFpYnNkLmNvbT4NCj4gLS0tDQo+IE5vdGljZToN
Cj4gUGxlYXNlIHJ1biBmdXJ0aGVyIHRlc3RzIGJlZm9yZSBtZXJnaW5nLiBJJ20gTk9UIGZhbWls
aWFyIHdpdGggZGV2aWNlDQo+IGRyaXZlcnMuDQo+IC0tLQ0KPiDCoGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvcGNpZS9kcnYuYyB8IDIgKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL3BjaWUvZHJ2LmMgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9pbnRlbC9pd2x3aWZpL3BjaWUvZHJ2LmMNCj4gaW5kZXggYTQ2ZGYxMzIwMzcyLi41ZDc0
YWRiZDQ5Y2YgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvcGNpZS9kcnYuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZp
L3BjaWUvZHJ2LmMNCj4gQEAgLTE0NjEsNyArMTQ2MSw3IEBAIGl3bF9wY2lfZmluZF9kZXZfaW5m
byh1MTYgZGV2aWNlLCB1MTYgc3Vic3lzdGVtX2RldmljZSwNCj4gwqDCoMKgwqDCoMKgwqDCoGlm
ICghbnVtX2RldmljZXMpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJu
IE5VTEw7DQo+IMKgDQo+IC3CoMKgwqDCoMKgwqDCoGZvciAoaSA9IG51bV9kZXZpY2VzIC0gMTsg
aSA+PSAwOyBpLS0pIHsNCj4gK8KgwqDCoMKgwqDCoMKgZm9yIChpID0gMDsgaSA8IG51bV9kZXZp
Y2VzOyBpKyspIHsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb25zdCBzdHJ1
Y3QgaXdsX2Rldl9pbmZvICpkZXZfaW5mbyA9ICZpd2xfZGV2X2luZm9fdGFibGVbaV07DQo+IMKg
DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGRldl9pbmZvLT5kZXZpY2Ug
IT0gKHUxNilJV0xfQ0ZHX0FOWSAmJg0KDQo=
