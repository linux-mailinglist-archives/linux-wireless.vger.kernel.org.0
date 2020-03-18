Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F950189DC2
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2020 15:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgCROZg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Mar 2020 10:25:36 -0400
Received: from mail-vi1eur05on2074.outbound.protection.outlook.com ([40.107.21.74]:1088
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726730AbgCROZf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Mar 2020 10:25:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzgWLZnoTXDkSOdTxH3mAkwQiOKnEcfmicDuH37jP9CeG40YJTY3Vmo7o8pqySELazb+4ccKysxizoDx5NvM1ROZZgA2Y7kFMSphPkqFHFbk8EE7NXDBxkxudb4J53Qj3utBO4K89GQGmn/n8E1dabr78yR081GPMB1OkIfgBkeXk8v0nxMnBspSVqUFHK4ghpV64KrjFVDFEvZYKAUMcvIUXgP0DKUyqL6js4w2zjsIqYlxp51OXXMVHBqgwtWWDBdVnc4qxbvM9x05VWYMwY5QckH6VUa+vdcy70v3csOffk3E70oHpLHFdQeEZJ//IsQ2q+mzs6EZH4FCnAhpEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6HeLJ53CxD9633odJinRZFe2ssu8XVJLLg3jmXGaSQ=;
 b=SLaXqreu2+gzdZ2f1VSZAbeAJKNGFWP/77BXVIsmcNBSCqxMaU2eSyAWk8wuGyvFW2fV6j/FTjjJ02SSHdyUa4OVDDg0jqvlHrDsQG0ydIJGOmMdBi1TkI37j+WpE1HLBrQrizcKFBBqKd7WFLmOlNGoswLsxyEnR7KfnKbm41E3aWlF5oGDnWYl7ZzxXCJO8m+Zd5fbCMrgJssKZo7rZECm8YoPxPVDYbmhbl+6cyLVpOQnEiJWen8WyqkINuC3sJih1uUYN+HFBdIjkCMKfOYEqSO3dVW1vVOsIwsWexgm00JQY5o2uVqVwPw2NEdd2dHHG9/+qhxwclEdSIDYqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6HeLJ53CxD9633odJinRZFe2ssu8XVJLLg3jmXGaSQ=;
 b=NOzKBSwRdlp0Q+ysy2CKhiqinCgsVU2tiPthVgi2HrBfqPbC7U8Hw5meX4xjSrqSY6h54oy9HBx5i2RrBtZ4iFa6BBbzoEUEPiJYgLztqM8aSq7ov/YEExXn1h2+gxBx8G/6TKl0QmopVf6lALyUrUpIHFIj75/dU6uEGOwxdxQ=
Received: from DB7PR04MB5242.eurprd04.prod.outlook.com (20.176.234.25) by
 DB7PR04MB4522.eurprd04.prod.outlook.com (52.135.138.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Wed, 18 Mar 2020 14:25:32 +0000
Received: from DB7PR04MB5242.eurprd04.prod.outlook.com
 ([fe80::5467:de53:6e5f:8692]) by DB7PR04MB5242.eurprd04.prod.outlook.com
 ([fe80::5467:de53:6e5f:8692%3]) with mapi id 15.20.2814.025; Wed, 18 Mar 2020
 14:25:32 +0000
From:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
To:     Brian Norris <briannorris@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
CC:     Amitkumar Karwar <amitkarwar@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: [EXT] Re: [bug report] wireless: mwifiex: initial commit for
 Marvell mwifiex driver
Thread-Topic: [EXT] Re: [bug report] wireless: mwifiex: initial commit for
 Marvell mwifiex driver
Thread-Index: AQHV/IJAQVQtkEHJM0iCqvFWOg5T0KhOZ/4Q
Date:   Wed, 18 Mar 2020 14:25:32 +0000
Message-ID: <DB7PR04MB52429DE16439F690857070A78FF70@DB7PR04MB5242.eurprd04.prod.outlook.com>
References: <20200317091837.GA18001@mwanda>
 <CA+ASDXP80wMrWyc+WZNoGt=DK0EjFjNSjqCi4NGpJgc1mGK3sg@mail.gmail.com>
In-Reply-To: <CA+ASDXP80wMrWyc+WZNoGt=DK0EjFjNSjqCi4NGpJgc1mGK3sg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ganapathi.bhat@nxp.com; 
x-originating-ip: [115.112.95.158]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6334957b-0df5-4fe0-7cbd-08d7cb483755
x-ms-traffictypediagnostic: DB7PR04MB4522:
x-microsoft-antispam-prvs: <DB7PR04MB45228A6D1A4DB4E13C79A09A8FF70@DB7PR04MB4522.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(199004)(2906002)(52536014)(55016002)(71200400001)(33656002)(5660300002)(9686003)(4744005)(186003)(81156014)(8676002)(8936002)(81166006)(316002)(54906003)(55236004)(4326008)(44832011)(110136005)(86362001)(66556008)(76116006)(6506007)(66446008)(66476007)(66946007)(64756008)(478600001)(26005)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4522;H:DB7PR04MB5242.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6bYnocWtaqJvqbf/CkRKn2ESfG92vmSBtPvORJ81lrb45GCkc2MOXmlyBjV6EmMSgvKCdCxqm+J9FPr6dyOj2iMJQm7FOjBeEcuj+jGo95sDzuy5JLgF2JqQ5HUon9WsfrzrnFR5bcLkrVp5jUDqw3wFSoqdKam+8bFwd74CpMOvXLpxSViKETNF7udSpc2JxSrZKBmsDR8iswbPjfn9pGoPt7dVmPlQWHhgwcidzK7D9+T3k6kHx20XP1QK2vRQB6He4bXoRdlky9nTTrmTH9S7al0RM6VzqJK8GhvvVGCJGZlCf0TJDZDQjQkFDyWPVX8ryFj6SFBB3gSuCq5S4UT0D5xABY0ScY2I5fCL0LXWdenttH4AdALFq1OwaU4VpGG52MIKBagjvfZ5xXq65wXcdkVoHvDQHqHVYp1oURZ5Fy0tvyikvlUh5MF2TmgQ
x-ms-exchange-antispam-messagedata: H0YQGWpXkzkV9XbQQw8bvYQkWH+mYFM1yfHorlgEzivPweorgr/ttWbYtC4dwCjRuRDhQFRC/imCE2DTLUyjnYfh/E6wBT1A+oJU7uQGGc6si+J56JHWfpWaSoKPNb98Cnun+xT2QeCEvQQ55lWUYQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6334957b-0df5-4fe0-7cbd-08d7cb483755
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 14:25:32.1568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fit5LBq824zhsiLoXTf7AM2ETCeiU6FZMIa4pCx5Aa/OlgQ3LHlqgQzJ8hSUApDdEFijMMtGzDv6KASXlfUTdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4522
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgRGFuL0JyaWFuDQoNCj4gICAgNDk1ICB2b2lkIG13aWZpZXhfMTFuX2RlbGV0ZV90eF9iYV9z
dHJlYW1fdGJsX2VudHJ5KHN0cnVjdA0KPiBtd2lmaWV4X3ByaXZhdGUgKnByaXYsDQo+ICAgIDQ5
NiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgbXdpZmlleF90eF9iYV9z
dHJlYW1fdGJsICp0eF9iYV90c3JfdGJsKQ0KPiAgICA0OTcgIHsNCj4gICAgNDk4ICAgICAgICAg
IGlmICghdHhfYmFfdHNyX3RibCAmJg0KPiAgICAgICAgICAgICAgICAgICAgICBeXl5eXl5eXl5e
Xl5eDQo+IENoZWNrIGZvciBOVUxMDQo+IA0KPiAgICA0OTkgICAgICAgICAgICAgIG13aWZpZXhf
aXNfdHhfYmFfc3RyZWFtX3B0cl92YWxpZChwcml2LCB0eF9iYV90c3JfdGJsKSkNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXl5e
Xl5eXl5eXl5eXiBXaGljaCBpcyBwYXNzZWQgdG8gaGVyZS4gIFNvDQo+IG1heWJlIHRoZSBOVUxM
IGNoZWNrIGlzIHJldmVyc2VkPw0KDQpJIHRoaW5rLCBpdCBzaG91bGQgaGF2ZSBiZWVuIGxpa2Ug
YmVsb3c6IA0KDQppZiAoIXR4X2JhX3Rzcl90YmwgfHwgIW13aWZpZXhfaXNfdHhfYmFfc3RyZWFt
X3B0cl92YWxpZChwcml2LCB0eF9iYV90c3JfdGJsKSkgLiAuIC4gDQoNCg0KUmVnYXJkcywNCkdh
bmFwYXRoaQ0K
