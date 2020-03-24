Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4288A190629
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 08:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgCXHT6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 03:19:58 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:22753 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgCXHT6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 03:19:58 -0400
IronPort-SDR: hJOKXDh9yXcgJbwr/pcsz0y8WmHzwxhjPjQoDStZYbNNq6XQ6td00ymQAx4ywNUC7ypndRndiQ
 kmqh/8VeHyx6OYcI5dMGNZMklG+HKOGrfA4riVwFo3rICYc/QhKn8XN6OxbVgcDx7FYcmT9v8u
 8v3DF7FNN2uVyW5qVkWbcQSTqUo9rehqpA8F1Pu5vxV9J6XscvpwGwLN4+7TCG5IpSubqQ502p
 HCqIlhhE+Y+MiW9yC1qmUQuzxfUSyBH6WYSbymnM51L/o+mJK9v2P6pSv5XWm7E+Y+bAoADONA
 eA4=
X-IronPort-AV: E=Sophos;i="5.72,299,1580799600"; 
   d="scan'208";a="73235160"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Mar 2020 00:19:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Mar 2020 00:19:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 24 Mar 2020 00:19:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHjG2+GsG9v1k9aUZnsc/fasDH5TeRiUI50Ey8b2bUik1tM1j3F9aA+ZWJHMcWnD2pBoqHQ6/yWlamIOb1w7q5bet9ipc+VhjNQnGD8dnDFd8d8l2CV95w45xYwHODhSbxCkIEzPaWwnwq/iiR3aj2gHL/hL2+XLMeGCB1sTxB+b628dPi00M0AqtB6mbV9Fd5xilkM6xVyi8TP21dSwZpBNo66HkhUXfKAADyydPLzk8FRdhe1bg41lsb9gOVfSEPsahTLjLUcvIcdWuRgnaQmznkfkGpul2dCECNjFEG4lvnDOb++n93lgJVHS4DwArLuNptUVVjmbVst1fqELJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awFGiIh1w3j1JWUWLzeh+gkkO7nkMIxIS1CyCKHfRk8=;
 b=hgNeRfuL/tdhZjq6FCBFYvOlIFZPY6UoPfdWai2ueVmJCkce85/jPj0t6KX5AHb+EIuVHSwFacZh7f21owPakPIQFga1OlpJD1PSpXkCo1jjr+tC24weGouS9Gvpw+JadqbBxnLHIyHe/nVjBolcFALqT3+2TBEXeaWI9txswe975+xZXLghdLXbNS59NLaDTx3ESPwEpi99gxZcq76nX9+3FcaxiFrqJlla4z/DeXKx00IvY4YW5GP30WYhOTdWp5sFszLz2o8qgkhtzBG+E5hkXH5pk2X0lp53gzd/nCyAI8S2+UD12epcB21Zq5mHF0mVOQ6iZwQLTdvHW9qv1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awFGiIh1w3j1JWUWLzeh+gkkO7nkMIxIS1CyCKHfRk8=;
 b=U4Fw544Xw4HaYyHdJeDEP0IEvdpbt1DDlyxlwKSW7/3y1o3ZuGDhJOILB7OpC/Cfb5hHVzHWysqQx3j7IDOAyzkxuoMyo6BdLo+uqPSZN8J/Bpzg/O/XUuU3PBO/8oKpq/60vNgo8M+iaONP0yEujJBzSDnbxNXnb4YgYAH/k6g=
Received: from BYAPR11MB3125.namprd11.prod.outlook.com (2603:10b6:a03:8e::32)
 by BYAPR11MB3398.namprd11.prod.outlook.com (2603:10b6:a03:19::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Tue, 24 Mar
 2020 07:19:47 +0000
Received: from BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e]) by BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e%4]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 07:19:47 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <lkml@SDF.ORG>
CC:     <Adham.Abozaeid@microchip.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wilc1000: Use crc7 in lib/ rather than a private copy
Thread-Topic: [PATCH v2] wilc1000: Use crc7 in lib/ rather than a private copy
Thread-Index: AQHWATVOSzSIm82x00G0NQPRTejvI6hXVsWA
Date:   Tue, 24 Mar 2020 07:19:47 +0000
Message-ID: <c4c804d5-afeb-76e4-4fc6-fe56225ece5e@microchip.com>
References: <20200322120408.GA19411@SDF.ORG>
 <2315a030-75ad-0383-3aa3-25528d2cd29a@microchip.com>
 <20200323064558.GC19411@SDF.ORG>
 <48611e28-5a55-ab05-3865-71992a5be327@microchip.com>
 <20200323170516.GB3769@SDF.ORG>
