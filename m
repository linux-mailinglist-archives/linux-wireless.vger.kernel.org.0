Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD74430928
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2019 09:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfEaHLT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 May 2019 03:11:19 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:59705 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaHLT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 May 2019 03:11:19 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.60,534,1549954800"; 
   d="scan'208";a="35555637"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 May 2019 00:11:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex01.mchp-main.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 31 May 2019 00:11:17 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 31 May 2019 00:11:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziQcYK5HajOS1M+7z34cc2MbSwCBybUas5ZxVd85j4s=;
 b=UjvS5B670WjWhbSi0JkAIukuw4g3qxiqQWiSkwlb+Ayd0ELxyKbDyVxjxn9caowBLYRU08IrVyd8UVFynMqCb0ymuzOha2R3y+l1XVkTf8M+5yzfCQfT0T7WRyuVz42Oq+cOovWdM4kZfOijGPigtUb3QYkZC4qZEK0IAwNKPRM=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB2019.namprd11.prod.outlook.com (10.173.27.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Fri, 31 May 2019 07:11:15 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::49ee:ab78:412:48ac]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::49ee:ab78:412:48ac%5]) with mapi id 15.20.1922.021; Fri, 31 May 2019
 07:11:15 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        <gregkh@linuxfoundation.org>, <Adham.Abozaeid@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 00/16] wilc1000: move out of staging
