Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D850207043
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2020 11:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389736AbgFXJmS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jun 2020 05:42:18 -0400
Received: from mail-eopbgr150070.outbound.protection.outlook.com ([40.107.15.70]:21014
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388005AbgFXJmS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jun 2020 05:42:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVyXlC72oEOAJpMq4hJHy2T3zdYNlQNuchc9byVItdRP+Mh6sycU27Jyobd6sdj258cNwzUGA82d2PMpb0UMB9r3ETiJEYjbCEgP76YjiJ4Ch5y+S8lPNg998e7tDlNFvv7CUrAIeEPZFXkyrZvZC5poJpZuzXWPbBFC4X4XrdUjaarGSeilVZp0mRKqK/te4kkQeC9llS4b11oqBzESNUKyUXkKLfV36xP0OU+FNRr7La5IhRUwFMDMhJVUmV45FhyO+NPQsXUAiY4F9mFCLGldMNA+Ab791luwbO8Xf5NcJ6t2aCPW53AO2Gvca/jL4wlr435GsYGuJN+RfLucPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eijbQIHE5obPQu13PPhCctgjYrSEfmyN7CSUEBUNi/Q=;
 b=LJGKB5ZrD6fbxn7xDrEM5u3x3vwCBn9hYI/aKyHEZijG/1MNZh6xcd+sMi9rvWor6+fjLTnyRm+maGpHp6M5i7WdW/GRV1gQql8klHyfdmMLqdL61pqSZP1GmnDX50SG7YwR/swmUset0KLabDeFwoWBnkH/CAvdYbdLKPQwXFQYd1E5Da8k73yyMVw1hMOunMiJRiS4FnJytDSdJ+JW4wt9e5SzKVOk2MXP1zgwNS4NL2zScbiAhDvG97zXXlWTUXEUoMSHC8wGCJZq+JEW/d1HwWKDOndwXBh6C8DJKTYby6A9U1ORUSXtbaF+1vPMYSx3eqmJ4YQ1pVtHG5fNsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eijbQIHE5obPQu13PPhCctgjYrSEfmyN7CSUEBUNi/Q=;
 b=ZJ+x6Lm39uj+GCSRQV9jjbT7e8JYyWE22nf8Nq7JVDTC66XK9JZglrVVvvwxD3p7FaCgpWuYLPdvxCTRTlznnDl+uanHXDIMYqeoyMVgYMLCQmU5DqzdrAvQKk0eIjU5ZMdvoB3VXLwLXV19m1evnfC3sSyO6+twth8sJWT3EaQ=
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com (2603:10a6:803:3d::27)
 by VI1PR04MB6974.eurprd04.prod.outlook.com (2603:10a6:803:133::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 24 Jun
 2020 09:42:14 +0000
Received: from VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09]) by VI1PR04MB4366.eurprd04.prod.outlook.com
 ([fe80::8102:b59d:36b:4d09%7]) with mapi id 15.20.3131.021; Wed, 24 Jun 2020
 09:42:14 +0000
From:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
To:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>
CC:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        =?utf-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] mwifiex: Firmware name for W8997 sdio wifi chip
Thread-Topic: [EXT] mwifiex: Firmware name for W8997 sdio wifi chip
Thread-Index: AQHWKrwXtO/N2oQua0+uJ10PPhSg4aiqXxHQgBMCnACAAXIN0IAAAhkAgAAAaZCAAAIiAIAAA9TggAAAzoCAH6fKgIAJPHlw
Date:   Wed, 24 Jun 2020 09:42:14 +0000
Message-ID: <VI1PR04MB4366C3866EB8D2CD2A8A08E38F950@VI1PR04MB4366.eurprd04.prod.outlook.com>
References: <20200515132353.vfor7v4buzoddfmb@pali>
 <VI1PR04MB4366625917BB57695BE454448FBA0@VI1PR04MB4366.eurprd04.prod.outlook.com>
 <20200528103432.irmsaaz72x3xophg@pali>
 <VI1PR04MB4366409B8E293A265851DA948F8F0@VI1PR04MB4366.eurprd04.prod.outlook.com>
 <20200529084630.j7rpdypt6vycsedh@pali>
 <VI1PR04MB4366DECFA1EB5C3D6AADB0818F8F0@VI1PR04MB4366.eurprd04.prod.outlook.com>
 <20200529085536.zivf36mn2d6zx5ii@pali>
 <VI1PR04MB43663ACEAADB7ADD1EB7572D8F8F0@VI1PR04MB4366.eurprd04.prod.outlook.com>
 <20200529091211.vx2godj5zirsptam@pali> <20200618123647.axx7wtlclgs333k5@pali>
