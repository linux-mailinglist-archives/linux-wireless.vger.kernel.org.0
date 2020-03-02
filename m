Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5643A17602E
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2020 17:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgCBQl3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Mar 2020 11:41:29 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:48831 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgCBQl2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Mar 2020 11:41:28 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: kYz0JriBI6+MeLZNK9L3z2hBGZ4NcVqkGraQaP4yKum8ZPuRbouHd0drnXUBgu/sDDPNT1HH29
 Y4hdQns4uiGhtA9bMiU1+xmvXlJ3bQ5jZUaxuLbSOr0qMYZL8Rvj+XTIZkXXceQ2TjRd6fHYQc
 fzeNefPjaXc4FtDzNDjWe+ZdnyeHy2hIamtYVMhWLehfbSrYbtdA0U26QMGmf+CCPl4/mKMjCw
 qp77l1Uqkvz8sjIhkuVnETZgrquzyUrQbxn5ghQEx9wtoTIzMUENRju4aPxv8QuYzqqKEYpxn9
 U+Q=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="4187796"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 09:41:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 09:41:27 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 2 Mar 2020 09:41:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idiOsq8oDXT1yivvxKqjM4VSkxBiy/m63IfcuFzq4iHoLHfxdZJ5m2cbWb08VqLniH6uwbzVmWfeKTE65L2W0Zql42t/leZuZAHsTBXwX931/GUNYT4OEIRLPRh0mGm9zm/iZc3+02xbEmXywndltj3o3wc1LeMHh/qGzIdtnMbFFTNDfN5I6KSpQFEO49UDAr95y4Hq3M3OtsKDZplBq/HvvRFlQyCppSc5XgUsIoYoYw1JkyN/4jIavomouADMHMazarwQepVc/e96qce3NG5DQn/z6Ai7LDXq01bc+B9LJG9kf+/JtIKMi8Gci6vGamBUnQCBnM2ixFH0UmE/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2Cd5Uw3gFwO4QY96RH+l0lPsbamxj24yyHiW12Ztvo=;
 b=UDJYOR0CYNLmLwAHQ26JZgmvTUNmCd+nMnifJvkLjlmUL/CpDua55ClQeOJZcLYnFUKXmQPaW5cwfu5teXL9qrx4gwo2qafmhamYupY5HHzIAtqVV3Zr8/g9A5tqd1RpdOc3th3E7RLzhh3HqaAOUa6x9dVH8vF/80KmrJAUexTwmBYrdwxfzkVHzXFdX3jupdM5lkKOoGKAX3DfxT9e79AiyFd08S/daT3VNqDeaafIXBG2XkHma44LDxSR6kxCyuZlwjaF6A5m5+p/WRkRA/36aCI5ipoZlFT1Y1CYdGL95hxJ7cI3Z7PFRP0WRn9lo0myQ5bcIyoDpSRFsfTRiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2Cd5Uw3gFwO4QY96RH+l0lPsbamxj24yyHiW12Ztvo=;
 b=q6sWDDd/NmGIUeMuerkjwmfY1LdKPJE/i4IKjjtuxtbJEP60XRAQpzFd7l6gAql5J90t+VNBabS8b3WrHcvi2dp+zw2oqZ2xb2ZC7bjXWvSYAxPO8Lu/5p4udeCUQYfHpLctEZ98vNqTj1q3c+BeC5+R5YoqcC6U6Jxr3r3BRjw=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB2018.namprd11.prod.outlook.com (2603:10b6:404:4a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 16:31:05 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:31:05 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <dan.carpenter@oracle.com>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <Venkateswara.Kaja@microchip.com>, <gregkh@linuxfoundation.org>,
        <linux-wireless@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>
Subject: Re: [PATCH v3 00/18] wilc1000: move out of staging
Thread-Topic: [PATCH v3 00/18] wilc1000: move out of staging
Thread-Index: AQHV667y+zVJzO3Rq0qfZ397NNWe/ag1ES4AgAB3VAA=
Date:   Mon, 2 Mar 2020 16:31:04 +0000
Message-ID: <46e42e91-bd9b-dc3c-49d6-1ebe762b2814@microchip.com>
References: <20200225074105.7740-1-ajay.kathat@microchip.com>
 <20200302092346.GA24308@kadam>
In-Reply-To: <20200302092346.GA24308@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 263ca700-26c7-454b-1eb2-08d7bec71aaf
x-ms-traffictypediagnostic: BN6PR11MB2018:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB20189D67A8B78D53F785E2FDE3E70@BN6PR11MB2018.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(366004)(39860400002)(136003)(189003)(199004)(71200400001)(4326008)(5660300002)(91956017)(86362001)(36756003)(76116006)(66946007)(64756008)(478600001)(66476007)(66556008)(8676002)(316002)(66446008)(81156014)(81166006)(31696002)(6916009)(54906003)(6512007)(2906002)(2616005)(6506007)(31686004)(26005)(6486002)(4744005)(186003)(53546011)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB2018;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QwmU9B7UCbklR6fGdicI18R3RAphP8ZgAQ+ZSmzRnw015xOAi7ys6PcjH3iNP0J0tkLKHft3K6ygqxEQnMpbQheCkAg5E5JHRW/RamDWKaoQWUNUf9Ct9vmFNWSJD3Im4B1jSqH2by9tAIMgd83kedudqCMF+hV9/+fO4rDdjLufvf6dWacbuQ9cVJ6zLG09UC5K1V5rQ9igs8FCoT2A9pfy+Grxf5kfFm+QLX2OiqezuGspGzJQvfWAd4xhkayrz6EtsGAlWOY2wNeii/nXkGtIN62FiZXjzTuJInEqyIxGfg1LVOuO+Q5CMsZU9h4NNNIqSyo5x4f1QXBwP+CgwZXQFrhf0YYbKXPJQWLm/FH10mYPn3jKE8w7rZKUiqpOIkUEMOJYVMrVoo6z2ccjfHy++92p9vl+ow7BV9N1c/qPrU7IiKI8yA8IVGK+fJ4m
x-ms-exchange-antispam-messagedata: GRckWMsHyOxZeep+6cqXNzNBBT3T8361YNQaRNWoxyUMm0K2v3o1oVywyPIeqScPhaux3sWVv+Qt+hjesZlBaeDfeGdsGMb8CwIazcCZrnQfhaglqYZWg52sAkHqAgI4kecP3w1L24P6yqJgo48Rqg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBBD8FFE0F223F46A64AF455F059B82F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 263ca700-26c7-454b-1eb2-08d7bec71aaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 16:31:04.9439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e6U6AgNwpnaWM331rAgqloS0xAdLMENZvhSaH+eAAkItsHOf3i/DUkYS08up2M25/+Y3s2ev31P18y0Voi0B0IJaTcdntTLtVZQ8KZ5PfZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2018
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgRGFuLA0KDQoNCk9uIDAyLzAzLzIwIDI6NTMgcG0sIERhbiBDYXJwZW50ZXIgd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVGhlcmUgYXJlIGEgZmV3
IHN0YXRpYyBjaGVja2VyIHdhcm5pbmdzIGZyb20gRnJpZGF5J3MgbGludXgtbmV4dC4gIE9ubHkN
Cj4gdGhlIGZpcnN0IG9uZSBpcyBpbXBvcnRhbnQuICAoTm90IGFsbCB0aGVzZSBTbWF0Y2ggd2Fy
bmluZ3MgaGF2ZSBiZWVuDQo+IHB1Ymxpc2hlZCkuDQoNClRoYW5rcy4gSSBoYXZlIHN1Ym1pdHRl
ZCBhIHBhdGNoIHNlcmllcyB0byBhZGRyZXNzIFNtYXRjaCBzdGF0aWMgY2hlY2tlcg0Kd2Fybmlu
Z3MgaW4gc3RhZ2luZyBtbC4gSSB3aWxsIHNlbmQgdjQgZm9yIHRoaXMgc2VyaWVzIGJ5IGluY2x1
ZGluZw0KdGhvc2UgY2hhbmdlcy4NCg0KUmVnYXJkcw0KQWpheQ==
