Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFC8B56971
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2019 14:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfFZMlO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jun 2019 08:41:14 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:3372 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfFZMlN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jun 2019 08:41:13 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,419,1557212400"; 
   d="scan'208";a="37422545"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2019 05:41:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex04.mchp-main.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 26 Jun 2019 05:42:19 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 26 Jun 2019 05:41:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdys3uLCuEPQGBrMaFOB+Jfxg0NLWXa/10sqWEiqueY=;
 b=Rw3Tuq58dk4Tk7YIIArvXxny7rRIfzYP0rMq4vtF9Aj7EDpCzDTztL91aN4dZ0/HQou1CpWnoTHvbiuBC5GW/oobeT3kUV4hxIOkdpV+Qykv7U1ocBGovMFyT3Pj0OicpBRaYFC3bDNOkIA07qCEWc2neD1SaqIOcVsQUkKGuB0=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB3907.namprd11.prod.outlook.com (10.255.131.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 12:41:07 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::49ee:ab78:412:48ac]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::49ee:ab78:412:48ac%5]) with mapi id 15.20.2008.017; Wed, 26 Jun 2019
 12:41:07 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 8/8] staging: wilc1000: rename 'host_interface' source and
 header
Thread-Topic: [PATCH 8/8] staging: wilc1000: rename 'host_interface' source
 and header
