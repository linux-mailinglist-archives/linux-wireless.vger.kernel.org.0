Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA4C41122EB
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2019 07:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfLDGb2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Dec 2019 01:31:28 -0500
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90]:36027 "EHLO
        esa9.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725791AbfLDGb2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Dec 2019 01:31:28 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Dec 2019 01:31:27 EST
IronPort-SDR: bWzsCTHjWh/KIUmJXrBycqTCO5pjlY0zy1db/YnVKp3RosuJbwkZo5eIUm86VmRuwROyuKWXOf
 5oDs0VT1sENDIOmIYfoW/RuxMKt7EGhmRqo+VbuN6H6kDR3MmrM425u8EwciRh6+McJdLnp2ua
 viyDvGLHHEwSVfh+DCD41VFevvbxnaT6ZPLRAKAHqe5ehvFKEeY8+wfSYXWNtdfsqI5faH4K/B
 U4HfMBiqNWcdL3F1KpGzdsw5xlFviLJn+SRWYqrqPhw/yTizTcDpncNu5aPFGTSjT2GSZRn7W9
 r+8=
X-IronPort-AV: E=McAfee;i="6000,8403,9460"; a="8291309"
X-IronPort-AV: E=Sophos;i="5.69,276,1571670000"; 
   d="scan'208";a="8291309"
Received: from mail-ty1jpn01lp2052.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.52])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 15:24:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEnNuHIv9hb0/BWlTDVi35RhSK9CZejnp6emUpVQ7bS70GdWnYHAbW0RyNiDkoCJUyP5cQCc79cRhpJaPyeZeqfF4DjTOjXfTDsE4hpvmiG5xbL1ggMx/Ehr/fKWTHtoCMPxU7mJV/Y+EseEWW2bV1WeDpsj2rV/KEDDXNY7YR6SiZbSVVlfgDXgak1Zm/MSTUfvEQ/Ya5XDR01KYKHJI+y4lIlTqk3bWPHn+0g6sFvu5F004cWWK6SixaHpxrMtli/6rv4l1ClG26SjZO8cuifPcBsZ/bhlJ8SlgkfuSIS2MVDnaMcclrg5/WrTJ8Z5ZqcoXdK/ObrhbFQcElYBGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+eo22v7LYgQ8bEtWCsVxp32ur1I/vsMPv6FDyq1qME=;
 b=T73NSE5Ew45KJGKGUaufCzcHu9OEef5uf8k77viGHW8H5hTiofgll78CglK1I2VDoXq6WwvWGRja1HK5XQj/9x0tPXUAl1xN1U8uoDgk+tGWTM2UX3simoQBGDVqxyiFOEblK1Vy2+cKqrXgRKhSXxFpozk7Txl+eQSUd+sSUYGgHkk6pusp6IlcD/bjj0nbJLUpLs3AoBUbqyNpCDGxh6vYiy34DbUndYYrTZ9Gbl5UE91zF9oAl8dGZM245pRJtmQU7Nbspqil9FL6HeXWcJrv0SA8EF8mIe6Pb+Pgw2YUrHsD1NEj1el77DrgRZjHRBXE9HO9MDZ20Nah1tRPDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+eo22v7LYgQ8bEtWCsVxp32ur1I/vsMPv6FDyq1qME=;
 b=AGmowb5cZGuHXtv/buTOaqJ3Ofn5Lh+VVAaVKZwpzpIq5yY5cZvw1gORb89rFvQG9OzLmvk6Cp3h9UkTozy/FHO+JZTPU+lpidVPhr6D70Ai9Mmf9yB5datg00h8aAX4qFm3blQGIw+/4LSFIQYb0x7WTtFVs9dW2jflZI0Rros=
