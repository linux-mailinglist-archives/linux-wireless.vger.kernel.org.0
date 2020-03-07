Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B780C17CCFF
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2020 09:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgCGIu7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Mar 2020 03:50:59 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:6039 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgCGIu7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Mar 2020 03:50:59 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: BYzFmIas2J56mLER/TmmFc8tFoTJD9h7WqxcoAsuirEoAB2tkoUcmPHQNeaHS4FaG059vWzjC0
 ZF+iAGnWIFaBajOI/9YU+IZS2dL1UsugNP/oOvgeosfUsBoJDlVX3zCJpZUHCtscUfdVq31wNJ
 OqmnN2aJeZxZJECWAJNjawfD7X1ELYFqB3XZ4GevPutFME2yVc4TpHeYw8keyWLuuRYmZ5w365
 D5RFK6fcX38rkXH4hDKa6Jv3gSJDc+XAsSL2uklbbP5JtadxIkMIsbBiSEeyTklp4ao9MetjkX
 pRQ=
X-IronPort-AV: E=Sophos;i="5.70,525,1574146800"; 
   d="scan'208";a="68188713"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2020 01:50:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 7 Mar 2020 01:50:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 7 Mar 2020 01:50:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCZQVbjzQ479BulVT5zEvZ7zmhf31EhBOqqpxCP7fLwdi9r4F3BcHSn4qRdaFUuXSSEPTi7jgjuWlPsNhS/Ki+08/YfTqiLDRxhlpt/ym/hsF7VKPgfr06p7JDxROYkGkg6ZJqXTNHdCHKMN01ZPMrol67INdhJybIO1dYnz0fHXswLZuan/dkam9I5W7lCy6s3hy4InJg1wGk3P7h5nm2RPE8tznOvF+wqMS4U8L17lO5xCVoX6sJePlfwsTUV/S2iiG8yX6ZX9imax8mQHiOfIrseKnIXsMf5wlQd1L4zAp2E6SrEjBq2b9zARfctUIrCjPurYa4X5jK8Lh/vygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRJ49oH4OJ+kR80o0LBl+Eu1lcsBDpsMElpPgJ5mZso=;
 b=FmrKX6j7XKjns4EYH+I8Q4/nlTHBZu4ve/BblmWSJ9Jt33wZx0JgpSHWF+tfqLFKWuKm0UD42Kn070xvvASAyQIKEl7Aia3o8AEWp2RRTHeE8u3D/gdcdafXhxy+MqeqiBxioESOwPNK87LjVd66Nwl+7NCytY23IfGzOQq10jSr+iMh/nRefRBeqEW7j+UIJeltPo4w/L2b2c87CA2BN/oj81o+MfPF1lAsL08yV0du6XRIb8DIfCXQAZ0JaYXG10aXl8HgLetzhYLFzcPfQP6oa3W9RiMGBkktxM7gR//qFOJM0Uzu87DcogHiKAjCeXpIi4nNPMR/r0jvqF3++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRJ49oH4OJ+kR80o0LBl+Eu1lcsBDpsMElpPgJ5mZso=;
 b=VX4KBJif0R2uWqPa55lqfvz+aYvJsbYfkUpDBD5Uwws9lcyjtQoTKcxIx8Df36VrN44ZOv0IT44ANIxTDHK4T5GTiTMsxGauT40Sxs4Lh0zKnv+RcAoBXO62dGpZBUyNnJVoDpSSkrSxbkD1GrKbXJ4KD75B9bwUp/glfSiXzRU=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB1601.namprd11.prod.outlook.com (2603:10b6:405:f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Sat, 7 Mar
 2020 08:50:53 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::a0be:9e7c:714e:e2bd]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::a0be:9e7c:714e:e2bd%6]) with mapi id 15.20.2793.013; Sat, 7 Mar 2020
 08:50:53 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <robh@kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <linux-wireless@vger.kernel.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>
