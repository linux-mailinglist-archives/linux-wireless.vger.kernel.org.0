Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAFBAE4D8
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2019 09:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404520AbfIJHqN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Sep 2019 03:46:13 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:6666 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbfIJHqM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Sep 2019 03:46:12 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: EY2HDGgTI7tpHJoJ7NzGC8RMehU2Eu5foxmbkpuJWRJuFrIJnJphhjz3uv0H8zbJUh+sTGTm36
 RQX0a4mDAC++vAAbQuTkzvSQGk1qKhd/BsbS0SiNoNnoHXFGjfsvT8FwO7UeJQHVrmb1B4sxnG
 FHwGBoMRcRp77LJKKKAGbVeLBiAO4VGOcOVa2As7iSvgiOsFx0XfezSoq6bqv+hrNYBKbqyAsz
 yYRzqkW8A9+m3vNTCaJveETNEYCDmcUuGkI4yA900LgWFIFxh9h7vtQuXp8swiiURr0dNFHItq
 S40=
X-IronPort-AV: E=Sophos;i="5.64,487,1559545200"; 
   d="scan'208";a="49856980"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Sep 2019 00:46:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Sep 2019 00:46:09 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 10 Sep 2019 00:46:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYPrUMk7Hki4TTVi2SWhvtFWZ3UlelO/p+xO81GAG/r67MCyZ65HxOP1Hrnt5GJA3lDqg6kOxlU02rKYdDPYUxvhlo6S6bkpLO2YRKJquWJdT9q0lWzDzyBPWuo1MzJTVP5fiK75H68jjnf/xkD5KEFNnfXf2u7DiQmT9j0qAIJp7N/DtDf9E9PhwCvdj0RabKmTcZMcXVeOVBF0IDPAWgkULUCf+BLGB4aM0GS8d3ABSObc4JxM63OOB2mYiHoaQuMULQ1cSN0LL4kVmW/ukz7gs6hJuRgxhCaewajZpbZkJ05ND5qDNhlnL4BXQQdoXLOfGW8jz2htuDmG4085Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZitsTgT7/DVZDIBDg0XpL7bClgr9eqjd4AiNqpzHhAY=;
 b=VEHpRGXxmiJVm7L2uuT/zPPEeMy4ymz1qqVUZgbWjHn6NEF8cUCTh3G7gsq/A4Jg836zrm2VcqastqAA+hEI0Q7BWhQNBQystHbYu0hEwixLVwoRxEGDGWqjquZGGX3Ghn1RxDIkyCM2eCLfoGApbsNdgE4ULdIRdTKs3MLbQPX4ljCigMQdxdo8K2SWzSMQvLBzfCFALMRp/YfV9Id11D53efFTMeIzjZEK1LY0lbwAP6eJz/PIeI3s7/MPxFfp6Qrq9qayPO89Isr7YCSgJQXAR9+jqV/u9WUWX57ekb3qySJBlaAQ/mplkWWmUVBJd4kfO9pvZxhjKxvLhkVlGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZitsTgT7/DVZDIBDg0XpL7bClgr9eqjd4AiNqpzHhAY=;
 b=RmbjdixaEly90GdYL6EQAZIQrIHaEqnCdOoP3fbM/nvS72vlpd01lxCNpf9rTYPE4gpYSKwRTAdTTwptG8VXlN5Aibi8bDzg7s9Qxn7LZkLq3es2muHA3AxsBGBnUKz++HPFpoB124k/iDffSIzpwqCym9FQx8U0cGl60n4PgAI=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1985.namprd11.prod.outlook.com (10.173.31.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Tue, 10 Sep 2019 07:46:08 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::5864:dae1:9b7e:ff83]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::5864:dae1:9b7e:ff83%4]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 07:46:08 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 2/2] staging: wilc1000: avoid twice IRQ handler execution for
 each single interrupt
Thread-Topic: [PATCH 2/2] staging: wilc1000: avoid twice IRQ handler execution
 for each single interrupt
