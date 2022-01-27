Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1FB49EA5A
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 19:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiA0S2l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 13:28:41 -0500
Received: from mga04.intel.com ([192.55.52.120]:41299 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232745AbiA0S2l (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 13:28:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643308121; x=1674844121;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5dLddCrNGbJLmLn5aM7oalU/cQSYwKpEtc75/mU3Fb4=;
  b=i5wTrbTzpz2Or4oAh8T4lmHv7YzvtFFwu6P8NgAorldScJuFhZLcelEO
   MtPWTWCVF2pJK+N25G21HkurS7C3M5pUAIqGe9tqml0Gr4K37sixMQEz8
   fGbmBaOiBpb2upcQYJ9IIyakoBO1ltXcdT7gFlwkbC9iPqwL7mjMc2pH7
   j11imxoA9ZaVTJYEWTJsGp/zEjFWdN0UUGjlyyXxJRfgEvHHwoLJ7JYK8
   nhe/Bk+2byy8pttzL/iou0HVeQYNFX1RoVomF1tfHlrVI7Qv7Ii/XEk/Q
   LZP9sGxYQrecmPY+oDwkKm5f+k97WRSIcCIut5GpLRay153rVDh6iwdAH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="245774644"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="245774644"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 10:28:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="767604465"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jan 2022 10:28:40 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 27 Jan 2022 10:28:40 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 27 Jan 2022 10:28:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 27 Jan 2022 10:28:40 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 27 Jan 2022 10:28:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5zvhrCiwy3tpaSysRDh4NuOqA8ImJfhsqrsZlFDtpUySSvCXco1JQ8tUwI38VcUxsVUJ1sAzlzF19Z/g3nPZnAjqFH1MTSdIgKerQEIy7e4g8EG7Mqy1gnCCWshUO7l/1t5zwyXPE/J7frtV0TcJ6py9dOKFtVPbtztvVEP3QUz72Gxztk3UPsGBL1kM+4zBepVapWkr0eWTSnc2tvkblZEIaVnEotVqXCUeGDQqEZv2wa6gUaqDHmhD942H506vXorciVhfDnyUlu1ejLuN8GRAm6YTk0jZE7/AbbkgyNEN2xGKcvJMFq9o6wTvNXF7MwdR+y93JN30IQVlJK0Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dLddCrNGbJLmLn5aM7oalU/cQSYwKpEtc75/mU3Fb4=;
 b=fkQ7U9QcPV3xKT6dxlN1r4xYrj98ku3NHi53TtHgIat+salmKHupg3e3Mpe59qmA+ZxXstIDacxrKhmBuMZZYHCy07ddSYnQvXHiVCVtVG18L/SafQoPFzzwHXhz6DQoay9kNmdmFd7Dy6IiefGGpsmp3h64EzyuxNpfkC7c9yuUlWtw8cbqU9/70XlEZrxAxpa+z4AslCql6zByYsWwX0VYcjVFUdXy/6h0vlVmBJHZ4jPqM+0/TGf4M/ENfHVohXiOYWcrq2KBVUzmaPw/wFqb7VTX57hJEn08ED41kajtJWspkyFmwdPU9cJkJt/bBueg710IrfNezQSWuwndIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by DM6PR11MB4348.namprd11.prod.outlook.com (2603:10b6:5:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Thu, 27 Jan
 2022 18:28:38 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::9977:f8a0:e268:24f5]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::9977:f8a0:e268:24f5%5]) with mapi id 15.20.4909.017; Thu, 27 Jan 2022
 18:28:38 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "lenb@kernel.org" <lenb@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: iwlwifi 0000:3a:00.0: Microcode SW error detected. Restarting
 0x2000000.
Thread-Topic: iwlwifi 0000:3a:00.0: Microcode SW error detected. Restarting
 0x2000000.
Thread-Index: AQHYB1Z1kfzr/0Efz0WQ7sMSiyR//KxfD8iAgACrzgCAF40igA==
Date:   Thu, 27 Jan 2022 18:28:38 +0000
Message-ID: <09ec9572150da3bd22d7c1a70491d15bfbfdd936.camel@intel.com>
References: <CAJvTdKm9PQrnyEG=b-8DbdnOHup8Ec6VqoKp3ZCQXwmvXU3FbA@mail.gmail.com>
         <0bb2a3b794c19514ad30ecc0ca60d1d6e9e438b0.camel@sipsolutions.net>
         <CAJvTdKmKPA_W_tXVjFOQEb5nX+sE+PmBeyVcf35=8WbLXuZapA@mail.gmail.com>
