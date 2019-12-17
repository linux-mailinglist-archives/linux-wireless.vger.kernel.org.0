Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE9512340D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 19:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfLQSBF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 13:01:05 -0500
Received: from mail-eopbgr10053.outbound.protection.outlook.com ([40.107.1.53]:21988
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727711AbfLQSBF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 13:01:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOm47wYlISttheIk1pgUwsbF5TQNMbjhAkWB/9xiKLl3VUNZ5IjSJK10V/6/fxYKNlyHsS0gGnvemwYbgjid8ow4XaLSukqcTuZUS8Q/BMU7sU0tns3RQsGDu02afoCGVjMlTdHt9baMEWsh7sVllalSKnCWlSNRCKKJeHa2WsEQlKyAAqMa5wu+ULOoCaP4VB6g5MlAENKydQf9pQ2kPDpa5/FgGVQNqDnhaqLGuIbD+6bGa21+VslLW4xgpY+imlPikjb8KzJoLQxG84knDZdt6aXhvTPp8Aj4BTAe1pp6hQUmdLZB+AUl8Y/L3W6UPRyeH3/VniaCFtooeK1d+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWFgk+69cML9KeALSiXcvsQWjj1naG4dE3dkrsJDyEM=;
 b=VrJXZaNg/xSzrbWtnD2Qn9jXOhD90bXOtqTuNTp4EYtScoGW0r4IckAuLIGLhaglIn6X0Dklog5aux2LTuN8S6MEbYV50G0bxbBsZyBimHULjJP8tg8CYX0m4+4usiv/2cKHwOAs3uLGsRGwPZkZxdSZxvLIezxdzjDcwe8YmEX0DzdGdnC/FUDfb9TCsCujf/8gXvheElwPT9t5iyenpEIZBXTrp1/uzsaezCdVOAKAs4gcGOoPRIw+AL3ws7xib2jTY+3fkal4ZV1H0djenCCnMX0MmEnnueXnIzxItY4ofrryNGCxzhDzM3YQBT8IAB9V0QgTZtkfTUftR0gIBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWFgk+69cML9KeALSiXcvsQWjj1naG4dE3dkrsJDyEM=;
 b=Sd81JrOs5CBpO72+RSGYhA2yMTSJYFTK2rSfvyTn4ZHwD7zXykAgIinxmX1hI8Azw5xium6df4nmXAvzfWtxepcQBF02euiCNetQhWmSgU8PFcd7RXhqQ/OFHgXPEfewvG9FhAtoABdg2pZJPwUHuGw5lQ+MNyQA3zh27XKtJ9A=
Received: from DB7PR04MB5242.eurprd04.prod.outlook.com (20.176.234.25) by
 DB7PR04MB4762.eurprd04.prod.outlook.com (20.176.233.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Tue, 17 Dec 2019 18:01:01 +0000
Received: from DB7PR04MB5242.eurprd04.prod.outlook.com
 ([fe80::bce1:71a5:299f:f2ff]) by DB7PR04MB5242.eurprd04.prod.outlook.com
 ([fe80::bce1:71a5:299f:f2ff%7]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 18:01:01 +0000
From:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
To:     Ganapathi Bhat <gbhat@marvell.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Cathy Luo <cluo@marvell.com>, Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Brian Norris <briannorris@chromium.org>
Subject: RE: [PATCH] MAINTAINERS: update Ganapathi Bhat's email address
Thread-Topic: [PATCH] MAINTAINERS: update Ganapathi Bhat's email address
Thread-Index: AQHVsT/qZ1lsTDEbO0+wOSuy9cP136e+pR+g
Date:   Tue, 17 Dec 2019 18:01:01 +0000
Message-ID: <DB7PR04MB5242AD2254A7CB093BEAB6388F500@DB7PR04MB5242.eurprd04.prod.outlook.com>
References: <1575620268-4613-1-git-send-email-gbhat@marvell.com>
In-Reply-To: <1575620268-4613-1-git-send-email-gbhat@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ganapathi.bhat@nxp.com; 
x-originating-ip: [92.121.64.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1c679a2-4b22-4605-75ae-08d7831b1393
x-ms-traffictypediagnostic: DB7PR04MB4762:
x-microsoft-antispam-prvs: <DB7PR04MB47621F9310F33D7170C98B0B8F500@DB7PR04MB4762.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(13464003)(189003)(199004)(66946007)(8676002)(33656002)(66446008)(110136005)(186003)(54906003)(7696005)(52536014)(86362001)(81166006)(5660300002)(15650500001)(26005)(81156014)(6506007)(9686003)(71200400001)(8936002)(76116006)(53546011)(4744005)(4326008)(44832011)(55016002)(66556008)(316002)(66476007)(64756008)(2906002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4762;H:DB7PR04MB5242.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n9KsvRK0oXwr4KZa5qK7V3Urh0SSHZsXT6BOkV+V5B+Sg18Xuf8Q21iJy6NepleOHV/z/ZAOiXYDJtLq2lpm6k2MOWq/oSgFHoTsIkFzjdIYD/ShOMjjXAnlkj2xV1FpGOz62qo6ENurJD/V1d6Rv89hVfIPqNxo/KLhyeHJyUe2wy219dKo5LnGglTQ80Pz3CezLWN1QuF97EMPxKUhCqKzbX6gIEumUE1PpNTQAV8PVJ11FZy193JjYZbHbZzFUSG+SuPsifH+iXWQqiiFbgO9qOEbS9abFs/xj0Fw3h0Wevn22IWjYQci9pHQneWBWPIYqZUkPGZbVKRJnc/eSt/NbUwlrqJwcki5d8mQRZJz8aAn4F4W2GbM0HwK5O4hy1mV6qmOXLoPzD3Lt1AF0qUHWmKolh6Yhyebq0B0PF6U1WLtbwEhtaQS9c+7glJ7E02x4GnSgpc0YLuw1zpmbd3usJWnXno098usMx/etGwvhcCIt8FMMhPFx4uxm0uk
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c679a2-4b22-4605-75ae-08d7831b1393
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 18:01:01.0522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mIjX//u+cr3XIfGhvKT1qurgfaLcggHFmxTOeZvVT0yYgVnBCCjaJzT/DHda84z5UzzRZDNSBHpAF7wLOF7R+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4762
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

Kindly accept the below change in MAITAINER mail ID;

Regards,
Ganapathi

> -----Original Message-----
> From: Ganapathi Bhat <gbhat@marvell.com>
> Sent: Friday, December 6, 2019 1:48 PM
> To: linux-wireless@vger.kernel.org
> Cc: Cathy Luo <cluo@marvell.com>; Zhiyuan Yang <yangzy@marvell.com>;
> James Cao <jcao@marvell.com>; Rakesh Parmar <rakeshp@marvell.com>;
> Brian Norris <briannorris@chromium.org>; Ganapathi Bhat
> <gbhat@marvell.com>
> Subject: [PATCH] MAINTAINERS: update Ganapathi Bhat's email address
>=20
> I'd like to use this email-id from now on.
>=20
> Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7600494..67b5e65 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9821,7 +9821,7 @@ F:	drivers/net/ethernet/marvell/mvneta.*
>  MARVELL MWIFIEX WIRELESS DRIVER
>  M:	Amitkumar Karwar <amitkarwar@gmail.com>
>  M:	Nishant Sarmukadam <nishants@marvell.com>
> -M:	Ganapathi Bhat <gbhat@marvell.com>
> +M:	Ganapathi Bhat <ganapathi.bhat@nxp.com>
>  M:	Xinming Hu <huxinming820@gmail.com>
>  L:	linux-wireless@vger.kernel.org
>  S:	Maintained
> --
> 1.9.1

