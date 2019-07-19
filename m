Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7DD16E514
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2019 13:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfGSLeY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Jul 2019 07:34:24 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:5108 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfGSLeX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Jul 2019 07:34:23 -0400
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
IronPort-SDR: 9HAHxvPWKHMX6xXkIRGF6U0uGVsNJZI0irNPU7G8ckkRJsPvEpT8Q9lXvtNQ2tHrmJ+xbgJcZe
 ehA9Kl+68wm/P7qbbOeWYQt2UqVvhCw0H6jf7AylZYC3asj70566pKAyNw90PfJ1OeJ3f76Izu
 mCr0pWCAj5L5QJy+fX1JMs/u1YWRM6XOIpoeSV1UjuXSngaGVVczFNUvD6LoLdH+efrlkawnC5
 M9ptucVBYkpb8K222D1I/o4pw163kpe4dZx+HlbKTYm+Jj/n7i9yaSGhoHWfrkbCulY8Kr9C0W
 52I=
X-IronPort-AV: E=Sophos;i="5.64,282,1559545200"; 
   d="scan'208";a="38937699"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2019 04:34:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex01.mchp-main.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 19 Jul 2019 04:34:20 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 19 Jul 2019 04:34:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axGc15rfkuuqDQ5Mcb2E/COHI3ZtaeuHfTv4kt46/lrlUKGyL+hX7T0jXCvDM4hUGwnAnqGsCOZd+b5RmDz3PMv+DyzLdVHzh2EXHWNghlVTFS3pkDLpQwavACFFKqZMUYtcMZSTriClQeAVW4KjRjo3FEXmdO9gv2MBdNtlThpcC5br6hCdgc0D2a0O8UCOTdOTdMmD+lYjEuFlcB6qfLA6qnbUoDVmzTbkM0CfTZlMhX+S9VJXIFZoOuEdgVTEu4oxc4+9jPgBZGCMzuCS4+ucqoPrpXbStmWRMDrgvgbellzeD812fFeAME+kWBn3Jq/PxQF5wyd5VMVbvshCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ewje1OrZEmiwknx0jsN7gpq0TSuDGawzaNgGJVfHY0M=;
 b=KBnNdtrQMtP2L3vviHKyajRaiYHGahGcm8skSOQw95Qbo3dOvkO+bzXy5F1p5UEU0JLKiu70HbO8m/q4j00GHxRnWU7JTd1gQ4RAQatLZjszeqKLojuF/Lfm9cBCXYVxW+Ggj1usbwsojxgGYLyTbLeE8+0oHek5GpCmMFD7QFvTE/oxlBwblwAb/ItbS1CXx9cuQ+kKWDR5BcecurHuEkVoJ9/F/3Tgghi/RsHPymU1fkgyDE8isc7H5zgsLFb19MYwwMAKJlVF0zAFCrajmmQwLe+hK4peG77vqbONTtN1MSjUd3wVL7z1eTDEPSRCgmpbSbc4XxZWirajPp6oSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ewje1OrZEmiwknx0jsN7gpq0TSuDGawzaNgGJVfHY0M=;
 b=bSfWLbXvOpRDsUqkU2N8A37fRZPZNriOZKlOVsFki+MMvCS0fyynxseb0W0SAMZ7pbWPvBMG6C1zjvRsgmXOdTUkt7usOTRJzHvy01/zzgWiUl92RAZInunhRXe4UsoWNQoP73PMgJiluGQ4uFnx1fzt3Gqg2YiKJb/M1fF68mY=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1716.namprd11.prod.outlook.com (10.173.33.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Fri, 19 Jul 2019 11:34:17 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086%6]) with mapi id 15.20.2073.012; Fri, 19 Jul 2019
 11:34:17 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <hslester96@gmail.com>
CC:     <Adham.Abozaeid@microchip.com>, <gregkh@linuxfoundation.org>,
        <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: wilc1000: Merge memcpy + le32_to_cpus to
 get_unaligned_le32
Thread-Topic: [PATCH] staging: wilc1000: Merge memcpy + le32_to_cpus to
 get_unaligned_le32
