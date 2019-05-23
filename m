Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE8D428981
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2019 21:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390422AbfEWTjQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 May 2019 15:39:16 -0400
Received: from mail-eopbgr800070.outbound.protection.outlook.com ([40.107.80.70]:22160
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390036AbfEWTjP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 May 2019 15:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsczeKVXu7v4uwo1knYrfK0hpL7B4h9of8YB5VBV2cg=;
 b=oSBCSxZAU4y8BxFW7plYGZWbnyBS96CN6Mm9NOh5KmEoGDmRY4ILFHLzo2NJAnTB/YB2PLC4tGqdAVJjbdUsr4er6wMcNPTrupeFCFxmS6JJlK1ZokU/JuZ8iQ1EGN83j5YOExxKuEdyXvrBDP5dKFqqRCMz2vJTe8akBvSrYYM=
Received: from BYAPR05MB4039.namprd05.prod.outlook.com (52.135.199.27) by
 BYAPR05MB6325.namprd05.prod.outlook.com (20.178.197.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.8; Thu, 23 May 2019 19:38:58 +0000
Received: from BYAPR05MB4039.namprd05.prod.outlook.com
 ([fe80::1927:46bb:540f:52e]) by BYAPR05MB4039.namprd05.prod.outlook.com
 ([fe80::1927:46bb:540f:52e%5]) with mapi id 15.20.1922.013; Thu, 23 May 2019
 19:38:57 +0000
Received: from BN6PR05MB3602.namprd05.prod.outlook.com (10.174.94.152) by
 BN6PR05MB3315.namprd05.prod.outlook.com (10.174.95.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.13; Thu, 23 May 2019 19:26:27 +0000
Received: from BN6PR05MB3602.namprd05.prod.outlook.com
 ([fe80::15ce:7d92:fb99:53]) by BN6PR05MB3602.namprd05.prod.outlook.com
 ([fe80::15ce:7d92:fb99:53%7]) with mapi id 15.20.1922.016; Thu, 23 May 2019
 19:26:27 +0000
From:   Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
To:     Jonas Gorski <jonas.gorski@gmail.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Andrey Shevchenko <ashevchenko@quantenna.com>
Subject: Re: [PATCH v2 2/2] qtnfmac: add support for Topaz chipsets
Thread-Topic: [PATCH v2 2/2] qtnfmac: add support for Topaz chipsets
Thread-Index: AQHUZTpbxq0LvcBgsU2PEW0QVFkG+KZyexGAgAf1SwA=
Date:   Thu, 23 May 2019 19:26:27 +0000
Message-ID: <41b4f41f-37ae-ef5f-476c-eb616d6a3da1@quantenna.com>
References: <20181016102349.26544-1-sergey.matyukevich.os@quantenna.com>
 <20181016102349.26544-3-sergey.matyukevich.os@quantenna.com>
 <CAOiHx=nBWr4GNh61WV+SAY-++Z6es-HX3_pd70DB_N33bVK1tw@mail.gmail.com>
In-Reply-To: <CAOiHx=nBWr4GNh61WV+SAY-++Z6es-HX3_pd70DB_N33bVK1tw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:a03:114::19) To BN6PR05MB3602.namprd05.prod.outlook.com
 (2603:10b6:405:3d::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=igor.mitsyanko.os@quantenna.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.131.200.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f2b57b1-f77e-43fb-77e1-08d6dfb48d00
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BN6PR05MB3315;
x-ms-traffictypediagnostic: BN6PR05MB3315:|BYAPR05MB6325:
x-moderation-data: 5/23/2019 7:38:56 PM
x-microsoft-antispam-prvs: <BYAPR05MB6325B9422834E4691D3E6A54B0010@BYAPR05MB6325.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(136003)(376002)(366004)(346002)(189003)(199004)(386003)(4326008)(5660300002)(6506007)(14454004)(66066001)(6512007)(107886003)(86362001)(478600001)(36756003)(6436002)(53936002)(6486002)(99286004)(76176011)(102836004)(31686004)(4744005)(6246003)(52116002)(316002)(8936002)(7736002)(81156014)(81166006)(186003)(229853002)(8676002)(305945005)(3846002)(6116002)(256004)(54906003)(110136005)(71200400001)(71190400001)(26005)(68736007)(73956011)(66476007)(486006)(66946007)(476003)(2616005)(25786009)(446003)(436003)(64756008)(66556008)(11346002)(6636002)(2906002)(66446008)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6325;H:BYAPR05MB4039.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /Qm2H19sHRTSm3DaTo59KNweT/68Ys5aSAuKzA8MRvtlyP4eEA4IU+tFZCPRDLuwT9de3XoNn2BRorjqUfU7wX9LylAOpCkjFQyh41uL/mIeIABfM/7G4aWTQcSilVVbTBg+Am4zUaFlURKwiX0EQDItyW0iUc+62yqMpJMxbXKqh4D9YjMf+EX+x63FHgt8oGX/pivQ1lBwo3VKsREQcqG/eJuDN4giW9wFBcNjIRnI8mLiCUFMy4eOn8Kkz20v6K1tkOv7WezC3eTU1AB5umAK3ZkXUshKBcVWQMJh+ml35C/Q/yzznaHWXGKvnwXQLZUBg+0zNdFe+9b4PuGp9EGfyfGrBKTBU69IvnP+NAZNYUb4TXbej3Upg0u4ELARFQ3+91rcOlfwhsdswv+AxpaFoUSVa0SoTKKTwDp1dzw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0600C119F93D564D8814883B55E1D230@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2b57b1-f77e-43fb-77e1-08d6dfb48d00
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CompliancePolicyCacheOneDriveRetention@quantenna.onmicrosoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 19:38:57.6761
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6325
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IA0KPiBBIGJpdCBsYXRlIG9mIGEgcmV2aWV3L3F1ZXN0aW9uLCBidXQgaG93IGRvZXMgb25l
IG9idGFpbiBvbmUgb2YgdGhlc2UNCj4gZmlsZXM/IFRoZXJlJ3Mgbm90aGluZyBpbiBsaW51eC1m
aXJtd2FyZSwgYW5kIEkgc2VlIG9ubHkgb25lIGFib3J0ZWQNCj4gYXR0ZW1wdCBmb3IgYWRkaW5n
IGZtYWNfcXNyMTBnLmltZyBmcm9tIDIwMTYsIGJ1dCBub25lIGZvciB0aGUgb3RoZXJzLg0KPiBT
ZWFyY2hpbmcgZm9yIHRoZXNlIGZpbGVuYW1lcyBhbHNvIGRpZG4ndCByZXZlYWwgYW55IGV4dGVy
bmFsDQo+IGxvY2F0aW9ucy4NCj4gDQo+IA0KPiBSZWdhcmRzDQo+IEpvbmFzDQo+IA0KDQpIaSBK
b25hcywgd2UncmUgd29ya2luZyB0b3dhcmRzIGEgc2Vjb25kIGF0dGVtcHQgdG8gZ2V0IHRob3Nl
IGFjY2VwdGVkIA0KdG8gbGludXgtZmlybXdhcmUgKGZtYWNfcXNyMTAwMC5pbWcgYmluYXJ5IGZp
cnN0KSBhZG1pdHRlZGx5IGl0IHRha2VzIHVzIA0KYSBsb25nIHRpbWUgdG8gZG8gdGhhdC4gVGhl
IG1haW4gb2JzdGFjbGUgZm9yIHVzIGFzIGRldmVsb3BlcnMgaXMgdGhhdCANCnRoZSBiaW5hcnkg
Y29udGFpbnMgMy1kIHBhcnR5IEdQTCBjb2RlIHNvIHdlIGhhdmUgdG8gd29yayB3aXRoIG90aGVy
IA0KZGVwYXJ0bWVudHMgdG8gc2F0aXNmeSBhbGwgc3VibWlzc2lvbiByZXF1aXJlbWVudHMgKHBy
b3ZpZGUgc291cmNlcywgDQpwcm9wZXIgbGljZW5zaW5nL2F0dHJpYnV0aW9uIGV0YykuIEZyb20g
YSBmYWlsZWQgZm1hY19xc3IxMGcuaW1nIGF0dGVtcHQgDQppdCB3YXMgY2xlYXIgdGhhdCBzaW1w
bHkgcHJvdmlkaW5nIGFuIGNvbnRhY3QgZW1haWwgaXMgbm90IGVub3VnaC4NCg0KV2UncmUgcGxh
bm5pbmcgYSBzZWNvbmQgYXR0ZW1wdCB0byBzdWJtaXQgZmlybXdhcmUgYmluYXJ5IHBhdGNoIA0K
cmVsYXRpdmVseSBzb29uLCBmb3Igbm93IHdlIGV4cGVjdCBkZXZpY2Ugd2lsbCBib290IGZyb20g
Zmxhc2guDQo=
