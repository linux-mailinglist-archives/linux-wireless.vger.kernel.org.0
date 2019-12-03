Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2F51104C7
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2019 20:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfLCTK3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Dec 2019 14:10:29 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:52039 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfLCTK3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Dec 2019 14:10:29 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Uq7ajqWOGUHPrAQ7M/qjHIfsdUzTFtZWbKl71e4GEfPi1Rt0egxS1ynmC/5avaTC4H+sEK177q
 q3G/s38VUHM2jxNL9FiEduYf3fb+Pp4K/lv0Po3wPYG6KNdofdH4SMKrsMYbG1zp341RaLHdFm
 h7YzEkmDhHbbgJgJsTWuTXCV/xeN4um3CUZNnwW/cbgZ+VC7/du8Zf494ipN5RjmxmY8nqQrjm
 xaHSXEot8fMMn7C5fdpFz1MOOuJF8afQxBNB/nzYpjZzgWZY3kplWcq8c+OzmWKDoPMo1OVeKx
 b9c=
X-IronPort-AV: E=Sophos;i="5.69,274,1571727600"; 
   d="scan'208";a="60491022"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Dec 2019 12:10:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 3 Dec 2019 12:10:28 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 3 Dec 2019 12:10:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6XbFXipzz5L4SPibi1Dlwu1035BnlcXuuFOCsMcOSt0+M81794i/nJl0WlxxxO76PES4dvb9EwZLgxaRqhJaSrV/0uFS8vatvpqlJNC7wpV9YwTR7jaKTBZXnvfN6NnaW9ETpA+bmrv3LBZeljAefZDk7r8rxiF8SuinZMIxTajw1wHYINYRPQLHEbsZIf0qr8d/rIQa0YyKy656gM2FeoFk0waJAekeHM/qykz6JPFpEDhy91M5T+imvwqOGwEqc7mt6Cas1tgMP/A6AaNxaf5tBfqqkTp1hdabxTxYPr6JFuM9TQuBeZuRtDE7sdZec4WSxPbCElDP4bSNaFtCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeNXihDk0ESQajAswJovugxWKDNQruoJ+qaGUe1OO7Q=;
 b=DRCET6Se2iAlxLBz7TK5CchQczpAbnT/1NJTPlqRfmLtpK8aMKrG9xBv2idvPLLq5afWKeUGwOhiW85/NhrRPhtfX/4vw+umEwpnQh1qw5EzB0XkUBSq7g5PtcA4oGkKeIB/eA5WfbJs/qtYEspgROd5tYp/5+ELM2SzDakeQtj6R3CcOmgNytNfsrWo28KJ4Xguu280TcMuIUsbxJwbH6sZ+lQPPfc9F4JTHT0VRIhOm++MLW/HpLxe8TLxWgGhezQl5Lr2t1EaMQV6huLihWEzV2ZPMRhYXTxCqhpVd2/lCwRNb47ADi5FWNeUG/uKDOHFK9MFQ1mq1S8d7+7hSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeNXihDk0ESQajAswJovugxWKDNQruoJ+qaGUe1OO7Q=;
 b=H/6oOf6OBZMXlR9uKfiLJCtQtneu8kEBEAeS452pyQRjQ3GV2tMVAiTLWuoU+uD8KZ+WkDSYqChbkH6t5b/TvFfGjfMGuXtjxpCGRTUzq7RzoU2ENWbIM0YoAk/FCP+vBtHvhz0E4F6/dPVODLH+4tpwSul9GyMGhK8sTmQy6lQ=
