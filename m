Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1981A190155
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 23:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgCWWxP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 18:53:15 -0400
Received: from mx3.watchguard.com ([63.251.166.21]:6765 "EHLO
        mx3.watchguard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbgCWWxN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 18:53:13 -0400
Received: from PRDITOMBX01.wgti.net (172.24.2.21) by PRDITOMBX01.wgti.net
 (172.24.2.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Mon, 23 Mar
 2020 15:53:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by owa.watchguard.com (172.24.2.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3
 via Frontend Transport; Mon, 23 Mar 2020 15:53:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcyARlgwaIHBEkqxBQW+0/utB+TTLkA7Ax7RGxQQI8GHo2nWsHPXTfs35Vz68jpBEcKL+PK2KCNHicPFchsZGbNU0g1OztBWYvQl1hthFUq54WCRABvFR0ev35N8c96x0AHlWOdMXt0rMQYonlOTz60Gu+KfkUNfz6EwG2/qBqfiK2Fhic3D92orjztrRUbvM5JS3lP09aD4S2Op7SBXCda6+Ha/iAdAlXv1vDmqvxjiskC2ba4HcjX1gNGbga+8Ni61sb/lojn2O/hUWTdHNMyE19SwDwOmFiVwuHTXliLRDkdalpby0ofGR0ICZCuoyI7NdrhbgJUVHmDUAyXalA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eygn2r+DeR0CxjW4h82Kt/iEj+1DC7YtUOh8bT6h0g=;
 b=Knk0ngfAX9oO81Um0wj3bO+7ZE0Wpt+U6iqVqGaBP92CjRMIHZFr9uKi54ZHHk73wB5GbLxpLJ3DxA1NWlvFH7Sfm3qmadUd4I/crPTGijrTILf5bbKX24odDO6GBqvo2DJX4X1KCD6X3zIMFFUblrPJGWkCRzXcbxEWD1sKKbeAGpDyP3dTjBSQVYyRNgP+AcBwDtyL3h/hKd+tbU3/Hp6m99UL0MkbYVRCPygg6uLIo7rCdqeex6/B2lu8xOYA6STa6iTG+mRj9+l63ElW4kEBrwLR/915543su4UrbAc2Xd7mT2zFP2PGSM1NldQDJHxp+VirF6doAZ8Pr9cRsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=watchguard.com; dmarc=pass action=none
 header.from=watchguard.com; dkim=pass header.d=watchguard.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wgt.onmicrosoft.com;
 s=selector2-wgt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eygn2r+DeR0CxjW4h82Kt/iEj+1DC7YtUOh8bT6h0g=;
 b=ffR/xEpwLu8HYNske0We5m9bgxWaNkvvb7p3aSPM0x5NBWGdklJ6crKjqjrZXF0k7pmF7+cLTQELNWiOrdptYEslePQ2f40n0roJGHtSKw1tOOiXAfgFX+lqQE8w0cWqfmeAiSc2gQnWVsNfKbU5yAH7527YdC39kt3y5Ih5P+M=
Received: from BN7PR10MB2737.namprd10.prod.outlook.com (2603:10b6:406:c5::24)
 by BN7PR10MB2625.namprd10.prod.outlook.com (2603:10b6:406:c4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Mon, 23 Mar
 2020 22:53:11 +0000
Received: from BN7PR10MB2737.namprd10.prod.outlook.com
 ([fe80::ed60:6ed3:92fa:9128]) by BN7PR10MB2737.namprd10.prod.outlook.com
 ([fe80::ed60:6ed3:92fa:9128%3]) with mapi id 15.20.2835.017; Mon, 23 Mar 2020
 22:53:11 +0000
From:   Ming Chen <Ming.Chen@watchguard.com>
To:     Tom Psyborg <pozega.tomislav@gmail.com>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Joe Qiao <Joe.Qiao@watchguard.com>
Subject: RE: Firmware Crashed
Thread-Topic: Firmware Crashed
Thread-Index: AdX/0YxOsQET/+KrQn2mecR6d2iN5gAP8c6AAEdzTgAACoSDgAAC7fCA
Date:   Mon, 23 Mar 2020 22:53:10 +0000
Message-ID: <BN7PR10MB2737794DBC285DD90E17536D9AF00@BN7PR10MB2737.namprd10.prod.outlook.com>
References: <BN7PR10MB2737FC3E7028D66FE34351C09AF20@BN7PR10MB2737.namprd10.prod.outlook.com>
 <CAKR_QVLLe2nssX3fz=xtPvM8ZQKwGpC4g=YOyUUkaniX_KB8QA@mail.gmail.com>
 <BN7PR10MB27370353B542954AD795D77E9AF00@BN7PR10MB2737.namprd10.prod.outlook.com>
 <CAKR_QVLvQUKCORmdJCqTz8JVoeo2-TYxkvj5p2RzoLNetKY8Vg@mail.gmail.com>
In-Reply-To: <CAKR_QVLvQUKCORmdJCqTz8JVoeo2-TYxkvj5p2RzoLNetKY8Vg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ming.Chen@watchguard.com; 
x-originating-ip: [66.235.15.95]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0465f16-7a2f-470a-f851-08d7cf7cf651
x-ms-traffictypediagnostic: BN7PR10MB2625:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR10MB2625E3C773E10A981F54E9159AF00@BN7PR10MB2625.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(136003)(396003)(39850400004)(107886003)(186003)(7696005)(26005)(8936002)(81156014)(5660300002)(33656002)(478600001)(76116006)(8676002)(66476007)(86362001)(66446008)(52536014)(66946007)(64756008)(81166006)(66556008)(71200400001)(55016002)(2906002)(3480700007)(6916009)(7116003)(53546011)(6506007)(316002)(9686003)(4326008)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR10MB2625;H:BN7PR10MB2737.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: watchguard.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BqIDxudx5PKC1W4P+OCnxoCqNiySJIyc4MikeOOfhiGrvUh9Y8U8QzM5Pu3u4b3PnSPFk02bJaejFim2+Uh+vMsNFd0pfDUftzUfrYelKIbgYnCBWxpvYUZD8Ygi9V2JgsVzqiNpwMMGwzJlMyL/YywP/+9Y1/oMMtskKtCzZd8prpGHhay5z3GEf37C+BlTRLqPnn/wcLDhBAXDwksicrZ/CqOhWd93YYoL47sdFa+C1wxnkuo7gvwRLJ74di4FWaetd2JGKVxLGDGM5aJlMd9w+0lhnVQyY5gIs+2I72YnNWk1jWnhkuszWliaHZ8ZNjMApDkCb1ZFtC2+zCj7DRWwA/+csNzkbbthkR9KIg8v/7kfvgvcGdCsuQYhUvDZcRr3E46icVwHXfo37vNLdT6fqDOTySzkfrSMYWmAI790jpP2VQrs1I/TEebsDU+K
x-ms-exchange-antispam-messagedata: nFaaGm8SHL9w2dOI6ikg30Op1Ju25oeLo6fYg4kCpSzI4pzisNJu+9f7Cv1UypcDgq9gjD/+1vYyG9rBouUcbMdCUVCPwE76wKWzsrBPuO/s49jNSWTJomJcw47leQjJAJpVdio/3aAHHpQZYvSfUQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f0465f16-7a2f-470a-f851-08d7cf7cf651
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 22:53:10.9477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2563c132-88f5-466f-bbb2-e83153b3c808
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uq/HbozwWcukotU00UakssRpUjOty45W1cV2wEExd62z9CsKMq8ahH+2nzN1C+RvERDqZ5by1o/3E+0Y3DNVCmBvsHa138F6qZNXfM1Btq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2625
X-OriginatorOrg: watchguard.com
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiA+IE5vLCBpdCB3aWxsIGJlIHZlcnkgZGlmZmljdWx0IGZvciB1cyB0byB1cGdyYWRlIHRoZSBr
ZXJuZWwuDQo+ID4gVGhpcyBtb2R1bGUoUUNBOTk4NiBQQ0llKSBpcyBmcm9tIHRoZSBhIHRoaXJk
IHBhcnR5IGNvbXBhbnkuIFRoZXkgYXJlDQo+ID4gdXNpbmcgdGhlIFFDQSBkcml2ZXIgYW5kIGl0
IHdvcmtzIHdlbGwuIFdlIGFyZSB0cnlpbmcgdG8gaW50ZWdyYXRlDQo+ID4gdGhpcyBtb2R1bGUg
dG8gb3VyIG93biBkZXZpY2UoUFBDLTY0ICsgS2VybmVsIDQuMTQuODMpLiBXZSBkb24ndCB3YW50
DQo+ID4gdG8gdXBncmFkZSB0aGUga2VybmVsLCBzaW5jZSBpdCB3aWxsIGJlIGEgaHVnZSBjaGFs
bGVuZ2Ugd29yayBmb3IgdXMuDQo+ID4NCj4gPg0KPiA+IFRoYW5rcw0KPiA+IE1pbmcgQ2hlbg0K
PiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IFRvbSBQc3li
b3JnIDxwb3plZ2EudG9taXNsYXZAZ21haWwuY29tPg0KPiA+PiBTZW50OiBTYXR1cmRheSwgTWFy
Y2ggMjEsIDIwMjAgMTE6MTYgUE0NCj4gPj4gVG86IE1pbmcgQ2hlbiA8TWluZy5DaGVuQHdhdGNo
Z3VhcmQuY29tPg0KPiA+PiBDYzogbGludXgtd2lyZWxlc3MgPGxpbnV4LXdpcmVsZXNzQHZnZXIu
a2VybmVsLm9yZz4NCj4gPj4gU3ViamVjdDogUmU6IEZpcm13YXJlIENyYXNoZWQNCj4gPj4NCj4g
Pj4gY2FuIHlvdSB0cnkgdG8gYm9vdCBpdCBpbiBhbm90aGVyIGRldmljZSBhbmQgdXNpbmcgc29t
ZSBkaXN0cm8gdGhhdA0KPiA+PiBoYXMgNC4xOSBvciBsYXRlciBrZXJuZWwgd2l0aG91dCBiYWNr
cG9ydHM/DQo+ID4NCj4gDQo+IE15IHN1Z2dlc3Rpb24gaXMgdG8gdHJ5IGl0IGluIHg4Nl82NCBQ
Qy4gVGhlbiB5b3UgY2FuIGp1c3QgdXNlIGxpdmUgbGludXggZGlzdHJvDQo+IHdpdGggZGlmZmVy
ZW50IGtlcm5lbCB2ZXJzaW9ucy4gSWYgaXQgZG9lcyBub3Qgd29yayB3aXRoIGFueSBvZiB0aGVz
ZSB5b3UgbWF5DQo+IGhhdmUgcmFuIGludG8gYSBodyBidWcgc2FtcGxlLiBJZiBpdCBkb2VzIHdv
cmsgdGhlbiB5b3UgZG9uJ3QgbmVlZCB0byB1cGRhdGUNCj4geW91ciBQUEM2NCBrZXJuZWwgYnV0
IGZpbmQgYW4gYXJjaGl0ZWN0dXJlL2RldmljZSBzcGVpZmljIGJ1ZyB0aGF0IHByZXZlbnRzIGl0
DQo+IGZyb20gbG9hZGluZy4NCg0KW01pbmcgQ2hlbl0gDQpUaGFua3MgZm9yIHRoZSBzdWdnZXN0
aW9uLiBJIGRvbid0IGhhdmUgYSBQQyB3aXRoIFBDSWUgc29ja2V0IG9uIG15IGhhbmQsIGJ1dCBp
dCdzIGluZGVlZCB3b3J0aCB0byBoYXZlIGEgdHJ5LiBJIHdpbGwgdHJ5IHRvIGZpbmQgYSBvbmUu
DQo=
