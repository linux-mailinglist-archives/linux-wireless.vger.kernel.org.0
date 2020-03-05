Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91565179E74
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2020 05:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgCEEAr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Mar 2020 23:00:47 -0500
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:32993
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725861AbgCEEAr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Mar 2020 23:00:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLoeN+VZteZfNaEHCCUshV4qwZWXJWUIcOMcEY/oxxpVyVY/ipv5LxN2rCgIL+AhkiZrmaEGkRUY9y0wKtYux/AAbK7de5qdsDAesxvmT4bfHgaZVwmPVsyqEDFqVVQ+W5hxZUwRcRoM0cV6ZSmlS/TLBphzoCZzS9mo4DdD4RVrHvnjsxkl0Nd//9iaIG1JbIWC68/6Slcpu27EK8C52kqUTL9fmEfg1jIEXbeW3x0iDlx8yNEA2PWnCfJoJau8brxLOo5da7OxcKi0Pe/tVKY/9a2MAiHNNxoqHyr/KTbH95KogE97+yJIElLCTe7wKGRD/JzQIE2GyVMl3DB9SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQUGsxgKNOvtd+TTjLBPopO1eqpmapYRk+tsspgpm/Y=;
 b=RQlR8jue6Gbql3ZdVmHIYkPBqQZsIgGkerxfz7JsugNvY2Oe1zgPOMd/kxoZTDOxcJygBUe9ySlIr2z8l5/9PlwC5E2xXNtvoaPCsuS8eCh9j5Dl8Q9LLMIs5SXiXaFkplPYB0cz0DCvU1M2pWC9nj5WIemsNO7HboPdM8WasnZENlyKpHF0iksRlm76K1FIHgsZJyw9T72lSG6uK7N43CMQ/Y+ZfbXg2mGfIPrqJXOaxnGp4WVqdNcwUGkYzFVguqXpGbl3qndE8SeTXGzUmuZl75MmY9piVT1UMuX0FN32mroOZ2kL2LHoW5M6YeaC+vAJnNuVh0hkMTUbLy91tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQUGsxgKNOvtd+TTjLBPopO1eqpmapYRk+tsspgpm/Y=;
 b=Z0xxfUaaBNUfAWNLGeiNmwykSqZ8vVg7J8vbRXlmgiPB8rXIH10Vgb1ecaaFvVRuFqrcg8FvhXSJ3DitW0FV57MpDLqKQPzZMqIYkqfuzwOjenU9hv3bFr2Z68U4FcuOmbi3S5bKdHXfZHzclW5mFr9hGsHAaDBH/z1tXVZySIw=
Received: from DB7PR04MB5242.eurprd04.prod.outlook.com (20.176.234.25) by
 DB7PR04MB3977.eurprd04.prod.outlook.com (52.135.129.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.19; Thu, 5 Mar 2020 04:00:42 +0000
Received: from DB7PR04MB5242.eurprd04.prod.outlook.com
 ([fe80::d55c:9106:6fb2:cc34]) by DB7PR04MB5242.eurprd04.prod.outlook.com
 ([fe80::d55c:9106:6fb2:cc34%4]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 04:00:42 +0000
From:   Ganapathi Bhat <ganapathi.bhat@nxp.com>
To:     Brian Norris <briannorris@chromium.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Arend Van Spriel <arend@broadcom.com>
Subject: RE: [EXT] [PATCH] mwifiex: set needed_headroom, not hard_header_len
Thread-Topic: [EXT] [PATCH] mwifiex: set needed_headroom, not hard_header_len
Thread-Index: AQHV7QGefb0w+LZbCU2BNI3eE64ugag5ZweQ
Date:   Thu, 5 Mar 2020 04:00:42 +0000
Message-ID: <DB7PR04MB524240B38FF6603D89D694538FE20@DB7PR04MB5242.eurprd04.prod.outlook.com>
References: <20200227000511.256055-1-briannorris@chromium.org>
In-Reply-To: <20200227000511.256055-1-briannorris@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ganapathi.bhat@nxp.com; 
x-originating-ip: [115.112.95.158]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18e32537-b7ae-4ca3-e870-08d7c0b9c640
x-ms-traffictypediagnostic: DB7PR04MB3977:
x-microsoft-antispam-prvs: <DB7PR04MB3977D3E57E5020D46B152F698FE20@DB7PR04MB3977.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(189003)(199004)(7696005)(54906003)(110136005)(66446008)(64756008)(66946007)(5660300002)(66556008)(81166006)(44832011)(8936002)(6506007)(9686003)(52536014)(4326008)(316002)(81156014)(478600001)(186003)(26005)(8676002)(66476007)(55016002)(71200400001)(76116006)(2906002)(33656002)(86362001)(55236004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB3977;H:DB7PR04MB5242.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K1JcY9oRHzzJdAAroY+Pr8EujgussB+fb388ZYLWYyA1z0aUXCAcnGr8YyZjQ0iO8Ej5EW4uu7ytj4CDbv/682jfy+tOlBzV6zCzvCivet390ncilAIGC3iAG04rcaG2zpQdsuxcEFgQ/hwMJjb5OXcI5dvVwxnyatXGP6bmNBEyXPecffqvpT1gBwlRmfXX0e51JHaklhpi4e4y3z18NsPB9CEop8ftvJbwBZINS4FthsI76HrUZWuG/P8clZaYQKtpG/5AlkhoGcmBQTMBXfWnQGIdI3XAkE7JfQJS3voAmhnt837A6Mp9jJjNsRedYsWcpiPLck6psTzFphEbg2tQDyzpbeE3FLf/hSxFa9AUBU90VetELnXTzIiJGCdjGSnilTvB9TTdZylzjdkZrpEClYKPc4as0Y1GZYKPQcFKaAfQPFOf2iCD2lIJN5jJ
x-ms-exchange-antispam-messagedata: XZSs09H/p7Vq62fiHWdJ8BD0MaLcq15Jx1LuV/FvNbxrexfGlO9EYpCkAoO4xyLLuo+KTHNAiJiTwz/3FNWgOXHdTyyzoopnGz4dMs0oHUJo8kvlll19PwahmPB/VshvinLKTB8oqG4OZVm8Fv7NdQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e32537-b7ae-4ca3-e870-08d7c0b9c640
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 04:00:42.2160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9rNofqnpgZASrhbFcTWgBuoIcyt1IqD6dB6nNLxuWxNMQybkJUAxQLKLQYZE30IBb8kE4Ddher+Q20PpTrcdyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB3977
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Brian,
=20
> hard_header_len provides limitations for things like AF_PACKET, such that
> we don't allow transmitting packets smaller than this.


OK; However, are we not supposed to mention hard_header_len also?

>=20
> needed_headroom provides a suggested minimum headroom for SKBs, so
> that we can trivally add our headers to the front.
>=20
> The latter is the correct field to use in this case, while the former mos=
tly just
> prevents sending small AF_PACKET frames.
>=20
> In any case, mwifiex already does its own bounce buffering [1] if we don'=
t
> have enough headroom, so hints (not hard limits) are all that are needed.
>=20
> This is the essentially the same bug (and fix) that brcmfmac had, fixed i=
n
> commit cb39288fd6bb ("brcmfmac: use ndev->needed_headroom to reserve
> additional header space").

OK; I read this commit:

"... According to definition of LL_RESERVED_SPACE() and hard_header_len, we=
 should use hard_header_len to reserve for L2 header, like ethernet header(=
ETH_HLEN) in our case and use needed_headroom for the additional headroom n=
eeded by hardware..."

So, does it mean, hard_header_len is already considered by upper layer?


Regards,
Ganapathi
