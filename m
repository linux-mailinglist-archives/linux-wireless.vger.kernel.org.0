Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45AB418EEF3
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 06:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbgCWFDS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 01:03:18 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:36803 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgCWFDS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 01:03:18 -0400
IronPort-SDR: t26X2By6znRM0klgWJW6rAVixHi65IYRWy6UndyngU9LO8s/DlBf6bK+4Cz3NRjrntSUw6TEko
 pWN0I9q42XEhX9rvEe1U9ukixfs6bWhZSGJoaSusJVtHfRVfwfktBviBW3mYdspiAQe6iCP8Fv
 wXm8Tr5Di13bSK1vn2bUPxESQuUxYTDrczyOi6Pp9vue4uwhdB0byVaKrC0O6LbW+CdMbGsO7j
 1Q107uDTwrY5Kl4ZpSaAQ2bdE2vx+ZYVTDAANETUmb3naJIUImUkEQcK2/CVqkxbo/7+AS00g7
 lvs=
X-IronPort-AV: E=Sophos;i="5.72,295,1580799600"; 
   d="scan'208";a="69778903"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Mar 2020 22:03:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 22 Mar 2020 22:03:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sun, 22 Mar 2020 22:03:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvYx2DAmKsPjkiWA8aGWbuxpqvBuW/14glynY0XzEkHbQfs0Wsp6ro2MRoBOz4NF2gs8lbb9j4HJWIne9tMCMJktuoLTmOgNvoZqAQKarFWPtoPDdhYJkB/OwwprJYRq26jGoGF01B607ZUrKf+QDo9brPUkN+AO2m4z2Nb7+u4zyzIhU+B+5OoNHQl2OLKzjrnoMMLcQl/rj/+GLNtXAUHIjB6QimVq+utphonpfrwosHW+jbO/ikCTF+FA1ovSox50tuu63V7bupRsp4HRwOWorImUlGslYX/nrPknJPxsx/4uji3fxAGylsE8zK1PWCrolYpcrqAZscNH2L0YWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clTzoVhq9W5hlrxs3Z07ao3qMEQTZCWXPflOFp4UioE=;
 b=WJ03JxNFu39kVzQel1lmF2sNTVmKrdqR7QnPm3owIQU1ZGpX5tOQms710QrJm3V7Rw8m67tzrAwxCYu9tzmlje0kfqoGFmNKFhH3Hc7fihRw1PHbOFAyQTfrCks0jiS88zEX2Jy7RmNBU3S86sSIbj4D2RFQZf+fNSAHJw35w2bY9UoDUaY66/EdkrpT6ZaTzZTiLxKFK2+04pxUOWJd8I1anHv6gDHD8cr9NvEl/mDc6s+h3n+JhIz6iq8habBE5il/l2Y3GEm7zQo+g5GmSa8cCA9JsMARxKfqZdiFOQ9JzksAB/cDi6kA11Op79ZW/LcGnAD1hwsS5izUuQGt8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clTzoVhq9W5hlrxs3Z07ao3qMEQTZCWXPflOFp4UioE=;
 b=dl3ug+X6DFhMbAVP2/4ylBz65uKrLfwMbu0SuoZJrcl+gRowrUfF4G6fSNHgCQTVHdUidNTgLnX+BSzBFW/Ritoj0XURLxAm6HGfqmUIHbwthnmF0BHlAdLZLYeZeO9pcBciTkjRKKPCbpsnGn+gYMO/NnhVFSwAm0ze1rpZrzQ=