Thread-Topic: [PATCH 00/16] wilc1000: move out of staging
Thread-Index: AQHUwEbCCX3IcHjEkkah7YSVPvJ9TKYWSGkAgAABd3mAYw1+AIAADAJigAApwICAC8uXgIAAGXISgAAMgoA=
Date:   Fri, 31 May 2019 07:11:14 +0000
Message-ID: <53ee733f-1e7f-91a7-639a-3dda7821dcd7@microchip.com>
References: <1549696298-9795-1-git-send-email-ajay.kathat@microchip.com>
 <5ac9d9bb-08e4-c46f-ce0a-40630e1d958e@microchip.com>
 <871s30pevc.fsf@codeaurora.org>
 <2ba91fc2-af3a-b235-5cb0-2ba06444ea30@microchip.com>
 <87sgt5cl8q.fsf@kamboji.qca.qualcomm.com>
 <fb17fb6b-08d2-6871-d214-2fbcc1da73fb@microchip.com>
 <8e227b89-6068-266c-f41d-1c45664d57d1@microchip.com>
 <87zhn3ywfh.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87zhn3ywfh.fsf@kamboji.qca.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR01CA0101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::19) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [223.237.195.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3f679fb-eaf8-43aa-e37e-08d6e5972b2b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB2019;
x-ms-traffictypediagnostic: BN6PR11MB2019:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN6PR11MB20193BD63F6953014A9728AFE3190@BN6PR11MB2019.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(376002)(396003)(39860400002)(199004)(189003)(55674003)(72206003)(66556008)(5660300002)(8676002)(99286004)(6916009)(31686004)(316002)(66476007)(64756008)(66946007)(478600001)(386003)(6246003)(66446008)(81166006)(7736002)(52116002)(53936002)(76176011)(102836004)(305945005)(68736007)(229853002)(966005)(36756003)(6506007)(53546011)(73956011)(6486002)(107886003)(486006)(186003)(86362001)(2906002)(446003)(256004)(11346002)(8936002)(54906003)(6436002)(71200400001)(476003)(6512007)(6306002)(3846002)(6116002)(14444005)(31696002)(4326008)(25786009)(71190400001)(2616005)(26005)(14454004)(66066001)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB2019;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mxA6LVxdg3XuOEY4CXkKSRjzYYlf5u297Hhp5ddJKw5jcjvtY4N8XVr9F6NApQOIJEPoQRAUE82WTnqtuNDWyxiYiWEjWSKY16GKd/F+co6X7dc07KD91nAkcydszTA3YJqrUlvxTtOMJssU24t4XwdUAoa5ofRb3CW7KEkgJtfWO08tck3IVX/v7hg+DuV1qSQ+IA870lBfqh9ghF6i71ouTCbeSpAX+F1lbYqAd+rbogD1AikaboWYNUnpjz+kQ7s6FCZ6QdK4+VQYiD2kfnPToDmSpUqtqV4wqeSt7exv7iOXsbh1QEzt2+FbxhYOvdpEaTOIKSpxAxPNRWLLkriCUPvUtoLXa45EmvEeVpVH97kcyL90Z/bLlPyz+bsqeINGgvS5701fpUfs3zVQENRlOXlgY26nTnw5GipnLGI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D4E17588FEB344BA92EFE2B93594FB4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f679fb-eaf8-43aa-e37e-08d6e5972b2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 07:11:15.0130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajay.kathat@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2019
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQpPbiA1LzMxLzIwMTkgMTE6NTMgQU0sIEthbGxlIFZhbG8gd3JvdGU6DQo+IEV4dGVybmFsIEUt
TWFpbA0KPiANCj4gDQo+IDxBamF5LkthdGhhdEBtaWNyb2NoaXAuY29tPiB3cml0ZXM6DQo+IA0K
Pj4gSGkgS2FsbGUsDQo+Pg0KPj4gT24gNS8yMy8yMDE5IDEwOjE1IFBNLCBBamF5LkthdGhhdEBt
aWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+IEhpIEthbGxlLA0KPj4+DQo+Pj4gT24gNS8yMy8yMDE5
IDc6NDMgUE0sIEthbGxlIFZhbG8gd3JvdGU6DQo+Pj4+IDxBamF5LkthdGhhdEBtaWNyb2NoaXAu
Y29tPiB3cml0ZXM6DQo+Pj4+DQo+Pj4+PiBIaSBLYWxsZSwNCj4+Pj4+DQo+Pj4+PiBPbiAzLzIx
LzIwMTkgNjoyNCBQTSwgS2FsbGUgVmFsbyB3cm90ZToNCj4+Pj4+Pg0KPj4+Pj4+IDxBamF5Lkth
dGhhdEBtaWNyb2NoaXAuY29tPiB3cml0ZXM6DQo+Pj4+Pj4NCj4+Pj4+Pj4gSGkgS2FsbGUvSm9o
YW5uZXMsDQo+Pj4+Pj4+DQo+Pj4+Pj4+IE9uIDIvOS8yMDE5IDEyOjQyIFBNLCBBamF5IEthdGhh
dCAtIEkxNTQ4MSB3cm90ZToNCj4+Pj4+Pj4+IEZyb206IEFqYXkgU2luZ2ggPGFqYXkua2F0aGF0
QG1pY3JvY2hpcC5jb20+DQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gVGhpcyBwYXRjaCBzZXJpZXMgaXMg
dG8gcmV2aWV3IGFuZCBtb3ZlIHdpbGMxMDAwIGRyaXZlciBvdXQgb2Ygc3RhZ2luZy4NCj4+Pj4+
Pj4+IEltcGxlbWVudGVkIHRoZSBpbml0aWFsIHJlY2VpdmVkIHJldmlldyBjb21tZW50c1sxXSBh
bmQgc3VibWl0dGluZyB0aGUNCj4+Pj4+Pj4+IGRyaXZlciBhZ2Fpbi4gRHVyaW5nIHRoaXMgY2xl
YW51cCBkZWxldGVkIGFyb3VuZCAzLjNrIGxpbmVzIG9mIGNvZGUuDQo+Pj4+Pj4+Pg0KPj4+Pj4+
Pj4gQmVsb3cgYXJlIHRoZSBtYWpvciBpdGVtcyBmaXhlZCBpbiByZWNlbnQgY2xlYW51cDoNCj4+
Pj4+Pj4+ICAtIHJlbW92ZSB1c2Ugb2Ygc2hhZG93IGJ1ZmZlciB0byBrZWVwIHNjYW4gcmVzdWx0
Lg0KPj4+Pj4+Pj4gIC0gcmVtb3ZlIGludGVybmFsIG1lc3NhZ2luZyBmbG93IHRvIGhhbmRsZSBj
Zmc4MDIxMV9vcHMuDQo+Pj4+Pj4+PiAgLSBtYWtlIHVzZSBvZiBjZmc4MDIxMSBwcm92aWRlZCBB
UEkuDQo+Pj4+Pj4+PiAgLSB1c2Ugc3RydWN0dXJlIGZvciBwYWNraW5nIGZpcm13YXJlIGNvbW1h
bmRzLg0KPj4+Pj4+Pj4gIC0gbWFrZSB1c2Ugb2Yga2VybmVsIHByb3ZpZGVkIEFQSSBhbmQgbWFj
cm9zLg0KPj4+Pj4+Pj4gIC0gcmVtb3ZlIHVubmVjZXNzYXJ5IGxvZ3MgbWVzc2FnZXMuDQo+Pj4+
Pj4+Pg0KPj4+Pj4+Pj4gUGVuZGluZyBhY3Rpb24gaXRlbToNCj4+Pj4+Pj4+ICAtIGR5bmFtaWNh
bGx5IGFkZC9yZW1vdmUgcDJwIGludGVyZmFjZS4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiAgVGhpcyBp
dGVtIHdpbGwgdGFrZSBzb21lIHRpbWUsIHdlIGFyZSBwbGFubmluZyB0byB0YWtlIGl0IHVwIGFm
dGVyDQo+Pj4+Pj4+PiAgbWFpbmxpbmUuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gIFdlIGhvcGUgaXQg
Y2FuIGJlIG1vdmUgb3V0IHN0YWdpbmcgaW4gdjUuMS4NCj4+Pj4+Pj4+ICBQbGVhc2UgcmV2aWV3
IGFuZCBjb25maXJtIGlmIGl0IGlzIGdvb2QgdG8gbW92ZSBvdXQuDQo+Pj4+Pj4+DQo+Pj4+Pj4+
IERvIHlvdSBoYXZlIGFueSB1cGRhdGUgZm9yIHRoaXMgc2VyaWVzLiBQbGVhc2UgcHJvdmlkZSB5
b3VyIGlucHV0cyBmb3INCj4+Pj4+Pj4gbmV4dCBzdGVwLg0KPj4+Pj4+DQo+Pj4+Pj4gcnR3ODgg
aXMgdGFraW5nIHByaW9yaXR5IGluIHRoZSBuZXcgZHJpdmVycyAicXVldWUiIHNvIEkgZG91YnQg
SSBjYW4NCj4+Pj4+PiB0YWtlIGEgbG9vayBhdCB0aGlzIGluIHRoZSBuZXh0IGZldyB3ZWVrcy4N
Cj4+Pj4+Pg0KPj4+Pj4NCj4+Pj4+IElzIHRoZXJlIGFueSB1cGRhdGUgZm9yIHdpbGMxMDAwIGRy
aXZlciByZXZpZXcuIFBsZWFzZSBsZXQgbWUga25vdyB5b3VyDQo+Pj4+PiBpbnB1dHMuDQo+Pj4+
DQo+Pj4+IFNvIGlzIHRoZSBkcml2ZXIgaW4gZ29vZCBzaGFwZSBub3c/IEkgcmVhbGx5IGRvIG5v
dCB3YW50IHRvIHVzZSBhIGxvdCBvZg0KPj4+PiB0aW1lIHJldmlld2luZyBpdCBqdXN0IHRvIGZp
bmQgb3V0IHRoYXQgdGhlcmUncyBhIGxvdCBvZiB3b3JrIHRvIGRvLiBGb3INCj4+Pj4gZXhhbXBs
ZSwgaGFzIHNvbWVvbmUgZWxzZSByZXZpZXdlZCBpdD8NCj4+Pj4NCj4+Pg0KPj4+IFRoZSBmaXJz
dCBzZXJpZXMgZm9yIGNvbXBsZXRlIGRyaXZlciByZXZpZXcgd2FzIHN1Ym1pdHRlZCBlYXJsaWVy
IFsxXS4NCj4+PiBJdCB3YXMgcmV2aWV3ZWQgYnkgSm9oYW5uZXMgYW5kIGhlIGxvb2tlZCBpbnRv
IGRyaXZlciBpbnRlZ3JhdGlvbiB3aXRoDQo+Pj4gdGhlIGNmZzgwMjExIHN0YWNrIHBhcnQuIFdl
IHdvcmtlZCBvbiB0aGUgcmV2aWV3IGNvbW1lbnRzIGFuZCBzdWJtaXR0ZWQNCj4+PiB0aGUgY2hh
bmdlcyB0byBzdGFnaW5nLg0KPj4+DQo+Pj4gV2UgbmVlZCBmdXJ0aGVyIHJldmlldyB0byBpZGVu
dGlmeSBpZiB0aGVyZSBpcyBhbnkgYmxvY2tlciB0byBtb3ZlIHRvDQo+Pj4gbWFpbmxpbmUuDQo+
Pj4NCj4+PiBbMV0uIGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LXdpcmVsZXNz
L21zZzE3Nzg3OC5odG1sDQo+Pj4NCj4+DQo+PiBKdXN0IGEgZ2VudGxlIG1haWwgdG8gY2hlY2sg
aWYgd2lsYzEwMDAgZHJpdmVyIGlzIHBpY2tlZC11cCBmb3IgcmV2aWV3DQo+PiBhbmQgd2hhdCBp
cyB0aGUgbmV4dCBzdGVwLg0KPiANCj4gUGxlYXNlIGJlIHBhdGllbnQsIGdldHRpbmcgYSBkcml2
ZXIgdXBzdHJlYW0gaXMgbm90IGEgc2ltcGxlIHRhc2suIFdoYXQNCj4gdGhpcyBkcml2ZXIgbmVl
ZHMgbm93IGlzIHJldmlld3MgYW5kIHBlb3BsZSBzYXlpbmcgdGhhdCB0aGUgZHJpdmVyIGlzDQo+
IHJlYWR5IGZvciB1cHN0cmVhbSwgSSBoYXZlIG5vdCBzZWVuIGFueSBvZiB0aGF0IHlldC4gTWF5
YmUgeW91IGNvdWxkDQo+IHN1Ym1pdCBhIG5ldyB2ZXJzaW9uLCBob3BlZnVsbHkgdGhhdCB0cmln
Z2VycyBwZW9wbGUgdG8gcmV2aWV3IHRoaXM/DQo+IEFsc28gSSdsbCB0cnkgdG8gZmluZCB0aW1l
IGZvciByZXZpZXcgYnV0LCBhcyB1c3VhbCwgSSdtIHJlYWxseSBidXN5Lg0KPiANCg0KVGhhbmtz
IEthbGxlLCBJIHdpbGwgd2FpdCBmb3IgcmV2aWV3IGNvbW1lbnRzIGFuZCBpbiB0aGUgbWVhbnRp
bWUgSSB3aWxsDQpzZW5kIHRoZSBwYXRjaCB1cGRhdGUuDQoNClJlZ2FyZHMsDQpBamF5DQo=