In-Reply-To: <CAJvTdKmKPA_W_tXVjFOQEb5nX+sE+PmBeyVcf35=8WbLXuZapA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.3-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 769857bc-4dea-444b-06f8-08d9e1c2d64d
x-ms-traffictypediagnostic: DM6PR11MB4348:EE_
x-microsoft-antispam-prvs: <DM6PR11MB43489ACB44CF9F43D5F5ED7690219@DM6PR11MB4348.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: shrAHz/zXdPZHySc+TSPK8BPJzZbuiFzxwaRXxy/NX8FmDM4l3LzlLTiAg84iuHUNYLf2ZoGFay0Y6J8CaIyDgSPDj6rrA8riScCpvF/MCIjrkrraZdVBYNt0fDu4aEhMCx01++qCPcx1CUEB2ri3pjLRM/+howYc/MATcn6B/GaaPnI22ajO1zSXeITpmoAlx1XxuoluAw4RNYmrJpjpbva8kLOcbWVX1heXGa+GkNO3SIXLpgLeT90HuR4KofP93khWmEUW9bkYDYhLoL59cmnUqFR3kDA7ROzRtWwTz6Qoe1qCEPsSuTBZpfaQ5lvWw+O0xVBx+Y+s/W1t2iacLTDq3LnQYJfqSG9pi5yNjHHydk9H4iWSKxbSso7lhorQ4mBTewj59rip0Dg97DBA3o6k1To5/BoNP+8n/54hFitv1k9LA50H0j30hbMqcSc+Poh1sQummlVbXfK0yJl3NK9NPMYjuC+rjr6ReQlGnEQ/BxkjClqzwD1kLc77Z0aLKQt7Q6mAB7mjHVDssGqGffWpv0sKvjevZBKNSj4yvusdPJK8Rs3ANevk+/Yw5ggaWDv563gkPrCSdWWGXLYybsoouwMePQRCo/gg+sl4QmzqCOUiD0zMCXwImiIMmI3/PdAT0a+qs0czpp2xLr/gT+OpGIWhqgMwCFiqDlCrFJ0TZaGggn6yAIe6XLrmLly2Y9TD+lQtjopX9n9MvYQqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(6512007)(38070700005)(53546011)(82960400001)(8936002)(66556008)(86362001)(186003)(5660300002)(8676002)(66946007)(66476007)(110136005)(91956017)(122000001)(64756008)(71200400001)(6506007)(6486002)(316002)(38100700002)(66446008)(76116006)(36756003)(83380400001)(508600001)(4326008)(2616005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGpVSzlYeUhka01rMzlvTERPaUkrVXQ2bXRlYWU5VUI4NG9JNXYyb0c1Znc2?=
 =?utf-8?B?OVp1Y2RjV1I2N2tJc3VTREFYd2lIQWFaVXViSE84MEtHY0sySEZEcHBaTE16?=
 =?utf-8?B?dnF0MVVSZktkTGJCMXJTTVYwYWRSSnFXZEVscmlTcWhGaXgzZFo5cndkYzgz?=
 =?utf-8?B?QzhVdVVLNXBEZGJqbGQyNlNJMXJqTUhuMXZ0ZWhkYzZmaHIwcjNxYUVndmdK?=
 =?utf-8?B?YVVhK3Njb29aK3FIZ1RlekxrSkVSUjQyQ3dFTFVaazhZUUZPaG5US0NVeEsx?=
 =?utf-8?B?TnVNTGs4UmNYMEsvY2JXU2xwNHdRY0ZMZks1bHFjTmU0ek5TbFZDQlBpMzlT?=
 =?utf-8?B?akpyUWJYeDVjR2tMQS9pd0Y5anpvTVIwRjdIR0RjZ1NzYm1vbjQ5a1pDUjNL?=
 =?utf-8?B?REIyYmh3M1dBQjZvVkErU09YN3MyWkpoQ25PTndYbDB6L2txbzFFUE15VHFh?=
 =?utf-8?B?ME9lNExsaEJNcU85SGlZR1N3aWhJSlJWWExIUU0zZC9YM3JUVkw1TitMOVRZ?=
 =?utf-8?B?TllxT3BzUkVBK0JwYnhiaXl1cGQzMVUzbFhLYXo0ZENIS1ZNYzdUYVNEYnYv?=
 =?utf-8?B?U0RHVzdKZXRSeTVFMmhnenRKZUhVUE9TS212OUo4c3FlalFWUXFrdm1vQ1M1?=
 =?utf-8?B?YXhjSXVaQlhVUG5nWWRvSVZxcjBZU2JScWVwN25GR2kyY1FjblRaZk5DNW1T?=
 =?utf-8?B?TFZIUTkrejZSQklyZ1BtR0ZqZE1WRGJyNlVJU0l2dzN5SElFekNkYlZ0TGNT?=
 =?utf-8?B?UEw4aDkrL0w4U2RJRHR6S2JPeHVTSk1BZ2JhTU1wV3VmWkR3Sll5UDRiQzlJ?=
 =?utf-8?B?NlNxZmUyRy92UkxGNXhLaEt0WU80UmEyZFF3OVJqM1ludEhrM21hMHpheGlN?=
 =?utf-8?B?aTRJWks3c1lySmN0eFJxYWNQb0IxNW5HZWxnVGUwVEpqWm5HcS9kQUVNdVJz?=
 =?utf-8?B?NkRrNXExT2NJckJsZmNpSWhNckZXL0NMM1Z2VkQxeVBGd1BYSGJURUdyWFRu?=
 =?utf-8?B?OXFLdEtsNXFsNnRWenBWR3VjOEVIY3JmN1JjR01vZjNNRm0ydWpRNEs1aTda?=
 =?utf-8?B?SXROaXBiSy9OM1dmN0ZXYmUxc3lSMkNEdE1FYXFuNFNObnd2ODBQbXVjbThv?=
 =?utf-8?B?SGVLdlNXbDI1NzhNc0JaSExoekpPdm85VmRtTkVybVZQOVJjSzNPT0lpS1oz?=
 =?utf-8?B?ZkNaU1BSaVFkajQwNFM1UnA3YXk0dkd5MmtlS0FDSVIzUkNKRzdrYnVxRWVi?=
 =?utf-8?B?MkY4blRkcnNlV0tXaHpiYU13OXd0L255bytkOW9MTFRlcGdhYUhzN09ZckRE?=
 =?utf-8?B?eEU4L0NaU0FWTlhMYW5ZUTBHV3NUeDYyK0hrM3pnbktGbzVvWFRveUx5elJM?=
 =?utf-8?B?akRZdlRPTDBsZzA0Ykx6Y1NRR3pCSTRwbytwMkM5QmpzNUhnL1J4VjREak5E?=
 =?utf-8?B?RjBpdkl0MFRSQ3BYalJYSUluVmdyM0JSaXpMVFNGcU5pYURTS3JqRVZ5VTd1?=
 =?utf-8?B?S3pWSmZTenByUmdBRzBUSG94UndRZ2FNZkIxN2ZlL1NRNGFoaU4xcXNFSFhi?=
 =?utf-8?B?WE1oWGd3OUlQMEFPdVVZcnFsZ2FGS1ArdFI4OTlROHJMd0VFVXAxdTUrSklw?=
 =?utf-8?B?WWthTnVKdzFNTWdJUDFkNVhLY1J0YTdzOFdNZTBpWk9HeEIxVGx5V1A0Wkh5?=
 =?utf-8?B?alhTa3RWNDB3Umx5bVRKbjBYaDlOQTJRWFpGTWIyUkFWVTZpRW5EZG9ycDZV?=
 =?utf-8?B?L2d3dG5pOXhZdnpKcXg5a1huZVZXKzBqQU5oanQ2a2hJb0tYZ1gzeW81T1R2?=
 =?utf-8?B?cXAvRkZFMTgyUTB2dVZLSzhGMXlWaXFoSUV0MTZUUjg1WGdCa2o4WnlhZHlY?=
 =?utf-8?B?aWxlOUV1RFM4R0Zld25ReFZhVi9SOTZRZTBpTG9pdmdNdHJXbTI0d3BNK09r?=
 =?utf-8?B?aUNKdU5leXpGZDNIcmE0aUw2emgxRGkyTmNTb1k3bDlHWDR3clVSekJmK2lt?=
 =?utf-8?B?Z0VncFRPaUZIcVRrZjZZL3VNbE5iR056ZWc3TmtFV1ZUY3F1eXlSSEx0SVU5?=
 =?utf-8?B?QlNSb041OTN5VWJaZHVvckxrbk1STkcyZmc5aVNFemxEY1ZhSEkrcUFXenNm?=
 =?utf-8?B?Y0pOVTNkU1ZaUmJZSVg5RHVyWTRiUkZiV2JUR3RNT3ZzRlBsdUpIMnBkV0VG?=
 =?utf-8?B?eGk3c1lacWhtbFJCbnZiOTVxVG5QS3Ivbjl2ZFJFcVg0eUJyL2tONm8yM0ZB?=
 =?utf-8?Q?MBt+UKPCFj++CwSR+dqDBrkcZQfQxjGw7U8arL19vg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58A8DA3058F6764CA963102D7DC000F4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 769857bc-4dea-444b-06f8-08d9e1c2d64d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 18:28:38.4288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PkHR46Rj5VwLn900AAnA/yarCys1KwylYoN+IAXY5BpWVWB/z1PUKOFFrV2ZIH3DOpky65fUOUVz1o9+2lwPlXquMDasG7cxbPli6aB+foE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4348
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgTGVuLA0KDQpPbiBXZWQsIDIwMjItMDEtMTIgYXQgMTM6NDkgLTA1MDAsIExlbiBCcm93biB3
cm90ZToNCj4gT24gV2VkLCBKYW4gMTIsIDIwMjIgYXQgMzozNCBBTSBKb2hhbm5lcyBCZXJnIDxq
b2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0PiB3cm90ZToNCj4gDQo+ID4gU29tZXRoaW5nIGxpa2Ug
dGhpcyBtaWdodCBoZWxwPw0KPiANCj4gWWVzIQ0KPiBJIGhhdmUgY29uZmlybWVkIHRoYXQgdGhp
cyBwYXRjaCBhbGxvd3Mgd2lmaSB0byB3b3JrLCB3aGVuIGFwcGxpZWQgdG8NCj4gTGludXgtNS4x
Ni4NCj4gDQo+IExldCBtZSBrbm93IHdoZW4geW91J2QgbGlrZSBtZSB0byB0ZXN0IGEgcHJvZHVj
dGlvbiBwYXRjaC4NCg0KVW5mb3J0dW5hdGVseSBuZWl0aGVyIEpvaGFubmVzJyBub3IgbXkgZml4
IHdhcyBhY3R1YWxseSBmdWxseSBzb2x2aW50DQp0aGUgcHJvYmxlbS4gIEJ1dCBJIHRoaW5rIEkg
aGF2ZSB0aGUgcmlnaHQgZml4IG5vdywgYnV0IEkgZG9uJ3QgaGF2ZSBhDQozMTYwIHdoZXJlIEkg
Y291bGQgdGVzdCBpdC4NCg0KQ2FuIHlvdSBwbGVhc2UgdGVzdCBpZiBpdCB3b3JrcyBmb3IgeW91
IHdpdGggdGhpcyBjaGFuZ2U/DQoNClRoYW5rcyENCg0KLS0NCkNoZWVycywNCkx1Y2EuDQoNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYWNwaS5j
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9hY3BpLmMNCmluZGV4IGM1
YzgwZTNiOTViMy4uNjYzMWIyNWFhYTgzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvaW50ZWwvaXdsd2lmaS9mdy9hY3BpLmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2lu
dGVsL2l3bHdpZmkvZncvYWNwaS5jDQpAQCAtOTAwLDEwICs5MDAsMTEgQEAgYm9vbCBpd2xfc2Fy
X2dlb19zdXBwb3J0KHN0cnVjdCBpd2xfZndfcnVudGltZSAqZndydCkNCiAgICAgICAgICogb25s
eSBvbmUgdXNpbmcgdmVyc2lvbiAzNiwgc28gc2tpcCB0aGlzIHZlcnNpb24gZW50aXJlbHkuDQog
ICAgICAgICAqLw0KICAgICAgICByZXR1cm4gSVdMX1VDT0RFX1NFUklBTChmd3J0LT5mdy0+dWNv
ZGVfdmVyKSA+PSAzOCB8fA0KLSAgICAgICAgICAgICAgSVdMX1VDT0RFX1NFUklBTChmd3J0LT5m
dy0+dWNvZGVfdmVyKSA9PSAxNyB8fA0KLSAgICAgICAgICAgICAgKElXTF9VQ09ERV9TRVJJQUwo
ZndydC0+ZnctPnVjb2RlX3ZlcikgPT0gMjkgJiYNCi0gICAgICAgICAgICAgICAoKGZ3cnQtPnRy
YW5zLT5od19yZXYgJiBDU1JfSFdfUkVWX1RZUEVfTVNLKSA9PQ0KLSAgICAgICAgICAgICAgICBD
U1JfSFdfUkVWX1RZUEVfNzI2NUQpKTsNCisgICAgICAgICAgICAgICAoSVdMX1VDT0RFX1NFUklB
TChmd3J0LT5mdy0+dWNvZGVfdmVyKSA9PSAxNyAmJg0KKyAgICAgICAgICAgICAgICBmd3J0LT50
cmFucy0+aHdfcmV2ICE9IENTUl9IV19SRVZfVFlQRV8zMTYwKSB8fA0KKyAgICAgICAgICAgICAg
IChJV0xfVUNPREVfU0VSSUFMKGZ3cnQtPmZ3LT51Y29kZV92ZXIpID09IDI5ICYmDQorICAgICAg
ICAgICAgICAgICgoZndydC0+dHJhbnMtPmh3X3JldiAmIENTUl9IV19SRVZfVFlQRV9NU0spID09
DQorICAgICAgICAgICAgICAgICBDU1JfSFdfUkVWX1RZUEVfNzI2NUQpKTsNCiB9DQogSVdMX0VY
UE9SVF9TWU1CT0woaXdsX3Nhcl9nZW9fc3VwcG9ydCk7DQogDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtY3NyLmggYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9pbnRlbC9pd2x3aWZpL2l3bC1jc3IuaA0KaW5kZXggYTc4MDZhMWYyZTkzLi5lMjk1OTM2
MjVlYTAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2l3
bC1jc3IuaA0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtY3Ny
LmgNCkBAIC0zMjksNiArMzI5LDcgQEAgZW51bSB7DQogI2RlZmluZSBDU1JfSFdfUkVWX1RZUEVf
MngwMCAgICAgICAgICAgKDB4MDAwMDEwMCkNCiAjZGVmaW5lIENTUl9IV19SRVZfVFlQRV8xMDUg
ICAgICAgICAgICAoMHgwMDAwMTEwKQ0KICNkZWZpbmUgQ1NSX0hXX1JFVl9UWVBFXzEzNSAgICAg
ICAgICAgICgweDAwMDAxMjApDQorI2RlZmluZSBDU1JfSFdfUkVWX1RZUEVfMzE2MCAgICAgICAg
ICAgKDB4MDAwMDE2NCkNCiAjZGVmaW5lIENTUl9IV19SRVZfVFlQRV83MjY1RCAgICAgICAgICAo
MHgwMDAwMjEwKQ0KICNkZWZpbmUgQ1NSX0hXX1JFVl9UWVBFX05PTkUgICAgICAgICAgICgweDAw
MDAxRjApDQogI2RlZmluZSBDU1JfSFdfUkVWX1RZUEVfUU5KICAgICAgICAgICAgKDB4MDAwMDM2
MCkNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9m
dy5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vZncuYw0KaW5kZXgg
YTM0YmFkMGMyNjQ1Li44NGIwM2VjYmIyNjYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9pbnRlbC9pd2x3aWZpL212bS9mdy5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9p
bnRlbC9pd2x3aWZpL212bS9mdy5jDQpAQCAtMjAxNiw3ICsyMDE2LDcgQEAgaW50IGl3bF9tdm1f
dXAoc3RydWN0IGl3bF9tdm0gKm12bSkNCiAgICAgICAgcmV0ID0gaXdsX212bV9zYXJfaW5pdCht
dm0pOw0KICAgICAgICBpZiAocmV0ID09IDApDQogICAgICAgICAgICAgICAgcmV0ID0gaXdsX212
bV9zYXJfZ2VvX2luaXQobXZtKTsNCi0gICAgICAgZWxzZSBpZiAocmV0IDwgMCkNCisgICAgICAg
aWYgKHJldCA8IDApDQogICAgICAgICAgICAgICAgZ290byBlcnJvcjsNCiANCiAgICAgICAgcmV0
ID0gaXdsX212bV9zZ29tX2luaXQobXZtKTsNCg0K