Thread-Index: AQHVLBxs9VL06WIKl02rM1YZN1ce8A==
Date:   Wed, 26 Jun 2019 12:41:06 +0000
Message-ID: <1561552810-8933-9-git-send-email-ajay.kathat@microchip.com>
References: <1561552810-8933-1-git-send-email-ajay.kathat@microchip.com>
In-Reply-To: <1561552810-8933-1-git-send-email-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::28) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [183.82.16.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a168db9-537e-4260-53ba-08d6fa338ed8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB3907;
x-ms-traffictypediagnostic: BN6PR11MB3907:
x-microsoft-antispam-prvs: <BN6PR11MB39073EF4F03696EAA4B2540AE3E20@BN6PR11MB3907.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(366004)(396003)(376002)(199004)(189003)(476003)(14454004)(54906003)(81166006)(8936002)(2616005)(446003)(486006)(81156014)(6506007)(6436002)(6512007)(386003)(186003)(11346002)(5640700003)(102836004)(36756003)(316002)(6116002)(3846002)(26005)(2906002)(72206003)(478600001)(66066001)(50226002)(66446008)(2501003)(5660300002)(6486002)(107886003)(66556008)(64756008)(2351001)(86362001)(25786009)(6916009)(4326008)(8676002)(71190400001)(71200400001)(7736002)(76176011)(256004)(99286004)(68736007)(305945005)(52116002)(78486014)(53936002)(66476007)(73956011)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB3907;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5bva9cMrc/tzT7Dg3Cjsoxy17GAS5VGzbfkKcsMgchD+dzoDj6EDhub2sNny+2S8Rx+66U3OqyPNBqhxs5h9UCe8Edk5oA/RuuPMPamh/uV5EAN/4Ls1zXGnlziFx/zHZGRsf7FZf0IlkPz/Oo/i9krbAq26XKbpGSM4mA4ldvYDcLAVxppkFzl7LDyXUi17+iVCtPWq3T24FELF2Jc5OZsLk9gWUVl4P/34U7Z7bjs5u2lIJCiOK9W7jJWjZ5mPl7n+oMmnXcFBmPfh7T3Hit2rvQkYsotEaO5b/iPUvG1V1rWvBA+Igtnloc8KJAtQghl38LfVM9a0hQvXMifT3eAUMZSxW6ajoAE2tJgnj1mvqs/jB+KsoNvt66OdD6o2WQLUwcwMcesgSjM0iGY8TzrniaZzN3PQe03oidy5cqE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a168db9-537e-4260-53ba-08d6fa338ed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 12:41:06.9470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajay.kathat@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3907
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlwLmNvbT4NCg0KUmVuYW1lICdo
b3N0X2ludGVyZmFjZScgc291cmNlIGFuZCBoZWFkZXIgZmlsZSB0byBpbmNsdWRlIHRoZSAnd2ls
Y18nDQpwcmVmaXggaW4gaXRzIG5hbWUuDQoNClNpZ25lZC1vZmYtYnk6IEFqYXkgU2luZ2ggPGFq
YXkua2F0aGF0QG1pY3JvY2hpcC5jb20+DQotLS0NCiBkcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAv
TWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgfCAyICstDQogZHJpdmVycy9zdGFnaW5n
L3dpbGMxMDAwL3tob3N0X2ludGVyZmFjZS5jID0+IHdpbGNfaGlmLmN9IHwgMA0KIGRyaXZlcnMv
c3RhZ2luZy93aWxjMTAwMC97aG9zdF9pbnRlcmZhY2UuaCA9PiB3aWxjX2hpZi5ofSB8IDANCiBk
cml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvd2lsY193ZmlfbmV0ZGV2aWNlLmggICAgICAgICAgICAg
fCAyICstDQogNCBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQogcmVuYW1lIGRyaXZlcnMvc3RhZ2luZy93aWxjMTAwMC97aG9zdF9pbnRlcmZhY2UuYyA9PiB3
aWxjX2hpZi5jfSAoMTAwJSkNCiByZW5hbWUgZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3tob3N0
X2ludGVyZmFjZS5oID0+IHdpbGNfaGlmLmh9ICgxMDAlKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9zdGFnaW5nL3dpbGMxMDAwL01ha2VmaWxlIGIvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL01h
a2VmaWxlDQppbmRleCAyYWQzZmVlLi5hNWE4ZTgwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zdGFn
aW5nL3dpbGMxMDAwL01ha2VmaWxlDQorKysgYi9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvTWFr
ZWZpbGUNCkBAIC01LDcgKzUsNyBAQCBjY2ZsYWdzLXkgKz0gLURGSVJNV0FSRV8xMDAyPVwiYXRt
ZWwvd2lsYzEwMDJfZmlybXdhcmUuYmluXCIgXA0KIAkJLURGSVJNV0FSRV8xMDAzPVwiYXRtZWwv
d2lsYzEwMDNfZmlybXdhcmUuYmluXCINCiANCiB3aWxjMTAwMC1vYmpzIDo9IHdpbGNfd2ZpX2Nm
Z29wZXJhdGlvbnMubyB3aWxjX25ldGRldi5vIHdpbGNfbW9uLm8gXA0KLQkJCWhvc3RfaW50ZXJm
YWNlLm8gd2lsY193bGFuX2NmZy5vIHdpbGNfd2xhbi5vDQorCQkJd2lsY19oaWYubyB3aWxjX3ds
YW5fY2ZnLm8gd2lsY193bGFuLm8NCiANCiBvYmotJChDT05GSUdfV0lMQzEwMDBfU0RJTykgKz0g
d2lsYzEwMDAtc2Rpby5vDQogd2lsYzEwMDAtc2Rpby1vYmpzICs9IHdpbGNfc2Rpby5vDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL2hvc3RfaW50ZXJmYWNlLmMgYi9kcml2
ZXJzL3N0YWdpbmcvd2lsYzEwMDAvd2lsY19oaWYuYw0Kc2ltaWxhcml0eSBpbmRleCAxMDAlDQpy
ZW5hbWUgZnJvbSBkcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvaG9zdF9pbnRlcmZhY2UuYw0KcmVu
YW1lIHRvIGRyaXZlcnMvc3RhZ2luZy93aWxjMTAwMC93aWxjX2hpZi5jDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL2hvc3RfaW50ZXJmYWNlLmggYi9kcml2ZXJzL3N0YWdp
bmcvd2lsYzEwMDAvd2lsY19oaWYuaA0Kc2ltaWxhcml0eSBpbmRleCAxMDAlDQpyZW5hbWUgZnJv
bSBkcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvaG9zdF9pbnRlcmZhY2UuaA0KcmVuYW1lIHRvIGRy
aXZlcnMvc3RhZ2luZy93aWxjMTAwMC93aWxjX2hpZi5oDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9z
dGFnaW5nL3dpbGMxMDAwL3dpbGNfd2ZpX25ldGRldmljZS5oIGIvZHJpdmVycy9zdGFnaW5nL3dp
bGMxMDAwL3dpbGNfd2ZpX25ldGRldmljZS5oDQppbmRleCBlMjhjOGRlLi4xZTc0YTA4IDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dpbGMxMDAwL3dpbGNfd2ZpX25ldGRldmljZS5oDQor
KysgYi9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvd2lsY193ZmlfbmV0ZGV2aWNlLmgNCkBAIC0x
NCw3ICsxNCw3IEBADQogI2luY2x1ZGUgPGxpbnV4L2lmX2FycC5oPg0KICNpbmNsdWRlIDxsaW51
eC9ncGlvL2NvbnN1bWVyLmg+DQogDQotI2luY2x1ZGUgImhvc3RfaW50ZXJmYWNlLmgiDQorI2lu
Y2x1ZGUgIndpbGNfaGlmLmgiDQogI2luY2x1ZGUgIndpbGNfd2xhbi5oIg0KICNpbmNsdWRlICJ3
aWxjX3dsYW5fY2ZnLmgiDQogDQotLSANCjIuNy40DQoNCg==
