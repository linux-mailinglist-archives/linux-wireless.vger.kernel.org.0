Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB988DB2FB
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2019 19:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440565AbfJQRGi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Oct 2019 13:06:38 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:8611 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436550AbfJQRGh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Oct 2019 13:06:37 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: bWT1oZVSuJDreiuEYvMXWANIHPkPQYdFhwZRGPJg/3NwSF1h1EcrTa9Exl2KurzHy8Hk2TGjbT
 8ZsYGO3YMEhjnwuhE1Ckq6ygDF4tEZfELnQkDJGXuQR4vdxs1JQWV11fxdh9kUW54K54G7cj0E
 UljDOtsFmImLZXZY4QTaegVs3wkz7p0HtM9pBoGWZEvx+ezBDgxzO3J/n3CkhDq5vws6Mxz8db
 cMmkjAUeAeEL2Dvue8/n+DMnVuUhkG3DPxLIZjn4IlZsAq9tUT2+k7ycX/iwxSG/VgCPybN8r0
 tPo=
X-IronPort-AV: E=Sophos;i="5.67,308,1566889200"; 
   d="scan'208";a="53112050"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Oct 2019 10:06:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Oct 2019 10:06:36 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 17 Oct 2019 10:06:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8r3NHRGSeE7QeWdmuar33q+mm31SfOHEGTGqPBRErYpCB0D75N4qq4m0FbrRNEgUu3Sg12Nc+TFMFCWC67ClfWNdNGNQVEaceQHi4UDVTl/i7bt6/AI+QkHZNtXcoC9Gp85bTF7jjeSp9078icPPMkEkWjm1qOBvvGYREsE3U49bdv6yKOoMyDPTj4VJW2UFwNMTkbjYw8f1uHjoXDFmbIetlYPKrcLULFuCzpNCH20dmVqFYq51KXm2XGiwUEl/hg7qx+5D+nGI4dgwmjiVlneHRMrK9n4AwiKiugGqExG2DNtk4zA9yLGFtUkslPXwfLFDIQy9U0LKDT71eHlIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDwYBtKxH1XG+Vjf4A4tAo4GymfAfBlFaGIqBWuV+Mc=;
 b=GAsvysTVVQhn1OEN2vIDvcExFkqhSGxRf4zAmDTwAYSL74jwvmOmp16dupFDQsn3zhcPFSIl+4KfY0yuqFdOD1CQhHJ4vex57iZsQijENKkR3GrvScUG9Kj3lxtknAo4IRj5eT1Ldqa2RP2ZpZKhRA6P/J1VBTp2/M6vRtcdNOzTkLApAlfi7v5VHYyGm2f77h+wrsUNuXcLmkcNEF38E8jVAYccG0ofcevRmhiP4co3aWtz1LE/oyJdGl+fm6J+fMUbacuuyPVQsey1hU3h8QQgfTtqAWHmMt2EflWWO/H7z3XEMpr1eRxNyJf6P/Frfr3uMf6bYqimAkaOoxqWfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDwYBtKxH1XG+Vjf4A4tAo4GymfAfBlFaGIqBWuV+Mc=;
 b=JNx3WGJqXFYqlw0sPpeXIQ9b0mdY2l6O8V57wENVeAhtIFaIi5sETe6jpMMjygAk/V9S0sWr5NzdwoCkzTJ1daB4cDW1KXcJL+44/6/vTe+HAPgAWk9iKX4NanYbKI/vxzWbHzwN/0p0JFK2mUk/ZWLbZDqZkH7ytGDhuWVItcI=
Received: from MWHPR11MB1373.namprd11.prod.outlook.com (10.169.234.141) by
 MWHPR11MB1453.namprd11.prod.outlook.com (10.172.54.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Thu, 17 Oct 2019 17:06:32 +0000
Received: from MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::c518:fad3:68fe:ce20]) by MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::c518:fad3:68fe:ce20%12]) with mapi id 15.20.2347.024; Thu, 17 Oct
 2019 17:06:32 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <dan.carpenter@oracle.com>
CC:     <Ajay.Kathat@microchip.com>, <gregkh@linuxfoundation.org>,
        <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] staging: wilc1000: potential corruption in
 wilc_parse_join_bss_param()