Received: from BYAPR11MB3125.namprd11.prod.outlook.com (2603:10b6:a03:8e::32)
 by BYAPR11MB2645.namprd11.prod.outlook.com (2603:10b6:a02:c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Mon, 23 Mar
 2020 05:03:03 +0000
Received: from BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e]) by BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e%4]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 05:03:02 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <lkml@SDF.ORG>, <Adham.Abozaeid@microchip.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wilc1000: Use crc7 in lib/ rather than a private copy
Thread-Topic: [PATCH] wilc1000: Use crc7 in lib/ rather than a private copy
Thread-Index: AQHWAEIKTm0S89iTgU6wn5ujLF8hH6hVoCEA
Date:   Mon, 23 Mar 2020 05:03:02 +0000
Message-ID: <2315a030-75ad-0383-3aa3-25528d2cd29a@microchip.com>
References: <20200322120408.GA19411@SDF.ORG>
In-Reply-To: <20200322120408.GA19411@SDF.ORG>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ajay.Kathat@microchip.com; 
x-originating-ip: [183.82.16.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 036845fe-0080-4907-07bd-08d7cee77726
x-ms-traffictypediagnostic: BYAPR11MB2645:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2645FA49D77E851949EE6294E3F00@BYAPR11MB2645.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(366004)(396003)(199004)(110136005)(966005)(6636002)(6512007)(4326008)(5660300002)(71200400001)(26005)(478600001)(316002)(186003)(91956017)(76116006)(6506007)(53546011)(66476007)(66556008)(64756008)(66446008)(31686004)(6486002)(66946007)(2616005)(31696002)(81166006)(81156014)(2906002)(36756003)(86362001)(8936002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB2645;H:BYAPR11MB3125.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cysibD1BbBBXSf1QWvLvj91QaImHmg66NwmN6NnTjCqO5szGTs/Lo8L3MaaErBmcZbn2DQbk2qr19k9WZ1B11yDaKoP5TyomnK6TmY2kbUFoqMNBf52iNTzZd/rYqMonYiw3+H/iZO4Sj5XWQvW76Tz592fvj0SBjDizuErPPY9QAS3IpoQLmORo7lFXq7Kn4mlnDHi+W4L53vNkFbh6pB16BScj2tckOTlNYnWyBLaf+cqfr8lrhBQk9lvZGMG335o+75LC2bMhUuQ9GCyyTLrmZM/7QpYjd1f5aFqkwvUzzv/55oZ/lEZHsdna+iF3KsQVTeQZor5tLdnvrPo96tmH1qIzHjZ/pGK0gp1Qdk5XP6eosR5O5pRszgFtXfDLHmad9Yr7Efl2SoLtepWz/rNgmW9dYcIx40x56WjO1+FQ099e7ZtqqmAVnnBjwB9WpIioikuXj9SRYYjdCwT4+fFYoyHImHu4rEh+ZqmmVs83eOouA0My+rI+4CUUQTBVylMbe7GJdRrpxOCJGKR6og==
x-ms-exchange-antispam-messagedata: ANNK4qoFxGwOBf7YOCb55tJjkJHlPHZcFQu6rC2CywTvO/MU6I/TwLtJJGHsy5tXEwYVnaX9pAIuvda85wOYVu6KLb0ET6JjRgWvjnpYlP5sSilHSZWb836RUS+7qHZB7Ur1QMcDOhUn/yi2mcb2FA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A66B495A5EEB54FAF3B69F2ECBAA988@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 036845fe-0080-4907-07bd-08d7cee77726
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 05:03:02.5124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lwk1dduD1u6uRIVcKj1Qrse+zW9pRutGLe7+fE3v8XBC0ipRLTzC7JJY718bZ5DRifgf4vC2pPrqYnMumM1/HTfRzpW3XygU4cnyHqOcQV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2645
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgR2VvcmdlLA0KDQpPbiAyMi8wMy8yMCA1OjM0IHBtLCBHZW9yZ2UgU3BlbHZpbiB3cm90ZToN
Cj4gDQo+IFRoZSBjb2RlIGluIGxpYi8gaXMgdGhlIGRlc2lyZWQgcG9seW5vbWlhbCwgYW5kIGV2
ZW4gaW5jbHVkZXMNCj4gdGhlIDEtYml0IGxlZnQgc2hpZnQgaW4gdGhlIHRhYmxlIHJhdGhlciB0
aGFuIG5lZWRpbmcgdG8gY29kZQ0KPiBpdCBleHBsaWNpdGx5Lg0KDQpUaGVzZSBjaGFuZ2VzIHdp
bGwgYnJlYWsgZnVuY3Rpb25hbGl0eS4gVGhlIGNyYzcgdXNlZCBpbiAnd2lsYycgaXMgYmFzZWQN
Cm9uIHRoZSBwcmV2aW91cyByZXZpc2lvbihjb21taXQjIGFkMjQxNTI4YzQ5MSkuIFRoZSBuZXcg
Y2hhbmdlcyBjYW4gbm90DQpiZSBhZG9wdGVkIGZyb20gJ3dpbGMnIGRldmljZSBzaWRlIGJlY2F1
c2UgdGhlIGNyYyBjYWxjdWxhdGlvbiBpcyBkb25lDQpvbiBoYXJkd2FyZSBJUCBhbmQgaXQgZXhw
ZWN0cyB0aGUgdmFsdWUgYmFzZWQgdGhlIG9sZGVyIGltcGxlbWVudGF0aW9uLg0KDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBHZW9yZ2UgU3BlbHZpbiA8bGttbEBzZGYub3JnPg0KPiBDYzogQWRoYW0g
QWJvemFlaWQgPGFkaGFtLmFib3phZWlkQG1pY3JvY2hpcC5jb20+DQo+IENjOiBBamF5IFNpbmdo
IDxhamF5LmthdGhhdEBtaWNyb2NoaXAuY29tPg0KPiBDYzogbGludXgtd2lyZWxlc3NAdmdlci5r
ZXJuZWwub3JnDQo+IC0tLQ0KPiBKdXN0IGEgZHJpdmUtYnkgZml4IEkgaGFwcGVuZWQgdG8gc3Bv
dC4gIEFub3RoZXIgcG9zc2libGUgYnVnIEkgZm91bmQgaW4NCj4gdGhlIGNvZGUgaXMgaW4gd2ls
Y193ZmlfY2ZnX3R4X3ZlbmRvcl9zcGVjOg0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAg
Z2V0X3JhbmRvbV9ieXRlcygmcHJpdi0+cDJwLmxvY2FsX3JhbmRvbSwgMSk7DQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIHByaXYtPnAycC5sb2NhbF9yYW5kb20rKzsNCj4gDQo+IFdoYXQgaXMg
dGhlIHBvaW50IG9mIHRoZSBpbmNyZW1lbnQ/ICBTaW5jZSBsb2NhbF9yYW5kb20gaXMgYW4gOC1i
aXQNCj4gdmFyaWFibGUsIHRoZSByZXN1bHQgaXMgOCByYW5kb20gYml0cyBpbiB0aGUgcmFuZ2Ug
WzAuLjI1NV0sIHRoZSBzYW1lDQo+IHRoaW5nIHRoYXQgd2FzIHRoZXJlIGJlZm9yZSB0aGUgaW5j
cmVtZW50Lg0KPiANCj4gQWxzbywgSSB3YXMgdGhpbmtpbmcgaXQgY291bGQgYmUgcmVwbGFjZWQg
YnkgcHJhbmRvbV91MzIoKTsgZG9lcyB0aGlzDQo+IGFwcGxpY2F0aW9uIGNhbGwgZm9yIGNyeXB0
by1ncmFkZSByYW5kb21uZXNzPw0KPiANCg0KSXQgc2VlbXMgeW91IGFyZSB1c2luZyBhbiBvbGQg
dmVyc2lvbiBvZiAnd2lsYycgZHJpdmVyLiBUaGlzIGxvZ2ljIGlzDQphbHJlYWR5IGNoYW5nZWQg
aW4gdGhlIGxhdGVzdCBjb2RlLiBXZSBoYXZlIHJlbW92ZSBjdXN0b20gYmVoYXZpb3IgdG8NCmRl
Y2lkZSBwMnAgcm9sZSAoUDJQX0dvL1AyUF9DbGllbnQpIGJldHdlZW4gMiB3aWxjIGRldmljZXMg
YmFzZWQgb24NCidsb2NhbF9yYW5kb20nIHZhbHVlIGFuZCBub3cgcmVsaWVzIG9uICdpbnRlbnQn
IHZhbHVlIHJlY2VpdmVkIGZyb20gJ3dwYV9zJy4NClRvIHN1Ym1pdCBjaGFuZ2VzIGZvciB3aWxj
LCBwbGVhc2UgdXNlICdzdGFnaW5nLW5leHQnIGJyYW5jaCBvZg0KaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvZ3JlZ2toL3N0YWdpbmcuZ2l0IHJlcG8uDQoN
ClJlZ2FyZHMsDQpBamF5