Received: from BY5PR11MB4306.namprd11.prod.outlook.com (52.132.252.145) by
 BY5PR11MB4497.namprd11.prod.outlook.com (52.132.255.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Tue, 3 Dec 2019 19:10:26 +0000
Received: from BY5PR11MB4306.namprd11.prod.outlook.com
 ([fe80::4e9:cd32:b915:5a4d]) by BY5PR11MB4306.namprd11.prod.outlook.com
 ([fe80::4e9:cd32:b915:5a4d%7]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 19:10:26 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <julian.calaby@gmail.com>
CC:     <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: Re: [PATCH 1/4] staging: wilc1000: use runtime configuration for sdio
 oob interrupt
Thread-Topic: [PATCH 1/4] staging: wilc1000: use runtime configuration for
 sdio oob interrupt
Thread-Index: AQHVoXawsACklCtDcEijfkbhUigNzqebogeAgA01q4A=
Date:   Tue, 3 Dec 2019 19:10:26 +0000
Message-ID: <a174f958-ddda-b57f-060b-ca4ed7c36ea1@microchip.com>
References: <20191122205153.30723-1-adham.abozaeid@microchip.com>
 <CAGRGNgV=zW8xpgHfj99m9LHN=dtUBH_36_kQSnnBOrd_6WpDoA@mail.gmail.com>
In-Reply-To: <CAGRGNgV=zW8xpgHfj99m9LHN=dtUBH_36_kQSnnBOrd_6WpDoA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.175.253.81]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
x-clientproxiedby: BYAPR08CA0070.namprd08.prod.outlook.com
 (2603:10b6:a03:117::47) To BY5PR11MB4306.namprd11.prod.outlook.com
 (2603:10b6:a03:1bb::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e88e6073-2900-4277-e92d-08d77824742b
x-ms-traffictypediagnostic: BY5PR11MB4497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4497CBA1BEF6E93CACDCB6B98D420@BY5PR11MB4497.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(136003)(396003)(366004)(189003)(199004)(58126008)(386003)(25786009)(6506007)(256004)(14444005)(6916009)(53546011)(102836004)(4326008)(6436002)(186003)(305945005)(6512007)(107886003)(7736002)(4744005)(86362001)(6246003)(52116002)(76176011)(71200400001)(71190400001)(99286004)(316002)(31686004)(54906003)(26005)(3846002)(65956001)(66946007)(36756003)(2616005)(66556008)(64756008)(66476007)(81166006)(478600001)(81156014)(14454004)(11346002)(229853002)(66446008)(2906002)(8676002)(5660300002)(8936002)(446003)(6486002)(6116002)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR11MB4497;H:BY5PR11MB4306.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O8klBpqk4XK6UuucnJbShDTCEqSLpSFqM5P9Qzelf516GpB367wEyt/3kNo5O87Kv9TfBQTqu7wv05oRGVrsYjvKqz8QY+D+372+3m20l6s44ue+Y2TvtD/dy8Q9pFjc+hTVCU7LJLMHqY/o8urnAfCaY19M9dglF4M6XAUppUN01ab/8s5g8CtNNrt+t2kt5ekzHnml0SJ73IPlKmf5DzlluTG6mVHhaytzx7GOs1yXBRv0I8sHMWt8kVaSD+R9jSD1WeDCgo1EVBPCNpR4GGK07Ev2KRnuiC2DLA7jknKG0GW5VPHNUiMHFLsNQc6i3xSKWOxjRa1MNHQ2OD45XB9vZv4EXWKY1Ir1Vdo5v86Vk4KTwIaZbpYEQyTEUEGx7P8qJjSYja2d5Is0jQAJD70re5BoTZWIzWJUK1VBNZ/kFckGVB8cofzIyszExb9m
Content-Type: text/plain; charset="utf-8"
Content-ID: <6575A14B6BF4784FA711A7C64B3D1811@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e88e6073-2900-4277-e92d-08d77824742b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 19:10:26.2103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ufVTz2Qnl3T0rcGVkCrqqm7Aufz+JHF0Xk6dRal6Eqryl+rTgxnrj4Uymbw4m/JhdexBh2/gQfFghhB9nk7i/Cz9dV1/oG+CPyyrvcyxO7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4497
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCk9uIDExLzI1LzE5IDI6MjYgQU0sIEp1bGlhbiBDYWxhYnkgd3JvdGU6DQo+IEhpIEFkaGFt
LA0KPg0KPiBUaGUgT09CIGludGVycnVwdCBpcyBhIEdQSU8gYW5kIHRoaXMgaXMgYW4gU0RJTyBj
YXJkLCBzbyB3aHkgbm90IGp1c3QNCj4gc2V0IHRoZSByZWxldmFudCBwaW4gaW4gdGhlIGRldmlj
ZXRyZWUgYW5kIGRldGVjdCBpdCBiYXNlZCBvbiB0aGF0Pw0KPg0KPiBJJ20gcHJldHR5IHN1cmUg
dGhhdCB0aGUgQnJvYWRjb20gZm1hYyBkcml2ZXIgZG9lcyBzb21ldGhpbmcgbGlrZSB0aGlzLg0K
VGhhbmtzIEp1bGlhbiBhbmQgRGFuIGZvciB5b3VyIGZlZWRiYWNrLiBXZSB3aWxsIGdvIHRocm91
Z2ggdGhlIGZtYWMgZHJpdmVyIHRvIHNlZSBob3cgdG8gaW1wcm92ZSBPT0Igc2VsZWN0aW9uIGJh
c2VkIG9uIHRoYXQsIGFuZCBzZW5kIHYyIG9mIHRoaXMgcGF0Y2guDQpHcmVnLCB3aWxsIGl0IGJl
IHBvc3NpYmxlIHRvIGlnbm9yZSB0aGlzIHBhdGNoIGZvciBub3cgYW5kIG1lcmdlIHRoZSByZXN0
IG9mIHRoZSBwYXRjaCBzZXJpZXM/DQoNClRoYW5rcywNCkFkaGFtDQo=
