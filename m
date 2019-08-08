Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD6E86882
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2019 20:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbfHHSOy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Aug 2019 14:14:54 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:39041 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfHHSOx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Aug 2019 14:14:53 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: ArV0K85sVhSbvo5h4pJaoOW6TcMXfhNWPmBCzXRDV19zUJcRZZBCI7dsR8VBvSNyfUJ5yKFRnT
 GxxU/ZtsjgcEWvnP/7b63aAlNh7z5A+9cc4nkPjTwOWU7HfvepYBl0GllZcP/7e7CLE1kipOdd
 nUGU5jUhY5RTwgbLGOwArYwAZHZVMfi3Qj+CKXPPP9mATO/kNjrEY7KPMQlKUWhuhCfOkJ8iWz
 VCY3q4CWa5gKBWNn+ZGxtaQK26XnANCdpRWoK8eCmulDxU/IGJnhN/ESeZfX7Z9AsxU92DNFos
 Z2A=
X-IronPort-AV: E=Sophos;i="5.64,362,1559545200"; 
   d="scan'208";a="44493260"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Aug 2019 11:14:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 8 Aug 2019 11:14:52 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 8 Aug 2019 11:14:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLVYcS7nIdAOD07ykOZwb03tSZzPAnA9puo7VM+1LaG0cu3A9p3BIXT1NIZN7T4COnuBphPSfjjSrJ7EHvU30EwZg6v7uFr4H9IVMmwve6bdog5R/jIJ9yT0Y0DXzThDnxzJMiif+eMikEy/XE7girii8kCZfLeqEMeLh3lxYL2b0xZJRMk2Y1UgyXKuQr9ljl7/+DdwnaCDihz5rxeZWghyMsllOADvTuHECa7UDLOKuxzkaOxp42kNgC46wR/YYwZ5DyK0ZiXslYJK3UadcM03QyNHQcQ47/E/ezMUuCVa4GolyE6ZtR5GQRm/q6cThGT6lpx+WMkhkqUZH5lBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2I6jku4RCoF5/L07f3MhyjizfBsfgSJyG6l7BDX5xs=;
 b=eIJdVYX845c2ZMKmEcnizl5PnmZ3T4LdbIwMbyRB7x8uN9YKlJ0s9N00UXKSk/r/CwgpwQEzrkUVjkgA91ndXS2h2j962CNAHX0H1ILDLY2bfC1hRiETaIHHTJtgoF7oiL4IYHJbNuYTTje6ME2UPxeEJjwqCAhpSWJ4wtq1qGv66j6XJPTThNWXySa6RRHeEqpm1I/jIxyjs1/wfF9WSnS2cRQkE2rn6Jsf82HaJRiDTPDugekSUHffxQ+u9PNFjBJmZFblD2HIRYppnQyjW4VW9IKHsnqlkCCh8z8xTQZbEmY1IaL5glGu7a5WjVHx8SJTmkDxydPSIkme/CV0ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2I6jku4RCoF5/L07f3MhyjizfBsfgSJyG6l7BDX5xs=;
 b=FkLS2b+sJ/82a3tJuOayF76oc3LTLD+dq6pleHxndYBxmaa1VUR3gq49B9etmJvvoOC8fIZWYqEesHFpTWfIZRCqYFhR1rSshlmxe2TqKGgO3TrQlaKKabN5mh4qY7Gdp6K7UBh8wR2qdkiJcU1pGDdqT7uKuAB8FLL/FA46980=
Received: from MWHPR11MB1373.namprd11.prod.outlook.com (10.169.234.141) by
 MWHPR11MB0013.namprd11.prod.outlook.com (10.164.204.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Thu, 8 Aug 2019 18:14:50 +0000
Received: from MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::480d:becc:c567:3336]) by MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::480d:becc:c567:3336%2]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 18:14:50 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <dan.carpenter@oracle.com>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>,
        <Ajay.Kathat@microchip.com>
Subject: Re: [PATCH 3/6] staging: wilc1000: remove unused members
Thread-Topic: [PATCH 3/6] staging: wilc1000: remove unused members
Thread-Index: AQHVQzBVmkV0XiIfSkqdQ0TzXZfFVabuI64AgABuv4CAAQbJgIACCruA
Date:   Thu, 8 Aug 2019 18:14:50 +0000
Message-ID: <783e9b64-bb7c-cd27-2ebd-4eb7d2879044@microchip.com>
References: <20190725213125.2810-1-adham.abozaeid@microchip.com>
 <20190725213125.2810-4-adham.abozaeid@microchip.com>
 <20190806124656.GH1974@kadam>
 <f0a3701c-39c3-1b95-3148-621b26d3f870@microchip.com>
 <20190807110351.GM1974@kadam>
