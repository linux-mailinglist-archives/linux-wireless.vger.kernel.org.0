Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAA07B47E3
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 09:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387915AbfIQHLv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 03:11:51 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:61587 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387879AbfIQHLv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 03:11:51 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: D7eQuBu+4pah/WZnz0JJUsH4jwqb8zruTV3HdBqCy/1mDHisKb0v4Eadcr5V0bw9lZIelL2q7B
 PVTGU0iI1+05xafc/PHRwXSLiseBNAAx/VKNPTux2GEo9lMhEuDLnzA/stmt1WUO2b23Wat4JV
 mjNEZkcLacyJd6OLXpXhMuRJ34BHywt6Jqs1PWhQbOpBxY7alvXSppB4LjO0JY0+aouLKYP2JQ
 9Il73tnDyVTV3vqowyZGlhBPZsRNAQ1nzMnSGrucvQjIJIHC55894YN+5elJDJ1gkACoIF4Bk4
 B1E=
X-IronPort-AV: E=Sophos;i="5.64,515,1559545200"; 
   d="scan'208";a="48188493"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2019 00:11:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Sep 2019 00:11:49 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Sep 2019 00:11:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+kunzIW9EC2Vdhd+OWoK9rUnWT6wPArOxmLQfrMMnp3fC3FFQwGtZKEoQHiVtGaFCQUF0NdKZ6hSjFJ8Lz4g79B5i3NadNBmPSeGtcWeoBZY3A2cOJRNEqc9XYiVEcgvPb5XRutc9Xkx0v5AFwSu2LHJK7kLE094BTe+S4q6YwSbFI1Z5x1AJxZSJuT1t26MIBSA33oVoEsUQGMnQuxdjvgicCHvPogb+wBpXSft8aLQB0OAFgJjD61Z9ula1cu+DLRLLyIcF/P35sx3Rc6UaHBIDLRm7eIRlS9KsGAOVjl4Dc7MhebMx6a83+ECzVAtjGCOOV93u5bSc7r+HTc+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiBR0FJOv8HnZmgO5ujzVQNY2sINwFtFNAvXegIzlX4=;
 b=VdU57uZUHoawz0oyZFWMjnUECLaLaTZMA5PS7Mxe4gWEmdW1CPtrJ/BomaXFFaHdlBcVQ8I1c37d/313VPf2OgfQzg8x1SXJ5L4iMdMoSCMzGhd6wq8MiGiykz8Dy/20W915aVPcrJjVPN8CA4kaSN1f5fjBK89I6D4MyszbhNBAURwjEWF/9uHBWJniVx3tYOSnWvH1lJnp3GUZmQGrWfLvEBhLhxVVhiqK8KY0WRGDVoO2UDlzD8eqpLBNc01lrDOocvNb31DRtTxBYjzJbADGdoRNlqRQmFfDEYIfoi6VsrV6HBvU2swbvpHZgOpDA9c1F/aaMj8yzlr9qbqCOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiBR0FJOv8HnZmgO5ujzVQNY2sINwFtFNAvXegIzlX4=;
 b=cckMunNqniS9gQMwQ7sA7v3GMPWcpuBiA2En8q4QjZy45IfevXDBnWF0ONFcsOL6IIuvqpIcb2FMDqlwy6f0ISNVHe0PWUJnI5pMIeYoZSjV5blH8SsvEn0iS324p6dcxUToOvP+an1NxXnXTyP+lv2U1R0ue+TRRCBPMSZqg2A=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1824.namprd11.prod.outlook.com (10.175.54.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.23; Tue, 17 Sep 2019 07:11:47 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::e1f5:745f:84b4:7c7c]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::e1f5:745f:84b4:7c7c%12]) with mapi id 15.20.2263.023; Tue, 17 Sep
 2019 07:11:47 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Adham.Abozaeid@microchip.com>, <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <Ajay.Kathat@microchip.com>,
        <gregkh@linuxfoundation.org>, <Eugen.Hristev@microchip.com>,
        <johannes@sipsolutions.net>
