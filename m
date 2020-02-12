Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECD4D15A430
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2020 10:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgBLJEK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Feb 2020 04:04:10 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:20778 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbgBLJEK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Feb 2020 04:04:10 -0500
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
IronPort-SDR: zWwK8CpJNTU35WPmT1l71V0mavI7ABmHs7NuS+cTcHnrCOpbqMdZBHe8EBI2jhG0VazTv/FaEF
 9l158qf49kPe1NMfAJ/Q+H46AoDZDR7mmy0fOBvxbZUq6rvFkw7flKwhjWsdV+2uUYdoVA9FvC
 /FNrc7QhbZkcSDOa0fUl9H9et3+4FAVMvk0LJBBKv9+sHLWfjCPt78m/Q4vfcj+VcVH/yx9C6a
 pE05oQ6HYoHxEaXYxuGUf6A6OO0lDwdd8HceHw7vLlC5kvnf/0PtvBmrdSJaH0G9dPZUP90GrE
 sGE=
X-IronPort-AV: E=Sophos;i="5.70,428,1574146800"; 
   d="scan'208";a="65630158"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Feb 2020 02:04:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 12 Feb 2020 02:04:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 12 Feb 2020 02:04:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEHegHh7NKbCsZWUasnahDKB6VtbZhWcuKVbF0OUzeiO1mUOA1Zvo71xtq8RjjXw7fGQExP9W/8bONK57qPvY9MOeOs+8XkKXAfPsfXM2hMV/PifjH5kIaS6O34vL1WSMKlBFuopyvCpgkknXML2mUYURQ1zevet0iJM8iEY3SrCwPnyKs8J5+gTL7GBLvuppm0N+mvwrMY6o2JpLAF4kw3l/O6aK7ymNXnGNcJMO0nzOV4Rv8FHOR7934O40wOkENWgMbqdus2/FkNCAIUrhjXMTbednUFqk5FusDzccbTjm4PqrLQlpU3ikywSP2LN5jyCQcG4VZ//qRi876dEgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45OgJvYe5NDOVXkCYpenmlJtxwp2tdgpaWGZpL97p6g=;
 b=gzPZ1TAe/e6beQl4UseawPazaQH8+UCevs74yshh5E3RGa7UoQeFkYkDIIFvGBBbedYx8EUBTbYTmrzaD/jGx4havJ5tsvCttCi+r8gLVKWDetPQnloGQjMJZsbmOvLVEmG3ZddB1j1ScRKAgjvi1WXUyEyBiN4lc+oBZcd91sZgIvRz3p4o6jzLGOx45zr1bF63JlbZoERHmMa7q+mZte4QEZ+xGtnCc5Ls/XfF5G3V3e6kxplDbZMbJPfqx+EqEYWydNhNAVwVK7AExkkrcts3v1wsTm3HCx2432xllqZUR8sfXsG0AqRx1M7yljEne83vfD7vcA4tOUkcr+O4PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45OgJvYe5NDOVXkCYpenmlJtxwp2tdgpaWGZpL97p6g=;
 b=hnWfPCzpBuQaVeK6vMKFUxO54tPBCKn/D7g5rn/OfC47E2hN6EemhwGgMFhZCZupPbA6egS+mdDiKsRUwehKqX3drwh5JZdVg84Nx36F0nz6oYlFOc1SP2Dqq0VlRpEqNlImVpW+z71JMLAx5+4FfHKp8HLklCsQF0D2wBbjDck=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1971.namprd11.prod.outlook.com (10.175.97.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.28; Wed, 12 Feb 2020 09:04:05 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2729.021; Wed, 12 Feb 2020
 09:04:05 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <johannes@sipsolutions.net>, <Adham.Abozaeid@microchip.com>
Subject: Re: [PATCH v2 3/3] staging: wilc1000: refactor p2p action frames
 handling API's
Thread-Topic: [PATCH v2 3/3] staging: wilc1000: refactor p2p action frames
 handling API's
Thread-Index: AQHV4MGgpY9wAVPMCES4mYM6Bflaa6gWXqyAgAFDDIA=
Date:   Wed, 12 Feb 2020 09:04:05 +0000
Message-ID: <6f33e47b-2eb1-b25c-49c4-a711c1c067fa@microchip.com>
References: <20200211152802.6096-1-ajay.kathat@microchip.com>
 <20200211152802.6096-3-ajay.kathat@microchip.com>
 <20200211191851.GA1959566@kroah.com>
In-Reply-To: <20200211191851.GA1959566@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4014ce76-f96e-4e4b-4d0f-08d7af9a830f
x-ms-traffictypediagnostic: BN6PR11MB1971:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB197105C1A29204A4709A535AE31B0@BN6PR11MB1971.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39860400002)(376002)(136003)(189003)(199004)(6916009)(71200400001)(66476007)(76116006)(66446008)(64756008)(5660300002)(107886003)(66556008)(91956017)(66946007)(31686004)(186003)(53546011)(4744005)(6506007)(26005)(6512007)(316002)(31696002)(8676002)(54906003)(2616005)(6486002)(81156014)(81166006)(36756003)(4326008)(478600001)(86362001)(8936002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1971;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Edr8Y6nXBYwpSvqNrNxVeTASKMb6TbuWcn4lCaVTZOqQXErDjaUV1alH+iHgWupIPYmWZcAymq6LC/4tkK2BrHXwA3xW3T/95zhgkfvBlp396HlxdDWEZqW4NBRuw2sLEfBlzPbWvYNrPEm+bxA1VKuZmlQz42We9lX/m/d2B80JrMYld6yk2t/PG4ZmUDCkzUn5UF1HMZdNSlBsvE0Up1pueSXHwOhWbHA7LEDonRXdFcAdLX39OGixVs7Ky6P9+k0bJlUH50etskVpUfdik+TkC1cnPx3ckV+HQmkM+iIc0XQRXzqNHLpkNWfY8wQJ2ymBT+IY/AqOOqBrfK20Fwm93IgOGHkEFUP+f4If+zTUl9H3S9g2B7Qu4U2IvthTZaWv6vVQ7R0WDijrCiYotqc2DxAwNtym9kq/wSxdhB+EwgUur+Sh/McHX7JTbOey
x-ms-exchange-antispam-messagedata: KCVubUW3R9zGYkyttG5j7uyION2wnNbSfszh31SMQ2VwGQoWTCrvrEFd0OSQxm7SJAXJhPatv56nF42FhJJAv397oxUaVehTktrEDS0nmHL9yESy1shS5+F/f0XaFbJtsEZ1V79tI4qBARVHfyeGLA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F5AD3081F61104B8392EF0ECE718108@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4014ce76-f96e-4e4b-4d0f-08d7af9a830f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 09:04:05.3597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MEXMLPcFUAmHsMFgrEryI9szjIxwwgOl/oPu3QuOPnwnM58rI3WKIVa9VZ3cGXzhdB7rhWFz8tTlB/p09f78EJB2TDMHzdFPxyge/iOUIDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1971
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgR3JlZywNCg0KT24gMTIvMDIvMjAgMTI6NDggYW0sIEdyZWcgS0ggd3JvdGU6DQo+IEVYVEVS
TkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gVHVlLCBGZWIgMTEsIDIwMjAg
YXQgMDk6NTc6MTBBTSArMDAwMCwgQWpheS5LYXRoYXRAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+
IEZyb206IEFqYXkgU2luZ2ggPGFqYXkua2F0aGF0QG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gUmVm
YWN0b3IgaGFuZGxpbmcgb2YgUDJQIHNwZWNpZmljIGFjdGlvbiBmcmFtZXMuIE1ha2UgdXNlIG9m
ICdzdHJ1Y3QnIHRvDQo+PiBoYW5kbGUgdGhlIFAyUCBmcmFtZXMgaW5zdGVhZCBvZiBtYW5pcHVs
YXRpbmcgdXNpbmcgJ2J1ZicgcG9pbnRlci4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBamF5IFNp
bmdoIDxhamF5LmthdGhhdEBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgdjI6IGNvcnJlY3Rl
ZCAnd2hpbGUnIGNvbmRpdGlvbiBieSBhZGRpbmcgJ3N0cnVjdCcgc2l6ZSBhcyBzdWdnZXN0ZWQg
YnkgRGFuLg0KPiANCj4gVGhpcyBwYXRjaCBkb2Vzbid0IGFwcGx5IHRvIG15IHRyZWUgOigNCj4g
DQoNCk9rLiBQbGVhc2UgaWdub3JlIHRoaXMgcGF0Y2guIEkgd2lsbCByZWJhc2UgYW5kIHNlbmQg
dGhpcyBwYXRjaCBhZ2Fpbi4NCg0KUmVnYXJkcywNCkFqYXk=
