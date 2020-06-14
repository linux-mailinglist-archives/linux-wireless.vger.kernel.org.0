Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502951F87C3
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2020 10:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgFNIyL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Jun 2020 04:54:11 -0400
Received: from qrelay201.mxroute.com ([172.82.139.201]:33527 "EHLO
        qrelay201.mxroute.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgFNIyJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Jun 2020 04:54:09 -0400
Received: from filter003.mxroute.com ([168.235.111.26] 168-235-111-26.cloud.ramnode.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by qrelay201.mxroute.com (ZoneMTA) with ESMTPA id 172b20937af0008e63.001
 for <linux-wireless@vger.kernel.org>;
 Sun, 14 Jun 2020 08:54:08 +0000
X-Zone-Loop: 657f1d6bc3b8eec0fe419c2fa2144863eda338bb1bfc
X-Originating-IP: [168.235.111.26]
Received: from eagle.mxlogin.com (unknown [23.92.74.70])
        by filter003.mxroute.com (Postfix) with ESMTPS id 54A0160029
        for <linux-wireless@vger.kernel.org>; Sun, 14 Jun 2020 08:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=libreelec.tv; s=default; h=Message-Id:In-Reply-To:To:References:Date:
        Subject:Mime-Version:Content-Transfer-Encoding:Content-Type:From:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4CjjZ4pwzmJg9EvkmdxKgbcPT03x8iUQuUf3+x+6Mrk=; b=bV29JBo+ti3YlSuqcyDS9rFz7c
        /moX5Jo/vowb+NhRqYHhcbYcp5sVO6AN+6Q/5xUkaZgceegq5eU3PGMXmxCk4ChuOADCH3vx82Emf
        xmRbquSfJjqRnyxTS+XvGNnbe/429z0ykhMLKuSn5F5NHiace7u9+v2fpZ9YjOK5pW9oBWUB/Bz69
        J++mUwNDwLws5vAd9gjQU+0innATnPfwJRsUB7u0ksrtbHp9hmd3IOmThbp2JhAqkWvshTHB4KbDf
        MAhGPv7gaCB39cVWxtYSWGxWpUZ8njxm5dma8yHVCMR5Fy3yoqMxhzdxCEFR1+wVFhBhnEoqfmNCc
        lAXXRMEA==;
From:   Christian Hewitt <chewitt@libreelec.tv>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: rtw88 SDIO support?
Date:   Sun, 14 Jun 2020 12:54:04 +0400
References: <50223157-F9F8-4039-87E7-A8575DF10945@libreelec.tv>
To:     Linux Wireless <linux-wireless@vger.kernel.org>
In-Reply-To: <50223157-F9F8-4039-87E7-A8575DF10945@libreelec.tv>
Message-Id: <45E86424-06BE-4B6E-B047-245D43D885BA@libreelec.tv>
X-Mailer: Apple Mail (2.3445.104.14)
X-AuthUser: chewitt@libreelec.tv
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Resending due to no responses :(

> On 8 Jun 2020, at 8:42 am, Christian Hewitt <chewitt@libreelec.tv> =
wrote:
>=20
> I=E2=80=99m a maintainer for a distro that runs Kodi mediacentre on =
many popular ARM SBCs and Android STBs (replacing Android).=20
>=20
> I have a number of requests for WiFi support on Amlogic SoC devices =
using RTL8822CS chips which rtw88 supports on PCI, but not SDIO.
>=20
> Can I ask if there is any timeline/plan for SDIO support? .. the =
out-of-tree vendor drivers are hassle for distro=E2=80=99s to maintain.
>=20
> Christian
>=20