In-Reply-To: <20200618123647.axx7wtlclgs333k5@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [115.112.95.158]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 11db65af-3af2-40ee-8c72-08d81822e095
x-ms-traffictypediagnostic: VI1PR04MB6974:
x-microsoft-antispam-prvs: <VI1PR04MB69746B865853DF01A82C453B8F950@VI1PR04MB6974.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SbwADqBYHWbVwUkpDE+8NJrdIdWcjKgTFj1qQnPqWf5sIgocLlwLOICpBkPMuz2lpNC92J2TdLpkA931aGBAHIYeZ6UkgNxFEUGJRZo5eA3lIfFGtoBgkovgTp4jzFLT/2SvoUFnolXCYzaDKRJP2TpV+W9KkVBuW33TG96yyVt1dtCA4+iUAlg3FYku1x6/SH5rHyNu2/xQ2dJUbkMDko0TZdGMhzR8o6zICMtSYTmOTE5iWZi68Dn1Nmtzj1z7DxQRJv08+tbxivcXfiNQGfrGc89Bxw9zmH5cQiSFTQRrs5EyAD0aFJ4j3Kim8M9a4EJIYU3V9iDnpvIb79cNqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(66446008)(64756008)(66946007)(66476007)(8676002)(44832011)(33656002)(4326008)(478600001)(8936002)(76116006)(83380400001)(2906002)(186003)(26005)(55016002)(6506007)(4744005)(55236004)(5660300002)(52536014)(66556008)(6916009)(7696005)(9686003)(316002)(54906003)(71200400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xWfjW7HSwP+vzNJTkFn3OnQAZoz1Q7o9KuCrQ9RVGR8OGbwjPP5YQlWWfeTdvnDrAa7ZemKPsx+K8amJL28iKG3OHwhhYCHApR2y8yJHKhFQfqf65oEJ/9SoV6gLmo+6eNaeSkML4vrbT7Za7f5lLMVU9I29i1pVWqd/kLra67wHtxWjcsLdEHXQ8LAlK6KhtsCoX/gtq1smvO9yOYBA8oFUtpBmyGCyeN0aJT3bxAySM7eN4+RiQJaSSyZtpwfdOiub01keagBG5cVXBCrPpLh4QLeBUnyZACItmLqmn8IEAByzYYBSa+ZCWDmabNDdBsxCLjZGBSIqkCKc95oyNOpYg86/qQ/rNa9NSxEEAKs4cCZ+EmhNRgoegoP7kXWpKME/Nmf6Sh6OyNqlb9xYz1EYyirtXEikfb0JH6H2m7ReIlKDWC2kZ3Y4uc3rvOB5PTBWxOqUrD8g/rIT9sOwWB1tNr16vJio/NN5Iy3sxtCyLh04hUErCUNrL5q62S3c
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11db65af-3af2-40ee-8c72-08d81822e095
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 09:42:14.7627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /lzsbyXbEfpdDiJUG2LW5Uk8KWrHRk1X+e7gSgGvuIxppcabEcRfZNW/+10qhS1bmFCcHXRVttBn4WiSDeODCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6974
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgUGFsaSwNCg0KPiA+ID4gPiBIZWxsbyBHYW5hcGF0aGkhIFNlZW1zIHRoYXQgb24gYm90aCBs
b2NhdGlvbnMgaXMgb2xkZXIgdmVyc2lvbiBvZg0KPiA+ID4gPiBzZHNkODk5N19jb21ib192NC5i
aW4gZmlybXdhcmUsIG5vdCB0aGUgbGF0ZXN0IG9uZS4gT24gYm90aA0KPiA+ID4gPiBsb2NhdGlv
biBpcyBhdmFpbGFibGUganVzdCB2ZXJzaW9uIDE2LjY4LjEucDE3OS4gQnV0IHdlIGhhdmUgbmV3
ZXINCj4gdmVyc2lvbiAxNi42OC4xLnAxOTcuDQoNCldoZXJlIGRpZCB5b3UgZmluZCBwMTk3LCBr
aW5kbHkgbGV0IG1lIGtub3cgc28gdGhhdCBJIGNhbiB0cnkgdG8gZ2V0IGl0J3MgZGV0YWlscyBh
bmQgdXBzdHJlYW0uDQoNCj4gPiA+ID4gQ291bGQgeW91IHBsZWFzZSByZWNoZWNrIGl0Pw0KPiA+
ID4NCj4gPiA+IHAxNzkgZG8gaGF2ZSB0aGUgZml4IGJ1dCB3ZSB3aWxsIHRyeSB0byB1cHN0cmVh
bSBwMTk3IGFsc28gc29vbi4NCj4gPg0KPiA+IFRoYW5rIHlvdSENCj4gDQo+IEhlbGxvIEdhbmFw
YXRoaSEgRG8geW91IGhhdmUgYW55IHVwZGF0ZXMgYWJvdXQgdXBzdHJlYW1pbmcgbmV3IGZpcm13
YXJlDQo+IHZlcnNpb24/DQoNClJlZ2FyZHMsDQpHYW5hcGF0aGkNCg==
