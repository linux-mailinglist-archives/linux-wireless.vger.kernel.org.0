Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 035056E55E
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2019 14:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfGSMFZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Jul 2019 08:05:25 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:59229 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfGSMFY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Jul 2019 08:05:24 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: iTVPItkSgZtFFMuMOVPd+dYPe//3xuMT3npqs/UXitqfb8So1/EbRgT8uFBbxKVwBn8uPXhVki
 0DRsAyT9HD9KJ9pFdZCStR8BB0F81jT+Nf6BvalLmsuwaPRJh216FmRyX2sY7kWt1XS/gAdoaQ
 HviBpAUfp52C3M+usr4QREscNVHMhxst8EomeVa1iGxpRDScwkT5RlCUknnm1bqGRmqSomwENd
 MjnuUg4UMsXLFr2wMUi9uZVLfN0gL5kAKldszJcUyokLj05w8tED2ieTnkiq9aug3pw1GQiIr0
 uOg=
X-IronPort-AV: E=Sophos;i="5.64,282,1559545200"; 
   d="scan'208";a="38940952"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2019 05:05:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex01.mchp-main.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 19 Jul 2019 05:05:11 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 19 Jul 2019 05:05:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HScWxfsp4BwXhpi/c6OaLxg9bT+nAz7whHxtVcpCRTUwKBOUkB93qJE/3jFsJ+BcKczX0Qlu3YRLSp+4LNERBV4bU0LGP5rF2R0kB+WRFXIVMZhnWe+oaPr0zmJst3N3ArJGRZhAQEotDlzMQUR0JOtScWHAQ4TEdKQhlDB/1Al41W0+q6hICa2rgd+IAz5m3BwWROCVhwuZZ9vzaT0iBs9Q8Dq5y3mLJQnGzO/8NGFjLr60AOrq9G3ii/7zqgzL4MPXwe9uEwYUMB8N+YZDDnYJFNNdpf1p4Gvo/wXEJ/gKeRKaUqqXigIu7JX+Fxr9sNzxxXQji2g7Yu2b9+SPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/U0KcqtPqPBLo+Y+DEru40WG2e5Y0XPpCLbCYLgHgWs=;
 b=hrKQYOS6aIG6/We3rM8qwQMHmLN2Vs2P2ktornVjpl+LfG+L0CoNZMAdRisaGWVYsnlma5nZmTTj56ceeOoXkCgldmESt2p/VLxQ3OV1c7wKa9yu/50w+Ti0WY3K44DeqeOfdNllJjMGcKjTje1gxfzi/Q00IPIWmMwV8csDbZb8vyaZwB+JeH7jHoYa4zkQUSutO7vYE1tc2CqKLD7KKy4gkU/VWir2GwOyTl6idcl06RnqtALApFeAk1HFOnD5FHBVXf1z4QmQJ5IeePJ53579cRO35511xqj3At10Q+SkSqYDu+94CFDksirB4P94sdpDLrBru5a1tGYoX9+n+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/U0KcqtPqPBLo+Y+DEru40WG2e5Y0XPpCLbCYLgHgWs=;
 b=Jq2fcTSZBmcWN9nJENFFu9I2U6bt0q+un5+CDdtt8P2/FMbZrG00EPoZe/xfqkv76gdczCSBRz3p4+oJnU6wY5B9ARxgvK2t4UviGT63rFNCnXHIKkGobwK9JanWh27Z+hfUApTcJiACbTuH2r0Zd22xdxgDJbwKackhmm8ZiJQ=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1778.namprd11.prod.outlook.com (10.175.99.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.14; Fri, 19 Jul 2019 12:05:07 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086%6]) with mapi id 15.20.2073.012; Fri, 19 Jul 2019
 12:05:07 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <hslester96@gmail.com>
CC:     <Adham.Abozaeid@microchip.com>, <gregkh@linuxfoundation.org>,
        <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: wilc1000: Merge memcpy + le32_to_cpus to
 get_unaligned_le32
Thread-Topic: [PATCH] staging: wilc1000: Merge memcpy + le32_to_cpus to
 get_unaligned_le32