In-Reply-To: <20200323170516.GB3769@SDF.ORG>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ajay.Kathat@microchip.com; 
x-originating-ip: [49.205.216.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e89af1ef-9075-44a3-a926-08d7cfc3bbe5
x-ms-traffictypediagnostic: BYAPR11MB3398:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3398F1AD1D83CEED60352CF1E3F10@BYAPR11MB3398.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39850400004)(366004)(346002)(376002)(6916009)(6506007)(66946007)(53546011)(54906003)(71200400001)(36756003)(2906002)(6486002)(8936002)(66446008)(316002)(2616005)(81166006)(4326008)(86362001)(26005)(76116006)(186003)(8676002)(91956017)(31696002)(66556008)(64756008)(66476007)(478600001)(6512007)(31686004)(5660300002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3398;H:BYAPR11MB3125.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TZuehzzxQmk3niUv0JGMl2g6e5qXtNqQpJ3ZJrcsldw+/4DnvGrWDf8DIiyPNs2kafKbMiVHgRj+pma5WpsZyGE0wwYnop4/u4CMZy5KeZjCCVpS/5nv694rSR6e7vXBtCJ9S1hXl8OpbW7825uWU9K08JkjL7+r1cwl3luT06+rDeBnP8MEGojrAImlSCSjOCfjmTW6+tXj1ybLnsTKsKs0u9UhU14bt5I4fKN+zuaOw4i5hOZmAANDpDzFF1zCrOGjrcOSDUy0ZmbRnl5eHeTp/6fs8sxbvVL4kMUgNO1MXqA1m7mjOP1StcTKF3xW6kvZ1T5MVMa1bDsGc/jwVlKJjYOBGsCyvsMJHfzH3PxSJdSaCYk4F6g6xLmotoQe/HihY0AgxdcmuFQEcliJ1hNevgZkIQfOb91MvQPH+baOZAUf42mFmrYykmUBFPwl
x-ms-exchange-antispam-messagedata: I0b7uhzpjXlfFa3aD8NePourL53QPqTZ2PA/mb6jdoXa+/uPQdskLUMHhUzvF22IcD94RrLmNtYT74MMTwJWR/i3TJCXsAQ1dOVHddQuMgCHTTzhXA9RAEiwwe9mckM+gV/9D9FsVW2Fde351lrxXw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <75E64C03D3284042A9484C99B5780F4A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e89af1ef-9075-44a3-a926-08d7cfc3bbe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 07:19:47.2558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iNAlDJLVWlwOmO4sJZkQoDsdWenieHq0yAxrR+CYDaRc9Z03VvuljNcpKO2xzZQ19PeI8gPUOSef2zlsZq9J4JCWLpLBzQc4QqCWxMGrPbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3398
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgR2VvcmdlLA0KDQpPbiAyMy8wMy8yMCAxMDozNSBwbSwgR2VvcmdlIFNwZWx2aW4gd3JvdGU6
DQo+IA0KPj4gRWFybGllciwgSSBhbHNvIHRyaWVkIHRvIHJlcGxhY2UgY3JjNyBieSB1c2luZyBl
eGlzdGluZyBsaWJyYXJ5IGJ1dCBpdA0KPj4gZ2F2ZSBkaWZmZXJlbnQgcmVzdWx0cyB3aXRoICdj
cmM3X2JlKCknIGJlY2F1c2UgSSBkaWRuJ3QgbW9kaWZ5ICcweDdmJw0KPj4gdG8gJzB4ZmUnLg0K
PiANCj4gSSBoYWQgYW4gYWZ0ZXJ0aG91Z2h0IHRoYXQgbWF5YmUgZG9jdW1lbnRpbmcgdGhpcyBp
biA8bGludXgvY3JjNy5oPg0KPiB3b3VsZCBiZSB1c2VmdWwsIHNpbmNlIHlvdSdyZSB1bmxpa2Vs
eSB0byBiZSB0aGUgbGFzdCBwZXJzb24gdG8NCj4gbWFrZSB0aGlzIG1pc3Rha2UuDQo+IA0KPiBT
b21ldGhpbmcgbGlrZToNCj4gDQo+IC8qDQo+ICAqIEdlbmVyYXRlIGEgQ1JDIHdpdGggdGhlIHBv
bHlub21pYWwgeF43ICsgeF4zICsgMSBhbmQgYmlnLWVuZGlhbg0KPiAgKiBiaXQgb3JkZXIuICAo
VGh1cywgdGhlIHBvbHlub21pYWwgaXMgMHg4OS4pICBUaGUgcmVzdWx0IGlzIGluIHRoZQ0KPiAg
KiBtb3N0LXNpZ25pZmljYW50IDcgYml0cyBvZiB0aGUgY3JjIHZhcmlhYmxlLg0KPiAgKg0KPiAg
KiBUaGlzIGlzIHdoZXJlIG1vc3QgcHJvdG9jb2xzIHdhbnQgdGhlIENSQyAodGhlIGxzYml0IGlz
IHBhc3QgdGhlDQo+ICAqIGVuZCBvZiBDUkMgY292ZXJhZ2UgYW5kIGlzIHVzZWQgZm9yIHNvbWV0
aGluZyBlbHNlKSwgYnV0IGRpZmZlcnMNCj4gICogZnJvbSBtb3N0IGV4YW1wbGUgY29kZSwgd2hp
Y2ggY29tcHV0ZXMgdGhlIENSQyBpbiB0aGUgbHNiaXRzIGFuZA0KPiAgKiBkb2VzIGFuIGV4cGxp
Y2l0IDEtYml0IHNoaWZ0IGF0IHRoZSBlbmQuDQo+ICAqDQo+ICAqIEJlY2F1c2UgdGhlIHN0YXRl
IGlzIG1haW50YWluZWQgbGVmdC1hbGlnbmVkLCB0aGUgY29tbW9uICJwcmVzZXQNCj4gICogdG8g
YWxsIG9uZXMiIENSQyB2YXJpYW50IHJlcXVpcmVzIHRoZSBjcmMgYmUgcHJlc2V0IHRvIDB4ZmUu
DQo+ICAqIChSaWdodC1hbGlnbmVkIGV4YW1wbGUgY29kZSB3aWxsIHNob3cgYSBwcmVzZXQgdG8g
MHg3Zi4pDQo+ICAqLw0KPiANCj4gRmVlbCBmcmVlIHRvIGFkZCB0aGF0IHRvIHRoZSBwYXRjaCAo
cHJlc2VydmluZyBteSBTLW8tYikgaWYgeW91IGxpa2UuDQo+IA0KDQpTb3VuZHMgZ29vZC4gSSB3
aWxsIHRyeSB0byBhZGQgdGhlc2UgY29tbWVudHMgaW4gYSBzZXBhcmF0ZSBwYXRjaCBmb3INCids
aW51eC9jcmM3LmgnLg0KDQo+PiBUaGFua3MgYWdhaW4gZm9yIHN1Ym1pdHRpbmcgdGhlIHBhdGNo
Lg0KPiANCj4gVGhhbmsgeW91IGZvciB3cml0aW5nIHRoZSB3aG9sZSBkcml2ZXIhICBJIGtub3cg
aXQgY2FuIGJlIGEgcmVhbCBQSVRBOw0KPiBMaW51eCBrZXJuZWwgZGV2ZWxvcGVycyBSZWFsbHkg
UmVhbGx5IFdhbnQgZHJpdmVycyBpbiBhIGNvbW1vbiBzdHlsZQ0KPiBhbmQgdXNpbmcgZXhpc3Rp
bmcga2VybmVsIGZhY2lsaXRpZXMgYXMgbXVjaCBhcyBwb3NzaWJsZSwgYnV0IHlvdSdyZQ0KPiB1
c3VhbGx5IHN0YXJ0aW5nIGZyb20gc29tZSBpbnRlcm5hbCBkcml2ZXIgdGhhdCBoYXMgaXRzIG93
biwNCj4gdmVyeSBkaWZmZXJlbnQsIHN1cHBvcnQgbGlicmFyeS4NCj4gDQoNCk92ZXIgbXVsdGlw
bGUgY29kZSByZXZpZXdzIGFuZCBjb250cmlidXRpb24gZnJvbSBjb21tdW5pdHkgaGFzIGhlbHBl
ZCB0bw0KYnJpbmcgdGhpcyBkcml2ZXIgdG8gZm9sbG93IGtlcm5lbCByZWNvbW1lbmRhdGlvbnMu
IEkgaG9wZSB0aGUgZHJpdmVyDQp3aWxsIGJlIHNvb24gb3V0IG9mIHN0YWdpbmcuDQoNCj4gQlRX
LCBvbmUgdGhpbmcgSSBub3RpY2VkIGF0IGNmZzgwMjExLmM6MTEzMjoNCj4gICAgICAgICAqY29v
a2llID0gcHJhbmRvbV91MzIoKTsNCj4gICAgICAgICBwcml2LT50eF9jb29raWUgPSAqY29va2ll
Ow0KPiANCj4gSSBkb24ndCBrbm93IHdoYXQgdGhlIGNvb2tpZSBpcyBmb3IsIGJ1dCBJIG5vdGlj
ZSB0aGF0ICpjb29raWUNCj4gYW5kIHByaXYtPnR4X2Nvb2tpZSBhcmUgYm90aCA2NC1iaXQgZGF0
YSB0eXBlcy4NCj4gDQo+IFNob3VsZCB0aGF0IGJlICIodTY0KXByYW5kb21fdTMyKCkgPDwgMzIg
fCBwcmFuZG9tX3UzMigpIg0KPiAoc2luY2UgdGhlcmUgaXMgbm8gcHJhbmRvbV91NjQoKSk/DQoN
Cg0KQWN0dWFsbHksIHRoZSBjb29raWUgaXMgdXNlZCB0byBtYXRjaCB0aGUgbWFuYWdlbWVudCBh
Y3Rpb24gZnJhbWUNCnJlcXVlc3RzIHdpdGggaXRzIHJlc3BvbnNlIHN0YXR1cyByZWNlaXZlZCBm
cm9tIHdpbGMxMDAwIGRldmljZS4NClRoZSBkcml2ZXIgYXNzaWduIHRoZSBjb29raWUgdmFsdWUg
Zm9yIHRyYW5zbWl0IG1hbmFnZW1lbnQgZnJhbWUNCnJlY2VpdmVkIGZyb20gdXNlciBzcGFjZSBh
bmQgbGF0ZXIgd2hpbGUgcHVibGlzaGluZyBzdGF0dXMgYmFjayBpdCB1c2VzDQp0aGUgc2FtZSBj
b29raWUgdmFsdWUuIEl0J3MgdmFsaWRhdGlvbiBpcyB0YWtlbiBjYXJlIGluIHVzZXIgc3BhY2Ug
IGUuZw0Kd3BhX3N1cHBsaWNhbnQuDQoNCkV2ZW4gdGhvdWdoIHRoZSBhcHBsaWNhdGlvbiBleHBl
Y3RzIHU2NC1iaXQgdmFsdWUgYnV0IHBhc3NpbmcgdXBzY2FsZWQNCnUzMi1iaXQgcmFuZG9tIHZh
bHVlKHByYW5kb21fdTMyKCkgYWxvbmUpIHNob3VsZCBiZSBlbm91Z2ggZm9yIHRoaXMgY2FzZS4N
Cg0KUmVnYXJkcywNCkFqYXk=
