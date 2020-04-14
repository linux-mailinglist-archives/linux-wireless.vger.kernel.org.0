Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2371A7302
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 07:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405525AbgDNFcJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 01:32:09 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:27919 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405521AbgDNFcI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 01:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1586842327; x=1618378327;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=MVznwrR6WRGZqZtQ/rQ1ZlMtRcqf/PBBv2+2gBrBQsQ=;
  b=GKhMbvEpU2+xsCveZM6NHq3VcxUboLlCCnlw8aQ96RHHL2gmXhL0azBP
   RIe7BNxOX5BnEjgk/7t4HE8kvPqgvZGt5Llc6m7qF1bmAAgvfhGnB2X3w
   vFPyK9bqkjgZrxGVA3DGZrCo1fwLlE+6H/+glA4RP1b6aodX1Up7K6xGl
   A=;
Subject: RE: [PATCH v2 2/2] ath10k: correct legacy rate in tx stats
Thread-Topic: [PATCH v2 2/2] ath10k: correct legacy rate in tx stats
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Apr 2020 22:32:07 -0700
Received: from nasanexm01a.na.qualcomm.com ([10.85.0.81])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 13 Apr 2020 22:32:06 -0700
Received: from nasanexm01a.na.qualcomm.com (10.85.0.81) by
 nasanexm01a.na.qualcomm.com (10.85.0.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 13 Apr 2020 22:32:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm01a.na.qualcomm.com (10.85.0.81) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 13 Apr 2020 22:32:06 -0700
Received: from MWHPR02MB2496.namprd02.prod.outlook.com (2603:10b6:300:48::7)
 by MWHPR02MB3277.namprd02.prod.outlook.com (2603:10b6:301:6a::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Tue, 14 Apr
 2020 05:32:04 +0000
Received: from MWHPR02MB2496.namprd02.prod.outlook.com
 ([fe80::fdf2:a83d:5a48:2a6a]) by MWHPR02MB2496.namprd02.prod.outlook.com
 ([fe80::fdf2:a83d:5a48:2a6a%4]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 05:32:04 +0000
From:   Yu Wang <yyuwang@qti.qualcomm.com>
To:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        Yu Wang <yyuwang@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Thread-Index: AQHWDnpFzFtV+JgAYEexhoJhfDOKm6h4EwBg
Date:   Tue, 14 Apr 2020 05:32:04 +0000
Message-ID: <MWHPR02MB2496EE78C46698CE3E6101EB98DA0@MWHPR02MB2496.namprd02.prod.outlook.com>
References: <0101016e82883ded-63f88383-cd90-4cb0-b9bb-3dd6a1e9f4e9-000000@us-west-2.amazonses.com>
 <20200409142136.5490EC433BA@smtp.codeaurora.org>
In-Reply-To: <20200409142136.5490EC433BA@smtp.codeaurora.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yyuwang@qti.qualcomm.com; 
x-originating-ip: [103.229.16.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03afdb92-3176-4cff-6409-08d7e0352a8c
x-ms-traffictypediagnostic: MWHPR02MB3277:
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR02MB3277A5F76B9C918A1BDAD98798DA0@MWHPR02MB3277.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2496.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(39860400002)(346002)(136003)(396003)(366004)(478600001)(966005)(26005)(4326008)(71200400001)(7696005)(86362001)(6506007)(316002)(110136005)(54906003)(53546011)(186003)(55016002)(2906002)(76116006)(66946007)(52536014)(8676002)(9686003)(66446008)(64756008)(66476007)(81156014)(33656002)(66556008)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iSUPDrDtmSFcm4rQVOSqHZAviAyEtGBKCSpSkroS+J9B2TXeWl5dxcHPSO0dE1ECPEza9qLLryE4urTyOmcZ0bsG5ySX9ET+iEePPUIbpPlQl8CFq48gUaAAweCu8PEe+ymhZ9vp1tBSqE5NV23efVSnc5Ko9sZuhwp8JT8uKckMzfbdE14gHVd/2SOr6sqIt8oarU8o0yKGSxqilXNZZf1LPmtRNMlfiiN4AeNsAaC36bi1GFBYDfun9nEIjv/UOfOKngRY3u0T6El+PHGssoIDvkonCQAC+thmvoNuIpBUpT9HMEuy7ycgJwMSb+0DK1lQ5vwEH9rRk5w2rD9/sSlx1J26sFqVMmRpmxwf8UlhvR/yDJkhOiYA46KuxraVLUgPoB17rTH+LomNbVfXLImiPrn8L18sS9IUxPtphS1EQLy0NIfrWVCTS1JKyxN1g/j0wV5X49/pH3yXO1bAIHrD6i1b+tNKHqKpVG07dqTv8ZJSZmwZ+mnrWA0fZc/RmHe3LLMeFhdWCs4m02ET7A==
x-ms-exchange-antispam-messagedata: WVYyBj1mpbvJLkfIcOjRhktcC30zm/g4o2sCTnoVxT5vDG10Q7xa2ntp/0hVWpYsj4H3+Eq/6RZ/3N1yXEUSGZ46+R8SJRPLl/K0A9+gV8gzI0R9I2ijbhu8+Q+rCJ94PSoG8iLEuksgwhFodPO35g==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLxy/R9zFMfnBGFo37uDXbQ0zpohdB7hluo6a85sjD/qwlLIFmCUn60t3B7cfbLOwK0HRfQmVpQ3AOpR8CrMzda4o307nisWRZLz9Kuwqjte+ekFDT1P4REiGMucwv6nzgiALEr/SITQICgfIyYlWQVxTf+cCJQa5TTq+dFKgQ6EDZvherE41bM2g1KI42gq6XFMY211NgLRxidsjQGGvR1aWeXT9vocx44wkC51dlGT41h5V+uN56G9bi77S/K1ZZ4S1dnyTAW22nnCn/HPZZtg1auhT7FwoIJ7r6zVaCBVqQZHbpbqfxHJKgVxMVNoVJSffhj2bcptTpkaj46VBA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqMskidiONKcjAwfkZc+os76whAYBprcoNV1XT8BtLo=;
 b=hekGapAnWZht911pjwBoRnVTrkRSBOqEUm8Vpzfzk7ZDPZy4a4xgsl9C2i7+flPeduCTLMk226YQE6JNKJaYJRrjIVz4e4kTHCH1Sd7y+RD3a052P/m2h1OMEkasH5XE+fExVHtdhQ7o3I6rNwKmbz1812AubkUn+ylvtZUE2caRY19oNfM82lMP9T/Pp2bx2RwzHOWV9/VhxR/7SRzGVaZt0ihhA1LCW5NZItw7B6vhZUhW9SCGIXygpvpJ7y4skYQcjhvgOrYc2BRUDScBpN25BbFJTNNr7ZV5yFG+QuLUFGJi4FWBhGvTKUcKXHUpaDa70J5CFDqpm07/rxa9kQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqMskidiONKcjAwfkZc+os76whAYBprcoNV1XT8BtLo=;
 b=tQn85Y0m4dvCGoR8RRq4xUoopzHA7vRphQ2tqAEuDAqblUsOM/WK5iDVulouOkoPkx5FceB0JJRfbAY2aXEbVz1VL3mtdc5pQx6bi4l5QcGKkVZ/yGOd6JafnyeIFp2T4NOWo+4rDB2dfrStyO4VPDQcv8hynIY6yIRwfTaf2Zk=
x-ms-exchange-crosstenant-network-message-id: 03afdb92-3176-4cff-6409-08d7e0352a8c
x-ms-exchange-crosstenant-originalarrivaltime: 14 Apr 2020 05:32:04.6117 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: aH3EsLGzhjFEHXXX36nr4/nSoMnBvypFS7rFtvmlbEosMmd1drmVrlIwPXwvMdLHWU9qU5aHJJdp873gFGbPpYklOGHUS+MnTOpVcWAgzu0=
x-ms-exchange-transport-crosstenantheadersstamped: MWHPR02MB3277
x-originatororg: qti.qualcomm.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYXRoMTBrIDxhdGgxMGst
Ym91bmNlc0BsaXN0cy5pbmZyYWRlYWQub3JnPiBPbiBCZWhhbGYgT2YgS2FsbGUgVmFsbw0KPiBT
ZW50OiBUaHVyc2RheSwgQXByaWwgOSwgMjAyMCAxMDoyMiBQTQ0KPiBUbzogWXUgV2FuZyA8eXl1
d2FuZ0Bjb2RlYXVyb3JhLm9yZz4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9y
ZzsgYXRoMTBrQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRD
SCB2MiAyLzJdIGF0aDEwazogY29ycmVjdCBsZWdhY3kgcmF0ZSBpbiB0eCBzdGF0cw0KPg0KPiBZ
dSBXYW5nIDx5eXV3YW5nQGNvZGVhdXJvcmEub3JnPiB3cm90ZToNCj4NCj4gPiBXaGVuIHdvcmtp
bmcgaW4gc3RhdGlvbiBtb2RlLCBhZnRlciBjb25uZWN0ZWQgdG8gYSBsZWdhY3kgQVAsIDExZw0K
PiA+IG9ubHksIGZvciBleGFtcGxlLCB0aGUgdHggYml0cmF0ZSBpcyBpbmNvcnJlY3QgaW4gb3V0
cHV0IG9mIGNvbW1hbmQNCj4gPiAnaXcgd2xhbjAgbGluaycuDQo+ID4NCj4gPiBUaGF0J3MgYmVj
YXVzZSB0aGUgbGVnYWN5IHR4IGJpdHJhdGUgdmFsdWUgcmVwb3J0ZWQgYnkgZmlybXdhcmUgaXMg
bm90DQo+ID4gd2VsbCBoYW5kbGVkOg0KPiA+IEZvciBRQ0E2MTc0LCB0aGUgdmFsdWUgcmVwcmVz
ZW50cyByYXRlIGluZGV4LCBidXQgdHJlYXRlZCBhcyBhIHJlYWwNCj4gPiByYXRlOyBGb3IgUUNB
OTg4OCwgdGhlIHZhbHVlIGlzIHJlYWwgcmF0ZSwgd2l0aCB1bml0ICdNYnBzJywgYnV0DQo+ID4g
dHJlYXRlZCBhcyAnMTAwa2JwcycuDQo+ID4NCj4gPiBUbyBmaXggdGhpcyBpc3N1ZToNCj4gPiAx
LiBUcmFuc2xhdGUgdGhlIHJhdGUgaW5kZXggdG8gcmVhbCByYXRlIGZvciBRQ0E2MTc0OyAyLiBU
cmFuc2xhdGUgdGhlDQo+ID4gcmF0ZSBmcm9tICdNYnBzJyB0byAna2JwcycgZm9yIFFDQTk4ODgu
DQo+ID4NCj4gPiBUZXN0ZWQgd2l0aDoNCj4gPiBRQ0E2MTc0IFBDSWUgd2l0aCBmaXJtd2FyZSBX
TEFOLlJNLjQuNC4xLmMzLTAwMDMxLg0KPiA+IFFDQTYxNzQgU0RJTyB3aXRoIGZpcm13YXJlIFdM
QU4uUk1ILjQuNC4xLTAwMDI5Lg0KPiA+IFFDQTk4ODggUENJZSB3aXRoIGZpcm13YXJlIDEwLjQt
My45LjAuMi0wMDA0MC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFl1IFdhbmcgPHl5dXdhbmdA
Y29kZWF1cm9yYS5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2FsbGUgVmFsbyA8a3ZhbG9AY29k
ZWF1cm9yYS5vcmc+DQo+DQo+IE15IGNvbW1lbnRzIGRvbid0IHNlZW0gdG8gZ28gdG8gcGF0Y2h3
b3JrLCBzbyB0cnlpbmcgYWdhaW46DQo+DQo+IFdoYXQgYWJvdXQgUUNBOTg4WCBhbmQgV0NOMzk5
MCwgaG93IGRvIHRoZXkgYmVoYXZlPyBEb2VzIHRoaXMgcGF0Y2gNCj4gYnJlYWsgdGhvc2U/DQpT
aW5jZSBIVFRfVDJIX01TR19UWVBFX1BQRFVfU1RBVFNfSU5EIGlzIGEgbmV3bHkgYWRkZWQgbWVz
c2FnZSwgc3VwcG9zZSBpdCdzIHdvbid0IGJyZWFrIHRoZSBvdGhlciBmdW5jdGlvbnMuDQpJIGRv
buKAmXQgaGF2ZSBlbnZpcm9ubWVudCB0byB2ZXJpZnkgdGhlIHBhdGNoIHdpdGggUUNBOTg4WCBh
bmQgV0NOMzk5MC4NCkNhbiBhbnlvbmUgaGVscCBvbiB0aGlzPw0KDQo+DQo+ID4gK2NjayA9IChw
cmVhbWJsZSA9PSBXTUlfUkFURV9QUkVBTUJMRV9DQ0spOw0KPiA+ICtod19yYXRlID0gQVRIMTBL
X0hXX0xFR0FDWV9SQVRFKCpyYXRlY29kZSk7DQo+ID4gK2ZvciAoaSA9IDA7IGkgPCBzYmFuZC0+
bl9iaXRyYXRlczsgaSsrKSB7DQo+ID4gK2JpdHJhdGVzID0gJnNiYW5kLT5iaXRyYXRlc1tpXTsN
Cj4gPiAraWYgKGF0aDEwa19tYWNfYml0cmF0ZV9pc19jY2soYml0cmF0ZXMtPmJpdHJhdGUpICE9
IGNjaykNCj4gPiArY29udGludWU7DQo+ID4gKw0KPiA+ICtpZiAoYml0cmF0ZXMtPmh3X3ZhbHVl
ID09IGh3X3JhdGUgfHwNCj4gPiArICAgIChiaXRyYXRlcy0+ZmxhZ3MgJiBJRUVFODAyMTFfUkFU
RV9TSE9SVF9QUkVBTUJMRSAmJg0KPiA+ICsgICAgIGJpdHJhdGVzLT5od192YWx1ZV9zaG9ydCA9
PSBod19yYXRlKSkgew0KPiA+ICtiaXRyYXRlID0gYml0cmF0ZXMtPmJpdHJhdGU7DQo+ID4gKw0K
PiA+ICsvKiBUaGUgYml0cmF0ZSB3aWxsIGJlIHJlY292ZXJlZCBpbg0KPiA+ICsgKiBhdGgxMGtf
dXBkYXRlX3Blcl9wZWVyX3R4X3N0YXRzKCkuDQo+ID4gKyAqLw0KPiA+ICtpZiAoYml0cmF0ZSA9
PSA1NSkNCj4gPiArYml0cmF0ZSA9IDYwOw0KPiA+ICsNCj4gPiArYml0cmF0ZSA9IGJpdHJhdGUg
LyAxMDsNCj4NCj4gSGVyZSB5b3UgdXNlIG1hZ2ljIHZhbHVlIDYwIGJ1dCBpbiBhdGgxMGtfdXBk
YXRlX3Blcl9wZWVyX3R4X3N0YXRzKCkgeW91IHVzZQ0KPiBtYWdpYyB2YWx1ZSA1MDoNCj4NCj4g
PiArLyogZnJvbSAxTWJwcyB0byAxMDBLYnBzICovDQo+ID4gK3JhdGUgPSByYXRlICogMTA7DQo+
ID4gK2lmIChyYXRlID09IDUwKQ0KPiA+ICtyYXRlID0gNTU7DQo+DQo+IEFtIEkgbWlzc2luZyBz
b21ldGhpbmcgb3IgaG93IGlzIHRoaXMgc3VwcG9zZWQgdG8gd29yaz8NCkluIGV4aXN0aW5nIGNv
ZGUsIGF0aDEwa191cGRhdGVfcGVyX3BlZXJfdHhfc3RhdHMoKSB3aWxsIGNoZWNrIHRoZSBiaXRy
YXRlIGFuZCBjb252ZXJ0IDZfQ0NLIHRvIDUoaW4gdGhlIGNvbW1lbnQ6IEZXIHNlbmRzIENDSyBy
YXRlIDUuNU1icHMgYXMgNiksIGFuZCB0aGVuIDUgd2lsbCBiZSByZWNvdmVyZWQgdG8gNTUuDQpU
aGF0J3Mgd2h5IHdlIG5lZWQgdG8gY29udmVydCBiaXRyYXRlIDU1IHRvIDYgd2hlbiBwcm9jZXNz
aW5nIFBQRFVfU1RBVFMuDQoNCmlmICh0eHJhdGUuZmxhZ3MgPT0gV01JX1JBVEVfUFJFQU1CTEVf
Q0NLIHx8DQp0eHJhdGUuZmxhZ3MgPT0gV01JX1JBVEVfUFJFQU1CTEVfT0ZETSkgew0KcmF0ZSA9
IEFUSDEwS19IV19MRUdBQ1lfUkFURShwZWVyX3N0YXRzLT5yYXRlY29kZSk7DQovKiBUaGlzIGlz
IGhhY2t5LCBGVyBzZW5kcyBDQ0sgcmF0ZSA1LjVNYnBzIGFzIDYgKi8NCmlmIChyYXRlID09IDYg
JiYgdHhyYXRlLmZsYWdzID09IFdNSV9SQVRFX1BSRUFNQkxFX0NDSykNCnJhdGUgPSA1Ow0KcmF0
ZV9pZHggPSBhdGgxMGtfZ2V0X2xlZ2FjeV9yYXRlX2lkeChhciwgcmF0ZSk7DQppZiAocmF0ZV9p
ZHggPCAwKQ0KcmV0dXJuOw0KDQovKiBmcm9tIDFNYnBzIHRvIDEwMEticHMgKi8NCnJhdGUgPSBy
YXRlICogMTA7DQppZiAocmF0ZSA9PSA1MCkNCnJhdGUgPSA1NTsNCj4NCj4gLS0NCj4gaHR0cHM6
Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTI1MTAwMS8NCj4NCj4gaHR0cHM6Ly93aXJl
bGVzcy53aWtpLmtlcm5lbC5vcmcvZW4vZGV2ZWxvcGVycy9kb2N1bWVudGF0aW9uL3N1Ym1pdHRp
bmdwYXRjaA0KPiBlcw0KPg0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KPiBhdGgxMGsgbWFpbGluZyBsaXN0DQo+IGF0aDEwa0BsaXN0cy5pbmZyYWRl
YWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vYXRo
MTBrDQo=