Thread-Index: AQHVPglvMqeECHTdUkeF0n7ouW4TM6bRz6sAgAADegCAAAUkAA==
Date:   Fri, 19 Jul 2019 12:05:07 +0000
Message-ID: <82dc6d2e-5f62-b2c7-296a-38f781628ec5@microchip.com>
References: <20190719081005.4598-1-hslester96@gmail.com>
 <8c14743d-efe1-3e3a-0419-bde22f848751@microchip.com>
 <CANhBUQ3knUV44GiaB-xZMD8F6y8dcZQdznSmpk3E9ZKoakkBRQ@mail.gmail.com>
In-Reply-To: <CANhBUQ3knUV44GiaB-xZMD8F6y8dcZQdznSmpk3E9ZKoakkBRQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PN1PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::30) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [49.205.218.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 589308c6-0ee5-47e7-e83a-08d70c415775
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1778;
x-ms-traffictypediagnostic: BN6PR11MB1778:
x-microsoft-antispam-prvs: <BN6PR11MB17788B0CC2782A789587D8E7E3CB0@BN6PR11MB1778.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(396003)(366004)(376002)(189003)(199004)(386003)(446003)(53546011)(2616005)(6506007)(11346002)(476003)(186003)(76176011)(52116002)(102836004)(26005)(316002)(36756003)(14444005)(256004)(25786009)(86362001)(99286004)(5660300002)(31696002)(54906003)(3846002)(6116002)(478600001)(14454004)(64756008)(71200400001)(66556008)(66476007)(66446008)(71190400001)(78486014)(66946007)(6486002)(6246003)(1411001)(2906002)(305945005)(7736002)(81166006)(8936002)(6512007)(66066001)(81156014)(68736007)(229853002)(486006)(4326008)(31686004)(53936002)(8676002)(6436002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1778;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bpEm6uX+sv62Vgx2rAPDDHszFnqfQgfXAkziucRxrApkn6E3EeI4jT/qEkTrOrzfJB3Ovwyyaxjcp/877QkT60CkyFUWysO/wRnENPzzKzfXAaqv1t50xroymG48grJJUfCx8JvE0y98ZDRoObsciXPUpVwyVV1U8ZbKLApmp2m/h1bb+Fssg8ztFJlKVr9mvEu9FX9KZh6NIb5GQqW61hRDHNziCLVrFa8W7lx7JZKIAqBXteORBOIFE1eUDnLGbbY+NyFm5OQVnKuuHoqgjVvYbkwE9r7nOGJu75CKVvnomfgK+kEbHvs/+8UhI5imgV5XnOv+/+HMSapZaIrbcmbEjtE7VmsM9TtLvQPHc9fRWejTlHwCFomPApxBc/Hv9zV/ZwoM19POQThxlCxX4TOqLEry/O0ACJ8HY+KZ2BA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24E59B363CECA045B8537AC10CA29CF2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 589308c6-0ee5-47e7-e83a-08d70c415775
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 12:05:07.7975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajay.kathat@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1778
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQpPbiA3LzE5LzIwMTkgNToxNiBQTSwgQ2h1aG9uZyBZdWFuIHdyb3RlOg0KPiANCj4gPEFqYXku
S2F0aGF0QG1pY3JvY2hpcC5jb20+IOS6jjIwMTnlubQ35pyIMTnml6XlkajkupQg5LiL5Y2INzoz
NOWGmemBk++8mg0KPj4NCj4+IE9uIDcvMTkvMjAxOSAxOjQwIFBNLCBDaHVob25nIFl1YW4gd3Jv
dGU6DQo+Pj4NCj4+PiBNZXJnZSB0aGUgY29tYm8gdXNlIG9mIG1lbWNweSBhbmQgbGUzMl90b19j
cHVzLg0KPj4+IFVzZSBnZXRfdW5hbGlnbmVkX2xlMzIgaW5zdGVhZC4NCj4+PiBUaGlzIHNpbXBs
aWZpZXMgdGhlIGNvZGUuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBDaHVob25nIFl1YW4gPGhz
bGVzdGVyOTZAZ21haWwuY29tPg0KPj4+IC0tLQ0KPj4+ICBkcml2ZXJzL3N0YWdpbmcvd2lsYzEw
MDAvd2lsY193ZmlfY2Znb3BlcmF0aW9ucy5jIHwgMyArLS0NCj4+PiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvc3RhZ2luZy93aWxjMTAwMC93aWxjX3dmaV9jZmdvcGVyYXRpb25zLmMgYi9kcml2ZXJz
L3N0YWdpbmcvd2lsYzEwMDAvd2lsY193ZmlfY2Znb3BlcmF0aW9ucy5jDQo+Pj4gaW5kZXggZDcy
ZmRkMzMzMDUwLi4xMmZiNGFkZDA1ZWMgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9zdGFnaW5n
L3dpbGMxMDAwL3dpbGNfd2ZpX2NmZ29wZXJhdGlvbnMuYw0KPj4+ICsrKyBiL2RyaXZlcnMvc3Rh
Z2luZy93aWxjMTAwMC93aWxjX3dmaV9jZmdvcGVyYXRpb25zLmMNCj4+PiBAQCAtMTAzOCw4ICsx
MDM4LDcgQEAgdm9pZCB3aWxjX3dmaV9wMnBfcngoc3RydWN0IHdpbGNfdmlmICp2aWYsIHU4ICpi
dWZmLCB1MzIgc2l6ZSkNCj4+PiAgICAgICBzMzIgZnJlcTsNCj4+PiAgICAgICBfX2xlMTYgZmM7
DQo+Pj4NCj4+PiAtICAgICBtZW1jcHkoJmhlYWRlciwgKGJ1ZmYgLSBIT1NUX0hEUl9PRkZTRVQp
LCBIT1NUX0hEUl9PRkZTRVQpOw0KPj4+IC0gICAgIGxlMzJfdG9fY3B1cygmaGVhZGVyKTsNCj4+
PiArICAgICBoZWFkZXIgPSBnZXRfdW5hbGlnbmVkX2xlMzIoYnVmZiAtIEhPU1RfSERSX09GRlNF
VCk7DQo+Pj4gICAgICAgcGt0X29mZnNldCA9IEdFVF9QS1RfT0ZGU0VUKGhlYWRlcik7DQo+Pj4N
Cj4+PiAgICAgICBpZiAocGt0X29mZnNldCAmIElTX01BTkFHTUVNRU5UX0NBTExCQUNLKSB7DQo+
Pj4NCj4+DQo+PiBUaGFua3MgZm9yIHNlbmRpbmcgdGhlIHBhdGNoZXMuDQo+Pg0KPj4gVGhlIGNv
ZGUgY2hhbmdlIGxvb2tzIG9rYXkgdG8gbWUuIEp1c3QgYSBtaW5vciBjb21tZW50LCBhdm9pZCB0
aGUgdXNlIG9mDQo+PiBzYW1lIHN1YmplY3QgbGluZSBmb3IgZGlmZmVyZW50IHBhdGNoZXMuDQo+
IA0KPiBUaGVzZSB0d28gcGF0Y2hlcyBhcmUgaW4gdGhlIHNhbWUgc3Vic3lzdGVtIGFuZCBzb2x2
ZSB0aGUgc2FtZSBwcm9ibGVtLg0KPiBJIHNwbGl0dGVkIHRoZW0gaW50byB0d28gcGF0Y2hlcyBi
eSBtaXN0YWtlIHNpbmNlIEkgZGlkIG5vdCBub3RpY2UgdGhlIHByb2JsZW1zDQo+IGluIHRoZSBz
ZWNvbmQgcGF0Y2ggd2hlbiBJIHNlbnQgdGhlIGZpcnN0IG9uZS4NCj4gU2hvdWxkIEkgbWVyZ2Ug
dGhlIHR3byBwYXRjaGVzIGFuZCByZXNlbmQ/DQo+IA0KDQpZZXMsIHBsZWFzZSBnbyBhaGVhZCwg
bWVyZ2UgdGhlIHBhdGNoZXMgYW5kIHNlbmQgdGhlIHVwZGF0ZWQgdmVyc2lvbi4NCg0KUmVnYXJk
cywNCkFqYXkNCg==
