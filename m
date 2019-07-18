Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 084BC6D073
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2019 16:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfGROwK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jul 2019 10:52:10 -0400
Received: from mail-eopbgr10119.outbound.protection.outlook.com ([40.107.1.119]:7910
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727685AbfGROwK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jul 2019 10:52:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJrwLfsVcRAfmVXjjpJOGqZ9y1wAN/tHL+8CleeGmLU0mHDSVJkXclF62b3VYEdBskrnJ10q+LFdwg7DOmRxjuOdz+G+8nc8kfZM646UM+cRf7KAlZrDsjuc8VoMXteeSfYo4Iu7VRJ9Vhr3WzjE/BOSBIwZ82xg5MlDMUyzTY3HQvvjluSyyriyMeiHjqMY2qDVDCtEQJ6IVYkyJmc8SjRnwD/dUwLfAQRY+6hYniNPGEBd0SK9abX+wF1X24erYIPObO7eS8MrhyUOFxd8t31XT21JqQUsIZVmBENTqF+BDU5Jdrngv3eBREIkCjuBZoUe/SGEFZRRfHh/QrU82Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEWtPjLhE8LNN1qeXjBBu22jgH7LLkx8BLaXSXUtlag=;
 b=iBILpC3J8O2iJLzKwJv2MS+kSEyI5WQL+bV9TBwrsbHlzZxvrPCqKkkIPfPkMT5QfF5PRZxWomzudYYfxRXbvRpej0I2YBX2ktyerExJge5I0qPAHl8BLoarFnvDCLuJ6MXPqbkINqP970FyrXBXzBY742MXDApBlh3HmkS25ZcMy+KttCCVPsLqbHsSsvPVPrdaS8avAgpPiFrL7Pz18jcDrVwPlES26cgzwJmgZUfiyLCQ722wmgn8l+yfCjceOUr4v3EFCbaDIEtyqH8Lf3QMCiveCDbqNSLJ46Hs1Oo7jO3m5uZLYoUb7lIeWt5/DtsP4OfGRnNKDM4tbUPqDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=acksys.fr;dmarc=pass action=none
 header.from=acksys.fr;dkim=pass header.d=acksys.fr;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ACKSYS.onmicrosoft.com; s=selector1-ACKSYS-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEWtPjLhE8LNN1qeXjBBu22jgH7LLkx8BLaXSXUtlag=;
 b=cbcHqyfmm/4jOUjQjwGQtDCxKxpZIVZVO2brPjz0Eqp26Tm6cKAyZgWoVxQygfFIkHYncupa5p4nKBolAYpxP9UBiQhcy7KJmeMlOJMlEEha8G9xmIYEwY1BwjMkHWNKKw0vW8tASXWxLSfZ1xIGwKM4xPphqyKWSNU0BBT63Ps=
Received: from AM4PR0101MB2305.eurprd01.prod.exchangelabs.com (10.165.38.134)
 by AM4PR0101MB2209.eurprd01.prod.exchangelabs.com (10.165.23.26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.14; Thu, 18 Jul
 2019 14:52:06 +0000
Received: from AM4PR0101MB2305.eurprd01.prod.exchangelabs.com
 ([fe80::11b6:e76d:fd99:56a3]) by
 AM4PR0101MB2305.eurprd01.prod.exchangelabs.com
 ([fe80::11b6:e76d:fd99:56a3%6]) with mapi id 15.20.2073.012; Thu, 18 Jul 2019
 14:52:06 +0000
From:   Jean-Pierre TOSONI <jp.tosoni@acksys.fr>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: mac80211+ath9k AP fails to honour power save mode from client
Thread-Topic: mac80211+ath9k AP fails to honour power save mode from client
Thread-Index: AdU9eFbLkuMG7XNGT3uLWVmdQrilwg==
Date:   Thu, 18 Jul 2019 14:52:05 +0000
Message-ID: <AM4PR0101MB23055B57EF8BEBA8D478554CE4C80@AM4PR0101MB2305.eurprd01.prod.exchangelabs.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jp.tosoni@acksys.fr; 
x-originating-ip: [62.193.53.221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad5c0a0d-3e72-4d6f-9170-08d70b8f8090
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM4PR0101MB2209;
x-ms-traffictypediagnostic: AM4PR0101MB2209:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM4PR0101MB2209D931EEEFB716CFDB0261E4C80@AM4PR0101MB2209.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39840400004)(396003)(136003)(366004)(376002)(199004)(189003)(316002)(6116002)(3846002)(102836004)(26005)(256004)(186003)(66946007)(14454004)(2501003)(5660300002)(53936002)(64756008)(2351001)(486006)(66476007)(71190400001)(33656002)(2906002)(66556008)(6916009)(76116006)(14444005)(508600001)(66446008)(66066001)(74316002)(9686003)(55016002)(6306002)(6436002)(68736007)(5640700003)(476003)(71200400001)(99286004)(81156014)(305945005)(25786009)(6506007)(7696005)(966005)(7736002)(86362001)(81166006)(52536014)(8676002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0101MB2209;H:AM4PR0101MB2305.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: acksys.fr does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zqVHoSLE8pDGpmKIudSW8idKY+fYNeEEHaIDWjs/Q4tpXUo0mrRXTcLNis+EfTRuZgCWAMSLDoRQSSm0gElvb++bE/aaCeuiEvY0gNQDfT1va0nJ6qHWkYD2ICgpyfyAA63otw2hOXVmY6VY/G1EafrQ24tXMT/5LybDmkJ4bGSAt1NJKkhhZZ0LqtAx5X2r8jl0KKw910lciACz/i0pDAimiehvPArlM84Ld/36IkU4PY8JDnQX5O9n7OKc1507FwEamTb2RIRKQuvrXP+wtspNk/1fYBpceVKN48BXy3WuuOeI2roKiFqHb7g5N81jd0JjF1NQeg1ZGMQhxmvNev7TDCuYBe43IIY/lRAfdChFzRi5XSolhx4+4rmfV7NtL3lBhEvWDMAb6ay5Zfg5NbRJ8wirvReA+EuRLG79NwE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: acksys.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5c0a0d-3e72-4d6f-9170-08d70b8f8090
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 14:52:05.9882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f18a6414-d5f3-4b5c-9345-f30c01d87e32
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jp.tosoni@acksys.fr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0101MB2209
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello list,

Context:

 I am using one device in AP mode, the other in client mode.
 The client uses wpa_supplicant to do *background scan to other channels th=
at the data channel*.
 I am running iperf (UDP) *from the AP* to the client.

 My device is Cavium development board-based (Octeon III CPU), equipped wit=
h Compex WLE350NX.
 It used to work correctly with kernel 3.18 and an old 2015 wireless backpo=
rt.
 Now I updated to kernel 4.9 and the wireless backport 4.19.32-1, the last =
one from the OpenWRT trunk. (previously I used backport-2017-11-01 with the=
 same failure).

 I am running wireshark with Airpcap to spy the wireless link.

Problem:

 When the client scans offchannel, it correctly sends nullfunc frames aroun=
d the offchannel period, with the PM bit set then unset.

 However, during this time, the AP continues to send data to the client.
  =20
 This results in a lot of lost frames, though I set the powersave buffers t=
o high values on the AP side.


After some research I saw that the same kind of problem was fixed [1] and e=
ven re-fixed, but since there where so many changes in the queue management=
, I cannot really compare his work and the current state of the driver.

Any idea / patch / directions of research ?

J.P. Tosoni - ACKSYS

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D5519541d5a5f19893546883547e2f0f2e5934df7=20
