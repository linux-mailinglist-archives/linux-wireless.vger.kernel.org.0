Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5FD3249ED
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Feb 2021 06:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhBYFAX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Feb 2021 00:00:23 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:4471 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBYFAT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Feb 2021 00:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614229218; x=1645765218;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eRtK6km9w90NoyQIj35RLcQFyEzJcGCemcr8hOnj+GI=;
  b=NEwlBLPtMDUyCNekTXveNQcmXXyw9gm2AU9XUD3aLdUxxEzMS3cBaaDw
   gY/lZ7zVNFi20tV5nFPJDxkU+NHBTQSirYPL8GYbIE21cubqGVsO4jP43
   PJH66JwGVhdhHRqrDIU9qkuW3p4b/JZMstWUF5P1F/GbI8s73TrnKngLq
   NHmXOJoRnEIectwzazFVxTH3MyPYvUzOXRFa3CuJg5Ntkfkd8Ww0FKS7M
   6EGI58zIIhyHrYlj1tsE0rN2h9SHcvDSVc0qPtVoQ1wH1BGlSwhd+g7de
   a7UbfJjobGvJJZz1CTkHiVDhK9P0rHbduUYMPkI8hgiN+N50jj9obWnZw
   A==;
IronPort-SDR: QbZpSF0T2TEp2/RdW8VHENjg9NVBDqrkdQ9JGNs3hIZ8PQq9vqw3eAAgEL9xJ5/ZG2a8djGWoN
 d9BVoHwkGowd4phHxSF7S9lJt7o2bD1YADg+vpAoNrMXaDjBp1yhKDUeQkOB4vA2ToCCXb/qQa
 bVXTXyxSakne3d4AN9JdziVWNn63vToYCHKacbMilI0hy/PmsMurgXmeaw8c6ztpy59h3FqS+x
 FGdY+/lwUu3bOejPqsonrWyP1CdKoe/uq4tjpDNyM7PwP+jInElA26GRP5F4Ic25YfE8DYF/la
 YwM=
X-IronPort-AV: E=Sophos;i="5.81,203,1610434800"; 
   d="scan'208";a="105067984"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2021 21:59:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 24 Feb 2021 21:59:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 24 Feb 2021 21:59:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PADmPYc7SYwCFSibO/A3AxWa883tXdCqRPmJgvBPN7sYbUZYcNm8cWSRJtVMIrbcdhSoc1SAQ/XmlRRUG4oym5UElyMEqzCJcDOhjBFQcboxQ+urKocKYIA1zVmktfPpOh12aesroOotbFmY8L+7aRGPsqcw62IlUAL5b5NYS3JLpGfM+Ud2ocfDomoiGUmO4Jzi2CLQmgoj3JAK0/WbxAxnEQ1Wl5fOrcZWFj1kDldaUZe+UWqDIYBKnlxb45vYSBhYl/t8JnrBrDc2mnPdh2D5/10rYXXfVEUhVTO8yVIQ7hCKi0xIgJ0BHIJ3I1qmOMQ5JX/snHck3dobuUF6oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRtK6km9w90NoyQIj35RLcQFyEzJcGCemcr8hOnj+GI=;
 b=YFL5ttPPgik9x+rxD5FvkJV6OTET/rSH3+hldLKuwLqBTQSuOVLfyKs+UqGvGc62WhJSYp2k7J+2dbqzs7eSgF55rBQkT/BkGtgIaXinPVMp2tdLasA3uKr+GQ9WOwgMSepO4L7eXNV6nj8ENBI3MncYCjgJ/eRiE6Tr9m9nQPB/g4G5lF7yLkuAJJs7oItj3EhnQg09ICx2H1xiLZ+mBWnuFKEkwIkjUj4ULhDG8yeCqRf7KM8Zj3F1D/nBPqFb6XQuCj/BPRDqj+h6MG/572V9bjtNO/Igk/KNF1PrM/81nlZ+AauSMhq5nzX4W0MdImdPX2VLukUxPlJJwGaFUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRtK6km9w90NoyQIj35RLcQFyEzJcGCemcr8hOnj+GI=;
 b=NqEonyPUr5DL7wwO2Rb12m1kvpiimuLfKpoHmSQ7ZeNhfQQ40/T5vL7rMrPvxe/neZX1dOAmmsI9z+BtuwK5fyv2qi9arFT+mWiGwUp0XnljgKe8GlLROCvGB6q7WYcy+BQBIbmFUjA3eePPapQO6NZtCVvTFgn3trmvvMjMWh4=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB3173.namprd11.prod.outlook.com (2603:10b6:a03:1d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Thu, 25 Feb
 2021 04:58:59 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::6c3c:2ae0:c40b:6082]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::6c3c:2ae0:c40b:6082%3]) with mapi id 15.20.3868.034; Thu, 25 Feb 2021
 04:58:59 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <davidm@egauge.net>, <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 4/4] wilc1000: Add support for enabling CRC