Subject: Re: [PATCH] staging: wilc1000: look for rtc_clk clock in spi mode
Thread-Topic: [PATCH] staging: wilc1000: look for rtc_clk clock in spi mode
Thread-Index: AQHVbScl6jIVhd9+50ifu++xL1vFiQ==
Date:   Tue, 17 Sep 2019 07:11:47 +0000
Message-ID: <33c095f7-57a8-1d80-02af-0195f317bc39@microchip.com>
References: <20190916193701.20755-1-adham.abozaeid@microchip.com>
In-Reply-To: <20190916193701.20755-1-adham.abozaeid@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0902CA0047.eurprd09.prod.outlook.com
 (2603:10a6:802:1::36) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190917101138274
x-originating-ip: [86.120.236.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 259ec526-674f-430e-469b-08d73b3e4d88
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR11MB1824;
x-ms-traffictypediagnostic: MWHPR11MB1824:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB182433383B9F313CB190C3FC878F0@MWHPR11MB1824.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:605;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(396003)(376002)(189003)(199004)(4326008)(2501003)(6116002)(3846002)(66066001)(2906002)(476003)(86362001)(229853002)(81156014)(8936002)(81166006)(31696002)(5660300002)(26005)(76176011)(11346002)(446003)(71200400001)(186003)(8676002)(71190400001)(386003)(6436002)(6512007)(53546011)(6246003)(6486002)(6306002)(6506007)(52116002)(31686004)(102836004)(66556008)(64756008)(14454004)(14444005)(66446008)(66476007)(966005)(256004)(478600001)(36756003)(2616005)(7736002)(486006)(305945005)(99286004)(54906003)(110136005)(316002)(25786009)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1824;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VIIOymEhZ28mwiLpRxDNJkRIGq+rM3f0su2K6+DPj5t8hxVeErmwO6Nt2vortgDPsIlAOqeq1L7wBMFkIj5j0Cgg31i1jFaj1YE9gNyeUg5bosefsu399i49LFKGA53wSLmC5Zdr/7v/F+ioVh3yCYXbZicULtN3eTvo85OIR0BKhLbZHUpj+Snw/tpFCN/L9jp/m3tSAmBD9fNtz6zdixzKLU1W/193xNDL+rlexb0qNWL37dWtGP85YbmO4Lm3h+GRnZ/5ALS/aKjTZibrKNiakOqrIovQbxBni+psnfUotEvNlG1Z//3at/htqFC3jX0kC4CRRrVpT3HSCl15Q7+btGVNQ9EVIBpPdi2JTshULmoHm3Xr/dRHoR9/QLpLf8kMK9LFemPIF9fUT07oA7b4RMfLIk79Ricr6Zk4i00=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F43B7A6F6C49A4B9D87E4F8A1B44DF4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 259ec526-674f-430e-469b-08d73b3e4d88
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 07:11:47.4460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sBOqVzG6qxfFEtJPaaGHel1mCi7+RIHtPUsS12tOqFb1zoFRXdxAj65pj6RLiVZYVvOzKa8+cvL+XdTiaAXAseKoI5ECdUqB/OfEamiN3sA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1824
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhpcyBpcyBhbHJlYWR5IHByZXNlbnQgaW4gc3RhZ2luZy1uZXh0IChzZWUgWzFdIGFuZCBbMl0p
DQoNClsxXSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9n
cmVna2gvc3RhZ2luZy5naXQvY29tbWl0L2RyaXZlcnMvc3RhZ2luZy93aWxjMTAwMD9oPXN0YWdp
bmctbmV4dCZpZD04NjkyYjA0N2U4NmNmZjQ0OGFmMTU2NGE4YmRkYTc3MGQyZGViNTY3DQpbMl0g
aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvZ3JlZ2toL3N0
YWdpbmcuZ2l0L2NvbW1pdC9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDA/aD1zdGFnaW5nLW5leHQm
aWQ9YWU4Nzc5ZTE5ODNkNjM2MTYyMGYxZjZkM2Y3NjA2NGVkZWU3MzNjMA0KDQpPbiAxNi4wOS4y
MDE5IDIyOjM3LCBBZGhhbS5BYm96YWVpZEBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPiBFeHRlcm5h
bCBFLU1haWwNCj4gDQo+IA0KPiBGcm9tOiBBZGhhbSBBYm96YWVpZCA8YWRoYW0uYWJvemFlaWRA
bWljcm9jaGlwLmNvbT4NCj4gDQo+IElmIHJ0Y19jbGsgaXMgcHJvdmlkZWQgZnJvbSBEVCwgdXNl
IGl0IGFuZCBlbmFibGUgaXQuDQo+IFRoaXMgaXMgb3B0aW9uYWwuDQo+IFRoZSBzaWduYWwgbWF5
IGJlIGhhcmRjb2RlZCBhbmQgbm8gbmVlZCB0byBiZSByZXF1ZXN0ZWQsDQo+IGJ1dCBpZiBEVCBw
cm92aWRlcyBpdCwgdXNlIGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWRoYW0gQWJvemFlaWQg
PGFkaGFtLmFib3phZWlkQG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9zdGFnaW5n
L3dpbGMxMDAwL3dpbGNfc3BpLmMgfCAxMSArKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQs
IDExIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2ls
YzEwMDAvd2lsY19zcGkuYyBiL2RyaXZlcnMvc3RhZ2luZy93aWxjMTAwMC93aWxjX3NwaS5jDQo+
IGluZGV4IDNjMWFlOWU5ZjlhYS4uMTY2NDU1YTk2OWJmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3N0YWdpbmcvd2lsYzEwMDAvd2lsY19zcGkuYw0KPiArKysgYi9kcml2ZXJzL3N0YWdpbmcvd2ls
YzEwMDAvd2lsY19zcGkuYw0KPiBAQCAtNCw2ICs0LDcgQEANCj4gICAqIEFsbCByaWdodHMgcmVz
ZXJ2ZWQuDQo+ICAgKi8NCj4gIA0KPiArI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiAgI2luY2x1
ZGUgPGxpbnV4L3NwaS9zcGkuaD4NCj4gIA0KPiAgI2luY2x1ZGUgIndpbGNfd2ZpX25ldGRldmlj
ZS5oIg0KPiBAQCAtMTMyLDYgKzEzMywxMiBAQCBzdGF0aWMgaW50IHdpbGNfYnVzX3Byb2JlKHN0
cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+ICAJd2lsYy0+YnVzX2RhdGEgPSBzcGlfcHJpdjsNCj4g
IAl3aWxjLT5ncGlvX2lycSA9IGdwaW87DQo+ICANCj4gKwl3aWxjLT5ydGNfY2xrID0gZGV2bV9j
bGtfZ2V0KCZzcGktPmRldiwgInJ0Y19jbGsiKTsNCj4gKwlpZiAoUFRSX0VSUl9PUl9aRVJPKHdp
bGMtPnJ0Y19jbGspID09IC1FUFJPQkVfREVGRVIpDQo+ICsJCXJldHVybiAtRVBST0JFX0RFRkVS
Ow0KPiArCWVsc2UgaWYgKCFJU19FUlIod2lsYy0+cnRjX2NsaykpDQo+ICsJCWNsa19wcmVwYXJl
X2VuYWJsZSh3aWxjLT5ydGNfY2xrKTsNCj4gKw0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+
IEBAIC0xNDIsNiArMTQ5LDEwIEBAIHN0YXRpYyBpbnQgd2lsY19idXNfcmVtb3ZlKHN0cnVjdCBz
cGlfZGV2aWNlICpzcGkpDQo+ICAJLyogZnJlZSB0aGUgR1BJTyBpbiBtb2R1bGUgcmVtb3ZlICov
DQo+ICAJaWYgKHdpbGMtPmdwaW9faXJxKQ0KPiAgCQlncGlvZF9wdXQod2lsYy0+Z3Bpb19pcnEp
Ow0KPiArDQo+ICsJaWYgKCFJU19FUlIod2lsYy0+cnRjX2NsaykpDQo+ICsJCWNsa19kaXNhYmxl
X3VucHJlcGFyZSh3aWxjLT5ydGNfY2xrKTsNCj4gKw0KPiAgCXdpbGNfbmV0ZGV2X2NsZWFudXAo
d2lsYyk7DQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+IA0K
