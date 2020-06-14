Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB761F87C4
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2020 10:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgFNIyU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Jun 2020 04:54:20 -0400
Received: from qrelay101.mxroute.com ([172.82.139.101]:39037 "EHLO
        qrelay101.mxroute.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgFNIyT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Jun 2020 04:54:19 -0400
Received: from filter004.mxroute.com ([149.28.56.236] 149.28.56.236.vultr.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by qrelay101.mxroute.com (ZoneMTA) with ESMTPA id 172b20956a30008e63.001
 for <linux-wireless@vger.kernel.org>;
 Sun, 14 Jun 2020 08:54:15 +0000
X-Zone-Loop: 8334986f1075e301f45aff659816e7774b2cc4216381
X-Originating-IP: [149.28.56.236]
Received: from eagle.mxlogin.com (unknown [23.92.74.70])
        by filter004.mxroute.com (Postfix) with ESMTPS id 570BD3EDA0
        for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2020 08:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=libreelec.tv; s=default; h=Message-Id:In-Reply-To:To:References:Date:
        Subject:Mime-Version:Content-Transfer-Encoding:Content-Type:From:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wlkIRpukyhcBu8xqzORiAjT6tXz3NOvcDSKQNsYB9zc=; b=jKyOPsgNhZtCYuEJVKommo7BZ+
        t7LxE1tT1Arx/eQJCxKkorMnYZ18WNp6ZTjYQyxNUm6rzLfFinciVko+0J3sZnqKnGkEvf9wC+f0z
        dx4B2WOBxfbQ1ZsiFtHVQ9J6spR9GdjtM2Dljg0EkqhX8tOeVfP/rA+G5q1nMnTu3e1UT5GT2/Osj
        wNtpQjbu6LmSOOAo4KyGRYh0cdxnKUmO42U2lYJfekTfCFR4NJxySVMxVBXqNY/n+9jCc5SZsw1Ed
        9S19/gG4WQSyiBPyivGJbivGl6oi43q2QrXn29FDfzKkke+WRNOKOLrSqzdUYg3KX+3HP1ShUv+x/
        sAlShLuA==;
From:   Christian Hewitt <chewitt@libreelec.tv>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: mt76 support for MT7668 SDIO?
Date:   Sun, 14 Jun 2020 12:54:13 +0400
References: <3BFCA289-ADD8-4755-80C5-1889A9AFB41D@libreelec.tv>
To:     Linux Wireless <linux-wireless@vger.kernel.org>
In-Reply-To: <3BFCA289-ADD8-4755-80C5-1889A9AFB41D@libreelec.tv>
Message-Id: <B5F852AD-4717-4237-90C8-81D313FD43D3@libreelec.tv>
X-Mailer: Apple Mail (2.3445.104.14)
X-AuthUser: chewitt@libreelec.tv
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Resending due to no responses :(

> On 8 Jun 2020, at 8:45 am, Christian Hewitt <chewitt@libreelec.tv> =
wrote:
>=20
> I=E2=80=99m a maintainer for a distro that runs Kodi mediacentre on =
many popular ARM SBCs and Android STBs (replacing Android).=20
>=20
> Similar to my request on RTL8822CS, I have a number of requests for =
WiFi support on Amlogic SoC devices using MT7668 chips. The BT side of =
the module is supported in mainline for sometime, but there is no =
mention of WiFi.
>=20
> Is there any plan or timeline for MT7668 SDIO support in mt76? .. =
I=E2=80=99m struggling to even find vendor drivers for this chip.
>=20
> Christian
>=20