Received: from OSBPR01MB2168.jpnprd01.prod.outlook.com (52.134.242.11) by
 OSBPR01MB3352.jpnprd01.prod.outlook.com (20.178.99.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Wed, 4 Dec 2019 06:24:15 +0000
Received: from OSBPR01MB2168.jpnprd01.prod.outlook.com
 ([fe80::5410:46d5:c655:2775]) by OSBPR01MB2168.jpnprd01.prod.outlook.com
 ([fe80::5410:46d5:c655:2775%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 06:24:15 +0000
From:   "ambai.masaki@fujitsu.com" <ambai.masaki@fujitsu.com>
To:     "ambai.masaki@fujitsu.com" <ambai.masaki@fujitsu.com>,
        "'linux-wireless@vger.kernel.org'" <linux-wireless@vger.kernel.org>
CC:     "'brcm80211-dev-list.pdl@broadcom.com'" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "'brcm80211-dev-list@cypress.com'" <brcm80211-dev-list@cypress.com>
Subject: RE: Re: What is the license for linux/lib/math/cordic.c?
Thread-Topic: Re: What is the license for linux/lib/math/cordic.c?
Thread-Index: AdWmm5RtoddtbjEIQ/yLayvM+Qn80QAU+8GAAN72sTs=
Date:   Wed, 4 Dec 2019 06:24:15 +0000
Message-ID: <OSBPR01MB2168520C8A25889FEEEF6A0B835D0@OSBPR01MB2168.jpnprd01.prod.outlook.com>
References: <afb1b412-a632-f2dc-0b76-52c345c25491@lwfinger.net>
In-Reply-To: <afb1b412-a632-f2dc-0b76-52c345c25491@lwfinger.net>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckerpolicyversion: FJ-ISEC-20140924-1
x-shieldmailcheckermailid: 20bdf7c09ac144ebb3a3038047a9cbc9
x-securitypolicycheck: OK by SHieldMailChecker v2.3.2
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ambai.masaki@fujitsu.com; 
x-originating-ip: [210.170.118.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e6a016a-6376-4856-072d-08d778829636
x-ms-traffictypediagnostic: OSBPR01MB3352:|OSBPR01MB3352:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB3352B75CF27BFD748C08F8C9835D0@OSBPR01MB3352.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(199004)(189003)(51444003)(7736002)(966005)(81166006)(14454004)(6436002)(6306002)(8676002)(55016002)(478600001)(76116006)(9686003)(71190400001)(71200400001)(33656002)(81156014)(66556008)(66446008)(64756008)(305945005)(66946007)(229853002)(8936002)(66476007)(11346002)(6116002)(25786009)(4326008)(3846002)(256004)(86362001)(6246003)(26005)(14444005)(446003)(7696005)(76176011)(52536014)(53546011)(316002)(102836004)(6506007)(99286004)(110136005)(5660300002)(54906003)(2906002)(85182001)(186003)(74316002)(777600001)(491001);DIR:OUT;SFP:1101;SCL:1;SRVR:OSBPR01MB3352;H:OSBPR01MB2168.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AjQBv8TSkYESgCd3HJoAwBUo3/NFxCBrIc9YG6RHP+XlEMZZbd0dmeQOC/R/3GnW6ij3964CrqCIM1NKbkaLb6tvN/Q2TPul+GOL9tPTYg57b71uGL1tMXAI/LlrRP8qZCl/yfXj080B5Iq+iAxUfNdIAYBEU/+LWM5GdAj2767t6+47LZY0Kv08kTJcd070Q4tkMEewrbrT3SSqCvZXpnatpN80USBEQXGpTivJccrYyoGjFuNaYQnlRr8SEImKdn0rqaGwMmEq29cnKsc1paRGOqPiSPRIzTJyELit7sUY9e/tfbcYkzFCmLOwt2rH0Dr8hkXBur42X9Drs37xV3CIRxPJysJbRbp+7ju65YtfekJ1SZaARm0jWFseEUDzEa/Bxo9qdwgRxC+uip60YAjBis+SpfdhVuh5znh6b2sE5U1XkiyBvlUorqBTmb21P5uKQTbRnlvxYKluJrz0Q1rvhtbRZcgVHKSTjkLGoSY1FkbziQrvQcxvsBAHuvbCWjgRDT8ifuqqdk9r2MWFGDJBNdqyqzo6lRPN53rLquijN6YMDo9kOrmC6RA/irka
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6a016a-6376-4856-072d-08d778829636
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 06:24:15.6299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XO14taAMMc4ZpnggSku3TYaPAE5S5JqXXJ5Sb9KFioamOxY0ofPSXNyyAyqIUV19+zWA1ZqRG+ISwxXG5xATn25TfUGo8pFA7VPIirl9Uao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3352
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> On 11/29/19 4:03 AM, ambai.masaki@fujitsu.com wrote:
> > Hi,
> >
> > What is the license for linux/lib/math/cordic.c?
> >
> >>   * Copyright (c) 2011 Broadcom Corporation
> >>   *
> >>   * Permission to use, copy, modify, and/or distribute this software
> for any
> >>   * purpose with or without fee is hereby granted, provided that the
> above
> >>   * copyright notice and this permission notice appear in all copies.
> >>   *
> >>   * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
> WARRANTIES
> >>   * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
> >>   * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABL=
E
> FOR ANY
> >>   * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
> >>   * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN
> AN ACTION
> >>   * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
> OR IN
> >>   * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> > I think this license is an ISC license.
> >
> >> MODULE_LICENSE("Dual BSD/GPL");
> > However, MODULE _ LICENSE declares a different license.
> > I don't know which license is correct.
> > What licenses are declared in this file?
> >
>=20
> I am a little confused. If the author(s) declare the license to be "Dual
> BSD/GPL", why do you not believe them?
I judged it as an ISC license because the text in the file matched the text=
 in the ISC license.
I am referring to SPDX license list.
https://spdx.org/licenses/ISC.html

I think that the license for this file is "Dual MIT/GPL" if I believe this =
license text.


Regards,
Ambai