Thread-Topic: [PATCH] staging: wilc1000: potential corruption in
 wilc_parse_join_bss_param()
Thread-Index: AQHVhMwS9hB5KMK9e0muJstOe8jjSadfEMIA
Date:   Thu, 17 Oct 2019 17:06:32 +0000
Message-ID: <79ba46e7-9349-04fa-40f7-5367672b8189@microchip.com>
References: <20191017091832.GB31278@mwanda>
In-Reply-To: <20191017091832.GB31278@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.175.253.81]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
x-clientproxiedby: BY5PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::21) To MWHPR11MB1373.namprd11.prod.outlook.com
 (2603:10b6:300:25::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbe955bb-bcb3-47d0-84f7-08d753245bcb
x-ms-traffictypediagnostic: MWHPR11MB1453:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1453CD8D0791E10E9F33371E8D6D0@MWHPR11MB1453.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(396003)(136003)(366004)(189003)(199004)(66556008)(66446008)(86362001)(11346002)(8676002)(6916009)(36756003)(64756008)(66476007)(66946007)(31696002)(316002)(81166006)(81156014)(58126008)(8936002)(476003)(2616005)(446003)(5660300002)(4744005)(66066001)(65956001)(65806001)(7736002)(2906002)(305945005)(76176011)(53546011)(386003)(31686004)(6436002)(6506007)(99286004)(3846002)(54906003)(6512007)(256004)(25786009)(478600001)(6246003)(4326008)(14454004)(26005)(186003)(71200400001)(71190400001)(102836004)(486006)(229853002)(6486002)(6116002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1453;H:MWHPR11MB1373.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sxbiiX/rQXccK3+HrXMvsA8Mpi7eG369wrN+X82I0mxCiGXz0NKTLz7Pqty78dMhtmGpQzyxFT99rWauKNqqVQYWBy61kKUys/BpyVnedniNDThZFzu/+gIh8hEOkReB96zP3vMKBkkcIaV1nVOpBDkhQKfk9z/b0nRtvr1Sr2TX4E0gkFHrwosWTLfWklrGR5IPDpvXXLY38Tvrr0EckA3GDJfapoR9nNbikww4oU1t8A6TGOaSVFCMHoNaAaJKwpoT1+7hKR7l4YMKnMqajBLgMID3LyFQ084G2u4VyJIWsP0H336ud4Zj09uGZcvERV156HqtwLuooKZGLTL00BX1S8foqLvYkemIoqbdzLCXFpC8TG7f+NsShKPJLZgiuI2MeCIfDD8v7n/5rAXCzD7FZC8VYWJNZdS71x/GlA4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8A346C01027D945B80B5E28E3E7AA37@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe955bb-bcb3-47d0-84f7-08d753245bcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 17:06:32.2635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lo0pfXn7/Ofpv3LhCVernmotsuq9pyaORLcScEP2m7id4jUhDO1kaFlVAXv8uXe61/UMoE4yDDb/hpqNsHb3UeFe9FiRgVHA8B3Z1Wfoock=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1453
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCk9uIDEwLzE3LzE5IDI6MTggQU0sIERhbiBDYXJwZW50ZXIgd3JvdGU6DQo+IFRoZSAicmF0
ZXNfbGVuIiB2YWx1ZSBuZWVkcyB0byBiZSBjYXBwZWQgc28gdGhhdCB0aGUgbWVtY3B5KCkgZG9l
c24ndA0KPiBjb3B5IGJleW9uZCB0aGUgZW5kIG9mIHRoZSBhcnJheS4NCj4NCj4gRml4ZXM6IGM1
Yzc3YmExOGVhNiAoInN0YWdpbmc6IHdpbGMxMDAwOiBBZGQgU0RJTy9TUEkgODAyLjExIGRyaXZl
ciIpDQo+IFNpZ25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xl
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3N0YWdpbmcvd2lsYzEwMDAvd2lsY19oaWYuYyB8IDIg
KysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KUmV2aWV3ZWQtYnk6IEFk
aGFtIEFib3phZWlkIDxhZGhhbS5hYm96YWVpZEBtaWNyb2NoaXAuY29tPg0KDQpUaGFua3MgRGFu
IGZvciB0aGUgcGF0Y2guDQoNCg0K