In-Reply-To: <20190807110351.GM1974@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.175.253.81]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
x-clientproxiedby: BY5PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::23) To MWHPR11MB1373.namprd11.prod.outlook.com
 (2603:10b6:300:25::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9edcbcc4-44c3-4973-65c8-08d71c2c4d66
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR11MB0013;
x-ms-traffictypediagnostic: MWHPR11MB0013:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB0013CEB451C180E729C693FE8DD70@MWHPR11MB0013.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(376002)(346002)(136003)(189003)(199004)(31686004)(7736002)(4744005)(102836004)(81156014)(6246003)(53936002)(5660300002)(6506007)(36756003)(65956001)(66066001)(53546011)(81166006)(65806001)(65826007)(64126003)(58126008)(71190400001)(386003)(8936002)(107886003)(66446008)(86362001)(14454004)(99286004)(31696002)(66946007)(66556008)(71200400001)(316002)(64756008)(66476007)(54906003)(25786009)(52116002)(6916009)(4326008)(76176011)(478600001)(6436002)(305945005)(486006)(256004)(8676002)(14444005)(446003)(6486002)(11346002)(229853002)(6116002)(3846002)(2906002)(6512007)(476003)(26005)(186003)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB0013;H:MWHPR11MB1373.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YtUQkEdflW9Qeo3+/eb/PrhDyryxCjZyqUb0MHb0i2zCnFNbMfK/l1vTuF/iB2C7sxawPRkhdWpAt+egZo6Sin9xvoKOM7h79SExdzkHbz5qtD1ZAZbi61vntnTZVd+kU2lFNL/mWnl0EJS4JnHHBzYe7p/Ks21aB0j2E2y/HXfl0EM2F1d4fu627wbRmpWdbCHso3/avzTcDWYIA+3n2k8o5dk0RQ9S6OiQgx+EJNFy6RCandc5QZVbhGD7oA6uzyg8mh4JeC1alr4fp8Q7IC/xT+1GXdeCKb0hpbE3uyptAypkJUvwUAdNFA853GRzR4xPprSycilwUuskPF6LQjMKPcbfqanAcTyV0nXdcNxJDPMKwCL0jjpCs7M3VxgI1SEBc7ehTD5o0+Lh4cEG7+1deaDvMAOQr+3bGnOFhWQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81FC4B00BE9AC54D90D59B55D1A8475D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9edcbcc4-44c3-4973-65c8-08d71c2c4d66
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 18:14:50.0808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yHWWuds0QlUkuVWE69XecCGh4oKGtO8fvF04TQWJt0qhSaUzchqhU7hkjKK2RxY9jpcCpgVBOqGSTMCz4uGj0QVbfvtfLPuBoNYv8OnAVxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0013
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgRGFuDQoNCk9uIDgvNy8xOSA0OjAzIEFNLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0KPiBFeHRl
cm5hbCBFLU1haWwNCj4NCj4NCj4gT24gVHVlLCBBdWcgMDYsIDIwMTkgYXQgMDc6MzI6MDhQTSAr
MDAwMCwgQWRoYW0uQWJvemFlaWRAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IEhpIERhbg0KPj4N
Cj4+IE9uIDgvNi8xOSA1OjQ2IEFNLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0KPj4+IEV4dGVybmFs
IEUtTWFpbA0KPj4+DQo+Pj4NCj4+PiBPbiBUaHUsIEp1bCAyNSwgMjAxOSBhdCAwOTozMTozNFBN
ICswMDAwLCBBZGhhbS5BYm96YWVpZEBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+PiBGcm9tOiBB
ZGhhbSBBYm96YWVpZCA8YWRoYW0uYWJvemFlaWRAbWljcm9jaGlwLmNvbT4NCj4+Pj4NCj4+Pj4g
cmVtb3ZlIG9idGFpbmluZ19pcCBmcm9tIHN0cnVjdCB3aWxjX3ZpZg0KPj4+Pg0KPj4+IEhvdyBp
cyB0aGlzICJ1bnVzZWQiPyAgSXQgbG9va3MgbGlrZSBpdCBpcyB1c2VkIHRvIG1lLg0KPj4gVGhl
IG1haW4gdXNhZ2Ugb2Ygb2J0YWluaW5nX2lwIHdhcyB0byB0cmFjayB0aGUgaW5ldGFkZF9ub3Rp
ZmllciBzdGF0dXMuDQo+PiBBZnRlciByZW1vdmluZyB0aGUgbm90aWZpZXIgYW5kIGlwIGFkZHJl
c3MgdGltZW91dCB0aW1lciBpbiB0aGUgZmlyc3QgYW5kIHNlY29uZCBwYXRjaCwNCj4+IHRoZSBy
ZW1haW5pbmcgdXNhZ2UgYmVjYW1lIG1lYW5pbmdsZXNzLCBhbmQgY291bGQgYmUgcmVtb3ZlZC4N
Cj4gVGhpcyBpcyBleGFjdGx5IHRoZSBsZXZlbCBvZiBkZXRhaWwgdGhhdCBJIHdvdWxkIGxpa2Ug
aW4gYSBjb21taXQNCj4gZGVzY3JpcHRpb24uDQpTdXJlLiBXaWxsIGRvIG15IGJlc3QgaW4gdGhl
IGZ1dHVyZSB0byBhZGQgbW9yZSBkZXRhaWxzIGluIHRoZSBjb21taXQgZGVzY3JpcHRpb24uDQoN
ClRoYW5rcywNCkFkaGFtDQo=