Thread-Index: AQHVPglvMqeECHTdUkeF0n7ouW4TM6bRz6sA
Date:   Fri, 19 Jul 2019 11:34:17 +0000
Message-ID: <8c14743d-efe1-3e3a-0419-bde22f848751@microchip.com>
References: <20190719081005.4598-1-hslester96@gmail.com>
In-Reply-To: <20190719081005.4598-1-hslester96@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::27) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [49.205.218.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcf15511-97f7-4429-5857-08d70c3d08be
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1716;
x-ms-traffictypediagnostic: BN6PR11MB1716:
x-microsoft-antispam-prvs: <BN6PR11MB1716E68D1F5A60D1374E6518E3CB0@BN6PR11MB1716.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(366004)(396003)(189003)(199004)(2906002)(7736002)(8676002)(256004)(6436002)(486006)(31686004)(186003)(8936002)(476003)(71200400001)(54906003)(316002)(6486002)(1411001)(31696002)(68736007)(36756003)(66066001)(99286004)(86362001)(53546011)(386003)(305945005)(478600001)(76176011)(25786009)(14454004)(229853002)(6506007)(52116002)(53936002)(6512007)(6246003)(78486014)(81156014)(6116002)(3846002)(26005)(4326008)(81166006)(446003)(64756008)(66556008)(102836004)(66476007)(71190400001)(66446008)(66946007)(11346002)(6916009)(2616005)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1716;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j1vFk9/TA94SqN8P0CQBQp2PWEG7Jzh8oRtoXSiIAuOWjQFg/ZaRkN7+sm9ojkmUys9q4ea2naXDkx4fr1/miQPayuqFrqqf1xyaZ3/IfihxTmpOMJLsEHGvwxM83bQXrICr9ZfeoHLBgYocnYsTgFlrSIMY+//h3ihOZlwKU37q19VUVipgziXyFs/NpU9ktANQ8Pt1FNI3hknco41BZCBduEIDvbbM7ZtJSb6RPhL9F/jvVQuZ3vPAykIOPnV+Vwff6zPAFIDM2EPu+QEeKeAj5Mq6AArKr+gTBD+Vznfqm8fH/WilbWcDckl25+b6ArhljOnoKRAiW4rfXT1LAOpPnZBKMt/dqX6LGNCpMCZkuGld1DR/UiX0JFKtCm4ShB5k0AuAwJRmvgdK/oVIwgvmhVEKhFqme911THAKxEY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51182E83F4814747BE92D343F9FF7412@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf15511-97f7-4429-5857-08d70c3d08be
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 11:34:17.7943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajay.kathat@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gNy8xOS8yMDE5IDE6NDAgUE0sIENodWhvbmcgWXVhbiB3cm90ZToNCj4gDQo+IE1lcmdlIHRo
ZSBjb21ibyB1c2Ugb2YgbWVtY3B5IGFuZCBsZTMyX3RvX2NwdXMuDQo+IFVzZSBnZXRfdW5hbGln
bmVkX2xlMzIgaW5zdGVhZC4NCj4gVGhpcyBzaW1wbGlmaWVzIHRoZSBjb2RlLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQ2h1aG9uZyBZdWFuIDxoc2xlc3Rlcjk2QGdtYWlsLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvd2lsY193ZmlfY2Znb3BlcmF0aW9ucy5jIHwgMyAr
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvd2lsY193ZmlfY2Znb3Bl
cmF0aW9ucy5jIGIvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3dpbGNfd2ZpX2NmZ29wZXJhdGlv
bnMuYw0KPiBpbmRleCBkNzJmZGQzMzMwNTAuLjEyZmI0YWRkMDVlYyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3dpbGNfd2ZpX2NmZ29wZXJhdGlvbnMuYw0KPiArKysg
Yi9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvd2lsY193ZmlfY2Znb3BlcmF0aW9ucy5jDQo+IEBA
IC0xMDM4LDggKzEwMzgsNyBAQCB2b2lkIHdpbGNfd2ZpX3AycF9yeChzdHJ1Y3Qgd2lsY192aWYg
KnZpZiwgdTggKmJ1ZmYsIHUzMiBzaXplKQ0KPiAgCXMzMiBmcmVxOw0KPiAgCV9fbGUxNiBmYzsN
Cj4gIA0KPiAtCW1lbWNweSgmaGVhZGVyLCAoYnVmZiAtIEhPU1RfSERSX09GRlNFVCksIEhPU1Rf
SERSX09GRlNFVCk7DQo+IC0JbGUzMl90b19jcHVzKCZoZWFkZXIpOw0KPiArCWhlYWRlciA9IGdl
dF91bmFsaWduZWRfbGUzMihidWZmIC0gSE9TVF9IRFJfT0ZGU0VUKTsNCj4gIAlwa3Rfb2Zmc2V0
ID0gR0VUX1BLVF9PRkZTRVQoaGVhZGVyKTsNCj4gIA0KPiAgCWlmIChwa3Rfb2Zmc2V0ICYgSVNf
TUFOQUdNRU1FTlRfQ0FMTEJBQ0spIHsNCj4gDQoNClRoYW5rcyBmb3Igc2VuZGluZyB0aGUgcGF0
Y2hlcy4NCg0KVGhlIGNvZGUgY2hhbmdlIGxvb2tzIG9rYXkgdG8gbWUuIEp1c3QgYSBtaW5vciBj
b21tZW50LCBhdm9pZCB0aGUgdXNlIG9mDQpzYW1lIHN1YmplY3QgbGluZSBmb3IgZGlmZmVyZW50
IHBhdGNoZXMuDQoNClJlZ2FyZHMsDQpBamF5DQo=