Thread-Topic: [PATCH 4/4] wilc1000: Add support for enabling CRC
Thread-Index: AQHXCnEwZSbR0AsbwkSoOjOCksEYjKpnTv8AgAAk7QCAAN0LAA==
Date:   Thu, 25 Feb 2021 04:58:59 +0000
Message-ID: <56ff1617-8d39-9dbd-0055-b3cee6d458ff@microchip.com>
References: <20210224055135.1509200-1-davidm@egauge.net>
 <20210224055135.1509200-4-davidm@egauge.net>
 <a4261e8e-3693-2aa0-e23a-3bd3c6eb5686@microchip.com>
 <33012e779ee172e688cac2e710fa1ddab68fc611.camel@egauge.net>
In-Reply-To: <33012e779ee172e688cac2e710fa1ddab68fc611.camel@egauge.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: egauge.net; dkim=none (message not signed)
 header.d=none;egauge.net; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [106.51.110.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3ff65c6-8067-4f4f-dec5-08d8d94a1037
x-ms-traffictypediagnostic: BYAPR11MB3173:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3173C6CF3B4193FDF66154E2E39E9@BYAPR11MB3173.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sfj5GoHg7pKKofWOwG78ttxKK1NG6s7NIXarj93OdxldvSWFsAhktGIuO1GSACH7mIMWuvtZyqR/RhcaP5bgMGQvzXiKhz/xpFUNcvFxR/C6LW+yLAV9Ims9yxGSG/NP3opMbbDZ4LxU26gaGHkbrSez/lx+Tu/J5PuAlnJpY1kbLFOa2Xorbe86jJdHJ/ZUoRyhv9sELRk36wecu6tfg06sZVi2p4790trvhECuCKl1s9Kp7OyEzecmIaXuUldXW8/8KoT0EWm3tQCs6V8vOcmU75h+8ibFns4YjO4YH2ML6D1/dUMyOOF57wrl3bxwcQdHdom30vjFsGCJFhBbg4tzx0YMjwPD1Wkhec2hDNU62ibyLOgbTJPY4zmVdPy6o1LZKpuOuLmT47ALOSoUiWxODi6E+NE9k+QDR+5ZC9+T8cro2hPnUTE66PbhFN9X1zTLYj4Bc2R1NNc2d56GqPQF/Pk3MLmWtBdEGy4Y/cGaO8qgoBHnVslKPRFKhmu7JeVVDmKp9EVVvW/kWbzthMWw3vILg0HnmO3QebhpigSQDdAuruEAzNv3Haj6EeCgKzcNchGTaHhIeFJoAecIbIc/+EeQhy1nkvKnarx7o0c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(396003)(376002)(366004)(64756008)(66556008)(31696002)(83380400001)(110136005)(66476007)(91956017)(66946007)(478600001)(76116006)(6506007)(66446008)(4326008)(5660300002)(31686004)(53546011)(316002)(71200400001)(8936002)(26005)(55236004)(107886003)(8676002)(186003)(6486002)(36756003)(2906002)(2616005)(6512007)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Sk93bHBKMkc5emQvUy8zS1BuRkI0NXRNZlZ6VzBBSmVzazNYK2NySnI1NGxy?=
 =?utf-8?B?Sjg5aEk1V1lNay9kMTAvWWtOT21RQWgzU3JMRlhsL1Y1V0ZvZDlDRE9saVc4?=
 =?utf-8?B?VVgzK3pEMDN6Y1VPejZSbmdEY3kzcmJUM1MzeHFacFZWaXBZMWZSaEQ2UVlx?=
 =?utf-8?B?c1JCWE00SVN2d3B1Q2lWS3JqQ2VBcWxKWEk2OVd3amJ5ekVxM2phOHRrNkU4?=
 =?utf-8?B?WVJqR3c1WTkvV0t3TEFkY3VwNFFYYW5PYlEvRXNDSjlFODk2czMrRjNCbHho?=
 =?utf-8?B?NHpVbmlrOFpEdlZNblpCc2RVTDNWeG5VOGZxVVNFYk5Ddmo4Ky9HMzJFblVP?=
 =?utf-8?B?QmVZRWd6dk9mQ2dFakZINDkyVjlTQXBlUzF6V2FLa0lGSzRjbXdsT2pVQmVW?=
 =?utf-8?B?Q2h3bXAyVW9zb3lmVXliN3ZqU3Y4MDhrNjluU21iMkQwemhSaHdhMlJtSnZq?=
 =?utf-8?B?ZHgzUGJzWVZjR3BuNnI2S2lPdVpzcldtZHZDeUdZTk81RWoxckkreHl0WGVI?=
 =?utf-8?B?U3pwRzQ3L21ySzVvajgyaHdpUDcvbWhSQ0tKMTRWaHpNSm4vc0RtSWZVdlZw?=
 =?utf-8?B?N29JVWpLV3B3WFd3eXd6OWhNc3BNa0RPb1ZSQ3ZUZXJqVVF3M2M1MUJSVGpJ?=
 =?utf-8?B?dVl5d1p1MnBEc0RTTjZEWm52WWNTVHdBNVlBYUt3bk43QVo2UFViRzNQSEJ4?=
 =?utf-8?B?UFRMWFVEdk4weWVEQ2hoVko4S1RpRU5JN2I4VzVxc2RLMjh3NGh0cmFXRndV?=
 =?utf-8?B?SmNZRHZLWGxQcEpWUmc4VkNqdjVKUGRFbkZnYUJqeWNya204Rm5CZzVoWVVE?=
 =?utf-8?B?d3R5dGhIQXdVSkdOdTFYY0pwM2JFOTVoc0JHbVNjZGxvaWxkWFZXbkdqWTNx?=
 =?utf-8?B?aVAwQVFqdkpjV1BoMWhhTm5URGd3QTg1Q1ZCZzNBOWoxSkNVZEZXOEd5c2Fk?=
 =?utf-8?B?S042Z3hlSDNiM29zRkNsYWx3dVN6UDV5eTNQMXA0YmJtcG0rdDhiUkI1T1NT?=
 =?utf-8?B?Vlc0THBtYWdORE1KVnppdGV4MFVmWWd2RDNLSUNCYlZia1ZrbGtvb0hjUlFF?=
 =?utf-8?B?VlpkWWhoZnpRS0xuY0huQUxVZm5RR0o0NWExdG1qMVB3Y3BKenRLcnRjOGJj?=
 =?utf-8?B?Qjd1b0l5NE5lWkRubGo1RFRBT3dOM1BYK3o2OHBXRWJkOHZpVWZJckRUY3hB?=
 =?utf-8?B?cDVDRkFFWkI3bTN3OG1MVmZvZFhnbjdJMWwzc3BoNFZqQTdXNEV4V0Z2b0RP?=
 =?utf-8?B?VW5TanBJaXR3dDdRTVBiLzRBdzdwVVV6Yi9pVGZMcExlSldmVVUzeGN5QlJF?=
 =?utf-8?B?WHZtczBjNzhYV0EyeGdsclN0VXpNQzlIbzdjdUhiVUtZRHY5MjNaNG1FbE9y?=
 =?utf-8?B?VFFBMlNOMnd2R3dkY0RsaUloUFVRVWpkaTFJbmRpYU52NXFRRk0rb0N3b2Zp?=
 =?utf-8?B?bi9UZ0wrcjNQbVBobWdxRXVjVTh3aXV5NWFZc3ZKckRCOURNOXVhSHZkb0Ex?=
 =?utf-8?B?dzdjTi92STlpaE9rUFJlWTBVMjhsQ2ZCKzQ4NVh0S0NBRUFvRDBrYlRQWEZo?=
 =?utf-8?B?R2ltMzhhRmhBYi9QSDUrbFc4MFlGaHpqcEs0emtUbEpIZ2FMSjltdU9OYVF1?=
 =?utf-8?B?TjEvR1d4dUpPbFB2dUJGUWJlWktURUJNK1dnZ1BleXAvM1JrdXh5UWtQc01s?=
 =?utf-8?B?VUVvRGQ4eVMyYzYvMnc5WUxPa2dNT3NCMFRWSWZqakFaQVN0OFZ0VHplc3RY?=
 =?utf-8?Q?CZTUToRAzfp09RYa17xNFyX3D7ZImY/7oRyr2xc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BCA3DC3BFFE6844A269A6ACC7829A12@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ff65c6-8067-4f4f-dec5-08d8d94a1037
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 04:58:59.4564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +m/CHh1wdz9dGExaRTxjDpZ52g7zRjA4KgKLMg+abqxsCAPvCJXTQCs1GyxXNN5X3xP/y1uLqW2yBq9z9EBHlGXMMZ3Kn3ondm3H7O9+K1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3173
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgRGF2aWQsDQoNCk9uIDI0LzAyLzIxIDk6MTcgcG0sIERhdmlkIE1vc2Jlcmdlci1UYW5nIHdy
b3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEFqYXksDQo+
IA0KPiBPbiBXZWQsIDIwMjEtMDItMjQgYXQgMTM6MzUgKzAwMDAsIEFqYXkuS2F0aGF0QG1pY3Jv
Y2hpcC5jb20gd3JvdGU6DQo+Pg0KPj4gT25lIG1vcmUgb2JzZXJ2YXRpb24uDQo+PiBJIGFtIG5v
dCBjbGVhciBpZiB0aGUgYmVsb3cgYmxvY2sgaXMgcmVhbGx5IG5lZWRlZC4gSGF2ZSB5b3UgZmFj
ZWQgYW55DQo+PiBpc3N1ZSBoZXJlIGFuZCBkaWQgdGhlIGJlbG93IGxvZ2ljIG9mIHNraXBwaW5n
IGRhdGEgaGVscGVkIHRvIGNvbWUgb3V0DQo+PiBvZiBpdC4gQWxzbyBjaGVja2luZyB0aGUgbGlt
aXQgb2YgMTYzODQoMio4S0IpIGJ5dGUgbG9va3Mgb2RkIHdoZW4gdGhlDQo+PiBtYXggbGltaXQg
Zm9yIGRhdGEgcGFja2V0IGlzIGFyb3VuZCA4S0IuIEFtIEkgbWlzc2luZyBzb21ldGhpbmcgaGVy
ZS4NCj4+DQo+Pj4gKw0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgew0KPj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1OCBieXRlOw0KPj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgaTsNCj4+PiArDQo+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCAx
NjM4NDsgKytpKSB7DQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgYnl0ZSA9IDA7DQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgd2lsY19zcGlfcngod2lsYywgJmJ5dGUsIDEpOw0KPj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICghYnl0ZSkNCj4+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJy
ZWFrOw0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+IA0KPiBPdWNoLCB0aGF0J3MgZGVm
aW5pdGVseSBub3Qgc3VwcG9zZWQgdG8gYmUgdGhlcmUhICBJdCdzIGxlZnQtb3ZlciBkZWJ1Zw0K
PiBjb2RlIGZyb20gd2hlbiBJIHdhcyB0cmFja2luZyBkb3duIHRoZSBwb3dlci1zYXZlIGlzc3Vl
LiAgTm90IHN1cmUgaG93DQo+IEkgbWlzc2VkIHRoYXQuICBUaGFua3MgZm9yIGNhdGNoaW5nIGl0
IGFuZCBiZWluZyBzbyBnZW50bGUgYWJvdXQgaXQhDQo+IA0KPiBIb3cgZG8gSSBmaXggdGhpcyBi
ZXN0PyAgRG8gSSByZXNlbmQgdGhlIGVudGlyZSBwYXRjaCBzZXJpZXMgb3IgaXMgaXQNCj4gT0sg
dG8gY3JlYXRlIGEgVjIgb2YganVzdCB0aGlzIGxhc3QgcGF0Y2g/DQo+IA0KDQpJdCdzIGJldHRl
ciB0byByZXN1Ym1pdCB0aGUgY29tcGxldGUgcGF0Y2ggc2VyaWVzIHYyLCBhcyBpdCB3b3VsZCBi
ZQ0KY29udmVuaWVudCBmb3IgS2FsbGUgdG8gYXBwbHkgdGhlIHBhdGNoZXMgaW4gb3JkZXIuDQoN
ClJlZ2FyZHMsDQpBamF5DQo=