Subject: Re: [PATCH 1/2] staging: wilc1000: use 'interrupts' property instead
 of 'irq-gpio'
Thread-Topic: [PATCH 1/2] staging: wilc1000: use 'interrupts' property instead
 of 'irq-gpio'
Thread-Index: AQHV88WupU/867Y5g0u3Z47AmpcYLag7shyAgAEhWwA=
Date:   Sat, 7 Mar 2020 08:50:53 +0000
Message-ID: <4408ce4a-1914-ae73-e3e0-15cf2d283a6c@microchip.com>
References: <20200306144400.4269-1-ajay.kathat@microchip.com>
 <20200306144400.4269-2-ajay.kathat@microchip.com>
 <CAL_JsqKP-9bBMpkvMfphyAfdeVd44=pYDSOY=fSsx5xYkJPCjA@mail.gmail.com>
In-Reply-To: <CAL_JsqKP-9bBMpkvMfphyAfdeVd44=pYDSOY=fSsx5xYkJPCjA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [49.205.217.30]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b8eafa6-93d6-406c-29a0-08d7c274a4f5
x-ms-traffictypediagnostic: BN6PR11MB1601:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1601BAE70136DEAED483C4EDE3E00@BN6PR11MB1601.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 03355EE97E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(396003)(136003)(39860400002)(199004)(189003)(76116006)(66446008)(66946007)(91956017)(66556008)(966005)(5660300002)(64756008)(66476007)(36756003)(71200400001)(53546011)(478600001)(6486002)(6506007)(2616005)(31696002)(54906003)(4326008)(26005)(31686004)(86362001)(316002)(6512007)(81156014)(81166006)(8936002)(186003)(6916009)(2906002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1601;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jzfamJ9BJT19qO4c685Tu+Wh9RT1EXwZDXxkBA25Ce8DIuWZWTj1coBXfstjcjBiR0OxVeOt1yhUZO55ZCkeTJzztTubA2RuzlUMgXhW7EpR5WCHx1kS3cW12tAWSMQu2JYnqn/Fl5LGo8jw8jU+tWE4pyCXuDKB7+KNDVWkzYYHlKOQZbsKw0dg3/0bFTKrVivqU0EHv/23BoklM1AguNRe0agmg385OjYb5mkiXMvZC221AU5em+yi/ntjGVOtRvIpfg96B0ttK+Gmo3sXu/xQiscmTAkVoxuDM0lrdIqK4XzKyFt/AkXcCYnzhvl5aDhUClZhkN5LWfztx7PB4RRYiTE+chHwrOYcWrV/35qfGvx8UCAqyempELIr/+gtKeJwta67lyurJFkpVK3ewTuui4PcbP8Gu0XaszA4uvdnSdMNQLlXVmA99PPMuMOIXAONXqIpCR/67wc3+G2DnvGU7FC7NbuYjidSUnBnXtTn4/paCleLSqtATIjJArgq
x-ms-exchange-antispam-messagedata: IX3y6VMDeo22rl9O/7gG7k/zQ8kNV2GfNGvg6ZVjos5Z/Wk7avmNy3NEK+kgYwblLuBWxhUTKmYNI3Gy5pVFUFtujNOh3xK+50Wqjv8GPBKEjSrziuF68BsDjhZWQH14GIBQG+FJXdSsgAOPAEeThQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AA77E5AFC563449B59A4572E278CDD4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8eafa6-93d6-406c-29a0-08d7c274a4f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2020 08:50:53.3830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lQ8NpNIbWS+eZ0VHNtX6CvyMtr+NK3hgOP/Fd1fLN3/NAkr3ct5lkbuN9UAquffSMxWcADKaPswh8HjRj68RzbHdVNJdIa3Ce9lRjQ6yiIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1601
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgUm9iLA0KDQpPbiAwNi8wMy8yMCA5OjA1IHBtLCBSb2IgSGVycmluZyB3cm90ZToNCj4gDQo+
IE9uIEZyaSwgTWFyIDYsIDIwMjAgYXQgODo0NCBBTSA8QWpheS5LYXRoYXRAbWljcm9jaGlwLmNv
bT4gd3JvdGU6DQo+Pg0KPj4gRnJvbTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlw
LmNvbT4NCj4+DQo+PiBNYWtlIHVzZSBvZiAnaW50ZXJydXB0cycgcHJvcGVydHkgaW5zdGVhZCBv
ZiB1c2luZyBncGlvIGZvciBoYW5kbGluZw0KPj4gdGhlIGludGVycnVwdCBhcyBzdWdnZXN0ZWQg
aW4gWzFdLg0KPj4NCj4+IFsxXS4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtd2lyZWxl
c3MvMjAyMDAzMDMwMTU1NTguR0E2ODc2QGJvZ3VzLw0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEFq
YXkgU2luZ2ggPGFqYXkua2F0aGF0QG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICAuLi4vbmV0
L3dpcmVsZXNzL21pY3JvY2hpcCx3aWxjMTAwMC55YW1sICAgICAgfCA3OSArKysrKysrKysrKysr
KysrKysrDQo+PiAgLi4uL3dpbGMxMDAwL21pY3JvY2hpcCx3aWxjMTAwMCxzZGlvLnlhbWwgICAg
IHwgIDggKy0NCj4+ICAuLi4vd2lsYzEwMDAvbWljcm9jaGlwLHdpbGMxMDAwLHNwaS55YW1sICAg
ICAgfCAgOCArLQ0KPiANCj4gQmluZGluZ3Mgc2hvdWxkIGJlIGEgc2VwYXJhdGUgcGF0Y2guDQo+
IA0KDQpPay4gSSB3aWxsIGFkZCB0aGVtIGluIHNlcGFyYXRlIHBhdGNoLg0KDQo+PiAgZHJpdmVy
cy9zdGFnaW5nL3dpbGMxMDAwL25ldGRldi5jICAgICAgICAgICAgIHwgMjQgKystLS0tDQo+PiAg
ZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL25ldGRldi5oICAgICAgICAgICAgIHwgIDEgLQ0KPj4g
IGRyaXZlcnMvc3RhZ2luZy93aWxjMTAwMC9zZGlvLmMgICAgICAgICAgICAgICB8IDMxICsrKy0t
LS0tDQo+PiAgZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3NwaS5jICAgICAgICAgICAgICAgIHwg
MTUgKy0tLQ0KPj4gIGRyaXZlcnMvc3RhZ2luZy93aWxjMTAwMC93bGFuLmggICAgICAgICAgICAg
ICB8ICAxIC0NCj4+ICA4IGZpbGVzIGNoYW5nZWQsIDEwOCBpbnNlcnRpb25zKCspLCA1OSBkZWxl
dGlvbnMoLSkNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL25ldC93aXJlbGVzcy9taWNyb2NoaXAsd2lsYzEwMDAueWFtbA0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3dpcmVsZXNz
L21pY3JvY2hpcCx3aWxjMTAwMC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL25ldC93aXJlbGVzcy9taWNyb2NoaXAsd2lsYzEwMDAueWFtbA0KPj4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uYTE5MTQ0NDlhZDA3DQo+PiAtLS0gL2Rl
di9udWxsDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3dp
cmVsZXNzL21pY3JvY2hpcCx3aWxjMTAwMC55YW1sDQo+PiBAQCAtMCwwICsxLDc5IEBADQo+PiAr
IyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2Up
DQo+PiArJVlBTUwgMS4yDQo+PiArLS0tDQo+PiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcv
c2NoZW1hcy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwLHdpbGMxMDAwLnlhbWwjDQo+PiArJHNjaGVt
YTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+PiArDQo+
PiArdGl0bGU6IE1pY3JvY2hpcCBXSUxDIHdpcmVsZXNzIGRldmljZXRyZWUgYmluZGluZ3MNCj4+
ICsNCj4+ICttYWludGFpbmVyczoNCj4+ICsgIC0gQWRoYW0gQWJvemFlaWQgPGFkaGFtLmFib3ph
ZWlkQG1pY3JvY2hpcC5jb20+DQo+PiArICAtIEFqYXkgU2luZ2ggPGFqYXkua2F0aGF0QG1pY3Jv
Y2hpcC5jb20+DQo+PiArDQo+PiArZGVzY3JpcHRpb246DQo+PiArICBUaGUgd2lsYzEwMDAgY2hp
cHMgY2FuIGJlIGNvbm5lY3RlZCB2aWEgU1BJIG9yIFNESU8uIFRoaXMgZG9jdW1lbnQNCj4+ICsg
IGRlc2NyaWJlcyB0aGUgYmluZGluZyB0byBjb25uZWN0IHdpbGMgZGV2aWNlcy4NCj4+ICsNCj4+
ICtwcm9wZXJ0aWVzOg0KPj4gKyAgY29tcGF0aWJsZToNCj4+ICsgICAgY29uc3Q6IG1pY3JvY2hp
cCx3aWxjMTAwMA0KPj4gKw0KPj4gKyAgc3BpLW1heC1mcmVxdWVuY3k6DQo+PiArICAgIGRlc2Ny
aXB0aW9uOiBNYXhpbXVtIFNQSSBjbG9ja2luZyBzcGVlZCBvZiBkZXZpY2UgaW4gSHouDQo+PiAr
ICAgIG1heEl0ZW1zOiAxDQo+IA0KPiBObyBuZWVkIHRvIHJlZGVmaW5lIGEgY29tbW9uIHByb3Bl
cnR5LiBKdXN0Og0KPiANCj4gc3BpLW1heC1mcmVxdWVuY3k6IHRydWUNCj4gDQpPay4gSSB3aWxs
IGNoYW5nZXMgdGhpcy4NCg0KPj4gKw0KPj4gKyAgcmVnOg0KPj4gKyAgICBkZXNjcmlwdGlvbjog
Q2hpcCBzZWxlY3QgYWRkcmVzcyBvZiBkZXZpY2UuDQo+IA0KPiBEcm9wIHRoaXMuDQo+DQoNCk9r
Lg0KDQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+PiArICBpbnRlcnJ1cHRzOg0KPj4gKyAg
ICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgY2xvY2tzOg0KPj4gKyAgICBkZXNjcmlwdGlvbjog
cGhhbmRsZSB0byB0aGUgY2xvY2sgY29ubmVjdGVkIG9uIHJ0YyBjbG9jayBsaW5lLg0KPj4gKyAg
ICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgY2xvY2stbmFtZXM6DQo+PiArICAgIGNvbnN0OiBy
dGMNCj4+ICsNCj4+ICtyZXF1aXJlZDoNCj4+ICsgIC0gY29tcGF0aWJsZQ0KPj4gKyAgLSByZWcN
Cj4+ICsgIC0gaW50ZXJydXB0cw0KPj4gKw0KPj4gK2V4YW1wbGVzOg0KPj4gKyAgLSB8DQo+PiAr
ICAgIHNwaTE6IHNwaUBmYzAxODAwMCB7DQo+PiArICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47
DQo+PiArICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+PiArICAgICAgY3MtZ3Bpb3MgPSA8JnBp
b0IgMjEgMD47DQo+PiArICAgICAgd2lmaUAwIHsNCj4+ICsgICAgICAgIGNvbXBhdGlibGUgPSAi
bWljcm9jaGlwLHdpbGMxMDAwIjsNCj4+ICsgICAgICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDQ4
MDAwMDAwPjsNCj4+ICsgICAgICAgIHJlZyA9IDwwPjsNCj4+ICsgICAgICAgIGludGVycnVwdC1w
YXJlbnQgPSA8JnBpb0M+Ow0KPj4gKyAgICAgICAgaW50ZXJydXB0cyA9IDwyNyAwPjsNCj4+ICsg
ICAgICAgIGNsb2NrcyA9IDwmcGNrMT47DQo+PiArICAgICAgICBjbG9jay1uYW1lcyA9ICJydGMi
Ow0KPj4gKyAgICAgIH07DQo+PiArICAgIH07DQo+PiArDQo+PiArICAtIHwNCj4+ICsgICAgbW1j
MTogbW1jQGZjMDAwMDAwIHsNCj4+ICsgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4+ICsg
ICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4+ICsgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1
bHQiOw0KPj4gKyAgICAgIHBpbmN0cmwtMCA9IDwmcGluY3RybF9tbWMxX2Nsa19jbWRfZGF0MCAm
cGluY3RybF9tbWMxX2RhdDFfMz47DQo+PiArICAgICAgbm9uLXJlbW92YWJsZTsNCj4+ICsgICAg
ICB2bW1jLXN1cHBseSA9IDwmdmNjX21tYzFfcmVnPjsNCj4+ICsgICAgICB2cW1tYy1zdXBwbHkg
PSA8JnZjY18zdjNfcmVnPjsNCj4+ICsgICAgICBidXMtd2lkdGggPSA8ND47DQo+PiArICAgICAg
d2lmaUAwIHsNCj4+ICsgICAgICAgIGNvbXBhdGlibGUgPSAibWljcm9jaGlwLHdpbGMxMDAwIjsN
Cj4+ICsgICAgICAgIHJlZyA9IDwwPjsNCj4+ICsgICAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8
JnBpb0M+Ow0KPj4gKyAgICAgICAgaW50ZXJydXB0cyA9IDwyNyAwPjsNCj4+ICsgICAgICAgIGNs
b2NrcyA9IDwmcGNrMT47DQo+PiArICAgICAgICBjbG9jay1uYW1lcyA9ICJydGMiOw0KPj4gKyAg
ICAgIH07DQo+PiArICAgIH07DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dpbGMx
MDAwL21pY3JvY2hpcCx3aWxjMTAwMCxzZGlvLnlhbWwgYi9kcml2ZXJzL3N0YWdpbmcvd2lsYzEw
MDAvbWljcm9jaGlwLHdpbGMxMDAwLHNkaW8ueWFtbA0KPj4gaW5kZXggYjMzOGY1NjlmN2UyLi45
ZGY3MzI3YmM2NjggMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvbWlj
cm9jaGlwLHdpbGMxMDAwLHNkaW8ueWFtbA0KPj4gKysrIGIvZHJpdmVycy9zdGFnaW5nL3dpbGMx
MDAwL21pY3JvY2hpcCx3aWxjMTAwMCxzZGlvLnlhbWwNCj4gDQo+IFdoeSBhcmVuJ3QgeW91IGp1
c3QgcmVtb3ZpbmcgdGhpcyBmaWxlIGFuZCB0aGUgc3BpIG9uZT8NCg0KDQpUaGUgYmluZGluZyBm
aWxlIHdyb25nbHkgZ290IGFkZGVkIGluIHRoaXMgcGF0Y2guIEl0IG5lZWRzIHRvIGJlIGFkZGVk
DQpvbmx5IHRvICcvZHJpdmVyL3N0YWdpbmcvd2lsYzEwMDAnLiBJIHdpbGwgdXBkYXRlIHRoaXMg
YW5kIHNlbmQgdjINCnNlcmllcyBieSBrZWVwaW5nIGJpbmRpbmcgcGF0Y2ggc2VwYXJhdGUgZnJv
bSBjb2RlIGNoYW5nZXMuDQoNClJlZ2FyZHMsDQpBamF5