Thread-Index: AQHVZ6vOQhEXwUqqEECS+kD89ZsUxA==
Date:   Tue, 10 Sep 2019 07:46:07 +0000
Message-ID: <20190910074514.3073-2-ajay.kathat@microchip.com>
References: <20190910074514.3073-1-ajay.kathat@microchip.com>
In-Reply-To: <20190910074514.3073-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::12) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-mailer: git-send-email 2.22.0
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [27.59.41.188]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 610f095f-60f0-4e2a-b0c1-08d735c2f0ba
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1985;
x-ms-traffictypediagnostic: BN6PR11MB1985:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB19856332958C336F0371E585E3B60@BN6PR11MB1985.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(346002)(39860400002)(189003)(199004)(3846002)(6506007)(11346002)(6486002)(25786009)(476003)(7736002)(1076003)(71190400001)(71200400001)(446003)(6116002)(2501003)(2616005)(305945005)(5660300002)(486006)(52116002)(2351001)(4744005)(2906002)(14454004)(99286004)(26005)(186003)(478600001)(256004)(14444005)(50226002)(102836004)(66946007)(66476007)(66556008)(64756008)(66446008)(5640700003)(6916009)(76176011)(81156014)(81166006)(86362001)(8676002)(8936002)(316002)(36756003)(66066001)(53936002)(107886003)(6436002)(54906003)(4326008)(386003)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1985;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jmqg+jN3T4bT5oBkI2iXZ5uAaI86cvyO5JEnasERXxMVsjDoXNUoodjrhxH9y1msLp8AJw9UwfuHchglxxuA1RJkg8guRSFi/Lx4EV4k0mSV0Qvr9smnL4l48GpeucUXfaQvgqR3jfKm+fNV7SJ8yGFVZFR+msi2ugSauipR6mS30PorIT3C4v+Lx4r4xVGqSBQykGBb194HhkH0d938RTVDKxm6DvmFzuW2Tamw0NNmLt07OA8aTo5+3Yu8CL8EX5fyR3ahUg7u5RGax9HJKU9rjUmtb+kTlsfvxHZU1F2XyowXuwaE2DsXR/RhkmwOxrRx1RfUqH6CSh8oYop6U22egaSWElbGWyvo7wAaN8+j7G0aG99cWUZWc9wCj8DFCVG4Qy+jijQOA/880FAO+yD6hgRAayCyIb6/AgQ7lDA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <305B38B0D662BF4F97BCD7AE005AB44C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 610f095f-60f0-4e2a-b0c1-08d735c2f0ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 07:46:07.8436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e1eLjeja8mgmiy4Gl0eLCzEE8y34jSpH6YDJi/82u0FD4cK4QQOltSj8OnCk3E1bLhBE8pVygPih0sDH6NkoP4xobi3aK2rjSja7PjeYtqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1985
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogQWpheSBTaW5naCA8YWpheS5rYXRoYXRAbWljcm9jaGlwLmNvbT4NCg0KVGhlIElSUSBo
YW5kbGVyKGlzcl9iaF9yb3V0aW5lKCkpIHdhcyBjYWxsZWQgdHdpY2UgZm9yIGVhY2ggaW50ZXJy
dXB0DQpmcm9tIGZpcm13YXJlLiBUaGUgZGF0YSB3YXMgcmVhZCBjb21wbGV0ZWx5IGR1cmluZyB0
aGUgZmlyc3QgY2FsbCBhbmQNCnRoZSBzZWNvbmQgY2FsbCB3YXMgZG9pbmcgbm90aGluZy4NCk5v
dyBjaGFuZ2VkIHRoZSBJUlEgZmxhZyBmcm9tIOKAmGxldmVs4oCZIHRvIOKAmGVkZ2XigJkgdHJp
Z2dlciBpLmUNCklSUUZfVFJJR0dFUl9MT1cgdG8gSVJRRl9UUklHR0VSX0ZBTExJTkcgdG8gYXZv
aWQgZXh0cmEgaW50ZXJydXB0DQp0cmlnZ2VyLg0KDQpTaWduZWQtb2ZmLWJ5OiBBamF5IFNpbmdo
IDxhamF5LmthdGhhdEBtaWNyb2NoaXAuY29tPg0KLS0tDQogZHJpdmVycy9zdGFnaW5nL3dpbGMx
MDAwL3dpbGNfbmV0ZGV2LmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAv
d2lsY19uZXRkZXYuYyBiL2RyaXZlcnMvc3RhZ2luZy93aWxjMTAwMC93aWxjX25ldGRldi5jDQpp
bmRleCBjZDExYzM1YWRjZmUuLjUwOGFjYjhiYjA4OSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc3Rh
Z2luZy93aWxjMTAwMC93aWxjX25ldGRldi5jDQorKysgYi9kcml2ZXJzL3N0YWdpbmcvd2lsYzEw
MDAvd2lsY19uZXRkZXYuYw0KQEAgLTYwLDcgKzYwLDcgQEAgc3RhdGljIGludCBpbml0X2lycShz
dHJ1Y3QgbmV0X2RldmljZSAqZGV2KQ0KIA0KIAlyZXQgPSByZXF1ZXN0X3RocmVhZGVkX2lycSh3
bC0+ZGV2X2lycV9udW0sIGlzcl91aF9yb3V0aW5lLA0KIAkJCQkgICBpc3JfYmhfcm91dGluZSwN
Ci0JCQkJICAgSVJRRl9UUklHR0VSX0xPVyB8IElSUUZfT05FU0hPVCwNCisJCQkJICAgSVJRRl9U
UklHR0VSX0ZBTExJTkcgfCBJUlFGX09ORVNIT1QsDQogCQkJCSAgICJXSUxDX0lSUSIsIGRldik7
DQogCWlmIChyZXQgPCAwKQ0KIAkJbmV0ZGV2X2VycihkZXYsICJGYWlsZWQgdG8gcmVxdWVzdCBJ
UlFcbiIpOw0KLS0gDQoyLjIyLjANCg0K
