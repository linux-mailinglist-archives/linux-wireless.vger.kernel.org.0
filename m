Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E065138EE8
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2020 11:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgAMKTq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jan 2020 05:19:46 -0500
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]:46272
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbgAMKTp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jan 2020 05:19:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIHNQs6+QXE2A/CjdsP87vawP1naG+kVAkbsAQW4kctKhlzP8psJVEwYuTmQ4AO4h85HVGtKKqcDHBRIIUfVc72zVEUuERbF4herIh1ggAyOsyfTZTZzO9Zr94jREkDOOcHF0QgCafddZKbUf6uBmmCrhcr31Rhch24yKql35Jv3KBw2q3PVYR3AIoRX6GftJv5IoD6JTVAsdIqvTJwQrGHRFvPUzDX1O1/K7yYZa0lXHsiJSZIJa3UruA5rDeNoufGbjV+IWGU7MnJSTv8sx1tXrtK7utH0PUE/t0sktDYOiQaEqXcrssRWgwJK4UYQIG/+J6JUqBOH9s8nH5GtLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0u8TCZMg2cdFeUq22OX5w/J4cpCrE5KROtzXkw5OGp0=;
 b=X/KvJBaCM4WM3ktfVgePbAy1zGCgLbIHkC5TOtM8B1OScTsMl7J8keLwPUP2DF5heYN1Ux04L4CQaU8Lt9pYRo/XftmtPCOetV5JU6Pql8VN0IIShUwuE4MU7tU2TlFN44Je6bBY5TtbQUD6mUwvUtAUwkB4dTp9TIQPbSs1AQzxCMq2DOpagmY9g0y8F9ADkVMvbbdxc1f1jzG2SxoLi4NTCwVWPakXg7QTE1lBUlMbpc31aoBrXDhfEa0n2i19iAHxGKFZxcJB3li/irArYtnWhoFi+5uzvaQAdRkJIVCurEuq6gEa00uq0DDo27k6UyN3P9xZAcmVVdupnHwqbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0u8TCZMg2cdFeUq22OX5w/J4cpCrE5KROtzXkw5OGp0=;
 b=snJouT/Z+cU7MCXpXYa+aCYfxSf14yybwYNTQmqNBhyZSQWQSsQPr37YhO85WQs6kE412fH7wB6qqAepvWc/YMwQbrapo3kLvrZnSm0o991T7r+LJSrugspoFuSuKEMtBNFclRcNiXoptCwk4Vp/x1UcEHgUrLQ0ky6u4SqrMQw=
Received: from DB7PR04MB5242.eurprd04.prod.outlook.com (20.176.234.25) by
 DB7PR04MB3963.eurprd04.prod.outlook.com (52.134.109.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 10:19:41 +0000
Received: from DB7PR04MB5242.eurprd04.prod.outlook.com
 ([fe80::bce1:71a5:299f:f2ff]) by DB7PR04MB5242.eurprd04.prod.outlook.com
 ([fe80::bce1:71a5:299f:f2ff%7]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 10:19:41 +0000
From:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Cathy Luo <cluo@marvell.com>,
        Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Rakesh Parmar <rakesh.parmar@nxp.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Sachin Shelke <sachin.shelke@nxp.com>
Subject: RE: [EXT] Re: [PATCH] MAINTAINERS: update for mwifiex driver
 maintainers
Thread-Topic: [EXT] Re: [PATCH] MAINTAINERS: update for mwifiex driver
 maintainers
Thread-Index: AQHVxULra7xFx8PUQkCYPtEHbpzs06foamU5gAAAtiA=
Date:   Mon, 13 Jan 2020 10:19:41 +0000
Message-ID: <DB7PR04MB524269A0B4F3EB920DDA4E898F350@DB7PR04MB5242.eurprd04.prod.outlook.com>
References: <1578391915-3960-1-git-send-email-ganapathi.bhat@nxp.com>
 <87sgkj1x2g.fsf@tynnyri.adurom.net>
In-Reply-To: <87sgkj1x2g.fsf@tynnyri.adurom.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ganapathi.bhat@nxp.com; 
x-originating-ip: [92.121.64.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c336b90f-1347-408b-59cf-08d798121a6f
x-ms-traffictypediagnostic: DB7PR04MB3963:|DB7PR04MB3963:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB3963880B45AEB8D75A0E10C58F350@DB7PR04MB3963.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(4744005)(54906003)(33656002)(66446008)(71200400001)(76116006)(316002)(64756008)(66946007)(66476007)(66556008)(6916009)(478600001)(2906002)(26005)(86362001)(9686003)(44832011)(55016002)(186003)(8676002)(8936002)(7696005)(15650500001)(4326008)(81166006)(5660300002)(81156014)(52536014)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB3963;H:DB7PR04MB5242.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TVhEzHyJ0A14a3fXPEic8qgAWRkdaPKgfErrB5q1XzMa9TDmJH4Q6w1+L2ytO1wTOUUA790CWOLQpVK02o4JrcPSQNDQU7R25d1OhN12rev3XPgiEdRAQyw3xklF6AgSM9knknu3GM8YQjoavu31G3c7e4gvI06I7V8C7+oO7u5oxs7xUJJztnYSKd3pf4UKBdf4JlMbLaTL3gIi/T/lAfzkY4PmQR5X/meP/gkvDORpdJAAJBS+pn6sxAtnVBcLxVGSisK87abHLn7gQ1g8wFe3y7aaCiRCqcGoN+aGUsEGXjguA7JVAMEdnb07VWupe/1TWZJj3265DBfM5B02TfKQ47knyfBQ2mMaGnC2jWHj4q/a3nCIwGizNLRtKxZsZjIY6ODQrC/wUMaYAJxa6pBoE0Z//sErk22g3tmYRzUK+RqWUsVVvnhyYI+U4BOO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c336b90f-1347-408b-59cf-08d798121a6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 10:19:41.5183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 57+U5pM41UaFLJn6G7SdiVuNz5vxB0vooN2Zq73/rC8MBpMtYoIZSGyKhcUxJoKG9fAeQlIuwm3W3r0AVqe31w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB3963
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

> >  MARVELL MWIFIEX WIRELESS DRIVER
> >  M:   Amitkumar Karwar <amitkarwar@gmail.com>
> > -M:   Nishant Sarmukadam <nishants@marvell.com>
>=20
> What about Nishant, you don't mention anything about him.

OK, I will remove it and update the change.
>=20
> > +M:   Rakesh Parmar <rakesh.parmar@nxp.com>
> >  M:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
> > +M:   Sharvari Harisangam <sharvari.harisangam@nxp.com>
> > +M:   Sachin Shelke <sachin.shelke@nxp.com>
> >  M:   Xinming Hu <huxinming820@gmail.com>
>=20
> I think there are too many maintainers now. There should be just one or t=
wo
> maintainers per driver, not six. Maintainer is a different role from a pe=
rson
> actively working on the driver.

OK, sure.

Regards,
Ganapathi
